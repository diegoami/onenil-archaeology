"""T101: restore the league preparation state in the emulator harness.

    python3 runs/T101/boot.py            write runs/T101/boot-r0001.json
    python3 runs/T101/boot.py --check    verify the committed receipt

Reads the digest-pinned savestate from the committed T100 receipt, restores it
with the harness's own machine, and authenticates the boundary: release
identity, the recorded preparation screen (digest and text), the projected
campaign and the seed word. No key is delivered and no match is played.
"""
import hashlib
import json
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT/'runtime/emul'))
sys.path.insert(0, str(ROOT/'runtime/driver'))
import campaign_admission as admission  # noqa: E402
import postmatch_tail as tail  # noqa: E402
import week_completion  # noqa: E402

PREPARATION = ROOT/'runs/T100/preparation-r0001.json'
OUT = ROOT/'runs/T101/boot-r0001.json'


def sha(data):
    return hashlib.sha256(data).hexdigest()


def boot(preparation_path=PREPARATION):
    """Restore the captured league machine and return its authenticated facts."""
    receipt = json.loads(Path(preparation_path).read_text())
    if receipt['schema'] != 'league-preparation-receipt/1':
        raise ValueError('the T100 receipt schema differs')
    state = ROOT/receipt['savestate']['path']
    if not state.exists():
        raise ValueError(f'{receipt["savestate"]["path"]} is missing (pull the private state)')
    data = state.read_bytes()
    if sha(data) != receipt['savestate']['sha256']:
        raise ValueError('the savestate digest differs from the T100 receipt')
    files = json.loads((ROOT/'records/T01/inventory.json').read_text())['files']
    release = {row['name']: row['sha256'] for row in files if row['edition'] == '96'}
    week = tail.full.match.Week(data)
    g = week.g
    if {name: sha(value) for name, value in week.files_at_start.items()} != release:
        raise ValueError('wrong original release at the league preparation boot')
    screen = g.screen()
    preparation = receipt['preparation']
    if screen.digest() != preparation['screen_sha256']:
        raise ValueError('the restored screen differs from the captured preparation screen')
    if sha(screen.text().encode()) != preparation['text_sha256']:
        raise ValueError('the restored screen text differs from the captured preparation text')
    names = admission.seed.names(week.files_at_start['ENGL-95.DAT'])
    projected = admission.seed.project(admission.memory_save(g), names)
    clubs = names['clubs']
    fixture = projected['next_fixture']
    if projected['club']['name'] != preparation['managed']:
        raise ValueError('the projected club differs from the preparation screen')
    if projected['cash'] != int(receipt['context']['money'].replace(',', '')):
        raise ValueError('the projected funds differ from the menu screen')
    week_byte = week_completion.decode_week_byte(admission.memory_save(g))
    rows = week_completion.decode_fixture_triples(admission.memory_save(g), 130, weeks=week_byte + 2)
    name_of = lambda club: clubs[club - 1] if club else ''
    # [confirmed:T82/T89 pattern] The original pre-advances its fixture pointer:
    # the prepared match is the row before the live week byte, the live next
    # fixture is the row at it.
    prepared = dict(rows[week_byte - 1], name=name_of(rows[week_byte - 1]['opponent']))
    live = dict(rows[week_byte], name=name_of(rows[week_byte]['opponent']))
    if prepared['name'] != preparation['opponent']:
        raise ValueError('the fixture row before the week byte is not the prepared opponent')
    if prepared['competition'] != 0:
        raise ValueError('the prepared fixture is not the league competition')
    if live['opponent'] != fixture['opponent'] or live['name'] != fixture['opponent_name']:
        raise ValueError('the live next fixture differs from the decoded row at the week byte')
    return dict(receipt=receipt, week=week, g=g, screen=screen, projected=projected, state=state,
                week_byte=week_byte, prepared=prepared, live=live)


def facts(booted):
    receipt, week, g = booted['receipt'], booted['week'], booted['g']
    projected = booted['projected']
    return dict(
        schema='league-boot/1', issue=225, task='T101',
        preparation=dict(receipt='runs/T100/preparation-r0001.json',
                         receipt_sha256=sha(PREPARATION.read_bytes()),
                         state=receipt['savestate']['path'],
                         state_sha256=receipt['savestate']['sha256'],
                         screen_sha256=booted['screen'].digest(),
                         text_sha256=sha(booted['screen'].text().encode())),
        release={name: sha(value) for name, value in sorted(week.files_at_start.items())},
        campaign=dict(club=projected['club']['name'], manager=projected['manager']['name'],
                      season=projected['season'], week_byte=booted['week_byte'],
                      cash=projected['cash'], next_fixture=projected['next_fixture'],
                      prepared_fixture=booted['prepared'],
                      live_fixture=booted['live'],
                      competition=receipt['preparation']['competition'],
                      venue=receipt['context']['venue'].split()[-1]),
        machine=dict(site=g.where(), registers=tail.prior.registers(g),
                     seed_word=g.word_at(g.far(0xDE84)), divisor=g.divisor,
                     draws=week.draws, screen_text=booted['screen'].text()),
        scope='A restored original preparation machine; no key delivered, no match '
              'played, no result claimed. The host clock and seed are uncontrolled.',
    )


def main(argv):
    booted = boot()
    if '--check' in argv:
        committed = json.loads(OUT.read_text())
        if facts(booted) != committed:
            raise ValueError('the committed boot receipt differs from the restored machine')
        print(json.dumps({k: committed[k] for k in ('schema', 'campaign', 'preparation')},
                         indent=2))
        print('league boot: ready')
        return 0
    if OUT.exists():
        raise SystemExit(f'{OUT.relative_to(ROOT)} exists; a new reading is a new file')
    value = facts(booted)
    OUT.parent.mkdir(parents=True, exist_ok=True)
    OUT.write_text(json.dumps(value, indent=2)+'\n')
    print(json.dumps({k: value[k] for k in ('campaign', 'preparation')}, indent=2))
    return 0


if __name__ == '__main__':
    raise SystemExit(main(sys.argv[1:]))
