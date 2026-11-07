#!/usr/bin/env python3
"""T71: sequential original capture/repeat with validated LOCAL git checkpoints. No publisher."""
import argparse
import hashlib
import importlib.util
import json
import os
from pathlib import Path
import re
import signal
import subprocess
import sys
import time

ROOT = Path(__file__).resolve().parents[1]
BRANCH = 'task/T71-edited-full'
LEAF = re.compile(r'(?:start|index|chunk-\d{6}|attempt-\d{4}-(?:start|bounded|finish|verified-\d{6})|repeat-\d{4})\.json')


class Busy(Exception):
    """Writer changed a snapshot; retry without staging anything."""


def git(root, *args):
    return subprocess.check_output(['git', '-C', str(root), *args], text=True).strip()


def snapshot(directory):
    result = {}
    for path in sorted(directory.iterdir()):
        if path.is_symlink() or not path.is_file() or not LEAF.fullmatch(path.name):
            raise ValueError('foreign or symlinked stream leaf: '+path.name)
        raw = path.read_bytes()
        if len(raw) > 16*1024*1024:
            raise ValueError('stream leaf exceeds bound')
        json.loads(raw)
        result[path.name] = dict(size=len(raw), sha256=hashlib.sha256(raw).hexdigest())
    return result


def checkpoint(root, stream, receipts, validate):
    root, stream, receipts = root.resolve(), stream.resolve(), receipts.resolve()
    stream.relative_to(root); receipts.relative_to(root)
    if git(root, 'branch', '--show-current') != BRANCH:
        raise ValueError('checkpoint branch differs')
    if git(root, 'diff', '--cached', '--name-only'):
        raise ValueError('preexisting staged work; checkpoint refused')
    if git(root, 'diff', '--name-only'):
        raise ValueError('tracked files changed; immutable checkpoint refused')
    try:
        before = snapshot(stream)
        verified = validate(stream)
        after = snapshot(stream)
    except (json.JSONDecodeError, FileNotFoundError) as exc:
        raise Busy('writer has an incomplete leaf') from exc
    if before != after:
        raise Busy('writer advanced during verification')
    tracked = set(git(root, 'ls-files', '--', str(stream.relative_to(root))).splitlines())
    new = [stream/name for name in before if str((stream/name).relative_to(root)) not in tracked]
    if not new:
        return None
    receipts.mkdir(parents=True, exist_ok=True)
    number = len(list(receipts.glob('checkpoint-*.json')))+1
    path = receipts/f'checkpoint-{number:06d}.json'
    record = dict(schema='local-edited-capture-checkpoint/1', producer=git(root, 'rev-parse', 'HEAD'),
                  verified=verified, leaves={str(p.relative_to(root)):before[p.name] for p in new})
    with path.open('x') as output:
        json.dump(record, output, indent=2); output.write('\n')
    names = [str(p.relative_to(root)) for p in new+[path]]
    git(root, 'add', '--', *names)
    if set(git(root, 'diff', '--cached', '--name-only').splitlines()) != set(names):
        raise ValueError('index changed concurrently; refusing commit')
    git(root, 'commit', '-m', f'T71: preserve validated local capture checkpoint {number}')
    return dict(commit=git(root, 'rev-parse', 'HEAD'), **record)


def observer():
    sys.path.insert(0, str(ROOT/'runtime/emul'))
    spec = importlib.util.spec_from_file_location('job_edited_observer', ROOT/'runtime/emul/edited_watched.py')
    module = importlib.util.module_from_spec(spec); spec.loader.exec_module(module)
    return module


