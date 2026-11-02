import copy,json,sys
from pathlib import Path
from unittest.mock import patch
import pytest
ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT/'runtime/emul'))
import match_setup as r

@pytest.fixture(scope='module')
def sample():
    meta,base=next(r.sources());draws,_=r.setup_draws(base)
    assert r.selected_runs(),'missing completed setup capture'
    _,rec=next(iter(r.selected_runs().values()))
    return r.contests.outputs(rec),meta,base,draws

def test_complete_original_setup_corpus():assert r.main(['--check'])==0

@pytest.mark.parametrize('damage',[
    'admission-missing','admission-player','admission-roster','admission-bool','admission-legacy','admission-readset',
    'point-missing','point-order','point-site','point-draw','point-bool','point-seed','point-alias','point-readonly','mode-bool','mode-alias','numeric-weight','reserve-index','club-field','scene-mode',
    'selector-changed','first-t36','first-t37','income-missing','income-order','income-caller','income-draw',
    'income-club','income-table','income-bool','income-return','draw-missing','draw-order','draw-value','retained'])
def test_missing_reordered_mistyped_alias_and_source_fail(sample,damage):
    orig,_,base,draws=sample;o=copy.deepcopy(orig);p=o['points'];a=o['admission'];c=o['incomes'][0]
    if damage=='admission-missing':del a['read_sets']
    elif damage=='admission-player':a['players'].pop()
    elif damage=='admission-roster':a['clubs'][0]['roster'].pop()
    elif damage=='admission-bool':a['config'][0]=False
    elif damage=='admission-legacy':a['legacy']['cached_players'][0]^=1
    elif damage=='admission-readset':a['read_sets']['positions'].pop()
    elif damage=='point-missing':p.pop()
    elif damage=='point-order':p.reverse()
    elif damage=='point-site':p[0]['site']='0AB9:FFFF'
    elif damage=='point-draw':p[0]['draw']+=1
    elif damage=='point-bool':p[0]['draw']=False
    elif damage=='point-seed':p[3]['state']['caller']['seed']^=1
    elif damage=='point-alias':p[2]['state']['caller']['codes']['context']['actor']^=1
    elif damage=='point-readonly':p[2]['state']['initial']['ratings']['tables']['home_divisors'][0]+=1
    elif damage=='mode-bool':p[6]['state']['initial']['events']['mode']=False
    elif damage=='mode-alias':p[6]['state']['initial']['reset']['mode']=1
    elif damage=='numeric-weight':p[2]['state']['setup_cells']['numeric_weights'].pop()
    elif damage=='reserve-index':p[2]['state']['setup_cells']['reserve_cell']['index']^=1
    elif damage=='club-field':p[2]['state']['setup_cells']['club_fields'][0]['byte55']^=1
    elif damage=='scene-mode':p[2]['state']['setup_cells']['scene_mode']=False
    elif damage=='selector-changed':p[1]['state']['initial']['selectors'][0]['value']^=1
    elif damage=='first-t36':p[-1]['state']['initial']['config'][0]^=1
    elif damage=='first-t37':p[-1]['state']['caller']['ratings'][0]^=1
    elif damage=='income-missing':o['incomes'].pop()
    elif damage=='income-order':o['incomes'].reverse()
    elif damage=='income-caller':c['caller']='1B55:FFFF'
    elif damage=='income-draw':c['draw_end']+=1
    elif damage=='income-club':c['input']['club']=1
    elif damage=='income-table':c['input']['table'].pop()
    elif damage=='income-bool':c['input']['strength']=False
    elif damage=='income-return':c['result']=-1
    elif damage=='draw-missing':o['draws'].pop()
    elif damage=='draw-order':o['draws'].reverse()
    elif damage=='draw-value':o['draws'][0]['value']^=1
    elif damage=='retained':o['retained']='0'*64
    with pytest.raises((ValueError,KeyError,IndexError)):r.validate_observations(o,base,draws)

@pytest.mark.parametrize('prefix',['runs/T38/','traces/T38/',*r.STATIC])
def test_source_static_fixture_provenance_fail(sample,prefix):
    _,meta,base,_=sample;sha=r.contests.sha
    with patch.object(r,'sources',return_value=iter([(meta,base)])),patch.object(r.contests,'sha',side_effect=lambda p:'0'*64 if Path(p).relative_to(ROOT).as_posix().startswith(prefix) else sha(p)):
        assert r.main(['--check'])==1

def test_actual_setup_sites_are_instructions():
    rows={line[:4] for p in (ROOT/'static/1-0-exe/code').glob('seg_0AB9_*.asm') for line in p.read_text().splitlines() if len(line)>6 and line[4:6]=='  '}
    for site in r.SITES:assert site.split(':')[1] in rows

def test_preparation_mode_zero_is_structural_only_and_never_changes_data(sample):
    o,_,_,_=sample
    before=copy.deepcopy(o['points'][6]['state'])
    assert before['caller']['gates']['quick']==0
    r.validate_state(o['points'][6]['state'])
    assert o['points'][6]['state']==before

@pytest.fixture(scope='module')
def input_sample():
    _,base=next(iter(r.selected_runs().values()))
    records=[json.loads(p.read_text()) for p in sorted(r.RUNS.glob('T38-input-r*.json')) if json.loads(p.read_text())['status']=='completed']
    assert len(records)==1,'missing successful input supplement'
    return r.contests.outputs(records[0]),base

@pytest.mark.parametrize('damage',['initial','draws','capacity-missing','capacity-bool','club','factor-index','factor-value','fixture-missing','start-bool'])
def test_input_supplement_identity_shape_and_aliases_fail(input_sample,damage):
    orig,base=input_sample;o=copy.deepcopy(orig);f=o['fields']
    if damage=='initial':o['initial_sha256']='0'*64
    elif damage=='draws':o['draws'].pop()
    elif damage=='capacity-missing':f['capacities'].pop()
    elif damage=='capacity-bool':f['capacities'][0]['byte']=False
    elif damage=='club':f['club_factors'][0]['club']=1
    elif damage=='factor-index':f['club_factors'][0]['address']^=1
    elif damage=='factor-value':f['club_factors'][0]['value']=-1
    elif damage=='fixture-missing':f['fixture_factors'].pop()
    elif damage=='start-bool':f['start_gate']=False
    with pytest.raises((ValueError,KeyError,IndexError)):r.validate_inputs(o,base)

def test_input_supplement_record_hash_is_checked(input_sample):
    sha=r.contests.sha
    with patch.object(r.contests,'sha',side_effect=lambda p:'0'*64 if Path(p).name.startswith('T38-input-') else sha(p)):
        assert r.input_index()!=json.loads((r.FIXTURES/'input-index.json').read_text())

def test_input_manifest_resumes_after_completed_record(tmp_path):
    expected={'schema':'setup-input-index/1','record':'runs/T38/T38-input-r0001.json'}
    with patch.object(r,'FIXTURES',tmp_path),patch.object(r,'input_index',return_value=expected):
        r.write_input_index()
        path=tmp_path/'input-index.json';original=path.read_bytes();stamp=path.stat().st_mtime_ns
        r.write_input_index()
        assert path.read_bytes()==original and path.stat().st_mtime_ns==stamp
        path.write_text('{}')
        with pytest.raises(ValueError):r.write_input_index()
