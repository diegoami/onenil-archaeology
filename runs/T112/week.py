"""T112: the third league week receipt - match #30 from the post-league29 machine.

    python3 runs/T112/week.py            write runs/T112/week-r0001.json
    python3 runs/T112/week.py --check    re-read and require equality; prints ready

Note (review #245): the superseded sessions' savestate citations share paths
whose bytes later attempts overwrote - their digests preserve the identity of
bytes no longer at those paths.

Reads the completed manual session (runs/T112/session-r0019) and requires the
deterministic replay invariant: every replayed step's screen digest equals the
committed T106 session's corresponding step (the route replays the T106 keys
exactly, so weeks 28 and 29 are re-witnessed per step before week 30 is
played). The receipt records what the screens show - the score with its scorer
tables, the eight round-30 results rows, the full 16-row table with its
displayed positions, the cash chain from the T106 receipt, the transfer news
and the management screen's own next-fixture box - and requires the 2/1/0
table model, the cash chain and the F41 display-order comparator to hold.
"""
import hashlib
import json
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
SESSION = ROOT/'runs/T112/session-r0019'
T106 = ROOT/'runs/T106/session-r0014'
T106_RECEIPT = ROOT/'runs/T106/week-r0001.json'
OUT = ROOT/'runs/T112/week-r0001.json'
SAVE = ROOT/'.cache/saves/pre-league28/SAVE1.1-0'


def sha(data):
    return hashlib.sha256(data).hexdigest()


def step(number, session=SESSION):
    return json.loads((session/f'step-{number:04d}.json').read_text())


def session_steps(session=SESSION, verify_chain=False):
    paths = sorted(session.glob('step-*.json'))
    steps = [json.loads(p.read_text()) for p in paths]
    if verify_chain:
        previous = None
        for path, step in zip(paths, steps):
            if step['previous'] != previous:
                raise ValueError(f'{path.name}: the action chain is broken')
            previous = sha(path.read_bytes())
        end = json.loads((session/'end.json').read_text())
        if end['steps'] != len(steps) or end['last_step'] != previous:
            raise ValueError(f'{session.name}: the end record disagrees with the chain')
    return steps


def digits(line):
    """Join the numeric cells of a cash row ('5│8,3│1│6' -> 58316)."""
    text = ''.join(re.findall(r'[0-9,]+', line))
    return int(text.replace(',', ''))


def parse_table(text):
    """All 16 rows of the league-table screen, in displayed order."""
    rows = []
    for line in text.splitlines():
        match = re.match(r'\s*│\s*(\d+)│\s*([^│]+)│\s*(\d+)\s*│\s*(\d+)\s*│\s*(\d+)\s*│\s*(\d+)'
                         r'\s*│\s*(\d+)\s*│\s*(\d+)\s*│\s*(\d+)\s*│\s*(\d+)\s*│\s*(\d+)\s*│\s*(\d+)', line)
        if match:
            rows.append(dict(position=int(match.group(1)), club=match.group(2).strip().strip('-').strip(),
                             played=int(match.group(3)),
                             home=[int(match.group(4)), int(match.group(5)), int(match.group(6))],
                             away=[int(match.group(7)), int(match.group(8)), int(match.group(9))],
                             goals_for=int(match.group(10)), goals_against=int(match.group(11)),
                             points=int(match.group(12))))
    return rows


def parse_results(text):
    """The eight round rows: (home, home_goals, away_goals, away)."""
    rows = []
    for line in text.splitlines():
        match = re.search(r'([A-Za-z. &\' -]+?)\s+(\d)v(\d)\s+([A-Za-z. &\' -]+?)-*\s*│', line)
        if match and '│' in line:
            rows.append((match.group(1).strip().strip('-').strip(), int(match.group(2)),
                         int(match.group(3)), match.group(4).strip().strip('-').strip()))
    return rows


