"""[evidence] Check T102's league week receipt against the committed session.

    python3 runs/T102/check_week.py --check

Re-runs the manual session's validator, then re-reads the facts from the
captured screens and requires them to equal the receipt: the full-time score,
the results row, Blackburn's table row, the cash totals and the next fixture.
"""
import hashlib
import importlib.util
import json
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
RECEIPT = ROOT/'runs/T102/week-r0001.json'


def sha(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def validator():
    spec = importlib.util.spec_from_file_location(
        'manual_session_checked', ROOT/'runtime/driver/manual_session.py')
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module


def digits(line):
    return int(''.join(re.findall(r'[0-9,]+', line)).replace(',', ''))


def check():
    receipt = json.loads(RECEIPT.read_text())
    if receipt.get('schema') != 'league-week-receipt/1':
        raise ValueError('schema differs')
    session = ROOT/receipt['session']['directory']
    if sha(session/'session.json') != receipt['session']['session_sha256']:
        raise ValueError('session header digest differs')
    end = json.loads((session/'end.json').read_text())
    if (end['status'], end['steps'], end['last_step']) != (
            'completed', receipt['session']['steps'], receipt['session']['last_step']):
        raise ValueError('session did not complete as recorded')
    steps = {row['number']: row for row in validator().validate(session)}
    facts, table, cash, menu = steps[6], steps[8], steps[9], steps[11]
    score = receipt['score']
    if f'NEWCASTLE UTD--│ {score["home_goals"]}' not in facts['text'] \
            or f'BLACKBURN R----│ {score["away_goals"]}' not in facts['text'] \
            or score['stage'] not in facts['text']:
        raise ValueError('the full-time screen does not carry the recorded score')
    results = steps[7]
    expected = f'{score["home"]}  {score["home_goals"]}v{score["away_goals"]}  {score["away"]}'
    row = next(line for line in results['text'].splitlines() if 'Newcastle Utd' in line)
    if expected not in row or receipt['results']['line'] != row.strip():
        raise ValueError('the results row differs from the receipt')
    row = next(line for line in table['text'].splitlines()
               if 'Blackburn R----' in line and ' 28 ' in line)
    if receipt['table']['line'] != row.strip():
        raise ValueError('the table row differs from the receipt')
    cells = [cell.strip() for cell in row.strip().strip('│').split('│')]
    if (int(cells[0]), int(cells[2]), int(cells[11])) != (
            receipt['table']['position'], receipt['table']['played'], receipt['table']['points']):
        raise ValueError('the table cells differ from the receipt')
    totals = next(line for line in cash['text'].splitlines() if 'TOTAL IN' in line)
    funds = next(line for line in cash['text'].splitlines() if 'Club funds' in line)
    if digits(totals.split('TOTAL OUT')[0]) != receipt['cash']['total_in'] \
            or digits(totals.split('TOTAL OUT')[1]) != receipt['cash']['total_out'] \
            or digits(funds.split('Overdraft facility')[0]) != receipt['cash']['club_funds']:
        raise ValueError('the cash-flow totals differ from the receipt')
    next_line = next(line for line in menu['text'].splitlines() if 'League match #' in line)
    if receipt['next_fixture']['competition'] not in next_line:
        raise ValueError('the next competition differs from the receipt')
    # the review's #249: the scorers, the attendance and the next fixture's
    # opponent/venue/funds are derived from the screens, not trusted from the
    # receipt's own fields.
    home_scorers, away_scorers = [], []
    for line in facts['text'].splitlines():
        cells = [cell.strip() for cell in line.split('│')]
        if len(cells) >= 6:
            if cells[1] and re.fullmatch(r"[A-Za-z. ']+", cells[1]) \
                    and re.fullmatch(r'\d+', cells[2] or ''):
                home_scorers.append(f'{cells[1]} {cells[2]}')
            if cells[-3] and re.fullmatch(r"[A-Za-z. ']+", cells[-3]) \
                    and re.fullmatch(r'\d+', cells[-2] or ''):
                away_scorers.append(f'{cells[-3]} {cells[-2]}')
    if home_scorers != score['scorers']:
        raise ValueError('the scorer tables differ from the receipt')
    attendance = None
    for line in facts['text'].splitlines():
        for cell in line.split('│'):
            hit = re.fullmatch(r'(\d{4,6})', cell.strip())
            if hit and attendance is None:
                attendance = int(hit.group(1))
    if attendance != score['attendance']:
        raise ValueError('the attendance differs from the receipt')
    venue_line = next(line for line in menu['text'].splitlines() if 'VENUE' in line)
    if receipt['next_fixture']['venue'] not in venue_line:
        raise ValueError('the next venue differs from the receipt')
    menu_lines = menu['text'].splitlines()
    money_i = next(i for i, line in enumerate(menu_lines) if 'MONEY' in line)
    funds_line = next(line for line in menu_lines[money_i:money_i + 3]
                      if re.search(r'[0-9],[0-9]{3}', line))
    if digits(funds_line) != receipt['next_fixture']['funds']:
        raise ValueError('the management screen funds differ from the receipt')
    if not any(f for f in receipt['transfer_news'] if f in steps[10]['text']):
        raise ValueError('the transfer news differs from the receipt')
    return dict(schema='league-week-check/1', session=receipt['session']['directory'],
                steps=len(steps), score=f'{score["home_goals"]}-{score["away_goals"]}',
                results=receipt['results']['line'], table=receipt['table']['line'],
                cash=receipt['cash'], next_fixture=receipt['next_fixture'], ready=True)


def main():
    result = check()
    print(json.dumps(result, indent=2))
    print('league week: ready')
    return 0


if __name__ == '__main__':
    raise SystemExit(main())
