#!/usr/bin/env python3
"""T20: observe post-score strategy and late-call spans, without engine formulas."""
import argparse
import copy
import hashlib
import json
import platform

import contests
import extra_event as raw
import match
import placement
import step_tail

ROOT = contests.ROOT
RUNS, FIXTURES = ROOT / 'runs/T20', ROOT / 'traces/T20'
SITES = {'0AB9:A305', '0AB9:A38C', '0AB9:A3A4', '0AB9:A417', '0AB9:A4A5'}


def snapshot(g):
    clubs = []
    for off in (0xD6E4, 0xD6E6):
        identifier = g.rd(off); base = g.far(0xD7C2) + (identifier - 1) * 62
        index = g.rd(0xD885 + identifier, 1)
        clubs.append({'id': identifier, 'roster': [g.word_at(base + 2 * i) for i in range(20)],
                      'byte51': g.mem(base + 51, 1)[0], 'byte54': g.mem(base + 54, 1)[0],
                      'strategy': g.mem(base + 57, 1)[0], 'baseline_index': index,
                      'baseline_value': g.rd(0x93F7 + index, 1)})
    players = []
    for identifier in sorted({p for c in clubs for p in c['roster']}):
        p8, p15 = g.far(0xD7BA) + 8 * identifier, g.far(0xD7BE) + 15 * identifier
        players.append({'id': identifier, 'age': g.mem(p8 + 1, 1)[0], 'flags3': g.mem(p8 + 3, 1)[0],
                        'level': g.mem(p8 + 5, 1)[0], 'position': g.mem(p8 + 6, 1)[0],
                        'flags10': g.mem(p15 + 10, 1)[0]})
    return {'seed': g.word_at(g.far(0xDE84)), 'scores': [g.rd(0xD0C4 + i, 1) for i in range(2)],
            'managed_clubs': [g.rd(0xDCBA + i, 1) for i in range(2)],
            'limits': [g.rd(0x0C66 + i, 1) for i in range(2)],
            'raised': [g.rd(0xD0CC + i, 1) for i in range(2)],
            'lowered': [g.rd(0xD0CE + i, 1) for i in range(2)], 'clubs': clubs, 'players': players}


