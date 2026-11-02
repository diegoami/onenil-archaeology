#!/usr/bin/env python3
"""T38: named incoming setup data and original preparation boundaries;no engine model."""
import argparse,copy,hashlib,json,platform
import halftime_continuity as prior
ROOT=prior.ROOT
raw,contests,match,placement=prior.raw,prior.contests,prior.match,prior.placement
initials=prior.prior
reb=prior.pairing.prior.reb
RUNS,FIXTURES=ROOT/'runs/T38',ROOT/'traces/T38'
SITES=('0AB9:E24C','0AB9:E24F','0AB9:86E9','0AB9:E2D4','0AB9:E2D9','0AB9:E2EF',
       '0AB9:E303','0AB9:E008','0AB9:7D86','0AB9:7DC8','0AB9:DD02')
STATIC=tuple(dict.fromkeys((*prior.STATIC,'static/1-0-exe/code/seg_1B55_04.asm','static/1-0-exe/code/seg_24BC_02.asm','static/1-0-exe/code/seg_1998_01.asm','static/1-0-exe/code/seg_1998_02.asm')))

def state(week):
    g=week.g;index=g.rd(0xD6DD,1)
    cells={'numeric_weights':[{'code':code,'value':g.rd(0x097A+code,1)} for code in (0,59)],
           'reserve_cell':{'index':index,'value':g.rd(0xD58+index,1)},
           'scene_mode':g.mem(g.far(0xDCC0)+23,1)[0],
           'club_fields':[{'club':g.rd(off),**{f'byte{k}':reb.far_value(g,0xD7C2,62*(g.rd(off)-1)+k,1) for k in (37,54,55,57)}} for off in (0xD6E4,0xD6E6)]}
    return {'initial':initials.initial(week),'caller':prior.snapshot(g),'setup_cells':cells}

def admission(s):
    # Structural projection only. Derived selectors/scenes/clock/seed are assertions.
    a=s['initial'];c=s['caller'];outer=c['pairing']['context']['rebuild']['outer']
    return {'players':outer['players'],'clubs':outer['selection']['clubs'],'config':a['config'],
            'read_sets':{'setup_cells':s['setup_cells'],'ratings':a['ratings'],'skills':a['skills'],
                         'positions':a['positions']['positions'],'signs':a['positions']['signs'],
                         'pairing_flags':c['pairing']['club_flags'],'pairing_preferences':c['pairing']['preferences'],
                         'codes':{k:c['codes'][k] for k in ('direction_signs','codes','role_codes')},
                         'club_counts':c['pairing']['context']['rebuild']['club_counts'],
                         'globals':outer['globals'],'directions':outer['directions'],
                         'scorer_slots':a['scorer_slots'],'minute_limits':a['minute_limits'],'threshold':a['threshold'],
                         'goal_numeric':{k:a['goals'][k] for k in ('position_deltas','event_weights')},
                         'event_weights':a['events']['weights'],'clock_reload':a['clock']['reload'],
                         'reset_strategy':a['reset']['strategy'],'reset_signs':a['reset']['signs'],
                         'extra_home_bonus':a['extra']['home_bonus'],'cache_criteria':a['positions']['context']['criteria']},
            'legacy':{'cached_players':outer['cached_players'],'cache':a['positions']['context']['cache'],
                      'managed_clubs':outer['selection']['managed_clubs'],'preferences':outer['selection']['preferences'],
                      'allowance':outer['selection']['allowance'],'cpu_class':c['pairing']['context']['cpu_class'],
                      'ratings':c['ratings'],'gates':c['gates'],'history':a['history']}}

def income_input(g,club):
    cfg=g.mem(g.far(0xD7D2),1)[0]
    fixture=reb.far_value(g,0xD7CA,174*club+3*cfg-177,1)
    flags=reb.far_value(g,0xD7CA,174*club+3*cfg-175,1)
    return {'club':club,'config':cfg,'fixture':fixture,'fixture_flags':flags,
            'club54':reb.far_value(g,0xD7C2,62*(club-1)+54,1),'strength':g.rd(0xD935+club,1),
            'allowance':g.rd(0xD6DD,1),'table':[{'index':i,'value':g.rd(0x1022+i,1)} for i in range(24)],
            'minimums':[g.rd(0x1086+i,1) for i in range(2)]}

