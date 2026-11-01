#!/usr/bin/env python3
"""T25: original AEB8 outer-body observations; direct callees remain opaque."""
import argparse
import copy
import hashlib
import json
import platform

import ai_selection as ai
import contests
import extra_event as raw
import match
import placement

ROOT = contests.ROOT
RUNS, FIXTURES = ROOT/'runs/T25', ROOT/'traces/T25'
MAP = ROOT/'static/1-0-exe/replacement-boundaries.json'
BOUNDARIES = json.loads(MAP.read_text())['boundaries']
SITES = {r['site']: r for r in BOUNDARIES}
SCENE = {**{f'word{i}': (i, 2) for i in (0, 2, 8, 10, 12, 14, 20, 23)},
         **{f'byte{i}': (i, 1) for i in (4, 5, 6, 7, 16, 17, 18, 19, 22)}}
GLOBALS = {'mode': (0xD074,1), 'position12': (0xD2C,2), 'position_sentinel': (0xD2E,2),
           'position_default': (0xD32,2), 'speaker_gate': (0xA2EC,1)}


def snapshot(g):
    s = ai.state(g)
    cached = [g.rd(0xCF5E+10*i) for i in range(2)]
    ids = sorted({p['id'] for p in s['players']} | set(cached))
    players = []
    for identifier in ids:
        a, b = g.far(0xD7BA)+8*identifier, g.far(0xD7BE)+15*identifier
        players.append({'id': identifier, 'p15_word0': g.word_at(b),
                        **{f'p8_{i}': g.mem(a+i,1)[0] for i in range(8)},
                        **{f'p15_{i}': g.mem(b+i,1)[0] for i in range(2,15)}})
    return {'selection': s, 'players': players, 'cached_players': cached,
            'directions': [g.rd(0xD0C8+i,1) for i in range(4)],
            'club_totals': [g.rd(0xD12A+2*i) for i in range(2)],
            'globals': {k: g.rd(off,n) for k,(off,n) in GLOBALS.items()},
            'scenes': [{'index': i, **{k:g.rd(0xCCEF+25*i+off,n) for k,(off,n) in SCENE.items()}}
                       for i in range(1,23)]}


def validate_state(s):
    raw.keys(s,'selection players cached_players directions club_totals globals scenes')
    ai.validate_state(s['selection'])
    raw.vector(s['cached_players'],2,3920); raw.vector(s['directions'],4,255); raw.vector(s['club_totals'],2,65535)
    raw.keys(s['globals'],' '.join(GLOBALS))
    for k,(_,n) in GLOBALS.items(): raw.integer(s['globals'][k],0,255 if n==1 else 65535)
    ids=sorted({p['id'] for p in s['selection']['players']} | set(s['cached_players']))
    if [p['id'] for p in s['players']]!=ids: raise ValueError('incomplete canonical outer players')
    for p in s['players']:
        raw.keys(p,'id p15_word0 '+' '.join(f'p8_{i}' for i in range(8))+' '+' '.join(f'p15_{i}' for i in range(2,15)))
        raw.integer(p['id'],0,3920); raw.integer(p['p15_word0'])
        for k,v in p.items():
            if k not in ('id','p15_word0'): raw.integer(v,0,255)
        old=next((o for o in s['selection']['players'] if o['id']==p['id']),None)
        if old and (p['p8_6'],p['p8_7'],p['p15_8'],p['p15_11'])!=(old['position'],old['style'],old['byte8'],old['flags11']):
            raise ValueError('canonical player projection differs')
    if [r['index'] for r in s['scenes']]!=list(range(1,23)): raise ValueError('complete ordered scenes required')
    for r,old in zip(s['scenes'],s['selection']['scenes']):
        raw.keys(r,'index '+' '.join(SCENE)); raw.integer(r['index'],1,22)
        for k,(_,n) in SCENE.items(): raw.integer(r[k],0,255 if n==1 else 65535)
        if (r['byte7'],r['word14'])!=(old['slot'],old['player']): raise ValueError('scene projection differs')


