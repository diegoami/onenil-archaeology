#!/usr/bin/env python3
"""T88 natural fresh-friendly caller with safe, authenticated original recovery."""
import argparse
import copy
from functools import lru_cache
import hashlib
import json
import platform
import re
import subprocess
import sys
import time
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT/'runtime/emul'))
import campaign_watched as campaign
import checkpoint
import postmatch_tail as tail
import postmatch_incoming as early
import unicorn
sha=tail.sha
encoded=tail.encoded
git=tail.git
REFERENCE=ROOT/'runs/T67/reference-r0001'
REFERENCE_SHA='ad30ff29d886aff9812a26ef2cfe65362f66026da78f69d3d43cf62b855fe6fb'
ACCEPTED={}
FOLDERS=('runtime/emul','runtime/driver','tools/static','tools/data')

def dependencies(producer):
    if not re.fullmatch('[0-9a-f]{40}',producer):raise ValueError('invalid producer identity')
    rows=git('ls-tree','-r','--name-only',producer).decode().splitlines()
    return sorted(p for p in rows if Path(p).suffix=='.py'and str(Path(p).parent)in FOLDERS)

def authenticate_producer(record):
    names=dependencies(record['producer'])
    if set(record['producer_files'])!=set(names) or 'runtime/emul/fresh_postmatch.py'not in names:
        raise ValueError('producer dependency census differs')
    for name in names:
        if sha(git('show',record['producer']+':'+name))!=record['producer_files'][name]:raise ValueError('producer file differs')

@lru_cache(maxsize=1)
def _load_reference():
    if sha((REFERENCE/'index.json').read_bytes())!=REFERENCE_SHA:raise ValueError('accepted fresh index differs')
    finish,index=campaign.check(REFERENCE,require_repeat=True)
    rows=dict(ticks=[],draws=[],actions=[],finish=finish)
    for item in index['chunks']:
        payload=json.loads((REFERENCE/item['path']).read_text())['payload']
        for k in ('ticks','draws','actions'):rows[k].extend(payload[k])
    base=campaign.source()
    source=dict(reference_index_sha256=REFERENCE_SHA,admission_sha256=campaign.SOURCE_SHA,
        state_sha256=campaign.admission.STATE_SHA,release=base['source']['release'],interventions=[])
    return source,rows

def reference():
    # Immutable expected identity must not alias a caller's mutable receipt.
    if sha((REFERENCE/'index.json').read_bytes())!=REFERENCE_SHA:raise ValueError('accepted fresh index differs')
    source,rows=_load_reference()
    return copy.deepcopy(source),rows

def initial_progress():
    return dict(ticks=0,draws=0,actions=0,pending_tick=None,pending_action=None,joined=False,returned=None,post_draws=[])

class Events:
    """Verify actual draw observations incrementally; never initialize guest state."""
    def __init__(self,state,expected):self.state,self.expected=state,expected
    def append(self,event):
        if event['kind']!='draw':return
        state=self.state
        if state['returned']is not None:state['post_draws'].append(event);return
        n=state['draws']
        if n>=len(self.expected['draws']) or event!=self.expected['draws'][n]:raise ValueError('actual fresh RNG prefix differs at '+str(n))
        state['draws']+=1

def prefix_digest(progress,expected):
    for key in ('ticks','draws','actions'):
        n=progress[key]
        if type(n)is not int or not 0<=n<=len(expected[key]):raise ValueError('invalid recovery cursor')
    return sha(encoded({key:sha(encoded(expected[key][:progress[key]]))for key in ('ticks','draws','actions')}))

def producer():
    head=git('rev-parse','HEAD').decode().strip();names=dependencies(head)
    for name in names:
        if (ROOT/name).read_bytes()!=git('show',head+':'+name):raise ValueError('commit producer before original run: '+name)
    return dict(producer=head,producer_files={n:sha((ROOT/n).read_bytes())for n in names})

def synthetic_receipt():
    src,expected=reference();progress=initial_progress()
    return dict(schema='fresh-postmatch-checkpoint/1',**producer(),source=src,
        unicorn='2.1.4',safe_boundary=True,progress=progress,prefix_sha256=prefix_digest(progress,expected),
        private_sha256='0'*64,private_path='.cache/T88/synthetic.pkl.gz',site='24BC:0C58',registers={},memory_sha256='0'*64)

