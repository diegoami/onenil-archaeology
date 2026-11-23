#!/usr/bin/env python3
"""T114 receipt: the injury substitution witnessed - the PUT HERE flow from
the pitch's stoppage menu, captured in runs/T114/session-r0015. The T106
route replayed digest-, key- and wait-identical in order (53/53, the load
step included), the injury pause offered SUBSTITUTION OPPORTUNITY with
Sherwood INJURED, two Spaces reached the squad screen with MAKE
SUBSTITUTION in its footer, ten content-verified Downs selected the injured
T Sherwood, Enter started PUT HERE, two Downs selected the substitute
S Ripley, Enter confirmed, the panel shows the swap positionally (Ripley in
the eleven, Sherwood under SUBS, Remaining subs 2 -> 1), full time reads
Blackburn R 5 Wimbledon 3, and the week walk runs
results/table/cash/news/management with the cash amounts parsed from the
screens and joined to the T112 receipt's funds. --check re-reads every fact
from the committed session, proves the session's own chain and text digests,
and prints ready.

[review pass] The first version (schema 1/1) left five gaps that read-only
mutations exposed: the cash figure was a constant and not parsed from the
screen; the swap was not positional (the two names swapped still passed);
the flow's keys were never compared; the injury itself was not asserted at
the offer; and the replay binding skipped unmatched capture steps even when
they carried gameplay keys. The binding now mirrors T112's replay_pairs: the
route is consumed in order with keys, waits, text and screenshot digests
compared, and any unmatched step outside the route that sends input fails."""
import hashlib
import json
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent.parent
SESSION = ROOT/'runs/T114/session-r0015'
T106_SESSION = ROOT/'runs/T106/session-r0014'
T112_RECEIPT = ROOT/'runs/T112/week-r0001.json'
SOURCE_SAVE = ROOT/'.cache/saves/pre-league28/SAVE1.1-0'
STATE = ROOT/'.cache/T114/states/post-league30-t114.sav'
RECEIPT = ROOT/'runs/T114/week-r0001.json'
REPLAY_RANGE = range(1, 54)          # T106's steps 1..53 (the load included)
# the control script's own load command id differs from the route's:
REPLAY_ID_MAP = {'S002-loaded': 'S002-y-1'}
INJURED = 'T Sherwood'
SUBS = ('S Ripley', 'C Hendry', 'H Berg', 'B Mimms')


def sha(data):
    return hashlib.sha256(data).hexdigest()


def digits(line):
    """Join the numeric cells of a boxed amount ('1,6│3│6,5│8│3' -> 1636583)."""
    return int(''.join(re.findall(r'[0-9,]+', line)).replace(',', ''))


def session_steps():
    """The committed capture, its own integrity proven: the action chain
    (each step's previous is the previous file's digest), every text digest
    against the text bytes, and the end record against the chain. Any edit to
    a committed step file - text, keys, digests - fails here."""
    paths = sorted(SESSION.glob('step-*.json'))
    steps = [json.loads(p.read_text()) for p in paths]
    previous = None
    for path, s in zip(paths, steps):
        if s['previous'] != previous:
            raise SystemExit(f'{path.name}: the action chain is broken')
        previous = sha(path.read_bytes())
        if s.get('text_sha256') != sha(s['text'].encode()):
            raise SystemExit(f'{path.name}: the text does not match its digest')
    end = json.loads((SESSION/'end.json').read_text())
    if end['steps'] != len(steps) or end['last_step'] != previous:
        raise SystemExit('the end record disagrees with the chain')
    return steps


def capture_by_id(steps, sid):
    matches = [s for s in steps if s['id'] == sid]
    if len(matches) != 1:
        raise SystemExit(f'{sid}: {len(matches)} captures, expected one')
    return matches[0]


def selection(steps, sid):
    """The selected player on the MAKE SUBSTITUTION screen: the OCR merges
    the skills bars with the name box into one highlighted entry - the
    selection is the last ║-delimited segment of the highlighted row."""
    s = capture_by_id(steps, sid)
    for entry in s.get('highlighted') or []:
        if len(entry) == 2 and '║' in str(entry[1]):
            tail = str(entry[1]).rsplit('║', 1)[-1].strip()
            words = tail.split()
            if len(words) >= 2 and all(
                    w[0].isupper() and not (len(w) > 1 and w.isupper())
                    for w in words):
                return tail, s
    return None, s


