"""Logical-effect observer contracts on literal states, without a 5083 model."""
import copy
import sys
from pathlib import Path
from unittest.mock import patch

import pytest

sys.path.insert(0, str(Path(__file__).resolve().parents[2] / "runtime/emul"))
import goal_effects
from test_quick_step import specimen as step_specimen


def logical_state():
    rosters = [list(range(201, 221)), list(range(212, 232))]
    return {
        "global_actor": 2, "secondary_actor": 0, "clubs": [10, 20], "side_offsets": [0, 11],
        "flags": {key: 0 for key in goal_effects.FLAGS},
        "position_deltas": [0] * 14, "event_weights": [1, -1],
        "scenes": [{"index": i, "player": 200 + i, "slot": i} for i in range(1, 23)],
        "rosters": rosters,
        "players": [{"id": i, "p8_position": 0, "p8_flag7": 1,
                     "p15_word2": 0, "p15_byte5": 0, "p15_byte6": 1}
                    for i in range(201, 232)],
        "event_totals": [[0] * 20 for _ in range(2)], "cache": [[0] * 20 for _ in range(2)],
        "event_counts": [0, 0], "side_counts": [0, 0], "log_counts": [0, 0],
        "logs": [[{"player": 0, "minute_byte": 0} for _ in range(11)] for _ in range(2)],
        "source_pair": [7, 9], "target_pair": [4, 6],
        "queue": {"head": 0, "rows": [{"index": i, "code": 255, "first_player": 0,
                                        "second_player": 0, "side": 0} for i in range(3)]},
    }


def specimen():
    step, _, trace, source = step_specimen()
    event = {"minute": 7, "actor": 2, "side_flag": 1}
    before, after = logical_state(), logical_state()
    # Literal synthetic observations: these values do not come from a Python effects routine.
    after["cache"][1][1] = 1
    after["cache"][0][0] = 1
    after["event_totals"][1][1] = 1
    after["event_counts"][1] = 1
    after["side_counts"][1] = 1
    after["log_counts"][1] = 1
    after["logs"][1][0] = {"player": 202, "minute_byte": 7}
    after["queue"]["head"] = 1
    after["queue"]["rows"][1] = {"index": 1, "code": 38, "first_player": 202,
                                   "second_player": 0, "side": 1}
    after["target_pair"] = [7, 9]
    oldgoal = step["goal_calls"][0]
    for label in ("before", "after"):
        oldgoal[label]["flags"]["DS:D09F"] = 2
    oldgoal["after"]["scorer_logs"] = [[], [{"player": 202, "minute_byte": 7}]]
    contract = {"event": event.copy(), "coin": 1,
                "draws": [{"site": "0AB9:5190", "n": 2, "seed_before": 268,
                           "seed_after": 269, "value": 1}]}
    helpers = [
        {"input": {"old_byte6": 1, "delta": 0, "cache_flag": 1, "cache_before": 0},
         "output": {"byte6": 1, "cache": 1}, "scene_player": 202, "scene_slot": 2,
         "cache_side": 1, "cache_slot": 2},
        {"input": {"old_byte6": 1, "delta": -1, "cache_flag": 1, "cache_before": 0},
         "output": {"byte6": 1, "cache": 1}, "scene_player": 212, "scene_slot": 12,
         "cache_side": 0, "cache_slot": 1},
    ]
    call = {"step": 0, "draw_start": 268, "draw_end": 269, "seed_before": 268,
            "seed_after": 269, "event": event.copy(), "coin": 1, "before": before, "after": after,
            "helper_calls": helpers,
            "commentary": {"code": 38, "secondary_slot": 0, "actor_slot": 2,
                           "event_side": 1, "accepted": 1}}
    meta = {"record": "runs/T13/synthetic.json", "record_sha256": "c" * 64,
            "cases": "synthetic.jsonl", "cases_sha256": "d" * 64}
    previous = {"start_state": {"sha256": source["start_state_sha256"]}}
    placements = [{"step": 0, "callbacks": [contract], "input": {"rosters": copy.deepcopy(before["rosters"])}}]
    t12meta = {"record": "runs/T12/synthetic.json", "record_sha256": "e" * 64}
    sources = (meta, previous, placements, t12meta, {}, [step])
    return call, source, trace, sources


