#!/usr/bin/env python3
"""T116 receipt: the season boundary. The T115 post-league30 lineage save boots
the management machine; one Enter on PLAY NEXT GAME opens the next scheduled
fixture, the European Cup Final between Lazio and P St Germain (a fixture that
does not involve Blackburn R), as that home club's preparation screen - the
left panel names the competition and the pairing, the centre and right columns
are Lazio's squad (Remaining subs 3). No question is asked, the screen is
stable across follower captures, and F7 rewrites a save byte-identical to the
source: opening the boundary screen changes no machine state.

--check re-reads every fact from the committed session, proves the session's
chain and text digests, and binds the source save to the T115 receipt's own F7
digest; it prints ready with or without the private save bytes."""
import hashlib
import json
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent.parent
SESSION = ROOT/'runs/T116/session-r0001'
T115_RECEIPT = ROOT/'runs/T115/menu-r0001.json'
SOURCE_SAVE = ROOT/'.cache/saves/post-league30-t115/SAVE1.1-0'
LINEAGE_SAVE = ROOT/'.cache/saves/post-league30-t116/SAVE1.1-0'
RECEIPT = ROOT/'runs/T116/boundary-r0001.json'


def sha(data):
    return hashlib.sha256(data).hexdigest()


def session_steps():
    paths = sorted(SESSION.glob('step-*.json'))
    steps = [json.loads(p.read_text()) for p in paths]
    previous = None
    for path, s in zip(paths, steps):
        if s['previous'] != previous:
            raise SystemExit(f'{path.name}: the action chain is broken')
        previous = sha(path.read_bytes())
        if s.get('text_sha256') != sha(s['text'].encode()):
            raise SystemExit(f'{path.name}: the text does not match its digest')
    end = json.loads((SESSION/'end.json').read_text())
    if end['steps'] != len(steps) or end['last_step'] != previous:
        raise SystemExit('the end record disagrees with the chain')
    return steps


def capture_by_id(steps, sid):
    matches = [s for s in steps if s['id'] == sid]
    if len(matches) != 1:
        raise SystemExit(f'{sid}: {len(matches)} captures, expected one')
    return matches[0]


def fact_lines(text, needles):
    lines = text.splitlines()
    facts = {}
    for needle in needles:
        for line in lines:
            if needle in line:
                facts[needle] = line.strip()
                break
        else:
            raise SystemExit(f'the needle {needle!r} is not on the screen')
    return facts


