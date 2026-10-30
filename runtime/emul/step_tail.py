#!/usr/bin/env python3
"""T16: observe the deterministic DD02 prefix and separate logical caller clock.

Only literal guest observations and retained-source projections are checked here.
The native consumer computes effects; this module contains no engine formula.
"""
import argparse
import hashlib
import json
import platform
from pathlib import Path

import contests
import match
import placement
import quick_step

ROOT = contests.ROOT
RUNS, FIXTURES = ROOT / 'runs/T16', ROOT / 'traces/T16'


def next_row(i):
    return 1 if i == 1700 else i + 1


def row_indices(head):
    return [head, next_row(head), next_row(next_row(head))]


def queue_row(g, i):
    p = g.DS * 16 + 0xA52A + 6 * i
    return {'index': i, 'code': g.mem(p, 1)[0], 'first_player': g.word_at(p + 1),
            'second_player': g.word_at(p + 3), 'side': g.mem(p + 5, 1)[0]}


def clock_state(g, indices=None):
    head = g.rd(0x0380)
    indices = row_indices(head) if indices is None else indices
    return {'clock': quick_step.clock(g), 'reload': g.rd(0x0D28, 1), 'cf51': g.rd(0xCF51),
            'seed': g.word_at(g.far(0xDE84)),
            'commentary': {'event_word': g.rd(0xD16E), 'counts': [g.rd(0xD1C0 + 2 * i) for i in range(2)],
                           'weights': [g.rd(0x097A + c, 1) for c in (63, 64)],
                           'queue': {'head': head, 'rows': [queue_row(g, i) for i in indices]},
                           'source_pair': [g.rd(0xD08A), g.rd(0xD08C)],
                           'target_pair': [g.rd(0xD09A), g.rd(0xD09C)]}}


def prefix_records(g, ids=None):
    scenes = []
    for i in range(1, 23):
        p = g.DS * 16 + 0xCCEF + 25 * i
        scenes.append({'index': i, 'player': g.word_at(p + 14), 'word0': g.word_at(p)})
    ids = sorted({s['player'] for s in scenes}) if ids is None else ids
    players = []
    for i in ids:
        p = g.far(0xD7BE) + 15 * i
        players.append({'id': i, 'byte8': g.mem(p + 8, 1)[0], 'byte11': g.mem(p + 11, 1)[0]})
    return {'scenes': scenes, 'players': players}


def visit_state(g, index):
    p = g.DS * 16 + 0xCCEF + 25 * index
    identifier = g.word_at(p + 14)
    q = g.far(0xD7BE) + 15 * identifier
    return {'word0': g.word_at(p), 'byte8': g.mem(q + 8, 1)[0], 'byte11': g.mem(q + 11, 1)[0]}


