#!/usr/bin/env python3
"""T36: one named initial state and original DD02/clock/input observations;no effects model."""
import argparse
import copy
import hashlib
import json
import platform

import proximity_selectors as prior
import goal_effects
import event_effects
import extra_event
import quick_reset
import quick_step
from importlib.util import module_from_spec,spec_from_file_location

# Keep the observer distinct from tools/static/ratings.py in shared test processes.
_rating_spec=spec_from_file_location("t36_ratings_observer",prior.ROOT/"runtime/emul/ratings.py")
ratings=module_from_spec(_rating_spec)
_rating_spec.loader.exec_module(ratings)
import role_scoring
import step_tail

ROOT=prior.ROOT
raw,contests,match,placement=prior.raw,prior.contests,prior.match,prior.placement
RUNS,FIXTURES=ROOT/'runs/T36',ROOT/'traces/T36'
STATIC=('static/1-0-exe/code/seg_0AB9_13.asm','static/1-0-exe/code/seg_0AB9_21.asm',
        'static/1-0-exe/code/seg_0AB9_04.asm','static/1-0-exe/code/seg_1B55_08.asm')
NEUTRAL={'quick_mode':(0xD074,1),'mirror_mode':(0xD075,1),'auto_switch':(0xD1CC,1),
         'remaining':(0xD0AE,2),'active':(0xD0B8,1),'d0b9':(0xD0B9,1),'speaker_gate':(0xA2EC,1)}


def digest(value):return hashlib.sha256(json.dumps(value,sort_keys=True).encode()).hexdigest()
def neutral(g):
    return {**{k:g.rd(off,n) for k,(off,n) in NEUTRAL.items()},'speed':g.mem(g.far(0xD7D2)+2,1)[0]}
def validate_neutral(s):
    raw.keys(s,' '.join(NEUTRAL)+' speed')
    for k in s:raw.integer(s[k],0,65535 if k=='remaining' else 255)
def initial(week):
    g=week.g;positions=prior.prior.snapshot(g)
    criteria=sorted({6,14,*[g.rd(0x9F6+i,1) for i in range(6)]})
    return {'positions':positions,'proximity':prior.snapshot(g),'goals':goal_effects.snapshot(g),
            'events':event_effects.snapshot(g),'reset':quick_reset.snapshot(g),'extra':extra_event.state(g),
            'ratings':{'tables':ratings.tables(g),'bonuses':[ratings.bonus_input(g,g.rd(off)) for off in (0xD6E4,0xD6E6)]},
            'skills':[{'criterion':c,'state':role_scoring.snapshot(g,c)} for c in criteria],
            'neutral':neutral(g),'clock':step_tail.clock_state(g),
            'config':[g.mem(g.far(0xD7D2)+i,1)[0] for i in range(3)],
            'selectors':[{'index':i,'value':g.rd(0xCF71+i,1)} for i in range(1,256)],
            'history':{'base_offset':g.rd(0xD7CE),'base_segment':g.rd(0xD7D0),
                       'club':g.rd(0xD6E6),'selector':g.mem(g.far(0xD7D2),1)[0],
                       'value':quick_step.state(week)['history_byte']},
            'scorer_slots':[g.rd(0xCE0+i,1) for i in range(30)],
            'minute_limits':[g.rd(0xD00+i,1) for i in range(2)],'threshold':g.rd(0xD0B,1)}

