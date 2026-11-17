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


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--entry', type=Path, help='owner-local post-week save to authenticate')
    ap.add_argument('--record', type=Path, help='write the authenticated entry record here')
    args = ap.parse_args()
    if not args.entry:
        ap.error('--entry is required')
    record = entry_record(args.entry)
    if args.record:
        args.record.write_text(json.dumps(record, indent=1) + '\n')
        print('entry authenticated:', record['source']['sha256'][:16], 'week', record['decoded']['week_byte'],
              'following', record['decoded']['following'])
    else:
        print(json.dumps(record, indent=1))


if __name__ == '__main__':
    main()
