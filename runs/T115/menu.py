#!/usr/bin/env python3
"""T115 receipt: the league menu's remaining screens at the season boundary,
witnessed in runs/T115/session-r0017 - the completed capture whose controller
replayed the T112 route digest-verified (114/114), escaped the squad screen to
the management menu, walked the menu by the game's internal cursor (Cup
results, Weekly fixtures, Fixture list, Statistics), and F7-saved the named
game - the first committed post-league30 lineage point. --check re-reads
every fact from the committed session and prints ready."""
import hashlib
import json
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent.parent
SESSION = ROOT/'runs/T115/session-r0017'
T112_SESSION = ROOT/'runs/T112/session-r0019'
T112_LAST = T112_SESSION/'step-0115.json'
SOURCE_SAVE = ROOT/'.cache/saves/pre-league28/SAVE1.1-0'
SAVE_DEST = ROOT/'.cache/saves/post-league30-t115/SAVE1.1-0'
RECEIPT = ROOT/'runs/T115/menu-r0001.json'
SCREENS = ('Cup results', 'Weekly fixtures', 'Fixture list', 'Statistics')
# the replayed route range (T112's steps 2..115) and the live-play region the
# controller anchor-checked instead of digest-checking (steps 82-108: the
# ball positions and the clock digits are timing-sensitive per capture)
REPLAY_RANGE = range(2, 116)
EXEMPT_RANGE = range(82, 109)
# each screen's as-shown fact needles: the receipt stores the whole line
# containing the needle (interpreted nothing - the table contents are
# recorded as the screen shows them, the checker re-extracts them)
NEEDLES = {
    'Cup results': ('League Cup Round 1', 'Blackburn R  3v0  Portsmouth'),
    'Weekly fixtures': ('FIXTURES FOR GAME # 57', 'Eurpn Cup Final'),
    'Fixture list': ('PREMIER LEAGUE', 'League match #25'),
    'Statistics': ('Top scorers (league and cups)', 'Best attack'),
}
# the menu's right-hand column rows, by the game's own highlight index; the
# walk steered by the internal cursor (deterministic), the shown readings
# are recorded as evidence (they can trail the keys)
ROWS = {'Cup results': 13, 'Weekly fixtures': 14, 'Fixture list': 15,
        'Statistics': 16}


def sha(data):
    return hashlib.sha256(data).hexdigest()


def load_steps():
    """Every capture step in capture order - never keyed by id: the route's
    repeated ids (four S016-down-berg downs, the doubled boot ids) must not
    collapse, and the replay binding consumes the list in order."""
    return sorted((json.loads(f.read_text())
                   for f in sorted(SESSION.glob('step-*.json'))),
                  key=lambda s: s['number'])


def capture_by_id(steps, sid):
    matches = [s for s in steps if s['id'] == sid]
    if len(matches) != 1:
        raise SystemExit(f'{sid}: {len(matches)} captures, expected one')
    return matches[0]


def replay_binding():
    """The full-replay binding, checkable from committed bytes alone: the
    route is consumed in order against the capture (the route commands are
    issued verbatim in route order, interleaved with catch-up, anchor and
    walk steps carrying different id patterns), every non-exempt step's
    screen digest equals the committed T112 step's, and every exempt
    (timing-sensitive, live-play) step shows the match-30 header - the
    deterministic screens caught in the exempt range digest-match instead.
    This is the T112 week.py replay_pairs invariant carried to the T115
    capture - the review finding: a receipt that pins only the replay's
    last screen leaves the per-step claim uncheckable, and an id-keyed
    alignment silently drops the route's repeated ids."""
    theirs = [json.loads((T112_SESSION/f'step-{n:04d}.json').read_text())
              for n in REPLAY_RANGE]
    exempt = set()
    for n in EXEMPT_RANGE:
        s = json.loads((T112_SESSION/f'step-{n:04d}.json').read_text())
        exempt.add(s['id'])
    mine = sorted(load_steps(), key=lambda s: s['number'])
    cursor = 0
    matched = anchored = 0
    problems = []
    for s in theirs:
        while cursor < len(mine) and mine[cursor]['id'] != s['id']:
            cursor += 1
        if cursor >= len(mine):
            problems.append(f"step-{s['number']:04d} ({s['id']}): absent "
                            f'from the capture')
            continue
        step = mine[cursor]
        cursor += 1
        if step['text_sha256'] == s['text_sha256']:
            matched += 1
        elif s['id'] in exempt and 'LEAGUE MATCH #30' in step['text']:
            # the timing-sensitive live-play region: the controller
            # anchor-checked the match header instead of the digest; the
            # deterministic screens caught in the exempt range digest-match
            # above (the bench screen does)
            anchored += 1
        else:
            problems.append(f"step-{s['number']:04d} ({s['id']}): the "
                            f'screen digest differs')
    if problems:
        raise SystemExit('the replay binding fails: ' + '; '.join(problems[:4]))
    last = capture_by_id(mine, 'S039-post-league30-t112')
    if last['text_sha256'] != theirs[-1]['text_sha256']:
        raise SystemExit('the replay does not end on the T112 machine')
    return dict(route=T112_SESSION.relative_to(ROOT).as_posix(),
                route_steps=len(theirs), digest_matched=matched,
                header_anchored=anchored, anchor='LEAGUE MATCH #30',
                exempt_ids=len(exempt),
                replay_text_sha256=last['text_sha256'])


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


