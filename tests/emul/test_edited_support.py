"""T72 synthetic guard tests plus authenticated original-record corruption controls."""
import copy,importlib.util,json,sys
from pathlib import Path
import pytest
ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT/'runtime/emul'))
spec=importlib.util.spec_from_file_location('edited_support_test',ROOT/'runtime/emul/edited_support.py');module=importlib.util.module_from_spec(spec);spec.loader.exec_module(module)

def request():return dict(schema='fresh-caller-read-request/1',fields=[dict(area='ds',offset=0xB18)])

@pytest.mark.parametrize('damage',['empty','oversized','duplicate','seed','player','watch','mode','negative','bool','extra','unrequested'])
def test_requests_remain_bounded_and_disjoint(damage):
    value=request();module.request_check(value);bad=copy.deepcopy(value)
    if damage=='empty':bad['fields']=[]
    elif damage=='oversized':bad['fields']*=1025
    elif damage=='duplicate':bad['fields']*=2
    elif damage=='seed':bad['fields'][0]['offset']=0xA51C
    elif damage=='player':bad['fields'][0]['area']='p8'
    elif damage in ('watch','mode'):bad['fields'][0]=dict(area='config',offset=0xF2 if damage=='watch' else 0xF6)
    elif damage=='negative':bad['fields'][0]['offset']=-1
    elif damage=='bool':bad['fields'][0]['offset']=True
    elif damage=='extra':bad['fields'][0]['value']=0
    else:
        known=module.known_requests();offset=next(i for i in range(256) if module.allowed('config',i) and ('config',i) not in known)
        bad['fields'][0]=dict(area='config',offset=offset)
    with pytest.raises(ValueError):module.request_check(bad)

def witness():
    base=module.source();points=[]
    for i,(site,digest,draw) in enumerate(module.preparation_joins(base)):
        income=base['payload']['points'][(0,2,7)[min(i,2)]]['income_total']
        fields=dict(managed_selection_mode=0,legacy_income_total=income,legacy_queue_zero=dict(index=0,code=0,first_player=0,second_player=0,side=0))
        points.append(dict(site=site,join_sha256=digest,draw_count=draw,fields=fields))
    prep=dict(points=points,eligible={k:points[0]['fields'][k]==points[1]['fields'][k] for k in points[0]['fields']})
    payload=dict(points=[dict(site=s,join_sha256=d) for s,d in zip(module.SITES,module.joins(base))],draw_count=258,draws_sha256=module.prior.sha(module.prior.encoded(base['payload']['draws'])),fields=[dict(area='ds',offset=0xB18,before=3,precall=3,entry=3,incoming=True)],preparation=prep)
    return base,payload

@pytest.mark.parametrize('damage',['site','join','rng','domain','ownership','prep_site','prep_draw','prep_income','prep_bool','queue','eligibility','opaque'])
def test_source_and_ownership_aliases_refuse(damage):
    base,payload=witness();module.payload_check(payload,request(),base);bad=copy.deepcopy(payload)
    if damage=='site':bad['points'][0]['site']='foreign'
    elif damage=='join':bad['points'][0]['join_sha256']='0'*64
    elif damage=='rng':bad['draw_count']=257
    elif damage=='domain':bad['fields'][0]['before']=256
    elif damage=='ownership':bad['fields'][0]['incoming']=False
    elif damage=='prep_site':bad['preparation']['points'][1]['site']='foreign'
    elif damage=='prep_draw':bad['preparation']['points'][1]['draw_count']+=1
    elif damage=='prep_income':bad['preparation']['points'][1]['fields']['legacy_income_total']+=1
    elif damage=='prep_bool':bad['preparation']['points'][0]['fields']['managed_selection_mode']=False
    elif damage=='queue':bad['preparation']['points'][0]['fields']['legacy_queue_zero']['index']=1
    elif damage=='eligibility':bad['preparation']['eligible']['managed_selection_mode']=False
    else:bad['preparation']['opaque']='not an input'
    with pytest.raises(ValueError):module.payload_check(bad,request(),base)

def test_later_computation_is_not_a_preparation_input():
    base,payload=witness();payload['fields'][0].update(entry=4,incoming=False)
    for point in payload['preparation']['points'][2:]:point['fields']['managed_selection_mode']=1
    module.payload_check(payload,request(),base)
    assert payload['preparation']['points'][0]['fields']['managed_selection_mode']==0
    assert payload['preparation']['eligible']['managed_selection_mode'] is True
    payload['preparation']['points'][1]['fields']['managed_selection_mode']=2
    payload['preparation']['eligible']['managed_selection_mode']=False
    module.payload_check(payload,request(),base)

@pytest.mark.parametrize('damage',['source','request','producer','ui','keys','prep','witness','opaque'])
def test_real_original_record_corruption_controls(damage):
    path=ROOT/'runs/T72/support-r0001.json'
    value=json.loads(path.read_text());module.check(value);bad=copy.deepcopy(value)
    if damage=='source':bad['source']['state_sha256']='0'*64
    elif damage=='request':bad['request']['path']='traces/T68/requests-r0003.json'
    elif damage=='producer':bad['producer_files'].pop(module.TOOL)
    elif damage=='ui':bad['ui'][2]['selected_player']=2583
    elif damage=='keys':bad['keys_delivered'][0][0]='Return'
    elif damage=='prep':bad['payload']['preparation']['eligible']['managed_selection_mode']=not bad['payload']['preparation']['eligible']['managed_selection_mode']
    elif damage=='witness':next(r for r in bad['payload']['fields'] if r['incoming'])['entry']^=1
    else:bad['opaque']='unrecognized'
    bad['payload_sha256']=module.prior.sha(module.prior.encoded(bad['payload']))
    with pytest.raises(ValueError):module.check(bad)

def test_both_original_pairs_and_cross_group_preparation():
    directory=ROOT/'runs/T72'
    value=module.catalog([(directory/'support-r0001.json',directory/'support-r0002.json'),(directory/'support-r0003.json',directory/'support-r0004.json')])
    assert len(value['incoming'])<=2032

def test_unchanged_case_record_cannot_claim_edited_inputs():
    old=json.loads((ROOT/'runs/T68/support-r0005.json').read_text())
    with pytest.raises(ValueError):module.check(old)

def test_catalog_cannot_substitute_one_group_for_the_complete_census():
    directory=ROOT/'runs/T72';pair=(directory/'support-r0001.json',directory/'support-r0002.json')
    with pytest.raises(ValueError,match='two independent'):module.catalog([pair])
    with pytest.raises(ValueError,match='census incomplete'):module.catalog([pair,pair])
