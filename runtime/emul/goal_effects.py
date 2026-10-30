#!/usr/bin/env python3
"""T14: original logical goal effects and byte6 helpers, with RNG kept separate.

    python3 runtime/emul/goal_effects.py --run
    python3 runtime/emul/goal_effects.py --check

Only decoded logical fields and numeric event metadata are exported. No effects
formula is implemented here; the Rust consumer computes the state changes.
"""
import argparse
import hashlib
import json
import platform
from pathlib import Path

import contests
import match
import placement
import quick_step

ROOT = contests.ROOT
RUNS, FIXTURES = ROOT / "runs/T14", ROOT / "traces/T14"
FLAGS = {"d1ca": 0xD1CA, "d6dd": 0xD6DD, "d0b7": 0xD0B7, "d0b9": 0xD0B9}


def next_row(index):
    return 1 if index == 1700 else index + 1


def row_indices(head):
    return [head, next_row(head), next_row(next_row(head))]


def queue_row(g, index):
    address = g.DS * 16 + 0xA52A + 6 * index
    return {"index": index, "code": g.mem(address, 1)[0], "first_player": g.word_at(address + 1),
            "second_player": g.word_at(address + 3), "side": g.mem(address + 5, 1)[0]}


def snapshot(g, indices=None, player_ids=None):
    head = g.rd(0x0380)
    if not 0 <= head <= 1700:
        raise ValueError("unsupported numeric commentary head")
    indices = indices if indices is not None else row_indices(head)
    rosters = []
    clubs = [g.rd(0xD6E6), g.rd(0xD6E4)]
    for club in clubs:
        base = g.far(0xD7C2) + (club - 1) * 62
        rosters.append([g.word_at(base + 2 * i) for i in range(20)])
    scenes = []
    for index in range(1, 23):
        base = g.DS * 16 + 0xCCEF + 25 * index
        scenes.append({"index": index, "player": g.word_at(base + 14), "slot": g.mem(base + 7, 1)[0]})
    if player_ids is None:
        player_ids = sorted({p for r in rosters for p in r} | {s["player"] for s in scenes})
    players = []
    for player in player_ids:
        p8, p15 = g.far(0xD7BA) + player * 8, g.far(0xD7BE) + player * 15
        players.append({"id": player, "p8_position": g.mem(p8 + 6, 1)[0], "p8_flag7": g.mem(p8 + 7, 1)[0],
                        "p15_word2": g.word_at(p15 + 2), "p15_byte5": g.mem(p15 + 5, 1)[0],
                        "p15_byte6": g.mem(p15 + 6, 1)[0]})
    return {"global_actor": g.rd(0xD09F, 1), "secondary_actor": g.rd(0xD0A0, 1),
            "clubs": clubs, "side_offsets": [g.rd(0x0D57, 1), g.rd(0x0D56, 1)],
            "flags": {name: g.rd(off, 1) for name, off in FLAGS.items()},
            "position_deltas": [quick_step.signed(g.rd(0x0D1A + i, 1)) for i in range(14)],
            "event_weights": [quick_step.signed(g.rd(0x097A + 0x26 + i, 1)) for i in range(2)],
            "scenes": scenes, "rosters": rosters, "players": players,
            "event_totals": [[g.rd(0xD146 + 40 * side + 2 * slot) for slot in range(1, 21)] for side in range(2)],
            "cache": [[g.rd(0xD197 + 20 * side + slot, 1) for slot in range(1, 21)] for side in range(2)],
            "event_counts": [g.rd(0xD1C0 + 2 * side) for side in range(2)],
            "side_counts": [g.rd(0xD0D6 + 10 * side, 1) for side in range(2)],
            "log_counts": [g.rd(0xD128 + side, 1) for side in range(2)],
            "logs": [[{"player": g.rd(0xD0E3 + 33 * side + 3 * slot),
                       "minute_byte": g.rd(0xD0E5 + 33 * side + 3 * slot, 1)}
                      for slot in range(1, 12)] for side in range(2)],
            "source_pair": [g.rd(0xD08A), g.rd(0xD08C)], "target_pair": [g.rd(0xD09A), g.rd(0xD09C)],
            "queue": {"head": head, "rows": [queue_row(g, i) for i in indices]}}


