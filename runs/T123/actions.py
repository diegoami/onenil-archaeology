#!/usr/bin/env python3
"""T123: the league fixture's original action stream.

The T100 preparation machine drives the week-28 fixture watched in the harness
(no DOSBox). This records every original action at the 0AB9:0F94/0FFC
dispatcher - queue/arguments, the draw interval, the seed, the minute, the
tick - plus the score changes, so the native event stream can be compared
action by action. Append-only; the run is long, so it journals by screen.

    python3 runs/T123/actions.py --run <savestate> --record runs/T123/actions-r0001.json
    python3 runs/T123/actions.py --check runs/T123/actions-r0001.json
"""
import argparse
import hashlib
import json
import sys
import time
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / 'runtime' / 'emul'))
import league_week  # noqa: E402
import watched_actions as actions_tool  # noqa: E402

STATE_SHA = '3abfd6b00f8024900b93a20d1ff1eec60cfd2d570e927a00eca495d7f7b1d1c8'
T100_RECEIPT = ROOT / 'runs/T100/preparation-r0001.json'
T102_WEEK = ROOT / 'runs/T102/week-r0001.json'


def sha(data):
    return hashlib.sha256(data).hexdigest()


def capture(data):
    if sha(data) != STATE_SHA:
        raise ValueError('start RAM identity differs')
    week = league_week.LeagueWeek(data)
    g = week.g
    observed = dict(ticks=0, actions=[], draws=[], score_changes=[])
    pending = None
    last_score = [0, 0]

    def enter(g):
        nonlocal pending, last_score
        if pending is not None:
            raise ValueError('nested commentary request')
        score = [g.rd(0xD086, 1), g.rd(0xD087, 1)]
        if score != last_score:
            observed['score_changes'].append(dict(
                draw=week.draws, minute=g.rd(0xD0B2), score=score))
            last_score = score
        args = actions_tool.arguments(g)
        code, first, second, side = [args[k] for k in ('code', 'actor_slot', 'secondary_slot', 'side')]
        club = g.rd(0xD6E4 + 2 * side)

        def player(slot):
            return 0 if slot == 0 else int.from_bytes(
                g.mem(g.far(0xD7C2) + 62 * (club - 1) + 2 * (slot - 1), 2), 'little')

        pending = dict(code=code, actor_slot=first, secondary_slot=second, side=side, club=club,
                       player=player(first), secondary=player(second), minute=g.rd(0xD0B2),
                       tick=week.draws, draw_start=week.draws,
                       seed_before=g.rd(0xA51C), head_before=g.rd(0x380),
                       caller=g.image_address(g.reg('cs'), g.stack_word(0)))

    def leave(g):
        nonlocal pending
        if pending is None:
            return
        value = pending
        pending = None
        if g.rd(0x380) == value['head_before']:
            return
        value.update(event=len(observed['actions']), draw_end=week.draws,
                     seed_after=g.rd(0xA51C), queue=actions_tool.row(g))
        observed['actions'].append(value)
        if len(observed['actions']) % 100 == 0:
            print('action', len(observed['actions']), 'tick', observed['ticks'], flush=True)

    g.code_hook('0AB9:0F94', enter)
    g.code_hook('0AB9:0FFC', leave)
    started = time.monotonic()
    week.play(on_boundary=lambda w: print('screen', w.screen_i, 'draws', w.draws, flush=True))
    observed['draws'] = [e for e in week.events if e['kind'] == 'draw']
    observed['ticks'] = week.draws
    observed['elapsed_seconds'] = round(time.monotonic() - started, 1)
    if not observed['actions']:
        raise ValueError('no original action was captured')
    if [row['event'] for row in observed['actions']] != list(range(len(observed['actions']))):
        raise ValueError('action census differs')
    for before, after in zip(observed['actions'], observed['actions'][1:]):
        if after['draw_start'] < before['draw_end']:
            raise ValueError('action cursor order differs')
    for row in observed['actions']:
        if row['seed_before'] != observed['draws'][row['draw_start'] - 1]['seed_after']:
            raise ValueError('action input seed differs')
        if row['seed_after'] != observed['draws'][row['draw_end'] - 1]['seed_after']:
            raise ValueError('action output seed differs')
    return observed


def validate(record):
    if record['schema'] != 'league-action-stream/1' or record['status'] != 'completed':
        raise ValueError('incomplete action stream')
    if record['source']['state_sha256'] != STATE_SHA:
        raise ValueError('savestate identity differs')
    if record['source']['t100_receipt_sha256'] != sha(T100_RECEIPT.read_bytes()):
        raise ValueError('T100 receipt differs')
    if record['source']['t102_week_sha256'] != sha(T102_WEEK.read_bytes()):
        raise ValueError('T102 week differs')
    actions = record['actions']
    if not actions or [a['event'] for a in actions] != list(range(len(actions))):
        raise ValueError('action census differs')
    for row in actions:
        if row['queue']['code'] != row['code'] or row['queue']['player'] != row['player']:
            raise ValueError('queue/argument identity differs')
    if record['score_changes'][-1]['score'] != [2, 0]:
        raise ValueError('the original score differs from T102 (2-0 home)')
    if sha(json.dumps(record['actions'], sort_keys=True, separators=(',', ':')).encode()) != record['actions_sha256']:
        raise ValueError('action digest differs')


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--run', type=Path)
    parser.add_argument('--record', type=Path)
    parser.add_argument('--check', type=Path)
    args = parser.parse_args()
    if args.run:
        if args.record is None:
            parser.error('--run needs --record')
        if args.record.exists():
            raise SystemExit('the record path already exists')
        data = args.run.read_bytes()
        observed = capture(data)
        receipt = json.loads(T100_RECEIPT.read_text())
        record = dict(
            schema='league-action-stream/1', issue=282, task='T123', status='completed',
            source=dict(state_sha256=STATE_SHA, state_size=len(data),
                        t100_receipt_sha256=sha(T100_RECEIPT.read_bytes()),
                        receipt_screen_sha256=receipt['preparation']['screen_sha256'],
                        t102_week_sha256=sha(T102_WEEK.read_bytes())),
            ticks=observed['ticks'], action_count=len(observed['actions']),
            actions=observed['actions'], score_changes=observed['score_changes'],
            draws_sha256=sha(json.dumps(observed['draws'], sort_keys=True,
                                        separators=(',', ':')).encode()),
            draw_count=len(observed['draws']), elapsed_seconds=observed['elapsed_seconds'],
            actions_sha256=sha(json.dumps(observed['actions'], sort_keys=True,
                                          separators=(',', ':')).encode()),
            scope='Every accepted original action of the watched week-28 fixture; the '
                  'draw stream is hashed, the actions carry their own draw intervals.')
        validate(record)
        args.record.parent.mkdir(parents=True, exist_ok=True)
        args.record.write_text(json.dumps(record, indent=1) + '\n')
        print('recorded', record['action_count'], 'actions,', record['ticks'], 'ticks')
        return
    record = json.loads(args.check.read_text())
    validate(record)
    print('the league action stream and', record['action_count'], 'actions: ready')


if __name__ == '__main__':
    main()
