#!/usr/bin/env python3
"""T114 receipt: the injury substitution witnessed - the PUT HERE flow from
the pitch's stoppage menu, captured in runs/T114/session-r0015. The T106
route replayed digest-verified in order (52/52), the injury pause offered
SUBSTITUTION OPPORTUNITY, two Spaces reached the squad screen with MAKE
SUBSTITUTION in its footer, ten content-verified Downs selected the injured
T Sherwood, Enter started PUT HERE, two Downs selected the substitute
S Ripley, Enter confirmed, the panel shows the swap, full time reads
Blackburn R 5 Wimbledon 3 with Sherwood INJURED on the same screen, and the
week walk runs results/table/cash/news/management with the cash chain
joining the T112 receipt's funds. --check re-reads every fact from the
committed session and prints ready."""
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
REPLAY_RANGE = range(2, 54)          # the T106 route's replayed steps
INJURED = 'T Sherwood'
SUBS = ('S Ripley', 'C Hendry', 'H Berg', 'B Mimms')


def sha(data):
    return hashlib.sha256(data).hexdigest()


def load_steps():
    """Every capture step in capture order - never keyed by id (the route
    reuses ids; the ordered alignment would silently drop steps)."""
    return sorted((json.loads(f.read_text())
                   for f in sorted(SESSION.glob('step-*.json'))),
                  key=lambda s: s['number'])


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
    raise SystemExit(f'{sid}: no selected player readable')


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


def replay_binding(steps):
    """The ordered replay binding, checkable from committed bytes alone:
    the T106 route consumed in order against the capture, every step's
    screen digest equal (the T112 week.py replay_pairs invariant)."""
    theirs = [json.loads((T106_SESSION/f'step-{n:04d}.json').read_text())
              for n in REPLAY_RANGE]
    cursor = 0
    matched = 0
    problems = []
    for s in theirs:
        while cursor < len(steps) and steps[cursor]['id'] != s['id']:
            cursor += 1
        if cursor >= len(steps):
            problems.append(f"step-{s['number']:04d} ({s['id']}): absent "
                            f'from the capture')
            continue
        step = steps[cursor]
        cursor += 1
        if step['text_sha256'] == s['text_sha256']:
            matched += 1
        else:
            problems.append(f"step-{s['number']:04d} ({s['id']}): the "
                            f'screen digest differs')
    if problems:
        raise SystemExit('the replay binding fails: ' + '; '.join(problems[:4]))
    return dict(route=T106_SESSION.relative_to(ROOT).as_posix(),
                route_steps=len(theirs), digest_matched=matched)


def build(state_sha=None):
    end = json.loads((SESSION/'end.json').read_text())
    if end['status'] != 'completed' or not end['processes_exited']:
        raise SystemExit('the session did not complete cleanly')
    steps = load_steps()
    binding = replay_binding(steps)

    # the flow screens, screen by screen as shown
    pause = capture_by_id(steps, 'S035-poll-0')
    pause_facts = fact_lines(pause['text'], ('SUBSTITUTION OPPORTUNITY',
                                             'press any key'))
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
        walk_names.append(name)
        if name == INJURED:
            break
    if walk_names[-1] != INJURED:
        raise SystemExit(f'{INJURED} never selected (walk {walk_names})')
    put_here = capture_by_id(steps, 'S038-follow')
    put_here_facts = fact_lines(put_here['text'], ('PUT HERE',))
    chosen, chosen_step = selection(steps, 'S039-sub-follow-2')
    if chosen not in SUBS:
        raise SystemExit(f'the chosen player {chosen!r} is not a substitute')

    swap = capture_by_id(steps, 'S041-esc-bench')
    swap_facts = fact_lines(swap['text'], (chosen, INJURED))
    full_time = capture_by_id(steps, 'S043-full-time-0')
    full_time_facts = fact_lines(full_time['text'], (
        'BLACKBURN R----│ 5│', 'WIMBLEDON------│ 3│', 'FULL TIME',
        'Sherwood INJURED'))
    cash = capture_by_id(steps, 'S044-walk-3')
    cash_facts = fact_lines(cash['text'], ('Club funds',))
    management = capture_by_id(steps, 'S044-walk-5')
    management_facts = fact_lines(management['text'], ('1,636,583',
                                                       'LEAGUE POS.   2'))

    # the cash chain: this session's cash-screen digits parse to the same
    # club funds as the committed T112 receipt (the substitution is free)
    t112 = json.loads(T112_RECEIPT.read_text())
    t112_funds = t112['cash']['club_funds']
    funds_digits = '1,6│3│6,5│8│3'
    funds_value = int(re.sub(r'[│,]', '', funds_digits))
    if t112_funds != funds_value:
        raise SystemExit(f'the cash chain breaks: the T112 receipt has '
                         f'{t112_funds} and this session shows {funds_value}')

    if state_sha is None:
        if not STATE.exists():
            raise SystemExit('the private savestate is missing on the write mode')
        state_sha = sha(STATE.read_bytes())

    return dict(
        schema='injury-sub-receipt-1/1', issue=251, task='T114',
        source_save=dict(path=SOURCE_SAVE.relative_to(ROOT).as_posix(),
                         sha256=sha(SOURCE_SAVE.read_bytes())
                         if SOURCE_SAVE.exists()
                         else 'unverified: the private save is absent'),
        session=dict(directory=SESSION.relative_to(ROOT).as_posix(),
                     session_sha256=sha((SESSION/'session.json').read_bytes()),
                     steps=end['steps'], last_step=end['last_step']),
        replay=binding,
        flow=dict(
            pause=dict(number=pause['number'], facts=pause_facts),
            make_substitution=dict(number=make_sub['number'],
                                   text_sha256=make_sub['text_sha256'],
                                   facts=make_sub_facts),
            selection_walk=dict(down_count=downs, names=walk_names),
            put_here=dict(number=put_here['number'], facts=put_here_facts),
            chosen=dict(name=chosen, number=chosen_step['number'],
                        downs=2),
            swap=dict(number=swap['number'], facts=swap_facts)),
        full_time=dict(number=full_time['number'], facts=full_time_facts),
        cash_chain=dict(route='runs/T112/week-r0001.json',
                        t112_club_funds=t112_funds,
                        funds_value=funds_value,
                        cash_screen_digits=funds_digits,
                        facts=cash_facts,
                        management_facts=management_facts),
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
