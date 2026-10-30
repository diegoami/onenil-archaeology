"""Complete raw ratings observations, checked without a Python engine model."""
import copy
import importlib.util
import sys
from pathlib import Path
from unittest.mock import patch

import pytest

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / "runtime/emul"))
spec = importlib.util.spec_from_file_location("original_ratings_observer", ROOT / "runtime/emul/ratings.py")
observer = importlib.util.module_from_spec(spec)
spec.loader.exec_module(observer)
from test_contests import specimen as contest_specimen


def test_complete_committed_public_ratings_corpus():
    # The original, emulator and private savestates are not needed for this check.
    assert observer.main(["--check"]) == 0


@pytest.mark.parametrize("prefix", ["traces/T15/T15-r", "runs/T15/T15-r", "runs/T09/T09-r", "traces/T08/"])
def test_public_corpus_rejects_record_fixture_and_retained_source_digest_changes(prefix):
    original_sha = observer.contests.sha

    def damaged_sha(path):
        relative = Path(path).relative_to(ROOT).as_posix()
        return "0" * 64 if relative.startswith(prefix) else original_sha(path)

    with patch.object(observer.contests, "sha", side_effect=damaged_sha):
        assert observer.main(["--check"]) == 1


def raw_tables():
    return {"halving_group": [0, 1, 0], "halving_flags": [[0] * 14, [1] * 14],
            "position_class": [0, 1, 1, 4, 4, 2, 2, 2, 2, 5, 5, 5, 3, 3],
            "drop_divisors": [8, 16], "home_divisors": [16, 64]}


def raw_player():
    return {"id": 17, "p8_4": 68, "p8_6": 1, "p8_7": 1,
            "p15_6": 255, "p15_8": 2, "p15_11": 0}


def specimen():
    contest, trace, source = contest_specimen()
    source["t04_record"] = "synthetic-week"
    player = {"input": {"player": raw_player(), "mode": 0, "tables": raw_tables()},
              "output": {"value": 7, "unavailable": 0, "halved": 0, "halving_selectors": [1, 1]}}
    bonus = {"input": {"club": 1, "staff_ids": [2, 2], "staff": [{"id": 2, "byte2": 0}]},
             "output": {"bonus": 16}}
    sides = []
    before = [0] * 8
    for side in (0, 1):
        inp = {"club": 1, "side": side, "flag": side, "club_37": 1,
               "roster": [17] + [0] * 10, "players": [raw_player()], "tables": raw_tables(),
               "ratings": before.copy(), "seed": 10, "staff_ids": [2, 2], "staff": [{"id": 2, "byte2": 0}]}
        after = before.copy()
        after[side::2] = [7] * 4
        sides.append({"input": inp, "output": {"ratings": after.copy(), "seed": 10},
                      "draw_start": 0, "draw_end": 0,
                      "helpers": {"bonus": copy.deepcopy(bonus), "players": [copy.deepcopy(player)]},
                      "helper_indices": {"player_start": side, "player_end": side + 1,
                                         "bonus_start": side, "bonus_end": side + 1}})
        before = after
    handoff = {"after_sides": 2, "sides": [0, 1], "ratings": [7] * 8, "seed": 10, "draw_start": 0}
    observed = {"sides": sides, "players": [copy.deepcopy(player), copy.deepcopy(player)],
                "bonuses": [copy.deepcopy(bonus), copy.deepcopy(bonus)],
                "handoffs": [handoff], "contests": [contest]}
    old = {"players": [observer.legacy_player(p) for p in observed["players"]],
           "bonuses": [observer.legacy_bonus(b) for b in observed["bonuses"]],
           "sides": [observer.legacy_side(s) for s in sides],
           "contests": [{"after_sides": 2, "values": [7] * 8}]}
    r09 = {"status": "completed", "start_state": {"sha256": source["start_state_sha256"]},
           "outputs": [{"name": n, "value": v} for n, v in old.items()]}
    cases11 = observer.contests.cases_for([contest], trace, source, source["t04_record"])
    meta11 = {"record": "runs/T11/synthetic.json", "record_sha256": "e" * 64,
              "cases": "synthetic.jsonl", "cases_sha256": "f" * 64}
    linked = ((ROOT / "runs/T09/synthetic.json", r09), meta11,
              {"start_state": {"sha256": source["start_state_sha256"]}}, cases11)
    return observed, source, trace, linked


