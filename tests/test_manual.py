"""[designed] Reject damaged or incomplete manual capture evidence."""
import copy
import hashlib
import importlib.util
import json
from pathlib import Path
import pytest

ROOT=Path(__file__).resolve().parents[1]
spec=importlib.util.spec_from_file_location('manual',ROOT/'runtime/driver/manual.py')
manual=importlib.util.module_from_spec(spec)
spec.loader.exec_module(manual)

@pytest.fixture
def capture(tmp_path):
    # Real minimal PNG; synthetic validator input, never gameplay evidence.
    import base64
    png=base64.b64decode('iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mNk+A8AAQUBAScY42YAAAAASUVORK5CYII=')
    screens=[]
    for sid,text in [('S001','Do you want to load a saved game'),('S002','PLAY NEXT GAME')]:
        (tmp_path/(sid+'.png')).write_bytes(png)
        screens.append(dict(id=sid,text=text,screenshot=sid+'.png',screenshot_sha256=hashlib.sha256(png).hexdigest(),screen_sha256='a'*64))
    return tmp_path,dict(schema='original-ui-manual/1',status='completed',edition='96',workflow='W001',code_commit='b'*40,source_sha256='c'*64,game_files={'1-0.EXE':'d'*64,'SAVE1.1-0':'e'*64},keys=['y'],screens=screens,dosbox_version='2024.03.01',events=[],processes_exited=True)

def test_complete(capture):
    directory,record=capture
    manual.validate(record,directory,verify_source=False)

@pytest.mark.parametrize('change',['missing','digest','route','keys','traversal','status','game'])
def test_reject(capture,change):
    directory,record=capture;record=copy.deepcopy(record)
    if change=='missing':(directory/'S001.png').unlink()
    if change=='digest':record['screens'][0]['screenshot_sha256']='0'*64
    if change=='route':record['screens'][1]['text']='unknown screen'
    if change=='keys':record['keys']=['n']
    if change=='traversal':record['screens'][0]['screenshot']='../outside.png'
    if change=='status':record['status']='aborted'
    if change=='game':record['game_files']={}
    with pytest.raises((ValueError,OSError)):manual.validate(record,directory,verify_source=False)
