#!/usr/bin/env python3
"""T28: targeted original 164F prefix, swaps, selectors and opaque helper boundaries."""
import argparse
import copy
import hashlib
import json
import platform

import rebuild as reb
import contests
import extra_event as raw
import match
import placement

ROOT=contests.ROOT
RUNS,FIXTURES=ROOT/'runs/T28',ROOT/'traces/T28'
WEEK='T04-week-r0017'
SITES={
 '0AB9:16B6':('0AB9:16BB','sum-available'),
 '0AB9:16E1':('0AB9:16E6','division'),
 '0AB9:174A':('0AB9:174F','role-available'),
 '0AB9:17C0':('0AB9:17C5','roster'),
 '0AB9:17D7':('0AB9:17DC','roles'),
 '0AB9:180E':('0AB9:1813','scenes'),
 '0AB9:1841':('0AB9:1846','events'),
 '0AB9:186C':('0AB9:1871','cache'),
 '0AB9:1971':('0AB9:1974','assign'),
 '0AB9:1985':('0AB9:1988','opaque'),
 '0AB9:1988':('0AB9:198B','opaque'),
 '0AB9:198B':('0AB9:198E','opaque'),
 '0AB9:198E':('0AB9:1991','opaque'),
 '0AB9:1991':('0AB9:1994','opaque'),
}
SWAPS={'roster':2,'roles':1,'scenes':25,'events':2,'cache':1}


def selectors(g):return {'actor':g.rd(0xD09F,1),'secondary':g.rd(0xD0A0,1)}
def snapshot(g):return {'rebuild':reb.snapshot(g),**selectors(g),'cpu_class':g.rd(0xA52A,1)}
def validate_selectors(s):
    raw.keys(s,'actor secondary')
    for v in s.values():raw.integer(v,0,255)
def validate_state(s):
    raw.keys(s,'rebuild actor secondary cpu_class');reb.validate_state(s['rebuild'])
    validate_selectors({k:s[k] for k in ('actor','secondary')});raw.integer(s['cpu_class'],0,255)


def local(g,offset,n=2):
    return int.from_bytes(g.mem(g.reg('ss')*16+((g.reg('bp')+offset)&65535),n),'little')
def far_address(g,pointer,delta):
    return g.rd(pointer+2)*16+((g.rd(pointer)+delta)&65535)
def value(g,address,kind):
    if kind=='scenes':return {k:int.from_bytes(g.mem(address+off,n),'little') for k,(off,n) in reb.rep.SCENE.items()}
    return int.from_bytes(g.mem(address,SWAPS[kind]),'little')
def validate_value(v,kind):
    if kind=='scenes':
        raw.keys(v,' '.join(reb.rep.SCENE))
        for k,(_,n) in reb.rep.SCENE.items():raw.integer(v[k],0,255 if n==1 else 65535)
    else:raw.integer(v,0,3920 if kind=='roster' else 65535 if kind=='events' else 255)


def context(g,identifier=None,side=None):
    c={**selectors(g),'club_totals':[g.rd(0xD12A+2*i) for i in range(2)]}
    if identifier is not None:
        a=far_address(g,0xD7BA,8*identifier);b=far_address(g,0xD7BE,15*identifier)
        club=g.rd(0xD6E4+2*side)
        c.update(player=identifier,byte8=g.mem(b+8,1)[0],flags11=g.mem(b+11,1)[0],
                 p8_4=g.mem(a+4,1)[0],position=g.mem(a+6,1)[0],
                 roster=[int.from_bytes(g.mem(far_address(g,0xD7C2,62*(club-1)+2*i),2),'little') for i in range(20)])
    return c