def validate_checkpoint(receipt):
    src,expected=reference()
    if receipt['schema']!='fresh-postmatch-checkpoint/1' or receipt['source']!=src or receipt['unicorn']!='2.1.4' or receipt['safe_boundary']is not True:
        raise ValueError('foreign/unsafe recovery source or runtime')
    authenticate_producer(receipt)
    p=receipt['progress']
    if p['returned']is not None or p['post_draws']:raise ValueError('checkpoint is inside post-match execution')
    if receipt['prefix_sha256']!=prefix_digest(p,expected):raise ValueError('recovery prefix digest differs')
    if p['pending_tick']is not None:
        want=expected['ticks'][p['ticks']]
        if p['pending_tick']!={k:want[k]for k in ('tick','draw_start','before')}:raise ValueError('pending original tick differs')
    if p['pending_action']is not None:
        want=expected['actions'][p['actions']]
        if any(want.get(k)!=v for k,v in p['pending_action'].items()):raise ValueError('pending original action differs')
    if not re.fullmatch('[0-9a-f]{64}',receipt['private_sha256']):raise ValueError('invalid private digest')
    return expected

def authenticate_recovery(receipt,private):
    expected=validate_checkpoint(receipt)
    if unicorn.__version__!='2.1.4' or sha(private.read_bytes())!=receipt['private_sha256']:
        raise ValueError('private recovery digest/runtime differs; not deserializing')
    return expected

def restore(receipt_path,private):
    # A locally modified/unpublished receipt is not an authority for unpickling.
    relative=receipt_path.resolve().relative_to(ROOT)
    if relative.parts[:2]!=('records','T88') or receipt_path.read_bytes()!=git('show','HEAD:'+str(relative)):
        raise ValueError('unsealed public recovery receipt')
    receipt=json.loads(receipt_path.read_text());expected=authenticate_recovery(receipt,private)
    saved=checkpoint.read_private(private)
    if saved['progress']!=receipt['progress'] or saved['source']!=receipt['source'] or saved['producer']!=receipt['producer']:
        raise ValueError('private/public recovery identity differs')
    state=copy.deepcopy(saved['progress']);sink=Events(state,expected)
    week=checkpoint.restore(saved['machine'],tail.full.match.Week,sink)
    if week.draws!=state['draws'] or week.g.where()!=receipt['site'] or tail.prior.registers(week.g)!=receipt['registers'] or sha(week.g.mem(0,0x110000))!=receipt['memory_sha256']:
        raise ValueError('restored machine/cursor differs')
    early.authenticate_code(week.g)
    return week,state

class Paused(Exception):pass

