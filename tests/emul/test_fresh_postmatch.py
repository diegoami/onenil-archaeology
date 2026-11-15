"""T88 source/recovery and streaming comparison controls; no engine model."""
import copy
import importlib.util
import json
import subprocess
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
    receipt=p.synthetic_receipt();p.validate_checkpoint(receipt);private=tmp_path/'machine.pkl.gz';private.write_bytes(b'not a pickle')
    receipt['private_sha256']=p.sha(private.read_bytes())
    if damage=='source':receipt['source']['state_sha256']='0'*64
    if damage=='producer':receipt['producer']='HEAD'
    if damage=='private':receipt['private_sha256']='0'*64
    if damage=='prefix':receipt['prefix_sha256']='0'*64
    if damage=='cursor':receipt['progress']['draws']=999999999
    if damage=='runtime':receipt['unicorn']='0'
    loaded=[]
    monkeypatch.setattr(p.checkpoint,'read_private',lambda *_:loaded.append(True))
    with pytest.raises((ValueError,AssertionError)):p.authenticate_recovery(receipt,private)
    assert loaded==[]


def test_partial_source_is_not_completion():
    r={'schema':'fresh-postmatch-result/1','status':'paused','error':None}
    with pytest.raises(ValueError):p.validate_result(r)


def test_unpublished_recovery_receipt_refuses_before_pickle(tmp_path,monkeypatch):
    receipt=tmp_path/'checkpoint.json';receipt.write_text(json.dumps(p.synthetic_receipt()))
    private=tmp_path/'machine.pkl.gz';private.write_bytes(b'not a pickle')
    loaded=[];monkeypatch.setattr(p.checkpoint,'read_private',lambda *_:loaded.append(True))
    with pytest.raises((ValueError,subprocess.CalledProcessError)):p.restore(receipt,private)
    assert loaded==[]


def test_mutating_a_receipt_cannot_change_expected_source_identity():
    first=p.synthetic_receipt();first['source']['state_sha256']='0'*64
    assert p.reference()[0]['state_sha256']=='7a66ef10043b0a6da9312b8f729a5c4e6009096d955c1f7f4a7cf9b2507a78fc'
    with pytest.raises(ValueError):p.validate_checkpoint(first)


def numeric_record():
    r=json.loads((ROOT/'records/T86/tail-r0009.json').read_text());a=copy.deepcopy(r['payload']['caller']);a['ops']=a.pop('operations')
    return dict(caller=a,match_return=r['payload']['match_return'],post_draws=[d for d in r['payload']['draws']if d['i']>=a['draw_start']],
        condition={k:r['payload'][k]for k in('contexts','calls')})

def test_generic_numeric_protocol_preserves_accepted_caller():
    got=p.numeric_caller(numeric_record())
    assert got['fields']==482 and got['writes']==439 and got['caller_draws']==103
    assert got['condition_calls']==35 and got['read_before_write_bytes']==563

@pytest.mark.parametrize('damage',range(13))
def test_generic_numeric_trace_corruptions_refuse(damage):
    r=numeric_record();a=r['caller']
    if damage==0:a['initial'].pop()
    if damage==1:a['ops'][0]['value']^=1
    if damage==2:next(x for x in a['ops']if x['kind']=='write')['before']^=1
    if damage==3:a['ops'][0]['address']+=1
    if damage==4:a['regions'][0]['base']+=1
    if damage==5:a['final'][-1]['value']^=1
    if damage==6:a['census']['writes']-=1
    if damage==7:r['post_draws'][0]['seed_after']^=1
    if damage==8:r['condition']['calls'][0]['input']['age']^=1
    if damage==9:r['condition']['contexts'][0]['roster'][0]=0
    if damage==10:a['returned']['sp']+=2
    if damage==11:a['frame']['performance_flag']^=1
    if damage==12:a['ops'].pop()
    with pytest.raises((ValueError,KeyError)):p.numeric_caller(r)
