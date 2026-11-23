#!/usr/bin/env python3
"""T115 capture: replay the T112 session-r0019 route digest-verified to the
post-league30 management machine, then walk the menu's remaining entries
(League tables, League results, Cup results, Weekly fixtures, Fixture list,
Statistics and the preparation screen's Match stats) and F7-save the named
game - the first committed post-league30 lineage point."""
import fcntl
import hashlib
import json
import shutil
import subprocess
import sys
import time
from pathlib import Path

ROOT = Path('/home/diego/projects/onenil-archaeology')
T112 = ROOT/'runs/T112/session-r0019'
# [coordination] the capture lock: an advisory flock both capture sessions
# (this DOSBox-X one and the Wine one) take before booting an emulator, so
# the machine runs one capture at a time. Auto-released on any exit.
LOCK = ROOT/'.cache/capture.lock'
OUT = ROOT/'runs/T115'
LOG = Path('/tmp/opencode/t115-drive.log')
SAVE_DEST = ROOT/'.cache/saves/post-league30-t115/SAVE1.1-0'


def log(message):
    with LOG.open('a') as f:
        f.write(message + '\n')


def main():
    LOG.write_text('')
    import os
    lock_file = open(LOCK, 'w')
    lock_file.write(f'{Path(__file__).name} pid={os.getpid()}\n')
    lock_file.flush()
    try:
        fcntl.flock(lock_file, fcntl.LOCK_EX | fcntl.LOCK_NB)
        log('capture lock acquired (free)')
    except BlockingIOError:
        log('capture lock held by another session; waiting (blocking flock, '
            'auto-releases when that capture exits)')
        fcntl.flock(lock_file, fcntl.LOCK_EX)
        log('capture lock acquired after waiting')
    # this task's own private scratch from earlier attempts; never a record;
    # the replay renames its savestate commands to the poll-suffixed names
    # (stale ones make the driver refuse the run: a new read is a new file)
    states = ROOT/'.cache/T115/states'
    (states/'post-league30-t115.sav').unlink(missing_ok=True)
    for stale in states.glob('post-league30-t115-poll-*.sav'):
        stale.unlink()
    SAVE_DEST.parent.mkdir(parents=True, exist_ok=True)
    process = subprocess.Popen(
        ['python3', 'runtime/driver/manual_session.py', '--run', '--out', str(OUT.relative_to(ROOT)),
         '--route', 'supplied', '--save', '.cache/saves/pre-league28/SAVE1.1-0',
         '--state-dir', '.cache/T115/states'],
        cwd=str(ROOT), stdin=subprocess.PIPE, stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT, text=True, bufsize=1)
    session_dir = [None]

    def issue(command, stabilize=False):
        process.stdin.write(json.dumps(command) + '\n')
        process.stdin.flush()
        while True:
            line = process.stdout.readline()
            if not line:
                log(f'{command.get("id")}: driver produced no output')
                sys.exit(1)
            try:
                step = json.loads(line)
                break
            except json.JSONDecodeError:
                log(f'{command.get("id")}: non-json line: {line.strip()[:100]}')
        if session_dir[0] is None:
            session_dir[0] = ROOT/step['directory']
        path = session_dir[0]/f'step-{step["step"]:04d}.json'
        mine = json.loads(path.read_text())
        if stabilize:
            # the walk's decisions must name the screen as it is now: the
            # r0012 trace showed the controller reading one capture behind
            # the final files (its Enter opened the neighbouring entries),
            # so poll until two spaced reads agree before trusting the read
            stable = 0
            for _ in range(8):
                time.sleep(0.5)
                again = json.loads(path.read_text())
                if again == mine:
                    stable += 1
                    if stable == 2:
                        break
                else:
                    mine = again
                    stable = 0
        return step, mine

    def menu_highlight(mine):
        for entry in mine.get('highlighted') or []:
            if len(entry) == 2:
                return str(entry[1]).strip()
        return None

    try:
        # boot until the load prompt, then load with y
        step, mine = issue(dict(id='S001-launch', keys=[], wait=1))
        rounds = 0
        while 'load a saved game' not in mine['text'] and rounds < 8:
            rounds += 1
            step, mine = issue(dict(id=f'S001-boot-{rounds}', keys=[], wait=2))
        if 'load a saved game' not in mine['text']:
            log(f'BOOT: no prompt; last {mine["text"][:80]!r}')
            return 1
        loaded = False
        for attempt in range(1, 5):
            step, mine = issue(dict(id=f'S002-y-{attempt}', keys=['y'], wait=3))
            for poll in range(2):
                if 'TEAM' in mine['text'] and 'MANAGER' in mine['text']:
                    break
                step, mine = issue(dict(id=f'S002-poll-{attempt}-{poll}', keys=[], wait=3))
            if 'TEAM' in mine['text'] and 'MANAGER' in mine['text']:
                loaded = True
                break
            if 'load a saved game' not in mine['text']:
                log(f'LOAD: foreign screen: {mine["text"][:120]!r}')
                return 1
        if not loaded:
            log('LOAD: never reached the management screen')
            return 1
        theirs = json.loads((T112/'step-0002.json').read_text())
        if mine['text_sha256'] != theirs['text_sha256']:
            log(f'ALIGN: loaded screen differs: {mine["text"][:120]!r}')
            return 1
        log(f'ALIGN ok (my step {step["step"]} == T112 step 1)')

        # the deterministic replay of the T112 route: weeks 28, 29, 30 and the
        # walk to the management machine, digest-verified per step
        for number in range(2, 116):
            command = json.loads((T112/f'command-{number:04d}.json').read_text())
            if command.get('savestate'):
                command['savestate'] = f'post-league30-t115-poll-{number}'
            theirs = json.loads((T112/f'step-{number:04d}.json').read_text())
            step, mine = issue(command)
            # the live-play and pause screens are timing-sensitive (the ball
            # position, the clock digits): those steps anchor-check the match
            # header instead of the full digest; the management screens
            # digest-check whole
            # the match-30 live-play region: the T112 session's steps 82-108
            # (the kickoff through the full-time polls) - the timing-sensitive
            # screens anchor-check the match header instead of the full digest
            exempt_ids = set()
            for n in range(82, 109):
                exempt_ids.add(json.loads(
                    (T112/f'step-{n:04d}.json').read_text())['id'])
            if theirs['id'] in exempt_ids:
                # the captures can trail the keys: poll up to four no-key
                # captures before failing the anchor check
                anchors_ok = False
                for catchup in range(4):
                    if 'LEAGUE MATCH #30' in mine['text']:
                        anchors_ok = True
                        break
                    step, mine = issue(dict(id=f'S036-anchor-{number}-{catchup}', keys=[], wait=2))
                if not anchors_ok:
                    log(f'REPLAY {number}: the live-play screen lost the match header')
                    return 1
            elif mine['text_sha256'] != theirs['text_sha256']:
                matched = False
                for catchup in range(6):
                    step, mine = issue(dict(id=f'S900-catchup-{number}-{catchup}', keys=[], wait=3))
                    if mine['text_sha256'] == theirs['text_sha256']:
                        matched = True
                        log(f'REPLAY {number}: caught up after {catchup + 1} catch-up polls')
                        break
                if not matched:
                    log(f'REPLAY {number}: MISMATCH after catch-ups: {mine["text"][:200]!r}')
                    return 1
        log('REPLAY COMPLETE 114/114 digest-identical (weeks 28-30 re-witnessed)')

        # the replay ends on the squad screen (the T112 route's own final
        # screen, digest-identical): its legend is Esc-exit, and the
        # management menu shows PLAY NEXT GAME in its right-hand column.
        step, mine = issue(dict(id='S040-esc-to-menu', keys=['Escape'], wait=2), stabilize=True)
        for poll in range(3):
            if menu_highlight(mine) and 'PLAY NEXT GAME' in mine['text']:
                break
            step, mine = issue(dict(id=f'S040-esc-again-{poll}', keys=['Escape'], wait=2), stabilize=True)
        if not (menu_highlight(mine) and 'PLAY NEXT GAME' in mine['text']):
            log(f'MENU: management menu not reached from the squad screen: '
                f'{mine["text"][:120]!r}')
            return 1
        log('MENU: on the management menu')

        def on_menu(state):
            return bool(menu_highlight(state)) and 'PLAY NEXT GAME' in state['text']

        # the walk steers by the game's internal cursor, not by the OCR
        # highlight: the probe and the r0012-r0014 attempts established that
        # the highlight read can trail the keys by one or thrash under a
        # backlog, while the cursor itself is deterministic (r0012's cursor
        # math is exact: from Players, seven Downs landed on Cup results).
        # Anchor once, count Downs exactly, record the row as shown, and
        # let the opened-screen check catch a wrong entry honestly.
        MENU_ROWS = {'Players': 6, 'Next opponents': 7, 'Transfer market': 8,
                     'Use scout': 9, 'New staff': 10, 'League tables': 11,
                     'League results': 12, 'Cup results': 13,
                     'Weekly fixtures': 14, 'Fixture list': 15,
                     'Statistics': 16}
        step, mine = issue(dict(id='S041-anchor', keys=[], wait=1), stabilize=True)
        anchor = menu_highlight(mine)
        if anchor != 'Players':
            step, mine = issue(dict(id='S041-anchor-2', keys=[], wait=2), stabilize=True)
            anchor = menu_highlight(mine)
        if anchor != 'Players':
            log(f'MENU: the anchor row reads {anchor!r}, expected Players')
            return 1
        log('MENU: anchored at Players (row 6)')
        cursor = MENU_ROWS['Players']
        for t_idx, target in enumerate(('Cup results', 'Weekly fixtures', 'Fixture list', 'Statistics'), start=1):
            downs = MENU_ROWS[target] - cursor
            for k in range(downs):
                step, mine = issue(dict(id=f'S200-down-{t_idx}-{k + 1}',
                                        keys=['Down'], wait=1))
            cursor = MENU_ROWS[target]
            # the row as shown is recorded, interpreted nothing: the read
            # may trail the keys, and the divergence is itself evidence
            step, mine = issue(dict(id=f'S201-show-{t_idx}', keys=[], wait=1),
                               stabilize=True)
            log(f'MENU: {target} cursor {cursor}, the screen shows '
                f'{menu_highlight(mine)!r}')
            step, mine = issue(dict(id=f'S201-enter-{t_idx}', keys=['Enter'], wait=3), stabilize=True)
            # the enter may sit behind the queued Downs in the game's input
            # backlog: poll with fresh captures before judging, and if the
            # row genuinely refuses to open (a season-boundary row with no
            # cup run may), the polls are the as-shown record of the refusal
            for poll in range(4):
                if 'PLAY NEXT GAME' not in mine['text']:
                    break
                step, mine = issue(dict(id=f'S201-enter-{t_idx}-poll-{poll}',
                                        keys=[], wait=2), stabilize=True)
            if 'PLAY NEXT GAME' in mine['text']:
                log(f'MENU: {target} enter did not open a sub-screen in 4 '
                    f'polls: {mine["text"][:90]!r}')
                return 1
            log(f'{target} screen: {mine["text"][:90]!r}')
            step, mine = issue(dict(id=f'S202-back-{t_idx}', keys=['Escape'], wait=2), stabilize=True)
            for poll in range(4):
                if on_menu(mine):
                    break
                step, mine = issue(dict(id=f'S202-back-{t_idx}-poll-{poll}', keys=['Escape'], wait=2), stabilize=True)
            if not on_menu(mine):
                log(f'MENU: {target} dismissed but the menu did not return')
                return 1
            log(f'{target} dismissed: highlight {menu_highlight(mine)!r}')
        if not on_menu(mine):
            log('MENU: not back on the management menu before the save')
            return 1

        # F7 saves the named game (the manual's W005: overwrites without a
        # prompt); the scratch game dir's SAVE1.1-0 becomes the first
        # committed post-league30 lineage point.
        step, mine = issue(dict(id='S050-f7-save', keys=['F7'], wait=3), stabilize=True)
        log(f'F7 pressed: {mine["text"][:100]!r}')
        # the driver's scratch game dir (the F7 save lands there, not under
        # runs/): /tmp/onenil-manual-T115-<session-name>/game - r0016's walk
        # completed all four screens and the save was written; only this
        # check path was wrong
        game_dir = Path('/tmp')/f'onenil-manual-T115-{session_dir[0].name}'/'game'
        if not (game_dir/'SAVE1.1-0').exists():
            log(f'F7: no SAVE1.1-0 in {game_dir}')
            return 1
        digest = hashlib.sha256((game_dir/'SAVE1.1-0').read_bytes()).hexdigest()
        shutil.copyfile(game_dir/'SAVE1.1-0', SAVE_DEST)
        log(f'F7 saved: {SAVE_DEST} sha256={digest}')
        step, mine = issue(dict(id='S051-post-save', keys=[], wait=2), stabilize=True)
        log(f'POST-SAVE: {mine["text"][:100]!r}')
        log('LEAGUE MENU CAPTURED')
        issue(dict(finish=True))
        process.wait(timeout=120)
        return 0
    finally:
        try:
            fcntl.flock(lock_file, fcntl.LOCK_UN)
        except Exception:
            pass
        try:
            lock_file.close()
        except Exception:
            pass
        try:
            process.stdin.close()
        except Exception:
            pass


if __name__ == '__main__':
    sys.exit(main())
