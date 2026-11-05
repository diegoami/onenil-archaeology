"""Validation protects measured screenshot/action chains rather than reproducing game logic."""
import importlib.util
import json
from pathlib import Path

import pytest

ROOT=Path(__file__).resolve().parents[1]
spec=importlib.util.spec_from_file_location('manual_session',ROOT/'runtime/driver/manual_session.py')
manual=importlib.util.module_from_spec(spec);spec.loader.exec_module(manual)

def fixture(tmp_path):
    manual.write(tmp_path/'session.json',dict(schema='original-ui-session/1',edition='96',game_files=manual.release(),dosbox_version='2024.03.01'))
    previous=None
    for n in range(2):
        data=b'\x89PNG\r\n\x1a\nfixtureIEND\xaeB`\x82';name=f'step-{n:04d}.png'
        (tmp_path/name).write_bytes(data)
        path=tmp_path/f'step-{n:04d}.json'
        manual.write(path,dict(number=n,previous=previous,id=f'S{n+1:03d}',keys=[] if n==0 else ['n'],text='test',text_sha256=manual.sha(b'test'),screenshot=name,screenshot_sha256=manual.sha(data)))
        previous=manual.sha(path.read_bytes())
    manual.write(tmp_path/'end.json',dict(status='completed',processes_exited=True,steps=2,last_step=previous))
    return tmp_path

def test_complete_action_chain(tmp_path):
    assert len(manual.validate(fixture(tmp_path),source=False))==2

@pytest.mark.parametrize('damage',['missing','changed','chain','incomplete','text','traversal','release'])
def test_reject_damaged_evidence(tmp_path,damage):
    directory=fixture(tmp_path)
    if damage=='missing':(directory/'step-0000.png').unlink()
    elif damage=='changed':(directory/'step-0000.png').write_bytes(b'changed')
    else:
        path=directory/('end.json' if damage=='incomplete' else 'session.json' if damage=='release' else 'step-0001.json')
        value=json.loads(path.read_text())
        if damage=='chain':value['previous']='0'*64
        elif damage=='incomplete':value['status']='aborted'
        elif damage=='text':value['text']='changed'
        elif damage=='traversal':value['screenshot']='../outside.png'
        elif damage=='release':value['game_files']={}
        path.write_text(json.dumps(value))
    with pytest.raises((ValueError,FileNotFoundError)):
        manual.validate(directory,source=False)
