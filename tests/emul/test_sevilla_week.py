"""T93 week-route protocol controls; public checks need no private saves.

The sevilla_week module must refuse any state that is not the T81/T82-
authenticated post-week save before emulation, verify the replayed match
against the committed sevilla-r0001 chunk identity before the week route runs,
and accept only observed week facts (cash movement, the week-2 fixture
advance, the weekly condition refresh) with counts recorded, never
transplanted. Red until runtime/emul/sevilla_week.py exists (T93 #212).
"""
import hashlib
import importlib.util
import json
from pathlib import Path
import pytest

ROOT = Path(__file__).resolve().parents[2]
MODULE = ROOT / 'runtime/emul/sevilla_week.py'
spec = importlib.util.spec_from_file_location('sevilla_week_tested', MODULE)
sevilla_week = importlib.util.module_from_spec(spec)
spec.loader.exec_module(sevilla_week)

ENTRY_SAVE_SHA = 'f3aa2e4f076891fca47ca686664502a0f69ed79bdd67de0910bf0ed932225e29'
PREPARATION_STATE_SHA = '98275eb59475dc155e12c915996c2c2cbd0fc1298ffedf14490ff2aa118805c9'
SHA = lambda data: hashlib.sha256(data).hexdigest()


def t89_finish():
    return json.loads((ROOT / 'runs/T89/sevilla-r0001/finish.json').read_text())


def t89_index():
    return json.loads((ROOT / 'runs/T89/sevilla-r0001/index.json').read_text())


def test_the_module_pins_the_authenticated_entry_and_preparation_identities():
    assert sevilla_week.ENTRY_SAVE_SHA == ENTRY_SAVE_SHA
    assert sevilla_week.PREPARATION_STATE_SHA == PREPARATION_STATE_SHA


def test_the_sealed_match_identity_binds_the_committed_capture():
    finish, index = t89_finish(), t89_index()
    result = finish['result']
    assert result['ticks'] == 3927 and result['draws'] == 169996
    assert result['actions'] == 855 and result['entry_draws'] == 0
    assert result['match_return']['site'] == '0AB9:EBE2'
    assert index['start_sha256'] == SHA((ROOT / 'runs/T89/sevilla-r0001/start.json').read_bytes())
    pinned = sevilla_week.match_identity()
    assert pinned['chunk_sha256'] == [leaf['sha256'] for leaf in index['chunks']]
    # [T93] The flush compares the payload-digest layer: the first replayed
    # chunk's payload digest is the sealed chunk's own payload pin.
    first = json.loads((ROOT / 'runs/T89/sevilla-r0001/chunk-000000.json').read_text())
    assert pinned['payload_sha256'][0] == first['payload_sha256']
    assert pinned['payload_sha256'][0] == \
        '6330040397d724b84c1d1e9f498de76c71e3f378658bd399aca583166c4ca530'
    assert pinned['ticks'] == 3927
    assert pinned['match_return']['seed'] == result['match_return']['seed']


def test_the_week_route_refuses_a_foreign_entry_save():
    with pytest.raises(ValueError):
        sevilla_week.authenticate_entry(save_sha256='0' * 64)


def test_the_week_facts_refuse_transplanted_week0_values():
    # [confirmed:T81 dc54fe9] The week-0 movement (38,761/69,270) is
    # week-specific; the week route's check refuses it for the Sevilla week.
    with pytest.raises(ValueError):
        sevilla_week.authenticate_week_facts(
            cash_in=38_761, cash_out=69_270,
            following=dict(week=2, competition=1, opponent=28, flags=0))


def test_the_check_contract_exists_and_refuses_an_unrecorded_run():
    with pytest.raises(Exception):
        sevilla_week.check(directory=None)


