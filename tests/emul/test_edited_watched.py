"""Public guards for the bounded edited observer; synthetic stop records are not measurements."""
import copy,importlib.util,json,sys
from pathlib import Path
import pytest
ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT/'runtime/emul'))
spec=importlib.util.spec_from_file_location('edited_watched_test',ROOT/'runtime/emul/edited_watched.py');module=importlib.util.module_from_spec(spec);spec.loader.exec_module(module)

@pytest.mark.parametrize('damage',['first','repeat'])
def test_source_pair_is_pinned(damage,monkeypatch):
    monkeypatch.setattr(module,'SOURCE_SHA' if damage=='first' else 'REPEAT_SHA','0'*64)
    with pytest.raises(ValueError,match='source differs'):module.source()

def test_unchanged_profile_does_not_identify_edited_stream():
    start=json.loads((ROOT/'runs/T67/reference-r0001/start.json').read_text())
    with pytest.raises(ValueError):module.identity(start,module.source())

def synthetic_stop():
    payload=dict(draw_end=300,action_end=2,ticks=[dict(after={'named':'synthetic state'})])
    finish=dict(schema='original-edited-watched-bounded/1',producer='synthetic',status='prefix-completed',boundary='0AB9:7B79',ticks=64,draws=300,actions=2,final=payload['ticks'][-1]['after'],chunk_payloads=[module.sha(module.encoded(payload))],keys_delivered=[[k,'24BC:0C58'] for k in module.admission.UI_KEYS+['Return','Return']],unsupported=[])
    return finish,payload

@pytest.mark.parametrize('damage',['status','boundary','ticks','draws','actions','final','digest','keys','producer','extra'])
def test_prefix_cannot_masquerade_as_completion_or_corrupt_stop(damage):
    good,payload=synthetic_stop();module.validate_bounded_finish(good,payload,'synthetic');bad=copy.deepcopy(good)
    if damage=='status':bad['status']='completed'
    elif damage=='boundary':bad['boundary']='0AB9:EBE2'
    elif damage in ('ticks','draws','actions'):bad[damage]+=1
    elif damage=='final':bad['final']={'foreign':True}
    elif damage=='digest':bad['chunk_payloads']=['0'*64]
    elif damage=='keys':bad['keys_delivered'][0][0]='Return'
    elif damage=='producer':bad['producer']='foreign'
    else:bad['opaque']=True
    with pytest.raises(ValueError):module.validate_bounded_finish(bad,payload,'synthetic')

def test_public_bounded_original_and_independent_repeat():
    directory=ROOT/'runs/T70/reference-r0001'
    if not directory.exists():pytest.skip('original bounded pair not yet retained')
    result=module.check_bounded(directory,require_repeat=True)
    assert result['ticks']==64 and result['attempts']>=2

@pytest.mark.parametrize('damage',['entry','rng','tick','seed','receipt','closure','keys','completion'])
def test_public_prefix_corruption_controls(damage,tmp_path):
    import shutil
    source=ROOT/'runs/T70/reference-r0001'
    if not (source/'attempt-0002-bounded.json').exists():pytest.skip('original repeated prefix not yet retained')
    directory=tmp_path/'case';shutil.copytree(source,directory)
    if damage in ('entry','rng','tick','seed'):
        path=directory/'chunk-000000.json';row=json.loads(path.read_text())
        if damage=='entry':row['payload']['ticks'][0]['before']['scenes'][1]['word14']=2582
        elif damage=='rng':row['payload']['draws'][0]['seed_before']^=1
        elif damage=='tick':row['payload']['ticks'][0]['tick']=2
        else:row['payload']['ticks'][-1]['after']['seed']^=1
        row['payload_sha256']=module.sha(module.encoded(row['payload']));path.write_text(json.dumps(row))
    elif damage=='receipt':
        path=directory/'attempt-0002-verified-000000.json';row=json.loads(path.read_text());row['payload_sha256']='0'*64;path.write_text(json.dumps(row))
    elif damage=='closure':
        path=directory/'start.json';row=json.loads(path.read_text());row['producer_files'].pop('runtime/emul/guest.py');path.write_text(json.dumps(row))
    else:
        path=directory/'attempt-0002-bounded.json';row=json.loads(path.read_text())
        if damage=='keys':row['keys_delivered'][0][0]='Return'
        else:row.update(status='completed',boundary='0AB9:EBE2')
        path.write_text(json.dumps(row))
    with pytest.raises((ValueError,KeyError)):module.check_bounded(directory,require_repeat=True)
