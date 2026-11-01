#!/usr/bin/env python3
"""T35: original21D7 selector inputs, nested returns and actual stores, not an engine model."""
import argparse
import copy
import hashlib
import json
import platform

import scene_positions as prior

ROOT=prior.ROOT
RUNS,FIXTURES=ROOT/'runs/T35',ROOT/'traces/T35'
raw,contests,match,placement,arr,cache=prior.raw,prior.contests,prior.match,prior.placement,prior.arr,prior.cache
SITES={
 '0AB9:223D':('0AB9:2240','available'),
 '0AB9:1CAC':('0AB9:1CB1','player-available'),
 '0AB9:22AC':('0AB9:22AF','target-direction'),
 '0AB9:22BF':('0AB9:22C2','candidate-direction'),
 '0AB9:1EF5':('0AB9:1EF8','side'),
}
STORES={'0AB9:22A0':'near','0AB9:22EA':'ahead'}
STATIC=('static/1-0-exe/code/seg_0AB9_04.asm','static/1-0-exe/code/seg_0AB9_03.asm',
        'static/1-0-exe/code/seg_1B55_08.asm','static/1-0-exe/code/seg_24BC_01.asm')


def selectors(g):return {kind:[g.rd(off+i,1) for i in range(2)] for kind,off in (('near',0xD0A4),('ahead',0xD0A2))}
def validate_selectors(s):
    raw.keys(s,'near ahead')
    for v in s.values():raw.vector(v,2,255)
def snapshot(g):return {'context':cache.snapshot(g),'target':[g.rd(0xCF46+i,1) for i in range(2)],
                       'phase':g.rd(0xD0AC,1),'time':g.rd(0xD0AE),'signs':[g.rd(0xA338+i,1) for i in range(2)],'selectors':selectors(g)}
def validate_state(s):
    raw.keys(s,'context target phase time signs selectors');cache.validate_state(s['context'])
    raw.vector(s['target'],2,255);raw.integer(s['phase'],0,255);raw.integer(s['time']);raw.vector(s['signs'],2,255);validate_selectors(s['selectors'])
def scenes(s):return cache.rows(s['context'])
def offsets(s):return s['context']['context']['rebuild']['outer']['selection']['side_offsets']
def scene_argument(g):
    off,seg=g.stack_word(2),g.stack_word(4)
    if seg!=g.DS or (off-0xCCEF)%25:raise ValueError('selector scene pointer differs')
    index=(off-0xCCEF)//25;raw.integer(index,1,22);return index


