#!/usr/bin/env python3
"""T81: authenticate the original management-week completion transaction.

    python3 runtime/driver/week_completion.py --baseline   (see saved_roster.py --baseline)
    python3 runtime/driver/week_completion.py --run runs/T81/session-NEW.json --scratch /tmp/onenil-T81-NEW
    python3 runtime/driver/week_completion.py --check runs/T81/session-r0001.json runs/T81/session-r0002.json

One fresh original session from the supplied campaign plays the prepared fixture
WITHOUT substitutions (the interval is visited, the bench reviewed, no exchange),
then walks the documented W029/W030 route to the management menu. Bounded decoded
observations: the cash-flow screen categories/totals/funds, the transfer-news rows,
the next-fixture menu text, the save digest timeline (boot, post-full-time,
post-week, post-F7 - separating the week-completion autosave from the explicit
save), the save-file decode (manager, club, cash word, first-team roster, roster
players' condition/status/instruction fields), and a fresh-process reload whose
decode must equal the saved decode. An independent session reproduces the decoded
contract; fixture-dependent values are recorded per session without cross-session
equality claims. Public records hold digests, counts and decoded values only.
"""
import argparse
import hashlib
import json
import re
import struct
import subprocess
import sys
import time
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / 'runtime/driver'))
sys.path.insert(0, str(ROOT / 'tools/data'))
import save as save_layout
import driver
import screens
from halftime_replacement import capacity, projection, release, write
from saved_roster import (BASELINE, MANAGED_CLUB, MENU_STAGES, SAVE_FILE, SessionDriver,
                          block_offsets, decode_save, menu_projection, save_digest, sha, encoded,
                          git, git_bytes, source_clean, SOURCE, REFERENCE)

TOOL = 'runtime/driver/week_completion.py'
DEPENDENCIES = [TOOL, 'tools/data/save.py', 'runtime/driver/halftime_replacement.py',
                'runtime/driver/saved_roster.py',
                'runtime/driver/driver.py', 'runtime/driver/screens.py', 'runtime/driver/savestate.py',
                'runtime/driver/xkeys.py', 'runtime/driver/dosbox-x-2024.03.01-default.map']
STAGES = ['preparation', 'halftime', 'bench', 'bench-after', 'resumed', 'fulltime',
          'bench-ft', 'stats', 'cash', 'transfer', 'menu-after', 'saved', 'reloaded']
# Full screen texts are evidence only on the week-transaction screens.
TEXT_STAGES = {'halftime', 'cash', 'transfer', 'menu-after'}


def decode_save_week(data):
    """The T80 bounded decode plus the management/finance fields: the manager
    and managed club bytes (DS:DCBA pair) and the signed cash word at
    DCC4+(manager-1)*94+82 (campaign-seed.md)."""
    d = decode_save(data)
    off = block_offsets()
    manager = data[off['DS:DCBA'][0]]
    club = data[off['DS:DCBA'][0] + 1]
    base = off['[DS:DCC4]'][0] + (manager - 1) * 94
    d['manager'] = manager
    d['club_bytes'] = club
    d['cash'] = struct.unpack_from('<i', data, base + 82)[0]
    return d


