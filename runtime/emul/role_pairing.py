#!/usr/bin/env python3
"""T29: observe original 10B9 inputs and local range boundaries, never compute pairings."""
import argparse
import copy
import hashlib
import json
import platform

import rearrangement as prior

ROOT=prior.ROOT
RUNS,FIXTURES=ROOT/'runs/T29',ROOT/'traces/T29'
raw,contests,match,placement=prior.raw,prior.contests,prior.match,prior.placement
RANGES={
 '0AB9:12AD':('0AB9:12B0',12,13),
 '0AB9:12B5':('0AB9:12B8',9,11),
 '0AB9:12BD':('0AB9:12C0',5,8),
 '0AB9:12C5':('0AB9:12C8',1,1),
 '0AB9:12CD':('0AB9:12D0',2,4),
}
STATIC=('static/1-0-exe/code/seg_0AB9_02.asm','static/1-0-exe/code/seg_0AB9_03.asm',
        'static/1-0-exe/code/seg_1B55_08.asm','static/1-0-exe/code/seg_24BC_01.asm',
        'static/1-0-exe/code/seg_26C9_02.asm')


def snapshot(g):
    state=prior.snapshot(g)
    clubs=state['rebuild']['outer']['selection']['managed_clubs']
    return {'context':state,
            'club_flags':[{'id':i,'byte57':prior.reb.far_value(g,0xD7C2,62*(i-1)+57,1)} for i in clubs],
            'preferences':[{'pass':p,'roles':[g.rd(0x9B0+14*p+r,1) for r in range(1,14)]} for p in range(1,5)]}


def validate_state(s):
    raw.keys(s,'context club_flags preferences');prior.validate_state(s['context'])
    ids=s['context']['rebuild']['outer']['selection']['managed_clubs']
    if not isinstance(s['club_flags'],list) or [v['id'] for v in s['club_flags']]!=ids:
        raise ValueError('complete ordered club flags required')
    for c in s['club_flags']:
        raw.keys(c,'id byte57');raw.integer(c['id'],1,176);raw.integer(c['byte57'],0,255)
    if not isinstance(s['preferences'],list) or [v['pass'] for v in s['preferences']]!=[1,2,3,4]:
        raise ValueError('complete ordered preference passes required')
    for p in s['preferences']:
        raw.keys(p,'pass roles');raw.integer(p['pass'],1,4);raw.vector(p['roles'],13,255)


def locals_at(g):
    return {k:[prior.local(g,base+i,1) for i in range(1,12)]
            for k,base in (('own',-0x11),('opponent',-0x1D),('assigned',-0x29))}


def validate_locals(s):
    raw.keys(s,'own opponent assigned')
    for k in ('own','opponent'):raw.vector(s[k],11,255)
    raw.vector(s['assigned'],11,11)
    if 1 in s['assigned']:raise ValueError('assignment cannot select the keeper slot')
    if s['own'][0]!=10 or s['opponent'][0]!=10 or s['assigned'][0]!=0:
        raise ValueError('Pascal length/assignment sentinel differs')


class Recorder:
    def __init__(self,week):
        self.week,self.legacy=week,prior.Recorder(week)
        self.calls=[];self.pending=self.event=self.frame=None
        week.g.code_hook('0AB9:1985',self.enter);week.g.code_hook('0AB9:1988',self.leave)
        for site,(end,_,_) in RANGES.items():
            week.g.code_hook(site,lambda g,site=site:self.start(g,site))
            week.g.code_hook(end,lambda g,site=site:self.end(g,site))
    def enter(self,g):
        parent=self.legacy.pending
        if parent is None or g.reg('bp')!=self.legacy.frame:return
        if self.pending is not None:raise ValueError('nested role pairing')
        self.frame=None
        self.pending={k:copy.deepcopy(parent[k]) for k in ('step','replacement','arguments')}
        self.pending.update(input=snapshot(g),draw_start=self.week.draws,ranges=[])
    def start(self,g,site):
        if self.pending is None:return
        if self.frame is None:self.frame=g.reg('bp')
        if g.reg('bp')!=self.frame:return
        if self.event is not None:raise ValueError('nested role range')
        if g.stack_word(0)!=g.reg('bp'):raise ValueError('range parent frame differs')
        self.event={'site':site,'arguments':[prior.local(g,-5,1),g.stack_word(4),g.stack_word(2)],
                    'input':locals_at(g),'draw_start':self.week.draws}
    def end(self,g,site):
        if self.pending is None or self.event is None or self.event['site']!=site:return
        if g.reg('bp')!=self.frame:return
        self.event.update(output=locals_at(g),draw_end=self.week.draws,result=None)
        self.pending['ranges'].append(self.event);self.event=None
    def leave(self,g):
        if self.pending is None:return
        if g.reg('bp')!=self.legacy.frame:return
        if self.event is not None:raise ValueError('unfinished role range')
        self.pending.update(output=snapshot(g),draw_end=self.week.draws)
        self.calls.append(self.pending);self.pending=None