def fact_lines(text, needles):
    lines = text.splitlines()
    facts = {}
    for needle in needles:
        for line in lines:
            if needle in line:
                facts[needle] = line.strip()
                break
        else:
            raise SystemExit(f'the needle {needle!r} is not on the screen')
    return facts


def squad_sections(text):
    """The bench screen's squad columns: the FIRST TEAM rows above the SUBS
    divider and the substitute rows below it. A row is a name cell followed by
    a one-character position cell ('║ T Flowers    ║G║'); the divider is
    '╟─SUBS─────────╫─╢'."""
    first, subs, section = [], [], None
    for line in text.splitlines():
        if 'FIRST TEAM' in line and '═' in line:
            section = 'first'
            continue
        if 'SUBS' in line and '─' in line:
            section = 'subs'
            continue
        match = re.search(r"║\s*([A-Z][A-Za-z. '-]+?)\s*║[^║]║", line)
        if match and section:
            (first if section == 'first' else subs).append(match.group(1).strip())
    return first, subs


def replay_binding(steps):
    """The ordered replay binding, checkable from committed bytes alone: the
    T106 route consumed in order against the capture, every matched step's
    keys, wait, text digest and screenshot digest equal (T112's replay_pairs
    invariant), and no unmatched capture step inside the route carrying
    gameplay input. The load step's id differs by the control script's own
    command id and is mapped explicitly."""
    theirs = [json.loads((T106_SESSION/f'step-{n:04d}.json').read_text())
              for n in REPLAY_RANGE]
    cursor = 0
    matched = []
    problems = []
    for target in theirs:
        expected = REPLAY_ID_MAP.get(target['id'], target['id'])
        while cursor < len(steps) and steps[cursor]['id'] != expected:
            skipped = steps[cursor]
            if skipped.get('keys'):
                problems.append(f"an unmatched step sent gameplay input: my "
                                f"step {skipped['number']} ({skipped['id']}), "
                                f"keys {skipped['keys']}")
            cursor += 1
        if cursor >= len(steps):
            problems.append(f"step-{target['number']:04d} ({target['id']}): "
                            f'absent from the capture')
            continue
        step = steps[cursor]
        cursor += 1
        for field in ('keys', 'wait', 'text_sha256', 'screen_sha256'):
            if step[field] != target[field]:
                problems.append(f"my step {step['number']} ({step['id']}): "
                                f'{field} differs from T106')
        matched.append(dict(my_step=step['number'], my_id=step['id'],
                            t106_step=target['number'], t106_id=target['id'],
                            keys=step['keys'], wait=step['wait'],
                            text_sha256=step['text_sha256'],
                            screen_sha256=step['screen_sha256']))
    if problems:
        raise SystemExit('the replay binding fails: ' + '; '.join(problems[:4]))
    return dict(route=T106_SESSION.relative_to(ROOT).as_posix(),
                route_steps=len(theirs), matched=len(matched),
                id_mapping=REPLAY_ID_MAP, pairs=matched)


def flow_keys(steps):
    """The flow's own input, compared step by step: the walk's Downs, the
    PUT HERE Enter, the substitute Downs and the confirming Enter. The record
    then states the keys, not only the screens they produced."""
    downs, subs, spaces = [], [], []
    for s in steps:
        if s['id'].startswith('S037-down-'):
            downs.append(s)
        elif s['id'].startswith('S039-sub-down-'):
            subs.append(s)
        elif s['id'].startswith('S036-space-'):
            spaces.append(s)
    for group, expected in ((downs, ['Down']), (subs, ['Down']), (spaces, ['space'])):
        for s in group:
            if s['keys'] != expected:
                raise SystemExit(f"{s['id']}: keys {s['keys']} are not {expected}")
    for sid in ('S038-put-here', 'S040-confirm'):
        s = next((x for x in steps if x['id'] == sid), None)
        if s is None or s['keys'] != ['Enter']:
            raise SystemExit(f'{sid}: the Enter is missing')
    return dict(spaces=[s['id'] for s in spaces], downs=[s['id'] for s in downs],
                put_here=['Enter'], substitute_downs=[s['id'] for s in subs],
                confirm=['Enter'])


