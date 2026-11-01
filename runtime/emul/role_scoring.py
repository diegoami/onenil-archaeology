#!/usr/bin/env python3
"""T33: observed role-cache scoring, indexed inputs and store branches; no engine model."""
import argparse
import copy
import hashlib
import json
import platform

import player_cache as prior

ROOT=prior.ROOT
RUNS,FIXTURES=ROOT/'runs/T33',ROOT/'traces/T33'
raw,contests,match,placement,arr=prior.raw,prior.contests,prior.match,prior.placement,prior.arr
SITES={
 '0AB9:14B8':('0AB9:14BD','available'),
 '0AB9:14EF':('0AB9:14F2','slot'),
 '0AB9:14FC':('0AB9:14FF','old-score'),
 '0AB9:1509':('0AB9:150C','new-score'),
 '0AB9:1B60':('0AB9:1B63','table'),
}
STATIC=('static/1-0-exe/code/seg_0AB9_02.asm','static/1-0-exe/code/seg_0AB9_03.asm',
        'static/1-0-exe/code/seg_0AB9_14.asm','static/1-0-exe/code/seg_0AB9_15.asm',
        'static/1-0-exe/code/seg_1B55_08.asm','static/1-0-exe/code/seg_24BC_01.asm')


def players(s):return s['context']['context']['rebuild']['outer']['players']
def scenes(s):return prior.rows(s['context'])
def offsets(s):return s['context']['context']['rebuild']['outer']['selection']['side_offsets']
def cached(s,args):return s['context']['cache'][args[2]]['players'][args[0]-1]


def lookup(g,player,criterion):
    # Normalize actual memory addresses, never evaluate the callee's score.
    values=[arr.reb.far_value(g,0xD7BA,8*player+i,1) for i in (4,5,7)]
    first=(22*values[2]+criterion)&65535
    cell=g.rd((0x957D+first)&65535,1)
    second=(22*values[1]+cell)&65535
    return {'player':player,'p8_4':values[0],'p8_5':values[1],'p8_7':values[2],
            'first_index':first,'first_cell':cell,'second_index':second,
            'second_cell':g.rd((0x96B1+second)&65535,1)}


def snapshot(g,criterion):
    s={'context':prior.snapshot(g),'bonus':g.rd(0xD29,1),
       'flags':[g.rd(0xD1CE+i,1) for i in range(2)],
       'criterion_cell':g.rd((0x9FB+criterion)&65535,1)}
    ids=[p['id'] for p in players(s)]
    s['lookups']=[lookup(g,p,criterion) for p in ids]
    clubs=sorted({p['p8_0'] for p in players(s) if p['id']})
    s['club_rosters']=[{'club':c,'roster':[arr.reb.far_value(g,0xD7C2,62*(c-1)+2*k,2) for k in range(11)]} for c in clubs]
    return s


def validate_state(s,criterion):
    raw.keys(s,'context bonus flags criterion_cell lookups club_rosters');prior.validate_state(s['context'])
    for k in ('bonus','criterion_cell'):raw.integer(s[k],0,255)
    raw.vector(s['flags'],2,255)
    if [v['player'] for v in s['lookups']]!=[p['id'] for p in players(s)]:raise ValueError('incomplete canonical lookup inputs')
    for v in s['lookups']:
        raw.keys(v,'player p8_4 p8_5 p8_7 first_index first_cell second_index second_cell')
        raw.integer(v['player'],0,3920)
        for k in ('p8_4','p8_5','p8_7','first_cell','second_cell'):raw.integer(v[k],0,255)
        for k in ('first_index','second_index'):raw.integer(v[k])
        p=next(p for p in players(s) if p['id']==v['player'])
        if any(v[k]!=p[k] for k in ('p8_4','p8_5','p8_7')):raise ValueError('canonical lookup aliases differ')
        if v['first_index']!=(22*v['p8_7']+criterion)&65535 or v['second_index']!=(22*v['p8_5']+v['first_cell'])&65535:raise ValueError('indexed lookup address differs')
    clubs=sorted({p['p8_0'] for p in players(s) if p['id']})
    if [v['club'] for v in s['club_rosters']]!=clubs:raise ValueError('incomplete player-club rosters')
    for v in s['club_rosters']:
        raw.keys(v,'club roster');raw.integer(v['club'],1,176);raw.vector(v['roster'],11,3920)


