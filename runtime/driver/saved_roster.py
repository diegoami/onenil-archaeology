#!/usr/bin/env python3
"""T80: bind the saved club records to the accepted in-match projection, then walk the
original route from the managed halftime replacement to a saved, reloaded roster.

    python3 runtime/driver/saved_roster.py --baseline runs/T80/save-projection-NEW.json
    python3 runtime/driver/saved_roster.py --check runs/T80/save-projection-r0001.json
    python3 runtime/driver/saved_roster.py --run runs/T80/session-NEW.json --scratch /tmp/onenil-T80-NEW
    python3 runtime/driver/saved_roster.py --check runs/T80/session-r0001.json runs/T80/session-r0002.json

The baseline mode decodes bounded fields of the owner's private One-Nil96/SAVE1.1-0
(never its bytes) through the accepted T65 block layout (tools/data/save.py) and
compares the managed club's twenty roster words with the authentic T74 halftime
projection. The session mode extends the established T74 procedure: genuine halftime
replacement (highlight-checked), full W029/W030 route (full time, CONTINUE, statistics,
cash flow, transfer news, management menu), F7 save, and a fresh-process reload; every
stage binds savestate/screen digests and the bounded projection, and the save-file
digest timeline decides when persistence reaches the file. Public records hold digests,
counts and decoded values only.
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
import save as save_layout  # the accepted decoder: BLOCKS, SIZE, decode
import driver
import screens
from halftime_replacement import capacity, projection, release, write

TOOL = 'runtime/driver/saved_roster.py'
DEPENDENCIES = [TOOL, 'tools/data/save.py', 'runtime/driver/halftime_replacement.py',
                'runtime/driver/driver.py', 'runtime/driver/screens.py', 'runtime/driver/savestate.py',
                'runtime/driver/xkeys.py', 'runtime/driver/dosbox-x-2024.03.01-default.map']
MANAGED_CLUB = 130
OUTGOING = 2582  # I Pearce
INCOMING = 2592  # T Gale
REFERENCE = 'runs/T74/session-r0005.json'
BASELINE = 'runs/T80/save-projection-r0001.json'
SOURCE = 'One-Nil96/SAVE1.1-0'
SAVE_FILE = 'SAVE1.1-0'
sha = lambda b: hashlib.sha256(b).hexdigest()
encoded = lambda v: json.dumps(v, sort_keys=True, separators=(',', ':')).encode()
# T74's selection stages, then the watched-match W029/W030 route to a saved, reloaded roster.
TRANSACTION_STAGES = ['halftime', 'bench', 'players', 'pearce', 'picked', 'cancelled', 'picked-again',
                      'gale', 'confirmed', 'bench-after', 'resumed']
STAGES = ['preparation'] + TRANSACTION_STAGES + ['fulltime', 'bench-ft', 'stats', 'cash',
                                                 'transfer', 'menu-after', 'saved', 'reloaded']


def git(*args):
    return subprocess.check_output(['git', '-C', str(ROOT), *args]).decode().strip()


def git_bytes(*args):
    return subprocess.check_output(['git', '-C', str(ROOT), *args])


def block_offsets():
    off, out = 0, {}
    for dest, size in save_layout.BLOCKS:
        out[dest] = (off, size)
        off += size
    return out


def decode_save(data):
    """Bounded decoded values from save bytes: header numbers, roster-relevant block
    digests, the case clubs' roster words and the case players' fields."""
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
    if not (slots['outgoing'] < 11 <= slots['incoming']):
        raise SystemExit('pre-exchange slots are not a first-team/bench pair')
    record = dict(
        schema='original-saved-roster-projection/1',
        producer=git('rev-parse', 'HEAD'),
        producer_files={p: sha((ROOT / p).read_bytes()) for p in (TOOL, 'tools/data/save.py')},
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
        if sha(git_bytes('show', record['producer'] + ':' + name)) != digest:
            raise ValueError('producer identity differs: ' + name)
    if record['reference']['path'] != REFERENCE:
        raise ValueError('reference differs')
    if record['source']['path'] != SOURCE:
        raise ValueError('source differs')
    if sha((ROOT / REFERENCE).read_bytes()) != record['reference']['sha256']:
        raise ValueError('reference digest differs')
    _, ref_record, half = reference_halftime()
    roster = half['clubs'][next(i for i, c in enumerate(half['clubs']) if c['id'] == MANAGED_CLUB)]['roster']
    if sha(json.dumps(roster, separators=(',', ':')).encode()) != record['comparison']['halftime_roster_sha256']:
        raise ValueError('halftime roster digest differs')
    if not record['comparison']['equal'] or record['save']['clubs'][str(MANAGED_CLUB)]['roster'] != roster:
        raise ValueError('save/projection equality differs')
    slots = record['comparison']['slots_zero_based']
    if roster[slots['outgoing']] != OUTGOING or roster[slots['incoming']] != INCOMING:
        raise ValueError('case players differ')
    return dict(club=MANAGED_CLUB, slots=slots)


def save_digest(game_dir, name=SAVE_FILE):
    """The current digest of a .1-0 save file in the scratch game folder (digest only)."""
    path = Path(game_dir) / name
    if not path.is_file():
        raise ValueError('missing save file %s' % path)
    data = path.read_bytes()
    return dict(name=name, sha256=sha(data), size=len(data))


class SessionDriver(driver.Driver):
    """T74's calibrated boot waits, plus save preloading for the fresh-process reload."""

    def __init__(self, *a, preload_saves=None, **kw):
        self.preload_saves = preload_saves or {}
        super().__init__(*a, **kw)

    def _start_xvfb(self):
        # The verified release copy is in place; place the named saves before DOS mounts the folder.
        for name, data in self.preload_saves.items():
            (Path(self.game_dir) / name).write_bytes(data)
        return super()._start_xvfb()

    def _wait_window(self, timeout):
        window = super()._wait_window(timeout)
        time.sleep(3)  # [confirmed:T42..T61 manual driver] first reads can arrive during BIOS init
        self.log('T80: waited 3 seconds after window creation before first savestate')
        return window


