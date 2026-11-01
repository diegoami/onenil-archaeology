import copy
import json
import re
import sys
from pathlib import Path
from unittest.mock import patch
import pytest

ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT/'runtime/emul'))
import role_scoring as r


@pytest.fixture(scope='module')
def sample():
    meta,base=next(r.sources())
    rec=next(json.loads(p.read_text()) for p in sorted(r.RUNS.glob('T33-r*.json')) if json.loads(p.read_text())['status']=='completed')
    return r.contests.outputs(rec)['calls'],r.contests.outputs(base)['calls'],meta['week']


def test_complete_original_role_scoring_corpus():assert r.main(['--check'])==0


@pytest.mark.parametrize('damage',[
 'missing','order','event','step','replacement','kind','criterion','side','span','extra',
 'bonus-bool','bonus-bound','flags-missing','flag-bool','criterion-cell-bound',
 'lookup-missing','lookup-order','lookup-extra','lookup-alias','lookup-bool','first-index','second-index','first-cell',
 'club-missing','club-order','club-extra','roster-missing','roster-bool','roster-witness',
 'clear-before','clear-after','clear-draw','visit-missing','visit-order','slot-bool','scene','player','cache-before',
 'scene-input','scene-write','visit-draw','stored-bool','stored','cache-after','helper-missing','helper-order',
 'helper-site','helper-kind','helper-args','helper-result','helper-draw','helper-child',
 'score-scene','score-write','score-result','score-domain','table-missing','table-args','table-input','table-result',
 'final-cache','unrelated-write'])
def test_missing_malformed_or_discontinuous_observations_fail(sample,damage):
    original,retained,week=sample;calls=copy.deepcopy(original);c=calls[0];s=c['input'];v=c['visits'][1]
    h=v['helpers'][0];score=v['helpers'][2];table=score['children'][0]
    if damage=='missing':calls.pop()
    elif damage=='order':calls.reverse()
    elif damage in ('event','step','replacement'):c[damage]+=1
    elif damage=='kind':c['arguments'][0]=1
    elif damage=='criterion':c['arguments'][1]^=1
    elif damage=='side':c['arguments'][2]^=1
    elif damage=='span':c['draw_end']+=1
    elif damage=='extra':s['prediction']=0
    elif damage=='bonus-bool':s['bonus']=False
    elif damage=='bonus-bound':s['bonus']=256
    elif damage=='flags-missing':s['flags'].pop()
    elif damage=='flag-bool':s['flags'][0]=False
    elif damage=='criterion-cell-bound':s['criterion_cell']=256
    elif damage=='lookup-missing':s['lookups'].pop()
    elif damage=='lookup-order':s['lookups'].reverse()
    elif damage=='lookup-extra':s['lookups'][0]['prediction']=0
    elif damage=='lookup-alias':s['lookups'][0]['p8_4']^=1
    elif damage=='lookup-bool':s['lookups'][0]['p8_5']=False
    elif damage=='first-index':s['lookups'][0]['first_index']^=1
    elif damage=='second-index':s['lookups'][0]['second_index']^=1
    elif damage=='first-cell':s['lookups'][0]['first_cell']^=1
    elif damage=='club-missing':s['club_rosters'].pop()
    elif damage=='club-order':s['club_rosters'].reverse()
    elif damage=='club-extra':s['club_rosters'][0]['prediction']=0
    elif damage=='roster-missing':s['club_rosters'][0]['roster'].pop()
    elif damage=='roster-bool':s['club_rosters'][0]['roster'][0]=False
    elif damage=='roster-witness':
        for st in (c['input'],c['output']):
            for club in st['club_rosters']:club['roster']=[0]*11
    elif damage=='clear-before':c['clear']['before']^=1
    elif damage=='clear-after':c['clear']['after']=1
    elif damage=='clear-draw':c['clear']['draw']+=1
    elif damage=='visit-missing':c['visits'].pop()
    elif damage=='visit-order':c['visits'].reverse()
    elif damage=='slot-bool':v['slot']=True
    elif damage=='scene':v['scene']^=1
    elif damage=='player':v['player']^=1
    elif damage=='cache-before':v['cache_before']^=1
    elif damage=='scene-input':v['scene_input']['byte18']^=1
    elif damage=='scene-write':v['scene_output']['byte18']^=1
    elif damage=='visit-draw':v['draw_end']+=1
    elif damage=='stored-bool':v['stored']=False
    elif damage=='stored':v['stored']^=1
    elif damage=='cache-after':v['cache_after']^=1
    elif damage=='helper-missing':v['helpers'].pop()
    elif damage=='helper-order':v['helpers'].reverse()
    elif damage=='helper-site':h['site']='0AB9:FFFF'
    elif damage=='helper-kind':h['kind']='slot'
    elif damage=='helper-args':h['arguments'][0]^=1
    elif damage=='helper-result':h['result']=2
    elif damage=='helper-draw':h['draw_end']+=1
    elif damage=='helper-child':h['children']=[copy.deepcopy(table)]
    elif damage=='score-scene':score['arguments'][0]^=1
    elif damage=='score-write':score['scene_output']['byte18']^=1
    elif damage=='score-result':score['result']=65536
    elif damage=='score-domain':
        player=score['scene_input']['word14']
        for st in (c['input'],c['output']):next(p for p in r.players(st) if p['id']==player)['p15_6']=32
    elif damage=='table-missing':score['children']=[]
    elif damage=='table-args':table['arguments'][0]^=1
    elif damage=='table-input':table['input']['second_cell']^=1
    elif damage=='table-result':table['result']=65536
    elif damage=='final-cache':c['output']['context']['cache'][1]['players'][1]^=1
    elif damage=='unrelated-write':c['output']['bonus']^=1
    with pytest.raises(ValueError):r.cases_for(calls,retained,week)


