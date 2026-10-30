"""Literal tail/clock observer contracts; no Python effects model."""
import copy
import json
import sys
from pathlib import Path
from unittest.mock import patch

import pytest

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / 'runtime/emul'))
import step_tail


def test_complete_committed_public_tail_clock_corpus():
    # Decoded records are sufficient; no original game or private state is read.
    assert step_tail.main(['--check']) == 0


@pytest.mark.parametrize('prefix', ['traces/T16/T16-r', 'runs/T16/T16-r', 'runs/T12/', 'runs/T13/', 'traces/T08/'])
def test_public_corpus_rejects_record_fixture_and_retained_source_digest_changes(prefix):
    original = step_tail.contests.sha

    def damaged(path):
        relative = Path(path).relative_to(ROOT).as_posix()
        return '0' * 64 if relative.startswith(prefix) else original(path)

    with patch.object(step_tail.contests, 'sha', side_effect=damaged):
        assert step_tail.main(['--check']) == 1


def specimen():
    source = json.loads((ROOT / 'traces/T08/index.json').read_text())['entries'][-1]
    m12, r12, c12, m13, r13, c13 = step_tail.sources(source)
    old = copy.deepcopy(step_tail.contests.outputs(r12)['steps'][0])
    pc = copy.deepcopy(c13[0])
    visits = [step_tail.legacy_visit(v) for v in old['scene_visits']]
    scenes = [{'index': v['index'], 'player': v['player'], 'word0': v['before']['word0']} for v in visits]
    players = {v['player']: {'id': v['player'], **{k: v['before'][k] for k in ('byte8', 'byte11')}} for v in visits}
    after_players = {v['player']: {'id': v['player'], **{k: v['after'][k] for k in ('byte8', 'byte11')}} for v in visits}
    po = old['placement_output']; hist = old['history_write']
    prefix = {'input': {'placement': {'seed': po['seed'], 'generated': po['generated'], 'scores': po['saved_scores'],
                                      'goal_flag': po['goal_flag'], 'actor': pc['output']['actor']},
                         'mode': old['input']['flags']['DS:D074'], 'd6dd': old['input']['flags']['DS:D6DD'],
                         'remaining': po['clock']['remaining'], 'replacement_word': 0,
                         'clubs': old['input']['clubs'], 'history': {'base_offset': 1000, 'base_segment': 8000,
                         'selector': 1, 'value': hist['before']}, 'scenes': scenes,
                         'players': [players[i] for i in sorted(players)]},
              'output': {'seed': po['seed'], 'actor': pc['output']['actor'],
                         'goal_bytes': old['output']['goal_bytes'], 'score_bytes': list(reversed(old['output']['score_side'])),
                         'history_byte': hist['after'], 'history_offset': 2000, 'history_segment': 8000,
                         'scenes': [{**s, 'word0': v['after']['word0']} for s, v in zip(scenes, visits)],
                         'players': [after_players[i] for i in sorted(after_players)]},
              'visits': visits, 'pending_calls': step_tail.expected_requests(old['phases']),
              'history_observation': {'offset': 2000, 'segment': 8000, 'score_word': hist['score_word'], 'after': hist['after']},
              'draw_start': po['draws'], 'draw_end': po['draws']}
    common = {'reload': 0, 'cf51': 9, 'seed': old['output']['seed'],
              'commentary': {'event_word': 13, 'counts': [7, 8], 'weights': [0, 255],
                             'queue': {'head': 10, 'rows': [{'index': i, 'code': 255, 'first_player': 0,
                              'second_player': 0, 'side': 0} for i in (10, 11, 12)]},
                             'source_pair': [1, 2], 'target_pair': [3, 4]}}
    clock = {'input': {**copy.deepcopy(common), 'clock': copy.deepcopy(old['clock_before'])},
             'output': {**copy.deepcopy(common), 'clock': copy.deepcopy(old['clock_after'])},
             'event': None, 'result': old['clock_result'], 'draw_start': old['draw_end'], 'draw_end': old['draw_end']}
    r12['outputs'] = [{'name': 'steps', 'value': [old]}]
    linked = m12, r12, [c12[0]], m13, r13, [pc]
    trace = [{'state_sha256': source['start_state_sha256']}, {'status': 'completed'}]
    return [{'prefix': prefix, 'clock': clock}], source, trace, linked


def export(calls, source, trace, linked):
    with patch.object(step_tail, 'sources', return_value=linked), patch.object(step_tail.quick_step, 'cases_for', return_value=[]), \
            patch.object(step_tail.quick_step, 't11_calls', return_value=[]):
        return step_tail.cases_for(calls, source, trace)


def test_raw_prefix_and_clock_export_are_literal_and_expected_pointer_is_not_input():
    calls, source, trace, linked = specimen()
    rows = export(calls, source, trace, linked)
    assert len(rows) == 1
    assert rows[0]['schema'] == 'step-tail-case/1'
    assert rows[0]['prefix'] == calls[0]['prefix']
    assert rows[0]['clock'] == calls[0]['clock']
    assert rows[0]['placement'] == linked[-1][0]
    assert set(rows[0]['prefix']['input']['history']) == {'base_offset', 'base_segment', 'selector', 'value'}
    assert len(rows[0]['prefix']['visits']) == 22


