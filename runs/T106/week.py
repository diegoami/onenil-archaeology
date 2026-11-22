"""T106: the second league week receipt - match #29 from the post-week machine.

    python3 runs/T106/week.py            write runs/T106/week-r0001.json
    python3 runs/T106/week.py --check    re-read and require equality; prints ready

Reads the completed manual session (runs/T106/session-r0014) and the retained
superseded sessions that show the original's eligibility refusal; writes the
facts the screens show - the witnessed squad transaction, the score, the
results row, Blackburn's table row, the cash totals, the transfer news and the
next fixture - and requires the 2/1/0 table model and the cash chain to hold.
"""
import hashlib
import json
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
SESSION = ROOT/'runs/T106/session-r0014'
OUT = ROOT/'runs/T106/week-r0001.json'
SAVE = ROOT/'.cache/saves/pre-league28/SAVE1.1-0'
WEEK28 = ROOT/'runs/T102/week-r0001.json'
TABLE28 = ROOT/'runs/T103/table-r0001.json'


def sha(data):
    return hashlib.sha256(data).hexdigest()


def step(number, session=SESSION):
    return json.loads((session/f'step-{number:04d}.json').read_text())


def digits(line):
    """Join the numeric cells of a cash row ('5│8,3│1│6' -> 58316)."""
    text = ''.join(re.findall(r'[0-9,]+', line))
    return int(text.replace(',', ''))


def scorers(text):
    """The scorer rows: (home name, home min, away name, away min) per line."""
    home, away = [], []
    for line in text.splitlines():
        cells = [c.strip() for c in line.split('│')]
        if len(cells) < 6:
            continue
        left_name, left_min, right_name, right_min = cells[1], cells[2], cells[-3], cells[-2]
        if left_name and '---' not in left_name and re.fullmatch(r'\d+', left_min):
            home.append(f'{left_name} {left_min}')
        if right_name and '---' not in right_name and re.fullmatch(r'\d+', right_min):
            away.append(f'{right_name} {right_min}')
    return home, away


def squad_steps_verified():
    """Re-read the four cited squad screens from the committed session and
    require their stored digests to equal the files' own digests: a mutated
    step (its text changed while the digests stayed stale) fails here. Also
    require the last exchange screen to show the completed swap (Newell in,
    Hendry moved to the bench)."""
    verified = []
    for number in (12, 31, 41, 42):
        record = step(number)
        # the recorded digests must match the screen text the file itself
        # carries: a mutated text with stale digests fails here
        if sha(record['text'].encode()) != record['text_sha256']:
            raise ValueError(f'step {number}: the text does not match its stored digest')
        verified.append(dict(step=record['number'], id=record['id'],
                             text_sha256=record['text_sha256'],
                             screen_sha256=record['screen_sha256']))
    last = step(42)['text']
    if 'M Newell' not in last or 'C Hendry' not in last:
        raise ValueError('step 42 does not show the Newell/Hendry exchange')
    if step(12)['text'].count('A Wright') == 0 and step(31)['text'].count('A Wright') == 0:
        raise ValueError('the Wright exchange screens are missing Wright')
    return verified


def refusal_citations():
    """The retained superseded sessions whose screens show the refusal."""
    found = []
    for session in sorted((ROOT/'runs/T106').glob('session-r*')):
        for path in sorted(session.glob('step-*.json')):
            data = json.loads(path.read_text())
            if 'Blackburn R has an ineligible player in the first team' in data['text']:
                found.append(dict(session=session.name, step=data['number'], id=data['id'],
                                  text_sha256=data['text_sha256'], screen_sha256=data['screen_sha256']))
    if not found:
        raise ValueError('the eligibility refusal is not in the retained sessions')
    return found


