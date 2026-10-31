#!/usr/bin/env python3
"""T24: verify AEB8 direct call boundaries and retained T23 replacement provenance."""
import argparse
import hashlib
import json
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT/'runtime/emul'))
import ai_selection as ai

LISTING = ROOT/'static/1-0-exe/code/seg_0AB9_17.asm'
MAP = ROOT/'static/1-0-exe/replacement-boundaries.json'
ROLES = {
    'AEDF': ('outgoing-flag', 'bit 3; outgoing scene player flags11'),
    'AEF0': ('managed-side', 'side club identifier'),
    'AF01': ('speaker-off', 'A2EC gate and port 61h; no explicit arguments'),
    'AF18': ('managed-opponent', 'opposite side club identifier'),
    'AF5F': ('message', 'outgoing player; post-swap roster at normalized scene slot'),
    'AF7F': ('log', '0; incoming roster slot; normalized scene slot; side byte'),
    'AFAA': ('rebuild', 'scene pointer; physical scene index'),
    'AFB7': ('byte6-cache', 'scene pointer; cache flag 1; signed delta 1'),
    'AFDA': ('rating-flags', 'incoming scene player'),
    'B00C': ('season-counter', 'incoming scene player'),
    'B077': ('managed-cache-side', 'loop side club identifier'),
    'B08B': ('keeper-availability', 'loop side CF5E cached player'),
    'B0C6': ('club-cache-refresh', 'no explicit arguments'),
}


def boundaries(text):
    instructions = []
    for line in text.splitlines():
        m = re.match(r'^([0-9A-F]{4})  ((?:[0-9A-F]{2} )+)\s*(.*)', line)
        if m and 0xAEB8 <= int(m[1], 16) <= 0xB0F2:
            instructions.append((m[1], bytes.fromhex(m[2]), m[3]))
    rows = []
    for i, (site, code, asm) in enumerate(instructions):
        if not asm.startswith('call '):
            continue
        if site not in ROLES:
            raise ValueError('unclassified direct call')
        target = asm[5:].removeprefix('far ')
        if ':' not in target:
            target = f'0AB9:{int(target, 16)&65535:04X}'
        following = f'{(int(site,16)+len(code))&65535:04X}'
        if i+1 == len(instructions) or instructions[i+1][0] != following:
            raise ValueError('missing following instruction')
        role, arguments = ROLES[site]
        rows.append({'site': '0AB9:'+site, 'return': '0AB9:'+following,
                     'target': target, 'instruction_sha256': hashlib.sha256(code).hexdigest(),
                     'role': role, 'arguments': arguments})
    if [r['site'][5:] for r in rows] != list(ROLES):
        raise ValueError('missing/reordered direct call map')
    return rows


def corpus():
    index = ai.build_index()
    if not ai.placement.same_json(index, json.loads((ai.FIXTURES/'index.json').read_text())):
        raise ValueError('retained T23 index differs')
    rows = []
    for meta in index['records']:
        rec = json.loads((ROOT/meta['record']).read_text())
        calls = ai.contests.outputs(rec)['calls']
        effects = [e for c in calls for e in ai.flatten(c['helpers']) if e['kind']=='replace']
        rows.append({'record': meta['record'], 'record_sha256': meta['record_sha256'],
                     'cases_sha256': meta['cases_sha256'], 'replacements': len(effects),
                     'arguments': [e['arguments'] for e in effects]})
    if len(rows)!=6 or sum(r['replacements'] for r in rows)!=25:
        raise ValueError('incomplete retained replacement coverage')
    return {'index_sha256': ai.contests.sha(ai.FIXTURES/'index.json'), 'weeks': rows}


def build():
    return {'schema':'replacement-boundaries/1', 'listing': str(LISTING.relative_to(ROOT)),
            'listing_sha256': ai.contests.sha(LISTING),
            'boundaries': boundaries(LISTING.read_text()), 'retained_t23': corpus()}


def check(actual, expected):
    if not ai.placement.same_json(actual, expected):
        raise ValueError('replacement map or retained provenance differs')


def main(argv=None):
    ap=argparse.ArgumentParser(description=__doc__)
    m=ap.add_mutually_exclusive_group(required=True)
    m.add_argument('--write',action='store_true'); m.add_argument('--check',action='store_true')
    args=ap.parse_args(argv)
    try:
        value=build()
        if args.write:
            MAP.write_text(json.dumps(value,indent=2)+'\n')
        else:
            check(json.loads(MAP.read_text()),value)
    except (ValueError,OSError,KeyError,TypeError) as exc:
        print('replacement boundary check: FAIL:',exc); return 1
    print('replacement boundary check: ok (13 direct calls, 25 retained replacements)')
    return 0


if __name__=='__main__':
    raise SystemExit(main())
