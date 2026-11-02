#!/usr/bin/env python3
"""T37: initial caller read set and actual halftime boundaries;no engine calculations."""
import argparse,copy,hashlib,json,platform
import match_continuity as prior
import role_pairing as pairing
import scene_codes as codes
ROOT=prior.ROOT
raw,contests,match,placement=prior.raw,prior.contests,prior.match,prior.placement
RUNS,FIXTURES=ROOT/'runs/T37',ROOT/'traces/T37'
GATES={'cache_gate':(0xD18,1),'editor':(0xD1CB,1),'kickoff_side':(0xD0AD,1),'delay_word':(0xD0BE,2),
       'control':(0xD0BA,1),'d0a1':(0xD0A1,1),'cf53':(0xCF53,1),'active':(0xD0B8,1),'quick':(0xD074,1)}
PHASES=('0AB9:7DD3','0AB9:7E4C','0AB9:7E4F','0AB9:7E6E','0AB9:7E71')
STATIC=('static/1-0-exe/code/seg_0AB9_03.asm','static/1-0-exe/code/seg_0AB9_13.asm',
        'static/1-0-exe/code/seg_0AB9_20.asm','static/1-0-exe/code/seg_0AB9_21.asm',
        'static/1-0-exe/code/seg_1B55_05.asm','static/1-0-exe/code/seg_1B55_08.asm',
        'static/1-0-exe/code/seg_0AB9_14.asm','static/1-0-exe/code/seg_0AB9_16.asm',
        'static/1-0-exe/code/seg_0AB9_17.asm','static/1-0-exe/code/seg_0AB9_19.asm')
RR_CALLERS=('0AB9:8887','0AB9:D5F7','0AB9:D900','0AB9:C430','0AB9:B0C9','0AB9:A89C')

def snapshot(g):return {'pairing':pairing.snapshot(g),'codes':codes.snapshot(g),'gates':{k:g.rd(off,n) for k,(off,n) in GATES.items()},'ratings':prior.ratings.rating_words(g),'seed':g.word_at(g.far(0xDE84))}
def validate_state(s):
    raw.keys(s,'pairing codes gates ratings seed');pairing.validate_state(s['pairing']);codes.validate_state(s['codes'])
    if not placement.same_json(s['pairing']['context'],s['codes']['context']):raise ValueError('caller shared context differs')
    raw.keys(s['gates'],' '.join(GATES))
    for k,(_,n) in GATES.items():raw.integer(s['gates'][k],0,255 if n==1 else 65535)
    raw.vector(s['ratings'],8,65535);raw.integer(s['seed'])

def point(g,week,site):return {'site':site,'step':len(week.recorder.legacy.calls),'draw':week.draws,'state':snapshot(g)}

class Recorder:
    def __init__(self,week):
        self.week=week;self.legacy=prior.Recorder(week);self.rates=prior.ratings.Recorder(week)
        self.initial=None;self.rearrangements=[];self.phases=[];self.outside_ratings=[];self.rr=self.rate=None;self.half=False
        week.recorder=self
        for at,fn in {'0AB9:DD02':self.admit,'0AB9:164F':self.rearrange_enter,'0AB9:199E':self.rearrange_leave,
                      '1B55:50EB':self.rating_enter,'1B55:5281':self.rating_leave,'1B55:3255':self.quartered,'1B55:3279':self.capped}.items():week.g.code_hook(at,fn)
        for at in PHASES:week.g.code_hook(at,lambda g,at=at:self.phase(g,at))
    def admit(self,g):
        if self.legacy.active and self.initial is None:self.initial=snapshot(g)
    def rearrange_enter(self,g):
        if not self.legacy.active:return
        if self.rr is not None:raise ValueError('nested164F parent')
        self.rr={'caller':g.image_address(g.reg('cs'),g.stack_word(0)),'step':len(self.legacy.calls),'input':snapshot(g),'draw_start':self.week.draws}
    def rearrange_leave(self,g):
        if self.rr is not None:
            self.rr.update(output=snapshot(g),draw_end=self.week.draws);self.rearrangements.append(self.rr);self.rr=None
    def phase(self,g,site):
        if not self.legacy.active:return
        if site==PHASES[0]:
            if self.half or self.phases:raise ValueError('duplicate halftime entry')
            self.half=True
        if self.half:
            self.phases.append(point(g,self.week,site))
            if site==PHASES[-1]:self.half=False
    def rating_enter(self,g):
        if not self.legacy.active:return
        caller=g.image_address(g.stack_word(2),g.stack_word(0))
        if caller!='1B55:322E':return
        if self.rate is not None or self.rates.side is None:raise ValueError('overlapping/missing outside rating')
        self.rate={'caller':caller,'step':len(self.legacy.calls),'draw_start':self.week.draws,'frame':g.reg('bp'),'caps':[]}
    def rating_leave(self,g):
        if self.rate is not None and 'side' not in self.rate:
            self.rate['side']=copy.deepcopy(self.rates.sides[-1]);self.rate['draw_end']=self.week.draws
    def quartered(self,g):
        if self.rate is not None and g.reg('bp')==self.rate['frame']:
            if 'quartered' in self.rate:raise ValueError('duplicate quartering boundary')
            self.rate['quartered']=prior.ratings.rating_words(g)
    def capped(self,g):
        if self.rate is not None and g.reg('bp')==self.rate['frame']:
            self.rate['caps'].append({'class':pairing.prior.local(g,-2),'ratings':prior.ratings.rating_words(g),'draw':self.week.draws})
            if len(self.rate['caps'])==4:
                self.rate.pop('frame');self.outside_ratings.append(self.rate);self.rate=None