def validate_initial(s):
    raw.keys(s,'positions proximity goals events reset extra ratings skills neutral clock config selectors history scorer_slots minute_limits threshold')
    prior.prior.validate_state(s['positions']);prior.validate_state(s['proximity'])
    # These are existing decoded contracts,not independently recomputed effects.
    goal_effects.validate_state(s['goals'],{'actor':s['goals']['global_actor'],'side_flag':0})
    event_effects.validate_state(s['events']);quick_reset.validate_state(s['reset']);extra_event.validate_state(s['extra'])
    validate_neutral(s['neutral']);step_tail.validate_clock_state(s['clock'])
    raw.vector(s['config'],3,255);raw.vector(s['scorer_slots'],30,255);raw.vector(s['minute_limits'],2,255);raw.integer(s['threshold'],0,255)
    if s['config'][2]!=s['neutral']['speed'] or s['clock']['seed']!=s['extra']['seed']:raise ValueError('initial config/seed alias differs')
    if [r['index'] for r in s['selectors']]!=list(range(1,256)):raise ValueError('complete initial selector table required')
    for r in s['selectors']:raw.keys(r,'index value');raw.integer(r['value'],0,255)
    raw.keys(s['history'],'base_offset base_segment club selector value')
    for k,v in s['history'].items():raw.integer(v,0,255 if k in ('selector','value') else 65535)
    raw.keys(s['ratings'],'tables bonuses')
    tables=s['ratings']['tables'];raw.keys(tables,'halving_group halving_flags position_class drop_divisors home_divisors')
    for k,(n,lo,hi) in ratings.TABLE_SHAPES.items():
        raw.vector(tables[k],n,hi)
        if min(tables[k])<lo:raise ValueError('rating table minimum differs')
    if len(tables['halving_flags'])!=2:raise ValueError('halving table rows missing')
    for r in tables['halving_flags']:raw.vector(r,14,255)
    if [b['club'] for b in s['ratings']['bonuses']]!=list(reversed(s['goals']['clubs'])):raise ValueError('staff club order differs')
    for b in s['ratings']['bonuses']:
        raw.keys(b,'club staff_ids staff');raw.vector(b['staff_ids'],2,65535)
        if [r['id'] for r in b['staff']]!=sorted(set(b['staff_ids'])):raise ValueError('staff read set differs')
        for r in b['staff']:raw.keys(r,'id byte2');raw.integer(r['byte2'],0,255)
    criteria=sorted({6,14,*s['positions']['context']['criteria']})
    if [r['criterion'] for r in s['skills']]!=criteria:raise ValueError('initial skill criteria incomplete')
    for r in s['skills']:raw.keys(r,'criterion state');role_scoring.validate_state(r['state'],r['criterion'])
    if s['positions']['context']!=s['proximity']['context']:raise ValueError('initial cache projection differs')


class Recorder:
    def __init__(self,week):
        self.week,self.legacy=week,prior.Recorder(week)
        p=self.legacy
        while not hasattr(p,'tail'):p=p.legacy
        self.tail=p.tail;self.active=False;self.calls=[];self.admission=None;self.pending=None;self.polling=False
        for at,fn in {match.MATCH:self.start,match.MATCH_RETURN:self.stop,'0AB9:DD02':self.enter,
                      '0AB9:78B7':self.input_enter,'0AB9:791B':self.poll,'0AB9:79EB':self.input_leave,
                      '0AB9:E006':self.leave,'0AB9:7C92':self.clock_leave}.items():week.g.code_hook(at,fn)
    def start(self,g):self.active=True
    def stop(self,g):
        if self.pending is not None:raise ValueError('match returned before caller clock')
        self.active=False
    def enter(self,g):
        if not self.active:return
        if self.pending is not None:raise ValueError('overlapping complete steps')
        if self.admission is None:self.admission=initial(self.week)
        self.pending={'step':len(self.calls),'input':quick_step.state(self.week),'entry_clock':step_tail.clock_state(g),'draw_start':self.week.draws}
    def input_enter(self,g):
        if self.pending is None:return
        if 'neutral' in self.pending:raise ValueError('multiple input calls per DD02')
        self.pending['neutral']={'input':neutral(g),'draw_start':self.week.draws};self.polling=True
    def poll(self,g):
        if self.polling:
            n=self.pending['neutral']
            if 'poll_al' in n:raise ValueError('repeated neutral poll')
            n['poll_al']=g.reg('ax')&255
    def input_leave(self,g):
        if self.polling:
            self.pending['neutral'].update(output=neutral(g),draw_end=self.week.draws);self.polling=False
    def leave(self,g):
        if self.pending is not None:
            if self.polling:raise ValueError('unfinished input call')
            self.pending.update(output=quick_step.state(self.week),draw_end=self.week.draws)
    def clock_leave(self,g):
        if self.pending is not None:
            self.pending['clock']=copy.deepcopy(self.tail.calls[-1]['clock']);self.calls.append(self.pending);self.pending=None