class Recorder:
    def __init__(self, week):
        self.week, self.active, self.pending, self.calls = week, False, None, []
        self.step, self.helper, self.commentary = -1, None, None
        for address, callback in {
            match.MATCH: lambda g: setattr(self, "active", True),
            match.MATCH_RETURN: lambda g: setattr(self, "active", False),
            "0AB9:DD02": self.step_enter, "0AB9:5083": self.enter,
            "0AB9:5190": self.coin, "0AB9:5263": self.leave,
            "0AB9:67D0": self.helper_enter, "0AB9:6845": self.helper_leave,
            "0AB9:0F94": self.commentary_enter, "0AB9:0FAD": self.commentary_leave,
        }.items():
            week.g.code_hook(address, callback)

    def step_enter(self, g):
        if self.active:
            self.step += 1

    def enter(self, g):
        if not self.active or g.stack_word(0) != 0xDF0F:
            return
        if self.pending is not None or g.reg("ds") != g.DS:
            raise ValueError("unexpected goal-effect nesting or data segment")
        self.pending = {"step": self.step, "draw_start": self.week.draws,
                        "seed_before": g.word_at(g.far(0xDE84)),
                        "event": {"minute": g.stack_word(2), "actor": g.stack_word(4),
                                  "side_flag": g.stack_word(6) & 255},
                        "before": snapshot(g), "helper_calls": []}

    def coin(self, g):
        if self.pending is not None:
            if "coin" in self.pending:
                raise ValueError("multiple coin observations")
            self.pending["coin"] = g.reg("ax") & 255

    def helper_enter(self, g):
        if self.pending is None:
            return
        if self.helper is not None:
            raise ValueError("nested byte6 helper")
        scene = g.stack_word(6) * 16 + g.stack_word(4)
        player, slot = g.word_at(scene + 14), g.mem(scene + 7, 1)[0]
        if not 1 <= slot <= 22:
            raise ValueError("unsupported referenced scene slot")
        side, normalized = int(slot < 12), slot - 11 if slot > 11 else slot
        self.helper_player = g.far(0xD7BE) + player * 15
        self.helper_cache = g.DS * 16 + 0xD197 + 20 * side + normalized
        delta = g.stack_word(10)
        self.helper = {"input": {"old_byte6": g.mem(self.helper_player + 6, 1)[0],
                                  "delta": delta - 65536 if delta >= 32768 else delta,
                                  "cache_flag": g.stack_word(8) & 255,
                                  "cache_before": g.mem(self.helper_cache, 1)[0]},
                       "scene_player": player, "scene_slot": slot, "cache_side": side, "cache_slot": normalized}

    def helper_leave(self, g):
        if self.helper is not None:
            self.helper["output"] = {"byte6": g.mem(self.helper_player + 6, 1)[0],
                                      "cache": g.mem(self.helper_cache, 1)[0]}
            self.pending["helper_calls"].append(self.helper)
            self.helper = None

    def commentary_enter(self, g):
        if self.pending is not None:
            if self.commentary is not None:
                raise ValueError("multiple numeric commentary calls")
            self.commentary = {"code": g.stack_word(2) & 255, "secondary_slot": g.stack_word(4),
                               "actor_slot": g.stack_word(6), "event_side": g.stack_word(8) & 255}

    def commentary_leave(self, g):
        if self.pending is not None and self.commentary is not None:
            self.commentary["accepted"] = g.reg("ax") & 255
            self.pending["commentary"] = self.commentary

    def leave(self, g):
        if self.pending is not None:
            before = self.pending["before"]
            self.pending.update(draw_end=self.week.draws, seed_after=g.word_at(g.far(0xDE84)),
                                after=snapshot(g, [r["index"] for r in before["queue"]["rows"]],
                                               [p["id"] for p in before["players"]]))
            self.calls.append(self.pending)
            self.pending, self.commentary = None, None


def ints(values, low, high, length=None):
    return (length is None or len(values) == length) and all(placement.integer(v, low, high) for v in values)


def reject_numeric_aliases(value):
    if type(value) in (bool, float):
        raise ValueError("logical numeric fields require exact integers")
    if isinstance(value, dict):
        for item in value.values():
            reject_numeric_aliases(item)
    elif isinstance(value, list):
        for item in value:
            reject_numeric_aliases(item)


