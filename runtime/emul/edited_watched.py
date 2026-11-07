#!/usr/bin/env python3
"""T70: continuing original keyboard-edited watched stream; bounded prefixes are not matches."""
import argparse
import json
import re
import subprocess
import sys
import tempfile
from pathlib import Path

import edited_admission as admission
import watched_complete as prior

ROOT = admission.ROOT
SOURCE = 'runs/T69/admission-r0002.json'
REPEAT_SOURCE = 'runs/T69/admission-r0003.json'
REPEAT_SHA = 'a4bdfe03398b7c9de21ca8c6800b7c15cda7873218d413806b643fa31ce7b4af'
SOURCE_SHA = '45ca77eda64349d90700eb3983f6c725b5308e0dcf87c8a788bb081fde3ab627'
TOOL = 'runtime/emul/edited_watched.py'
sha = admission.sha
encoded = admission.encoded
write = prior.write


def source():
    data = (ROOT / SOURCE).read_bytes()
    if sha(data) != SOURCE_SHA:
        raise ValueError('accepted campaign preparation source differs')
    record = json.loads(data)
    admission.validate_record(record)
    repeated_raw = (ROOT / REPEAT_SOURCE).read_bytes()
    if sha(repeated_raw) != REPEAT_SHA:
        raise ValueError('edited preparation repeat source differs')
    repeated = json.loads(repeated_raw)
    admission.validate_record(repeated)
    if any(record[k] != repeated[k] for k in ('source','payload','keys_delivered')):
        raise ValueError('edited preparation independent repeat differs')
    return record


def identity(start, base):
    if set(start) != {'schema', 'producer', 'producer_files', 'source', 'state_sha256', 'release', 'watch_setting', 'interventions', 'ui'} or start['schema'] != 'original-edited-watched-start/1':
        raise ValueError('campaign start metadata fields differ')
    if start['source'] != {'record': SOURCE, 'sha256': SOURCE_SHA}:
        raise ValueError('watched campaign source differs')
    if start['state_sha256'] != admission.STATE_SHA or start['release'] != base['source']['release']:
        raise ValueError('watched campaign start/release differs')
    if start['ui'] != base['payload']['ui']:
        raise ValueError('original keyboard edit differs')
    if start['interventions'] or start['watch_setting'] != 1:
        raise ValueError('unexpected campaign watch intervention')
    if not start['producer_files'] or TOOL not in start['producer_files']:
        raise ValueError('missing campaign observer identity')
    source_paths = admission.git('ls-tree', '-r', '--name-only', start['producer'], '--', 'runtime/emul').decode().splitlines()
    required = {name for name in source_paths if Path(name).parent == Path('runtime/emul') and name.endswith('.py')}
    required.update(['runtime/driver/savestate.py', 'runtime/driver/screens.py',
                     'tools/data/campaign_seed.py', 'tools/data/save.py', 'tools/data/league.py'])
    if set(start['producer_files']) != required:
        raise ValueError('campaign observer dependency census differs')
    for name, digest in start['producer_files'].items():
        if sha(admission.git('show', start['producer'] + ':' + name)) != digest:
            raise ValueError('campaign observer source differs')


