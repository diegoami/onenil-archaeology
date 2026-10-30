#!/usr/bin/env python3
"""T17: literal DBC6 decision/helper observations, with 69B8 kept external.

--run resumes at the next unrecorded week; --check needs only git fixtures.
No engine formula is evaluated here. Address arithmetic only locates guest fields.
"""
import argparse
import hashlib
import json
import platform

import contests
import match
import placement
import step_tail

ROOT = contests.ROOT
RUNS, FIXTURES = ROOT / 'runs/T17', ROOT / 'traces/T17'
SITES = {'0AB9:DBD1', '0AB9:DC38', '0AB9:DC98', '0AB9:DCBF', '0AB9:DCD4'}
HELPERS = {'0AB9:DC17': ('availability', None), '0AB9:DC2C': ('availability', None),
           '0AB9:DC71': ('rating', 14), '0AB9:DC7D': ('rating', 6),
           '0AB9:DC8D': ('predicate', 4), '0AB9:DCB7': ('threshold', None),
           '0AB9:DCCC': ('threshold', None)}
P8 = (0, 1, 3, 4, 5, 7)
P15 = (6, 8, 10, 11)
SCENE = {'word0': (0, 2), 'slot': (7, 1), 'player': (14, 2),
         'rating_bonus': (18, 1), 'half': (22, 1)}


def seed(g):
    return g.word_at(g.far(0xDE84))


def player(g, identifier):
    p8, p15 = g.far(0xD7BA) + 8 * identifier, g.far(0xD7BE) + 15 * identifier
    row = {'id': identifier}
    row.update({f'p8_{i}': g.mem(p8 + i, 1)[0] for i in P8})
    row.update({f'p15_{i}': g.mem(p15 + i, 1)[0] for i in P15})
    row['skills'] = []
    for mode in (6, 14):
        cell = g.rd((0x957D + 22 * row['p8_7'] + mode) & 65535, 1)
        row['skills'].append({'mode': mode, 'style_cell': cell,
                              'level_cell': g.rd((0x96B1 + 22 * row['p8_5'] + cell) & 65535, 1)})
    return row


def state(g):
    scenes = []
    for index in range(1, 23):
        base = g.DS * 16 + 0xCCEF + 25 * index
        scenes.append({'index': index, **{k: int.from_bytes(g.mem(base + off, n), 'little')
                                         for k, (off, n) in SCENE.items()}})
    return {'seed': seed(g), 'actor': g.rd(0xD09F, 1), 'secondary': g.rd(0xD0A0, 1),
            'd6dd': g.rd(0xD6DD, 1), 'home_bonus': g.rd(0x0D29, 1),
            'side_offsets': [g.rd(0x0D56 + i, 1) for i in range(2)],
            'opponents': [g.rd(0x0D00 + i, 1) for i in range(1, 11)],
            'clubs': [{'id': g.rd(off), 'byte57': g.mem(g.far(0xD7C2) + (g.rd(off) - 1) * 62 + 57, 1)[0]}
                      for off in (0xD6E4, 0xD6E6)],
            'side_flags': [g.rd(0xD1CE + i, 1) for i in range(2)],
            'skill_bonus_flags': [{'mode': i, 'value': g.rd(0x09FB + i, 1)} for i in (6, 14)],
            'scenes': scenes, 'players': [player(g, i) for i in sorted({s['player'] for s in scenes})]}