def validate_state(state, event, indices=None):
    if not (placement.integer(state["global_actor"], 1, 22) and placement.integer(state["secondary_actor"], 0, 22)
            and ints(state["clubs"], 1, 176, 2) and ints(state["side_offsets"], 0, 21, 2)
            and set(state["flags"]) == set(FLAGS) and ints(state["flags"].values(), 0, 255)
            and ints(state["position_deltas"], -128, 127, 14) and ints(state["event_weights"], -128, 127, 2)):
        raise ValueError("invalid logical selectors, flags or signed tables")
    scenes = state["scenes"]
    if [s["index"] for s in scenes] != list(range(1, 23)) or any(
            not placement.integer(s["player"], 0, 3920) or not placement.integer(s["slot"], 0, 255) for s in scenes):
        raise ValueError("complete typed scenes missing")
    refs = {event["actor"], state["global_actor"], state["side_offsets"][event["side_flag"]] + 1}
    if state["secondary_actor"]:
        refs.add(state["secondary_actor"])
    if any(not 1 <= scenes[i - 1]["slot"] <= 22 for i in refs):
        raise ValueError("unsupported referenced scene layout")
    rosters, players = state["rosters"], state["players"]
    if len(rosters) != 2 or any(not ints(r, 0, 3920, 20) for r in rosters):
        raise ValueError("complete typed rosters missing")
    ids = {p for r in rosters for p in r} | {s["player"] for s in scenes}
    if len(players) != len(ids) or {p["id"] for p in players} != ids:
        raise ValueError("complete shared player-ID records missing")
    for p in players:
        if not (placement.integer(p["id"], 0, 3920) and placement.integer(p["p8_position"], 0, 13)
                and ints([p["p8_flag7"], p["p15_byte5"], p["p15_byte6"]], 0, 255)
                and placement.integer(p["p15_word2"], 0, 65535)):
            raise ValueError("invalid typed player fields")
    for name, high in (("event_totals", 65535), ("cache", 255)):
        if len(state[name]) != 2 or any(not ints(r, 0, high, 20) for r in state[name]):
            raise ValueError("incomplete logical matrix")
    for name, high in (("event_counts", 65535), ("side_counts", 255), ("log_counts", 11),
                       ("source_pair", 65535), ("target_pair", 65535)):
        if not ints(state[name], 0, high, 2):
            raise ValueError("invalid typed logical counter/pair")
    if len(state["logs"]) != 2 or any(len(r) != 11 for r in state["logs"]) or any(
            not placement.integer(e["player"], 0, 65535) or not placement.integer(e["minute_byte"], 0, 255)
            for r in state["logs"] for e in r):
        raise ValueError("complete typed scorer logs missing")
    queue = state["queue"]
    if not placement.integer(queue["head"], 0, 1700):
        raise ValueError("invalid queue head")
    expected = indices if indices is not None else row_indices(queue["head"])
    if [r["index"] for r in queue["rows"]] != expected or any(
            not ints([r["index"]], 0, 1700) or not ints([r["code"], r["side"]], 0, 255)
            or not ints([r["first_player"], r["second_player"]], 0, 65535) for r in queue["rows"]):
        raise ValueError("queue projection is incomplete or reordered")


def sources(week):
    index = json.loads((ROOT / "traces/T13/index.json").read_text())
    meta = next(r for r in index["records"] if r["week"] == week)
    path, fixture = ROOT / meta["record"], ROOT / "traces/T13" / meta["cases"]
    if contests.sha(path) != meta["record_sha256"] or contests.sha(fixture) != meta["cases_sha256"]:
        raise ValueError("T13 source digest differs")
    record = json.loads(path.read_text())
    if record["status"] != "completed":
        raise ValueError("T13 source incomplete")
    t12meta, t12rec, steps = placement.t12_source(week)
    return meta, record, contests.events(fixture), t12meta, t12rec, steps


