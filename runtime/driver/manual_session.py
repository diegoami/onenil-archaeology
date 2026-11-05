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
    return steps

def run(out):
    sys.path.insert(0,str(ROOT/'runtime/driver'))
    import driver
    import screens
    if git('status','--porcelain','--','runtime/driver').strip():raise ValueError('commit driver source first')
    out.mkdir(parents=True,exist_ok=True)
    n=1
    while (out/f'session-r{n:04d}').exists():n+=1
    directory=out/f'session-r{n:04d}';directory.mkdir()
    d=driver.Driver(workdir=driver.SCRATCH/'manual'/f'{out.name}-{directory.name}')
    write(directory/'session.json',dict(schema='original-ui-session/1',edition='96',game_files=release(),
        code_commit=git('rev-parse','HEAD').decode().strip(),source_sha256=sha(Path(__file__).read_bytes()),
        dosbox_version=driver.require_dosbox() and driver.WANT_DOSBOX,started=driver.host_times()['utc'],
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
            wait=command.get('wait',1),text=text,text_sha256=sha(text.encode()),screen_sha256=screen.digest(),
            highlighted=screens.highlighted(screen),screenshot=image,screenshot_sha256=sha(data),time=driver.host_times()['utc'])
        path=directory/f'step-{number:04d}.json';write(path,step);previous=sha(path.read_bytes());number+=1
        print(json.dumps(dict(directory=str(directory),step=number-1,text=text,highlighted=step['highlighted'])),flush=True)
    try:
        capture(dict(id='S001',keys=[],wait=0),d.launch())
        for line in sys.stdin:
            command=json.loads(line)
            if command.get('finish'):status='completed';break
            if not re.fullmatch(r'S\d{3,}(?:-[a-z0-9-]+)?',command['id']):raise ValueError('screen ID')
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
    parser.add_argument('--check',type=Path);args=parser.parse_args()
    if args.check:
        sessions=[p for p in args.check.glob('session-r*') if (p/'end.json').exists() and json.loads((p/'end.json').read_text())['status']=='completed']
        if not sessions:raise ValueError('no completed sessions')
        steps=[s for p in sessions for s in validate(p)]
        if not any('n' in s['keys'] for s in steps):raise ValueError('missing N route')
        if not any('Please enter name of new game' in s['text'] for s in steps):raise ValueError('missing setup prompt')
        if not any('PLAY NEXT GAME' in s['text'] for s in steps):raise ValueError('missing main menu')
        print(f'{len(sessions)} sessions, {len(steps)} screens verified')
    elif args.run and args.out:run(args.out)
    else:parser.error('choose --run --out PATH or --check PATH')
