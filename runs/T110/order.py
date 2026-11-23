"""T110: decode the league table's display order and prove it against the captures.

    python3 runs/T110/order.py --check    verify the committed receipt and print ready

The decode (runs/T110/order-r0001.json) reads the committed listing: the table
is ordered per division of 16 by a quicksort on points and a bubble pass that
orders equal-points neighbours by the signed 8-bit low byte of (F - A), then by
unsigned goals for. This checker re-reads every anchored instruction from the
listing, then requires the decoded comparator to reproduce the captured display
positions - all 16 clubs at week 28 (runs/T105) and, with the round-29 results
derived from the committed screens, all 16 clubs at week 29 (runs/T106).
"""
import json
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
LISTING = ROOT/'static/1-0-exe/code'
RECEIPT = ROOT/'runs/T110/order-r0001.json'
SEED = ROOT/'runs/T105/seed-r0001.json'
RESULTS29 = ROOT/'runs/T106/session-r0014/step-0048.json'
TABLE29 = ROOT/'runs/T106/session-r0014/step-0049.json'


def fail(message):
    print(f'T110: {message}')
    sys.exit(1)


def listing_line(path, offset):
    for line in (LISTING/path).read_text().splitlines():
        parts = re.split(r'\s{2,}', line.strip())
        if parts and parts[0].upper() == offset.upper():
            return parts
    return None


def verify_facts(facts):
    problems = []
    for fact in facts:
        parts = listing_line(fact['file'], fact['offset'])
        if parts is None:
            problems.append(f"{fact['file']}:{fact['offset']} not in the listing")
            continue
        if len(parts) < 2:
            problems.append(f"{fact['file']}:{fact['offset']} has no bytes column")
            continue
        got = ' '.join(parts[1].split())
        want = ' '.join(fact['bytes'].split())
        if got != want:
            problems.append(f"{fact['file']}:{fact['offset']}: bytes {got!r} != receipt {want!r}")
    return problems


def cross_check_layout(receipt):
    """The block layout the checker sorts by must be the one the anchors
    decode: the stride-12 rows whose points byte sits at +1 and whose goal
    columns sit at +8/+10 (the receipt's data_blocks and table facts)."""
    block = receipt.get('data_blocks', {}).get('table', {})
    if block.get('row_stride') != 12 or block.get('clubs') != 176:
        fail("the receipt's table block is not the 176 x 12 rows the listing decodes")
    layout = block.get('layout', [])
    if layout[:2] != ['P:u8', 'PTS:u8'] or layout[8:] != ['F:u16', 'A:u16']:
        fail(f"the receipt's row layout differs: {layout}")


def gd8(row):
    """The comparator's goal difference: the signed 8-bit low byte of F - A."""
    value = (row['F'] - row['A']) & 0xFF
    return value - 256 if value >= 128 else value


def displayed_order(rows):
    """Descending (PTS, GD8, F), the decoded comparator."""
    return sorted(rows, key=lambda row: (row['pts'], gd8(row), row['F']), reverse=True)


def full_ties(rows):
    seen = {}
    for row in rows:
        seen.setdefault((row['pts'], gd8(row), row['F']), []).append(row['club'])
    return {key: names for key, names in seen.items() if len(names) > 1}


def parse_table(text):
    rows = {}
    for line in text.splitlines():
        match = re.match(r'\s*│\s*(\d+)│\s*([^│]+)│\s*(\d+)\s*│\s*(\d+)\s*│\s*(\d+)\s*│\s*(\d+)'
                         r'\s*│\s*(\d+)\s*│\s*(\d+)\s*│\s*(\d+)\s*│\s*(\d+)\s*│\s*(\d+)\s*│\s*(\d+)', line)
        if match:
            club = match.group(2).strip().strip('-').strip()
            rows[club] = dict(position=int(match.group(1)), played=int(match.group(3)),
                              F=int(match.group(10)), A=int(match.group(11)),
                              pts=int(match.group(12)))
    return rows


def parse_results(text):
    pairs = []
    for line in text.splitlines():
        match = re.search(r'-{0,4}([A-Za-z. &\' ]+?)\s+(\d)v(\d)\s+([A-Za-z. &\' -]+?)-*\s*│', line)
        if match:
            pairs.append((match.group(1).strip(), match.group(4).strip(),
                          int(match.group(2)), int(match.group(3))))
    return pairs


