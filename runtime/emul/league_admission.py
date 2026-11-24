#!/usr/bin/env python3
"""T119: the league fixture's preparation input from the T100 machine.

The T100 savestate (sha256 3abfd6b0...) is the match-#28 PLAY GAME preparation
screen. T117 proved the harness decodes it byte-identically. This tool delivers
the one observed PLAY GAME key, runs the original's setup path to the
0AB9:86E9 admission boundary - no match play, no other key - and publishes the
admission projection the native campaign consumes, bound to the T100 receipt
and the T105 league seed. Thesavestate is private and never enters git.

    python3 runtime/emul/league_admission.py --run <savestate> --record runs/T119/admission-r0001.json
    python3 runtime/emul/league_admission.py --check runs/T119/admission-r0001.json
"""
import argparse
import copy
import hashlib
import importlib.util
import json
import platform
import subprocess
import sys
import time
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / 'runtime/emul'))
sys.path.insert(0, str(ROOT / 'tools/data'))
import campaign_admission as admission  # noqa: E402
import league_week  # noqa: E402
import match_setup as setup  # noqa: E402
import watched_complete as watched  # noqa: E402

TOOL = 'runtime/emul/league_admission.py'
STATE_SHA = '3abfd6b00f8024900b93a20d1ff1eec60cfd2d570e927a00eca495d7f7b1d1c8'
T100_RECEIPT = ROOT / 'runs/T100/preparation-r0001.json'
SEED_RECORD = ROOT / 'runs/T105/seed-r0001.json'
SITES = ('0AB9:E24C', '0AB9:E24F', '0AB9:86E9', '0AB9:E2D4', '0AB9:E2D9',
         '0AB9:E2EF', '0AB9:E303', '0AB9:E008', '0AB9:7D86', '0AB9:7DC8', '0AB9:7C67')


def sha(data):
    return hashlib.sha256(data).hexdigest()


def encoded(value):
    return json.dumps(value, sort_keys=True, separators=(',', ':')).encode()


def git(*args):
    return subprocess.check_output(['git', '-C', str(ROOT), *args])


def seed_campaign():
    return json.loads(SEED_RECORD.read_text())['campaign']


def require_campaign(value):
    if value != seed_campaign():
        raise ValueError('start campaign differs from the T105 league seed')
    if value['club']['id'] != 130 or value['week_index'] != 54:
        raise ValueError('not the week-54 Blackburn R league machine')


def validate_payload(payload):
    require_campaign(payload['campaign'])
    if payload['watch_setting'] != 1 or payload['interventions']:
        raise ValueError('unobserved watch/input intervention')
    if payload['fixture_request']['club'] != 130:
        raise ValueError('caller fixture is not the managed club')
    if [point['site'] for point in payload['points']] != list(SITES):
        raise ValueError('boundary census/order differs')
    points = payload['points']
    draws = payload['draws']
    config = points[0]['state']['initial']['config']
    if not draws or draws[0]['seed_before'] != (config[1] * 58 + config[0]) & 65535:
        raise ValueError('selector reseeding alias differs')
    if [d['i'] for d in draws] != list(range(len(draws))):
        raise ValueError('draw cursor differs')
    for before, after in zip(draws, draws[1:]):
        if before['seed_after'] != after['seed_before']:
            raise ValueError('RNG chain differs')
    if points[2]['draw'] - points[0]['draw'] != 255 or points[-1]['draw'] - points[2]['draw'] != 3:
        raise ValueError('original preparation draw census differs')
    for point in points:
        cursor = point['draw']
        if cursor < 0 or cursor > len(draws):
            raise ValueError('boundary draw cursor outside prefix')
        if cursor and point['seed'] != draws[cursor - 1]['seed_after']:
            raise ValueError('boundary seed differs')
        if point['seed'] != point['state']['caller']['seed']:
            raise ValueError('caller seed alias differs')
        clubs = point['state']['caller']['pairing']['context']['rebuild']['outer']['selection']['clubs']
        expected = {130, seed_campaign()['next_fixture']['opponent']}
        if {club['id'] for club in clubs} != expected:
            raise ValueError('selected club aliases differ')
    before = points[2]['state']
    derived = setup.admission(before)
    if derived != payload['selected_admission']:
        raise ValueError('admission projection differs from the actual pre-86E9 state')
    original = {v['id']: v for v in seed_campaign()['players']}
    own = next(c for c in derived['clubs'] if c['id'] == 130)
    if own['roster'] != [v or 0 for v in seed_campaign()['club']['first_team']]:
        raise ValueError('managed selected roster differs')
    for player in derived['players']:
        if player['id'] in original:
            saved = original[player['id']]
            if (player['p8_6'], player['p8_7'], player['p15_10']) != (
                    saved['current_position'], saved['club_position'],
                    saved['individual_instructions']):
                raise ValueError('managed player position/instruction differs')
    watched.state_check(payload['first_entry'])
    if payload['first_entry']['seed'] != points[-1]['seed']:
        raise ValueError('first-entry seed alias differs')
    if len(payload['first_entry']['scenes']) != 22:
        raise ValueError('first-entry player census differs')
    if set(payload['supplement']) != {'capacities', 'start_gate', 'club_factors', 'fixture_factors'}:
        raise ValueError('supplement shape differs')


