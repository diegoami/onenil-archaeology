#!/usr/bin/env python3
"""T30: observe original 03BB scene/cache code inputs and effects, not compute codes."""
import argparse
import copy
import hashlib
import json
import platform

import role_pairing as prior

ROOT=prior.ROOT
RUNS,FIXTURES=ROOT/'runs/T30',ROOT/'traces/T30'
raw,contests,match,placement=prior.raw,prior.contests,prior.match,prior.placement
arr=prior.prior
STATIC=('static/1-0-exe/code/seg_0AB9_01.asm','static/1-0-exe/code/seg_0AB9_03.asm')
SITES={'0AB9:03D4':('0AB9:03D7','scene'), '0AB9:03DD':('0AB9:03E0','cache'),
       '0AB9:0378':('0AB9:037B','code'), '0AB9:03B0':('0AB9:03B3','code')}


def cache_rows(g):
    return [{'index':i,**{f'word{off}':g.rd(0xCF2E+7*i+off,2) for off in (0,2,4)}} for i in range(3)]


def snapshot(g):
    return {'context':arr.snapshot(g),'mode':g.mem(g.far(0xD0C0),1)[0],
            'threshold':g.rd(0xD0AC,1),'clock':g.rd(0xD0AE,2),
            'direction_signs':[g.rd(0xA338+i,1) for i in range(2)],
            'codes':[g.rd(0x96A+i,1) for i in range(6)],
            'role_codes':[g.rd(0x8716+i,1) for i in range(14)],'cache':cache_rows(g)}


def validate_state(s):
    raw.keys(s,'context mode threshold clock direction_signs codes role_codes cache');arr.validate_state(s['context'])
    raw.integer(s['mode'],0,4);raw.integer(s['threshold'],0,255);raw.integer(s['clock'])
    if s['clock']!=s['context']['rebuild']['outer']['selection']['remaining']:raise ValueError('raw clock alias differs')
    raw.vector(s['direction_signs'],2,255);raw.vector(s['codes'],6,255);raw.vector(s['role_codes'],14,255)
    if not isinstance(s['cache'],list) or [c['index'] for c in s['cache']]!=[0,1,2]:raise ValueError('complete ordered code cache required')
    for c in s['cache']:
        raw.keys(c,'index word0 word2 word4');raw.integer(c['index'],0,2)
        for k in ('word0','word2','word4'):raw.integer(c[k])


def scene(g,index):return arr.reb.row(g,index)
def validate_scene(s):arr.reb.validate_row(s)
def scenes(s):return s['context']['rebuild']['outer']['scenes']


def target(g):
    offset,segment=g.stack_word(2),g.stack_word(4)
    n,rem=divmod(offset-0xCCEF,25)
    if segment!=g.DS or rem or not 1<=n<=22:raise ValueError('scene code pointer identity differs')
    return n


class Recorder:
    def __init__(self,week):
        self.week,self.legacy=week,prior.Recorder(week)
        self.calls=[];self.pending=self.event=self.child=self.frame=self.cache_frame=None
        week.g.code_hook('0AB9:1988',self.enter);week.g.code_hook('0AB9:198B',self.leave)
        for site,(end,_) in SITES.items():
            week.g.code_hook(site,lambda g,site=site:self.start(g,site))
            week.g.code_hook(end,lambda g,site=site:self.end(g,site))
    def enter(self,g):
        parent=self.legacy.legacy.pending
        if parent is None or g.reg('bp')!=self.legacy.legacy.frame:return
        if self.pending is not None:raise ValueError('nested scene code refresh')
        self.frame=self.cache_frame=None
        self.pending={k:copy.deepcopy(parent[k]) for k in ('step','replacement','arguments')}
        self.pending.update(input=snapshot(g),draw_start=self.week.draws,events=[])
    def start(self,g,site):
        if self.pending is None:return
        kind=SITES[site][1]
        if kind=='code':
            if self.event is None or self.event['kind']!='cache':return
            if self.cache_frame is None:self.cache_frame=g.reg('bp')
            if g.reg('bp')!=self.cache_frame:return
            if self.child is not None:raise ValueError('nested cache code')
            n=target(g)
            self.child={'site':site,'arguments':[n,g.stack_word(6),g.stack_word(8)],
                        'input':scene(g,n),'draw_start':self.week.draws}
            return
        if self.frame is None:self.frame=g.reg('bp')
        if g.reg('bp')!=self.frame:return
        if self.event is not None:raise ValueError('nested direct code helper')
        if kind=='scene':
            n=target(g)
            self.event={'site':site,'kind':kind,'arguments':[n],'input':scene(g,n),'draw_start':self.week.draws}
        else:
            self.event={'site':site,'kind':kind,'arguments':[],'input':snapshot(g),'draw_start':self.week.draws,'calls':[]}
    def end(self,g,site):
        if self.pending is None:return
        kind=SITES[site][1]
        if kind=='code':
            if self.child is None or self.child['site']!=site or g.reg('bp')!=self.cache_frame:return
            self.child.update(output=scene(g,self.child['arguments'][0]),result=g.reg('ax'),draw_end=self.week.draws)
            self.event['calls'].append(self.child);self.child=None
            return
        if self.event is None or self.event['site']!=site or g.reg('bp')!=self.frame:return
        if self.child is not None:raise ValueError('unfinished cache code')
        self.event.update(output=scene(g,self.event['arguments'][0]) if kind=='scene' else snapshot(g),
                          result=None,draw_end=self.week.draws)
        self.pending['events'].append(self.event);self.event=None
    def leave(self,g):
        if self.pending is None or g.reg('bp')!=self.legacy.legacy.frame:return
        if self.event is not None or self.child is not None:raise ValueError('unfinished scene code refresh')
        self.pending.update(output=snapshot(g),draw_end=self.week.draws)
        self.calls.append(self.pending);self.pending=None


