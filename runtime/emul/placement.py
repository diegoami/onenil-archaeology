#!/usr/bin/env python3
"""T13: complete original placement inputs and literal helper contracts, no Python model.

    python3 runtime/emul/placement.py --run
    python3 runtime/emul/placement.py --check
"""
import argparse
import hashlib
import json
import platform
from pathlib import Path

import contests
import match
import quick_step

ROOT = contests.ROOT
RUNS, FIXTURES = ROOT / "runs/T13", ROOT / "traces/T13"


def integer(value, low, high):
    return type(value) is int and low <= value <= high


def same_json(a, b):
    # Python numeric equality otherwise aliases 1, 1.0 and True.
    return json.dumps(a, sort_keys=True) == json.dumps(b, sort_keys=True)


def typed_event(event):
    return (integer(event["minute"], 0, 65535) and integer(event["actor"], 0, 255)
            and integer(event["side_flag"], 0, 1))


def frame_byte(g, offset):
    return g.mem(g.reg("ss") * 16 + ((g.reg("bp") + offset) & 0xFFFF), 1)[0]


class Recorder:
    def __init__(self, week):
        self.week, self.active, self.pending, self.calls, self.goal = week, False, None, [], None
        self.contests = contests.Recorder(week)
        for address, callback in {
            match.MATCH: lambda g: setattr(self, "active", True),
            match.MATCH_RETURN: lambda g: setattr(self, "active", False),
            "0AB9:DD7C": self.enter, "0AB9:DF35": self.leave,
            "0AB9:DF0C": self.goal_enter, "0AB9:5190": self.coin,
            "0AB9:DF0F": self.goal_leave,
        }.items():
            week.g.code_hook(address, callback)

    def enter(self, g):
        if not self.active:
            return
        if self.pending is not None or len(self.contests.calls) != len(self.calls) + 1 or g.reg("ds") != g.DS:
            raise ValueError("placement/contest boundary differs")
        rosters = []
        for club in (g.rd(0xD6E6), g.rd(0xD6E4)):
            base = g.far(0xD7C2) + (club - 1) * 62
            rosters.append([g.word_at(base + 2 * i) for i in range(20)])
        players = []
        for player in sorted({p for roster in rosters for p in roster}):
            base = g.far(0xD7BE) + player * 15
            players.append({"id": player, "p15_sbyte8": quick_step.signed(g.mem(base + 8, 1)[0]),
                            "p15_byte11": g.mem(base + 11, 1)[0]})
        self.pending = {
            "draw_start": self.week.draws,
            "input": {"seed": g.word_at(g.far(0xDE84)),
                      "generated": [g.rd(0xD086, 1), g.rd(0xD087, 1)],
                      "scores": [frame_byte(g, -2), frame_byte(g, -1)], "elapsed": g.rd(0xD0B2),
                      "minute_limit": g.rd(0x0D00 + int(g.rd(0xD0AC, 1) == 15), 1),
                      "side_offsets": [g.rd(0x0D57, 1), g.rd(0x0D56, 1)], "actor_before": g.rd(0xD09F, 1),
                      "scorer_slots": list(g.mem(g.DS * 16 + 0x0CE0, 30)), "rosters": rosters, "players": players},
            "contest": self.contests.calls[-1], "callbacks": []}

    def goal_enter(self, g):
        if self.pending is not None:
            self.goal = {"draw_start": self.week.draws,
                         "event": {"minute": g.stack_word(0), "actor": g.stack_word(2),
                                   "side_flag": g.stack_word(4) & 255}}

    def coin(self, g):
        if self.goal is not None:
            if "coin" in self.goal:
                raise ValueError("more than one coin in goal helper")
            self.goal["coin"] = g.reg("ax") & 255

    def goal_leave(self, g):
        if self.goal is not None:
            self.goal["draw_end"] = self.week.draws
            self.pending["callbacks"].append(self.goal)
            self.goal = None

    def leave(self, g):
        if self.pending is not None:
            callbacks = self.pending["callbacks"]
            self.pending.update(draw_end=self.week.draws,
                output={"seed": g.word_at(g.far(0xDE84)), "generated": [g.rd(0xD086, 1), g.rd(0xD087, 1)],
                        "scores": [frame_byte(g, -2), frame_byte(g, -1)], "goal_flag": frame_byte(g, -0x26),
                        "actor": g.rd(0xD09F, 1), "goal": callbacks[0]["event"] if callbacks else None})
            self.calls.append(self.pending)
            self.pending = None


