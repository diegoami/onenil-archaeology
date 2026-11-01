#!/usr/bin/env python3
"""T34: original3155 position inputs and literal scene-store continuations."""
import argparse
import copy
import hashlib
import json
import platform

import role_scoring as prior

ROOT=prior.ROOT
RUNS,FIXTURES=ROOT/'runs/T34',ROOT/'traces/T34'
raw,contests,match,placement,arr=prior.raw,prior.contests,prior.match,prior.placement,prior.arr
cache=prior.prior
STATIC=('static/1-0-exe/code/seg_0AB9_05.asm','static/1-0-exe/code/seg_0AB9_02.asm')
BRANCHES=('0AB9:3223','0AB9:3235')


def players(s):return s['context']['context']['rebuild']['outer']['players']
def scenes(s):return cache.rows(s['context'])
def offsets(s):return s['context']['context']['rebuild']['outer']['selection']['side_offsets']


def snapshot(g):
    s={'context':cache.snapshot(g),'signs':[g.rd(0xA338+i,1) for i in range(2)]}
    codes=sorted({p['p8_6'] for p in players(s)})
    s['positions']=[{'position':p,'word':g.rd(0xA3A+2*p)} for p in codes]
    return s


def validate_state(s):
    raw.keys(s,'context signs positions');cache.validate_state(s['context']);raw.vector(s['signs'],2,255)
    codes=sorted({p['p8_6'] for p in players(s)})
    if [v['position'] for v in s['positions']]!=codes:raise ValueError('complete ordered position cells required')
    for v in s['positions']:
        raw.keys(v,'position word');raw.integer(v['position'],0,255);raw.integer(v['word'])


def pointer(g,index):
    raw.integer(index,1,22)
    if (arr.local(g,-12),arr.local(g,-10))!=(0xCCEF+25*index,g.DS):raise ValueError('position scene pointer differs')


class Recorder:
    def __init__(self,week):
        self.week,self.legacy=week,prior.Recorder(week)
        self.outer=self.legacy.legacy.outer
        self.calls=[];self.pending=self.frame=self.visit=None
        week.g.code_hook('0AB9:198E',self.enter);week.g.code_hook('0AB9:1991',self.leave)
        week.g.code_hook('0AB9:31A1',self.start);week.g.code_hook('0AB9:31D3',self.base)
        week.g.code_hook('0AB9:3243',self.finish)
        for site in BRANCHES:week.g.code_hook(site,lambda g,site=site:self.branch(g,site))
    def enter(self,g):
        parent=self.outer.pending
        if parent is None or g.reg('bp')!=self.outer.frame:return
        if self.pending is not None:raise ValueError('nested position assignment')
        self.pending={k:copy.deepcopy(parent[k]) for k in ('step','replacement','arguments')}
        self.pending.update(event=len(parent['events']),input=snapshot(g),draw_start=self.week.draws,visits=[])
    def start(self,g):
        if self.pending is None:return
        if self.frame is None:self.frame=g.reg('bp')
        if g.reg('bp')!=self.frame:return
        if self.visit is not None:raise ValueError('unfinished position visit')
        side,index=arr.local(g,-1,1),arr.local(g,-4)
        slot=index-g.rd(0xD56+side,1)
        raw.integer(side,0,1);raw.integer(slot,1,11)
        previous=0 if slot==1 else arr.local(g,-6)
        self.visit={'side':side,'slot':slot,'scene':index,'previous':previous,
                    'input':cache.scene(g,index),'previous_input':cache.scene(g,previous) if previous else None,
                    'draw_start':self.week.draws,'branch':None}
        self.visit['player']=self.visit['input']['word14']
    def base(self,g):
        if self.pending is None or g.reg('bp')!=self.frame:return
        if self.visit is None or 'base' in self.visit:raise ValueError('position base store lacks visit')
        v=self.visit;pointer(g,v['scene'])
        position=arr.reb.far_value(g,0xD7BA,8*v['player']+6,1)
        v.update(table={'position':position,'word':g.rd(0xA3A+2*position)},base=cache.scene(g,v['scene']))
    def branch(self,g,site):
        if self.pending is None or g.reg('bp')!=self.frame:return
        if self.visit is None or 'base' not in self.visit or self.visit['branch'] is not None:raise ValueError('position adjustment lacks base store')
        self.visit['branch']=site
    def finish(self,g):
        if self.pending is None or g.reg('bp')!=self.frame:return
        if self.visit is None or 'base' not in self.visit:raise ValueError('position visit lacks base store')
        v=self.visit;pointer(g,v['scene'])
        if v['previous'] and arr.local(g,-6)!=v['previous']:raise ValueError('previous scene local changed')
        v.update(output=cache.scene(g,v['scene']),previous_output=cache.scene(g,v['previous']) if v['previous'] else None,
                 draw_end=self.week.draws)
        self.pending['visits'].append(v);self.visit=None
    def leave(self,g):
        if self.pending is None or g.reg('bp')!=self.outer.frame:return
        if self.visit is not None or self.frame is None:raise ValueError('unfinished position assignment')
        self.pending.update(output=snapshot(g),draw_end=self.week.draws)
        self.calls.append(self.pending);self.pending=self.frame=None


