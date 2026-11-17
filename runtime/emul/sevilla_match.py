#!/usr/bin/env python3
"""T89 authenticated Sevilla friendly capture — entry gate, stream, caller.

The native T90 refusal (onenil c0546abb) names the gap: the following fixture
after the completed friendly week has no accepted original match evidence, so
playing it is unwitnessed. This capture produces that evidence from the
T81/T82-authenticated post-week save. Entry gate first: any state that is not
the pinned owner-local save refuses before emulation. Week-0 values are never
transplanted; the checker refines only from observed reads.
"""
import argparse
import hashlib
import json
import subprocess
import sys
import time
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / 'runtime/emul'))
sys.path.insert(0, str(ROOT / 'runtime/driver'))
sys.path.insert(0, str(ROOT / 'tools/data'))

from saved_roster import MANAGED_CLUB, block_offsets  # noqa: E402
import week_completion  # noqa: E402

# [confirmed:T82 c13195a] records/T82/next-fixture-r0001.json: the post-week
# save of the T81 session r0007 timeline, decoded around the managed club.
ENTRY_SHA = 'f3aa2e4f076891fca47ca686664502a0f69ed79bdd67de0910bf0ed932225e29'
# [confirmed:T81 dc54fe9] the management menu advertises this fixture as
# Sevilla/Aragones, Friendly #2 after the completed week.
WITNESSED_FOLLOWING = dict(week=1, competition=1, opponent=176, flags=0)
PLAYED_FRIENDLY = dict(week=0, competition=1, opponent=17, flags=65)

decode_fixture_triples = week_completion.decode_fixture_triples
decode_week_byte = week_completion.decode_week_byte
sha = lambda data: hashlib.sha256(data).hexdigest()
encoded = lambda value: json.dumps(value, sort_keys=True, separators=(',', ':')).encode()


def git(*args):
    return subprocess.check_output(['git', '-C', str(ROOT), *args])


def entry_structure(data):
    """[confirmed static: campaign-seed.md; dynamic: T82 c13195a] Decode and
    authenticate the post-week fixture sequence: the played friendly carries
    its played marker on both reciprocal rows, the following fixture is the
    witnessed Sevilla triple, the week byte advanced exactly once."""
    triples = decode_fixture_triples(data, MANAGED_CLUB, weeks=4)
    played = triples[0]
    if (played['competition'], played['opponent']) != (1, 17):
        raise ValueError('the played friendly triple differs from the witnessed admission')
    if played['flags'] & 64 != 64:
        raise ValueError('the played fixture lost its played marker')
    reciprocal_played = decode_fixture_triples(data, 17, weeks=2)[0]
    if (reciprocal_played['competition'], reciprocal_played['opponent']) != (1, MANAGED_CLUB) \
            or reciprocal_played['flags'] & 64 != 64:
        raise ValueError('the played friendly reciprocal row differs')
    following = triples[1]
    if following != WITNESSED_FOLLOWING:
        raise ValueError('the following fixture differs from the witnessed triple')
    reciprocal_following = decode_fixture_triples(data, 176, weeks=2)[1]
    if (reciprocal_following['competition'], reciprocal_following['opponent']) != (1, MANAGED_CLUB):
        raise ValueError('the following fixture reciprocal row differs')
    week = decode_week_byte(data)
    if week != 1:
        raise ValueError('the week counter is not the completed first week')
    return dict(week_byte=week,
                played=played,
                following=following,
                reciprocal_played=(reciprocal_played['competition'], reciprocal_played['opponent']),
                reciprocal_following=(reciprocal_following['competition'],
                                      reciprocal_following['opponent']))


def authenticate_entry(path):
    """Refuse any state that is not the pinned post-week save before any
    emulation begins. The digest gate opens only for the owner-local save."""
    path = Path(path)
    try:
        data = path.read_bytes()
    except OSError:
        raise ValueError('the entry save is missing or unreadable; the digest gate refuses')
    if hashlib.sha256(data).hexdigest() != ENTRY_SHA:
        raise ValueError('the entry save digest differs from the pinned post-week state')
    return data


