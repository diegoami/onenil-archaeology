"""Routine recorder linkage is checked against literal traces, without a D983 model."""
import copy
import json
import sys
from pathlib import Path
from unittest.mock import patch

import pytest

sys.path.insert(0, str(Path(__file__).resolve().parents[2] / "runtime/emul"))
import contests


def specimen():
    draws = [{"kind": "draw", "i": i, "n": 7, "seed_before": 10 + i,
              "seed_after": 11 + i, "value": 1, "callers": ["24BC:0D12", "0AB9:D9BD"]}
             for i in range(4)]
    trace = [{"kind": "start", "state_sha256": "a" * 64}, *draws,
             {"kind": "mark", "what": "match return", "draws": 4}, {"kind": "end", "status": "completed"}]
    source = {"trace": "synthetic.jsonl", "trace_sha256": "b" * 64, "start_state_sha256": "a" * 64,
              "run_status": "completed", "verdict": "all screens met in order"}
    call = {"draw_start": 0, "draw_end": 4, "input": {"k": 1, "seed": 10, "ratings": [7] * 8, "goals": [0, 0]},
            "output": {"seed": 14, "goals": [0, 0]}, "ratings_after": [7] * 8}
    return call, trace, source


def test_fixture_is_literal_original_span_with_recorded_outputs():
    call, trace, source = specimen()
    cases = contests.cases_for([call], trace, source, "synthetic-week")
    assert cases[0]["input"] == call["input"]
    assert cases[0]["output"] == call["output"]
    assert len(cases[0]["draws"]) == 4
    assert cases[0]["draws"][0] == {"site": "0AB9:D9BD", "n": 7, "seed_before": 10, "seed_after": 11, "value": 1}


@pytest.mark.parametrize("corruption", ["missing", "span", "overlap", "input-seed", "output-seed", "ratings", "indices", "site"])
def test_incomplete_or_corrupted_linkage_rejected(corruption):
    call, trace, source = specimen()
    calls = [call]
    if corruption == "missing":
        calls = []
    elif corruption == "span":
        call["draw_end"] = 3
        call["output"]["seed"] = 13
    elif corruption == "overlap":
        calls.append(copy.deepcopy(call))
    elif corruption == "input-seed":
        call["input"]["seed"] = 11
    elif corruption == "output-seed":
        call["output"]["seed"] = 15
    elif corruption == "ratings":
        call["ratings_after"][0] = 8
    elif corruption == "indices":
        trace[1]["i"] = 99
    else:
        trace[1]["callers"] = ["0AB9:0000"]
    with pytest.raises(ValueError):
        contests.cases_for(calls, trace, source, "synthetic-week")


def test_grouping_rejects_wrong_state_digest_and_incomplete_trace(tmp_path):
    _, trace, source = specimen()
    path = tmp_path / "synthetic.jsonl"
    path.write_text("\n".join(json.dumps(x) for x in trace) + "\n")
    source["trace_sha256"] = contests.sha(path)
    index = {"entries": [source]}
    read = lambda p: (path, trace)
    assert len(contests.corpus_groups(index, read)) == 1
    for field, wrong in (("start_state_sha256", "c" * 64), ("trace_sha256", "d" * 64),
                         ("run_status", "aborted: stopped")):
        damaged = copy.deepcopy(index)
        damaged["entries"][0][field] = wrong
        with pytest.raises(ValueError):
            contests.corpus_groups(damaged, read)
    trace[-1]["status"] = "stopped"
    with pytest.raises(ValueError):
        contests.corpus_groups(index, read)


def test_failed_run_is_not_selected_as_completed_coverage(tmp_path):
    for n, status in ((1, "completed"), (2, "aborted: stopped")):
        (tmp_path / f"T11-r{n:04d}.json").write_text(json.dumps(
            {"run_id": f"T11-r{n:04d}", "status": status, "actions": {"stream_key": "same"}}))
    with patch.object(contests, "RUNS", tmp_path):
        assert "same" not in contests.selected_runs()
