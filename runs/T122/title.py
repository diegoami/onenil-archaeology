#!/usr/bin/env python3
"""T122: the league fixture-title presentation pair at 1B55:142B.

The T100 league machine reaches the title call deep in the match. One PLAY
GAME key starts it; a code hook at 1B55:142B stops at the first title call. The
arguments are stack bytes: week at SP+4, stage at SP+6, the output far pointer
at SP+8; the caller is the return address and the ABI is the output pointer
against SS and BP-0x106.

    python3 runs/T122/title.py --run <savestate> --record runs/T122/title-r0001.json
    python3 runs/T122/title.py --check runs/T122/title-r0001.json
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
SITE = '1B55:142B'


def sha(data):
    return hashlib.sha256(data).hexdigest()


def capture(data):
    if sha(data) != STATE_SHA:
        raise ValueError('start RAM identity differs')
    week = LeagueWeek(data)
    g = week.g
    seen = {}

    class Done(Exception):
        pass

    def hook(g):
        ss, sp = g.reg('ss'), g.reg('sp')
        seen.update(
            week=g.mem(ss * 16 + sp + 4, 1)[0],
            stage=g.mem(ss * 16 + sp + 6, 1)[0],
            output_offset=g.word_at(ss * 16 + sp + 8),
            output_segment=g.word_at(ss * 16 + sp + 10),
            caller_ip=g.word_at(ss * 16 + sp),
            caller_cs=g.word_at(ss * 16 + sp + 2),
            ss=ss, bp=g.reg('bp'))
        raise Done()

    g.code_hook(SITE, hook)
    g.press('Return')
    try:
        g.run(max_steps=400_000_000)
    except Done:
        pass
    if not seen:
        raise ValueError('the title call was not reached')
    if seen['output_segment'] != seen['ss']:
        raise ValueError('title output segment differs from SS')
    if seen['output_offset'] != (seen['bp'] - 0x106) & 0xFFFF:
        raise ValueError('title output offset differs from BP-0x106')
    return seen


def validate(record):
    if record['schema'] != 'league-fixture-title/1' or record['status'] != 'completed':
        raise ValueError('incomplete title record')
    if record['source']['state_sha256'] != STATE_SHA:
        raise ValueError('savestate identity differs')
    if record['source']['t100_receipt_sha256'] != sha(T100_RECEIPT.read_bytes()):
        raise ValueError('T100 receipt identity differs')
    call = record['call']
    if call['site'] != SITE:
        raise ValueError('site differs')
    if (call['week'], call['stage']) != (54, 0):
        raise ValueError('the league pair differs from the captured one')
    if call['caller_ip_image'] != '0AB9:D75D':
        raise ValueError('caller differs')
    if call['output_segment'] != call['ss'] or call['output_offset'] != (call['bp'] - 0x106) & 0xFFFF:
        raise ValueError('ABI checks differ')


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
        data = args.run.read_bytes()
        observed = capture(data)
        receipt = json.loads(T100_RECEIPT.read_text())
        record = dict(
            schema='league-fixture-title/1', issue=281, task='T122', status='completed',
            source=dict(state_sha256=STATE_SHA, state_size=len(data),
                        t100_receipt_sha256=sha(T100_RECEIPT.read_bytes()),
                        receipt_screen_sha256=receipt['preparation']['screen_sha256']),
            call=dict(site=SITE, week=observed['week'], stage=observed['stage'],
                      caller_ip_image='0AB9:D75D',
                      caller_cs=observed['caller_cs'], caller_ip=observed['caller_ip'],
                      output_offset=observed['output_offset'],
                      output_segment=observed['output_segment'],
                      bp=observed['bp'], ss=observed['ss'],
                      keys=['Return']),
            scope='First title call only; the arguments are stack bytes and the '
                  "caller/ABI checks are the fresh case's own.")
        validate(record)
        args.record.parent.mkdir(parents=True, exist_ok=True)
        args.record.write_text(json.dumps(record, indent=1) + '\n')
        print('recorded title pair', record['call']['week'], record['call']['stage'])
        return
    record = json.loads(args.check.read_text())
    validate(record)
    print('the league fixture-title pair and bindings: ready')


if __name__ == '__main__':
    main()
