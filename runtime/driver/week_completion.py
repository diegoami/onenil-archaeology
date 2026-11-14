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
STAGES = ['preparation', 'halftime', 'bench', 'resumed', 'fulltime',
          'bench-ft', 'stats', 'cash', 'transfer', 'menu-after', 'saved', 'reloaded']
# Full screen texts are evidence only on the week-transaction screens.
TEXT_STAGES = {'halftime', 'cash', 'transfer', 'menu-after'}


def decode_save_week(data):
    """The T80 bounded decode plus the management/finance fields: the manager
    and managed club bytes (DS:DCBA pair) and the signed cash word at
    DCC4+(manager-1)*94+82 (campaign-seed.md)."""
    d = decode_save(data)
    off = block_offsets()
    # [confirmed static: campaign-seed.md] The manager number lives at
    # game[D7D2]+4, the managed club at DS:DCBA[manager-1], and the club's
    # signed cash word at DCC4+(manager-1)*94+82.
    manager = data[off['[DS:D7D2]'][0] + 4]
    club = data[off['DS:DCBA'][0] + manager - 1]
    cash = struct.unpack_from('<i', data, off['[DS:DCC4]'][0] + (manager - 1) * 94 + 82)[0]
    d['manager'] = manager
    d['club_bytes'] = club
    d['cash'] = cash
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
        # [confirmed:T74 route] PLAY GAME on the halftime bench resumes the match.
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


def decode_fixture_triples(data, club, weeks=4):
    """[confirmed static: campaign-seed.md] The club's fixture triples at
    D7CA+club*174+(week+1)*3-177, competition/opponent/flags, in block order."""
    base = block_offsets()['[DS:D7CA]'][0]
    out = []
    for week in range(weeks):
        at = base + club * 174 + (week + 1) * 3 - 177
        out.append(dict(week=week, competition=data[at], opponent=data[at + 1], flags=data[at + 2]))
    return out


def decode_week_byte(data):
    """[confirmed: T82 records/T82/next-fixture-r0001.json] The week counter byte
    at game[D7D2]+0: 0 before the first managed week, 1 after it completes."""
    return data[block_offsets()['[DS:D7D2]'][0]]


WITNESSED_FOLLOWING = dict(week=1, competition=1, opponent=176, flags=0)


def fixtures_record(save_pre_path, save_post_path, session_path, out):
    """Decode the next-fixture lookup around the played friendly from the two
    private saves, authenticated against the committed T80/T81 evidence."""
    session_path = Path(session_path).resolve()
    save_pre_path = Path(save_pre_path).resolve()
    save_post_path = Path(save_post_path).resolve()
    session_raw = session_path.read_bytes()
    session = json.loads(session_raw)
    pre = save_pre_path.read_bytes()
    post = save_post_path.read_bytes()
    baseline_path = ROOT / BASELINE
    baseline = json.loads(baseline_path.read_text())
    saved_digest = {t['at']: t['sha256'] for t in session['payload']['save_timeline']}['saved']
    if sha(Path(save_post_path).read_bytes()) != saved_digest:
        raise ValueError('the post-week save differs from the committed session timeline')
    if sha(pre) != baseline['source']['sha256']:
        raise ValueError('the pre-match save differs from the pinned baseline')
    menu = next(s for s in session['payload']['stages'] if s['name'] == 'menu-after')['text']
    fixtures_pre = decode_fixture_triples(pre, MANAGED_CLUB)
    fixtures_post = decode_fixture_triples(post, MANAGED_CLUB)
    played = fixtures_pre[0]
    if (played['competition'], played['opponent']) != (1, 17) or played['flags'] != 1:
        raise ValueError('the played friendly triple differs from the witnessed admission')
    following = fixtures_post[1]
    if following != WITNESSED_FOLLOWING:
        raise ValueError('the following fixture differs from the witnessed triple')
    reciprocal = decode_fixture_triples(pre, 17)[0]
    if (reciprocal['competition'], reciprocal['opponent']) != (1, MANAGED_CLUB):
        raise ValueError('the played friendly reciprocal row differs')
    if decode_week_byte(pre) != 0 or decode_week_byte(post) != 1:
        raise ValueError('the week counter did not advance exactly once')
    marked = decode_fixture_triples(post, MANAGED_CLUB)[0]
    if marked['flags'] & 64 != 64 or decode_fixture_triples(post, 17)[0]['flags'] & 64 != 64:
        raise ValueError('the played fixture lost its played marker')
    for marker in ('Next opponents', 'Sevilla', 'Friendly #2'):
        if marker not in menu:
            raise ValueError('the management menu lacks %r' % marker)
    record = dict(
        schema='original-next-fixture/1', producer=git('rev-parse', 'HEAD'),
        producer_files={p: sha((ROOT / p).read_bytes()) for p in DEPENDENCIES},
        session=dict(path=str(session_path.relative_to(ROOT)), sha256=sha(session_path.read_bytes())),
        sources=dict(pre=dict(path=SOURCE, sha256=sha(pre), size=len(pre)),
                     post=dict(origin="the T81 session r0007 scratch game save (host-local)",
                               sha256=sha(post), size=len(post))),
        decoded=dict(manager=session['payload']['decoded_saves']['saved']['manager'],
                     club=MANAGED_CLUB,
                     cash_pre=session['payload']['decoded_saves']['boot']['cash'],
                     cash_post=session['payload']['decoded_saves']['saved']['cash'],
                     week_byte_pre=decode_week_byte(pre), week_byte_post=decode_week_byte(post),
                     fixtures_pre=fixtures_pre, fixtures_post=fixtures_post,
                     reciprocal_played=reciprocal),
        cross_check=dict(menu_markers=['Next opponents', 'Sevilla', 'Friendly #2'],
                         following=dict(WITNESSED_FOLLOWING),
                         note='the original menu advertises the following fixture (Sevilla, '
                              'Friendly #2) after the week; W030 describes it as away'),
        interpretation='the native B5 week advance sets the following fixture to the '
                       'witnessed triple and advances the week byte exactly once; one '
                       'friendly week, no scheduler claim',
    )
    out = Path(out)
    if out.exists():
        raise ValueError('run records are immutable: %s exists' % out)
    out.parent.mkdir(parents=True, exist_ok=True)
    with out.open('x') as f:
        json.dump(record, f, indent=2)
        f.write('\n')
    print('wrote', out, 'following fixture', following)


