#!/usr/bin/env python3
"""T87 original pre19CA numeric observations; no native admission or engine model."""
import argparse
from functools import lru_cache
import hashlib
import json
import platform
import re
import struct
import sys
from pathlib import Path

ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT/'runtime/emul'))
import postmatch_tail as tail
import unicorn

sha=tail.sha
encoded=tail.encoded
git=tail.git
LATE=ROOT/'records/T86/tail-r0009.json'
LATE_SHA='1163ecc7f55c46d35a3cc74d80792e8e0bb7511ea21b301792effceef1a7d4d0'
DEPENDENCIES=sorted(set(tail.DEPENDENCIES)|{'runtime/emul/postmatch_incoming.py'})
# Set only after the two immutable originals are independently captured.
ACCEPTED={}


@lru_cache(maxsize=1)
def late_record():
    data=LATE.read_bytes()
    if sha(data)!=LATE_SHA:raise ValueError('accepted T86 footprint digest differs')
    return json.loads(data)


@lru_cache(maxsize=1)
def reference():
    tail.validate(late_record())
    return tail.reference()


def requests():
    """Use only observed field coordinates/widths; discard every late value."""
    caller=late_record()['payload']['caller']
    result=[]
    for item in caller['initial']:
        name=item['field']
        if name.startswith('DS:'):
            coord=dict(region='DS',index=0,offset=int(name[3:],16))
        elif name.startswith('frame:'):
            coord=dict(region='frame',index=0,offset=int(name[6:],16)-caller['frame']['parent_bp'])
        elif name=='seed+0':coord=dict(region='seed',index=0,offset=0)
        else:
            match=re.fullmatch(r'(\w+)\[(\d+)\]\+(\d+)',name)
            if not match:raise ValueError('unclassified source coordinate')
            coord=dict(region=match[1],index=int(match[2]),offset=int(match[3]))
        result.append(dict(field=name,size=item['size'],coordinate=coord))
    if len(result)!=482 or sum(r['size']for r in result)!=583:
        raise ValueError('T86 footprint census differs')
    return result


def source():
    _,base,_=tail.full.reference()
    rows=tail.lineage()
    return dict(state_sha256=base['start_state']['sha256'],
        reference_index_sha256=tail.REFERENCE_SHA,tail_sha256=LATE_SHA,
        lineage_index_sha256=tail.SOURCE_INDEX_SHA,
        observer_sha256=rows['start.json']['observer_sha256'],
        packed_sha256=tail.prior.controlled.PACKED,
        unpacked_sha256=tail.prior.controlled.UNPACKED)


def address(request,context):
    c=request['coordinate'];r=c['region'];o=c['offset'];i=c['index'];size=request['size']
    regs=context['registers']
    if r=='DS' and i==0 and 0<=o<=65536-size:return regs['ds']*16+o
    if r=='seed' and i==0 and o==0 and size==2:return regs['ds']*16+0xA51C
    if r=='frame' and i==0 and (o,size) in [(-7,1),(-6,2),(-2,2),(6,2)]:
        return regs['ss']*16+context['parent_bp']+o
    region=next((x for x in context['regions']if x['name']==r),None)
    if region and region['origin']<=i<region['origin']+region['count'] and 0<=o<=region['stride']-size:
        return region['base']+(i-region['origin'])*region['stride']+o
    raise ValueError('invalid numeric field coordinate')


def authenticate_code(g):
    """Compare loaded code to the packed/unpacked pinned original plus relocations."""
    controlled=tail.prior.controlled
    packed=(ROOT/'.cache/One-Nil96/1-0.EXE').read_bytes()
    if sha(packed)!=controlled.PACKED:raise ValueError('original executable differs')
    unpacked=controlled.unlzexe.unpack(packed)
    if sha(unpacked)!=controlled.UNPACKED:raise ValueError('unpacked executable differs')
    image=controlled.onilexe.Image(unpacked);relocated=bytearray(image.data)
    for at,value in image.reloc_value.items():struct.pack_into('<H',relocated,at,(value+g.load)&65535)
    result={}
    for seg in (0x0AB9,0x1998,0x1B55,0x232A,0x24BC):
        lo,hi=next((a*16,b*16)for a,b in image.code_segments if a==seg)
        actual=g.mem(g.seg(seg)*16,hi-lo)
        if actual!=relocated[lo:hi]:raise ValueError('loaded original code differs: %04X'%seg)
        result['%04X'%seg]=sha(actual)
    return result


