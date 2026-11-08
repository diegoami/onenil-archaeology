#!/usr/bin/env python3
"""T74: observe real original halftime cancel/confirm; never modify guest memory."""
import argparse
import hashlib
import json
import re
import subprocess
import sys
import time
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT/'runtime/driver'))
import driver
import screens
import savestate
TOOL='runtime/driver/halftime_replacement.py'
DEPENDENCIES=[TOOL,'runtime/driver/driver.py','runtime/driver/screens.py','runtime/driver/savestate.py','runtime/driver/xkeys.py','runtime/driver/dosbox-x-2024.03.01-default.map']
STAGES=['halftime','bench','players','pearce','picked','cancelled','picked-again','gale','confirmed','bench-after','resumed']
sha=lambda b:hashlib.sha256(b).hexdigest()
def encoded(value):return json.dumps(value,sort_keys=True,separators=(',',':')).encode()
def git(*args):return subprocess.check_output(['git','-C',str(ROOT),*args])
def release():return {p['name']:p['sha256'] for p in json.loads((ROOT/'records/T01/inventory.json').read_text())['files'] if p['edition']=='96'}
def write(path,value):
 path.parent.mkdir(parents=True,exist_ok=True)
 with path.open('x') as f:json.dump(value,f,indent=2);f.write('\n')
def projection(st):
 """[confirmed] T22 dispatcher/T40 scenes;C866 swaps roster/event accounting then AEB8."""
 ds=st.program().ds_base
 def rd(at,n=2):return int.from_bytes(st.memory(ds+at,n),'little')
 def far(at):return rd(at)+16*rd(at+2)
 def at(address,n=2):return int.from_bytes(st.memory(address,n),'little')
 clubs=[]
 for side in range(2):
  club=rd(0xD6E4+2*side);base=far(0xD7C2)+(club-1)*62
  clubs.append(dict(id=club,roster=[at(base+2*i) for i in range(20)]))
 players=[]
 for identifier in sorted({p for c in clubs for p in c['roster'] if p}):
  p8=far(0xD7BA)+8*identifier;p15=far(0xD7BE)+15*identifier
  players.append(dict(id=identifier,current_position=at(p8+6,1),club_position=at(p8+7,1),condition=at(p15+8,1),instructions=at(p15+10,1),status=at(p15+11,1)))
 return dict(seed=at(far(0xDE84)),clubs=clubs,players=players,
  scenes=[dict(index=i,**{f'word{k}':rd(0xCCEF+25*i+k) for k in (0,2,4,8,10,14,16,20)},**{f'byte{k}':rd(0xCCEF+25*i+k,1) for k in (6,7,12,13,18,19,22,23,24)}) for i in range(1,23)],
  elapsed=rd(0xD0B2),remaining=rd(0xD0AE),stoppage=rd(0xD0B4),active=rd(0xD0B8,1),phase=rd(0xD0AC,1),live_goals=[rd(0xD0C4+i,1) for i in range(2)],
  allowance=rd(0xD6DD,1),sub_flags=[rd(0xD6DE+i,1) for i in range(2)],reserves=[rd(0xD6E0+i,1) for i in range(2)],pending=rd(0xD6E2,1),control=rd(0xD0BA,1),
  event_totals=[[rd(0xD148+40*side+2*i) for i in range(20)] for side in range(2)],event_flags=[[rd(0xD198+20*side+i,1) for i in range(20)] for side in range(2)])
def capacity(state,side):return (state['allowance']+state['reserves'][side]-state['sub_flags'][side])&65535

