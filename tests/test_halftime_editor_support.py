"""T75 source identity, support binding and original transaction controls."""
import copy
import importlib.util
from pathlib import Path
import pytest
ROOT=Path(__file__).resolve().parents[1]
def module(name,path):
 spec=importlib.util.spec_from_file_location(name,ROOT/path);m=importlib.util.module_from_spec(spec);spec.loader.exec_module(m);return m
h=module('editor_support','runtime/driver/halftime_editor_support.py')
t=module('previous_tests','tests/test_halftime_replacement.py')
def payload():
 p=t.payload()
 for row in p['stages']:
  row['support']=dict(area='config',offset=4,width=8,consumer='0AB9:D1F1',ds_base=0x30000,pointer_slot=0xD7D2,pointer_offset=0,pointer_segment=0x4900,address=0x49004,value=1)
  row['support_sha256']=h.sha(h.encoded(row['support']))
 return p

def test_bounded_synthetic_support_retains_original_contract():
 assert h.validate_support(payload())['capacity_delta']==-1

@pytest.mark.parametrize('field,value',[('offset',5),('area','ds'),('width',16),('consumer','0AB9:D20F'),('pointer_slot',0xD7D3),('address',0x49005),('pointer_segment',-1),('ds_base',0),('value',256)])
def test_wrong_support_field_rejected(field,value):
 p=payload();s=p['stages'][0];s['support'][field]=value;s['support_sha256']=h.sha(h.encoded(s['support']))
 with pytest.raises(ValueError):h.validate_support(p)

def test_unbound_value_and_wrong_editor_store_rejected():
 p=payload();p['stages'][0]['support']['value']=2
 with pytest.raises(ValueError,match='digest'):h.validate_support(p)
 p=payload();s=p['stages'][2];s['support']['value']=2;s['support_sha256']=h.sha(h.encoded(s['support']))
 with pytest.raises(ValueError,match='store'):h.validate_support(p)

def test_original_cancellation_still_required():
 p=payload();p['stages'][5]['state']['seed']=987;t.reseal(p)
 with pytest.raises(ValueError,match='cancellation'):h.validate_support(p)

@pytest.mark.parametrize('damage',['release','producer','payload','completion','census'])
def test_source_identity_rejected(monkeypatch,damage):
 r=t.record();r.update(schema='original-halftime-editor-support/1',payload=payload())
 monkeypatch.setattr(h,'git',lambda *args:b'synthetic code')
 r['producer_files']={p:h.sha(b'synthetic code') for p in h.DEPENDENCIES};r['payload_sha256']=h.sha(h.encoded(r['payload']))
 if damage=='release':r['release']={}
 if damage=='producer':r['producer_files'][h.TOOL]='a'*64
 if damage=='payload':r['payload_sha256']='a'*64
 if damage=='completion':r['processes_exited']=False
 if damage=='census':r['producer_files'].pop(h.TOOL)
 with pytest.raises(ValueError):h.validate_record(r)

@pytest.mark.parametrize('query',[{},dict(stage='bad',area='ds',offset=0,width=8,consumer='0AB9:CC00'),dict(stage='halftime',area='ds',offset=0,width=24,consumer='0AB9:CC00'),dict(stage='halftime',area='all',offset=0,width=8,consumer='0AB9:CC00')])
def test_query_rejects_unbounded_or_unwitnessed_fields(monkeypatch,tmp_path,query):
 import json
 q=module('support_query','runtime/driver/halftime_support_query.py')
 p=tmp_path/'source.json';p.write_text(json.dumps(dict(payload=payload())))
 monkeypatch.setattr(q.source,'validate_record',lambda r:True)
 with pytest.raises(ValueError):q.extract(p,tmp_path,[query])
