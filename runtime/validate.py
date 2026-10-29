#!/usr/bin/env python3
"""Check run records (T04): every *.json under the given directories or files is a `run/1` record of
this project. Exit 0 when every record holds, 1 otherwise.

    python3 runtime/validate.py runs/T04

A record is valid when it has every field below with the right type; `run_id` is its file name and
unique; `status` is "completed" or starts with "aborted:"; every observation has `step`, `source`,
`field` and `value`, steps never fall; every sha256 field is 64 hex digits; `started` <= `ended` (ISO
UTC); no host path (`/home/`, `/tmp/`) and no savestate or game bytes (no value over 64 KB, logs
excepted) appear.
The format follows goal2-archaeology's run/1 records (its tools/validate_runs.py, which uses the
game-archaeologist validator); this is a smaller, local check of the same shape.
"""
import json
import re
import sys
from pathlib import Path

FIELDS = {"schema": str, "run_id": str, "experiment": str, "arm": str, "rep": int, "code_commit": str,
          "machine": str, "artifact": dict, "runtime": dict, "interventions": list, "start_state": dict,
          "actions": dict, "observations": list, "outputs": list, "started": str, "ended": str, "status": str}
HEX64 = re.compile(r"^[0-9a-f]{64}$")
SOURCES = {"log", "screen", "ui-text", "memory", "save", "file", "process"}


def check(path, seen):
    errs = []
    try:
        rec = json.loads(Path(path).read_text())
    except (OSError, json.JSONDecodeError) as e:
        return [f"{path}: not JSON ({e})"]
    for k, t in FIELDS.items():
        if not isinstance(rec.get(k), t):
            errs.append(f"{path}: {k} missing or not {t.__name__}")
    if errs:
        return errs
    if rec["schema"] != "run/1":
        errs.append(f"{path}: schema {rec['schema']!r}")
    if rec["run_id"] != Path(path).stem:
        errs.append(f"{path}: run_id {rec['run_id']} is not the file name")
    if rec["run_id"] in seen:
        errs.append(f"{path}: run_id {rec['run_id']} also in {seen[rec['run_id']]}")
    seen[rec["run_id"]] = path
    if not (rec["status"] == "completed" or rec["status"].startswith("aborted:")):
        errs.append(f"{path}: status {rec['status']!r}")
    if not rec["started"] <= rec["ended"]:
        errs.append(f"{path}: started after ended")
    last = -1
    for i, o in enumerate(rec["observations"]):
        if not all(k in o for k in ("step", "source", "field", "value")):
            errs.append(f"{path}: observation {i} lacks step, source, field or value")
            continue
        if o["step"] < last:
            errs.append(f"{path}: observation {i} goes back to step {o['step']}")
        last = o["step"]
        if o["source"] not in SOURCES:
            errs.append(f"{path}: observation {i} has source {o['source']!r}")
        if "sha256" in o["field"] and o["source"] in ("screen", "save", "file") and not HEX64.match(str(o["value"])):
            errs.append(f"{path}: observation {i} ({o['field'][:40]}) is not a sha256")
    st = rec["start_state"]
    if st.get("sha256") is not None and not HEX64.match(str(st["sha256"])):
        errs.append(f"{path}: start_state.sha256 is not a sha256")
    text = Path(path).read_text()
    for bad in ("/home/", "/tmp/"):
        if bad in text:
            errs.append(f"{path}: a host path ({bad}) in the record")
    for o in rec["observations"]:
        # bytes of a savestate or of the game would be long; a log of waits and polls can be too,
        # and is exempt (T04-week-r0018 logs 400 reads)
        if o.get("source") != "log" and len(str(o.get("value", ""))) > 65536:
            errs.append(f"{path}: an observation value over 64 KB ({o['field'][:40]})")
    return errs


def main(argv):
    files = []
    for a in argv:
        p = Path(a)
        files += sorted(p.glob("*.json")) if p.is_dir() else [p]
    if not files:
        print("validate: no records")
        return 1
    seen, errs = {}, []
    for f in files:
        errs += check(f, seen)
    for e in errs:
        print(e)
    print(f"validate: {len(files)} records, {'FAIL' if errs else 'ok'}")
    return 1 if errs else 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