class Recorder:
    def __init__(self, week):
        self.week, self.active = week, False
        self.legacy = quick_step.Recorder(week)
        self.calls, self.pending, self.clock_call = [], None, None
        hooks = {match.MATCH: lambda g: setattr(self, 'active', True),
                 match.MATCH_RETURN: lambda g: setattr(self, 'active', False),
                 '0AB9:DF35': self.enter, '0AB9:DF65': self.history_enter,
                 '0AB9:DF6A': self.history_leave, '0AB9:DF9D': self.scene_enter,
                 '0AB9:DFD5': self.scene_leave, '0AB9:DFDB': self.leave,
                 '0AB9:DFE9': lambda g: self.request(g, '0AB9:DBC6'),
                 '0AB9:DFF2': lambda g: self.request(g, '0AB9:6B2F'),
                 '0AB9:DFFB': lambda g: self.request(g, '1998:045C', [g.stack_word(0), g.stack_word(2)]),
                 '0AB9:E000': lambda g: self.request(g, '0AB9:52B6'),
                 '0AB9:E003': lambda g: self.request(g, '0AB9:78B7'),
                 '0AB9:7B7B': self.clock_enter, '0AB9:7C92': self.clock_leave,
                 '0AB9:0F94': self.event_enter, '0AB9:0FAD': self.event_accepted}
        for address, callback in hooks.items():
            week.g.code_hook(address, callback)

    def enter(self, g):
        if not self.active:
            return
        if self.pending is not None or g.reg('ds') != g.DS:
            raise ValueError('unexpected prefix nesting/data segment')
        inp = {'placement': {'seed': g.word_at(g.far(0xDE84)),
                             'generated': [g.rd(0xD086, 1), g.rd(0xD087, 1)],
                             'scores': [placement.frame_byte(g, -2), placement.frame_byte(g, -1)],
                             'goal_flag': placement.frame_byte(g, -0x26), 'actor': g.rd(0xD09F, 1)},
               'mode': g.rd(0xD074, 1), 'd6dd': g.rd(0xD6DD, 1),
               'remaining': g.rd(0xD0AE), 'replacement_word': g.rd(0x0D32),
               'clubs': [g.rd(0xD6E6), g.rd(0xD6E4)],
               'history': {'base_offset': g.rd(0xD7CE), 'base_segment': g.rd(0xD7D0),
                           'selector': g.mem(g.far(0xD7D2), 1)[0]}, **prefix_records(g)}
        self.pending = {'input': inp, 'visits': [], 'pending_calls': [], 'draw_start': self.week.draws}
        self.calls.append({'prefix': self.pending})

    def history_enter(self, g):
        if self.pending is not None:
            self.history_address = g.reg('es') * 16 + g.reg('di')
            self.pending['input']['history']['value'] = g.mem(self.history_address, 1)[0]
            self.pending['history_observation'] = {'offset': g.reg('di'), 'segment': g.reg('es'),
                                                   'score_word': g.stack_word(4)}

    def history_leave(self, g):
        if self.pending is not None:
            self.pending['history_observation']['after'] = g.mem(self.history_address, 1)[0]

    def scene_enter(self, g):
        if self.pending is not None:
            i = self.legacy.local(g, -0x1E)
            p = g.DS * 16 + 0xCCEF + 25 * i
            self.pending['visits'].append({'index': i, 'player': g.word_at(p + 14),
                                          'unavailable': g.reg('ax') & 255, 'before': visit_state(g, i)})

    def scene_leave(self, g):
        if self.pending is not None:
            self.pending['visits'][-1]['after'] = visit_state(g, self.legacy.local(g, -0x1E))

    def leave(self, g):
        if self.pending is not None:
            h = self.pending['history_observation']
            self.pending['output'] = {'seed': g.word_at(g.far(0xDE84)), 'actor': g.rd(0xD09F, 1),
                                      'goal_bytes': [g.rd(0xD086, 1), g.rd(0xD087, 1)],
                                      'score_bytes': [g.rd(0xD0C4, 1), g.rd(0xD0C5, 1)],
                                      'history_byte': g.mem(self.history_address, 1)[0],
                                      'history_offset': h['offset'], 'history_segment': h['segment'],
                                      **prefix_records(g, [p['id'] for p in self.pending['input']['players']])}
            self.pending['draw_end'] = self.week.draws
            self.pending = None

    def request(self, g, routine, args=None):
        if self.active and self.calls and 'clock' not in self.calls[-1]:
            self.calls[-1]['prefix']['pending_calls'].append({'routine': routine, 'args': args or []})

    def clock_enter(self, g):
        if self.active and self.calls and 'clock' not in self.calls[-1]:
            if self.pending is not None or self.clock_call is not None:
                raise ValueError('clock overlaps prefix/another clock')
            self.clock_call = {'input': clock_state(g), 'event': None, 'draw_start': self.week.draws}
            self.calls[-1]['clock'] = self.clock_call

    def event_enter(self, g):
        if self.clock_call is not None:
            if self.clock_call['event'] is not None:
                raise ValueError('multiple clock numeric events')
            self.clock_call['event'] = {'code': g.stack_word(2) & 255, 'secondary_slot': g.stack_word(4),
                                        'actor_slot': g.stack_word(6), 'event_side': g.stack_word(8) & 255}

    def event_accepted(self, g):
        if self.clock_call is not None and self.clock_call['event'] is not None:
            self.clock_call['event']['accepted'] = g.reg('ax') & 255

    def clock_leave(self, g):
        if self.clock_call is not None:
            indices = [r['index'] for r in self.clock_call['input']['commentary']['queue']['rows']]
            self.clock_call.update(output=clock_state(g, indices), result=g.reg('ax') & 255,
                                   draw_end=self.week.draws)
            self.clock_call = None