def context(g):
    regs=tail.prior.registers(g);bp=regs['bp'];ss=regs['ss']*16
    parent=g.word_at(ss+bp)
    match_frame=dict(bp=bp,saved_parent=parent,return_ip=g.word_at(ss+bp+2),
                     week_slot=g.word_at(ss+bp+4),club=g.word_at(ss+bp+6))
    frame={str(off):int.from_bytes(g.mem(ss+parent+off,size),'little')
           for off,size in [(-7,1),(-6,2),(-2,2),(6,2)]}
    club=g.rd(0xD4FB+frame['-2'],1);week=frame['6']
    fixture=g.far(0xD7CA)+174*(club-1)+3*(week-1)
    regions=[]
    for name,(slot,count,stride,origin) in tail.POOL_SPECS.items():
        offset,segment=struct.unpack('<HH',g.mem(g.DS*16+slot,4))
        regions.append(dict(name=name,pointer=slot,count=count,stride=stride,origin=origin,
                            offset=offset,segment=segment,base=segment*16+offset))
    return dict(registers=regs,parent_bp=parent,match_frame=match_frame,parent_frame=frame,
        fixture=dict(week_slot=week,schedule_index=frame['-2'],detailed=frame['-7'],club=club,
                     opponent=g.mem(fixture+1,1)[0],competition=g.mem(fixture,1)[0]),regions=regions)


class Complete(Exception):pass


def run(out):
    if out.exists():raise ValueError('run records are immutable')
    for name in DEPENDENCIES:
        if (ROOT/name).read_bytes()!=git('show','HEAD:'+name):raise ValueError('commit recorder first: '+name)
    expected=reference();src=source()
    state,data=tail.full.match.find_state(src['state_sha256'])
    if sha(data)!=src['state_sha256']:raise ValueError('private start state differs')
    record=dict(schema='original-postmatch-incoming/1',producer=git('rev-parse','HEAD').decode().strip(),
        producer_files={name:sha((ROOT/name).read_bytes())for name in DEPENDENCIES},
        source=src,runtime=dict(python=platform.python_version(),unicorn=unicorn.__version__),
        status='aborted',error=None,unsupported=[],payload=None)
    week=None
    try:
        if unicorn.__version__!='2.1.4':raise ValueError('unsupported original runtime')
        week=tail.full.match.Week(data);g=week.g
        code_before=authenticate_code(g)
        def capture(current):
            before=current.mem(0,0x110000);at=current.far(0xD7D2)+0xF2
            timer=(current.timer_ticks,current.game_timer_ticks)
            # [confirmed:T45 frozen observer] Retain its declared watch input.
            current.put(at,b'\x01')
            after=current.mem(0,0x110000)
            changed=[i for i,(a,b)in enumerate(zip(before,after))if a!=b]
            c=context(current)
            fields=[dict(req,address=address(req,c),value=int.from_bytes(
                current.mem(address(req,c),req['size']),'little'))for req in requests()]
            draws=[tail.normalized(d)for d in week.events if d['kind']=='draw']
            want=[tail.normalized(d)for d in expected[1][:week.draws]]
            if draws!=want:raise ValueError('original pre-match RNG prefix differs')
            if timer!=(current.timer_ticks,current.game_timer_ticks):raise ValueError('capture advanced original clocks')
            record['payload']=dict(boundary=dict(site=current.where(),phase='pre19CA',
                draw_cursor=week.draws,seed=current.word_at(current.far(0xDE84)),prefix_sha256=sha(encoded(draws))),
                context=c,fields=fields,code_before=code_before,code_after=authenticate_code(current),
                game_files={name:sha(data)for name,data in sorted(week.files_at_start.items())},
                watch_intervention=dict(site=current.where(),address=at,before=before[at],after=after[at],
                    changed_addresses=changed,outside_unchanged=all(i==at for i in changed),
                    before_sha256=sha(before),after_sha256=sha(after)))
            raise Complete()
        g.code_hook('0AB9:E24C',capture)
        try:week.play(max_run_on=500000)
        except Complete:pass
        if record['payload'] is None:raise ValueError('original did not reach pre19CA boundary')
        record['unsupported']=list(g.unsupported)
        if record['unsupported']:raise ValueError('unsupported original service')
        record['status']='completed'
    except Exception as error:
        record['error']=type(error).__name__+': '+str(error)
        if week is not None:record['unsupported']=list(week.g.unsupported)
    record['payload_sha256']=sha(encoded(record['payload']))
    out.parent.mkdir(parents=True,exist_ok=True)
    with out.open('x')as stream:json.dump(record,stream,indent=2,sort_keys=True);stream.write('\n')
    print(out,record['status'],record['error'],flush=True)
    if record['status']!='completed':raise ValueError('aborted original capture: '+str(record['error']))
    validate(record)