class Recorder:
    def __init__(self,week):
        self.week,self.legacy=week,prior.Recorder(week);self.outer=self.legacy.outer
        self.calls=[];self.pending=self.frame=self.visit=None;self.stack=[]
        week.g.code_hook('0AB9:1991',self.enter);week.g.code_hook('0AB9:1994',self.leave)
        week.g.code_hook('0AB9:2208',self.initialize);week.g.code_hook('0AB9:22F0',self.finish)
        for site in STORES:week.g.code_hook(site,lambda g,site=site:self.store(g,site))
        for site,(end,_) in SITES.items():
            week.g.code_hook(site,lambda g,site=site:self.start(g,site));week.g.code_hook(end,lambda g,site=site:self.end(g,site))
    def enter(self,g):
        parent=self.outer.pending
        if parent is None or g.reg('bp')!=self.outer.frame:return
        if self.pending is not None:raise ValueError('nested proximity selection')
        self.pending={k:copy.deepcopy(parent[k]) for k in ('step','replacement','arguments')}
        self.pending.update(event=len(parent['events']),input=snapshot(g),draw_start=self.week.draws,initializations=[],visits=[])
    def initialize(self,g):
        if self.pending is None:return
        if self.frame is None:self.frame=g.reg('bp')
        if g.reg('bp')!=self.frame:return
        self.pending['initializations'].append({'side':arr.local(g,-1,1),'output':selectors(g),'draw':self.week.draws})
    def start(self,g,site):
        if self.pending is None:return
        kind=SITES[site][1];nested=kind in ('player-available','side')
        if nested:
            allowed=('available',) if kind=='player-available' else ('target-direction','candidate-direction')
            if not self.stack or self.stack[-1]['kind'] not in allowed:return
            if 'frame' in self.stack[-1]:raise ValueError('duplicate nested selector helper')
            self.stack[-1]['frame']=g.reg('bp')
        elif g.reg('bp')!=self.frame:return
        if kind=='available':
            if self.visit is not None:raise ValueError('unfinished selector candidate')
            side,slot=arr.local(g,-1,1),arr.local(g,-4);index=scene_argument(g)
            if (arr.local(g,-14),arr.local(g,-12))!=(0xCCEF+25*index,g.DS):raise ValueError('candidate saved pointer differs')
            self.visit={'side':side,'slot':slot,'scene':index,'input':cache.scene(g,index),'before':selectors(g),
                        'draw_start':self.week.draws,'helpers':[],'stores':[]}
        if self.visit is None:raise ValueError('selector helper lacks visit')
        index=self.visit['scene'];args=[g.stack_word(0)] if kind=='player-available' else [scene_argument(g)]
        e={'site':site,'kind':kind,'arguments':args,'input':cache.scene(g,index),'draw_start':self.week.draws,'children':[]}
        (self.stack[-1]['children'] if nested else self.visit['helpers']).append(e);self.stack.append(e)
    def end(self,g,site):
        if self.pending is None or not self.stack or self.stack[-1]['site']!=site:return
        e=self.stack[-1];nested=e['kind'] in ('player-available','side')
        frame=self.stack[-2].get('frame') if nested else self.frame
        if g.reg('bp')!=frame:return
        self.stack.pop();e.pop('frame',None)
        e.update(output=cache.scene(g,self.visit['scene']),result=g.reg('ax')&255,draw_end=self.week.draws)
    def store(self,g,site):
        if self.pending is None or g.reg('bp')!=self.frame:return
        if self.visit is None or self.stack:raise ValueError('selector store lacks completed helper')
        self.visit['stores'].append({'site':site,'kind':STORES[site],'output':selectors(g),'draw':self.week.draws})
    def finish(self,g):
        if self.pending is None or g.reg('bp')!=self.frame:return
        if self.visit is None or self.stack:raise ValueError('unfinished selector helpers')
        self.visit.update(output=cache.scene(g,self.visit['scene']),after=selectors(g),draw_end=self.week.draws)
        self.pending['visits'].append(self.visit);self.visit=None
    def leave(self,g):
        if self.pending is None or g.reg('bp')!=self.outer.frame:return
        if self.visit is not None or self.stack or self.frame is None:raise ValueError('unfinished proximity selection')
        self.pending.update(output=snapshot(g),draw_end=self.week.draws);self.calls.append(self.pending);self.pending=self.frame=None


def helper(e,c,v,kind,args):
    raw.keys(e,'site kind arguments input draw_start children output result draw_end')
    if e['site'] not in SITES or SITES[e['site']][1]!=kind or e['kind']!=kind:raise ValueError('selector helper site/order differs')
    raw.vector(e['arguments'],1,65535)
    if e['arguments']!=args:raise ValueError('selector helper arguments differ')
    for k in ('input','output'):arr.reb.validate_row(e[k])
    if e['input']!=v['input'] or e['output']!=v['input']:raise ValueError('read-only selector helper scene differs')
    prior.prior.interval(e,v['draw_start'],v['draw_end']);raw.integer(e['result'],0,255 if 'direction' in kind else 1)
    child='player-available' if kind=='available' else 'side' if 'direction' in kind else None
    if child:
        if len(e['children'])!=1:raise ValueError('one nested selector helper required')
        h=e['children'][0];helper(h,c,v,child,[v['input']['word14']] if child=='player-available' else [v['scene']])
        prior.prior.interval(h,e['draw_start'],e['draw_end'])
        if child=='player-available' and e['result']!=h['result']:raise ValueError('availability wrapper return differs')
        if child=='side' and e['result'] not in c['input']['signs']:raise ValueError('direction return lacks sign-cell witness')
    elif e['children']!=[]:raise ValueError('unexpected nested selector helper')


