"""Placement exports retain original inputs and literal observations, not a Python model."""
import copy
import json
import sys
from pathlib import Path
from unittest.mock import patch

import pytest

sys.path.insert(0, str(Path(__file__).resolve().parents[2] / "runtime/emul"))
sys.path.insert(0, str(Path(__file__).resolve().parent))
import placement


def test_complete_public_placement_corpus_and_helper_checks():
    # All validation inputs are public decoded evidence; no private game is loaded.
    assert placement.main(["--check"]) == 0
from test_quick_step import specimen as step_specimen


def specimen():
    step, contest, trace, source = step_specimen()
    before, after = step["placement_input"], step["placement_output"]
    event = {key: step["goal_calls"][0][key] for key in ("minute", "actor", "side_flag")}
    rosters = [list(range(201, 221)), list(range(221, 241))]
    call = {
        "draw_start": before["draws"], "draw_end": after["draws"], "contest": copy.deepcopy(contest),
        "input": {"seed": before["seed"], "generated": before["generated"].copy(),
                  "scores": before["saved_scores"].copy(), "elapsed": before["clock"]["elapsed"],
                  "minute_limit": before["minute_limit"], "side_offsets": before["side_offsets"].copy(),
                  "actor_before": 0, "scorer_slots": [2] * 30, "rosters": rosters,
                  "players": [{"id": player, "p15_sbyte8": 10, "p15_byte11": 0}
                              for player in range(201, 241)]},
        "output": {"seed": after["seed"], "generated": after["generated"].copy(),
                   "scores": after["saved_scores"].copy(), "goal_flag": after["goal_flag"],
                   "actor": event["actor"], "goal": event.copy()},
        "callbacks": [{"draw_start": 268, "draw_end": 269, "coin": 1, "event": event.copy()}],
    }
    meta = {"record": "runs/T12/T12-synthetic.json", "record_sha256": "c" * 64,
            "cases": "T12-synthetic.jsonl", "cases_sha256": "d" * 64}
    previous = {"start_state": {"sha256": source["start_state_sha256"]}}
    return call, step, source, trace, meta, previous


def exported(call, step, source, trace, meta, previous, reference_source=None):
    with patch.object(placement, "t12_source", return_value=(meta, previous, [step])):
        return placement.cases_for([call], source, trace, reference_source)


def test_complete_original_input_and_literal_coin_contract_export():
    call, step, source, trace, meta, previous = specimen()
    cases = exported(call, step, source, trace, meta, previous)
    assert len(cases) == 1
    case = cases[0]
    assert case["schema"] == "placement-case/1"
    assert case["input"] == call["input"]
    assert len(case["input"]["rosters"]) == 2
    assert all(len(roster) == 20 for roster in case["input"]["rosters"])
    assert len(case["input"]["players"]) == 40
    assert case["output"] == call["output"]
    assert [draw["site"] for draw in case["draws"]] == ["0AB9:DDE4", "0AB9:DE5C", "0AB9:5190"]
    assert case["callbacks"] == [{"event": call["callbacks"][0]["event"], "coin": 1,
        "draws": [{"site": "0AB9:5190", "n": 2, "seed_before": 268,
                   "seed_after": 269, "value": 1}]}]
    assert case["contest"]["input"] == call["contest"]["input"]
    assert case["source"]["t12_record_sha256"] == meta["record_sha256"]


