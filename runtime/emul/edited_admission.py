#!/usr/bin/env python3
"""T69: original keyboard-edited Pearce/Hendry preparation; no gameplay-data writes."""
import argparse,copy,hashlib,importlib.util,json,platform,subprocess,sys,time
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT/'runtime/emul'));sys.path.insert(0,str(ROOT/'tools/data'))
import match,match_setup as setup,watched_complete as watched,campaign_seed as seed
TOOL='runtime/emul/edited_admission.py'
STATE_SHA='7a66ef10043b0a6da9312b8f729a5c4e6009096d955c1f7f4a7cf9b2507a78fc'
SEED_RECORD='runs/T65/seed-r0001.json'
SITES=('0AB9:E24C','0AB9:E24F','0AB9:86E9','0AB9:E2D4','0AB9:E2D9','0AB9:E2EF','0AB9:E303','0AB9:E008','0AB9:7D86','0AB9:7DC8','0AB9:7C67')
sha=lambda data:hashlib.sha256(data).hexdigest()
def encoded(value):return json.dumps(value,sort_keys=True,separators=(',',':')).encode()
def git(*args):return subprocess.check_output(['git','-C',str(ROOT),*args])
UI_KEYS=['space','Down','Return','Down','Return','Escape','Up']
UI_STAGES=['main-before','squad','source','picked','destination','placed','main-return','main-after']
UI_SELECTED=[None,2581,2582,2582,2583,2582,None,None]
UI_MENU=['PLAY NEXT GAME',None,None,None,None,None,'Players','PLAY NEXT GAME']
def initial_campaign():return json.loads((ROOT/SEED_RECORD).read_text())['initial']
def expected_campaign():
 value=initial_campaign();value['club']['first_team'][1:3]=[2583,2582];return value

def validate_edit(payload):
 if payload['initial_campaign']!=initial_campaign():raise ValueError('initial campaign differs')
 require_campaign(payload['campaign'])
 ui=payload['ui']
 if len(ui)!=8:raise ValueError('incomplete UI edit witness')
 for i,step in enumerate(ui):
  if set(step)!={'stage','key','selected_player','put_here','screen_sha256','roster','menu'}:raise ValueError('UI shape differs')
  if step['stage']!=UI_STAGES[i] or step['key']!=(None if i==0 else UI_KEYS[i-1]):raise ValueError('UI key/stage differs')
  if step['selected_player']!=UI_SELECTED[i] or step['put_here']!=(i in (3,4)):raise ValueError('UI selection/pick differs')
  if step['menu']!=UI_MENU[i]:raise ValueError('original menu selection differs')
  digest=step['screen_sha256']
  if len(digest)!=64 or any(c not in '0123456789abcdef' for c in digest):raise ValueError('invalid screen digest')
  expected=initial_campaign() if i<5 else expected_campaign()
  if step['roster']!=expected['club']['first_team']:raise ValueError('UI roster differs')

def edit_week(week,ui):
 g=week.g;tables=seed.names(week.files_at_start['ENGL-95.DAT'])
 names={p['id']:p['name'] for p in initial_campaign()['players']}
 for i,stage in enumerate(UI_STAGES):
  key=None if i==0 else UI_KEYS[i-1]
  if key:g.press(key)
  if not g.run(max_steps=400_000_000):raise ValueError('UI key wait not reached')
  sc=g.screen();text=sc.text();highlights=[t for _,t in match.screens.highlighted(sc)]
  if i in (0,6,7):
   if 'GAME NAME' not in text or 'PLAY NEXT GAME' not in text:raise ValueError('expected original main menu')
   if not any(t.startswith(UI_MENU[i]) for t in highlights):raise ValueError('original main selection differs')
   selected=None
  else:
   matches={identifier for identifier,name in names.items() if any(name in t for t in highlights)}
   if matches!={UI_SELECTED[i]}:raise ValueError('original selected player differs: '+str(sorted(matches)))
   selected=next(iter(matches))
  put_here='PUT HERE' in text
  if put_here!=(i in (3,4)):raise ValueError('original pick mode differs')
  address=g.far(0xD7C2)+(130-1)*62
  roster=[g.word_at(address+2*j) for j in range(20)]
  ui.append(dict(stage=stage,key=key,selected_player=selected,put_here=put_here,menu=UI_MENU[i],screen_sha256=sc.digest(),roster=roster))
  print('original edit',stage,'selected',selected,'draws',week.draws,flush=True)
 result=seed.project(memory_save(g),tables);require_campaign(result)
 return result

