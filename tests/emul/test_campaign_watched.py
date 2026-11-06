import copy
import importlib.util
import sys
from pathlib import Path

import pytest

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / 'runtime/emul'))
spec = importlib.util.spec_from_file_location('campaign_watched_test', ROOT / 'runtime/emul/campaign_watched.py')
module = importlib.util.module_from_spec(spec)
spec.loader.exec_module(module)


def state(seed=1):
    row = {**{f'word{k}': 0 for k in (0, 2, 4, 8, 10, 14, 16, 20)},
           **{f'byte{k}': 0 for k in (6, 7, 12, 13, 18, 19, 22, 23, 24)}}
    return dict(seed=seed, elapsed=0, remaining=90, quick=0, scores=[0, 0],
                phase=45, active=0, hold=0, stoppage=0, actor=0, secondary=0,
                ball={**{f'word{k}': 0 for k in (0, 2, 4, 7, 9, 11)},
                      **{f'byte{k}': 0 for k in (6, 13, 14)}},
                scenes=[dict(index=i, **row) for i in range(1, 23)])


def chunk():
    return dict(index=0, draw_start=0, draw_end=1, tick_start=1, tick_end=1,
                action_start=0, action_end=0,
                draws=[dict(kind='draw', i=0, n=1, seed_before=1, seed_after=2,
                            value=1, callers=[])],
                ticks=[dict(tick=1, draw_start=0, draw_end=1, before=state(), after=state(2))],
                actions=[])


@pytest.mark.parametrize('damage', ['index', 'draw', 'tick', 'seed', 'scene', 'action', 'quick'])
def test_discontinuous_or_invalid_stream_refuses(damage):
    good = chunk()
    assert module.prior.validate_chunk(good)['tick'] == 2
    bad = copy.deepcopy(good)
    if damage == 'index': bad['index'] = 1
    elif damage == 'draw': bad['draws'][0]['i'] = 1
    elif damage == 'tick': bad['ticks'][0]['tick'] = 2
    elif damage == 'seed': bad['ticks'][0]['after']['seed'] = 3
    elif damage == 'scene': bad['ticks'][0]['before']['scenes'].pop()
    elif damage == 'action': bad['actions'] = [{'event': 1}]; bad['action_end'] = 1
    else: bad['ticks'][0]['before']['quick'] = 1
    with pytest.raises((KeyError, ValueError)):
        module.prior.validate_chunk(bad)


def test_unfinished_and_missing_phase_evidence_refuse():
    final = state(); final.update(elapsed=90, remaining=0)
    events = [{'code': 64, 'minute': 45}, {'code': 63, 'minute': 90}]
    module.prior.validate_finish(final, events)
    for field in ['elapsed', 'remaining', 'stoppage']:
        bad = copy.deepcopy(final); bad[field] = 1
        with pytest.raises(ValueError): module.prior.validate_finish(bad, events)
    for removed in range(2):
        with pytest.raises(ValueError): module.prior.validate_finish(final, events[removed:removed + 1])


def test_changed_source_pin_refuses(monkeypatch):
    monkeypatch.setattr(module, 'SOURCE_SHA', '0' * 64)
    with pytest.raises(ValueError, match='preparation source'):
        module.source()


def test_changed_source_start_release_and_intervention_refuse():
    base = module.source()
    start = dict(source={'record': module.SOURCE, 'sha256': module.SOURCE_SHA},
                 state_sha256=module.admission.STATE_SHA, release=base['source']['release'],
                 watch_setting=1, interventions=[], schema='original-campaign-watched-start/1',
                 producer=module.admission.git('rev-parse', 'HEAD').decode().strip(),
                 producer_files={module.TOOL: module.sha(module.admission.git('show', 'HEAD:' + module.TOOL))})
    module.identity(start, base)
    for field in ['source', 'state_sha256', 'release', 'watch_setting', 'interventions']:
        bad = copy.deepcopy(start)
        if field == 'source': bad[field]['sha256'] = '0' * 64
        elif field == 'state_sha256': bad[field] = '0' * 64
        elif field == 'release': bad[field] = {}
        elif field == 'watch_setting': bad[field] = 0
        else: bad[field] = [{'mutation': 'not allowed'}]
        with pytest.raises(ValueError): module.identity(bad, base)
