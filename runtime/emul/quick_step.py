#!/usr/bin/env python3
"""T12: observe original DD02 steps and their caller clock boundary; no engine model.

    python3 runtime/emul/quick_step.py --run
    python3 runtime/emul/quick_step.py --check

Decoded state, decisions and call boundaries are retained as immutable observations.
Their expected draw streams are literal T08 slices. They are not a closed DD02 model.
"""
import argparse
import hashlib
import json
import platform
from pathlib import Path

import contests
import match

ROOT = contests.ROOT
RUNS, FIXTURES = ROOT / "runs/T12", ROOT / "traces/T12"
CLOCK = {"kind": (0xD0AC, 1), "remaining": (0xD0AE, 2), "delay": (0xD0B0, 2),
         "elapsed": (0xD0B2, 2), "added": (0xD0B4, 2), "active": (0xD0B8, 1), "zero": (0xD0B9, 1)}
FLAGS = (0xD074, 0xD09F, 0xD0A0, 0xD0B7, 0xD1CA, 0xD6DD)


def signed(value):
    return value - 256 if value >= 128 else value


def clock(g):
    return {name: g.rd(off, size) for name, (off, size) in CLOCK.items()}


def participant(g, slot):
    scene = g.DS * 16 + 0xCCEF + slot * 25
    player = g.word_at(scene + 14)
    p = g.far(0xD7BE) + player * 15
    return {"scene_slot": slot, "player": player, "scene_word0": g.word_at(scene),
            "scene_word8": g.word_at(scene + 8), "scene_byte19": g.mem(scene + 19, 1)[0],
            "p15_word2": g.word_at(p + 2), "p15_byte5": g.mem(p + 5, 1)[0],
            "p15_sbyte6": signed(g.mem(p + 6, 1)[0]),
            "p15_sbyte8": signed(g.mem(p + 8, 1)[0]), "p15_byte11": g.mem(p + 11, 1)[0]}


def state(week):
    g = week.g
    history = g.far(0xD7CE) + g.rd(0xD6E6) * 0x3A + g.mem(g.far(0xD7D2), 1)[0] - 0x3B
    logs = []
    for side in range(2):
        count = g.rd(0xD128 + side, 1)
        if count > 11:
            raise ValueError("scorer log count exceeds its statically read capacity")
        logs.append([{"player": g.word_at(g.DS * 16 + 0xD0E3 + 33 * side + 3 * i),
                      "minute_byte": g.rd(0xD0E5 + 33 * side + 3 * i, 1)} for i in range(1, count + 1)])
    return {"clock": clock(g), "seed": g.word_at(g.far(0xDE84)),
            "score_side": [g.rd(0xD0C5, 1), g.rd(0xD0C4, 1)],
            "goal_bytes": [g.rd(0xD086, 1), g.rd(0xD087, 1)],
            "ratings": [g.rd(0xD674 + 2 * i) for i in range(8)],
            "clubs": [g.rd(0xD6E6), g.rd(0xD6E4)],
            "flags": {f"DS:{off:04X}": g.rd(off, 1) for off in FLAGS},
            "history_byte": g.mem(history, 1)[0], "scorer_logs": logs,
            "players": [participant(g, slot) for slot in range(1, 23)], "save_block_digests": week.state_digests()}