class Recorder:
    def __init__(self,week):
        self.week,self.legacy=week,reb.Recorder(week)
        self.calls=[];self.pending=self.event=self.swap_selectors=None;self.addresses=None;self.frame=None
        week.g.code_hook('0AB9:B0C6',self.enter);week.g.code_hook('0AB9:B0C9',self.leave)
        week.g.code_hook('0AB9:1925',self.selector_mark)
        for site,(end,_) in SITES.items():
            week.g.code_hook(site,lambda g,site=site:self.start(g,site))
            week.g.code_hook(end,lambda g,site=site:self.end(g,site))
    def enter(self,g):
        parent=self.legacy.legacy.pending
        if parent is None:return
        if self.pending is not None:raise ValueError('nested rearrangement')
        self.frame=None
        self.pending={'step':parent['step'],'replacement':len(self.legacy.legacy.calls),
                      'arguments':copy.deepcopy(parent['arguments']),'input':snapshot(g),
                      'draw_start':self.week.draws,'events':[]}
    def start(self,g,site):
        if self.pending is None:return
        if self.frame is None:self.frame=g.reg('bp')
        if g.reg('bp')!=self.frame:return  # descendants of opaque helpers belong to their own frames
        if self.event is not None:raise ValueError('nested direct rearrangement helper')
        kind=SITES[site][1];e={'site':site,'kind':kind,'draw_start':self.week.draws}
        if kind in ('sum-available','role-available'):
            side,slot,identifier=local(g,-1,1),local(g,-4),g.stack_word(0)
            e.update(arguments=[side,slot,identifier],input=context(g,identifier,side))
        elif kind=='division':
            e.update(arguments=[local(g,-1,1),(g.reg('dx')<<16)|g.reg('ax'),(g.reg('bx')<<16)|g.reg('cx')],input=context(g))
        elif kind in SWAPS:
            side,outer,inner=local(g,-1,1),local(g,-6),local(g,-4)
            n=g.stack_word(0)
            if n!=SWAPS[kind]:raise ValueError('swap width differs')
            a=g.stack_word(8)*16+g.stack_word(6);b=g.stack_word(4)*16+g.stack_word(2)
            def expected(slot):
                if kind=='roles':return g.reg('ss')*16+((g.reg('bp')+slot-0x15)&65535)
                if kind=='roster':return far_address(g,0xD7C2,62*(g.rd(0xD6E4+2*side)-1)+2*(slot-1))
                off={'scenes':0xCCEF+25*(g.rd(0xD56+side,1)+slot),'events':0xD146+40*side+2*slot,'cache':0xD197+20*side+slot}[kind]
                return g.DS*16+off
            if (a,b)!=(expected(inner),expected(outer)):raise ValueError('swap pointer identity differs')
            e.update(arguments=[side,outer,inner,n],input={'a':value(g,a,kind),'b':value(g,b,kind)},selectors=selectors(g))
            self.addresses=(a,b)
            if kind=='roster':
                if self.swap_selectors is not None:raise ValueError('unfinished selector transaction')
                self.swap_selectors=(copy.deepcopy(e['arguments'][:3]),selectors(g),self.week.draws)
        elif kind=='assign':
            offset,segment,index=g.stack_word(2),g.stack_word(4),g.stack_word(6)
            if segment!=g.DS or offset!=0xCCEF+25*index:raise ValueError('assignment scene pointer differs')
            e.update(arguments=[local(g,-1,1),index,index],input=snapshot(g))
        else:e.update(arguments=[],input=snapshot(g))
        self.event=e
    def end(self,g,site):
        if self.pending is None or self.event is None or self.event['site']!=site:return
        if g.reg('bp')!=self.frame:return
        e=self.event;kind=e['kind']
        if kind in ('sum-available','role-available'):e.update(output=context(g,e['arguments'][2],e['arguments'][0]),result=g.reg('ax')&255)
        elif kind=='division':e.update(output=context(g),result={'quotient':(g.reg('dx')<<16)|g.reg('ax'),'remainder':(g.reg('bx')<<16)|g.reg('cx')})
        elif kind in SWAPS:
            a,b=self.addresses;e.update(output={'a':value(g,a,kind),'b':value(g,b,kind)},selectors_after=selectors(g));self.addresses=None
        else:e.update(output=snapshot(g),result=None)
        e['draw_end']=self.week.draws;self.pending['events'].append(e);self.event=None
    def selector_mark(self,g):
        if self.pending is None or self.swap_selectors is None:return
        if g.reg('bp')!=self.frame:return
        if self.event is not None:raise ValueError('selector mark inside helper')
        args,before,start=self.swap_selectors
        self.pending['events'].append({'site':'0AB9:1925','kind':'selectors','arguments':args,'input':before,
                                       'output':selectors(g),'draw_start':start,'draw_end':self.week.draws})
        self.swap_selectors=None
    def leave(self,g):
        if self.pending is None:return
        if self.event is not None or self.swap_selectors is not None:raise ValueError('unfinished rearrangement transaction')
        self.pending.update(output=snapshot(g),draw_end=self.week.draws)
        self.calls.append(self.pending);self.pending=None


def validate_context(s,availability=False):
    keys='actor secondary club_totals'+(' player byte8 flags11 p8_4 position roster' if availability else '')
    raw.keys(s,keys);validate_selectors({k:s[k] for k in ('actor','secondary')});raw.vector(s['club_totals'],2,65535)
    if availability:
        raw.integer(s['player'],0,3920);raw.vector(s['roster'],20,3920)
        for k in ('byte8','flags11','p8_4','position'):raw.integer(s[k],0,255)


