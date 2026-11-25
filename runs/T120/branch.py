#!/usr/bin/env python3
"""T120: the P15+6>=32 role-scoring branch in the T100 league match.

Static (listing 0AB9:1AE2..1BD3): raw P15+6 0..31 sets the baseline to
signed+1. Signed 32..127 takes the club/flag branch: the selected flag is the
byte at D1CE+D1CF indexed by (P8+0 == D6E6); a nonzero flag sets the baseline to
0, a zero flag adds 32 to an uninitialized local at SS:BP-4.

This runs the T100 machine - the same savestate T117/T119 decode - through the
league match until the high-branch calls occur, and records what the image
actually holds. It does not play a result of its own: the outcome binding is the
witnessed T102 score.

    python3 runs/T120/branch.py --run <savestate> --record runs/T120/branch-r0001.json
    python3 runs/T120/branch.py --check runs/T120/branch-r0001.json
"""
import argparse
import hashlib
import json
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / 'runtime' / 'emul'))
from league_week import LeagueWeek  # noqa: E402

STATE_SHA = '3abfd6b00f8024900b93a20d1ff1eec60cfd2d570e927a00eca495d7f7b1d1c8'
T100_RECEIPT = ROOT / 'runs/T100/preparation-r0001.json'
T102_WEEK = ROOT / 'runs/T102/week-r0001.json'
LIMIT = 20


def sha(data):
    return hashlib.sha256(data).hexdigest()


def read_far(g, offset):
    return g.word_at(g.DS * 16 + offset + 2), g.word_at(g.DS * 16 + offset)


def collect(data):
    if sha(data) != STATE_SHA:
        raise ValueError('start RAM identity differs')
    week = LeagueWeek(data)
    g = week.g
    cases = []
    calls = 0

    class Done(Exception):
        pass

    def hook(g):
        nonlocal calls
        calls += 1
        ss, sp = g.reg('ss'), g.reg('sp')
        # The near call's stack: [IP][CS][scene offset][scene segment]...
        row = g.word_at(ss * 16 + sp + 4)
        es = g.word_at(ss * 16 + sp + 6)
        player = g.word_at(es * 16 + row + 0xE)
        segment, base = read_far(g, 0xD7BE)
        p15_6 = g.mem(segment * 16 + base + 15 * player, 15)[6]
        if p15_6 < 32:
            return
        stale = g.word_at(ss * 16 + sp - 6)
        p8_segment, p8_base = read_far(g, 0xD7BA)
        p8_0 = g.mem(p8_segment * 16 + p8_base + 8 * player, 1)[0]
        selected = 1 if p8_0 == g.word_at(g.DS * 16 + 0xD6E6) else 0
        flag = g.mem(g.DS * 16 + 0xD1CE + selected, 1)[0]
        baseline = 0 if flag else stale + 0x20
        cases.append(dict(player=player, p15_6=p15_6, p8_0=p8_0, selected=selected,
                          flag=flag, stale_local=stale, baseline=baseline,
                          call=calls))
        if len(cases) >= LIMIT:
            raise Done()

    g.code_hook('0AB9:1AE2', hook)
    try:
        week.play()
    except Done:
        pass
    return cases, calls


def validate(record):
    if record['schema'] != 'role-score-high-branch/1' or record['status'] != 'completed':
        raise ValueError('incomplete high-branch record')
    if record['source']['state_sha256'] != STATE_SHA:
        raise ValueError('savestate identity differs')
    if record['source']['t100_receipt_sha256'] != sha(T100_RECEIPT.read_bytes()):
        raise ValueError('T100 receipt differs')
    week = json.loads(T102_WEEK.read_text())
    if record['outcome'] != dict(receipt=week['schema'] and 'runs/T102/week-r0001.json',
                                 score=[0, 2], opponent='Newcastle Utd'):
        raise ValueError('outcome binding differs')
    contract = record['contract']
    if contract['low'] != 'raw 0..31: baseline = signed + 1':
        raise ValueError('low contract differs')
    if contract['high_nonzero_flag'] != 'baseline = 0':
        raise ValueError('high nonzero-flag contract differs')
    if contract['high_zero_flag'] != 'baseline = uninitialized local + 32 (not established): diagnose':
        raise ValueError('high zero-flag contract differs')
    cases = record['cases']
    if not cases:
        raise ValueError('no high-branch cases')
    for case in cases:
        if set(case) != {'player', 'p15_6', 'p8_0', 'selected', 'flag', 'stale_local',
                         'baseline', 'call'}:
            raise ValueError('case shape differs')
        if case['p15_6'] < 32 or case['player'] == 0:
            raise ValueError('case is not a high raw value')
        if case['selected'] != (1 if case['p8_0'] == 122 else 0):
            raise ValueError('selected flag index differs')
        if case['flag']:
            if case['baseline'] != 0:
                raise ValueError('nonzero flag must set the baseline to 0')
        else:
            raise ValueError('a zero-flag high case needs a new contract')


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--run', type=Path)
    parser.add_argument('--record', type=Path)
    parser.add_argument('--check', type=Path)
    args = parser.parse_args()
    if args.run:
        if args.record is None:
            parser.error('--run needs --record')
        if args.record.exists():
            raise SystemExit('the record path already exists')
        cases, calls = collect(args.run.read_bytes())
        if not cases:
            raise SystemExit('no high-branch call reached')
        receipt = json.loads(T100_RECEIPT.read_text())
        record = dict(
            schema='role-score-high-branch/1', issue=278, task='T120',
            status='completed',
            source=dict(state_sha256=STATE_SHA, state_size=args.run.stat().st_size,
                        t100_receipt_sha256=sha(T100_RECEIPT.read_bytes()),
                        receipt_screen_sha256=receipt['preparation']['screen_sha256']),
            outcome=dict(receipt='runs/T102/week-r0001.json', score=[0, 2],
                         opponent='Newcastle Utd'),
            contract=dict(low='raw 0..31: baseline = signed + 1',
                          high_nonzero_flag='baseline = 0',
                          high_zero_flag='baseline = uninitialized local + 32 (not established): diagnose'),
            calls_before_stop=calls, cases=cases,
            scope='The T100 machine runs the league match only until the high-branch '
                  'calls; the witnessed T102 score is the outcome binding, not recomputed here.')
        validate(record)
        args.record.parent.mkdir(parents=True, exist_ok=True)
        args.record.write_text(json.dumps(record, indent=1) + '\n')
        print('recorded', len(cases), 'high-branch cases in', calls, 'point calls')
        return
    record = json.loads(args.check.read_text())
    validate(record)
    print('the high-branch contract and', len(record['cases']), 'cases: ready')


if __name__ == '__main__':
    main()