def parse_scorers(text):
    """The full-time screen's scorer tables: (home scorers, away scorers).
    The two tables are read independently - a home scorer's row can carry an
    empty away cell and the other way round."""
    name = re.fullmatch(r"[A-Za-z. ']+", '')
    def is_name(cell):
        return bool(cell) and re.fullmatch(r"[A-Za-z. ']+", cell) is not None
    home, away = [], []
    for line in text.splitlines():
        cells = [cell.strip() for cell in line.split('│')]
        if len(cells) >= 6:
            if is_name(cells[1]) and re.fullmatch(r'\d+', cells[2] or ''):
                home.append(f"{cells[1]} {cells[2]}")
            if is_name(cells[-3]) and re.fullmatch(r'\d+', cells[-2] or ''):
                away.append(f"{cells[-3]} {cells[-2]}")
    return home, away


def goal_difference_low_byte(row):
    """F41's comparator key: the signed 8-bit low byte of F - A."""
    value = (row['goals_for'] - row['goals_against']) & 0xFF
    return value - 256 if value >= 128 else value


def displayed_order(rows):
    """Descending (points, GD8, goals for), the decoded comparator (F41)."""
    return sorted(rows, key=lambda row: (row['points'], goal_difference_low_byte(row),
                                         row['goals_for']), reverse=True)


def replay_pairs():
    """Align in order: the replayed commands carry the committed T106
    session's own ids, so walking both sessions in step consumes each T106
    replay step against my matching step (catch-up and boot steps, which carry
    their own ids, are skipped)."""
    mine = session_steps(verify_chain=True)
    theirs = session_steps(T106, verify_chain=True)
    replay_theirs = theirs[1:]
    # the control script's boot/load ids differ from T106's own ('S002-y-1'
    # against 'S002-loaded'); the loaded screen is the same committed digest
    replay_theirs[0] = dict(replay_theirs[0], my_id='S002-y-1')
    pairs = []
    t = 0
    for step in mine:
        if t >= len(replay_theirs):
            break
        target = replay_theirs[t]
        expected_id = target.get('my_id', target['id'])
        if step['id'] == expected_id:
            for field in ('screen_sha256', 'keys', 'wait'):
                if step[field] != target[field]:
                    raise ValueError(f'the replay diverges at my step {step["number"]} '
                                     f'({step["id"]}): {field} differs from T106')
            if step['text_sha256'] != target['text_sha256']:
                raise ValueError(f'the replay diverges at my step {step["number"]} '
                                 f'({step["id"]})')
            pairs.append(dict(my_step=step['number'], my_id=step['id'],
                              t106_step=target['number'], t106_id=target['id'],
                              keys=step['keys'], wait=step['wait'],
                              text_sha256=step['text_sha256'],
                              screen_sha256=step['screen_sha256']))
            t += 1
        elif step.get('keys'):
            # a skipped step that sent gameplay input would break the route
            raise ValueError(f'an unmatched step sent gameplay input: my step '
                             f'{step["number"]} ({step["id"]}), keys {step["keys"]}')
    if t != len(replay_theirs):
        raise ValueError(f'the replay covers only {t} of {len(replay_theirs)} T106 steps')
    return pairs, mine, theirs, replay_theirs


def find_step(steps, anchor):
    found = [step for step in steps if anchor in step['text']]
    if not found:
        raise ValueError(f'no screen carries {anchor!r}')
    return found