class Recorder:
    def __init__(self, week):
        self.week, self.active, self.pending, self.steps = week, False, None, []
        self.contests = contests.Recorder(week)
        self.rating = self.attempt = self.mapping = self.goal = self.phase = None
        self.added = self.clock_step = None
        self.between_steps = []
        g = week.g
        hooks = {match.MATCH: lambda g: setattr(self, "active", True),
                 match.MATCH_RETURN: lambda g: setattr(self, "active", False),
                 "0AB9:DD02": self.enter, "0AB9:DD53": self.rating_enter,
                 "0AB9:DD58": self.rating_leave, "0AB9:DD60": self.rating_enter,
                 "0AB9:DD65": self.rating_leave, "0AB9:DD7C": self.core_enter,
                 "0AB9:DDE4": self.minute, "0AB9:DE8D": self.attempt_enter,
                 "0AB9:DE92": self.attempt_leave, "0AB9:DECF": self.mapping_enter,
                 "0AB9:DED4": self.mapping_leave, "0AB9:DF0C": self.goal_enter,
                 "0AB9:DF0F": self.goal_leave, "0AB9:DF35": self.core_leave,
                 "0AB9:DF65": self.history_enter, "0AB9:DF6A": self.history_leave,
                 "0AB9:DF9D": self.scene_enter, "0AB9:DFD5": self.scene_leave,
                 "0AB9:DFE9": lambda g: self.phase_enter(g, "0AB9:DBC6"),
                 "0AB9:DFEC": self.phase_leave,
                 "0AB9:DFF2": lambda g: self.phase_enter(g, "0AB9:6B2F"),
                 "0AB9:DFF5": self.phase_leave,
                 "0AB9:DFF7": lambda g: self.phase_enter(g, "goal reset: 1998:045C,0AB9:52B6"),
                 "0AB9:E003": self.keyboard, "0AB9:E006": self.leave,
                 "0AB9:7B7B": self.clock_enter, "0AB9:7C92": self.clock_leave}
        for address, callback in hooks.items():
            g.code_hook(address, callback)
        for before, after in (("6456", "645A"), ("65ED", "65F1"), ("68A6", "68AA")):
            g.code_hook("0AB9:" + before, lambda g, at=before: self.added_enter(g, at))
            g.code_hook("0AB9:" + after, self.added_leave)

    def local(self, g, offset, size=2):
        return int.from_bytes(g.mem(g.reg("ss") * 16 + ((g.reg("bp") + offset) & 0xFFFF), size), "little")

    def enter(self, g):
        if not self.active:
            return
        if self.pending is not None:
            raise ValueError("nested DD02")
        self.contest_index = len(self.contests.calls)
        self.pending = {"draw_start": self.week.draws, "input": state(self.week),
                        "ratings_calls": [], "minute_fills": [], "scorer_attempts": [],
                        "scorer_mappings": [], "goal_calls": [], "scene_visits": [],
                        "phases": [], "added_time": []}

    def rating_enter(self, g):
        if self.pending is not None:
            self.rating = {"club": g.stack_word(4), "side": g.stack_word(2), "flag": g.stack_word(0) & 255,
                           "draw_start": self.week.draws}

    def rating_leave(self, g):
        if self.rating is not None:
            self.rating.update(values=[g.rd(0xD674 + 4 * k + 2 * self.rating["side"]) for k in range(4)],
                               draw_end=self.week.draws)
            self.pending["ratings_calls"].append(self.rating)
            self.rating = None

    def core_state(self, g):
        return {"draws": self.week.draws, "seed": g.word_at(g.far(0xDE84)),
                "generated": [g.rd(0xD086, 1), g.rd(0xD087, 1)],
                "saved_scores": [self.local(g, -2, 1), self.local(g, -1, 1)],
                "goal_flag": self.local(g, -0x26, 1), "clock": clock(g),
                "side_offsets": [g.rd(0x0D57, 1), g.rd(0x0D56, 1)],
                "minute_limit": g.rd(0x0D00 + int(g.rd(0xD0AC, 1) == 15), 1)}

    def core_enter(self, g):
        if self.pending is not None:
            self.pending["placement_input"] = self.core_state(g)

    def core_leave(self, g):
        if self.pending is not None:
            self.pending["placement_output"] = self.core_state(g)

    def minute(self, g):
        if self.pending is not None:
            self.pending["minute_fills"].append({"draw_i": self.week.draws - 1, "minute": g.reg("ax") & 255,
                "outer_side": self.local(g, -0x22), "side": self.local(g, -0x1C),
                "goal_index": self.local(g, -0x1E)})

    def attempt_enter(self, g):
        if self.pending is not None:
            self.attempt = {"draw_i": self.week.draws - 1, "side": self.local(g, -0x1C),
                            "sampled_slot": self.local(g, -0x24), "player": g.stack_word(0)}

    def attempt_leave(self, g):
        if self.attempt is not None:
            self.attempt["unavailable"] = g.reg("ax") & 255
            self.pending["scorer_attempts"].append(self.attempt)
            self.attempt = None

    def mapping_enter(self, g):
        if self.pending is not None:
            address = g.stack_word(2) * 16 + g.stack_word(0)
            self.mapping = {"player": g.stack_word(4), "side": self.local(g, -0x1C),
                            "roster": [g.word_at(address + 2 * i) for i in range(20)]}

    def mapping_leave(self, g):
        if self.mapping is not None:
            self.mapping["first_slot"] = g.reg("ax")
            self.pending["scorer_mappings"].append(self.mapping)
            self.mapping = None

    def goal_enter(self, g):
        if self.pending is not None:
            self.goal = {"minute": g.stack_word(0), "actor": g.stack_word(2), "side_flag": g.stack_word(4) & 255,
                         "draw_start": self.week.draws, "before": state(self.week)}

    def goal_leave(self, g):
        if self.goal is not None:
            self.goal.update(draw_end=self.week.draws, after=state(self.week))
            self.pending["goal_calls"].append(self.goal)
            self.goal = None

    def history_enter(self, g):
        if self.pending is not None:
            self.history_ptr = g.reg("es") * 16 + g.reg("di")
            self.pending["history_write"] = {"score_word": g.stack_word(4), "before": g.mem(self.history_ptr, 1)[0]}

    def history_leave(self, g):
        if self.pending is not None:
            self.pending["history_write"]["after"] = g.mem(self.history_ptr, 1)[0]

    def scene_enter(self, g):
        if self.pending is not None:
            slot = self.local(g, -0x1E)
            self.pending["scene_visits"].append({"unavailable": g.reg("ax") & 255,
                                                "before": participant(g, slot)})

    def scene_leave(self, g):
        if self.pending is not None:
            self.pending["scene_visits"][-1]["after"] = participant(g, self.local(g, -0x1E))

    def phase_enter(self, g, name):
        if self.pending is not None:
            if self.phase is not None:
                raise ValueError("unexpected nested observation phase")
            self.phase = {"routine": name, "draw_start": self.week.draws}

    def phase_leave(self, g):
        if self.phase is not None:
            self.phase["draw_end"] = self.week.draws
            self.pending["phases"].append(self.phase)
            self.phase = None

    def keyboard(self, g):
        if self.pending is not None:
            self.phase_leave(g)
            self.phase_enter(g, "0AB9:78B7")

    def added_enter(self, g, at):
        if self.active:
            self.added = {"at": "0AB9:" + at, "before": g.rd(0xD0B4), "draws": self.week.draws}

    def added_leave(self, g):
        if self.added is not None:
            self.added["after"] = g.rd(0xD0B4)
            (self.pending["added_time"] if self.pending is not None else self.between_steps).append(self.added)
            self.added = None

    def leave(self, g):
        if self.pending is not None:
            self.phase_leave(g)
            if len(self.contests.calls) != self.contest_index + 1:
                raise ValueError("DD02 did not contain exactly one completed D983")
            self.pending.update(draw_end=self.week.draws, output=state(self.week),
                                contest=self.contests.calls[self.contest_index])
            self.steps.append(self.pending)
            self.pending = None

    def clock_enter(self, g):
        if self.active and self.steps and "clock_after" not in self.steps[-1]:
            if self.pending is not None:
                raise ValueError("clock called within DD02")
            self.clock_step = self.steps[-1]
            self.clock_step["clock_before"] = clock(g)

    def clock_leave(self, g):
        if self.clock_step is not None:
            self.clock_step.update(clock_after=clock(g), clock_result=g.reg("ax") & 255)
            self.clock_step = None


