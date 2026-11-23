#!/usr/bin/env python3
"""T116 capture: the season boundary. Boot the T115 post-league30 lineage save
(SAVE1.1-0, the first committed post-week-30 point), confirm the management
machine, press PLAY NEXT GAME, and record the original's first response: the
immediate screen, any question it asks (answered once), and the first stable
screen after the transition. F7-saves that machine as the next lineage point.

The controller never trusts a key's own capture (T114's lesson): every decision
read follows the key with a no-key capture, and any question is recorded as
shown before it is answered."""
import fcntl
import hashlib
import json
import os
import shutil
import subprocess
import sys
import time
from pathlib import Path

ROOT = Path('/home/diego/projects/onenil-archaeology')
SOURCE_SAVE = ROOT/'.cache/saves/post-league30-t115/SAVE1.1-0'
SAVE_DEST = ROOT/'.cache/saves/post-league30-t116/SAVE1.1-0'
OUT = ROOT/'runs/T116'
LOG = Path('/tmp/opencode/t116-drive.log')
LOCK = ROOT/'.cache/capture.lock'


def log(message):
    with LOG.open('a') as f:
        f.write(message + '\n')


def main():
    LOG.write_text('')
    lock_file = open(LOCK, 'w')
    lock_file.write(f'{Path(__file__).name} pid={os.getpid()}\n')
    lock_file.flush()
    try:
        fcntl.flock(lock_file, fcntl.LOCK_EX | fcntl.LOCK_NB)
        log('capture lock acquired (free)')
    except BlockingIOError:
        log('capture lock held; waiting (blocking flock)')
        fcntl.flock(lock_file, fcntl.LOCK_EX)
        log('capture lock acquired after waiting')
    if not SOURCE_SAVE.exists():
        log(f'the T115 lineage save is absent: {SOURCE_SAVE}')
        fcntl.flock(lock_file, fcntl.LOCK_UN)
        return 1
    states = ROOT/'.cache/T116/states'
    states.mkdir(parents=True, exist_ok=True)
    for stale in states.glob('*.sav'):
        stale.unlink()
    SAVE_DEST.parent.mkdir(parents=True, exist_ok=True)
    process = subprocess.Popen(
        ['python3', 'runtime/driver/manual_session.py', '--run', '--out',
         str(OUT.relative_to(ROOT)), '--route', 'supplied',
         '--save', SOURCE_SAVE.relative_to(ROOT).as_posix(),
         '--state-dir', '.cache/T116/states'],
        cwd=str(ROOT), stdin=subprocess.PIPE, stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT, text=True, bufsize=1)
    session_dir = [None]

    def issue(command):
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
        return step, json.loads(
            (session_dir[0]/f'step-{step["step"]:04d}.json').read_text())

    def follower(prefix, wait=2):
        # a decision read is always a fresh no-key capture
        return issue(dict(id=prefix, keys=[], wait=wait))

    def settled(prefix, state, rounds=4):
        same = 0
        for k in range(rounds):
            previous = state['text']
            _, state = follower(f'{prefix}-settle-{k}', wait=2)
            if state['text'] == previous:
                same += 1
                if same == 2:
                    break
            else:
                same = 0
        return state

    try:
        # boot to the load prompt, then load the lineage save with y
        step, mine = issue(dict(id='S001-launch', keys=[], wait=1))
        rounds = 0
        while 'load a saved game' not in mine['text'] and rounds < 8:
            rounds += 1
            step, mine = issue(dict(id=f'S001-boot-{rounds}', keys=[], wait=2))
        if 'load a saved game' not in mine['text']:
            log(f'BOOT: no prompt; last {mine["text"][:100]!r}')
            return 1
        loaded = False
        for attempt in range(1, 5):
            step, mine = issue(dict(id=f'S002-y-{attempt}', keys=['y'], wait=3))
            for poll in range(3):
                if 'PLAY NEXT GAME' in mine['text']:
                    break
                step, mine = follower(f'S002-poll-{attempt}-{poll}', wait=3)
            if 'PLAY NEXT GAME' in mine['text']:
                loaded = True
                break
            if 'load a saved game' not in mine['text']:
                log(f'LOAD: foreign screen: {mine["text"][:120]!r}')
                return 1
        if not loaded:
            log('LOAD: never reached the management screen')
            return 1
        mine = settled('S002-load', mine)
        # the machine must be the T115 save's: the post-week-30 funds and the
        # season header - the pre-league28 machine showed 1,045,060
        if '1,636,583' not in mine['text']:
            log(f'ALIGN: the loaded machine is not the T115 save: '
                f'{mine["text"][:160]!r}')
            return 1
        log(f'ALIGN ok: the T115 machine loaded (step {step["step"]})')

        # the boundary probe: PLAY NEXT GAME is the menu's selected top row
        step, mine = issue(dict(id='S010-enter', keys=['Enter'], wait=3))
        step, mine = follower('S011-follow', wait=3)
        before = 'PLAY NEXT GAME' in mine['text']
        if before:
            log(f'BOUNDARY: the management screen survived the key: '
                f'{mine["text"][:120]!r}')
        else:
            log(f'BOUNDARY: the screen changed: {mine["text"][:120]!r}')
        mine = settled('S012-boundary', mine)

        # if a question is on screen, record it as shown, then answer once
        question = any(mark in mine['text'] for mark in
                       ('Are you sure', 'are you sure', '(Y/N)', 'Y/N',
                        'Press', 'PRESS'))
        if question and not before:
            log(f'QUESTION as shown: {mine["text"][:400]!r}')
            step, mine = issue(dict(id='S013-answer', keys=['Enter'], wait=3))
            step, mine = follower('S014-answer-follow', wait=3)
            mine = settled('S015-after-answer', mine)
            log(f'AFTER THE ANSWER: {mine["text"][:200]!r}')
        else:
            log(f'NO QUESTION: the transition screen stands: '
                f'{mine["text"][:200]!r}')

        # F7 saves the named game (W005: overwrites without a prompt)
        step, mine = issue(dict(id='S020-f7', keys=['F7'], wait=3))
        step, mine = follower('S021-post-save', wait=2)
        game_dir = Path('/tmp')/f'onenil-manual-T116-{session_dir[0].name}'/'game'
        saved = game_dir/'SAVE1.1-0'
        if not saved.exists():
            log(f'F7: no SAVE1.1-0 in {game_dir}')
            return 1
        digest = hashlib.sha256(saved.read_bytes()).hexdigest()
        shutil.copyfile(saved, SAVE_DEST)
        log(f'F7 saved: {SAVE_DEST} sha256={digest}')
        log('SEASON BOUNDARY CAPTURED')
        issue(dict(finish=True))
        try:
            process.wait(timeout=300)
        except subprocess.TimeoutExpired:
            log('FINISH: the driver hung at shutdown; killing the tree')
            process.kill()
            return 1
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
