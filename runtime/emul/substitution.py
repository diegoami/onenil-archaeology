#!/usr/bin/env python3
"""T22: observe 6B2F dispatcher/helper/outbound boundaries; no effects model."""
import argparse
import copy
import hashlib
import json
import platform

import contests
import extra_event as raw
import match
import placement
import post_score
import step_tail
from quick_reset import sources

ROOT=contests.ROOT
RUNS,FIXTURES=ROOT/'runs/T22',ROOT/'traces/T22'
KINDS=('managed','keeper','capacity','prompt','editor','ai')


def snapshot(g):
    clubs=[]
    for side in range(2):
        identifier=g.rd(0xD6E4+2*side);base=g.far(0xD7C2)+(identifier-1)*62
        clubs.append({'id':identifier,'roster':[g.word_at(base+2*i) for i in range(20)]})
    scenes=[{'index':i,'slot':g.rd(0xCCEF+25*i+7,1),'player':g.rd(0xCCEF+25*i+14)} for i in range(1,23)]
    players=[]
    for identifier in sorted({v for c in clubs for v in c['roster']}|{s['player'] for s in scenes}):
        base=g.far(0xD7BE)+15*identifier
        players.append({'id':identifier,'byte8':g.mem(base+8,1)[0],'flags11':g.mem(base+11,1)[0]})
    return {'seed':g.word_at(g.far(0xDE84)),'managed_clubs':[g.rd(0xDCBA+i,1) for i in range(2)],
            'clubs':clubs,'scenes':scenes,'players':players,'side_offsets':[g.rd(0xD56+i,1) for i in range(2)],
            'remaining':g.rd(0xD0AE),'added':g.rd(0xD0B4),'allowance':g.rd(0xD6DD,1),
            'sub_flags':[g.rd(0xD6DE+i,1) for i in range(2)],'reserves':[g.rd(0xD6E0+i,1) for i in range(2)],
            'pending':g.rd(0xD6E2,1),'control':g.rd(0xD0BA,1),'key':g.rd(0xDE8A,1),
            'event_totals':[[g.rd(0xD148+40*side+2*i) for i in range(20)] for side in range(2)]}


class Recorder:
    def __init__(self,week):
        self.week,self.legacy=week,post_score.Recorder(week)
        self.calls=[];self.pending=self.event=None
        hooks={'0AB9:6B2F':self.enter,'0AB9:6CCC':self.leave}
        for begin,end,kind in ((0x6B48,0x6B4D,'managed'),(0x6B68,0x6B6D,'keeper'),
                               (0x6B8C,0x6B91,'capacity'),(0x6B99,0x6B9E,'capacity'),(0x6BD5,0x6BDA,'capacity'),
                               (0x6BB4,0x6BB7,'prompt'),(0x6BC6,0x6BC9,'editor'),(0x6CA5,0x6CA8,'ai')):
            hooks[f'0AB9:{begin:04X}']=lambda g,k=kind,b=begin:self.start(g,k,b)
            hooks[f'0AB9:{end:04X}']=self.end
        for address,fn in hooks.items():week.g.code_hook(address,fn)
    def enter(self,g):
        if not self.legacy.tail.active or g.stack_word(0)!=0xDFF5:return
        if self.pending is not None or g.reg('ds')!=g.DS:raise ValueError('unexpected substitution nesting/DS')
        self.pending={'step':len(self.legacy.tail.calls)-1,'input':snapshot(g),'draw_start':self.week.draws,'events':[]}
    def side(self,g):return g.mem(g.reg('ss')*16+((g.reg('bp')-1)&65535),1)[0]
    def start(self,g,kind,site):
        if self.pending is None:return
        if self.event is not None:raise ValueError('nested outbound/helper boundary')
        side=self.side(g);s=snapshot(g)
        e={'kind':kind,'site':f'0AB9:{site:04X}','side':side}
        if kind=='managed':e.update(argument=g.stack_word(0),managed_clubs=s['managed_clubs'])
        elif kind=='keeper':
            identifier=g.stack_word(0);p=next(p for p in s['players'] if p['id']==identifier)
            e.update(argument=identifier,byte8=p['byte8'],flags11=p['flags11'])
        elif kind=='capacity':
            e.update(argument=g.stack_word(0)&255,allowance=s['allowance'],sub_flag=s['sub_flags'][side],reserves=s['reserves'][side])
        else:
            n={'prompt':2,'editor':1,'ai':5}[kind]
            e.update(arguments=[g.stack_word(2*i) for i in range(n)],input=s,draw_start=self.week.draws)
            # Preserve decoded club identity, rather than a host/emulated pointer.
            if kind=='ai':e['arguments']=e['arguments'][:3]+[s['clubs'][side]['id']]
        self.event=e
    def end(self,g):
        if self.event is None:return
        e=self.event
        if e['kind'] in ('managed','keeper','capacity'):e['result']=g.reg('ax')&(65535 if e['kind']=='capacity' else 255)
        else:e.update(output=snapshot(g),draw_end=self.week.draws)
        self.pending['events'].append(e);self.event=None
    def leave(self,g):
        if self.pending is None:return
        if self.event is not None:raise ValueError('incomplete substitution child')
        self.pending.update(output=snapshot(g),draw_end=self.week.draws);self.calls.append(self.pending);self.pending=None