def test_the_check_binds_the_sealed_identity_through_the_payload_layer(tmp_path):
    # [T93 aborted-r0001 lesson] The chunk wrappers legitimately differ between
    # captures (each carries its own producer and schema), so the sealed
    # identity binds through the chunk PAYLOAD digests; the record's own file
    # digests prove the record's integrity. A re-wrapped copy of every sealed
    # chunk — foreign producer, identical payloads — must therefore pass the
    # identity comparison and fail later, on the observed counts.
    sealed_dir = ROOT / 'runs/T89/sevilla-r0001'
    leaves = []
    for leaf in t89_index()['chunks']:
        chunk = json.loads((sealed_dir / leaf['path']).read_text())
        rewrapped = dict(schema='sevilla-watched-chunk/1', producer='0' * 40,
                         payload_sha256=chunk['payload_sha256'], payload=chunk['payload'])
        data = json.dumps(rewrapped, sort_keys=True, separators=(',', ':')).encode() + b'\n'
        (tmp_path / leaf['path']).write_bytes(data)
        leaves.append(dict(path=leaf['path'], sha256=SHA(data)))
    (tmp_path / 'start.json').write_text(json.dumps(dict(schema='sevilla-week-start/1')))
    (tmp_path / 'finish.json').write_text(json.dumps(dict(
        schema='sevilla-week-finish/1', status='completed',
        result=dict(ticks=0, draws=0, actions=0, chunk_payloads=[l['sha256'] for l in leaves]))))
    (tmp_path / 'index.json').write_text(json.dumps(dict(chunks=leaves)))
    with pytest.raises(ValueError) as caught:
        sevilla_week.check(tmp_path)
    assert 'count differs from the sealed identity' in str(caught.value)
    assert 'stream differs' not in str(caught.value)


class _FaultyGuest:
    """A stand-in guest for the play-segment wrapper: no private machine."""
    keys_delivered = []

    def where(self):
        return '0AB9:1234'

    def lin(self, where):
        return 0

    def mem(self, address, size):
        return bytes(size)


def test_the_fault_wrapper_passes_the_sealed_caller_return_through():
    # [T93, found on review of c44b8c0] tail.Complete is an Exception: it is the
    # route's control signal when the sealed caller returns, never a fault. The
    # diagnostics wrapper must re-raise it unchanged or every full run aborts at
    # the match return after the 2.5-hour replay.
    def returned():
        raise sevilla_week.tail.Complete()
    with pytest.raises(sevilla_week.tail.Complete):
        sevilla_week.diagnosed(_FaultyGuest(), [], returned)


def test_the_fault_wrapper_annotates_a_real_fault_with_the_guest_position():
    def fault():
        raise ValueError('Invalid instruction')
    stages = [dict(text='FRIENDLY #2 commentary')]
    with pytest.raises(RuntimeError) as caught:
        sevilla_week.diagnosed(_FaultyGuest(), stages, fault)
    assert 'Invalid instruction at 0AB9:1234 bytes ' + '00' * 16 in str(caught.value)
    assert 'FRIENDLY #2' in str(caught.value)


def test_a_new_capture_never_reuses_a_recorded_run_directory():
    # Rule 13: an interrupted run stays as recorded; the next attempt is a new run.
    fresh = sevilla_week.next_run('sevilla-week')
    assert fresh.parent == sevilla_week.RUNS and not fresh.exists()
    assert (fresh.parent / fresh.name.replace(fresh.name[-4:], '0001')).exists()


def test_the_default_check_names_only_a_run_with_a_finish_record():
    latest = sevilla_week.latest_complete('sevilla-week')
    assert latest is None or (latest / 'finish.json').exists()


def test_the_boundary_checkpoint_never_stops_the_capture(tmp_path):
    receipt = sevilla_week.save_boundary(tmp_path, object(), dict(producer='0' * 40), {})
    assert set(receipt) == {'error'}
    assert not (tmp_path / 'checkpoint-caller.json').exists()


def test_the_suffix_resume_refuses_an_unsealed_receipt(tmp_path):
    # An unpublished receipt is no authority for unpickling a private machine.
    receipt = tmp_path / 'checkpoint-caller.json'
    receipt.write_text(json.dumps(dict(schema='sevilla-week-checkpoint/1')))
    with pytest.raises(ValueError) as caught:
        sevilla_week.resume(receipt, tmp_path / 'suffix')
    assert 'unsealed' in str(caught.value)
    assert not (tmp_path / 'suffix').exists()
