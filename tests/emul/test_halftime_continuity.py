import copy,json,sys
from pathlib import Path
from unittest.mock import patch
import pytest
ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT/'runtime/emul'))
import halftime_continuity as r

@pytest.fixture(scope='module')
def sample():
    meta,base=next(r.sources());m15,r15=r.t15_source(meta['week'])
    rec=next(json.loads(p.read_text()) for p in sorted(r.RUNS.glob('T37-r*.json')) if json.loads(p.read_text())['status']=='completed')
    return r.contests.outputs(rec),meta,base,m15,r15

def test_complete_original_halftime_corpus():assert r.main(['--check'])==0

@pytest.mark.parametrize('damage',[
 'initial-missing','initial-bool','initial-alias','initial-seed','initial-ratings','pairing-missing','codes-missing',
 'phase-missing','phase-order','phase-step','phase-draw','phase-seed','phase-return',
 'rr-missing','rr-order','rr-caller','rr-draw','rr-step','rr-seed','rr-readonly','rr-gate',
 'rating-missing','rating-order','rating-caller','rating-step','rating-bool','rating-side','rating-draw','quarter-missing','quarter-unrelated',
 'cap-missing','cap-order','cap-class','cap-bool','cap-draw','cap-unrelated','cap-final','retained-t36','retained-upstream','retained-t15'])
def test_incomplete_wrong_or_unrelated_observations_fail(sample,damage):
    orig,_,base,_,r15=sample;o=copy.deepcopy(orig);a=o['initial'];ph=o['phases'];rr=o['rearrangements'];rates=o['outside_ratings'];c=rates[0]
    if damage=='initial-missing':del a['gates']['editor']
    elif damage=='initial-bool':a['gates']['editor']=False
    elif damage=='initial-alias':a['codes']['context']['actor']^=1
    elif damage=='initial-seed':a['seed']^=1
    elif damage=='initial-ratings':a['ratings'][0]^=1
    elif damage=='pairing-missing':a['pairing']['preferences'].pop()
    elif damage=='codes-missing':a['codes']['role_codes'].pop()
    elif damage=='phase-missing':ph.pop()
    elif damage=='phase-order':ph.reverse()
    elif damage=='phase-step':ph[0]['step']+=1
    elif damage=='phase-draw':ph[0]['draw']+=1
    elif damage=='phase-seed':ph[3]['state']['seed']^=1
    elif damage=='phase-return':ph[-1]['state']['seed']^=1
    elif damage=='rr-missing':rr.pop(0)
    elif damage=='rr-order':rr.reverse()
    elif damage=='rr-caller':rr[0]['caller']='0AB9:FFFF'
    elif damage=='rr-draw':rr[0]['draw_end']+=1
    elif damage=='rr-step':next(c for c in rr if c['caller']=='0AB9:B0C9')['step']+=1
    elif damage=='rr-seed':rr[0]['output']['seed']^=1
    elif damage=='rr-readonly':rr[0]['output']['pairing']['preferences'][0]['roles'][0]^=1
    elif damage=='rr-gate':rr[0]['output']['gates']['editor']^=1
    elif damage=='rating-missing':rates.pop()
    elif damage=='rating-order':rates.reverse()
    elif damage=='rating-caller':c['caller']='0AB9:322E'
    elif damage=='rating-step':c['step']=1
    elif damage=='rating-bool':c['step']=False
    elif damage=='rating-side':c['side']['output']['ratings'][0]^=1
    elif damage=='rating-draw':c['draw_end']+=1
    elif damage=='quarter-missing':c['quartered'].pop()
    elif damage=='quarter-unrelated':c['quartered'][0]^=1
    elif damage=='cap-missing':c['caps'].pop()
    elif damage=='cap-order':c['caps'].reverse()
    elif damage=='cap-class':c['caps'][0]['class']=4
    elif damage=='cap-bool':c['caps'][0]['class']=False
    elif damage=='cap-draw':c['caps'][0]['draw']+=1
    elif damage=='cap-unrelated':c['caps'][0]['ratings'][0]^=1
    elif damage=='cap-final':c['caps'][-1]['ratings'][7]^=1
    elif damage=='retained-t36':o['retained']['t36_calls']='0'*64
    elif damage=='retained-upstream':o['retained']['upstream'].pop()
    elif damage=='retained-t15':o['retained']['t15']['sides']='0'*64
    with pytest.raises((ValueError,KeyError)):r.validate_observations(o,base,r15)

@pytest.mark.parametrize('prefix',['runs/T37/','traces/T37/',*r.STATIC])
def test_own_source_fixture_manifest_and_static_corruption_fail(sample,prefix):
    _,meta,base,m15,r15=sample;sha=r.contests.sha
    # Parent corpora were independently verified by sample and the complete check.
    # Isolate this task's own digest gate rather than repeating every parent validator.
    with patch.object(r,'sources',return_value=iter([(meta,base)])),patch.object(r,'t15_source',return_value=(m15,r15)),patch.object(r.contests,'sha',side_effect=lambda p:'0'*64 if Path(p).relative_to(ROOT).as_posix().startswith(prefix) else sha(p)):
        assert r.main(['--check'])==1

def test_hook_and_store_sites_are_actual_instructions():
    paths={p.name:p.read_text() for p in (ROOT/'static/1-0-exe/code').glob('*.asm')}
    for name,sites in [('seg_0AB9_03.asm',['164F','199E']),('seg_0AB9_13.asm',['7DD3','7E4C','7E4F','7E6E','7E71']),('seg_1B55_05.asm',['322B','3255','3279'])]:
        for site in sites:assert any(l.startswith(site+'  ') for l in paths[name].splitlines())
