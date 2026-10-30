#!/usr/bin/env python3
"""T21: observe the named quick52B6 reset, without Python effects formulas."""
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

ROOT=contests.ROOT
RUNS,FIXTURES=ROOT/'runs/T21',ROOT/'traces/T21'


def snapshot(g):
    strategy=post_score.snapshot(g)
    scenes=[]
    for i in range(1,23):
        a=g.DS*16+0xCCEF+25*i
        scenes.append({'index':i,'player':g.word_at(a+14),'slot':g.mem(a+7,1)[0],
                       'word0':g.word_at(a),'word8':g.word_at(a+8),'word10':g.word_at(a+10),'motion':g.mem(a+19,1)[0]})
    ids=sorted({p['id'] for p in strategy['players']}|{s['player'] for s in scenes})
    players=[]
    for i in ids:
        a=g.far(0xD7BE)+15*i
        players.append({'id':i,'byte6':g.mem(a+6,1)[0],'byte8':g.mem(a+8,1)[0],'flags11':g.mem(a+11,1)[0]})
    return {'strategy':strategy,'mode':g.rd(0xD074,1),'actor':g.rd(0xD09F,1),'secondary':g.rd(0xD0A0,1),
            'active':g.rd(0xD0B8,1),'zero':g.rd(0xD0B9,1),'alternate':g.rd(0xD1CA,1),
            'kind':g.rd(0xD0AC,1),'remaining':g.rd(0xD0AE),'side_offsets':[g.rd(0x0D56+i,1) for i in range(2)],
            'signs':[g.rd(0xA338+i,1) for i in range(2)],'scenes':scenes,'players':players,
            'cache':[[g.rd(0xD198+20*side+i,1) for i in range(20)] for side in range(2)]}


