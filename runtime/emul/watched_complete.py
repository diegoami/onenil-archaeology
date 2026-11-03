#!/usr/bin/env python3
"""Complete original watched reference;decoded immutable chunks,never a native runtime backend."""
import argparse,hashlib,json,platform,subprocess
from pathlib import Path
import watched_actions as prefix
match=prefix.match;ROOT=prefix.ROOT;RUNS=ROOT/'runs/T40';INDEX=ROOT/'traces/T40/index.json';CHUNK_TICKS=64

def encoded(value):return json.dumps(value,sort_keys=True,separators=(',',':')).encode()
def sha(data):return hashlib.sha256(data).hexdigest()
def write(path,value):
 path.parent.mkdir(parents=True,exist_ok=True)
 with path.open('x')as f:json.dump(value,f,indent=2);f.write('\n')
def integer(v,lo,hi):
 if type(v)is not int or not lo<=v<=hi:raise ValueError('invalid reference integer/domain')
def state_check(s):
 if set(s)!={'seed','elapsed','remaining','quick','scores','phase','active','hold','stoppage','actor','secondary','ball','scenes'}:raise ValueError('reference state fields differ')
 for k in ('seed','elapsed','remaining','stoppage'):integer(s[k],0,65535)
 for k in ('quick','phase','active','hold'):integer(s[k],0,255)
 for k in ('actor','secondary'):integer(s[k],0,22)
 if s['quick']!=0:raise ValueError('quick fallback is not a complete watched reference')
 if len(s['scores'])!=2:raise ValueError('goal pair differs')
 for goal in s['scores']:integer(goal,0,255)
 if set(s['ball'])!={*(f'word{k}'for k in (0,2,4,7,9,11)),*(f'byte{k}'for k in (6,13,14))}:raise ValueError('ball fields differ')
 for k,v in s['ball'].items():integer(v,0,65535 if k.startswith('word')else 255)
 if len(s['scenes'])!=22:raise ValueError('scene census differs')
 for i,row in enumerate(s['scenes'],1):
  if set(row)!={'index',*(f'word{k}'for k in (0,2,4,8,10,14,16,20)),*(f'byte{k}'for k in (6,7,12,13,18,19,22,23,24))}:raise ValueError('scene fields differ')
  integer(row['index'],i,i)
  for k,v in row.items():
   if k!='index':integer(v,0,3920 if k=='word14'else 65535 if k.startswith('word')else 255)

def validate_chunk(value,previous=None):
 keys={'index','draw_start','draw_end','tick_start','tick_end','action_start','action_end','draws','ticks','actions'}
 if set(value)!=keys:raise ValueError('chunk fields differ')
 p=previous or {'index':0,'draw':0,'tick':1,'action':0,'seed':None}
 for k,want in [('index',p['index']),('draw_start',p['draw']),('tick_start',p['tick']),('action_start',p['action'])]:
  if value[k]!=want:raise ValueError('chunk cursor differs:'+k)
 if value['draw_end']!=value['draw_start']+len(value['draws'])or value['tick_end']!=value['tick_start']+len(value['ticks'])-1 or value['action_end']!=value['action_start']+len(value['actions']):raise ValueError('chunk interval differs')
 if len(value['ticks'])>CHUNK_TICKS:raise ValueError('oversized tick chunk')
 seed=p['seed'];seed_at={value['draw_start']:seed}
 for i,d in enumerate(value['draws'],value['draw_start']):
  if set(d)!={'kind','i','n','seed_before','seed_after','value','callers'}or d['kind']!='draw'or d['i']!=i:raise ValueError('ordered draw identity differs')
  for k in ('n','seed_before','seed_after'):integer(d[k],0,65535)
  integer(d['value'],1,65535)
  if seed is not None and d['seed_before']!=seed:raise ValueError('RNG seed chain differs')
  if seed is None:seed_at[i]=d['seed_before']
  seed=d['seed_after'];seed_at[i+1]=seed
 def cursor_seed(cursor,actual):
  integer(cursor,value['draw_start'],value['draw_end'])
  if seed_at.get(cursor)is not None and actual!=seed_at[cursor]:raise ValueError('state/action seed cursor differs')
 for number,t in enumerate(value['ticks'],value['tick_start']):
  if set(t)!={'tick','draw_start','draw_end','before','after'}or t['tick']!=number or t['draw_end']<t['draw_start']:raise ValueError('watched tick identity differs')
  for state,cursor in [(t['before'],t['draw_start']),(t['after'],t['draw_end'])]:state_check(state);cursor_seed(cursor,state['seed'])
 for i,a in enumerate(value['actions'],value['action_start']):
  if a['event']!=i:raise ValueError('action identity differs')
  for k in ('code','side','actor_slot','secondary_slot','club','player','secondary','minute','tick','draw_start','draw_end','seed_before','seed_after','head_before','caller','queue','event'):
   if k not in a:raise ValueError('missing action field')
  integer(a['code'],0,255);integer(a['side'],0,1)
  for k in ('player','secondary'):integer(a[k],0,3920)
  for k in ('actor_slot','secondary_slot'):integer(a[k],0,20)
  if a['draw_end']<a['draw_start']:raise ValueError('action interval differs')
  cursor_seed(a['draw_start'],a['seed_before']);cursor_seed(a['draw_end'],a['seed_after'])
  q=a['queue'];integer(q['index'],1,1700)
  if(q['code'],q['player'],q['secondary'],q['side'])!=(a['code'],a['player'],a['secondary'],a['side']):raise ValueError('numeric queue/arguments differ')
 return {'index':value['index']+1,'draw':value['draw_end'],'tick':value['tick_end']+1,'action':value['action_end'],'seed':seed}