def run(out, scratch):
    """One authenticated session: the plain watched week from kick-off to the
    reloaded management menu, with the save digest timeline and decoded saves."""
    if out.exists() or scratch.exists():
        raise ValueError('fresh output/scratch required')
    if not source_clean():
        raise ValueError('commit driver first')
    baseline_path = ROOT / BASELINE
    baseline = json.loads(baseline_path.read_text())
    stages, timeline, decoded_saves = [], [], {}
    record = dict(
        schema='original-week-completion/1', producer=git('rev-parse', 'HEAD'),
        producer_files={p: sha((ROOT / p).read_bytes()) for p in DEPENDENCIES},
        release=release(), dosbox_version=driver.WANT_DOSBOX, status='aborted',
        processes_exited=False, baseline=dict(path=BASELINE, sha256=sha(baseline_path.read_bytes())),
        restart=None, payload=dict(start=None, stages=stages, save_timeline=timeline,
                                   decoded_saves=decoded_saves), error=None)
    start = time.monotonic()
    progress = out.with_name(out.stem + '-progress.jsonl')
    d = SessionDriver(workdir=scratch, game_dir=scratch / 'game')

    def note(row):
        with progress.open('a') as f:
            f.write(json.dumps(dict(name=row['name'], t=round(time.monotonic() - start, 1),
                                    state_sha256=row['state_sha256'])) + '\n')

    def file_digest(at):
        row = save_digest(d.game_dir)
        timeline.append(dict(at=at, **row))
        return row

    def observe(name, keys=(), want=None, wait=None, keep_text=False):
        for k in keys:
            d.keys(k)
        if wait is not None:
            d.wait_screen(lambda s: wait in s.text(), timeout=20, what=name)
        time.sleep(.25)
        _, st, data = d.read()
        sc = st.screen()
        text = sc.text()
        if want is not None and want not in text:
            raise ValueError('screen %s lacks %r' % (name, want))
        state = menu_projection(st) if name in MENU_STAGES else projection(st)
        row = dict(name=name, keys=list(keys),
                   screen_sha256=sc.digest(), savestate_sha256=sha(data),
                   state_sha256=sha(encoded(state)), state=state)
        if keep_text or name in TEXT_STAGES:
            row['text'] = text
        stages.append(row)
        note(row)
        print(name, flush=True)
        return text

    try:
        d.launch()
        time.sleep(3)
        d.keys('y')
        time.sleep(3)
        d.wait_screen(lambda s: 'PLAY NEXT GAME' in s.text(), what='supplied main')
        boot_file = file_digest('boot')
        if boot_file['sha256'] != baseline['source']['sha256']:
            raise ValueError('boot save file differs from the authenticated baseline')
        decoded_saves['boot'] = decode_save_week((Path(d.game_dir) / SAVE_FILE).read_bytes())
        record['payload']['start'] = dict(savestate_sha256=sha(d.last_blob),
                                          screen_sha256=d.last[1].screen().digest(),
                                          save_file=boot_file, keys=['y', 'Return'])
        d.keys('Return')
        d.wait_screen(lambda s: 'PLAY GAME' in s.text(), what='preparation')
        observe('preparation')
        d.keys('Return')
        deadline = time.monotonic() + 900
        while time.monotonic() < deadline:
            time.sleep(2)
            text = d.screen().text()
            if 'HALF TIME' in text and 'press any key' in text.lower():
                break
        else:
            raise RuntimeError('genuine halftime not reached within 900 seconds')
        observe('halftime', keep_text=True)
        observe('bench', ['space'])
        observe('bench-after', ['Escape'])
        d.keys('Return')
        d.wait_screen(lambda s: projection(d.last[1])['elapsed'] > stages[-1]['state']['elapsed'],
                      timeout=30, what='second half progression')
        observe('resumed')
        deadline = time.monotonic() + 1200
        while time.monotonic() < deadline:
            time.sleep(2)
            if 'FULL TIME' in d.screen().text():
                break
        else:
            raise RuntimeError('full time not reached within 1200 seconds')
        deadline = time.monotonic() + 120
        while time.monotonic() < deadline:
            time.sleep(2)
            text = d.screen().text()
            if 'FULL TIME' in text and 'print commentary' in text:
                break
        else:
            raise RuntimeError('fulltime pitch did not settle within 120 seconds')
        observe('fulltime', want='FULL TIME')
        observe('bench-ft', ['Return'], wait='CONTINUE')
        d.keys('Return')
        time.sleep(1)
        observe('stats', ['n'], wait='MAN OF THE MATCH')
        observe('cash', ['space'], wait='CASH FLOW', keep_text=True)
        observe('transfer', ['space'], wait='TRANSFER', keep_text=True)
        observe('menu-after', ['space'], wait='PLAY NEXT GAME', keep_text=True)
        file_digest('menu-after')
        d.keys('F7')
        time.sleep(2.5)
        saved_file = file_digest('saved')
        if saved_file['sha256'] == boot_file['sha256']:
            raise ValueError('the week left the boot save file in place')
        decoded_saves['saved'] = decode_save_week((Path(d.game_dir) / SAVE_FILE).read_bytes())
        observe('saved', wait='PLAY NEXT GAME')
        files = {p.name: p.read_bytes() for p in Path(d.game_dir).iterdir()
                 if p.suffix.lower() == '.1-0'}
        old_pid = d.dbx.pid
        exited = d.terminate()
        if not exited:
            raise RuntimeError('old processes remain before reload')
        restart_scratch = scratch / 'restart'
        d = SessionDriver(workdir=restart_scratch, game_dir=restart_scratch / 'game',
                          preload_saves=files)
        record['restart'] = dict(old_pid=old_pid, new_pid=None, old_processes_exited=exited,
                                 saved_files={n: sha(b) for n, b in files.items()},
                                 restored_files=None,
                                 intervention='Copied only game saves after verified release copy '
                                              'and before the new emulator process/mount; no emulator state restored.')
        d.launch()
        time.sleep(3)
        d.keys('y')
        time.sleep(3)
        d.wait_screen(lambda s: 'PLAY NEXT GAME' in s.text(), what='reloaded main')
        record['restart']['new_pid'] = d.dbx.pid
        record['restart']['restored_files'] = {n: sha((Path(d.game_dir) / n).read_bytes())
                                               for n in files}
        observe('reloaded')
        validate_session(record['payload'], baseline)
        record['status'] = 'completed'
    except Exception as exc:
        record['error'] = f'{type(exc).__name__}: {exc}'
        raise
    finally:
        record['processes_exited'] = d.terminate()
        record['elapsed_seconds'] = time.monotonic() - start
        record['driver_events'] = d.events
        record['payload_sha256'] = sha(encoded(record['payload']))
        write(out, record)
    validate_record(record)