def source_chain(base):
    while True:
        yield base
        src=base['actions']['source'];keys=[k for k in src if k.endswith('_record')]
        if not keys or keys==['t04_record']:return
        if len(keys)!=1:raise ValueError('ambiguous retained source chain')
        path=ROOT/src[keys[0]]
        if contests.sha(path)!=src[keys[0]+'_sha256']:raise ValueError('retained source digest differs')
        base=json.loads(path.read_text())

def retained_capture(recorder,base):
    rows=[];p=recorder.legacy
    for original in source_chain(base):
        if original['experiment']=='T16':p=p.tail
        want=contests.outputs(original)['calls']
        if not placement.same_json(p.calls,want):raise ValueError('retained '+original['experiment']+' calls differ')
        row={'run_id':original['run_id'],'calls_sha256':digest(p.calls)}
        if original['experiment']=='T20':
            if not placement.same_json(p.ledger,contests.outputs(original)['ledger']):raise ValueError('retained T20 ledger differs')
            row['ledger_sha256']=digest(p.ledger)
        rows.append(row)
        if original['experiment']=='T16':break
        if original['experiment']!='T20':p=p.legacy
    return rows

def validate_calls(calls,admission,t12,t16,draws):
    validate_initial(admission)
    if len(calls)!=95 or len(t12)!=95 or len(t16)!=95:raise ValueError('95 complete boundaries required')
    if admission['clock']['seed']!=calls[0]['input']['seed'] or admission['clock']['clock']!=calls[0]['input']['clock']:raise ValueError('admission/first entry differs')
    for i,(c,q,t) in enumerate(zip(calls,t12,t16)):
        raw.keys(c,'step input output entry_clock draw_start draw_end neutral clock');raw.integer(c['step'],0,94)
        if c['step']!=i:raise ValueError('step order differs')
        for k in ('input','output','draw_start','draw_end'):
            if not placement.same_json(c[k],q[k]):raise ValueError('T12 '+k+' projection differs')
        if not placement.same_json(c['clock'],t['clock']):raise ValueError('T16 caller clock projection differs')
        n=c['neutral'];raw.keys(n,'input output poll_al draw_start draw_end')
        validate_neutral(n['input']);validate_neutral(n['output']);raw.integer(n['poll_al'],0,255)
        # This task captures the real poll result,not a forced neutral assumption.
        if n['poll_al']!=0:raise ValueError('fixed reference reached a key-present path;requires scoped follow-up')
        if n['draw_start']!=c['draw_end'] or n['draw_end']!=c['draw_end']:raise ValueError('neutral draw boundary differs')
        for state in n.values():
            if isinstance(state,dict) and state['remaining']!=c['output']['clock']['remaining']:raise ValueError('input/return clock alias differs')
        if n['output']!=n['input']:raise ValueError('unexpected logical neutral change in fixed quick reference')
        if c['input']['seed']!=draws[c['draw_start']]['seed_before'] or c['output']['seed']!=draws[c['draw_end']-1]['seed_after']:raise ValueError('draw seed boundary differs')
        step_tail.validate_clock_state(c['entry_clock'])
        if c['entry_clock']['seed']!=q['input']['seed'] or c['entry_clock']['clock']!=q['input']['clock']:raise ValueError('entry clock projection differs')
        if i and calls[i-1]['clock']['draw_end']>c['draw_start']:raise ValueError('successive clock/entry draw order differs')
        # Halftime caller work may change clock/consume draws between DD02 calls.
        # Preserve both observed boundaries;do not assume or calculate an empty gap.