def entry_record(path):
    """Bind the authenticated entry identity for the capture record."""
    data = authenticate_entry(path)
    decoded = entry_structure(data)
    return dict(
        schema='sevilla-entry/1',
        source=dict(path=str(path), sha256=hashlib.sha256(data).hexdigest(), size=len(data)),
        decoded=dict(club=MANAGED_CLUB, **decoded),
        evidence=dict(task='T89 #210', t82='records/T82/next-fixture-r0001.json',
                      native_boundary='onenil T90 c0546abb refuses this fixture unwitnessed'),
    )


# [confirmed:T89 records/T89/entry-r0001.json] the machine savestate captured at
# the Sevilla fixture preparation entry (driver session, nothing keyed past PLAY GAME).
PREPARATION_STATE_SHA = '98275eb59475dc155e12c915996c2c2cbd0fc1298ffedf14490ff2aa118805c9'


def week_one_anchors():
    """The committed week-1 context, cross-checked between the T81 session decode
    and the T82 next-fixture record. Only evidenced values become refusals; the
    projected fixture's venue fields are published by boot(), not pre-pinned."""
    session = json.loads((ROOT / 'runs/T81/session-r0007.json').read_text())
    saved = session['payload']['decoded_saves']['saved']
    t82 = json.loads((ROOT / 'records/T82/next-fixture-r0001.json').read_text())
    decoded = t82['decoded']
    if saved['seed_word'] != 10649 or saved['cash'] != decoded['cash_post']:
        raise ValueError('committed week-1 anchors disagree')
    return dict(seed_word=saved['seed_word'], cash=saved['cash'],
                roster=saved['clubs'][str(MANAGED_CLUB)]['roster'],
                week_byte=decoded['week_byte_post'],
                following=decoded['fixtures_post'][1],
                slot_after=decoded['fixtures_post'][2],
                menu_markers=t82['cross_check']['menu_markers'])


# [confirmed:T89 records/T89/entry-r0001.json + boot observation r0001] The
# original pre-advances its live context when entering fixture preparation:
# the menu boundary still holds the saved state (seed 10649, Sevilla next),
# while the projected campaign at the preparation savestate reads week_index 2
# with the save's own slot-2 fixture (Celtic) as the live next fixture, and
# the seed word consumed to 50238 by the preparation's own draw work.
PREPARATION_LIVE = dict(week_index=2, seed_word=50238)


def authenticate_preparation_state(path):
    """Digest gate for the private preparation savestate; refuses before boot."""
    try:
        data = Path(path).read_bytes()
    except OSError:
        raise ValueError('the preparation savestate is missing or unreadable; the digest gate refuses')
    if hashlib.sha256(data).hexdigest() != PREPARATION_STATE_SHA:
        raise ValueError('the preparation savestate digest differs from the pinned entry capture')
    return data


def check_preparation_context(projected, anchors):
    """Assert the evidenced campaign context at the preparation boundary against
    a projected campaign: the untouched Pearce XI, the moved funds, the
    original's pre-advanced live context (week 2, the save's own slot-2 fixture
    — T82's decode, corroborated live), manager and season."""
    if projected['week_index'] != PREPARATION_LIVE['week_index']:
        raise ValueError('projected week differs from the pre-advanced preparation context')
    if projected['cash'] != anchors['cash']:
        raise ValueError('projected cash differs from the committed week-1 movement')
    if projected['club']['id'] != MANAGED_CLUB:
        raise ValueError('projected club differs')
    first = projected['club']['first_team']
    if first[:len(anchors['roster'])] != anchors['roster']:
        raise ValueError('projected first team differs from the committed roster')
    fixture = projected['next_fixture']
    if (fixture['competition_code'], fixture['opponent']) != (anchors['slot_after']['competition'],
                                                              anchors['slot_after']['opponent']):
        raise ValueError('projected live fixture differs from the save slot the T82 decode rows')
    if projected['manager']['name'] != 'Dalglish' or projected['season']['start_year'] != 1994:
        raise ValueError('projected manager/season differs from the committed campaign')
    return fixture