def t15_source(week):
    idx=json.loads((ROOT/'traces/T15/index.json').read_text());m=next(r for r in idx['records'] if r['week']==week)
    if contests.sha(ROOT/m['record'])!=m['record_sha256'] or contests.sha(ROOT/'traces/T15'/m['cases'])!=m['cases_sha256']:raise ValueError('T15 source differs')
    return m,json.loads((ROOT/m['record']).read_text())

def validate_observations(o,base,r15):
    raw.keys(o,'initial rearrangements phases outside_ratings retained');validate_state(o['initial'])
    old=contests.outputs(base);context=old['admission']['positions']['context']['context']
    if not placement.same_json(o['initial']['pairing']['context'],context) or o['initial']['seed']!=old['calls'][0]['input']['seed'] or o['initial']['ratings']!=old['calls'][0]['input']['ratings']:raise ValueError('first admission supplement differs')
    if [p['site'] for p in o['phases']]!=list(PHASES):raise ValueError('halftime continuation order incomplete')
    cursor=0
    for p in o['phases']:
        raw.keys(p,'site step draw state');raw.integer(p['step'],0,95);raw.integer(p['draw'],0,2**32);validate_state(p['state'])
        if p['draw']<cursor:raise ValueError('caller draw order differs')
        cursor=p['draw']
    phases=o['phases']
    if [p['step'] for p in phases]!=[46,46,46,46,95] or [p['draw'] for p in phases]!=[3255,3255,3255,3255,6216]:raise ValueError('fixed caller boundaries differ')
    if phases[3]['state']['ratings']!=old['calls'][46]['input']['ratings'] or phases[3]['state']['seed']!=old['calls'][46]['input']['seed']:raise ValueError('second-loop entry projection differs')
    if phases[-1]['state']['seed']!=old['calls'][-1]['clock']['output']['seed']:raise ValueError('final caller seed differs')
    rr=o['rearrangements']
    if not rr:raise ValueError('missing reached164F parents')
    rr_cursor=rr_step=0
    for c in rr:
        raw.keys(c,'caller step input output draw_start draw_end');raw.integer(c['step'],0,95);raw.integer(c['draw_start'],0,2**32);raw.integer(c['draw_end'],c['draw_start'],2**32)
        if c['draw_start']<rr_cursor or c['step']<rr_step:raise ValueError('rearrangement chronology differs')
        rr_cursor,rr_step=c['draw_end'],c['step']
        if c['caller'] not in RR_CALLERS:raise ValueError('unidentified164F caller')
        for k in ('input','output'):validate_state(c[k])
        if c['draw_start']!=c['draw_end'] or c['input']['seed']!=c['output']['seed']:raise ValueError('unexpected164F draws')
        if c['input']['gates']!=c['output']['gates'] or c['input']['pairing']['preferences']!=c['output']['pairing']['preferences']:raise ValueError('rearrangement changed unrelated caller/read-only inputs')
    if [c['step'] for c in rr if c['caller']=='0AB9:B0C9']!=[57,57] or not any(c['caller']=='0AB9:8887' and c['step']==0 for c in rr) or not any(c['caller']=='0AB9:D5F7' and c['step']==46 for c in rr):raise ValueError('required164F setup/halftime/replacement parents missing')
    rates=o['outside_ratings'];all_sides=contests.outputs(r15)['sides']
    if len(rates)!=2:raise ValueError('two outside rating calls required')
    for c,ordinal in zip(rates,(0,93)):
        raw.keys(c,'caller step draw_start draw_end side quartered caps');raw.integer(c['step'],0,95)
        if c['caller']!='1B55:322E' or c['step'] not in (0,46) or not placement.same_json(c['side'],all_sides[ordinal]):raise ValueError('outside T15 rating projection differs')
        if c['draw_start']!=c['draw_end'] or c['draw_start']!=c['side']['draw_start']:raise ValueError('outside rating draw link differs')
        raw.vector(c['quartered'],8,65535)
        if c['quartered'][::2]!=c['side']['output']['ratings'][::2]:raise ValueError('quartering changed unrelated side words')
        if [p['class'] for p in c['caps']]!=list(range(4)):raise ValueError('four ordered cap boundaries required')
        before=c['quartered']
        for p in c['caps']:
            raw.keys(p,'class ratings draw');raw.integer(p['class'],0,3);raw.vector(p['ratings'],8,65535)
            if p['draw']!=c['draw_end']:raise ValueError('cap boundary draw differs')
            if any(x!=y for i,(x,y) in enumerate(zip(before,p['ratings'])) if i!=2*p['class']+1):raise ValueError('cap store changed unrelated words')
            before=p['ratings']
    if rates[0]['caps'][-1]['ratings']!=o['initial']['ratings'] or rates[1]['caps'][-1]['ratings']!=phases[3]['state']['ratings']:raise ValueError('display return/entry ratings differ')
    expected={'t36_calls':prior.digest(old['calls']),'t36_admission':prior.digest(old['admission']),'upstream':old['retained'],
              't15':{k:prior.digest(v) for k,v in contests.outputs(r15).items()}}
    if o['retained']!=expected:raise ValueError('retained observation receipts differ')

