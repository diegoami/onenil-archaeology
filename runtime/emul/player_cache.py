#!/usr/bin/env python3
"""T31: original 1539 outbound calls/cache context and caller stores, never computed effects."""
import argparse
import copy
import hashlib
import json
import platform

import scene_codes as prior

ROOT=prior.ROOT
RUNS,FIXTURES=ROOT/'runs/T31',ROOT/'traces/T31'
raw,contests,match,placement=prior.raw,prior.contests,prior.match,prior.placement
arr=prior.arr
SITES={
 '0AB9:1569':('0AB9:156E','managed'),
 '0AB9:1588':('0AB9:158B','select'),
 '0AB9:15B3':('0AB9:15B6','role'),
 '0AB9:15D0':('0AB9:15D5','available'),
 '0AB9:15DF':('0AB9:15E2','slot'),
 '0AB9:15ED':('0AB9:15F0','fallback'),
 '0AB9:1630':('0AB9:1635','rating'),
}
STATIC=('static/1-0-exe/code/seg_0AB9_02.asm','static/1-0-exe/code/seg_1B55_02.asm',
        'static/1-0-exe/code/seg_1B55_08.asm','static/1-0-exe/code/seg_0AB9_03.asm',
        'static/1-0-exe/code/seg_0AB9_09.asm','static/1-0-exe/code/seg_0AB9_14.asm',
        'static/1-0-exe/code/seg_0AB9_18.asm')


def snapshot(g):
    return {'context':arr.snapshot(g),'gate':g.rd(0xD18,1),
            'criteria':[g.rd(0x9F6+i,1) for i in range(6)],
            'cache':[{'side':side,'players':[g.rd(0xCF5C+10*side+2*kind) for kind in range(1,6)]} for side in range(2)]}


def validate_state(s):
    raw.keys(s,'context gate criteria cache');arr.validate_state(s['context'])
    raw.integer(s['gate'],0,255);raw.vector(s['criteria'],6,255)
    if not isinstance(s['cache'],list) or [r['side'] for r in s['cache']]!=[0,1]:raise ValueError('complete ordered player caches required')
    for side,r in enumerate(s['cache']):
        raw.keys(r,'side players');raw.integer(r['side'],0,1);raw.vector(r['players'],5,3920)
        if r['players'][0]!=s['context']['rebuild']['outer']['cached_players'][side]:raise ValueError('selected-player cache alias differs')


def rows(s):return s['context']['rebuild']['outer']['scenes']
def scene(g,index):return arr.reb.row(g,index)
def selected(s,side):return s['cache'][side]['players'][0]


def target(g):
    side,slot=arr.local(g,-1,1),arr.local(g,-4)
    index=g.rd(0xD56+side,1)+slot
    if arr.local(g,-0xC)!=0xCCEF+25*index or arr.local(g,-0xA)!=g.DS:
        raise ValueError('rating caller scene pointer differs')
    return slot,index


