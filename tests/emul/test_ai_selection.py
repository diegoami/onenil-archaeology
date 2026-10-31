"""Mutation checks for T23's independent observation reader."""
import copy
import json
import sys
from pathlib import Path
from unittest.mock import patch

import pytest

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT/'runtime/emul'))
import ai_selection as ai


@pytest.fixture(scope='module')
def sample():
    meta, base = next(ai.sources())
    rec = json.loads((ai.RUNS/'T23-r0001.json').read_text())
    return ai.contests.outputs(rec)['calls'], ai.contests.outputs(base)['calls'], meta['week']


def test_public_corpus():
    assert ai.main(['--check']) == 0


@pytest.mark.parametrize('damage', [
    'missing', 'order', 'step', 'side', 'mode', 'scene', 'seed', 'draw',
    'player', 'position-bool', 'style-negative', 'hand-selector', 'hand-cell',
    'limit-cell', 'text', 'preference-missing', 'preference-order', 'preference-extra',
    'weight-count', 'style-bounds', 'candidates-count', 'cache-count', 'cache-bounds',
    'helper-missing', 'helper-order', 'helper-site', 'helper-kind', 'helper-result',
    'helper-args', 'helper-draw', 'child-missing', 'child-order', 'child-extra',
    'child-mutation', 'effect-input', 'effect-output', 'effect-args', 'effect-child',
    'extra',
])
def test_malformed_or_discontinuous_observations_fail(sample, damage):
    original, retained, week = sample
    calls = copy.deepcopy(original)
    c = calls[0]
    s = c['input']
    parent = next(e for e in c['helpers'] if e['kind'] == 'candidates')
    effect = next(e for e in c['helpers'] if e['kind'] == 'replace')
    if damage == 'missing': calls.pop()
    elif damage == 'order': calls.reverse()
    elif damage == 'step': c['step'] += 1
    elif damage == 'side': c['side'] ^= 1
    elif damage == 'mode': c['mode'] = 1
    elif damage == 'scene': c['scene'] += 1
    elif damage == 'seed': s['seed'] ^= 1
    elif damage == 'draw': c['draw_end'] += 1
    elif damage == 'player': s['players'].pop()
    elif damage == 'position-bool': s['players'][0]['position'] = True
    elif damage == 'style-negative': s['players'][0]['style'] = -1
    elif damage == 'hand-selector': s['players'][0]['hand_selector'] = 256
    elif damage == 'hand-cell': s['players'][0]['hand_cell'] = 256
    elif damage == 'limit-cell': s['limit_cell'] = True
    elif damage == 'text': s['style_text'] = [1, 2]
    elif damage == 'preference-missing': s['preferences'].pop()
    elif damage == 'preference-order': s['preferences'].reverse()
    elif damage == 'preference-extra': s['preferences'][0]['invented'] = 0
    elif damage == 'weight-count': s['preferences'][0]['weights'].pop()
    elif damage == 'style-bounds': s['preferences'][0]['styles'] = [14]
    elif damage == 'candidates-count': s['candidates'].pop()
    elif damage == 'cache-count': s['cache_selectors'].pop()
    elif damage == 'cache-bounds': s['cache_selectors'][0][0] = 256
    elif damage == 'helper-missing': c['helpers'].pop(0)
    elif damage == 'helper-order': c['helpers'].reverse()
    elif damage == 'helper-site': parent['site'] = '0AB9:AA13'
    elif damage == 'helper-kind': parent['kind'] = 'weighted'
    elif damage == 'helper-result': c['helpers'][1]['result'] = True
    elif damage == 'helper-args': parent['arguments'] = [1]
    elif damage == 'helper-draw': parent['draw_end'] = c['draw_end'] + 1
    elif damage == 'child-missing': parent['children'].pop(1)
    elif damage == 'child-order': parent['children'].reverse()
    elif damage == 'child-extra': parent['children'].append(copy.deepcopy(parent['children'][0]))
    elif damage == 'child-mutation': parent['children'][1]['candidates_after'][0] ^= 1
    elif damage == 'effect-input': effect['input']['candidates'][0] ^= 1
    elif damage == 'effect-output': effect['output']['players'][0]['position'] ^= 1
    elif damage == 'effect-args': effect['arguments'][0] = 0
    elif damage == 'effect-child': effect['children'].append(copy.deepcopy(parent['children'][0]))
    elif damage == 'extra': s['expected_choice'] = 13
    with pytest.raises(ValueError):
        ai.cases_for(calls, retained, week)


@pytest.mark.parametrize('prefix', ['runs/T23/', 'traces/T23/', 'runs/T22/', 'traces/T22/', 'runs/T20/', 'traces/T20/'])
def test_provenance_digests_are_checked(prefix):
    original = ai.contests.sha
    with patch.object(ai.contests, 'sha', side_effect=lambda p: '0'*64 if Path(p).relative_to(ROOT).as_posix().startswith(prefix) else original(p)):
        assert ai.main(['--check']) == 1


@pytest.mark.parametrize('damage', ['all-helpers', 'candidate-chain', 'choice', 'opaque-seed', 'preference-bool', 'non-byte-text'])
def test_context_and_return_links(sample, damage):
    original, retained, week = sample
    calls = copy.deepcopy(original)
    c = calls[0]
    if damage == 'all-helpers':
        c = next(c for c in calls if len(c['helpers']) == 2)
        c['helpers'] = []
    elif damage == 'candidate-chain': c['helpers'][1]['candidates_before'][0] ^= 1
    elif damage == 'choice': c['helpers'][1]['result'] = 0
    elif damage == 'opaque-seed': c['helpers'][-1]['input']['seed'] ^= 1
    elif damage == 'preference-bool': c['input']['preferences'][1]['position'] = True
    elif damage == 'non-byte-text': c['input']['style_text'] = '\u2603'
    with pytest.raises(ValueError):
        ai.cases_for(calls, retained, week)