def check_prefix(directory):
    """Verify completed immutable leaves while the original writer is still running."""
    base = source()
    identity(json.loads((directory / 'start.json').read_text()), base)
    producers = set()
    attempts = {}
    for path in sorted(directory.glob('attempt-*-start.json')):
        attempt = json.loads(path.read_text())
        identity(attempt, base)
        producers.add(attempt['producer'])
        attempts[path.name.removesuffix('-start.json')] = attempt['producer']
    cursor, first = None, None
    setup_draws = []
    paths = sorted(directory.glob('chunk-*.json'))
    for number, path in enumerate(paths):
        if path.name != f'chunk-{number:06d}.json':
            raise ValueError('campaign prefix chunk order differs')
        row = json.loads(path.read_text())
        payload = row['payload']
        if row['producer'] not in producers or sha(encoded(payload)) != row['payload_sha256']:
            raise ValueError('campaign prefix producer/payload differs')
        cursor = prior.validate_chunk(payload, cursor)
        if first is None and payload['ticks']:
            first = payload['ticks'][0]['before']
        if len(setup_draws) < 258:
            setup_draws.extend(payload['draws'][:258 - len(setup_draws)])
    if paths and (first != base['payload']['first_entry'] or setup_draws != base['payload']['draws']):
        raise ValueError('campaign prefix preparation/entry differs')
    for path in sorted(directory.glob('attempt-*-verified-*.json')):
        verified = json.loads(path.read_text())
        match = re.fullmatch(r'(attempt-\d{4})-verified-(\d{6})\.json', path.name)
        if (match is None or verified['producer'] != attempts.get(match[1])
                or verified['chunk'] != f'chunk-{match[2]}.json'):
            raise ValueError('independent verified prefix attempt/chunk identity differs')
        if verified['chunk'] not in {p.name for p in paths}:
            raise ValueError('verified prefix names an unknown campaign chunk')
        observed = json.loads((directory / verified['chunk']).read_text())
        if (verified['producer'] not in producers
                or verified['payload_sha256'] != observed['payload_sha256']
                or verified['tick'] != observed['payload']['tick_end']
                or verified['draws'] != observed['payload']['draw_end']):
            raise ValueError('independent verified prefix differs')
    result = dict(chunks=len(paths), ticks=cursor['tick'] - 1 if cursor else 0,
                  draws=cursor['draw'] if cursor else 0, actions=cursor['action'] if cursor else 0)
    print('PASS authenticated campaign prefix', result)
    return result


