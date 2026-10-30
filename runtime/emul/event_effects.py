#!/usr/bin/env python3
"""T19: observe logical 69B8 effects; no Python effects model."""
import argparse
import copy
import hashlib
import json
import platform

import contests
import extra_event as decision
import extra_event_inputs as supplement
import match
import placement
import step_tail

ROOT = contests.ROOT
RUNS, FIXTURES = ROOT / 'runs/T19', ROOT / 'traces/T19'
P8 = (0, 1, 3, 4, 5, 6, 7)
P15 = (6, 8, 10, 11, 14)


def snapshot(g, context=None):
    head = g.rd(0xD072)
    queue = g.rd(0x0380)
    if context is None:
        selectors = [head, 1 if head == 255 else head + 1]
        rows = [queue]
        for _ in range(3): rows.append(step_tail.next_row(rows[-1]))
    else:
        selectors = [c['index'] for c in context['selectors']['cells']]
        rows = [r['index'] for r in context['queue']['rows']]
    handoff = decision.state(g)
    rosters = [{'club': c['id'], 'players': [g.word_at(g.far(0xD7C2) + (c['id'] - 1) * 62 + 2 * i) for i in range(20)]}
               for c in handoff['clubs']]
    ids = sorted({p for r in rosters for p in r['players']} | {s['player'] for s in handoff['scenes']})
    if context is not None: ids = [p['id'] for p in context['players']]
    players = []
    for i in ids:
        p8, p15 = g.far(0xD7BA) + 8 * i, g.far(0xD7BE) + 15 * i
        players.append({'id': i, **{f'p8_{f}': g.mem(p8 + f, 1)[0] for f in P8},
                        **{f'p15_{f}': g.mem(p15 + f, 1)[0] for f in P15}})
    return {'handoff': handoff, 'players': players, 'rosters': rosters,
            'selectors': {'head': head, 'cells': [{'index': i, 'value': g.rd(0xCF71 + i, 1)} for i in selectors]},
            'managed_clubs': [g.rd(0xDCBA + i, 1) for i in range(2)],
            'mode': g.rd(0xD074, 1), 'pending': g.rd(0xD6E2, 1), 'cf53': g.rd(0xCF53, 1),
            'sub_flags': [g.rd(0xD6DE + i, 1) for i in range(2)],
            'reserves': [g.rd(0xD6E0 + i, 1) for i in range(2)],
            'added': g.rd(0xD0B4), 'active': g.rd(0xD0B8, 1), 'control': g.rd(0xD0BA, 1),
            'clear_word': g.rd(0x0D2E), 'target_word': g.rd(0x0D30),
            'scene_extra': [{'index': i, 'word8': g.rd(0xCCEF + 25 * i + 8),
                             'motion': g.rd(0xCCEF + 25 * i + 19, 1),
                             'motion_word': g.rd(0xCCEF + 25 * i + 20)} for i in range(1, 23)],
            'counters': [[g.rd(0xD0D9 + 10 * side + i, 1) for i in range(3)] for side in range(2)],
            'cache': [[g.rd(0xD198 + 20 * side + i, 1) for i in range(20)] for side in range(2)],
            'event_totals': [[g.rd(0xD148 + 40 * side + 2 * i) for i in range(20)] for side in range(2)],
            'weights': [{'code': i, 'value': g.rd(0x097A + i, 1)} for i in (50, 51, 52)],
            'event_counts': [g.rd(0xD1C0 + 2 * side) for side in range(2)],
            'queue': {'head': queue, 'rows': [step_tail.queue_row(g, i) for i in rows]},
            'source_pair': [g.rd(0xD08A), g.rd(0xD08C)], 'target_pair': [g.rd(0xD09A), g.rd(0xD09C)]}


