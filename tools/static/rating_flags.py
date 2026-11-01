#!/usr/bin/env python3
"""T27: compact projections of original 53FB observations, never calculated effects."""
import argparse
import copy
import hashlib
import json
import sys
from pathlib import Path

ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT/'runtime/emul'))
import replacement as rep

OUT=ROOT/'traces/T27'
CASES=OUT/'cases.jsonl'
INDEX=OUT/'index.json'
STATIC=('static/1-0-exe/code/seg_1B55_08.asm','static/1-0-exe/code/seg_232A_01.asm','static/1-0-exe/code/seg_24BC_01.asm')
FIELDS=('p8_1','p8_3','p8_5','p8_6','flags10')


def project(calls,meta):
    rows=[]
    for ordinal,c in enumerate(calls):
        selected=[(i,e) for i,e in enumerate(c['helpers']) if e['site']=='0AB9:AFDA']
        if len(selected)!=1:raise ValueError('one rating/flag helper per original replacement required')
        index,e=selected[0]
        for k in ('input','output'):rep.validate_state(e[k])
        rep.raw.vector(e['arguments'],1,3920);identifier=e['arguments'][0]
        before=next(p for p in e['input']['players'] if p['id']==identifier)
        after=next(p for p in e['output']['players'] if p['id']==identifier)
        cleaned=copy.deepcopy(e['output'])
        next(p for p in cleaned['players'] if p['id']==identifier)['p15_10']=before['p15_10']
        if cleaned!=e['input']:raise ValueError('53FB changed an unrelated named field')
        if e['draw_start']!=e['draw_end']:raise ValueError('rating/flag helper unexpectedly draws RNG')
        rows.append({'schema':'rating-flags-case/1','week':meta['week'],'step':c['step'],'replacement':ordinal,
                     'helper':index,'player':identifier,
                     'input':{**{k:before[k] for k in FIELDS[:-1]},'flags10':before['p15_10']},
                     'output':{'flags10':after['p15_10']},'draw_start':e['draw_start'],'draw_end':e['draw_end'],
                     'source':{'record':meta['record'],'record_sha256':meta['record_sha256'],
                               'cases':str((rep.FIXTURES/meta['cases']).relative_to(ROOT)),'cases_sha256':meta['cases_sha256']}})
    return rows


def validate(rows):
    for i,c in enumerate(rows):
        rep.raw.keys(c,'schema week step replacement helper player input output draw_start draw_end source')
        if c['schema']!='rating-flags-case/1':raise ValueError('unknown compact rating/flag schema')
        for k in ('step','replacement','helper','draw_start','draw_end'):rep.raw.integer(c[k],0,10**9)
        rep.raw.integer(c['player'],0,3920)
        rep.raw.keys(c['input'],' '.join(FIELDS));rep.raw.keys(c['output'],'flags10')
        for value in c['input'].values():rep.raw.integer(value,0,255)
        rep.raw.integer(c['output']['flags10'],0,255)
        if c['draw_start']!=c['draw_end']:raise ValueError('nonzero compact draw interval')
        rep.raw.keys(c['source'],'record record_sha256 cases cases_sha256')


def build():
    source=rep.build_index()
    if not rep.placement.same_json(source,json.loads((rep.FIXTURES/'index.json').read_text())):raise ValueError('retained T25 manifest differs')
    rows=[]
    for meta in source['records']:
        rec=json.loads((ROOT/meta['record']).read_text())
        rows.extend(project(rep.contests.outputs(rec)['calls'],meta))
    validate(rows)
    if len(rows)!=25 or len(source['records'])!=6:raise ValueError('incomplete original rating/flag coverage')
    payload=''.join(json.dumps(c,sort_keys=True)+'\n' for c in rows).encode()
    index={'schema':'rating-flags-corpus/1','count':len(rows),'weeks':len(source['records']),
           'cases':str(CASES.relative_to(ROOT)),'cases_sha256':hashlib.sha256(payload).hexdigest(),
           't25_index_sha256':rep.contests.sha(rep.FIXTURES/'index.json'),
           'static_sources':{p:rep.contests.sha(ROOT/p) for p in STATIC}}
    return rows,payload,index


def check_rows(actual,expected):
    validate(actual)
    if not rep.placement.same_json(actual,expected):raise ValueError('compact original rating/flag cases differ')


def write(payload,index):
    if CASES.exists() or INDEX.exists():raise FileExistsError('compact original exports are immutable; use a new version')
    CASES.parent.mkdir(parents=True,exist_ok=True)
    with CASES.open('xb') as f:f.write(payload)
    with INDEX.open('x') as f:f.write(json.dumps(index,indent=2)+'\n')


def main(argv=None):
    ap=argparse.ArgumentParser(description=__doc__);m=ap.add_mutually_exclusive_group(required=True)
    m.add_argument('--write',action='store_true');m.add_argument('--check',action='store_true');args=ap.parse_args(argv)
    try:
        rows,payload,index=build()
        if args.write:write(payload,index)
        else:
            check_rows(rep.contests.events(CASES),rows)
            if CASES.read_bytes()!=payload or rep.contests.sha(CASES)!=index['cases_sha256']:raise ValueError('compact fixture bytes/digest differ')
            if not rep.placement.same_json(index,json.loads(INDEX.read_text())):raise ValueError('compact manifest differs')
    except (ValueError,OSError,KeyError,IndexError,TypeError,StopIteration) as exc:
        print(f'rating/flag contract check: FAIL: {exc}');return 1
    print('rating/flag contract check: ok (25 original cases, six weeks, zero draws)');return 0


if __name__=='__main__':raise SystemExit(main())
