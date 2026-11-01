import copy
import importlib.util
import json
from pathlib import Path
from unittest.mock import patch
import pytest

ROOT=Path(__file__).resolve().parents[2]
spec=importlib.util.spec_from_file_location('rating_flags_contract',ROOT/'tools/static/rating_flags.py')
r=importlib.util.module_from_spec(spec);spec.loader.exec_module(r)


@pytest.fixture(scope='module')
def sample():return r.rep.contests.events(r.CASES)


def test_complete_compact_original_corpus():assert r.main(['--check'])==0


@pytest.mark.parametrize('damage',['missing','order','input','output','bool','bounds','extra','player','source','draw','helper'])
def test_compact_mutations_fail(sample,damage):
    rows=copy.deepcopy(sample)
    if damage=='missing':rows.pop()
    elif damage=='order':rows.reverse()
    elif damage=='input':rows[0]['input']['p8_1']^=1
    elif damage=='output':rows[0]['output']['flags10']^=1
    elif damage=='bool':rows[0]['input']['p8_3']=False
    elif damage=='bounds':rows[0]['output']['flags10']=256
    elif damage=='extra':rows[0]['input']['computed_rating']=0
    elif damage=='player':rows[0]['player']^=1
    elif damage=='source':rows[0]['source']['record_sha256']='0'*64
    elif damage=='draw':rows[0]['draw_end']+=1
    elif damage=='helper':rows[0]['helper']+=1
    with pytest.raises(ValueError):r.check_rows(rows,sample)


@pytest.mark.parametrize('damage',['global','other-player','same-player','missing-helper','extra-helper','draw'])
def test_projection_rejects_unrelated_mutations(damage):
    index=json.loads((r.rep.FIXTURES/'index.json').read_text());meta=index['records'][0]
    rec=json.loads((ROOT/meta['record']).read_text());calls=copy.deepcopy(r.rep.contests.outputs(rec)['calls'])
    c=calls[0];e=next(e for e in c['helpers'] if e['site']=='0AB9:AFDA')
    if damage=='global':e['output']['globals']['mode']^=1
    elif damage=='other-player':
        next(p for p in e['output']['players'] if p['id']!=e['arguments'][0])['p15_10']^=1
    elif damage=='same-player':next(p for p in e['output']['players'] if p['id']==e['arguments'][0])['p15_2']^=1
    elif damage=='missing-helper':c['helpers'].remove(e)
    elif damage=='extra-helper':c['helpers'].append(copy.deepcopy(e))
    elif damage=='draw':e['draw_end']+=1
    with pytest.raises(ValueError):r.project(calls,meta)


@pytest.mark.parametrize('prefix',['runs/T25/','traces/T25/','runs/T23/','traces/T23/','traces/T27/','static/1-0-exe/code/seg_1B55_08.asm'])
def test_source_or_fixture_digests_fail(prefix):
    original=r.rep.contests.sha
    with patch.object(r.rep.contests,'sha',side_effect=lambda p:'0'*64 if Path(p).relative_to(ROOT).as_posix().startswith(prefix) else original(p)):
        assert r.main(['--check'])==1


def test_existing_exports_are_preserved(tmp_path):
    cases=tmp_path/'cases.jsonl';index=tmp_path/'index.json';cases.write_bytes(b'existing')
    with patch.object(r,'CASES',cases),patch.object(r,'INDEX',index):
        with pytest.raises(FileExistsError):r.write(b'changed',{})
    assert cases.read_bytes()==b'existing' and not index.exists()