def build(state_sha=None):
    end = json.loads((SESSION/'end.json').read_text())
    if end['status'] != 'completed' or not end['processes_exited']:
        raise SystemExit('the session did not complete cleanly')
    steps = session_steps()
    binding = replay_binding(steps)
    inputs = flow_keys(steps)

    # the flow screens, screen by screen as shown: the offer names the injury
    # itself, not only the opportunity
    pause = capture_by_id(steps, 'S035-poll-0')
    pause_facts = fact_lines(pause['text'], ('SUBSTITUTION OPPORTUNITY',
                                             'press any key',
                                             'Sherwood INJURED'))
    make_sub = capture_by_id(steps, 'S036-confirm-2')
    if 'MAKE SUBSTITUTION' not in make_sub['text']:
        raise SystemExit('the substitution squad screen is not verified')
    make_sub_facts = fact_lines(make_sub['text'], ('MAKE SUBSTITUTION',))

    walk_names = []
    downs = 0
    while True:
        downs += 1
        sid = f'S037-follow-{downs}'
        if sid not in {s['id'] for s in steps}:
            break
        name, _ = selection(steps, sid)
        if name is None:
            raise SystemExit(f'{sid}: no selected player readable')
        walk_names.append(name)
        if name == INJURED:
            break
    if walk_names[-1] != INJURED:
        raise SystemExit(f'{INJURED} never selected (walk {walk_names})')
    put_here = capture_by_id(steps, 'S038-follow')
    put_here_facts = fact_lines(put_here['text'], ('PUT HERE',))

    # the substitute's position in the SUBS list: the chosen follower must
    # carry the name, and its down count is counted from the recorded steps
    chosen = None
    chosen_down = 0
    for n in range(1, 13):
        sid = f'S039-sub-follow-{n}'
        if sid not in {s['id'] for s in steps}:
            break
        name, step = selection(steps, sid)
        if name in SUBS:
            chosen, chosen_step, chosen_down = name, step, n
            break
    if chosen is None:
        raise SystemExit('no substitute was selected')
    if chosen_down != len(inputs['substitute_downs']):
        raise SystemExit('the substitute down count disagrees with the keys '
                         f'({chosen_down} follows, {len(inputs["substitute_downs"])} Downs)')

    # the bench screen after Escape: the swap is positional - the chosen player
    # in the FIRST TEAM column, the injured player under SUBS, and one fewer
    # remaining substitution
    swap = capture_by_id(steps, 'S041-esc-bench')
    first, subs = squad_sections(swap['text'])
    if chosen not in first:
        raise SystemExit(f'{chosen} is not in the FIRST TEAM column')
    if INJURED not in subs:
        raise SystemExit(f'{INJURED} is not under SUBS')
    if INJURED in first or chosen in subs:
        raise SystemExit('the swap did not move both players')
    remaining_before = int(re.search(r'Remaining subs\s*(\d+)',
                                     capture_by_id(steps, 'S036-follow-1')['text']).group(1))
    remaining_after = int(re.search(r'Remaining subs\s*(\d+)',
                                    swap['text']).group(1))
    if remaining_after != remaining_before - 1:
        raise SystemExit(f'the remaining substitutions did not decrease '
                         f'({remaining_before} -> {remaining_after})')
    swap_facts = fact_lines(swap['text'], ('Remaining subs',))

    full_time = capture_by_id(steps, 'S043-full-time-0')
    full_time_facts = fact_lines(full_time['text'], (
        'BLACKBURN R----│ 5│', 'WIMBLEDON------│ 3│', 'FULL TIME',
        'Sherwood INJURED'))

    # the cash chain: both screens' amounts parse from the committed text and
    # equal the T112 receipt's club funds (the substitution is free)
    cash = capture_by_id(steps, 'S044-walk-3')
    cash_line = next((line for line in cash['text'].splitlines()
                      if 'Club funds' in line), None)
    if cash_line is None:
        raise SystemExit('the cash screen does not carry Club funds')
    cash_funds = digits(cash_line.split('Club funds')[1].split('Overdraft facility')[0])
    management = capture_by_id(steps, 'S044-walk-5')
    management_line = next((line for line in management['text'].splitlines()
                            if re.search(r'[0-9],[0-9]{3}', line)), None)
    if management_line is None:
        raise SystemExit('the management screen does not carry funds')
    management_funds = digits(management_line)
    league_pos = int(re.search(r'LEAGUE POS\.\s*(\d+)', management['text']).group(1))
    t112 = json.loads(T112_RECEIPT.read_text())
    t112_funds = t112['cash']['club_funds']
    if cash_funds != t112_funds or management_funds != t112_funds:
        raise SystemExit(f'the cash chain breaks: T112 has {t112_funds}, '
                         f'the cash screen {cash_funds}, the management screen '
                         f'{management_funds}')
    if league_pos != t112['management']['league_pos']:
        raise SystemExit(f'the league position changed: {league_pos} against '
                         f"T112's {t112['management']['league_pos']}")

    if state_sha is None:
        if not STATE.exists():
            raise SystemExit('the private savestate is missing on the write mode')
        state_sha = sha(STATE.read_bytes())

    return dict(
        schema='injury-sub-receipt-1/2', issue=251, task='T114',
        source_save=dict(path=SOURCE_SAVE.relative_to(ROOT).as_posix(),
                         sha256=sha(SOURCE_SAVE.read_bytes())
                         if SOURCE_SAVE.exists()
                         else 'unverified: the private save is absent'),
        session=dict(directory=SESSION.relative_to(ROOT).as_posix(),
                     session_sha256=sha((SESSION/'session.json').read_bytes()),
                     steps=end['steps'], last_step=end['last_step']),
        replay=binding,
        flow=dict(
            inputs=inputs,
            pause=dict(number=pause['number'], facts=pause_facts),
            make_substitution=dict(number=make_sub['number'],
                                   text_sha256=make_sub['text_sha256'],
                                   facts=make_sub_facts),
            selection_walk=dict(down_count=downs, names=walk_names),
            put_here=dict(number=put_here['number'], facts=put_here_facts),
            chosen=dict(name=chosen, number=chosen_step['number'],
                        downs=chosen_down),
            swap=dict(number=swap['number'], facts=swap_facts,
                      first_team=first, substitutes=subs,
                      remaining_subs=dict(before=remaining_before,
                                          after=remaining_after))),
        full_time=dict(number=full_time['number'], facts=full_time_facts),
        cash_chain=dict(route='runs/T112/week-r0001.json',
                        t112_club_funds=t112_funds,
                        cash_screen_funds=cash_funds,
                        management_funds=management_funds,
                        league_pos=league_pos,
                        cash_fact=cash_line.strip(),
                        management_fact=management_line.strip()),
        savestate=dict(step_id='S045-post-league30-t114',
                       path=STATE.relative_to(ROOT).as_posix(),
                       sha256=state_sha))