def draw_view(draw):
    site = next((c for c in draw["callers"] if c.startswith("0AB9:")), None)
    if site is None:
        raise ValueError("unresolved quick-step draw site")
    return {"site": site, **{k: draw[k] for k in ("i", "n", "seed_before", "seed_after", "value")}}


def _check_step(step, original_contest, draws):
    """Validate linked observations and invariants, without simulating the step's decisions."""
    begin, end = step["draw_start"], step["draw_end"]
    if not (0 <= begin < end <= len(draws)) or step["contest"] != original_contest:
        raise ValueError("step bounds or T11 contest linkage differ")
    core_in, core_out = step["placement_input"], step["placement_output"]
    for snapshot in (step["input"], step["output"]):
        if (set(snapshot["clock"]) != set(CLOCK) or len(snapshot["ratings"]) != 8
                or len(snapshot["score_side"]) != 2 or len(snapshot["goal_bytes"]) != 2
                or [p["scene_slot"] for p in snapshot["players"]] != list(range(1, 23))
                or not snapshot["save_block_digests"]):
            raise ValueError("decoded state observation incomplete")
    c = step["contest"]
    if not (begin <= c["draw_start"] < c["draw_end"] == core_in["draws"] <= core_out["draws"] <= end):
        raise ValueError("step stages are incomplete or unordered")
    if (step["input"]["seed"] != draws[begin]["seed_before"]
            or step["output"]["seed"] != draws[end - 1]["seed_after"]):
        raise ValueError("step seed boundary differs")
    ratings = step["ratings_calls"]
    if [r["side"] for r in ratings] != [0, 1] or any(
            r["values"] != c["input"]["ratings"][r["side"]::2] for r in ratings):
        raise ValueError("ratings stage differs from D983 inputs")
    if core_in["generated"] != c["output"]["goals"] or core_in["seed"] != c["output"]["seed"]:
        raise ValueError("placement stage differs from D983 outputs")
    if len(step["goal_calls"]) > 1 or core_out["goal_flag"] != len(step["goal_calls"]):
        raise ValueError("step goal limit or flag differs")
    if core_out["saved_scores"] != step["output"]["score_side"]:
        raise ValueError("restored cumulative score differs")
    if [v["before"]["scene_slot"] for v in step["scene_visits"]] != list(range(1, 23)) or any(
            "after" not in v or v.get("unavailable") not in (0, 1)
            or v["after"]["scene_slot"] != v["before"]["scene_slot"] for v in step["scene_visits"]):
        raise ValueError("post-step scene observations incomplete")
    if any(key not in step for key in ("clock_before", "clock_after", "clock_result", "history_write")):
        raise ValueError("clock/history observations incomplete")
    if (step["clock_before"] != step["output"]["clock"] or set(step["clock_after"]) != set(CLOCK)
            or step["clock_result"] not in (0, 1)):
        raise ValueError("caller clock boundary differs or is incomplete")
    history = step["history_write"]
    if (history["score_word"] != core_out["saved_scores"][0] + 256 * core_out["saved_scores"][1]
            or history["after"] != step["output"]["history_byte"]
            or history["after"] != (((history["score_word"] & 255) + (history["score_word"] >> 8) * 16) & 255)):
        raise ValueError("packed history write differs")
    for key, site, value_key in (("minute_fills", "0AB9:DDE4", "minute"),
                                 ("scorer_attempts", "0AB9:DE5C", None)):
        wanted = [d for d in draws[begin:end] if site in d["callers"]]
        got = step[key]
        if [e["draw_i"] for e in got] != [d["i"] for d in wanted]:
            raise ValueError("decision draw observations missing or reordered")
        if value_key and any(e[value_key] != (d["value"] & 255) for e, d in zip(got, wanted)):
            raise ValueError("minute observation differs from original draw")
        if not value_key and any(e.get("unavailable") not in (0, 1) for e in got):
            raise ValueError("scorer predicate observation incomplete")
    accepted = [e for e in step["scorer_attempts"] if e["unavailable"] == 0]
    if len(accepted) != len(step["goal_calls"]) or len(step["scorer_mappings"]) != len(accepted):
        raise ValueError("accepted scorer/mapping/goal observations differ")
    expected_scores = list(core_in["saved_scores"])
    for candidate, mapping, goal in zip(accepted, step["scorer_mappings"], step["goal_calls"]):
        roster = mapping["roster"]
        first_slot = next((i + 1 for i, player in enumerate(roster) if player == mapping["player"]), 0)
        side = candidate["side"] - 1
        if (side not in (0, 1) or mapping["player"] != candidate["player"] or len(roster) != 20
                or mapping["first_slot"] != first_slot or mapping["side"] != candidate["side"]
                or goal["side_flag"] != int(side == 0) or expected_scores[side] >= 15
                or goal["minute"] != core_in["clock"]["elapsed"]
                or goal["actor"] != ((first_slot + core_in["side_offsets"][side]) & 255)):
            raise ValueError("scorer mapping or goal callback differs")
        expected_scores[side] += 1
    if core_out["saved_scores"] != expected_scores:
        raise ValueError("cumulative score delta differs from the goal callback")
    for goal in step["goal_calls"]:
        if not (core_in["draws"] <= goal["draw_start"] <= goal["draw_end"] <= core_out["draws"]):
            raise ValueError("goal helper draw span is outside placement")