def boot(state_path):
    """Boot the watched machine from the pinned preparation savestate and
    authenticate the live week-1 campaign context against committed evidence."""
    import campaign_admission as admission
    import postmatch_tail as tail
    data = authenticate_preparation_state(state_path)
    week = tail.full.match.Week(data)
    g = week.g
    release_digests = release_96()
    if {name: sha(value) for name, value in week.files_at_start.items()} != release_digests:
        raise ValueError('wrong original release at preparation boot')
    projected = admission.seed.project(admission.memory_save(g),
                                       admission.seed.names(week.files_at_start['ENGL-95.DAT']))
    anchors = week_one_anchors()
    fixture = check_preparation_context(projected, anchors)
    seed_word = g.word_at(g.far(0xDE84))
    if seed_word != PREPARATION_LIVE['seed_word']:
        raise ValueError('machine seed word differs from the pinned preparation consumption')
    return week, projected, dict(anchors=anchors, live_fixture=fixture,
                                 seed_word=seed_word, prepared_fixture=anchors['following'])


def release_96():
    """The verified 96-edition release identity (T01 inventory)."""
    inventory = json.loads((ROOT / 'records/T01/inventory.json').read_text())
    return {p['name']: p['sha256'] for p in inventory['files'] if p['edition'] == '96'}


def watcher_census():
    """The observer dependency census for the watched capture (campaign_watched's
    shape): every runtime/emul module plus the driver/tool files it loads."""
    names = [str(p.relative_to(ROOT)) for p in sorted((ROOT / 'runtime/emul').glob('*.py'))]
    names += ['runtime/driver/savestate.py', 'runtime/driver/screens.py',
              'tools/data/campaign_seed.py', 'tools/data/save.py', 'tools/data/league.py']
    return sorted(set(names))