@pytest.mark.parametrize("bad", [
    "roster-missing", "roster-short", "player-missing", "player-duplicate", "scorer-short", "scorer-invalid",
    "generated-overflow", "scores-overflow", "offset-overflow", "actor-overflow", "signed-player-overflow",
    "status-player-overflow", "input-seed", "input-generated", "input-score", "input-elapsed", "input-limit",
    "input-offset", "player-field", "selected-slot", "mapping-roster", "output-seed", "output-generated",
    "output-score", "output-flag", "output-actor", "output-goal", "bounds-start", "bounds-end",
    "callback-missing", "callback-event", "callback-span", "callback-coin", "coin-site", "coin-argument",
    "contest", "t12-state", "reference-state", "incomplete-trace", "trace-index", "roster-word-overflow",
])
def test_incomplete_or_corrupted_original_contract_is_rejected(bad):
    call, step, source, trace, meta, previous = specimen()
    inputs, output = call["input"], call["output"]
    if bad == "roster-missing":
        inputs["rosters"].pop()
    elif bad == "roster-short":
        inputs["rosters"][0].pop()
    elif bad == "player-missing":
        inputs["players"].pop()
    elif bad == "player-duplicate":
        inputs["players"].append(copy.deepcopy(inputs["players"][0]))
    elif bad == "scorer-short":
        inputs["scorer_slots"].pop()
    elif bad == "scorer-invalid":
        inputs["scorer_slots"][0] = 0
    elif bad == "generated-overflow":
        inputs["generated"][0] = 12
    elif bad == "scores-overflow":
        inputs["scores"][0] = 256
    elif bad == "offset-overflow":
        inputs["side_offsets"][0] = 256
    elif bad == "actor-overflow":
        inputs["actor_before"] = 256
    elif bad == "signed-player-overflow":
        inputs["players"][-1]["p15_sbyte8"] = 128
    elif bad == "status-player-overflow":
        inputs["players"][-1]["p15_byte11"] = 256
    elif bad.startswith("input-"):
        key = {"input-seed": "seed", "input-generated": "generated", "input-score": "scores",
               "input-elapsed": "elapsed", "input-limit": "minute_limit", "input-offset": "side_offsets"}[bad]
        if isinstance(inputs[key], list):
            inputs[key][0] += 1
        else:
            inputs[key] += 1
    elif bad == "player-field":
        inputs["players"][0]["p15_sbyte8"] += 1
    elif bad == "selected-slot":
        inputs["scorer_slots"][1] = 3
    elif bad == "mapping-roster":
        inputs["rosters"][0][10], inputs["rosters"][0][11] = inputs["rosters"][0][11], inputs["rosters"][0][10]
    elif bad.startswith("output-"):
        key = {"output-seed": "seed", "output-generated": "generated", "output-score": "scores",
               "output-flag": "goal_flag", "output-actor": "actor", "output-goal": "goal"}[bad]
        if key == "goal":
            output[key] = None
        elif isinstance(output[key], list):
            output[key][0] += 1
        else:
            output[key] += 1
    elif bad == "bounds-start":
        call["draw_start"] -= 1
    elif bad == "bounds-end":
        call["draw_end"] += 1
    elif bad == "callback-missing":
        call["callbacks"] = []
    elif bad == "callback-event":
        call["callbacks"][0]["event"]["minute"] += 1
    elif bad == "callback-span":
        call["callbacks"][0]["draw_start"] -= 1
    elif bad == "callback-coin":
        call["callbacks"][0]["coin"] = 0
    elif bad in ("coin-site", "coin-argument"):
        draw = next(draw for draw in trace if draw.get("i") == 268)
        if bad == "coin-site":
            draw["callers"] = ["0AB9:DDE4"]
        else:
            draw["n"] = 3
    elif bad == "contest":
        call["contest"]["input"]["seed"] += 1
    elif bad == "t12-state":
        previous["start_state"]["sha256"] = "e" * 64
    elif bad == "reference-state":
        trace[0]["state_sha256"] = "e" * 64
    elif bad == "incomplete-trace":
        trace[-1]["status"] = "stopped"
    elif bad == "roster-word-overflow":
        inputs["rosters"][1][-1] = 65536
        inputs["players"][-1]["id"] = 65536
    else:
        next(draw for draw in trace if draw.get("i") == 266)["i"] = 999
    with pytest.raises(ValueError):
        exported(call, step, source, trace, meta, previous)


@pytest.mark.parametrize("field", ["seed", "generated", "scores", "elapsed", "minute_limit", "side_offsets",
                                   "actor_before", "roster-id", "player-id", "player-signed", "player-status", "coin",
                                   "output-seed", "output-generated", "output-score", "output-flag", "output-actor",
                                   "callback-minute"])
