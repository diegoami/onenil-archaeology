#!/usr/bin/env python3
"""T66: observe actual supplied-SAVE1 PSG preparation; no native engine/model."""
import argparse,copy,hashlib,importlib.util,json,platform,subprocess,sys,time
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT/'runtime/emul'));sys.path.insert(0,str(ROOT/'tools/data'))
import match,match_setup as setup,watched_complete as watched,campaign_seed as seed
TOOL='runtime/emul/campaign_admission.py'
STATE_SHA='7a66ef10043b0a6da9312b8f729a5c4e6009096d955c1f7f4a7cf9b2507a78fc'
SEED_RECORD='runs/T65/seed-r0001.json'
SITES=('0AB9:E24C','0AB9:E24F','0AB9:86E9','0AB9:E2D4','0AB9:E2D9','0AB9:E2EF','0AB9:E303','0AB9:E008','0AB9:7D86','0AB9:7DC8','0AB9:7C67')
sha=lambda data:hashlib.sha256(data).hexdigest()
def encoded(value):return json.dumps(value,sort_keys=True,separators=(',',':')).encode()
def git(*args):return subprocess.check_output(['git','-C',str(ROOT),*args])
def expected_campaign():return json.loads((ROOT/SEED_RECORD).read_text())['initial']
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
 require_campaign(p['campaign'])
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
 if r['schema']!='original-campaign-admission/1' or r['status']!='completed':raise ValueError('incomplete campaign admission')
 if r['source']['state_sha256']!=STATE_SHA or r['source']['t65_record_sha256']!=sha((ROOT/SEED_RECORD).read_bytes()):raise ValueError('source identity differs')
 source=json.loads((ROOT/SEED_RECORD).read_text())
 if r['source']['save_sha256']!=source['save_sha256'] or r['source']['league_sha256']!=source['league_sha256']:raise ValueError('save/league source identity differs')
 release={p['name']:p['sha256'] for p in json.loads((ROOT/'records/T01/inventory.json').read_text())['files'] if p['edition']=='96'}
 if r['source']['release']!=release or r['unsupported']:raise ValueError('release/runtime identity differs')
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
 campaign=seed.project(memory_save(g),seed.names(files['ENGL-95.DAT']));require_campaign(campaign)
 watch=g.mem(g.far(0xD7D2)+0xF2,1)[0]
 if watch!=1:raise ValueError('start RAM does not request watched play')
 payload=dict(campaign=campaign,watch_setting=watch,interventions=[],fixture_request=None,incoming=None,points=[],draws=[],selected_admission=None,supplement=None,first_entry=None)
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
  try:week.play(on_boundary=lambda w:print('PSG original boundary',w.screen_i,'draws',w.draws,flush=True))
  except Complete:pass
  else:raise ValueError('original did not reach first watched entry')
  if g.unsupported:raise ValueError('unsupported guest services')
  payload['draws']=[d for d in week.events if d['kind']=='draw'];validate_payload(payload)
 except (Exception,KeyboardInterrupt) as exc:status='aborted';error=f'{type(exc).__name__}: {exc}';payload['draws']=[d for d in week.events if d['kind']=='draw']
 result=dict(schema='original-campaign-admission/1',producer=git('rev-parse','HEAD').decode().strip(),producer_files={name:sha((ROOT/name).read_bytes()) for name in producer_files},source=dict(state_sha256=sha(data),state_size=len(data),save_sha256=sha(files['SAVE1.1-0']),league_sha256=sha(files['ENGL-95.DAT']),release=release,t65_record_sha256=sha((ROOT/SEED_RECORD).read_bytes())),runtime=dict(python=platform.python_version(),unicorn=__import__('unicorn').__version__),elapsed_seconds=time.monotonic()-start,status=status,error=error,payload=payload,payload_sha256=sha(encoded(payload)),unsupported=g.unsupported,keys_delivered=g.keys_delivered)
 out.parent.mkdir(parents=True,exist_ok=True)
 with out.open('x') as f:json.dump(result,f,indent=2);f.write('\n')
 print(status,error or '',len(payload['points']),'boundaries',len(payload['draws']),'draws',flush=True)
 if status!='completed':raise ValueError(error)
