import copy,json,sys
from pathlib import Path
from unittest.mock import patch
import pytest
ROOT=Path(__file__).resolve().parents[2];sys.path.insert(0,str(ROOT/'runtime/emul'))
import quick_reset as qr
def test_complete_public_quick_reset_corpus():assert qr.main(['--check'])==0
@pytest.fixture(scope='module')
def sample():
    r=json.loads(next(iter(sorted(qr.RUNS.glob('T21-r*.json')))).read_text());meta,prior,cases,_,base,prefixes=next(qr.sources());source=base['actions']['source']
    return qr.contests.outputs(r)['calls'],cases,qr.contests.outputs(prior)['ledger'],prefixes,source,qr.contests.events(ROOT/source['trace']),meta
@pytest.mark.parametrize('damage',['missing','order','seed','actor','remaining','scene','slot','player-missing','byte-bool','cache-size','copy-missing','copy-order','motion-missing','motion-type','keeper-seed','strategy-input','strategy-output','helper-missing','helper-type','helper-order'])
def test_incomplete_mistyped_boundaries_and_shared_observations_fail(sample,damage):
    calls,*rest=sample;calls=copy.deepcopy(calls);c=calls[0];s=c['input']
    if damage=='missing':calls.pop()
    elif damage=='order':calls.reverse()
    elif damage=='seed':s['strategy']['seed']^=1
    elif damage=='actor':s['actor']^=1
    elif damage=='remaining':s['remaining']^=1
    elif damage=='scene':s['scenes'][0]['word0']^=1
    elif damage=='slot':s['scenes'][0]['slot']=0
    elif damage=='player-missing':s['players'].pop()
    elif damage=='byte-bool':s['players'][0]['byte6']=True
    elif damage=='cache-size':s['cache'][0].pop()
    elif damage=='copy-missing':c['copies'].pop()
    elif damage=='copy-order':c['copies'].reverse()
    elif damage=='motion-missing':c['motions'].pop()
    elif damage=='motion-type':c['motions'][0]['after']=1.0
    elif damage=='keeper-seed':c['keeper']['output']['strategy']['seed']^=1
    elif damage=='strategy-input':c['strategy_input']['strategy']['seed']^=1
    elif damage=='strategy-output':c['strategy_output']['strategy']['seed']^=1
    elif damage=='helper-missing':c['helpers'].pop()
    elif damage=='helper-type':next(h for h in c['helpers'] if h['kind']=='byte6')['input']['delta']=-1.0
    elif damage=='helper-order':c['helpers'].reverse()
    with pytest.raises(ValueError):qr.cases_for(calls,*rest)
@pytest.mark.parametrize('prefix',['runs/T21/','traces/T21/','runs/T20/','traces/T20/','runs/T16/','traces/T16/'])
def test_corrupt_record_fixture_and_retained_source_digests_fail(prefix):
    original=qr.contests.sha
    with patch.object(qr.contests,'sha',side_effect=lambda p:'0'*64 if Path(p).relative_to(ROOT).as_posix().startswith(prefix) else original(p)):
        assert qr.main(['--check'])==1
