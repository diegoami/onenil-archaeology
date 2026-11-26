#!/usr/bin/env python3
"""T117: the player names behind T102's and T49's boards.

The save's player id is one more than the league file's name-pool index. The
campaign's own Blackburn rows show it (save 2581 'T Flowers' is pool 2580
'Flowers'), and the 1995 league pool then gives the opponents' surnames:
2429 -> Fox, 2426 -> Howey, 2434 -> Clark, 2427 -> Venison, 2435 -> Albert,
2423 -> Watson; 333 -> Bravo, 325 -> Cobos, 334 -> Allou, 327 -> Le Guen,
335 -> Kombouare, 323 -> Colleter.

The initials on a board are the original's display strings; the league pool has
surnames only. This record binds both to the scorer and substitution records so
a renderer can show the same board without the original game bytes.

    python3 runs/T117/names.py --run
    python3 runs/T117/names.py --check runs/T117/names-r0001.json
"""
import argparse
import hashlib
import json
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
LEAGUES = ROOT / 'records/T03/leagues.json'
T119 = ROOT / 'runs/T119/admission-r0004.json'
T49 = ROOT / 'runs/T49/session-r0002/step-0012.json'
T102_HALF = ROOT / 'runs/T102/session-r0002/step-0003.json'
T102_FULL = ROOT / 'runs/T102/session-r0002/step-0005.json'

CASES = {
    'league': {
        'fixture': T119,
        'screens': {'half': T102_HALF, 'full': T102_FULL},
        'players': [
            {'save_id': 2429, 'display': 'R Fox', 'minute': 29, 'role': 'scorer'},
            {'save_id': 2426, 'display': 'S Howey', 'minute': 33, 'role': 'scorer'},
            {'save_id': 2434, 'display': 'Clark', 'minute': None, 'role': 'substitute_on'},
            {'save_id': 2427, 'display': 'Venison', 'minute': None, 'role': 'substitute_off'},
            {'save_id': 2423, 'display': 'Watson', 'minute': None, 'role': 'substitute_on'},
            {'save_id': 2435, 'display': 'Albert', 'minute': None, 'role': 'substitute_off'},
        ],
        'pairs': [
            {'on': 2434, 'off': 2427, 'screen': 'Clark on for Venison'},
            {'on': 2423, 'off': 2435, 'screen': 'Watson on for Albert'},
        ],
        'screen_lines': {'half': ['**** GOAL **** by Fox', '**** GOAL **** by Howey'],
                         'full': ['R Fox', 'S Howey', 'Clark on for Venison',
                                  'Watson on for Albert']},
    },
    'friendly': {
        'fixture': None,
        'screens': {'full': T49},
        'players': [
            {'save_id': 333, 'display': 'D Bravo', 'minute': 27, 'role': 'scorer'},
            {'save_id': 325, 'display': 'J Cobos', 'minute': 45, 'role': 'scorer'},
            {'save_id': 334, 'display': 'Allou', 'minute': None, 'role': 'substitute_on'},
            {'save_id': 327, 'display': 'Le Guen', 'minute': None, 'role': 'substitute_off'},
            {'save_id': 335, 'display': 'Kombouare', 'minute': None, 'role': 'substitute_on'},
            {'save_id': 323, 'display': 'Colleter', 'minute': None, 'role': 'substitute_off'},
        ],
        'pairs': [
            {'on': 334, 'off': 327, 'screen': 'Allou on for Le Guen'},
            {'on': 335, 'off': 323, 'screen': 'Kombouare on for Colleter'},
        ],
        'screen_lines': {'full': ['D Bravo', 'J Cobos', 'Allou on for Le Guen',
                                  'Kombouare on for Colleter']},
    },
}


def sha(data):
    return hashlib.sha256(data).hexdigest()


def names():
    record = json.loads(LEAGUES.read_text())
    blocks = record['files']['ENGL-95.DAT']['blocks']
    pool = next(block for block in blocks if block['name'] == 'player_name_pool')
    return pool['player_names'], sha(LEAGUES.read_bytes())


