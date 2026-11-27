#!/usr/bin/env python3
"""T124: the league fixture's original watched match,chunked decoded reference.

The unforced T100 league run is the quick path (T123:7 actions,2-0,20734 draws).
This observer forces the original watch configuration at match entry with the
T39/T40 `0AB9:E24C`/`config+F2` intervention and records the actual watched
league match from the T100 preparation state to the first `0AB9:E1F2` return.
It is reference evidence only,never a native runtime backend.

    .cache/venv/bin/python runtime/emul/league_watched_complete.py --run
    .cache/venv/bin/python runtime/emul/league_watched_complete.py --check
"""
import argparse
import json
import platform
import subprocess
from pathlib import Path

import league_week
import watched_actions as prefix
import watched_complete as full

match = prefix.match
ROOT = prefix.ROOT
RUNS = ROOT / 'runs/T124'
INDEX = ROOT / 'traces/T124/index.json'
CHUNK_TICKS = 64
STATE_SHA = '3abfd6b00f8024900b93a20d1ff1eec60cfd2d570e927a00eca495d7f7b1d1c8'
STATE_PATH = '.cache/T100/states/league-preparation-0001.sav'
T100_RECEIPT = ROOT / 'runs/T100/preparation-r0001.json'
T117_PARITY = ROOT / 'runs/T117/parity-r0001.json'
T117_TRACE = ROOT / 'traces/T117/3abfd6b00f802490-week-r0001.jsonl'
T102_WEEK = ROOT / 'runs/T102/week-r0001.json'
FIRST_SEED = 18521
QUICK_ACTIONS = 7
QUICK_DRAWS = 20734

sha = full.sha
encoded = full.encoded
write = full.write
validate_chunk = full.validate_chunk
state_check = full.state_check
validate_finish = full.validate_finish
state = full.state


def reference():
    """The T100/T117/T102 binding this stream joins."""
    receipt = json.loads(T100_RECEIPT.read_text())
    if receipt['savestate']['sha256'] != STATE_SHA or receipt['savestate']['path'] != STATE_PATH:
        raise ValueError('the T100 preparation savestate binding differs')
    state_file = ROOT / STATE_PATH
    if not state_file.exists() or sha(state_file.read_bytes()) != STATE_SHA:
        raise ValueError('the league preparation savestate is missing or differs')
    parity = json.loads(T117_PARITY.read_text())
    if parity['trace']['state_sha256'] != STATE_SHA:
        raise ValueError('the T117 parity state binding differs')
    if parity['trace']['draws'] != QUICK_DRAWS or parity['trace']['screens'] != 9:
        raise ValueError('the T117 quick-week parity differs')
    if sha(T117_TRACE.read_bytes()) != parity['trace']['sha256']:
        raise ValueError('the T117 trace digest differs')
    week = json.loads(T102_WEEK.read_text())
    if week['score']['home_goals'] != 2 or week['score']['away_goals'] != 0:
        raise ValueError('the T102 quick witness differs')
    return {'t100_receipt': str(T100_RECEIPT.relative_to(ROOT)),
            't117_parity': str(T117_PARITY.relative_to(ROOT)),
            't117_trace': str(T117_TRACE.relative_to(ROOT)),
            't102_week': str(T102_WEEK.relative_to(ROOT)),
            'state_sha256': STATE_SHA}


def validate_league_start(first):
    """The first watched league tick, not the quick week or the friendly."""
    state_check(first)
    if first['quick'] != 0:
        raise ValueError('the league stream is not watched')
    if first['seed'] != FIRST_SEED:
        raise ValueError('the watched league seed differs from T117/T123')
    if first['scores'] != [0, 0] or first['elapsed'] != 0:
        raise ValueError('the watched league does not start 0-0 at minute 0')
    if first['remaining'] != 91:
        raise ValueError('the watched league clock differs from T117')


def finish_count(actions, ticks, draws):
    if len(actions) <= QUICK_ACTIONS or draws <= QUICK_DRAWS:
        raise ValueError('the stream is the quick path, not a watched league match')
    if len(ticks) < 3000:
        raise ValueError('the watched league tick census is too small')


