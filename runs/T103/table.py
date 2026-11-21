"""T103: decode the league table and prove it against the captured round.

    python3 runs/T103/table.py            write runs/T103/table-r0001.json
    python3 runs/T103/table.py --check    verify the committed receipt

The preparation machine stores one 12-byte row per club:
    P u8, PTS u8, HW u8, AW u8, HD u8, AD u8, HL u8, AL u8, F u16, A u16
at base + (club - 1) * 12. Applying the eight results the T102 capture displays
to these pre-round rows must reproduce the captured post-round table exactly.
"""
import hashlib
import json
import re
import struct
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT/'runtime/emul'))
sys.path.insert(0, str(ROOT/'runtime/driver'))
sys.path.insert(0, str(ROOT/'tools/data'))
import campaign_admission as admission  # noqa: E402
import postmatch_tail as tail  # noqa: E402

PREPARATION = ROOT/'runs/T100/preparation-r0001.json'
RESULTS = ROOT/'runs/T102/session-r0002/step-0007.json'
TABLE = ROOT/'runs/T102/session-r0002/step-0008.json'
OUT = ROOT/'runs/T103/table-r0001.json'
STRIDE = 12


def sha(data):
    return hashlib.sha256(data).hexdigest()


def captured_table():
    rows = {}
    for line in json.loads(TABLE.read_text())['text'].splitlines():
        match = re.match(r'\s*│\s*(\d+)│\s*([^│]+)│\s*(\d+)\s*│\s*(\d+)\s*│\s*(\d+)\s*│\s*(\d+)'
                         r'\s*│\s*(\d+)\s*│\s*(\d+)\s*│\s*(\d+)\s*│\s*(\d+)\s*│\s*(\d+)\s*│\s*(\d+)', line)
        if not match:
            continue
        club = match.group(2).strip().strip('-').strip()
        rows[club] = dict(position=int(match.group(1)), P=int(match.group(3)),
                          home=[int(match.group(4)), int(match.group(5)), int(match.group(6))],
                          away=[int(match.group(7)), int(match.group(8)), int(match.group(9))],
                          F=int(match.group(10)), A=int(match.group(11)), pts=int(match.group(12)))
    return rows


def captured_results():
    pairs = {}
    for line in json.loads(RESULTS.read_text())['text'].splitlines():
        match = re.search(r'-{0,4}([A-Za-z. &\' ]+?)\s+(\d)v(\d)\s+([A-Za-z. &\' -]+?)-*\s*│', line)
        if match:
            pairs[(match.group(1).strip(), match.group(4).strip())] = (
                int(match.group(2)), int(match.group(3)))
    return pairs


def restore():
    receipt = json.loads(PREPARATION.read_text())
    state = ROOT/receipt['savestate']['path']
    data = state.read_bytes()
    if sha(data) != receipt['savestate']['sha256']:
        raise ValueError('the savestate digest differs from the T100 receipt')
    week = tail.full.match.Week(data)
    return week, admission.memory_save(week.g)


def find_table(memory):
    """The per-club record array: every row's played count agrees and sums."""
    # Clubs without a league record are all zero; the league clubs share one
    # played count, and every row's home/away columns must sum to it.
    for base in range(0, len(memory) - 176*STRIDE):
        played = set()
        for index in range(176):
            row = memory[base + index*STRIDE: base + (index+1)*STRIDE]
            P, pts, HW, AW, HD, AD, HL, AL = struct.unpack_from('<8B', row)
            if P > 60 or HW+HD+HL + AW+AD+AL != P or pts > 2*P:
                break
            if P:
                played.add(P)
        else:
            if len(played) == 1 and sum(1 for i in range(176)
                                        if memory[base + i*STRIDE]) >= 8:
                return base
    raise ValueError('no per-club record array found')


def decode(memory, base, club_id):
    P, pts, HW, AW, HD, AD, HL, AL, F, A = struct.unpack_from(
        '<8B2H', memory, base + (club_id-1)*STRIDE)
    return dict(played=P, points=pts, home=[HW, HD, HL], away=[AW, AD, AL], F=F, A=A)