def test_typed_integer_inputs_reject_float_and_boolean_aliases(field):
    call, step, source, trace, meta, previous = specimen()
    inputs = call["input"]
    if field in ("seed", "elapsed", "minute_limit", "actor_before"):
        inputs[field] = float(inputs[field])
    elif field in ("generated", "scores", "side_offsets"):
        inputs[field][0] = bool(inputs[field][0])
    elif field == "roster-id":
        inputs["rosters"][1][-1] = float(inputs["rosters"][1][-1])
    elif field == "player-id":
        inputs["players"][-1]["id"] = float(inputs["players"][-1]["id"])
    elif field == "player-signed":
        inputs["players"][-1]["p15_sbyte8"] = float(inputs["players"][-1]["p15_sbyte8"])
    elif field == "player-status":
        inputs["players"][-1]["p15_byte11"] = False
    elif field.startswith("output-"):
        key = {"output-seed": "seed", "output-generated": "generated", "output-score": "scores",
               "output-flag": "goal_flag", "output-actor": "actor"}[field]
        if isinstance(call["output"][key], list):
            call["output"][key][0] = bool(call["output"][key][0])
        else:
            call["output"][key] = float(call["output"][key])
    elif field == "callback-minute":
        call["callbacks"][0]["event"]["minute"] = float(call["callbacks"][0]["event"]["minute"])
    else:
        call["callbacks"][0]["coin"] = True
    with pytest.raises(ValueError):
        exported(call, step, source, trace, meta, previous)


def test_repeated_t08_state_uses_canonical_t12_with_explicit_reference_identity():
    call, step, canonical, trace, meta, previous = specimen()
    reference = {**canonical, "t04_record": "synthetic-repeat", "trace": "traces/T08/repeat.jsonl",
                 "trace_sha256": "f" * 64, "start_state_sha256": "e" * 64}
    trace[0]["state_sha256"] = reference["start_state_sha256"]
    case = exported(call, step, canonical, trace, meta, previous, reference)[0]
    assert case["week"] == canonical["t04_record"]
    assert case["source"]["t08_trace"] == reference["trace"]
    assert case["source"]["t08_sha256"] == reference["trace_sha256"]
    with pytest.raises(ValueError):
        exported(call, step, canonical, trace, meta, previous)


@pytest.mark.parametrize("bad", ["status", "record-digest", "fixture-digest"])
def test_t12_source_rejects_failed_or_changed_inputs(tmp_path, bad):
    _, step, source, _, _, _ = specimen()
    record = tmp_path / "runs/T12/T12-r0001.json"
    fixture = tmp_path / "traces/T12/T12-r0001.jsonl"
    record.parent.mkdir(parents=True)
    fixture.parent.mkdir(parents=True)
    record.write_text(json.dumps({"status": "aborted: incomplete" if bad == "status" else "completed",
        "start_state": {"sha256": source["start_state_sha256"]},
        "outputs": [{"name": "steps", "value": [step]}]}))
    fixture.write_text('{"schema":"synthetic"}\n')
    meta = {"week": source["t04_record"], "record": "runs/T12/T12-r0001.json", "cases": fixture.name,
            "record_sha256": "e" * 64 if bad == "record-digest" else placement.contests.sha(record),
            "cases_sha256": "f" * 64 if bad == "fixture-digest" else placement.contests.sha(fixture)}
    (tmp_path / "traces/T12/index.json").write_text(json.dumps({"records": [meta]}))
    with patch.object(placement, "ROOT", tmp_path):
        with pytest.raises(ValueError):
            placement.t12_source(source["t04_record"])


def test_failed_latest_input_receipt_remains_retryable(tmp_path):
    for number, status in ((1, "completed"), (2, "aborted: interrupted")):
        (tmp_path / f"T13-r{number:04d}.json").write_text(json.dumps(
            {"status": status, "actions": {"stream_key": "same"}}))
    with patch.object(placement, "RUNS", tmp_path):
        assert placement.selected_runs() == {}
