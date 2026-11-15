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
    g=week.g
    if g.mem(g.far(0xD7D2)+0xF2,1)[0]!=1:raise ValueError('fresh watch setting differs; no patch permitted')
    code=early.authenticate_code(g);audit=condition=None;began=time.monotonic();due=began+(checkpoint_seconds if resume is not None else 0)
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

def numeric_caller(record):
    """Replay observed numeric reads/stores only; no game or RNG algorithm."""
    caller=record['caller'];boundary=record['match_return'];post=record['post_draws']
    if caller is None or caller['returned']is None or not post:raise ValueError('missing completed caller')
    entry=caller['entry'];frame=caller['frame'];returned=caller['returned']
    before=boundary['registers']
    if entry['sp']!=(before['sp']-4)&65535 or returned['sp']!=(entry['sp']+4)&65535 or any(entry[k]!=before[k]or returned[k]!=entry[k]for k in('cs','ds','ss','bp')):
        raise ValueError('actual match/caller return frame differs')
    if frame['parent_bp']!=entry['bp'] or frame['detailed']!=1:raise ValueError('caller parent context differs')
    if caller['draw_start']!=boundary['draw'] or post[0]['seed_before']!=boundary['seed'] or [d['i']for d in post]!=list(range(caller['draw_start'],caller['draw_end'])):
        raise ValueError('actual caller RNG cursor differs')
    for i,draw in enumerate(post):
        if not 1<=draw['value']<=max(1,draw['n'])or(i and draw['seed_before']!=post[i-1]['seed_after']):raise ValueError('caller literal RNG chain differs')
    expected_census=dict(reads=sum(x['kind']=='read'for x in caller['ops']),writes=sum(x['kind']=='write'for x in caller['ops']),initial=len(caller['initial']))
    if caller['census']!=expected_census or caller['preservation']['unexpected_count']!=0 or caller['preservation']['unexpected_first']!=[]:
        raise ValueError('caller census/preservation differs')
    value_bytes=tail.value_bytes;memory_value=tail.memory_value;POOL_SPECS=tail.POOL_SPECS;DS_RANGES=tail.DS_RANGES;prior=tail.prior
    memory = {}
    for item in caller['initial']:
        raw = value_bytes(item['value'], item['size'])
        if any(item['address'] + i in memory for i in range(item['size'])):
            raise ValueError('overlapping initial operand observations')
        memory.update({item['address'] + i: b for i, b in enumerate(raw)})
    initial = dict(memory)
    ds, ss = entry['ds'] * 16, entry['ss'] * 16
    def far(off):
        value = memory_value(initial, ds + off, 4)
        return (value >> 16) * 16 + (value & 65535)
    seed = far(0xDE84)
    regions = {r['name']: r for r in caller['regions']}
    if set(regions) != set(POOL_SPECS):
        raise ValueError('declared pool census differs')
    for name, (pointer, count, stride, origin) in POOL_SPECS.items():
        if regions[name] != dict(name=name, base=far(pointer), count=count, stride=stride, origin=origin):
            raise ValueError('semantic pool binding differs')
    scratch_lo, scratch_hi = ss + entry['sp'] - 1024, ss + entry['sp'] + 6
    def location(item):
        address, size, field = item['address'], item['size'], item['field']
        if not 0 <= address < address + size <= 0x110000 \
                or max(address, scratch_lo) < min(address + size, scratch_hi):
            raise ValueError('operand escapes semantic/frame bounds')
        if field.startswith('seed+'):
            offset = int(field[5:])
            if offset < 0 or offset + size > 2 or address != seed + offset:
                raise ValueError('seed operand binding differs')
        elif field.startswith('DS:'):
            offset = int(field[3:], 16)
            if address != ds + offset or not any(lo <= offset and offset + size <= lo + n for lo, n in DS_RANGES):
                raise ValueError('undeclared DS numeric operand')
        elif field.startswith('frame:'):
            offset = int(field[6:], 16)
            if address != ss + offset or not scratch_hi <= address < address + size <= ss + entry['bp'] + 8:
                raise ValueError('parent frame input bounds differ')
        else:
            match = re.fullmatch(r'([a-z0-9_]+)\[(\d+)\]\+(\d+)', field)
            if not match or match[1] not in regions:
                raise ValueError('unclassified semantic operand')
            r = regions[match[1]]
            entity, offset = int(match[2]), int(match[3])
            if not r['origin'] <= entity < r['origin'] + r['count'] or not 0 <= offset < offset + size <= r['stride'] \
                    or address != r['base'] + (entity - r['origin']) * r['stride'] + offset:
                raise ValueError('semantic record/address binding differs')
    for item in caller['initial']:
        location(item)
    if memory_value(initial, seed, 2) != boundary['seed']:
        raise ValueError('initial live seed differs')
    if [memory_value(initial, ds + 0xD086 + i, 1) for i in range(2)] != frame['scores'] \
            or memory_value(initial, ds + 0xD075, 1) != frame['performance_flag'] \
            or memory_value(initial, ds + 0xD6DD, 1) != frame['stat_flag']:
        raise ValueError('caller score/performance inputs differ')

    written, required, touched, snapshots, seed_writes = set(), set(), set(), {}, []
    last_cursor = caller['draw_start']
    for op in caller['ops']:
        location(op)
        raw = value_bytes(op['value'], op['size'])
        if not re.fullmatch(r'[0-9A-F]{4}:[0-9A-F]{4}', op['site']) \
                or not last_cursor <= op['draw'] <= caller['draw_end']:
            raise ValueError('operand site/draw order differs')
        last_cursor = op['draw']
        if op['site'] == '1998:14AD' and op['draw'] not in snapshots:
            snapshots[op['draw']] = dict(memory)
        old = memory_value(memory, op['address'], op['size'])
        keys = set(range(op['address'], op['address'] + op['size']))
        touched |= keys
        if op['kind'] == 'read':
            if old != op['value']:
                raise ValueError('read differs from entry/observed write state')
            required |= keys - written
        elif op['kind'] == 'write':
            if old != op['before']:
                raise ValueError('write-before observation differs')
            if op['field'] == 'seed+0':
                seed_writes.append((op['draw'], op['before'], op['value']))
            memory.update({op['address'] + i: b for i, b in enumerate(raw)})
            written |= keys
        else:
            raise ValueError('unknown operand operation')
    if seed_writes != [(d['i'], d['seed_before'], d['seed_after']) for d in post] \
            or memory_value(memory, seed, 2) != post[-1]['seed_after']:
        raise ValueError('caller RNG writes differ from literal draw order')
    if touched != set(initial):
        raise ValueError('unused or missing initial operand coverage')
    if len(caller['final'])!=len(caller['initial']):
        raise ValueError('final observation census differs')
    for before,after in zip(caller['initial'],caller['final']):
        if {k:v for k,v in before.items() if k!='value'}!={k:v for k,v in after.items() if k!='value'} \
                or memory_value(memory,after['address'],after['size'])!=after['value']:
            raise ValueError('independent final memory observation differs')

    contexts, calls = record['condition']['contexts'], record['condition']['calls']
    if len(contexts) != 2 or [x['index'] for x in contexts] != [0, 1] \
            or [x['club'] for x in contexts] != [frame['club'], frame['opponent']]:
        raise ValueError('first post-match pair census differs')
    if [x['index'] for x in calls] != list(range(len(calls))):
        raise ValueError('condition call indices differ')
    owned, covered = [], []
    draw_map = {d['i']:d for d in post}
    for context in contexts:
        if context['kind'] != 'first_team' or not context['active'] or len(context['roster']) != 20 \
                or any(not 0 <= i < len(calls) for i in context['calls']):
            raise ValueError('caller roster/class differs')
        selected = [calls[i] for i in context['calls']]
        if [(c['slot'],c['input']['player']) for c in selected] != [(i+1,p) for i,p in enumerate(context['roster']) if p] \
                or any(c['context'] != context['index'] for c in selected):
            raise ValueError('missing or foreign roster slot call')
        if context['arguments'] != [255,255,context['club']] or context['return_instruction'] != '1998:1B96' \
                or context['returned']['sp'] != (context['entry']['sp'] + 10) & 65535 \
                or any(context['returned'][k] != context['entry'][k] for k in ('ds','ss','bp')):
            raise ValueError('first-pair caller arguments/ABI differ')
        if not caller['draw_start'] <= context['draw_start'] <= context['draw_end'] <= caller['draw_end']:
            raise ValueError('nested caller draw scope differs')
        owned += context['calls']
    if owned != list(range(len(calls))) or len(snapshots) != len(calls):
        raise ValueError('incomplete condition-entry coverage')
    for call in calls:
        prior.validate_input(call['input'])
        if call['return_site'] not in ('1998:193A','1998:19FB') \
                or call['returned']['sp'] != (call['entry']['sp']+6) & 65535 \
                or any(call['returned'][k] != call['entry'][k] for k in ('cs','ds','ss','bp')):
            raise ValueError('condition ABI differs')
        if call['input']['flag'] != int(call['slot'] <= 11 or call['status_byte'] & 4 != 0):
            raise ValueError('condition caller flag differs')
        begin,end = call['draw_start'],call['draw_end']
        if not contexts[call['context']]['draw_start'] <= begin < end <= contexts[call['context']]['draw_end']:
            raise ValueError('condition span outside parent')
        observed = [{k:draw_map[i][k] for k in ('n','seed_before','seed_after','value')} for i in range(begin,end)]
        if observed != call['draws'] or call['input']['seed'] != observed[0]['seed_before']:
            raise ValueError('condition literal draw span differs')
        covered += list(range(begin,end))
        before = snapshots[begin]
        pid = call['input']['player']
        p8,p15 = regions['player8']['base']+8*pid,regions['player15']['base']+15*pid
        for key,address,signed in [('club',p8,False),('age',p8+1,False),('age_reference',p8+2,False),
                                  ('base_condition',p15+7,True),('condition',p15+8,True)]:
            value=memory_value(before,address,1)
            if call['input'][key] != (prior.signed(value) if signed else value):
                raise ValueError('condition input differs from caller memory')
        if call['status_byte'] != memory_value(before,p15+11,1):
            raise ValueError('condition status differs from caller memory')
        staff = memory_value(before,regions['club']['base']+62*(call['input']['club']-1)+44,2)
        facility = memory_value(before,regions['staff']['base']+4*staff+2,1)
        if call['dependencies'] != dict(staff_id=staff,facility=facility) or call['input']['facility'] != facility:
            raise ValueError('condition staff dependency differs from caller memory')
        state={k:call['input'][k]&255 for k in ('base_condition','condition','recovery')}
        state['seed']=call['input']['seed']
        for write in call['writes']:
            key=write['field']
            if key not in state or write['before'] != state[key] or write['size'] != (2 if key=='seed' else 1):
                raise ValueError('condition write chain differs')
            value_bytes(write['after'],write['size']);state[key]=write['after']
        if {k:v if k=='seed' else prior.signed(v) for k,v in state.items()} != call['output'] \
                or state['seed'] != observed[-1]['seed_after']:
            raise ValueError('condition output differs')
        stores={'1998:14EE','1998:151C','1998:1527','1998:1546','1998:1449','1998:147E','1998:1489'}
        observed_writes=[]
        for op in caller['ops']:
            if op['kind']!='write':continue
            if op['field']=='seed+0' and begin<=op['draw']<end:
                key='seed'
            elif op['site'] in stores and begin<=op['draw']<=end \
                    and op['address'] in (p15+7,p15+8,p15+14):
                key={p15+7:'base_condition',p15+8:'condition',p15+14:'recovery'}[op['address']]
            else:continue
            observed_writes.append(dict(field=key,size=op['size'],before=op['before'],after=op['value']))
        if observed_writes!=call['writes']:
            raise ValueError('condition writes differ from enclosing operand audit')
    if covered != sorted(set(covered)):
        raise ValueError('overlapping condition draws')
    return dict(fields=len(caller['initial']),reads=caller['census']['reads'],writes=caller['census']['writes'],
        read_before_write_bytes=len(required),context_bytes=len(initial)-len(required),caller_draws=len(post),condition_calls=len(calls),condition_draws=len(covered))

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
    return dict(ticks=progress['ticks'],draws=progress['draws'],actions=progress['actions'],**numeric_caller(record))

