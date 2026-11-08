"""Synthetic git/filesystem tests: never execute the original or claim source measurements."""
import importlib.util,json,subprocess
from pathlib import Path
import pytest
ROOT=Path(__file__).resolve().parents[1]
spec=importlib.util.spec_from_file_location('edited_capture_job_test',ROOT/'tools/edited_capture_job.py');module=importlib.util.module_from_spec(spec);spec.loader.exec_module(module)

def command(root,*args):return subprocess.check_output(['git','-C',str(root),*args],text=True)
@pytest.fixture
def repository(tmp_path):
    root=tmp_path/'repo';root.mkdir();command(root,'init','-b',module.BRANCH)
    command(root,'config','user.name','Synthetic test');command(root,'config','user.email','synthetic@example.invalid')
    (root/'base.txt').write_text('owned baseline\n');command(root,'add','base.txt');command(root,'commit','-m','synthetic baseline')
    stream=root/'runs/T70/reference-r0001';stream.mkdir(parents=True)
    (stream/'start.json').write_text('{"schema":"synthetic"}')
    return root,stream,root/'runs/T71/checkpoints'

def validate(stream):
    assert json.loads((stream/'start.json').read_text())=={'schema':'synthetic'}
    return {'retained_prefix':{'ticks':64},'full_index':False}

def test_only_verified_owned_leaves_and_receipt_are_committed(repository):
    root,stream,receipts=repository
    (root/'unrelated.txt').write_text('not owned')
    record=module.checkpoint(root,stream,receipts,validate)
    assert record and record['verified']['retained_prefix']['ticks']==64
    changed=set(command(root,'diff-tree','--no-commit-id','--name-only','-r','HEAD').splitlines())
    assert changed=={'runs/T70/reference-r0001/start.json','runs/T71/checkpoints/checkpoint-000001.json'}
    assert 'unrelated.txt' in command(root,'status','--porcelain')
    assert module.checkpoint(root,stream,receipts,validate) is None

@pytest.mark.parametrize('damage',['branch','staged','tracked','foreign','symlink','partial','invalid'])
def test_checkpoint_refuses_unsafe_or_unverified_input(repository,damage):
    root,stream,receipts=repository;head=command(root,'rev-parse','HEAD')
    if damage=='branch':command(root,'switch','-c','foreign')
    elif damage=='staged':(root/'user.txt').write_text('user');command(root,'add','user.txt')
    elif damage=='tracked':(root/'base.txt').write_text('user change')
    elif damage=='foreign':(stream/'private.sav').write_text('not a decoded leaf')
    elif damage=='symlink':(stream/'chunk-000000.json').symlink_to(root/'base.txt')
    elif damage=='partial':(stream/'chunk-000000.json').write_text('{')
    else:(stream/'start.json').write_text('{"schema":"foreign"}')
    with pytest.raises((ValueError,module.Busy,AssertionError)):module.checkpoint(root,stream,receipts,validate)
    assert command(root,'rev-parse','HEAD')==head
    assert not receipts.exists()

def test_writer_race_leaves_index_and_history_untouched(repository):
    root,stream,receipts=repository;head=command(root,'rev-parse','HEAD')
    def advancing(path):
        result=validate(path);(path/'chunk-000000.json').write_text('{"synthetic":true}');return result
    with pytest.raises(module.Busy):module.checkpoint(root,stream,receipts,advancing)
    assert command(root,'rev-parse','HEAD')==head
    assert not command(root,'diff','--cached','--name-only').strip()
    assert not receipts.exists()

@pytest.mark.parametrize('damage',['none','producer','alias','digest','keys','unsupported','index_pending'])
def test_failure_receipts_are_explicit_and_do_not_claim_completion(tmp_path,damage):
    from types import SimpleNamespace
    (tmp_path/'attempt-0001-start.json').write_text('{"producer":"synthetic"}')
    row=dict(schema='original-edited-watched-finish/1',producer='synthetic',status='aborted',error='KeyboardInterrupt',boundary=None,ticks=0,draws=0,actions=0,final=None,result=dict(chunk_payloads=[],final=None,ticks=0,draws=0,actions=0),keys_delivered=[],unsupported=[])
    if damage=='producer':row['producer']='foreign'
    elif damage=='alias':row['result']['ticks']=1
    elif damage=='digest':row['result']['chunk_payloads']=['0'*64]
    elif damage=='keys':row['keys_delivered']=[['Return','foreign']]
    elif damage=='unsupported':row['unsupported']=['unknown service']
    elif damage=='index_pending':row['status']='completed'
    (tmp_path/'attempt-0001-finish.json').write_text(json.dumps(row))
    fake=SimpleNamespace(check_prefix=lambda p:{'ticks':0},check_bounded=lambda *a,**k:None,prior=SimpleNamespace(state_check=lambda s:None,match=SimpleNamespace(guest=SimpleNamespace(SCAN={'Return':28}))))
    if damage=='none':assert module.validator(fake)(tmp_path)['full_index'] is False
    elif damage=='index_pending':
        with pytest.raises(module.Busy):module.validator(fake)(tmp_path)
    else:
        with pytest.raises(ValueError):module.validator(fake)(tmp_path)

def test_mutable_job_control_uses_complete_atomic_replacement(tmp_path):
    path=tmp_path/'job.json'
    module.control_write(path,{'status':'running'})
    module.control_write(path,{'status':'failed','error':'synthetic'})
    assert json.loads(path.read_text())=={'status':'failed','error':'synthetic'}
    assert not path.with_suffix('.tmp').exists()
