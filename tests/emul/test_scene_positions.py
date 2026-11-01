import copy
import json
import re
import sys
from pathlib import Path
from unittest.mock import patch
import pytest

ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT/'runtime/emul'))
import scene_positions as r


@pytest.fixture(scope='module')
def sample():
    meta,base=next(r.sources())
    rec=next(json.loads(p.read_text()) for p in sorted(r.RUNS.glob('T34-r*.json')) if json.loads(p.read_text())['status']=='completed')
    return r.contests.outputs(rec)['calls'],base,meta['week']


def test_complete_original_scene_positions_corpus():assert r.main(['--check'])==0


@pytest.mark.parametrize('damage',[
 'missing','order','step','replacement','arguments','event','span','extra','sign-missing','sign-bool','sign-bound',
 'position-missing','position-order','position-extra','position-bool','position-bound','position-word-bool','position-word-bound',
 'input','output','visit-missing','visit-order','side-bool','slot-bool','side','slot','scene','previous','player',
 'visit-input','previous-input','base-unrelated','base-word','table-missing','table-position','table-word','table-bool',
 'branch','duplicate-branch','first-branch','visit-output','previous-output','current-high','draw-start','draw-end','extra-visit',
 'first-previous','first-previous-output','final-word','unrelated-cache'])
def test_missing_malformed_or_discontinuous_observations_fail(sample,damage):
    original,base,week=sample;calls=copy.deepcopy(original);c=calls[0];s=c['input'];v=c['visits'][1]
    if damage=='missing':calls.pop()
    elif damage=='order':calls.reverse()
    elif damage in ('step','replacement','event'):c[damage]+=1
    elif damage=='arguments':c['arguments'][0]^=1
    elif damage=='span':c['draw_end']+=1
    elif damage=='extra':s['prediction']=0
    elif damage=='sign-missing':s['signs'].pop()
    elif damage=='sign-bool':s['signs'][0]=False
    elif damage=='sign-bound':s['signs'][0]=256
    elif damage=='position-missing':s['positions'].pop()
    elif damage=='position-order':s['positions'].reverse()
    elif damage=='position-extra':s['positions'][0]['prediction']=0
    elif damage=='position-bool':s['positions'][0]['position']=False
    elif damage=='position-bound':s['positions'][0]['position']=256
    elif damage=='position-word-bool':s['positions'][0]['word']=False
    elif damage=='position-word-bound':s['positions'][0]['word']=65536
    elif damage=='input':s['context']['gate']^=1
    elif damage=='output':c['output']['signs'][0]^=1
    elif damage=='visit-missing':c['visits'].pop()
    elif damage=='visit-order':c['visits'].reverse()
    elif damage=='side-bool':v['side']=False
    elif damage=='slot-bool':v['slot']=True
    elif damage in ('side','slot','scene','previous','player'):v[damage]^=1
    elif damage=='visit-input':v['input']['word10']^=1
    elif damage=='previous-input':v['previous_input']['word10']^=1
    elif damage=='base-unrelated':v['base']['byte18']^=1
    elif damage=='base-word':v['base']['word10']^=1
    elif damage=='table-missing':v['table'].pop('word')
    elif damage=='table-position':v['table']['position']^=1
    elif damage=='table-word':v['table']['word']^=1
    elif damage=='table-bool':v['table']['word']=False
    elif damage=='branch':v['branch']='0AB9:FFFF'
    elif damage=='duplicate-branch':v['branch']=r.BRANCHES[0] if v['branch'] is None else None
    elif damage=='first-branch':c['visits'][0]['branch']=r.BRANCHES[0]
    elif damage=='visit-output':v['output']['byte18']^=1
    elif damage=='previous-output':v['previous_output']['byte18']^=1
    elif damage=='current-high':v['output']['word10']^=256
    elif damage=='draw-start':v['draw_start']+=1
    elif damage=='draw-end':v['draw_end']+=1
    elif damage=='extra-visit':c['visits'].append(copy.deepcopy(v))
    elif damage=='first-previous':c['visits'][0]['previous']=1
    elif damage=='first-previous-output':c['visits'][0]['previous_output']=copy.deepcopy(v['previous_output'])
    elif damage=='final-word':r.scenes(c['output'])[0]['word10']^=1
    elif damage=='unrelated-cache':c['output']['context']['cache'][0]['players'][1]^=1
    with pytest.raises(ValueError):r.cases_for(calls,base,week)


@pytest.mark.parametrize('prefix',['runs/T34/','traces/T34/','runs/T33/','traces/T33/','runs/T31/',*r.STATIC])
def test_source_fixture_manifest_and_static_digests_fail(prefix):
    original=r.contests.sha
    with patch.object(r.contests,'sha',side_effect=lambda p:'0'*64 if Path(p).relative_to(ROOT).as_posix().startswith(prefix) else original(p)):
        assert r.main(['--check'])==1


def test_store_sites_and_dead_initial_previous_local_match_listing():
    ins={}
    for line in (ROOT/r.STATIC[0]).read_text().splitlines():
        m=re.match(r'^([0-9A-F]{4})  ((?:[0-9A-F]{2} )+)\s*(.*)',line)
        if m:ins[m[1]]=(len(m[2].split()),m[3])
    block={k:v for k,v in ins.items() if 0x3155<=int(k,16)<=0x325E}
    assert not any(v[1].startswith('call ') for v in block.values())
    assert ins['3159'][1]=='mov al, byte ptr [bp - 1]'
    assert ins['3166'][1]=='mov word ptr [bp - 6], ax'
    assert ins['3169'][1]=='mov byte ptr [bp - 1], 0'
    assert ins['31E3'][1]=='jae 0x3243'
    assert ins['3243'][1]=='mov ax, word ptr [bp - 4]'
    assert ins['3246'][1]=='mov word ptr [bp - 6], ax'
    assert ins['31CF'][1]=='mov word ptr es:[di + 0xa], ax'
    assert 0x31CF+ins['31CF'][0]==0x31D3
    assert ins['3223'][1]=='sub byte ptr es:[di + 0xa], al'
    assert ins['322B'][1]=='sub byte ptr [di - 0x3306], 3'
    assert ins['3235'][1]=='add byte ptr es:[di + 0xa], 3'
    assert ins['323E'][1]=='sub byte ptr [di - 0x3307], 3'


@pytest.mark.parametrize('off,seg',[(0xCCEF+26,0x1234),(0xCCEF+25,0x9999)])
def test_saved_scene_pointer_rejects_wrong_offset_or_segment(off,seg):
    class Guest:DS=0x1234
    with patch.object(r.arr,'local',side_effect=lambda g,n:off if n==-12 else seg):
        with pytest.raises(ValueError):r.pointer(Guest(),1)
