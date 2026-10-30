#!/usr/bin/env python3
"""T11: record original D983 calls and link decoded replay cases to T08 (no engine model).

    python3 runtime/emul/contests.py --run
    python3 runtime/emul/contests.py --check

One original run per distinct full draw stream; all 15 T08 traces are checked. Failed
attempts remain immutable and may be retried. Fixtures hold only decoded inputs/outputs.
"""
import argparse
import hashlib
import json
import platform
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / "runtime" / "emul"))
import match

SITES = {"0AB9:D9BD", "0AB9:D9CC", "0AB9:D9E4", "0AB9:D9F3", "0AB9:DA0B", "0AB9:DA1A"}
RUNS = ROOT / "runs/T11"
FIXTURES = ROOT / "traces/T11"


def sha(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def events(path):
    return [json.loads(line) for line in Path(path).read_text().splitlines()]


def draw_stream(trace):
    return [e for e in trace if e["kind"] == "draw"]


def stream_key(trace):
    # T08 repeats a week from different emulator savestates. Group by the complete
    # measured draw stream, including callers, not by score, seed alone or filename.
    return hashlib.sha256(json.dumps(draw_stream(trace), sort_keys=True).encode()).hexdigest()


def corpus_groups(index, read_trace):
    groups = {}
    for entry in index["entries"]:
        if entry["run_status"] != "completed" or entry["verdict"] != "all screens met in order":
            raise ValueError("T08 entry is not completed and compared")
        path, trace = read_trace(entry["trace"])
        if sha(path) != entry["trace_sha256"]:
            raise ValueError("T08 trace digest differs")
        if trace[0]["state_sha256"] != entry["start_state_sha256"]:
            raise ValueError("T08 start state differs")
        if trace[-1]["status"] != "completed":
            raise ValueError("T08 trace is incomplete")
        groups.setdefault(stream_key(trace), []).append((entry, trace))
    return groups


def normalized(draw):
    sites = [c for c in draw["callers"] if c in SITES]
    if len(sites) != 1:
        raise ValueError("draw is not attributed to exactly one D983 site")
    return {"site": sites[0], **{k: draw[k] for k in ("n", "seed_before", "seed_after", "value")}}


def cases_for(calls, trace, source, week):
    """Export recorded semantics and a literal slice of the independently retained trace."""
    draws, result = draw_stream(trace), []
    previous_end = 0
    for number, call in enumerate(calls):
        begin, end = call["draw_start"], call["draw_end"]
        if not (previous_end <= begin <= end <= len(draws)):
            raise ValueError("missing, overlapping or invalid call span")
        selected = draws[begin:end]
        if [d["i"] for d in selected] != list(range(begin, end)):
            raise ValueError("source draw indices are not contiguous")
        if call["input"]["seed"] != (selected[0]["seed_before"] if selected else call["output"]["seed"]):
            raise ValueError("routine input seed differs from the trace")
        if selected and call["output"]["seed"] != selected[-1]["seed_after"]:
            raise ValueError("routine output seed differs from the trace")
        if call["ratings_after"] != call["input"]["ratings"]:
            raise ValueError("D983 changed the recorded ratings")
        result.append({"schema": "routine-case/1", "week": week, "call": number,
                       "input": call["input"], "output": call["output"],
                       "source": {"trace": source["trace"], "sha256": source["trace_sha256"],
                                  "draw_start": begin, "draw_end": end},
                       "draws": [normalized(d) for d in selected]})
        previous_end = end
    # Every managed D983 draw must be owned by one call; a truncated/missing call
    # cannot pass just because the remaining calls match literal trace slices.
    managed_end = next(e["draws"] for e in trace if e["kind"] == "mark" and e["what"].startswith("match return"))
    covered = [i for c in calls for i in range(c["draw_start"], c["draw_end"])]
    expected = [d["i"] for d in draws[:managed_end] if any(c in SITES for c in d["callers"])]
    if covered != expected:
        raise ValueError("routine spans do not cover every managed D983 draw")
    return result


class Recorder:
    def __init__(self, week):
        self.week, self.active, self.pending, self.calls = week, False, None, []
        g = week.g
        g.code_hook(match.MATCH, lambda g: setattr(self, "active", True))
        g.code_hook(match.MATCH_RETURN, lambda g: setattr(self, "active", False))
        g.code_hook("0AB9:D983", self.enter)
        g.code_hook("0AB9:DA3D", self.leave)

    def enter(self, g):
        if not self.active:
            return
        if self.pending is not None or g.reg("ds") != g.DS:
            raise ValueError("unexpected D983 nesting or data segment")
        self.seed_ptr = g.far(0xDE84)
        self.pending = {"draw_start": self.week.draws,
                        "seed_target": g.image_address(g.rd(0xDE86), g.rd(0xDE84)),
                        "input": {"k": g.stack_word(2), "seed": g.word_at(self.seed_ptr),
                                  "ratings": [g.rd(0xD674 + 2 * i) for i in range(8)],
                                  "goals": list(g.mem(g.DS * 16 + 0xD086, 2))}}

    def leave(self, g):
        if self.pending is None:
            return
        call = self.pending
        call.update(draw_end=self.week.draws,
                    output={"seed": g.word_at(self.seed_ptr), "goals": list(g.mem(g.DS * 16 + 0xD086, 2))},
                    ratings_after=[g.rd(0xD674 + 2 * i) for i in range(8)])
        self.calls.append(call)
        self.pending = None


def read_corpus():
    index = json.loads((ROOT / "traces/T08/index.json").read_text())
    return index, corpus_groups(index, lambda p: (ROOT / p, events(ROOT / p)))


def outputs(record):
    return {o["name"]: o["value"] for o in record["outputs"]}


def selected_runs():
    selected = {}
    for path in sorted(RUNS.glob("T11-r*.json")):
        record = json.loads(path.read_text())
        selected[record["actions"]["stream_key"]] = (path, record)
    return {key: pair for key, pair in selected.items() if pair[1]["status"] == "completed"}


def run():
    import cycle
    import unicorn
    if match.git("status", "--porcelain", "--", "runtime/emul"):
        raise SystemExit("commit runtime/emul before recording original calls")
    commit = match.git("rev-parse", "--short", "HEAD")
    _, groups = read_corpus()
    RUNS.mkdir(parents=True, exist_ok=True)
    FIXTURES.mkdir(parents=True, exist_ok=True)
    have = selected_runs()
    for key, members in groups.items():
        if key in have:
            print(f"already recorded {have[key][1]['run_id']}", flush=True)
            continue
        source, reference = members[-1]  # the third-session states, also measured by T09
        started = match.utc()
        path, data = match.find_state(source["start_state_sha256"])
        week, status, lines, cases = match.Week(data), "completed", [], []
        recorder = Recorder(week)
        try:
            week.play()
            if week.g.unsupported or recorder.pending is not None:
                raise ValueError("unsupported service or incomplete routine")
            if week.events != reference[1:-1]:
                raise ValueError("new week events differ from retained T08 trace")
            ok, lines = match.compare(week.events, source["start_state_sha256"], ROOT / source["t04_record_path"])
            if not ok:
                raise ValueError("DOSBox-X comparison failed")
            cases = cases_for(recorder.calls, reference, source, source["t04_record"])
        except (Exception, KeyboardInterrupt) as e:
            status = f"aborted: {type(e).__name__}: {e}"
        n = max(match.next_number(RUNS, "T11-r*.json"), match.next_number(FIXTURES, "T11-r*.jsonl"))
        rid = f"T11-r{n:04d}"
        fixture = FIXTURES / (rid + ".jsonl")
        with fixture.open("x") as f:
            for case in cases:
                f.write(json.dumps(case, sort_keys=True) + "\n")
        record = {"schema": "run/1", "run_id": rid, "experiment": "T11", "arm": "quick-contests", "rep": n,
                  "code_commit": commit, "machine": cycle.machine_id(),
                  "artifact": {"set": "One-Nil96 (records/T01/inventory.json)", "variant": None},
                  "runtime": {"harness": f"runtime/emul/contests.py@{commit}", "unicorn": unicorn.__version__,
                              "python": platform.python_version()},
                  "interventions": [{"level": "I3", "what": "original code under guest.py; read-only routine hooks"}],
                  "start_state": {"id": match.rel(path), "sha256": source["start_state_sha256"],
                                  "restore": "DOSBox-X savestate loaded by runtime/emul/guest.py"},
                  "seed": None,
                  "actions": {"script": "runtime/emul/contests.py", "stream_key": key,
                              "week_record": source["t04_record_path"], "source": source,
                              "game_files": {k: hashlib.sha256(v).hexdigest() for k, v in week.files_at_start.items()}},
                  "observations": [{"step": 0, "source": "file", "field": "fixture path", "value": match.rel(fixture)},
                                   {"step": 0, "source": "file", "field": "fixture sha256", "value": sha(fixture)},
                                   {"step": 1, "source": "log", "field": "ordered DOSBox-X comparison", "value": "\n".join(lines)}],
                  "outputs": [{"name": "calls", "value": recorder.calls}],
                  "started": started, "ended": match.utc(), "status": status}
        match.write_record(RUNS / (rid + ".json"), record)
        print(f"{rid}: {status}; {len(recorder.calls)} calls, {len(cases)} cases", flush=True)
        if status != "completed":
            raise SystemExit(1)
    write_index()


def build_index():
    index, groups = read_corpus()
    selected, records, coverage = selected_runs(), [], []
    for key, members in groups.items():
        if key not in selected:
            raise ValueError("missing completed routine run")
        path, record = selected[key]
        source = record["actions"]["source"]
        if record["start_state"]["sha256"] != source["start_state_sha256"]:
            raise ValueError("routine run start state differs")
        canonical = next((t for e, t in members if e == source), None)
        if canonical is None:
            raise ValueError("routine source does not match corpus entry")
        calls = outputs(record)["calls"]
        expected = cases_for(calls, canonical, source, source["t04_record"])
        obs = {o["field"]: o["value"] for o in record["observations"]}
        fixture = ROOT / obs["fixture path"]
        if sha(fixture) != obs["fixture sha256"] or events(fixture) != expected:
            raise ValueError("fixture differs from recorded calls or source draws")
        records.append({"record": match.rel(path), "record_sha256": sha(path), "cases": fixture.name,
                        "cases_sha256": sha(fixture), "week": source["t04_record"], "calls": len(calls),
                        "source_trace": source["trace"], "source_trace_sha256": source["trace_sha256"],
                        "producer_commit": record["code_commit"]})
        for other, trace in members:
            cases_for(calls, trace, other, other["t04_record"])
            # Equality of grouped streams is checked again against each span; the
            # routine outputs were measured in the canonical state, not all repeats.
            coverage.append({"t04_record": other["t04_record"], "trace": other["trace"],
                             "trace_sha256": other["trace_sha256"], "cases": fixture.name})
    return {"schema": "quick-contests/1", "routine": "0AB9:D983",
            "producer_commit": records[0]["producer_commit"] if records else None,
            "corpus_sha256": sha(ROOT / "traces/T08/index.json"), "records": records, "coverage": coverage,
            "calls": sum(r["calls"] for r in records), "weeks": len(records), "traces": len(coverage)}


def write_index():
    value = build_index()
    (FIXTURES / "index.json").write_text(json.dumps(value, indent=2) + "\n")
    return value


def main(argv=None):
    ap = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    choice = ap.add_mutually_exclusive_group(required=True)
    choice.add_argument("--run", action="store_true")
    choice.add_argument("--check", action="store_true")
    a = ap.parse_args(argv)
    if a.run:
        run()
        return 0
    try:
        actual = build_index()
        if (actual["calls"], actual["weeks"], actual["traces"]) != (558, 6, 15):
            raise ValueError("expected 558 calls, six distinct weeks, 15 source traces")
        if actual != json.loads((FIXTURES / "index.json").read_text()):
            raise ValueError("fixture index differs from measured evidence")
    except (ValueError, OSError, KeyError, StopIteration) as e:
        print(f"contests check: FAIL: {e}")
        return 1
    print("contests check: ok (558 calls, six measured weeks, all 15 T08 traces)")
    return 0


if __name__ == "__main__":
    sys.exit(main())
