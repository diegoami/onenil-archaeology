"""[evidence] T100 milestone 1: the league fixture's preparation savestate.

The manual sessions under runs/T100 boot the original from a restored league
save; session-r0005 answered the load prompt with the `pre-league28` save,
entered PLAY NEXT GAME and saved `league-preparation-0001.sav` at the match
preparation screen (Newcastle Utd versus Blackburn R, League match #28, away).

This writes the receipt; the private savestate stays in .cache.
"""
import hashlib
import json
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
OUT = ROOT/'runs/T100/preparation-r0001.json'
SAVE = ROOT/'.cache/saves/pre-league28/SAVE1.1-0'
SESSION = ROOT/'runs/T100/session-r0005'
STATE = ROOT/'.cache/T100/states/league-preparation-0001.sav'
# What the preparation screen itself shows, and what the menu one step earlier fixes.
FACTS = {'competition': 'League match #28', 'opponent': 'Newcastle Utd', 'managed': 'Blackburn R',
         'versus': 'versus', 'subs': 'Remaining subs 3'}
CONTEXT = {'venue': 'VENUE       away', 'money': '1,045,060', 'season': 'SEASON  1994/95',
           'league_position': 'LEAGUE POS.   2'}


def sha(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def main():
    if OUT.exists():
        raise SystemExit(f'{OUT.relative_to(ROOT)} exists; a new reading is a new file')
    step = json.loads((SESSION/'step-0002.json').read_text())
    end = json.loads((SESSION/'end.json').read_text())
    if end['status'] != 'completed' or not end['processes_exited']:
        raise SystemExit('the session did not complete cleanly')
    if step['savestate'] != str(STATE.relative_to(ROOT)):
        raise SystemExit('the savestate step names another file')
    text = step['text']
    context = json.loads((SESSION/'step-0001.json').read_text())['text']
    missing = [name for name, value in FACTS.items() if str(value) not in text]
    missing += [f'{name} (menu)' for name, value in CONTEXT.items() if value not in context]
    if 'PLAY GAME' not in [row[1] for row in step['highlighted']]:
        missing.append('PLAY GAME highlight')
    if missing:
        raise SystemExit(f'the recorded screens lack {missing}')
    receipt = dict(
        schema='league-preparation-receipt/1', issue=223, task='T100',
        source_save=dict(name='pre-league28', path=SAVE.relative_to(ROOT).as_posix(),
                         sha256=sha(SAVE), bytes=SAVE.stat().st_size),
        session=dict(directory=SESSION.relative_to(ROOT).as_posix(),
                     session_sha256=sha(SESSION/'session.json'),
                     code_commit=json.loads((SESSION/'session.json').read_text())['code_commit'],
                     steps=end['steps'], last_step=end['last_step']),
        preparation=dict(step=step['number'], id=step['id'], text_sha256=step['text_sha256'],
                         screen_sha256=step['screen_sha256'],
                         highlighted=[row[1] for row in step['highlighted']], **FACTS),
        context=dict(step=1, **CONTEXT),
        savestate=dict(path=step['savestate'], sha256=step['savestate_sha256'],
                       bytes=STATE.stat().st_size),
        keys=['y', 'Enter'],
        scope='A real original process booted from a restored league save; the '
              'savestate is the match preparation screen, before PLAY GAME. The '
              'host clock and seed are uncontrolled, and this claims no result.',
    )
    OUT.write_text(json.dumps(receipt, indent=2)+'\n')
    print(json.dumps(receipt, indent=2))


if __name__ == '__main__':
    main()
