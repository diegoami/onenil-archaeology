"""T112 follow-up: project the post-league30 machine and record that the
league's fixture list ends at slot 30.

    python3 runs/T112/state.py            write runs/T112/state-r0001.json
    python3 runs/T112/state.py --check    re-read and require equality; prints ready

The post-league30 savestate (the private state this task's receipt cites) is
projected through the T105 machinery with the fixture slot left unvalidated:
the game's fixture table has no slot-31 opponent, which is the machine-side
confirmation of the blank NEXT OPPONENTS box the week-30 walk captured.
"""
import hashlib
import json
import struct
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT/'runtime/emul'))
sys.path.insert(0, str(ROOT/'runtime/driver'))
sys.path.insert(0, str(ROOT/'tools/data'))
import campaign_admission as admission  # noqa: E402
import postmatch_tail as tail  # noqa: E402

STATE = ROOT/'.cache/T112/states/post-league30-t112.sav'
OUT = ROOT/'runs/T112/state-r0001.json'


def sha(data):
    return hashlib.sha256(data).hexdigest()


def project():
    data = STATE.read_bytes()
    week = tail.full.match.Week(data)
    names = admission.seed.names(week.files_at_start['ENGL-95.DAT'])
    save = admission.memory_save(week.g)
    b = admission.seed.blocks(save)
    tables = names
    game = b['[DS:D7D2]']
    manager = game[4]
    club = b['DS:DCBA'][manager - 1]
    if not 1 <= manager <= 2 or not 1 <= club <= 176:
        raise ValueError('invalid active manager or club')
    clubrow = b['[DS:D7C2]'][(club - 1) * 62:club * 62]
    first = list(struct.unpack_from('<20H', clubrow))
    reserve = list(struct.unpack_from('<20H', game, manager * 40 + 48))
    week_byte = game[0]
    season_counter = game[1]
    slot = week_byte + 1
    offset = club * 174 + slot * 3 - 177
    raw_slot = list(b['[DS:D7CA]'][offset:offset + 3])
    cash = struct.unpack_from('<i', b['[DS:DCC4]'], (manager - 1) * 94 + 82)[0]
    name_id = struct.unpack_from('<H', game, manager * 2 + 3)[0]
    manager_name = admission.seed.pascal(b['[DS:DCCC]'], name_id * 11, 11)
    identifiers = [p for p in first + reserve if p]
    players = []
    for identifier in sorted(identifiers):
        p8 = b['[DS:D7BA]'][identifier * 8:identifier * 8 + 8]
        p15 = b['[DS:D7BE]'][identifier * 15:identifier * 15 + 15]
        if p8[0] != club:
            raise ValueError('player belongs to a different club')
        initial = chr(b['[DS:D7AA]'][identifier])
        players.append(dict(id=identifier, name=(initial + ' ' + tables['players'][identifier - 1]).strip(),
                            age=p8[1], current_position=p8[6], club_position=p8[7],
                            individual_instructions=p15[10],
                            availability=dict(condition_signed=struct.unpack('b', p15[8:9])[0],
                                              status_bits=p15[11])))
    if raw_slot[1] != 0:
        raise ValueError(f'slot {slot} schedules an opponent: {raw_slot}')
    return dict(
        schema='post-league30-projection/1', task='T112',
        source_state=dict(path=STATE.relative_to(ROOT).as_posix(), sha256=sha(data)),
        week_index=week_byte, season_counter=season_counter,
        manager=dict(slot=manager, name_id=name_id, name=manager_name),
        club=dict(id=club, name=tables['clubs'][club - 1], first_team=first, reserves=reserve),
        cash=cash,
        next_fixture=None,
        fixture_table_end=dict(slot=slot, raw_bytes=raw_slot,
                               observed='the fixture table\'s next slot carries no opponent '
                                        '(opponent byte 0, competition 5): the 16-club league '
                                        'schedule is complete at 30 matches'),
        players=players,
    )


def write():
    if OUT.exists():
        raise SystemExit(f'{OUT.relative_to(ROOT)} exists; a new reading is a new file')
    value = project()
    OUT.write_text(json.dumps(value, indent=1) + '\n')
    print(f"wrote {OUT.relative_to(ROOT)}")


def check():
    value = json.loads(OUT.read_text())
    rebuilt = project()
    if value != rebuilt:
        for key in value:
            if value[key] != rebuilt.get(key):
                raise SystemExit(f'the receipt\'s {key} differs from the re-read state')
        raise SystemExit('the receipt differs from the re-read state')
    print('post-league30 projection: ready')


if __name__ == '__main__':
    if '--check' in sys.argv:
        check()
    else:
        write()