class Recorder(prior.Recorder):
    def __init__(self,week):
        super().__init__(week)
        self.setup_points=[];self.setup_admission=None;self.setup_done=False;self.incomes=[];self.income=None
        for site in SITES:week.g.code_hook(site,lambda g,site=site:self.setup_point(g,site))
        week.g.code_hook('1B55:2735',self.income_enter);week.g.code_hook('1B55:284A',self.income_leave)
    def setup_point(self,g,site):
        if not self.legacy.active or self.setup_done:return
        s=state(self.week)
        self.setup_points.append({'site':site,'draw':self.week.draws,'state':s,'income_total':g.rd(0xD6E8,4)})
        if site=='0AB9:86E9':
            if self.setup_admission is not None:raise ValueError('duplicate setup admission')
            self.setup_admission=admission(s)
        if site=='0AB9:DD02':self.setup_done=True
    def income_enter(self,g):
        if not self.legacy.active or self.setup_done:return
        if self.income is not None:raise ValueError('nested setup income')
        club=g.stack_word(2)
        self.income={'caller':g.image_address(g.reg('cs'),g.stack_word(0)),
                     'input':income_input(g,club),'draw_start':self.week.draws}
    def income_leave(self,g):
        if self.income is None:return
        self.income.update(result=g.reg('ax')|(g.reg('dx')<<16),draw_end=self.week.draws)
        self.incomes.append(self.income);self.income=None

def t37_capture(rec,base):
    m36=base['actions']['source']['t36_record'];b36=json.loads((ROOT/m36).read_text())
    b35=json.loads((ROOT/b36['actions']['source']['t35_record']).read_text())
    m15,r15=prior.t15_source(next(m['week'] for m,_ in prior.sources() if m['record']==m36))
    observed={k:getattr(rec.rates,k) for k in ('sides','players','bonuses','handoffs')};observed['contests']=rec.rates.contests.calls
    if not placement.same_json(observed,contests.outputs(r15)):raise ValueError('retained full T15 differs')
    retained={'t36_calls':initials.digest(rec.legacy.calls),'t36_admission':initials.digest(rec.legacy.admission),
              'upstream':initials.retained_capture(rec.legacy,b35),'t15':{k:initials.digest(v) for k,v in observed.items()}}
    value={'initial':rec.initial,'rearrangements':rec.rearrangements,'phases':rec.phases,'outside_ratings':rec.outside_ratings,'retained':retained}
    if not placement.same_json(value,contests.outputs(base)):raise ValueError('retained complete T37 differs')
    return value,b35

def validate_state(s):
    raw.keys(s,'initial caller setup_cells');a=s['initial'];c=s['caller']
    cells=s['setup_cells'];raw.keys(cells,'numeric_weights reserve_cell scene_mode club_fields')
    if [v['code'] for v in cells['numeric_weights']]!=[0,59]:raise ValueError('setup numeric weights incomplete')
    for v in cells['numeric_weights']:raw.keys(v,'code value');raw.integer(v['value'],0,255)
    raw.keys(cells['reserve_cell'],'index value')
    for v in cells['reserve_cell'].values():raw.integer(v,0,255)
    if cells['reserve_cell']['index']!=a['extra']['d6dd']:raise ValueError('reserve allowance alias differs')
    raw.integer(cells['scene_mode'],0,4)
    if [v['club'] for v in cells['club_fields']]!=[v['club'] for v in a['ratings']['bonuses']]:raise ValueError('setup club fields incomplete')
    for v in cells['club_fields']:
        raw.keys(v,'club byte37 byte54 byte55 byte57')
        for key in ('byte37','byte54','byte55','byte57'):raw.integer(v[key],0,255)
    mode=c['gates']['quick'];raw.integer(mode,0,1)
    aliases=[a['events']['mode'],a['reset']['mode'],a['neutral']['quick_mode'],c['pairing']['context']['rebuild']['outer']['globals']['mode']]
    raw.vector(aliases,4,1)
    if any(value!=mode for value in aliases):raise ValueError('setup mode aliases differ')
    # [designed] T36's event/reset schemas have quick-entry guards,not general
    # preparation domains. Validate their unchanged shapes on a local copy;
    # actual captured modes are checked above and by the fixed stage census.
    # This copy never enters a capture or an engine,and the source is untouched.
    probe=copy.deepcopy(a);probe['events']['mode']=1;probe['reset']['mode']=1
    initials.validate_initial(probe);prior.validate_state(c)
    if not placement.same_json(s['initial']['positions']['context']['context'],s['caller']['pairing']['context']):raise ValueError('setup context alias differs')

