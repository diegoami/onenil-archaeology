#!/usr/bin/env python3
"""[designed] Append-only rendered original UI captures for the illustrated manual.

--run writes a fresh startup/supplied-save route; --check authenticates records.
Original binaries and temporary savestates remain in ignored driver storage.
"""
import argparse
import hashlib
import json
import re
import shutil
import subprocess
import sys
import time
from pathlib import Path

ROOT=Path(__file__).resolve().parents[2]
SCRIPT='runtime/driver/manual.py'

def digest(data):
    return hashlib.sha256(data).hexdigest()

def git(*args):
    return subprocess.check_output(['git','-C',str(ROOT),*args])

def validate(record,directory,verify_source=True):
    def require(ok,message):
        if not ok:raise ValueError(message)
    require(record['schema']=='original-ui-manual/1','schema')
    require(record['status']=='completed' and record['processes_exited'],'incomplete run')
    require(record['edition']=='96' and record['dosbox_version']=='2024.03.01','target/runtime')
    require(record['workflow']=='W001' and record['keys']==['y'],'startup key sequence')
    require(re.fullmatch('[0-9a-f]{40}',record['code_commit']) is not None,'source identity')
    require({'1-0.EXE','SAVE1.1-0'} <= record['game_files'].keys(),'game identities')
    for value in record['game_files'].values():require(re.fullmatch('[0-9a-f]{64}',value) is not None,'game digest')
    screens=record['screens']
    require([s['id'] for s in screens]==['S001','S002'],'route screens')
    require('Do you want to load a saved game' in screens[0]['text'],'startup question')
    require('PLAY NEXT GAME' in screens[1]['text'],'main menu not reached')
    for screen in screens:
        name=Path(screen['screenshot'])
        require(name.name==str(name) and name.suffix=='.png','unsafe screenshot path')
        data=(directory/name).read_bytes()
        require(data.startswith(b'\x89PNG\r\n\x1a\n'),'not a rendered PNG')
        require(digest(data)==screen['screenshot_sha256'],'screenshot digest mismatch')
        require(re.fullmatch('[0-9a-f]{64}',screen['screen_sha256']) is not None,'decoded screen identity')
    if verify_source:
        require(digest(git('show',record['code_commit']+':'+SCRIPT))==record['source_sha256'],'producer identity')
        inventory=json.loads((ROOT/'records/T01/inventory.json').read_text())['files']
        expected={p['name']:p['sha256'] for p in inventory if p['edition']=='96'}
        require(record['game_files']==expected,'release identity mismatch')
    return True

def run(out):
    sys.path.insert(0,str(ROOT/'runtime/driver'))
    import driver
    import screens
    if git('status','--porcelain','--','runtime/driver').strip():
        raise ValueError('commit driver sources before capture')
    out.mkdir(parents=True,exist_ok=True)
    existing=[int(p.name.split('-r')[-1]) for p in out.glob('T41-r*') if re.fullmatch(r'T41-r\d+',p.name)]
    number=max(existing,default=0)+1
    directory=out/f'T41-r{number:04d}';directory.mkdir()
    d=driver.Driver(workdir=driver.SCRATCH/'manual'/directory.name)
    record=dict(schema='original-ui-manual/1',status='aborted',edition='96',workflow='W001',
                code_commit=git('rev-parse','HEAD').decode().strip(),source_sha256=digest(Path(__file__).read_bytes()),
                dosbox_version=driver.require_dosbox() and driver.WANT_DOSBOX,
                game_files={},keys=[],screens=[],started=driver.host_times()['utc'],
                scope='Fresh launch and supplied SAVE1 load only;host clock/seed uncontrolled;no new-game or menu-action coverage.')
    record['game_files']={p['name']:p['sha256'] for p in json.loads(driver.INVENTORY.read_text())['files'] if p['edition']=='96'}
    def capture(sid,sc):
        before=set((d.workdir/'cap').glob('*.png'))
        d._hostkey('p')
        deadline=time.monotonic()+10
        while time.monotonic()<deadline:
            new=set((d.workdir/'cap').glob('*.png'))-before
            if len(new)==1:
                source=new.pop()
                # Emulator has completed its PNG write once bytes stabilize.
                data=source.read_bytes();time.sleep(.2)
                if data==source.read_bytes() and data.endswith(b'IEND\xaeB`\x82'):break
            time.sleep(.1)
        else:raise RuntimeError('rendered screenshot not complete')
        target=directory/(sid+'.png')
        with target.open('xb') as f:f.write(data)
        record['screens'].append(dict(id=sid,text=sc.text(),screen_sha256=sc.digest(),
            screenshot=target.name,screenshot_sha256=digest(data),highlighted=screens.highlighted(sc)))
        print(sid,sc.text(),flush=True)
    try:
        sc=d.launch();capture('S001',sc)
        d.keys('y');record['keys'].append('y');time.sleep(3)
        sc=d.wait_screen(lambda s:'PLAY NEXT GAME' in s.text(),30,'supplied-save main menu')
        capture('S002',sc)
        record['status']='completed'
    except Exception as error:
        record['error']=f'{type(error).__name__}: {error}'
        raise
    finally:
        record['processes_exited']=d.terminate()
        record['events']=d.events;record['ended']=driver.host_times()['utc']
        with (directory/'record.json').open('x') as f:json.dump(record,f,indent=2);f.write('\n')
    validate(record,directory)
    print(directory/'record.json',flush=True)

if __name__=='__main__':
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--run',action='store_true')
    parser.add_argument('--out',type=Path,default=ROOT/'runs/T41')
    parser.add_argument('--check',type=Path)
    args=parser.parse_args()
    if args.check:
        paths=sorted(args.check.glob('T41-r*/record.json'))
        complete=[p for p in paths if json.loads(p.read_text())['status']=='completed']
        if not complete:raise ValueError('no completed original UI capture')
        for path in complete:validate(json.loads(path.read_text()),path.parent)
        print(f'original manual captures: {len(complete)} verified')
    elif args.run:run(args.out)
    else:parser.error('choose --run or --check directory')
