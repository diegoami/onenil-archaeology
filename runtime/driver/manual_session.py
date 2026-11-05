#!/usr/bin/env python3
"""Append-only original-game manual sessions; stdin accepts JSON commands.

--run --out runs/T42: {"keys":["n"],"id":"S003","wait":1}
Each command captures an actual rendered screen. {"finish":true} closes cleanly.
"""
import argparse
import hashlib
import json
import re
import subprocess
import sys
import time
from pathlib import Path

ROOT=Path(__file__).resolve().parents[2]
SCRIPT='runtime/driver/manual_session.py'
def sha(data):return hashlib.sha256(data).hexdigest()
def git(*args):return subprocess.check_output(['git','-C',str(ROOT),*args])
def write(path,value):
    with path.open('x') as f:json.dump(value,f,indent=2);f.write('\n')
def release():
    return {p['name']:p['sha256'] for p in json.loads((ROOT/'records/T01/inventory.json').read_text())['files'] if p['edition']=='96'}

def validate(directory,source=True):
    def require(ok,message):
        if not ok:raise ValueError(message)
    header=json.loads((directory/'session.json').read_text())
    end=json.loads((directory/'end.json').read_text())
    require(header['schema']=='original-ui-session/1','schema')
    require(header['edition']=='96' and header['game_files']==release(),'release')
    require(header['dosbox_version']=='2024.03.01','runtime')
    require(end['status']=='completed' and end['processes_exited'],'incomplete session')
    if source:require(sha(git('show',header['code_commit']+':'+SCRIPT))==header['source_sha256'],'producer identity')
    paths=sorted(directory.glob('step-*.json'))
    require(len(paths)==end['steps'] and len(paths)>1,'step count')
    previous=None;steps=[]
    for number,path in enumerate(paths):
        step=json.loads(path.read_text());steps.append(step)
        require(step['number']==number and step['previous']==previous,'broken action chain')
        require(isinstance(step['keys'],list) and all(isinstance(k,str) for k in step['keys']),'keys')
        require(re.fullmatch(r'S\d{3,}(?:-[a-z0-9-]+)?',step['id']) is not None,'screen ID')
        require(sha(step['text'].encode())==step['text_sha256'],'decoded text digest')
        name=step['screenshot'];require(Path(name).name==name and name.endswith('.png'),'screenshot path')
        data=(directory/name).read_bytes()
        require(data.startswith(b'\x89PNG\r\n\x1a\n') and data.endswith(b'IEND\xaeB`\x82'),'PNG')
        require(sha(data)==step['screenshot_sha256'],'screenshot digest')
        previous=sha(path.read_bytes())
    require(previous==end['last_step'],'final chain')
    if header.get('requires_restart'):
        restarts=[(n,s) for n,s in enumerate(steps) if s.get('restart')]
        require(len(restarts)>=1,'missing restart receipt')
        for n,step in restarts:
            receipt=step['restart']
            require(receipt['old_processes_exited'] and receipt['old_pid']!=receipt['new_pid'],'fresh process')
            require(bool(receipt['saved_files']) and receipt['saved_files']==receipt['restored_files'],'restart save hashes')
            for name,digest in receipt['saved_files'].items():
                require(Path(name).name==name and name.lower().endswith('.1-0') and re.fullmatch('[0-9a-f]{64}',digest) is not None,'save identity')
            require(any('F7' in s['keys'] for s in steps[:n]),'missing game save action')
            require(any('y' in s['keys'] for s in steps[n+1:]),'missing game reload action')
            require(any('PLAY NEXT GAME' in s['text'] for s in steps[n+1:]),'reload main menu')
            saved=[s for s in steps[:n] if 'F7' in s['keys']][-1]
            require('GAME NAME:' in saved['text'] and any(s['text']==saved['text'] for s in steps[n+1:]),'reload visible state mismatch')
    return steps

def check_route(steps,route):
    keys=[key for step in steps for key in step['keys']]
    if not keys or keys[0]!=('y' if route=='supplied' else 'n'):
        raise ValueError('missing initial '+('Y' if route=='supplied' else 'N')+' route')
    if not any('PLAY NEXT GAME' in step['text'] for step in steps):
        raise ValueError('missing main menu')
    if route=='setup' and not any('Please enter name of new game' in step['text'] for step in steps):
        raise ValueError('missing setup prompt')