def validate_record(record):
    if record['schema'] != 'original-league-admission/1' or record['status'] != 'completed':
        raise ValueError('incomplete league admission')
    source = record['source']
    receipt = json.loads(T100_RECEIPT.read_text())
    if source['state_sha256'] != STATE_SHA:
        raise ValueError('source savestate identity differs')
    if source['t100_receipt_sha256'] != sha(T100_RECEIPT.read_bytes()):
        raise ValueError('T100 receipt identity differs')
    if source['t105_record_sha256'] != sha(SEED_RECORD.read_bytes()):
        raise ValueError('T105 seed identity differs')
    if source['receipt_step'] != receipt['preparation']['step']:
        raise ValueError('T100 receipt step differs')
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
    if [key for key, _ in record['keys_delivered'] if key != 'Return']:
        raise ValueError('only the observed PLAY GAME key may be delivered')
    if not record['keys_delivered']:
        raise ValueError('the PLAY GAME key was not delivered')
    validate_payload(record['payload'])


def capture(state, out):
    if out.exists():
        raise ValueError('record path already exists')
    producer_files = [str(p.relative_to(ROOT)) for p in sorted((ROOT / 'runtime/emul').glob('*.py'))]
    producer_files += ['runtime/driver/savestate.py', 'runtime/driver/screens.py',
                       'tools/data/campaign_seed.py', 'tools/data/save.py', 'tools/data/league.py']
    if git('status', '--porcelain', '--', *producer_files).strip():
        raise ValueError('commit observer and dependencies first')
    data = state.read_bytes()
    if sha(data) != STATE_SHA:
        raise ValueError('start RAM identity differs')
    receipt = json.loads(T100_RECEIPT.read_text())
    week = league_week.LeagueWeek(data)
    g = week.g
    names = admission.seed.names(week.files_at_start['ENGL-95.DAT'])
    require_campaign(admission.seed.project(admission.memory_save(g), names))
    watch = g.mem(g.far(0xD7D2) + 0xF2, 1)[0]
    if watch != 1:
        raise ValueError('start RAM does not request watched play')
    payload = dict(campaign=seed_campaign(), watch_setting=watch, interventions=[],
                   fixture_request=None, incoming=None, points=[], draws=[],
                   selected_admission=None, supplement=None, first_entry=None, income_inputs=None)

    class Complete(Exception):
        pass

    def observe(g, site):
        if site == SITES[0]:
            ss = 16 * g.reg('ss')
            bp = g.reg('bp')
            payload['fixture_request'] = dict(week=g.word_at(ss + bp + 4), club=g.word_at(ss + bp + 6))
            payload['incoming'] = dict(ball_byte6=g.rd(0xCF4C, 1), ball_word7=g.rd(0xCF4D),
                                       ball_word9=g.rd(0xCF4F),
                                       scores=[g.rd(0xD086, 1), g.rd(0xD087, 1)])
        current = setup.state(week)
        payload['points'].append(dict(site=site, draw=week.draws, seed=g.word_at(g.far(0xDE84)),
                                      state=current, income_total=g.rd(0xD6E8, 4)))
        if site == '0AB9:86E9':
            payload['selected_admission'] = setup.admission(current)
            payload['income_inputs'] = [setup.income_input(g, club['id'])
                                        for club in payload['selected_admission']['clubs']]
            payload['supplement'] = setup.input_fields(
                g, {'outputs': [{'name': 'admission', 'value': payload['selected_admission']}]})
        if site == SITES[-1]:
            payload['first_entry'] = watched.state(g)
            raise Complete()
        print('league admission boundary', site, 'draw', week.draws, flush=True)

    for site in SITES:
        g.code_hook(site, lambda g, site=site: observe(g, site))
    status = 'completed'
    error = None
    start = time.monotonic()
    try:
        try:
            week.play(on_boundary=lambda w: print('original league boundary', w.screen_i,
                                                  'draws', w.draws, flush=True))
        except Complete:
            pass
        else:
            raise ValueError('original did not reach the first watched entry')
        if g.unsupported:
            raise ValueError('unsupported guest services')
        payload['draws'] = [d for d in week.events if d['kind'] == 'draw']
        validate_payload(payload)
    except (Exception, KeyboardInterrupt) as exc:
        status = 'aborted'
        error = f'{type(exc).__name__}: {exc}'
        payload['draws'] = [d for d in week.events if d['kind'] == 'draw']
    result = dict(
        schema='original-league-admission/1', issue=277, task='T119',
        producer=git('rev-parse', 'HEAD').decode().strip(),
        producer_files={name: sha((ROOT / name).read_bytes()) for name in producer_files},
        source=dict(state_sha256=sha(data), state_size=len(data),
                    save_sha256=receipt['source_save']['sha256'],
                    league_sha256=json.loads(SEED_RECORD.read_text())['campaign']['origin']['league_sha256'],
                    release={p['name']: p['sha256'] for p in
                             json.loads((ROOT / 'records/T01/inventory.json').read_text())['files']
                             if p['edition'] == '96'},
                    t100_receipt_sha256=sha(T100_RECEIPT.read_bytes()),
                    t105_record_sha256=sha(SEED_RECORD.read_bytes()),
                    receipt_step=receipt['preparation']['step'],
                    preparation_screen_sha256=receipt['preparation']['screen_sha256']),
        runtime=dict(python=platform.python_version(), unicorn=__import__('unicorn').__version__),
        elapsed_seconds=time.monotonic() - start,
        status=status, error=error, payload=payload, payload_sha256=sha(encoded(payload)),
        unsupported=g.unsupported, keys_delivered=g.keys_delivered,
        state_path=state.relative_to(ROOT).as_posix() if state.is_relative_to(ROOT) else str(state),
    )
    out.parent.mkdir(parents=True, exist_ok=True)
    with out.open('x') as f:
        json.dump(result, f, indent=2)
        f.write('\n')
    print(status, error or '', len(payload['points']), 'boundaries',
          len(payload['draws']), 'draws', flush=True)
    if status != 'completed':
        raise ValueError(error)