def t12_source(week):
    index = json.loads((ROOT / "traces/T12/index.json").read_text())
    meta = next(r for r in index["records"] if r["week"] == week)
    path, fixture = ROOT / meta["record"], ROOT / "traces/T12" / meta["cases"]
    if contests.sha(path) != meta["record_sha256"] or contests.sha(fixture) != meta["cases_sha256"]:
        raise ValueError("T12 source digest differs")
    record = json.loads(path.read_text())
    if record["status"] != "completed":
        raise ValueError("T12 source is incomplete")
    return meta, record, contests.outputs(record)["steps"]


def normalized_span(draws, start, end):
    if not (0 <= start <= end <= len(draws)) or [d["i"] for d in draws[start:end]] != list(range(start, end)):
        raise ValueError("invalid placement draw span")
    return [{k: v for k, v in quick_step.draw_view(d).items() if k != "i"} for d in draws[start:end]]


def _cases_for(calls, source, trace, reference_source=None):
    meta, previous, steps = t12_source(source["t04_record"])
    reference_source = reference_source or source
    if (previous["start_state"]["sha256"] != source["start_state_sha256"]
            or trace[0]["state_sha256"] != reference_source["start_state_sha256"]
            or trace[-1].get("kind") != "end" or trace[-1]["status"] != "completed" or len(calls) != len(steps)):
        raise ValueError("placement source/state/completion differs")
    draws, cases = contests.draw_stream(trace), []
    for i, (call, step) in enumerate(zip(calls, steps)):
        before, after = step["placement_input"], step["placement_output"]
        inputs, out = call["input"], call["output"]
        if (call["draw_start"] != before["draws"] or call["draw_end"] != after["draws"]
                or not same_json(call["contest"], step["contest"])
                or any(inputs[k] != before[old] for k, old in
                       (("seed", "seed"), ("generated", "generated"), ("scores", "saved_scores"),
                        ("minute_limit", "minute_limit"), ("side_offsets", "side_offsets")))
                or inputs["elapsed"] != before["clock"]["elapsed"]
                or any(out[k] != after[old] for k, old in
                       (("seed", "seed"), ("generated", "generated"), ("scores", "saved_scores"), ("goal_flag", "goal_flag")))):
            raise ValueError("placement input/output differs from T12")
        rosters, players = inputs["rosters"], {p["id"]: p for p in inputs["players"]}
        if (len(rosters) != 2 or any(len(r) != 20 for r in rosters) or len(inputs["scorer_slots"]) != 30
                or any(not integer(p, 0, 65535) for r in rosters for p in r)
                or any(not integer(slot, 1, 20) for slot in inputs["scorer_slots"])
                or not integer(inputs["seed"], 0, 65535) or not integer(inputs["elapsed"], 0, 65535)
                or not integer(inputs["minute_limit"], 0, 255)
                or len(inputs["generated"]) != 2 or any(not integer(g, 0, 11) for g in inputs["generated"])
                or len(inputs["scores"]) != 2 or any(not integer(s, 0, 255) for s in inputs["scores"])
                or len(inputs["side_offsets"]) != 2 or any(not integer(s, 0, 255) for s in inputs["side_offsets"])
                or not integer(inputs["actor_before"], 0, 255)
                or len(players) != len(inputs["players"])
                or set(players) != {p for r in rosters for p in r}):
            raise ValueError("complete roster/player/scorer inputs missing")
        for p in players.values():
            if not (integer(p["id"], 0, 65535) and integer(p["p15_sbyte8"], -128, 127)
                    and integer(p["p15_byte11"], 0, 255)):
                raise ValueError("invalid typed player input")
        if (not integer(out["seed"], 0, 65535) or not integer(out["goal_flag"], 0, 1)
                or not integer(out["actor"], 0, 255)
                or len(out["generated"]) != 2 or any(not integer(g, 0, 11) for g in out["generated"])
                or len(out["scores"]) != 2 or any(not integer(s, 0, 255) for s in out["scores"])
                or (out["goal"] is not None and not typed_event(out["goal"]))):
            raise ValueError("invalid typed placement output")
        for p in step["input"]["players"]:
            if p["player"] in players and any(players[p["player"]][k] != p[old] for k, old in
                                              (("p15_sbyte8", "p15_sbyte8"), ("p15_byte11", "p15_byte11"))):
                raise ValueError("eligibility fields differ from original T12 player input")
        for attempt in step["scorer_attempts"]:
            draw = draws[attempt["draw_i"]]
            if (inputs["scorer_slots"][draw["value"] - 1] != attempt["sampled_slot"]
                    or rosters[attempt["side"] - 1][attempt["sampled_slot"] - 1] != attempt["player"]):
                raise ValueError("selected roster player differs")
        for mapping in step["scorer_mappings"]:
            if rosters[mapping["side"] - 1] != mapping["roster"]:
                raise ValueError("complete roster differs from original helper input")
        expected_draws = normalized_span(draws, call["draw_start"], call["draw_end"])
        if inputs["seed"] != (expected_draws[0]["seed_before"] if expected_draws else out["seed"]) or (
                expected_draws and out["seed"] != expected_draws[-1]["seed_after"]):
            raise ValueError("placement seed/draw boundary differs")
        callbacks = []
        if len(call["callbacks"]) != len(step["goal_calls"]):
            raise ValueError("goal callback count differs")
        for actual, old in zip(call["callbacks"], step["goal_calls"]):
            event = {k: old[k] for k in ("minute", "actor", "side_flag")}
            if (not typed_event(actual["event"]) or not integer(actual["coin"], 0, 1)
                    or actual["event"] != event or actual["draw_start"] != old["draw_start"]
                    or actual["draw_end"] != old["draw_end"]):
                raise ValueError("goal callback contract differs")
            nested = normalized_span(draws, actual["draw_start"], actual["draw_end"])
            if (len(nested) != 1 or nested[0]["site"] != "0AB9:5190" or nested[0]["n"] != 2
                    or actual["coin"] != int(nested[0]["value"] == 1)):
                raise ValueError("original goal coin projection differs")
            callbacks.append({"event": event, "coin": actual["coin"], "draws": nested})
        if out["goal"] != (callbacks[0]["event"] if callbacks else None) or out["actor"] != (
                callbacks[0]["event"]["actor"] if callbacks else inputs["actor_before"]):
            raise ValueError("placement actor/effect request differs")
        cases.append({"schema": "placement-case/1", "week": source["t04_record"], "step": i,
            "input": inputs, "output": out, "draws": expected_draws, "callbacks": callbacks,
            "minute_fills": [{k: v for k, v in m.items() if k != "draw_i"} for m in step["minute_fills"]],
            "attempts": [{k: v for k, v in a.items() if k != "draw_i"} for a in step["scorer_attempts"]],
            "mappings": [{k: v for k, v in m.items() if k != "roster"} for m in step["scorer_mappings"]],
            "contest": {"input": call["contest"]["input"], "output": call["contest"]["output"],
                        "draws": normalized_span(draws, call["contest"]["draw_start"], call["contest"]["draw_end"])},
            "source": {"t12_record": meta["record"], "t12_record_sha256": meta["record_sha256"],
                       "t12_cases": "traces/T12/" + meta["cases"], "t12_cases_sha256": meta["cases_sha256"],
                       "t12_step": i, "t08_trace": reference_source["trace"], "t08_sha256": reference_source["trace_sha256"],
                       "draw_start": call["draw_start"], "draw_end": call["draw_end"]}})
    return cases