def export(call, source, trace, sources, reference=None):
    with patch.object(goal_effects, "sources", return_value=sources):
        return goal_effects.cases_for([call], source, trace, reference)


def test_complete_logical_states_and_consumed_coin_export_literally():
    call, source, trace, sources = specimen()
    rows = export(call, source, trace, sources)
    assert len(rows) == 1
    row = rows[0]
    assert row["schema"] == "goal-effects-case/1"
    assert row["request"] == sources[2][0]["callbacks"][0]
    assert row["before"] == call["before"]
    assert row["after"] == call["after"]
    assert row["commentary"] == call["commentary"]
    assert row["source"]["t12_record_sha256"] == "e" * 64
    assert row["source"]["t08_trace"] == source["trace"]
    helpers = goal_effects.helper_cases(rows)
    assert len(helpers) == 2
    assert [h["role"] for h in helpers] == [0, 1]
    assert helpers[1]["input"]["delta"] == -1
    assert "xy" not in row["before"]
    assert row["before"]["source_pair"] == [7, 9]


@pytest.mark.parametrize("corruption", [
    "missing-call", "event", "step", "bounds", "seed-before", "seed-after", "coin",
    "missing-player", "duplicate-player", "missing-roster", "wrong-roster", "scene-order", "scene-slot",
    "matrix-row", "matrix-width", "log-width", "queue-width", "queue-order", "queue-head", "queue-index",
    "source-pair", "target-pair", "changed-table", "changed-flag", "old-player", "old-log", "old-actor",
    "missing-commentary", "commentary-result", "missing-helper", "helper-delta", "helper-output",
])
def test_missing_corrupt_states_and_contracts_are_rejected(corruption):
    call, source, trace, sources = specimen()
    if corruption == "missing-call":
        with patch.object(goal_effects, "sources", return_value=sources), pytest.raises(ValueError):
            goal_effects.cases_for([], source, trace)
        return
    if corruption == "event": call["event"]["actor"] = 3
    elif corruption == "step": call["step"] = 1
    elif corruption == "bounds": call["draw_end"] = 270
    elif corruption == "seed-before": call["seed_before"] += 1
    elif corruption == "seed-after": call["seed_after"] += 1
    elif corruption == "coin": call["coin"] = 0
    elif corruption == "missing-player": call["before"]["players"].pop()
    elif corruption == "duplicate-player": call["before"]["players"].append(call["before"]["players"][0].copy())
    elif corruption == "missing-roster": call["before"]["rosters"][0].pop()
    elif corruption == "wrong-roster": call["before"]["rosters"].reverse()
    elif corruption == "scene-order": call["before"]["scenes"].reverse()
    elif corruption == "scene-slot": call["before"]["scenes"][1]["slot"] = 0
    elif corruption == "matrix-row": call["after"]["cache"].pop()
    elif corruption == "matrix-width": call["after"]["event_totals"][0].pop()
    elif corruption == "log-width": call["after"]["logs"][0].pop()
    elif corruption == "queue-width": call["before"]["queue"]["rows"].pop()
    elif corruption == "queue-order": call["after"]["queue"]["rows"].reverse()
    elif corruption == "queue-head": call["before"]["queue"]["head"] = 1701
    elif corruption == "queue-index": call["after"]["queue"]["rows"][0]["index"] = 3
    elif corruption == "source-pair": call["after"]["source_pair"] = [1]
    elif corruption == "target-pair": call["after"]["target_pair"] = [65536, 0]
    elif corruption == "changed-table": call["after"]["event_weights"][0] = 2
    elif corruption == "changed-flag": call["after"]["flags"]["d1ca"] = 1
    elif corruption == "old-player": call["before"]["players"][0]["p15_word2"] = 1
    elif corruption == "old-log": call["after"]["logs"][1][0]["player"] = 203
    elif corruption == "old-actor": call["after"]["global_actor"] = 3
    elif corruption == "missing-commentary": del call["commentary"]
    elif corruption == "commentary-result": call["commentary"]["accepted"] = 2
    elif corruption == "missing-helper": call["helper_calls"].pop()
    elif corruption == "helper-delta": call["helper_calls"][0]["input"]["delta"] = 32768
    else: call["helper_calls"][0]["output"]["cache"] = 256
    with pytest.raises(ValueError):
        export(call, source, trace, sources)