class Recorder:
    def __init__(self, week):
        self.week, self.pending, self.helper = week, None, None
        self.calls = []
        self.tail = step_tail.Recorder(week)
        hooks = {'0AB9:DBC6': self.enter, '0AB9:DCFE': self.leave,
                 '0AB9:DCFB': self.dispatch, '0AB9:1AFA': self.rating_stack}
        for addr in ('0AB9:1CA1', '0AB9:1AE2', '0AB9:1A4C', '1B55:4E0C'):
            hooks[addr] = self.helper_enter
        for addr in ('0AB9:1CB7', '0AB9:1BD2', '0AB9:1ADE', '1B55:4E7D'):
            hooks[addr] = self.helper_leave
        for addr, fn in hooks.items():
            week.g.code_hook(addr, fn)

    def enter(self, g):
        if not self.tail.active:
            return
        if self.pending is not None or self.helper is not None or g.reg('ds') != g.DS:
            raise ValueError('unexpected DBC6 nesting/data segment')
        self.pending = {'step': len(self.tail.calls) - 1, 'input': state(g),
                        'draw_start': self.week.draws, 'helpers': [], 'dispatch': None}

    def helper_enter(self, g):
        if self.pending is None or self.pending['dispatch'] is not None:
            return
        caller = g.image_address(g.stack_word(2), g.stack_word(0))
        if caller not in HELPERS:
            return
        if self.helper is not None:
            raise ValueError('nested direct DBC6 helper')
        kind, mode = HELPERS[caller]
        inp = {'player': g.stack_word(4)} if kind == 'threshold' else {
            'scene': (g.stack_word(4) - 0xCCEF) // 25,
            'offset': g.stack_word(4), 'segment': g.stack_word(6)}
        if mode is not None:
            inp['mode'] = g.stack_word(8)
        self.helper = {'caller': caller, 'kind': kind, 'input': inp,
                       'draw_start': self.week.draws}

    def rating_stack(self, g):
        if self.helper is not None and self.helper['kind'] == 'rating':
            self.helper['stack_word_before'] = g.word_at(g.reg('ss') * 16 + ((g.reg('bp') - 4) & 65535))

    def helper_leave(self, g):
        if self.helper is not None:
            self.helper.update(result=g.reg('ax') if self.helper['kind'] == 'rating' else g.reg('ax') & 255,
                               draw_end=self.week.draws)
            self.pending['helpers'].append(self.helper)
            self.helper = None

    def dispatch(self, g):
        if self.pending is not None:
            if self.helper is not None or self.pending['dispatch'] is not None:
                raise ValueError('incomplete helper or repeated dispatch')
            self.pending['dispatch'] = {'routine': '0AB9:69B8', 'input': state(g),
                                        'draw_start': self.week.draws}

    def leave(self, g):
        if self.pending is not None:
            if self.helper is not None:
                raise ValueError('incomplete DBC6 helper')
            self.pending.update(output=state(g), draw_end=self.week.draws)
            self.calls.append(self.pending)
            self.pending = None


def integer(v, lo=0, hi=65535):
    if not placement.integer(v, lo, hi):
        raise ValueError('missing/mistyped/out-of-range raw integer')


def vector(v, n, hi=255):
    if not isinstance(v, list) or len(v) != n:
        raise ValueError('incomplete ordered vector')
    for i in v:
        integer(i, 0, hi)


def keys(v, names):
    if not isinstance(v, dict) or set(v) != set(names.split()):
        raise ValueError('missing or unknown raw fields')