def word_only(before,after):
    arr.reb.validate_row(before);arr.reb.validate_row(after)
    clean=copy.deepcopy(after);clean['word10']=before['word10']
    if clean!=before:raise ValueError('unrelated position scene write')


def validate_case(c):
    raw.keys(c,'step replacement arguments event input draw_start visits output draw_end')
    for k in ('step','replacement','event'):raw.integer(c[k],0,10**9)
    raw.vector(c['arguments'],3,65535)
    for k in ('input','output'):validate_state(c[k])
    prior.interval(c,c['draw_start'],c['draw_end'])
    state=copy.deepcopy(c['input']);cursor=c['draw_start']
    expected=[(side,slot) for side in range(2) for slot in range(1,12)]
    if not isinstance(c['visits'],list) or [(v['side'],v['slot']) for v in c['visits']]!=expected:raise ValueError('position visit order/coverage differs')
    for v in c['visits']:
        raw.keys(v,'side slot scene previous input previous_input draw_start branch player table base output previous_output draw_end')
        for k,lo,hi in (('side',0,1),('slot',1,11),('scene',1,22),('previous',0,22),('player',0,3920)):raw.integer(v[k],lo,hi)
        prior.interval(v,cursor,c['draw_end']);cursor=v['draw_end']
        index=offsets(state)[v['side']]+v['slot'];previous=index-1 if v['slot']>1 else 0
        if (v['scene'],v['previous'])!=(index,previous):raise ValueError('position/previous scene identity differs')
        if v['input']!=scenes(state)[index-1] or v['player']!=v['input']['word14']:raise ValueError('position player/input continuation differs')
        if v['previous_input']!=(scenes(state)[previous-1] if previous else None):raise ValueError('previous scene continuation differs')
        word_only(v['input'],v['base']);word_only(v['base'],v['output'])
        raw.keys(v['table'],'position word');raw.integer(v['table']['position'],0,255);raw.integer(v['table']['word'])
        p=next(p for p in players(state) if p['id']==v['player'])
        table=next(t for t in state['positions'] if t['position']==p['p8_6'])
        if v['table']!=table or v['base']['word10']!=table['word']:raise ValueError('literal position-table store differs')
        branch=v['branch']
        if branch is not None and branch not in BRANCHES:raise ValueError('unknown position adjustment branch')
        duplicate=previous!=0 and v['base']['word10']==v['previous_input']['word10']
        if duplicate!=(branch is not None):raise ValueError('duplicate position branch differs')
        if previous:
            word_only(v['previous_input'],v['previous_output'])
            if branch is None and v['previous_output']!=v['previous_input']:raise ValueError('unadjusted previous scene changed')
            if branch is not None:
                # Byte write whitelists only, never evaluate the coordinate arithmetic.
                mask=255 if branch==BRANCHES[0] else 65280
                if (v['previous_input']['word10']&mask)!=(v['previous_output']['word10']&mask):raise ValueError('wrong previous coordinate byte changed')
            scenes(state)[previous-1]=copy.deepcopy(v['previous_output'])
        elif v['previous_output'] is not None:raise ValueError('first visit has previous output')
        if branch is None and v['output']!=v['base']:raise ValueError('unadjusted current scene changed')
        if branch is not None and (v['base']['word10']&65280)!=(v['output']['word10']&65280):raise ValueError('wrong current coordinate byte changed')
        scenes(state)[index-1]=copy.deepcopy(v['output'])
    if state!=c['output']:raise ValueError('final position continuation/unrelated writes differ')


def retained(base):
    r=base
    for key in ('t31_record','t30_record','t29_record','t28_record'):
        r=json.loads((ROOT/r['actions']['source'][key]).read_text())
    return contests.outputs(r)['calls']


