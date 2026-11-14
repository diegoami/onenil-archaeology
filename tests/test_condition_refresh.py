"""T83: receipt authentication and independent private-save re-decode, no engine model."""
import copy
import json
from pathlib import Path

import pytest

from test_week_completion import w

ROOT = Path(__file__).resolve().parents[1]
RECORD = ROOT / 'records/T83/conditions-r0002.json'


def receipt():
    return json.loads(RECORD.read_text())


def test_clean_condition_receipt():
    assert w.validate_conditions(receipt()) == dict(roster=18, changed=17, gale=19, pearce=31)


@pytest.mark.parametrize('damage', range(9))
def test_condition_receipt_rejects_corruption(damage):
    record = receipt()
    if damage == 0:
        record['decoded']['conditions_post']['2583']['condition'] += 1
    if damage == 1:
        record['sources']['post']['sha256'] = '0' * 64
    if damage == 2:
        record['decoded']['conditions_pre']['2583']['slot'] = 19
    if damage == 3:
        del record['decoded']['conditions_post']['2598']
    if damage == 4:
        record['producer'] = 'b79e47b3b94537ff9dcface2b596a66c1baac3ee'
    if damage == 5:
        record['producer_files']['runtime/driver/week_completion.py'] = '0' * 64
    if damage == 6:
        record['producer_files'].pop('tools/data/save.py')
    if damage == 7:
        record['session']['sha256'] = '0' * 64
    if damage == 8:
        record['decoded']['conditions_post']['2592']['condition'] = 17
    with pytest.raises(ValueError):
        w.validate_conditions(record)


def test_old_dirty_producer_receipt_is_preserved_but_refuses():
    old = json.loads((ROOT / w.CONDITIONS_PATH).read_text())
    with pytest.raises(ValueError, match='producer identity'):
        w.validate_conditions(old)
    assert old['decoded'] == receipt()['decoded']


def test_private_condition_save_pair():
    pre = ROOT / '.cache/One-Nil96/SAVE1.1-0'
    post = ROOT / '.cache/T81-original-r0007/game/SAVE1.1-0'
    if not pre.is_file() or not post.is_file():
        pytest.skip('private T81 saves are absent')
    before, after = pre.read_bytes(), post.read_bytes()
    record = receipt()
    assert w.validate_conditions(record, before, after)['changed'] == 17
    bad = bytearray(after)
    offset = w.block_offsets()['[DS:D7BE]'][0] + 15 * 2583 + 8
    bad[offset] ^= 1
    with pytest.raises(ValueError, match='private condition save digest'):
        w.validate_conditions(record, before, bytes(bad))
    with pytest.raises(ValueError, match='both private saves'):
        w.validate_conditions(record, before)
    # If a decoder later drops an observed field, a matching file digest alone
    # must not make the receipt pass.
    original = w.roster_conditions
    def wrong_decode(data):
        rows = copy.deepcopy(original(data))
        rows['2583']['condition'] += 1
        return rows
    with pytest.MonkeyPatch.context() as patch:
        patch.setattr(w, 'roster_conditions', wrong_decode)
        with pytest.raises(ValueError, match='private condition decode'):
            w.validate_conditions(record, before, after)