def check_step(step, original_contest, draws):
    try:
        _check_step(step, original_contest, draws)
    except (KeyError, IndexError, TypeError) as e:
        raise ValueError(f"incomplete or malformed step observation: {e}") from e


def cases_for(steps, original_calls, trace, source):
    if (not trace or trace[0].get("state_sha256") != source["start_state_sha256"]
            or trace[-1].get("kind") != "end" or trace[-1].get("status") != "completed"):
        raise ValueError("reference start state or completion differs")
    draws = contests.draw_stream(trace)
    if not steps or len(steps) != len(original_calls):
        raise ValueError("step/contest count differs")
    covered, result = [], []
    for i, (step, c) in enumerate(zip(steps, original_calls)):
        check_step(step, c, draws)
        a, b = step["draw_start"], step["draw_end"]
        if [d["i"] for d in draws[a:b]] != list(range(a, b)):
            raise ValueError("source draw indices are not contiguous")
        covered.extend(range(a, b))
        result.append({"schema": "quick-step-observation/1", "week": source["t04_record"], "step": i,
                       "observation": step, "source": {"trace": source["trace"], "sha256": source["trace_sha256"]},
                       "draws": [draw_view(d) for d in draws[a:b]]})
    managed_end = next(e["draws"] for e in trace if e["kind"] == "mark" and e["what"].startswith("match return"))
    if covered != list(range(258, managed_end)):
        raise ValueError("steps omit or overlap managed draws after the recorded 258-draw prefix")
    return result