class Recorder:
    def __init__(self, week):
        self.week, self.calls, self.pending = week, [], None
        self.legacy = decision.Recorder(week)
        self.selector = self.action = self.helper = self.event = self.threshold = None
        hooks = {'0AB9:69B8': self.enter, '0AB9:6A78': self.leave,
                 '0AB9:19A0': self.selector_enter, '0AB9:19C8': self.selector_leave,
                 '0AB9:1CA1': self.availability_enter, '0AB9:1CB7': self.availability_leave,
                 '0AB9:67D0': self.byte6_enter, '0AB9:6845': self.byte6_leave,
                 '0AB9:0F94': self.event_enter, '0AB9:0FAD': self.event_leave,
                 '1B55:4E0C': self.threshold_enter, '1B55:4E7D': self.threshold_leave}
        for routine, end in [('63E3', '6485'), ('6589', '67CC'), ('6849', '6931')]:
            hooks['0AB9:' + routine] = lambda g, r=routine: self.action_enter(g, r)
            hooks['0AB9:' + end] = self.action_leave
        for routine in ('A837', 'A94B'):
            hooks['0AB9:' + routine] = lambda g, r=routine: self.external(g, r)
        for address, callback in hooks.items(): week.g.code_hook(address, callback)

    def enter(self, g):
        if not self.legacy.tail.active or g.stack_word(0) != 0xDCFE: return
        if self.pending is not None or g.reg('ds') != g.DS: raise ValueError('unexpected effect nesting/DS')
        self.pending = {'step': len(self.legacy.tail.calls) - 1, 'input': snapshot(g),
                        'draw_start': self.week.draws, 'selectors': [], 'actions': [],
                        'helpers': [], 'events': [], 'external_calls': []}

    def selector_enter(self, g):
        if self.pending is not None:
            if self.selector is not None: raise ValueError('nested selector')
            self.selector = {'site': g.image_address(g.reg('cs'), g.stack_word(0)), 'head_before': g.rd(0xD072)}

    def selector_leave(self, g):
        if self.selector is not None:
            self.selector.update(head_after=g.rd(0xD072), value=g.reg('ax'))
            self.pending['selectors'].append(self.selector); self.selector = None

    def action_enter(self, g, routine):
        if self.pending is not None:
            if self.action is not None: raise ValueError('nested action')
            self.action = {'routine': '0AB9:' + routine, 'scene': (g.stack_word(4) - 0xCCEF) // 25,
                           'input': snapshot(g, self.pending['input'])}

    def action_leave(self, g):
        if self.action is not None:
            self.action['output'] = snapshot(g, self.pending['input'])
            self.pending['actions'].append(self.action); self.action = None

    def availability_enter(self, g):
        if self.pending is not None:
            if self.helper is not None: raise ValueError('nested observed helper')
            index = (g.stack_word(4) - 0xCCEF) // 25
            identifier = g.word_at(g.DS * 16 + 0xCCEF + 25 * index + 14)
            base = g.far(0xD7BE) + 15 * identifier
            self.helper = {'kind': 'availability', 'scene': index, 'player': identifier,
                           'byte8': g.mem(base + 8, 1)[0], 'flags11': g.mem(base + 11, 1)[0]}

    def availability_leave(self, g):
        if self.helper is not None and self.helper['kind'] == 'availability':
            self.helper['result'] = g.reg('ax') & 255
            self.pending['helpers'].append(self.helper); self.helper = None

    def byte6_enter(self, g):
        if self.pending is not None:
            if self.helper is not None: raise ValueError('nested observed helper')
            index = (g.stack_word(4) - 0xCCEF) // 25
            base = g.DS * 16 + 0xCCEF + 25 * index
            identifier, slot = g.word_at(base + 14), g.mem(base + 7, 1)[0]
            side, norm = int(slot < 12), slot - 11 if slot > 11 else slot
            self.player_address = g.far(0xD7BE) + 15 * identifier
            self.cache_address = g.DS * 16 + 0xD197 + 20 * side + norm
            delta = g.stack_word(10)
            self.helper = {'kind': 'byte6', 'scene': index, 'player': identifier,
                           'cache_side': side, 'cache_slot': norm,
                           'input': {'old_byte6': g.mem(self.player_address + 6, 1)[0],
                                     'delta': delta - 65536 if delta >= 32768 else delta,
                                     'cache_flag': g.stack_word(8) & 255, 'cache_before': g.mem(self.cache_address, 1)[0]}}

    def byte6_leave(self, g):
        if self.helper is not None and self.helper['kind'] == 'byte6':
            self.helper['output'] = {'byte6': g.mem(self.player_address + 6, 1)[0], 'cache': g.mem(self.cache_address, 1)[0]}
            self.pending['helpers'].append(self.helper); self.helper = None

    def threshold_enter(self, g):
        if self.pending is not None: self.threshold = {'kind': 'threshold', 'player': g.stack_word(4)}

    def threshold_leave(self, g):
        if self.threshold is not None:
            self.threshold['result'] = g.reg('ax') & 255
            self.pending['helpers'].append(self.threshold); self.threshold = None

    def event_enter(self, g):
        if self.pending is not None:
            if self.event is not None: raise ValueError('nested numeric event')
            self.event = {'code': g.stack_word(2) & 255, 'secondary_slot': g.stack_word(4),
                          'actor_slot': g.stack_word(6), 'event_side': g.stack_word(8) & 255}

    def event_leave(self, g):
        if self.event is not None:
            self.event['accepted'] = g.reg('ax') & 255
            self.pending['events'].append(self.event); self.event = None

    def external(self, g, routine):
        if self.pending is not None: self.pending['external_calls'].append({'routine': '0AB9:' + routine})

    def leave(self, g):
        if self.pending is not None:
            if any(x is not None for x in (self.selector, self.action, self.helper, self.event, self.threshold)):
                raise ValueError('incomplete effect/helper boundary')
            self.pending.update(output=snapshot(g, self.pending['input']), draw_end=self.week.draws)
            self.calls.append(self.pending); self.pending = None


