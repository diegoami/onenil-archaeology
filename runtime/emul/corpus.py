#!/usr/bin/env python3
"""A trace corpus: every completed T04 week, played as guest code from its start state and compared
with its DOSBox-X record (T08).

    python3 runtime/emul/corpus.py [--t04 runs/T04] [--out traces/T08] [--runs runs/T08] [--index-only]

For each completed `T04-week-r<nnnn>` record (status "completed"), the start state is the savestate
whose sha256 is the record's `start_state.sha256` (the load record's end savestate for a session's
first week, the previous week's otherwise); it must be a file under .cache/states/ with exactly that
sha256, or the week is not run. The week is run by match.py (its run-record behaviour: a new trace
under <out>, a new record T08-r<nnnn> under <runs>, never overwriting) with `--compare` against the
record. A week already run (a T08 record whose comparison names that T04 record) is not run again:
the command resumes.

Then <out>/index.json is written from the records and traces (derived, regenerated each time): per
week the T04 record, the start state, the trace and its sha256, the T08 run record, the verdict
("all screens met in order", or the comparison's failing line and, if the run stopped, why), the
result (teams, goals) and the draw count. The latest T08 run of a week is the one indexed; earlier
runs of it are listed under `superseded_runs`.
"""
import argparse
import hashlib
import json
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / "runtime" / "emul"))

ALL_MET = "all screens met in order"


def week_records(t04_dir):
    """The completed T04 week records, in id order: (id, path relative to ROOT, start sha256)."""
    out = []
    for p in sorted(Path(t04_dir).glob("T04-week-r*.json")):
        rec = json.loads(p.read_text())
        if rec.get("status") == "completed":
            out.append((rec["run_id"], rel(p), rec["start_state"]["sha256"]))
    return out


def rel(p):
    p = Path(p).resolve()
    return p.relative_to(ROOT).as_posix() if p.is_relative_to(ROOT) else p.as_posix()


def state_files(states_dir):
    """sha256 -> savestate path, for every *.sav under states_dir."""
    return {hashlib.sha256(p.read_bytes()).hexdigest(): p for p in sorted(Path(states_dir).rglob("*.sav"))}


def compared_record(run):
    """The T04 record a T08 run was compared with (its `--compare` argument), or None."""
    args = run["actions"]["args"]
    return args[args.index("--compare") + 1] if "--compare" in args else None


def runs_by_week(runs):
    """{T04 record path: [T08 runs, in run order]} from T08 run records."""
    out = {}
    for run in sorted(runs, key=lambda r: r["run_id"]):
        week = compared_record(run)
        if week:
            out.setdefault(Path(week).as_posix(), []).append(run)
    return out


def observation(run, field):
    return next(o["value"] for o in run["observations"] if o["field"] == field)


def verdict(run, end):
    """"all screens met in order", or the comparison's failing line, with the stop if the run stopped."""
    lines = observation(run, "comparison with a DOSBox-X week record").splitlines()
    met = run["status"] == "completed" and lines and lines[-1].startswith("all of the record's")
    if met:
        return ALL_MET
    failing = [ln for ln in lines if ln.endswith("not met in order") or ln.startswith("start state differs")]
    parts = failing or [lines[-1] if lines else "no comparison"]
    if end and end["status"] != "completed":
        parts.append(f"the run {end['status']}")
    return "; ".join(parts)


def stop_screen(events):
    """The key wait the run stopped at (its index and digest), when its screen rules had no answer."""
    for e in events:
        if e["kind"] == "screen" and e.get("action") == "unknown screen: stop":
            return {"key_wait": e["i"], "digest": e["digest"], "draws": e["draws"]}
    return None