def validate_transaction(payload):
 stages=payload['stages']
 if [s['name'] for s in stages]!=STAGES:raise ValueError('stage census/order differs')
 rows={s['name']:s for s in stages}
 for row in stages:
  if sha(encoded(row['state']))!=row['state_sha256']:raise ValueError('state digest differs')
  if not all(re.fullmatch('[0-9a-f]{64}',row[k]) for k in ('screen_sha256','savestate_sha256')):raise ValueError('observation identity differs')
 if rows['pearce']['selected']!=2582 or rows['gale']['selected']!=2592:raise ValueError('selected player differs')
 for name in ('picked','picked-again','gale'):
  if not rows[name]['put_here']:raise ValueError('replacement pick mode missing')
 if rows['cancelled']['put_here'] or rows['confirmed']['put_here']:raise ValueError('replacement mode not closed')
 if rows['pearce']['state']!=rows['cancelled']['state']:raise ValueError('cancellation changed gameplay')
 if rows['pearce']['state']!=rows['gale']['state']:raise ValueError('selection changed gameplay')
 before=rows['gale']['state'];after=rows['confirmed']['state']
 if [c['id'] for c in before['clubs']]!=[c['id'] for c in after['clubs']]:raise ValueError('club identity changed')
 side=next(i for i,c in enumerate(before['clubs']) if c['id']==130)
 roster=before['clubs'][side]['roster'];want=list(roster)
 a,b=roster.index(2582),roster.index(2592)
 if not (a<11<=b):raise ValueError('not a first-team/bench replacement')
 want[a],want[b]=want[b],want[a]
 if after['clubs'][side]['roster']!=want or after['clubs'][1-side]!=before['clubs'][1-side]:raise ValueError('roster exchange differs')
 if capacity(after,side)!=capacity(before,side)-1:raise ValueError('capacity did not decrease once')
 for name in ('seed','elapsed','remaining','stoppage','live_goals'):
  if before[name]!=after[name]:raise ValueError('replacement changed clock/score/seed')
 if rows['bench']['remaining_display']!=capacity(before,side) or rows['bench-after']['remaining_display']!=capacity(after,side):raise ValueError('display capacity alias differs')
 if rows['resumed']['state']['elapsed']<=after['elapsed']:raise ValueError('second half did not resume')
 # Keys at each observed boundary, including adaptive selection, remain explicit.
 fixed={'bench':['space'],'players':['space'],'picked':['Return'],'cancelled':['Escape'],'picked-again':['Return'],'confirmed':['Return'],'bench-after':['Escape'],'resumed':['Return']}
 for name,keys in fixed.items():
  if rows[name]['keys']!=keys:raise ValueError('input sequence differs')
 for name in ('pearce','gale'):
  if not rows[name]['keys'] or any(k!='Down' for k in rows[name]['keys']):raise ValueError('selection input differs')
 return dict(club=130,outgoing=2582,incoming=2592,slots=[a,b],capacity_delta=-1)

def validate_record(record):
 if record['schema']!='original-halftime-replacement/1' or record['status']!='completed' or not record['processes_exited']:raise ValueError('incomplete original session')
 if record['release']!=release() or record['dosbox_version']!=driver.WANT_DOSBOX:raise ValueError('release/runtime differs')
 if set(record['producer_files'])!=set(DEPENDENCIES):raise ValueError('producer census differs')
 for name,digest in record['producer_files'].items():
  if sha(git('show',record['producer']+':'+name))!=digest:raise ValueError('producer identity differs')
 if sha(encoded(record['payload']))!=record['payload_sha256']:raise ValueError('payload digest differs')
 return validate_transaction(record['payload'])

