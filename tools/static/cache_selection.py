#!/usr/bin/env python3
"""T32: compact original 13B8/4EBF cases; no availability, rating or selection model."""
import argparse
import hashlib
import json
import sys
from pathlib import Path

ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT/'runtime/emul'))
import player_cache as prior

OUT=ROOT/'traces/T32'
FILES={kind:OUT/(kind+'.jsonl') for kind in ('selectors','ratings')}
INDEX=OUT/'index.json'
STATIC=('static/1-0-exe/code/seg_0AB9_02.asm','static/1-0-exe/code/seg_1B55_08.asm',
        'static/1-0-exe/code/seg_24BC_01.asm')
RATING_FIELDS=('p8_1','p8_3','p8_5')
SELECTOR_FIELDS=(*RATING_FIELDS,'byte8','flags11')
raw=prior.raw


def project(calls,meta):
    result={kind:[] for kind in FILES}
    try:
        source={'record':meta['record'],'record_sha256':meta['record_sha256'],
                'cases':prior.match.rel(prior.FIXTURES/meta['cases']),'cases_sha256':meta['cases_sha256']}
        for c in calls:
            for event,e in enumerate(c['events']):
                if e['kind'] not in ('select','rating'):continue
                if e['input']!=e['output']:raise ValueError('read-only selection/rating source changed named state')
                if e['draw_start']!=e['draw_end']:raise ValueError('selection/rating source consumed RNG')
                s=e['input']['context']['rebuild']['outer'];players={p['id']:p for p in s['players']}
                common={'week':meta['week'],'step':c['step'],'replacement':c['replacement'],'event':event,
                        'draw_start':e['draw_start'],'draw_end':e['draw_end'],'source':source.copy()}
                if e['kind']=='select':
                    side=e['side']
                    if e['arguments']!=[side]:raise ValueError('original selector side differs')
                    club=s['selection']['clubs'][side];roster=club['roster'][:11]
                    inputs=[]
                    for identifier in sorted(set(roster)):
                        p=players[identifier]
                        inputs.append({'id':identifier,**{k:p[k] for k in RATING_FIELDS},
                                       'byte8':p['p15_8'],'flags11':p['p15_11']})
                    result['selectors'].append({'schema':'cached-selector-case/1',**common,
                        'input':{'side':side,'club':club['id'],'roster':roster,'players':inputs},
                        'output':{'player':e['result']}})
                else:
                    slot,scene,identifier=e['arguments'];p=players[identifier]
                    result['ratings'].append({'schema':'cached-rating-case/1',**common,
                        'side':e['side'],'slot':slot,'scene':scene,'player':identifier,
                        'input':{k:p[k] for k in RATING_FIELDS},'output':{'value':e['result']}})
        for kind,rows in result.items():validate(rows,kind)
        return result
    except (KeyError,IndexError,TypeError,AttributeError) as exc:raise ValueError(f'incomplete compact cache source: {exc}') from exc


def validate(rows,kind):
    if kind not in FILES or not isinstance(rows,list):raise ValueError('unknown compact cache stream')
    for c in rows:
        keys='schema week step replacement event input output draw_start draw_end source'
        if kind=='ratings':keys+=' side slot scene player'
        raw.keys(c,keys)
        if c['schema']!=('cached-selector-case/1' if kind=='selectors' else 'cached-rating-case/1'):
            raise ValueError('unknown compact cache schema')
        if not isinstance(c['week'],str):raise ValueError('missing original week')
        for k in ('step','replacement','event','draw_start','draw_end'):raw.integer(c[k],0,10**9)
        if c['draw_start']!=c['draw_end']:raise ValueError('nonzero compact cache draw interval')
        raw.keys(c['source'],'record record_sha256 cases cases_sha256')
        if kind=='selectors':
            s=c['input'];raw.keys(s,'side club roster players')
            raw.integer(s['side'],0,1);raw.integer(s['club'],1,176);raw.vector(s['roster'],11,3920)
            if not isinstance(s['players'],list) or [p['id'] for p in s['players']]!=sorted(set(s['roster'])):
                raise ValueError('complete ordered canonical selector players required')
            for p in s['players']:
                raw.keys(p,'id '+' '.join(SELECTOR_FIELDS));raw.integer(p['id'],0,3920)
                for k in SELECTOR_FIELDS:raw.integer(p[k],0,255)
            raw.keys(c['output'],'player');raw.integer(c['output']['player'],1,3920)
            if c['output']['player'] not in s['roster']:raise ValueError('original selected player is outside roster')
            witness=next(p for p in s['players'] if p['id']==c['output']['player'])
            # Restricted raw witness for these specimens, never a general availability evaluator.
            if not 1<=witness['byte8']<=127 or witness['flags11']!=0:
                raise ValueError('specimen lacks the positive-byte8/zero-flags defined-call witness')
        else:
            for k,lo,hi in (('side',0,1),('slot',1,11),('scene',1,22),('player',0,3920)):raw.integer(c[k],lo,hi)
            raw.keys(c['input'],' '.join(RATING_FIELDS))
            for v in c['input'].values():raw.integer(v,0,255)
            raw.keys(c['output'],'value');raw.integer(c['output']['value'])