class Recorder:
    def __init__(self,week):
        self.week,self.legacy=week,post_score.Recorder(week)
        self.calls=[];self.pending=self.copy=self.motion=self.keeper=self.helper=None
        hooks={'0AB9:52B6':self.enter,'0AB9:537A':self.leave,'0AB9:52DC':self.copy_enter,'0AB9:52E0':self.copy_leave,
               '0AB9:5275':self.motion_enter,'0AB9:52AB':self.motion_leave,'0AB9:4F95':self.keeper_enter,'0AB9:5081':self.keeper_leave,
               '0AB9:A4F2':self.strategy_enter,'0AB9:A5BA':self.strategy_leave,
               '0AB9:1CA1':self.availability_enter,'0AB9:1CB7':self.availability_leave,
               '0AB9:67D0':self.byte6_enter,'0AB9:6845':self.byte6_leave}
        for address,fn in hooks.items():week.g.code_hook(address,fn)
    def enter(self,g):
        if not self.legacy.tail.active or g.stack_word(0)!=0xE003:return
        if self.pending is not None or g.reg('ds')!=g.DS:raise ValueError('unexpected reset nesting/DS')
        self.pending={'step':len(self.legacy.tail.calls)-1,'input':snapshot(g),'draw_start':self.week.draws,
                      'copies':[],'motions':[],'keeper':None,'strategy_input':None,'strategy_output':None,'helpers':[]}
    def index(self,g):return g.word_at(g.reg('ss')*16+((g.reg('bp')-2)&65535))
    def copy_enter(self,g):
        if self.pending is not None:
            i=self.index(g);a=0xCCEF+25*i
            self.copy={'index':i,'word0':g.rd(a),'before':g.rd(a+8)}
    def copy_leave(self,g):
        if self.copy is not None:
            self.copy['after']=g.rd(0xCCEF+25*self.copy['index']+8);self.pending['copies'].append(self.copy);self.copy=None
    def motion_enter(self,g):
        if self.pending is not None:
            i=self.index(g);self.motion={'index':i,'before':g.rd(0xCCEF+25*i+19,1)}
    def motion_leave(self,g):
        if self.motion is not None:
            self.motion['after']=g.rd(0xCCEF+25*self.motion['index']+19,1);self.pending['motions'].append(self.motion);self.motion=None
    def keeper_enter(self,g):
        if self.pending is not None:
            if self.keeper is not None:raise ValueError('nested keeper prelude')
            self.keeper={'input':snapshot(g),'draw_start':self.week.draws}
    def keeper_leave(self,g):
        if self.keeper is not None:
            self.keeper.update(output=snapshot(g),draw_end=self.week.draws);self.pending['keeper']=self.keeper;self.keeper=None
    def strategy_enter(self,g):
        if self.pending is not None:self.pending['strategy_input']=snapshot(g)
    def strategy_leave(self,g):
        if self.pending is not None:self.pending['strategy_output']=snapshot(g)
    def availability_enter(self,g):
        if self.pending is not None:
            if self.helper is not None:raise ValueError('nested reset helper')
            i=(g.stack_word(4)-0xCCEF)//25;id=g.word_at(g.DS*16+0xCCEF+25*i+14);a=g.far(0xD7BE)+15*id
            self.helper={'kind':'availability','scene':i,'player':id,'byte8':g.mem(a+8,1)[0],'flags11':g.mem(a+11,1)[0]}
    def availability_leave(self,g):
        if self.helper is not None and self.helper['kind']=='availability':
            self.helper['result']=g.reg('ax')&255;self.pending['helpers'].append(self.helper);self.helper=None
    def byte6_enter(self,g):
        if self.pending is not None:
            if self.helper is not None:raise ValueError('nested reset helper')
            i=(g.stack_word(4)-0xCCEF)//25;a=g.DS*16+0xCCEF+25*i;id=g.word_at(a+14);slot=g.mem(a+7,1)[0]
            side,norm=int(slot<12),slot-11 if slot>11 else slot
            self.player=g.far(0xD7BE)+15*id;self.cache=g.DS*16+0xD197+20*side+norm;delta=g.stack_word(10)
            self.helper={'kind':'byte6','scene':i,'player':id,'cache_side':side,'cache_slot':norm,
                         'input':{'old_byte6':g.mem(self.player+6,1)[0],'delta':delta-65536 if delta>=32768 else delta,
                                  'cache_flag':g.stack_word(8)&255,'cache_before':g.mem(self.cache,1)[0]}}
    def byte6_leave(self,g):
        if self.helper is not None and self.helper['kind']=='byte6':
            self.helper['output']={'byte6':g.mem(self.player+6,1)[0],'cache':g.mem(self.cache,1)[0]}
            self.pending['helpers'].append(self.helper);self.helper=None
    def leave(self,g):
        if self.pending is not None:
            if any(x is not None for x in (self.copy,self.motion,self.keeper,self.helper)):raise ValueError('incomplete reset boundary')
            self.pending.update(output=snapshot(g),draw_end=self.week.draws);self.calls.append(self.pending);self.pending=None


def validate_state(s):
    raw.keys(s,'strategy mode actor secondary active zero alternate kind remaining side_offsets signs scenes players cache')
    post_score.validate_state(s['strategy']);step_tail.numeric(s)
    for k in ('mode','actor','secondary','active','zero','alternate','kind'):raw.integer(s[k],0,255)
    if s['mode']==0 or not 1<=s['actor']<=22 or s['side_offsets']!=[11,0]:raise ValueError('unsupported quick actor/physical offsets')
    raw.integer(s['remaining']);raw.vector(s['side_offsets'],2);raw.vector(s['signs'],2)
    if [r['index'] for r in s['scenes']]!=list(range(1,23)):raise ValueError('complete ordered scenes required')
    for r in s['scenes']:
        raw.keys(r,'index player slot word0 word8 word10 motion');raw.integer(r['player'],0,3920);raw.integer(r['slot'],1,22)
        for k in ('word0','word8','word10'):raw.integer(r[k])
        raw.integer(r['motion'],0,255)
    ids=sorted({p['id'] for p in s['strategy']['players']}|{r['player'] for r in s['scenes']})
    if [p['id'] for p in s['players']]!=ids:raise ValueError('incomplete canonical reset players')
    for p in s['players']:
        raw.keys(p,'id byte6 byte8 flags11');raw.integer(p['id'],0,3920)
        for k in ('byte6','byte8','flags11'):raw.integer(p[k],0,255)
    if len(s['cache'])!=2:raise ValueError('two cache rows required')
    for r in s['cache']:raw.vector(r,20)