def cases_for(calls,base,week):
    try:
        parents=retained(base)
        t31=json.loads((ROOT/base['actions']['source']['t31_record']).read_text())
        cache_calls=contests.outputs(t31)['calls']
        if len(calls)!=len(parents) or len(cache_calls)!=len(parents):raise ValueError('missing/extra position boundaries')
        result=[]
        for c,parent,cache_call in zip(calls,parents,cache_calls):
            validate_case(c)
            if c['input']['context']!=cache_call['output']:raise ValueError('position input differs from final T31 cache state')
            events=[(i,e) for i,e in enumerate(parent['events']) if e['site']=='0AB9:198E']
            if len(events)!=1:raise ValueError('one retained position boundary required')
            i,e=events[0]
            if any(c[k]!=parent[k] for k in ('step','replacement','arguments')) or c['event']!=i:raise ValueError('position boundary order/identity differs')
            for k in ('input','output'):
                if c[k]['context']['context']!=e[k]:raise ValueError('position boundary differs from T28')
            if (c['draw_start'],c['draw_end'])!=(e['draw_start'],e['draw_end']):raise ValueError('position root interval differs')
            result.append({'schema':'scene-positions-case/1','week':week,**c})
        return result
    except (KeyError,IndexError,TypeError,AttributeError,StopIteration) as exc:raise ValueError(f'incomplete position fields: {exc}') from exc


def sources():
    index=prior.build_index()
    if not placement.same_json(index,json.loads((prior.FIXTURES/'index.json').read_text())):raise ValueError('retained T33 manifest differs')
    for meta in index['records']:yield meta,json.loads((ROOT/meta['record']).read_text())


def selected_runs():
    result={}
    for p in sorted(RUNS.glob('T34-r*.json')):
        r=json.loads(p.read_text())
        if r['status']=='completed':
            key=r['actions']['source']['t33_record']
            if key in result:raise ValueError('duplicate completed scene-positions week')
            result[key]=p,r
    return result