def validate_state(s, context=None):
    decision.keys(s, 'handoff players rosters selectors managed_clubs mode pending cf53 sub_flags reserves added active control clear_word target_word scene_extra counters cache event_totals weights event_counts queue source_pair target_pair')
    decision.validate_state(s['handoff']); step_tail.numeric(s)
    for name in ('mode', 'pending', 'cf53', 'active', 'control'): decision.integer(s[name], 0, 255)
    if s['mode'] == 0: raise ValueError('quick mode required')
    for name in ('added', 'clear_word', 'target_word'): decision.integer(s[name])
    for name in ('managed_clubs', 'sub_flags', 'reserves'): decision.vector(s[name], 2)
    for name in ('event_counts', 'source_pair', 'target_pair'): decision.vector(s[name], 2, 65535)
    if len(s['rosters']) != 2: raise ValueError('two complete rosters required')
    for r, c in zip(s['rosters'], s['handoff']['clubs']):
        decision.keys(r, 'club players'); decision.vector(r['players'], 20, 3920)
        if r['club'] != c['id']: raise ValueError('roster club differs')
    ids = sorted({p for r in s['rosters'] for p in r['players']} | {r['player'] for r in s['handoff']['scenes']})
    if [p['id'] for p in s['players']] != ids: raise ValueError('incomplete/ambiguous shared players')
    old = {p['id']: p for p in s['handoff']['players']}
    for p in s['players']:
        decision.keys(p, 'id ' + ' '.join(f'p8_{i}' for i in P8) + ' ' + ' '.join(f'p15_{i}' for i in P15))
        decision.integer(p['id'], 0, 3920)
        for k, v in p.items():
            if k != 'id': decision.integer(v, 0, 255)
            if p['id'] in old and k in old[p['id']] and old[p['id']][k] != v: raise ValueError('conflicting handoff/shared player field')
    if [r['index'] for r in s['scene_extra']] != list(range(1, 23)): raise ValueError('incomplete ordered scene extras')
    for r in s['scene_extra']:
        decision.keys(r, 'index word8 motion motion_word')
        for k, v in r.items(): decision.integer(v, 0, 255 if k == 'motion' else 65535)
    for name, n, hi in [('counters', 3, 255), ('cache', 20, 255), ('event_totals', 20, 65535)]:
        if len(s[name]) != 2: raise ValueError('incomplete matrix')
        for row in s[name]: decision.vector(row, n, hi)
    if [r['code'] for r in s['weights']] != [50, 51, 52]: raise ValueError('incomplete event weights')
    for r in s['weights']: decision.keys(r, 'code value'); decision.integer(r['value'], 0, 255)
    decision.keys(s['selectors'], 'head cells'); decision.integer(s['selectors']['head'], 1, 255)
    cells = s['selectors']['cells']
    if len(cells) != 2: raise ValueError('two selector cells required')
    for c in cells: decision.keys(c, 'index value'); decision.integer(c['index'], 1, 255); decision.integer(c['value'], 0, 255)
    decision.keys(s['queue'], 'head rows'); decision.integer(s['queue']['head'], 0, 1700)
    rows = s['queue']['rows']
    if len(rows) != 4: raise ValueError('four numeric queue context rows required')
    for r in rows:
        decision.keys(r, 'index code first_player second_player side')
        for k, v in r.items(): decision.integer(v, 0, 255 if k in ('code', 'side') else 1700 if k == 'index' else 65535)
    if context is None:
        indices = [s['queue']['head']]
        for _ in range(3): indices.append(step_tail.next_row(indices[-1]))
        if [r['index'] for r in rows] != indices or cells[0]['index'] != s['selectors']['head']:
            raise ValueError('entry selector/queue context differs')
    elif ([r['index'] for r in rows] != [r['index'] for r in context['queue']['rows']]
          or not placement.same_json(cells, context['selectors']['cells'])):
        raise ValueError('observation context identity changed')


