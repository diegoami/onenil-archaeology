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
    'point-missing','point-order','point-site','point-draw','point-bool','point-seed','point-alias','point-readonly',
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