def apply_round(rows, results):
    """Two points for a win, one for a draw - the captured table's own arithmetic."""
    after = {club: dict(row, home=list(row['home']), away=list(row['away']))
             for club, row in rows.items()}  # copy the lists: they are mutated below
    for (home, away), (hg, ag) in results.items():
        h, a = after[home], after[away]
        h['F'] += hg; h['A'] += ag; a['F'] += ag; a['A'] += hg
        for row in (h, a):
            row['played'] += 1
        if hg > ag:
            h['points'] += 2; h['home'][0] += 1; a['away'][2] += 1
        elif hg < ag:
            a['points'] += 2; a['away'][0] += 1; h['home'][2] += 1
        else:
            h['points'] += 1; a['points'] += 1
            h['home'][1] += 1; a['away'][1] += 1
    return after


def verify(week, memory):
    names = admission.seed.names(week.files_at_start['ENGL-95.DAT'])['clubs']
    base = find_table(memory)
    post = captured_table()
    results = captured_results()
    if len(post) != 16 or len(results) != 8:
        raise ValueError('the captured round is incomplete')
    pre = {}
    for club in post:
        club_id = names.index(club) + 1
        pre[club] = decode(memory, base, club_id)
    after = apply_round(pre, results)
    def counted(row, played, points):
        return (row[played], row[points], row['home'], row['away'], row['F'], row['A'])
    mismatched = [club for club in post
                  if counted(after[club], 'played', 'points')
                  != counted(post[club], 'P', 'pts')]
    if mismatched:
        raise ValueError(f'the reproduced round differs for {mismatched}')
    return dict(base=base, names=names, post=post, results=results, pre=pre, after=after)


def facts(value):
    week, memory = restore()
    names = value['names']
    return dict(
        schema='league-table/1', issue=229, task='T103',
        state=dict(path=json.loads(PREPARATION.read_text())['savestate']['path'],
                   sha256=sha((ROOT/json.loads(PREPARATION.read_text())['savestate']['path']).read_bytes())),
        block=dict(linear_base=value['base'], stride=STRIDE, clubs=176,
                   layout=['P', 'PTS', 'HW', 'AW', 'HD', 'AD', 'HL', 'AL', 'F:u16', 'A:u16']),
        round=dict(match_no=28,
                   results=[dict(home=home, away=away, home_goals=hg, away_goals=ag)
                            for (home, away), (hg, ag) in value['results'].items()]),
        clubs=[dict(club=club, id=names.index(club)+1,
                    pre=value['pre'][club], post=value['post'][club])
               for club in value['post']],
        reproduction='every one of the 16 rows: applying the eight captured results to '
                     'the decoded pre-round rows equals the captured post-round row',
        points_rule='a win is 2 points and a draw 1 (Newcastle 21 wins + 3 draws = 45)',
        scope='The private preparation machine and the committed T102 screens only; '
              'no ranking tie-break is claimed, and the rows are stored in club-id order.',
    )


def main(argv):
    week, memory = restore()
    value = verify(week, memory)
    if '--check' in argv:
        committed = json.loads(OUT.read_text())
        if facts(value) != committed:
            raise ValueError('the committed receipt differs from the restored table')
        print(json.dumps(dict(block=committed['block'], round=committed['round']),
                         indent=2)[:600])
        print('league table: ready')
        return 0
    if OUT.exists():
        raise SystemExit(f'{OUT.relative_to(ROOT)} exists; a new reading is a new file')
    OUT.parent.mkdir(parents=True, exist_ok=True)
    OUT.write_text(json.dumps(facts(value), indent=2)+'\n')
    print(json.dumps(dict(block=facts(value)['block'], scores=value['post']['Blackburn R']),
                     indent=2))
    return 0


if __name__ == '__main__':
    raise SystemExit(main(sys.argv[1:]))