def pointer(g,off,seg):
    if seg!=g.DS or (off-0xCCEF)%25:raise ValueError('score scene pointer differs')
    index=(off-0xCCEF)//25
    raw.integer(index,1,22)
    return index


class Recorder:
    def __init__(self,week):
        self.week,self.legacy=week,prior.Recorder(week)
        self.calls=[];self.pending=self.frame=self.visit=None;self.stack=[]
        week.g.code_hook('0AB9:15B3',self.enter);week.g.code_hook('0AB9:15B6',self.leave)
        week.g.code_hook('0AB9:146F',self.clear)
        week.g.code_hook('0AB9:1511',self.store);week.g.code_hook('0AB9:152C',self.finish)
        for site,(end,_) in SITES.items():
            week.g.code_hook(site,lambda g,site=site:self.start(g,site))
            week.g.code_hook(end,lambda g,site=site:self.end(g,site))
    def enter(self,g):
        parent=self.legacy.pending
        if parent is None or g.reg('bp')!=self.legacy.frame:return
        if self.pending is not None or self.stack:raise ValueError('nested role cache')
        args=[g.stack_word(0),g.stack_word(2),g.stack_word(4)&255]
        self.pending={'step':parent['step'],'replacement':parent['replacement'],'event':len(parent['events']),
                      'arguments':args,'input':snapshot(g,args[1]),'draw_start':self.week.draws,'visits':[]}
    def clear(self,g):
        if self.pending is None:return
        if self.frame is not None:raise ValueError('duplicate role clear')
        self.frame=g.reg('bp');a=self.pending['arguments']
        self.pending['clear']={'before':cached(self.pending['input'],a),'after':g.rd(0xCF5C+10*a[2]+2*a[0]),'draw':self.week.draws}
    def start(self,g,site):
        if self.pending is None:return
        kind=SITES[site][1];w=g.stack_word
        if kind=='table':
            if not self.stack or self.stack[-1]['kind'] not in ('old-score','new-score'):return
            if self.stack[-1].get('frame') is not None:raise ValueError('duplicate score table call')
            self.stack[-1]['frame']=g.reg('bp')
        elif g.reg('bp')!=self.frame:return
        if kind=='available':
            if self.visit is not None:raise ValueError('unfinished candidate')
            slot,index=arr.local(g,-2),arr.local(g,-4)
            if pointer(g,arr.local(g,-8),arr.local(g,-6))!=index:raise ValueError('candidate scene pointer differs')
            a=self.pending['arguments']
            self.visit={'slot':slot,'scene':index,'player':w(0),'cache_before':g.rd(0xCF5C+10*a[2]+2*a[0]),
                        'scene_input':prior.scene(g,index),'draw_start':self.week.draws,'helpers':[],'stored':0}
        if self.visit is None:raise ValueError('helper lacks candidate')
        e={'site':site,'kind':kind,'arguments':[w(0)],'draw_start':self.week.draws,'children':[]}
        if kind in ('old-score','new-score'):
            index=pointer(g,w(2),w(4));e['arguments']=[index,w(6)];e['scene_input']=prior.scene(g,index)
            p=next(p for p in players(self.pending['input']) if p['id']==e['scene_input']['word14'])
            if not 0<=p['p15_6']<=31:raise ValueError('unsupported raw P15+6 score domain')
        elif kind=='table':
            e['arguments']=[w(0),w(2)];e['input']=lookup(g,w(2),w(0))
        (self.stack[-1]['children'] if self.stack else self.visit['helpers']).append(e);self.stack.append(e)
    def end(self,g,site):
        if self.pending is None or not self.stack or self.stack[-1]['site']!=site:return
        e=self.stack[-1]
        frame=self.stack[-2].get('frame') if e['kind']=='table' else self.frame
        if g.reg('bp')!=frame:return
        self.stack.pop();e.pop('frame',None)
        e.update(result=g.reg('ax')&(255 if e['kind']=='available' else 65535),draw_end=self.week.draws)
        if e['kind'] in ('old-score','new-score'):e['scene_output']=prior.scene(g,e['arguments'][0])
    def store(self,g):
        if self.pending is not None and g.reg('bp')==self.frame:
            if self.visit is None or self.stack:raise ValueError('store lacks completed candidate helpers')
            self.visit['stored']=1
    def finish(self,g):
        if self.pending is None or g.reg('bp')!=self.frame:return
        if self.visit is None or self.stack:raise ValueError('unfinished candidate helpers')
        a=self.pending['arguments'];v=self.visit
        v.update(cache_after=g.rd(0xCF5C+10*a[2]+2*a[0]),scene_output=prior.scene(g,v['scene']),draw_end=self.week.draws)
        self.pending['visits'].append(v);self.visit=None
    def leave(self,g):
        if self.pending is None or g.reg('bp')!=self.legacy.frame:return
        if self.stack or self.visit is not None or self.frame is None:raise ValueError('unfinished role cache')
        self.pending.update(output=snapshot(g,self.pending['arguments'][1]),draw_end=self.week.draws)
        self.calls.append(self.pending);self.pending=self.frame=None