def require_campaign(value,expected=None):
 expected=expected_campaign() if expected is None else expected
 if value!=expected:raise ValueError('start campaign differs from authenticated supplied SAVE1')
 if value['club']['id']!=130 or value['next_fixture']['opponent']!=17 or value['week_index']!=0:raise ValueError('not the initial PSG campaign')
def memory_save(g):
 out=[]
 for destination,size in seed.save.BLOCKS:
  offset=int(destination.strip('[]').split(':')[1],16)
  address=g.far(offset) if destination.startswith('[') else g.DS*16+offset
  out.append(g.mem(address,size))
 return b''.join(out)
def validate_payload(p):
 validate_edit(p)
 if p['watch_setting']!=1 or p['interventions']:raise ValueError('unobserved watch/input intervention')
 if p['fixture_request']!={'week':1,'club':130}:raise ValueError('caller fixture differs')
 if [point['site'] for point in p['points']]!=list(SITES):raise ValueError('boundary census/order differs')
 points=p['points'];draws=p['draws']
 # [confirmed] Original19CA overwrites the seed from season/week before selector draws.
 config=points[0]['state']['initial']['config']
 if not draws or draws[0]['seed_before']!=(config[1]*58+config[0])&65535:raise ValueError('selector reseeding alias differs')
 if [d['i'] for d in draws]!=list(range(len(draws))):raise ValueError('draw cursor differs')
 for before,after in zip(draws,draws[1:]):
  if before['seed_after']!=after['seed_before']:raise ValueError('RNG chain differs')
 if points[2]['draw']-points[0]['draw']!=255 or points[-1]['draw']-points[2]['draw']!=3:raise ValueError('original preparation draw census differs')
 for point in points:
  cursor=point['draw']
  if cursor<0 or cursor>len(draws):raise ValueError('boundary draw cursor outside prefix')
  if cursor and point['seed']!=draws[cursor-1]['seed_after']:raise ValueError('boundary seed differs')

  if point['seed']!=point['state']['caller']['seed']:raise ValueError('caller seed alias differs')
  clubs=point['state']['caller']['pairing']['context']['rebuild']['outer']['selection']['clubs']
  if {club['id'] for club in clubs}!={130,17}:raise ValueError('selected club aliases differ')
 before=points[2]['state'];derived=setup.admission(before)
 if derived!=p['selected_admission']:raise ValueError('incoming projection differs from actual pre86E9')
 original={v['id']:v for v in p['campaign']['players']}
 own=next(c for c in derived['clubs'] if c['id']==130)
 if own['roster']!=[v or 0 for v in p['campaign']['club']['first_team']]:raise ValueError('managed selected roster differs')
 for player in derived['players']:
  if player['id'] in original:
   saved=original[player['id']]
   if (player['p8_6'],player['p8_7'],player['p15_10'])!=(saved['current_position'],saved['club_position'],saved['individual_instructions']):raise ValueError('managed player position/instruction differs')
 watched.state_check(p['first_entry'])
 if p['first_entry']['seed']!=points[-1]['seed']:raise ValueError('first-entry seed alias differs')
 if len(p['first_entry']['scenes'])!=22:raise ValueError('first-entry player census differs')
 ball=p['first_entry']['ball'];incoming=p['incoming']
 if (ball['byte6'],ball['word7'],ball['word9'],p['first_entry']['scores'])!=(incoming['ball_byte6'],incoming['ball_word7'],incoming['ball_word9'],incoming['scores']):raise ValueError('incoming watched preservation alias differs')
 if set(p['supplement'])!={'capacities','start_gate','club_factors','fixture_factors'}:raise ValueError('incoming supplement shape differs')
 if {row['club'] for row in p['supplement']['capacities']}!={130,17}:raise ValueError('supplement club differs')
