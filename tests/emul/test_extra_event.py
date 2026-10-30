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


def test_complete_public_corpus():
    assert ee.main(['--check']) == 0


@pytest.mark.parametrize('prefix', ['runs/T17/', 'traces/T17/', 'runs/T16/', 'traces/T16/', 'traces/T08/'])
def test_public_corpus_rejects_changed_record_fixture_and_source_digests(prefix):
    original = ee.contests.sha

    def damaged(path):
        return '0' * 64 if Path(path).relative_to(ROOT).as_posix().startswith(prefix) else original(path)

    with patch.object(ee.contests, 'sha', side_effect=damaged):
        assert ee.main(['--check']) == 1


@pytest.fixture(scope='module')
def active_record():
    rec = next(r for _, r in ee.selected_runs().values() if ee.contests.outputs(r)['calls'])
    source = rec['actions']['source']
    return rec, source, ee.contests.events(ROOT / source['trace'])


@pytest.mark.parametrize('damage', [
    'missing-call', 'reordered-calls', 'wrong-step', 'missing-helper', 'helper-pointer',
    'helper-position', 'helper-span', 'input-seed', 'output-seed', 'prefix-scene', 'wrong-draw-span',
    'trace-state', 'trace-status', 'trace-draw-value', 'missing-dispatch', 'dispatch-seed',
])
def test_actual_call_links_reject_missing_boundaries_and_corrupt_sources(active_record, damage):
    record, source, trace = active_record
    calls = copy.deepcopy(ee.contests.outputs(record)['calls'])
    source, trace = copy.deepcopy(source), copy.deepcopy(trace)
    c = calls[0]
    if damage == 'missing-call': calls.pop()
    elif damage == 'reordered-calls': calls.reverse()
    elif damage == 'wrong-step': c['step'] += 1
    elif damage == 'missing-helper': c['helpers'].pop()
    elif damage == 'helper-pointer': c['helpers'][0]['input']['offset'] += 1
    elif damage == 'helper-position': c['helpers'][0]['draw_start'] -= 1; c['helpers'][0]['draw_end'] -= 1
    elif damage == 'helper-span': c['helpers'][0]['draw_end'] += 1
    elif damage == 'input-seed': c['input']['seed'] ^= 1
    elif damage == 'output-seed': c['output']['seed'] ^= 1
    elif damage == 'prefix-scene': c['input']['scenes'][0]['word0'] ^= 1
    elif damage == 'wrong-draw-span': c['draw_end'] += 1
    elif damage == 'trace-state': trace[0]['state_sha256'] = '0' * 64
    elif damage == 'trace-status': trace[-1]['status'] = 'aborted: test'
    elif damage == 'trace-draw-value':
        # A changed retained draw must be rejected by its source SHA, before export.
        with patch.object(ee.contests, 'sha', return_value='0' * 64):
            assert ee.main(['--check']) == 1
        return
    elif damage == 'missing-dispatch':
        next(c for c in calls if c['dispatch'])['dispatch'] = None
    elif damage == 'dispatch-seed':
        next(c for c in calls if c['dispatch'])['dispatch']['input']['seed'] ^= 1
    with pytest.raises(ValueError):
        ee.cases_for(calls, source, trace)