def validate_fixtures(record):
    if record['schema'] != 'original-next-fixture/1':
        raise ValueError('schema differs')
    for name, digest in record['producer_files'].items():
        if sha(git_bytes('show', record['producer'] + ':' + name)) != digest:
            raise ValueError('producer identity differs: ' + name)
    session_path = ROOT / record['session']['path']
    if sha(session_path.read_bytes()) != record['session']['sha256']:
        raise ValueError('session record differs')
    session = json.loads(session_path.read_text())
    saved_digest = {t['at']: t['sha256'] for t in session['payload']['save_timeline']}['saved']
    if record['sources']['post']['sha256'] != saved_digest:
        raise ValueError('post-week save digest differs from the session timeline')
    if record['sources']['pre']['sha256'] != json.loads((ROOT / BASELINE).read_text())['source']['sha256']:
        raise ValueError('pre-match save digest differs from the baseline')
    if record['decoded']['week_byte_pre'] != 0 or record['decoded']['week_byte_post'] != 1:
        raise ValueError('week bookkeeping differs')
    if record['decoded']['fixtures_post'][1] != record['cross_check']['following']:
        raise ValueError('the following fixture differs from the witnessed triple')
    if record['decoded']['fixtures_pre'][0]['opponent'] != 17:
        raise ValueError('the played fixture differs')
    if record['decoded']['cash_post'] == record['decoded']['cash_pre']:
        raise ValueError('the recorded week cash did not move')
    menu = next(s for s in session['payload']['stages'] if s['name'] == 'menu-after')['text']
    for marker in record['cross_check']['menu_markers']:
        if marker not in menu:
            raise ValueError('the committed menu text lacks %r' % marker)
    return dict(following=record['cross_check']['following'])


def roster_conditions(data):
    """The managed club's twenty roster players' bounded fields, decoded from a
    save image: id, condition (p15+8), status (+11), instructions (+10),
    current/club position (p8+6/+7). Zero slots are skipped."""
    off = block_offsets()
    p8, _ = off['[DS:D7BA]']
    p15, _ = off['[DS:D7BE]']
    clubs_at, _ = off['[DS:D7C2]']
    roster = list(struct.unpack_from('<20H', data, clubs_at + (MANAGED_CLUB - 1) * 62))
    out = {}
    for slot, pid in enumerate(roster):
        if pid == 0:
            continue
        out[str(pid)] = dict(slot=slot,
            current_position=data[p8_at := p8 + 8 * pid + 6],
            club_position=data[p8 + 8 * pid + 7],
            condition=data[p15 + 15 * pid + 8],
            instructions=data[p15 + 15 * pid + 10],
            status=data[p15 + 15 * pid + 11])
    return out