def validate_events(c):
    events=c['events'];cursor=c['draw_start']
    for e in events:
        kind=e['kind'];site=e['site']
        if kind=='selectors':
            if site!='0AB9:1925':raise ValueError('unknown selector mark')
        elif site not in SITES or SITES[site][1]!=kind:raise ValueError('unknown rearrangement helper')
        extra=' selectors selectors_after' if kind in SWAPS else '' if kind=='selectors' else ' result'
        raw.keys(e,'site kind draw_start arguments input output draw_end'+extra)
        for k in ('draw_start','draw_end'):raw.integer(e[k],0,10**9)
        if not cursor<=e['draw_start']<=e['draw_end']<=c['draw_end']:raise ValueError('rearrangement draw continuation differs')
        cursor=e['draw_end']
        if kind in ('sum-available','role-available'):
            raw.vector(e['arguments'],3,65535);side,slot,identifier=e['arguments'];raw.integer(side,0,1);raw.integer(slot,1,11);raw.integer(identifier,0,3920)
            for k in ('input','output'):validate_context(e[k],True)
            if e['input']!=e['output'] or e['input']['player']!=identifier or e['input']['roster'][slot-1]!=identifier:raise ValueError('availability context differs')
            raw.integer(e['result'],0,1)
            player=next(p for p in c['input']['rebuild']['outer']['players'] if p['id']==identifier)
            if [e['input'][k] for k in ('byte8','flags11','p8_4','position')]!=[player[k] for k in ('p15_8','p15_11','p8_4','p8_6')]:raise ValueError('canonical availability fields differ')
        elif kind=='division':
            raw.vector(e['arguments'],3,4294967295);raw.integer(e['arguments'][0],0,1)
            if e['arguments'][2]!=22:raise ValueError('division denominator differs')
            for k in ('input','output'):validate_context(e[k])
            if e['input']!=e['output']:raise ValueError('division changed named memory')
            raw.keys(e['result'],'quotient remainder')
            for v in e['result'].values():raw.integer(v,0,4294967295)
        elif kind in SWAPS:
            raw.vector(e['arguments'],4,65535);side,outer,inner,n=e['arguments']
            raw.integer(side,0,1);raw.integer(outer,1,10);raw.integer(inner,outer+1,11)
            if n!=SWAPS[kind]:raise ValueError('typed swap length differs')
            for k in ('input','output'):
                raw.keys(e[k],'a b')
                for v in e[k].values():validate_value(v,kind)
            if e['output']!={'a':e['input']['b'],'b':e['input']['a']}:raise ValueError('observed exchange differs')
            validate_selectors(e['selectors']);validate_selectors(e['selectors_after'])
            if e['selectors']!=e['selectors_after']:raise ValueError('exchange helper changed selectors')
        elif kind=='selectors':
            raw.vector(e['arguments'],3,65535);validate_selectors(e['input']);validate_selectors(e['output'])
        else:
            raw.vector(e['arguments'],3 if kind=='assign' else 0,65535)
            for k in ('input','output'):validate_state(e[k])
            if e['result'] is not None:raise ValueError('void helper has scalar result')
            if kind=='assign':
                side,index,argument=e['arguments'];raw.integer(side,0,1);raw.integer(index,1,22)
                if index!=argument:raise ValueError('assignment selector differs')
    # Literal static phase ordering, with measured swaps retained instead of a sorting model.
    pos=0
    for side in range(2):
        for phase in ('sum-available','division','role-available'):
            count=1 if phase=='division' else 11
            block=events[pos:pos+count]
            if len(block)!=count or any(e['kind']!=phase or e['arguments'][0]!=side for e in block):raise ValueError('missing/reordered availability/division phase')
            if phase!='division' and [e['arguments'][1] for e in block]!=list(range(1,12)):raise ValueError('slot scan incomplete')
            pos+=count
        while pos<len(events) and events[pos]['kind']=='roster':
            bundle=events[pos:pos+6]
            if [e['kind'] for e in bundle]!=['roster','roles','scenes','events','cache','selectors']:raise ValueError('incomplete/reordered swap transaction')
            args=bundle[0]['arguments'][:3]
            if args[0]!=side or any(e['arguments'][:3]!=args for e in bundle):raise ValueError('coupled swap selectors differ')
            if bundle[-1]['input']!=bundle[0]['selectors']:raise ValueError('selector transaction start differs')
            pos+=6
        assignments=events[pos:pos+11]
        expected=[c['input']['rebuild']['outer']['selection']['side_offsets'][side]+i for i in range(1,12)]
        if len(assignments)!=11 or any(e['kind']!='assign' or e['arguments'][0]!=side for e in assignments) or [e['arguments'][1] for e in assignments]!=expected:raise ValueError('missing/reordered scene assignments')
        pos+=11
    tail=events[pos:]
    if [e['site'] for e in tail]!=['0AB9:1985','0AB9:1988','0AB9:198B','0AB9:198E','0AB9:1991']:raise ValueError('missing/reordered opaque tail')
    for a,b in zip(tail,tail[1:]):
        if a['output']!=b['input']:raise ValueError('opaque tail state continuation differs')
    final=copy.deepcopy(tail[-1]['output'])
    for i in (0,11):final['rebuild']['outer']['scenes'][i]['word12']=0
    if final!=c['output']:raise ValueError('final keeper-field clear continuation differs')