@pytest.mark.parametrize('corruption', [
    'missing-call', 'missing-clock', 'missing-scene', 'duplicate-scene', 'player-id', 'missing-player',
    'duplicate-player', 'byte8', 'flag-bool', 'history-missing', 'history-byte', 'history-output', 'history-score',
    'scene-before', 'visit-after', 'missing-visit', 'visit-index', 'visit-player', 'availability', 'changed-status',
    'seed', 'actor', 'generated', 'scores', 'goal-flag', 'mode', 'd6dd', 'remaining', 'clubs', 'prefix-rng',
    'pending-missing', 'pending-args', 'clock-before', 'clock-after', 'clock-seed', 'clock-rng', 'clock-reload',
    'clock-flag', 'clock-missing', 'queue-head', 'queue-indices', 'queue-side', 'queue-player-bool', 'weights',
    'pair-width', 'event-code', 'missing-event', 'trace-state', 'trace-status', 'source-t13', 'source-t12',
])
def test_incomplete_corrupt_mistyped_observations_and_sources_are_rejected(corruption):
    calls, source, trace, linked = specimen()
    p, c = calls[0]['prefix'], calls[0]['clock']
    if corruption == 'missing-call': calls.clear()
    elif corruption == 'missing-clock': del calls[0]['clock']
    elif corruption == 'missing-scene': p['input']['scenes'].pop()
    elif corruption == 'duplicate-scene': p['input']['scenes'][1]['index'] = 1
    elif corruption == 'player-id': p['input']['players'][0]['id'] = 3921
    elif corruption == 'missing-player': p['input']['players'].pop()
    elif corruption == 'duplicate-player': p['input']['players'].append(copy.deepcopy(p['input']['players'][0]))
    elif corruption == 'byte8': p['input']['players'][0]['byte8'] = -1
    elif corruption == 'flag-bool': p['input']['placement']['goal_flag'] = False
    elif corruption == 'history-missing': del p['input']['history']['selector']
    elif corruption == 'history-byte': p['input']['history']['value'] = 256
    elif corruption == 'history-output': p['output']['history_byte'] ^= 1
    elif corruption == 'history-score': p['history_observation']['score_word'] ^= 1
    elif corruption == 'scene-before': p['visits'][0]['before']['word0'] ^= 1
    elif corruption == 'visit-after': p['visits'][0]['after']['byte8'] ^= 1
    elif corruption == 'missing-visit': p['visits'].pop()
    elif corruption == 'visit-index': p['visits'][0]['index'] = 0
    elif corruption == 'visit-player': p['visits'][0]['player'] = 0
    elif corruption == 'availability': p['visits'][0]['unavailable'] = 2
    elif corruption == 'changed-status': p['visits'][0]['after']['byte11'] ^= 1
    elif corruption == 'seed': p['output']['seed'] ^= 1
    elif corruption == 'actor': p['output']['actor'] ^= 1
    elif corruption == 'generated': p['input']['placement']['generated'][0] ^= 1
    elif corruption == 'scores': p['input']['placement']['scores'][0] ^= 1
    elif corruption == 'goal-flag': p['input']['placement']['goal_flag'] ^= 1
    elif corruption == 'mode': p['input']['mode'] = 0
    elif corruption == 'd6dd': p['input']['d6dd'] ^= 1
    elif corruption == 'remaining': p['input']['remaining'] ^= 1
    elif corruption == 'clubs': p['input']['clubs'][0] = 0
    elif corruption == 'prefix-rng': p['draw_end'] += 1
    elif corruption == 'pending-missing': p['pending_calls'].pop()
    elif corruption == 'pending-args': p['pending_calls'][0]['args'] = [2]
    elif corruption == 'clock-before': c['input']['clock']['elapsed'] ^= 1
    elif corruption == 'clock-after': c['output']['clock']['elapsed'] ^= 1
    elif corruption == 'clock-seed': c['output']['seed'] ^= 1
    elif corruption == 'clock-rng': c['draw_end'] += 1
    elif corruption == 'clock-reload': c['output']['reload'] = 1
    elif corruption == 'clock-flag': c['input']['clock']['active'] = True
    elif corruption == 'clock-missing': del c['input']['cf51']
    elif corruption == 'queue-head': c['input']['commentary']['queue']['head'] = 1701
    elif corruption == 'queue-indices': c['output']['commentary']['queue']['rows'].reverse()
    elif corruption == 'queue-side': c['input']['commentary']['queue']['rows'][0]['side'] = 256
    elif corruption == 'queue-player-bool': c['input']['commentary']['queue']['rows'][0]['first_player'] = False
    elif corruption == 'weights': c['output']['commentary']['weights'][0] ^= 1
    elif corruption == 'pair-width': c['input']['commentary']['source_pair'].pop()
    elif corruption == 'event-code': c['event'] = {'code': 38, 'actor_slot': 0, 'secondary_slot': 0, 'event_side': 1, 'accepted': 1}
    elif corruption == 'missing-event': c['result'] = 1
    elif corruption == 'trace-state': trace[0]['state_sha256'] = 'a' * 64
    elif corruption == 'trace-status': trace[-1]['status'] = 'aborted'
    elif corruption == 'source-t13': linked[-1][0]['output']['actor'] ^= 1
    elif corruption == 'source-t12': step_tail.contests.outputs(linked[1])['steps'][0]['history_write']['after'] ^= 1
    with pytest.raises(ValueError):
        export(calls, source, trace, linked)


def test_zero_actor_numeric_event_is_valid_with_entry_selected_queue_rows():
    calls, *_ = specimen()
    c = calls[0]['clock']
    c['result'] = 1
    c['event'] = {'code': 63, 'actor_slot': 0, 'secondary_slot': 0, 'event_side': 1, 'accepted': 0}
    step_tail.validate_clock(c)
    assert c['input']['commentary']['event_word'] == 13


def test_unreached_clock_commentary_has_no_invented_event():
    calls, *_ = specimen()
    assert calls[0]['clock']['event'] is None
    step_tail.validate_clock(calls[0]['clock'])
