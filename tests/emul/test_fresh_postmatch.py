"""T88 source/recovery and streaming comparison controls; no engine model."""
import copy
import importlib.util
import json
from pathlib import Path
from types import SimpleNamespace
import pytest
ROOT=Path(__file__).resolve().parents[2]
spec=importlib.util.spec_from_file_location('fresh_postmatch_tested',ROOT/'runtime/emul/fresh_postmatch.py')
p=importlib.util.module_from_spec(spec);spec.loader.exec_module(p)


def test_source_matches_the_actual_fresh_reference():
    source,expected=p.reference()
    assert source['state_sha256']=='7a66ef10043b0a6da9312b8f729a5c4e6009096d955c1f7f4a7cf9b2507a78fc'
    assert (len(expected['ticks']),len(expected['draws']),len(expected['actions']))==(3825,158992,748)
    assert expected['finish']['boundary']=='0AB9:EBE2'


def test_actual_rng_prefix_is_compared_never_used_as_state():
    _,expected=p.reference();state=p.initial_progress();sink=p.Events(state,expected)
    first=copy.deepcopy(expected['draws'][0]);sink.append(first)
    assert state['draws']==1
    for name in ['i','n','value','seed_before','seed_after']:
        bad=copy.deepcopy(expected['draws'][1]);bad[name]^=1
        with pytest.raises(ValueError):sink.append(bad)
    assert state['draws']==1


@pytest.mark.parametrize('damage',['source','producer','private','prefix','cursor','runtime'])
def test_bad_recovery_refuses_before_deserialization(tmp_path,monkeypatch,damage):
    # A valid public receipt is supplied by the producer fixture helper; every
    # negative must stop before any local/owner pickle is deserialized.
    receipt=p.synthetic_receipt();private=tmp_path/'machine.pkl.gz';private.write_bytes(b'not a pickle')
    receipt['private_sha256']=p.sha(private.read_bytes())
    if damage=='source':receipt['source']['state_sha256']='0'*64
    if damage=='producer':receipt['producer']='HEAD'
    if damage=='private':receipt['private_sha256']='0'*64
    if damage=='prefix':receipt['prefix_sha256']='0'*64
    if damage=='cursor':receipt['progress']['draws']=999999999
    if damage=='runtime':receipt['unicorn']='0'
    loaded=[]
    monkeypatch.setattr(p.checkpoint,'read_private',lambda *_:loaded.append(True))
    with pytest.raises((ValueError,AssertionError)):p.restore(receipt,private)
    assert loaded==[]


def test_partial_source_is_not_completion():
    r={'schema':'fresh-postmatch-result/1','status':'paused','error':None}
    with pytest.raises(ValueError):p.validate_result(r)