def run(directory,resume=None,stop_ticks=0,checkpoint_seconds=300):
    meta=producer();src,expected=reference();directory.mkdir(parents=True,exist_ok=True)
    start=directory/'start.json'
    if not start.exists():tail.full.write(start,dict(schema='fresh-postmatch-start/1',**meta,source=src,runtime=dict(python=platform.python_version(),unicorn=unicorn.__version__),interventions=[]))
    existing=json.loads(start.read_text())
    if existing['schema']!='fresh-postmatch-start/1' or existing['source']!=src or existing['interventions']:
        raise ValueError('foreign immutable source start')
    authenticate_producer(existing)
    if resume is not None:
        receipt=json.loads(resume.read_text());week,state=restore(resume,ROOT/receipt['private_path'])
    else:
        _,data=tail.full.match.find_state(src['state_sha256'])
        if sha(data)!=src['state_sha256']:raise ValueError('wrong private fresh start')
        week=tail.full.match.Week(data);state=initial_progress();week.events=Events(state,expected)
        if {n:sha(v)for n,v in week.files_at_start.items()}!=src['release']:raise ValueError('wrong original release')
        campaign.admission.require_campaign(campaign.admission.seed.project(campaign.admission.memory_save(week.g),campaign.admission.seed.names(week.files_at_start['ENGL-95.DAT'])))
    g=week.g;code=early.authenticate_code(g);audit=condition=None;began=time.monotonic();due=began
    last_checkpoint=None
    def safe_boundary(current):
        nonlocal due,last_checkpoint
        if state['returned']is not None:return
        near_end=state['ticks']>=len(expected['ticks'])-64
        stopping=bool(stop_ticks and state['ticks']>=stop_ticks)
        if time.monotonic()<due and not stopping and not near_end:return
        if near_end and last_checkpoint is not None and state['ticks']-last_checkpoint['progress']['ticks']<8 and not stopping:return
        number=max((int(p.stem.split('-r')[1])for p in directory.glob('checkpoint-r*.json')),default=0)+1
        private=ROOT/'.cache/T88'/directory.name/f'checkpoint-r{number:04d}.pkl.gz'
        snapshot=dict(machine=checkpoint.capture(current),progress=copy.deepcopy(state),source=src,producer=meta['producer'])
        digest=checkpoint.write_private(private,snapshot)
        receipt=dict(schema='fresh-postmatch-checkpoint/1',**meta,source=src,unicorn=unicorn.__version__,safe_boundary=True,
            progress=copy.deepcopy(state),prefix_sha256=prefix_digest(state,expected),private_path=str(private.relative_to(ROOT)),private_sha256=digest,
            site=current.g.where(),registers=tail.prior.registers(current.g),memory_sha256=sha(current.g.mem(0,0x110000)))
        tail.full.write(directory/f'checkpoint-r{number:04d}.json',receipt)
        last_checkpoint=receipt;due=time.monotonic()+checkpoint_seconds
        print('SAFE_CHECKPOINT',number,'ticks',state['ticks'],'draws',state['draws'],'elapsed',round(time.monotonic()-began,2),flush=True)
        if stopping:raise Paused()
    def entry(current):
        if state['joined']:return
        if tail.full.state(current)!=campaign.source()['payload']['first_entry'] or state['draws']!=258:
            raise ValueError('fresh preparation/entry join differs')
        state['joined']=True
    def tick_enter(current):
        if not state['joined'] or state['pending_tick']is not None:raise ValueError('unjoined/nested tick')
        n=state['ticks'];want=expected['ticks'][n]
        row=dict(tick=n+1,draw_start=week.draws,before=tail.full.state(current))
        if row!={k:want[k]for k in row}:raise ValueError('original tick entry differs')
        state['pending_tick']=row
    def tick_leave(current):
        row=state['pending_tick']
        if row is None:return
        row.update(draw_end=week.draws,after=tail.full.state(current))
        if row!=expected['ticks'][state['ticks']]:raise ValueError('original tick output differs')
        state['ticks']+=1;state['pending_tick']=None
        if state['ticks']%16==0:print('VERIFIED',state['ticks'],'draws',state['draws'],'actions',state['actions'],'seconds',round(time.monotonic()-began,2),flush=True)
    def action_enter(current):
        if not state['ticks']and state['pending_tick']is None:return
        if state['pending_action']is not None:raise ValueError('nested action')
        args=tail.full.prefix.arguments(current);club=current.rd(0xD6E4+2*args['side'])
        def player(slot):return 0 if slot==0 else current.word_at(current.far(0xD7C2)+62*(club-1)+2*(slot-1))
        state['pending_action']=dict(**args,club=club,player=player(args['actor_slot']),secondary=player(args['secondary_slot']),minute=current.rd(0xD0B2),
            tick=state['ticks']+(state['pending_tick']is not None),draw_start=week.draws,seed_before=current.rd(0xA51C),head_before=current.rd(0x380),caller=current.image_address(current.reg('cs'),current.stack_word(0)))
    def action_leave(current):
        row=state['pending_action'];state['pending_action']=None
        if row is None or current.rd(0x380)==row['head_before']:return
        row.update(event=state['actions'],draw_end=week.draws,seed_after=current.rd(0xA51C),queue=tail.full.prefix.row(current))
        if row!=expected['actions'][state['actions']]:raise ValueError('original action differs')
        state['actions']+=1
    def returned(current):
        nonlocal audit,condition
        if state['returned']is not None:return
        if state['pending_tick']is not None or state['pending_action']is not None or (state['ticks'],state['draws'],state['actions'])!=(len(expected['ticks']),len(expected['draws']),len(expected['actions'])) or tail.full.state(current)!=expected['finish']['final']:
            raise ValueError('natural fresh EBE2 return differs')
        state['returned']=dict(site=current.where(),registers=tail.prior.registers(current),draw=week.draws,seed=current.word_at(current.far(0xDE84)))
        # Install only observers; the original EBE2 push/call runs next.
        audit=tail.NumericAudit(week);condition=tail.prior.Recorder(week)
    for site,callback in [('0AB9:7C67',entry),('0AB9:7A02',tick_enter),('0AB9:7B79',tick_leave),('0AB9:0F94',action_enter),('0AB9:0FFC',action_leave),('0AB9:EBE2',returned)]:g.code_hook(site,callback)
    result=dict(schema='fresh-postmatch-result/1',**meta,source=src,status='aborted',error=None,interventions=[],runtime=dict(python=platform.python_version(),unicorn=unicorn.__version__))
    try:
        try:week.play(max_run_on=500000,on_boundary=safe_boundary)
        except tail.Complete:pass
        if audit is None or audit.returned is None:raise ValueError('original caller did not return')
        result['status']='completed'
    except Paused:result['status']='paused'
    except Exception as error:result['error']=type(error).__name__+': '+str(error)
    result['progress']=dict(ticks=state['ticks'],draws=state['draws'],actions=state['actions'])
    result['prefix_sha256']=prefix_digest(state,expected)
    result['unsupported']=list(g.unsupported)
    result['match_return']=state['returned']
    result['post_draws']=state['post_draws']
    result['caller']=None if audit is None else {k:getattr(audit,k)for k in ('entry','returned','frame','initial','final','ops','regions','draw_start','draw_end','census','preservation','timer_effects','service_effects')}
    result['condition']=None if condition is None else dict(calls=condition.calls,contexts=condition.contexts)
    result['code_before']=code;result['code_after']=early.authenticate_code(g)
    number=max((int(p.stem.split('-r')[1])for p in directory.glob('result-r*.json')),default=0)+1
    path=directory/f'result-r{number:04d}.json';tail.full.write(path,result)
    print('RESULT',result['status'],result['progress'],result['error'],flush=True)
    if result['status']=='aborted':raise ValueError(result['error'])
    return path