def check():
    binding = reference()
    index = json.loads(INDEX.read_text())
    if index.get('schema') != 'complete-original-watched/1':
        raise ValueError('the T124 manifest schema differs')
    start_path = ROOT / index['start']['path']
    if sha(start_path.read_bytes()) != index['start']['sha256']:
        raise ValueError('stream start digest differs')
    start = json.loads(start_path.read_text())
    if start['source'] != binding or start['state_sha256'] != STATE_SHA:
        raise ValueError('stream source identity differs')
    cursor = None
    draws, actions, ticks = [], [], []
    for item in index['chunks']:
        path = ROOT / item['path']
        raw = path.read_bytes()
        if sha(raw) != item['sha256']:
            raise ValueError('chunk digest differs')
        chunk = json.loads(raw)
        if sha(encoded(chunk['payload'])) != chunk['payload_sha256']:
            raise ValueError('chunk payload digest differs')
        cursor = validate_chunk(chunk['payload'], cursor)
        draws.extend(chunk['payload']['draws'])
        actions.extend(chunk['payload']['actions'])
        ticks.extend(chunk['payload']['ticks'])
    if not ticks or not actions:
        raise ValueError('no watched league ticks or actions')
    validate_league_start(ticks[0]['before'])
    finish_count(actions, ticks, len(draws))
    finish_path = ROOT / index['finish']['path']
    if sha(finish_path.read_bytes()) != index['finish']['sha256']:
        raise ValueError('finish digest differs')
    finish = json.loads(finish_path.read_text())
    if finish.get('intervention') != {'site': '0AB9:E24C', 'field': 'config+F2', 'before': 0, 'after': 1}:
        raise ValueError('watch intervention differs')
    if finish['status'] != 'completed' or finish['boundary'] != match.MATCH_RETURN:
        raise ValueError('original match return not completed')
    if (finish['ticks'], finish['draws'], finish['actions']) != (cursor['tick'] - 1, cursor['draw'], cursor['action']):
        raise ValueError('final cursors differ')
    validate_finish(finish['final'], actions)
    print(f'Complete original watched league match: {finish["ticks"]} ticks/'
          f'{finish["draws"]} draws/{finish["actions"]} actions, score '
          f'{finish["final"]["scores"]}, elapsed {finish["final"]["elapsed"]}, '
          f'return {finish["boundary"]}.')
    return index


