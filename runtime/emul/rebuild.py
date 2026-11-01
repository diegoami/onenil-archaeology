#!/usr/bin/env python3
"""T26: original scene rebuild and nested lookup observations, without an engine model."""
import argparse
import copy
import hashlib
import json
import platform

import replacement as rep
import contests
import extra_event as raw
import match
import placement

ROOT=contests.ROOT
RUNS,FIXTURES=ROOT/'runs/T26',ROOT/'traces/T26'
SITES={
 '0AB9:866F':('0AB9:8672','assign'),
 '0AB9:85AA':('0AB9:85AD','slot'),
 '0AB9:85B8':('0AB9:85BB','side'),
 '0AB9:85EC':('0AB9:85F1','club-count'),
 '0AB9:860A':('0AB9:860F','minimum32'),
 '0AB9:8653':('0AB9:8658','half'),
 '1B55:4F1F':('1B55:4F22','hand'),
 '1B55:4F3D':('1B55:4F40','hand'),
 '0AB9:8689':('0AB9:868C','keeper'),
 '0AB9:8696':('0AB9:8699','direction-side'),
 '0AB9:86AF':('0AB9:86B2','direction-side'),
}


def far_value(g,pointer,delta,n):
    offset=g.rd(pointer);segment=g.rd(pointer+2)
    return int.from_bytes(g.mem(segment*16+((offset+delta)&65535),n),'little')


def snapshot(g):
    outer=rep.snapshot(g)
    ids=sorted({p['p8_0'] for p in outer['players'] if p['id']})
    clubs=[]
    for identifier in ids:
        raw.integer(identifier,1,176)
        a=far_value(g,0xD7C2,(identifier-1)*62+40,2)
        b=far_value(g,0xD7C2,(identifier-1)*62+42,2)
        clubs.append({'id':identifier,'index40':a,'index42':b,
                      'cell40':far_value(g,0xDCC8,((a<<2)&65535)+2,1),
                      'cell42':far_value(g,0xDCC8,((b<<2)&65535)+2,1)})
    return {'outer':outer,'club_counts':clubs}


def validate_state(s):
    raw.keys(s,'outer club_counts'); rep.validate_state(s['outer'])
    ids=sorted({p['p8_0'] for p in s['outer']['players'] if p['id']})
    if [c['id'] for c in s['club_counts']]!=ids: raise ValueError('incomplete club-count input closure')
    for c in s['club_counts']:
        raw.keys(c,'id index40 index42 cell40 cell42');raw.integer(c['id'],1,176)
        for k in ('index40','index42'):raw.integer(c[k])
        for k in ('cell40','cell42'):raw.integer(c[k],0,255)


def row(g,scene):
    return {'index':scene,**{k:g.rd(0xCCEF+25*scene+off,n) for k,(off,n) in rep.SCENE.items()}}


def validate_row(r):
    raw.keys(r,'index '+' '.join(rep.SCENE));raw.integer(r['index'],1,22)
    for k,(_,n) in rep.SCENE.items():raw.integer(r[k],0,255 if n==1 else 65535)


def arguments(g,site,scene):
    w=g.stack_word;kind=SITES[site][1]
    if kind in ('assign','slot','side','direction-side'):
        if (w(2),w(4))!=(0xCCEF+25*scene,g.DS):raise ValueError('rebuild helper scene pointer differs')
        return [scene,w(6)] if kind=='assign' else [scene]
    if kind=='minimum32':return [w(0)|(w(2)<<16),w(4)|(w(6)<<16)]
    if kind=='hand':return [w(2)]  # explicit CS pushed before the near call to a far-returning helper
    return [w(0)]


