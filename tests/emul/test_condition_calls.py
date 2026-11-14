"""T84: literal original-call integrity and a private executable replay, no model."""
import copy
import importlib.util
import json
from pathlib import Path

import pytest

ROOT = Path(__file__).resolve().parents[2]
spec = importlib.util.spec_from_file_location('condition_calls', ROOT / 'runtime/emul/condition_refresh.py')
c = importlib.util.module_from_spec(spec)
spec.loader.exec_module(c)


def record():
    return json.loads((ROOT / 'records/T84/calls-r0007.json').read_text())


def reseal(value):
    value['payload_sha256'] = c.sha(c.encoded(value['cases']))


def test_original_repeated_calls():
    c.check()
    cases = c.validate(record())
    assert len(cases) == 21
    assert sum(len(case['draws']) for case in cases) == 47


@pytest.mark.parametrize('damage', range(16))
def test_reject_corruptions_even_with_resealed_payload(damage):
    value = record()
    case = value['cases'][0]
    if damage == 0:
        case['input']['base_condition'] += 1
    if damage == 1:
        case['output']['condition'] += 1
    if damage == 2:
        case['draws'][0]['seed_before'] += 1
    if damage == 3:
        case['draws'][0]['value'] = 0
    if damage == 4:
        case['writes'][0]['field'] = 'age'
    if damage == 5:
        case['reads']['undocumented'] = 1
    if damage == 6:
        del case['reads']['caps']
    if damage == 7:
        case['returned']['sp'] -= 2
    if damage == 8:
        value['cases'].pop()
    if damage == 9:
        value['producer_files']['runtime/emul/condition_refresh.py'] = '0' * 64
    if damage == 10:
        value['source']['packed_sha256'] = '0' * 64
    if damage == 11:
        del case['input']['caps']
    if damage == 12:
        case['draws'].reverse()
    if damage == 13:
        value['status'] = 'aborted'
    if damage == 14:
        case['sites'].append('1998:0000')
    if damage == 15:
        case['writes'][0]['before'] += 1
    reseal(value)
    with pytest.raises(ValueError):
        c.validate(value)


def test_index_checks_run_digest_and_independent_repeat(tmp_path, monkeypatch):
    value = json.loads(c.INDEX.read_text())
    value['runs'][0]['sha256'] = '0' * 64
    path = tmp_path / 'index.json'
    path.write_text(json.dumps(value))
    monkeypatch.setattr(c, 'INDEX', path)
    with pytest.raises(ValueError, match='run digest'):
        c.check()
    value['runs'][0] = copy.deepcopy(value['runs'][1])
    path.write_text(json.dumps(value))
    with pytest.raises(ValueError, match='independent original repeat'):
        c.check()


def test_undeclared_semantic_operand():
    with pytest.raises(ValueError, match='undeclared semantic memory'):
        c.operand(0x60000, 1)
    with pytest.raises(ValueError, match='undeclared semantic memory'):
        c.operand(c.P15 + 22, 2)  # widening a byte crosses the declared field


def test_aborted_attempts_remain_immutable_and_refuse():
    for n in (1, 2):
        value = json.loads((ROOT / ('records/T84/calls-r%04d.json' % n)).read_text())
        assert value['cases'] == [] and value['error']
        with pytest.raises(ValueError, match='incomplete condition calls'):
            c.validate(value)


def test_private_original_replay():
    path = ROOT / '.cache/One-Nil96/1-0.EXE'
    if not path.is_file():
        pytest.skip('private original executable is absent')
    raw = path.read_bytes()
    assert c.sha(raw) == c.PACKED
    unpacked = c.unlzexe.unpack(raw)
    assert c.sha(unpacked) == c.UNPACKED
    image = c.onilexe.Image(unpacked).data
    observed = [c.execute(image, case) for case in c.inputs()]
    assert observed == record()['cases']