def numeric(value):
    if type(value) in (float, bool):
        raise ValueError('raw numeric observations require exact integers')
    if isinstance(value, dict):
        for item in value.values(): numeric(item)
    elif isinstance(value, list):
        for item in value: numeric(item)


def ints(value, low, high, size):
    return isinstance(value, list) and len(value) == size and all(placement.integer(v, low, high) for v in value)


def fields(value, names, low, high):
    if set(value) != set(names) or any(not placement.integer(value[k], low, high) for k in names):
        raise ValueError('incomplete or mistyped numeric fields')


def validate_records(value):
    scenes, players = value['scenes'], value['players']
    if not isinstance(scenes, list) or len(scenes) != 22 or [s['index'] for s in scenes] != list(range(1, 23)):
        raise ValueError('complete ordered scene records required')
    for s in scenes:
        fields(s, ('index', 'player', 'word0'), 0, 65535)
        if s['player'] > 3920: raise ValueError('scene player outside pool')
    if not isinstance(players, list) or [p['id'] for p in players] != sorted({s['player'] for s in scenes}):
        raise ValueError('missing/duplicate/noncanonical shared player definitions')
    for p in players:
        fields(p, ('id', 'byte8', 'byte11'), 0, 65535)
        if p['id'] > 3920 or p['byte8'] > 255 or p['byte11'] > 255:
            raise ValueError('player fields outside byte/pool bounds')


def validate_prefix(p):
    numeric(p)
    inp, out = p['input'], p['output']
    f = inp['placement']
    if (not placement.integer(f['seed'], 0, 65535) or not ints(f['generated'], 0, 11, 2)
            or not ints(f['scores'], 0, 255, 2) or not placement.integer(f['goal_flag'], 0, 1)
            or not placement.integer(f['actor'], 0, 255) or not placement.integer(inp['mode'], 1, 255)
            or not placement.integer(inp['d6dd'], 0, 255) or not ints(inp['clubs'], 1, 176, 2)
            or not placement.integer(inp['remaining'], 0, 65535)
            or not placement.integer(inp['replacement_word'], 0, 65535)):
        raise ValueError('invalid raw prefix fields')
    h = inp['history']
    fields(h, ('base_offset', 'base_segment', 'selector', 'value'), 0, 65535)
    if h['selector'] > 255 or h['value'] > 255: raise ValueError('history raw bytes out of range')
    validate_records(inp); validate_records(out)
    if (out['seed'] != f['seed'] or out['actor'] != f['actor']
            or not ints(out['goal_bytes'], 0, 255, 2) or not ints(out['score_bytes'], 0, 255, 2)
            or not placement.integer(out['history_byte'], 0, 255)
            or not placement.integer(out['history_offset'], 0, 65535)
            or not placement.integer(out['history_segment'], 0, 65535)
            or not placement.integer(p['draw_start'], 0, 2**32) or p['draw_start'] != p['draw_end']):
        raise ValueError('invalid prefix output or unexpected RNG change')
    if [s['player'] for s in inp['scenes']] != [s['player'] for s in out['scenes']]:
        raise ValueError('prefix changed scene player IDs')
    visits = p['visits']
    if [v['index'] for v in visits] != list(range(1, 23)):
        raise ValueError('missing/reordered scene visits')
    current = {p['id']: dict(p) for p in inp['players']}
    final_scenes = []
    for s, v in zip(inp['scenes'], visits):
        if v['player'] != s['player'] or not placement.integer(v['unavailable'], 0, 1):
            raise ValueError('visit player/availability differs')
        before = {'word0': s['word0'], **{k: current[s['player']][k] for k in ('byte8', 'byte11')}}
        if not placement.same_json(v['before'], before): raise ValueError('shared-player visit input differs')
        for k in ('before', 'after'):
            fields(v[k], ('word0', 'byte8', 'byte11'), 0, 65535)
            if v[k]['byte8'] > 255 or v[k]['byte11'] > 255: raise ValueError('invalid visit raw byte')
        if v['after']['byte11'] != before['byte11']: raise ValueError('visit changed status flags')
        current[s['player']].update(byte8=v['after']['byte8'])
        final_scenes.append({**s, 'word0': v['after']['word0']})
    if (not placement.same_json(final_scenes, out['scenes'])
            or not placement.same_json([current[i] for i in sorted(current)], out['players'])):
        raise ValueError('output differs from literal sequential visits')
    obs = p['history_observation']
    fields(obs, ('offset', 'segment', 'score_word', 'after'), 0, 65535)
    if (obs['after'] != out['history_byte'] or obs['offset'] != out['history_offset']
            or obs['segment'] != out['history_segment']):
        raise ValueError('history output differs from original helper observation')
    if any(set(c) != {'routine', 'args'} or not isinstance(c['routine'], str)
           or not isinstance(c['args'], list) or not all(placement.integer(x, 0, 65535) for x in c['args'])
           for c in p['pending_calls']):
        raise ValueError('invalid pending dependency request')