def source_clean():
    return not subprocess.check_output(
        ['git', '-C', str(ROOT), 'status', '--porcelain', '--', 'runtime/driver', 'tools/data']
    ).decode().strip()


def run(out, scratch):
    """One authenticated session: T74's genuine halftime replacement, then the W029/W030
    route to full time, the management week, F7, and a fresh-process reload."""
    if out.exists() or scratch.exists():
        raise ValueError('fresh output/scratch required')
    if not source_clean():
        raise ValueError('commit driver first')
    baseline_path = ROOT / BASELINE
    baseline = json.loads(baseline_path.read_text())
    stages, timeline, decoded_saves = [], [], {}
    record = dict(
        schema='original-saved-roster-session/1', producer=git('rev-parse', 'HEAD'),
        producer_files={p: sha((ROOT / p).read_bytes()) for p in DEPENDENCIES},
        release=release(), dosbox_version=driver.WANT_DOSBOX, status='aborted',
        processes_exited=False, baseline=dict(path=BASELINE, sha256=sha(baseline_path.read_bytes())),
        restart=None, payload=dict(start=None, stages=stages, save_timeline=timeline,
                                   decoded_saves=decoded_saves), error=None)
    start = time.monotonic()
    progress = out.with_name(out.stem + '-progress.jsonl')
    d = SessionDriver(workdir=scratch, game_dir=scratch / 'game')

    def note(row):
        # append-only progress sidecar; the session record itself is written once at the end
        with progress.open('a') as f:
            f.write(json.dumps(dict(name=row['name'], t=round(time.monotonic() - start, 1),
                                    state_sha256=row['state_sha256'])) + '\n')

    def file_digest(at):
        row = save_digest(d.game_dir)
        timeline.append(dict(at=at, **row))
        return row

    def observe(name, keys=(), selected=None, want=None):
        for key in keys:
            d.keys(key)
        time.sleep(.25)
        _, st, data = d.read()
        sc = st.screen()
        text = sc.text()
        high = [t for _, t in screens.highlighted(sc)]
        actual = next((i for i, n in [(OUTGOING, 'I Pearce'), (INCOMING, 'T Gale')]
                       if any(n in h for h in high)), None)
        if selected is not None and actual != selected:
            raise ValueError('highlight differs ' + name)
        if want is not None and want not in text:
            raise ValueError('screen %s lacks %r' % (name, want))
        state = projection(st)
        m = re.search(r'Remaining subs\s+(\d+)', text)
        row = dict(name=name, keys=list(keys), selected=actual,
                   put_here='PUT HERE' in text, remaining_display=int(m[1]) if m else None,
                   screen_sha256=sc.digest(), savestate_sha256=sha(data),
                   state_sha256=sha(encoded(state)), state=state)
        stages.append(row)
        note(row)
        print(name, 'elapsed', state['elapsed'],
              'roster[1]', state['clubs'][1]['roster'][1], flush=True)
        return text

    def select(identifier):
        keys = []
        for _ in range(22):
            d.keys('Down')
            keys.append('Down')
            time.sleep(.15)
            sc = d.screen()
            name = {OUTGOING: 'I Pearce', INCOMING: 'T Gale'}[identifier]
            if any(name in h for _, h in screens.highlighted(sc)):
                return keys
        raise ValueError('requested highlighted player not reached')

    try:
        d.launch()
        time.sleep(3)
        d.keys('y')
        time.sleep(3)
        d.wait_screen(lambda s: 'PLAY NEXT GAME' in s.text(), what='supplied main')
        boot_file = file_digest('boot')
        if boot_file['sha256'] != baseline['source']['sha256']:
            raise ValueError('boot save file differs from the authenticated baseline')
        record['payload']['start'] = dict(savestate_sha256=sha(d.last_blob),
                                          screen_sha256=d.last[1].screen().digest(),
                                          save_file=boot_file, keys=['y', 'Return'])
        d.keys('Return')
        d.wait_screen(lambda s: 'PLAY GAME' in s.text(), what='preparation')
        observe('preparation')
        d.keys('Return')  # PLAY GAME starts the match (T74's calibrated preparation route)
        deadline = time.monotonic() + 900
        while time.monotonic() < deadline:
            time.sleep(2)  # avoid continuously stopping play for compressed savestate reads
            text = d.screen().text()
            if 'HALF TIME' in text and 'press any key' in text.lower():
                break
        else:
            raise RuntimeError('genuine halftime not reached within 900 seconds')
        observe('halftime')
        observe('bench', ['space'])
        observe('players', ['space'])
        keys = select(OUTGOING)
        observe('pearce', selected=OUTGOING)
        stages[-1]['keys'] = keys
        observe('picked', ['Return'])
        observe('cancelled', ['Escape'])
        observe('picked-again', ['Return'])
        keys = select(INCOMING)
        observe('gale', selected=INCOMING)
        stages[-1]['keys'] = keys
        observe('confirmed', ['Return'])
        observe('bench-after', ['Escape'])
        d.keys('Return')
        d.wait_screen(lambda s: projection(d.last[1])['elapsed'] > stages[-1]['state']['elapsed'],
                      timeout=30, what='second half progression')
        observe('resumed')
        validate_transaction(stages[1:stages.index(next(s for s in stages if s['name'] == 'resumed')) + 1])
        deadline = time.monotonic() + 1200
        while time.monotonic() < deadline:
            time.sleep(2)
            if 'FULL TIME' in d.screen().text():
                break
        else:
            raise RuntimeError('full time not reached within 1200 seconds')
        observe('fulltime', want='FULL TIME')
        observe('bench-ft', ['Return'])
        d.keys('Return')          # CONTINUE returns to the fulltime pitch
        time.sleep(1)
        observe('stats', ['n'], want='MAN OF THE MATCH')
        observe('cash', ['space'], want='CASH FLOW')
        observe('transfer', ['space'], want='TRANSFER NEWS')
        observe('menu-after', ['space'], want='PLAY NEXT GAME')
        file_digest('menu-after')
        d.keys('F7')
        time.sleep(2.5)           # W005: the save writes during a one-second observation delay
        saved_file = file_digest('saved')
        if saved_file['sha256'] == boot_file['sha256']:
            raise ValueError('F7 left the save file unchanged')
        decoded_saves['saved'] = decode_save((Path(d.game_dir) / SAVE_FILE).read_bytes())
        observe('saved')
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


