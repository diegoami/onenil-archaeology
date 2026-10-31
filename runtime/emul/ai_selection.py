#!/usr/bin/env python3
"""T23: original A94B selection observations; A837/AEB8 remain opaque."""
import argparse
import copy
import hashlib
import json
import platform

import contests
import extra_event as raw
import match
import placement
import substitution as sub

ROOT = contests.ROOT
RUNS, FIXTURES = ROOT / 'runs/T23', ROOT / 'traces/T23'
# Call sites and following instructions, verified against the committed listings.
SITES = {
    '0AB9:AA02': ('0AB9:AA05', 'candidates', 0),
    '0AB9:A8A4': ('0AB9:A8A9', 'limit', 0),
    '0AB9:A909': ('0AB9:A90E', 'available', 1),
    '0AB9:AA13': ('0AB9:AA16', 'preferred', 0),
    '0AB9:993A': ('0AB9:993F', 'handedness', 1),
    '0AB9:AA4F': ('0AB9:AA54', 'limit', 0),
    '0AB9:AA6D': ('0AB9:AA72', 'weighted', 2),
    '1B55:505D': ('1B55:5060', 'available', 1),
    '1B55:50A5': ('1B55:50A8', 'handedness', 1),
    '0AB9:A9D1': ('0AB9:A9D4', 'fallback', 1),
    '0AB9:AA9B': ('0AB9:AA9E', 'fallback', 1),
    '0AB9:ABAF': ('0AB9:ABB2', 'replace', 3),
}
OPAQUE = {'fallback', 'replace'}


def scratch(g):
    return [g.rd(0xD076 + i, 1) for i in range(14)]


def state(g):
    s = sub.snapshot(g)
    for p in s['players']:
        base = g.far(0xD7BA) + 8 * p['id']
        p['position'] = g.mem(base + 6, 1)[0]
        p['style'] = g.mem(base + 7, 1)[0]
        selector = g.rd(0x12BA + p['id'] % 3, 1)
        p['hand_selector'] = selector
        p['hand_cell'] = g.rd((0x129E + 14 * selector + p['style']) & 65535, 1)
    allowance = s['allowance']
    signed = allowance if allowance < 128 else allowance - 256
    s['limit_cell'] = g.rd((0xD58 + signed) & 65535, 1)
    n = g.rd(0xD9A, 1)
    s['style_text'] = g.mem(g.DS * 16 + 0xD9B, n).decode('latin1')
    s['preferences'] = []
    for position in range(14):
        base = 0xBF6 + 8 * position
        count = g.rd(base, 1)
        if count > 7:
            raise ValueError('preference table exceeds its static eight-byte row')
        s['preferences'].append({'position': position, 'styles': [g.rd(base + i, 1) for i in range(1, count + 1)],
                                 'weights': [g.rd(0xDA6 + 14 * position + i, 1) for i in range(14)]})
    s['candidates'] = scratch(g)
    s['cache_selectors'] = [[g.rd(0xD197 + 20 * side + slot, 1) for slot in range(1, 21)] for side in range(2)]
    return s


def project(s):
    result = {k: copy.deepcopy(s[k]) for k in (
        'seed', 'managed_clubs', 'clubs', 'scenes', 'players', 'side_offsets', 'remaining',
        'added', 'allowance', 'sub_flags', 'reserves', 'pending', 'control', 'key', 'event_totals')}
    for p in result['players']:
        for k in ('position', 'style', 'hand_selector', 'hand_cell'):
            del p[k]
    return result


