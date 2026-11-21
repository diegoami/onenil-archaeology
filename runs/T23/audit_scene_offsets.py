"""[derived] T96 audit of the T23 corpus's scene-row coverage for A8A0's exclusion.

Reads the six immutable T23 records only; it runs no original code and implements
no selection rule. It answers one question for #122: does the retained corpus
distinguish the physical scene row from the side-normalized row that
`0AB9:A8BF-A8DD` computes?

`--check` pins the records by digest and asserts the audited counts.
"""
import glob
import hashlib
import json
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
RUNS = ROOT/'runs/T23'
DIGESTS = {
    'T23-r0001.json': '1f7fe8b6d4d6aa615141b8fd0be672482799a5dd86e9885d5f3d884e925b2a29',
    'T23-r0002.json': '055cfd3483556b4c784a2efd93a0a93e3e43e8b4d292b8a1ff30d29cebb8e7af',
    'T23-r0003.json': '220e2d3859ec182ac2c2c4cd3447f2e55389e7e0e6a4aa76796bafd7c8fa6dc4',
    'T23-r0004.json': '7a6790fd78fedae16a5a22f5a675b71b3668de1180ef31d428e2c40769aeb732',
    'T23-r0005.json': '54b5b25c4da06f99a8c17d245cbed2589a689edbd8fe832d82ff074913338fb2',
    'T23-r0006.json': 'ef9c68baa4f7d77447bdd2d4fd96ae55b474287cf8f6fa4fe9ba714cfccd373f',
}
EXPECTED = {
    'schema': 't23-scene-offset-audit/1',
    'issue': 122,
    'calls': 556,
    'calls_by_offset': {'0': 243, '11': 313},
    'candidate_scans': 494,
    'scans_by_offset': {'0': 211, '11': 283},
    'scans_where_readings_differ': 283,
    'distinguishing_scans': 0,
}


def records():
    found = sorted(glob.glob(str(RUNS/'T23-r*.json')))
    if len(found) != 6:
        raise SystemExit(f'expected six T23 records, found {len(found)}')
    for path in found:
        raw = Path(path).read_bytes()
        name = Path(path).name
        digest = hashlib.sha256(raw).hexdigest()
        if digest != DIGESTS[name]:
            raise SystemExit(f'{name} digest differs: {digest}')
        yield name, json.loads(raw)


def audit():
    calls = scans_by_offset = calls_by_offset = 0
    differing = distinguishing = 0
    calls_by_offset = {}
    scans_by_offset = {}
    for _, record in records():
        for call in record['outputs'][0]['value']:
            calls += 1
            side, scene = call['side'], call['scene']
            offset = call['input']['side_offsets'][side]
            calls_by_offset[offset] = calls_by_offset.get(offset, 0) + 1
            candidates = [h for h in call['helpers'] if h['kind'] == 'candidates']
            if not candidates:
                continue
            limiting = next(
                child['result'] for child in candidates[0]['children'] if child['kind'] == 'limit')
            roster = call['input']['clubs'][side]['roster']
            rows = call['input']['scenes']
            physical = rows[scene-1]['player']
            normalized = rows[scene-1-offset]['player']
            scanned = {roster[i-1] for i in range(12, limiting+1)}
            # A scan distinguishes the readings only when the two rows name
            # different players and exactly one of them is in the scanned slots.
            if physical != normalized:
                differing += 1
                if (physical in scanned) != (normalized in scanned):
                    distinguishing += 1
            scans_by_offset[offset] = scans_by_offset.get(offset, 0) + 1
    return {
        'schema': EXPECTED['schema'],
        'issue': EXPECTED['issue'],
        'calls': calls,
        'calls_by_offset': {str(k): v for k, v in sorted(calls_by_offset.items())},
        'candidate_scans': sum(scans_by_offset.values()),
        'scans_by_offset': {str(k): v for k, v in sorted(scans_by_offset.items())},
        'scans_where_readings_differ': differing,
        'distinguishing_scans': distinguishing,
        'records': DIGESTS,
        'scope': ('Read-only audit of the six pinned T23 records. A8A0 normalizes its scene '
                  'argument by DS:0D56[side] before reading word 14 of the DS:CCEF row '
                  '(0AB9:A8BF-A8DD); no record here separates that row from the physical row, '
                  'so this audit supports a static reading, not a dynamic confirmation.'),
    }


def main():
    result = audit()
    if '--check' in sys.argv:
        for key, value in EXPECTED.items():
            if result[key] != value:
                raise SystemExit(f'{key} differs: {result[key]!r} != {value!r}')
    print(json.dumps(result, indent=2))
    return 0


if __name__ == '__main__':
    raise SystemExit(main())