def capture(directory, state_path, max_ticks=0):
    """The watched Sevilla match, recorded. Boots from the pinned preparation
    savestate (boot() authenticates context first), delivers PLAY GAME, joins
    the match at the watched loop header and records ticks/draws/actions into
    digest-chained chunks until the match returns. No expected stream exists:
    the entry state is recorded, and only structural chaining is enforced.
    max_ticks bounds a smoke run; the real capture leaves it at 0."""
    import campaign_admission as admission
    import watched_complete as prior
    import postmatch_tail as tail
    directory = Path(directory)
    if (directory / 'finish.json').exists():
        raise ValueError('capture directory already complete')
    meta = dict(producer=git('rev-parse', 'HEAD').decode().strip(),
                producer_files={p: sha((ROOT / p).read_bytes()) for p in watcher_census()})
    for name, digest in meta['producer_files'].items():
        if sha(git('show', meta['producer'] + ':' + name)) != digest:
            raise ValueError('commit the observer before the capture: ' + name)
    week, projected, context = boot(state_path)
    g = week.g
    watch = g.mem(g.far(0xD7D2) + 0xF2, 1)[0]
    if watch != 1:
        raise ValueError('the saved campaign does not carry the enabled watch setting')
    boot_record = json.loads((ROOT / 'records/T89/boot-r0001.json').read_text())
    if boot_record['projection_sha256'] != hashlib.sha256(
            json.dumps(projected, sort_keys=True).encode()).hexdigest():
        raise ValueError('the live projection differs from the published boot record')
    start = dict(schema='sevilla-watched-start/1', **meta,
                 preparation_state=dict(path=str(state_path), sha256=PREPARATION_STATE_SHA),
                 boot=dict(record='records/T89/boot-r0001.json',
                           record_sha256=sha((ROOT / 'records/T89/boot-r0001.json').read_bytes()),
                           projection_sha256=boot_record['projection_sha256']),
                 release=release_96(), watch_setting=watch, live_context=PREPARATION_LIVE,
                 interventions=[])
    directory.mkdir(parents=True, exist_ok=True)
    prior.write(directory / 'start.json', start)

    ticks = 0
    cursor = None
    chunk_index = export_draw = export_action = 0
    export_tick = 1
    tick_rows, action_rows, all_actions = [], [], []
    joined = False
    pending_tick = pending_action = None
    first_entry = entry_draws = final = None

    def flush():
        nonlocal cursor, chunk_index, export_draw, export_action, export_tick, tick_rows, action_rows
        draws = [e for e in week.events if e['kind'] == 'draw']
        payload = dict(index=chunk_index, draw_start=export_draw, draw_end=week.draws,
                       tick_start=export_tick, tick_end=ticks,
                       action_start=export_action, action_end=len(all_actions),
                       draws=draws[export_draw:], ticks=tick_rows, actions=action_rows)
        cursor = prior.validate_chunk(payload, cursor)
        digest = sha(encoded(payload))
        path = directory / f'chunk-{chunk_index:06d}.json'
        if path.exists():
            previous = json.loads(path.read_text())
            if previous['payload_sha256'] != digest or previous['payload'] != payload:
                raise ValueError('sevilla verified-prefix replay differs')
        else:
            with path.open('xb') as out:
                out.write(encoded(dict(schema='sevilla-watched-chunk/1', producer=meta['producer'],
                                       payload_sha256=digest, payload=payload)) + b'\n')
        print(f'sevilla chunk{chunk_index}: tick{ticks}, draw{week.draws}, '
              f'actions{len(all_actions)}', flush=True)
        chunk_index += 1
        export_draw, export_action, export_tick = week.draws, len(all_actions), ticks + 1
        tick_rows, action_rows = [], []

    class Complete(Exception):
        pass

    def entry(current):
        nonlocal joined, first_entry, entry_draws
        if joined:
            return
        # The first watched entry into the Sevilla match is recorded, never
        # assumed: its state and the draws consumed before it become the pin.
        first_entry = prior.state(current)
        entry_draws = week.draws
        joined = True
        print(f'sevilla joined: entry draws {entry_draws}', flush=True)

    def tick_enter(current):
        nonlocal ticks, pending_tick
        if not joined or pending_tick is not None:
            raise ValueError('unjoined/nested sevilla tick')
        ticks += 1
        if max_ticks and ticks > max_ticks:
            raise Complete()
        pending_tick = dict(tick=ticks, draw_start=week.draws, before=prior.state(current))

    def tick_leave(current):
        nonlocal pending_tick, tick_rows
        if pending_tick is None:
            return
        pending_tick.update(draw_end=week.draws, after=prior.state(current))
        tick_rows.append(pending_tick)
        pending_tick = None
        if len(tick_rows) == prior.CHUNK_TICKS:
            flush()

    def action_enter(current):
        nonlocal pending_action
        if not ticks:
            return
        if pending_action is not None:
            raise ValueError('nested sevilla commentary')
        args = prior.prefix.arguments(current)
        club = current.rd(0xD6E4 + 2 * args['side'])

        def player(slot):
            return 0 if slot == 0 else current.word_at(current.far(0xD7C2) + 62 * (club - 1) + 2 * (slot - 1))

        pending_action = dict(**args, club=club, player=player(args['actor_slot']),
                              secondary=player(args['secondary_slot']), minute=current.rd(0xD0B2),
                              tick=ticks, draw_start=week.draws, seed_before=current.rd(0xA51C),
                              head_before=current.rd(0x380),
                              caller=current.image_address(current.reg('cs'), current.stack_word(0)))

    def action_leave(current):
        nonlocal pending_action, action_rows, all_actions
        if pending_action is None:
            return
        row, pending_action = pending_action, None
        if current.rd(0x380) == row['head_before']:
            return
        row.update(event=len(all_actions), draw_end=week.draws, seed_after=current.rd(0xA51C),
                   queue=prior.prefix.row(current))
        action_rows.append(row)
        all_actions.append(row)

    def end(current):
        nonlocal final
        if not ticks:
            return
        if pending_tick is not None or pending_action is not None:
            raise ValueError('sevilla match returned with a pending observer frame')
        final = prior.state(current)
        raise Complete()

    for site, callback in [('0AB9:7C67', entry), ('0AB9:7A02', tick_enter),
                           ('0AB9:7B79', tick_leave), ('0AB9:0F94', action_enter),
                           ('0AB9:0FFC', action_leave), (prior.match.MATCH_RETURN, end)]:
        g.code_hook(site, callback)

    status, error = 'completed', None
    began = time.monotonic()
    try:
        try:
            week.play(max_run_on=500000)
        except Complete:
            pass
        else:
            raise ValueError('the sevilla match did not return')
        if not joined or final is None or g.unsupported:
            raise ValueError('unsupported/incomplete sevilla capture')
        flush()
    except (Exception, KeyboardInterrupt) as exc:
        status, error = 'aborted', f'{type(exc).__name__}: {exc}'
    chunks = sorted(directory.glob('chunk-*.json'))
    result = dict(chunk_payloads=[sha(p.read_bytes()) for p in chunks], final=final,
                  ticks=ticks, draws=week.draws, actions=len(all_actions),
                  first_entry=first_entry, entry_draws=entry_draws,
                  seconds=round(time.monotonic() - began, 1), smoke=bool(max_ticks))
    prior.write(directory / 'finish.json',
                dict(schema='sevilla-watched-finish/1', status=status, error=error,
                     producer=meta['producer'], result=result,
                     keys_delivered=g.keys_delivered, unsupported=g.unsupported))
    if status != 'completed':
        raise ValueError(error)
    prior.write(directory / 'index.json',
                dict(start_sha256=sha((directory / 'start.json').read_bytes()),
                     chunks=[dict(path=p.name, sha256=sha(p.read_bytes())) for p in chunks],
                     finish_sha256=sha((directory / 'finish.json').read_bytes())))
    return result


