"""[evidence] Check T100's league preparation receipt against the recorded session.

    python3 runs/T100/check_preparation.py [--check]

Verifies the committed session chain and screenshot digests with the manual
session's own validator, the typed preparation facts, and - when the private
bytes are present - the source save and the savestate digests. Exits 0 and
prints ready when the receipt is coherent.
"""
import hashlib
import importlib.util
import json
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
RECEIPT = ROOT/'runs/T100/preparation-r0001.json'


def sha(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def manual_session():
    spec = importlib.util.spec_from_file_location(
        'manual_session_checked', ROOT/'runtime/driver/manual_session.py')
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module


def check(receipt_path=RECEIPT):
    receipt = json.loads(Path(receipt_path).read_text())
    if receipt.get('schema') != 'league-preparation-receipt/1':
        raise ValueError('schema differs')
    session = ROOT/receipt['session']['directory']
    if sha(session/'session.json') != receipt['session']['session_sha256']:
        raise ValueError('session header digest differs')
    end = json.loads((session/'end.json').read_text())
    if end['status'] != 'completed' or not end['processes_exited']:
        raise ValueError('session did not complete cleanly')
    if (end['steps'], end['last_step']) != (receipt['session']['steps'],
                                            receipt['session']['last_step']):
        raise ValueError('session length or chain differs')
    steps = manual_session().validate(session)
    preparation = receipt['preparation']
    step = next(row for row in steps if row['number'] == preparation['step'])
    if (step['text_sha256'], step['screen_sha256']) != (preparation['text_sha256'],
                                                        preparation['screen_sha256']):
        raise ValueError('preparation screen digests differ')
    for name in ('competition', 'opponent', 'managed', 'versus', 'subs'):
        if str(preparation[name]) not in step['text']:
            raise ValueError(f'the preparation screen lacks {name}')
    if preparation['highlighted'] != [row[1] for row in step['highlighted']]:
        raise ValueError('highlighted control differs')
    menu = next(row for row in steps if row['number'] == receipt['context']['step'])
    for name, value in receipt['context'].items():
        if name != 'step' and value not in menu['text']:
            raise ValueError(f'the menu screen lacks {name}')
    if step['savestate'] != receipt['savestate']['path']:
        raise ValueError('savestate step and receipt disagree')
    verified = []
    state = ROOT/receipt['savestate']['path']
    if state.exists():
        if sha(state) != receipt['savestate']['sha256'] or sha(state) != step['savestate_sha256']:
            raise ValueError('savestate digest differs')
        verified.append('savestate')
    save = ROOT/receipt['source_save']['path']
    if save.exists():
        if sha(save) != receipt['source_save']['sha256']:
            raise ValueError('source save digest differs')
        verified.append('source save')
    return dict(schema='league-preparation-check/1', receipt=str(RECEIPT.name),
                session=str(session.relative_to(ROOT)), steps=len(steps),
                competition=preparation['competition'], opponent=preparation['opponent'],
                venue=receipt['context']['venue'].split()[-1],
                savestate=receipt['savestate']['path'], private_verified=verified,
                ready=True)


def main():
    result = check()
    print(json.dumps(result, indent=2))
    print('league preparation: ready' if '--quiet' not in sys.argv else '', end='')
    return 0


if __name__ == '__main__':
    raise SystemExit(main())
