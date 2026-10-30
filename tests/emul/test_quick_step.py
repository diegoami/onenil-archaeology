"""Quick-step observations link literal synthetic traces; no DD02 simulation."""
import copy
import json
import sys
from pathlib import Path
from unittest.mock import patch

import pytest

sys.path.insert(0, str(Path(__file__).resolve().parents[2] / "runtime/emul"))
import quick_step


def state(seed, score=(0, 0)):
    clock = {"kind": 45, "remaining": 91, "delay": 0, "elapsed": 7,
             "added": 0, "active": 1, "zero": 0}
    return {"clock": clock, "seed": seed, "score_side": list(score),
            "goal_bytes": list(score), "ratings": [100] * 8, "clubs": [10, 20],
            "flags": {f"DS:{off:04X}": 0 for off in quick_step.FLAGS},
            "history_byte": score[0] + (score[1] << 4), "scorer_logs": [[], []],
            "players": [participant(i) for i in range(1, 23)],
            "save_block_digests": {name: "a" * 64 for name, _ in quick_step.match.save.BLOCKS}}


def participant(slot):
    return {"scene_slot": slot, "player": 200 + slot, "scene_word0": 0,
            "scene_word8": 0, "scene_byte19": 0, "p15_word2": 0, "p15_byte5": 0,
            "p15_sbyte6": 1, "p15_sbyte8": 10, "p15_byte11": 0}


def specimen():
    # Seed labels are observer fixtures, not a generator test. Values/sites form a
    # literal request sequence with one D983 call and a recorded placement decision.
    prefix = [{"kind": "draw", "i": i, "n": 16, "seed_before": i,
               "seed_after": i + 1, "value": 1, "callers": ["0AB9:1A01"]}
              for i in range(258)]
    sequence = [("D9BD", 100, 1), ("D9CC", 100, 2), ("D9E4", 100, 1),
                ("D9F3", 100, 2), ("DA0B", 100, 1), ("DA1A", 100, 2),
                ("D9BD", 100, 2), ("D9CC", 100, 1),
                ("DDE4", 90, 7), ("DE5C", 30, 2), ("5190", 2, 1), ("A3A4", 6, 1)]
    tail = [{"kind": "draw", "i": 258 + i, "n": n, "seed_before": 258 + i,
             "seed_after": 259 + i, "value": value,
             "callers": ["24BC:0D12", "0AB9:" + site]}
            for i, (site, n, value) in enumerate(sequence)]
    trace = [{"kind": "start", "state_sha256": "a" * 64},
             {"kind": "mark", "what": "match entry", "draws": 0}, *prefix, *tail,
             {"kind": "mark", "what": "match return", "draws": 270},
             {"kind": "end", "status": "completed"}]
    source = {"t04_record": "synthetic-week", "trace": "traces/T08/synthetic.jsonl",
              "trace_sha256": "b" * 64, "start_state_sha256": "a" * 64,
              "run_status": "completed", "verdict": "all screens met in order"}
    contest = {"draw_start": 258, "draw_end": 266, "seed_target": "2864:A51C",
               "input": {"k": 1, "seed": 258, "ratings": [100] * 8, "goals": [0, 0]},
               "output": {"seed": 266, "goals": [1, 0]}, "ratings_after": [100] * 8}
    before = state(258)
    after = state(270, (1, 0))
    step = {"draw_start": 258, "draw_end": 270, "input": before, "output": after,
            "contest": copy.deepcopy(contest),
            "ratings_calls": [{"club": 10, "side": 0, "flag": 1, "draw_start": 258,
                               "draw_end": 258, "values": [100] * 4},
                              {"club": 20, "side": 1, "flag": 0, "draw_start": 258,
                               "draw_end": 258, "values": [100] * 4}],
            "placement_input": {"draws": 266, "seed": 266, "generated": [1, 0],
                                "saved_scores": [0, 0], "goal_flag": 0, "clock": before["clock"].copy(),
                                "side_offsets": [0, 11], "minute_limit": 90},
            "placement_output": {"draws": 269, "seed": 269, "generated": [1, 0],
                                 "saved_scores": [1, 0], "goal_flag": 1, "clock": after["clock"].copy(),
                                 "side_offsets": [0, 11], "minute_limit": 90},
            "minute_fills": [{"draw_i": 266, "minute": 7, "outer_side": 1, "side": 1, "goal_index": 1}],
            "scorer_attempts": [{"draw_i": 267, "side": 1, "sampled_slot": 2,
                                 "player": 202, "unavailable": 0}],
            "scorer_mappings": [{"player": 202, "side": 1, "roster": list(range(201, 221)), "first_slot": 2}],
            "goal_calls": [{"minute": 7, "actor": 2, "side_flag": 1, "draw_start": 268,
                            "draw_end": 269, "before": state(268), "after": state(269)}],
            "history_write": {"score_word": 1, "before": 0, "after": 1},
            "scene_visits": [{"unavailable": 0, "before": participant(i), "after": participant(i)}
                             for i in range(1, 23)],
            "phases": [{"routine": "goal reset: 1998:045C,0AB9:52B6", "draw_start": 269, "draw_end": 270},
                       {"routine": "0AB9:78B7", "draw_start": 270, "draw_end": 270}],
            "added_time": [], "clock_before": after["clock"].copy(),
            "clock_after": {**after["clock"], "remaining": 90, "elapsed": 8}, "clock_result": 0}
    return step, contest, trace, source