class Recorder:
    def __init__(self, week):
        self.week, self.tail = week, step_tail.Recorder(week)
        self.calls, self.ledger = [], []
        self.gap = self.phase = self.pending = self.setter = self.normalizer = self.getter = None
        hooks = {'0AB9:DFDB': self.gap_enter, '0AB9:E006': self.gap_leave,
                 '0AB9:DFE9': lambda g: self.start(g, '0AB9:DBC6'), '0AB9:DFEC': self.end,
                 '0AB9:DFF2': lambda g: self.start(g, '0AB9:6B2F'), '0AB9:DFF5': self.end,
                 '0AB9:DFFB': lambda g: self.start(g, '1998:045C'),
                 '0AB9:E000': lambda g: self.switch(g, '0AB9:52B6'),
                 '0AB9:E003': lambda g: self.switch(g, '0AB9:78B7'),
                 '0AB9:A4F2': self.enter, '0AB9:A5BA': self.leave,
                 '1998:0C23': self.setter_enter, '1998:0C76': self.setter_leave,
                 '1B55:53FB': self.normalizer_enter, '1B55:54A2': self.normalizer_leave,
                 '1B55:265B': self.getter_enter, '1B55:26B9': self.getter_leave}
        for routine in ('A23C', 'A34D', 'A3D6', 'A464'):
            hooks['0AB9:' + routine] = lambda g, r=routine: self.path(g, r)
        for address, fn in hooks.items(): week.g.code_hook(address, fn)

    def gap_enter(self, g):
        if self.tail.active:
            if self.gap is not None: raise ValueError('nested late-call gap')
            self.gap = {'step': len(self.tail.calls) - 1, 'draw_start': self.week.draws,
                        'seed_start': g.word_at(g.far(0xDE84)), 'phases': []}

    def start(self, g, routine):
        if self.gap is not None:
            if self.phase is not None: raise ValueError('nested late phase')
            self.phase = {'routine': routine, 'draw_start': self.week.draws, 'seed_before': g.word_at(g.far(0xDE84))}

    def end(self, g):
        if self.phase is not None:
            self.phase.update(draw_end=self.week.draws, seed_after=g.word_at(g.far(0xDE84)))
            self.gap['phases'].append(self.phase); self.phase = None

    def switch(self, g, routine):
        self.end(g); self.start(g, routine)

    def gap_leave(self, g):
        if self.gap is not None:
            self.end(g); self.gap.update(draw_end=self.week.draws, seed_end=g.word_at(g.far(0xDE84)))
            self.ledger.append(self.gap); self.gap = None

    def enter(self, g):
        if self.gap is None or g.stack_word(0) != 0x5306: return
        if self.pending is not None or g.reg('ds') != g.DS: raise ValueError('unexpected strategy nesting/DS')
        self.pending = {'step': self.gap['step'], 'argument': g.stack_word(2), 'input': snapshot(g),
                        'draw_start': self.week.draws, 'paths': [], 'setters': [], 'normalizers': [], 'getters': []}

    def leave(self, g):
        if self.pending is not None:
            if any(x is not None for x in (self.setter, self.normalizer, self.getter)): raise ValueError('incomplete strategy helper')
            self.pending.update(output=snapshot(g), draw_end=self.week.draws)
            self.calls.append(self.pending); self.pending = None

    def path(self, g, routine):
        if self.pending is not None:
            side = g.stack_word(2 if routine == 'A23C' else 4) & 255
            row = {'routine': '0AB9:' + routine, 'side': side}
            if routine == 'A34D': row['raise'] = g.stack_word(6) & 255
            self.pending['paths'].append(row)

    def setter_enter(self, g):
        if self.pending is not None:
            if self.setter is not None: raise ValueError('nested strategy setter')
            self.setter = {'club': g.stack_word(6), 'value': g.stack_word(4) & 255, 'input': snapshot(g),
                           'normalizer_start': len(self.pending['normalizers'])}

    def setter_leave(self, g):
        if self.setter is not None:
            self.setter.update(output=snapshot(g), normalizer_end=len(self.pending['normalizers']))
            self.pending['setters'].append(self.setter); self.setter = None

    def normalizer_enter(self, g):
        if self.pending is not None:
            if self.normalizer is not None: raise ValueError('nested flag normalizer')
            identifier = g.stack_word(4)
            self.normalizer = {'player': identifier, 'before': g.mem(g.far(0xD7BE) + 15 * identifier + 10, 1)[0]}

    def normalizer_leave(self, g):
        if self.normalizer is not None:
            self.normalizer['after'] = g.mem(g.far(0xD7BE) + 15 * self.normalizer['player'] + 10, 1)[0]
            self.pending['normalizers'].append(self.normalizer); self.normalizer = None

    def getter_enter(self, g):
        if self.pending is not None:
            if self.getter is not None: raise ValueError('nested club getter')
            self.getter = {'club': g.stack_word(4)}

    def getter_leave(self, g):
        if self.getter is not None:
            self.getter['value'] = g.reg('ax'); self.pending['getters'].append(self.getter); self.getter = None


def validate_state(s):
    raw.keys(s, 'seed scores managed_clubs limits raised lowered clubs players'); step_tail.numeric(s)
    raw.integer(s['seed'])
    for name in ('scores', 'managed_clubs', 'limits', 'raised', 'lowered'): raw.vector(s[name], 2)
    if len(s['clubs']) != 2: raise ValueError('two clubs required')
    aliases, lookups = {}, {}
    for c in s['clubs']:
        raw.keys(c, 'id roster byte51 byte54 strategy baseline_index baseline_value'); raw.integer(c['id'], 1, 176)
        raw.vector(c['roster'], 20, 3920)
        for k in ('byte51', 'byte54', 'strategy', 'baseline_index', 'baseline_value'): raw.integer(c[k], 0, 255)
        if c['id'] in aliases and not placement.same_json(aliases[c['id']], c): raise ValueError('conflicting club alias')
        aliases[c['id']] = c
        if c['baseline_index'] in lookups and lookups[c['baseline_index']] != c['baseline_value']: raise ValueError('conflicting baseline lookup')
        lookups[c['baseline_index']] = c['baseline_value']
    if [p['id'] for p in s['players']] != sorted({p for c in s['clubs'] for p in c['roster']}): raise ValueError('incomplete canonical players')
    for p in s['players']:
        raw.keys(p, 'id age flags3 level position flags10'); raw.integer(p['id'], 0, 3920)
        for k in ('age', 'flags3', 'level', 'position', 'flags10'): raw.integer(p[k], 0, 255)


