"""T87 early original observations: provenance, coordinates and late-data refusal."""
import copy
import importlib.util
import json
from pathlib import Path
import pytest
ROOT=Path(__file__).resolve().parents[2]
spec=importlib.util.spec_from_file_location('postmatch_incoming_tested',ROOT/'runtime/emul/postmatch_incoming.py')
p=importlib.util.module_from_spec(spec)
spec.loader.exec_module(p)


def capture():
    return json.loads((ROOT/'records/T87/incoming-r0001.json').read_text())


def test_accepted_original_pair_and_full_coordinate_census():
    assert p.check()==dict(repeats=2,fields=482,bytes=583,phase='pre19CA')
    r=capture();p.validate(r)
    assert len(r['payload']['fields'])==482
    assert r['payload']['boundary']['site']=='0AB9:E24C'
    assert r['payload']['context']['fixture']['week_slot']==6
    assert r['payload']['context']['fixture']['club']==134
    assert r['payload']['context']['fixture']['opponent']==130


def test_requests_contain_coordinates_not_late_values():
    req=p.requests()
    assert len(req)==482 and sum(x['size']for x in req)==583
    assert all(set(x)=={'field','size','coordinate'}for x in req)
    assert all(set(x['coordinate'])=={'region','index','offset'}for x in req)
    assert {x['coordinate']['offset']for x in req if x['coordinate']['region']=='frame'}=={-7,-6,-2,6}


@pytest.mark.parametrize('damage',range(22))
def test_resealed_provenance_coordinate_and_census_corruption_refuses(damage):
    r=capture();a=r['payload'];c=a['context']
    if damage==0:r['status']='aborted'
    if damage==1:r['source']['state_sha256']='0'*64
    if damage==2:r['producer_files']['runtime/emul/postmatch_incoming.py']='0'*64
    if damage==3:r['producer_files'].pop('runtime/emul/postmatch_incoming.py')
    if damage==4:a['boundary']['site']='0AB9:E679'
    if damage==5:a['boundary']['draw_cursor']+=1
    if damage==6:c['match_frame']['saved_parent']+=2
    if damage==7:c['match_frame']['return_ip']=0
    if damage==8:c['fixture']['club']=130
    if damage==9:c['fixture']['week_slot']=1
    if damage==10:a['fields'].pop()
    if damage==11:a['fields'].append(copy.deepcopy(a['fields'][0]))
    if damage==12:a['fields'][0]['address']+=1
    if damage==13:a['fields'][0]['coordinate']['offset']+=1
    if damage==14:a['fields'][0]['size']=4
    if damage==15:c['regions'][0]['base']+=1
    if damage==16:c['regions'][0]['stride']+=1
    if damage==17:r['unsupported']=['test']
    if damage==18:a['watch_intervention']['outside_unchanged']=False
    if damage==19:a['watch_intervention']['after']=0
    if damage==20:a['code_after']['1998']='0'*64
    if damage==21:a['boundary']['prefix_sha256']='0'*64
    r['payload_sha256']=p.sha(p.encoded(a))
    with pytest.raises(ValueError):p.validate(r)


def test_numeric_late_value_cannot_be_resealed_into_accepted_early_record(tmp_path):
    r=capture()
    seed=next(x for x in r['payload']['fields']if x['field']=='seed+0')
    late=p.late_record()['payload']['caller']['initial']
    late_seed=next(x['value']for x in late if x['field']=='seed+0')
    assert seed['value']!=late_seed
    seed['value']=late_seed;r['payload_sha256']=p.sha(p.encoded(r['payload']))
    # Numeric provenance cannot be manufactured by recomputing a payload hash.
    path=tmp_path/'incoming-r0001.json';path.write_text(json.dumps(r))
    with pytest.raises(ValueError,match='accepted.*digest'):p.check_leaf(path)


def test_old_t86_producer_census_does_not_grow_with_this_recorder():
    original=p.late_record()
    p.tail.validate(original)
    assert 'runtime/emul/postmatch_incoming.py'not in original['producer_files']


def test_wrong_field_values_outside_byte_domain_refuse():
    r=capture();f=next(x for x in r['payload']['fields']if x['size']==1)
    f['value']=256;r['payload_sha256']=p.sha(p.encoded(r['payload']))
    with pytest.raises(ValueError):p.validate(r)