def apply_round(rows, pairs):
    """The confirmed 2/1/0 arithmetic (T103): one played week on the decoded rows."""
    moved = {club: dict(row) for club, row in rows.items()}
    for home, away, hg, ag in pairs:
        if home not in moved or away not in moved:
            fail(f'round result names a club the seed does not carry: {home} v {away}')
        moved[home]['played'] += 1
        moved[away]['played'] += 1
        moved[home]['F'] += hg
        moved[home]['A'] += ag
        moved[away]['F'] += ag
        moved[away]['A'] += hg
        moved[home]['pts'] += 2 if hg > ag else 1 if hg == ag else 0
        moved[away]['pts'] += 2 if ag > hg else 1 if ag == hg else 0
    return moved


def main():
    if not RECEIPT.exists():
        fail(f'{RECEIPT.relative_to(ROOT)} does not exist')
    receipt = json.loads(RECEIPT.read_text())
    problems = verify_facts(receipt['facts'])
    if problems:
        fail('the committed listing does not carry the receipt:\n  ' + '\n  '.join(problems))
    if len(receipt['facts']) != 49:
        fail(f"the receipt carries {len(receipt['facts'])} anchored facts, not the 49 the "
             "decode recorded; an emptied or trimmed anchor list is not a verification")
    comparator = receipt.get('comparator', {})
    claim = comparator.get('claim', '')
    if 'signed 8-bit' not in claim or 'F - A' not in claim:
        fail("the receipt's comparator claim does not state the decoded rule "
             "(points, the signed 8-bit low byte of goal difference, goals for)")
    print(f"listing: {len(receipt['facts'])} anchored instructions verified")

    cross_check_layout(receipt)
    seed = json.loads(SEED.read_text())
    week28 = {club['club']: dict(club=club['club'], played=club['post']['P'],
                                 F=club['post']['F'], A=club['post']['A'],
                                 pts=club['post']['pts'], position=club['post']['position'])
              for club in seed['table']['clubs']}
    if len(week28) != 16:
        fail(f'the seed carries {len(week28)} clubs, not 16')
    ties = full_ties(week28.values())
    if ties:
        fail(f'week 28 holds clubs equal in (PTS, GD8, F): {ties}')
    for position, row in enumerate(displayed_order(week28.values()), start=1):
        if row['position'] != position:
            fail(f'week 28: the comparator puts {row["club"]} at {position}, '
                 f'the capture displays {row["position"]}')
    print('week 28: the decoded comparator reproduces all 16 displayed positions '
          '(three points ties, all on goal difference)')

    pairs = parse_results(json.loads(RESULTS29.read_text())['text'])
    if len(pairs) != 8:
        fail(f'the round-29 results screen holds {len(pairs)} rows, not 8')
    week29 = apply_round(week28, pairs)
    table29 = parse_table(json.loads(TABLE29.read_text())['text'])
    if len(table29) != 16:
        fail(f'the week-29 table screen holds {len(table29)} rows, not 16')
    for club, shown in table29.items():
        derived = week29.get(club)
        if derived is None:
            fail(f'the week-29 table names a club the seed does not carry: {club}')
        for field in ('played', 'F', 'A', 'pts'):
            if derived[field] != shown[field]:
                fail(f'week 29 {club}: derived {field}={derived[field]}, '
                     f'the screen shows {shown[field]}')
    ties = full_ties(week29.values())
    if ties:
        fail(f'week 29 holds clubs equal in (PTS, GD8, F): {ties}')
    for position, row in enumerate(displayed_order(week29.values()), start=1):
        if table29[row['club']]['position'] != position:
            fail(f'week 29: the comparator puts {row["club"]} at {position}, '
                 f'the capture displays {table29[row["club"]]["position"]}')
    print('week 29: the round derived from the committed screens reproduces all 16 rows, '
          'and the decoded comparator reproduces all 16 displayed positions '
          '(three further points ties, all on goal difference)')

    print('T110 league table display order: ready')


if __name__ == '__main__':
    if '--check' not in sys.argv:
        print(__doc__)
        sys.exit(2)
    main()