class Recorder:
    def __init__(self,week):
        self.week,self.legacy=week,prior.Recorder(week)
        self.outer=self.legacy.legacy.legacy
        self.calls=[];self.pending=self.event=self.store=self.frame=None
        week.g.code_hook('0AB9:198B',self.enter);week.g.code_hook('0AB9:198E',self.leave)
        week.g.code_hook('0AB9:163E',self.mark)
        for site,(end,_) in SITES.items():
            week.g.code_hook(site,lambda g,site=site:self.start(g,site))
            week.g.code_hook(end,lambda g,site=site:self.end(g,site))
    def enter(self,g):
        parent=self.outer.pending
        if parent is None or g.reg('bp')!=self.outer.frame:return
        if self.pending is not None:raise ValueError('nested player-cache refresh')
        self.frame=None
        self.pending={k:copy.deepcopy(parent[k]) for k in ('step','replacement','arguments')}
        self.pending.update(input=snapshot(g),draw_start=self.week.draws,events=[])
    def start(self,g,site):
        if self.pending is None:return
        if self.frame is None:self.frame=g.reg('bp')
        if g.reg('bp')!=self.frame:return
        if self.event is not None or self.store is not None:raise ValueError('unfinished direct player-cache call/store')
        side=arr.local(g,-1,1);kind=SITES[site][1];w=g.stack_word
        if kind in ('managed','available'):args=[w(0)]
        elif kind=='select':args=[w(0)&255]
        elif kind=='role':args=[w(0),w(2),w(4)&255]
        elif kind in ('slot','fallback'):args=[w(0),w(2)&255]
        else:args=[*target(g),w(0)]
        self.event={'site':site,'kind':kind,'side':side,'arguments':args,'input':snapshot(g),'draw_start':self.week.draws}
    def end(self,g,site):
        if self.pending is None or self.event is None or self.event['site']!=site or g.reg('bp')!=self.frame:return
        e=self.event;kind=e['kind']
        result=None if kind=='role' else g.reg('ax')&255 if kind in ('managed','available') else g.reg('ax')
        e.update(output=snapshot(g),result=result,draw_end=self.week.draws)
        self.pending['events'].append(e);self.event=None
        if kind=='rating':self.store=e
    def mark(self,g):
        if self.pending is None or g.reg('bp')!=self.frame:return
        if self.store is None or self.event is not None:raise ValueError('caller store lacks rating observation')
        e=self.store;slot,index=target(g)
        if [slot,index]!=e['arguments'][:2]:raise ValueError('caller store target changed')
        self.pending['events'].append({'site':'0AB9:163E','kind':'store','side':e['side'],
            'arguments':copy.deepcopy(e['arguments']),'input':copy.deepcopy(rows(e['output'])[index-1]),
            'output':scene(g,index),'result':None,'draw_start':e['draw_end'],'draw_end':self.week.draws})
        self.store=None
    def leave(self,g):
        if self.pending is None or g.reg('bp')!=self.outer.frame:return
        if self.event is not None or self.store is not None:raise ValueError('unfinished player-cache refresh')
        self.pending.update(output=snapshot(g),draw_end=self.week.draws)
        self.calls.append(self.pending);self.pending=None


def validate_event(e,c,cursor):
    raw.keys(e,'site kind side arguments input draw_start output result draw_end')
    raw.integer(e['side'],0,1);kind=e['kind']
    if kind=='store':
        if e['site']!='0AB9:163E':raise ValueError('unknown caller store')
        for k in ('input','output'):arr.reb.validate_row(e[k])
        clean=copy.deepcopy(e['output']);clean['byte18']=e['input']['byte18']
        if clean!=e['input']:raise ValueError('caller store changed unrelated scene field')
        if e['result'] is not None:raise ValueError('caller store has scalar result')
    else:
        if e['site'] not in SITES or SITES[e['site']][1]!=kind:raise ValueError('unknown player-cache helper')
        for k in ('input','output'):validate_state(e[k])
        if kind=='role':
            if e['result'] is not None:raise ValueError('void role helper has scalar result')
        else:raw.integer(e['result'],0,1 if kind in ('managed','available') else 3920 if kind in ('select','fallback') else 65535)
        if kind in ('managed','select','available','slot','rating') and e['input']!=e['output']:
            raise ValueError('read-only direct helper changed named state')
    raw.vector(e['arguments'],3 if kind in ('role','rating','store') else 2 if kind in ('slot','fallback') else 1,65535)
    for k in ('draw_start','draw_end'):raw.integer(e[k],0,10**9)
    if not cursor<=e['draw_start']<=e['draw_end']<=c['draw_end']:raise ValueError('player-cache draw continuation differs')
    return e['draw_end']


def apply_selected(state,side,player):
    # Copy an actual original helper return into its two named aliases, not a selection algorithm.
    result=copy.deepcopy(state);result['cache'][side]['players'][0]=player
    result['context']['rebuild']['outer']['cached_players'][side]=player
    return result


