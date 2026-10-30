#!/usr/bin/env python3
"""T18: read the reached raw D0B cell omitted by T17; preserve T17 verbatim."""
import argparse
import copy
import hashlib
import json
import platform

import contests
import extra_event
import match
import placement

ROOT = contests.ROOT
RUNS, FIXTURES = ROOT / 'runs/T18', ROOT / 'traces/T18'


def sources():
    index = json.loads((ROOT / 'traces/T17/index.json').read_text())
    result = []
    for meta in index['records']:
        if not meta['calls']: continue
        path = ROOT / meta['record']
        fixture = ROOT / 'traces/T17' / meta['cases']
        if contests.sha(path) != meta['record_sha256'] or contests.sha(fixture) != meta['cases_sha256']:
            raise ValueError('retained T17 source digest differs')
        rec = json.loads(path.read_text())
        if rec['status'] != 'completed' or len(contests.outputs(rec)['calls']) != meta['calls']:
            raise ValueError('incomplete retained T17 source')
        result.append((meta, rec))
    return result


def cases_for(cells, meta, original):
    calls = contests.outputs(original)['calls']
    if len(cells) != len(calls): raise ValueError('missing supplementary cell')
    result = []
    for c, old in zip(cells, calls):
        if not isinstance(c, dict) or set(c) != {'step', 'draw_start', 'seed', 'offset', 'value'}:
            raise ValueError('incomplete supplementary input fields')
        for k, v in c.items():
            high = 255 if k == 'value' else 2**32 if k == 'draw_start' else 65535
            if not placement.integer(v, 0, high): raise ValueError('mistyped or out-of-range cell')
        if (c['step'] != old['step'] or c['draw_start'] != old['draw_start']
                or c['seed'] != old['input']['seed'] or c['offset'] != 0x0D0B):
            raise ValueError('supplementary cell identity differs')
        result.append({'schema': 'extra-event-input/1', **c, 'source': {
            't17_record': meta['record'], 't17_record_sha256': meta['record_sha256'],
            't17_cases': meta['cases'], 't17_cases_sha256': meta['cases_sha256']}})
    return result


def selected_runs():
    chosen = {}
    for p in sorted(RUNS.glob('T18-r*.json')):
        rec = json.loads(p.read_text())
        if rec['status'] != 'completed': continue
        key = rec['actions']['source']['t17_record']
        if key in chosen: raise ValueError('duplicate completed supplementary week')
        chosen[key] = p, rec
    return chosen


def build_index():
    chosen, entries = selected_runs(), []
    original = sources()
    if set(chosen) != {m['record'] for m, _ in original}: raise ValueError('missing/extra supplementary week')
    for meta, old in original:
        path, rec = chosen[meta['record']]
        rows = cases_for(contests.outputs(rec)['cells'], meta, old)
        if rec['start_state'] != old['start_state'] or rec['actions']['game_files'] != old['actions']['game_files']:
            raise ValueError('supplement state/game identities differ')
        obs = {o['field']: o['value'] for o in rec['observations']}
        fixture = ROOT / obs['fixture path']
        if (fixture.parent != FIXTURES or contests.sha(fixture) != obs['fixture sha256']
                or not placement.same_json(contests.events(fixture), rows)):
            raise ValueError('supplement fixture differs')
        entries.append({'record': match.rel(path), 'record_sha256': contests.sha(path),
                        'cases': fixture.name, 'cases_sha256': contests.sha(fixture),
                        'cells': len(rows), 'week': old['actions']['source']['t04_record'],
                        't17_record': meta['record'], 't17_record_sha256': meta['record_sha256'],
                        'producer_commit': rec['code_commit']})
    return {'schema': 'extra-event-inputs/1', 'records': entries, 'cells': sum(e['cells'] for e in entries),
            'weeks': len(entries), 't17_index_sha256': contests.sha(ROOT / 'traces/T17/index.json')}


