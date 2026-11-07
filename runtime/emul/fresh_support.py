#!/usr/bin/env python3
"""T68: bounded original incoming read witnesses, never a native engine model."""
import argparse
import json
import re
from pathlib import Path

import campaign_admission as prior

ROOT = prior.ROOT
TOOL = 'runtime/emul/fresh_support.py'
BASE = 'runs/T66/admission-r0001.json'
BASE_SHA = '9639833b657ed2cf0c5684e7338843534f0d552e8323b55dd12e947a5b6e6331'
SITES = ('0AB9:E24C', '0AB9:E008', '0AB9:7C67')
# [confirmed: native d42add34, prepared::support_cells] Disjoint incoming
# domains, excluding canonical players, scenes, ball, queue, seed and ABI.
DS_RANGES = ((0xD144, 0xD148), (0xD1D4, 0xD1DC), (0xD34, 0xD36),
             (0xD5C, 0xD5E), (0xD0A6, 0xD0AC), (0x9FB, 0xB5A),
             (0x97A, 0x9BE), (0xD36, 0xD56), (0xBF6, 0xC68),
             (0xCD7, 0xCE0), (0xD60, 0xD91), (0xD92, 0xE6A),
             (0xF20, 0xF30), (0x1274, 0x1288), (0x129E, 0x12CE),
             (0x8708, 0x8716), (0x935B, 0xA51C), (0xD886, 0xD936))
DS_CELLS = (0xD084, 0xD09E, 0xD0B6, 0xD0BD, 0xD1C9, 0xE5DD, 0xCF5A, 0xCF5B)
FAR = dict(config=0xD7D2, counts=0xDCC8, results=0xD7CE, fixtures=0xD7CA)


def source():
    data = (ROOT / BASE).read_bytes()
    if prior.sha(data) != BASE_SHA:
        raise ValueError('fresh support base source differs')
    value = json.loads(data)
    prior.validate_record(value)
    return value


def allowed(area, offset):
    if type(area) is not str or type(offset) is not int or offset < 0:
        return False
    if area == 'ds':
        return offset in DS_CELLS or any(lo <= offset < hi for lo, hi in DS_RANGES)
    if area == 'config':
        return offset < 256 and offset not in (0, 1, 2, 0xF2, 0xF6)
    return offset < dict(counts=4004, results=58 * 176, fixtures=174 * 176).get(area, 0)


def request_check(value):
    if set(value) != {'schema', 'fields'} or value['schema'] != 'fresh-caller-read-request/1':
        raise ValueError('fresh support request fields differ')
    if not isinstance(value['fields'], list) or not 1 <= len(value['fields']) <= 1024:
        raise ValueError('fresh support request bound differs')
    seen = set()
    for field in value['fields']:
        if not isinstance(field, dict) or set(field) != {'area', 'offset'} or not allowed(field['area'], field['offset']):
            raise ValueError('unsupported fresh support request')
        key = field['area'], field['offset']
        if key in seen:
            raise ValueError('duplicate fresh support request')
        seen.add(key)


def joins(base):
    payload = base['payload']
    return [prior.sha(prior.encoded(payload['points'][i]['state'])) for i in (0, 7)] + [prior.sha(prior.encoded(payload['first_entry']))]