def validate_case(c):
    raw.keys(c,'step replacement arguments event input draw_start initializations visits output draw_end')
    for k in ('step','replacement','event'):raw.integer(c[k],0,10**9)
    raw.vector(c['arguments'],3,65535)
    for k in ('input','output'):validate_state(c[k])
    prior.prior.interval(c,c['draw_start'],c['draw_end'])
    clean=copy.deepcopy(c['output']);clean['selectors']=copy.deepcopy(c['input']['selectors'])
    if clean!=c['input']:raise ValueError('selector changed unrelated named inputs')
    if [a['side'] for a in c['initializations']]!=[0,1]:raise ValueError('selector side initialization coverage differs')
    expected=[(side,slot) for side in range(2) for slot in range(2,12)]
    if [(v['side'],v['slot']) for v in c['visits']]!=expected:raise ValueError('selector visit order/coverage differs')
    state=copy.deepcopy(c['input']['selectors']);pos=0;cursor=c['draw_start']
    for side,a in enumerate(c['initializations']):
        raw.keys(a,'side output draw');raw.integer(a['side'],0,1);raw.integer(a['draw'],cursor,c['draw_end']);validate_selectors(a['output'])
        state['near'][side]=offsets(c['input'])[side]+1;state['ahead'][side]=0
        if a['output']!=state:raise ValueError('selector initialization value differs')
        for slot in range(2,12):
            v=c['visits'][pos];pos+=1
            raw.keys(v,'side slot scene input before draw_start helpers stores output after draw_end')
            for k,lo,hi in (('side',0,1),('slot',2,11),('scene',1,22)):raw.integer(v[k],lo,hi)
            prior.prior.interval(v,cursor,c['draw_end']);cursor=v['draw_end']
            for k in ('input','output'):arr.reb.validate_row(v[k])
            for k in ('before','after'):validate_selectors(v[k])
            if v['scene']!=offsets(c['input'])[side]+slot or v['input']!=scenes(c['input'])[v['scene']-1] or v['output']!=v['input'] or v['before']!=state:raise ValueError('selector candidate/state identity differs')
            hs=v['helpers']
            if not hs:raise ValueError('missing selector availability')
            helper(hs[0],c,v,'available',[v['scene']])
            skip=hs[0]['result']!=0 or v['input']['byte7']==c['input']['context']['context']['actor'] or v['input']['byte19']==13
            if len(hs)!=(1 if skip else 3):raise ValueError('selector helper branch/count differs')
            if not skip:
                helper(hs[1],c,v,'target-direction',[v['scene']]);helper(hs[2],c,v,'candidate-direction',[v['scene']])
                if hs[1]['result']!=hs[2]['result']:raise ValueError('repeated read-only direction return differs')
            kinds=[s['kind'] for s in v['stores']]
            if kinds not in ([],['near'],['ahead'],['near','ahead']) or (skip and kinds):raise ValueError('selector store branch/order differs')
            for s in v['stores']:
                raw.keys(s,'site kind output draw');validate_selectors(s['output']);raw.integer(s['draw'],v['draw_start'],v['draw_end'])
                if s['site'] not in STORES or STORES[s['site']]!=s['kind']:raise ValueError('unknown selector store')
                state[s['kind']][side]=v['input']['byte7']
                if state!=s['output']:raise ValueError('literal selector store differs')
            if v['after']!=state:raise ValueError('candidate selector continuation differs')
    if c['output']['selectors']!=state:raise ValueError('final proximity selector differs')