@pytest.mark.parametrize('prefix',['runs/T33/','traces/T33/','runs/T31/','traces/T31/','runs/T30/','traces/T30/',*r.STATIC])
def test_source_fixture_manifest_and_static_digests_fail(prefix):
    original=r.contests.sha
    with patch.object(r.contests,'sha',side_effect=lambda p:'0'*64 if Path(p).relative_to(ROOT).as_posix().startswith(prefix) else original(p)):
        assert r.main(['--check'])==1


def test_nested_call_return_and_store_sites_match_listing():
    ins={}
    for path in r.STATIC[:2]:
        for line in (ROOT/path).read_text().splitlines():
            m=re.match(r'^([0-9A-F]{4})  ((?:[0-9A-F]{2} )+)\s*(.*)',line)
            if m:ins[m[1]]=(len(m[2].split()),m[3])
    targets={'14B8':'far 1B55:4F89','14EF':'0x8973','14FC':'0x1ae2','1509':'0x1ae2','1B60':'0xffff9f6e'}
    for site,(end,_) in r.SITES.items():
        off=site[5:];length,asm=ins[off]
        assert asm=='call '+targets[off]
        assert end==f'0AB9:{int(off,16)+length:04X}'
    assert ins['146B'][1]=='mov word ptr [di - 0x30a4], ax'
    assert 0x146B+ins['146B'][0]==0x146F
    assert ins['1511'][1]=='les di, ptr [bp - 8]'
    assert ins['1528'][1]=='mov word ptr [di - 0x30a4], cx'
    assert 0x1528+ins['1528'][0]==0x152C


@pytest.mark.parametrize('off,seg',[(0xCCEF,0x1234),(0xCCEF+26,0x1234),(0xCCEF+25,0x9999)])
def test_pointer_identity_rejects_wrong_scene_or_segment(off,seg):
    class Guest:DS=0x1234
    with pytest.raises(ValueError):r.pointer(Guest(),off,seg)