def interval(e,lo,hi):
    for k in ('draw_start','draw_end'):raw.integer(e[k],0,10**9)
    if not lo<=e['draw_start']<=e['draw_end']<=hi:raise ValueError('code draw continuation differs')
    return e['draw_end']


def validate_cache(e):
    raw.keys(e,'site kind arguments input draw_start calls output result draw_end')
    raw.vector(e['arguments'],0,65535)
    for k in ('input','output'):validate_state(e[k])
    if e['result'] is not None:raise ValueError('void cache helper has scalar result')
    if not isinstance(e['calls'],list) or len(e['calls'])!=3:raise ValueError('three cache code calls required')
    cursor=e['draw_start'];state=copy.deepcopy(e['input']);selected=None
    for i,(h,site) in enumerate(zip(e['calls'],['0AB9:0378','0AB9:0378','0AB9:03B0'])):
        raw.keys(h,'site arguments input draw_start output result draw_end')
        raw.vector(h['arguments'],3,65535);index,a,b=h['arguments'];raw.integer(index,1,22)
        if h['site']!=site or [a,b]!=[e['input']['cache'][i]['word2'],e['input']['cache'][i]['word0']]:raise ValueError('cache packed argument order differs')
        if selected is not None and selected!=index:raise ValueError('cache keeper target continuation differs')
        selected=index
        for k in ('input','output'):validate_scene(h[k])
        if h['input']['index']!=index or h['output']['index']!=index or h['input']!=scenes(state)[index-1]:raise ValueError('cache scene continuation differs')
        clean=copy.deepcopy(h['output']);clean['byte6']=h['input']['byte6']
        if clean!=h['input']:raise ValueError('0143 changed an unrelated scene field')
        scenes(state)[index-1]=copy.deepcopy(h['output'])
        raw.integer(h['result']);cursor=interval(h,cursor,e['draw_end'])
    # Literal observed row writes and caller cache-word writes, never a code formula.
    for old,new in zip(state['cache'],e['output']['cache']):old['word4']=new['word4']
    if state!=e['output']:raise ValueError('cache refresh changed unrelated state')


def validate_events(c):
    events=c['events']
    if not isinstance(events,list) or len(events)!=23:raise ValueError('22 scenes and one cache helper required')
    state=copy.deepcopy(c['input']);cursor=c['draw_start']
    for index,e in enumerate(events[:22],1):
        raw.keys(e,'site kind arguments input draw_start output result draw_end')
        raw.vector(e['arguments'],1,22)
        if e['site']!='0AB9:03D4' or e['kind']!='scene' or e['arguments']!=[index]:raise ValueError('scene helper order/arguments differ')
        for k in ('input','output'):validate_scene(e[k])
        if e['input']!=scenes(state)[index-1] or e['output']['index']!=index:raise ValueError('scene helper continuation differs')
        clean=copy.deepcopy(e['output'])
        for k in ('byte4','byte5','byte6'):clean[k]=e['input'][k]
        if clean!=e['input']:raise ValueError('02D7 changed an unrelated scene field')
        if e['result'] is not None:raise ValueError('void scene helper has scalar result')
        scenes(state)[index-1]=copy.deepcopy(e['output']);cursor=interval(e,cursor,c['draw_end'])
    e=events[-1]
    if e['site']!='0AB9:03DD' or e['kind']!='cache':raise ValueError('missing/reordered cache helper')
    if e['input']!=state:raise ValueError('cache entry differs from observed scene writes')
    interval(e,cursor,c['draw_end']);validate_cache(e)
    if e['output']!=c['output']:raise ValueError('final code boundary continuation differs')