def validate_state(s):
    raw.keys(s,'seed managed_clubs clubs scenes players side_offsets remaining added allowance sub_flags reserves pending control key event_totals')
    step_tail.numeric(s)
    for k in ('seed','remaining','added'):raw.integer(s[k])
    for k in ('allowance','pending','control','key'):raw.integer(s[k],0,255)
    for k in ('managed_clubs','side_offsets','sub_flags','reserves'):raw.vector(s[k],2)
    if sorted(s['side_offsets'])!=[0,11]:raise ValueError('two disjoint physical sides required')
    if len(s['clubs'])!=2:raise ValueError('two clubs required')
    aliases={}
    for c in s['clubs']:
        raw.keys(c,'id roster');raw.integer(c['id'],1,176);raw.vector(c['roster'],20,3920)
        if c['id'] in aliases and aliases[c['id']]!=c:raise ValueError('conflicting club alias')
        aliases[c['id']]=c
    if [r['index'] for r in s['scenes']]!=list(range(1,23)):raise ValueError('complete ordered scenes required')
    for r in s['scenes']:
        raw.keys(r,'index slot player');raw.integer(r['slot'],1,22);raw.integer(r['player'],0,3920)
    ids=sorted({v for c in s['clubs'] for v in c['roster']}|{r['player'] for r in s['scenes']})
    if [p['id'] for p in s['players']]!=ids:raise ValueError('incomplete canonical players')
    for p in s['players']:
        raw.keys(p,'id byte8 flags11');raw.integer(p['id'],0,3920)
        for k in ('byte8','flags11'):raw.integer(p[k],0,255)
    if len(s['event_totals'])!=2:raise ValueError('two total rows required')
    for r in s['event_totals']:raw.vector(r,20,65535)


def cases_for(calls,ledger,prefixes,source,trace,meta):
    try:return _cases_for(calls,ledger,prefixes,source,trace,meta)
    except (KeyError,IndexError,TypeError,AttributeError,StopIteration) as exc:raise ValueError(f'incomplete substitution fields: {exc}') from exc

