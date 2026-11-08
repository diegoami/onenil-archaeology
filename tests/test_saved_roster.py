"""[designed:T80] Synthetic validator corruptions, plus the authenticated baseline and session records."""
import copy
import importlib.util
import json
from pathlib import Path
import pytest
ROOT=Path(__file__).resolve().parents[1]
spec=importlib.util.spec_from_file_location('saved_roster',ROOT/'runtime/driver/saved_roster.py')
s=importlib.util.module_from_spec(spec);spec.loader.exec_module(s)
BASELINE=ROOT/'runs/T80/save-projection-r0001.json'
SESSIONS=sorted((ROOT/'runs/T80').glob('session-r*.json'))

def halftime_state():
 return dict(clubs=[dict(id=130,roster=[2581,2582]+list(range(2583,2593))+[0]*8),dict(id=17,roster=list(range(321,341)))],allowance=0,reserves=[7,3],sub_flags=[0,0],seed=1,elapsed=46,remaining=45,stoppage=0,live_goals=[0,1],control=1,scenes=[dict(index=i+1,word14=2582 if i==1 else i+1) for i in range(22)])
def persisted(state):
 out=copy.deepcopy(state);out['clubs'][0]['roster'][1],out['clubs'][0]['roster'][11]=2592,2582
 out['reserves'][0]-=1;out['scenes'][1]['word14']=2592
 return out
def transaction_stages():
 out=[];state=halftime_state()
 fixed={'bench':['space'],'players':['space'],'pearce':['Down'],'picked':['Return'],'cancelled':['Escape'],'picked-again':['Return'],'gale':['Down']*11,'confirmed':['Return'],'bench-after':['Escape'],'resumed':['Return']}
 for name in s.TRANSACTION_STAGES:
  if name in ('confirmed','bench-after','resumed'):state=persisted(halftime_state()) if name=='confirmed' else copy.deepcopy(out[-1]['state'])
  if name=='resumed':state=dict(state,elapsed=state['elapsed']+1)
  out.append(dict(name=name,keys=fixed.get(name,[]),selected=2582 if name=='pearce' else 2592 if name=='gale' else None,put_here=name in ('picked','picked-again','gale'),remaining_display=7 if name=='bench' else 6 if name=='bench-after' else None,state=copy.deepcopy(state),state_sha256=None,screen_sha256='a'*64,savestate_sha256='b'*64))
 for row in out:row['state_sha256']=s.sha(s.encoded(row['state']))
 return out
def session_payload():
 stages=[dict(name='preparation',keys=[],selected=None,put_here=False,remaining_display=None,state=halftime_state(),state_sha256=s.sha(s.encoded(halftime_state())),screen_sha256='p'*64,savestate_sha256='q'*64)]
 stages+=transaction_stages()
 stages[-1]['state']['elapsed']=92;stages[-1]['state_sha256']=s.sha(s.encoded(stages[-1]['state']))
 base=dict(keys=[],selected=None,put_here=False,remaining_display=None,screen_sha256='x'*64,savestate_sha256='y'*64)
 def row(name,state,keys=[]):
  st=copy.deepcopy(state);r=dict(base,name=name,keys=list(keys),state=st);r['state_sha256']=s.sha(s.encoded(st));return r
 ft=copy.deepcopy(stages[-1]['state']);ft['elapsed']=93
 menu=copy.deepcopy(ft);menu['seed']=4242
 saved=dict(clubs={'130':{'roster':menu['clubs'][0]['roster'],'players':{'2582':dict(current_position=9,club_position=3,condition=80,instructions=0,status=4),'2592':dict(current_position=2,club_position=1,condition=90,instructions=0,status=0)}},'17':{'roster':list(range(321,341))}},seed_word=4242,header_byte=1,year=1995,clubs_block_sha256='k'*64,players8_block_sha256='l'*64,players15_block_sha256='m'*64)
 stages+=[row('fulltime',ft),row('bench-ft',ft,['Return']),row('stats',menu,['n']),row('cash',menu,['space']),row('transfer',menu,['space']),row('menu-after',menu,['space']),row('saved',menu,['F7'])]
 reload=copy.deepcopy(menu);reload['players']=[dict(id=i,current_position=9,club_position=3,condition=80,instructions=0,status=4) if i==2582 else dict(id=i,current_position=2,club_position=1,condition=90,instructions=0,status=0) for i in (2582,2592)]
 stages.append(row('reloaded',reload))
 return dict(start=dict(savestate_sha256='c'*64),stages=stages,
  save_timeline=[dict(at='boot',name='SAVE1.1-0',sha256='bootd',size=1),dict(at='menu-after',name='SAVE1.1-0',sha256='weekd',size=1),dict(at='saved',name='SAVE1.1-0',sha256='f7d',size=1)],
  decoded_saves={'saved':saved})
BASELINE_SYNTH=dict(source=dict(sha256='bootd'))
def reseal(p):
 for row in p['stages']:row['state_sha256']=s.sha(s.encoded(row['state']))
 return p

def test_synthetic_session_contract_passes():
 contract=s.validate_session(session_payload(),BASELINE_SYNTH)
 assert contract['persisted_slots']==[1,11] and contract['saved_sha256']=='f7d'

@pytest.mark.parametrize('damage',range(10))
def test_session_rejects_corruptions(damage):
 p=session_payload();rows={r['name']:r for r in p['stages']}
 if damage==0:p['stages'].pop()
 if damage==1:rows['fulltime']['state']['clubs'][0]['roster'][1]=2582;reseal(p)
 if damage==2:p['save_timeline'][0]['sha256']='other'
 if damage==3:p['save_timeline'][2]['sha256']='weekd'
 if damage==4:p['decoded_saves']['saved']['clubs']['130']['roster'][1]=2582
 if damage==5:rows['reloaded']['state']['seed']=1;reseal(p)
 if damage==6:rows['reloaded']['state']['players'][0]['status']=0;reseal(p)
 if damage==7:rows['menu-after']['screen_sha256']='p'*64;reseal(p)
 if damage==8:rows['stats']['keys']=['space'];reseal(p)
 if damage==9:rows['saved']['state']['clubs'][0]['roster'][1]=2582;reseal(p)
 with pytest.raises(ValueError):s.validate_session(p,BASELINE_SYNTH)

def test_authenticated_baseline_record_passes():
 record=json.loads(BASELINE.read_text())
 assert s.validate_baseline(record)==dict(club=130,slots=dict(outgoing=1,incoming=11))

@pytest.mark.parametrize('damage',['roster','slots','equal','digest','source'])
def test_baseline_rejects_corruptions(damage):
 record=json.loads(BASELINE.read_text())
 if damage=='roster':record['save']['clubs']['130']['roster'][1]=2592
 if damage=='slots':record['comparison']['slots_zero_based']=dict(outgoing=11,incoming=1)
 if damage=='equal':record['comparison']['equal']=False
 if damage=='digest':record['comparison']['halftime_roster_sha256']='0'*64
 if damage=='source':record['source']['path']='One-Nil95/SAVE1.1-0'
 with pytest.raises(ValueError):s.validate_baseline(record)

def test_authenticated_sessions_match_the_contract():
 if len(SESSIONS)<2:pytest.skip('authenticated session records are not committed yet')
 paths=[p for p in SESSIONS if 'progress' not in p.name]
 contracts=[s.validate_record(json.loads(p.read_text())) for p in paths]
 assert len({json.loads(p.read_text())['payload']['start']['savestate_sha256'] for p in paths})>=2
 assert all(c==contracts[0] for c in contracts[1:])
