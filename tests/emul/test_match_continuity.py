import copy
import json
import sys
from pathlib import Path
from unittest.mock import patch
import pytest

ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT/'runtime/emul'))
import match_continuity as r

@pytest.fixture(scope='module')
def sample():
    _,base=next(r.sources())
    record=next(json.loads(p.read_text()) for p in sorted(r.RUNS.glob('T36-r*.json')) if json.loads(p.read_text())['status']=='completed')
    tail,t12,_,draws=r.source_data(base)
    return r.contests.outputs(record),r.contests.outputs(t12)['steps'],r.contests.outputs(tail)['calls'],draws

def test_complete_original_continuity_corpus():assert r.main(['--check'])==0

@pytest.mark.parametrize('damage',[
 'missing','reordered','entry-clock','step-bool','input-seed','output-seed','draw','clock','poll-key','poll-bool','poll-missing','poll-draw','poll-output',
 'admission-missing','config-missing','config-alias','selector-missing','selector-order','selector-bool','history-missing','history-bool',
 'ratings-missing','staff-missing','skills-missing','positions-missing','neutral-missing','first-seed'])
def test_broken_observations_fail(sample,damage):
    orig,t12,t16,draws=sample;o=copy.deepcopy(orig);calls=o['calls'];a=o['admission'];c=calls[0]
    if damage=='missing':calls.pop()
    elif damage=='reordered':calls.reverse()
    elif damage=='entry-clock':c['entry_clock']['clock']['remaining']^=1
    elif damage=='step-bool':c['step']=False
    elif damage=='input-seed':c['input']['seed']^=1
    elif damage=='output-seed':c['output']['seed']^=1
    elif damage=='draw':c['draw_end']+=1
    elif damage=='clock':c['clock']['output']['seed']^=1
    elif damage=='poll-key':c['neutral']['poll_al']=1
    elif damage=='poll-bool':c['neutral']['poll_al']=False
    elif damage=='poll-missing':del c['neutral']['poll_al']
    elif damage=='poll-draw':c['neutral']['draw_start']+=1
    elif damage=='poll-output':c['neutral']['output']['speed']^=1
    elif damage=='admission-missing':del a['events']
    elif damage=='config-missing':a['config'].pop()
    elif damage=='config-alias':a['config'][2]^=1
    elif damage=='selector-missing':a['selectors'].pop()
    elif damage=='selector-order':a['selectors'].reverse()
    elif damage=='selector-bool':a['selectors'][0]['value']=False
    elif damage=='history-missing':del a['history']['value']
    elif damage=='history-bool':a['history']['value']=False
    elif damage=='ratings-missing':del a['ratings']['tables']['position_class']
    elif damage=='staff-missing':a['ratings']['bonuses'][0]['staff'].pop()
    elif damage=='skills-missing':a['skills'].pop()
    elif damage=='positions-missing':a['positions']['positions'].pop()
    elif damage=='neutral-missing':del a['neutral']['auto_switch']
    elif damage=='first-seed':a['clock']['seed']^=1
    with pytest.raises((ValueError,KeyError)):r.validate_calls(calls,a,t12,t16,draws)

@pytest.mark.parametrize('prefix',['runs/T36/','traces/T36/','runs/T35/','traces/T35/',*r.STATIC])
def test_provenance_and_static_corruption_fail(prefix):
    sha=r.contests.sha
    with patch.object(r.contests,'sha',side_effect=lambda p:'0'*64 if Path(p).relative_to(ROOT).as_posix().startswith(prefix) else sha(p)):
        assert r.main(['--check'])==1

def test_retained_receipt_damage_fails(sample):
    _,base=next(r.sources());out=copy.deepcopy(sample[0]);out['retained'][0]['calls_sha256']='0'*64
    with pytest.raises(ValueError,match='retained'):r.validate_record({'outputs':[{'name':k,'value':v} for k,v in out.items()]},base)


def test_ratings_observer_does_not_alias_static_rating_tool():
    import subprocess
    code="""
import sys,types
from pathlib import Path
sys.path.insert(0,'runtime/emul')
stub=types.ModuleType('ratings');sys.modules['ratings']=stub
import match_continuity
assert sys.modules['ratings'] is stub
assert match_continuity.ratings is not stub
assert Path(match_continuity.ratings.__file__).resolve()==Path('runtime/emul/ratings.py').resolve()
assert callable(match_continuity.ratings.tables)
"""
    subprocess.run([sys.executable,'-c',code],cwd=ROOT,check=True)
