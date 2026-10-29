#!/usr/bin/env python3
"""T05: F03's layouts read back from One-Nil 96's memory after it loads SAVE1.1-0.

    python3 runtime/layouts.py run [--out runs/T05]      one run: launch, Y, the main menu, a savestate,
                                                         the comparison; writes T05-r<nnnn>.json
    python3 runtime/layouts.py --check <record.json>     the record's league names equal one league
                                                         file's and at least 20 of the 28 save blocks
                                                         are equal; exit 0 when so

The comparison (compare(), below) reads guest memory from the savestate: 1-0.EXE's data segment is
found by its memory control block (runtime/driver/savestate.py), a destination `DS:XXXX` is DS + XXXX,
and `[DS:XXXX]` is the far pointer stored there (offset word, then segment word, as the program left
it after relocation: linear address segment * 16 + offset). The league side decodes the club names
(R06, [DS:D7B2], 176 x 16 bytes) and the division names (R05, DS:DCE6, 7 x 16) from memory and
compares them with each league file's (tools/data/league.py); the save side compares the sha256 of
the memory at each save block's destination with that block's sha256 in records/T03/saves.json.
A record holds names, digests and verdicts, never memory bytes.
"""
import argparse
import hashlib
import json
import platform
import struct
import sys
import time
import traceback
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "runtime" / "driver"))
sys.path.insert(0, str(ROOT / "tools" / "data"))
import league  # noqa: E402
import save  # noqa: E402
import savestate  # noqa: E402

SAVE_RECORD = ROOT / "records" / "T03" / "saves.json"
SAVE_FILE = "One-Nil96/SAVE1.1-0"
STATES = ROOT / ".cache" / "states" / "T05"
LOAD_WAIT = 3.0  # F04: no savestate while the game reads the save


def linear(mem, ds_base, dest):
    """The linear address of a destination: DS:XXXX, or the far pointer at [DS:XXXX]."""
    off = int(dest.strip("[]").split(":")[1], 16)
    if dest.startswith("["):
        p_off, p_seg = struct.unpack("<HH", mem(ds_base + off, 4))
        return p_seg * 16 + p_off
    return ds_base + off


def compare(mem, ds_base, league_names, save_blocks):
    """mem(addr, n) -> bytes. league_names: {file: (division names, club names)}. save_blocks: the
    blocks of records/T03/saves.json for SAVE1.1-0. Returns the comparison as a dict."""
    clubs, _ = league.pascal_strings(mem(linear(mem, ds_base, "[DS:D7B2]"), 0xB00), 16)
    divs, _ = league.pascal_strings(mem(ds_base + 0xDCE6, 0x70), 16)
    match = sorted(f for f, (dv, cl) in league_names.items() if cl == clubs and dv == divs)
    blocks = []
    for b in save_blocks:
        addr = linear(mem, ds_base, b["destination"])
        got = hashlib.sha256(mem(addr, b["size"])).hexdigest()
        blocks.append({"destination": b["destination"], "size": b["size"], "linear": "0x%05X" % addr,
                       "memory_sha256": got, "save_sha256": b["sha256"],
                       "verdict": "equal" if got == b["sha256"] else "differs"})
    return {"league": {"club_names_in_memory": len(clubs), "division_names_in_memory": divs,
                       "first_club_names_in_memory": clubs[:3], "league_files_equal": match},
            "save": {"blocks": blocks, "equal": sum(b["verdict"] == "equal" for b in blocks)}}


def league_names_from(cache):
    out = {}
    for name, path in league.league_files(cache):
        by = {b["name"]: b for b in league.decode(Path(path).read_bytes())}
        out[name] = (by["division_names"]["strings"], by["club_names"]["strings"])
    return out


def save_blocks():
    return json.loads(SAVE_RECORD.read_text())["files"][SAVE_FILE]["blocks"]


