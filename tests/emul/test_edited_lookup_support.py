"""T73 public narrow-request and authenticated-record corruption controls."""
import copy,importlib.util,json,sys
from pathlib import Path
import pytest
ROOT=Path(__file__).resolve().parents[2];sys.path.insert(0,str(ROOT/'runtime/emul'))
spec=importlib.util.spec_from_file_location('lookup_test',ROOT/'runtime/emul/edited_lookup_support.py');m=importlib.util.module_from_spec(spec);spec.loader.exec_module(m)

def request():return json.loads((ROOT/'traces/T73/requests-r0001.json').read_text())

@pytest.mark.parametrize('damage',['oversize','empty','duplicate','foreign','schema','bool','negative','seed','owned'])
def test_exact_lookup_request_refusals(damage):
    value=request();m.request_check(value)
    if damage=='oversize':value['fields']+=value['fields'][:1]
    elif damage=='empty':value['fields']=[]
    elif damage=='duplicate':value['fields'][1]=value['fields'][0]
    elif damage=='foreign':value['fields'][0]['area']='config'
    elif damage=='schema':value['schema']='fresh-caller-read-request/1'
    elif damage=='bool':value['fields'][0]['offset']=True
    elif damage=='negative':value['fields'][0]['offset']=-1
    elif damage=='seed':value['fields'][0]['offset']=0xA51C
    else:value['fields'][0]['offset']=0xD56
    with pytest.raises(ValueError):m.request_check(value)

def test_t72_policy_still_refuses_the_unwitnessed_address():
    import edited_support as old
    with pytest.raises(ValueError):old.request_check(dict(schema='fresh-caller-read-request/1',fields=[dict(area='ds',offset=0xD4B)]))

@pytest.mark.parametrize('damage',['source','producer','ui','rng','join','ownership','request','opaque'])
def test_actual_original_lookup_corruption_refuses(damage):
    value=json.loads((ROOT/'runs/T73/lookup-r0001.json').read_text());m.check(value);bad=copy.deepcopy(value)
    if damage=='source':bad['source']['state_sha256']='0'*64
    elif damage=='producer':bad['producer_files'].pop(m.TOOL)
    elif damage=='ui':bad['ui'][2]['selected_player']=2583
    elif damage=='rng':bad['payload']['draw_count']-=1
    elif damage=='join':bad['payload']['points'][0]['join_sha256']='0'*64
    elif damage=='ownership':bad['payload']['fields'][0]['incoming']=not bad['payload']['fields'][0]['incoming']
    elif damage=='request':bad['request']['path']='traces/T72/requests-r0001.json'
    else:bad['opaque']=True
    bad['payload_sha256']=m.prior.sha(m.prior.encoded(bad['payload']))
    with pytest.raises(ValueError):m.check(bad)

def test_independent_pair_and_accepted_overlap():
    d=ROOT/'runs/T73';value=m.catalog((d/'lookup-r0001.json',d/'lookup-r0002.json'))
    assert len(value['incoming'])==32
    assert any(r['offset']==0xD4B for r in value['incoming'])
    assert 0<value['overlap_count']<32


def test_overlap_source_identity_is_pinned(monkeypatch):
    pins=dict(m.T72_PINS);pins['support-r0001.json']='0'*64
    monkeypatch.setattr(m,'T72_PINS',pins)
    d=ROOT/'runs/T73'
    with pytest.raises(ValueError,match='accepted T72 source pin'):
        m.catalog((d/'lookup-r0001.json',d/'lookup-r0002.json'))
