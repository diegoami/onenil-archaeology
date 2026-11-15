"""T85 observed-call/caller census, trace linkage and native comparison corruptions."""
import copy
import importlib.util
import json
from pathlib import Path

import pytest

ROOT = Path(__file__).resolve().parents[2]
spec = importlib.util.spec_from_file_location('condition_handoff_tested', ROOT / 'runtime/emul/condition_handoff.py')
c = importlib.util.module_from_spec(spec)
spec.loader.exec_module(c)
RUN = ROOT / 'records/T85/handoff-r0003.json'


def capture():
    return json.loads(RUN.read_text())


def reseal(value):
    value['payload_sha256'] = c.sha(c.encoded(value['payload']))


def test_complete_original_repeat_and_native_receipt():
    c.check()
    assert c.validate(capture()) == dict(calls=3028, call_draws=6056, outside_draws=16950,
                                       contexts=178, initial_players=18, quick_steps=92)


@pytest.mark.parametrize('damage', range(28))
def test_resealed_capture_corruptions_refuse(damage):
    value = capture()
    p = value['payload']
    call, parent = p['calls'][0], p['contexts'][0]
    if damage == 0:
        p['calls'].pop()
    if damage == 1:
        p['calls'].insert(0, copy.deepcopy(call))
    if damage == 2:
        call['draw_start'] -= 1
    if damage == 3:
        p['outside'][0][1] += 1
    if damage == 4:
        call['input']['seed'] ^= 1
    if damage == 5:
        call['output']['condition'] += 1
    if damage == 6:
        call['writes'][0]['before'] ^= 1
    if damage == 7:
        bench = next(x for x in p['calls'] if x['slot'] > 11 and x['input']['flag'] == 0)
        bench['status_byte'] |= 4
    if damage == 8:
        call['returned']['sp'] -= 2
    if damage == 9:
        parent['roster'][0] += 1
    if damage == 10:
        parent['calls'].pop()
    if damage == 11:
        parent['draw_end'] = parent['draw_start'] - 1
    if damage == 12:
        p['contexts'].pop()  # empty inactive manager visits must not disappear
    if damage == 13:
        del call['input']['age_reference']
    if damage == 14:
        call['dependencies']['facility'] ^= 1
    if damage == 15:
        value['save']['sha256'] = '0' * 64
    if damage == 16:
        parent['entry_seed'] ^= 1
    if damage == 17:
        call['return_site'] = '1998:0000'
    if damage == 18:
        value['producer_files']['runtime/emul/condition_handoff.py'] = '0' * 64
    if damage == 19:
        call['input']['player'] = 0
    if damage == 20:
        p['quick_steps'] = 0
    if damage == 21:
        call['draws'][0]['value'] ^= 1
    if damage == 22:
        p['pending'] = dict(incomplete=True)
    if damage == 23:
        parent['return_instruction'] = '1998:0000'
    if damage == 24:
        value['mode'] = 'watched'
    if damage == 25:
        value['initial']['players']['2582']['condition'] -= 1
    if damage == 26:
        value['initial']['staff_by_club']['130']['staff_id'] = 1001
    if damage == 27:
        value['code'].pop('1998')
    reseal(value)
    with pytest.raises(ValueError):
        c.validate(value)


@pytest.mark.parametrize('damage', range(8))
def test_native_receipt_corruptions_refuse(damage):
    value = json.loads((ROOT / 'records/T85/native-r0001.json').read_text())
    if damage == 0:
        value['matches'] -= 1
    if damage == 1:
        value['counts']['call_draws'] -= 1
    if damage == 2:
        value['source']['sha256'] = '0' * 64
    if damage == 3:
        value['native_commit'] = '0' * 40
    if damage == 4:
        value['actual_sha256'] = '0' * 64
    if damage == 5:
        value['build']['probe_sha256'] = '0' * 64
    if damage == 6:
        value['status'] = 'aborted'
    if damage == 7:
        value['native_tree'] = '0' * 40
    with pytest.raises(ValueError):
        c.validate_native(value, RUN, capture())


def test_manifest_rejects_mutated_initial_fields_without_private_bytes(tmp_path, monkeypatch):
    # Private bytes are needed to re-decode new initial fields. Public checking
    # authenticates the retained observation instead of pretending to do that.
    value = capture()
    value['initial']['players']['2582']['base_condition'] -= 1
    changed = tmp_path / 'changed.json'
    changed.write_text(json.dumps(value))
    index = json.loads(c.INDEX.read_text())
    index['runs'][0]['path'] = str(changed)
    path = tmp_path / 'index.json'
    path.write_text(json.dumps(index))
    monkeypatch.setattr(c, 'INDEX', path)
    with pytest.raises(ValueError, match='immutable handoff run digest'):
        c.check()


def test_partition_rejects_overlapping_spans():
    with pytest.raises(ValueError, match='overlapping'):
        c.partition([dict(draw_start=2, draw_end=4), dict(draw_start=3, draw_end=5)], 6)