def conditions_record(out, pre_path, post_path, session_path):
    """The full managed-roster condition fields before and after the completed
    friendly week, from the digest-chained private saves (no bytes in git)."""
    for name in DEPENDENCIES:
        if (ROOT / name).read_bytes() != git_bytes('show', 'HEAD:' + name):
            raise ValueError('commit condition producer first: ' + name)
    pre_path = Path(pre_path).resolve()
    post_path = Path(post_path).resolve()
    session_path = Path(session_path).resolve()
    session = json.loads(session_path.read_text())
    baseline_path = ROOT / BASELINE
    baseline = json.loads(baseline_path.read_text())
    pre = Path(pre_path).read_bytes()
    post = Path(post_path).read_bytes()
    saved_digest = {t['at']: t['sha256'] for t in session['payload']['save_timeline']}['saved']
    if sha(post) != saved_digest:
        raise ValueError('the post-week save differs from the committed session timeline')
    if sha(pre) != baseline['source']['sha256']:
        raise ValueError('the pre-match save differs from the pinned baseline')
    menu = next(s for s in session['payload']['stages'] if s['name'] == 'menu-after')['text']
    conditions_pre = roster_conditions(pre)
    conditions_post = roster_conditions(post)
    if set(conditions_pre) != set(conditions_post):
        raise ValueError('the roster membership changed during the week')
    moved = {pid: (conditions_pre[pid]['condition'], conditions_post[pid]['condition'])
             for pid in conditions_pre
             if conditions_pre[pid]['condition'] != conditions_post[pid]['condition']}
    stable_positions = all(conditions_pre[pid]['current_position'] == conditions_post[pid]['current_position']
                           and conditions_pre[pid]['club_position'] == conditions_post[pid]['club_position']
                           and conditions_pre[pid]['instructions'] == conditions_post[pid]['instructions']
                           for pid in conditions_pre)
    record = dict(
        schema='original-week-conditions/1', producer=git('rev-parse', 'HEAD'),
        producer_files={p: sha((ROOT / p).read_bytes()) for p in DEPENDENCIES},
        session=dict(path=str(session_path.relative_to(ROOT)), sha256=sha(session_path.read_bytes())),
        sources=dict(pre=dict(path=SOURCE, sha256=sha(pre), size=len(pre)),
                     post=dict(origin='the T81 session r0007 scratch game save (host-local)',
                               sha256=sha(post), size=len(post))),
        decoded=dict(manager=decode_save_week(pre)['manager'], club=MANAGED_CLUB,
                     cash_pre=decode_save_week(pre)['cash'], cash_post=decode_save_week(post)['cash'],
                     roster=len(conditions_pre), conditions_pre=conditions_pre,
                     conditions_post=conditions_post, condition_moved=moved,
                     positions_and_instructions_stable=stable_positions),
        cross_check=dict(note='the case values reproduce the committed T81 decoded refreshes',
                         gale_condition=conditions_post.get('2592', {}).get('condition'),
                         pearce_condition=conditions_post.get('2582', {}).get('condition')),
        interpretation='the week refreshes the roster players condition fields; positions, '
                       'instructions and the roster arrangement stay stable; one friendly week',
    )
    if out.exists():
        raise ValueError('run records are immutable: %s exists' % out)
    out.parent.mkdir(parents=True, exist_ok=True)
    with out.open('x') as f:
        json.dump(record, f, indent=2)
        f.write('\n')
    print('wrote', out, 'roster', len(conditions_pre), 'condition moved:', moved)


CONDITIONS_PATH = 'records/T83/conditions-r0001.json'
CONDITIONS_COMMIT = '61118f37f2effd37d3abb84660d7e8e20b6da40e'