def validate_clock_state(s, indices=None):
    fields(s['clock'], quick_step.CLOCK, 0, 65535)
    if any(s['clock'][k] > 255 for k in ('kind', 'active', 'zero')):
        raise ValueError('clock byte outside range')
    if (not placement.integer(s['reload'], 0, 255) or not placement.integer(s['cf51'], 0, 65535)
            or not placement.integer(s['seed'], 0, 65535)):
        raise ValueError('clock raw fields outside range')
    c = s['commentary']
    if (not placement.integer(c['event_word'], 0, 65535) or not ints(c['counts'], 0, 65535, 2)
            or not ints(c['weights'], 0, 255, 2) or not ints(c['source_pair'], 0, 65535, 2)
            or not ints(c['target_pair'], 0, 65535, 2)):
        raise ValueError('numeric clock commentary incomplete')
    q = c['queue']; head = q['head']
    if not placement.integer(head, 0, 1700): raise ValueError('invalid queue head')
    indices = row_indices(head) if indices is None else indices
    if len(q['rows']) != 3 or [r['index'] for r in q['rows']] != indices:
        raise ValueError('entry-selected queue rows missing/reordered')
    for r in q['rows']:
        fields(r, ('index', 'code', 'first_player', 'second_player', 'side'), 0, 65535)
        if r['index'] > 1700 or r['code'] > 255 or r['side'] > 255:
            raise ValueError('queue row field outside range')


def validate_clock(c):
    numeric(c)
    validate_clock_state(c['input'])
    validate_clock_state(c['output'], [r['index'] for r in c['input']['commentary']['queue']['rows']])
    if (not placement.integer(c['result'], 0, 1) or not placement.integer(c['draw_start'], 0, 2**32)
            or c['draw_start'] != c['draw_end'] or c['input']['seed'] != c['output']['seed']):
        raise ValueError('invalid clock result or unexpected RNG change')
    if (c['input']['reload'] != c['output']['reload']
            or c['input']['commentary']['weights'] != c['output']['commentary']['weights']
            or c['input']['commentary']['source_pair'] != c['output']['commentary']['source_pair']):
        raise ValueError('clock changed static fields')
    event = c['event']
    if event is not None:
        if (set(event) != {'code', 'actor_slot', 'secondary_slot', 'event_side', 'accepted'}
                or event['code'] not in (63, 64) or event['actor_slot'] != 0 or event['secondary_slot'] != 0
                or event['event_side'] != 1 or not placement.integer(event['accepted'], 0, 1)
                or c['result'] != 1):
            raise ValueError('invalid actor-zero clock termination event')
    elif c['result']:
        raise ValueError('missing terminating numeric event')