def _cases_for(calls, source, trace, reference_source=None):
    reject_numeric_aliases(calls)
    meta, previous, placements, t12meta, _, steps = sources(source["t04_record"])
    reference_source = reference_source or source
    if (previous["start_state"]["sha256"] != source["start_state_sha256"]
            or trace[0]["state_sha256"] != reference_source["start_state_sha256"]
            or trace[-1].get("kind") != "end" or trace[-1]["status"] != "completed"):
        raise ValueError("goal-effect source/state/completion differs")
    expected = [c for c in placements if c["callbacks"]]
    if len(calls) != len(expected):
        raise ValueError("missing original goal-effect call")
    draws, result = contests.draw_stream(trace), []
    for call, old in zip(calls, expected):
        step = steps[old["step"]]
        oldgoal, contract = step["goal_calls"][0], old["callbacks"][0]
        if (call["step"] != old["step"] or call["draw_start"] != oldgoal["draw_start"]
                or call["draw_end"] != oldgoal["draw_end"] or call["event"] != contract["event"]
                or not placement.typed_event(call["event"]) or not placement.integer(call["coin"], 0, 1)):
            raise ValueError("goal-effect request or bounds differ")
        request = {"event": call["event"], "coin": call["coin"],
                   "draws": placement.normalized_span(draws, call["draw_start"], call["draw_end"])}
        if (not placement.same_json(request, contract) or len(request["draws"]) != 1
                or call["seed_before"] != request["draws"][0]["seed_before"]
                or call["seed_after"] != request["draws"][0]["seed_after"]):
            raise ValueError("consumed-coin provenance differs")
        before, after = call["before"], call["after"]
        validate_state(before, call["event"])
        validate_state(after, call["event"], [r["index"] for r in before["queue"]["rows"]])
        for name in ("global_actor", "secondary_actor", "clubs", "side_offsets", "flags",
                     "position_deltas", "event_weights", "scenes", "rosters"):
            if not placement.same_json(before[name], after[name]):
                raise ValueError("untranslated logical input changed")
        if before["rosters"] != old["input"]["rosters"]:
            raise ValueError("roster input differs from T13")
        for snapshot_name in ("before", "after"):
            state = call[snapshot_name]
            previous_state = oldgoal[snapshot_name]
            if (state["global_actor"] != previous_state["flags"]["DS:D09F"]
                    or state["secondary_actor"] != previous_state["flags"]["DS:D0A0"]
                    or any(state["flags"][k] != (previous_state["clock"]["zero"] if k == "d0b9"
                           else previous_state["flags"][f"DS:{address:04X}"]) for k, address in FLAGS.items())):
                raise ValueError("logical selectors differ from retained T12")
            pmap = {p["id"]: p for p in state["players"]}
            for p in previous_state["players"]:
                q = pmap[p["player"]]
                if (q["p15_word2"] != p["p15_word2"] or q["p15_byte5"] != p["p15_byte5"]
                        or q["p15_byte6"] != (p["p15_sbyte6"] & 255)):
                    raise ValueError("player effects differ from retained T12")
            active_logs = [row[:count] for row, count in zip(state["logs"], state["log_counts"])]
            if active_logs != previous_state["scorer_logs"]:
                raise ValueError("scorer-log effects differ from T12")
        commentary = call["commentary"]
        if not (placement.integer(commentary["code"], 0, 255)
                and placement.integer(commentary["actor_slot"], 1, 11)
                and placement.integer(commentary["secondary_slot"], 0, 11)
                and placement.integer(commentary["event_side"], 0, 1)
                and placement.integer(commentary["accepted"], 0, 1)):
            raise ValueError("incomplete numeric commentary contract")
        if len(call["helper_calls"]) != 2:
            raise ValueError("missing original byte6 helper call")
        for helper in call["helper_calls"]:
            i, o = helper["input"], helper["output"]
            if not (ints([i["old_byte6"], i["cache_flag"], i["cache_before"], o["byte6"], o["cache"]], 0, 255)
                    and placement.integer(i["delta"], -32768, 32767)):
                raise ValueError("invalid typed byte6 helper observation")
        result.append({"schema": "goal-effects-case/1", "week": source["t04_record"], "step": call["step"],
                       "request": request, "before": before, "after": after, "commentary": commentary,
                       "helper_calls": call["helper_calls"],
                       "source": {"t13_record": meta["record"], "t13_record_sha256": meta["record_sha256"],
                                  "t12_record": t12meta["record"], "t12_record_sha256": t12meta["record_sha256"],
                                  "t13_cases": "traces/T13/" + meta["cases"], "t13_cases_sha256": meta["cases_sha256"],
                                  "t13_step": old["step"], "t08_trace": reference_source["trace"],
                                  "t08_sha256": reference_source["trace_sha256"],
                                  "draw_start": call["draw_start"], "draw_end": call["draw_end"]}})
    return result