def validate_ledger(ledger, prefixes, trace):
    if len(ledger) != len(prefixes): raise ValueError('incomplete late-call ledger')
    draws = contests.draw_stream(trace)
    for i, (c, old) in enumerate(zip(ledger, prefixes)):
        raw.keys(c, 'step draw_start seed_start phases draw_end seed_end'); step_tail.numeric(c)
        if c['step'] != i or c['draw_start'] != old['prefix']['draw_end'] or c['seed_start'] != old['prefix']['output']['seed'] or c['draw_end'] != old['clock']['draw_start'] or c['seed_end'] != old['clock']['input']['seed']:
            raise ValueError('late gap differs from retained prefix/clock')
        if [p['routine'] for p in c['phases']] != [p['routine'] for p in old['prefix']['pending_calls']]: raise ValueError('missing/reordered late call')
        cursor, seed = c['draw_start'], c['seed_start']
        for p in c['phases']:
            raw.keys(p, 'routine draw_start seed_before draw_end seed_after')
            for k in ('draw_start', 'draw_end'): raw.integer(p[k], 0, len(draws))
            for k in ('seed_before', 'seed_after'): raw.integer(p[k])
            if p['draw_start'] != cursor or p['seed_before'] != seed or p['draw_end'] < cursor: raise ValueError('late phase boundary not contiguous')
            selected = draws[cursor:p['draw_end']]
            if selected:
                if selected[0]['seed_before'] != seed or selected[-1]['seed_after'] != p['seed_after']: raise ValueError('late draw seed differs')
            elif p['seed_after'] != seed: raise ValueError('zero-draw phase changed seed')
            cursor, seed = p['draw_end'], p['seed_after']
        if cursor != c['draw_end'] or seed != c['seed_end']: raise ValueError('late ledger truncated')


def cases_for(calls, ledger, prefixes, source, trace, meta):
    try: return _cases_for(calls, ledger, prefixes, source, trace, meta)
    except (KeyError, IndexError, TypeError, AttributeError, StopIteration) as exc: raise ValueError(f'incomplete strategy/source fields: {exc}') from exc


def _cases_for(calls, ledger, prefixes, source, trace, meta):
    validate_ledger(ledger, prefixes, trace)
    wanted = [i for i, p in enumerate(prefixes) if any(r['routine'] == '0AB9:52B6' for r in p['prefix']['pending_calls'])]
    if [c['step'] for c in calls] != wanted: raise ValueError('missing/reordered post-score call')
    draws, rows = contests.draw_stream(trace), []
    for c in calls:
        raw.keys(c, 'step argument input output draw_start paths setters normalizers getters draw_end'); step_tail.numeric(c)
        raw.integer(c['argument']); validate_state(c['input']); validate_state(c['output'])
        old = prefixes[c['step']]; reset = next(p for p in ledger[c['step']]['phases'] if p['routine'] == '0AB9:52B6')
        start, end = c['draw_start'], c['draw_end']
        if not reset['draw_start'] <= start <= end <= reset['draw_end']: raise ValueError('strategy not inside reset')
        if c['input']['seed'] != old['prefix']['output']['seed'] or c['input']['scores'] != old['prefix']['output']['score_bytes'] or [x['id'] for x in c['input']['clubs']] != list(reversed(old['prefix']['input']['clubs'])):
            raise ValueError('strategy shared inputs differ from prefix')
        selected = draws[start:end]
        if selected:
            if selected[0]['seed_before'] != c['input']['seed'] or selected[-1]['seed_after'] != c['output']['seed']: raise ValueError('strategy seed differs')
        elif c['input']['seed'] != c['output']['seed']: raise ValueError('zero-draw strategy seed differs')
        if any(len(SITES.intersection(d['callers'])) != 1 for d in selected): raise ValueError('unattributed strategy draw')
        values = {p['id']: p['flags10'] for p in c['input']['players']}
        for n in c['normalizers']:
            raw.keys(n, 'player before after'); raw.integer(n['player'], 0, 3920); raw.integer(n['before'], 0, 255); raw.integer(n['after'], 0, 255)
            if values[n['player']] != n['before']: raise ValueError('normalizer did not continue actual player flag')
            values[n['player']] = n['after']
        if values != {p['id']: p['flags10'] for p in c['output']['players']}: raise ValueError('missing player normalizer')
        cursor = 0
        for setter in c['setters']:
            raw.keys(setter, 'club value input normalizer_start output normalizer_end')
            raw.integer(setter['club'], 1, 176); raw.integer(setter['value'], 0, 255)
            validate_state(setter['input']); validate_state(setter['output'])
            begin, finish = setter['normalizer_start'], setter['normalizer_end']
            raw.integer(begin, 0, len(c['normalizers'])); raw.integer(finish, begin, len(c['normalizers']))
            club = next(r for r in setter['input']['clubs'] if r['id'] == setter['club'])
            if begin != cursor or [n['player'] for n in c['normalizers'][begin:finish]] != [p for p in club['roster'] if p != 0]: raise ValueError('setter normalizer coverage differs')
            cursor = finish
        if cursor != len(c['normalizers']): raise ValueError('normalizer outside setter')
        for p in c['paths']:
            raw.keys(p, 'routine side' + (' raise' if p['routine'] == '0AB9:A34D' else '')); raw.integer(p['side'], 0, 1)
            if p['routine'] not in ('0AB9:A23C', '0AB9:A34D', '0AB9:A3D6', '0AB9:A464'): raise ValueError('unknown strategy path')
            if 'raise' in p: raw.integer(p['raise'], 0, 1)
        for g in c['getters']: raw.keys(g, 'club value'); raw.integer(g['club'], 1, 176); raw.integer(g['value'])
        rows.append({'schema': 'post-score-case/1', 'week': source['t04_record'], **c, 'draws': selected, 'prefix': old,
                     'source': {'t16_record': meta['record'], 't16_record_sha256': meta['record_sha256'],
                                't16_cases': meta['cases'], 't16_cases_sha256': meta['cases_sha256'],
                                't08_trace': source['trace'], 't08_trace_sha256': source['trace_sha256']}})
    owned = [d['i'] for c in calls for d in draws[c['draw_start']:c['draw_end']]]
    expected = [d['i'] for l in ledger for d in draws[l['draw_start']:l['draw_end']] if SITES.intersection(d['callers'])]
    if owned != expected: raise ValueError('strategy draw coverage incomplete')
    return rows