def sources(source):
    meta12 = next(r for r in json.loads((ROOT / 'traces/T12/index.json').read_text())['records']
                  if r['week'] == source['t04_record'])
    meta13 = next(r for r in json.loads((ROOT / 'traces/T13/index.json').read_text())['records']
                  if r['week'] == source['t04_record'])
    def read(meta, directory):
        record, fixture = ROOT / meta['record'], ROOT / directory / meta['cases']
        if contests.sha(record) != meta['record_sha256'] or contests.sha(fixture) != meta['cases_sha256']:
            raise ValueError('retained source digest differs')
        rec = json.loads(record.read_text())
        if rec['status'] != 'completed' or rec['start_state']['sha256'] != source['start_state_sha256']:
            raise ValueError('retained source state/status differs')
        return rec, contests.events(fixture)
    r12, c12 = read(meta12, 'traces/T12'); r13, c13 = read(meta13, 'traces/T13')
    return meta12, r12, c12, meta13, r13, c13


def legacy_visit(v):
    def view(p):
        return {'word0': p['scene_word0'], 'byte8': p['p15_sbyte8'] & 255, 'byte11': p['p15_byte11']}
    return {'index': v['before']['scene_slot'], 'player': v['before']['player'],
            'unavailable': v['unavailable'], 'before': view(v['before']), 'after': view(v['after'])}


def expected_requests(phases):
    # Literal normalization of observed call boundaries, not dispatch simulation.
    result = []
    for p in phases:
        if p['routine'] == 'goal reset: 1998:045C,0AB9:52B6':
            result.extend([{'routine': '1998:045C', 'args': [1, 0]}, {'routine': '0AB9:52B6', 'args': []}])
        else:
            result.append({'routine': p['routine'], 'args': []})
    return result


def cases_for(calls, source, trace, reference=None):
    try:
        return _cases_for(calls, source, trace, reference)
    except (KeyError, IndexError, TypeError, AttributeError, StopIteration) as e:
        raise ValueError(f'incomplete/malformed tail/clock observation: {e}') from e


def _cases_for(calls, source, trace, reference=None):
    m12, r12, c12, m13, r13, c13 = sources(source)
    reference = reference or source
    if (trace[0]['state_sha256'] != reference['start_state_sha256'] or trace[-1].get('status') != 'completed'
            or len(calls) != len(c12) or len(calls) != len(c13)):
        raise ValueError('incomplete prefix/clock/source coverage')
    old_steps = contests.outputs(r12)['steps']
    quick_step.cases_for(old_steps, quick_step.t11_calls(source), trace, reference,
                         contests.outputs(r12).get('outside_step_draws'))
    provenance = {'t12_record': m12['record'], 't12_record_sha256': m12['record_sha256'],
                  't12_cases': m12['cases'], 't12_cases_sha256': m12['cases_sha256'],
                  't13_record': m13['record'], 't13_record_sha256': m13['record_sha256'],
                  't13_cases': m13['cases'], 't13_cases_sha256': m13['cases_sha256'],
                  't08_trace': source['trace'], 't08_trace_sha256': source['trace_sha256']}
    result = []
    for i, (call, old, pc) in enumerate(zip(calls, old_steps, c13)):
        p, c = call['prefix'], call['clock']
        validate_prefix(p); validate_clock(c)
        inp, out, po = p['input'], p['output'], old['placement_output']
        wanted = {'seed': po['seed'], 'generated': po['generated'], 'scores': po['saved_scores'],
                  'goal_flag': po['goal_flag'], 'actor': pc['output']['actor']}
        if (not placement.same_json(inp['placement'], wanted) or p['draw_start'] != po['draws']
                or not placement.same_json(inp['placement'], {k: pc['output'][k] for k in wanted})
                or inp['remaining'] != po['clock']['remaining'] or inp['clubs'] != old['input']['clubs']
                or inp['mode'] != old['input']['flags']['DS:D074']
                or inp['d6dd'] != old['input']['flags']['DS:D6DD']):
            raise ValueError('prefix raw placement/flag boundary differs from T12/T13')
        if (not placement.same_json(p['visits'], [legacy_visit(v) for v in old['scene_visits']])
                or not placement.same_json(p['pending_calls'], expected_requests(old['phases']))
                or out['goal_bytes'] != old['output']['goal_bytes']
                or out['score_bytes'] != list(reversed(old['output']['score_side']))
                or inp['history']['value'] != old['history_write']['before']
                or out['history_byte'] != old['history_write']['after']
                or p['history_observation']['score_word'] != old['history_write']['score_word']):
            raise ValueError('prefix visits/history/pending boundaries differ from retained T12')
        if (not placement.same_json(c['input']['clock'], old['clock_before'])
                or not placement.same_json(c['output']['clock'], old['clock_after'])
                or c['result'] != old['clock_result']):
            raise ValueError('caller clock differs from retained T12')
        if c['draw_start'] != old['draw_end'] or c['input']['seed'] != old['output']['seed']:
            raise ValueError('clock boundary crosses unrecorded draws')
        result.append({'schema': 'step-tail-case/1', 'week': source['t04_record'], 'step': i,
                       **call, 'placement': pc, 'source': provenance})
    return result