def test_full_step_exports_literal_source_and_typed_observations():
    step, contest, trace, source = specimen()
    exported = quick_step.cases_for([step], [contest], trace, source)
    assert len(exported) == 1
    assert exported[0]["observation"] == step
    assert exported[0]["schema"] == "quick-step-observation/1"
    assert exported[0]["source"] == {"trace": source["trace"], "sha256": source["trace_sha256"]}
    assert exported[0]["draws"] == [quick_step.draw_view(d) for d in tail_draws(trace)]
    assert exported[0]["draws"][8] == {"site": "0AB9:DDE4", "i": 266, "n": 90,
                                       "seed_before": 266, "seed_after": 267, "value": 7}


def tail_draws(trace):
    return [d for d in trace if d["kind"] == "draw" and d["i"] >= 258]


@pytest.mark.parametrize("corrupt", ["missing-step", "overlap", "gap", "past-end", "input-seed", "output-seed",
                                     "contest", "ratings", "generated", "core-order", "scores", "scene-order",
                                     "scene-after", "scene-after-slot", "scene-predicate", "clock", "history", "predicate", "minute-index", "minute-value",
                                     "scorer-index", "goal-limit", "goal-flag", "goal-span", "source-indices"])
def test_missing_corrupt_spans_and_observations_are_rejected(corrupt):
    step, contest, trace, source = specimen()
    steps, calls = [step], [contest]
    if corrupt == "missing-step":
        steps = []
    elif corrupt == "overlap":
        steps.append(copy.deepcopy(step)); calls.append(copy.deepcopy(contest))
    elif corrupt == "gap":
        step["draw_start"] = 257; step["input"]["seed"] = 257
    elif corrupt == "past-end":
        step["draw_end"] = 999
    elif corrupt == "input-seed":
        step["input"]["seed"] += 1
    elif corrupt == "output-seed":
        step["output"]["seed"] += 1
    elif corrupt == "contest":
        step["contest"]["input"]["ratings"][0] += 1
    elif corrupt == "ratings":
        step["ratings_calls"].pop()
    elif corrupt == "generated":
        step["placement_input"]["generated"] = [0, 0]
    elif corrupt == "core-order":
        step["placement_output"]["draws"] = 265
    elif corrupt == "scores":
        step["placement_output"]["saved_scores"] = [0, 0]
    elif corrupt == "scene-order":
        step["scene_visits"].reverse()
    elif corrupt == "scene-after":
        del step["scene_visits"][0]["after"]
    elif corrupt == "scene-after-slot":
        step["scene_visits"][0]["after"]["scene_slot"] = 2
    elif corrupt == "scene-predicate":
        step["scene_visits"][0]["unavailable"] = None
    elif corrupt == "clock":
        del step["clock_after"]
    elif corrupt == "history":
        del step["history_write"]
    elif corrupt == "predicate":
        del step["scorer_attempts"][0]["unavailable"]
    elif corrupt == "minute-index":
        step["minute_fills"][0]["draw_i"] += 1
    elif corrupt == "minute-value":
        step["minute_fills"][0]["minute"] += 1
    elif corrupt == "scorer-index":
        step["scorer_attempts"][0]["draw_i"] += 1
    elif corrupt == "goal-limit":
        step["goal_calls"].append(copy.deepcopy(step["goal_calls"][0]))
        step["placement_output"]["goal_flag"] = 2
    elif corrupt == "goal-flag":
        step["placement_output"]["goal_flag"] = 0
    elif corrupt == "goal-span":
        step["goal_calls"][0]["draw_end"] = 270
    else:
        trace[-3]["i"] = 999
    with pytest.raises(ValueError):
        quick_step.cases_for(steps, calls, trace, source)


def test_failed_latest_receipt_is_retryable(tmp_path):
    for n, status in ((1, "completed"), (2, "aborted: interrupted")):
        (tmp_path / f"T12-r{n:04d}.json").write_text(json.dumps(
            {"status": status, "actions": {"stream_key": "same"}}))
    with patch.object(quick_step, "RUNS", tmp_path):
        assert quick_step.selected_runs() == {}