def arguments(g,site,c):
    w=g.stack_word; scene=c['arguments'][1]; side=c['arguments'][2]
    if site=='0AB9:AEDF':
        if w(2)*16+w(0)!=g.far(0xD7BE)+15*g.rd(0xCCEF+25*scene+14)+11: raise ValueError('flag pointer differs')
        return [w(4),g.rd(0xCCEF+25*scene+14)]
    if site in ('0AB9:AEF0','0AB9:AF18','0AB9:AFDA','0AB9:B00C'): return [w(0)]
    if site=='0AB9:AF5F': return [w(0),w(2)]
    if site=='0AB9:AF7F': return [w(0)&255,w(2),w(4),w(6)&255]
    if site in ('0AB9:AFAA','0AB9:AFB7'):
        if (w(2),w(4))!=(0xCCEF+25*scene,g.DS): raise ValueError('scene pointer differs')
        return [scene,w(6)] if site.endswith('AFAA') else [scene,w(6)&255,w(8)]
    if site in ('0AB9:B077','0AB9:B08B'):
        loop=g.mem(g.reg('ss')*16+((g.reg('bp')-4)&65535),1)[0]
        return [loop,w(0)]
    return []


class Recorder:
    def __init__(self,week):
        self.week,self.legacy=week,ai.Recorder(week)
        self.calls=[]; self.pending=self.helper=None
        week.g.code_hook('0AB9:ABAF',self.enter); week.g.code_hook('0AB9:ABB2',self.leave)
        for r in BOUNDARIES:
            site=r['site']
            week.g.code_hook(site,lambda g,site=site:self.start(g,site))
            week.g.code_hook(r['return'],lambda g,site=site:self.end(g,site))
    def enter(self,g):
        if self.legacy.pending is None: return
        if self.pending is not None: raise ValueError('nested replacement')
        self.pending={'step':self.legacy.pending['step'],'a94b':len(self.legacy.calls),
                      'arguments':[g.stack_word(0),g.stack_word(2),g.stack_word(4)&255],
                      'input':snapshot(g),'draw_start':self.week.draws,'helpers':[]}
    def start(self,g,site):
        if self.pending is None: return
        if self.helper is not None: raise ValueError('nested direct replacement helper')
        self.helper={'site':site,'arguments':arguments(g,site,self.pending),'input':snapshot(g),'draw_start':self.week.draws}
    def end(self,g,site):
        if self.pending is None or self.helper is None or self.helper['site']!=site: return
        e=self.helper
        e.update(output=snapshot(g),draw_end=self.week.draws,
                 result=(g.reg('ax')&255) if site in ('0AB9:AEF0','0AB9:AF18','0AB9:B077','0AB9:B08B') else None)
        self.pending['helpers'].append(e); self.helper=None
    def leave(self,g):
        if self.pending is None: return
        if self.helper is not None: raise ValueError('unfinished replacement helper')
        self.pending.update(output=snapshot(g),draw_end=self.week.draws)
        self.calls.append(self.pending); self.pending=None


