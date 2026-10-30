import copy
import sys
from pathlib import Path
from unittest.mock import patch
import pytest

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / 'runtime/emul'))
import extra_event_inputs as ei


def test_complete_supplementary_public_corpus():
    assert ei.main(['--check']) == 0


@pytest.mark.parametrize('damage', ['missing', 'duplicate', 'step', 'seed', 'draw', 'offset', 'bool', 'overflow', 'field'])
def test_supplement_rejects_invalid_cells(damage):
    meta, rec = ei.sources()[0]
    cells = [{'step': c['step'], 'seed': c['input']['seed'], 'draw_start': c['draw_start'],
              'offset': 0xD0B, 'value': 2} for c in ei.contests.outputs(rec)['calls']]
    if damage == 'missing': cells.pop()
    elif damage == 'duplicate': cells[1] = copy.deepcopy(cells[0])
    elif damage == 'step': cells[0]['step'] += 1
    elif damage == 'seed': cells[0]['seed'] ^= 1
    elif damage == 'draw': cells[0]['draw_start'] += 1
    elif damage == 'offset': cells[0]['offset'] -= 1
    elif damage == 'bool': cells[0]['value'] = True
    elif damage == 'overflow': cells[0]['value'] = 256
    elif damage == 'field': del cells[0]['value']
    with pytest.raises(ValueError): ei.cases_for(cells, meta, rec)


@pytest.mark.parametrize('prefix', ['runs/T18/', 'traces/T18/', 'runs/T17/', 'traces/T17/'])
def test_supplement_rejects_changed_source_record_fixture_hashes(prefix):
    original = ei.contests.sha
    with patch.object(ei.contests, 'sha', side_effect=lambda p: '0' * 64 if Path(p).relative_to(ROOT).as_posix().startswith(prefix) else original(p)):
        assert ei.main(['--check']) == 1
