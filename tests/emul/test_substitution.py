import copy,json,sys
from pathlib import Path
from unittest.mock import patch
import pytest
ROOT=Path(__file__).resolve().parents[2];sys.path.insert(0,str(ROOT/'runtime/emul'))
import substitution as sub


def test_complete_public_substitution_corpus():assert sub.main(['--check'])==0


@pytest.fixture(scope='module')
def sample():
    r=json.loads(next(iter(sorted(sub.RUNS.glob('T22-r*.json')))).read_text())
    meta,prior,_,_,base,prefixes=next(sub.sources());source=base['actions']['source']
    return sub.contests.outputs(r)['calls'],sub.contests.outputs(prior)['ledger'],prefixes,source,sub.contests.events(ROOT/source['trace']),meta


@pytest.mark.parametrize('damage',['missing','order','seed','end-seed','scene-order','slot','player-missing','byte-bool','club-alias','offset-alias','totals-size','total-bounds','helper-missing','helper-order','helper-side','helper-result','helper-context','helper-site','output-mutation','span','extra-field'])
def test_incomplete_mistyped_or_discontinuous_observations_fail(sample,damage):
    calls,*rest=sample;calls=copy.deepcopy(calls);c=calls[0];s=c['input']
    if damage=='missing':calls.pop()
    elif damage=='order':calls.reverse()
    elif damage=='seed':s['seed']^=1
    elif damage=='end-seed':c['output']['seed']^=1
    elif damage=='scene-order':s['scenes'].reverse()
    elif damage=='slot':s['scenes'][0]['slot']=0
    elif damage=='player-missing':s['players'].pop()
    elif damage=='byte-bool':s['players'][0]['byte8']=True
    elif damage=='club-alias':s['clubs'][1]['id']=s['clubs'][0]['id']
    elif damage=='offset-alias':s['side_offsets']=[0,0]
    elif damage=='totals-size':s['event_totals'][0].pop()
    elif damage=='total-bounds':s['event_totals'][0][0]=65536
    elif damage=='helper-missing':c['events'].pop()
    elif damage=='helper-order':c['events'].reverse()
    elif damage=='helper-side':c['events'][0]['side']^=1
    elif damage=='helper-result':c['events'][0]['result']=2
    elif damage=='helper-context':c['events'][0]['argument']^=1
    elif damage=='helper-site':c['events'][0]['site']='0AB9:6BD5'
    elif damage=='output-mutation':c['output']['pending']^=1
    elif damage=='span':c['draw_end']+=1
    elif damage=='extra-field':s['guessed']=0
    with pytest.raises(ValueError):sub.cases_for(calls,*rest)


@pytest.mark.parametrize('prefix',['runs/T22/','traces/T22/','runs/T20/','traces/T20/','runs/T16/','traces/T16/'])
def test_corrupt_record_fixture_and_retained_source_digests_fail(prefix):
    original=sub.contests.sha
    with patch.object(sub.contests,'sha',side_effect=lambda p:'0'*64 if Path(p).relative_to(ROOT).as_posix().startswith(prefix) else original(p)):
        assert sub.main(['--check'])==1


@pytest.mark.parametrize('damage',['input','output','span','arguments','extra'])
def test_opaque_ai_boundaries_remain_contiguous_and_typed(sample,damage):
    calls,*rest=sample;calls=copy.deepcopy(calls)
    e=next(e for c in calls for e in c['events'] if e['kind']=='ai')
    if damage=='input':e['input']['pending']^=1
    elif damage=='output':e['output']['pending']^=1
    elif damage=='span':e['draw_end']+=1
    elif damage=='arguments':e['arguments'][1]^=1
    elif damage=='extra':e['expected_replacement']=0
    with pytest.raises(ValueError):sub.cases_for(calls,*rest)


def test_each_mandatory_helper_is_required(sample):
    original,*rest=sample
    for i,e in enumerate(original[0]['events']):
        if e['kind'] not in ('managed','keeper','capacity'):continue
        calls=copy.deepcopy(original);calls[0]['events'].pop(i)
        with pytest.raises(ValueError):sub.cases_for(calls,*rest)


def test_unexplained_control_mutation_fails(sample):
    calls,*rest=sample;calls=copy.deepcopy(calls);calls[0]['output']['control']^=1
    with pytest.raises(ValueError):sub.cases_for(calls,*rest)