def _cases_for(calls,ledger,prefixes,source,trace,meta):
    post_score.validate_ledger(ledger,prefixes,trace)
    expected=[r['step'] for r in ledger if any(p['routine']=='0AB9:6B2F' for p in r['phases'])]
    if [c['step'] for c in calls]!=expected:raise ValueError('missing/reordered substitution calls')
    draws=contests.draw_stream(trace);rows=[]
    sites={'managed':{'0AB9:6B48'},'keeper':{'0AB9:6B68'},'capacity':{'0AB9:6B8C','0AB9:6B99','0AB9:6BD5'},
           'prompt':{'0AB9:6BB4'},'editor':{'0AB9:6BC6'},'ai':{'0AB9:6CA5'}}
    for c in calls:
        raw.keys(c,'step input draw_start events output draw_end');step_tail.numeric(c)
        validate_state(c['input']);validate_state(c['output'])
        span=next(p for p in ledger[c['step']]['phases'] if p['routine']=='0AB9:6B2F')
        if (c['draw_start'],c['draw_end'],c['input']['seed'],c['output']['seed'])!=(span['draw_start'],span['draw_end'],span['seed_before'],span['seed_after']):raise ValueError('substitution span differs')
        state=copy.deepcopy(c['input']);managed=[];side=-1;pending=None;child_cursor=c['draw_start']
        for e in c['events']:
            kind=e['kind'];raw.integer(e['side'],0,1)
            if kind not in sites or e['site'] not in sites[kind]:raise ValueError('unknown helper/site')
            if kind=='managed':
                raw.keys(e,'kind site side argument managed_clubs result');raw.integer(e['argument']);raw.vector(e['managed_clubs'],2);raw.integer(e['result'],0,1)
                if pending=='keeper':raise ValueError('missing keeper observation')
                side=e['side'];managed.append(side)
                if e['argument']!=state['clubs'][side]['id'] or e['managed_clubs']!=state['managed_clubs']:raise ValueError('managed context differs')
                pending='keeper' if e['result'] else 'capacity'
            elif e['side']!=side:raise ValueError('reordered side child')
            elif kind=='keeper':
                raw.keys(e,'kind site side argument byte8 flags11 result');raw.integer(e['argument'],0,3920)
                for k in ('byte8','flags11','result'):raw.integer(e[k],0,255)
                identifier=state['scenes'][state['side_offsets'][side]]['player'];p=next(p for p in state['players'] if p['id']==identifier)
                if pending!='keeper' or (e['argument'],e['byte8'],e['flags11'])!=(identifier,p['byte8'],p['flags11']):raise ValueError('keeper context/order differs')
                pending=None
            elif kind=='capacity':
                raw.keys(e,'kind site side argument allowance sub_flag reserves result');raw.integer(e['result'])
                for k in ('argument','allowance','sub_flag','reserves'):raw.integer(e[k],0,255)
                if (e['argument'],e['allowance'],e['sub_flag'],e['reserves'])!=(side,state['allowance'],state['sub_flags'][side],state['reserves'][side]):raise ValueError('capacity context differs')
                if pending=='keeper':raise ValueError('capacity before keeper')
                pending=None
            else:
                raw.keys(e,'kind site side arguments input draw_start output draw_end')
                raw.vector(e['arguments'],{'prompt':2,'editor':1,'ai':4}[kind],65535)
                validate_state(e['input']);validate_state(e['output'])
                # Control is written around the prompt by the dispatcher itself.
                state['control']=e['input']['control']
                if state!=e['input'] or not child_cursor<=e['draw_start']<=e['draw_end']<=c['draw_end']:raise ValueError('outbound continuation differs')
                state=copy.deepcopy(e['output']);child_cursor=e['draw_end']
        if managed!=[0,1] or pending is not None:raise ValueError('incomplete/reordered side helpers')
        state['control']=c['output']['control']
        if state!=c['output']:raise ValueError('unobserved dispatcher mutation')
        rows.append({'schema':'substitution-case/1','week':source['t04_record'],**c,'draws':draws[c['draw_start']:c['draw_end']],
                     'source':{'t20_record':meta['record'],'t20_record_sha256':meta['record_sha256'],'t20_cases':meta['cases'],'t20_cases_sha256':meta['cases_sha256']}})
    return rows


def selected_runs():
    result={}
    for p in sorted(RUNS.glob('T22-r*.json')):
        r=json.loads(p.read_text())
        if r['status']=='completed':
            key=r['actions']['source']['t20_record']
            if key in result:raise ValueError('duplicate completed substitution week')
            result[key]=p,r
    return result
def build_index():
    old=list(sources());chosen=selected_runs();records=[]
    if set(chosen)!={m['record'] for m,*_ in old}:raise ValueError('missing/extra completed substitution week')
    for meta,prior,strategy_cases,_,base,prefixes in old:
        path,rec=chosen[meta['record']];source=base['actions']['source'];trace=contests.events(ROOT/source['trace'])
        if rec['start_state']!=prior['start_state'] or rec['actions']['game_files']!=prior['actions']['game_files']:raise ValueError('original state/game identity differs')
        values=contests.outputs(rec);ledger=contests.outputs(prior)['ledger'];rows=cases_for(values['calls'],ledger,prefixes,source,trace,meta)
        obs={o['field']:o['value'] for o in rec['observations']};fixture=ROOT/obs['fixture path']
        if fixture.parent!=FIXTURES or contests.sha(fixture)!=obs['fixture sha256'] or not placement.same_json(contests.events(fixture),rows):raise ValueError('substitution fixture differs')
        records.append({'record':match.rel(path),'record_sha256':contests.sha(path),'cases':fixture.name,'cases_sha256':contests.sha(fixture),'week':source['t04_record'],
                        'calls':len(rows),'draws':sum(c['draw_end']-c['draw_start'] for c in rows),
                        'events':{kind:sum(e['kind']==kind for c in rows for e in c['events']) for kind in KINDS},
                        'producer_commit':rec['code_commit']})
    return {'schema':'substitution-corpus/1','records':records,'calls':sum(r['calls'] for r in records),
            'draws':sum(r['draws'] for r in records),
            'events':{kind:sum(r['events'][kind] for r in records) for kind in KINDS},
            'weeks':len(records),'t20_index_sha256':contests.sha(ROOT/'traces/T20/index.json')}