def cases_for(calls,retained,week):
    try:
        expected=[(i,c['step'],c['arguments'],e) for i,c in enumerate(retained) for e in c['helpers'] if e['site']=='0AB9:B0C6']
        if len(calls)!=len(expected):raise ValueError('missing/extra refreshes')
        rows=[]
        for c,(i,step,args,e) in zip(calls,expected):
            raw.keys(c,'step replacement arguments input draw_start events output draw_end')
            raw.integer(c['step'],0,10000);raw.integer(c['replacement'],0,10000);raw.vector(c['arguments'],3,65535)
            if (c['step'],c['replacement'],c['arguments'])!=(step,i,args):raise ValueError('refresh order/arguments differ')
            for k in ('input','output'):
                validate_state(c[k])
                if c[k]['rebuild']['outer']!=e[k]:raise ValueError('refresh boundary differs from T25')
            if (c['draw_start'],c['draw_end'])!=(e['draw_start'],e['draw_end']):raise ValueError('refresh interval differs')
            validate_events(c);rows.append({'schema':'rearrangement-case/1','week':week,**c})
        return rows
    except (KeyError,IndexError,TypeError,AttributeError,StopIteration) as exc:raise ValueError(f'incomplete rearrangement fields: {exc}') from exc


def sources():
    index=reb.build_index()
    if not placement.same_json(index,json.loads((reb.FIXTURES/'index.json').read_text())):raise ValueError('retained T26 manifest differs')
    selected=[m for m in index['records'] if m['week']==WEEK]
    if len(selected)!=1:raise ValueError('unique target week required')
    for meta in selected:yield meta,json.loads((ROOT/meta['record']).read_text())


def selected_runs():
    result={}
    for p in sorted(RUNS.glob('T28-r*.json')):
        r=json.loads(p.read_text())
        if r['status']=='completed':
            key=r['actions']['source']['t26_record']
            if key in result:raise ValueError('duplicate completed targeted week')
            result[key]=p,r
    return result


