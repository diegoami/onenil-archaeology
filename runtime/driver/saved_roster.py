#!/usr/bin/env python3
"""T80: bind the supplied save's club records to the accepted in-match projection.

    python3 runtime/driver/saved_roster.py --baseline runs/T80/save-projection-NEW.json

Decodes bounded fields of the owner's private One-Nil96/SAVE1.1-0 (never its bytes)
through the accepted T65 block layout (tools/data/save.py) and compares the managed
club's twenty roster words with the authentic T74 halftime projection. Public records
hold digests, counts and decoded values only; the generator refuses to overwrite and
refuses to run without the private file. The session mode (added by the same task)
walks the original route: replacement -> full time -> save -> fresh-process reload.
"""
import argparse
import hashlib
import json
import struct
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / 'runtime/driver'))
sys.path.insert(0, str(ROOT / 'tools/data'))
import save as save_layout  # the accepted decoder: BLOCKS, SIZE, decode

TOOL = 'runtime/driver/saved_roster.py'
DEPENDENCIES = [TOOL, 'tools/data/save.py']
MANAGED_CLUB = 130
OUTGOING = 2582  # I Pearce
INCOMING = 2592  # T Gale
REFERENCE = 'runs/T74/session-r0005.json'
SOURCE = 'One-Nil96/SAVE1.1-0'
sha = lambda b: hashlib.sha256(b).hexdigest()


def git(*args):
    return subprocess.check_output(['git', '-C', str(ROOT), *args]).decode().strip()


def block_offsets():
    off, out = 0, {}
    for dest, size in save_layout.BLOCKS:
        out[dest] = (off, size)
        off += size
    return out


def decode_save(data):
    """Bounded decoded values from save bytes: header numbers, roster-relevant block
    digests, the managed club's roster words and the case players' fields."""
    if len(data) != save_layout.SIZE:
        raise ValueError('save is %d bytes; the block sequence is %d' % (len(data), save_layout.SIZE))
    off = block_offsets()
    clubs_at, clubs_size = off['[DS:D7C2]']
    p8_at, _ = off['[DS:D7BA]']
    p15_at, _ = off['[DS:D7BE]']
    d = dict(
        header_byte=data[off['DS:DCD8'][0]],
        year=struct.unpack_from('<H', data, off['DS:DCDA'][0])[0],
        seed_word=struct.unpack_from('<H', data, off['[DS:DE84]'][0])[0],
        clubs_block_sha256=sha(data[clubs_at:clubs_at + clubs_size]),
        players8_block_sha256=sha(data[p8_at:p8_at + off['[DS:D7BA]'][1]]),
        players15_block_sha256=sha(data[p15_at:p15_at + off['[DS:D7BE]'][1]]),
        clubs={},
    )
    for club in (MANAGED_CLUB, 17):
        base = clubs_at + (club - 1) * 62
        roster = list(struct.unpack_from('<20H', data, base))
        entry = {'roster': roster}
        if club == MANAGED_CLUB:
            entry['players'] = {}
            for identifier in (OUTGOING, INCOMING):
                entry['players'][str(identifier)] = dict(
                    current_position=data[p8_at + 8 * identifier + 6],
                    club_position=data[p8_at + 8 * identifier + 7],
                    condition=data[p15_at + 15 * identifier + 8],
                    instructions=data[p15_at + 15 * identifier + 10],
                    status=data[p15_at + 15 * identifier + 11],
                )
        d['clubs'][str(club)] = entry
    return d


def reference_halftime():
    """The authentic T74 halftime projection (public record, private bytes not needed)."""
    ref = ROOT / REFERENCE
    record = json.loads(ref.read_text())
    stage = next(s for s in record['payload']['stages'] if s['name'] == 'halftime')
    return ref, record, stage['state']


def build_baseline(out):
    if out.exists():
        raise SystemExit('run records are immutable (CLAUDE.md rule 13): %s exists' % out)
    game = ROOT / '.cache' / SOURCE
    if not game.is_file():
        raise SystemExit('private original save missing: %s (tools/artifacts.py pull)' % game)
    data = game.read_bytes()
    ref, ref_record, half = reference_halftime()
    decoded = decode_save(data)
    managed = decoded['clubs'][str(MANAGED_CLUB)]
    roster = half['clubs'][next(i for i, c in enumerate(half['clubs']) if c['id'] == MANAGED_CLUB)]['roster']
    equal = managed['roster'] == roster
    slots = dict(outgoing=roster.index(OUTGOING), incoming=roster.index(INCOMING)) if equal else None
    if not equal:
        raise SystemExit('managed club roster differs between save and T74 halftime projection')
    if slots['incoming'] <= 11 <= slots['outgoing']:
        raise SystemExit('pre-exchange slots are not a first-team/bench pair')
    record = dict(
        schema='original-saved-roster-projection/1',
        producer=git('rev-parse', 'HEAD'),
        producer_files={p: sha((ROOT / p).read_bytes()) for p in DEPENDENCIES},
        source=dict(path=SOURCE, sha256=sha(data), size=len(data)),
        reference=dict(path=REFERENCE, sha256=sha(ref.read_bytes())),
        save=decoded,
        comparison=dict(
            club=MANAGED_CLUB,
            halftime_roster_sha256=sha(json.dumps(roster, separators=(',', ':')).encode()),
            equal=True, slots_zero_based=slots,
            note='opponent club 17 words are the saved arrangement; its match arrangement is execution state (ai-selection)',
        ),
        interpretation='bounded decoded values and digests only; no save bytes enter git',
    )
    out.parent.mkdir(parents=True, exist_ok=True)
    with out.open('x') as f:
        json.dump(record, f, indent=2)
        f.write('\n')
    print('wrote', out, 'managed club roster equal:', equal, 'slots', slots)


def validate_baseline(record):
    """Public authentication: schema, digests, and the equality against the T74 record."""
    if record['schema'] != 'original-saved-roster-projection/1':
        raise ValueError('schema differs')
    for name, digest in record['producer_files'].items():
        if sha(git('show', record['producer'] + ':' + name).encode()) != digest:
            raise ValueError('producer identity differs: ' + name)
    if record['reference']['path'] != REFERENCE:
        raise ValueError('reference differs')
    _, ref_record, half = reference_halftime()
    if sha((ROOT / REFERENCE).read_bytes()) != record['reference']['sha256']:
        raise ValueError('reference digest differs')
    roster = half['clubs'][next(i for i, c in enumerate(half['clubs']) if c['id'] == MANAGED_CLUB)]['roster']
    if sha(json.dumps(roster, separators=(',', ':')).encode()) != record['comparison']['halftime_roster_sha256']:
        raise ValueError('halftime roster digest differs')
    if not record['comparison']['equal'] or record['save']['clubs'][str(MANAGED_CLUB)]['roster'] != roster:
        raise ValueError('save/projection equality differs')
    slots = record['comparison']['slots_zero_based']
    if roster[slots['outgoing']] != OUTGOING or roster[slots['incoming']] != INCOMING:
        raise ValueError('case players differ')
    return dict(club=MANAGED_CLUB, slots=slots)


def main(argv):
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('--baseline', type=Path)
    p.add_argument('--check', type=Path)
    a = p.parse_args(argv)
    if a.check:
        print('PASS saved-roster baseline:', validate_baseline(json.loads(a.check.read_text())))
    elif a.baseline:
        build_baseline(a.baseline)
    else:
        p.error('choose --baseline OUTPUT or --check RECORD')


if __name__ == '__main__':
    main(sys.argv[1:])
