"""T25 original observation/provenance mutation checks."""
import copy
import json
import sys
from pathlib import Path
from unittest.mock import patch
import pytest

ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT/'runtime/emul'))
import replacement as r


@pytest.fixture(scope='module')
def sample():
    meta,base=next(r.sources())
    rec=json.loads((r.RUNS/'T25-r0001.json').read_text())
    return r.contests.outputs(rec)['calls'],r.contests.outputs(base)['calls'],meta['week']


def test_complete_public_corpus(): assert r.main(['--check'])==0


@pytest.mark.parametrize('damage',[
 'missing','order','step','a94b','arguments','span','input','output','extra',
 'player-missing','player-bool','player-alias','scene-missing','scene-order','scene-bounds','scene-projection',
 'direction','cached-player','global-missing','global-bool','total',
 'helper-missing','helper-order','helper-extra','helper-site','helper-args','helper-result','helper-draw',
 'helper-seed','helper-readonly','helper-first','rebuild-continuation','refresh-output','cache-loop',
 'managed-result','void-result','flag-player','log-slot','scene-pointer-selector'])
def test_malformed_or_discontinuous_capture_fails(sample,damage):
    original,retained,week=sample; calls=copy.deepcopy(original);c=calls[0];s=c['input'];h=c['helpers']
    def event(site): return next(e for e in h if e['site']==site)
    if damage=='missing': calls.pop()
    elif damage=='order': calls.reverse()
    elif damage=='step': c['step']+=1
    elif damage=='a94b': c['a94b']+=1
    elif damage=='arguments': c['arguments'][0]^=1
    elif damage=='span': c['draw_end']+=1
    elif damage=='input': s['selection']['pending']^=1
    elif damage=='output': c['output']['selection']['pending']^=1
    elif damage=='extra': s['expected_replacement']=0
    elif damage=='player-missing': s['players'].pop()
    elif damage=='player-bool': s['players'][0]['p15_6']=True
    elif damage=='player-alias': s['players'][1]['id']=s['players'][0]['id']
    elif damage=='scene-missing': s['scenes'].pop()
    elif damage=='scene-order': s['scenes'].reverse()
    elif damage=='scene-bounds': s['scenes'][0]['word2']=65536
    elif damage=='scene-projection': s['scenes'][0]['word14']^=1
    elif damage=='direction': s['directions'].pop()
    elif damage=='cached-player': s['cached_players'][0]=3921
    elif damage=='global-missing': s['globals'].pop('mode')
    elif damage=='global-bool': s['globals']['mode']=True
    elif damage=='total': s['club_totals'][0]=65536
    elif damage=='helper-missing': h.pop(0)
    elif damage=='helper-order': h.reverse()
    elif damage=='helper-extra': h.append(copy.deepcopy(h[-1]))
    elif damage=='helper-site': h[0]['site']='0AB9:FFFF'
    elif damage=='helper-args': h[0]['arguments'].pop()
    elif damage=='helper-result': event('0AB9:AEF0')['result']=2
    elif damage=='helper-draw': h[0]['draw_end']=c['draw_end']+1
    elif damage=='helper-seed': h[0]['input']['selection']['seed']^=1
    elif damage=='helper-readonly': event('0AB9:AEF0')['output']['globals']['mode']^=1
    elif damage=='helper-first': h[0]['input']['globals']['mode']^=1
    elif damage=='rebuild-continuation': event('0AB9:AFB7')['input']['globals']['mode']^=1
    elif damage=='refresh-output': h[-1]['output']['globals']['mode']^=1
    elif damage=='cache-loop': event('0AB9:B077')['arguments'][0]^=1
    elif damage=='managed-result': event('0AB9:AEF0')['result']^=1
    elif damage=='void-result': h[0]['result']=1
    elif damage=='flag-player': h[0]['arguments'][1]^=1
    elif damage=='log-slot': event('0AB9:AF7F')['arguments'][1]^=1
    elif damage=='scene-pointer-selector': event('0AB9:AFAA')['arguments'][0]^=1
    with pytest.raises(ValueError): r.cases_for(calls,retained,week)


@pytest.mark.parametrize('prefix',['runs/T25/','traces/T25/','runs/T23/','traces/T23/','runs/T22/','traces/T22/','static/1-0-exe/replacement-boundaries.json'])
def test_provenance_mutations_fail(prefix):
    original=r.contests.sha
    with patch.object(r.contests,'sha',side_effect=lambda p:'0'*64 if Path(p).relative_to(ROOT).as_posix().startswith(prefix) else original(p)):
        assert r.main(['--check'])==1


def test_modified_valid_helper_result_cannot_match_immutable_fixture():
    original=r.contests.outputs
    def altered(rec):
        value=original(rec)
        if rec.get('experiment')=='T25':
            value=copy.deepcopy(value)
            e=next(e for c in value['calls'] for e in c['helpers'] if e['site']=='0AB9:B08B')
            e['result']^=1
        return value
    with patch.object(r.contests,'outputs',side_effect=altered): assert r.main(['--check'])==1