def validate_observations(o,base,draws):
    raw.keys(o,'admission points incomes draws retained')
    points=o['points']
    if [p['site'] for p in points]!=list(SITES):raise ValueError('setup boundary census/order differs')
    expected=[0,255,255,256,258,258,258,258,258,258,258]
    for p,cursor in zip(points,expected):
        raw.keys(p,'site draw state income_total');raw.integer(p['draw'],0,258);raw.integer(p['income_total'],0,0xFFFFFFFF)
        if p['draw']!=cursor:raise ValueError('setup boundary draw differs')
        validate_state(p['state'])
        if p['state']['caller']['gates']['quick']!=(0 if p['site']=='0AB9:E303' else 1):raise ValueError('actual preparation mode census differs')
    if not placement.same_json(o['admission'],admission(points[2]['state'])):raise ValueError('incoming selected-squad admission differs')
    if not placement.same_json(o['draws'],draws) or len(draws)!=258:raise ValueError('actual ordered setup draws differ')
    if [d['n'] for d in draws[:255]]!=[16]*255 or [d['n'] for d in draws[256:]]!=[999,999]:raise ValueError('setup draw sites/bounds differ')
    for p in points[1:]:
        if p['state']['caller']['seed']!=draws[p['draw']-1]['seed_after']:raise ValueError('setup seed boundary differs')
    if any(p['state']['setup_cells']!=points[2]['state']['setup_cells'] for p in points[2:]):raise ValueError('setup raw read-only cells changed')
    constants={}
    for p in points:
        a=p['state']['initial'];c=p['state']['caller']
        if a['ratings']['tables']!=points[0]['state']['initial']['ratings']['tables']:raise ValueError('read-only rating tables changed')
        for skill in a['skills']:
            for v in skill['state']['lookups']:
                for offset,index,value in [(0x957D,v['first_index'],v['first_cell']),(0x96B1,v['second_index'],v['second_cell'])]:
                    address=(offset+index)&65535
                    if constants.setdefault(address,value)!=value:raise ValueError('raw read-only table alias differs')
        if c['pairing']['preferences']!=points[0]['state']['caller']['pairing']['preferences']:raise ValueError('read-only pairing preferences changed')
    if points[1]['state']['initial']['selectors']!=points[-1]['state']['initial']['selectors']:raise ValueError('generated selectors changed before kickoff')
    old=contests.outputs(base)
    if not placement.same_json(points[-1]['state']['caller'],old['initial']):raise ValueError('initial T37 caller join differs')
    b36=json.loads((ROOT/base['actions']['source']['t36_record']).read_text())
    if not placement.same_json(points[-1]['state']['initial'],contests.outputs(b36)['admission']):raise ValueError('initial T36 join differs')
    incomes=o['incomes']
    if [(c['caller'],c['draw_start'],c['draw_end']) for c in incomes]!=[('1B55:2882',256,257),('1B55:288B',257,258)]:raise ValueError('income caller/draw census differs')
    for c in incomes:
        raw.keys(c,'caller input result draw_start draw_end');raw.integer(c['result'],0,0xFFFFFFFF)
        s=c['input'];raw.keys(s,'club config fixture fixture_flags club54 strength allowance table minimums')
        raw.integer(s['club'],1,176)
        for k in ('config','fixture','fixture_flags','club54','strength','allowance'):raw.integer(s[k],0,255)
        raw.vector(s['minimums'],2,255)
        if [r['index'] for r in s['table']]!=list(range(24)):raise ValueError('income indexed table incomplete')
        for r in s['table']:raw.keys(r,'index value');raw.integer(r['value'],0,255)
    if [c['input']['club'] for c in incomes]!=[c['id'] for c in o['admission']['clubs']]:raise ValueError('income club order differs')
    if o['retained']!=initials.digest(old):raise ValueError('retained complete T37 digest differs')