def sources():
    index = json.loads((ROOT / 'traces/T16/index.json').read_text())
    for m in index['records']:
        p, f = ROOT / m['record'], ROOT / 'traces/T16' / m['cases']
        if contests.sha(p) != m['record_sha256'] or contests.sha(f) != m['cases_sha256']: raise ValueError('retained prefix record/case digest differs')
        yield m, json.loads(p.read_text()), contests.events(f)


def selected_runs():
    chosen = {}
    for p in sorted(RUNS.glob('T20-r*.json')):
        r = json.loads(p.read_text())
        if r['status'] == 'completed':
            key = r['actions']['source']['t16_record']
            if key in chosen: raise ValueError('duplicate completed strategy week')
            chosen[key] = p, r
    return chosen


def build_index():
    old, chosen, records, coverage = list(sources()), selected_runs(), [], []
    if set(chosen) != {m['record'] for m, _, _ in old}: raise ValueError('missing/extra strategy week')
    _, groups = contests.read_corpus()
    for meta, prior, prefixes in old:
        path, rec = chosen[meta['record']]; source = prior['actions']['source']
        if rec['start_state'] != prior['start_state'] or rec['actions']['game_files'] != prior['actions']['game_files']: raise ValueError('original state/game identity differs')
        values = contests.outputs(rec); trace = contests.events(ROOT / source['trace'])
        rows = cases_for(values['calls'], values['ledger'], prefixes, source, trace, meta)
        obs = {o['field']: o['value'] for o in rec['observations']}; fixture = ROOT / obs['fixture path']
        if fixture.parent != FIXTURES or contests.sha(fixture) != obs['fixture sha256'] or not placement.same_json(contests.events(fixture), rows): raise ValueError('strategy export differs')
        records.append({'record': match.rel(path), 'record_sha256': contests.sha(path), 'cases': fixture.name, 'cases_sha256': contests.sha(fixture),
                        'week': source['t04_record'], 'calls': len(rows), 'draws': sum(c['draw_end'] - c['draw_start'] for c in rows),
                        'steps': len(values['ledger']), 'late_calls': sum(len(l['phases']) for l in values['ledger']),
                        'setters': sum(len(c['setters']) for c in rows), 'normalizers': sum(len(c['normalizers']) for c in rows),
                        'getters': sum(len(c['getters']) for c in rows), 'producer_commit': rec['code_commit']})
        for entry, repeated in groups[prior['actions']['stream_key']]:
            validate_ledger(values['ledger'], prefixes, repeated)
            coverage.append({'trace': entry['trace'], 'trace_sha256': entry['trace_sha256'], 'cases': fixture.name})
    return {'schema': 'post-score-corpus/1', 'records': records, 'coverage': coverage,
            **{k: sum(r[k] for r in records) for k in ('calls', 'draws', 'steps', 'late_calls', 'setters', 'normalizers', 'getters')},
            'weeks': len(records), 'traces': len(coverage), 't16_index_sha256': contests.sha(ROOT / 'traces/T16/index.json')}