def validate_state(s):
    raw.keys(s, 'seed managed_clubs clubs scenes players side_offsets remaining added allowance sub_flags reserves pending control key event_totals limit_cell style_text preferences candidates cache_selectors')
    sub.validate_state(project(s))
    for p in s['players']:
        raw.keys(p, 'id byte8 flags11 position style hand_selector hand_cell')
        for k in ('position', 'style', 'hand_selector', 'hand_cell'):
            raw.integer(p[k], 0, 255)
    raw.integer(s['limit_cell'], 0, 255)
    if not isinstance(s['style_text'], str) or len(s['style_text']) > 255:
        raise ValueError('invalid numeric style text')
    if [r['position'] for r in s['preferences']] != list(range(14)):
        raise ValueError('complete ordered preference rows required')
    for r in s['preferences']:
        raw.keys(r, 'position styles weights')
        if len(r['styles']) > 7:
            raise ValueError('oversized preference row')
        raw.vector(r['styles'], len(r['styles']), 13)
        raw.vector(r['weights'], 14, 255)
    raw.vector(s['candidates'], 14, 255)
    if len(s['cache_selectors']) != 2:
        raise ValueError('two cache rows required')
    for r in s['cache_selectors']:
        raw.vector(r, 20, 255)


class Recorder:
    def __init__(self, week):
        self.week, self.legacy = week, sub.Recorder(week)
        self.calls, self.pending, self.stack = [], None, []
        week.g.code_hook('0AB9:6CA5', self.enter)
        week.g.code_hook('0AB9:6CA8', self.leave)
        for site, (end, kind, nargs) in SITES.items():
            week.g.code_hook(site, lambda g, site=site: self.start(g, site))
            week.g.code_hook(end, lambda g, site=site: self.end(g, site))

    def enter(self, g):
        if self.legacy.pending is None:
            return
        if self.pending is not None or self.stack:
            raise ValueError('nested dispatcher A94B')
        side = g.stack_word(2) & 255
        self.pending = {'step': self.legacy.pending['step'], 'side': side,
                        'scene': g.stack_word(4), 'mode': g.stack_word(0) & 255,
                        'input': state(g), 'draw_start': self.week.draws, 'helpers': []}

    def start(self, g, site):
        if self.pending is None or any(e['kind'] in OPAQUE for e in self.stack):
            return
        _, kind, n = SITES[site]
        e = {'site': site, 'kind': kind, 'arguments': [g.stack_word(2*i) for i in range(n)],
             'draw_start': self.week.draws, 'candidates_before': scratch(g), 'children': []}
        if kind in OPAQUE:
            if kind == 'replace':
                e['arguments'][2] &= 255
            e['input'] = state(g)
        if self.stack:
            self.stack[-1]['children'].append(e)
        else:
            self.pending['helpers'].append(e)
        self.stack.append(e)

    def end(self, g, site):
        if self.pending is None or not self.stack or self.stack[-1]['site'] != site:
            return
        e = self.stack.pop()
        e.update(draw_end=self.week.draws, candidates_after=scratch(g))
        if e['kind'] in OPAQUE:
            e['output'] = state(g)
        elif e['kind'] != 'candidates':
            e['result'] = g.reg('ax') & (255 if e['kind'] in ('available', 'handedness') else 65535)

    def leave(self, g):
        if self.pending is None:
            return
        if self.stack:
            raise ValueError('unfinished A94B helper')
        self.pending.update(output=state(g), draw_end=self.week.draws)
        self.calls.append(self.pending)
        self.pending = None


def flatten(events):
    for e in events:
        yield e
        yield from flatten(e['children'])