def interval(e,start,end):
    for k in ('draw_start','draw_end'):raw.integer(e[k],0,10**9)
    if not start<=e['draw_start']<=e['draw_end']<=end:raise ValueError('role draw continuation differs')
    # These reached routines have no random dependency; reject unexplained draws.
    if e['draw_start']!=e['draw_end']:raise ValueError('unexpected role draws')


def validate_helper(e,c,kind,args,start,end):
    fields='site kind arguments draw_start children result draw_end'
    if kind in ('old-score','new-score'):fields+=' scene_input scene_output'
    if kind=='table':fields+=' input'
    raw.keys(e,fields)
    if e['site'] not in SITES or SITES[e['site']][1]!=kind or e['kind']!=kind:raise ValueError('role helper site/order differs')
    raw.vector(e['arguments'],len(args),65535)
    if e['arguments']!=args:raise ValueError('role helper arguments differ')
    interval(e,start,end);raw.integer(e['result'],0,1 if kind=='available' else 22 if kind=='slot' else 65535)
    if kind in ('old-score','new-score'):
        for k in ('scene_input','scene_output'):arr.reb.validate_row(e[k])
        index,criterion=args
        if e['scene_input']!=scenes(c['input'])[index-1] or e['scene_output']!=e['scene_input']:raise ValueError('score scene input/write differs')
        p=next(p for p in players(c['input']) if p['id']==e['scene_input']['word14'])
        if not 0<=p['p15_6']<=31:raise ValueError('unsupported raw P15+6 score domain')
        if len(e['children'])!=1:raise ValueError('one nested table helper required')
        validate_helper(e['children'][0],c,'table',[criterion,p['id']],e['draw_start'],e['draw_end'])
    else:
        if e['children']!=[]:raise ValueError('unexpected nested role helper')
        if kind=='table':
            v=next(v for v in c['input']['lookups'] if v['player']==args[1])
            if e['input']!=v:raise ValueError('nested table inputs differ')
    return e