def cases_for(calls, meta, original, lookup_rows):
    try: return _cases_for(calls, meta, original, lookup_rows)
    except (KeyError, IndexError, TypeError, AttributeError, StopIteration) as exc: raise ValueError(f'incomplete effect/source fields: {exc}') from exc


def _cases_for(calls, meta, original, lookup_rows):
    old = [c for c in contests.outputs(original)['calls'] if c['dispatch'] is not None]
    if [c['step'] for c in calls] != [c['step'] for c in old]: raise ValueError('incomplete/reordered dispatches')
    lookups = {r['step']: r for r in lookup_rows}
    rows = []
    for c, previous in zip(calls, old):
        decision.keys(c, 'step input output draw_start draw_end selectors actions helpers events external_calls')
        validate_state(c['input']); validate_state(c['output'], c['input'])
        if (not placement.same_json(c['input']['handoff'], previous['dispatch']['input'])
                or not placement.same_json(c['output']['handoff'], previous['output'])
                or c['draw_start'] != previous['dispatch']['draw_start'] or c['draw_end'] != previous['draw_end']):
            raise ValueError('logical dispatch/return differs from T17')
        selectors = c['selectors']
        if len(selectors) != 2 or [r['site'] for r in selectors] != ['0AB9:69D3', '0AB9:6A25']:
            raise ValueError('incomplete selector calls')
        before = c['input']['selectors']['head']
        for sel, cell in zip(selectors, c['input']['selectors']['cells']):
            decision.keys(sel, 'site head_before head_after value')
            for k in ('head_before', 'head_after'): decision.integer(sel[k], 1, 255)
            decision.integer(sel['value'], 0, 255)
            if sel['head_before'] != before or cell['index'] != before or cell['value'] != sel['value']:
                raise ValueError('selector boundary/cell differs')
            before = sel['head_after']
        if before != c['output']['selectors']['head']: raise ValueError('selector output differs')
        for a in c['actions']:
            decision.keys(a, 'routine scene input output'); decision.integer(a['scene'], 1, 22)
            if a['routine'] not in ('0AB9:63E3', '0AB9:6589', '0AB9:6849'): raise ValueError('unknown effect handler')
            validate_state(a['input'], c['input']); validate_state(a['output'], c['input'])
        for h in c['helpers']:
            if h['kind'] == 'availability':
                decision.keys(h, 'kind scene player byte8 flags11 result')
                for k in ('byte8', 'flags11', 'result'): decision.integer(h[k], 0, 255)
            elif h['kind'] == 'byte6':
                decision.keys(h, 'kind scene player cache_side cache_slot input output')
                decision.keys(h['input'], 'old_byte6 delta cache_flag cache_before'); decision.keys(h['output'], 'byte6 cache')
                decision.integer(h['input']['delta'], -32768, 32767)
                for k in ('old_byte6', 'cache_flag', 'cache_before'): decision.integer(h['input'][k], 0, 255)
                for v in h['output'].values(): decision.integer(v, 0, 255)
                decision.integer(h['cache_side'], 0, 1); decision.integer(h['cache_slot'], 1, 20)
            elif h['kind'] == 'threshold':
                decision.keys(h, 'kind player result'); decision.integer(h['result'], 0, 255)
            else: raise ValueError('unknown helper kind')
            decision.integer(h['player'], 0, 3920)
            if 'scene' in h: decision.integer(h['scene'], 1, 22)
        if len(c['events']) != len(c['actions']) or len(c['events']) > 2: raise ValueError('missing numeric event observation')
        for e in c['events']:
            decision.keys(e, 'code secondary_slot actor_slot event_side accepted')
            if e['code'] not in (50, 51, 52): raise ValueError('wrong numeric code')
            for k in ('secondary_slot', 'actor_slot'): decision.integer(e[k], 0, 20)
            for k in ('event_side', 'accepted'): decision.integer(e[k], 0, 1)
        for e in c['external_calls']:
            decision.keys(e, 'routine')
            if e['routine'] not in ('0AB9:A837', '0AB9:A94B'): raise ValueError('unexpected external call')
        step_tail.numeric(c)
        draws = [d for d in previous['draws'] if d['i'] >= c['draw_start']]
        if len(draws) != c['draw_end'] - c['draw_start']: raise ValueError('effect draw span differs')
        rows.append({'schema': 'event-effects-case/1', 'week': original['actions']['source']['t04_record'], **c,
                     'draws': draws, 'decision': previous, 'lookup': lookups[c['step']],
                     'source': {'t17_record': meta['record'], 't17_record_sha256': meta['record_sha256'],
                                't17_cases': meta['cases'], 't17_cases_sha256': meta['cases_sha256']}})
    return rows