def selected_runs():
    selected = {}
    for p in sorted(RUNS.glob('T16-r*.json')):
        rec = json.loads(p.read_text()); selected[rec['actions']['stream_key']] = (p, rec)
    return {k: v for k, v in selected.items() if v[1]['status'] == 'completed'}


def build_index():
    _, groups = contests.read_corpus()
    chosen, records, coverage = selected_runs(), [], []
    for key, members in groups.items():
        if key not in chosen: raise ValueError('missing completed tail/clock week')
        path, record = chosen[key]
        source = record['actions']['source']
        trace = next((t for e, t in members if placement.same_json(e, source)), None)
        if trace is None or record['start_state']['sha256'] != source['start_state_sha256']:
            raise ValueError('tail source/start-state identity differs')
        cases = cases_for(contests.outputs(record)['calls'], source, trace)
        obs = {o['field']: o['value'] for o in record['observations']}
        fixture = ROOT / obs['fixture path']
        if contests.sha(fixture) != obs['fixture sha256'] or not placement.same_json(contests.events(fixture), cases):
            raise ValueError('tail/clock fixture differs from original observations')
        records.append({'record': match.rel(path), 'record_sha256': contests.sha(path), 'cases': fixture.name,
                        'cases_sha256': contests.sha(fixture), 'week': source['t04_record'], 'calls': len(cases),
                        'visits': sum(len(c['prefix']['visits']) for c in cases),
                        'events': sum(c['clock']['event'] is not None for c in cases),
                        'producer_commit': record['code_commit']})
        for entry, repeated in members:
            cases_for(contests.outputs(record)['calls'], source, repeated, entry)
            coverage.append({'t04_record': entry['t04_record'], 'trace': entry['trace'],
                             'trace_sha256': entry['trace_sha256'], 'cases': fixture.name})
    return {'schema': 'step-tail-corpus/1', 'records': records, 'coverage': coverage,
            'calls': sum(r['calls'] for r in records), 'clock_calls': sum(r['calls'] for r in records),
            'scene_visits': sum(r['visits'] for r in records), 'clock_events': sum(r['events'] for r in records),
            'weeks': len(records), 'traces': len(coverage),
            't12_index_sha256': contests.sha(ROOT / 'traces/T12/index.json'),
            't13_index_sha256': contests.sha(ROOT / 'traces/T13/index.json')}


