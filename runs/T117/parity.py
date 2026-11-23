#!/usr/bin/env python3
"""T117 milestone 2, the parity check: the harness's league week equals the
DOSBox week. The parity run (runtime/emul/league_week.py, match.py's closed
loop from the T100 preparation machine) produced runs/T117/T117-r0001.json and
its trace; this checker requires, from the committed bytes alone:

1. the run completed, its full-time board's goals equal the T102 receipt's
   score (Newcastle Utd 2 - 0 Blackburn R), and the board's text-page digest is
   byte-identical to the T102 receipt's full-time screen;
2. every settled week screen the T102 receipt records - half-time, full-time,
   league results, league table, cash flow, transfer news, management - appears
   among the trace's text-page digests, in receipt order (an ordered
   subsequence: the harness may interleave extra key-wait screens, but never a
   different order);
3. the trace binds the run: its start event carries the T100 state sha, and its
   end event's draw and screen counts equal the record's;
4. the week wrote the game's save file (the first harness-written
   post-league28 machine; no DOSBox counterpart was ever recorded, so only its
   presence and size bind).

--check re-reads the record, the trace and the T102 receipt and prints ready."""
import argparse
import hashlib
import json
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
RECORD = ROOT / 'runs/T117/T117-r0001.json'
TRACE = ROOT / 'traces/T117/3abfd6b00f802490-week-r0001.jsonl'
T102_RECEIPT = ROOT / 'runs/T102/week-r0001.json'
STATE_SHA = '3abfd6b00f8024900b93a20d1ff1eec60cfd2d570e927a00eca495d7f7b1d1c8'


def sha(data):
    return hashlib.sha256(data).hexdigest()


def trace_screens():
    digests, start, end = [], None, None
    with TRACE.open() as f:
        for line in f:
            event = json.loads(line)
            if event.get('kind') == 'screen':
                digests.append(event['digest'])
            elif event.get('kind') == 'start':
                start = event
            elif event.get('kind') == 'end':
                end = event
    return digests, start, end


def build():
    record = json.loads(RECORD.read_text())
    if record['status'] != 'completed':
        raise SystemExit(f"the run's status is {record['status']!r}")
    t102 = json.loads(T102_RECEIPT.read_text())

    end = next(o['value'] for o in record['outputs'] if o['name'] == 'end')
    result = end['result']
    score = t102['score']

    # 1. the full-time board: the goals, and the board itself byte-identical
    goals_ok = result['goals'] == [score['home_goals'], score['away_goals']]
    board_ok = result['board_digest'] == next(
        s['screen_sha256'] for s in t102['screens'] if s['id'] == 'S007-full-time')
    if not goals_ok:
        raise SystemExit(f"the score differs: the harness has {result['goals']}, "
                         f'the T102 receipt {[score["home_goals"], score["away_goals"]]}')
    if not board_ok:
        raise SystemExit('the full-time board is not byte-identical to the '
                         'T102 receipt\'s screen')

    # 2. the settled week screens, in receipt order, in the trace
    digests, start, end_event = trace_screens()
    if not TRACE.exists():
        raise SystemExit('the trace is absent')
    placements = []
    cursor = 0
    for screen in t102['screens']:
        want = screen['screen_sha256']
        while cursor < len(digests) and digests[cursor] != want:
            cursor += 1
        if cursor == len(digests):
            raise SystemExit(f"{screen['id']} ({want[:16]}) never appeared in "
                             f'the trace in order')
        placements.append(dict(id=screen['id'], screen_sha256=want,
                               key_wait=cursor))
        cursor += 1

    # 3. the trace binds the run
    if start['state_sha256'] != STATE_SHA:
        raise SystemExit('the trace starts from another state')
    if end_event['draws'] != end['draws'] or end_event['screens'] != end['screens']:
        raise SystemExit('the trace end disagrees with the record')

    # 4. the week wrote the game's save
    saves = [f for f in end['files_written'] if f['name'] == 'SAVE1.1-0']
    if len(saves) != 1 or saves[0]['size'] != 194426:
        raise SystemExit(f'the week did not write the named save: {saves!r}')

    return dict(
        schema='harness-league-parity-1/1', issue=273, task='T117',
        record=dict(path=RECORD.relative_to(ROOT).as_posix(),
                    code_commit=record['code_commit'],
                    status=record['status']),
        trace=dict(path=TRACE.relative_to(ROOT).as_posix(),
                   sha256=sha(TRACE.read_bytes()),
                   state_sha256=start['state_sha256'],
                   draws=end_event['draws'], screens=end_event['screens']),
        result=dict(goals=result['goals'], board_digest=result['board_digest']),
        t102_binding=dict(receipt=T102_RECEIPT.relative_to(ROOT).as_posix(),
                          score_goals=[score['home_goals'], score['away_goals']],
                          full_time_screen=next(s['screen_sha256'] for s in t102['screens']
                                                if s['id'] == 'S007-full-time')),
        screens_in_order=placements,
        save_written=dict(name='SAVE1.1-0', sha256=saves[0]['sha256'],
                          size=saves[0]['size'],
                          note='the first harness-written post-league28 machine; '
                               'no DOSBox counterpart was ever recorded'),
        scope='The harness reproduced the DOSBox league week: the full-time '
              'board is byte-identical and every settled week screen appears '
              'in order with the same text-page digest.')


def differs(stored, rebuilt, path=''):
    if isinstance(stored, dict) and isinstance(rebuilt, dict):
        for key in stored:
            differs(stored[key], rebuilt.get(key), path + '/' + key)
        return
    if isinstance(stored, list) and isinstance(rebuilt, list):
        if len(stored) != len(rebuilt):
            raise SystemExit(f"the record's {path or 'root'} differs (length)")
        for i, (a, b) in enumerate(zip(stored, rebuilt)):
            differs(a, b, f'{path}[{i}]')
        return
    if stored == rebuilt:
        return
    raise SystemExit(f"the record's {path or 'root'} differs from the re-read run")


def main():
    ap = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    ap.add_argument('--check', action='store_true')
    a = ap.parse_args()
    rebuilt = build()
    if a.check:
        if not (ROOT / 'runs/T117/parity-r0001.json').exists():
            raise SystemExit('the parity record does not exist yet')
        stored = json.loads((ROOT / 'runs/T117/parity-r0001.json').read_text())
        differs(stored, rebuilt)
        print('the harness league week equals the DOSBox week: ready')
        return 0
    out = ROOT / 'runs/T117/parity-r0001.json'
    out.write_text(json.dumps(rebuilt, indent=1) + '\n')
    print(f'record written: {out.relative_to(ROOT)}')
    return 0


if __name__ == '__main__':
    sys.exit(main())