def validate_helpers(c):
    helpers=c['helpers']; sites=[e['site'] for e in helpers]
    if any(site not in SITES for site in sites): raise ValueError('unknown replacement helper')
    mandatory=['0AB9:AEDF','0AB9:AEF0','0AB9:AFAA','0AB9:AFB7','0AB9:B00C','0AB9:B077','0AB9:B0C6']
    cursor=0
    for site in mandatory:
        try: cursor=sites.index(site,cursor)+1
        except ValueError: raise ValueError('missing/reordered mandatory replacement helper')
    # Two ordered managed-cache-side checks always precede the final refresh.
    loops=[e['arguments'][0] for e in helpers if e['site']=='0AB9:B077']
    if loops!=[0,1] or sites[-1]!='0AB9:B0C6': raise ValueError('incomplete cache loop/refresh')
    managed=next(e for e in helpers if e['site']=='0AB9:AEF0')['result']
    unmanaged_sites=('0AB9:AF01','0AB9:AF18','0AB9:AF7F','0AB9:AFDA')
    if any((site in sites)!=(managed==0) for site in unmanaged_sites): raise ValueError('managed branch footprint differs')
    tail=helpers[sites.index('0AB9:B077'):-1]
    cursor=0
    for side in range(2):
        if cursor>=len(tail) or tail[cursor]['site']!='0AB9:B077' or tail[cursor]['arguments'][0]!=side: raise ValueError('cache loop order differs')
        reached=tail[cursor]['result']; cursor+=1
        if reached:
            if cursor>=len(tail) or tail[cursor]['site']!='0AB9:B08B' or tail[cursor]['arguments'][0]!=side: raise ValueError('missing cache availability predicate')
            cursor+=1
    if cursor!=len(tail): raise ValueError('extra cache predicates')
    position={r['site']:i for i,r in enumerate(BOUNDARIES)}
    prefix=[position[s] for s in sites[:sites.index('0AB9:B077')]]
    if prefix!=sorted(set(prefix)) or any(i>=position['0AB9:B077'] for i in prefix):
        raise ValueError('reordered direct replacement sites')
    draw=c['draw_start']
    for e in helpers:
        raw.keys(e,'site arguments input draw_start output draw_end result')
        if e['site'] not in SITES: raise ValueError('unknown replacement helper')
        for k in ('input','output'): validate_state(e[k])
        raw.integer(e['draw_start'],0,10**9);raw.integer(e['draw_end'],0,10**9)
        if not draw<=e['draw_start']<=e['draw_end']<=c['draw_end']: raise ValueError('helper draw continuation differs')
        draw=e['draw_end']
        site=e['site'];args=e['arguments']; scene=c['arguments'][1];side=c['arguments'][2]
        sizes={'0AB9:AEDF':2,'0AB9:AEF0':1,'0AB9:AF18':1,'0AB9:AF5F':2,'0AB9:AF7F':4,
               '0AB9:AFAA':2,'0AB9:AFB7':3,'0AB9:AFDA':1,'0AB9:B00C':1,'0AB9:B077':2,'0AB9:B08B':2}
        raw.vector(args,sizes.get(site,0),65535)
        s=e['input']['selection']; player=s['scenes'][scene-1]['player']
        if site=='0AB9:AEDF' and args!=[3,player]: raise ValueError('outgoing flag arguments differ')
        if site=='0AB9:AEF0' and args!=[s['clubs'][side]['id']]: raise ValueError('managed side argument differs')
        if site=='0AB9:AF18' and args!=[s['clubs'][1-side]['id']]: raise ValueError('managed opponent argument differs')
        normalized=scene-s['side_offsets'][side]
        if site=='0AB9:AF5F' and args!=[player,s['clubs'][side]['roster'][normalized-1]]: raise ValueError('message player arguments differ')
        if site=='0AB9:AF7F' and args!=[0,c['arguments'][0],normalized,side]: raise ValueError('log arguments differ')
        if site=='0AB9:AFAA' and args!=[scene,scene]: raise ValueError('rebuild scene arguments differ')
        if site=='0AB9:AFB7' and args!=[scene,1,1]: raise ValueError('byte6 arguments differ')
        if site in ('0AB9:AFDA','0AB9:B00C') and args!=[player]: raise ValueError('incoming player argument differs')
        if site in ('0AB9:B077','0AB9:B08B'):
            raw.integer(args[0],0,1)
            expected=s['clubs'][args[0]]['id'] if site.endswith('B077') else e['input']['cached_players'][args[0]]
            if args[1]!=expected: raise ValueError('cache helper context differs')
        if site in ('0AB9:AEF0','0AB9:AF18','0AB9:B077','0AB9:B08B'): raw.integer(e['result'],0,1)
        elif e['result'] is not None: raise ValueError('void helper has a scalar result')
        if c['draw_start']==c['draw_end'] and (e['input']['selection']['seed']!=c['input']['selection']['seed'] or e['output']['selection']['seed']!=c['output']['selection']['seed']):
            raise ValueError('zero-draw helper seed differs')
        if site in ('0AB9:AEF0','0AB9:AF18','0AB9:B077','0AB9:B08B','0AB9:AF01') and e['input']!=e['output']:
            raise ValueError('read-only named helper projection changed')
    if helpers[0]['input']!=c['input']: raise ValueError('first helper entry differs')
    # Direct-body writes occur between helpers. Preserve their observed states rather than modelling them.
    for a,b in zip(helpers,helpers[1:]):
        contiguous={('0AB9:AEDF','0AB9:AEF0'),('0AB9:AEF0','0AB9:AF01'),('0AB9:AF01','0AB9:AF18'),
                    ('0AB9:AF5F','0AB9:AF7F'),('0AB9:AF7F','0AB9:AFAA'),('0AB9:AFAA','0AB9:AFB7'),
                    ('0AB9:B077','0AB9:B08B')}
        if (a['site'],b['site']) in contiguous and a['output']!=b['input']:
            raise ValueError('direct helper state continuation differs')
    for k in ('selection','scenes','globals','directions','club_totals'):
        if helpers[-1]['output'][k]!=c['output'][k]: raise ValueError('refresh to return continuation differs')
    before={p['id']:p for p in helpers[-1]['output']['players']}
    for p in c['output']['players']:
        if p['id'] in before and p!=before[p['id']]: raise ValueError('player changed after refresh')