def validator(module):
    def validate(stream):
        retained = module.check_prefix(stream)
        module.check_bounded(stream, require_repeat=True)
        indexed = (stream/'index.json').exists()
        if indexed:
            module.check(stream, require_repeat=bool(list(stream.glob('repeat-*.json'))))
        for path in stream.glob('attempt-*-finish.json'):
            row = json.loads(path.read_text())
            if row['status'] == 'completed':
                if not indexed:
                    raise Busy('completion index is not yet available')
                # The full checker authenticates indexed and repeated completions.
                index = json.loads((stream/'index.json').read_text())
                accepted = {index['finish']['path']}
                accepted.update(f"attempt-{p.stem.removeprefix('repeat-')}-finish.json" for p in stream.glob('repeat-*.json'))
                if path.name not in accepted:
                    raise Busy('completed repeat receipt is not yet available')
            else:
                required = {'schema','producer','status','error','boundary','ticks','draws','actions','final','result','keys_delivered','unsupported'}
                if set(row) != required or row['schema'] != 'original-edited-watched-finish/1' or row['status'] != 'aborted':
                    raise ValueError('unknown failure receipt')
                if row['boundary'] is not None or not isinstance(row['error'], str) or not 0<len(row['error'])<=4096 or row['unsupported']:
                    raise ValueError('unvalidated failure/services')
                start = json.loads(path.with_name(path.name.replace('-finish.json','-start.json')).read_text())
                if row['producer'] != start['producer']:
                    raise ValueError('failure producer differs')
                for name in ('ticks','draws','actions'):
                    if type(row[name]) is not int or not 0<=row[name]<=2_000_000:
                        raise ValueError('failure cursor outside bound')
                if row['final'] is not None: module.prior.state_check(row['final'])
                if row['result'] != {name:row[name] for name in ('final','ticks','draws','actions')} | {'chunk_payloads':row['result']['chunk_payloads']}:
                    raise ValueError('failure result aliases differ')
                digests = [json.loads(p.read_text())['payload_sha256'] for p in sorted(stream.glob('chunk-*.json'))]
                prefix = row['result']['chunk_payloads']
                if prefix != digests[:len(prefix)] or len(prefix)>len(digests):
                    raise ValueError('failure prefix differs')
                if any(not isinstance(k,list) or len(k)!=2 or k[0] not in module.prior.match.guest.SCAN or k[1]!='24BC:0C58' for k in row['keys_delivered']):
                    raise ValueError('failure key witness differs')
        return dict(retained_prefix=retained, full_index=indexed, repeats=len(list(stream.glob('repeat-*.json'))))
    return validate


def control_write(path, state):
    path.parent.mkdir(parents=True, exist_ok=True)
    temporary = path.with_suffix('.tmp')
    temporary.write_text(json.dumps(state, indent=2)+'\n'); temporary.replace(path)


def main():
    p=argparse.ArgumentParser(description=__doc__)
    p.add_argument('--state',type=Path)
    p.add_argument('--control',type=Path,default=ROOT/'.cache/recovery/T71-job.json')
    p.add_argument('--checkpoint-only',action='store_true')
    args=p.parse_args()
    stream=ROOT/'runs/T70/reference-r0001'; receipts=ROOT/'runs/T71/checkpoints'
    module=observer(); validate=validator(module)
    if args.checkpoint_only:
        print(checkpoint(ROOT,stream,receipts,validate)); return
    if args.state is None:p.error('--state required')
    if git(ROOT,'branch','--show-current')!=BRANCH:raise ValueError('job branch differs')
    state=dict(status='running',phase='initializing',runner_pid=os.getpid(),child_pid=None,observer_log='standard output; redirect to ignored local log')
    child=None
    try:
        if (stream/'index.json').exists() and list(stream.glob('repeat-*.json')):
            module.check(stream,require_repeat=True)
        else:
            for phase,extra in [('original',[]),('repeat',['--repeat'])]:
                state.update(phase=phase);control_write(args.control,state)
                command=[sys.executable,str(ROOT/'runtime/emul/edited_watched.py'),'--run',str(args.state.resolve()),'--directory',str(stream),'--continue-full',*extra]
                child=subprocess.Popen(command,cwd=ROOT)
                state['child_pid']=child.pid;control_write(args.control,state)
                last=time.monotonic()
                while child.poll() is None:
                    if time.monotonic()-last>=600:
                        try:
                            saved=checkpoint(ROOT,stream,receipts,validate)
                            if saved:state['last_checkpoint']=saved['commit']
                            last=time.monotonic();control_write(args.control,state)
                        except Busy as exc:print('checkpoint retry:',exc,flush=True)
                    time.sleep(30)
                if child.returncode:
                    raise RuntimeError(f'{phase} observer exited {child.returncode}')
                checkpoint(ROOT,stream,receipts,validate)
        module.check(stream,require_repeat=True)
        state.update(status='completed',phase='verified',child_pid=None)
    except BaseException as exc:
        if child is not None and child.poll() is None:
            child.send_signal(signal.SIGINT)
            try:child.wait(timeout=30)
            except subprocess.TimeoutExpired:child.kill();child.wait()
        state.update(status='interrupted' if isinstance(exc,KeyboardInterrupt) else 'failed',error=f'{type(exc).__name__}: {exc}',child_pid=None)
        try:checkpoint(ROOT,stream,receipts,validate)
        except Exception as failure:state['checkpoint_error']=str(failure)
        control_write(args.control,state)
        raise
    control_write(args.control,state)


if __name__=='__main__':main()