def check_capture(directory):
    """Public re-validation of a capture directory: producer census against its
    own commit, digest-chained chunk replay, and result identities. No private
    savestate is needed."""
    import watched_complete as prior
    directory = Path(directory)
    start = json.loads((directory / 'start.json').read_text())
    if start['schema'] != 'sevilla-watched-start/1' or start['interventions'] \
            or start['watch_setting'] != 1 \
            or start['preparation_state']['sha256'] != PREPARATION_STATE_SHA \
            or start['live_context'] != PREPARATION_LIVE:
        raise ValueError('foreign sevilla capture start')
    names = git('ls-tree', '-r', '--name-only', start['producer']).decode().splitlines()
    wanted = {n for n in names if Path(n).parent == Path('runtime/emul') and n.endswith('.py')} | \
             {'runtime/driver/savestate.py', 'runtime/driver/screens.py',
              'tools/data/campaign_seed.py', 'tools/data/save.py', 'tools/data/league.py'}
    if set(start['producer_files']) != wanted:
        raise ValueError('capture producer census differs')
    for name, digest in start['producer_files'].items():
        if sha(git('show', start['producer'] + ':' + name)) != digest:
            raise ValueError('capture producer source differs: ' + name)
    if start['release'] != release_96():
        raise ValueError('capture release identity differs')
    boot_record = json.loads((ROOT / start['boot']['record']).read_bytes())
    if sha((ROOT / start['boot']['record']).read_bytes()) != start['boot']['record_sha256'] \
            or start['boot']['projection_sha256'] != boot_record['projection_sha256']:
        raise ValueError('capture boot anchor differs from the committed boot record')
    index = json.loads((directory / 'index.json').read_text())
    finish = json.loads((directory / 'finish.json').read_text())
    if index['start_sha256'] != sha((directory / 'start.json').read_bytes()) \
            or index['finish_sha256'] != sha((directory / 'finish.json').read_bytes()):
        raise ValueError('capture identity digests differ')
    if finish['status'] != 'completed' or finish['error'] or finish['unsupported']:
        raise ValueError('capture is not a completed clean run')
    cursor = None
    draws_end = 0
    for row in index['chunks']:
        path = directory / row['path']
        if sha(path.read_bytes()) != row['sha256']:
            raise ValueError('capture chunk digest differs: ' + row['path'])
        chunk = json.loads(path.read_text())
        if chunk['schema'] != 'sevilla-watched-chunk/1' or chunk['producer'] != start['producer']:
            raise ValueError('foreign capture chunk')
        if chunk['payload_sha256'] != sha(encoded(chunk['payload'])):
            raise ValueError('capture chunk payload digest differs')
        cursor = prior.validate_chunk(chunk['payload'], cursor)
        draws_end = chunk['payload']['draw_end']
    result = finish['result']
    if result['chunk_payloads'] != [row['sha256'] for row in index['chunks']]:
        raise ValueError('capture result does not match the chunk index')
    if result['draws'] != draws_end or result['ticks'] != cursor['tick'] - 1 \
            or result['actions'] != cursor['action'] or not result['final'] \
            or result['entry_draws'] is None:
        raise ValueError('capture result identities differ')
    print('sevilla capture verified:', directory,
          f"ticks {result['ticks']}, draws {result['draws']}, actions {result['actions']}")


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--entry', type=Path, help='owner-local post-week save to authenticate')
    ap.add_argument('--record', type=Path, help='write the authenticated entry record here')
    ap.add_argument('--state', type=Path, help='owner-local preparation savestate for --boot')
    ap.add_argument('--boot-out', type=Path, help='write the boot context record here')
    ap.add_argument('--capture-dir', type=Path, help='directory for the watched match chunks')
    ap.add_argument('--max-ticks', type=int, default=0, help='smoke bound; 0 = full match')
    ap.add_argument('--check-capture', type=Path, help='publicly re-validate a capture directory')
    args = ap.parse_args()
    if args.check_capture:
        check_capture(args.check_capture)
    elif args.capture_dir:
        if not args.state:
            ap.error('--capture-dir needs --state')
        result = capture(args.capture_dir, args.state, max_ticks=args.max_ticks)
        print('capture', 'completed' if not args.max_ticks else 'smoke',
              'ticks', result['ticks'], 'draws', result['draws'], 'actions', result['actions'],
              'entry draws', result['entry_draws'])
    elif args.state:
        week, projected, context = boot(args.state)
        record = dict(schema='sevilla-boot/1',
                      preparation_state=dict(path=str(args.state), sha256=PREPARATION_STATE_SHA),
                      projected=projected, context=context,
                      projection_sha256=hashlib.sha256(
                          json.dumps(projected, sort_keys=True).encode()).hexdigest())
        if args.boot_out:
            args.boot_out.write_text(json.dumps(record, indent=1) + '\n')
            print('boot authenticated: week', projected['week_index'], 'cash', projected['cash'],
                  'live fixture', context['live_fixture']['opponent_name'],
                  'prepared', context['prepared_fixture']['opponent'],
                  'seed', context['seed_word'])
        else:
            print(json.dumps(record, indent=1))
    elif args.entry:
        record = entry_record(args.entry)
        if args.record:
            args.record.write_text(json.dumps(record, indent=1) + '\n')
            print('entry authenticated:', record['source']['sha256'][:16], 'week', record['decoded']['week_byte'],
                  'following', record['decoded']['following'])
        else:
            print(json.dumps(record, indent=1))
    else:
        ap.error('--state or --entry is required')


if __name__ == '__main__':
    main()