def check(record_path):
    record = json.loads(record_path.read_text())
    validate_record(record)
    receipt = json.loads(T100_RECEIPT.read_text())
    if receipt['source_save']['sha256'] != record['source']['save_sha256']:
        raise ValueError('record and receipt saves differ')
    private = record.get('state_path')
    if private:
        path = ROOT / private
        if path.exists() and sha(path.read_bytes()) == STATE_SHA:
            screen = admission.guest.Guest(path.read_bytes(), files={}).screen()
            if screen.digest() != record['source']['preparation_screen_sha256']:
                raise ValueError('the private savestate no longer decodes to the preparation screen')
    for corruption in ('roster', 'seed', 'draw', 'fixture'):
        bad = copy.deepcopy(record)
        if corruption == 'roster':
            bad['payload']['selected_admission']['clubs'][0]['roster'][0] = 0
        elif corruption == 'seed':
            bad['payload']['points'][-1]['seed'] ^= 1
        elif corruption == 'draw':
            bad['payload']['draws'][0]['seed_after'] ^= 1
        else:
            bad['payload']['fixture_request']['club'] = 134
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
    args = parser.parse_args()
    if args.run:
        if args.record is None:
            parser.error('--run needs --record')
        capture(args.run, args.record)
    else:
        check(args.check)


if __name__ == '__main__':
    main()