def validate_transaction(stages):
    """The T74 contract (cancellation/selection/exchange/capacity/clock) for this session."""
    if [s['name'] for s in stages] != TRANSACTION_STAGES:
        raise ValueError('stage census/order differs')
    rows = {s['name']: s for s in stages}
    half = rows['halftime']['state']
    if half['elapsed'] < 45 or half['remaining'] <= 0 or half['control'] != 1 \
            or {c['id'] for c in half['clubs']} != {17, MANAGED_CLUB}:
        raise ValueError('genuine managed interval state differs')
    for row in stages:
        if sha(encoded(row['state'])) != row['state_sha256']:
            raise ValueError('state digest differs')
        if not all(re.fullmatch('[0-9a-f]{64}', row[k]) for k in ('screen_sha256', 'savestate_sha256')):
            raise ValueError('observation identity differs')
    if rows['pearce']['selected'] != OUTGOING or rows['gale']['selected'] != INCOMING:
        raise ValueError('selected player differs')
    for name in ('picked', 'picked-again', 'gale'):
        if not rows[name]['put_here']:
            raise ValueError('replacement pick mode missing')
    if rows['cancelled']['put_here'] or rows['confirmed']['put_here']:
        raise ValueError('replacement mode not closed')
    if rows['pearce']['state'] != rows['cancelled']['state']:
        raise ValueError('cancellation changed gameplay')
    if rows['pearce']['state'] != rows['gale']['state']:
        raise ValueError('selection changed gameplay')
    before = rows['gale']['state']
    after = rows['confirmed']['state']
    if [c['id'] for c in before['clubs']] != [c['id'] for c in after['clubs']]:
        raise ValueError('club identity changed')
    side = next(i for i, c in enumerate(before['clubs']) if c['id'] == MANAGED_CLUB)
    roster = before['clubs'][side]['roster']
    want = list(roster)
    a, b = roster.index(OUTGOING), roster.index(INCOMING)
    if not (a < 11 <= b):
        raise ValueError('not a first-team/bench replacement')
    want[a], want[b] = want[b], want[a]
    if after['clubs'][side]['roster'] != want or after['clubs'][1 - side] != before['clubs'][1 - side]:
        raise ValueError('roster exchange differs')
    if capacity(after, side) != capacity(before, side) - 1:
        raise ValueError('capacity did not decrease once')
    for name in ('seed', 'elapsed', 'remaining', 'stoppage', 'live_goals'):
        if before[name] != after[name]:
            raise ValueError('replacement changed clock/score/seed')
    if rows['bench']['remaining_display'] != capacity(before, side) \
            or rows['bench-after']['remaining_display'] != capacity(after, side):
        raise ValueError('display capacity alias differs')
    if rows['resumed']['state']['elapsed'] <= after['elapsed']:
        raise ValueError('second half did not resume')
    fixed = {'bench': ['space'], 'players': ['space'], 'picked': ['Return'], 'cancelled': ['Escape'],
             'picked-again': ['Return'], 'confirmed': ['Return'], 'bench-after': ['Escape'],
             'resumed': ['Return']}
    for name, keys in fixed.items():
        if rows[name]['keys'] != keys:
            raise ValueError('input sequence differs')
    for name in ('pearce', 'gale'):
        if not rows[name]['keys'] or any(k != 'Down' for k in rows[name]['keys']):
            raise ValueError('selection input differs')
    return dict(club=MANAGED_CLUB, outgoing=OUTGOING, incoming=INCOMING, slots=[a, b], capacity_delta=-1)