def cases_for(calls,retained,week):
    try:
        if len(calls)!=len(retained):raise ValueError('missing/extra code cases')
        rows=[]
        for c,base in zip(calls,retained):
            raw.keys(c,'step replacement arguments input draw_start events output draw_end')
            for k in ('step','replacement','draw_start','draw_end'):raw.integer(c[k],0,10**9)
            raw.vector(c['arguments'],3,65535)
            if any(c[k]!=base[k] for k in ('step','replacement','arguments')):raise ValueError('code case order/arguments differ')
            selected=[e for e in base['events'] if e['site']=='0AB9:1988']
            if len(selected)!=1:raise ValueError('one retained code refresh required')
            e=selected[0]
            if (c['draw_start'],c['draw_end'])!=(e['draw_start'],e['draw_end']):raise ValueError('code root interval differs')
            for k in ('input','output'):
                validate_state(c[k])
                if c[k]['context']!=e[k]:raise ValueError('code boundary differs from T28')
            validate_events(c);rows.append({'schema':'scene-codes-case/1','week':week,**c})
        return rows
    except (KeyError,IndexError,TypeError,AttributeError) as exc:raise ValueError(f'incomplete code fields: {exc}') from exc


def sources():
    index=prior.build_index()
    if not placement.same_json(index,json.loads((prior.FIXTURES/'index.json').read_text())):raise ValueError('retained T29 manifest differs')
    for meta in index['records']:yield meta,json.loads((ROOT/meta['record']).read_text())


def selected_runs():
    result={}
    for p in sorted(RUNS.glob('T30-r*.json')):
        r=json.loads(p.read_text())
        if r['status']=='completed':
            key=r['actions']['source']['t29_record']
            if key in result:raise ValueError('duplicate completed code week')
            result[key]=p,r
    return result