def check(directory, require_repeat=False):
    prefix_result = check_prefix(directory)
    base = source()
    start = json.loads((directory / 'start.json').read_text())
    identity(start, base)
    producers = set()
    for attempt_path in sorted(directory.glob('attempt-*-start.json')):
        attempt = json.loads(attempt_path.read_text())
        identity(attempt, base)
        producers.add(attempt['producer'])
    index = json.loads((directory / 'index.json').read_text())
    if len(index['chunks']) != prefix_result['chunks']:
        raise ValueError('campaign indexed chunk census differs')
    if index['start_sha256'] != sha((directory / 'start.json').read_bytes()):
        raise ValueError('campaign stream start digest differs')
    cursor = None
    actions = []
    draws = []
    payload_digests = []
    first = None
    for number, item in enumerate(index['chunks']):
        if item['path'] != f'chunk-{number:06d}.json':
            raise ValueError('campaign chunk path/order differs')
        data = (directory / item['path']).read_bytes()
        if sha(data) != item['sha256']:
            raise ValueError('campaign chunk digest differs')
        row = json.loads(data)
        if row['producer'] not in producers:
            raise ValueError('campaign chunk observer identity differs')
        if sha(encoded(row['payload'])) != row['payload_sha256']:
            raise ValueError('campaign chunk payload digest differs')
        payload_digests.append(row['payload_sha256'])
        cursor = prior.validate_chunk(row['payload'], cursor)
        draws.extend(row['payload']['draws'])
        actions.extend(row['payload']['actions'])
        if first is None and row['payload']['ticks']:
            first = row['payload']['ticks'][0]['before']
    if first != base['payload']['first_entry'] or draws[:258] != base['payload']['draws']:
        raise ValueError('campaign T66 preparation/entry join differs')
    if not re.fullmatch(r'attempt-\d{4}-finish\.json', index['finish']['path']):
        raise ValueError('campaign finish path differs')
    finish_data = (directory / index['finish']['path']).read_bytes()
    if sha(finish_data) != index['finish']['sha256']:
        raise ValueError('campaign finish digest differs')
    finish = json.loads(finish_data)
    if finish['schema'] != 'original-edited-watched-finish/1' or finish['error'] is not None or finish['unsupported']:
        raise ValueError('campaign completion metadata differs')
    if finish['producer'] not in producers:
        raise ValueError('campaign finish observer identity differs')
    finish_start_path = directory / index['finish']['path'].replace('-finish.json', '-start.json')
    if not finish_start_path.exists() or json.loads(finish_start_path.read_text())['producer'] != finish['producer']:
        raise ValueError('campaign finish attempt identity differs')
    if finish['status'] != 'completed' or finish['boundary'] != prior.match.MATCH_RETURN:
        raise ValueError('campaign did not reach original match return')
    if cursor is None or (finish['ticks'], finish['draws'], finish['actions']) != (cursor['tick'] - 1, cursor['draw'], cursor['action']):
        raise ValueError('campaign final stream cursors differ')
    prior.validate_finish(finish['final'], actions)
    expected_result = dict(chunk_payloads=payload_digests, final=finish['final'],
                           ticks=finish['ticks'], draws=finish['draws'], actions=finish['actions'])
    if finish['result'] != expected_result:
        raise ValueError('campaign completion result aliases differ')
    repeats = sorted(directory.glob('repeat-*.json'))
    if require_repeat and not repeats:
        raise ValueError('completed independent campaign repeat is still required')
    for repeat_path in repeats:
        repeat = json.loads(repeat_path.read_text())
        if repeat['producer'] not in producers:
            raise ValueError('repeat observer identity differs')
        number = repeat_path.stem.removeprefix('repeat-')
        attempt_start = directory / f'attempt-{number}-start.json'
        attempt_finish = directory / f'attempt-{number}-finish.json'
        if not attempt_start.exists() or not attempt_finish.exists():
            raise ValueError('repeat completed attempt is missing')
        if json.loads(attempt_start.read_text())['producer'] != repeat['producer']:
            raise ValueError('repeat attempt observer differs')
        repeated = json.loads(attempt_finish.read_text())
        if repeated['producer'] != repeat['producer'] or any(repeated[field] != finish[field] for field in (
                'schema', 'status', 'error', 'boundary', 'ticks', 'draws', 'actions',
                'final', 'result', 'keys_delivered', 'unsupported')):
            raise ValueError('repeat actual return differs')
        expected_receipts = {f'attempt-{number}-verified-{i:06d}.json' for i in range(len(index['chunks']))}
        if {p.name for p in directory.glob(f'attempt-{number}-verified-*.json')} != expected_receipts:
            raise ValueError('repeat verified chunk census differs')
        if repeat['payload_sha256'] != sha(encoded(finish['result'])) or repeat['result'] != finish['result']:
            raise ValueError('independent campaign repeat differs')
        if repeat['chunk_payloads'] != [json.loads((directory / item['path']).read_text())['payload_sha256'] for item in index['chunks']]:
            raise ValueError('independent campaign chunk repeat differs')
    print(f'PASS original campaign complete:{finish["ticks"]} ticks,{finish["draws"]} draws,{finish["actions"]} actions;score{finish["final"]["scores"]}')
    return finish, index


def validate_bounded_finish(finish, payload, producer):
    required = {'schema','producer','status','boundary','ticks','draws','actions','final','chunk_payloads','keys_delivered','unsupported'}
    if set(finish) != required or finish['schema'] != 'original-edited-watched-bounded/1':
        raise ValueError('bounded finish schema differs')
    if finish['status'] != 'prefix-completed' or finish['boundary'] != '0AB9:7B79':
        raise ValueError('bounded prefix is not a completed match')
    if finish['producer'] != producer or finish['unsupported']:
        raise ValueError('bounded producer/services differ')
    if (finish['ticks'],finish['draws'],finish['actions']) != (64,payload['draw_end'],payload['action_end']):
        raise ValueError('bounded cursors differ')
    if finish['final'] != payload['ticks'][-1]['after'] or finish['chunk_payloads'] != [sha(encoded(payload))]:
        raise ValueError('bounded final state/chunk differs')
    if finish['keys_delivered'] != [[k,'24BC:0C58'] for k in admission.UI_KEYS+['Return','Return']]:
        raise ValueError('bounded original key witness differs')


