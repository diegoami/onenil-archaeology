import copy
import json
import sys
from pathlib import Path
from unittest.mock import patch
import pytest

ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT/'runtime/emul'))
import rebuild as r


@pytest.fixture(scope='module')
def sample():
    meta,base=next(r.sources())
    rec=json.loads((r.RUNS/'T26-r0001.json').read_text())
    return r.contests.outputs(rec)['calls'],r.contests.outputs(base)['calls'],meta['week']


def test_public_rebuild_corpus():assert r.main(['--check'])==0


@pytest.mark.parametrize('damage',[
 'missing','order','step','replacement','scene','span','input','output','extra',
 'club-missing','club-order','club-bool','index-bool','index-bounds','cell-bounds','cell-missing','club-output',
 'helper-missing','helper-order','helper-site','helper-kind','helper-draw','helper-nesting',
 'scene-row','scene-bool','assign-output','stored-predicate','keeper-result','direction-continuation',
 'slot-arguments','club-arguments','minimum-arguments','minimum-result','half-arguments','hand-missing',
 'hand-arguments','hand-continuation','read-only-scene','entry-row'])
def test_incomplete_mistyped_or_discontinuous_rebuilds_fail(sample,damage):
    original,retained,week=sample;calls=copy.deepcopy(original);c=calls[0];s=c['input'];h=c['helpers']
    assign=h[0];children=assign['children'];half=children[-1]
    if damage=='missing':calls.pop()
    elif damage=='order':calls.reverse()
    elif damage=='step':c['step']+=1
    elif damage=='replacement':c['replacement']+=1
    elif damage=='scene':c['scene']^=1
    elif damage=='span':c['draw_end']+=1
    elif damage=='input':s['outer']['globals']['mode']^=1
    elif damage=='output':c['output']['outer']['globals']['mode']^=1
    elif damage=='extra':s['expected_rebuild']=0
    elif damage=='club-missing':s['club_counts'].pop()
    elif damage=='club-order':s['club_counts'].reverse()
    elif damage=='club-bool':s['club_counts'][0]['id']=True
    elif damage=='index-bool':s['club_counts'][0]['index40']=True
    elif damage=='index-bounds':s['club_counts'][0]['index42']=65536
    elif damage=='cell-bounds':s['club_counts'][0]['cell40']=256
    elif damage=='cell-missing':s['club_counts'][0].pop('cell42')
    elif damage=='club-output':c['output']['club_counts'][0]['cell40']^=1
    elif damage=='helper-missing':h.pop()
    elif damage=='helper-order':h.reverse()
    elif damage=='helper-site':children[0]['site']='0AB9:FFFF'
    elif damage=='helper-kind':children[0]['kind']='side'
    elif damage=='helper-draw':children[0]['draw_end']=c['draw_end']+1
    elif damage=='helper-nesting':half['children'].append(copy.deepcopy(children[0]))
    elif damage=='scene-row':assign['scene_input']['index']^=1
    elif damage=='scene-bool':assign['scene_input']['byte6']=True
    elif damage=='assign-output':assign['scene_output']['word0']^=1
    elif damage=='stored-predicate':assign['scene_output']['byte22']^=1
    elif damage=='keeper-result':h[1]['result']^=1
    elif damage=='direction-continuation':h[2]['scene_input']['word0']^=1
    elif damage=='slot-arguments':children[0]['arguments'][0]^=1
    elif damage=='club-arguments':children[2]['arguments'][0]^=1
    elif damage=='minimum-arguments':children[3]['arguments'][0]^=1
    elif damage=='minimum-result':children[3]['result']=4294967296
    elif damage=='half-arguments':half['arguments'][0]^=1
    elif damage=='hand-missing':half['children'].clear()
    elif damage=='hand-arguments':half['children'][0]['arguments'][0]^=1
    elif damage=='hand-continuation':half['children'][0]['scene_input']['word2']^=1
    elif damage=='read-only-scene':children[0]['scene_output']['word0']^=1
    elif damage=='entry-row':assign['scene_input']['word2']^=1
    with pytest.raises(ValueError):r.cases_for(calls,retained,week)


@pytest.mark.parametrize('prefix',['runs/T26/','traces/T26/','runs/T25/','traces/T25/','runs/T23/','traces/T23/'])
def test_provenance_digest_mutations_fail(prefix):
    original=r.contests.sha
    with patch.object(r.contests,'sha',side_effect=lambda p:'0'*64 if Path(p).relative_to(ROOT).as_posix().startswith(prefix) else original(p)):
        assert r.main(['--check'])==1


def test_every_helper_call_and_return_site_matches_static_listing():
    import re
    instructions={}
    for path in (ROOT/'static/1-0-exe/code').glob('seg_*.asm'):
        segment=path.stem.split('_')[1]
        for line in path.read_text().splitlines():
            m=re.match(r'^([0-9A-F]{4})  ((?:[0-9A-F]{2} )+)\s*(.*)',line)
            if m:instructions[f'{segment}:{m[1]}']=(len(m[2].split()),m[3])
    for site,(end,_) in r.SITES.items():
        length,asm=instructions[site]
        assert asm.startswith('call ')
        segment,offset=site.split(':')
        assert end==f'{segment}:{(int(offset,16)+length)&65535:04X}'


def test_far_lookup_wraps_offset_without_changing_segment():
    class Memory:
        def rd(self,address):return {0x100:65534,0x102:0x1234}[address]
        def mem(self,address,n):
            assert (address,n)==(0x12340+2,1)
            return b'\x7f'
    assert r.far_value(Memory(),0x100,65540,1)==127


@pytest.mark.parametrize('damage',['minimum-result','cell','hand-result'])
def test_valid_typed_changes_cannot_match_immutable_original_fixture(damage):
    original=r.contests.outputs
    def altered(rec):
        value=original(rec)
        if rec.get('experiment')=='T26':
            value=copy.deepcopy(value);c=value['calls'][0]
            if damage=='cell':
                for k in ('input','output'):c[k]['club_counts'][0]['cell40']^=1
            else:
                kind='minimum32' if damage=='minimum-result' else 'hand'
                e=next(e for e in r.flatten(c['helpers']) if e['kind']==kind)
                e['result']^=1
        return value
    with patch.object(r.contests,'outputs',side_effect=altered):assert r.main(['--check'])==1
