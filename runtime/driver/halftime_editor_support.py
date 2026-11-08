#!/usr/bin/env python3
"""T75: authenticate bounded original halftime editor support; no memory writes."""
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
TOOL='runtime/driver/halftime_editor_support.py'
DEPENDENCIES=[TOOL,'runtime/driver/halftime_replacement.py','runtime/driver/driver.py','runtime/driver/screens.py','runtime/driver/savestate.py','runtime/driver/xkeys.py','runtime/driver/dosbox-x-2024.03.01-default.map']
STAGES=['halftime','bench','players','pearce','picked','cancelled','picked-again','gale','confirmed','bench-after','resumed']
sha=lambda b:hashlib.sha256(b).hexdigest()
def encoded(value):return json.dumps(value,sort_keys=True,separators=(',',':')).encode()
def git(*args):return subprocess.check_output(['git','-C',str(ROOT),*args])
def release():return {p['name']:p['sha256'] for p in json.loads((ROOT/'records/T01/inventory.json').read_text())['files'] if p['edition']=='96'}
def write(path,value):
 path.parent.mkdir(parents=True,exist_ok=True)
 with path.open('x') as f:json.dump(value,f,indent=2);f.write('\n')
import halftime_replacement as original
projection=original.projection

def support(st):
 ds=st.program().ds_base
 pointer=int.from_bytes(st.memory(ds+0xD7D2,2),'little')
 segment=int.from_bytes(st.memory(ds+0xD7D4,2),'little')
 address=16*segment+pointer+4
 return dict(area='config',offset=4,width=8,consumer='0AB9:D1F1',ds_base=ds,pointer_slot=0xD7D2,pointer_offset=pointer,pointer_segment=segment,address=address,value=st.memory(address,1)[0])

def validate_support(payload):
 original.validate_transaction(payload)
 for row in payload['stages']:
  s=row['support']
  if set(s)!={'area','offset','width','consumer','ds_base','pointer_slot','pointer_offset','pointer_segment','address','value'}:raise ValueError('support field census differs')
  if (s['area'],s['offset'],s['width'],s['consumer'],s['pointer_slot'])!=('config',4,8,'0AB9:D1F1',0xD7D2):raise ValueError('support consumer differs')
  if not all(isinstance(s[k],int) and 0<=s[k]<=65535 for k in ('pointer_offset','pointer_segment')):raise ValueError('support pointer differs')
  if s['address']!=16*s['pointer_segment']+s['pointer_offset']+4 or not 0<s['ds_base']<1048576 or not 0<=s['value']<=255:raise ValueError('support address/value differs')
  if row['support_sha256']!=sha(encoded(s)):raise ValueError('support digest differs')
  if row['name'] in ('players','pearce','picked','cancelled','picked-again','gale','confirmed','bench-after') and s['value']!=1:raise ValueError('observed D1F1 selected-team store differs')
 return original.validate_transaction(payload)

def capacity(state,side):return (state['allowance']+state['reserves'][side]-state['sub_flags'][side])&65535

def validate_transaction(payload):
 stages=payload['stages']
 if [s['name'] for s in stages]!=STAGES:raise ValueError('stage census/order differs')
 rows={s['name']:s for s in stages}
 half=rows['halftime']['state']
 if half['elapsed']<45 or half['remaining']<=0 or half['control']!=1 or {c['id'] for c in half['clubs']}!={17,130}:raise ValueError('genuine managed interval state differs')
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
 expected_players=[scene['word14'] for scene in before['scenes']]
 if expected_players.count(2582)!=1 or 2592 in expected_players:raise ValueError('outgoing active scene differs')
 expected_players[expected_players.index(2582)]=2592
 if [scene['word14'] for scene in after['scenes']]!=expected_players:raise ValueError('live scene replacement differs')
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
 if record['schema']!='original-halftime-editor-support/1' or record['status']!='completed' or not record['processes_exited']:raise ValueError('incomplete original session')
 if record['release']!=release() or record['dosbox_version']!=driver.WANT_DOSBOX:raise ValueError('release/runtime differs')
 if set(record['producer_files'])!=set(DEPENDENCIES):raise ValueError('producer census differs')
 for name,digest in record['producer_files'].items():
  if sha(git('show',record['producer']+':'+name))!=digest:raise ValueError('producer identity differs')
 if sha(encoded(record['payload']))!=record['payload_sha256']:raise ValueError('payload digest differs')
 return validate_support(record['payload'])

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
 d=IntervalDriver(workdir=scratch,game_dir=scratch/'game');stages=[];record=dict(schema='original-halftime-editor-support/1',producer=git('rev-parse','HEAD').decode().strip(),producer_files={p:sha((ROOT/p).read_bytes()) for p in DEPENDENCIES},release=release(),dosbox_version=driver.WANT_DOSBOX,status='aborted',processes_exited=False,payload={'start':None,'stages':stages},error=None)
 start=time.monotonic()
 def observe(name,keys=(),selected=None):
  for key in keys:d.keys(key)
  time.sleep(.25)
  _,st,data=d.read();sc=st.screen();text=sc.text();high=[t for _,t in screens.highlighted(sc)]
  actual=next((i for i,name in [(2582,'I Pearce'),(2592,'T Gale')] if any(name in h for h in high)),None)
  if selected is not None and actual!=selected:raise ValueError('highlight differs '+name)
  state=projection(st);m=re.search(r'Remaining subs\s+(\d+)',text)
  row=dict(name=name,keys=list(keys),selected=actual,put_here='PUT HERE' in text,remaining_display=int(m[1]) if m else None,screen_sha256=sc.digest(),savestate_sha256=sha(data),state_sha256=sha(encoded(state)),state=state)
  row['support']=support(st);row['support_sha256']=sha(encoded(row['support']));(scratch/(name+'.sav')).write_bytes(data)
  stages.append(row);print(name,'selected-team',row['support']['value'],'elapsed',state['elapsed'],'capacity',[capacity(state,i) for i in range(2)],flush=True)
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
  deadline=time.monotonic()+900
  while time.monotonic()<deadline:
   time.sleep(2)  # Avoid continuously stopping play for compressed savestate reads.
   text=d.screen().text()
   if 'HALF TIME' in text and 'press any key' in text.lower():break
  else:raise RuntimeError('genuine halftime not reached within 900 seconds')
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
 values=[[s['support']['value'] for s in r['payload']['stages']] for r in records]
 if any(v!=values[0] for v in values[1:]):raise ValueError('independent support values differ')
 print('PASS original halftime editor support:',len(records),'independent sessions',contracts[0])
if __name__=='__main__':
 p=argparse.ArgumentParser(description=__doc__);p.add_argument('--run',type=Path);p.add_argument('--scratch',type=Path);p.add_argument('--check',type=Path,nargs='+');a=p.parse_args()
 if a.check:check(a.check)
 elif a.run and a.scratch:run(a.run,a.scratch)
 else:p.error('choose --run OUTPUT --scratch NEW_PATH or --check RECORDS')
