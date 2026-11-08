"""[designed:T74] Synthetic validator corruptions, not original observations."""
import copy
import importlib.util
import json
from pathlib import Path
import pytest
ROOT=Path(__file__).resolve().parents[1]
spec=importlib.util.spec_from_file_location('halftime_replacement',ROOT/'runtime/driver/halftime_replacement.py')
h=importlib.util.module_from_spec(spec);spec.loader.exec_module(h)
def payload():
 s=dict(clubs=[dict(id=130,roster=[2581,2582]+list(range(2583,2593))+[0]*8),dict(id=17,roster=list(range(321,341)))],allowance=0,reserves=[7,3],sub_flags=[0,0],seed=1,elapsed=46,remaining=45,stoppage=0,live_goals=[0,1])
 out=[]
 fixed={'bench':['space'],'players':['space'],'pearce':['Down'],'picked':['Return'],'cancelled':['Escape'],'picked-again':['Return'],'gale':['Down']*11,'confirmed':['Return'],'bench-after':['Escape'],'resumed':['Return']}
 for name in h.STAGES:
  state=copy.deepcopy(s)
  if name in ('confirmed','bench-after','resumed'):
   state['clubs'][0]['roster'][1],state['clubs'][0]['roster'][11]=2592,2582;state['reserves'][0]-=1
  if name=='resumed':state['elapsed']+=1
  out.append(dict(name=name,keys=fixed.get(name,[]),selected=2582 if name=='pearce' else 2592 if name=='gale' else None,put_here=name in ('picked','picked-again','gale'),remaining_display=7 if name=='bench' else 6 if name=='bench-after' else None,state=state,state_sha256=h.sha(h.encoded(state)),screen_sha256='a'*64,savestate_sha256='b'*64))
 return dict(stages=out,start=dict(savestate_sha256='c'*64))
def reseal(p):
 for s in p['stages']:s['state_sha256']=h.sha(h.encoded(s['state']))
 return p

def test_synthetic_valid_transaction_and_wrapping_capacity():
 assert h.validate_transaction(payload())==dict(club=130,outgoing=2582,incoming=2592,slots=[1,11],capacity_delta=-1)
 assert h.capacity(dict(allowance=0,reserves=[0],sub_flags=[1]),0)==65535

@pytest.mark.parametrize('damage',range(10))
def test_transaction_rejects_corruptions(damage):
 p=payload();r={s['name']:s for s in p['stages']}
 if damage==0:p['stages'][0],p['stages'][1]=p['stages'][1],p['stages'][0]
 if damage==1:p['stages'].pop()
 if damage==2:r['cancelled']['state']['seed']=42
 if damage==3:r['confirmed']['state']['clubs'][0]['roster'][1]=2582
 if damage==4:r['confirmed']['state']['reserves'][0]=7
 if damage==5:r['gale']['selected']=2582
 if damage==6:r['picked']['put_here']=False
 if damage==7:r['confirmed']['state']['live_goals']=[4,5]
 if damage==8:r['confirmed']['keys']=['Escape']
 if damage==9:r['resumed']['state']['elapsed']=46
 with pytest.raises(ValueError):h.validate_transaction(reseal(p))

def record():
 p=payload()
 return dict(schema='original-halftime-replacement/1',status='completed',processes_exited=True,release=h.release(),dosbox_version='2024.03.01',producer='synthetic',producer_files={p:'d'*64 for p in h.DEPENDENCIES},payload=p,payload_sha256=h.sha(h.encoded(p)))

@pytest.mark.parametrize('damage',['release','producer','payload','completion','census'])
def test_record_rejects_identity_corruptions(monkeypatch,damage):
 r=record();monkeypatch.setattr(h,'git',lambda *args:b'synthetic code');r['producer_files']={p:h.sha(b'synthetic code') for p in h.DEPENDENCIES}
 if damage=='release':r['release']={}
 if damage=='producer':r['producer_files'][h.TOOL]='a'*64
 if damage=='payload':r['payload_sha256']='a'*64
 if damage=='completion':r['processes_exited']=False
 if damage=='census':r['producer_files'].pop(h.TOOL)
 with pytest.raises(ValueError):h.validate_record(r)

def test_repeat_requires_separate_session_and_equal_contract(monkeypatch,tmp_path):
 r=record();monkeypatch.setattr(h,'validate_record',lambda r:h.validate_transaction(r['payload']))
 a=tmp_path/'a.json';b=tmp_path/'b.json';a.write_text(json.dumps(r));b.write_text(json.dumps(r))
 with pytest.raises(ValueError,match='fresh sessions'):h.check([a,b])
 r['payload']['start']['savestate_sha256']='e'*64;b.write_text(json.dumps(r));h.check([a,b])
 r['payload']['stages'][3]['selected']=2592;b.write_text(json.dumps(r))
 with pytest.raises(ValueError):h.check([a,b])
