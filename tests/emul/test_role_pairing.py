import copy
import json
import re
import sys
from pathlib import Path
from unittest.mock import patch
import pytest

ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT/'runtime/emul'))
import role_pairing as r


@pytest.fixture(scope='module')
def sample():
    meta,base=next(r.sources())
    rec=next(json.loads(p.read_text()) for p in sorted(r.RUNS.glob('T29-r*.json')) if json.loads(p.read_text())['status']=='completed')
    return r.contests.outputs(rec)['calls'],r.contests.outputs(base)['calls'],meta['week']


def test_complete_original_pairing_corpus():assert r.main(['--check'])==0


@pytest.mark.parametrize('damage',[
 'missing','order','step','replacement','argument','span','extra','input','output',
 'actor-bool','club-missing','club-order','club-bool','club-bound','club-extra',
 'pass-missing','pass-order','pass-bool','cell-missing','cell-bool','cell-bound','cell-extra',
 'flag-write','preference-write','player-write','scene-write',
 'range-missing','range-order','range-site','range-side','range-low','range-high','range-bool',
 'local-missing','local-bool','local-bound','assigned-bound','length','sentinel','initialized',
 'continuation','range-draw','range-result'])
def test_malformed_missing_or_discontinuous_cases_fail(sample,damage):
    original,retained,week=sample;calls=copy.deepcopy(original);c=calls[0]
    s=c['input'];e=c['ranges'][0]
    if damage=='missing':calls.pop()
    elif damage=='order':calls.reverse()
    elif damage=='step':c['step']+=1
    elif damage=='replacement':c['replacement']+=1
    elif damage=='argument':c['arguments'][0]^=1
    elif damage=='span':c['draw_end']+=1
    elif damage=='extra':s['computed_pairing']=0
    elif damage=='input':s['context']['actor']^=1
    elif damage=='output':c['output']['context']['secondary']^=1
    elif damage=='actor-bool':s['context']['actor']=True
    elif damage=='club-missing':s['club_flags'].pop()
    elif damage=='club-order':s['club_flags'].reverse()
    elif damage=='club-bool':s['club_flags'][0]['id']=True
    elif damage=='club-bound':s['club_flags'][0]['byte57']=256
    elif damage=='club-extra':s['club_flags'][0]['decoded_name']='x'
    elif damage=='pass-missing':s['preferences'].pop()
    elif damage=='pass-order':s['preferences'].reverse()
    elif damage=='pass-bool':s['preferences'][0]['pass']=True
    elif damage=='cell-missing':s['preferences'][0]['roles'].pop()
    elif damage=='cell-bool':s['preferences'][0]['roles'][0]=False
    elif damage=='cell-bound':s['preferences'][0]['roles'][0]=256
    elif damage=='cell-extra':s['preferences'][0]['raw_bytes']='00'
    elif damage=='flag-write':c['output']['club_flags'][0]['byte57']^=1
    elif damage=='preference-write':c['output']['preferences'][0]['roles'][0]^=1
    elif damage=='player-write':c['output']['context']['rebuild']['outer']['players'][0]['p15_10']^=1
    elif damage=='scene-write':c['output']['context']['rebuild']['outer']['scenes'][0]['byte4']^=1
    elif damage=='range-missing':c['ranges'].pop()
    elif damage=='range-order':c['ranges'].reverse()
    elif damage=='range-site':e['site']='0AB9:FFFF'
    elif damage=='range-side':e['arguments'][0]=1
    elif damage=='range-low':e['arguments'][1]^=1
    elif damage=='range-high':e['arguments'][2]^=1
    elif damage=='range-bool':e['arguments'][0]=False
    elif damage=='local-missing':e['input']['own'].pop()
    elif damage=='local-bool':e['input']['opponent'][1]=False
    elif damage=='local-bound':e['input']['own'][1]=256
    elif damage=='assigned-bound':e['output']['assigned'][1]=12
    elif damage=='length':e['input']['own'][0]=9
    elif damage=='sentinel':e['output']['assigned'][0]=1
    elif damage=='initialized':e['input']['assigned'][1]=1
    elif damage=='continuation':c['ranges'][1]['input']['own'][1]^=1
    elif damage=='range-draw':e['draw_end']=c['draw_end']+1
    elif damage=='range-result':e['result']=0
    with pytest.raises(ValueError):r.cases_for(calls,retained,week)


@pytest.mark.parametrize('prefix',['runs/T29/','traces/T29/','runs/T28/','traces/T28/','runs/T26/','traces/T26/',*r.STATIC])
def test_provenance_mutations_fail(prefix):
    original=r.contests.sha
    with patch.object(r.contests,'sha',side_effect=lambda p:'0'*64 if Path(p).relative_to(ROOT).as_posix().startswith(prefix) else original(p)):
        assert r.main(['--check'])==1


def test_direct_range_calls_and_returns_match_listing():
    instructions={}
    for line in (ROOT/r.STATIC[0]).read_text().splitlines():
        m=re.match(r'^([0-9A-F]{4})  ((?:[0-9A-F]{2} )+)\s*(.*)',line)
        if m:instructions[m[1]]=(len(m[2].split()),m[3])
    for site,(end,_,_) in r.RANGES.items():
        off=site[5:];length,asm=instructions[off]
        assert asm=='call 0x1000'
        assert end==f'0AB9:{int(off,16)+length:04X}'
