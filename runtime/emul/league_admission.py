#!/usr/bin/env python3
"""T119: the league fixture's preparation input from the T100 machine.

The T100 savestate (sha256 3abfd6b0...) is the match-#28 PLAY GAME preparation
screen; T117 proved the harness decodes it byte-identically. `match_setup.state`
decodes the admission structures (`initial`/`caller`) straight from that memory
image - no guest instruction runs - and `match_setup.admission` projects the
input the native campaign consumes. This publishes that projection, bound to the
T100 receipt and the T105 league seed. Private bytes never enter git.

    python3 runtime/emul/league_admission.py --run <savestate> --record runs/T119/admission-r0002.json
    python3 runtime/emul/league_admission.py --check runs/T119/admission-r0002.json
"""
import argparse
import copy
import hashlib
import importlib.util
import json
import platform
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / 'runtime/emul'))
sys.path.insert(0, str(ROOT / 'tools/data'))
import campaign_admission as admission  # noqa: E402
import league_week  # noqa: E402
import match_setup as setup  # noqa: E402

TOOL = 'runtime/emul/league_admission.py'
STATE_SHA = '3abfd6b00f8024900b93a20d1ff1eec60cfd2d570e927a00eca495d7f7b1d1c8'
T100_RECEIPT = ROOT / 'runs/T100/preparation-r0001.json'
SEED_RECORD = ROOT / 'runs/T105/seed-r0001.json'


def sha(data):
    return hashlib.sha256(data).hexdigest()


def encoded(value):
    return json.dumps(value, sort_keys=True, separators=(',', ':')).encode()


def git(*args):
    return subprocess.check_output(['git', '-C', str(ROOT), *args])


def seed_campaign():
    return json.loads(SEED_RECORD.read_text())['campaign']


def validate_payload(payload):
    if payload['campaign'] != seed_campaign():
        raise ValueError('start campaign differs from the T105 league seed')
    if payload['campaign']['club']['id'] != 130 or payload['campaign']['week_index'] != 54:
        raise ValueError('not the week-54 Blackburn R league machine')
    # [confirmed:T100] The machine's own display setting is Watch off; the
    # admission projection does not depend on it.
    if payload['watch_setting'] != 0:
        raise ValueError('the T100 display setting differs')
    projection = payload['admission']
    if set(projection) != {'players', 'clubs', 'config', 'read_sets', 'legacy'}:
        raise ValueError('admission projection shape differs')
    if {club['id'] for club in projection['clubs']} != {130, 122}:
        raise ValueError('admission clubs are not Blackburn R and Newcastle Utd')
    if len(projection['players']) != 34:
        raise ValueError('admission player census differs')
    seed = seed_campaign()
    original = {v['id']: v for v in seed['players']}
    own = next(club for club in projection['clubs'] if club['id'] == 130)
    if own['roster'] != [v or 0 for v in seed['club']['first_team']]:
        raise ValueError('managed selected roster differs')
    for player in projection['players']:
        if player['id'] in original:
            saved = original[player['id']]
            if (player['p8_6'], player['p8_7'], player['p15_10']) != (
                    saved['current_position'], saved['club_position'],
                    saved['individual_instructions']):
                raise ValueError('managed player position/instruction differs')
    receipt = json.loads(T100_RECEIPT.read_text())
    if payload['state']['screen_sha256'] != receipt['preparation']['screen_sha256']:
        raise ValueError('decoded screen is not the T100 preparation screen')
    if payload['state']['text_sha256'] != receipt['preparation']['text_sha256']:
        raise ValueError('decoded text is not the T100 preparation text')