def build(save_sha=None, post29_sha=None):
    # save_sha / post29_sha: the recorded digests carried by --check when the
    # private bytes are absent on this machine (finding #244); the write mode
    # reads the files and raises when they are missing.
    end = json.loads((SESSION/'end.json').read_text())
    if end['status'] != 'completed' or not end['processes_exited']:
        raise SystemExit('the session did not complete cleanly')
    pairs, steps, theirs, replay_theirs = replay_pairs()
    by_id = {step['id']: step for step in steps}
    full_time_polls = [step for step in steps if step['id'].startswith('S036-full-time-')]
    full = full_time_polls[-1]
    results = by_id['S037-walk-1']
    table = by_id['S037-walk-2']
    cash = by_id['S037-walk-3']
    news = by_id['S037-walk-4']
    menu = by_id['S037-walk-5']
    state = by_id['S039-post-league30-t112']
    kickoff = by_id['S032-kickoff']

    home_scorers, away_scorers = parse_scorers(full['text'])
    result_rows = parse_results(results['text'])
    table_rows = parse_table(table['text'])
    t106 = json.loads(T106_RECEIPT.read_text())

    blackburn_goals = wimbledon_goals = None
    for line in full['text'].splitlines():
        cells = [cell.strip() for cell in line.split('│')]
        if len(cells) >= 3:
            name = cells[1].strip().rstrip('-').strip()
            if name in ('BLACKBURN R', 'WIMBLEDON') and re.fullmatch(r'\d+', cells[2] or ''):
                goals = int(cells[2])
                if name == 'BLACKBURN R':
                    blackburn_goals = goals
                else:
                    wimbledon_goals = goals
    if blackburn_goals is None or wimbledon_goals is None:
        raise ValueError('the full-time pitch does not carry the 5-3 score box')

    total_in = total_out = funds = None
    for line in cash['text'].splitlines():
        if 'TOTAL IN' in line and 'TOTAL OUT' in line:
            left, right = line.split('TOTAL OUT')
            total_in = digits(left.split('TOTAL IN')[1])
            total_out = digits(right)
        if 'Club funds' in line:
            funds = digits(line.split('Club funds')[1].split('Overdraft facility')[0])
    if total_in is None or funds is None:
        raise ValueError('the cash screen does not carry its totals')

    news_rows = [line.strip().strip('│').strip() for line in news['text'].splitlines()
                 if re.search(r'[A-Za-z]{3,}-{2,}', line)]
    league_pos = re.search(r'LEAGUE POS\.\s*(\d+)', menu['text']).group(1)
    menu_funds = digits(next(line for line in menu['text'].splitlines()
                             if re.search(r'[0-9],[0-9]{3}', line)))

    match_no = None
    for line in results['text'].splitlines():
        hit = re.search(r'MATCH NO #(\d+)', line)
        if hit:
            match_no = int(hit.group(1))
    if match_no is None:
        raise ValueError('the results screen does not carry the match number')
    attendance = None
    for line in full['text'].splitlines():
        for cell in line.split('│'):
            hit = re.fullmatch(r'(\d{4,6})', cell.strip())
            if hit and attendance is None:
                attendance = int(hit.group(1))
    if attendance is None:
        raise ValueError('the full-time pitch does not carry the attendance')
    next_opponent_cell = None
    menu_lines = menu['text'].splitlines()
    for i, line in enumerate(menu_lines):
        if 'NEXT OPPONENTS' in line and i + 1 < len(menu_lines):
            next_opponent_cell = menu_lines[i + 1].strip().strip('│').strip()
            break
    if next_opponent_cell is None:
        raise ValueError('the management screen has no NEXT OPPONENTS box')
    next_opponent_blank = not re.search(r'[A-Za-z]{3,}', next_opponent_cell)

    outcome = dict(
        schema='league-week-receipt-3/1', issue=238, task='T112',
        source_save=dict(path=SAVE.relative_to(ROOT).as_posix(),
                         sha256=save_sha if save_sha is not None else sha(SAVE.read_bytes())),
        session=dict(directory=SESSION.relative_to(ROOT).as_posix(),
                     session_sha256=sha((SESSION/'session.json').read_bytes()),
                     steps=end['steps'], last_step=end['last_step']),
        keys=[row['keys'] for row in steps],
        replay=dict(invariant='every replayed step screen digest equals the committed '
                              'T106 session-r0014 step; the route replays the T106 keys '
                              'exactly, so weeks 28 and 29 are re-witnessed per step',
                    t106_session_sha256=sha((T106/'session.json').read_bytes()),
                    pairs=pairs),
        screens=[dict(id=step['id'], step=step['number'], text_sha256=step['text_sha256'],
                      screen_sha256=step['screen_sha256'])
                 for step in (kickoff, full, results, table, cash, news, menu, state)],
        score=dict(home='Blackburn R', away='Wimbledon', home_goals=blackburn_goals,
                   away_goals=wimbledon_goals, scorers=dict(home=home_scorers, away=away_scorers),
                   attendance=attendance, stage='FULL TIME'),
        results=dict(match_no=match_no,
                     rows=[dict(home=home, home_goals=hg, away_goals=ag, away=away)
                           for home, hg, ag, away in result_rows]),
        table=table_rows,
        cash=dict(total_in=total_in, total_out=total_out, club_funds=funds),
        transfer_news=news_rows,
        management=dict(league_pos=int(league_pos), funds=menu_funds,
                        next_opponent_box_blank=next_opponent_blank,
                        next_opponent_cell=next_opponent_cell,
                        observed='the NEXT OPPONENTS box reads blank at P30: the league '
                                 'schedule of 16 clubs is complete at 30 matches'),
        savestates=dict(
            post_league29=dict(session=SESSION.name,
                               path='.cache/T112/states/post-league29-t112.sav',
                               sha256=post29_sha if post29_sha is not None else
                               sha((ROOT/'.cache/T112/states/post-league29-t112.sav').read_bytes())),
            post_league30=dict(session=SESSION.name, step=state['number'],
                               path=state['savestate'], sha256=state['savestate_sha256'])),
        scope='One real original process from the restored pre-league28 save; the '
              'host clock and seed are uncontrolled, so the score, the injury '
              'substitution and the table are this run\'s facts. The route replays '
              'the T106 keys exactly and every replayed screen digest is checked '
              'against the committed T106 session before week 30 is played.',
    )

    # the cash chain must join the T106 receipt
    if t106['cash']['club_funds'] + outcome['cash']['total_in'] - outcome['cash']['total_out'] \
            != outcome['cash']['club_funds']:
        raise ValueError('the cash chain does not join the T106 receipt')

    # Blackburn's row must be the T106 post-row plus one home win under 2/1/0
    pre = t106['table']
    row = next(r for r in table_rows if r['club'].startswith('Blackburn'))
    if (row['played'], row['points'], row['home'], row['away'], row['goals_for'],
        row['goals_against']) != (
            pre['played'] + 1, pre['points'] + 2,
            [pre['home'][0] + 1, pre['home'][1], pre['home'][2]], pre['away'],
            pre['goals_for'] + outcome['score']['home_goals'],
            pre['goals_against'] + outcome['score']['away_goals']):
        raise ValueError('Blackburn\'s row is not the T106 row plus one home win under 2/1/0')
    if outcome['score']['home_goals'] != 5 or outcome['score']['away_goals'] != 3:
        raise ValueError('the score differs from the witnessed 5-3')
    if [row['goals_for'], row['goals_against']] != [68, 41] or row['points'] != 41:
        raise ValueError('Blackburn\'s captured row differs from the screen (P30, 68-41, 41 pts)')

    # the displayed order must equal the F41 comparator over the captured rows
    order = [row['club'] for row in displayed_order(table_rows)]
    shown = [row['club'] for row in sorted(table_rows, key=lambda r: r['position'])]
    if order != shown:
        raise ValueError(f'the F41 comparator does not reproduce the displayed order: {order} vs {shown}')
    if len(table_rows) != 16:
        raise ValueError('the captured table does not hold 16 rows')
    return outcome