def state(g):
 s=prefix.snapshot(g);s['ball'].update({**{f'word{k}':g.rd(0xCF46+k)for k in (7,9,11)},**{f'byte{k}':g.rd(0xCF46+k,1)for k in (13,14)}})
 s.update(scores=[g.rd(0xD086,1),g.rd(0xD087,1)],phase=g.rd(0xD0AC,1),active=g.rd(0xD0B8,1),hold=g.rd(0xD0B9,1),stoppage=g.rd(0xD0B4));return s

def reference():
 source=prefix.check();record=json.loads((ROOT/source['record']).read_text());return source,record,prefix.setup.contests.outputs(record)

def validate_finish(final,actions):
 state_check(final)
 if final['elapsed']<90 or final['remaining']!=0 or final['stoppage']!=0:raise ValueError('incomplete watched termination')
 if not any(a['code']==64 and a['minute']>=40 for a in actions):raise ValueError('halftime evidence missing')
 if not any(a['code']==63 and a['minute']>=90 for a in actions):raise ValueError('full-time evidence missing')

def check():
 source,base,expected=reference();index=json.loads(INDEX.read_text());start_path=ROOT/index['start']['path']
 if sha(start_path.read_bytes())!=index['start']['sha256']:raise ValueError('stream start digest differs')
 start=json.loads(start_path.read_text())
 if start['source']!=source or start['state_sha256']!=base['start_state']['sha256']:raise ValueError('stream source identity differs')
 cursor=None;draws=[];actions=[];ticks=[]
 for item in index['chunks']:
  path=ROOT/item['path'];raw=path.read_bytes()
  if sha(raw)!=item['sha256']:raise ValueError('chunk digest differs')
  c=json.loads(raw)
  if sha(encoded(c['payload']))!=c['payload_sha256']:raise ValueError('chunk payload digest differs')
  cursor=validate_chunk(c['payload'],cursor);draws.extend(c['payload']['draws']);actions.extend(c['payload']['actions']);ticks.extend(c['payload']['ticks'])
 if draws[:len(expected['draws'])]!=expected['draws'] or len(draws)<len(expected['draws']):raise ValueError('complete T39 RNG prefix not joined')
 if actions[:32]!=expected['actions'] or len(actions)<32:raise ValueError('complete32-action prefix not joined')
 if not ticks:raise ValueError('no watched ticks')
 first=ticks[0]['before'];old={k:first[k]for k in ('seed','elapsed','remaining','quick','actor','secondary','ball','scenes')};old['ball']={k:first['ball'][k]for k in ('word0','word2','word4','byte6')}
 if old!=expected['first_ticks'][0]['state']:raise ValueError('first watched snapshot differs')
 finish_path=ROOT/index['finish']['path']
 if sha(finish_path.read_bytes())!=index['finish']['sha256']:raise ValueError('finish digest differs')
 finish=json.loads(finish_path.read_text())
 if finish.get('intervention')!=expected['intervention']:raise ValueError('watch intervention differs')
 if finish['status']!='completed' or finish['boundary']!=match.MATCH_RETURN:raise ValueError('original match return not completed')
 if (finish['ticks'],finish['draws'],finish['actions'])!=(cursor['tick']-1,cursor['draw'],cursor['action']):raise ValueError('final cursors differ')
 validate_finish(finish['final'],actions)
 print(f'Complete original watched reference:{finish["ticks"]}ticks/{finish["draws"]}draws/{finish["actions"]}actions,score{finish["final"]["scores"]},elapsed{finish["final"]["elapsed"]}.');return index