class Recorder:
    def __init__(self,week):
        self.week,self.legacy=week,rep.Recorder(week)
        self.calls=[];self.pending=None;self.stack=[]
        week.g.code_hook('0AB9:AFAA',self.enter);week.g.code_hook('0AB9:AFAD',self.leave)
        for site,(end,_) in SITES.items():
            week.g.code_hook(site,lambda g,site=site:self.start(g,site))
            week.g.code_hook(end,lambda g,site=site:self.end(g,site))
    def enter(self,g):
        if self.legacy.pending is None:return
        if self.pending is not None or self.stack:raise ValueError('nested rebuild')
        scene=self.legacy.pending['arguments'][1]
        self.pending={'step':self.legacy.pending['step'],'replacement':len(self.legacy.calls),'scene':scene,
                      'input':snapshot(g),'draw_start':self.week.draws,'helpers':[]}
    def start(self,g,site):
        if self.pending is None:return
        scene=self.pending['scene']
        e={'site':site,'kind':SITES[site][1],'arguments':arguments(g,site,scene),
           'scene_input':row(g,scene),'draw_start':self.week.draws,'children':[]}
        (self.stack[-1]['children'] if self.stack else self.pending['helpers']).append(e)
        self.stack.append(e)
    def end(self,g,site):
        if self.pending is None or not self.stack or self.stack[-1]['site']!=site:return
        e=self.stack.pop();kind=e['kind']
        result=None if kind=='assign' else ((g.reg('dx')<<16)|g.reg('ax') if kind=='minimum32' else g.reg('ax')&(65535 if kind=='club-count' else 255))
        e.update(scene_output=row(g,self.pending['scene']),result=result,draw_end=self.week.draws)
    def leave(self,g):
        if self.pending is None:return
        if self.stack:raise ValueError('unfinished rebuild helper')
        self.pending.update(output=snapshot(g),draw_end=self.week.draws)
        self.calls.append(self.pending);self.pending=None


def flatten(events):
    for e in events:
        yield e
        yield from flatten(e['children'])


def validate_helpers(events,c,parent=None):
    cursor=c['draw_start'] if parent is None else parent['draw_start']
    end=c['draw_end'] if parent is None else parent['draw_end']
    allowed={'assign','keeper','direction-side'} if parent is None else {'slot','side','club-count','minimum32','half'} if parent['kind']=='assign' else {'hand'} if parent['kind']=='half' else set()
    prior=None
    for e in events:
        raw.keys(e,'site kind arguments scene_input draw_start children scene_output result draw_end')
        if e['site'] not in SITES or SITES[e['site']][1]!=e['kind'] or e['kind'] not in allowed:raise ValueError('unknown/reordered rebuild helper nesting')
        for k in ('scene_input','scene_output'):validate_row(e[k])
        if e['scene_input']['index']!=c['scene'] or e['scene_output']['index']!=c['scene']:raise ValueError('helper scene differs')
        for k in ('draw_start','draw_end'):raw.integer(e[k],0,10**9)
        if not cursor<=e['draw_start']<=e['draw_end']<=end:raise ValueError('rebuild helper draw continuation differs')
        cursor=e['draw_end'];kind=e['kind'];args=e['arguments']
        raw.vector(args,2 if kind in ('assign','minimum32') else 1,4294967295 if kind=='minimum32' else 65535)
        if kind in ('assign','slot','side','direction-side') and args!=([c['scene'],c['scene']] if kind=='assign' else [c['scene']]):raise ValueError('scene helper arguments differ')
        if kind=='keeper' and args!=[e['scene_input']['byte7']]:raise ValueError('keeper selector differs')
        if kind in ('half','hand') and args!=[e['scene_input']['word14']]:raise ValueError('player predicate argument differs')
        if kind=='club-count':
            p=next(p for p in c['input']['outer']['players'] if p['id']==e['scene_input']['word14'])
            if args!=[p['p8_0']] or args[0] not in [v['id'] for v in c['input']['club_counts']]:raise ValueError('club-count context differs')
        if kind=='assign':
            if e['result'] is not None:raise ValueError('void assignment has a scalar result')
        else:
            raw.integer(e['result'],0,4294967295 if kind=='minimum32' else 65535 if kind=='club-count' else 255 if kind=='slot' else 1)
            if e['scene_input']!=e['scene_output']:raise ValueError('read-only rebuild helper changed scene')
        validate_helpers(e['children'],c,e)
        if kind=='assign' and [x['kind'] for x in e['children']]!=['slot','side','club-count','minimum32','half']:raise ValueError('missing/reordered assignment closure')
        if kind=='half' and [x['site'] for x in e['children']] not in (['1B55:4F1F'],['1B55:4F1F','1B55:4F3D']):raise ValueError('missing/reordered handedness observations')
        if prior is not None and parent is not None and parent['kind']=='assign' and kind=='minimum32':
            player=next(p for p in c['input']['outer']['players'] if p['id']==e['scene_input']['word14'])
            if args!=[player['p15_word0'],prior['result']]:raise ValueError('minimum arguments differ from measured inputs')
        prior=e
    if parent is None:
        if [e['kind'] for e in events]!=['assign','keeper','direction-side']:raise ValueError('incomplete top-level rebuild helpers')
        if events[0]['scene_input']!=c['input']['outer']['scenes'][c['scene']-1]:raise ValueError('assignment entry differs')
        expected='0AB9:8696' if events[1]['result'] else '0AB9:86AF'
        if events[2]['site']!=expected:raise ValueError('direction branch differs from observed keeper predicate')


