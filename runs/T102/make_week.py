"""T102: the league week route after League match #28.

Reads the completed manual session (runs/T102/session-r0002) and writes
runs/T102/week-r0001.json: the keys delivered, the screens with their digests,
and the facts read off them - the score, the results row, Blackburn's league
table row, the cash-flow totals and the next fixture.
"""
import hashlib
import json
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
SESSION = ROOT/'runs/T102/session-r0002'
OUT = ROOT/'runs/T102/week-r0001.json'
SAVE = ROOT/'.cache/saves/pre-league28/SAVE1.1-0'


def sha(data):
    return hashlib.sha256(data).hexdigest()


def step(number):
    return json.loads((SESSION/f'step-{number:04d}.json').read_text())


def digits(line):
    """Join the numeric cells of a cash-flow row ('1,6|9|1,3|9|3' -> 1691393)."""
    text = ''.join(re.findall(r'[0-9,]+', line))
    return int(text.replace(',', ''))


def main():
    if OUT.exists():
        raise SystemExit(f'{OUT.relative_to(ROOT)} exists; a new reading is a new file')
    end = json.loads((SESSION/'end.json').read_text())
    if end['status'] != 'completed' or not end['processes_exited']:
        raise SystemExit('the session did not complete cleanly')
    half, full, results, table, cash, news, menu = (step(n) for n in (3, 6, 7, 8, 9, 10, 11))
    if '---- FULL TIME ----' not in full['text'] or 'BLACKBURN R----│ 0' not in full['text']:
        raise SystemExit('the full-time screen is not the observed one')
    results_line = next(line for line in results['text'].splitlines()
                        if 'Newcastle Utd' in line and 'Blackburn R----' in line)
    table_row = next(line for line in table['text'].splitlines()
                     if 'Blackburn R----' in line and '│' in line and ' 28 ' in line)
    cells = [cell.strip() for cell in table_row.strip().strip('│').split('│')]
    totals = next(line for line in cash['text'].splitlines() if 'TOTAL IN' in line)
    cash_in, cash_out = totals.split('TOTAL OUT')
    funds = next(line for line in cash['text'].splitlines() if 'Club funds' in line).split('Overdraft facility')[0]
    next_line = next(line for line in menu['text'].splitlines() if 'League match #' in line)
    competition = re.search(r'├\s*(League match #\d+)\s*┤', next_line).group(1)
    outcome = dict(
        schema='league-week-receipt/1', issue=227, task='T102',
        source_save=dict(path=SAVE.relative_to(ROOT).as_posix(), sha256=sha(SAVE.read_bytes())),
        session=dict(directory=SESSION.relative_to(ROOT).as_posix(),
                     session_sha256=sha((SESSION/'session.json').read_bytes()),
                     steps=end['steps'], last_step=end['last_step']),
        keys=[row['keys'] for row in (step(n) for n in range(1, 12))],
        screens=[dict(step=row['number'], id=row['id'], text_sha256=row['text_sha256'],
                      screen_sha256=row['screen_sha256'])
                 for row in (half, full, results, table, cash, news, menu)],
        score=dict(home='Newcastle Utd', away='Blackburn R----', home_goals=2, away_goals=0,
                   scorers=['R Fox 29', 'S Howey 33'], substitutions=['Clark on for Venison',
                                                                     'Watson on for Albert'],
                   attendance=36986, stage='FULL TIME'),
        results=dict(match_no=28, line=results_line.strip()),
        table=dict(line=table_row.strip(), position=int(cells[0]), club=cells[1], played=int(cells[2]),
                   home=[int(cells[3]), int(cells[4]), int(cells[5])],
                   away=[int(cells[6]), int(cells[7]), int(cells[8])],
                   goals_for=int(cells[9]), goals_against=int(cells[10]), points=int(cells[11])),
        cash=dict(total_in=digits(cash_in), total_out=digits(cash_out), club_funds=digits(funds),
                  line_in=cash_in.strip(), line_funds=funds.strip()),
        transfer_news=[line.strip() for line in news['text'].splitlines()
                       if '....' in line][:3],
        next_fixture=dict(competition=competition,
                          opponent=re.search(r'├\s*([A-Za-z. &\']+?)-*\s*┤',
                                             next(line for line in menu['text'].splitlines()
                                                  if 'Chelsea' in line)).group(1).strip(),
                          venue='away', funds=digits(next(line for line in menu['text'].splitlines()
                                                          if '1,6' in line))),
        scope='One real original process from the restored pre-league28 save; the host '
              'clock and seed are uncontrolled, so the score and table are this run\'s '
              'facts, not a prediction. The menu position after the match is recorded '
              'as shown, not interpreted.',
    )
    OUT.write_text(json.dumps(outcome, indent=2)+'\n')
    print(json.dumps({k: outcome[k] for k in ('score', 'results', 'table', 'cash', 'next_fixture')},
                     indent=2))


if __name__ == '__main__':
    main()
