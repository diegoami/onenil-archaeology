import copy
import json
import sys
from pathlib import Path
from unittest.mock import patch
import pytest

ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT/'runtime/emul'))
import rearrangement as r


@pytest.fixture(scope='module')
def sample():
    meta,base=next(r.sources())
    rec=next(json.loads(p.read_text()) for p in sorted(r.RUNS.glob('T28-r*.json')) if json.loads(p.read_text())['status']=='completed')
    prior=json.loads((ROOT/base['actions']['source']['t25_record']).read_text())
    return r.contests.outputs(rec)['calls'],r.contests.outputs(prior)['calls'],meta['week']


def test_complete_targeted_corpus():assert r.main(['--check'])==0


@pytest.mark.parametrize('damage',[
 'missing','order','step','replacement','argument','span','input-boundary','output-boundary',
 'actor','actor-bool','secondary','cpu-bool','extra','event-missing','event-order','unknown-site',
 'availability-slot','availability-player','availability-result','availability-field','availability-selector',
 'division-denominator','division-result','division-write','assign-selector','assign-actor',
 'tail-missing','tail-order','tail-continuation','final-scene','final-actor',
 'swap-missing','swap-order','swap-args','swap-width','swap-value','swap-bool','swap-selectors',
 'mark-missing','mark-args','mark-output'])
def test_malformed_missing_or_discontinuous_observations_fail(sample,damage):
    original,retained,week=sample;calls=copy.deepcopy(original);c=calls[0];ev=c['events']
    def event(kind):return next(e for e in ev if e['kind']==kind)
    changed=next(c for c in calls if any(e['kind']=='roster' for e in c['events']))
    swaps=[e for e in changed['events'] if e['kind'] in r.SWAPS]
    mark=next(e for e in changed['events'] if e['kind']=='selectors')
    if damage=='missing':calls.pop()
    elif damage=='order':calls.reverse()
    elif damage=='step':c['step']+=1
    elif damage=='replacement':c['replacement']+=1
    elif damage=='argument':c['arguments'][0]^=1
    elif damage=='span':c['draw_end']+=1
    elif damage=='input-boundary':c['input']['rebuild']['outer']['globals']['mode']^=1
    elif damage=='output-boundary':c['output']['rebuild']['outer']['globals']['mode']^=1
    elif damage=='actor':c['input']['actor']^=1
    elif damage=='actor-bool':c['input']['actor']=True
    elif damage=='secondary':c['output']['secondary']^=1
    elif damage=='cpu-bool':c['input']['cpu_class']=False
    elif damage=='extra':c['input']['predicted_swap']=0
    elif damage=='event-missing':ev.pop(0)
    elif damage=='event-order':ev.reverse()
    elif damage=='unknown-site':ev[0]['site']='0AB9:FFFF'
    elif damage=='availability-slot':ev[0]['arguments'][1]+=1
    elif damage=='availability-player':ev[0]['arguments'][2]^=1
    elif damage=='availability-result':ev[0]['result']=2
    elif damage=='availability-field':ev[0]['input']['flags11']^=1
    elif damage=='availability-selector':ev[0]['input']['actor']^=1
    elif damage=='division-denominator':event('division')['arguments'][2]=23
    elif damage=='division-result':event('division')['result']['quotient']=4294967296
    elif damage=='division-write':event('division')['output']['club_totals'][0]^=1
    elif damage=='assign-selector':event('assign')['arguments'][1]^=1
    elif damage=='assign-actor':event('assign')['output']['actor']^=1
    elif damage=='tail-missing':ev.pop()
    elif damage=='tail-order':ev[-1],ev[-2]=ev[-2],ev[-1]
    elif damage=='tail-continuation':ev[-1]['input']['rebuild']['outer']['globals']['mode']^=1
    elif damage=='final-scene':c['output']['rebuild']['outer']['scenes'][0]['byte4']^=1
    elif damage=='final-actor':c['output']['actor']^=1
    elif damage=='swap-missing':changed['events'].remove(swaps[1])
    elif damage=='swap-order':
        a=changed['events'].index(swaps[0]);changed['events'][a],changed['events'][a+1]=changed['events'][a+1],changed['events'][a]
    elif damage=='swap-args':swaps[0]['arguments'][1]^=1
    elif damage=='swap-width':swaps[0]['arguments'][3]=1
    elif damage=='swap-value':swaps[0]['output']['a']^=1
    elif damage=='swap-bool':swaps[0]['input']['a']=True
    elif damage=='swap-selectors':swaps[0]['selectors_after']['actor']^=1
    elif damage=='mark-missing':changed['events'].remove(mark)
    elif damage=='mark-args':mark['arguments'][1]^=1
    elif damage=='mark-output':mark['output']['actor']^=1
    with pytest.raises(ValueError):r.cases_for(calls,retained,week)


@pytest.mark.parametrize('prefix',['runs/T28/','traces/T28/','runs/T26/','traces/T26/','runs/T25/','traces/T25/'])
def test_provenance_digest_mutations_fail(prefix):
    original=r.contests.sha
    with patch.object(r.contests,'sha',side_effect=lambda p:'0'*64 if Path(p).relative_to(ROOT).as_posix().startswith(prefix) else original(p)):
        assert r.main(['--check'])==1


def test_direct_call_and_return_sites_match_static_listing():
    import re
    targets={'16B6':'1B55:4F89','16E1':'26C9:0A67','174A':'1B55:4F89','17C0':'24BC:0203',
             '17D7':'24BC:0203','180E':'24BC:0203','1841':'24BC:0203','186C':'24BC:0203',
             '1971':'0AB9:8599','1985':'0AB9:10B9','1988':'0AB9:03BB','198B':'0AB9:1539','198E':'0AB9:3155','1991':'0AB9:21D7'}
    instructions={}
    for line in (ROOT/'static/1-0-exe/code/seg_0AB9_03.asm').read_text().splitlines():
        m=re.match(r'^([0-9A-F]{4})  ((?:[0-9A-F]{2} )+)\s*(.*)',line)
        if m:instructions[m[1]]=(len(m[2].split()),m[3])
    for site,(end,_) in r.SITES.items():
        off=site[5:];length,asm=instructions[off];assert asm.startswith('call ')
        target=asm[5:].removeprefix('far ')
        if ':' not in target:target=f'0AB9:{int(target,16)&65535:04X}'
        assert target==targets[off]
        assert end==f'0AB9:{int(off,16)+length:04X}'