def validate_case(c):
    raw.keys(c,'step replacement event arguments input draw_start visits clear output draw_end')
    for k in ('step','replacement','event'):raw.integer(c[k],0,10**9)
    raw.vector(c['arguments'],3,65535);kind,criterion,side=c['arguments']
    raw.integer(kind,2,5);raw.integer(criterion,0,255);raw.integer(side,0,1)
    for k in ('input','output'):validate_state(c[k],criterion)
    interval(c,c['draw_start'],c['draw_end'])
    a=c['clear'];raw.keys(a,'before after draw')
    for k in ('before','after'):raw.integer(a[k],0,3920)
    raw.integer(a['draw'],c['draw_start'],c['draw_end'])
    if a['before']!=cached(c['input'],c['arguments']) or a['after']!=0:raise ValueError('role cache clear differs')
    before=copy.deepcopy(c['input']);before['context']['cache'][side]['players'][kind-1]=cached(c['output'],c['arguments'])
    if before!=c['output']:raise ValueError('role changed unrelated named inputs')
    first=c['input']['context']['criteria'][1 if kind==5 else 0]+1
    if not isinstance(c['visits'],list) or [v['slot'] for v in c['visits']]!=list(range(first,12)):raise ValueError('candidate visit coverage/order differs')
    current=0;cursor=c['draw_start']
    for v in c['visits']:
        raw.keys(v,'slot scene player cache_before scene_input draw_start helpers stored cache_after scene_output draw_end')
        raw.integer(v['slot'],1,11);raw.integer(v['scene'],1,22);raw.integer(v['player'],0,3920)
        for k in ('cache_before','cache_after'):raw.integer(v[k],0,3920)
        raw.integer(v['stored'],0,1);interval(v,cursor,c['draw_end']);cursor=v['draw_end']
        index=offsets(c['input'])[side]+v['slot']
        for k in ('scene_input','scene_output'):arr.reb.validate_row(v[k])
        if v['scene']!=index or v['scene_input']!=scenes(c['input'])[index-1] or v['scene_output']!=v['scene_input'] or v['player']!=v['scene_input']['word14']:raise ValueError('candidate pointer/player/state differs')
        if v['cache_before']!=current:raise ValueError('candidate cache continuation differs')
        hs=v['helpers']
        if not isinstance(hs,list) or not hs:raise ValueError('missing candidate helpers')
        av=validate_helper(hs[0],c,'available',[v['player']],v['draw_start'],v['draw_end'])
        if av['result']!=0 or current==0:
            if len(hs)!=1 or v['stored']!=int(av['result']==0):raise ValueError('availability/empty-cache branch differs')
        else:
            if len(hs)!=4:raise ValueError('missing/reordered candidate comparison')
            sl=validate_helper(hs[1],c,'slot',[current],av['draw_end'],v['draw_end'])
            index_old=sl['result']
            if not 1<=index_old<=22 or scenes(c['input'])[index_old-1]['word14']!=current:raise ValueError('cached player scene identity differs')
            p=next(p for p in players(c['input']) if p['id']==current)
            roster=next(v['roster'] for v in c['input']['club_rosters'] if v['club']==p['p8_0'])
            selection=c['input']['context']['context']['rebuild']['outer']['selection']
            old_side=int(p['p8_0']==selection['clubs'][1]['id'])
            slot_old=index_old-offsets(c['input'])[old_side]
            if not 1<=slot_old<=11 or roster[slot_old-1]!=current or current in roster[slot_old:]:raise ValueError('player-club roster slot witness differs')
            old=validate_helper(hs[2],c,'old-score',[index_old,criterion],sl['draw_end'],v['draw_end'])
            validate_helper(hs[3],c,'new-score',[v['scene'],criterion],old['draw_end'],v['draw_end'])
        current=v['player'] if v['stored'] else current
        if v['cache_after']!=current:raise ValueError('observed store/cache value differs')
    if current!=cached(c['output'],c['arguments']):raise ValueError('final role cache differs')


def cases_for(calls,retained,week):
    try:
        expected=[(parent,i,e) for parent in retained for i,e in enumerate(parent['events']) if e['kind']=='role']
        if len(calls)!=len(expected):raise ValueError('missing/extra role boundaries')
        result=[]
        for c,(parent,i,e) in zip(calls,expected):
            validate_case(c)
            if [c['step'],c['replacement'],c['event'],c['arguments']]!=[parent['step'],parent['replacement'],i,e['arguments']]:raise ValueError('role boundary identity/order differs')
            for k in ('input','output'):
                if c[k]['context']!=e[k]:raise ValueError('role boundary differs from T31')
            if (c['draw_start'],c['draw_end'])!=(e['draw_start'],e['draw_end']):raise ValueError('role root interval differs')
            result.append({'schema':'role-scoring-case/1','week':week,**c})
        return result
    except (KeyError,IndexError,TypeError,AttributeError,StopIteration) as exc:raise ValueError(f'incomplete role fields: {exc}') from exc


