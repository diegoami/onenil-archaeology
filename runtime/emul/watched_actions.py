#!/usr/bin/env python3
"""Original watched-action prefix;observer only,never a viewer runtime backend."""
import argparse,copy,hashlib,json,platform
from pathlib import Path
import match_setup as setup
match=setup.match
ROOT=setup.ROOT
RUNS=ROOT/'runs/T39';FIXTURES=ROOT/'traces/T39'
STATIC=('static/1-0-exe/code/seg_0AB9_01.asm','static/1-0-exe/code/seg_0AB9_02.asm','static/1-0-exe/code/seg_0AB9_13.asm','static/1-0-exe/code/seg_0AB9_20.asm')
LIMIT=32

def sha(data):return hashlib.sha256(data).hexdigest()
def integer(value,lo,hi):
    if type(value) is not int or not lo<=value<=hi:raise ValueError('invalid integer identity/domain')
def row(g):
    index=g.rd(0x380);a=0xA52A+6*index
    return {'index':index,'code':g.rd(a,1),'player':g.rd(a+1),'secondary':g.rd(a+3),'side':g.rd(a+5,1)}
def snapshot(g):
    return {'seed':g.rd(0xA51C),'elapsed':g.rd(0xD0B2),'remaining':g.rd(0xD0AE),'quick':g.rd(0xD074,1),
            'actor':g.rd(0xD09F,1),'secondary':g.rd(0xD0A0,1),
            'ball':{'word0':g.rd(0xCF46),'word2':g.rd(0xCF48),'word4':g.rd(0xCF4A),'byte6':g.rd(0xCF4C,1)},
            'scenes':[{'index':i,**{f'word{k}':g.rd(0xCCEF+25*i+k) for k in (0,2,4,8,10,14,16,20)},**{f'byte{k}':g.rd(0xCCEF+25*i+k,1) for k in (6,7,12,13,18,19,22,23,24)}} for i in range(1,23)]}

def validate(observed):
    if set(observed)!={'intervention','setup_draws','draws','ticks','actions','first_ticks'}:raise ValueError('prefix fields differ')
    if observed['intervention']!={'site':'0AB9:E24C','field':'config+F2','before':0,'after':1}:raise ValueError('watch intervention differs')
    actions=observed['actions'];integer(observed['ticks'],1,1_000_000)
    if len(actions)!=LIMIT:raise ValueError('32 accepted original actions required')
    draws=observed['draws']
    if len(draws)<258 or observed['setup_draws']!=draws[:258]:raise ValueError('setup draw prefix differs')
    for i,d in enumerate(draws):
        integer(d['i'],i,i)
        if i and d['seed_before']!=draws[i-1]['seed_after']:raise ValueError('ordered RNG seed continuity differs')
    if not observed['first_ticks'] or any(t['state']['quick']!=0 for t in observed['first_ticks']):raise ValueError('watched mode not reached')
    for i,a in enumerate(actions):
        integer(a['event'],i,i);integer(a['draw_start'],258,len(draws));integer(a['draw_end'],a['draw_start'],len(draws))
        integer(a['code'],0,63);integer(a['side'],0,1);integer(a['player'],0,3920);integer(a['secondary'],0,3920)
        integer(a['minute'],0,128);integer(a['tick'],1,observed['ticks'])
        if a['queue']['code']!=a['code'] or a['queue']['player']!=a['player'] or a['queue']['secondary']!=a['secondary'] or a['queue']['side']!=a['side']:raise ValueError('numeric queue/argument identity differs')
        if i and a['draw_start']<actions[i-1]['draw_end']:raise ValueError('action cursor order differs')
        if a['seed_before']!=draws[a['draw_start']-1]['seed_after']:raise ValueError('action input seed differs')
        if a['seed_after']!=draws[a['draw_end']-1]['seed_after']:raise ValueError('action output seed differs')

def source():
    path=ROOT/'runs/T38/T38-r0002.json';base=json.loads(path.read_text())
    return path,base

def check():
    index=json.loads((FIXTURES/'index.json').read_text())
    path=ROOT/index['record'];record=json.loads(path.read_text())
    if sha(path.read_bytes())!=index['record_sha256'] or record['status']!='completed':raise ValueError('completed prefix record differs')
    if index['static_sources']!={p:sha((ROOT/p).read_bytes()) for p in STATIC}:raise ValueError('static source pins differ')
    path,base=source()
    if record['actions']['source']!={'record':str(path.relative_to(ROOT)),'sha256':sha(path.read_bytes())}:raise ValueError('source pin differs')
    if record['start_state']!=base['start_state']:raise ValueError('start state differs')
    observed=setup.contests.outputs(record);validate(observed)
    expected=setup.contests.outputs(base)['draws']
    if observed['setup_draws']!=expected:raise ValueError('original258 setup draws differ')
    rows=''.join(json.dumps(a,sort_keys=True,separators=(',',':'))+'\n' for a in observed['actions']).encode()
    if rows!=(FIXTURES/'actions.jsonl').read_bytes() or sha(rows)!=index['actions_sha256']:raise ValueError('decoded action export differs')
    return index