def build_index():
    inputs=list(sources());chosen=selected_runs();records=[]
    if set(chosen)!={m['record'] for m,_ in inputs}:raise ValueError('missing/extra scene-positions week')
    for meta,base in inputs:
        path,r=chosen[meta['record']]
        expected={'t33_record':meta['record'],'t33_record_sha256':meta['record_sha256'],'t33_cases_sha256':meta['cases_sha256']}
        if r['actions']['source']!=expected:raise ValueError('scene-positions provenance differs')
        if r['start_state']!=base['start_state'] or r['actions']['game_files']!=base['actions']['game_files']:raise ValueError('original state/game differs')
        cases=cases_for(contests.outputs(r)['calls'],base,meta['week'])
        obs={o['field']:o['value'] for o in r['observations']};fixture=ROOT/obs['fixture path']
        if fixture.parent!=FIXTURES or contests.sha(fixture)!=obs['fixture sha256'] or not placement.same_json(contests.events(fixture),cases):raise ValueError('scene-positions fixture differs')
        records.append({'record':match.rel(path),'record_sha256':contests.sha(path),'cases':fixture.name,
                        'cases_sha256':contests.sha(fixture),'week':meta['week'],'calls':len(cases),
                        'visits':sum(len(c['visits']) for c in cases),
                        'branches':{str(kind):sum(v['branch']==kind for c in cases for v in c['visits']) for kind in (None,*BRANCHES)},
                        'draws':sum(c['draw_end']-c['draw_start'] for c in cases),'producer_commit':r['code_commit']})
    return {'schema':'scene-positions-corpus/1','records':records,'weeks':len(records),
            'calls':sum(r['calls'] for r in records),'draws':sum(r['draws'] for r in records),
            't33_index_sha256':contests.sha(prior.FIXTURES/'index.json'),
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
                raise ValueError('incomplete capture or retained T33 differs')
            t31=json.loads((ROOT/base['actions']['source']['t31_record']).read_text())
            if not placement.same_json(recorder.legacy.legacy.calls,contests.outputs(t31)['calls']):raise ValueError('retained T31 differs')
            t30=json.loads((ROOT/t31['actions']['source']['t30_record']).read_text())
            if not placement.same_json(recorder.legacy.legacy.legacy.calls,contests.outputs(t30)['calls']):raise ValueError('retained T30 differs')
            t29=json.loads((ROOT/t30['actions']['source']['t29_record']).read_text())
            if not placement.same_json(recorder.legacy.legacy.legacy.legacy.calls,contests.outputs(t29)['calls']):raise ValueError('retained T29 differs')
            t28=json.loads((ROOT/t29['actions']['source']['t28_record']).read_text())
            if not placement.same_json(recorder.legacy.legacy.legacy.legacy.legacy.calls,contests.outputs(t28)['calls']):raise ValueError('retained T28 differs')
            t26=json.loads((ROOT/t28['actions']['source']['t26_record']).read_text())
            if not placement.same_json(recorder.legacy.legacy.legacy.legacy.legacy.legacy.calls,contests.outputs(t26)['calls']):raise ValueError('retained T26 differs')
            t25=json.loads((ROOT/t26['actions']['source']['t25_record']).read_text())
            if not placement.same_json(recorder.legacy.legacy.legacy.legacy.legacy.legacy.legacy.calls,contests.outputs(t25)['calls']):raise ValueError('retained T25 differs')
            t23=json.loads((ROOT/t25['actions']['source']['t23_record']).read_text())
            if not placement.same_json(recorder.legacy.legacy.legacy.legacy.legacy.legacy.legacy.legacy.calls,contests.outputs(t23)['calls']):raise ValueError('retained T23 differs')
            t22=json.loads((ROOT/t23['actions']['source']['t22_record']).read_text())
            if not placement.same_json(recorder.legacy.legacy.legacy.legacy.legacy.legacy.legacy.legacy.legacy.calls,contests.outputs(t22)['calls']):raise ValueError('retained T22 differs')
            t20=json.loads((ROOT/t22['actions']['source']['t20_record']).read_text())
            if not placement.same_json(recorder.legacy.legacy.legacy.legacy.legacy.legacy.legacy.legacy.legacy.legacy.calls,contests.outputs(t20)['calls']) or not placement.same_json(recorder.legacy.legacy.legacy.legacy.legacy.legacy.legacy.legacy.legacy.legacy.ledger,contests.outputs(t20)['ledger']):raise ValueError('retained T20 differs')
            t16=next(b for m,p,sc,x,b,pre in arr.reb.rep.ai.sub.sources() if m['record']==t22['actions']['source']['t20_record'])
            if not placement.same_json(recorder.legacy.legacy.legacy.legacy.legacy.legacy.legacy.legacy.legacy.legacy.tail.calls,contests.outputs(t16)['calls']):raise ValueError('retained T16 differs')
            source = t16['actions']['source']; trace = contests.events(ROOT/source['trace'])
            if week.events != trace[1:-1]:
                raise ValueError('new original week differs from T08')
            ok, lines = match.compare(week.events, source['start_state_sha256'], ROOT/source['t04_record_path'])
            if not ok:
                raise ValueError('ordered DOSBox-X comparison failed')
            rows = cases_for(recorder.calls, base, meta['week'])
        except (Exception, KeyboardInterrupt) as exc:
            status = f'aborted: {type(exc).__name__}: {exc}'
        n = max(match.next_number(RUNS, 'T34-r*.json'), match.next_number(FIXTURES, 'T34-r*.jsonl'))
        rid = f'T34-r{n:04d}'; fixture = FIXTURES/(rid+'.jsonl'); placement.write_lines(fixture, rows)
        rec = copy.deepcopy(base)
        rec.update(run_id=rid, experiment='T34', arm='scene_positions', rep=n, code_commit=commit,
                   machine=cycle.machine_id(), started=started, ended=match.utc(), status=status,
                   actions={'script': 'runtime/emul/scene_positions.py',
                            'source': {'t33_record': meta['record'], 't33_record_sha256': meta['record_sha256'], 't33_cases_sha256': meta['cases_sha256']},
                            'game_files': {name: hashlib.sha256(b).hexdigest() for name, b in week.files_at_start.items()}},
                   outputs=[{'name': 'calls', 'value': recorder.calls}],
                   observations=[{'step': 0, 'source': 'file', 'field': 'fixture path', 'value': match.rel(fixture)},
                                 {'step': 0, 'source': 'file', 'field': 'fixture sha256', 'value': contests.sha(fixture)},
                                 {'step': 1, 'source': 'log', 'field': 'ordered DOSBox-X comparison', 'value': '\n'.join(lines)}])
        rec['runtime'] = {'harness': f'runtime/emul/scene_positions.py@{commit}', 'unicorn': unicorn.__version__,
                          'python': platform.python_version(), 'dos_clock': week.g.clock,
                          'settings': {k: getattr(guest, k) for k in ('INSTR_PER_S', 'KEY_HOLD', 'PIT_HZ', 'SLICE_MAX')}}
        rec['interventions'] = [{'level': 'I3', 'what': 'guest.py services and read-only scene_positions hooks'}]
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
        if tuple(index[k] for k in ('weeks','calls','draws'))!=(1,2,0):raise ValueError('incomplete scene-positions corpus')
        if not placement.same_json(index,json.loads((FIXTURES/'index.json').read_text())):raise ValueError('scene-positions manifest differs')
    except (ValueError,OSError,KeyError,IndexError,TypeError) as exc:
        print(f'scene-positions check: FAIL: {exc}');return 1
    print('scene-positions check: ok (2 calls,44 scene visits,zero draws)');return 0


if __name__=='__main__':raise SystemExit(main())
