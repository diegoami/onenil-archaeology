"""T86 recovery gates and independent numeric caller-trace integrity."""
import copy
import importlib.util
import json
from pathlib import Path

import pytest

ROOT = Path(__file__).resolve().parents[2]
spec = importlib.util.spec_from_file_location('postmatch_tail_tested',ROOT/'runtime/emul/postmatch_tail.py')
p = importlib.util.module_from_spec(spec)
spec.loader.exec_module(p)
RUN = ROOT/'records/T86/tail-r0009.json'


@pytest.fixture(scope='module')
def expected():
    return p.reference()


def capture():
    return json.loads(RUN.read_text())


def reseal(record):
    record['payload_sha256']=p.sha(p.encoded(record['payload']))


def test_complete_watched_suffix_caller_and_repeat(expected):
    p.check()
    counts=p.validate(capture(),expected)
    assert counts==dict(suffix_ticks=41,suffix_draws=394,caller_draws=103,
        condition_calls=35,condition_draws=70,other_draws=33,initial_observations=482,
        read_before_write_bytes=563,context_only_bytes=20,reads=2691,writes=439)


@pytest.mark.parametrize('damage',range(36))
def test_resealed_trace_corruptions_refuse(damage,expected):
    r=capture();v=r['payload'];a=v['caller'];call=v['calls'][0]
    if damage==0:v['suffix'][0]['before']['seed']^=1
    if damage==1:r['source']['private_sha256']='0'*64
    if damage==2:r['producer_files']['runtime/emul/postmatch_tail.py']='0'*64
    if damage==3:v['match_return']['draw']-=1
    if damage==4:a['entry']['sp']+=2
    if damage==5:a['returned']['bp']+=2
    if damage==6:a['frame']['parent_bp']+=2
    if damage==7:a['initial'].pop(0)
    if damage==8:a['initial'].append(copy.deepcopy(a['initial'][0]))
    if damage==9:next(x for x in a['operations'] if x['kind']=='read')['value']^=1
    if damage==10:next(x for x in a['operations'] if x['kind']=='write')['before']^=1
    if damage==11:a['operations'][0]['field']='opaque[0]+0'
    if damage==12:a['operations'][0]['address']+=1
    if damage==13:a['operations'][0]['size']=3
    if damage==14:v['draws'].pop(0)
    if damage==15:v['draws'][394]['seed_before']^=1
    if damage==16:next(x for x in a['operations'] if x['kind']=='write' and x['field']=='seed+0')['value']^=1
    if damage==17:v['contexts'].pop()
    if damage==18:v['calls'].pop()
    if damage==19:v['contexts'][0]['roster'][0]=0
    if damage==20:call['returned']['sp']+=1
    if damage==21:call['input']['age']+=1
    if damage==22:call['input']['facility']^=1
    if damage==23:call['status_byte']^=1
    if damage==24:call['output']['condition']+=1
    if damage==25:
        call['writes'][-1]['after']^=1
        call['output']['condition']=call['writes'][-1]['after']
    if damage==26:a['regions'][0]['base']+=1
    if damage==27:r['runtime']['unicorn']='unsupported'
    if damage==28:r['interventions']=[]
    if damage==29:a['service_effects']={'unmodelled service':1}
    if damage==30:a['timer_effects']['game_interrupts']=1
    if damage==31:a['initial'][0]['value']^=1
    if damage==32:
        index=max(i for i,x in enumerate(a['operations']) if x['kind']=='write')
        a['operations'].pop(index)
    if damage==33:a['final'][0]['value']^=1
    if damage==34:a['census']['writes']-=1
    if damage==35:a['preservation']['unexpected_count']=1
    reseal(r)
    with pytest.raises(ValueError):p.validate(r,expected)


def test_rehashed_write_only_fabrication_refuses_against_independent_repeat(tmp_path,monkeypatch):
    r=capture();ops=r['payload']['caller']['operations']
    op=next(x for x in reversed(ops) if x['kind']=='write' and x['field'].startswith('game['))
    op['value']^=1
    for item in r['payload']['caller']['final']:
        if item['address']==op['address'] and item['size']==op['size']:item['value']=op['value']
    reseal(r)
    leaf=tmp_path/'changed.json';leaf.write_text(json.dumps(r))
    index=json.loads(p.INDEX.read_text())
    index['runs'][0]=dict(path=str(leaf),sha256=p.sha(leaf.read_bytes()))
    path=tmp_path/'index.json';path.write_text(json.dumps(index))
    monkeypatch.setattr(p,'INDEX',path)
    with pytest.raises(ValueError):p.check()


def test_changed_private_never_reaches_pickle_loader(tmp_path,monkeypatch):
    path=tmp_path/'untrusted.pkl.gz';path.write_bytes(b'not an owner checkpoint')
    monkeypatch.setattr(p.checkpoint,'read_private',lambda *a:pytest.fail('unsafe private load'))
    with pytest.raises(ValueError,match='private checkpoint digest'):
        p.restore(path)


def test_changed_public_lineage_refuses_before_private_load(tmp_path,monkeypatch):
    index=json.loads((p.SOURCE/'index.json').read_text());index['native_commit']='0'*40
    (tmp_path/'index.json').write_text(json.dumps(index))
    monkeypatch.setattr(p,'SOURCE',tmp_path)
    monkeypatch.setattr(p.checkpoint,'read_private',lambda *a:pytest.fail('unsafe private load'))
    with pytest.raises(ValueError,match='lineage root'):
        p.restore(tmp_path/'anything')


def test_wrong_unicorn_context_version_refuses_before_private_load(monkeypatch):
    monkeypatch.setattr(p.unicorn,'__version__','unsupported')
    monkeypatch.setattr(p.checkpoint,'read_private',lambda *a:pytest.fail('unsafe private load'))
    with pytest.raises(ValueError,match='Unicorn checkpoint context'):
        p.restore(Path('not-used'))


def test_preserved_aborted_discovery_attempts_refuse(expected):
    for number in (1,2):
        r=json.loads((ROOT/f'records/T86/tail-r{number:04d}.json').read_text())
        assert r['status']=='aborted' and r['error']
        with pytest.raises(ValueError,match='incomplete watched caller'):
            p.validate(r,expected)


def test_private_recovery_restores_pending_observer_without_execution():
    private=ROOT/'.cache/native-recovery/T45/.cache/prepared-match-checkpoints/original-r0003/checkpoint-r0047.pkl.gz'
    if not private.exists():pytest.skip('owner private recovery checkpoint absent')
    week,saved,_,_=p.restore(private)
    assert week.draws==182417 and saved['result']['ticks']==4158
    assert saved['pending']['tick']==4159 and week.g.where()=='24BC:0C58'
    assert sorted(p.prior.authenticate_code(week.g))==['1998','232A','24BC']