def export(observed, source, trace, linked):
    with patch.object(observer, "sources", return_value=linked), patch.object(observer.contests, "sha", return_value="c" * 64):
        return observer.cases_for(observed, source, trace)


def test_literal_raw_side_and_helper_observations_export_without_expected_inputs():
    observed, source, trace, linked = specimen()
    sides, pairs, helpers = export(observed, source, trace, linked)
    assert len(sides) == 2
    assert len(pairs) == 1
    assert len(helpers) == 4
    assert sides[0]["input"] == observed["sides"][0]["input"]
    assert sides[0]["input"]["players"][0]["p15_6"] == 255
    assert sides[0]["helpers"]["players"][0]["output"]["halving_selectors"] == [1, 1]
    assert pairs[0]["sides"] == [0, 1]
    assert pairs[0]["contest"] == linked[-1][0]
    assert "unavailable" not in sides[0]["input"]["players"][0]
    assert sides[0]["source"]["t09_record_sha256"] == "c" * 64


@pytest.mark.parametrize("corruption", [
    "missing-table", "short-table", "group-outside", "bad-divisor", "missing-player", "duplicate-player",
    "player-bounds", "player-byte", "player-missing-field", "player-position", "player-selector", "roster-width",
    "roster-player", "club-bounds", "side-bounds", "missing-staff", "duplicate-staff", "staff-byte",
    "staff-id-float", "staff-id-bool", "flag-bool", "draw-end-float", "seed", "rng", "other-side",
    "helper-player", "helper-tables", "helper-mode", "missing-helper", "unavailable", "missing-halved",
    "selector-calls", "selector-type", "helper-value", "bonus-value", "player-indices", "bonus-indices",
    "missing-handoff", "handoff-pair", "handoff-latest", "handoff-boundary", "handoff-seed", "handoff-draw",
    "t09-value", "t09-missing", "t11-input", "trace-state", "trace-incomplete", "trace-draw", "missing-field",
])
def test_incomplete_corrupt_mistyped_raw_inputs_and_provenance_are_rejected(corruption):
    obs, source, trace, linked = specimen()
    side = obs["sides"][0]
    if corruption == "missing-table": del side["input"]["tables"]["halving_group"]
    elif corruption == "short-table": side["input"]["tables"]["halving_flags"][0].pop()
    elif corruption == "group-outside": side["input"]["tables"]["halving_group"][0] = 2
    elif corruption == "bad-divisor": side["input"]["tables"]["drop_divisors"][1] = 0
    elif corruption == "missing-player": side["input"]["players"] = []
    elif corruption == "duplicate-player": side["input"]["players"].append(raw_player())
    elif corruption == "player-bounds": side["input"]["players"][0]["id"] = 3921
    elif corruption == "player-byte": side["input"]["players"][0]["p15_6"] = -1
    elif corruption == "player-missing-field": del side["input"]["players"][0]["p15_11"]
    elif corruption == "player-position": side["input"]["players"][0]["p8_6"] = 14
    elif corruption == "player-selector": side["input"]["players"][0]["p8_7"] = 14
    elif corruption == "roster-width": side["input"]["roster"].pop()
    elif corruption == "roster-player": side["input"]["roster"][0] = 18
    elif corruption == "club-bounds": side["input"]["club"] = 177
    elif corruption == "side-bounds": side["input"]["side"] = 2
    elif corruption == "missing-staff": side["input"]["staff"] = []
    elif corruption == "duplicate-staff": side["helpers"]["bonus"]["input"]["staff"].append({"id": 2, "byte2": 0})
    elif corruption == "staff-byte": side["helpers"]["bonus"]["input"]["staff"][0]["byte2"] = 256
    elif corruption == "staff-id-float": side["input"]["staff"][0]["id"] = 2.0
    elif corruption == "staff-id-bool": side["input"]["staff"][0]["id"] = True
    elif corruption == "flag-bool": side["input"]["flag"] = False
    elif corruption == "draw-end-float": side["draw_end"] = 0.0
    elif corruption == "seed": side["output"]["seed"] = 11
    elif corruption == "rng": side["draw_end"] = 1
    elif corruption == "other-side": side["output"]["ratings"][1] = 7
    elif corruption == "helper-player": side["helpers"]["players"][0]["input"]["player"]["p8_4"] = 69
    elif corruption == "helper-tables": side["helpers"]["players"][0]["input"]["tables"]["home_divisors"][1] = 63
    elif corruption == "helper-mode": side["helpers"]["players"][0]["input"]["mode"] = 1
    elif corruption == "missing-helper": side["helpers"]["players"] = []
    elif corruption == "unavailable": side["helpers"]["players"][0]["output"]["unavailable"] = 1
    elif corruption == "missing-halved": side["helpers"]["players"][0]["output"]["halved"] = None
    elif corruption == "selector-calls": side["helpers"]["players"][0]["output"]["halving_selectors"] = []
    elif corruption == "selector-type": side["helpers"]["players"][0]["output"]["halving_selectors"][0] = True
    elif corruption == "helper-value": side["helpers"]["players"][0]["output"]["value"] = 8
    elif corruption == "bonus-value": side["helpers"]["bonus"]["output"]["bonus"] = 17
    elif corruption == "player-indices": side["helper_indices"]["player_start"] = 1
    elif corruption == "bonus-indices": side["helper_indices"]["bonus_end"] = 2
    elif corruption == "missing-handoff": obs["handoffs"] = []
    elif corruption == "handoff-pair": obs["handoffs"][0]["sides"] = [0, 0]
    elif corruption == "handoff-latest": obs["handoffs"][0]["sides"] = [1, 0]
    elif corruption == "handoff-boundary": obs["sides"][1]["input"]["ratings"][0] = 0
    elif corruption == "handoff-seed": obs["handoffs"][0]["seed"] = 11
    elif corruption == "handoff-draw": obs["handoffs"][0]["draw_start"] = 1
    elif corruption == "t09-value": linked[0][1]["outputs"][0]["value"][0]["value"] = 8
    elif corruption == "t09-missing": linked[0][1]["outputs"][0]["value"].pop()
    elif corruption == "t11-input": linked[-1][0]["input"]["ratings"][0] = 8
    elif corruption == "trace-state": trace[0]["state_sha256"] = "z" * 64
    elif corruption == "trace-incomplete": trace[-1]["status"] = "aborted"
    elif corruption == "trace-draw": trace[1]["n"] = 8
    elif corruption == "missing-field": del side["helpers"]
    with pytest.raises(ValueError):
        export(obs, source, trace, linked)


def test_absent_unreached_halving_call_stays_null():
    call = {"input": {"player": raw_player(), "mode": 0, "tables": raw_tables()},
            "output": {"value": 0, "unavailable": 1, "halved": None, "halving_selectors": []}}
    observer.validate_player_call(call)
    assert observer.legacy_player(call)["halved"] == 0
    assert call["output"]["halved"] is None


def test_failed_latest_run_is_not_treated_as_completed(tmp_path):
    import json
    for i, status in enumerate(("completed", "aborted: stopped"), 1):
        (tmp_path / f"T15-r{i:04d}.json").write_text(json.dumps(
            {"actions": {"stream_key": "same"}, "status": status}))
    with patch.object(observer, "RUNS", tmp_path):
        assert "same" not in observer.selected_runs()
