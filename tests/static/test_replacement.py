import copy
import importlib.util
import json
from pathlib import Path
from unittest.mock import patch
import pytest

ROOT=Path(__file__).resolve().parents[2]
spec=importlib.util.spec_from_file_location('replacement',ROOT/'tools/static/replacement.py')
r=importlib.util.module_from_spec(spec); spec.loader.exec_module(r)


def test_checked_map():
    assert r.main(['--check'])==0


@pytest.mark.parametrize('damage',['missing','order','target','return','hash','argument','source','count'])
def test_map_mutations_fail(damage):
    expected=json.loads(r.MAP.read_text()); actual=copy.deepcopy(expected)
    if damage=='missing': actual['boundaries'].pop()
    elif damage=='order': actual['boundaries'].reverse()
    elif damage=='target': actual['boundaries'][-1]['target']='0AB9:164E'
    elif damage=='return': actual['boundaries'][0]['return']='0AB9:AEE5'
    elif damage=='hash': actual['boundaries'][0]['instruction_sha256']='0'*64
    elif damage=='argument': actual['retained_t23']['weeks'][0]['arguments'][0][0]^=1
    elif damage=='source': actual['retained_t23']['weeks'][0]['record_sha256']='0'*64
    elif damage=='count': actual['retained_t23']['weeks'][0]['replacements']-=1
    with pytest.raises(ValueError): r.check(actual,expected)


def test_near_calls_wrap_to_sixteen_bits():
    rows=r.boundaries(r.LISTING.read_text())
    assert next(x for x in rows if x['site']=='0AB9:B0C6')['target']=='0AB9:164F'
    assert next(x for x in rows if x['site']=='0AB9:AF7F')['target']=='0AB9:0F94'


@pytest.mark.parametrize('damage',['missing','unknown','next'])
def test_listing_shape_mutations_fail(damage):
    text=r.LISTING.read_text()
    if damage=='missing': text=text.replace('B0C6  E8 86 65        call 0x1164f','')
    elif damage=='unknown': text=text.replace('AEB8  C8 0A 00 00     enter 0xa, 0','AEB8  E8 00 00        call 0xaebb')
    else: text=text.replace('AEE4  8A 46 08','AEE5  8A 46 08')
    with pytest.raises(ValueError): r.boundaries(text)


@pytest.mark.parametrize('prefix',['runs/T23/','traces/T23/','runs/T22/','traces/T22/'])
def test_retained_digests_fail(prefix):
    original=r.ai.contests.sha
    with patch.object(r.ai.contests,'sha',side_effect=lambda p:'0'*64 if Path(p).relative_to(ROOT).as_posix().startswith(prefix) else original(p)):
        assert r.main(['--check'])==1