def cases_for(calls,retained,week):
    try:
        if len(calls)!=len(retained):raise ValueError('missing/extra rebuilds')
        rows=[]
        for i,(c,old) in enumerate(zip(calls,retained)):
            raw.keys(c,'step replacement scene input draw_start helpers output draw_end')
            for k in ('step','replacement','scene'):raw.integer(c[k],0,10000)
            e=next(e for e in old['helpers'] if e['site']=='0AB9:AFAA')
            if (c['step'],c['replacement'],c['scene'])!=(old['step'],i,old['arguments'][1]):raise ValueError('rebuild order/selector differs')
            for k in ('input','output'):
                validate_state(c[k])
                if c[k]['outer']!=e[k]:raise ValueError('rebuild boundary differs from T25')
            if (c['draw_start'],c['draw_end'])!=(e['draw_start'],e['draw_end']):raise ValueError('rebuild interval differs')
            if c['input']['club_counts']!=c['output']['club_counts']:raise ValueError('read-only club-count context changed')
            validate_helpers(c['helpers'],c)
            rows.append({'schema':'rebuild-case/1','week':week,**c})
        return rows
    except (KeyError,TypeError,IndexError,AttributeError,StopIteration) as exc:raise ValueError(f'incomplete rebuild fields: {exc}') from exc


def sources():
    index=rep.build_index()
    if not placement.same_json(index,json.loads((rep.FIXTURES/'index.json').read_text())):raise ValueError('retained T25 index differs')
    for meta in index['records']:yield meta,json.loads((ROOT/meta['record']).read_text())


def selected_runs():
    result={}
    for p in sorted(RUNS.glob('T26-r*.json')):
        r=json.loads(p.read_text())
        if r['status']=='completed':
            key=r['actions']['source']['t25_record']
            if key in result:raise ValueError('duplicate rebuild week')
            result[key]=p,r
    return result