def run():
    import cycle
    import guest
    import unicorn
    if match.git('status', '--porcelain', '--', 'runtime/emul'): raise SystemExit('commit observer before capture')
    commit = match.git('rev-parse', 'HEAD')
    RUNS.mkdir(parents=True, exist_ok=True); FIXTURES.mkdir(parents=True, exist_ok=True)
    have = selected_runs()
    for meta, old in sources():
        if meta['record'] in have:
            print('already recorded ' + meta['record'], flush=True); continue
        source = old['actions']['source']
        path, data = match.find_state(source['start_state_sha256'])
        started = match.utc(); week = match.Week(data); recorder = extra_event.Recorder(week)
        cells, rows, lines, status = [], [], [], 'completed'
        def observe(g):
            if recorder.tail.active:
                cells.append({'step': len(recorder.tail.calls) - 1, 'draw_start': week.draws,
                              'seed': extra_event.seed(g), 'offset': 0x0D0B, 'value': g.rd(0x0D0B, 1)})
        week.g.code_hook('0AB9:DBC6', observe)
        try:
            week.play()
            if (week.g.unsupported or recorder.pending is not None or recorder.helper is not None
                    or not placement.same_json(recorder.calls, contests.outputs(old)['calls'])):
                raise ValueError('new original DBC6 stream differs from T17')
            trace = contests.events(ROOT / source['trace'])
            if week.events != trace[1:-1]: raise ValueError('new original week differs from T08')
            ok, lines = match.compare(week.events, source['start_state_sha256'], ROOT / source['t04_record_path'])
            if not ok: raise ValueError('ordered DOSBox-X comparison failed')
            rows = cases_for(cells, meta, old)
        except (Exception, KeyboardInterrupt) as exc:
            status = f'aborted: {type(exc).__name__}: {exc}'
        number = max(match.next_number(RUNS, 'T18-r*.json'), match.next_number(FIXTURES, 'T18-r*.jsonl'))
        rid = f'T18-r{number:04d}'; fixture = FIXTURES / (rid + '.jsonl')
        placement.write_lines(fixture, rows)
        rec = copy.deepcopy(old)
        rec.update(run_id=rid, experiment='T18', arm='dbc6-input-cell', rep=number, code_commit=commit,
                   machine=cycle.machine_id(), started=started, ended=match.utc(), status=status,
                   actions={'script': 'runtime/emul/extra_event_inputs.py',
                            'source': {'t17_record': meta['record'], 't17_record_sha256': meta['record_sha256']},
                            'game_files': {name: hashlib.sha256(raw).hexdigest() for name, raw in week.files_at_start.items()}},
                   outputs=[{'name': 'cells', 'value': cells}],
                   observations=[{'step': 0, 'source': 'file', 'field': 'fixture path', 'value': match.rel(fixture)},
                                 {'step': 0, 'source': 'file', 'field': 'fixture sha256', 'value': contests.sha(fixture)},
                                 {'step': 1, 'source': 'log', 'field': 'ordered DOSBox-X comparison', 'value': '\n'.join(lines)}])
        rec['runtime'] = {'harness': f'runtime/emul/extra_event_inputs.py@{commit}', 'unicorn': unicorn.__version__,
                          'python': platform.python_version(), 'dos_clock': week.g.clock,
                          'settings': {k: getattr(guest, k) for k in ('INSTR_PER_S', 'KEY_HOLD', 'PIT_HZ', 'SLICE_MAX')}}
        rec['interventions'] = [{'level': 'I3', 'what': 'guest.py services and read-only DBC6/D0B hooks'}]
        match.write_record(RUNS / (rid + '.json'), rec)
        print(f'{rid}: {status}, {len(rows)} raw input cells', flush=True)
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
        if (index['weeks'], index['cells']) != (2, 184): raise ValueError('two weeks and184 cells required')
        if not placement.same_json(index, json.loads((FIXTURES / 'index.json').read_text())):
            raise ValueError('supplement index differs')
    except (ValueError, OSError, KeyError, TypeError, StopIteration) as exc:
        print(f'extra-event-input check: FAIL: {exc}'); return 1
    print('extra-event-input check: ok (184 original cells, two weeks)'); return 0


if __name__ == '__main__':
    raise SystemExit(main())