def differs(stored, rebuilt, path=''):
    """Recursive comparison; the private-byte digests are skipped when the
    rebuilt values carry the unverifiable sentinel (the private files absent
    on this machine)."""
    if isinstance(stored, dict) and isinstance(rebuilt, dict):
        for key in stored:
            differs(stored[key], rebuilt.get(key), path + '/' + key)
        return
    if stored == rebuilt:
        return
    if isinstance(rebuilt, str) and rebuilt.startswith('unverified'):
        return
    raise SystemExit(f"the receipt's {path or 'root'} differs from the "
                     f're-read session')


def main():
    if '--check' in sys.argv:
        if not RECEIPT.exists():
            raise SystemExit('the receipt does not exist yet')
        stored = json.loads(RECEIPT.read_text())
        if STATE.exists():
            state_sha = sha(STATE.read_bytes())
        else:
            state_sha = ('unverified: the private savestate is absent '
                         f'(the receipt records {stored["savestate"]["sha256"][:12]})')
        differs(stored, build(state_sha))
        print('the injury substitution: ready')
        return 0
    RECEIPT.write_text(json.dumps(build(), indent=1) + '\n')
    print(f'receipt written: {RECEIPT.relative_to(ROOT)}')
    return 0


if __name__ == '__main__':
    sys.exit(main())