def validate_session(payload, baseline):
    """The T80 contract: the exchange persists through full time, the week route, F7 and reload."""
    stages = payload['stages']
    if [s['name'] for s in stages] != STAGES:
        raise ValueError('stage census/order differs')
    rows = {s['name']: s for s in stages}
    resumed_index = next(i for i, s in enumerate(stages) if s['name'] == 'resumed')
    contract = validate_transaction(stages[1:resumed_index + 1])
    persisted = next(c for c in rows['confirmed']['state']['clubs']
                     if c['id'] == MANAGED_CLUB)['roster']
    slots = contract['slots']
    if persisted[slots[0]] != INCOMING or persisted[slots[1]] != OUTGOING:
        raise ValueError('persisted arrangement differs')
    timeline = {t['at']: t for t in payload['save_timeline']}
    for name in ('boot', 'menu-after', 'saved'):
        if name not in timeline:
            raise ValueError('save timeline missing ' + name)
    if timeline['boot']['sha256'] != baseline['source']['sha256']:
        raise ValueError('boot save differs from the baseline')
    if timeline['menu-after']['sha256'] == timeline['boot']['sha256']:
        raise ValueError('the management week left the save file unchanged')
    if timeline['saved']['sha256'] == timeline['menu-after']['sha256']:
        raise ValueError('F7 left the save file unchanged')
    saved = payload['decoded_saves']['saved']
    if saved['clubs'][str(MANAGED_CLUB)]['roster'] != persisted:
        raise ValueError('saved roster differs from the post-exchange roster')
    # full time, the management week, F7 and the reloaded menu keep the persisted arrangement
    for name in ('fulltime', 'bench-ft', 'menu-after', 'saved', 'reloaded'):
        club = next(c for c in rows[name]['state']['clubs'] if c['id'] == MANAGED_CLUB)
        if club['roster'] != persisted:
            raise ValueError('%s lost the persisted arrangement' % name)
    if rows['fulltime']['state']['elapsed'] <= rows['resumed']['state']['elapsed']:
        raise ValueError('second half did not advance to full time')
    if rows['menu-after']['screen_sha256'] == rows['preparation']['screen_sha256']:
        raise ValueError('management return did not advance the menu')
    reload_players = rows['reloaded']['state']['players']
    saved_players = saved['clubs'][str(MANAGED_CLUB)]['players']
    for identifier, fields in saved_players.items():
        live = next((p for p in reload_players if p['id'] == int(identifier)), None)
        if live is None or {k: live[k] for k in fields} != fields:
            raise ValueError('reloaded player fields differ: ' + identifier)
    if rows['reloaded']['state']['seed'] != saved['seed_word']:
        raise ValueError('reloaded seed differs from the saved seed word')
    fixed = {'preparation': [], 'fulltime': [], 'bench-ft': ['Return'], 'stats': ['n'],
             'cash': ['space'], 'transfer': ['space'], 'menu-after': ['space'], 'saved': [],
             'reloaded': []}
    for name, keys in fixed.items():
        if rows[name]['keys'] != keys:
            raise ValueError('%s input differs' % name)
    return dict(persisted_slots=slots, saved_sha256=timeline['saved']['sha256'])


