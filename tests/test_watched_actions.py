import copy,json,sys
from pathlib import Path
import pytest
ROOT=Path(__file__).resolve().parents[1]
sys.path.insert(0,str(ROOT/'runtime/emul'))
import watched_actions as r

@pytest.fixture(scope='module')
def sample():
    index=r.check()
    return r.setup.contests.outputs(json.loads((ROOT/index['record']).read_text()))

def test_complete_original_watched_prefix():assert r.check()['schema']=='watched-action-prefix/1'

@pytest.mark.parametrize('damage',['missing','bool-player','negative-player','invalid-code','side','queue-player','queue-code','cursor','seed','draw-seed','setup-prefix','mode','intervention','action-order'])
def test_inconsistent_or_missing_prefix_is_rejected(sample,damage):
    value=copy.deepcopy(sample);a=value['actions'][0]
    if damage=='missing':value['actions'].pop()
    elif damage=='bool-player':a['player']=True
    elif damage=='negative-player':a['player']=-1
    elif damage=='invalid-code':a['code']=255
    elif damage=='side':a['side']=2
    elif damage=='queue-player':a['queue']['player']^=1
    elif damage=='queue-code':a['queue']['code']^=1
    elif damage=='cursor':a['draw_end']=a['draw_start']-1
    elif damage=='seed':a['seed_before']^=1
    elif damage=='draw-seed':value['draws'][15]['seed_before']^=1
    elif damage=='setup-prefix':value['setup_draws'].pop()
    elif damage=='mode':value['first_ticks'][0]['state']['quick']=1
    elif damage=='intervention':value['intervention']['after']=0
    elif damage=='action-order':value['actions'].reverse()
    with pytest.raises((ValueError,KeyError,IndexError,TypeError)):r.validate(value)

def test_changed_static_or_record_source_pins_reject(tmp_path,monkeypatch):
    index=r.check();directory=tmp_path/'corpus';directory.mkdir()
    for path in r.FIXTURES.iterdir():(directory/path.name).write_bytes(path.read_bytes())
    monkeypatch.setattr(r,'FIXTURES',directory)
    for field in ('record_sha256','static_sources','actions_sha256'):
        value=copy.deepcopy(index)
        if field=='static_sources':value[field][r.STATIC[0]]='0'*64
        else:value[field]='0'*64
        (directory/'index.json').write_text(json.dumps(value))
        with pytest.raises(ValueError):r.check()


def test_resume_validates_without_rewriting_completed_outputs(monkeypatch):
    r.check()
    def no_original(*args,**kwargs):raise AssertionError('resume attempted new original run')
    monkeypatch.setattr(r.match,'Week',no_original)
    before={p:p.read_bytes() for d in (r.RUNS,r.FIXTURES) for p in d.iterdir() if p.is_file()}
    monkeypatch.setattr(r.match,'git',lambda *args:'' if args[0]=='status' else 'unused')
    r.run()
    assert all(p.read_bytes()==data for p,data in before.items())

def test_original_byte_arguments_and_reversed_roster_slots():
    class Guest:
        def stack_word(self,index):return {2:0xFF31,4:0,6:10,8:0xFF00}[index]
    assert r.arguments(Guest())=={'code':49,'actor_slot':10,'secondary_slot':0,'side':0}