def validate_record(record):
    if record['schema'] not in ('original-league-admission/1',
                                'original-league-admission/2') or record['status'] != 'completed':
        raise ValueError('incomplete league admission')
    source = record['source']
    receipt = json.loads(T100_RECEIPT.read_text())
    if source['state_sha256'] != STATE_SHA:
        raise ValueError('source savestate identity differs')
    if source['t100_receipt_sha256'] != sha(T100_RECEIPT.read_bytes()):
        raise ValueError('T100 receipt identity differs')
    if source['t105_record_sha256'] != sha(SEED_RECORD.read_bytes()):
        raise ValueError('T105 seed identity differs')
    if source['preparation_screen_sha256'] != receipt['preparation']['screen_sha256']:
        raise ValueError('preparation screen identity differs')
    if source['save_sha256'] != receipt['source_save']['sha256']:
        raise ValueError('source save identity differs')
    release = {p['name']: p['sha256'] for p in
               json.loads((ROOT / 'records/T01/inventory.json').read_text())['files']
               if p['edition'] == '96'}
    if source['release'] != release or record['unsupported']:
        raise ValueError('release/runtime identity differs')
    if sha(encoded(record['payload'])) != record['payload_sha256']:
        raise ValueError('payload digest differs')
    if record['schema'] == 'original-league-admission/2':
        validate_full(record['payload'])
    else:
        validate_payload(record['payload'])


def derive(data):
    """Pure decode: guest instructions never run; the memory image is read."""
    if sha(data) != STATE_SHA:
        raise ValueError('start RAM identity differs')
    week = league_week.LeagueWeek(data)
    require_campaign(admission.seed.project(admission.memory_save(week.g),
                                            admission.seed.names(week.files_at_start['ENGL-95.DAT'])))
    state = setup.state(week)
    screen = week.g.screen()
    return dict(
        campaign=seed_campaign(),
        watch_setting=week.g.mem(week.g.far(0xD7D2) + 0xF2, 1)[0],
        admission=setup.admission(state),
        state=dict(text_sha256=sha(screen.text().encode()), screen_sha256=screen.digest()),
    )


def derive_full(data):
    """The complete decode: admission projection plus the setup state and its
    inputs, as the native import consumes them. Still no guest instruction."""
    payload = derive(data)
    week = league_week.LeagueWeek(data)
    g = week.g
    state = setup.state(week)
    if setup.admission(state) != payload['admission']:
        raise ValueError('the full state and the projection disagree')
    payload['state'] = state
    payload['supplement'] = setup.input_fields(
        g, {'outputs': [{'name': 'admission', 'value': payload['admission']}]})
    payload['income_inputs'] = [setup.income_input(g, club['id'])
                                for club in payload['admission']['clubs']]
    payload['incoming'] = dict(ball_byte6=g.rd(0xCF4C, 1), ball_word7=g.rd(0xCF4D),
                               ball_word9=g.rd(0xCF4F),
                               scores=[g.rd(0xD086, 1), g.rd(0xD087, 1)])
    payload['incoming_fields'] = dict(
        managed_selection_mode=g.mem(g.far(0xD7D2) + 0xF6, 1)[0],
        legacy_income_total=g.rd(0xD6E8, 4),
        legacy_queue_zero=dict(index=0, code=g.rd(0xA52A, 1), first_player=g.rd(0xA52B),
                               second_player=g.rd(0xA52D), side=g.rd(0xA52F, 1)))
    return payload


def validate_full(payload):
    validate_payload(payload)
    if set(payload['state']) != {'initial', 'caller', 'setup_cells'}:
        raise ValueError('full setup state shape differs')
    if setup.admission(payload['state']) != payload['admission']:
        raise ValueError('the state and the admission projection disagree')
    if set(payload['supplement']) != {'capacities', 'start_gate', 'club_factors', 'fixture_factors'}:
        raise ValueError('supplement shape differs')
    if len(payload['income_inputs']) != 2:
        raise ValueError('income inputs differ')
    if set(payload['incoming']) != {'ball_byte6', 'ball_word7', 'ball_word9', 'scores'}:
        raise ValueError('incoming witness differs')
    if set(payload['incoming_fields']) != {'managed_selection_mode', 'legacy_income_total', 'legacy_queue_zero'}:
        raise ValueError('incoming field shape differs')


def require_campaign(value):
    if value != seed_campaign():
        raise ValueError('start campaign differs from the T105 league seed')
    if value['club']['id'] != 130 or value['week_index'] != 54:
        raise ValueError('not the week-54 Blackburn R league machine')