def entry(week_id, week_path, start_sha, run, trace_text):
    """One index entry from a T04 week, its T08 run record and its trace's text."""
    events = [json.loads(ln) for ln in trace_text.splitlines() if ln.strip()]
    end = next((e for e in events if e["kind"] == "end"), None)
    trace_sha = hashlib.sha256(trace_text.encode()).hexdigest()
    recorded = observation(run, "the trace written, sha256")
    if trace_sha != recorded:
        raise ValueError(f"{run['run_id']}: the trace's sha256 {trace_sha} is not the recorded {recorded}")
    res = end.get("result") if end else None
    out = {"t04_record": week_id, "t04_record_path": week_path, "start_state_sha256": start_sha,
           "t08_run": run["run_id"], "run_status": run["status"],
           "trace": observation(run, "the trace written, path"), "trace_sha256": trace_sha,
           "verdict": verdict(run, end),
           "result": {"teams": res["teams"], "goals": res["goals"]} if res else None,
           "draws": end["draws"] if end else None,
           "key_waits": end["screens"] if end else None}
    if run["start_state"]["sha256"] != start_sha:
        out["verdict"] = f"start state differs: the run's {run['start_state']['sha256']}; " + out["verdict"]
    stop = stop_screen(events)
    if stop:
        out["stopped_at"] = stop
    return out


def build_index(weeks, runs, read_trace):
    """The index: one entry per completed T04 week, in week order. A week without a T08 run is listed
    with verdict "not run" and why (`missing`: {week id: reason})."""
    by_week = runs_by_week(runs)
    entries = []
    for week_id, week_path, start_sha in weeks:
        rs = by_week.get(week_path, [])
        if not rs:
            entries.append({"t04_record": week_id, "t04_record_path": week_path,
                             "start_state_sha256": start_sha, "verdict": "not run"})
            continue
        e = entry(week_id, week_path, start_sha, rs[-1], read_trace(observation(rs[-1], "the trace written, path")))
        if len(rs) > 1:
            e["superseded_runs"] = [r["run_id"] for r in rs[:-1]]
        entries.append(e)
    met = sum(e["verdict"] == ALL_MET for e in entries)
    return {"what": "T08: every completed T04 week traced under Unicorn (runtime/emul/match.py) from its "
                    "start state and compared with its DOSBox-X record; format: runtime/emul/corpus.py",
            "weeks": len(entries), "all_screens_met": met, "entries": entries}


def load_runs(runs_dir, experiment):
    return [json.loads(p.read_text()) for p in sorted(Path(runs_dir).glob(f"{experiment}-r*.json"))]


def main(argv=None):
    ap = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    ap.add_argument("--t04", default="runs/T04")
    ap.add_argument("--out", default="traces/T08")
    ap.add_argument("--runs", default="runs/T08")
    ap.add_argument("--experiment", default="T08")
    ap.add_argument("--index-only", action="store_true", help="write the index from the records there are")
    a = ap.parse_args(argv)
    import os
    os.chdir(ROOT)   # match.py reads --compare from the working directory; records name it relative
    weeks = week_records(ROOT / a.t04)
    print(f"{len(weeks)} completed T04 weeks")
    if not a.index_only:
        import match
        have = state_files(ROOT / ".cache" / "states")
        missing = [(w, s) for w, _, s in weeks if s not in have]
        if missing:
            raise SystemExit("start states not under .cache/states: " + ", ".join(f"{w} ({s})" for w, s in missing))
        for week_id, week_path, start_sha in weeks:
            print(f"{week_id}: start state {rel(have[start_sha])} ({start_sha[:16]})")
        done = runs_by_week(load_runs(ROOT / a.runs, a.experiment))
        for week_id, week_path, start_sha in weeks:
            if week_path in done:
                print(f"{week_id}: already run ({done[week_path][-1]['run_id']})")
                continue
            print(f"{week_id}: running")
            match.main(["--state", start_sha, "--compare", week_path, "--out", a.out, "--runs", a.runs,
                        "--experiment", a.experiment])
    index = build_index(weeks, load_runs(ROOT / a.runs, a.experiment), lambda p: (ROOT / p).read_text())
    path = ROOT / a.out / "index.json"
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(index, indent=2, ensure_ascii=False) + "\n", newline="\n")
    print(f"{rel(path)}: {index['weeks']} weeks, {index['all_screens_met']} with all screens met in order")
    return 0


if __name__ == "__main__":
    sys.exit(main())