def validate_events(c):
    if not isinstance(c['events'],list):raise ValueError('ordered player-cache events required')
    cursor=c['draw_start']
    for e in c['events']:cursor=validate_event(e,c,cursor)
    pos=0;state=copy.deepcopy(c['input'])
    def take(kind,side):
        nonlocal pos,state
        if pos>=len(c['events']):raise ValueError('missing player-cache event')
        e=c['events'][pos];pos+=1
        if e['kind']!=kind or e['side']!=side:raise ValueError('player-cache branch/order differs')
        if kind!='store':
            if e['input']!=state:raise ValueError('direct helper state continuation differs')
            state=copy.deepcopy(e['output'])
        return e
    for side in range(2):
        managed=take('managed',side)
        club=state['context']['rebuild']['outer']['selection']['clubs'][side]['id']
        if managed['arguments']!=[club]:raise ValueError('managed club argument differs')
        if managed['result']==0 or state['gate']==0:
            if managed['result']==0:
                e=take('select',side)
                if e['arguments']!=[side]:raise ValueError('selector side differs')
                state=apply_selected(state,side,e['result'])
            for kind in range(2,6):
                before=copy.deepcopy(state);e=take('role',side)
                if e['arguments']!=[kind,before['criteria'][kind],side]:raise ValueError('role criterion/side differs')
                before['cache'][side]['players'][kind-1]=state['cache'][side]['players'][kind-1]
                if before!=state:raise ValueError('role helper changed unrelated named state')
        else:
            e=take('available',side)
            if e['arguments']!=[selected(state,side)]:raise ValueError('cached availability player differs')
            fallback=e['result']!=0
            if not fallback:
                e=take('slot',side)
                if e['arguments']!=[1,side] or not 1<=e['result']<=12:raise ValueError('cached roster slot differs')
                fallback=e['result']>11
            if fallback:
                e=take('fallback',side)
                if e['arguments']!=[1,side]:raise ValueError('fallback arguments differ')
                state=apply_selected(state,side,e['result'])
        for slot in range(1,12):
            index=state['context']['rebuild']['outer']['selection']['side_offsets'][side]+slot
            args=[slot,index,selected(state,side)]
            e=take('rating',side)
            if e['arguments']!=args:raise ValueError('rating side/slot/scene/player differs')
            mark=take('store',side)
            if mark['arguments']!=args or mark['input']!=rows(state)[index-1] or mark['output']['index']!=index:
                raise ValueError('observed caller store continuation differs')
            rows(state)[index-1]=copy.deepcopy(mark['output'])
    if pos!=len(c['events']) or state!=c['output']:raise ValueError('final player-cache state/order differs')


def cases_for(calls,retained,week):
    try:
        if len(calls)!=len(retained):raise ValueError('missing/extra player-cache cases')
        rows_out=[]
        for c,base in zip(calls,retained):
            raw.keys(c,'step replacement arguments input draw_start events output draw_end')
            for k in ('step','replacement','draw_start','draw_end'):raw.integer(c[k],0,10**9)
            raw.vector(c['arguments'],3,65535)
            if any(c[k]!=base[k] for k in ('step','replacement','arguments')):raise ValueError('player-cache case order differs')
            selected_events=[e for e in base['events'] if e['site']=='0AB9:198B']
            if len(selected_events)!=1:raise ValueError('one retained player-cache boundary required')
            e=selected_events[0]
            if (c['draw_start'],c['draw_end'])!=(e['draw_start'],e['draw_end']):raise ValueError('player-cache root interval differs')
            for k in ('input','output'):
                validate_state(c[k])
                if c[k]['context']!=e[k]:raise ValueError('player-cache boundary differs from T28')
            validate_events(c);rows_out.append({'schema':'player-cache-case/1','week':week,**c})
        return rows_out
    except (KeyError,IndexError,TypeError,AttributeError) as exc:raise ValueError(f'incomplete player-cache fields: {exc}') from exc