def validate_conditions(record, pre=None, post=None):
    """Authenticate the retained decode, without modelling the refresh routine.

    Public validation binds the complete numeric projection to its immutable
    capture commit. Two players can additionally be checked against the T81
    observer; the other sixteen have no public raw save to re-decode. Supplying
    both private saves independently re-decodes every recorded roster field.
    """
    retained = json.loads(git_bytes('show', CONDITIONS_COMMIT + ':' + CONDITIONS_PATH))
    for key in ('schema', 'session', 'sources', 'decoded', 'cross_check', 'interpretation'):
        if record[key] != retained[key]:
            raise ValueError('condition capture differs from its immutable committed receipt: ' + key)
    if set(record['producer_files']) != set(DEPENDENCIES):
        raise ValueError('condition producer census differs')
    for name, digest in record['producer_files'].items():
        if sha(git_bytes('show', record['producer'] + ':' + name)) != digest:
            raise ValueError('condition producer identity differs: ' + name)
    session_path = ROOT / record['session']['path']
    if sha(session_path.read_bytes()) != record['session']['sha256']:
        raise ValueError('condition session digest differs')
    session = json.loads(session_path.read_text())
    validate_record(session)
    timeline = {t['at']: t for t in session['payload']['save_timeline']}
    baseline = json.loads((ROOT / BASELINE).read_text())
    for side, witness in (('pre', baseline['source']), ('post', timeline['saved'])):
        if any(record['sources'][side][k] != witness[k] for k in ('sha256', 'size')):
            raise ValueError('condition save identity differs: ' + side)
    decoded = record['decoded']
    for side, stage in (('pre', 'boot'), ('post', 'saved')):
        source = session['payload']['decoded_saves'][stage]
        rows = decoded['conditions_' + side]
        roster = source['clubs'][str(decoded['club'])]['roster']
        if len(rows) != decoded['roster'] or len(rows) != sum(pid != 0 for pid in roster):
            raise ValueError('condition roster census differs')
        if {row['slot']: int(pid) for pid, row in rows.items()} != {
                slot: pid for slot, pid in enumerate(roster) if pid}:
            raise ValueError('condition roster differs')
        if decoded['cash_' + side] != source['cash'] or decoded['manager'] != source['manager']:
            raise ValueError('condition campaign context differs')
        for pid, fields in source['clubs'][str(decoded['club'])]['players'].items():
            if any(rows[pid][key] != value for key, value in fields.items()):
                raise ValueError('condition case differs from T81: ' + pid)
    if (pre is None) != (post is None):
        raise ValueError('both private saves are required')
    if pre is not None:
        for side, data in (('pre', pre), ('post', post)):
            source = record['sources'][side]
            if sha(data) != source['sha256'] or len(data) != source['size']:
                raise ValueError('private condition save digest differs: ' + side)
            if roster_conditions(data) != decoded['conditions_' + side]:
                raise ValueError('private condition decode differs: ' + side)
    return dict(roster=decoded['roster'], changed=len(decoded['condition_moved']),
                gale=decoded['conditions_post']['2592']['condition'],
                pearce=decoded['conditions_post']['2582']['condition'])


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
    # No substitution: from the interval onward the roster and the substitution
    # capacity are unchanged (the pre-match arrangement differs and is not claimed).
    interval_capacity = None
    for name in ('halftime', 'bench', 'resumed', 'fulltime'):
        st = rows[name]['state']
        if managed_roster(name) != boot_roster:
            raise ValueError('%s changed the roster without a replacement' % name)
        cap = capacity(st, managed_side(st))
        if interval_capacity is None:
            interval_capacity = cap
        elif cap != interval_capacity:
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
    if rows['menu-after'].get('text') and format(saved['cash'], ',d') not in rows['menu-after']['text']:
        raise ValueError('the management menu does not display the saved club funds')
    fixed = {'preparation': [], 'halftime': [], 'bench': ['space'],
             'resumed': [], 'fulltime': [], 'bench-ft': ['Return'], 'stats': ['n'],
             'cash': ['space'], 'transfer': ['space'], 'menu-after': ['space'], 'saved': [],
             'reloaded': []}
    for name, keys in fixed.items():
        if rows[name]['keys'] != keys:
            raise ValueError('%s input differs' % name)
    # Fixture-dependent values (cash amount, score, news rows) stay per session;
    # only the structural contract is compared across independent sessions.
    return dict(roster_slots=20, cash_moved=saved['cash'] != boot_decoded['cash'])


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
    p.add_argument('--fixtures', type=Path)
    p.add_argument('--conditions', type=Path)
    p.add_argument('--check-conditions', type=Path)
    p.add_argument('--save-pre', type=Path)
    p.add_argument('--save-post', type=Path)
    p.add_argument('--session', type=Path)
    a = p.parse_args(argv)
    if a.check:
        check(a.check)
    elif a.run and a.scratch:
        run(a.run, a.scratch)
    elif a.check_conditions:
        pre = a.save_pre.read_bytes() if a.save_pre else None
        post = a.save_post.read_bytes() if a.save_post else None
        print('PASS week conditions:', validate_conditions(
            json.loads(a.check_conditions.read_text()), pre, post))
    elif a.conditions and a.save_pre and a.save_post and a.session:
        conditions_record(a.conditions, a.save_pre, a.save_post, a.session)
    elif a.fixtures and a.save_pre and a.save_post and a.session:
        fixtures_record(a.save_pre, a.save_post, a.session, a.fixtures)
        print('PASS next-fixture record:', validate_fixtures(json.loads(a.fixtures.read_text())))
    else:
        p.error('choose --run OUTPUT --scratch NEW_PATH, --check RECORDS or --fixtures OUT --save-pre PRE --save-post POST --session RECORD')


if __name__ == '__main__':
    main(sys.argv[1:])