def payload_check(payload, request, base):
    request_check(request)
    if set(payload) != {'points', 'draw_count', 'draws_sha256', 'fields'}:
        raise ValueError('fresh support payload fields differ')
    if [point['site'] for point in payload['points']] != list(SITES):
        raise ValueError('fresh support boundary census differs')
    if any(set(point) != {'site', 'join_sha256'} for point in payload['points']):
        raise ValueError('fresh support boundary fields differ')
    if [point['join_sha256'] for point in payload['points']] != joins(base):
        raise ValueError('fresh support source state joins differ')
    if payload['draw_count'] != 258 or payload['draws_sha256'] != prior.sha(prior.encoded(base['payload']['draws'])):
        raise ValueError('fresh support preparation RNG differs')
    if len(payload['fields']) != len(request['fields']):
        raise ValueError('fresh support witness census differs')
    for wanted, observed in zip(request['fields'], payload['fields']):
        if set(observed) != {'area', 'offset', 'before', 'precall', 'entry', 'incoming'}:
            raise ValueError('fresh support witness fields differ')
        if {k: observed[k] for k in ('area', 'offset')} != wanted:
            raise ValueError('fresh support request alias differs')
        values = [observed[k] for k in ('before', 'precall', 'entry')]
        if any(type(v) is not int or not 0 <= v <= 255 for v in values):
            raise ValueError('fresh support witness domain differs')
        if type(observed['incoming']) is not bool or observed['incoming'] != (len(set(values)) == 1):
            raise ValueError('fresh support input/computation ownership differs')


def check(value):
    base = source()
    if set(value) != {'schema', 'status', 'error', 'producer', 'producer_files', 'source', 'request', 'interventions', 'payload', 'payload_sha256', 'unsupported'}:
        raise ValueError('fresh support record fields differ')
    if value['schema'] != 'original-fresh-support/1' or value['status'] != 'completed' or value['unsupported'] or value['error'] is not None:
        raise ValueError('fresh support run incomplete')
    if not re.fullmatch(r'[0-9a-f]{40}', value['producer']):
        raise ValueError('fresh support producer identity differs')
    if value['source'] != dict(record=BASE, sha256=BASE_SHA, state_sha256=prior.STATE_SHA, release=base['source']['release']):
        raise ValueError('fresh support source identity differs')
    if value['interventions']:
        raise ValueError('unexpected fresh support intervention')
    if set(value['request']) != {'path', 'sha256'} or Path(value['request']['path']).parts[:2] != ('traces', 'T68') or '..' in Path(value['request']['path']).parts:
        raise ValueError('fresh support request identity differs')
    source_paths = prior.git('ls-tree', '-r', '--name-only', value['producer'], '--', 'runtime/emul').decode().splitlines()
    required = {name for name in source_paths if Path(name).parent == Path('runtime/emul') and name.endswith('.py')}
    required.update(['runtime/driver/savestate.py', 'runtime/driver/screens.py', 'tools/data/campaign_seed.py', 'tools/data/save.py', 'tools/data/league.py', value['request']['path']])
    if set(value['producer_files']) != required:
        raise ValueError('fresh support producer dependency census differs')
    for name, digest in value['producer_files'].items():
        if prior.sha(prior.git('show', value['producer'] + ':' + name)) != digest:
            raise ValueError('fresh support producer differs')
    if TOOL not in value['producer_files']:
        raise ValueError('missing fresh support observer')
    request = json.loads(prior.git('show', value['producer'] + ':' + value['request']['path']))
    if prior.sha(prior.encoded(request)) != value['request']['sha256']:
        raise ValueError('fresh support committed request differs')
    if prior.sha(prior.encoded(value['payload'])) != value['payload_sha256']:
        raise ValueError('fresh support payload digest differs')
    payload_check(value['payload'], request, base)
    return [dict(area=row['area'], offset=row['offset'], value=row['before']) for row in value['payload']['fields'] if row['incoming']]