def run(publish=False, max_ticks=10000, max_draws=1000000):
    if INDEX.exists():
        check()
        print('completed original watched league match unchanged')
        return
    if match.git('status', '--porcelain', '--', 'runtime/emul/league_watched_complete.py'):
        raise ValueError('commit observer before capture')
    import unicorn
    import guest
    binding = reference()
    state_file = ROOT / STATE_PATH
    week = league_week.LeagueWeek(state_file.read_bytes())
    producer = match.git('rev-parse', 'HEAD')
    RUNS.mkdir(parents=True, exist_ok=True)
    INDEX.parent.mkdir(parents=True, exist_ok=True)
    attempts = [int(p.name.split('-')[1]) for p in RUNS.glob('attempt-*-start.json')]
    attempt = max(attempts, default=0) + 1
    metadata = {'schema': 'watched-complete-attempt/1', 'attempt': attempt,
                'code_commit': producer, 'started': match.utc(), 'source': binding,
                'state_sha256': STATE_SHA,
                'game_files': {k: sha(v) for k, v in week.files_at_start.items()},
                'runtime': {'python': platform.python_version(), 'unicorn': unicorn.__version__,
                            'settings': {k: getattr(guest, k) for k in
                                         ('INSTR_PER_S', 'KEY_HOLD', 'PIT_HZ', 'SLICE_MAX')},
                            'dos_clock': week.g.clock},
                'bounds': {'ticks': max_ticks, 'draws': max_draws, 'run_on': 500000}}
    start = RUNS / 'stream-start.json'
    if start.exists():
        old = json.loads(start.read_text())
        if (old['source'] != binding or old['state_sha256'] != metadata['state_sha256']
                or old['game_files'] != metadata['game_files']):
            raise ValueError('resume source inputs differ')
    else:
        write(start, metadata)
    write(RUNS / f'attempt-{attempt:04d}-start.json', metadata)

    def publishing(message, checkpoint=False):
        if not publish:
            return
        files = [str(p.relative_to(ROOT)) for directory in (RUNS, INDEX.parent)
                 for p in directory.rglob('*') if p.is_file()]
        subprocess.run(['git', 'add', '--', *files], cwd=ROOT, check=True)
        if subprocess.run(['git', 'diff', '--cached', '--quiet'], cwd=ROOT).returncode:
            subprocess.run(['git', 'commit', '-m', message], cwd=ROOT, check=True)
            subprocess.run(['git', 'push'], cwd=ROOT, check=True, timeout=120)
        if checkpoint:
            text = ('Research T124 original watched league match in progress on '
                    f'task/T124-league-watched-stream. {message}. Observer producer {producer}; '
                    'append-only 64-tick chunks under runs/T124. No completion is assumed. '
                    'Resume: .cache/venv/bin/python runtime/emul/league_watched_complete.py '
                    '--run --publish (replays/verifies existing chunks, then appends).')
            subprocess.run(['gh', 'issue', 'comment', '283', '--body', text], cwd=ROOT,
                           check=True, timeout=60)

    publishing(f'T124 original watched league attempt {attempt} started', True)
    cursor = None
    chunk_index = 0
    export_draw = 0
    export_tick = 1
    export_action = 0
    tick_number = 0
    action_number = 0
    pending_tick = None
    pending_action = None
    tick_rows = []
    action_rows = []
    all_actions = []
    intervention = None

    def flush():
        nonlocal cursor, chunk_index, export_draw, export_action, export_tick
        nonlocal tick_rows, action_rows
        if not tick_rows and not action_rows and export_draw == week.draws:
            return
        draws = [e for e in week.events if e['kind'] == 'draw']
        payload = {'index': chunk_index, 'draw_start': export_draw, 'draw_end': week.draws,
                   'tick_start': export_tick, 'tick_end': tick_number,
                   'action_start': export_action, 'action_end': action_number,
                   'draws': draws[export_draw:], 'ticks': tick_rows, 'actions': action_rows}
        cursor = validate_chunk(payload, cursor)
        digest = sha(encoded(payload))
        path = RUNS / f'chunk-{chunk_index:06d}.json'
        if path.exists():
            previous = json.loads(path.read_text())
            if previous['payload_sha256'] != digest or previous['payload'] != payload:
                raise ValueError('verified-prefix replay differs')
            print(f'verified existing chunk {chunk_index}/tick {tick_number}', flush=True)
        else:
            record = {'schema': 'original-watched-chunk/1', 'attempt': attempt,
                      'code_commit': producer, 'written': match.utc(),
                      'payload_sha256': digest, 'payload': payload}
            with path.open('xb') as f:
                f.write(encoded(record) + b'\n')
            print(f'original chunk {chunk_index}: tick {tick_number}/draw {week.draws}/'
                  f'actions {action_number}', flush=True)
            publishing(f'T124 original chunk {chunk_index}: tick {tick_number} '
                       f'draw {week.draws} actions {action_number}', chunk_index % 4 == 0)
        chunk_index += 1
        export_draw = week.draws
        export_action = action_number
        export_tick = tick_number + 1
        tick_rows = []
        action_rows = []

    class Complete(Exception):
        pass

    final = None

    def enable(g):
        nonlocal intervention
        if intervention is None:
            address = g.far(0xD7D2) + 0xF2
            intervention = {'site': '0AB9:E24C', 'field': 'config+F2',
                            'before': g.mem(address, 1)[0], 'after': 1}
            g.put(address, b'\x01')

    def tick_enter(g):
        nonlocal tick_number, pending_tick
        if pending_tick is not None:
            raise ValueError('nested watched tick')
        tick_number += 1
        if tick_number > max_ticks or week.draws > max_draws:
            raise ValueError('original watched reference hard bound reached')
        pending_tick = {'tick': tick_number, 'draw_start': week.draws, 'before': state(g)}

    def tick_leave(g):
        nonlocal pending_tick
        if pending_tick is None:
            return
        pending_tick.update(draw_end=week.draws, after=state(g))
        if tick_number == 1:
            validate_league_start(pending_tick['before'])
        tick_rows.append(pending_tick)
        pending_tick = None
        if len(tick_rows) == CHUNK_TICKS:
            flush()

    def action_enter(g):
        nonlocal pending_action
        if not tick_number:
            return
        if pending_action is not None:
            raise ValueError('nested commentary')
        args = prefix.arguments(g)
        code, first, second, side = [args[k] for k in
                                     ('code', 'actor_slot', 'secondary_slot', 'side')]
        club = g.rd(0xD6E4 + 2 * side)

        def player(slot):
            return 0 if slot == 0 else g.word_at(
                g.far(0xD7C2) + 62 * (club - 1) + 2 * (slot - 1))

        pending_action = {'code': code, 'actor_slot': first, 'secondary_slot': second,
                          'side': side, 'club': club, 'player': player(first),
                          'secondary': player(second), 'minute': g.rd(0xD0B2),
                          'tick': tick_number, 'draw_start': week.draws,
                          'seed_before': g.rd(0xA51C), 'head_before': g.rd(0x380),
                          'caller': g.image_address(g.reg('cs'), g.stack_word(0))}

    def action_leave(g):
        nonlocal pending_action, action_number
        if pending_action is None:
            return
        action = pending_action
        pending_action = None
        if g.rd(0x380) == action['head_before']:
            return
        action.update(event=action_number, draw_end=week.draws,
                      seed_after=g.rd(0xA51C), queue=prefix.row(g))
        action_number += 1
        action_rows.append(action)
        all_actions.append(action)

    def end(g):
        nonlocal final
        if tick_number:
            if pending_tick is not None or pending_action is not None:
                raise ValueError('unfinished original frame at match return')
            final = state(g)
            raise Complete()

    week.g.code_hook('0AB9:E24C', enable)
    week.g.code_hook('0AB9:7A02', tick_enter)
    week.g.code_hook('0AB9:7B79', tick_leave)
    week.g.code_hook('0AB9:0F94', action_enter)
    week.g.code_hook('0AB9:0FFC', action_leave)
    week.g.code_hook(match.MATCH_RETURN, end)
    status = 'completed'
    reason = None
    try:
        try:
            week.play(max_run_on=500000)
        except Complete:
            pass
        else:
            raise ValueError('week ended without watched match return')
        if week.g.unsupported or final is None:
            raise ValueError('unsupported/incomplete watched run')
        validate_league_start(ticks_start(week, tick_rows, all_actions))
        validate_finish(final, all_actions)
        finish_count(all_actions, [1] * tick_number, week.draws)
        flush()
    except (Exception, KeyboardInterrupt) as exc:
        status = 'aborted'
        reason = f'{type(exc).__name__}: {exc}'
    finish = RUNS / f'attempt-{attempt:04d}-finish.json'
    write(finish, {'schema': 'watched-complete-finish/1', 'attempt': attempt,
                   'code_commit': producer, 'status': status, 'reason': reason,
                   'ended': match.utc(),
                   'boundary': match.MATCH_RETURN if status == 'completed' else None,
                   'ticks': tick_number, 'draws': week.draws, 'actions': action_number,
                   'intervention': intervention, 'final': final,
                   'scope': 'Original watched league match #28, decoded reference only; '
                            'never a native runtime backend.'})
    if status == 'completed':
        chunks = sorted(RUNS.glob('chunk-*.json'))
        write(INDEX, {'schema': 'complete-original-watched/1',
                      'start': {'path': str(start.relative_to(ROOT)),
                                'sha256': sha(start.read_bytes())},
                      'finish': {'path': str(finish.relative_to(ROOT)),
                                 'sha256': sha(finish.read_bytes())},
                      'chunks': [{'path': str(p.relative_to(ROOT)),
                                  'sha256': sha(p.read_bytes())} for p in chunks]})
        check()
    publishing(f'T124 watched league attempt {attempt} {status}: tick {tick_number} '
                f'draw {week.draws}', True)
    print(status, reason, flush=True)
    if status != 'completed':
        raise SystemExit(1)


def ticks_start(week, tick_rows, all_actions):
    """The first recorded tick, for the post-run validation."""
    if tick_rows:
        return tick_rows[0]['before']
    raise ValueError('no watched tick was recorded')


def main():
    parser = argparse.ArgumentParser(description=__doc__,
                                     formatter_class=argparse.RawDescriptionHelpFormatter)
    group = parser.add_mutually_exclusive_group(required=True)
    group.add_argument('--run', action='store_true')
    group.add_argument('--check', action='store_true')
    parser.add_argument('--publish', action='store_true')
    parser.add_argument('--max-ticks', type=int, default=10000)
    parser.add_argument('--max-draws', type=int, default=1000000)
    args = parser.parse_args()
    if args.run:
        run(args.publish, args.max_ticks, args.max_draws)
    else:
        try:
            check()
        except (ValueError, OSError, KeyError, TypeError, IndexError) as exc:
            print('league watched check: FAIL: ' + str(exc))
            raise SystemExit(1)


if __name__ == '__main__':
    main()
