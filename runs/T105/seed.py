"""T105: publish the league campaign seed for the native B6 transaction.

    python3 runs/T105/seed.py            write runs/T105/seed-r0001.json
    python3 runs/T105/seed.py --check    re-project and require equality

Reads the private preparation state and the committed T100/T101/T102/T103
receipts; the output holds decoded values only, never an original byte.
"""
import hashlib
import importlib.util
import json
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT/'runtime/emul'))
sys.path.insert(0, str(ROOT/'runtime/driver'))
sys.path.insert(0, str(ROOT/'tools/data'))
import campaign_admission as admission  # noqa: E402
import postmatch_tail as tail  # noqa: E402
import re  # noqa: E402

PREPARATION = ROOT/'runs/T100/preparation-r0001.json'
BOOT = ROOT/'runs/T101/boot-r0001.json'
WEEK = ROOT/'runs/T102/week-r0001.json'
TABLE = ROOT/'runs/T103/table-r0001.json'
RESULTS = ROOT/'runs/T102/session-r0002/step-0007.json'
OUT = ROOT/'runs/T105/seed-r0001.json'


def sha(data):
    return hashlib.sha256(data).hexdigest()


def captured_results():
    """The eight results the T102 results screen displays, from the committed step."""
    pairs = []
    for line in json.loads(RESULTS.read_text())['text'].splitlines():
        match = re.search(r'-{0,4}([A-Za-z. &\' ]+?)\s+(\d)v(\d)\s+([A-Za-z. &\' -]+?)-*\s*│', line)
        if match:
            pairs.append(dict(home=match.group(1).strip(), away=match.group(4).strip(),
                              home_goals=int(match.group(2)), away_goals=int(match.group(3))))
    if len(pairs) != 8:
        raise ValueError('the captured results screen is incomplete')
    return pairs


def project():
    preparation = json.loads(PREPARATION.read_text())
    state = ROOT/preparation['savestate']['path']
    data = state.read_bytes()
    if sha(data) != preparation['savestate']['sha256']:
        raise ValueError('the savestate digest differs from the T100 receipt')
    week = tail.full.match.Week(data)
    names = admission.seed.names(week.files_at_start['ENGL-95.DAT'])
    memory = admission.memory_save(week.g)
    campaign = admission.seed.project(memory, names)

    boot = json.loads(BOOT.read_text())
    if campaign['week_index'] != boot['campaign']['week_byte']:
        raise ValueError('the projected week differs from the T101 boot fact')
    if campaign['cash'] != boot['campaign']['cash']:
        raise ValueError('the projected funds differ from the T101 boot fact')
    if campaign['next_fixture'] != boot['campaign']['next_fixture']:
        raise ValueError('the projected next fixture differs from the T101 boot fact')
    # [review #248] the table is re-decoded from the restored machine's own
    # memory, independently of the T103 receipt's stored rows: a drift shared
    # between the T103 receipt and this seed fails here.
    table = json.loads(TABLE.read_text())
    table103_spec = importlib.util.spec_from_file_location(
        'table103_checked', ROOT/'runs/T103/table.py')
    table103 = importlib.util.module_from_spec(table103_spec)
    table103_spec.loader.exec_module(table103)
    base = table103.find_table(memory)
    for club in table['clubs']:
        decoded = table103.decode(memory, base, club['id'])
        if decoded != club['pre']:
            raise ValueError(f"the restored state's row for {club['club']} differs "
                             f"from the T103 receipt: {decoded} vs {club['pre']}")

    return preparation, campaign, boot


def seed():
    preparation, campaign, boot = project()
    table = json.loads(TABLE.read_text())
    week = json.loads(WEEK.read_text())
    if boot['campaign']['prepared_fixture']['name'] != week['score']['home']:
        raise ValueError('the prepared fixture differs from the captured match home side')
    value = dict(
        schema='league-campaign-seed/1', issue=231, task='T105',
        source=dict(
            preparation=dict(receipt='runs/T100/preparation-r0001.json',
                             state=preparation['savestate']['path'],
                             state_sha256=preparation['savestate']['sha256']),
            boot=dict(receipt='runs/T101/boot-r0001.json', receipt_sha256=sha(BOOT.read_bytes())),
            week=dict(receipt='runs/T102/week-r0001.json', receipt_sha256=sha(WEEK.read_bytes())),
            table=dict(receipt='runs/T103/table-r0001.json', receipt_sha256=sha(TABLE.read_bytes())),
            results=dict(step='runs/T102/session-r0002/step-0007.json',
                         step_sha256=sha(RESULTS.read_bytes())),
        ),
        campaign=campaign,
        prepared_fixture=boot['campaign']['prepared_fixture'],
        live_fixture=boot['campaign']['live_fixture'],
        table=dict(block=table['block'], clubs=table['clubs']),
        round=dict(match_no=week['results']['match_no'], results=captured_results(),
                   score=week['score'], cash=week['cash']),
        scope='Decoded values from the restored original machine and the committed '
              'captures; no original byte, no new observation, no claim about other '
              'clubs\' future fixtures. The squad is the save\'s own 15 players.',
    )
    return value


def main(argv):
    value = seed()
    if '--check' in argv:
        committed = json.loads(OUT.read_text())
        if value != committed:
            raise ValueError('the committed seed differs from the restored projection')
        print(json.dumps(dict(campaign=committed['campaign']['week_index'],
                              cash=committed['campaign']['cash'],
                              players=len(committed['campaign']['players']),
                              table_rows=len(committed['table']['clubs'])), indent=2))
        print('league seed: ready')
        return 0
    if OUT.exists():
        raise SystemExit(f'{OUT.relative_to(ROOT)} exists; a new reading is a new file')
    OUT.parent.mkdir(parents=True, exist_ok=True)
    OUT.write_text(json.dumps(value, indent=2)+'\n')
    print(json.dumps(dict(week=value['campaign']['week_index'], cash=value['campaign']['cash'],
                          players=len(value['campaign']['players']),
                          prepared=value['prepared_fixture']['name'],
                          live=value['live_fixture']['name'],
                          table_rows=len(value['table']['clubs'])), indent=2))
    return 0


if __name__ == '__main__':
    raise SystemExit(main(sys.argv[1:]))
