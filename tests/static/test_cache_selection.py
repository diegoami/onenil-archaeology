import copy
import importlib.util
import json
from pathlib import Path
from unittest.mock import patch
import re
import pytest

ROOT=Path(__file__).resolve().parents[2]
spec=importlib.util.spec_from_file_location('cache_selection_contract',ROOT/'tools/static/cache_selection.py')
r=importlib.util.module_from_spec(spec);spec.loader.exec_module(r)


@pytest.fixture(scope='module')
def sample():return {kind:r.prior.contests.events(path) for kind,path in r.FILES.items()}


def test_complete_compact_original_cache_contracts():assert r.main(['--check'])==0


@pytest.mark.parametrize('kind',['selectors','ratings'])
@pytest.mark.parametrize('damage',['missing','order','step','event','input','output','bool','extra','source','draw'])
def test_compact_common_mutations_fail(sample,kind,damage):
    cases=copy.deepcopy(sample[kind]);c=cases[0]
    if damage=='missing':cases.pop()
    elif damage=='order':cases.reverse()
    elif damage=='step':c['step']+=1
    elif damage=='event':c['event']+=1
    elif damage=='input':
        if kind=='selectors':c['input']['players'][0]['p8_3']^=1
        else:c['input']['p8_3']^=1
    elif damage=='output':c['output']['player' if kind=='selectors' else 'value']^=1
    elif damage=='bool':
        if kind=='selectors':c['input']['side']=True
        else:c['output']['value']=False
    elif damage=='extra':c['input']['computed_winner']=0
    elif damage=='source':c['source']['record_sha256']='0'*64
    elif damage=='draw':c['draw_end']+=1
    with pytest.raises(ValueError):r.check_rows(cases,sample[kind],kind)


@pytest.mark.parametrize('damage',['roster-missing','roster-order','roster-bool','roster-bound',
 'players-missing','players-order','player-field','player-bool','byte-bound','byte-missing',
 'outside-player','zero-player','witness-byte','witness-flags','club','side'])
def test_selector_input_closure_and_defined_call_witness_fail(sample,damage):
    cases=copy.deepcopy(sample['selectors']);c=cases[0];s=c['input']
    if damage=='roster-missing':s['roster'].pop()
    elif damage=='roster-order':s['roster'].reverse()
    elif damage=='roster-bool':s['roster'][0]=False
    elif damage=='roster-bound':s['roster'][0]=3921
    elif damage=='players-missing':s['players'].pop()
    elif damage=='players-order':s['players'].reverse()
    elif damage=='player-field':s['players'][0]['expected_rating']=0
    elif damage=='player-bool':s['players'][0]['id']=True
    elif damage=='byte-bound':s['players'][0]['p8_1']=256
    elif damage=='byte-missing':del s['players'][0]['p8_5']
    elif damage=='outside-player':c['output']['player']=3920
    elif damage=='zero-player':c['output']['player']=0
    elif damage=='witness-byte':next(p for p in s['players'] if p['id']==c['output']['player'])['byte8']=128
    elif damage=='witness-flags':next(p for p in s['players'] if p['id']==c['output']['player'])['flags11']=1
    elif damage=='club':s['club']=0
    elif damage=='side':s['side']=2
    with pytest.raises(ValueError):r.check_rows(cases,sample['selectors'],'selectors')


@pytest.mark.parametrize('damage',['byte-bound','byte-missing','return-bound','player','side','slot','scene'])
def test_rating_inputs_word_return_and_identity_mutations_fail(sample,damage):
    cases=copy.deepcopy(sample['ratings']);c=cases[0]
    if damage=='byte-bound':c['input']['p8_5']=256
    elif damage=='byte-missing':del c['input']['p8_1']
    elif damage=='return-bound':c['output']['value']=65536
    elif damage=='player':c['player']^=1
    elif damage=='side':c['side']=2
    elif damage=='slot':c['slot']=0
    elif damage=='scene':c['scene']=23
    with pytest.raises(ValueError):r.check_rows(cases,sample['ratings'],'ratings')


@pytest.mark.parametrize('damage',['selector-write','rating-write','selector-draw','rating-draw','selector-argument','missing-player'])
def test_projection_rejects_bad_original_boundaries(damage):
    index=json.loads((r.prior.FIXTURES/'index.json').read_text());meta=index['records'][0]
    rec=json.loads((ROOT/meta['record']).read_text());calls=r.prior.contests.outputs(rec)['calls']
    e=next(e for e in calls[0]['events'] if e['kind']==('rating' if damage.startswith('rating') else 'select'))
    if damage.endswith('write'):e['output']['gate']^=1
    elif damage.endswith('draw'):e['draw_end']+=1
    elif damage=='selector-argument':e['arguments'][0]^=1
    elif damage=='missing-player':
        player=e['result'];e['input']['context']['rebuild']['outer']['players']=[p for p in e['input']['context']['rebuild']['outer']['players'] if p['id']!=player]
        e['output']=copy.deepcopy(e['input'])
    with pytest.raises(ValueError):r.project(calls,meta)


@pytest.mark.parametrize('prefix',['runs/T31/','traces/T31/','runs/T30/','traces/T30/','traces/T32/',r.STATIC[0],r.STATIC[1]])
def test_provenance_fixture_manifest_and_static_digest_mutations_fail(prefix):
    original=r.prior.contests.sha
    with patch.object(r.prior.contests,'sha',side_effect=lambda p:'0'*64 if Path(p).relative_to(ROOT).as_posix().startswith(prefix) else original(p)):
        assert r.main(['--check'])==1


def test_changed_existing_exports_are_never_overwritten(tmp_path):
    files={k:tmp_path/(k+'.jsonl') for k in r.FILES};index=tmp_path/'index.json'
    files['selectors'].write_bytes(b'existing')
    with patch.object(r,'FILES',files),patch.object(r,'INDEX',index):
        with pytest.raises(FileExistsError):r.write({k:b'changed' for k in files},{})
    assert files['selectors'].read_bytes()==b'existing'
    assert not files['ratings'].exists() and not index.exists()


def test_partial_identical_exports_resume_without_rewriting(tmp_path):
    files={k:tmp_path/(k+'.jsonl') for k in r.FILES};index=tmp_path/'index.json'
    files['selectors'].write_bytes(b'kept');before=files['selectors'].stat().st_mtime_ns
    with patch.object(r,'FILES',files),patch.object(r,'INDEX',index):
        r.write({'selectors':b'kept','ratings':b'new'},{});r.write({'selectors':b'kept','ratings':b'new'},{})
    assert files['selectors'].stat().st_mtime_ns==before
    assert files['ratings'].read_bytes()==b'new'


@pytest.mark.parametrize('file,start,end,expected',[
 (0,0x13B8,0x1452,['far 1B55:4F89','far 1B55:4EBF','far 1B55:4EBF']),
 (1,0x4EBF,0x4F02,[]),(1,0x4F89,0x5008,['far 24BC:0259']*4),
 (2,0x0259,0x0274,[])])
def test_complete_static_transitive_call_graph(file,start,end,expected):
    calls=[]
    for line in (ROOT/r.STATIC[file]).read_text().splitlines():
        m=re.match(r'^([0-9A-F]{4})  (?:[0-9A-F]{2} )+\s*call (.*)',line)
        if m and start<=int(m[1],16)<=end:calls.append(m[2])
    assert calls==expected