def sources():
    idx=prior.build_index()
    if not placement.same_json(idx,json.loads((prior.FIXTURES/'index.json').read_text())):raise ValueError('T36 manifest differs')
    for m in idx['records']:yield m,json.loads((ROOT/m['record']).read_text())
def selected_runs():
    out={}
    for p in sorted(RUNS.glob('T37-r*.json')):
        r=json.loads(p.read_text())
        if r['status']=='completed':
            key=r['actions']['source']['t36_record']
            if key in out:raise ValueError('duplicate completed halftime week')
            out[key]=(p,r)
    return out

def fixture_rows(o,week):
    return [{'schema':'caller-admission/1','week':week,'state':o['initial']},*[{'schema':'caller-rearrangement/1','week':week,**v} for v in o['rearrangements']],*[{'schema':'caller-phase/1','week':week,**v} for v in o['phases']],*[{'schema':'caller-rating/1','week':week,**v} for v in o['outside_ratings']]]
def build_index():
    srcs=list(sources());have=selected_runs();records=[]
    if set(have)!={m['record'] for m,_ in srcs}:raise ValueError('missing/extra halftime week')
    for meta,base in srcs:
        path,r=have[meta['record']];m15,r15=t15_source(meta['week']);expected={'t36_record':meta['record'],'t36_record_sha256':meta['record_sha256'],'t36_cases_sha256':meta['cases_sha256'],'t15_record':m15['record'],'t15_record_sha256':m15['record_sha256']}
        if r['actions']['source']!=expected or r['start_state']!=base['start_state'] or r['actions']['game_files']!=base['actions']['game_files']:raise ValueError('halftime provenance differs')
        o=contests.outputs(r);validate_observations(o,base,r15);obs={v['field']:v['value'] for v in r['observations']};f=ROOT/obs['fixture path']
        if f.parent!=FIXTURES or contests.sha(f)!=obs['fixture sha256'] or not placement.same_json(contests.events(f),fixture_rows(o,meta['week'])):raise ValueError('halftime fixture differs')
        records.append({'record':match.rel(path),'record_sha256':contests.sha(path),'cases':f.name,'cases_sha256':contests.sha(f),'week':meta['week'],'admissions':1,'rearrangements':len(o['rearrangements']),'phases':len(o['phases']),'outside_ratings':len(o['outside_ratings']),'producer_commit':r['code_commit']})
    return {'schema':'halftime-continuity-corpus/1','records':records,'t36_index_sha256':contests.sha(prior.FIXTURES/'index.json'),'static_sources':{p:contests.sha(ROOT/p) for p in STATIC}}