def build_index():
    old=list(sources());chosen=selected_runs();records=[]
    if set(chosen)!={m['record'] for m,_ in old}:raise ValueError('missing/extra rebuild week')
    for meta,base in old:
        path,r=chosen[meta['record']]
        if r['actions']['source']!={'t25_record':meta['record'],'t25_record_sha256':meta['record_sha256'],'t25_cases_sha256':meta['cases_sha256']}:raise ValueError('rebuild source differs')
        if r['start_state']!=base['start_state'] or r['actions']['game_files']!=base['actions']['game_files']:raise ValueError('original state/game differs')
        rows=cases_for(contests.outputs(r)['calls'],contests.outputs(base)['calls'],meta['week'])
        obs={o['field']:o['value'] for o in r['observations']};fixture=ROOT/obs['fixture path']
        if fixture.parent!=FIXTURES or contests.sha(fixture)!=obs['fixture sha256'] or not placement.same_json(contests.events(fixture),rows):raise ValueError('rebuild fixture differs')
        helpers=[e for c in rows for e in flatten(c['helpers'])]
        records.append({'record':match.rel(path),'record_sha256':contests.sha(path),'cases':fixture.name,'cases_sha256':contests.sha(fixture),
                        'week':meta['week'],'calls':len(rows),'draws':sum(c['draw_end']-c['draw_start'] for c in rows),
                        'helpers':{kind:sum(e['kind']==kind for e in helpers) for kind in sorted({v[1] for v in SITES.values()})},'producer_commit':r['code_commit']})
    return {'schema':'rebuild-corpus/1','records':records,'weeks':len(records),'calls':sum(r['calls'] for r in records),
            'draws':sum(r['draws'] for r in records),'t25_index_sha256':contests.sha(rep.FIXTURES/'index.json')}


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
                raise ValueError('incomplete capture or retained T22 differs')
            t23=json.loads((ROOT/base['actions']['source']['t23_record']).read_text())
            if not placement.same_json(recorder.legacy.legacy.calls,contests.outputs(t23)['calls']):raise ValueError('retained T23 differs')
            t22=json.loads((ROOT/t23['actions']['source']['t22_record']).read_text())
            if not placement.same_json(recorder.legacy.legacy.legacy.calls,contests.outputs(t22)['calls']):raise ValueError('retained T22 differs')
            t20=json.loads((ROOT/t22['actions']['source']['t20_record']).read_text())
            if not placement.same_json(recorder.legacy.legacy.legacy.legacy.calls,contests.outputs(t20)['calls']) or not placement.same_json(recorder.legacy.legacy.legacy.legacy.ledger,contests.outputs(t20)['ledger']):raise ValueError('retained T20 differs')
            t16=next(b for m,p,sc,x,b,pre in rep.ai.sub.sources() if m['record']==t22['actions']['source']['t20_record'])
            if not placement.same_json(recorder.legacy.legacy.legacy.legacy.tail.calls,contests.outputs(t16)['calls']):raise ValueError('retained T16 differs')
            source = t16['actions']['source']; trace = contests.events(ROOT/source['trace'])
            if week.events != trace[1:-1]:
                raise ValueError('new original week differs from T08')
            ok, lines = match.compare(week.events, source['start_state_sha256'], ROOT/source['t04_record_path'])
            if not ok:
                raise ValueError('ordered DOSBox-X comparison failed')
            rows = cases_for(recorder.calls, contests.outputs(base)['calls'], meta['week'])
        except (Exception, KeyboardInterrupt) as exc:
            status = f'aborted: {type(exc).__name__}: {exc}'
        n = max(match.next_number(RUNS, 'T26-r*.json'), match.next_number(FIXTURES, 'T26-r*.jsonl'))
        rid = f'T26-r{n:04d}'; fixture = FIXTURES/(rid+'.jsonl'); placement.write_lines(fixture, rows)
        rec = copy.deepcopy(base)
        rec.update(run_id=rid, experiment='T26', arm='rebuild', rep=n, code_commit=commit,
                   machine=cycle.machine_id(), started=started, ended=match.utc(), status=status,
                   actions={'script': 'runtime/emul/rebuild.py',
                            'source': {'t25_record': meta['record'], 't25_record_sha256': meta['record_sha256'], 't25_cases_sha256': meta['cases_sha256']},
                            'game_files': {name: hashlib.sha256(b).hexdigest() for name, b in week.files_at_start.items()}},
                   outputs=[{'name': 'calls', 'value': recorder.calls}],
                   observations=[{'step': 0, 'source': 'file', 'field': 'fixture path', 'value': match.rel(fixture)},
                                 {'step': 0, 'source': 'file', 'field': 'fixture sha256', 'value': contests.sha(fixture)},
                                 {'step': 1, 'source': 'log', 'field': 'ordered DOSBox-X comparison', 'value': '\n'.join(lines)}])
        rec['runtime'] = {'harness': f'runtime/emul/rebuild.py@{commit}', 'unicorn': unicorn.__version__,
                          'python': platform.python_version(), 'dos_clock': week.g.clock,
                          'settings': {k: getattr(guest, k) for k in ('INSTR_PER_S', 'KEY_HOLD', 'PIT_HZ', 'SLICE_MAX')}}
        rec['interventions'] = [{'level': 'I3', 'what': 'guest.py services and read-only rebuild hooks'}]
        match.write_record(RUNS/(rid+'.json'), rec)
        print(f'{rid}: {status}; {len(rows)} rebuild cases', flush=True)
        if status != 'completed':
            raise SystemExit(1)
    (FIXTURES/'index.json').write_text(json.dumps(build_index(), indent=2)+'\n')


def main(argv=None):
    ap = argparse.ArgumentParser(description=__doc__)
    m = ap.add_mutually_exclusive_group(required=True)
    m.add_argument('--run', action='store_true'); m.add_argument('--check', action='store_true')
    args = ap.parse_args(argv)
    if args.run:
        run(); return 0
    try:
        index = build_index()
        if (index['weeks'], index['calls'], index['draws']) != (6, 25, 0):
            raise ValueError('incomplete original AI coverage')
        if not placement.same_json(index, json.loads((FIXTURES/'index.json').read_text())):
            raise ValueError('AI index differs')
    except (ValueError, OSError, KeyError, TypeError, StopIteration) as exc:
        print(f'rebuild check: FAIL: {exc}'); return 1
    print(f'rebuild check: ok ({index["calls"]} calls, {index["draws"]} draws)')
    return 0


if __name__ == '__main__':
    raise SystemExit(main())