def build_index():
    inputs=list(sources());chosen=selected_runs();records=[]
    if set(chosen)!={m['record'] for m,_ in inputs}:raise ValueError('missing/extra code week')
    for meta,base in inputs:
        path,r=chosen[meta['record']]
        expected={'t29_record':meta['record'],'t29_record_sha256':meta['record_sha256'],'t29_cases_sha256':meta['cases_sha256']}
        if r['actions']['source']!=expected:raise ValueError('code provenance differs')
        if r['start_state']!=base['start_state'] or r['actions']['game_files']!=base['actions']['game_files']:raise ValueError('original state/game differs')
        t28=json.loads((ROOT/base['actions']['source']['t28_record']).read_text())
        rows=cases_for(contests.outputs(r)['calls'],contests.outputs(t28)['calls'],meta['week'])
        obs={o['field']:o['value'] for o in r['observations']};fixture=ROOT/obs['fixture path']
        if fixture.parent!=FIXTURES or contests.sha(fixture)!=obs['fixture sha256'] or not placement.same_json(contests.events(fixture),rows):raise ValueError('code fixture differs')
        records.append({'record':match.rel(path),'record_sha256':contests.sha(path),'cases':fixture.name,
                        'cases_sha256':contests.sha(fixture),'week':meta['week'],'calls':len(rows),
                        'scenes':sum(len(c['events'])-1 for c in rows),'cache':len(rows),
                        'codes':sum(len(c['events'][-1]['calls']) for c in rows),
                        'draws':sum(c['draw_end']-c['draw_start'] for c in rows),'producer_commit':r['code_commit']})
    return {'schema':'scene-codes-corpus/1','records':records,'weeks':len(records),
            **{k:sum(r[k] for r in records) for k in ('calls','scenes','cache','codes','draws')},
            't29_index_sha256':contests.sha(prior.FIXTURES/'index.json'),
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
                raise ValueError('incomplete capture or retained T29 differs')
            t28=json.loads((ROOT/base['actions']['source']['t28_record']).read_text())
            if not placement.same_json(recorder.legacy.legacy.calls,contests.outputs(t28)['calls']):raise ValueError('retained T28 differs')
            t26=json.loads((ROOT/t28['actions']['source']['t26_record']).read_text())
            if not placement.same_json(recorder.legacy.legacy.legacy.calls,contests.outputs(t26)['calls']):raise ValueError('retained T26 differs')
            t25=json.loads((ROOT/t26['actions']['source']['t25_record']).read_text())
            if not placement.same_json(recorder.legacy.legacy.legacy.legacy.calls,contests.outputs(t25)['calls']):raise ValueError('retained T25 differs')
            t23=json.loads((ROOT/t25['actions']['source']['t23_record']).read_text())
            if not placement.same_json(recorder.legacy.legacy.legacy.legacy.legacy.calls,contests.outputs(t23)['calls']):raise ValueError('retained T23 differs')
            t22=json.loads((ROOT/t23['actions']['source']['t22_record']).read_text())
            if not placement.same_json(recorder.legacy.legacy.legacy.legacy.legacy.legacy.calls,contests.outputs(t22)['calls']):raise ValueError('retained T22 differs')
            t20=json.loads((ROOT/t22['actions']['source']['t20_record']).read_text())
            if not placement.same_json(recorder.legacy.legacy.legacy.legacy.legacy.legacy.legacy.calls,contests.outputs(t20)['calls']) or not placement.same_json(recorder.legacy.legacy.legacy.legacy.legacy.legacy.legacy.ledger,contests.outputs(t20)['ledger']):raise ValueError('retained T20 differs')
            t16=next(b for m,p,sc,x,b,pre in arr.reb.rep.ai.sub.sources() if m['record']==t22['actions']['source']['t20_record'])
            if not placement.same_json(recorder.legacy.legacy.legacy.legacy.legacy.legacy.legacy.tail.calls,contests.outputs(t16)['calls']):raise ValueError('retained T16 differs')
            source = t16['actions']['source']; trace = contests.events(ROOT/source['trace'])
            if week.events != trace[1:-1]:
                raise ValueError('new original week differs from T08')
            ok, lines = match.compare(week.events, source['start_state_sha256'], ROOT/source['t04_record_path'])
            if not ok:
                raise ValueError('ordered DOSBox-X comparison failed')
            rows = cases_for(recorder.calls, contests.outputs(t28)['calls'], meta['week'])
        except (Exception, KeyboardInterrupt) as exc:
            status = f'aborted: {type(exc).__name__}: {exc}'
        n = max(match.next_number(RUNS, 'T30-r*.json'), match.next_number(FIXTURES, 'T30-r*.jsonl'))
        rid = f'T30-r{n:04d}'; fixture = FIXTURES/(rid+'.jsonl'); placement.write_lines(fixture, rows)
        rec = copy.deepcopy(base)
        rec.update(run_id=rid, experiment='T30', arm='scene_codes', rep=n, code_commit=commit,
                   machine=cycle.machine_id(), started=started, ended=match.utc(), status=status,
                   actions={'script': 'runtime/emul/scene_codes.py',
                            'source': {'t29_record': meta['record'], 't29_record_sha256': meta['record_sha256'], 't29_cases_sha256': meta['cases_sha256']},
                            'game_files': {name: hashlib.sha256(b).hexdigest() for name, b in week.files_at_start.items()}},
                   outputs=[{'name': 'calls', 'value': recorder.calls}],
                   observations=[{'step': 0, 'source': 'file', 'field': 'fixture path', 'value': match.rel(fixture)},
                                 {'step': 0, 'source': 'file', 'field': 'fixture sha256', 'value': contests.sha(fixture)},
                                 {'step': 1, 'source': 'log', 'field': 'ordered DOSBox-X comparison', 'value': '\n'.join(lines)}])
        rec['runtime'] = {'harness': f'runtime/emul/scene_codes.py@{commit}', 'unicorn': unicorn.__version__,
                          'python': platform.python_version(), 'dos_clock': week.g.clock,
                          'settings': {k: getattr(guest, k) for k in ('INSTR_PER_S', 'KEY_HOLD', 'PIT_HZ', 'SLICE_MAX')}}
        rec['interventions'] = [{'level': 'I3', 'what': 'guest.py services and read-only scene_codes hooks'}]
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
        if tuple(index[k] for k in ('weeks','calls','scenes','cache','codes','draws'))!=(1,2,44,2,6,0):raise ValueError('incomplete scene-code corpus')
        if not placement.same_json(index,json.loads((FIXTURES/'index.json').read_text())):raise ValueError('code manifest differs')
    except (ValueError,OSError,KeyError,IndexError,TypeError) as exc:
        print(f'scene-code check: FAIL: {exc}');return 1
    print('scene-code check: ok (2 calls,44 scenes,2 caches,6 nested codes,zero draws)');return 0


if __name__=='__main__':raise SystemExit(main())