def sources():
    idx=prior.build_index()
    if not placement.same_json(idx,json.loads((prior.FIXTURES/'index.json').read_text())):raise ValueError('T35 manifest differs')
    for meta in idx['records']:yield meta,json.loads((ROOT/meta['record']).read_text())

def source_data(base):
    tail=list(source_chain(base))[-1]
    if tail['experiment']!='T16':raise ValueError('T16 chain missing')
    src=tail['actions']['source'];t12=next(json.loads(p.read_text()) for p in sorted((ROOT/'runs/T12').glob('*.json')) if json.loads(p.read_text())['actions']['source']==src)
    return tail,t12,src,contests.draw_stream(contests.events(ROOT/src['trace']))

def validate_record(r,base):
    tail,t12,src,draws=source_data(base);out=contests.outputs(r)
    raw.keys(out,'calls admission retained')
    validate_calls(out['calls'],out['admission'],contests.outputs(t12)['steps'],contests.outputs(tail)['calls'],draws)
    expected=[]
    for o in source_chain(base):
        row={'run_id':o['run_id'],'calls_sha256':digest(contests.outputs(o)['calls'])}
        if o['experiment']=='T20':row['ledger_sha256']=digest(contests.outputs(o)['ledger'])
        expected.append(row)
    if out['retained']!=expected:raise ValueError('retained observation receipts differ')
    return out

def selected_runs():
    result={}
    for p in sorted(RUNS.glob('T36-r*.json')):
        r=json.loads(p.read_text())
        if r['status']=='completed':
            key=r['actions']['source']['t35_record']
            if key in result:raise ValueError('duplicate completed continuity week')
            result[key]=(p,r)
    return result

def build_index():
    chosen=selected_runs();srcs=list(sources())
    if set(chosen)!={m['record'] for m,_ in srcs}:raise ValueError('missing/extra continuity week')
    records=[]
    for meta,base in srcs:
        path,r=chosen[meta['record']]
        expected={'t35_record':meta['record'],'t35_record_sha256':meta['record_sha256'],'t35_cases_sha256':meta['cases_sha256']}
        if r['actions']['source']!=expected or r['start_state']!=base['start_state'] or r['actions']['game_files']!=base['actions']['game_files']:raise ValueError('continuity provenance differs')
        out=validate_record(r,base);obs={o['field']:o['value'] for o in r['observations']};fixture=ROOT/obs['fixture path']
        rows=[{'schema':'match-admission/1','week':meta['week'],'state':out['admission']},*[{'schema':'match-boundary/1','week':meta['week'],**c} for c in out['calls']]]
        if fixture.parent!=FIXTURES or contests.sha(fixture)!=obs['fixture sha256'] or not placement.same_json(contests.events(fixture),rows):raise ValueError('continuity fixture differs')
        records.append({'record':match.rel(path),'record_sha256':contests.sha(path),'cases':fixture.name,'cases_sha256':contests.sha(fixture),'week':meta['week'],'admissions':1,'steps':len(out['calls']),'polls':len(out['calls']),'poll_al':sorted({c['neutral']['poll_al'] for c in out['calls']}),'producer_commit':r['code_commit']})
    return {'schema':'match-continuity-corpus/1','records':records,'t35_index_sha256':contests.sha(prior.FIXTURES/'index.json'),'static_sources':{p:contests.sha(ROOT/p) for p in STATIC}}