def capture(state_path, out, full=False):
    if out.exists():
        raise ValueError('record path already exists')
    producer_files = [str(p.relative_to(ROOT)) for p in sorted((ROOT / 'runtime/emul').glob('*.py'))]
    producer_files += ['runtime/driver/savestate.py', 'runtime/driver/screens.py',
                       'tools/data/campaign_seed.py', 'tools/data/save.py', 'tools/data/league.py']
    if git('status', '--porcelain', '--', *producer_files).strip():
        raise ValueError('commit observer and dependencies first')
    data = state_path.read_bytes()
    payload = derive_full(data) if full else derive(data)
    validate_full(payload) if full else validate_payload(payload)
    receipt = json.loads(T100_RECEIPT.read_text())
    record = dict(
        schema='original-league-admission/2' if full else 'original-league-admission/1',
        issue=277, task='T119',
        producer=git('rev-parse', 'HEAD').decode().strip(),
        producer_files={name: sha((ROOT / name).read_bytes()) for name in producer_files},
        source=dict(state_sha256=sha(data), state_size=len(data),
                    save_sha256=receipt['source_save']['sha256'],
                    release={p['name']: p['sha256'] for p in
                             json.loads((ROOT / 'records/T01/inventory.json').read_text())['files']
                             if p['edition'] == '96'},
                    t100_receipt_sha256=sha(T100_RECEIPT.read_bytes()),
                    t105_record_sha256=sha(SEED_RECORD.read_bytes()),
                    preparation_screen_sha256=receipt['preparation']['screen_sha256']),
        runtime=dict(python=platform.python_version(), unicorn=__import__('unicorn').__version__),
        status='completed', error=None, payload=payload,
        payload_sha256=sha(encoded(payload)), unsupported=False,
        private_state=state_path.relative_to(ROOT).as_posix() if state_path.is_relative_to(ROOT) else str(state_path),
        scope='The savestate is decoded, not executed: the admission structures '
              'come straight from its memory and the screen equals the T100 '
              'receipt preparation step.',
    )
    out.parent.mkdir(parents=True, exist_ok=True)
    with out.open('x') as handle:
        json.dump(record, handle, indent=2)
        handle.write('\n')
    print('accepted', len(payload['admission']['players']), 'players',
          len(payload['admission']['clubs']), 'clubs', flush=True)


def check(record_path):
    record = json.loads(record_path.read_text())
    validate_record(record)
    saved = record.get('private_state')
    if saved:
        path = ROOT / saved
        if path.exists() and sha(path.read_bytes()) == STATE_SHA:
            rebuilt = (derive_full(path.read_bytes())
                       if record['schema'] == 'original-league-admission/2'
                       else derive(path.read_bytes()))
            if rebuilt != record['payload']:
                raise ValueError('the private savestate no longer yields the recorded projection')
    for corruption in ('roster', 'club', 'position', 'screen'):
        bad = copy.deepcopy(record)
        if corruption == 'roster':
            bad['payload']['admission']['clubs'][0]['roster'][0] = 0
        elif corruption == 'club':
            bad['payload']['admission']['clubs'][1]['id'] = 134
        elif corruption == 'position':
            player = next(row for row in bad['payload']['admission']['players']
                          if row['id'] == 2581)
            player['p8_6'] ^= 1
        else:
            bad['payload']['state']['screen_sha256'] = '0' * 64
        bad['payload_sha256'] = sha(encoded(bad['payload']))
        try:
            validate_record(bad)
        except ValueError:
            pass
        else:
            raise ValueError('corruption accepted: ' + corruption)
    print('the league admission is ready: 4 corruptions rejected')


def main():
    parser = argparse.ArgumentParser()
    group = parser.add_mutually_exclusive_group(required=True)
    group.add_argument('--run', type=Path)
    group.add_argument('--check', type=Path)
    parser.add_argument('--record', type=Path)
    parser.add_argument('--full', action='store_true')
    args = parser.parse_args()
    if args.run:
        if args.record is None:
            parser.error('--run needs --record')
        capture(args.run, args.record, full=args.full)
    else:
        check(args.check)


if __name__ == '__main__':
    main()
