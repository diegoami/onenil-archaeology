import copy
import json
import re
import sys
from pathlib import Path
from unittest.mock import patch
import pytest

ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT/'runtime/emul'))
import scene_codes as r


@pytest.fixture(scope='module')
def sample():
    meta,base=next(r.sources())
    rec=next(json.loads(p.read_text()) for p in sorted(r.RUNS.glob('T30-r*.json')) if json.loads(p.read_text())['status']=='completed')
    t28=json.loads((ROOT/base['actions']['source']['t28_record']).read_text())
    return r.contests.outputs(rec)['calls'],r.contests.outputs(t28)['calls'],meta['week']


def test_complete_original_scene_code_corpus():assert r.main(['--check'])==0


@pytest.mark.parametrize('damage',[
 'missing','order','step','replacement','argument','span','extra','input','output',
 'mode-bool','unsupported-mode','threshold-bound','clock-alias','direction-missing','direction-bool',
 'codes-missing','codes-bound','roles-missing','roles-bool','cache-missing','cache-order','cache-index-bool',
 'cache-word-bound','cache-extra','scene-missing','scene-order','scene-site','scene-kind','scene-argument',
 'scene-bool','scene-input','scene-output','scene-unrelated','scene-result','scene-draw',
 'cache-helper-missing','cache-entry','cache-final','cache-unrelated','cache-input-word','cache-result',
 'code-missing','code-order','code-site','code-index','code-packed','code-bool','code-input','code-output',
 'code-unrelated','code-result-bound','code-draw','code-continuation'])
def test_missing_malformed_or_discontinuous_observations_fail(sample,damage):
    original,retained,week=sample;calls=copy.deepcopy(original);c=calls[0];s=c['input']
    e=c['events'][0];cache=c['events'][-1];h=cache['calls'][0]
    if damage=='missing':calls.pop()
    elif damage=='order':calls.reverse()
    elif damage=='step':c['step']+=1
    elif damage=='replacement':c['replacement']+=1
    elif damage=='argument':c['arguments'][0]^=1
    elif damage=='span':c['draw_end']+=1
    elif damage=='extra':s['predicted_code']=0
    elif damage=='input':s['context']['actor']^=1
    elif damage=='output':c['output']['context']['secondary']^=1
    elif damage=='mode-bool':s['mode']=False
    elif damage=='unsupported-mode':s['mode']=5
    elif damage=='threshold-bound':s['threshold']=256
    elif damage=='clock-alias':s['clock']^=1
    elif damage=='direction-missing':s['direction_signs'].pop()
    elif damage=='direction-bool':s['direction_signs'][0]=True
    elif damage=='codes-missing':s['codes'].pop()
    elif damage=='codes-bound':s['codes'][0]=256
    elif damage=='roles-missing':s['role_codes'].pop()
    elif damage=='roles-bool':s['role_codes'][0]=False
    elif damage=='cache-missing':s['cache'].pop()
    elif damage=='cache-order':s['cache'].reverse()
    elif damage=='cache-index-bool':s['cache'][0]['index']=False
    elif damage=='cache-word-bound':s['cache'][0]['word0']=65536
    elif damage=='cache-extra':s['cache'][0]['raw_bytes']='00'
    elif damage=='scene-missing':c['events'].pop(0)
    elif damage=='scene-order':c['events'][0],c['events'][1]=c['events'][1],c['events'][0]
    elif damage=='scene-site':e['site']='0AB9:FFFF'
    elif damage=='scene-kind':e['kind']='cache'
    elif damage=='scene-argument':e['arguments'][0]=2
    elif damage=='scene-bool':e['output']['byte4']=False
    elif damage=='scene-input':e['input']['byte4']^=1
    elif damage=='scene-output':e['output']['index']=2
    elif damage=='scene-unrelated':e['output']['word20']^=1
    elif damage=='scene-result':e['result']=0
    elif damage=='scene-draw':e['draw_end']=c['draw_end']+1
    elif damage=='cache-helper-missing':c['events'].pop()
    elif damage=='cache-entry':cache['input']['cache'][0]['word4']^=1
    elif damage=='cache-final':cache['output']['cache'][0]['word4']^=1
    elif damage=='cache-unrelated':cache['output']['threshold']^=1
    elif damage=='cache-input-word':cache['output']['cache'][0]['word0']^=1
    elif damage=='cache-result':cache['result']=0
    elif damage=='code-missing':cache['calls'].pop()
    elif damage=='code-order':cache['calls'].reverse()
    elif damage=='code-site':h['site']='0AB9:FFFF'
    elif damage=='code-index':h['arguments'][0]^=1
    elif damage=='code-packed':h['arguments'][1]^=1
    elif damage=='code-bool':h['arguments'][0]=True
    elif damage=='code-input':h['input']['byte6']^=1
    elif damage=='code-output':h['output']['index']^=1
    elif damage=='code-unrelated':h['output']['byte4']^=1
    elif damage=='code-result-bound':h['result']=65536
    elif damage=='code-draw':h['draw_end']=c['draw_end']+1
    elif damage=='code-continuation':cache['calls'][1]['input']['byte6']^=1
    with pytest.raises(ValueError):r.cases_for(calls,retained,week)


@pytest.mark.parametrize('prefix',['runs/T30/','traces/T30/','runs/T29/','traces/T29/','runs/T28/','traces/T28/',*r.STATIC])
def test_source_fixture_manifest_and_static_digest_mutations_fail(prefix):
    original=r.contests.sha
    with patch.object(r.contests,'sha',side_effect=lambda p:'0'*64 if Path(p).relative_to(ROOT).as_posix().startswith(prefix) else original(p)):
        assert r.main(['--check'])==1


def instructions(file):
    out={}
    for line in (ROOT/file).read_text().splitlines():
        m=re.match(r'^([0-9A-F]{4})  ((?:[0-9A-F]{2} )+)\s*(.*)',line)
        if m:out[int(m[1],16)]=(len(m[2].split()),m[3])
    return out


def test_direct_observation_call_and_return_targets():
    ins=instructions(r.STATIC[0])
    for site,(end,kind) in r.SITES.items():
        address=int(site[5:],16);length,asm=ins[address]
        assert asm=={'scene':'call 0x2d7','cache':'call 0x33e','code':'call 0x143'}[kind]
        assert end==f'0AB9:{address+length:04X}'


@pytest.mark.parametrize('file,start,end,expected',[
 (0,0x0000,0x001D,[]),
 (0,0x0143,0x0204,['0x1ecc']*3),
 (0,0x0207,0x02D4,['0x143']),
 (0,0x02D7,0x033B,['0','0x1cbb','0x207','0x1cbb']),
 (0,0x033E,0x03BA,['0x1cd6','0x143','0x1cd6','0x143']),
 (0,0x03BB,0x03E1,['0x2d7','0x33e']),
 (1,0x1CBB,0x1CD3,[]),(1,0x1CD6,0x1CEB,[]),
 (1,0x1ECC,0x1F09,['0x1cbb'])])
def test_complete_static_transitive_call_graph(file,start,end,expected):
    assert [asm[5:] for off,(_,asm) in instructions(r.STATIC[file]).items()
            if start<=off<=end and asm.startswith('call ')]==expected
