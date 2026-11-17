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
import sys
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


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--entry', type=Path, help='owner-local post-week save to authenticate')
    ap.add_argument('--record', type=Path, help='write the authenticated entry record here')
    ap.add_argument('--state', type=Path, help='owner-local preparation savestate for --boot')
    ap.add_argument('--boot-out', type=Path, help='write the boot context record here')
    args = ap.parse_args()
    if args.state:
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