def validate_result(record):
    if record.get('schema')!='fresh-postmatch-result/1' or record.get('status')!='completed' or record.get('error')is not None or record.get('unsupported'):
        raise ValueError('incomplete fresh post-match source')
    src,expected=reference()
    if record['source']!=src or record['interventions']:raise ValueError('wrong fresh source/intervention')
    authenticate_producer(record)
    progress=record['progress']
    if progress!={key:len(expected[key])for key in ('ticks','draws','actions')} or record['prefix_sha256']!=prefix_digest(progress,expected):raise ValueError('complete fresh prefix differs')
    a=record['caller']
    if a is None or a['returned']is None or a['preservation']['unexpected_count']!=0 or a['census']['initial']!=len(a['initial']):raise ValueError('incomplete typed caller footprint')
    if record['code_before']!=record['code_after']:raise ValueError('original code changed')
    return dict(ticks=progress['ticks'],draws=progress['draws'],actions=progress['actions'],caller_draws=len(record['post_draws']),writes=a['census']['writes'],fields=len(a['initial']))

def check():
    if len(ACCEPTED)!=2:raise ValueError('two sealed completed caller records required')
    records=[];counts=[]
    for name,digest in ACCEPTED.items():
        data=(ROOT/'records/T88'/name).read_bytes()
        if sha(data)!=digest:raise ValueError('accepted fresh caller digest differs')
        records.append(json.loads(data));counts.append(validate_result(records[-1]))
    if counts[0]!=counts[1]or any(records[0][key]!=records[1][key]for key in ('caller','condition','post_draws','match_return')):raise ValueError('independent restored caller differs')
    return counts[0]

def main():
    parser=argparse.ArgumentParser(description=__doc__);parser.add_argument('--run',type=Path);parser.add_argument('--resume',type=Path);parser.add_argument('--stop-ticks',type=int,default=0);parser.add_argument('--checkpoint-seconds',type=float,default=300);parser.add_argument('--check',action='store_true')
    args=parser.parse_args()
    if args.check:print(json.dumps(check(),sort_keys=True))
    elif args.run:run(args.run,args.resume,args.stop_ticks,args.checkpoint_seconds)
    else:parser.error('choose --run or --check')
if __name__=='__main__':main()