def run():
    import cycle,guest,unicorn
    if match.git('status','--porcelain','--','runtime/emul'):raise SystemExit('commit observer before capture')
    commit=match.git('rev-parse','HEAD');have=selected_runs();RUNS.mkdir(parents=True,exist_ok=True);FIXTURES.mkdir(parents=True,exist_ok=True)
    for meta,base in sources():
        if meta['record'] in have:print('already recorded '+meta['record'],flush=True);continue
        m15,r15=t15_source(meta['week']);_,data=match.find_state(base['start_state']['sha256']);started=match.utc();week=match.Week(data);recorder=Recorder(week);lines=[];status='completed';retained={}
        try:
            week.play(on_boundary=lambda w:print(f'original week:screen{w.screen_i},draws{w.draws}',flush=True))
            if week.g.unsupported or recorder.rr is not None or recorder.rate is not None or recorder.half or recorder.legacy.pending is not None:raise ValueError('incomplete halftime capture')
            old=contests.outputs(base)
            if not placement.same_json(recorder.legacy.calls,old['calls']) or not placement.same_json(recorder.legacy.admission,old['admission']):raise ValueError('retained T36 differs')
            b35=json.loads((ROOT/base['actions']['source']['t35_record']).read_text());upstream=prior.retained_capture(recorder.legacy,b35)
            observed={k:getattr(recorder.rates,k) for k in ('sides','players','bonuses','handoffs')};observed['contests']=recorder.rates.contests.calls
            if not placement.same_json(observed,contests.outputs(r15)):raise ValueError('retained full T15 differs')
            retained={'t36_calls':prior.digest(recorder.legacy.calls),'t36_admission':prior.digest(recorder.legacy.admission),'upstream':upstream,'t15':{k:prior.digest(v) for k,v in observed.items()}}
            _,_,src,_=prior.source_data(b35)
            if week.events!=contests.events(ROOT/src['trace'])[1:-1]:raise ValueError('T08 event stream differs')
            ok,lines=match.compare(week.events,src['start_state_sha256'],ROOT/src['t04_record_path'])
            if not ok:raise ValueError('ordered DOSBox-X comparison failed')
            validate_observations({'initial':recorder.initial,'rearrangements':recorder.rearrangements,'phases':recorder.phases,'outside_ratings':recorder.outside_ratings,'retained':retained},base,r15)
        except (Exception,KeyboardInterrupt) as exc:status=f'aborted: {type(exc).__name__}: {exc}'
        o={'initial':recorder.initial,'rearrangements':recorder.rearrangements,'phases':recorder.phases,'outside_ratings':recorder.outside_ratings,'retained':retained}
        n=max(match.next_number(RUNS,'T37-r*.json'),match.next_number(FIXTURES,'T37-r*.jsonl'));rid=f'T37-r{n:04d}';f=FIXTURES/(rid+'.jsonl');placement.write_lines(f,fixture_rows(o,meta['week']));r=copy.deepcopy(base)
        r.update(run_id=rid,experiment='T37',arm='halftime_continuity',rep=n,code_commit=commit,machine=cycle.machine_id(),started=started,ended=match.utc(),status=status,
                 actions={'script':'runtime/emul/halftime_continuity.py','source':{'t36_record':meta['record'],'t36_record_sha256':meta['record_sha256'],'t36_cases_sha256':meta['cases_sha256'],'t15_record':m15['record'],'t15_record_sha256':m15['record_sha256']},'game_files':{k:hashlib.sha256(v).hexdigest() for k,v in week.files_at_start.items()}},
                 outputs=[{'name':k,'value':v} for k,v in o.items()],observations=[{'step':0,'source':'file','field':'fixture path','value':match.rel(f)},{'step':0,'source':'file','field':'fixture sha256','value':contests.sha(f)},{'step':1,'source':'log','field':'ordered DOSBox-X comparison','value':'\n'.join(lines)}])
        r['runtime']={'harness':f'runtime/emul/halftime_continuity.py@{commit}','unicorn':unicorn.__version__,'python':platform.python_version(),'dos_clock':week.g.clock,'settings':{k:getattr(guest,k) for k in ('INSTR_PER_S','KEY_HOLD','PIT_HZ','SLICE_MAX')}};r['interventions']=[{'level':'I3','what':'guest.py services and read-only halftime_continuity hooks'}];match.write_record(RUNS/(rid+'.json'),r)
        print(f'{rid}: {status};{len(recorder.rearrangements)} reached164F parents',flush=True)
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
        if not placement.same_json(index,json.loads((FIXTURES/'index.json').read_text())):raise ValueError('halftime manifest differs')
    except (ValueError,OSError,KeyError,IndexError,TypeError) as exc:print('halftime-continuity check:FAIL: '+str(exc));return 1
    print('halftime-continuity check:ok (initial supplement,caller/rearrangement/display-rating boundaries)');return 0
if __name__=='__main__':raise SystemExit(main())