def run(publish=False,max_ticks=10000,max_draws=1000000):
 if INDEX.exists():check();print('completed original match unchanged');return
 if match.git('status','--porcelain','--','runtime/emul/watched_complete.py'):raise ValueError('commit observer before capture')
 import unicorn,guest
 source,base,expected=reference();_,data=match.find_state(base['start_state']['sha256']);week=match.Week(data)
 producer=match.git('rev-parse','HEAD');RUNS.mkdir(parents=True,exist_ok=True);INDEX.parent.mkdir(parents=True,exist_ok=True)
 attempts=[int(p.name.split('-')[1])for p in RUNS.glob('attempt-*-start.json')];attempt=max(attempts,default=0)+1
 metadata={'schema':'watched-complete-attempt/1','attempt':attempt,'code_commit':producer,'started':match.utc(),'source':source,'state_sha256':base['start_state']['sha256'],'game_files':{k:sha(v)for k,v in week.files_at_start.items()},'runtime':{'python':platform.python_version(),'unicorn':unicorn.__version__,'settings':{k:getattr(guest,k)for k in ('INSTR_PER_S','KEY_HOLD','PIT_HZ','SLICE_MAX')},'dos_clock':week.g.clock},'bounds':{'ticks':max_ticks,'draws':max_draws,'run_on':500000}}
 start=RUNS/'stream-start.json'
 if start.exists():
  old=json.loads(start.read_text())
  if old['source']!=source or old['state_sha256']!=metadata['state_sha256'] or old['game_files']!=metadata['game_files']:raise ValueError('resume source inputs differ')
 else:write(start,metadata)
 write(RUNS/f'attempt-{attempt:04d}-start.json',metadata)
 def publishing(message,checkpoint=False):
  if not publish:return
  files=[str(p.relative_to(ROOT))for directory in (RUNS,INDEX.parent)for p in directory.rglob('*')if p.is_file()]
  subprocess.run(['git','add','--',*files],cwd=ROOT,check=True)
  if subprocess.run(['git','diff','--cached','--quiet'],cwd=ROOT).returncode:
   subprocess.run(['git','commit','-m',message],cwd=ROOT,check=True);subprocess.run(['git','push'],cwd=ROOT,check=True,timeout=120)
  if checkpoint:
   text=f'ResearchT40 original watched reference in progress on task/T40-watched-complete. {message}. Observer producer{producer};append-only64-tick chunks under runs/T40. No completion is assumed. Resume: .cache/venv/bin/python runtime/emul/watched_complete.py --run --publish (replays/verifies existing chunks,then appends). Native original-engine ports continue independently toward35;no review started.'
   subprocess.run(['gh','issue','comment','1','--body',text],cwd=ROOT,check=True,timeout=60)
 publishing(f'T40 original watched attempt{attempt} started',True)
 cursor=None;chunk_index=0;export_draw=0;export_action=0;export_tick=1;tick_number=0;action_number=0;pending_tick=None;pending_action=None;tick_rows=[];action_rows=[];all_actions=[];joined=False;intervention=None
 def flush():
  nonlocal cursor,chunk_index,export_draw,export_action,export_tick,tick_rows,action_rows
  if not tick_rows and not action_rows and export_draw==week.draws:return
  draws=[e for e in week.events if e['kind']=='draw'];payload={'index':chunk_index,'draw_start':export_draw,'draw_end':week.draws,'tick_start':export_tick,'tick_end':tick_number,'action_start':export_action,'action_end':action_number,'draws':draws[export_draw:],'ticks':tick_rows,'actions':action_rows}
  cursor=validate_chunk(payload,cursor)
  if draws[:min(len(draws),len(expected['draws']))]!=expected['draws'][:min(len(draws),len(expected['draws']))]:raise ValueError('T39 original RNG prefix changed')
  path=RUNS/f'chunk-{chunk_index:06d}.json';digest=sha(encoded(payload))
  if path.exists():
   previous=json.loads(path.read_text())
   if previous['payload_sha256']!=digest or previous['payload']!=payload:raise ValueError('verified-prefix replay differs')
   print(f'verified existing chunk{chunk_index}/tick{tick_number}',flush=True)
  else:
   record={'schema':'original-watched-chunk/1','attempt':attempt,'code_commit':producer,'written':match.utc(),'payload_sha256':digest,'payload':payload}
   with path.open('xb')as f:f.write(encoded(record)+b'\n')
   print(f'original chunk{chunk_index}:tick{tick_number}/draw{week.draws}/actions{action_number}',flush=True)
   publishing(f'T40 original chunk{chunk_index}:tick{tick_number} draw{week.draws} actions{action_number}',chunk_index%4==0)
  chunk_index+=1;export_draw=week.draws;export_action=action_number;export_tick=tick_number+1;tick_rows=[];action_rows=[]
 class Complete(Exception):pass
 final=None
 def enable(g):
  nonlocal intervention
  if intervention is None:
   address=g.far(0xD7D2)+0xF2;intervention={'site':'0AB9:E24C','field':'config+F2','before':g.mem(address,1)[0],'after':1};g.put(address,b'\x01')
 def tick_enter(g):
  nonlocal tick_number,pending_tick,joined
  if pending_tick is not None:raise ValueError('nested watched tick')
  tick_number+=1
  if tick_number>max_ticks or week.draws>max_draws:raise ValueError('original watched reference hard bound reached')
  if tick_number==1:
   if prefix.snapshot(g)!=expected['first_ticks'][0]['state']:raise ValueError('first watched tick differs')
   if [e for e in week.events if e['kind']=='draw']!=expected['setup_draws']:raise ValueError('original258 setup draws differ')
   joined=True
  pending_tick={'tick':tick_number,'draw_start':week.draws,'before':state(g)}
 def tick_leave(g):
  nonlocal pending_tick
  if pending_tick is None:return
  pending_tick.update(draw_end=week.draws,after=state(g));tick_rows.append(pending_tick);pending_tick=None
  if len(tick_rows)==CHUNK_TICKS:flush()
 def action_enter(g):
  nonlocal pending_action
  if not tick_number:return
  if pending_action is not None:raise ValueError('nested commentary')
  args=prefix.arguments(g);code,first,second,side=[args[k]for k in ('code','actor_slot','secondary_slot','side')];club=g.rd(0xD6E4+2*side)
  def player(slot):return 0 if slot==0 else g.word_at(g.far(0xD7C2)+62*(club-1)+2*(slot-1))
  pending_action={'code':code,'actor_slot':first,'secondary_slot':second,'side':side,'club':club,'player':player(first),'secondary':player(second),'minute':g.rd(0xD0B2),'tick':tick_number,'draw_start':week.draws,'seed_before':g.rd(0xA51C),'head_before':g.rd(0x380),'caller':g.image_address(g.reg('cs'),g.stack_word(0))}
 def action_leave(g):
  nonlocal pending_action,action_number
  if pending_action is None:return
  a=pending_action;pending_action=None
  if g.rd(0x380)==a['head_before']:return
  a.update(event=action_number,draw_end=week.draws,seed_after=g.rd(0xA51C),queue=prefix.row(g))
  if action_number<32 and a!=expected['actions'][action_number]:raise ValueError('T39 accepted action prefix changed')
  action_number+=1;action_rows.append(a);all_actions.append(a)
 def end(g):
  nonlocal final
  if tick_number:
   if pending_tick is not None or pending_action is not None:raise ValueError('unfinished original frame at match return')
   final=state(g);raise Complete()
 week.g.code_hook('0AB9:E24C',enable);week.g.code_hook('0AB9:7A02',tick_enter);week.g.code_hook('0AB9:7B79',tick_leave)
 week.g.code_hook('0AB9:0F94',action_enter);week.g.code_hook('0AB9:0FFC',action_leave);week.g.code_hook(match.MATCH_RETURN,end)
 status='completed';reason=None
 try:
  try:week.play(max_run_on=500000)
  except Complete:pass
  else:raise ValueError('week ended without watched match return')
  if not joined or week.g.unsupported or final is None:raise ValueError('unsupported/incomplete watched run')
  validate_finish(final,all_actions);flush()
 except (Exception,KeyboardInterrupt)as exc:status='aborted';reason=f'{type(exc).__name__}: {exc}'
 finish=RUNS/f'attempt-{attempt:04d}-finish.json';write(finish,{'schema':'watched-complete-finish/1','attempt':attempt,'code_commit':producer,'status':status,'reason':reason,'ended':match.utc(),'boundary':match.MATCH_RETURN if status=='completed'else None,'ticks':tick_number,'draws':week.draws,'actions':action_number,'intervention':intervention,'final':final,'scope':'Original watched first match,decoded reference only;never a native runtime backend.'})
 if status=='completed':
  chunks=sorted(RUNS.glob('chunk-*.json'));write(INDEX,{'schema':'complete-original-watched/1','start':{'path':str(start.relative_to(ROOT)),'sha256':sha(start.read_bytes())},'finish':{'path':str(finish.relative_to(ROOT)),'sha256':sha(finish.read_bytes())},'chunks':[{'path':str(p.relative_to(ROOT)),'sha256':sha(p.read_bytes())}for p in chunks]});check()
 publishing(f'T40 watched attempt{attempt} {status}:tick{tick_number} draw{week.draws}',True)
 print(status,reason,flush=True)
 if status!='completed':raise SystemExit(1)

def main():
 p=argparse.ArgumentParser(description=__doc__);g=p.add_mutually_exclusive_group(required=True);g.add_argument('--run',action='store_true');g.add_argument('--check',action='store_true');p.add_argument('--publish',action='store_true');p.add_argument('--max-ticks',type=int,default=10000);p.add_argument('--max-draws',type=int,default=1000000);args=p.parse_args()
 if args.run:run(args.publish,args.max_ticks,args.max_draws)
 else:check()
if __name__=='__main__':main()