def cases_for(calls,base,week):
    try:
        t33=json.loads((ROOT/base['actions']['source']['t33_record']).read_text());parents=prior.retained(t33)
        states=contests.outputs(base)['calls']
        if len(calls)!=len(parents) or len(states)!=len(parents):raise ValueError('missing/extra proximity boundaries')
        rows=[]
        for c,p,s in zip(calls,parents,states):
            validate_case(c)
            events=[(i,e) for i,e in enumerate(p['events']) if e['site']=='0AB9:1991']
            if len(events)!=1:raise ValueError('one retained proximity boundary required')
            i,e=events[0]
            if any(c[k]!=p[k] for k in ('step','replacement','arguments')) or c['event']!=i:raise ValueError('proximity root identity/order differs')
            if c['input']['context']!=s['output']['context']:raise ValueError('proximity entry differs from final T34')
            for k in ('input','output'):
                if c[k]['context']['context']!=e[k]:raise ValueError('proximity boundary differs from T28')
            if (c['draw_start'],c['draw_end'])!=(e['draw_start'],e['draw_end']):raise ValueError('proximity root interval differs')
            rows.append({'schema':'proximity-selectors-case/1','week':week,**c})
        return rows
    except (KeyError,IndexError,TypeError,AttributeError) as exc:raise ValueError(f'incomplete proximity fields: {exc}') from exc


def sources():
    index=prior.build_index()
    if not placement.same_json(index,json.loads((prior.FIXTURES/'index.json').read_text())):raise ValueError('retained T34 manifest differs')
    for meta in index['records']:yield meta,json.loads((ROOT/meta['record']).read_text())


def selected_runs():
    result={}
    for p in sorted(RUNS.glob('T35-r*.json')):
        r=json.loads(p.read_text())
        if r['status']=='completed':
            key=r['actions']['source']['t34_record']
            if key in result:raise ValueError('duplicate completed proximity-selectors week')
            result[key]=p,r
    return result


def build_index():
    inputs=list(sources());chosen=selected_runs();records=[]
    if set(chosen)!={m['record'] for m,_ in inputs}:raise ValueError('missing/extra proximity-selectors week')
    for meta,base in inputs:
        path,r=chosen[meta['record']]
        expected={'t34_record':meta['record'],'t34_record_sha256':meta['record_sha256'],'t34_cases_sha256':meta['cases_sha256']}
        if r['actions']['source']!=expected:raise ValueError('proximity-selectors provenance differs')
        if r['start_state']!=base['start_state'] or r['actions']['game_files']!=base['actions']['game_files']:raise ValueError('original state/game differs')
        cases=cases_for(contests.outputs(r)['calls'],base,meta['week'])
        obs={o['field']:o['value'] for o in r['observations']};fixture=ROOT/obs['fixture path']
        if fixture.parent!=FIXTURES or contests.sha(fixture)!=obs['fixture sha256'] or not placement.same_json(contests.events(fixture),cases):raise ValueError('proximity-selectors fixture differs')
        records.append({'record':match.rel(path),'record_sha256':contests.sha(path),'cases':fixture.name,
                        'cases_sha256':contests.sha(fixture),'week':meta['week'],'calls':len(cases),
                        'visits':sum(len(c['visits']) for c in cases),
                        'stores':{kind:sum(s['kind']==kind for c in cases for v in c['visits'] for s in v['stores']) for kind in ('near','ahead')},
                        'helpers':{kind:sum(e['kind']==kind for c in cases for v in c['visits'] for h in v['helpers'] for e in [h,*h['children']]) for _,kind in SITES.values()},
                        'draws':sum(c['draw_end']-c['draw_start'] for c in cases),'producer_commit':r['code_commit']})
    return {'schema':'proximity-selectors-corpus/1','records':records,'weeks':len(records),
            'calls':sum(r['calls'] for r in records),'draws':sum(r['draws'] for r in records),
            't34_index_sha256':contests.sha(prior.FIXTURES/'index.json'),
            'static_sources':{p:contests.sha(ROOT/p) for p in STATIC}}