def validate_record(r):
 if r['schema']!='original-edited-admission/1' or r['status']!='completed':raise ValueError('incomplete campaign admission')
 if r['source']['state_sha256']!=STATE_SHA or r['source']['t65_record_sha256']!=sha((ROOT/SEED_RECORD).read_bytes()):raise ValueError('source identity differs')
 source=json.loads((ROOT/SEED_RECORD).read_text())
 if r['source']['save_sha256']!=source['save_sha256'] or r['source']['league_sha256']!=source['league_sha256']:raise ValueError('save/league source identity differs')
 release={p['name']:p['sha256'] for p in json.loads((ROOT/'records/T01/inventory.json').read_text())['files'] if p['edition']=='96'}
 if r['source']['release']!=release or r['unsupported']:raise ValueError('release/runtime identity differs')
 if r['keys_delivered']!=[[key,'24BC:0C58'] for key in UI_KEYS+['Return','Return']]:raise ValueError('original IRQ1 key witness differs')
 expected_files=set(git('ls-tree','-r','--name-only',r['producer'],'--','runtime/emul').decode().splitlines())
 expected_files={name for name in expected_files if name.endswith('.py')}|{'runtime/driver/savestate.py','runtime/driver/screens.py','tools/data/campaign_seed.py','tools/data/save.py','tools/data/league.py'}
 if set(r['producer_files'])!=expected_files:raise ValueError('producer closure differs')
 for name,digest in r['producer_files'].items():
  if sha(git('show',r['producer']+':'+name))!=digest:raise ValueError('producer source differs')
 if sha(encoded(r['payload']))!=r['payload_sha256']:raise ValueError('payload digest differs')
 validate_payload(r['payload'])