def check_prefix(directory):
    start=json.loads((directory/'start.json').read_text());authenticate_producer(start)
    if start['source']!=reference()[0] or start['interventions']:raise ValueError('wrong prefix start')
    previous=(0,0,0);count=0
    for path in sorted(directory.glob('checkpoint-r*.json')):
        receipt=json.loads(path.read_text());validate_checkpoint(receipt)
        current=tuple(receipt['progress'][k]for k in ('ticks','draws','actions'))
        if any(a>b for a,b in zip(previous,current)):raise ValueError('nonmonotonic source recovery prefix')
        previous=current;count+=1
    if not count:raise ValueError('no authenticated prefix checkpoints')
    return dict(status='prefix-only',checkpoints=count,ticks=previous[0],draws=previous[1],actions=previous[2])

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
    parser=argparse.ArgumentParser(description=__doc__);parser.add_argument('--run',type=Path);parser.add_argument('--resume',type=Path);parser.add_argument('--stop-ticks',type=int,default=0);parser.add_argument('--checkpoint-seconds',type=float,default=300);parser.add_argument('--check',action='store_true');parser.add_argument('--check-prefix',type=Path)
    args=parser.parse_args()
    if args.check:print(json.dumps(check(),sort_keys=True))
    elif args.check_prefix:print(json.dumps(check_prefix(args.check_prefix),sort_keys=True))
    elif args.run:run(args.run,args.resume,args.stop_ticks,args.checkpoint_seconds)
    else:parser.error('choose --run or --check')
if __name__=='__main__':main()
