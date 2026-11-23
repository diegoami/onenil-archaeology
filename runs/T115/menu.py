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
T112_LAST = ROOT/'runs/T112/session-r0019/step-0115.json'
SOURCE_SAVE = ROOT/'.cache/saves/pre-league28/SAVE1.1-0'
SAVE_DEST = ROOT/'.cache/saves/post-league30-t115/SAVE1.1-0'
RECEIPT = ROOT/'runs/T115/menu-r0001.json'
SCREENS = ('Cup results', 'Weekly fixtures', 'Fixture list', 'Statistics')
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
    steps = {}
    for f in sorted(SESSION.glob('step-*.json')):
        s = json.loads(f.read_text())
        steps[s['id']] = s
    return steps


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
    # the walk happened on the T112 machine: the replay's last screen is
    # digest-identical to the T112 route's own final screen (both committed,
    # so this binds on any machine)
    last_replay = steps['S039-post-league30-t112']
    t112_last = json.loads(T112_LAST.read_text())
    if last_replay['text_sha256'] != t112_last['text_sha256']:
        raise SystemExit('the replay does not end on the T112 machine')
    anchor = steps['S041-anchor']
    if not anchor['highlighted'] or 'Players' not in str(anchor['highlighted']):
        raise SystemExit('the walk is not anchored at Players')
    screens = {}
    for t_idx, name in enumerate(SCREENS, start=1):
        enter = steps[f'S201-enter-{t_idx}']
        poll = steps[f'S201-enter-{t_idx}-poll-0']
        if enter['text_sha256'] != poll['text_sha256']:
            raise SystemExit(f'{name}: the enter and its poll differ')
        if 'PLAY NEXT GAME' in enter['text']:
            raise SystemExit(f'{name}: the enter never left the main screen')
        show = steps[f'S201-show-{t_idx}']
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
        binding=dict(replay_ends_on='runs/T112/session-r0019/step-0115.json',
                     replay_text_sha256=last_replay['text_sha256']),
        anchor=dict(number=anchor['number'], row_as_shown='Players'),
        screens=screens,
        f7_save=dict(step_id='S050-f7-save',
                     path=SAVE_DEST.relative_to(ROOT).as_posix(),
                     sha256=save_sha,
                     post_save_number=steps['S051-post-save']['number']))


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