def lookup_source(meta):
    index = json.loads((ROOT / 'traces/T18/index.json').read_text())
    for r in index['records']:
        if r['t17_record'] == meta['record']:
            p = ROOT / 'traces/T18' / r['cases']
            if contests.sha(p) != r['cases_sha256'] or contests.sha(ROOT / r['record']) != r['record_sha256']:
                raise ValueError('supplementary lookup source digest differs')
            return contests.events(p)
    raise ValueError('missing supplementary lookup source')


def selected_runs():
    chosen = {}
    for p in sorted(RUNS.glob('T19-r*.json')):
        r = json.loads(p.read_text())
        if r['status'] == 'completed':
            key = r['actions']['source']['t17_record']
            if key in chosen: raise ValueError('duplicate completed effect week')
            chosen[key] = p, r
    return chosen


def build_index():
    sources, chosen, records = supplement.sources(), selected_runs(), []
    if set(chosen) != {m['record'] for m, _ in sources}: raise ValueError('missing/extra completed effect week')
    for meta, original in sources:
        path, rec = chosen[meta['record']]
        if rec['start_state'] != original['start_state'] or rec['actions']['game_files'] != original['actions']['game_files']:
            raise ValueError('original state/game identities differ')
        rows = cases_for(contests.outputs(rec)['calls'], meta, original, lookup_source(meta))
        obs = {o['field']: o['value'] for o in rec['observations']}; fixture = ROOT / obs['fixture path']
        if fixture.parent != FIXTURES or contests.sha(fixture) != obs['fixture sha256'] or not placement.same_json(contests.events(fixture), rows):
            raise ValueError('effect export differs')
        records.append({'record': match.rel(path), 'record_sha256': contests.sha(path), 'cases': fixture.name,
                        'cases_sha256': contests.sha(fixture), 'week': original['actions']['source']['t04_record'],
                        'calls': len(rows), 'draws': sum(c['draw_end'] - c['draw_start'] for c in rows),
                        'selectors': sum(len(c['selectors']) for c in rows), 'actions': sum(len(c['actions']) for c in rows),
                        'helpers': sum(len(c['helpers']) for c in rows), 'events': sum(len(c['events']) for c in rows),
                        'producer_commit': rec['code_commit']})
    return {'schema': 'event-effects-corpus/1', 'records': records,
            **{k: sum(r[k] for r in records) for k in ('calls', 'draws', 'selectors', 'actions', 'helpers', 'events')},
            'weeks': len(records), 't17_index_sha256': contests.sha(ROOT / 'traces/T17/index.json'),
            't18_index_sha256': contests.sha(ROOT / 'traces/T18/index.json')}