def validate_helpers(events, call, parent=None):
    cursor = call['draw_start'] if parent is None else parent['draw_start']
    end = call['draw_end'] if parent is None else parent['draw_end']
    allowed = {'candidates', 'preferred', 'weighted', 'fallback', 'replace', 'limit'} if parent is None else {
        'candidates': {'limit', 'available'}, 'preferred': {'handedness'},
        'weighted': {'available', 'handedness'}}.get(parent['kind'], set())
    for e in events:
        kind = e['kind']
        if e['site'] not in SITES or SITES[e['site']][1] != kind or kind not in allowed:
            raise ValueError('unexpected helper/site/nesting')
        extra = ' input output' if kind in OPAQUE else ('' if kind == 'candidates' else ' result')
        raw.keys(e, 'site kind arguments draw_start draw_end candidates_before candidates_after children' + extra)
        raw.vector(e['arguments'], SITES[e['site']][2], 65535)
        for k in ('draw_start', 'draw_end'):
            raw.integer(e[k], 0, 10**9)
        if not cursor <= e['draw_start'] <= e['draw_end'] <= end:
            raise ValueError('helper draw order differs')
        cursor = e['draw_end']
        for k in ('candidates_before', 'candidates_after'):
            raw.vector(e[k], 14, 255)
        if kind in OPAQUE:
            validate_state(e['input']); validate_state(e['output'])
            if e['children'] or e['candidates_before'] != e['input']['candidates'] or e['candidates_after'] != e['output']['candidates']:
                raise ValueError('opaque boundary is incomplete')
            args = e['arguments']
            if kind == 'replace' and (args[1], args[2]) != (call['scene'], call['side']):
                raise ValueError('replacement selectors differ')
            if kind == 'fallback' and args != [call['scene']]:
                raise ValueError('fallback scene differs')
        elif kind != 'candidates':
            raw.integer(e['result'], 0, 255 if kind in ('available', 'handedness') else 65535)
        validate_helpers(e['children'], call, e)
        if kind == 'candidates':
            if not e['children'] or e['children'][0]['kind'] != 'limit' or any(c['kind'] != 'available' for c in e['children'][1:]):
                raise ValueError('missing/reordered candidate helpers')
            limit = e['children'][0]['result']
            raw.integer(limit, 11, 20)
            roster = call['input']['clubs'][call['side']]['roster']
            player = call['input']['scenes'][call['scene']-1]['player']
            # Verify the observed reserve-scan footprint, not candidate choice/results.
            expected = [[roster[i-1]] for i in range(12, limit+1) if roster[i-1] != player]
            if [child['arguments'] for child in e['children'][1:]] != expected:
                raise ValueError('missing/reordered reserve availability observations')
            if any(e['candidates_before']):
                raise ValueError('candidate scan did not begin after the clear')
        if kind in ('preferred', 'weighted') and e['candidates_before'] != e['candidates_after']:
            raise ValueError('selection helper changed candidate scratch')
        if kind in ('available', 'handedness', 'limit') and e['candidates_before'] != e['candidates_after']:
            raise ValueError('read-only helper changed candidates')
    if parent is None:
        kinds = [e['kind'] for e in events]
        permitted = ([], ['fallback'], ['candidates', 'preferred'], ['candidates', 'preferred', 'limit', 'weighted'],
                     ['candidates', 'preferred', 'fallback'], ['candidates', 'preferred', 'limit', 'weighted', 'fallback'],
                     ['candidates', 'preferred', 'replace'], ['candidates', 'preferred', 'limit', 'weighted', 'replace'])
        # The direct second reserve-limit call occurs before weighted selection.
        # It is retained as a separate ordered helper below.
        if kinds not in permitted:
            raise ValueError('selection helper order differs')
        candidate_cursor = None
        selected = None
        for e in events:
            if candidate_cursor is not None and e['candidates_before'] != candidate_cursor:
                raise ValueError('helper candidate continuation differs')
            candidate_cursor = e['candidates_after']
            if e['kind'] in ('preferred', 'weighted'):
                selected = e['result']
            if e['kind'] == 'replace' and (selected is None or not 12 <= selected <= 20 or e['arguments'][0] != selected):
                raise ValueError('replacement slot differs from observed selection')
        if events and events[-1]['kind'] in OPAQUE:
            if events[-1]['output'] != call['output']:
                raise ValueError('opaque return does not continue to A94B return')
        else:
            before, after = copy.deepcopy(call['input']), copy.deepcopy(call['output'])
            before.pop('candidates'); after.pop('candidates')
            if before != after:
                raise ValueError('unexplained selection-only mutation')
        if candidate_cursor is not None and candidate_cursor != call['output']['candidates']:
            raise ValueError('candidate return differs from final helper')