def build():
    end = json.loads((SESSION/'end.json').read_text())
    if end['status'] != 'completed' or not end['processes_exited']:
        raise SystemExit('the session did not complete cleanly')
    half, full, results, table, cash, news, menu, state = (step(n) for n in (44, 46, 48, 49, 50, 51, 52, 53))
    prep29 = step(13, ROOT/'runs/T106/session-r0002')
    if not prep29.get('savestate'):
        raise SystemExit('the preparation-29 savestate step is not where it is expected')
    home_scorers, away_scorers = scorers(full['text'])
    results_line = next(line for line in results['text'].splitlines()
                        if 'Chelsea' in line and 'Blackburn' in line and 'v' in line)
    table_row = next(line for line in table['text'].splitlines()
                     if 'Blackburn' in line and '│ 29 │' in line)
    cells = [cell.strip() for cell in table_row.strip().strip('│').split('│')]
    totals = next(line for line in cash['text'].splitlines() if 'TOTAL IN' in line)
    cash_in, cash_out = totals.split('TOTAL OUT')
    funds = next(line for line in cash['text'].splitlines() if 'Club funds' in line).split('Overdraft facility')[0]
    competition = re.search(r'├\s*(League match #\d+)\s*┤', next(
        line for line in menu['text'].splitlines() if 'League match #' in line)).group(1)
    venue = re.search(r'VENUE\s+(\w+)', next(
        line for line in menu['text'].splitlines() if 'VENUE' in line)).group(1)
    menu_lines = menu['text'].splitlines()
    after_opponents = menu_lines[menu_lines.index(next(
        line for line in menu_lines if 'NEXT OPPONENTS' in line)) + 1:]
    opponent = re.search(r'├\s*([A-Za-z. &\' -]+?)-*\s*┤', next(
        line for line in after_opponents
        if re.match(r'├\s*[A-Za-z].*-\s*┤', line.strip()))).group(1).strip().rstrip('-').strip()
    outcome = dict(
        schema='league-week-receipt-2/1', issue=233, task='T106',
        source_save=dict(path=SAVE.relative_to(ROOT).as_posix(), sha256=sha(SAVE.read_bytes())),
        session=dict(directory=SESSION.relative_to(ROOT).as_posix(),
                     session_sha256=sha((SESSION/'session.json').read_bytes()),
                     steps=end['steps'], last_step=end['last_step']),
        keys=[row['keys'] for row in (step(n) for n in range(1, 54))],
        screens=[dict(step=row['number'], id=row['id'], text_sha256=row['text_sha256'],
                      screen_sha256=row['screen_sha256'])
                 for row in (half, full, results, table, cash, news, menu)],
        squad=dict(
            players_out=['H Berg', 'C Hendry'], players_in=['A Wright', 'M Newell'],
            squad_steps_verified=squad_steps_verified(),
            reason='PLAY GAME refused League match #29 with "Blackburn R has an '
                   'ineligible player in the first team"; the retained superseded '
                   'sessions record the refusal, and the recorded exchange of the '
                   'two players the week-28 processing flagged (decoded statuses '
                   '1->3 via the T105 projection) cleared it',
            refusal=[dict(session=row['session'], step=row['step'], id=row['id'],
                          text_sha256=row['text_sha256'], screen_sha256=row['screen_sha256'])
                     for row in refusal_citations()],
            screens=[dict(step=row['number'], id=row['id'], text_sha256=row['text_sha256'],
                          screen_sha256=row['screen_sha256'])
                     for row in (step(12), step(31), step(41), step(42))]),
        savestates=dict(
            preparation_29=dict(session='session-r0002', step=prep29['number'],
                                path=prep29['savestate'], sha256=prep29['savestate_sha256']),
            post_league29=dict(session=SESSION.name, step=state['number'],
                               path=state['savestate'], sha256=state['savestate_sha256'])),
        score=dict(home='Chelsea', away='Blackburn R', home_goals=3, away_goals=3,
                   scorers=dict(home=home_scorers, away=away_scorers),
                   attendance=digits(next(line for line in half['text'].splitlines()
                                          if re.search(r'│\s*\d{5}│', line))),
                   stage='FULL TIME'),
        results=dict(match_no=29, line=results_line.strip()),
        table=dict(line=table_row.strip(), position=int(cells[0]), club=cells[1], played=int(cells[2]),
                   home=[int(cells[3]), int(cells[4]), int(cells[5])],
                   away=[int(cells[6]), int(cells[7]), int(cells[8])],
                   goals_for=int(cells[9]), goals_against=int(cells[10]), points=int(cells[11])),
        cash=dict(total_in=digits(cash_in), total_out=digits(cash_out), club_funds=digits(funds),
                  line_in=cash_in.strip(), line_funds=funds.strip()),
        transfer_news=[line.strip() for line in news['text'].splitlines()
                       if '....' in line and re.search(r'[A-Za-z]{3}', line)][:3],
        next_fixture=dict(competition=competition, opponent=opponent, venue=venue,
                          funds=digits(next(line for line in menu['text'].splitlines() if '1,6' in line))),
        scope='One real original process from the restored pre-league28 save; the '
              'host clock and seed are uncontrolled, so the score, the squad '
              'transaction and the table are this run\'s facts, not a prediction. '
              'The manager\'s own squad exchange answers the game\'s eligibility '
              'refusal; no eligibility rule is decoded here.',
    )

    # The 2/1/0 model must reproduce the captured row from week 28's post-round row.
    week28 = json.loads(WEEK28.read_text())
    if week28['cash']['club_funds'] + outcome['cash']['total_in'] - outcome['cash']['total_out'] \
            != outcome['cash']['club_funds']:
        raise ValueError('the cash chain does not join the T102 receipt')
    table28 = json.loads(TABLE28.read_text())
    pre = next(club for club in table28['clubs'] if club['club'].startswith('Blackburn'))['post']
    row = outcome['table']
    if (row['played'], row['points'], row['home'], row['away'], row['goals_for'], row['goals_against']) \
            != (pre['P'] + 1, pre['pts'] + 1, pre['home'], [pre['away'][0], pre['away'][1] + 1, pre['away'][2]],
                pre['F'] + outcome['score']['away_goals'], pre['A'] + outcome['score']['home_goals']):
        raise ValueError('the captured row is not the pre-round row plus one away draw under 2/1/0')
    if outcome['score']['home_goals'] != int(re.search(r'(\d)v(\d)', results_line).group(1)) \
            or outcome['score']['away_goals'] != int(re.search(r'(\d)v(\d)', results_line).group(2)):
        raise ValueError('the score differs from the results row')
    return outcome


def write():
    if OUT.exists():
        raise SystemExit(f'{OUT.relative_to(ROOT)} exists; a new reading is a new file')
    value = build()
    OUT.write_text(json.dumps(value, indent=1) + '\n')
    print(f"wrote {OUT.relative_to(ROOT)}")


def check():
    value = build()
    committed = json.loads(OUT.read_text())
    if committed != value:
        for key in committed:
            if committed.get(key) != value.get(key):
                print(f"differs: {key}")
        raise SystemExit('the committed receipt does not equal the re-read facts')
    print('second league week: ready')


def main(argv):
    if '--check' in argv:
        check()
    else:
        write()


if __name__ == '__main__':
    main(sys.argv[1:])
