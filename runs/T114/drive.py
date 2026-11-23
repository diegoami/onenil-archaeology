#!/usr/bin/env python3
"""T114 capture: replay T106 digest-verified, week 30 to the injury pause,
then the sighted PUT HERE substitution (Sherwood out, a substitute in), the
resumed second half to full time, and the league walk. The record is the
session; a mismatch stops it honestly."""
import json
import re
import subprocess
import sys
import time
from pathlib import Path

ROOT = Path('/home/diego/projects/onenil-archaeology')
T106 = ROOT/'runs/T106/session-r0014'
OUT = ROOT/'runs/T114'
LOG = Path('/tmp/opencode/t114-drive.log')
SUBS = ('S Ripley', 'C Hendry', 'H Berg', 'B Mimms')
INJURED = 'T Sherwood'


def log(message):
    with LOG.open('a') as f:
        f.write(message + '\n')


def main():
    LOG.write_text('')
    for name in ('pre-pause-t114.sav', 'post-league29-t114.sav', 'post-league30-t114.sav'):
        (ROOT/'.cache/T114/states'/name).unlink(missing_ok=True)
    process = subprocess.Popen(
        ['python3', 'runtime/driver/manual_session.py', '--run', '--out', str(OUT.relative_to(ROOT)),
         '--route', 'supplied', '--save', '.cache/saves/pre-league28/SAVE1.1-0',
         '--state-dir', '.cache/T114/states'],
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
            # the walk and the substitution flow decide on what the screen
            # shows NOW: the T115 probe proved the capture can trail the
            # game's input processing by one (r0009's space loop broke one
            # press late on a lagged read and made the downs on the wrong
            # screen), so poll until two spaced reads agree before trusting
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

    def cursor_name_highlights(mine):
        for entry in mine.get('highlighted') or []:
            if len(entry) == 2:
                candidate = str(entry[1]).strip()
                words = candidate.split()
                if len(words) >= 2 and all(
                        word[0].isupper() and not (len(word) > 1 and word.isupper())
                        for word in words):
                    return candidate
        return None

    def cursor_name(mine):
        # the selected player is named in the details pane's header row:
        # '│ T Flowers       Age 27  Team Blackburn R----'
        for line in mine['text'].splitlines():
            match = re.match(r'│\s*([A-Z][A-Za-z. \'-]+?)\s+Age\s+\d', line)
            if match:
                return match.group(1).strip()
        return cursor_name_highlights(mine)

    try:
        # boot until the load prompt, then load with y (retried if the prompt
        # re-appears), then the T106 replay, digest-verified in order.
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
        theirs = json.loads((T106/'step-0001.json').read_text())
        if mine['text_sha256'] != theirs['text_sha256']:
            log(f'ALIGN: loaded screen differs: {mine["text"][:120]!r}')
            return 1
        log(f'ALIGN ok (my step {step["step"]} == T106 step 1)')
        for number in range(2, 54):
            command = json.loads((T106/f'command-{number:04d}.json').read_text())
            if command.get('savestate'):
                command['savestate'] = 'pre-pause-t114'
            theirs = json.loads((T106/f'step-{number:04d}.json').read_text())
            step, mine = issue(command)
            if mine['text_sha256'] != theirs['text_sha256']:
                step, mine = issue(dict(id=f'S900-catchup-{number}', keys=[], wait=2))
                if mine['text_sha256'] != theirs['text_sha256']:
                    log(f'REPLAY {number}: MISMATCH after catch-up: {mine["text"][:200]!r}')
                    return 1
        log('REPLAY COMPLETE 52/52 digest-identical')

        prep = False
        for press in range(1, 4):
            step, mine = issue(dict(id=f'S031-prep30-{press}', keys=['Enter'], wait=2))
            for extra in range(2):
                if 'RATINGS' in mine['text'] and 'PLAY NEXT GAME' not in mine['text']:
                    break
                step, mine = issue(dict(id=f'S031-catchup-{press}-{extra}', keys=[], wait=2))
            if 'RATINGS' in mine['text'] and 'PLAY NEXT GAME' not in mine['text']:
                prep = True
                break
            if 'PLAY NEXT GAME' not in mine['text']:
                log(f'PREP: foreign screen: {mine["text"][:150]!r}')
                return 1
        if not prep:
            log('PREP: never reached the preparation screen')
            return 1
        log(f'PREP reached (step {step["step"]})')

        step, mine = issue(dict(id='S032-kickoff', keys=['Enter'], wait=3))
        if 'HALF TIME' not in mine['text']:
            step, mine = issue(dict(id='S032-catchup', keys=[], wait=3))
            if 'HALF TIME' not in mine['text']:
                log(f'KICKOFF: no halftime screen: {mine["text"][:200]!r}')
                return 1
        log(f'HALF TIME reached (step {step["step"]})')
        step, mine = issue(dict(id='S033-bench', keys=['space'], wait=2))
        if 'versus' not in mine['text']:
            step, mine = issue(dict(id='S033-catchup', keys=[], wait=2))
        if 'versus' not in mine['text']:
            log(f'BENCH: not the bench screen: {mine["text"][:150]!r}')
            return 1
        step, mine = issue(dict(id='S034-resume', keys=['Enter'], wait=4))
        log(f'RESUMED: {mine["text"][:70]!r}')

        # poll the pitch: the injury fires mid-second-half; the game pauses on
        # the statistics screen offering SUBSTITUTION OPPORTUNITY / press any key
        paused_step = None
        for tick in range(30):
            if 'SUBSTITUTION OPPORTUNITY' in mine['text']:
                paused_step = step['step']
                log(f'PAUSE: the injury substitution offer at step {paused_step} (tick {tick})')
                break
            if 'FULL TIME' in mine['text']:
                log('FULL TIME appeared without the pause; the flow cannot be witnessed here')
                return 1
            step, mine = issue(dict(id=f'S035-poll-{tick}', keys=[], wait=2),
                               stabilize=True)
        if paused_step is None:
            log('PAUSE: never appeared in 30 polls')
            return 1

        # W028's route, content-routed with follower reads (the r0011/r0009
        # lesson compounded: a capture can trail its own key AND the reads
        # can be stable-stale - r0011's loop broke on space-3's lagged read
        # while space-3 was dismissing the very screen it named). Every key
        # here is followed by a no-key follower capture, the layer is
        # identified by content, and the substitution mode is accepted only
        # when TWO consecutive followers show MAKE SUBSTITUTION.
        players = False
        for press in range(1, 5):
            step, mine = issue(dict(id=f'S036-space-{press}', keys=['space'], wait=2),
                               stabilize=True)
            step, mine = issue(dict(id=f'S036-follow-{press}', keys=[], wait=2),
                               stabilize=True)
            marks = [m for m in ('MAKE SUBSTITUTION', 'PLAY GAME',
                                 'SUBSTITUTION OPPORTUNITY', 'PLAYER DETAILS')
                     if m in mine['text']]
            log(f'space {press}: the follower reads {marks} '
                f'({mine["text"][:60]!r})')
            if 'TRANSFER NEWS' in mine['text'] or 'FULL TIME' in mine['text']:
                log(f'SUB: the walk advanced past Players: {mine["text"][:120]!r}')
                return 1
            if 'MAKE SUBSTITUTION' in mine['text']:
                step, mine = issue(dict(id=f'S036-confirm-{press}', keys=[], wait=2),
                                   stabilize=True)
                if 'MAKE SUBSTITUTION' in mine['text']:
                    players = True
                    log(f'the substitution squad screen verified at space '
                        f'{press} (step {step["step"]})')
                    break
                log(f'space {press}: the footer is not stable across '
                    f'followers ({mine["text"][:80]!r})')
                return 1
        if not players:
            log('SUB: the substitution squad screen never verified in 4 spaces')
            return 1

        downs = 0
        cursor = cursor_name(mine)
        while cursor != INJURED and downs < 12:
            downs += 1
            step, mine = issue(dict(id=f'S037-down-{downs}', keys=['Down'], wait=1),
                               stabilize=True)
            step, mine = issue(dict(id=f'S037-follow-{downs}', keys=[], wait=2),
                               stabilize=True)
            cursor = cursor_name(mine)
        if cursor != INJURED:
            log(f'SUB: {INJURED} never highlighted (cursor {cursor!r})')
            return 1
        log(f'SUB: {INJURED} highlighted after {downs} downs')
        step, mine = issue(dict(id='S038-put-here', keys=['Enter'], wait=2),
                           stabilize=True)
        if 'PUT HERE' not in mine['text']:
            log(f'PUT HERE: not started: {mine["text"][:200]!r}')
            return 1
        log('PUT HERE started')
        chosen = None
        for subs_down in range(1, 13):
            step, mine = issue(dict(id=f'S039-sub-down-{subs_down}', keys=['Down'], wait=1),
                               stabilize=True)
            step, mine = issue(dict(id=f'S039-sub-follow-{subs_down}', keys=[], wait=2),
                               stabilize=True)
            cursor = cursor_name(mine)
            if cursor in SUBS:
                chosen = cursor
                break
        if chosen is None:
            log('SUB: no substitute highlighted in 12 downs')
            return 1
        step, mine = issue(dict(id='S040-confirm', keys=['Enter'], wait=2),
                           stabilize=True)
        log(f'SUB: {chosen} confirmed after {subs_down} downs')
        step, mine = issue(dict(id='S041-esc-bench', keys=['Escape'], wait=2),
                           stabilize=True)
        log(f'BACK ON BENCH: {mine["text"][:80]!r}')
        step, mine = issue(dict(id='S042-resume', keys=['Enter'], wait=4),
                           stabilize=True)
        log(f'RESUMED: {mine["text"][:80]!r}')

        full = False
        for tick in range(20):
            step, mine = issue(dict(id=f'S043-full-time-{tick}', keys=[], wait=3),
                               stabilize=True)
            if 'FULL TIME' in mine['text']:
                full = True
                log(f'FULL TIME at step {step["step"]} (tick {tick})')
                break
            if 'LEAGUE MATCH #30' not in mine['text']:
                log(f'FT poll: left the pitch: {mine["text"][:150]!r}')
                return 1
        if not full:
            log('FULL TIME never appeared in 20 polls')
            return 1
        reached = False
        for number in range(1, 9):
            step, mine = issue(dict(id=f'S044-walk-{number}', keys=['space'], wait=2),
                               stabilize=True)
            first = next((l for l in mine['text'].splitlines() if l.strip()), '')
            log(f'walk {number} (step {step["step"]}): {first[:70]!r}')
            if 'PLAY NEXT GAME' in mine['text']:
                reached = True
                break
        if not reached:
            log('WALK: management never appeared in 8 spaces')
            return 1
        step, mine = issue(dict(id='S045-post-league30-t114', keys=[], wait=1,
                                savestate='post-league30-t114'))
        log(f'savestate written at step {step["step"]}')
        log('WEEK 30 WITH THE SUBSTITUTION CAPTURED')
        process.wait(timeout=120)
        return 0
    finally:
        try:
            process.stdin.close()
        except Exception:
            pass


if __name__ == '__main__':
    sys.exit(main())