def cases_for(calls, source, trace, reference_source=None):
    try:
        return _cases_for(calls, source, trace, reference_source)
    except (KeyError, IndexError, TypeError, StopIteration) as e:
        raise ValueError(f"incomplete or malformed placement observation: {e}") from e


def helper_cases():
    index = json.loads((ROOT / "traces/T12/index.json").read_text())
    rows = []
    for meta in index["records"]:
        _, _, steps = t12_source(meta["week"])
        for i, step in enumerate(steps):
            for visit in step["scene_visits"]:
                p = visit["before"]
                rows.append({"schema": "availability-case/1", "week": meta["week"], "step": i,
                             "scene_slot": p["scene_slot"],
                             "input": {"id": p["player"], "p15_sbyte8": p["p15_sbyte8"],
                                       "p15_byte11": p["p15_byte11"]}, "unavailable": visit["unavailable"]})
    return rows


def selected_runs():
    selected = {}
    for path in sorted(RUNS.glob("T13-r*.json")):
        record = json.loads(path.read_text())
        selected[record["actions"]["stream_key"]] = (path, record)
    return {k: v for k, v in selected.items() if v[1]["status"] == "completed"}


def build_index():
    if not same_json(quick_step.build_index(), json.loads((ROOT / "traces/T12/index.json").read_text())):
        raise ValueError("T12 corpus differs")
    _, groups = contests.read_corpus()
    selected, records, coverage = selected_runs(), [], []
    for key, members in groups.items():
        if key not in selected:
            raise ValueError("missing completed placement input run")
        path, record = selected[key]
        source = record["actions"]["source"]
        trace = next((t for e, t in members if e == source), None)
        if trace is None or record["start_state"]["sha256"] != source["start_state_sha256"]:
            raise ValueError("placement run source/state differs")
        calls = contests.outputs(record)["placements"]
        expected = cases_for(calls, source, trace)
        obs = {o["field"]: o["value"] for o in record["observations"]}
        fixture = ROOT / obs["fixture path"]
        if contests.sha(fixture) != obs["fixture sha256"] or not same_json(contests.events(fixture), expected):
            raise ValueError("placement fixture differs from original inputs/outputs")
        records.append({"record": match.rel(path), "record_sha256": contests.sha(path), "cases": fixture.name,
                        "cases_sha256": contests.sha(fixture), "week": source["t04_record"], "calls": len(calls),
                        "producer_commit": record["code_commit"]})
        for entry, repeated in members:
            cases_for(calls, source, repeated, entry)
            coverage.append({"t04_record": entry["t04_record"], "trace": entry["trace"],
                             "trace_sha256": entry["trace_sha256"], "cases": fixture.name})
    helper = FIXTURES / "availability.jsonl"
    if not same_json(contests.events(helper), helper_cases()):
        raise ValueError("availability checks differ from original predicates")
    return {"schema": "placement-corpus/1", "records": records, "coverage": coverage,
            "calls": sum(r["calls"] for r in records), "weeks": len(records), "traces": len(coverage),
            "draws": sum(len(c["draws"]) for r in records for c in contests.events(FIXTURES / r["cases"])),
            "callbacks": sum(len(c["callbacks"]) for r in records for c in contests.events(FIXTURES / r["cases"])),
            "helper_checks": {"file": helper.name, "sha256": contests.sha(helper), "cases": len(helper_cases())},
            "t12_index_sha256": contests.sha(ROOT / "traces/T12/index.json")}