def validate_ranges(c):
    events=c['ranges']
    expected=[(site,side,lo,hi) for side in range(2) for site,(_,lo,hi) in RANGES.items()]
    if not isinstance(events,list) or len(events)!=len(expected):raise ValueError('ten ordered ranges required')
    cursor=c['draw_start'];previous=None
    for e,(site,side,lo,hi) in zip(events,expected):
        raw.keys(e,'site arguments input draw_start output draw_end result')
        raw.vector(e['arguments'],3,65535)
        if e['site']!=site or e['arguments']!=[side,lo,hi]:raise ValueError('range order/arguments differ')
        for k in ('input','output'):validate_locals(e[k])
        for k in ('own','opponent'):
            if any(b not in (a,0) for a,b in zip(e['input'][k],e['output'][k])):
                raise ValueError('range helper can only clear role cells')
        if any(a and not b for a,b in zip(e['input']['assigned'],e['output']['assigned'])):
            raise ValueError('range helper cleared an assignment')
        for k in ('draw_start','draw_end'):raw.integer(e[k],0,10**9)
        if not cursor<=e['draw_start']<=e['draw_end']<=c['draw_end']:raise ValueError('range draw continuation differs')
        cursor=e['draw_end']
        if e['result'] is not None:raise ValueError('void range has scalar result')
        if site==next(iter(RANGES)):
            if any(e['input']['assigned']):raise ValueError('assignment locals not initialized')
        elif previous['output']!=e['input']:raise ValueError('range local continuation differs')
        previous=e


def cases_for(calls,retained,week):
    try:
        if len(calls)!=len(retained):raise ValueError('missing/extra pairing cases')
        rows=[]
        for c,base in zip(calls,retained):
            raw.keys(c,'step replacement arguments input draw_start ranges output draw_end')
            for k in ('step','replacement','draw_start','draw_end'):raw.integer(c[k],0,10**9)
            raw.vector(c['arguments'],3,65535)
            if any(c[k]!=base[k] for k in ('step','replacement','arguments')):raise ValueError('pairing case order/arguments differ')
            tail=[e for e in base['events'] if e['site']=='0AB9:1985']
            if len(tail)!=1:raise ValueError('one retained first tail required')
            e=tail[0]
            if (c['draw_start'],c['draw_end'])!=(e['draw_start'],e['draw_end']):raise ValueError('pairing interval differs')
            for k in ('input','output'):
                validate_state(c[k])
                if c[k]['context']!=e[k]:raise ValueError('pairing boundary differs from T28')
            clean=copy.deepcopy(c['output'])
            for a,b in zip(clean['context']['rebuild']['outer']['scenes'],c['input']['context']['rebuild']['outer']['scenes']):
                a['word20']=b['word20']
            if clean!=c['input']:raise ValueError('pairing changed unrelated logical state')
            validate_ranges(c);rows.append({'schema':'role-pairing-case/1','week':week,**c})
        return rows
    except (KeyError,IndexError,TypeError,AttributeError) as exc:raise ValueError(f'incomplete pairing fields: {exc}') from exc


def sources():
    index=prior.build_index()
    if not placement.same_json(index,json.loads((prior.FIXTURES/'index.json').read_text())):raise ValueError('retained T28 manifest differs')
    for meta in index['records']:yield meta,json.loads((ROOT/meta['record']).read_text())


def selected_runs():
    result={}
    for p in sorted(RUNS.glob('T29-r*.json')):
        r=json.loads(p.read_text())
        if r['status']=='completed':
            key=r['actions']['source']['t28_record']
            if key in result:raise ValueError('duplicate completed pairing week')
            result[key]=p,r
    return result


