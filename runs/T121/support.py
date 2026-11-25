#!/usr/bin/env python3
"""T121: the league machine's incoming support facts.

The T100 league preparation machine drives the original to its first watched
entry (0AB9:7C67) with the one observed PLAY GAME key; no match play follows.
At that entry this publishes the admitted incoming domains the native prepared
watcher consumes - the DS ranges/cells and the config and counts areas - so the
engine stops asking for bytes that only the original owned. Values are the
image's own; nothing is inferred. Private bytes never enter git.

    python3 runs/T121/support.py --run <savestate> --record runs/T121/support-r0001.json
    python3 runs/T121/support.py --check runs/T121/support-r0001.json
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
ENTRY_SITE = '0AB9:7C67'
# [confirmed: native prepared::support_cells] The incoming domains the engine
# admits. Everything else - players, scenes, ball, queue, seed, ABI - is owned
# by the setup or refused.
DS_RANGES = ((0xD144, 0xD148), (0xD1D4, 0xD1DC), (0x0D34, 0x0D36), (0x0D5C, 0x0D5E),
             (0xD0A6, 0xD0AC), (0x09FB, 0x0B5A), (0x097A, 0x09BE), (0x0D36, 0x0D56),
             (0x0BF6, 0x0C68), (0x0CD7, 0x0CE0), (0x0D60, 0x0D91), (0x0D92, 0x0E6A),
             (0x0F20, 0x0F30), (0x1274, 0x1288), (0x129E, 0x12CE), (0x8708, 0x8716),
             (0x935B, 0xA51C), (0xD886, 0xD936))
DS_CELLS = (0xD084, 0xD09E, 0xD0B6, 0xD0BD, 0xD1C9, 0xE5DD, 0xCF5A, 0xCF5B)
CONFIG_EXCLUDED = (0, 1, 2, 0xF2, 0xF6)
COUNT_LIMIT = 4004


def sha(data):
    return hashlib.sha256(data).hexdigest()


def domains():
    result = [('ds', o) for o in sorted({o for lo, hi in DS_RANGES for o in range(lo, hi)} | set(DS_CELLS))]
    result += [('config', o) for o in range(256) if o not in CONFIG_EXCLUDED]
    result += [('counts', o) for o in range(COUNT_LIMIT)]
    return result


def admitted(area, offset):
    if type(area) is not str or type(offset) is not int or offset < 0:
        return False
    if area == 'ds':
        return offset in DS_CELLS or any(lo <= offset < hi for lo, hi in DS_RANGES)
    if area == 'config':
        return offset < 256 and offset not in CONFIG_EXCLUDED
    if area == 'counts':
        return offset < COUNT_LIMIT
    return False


def capture(data):
    if sha(data) != STATE_SHA:
        raise ValueError('start RAM identity differs')
    week = LeagueWeek(data)
    g = week.g
    seen = {}

    class Done(Exception):
        pass

    def hook(g):
        seen['screen'] = g.screen()
        raise Done()

    g.code_hook(ENTRY_SITE, hook)
    g.press('Return')
    try:
        g.run(max_steps=400_000_000)
    except Done:
        pass
    if 'screen' not in seen:
        raise ValueError('the machine did not reach the first watched entry')
    facts = []
    far = dict(config=g.far(0xD7D2), counts=g.far(0xDCC8))
    for area, offset in domains():
        base = g.DS * 16 if area == 'ds' else far[area] * 16
        facts.append(dict(area=area, offset=offset, value=g.mem(base + offset, 1)[0]))
    if len({(f['area'], f['offset']) for f in facts}) != len(facts):
        raise ValueError('duplicate incoming fact')
    if any(not admitted(f['area'], f['offset']) or not 0 <= f['value'] <= 255 for f in facts):
        raise ValueError('incoming fact outside the admitted domains')
    return dict(screen=dict(text_sha256=sha(seen['screen'].text().encode()),
                            screen_sha256=seen['screen'].digest()),
                facts=facts)


def validate(record):
    if record['schema'] != 'league-incoming-support/1' or record['status'] != 'completed':
        raise ValueError('incomplete league support record')
    if record['source']['state_sha256'] != STATE_SHA:
        raise ValueError('savestate identity differs')
    if record['source']['t100_receipt_sha256'] != sha(T100_RECEIPT.read_bytes()):
        raise ValueError('T100 receipt identity differs')
    if record['entry']['site'] != ENTRY_SITE or len(record['entry']['screen_sha256']) != 64:
        raise ValueError('entry binding differs')
    facts = record['facts']
    if not facts:
        raise ValueError('no incoming facts')
    seen = set()
    for fact in facts:
        if set(fact) != {'area', 'offset', 'value'}:
            raise ValueError('fact shape differs')
        if not admitted(fact['area'], fact['offset']):
            raise ValueError('fact outside the admitted domain')
        if type(fact['value']) is not int or not 0 <= fact['value'] <= 255:
            raise ValueError('fact value outside the byte domain')
        key = fact['area'], fact['offset']
        if key in seen:
            raise ValueError('duplicate fact')
        seen.add(key)
    if len(facts) != len(domains()):
        raise ValueError('fact census differs')


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
        capture_values = capture(data)
        receipt = json.loads(T100_RECEIPT.read_text())
        record = dict(
            schema='league-incoming-support/1', issue=280, task='T121',
            status='completed',
            source=dict(state_sha256=STATE_SHA, state_size=len(data),
                        state_path=args.run.relative_to(ROOT).as_posix() if args.run.is_relative_to(ROOT) else str(args.run),
                        t100_receipt_sha256=sha(T100_RECEIPT.read_bytes()),
                        receipt_screen_sha256=receipt['preparation']['screen_sha256']),
            entry=dict(site=ENTRY_SITE, keys=['Return'], **capture_values['screen']),
            facts=capture_values['facts'],
            scope='Incoming domains at the first watched entry only; results and '
                  'fixtures areas are not published here, and no match play follows.')
        validate(record)
        args.record.parent.mkdir(parents=True, exist_ok=True)
        args.record.write_text(json.dumps(record, indent=1) + '\n')
        print('recorded', len(record['facts']), 'incoming facts at the first entry')
        return
    record = json.loads(args.check.read_text())
    validate(record)
    saved = record['source'].get('state_path')
    if saved:
        path = ROOT / saved
        if path.is_file() and sha(path.read_bytes()) == STATE_SHA:
            rebuilt = capture(path.read_bytes())
            if (rebuilt['facts'] != record['facts']
                    or rebuilt['screen']['text_sha256'] != record['entry']['text_sha256']
                    or rebuilt['screen']['screen_sha256'] != record['entry']['screen_sha256']):
                raise ValueError('the private state no longer yields the recorded facts')
    print('the league incoming support and', len(record['facts']), 'facts: ready')


if __name__ == '__main__':
    main()