def cases_for(calls,retained,week):
    try:
        expected=[(i,c['step'],e) for i,c in enumerate(retained) for e in ai.flatten(c['helpers']) if e['kind']=='replace']
        if len(calls)!=len(expected): raise ValueError('missing/extra replacements')
        rows=[]
        for c,(i,step,e) in zip(calls,expected):
            raw.keys(c,'step a94b arguments input draw_start helpers output draw_end')
            raw.integer(c['step'],0,10000);raw.integer(c['a94b'],0,10000);raw.vector(c['arguments'],3,65535)
            if (c['step'],c['a94b'],c['arguments'])!=(step,i,e['arguments']): raise ValueError('replacement order/arguments differ')
            for k in ('input','output'):
                validate_state(c[k])
                if c[k]['selection']!=e[k]: raise ValueError('replacement boundary differs from T23')
            if (c['draw_start'],c['draw_end'])!=(e['draw_start'],e['draw_end']): raise ValueError('replacement interval differs')
            validate_helpers(c)
            rows.append({'schema':'replacement-case/1','week':week,**c})
        return rows
    except (KeyError,IndexError,TypeError,AttributeError) as exc:
        raise ValueError(f'incomplete replacement fields: {exc}') from exc


def sources():
    index=ai.build_index()
    if not placement.same_json(index,json.loads((ai.FIXTURES/'index.json').read_text())): raise ValueError('retained T23 index differs')
    for meta in index['records']: yield meta,json.loads((ROOT/meta['record']).read_text())


def selected_runs():
    result={}
    for p in sorted(RUNS.glob('T25-r*.json')):
        r=json.loads(p.read_text())
        if r['status']=='completed':
            key=r['actions']['source']['t23_record']
            if key in result: raise ValueError('duplicate replacement week')
            result[key]=p,r
    return result


