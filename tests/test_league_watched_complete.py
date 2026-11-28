"""Structural checks for the T124 watched league reference; synthetic records are not evidence."""
import copy
import sys
from pathlib import Path

import pytest

sys.path.insert(0, str(Path(__file__).resolve().parents[1] / 'runtime/emul'))
import league_watched_complete as league


def sample_state():
    return {
        'seed': league.FIRST_SEED, 'elapsed': 0, 'remaining': 91, 'quick': 0,
        'scores': [0, 0], 'phase': 45, 'active': 0, 'hold': 0,
        'actor': 1, 'secondary': 0, 'stoppage': 0,
        'ball': {**{f'word{k}': 0 for k in (0, 2, 4, 7, 9, 11)},
                 **{f'byte{k}': 0 for k in (6, 13, 14)}},
        'scenes': [{'index': i,
                    **{f'word{k}': (i if k == 14 else 0) for k in (0, 2, 4, 8, 10, 14, 16, 20)},
                    **{f'byte{k}': 0 for k in (6, 7, 12, 13, 18, 19, 22, 23, 24)}}
                   for i in range(1, 23)],
    }


def test_the_watched_league_start_is_not_the_quick_path():
    league.validate_league_start(sample_state())


@pytest.mark.parametrize('field, value', [
    ('quick', 1), ('seed', 1234), ('scores', [1, 0]),
    ('elapsed', 1), ('remaining', 90),
])
def test_a_quick_or_shifted_start_is_rejected(field, value):
    start = sample_state()
    start[field] = copy.deepcopy(value)
    with pytest.raises(ValueError):
        league.validate_league_start(start)


def test_the_intervention_is_the_t100_watch_flag():
    assert league.INTERVENTION['watch'] == {'site': 'T100 preparation config+F2', 'before': 0, 'after': 1}
    assert league.INTERVENTION['timer'] == {'site': 'first watched tick PIT divisor', 'before': 65536, 'after': 1024}


def test_the_quick_census_is_not_a_watched_match():
    with pytest.raises(ValueError):
        league.finish_count([{}] * league.QUICK_ACTIONS, 4000, league.QUICK_DRAWS)
    league.finish_count([{}] * 600, 4000, 150000)