def check_bounded(directory, require_repeat=False):
    check_prefix(directory)
    chunk = json.loads((directory / 'chunk-000000.json').read_text())
    payload = chunk['payload']
    if payload['tick_start'] != 1 or payload['tick_end'] != 64 or len(payload['ticks']) != 64:
        raise ValueError('bounded prefix must contain64 complete ticks')
    finishes = sorted(directory.glob('attempt-*-bounded.json'))
    if not finishes or (require_repeat and len(finishes) < 2):
        raise ValueError('independent bounded stop still required')
    original = None
    for i,path in enumerate(finishes):
        number = path.name.removeprefix('attempt-').removesuffix('-bounded.json')
        if not re.fullmatch(r'\d{4}',number):
            raise ValueError('bounded attempt path differs')
        start = json.loads((directory / f'attempt-{number}-start.json').read_text())
        finish = json.loads(path.read_text())
        validate_bounded_finish(finish,payload,start['producer'])
        observed = {k:v for k,v in finish.items() if k != 'producer'}
        if original is None:
            original = observed
        elif observed != original:
            raise ValueError('independent bounded observed state differs')
        if i and require_repeat:
            receipt = directory / f'attempt-{number}-verified-000000.json'
            if not receipt.exists() or len(list(directory.glob(f'attempt-{number}-verified-*.json'))) != 1:
                raise ValueError('bounded repeat chunk receipt missing')
    result = dict(ticks=64,draws=payload['draw_end'],actions=payload['action_end'],attempts=len(finishes))
    print('PASS original edited bounded prefix (not full time)',result)
    return result


