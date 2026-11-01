import copy
import json
import re
import sys
from pathlib import Path
from unittest.mock import patch
import pytest

ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT/'runtime/emul'))
import player_cache as r


@pytest.fixture(scope='module')
def sample():
    meta,base=next(r.sources())
    rec=next(json.loads(p.read_text()) for p in sorted(r.RUNS.glob('T31-r*.json')) if json.loads(p.read_text())['status']=='completed')
    t29=json.loads((ROOT/base['actions']['source']['t29_record']).read_text())
    t28=json.loads((ROOT/t29['actions']['source']['t28_record']).read_text())
    return r.contests.outputs(rec)['calls'],r.contests.outputs(t28)['calls'],meta['week']


def test_complete_original_player_cache_corpus():assert r.main(['--check'])==0


@pytest.mark.parametrize('damage',[
 'missing','order','step','replacement','argument','span','extra','input','output',
 'gate-bool','gate-bound','criteria-missing','criteria-bool','criteria-bound',
 'cache-missing','cache-order','cache-side-bool','cache-player-missing','cache-player-bool','cache-player-bound','cache-alias',
 'event-missing','event-order','unknown-site','unknown-kind','side-bool','wrong-side','event-draw',
 'managed-argument','managed-result','managed-branch','readonly-write','selector-side','selector-bound',
 'role-missing','role-kind','role-criterion','role-side','role-result','role-write',
 'rating-missing','rating-slot','rating-scene','rating-player','rating-bound','rating-write',
 'store-missing','store-order','store-argument','store-input','store-bool','store-index','store-unrelated','store-result','store-draw',
 'extra-event','final-cache','final-scene'])
def test_missing_malformed_or_discontinuous_observations_fail(sample,damage):
    original,retained,week=sample;calls=copy.deepcopy(original);c=calls[0];s=c['input'];events=c['events']
    def event(kind):return next(e for e in events if e['kind']==kind)
    m=event('managed');sel=event('select');role=event('role');rating=event('rating');mark=event('store')
    if damage=='missing':calls.pop()
    elif damage=='order':calls.reverse()
    elif damage=='step':c['step']+=1
    elif damage=='replacement':c['replacement']+=1
    elif damage=='argument':c['arguments'][0]^=1
    elif damage=='span':c['draw_end']+=1
    elif damage=='extra':s['predicted_cache']=0
    elif damage=='input':s['context']['actor']^=1
    elif damage=='output':c['output']['context']['secondary']^=1
    elif damage=='gate-bool':s['gate']=False
    elif damage=='gate-bound':s['gate']=256
    elif damage=='criteria-missing':s['criteria'].pop()
    elif damage=='criteria-bool':s['criteria'][0]=True
    elif damage=='criteria-bound':s['criteria'][0]=256
    elif damage=='cache-missing':s['cache'].pop()
    elif damage=='cache-order':s['cache'].reverse()
    elif damage=='cache-side-bool':s['cache'][0]['side']=False
    elif damage=='cache-player-missing':s['cache'][0]['players'].pop()
    elif damage=='cache-player-bool':s['cache'][0]['players'][1]=False
    elif damage=='cache-player-bound':s['cache'][0]['players'][1]=3921
    elif damage=='cache-alias':s['cache'][0]['players'][0]^=1
    elif damage=='event-missing':events.pop(0)
    elif damage=='event-order':events.reverse()
    elif damage=='unknown-site':m['site']='0AB9:FFFF'
    elif damage=='unknown-kind':m['kind']='unknown'
    elif damage=='side-bool':m['side']=False
    elif damage=='wrong-side':m['side']^=1
    elif damage=='event-draw':m['draw_end']=c['draw_end']+1
    elif damage=='managed-argument':m['arguments'][0]^=1
    elif damage=='managed-result':m['result']=2
    elif damage=='managed-branch':m['result']^=1
    elif damage=='readonly-write':m['output']['criteria'][0]^=1
    elif damage=='selector-side':sel['arguments'][0]^=1
    elif damage=='selector-bound':sel['result']=3921
    elif damage=='role-missing':events.remove(role)
    elif damage=='role-kind':role['arguments'][0]^=1
    elif damage=='role-criterion':role['arguments'][1]^=1
    elif damage=='role-side':role['arguments'][2]^=1
    elif damage=='role-result':role['result']=0
    elif damage=='role-write':role['output']['gate']^=1
    elif damage=='rating-missing':events.remove(rating)
    elif damage=='rating-slot':rating['arguments'][0]^=1
    elif damage=='rating-scene':rating['arguments'][1]^=1
    elif damage=='rating-player':rating['arguments'][2]^=1
    elif damage=='rating-bound':rating['result']=65536
    elif damage=='rating-write':rating['output']['criteria'][0]^=1
    elif damage=='store-missing':events.remove(mark)
    elif damage=='store-order':
        i=events.index(mark);events[i],events[i-1]=events[i-1],events[i]
    elif damage=='store-argument':mark['arguments'][0]^=1
    elif damage=='store-input':mark['input']['byte18']^=1
    elif damage=='store-bool':mark['output']['byte18']=False
    elif damage=='store-index':mark['output']['index']^=1
    elif damage=='store-unrelated':mark['output']['byte4']^=1
    elif damage=='store-result':mark['result']=0
    elif damage=='store-draw':mark['draw_end']=c['draw_end']+1
    elif damage=='extra-event':events.append(copy.deepcopy(mark))
    elif damage=='final-cache':c['output']['cache'][0]['players'][1]^=1
    elif damage=='final-scene':r.rows(c['output'])[0]['byte18']^=1
    with pytest.raises(ValueError):r.cases_for(calls,retained,week)


@pytest.mark.parametrize('prefix',['runs/T31/','traces/T31/','runs/T30/','traces/T30/','runs/T28/','traces/T28/',r.STATIC[0],r.STATIC[3]])
def test_source_fixture_manifest_and_static_digests_fail(prefix):
    original=r.contests.sha
    with patch.object(r.contests,'sha',side_effect=lambda p:'0'*64 if Path(p).relative_to(ROOT).as_posix().startswith(prefix) else original(p)):
        assert r.main(['--check'])==1


def test_direct_call_return_and_caller_store_sites_match_listing():
    ins={}
    for line in (ROOT/r.STATIC[0]).read_text().splitlines():
        m=re.match(r'^([0-9A-F]{4})  ((?:[0-9A-F]{2} )+)\s*(.*)',line)
        if m:ins[m[1]]=(len(m[2].split()),m[3])
    targets={'1569':'far 1B55:0E7A','1588':'0x13b8','15B3':'0x1455','15D0':'far 1B55:4F89',
             '15DF':'0x577f','15ED':'0xffffb6bd','1630':'far 1B55:4EBF'}
    for site,(end,_) in r.SITES.items():
        off=site[5:];length,asm=ins[off]
        assert asm=='call '+targets[off]
        assert end==f'0AB9:{int(off,16)+length:04X}'
    length,asm=ins['163A'];assert asm=='add byte ptr es:[di + 0x12], al'
    assert 0x163A+length==0x163E
