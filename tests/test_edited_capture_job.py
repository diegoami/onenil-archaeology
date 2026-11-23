"""Synthetic git/filesystem tests: never execute the original or claim source measurements."""
import argparse,importlib.util,json,subprocess,sys,types
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

class Child:
    """A synthetic observer process: running for `polls` polls, then exited."""
    pid = 424242
    def __init__(self,polls,returncode=0):self.polls,self.returncode=polls,returncode
    def poll(self):
        if self.polls:self.polls-=1;return None
        return self.returncode
    def send_signal(self,signal):pass
    def wait(self,timeout=None):return self.returncode
    def kill(self):pass

def test_terminal_checkpoint_supersedes_the_periodic_pointer(repository,tmp_path):
    # #188: the terminal checkpoint's commit, not an older periodic one, ends in control state.
    root,stream,receipts=repository;control=tmp_path/'control.json';state={'status':'running'}
    def save():
        leaf=stream/f'chunk-{len(list(stream.glob("chunk-*.json"))):06d}.json';leaf.write_text('{"synthetic":true}')
        return module.checkpoint(root,stream,receipts,validate)
    ticks=iter(range(0,10_000,600))
    code=module.supervise(Child(2),state,save,control,interval=600,poll=0,clock=lambda:next(ticks),sleep=lambda s:None)
    assert code==0
    periodic=state['last_checkpoint']
    assert json.loads(control.read_text())['last_checkpoint']==periodic
    terminal=module.remember(state,save())
    assert terminal['commit']!=periodic
    assert state['last_checkpoint']==terminal['commit']==command(root,'rev-parse','HEAD').strip()

def test_remember_keeps_the_pointer_when_nothing_new_was_committed():
    state={'last_checkpoint':'a'*40}
    assert module.remember(state,None) is None
    assert state=={'last_checkpoint':'a'*40}

def test_supervise_retries_busy_checkpoints_and_reports_the_exit_code(tmp_path):
    state={};calls=[]
    def busy():calls.append(1);raise module.Busy('writer advanced')
    ticks=iter(range(0,10_000,600))
    assert module.supervise(Child(2,returncode=3),state,busy,tmp_path/'c.json',clock=lambda:next(ticks),sleep=lambda s:None)==3
    assert calls and 'last_checkpoint' not in state

def test_main_phase_terminal_checkpoint_reaches_control(repository,tmp_path,monkeypatch):
    # [review #257] #188 protects the per-phase terminal call site inside
    # main(); the regression test must drive main() itself, not the helper.
    # With the call site reverted to a bare save() the control state keeps the
    # supervise-periodic pointer and this test fails.
    root,stream,receipts=repository
    control=tmp_path/'control.json';state_path=tmp_path/'state.sav'
    monkeypatch.setattr(module,'ROOT',root)
    monkeypatch.setattr(module,'BRANCH',module.BRANCH)
    class ObserverStub:
        def check(self,stream_,require_repeat=False):return validate(stream_)
    monkeypatch.setattr(module,'observer',lambda:ObserverStub())
    monkeypatch.setattr(module,'validator',lambda stub:validate(stream))
    commits=[]
    def fake_checkpoint(root_,stream_,receipts_,validate_):
        leaf=stream_/f'chunk-{len(list(stream_.glob("chunk-*.json"))):06d}.json';leaf.write_text('{"synthetic":true}')
        command(root_,'add',str(leaf));command(root_,'commit','-m','synthetic chunk','-q')
        head=command(root_,'rev-parse','HEAD').strip();commits.append(head)
        return {'commit': head}
    monkeypatch.setattr(module,'checkpoint',fake_checkpoint)
    # the tool's subprocess binding: Popen is stubbed; git()'s check_output
    # and the TimeoutExpired exception stay real
    monkeypatch.setattr(module,'subprocess',types.SimpleNamespace(
        Popen=lambda *a,**k:Child(1),
        check_output=subprocess.check_output,
        TimeoutExpired=subprocess.TimeoutExpired))
    monkeypatch.setattr(sys,'argv',['job','--state',str(state_path),'--control',str(control)])
    module.main()
    state=json.loads(control.read_text())
    assert state['status']=='completed'
    head=command(root,'rev-parse','HEAD').strip()
    assert commits, 'the terminal checkpoint must have committed'
    assert state['last_checkpoint']==commits[-1]==head, (
        'the control state must end at the terminal checkpoint commit, not an '
        'older periodic one')
