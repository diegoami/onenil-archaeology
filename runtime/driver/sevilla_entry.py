#!/usr/bin/env python3
"""T89 stage 1: the authenticated entry session for the Sevilla friendly.

Restores the T81/T82-authenticated post-week save into a fresh verified release
copy before DOS mounts it, boots the original, authenticates the week-1
management menu (Sevilla advertised), walks Return into the fixture preparation
and captures the machine savestate at that boundary. The savestate stays
private under .cache/T89 (git-ignored); the committed record pins its digest.
No emulator state is ever restored; nothing is keyed past PLAY GAME.
"""
import argparse
import hashlib
import json
import re
import subprocess
import sys
import time
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / 'runtime/driver'))
sys.path.insert(0, str(ROOT / 'runtime/emul'))
sys.path.insert(0, str(ROOT / 'tools/data'))

import driver
import sevilla_match
from halftime_replacement import release, write
from saved_roster import SAVE_FILE, SessionDriver, menu_projection

TOOL = 'runtime/driver/sevilla_entry.py'
DEPENDENCIES = [TOOL, 'runtime/emul/sevilla_match.py', 'runtime/driver/week_completion.py',
                'runtime/driver/halftime_replacement.py', 'runtime/driver/saved_roster.py',
                'runtime/driver/driver.py', 'runtime/driver/screens.py',
                'runtime/driver/savestate.py', 'runtime/driver/xkeys.py',
                'runtime/driver/dosbox-x-2024.03.01-default.map', 'tools/data/save.py',
                'tools/data/league.py', 'tools/data/campaign_seed.py']
ENTRY_SCHEMA = 'original-sevilla-entry/1'
ENTRY_SHA = sevilla_match.ENTRY_SHA  # the single pinned post-week identity
MENU_MARKERS = ('Next opponents', 'Sevilla', 'Friendly #2')
sha = lambda data: hashlib.sha256(data).hexdigest()
encoded = lambda value: json.dumps(value, sort_keys=True, separators=(',', ':')).encode()


def git(*args):
    return subprocess.check_output(['git', '-C', str(ROOT), *args])


def source_clean():
    watched = DEPENDENCIES + ['runtime/driver']
    return not git('status', '--porcelain', '--', *watched).decode().strip()


def producer():
    head = git('rev-parse', 'HEAD').decode().strip()
    return dict(producer=head, producer_files={p: sha((ROOT / p).read_bytes()) for p in DEPENDENCIES})


def validate_record(record):
    """The public contract of the entry record: identities, markers, digest pins."""
    if record['schema'] != ENTRY_SCHEMA or record['status'] != 'completed':
        raise ValueError('incomplete sevilla entry record')
    if record['release'] != release():
        raise ValueError('release identity differs')
    if record['dosbox_version'] != driver.WANT_DOSBOX:
        raise ValueError('dosbox version differs')
    names = git('ls-tree', '-r', '--name-only', record['producer']).decode().splitlines()
    if set(record['producer_files']) != set(n for n in names if n in DEPENDENCIES) or TOOL not in record['producer_files']:
        raise ValueError('producer dependency census differs')
    for name, digest in record['producer_files'].items():
        if sha(git('show', record['producer'] + ':' + name)) != digest:
            raise ValueError('producer file differs: ' + name)
    if sha(encoded(record['payload'])) != record['payload_sha256']:
        raise ValueError('payload digest differs')
    payload = record['payload']
    if payload['boot']['save_sha256'] != sevilla_match.ENTRY_SHA:
        raise ValueError('boot save is not the pinned post-week state')
    decoded = payload['decoded']
    if decoded['week_byte'] != 1 or decoded['following'] != dict(sevilla_match.WITNESSED_FOLLOWING):
        raise ValueError('decoded entry context differs')
    menu = payload['menu']
    for marker in MENU_MARKERS:
        if marker not in menu['text']:
            raise ValueError('management menu lacks %r' % marker)
    prep = payload['preparation']
    if 'PLAY GAME' not in prep['text'] or 'Sevilla' not in prep['text']:
        raise ValueError('preparation screen is not the Sevilla fixture preparation')
    for stage in (menu, prep):
        if not re.fullmatch('[0-9a-f]{64}', stage['screen_sha256']) \
                or not re.fullmatch('[0-9a-f]{64}', stage['savestate_sha256']):
            raise ValueError('observation identity differs')
        if sha(encoded(stage['state'])) != stage['state_sha256']:
            raise ValueError('state digest differs')
    private = payload['savestate']
    if not re.fullmatch('[0-9a-f]{64}', private['sha256']) \
            or not str(private['path']).startswith('.cache/T89/'):
        raise ValueError('private savestate identity differs')