def run(out):
    import cycle  # noqa: E402
    import driver  # noqa: E402
    import screens  # noqa: F401,E402
    dirty = cycle.git("status", "--porcelain", "--", "runtime")
    if dirty:
        raise SystemExit("uncommitted changes under runtime/: commit them first\n" + dirty)
    commit = cycle.git("rev-parse", "--short", "HEAD")
    out_dir = ROOT / out
    out_dir.mkdir(parents=True, exist_ok=True)
    n = 1 + max((int(p.stem.split("-r")[1]) for p in out_dir.glob("T05-r*.json")), default=0)
    run_id = f"T05-r{n:04d}"
    d = driver.Driver(workdir=driver.SCRATCH / "layouts")
    obs, status, outputs = [], "completed", []
    try:
        sc = d.launch(None)
        obs.append({"step": 0, "source": "screen", "field": "title screen, sha256", "value": sc.digest()})
        d.keys("y")
        time.sleep(LOAD_WAIT)  # F04's rule; logged by keys() and here
        d.log(f"waited {LOAD_WAIT}s after Y before the first savestate")
        sc = d.wait_screen(lambda s: "PLAY NEXT GAME" in s.text(), 30, "main menu after Y")
        obs.append({"step": 1, "source": "screen", "field": "main menu after Y, text screen 80x25, sha256", "value": sc.digest()})
        obs.append({"step": 1, "source": "ui-text", "field": "main menu after Y, CP437 decoded", "value": sc.text()})
        data = d.last_blob
        STATES.mkdir(parents=True, exist_ok=True)
        with open(STATES / f"{run_id}.sav", "xb") as f:
            f.write(data)
        st = savestate.Savestate(data)
        prog = st.program()
        obs.append({"step": 2, "source": "save", "field": "sha256 of the savestate the comparison reads (.cache/states/T05/, the owner's Drive states/T05/)", "value": driver.sha256(data)})
        obs.append({"step": 2, "source": "memory", "field": "where 1-0.EXE was loaded (its MCB, PSP, load segment, data segment)", "value": prog.describe()})
        result = compare(st.memory, prog.ds_base, league_names_from(ROOT / ".cache"), save_blocks())
        outputs.append({"name": "comparison", "value": result})
    except Exception as e:  # noqa: BLE001
        status = f"aborted: {type(e).__name__}: {e}".splitlines()[0][:300]
        traceback.print_exc()
    finally:
        d.terminate()
    obs.append({"step": 3, "source": "log", "field": "waits, polls and key holds, seconds since launch", "value": json.dumps(d.events, separators=(",", ":"))})
    conf_text, conf_sha = d.conf_public()
    rec = {"schema": "run/1", "run_id": run_id, "experiment": "T05", "arm": "load-save1-read-memory", "rep": n,
           "code_commit": commit, "machine": cycle.machine_id(),
           "artifact": {"set": driver.verify_release(driver.CACHE), "variant": None},
           "runtime": {"driver": f"runtime/driver/driver.py@{commit}", "platform": f"python-{platform.python_version()}/{cycle.machine_id()}",
                       "fingerprint": cycle.fingerprint(d, conf_sha)},
           "interventions": [{"level": "I1", "what": "text screen and guest memory read from a DOSBox-X savestate"},
                             {"level": "I2", "what": "savestates written at each read"}],
           "start_state": {"id": "fresh launch", "sha256": None,
                           "restore": "fresh DOSBox-X process; C: a copy of One-Nil 96's files (records/T01/inventory.json); 1-0 run to its title screen; host clock not controlled"},
           "seed": None,
           "actions": {"script": "runtime/layouts.py", "sha256": driver.sha256(Path(__file__).read_bytes()), "keys": ["title: y"]},
           "observations": obs, "outputs": outputs,
           "started": d.launched["utc"] if d.launched else driver.host_times()["utc"],
           "ended": driver.host_times()["utc"], "status": status}
    text = json.dumps(rec, indent=2, ensure_ascii=False) + "\n"
    if str(ROOT) in text:
        raise SystemExit("a host path leaked into the record")
    with open(out_dir / f"{run_id}.json", "x", encoding="utf-8") as f:
        f.write(text)
    print(f"{run_id}: {status}")
    return 0 if status == "completed" else 1


def check(path):
    rec = json.loads(Path(path).read_text())
    if rec["status"] != "completed" or not rec["outputs"]:
        print("layouts check: FAIL (the run did not complete)")
        return 1
    res = rec["outputs"][0]["value"]
    files = res["league"]["league_files_equal"]
    eq = res["save"]["equal"]
    print("club and division names in memory equal those of: %s" % (", ".join(files) or "no league file"))
    for b in res["save"]["blocks"]:
        print("  %-10s %6d bytes  %s" % (b["destination"], b["size"], b["verdict"]))
    ok = len(files) >= 1 and eq >= 20
    print("save blocks equal: %d of %d; layouts check: %s" % (eq, len(res["save"]["blocks"]), "ok" if ok else "FAIL"))
    return 0 if ok else 1


def main(argv=None):
    ap = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    ap.add_argument("cmd", nargs="?", choices=["run"])
    ap.add_argument("--out", default="runs/T05")
    ap.add_argument("--check")
    a = ap.parse_args(argv)
    if a.check:
        return check(a.check)
    if a.cmd == "run":
        return run(a.out)
    ap.print_help()
    return 2


if __name__ == "__main__":
    sys.exit(main())
