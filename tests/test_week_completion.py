"""[designed:T81] Synthetic validator corruptions, plus the authenticated session records."""
import copy
import importlib.util
import json
from pathlib import Path
import pytest
ROOT=Path(__file__).resolve().parents[1]
spec=importlib.util.spec_from_file_location('week_completion',ROOT/'runtime/driver/week_completion.py')
w=importlib.util.module_from_spec(spec);spec.loader.exec_module(w)
SESSIONS=sorted((ROOT/'runs/T81').glob('session-r*.json'))

def state(elapsed=0,menu=False):
 if menu:return dict(seed=7,club=130,roster=[2581,2582]+list(range(2583,2593))+[0]*8,players={'2582':dict(current_position=2,club_position=2,condition=31,instructions=178,status=0),'2592':dict(current_position=2,club_position=2,condition=17,instructions=0,status=0)})
 return dict(clubs=[dict(id=17,roster=list(range(301,321))),dict(id=130,roster=[2581,2582]+list(range(2583,2593))+[0]*8)],allowance=0,reserves=[3,7],sub_flags=[0,0],seed=7,elapsed=elapsed,remaining=45,stoppage=0,live_goals=[1,2],control=1,scenes=[dict(index=i+1,word14=i+1) for i in range(22)])
def row(name,state,keys=[],text=None,menu=False):
 st=copy.deepcopy(state);r=dict(name=name,keys=list(keys),screen_sha256='a'*64,savestate_sha256='b'*64,state=st)
 r['state_sha256']=w.sha(w.encoded(st))
 if text is not None:r['text']=text
 return r
def payload():
 stages=[dict(row('preparation',state()),screen_sha256='e'*64)]
 stages+=[row('halftime',state(46),[],text='HALF TIME press any key'),row('bench',state(46),['space']),row('resumed',state(47),[]),row('fulltime',state(93),[],text='FULL TIME'),row('bench-ft',state(93),['Return'],text='CONTINUE'),row('stats',state(93),['n'],text='MAN OF THE MATCH')]
 roster=state()['clubs'][1]['roster']
 def menu():
  return dict(seed=7,club=130,roster=list(roster),players={'2582':dict(current_position=2,club_position=2,condition=31,instructions=178,status=0),'2592':dict(current_position=2,club_position=2,condition=19,instructions=0,status=0)})
 menu_state=menu()
 stages+=[row('cash',menu(),['space'],text='CASH FLOW FOR Blackburn R TOTAL'),row('transfer',menu(),['space'],text='TRANSFER NEWS rows'),dict(row('menu-after',menu(),['space'],text='PLAY NEXT GAME funds 421,491'),screen_sha256='9'*64)]
 base=dict(name='saved',keys=[],screen_sha256='c'*64,savestate_sha256='d'*64,state=copy.deepcopy(menu_state));base['state_sha256']=w.sha(w.encoded(base['state']))
 stages.append(base)
 stages.append(row('reloaded',menu()))
 saved=dict(clubs={'130':{'roster':list(roster),'players':{'2582':dict(current_position=2,club_position=2,condition=31,instructions=178,status=0),'2592':dict(current_position=2,club_position=2,condition=19,instructions=0,status=0)}},'17':{'roster':list(range(301,321))}},seed_word=7,header_byte=1,year=1995,manager=1,club_bytes=130,cash=421491,clubs_block_sha256='k'*64,players8_block_sha256='l'*64,players15_block_sha256='m'*64)
 boot=copy.deepcopy(saved);boot['cash']=452000
 boot['clubs']['130']['players']['2592']['condition']=17
 result=dict(start=dict(savestate_sha256='e'*64),stages=stages,
  save_timeline=[dict(at='boot',name='SAVE1.1-0',sha256='bootd',size=1),dict(at='menu-after',name='SAVE1.1-0',sha256='weekd',size=1),dict(at='saved',name='SAVE1.1-0',sha256='weekd',size=1)],
  decoded_saves={'boot':boot,'saved':saved})
 return reseal(result)
BASELINE_SYN=dict(source=dict(sha256='bootd'))
def reseal(p):
 for row in p['stages']:row['state_sha256']=w.sha(w.encoded(row['state']))
 return p

def test_synthetic_session_contract_passes():
 contract=w.validate_session(payload(),BASELINE_SYN)
 assert contract['roster_slots']==20 and contract['cash_moved'] is True

@pytest.mark.parametrize('damage',range(10))
def test_session_rejects_corruptions(damage):
 p=payload();rows={r['name']:r for r in p['stages']}
 if damage==0:p['stages'].pop()
 if damage==1:rows['fulltime']['state']['clubs'][1]['roster'][1]=2593;reseal(p)
 if damage==2:p['save_timeline'][0]['sha256']='other'
 if damage==3:p['decoded_saves']['saved']['cash']=452000
 if damage==4:rows['reloaded']['state']['seed']=1;reseal(p)
 if damage==5:rows['reloaded']['state']['players']['2582']['condition']=99;reseal(p)
 if damage==6:rows['cash']['text']='no marker here';reseal(p)
 if damage==7:rows['menu-after']['text']='PLAY NEXT GAME without funds';reseal(p)
 if damage==8:rows['stats']['keys']=['space'];reseal(p)
 if damage==9:p['decoded_saves']['saved']['clubs']['130']['roster'][11]=2582
 with pytest.raises(ValueError):w.validate_session(p,BASELINE_SYN)

def test_authenticated_sessions_match_the_contract():
 paths=[p for p in SESSIONS if 'progress' not in p.name
        and json.loads(p.read_text()).get('status')=='completed']
 if len(paths)<2:pytest.skip('authenticated session records are not committed yet')
 contracts=[w.validate_record(json.loads(p.read_text())) for p in paths]
 assert len({json.loads(p.read_text())['payload']['start']['savestate_sha256'] for p in paths})>=2
 assert all(c==contracts[0] for c in contracts[1:])