def run():
    import cycle, guest, unicorn
    if match.git('status', '--porcelain', '--', 'runtime/emul'):
        raise SystemExit('commit observer before capture')
    commit = match.git('rev-parse', 'HEAD'); have = selected_runs()
    RUNS.mkdir(parents=True, exist_ok=True); FIXTURES.mkdir(parents=True, exist_ok=True)
    for meta, base in sources():
        if meta['record'] in have:
            print('already recorded '+meta['record'], flush=True); continue
        _, data = match.find_state(base['start_state']['sha256'])
        started = match.utc(); week = match.Week(data); recorder = Recorder(week)
        rows, lines, status = [], [], 'completed'
        try:
            week.play(on_boundary=lambda w:print(f'original week: screen {w.screen_i}, draws {w.draws}',flush=True))
            if week.g.unsupported or recorder.pending is not None or not placement.same_json(recorder.legacy.calls, contests.outputs(base)['calls']):
                raise ValueError('incomplete capture or retained T34 differs')
            t33=json.loads((ROOT/base['actions']['source']['t33_record']).read_text())
            if not placement.same_json(recorder.legacy.legacy.calls,contests.outputs(t33)['calls']):raise ValueError('retained T33 differs')
            t31=json.loads((ROOT/t33['actions']['source']['t31_record']).read_text())
            if not placement.same_json(recorder.legacy.legacy.legacy.calls,contests.outputs(t31)['calls']):raise ValueError('retained T31 differs')
            t30=json.loads((ROOT/t31['actions']['source']['t30_record']).read_text())
            if not placement.same_json(recorder.legacy.legacy.legacy.legacy.calls,contests.outputs(t30)['calls']):raise ValueError('retained T30 differs')
            t29=json.loads((ROOT/t30['actions']['source']['t29_record']).read_text())
            if not placement.same_json(recorder.legacy.legacy.legacy.legacy.legacy.calls,contests.outputs(t29)['calls']):raise ValueError('retained T29 differs')
            t28=json.loads((ROOT/t29['actions']['source']['t28_record']).read_text())
            if not placement.same_json(recorder.legacy.legacy.legacy.legacy.legacy.legacy.calls,contests.outputs(t28)['calls']):raise ValueError('retained T28 differs')
            t26=json.loads((ROOT/t28['actions']['source']['t26_record']).read_text())
            if not placement.same_json(recorder.legacy.legacy.legacy.legacy.legacy.legacy.legacy.calls,contests.outputs(t26)['calls']):raise ValueError('retained T26 differs')
            t25=json.loads((ROOT/t26['actions']['source']['t25_record']).read_text())
            if not placement.same_json(recorder.legacy.legacy.legacy.legacy.legacy.legacy.legacy.legacy.calls,contests.outputs(t25)['calls']):raise ValueError('retained T25 differs')
            t23=json.loads((ROOT/t25['actions']['source']['t23_record']).read_text())
            if not placement.same_json(recorder.legacy.legacy.legacy.legacy.legacy.legacy.legacy.legacy.legacy.calls,contests.outputs(t23)['calls']):raise ValueError('retained T23 differs')
            t22=json.loads((ROOT/t23['actions']['source']['t22_record']).read_text())
            if not placement.same_json(recorder.legacy.legacy.legacy.legacy.legacy.legacy.legacy.legacy.legacy.legacy.calls,contests.outputs(t22)['calls']):raise ValueError('retained T22 differs')
            t20=json.loads((ROOT/t22['actions']['source']['t20_record']).read_text())
            if not placement.same_json(recorder.legacy.legacy.legacy.legacy.legacy.legacy.legacy.legacy.legacy.legacy.legacy.calls,contests.outputs(t20)['calls']) or not placement.same_json(recorder.legacy.legacy.legacy.legacy.legacy.legacy.legacy.legacy.legacy.legacy.legacy.ledger,contests.outputs(t20)['ledger']):raise ValueError('retained T20 differs')
            t16=next(b for m,p,sc,x,b,pre in arr.reb.rep.ai.sub.sources() if m['record']==t22['actions']['source']['t20_record'])
            if not placement.same_json(recorder.legacy.legacy.legacy.legacy.legacy.legacy.legacy.legacy.legacy.legacy.legacy.tail.calls,contests.outputs(t16)['calls']):raise ValueError('retained T16 differs')
            source = t16['actions']['source']; trace = contests.events(ROOT/source['trace'])
            if week.events != trace[1:-1]:
                raise ValueError('new original week differs from T08')
            ok, lines = match.compare(week.events, source['start_state_sha256'], ROOT/source['t04_record_path'])
            if not ok:
                raise ValueError('ordered DOSBox-X comparison failed')
            rows = cases_for(recorder.calls, base, meta['week'])
        except (Exception, KeyboardInterrupt) as exc:
            status = f'aborted: {type(exc).__name__}: {exc}'
        n = max(match.next_number(RUNS, 'T35-r*.json'), match.next_number(FIXTURES, 'T35-r*.jsonl'))
        rid = f'T35-r{n:04d}'; fixture = FIXTURES/(rid+'.jsonl'); placement.write_lines(fixture, rows)
        rec = copy.deepcopy(base)
        rec.update(run_id=rid, experiment='T35', arm='proximity_selectors', rep=n, code_commit=commit,
                   machine=cycle.machine_id(), started=started, ended=match.utc(), status=status,
                   actions={'script': 'runtime/emul/proximity_selectors.py',
                            'source': {'t34_record': meta['record'], 't34_record_sha256': meta['record_sha256'], 't34_cases_sha256': meta['cases_sha256']},
                            'game_files': {name: hashlib.sha256(b).hexdigest() for name, b in week.files_at_start.items()}},
                   outputs=[{'name': 'calls', 'value': recorder.calls}],
                   observations=[{'step': 0, 'source': 'file', 'field': 'fixture path', 'value': match.rel(fixture)},
                                 {'step': 0, 'source': 'file', 'field': 'fixture sha256', 'value': contests.sha(fixture)},
                                 {'step': 1, 'source': 'log', 'field': 'ordered DOSBox-X comparison', 'value': '\n'.join(lines)}])
        rec['runtime'] = {'harness': f'runtime/emul/proximity_selectors.py@{commit}', 'unicorn': unicorn.__version__,
                          'python': platform.python_version(), 'dos_clock': week.g.clock,
                          'settings': {k: getattr(guest, k) for k in ('INSTR_PER_S', 'KEY_HOLD', 'PIT_HZ', 'SLICE_MAX')}}
        rec['interventions'] = [{'level': 'I3', 'what': 'guest.py services and read-only proximity_selectors hooks'}]
        match.write_record(RUNS/(rid+'.json'), rec)
        print(f'{rid}: {status}; {len(rows)} refresh cases', flush=True)
        if status != 'completed':
            raise SystemExit(1)
    index=build_index();path=FIXTURES/'index.json'
    if path.exists():
        if not placement.same_json(index,json.loads(path.read_text())):raise ValueError('existing manifest differs')
    else:
        with path.open('x') as f:f.write(json.dumps(index,indent=2)+'\n')


def main(argv=None):
    ap=argparse.ArgumentParser(description=__doc__);m=ap.add_mutually_exclusive_group(required=True)
    m.add_argument('--run',action='store_true');m.add_argument('--check',action='store_true');args=ap.parse_args(argv)
    if args.run:run();return 0
    try:
        index=build_index()
        if tuple(index[k] for k in ('weeks','calls','draws'))!=(1,2,0):raise ValueError('incomplete proximity-selectors corpus')
        if not placement.same_json(index,json.loads((FIXTURES/'index.json').read_text())):raise ValueError('proximity-selectors manifest differs')
    except (ValueError,OSError,KeyError,IndexError,TypeError) as exc:
        print(f'proximity-selectors check: FAIL: {exc}');return 1
    print('proximity-selectors check: ok (2 calls,40 candidate visits,zero draws)');return 0


if __name__=='__main__':raise SystemExit(main())