def validate_session(payload, baseline):
    """The T81 contract: the plain week transaction, decoded and bound."""
    stages = payload['stages']
    if [s['name'] for s in stages] != STAGES:
        raise ValueError('stage census/order differs')
    rows = {s['name']: s for s in stages}
    for row in stages:
        if sha(encoded(row['state'])) != row['state_sha256']:
            raise ValueError('state digest differs')
        if not all(re.fullmatch('[0-9a-f]{64}', row[k]) for k in ('screen_sha256', 'savestate_sha256')):
            raise ValueError('observation identity differs')
    def managed_roster(name):
        st = rows[name]['state']
        return next(c for c in st['clubs'] if c['id'] == MANAGED_CLUB)['roster']
    def managed_side(state):
        return next(i for i, c in enumerate(state['clubs']) if c['id'] == MANAGED_CLUB)
    boot_roster = managed_roster('preparation')
    # No substitution: the roster and the unchanged capacity persist through full time.
    for name in ('halftime', 'bench', 'bench-after', 'resumed', 'fulltime'):
        st = rows[name]['state']
        if managed_roster(name) != boot_roster:
            raise ValueError('%s changed the roster without a replacement' % name)
        if capacity(st, managed_side(st)) != capacity(rows['preparation']['state'], managed_side(rows['preparation']['state'])):
            raise ValueError('%s changed the substitution capacity' % name)
    if rows['fulltime']['state']['elapsed'] <= rows['resumed']['state']['elapsed']:
        raise ValueError('second half did not advance to full time')
    for name, marker in (('cash', 'CASH FLOW'), ('transfer', 'TRANSFER'),
                         ('menu-after', 'PLAY NEXT GAME')):
        if marker not in rows[name].get('text', ''):
            raise ValueError('%s lacks the %r marker' % (name, marker))
    timeline = {t['at']: t for t in payload['save_timeline']}
    for name in ('boot', 'menu-after', 'saved'):
        if name not in timeline:
            raise ValueError('save timeline missing ' + name)
    if timeline['boot']['sha256'] != baseline['source']['sha256']:
        raise ValueError('boot save differs from the baseline')
    if timeline['menu-after']['sha256'] == timeline['boot']['sha256']:
        raise ValueError('the management week left the save file unchanged')
    if timeline['saved']['sha256'] == timeline['boot']['sha256']:
        raise ValueError('F7 left the boot save file in place')
    saved = payload['decoded_saves']['saved']
    boot_decoded = payload['decoded_saves']['boot']
    if saved['clubs'][str(MANAGED_CLUB)]['roster'] != boot_roster:
        raise ValueError('saved roster differs from the kickoff roster')
    if boot_decoded['clubs'][str(MANAGED_CLUB)]['roster'] != boot_roster:
        raise ValueError('boot decode differs from the kickoff roster')
    if saved['cash'] == boot_decoded['cash']:
        raise ValueError('the week left the recorded cash unchanged')
    if saved['manager'] != boot_decoded['manager'] or saved['club_bytes'] != boot_decoded['club_bytes']:
        raise ValueError('the week changed the manager or club bytes')
    for identifier, fields in boot_decoded['clubs'][str(MANAGED_CLUB)]['players'].items():
        after = saved['clubs'][str(MANAGED_CLUB)]['players'][identifier]
        if (after['current_position'], after['club_position']) != (fields['current_position'], fields['club_position']):
            raise ValueError('the week moved a player position: ' + identifier)
    if rows['menu-after']['screen_sha256'] == rows['preparation']['screen_sha256']:
        raise ValueError('management return did not advance the menu')
    reload_players = rows['reloaded']['state']['players']
    saved_players = saved['clubs'][str(MANAGED_CLUB)]['players']
    for identifier, fields in saved_players.items():
        live = reload_players.get(identifier)
        if live is None or {k: live[k] for k in fields} != fields:
            raise ValueError('reloaded player fields differ: ' + identifier)
    if rows['reloaded']['state']['seed'] != saved['seed_word']:
        raise ValueError('reloaded seed differs from the saved seed word')
    fixed = {'preparation': ['Return'], 'halftime': [], 'bench': ['space'], 'bench-after': ['Escape'],
             'resumed': ['Return'], 'fulltime': [], 'bench-ft': ['Return'], 'stats': ['n'],
             'cash': ['space'], 'transfer': ['space'], 'menu-after': ['space'], 'saved': [],
             'reloaded': []}
    for name, keys in fixed.items():
        if rows[name]['keys'] != keys:
            raise ValueError('%s input differs' % name)
    return dict(cash=saved['cash'], roster_slots=20)