def validate_state(v):
    keys(v, 'seed actor secondary d6dd home_bonus side_offsets opponents clubs side_flags skill_bonus_flags scenes players')
    integer(v['seed'])
    for k in ('actor', 'secondary', 'd6dd', 'home_bonus'):
        integer(v[k], 0, 255)
    vector(v['side_offsets'], 2); vector(v['opponents'], 10); vector(v['side_flags'], 2)
    if len(v['clubs']) != 2:
        raise ValueError('missing club inputs')
    for c in v['clubs']:
        keys(c, 'id byte57'); integer(c['id'], 1, 176); integer(c['byte57'], 0, 255)
    if [r['mode'] for r in v['skill_bonus_flags']] != [6, 14]:
        raise ValueError('incomplete skill bonus selectors')
    for r in v['skill_bonus_flags']:
        keys(r, 'mode value'); integer(r['mode']); integer(r['value'], 0, 255)
    if [s['index'] for s in v['scenes']] != list(range(1, 23)):
        raise ValueError('missing/reordered scenes')
    for s in v['scenes']:
        keys(s, 'index ' + ' '.join(SCENE)); integer(s['index'], 1, 22)
        for k, (_, n) in SCENE.items():
            integer(s[k], 0, 65535 if n == 2 else 255)
        integer(s['player'], 0, 3920)
    if [p['id'] for p in v['players']] != sorted({s['player'] for s in v['scenes']}):
        raise ValueError('missing or aliased player definitions')
    for p in v['players']:
        keys(p, 'id skills ' + ' '.join(f'p8_{i}' for i in P8) + ' ' + ' '.join(f'p15_{i}' for i in P15))
        integer(p['id'], 0, 3920)
        for k, val in p.items():
            if k not in ('id', 'skills'): integer(val, 0, 255)
        if [s['mode'] for s in p['skills']] != [6, 14]:
            raise ValueError('missing raw skill lookup cells')
        for s in p['skills']:
            keys(s, 'mode style_cell level_cell')
            for value in s.values(): integer(value, 0, 255)


def validate_call(c):
    step_tail.numeric(c)
    keys(c, 'step input output draw_start draw_end helpers dispatch')
    integer(c['step'], 0, 557)
    validate_state(c['input']); validate_state(c['output'])
    integer(c['draw_start'], 0, 2**32); integer(c['draw_end'], c['draw_start'], 2**32)
    helpers = c['helpers']
    # DBC6 is a straight short-circuit decision: helpers can only be prefixes
    # of these direct caller sites; later helpers are optional as a pair.
    sites = [h['caller'] for h in helpers]
    order = list(HELPERS)
    if sites not in [order[:i] for i in (1, 2, 4, 5, 7)]:
        raise ValueError('missing/reordered direct helper coverage')
    for h in helpers:
        kind, mode = HELPERS[h['caller']]
        keys(h, 'caller kind input draw_start draw_end result' + (' stack_word_before' if kind == 'rating' else ''))
        if h['kind'] != kind: raise ValueError('wrong helper kind')
        inp = h['input']
        keys(inp, 'player' if kind == 'threshold' else 'scene offset segment' + (' mode' if mode is not None else ''))
        if kind == 'threshold': integer(inp['player'], 0, 3920)
        else:
            integer(inp['scene'], 1, 22); integer(inp['offset']); integer(inp['segment'])
            if inp['offset'] != 0xCCEF + 25 * inp['scene']:
                raise ValueError('helper scene pointer differs')
            if mode is not None and inp['mode'] != mode:
                raise ValueError('helper mode differs')
        integer(h['result'], 0, 65535 if kind == 'rating' else 255)
        if kind == 'rating': integer(h['stack_word_before'])
        integer(h['draw_start'], c['draw_start'], c['draw_end'])
        if h['draw_start'] != h['draw_end']: raise ValueError('unexpected helper RNG')
    d = c['dispatch']
    if d is not None:
        keys(d, 'routine input draw_start')
        if d['routine'] != '0AB9:69B8' or len(helpers) != 7:
            raise ValueError('unexpected event dispatch')
        validate_state(d['input']); integer(d['draw_start'], c['draw_start'], c['draw_end'])


def tail_source(source):
    index = json.loads((ROOT / 'traces/T16/index.json').read_text())
    for m in index['records']:
        rec = json.loads((ROOT / m['record']).read_text())
        if placement.same_json(rec['actions']['source'], source):
            fixture = ROOT / 'traces/T16' / m['cases']
            if contests.sha(ROOT / m['record']) != m['record_sha256'] or contests.sha(fixture) != m['cases_sha256']:
                raise ValueError('T16 record/fixture digest differs')
            return m, rec, contests.events(fixture)
    raise ValueError('missing exact retained T16 source')


def cases_for(calls, source, trace, reference=None):
    try:
        return _cases_for(calls, source, trace, reference or source)
    except (KeyError, IndexError, TypeError, AttributeError, StopIteration) as e:
        raise ValueError(f'incomplete DBC6/source observation: {e}') from e