def run(out, scratch, entry):
    """One authenticated session: restored post-week save -> week-1 menu -> Sevilla
    preparation -> private savestate. The record is written once, at the end."""
    if out.exists() or scratch.exists():
        raise ValueError('fresh output/scratch required')
    if not source_clean():
        raise ValueError('commit driver first')
    meta = producer()
    entry_bytes = sevilla_match.authenticate_entry(entry)
    decoded = sevilla_match.entry_structure(entry_bytes)
    record = dict(schema=ENTRY_SCHEMA, **meta, release=release(),
                  dosbox_version=driver.WANT_DOSBOX, status='aborted',
                  processes_exited=False, entry=dict(path=str(entry), sha256=sha(entry_bytes),
                                                     size=len(entry_bytes)),
                  payload=dict(decoded=dict(club=sevilla_match.MANAGED_CLUB, **decoded),
                               boot=None, menu=None, preparation=None, savestate=None),
                  error=None, elapsed_seconds=None)
    start = time.monotonic()
    progress = out.with_name(out.stem + '-progress.jsonl')
    d = SessionDriver(workdir=scratch, game_dir=scratch / 'game',
                      preload_saves={SAVE_FILE: entry_bytes})

    def observe(name, keys):
        for key in keys:
            d.keys(key)
        time.sleep(.25)
        _, st, data = d.read()
        sc = st.screen()
        text = sc.text()
        state = menu_projection(st)
        row = dict(name=name, keys=list(keys), text=text,
                   screen_sha256=sc.digest(), savestate_sha256=sha(data),
                   state_sha256=sha(encoded(state)), state=state)
        with progress.open('a') as f:
            f.write(json.dumps(dict(name=name, t=round(time.monotonic() - start, 1),
                                    state_sha256=row['state_sha256'])) + '\n')
        print(name, 'screen', row['screen_sha256'][:16], flush=True)
        return row, data

    try:
        d.launch()
        time.sleep(3)
        d.keys('y')
        time.sleep(3)
        d.wait_screen(lambda s: 'PLAY NEXT GAME' in s.text(), what='restored main')
        save_path = Path(d.game_dir) / SAVE_FILE
        if sha(save_path.read_bytes()) != sevilla_match.ENTRY_SHA:
            raise ValueError('the mounted save is not the pinned post-week state')
        record['payload']['boot'] = dict(save_sha256=sha(save_path.read_bytes()),
                                         keys=['y', 'Return'])
        menu, menu_blob = observe('menu-sevilla', [])  # observation only; no key
        record['payload']['menu'] = menu
        for marker in MENU_MARKERS:
            if marker not in menu['text']:
                raise ValueError('management menu lacks %r' % marker)
        d.keys('Return')
        d.wait_screen(lambda s: 'PLAY GAME' in s.text(), timeout=20, what='preparation')
        prep, prep_blob = observe('preparation-sevilla', [])
        record['payload']['preparation'] = prep
        if 'PLAY GAME' not in prep['text'] or 'Sevilla' not in prep['text']:
            raise ValueError('preparation screen is not the Sevilla fixture preparation')
        number = out.stem.split('-r')[-1]
        private = ROOT / '.cache' / 'T89' / 'states' / f'sevilla-preparation-{number}.sav'
        private.parent.mkdir(parents=True, exist_ok=True)
        private.write_bytes(prep_blob)
        record['payload']['savestate'] = dict(path=str(private.relative_to(ROOT)),
                                              sha256=sha(prep_blob), size=len(prep_blob),
                                              at='fixture preparation entry; nothing keyed past PLAY GAME')
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


def check(path):
    """Public re-validation of a committed record; needs no private save."""
    record = json.loads(Path(path).read_text())
    validate_record(record)
    print('entry record verified:', path)


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--out', type=Path)
    ap.add_argument('--scratch', type=Path)
    ap.add_argument('--entry', type=Path)
    ap.add_argument('--check', type=Path)
    args = ap.parse_args()
    if args.check:
        check(args.check)
    elif args.out and args.scratch and args.entry:
        run(args.out, args.scratch, args.entry)
    else:
        ap.error('--check, or --out --scratch --entry')


if __name__ == '__main__':
    main()