def cases_for(calls, source, trace, reference_source=None):
    try:
        return _cases_for(calls, source, trace, reference_source)
    except (KeyError, IndexError, TypeError, StopIteration) as e:
        raise ValueError(f"incomplete/malformed logical effects: {e}") from e


def selected_runs():
    selected = {}
    for path in sorted(RUNS.glob("T14-r*.json")):
        record = json.loads(path.read_text())
        selected[record["actions"]["stream_key"]] = (path, record)
    return {k: v for k, v in selected.items() if v[1]["status"] == "completed"}


def helper_cases(cases):
    return [{"schema": "byte6-case/1", "week": case["week"], "step": case["step"], "role": role,
             **helper} for case in cases for role, helper in enumerate(case["helper_calls"])]


def build_index():
    if not placement.same_json(placement.build_index(), json.loads((ROOT / "traces/T13/index.json").read_text())):
        raise ValueError("T13 source corpus differs")
    _, groups = contests.read_corpus()
    chosen, records, coverage, all_cases = selected_runs(), [], [], []
    for key, members in groups.items():
        if key not in chosen:
            raise ValueError("missing completed logical goal-effect run")
        path, record = chosen[key]
        source = record["actions"]["source"]
        trace = next((t for e, t in members if e == source), None)
        if trace is None or record["start_state"]["sha256"] != source["start_state_sha256"]:
            raise ValueError("goal-effect run source/state differs")
        cases = cases_for(contests.outputs(record)["calls"], source, trace)
        obs = {o["field"]: o["value"] for o in record["observations"]}
        fixture = ROOT / obs["fixture path"]
        if contests.sha(fixture) != obs["fixture sha256"] or not placement.same_json(contests.events(fixture), cases):
            raise ValueError("goal-effect fixture differs from original state")
        all_cases.extend(cases)
        records.append({"record": match.rel(path), "record_sha256": contests.sha(path), "cases": fixture.name,
                        "cases_sha256": contests.sha(fixture), "week": source["t04_record"], "calls": len(cases),
                        "producer_commit": record["code_commit"]})
        for entry, repeated in members:
            cases_for(contests.outputs(record)["calls"], source, repeated, entry)
            coverage.append({"t04_record": entry["t04_record"], "trace": entry["trace"],
                             "trace_sha256": entry["trace_sha256"], "cases": fixture.name})
    helper = FIXTURES / "byte6.jsonl"
    if not placement.same_json(contests.events(helper), helper_cases(all_cases)):
        raise ValueError("byte6 checks differ from original calls")
    return {"schema": "goal-effects-corpus/1", "records": records, "coverage": coverage,
            "calls": len(all_cases), "weeks": len(records), "traces": len(coverage),
            "helper_checks": {"file": helper.name, "sha256": contests.sha(helper), "cases": len(helper_cases(all_cases))},
            "t13_index_sha256": contests.sha(ROOT / "traces/T13/index.json")}