def write():
    if not SAVE.exists():
        raise SystemExit(f'{SAVE.relative_to(ROOT)} is missing; the write mode reads it')
    if OUT.exists():
        raise SystemExit(f'{OUT.relative_to(ROOT)} exists; a new reading is a new file')
    value = build()
    OUT.write_text(json.dumps(value, indent=1) + '\n')
    print(f"wrote {OUT.relative_to(ROOT)}")


def check():
    value = json.loads(OUT.read_text())
    save_sha = value['source_save']['sha256'] if SAVE.exists() else None
    post29 = (ROOT/value['savestates']['post_league29']['path'])
    post29_sha = value['savestates']['post_league29']['sha256'] if post29.exists() else None
    if SAVE.exists() and sha(SAVE.read_bytes()) != save_sha:
        raise SystemExit('the private source save differs from the recorded digest')
    if post29.exists() and sha(post29.read_bytes()) != post29_sha:
        raise SystemExit('the private post-league29 savestate differs from the recorded digest')
    rebuilt = build(save_sha=save_sha, post29_sha=post29_sha)
    if value != rebuilt:
        # the receipt is compared field by field to name the first difference
        for key in value:
            if value[key] != rebuilt.get(key):
                raise SystemExit(f'the receipt\'s {key} differs from the re-read session')
        raise SystemExit('the receipt differs from the re-read session')
    print('third league week: ready')


if __name__ == '__main__':
    if '--check' in sys.argv:
        check()
    else:
        write()