def sources():
    index=json.loads((ROOT/'traces/T20/index.json').read_text());prefixes=list(post_score.sources())
    for m in index['records']:
        p,f=ROOT/m['record'],ROOT/'traces/T20'/m['cases']
        if contests.sha(p)!=m['record_sha256'] or contests.sha(f)!=m['cases_sha256']:raise ValueError('retained strategy digest differs')
        rec=json.loads(p.read_text());meta,prior,old=next(x for x in prefixes if x[0]['record']==rec['actions']['source']['t16_record'])
        yield m,rec,contests.events(f),meta,prior,old


def cases_for(calls,strategy_cases,ledger,prefixes,source,trace,meta):
    try:return _cases_for(calls,strategy_cases,ledger,prefixes,source,trace,meta)
    except (KeyError,IndexError,TypeError,AttributeError,StopIteration) as exc:raise ValueError(f'incomplete reset/source fields: {exc}') from exc
def _cases_for(calls,strategy_cases,ledger,prefixes,source,trace,meta):
    post_score.validate_ledger(ledger,prefixes,trace)
    if [c['step'] for c in calls]!=[c['step'] for c in strategy_cases]:raise ValueError('incomplete/reordered resets')
    draws=contests.draw_stream(trace);rows=[]
    for c,old in zip(calls,strategy_cases):
        raw.keys(c,'step input draw_start copies motions keeper strategy_input strategy_output helpers output draw_end');step_tail.numeric(c)
        validate_state(c['input']);validate_state(c['output']);p=prefixes[c['step']];start=next(r for r in ledger[c['step']]['phases'] if r['routine']=='0AB9:52B6')
        if c['draw_start']!=start['draw_start'] or c['draw_end']!=start['draw_end'] or c['input']['strategy']['seed']!=start['seed_before'] or c['output']['strategy']['seed']!=start['seed_after']:raise ValueError('reset span/seed differs')
        s=c['input'];out=p['prefix']['output']
        if (s['strategy']['seed']!=out['seed'] or s['strategy']['scores']!=out['score_bytes'] or s['actor']!=out['actor']
                or s['remaining']!=p['prefix']['input']['remaining']
                or [{k:r[k] for k in ('index','player','word0')} for r in s['scenes']]!=out['scenes']):raise ValueError('reset shared prefix inputs differ')
        before={v['id']:v for v in s['players']}
        if any(before[x['id']]['byte8']!=x['byte8'] or before[x['id']]['flags11']!=x['byte11'] for x in out['players']):raise ValueError('reset prefix player inputs differ')
        if [r['index'] for r in c['copies']]!=list(range(1,23)) or [r['index'] for r in c['motions']]!=list(range(1,23)):raise ValueError('missing/reordered copy/motion visits')
        for r in c['copies']:
            raw.keys(r,'index word0 before after')
            for k in ('word0','before','after'):raw.integer(r[k])
            b=s['scenes'][r['index']-1]
            if r['word0']!=b['word0'] or r['before']!=b['word8']:raise ValueError('copy input differs')
        for r in c['motions']:raw.keys(r,'index before after');raw.integer(r['before'],0,255);raw.integer(r['after'],0,255)
        k=c['keeper'];raw.keys(k,'input draw_start output draw_end');validate_state(k['input']);validate_state(k['output'])
        if not c['draw_start']<=k['draw_start']<=k['draw_end']<=c['draw_end']:raise ValueError('keeper span outside reset')
        validate_state(c['strategy_input']);validate_state(c['strategy_output'])
        if (not placement.same_json(c['strategy_input']['strategy'],old['input']) or not placement.same_json(c['strategy_output']['strategy'],old['output'])
                or k['output']!=c['strategy_input']):raise ValueError('keeper/strategy boundary differs from original')
        values={p['id']:p['byte6'] for p in s['players']};cache=copy.deepcopy(s['cache'])
        for h in c['helpers']:
            raw.integer(h['scene'],1,22);raw.integer(h['player'],0,3920)
            if h['kind']=='availability':
                raw.keys(h,'kind scene player byte8 flags11 result')
                for f in ('byte8','flags11','result'):raw.integer(h[f],0,255)
            elif h['kind']=='byte6':
                raw.keys(h,'kind scene player cache_side cache_slot input output');raw.integer(h['cache_side'],0,1);raw.integer(h['cache_slot'],1,20)
                raw.keys(h['input'],'old_byte6 delta cache_flag cache_before');raw.keys(h['output'],'byte6 cache');raw.integer(h['input']['delta'],-32768,32767)
                for f in ('old_byte6','cache_flag','cache_before'):raw.integer(h['input'][f],0,255)
                for v in h['output'].values():raw.integer(v,0,255)
                side,slot=h['cache_side'],h['cache_slot']-1
                if h['input']['old_byte6']!=values[h['player']] or h['input']['cache_before']!=cache[side][slot]:raise ValueError('shared helper continuation differs')
                values[h['player']]=h['output']['byte6'];cache[side][slot]=h['output']['cache']
            else:raise ValueError('unknown reset helper')
        if values!={p['id']:p['byte6'] for p in c['output']['players']} or cache!=c['output']['cache']:raise ValueError('missing helper effects')
        rows.append({'schema':'quick-reset-case/1','week':source['t04_record'],**c,'draws':draws[c['draw_start']:c['draw_end']],
                     'post_score':old,'source':{'t20_record':meta['record'],'t20_record_sha256':meta['record_sha256'],'t20_cases':meta['cases'],'t20_cases_sha256':meta['cases_sha256']}})
    return rows