@pytest.mark.parametrize("path,value", [
    (("seed_before",), 268.0), (("coin",), True), (("event", "minute"), 7.0),
    (("before", "global_actor"), 2.0), (("before", "flags", "d6dd"), False),
    (("before", "players", 0, "id"), 201.0), (("after", "cache", 0, 0), 1.0),
    (("after", "event_counts", 1), True), (("helper_calls", 0, "input", "delta"), 0.0),
])
def test_exact_integer_contract_rejects_float_and_boolean_aliases(path, value):
    call, source, trace, sources = specimen()
    obj = call
    for key in path[:-1]: obj = obj[key]
    obj[path[-1]] = value
    with pytest.raises(ValueError):
        export(call, source, trace, sources)


def test_shared_player_ids_have_one_state_record_not_one_record_per_role():
    call, source, trace, sources = specimen()
    for label in ("before", "after"):
        call[label]["scenes"][11]["player"] = 202
        sources[5][0]["goal_calls"][0][label]["players"][11]["player"] = 202
    assert len(export(call, source, trace, sources)) == 1
    call["before"]["players"].append(copy.deepcopy(call["before"]["players"][1]))
    with pytest.raises(ValueError):
        export(call, source, trace, sources)


def test_repeated_trace_checks_its_identity_without_changing_canonical_source():
    call, source, trace, sources = specimen()
    repeated = {**source, "start_state_sha256": "f" * 64, "trace": "traces/T08/repeated.jsonl"}
    trace[0]["state_sha256"] = repeated["start_state_sha256"]
    rows = export(call, source, trace, sources, repeated)
    assert rows[0]["source"]["t08_trace"] == repeated["trace"]
    assert rows[0]["source"]["t13_record"] == sources[0]["record"]
    with pytest.raises(ValueError):
        export(call, source, trace, sources)


@pytest.mark.parametrize("kind", ["canonical-state", "trace-state", "status", "empty", "missing-end"])
def test_source_and_reference_provenance_must_hold(kind):
    call, source, trace, sources = specimen()
    if kind == "canonical-state": sources[1]["start_state"]["sha256"] = "f" * 64
    elif kind == "trace-state": trace[0]["state_sha256"] = "f" * 64
    elif kind == "status": trace[-1]["status"] = "stopped"
    elif kind == "empty": trace = []
    else: trace.pop()
    with pytest.raises(ValueError):
        export(call, source, trace, sources)


def test_failed_latest_receipt_is_retryable(tmp_path):
    import json
    for n, status in ((1, "completed"), (2, "aborted: interrupted")):
        (tmp_path / f"T14-r{n:04d}.json").write_text(json.dumps({"status": status, "actions": {"stream_key": "same"}}))
    with patch.object(goal_effects, "RUNS", tmp_path):
        assert goal_effects.selected_runs() == {}


def test_queue_rows_wrap_and_retain_old_physical_projection():
    assert goal_effects.row_indices(1700) == [1700, 1, 2]
    call, source, trace, sources = specimen()
    before_indices = [1700, 1, 2]
    call["before"]["queue"]["head"] = 1700
    call["after"]["queue"]["head"] = 1
    for label in ("before", "after"):
        for row, index in zip(call[label]["queue"]["rows"], before_indices): row["index"] = index
    assert len(export(call, source, trace, sources)) == 1