def run():
    import cycle,guest,unicorn
    if match.git('status','--porcelain','--','runtime/emul'):raise SystemExit('commit observer before capture')
    commit=match.git('rev-parse','HEAD');have=selected_runs();RUNS.mkdir(parents=True,exist_ok=True);FIXTURES.mkdir(parents=True,exist_ok=True)
    for meta,base in sources():
        if meta['record'] in have:print('already recorded '+meta['record'],flush=True);continue
        _,data=match.find_state(base['start_state']['sha256']);started=match.utc();week=match.Week(data);recorder=Recorder(week)
        lines=[];status='completed';retained=[]
        try:
            week.play(on_boundary=lambda w:print(f'original week:screen{w.screen_i},draws{w.draws}',flush=True))
            if week.g.unsupported or recorder.pending is not None:raise ValueError('incomplete continuity run')
            retained=retained_capture(recorder,base)
            tail,t12,src,draws=source_data(base)
            if week.events!=contests.events(ROOT/src['trace'])[1:-1]:raise ValueError('T08 event stream differs')
            ok,lines=match.compare(week.events,src['start_state_sha256'],ROOT/src['t04_record_path'])
            if not ok:raise ValueError('ordered DOSBox-X comparison failed')
            validate_calls(recorder.calls,recorder.admission,contests.outputs(t12)['steps'],contests.outputs(tail)['calls'],draws)
        except (Exception,KeyboardInterrupt) as exc:status=f'aborted: {type(exc).__name__}: {exc}'
        n=max(match.next_number(RUNS,'T36-r*.json'),match.next_number(FIXTURES,'T36-r*.jsonl'));rid=f'T36-r{n:04d}';fixture=FIXTURES/(rid+'.jsonl')
        rows=[{'schema':'match-admission/1','week':meta['week'],'state':recorder.admission},*[{'schema':'match-boundary/1','week':meta['week'],**c} for c in recorder.calls]]
        placement.write_lines(fixture,rows);rec=copy.deepcopy(base)
        rec.update(run_id=rid,experiment='T36',arm='match_continuity',rep=n,code_commit=commit,machine=cycle.machine_id(),started=started,ended=match.utc(),status=status,
                   actions={'script':'runtime/emul/match_continuity.py','source':{'t35_record':meta['record'],'t35_record_sha256':meta['record_sha256'],'t35_cases_sha256':meta['cases_sha256']},'game_files':{k:hashlib.sha256(v).hexdigest() for k,v in week.files_at_start.items()}},
                   outputs=[{'name':'calls','value':recorder.calls},{'name':'admission','value':recorder.admission},{'name':'retained','value':retained}],
                   observations=[{'step':0,'source':'file','field':'fixture path','value':match.rel(fixture)},{'step':0,'source':'file','field':'fixture sha256','value':contests.sha(fixture)},{'step':1,'source':'log','field':'ordered DOSBox-X comparison','value':'\n'.join(lines)}])
        rec['runtime']={'harness':f'runtime/emul/match_continuity.py@{commit}','unicorn':unicorn.__version__,'python':platform.python_version(),'dos_clock':week.g.clock,'settings':{k:getattr(guest,k) for k in ('INSTR_PER_S','KEY_HOLD','PIT_HZ','SLICE_MAX')}}
        rec['interventions']=[{'level':'I3','what':'guest.py services and read-only match_continuity hooks'}];match.write_record(RUNS/(rid+'.json'),rec)
        print(f'{rid}: {status};{len(recorder.calls)} complete boundaries',flush=True)
        if status!='completed':raise SystemExit(1)
    index=build_index();path=FIXTURES/'index.json'
    if path.exists():
        if not placement.same_json(index,json.loads(path.read_text())):raise ValueError('existing manifest differs')
    else:
        with path.open('x') as f:f.write(json.dumps(index,indent=2)+'\n')

def main(argv=None):
    ap=argparse.ArgumentParser(description=__doc__);g=ap.add_mutually_exclusive_group(required=True);g.add_argument('--run',action='store_true');g.add_argument('--check',action='store_true');args=ap.parse_args(argv)
    if args.run:run();return 0
    try:
        index=build_index()
        if not placement.same_json(index,json.loads((FIXTURES/'index.json').read_text())):raise ValueError('continuity manifest differs')
    except (ValueError,OSError,KeyError,IndexError,TypeError) as exc:print('match-continuity check: FAIL: '+str(exc));return 1
    print('match-continuity check:ok (one admission,95 DD02/clock/input boundaries)');return 0
if __name__=='__main__':raise SystemExit(main())
