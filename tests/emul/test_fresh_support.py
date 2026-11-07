import copy
import importlib.util
import json
import sys
from pathlib import Path

import pytest

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / 'runtime/emul'))
spec = importlib.util.spec_from_file_location('fresh_support_test', ROOT / 'runtime/emul/fresh_support.py')
module = importlib.util.module_from_spec(spec)
spec.loader.exec_module(module)


def request():
    return dict(schema='fresh-caller-read-request/1', fields=[dict(area='ds', offset=0xB18)])


@pytest.mark.parametrize('damage', ['empty', 'oversized', 'duplicate', 'seed', 'player', 'watch', 'negative', 'bool', 'extra'])
def test_unsupported_or_opaque_requests_refuse(damage):
    good = request(); module.request_check(good)
    bad = copy.deepcopy(good)
    if damage == 'empty': bad['fields'] = []
    elif damage == 'oversized': bad['fields'] *= 1025
    elif damage == 'duplicate': bad['fields'] *= 2
    elif damage == 'seed': bad['fields'][0]['offset'] = 0xA51C
    elif damage == 'player': bad['fields'][0]['area'] = 'p8'
    elif damage == 'watch': bad['fields'][0] = dict(area='config', offset=0xF2)
    elif damage == 'negative': bad['fields'][0]['offset'] = -1
    elif damage == 'bool': bad['fields'][0]['offset'] = True
    else: bad['fields'][0]['value'] = 0
    with pytest.raises(ValueError): module.request_check(bad)


def witnesses():
    base = {'payload': dict(points=[{'state': {'named': i}} for i in range(8)],
                            first_entry={'entry': 1}, draws=[{'draw': 0}])}
    payload = dict(points=[dict(site=site, join_sha256=digest) for site, digest in zip(module.SITES, module.joins(base))],
        draw_count=258, draws_sha256=module.prior.sha(module.prior.encoded(base['payload']['draws'])),
        fields=[dict(area='ds', offset=0xB18, before=3, precall=3, entry=3, incoming=True)])
    return base, payload


@pytest.mark.parametrize('damage', ['site', 'join', 'rng', 'field', 'domain', 'ownership'])
def test_changed_source_and_witness_aliases_refuse(damage):
    base, payload = witnesses(); module.payload_check(payload, request(), base)
    bad = copy.deepcopy(payload)
    if damage == 'site': bad['points'][0]['site'] = 'other'
    elif damage == 'join': bad['points'][0]['join_sha256'] = '0' * 64
    elif damage == 'rng': bad['draw_count'] = 257
    elif damage == 'field': bad['fields'][0]['offset'] += 1
    elif damage == 'domain': bad['fields'][0]['before'] = 256
    else: bad['fields'][0]['incoming'] = False
    with pytest.raises(ValueError): module.payload_check(bad, request(), base)


def test_original_computation_is_excluded_from_incoming():
    base, payload = witnesses()
    payload['fields'][0].update(entry=4, incoming=False)
    module.payload_check(payload, request(), base)


@pytest.mark.parametrize('damage', ['source', 'join', 'witness', 'request', 'dependency', 'error', 'opaque'])
def test_authentic_record_rejects_corrupted_aliases(damage):
    value = json.loads((ROOT / 'runs/T68/support-r0003.json').read_text())
    assert module.check(value)
    bad = copy.deepcopy(value)
    if damage == 'source': bad['source']['state_sha256'] = '0' * 64
    elif damage == 'join': bad['payload']['points'][0]['join_sha256'] = '0' * 64
    elif damage == 'witness': bad['payload']['fields'][0]['entry'] ^= 1
    elif damage == 'request': bad['request']['sha256'] = '0' * 64
    elif damage == 'dependency': bad['producer_files'].pop('runtime/emul/guest.py')
    elif damage == 'error': bad['error'] = 'aborted'
    else: bad['opaque'] = 'unrecognized data'
    bad['payload_sha256'] = module.prior.sha(module.prior.encoded(bad['payload']))
    with pytest.raises(ValueError): module.check(bad)