def sources():
    idx=prior.build_index()
    if not placement.same_json(idx,json.loads((prior.FIXTURES/'index.json').read_text())):raise ValueError('T37 manifest differs')
    for m in idx['records']:yield m,json.loads((ROOT/m['record']).read_text())

def setup_draws(base):
    b36=json.loads((ROOT/base['actions']['source']['t36_record']).read_text())
    b35=json.loads((ROOT/b36['actions']['source']['t35_record']).read_text())
    _,_,src,_=initials.source_data(b35)
    trace=ROOT/src['trace']
    return [e for e in contests.events(trace) if e['kind']=='draw'][:258],src

def selected_runs():
    out={}
    for p in sorted(RUNS.glob('T38-r*.json')):
        r=json.loads(p.read_text())
        if r['status']=='completed':
            key=r['actions']['source']['t37_record']
            if key in out:raise ValueError('duplicate completed setup week')
            out[key]=(p,r)
    return out

def fixture_rows(o,week):
    return [{'schema':'setup-admission/1','week':week,'state':o['admission']},
            *[{'schema':'setup-boundary/1','week':week,**v} for v in o['points']],
            *[{'schema':'setup-income/1','week':week,**v} for v in o['incomes']],
            *[{'schema':'setup-draw/1','week':week,'event':v} for v in o['draws']]]

def build_index():
    srcs=list(sources());have=selected_runs();records=[]
    if set(have)!={m['record'] for m,_ in srcs}:raise ValueError('missing/extra setup week')
    for meta,base in srcs:
        path,r=have[meta['record']];draws,_=setup_draws(base)
        expected={'t37_record':meta['record'],'t37_record_sha256':meta['record_sha256'],'t37_cases_sha256':meta['cases_sha256']}
        if r['actions']['source']!=expected or r['start_state']!=base['start_state'] or r['actions']['game_files']!=base['actions']['game_files']:raise ValueError('setup provenance differs')
        o=contests.outputs(r);validate_observations(o,base,draws);obs={v['field']:v['value'] for v in r['observations']};f=ROOT/obs['fixture path']
        if f.parent!=FIXTURES or contests.sha(f)!=obs['fixture sha256'] or not placement.same_json(contests.events(f),fixture_rows(o,meta['week'])):raise ValueError('setup fixture differs')
        records.append({'record':match.rel(path),'record_sha256':contests.sha(path),'cases':f.name,'cases_sha256':contests.sha(f),'week':meta['week'],'admissions':1,'boundaries':len(o['points']),'incomes':len(o['incomes']),'draws':len(o['draws']),'producer_commit':r['code_commit']})
    return {'schema':'match-setup-corpus/1','records':records,'t37_index_sha256':contests.sha(prior.FIXTURES/'index.json'),'static_sources':{p:contests.sha(ROOT/p) for p in STATIC}}

