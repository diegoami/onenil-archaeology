import copy
import json
import re
import sys
from pathlib import Path
from unittest.mock import patch
import pytest

ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT/'runtime/emul'))
import proximity_selectors as r


@pytest.fixture(scope='module')
def sample():
    meta,base=next(r.sources())
    rec=next(json.loads(p.read_text()) for p in sorted(r.RUNS.glob('T35-r*.json')) if json.loads(p.read_text())['status']=='completed')
    return r.contests.outputs(rec)['calls'],base,meta['week']


def test_complete_original_proximity_corpus():assert r.main(['--check'])==0


@pytest.mark.parametrize('damage',[
 'missing','order','step','replacement','arguments','event','span','extra',
 'target-missing','target-bool','target-bound','phase-bool','phase-bound','time-bool','time-bound','sign-missing','sign-bool',
 'selector-missing','selector-bool','selector-bound','initialization-missing','initialization-order','initialization-side','initialization-value','initialization-draw',
 'visit-missing','visit-order','side-bool','slot-bool','scene','before','after','scene-input','scene-output','visit-draw',
 'helper-missing','helper-order','helper-kind','helper-args','helper-result','helper-draw','helper-write',
 'child-missing','child-args','child-return','child-extra','direction-result','direction-branch','direction-child','repeat-direction',
 'store-site','store-value','store-draw','store-extra','final-selector','unrelated-write'])
def test_missing_malformed_or_discontinuous_observations_fail(sample,damage):
    original,base,week=sample;cs=copy.deepcopy(original);c=cs[0];s=c['input'];a=c['initializations'][0]
    v=next(v for v in c['visits'] if len(v['helpers'])==3);h=v['helpers'][0];d=v['helpers'][1]
    if damage=='missing':cs.pop()
    elif damage=='order':cs.reverse()
    elif damage in ('step','replacement','event'):c[damage]+=1
    elif damage=='arguments':c['arguments'][0]^=1
    elif damage=='span':c['draw_end']+=1
    elif damage=='extra':s['prediction']=0
    elif damage=='target-missing':s['target'].pop()
    elif damage=='target-bool':s['target'][0]=False
    elif damage=='target-bound':s['target'][0]=256
    elif damage=='phase-bool':s['phase']=False
    elif damage=='phase-bound':s['phase']=256
    elif damage=='time-bool':s['time']=False
    elif damage=='time-bound':s['time']=65536
    elif damage=='sign-missing':s['signs'].pop()
    elif damage=='sign-bool':s['signs'][0]=False
    elif damage=='selector-missing':s['selectors']['near'].pop()
    elif damage=='selector-bool':s['selectors']['near'][0]=False
    elif damage=='selector-bound':s['selectors']['near'][0]=256
    elif damage=='initialization-missing':c['initializations'].pop()
    elif damage=='initialization-order':c['initializations'].reverse()
    elif damage=='initialization-side':a['side']=False
    elif damage=='initialization-value':a['output']['near'][0]^=1
    elif damage=='initialization-draw':a['draw']+=1
    elif damage=='visit-missing':c['visits'].pop()
    elif damage=='visit-order':c['visits'].reverse()
    elif damage=='side-bool':v['side']=False
    elif damage=='slot-bool':v['slot']=True
    elif damage=='scene':v['scene']^=1
    elif damage=='before':v['before']['near'][0]^=1
    elif damage=='after':v['after']['near'][0]^=1
    elif damage=='scene-input':v['input']['word0']^=1
    elif damage=='scene-output':v['output']['word0']^=1
    elif damage=='visit-draw':v['draw_end']+=1
    elif damage=='helper-missing':v['helpers'].pop()
    elif damage=='helper-order':v['helpers'].reverse()
    elif damage=='helper-kind':h['kind']='unknown'
    elif damage=='helper-args':h['arguments'][0]^=1
    elif damage=='helper-result':h['result']=2
    elif damage=='helper-draw':h['draw_end']+=1
    elif damage=='helper-write':h['output']['byte18']^=1
    elif damage=='child-missing':h['children']=[]
    elif damage=='child-args':h['children'][0]['arguments'][0]^=1
    elif damage=='child-return':h['children'][0]['result']^=1
    elif damage=='child-extra':h['children'][0]['children']=[copy.deepcopy(d)]
    elif damage=='direction-result':d['result']=256
    elif damage=='direction-branch':d['result']=2
    elif damage=='direction-child':d['children'][0]['arguments'][0]^=1
    elif damage=='repeat-direction':v['helpers'][2]['result']=0
    elif damage in ('store-site','store-value','store-draw'):
        store=next(st for v0 in c['visits'] for st in v0['stores'])
        if damage=='store-site':store['site']='0AB9:FFFF'
        elif damage=='store-value':store['output']['near'][0]^=1
        else:store['draw']+=1
    elif damage=='store-extra':v['stores'].append({'kind':'unknown'})
    elif damage=='final-selector':c['output']['selectors']['near'][0]^=1
    elif damage=='unrelated-write':c['output']['target'][0]^=1
    with pytest.raises(ValueError):r.cases_for(cs,base,week)


@pytest.mark.parametrize('prefix',['runs/T35/','traces/T35/','runs/T34/','traces/T34/','runs/T33/',*r.STATIC])
def test_source_fixture_manifest_and_static_digests_fail(prefix):
    original=r.contests.sha
    with patch.object(r.contests,'sha',side_effect=lambda p:'0'*64 if Path(p).relative_to(ROOT).as_posix().startswith(prefix) else original(p)):
        assert r.main(['--check'])==1


def test_call_return_and_store_sites_match_listings():
    ins={}
    for path in r.STATIC[:2]:
        for line in (ROOT/path).read_text().splitlines():
            m=re.match(r'^([0-9A-F]{4})  ((?:[0-9A-F]{2} )+)\s*(.*)',line)
            if m:ins[m[1]]=(len(m[2].split()),m[3])
    targets={'223D':'0x1ca1','1CAC':'far 1B55:4F89','22AC':'0x1ecc','22BF':'0x1ecc','1EF5':'0x1cbb'}
    for site,(end,_) in r.SITES.items():
        off=site[5:];length,asm=ins[off];assert asm=='call '+targets[off]
        assert end==f'0AB9:{int(off,16)+length:04X}'
    for off,end,asm in [('229C','22A0','mov byte ptr [di - 0x2f5c], dl'),('22E6','22EA','mov byte ptr [di - 0x2f5e], dl'),('2203','2208','mov byte ptr [di - 0x2f5e], 0')]:
        assert ins[off][1]==asm;assert int(off,16)+ins[off][0]==int(end,16)


@pytest.mark.parametrize('off,seg',[(0xCCEF,0x1234),(0xCCEF+26,0x1234),(0xCCEF+25,0x9999)])
def test_scene_pointer_identity_rejects_wrong_arguments(off,seg):
    class Guest:
        DS=0x1234
        def stack_word(self,n):return off if n==2 else seg
    with pytest.raises(ValueError):r.scene_argument(Guest())