def text(path):
    return json.loads(path.read_text())['text']


def case(name, pool):
    spec = CASES[name]
    players = []
    for row in spec['players']:
        surname = pool[row['save_id'] - 1]
        if not row['display'].endswith(surname):
            raise ValueError(f'{name} {row["save_id"]}: display does not end in {surname}')
        players.append({**row, 'surname': surname})
    for pair in spec['pairs']:
        on = next(row for row in players if row['save_id'] == pair['on'])
        off = next(row for row in players if row['save_id'] == pair['off'])
        expected = f'{on["surname"]} on for {off["surname"]}'
        if pair['screen'] != expected:
            raise ValueError(f'{name}: pair screen {pair["screen"]!r} != {expected!r}')
    return {'players': players, 'pairs': spec['pairs']}


def capture():
    pool, digest = names()
    out = {'schema': 'display-player-names/1', 'task': 'T117', 'status': 'completed',
           'sources': {'records/T03/leagues.json': digest,
                       'runs/T119/admission-r0004.json': sha(T119.read_bytes()),
                       'runs/T49/session-r0002/step-0012.json': sha(T49.read_bytes()),
                       'runs/T102/session-r0002/step-0003.json': sha(T102_HALF.read_bytes()),
                       'runs/T102/session-r0002/step-0005.json': sha(T102_FULL.read_bytes())},
           'league': 'ENGL-95.DAT',
           'pool_index': {'save_id_minus_pool_index': 1,
                          'witness': 'campaign save 2581 T Flowers = pool 2580 Flowers'},
           'matches': {}}
    for name in ('league', 'friendly'):
        out['matches'][name] = case(name, pool)
    # The screens are the display evidence: every witnessed line must be present.
    for name, spec in CASES.items():
        for key, lines in spec['screen_lines'].items():
            raw = text(spec['screens'][key])
            for line in lines:
                if line not in raw:
                    raise ValueError(f'{name} {key}: screen lacks {line!r}')
    # Scorers' minutes as the full-time board prints them.
    board = text(T102_FULL)
    for row in out['matches']['league']['players']:
        if row['role'] == 'scorer':
            if not any(row['display'] in line and str(row['minute']) in line
                       for line in board.splitlines()):
                raise ValueError(f'league: no full-time row for {row["display"]} {row["minute"]}')
    friend = text(T49)
    for row in out['matches']['friendly']['players']:
        if row['role'] == 'scorer':
            if not any(row['display'] in line and str(row['minute']) in line
                       for line in friend.splitlines()):
                raise ValueError(f'friendly: no full-time row for {row["display"]} {row["minute"]}')
    return out


def validate(record):
    if record['schema'] != 'display-player-names/1' or record['status'] != 'completed':
        raise ValueError('incomplete display-name record')
    for path, digest in record['sources'].items():
        if sha((ROOT / path).read_bytes()) != digest:
            raise ValueError(f'{path}: source digest differs')
    pool, _ = names()
    for name in ('league', 'friendly'):
        expected = case(name, pool)
        if record['matches'][name] != expected:
            raise ValueError(f'{name}: names differ from the league pool')


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--run', action='store_true')
    parser.add_argument('--record', type=Path)
    parser.add_argument('--check', type=Path)
    args = parser.parse_args()
    if args.run:
        if args.record is None:
            parser.error('--run needs --record')
        if args.record.exists():
            raise SystemExit('the record path already exists')
        record = capture()
        validate(record)
        args.record.parent.mkdir(parents=True, exist_ok=True)
        args.record.write_text(json.dumps(record, indent=1) + '\n')
        print('recorded', len(record['matches']['league']['players']),
              'league and', len(record['matches']['friendly']['players']),
              'friendly display names')
        return
    record = json.loads(args.check.read_text())
    validate(record)
    print('the T102/T49 display names and the league pool: ready')


if __name__ == '__main__':
    main()