def run():
    import cycle,guest,unicorn
    if match.git('status','--porcelain','--','runtime/emul'):raise SystemExit('commit observer before capture')
    commit=match.git('rev-parse','HEAD');have=selected_runs();RUNS.mkdir(parents=True,exist_ok=True);FIXTURES.mkdir(parents=True,exist_ok=True)
    for meta,base in sources():
        if meta['record'] in have:print('already recorded '+meta['record'],flush=True);continue
        draws,src=setup_draws(base);_,data=match.find_state(base['start_state']['sha256']);started=match.utc();week=match.Week(data);rec=Recorder(week);lines=[];status='completed';retained=None
        try:
            week.play(on_boundary=lambda w:print(f'original week:screen{w.screen_i},draws{w.draws}',flush=True))
            if week.g.unsupported or not rec.setup_done or rec.income is not None or rec.rr is not None or rec.rate is not None or rec.half or rec.legacy.pending is not None:raise ValueError('incomplete setup capture')
            old,_=t37_capture(rec,base);retained=initials.digest(old)
            if week.events!=contests.events(ROOT/src['trace'])[1:-1]:raise ValueError('T08 event stream differs')
            actual=[e for e in week.events if e['kind']=='draw'][:258]
            if actual!=draws:raise ValueError('retained ordered setup draws differ')
            ok,lines=match.compare(week.events,src['start_state_sha256'],ROOT/src['t04_record_path'])
            if not ok:raise ValueError('ordered DOSBox-X comparison failed')
            validate_observations({'admission':rec.setup_admission,'points':rec.setup_points,'incomes':rec.incomes,'draws':actual,'retained':retained},base,draws)
        except (Exception,KeyboardInterrupt) as exc:status=f'aborted: {type(exc).__name__}: {exc}'
        o={'admission':rec.setup_admission,'points':rec.setup_points,'incomes':rec.incomes,'draws':[e for e in week.events if e['kind']=='draw'][:258],'retained':retained}
        n=max(match.next_number(RUNS,'T38-r*.json'),match.next_number(FIXTURES,'T38-r*.jsonl'));rid=f'T38-r{n:04d}';f=FIXTURES/(rid+'.jsonl');placement.write_lines(f,fixture_rows(o,meta['week']));r=copy.deepcopy(base)
        r.update(run_id=rid,experiment='T38',arm='match_setup',rep=n,code_commit=commit,machine=cycle.machine_id(),started=started,ended=match.utc(),status=status,
                 actions={'script':'runtime/emul/match_setup.py','source':{'t37_record':meta['record'],'t37_record_sha256':meta['record_sha256'],'t37_cases_sha256':meta['cases_sha256']},'game_files':{k:hashlib.sha256(v).hexdigest() for k,v in week.files_at_start.items()}},
                 outputs=[{'name':k,'value':v} for k,v in o.items()],observations=[{'step':0,'source':'file','field':'fixture path','value':match.rel(f)},{'step':0,'source':'file','field':'fixture sha256','value':contests.sha(f)},{'step':1,'source':'log','field':'ordered DOSBox-X comparison','value':'\n'.join(lines)}])
        r['runtime']={'harness':f'runtime/emul/match_setup.py@{commit}','unicorn':unicorn.__version__,'python':platform.python_version(),'dos_clock':week.g.clock,'settings':{k:getattr(guest,k) for k in ('INSTR_PER_S','KEY_HOLD','PIT_HZ','SLICE_MAX')}};r['interventions']=[{'level':'I3','what':'guest.py services and read-only match_setup hooks'}];match.write_record(RUNS/(rid+'.json'),r)
        print(f'{rid}: {status};{len(rec.setup_points)} setup boundaries',flush=True)
        if status!='completed':raise SystemExit(1)
    index=build_index();path=FIXTURES/'index.json'
    if path.exists():
        if not placement.same_json(index,json.loads(path.read_text())):raise ValueError('existing manifest differs')
    else:
        with path.open('x') as f:f.write(json.dumps(index,indent=2)+'\n')

def main(argv=None):
    ap=argparse.ArgumentParser(description=__doc__);g=ap.add_mutually_exclusive_group(required=True);g.add_argument('--run',action='store_true');g.add_argument('--check',action='store_true');args=ap.parse_args(argv)
    if args.run:run();return 0
    try:
        index=build_index()
        if not placement.same_json(index,json.loads((FIXTURES/'index.json').read_text())):raise ValueError('setup manifest differs')
    except (ValueError,OSError,KeyError,IndexError,TypeError) as exc:print('match-setup check:FAIL: '+str(exc));return 1
    print('match-setup check:ok (selected-squad admission,ordered preparation and258 original draws)');return 0
if __name__=='__main__':raise SystemExit(main())