def _cases_for(calls, source, trace, reference):
    m, rec, tails = tail_source(source)
    if trace[0]['state_sha256'] != reference['start_state_sha256'] or trace[-1]['status'] != 'completed':
        raise ValueError('trace state/status differs')
    requested = [i for i, t in enumerate(tails) if any(r['routine'] == '0AB9:DBC6' for r in t['prefix']['pending_calls'])]
    if [c['step'] for c in calls] != requested:
        raise ValueError('DBC6 calls do not cover all T16 requests')
    draws, result, owned = contests.draw_stream(trace), [], []
    for c in calls:
        validate_call(c)
        t = tails[c['step']]['prefix']; inp = c['input']
        if (c['draw_start'] != t['draw_end'] or inp['seed'] != t['output']['seed']
                or inp['actor'] != t['output']['actor'] or inp['d6dd'] != t['input']['d6dd']
                or [x['id'] for x in inp['clubs']] != list(reversed(t['input']['clubs']))
                or [{k: s[k] for k in ('index', 'player', 'word0')} for s in inp['scenes']] != t['output']['scenes']
                or [{'id': p['id'], 'byte8': p['p15_8'], 'byte11': p['p15_11']} for p in inp['players']] != t['output']['players']):
            raise ValueError('DBC6 does not continue actual T16 prefix')
        begin, end = c['draw_start'], c['draw_end']
        if not begin < end <= len(draws): raise ValueError('invalid DBC6 draw span')
        selected = draws[begin:end]
        if [d['i'] for d in selected] != list(range(begin, end)) or inp['seed'] != selected[0]['seed_before'] or c['output']['seed'] != selected[-1]['seed_after']:
            raise ValueError('DBC6 draw span/seed differs')
        dispatch = c['dispatch']
        split = dispatch['draw_start'] if dispatch else end
        decision = draws[begin:split]
        for d in decision:
            if len(SITES.intersection(d['callers'])) != 1:
                raise ValueError('unattributed DBC6 decision draw')
        sites = [next(iter(SITES.intersection(d['callers']))) for d in decision]
        allowed = {1: [['0AB9:DBD1']], 2: [['0AB9:DBD1']],
                   4: [['0AB9:DBD1', '0AB9:DC38']],
                   5: [['0AB9:DBD1', '0AB9:DC38', '0AB9:DC98']],
                   7: [['0AB9:DBD1', '0AB9:DC38', '0AB9:DCBF', '0AB9:DCD4'],
                       ['0AB9:DBD1', '0AB9:DC38', '0AB9:DC98', '0AB9:DCBF', '0AB9:DCD4']]}
        if sites not in allowed[len(c['helpers'])]:
            raise ValueError('helper coverage differs from literal decision draw sites')
        # These comparisons check boundaries and pointers, not helper formulas.
        for h in c['helpers']:
            if h['kind'] == 'threshold':
                mode = 14 if h['caller'] == '0AB9:DCB7' else 6
                rating = next(r for r in c['helpers'] if r['kind'] == 'rating' and r['input']['mode'] == mode)
                if h['input']['player'] != inp['scenes'][rating['input']['scene'] - 1]['player']:
                    raise ValueError('threshold argument differs from observed rating scene')
            elif h['kind'] == 'predicate':
                rating = next(r for r in c['helpers'] if r['caller'] == '0AB9:DC7D')
                if any(h['input'][k] != rating['input'][k] for k in ('scene', 'offset', 'segment')):
                    raise ValueError('predicate scene differs from selected rating scene')
            before = '0AB9:DCBF' if h['caller'] == '0AB9:DCCC' else '0AB9:DC38' if h['kind'] in ('rating', 'predicate') else '0AB9:DBD1' if h['kind'] == 'availability' else None
            if before is not None:
                position = next(d['i'] + 1 for d in decision if before in d['callers'])
                if h['draw_start'] != position:
                    raise ValueError('helper draw boundary differs from literal trace')
        target = dispatch['input'] if dispatch else c['output']
        excluded = ('seed', 'actor', 'secondary') if dispatch else ('seed',)
        if not placement.same_json({k: v for k, v in inp.items() if k not in excluded},
                                   {k: v for k, v in target.items() if k not in excluded}):
            raise ValueError('decision changed fields outside seed/dispatch actors')
        if dispatch and dispatch['input']['seed'] != draws[split - 1]['seed_after']:
            raise ValueError('event handoff seed differs')
        for h in c['helpers']:
            if h['draw_start'] > split: raise ValueError('helper crosses event boundary')
        owned.extend(d['i'] for d in decision)
        result.append({'schema': 'extra-event-case/1', 'week': source['t04_record'], **c,
                       'draws': selected, 'source': {'t16_record': m['record'], 't16_record_sha256': m['record_sha256'],
                       't16_cases': m['cases'], 't16_cases_sha256': m['cases_sha256'],
                       't08_trace': source['trace'], 't08_trace_sha256': source['trace_sha256']}})
    managed = next(e['draws'] for e in trace if e['kind'] == 'mark' and e['what'].startswith('match return'))
    expected = [d['i'] for d in draws[:managed] if SITES.intersection(d['callers'])]
    if owned != expected: raise ValueError('DBC6 decision draws missing or duplicated')
    return result


