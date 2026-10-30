import copy
import json
import sys
from pathlib import Path
from unittest.mock import patch
import pytest

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / 'runtime/emul'))
import event_effects as ee


def test_complete_public_logical_effect_corpus():
    assert ee.main(['--check']) == 0


@pytest.fixture(scope='module')
def sample():
    # The immutable aborted export attempt still holds actual guest observations.
    p = next(p for p in sorted(ee.RUNS.glob('T19-r*.json')) if ee.contests.outputs(json.loads(p.read_text()))['calls'])
    r = json.loads(p.read_text()); meta, old = ee.supplement.sources()[0]
    return ee.contests.outputs(r)['calls'], meta, old, ee.lookup_source(meta)


@pytest.mark.parametrize('damage', [
    'missing-call', 'call-order', 'seed', 'handoff', 'player-byte', 'player-missing', 'player-alias',
    'roster', 'selector-missing', 'selector-order', 'selector-value', 'selector-head', 'pool-context',
    'queue-context', 'queue-row', 'byte-float', 'counter-bool', 'weight-missing', 'cache-size',
    'scene-extra', 'event-missing', 'action-missing', 'bad-action', 'event-side', 'source-sha',
])
def test_missing_mistyped_boundary_observations_and_provenance_rejected(sample, damage):
    calls, meta, old, lookups = sample
    calls, meta = copy.deepcopy(calls), copy.deepcopy(meta); c = calls[0]; s = c['input']
    if damage == 'missing-call': calls.pop()
    elif damage == 'call-order': calls.reverse()
    elif damage == 'seed': s['handoff']['seed'] ^= 1
    elif damage == 'handoff': c['output']['handoff']['actor'] ^= 1
    elif damage == 'player-byte': s['players'][0]['p15_11'] = 256
    elif damage == 'player-missing': s['players'].pop()
    elif damage == 'player-alias': s['players'].append(copy.deepcopy(s['players'][0]))
    elif damage == 'roster': s['rosters'][0]['club'] ^= 1
    elif damage == 'selector-missing': c['selectors'].pop()
    elif damage == 'selector-order': c['selectors'].reverse()
    elif damage == 'selector-value': c['selectors'][0]['value'] ^= 1
    elif damage == 'selector-head': c['selectors'][0]['head_after'] = 0
    elif damage == 'pool-context': c['output']['selectors']['cells'][0]['index'] ^= 1
    elif damage == 'queue-context': c['output']['queue']['rows'][0]['index'] += 1
    elif damage == 'queue-row': s['queue']['rows'].pop()
    elif damage == 'byte-float': s['active'] = 1.0
    elif damage == 'counter-bool': s['counters'][0][0] = False
    elif damage == 'weight-missing': s['weights'].pop()
    elif damage == 'cache-size': s['cache'][0].pop()
    elif damage == 'scene-extra': s['scene_extra'].pop()
    elif damage == 'event-missing': c['events'].pop()
    elif damage == 'action-missing': c['actions'].pop()
    elif damage == 'bad-action': c['actions'][0]['routine'] = '0AB9:FFFF'
    elif damage == 'event-side': c['events'][0]['event_side'] = 2
    elif damage == 'source-sha':
        with patch.object(ee.contests, 'sha', return_value='0' * 64): assert ee.main(['--check']) == 1
        return
    with pytest.raises(ValueError): ee.cases_for(calls, meta, old, lookups)


@pytest.mark.parametrize('prefix', ['runs/T19/', 'traces/T19/', 'runs/T17/', 'traces/T17/', 'runs/T18/', 'traces/T18/'])
def test_changed_original_source_record_fixture_digests_fail(prefix):
    original = ee.contests.sha
    with patch.object(ee.contests, 'sha', side_effect=lambda p: '0' * 64 if Path(p).relative_to(ROOT).as_posix().startswith(prefix) else original(p)):
        assert ee.main(['--check']) == 1


@pytest.mark.parametrize('damage', ['missing', 'order', 'cache', 'delta-type', 'availability'])
def test_missing_reordered_and_malformed_ordered_helpers_fail_public_check(damage):
    original = ee.contests.outputs
    def changed(rec):
        value = original(rec)
        if rec.get('experiment') == 'T19' and any(c['helpers'] for c in value['calls']):
            value = copy.deepcopy(value)
            c = next(c for c in value['calls'] if c['helpers'])
            h = next(h for h in c['helpers'] if h['kind'] == 'byte6')
            if damage == 'missing': c['helpers'].pop()
            elif damage == 'order': c['helpers'].reverse()
            elif damage == 'cache': h['input']['cache_before'] ^= 1
            elif damage == 'delta-type': h['input']['delta'] = -2.0
            else: c['helpers'].remove(next(h for h in c['helpers'] if h['kind'] == 'availability'))
        return value
    with patch.object(ee.contests, 'outputs', side_effect=changed): assert ee.main(['--check']) == 1