def write_lines(path, values):
    with Path(path).open("x") as f:
        for value in values:
            f.write(json.dumps(value, sort_keys=True) + "\n")


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
    have = selected_runs()
    for key, members in groups.items():
        if key in have:
            print(f"already recorded {have[key][1]['run_id']}", flush=True)
            continue
        source, reference = members[-1]
        started = match.utc()
        path, data = match.find_state(source["start_state_sha256"])
        week, status, lines, cases = match.Week(data), "completed", [], []
        recorder = Recorder(week)
        try:
            week.play()
            if week.g.unsupported or recorder.pending is not None or recorder.goal is not None:
                raise ValueError("unsupported service or incomplete placement")
            if week.events != reference[1:-1]:
                raise ValueError("new week differs from retained T08 events")
            ok, lines = match.compare(week.events, source["start_state_sha256"], ROOT / source["t04_record_path"])
            if not ok:
                raise ValueError("DOSBox-X comparison failed")
            cases = cases_for(recorder.calls, source, reference)
        except (Exception, KeyboardInterrupt) as e:
            status = f"aborted: {type(e).__name__}: {e}"
        n = max(match.next_number(RUNS, "T13-r*.json"), match.next_number(FIXTURES, "T13-r*.jsonl"))
        rid = f"T13-r{n:04d}"
        fixture = FIXTURES / (rid + ".jsonl")
        write_lines(fixture, cases)
        record = {"schema": "run/1", "run_id": rid, "experiment": "T13", "arm": "goal-placement", "rep": n,
                  "code_commit": commit, "machine": cycle.machine_id(),
                  "artifact": {"set": "One-Nil96 (records/T01/inventory.json)", "variant": None},
                  "runtime": {"harness": f"runtime/emul/placement.py@{commit}", "unicorn": unicorn.__version__,
                              "python": platform.python_version(), "dos_clock": week.g.clock,
                              "settings": {k: getattr(guest, k) for k in ("INSTR_PER_S", "KEY_HOLD", "PIT_HZ", "SLICE_MAX")}},
                  "interventions": [{"level": "I3", "what": "guest.py stand-ins and read-only placement input/exit hooks"}],
                  "start_state": {"id": match.rel(path), "sha256": source["start_state_sha256"],
                                  "restore": "DOSBox-X savestate restored by guest.py"}, "seed": None,
                  "actions": {"script": "runtime/emul/placement.py", "source": source, "stream_key": key,
                              "game_files": {name: hashlib.sha256(raw).hexdigest() for name, raw in week.files_at_start.items()}},
                  "observations": [{"step": 0, "source": "file", "field": "fixture path", "value": match.rel(fixture)},
                                   {"step": 0, "source": "file", "field": "fixture sha256", "value": contests.sha(fixture)},
                                   {"step": 1, "source": "log", "field": "ordered DOSBox-X comparison", "value": "\n".join(lines)}],
                  "outputs": [{"name": "placements", "value": recorder.calls}],
                  "started": started, "ended": match.utc(), "status": status}
        match.write_record(RUNS / (rid + ".json"), record)
        print(f"{rid}: {status}; {len(recorder.calls)} placements, {len(cases)} cases", flush=True)
        if status != "completed":
            raise SystemExit(1)
    helper = FIXTURES / "availability.jsonl"
    values = helper_cases()
    if not helper.exists():
        write_lines(helper, values)
    elif not same_json(contests.events(helper), values):
        raise ValueError("immutable availability export differs")
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
        if (index["calls"], index["weeks"], index["traces"], index["draws"], index["callbacks"],
                index["helper_checks"]["cases"]) != (558, 6, 15, 1804, 17, 12276):
            raise ValueError("expected complete 558/1804/17 placement and 12276 helper corpus")
        if not same_json(index, json.loads((FIXTURES / "index.json").read_text())):
            raise ValueError("placement index differs")
    except (ValueError, OSError, KeyError, StopIteration) as e:
        print(f"placement check: FAIL: {e}")
        return 1
    print("placement check: ok (558 cases, 1804 draws, 17 goal contracts, 12276 helper checks, 15 T08 traces)")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