def run(out,scratch):
 if out.exists() or scratch.exists():raise ValueError('fresh output/scratch required')
 if git('status','--porcelain','--',*DEPENDENCIES).strip():raise ValueError('commit observer first')
 # [confirmed:T42..T61 manual driver] Let BIOS initialization finish before
 # the first savestate; an early boot capture breaks this calibrated runtime.
 class IntervalDriver(driver.Driver):
  def _wait_window(self,timeout):
   window=super()._wait_window(timeout);time.sleep(3)
   self.log('T74: waited 3 seconds after window creation before first savestate')
   return window
 d=IntervalDriver(workdir=scratch,game_dir=scratch/'game');stages=[];record=dict(schema='original-halftime-replacement/1',producer=git('rev-parse','HEAD').decode().strip(),producer_files={p:sha((ROOT/p).read_bytes()) for p in DEPENDENCIES},release=release(),dosbox_version=driver.WANT_DOSBOX,status='aborted',processes_exited=False,payload={'start':None,'stages':stages},error=None)
 start=time.monotonic()
 def observe(name,keys=(),selected=None):
  for key in keys:d.keys(key)
  time.sleep(.25)
  _,st,data=d.read();sc=st.screen();text=sc.text();high=[t for _,t in screens.highlighted(sc)]
  actual=next((i for i,name in [(2582,'I Pearce'),(2592,'T Gale')] if any(name in h for h in high)),None)
  if selected is not None and actual!=selected:raise ValueError('highlight differs '+name)
  state=projection(st);m=re.search(r'Remaining subs\s+(\d+)',text)
  row=dict(name=name,keys=list(keys),selected=actual,put_here='PUT HERE' in text,remaining_display=int(m[1]) if m else None,screen_sha256=sc.digest(),savestate_sha256=sha(data),state_sha256=sha(encoded(state)),state=state)
  stages.append(row);print(name,'elapsed',state['elapsed'],'capacity',[capacity(state,i) for i in range(2)],flush=True)
  return text
 def select(identifier):
  keys=[]
  for _ in range(22):
   d.keys('Down');keys.append('Down');time.sleep(.15);sc=d.screen()
   name={2582:'I Pearce',2592:'T Gale'}[identifier]
   if any(name in h for _,h in screens.highlighted(sc)):return keys
  raise ValueError('requested highlighted player not reached')
 try:
  d.launch();time.sleep(3);d.keys('y');time.sleep(3);d.wait_screen(lambda s:'PLAY NEXT GAME' in s.text(),what='supplied main')
  record['payload']['start']=dict(savestate_sha256=sha(d.last_blob),screen_sha256=d.last[1].screen().digest(),keys=['y','Return','Return'])
  d.keys('Return');d.wait_screen(lambda s:'PLAY GAME' in s.text(),what='preparation');d.keys('Return')
  d.wait_screen(lambda s:'HALF TIME' in s.text() and 'press any key' in s.text().lower(),timeout=240,what='genuine halftime')
  observe('halftime');observe('bench',['space']);observe('players',['space'])
  keys=select(2582);observe('pearce',selected=2582);stages[-1]['keys']=keys
  observe('picked',['Return']);observe('cancelled',['Escape']);observe('picked-again',['Return'])
  keys=select(2592);observe('gale',selected=2592);stages[-1]['keys']=keys
  observe('confirmed',['Return']);observe('bench-after',['Escape']);d.keys('Return')
  d.wait_screen(lambda s:projection(d.last[1])['elapsed']>stages[-1]['state']['elapsed'],timeout=30,what='second half progression')
  observe('resumed');stages[-1]['keys']=['Return'];validate_transaction(record['payload']);record['status']='completed'
 except Exception as exc:
  record['error']=f'{type(exc).__name__}: {exc}';raise
 finally:
  record['processes_exited']=d.terminate();record['elapsed_seconds']=time.monotonic()-start;record['driver_events']=d.events;record['payload_sha256']=sha(encoded(record['payload']));write(out,record)
 validate_record(record)

def check(paths):
 records=[json.loads(p.read_text()) for p in paths];contracts=[validate_record(r) for r in records]
 if len(records)<2 or len({r['payload']['start']['savestate_sha256'] for r in records})<2:raise ValueError('independent fresh sessions required')
 if any(c!=contracts[0] for c in contracts[1:]):raise ValueError('repeat transaction differs')
 print('PASS original halftime replacement:',len(records),'independent sessions',contracts[0])
if __name__=='__main__':
 p=argparse.ArgumentParser(description=__doc__);p.add_argument('--run',type=Path);p.add_argument('--scratch',type=Path);p.add_argument('--check',type=Path,nargs='+');a=p.parse_args()
 if a.check:check(a.check)
 elif a.run and a.scratch:run(a.run,a.scratch)
 else:p.error('choose --run OUTPUT --scratch NEW_PATH or --check RECORDS')