def selected_runs():
    result = {}
    for p in sorted(RUNS.glob('T17-r*.json')):
        rec = json.loads(p.read_text())
        if rec['status'] == 'completed':
            key = rec['actions']['stream_key']
            if key in result: raise ValueError('duplicate completed DBC6 week')
            result[key] = (p, rec)
    return result


def build_index():
    _, groups = contests.read_corpus()
    chosen, records, coverage = selected_runs(), [], []
    if set(chosen) != set(groups): raise ValueError('missing/extra completed DBC6 week')
    for key, members in groups.items():
        path, rec = chosen[key]
        source = rec['actions']['source']
        reference = next(trace for e, trace in members if placement.same_json(e, source))
        if rec['start_state']['sha256'] != source['start_state_sha256']:
            raise ValueError('DBC6 record state differs')
        _, old, _ = tail_source(source)
        if rec['actions']['game_files'] != old['actions']['game_files']:
            raise ValueError('DBC6 game-file identities differ')
        cases = cases_for(contests.outputs(rec)['calls'], source, reference)
        obs = {o['field']: o['value'] for o in rec['observations']}
        fixture = ROOT / obs['fixture path']
        if fixture.parent != FIXTURES or contests.sha(fixture) != obs['fixture sha256'] or not placement.same_json(contests.events(fixture), cases):
            raise ValueError('DBC6 exported fixture differs')
        records.append({'record': match.rel(path), 'record_sha256': contests.sha(path),
                        'cases': fixture.name, 'cases_sha256': contests.sha(fixture),
                        'week': source['t04_record'], 'calls': len(cases),
                        'decision_draws': sum((c['dispatch']['draw_start'] if c['dispatch'] else c['draw_end']) - c['draw_start'] for c in cases),
                        'event_draws': sum(c['draw_end'] - c['dispatch']['draw_start'] for c in cases if c['dispatch']),
                        'dispatches': sum(c['dispatch'] is not None for c in cases),
                        'helpers': sum(len(c['helpers']) for c in cases), 'producer_commit': rec['code_commit']})
        for entry, trace in members:
            cases_for(contests.outputs(rec)['calls'], source, trace, entry)
            coverage.append({'trace': entry['trace'], 'trace_sha256': entry['trace_sha256'], 'cases': fixture.name})
    return {'schema': 'extra-event-corpus/1', 'records': records, 'coverage': coverage,
            **{k: sum(r[k] for r in records) for k in ('calls', 'decision_draws', 'event_draws', 'dispatches', 'helpers')},
            'weeks': len(records), 'traces': len(coverage), 't16_index_sha256': contests.sha(ROOT / 'traces/T16/index.json')}