def build(source_sha=None, lineage_sha=None):
    end = json.loads((SESSION/'end.json').read_text())
    if end['status'] != 'completed' or not end['processes_exited']:
        raise SystemExit('the session did not complete cleanly')
    steps = session_steps()

    # the boot: the T115 machine, named by its own funds and season header
    boot = capture_by_id(steps, 'S002-y-1')
    boot_facts = fact_lines(boot['text'], ('PLAY NEXT GAME', '1,636,583',
                                           'SEASON  1994/95'))
    # every decision read is a follower: the boundary screen must be stable
    boundary = capture_by_id(steps, 'S011-follow')
    boundary_facts = fact_lines(boundary['text'], (
        'Eurpn Cup Final', 'Lazio----------', 'P St Germain---',
        'Remaining subs 3', 'PLAY GAME'))
    if 'PLAY NEXT GAME' in boundary['text'] or '1,636,583' in boundary['text']:
        raise SystemExit('the boundary capture is still the management screen')
    if any(mark in boundary['text'] for mark in ('Are you sure', '(Y/N)')):
        raise SystemExit('the boundary asks a question; this flow answered none')
    stable = []
    for sid in ('S012-boundary-settle-0', 'S012-boundary-settle-1'):
        s = capture_by_id(steps, sid)
        if s['text_sha256'] != boundary['text_sha256']:
            raise SystemExit(f'{sid}: the boundary screen did not settle')
        stable.append(dict(id=sid, number=s['number'],
                           text_sha256=s['text_sha256']))

    # the inputs: the load, one Enter on PLAY NEXT GAME, one F7 - nothing else
    keyed = [(s['id'], s['keys']) for s in steps if s['keys']]
    expected = [('S002-y-1', ['y']), ('S010-enter', ['Enter']),
                ('S020-f7', ['F7'])]
    if keyed != expected:
        raise SystemExit(f'the session sent other input than the route: {keyed}')

    # the lineage: the source save is the T115 receipt's own F7 digest
    t115 = json.loads(T115_RECEIPT.read_text())
    t115_sha = t115['f7_save']['sha256']
    if source_sha is None:
        if not SOURCE_SAVE.exists():
            raise SystemExit('the source save is absent on the write mode')
        source_sha = sha(SOURCE_SAVE.read_bytes())
    if not source_sha.startswith('unverified') and source_sha != t115_sha:
        raise SystemExit(f'the source save is not the T115 lineage point '
                         f'({source_sha[:12]} against {t115_sha[:12]})')

    # F7 at the boundary rewrote the same bytes: the screen changed, the
    # machine did not
    if lineage_sha is None:
        if not LINEAGE_SAVE.exists():
            raise SystemExit('the boundary save is absent on the write mode')
        lineage_sha = sha(LINEAGE_SAVE.read_bytes())
    if lineage_sha.startswith('unverified') or source_sha.startswith('unverified'):
        identical = 'unverified: the private save bytes are absent'
    else:
        identical = lineage_sha == source_sha

    return dict(
        schema='season-boundary-receipt-1/1', issue=271, task='T116',
        source_save=dict(path=SOURCE_SAVE.relative_to(ROOT).as_posix(),
                         sha256=source_sha,
                         t115_binding=dict(
                             receipt=T115_RECEIPT.relative_to(ROOT).as_posix(),
                             f7_sha256=t115_sha)),
        session=dict(directory=SESSION.relative_to(ROOT).as_posix(),
                     session_sha256=sha((SESSION/'session.json').read_bytes()),
                     steps=end['steps'], last_step=end['last_step']),
        boot=dict(number=boot['number'], text_sha256=boot['text_sha256'],
                  facts=boot_facts),
        boundary=dict(number=boundary['number'],
                      text_sha256=boundary['text_sha256'],
                      facts=boundary_facts,
                      question=False,
                      note='the next scheduled fixture after the completed '
                           'league season: the European Cup Final, Lazio '
                           'versus P St Germain, opened as the home club\'s '
                           'preparation screen; Blackburn R is not a '
                           'participant'),
        stability=stable,
        inputs=dict(load='y', boundary=['Enter'], save=['F7']),
        lineage_save=dict(path=LINEAGE_SAVE.relative_to(ROOT).as_posix(),
                          sha256=lineage_sha,
                          identical_to_source=identical,
                          note='F7 at the boundary rewrote the same bytes: the '
                               'transition opened a screen without changing '
                               'the machine state'))


def differs(stored, rebuilt, path=''):
    if isinstance(stored, dict) and isinstance(rebuilt, dict):
        for key in stored:
            differs(stored[key], rebuilt.get(key), path + '/' + key)
        return
    if stored == rebuilt:
        return
    if isinstance(rebuilt, str) and rebuilt.startswith('unverified'):
        return
    raise SystemExit(f"the receipt's {path or 'root'} differs from the "
                     f're-read session')


def main():
    if '--check' in sys.argv:
        if not RECEIPT.exists():
            raise SystemExit('the receipt does not exist yet')
        stored = json.loads(RECEIPT.read_text())
        source_sha = (sha(SOURCE_SAVE.read_bytes()) if SOURCE_SAVE.exists()
                      else 'unverified: the source save is absent ' +
                           f'(the receipt records {stored["source_save"]["sha256"][:12]})')
        lineage_sha = (sha(LINEAGE_SAVE.read_bytes()) if LINEAGE_SAVE.exists()
                       else 'unverified: the boundary save is absent ' +
                            f'(the receipt records {stored["lineage_save"]["sha256"][:12]})')
        differs(stored, build(source_sha, lineage_sha))
        print('the season boundary: ready')
        return 0
    RECEIPT.write_text(json.dumps(build(), indent=1) + '\n')
    print(f'receipt written: {RECEIPT.relative_to(ROOT)}')
    return 0


if __name__ == '__main__':
    sys.exit(main())