def validate(record):
    """Structural/provenance consistency. Public numeric authenticity uses sealed leaves."""
    if record['schema']!='original-postmatch-incoming/1' or record['status']!='completed' or record['error'] is not None or record['unsupported']:
        raise ValueError('incomplete original pre-match capture')
    if record['source']!=source():raise ValueError('original pre-match source differs')
    paths=git('ls-tree','-r','--name-only',record['producer']).decode().splitlines()
    required={n for n in paths if Path(n).suffix=='.py'and str(Path(n).parent)in('runtime/emul','runtime/driver','tools/static')}
    if set(record['producer_files'])!=required:raise ValueError('producer dependency census differs')
    for name,digest in record['producer_files'].items():
        if sha(git('show',record['producer']+':'+name))!=digest:raise ValueError('producer digest differs')
    if record['runtime']['unicorn']!='2.1.4' or not record['runtime']['python']:raise ValueError('runtime differs')
    p=record['payload']
    if sha(encoded(p))!=record['payload_sha256']:raise ValueError('payload digest differs')
    if set(p)!={'boundary','context','fields','code_before','code_after','game_files','watch_intervention'}:raise ValueError('capture payload fields differ')
    boundary=p['boundary'];c=p['context'];regs=c['registers'];f=c['fixture'];m=c['match_frame']
    if boundary['site']!='0AB9:E24C' or boundary['phase']!='pre19CA':raise ValueError('capture phase differs')
    if m['bp']!=regs['bp'] or m['saved_parent']!=c['parent_bp'] or m['return_ip']!=0xEBE2 or c['parent_bp']<=m['bp']:
        raise ValueError('real parent/static return frame differs')
    old=late_record()['payload']['caller']['frame']
    identity={k:old[k]for k in ('week_slot','schedule_index','detailed','club','opponent','competition')}
    if f!=identity or (m['week_slot'],m['club'])!=(f['week_slot'],f['club']):raise ValueError('source fixture identity differs')
    if c['parent_frame']!={str(o):next(x['value']for x in p['fields']if x['coordinate']==dict(region='frame',index=0,offset=o))for o in(-7,-6,-2,6)}:
        raise ValueError('parent frame observation differs')
    if c['parent_frame']['6']!=f['week_slot'] or c['parent_frame']['-2']!=f['schedule_index'] or c['parent_frame']['-7']!=f['detailed']:
        raise ValueError('parent fixture fields differ')
    if len(c['regions'])!=len(tail.POOL_SPECS):raise ValueError('pool census differs')
    names=set();ranges=[]
    for r in c['regions']:
        if r['name'] in names or r['name'] not in tail.POOL_SPECS:raise ValueError('pool identity differs')
        names.add(r['name']);slot,count,stride,origin=tail.POOL_SPECS[r['name']]
        if (r['pointer'],r['count'],r['stride'],r['origin'])!=(slot,count,stride,origin) or r['base']!=16*r['segment']+r['offset']:
            raise ValueError('pool geometry/pointer differs')
        lo=r['base'];hi=lo+count*stride
        if not 0<=r['offset']<=65536-count*stride or not 0<=lo<hi<=0x110000 or any(lo<b and a<hi for a,b in ranges):raise ValueError('pool range/alias differs')
        ranges.append((lo,hi))
    req=requests()
    if len(p['fields'])!=len(req):raise ValueError('field census differs')
    memory={}
    for item,want in zip(p['fields'],req):
        if set(item)!={'field','size','coordinate','address','value'} or {k:item[k]for k in want}!=want or item['address']!=address(want,c):
            raise ValueError('field coordinate differs')
        value=item['value'];size=item['size'];a=item['address']
        if type(value)is not int or not 0<=value<1<<(8*size):raise ValueError('numeric value domain differs')
        for i,b in enumerate(value.to_bytes(size,'little')):
            if a+i in memory:raise ValueError('overlapping early observations')
            memory[a+i]=b
    def word(at):return memory[at]|memory[at+1]<<8
    ds=regs['ds']*16
    for r in c['regions']:
        if (word(ds+r['pointer']),word(ds+r['pointer']+2))!=(r['offset'],r['segment']):raise ValueError('observed pointer binding differs')
    if (word(ds+0xDE84),word(ds+0xDE86))!=(0xA51C,regs['ds']):raise ValueError('seed pointer binding differs')
    if word(ds+0xA51C)!=boundary['seed']:raise ValueError('seed observation differs')
    draws=reference()[1];n=boundary['draw_cursor']
    if type(n)is not int or not 0<=n<len(draws) or boundary['prefix_sha256']!=sha(encoded([tail.normalized(d)for d in draws[:n]])):
        raise ValueError('accepted original prefix differs')
    # [confirmed:0AB9:19E9/19ED] The next routine stores a setup-owned
    # seed before its first RNG call. A pre19CA observation is not that seed.
    # Authenticate the actual early value through its typed observation and
    # sealed record; prefix comparison authenticates draws already executed.

    for name,digest in late_record()['code'].items():
        if p['code_before'].get(name)!=digest:raise ValueError('original loaded code differs')
    if set(p['code_before'])!={'0AB9','1998','1B55','232A','24BC'} or p['code_after']!=p['code_before']:raise ValueError('code changed during original prefix')
    if p['game_files'].get('1-0.EXE')!=record['source']['packed_sha256'] or any(not re.fullmatch('[0-9a-f]{64}',x)for x in p['game_files'].values()):raise ValueError('game file identity differs')
    intervention=p['watch_intervention'];game=next(r for r in c['regions']if r['name']=='game')
    if intervention['site']!='0AB9:E24C' or intervention['address']!=game['base']+0xF2 or intervention['after']!=1 or intervention['outside_unchanged']is not True:
        raise ValueError('retained watch intervention differs')
    if intervention['changed_addresses']!=([intervention['address']]if intervention['before']!=1 else []):raise ValueError('undeclared capture mutation')
    return dict(fields=len(req),bytes=len(memory),phase='pre19CA')


def check_leaf(path):
    data=path.read_bytes()
    if path.name not in ACCEPTED or sha(data)!=ACCEPTED[path.name]:raise ValueError('accepted early record digest differs')
    record=json.loads(data);validate(record);return record


def check():
    if len(ACCEPTED)!=2:raise ValueError('two sealed original captures required')
    records=[check_leaf(ROOT/'records/T87'/name)for name in ACCEPTED]
    if records[0]['payload']!=records[1]['payload']:raise ValueError('independent early original captures differ')
    return dict(repeats=2,**validate(records[0]))


def main():
    parser=argparse.ArgumentParser(description=__doc__)
    group=parser.add_mutually_exclusive_group(required=True)
    group.add_argument('--run',type=Path);group.add_argument('--check',action='store_true')
    args=parser.parse_args()
    if args.run:run(args.run)
    else:print(json.dumps(check(),sort_keys=True))


if __name__=='__main__':main()