def run():
    import cycle
    import guest
    import unicorn
    if match.git('status', '--porcelain', '--', 'runtime/emul'):
        raise SystemExit('commit runtime/emul before recording')
    commit = match.git('rev-parse', 'HEAD')
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
            if week.g.unsupported or recorder.pending is not None or recorder.helper is not None:
                raise ValueError('unsupported service or incomplete DBC6 call')
            if week.events != reference[1:-1]: raise ValueError('new week differs from T08 events')
            ok, lines = match.compare(week.events, source['start_state_sha256'], ROOT / source['t04_record_path'])
            if not ok: raise ValueError('ordered DOSBox-X comparison failed')
            _, old, _ = tail_source(source)
            if not placement.same_json(recorder.tail.calls, contests.outputs(old)['calls']):
                raise ValueError('new full T16 projection differs')
            cases = cases_for(recorder.calls, source, reference)
        except (Exception, KeyboardInterrupt) as e:
            status = f'aborted: {type(e).__name__}: {e}'
        n = max(match.next_number(RUNS, 'T17-r*.json'), match.next_number(FIXTURES, 'T17-r*.jsonl'))
        rid = f'T17-r{n:04d}'; fixture = FIXTURES / (rid + '.jsonl')
        placement.write_lines(fixture, cases)
        rec = {'schema': 'run/1', 'run_id': rid, 'experiment': 'T17', 'arm': 'dbc6-contract', 'rep': n,
               'code_commit': commit, 'machine': cycle.machine_id(),
               'artifact': {'set': 'One-Nil96 (records/T01/inventory.json)', 'variant': None},
               'runtime': {'harness': f'runtime/emul/extra_event.py@{commit}', 'unicorn': unicorn.__version__,
                           'python': platform.python_version(), 'dos_clock': week.g.clock,
                           'settings': {k: getattr(guest, k) for k in ('INSTR_PER_S', 'KEY_HOLD', 'PIT_HZ', 'SLICE_MAX')}},
               'interventions': [{'level': 'I3', 'what': 'guest.py services and read-only DBC6/helper/dispatch hooks'}],
               'start_state': {'id': match.rel(path), 'sha256': source['start_state_sha256'], 'restore': 'DOSBox-X state restored by guest.py'},
               'seed': None, 'actions': {'script': 'runtime/emul/extra_event.py', 'source': source, 'stream_key': key,
                   'game_files': {name: hashlib.sha256(raw).hexdigest() for name, raw in week.files_at_start.items()}},
               'observations': [{'step': 0, 'source': 'file', 'field': 'fixture path', 'value': match.rel(fixture)},
                                {'step': 0, 'source': 'file', 'field': 'fixture sha256', 'value': contests.sha(fixture)},
                                {'step': 1, 'source': 'log', 'field': 'ordered DOSBox-X comparison', 'value': '\n'.join(lines)}],
               'outputs': [{'name': 'calls', 'value': recorder.calls}], 'started': started, 'ended': match.utc(), 'status': status}
        match.write_record(RUNS / (rid + '.json'), rec)
        print(f'{rid}: {status}; {len(recorder.calls)} DBC6 calls, {len(cases)} cases', flush=True)
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
        if (index['weeks'], index['traces']) != (6, 15): raise ValueError('six weeks and 15 references required')
        if not placement.same_json(index, json.loads((FIXTURES / 'index.json').read_text())):
            raise ValueError('DBC6 corpus index differs')
    except (ValueError, OSError, KeyError, StopIteration, TypeError) as e:
        print(f'extra-event check: FAIL: {e}'); return 1
    print(f'extra-event check: ok ({index["calls"]} calls, {index["decision_draws"]} decision draws, {index["dispatches"]} dispatches)')
    return 0


if __name__ == '__main__':
    raise SystemExit(main())
