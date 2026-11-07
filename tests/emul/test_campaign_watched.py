import copy
import importlib.util
import json
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
    start = json.loads((ROOT / 'runs/T67/reference-r0001/start.json').read_text())
    module.identity(start, base)
    for field in ['source', 'state_sha256', 'release', 'watch_setting', 'interventions']:
        bad = copy.deepcopy(start)
        if field == 'source': bad[field]['sha256'] = '0' * 64
        elif field == 'state_sha256': bad[field] = '0' * 64
        elif field == 'release': bad[field] = {}
        elif field == 'watch_setting': bad[field] = 0
        else: bad[field] = [{'mutation': 'not allowed'}]
        with pytest.raises(ValueError): module.identity(bad, base)


@pytest.mark.parametrize('damage', ['missing', 'extra'])
def test_observer_dependency_census_cannot_be_weakened(damage):
    base = module.source()
    start = json.loads((ROOT / 'runs/T67/reference-r0001/start.json').read_text())
    module.identity(start, base)
    if damage == 'missing':
        start['producer_files'].pop('runtime/emul/guest.py')
    else:
        name = 'CLAUDE.md'
        start['producer_files'][name] = module.sha(module.admission.git('show', start['producer'] + ':' + name))
    with pytest.raises(ValueError, match='dependency census'):
        module.identity(start, base)


def complete_stream(directory, monkeypatch):
    """Synthetic protocol fixture; no original match behavior is simulated."""
    payload = chunk()
    payload['ticks'][0]['after'].update(elapsed=90, remaining=0)
    for event, (code, minute) in enumerate([(64, 45), (63, 90)]):
        payload['actions'].append(dict(event=event, code=code, side=0,
            actor_slot=0, secondary_slot=0, club=1, player=0, secondary=0,
            minute=minute, tick=1, draw_start=0, draw_end=0, seed_before=1,
            seed_after=1, head_before=event, caller='0AB9:0000',
            queue=dict(index=event + 1, code=code, player=0, secondary=0, side=0)))
    payload['action_end'] = 2
    monkeypatch.setattr(module, 'source', lambda: {'payload': {
        'first_entry': payload['ticks'][0]['before'], 'draws': payload['draws']}})
    monkeypatch.setattr(module, 'identity', lambda *_: None)
    def put(name, value):
        data = module.encoded(value)
        (directory / name).write_bytes(data)
        return module.sha(data)
    put('start.json', {'producer': 'synthetic'})
    put('attempt-0001-start.json', {'producer': 'synthetic'})
    digest = module.sha(module.encoded(payload))
    leaf = dict(schema='original-campaign-watched-chunk/1', producer='synthetic',
                payload_sha256=digest, payload=payload)
    leaf_sha = put('chunk-000000.json', leaf)
    final = payload['ticks'][0]['after']
    result = dict(chunk_payloads=[digest], final=final, ticks=1, draws=1, actions=2)
    finish = dict(schema='original-campaign-watched-finish/1', producer='synthetic',
                  status='completed', error=None, boundary=module.prior.match.MATCH_RETURN,
                  ticks=1, draws=1, actions=2, final=final, result=result,
                  keys_delivered=[], unsupported=[])
    index = dict(start_sha256=module.sha((directory / 'start.json').read_bytes()),
                 chunks=[dict(path='chunk-000000.json', sha256=leaf_sha)],
                 finish=dict(path='attempt-0001-finish.json', sha256=put('attempt-0001-finish.json', finish)))
    put('index.json', index)
    return finish, index, put


@pytest.mark.parametrize('damage', ['result-count', 'result-state', 'result-chunks', 'unsupported', 'error', 'schema'])
def test_corrupted_completion_receipt_refuses(tmp_path, monkeypatch, damage):
    finish, index, put = complete_stream(tmp_path, monkeypatch)
    module.check(tmp_path)
    if damage == 'result-count': finish['result']['ticks'] += 1
    elif damage == 'result-state': finish['result']['final'] = state(3)
    elif damage == 'result-chunks': finish['result']['chunk_payloads'] = ['0' * 64]
    elif damage == 'unsupported': finish['unsupported'] = ['uncovered guest service']
    elif damage == 'error': finish['error'] = 'capture failed'
    else: finish['schema'] = 'other'
    index['finish']['sha256'] = put(index['finish']['path'], finish)
    put('index.json', index)
    with pytest.raises(ValueError): module.check(tmp_path)


def test_full_acceptance_requires_completed_repeat(tmp_path, monkeypatch):
    complete_stream(tmp_path, monkeypatch)
    with pytest.raises(ValueError, match='independent campaign repeat'):
        module.check(tmp_path, require_repeat=True)


@pytest.mark.parametrize('damage', [None, 'missing-start', 'missing-finish', 'aborted', 'different-result', 'different-keys', 'missing-prefix'])
def test_independent_repeat_requires_its_own_completed_attempt(tmp_path, monkeypatch, damage):
    finish, index, put = complete_stream(tmp_path, monkeypatch)
    candidate = copy.deepcopy(finish)
    put('attempt-0002-start.json', {'producer': 'synthetic'})
    put('attempt-0002-finish.json', candidate)
    put('attempt-0002-verified-000000.json', dict(producer='synthetic',
        chunk='chunk-000000.json', payload_sha256=finish['result']['chunk_payloads'][0], tick=1, draws=1))
    put('repeat-0002.json', dict(producer='synthetic', result=finish['result'],
        chunk_payloads=finish['result']['chunk_payloads'], payload_sha256=module.sha(module.encoded(finish['result']))))
    if damage is None:
        module.check(tmp_path, require_repeat=True)
        return
    if damage == 'missing-start': (tmp_path / 'attempt-0002-start.json').unlink()
    elif damage == 'missing-finish': (tmp_path / 'attempt-0002-finish.json').unlink()
    elif damage == 'missing-prefix': (tmp_path / 'attempt-0002-verified-000000.json').unlink()
    else:
        if damage == 'aborted': candidate['status'] = 'aborted'
        elif damage == 'different-result': candidate['result']['draws'] += 1
        else: candidate['keys_delivered'] = [['different input', '0AB9:0000']]
        put('attempt-0002-finish.json', candidate)
    with pytest.raises(ValueError): module.check(tmp_path, require_repeat=True)
