#!/usr/bin/env python3
"""T93 authenticated Sevilla week capture — the match, the sealed caller, and
the week's full-time route: cash flow, transfer news, the week transaction and
the week-2 state.

The native T91 refusal (onenil 8cf2de3) names the gap: the second week's cash
movement is unwitnessed. This capture closes it from the same pinned identities
T89 used: the entry gate refuses any state that is not the authenticated
post-week save; the match replays from the pinned preparation savestate and is
verified chunk-by-chunk against the committed sevilla-r0001 identity; the
caller runs under the sealed T89 observer; then the week route continues in the
same machine — the cash flow screen, the transfer news screen and the week
transaction are observed with typed facts (the second week's movement, the
week-2 Celtic fixture advance, the weekly condition refresh, the week-2
campaign projection), counts observed, never transplanted.
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
sys.path.insert(0, str(ROOT / 'runtime/emul'))
sys.path.insert(0, str(ROOT / 'runtime/driver'))
sys.path.insert(0, str(ROOT / 'tools/data'))

from saved_roster import MANAGED_CLUB  # noqa: E402
import sevilla_match as base  # noqa: E402
import week_completion  # noqa: E402
import campaign_admission as admission  # noqa: E402
import postmatch_tail as tail  # noqa: E402
import watched_complete as prior  # noqa: E402

RUNS = ROOT / 'runs/T93'
sha = lambda data: hashlib.sha256(data).hexdigest()
encoded = lambda value: json.dumps(value, sort_keys=True, separators=(',', ':')).encode()

# The digest-pinned private identities (owner-local; never in git), inherited
# from the sealed T89 module's gates.
ENTRY_SAVE_SHA = base.ENTRY_SHA
PREPARATION_STATE_SHA = base.PREPARATION_STATE_SHA
EMULATED_HARDWARE = dict(
    pit_divisor=1024,
    reason="the game's own PIT write (1998:0096, divisor 0x400 for a match) precedes "
           "the restored savestate; the savestate format cannot carry the timer chip")


def match_identity():
    """The committed sevilla-r0001 identity the replay must reproduce chunk for
    chunk: the file-digest chain (the record's integrity), the payload digests
    (what the replay's flush computes — the wrapper is not part of a chunk's
    self digest), the observed counts and the return boundary."""
    finish = json.loads((base.ROOT / 'runs/T89/sevilla-r0001/finish.json').read_text())
    index = json.loads((base.ROOT / 'runs/T89/sevilla-r0001/index.json').read_text())
    result = finish['result']
    if finish['status'] != 'completed' or result['entry_draws'] != 0:
        raise ValueError('the committed sevilla capture is not a complete natural run')
    payloads = []
    for leaf in index['chunks']:
        chunk = json.loads((base.ROOT / 'runs/T89/sevilla-r0001' / leaf['path']).read_text())
        if sha(chunk['payload']) != chunk['payload_sha256'] \
                or sha((base.ROOT / 'runs/T89/sevilla-r0001' / leaf['path']).read_bytes()) \
                != leaf['sha256']:
            raise ValueError('the committed sevilla chunk ledger differs')
        payloads.append(chunk['payload_sha256'])
    return dict(chunk_sha256=[leaf['sha256'] for leaf in index['chunks']],
                payload_sha256=payloads,
                ticks=result['ticks'], draws=result['draws'], actions=result['actions'],
                match_return=dict(site=result['match_return']['site'],
                                  draw=result['match_return']['draw'],
                                  seed=result['match_return']['seed']))


def authenticate_entry(save_sha256):
    """The entry gate: refuse any state that is not the authenticated post-week
    save before any emulation begins."""
    if save_sha256 != base.ENTRY_SHA:
        raise ValueError('the entry save is not the authenticated post-week state')


def authenticate_week_facts(cash_in, cash_out, following):
    """The observed week facts: refuse the week-0 transplant by name and
    require the week-2 advertisement the T82 decode names."""
    if (cash_in, cash_out) == (38_761, 69_270):
        raise ValueError('the week-0 cash movement is week-specific and cannot '
                         'stand for the Sevilla week')
    if following != dict(week=2, competition=1, opponent=28, flags=0):
        raise ValueError('the week-2 following fixture differs from the '
                         'T82-decoded Celtic triple')


def cash_screen_facts(text):
    """The cash flow screen's typed movement: TOTAL IN, TOTAL OUT and the club
    funds, parsed from the boxed display (the digits survive the cell split)."""
    flat = re.sub(r'[^\w\d,:\n ]', ' ', text)
    total_in = total_out = funds = None
    for line in flat.splitlines():
        if 'TOTAL IN' in line:
            total_in = int(re.sub(r'\D', '', line.split('TOTAL IN', 1)[1]) or 0)
        if 'TOTAL OUT' in line:
            total_out = int(re.sub(r'\D', '', line.split('TOTAL OUT', 1)[1]) or 0)
        if 'Club funds' in line:
            funds = int(re.sub(r'\D', '', line.split('Club funds', 1)[1]) or 0)
    if total_in is None or total_out is None or funds is None:
        raise ValueError('the cash flow screen lacks its typed movement')
    return dict(total_in=total_in, total_out=total_out, club_funds=funds)


def project(week):
    """The campaign projection from live machine memory (the boot analogue)."""
    return admission.seed.project(admission.memory_save(week.g),
                                  admission.seed.names(week.files_at_start['ENGL-95.DAT']))


def run(directory, state_path, max_ticks=0):
    """The full route. Replays the witnessed match from the pinned preparation
    savestate under the sealed observer, then continues the same machine
    through the week's full-time route to the advanced week-2 state."""
    directory = Path(directory)
    if (directory / 'finish.json').exists():
        raise ValueError('capture directory already complete')
    sealed = match_identity()
    meta = dict(producer=base.git('rev-parse', 'HEAD').decode().strip(),
                producer_files={p: sha((ROOT / p).read_bytes()) for p in base.watcher_census()})
    for name, digest in meta['producer_files'].items():
        if sha(base.git('show', meta['producer'] + ':' + name)) != digest:
            raise ValueError('commit the observer before the capture: ' + name)
    week, projected, context = base.boot(state_path)
    g = week.g
    watch = g.mem(g.far(0xD7D2) + 0xF2, 1)[0]
    if watch != 1:
        raise ValueError('the saved campaign does not carry the enabled watch setting')
    boot_record = json.loads((base.ROOT / 'records/T89/boot-r0001.json').read_text())
    if boot_record['projection_sha256'] != hashlib.sha256(
            json.dumps(projected, sort_keys=True).encode()).hexdigest():
        raise ValueError('the live projection differs from the published boot record')
    if projected['cash'] != 421_491:
        raise ValueError('the preparation cash differs from the committed week-1 movement')
    start = dict(schema='sevilla-week-start/1', **meta,
                 preparation_state=dict(path=str(state_path), sha256=base.PREPARATION_STATE_SHA),
                 boot=dict(record='records/T89/boot-r0001.json',
                           record_sha256=sha((base.ROOT / 'records/T89/boot-r0001.json').read_bytes()),
                           projection_sha256=boot_record['projection_sha256']),
                 release=base.release_96(), watch_setting=watch,
                 live_context=base.PREPARATION_LIVE,
                 emulated_hardware=EMULATED_HARDWARE,
                 sealed_match=dict(runs='runs/T89/sevilla-r0001',
                                   chunk_count=len(sealed['chunk_sha256']),
                                   ticks=sealed['ticks'], draws=sealed['draws'],
                                   actions=sealed['actions']),
                 interventions=[])
    directory.mkdir(parents=True, exist_ok=True)
    prior.write(directory / 'start.json', start)

    ticks = cursor = chunk_index = 0
    export_draw = export_action = 0
    export_tick = 1
    tick_rows, action_rows, all_actions = [], [], []
    joined = False
    pending_tick = pending_action = None
    first_entry = entry_draws = final = None
    match_return = audit = condition = None

    def flush():
        nonlocal cursor, chunk_index, export_draw, export_action, export_tick, tick_rows, action_rows
        draws = [e for e in week.events if e['kind'] == 'draw']
        payload = dict(index=chunk_index, draw_start=export_draw, draw_end=week.draws,
                       tick_start=export_tick, tick_end=ticks,
                       action_start=export_action, action_end=len(all_actions),
                       draws=draws[export_draw:], ticks=tick_rows, actions=action_rows)
        cursor = prior.validate_chunk(payload, cursor)
        digest = sha(encoded(payload))
        if not max_ticks:
            # Fail fast: the replay must reproduce the witnessed match exactly.
            # The comparison is on the chunk payload digests — the same layer
            # the sealed record's own chunks pin.
            if chunk_index >= len(sealed['payload_sha256']) \
                    or digest != sealed['payload_sha256'][chunk_index]:
                raise ValueError('the replayed match stream diverges from the '
                                 'sealed sevilla-r0001 identity')
        path = directory / f'chunk-{chunk_index:06d}.json'
        if path.exists():
            previous = json.loads(path.read_text())
            if previous['payload_sha256'] != digest or previous['payload'] != payload:
                raise ValueError('sevilla week verified-prefix replay differs')
        else:
            with path.open('xb') as out:
                out.write(encoded(dict(schema='sevilla-watched-chunk/1', producer=meta['producer'],
                                       payload_sha256=digest, payload=payload)) + b'\n')
        print(f'sevilla week chunk{chunk_index}: tick{ticks}, draw{week.draws}, '
              f'actions{len(all_actions)}', flush=True)
        chunk_index += 1
        export_draw, export_action, export_tick = week.draws, len(all_actions), ticks + 1
        tick_rows, action_rows = [], []
        if not max_ticks and chunk_index % 10 == 0:
            # Long-run rule (#58/#212): the append-only records leave the machine
            # while the capture runs; a failed push never stops the capture.
            try:
                subprocess.run(['git', 'add', str(directory)], check=True, cwd=ROOT)
                subprocess.run(['git', 'commit', '-q', '-m',
                                f'T93: capture progress, chunk {chunk_index} (automated milestone)'],
                               check=True, cwd=ROOT)
                subprocess.run(['git', 'push'], check=True, cwd=ROOT)
            except Exception as error:
                print(f'progress push skipped: {error}', flush=True)

    def entry(current):
        nonlocal joined, first_entry, entry_draws
        if joined:
            return
        first_entry = prior.state(current)
        entry_draws = week.draws
        joined = True
        print(f'sevilla week joined: entry draws {entry_draws}', flush=True)

    def tick_enter(current):
        nonlocal ticks, pending_tick
        if not joined or pending_tick is not None:
            raise ValueError('unjoined/nested sevilla week tick')
        if max_ticks and ticks + 1 > max_ticks:
            raise tail.Complete()
        ticks += 1
        pending_tick = dict(tick=ticks, draw_start=week.draws, before=prior.state(current))

    def tick_leave(current):
        nonlocal pending_tick, tick_rows
        if pending_tick is None:
            return
        pending_tick.update(draw_end=week.draws, after=prior.state(current))
        tick_rows.append(pending_tick)
        pending_tick = None
        if len(tick_rows) == prior.CHUNK_TICKS:
            flush()

    def action_enter(current):
        nonlocal pending_action
        if not ticks:
            return
        if pending_action is not None:
            raise ValueError('nested sevilla week commentary')
        args = prior.prefix.arguments(current)
        club = current.rd(0xD6E4 + 2 * args['side'])

        def player(slot):
            return 0 if slot == 0 else current.word_at(current.far(0xD7C2) + 62 * (club - 1) + 2 * (slot - 1))

        pending_action = dict(**args, club=club, player=player(args['actor_slot']),
                              secondary=player(args['secondary_slot']), minute=current.rd(0xD0B2),
                              tick=ticks, draw_start=week.draws, seed_before=current.rd(0xA51C),
                              head_before=current.rd(0x380),
                              caller=current.image_address(current.reg('cs'), current.stack_word(0)))

    def action_leave(current):
        nonlocal pending_action, action_rows, all_actions
        if pending_action is None:
            return
        row, pending_action = pending_action, None
        if current.rd(0x380) == row['head_before']:
            return
        row.update(event=len(all_actions), draw_end=week.draws, seed_after=current.rd(0xA51C),
                   queue=prior.prefix.row(current))
        action_rows.append(row)
        all_actions.append(row)

    def end(current):
        """EBE2, the match return: record the boundary, then install the sealed
        numeric observer and the condition recorder — the original's own
        post-match caller (E679→EBE6) runs next, and NumericAudit.leave raises
        Complete when it returns. The T89 observer, unchanged."""
        nonlocal final, match_return, audit, condition
        if not ticks or pending_tick is not None or pending_action is not None:
            raise ValueError('sevilla week match returned with a pending observer frame')
        final = prior.state(current)
        match_return = dict(site=current.where(), draw=week.draws,
                            seed=current.word_at(current.far(0xDE84)),
                            registers=tail.prior.registers(current), state=final)
        audit = tail.NumericAudit(week)
        condition = tail.prior.Recorder(week)

    for site, callback in [('0AB9:7C67', entry), ('0AB9:7A02', tick_enter),
                           ('0AB9:7B79', tick_leave), ('0AB9:0F94', action_enter),
                           ('0AB9:0FFC', action_leave), ('0AB9:EBE2', end)]:
        g.code_hook(site, callback)

    status, error = 'completed', None
    began = time.monotonic()
    caller_boundary = None
    stages = []
    try:
        try:
            week.play(max_run_on=500000)
        except tail.Complete:
            pass
        else:
            raise ValueError('the sevilla week match and its caller did not return')
        if max_ticks:
            if not joined:
                raise ValueError('the smoke run did not join the sevilla week match')
        else:
            if not joined or match_return is None or audit is None or audit.returned is None \
                    or g.unsupported:
                raise ValueError('unsupported/incomplete sevilla week capture')
        flush()
        caller_boundary = dict(schema='sevilla-week-caller-boundary/1',
                               seconds=round(time.monotonic() - began, 1),
                               projection=project(week))
        if not max_ticks:
            # The week route continues in the same machine: the boundary's cash
            # is still the week-1 movement; the caller's own fixture/history
            # writes sit between the projections.
            if caller_boundary['projection']['cash'] != 421_491:
                raise ValueError('the caller boundary cash differs from the committed week-1 state')
            observing = lambda w: stages.append(dict(
                screen=w.screen_i, digest=w.g.screen().digest(), text=w.g.screen().text()))
            week.play(max_run_on=500000, on_boundary=observing)
            if not week.finished:
                raise ValueError('the week route did not reach the management menu')
    except (Exception, KeyboardInterrupt) as exc:
        status, error = 'aborted', f'{type(exc).__name__}: {exc}'
    chunks = sorted(directory.glob('chunk-*.json'))
    caller = None if audit is None else {k: getattr(audit, k) for k in
                                         ('entry', 'returned', 'frame', 'initial', 'final', 'ops',
                                          'regions', 'draw_start', 'draw_end', 'census',
                                          'preservation', 'timer_effects', 'service_effects')}
    cond = None if condition is None else dict(calls=condition.calls, contexts=condition.contexts)
    result = dict(chunk_payloads=[sha(p.read_bytes()) for p in chunks], final=final,
                  ticks=ticks, draws=week.draws, actions=len(all_actions),
                  first_entry=first_entry, entry_draws=entry_draws,
                  match_return=match_return, caller=caller, condition=cond,
                  caller_boundary=caller_boundary, stages=stages,
                  seconds=round(time.monotonic() - began, 1), smoke=bool(max_ticks))
    if not max_ticks and status == 'completed':
        # The week route ran: project the advanced state and observe its facts.
        after = project(week)
        memory = admission.memory_save(g)
        fixtures = week_completion.decode_fixture_triples(memory, MANAGED_CLUB, weeks=4)
        week_byte = week_completion.decode_week_byte(memory)
        cash_facts = None
        for stage in reversed(stages):
            if 'CASH FLOW' in stage['text']:
                cash_facts = cash_screen_facts(stage['text'])
                break
        if cash_facts is None or cash_facts['club_funds'] != after['cash']:
            raise ValueError('the cash screen movement differs from the projected week-2 funds')
        authenticate_week_facts(cash_facts['total_in'], cash_facts['total_out'],
                                dict(week=week_byte, competition=fixtures[1]['competition'],
                                     opponent=fixtures[1]['opponent'], flags=fixtures[1]['flags']))
        result['week'] = dict(
            cash_before=projected['cash'],
            cash_after=after['cash'],
            total_in=cash_facts['total_in'], total_out=cash_facts['total_out'],
            following=dict(week=week_byte, competition=fixtures[1]['competition'],
                           opponent=fixtures[1]['opponent'], flags=fixtures[1]['flags'],
                           name=fixtures[1].get('name', '')),
            week_byte=week_byte,
            conditions_before={p['id']: p['availability']['condition_signed']
                               for p in caller_boundary['projection']['players']},
            conditions_after={p['id']: p['availability']['condition_signed']
                              for p in after['players']},
            next_fixture=after['next_fixture'], seed_word=g.word_at(g.far(0xDE84)),
            state_digests=week.state_digests(), files_written=week.files_written(),
            projection=after)
    prior.write(directory / 'finish.json',
                dict(schema='sevilla-week-finish/1', status=status, error=error,
                     producer=meta['producer'], result=result,
                     keys_delivered=g.keys_delivered, unsupported=g.unsupported))
    if status != 'completed':
        raise ValueError(error)
    prior.write(directory / 'index.json',
                dict(start_sha256=sha((directory / 'start.json').read_bytes()),
                     chunks=[dict(path=p.name, sha256=sha(p.read_bytes())) for p in chunks],
                     finish_sha256=sha((directory / 'finish.json').read_bytes())))
    print(f'sevilla week captured: ticks{ticks}, draw{week.draws}, '
          f'actions{len(all_actions)}, week byte {result.get("week", {}).get("week_byte")}',
          flush=True)


def check(directory):
    """Public acceptance: re-validate a complete capture directory without any
    private file."""
    if directory is None:
        raise ValueError('no recorded sevilla week run to check')
    directory = Path(directory)
    start = json.loads((directory / 'start.json').read_text())
    finish = json.loads((directory / 'finish.json').read_text())
    index = json.loads((directory / 'index.json').read_text())
    if start['schema'] != 'sevilla-week-start/1' or finish['schema'] != 'sevilla-week-finish/1':
        raise ValueError('sevilla week record schema differs')
    if finish['status'] != 'completed':
        raise ValueError('the recorded sevilla week run did not complete')
    identity = match_identity()
    if [leaf['sha256'] for leaf in index['chunks']] != identity['chunk_sha256']:
        raise ValueError('the replayed match stream differs from the sealed identity')
    result = finish['result']
    for key in ('ticks', 'draws', 'actions'):
        if result[key] != identity[key]:
            raise ValueError(f'the replayed match {key} count differs from the sealed identity')
    if result['match_return']['site'] != identity['match_return']['site'] \
            or result['match_return']['seed'] != identity['match_return']['seed']:
        raise ValueError('the replayed match return differs from the sealed identity')
    sealed_caller = json.loads(
        (base.ROOT / 'runs/T89/sevilla-r0001/finish.json').read_text())['result']['caller']
    for key in ('frame', 'census', 'preservation'):
        if result['caller'][key] != sealed_caller[key]:
            raise ValueError(f'the replayed caller {key} differs from the sealed T89 record')
    authenticate_week_facts(result['week']['total_in'], result['week']['total_out'],
                            result['week']['following'])
    if result['week']['cash_after'] != result['week']['projection']['cash']:
        raise ValueError('the week-2 projection cash differs from the observed movement')
    if result['week']['week_byte'] != 2:
        raise ValueError('the week byte did not advance to the second week')
    texts = ' '.join(stage['text'] for stage in result['stages'])
    for marker in ('CASH FLOW', 'TRANSFER'):
        if marker not in texts:
            raise ValueError(f'the week route never observed {marker}')
    return dict(schema='sevilla-week-check/1', status='accepted',
                ticks=result['ticks'], week_byte=result['week']['week_byte'],
                cash=dict(before=result['week']['cash_before'],
                          after=result['week']['cash_after'],
                          total_in=result['week']['total_in'],
                          total_out=result['week']['total_out']),
                following=result['week']['following'])


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--state', type=Path,
                        default=ROOT / '.cache/T89/states/sevilla-preparation-0001.sav')
    parser.add_argument('--directory', type=Path, default=RUNS / 'sevilla-week-r0001')
    parser.add_argument('--smoke-ticks', type=int, default=0)
    parser.add_argument('--check', action='store_true')
    args = parser.parse_args()
    if args.check:
        print(json.dumps(check(args.directory), indent=1))
    else:
        run(args.directory, args.state, max_ticks=args.smoke_ticks)


if __name__ == '__main__':
    main()