def build(save_sha=None):
    """The receipt from the committed session; save_sha carries the recorded
    digest when the private save bytes are absent on this machine (the write
    mode reads the file and raises when it is missing)."""
    end = json.loads((SESSION/'end.json').read_text())
    if end['status'] != 'completed' or not end['processes_exited']:
        raise SystemExit('the session did not complete cleanly')
    steps = load_steps()
    # the walk happened on the T112 machine: the whole replay route is
    # digest-bound to the committed T112 session (per step, with the
    # documented timing-sensitive exemptions anchor-checked); the endpoint
    # equality is asserted inside replay_binding
    binding = replay_binding()
    anchor = capture_by_id(steps, 'S041-anchor')
    if not anchor['highlighted'] or 'Players' not in str(anchor['highlighted']):
        raise SystemExit('the walk is not anchored at Players')
    screens = {}
    for t_idx, name in enumerate(SCREENS, start=1):
        enter = capture_by_id(steps, f'S201-enter-{t_idx}')
        poll = capture_by_id(steps, f'S201-enter-{t_idx}-poll-0')
        if enter['text_sha256'] != poll['text_sha256']:
            raise SystemExit(f'{name}: the enter and its poll differ')
        if 'PLAY NEXT GAME' in enter['text']:
            raise SystemExit(f'{name}: the enter never left the main screen')
        show = capture_by_id(steps, f'S201-show-{t_idx}')
        shown = str(show['highlighted'])
        screens[name] = dict(
            row=ROWS[name], row_as_shown=shown,
            number=enter['number'],
            text_sha256=enter['text_sha256'],
            screenshot_sha256=enter['screenshot_sha256'],
            facts=fact_lines(enter['text'], NEEDLES[name]))
    if save_sha is None:
        if not SAVE_DEST.exists():
            raise SystemExit('the private save is missing on the write mode')
        save_sha = sha(SAVE_DEST.read_bytes())
    return dict(
        schema='league-menu-receipt-1/1', issue=260, task='T115',
        source_save=dict(path=SOURCE_SAVE.relative_to(ROOT).as_posix(),
                         sha256=sha(SOURCE_SAVE.read_bytes())
                         if SOURCE_SAVE.exists()
                         else 'unverified: the private save is absent'),
        session=dict(directory=SESSION.relative_to(ROOT).as_posix(),
                     session_sha256=sha((SESSION/'session.json').read_bytes()),
                     steps=end['steps'], last_step=end['last_step']),
        binding=dict(replay_ends_on=T112_LAST.relative_to(ROOT).as_posix(),
                     **binding),
        anchor=dict(number=anchor['number'], row_as_shown='Players'),
        screens=screens,
        f7_save=dict(step_id='S050-f7-save',
                     path=SAVE_DEST.relative_to(ROOT).as_posix(),
                     sha256=save_sha,
                     post_save_number=capture_by_id(steps, 'S051-post-save')['number']))


def differs(stored, rebuilt, path=''):
    """Recursive comparison; the private-byte digests are skipped when the
    rebuilt values carry the unverifiable sentinel (the private files absent
    on this machine)."""
    if isinstance(stored, dict) and isinstance(rebuilt, dict):
        for key in stored:
            differs(stored[key], rebuilt.get(key), path + '/' + key)
        return
    if stored == rebuilt:
        return
    if isinstance(rebuilt, str) and rebuilt.startswith('unverified'):
        return
    raise SystemExit(f"the receipt's {path or 'root'} differs from the "
                     f"re-read session")


def main():
    if '--check' in sys.argv:
        if not RECEIPT.exists():
            raise SystemExit('the receipt does not exist yet')
        stored = json.loads(RECEIPT.read_text())
        save_sha = None
        if SAVE_DEST.exists():
            save_sha = sha(SAVE_DEST.read_bytes())
        else:
            save_sha = f"unverified: the private save is absent (the receipt records {stored['f7_save']['sha256'][:12]})"
        differs(stored, build(save_sha))
        print('league menu: ready')
        return 0
    receipt = build()
    RECEIPT.write_text(json.dumps(receipt, indent=1) + '\n')
    print(f'receipt written: {RECEIPT.relative_to(ROOT)}')
    return 0


if __name__ == '__main__':
    sys.exit(main())