def check_rows(actual,expected,kind):
    validate(actual,kind)
    if not prior.placement.same_json(actual,expected):raise ValueError('compact original cache cases differ')


def build():
    index=prior.build_index()
    if not prior.placement.same_json(index,json.loads((prior.FIXTURES/'index.json').read_text())):
        raise ValueError('retained T31 manifest differs')
    rows={kind:[] for kind in FILES}
    for meta in index['records']:
        record=json.loads((ROOT/meta['record']).read_text())
        projected=project(prior.contests.outputs(record)['calls'],meta)
        for kind in rows:rows[kind].extend(projected[kind])
    if len(index['records'])!=1 or (len(rows['selectors']),len(rows['ratings']))!=(2,44):
        raise ValueError('incomplete original cache selection/rating coverage')
    payloads={kind:''.join(json.dumps(c,sort_keys=True)+'\n' for c in cases).encode() for kind,cases in rows.items()}
    manifest={'schema':'cache-selection-corpus/1','weeks':1,
        'streams':{kind:{'cases':prior.match.rel(FILES[kind]),'count':len(rows[kind]),
                         'cases_sha256':hashlib.sha256(payloads[kind]).hexdigest(),
                         'draws':sum(c['draw_end']-c['draw_start'] for c in rows[kind])} for kind in FILES},
        't31_index_sha256':prior.contests.sha(prior.FIXTURES/'index.json'),
        'static_sources':{p:prior.contests.sha(ROOT/p) for p in STATIC}}
    return rows,payloads,manifest


def write(payloads,manifest):
    outputs={FILES[k]:payloads[k] for k in FILES}
    outputs[INDEX]=(json.dumps(manifest,indent=2)+'\n').encode()
    for path,data in outputs.items():
        if path.exists() and path.read_bytes()!=data:raise FileExistsError('existing compact exports differ; use a new version')
    for path,data in outputs.items():
        if not path.exists():
            path.parent.mkdir(parents=True,exist_ok=True)
            with path.open('xb') as f:f.write(data)


def main(argv=None):
    ap=argparse.ArgumentParser(description=__doc__);m=ap.add_mutually_exclusive_group(required=True)
    m.add_argument('--write',action='store_true');m.add_argument('--check',action='store_true');args=ap.parse_args(argv)
    try:
        rows,payloads,index=build()
        if args.write:write(payloads,index)
        else:
            for kind,path in FILES.items():
                check_rows(prior.contests.events(path),rows[kind],kind)
                if path.read_bytes()!=payloads[kind] or prior.contests.sha(path)!=index['streams'][kind]['cases_sha256']:
                    raise ValueError('compact cache fixture bytes/digest differ')
            if not prior.placement.same_json(index,json.loads(INDEX.read_text())):raise ValueError('compact cache manifest differs')
    except (ValueError,OSError,KeyError,IndexError,TypeError,StopIteration) as exc:
        print(f'cache selection contract check: FAIL: {exc}');return 1
    print('cache selection contract check: ok (2 selectors,44 ratings,one week,zero draws)');return 0


if __name__=='__main__':raise SystemExit(main())