def build_index():
    prior=list(sources());chosen=selected_runs();records=[]
    if set(chosen)!={m['record'] for m,_ in prior}: raise ValueError('missing/extra replacement week')
    for meta,base in prior:
        path,r=chosen[meta['record']]
        if r['actions']['source']!={'t23_record':meta['record'],'t23_record_sha256':meta['record_sha256'],'t23_cases_sha256':meta['cases_sha256'],'boundary_map_sha256':contests.sha(MAP)}:
            raise ValueError('replacement provenance differs')
        if r['start_state']!=base['start_state'] or r['actions']['game_files']!=base['actions']['game_files']: raise ValueError('original state/game differs')
        rows=cases_for(contests.outputs(r)['calls'],contests.outputs(base)['calls'],meta['week'])
        obs={o['field']:o['value'] for o in r['observations']};fixture=ROOT/obs['fixture path']
        if fixture.parent!=FIXTURES or contests.sha(fixture)!=obs['fixture sha256'] or not placement.same_json(contests.events(fixture),rows): raise ValueError('replacement fixture differs')
        records.append({'record':match.rel(path),'record_sha256':contests.sha(path),'cases':fixture.name,'cases_sha256':contests.sha(fixture),
                        'week':meta['week'],'calls':len(rows),'draws':sum(c['draw_end']-c['draw_start'] for c in rows),
                        'helpers':{site:sum(e['site']==site for c in rows for e in c['helpers']) for site in SITES},'producer_commit':r['code_commit']})
    return {'schema':'replacement-corpus/1','records':records,'weeks':len(records),'calls':sum(r['calls'] for r in records),
            'draws':sum(r['draws'] for r in records),'t23_index_sha256':contests.sha(ai.FIXTURES/'index.json'),'boundary_map_sha256':contests.sha(MAP)}


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
            t22 = json.loads((ROOT/base['actions']['source']['t22_record']).read_text())
            if not placement.same_json(recorder.legacy.legacy.calls,contests.outputs(t22)['calls']): raise ValueError('retained T22 differs')
            t20 = json.loads((ROOT/t22['actions']['source']['t20_record']).read_text())
            if not placement.same_json(recorder.legacy.legacy.legacy.calls,contests.outputs(t20)['calls']) or not placement.same_json(recorder.legacy.legacy.legacy.ledger,contests.outputs(t20)['ledger']): raise ValueError('retained T20 differs')
            t16 = next(b for m,p,sc,x,b,pre in ai.sub.sources() if m['record']==t22['actions']['source']['t20_record'])
            if not placement.same_json(recorder.legacy.legacy.legacy.tail.calls,contests.outputs(t16)['calls']): raise ValueError('retained T16 differs')
            source = t16['actions']['source']; trace = contests.events(ROOT/source['trace'])
            if week.events != trace[1:-1]:
                raise ValueError('new original week differs from T08')
            ok, lines = match.compare(week.events, source['start_state_sha256'], ROOT/source['t04_record_path'])
            if not ok:
                raise ValueError('ordered DOSBox-X comparison failed')
            rows = cases_for(recorder.calls, contests.outputs(base)['calls'], meta['week'])
        except (Exception, KeyboardInterrupt) as exc:
            status = f'aborted: {type(exc).__name__}: {exc}'
        n = max(match.next_number(RUNS, 'T25-r*.json'), match.next_number(FIXTURES, 'T25-r*.jsonl'))
        rid = f'T25-r{n:04d}'; fixture = FIXTURES/(rid+'.jsonl'); placement.write_lines(fixture, rows)
        rec = copy.deepcopy(base)
        rec.update(run_id=rid, experiment='T25', arm='replacement', rep=n, code_commit=commit,
                   machine=cycle.machine_id(), started=started, ended=match.utc(), status=status,
                   actions={'script': 'runtime/emul/replacement.py',
                            'source': {'t23_record': meta['record'], 't23_record_sha256': meta['record_sha256'], 't23_cases_sha256': meta['cases_sha256'], 'boundary_map_sha256': contests.sha(MAP)},
                            'game_files': {name: hashlib.sha256(b).hexdigest() for name, b in week.files_at_start.items()}},
                   outputs=[{'name': 'calls', 'value': recorder.calls}],
                   observations=[{'step': 0, 'source': 'file', 'field': 'fixture path', 'value': match.rel(fixture)},
                                 {'step': 0, 'source': 'file', 'field': 'fixture sha256', 'value': contests.sha(fixture)},
                                 {'step': 1, 'source': 'log', 'field': 'ordered DOSBox-X comparison', 'value': '\n'.join(lines)}])
        rec['runtime'] = {'harness': f'runtime/emul/replacement.py@{commit}', 'unicorn': unicorn.__version__,
                          'python': platform.python_version(), 'dos_clock': week.g.clock,
                          'settings': {k: getattr(guest, k) for k in ('INSTR_PER_S', 'KEY_HOLD', 'PIT_HZ', 'SLICE_MAX')}}
        rec['interventions'] = [{'level': 'I3', 'what': 'guest.py services and read-only replacement hooks'}]
        match.write_record(RUNS/(rid+'.json'), rec)
        print(f'{rid}: {status}; {len(rows)} replacement cases', flush=True)
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
        print(f'replacement check: FAIL: {exc}'); return 1
    print(f'replacement check: ok ({index["calls"]} calls, {index["draws"]} draws)')
    return 0


if __name__ == '__main__':
    raise SystemExit(main())
