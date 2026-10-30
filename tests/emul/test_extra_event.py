"""T17 schema and provenance checks; only literal observations, no engine formulas."""
import copy
import json
import sys
from pathlib import Path
from unittest.mock import patch

import pytest

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / 'runtime/emul'))
import extra_event as ee


def state():
    p = {'id': 1, **{f'p8_{i}': 0 for i in ee.P8}, **{f'p15_{i}': 0 for i in ee.P15},
         'skills': [{'mode': i, 'style_cell': 1, 'level_cell': 2} for i in (6, 14)]}
    return {'seed': 3, 'actor': 0, 'secondary': 0, 'd6dd': 1, 'home_bonus': 0,
            'side_offsets': [11, 0], 'opponents': [1] * 10, 'clubs': [{'id': i, 'byte57': 0} for i in (1, 2)],
            'side_flags': [0, 0], 'skill_bonus_flags': [{'mode': i, 'value': 0} for i in (6, 14)],
            'scenes': [{'index': i, 'word0': 0, 'slot': i, 'player': 1, 'rating_bonus': 0, 'half': 0}
                       for i in range(1, 23)], 'players': [p]}


def call():
    return {'step': 0, 'input': state(), 'output': state(), 'draw_start': 20, 'draw_end': 21,
            'helpers': [{'caller': '0AB9:DC17', 'kind': 'availability',
                         'input': {'scene': 1, 'offset': 0xCCEF + 25, 'segment': 123},
                         'draw_start': 21, 'draw_end': 21, 'result': 1}], 'dispatch': None}


def test_literal_state_and_call_validate():
    ee.validate_call(call())


@pytest.mark.parametrize('damage', [
    'seed-bool', 'actor-float', 'missing-field', 'unknown-field', 'scene-missing', 'scene-order',
    'player-duplicate', 'player-missing', 'player-overflow', 'byte-overflow', 'skill-missing',
    'skill-bool', 'club-missing', 'club-id', 'flag-size', 'helper-missing', 'helper-order',
    'helper-kind', 'helper-result', 'helper-pointer', 'helper-mode', 'helper-rng', 'helper-extra',
    'span', 'dispatch-incomplete', 'dispatch-wrong',
])
def test_malformed_raw_observations_rejected(damage):
    c = call(); s = c['input']; h = c['helpers'][0]
    if damage == 'seed-bool': s['seed'] = True
    elif damage == 'actor-float': s['actor'] = 0.0
    elif damage == 'missing-field': del s['d6dd']
    elif damage == 'unknown-field': s['expected_result'] = 0
    elif damage == 'scene-missing': s['scenes'].pop()
    elif damage == 'scene-order': s['scenes'].reverse()
    elif damage == 'player-duplicate': s['players'].append(copy.deepcopy(s['players'][0]))
    elif damage == 'player-missing': s['players'].clear()
    elif damage == 'player-overflow': s['scenes'][0]['player'] = 3921
    elif damage == 'byte-overflow': s['players'][0]['p15_10'] = 256
    elif damage == 'skill-missing': s['players'][0]['skills'].pop()
    elif damage == 'skill-bool': s['players'][0]['skills'][0]['level_cell'] = False
    elif damage == 'club-missing': s['clubs'].pop()
    elif damage == 'club-id': s['clubs'][0]['id'] = 0
    elif damage == 'flag-size': s['side_flags'].pop()
    elif damage == 'helper-missing': c['helpers'].clear()
    elif damage == 'helper-order': h['caller'] = '0AB9:DC2C'
    elif damage == 'helper-kind': h['kind'] = 'threshold'
    elif damage == 'helper-result': h['result'] = -1
    elif damage == 'helper-pointer': h['input']['offset'] += 1
    elif damage == 'helper-mode': h['input']['mode'] = 6
    elif damage == 'helper-rng': h['draw_end'] += 1
    elif damage == 'helper-extra': c['helpers'].append(copy.deepcopy(h))
    elif damage == 'span': c['draw_end'] = 19
    elif damage == 'dispatch-incomplete': c['dispatch'] = {}
    elif damage == 'dispatch-wrong': c['dispatch'] = {'routine': 'other', 'input': state(), 'draw_start': 21}
    with pytest.raises((ValueError, KeyError, TypeError)):
        ee.validate_call(c)


def test_public_checker_fails_before_corpus_exists():
    # The real corpus test is enabled once capture completes; no private bytes required.
    if not (ROOT / 'traces/T17/index.json').exists():
        assert ee.main(['--check']) == 1
    else:
        assert ee.main(['--check']) == 0