def cases_for(calls, retained, week):
    try:
        expected = [(c['step'], e) for c in retained for e in c['events'] if e['kind'] == 'ai']
        if len(calls) != len(expected):
            raise ValueError('missing/extra A94B cases')
        rows = []
        for c, (step, e) in zip(calls, expected):
            raw.keys(c, 'step side scene mode input draw_start helpers output draw_end')
            for k in ('step', 'scene', 'mode', 'side', 'draw_start', 'draw_end'):
                raw.integer(c[k], 0, 10**9)
            if (c['step'], c['mode'], c['side'], c['scene']) != (step, *e['arguments'][:3]):
                raise ValueError('A94B order/arguments differ from T22')
            for k in ('input', 'output'):
                validate_state(c[k])
                if project(c[k]) != e[k]:
                    raise ValueError('A94B boundary differs from T22')
            if (c['draw_start'], c['draw_end']) != (e['draw_start'], e['draw_end']):
                raise ValueError('A94B draw interval differs from T22')
            validate_helpers(c['helpers'], c)
            rows.append({'schema': 'ai-selection-case/1', 'week': week, **c})
        return rows
    except (KeyError, TypeError, IndexError, AttributeError) as exc:
        raise ValueError(f'incomplete AI selection fields: {exc}') from exc


def sources():
    sub.build_index()
    for meta in json.loads((sub.FIXTURES/'index.json').read_text())['records']:
        yield meta, json.loads((ROOT/meta['record']).read_text())


def selected_runs():
    result = {}
    for p in sorted(RUNS.glob('T23-r*.json')):
        r = json.loads(p.read_text())
        if r['status'] == 'completed':
            key = r['actions']['source']['t22_record']
            if key in result:
                raise ValueError('duplicate completed AI week')
            result[key] = p, r
    return result


def build_index():
    prior = list(sources()); chosen = selected_runs(); records = []
    if set(chosen) != {m['record'] for m, _ in prior}:
        raise ValueError('missing/extra completed AI week')
    for meta, base in prior:
        path, rec = chosen[meta['record']]
        if rec['actions']['source'] != {'t22_record': meta['record'], 't22_record_sha256': meta['record_sha256'],
                                      't22_cases_sha256': meta['cases_sha256']}:
            raise ValueError('T22 provenance differs')
        if rec['start_state'] != base['start_state'] or rec['actions']['game_files'] != base['actions']['game_files']:
            raise ValueError('original state/game identity differs')
        rows = cases_for(contests.outputs(rec)['calls'], contests.outputs(base)['calls'], meta['week'])
        obs = {o['field']: o['value'] for o in rec['observations']}
        fixture = ROOT/obs['fixture path']
        if fixture.parent != FIXTURES or contests.sha(fixture) != obs['fixture sha256'] or not placement.same_json(contests.events(fixture), rows):
            raise ValueError('AI fixture differs')
        helpers = list(e for c in rows for e in flatten(c['helpers']))
        records.append({'record': match.rel(path), 'record_sha256': contests.sha(path), 'cases': fixture.name,
                        'cases_sha256': contests.sha(fixture), 'week': meta['week'], 'calls': len(rows),
                        'draws': sum(c['draw_end']-c['draw_start'] for c in rows),
                        'helpers': {k: sum(e['kind'] == k for e in helpers) for k in sorted({v[1] for v in SITES.values()})},
                        'producer_commit': rec['code_commit']})
    return {'schema': 'ai-selection-corpus/1', 'records': records, 'weeks': len(records),
            'calls': sum(r['calls'] for r in records), 'draws': sum(r['draws'] for r in records),
            't22_index_sha256': contests.sha(sub.FIXTURES/'index.json')}