def run():
    import cycle
    import guest
    import unicorn
    if match.git("status", "--porcelain", "--", "runtime/emul"):
        raise SystemExit("commit runtime/emul before recording")
    commit = match.git("rev-parse", "--short", "HEAD")
    _, groups = contests.read_corpus()
    RUNS.mkdir(parents=True, exist_ok=True)
    FIXTURES.mkdir(parents=True, exist_ok=True)
    have, all_cases = selected_runs(), []
    for key, members in groups.items():
        if key in have:
            print(f"already recorded {have[key][1]['run_id']}", flush=True)
            fixture = ROOT / next(o["value"] for o in have[key][1]["observations"] if o["field"] == "fixture path")
            all_cases.extend(contests.events(fixture))
            continue
        source, reference = members[-1]
        started = match.utc()
        path, data = match.find_state(source["start_state_sha256"])
        week, status, lines, cases = match.Week(data), "completed", [], []
        recorder = Recorder(week)
        try:
            week.play()
            if week.g.unsupported or recorder.pending is not None or recorder.helper is not None:
                raise ValueError("unsupported service or incomplete goal effect")
            if week.events != reference[1:-1]:
                raise ValueError("new week differs from retained T08 events")
            ok, lines = match.compare(week.events, source["start_state_sha256"], ROOT / source["t04_record_path"])
            if not ok:
                raise ValueError("DOSBox-X comparison failed")
            cases = cases_for(recorder.calls, source, reference)
        except (Exception, KeyboardInterrupt) as e:
            status = f"aborted: {type(e).__name__}: {e}"
        n = max(match.next_number(RUNS, "T14-r*.json"), match.next_number(FIXTURES, "T14-r*.jsonl"))
        rid = f"T14-r{n:04d}"
        fixture = FIXTURES / (rid + ".jsonl")
        placement.write_lines(fixture, cases)
        record = {"schema": "run/1", "run_id": rid, "experiment": "T14", "arm": "logical-goal-effects", "rep": n,
                  "code_commit": commit, "machine": cycle.machine_id(),
                  "artifact": {"set": "One-Nil96 (records/T01/inventory.json)", "variant": None},
                  "runtime": {"harness": f"runtime/emul/goal_effects.py@{commit}", "unicorn": unicorn.__version__,
                              "python": platform.python_version(), "dos_clock": week.g.clock,
                              "settings": {k: getattr(guest, k) for k in ("INSTR_PER_S", "KEY_HOLD", "PIT_HZ", "SLICE_MAX")}},
                  "interventions": [{"level": "I3", "what": "guest.py services and read-only logical goal/callee hooks"}],
                  "start_state": {"id": match.rel(path), "sha256": source["start_state_sha256"],
                                  "restore": "DOSBox-X savestate restored by guest.py"}, "seed": None,
                  "actions": {"script": "runtime/emul/goal_effects.py", "source": source, "stream_key": key,
                              "game_files": {name: hashlib.sha256(raw).hexdigest() for name, raw in week.files_at_start.items()}},
                  "observations": [{"step": 0, "source": "file", "field": "fixture path", "value": match.rel(fixture)},
                                   {"step": 0, "source": "file", "field": "fixture sha256", "value": contests.sha(fixture)},
                                   {"step": 1, "source": "log", "field": "ordered DOSBox-X comparison", "value": "\n".join(lines)}],
                  "outputs": [{"name": "calls", "value": recorder.calls}],
                  "started": started, "ended": match.utc(), "status": status}
        match.write_record(RUNS / (rid + ".json"), record)
        print(f"{rid}: {status}; {len(recorder.calls)} goal calls, {len(cases)} cases", flush=True)
        if status != "completed":
            raise SystemExit(1)
        all_cases.extend(cases)
    helper = FIXTURES / "byte6.jsonl"
    checks = helper_cases(all_cases)
    if not helper.exists():
        placement.write_lines(helper, checks)
    elif not placement.same_json(contests.events(helper), checks):
        raise ValueError("immutable byte6 export differs")
    (FIXTURES / "index.json").write_text(json.dumps(build_index(), indent=2) + "\n")


def main(argv=None):
    ap = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    mode = ap.add_mutually_exclusive_group(required=True)
    mode.add_argument("--run", action="store_true")
    mode.add_argument("--check", action="store_true")
    args = ap.parse_args(argv)
    if args.run:
        run()
        return 0
    try:
        index = build_index()
        if (index["calls"], index["weeks"], index["traces"], index["helper_checks"]["cases"]) != (17, 6, 15, 34):
            raise ValueError("expected 17 logical effects, six measured weeks, 15 references and 34 helper checks")
        if not placement.same_json(index, json.loads((FIXTURES / "index.json").read_text())):
            raise ValueError("goal-effect index differs")
    except (ValueError, OSError, KeyError, StopIteration) as e:
        print(f"goal-effect check: FAIL: {e}")
        return 1
    print("goal-effect check: ok (17 cases, 34 helper checks, six measured weeks, 15 T08 references)")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