def t11_calls(source):
    index = json.loads((ROOT / "traces/T11/index.json").read_text())
    item = next(r for r in index["records"] if r["week"] == source["t04_record"])
    path = ROOT / item["record"]
    if contests.sha(path) != item["record_sha256"]:
        raise ValueError("T11 record digest differs")
    record = json.loads(path.read_text())
    if record["status"] != "completed" or record["start_state"]["sha256"] != source["start_state_sha256"]:
        raise ValueError("T11 source state/status differs")
    return contests.outputs(record)["calls"]


def selected_runs():
    selected = {}
    for path in sorted(RUNS.glob("T12-r*.json")):
        record = json.loads(path.read_text())
        selected[record["actions"]["stream_key"]] = (path, record)
    return {k: v for k, v in selected.items() if v[1]["status"] == "completed"}


def build_index():
    _, groups = contests.read_corpus()
    chosen, records, coverage = selected_runs(), [], []
    for key, members in groups.items():
        if key not in chosen:
            raise ValueError("missing completed quick-step run")
        path, record = chosen[key]
        source = record["actions"]["source"]
        reference = next((trace for entry, trace in members if entry == source), None)
        if reference is None or record["start_state"]["sha256"] != source["start_state_sha256"]:
            raise ValueError("quick-step source/state differs")
        steps = contests.outputs(record)["steps"]
        calls = t11_calls(source)
        wanted = cases_for(steps, calls, reference, source)
        observations = {o["field"]: o["value"] for o in record["observations"]}
        fixture = ROOT / observations["fixture path"]
        if contests.sha(fixture) != observations["fixture sha256"] or contests.events(fixture) != wanted:
            raise ValueError("fixture differs from measured steps/source")
        records.append({"record": match.rel(path), "record_sha256": contests.sha(path), "cases": fixture.name,
                        "cases_sha256": contests.sha(fixture), "week": source["t04_record"], "steps": len(steps),
                        "producer_commit": record["code_commit"], "source_trace": source["trace"],
                        "source_trace_sha256": source["trace_sha256"]})
        for entry, trace in members:
            cases_for(steps, calls, trace, entry)
            coverage.append({"t04_record": entry["t04_record"], "trace": entry["trace"],
                             "trace_sha256": entry["trace_sha256"], "cases": fixture.name})
    return {"schema": "quick-step-observations/1", "routine": "0AB9:DD02", "records": records, "coverage": coverage,
            "steps": sum(r["steps"] for r in records), "weeks": len(records), "traces": len(coverage),
            "t08_index_sha256": contests.sha(ROOT / "traces/T08/index.json"),
            "t11_index_sha256": contests.sha(ROOT / "traces/T11/index.json")}


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
            if week.g.unsupported or recorder.pending is not None or recorder.clock_step is not None:
                raise ValueError("unsupported service or incomplete observation")
            if week.events != reference[1:-1]:
                raise ValueError("new week differs from retained T08 events")
            ok, lines = match.compare(week.events, source["start_state_sha256"], ROOT / source["t04_record_path"])
            if not ok:
                raise ValueError("DOSBox-X comparison failed")
            cases = cases_for(recorder.steps, t11_calls(source), reference, source)
        except (Exception, KeyboardInterrupt) as e:
            status = f"aborted: {type(e).__name__}: {e}"
        n = max(match.next_number(RUNS, "T12-r*.json"), match.next_number(FIXTURES, "T12-r*.jsonl"))
        rid = f"T12-r{n:04d}"
        fixture = FIXTURES / (rid + ".jsonl")
        with fixture.open("x") as f:
            for case in cases:
                f.write(json.dumps(case, sort_keys=True) + "\n")
        record = {"schema": "run/1", "run_id": rid, "experiment": "T12", "arm": "quick-step", "rep": n,
                  "code_commit": commit, "machine": cycle.machine_id(),
                  "artifact": {"set": "One-Nil96 (records/T01/inventory.json)", "variant": None},
                  "runtime": {"harness": f"runtime/emul/quick_step.py@{commit}", "unicorn": unicorn.__version__,
                              "python": platform.python_version(), "dos_clock": week.g.clock, "settings": {
                                  k: getattr(guest, k) for k in ("INSTR_PER_S", "PIT_HZ", "KEY_HOLD", "STALL_POLLS",
                                                               "OTHER_STALL_POLLS", "SLICE_MAX", "IF_RETRY")}},
                  "interventions": [{"level": "I3", "what": "guest.py stand-ins; read-only stage/callee/state hooks"}],
                  "start_state": {"id": match.rel(path), "sha256": source["start_state_sha256"],
                                  "restore": "DOSBox-X savestate restored by guest.py"}, "seed": None,
                  "actions": {"script": "runtime/emul/quick_step.py", "source": source, "stream_key": key,
                              "game_files": {name: hashlib.sha256(raw).hexdigest() for name, raw in week.files_at_start.items()}},
                  "observations": [{"step": 0, "source": "file", "field": "fixture path", "value": match.rel(fixture)},
                                   {"step": 0, "source": "file", "field": "fixture sha256", "value": contests.sha(fixture)},
                                   {"step": 1, "source": "log", "field": "ordered DOSBox-X comparison", "value": "\n".join(lines)}],
                  "outputs": [{"name": "steps", "value": recorder.steps},
                              {"name": "between_steps_added_time", "value": recorder.between_steps}],
                  "started": started, "ended": match.utc(), "status": status}
        match.write_record(RUNS / (rid + ".json"), record)
        print(f"{rid}: {status}; {len(recorder.steps)} steps, {len(cases)} observations", flush=True)
        if status != "completed":
            raise SystemExit(1)
    index = build_index()
    (FIXTURES / "index.json").write_text(json.dumps(index, indent=2) + "\n")


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
        if (index["steps"], index["weeks"], index["traces"]) != (558, 6, 15):
            raise ValueError("expected 558 steps, six measured weeks, 15 source traces")
        if index != json.loads((FIXTURES / "index.json").read_text()):
            raise ValueError("observation index differs")
    except (ValueError, OSError, KeyError, StopIteration) as e:
        print(f"quick-step check: FAIL: {e}")
        return 1
    print("quick-step check: ok (558 steps, six measured weeks, all 15 T08 traces)")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
