import copy
import json
import sys
from pathlib import Path
from unittest.mock import patch
import pytest

ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT/'runtime/emul'))
import post_score as ps

def test_complete_public_post_score_corpus(): assert ps.main(['--check'])==0

@pytest.fixture(scope='module')
def specimen():
    rec=json.loads(next(iter(sorted(ps.RUNS.glob('T20-r*.json')))).read_text())
    meta,prior,prefixes=next(ps.sources());source=prior['actions']['source'];trace=ps.contests.events(ROOT/source['trace'])
    return ps.contests.outputs(rec),meta,prefixes,source,trace

@pytest.mark.parametrize('damage',['missing-call','order','seed','score','club','player-missing','player-alias','byte-bool','lookup-alias','setter-missing','normalizer-missing','normalizer-input','normalizer-output','path-kind','getter-byte','ledger-missing','phase-missing','phase-order','phase-span','phase-seed'])
def test_incomplete_mistyped_alias_and_boundary_observations_fail(specimen,damage):
    values,meta,prefixes,source,trace=specimen;values=copy.deepcopy(values);calls,ledger=values['calls'],values['ledger'];c=calls[0];s=c['input']
    if damage=='missing-call':calls.pop()
    elif damage=='order':calls.reverse()
    elif damage=='seed':s['seed']^=1
    elif damage=='score':s['scores'][0]^=1
    elif damage=='club':s['clubs'][0]['id']=0
    elif damage=='player-missing':s['players'].pop()
    elif damage=='player-alias':s['players'].append(copy.deepcopy(s['players'][0]))
    elif damage=='byte-bool':s['players'][0]['level']=True
    elif damage=='lookup-alias':s['clubs'][1]['baseline_index']=s['clubs'][0]['baseline_index'];s['clubs'][1]['baseline_value']=s['clubs'][0]['baseline_value']^1
    elif damage=='setter-missing':c['setters'].pop()
    elif damage=='normalizer-missing':c['normalizers'].pop()
    elif damage=='normalizer-input':c['normalizers'][0]['before']^=1
    elif damage=='normalizer-output':c['normalizers'][-1]['after']^=1
    elif damage=='path-kind':c['paths'][0]['routine']='0AB9:FFFF'
    elif damage=='getter-byte':c['getters'][0]['value']=65536
    elif damage=='ledger-missing':ledger.pop()
    elif damage=='phase-missing':ledger[0]['phases'].pop()
    elif damage=='phase-order':ledger[0]['phases'].reverse()
    elif damage=='phase-span':ledger[0]['phases'][0]['draw_start']+=1
    elif damage=='phase-seed':ledger[0]['phases'][0]['seed_before']^=1
    with pytest.raises(ValueError):ps.cases_for(calls,ledger,prefixes,source,trace,meta)

@pytest.mark.parametrize('prefix',['runs/T20/','traces/T20/','runs/T16/','traces/T16/','traces/T08/'])
def test_changed_source_record_fixture_hashes_fail(prefix):
    original=ps.contests.sha
    with patch.object(ps.contests,'sha',side_effect=lambda p:'0'*64 if Path(p).relative_to(ROOT).as_posix().startswith(prefix) else original(p)):
        assert ps.main(['--check'])==1