def run(state_path, directory, repeat=False, max_ticks=10000, max_draws=1000000, prefix_ticks=64):
    if prefix_ticks not in (0,64):
        raise ValueError('only the bounded64 or actual full continuation is supported')
    base = source()
    if (directory / 'index.json').exists() and not repeat:
        check(directory)
        return
    old_finish = check(directory)[0] if repeat and not prefix_ticks else None
    if repeat and prefix_ticks:
        check_bounded(directory)
    producers = [str(p.relative_to(ROOT)) for p in sorted((ROOT / 'runtime/emul').glob('*.py'))]
    producers += ['runtime/driver/savestate.py', 'runtime/driver/screens.py', 'tools/data/campaign_seed.py', 'tools/data/save.py', 'tools/data/league.py']
    if admission.git('status', '--porcelain', '--', *producers).strip():
        raise ValueError('commit campaign observer/dependencies before capture')
    data = state_path.read_bytes()
    if sha(data) != admission.STATE_SHA:
        raise ValueError('campaign private start identity differs')
    week = prior.match.Week(data)
    g = week.g
    if {name: sha(value) for name, value in week.files_at_start.items()} != base['source']['release']:
        raise ValueError('campaign original release differs')
    admission.require_campaign(admission.seed.project(admission.memory_save(g), admission.seed.names(week.files_at_start['ENGL-95.DAT'])), admission.initial_campaign())
    ui = []
    admission.edit_week(week, ui)
    watch = g.mem(g.far(0xD7D2) + 0xF2, 1)[0]
    metadata = dict(schema='original-edited-watched-start/1', producer=admission.git('rev-parse', 'HEAD').decode().strip(), producer_files={p: sha((ROOT / p).read_bytes()) for p in producers}, source={'record': SOURCE, 'sha256': SOURCE_SHA}, state_sha256=sha(data), release=base['source']['release'], watch_setting=watch, interventions=[], ui=ui)
    identity(metadata, base)
    directory.mkdir(parents=True, exist_ok=True)
    if not (directory / 'start.json').exists():
        write(directory / 'start.json', metadata)
    else:
        identity(json.loads((directory / 'start.json').read_text()), base)
    attempt = len(list(directory.glob('attempt-*-start.json'))) + 1
    write(directory / f'attempt-{attempt:04d}-start.json', metadata)
    cursor = None
    chunk_index = export_draw = export_action = ticks = action_number = 0
    export_tick = 1
    tick_rows, action_rows, all_actions, digests = [], [], [], []
    pending_tick = pending_action = None
    joined = False
    final = None

    def flush():
        nonlocal cursor, chunk_index, export_draw, export_action, export_tick, tick_rows, action_rows
        draws = [e for e in week.events if e['kind'] == 'draw']
        payload = dict(index=chunk_index, draw_start=export_draw, draw_end=week.draws, tick_start=export_tick, tick_end=ticks, action_start=export_action, action_end=action_number, draws=draws[export_draw:], ticks=tick_rows, actions=action_rows)
        cursor = prior.validate_chunk(payload, cursor)
        digest = sha(encoded(payload))
        path = directory / f'chunk-{chunk_index:06d}.json'
        if path.exists():
            previous = json.loads(path.read_text())
            if previous['payload_sha256'] != digest or previous['payload'] != payload:
                raise ValueError('campaign verified-prefix replay differs')
            if repeat:
                write(directory / f'attempt-{attempt:04d}-verified-{chunk_index:06d}.json',
                      dict(producer=metadata['producer'], chunk=path.name,
                           payload_sha256=digest, tick=ticks, draws=week.draws))
        elif repeat:
            raise ValueError('repeat extends original campaign stream')
        else:
            with path.open('xb') as out:
                out.write(encoded(dict(schema='original-edited-watched-chunk/1', producer=metadata['producer'], payload_sha256=digest, payload=payload)) + b'\n')
        digests.append(digest)
        print(f'original campaign chunk{chunk_index}:tick{ticks},draw{week.draws},actions{action_number}', flush=True)
        chunk_index += 1
        export_draw, export_action, export_tick = week.draws, action_number, ticks + 1
        tick_rows, action_rows = [], []

    class Complete(Exception):
        pass

    class PrefixStop(Exception):
        pass

    def entry(g):
        nonlocal joined
        # 7C67 is the watched loop header, revisited after each physical tick.
        if joined:
            return
        if prior.state(g) != base['payload']['first_entry'] or [e for e in week.events if e['kind'] == 'draw'] != base['payload']['draws']:
            raise ValueError('original campaign preparation/entry differs')
        joined = True

    def tick_enter(g):
        nonlocal ticks, pending_tick
        if not joined or pending_tick is not None:
            raise ValueError('unjoined/nested campaign tick')
        ticks += 1
        if ticks > max_ticks or week.draws > max_draws:
            raise ValueError('campaign watched hard bound reached')
        pending_tick = dict(tick=ticks, draw_start=week.draws, before=prior.state(g))

    def tick_leave(g):
        nonlocal pending_tick
        if pending_tick is None:
            return
        pending_tick.update(draw_end=week.draws, after=prior.state(g))
        tick_rows.append(pending_tick)
        pending_tick = None
        if len(tick_rows) == prior.CHUNK_TICKS:
            flush()
        if prefix_ticks and ticks == prefix_ticks:
            raise PrefixStop()

    def action_enter(g):
        nonlocal pending_action
        if not ticks:
            return
        if pending_action is not None:
            raise ValueError('nested campaign commentary')
        args = prior.prefix.arguments(g)
        club = g.rd(0xD6E4 + 2 * args['side'])
        def player(slot):
            return 0 if slot == 0 else g.word_at(g.far(0xD7C2) + 62 * (club - 1) + 2 * (slot - 1))
        pending_action = dict(**args, club=club, player=player(args['actor_slot']), secondary=player(args['secondary_slot']), minute=g.rd(0xD0B2), tick=ticks, draw_start=week.draws, seed_before=g.rd(0xA51C), head_before=g.rd(0x380), caller=g.image_address(g.reg('cs'), g.stack_word(0)))

    def action_leave(g):
        nonlocal pending_action, action_number
        if pending_action is None:
            return
        row, pending_action = pending_action, None
        if g.rd(0x380) == row['head_before']:
            return
        row.update(event=action_number, draw_end=week.draws, seed_after=g.rd(0xA51C), queue=prior.prefix.row(g))
        action_rows.append(row)
        all_actions.append(row)
        action_number += 1

    def end(g):
        nonlocal final
        if ticks:
            if pending_tick is not None or pending_action is not None:
                raise ValueError('campaign match returned with pending observer frame')
            final = prior.state(g)
            raise Complete()

    for site, callback in [('0AB9:7C67', entry), ('0AB9:7A02', tick_enter), ('0AB9:7B79', tick_leave), ('0AB9:0F94', action_enter), ('0AB9:0FFC', action_leave), (prior.match.MATCH_RETURN, end)]:
        g.code_hook(site, callback)
    status, error = 'completed', None
    try:
        try:
            week.play(max_run_on=500000)
        except PrefixStop:
            if not prefix_ticks or not joined or ticks != prefix_ticks or g.unsupported:
                raise ValueError('invalid bounded original stop')
            final = prior.state(g)
            if tick_rows:
                flush()
            bounded = dict(schema='original-edited-watched-bounded/1', producer=metadata['producer'],
                           status='prefix-completed', boundary='0AB9:7B79', ticks=ticks,
                           draws=week.draws, actions=action_number, final=final,
                           chunk_payloads=digests, keys_delivered=g.keys_delivered, unsupported=g.unsupported)
            write(directory / f'attempt-{attempt:04d}-bounded.json', bounded)
            check_bounded(directory, require_repeat=repeat)
            return
        except Complete:
            if prefix_ticks:
                raise ValueError('match returned before the requested bounded prefix')
        else:
            raise ValueError('campaign watched match did not return')
        if not joined or final is None or g.unsupported:
            raise ValueError('unsupported/incomplete original campaign')
        prior.validate_finish(final, all_actions)
        flush()
        if repeat and (digests != old_finish['result']['chunk_payloads'] or final != old_finish['final']):
            raise ValueError('independent original campaign termination differs')
    except (Exception, KeyboardInterrupt) as exc:
        status, error = 'aborted', f'{type(exc).__name__}: {exc}'
    result = dict(chunk_payloads=digests, final=final, ticks=ticks, draws=week.draws, actions=action_number)
    finish = dict(schema='original-edited-watched-finish/1', producer=metadata['producer'], status=status, error=error, boundary=prior.match.MATCH_RETURN if status == 'completed' else None, ticks=ticks, draws=week.draws, actions=action_number, final=final, result=result, keys_delivered=g.keys_delivered, unsupported=g.unsupported)
    finish_path = directory / f'attempt-{attempt:04d}-finish.json'
    write(finish_path, finish)
    if status != 'completed':
        raise ValueError(error)
    if repeat:
        write(directory / f'repeat-{attempt:04d}.json', dict(producer=metadata['producer'], result=result, chunk_payloads=digests, payload_sha256=sha(encoded(result))))
    else:
        chunks = sorted(directory.glob('chunk-*.json'))
        write(directory / 'index.json', dict(start_sha256=sha((directory / 'start.json').read_bytes()), finish={'path': finish_path.name, 'sha256': sha(finish_path.read_bytes())}, chunks=[dict(path=p.name, sha256=sha(p.read_bytes())) for p in chunks]))
    check(directory)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    group = parser.add_mutually_exclusive_group(required=True)
    group.add_argument('--run', type=Path)
    group.add_argument('--check', action='store_true')
    group.add_argument('--check-prefix', action='store_true')
    group.add_argument('--check-bounded', action='store_true')
    parser.add_argument('--directory', type=Path, required=True)
    parser.add_argument('--repeat', action='store_true')
    parser.add_argument('--continue-full', action='store_true')
    args = parser.parse_args()
    if args.run:
        run(args.run, args.directory, args.repeat, prefix_ticks=0 if args.continue_full else 64)
    elif args.check_prefix:
        check_prefix(args.directory)
    elif args.check_bounded:
        check_bounded(args.directory, require_repeat=True)
    else:
        check(args.directory, require_repeat=True)


if __name__ == '__main__':
    main()