def selected_runs():
    result={}
    for p in sorted(RUNS.glob('T21-r*.json')):
        r=json.loads(p.read_text())
        if r['status']=='completed':
            key=r['actions']['source']['t20_record']
            if key in result:raise ValueError('duplicate completed reset week')
            result[key]=p,r
    return result
def build_index():
    old=list(sources());chosen=selected_runs();records=[]
    if set(chosen)!={m['record'] for m,*_ in old}:raise ValueError('missing/extra completed reset week')
    for meta,prior,strategy_cases,_,base,prefixes in old:
        path,rec=chosen[meta['record']];source=base['actions']['source'];trace=contests.events(ROOT/source['trace'])
        if rec['start_state']!=prior['start_state'] or rec['actions']['game_files']!=prior['actions']['game_files']:raise ValueError('original state/game identity differs')
        values=contests.outputs(rec);ledger=contests.outputs(prior)['ledger'];rows=cases_for(values['calls'],strategy_cases,ledger,prefixes,source,trace,meta)
        obs={o['field']:o['value'] for o in rec['observations']};fixture=ROOT/obs['fixture path']
        if fixture.parent!=FIXTURES or contests.sha(fixture)!=obs['fixture sha256'] or not placement.same_json(contests.events(fixture),rows):raise ValueError('reset fixture differs')
        records.append({'record':match.rel(path),'record_sha256':contests.sha(path),'cases':fixture.name,'cases_sha256':contests.sha(fixture),'week':source['t04_record'],
                        'calls':len(rows),'draws':sum(c['draw_end']-c['draw_start'] for c in rows),'copies':sum(len(c['copies']) for c in rows),
                        'motions':sum(len(c['motions']) for c in rows),'helpers':sum(len(c['helpers']) for c in rows),'producer_commit':rec['code_commit']})
    return {'schema':'quick-reset-corpus/1','records':records,**{k:sum(r[k] for r in records) for k in ('calls','draws','copies','motions','helpers')},
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
                    or not placement.same_json(recorder.legacy.ledger,contests.outputs(prior)['ledger']) or not placement.same_json(recorder.legacy.tail.calls,contests.outputs(base)['calls'])):raise ValueError('incomplete reset or retained T16/T20 differs')
            trace=contests.events(ROOT/source['trace'])
            if week.events!=trace[1:-1]:raise ValueError('new original week differs from T08')
            ok,lines=match.compare(week.events,source['start_state_sha256'],ROOT/source['t04_record_path'])
            if not ok:raise ValueError('ordered DOSBox-X comparison failed')
            rows=cases_for(recorder.calls,strategy_cases,recorder.legacy.ledger,prefixes,source,trace,meta)
        except (Exception,KeyboardInterrupt) as exc:status=f'aborted: {type(exc).__name__}: {exc}'
        n=max(match.next_number(RUNS,'T21-r*.json'),match.next_number(FIXTURES,'T21-r*.jsonl'));rid=f'T21-r{n:04d}';fixture=FIXTURES/(rid+'.jsonl');placement.write_lines(fixture,rows)
        rec=copy.deepcopy(prior);rec.update(run_id=rid,experiment='T21',arm='quick-reset',rep=n,code_commit=commit,machine=cycle.machine_id(),started=started,ended=match.utc(),status=status,
            actions={'script':'runtime/emul/quick_reset.py','source':{'t20_record':meta['record'],'t20_record_sha256':meta['record_sha256']},'game_files':{name:hashlib.sha256(b).hexdigest() for name,b in week.files_at_start.items()}},
            outputs=[{'name':'calls','value':recorder.calls}],observations=[{'step':0,'source':'file','field':'fixture path','value':match.rel(fixture)},
                {'step':0,'source':'file','field':'fixture sha256','value':contests.sha(fixture)},{'step':1,'source':'log','field':'ordered DOSBox-X comparison','value':'\n'.join(lines)}])
        rec['runtime']={'harness':f'runtime/emul/quick_reset.py@{commit}','unicorn':unicorn.__version__,'python':platform.python_version(),'dos_clock':week.g.clock,
                        'settings':{k:getattr(guest,k) for k in ('INSTR_PER_S','KEY_HOLD','PIT_HZ','SLICE_MAX')}}
        rec['interventions']=[{'level':'I3','what':'guest.py services and read-only quick-reset/helper hooks'}];match.write_record(RUNS/(rid+'.json'),rec)
        print(f'{rid}: {status}; {len(rows)} reset cases',flush=True)
        if status!='completed':raise SystemExit(1)
    (FIXTURES/'index.json').write_text(json.dumps(build_index(),indent=2)+'\n')
def main(argv=None):
    ap=argparse.ArgumentParser(description=__doc__);m=ap.add_mutually_exclusive_group(required=True);m.add_argument('--run',action='store_true');m.add_argument('--check',action='store_true');args=ap.parse_args(argv)
    if args.run:run();return 0
    try:
        index=build_index()
        if tuple(index[k] for k in ('weeks','calls','draws','copies','motions'))!=(6,17,12,374,374):raise ValueError('incomplete original reset coverage')
        if not placement.same_json(index,json.loads((FIXTURES/'index.json').read_text())):raise ValueError('reset index differs')
    except (ValueError,OSError,KeyError,TypeError,StopIteration) as exc:print(f'quick-reset check: FAIL: {exc}');return 1
    print(f'quick-reset check: ok (17 calls, 12 draws, 374 copies/motions, {index["helpers"]} helpers)');return 0
if __name__=='__main__':raise SystemExit(main())