def validate_record(record):
    if record['schema'] != 'original-week-completion/1' or record['status'] != 'completed' \
            or not record['processes_exited']:
        raise ValueError('incomplete original session')
    if record['release'] != release() or record['dosbox_version'] != driver.WANT_DOSBOX:
        raise ValueError('release/runtime differs')
    if set(record['producer_files']) != set(DEPENDENCIES):
        raise ValueError('producer census differs')
    for name, digest in record['producer_files'].items():
        if sha(git_bytes('show', record['producer'] + ':' + name)) != digest:
            raise ValueError('producer identity differs: ' + name)
    if sha(encoded(record['payload'])) != record['payload_sha256']:
        raise ValueError('payload digest differs')
    restart = record.get('restart')
    if not restart or not restart['old_processes_exited'] \
            or restart['saved_files'] != restart['restored_files'] or not restart['new_pid']:
        raise ValueError('restart receipt differs')
    baseline_path = ROOT / BASELINE
    if not baseline_path.is_file() or sha(baseline_path.read_bytes()) != record['baseline']['sha256']:
        raise ValueError('baseline record differs')
    baseline = json.loads(baseline_path.read_text())
    return validate_session(record['payload'], baseline)


def check(paths):
    records = [json.loads(p.read_text()) for p in paths]
    contracts = [validate_record(r) for r in records]
    if len(records) < 2 or len({r['payload']['start']['savestate_sha256'] for r in records}) < 2:
        raise ValueError('independent fresh sessions required')
    if any(c != contracts[0] for c in contracts[1:]):
        raise ValueError('repeat contract differs')
    print('PASS week-completion sessions:', len(records), 'independent sessions', contracts[0])


def main(argv):
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('--check', type=Path, nargs='+')
    p.add_argument('--run', type=Path)
    p.add_argument('--scratch', type=Path)
    a = p.parse_args(argv)
    if a.check:
        check(a.check)
    elif a.run and a.scratch:
        run(a.run, a.scratch)
    else:
        p.error('choose --run OUTPUT --scratch NEW_PATH or --check RECORDS')


if __name__ == '__main__':
    main(sys.argv[1:])