def sources():
    index=prior.build_index()
    if not placement.same_json(index,json.loads((prior.FIXTURES/'index.json').read_text())):raise ValueError('retained T30 manifest differs')
    for meta in index['records']:yield meta,json.loads((ROOT/meta['record']).read_text())


def selected_runs():
    result={}
    for p in sorted(RUNS.glob('T31-r*.json')):
        r=json.loads(p.read_text())
        if r['status']=='completed':
            key=r['actions']['source']['t30_record']
            if key in result:raise ValueError('duplicate completed player-cache week')
            result[key]=p,r
    return result


def build_index():
    inputs=list(sources());chosen=selected_runs();records=[]
    if set(chosen)!={m['record'] for m,_ in inputs}:raise ValueError('missing/extra player-cache week')
    for meta,base in inputs:
        path,r=chosen[meta['record']]
        expected={'t30_record':meta['record'],'t30_record_sha256':meta['record_sha256'],'t30_cases_sha256':meta['cases_sha256']}
        if r['actions']['source']!=expected:raise ValueError('player-cache provenance differs')
        if r['start_state']!=base['start_state'] or r['actions']['game_files']!=base['actions']['game_files']:raise ValueError('original state/game differs')
        t29=json.loads((ROOT/base['actions']['source']['t29_record']).read_text())
        t28=json.loads((ROOT/t29['actions']['source']['t28_record']).read_text())
        cases=cases_for(contests.outputs(r)['calls'],contests.outputs(t28)['calls'],meta['week'])
        obs={o['field']:o['value'] for o in r['observations']};fixture=ROOT/obs['fixture path']
        if fixture.parent!=FIXTURES or contests.sha(fixture)!=obs['fixture sha256'] or not placement.same_json(contests.events(fixture),cases):raise ValueError('player-cache fixture differs')
        records.append({'record':match.rel(path),'record_sha256':contests.sha(path),'cases':fixture.name,
                        'cases_sha256':contests.sha(fixture),'week':meta['week'],'calls':len(cases),
                        'events':{kind:sum(e['kind']==kind for c in cases for e in c['events']) for kind in [*(v[1] for v in SITES.values()),'store']},
                        'draws':sum(c['draw_end']-c['draw_start'] for c in cases),'producer_commit':r['code_commit']})
    return {'schema':'player-cache-corpus/1','records':records,'weeks':len(records),
            'calls':sum(r['calls'] for r in records),'draws':sum(r['draws'] for r in records),
            'stores':sum(r['events']['store'] for r in records),'t30_index_sha256':contests.sha(prior.FIXTURES/'index.json'),
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
                raise ValueError('incomplete capture or retained T30 differs')
            t29=json.loads((ROOT/base['actions']['source']['t29_record']).read_text())
            if not placement.same_json(recorder.legacy.legacy.calls,contests.outputs(t29)['calls']):raise ValueError('retained T29 differs')
            t28=json.loads((ROOT/t29['actions']['source']['t28_record']).read_text())
            if not placement.same_json(recorder.legacy.legacy.legacy.calls,contests.outputs(t28)['calls']):raise ValueError('retained T28 differs')
            t26=json.loads((ROOT/t28['actions']['source']['t26_record']).read_text())
            if not placement.same_json(recorder.legacy.legacy.legacy.legacy.calls,contests.outputs(t26)['calls']):raise ValueError('retained T26 differs')
            t25=json.loads((ROOT/t26['actions']['source']['t25_record']).read_text())
            if not placement.same_json(recorder.legacy.legacy.legacy.legacy.legacy.calls,contests.outputs(t25)['calls']):raise ValueError('retained T25 differs')
            t23=json.loads((ROOT/t25['actions']['source']['t23_record']).read_text())
            if not placement.same_json(recorder.legacy.legacy.legacy.legacy.legacy.legacy.calls,contests.outputs(t23)['calls']):raise ValueError('retained T23 differs')
            t22=json.loads((ROOT/t23['actions']['source']['t22_record']).read_text())
            if not placement.same_json(recorder.legacy.legacy.legacy.legacy.legacy.legacy.legacy.calls,contests.outputs(t22)['calls']):raise ValueError('retained T22 differs')
            t20=json.loads((ROOT/t22['actions']['source']['t20_record']).read_text())
            if not placement.same_json(recorder.legacy.legacy.legacy.legacy.legacy.legacy.legacy.legacy.calls,contests.outputs(t20)['calls']) or not placement.same_json(recorder.legacy.legacy.legacy.legacy.legacy.legacy.legacy.legacy.ledger,contests.outputs(t20)['ledger']):raise ValueError('retained T20 differs')
            t16=next(b for m,p,sc,x,b,pre in arr.reb.rep.ai.sub.sources() if m['record']==t22['actions']['source']['t20_record'])
            if not placement.same_json(recorder.legacy.legacy.legacy.legacy.legacy.legacy.legacy.legacy.tail.calls,contests.outputs(t16)['calls']):raise ValueError('retained T16 differs')
            source = t16['actions']['source']; trace = contests.events(ROOT/source['trace'])
            if week.events != trace[1:-1]:
                raise ValueError('new original week differs from T08')
            ok, lines = match.compare(week.events, source['start_state_sha256'], ROOT/source['t04_record_path'])
            if not ok:
                raise ValueError('ordered DOSBox-X comparison failed')
            rows = cases_for(recorder.calls, contests.outputs(t28)['calls'], meta['week'])
        except (Exception, KeyboardInterrupt) as exc:
            status = f'aborted: {type(exc).__name__}: {exc}'
        n = max(match.next_number(RUNS, 'T31-r*.json'), match.next_number(FIXTURES, 'T31-r*.jsonl'))
        rid = f'T31-r{n:04d}'; fixture = FIXTURES/(rid+'.jsonl'); placement.write_lines(fixture, rows)
        rec = copy.deepcopy(base)
        rec.update(run_id=rid, experiment='T31', arm='player_cache', rep=n, code_commit=commit,
                   machine=cycle.machine_id(), started=started, ended=match.utc(), status=status,
                   actions={'script': 'runtime/emul/player_cache.py',
                            'source': {'t30_record': meta['record'], 't30_record_sha256': meta['record_sha256'], 't30_cases_sha256': meta['cases_sha256']},
                            'game_files': {name: hashlib.sha256(b).hexdigest() for name, b in week.files_at_start.items()}},
                   outputs=[{'name': 'calls', 'value': recorder.calls}],
                   observations=[{'step': 0, 'source': 'file', 'field': 'fixture path', 'value': match.rel(fixture)},
                                 {'step': 0, 'source': 'file', 'field': 'fixture sha256', 'value': contests.sha(fixture)},
                                 {'step': 1, 'source': 'log', 'field': 'ordered DOSBox-X comparison', 'value': '\n'.join(lines)}])
        rec['runtime'] = {'harness': f'runtime/emul/player_cache.py@{commit}', 'unicorn': unicorn.__version__,
                          'python': platform.python_version(), 'dos_clock': week.g.clock,
                          'settings': {k: getattr(guest, k) for k in ('INSTR_PER_S', 'KEY_HOLD', 'PIT_HZ', 'SLICE_MAX')}}
        rec['interventions'] = [{'level': 'I3', 'what': 'guest.py services and read-only player_cache hooks'}]
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
        if tuple(index[k] for k in ('weeks','calls','stores','draws'))!=(1,2,44,0):raise ValueError('incomplete player-cache corpus')
        if not placement.same_json(index,json.loads((FIXTURES/'index.json').read_text())):raise ValueError('player-cache manifest differs')
    except (ValueError,OSError,KeyError,IndexError,TypeError) as exc:
        print(f'player-cache check: FAIL: {exc}');return 1
    print('player-cache check: ok (2 calls,44 caller stores,zero draws)');return 0


if __name__=='__main__':raise SystemExit(main())
