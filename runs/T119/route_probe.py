#!/usr/bin/env python3
"""T119 milestone 1, the route probe: can the T100 preparation screen return to
the management menu?

The T100 machine requests Watch off, so the watched admission needs Watch turned
on through Game configuration first. That needs a route off the preparation
screen. This probe delivers one Escape - the observed backtrack key - and
records whether the screen changes. It does not scan for a different key: an
unobserved route would not be evidence.

    python3 runs/T119/route_probe.py            write the record
    python3 runs/T119/route_probe.py --check    re-read it
"""
import argparse
import hashlib
import json
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / 'runtime' / 'emul'))
import guest  # noqa: E402
from league_week import LeagueWeek  # noqa: E402

RECORD = ROOT / 'runs/T119/route-probe-r0001.json'
T100_RECEIPT = ROOT / 'runs/T100/preparation-r0001.json'
STATE_SHA = '3abfd6b00f8024900b93a20d1ff1eec60cfd2d570e927a00eca495d7f7b1d1c8'


def sha(data):
    return hashlib.sha256(data).hexdigest()


def find_state():
    for path in sorted((ROOT / '.cache' / 'states').rglob('*.sav')):
        if sha(path.read_bytes()) == STATE_SHA:
            return path
    raise SystemExit('the T100 savestate is not under .cache/states')


def build():
    path = find_state()
    data = path.read_bytes()
    week = LeagueWeek(data)
    start = week.g.screen()
    week.g.press('Escape')
    if not week.g.run(max_steps=400_000_000):
        raise SystemExit('no key wait after Escape')
    after = week.g.screen()
    if week.g.unsupported:
        raise SystemExit('unsupported guest services')
    receipt = json.loads(T100_RECEIPT.read_text())
    return dict(
        schema='league-route-probe-1/1', issue=277, task='T119',
        state=dict(path=path.relative_to(ROOT).as_posix(), sha256=STATE_SHA),
        start=dict(text_sha256=sha(start.text().encode()), screen_sha256=start.digest()),
        keys=['Escape'],
        after=dict(text_sha256=sha(after.text().encode()), screen_sha256=after.digest()),
        binding=dict(receipt=T100_RECEIPT.relative_to(ROOT).as_posix(),
                     receipt_sha256=sha(T100_RECEIPT.read_bytes()),
                     step=receipt['preparation']['step'],
                     screen_sha256=receipt['preparation']['screen_sha256']),
        conclusion='Escape leaves the T100 preparation screen unchanged: the '
                   'screen, the highlight and the text are identical, so the '
                   'harness cannot reach the management menu to turn Watch on.',
        scope='One observed backtrack key only; no other key is scanned.')


def check():
    stored = json.loads(RECORD.read_text())
    receipt = json.loads(T100_RECEIPT.read_text())
    if stored['schema'] != 'league-route-probe-1/1':
        raise SystemExit('the probe schema differs')
    if stored['binding']['receipt_sha256'] != sha(T100_RECEIPT.read_bytes()):
        raise SystemExit('the T100 receipt differs')
    if stored['start']['screen_sha256'] != receipt['preparation']['screen_sha256']:
        raise SystemExit('the start screen is not the T100 preparation')
    if stored['after'] != stored['start']:
        raise SystemExit('the recorded Escape did change the screen; the route needs re-examination')
    path = ROOT / stored['state']['path']
    if path.exists() and sha(path.read_bytes()) == STATE_SHA:
        rebuilt = build()
        if (rebuilt['start'], rebuilt['after']) != (stored['start'], stored['after']):
            raise SystemExit('the live probe differs from the record')
    print('the T100 preparation screen ignores Escape: route blocked (recorded)')


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--check', action='store_true')
    args = parser.parse_args()
    if args.check:
        check()
        return
    record = build()
    if RECORD.exists():
        raise SystemExit('the probe record already exists')
    RECORD.write_text(json.dumps(record, indent=1) + '\n')
    print('route probe written:', RECORD.relative_to(ROOT))


if __name__ == '__main__':
    sys.exit(main())