def run():
    import guest,unicorn,cycle
    if match.git('status','--porcelain','--','runtime/emul'):raise ValueError('commit observer before capture')
    RUNS.mkdir(exist_ok=True);FIXTURES.mkdir(exist_ok=True)
    if (FIXTURES/'index.json').exists():check();print('completed prefix unchanged');return
    path,base=source();_,data=match.find_state(base['start_state']['sha256']);week=match.Week(data)
    out={'intervention':None,'setup_draws':[],'draws':[],'ticks':0,'actions':[],'first_ticks':[]};pending=None
    class Complete(Exception):pass
    def enable(g):
        if out['intervention'] is not None:return
        address=g.far(0xD7D2)+0xF2;before=g.mem(address,1)[0]
        out['intervention']={'site':'0AB9:E24C','field':'config+F2','before':before,'after':1};g.put(address,b'\x01')
    def tick(g):
        out['ticks']+=1
        if out['ticks']==1:
            out['setup_draws']=[e.copy() for e in week.events if e['kind']=='draw']
            if out['setup_draws']!=setup.contests.outputs(base)['draws']:raise ValueError('first watched tick does not join original258 setup draws')
        if len(out['first_ticks'])<3:out['first_ticks'].append({'tick':out['ticks'],'draw':week.draws,'state':snapshot(g)})
    def enter(g):
        nonlocal pending
        if not out['ticks']:return
        if pending is not None:raise ValueError('nested commentary request')
        code,first,second,side=[g.stack_word(i) for i in (2,4,6,8)];club=g.rd(0xD6E4+2*side)
        def player(slot):return 0 if slot==0 else int.from_bytes(g.mem(g.far(0xD7C2)+62*(club-1)+2*(slot-1),2),'little')
        pending={'code':code,'actor_slot':first,'secondary_slot':second,'side':side,'club':club,
                 'player':player(first),'secondary':player(second),'minute':g.rd(0xD0B2),'tick':out['ticks'],
                 'draw_start':week.draws,'seed_before':g.rd(0xA51C),'head_before':g.rd(0x380),
                 'caller':g.image_address(g.reg('cs'),g.stack_word(0))}
    def leave(g):
        nonlocal pending
        if pending is None:return
        value=pending;pending=None
        if g.rd(0x380)==value['head_before']:return
        value.update(event=len(out['actions']),draw_end=week.draws,seed_after=g.rd(0xA51C),queue=row(g))
        out['actions'].append(value);print(f'action{len(out["actions"])} code{value["code"]} player{value["player"]} tick{out["ticks"]}',flush=True)
        if len(out['actions'])==LIMIT:raise Complete()
    week.g.code_hook('0AB9:E24C',enable);week.g.code_hook('0AB9:7A02',tick)
    week.g.code_hook('0AB9:0F94',enter);week.g.code_hook('0AB9:0FFC',leave)
    commit=match.git('rev-parse','HEAD');started=match.utc();status='completed'
    try:
        try:week.play(on_boundary=lambda w:print(f'watched prefix screen{w.screen_i}/draws{w.draws}',flush=True))
        except Complete:pass
        else:raise ValueError('prefix ended before32 accepted actions')
        if week.g.unsupported:raise ValueError('unsupported guest services')
        out['draws']=[e for e in week.events if e['kind']=='draw'];validate(out)
    except (Exception,KeyboardInterrupt) as exc:
        status=f'aborted: {type(exc).__name__}: {exc}';out['draws']=[e for e in week.events if e['kind']=='draw']
    n=match.next_number(RUNS,'T39-r*.json');rid=f'T39-r{n:04d}';record=copy.deepcopy(base)
    record.update(run_id=rid,experiment='T39',arm='watched_action_prefix',rep=n,code_commit=commit,machine=cycle.machine_id(),started=started,ended=match.utc(),status=status,
                  actions={'script':'runtime/emul/watched_actions.py --run','source':{'record':str(path.relative_to(ROOT)),'sha256':sha(path.read_bytes())},'game_files':{k:sha(v) for k,v in week.files_at_start.items()}},
                  outputs=[{'name':k,'value':v} for k,v in out.items()],observations=[{'step':0,'source':'log','field':'scope','value':'Original watched32-action prefix with deliberate watch-setting intervention;no complete match/DOSBox or native backend claim.'}])
    record['runtime']['harness']=f'runtime/emul/watched_actions.py@{commit}';record['runtime']['unicorn']=unicorn.__version__;record['runtime']['python']=platform.python_version()
    record['interventions']=[{'level':'I3','what':'original harness services;explicit config+F2 watch enable atE24C;read-only action/tick hooks;intentional prefix stop'}]
    target=RUNS/(rid+'.json');match.write_record(target,record);print(rid+': '+status,flush=True)
    if status!='completed':raise SystemExit(1)
    rows=''.join(json.dumps(a,sort_keys=True,separators=(',',':'))+'\n' for a in out['actions']).encode()
    with (FIXTURES/'actions.jsonl').open('xb') as f:f.write(rows)
    index={'schema':'watched-action-prefix/1','record':str(target.relative_to(ROOT)),'record_sha256':sha(target.read_bytes()),'actions_sha256':sha(rows),'static_sources':{p:sha((ROOT/p).read_bytes()) for p in STATIC},'producer_commit':commit}
    with (FIXTURES/'index.json').open('x') as f:json.dump(index,f,indent=2);f.write('\n')

def main():
    p=argparse.ArgumentParser(description=__doc__);g=p.add_mutually_exclusive_group(required=True);g.add_argument('--run',action='store_true');g.add_argument('--check',action='store_true');args=p.parse_args()
    if args.run:run();return 0
    try:check()
    except (ValueError,OSError,KeyError,TypeError,IndexError) as e:print('watched-action check:FAIL: '+str(e));return 1
    print('watched-action check:ok (32 original accepted actions,watched ticks,258-draw setup join)');return 0
if __name__=='__main__':raise SystemExit(main())