def capture(state_path, request_path, output):
    if output.exists():
        raise ValueError('fresh support output already exists')
    request = json.loads(request_path.read_text())
    request_check(request)
    relative = request_path.resolve().relative_to(ROOT)
    producers = [str(p.relative_to(ROOT)) for p in sorted((ROOT / 'runtime/emul').glob('*.py'))]
    producers += ['runtime/driver/savestate.py', 'runtime/driver/screens.py', 'tools/data/campaign_seed.py', 'tools/data/save.py', 'tools/data/league.py', str(relative)]
    if prior.git('status', '--porcelain', '--', *producers).strip():
        raise ValueError('commit fresh support observer/request/dependencies first')
    data = state_path.read_bytes()
    if prior.sha(data) != prior.STATE_SHA:
        raise ValueError('fresh support private start differs')
    base = source()
    week = prior.match.Week(data)
    if {name: prior.sha(value) for name, value in week.files_at_start.items()} != base['source']['release']:
        raise ValueError('fresh support original release differs')
    if week.g.mem(week.g.far(0xD7D2) + 0xF2, 1)[0] != 1:
        raise ValueError('fresh support start is not watched')
    observed = []
    class Complete(Exception):
        pass
    def observe(g, site):
        state = prior.watched.state(g) if site == SITES[-1] else prior.setup.state(week)
        index = len(observed)
        if index >= len(SITES) or SITES[index] != site or prior.sha(prior.encoded(state)) != joins(base)[index]:
            raise ValueError('fresh support reached different original source state')
        values = []
        for field in request['fields']:
            address = g.DS * 16 + field['offset'] if field['area'] == 'ds' else g.far(FAR[field['area']]) + field['offset']
            values.append(g.mem(address, 1)[0])
        observed.append(dict(site=site, join_sha256=prior.sha(prior.encoded(state)), values=values))
        if site == SITES[-1]:
            raise Complete()
    for site in SITES:
        week.g.code_hook(site, lambda g, site=site: observe(g, site))
    status, error, payload = 'completed', None, None
    try:
        try:
            week.play()
        except Complete:
            pass
        else:
            raise ValueError('fresh support entry not reached')
        if week.g.unsupported:
            raise ValueError('unsupported original guest service')
        draws = [event for event in week.events if event['kind'] == 'draw']
        payload = dict(points=[{k: point[k] for k in ('site', 'join_sha256')} for point in observed], draw_count=len(draws), draws_sha256=prior.sha(prior.encoded(draws)), fields=[])
        for i, field in enumerate(request['fields']):
            values = [point['values'][i] for point in observed]
            payload['fields'].append(dict(**field, before=values[0], precall=values[1], entry=values[2], incoming=len(set(values)) == 1))
        payload_check(payload, request, base)
    except (Exception, KeyboardInterrupt) as exc:
        status, error = 'aborted', f'{type(exc).__name__}: {exc}'
    result = dict(schema='original-fresh-support/1', status=status, error=error, producer=prior.git('rev-parse', 'HEAD').decode().strip(), producer_files={name: prior.sha((ROOT / name).read_bytes()) for name in producers}, source=dict(record=BASE, sha256=BASE_SHA, state_sha256=prior.STATE_SHA, release=base['source']['release']), request=dict(path=str(relative), sha256=prior.sha(prior.encoded(request))), interventions=[], payload=payload, payload_sha256=prior.sha(prior.encoded(payload)), unsupported=week.g.unsupported)
    output.parent.mkdir(parents=True, exist_ok=True)
    with output.open('x') as out:
        json.dump(result, out, indent=2)
        out.write('\n')
    if status != 'completed':
        raise ValueError(error)
    incoming = check(result)
    print('PASS original fresh support:', len(incoming), 'unchanged incoming fields;', len(payload['fields']) - len(incoming), 'changed fields excluded')


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    group = parser.add_mutually_exclusive_group(required=True)
    group.add_argument('--run', type=Path)
    group.add_argument('--check', type=Path)
    parser.add_argument('--request', type=Path)
    parser.add_argument('--record', type=Path)
    parser.add_argument('--compare', type=Path)
    args = parser.parse_args()
    if args.run:
        if args.request is None or args.record is None:
            parser.error('--run needs --request and --record')
        capture(args.run, args.request, args.record)
    else:
        value = json.loads(args.check.read_text())
        incoming = check(value)
        if args.compare:
            other = json.loads(args.compare.read_text())
            check(other)
            if value['payload'] != other['payload'] or value['request'] != other['request']:
                raise ValueError('independent original fresh-support repeat differs')
        print('PASS source/request/producer/ownership;', len(incoming), 'unchanged incoming fields')


if __name__ == '__main__':
    main()