def run():
    import cycle
    import guest
    import unicorn
    if match.git('status', '--porcelain', '--', 'runtime/emul'): raise SystemExit('commit observer before capture')
    commit = match.git('rev-parse', 'HEAD'); have = selected_runs()
    RUNS.mkdir(parents=True, exist_ok=True); FIXTURES.mkdir(parents=True, exist_ok=True)
    for meta, original in supplement.sources():
        if meta['record'] in have:
            print('already recorded ' + meta['record'], flush=True); continue
        source = original['actions']['source']; path, data = match.find_state(source['start_state_sha256'])
        started = match.utc(); week = match.Week(data); recorder = Recorder(week)
        rows, lines, status = [], [], 'completed'
        try:
            week.play()
            if week.g.unsupported or recorder.pending is not None or not placement.same_json(recorder.legacy.calls, contests.outputs(original)['calls']):
                raise ValueError('incomplete effects or new DBC6 observations differ')
            trace = contests.events(ROOT / source['trace'])
            if week.events != trace[1:-1]: raise ValueError('new original week differs from T08')
            ok, lines = match.compare(week.events, source['start_state_sha256'], ROOT / source['t04_record_path'])
            if not ok: raise ValueError('ordered DOSBox-X comparison failed')
            rows = cases_for(recorder.calls, meta, original, lookup_source(meta))
        except (Exception, KeyboardInterrupt) as exc: status = f'aborted: {type(exc).__name__}: {exc}'
        number = max(match.next_number(RUNS, 'T19-r*.json'), match.next_number(FIXTURES, 'T19-r*.jsonl'))
        rid = f'T19-r{number:04d}'; fixture = FIXTURES / (rid + '.jsonl'); placement.write_lines(fixture, rows)
        rec = copy.deepcopy(original)
        rec.update(run_id=rid, experiment='T19', arm='logical-event-effects', rep=number, code_commit=commit, machine=cycle.machine_id(),
                   started=started, ended=match.utc(), status=status, actions={'script': 'runtime/emul/event_effects.py',
                   'source': {'t17_record': meta['record'], 't17_record_sha256': meta['record_sha256']},
                   'game_files': {name: hashlib.sha256(raw).hexdigest() for name, raw in week.files_at_start.items()}},
                   outputs=[{'name': 'calls', 'value': recorder.calls}],
                   observations=[{'step': 0, 'source': 'file', 'field': 'fixture path', 'value': match.rel(fixture)},
                                 {'step': 0, 'source': 'file', 'field': 'fixture sha256', 'value': contests.sha(fixture)},
                                 {'step': 1, 'source': 'log', 'field': 'ordered DOSBox-X comparison', 'value': '\n'.join(lines)}])
        rec['runtime'] = {'harness': f'runtime/emul/event_effects.py@{commit}', 'unicorn': unicorn.__version__,
                          'python': platform.python_version(), 'dos_clock': week.g.clock,
                          'settings': {k: getattr(guest, k) for k in ('INSTR_PER_S', 'KEY_HOLD', 'PIT_HZ', 'SLICE_MAX')}}
        rec['interventions'] = [{'level': 'I3', 'what': 'guest.py services and read-only effect/helper hooks'}]
        match.write_record(RUNS / (rid + '.json'), rec)
        print(f'{rid}: {status}, {len(rows)} logical effect cases', flush=True)
        if status != 'completed': raise SystemExit(1)
    (FIXTURES / 'index.json').write_text(json.dumps(build_index(), indent=2) + '\n')


def main(argv=None):
    ap = argparse.ArgumentParser(description=__doc__); mode = ap.add_mutually_exclusive_group(required=True)
    mode.add_argument('--run', action='store_true'); mode.add_argument('--check', action='store_true'); args = ap.parse_args(argv)
    if args.run: run(); return 0
    try:
        index = build_index()
        if tuple(index[k] for k in ('weeks', 'calls', 'draws', 'selectors')) != (2, 22, 17, 44): raise ValueError('incomplete original effect coverage')
        if not placement.same_json(index, json.loads((FIXTURES / 'index.json').read_text())): raise ValueError('effect index differs')
    except (ValueError, OSError, KeyError, TypeError, StopIteration) as exc:
        print(f'event-effects check: FAIL: {exc}'); return 1
    print(f'event-effects check: ok (22 calls,17 draws,44 selectors,{index["helpers"]} helpers,{index["events"]} numeric events)'); return 0


if __name__ == '__main__': raise SystemExit(main())