def capture(path,out):
 if out.exists():raise ValueError('record path already exists')
 producer_files=[str(p.relative_to(ROOT)) for p in sorted((ROOT/'runtime/emul').glob('*.py'))]+['runtime/driver/savestate.py','runtime/driver/screens.py','tools/data/campaign_seed.py','tools/data/save.py','tools/data/league.py']
 if git('status','--porcelain','--',*producer_files).strip():raise ValueError('commit observer and dependencies first')
 data=path.read_bytes()
 if sha(data)!=STATE_SHA:raise ValueError('start RAM identity differs')
 supplied=json.loads((ROOT/SEED_RECORD).read_text());files=match.game_files()
 if sha(files['SAVE1.1-0'])!=supplied['save_sha256'] or sha(files['ENGL-95.DAT'])!=supplied['league_sha256']:raise ValueError('supplied game files differ')
 inventory=json.loads((ROOT/'records/T01/inventory.json').read_text())
 release={p['name']:p['sha256'] for p in inventory['files'] if p['edition']=='96'}
 if any(name not in files or sha(files[name])!=digest for name,digest in release.items()):raise ValueError('original96 release identity differs')
 week=match.Week(data);g=week.g
 campaign=seed.project(memory_save(g),seed.names(files['ENGL-95.DAT']));require_campaign(campaign,initial_campaign())
 watch=g.mem(g.far(0xD7D2)+0xF2,1)[0]
 if watch!=1:raise ValueError('start RAM does not request watched play')
 payload=dict(initial_campaign=campaign,campaign=None,ui=[],watch_setting=watch,interventions=[],fixture_request=None,incoming=None,points=[],draws=[],selected_admission=None,supplement=None,first_entry=None)
 class Complete(Exception):pass
 def observe(g,site):
  if site==SITES[0]:
   ss=16*g.reg('ss');bp=g.reg('bp');payload['fixture_request']=dict(week=g.word_at(ss+bp+4),club=g.word_at(ss+bp+6))
   payload['incoming']=dict(ball_byte6=g.rd(0xCF4C,1),ball_word7=g.rd(0xCF4D),ball_word9=g.rd(0xCF4F),scores=[g.rd(0xD086,1),g.rd(0xD087,1)])
  current=setup.state(week)
  payload['points'].append(dict(site=site,draw=week.draws,seed=g.word_at(g.far(0xDE84)),state=current,income_total=g.rd(0xD6E8,4)))
  print('original PSG',site,'draw',week.draws,flush=True)
  if site=='0AB9:86E9':
   payload['selected_admission']=setup.admission(current)
   payload['income_inputs']=[setup.income_input(g,club['id']) for club in payload['selected_admission']['clubs']]
   payload['supplement']=setup.input_fields(g,{'outputs':[{'name':'admission','value':payload['selected_admission']}]})
  if site==SITES[-1]:payload['first_entry']=watched.state(g);raise Complete()
 for site in SITES:g.code_hook(site,lambda g,site=site:observe(g,site))
 status='completed';error=None;start=time.monotonic()
 try:
  payload['campaign']=edit_week(week,payload['ui'])
  try:week.play(on_boundary=lambda w:print('PSG original boundary',w.screen_i,'draws',w.draws,flush=True))
  except Complete:pass
  else:raise ValueError('original did not reach first watched entry')
  if g.unsupported:raise ValueError('unsupported guest services')
  payload['draws']=[d for d in week.events if d['kind']=='draw'];validate_payload(payload)
 except (Exception,KeyboardInterrupt) as exc:status='aborted';error=f'{type(exc).__name__}: {exc}';payload['draws']=[d for d in week.events if d['kind']=='draw']
 result=dict(schema='original-edited-admission/1',producer=git('rev-parse','HEAD').decode().strip(),producer_files={name:sha((ROOT/name).read_bytes()) for name in producer_files},source=dict(state_sha256=sha(data),state_size=len(data),save_sha256=sha(files['SAVE1.1-0']),league_sha256=sha(files['ENGL-95.DAT']),release=release,t65_record_sha256=sha((ROOT/SEED_RECORD).read_bytes())),runtime=dict(python=platform.python_version(),unicorn=__import__('unicorn').__version__),elapsed_seconds=time.monotonic()-start,status=status,error=error,payload=payload,payload_sha256=sha(encoded(payload)),unsupported=g.unsupported,keys_delivered=g.keys_delivered)
 if status=='completed':
  try:validate_record(result)
  except (ValueError,KeyError,TypeError) as exc:
   status='aborted';error='public validation: '+str(exc);result.update(status=status,error=error)
 out.parent.mkdir(parents=True,exist_ok=True)
 with out.open('x') as f:json.dump(result,f,indent=2);f.write('\n')
 print(status,error or '',len(payload['points']),'boundaries',len(payload['draws']),'draws',flush=True)
 if status!='completed':raise ValueError(error)
def main():
 p=argparse.ArgumentParser();group=p.add_mutually_exclusive_group(required=True)
 group.add_argument('--run',type=Path);group.add_argument('--check',type=Path)
 p.add_argument('--record',type=Path);p.add_argument('--compare',type=Path);args=p.parse_args()
 if args.run:
  if args.record is None:p.error('--record required')
  capture(args.run,args.record)
 else:
  record=json.loads(args.check.read_text());validate_record(record)
  if args.compare:
   other=json.loads(args.compare.read_text());validate_record(other)
   for name in ['source','payload','keys_delivered','unsupported']:
    if record[name]!=other[name]:raise ValueError('independent repeat differs: '+name)
  print('PASS edited initial campaign,IRQ1/UI witnesses,pre86E9 and watched-entry joins'+('; independent repeat equal' if args.compare else ''))
if __name__=='__main__':main()