def build_index():
    prior=list(sources());chosen=selected_runs();records=[]
    if set(chosen)!={m['record'] for m,_ in prior}:raise ValueError('missing/extra targeted week')
    for meta,base in prior:
        path,r=chosen[meta['record']]
        if r['actions']['source']!={'t26_record':meta['record'],'t26_record_sha256':meta['record_sha256'],'t26_cases_sha256':meta['cases_sha256']}:raise ValueError('rearrangement provenance differs')
        if r['start_state']!=base['start_state'] or r['actions']['game_files']!=base['actions']['game_files']:raise ValueError('original state/game differs')
        t25=json.loads((ROOT/base['actions']['source']['t25_record']).read_text())
        rows=cases_for(contests.outputs(r)['calls'],contests.outputs(t25)['calls'],meta['week'])
        obs={o['field']:o['value'] for o in r['observations']};fixture=ROOT/obs['fixture path']
        if fixture.parent!=FIXTURES or contests.sha(fixture)!=obs['fixture sha256'] or not placement.same_json(contests.events(fixture),rows):raise ValueError('rearrangement fixture differs')
        records.append({'record':match.rel(path),'record_sha256':contests.sha(path),'cases':fixture.name,'cases_sha256':contests.sha(fixture),
                        'week':meta['week'],'calls':len(rows),'draws':sum(c['draw_end']-c['draw_start'] for c in rows),
                        'events':{kind:sum(e['kind']==kind for c in rows for e in c['events']) for kind in sorted({v[1] for v in SITES.values()}|{'selectors'})},'producer_commit':r['code_commit']})
    return {'schema':'rearrangement-corpus/1','records':records,'weeks':len(records),'calls':sum(r['calls'] for r in records),
            'draws':sum(r['draws'] for r in records),'t26_index_sha256':contests.sha(reb.FIXTURES/'index.json')}


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
            t25=json.loads((ROOT/base['actions']['source']['t25_record']).read_text())
            if not placement.same_json(recorder.legacy.legacy.calls,contests.outputs(t25)['calls']):raise ValueError('retained T25 differs')
            t23=json.loads((ROOT/t25['actions']['source']['t23_record']).read_text())
            if not placement.same_json(recorder.legacy.legacy.legacy.calls,contests.outputs(t23)['calls']):raise ValueError('retained T23 differs')
            t22=json.loads((ROOT/t23['actions']['source']['t22_record']).read_text())
            if not placement.same_json(recorder.legacy.legacy.legacy.legacy.calls,contests.outputs(t22)['calls']):raise ValueError('retained T22 differs')
            t20=json.loads((ROOT/t22['actions']['source']['t20_record']).read_text())
            if not placement.same_json(recorder.legacy.legacy.legacy.legacy.legacy.calls,contests.outputs(t20)['calls']) or not placement.same_json(recorder.legacy.legacy.legacy.legacy.legacy.ledger,contests.outputs(t20)['ledger']):raise ValueError('retained T20 differs')
            t16=next(b for m,p,sc,x,b,pre in reb.rep.ai.sub.sources() if m['record']==t22['actions']['source']['t20_record'])
            if not placement.same_json(recorder.legacy.legacy.legacy.legacy.legacy.tail.calls,contests.outputs(t16)['calls']):raise ValueError('retained T16 differs')
            source = t16['actions']['source']; trace = contests.events(ROOT/source['trace'])
            if week.events != trace[1:-1]:
                raise ValueError('new original week differs from T08')
            ok, lines = match.compare(week.events, source['start_state_sha256'], ROOT/source['t04_record_path'])
            if not ok:
                raise ValueError('ordered DOSBox-X comparison failed')
            rows = cases_for(recorder.calls, contests.outputs(t25)['calls'], meta['week'])
        except (Exception, KeyboardInterrupt) as exc:
            status = f'aborted: {type(exc).__name__}: {exc}'
        n = max(match.next_number(RUNS, 'T28-r*.json'), match.next_number(FIXTURES, 'T28-r*.jsonl'))
        rid = f'T28-r{n:04d}'; fixture = FIXTURES/(rid+'.jsonl'); placement.write_lines(fixture, rows)
        rec = copy.deepcopy(base)
        rec.update(run_id=rid, experiment='T28', arm='rearrangement', rep=n, code_commit=commit,
                   machine=cycle.machine_id(), started=started, ended=match.utc(), status=status,
                   actions={'script': 'runtime/emul/rearrangement.py',
                            'source': {'t26_record': meta['record'], 't26_record_sha256': meta['record_sha256'], 't26_cases_sha256': meta['cases_sha256']},
                            'game_files': {name: hashlib.sha256(b).hexdigest() for name, b in week.files_at_start.items()}},
                   outputs=[{'name': 'calls', 'value': recorder.calls}],
                   observations=[{'step': 0, 'source': 'file', 'field': 'fixture path', 'value': match.rel(fixture)},
                                 {'step': 0, 'source': 'file', 'field': 'fixture sha256', 'value': contests.sha(fixture)},
                                 {'step': 1, 'source': 'log', 'field': 'ordered DOSBox-X comparison', 'value': '\n'.join(lines)}])
        rec['runtime'] = {'harness': f'runtime/emul/rearrangement.py@{commit}', 'unicorn': unicorn.__version__,
                          'python': platform.python_version(), 'dos_clock': week.g.clock,
                          'settings': {k: getattr(guest, k) for k in ('INSTR_PER_S', 'KEY_HOLD', 'PIT_HZ', 'SLICE_MAX')}}
        rec['interventions'] = [{'level': 'I3', 'what': 'guest.py services and read-only rearrangement hooks'}]
        match.write_record(RUNS/(rid+'.json'), rec)
        print(f'{rid}: {status}; {len(rows)} refresh cases', flush=True)
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
        if (index['weeks'], index['calls'], index['draws']) != (1, 2, 0):
            raise ValueError('incomplete original AI coverage')
        if not placement.same_json(index, json.loads((FIXTURES/'index.json').read_text())):
            raise ValueError('AI index differs')
    except (ValueError, OSError, KeyError, TypeError, StopIteration) as exc:
        print(f'rearrangement check: FAIL: {exc}'); return 1
    print(f'rearrangement check: ok ({index["calls"]} calls, {index["draws"]} draws)')
    return 0


if __name__ == '__main__':
    raise SystemExit(main())