def run():
    import cycle
    import guest
    import unicorn
    if match.git('status', '--porcelain', '--', 'runtime/emul'):
        raise SystemExit('commit runtime/emul before recording')
    commit = match.git('rev-parse', '--short', 'HEAD')
    _, groups = contests.read_corpus()
    RUNS.mkdir(parents=True, exist_ok=True); FIXTURES.mkdir(parents=True, exist_ok=True)
    have = selected_runs()
    for key, members in groups.items():
        if key in have:
            print(f'already recorded {have[key][1]["run_id"]}', flush=True); continue
        source, reference = members[-1]
        started = match.utc(); path, data = match.find_state(source['start_state_sha256'])
        week, status, lines, cases = match.Week(data), 'completed', [], []
        recorder = Recorder(week)
        try:
            week.play()
            if (week.g.unsupported or recorder.pending is not None or recorder.clock_call is not None
                    or recorder.legacy.pending is not None or recorder.legacy.clock_step is not None):
                raise ValueError('unsupported service or incomplete tail/clock boundary')
            if week.events != reference[1:-1]: raise ValueError('new week differs from T08 events')
            ok, lines = match.compare(week.events, source['start_state_sha256'], ROOT / source['t04_record_path'])
            if not ok: raise ValueError('ordered DOSBox-X comparison failed')
            _, old12, _, _, _, _ = sources(source)
            if not placement.same_json(recorder.legacy.steps, contests.outputs(old12)['steps']):
                raise ValueError('new complete T12 projection differs')
            cases = cases_for(recorder.calls, source, reference)
        except (Exception, KeyboardInterrupt) as e:
            status = f'aborted: {type(e).__name__}: {e}'
        n = max(match.next_number(RUNS, 'T16-r*.json'), match.next_number(FIXTURES, 'T16-r*.jsonl'))
        rid = f'T16-r{n:04d}'; fixture = FIXTURES / (rid + '.jsonl')
        placement.write_lines(fixture, cases)
        record = {'schema': 'run/1', 'run_id': rid, 'experiment': 'T16', 'arm': 'step-tail-clock', 'rep': n,
                  'code_commit': commit, 'machine': cycle.machine_id(),
                  'artifact': {'set': 'One-Nil96 (records/T01/inventory.json)', 'variant': None},
                  'runtime': {'harness': f'runtime/emul/step_tail.py@{commit}', 'unicorn': unicorn.__version__,
                              'python': platform.python_version(), 'dos_clock': week.g.clock,
                              'settings': {k: getattr(guest, k) for k in ('INSTR_PER_S', 'KEY_HOLD', 'PIT_HZ', 'SLICE_MAX')}},
                  'interventions': [{'level': 'I3', 'what': 'guest.py services and read-only prefix/clock/helper hooks'}],
                  'start_state': {'id': match.rel(path), 'sha256': source['start_state_sha256'],
                                  'restore': 'DOSBox-X savestate restored by guest.py'}, 'seed': None,
                  'actions': {'script': 'runtime/emul/step_tail.py', 'source': source, 'stream_key': key,
                              'game_files': {name: hashlib.sha256(raw).hexdigest() for name, raw in week.files_at_start.items()}},
                  'observations': [{'step': 0, 'source': 'file', 'field': 'fixture path', 'value': match.rel(fixture)},
                                   {'step': 0, 'source': 'file', 'field': 'fixture sha256', 'value': contests.sha(fixture)},
                                   {'step': 1, 'source': 'log', 'field': 'ordered DOSBox-X comparison', 'value': '\n'.join(lines)}],
                  'outputs': [{'name': 'calls', 'value': recorder.calls}],
                  'started': started, 'ended': match.utc(), 'status': status}
        match.write_record(RUNS / (rid + '.json'), record)
        print(f'{rid}: {status}; {len(recorder.calls)} prefix/clock pairs, {len(cases)} cases', flush=True)
        if status != 'completed': raise SystemExit(1)
    (FIXTURES / 'index.json').write_text(json.dumps(build_index(), indent=2) + '\n')


def main(argv=None):
    ap = argparse.ArgumentParser(description=__doc__)
    mode = ap.add_mutually_exclusive_group(required=True)
    mode.add_argument('--run', action='store_true'); mode.add_argument('--check', action='store_true')
    args = ap.parse_args(argv)
    if args.run: run(); return 0
    try:
        index = build_index()
        if (index['calls'], index['clock_calls'], index['scene_visits'], index['clock_events'], index['weeks'], index['traces']) != (558, 558, 12276, 12, 6, 15):
            raise ValueError('expected 558 prefixes/clocks, 12276 visits, 12 events, six weeks and 15 references')
        if not placement.same_json(index, json.loads((FIXTURES / 'index.json').read_text())):
            raise ValueError('tail/clock index differs')
    except (ValueError, OSError, KeyError, StopIteration, TypeError) as e:
        print(f'step-tail check: FAIL: {e}'); return 1
    print('step-tail check: ok (558 prefixes, 558 clocks, 12276 visits, 12 events, six weeks, 15 references)')
    return 0


if __name__ == '__main__':
    raise SystemExit(main())