def run(out,persistence=False):
    sys.path.insert(0,str(ROOT/'runtime/driver'))
    import driver
    import screens
    class ManualDriver(driver.Driver):
        def _start_xvfb(self):
            for name,data in getattr(self,'preload_saves',{}).items():
                (self.game_dir/name).write_bytes(data)
            return super()._start_xvfb()
        def _wait_window(self,timeout):
            window=super()._wait_window(timeout)
            # First reads can arrive during BIOS initialization on this host.
            time.sleep(3)
            self.log('manual: waited 3 seconds after window appeared before first savestate')
            return window
    if git('status','--porcelain','--','runtime/driver').strip():raise ValueError('commit driver source first')
    out.mkdir(parents=True,exist_ok=True)
    n=1
    while (out/f'session-r{n:04d}').exists():n+=1
    directory=out/f'session-r{n:04d}';directory.mkdir()
    scratch=Path('/tmp')/f'onenil-manual-{out.name}-{directory.name}'
    if scratch.exists():raise ValueError(f'scratch exists: {scratch}')
    d=ManualDriver(workdir=scratch,game_dir=scratch/'game')
    write(directory/'session.json',dict(schema='original-ui-session/1',edition='96',game_files=release(),
        code_commit=git('rev-parse','HEAD').decode().strip(),source_sha256=sha(Path(__file__).read_bytes()),
        dosbox_version=driver.require_dosbox() and driver.WANT_DOSBOX,started=driver.host_times()['utc'],requires_restart=persistence,
        scope='Fresh original process; host clock and seed uncontrolled; savestate reads and emulator screenshots are observational interventions.'))
    number=0;previous=None;status='aborted';error=None
    def capture(command,screen):
        nonlocal number,previous
        before=set((d.workdir/'cap').glob('*.png'));d._hostkey('p')
        deadline=time.monotonic()+10
        while time.monotonic()<deadline:
            paths=set((d.workdir/'cap').glob('*.png'))-before
            if len(paths)==1:
                path=paths.pop();data=path.read_bytes();time.sleep(.2)
                if data==path.read_bytes() and data.endswith(b'IEND\xaeB`\x82'):break
            time.sleep(.1)
        else:raise RuntimeError('screenshot timeout')
        image=f'step-{number:04d}.png'
        with (directory/image).open('xb') as f:f.write(data)
        text=screen.text()
        step=dict(number=number,previous=previous,id=command['id'],keys=command.get('keys',[]),
            wait=command.get('wait',1),restart=command.get('restart_receipt'),text=text,text_sha256=sha(text.encode()),screen_sha256=screen.digest(),
            highlighted=screens.highlighted(screen),screenshot=image,screenshot_sha256=sha(data),time=driver.host_times()['utc'])
        path=directory/f'step-{number:04d}.json';write(path,step);previous=sha(path.read_bytes());number+=1
        print(json.dumps(dict(directory=str(directory),step=number-1,text=text,highlighted=step['highlighted'])),flush=True)
    try:
        capture(dict(id='S001',keys=[],wait=0),d.launch())
        for line in sys.stdin:
            command=json.loads(line)
            write(directory/f'command-{number:04d}.json',command)
            if command.get('finish'):status='completed';break
            if not re.fullmatch(r'S\d{3,}(?:-[a-z0-9-]+)?',command['id']):raise ValueError('screen ID')
            if command.get('restart'):
                files={p.name:p.read_bytes() for p in d.game_dir.iterdir() if p.suffix.lower()=='.1-0'}
                old_pid=d.dbx.pid;exited=d.terminate()
                if not exited:raise RuntimeError('old processes remain')
                next_scratch=scratch/f'restart-{number}'
                d=ManualDriver(workdir=next_scratch,game_dir=next_scratch/'game')
                d.preload_saves=files
                d.launch()
                source_hashes={name:sha(data) for name,data in files.items()}
                destination_hashes={name:sha((d.game_dir/name).read_bytes()) for name in files}
                command['restart_receipt']=dict(old_pid=old_pid,new_pid=d.dbx.pid,old_processes_exited=exited,
                    saved_files=source_hashes,restored_files=destination_hashes,
                    intervention='Copied only game saves after verified release copy and before new emulator process/mount; no emulator state restored.')
            for key in command.get('keys',[]):
                if key=='F1':raise ValueError('F1 crashes calibrated savestate reader')
                d.keys(key)
            time.sleep(min(max(float(command.get('wait',1)),0),30))
            capture(command,d.screen())
    except Exception as exc:
        error=f'{type(exc).__name__}: {exc}';raise
    finally:
        exited=d.terminate()
        write(directory/'end.json',dict(status=status,processes_exited=exited,error=error,steps=number,last_step=previous,events=d.events,ended=driver.host_times()['utc']))
    validate(directory)

if __name__=='__main__':
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--run',action='store_true');parser.add_argument('--out',type=Path)
    parser.add_argument('--persistence',action='store_true')
    parser.add_argument('--route',choices=['setup','supplied'],default='setup')
    parser.add_argument('--check',type=Path);args=parser.parse_args()
    if args.check:
        sessions=[p for p in args.check.glob('session-r*') if (p/'end.json').exists() and json.loads((p/'end.json').read_text())['status']=='completed']
        if not sessions:raise ValueError('no completed sessions')
        steps=[s for p in sessions for s in validate(p)]
        check_route(steps,args.route)
        print(f'{len(sessions)} sessions, {len(steps)} screens verified')
    elif args.run and args.out:run(args.out,args.persistence)
    else:parser.error('choose --run --out PATH or --check PATH')