def run():
    import cycle, guest, unicorn
    if match.git('status', '--porcelain', '--', 'runtime/emul'):
        raise SystemExit('commit observer before capture')
    commit = match.git('rev-parse', 'HEAD'); have = selected_runs()
    RUNS.mkdir(parents=True, exist_ok=True); FIXTURES.mkdir(parents=True, exist_ok=True)
    for meta, base in sources():
        if meta['record'] in have:
            print('already recorded '+meta['record'], flush=True); continue
        _, data = match.find_state(base['start_state']['sha256'])
        started = match.utc(); week = match.Week(data); recorder = Recorder(week)
        rows, lines, status = [], [], 'completed'
        try:
            week.play()
            if week.g.unsupported or recorder.pending is not None or not placement.same_json(recorder.legacy.calls, contests.outputs(base)['calls']):
                raise ValueError('incomplete capture or retained T22 differs')
            t20 = json.loads((ROOT/base['actions']['source']['t20_record']).read_text())
            if not placement.same_json(recorder.legacy.legacy.calls, contests.outputs(t20)['calls']) or not placement.same_json(recorder.legacy.legacy.ledger, contests.outputs(t20)['ledger']):
                raise ValueError('retained T20 differs')
            t16 = next(b for m, p, sc, x, b, pre in sub.sources() if m['record'] == base['actions']['source']['t20_record'])
            if not placement.same_json(recorder.legacy.legacy.tail.calls, contests.outputs(t16)['calls']):
                raise ValueError('retained T16 differs')
            source = t16['actions']['source']; trace = contests.events(ROOT/source['trace'])
            if week.events != trace[1:-1]:
                raise ValueError('new original week differs from T08')
            ok, lines = match.compare(week.events, source['start_state_sha256'], ROOT/source['t04_record_path'])
            if not ok:
                raise ValueError('ordered DOSBox-X comparison failed')
            rows = cases_for(recorder.calls, contests.outputs(base)['calls'], meta['week'])
        except (Exception, KeyboardInterrupt) as exc:
            status = f'aborted: {type(exc).__name__}: {exc}'
        n = max(match.next_number(RUNS, 'T23-r*.json'), match.next_number(FIXTURES, 'T23-r*.jsonl'))
        rid = f'T23-r{n:04d}'; fixture = FIXTURES/(rid+'.jsonl'); placement.write_lines(fixture, rows)
        rec = copy.deepcopy(base)
        rec.update(run_id=rid, experiment='T23', arm='ai-selection', rep=n, code_commit=commit,
                   machine=cycle.machine_id(), started=started, ended=match.utc(), status=status,
                   actions={'script': 'runtime/emul/ai_selection.py',
                            'source': {'t22_record': meta['record'], 't22_record_sha256': meta['record_sha256'], 't22_cases_sha256': meta['cases_sha256']},
                            'game_files': {name: hashlib.sha256(b).hexdigest() for name, b in week.files_at_start.items()}},
                   outputs=[{'name': 'calls', 'value': recorder.calls}],
                   observations=[{'step': 0, 'source': 'file', 'field': 'fixture path', 'value': match.rel(fixture)},
                                 {'step': 0, 'source': 'file', 'field': 'fixture sha256', 'value': contests.sha(fixture)},
                                 {'step': 1, 'source': 'log', 'field': 'ordered DOSBox-X comparison', 'value': '\n'.join(lines)}])
        rec['runtime'] = {'harness': f'runtime/emul/ai_selection.py@{commit}', 'unicorn': unicorn.__version__,
                          'python': platform.python_version(), 'dos_clock': week.g.clock,
                          'settings': {k: getattr(guest, k) for k in ('INSTR_PER_S', 'KEY_HOLD', 'PIT_HZ', 'SLICE_MAX')}}
        rec['interventions'] = [{'level': 'I3', 'what': 'guest.py services and read-only AI selection hooks'}]
        match.write_record(RUNS/(rid+'.json'), rec)
        print(f'{rid}: {status}; {len(rows)} A94B cases', flush=True)
        if status != 'completed':
            raise SystemExit(1)
    (FIXTURES/'index.json').write_text(json.dumps(build_index(), indent=2)+'\n')


def main(argv=None):
    ap = argparse.ArgumentParser(description=__doc__)
    m = ap.add_mutually_exclusive_group(required=True)
    m.add_argument('--run', action='store_true'); m.add_argument('--check', action='store_true')
    args = ap.parse_args(argv)
    if args.run:
        run(); return 0
    try:
        index = build_index()
        if (index['weeks'], index['calls'], index['draws']) != (6, 556, 0):
            raise ValueError('incomplete original AI coverage')
        if not placement.same_json(index, json.loads((FIXTURES/'index.json').read_text())):
            raise ValueError('AI index differs')
    except (ValueError, OSError, KeyError, TypeError, StopIteration) as exc:
        print(f'AI selection check: FAIL: {exc}'); return 1
    print(f'AI selection check: ok ({index["calls"]} calls, {index["draws"]} draws)')
    return 0


if __name__ == '__main__':
    raise SystemExit(main())