@pytest.mark.parametrize("corrupt", ["state", "status", "missing-end", "empty"])
def test_reference_state_and_completion_rejected(corrupt):
    step, contest, trace, source = specimen()
    if corrupt == "state":
        source["start_state_sha256"] = "c" * 64
    elif corrupt == "status":
        trace[-1]["status"] = "stopped"
    elif corrupt == "missing-end":
        trace.pop()
    else:
        trace = []
    with pytest.raises(ValueError):
        quick_step.cases_for([step], [contest], trace, source)


@pytest.mark.parametrize("corrupt", ["predicate-none", "mapping-missing", "mapping-slot", "mapping-player",
                                     "goal-minute", "goal-actor", "goal-side", "clock-value", "clock-return",
                                     "clock-shape", "history-value", "history-word"])
def test_callback_results_and_clock_history_linkage_rejected(corrupt):
    step, contest, trace, source = specimen()
    if corrupt == "predicate-none":
        step["scorer_attempts"][0]["unavailable"] = None
    elif corrupt == "mapping-missing":
        step["scorer_mappings"] = []
    elif corrupt == "mapping-slot":
        step["scorer_mappings"][0]["first_slot"] = 3
    elif corrupt == "mapping-player":
        step["scorer_mappings"][0]["player"] = 203
    elif corrupt == "goal-minute":
        step["goal_calls"][0]["minute"] += 1
    elif corrupt == "goal-actor":
        step["goal_calls"][0]["actor"] += 1
    elif corrupt == "goal-side":
        step["goal_calls"][0]["side_flag"] = 0
    elif corrupt == "clock-value":
        step["clock_before"]["remaining"] = 88
    elif corrupt == "clock-return":
        step["clock_result"] = 2
    elif corrupt == "clock-shape":
        del step["clock_after"]["remaining"]
    elif corrupt == "history-value":
        step["history_write"]["after"] = 2
    else:
        step["history_write"]["score_word"] = 0
    with pytest.raises(ValueError):
        quick_step.cases_for([step], [contest], trace, source)


def test_duplicate_roster_ids_require_first_matching_mapping_result():
    step, contest, trace, source = specimen()
    step["scorer_mappings"][0]["roster"][0] = 202
    with pytest.raises(ValueError):
        quick_step.cases_for([step], [contest], trace, source)
    # Matching the first occurrence is accepted when the callback and actor agree.
    step["scorer_mappings"][0]["first_slot"] = 1
    step["goal_calls"][0]["actor"] = 1
    assert len(quick_step.cases_for([step], [contest], trace, source)) == 1


@pytest.mark.parametrize("status,state_sha,corrupt_digest", [("aborted: incomplete", "a" * 64, False),
                                                           ("completed", "c" * 64, False),
                                                           ("completed", "a" * 64, True)])
def test_t11_provenance_status_state_and_digest_are_checked(tmp_path, status, state_sha, corrupt_digest):
    _, contest, _, source = specimen()
    record = tmp_path / "runs/T11/T11-r0001.json"
    record.parent.mkdir(parents=True)
    record.write_text(json.dumps({"status": status, "start_state": {"sha256": state_sha},
                                  "outputs": [{"name": "calls", "value": [contest]}]}))
    index = tmp_path / "traces/T11/index.json"
    index.parent.mkdir(parents=True)
    index.write_text(json.dumps({"records": [{"week": source["t04_record"], "record": "runs/T11/T11-r0001.json",
                                               "record_sha256": "d" * 64 if corrupt_digest else quick_step.contests.sha(record)}]}))
    with patch.object(quick_step, "ROOT", tmp_path):
        with pytest.raises(ValueError):
            quick_step.t11_calls(source)


def test_build_index_rejects_changed_fixture_even_with_updated_fixture_digest(tmp_path):
    step, contest, trace, source = specimen()
    fixture = tmp_path / "traces/T12/T12-r0001.jsonl"
    fixture.parent.mkdir(parents=True)
    rows = quick_step.cases_for([step], [contest], trace, source)
    rows[0]["observation"]["output"]["seed"] = 999
    fixture.write_text(json.dumps(rows[0]) + "\n")
    record = tmp_path / "runs/T12/T12-r0001.json"
    record.parent.mkdir(parents=True)
    record.write_text(json.dumps({"status": "completed", "code_commit": "synthetic",
        "start_state": {"sha256": source["start_state_sha256"]},
        "actions": {"stream_key": "synthetic", "source": source},
        "outputs": [{"name": "steps", "value": [step]}],
        "observations": [{"field": "fixture path", "value": "traces/T12/T12-r0001.jsonl"},
                         {"field": "fixture sha256", "value": quick_step.contests.sha(fixture)}]}))
    with patch.object(quick_step, "ROOT", tmp_path), patch.object(quick_step, "RUNS", record.parent), \
         patch.object(quick_step.contests, "read_corpus", return_value=({}, {"synthetic": [(source, trace)]})), \
         patch.object(quick_step, "t11_calls", return_value=[contest]):
        with pytest.raises(ValueError):
            quick_step.build_index()