def incoming_supplement(path,base_path,out):
 if out.exists():raise ValueError('record path already exists')
 if git('status','--porcelain','--','runtime/emul').strip():raise ValueError('commit observer first')
 base=json.loads(base_path.read_text());validate_record(base);data=path.read_bytes()
 if sha(data)!=STATE_SHA:raise ValueError('start RAM identity differs')
 week=match.Week(data);g=week.g
 require_campaign(seed.project(memory_save(g),seed.names(week.files_at_start['ENGL-95.DAT'])))
 result=None
 class Complete(Exception):pass
 def observe(g):
  nonlocal result
  current=setup.state(week);expected=base['payload']['points'][2]
  if current!=expected['state'] or week.draws!=expected['draw']:raise ValueError('supplement reached a different pre86E9 state')
  result=dict(pre86_state_sha256=sha(encoded(current)),draws=[e for e in week.events if e['kind']=='draw'],
   fields=dict(managed_selection_mode=g.mem(g.far(0xD7D2)+0xF6,1)[0],legacy_income_total=g.rd(0xD6E8,4),
   legacy_queue_zero=dict(index=0,code=g.rd(0xA52A,1),first_player=g.rd(0xA52B),second_player=g.rd(0xA52D),side=g.rd(0xA52F,1))))
  raise Complete()
 g.code_hook('0AB9:86E9',observe)
 try:week.play()
 except Complete:pass
 if result is None or g.unsupported:raise ValueError('supplement incomplete/unsupported')
 r=dict(schema='original-campaign-incoming/1',producer=git('rev-parse','HEAD').decode().strip(),observer_sha256=sha(Path(__file__).read_bytes()),source=dict(record=str(base_path.relative_to(ROOT) if base_path.is_absolute() else base_path),record_sha256=sha(base_path.read_bytes()),state_sha256=sha(data)),payload=result)
 out.parent.mkdir(parents=True,exist_ok=True)
 with out.open('x') as f:json.dump(r,f,indent=2);f.write('\n')
 validate_incoming(r);print('PASS same original pre86E9; additional incoming fields',result['fields'],flush=True)
def validate_incoming(r):
 if r['schema']!='original-campaign-incoming/1' or r['source']['state_sha256']!=STATE_SHA:raise ValueError('supplement identity differs')
 if sha(git('show',r['producer']+':'+TOOL))!=r['observer_sha256']:raise ValueError('supplement observer identity differs')
 base_path=ROOT/r['source']['record']
 if sha(base_path.read_bytes())!=r['source']['record_sha256']:raise ValueError('supplement base identity differs')
 base=json.loads(base_path.read_text());validate_record(base);point=base['payload']['points'][2];p=r['payload']
 if p['pre86_state_sha256']!=sha(encoded(point['state'])) or p['draws']!=base['payload']['draws'][:point['draw']]:raise ValueError('supplement join differs')
 if set(p['fields'])!={'managed_selection_mode','legacy_income_total','legacy_queue_zero'}:raise ValueError('supplement fields differ')
 if p['fields']['legacy_income_total']!=point['income_total']:raise ValueError('supplement income alias differs')
def main():
 p=argparse.ArgumentParser();g=p.add_mutually_exclusive_group(required=True);g.add_argument('--run',type=Path);g.add_argument('--check',type=Path);p.add_argument('--record',type=Path);p.add_argument('--compare',type=Path);p.add_argument('--supplement-of',type=Path);a=p.parse_args()
 if a.run:
  if a.record is None:p.error('--run needs --record')
  if a.supplement_of:incoming_supplement(a.run,a.supplement_of,a.record)
  else:capture(a.run,a.record)
 else:
  r=json.loads(a.check.read_text())
  if r['schema']=='original-campaign-incoming/1':
   validate_incoming(r);print('PASS incoming supplement source,observer and original draw/state join');return
  validate_record(r)
  for field in ['fixture','roster','seed','projection']:
   bad=copy.deepcopy(r)
   if field=='fixture':bad['payload']['fixture_request']['club']=134
   elif field=='roster':bad['payload']['selected_admission']['clubs'][0]['roster'][0]=0
   elif field=='seed':bad['payload']['points'][-1]['seed']^=1
   else:bad['payload']['campaign']['cash']+=1
   bad['payload_sha256']=sha(encoded(bad['payload']))
   try:validate_record(bad)
   except ValueError:pass
   else:raise ValueError('corruption accepted:'+field)
  if a.compare:
   other=json.loads(a.compare.read_text());validate_record(other)
   if r['payload']!=other['payload']:raise ValueError('independent original repeats differ')
  print('PASS supplied PSG campaign,original boundaries and RNG;4 corruptions rejected'+(';independent repeat identical' if a.compare else ''))
if __name__=='__main__':main()