def run():
    import cycle
    import guest
    import unicorn
    if match.git('status', '--porcelain', '--', 'runtime/emul'): raise SystemExit('commit observer before capture')
    commit = match.git('rev-parse', 'HEAD'); have = selected_runs()
    RUNS.mkdir(parents=True, exist_ok=True); FIXTURES.mkdir(parents=True, exist_ok=True)
    for meta, prior, prefixes in sources():
        if meta['record'] in have:
            print('already recorded ' + meta['record'], flush=True); continue
        source = prior['actions']['source']; path, data = match.find_state(source['start_state_sha256'])
        started = match.utc(); week = match.Week(data); recorder = Recorder(week)
        rows, lines, status = [], [], 'completed'
        try:
            week.play()
            if week.g.unsupported or recorder.pending is not None or recorder.gap is not None or not placement.same_json(recorder.tail.calls, contests.outputs(prior)['calls']): raise ValueError('incomplete strategy/ledger or full T16 projection differs')
            trace = contests.events(ROOT / source['trace'])
            if week.events != trace[1:-1]: raise ValueError('new original week differs from T08')
            ok, lines = match.compare(week.events, source['start_state_sha256'], ROOT / source['t04_record_path'])
            if not ok: raise ValueError('ordered DOSBox-X comparison failed')
            rows = cases_for(recorder.calls, recorder.ledger, prefixes, source, trace, meta)
        except (Exception, KeyboardInterrupt) as exc: status = f'aborted: {type(exc).__name__}: {exc}'
        n = max(match.next_number(RUNS, 'T20-r*.json'), match.next_number(FIXTURES, 'T20-r*.jsonl'))
        rid = f'T20-r{n:04d}'; fixture = FIXTURES / (rid + '.jsonl'); placement.write_lines(fixture, rows)
        rec = copy.deepcopy(prior)
        rec.update(run_id=rid, experiment='T20', arm='post-score-strategy', rep=n, code_commit=commit, machine=cycle.machine_id(),
                   started=started, ended=match.utc(), status=status,
                   actions={'script': 'runtime/emul/post_score.py', 'source': {'t16_record': meta['record'], 't16_record_sha256': meta['record_sha256']},
                            'game_files': {name: hashlib.sha256(raw).hexdigest() for name, raw in week.files_at_start.items()}},
                   outputs=[{'name': 'calls', 'value': recorder.calls}, {'name': 'ledger', 'value': recorder.ledger}],
                   observations=[{'step': 0, 'source': 'file', 'field': 'fixture path', 'value': match.rel(fixture)},
                                 {'step': 0, 'source': 'file', 'field': 'fixture sha256', 'value': contests.sha(fixture)},
                                 {'step': 1, 'source': 'log', 'field': 'ordered DOSBox-X comparison', 'value': '\n'.join(lines)}])
        rec['runtime'] = {'harness': f'runtime/emul/post_score.py@{commit}', 'unicorn': unicorn.__version__, 'python': platform.python_version(),
                          'dos_clock': week.g.clock, 'settings': {k: getattr(guest, k) for k in ('INSTR_PER_S', 'KEY_HOLD', 'PIT_HZ', 'SLICE_MAX')}}
        rec['interventions'] = [{'level': 'I3', 'what': 'guest.py services and read-only strategy/late-call hooks'}]
        match.write_record(RUNS / (rid + '.json'), rec)
        print(f'{rid}: {status}; {len(rows)} strategy cases, {len(recorder.ledger)} step ledgers', flush=True)
        if status != 'completed': raise SystemExit(1)
    (FIXTURES / 'index.json').write_text(json.dumps(build_index(), indent=2) + '\n')


def main(argv=None):
    ap = argparse.ArgumentParser(description=__doc__); mode = ap.add_mutually_exclusive_group(required=True)
    mode.add_argument('--run', action='store_true'); mode.add_argument('--check', action='store_true'); args = ap.parse_args(argv)
    if args.run: run(); return 0
    try:
        index = build_index()
        if tuple(index[k] for k in ('weeks', 'calls', 'draws', 'steps', 'late_calls', 'traces')) != (6, 17, 12, 558, 1317, 15): raise ValueError('incomplete strategy/late-call coverage')
        if not placement.same_json(index, json.loads((FIXTURES / 'index.json').read_text())): raise ValueError('strategy index differs')
    except (ValueError, OSError, KeyError, TypeError, StopIteration) as exc:
        print(f'post-score check: FAIL: {exc}'); return 1
    print('post-score check: ok (17 calls, 12 draws, 558 ledgers, 1317 late calls, 15 references)'); return 0


if __name__ == '__main__': raise SystemExit(main())