def validate_record(record):
    if record['schema'] != 'original-saved-roster-session/1' or record['status'] != 'completed' \
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
    validate_baseline(baseline)
    return validate_session(record['payload'], baseline)


def check(paths):
    records = [json.loads(p.read_text()) for p in paths]
    contracts = [validate_record(r) for r in records]
    if len(records) < 2 or len({r['payload']['start']['savestate_sha256'] for r in records}) < 2:
        raise ValueError('independent fresh sessions required')
    if any(c != contracts[0] for c in contracts[1:]):
        raise ValueError('repeat contract differs')
    print('PASS saved-roster sessions:', len(records), 'independent sessions', contracts[0])


def main(argv):
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('--baseline', type=Path)
    p.add_argument('--check', type=Path, nargs='+')
    p.add_argument('--run', type=Path)
    p.add_argument('--scratch', type=Path)
    a = p.parse_args(argv)
    if a.check:
        records = [json.loads(p.read_text()) for p in a.check]
        if records[0]['schema'] == 'original-saved-roster-projection/1':
            print('PASS saved-roster baseline:', validate_baseline(records[0]))
        else:
            check(a.check)
    elif a.run and a.scratch:
        run(a.run, a.scratch)
    elif a.baseline:
        build_baseline(a.baseline)
    else:
        p.error('choose --run OUTPUT --scratch NEW_PATH, --check RECORDS or --baseline OUTPUT')


if __name__ == '__main__':
    main(sys.argv[1:])