def sources():
    index=prior.build_index()
    if not placement.same_json(index,json.loads((prior.FIXTURES/'index.json').read_text())):raise ValueError('retained T31 manifest differs')
    for meta in index['records']:yield meta,json.loads((ROOT/meta['record']).read_text())


def selected_runs():
    result={}
    for p in sorted(RUNS.glob('T33-r*.json')):
        r=json.loads(p.read_text())
        if r['status']=='completed':
            key=r['actions']['source']['t31_record']
            if key in result:raise ValueError('duplicate completed role-scoring week')
            result[key]=p,r
    return result


def build_index():
    inputs=list(sources());chosen=selected_runs();records=[]
    if set(chosen)!={m['record'] for m,_ in inputs}:raise ValueError('missing/extra role-scoring week')
    for meta,base in inputs:
        path,r=chosen[meta['record']]
        expected={'t31_record':meta['record'],'t31_record_sha256':meta['record_sha256'],'t31_cases_sha256':meta['cases_sha256']}
        if r['actions']['source']!=expected:raise ValueError('role-scoring provenance differs')
        if r['start_state']!=base['start_state'] or r['actions']['game_files']!=base['actions']['game_files']:raise ValueError('original state/game differs')
        cases=cases_for(contests.outputs(r)['calls'],contests.outputs(base)['calls'],meta['week'])
        obs={o['field']:o['value'] for o in r['observations']};fixture=ROOT/obs['fixture path']
        if fixture.parent!=FIXTURES or contests.sha(fixture)!=obs['fixture sha256'] or not placement.same_json(contests.events(fixture),cases):raise ValueError('role-scoring fixture differs')
        records.append({'record':match.rel(path),'record_sha256':contests.sha(path),'cases':fixture.name,
                        'cases_sha256':contests.sha(fixture),'week':meta['week'],'calls':len(cases),
                        'visits':sum(len(c['visits']) for c in cases),
                        'helpers':{kind:sum(e['kind']==kind for c in cases for v in c['visits'] for h in v['helpers'] for e in [h,*h['children']]) for _,kind in SITES.values()},
                        'stores':sum(v['stored'] for c in cases for v in c['visits']),
                        'draws':sum(c['draw_end']-c['draw_start'] for c in cases),'producer_commit':r['code_commit']})
    return {'schema':'role-scoring-corpus/1','records':records,'weeks':len(records),
            'calls':sum(r['calls'] for r in records),'draws':sum(r['draws'] for r in records),
            't31_index_sha256':contests.sha(prior.FIXTURES/'index.json'),
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
                raise ValueError('incomplete capture or retained T31 differs')
            t30=json.loads((ROOT/base['actions']['source']['t30_record']).read_text())
            if not placement.same_json(recorder.legacy.legacy.calls,contests.outputs(t30)['calls']):raise ValueError('retained T30 differs')
            t29=json.loads((ROOT/t30['actions']['source']['t29_record']).read_text())
            if not placement.same_json(recorder.legacy.legacy.legacy.calls,contests.outputs(t29)['calls']):raise ValueError('retained T29 differs')
            t28=json.loads((ROOT/t29['actions']['source']['t28_record']).read_text())
            if not placement.same_json(recorder.legacy.legacy.legacy.legacy.calls,contests.outputs(t28)['calls']):raise ValueError('retained T28 differs')
            t26=json.loads((ROOT/t28['actions']['source']['t26_record']).read_text())
            if not placement.same_json(recorder.legacy.legacy.legacy.legacy.legacy.calls,contests.outputs(t26)['calls']):raise ValueError('retained T26 differs')
            t25=json.loads((ROOT/t26['actions']['source']['t25_record']).read_text())
            if not placement.same_json(recorder.legacy.legacy.legacy.legacy.legacy.legacy.calls,contests.outputs(t25)['calls']):raise ValueError('retained T25 differs')
            t23=json.loads((ROOT/t25['actions']['source']['t23_record']).read_text())
            if not placement.same_json(recorder.legacy.legacy.legacy.legacy.legacy.legacy.legacy.calls,contests.outputs(t23)['calls']):raise ValueError('retained T23 differs')
            t22=json.loads((ROOT/t23['actions']['source']['t22_record']).read_text())
            if not placement.same_json(recorder.legacy.legacy.legacy.legacy.legacy.legacy.legacy.legacy.calls,contests.outputs(t22)['calls']):raise ValueError('retained T22 differs')
            t20=json.loads((ROOT/t22['actions']['source']['t20_record']).read_text())
            if not placement.same_json(recorder.legacy.legacy.legacy.legacy.legacy.legacy.legacy.legacy.legacy.calls,contests.outputs(t20)['calls']) or not placement.same_json(recorder.legacy.legacy.legacy.legacy.legacy.legacy.legacy.legacy.legacy.ledger,contests.outputs(t20)['ledger']):raise ValueError('retained T20 differs')
            t16=next(b for m,p,sc,x,b,pre in arr.reb.rep.ai.sub.sources() if m['record']==t22['actions']['source']['t20_record'])
            if not placement.same_json(recorder.legacy.legacy.legacy.legacy.legacy.legacy.legacy.legacy.legacy.tail.calls,contests.outputs(t16)['calls']):raise ValueError('retained T16 differs')
            source = t16['actions']['source']; trace = contests.events(ROOT/source['trace'])
            if week.events != trace[1:-1]:
                raise ValueError('new original week differs from T08')
            ok, lines = match.compare(week.events, source['start_state_sha256'], ROOT/source['t04_record_path'])
            if not ok:
                raise ValueError('ordered DOSBox-X comparison failed')
            rows = cases_for(recorder.calls, contests.outputs(base)['calls'], meta['week'])
        except (Exception, KeyboardInterrupt) as exc:
            status = f'aborted: {type(exc).__name__}: {exc}'
        n = max(match.next_number(RUNS, 'T33-r*.json'), match.next_number(FIXTURES, 'T33-r*.jsonl'))
        rid = f'T33-r{n:04d}'; fixture = FIXTURES/(rid+'.jsonl'); placement.write_lines(fixture, rows)
        rec = copy.deepcopy(base)
        rec.update(run_id=rid, experiment='T33', arm='role_scoring', rep=n, code_commit=commit,
                   machine=cycle.machine_id(), started=started, ended=match.utc(), status=status,
                   actions={'script': 'runtime/emul/role_scoring.py',
                            'source': {'t31_record': meta['record'], 't31_record_sha256': meta['record_sha256'], 't31_cases_sha256': meta['cases_sha256']},
                            'game_files': {name: hashlib.sha256(b).hexdigest() for name, b in week.files_at_start.items()}},
                   outputs=[{'name': 'calls', 'value': recorder.calls}],
                   observations=[{'step': 0, 'source': 'file', 'field': 'fixture path', 'value': match.rel(fixture)},
                                 {'step': 0, 'source': 'file', 'field': 'fixture sha256', 'value': contests.sha(fixture)},
                                 {'step': 1, 'source': 'log', 'field': 'ordered DOSBox-X comparison', 'value': '\n'.join(lines)}])
        rec['runtime'] = {'harness': f'runtime/emul/role_scoring.py@{commit}', 'unicorn': unicorn.__version__,
                          'python': platform.python_version(), 'dos_clock': week.g.clock,
                          'settings': {k: getattr(guest, k) for k in ('INSTR_PER_S', 'KEY_HOLD', 'PIT_HZ', 'SLICE_MAX')}}
        rec['interventions'] = [{'level': 'I3', 'what': 'guest.py services and read-only role_scoring hooks'}]
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
        if tuple(index[k] for k in ('weeks','calls','draws'))!=(1,8,0):raise ValueError('incomplete role-scoring corpus')
        if not placement.same_json(index,json.loads((FIXTURES/'index.json').read_text())):raise ValueError('role-scoring manifest differs')
    except (ValueError,OSError,KeyError,IndexError,TypeError) as exc:
        print(f'role-scoring check: FAIL: {exc}');return 1
    print('role-scoring check: ok (8 calls,complete nested observations,zero draws)');return 0


if __name__=='__main__':raise SystemExit(main())