def build_index():
    inputs=list(sources());chosen=selected_runs();records=[]
    if set(chosen)!={m['record'] for m,_ in inputs}:raise ValueError('missing/extra pairing week')
    for meta,base in inputs:
        path,r=chosen[meta['record']]
        expected={'t28_record':meta['record'],'t28_record_sha256':meta['record_sha256'],'t28_cases_sha256':meta['cases_sha256']}
        if r['actions']['source']!=expected:raise ValueError('pairing provenance differs')
        if r['start_state']!=base['start_state'] or r['actions']['game_files']!=base['actions']['game_files']:raise ValueError('original state/game differs')
        rows=cases_for(contests.outputs(r)['calls'],contests.outputs(base)['calls'],meta['week'])
        obs={o['field']:o['value'] for o in r['observations']};fixture=ROOT/obs['fixture path']
        if fixture.parent!=FIXTURES or contests.sha(fixture)!=obs['fixture sha256'] or not placement.same_json(contests.events(fixture),rows):raise ValueError('pairing fixture differs')
        records.append({'record':match.rel(path),'record_sha256':contests.sha(path),'cases':fixture.name,
                        'cases_sha256':contests.sha(fixture),'week':meta['week'],'calls':len(rows),
                        'ranges':sum(len(c['ranges']) for c in rows),'draws':sum(c['draw_end']-c['draw_start'] for c in rows),
                        'producer_commit':r['code_commit']})
    return {'schema':'role-pairing-corpus/1','records':records,'weeks':len(records),
            **{k:sum(r[k] for r in records) for k in ('calls','ranges','draws')},
            't28_index_sha256':contests.sha(prior.FIXTURES/'index.json'),
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
            week.play()
            if week.g.unsupported or recorder.pending is not None or not placement.same_json(recorder.legacy.calls, contests.outputs(base)['calls']):
                raise ValueError('incomplete capture or retained T28 differs')
            t26=json.loads((ROOT/base['actions']['source']['t26_record']).read_text())
            if not placement.same_json(recorder.legacy.legacy.calls,contests.outputs(t26)['calls']):raise ValueError('retained T26 differs')
            t25=json.loads((ROOT/t26['actions']['source']['t25_record']).read_text())
            if not placement.same_json(recorder.legacy.legacy.legacy.calls,contests.outputs(t25)['calls']):raise ValueError('retained T25 differs')
            t23=json.loads((ROOT/t25['actions']['source']['t23_record']).read_text())
            if not placement.same_json(recorder.legacy.legacy.legacy.legacy.calls,contests.outputs(t23)['calls']):raise ValueError('retained T23 differs')
            t22=json.loads((ROOT/t23['actions']['source']['t22_record']).read_text())
            if not placement.same_json(recorder.legacy.legacy.legacy.legacy.legacy.calls,contests.outputs(t22)['calls']):raise ValueError('retained T22 differs')
            t20=json.loads((ROOT/t22['actions']['source']['t20_record']).read_text())
            if not placement.same_json(recorder.legacy.legacy.legacy.legacy.legacy.legacy.calls,contests.outputs(t20)['calls']) or not placement.same_json(recorder.legacy.legacy.legacy.legacy.legacy.legacy.ledger,contests.outputs(t20)['ledger']):raise ValueError('retained T20 differs')
            t16=next(b for m,p,sc,x,b,pre in prior.reb.rep.ai.sub.sources() if m['record']==t22['actions']['source']['t20_record'])
            if not placement.same_json(recorder.legacy.legacy.legacy.legacy.legacy.legacy.tail.calls,contests.outputs(t16)['calls']):raise ValueError('retained T16 differs')
            source = t16['actions']['source']; trace = contests.events(ROOT/source['trace'])
            if week.events != trace[1:-1]:
                raise ValueError('new original week differs from T08')
            ok, lines = match.compare(week.events, source['start_state_sha256'], ROOT/source['t04_record_path'])
            if not ok:
                raise ValueError('ordered DOSBox-X comparison failed')
            rows = cases_for(recorder.calls, contests.outputs(base)['calls'], meta['week'])
        except (Exception, KeyboardInterrupt) as exc:
            status = f'aborted: {type(exc).__name__}: {exc}'
        n = max(match.next_number(RUNS, 'T29-r*.json'), match.next_number(FIXTURES, 'T29-r*.jsonl'))
        rid = f'T29-r{n:04d}'; fixture = FIXTURES/(rid+'.jsonl'); placement.write_lines(fixture, rows)
        rec = copy.deepcopy(base)
        rec.update(run_id=rid, experiment='T29', arm='role_pairing', rep=n, code_commit=commit,
                   machine=cycle.machine_id(), started=started, ended=match.utc(), status=status,
                   actions={'script': 'runtime/emul/role_pairing.py',
                            'source': {'t28_record': meta['record'], 't28_record_sha256': meta['record_sha256'], 't28_cases_sha256': meta['cases_sha256']},
                            'game_files': {name: hashlib.sha256(b).hexdigest() for name, b in week.files_at_start.items()}},
                   outputs=[{'name': 'calls', 'value': recorder.calls}],
                   observations=[{'step': 0, 'source': 'file', 'field': 'fixture path', 'value': match.rel(fixture)},
                                 {'step': 0, 'source': 'file', 'field': 'fixture sha256', 'value': contests.sha(fixture)},
                                 {'step': 1, 'source': 'log', 'field': 'ordered DOSBox-X comparison', 'value': '\n'.join(lines)}])
        rec['runtime'] = {'harness': f'runtime/emul/role_pairing.py@{commit}', 'unicorn': unicorn.__version__,
                          'python': platform.python_version(), 'dos_clock': week.g.clock,
                          'settings': {k: getattr(guest, k) for k in ('INSTR_PER_S', 'KEY_HOLD', 'PIT_HZ', 'SLICE_MAX')}}
        rec['interventions'] = [{'level': 'I3', 'what': 'guest.py services and read-only role_pairing hooks'}]
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
        if tuple(index[k] for k in ('weeks','calls','ranges','draws'))!=(1,2,20,0):raise ValueError('incomplete pairing corpus')
        if not placement.same_json(index,json.loads((FIXTURES/'index.json').read_text())):raise ValueError('pairing manifest differs')
    except (ValueError,OSError,KeyError,IndexError,TypeError) as exc:
        print(f'role-pairing check: FAIL: {exc}');return 1
    print('role-pairing check: ok (2 original calls, 20 ranges, zero draws)');return 0


if __name__=='__main__':raise SystemExit(main())
