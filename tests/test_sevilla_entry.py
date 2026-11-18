"""T89 stage-1 record contract; public, no private save or emulator needed."""
import hashlib
import importlib.util
import json
import subprocess
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
spec = importlib.util.spec_from_file_location(
    'sevilla_entry_tested', ROOT / 'runtime/driver/sevilla_entry.py')
p = importlib.util.module_from_spec(spec)
spec.loader.exec_module(p)
sha = lambda data: hashlib.sha256(data).hexdigest()
encoded = lambda value: json.dumps(value, sort_keys=True, separators=(',', ':')).encode()


def git(*args):
    return subprocess.check_output(['git', '-C', str(ROOT), *args])


def producer_files():
    names = git('ls-tree', '-r', '--name-only', 'HEAD').decode().splitlines()
    return {n: sha(git('show', 'HEAD:' + n)) for n in p.DEPENDENCIES if n in names}


def state():
    return dict(seed=10649, club=130, roster=[2582] * 20, players={'2': {}})


def valid_record():
    menu = dict(name='menu-sevilla', keys=[],
                text='Next opponents  Sevilla  Friendly #2  PLAY NEXT GAME',
                screen_sha256=sha(b'menu-screen'), savestate_sha256=sha(b'menu-savestate'),
                state_sha256=sha(encoded(state())), state=state())
    prep = dict(name='preparation-sevilla', keys=['Return'],
                text='Sevilla away  PLAY GAME',
                screen_sha256=sha(b'prep-screen'), savestate_sha256=sha(b'prep-savestate'),
                state_sha256=sha(encoded(state())), state=state())
    payload = dict(decoded=dict(club=130, week_byte=1,
                                played=dict(week=0, competition=1, opponent=17, flags=65),
                                following=dict(week=1, competition=1, opponent=176, flags=0),
                                reciprocal_played=[1, 130], reciprocal_following=[1, 130]),
                   boot=dict(save_sha256=p.ENTRY_SHA, keys=['y', 'Return']),
                   menu=menu, preparation=prep,
                   savestate=dict(path='.cache/T89/states/sevilla-preparation-r0001.sav',
                                  sha256=sha(b'private-blob'), size=11, at='fixture preparation entry'))
    record = dict(schema=p.ENTRY_SCHEMA, producer='HEAD', producer_files=producer_files(),
                  release=p.release(), dosbox_version=p.driver.WANT_DOSBOX, status='completed',
                  processes_exited=True, entry=dict(path='x', sha256=p.ENTRY_SHA, size=194426),
                  payload=payload, error=None, elapsed_seconds=42.0, driver_events=[],
                  payload_sha256=sha(encoded(payload)))
    record['producer'] = git('rev-parse', 'HEAD').decode().strip()
    return record


def test_valid_record_is_accepted():
    p.validate_record(valid_record())


def test_incomplete_or_foreign_record_refuses():
    for bad in (dict(status='aborted'), dict(schema='other/1'), dict(release={}),
                dict(dosbox_version='0')):
        record = valid_record()
        record.update(bad)
        try:
            p.validate_record(record)
        except ValueError:
            continue
        raise AssertionError('record accepted despite ' + repr(bad))


def test_tampered_payload_refuses():
    for damage in ('boot', 'menu', 'preparation', 'savestate'):
        record = valid_record()
        payload = json.loads(json.dumps(record['payload']))
        if damage == 'boot':
            payload['boot']['save_sha256'] = '0' * 64
        if damage == 'menu':
            payload['menu']['text'] = 'no markers here'
        if damage == 'preparation':
            payload['preparation']['text'] = 'PLAY GAME without the opponent'
        if damage == 'savestate':
            payload['savestate']['path'] = 'records/T89/public.sav'
        record['payload'] = payload
        record['payload_sha256'] = sha(encoded(payload))
        try:
            p.validate_record(record)
        except ValueError:
            continue
        raise AssertionError('payload accepted despite ' + damage)


def test_payload_digest_pin_is_enforced():
    record = valid_record()
    record['payload_sha256'] = sha(b'other')
    try:
        p.validate_record(record)
    except ValueError as e:
        assert 'payload digest' in str(e)
        return
    raise AssertionError('payload digest not enforced')