def run():
    import cycle,guest,unicorn
    if match.git('status','--porcelain','--','runtime/emul'):raise SystemExit('commit observer before capture')
    commit=match.git('rev-parse','HEAD');have=selected_runs();RUNS.mkdir(parents=True,exist_ok=True);FIXTURES.mkdir(parents=True,exist_ok=True)
    for meta,prior,strategy_cases,_,base,prefixes in sources():
        if meta['record'] in have:print('already recorded '+meta['record'],flush=True);continue
        source=base['actions']['source'];path,data=match.find_state(source['start_state_sha256']);started=match.utc();week=match.Week(data);recorder=Recorder(week)
        rows,lines,status=[],[],'completed'
        try:
            week.play()
            if (week.g.unsupported or recorder.pending is not None or not placement.same_json(recorder.legacy.calls,contests.outputs(prior)['calls'])
                    or not placement.same_json(recorder.legacy.ledger,contests.outputs(prior)['ledger']) or not placement.same_json(recorder.legacy.tail.calls,contests.outputs(base)['calls'])):raise ValueError('incomplete substitution or retained T16/T20 differs')
            trace=contests.events(ROOT/source['trace'])
            if week.events!=trace[1:-1]:raise ValueError('new original week differs from T08')
            ok,lines=match.compare(week.events,source['start_state_sha256'],ROOT/source['t04_record_path'])
            if not ok:raise ValueError('ordered DOSBox-X comparison failed')
            rows=cases_for(recorder.calls,recorder.legacy.ledger,prefixes,source,trace,meta)
        except (Exception,KeyboardInterrupt) as exc:status=f'aborted: {type(exc).__name__}: {exc}'
        n=max(match.next_number(RUNS,'T22-r*.json'),match.next_number(FIXTURES,'T22-r*.jsonl'));rid=f'T22-r{n:04d}';fixture=FIXTURES/(rid+'.jsonl');placement.write_lines(fixture,rows)
        rec=copy.deepcopy(prior);rec.update(run_id=rid,experiment='T22',arm='substitution',rep=n,code_commit=commit,machine=cycle.machine_id(),started=started,ended=match.utc(),status=status,
            actions={'script':'runtime/emul/substitution.py','source':{'t20_record':meta['record'],'t20_record_sha256':meta['record_sha256']},'game_files':{name:hashlib.sha256(b).hexdigest() for name,b in week.files_at_start.items()}},
            outputs=[{'name':'calls','value':recorder.calls}],observations=[{'step':0,'source':'file','field':'fixture path','value':match.rel(fixture)},
                {'step':0,'source':'file','field':'fixture sha256','value':contests.sha(fixture)},{'step':1,'source':'log','field':'ordered DOSBox-X comparison','value':'\n'.join(lines)}])
        rec['runtime']={'harness':f'runtime/emul/substitution.py@{commit}','unicorn':unicorn.__version__,'python':platform.python_version(),'dos_clock':week.g.clock,
                        'settings':{k:getattr(guest,k) for k in ('INSTR_PER_S','KEY_HOLD','PIT_HZ','SLICE_MAX')}}
        rec['interventions']=[{'level':'I3','what':'guest.py services and read-only substitution/helper hooks'}];match.write_record(RUNS/(rid+'.json'),rec)
        print(f'{rid}: {status}; {len(rows)} substitution cases',flush=True)
        if status!='completed':raise SystemExit(1)
    (FIXTURES/'index.json').write_text(json.dumps(build_index(),indent=2)+'\n')
def main(argv=None):
    ap=argparse.ArgumentParser(description=__doc__);m=ap.add_mutually_exclusive_group(required=True);m.add_argument('--run',action='store_true');m.add_argument('--check',action='store_true');args=ap.parse_args(argv)
    if args.run:run();return 0
    try:
        index=build_index()
        if (index['weeks'],index['calls'],index['draws'])!=(6,541,0):raise ValueError('incomplete original substitution coverage')
        if not placement.same_json(index,json.loads((FIXTURES/'index.json').read_text())):raise ValueError('substitution index differs')
    except (ValueError,OSError,KeyError,TypeError,StopIteration) as exc:print(f'substitution check: FAIL: {exc}');return 1
    print(f'substitution check: ok ({index["calls"]} calls, {index["draws"]} draws; {index["events"]})');return 0
if __name__=='__main__':raise SystemExit(main())
