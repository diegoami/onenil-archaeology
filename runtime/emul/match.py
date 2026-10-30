#!/usr/bin/env python3
"""Play one week of One-Nil 96 as guest code under Unicorn from a savestate, and trace its draws (T06).

    python3 runtime/emul/match.py --state <sha256> [--out traces/T06] [--runs runs/T06]
                                  [--compare runs/T04/<week record>.json] [--max-screens 60]
                                  [--experiment T06]

The start state is a savestate the T04 or T05 records name by sha256, found in .cache/states/. From its
main menu the run does what runtime/driver/weeks.py does in DOSBox-X, closed-loop on the guest's own text
page: select PLAY NEXT GAME, PLAY GAME on the pre-match screen, Space at a key wait on a match board or a
"press any key" / "hit any key" / "any other key to continue" screen, Return through a PLAYER CONTRACT
screen, N at a (Y/N) question, until the main menu is back. With Watch match on (T10), as
runtime/driver/watched.py: no key while the watched pitch runs (a stop of the guest at polls from outside
readkey's loop on a screen with "spacebar-commentary" and no key prompt is a "run-on" event, and the run
goes on), n at the watched full-time screen ("any other key to exit"). Keys go in through the game's own keyboard
handler (runtime/emul/guest.py).

Each run writes, never overwriting (CLAUDE.md rule 13):
  <out>/<state sha256[:16]>-week-r<nnnn>.jsonl   the trace (format: runtime/emul/README.md)
  <runs>/<experiment>-r<nnnn>.json                a run record: the code commit, the state, the
                                                  settings, the game files' sha256, the trace's
                                                  sha256, the result, the comparison
The code under runtime/emul/ must be committed first, so the record names the code that ran.
"""
import argparse
import hashlib
import json
import os
import platform
import re
import subprocess
import sys
import time
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / "runtime" / "emul"))
sys.path.insert(0, str(ROOT / "runtime" / "driver"))
sys.path.insert(0, str(ROOT / "tools" / "data"))
import cycle  # noqa: E402
import checkpoint  # noqa: E402
import guest  # noqa: E402
import listing  # noqa: E402
import save  # noqa: E402
import screens  # noqa: E402

LCG = "24BC:0CDC"        # F02 item 4: s := s*0x7ABD + 0x1B0F; returns ((s*n) >> 16) + 1
LCG_LEAVE = "24BC:0CFD"  # its `leave`: AX holds the value, the seed is written
MATCH = "0AB9:E1F2"      # F02 item 5: plays a match; its one caller is 0AB9:EAB6
MATCH_RETURN = "0AB9:EBE2"   # EAB6: `EBDF call 0xe1f2` returns here (seg_0AB9_22.asm)
DEPTH = 4                # return addresses kept per draw
GAME_DIR = ROOT / ".cache" / "One-Nil96"


def find_state(sha):
    for p in sorted((ROOT / ".cache" / "states").rglob("*.sav")):
        data = p.read_bytes()
        if hashlib.sha256(data).hexdigest().startswith(sha):
            return p, data
    raise SystemExit(f"no savestate with sha256 {sha}... under .cache/states (rclone copy onenildrive:states .cache/states)")


def game_files():
    return {p.name.upper(): p.read_bytes() for p in sorted(GAME_DIR.iterdir()) if p.is_file()}


class Week:
    def __init__(self, data):
        self.files_at_start = game_files()
        self.g = guest.Guest(data, files=self.files_at_start)
        self.events = []
        self.draws = 0
        self._pending = None
        self.started = False      # PLAY NEXT GAME chosen
        self.board = None
        self.screen_i = self.run_on = 0
        self.finished = False
        self.install_hooks()

    def install_hooks(self):
        self.g.code_hook(LCG, self._lcg_entry)
        self.g.code_hook(LCG_LEAVE, self._lcg_leave)
        self.g.code_hook(MATCH, lambda g: self._mark("match entry " + MATCH))
        self.g.code_hook(MATCH_RETURN, lambda g: self._mark("match return to " + MATCH_RETURN))

    def _mark(self, what):
        self.events.append({"kind": "mark", "what": what, "draws": self.draws})

    def callers(self):
        """Return addresses from 24BC:0CDC's entry up the BP chain, image addresses of the listing.
        The first is read from the stack (0CDC returns far: IP, CS). Each next one is read from the
        frame of the routine that holds the last address: [BP+2] (and [BP+4] for CS) when the
        listing says that routine sets up a BP frame and returns far, [BP+2] with the same CS when
        it returns near; where the listing cannot say, the chain ends with "?"."""
        g = self.g
        ss, bp = g.reg("ss"), g.reg("bp")
        ip, cs = g.stack_word(0), g.stack_word(2)
        out = [g.image_address(cs, ip)]
        for _ in range(DEPTH - 1):
            seg = (cs - g.load) & 0xFFFF
            form = listing.frame_form(seg, ip)
            if form is None or not bp:
                out.append("?")
                break
            nip = g.word_at(ss * 16 + bp + 2)
            ncs = g.word_at(ss * 16 + bp + 4) if form == "far" else cs
            out.append(g.image_address(ncs, nip))
            ip, cs, bp = nip, ncs, g.word_at(ss * 16 + bp)
        return out

    def _lcg_entry(self, g):
        n = g.stack_word(4)
        ptr = g.stack_word(8) * 16 + g.stack_word(6)
        self._pending = {"kind": "draw", "i": self.draws, "n": n, "seed_before": g.word_at(ptr),
                         "callers": self.callers(), "_ptr": ptr}

    def _lcg_leave(self, g):
        d = self._pending
        if d is None:
            return
        d["seed_after"] = g.word_at(d.pop("_ptr"))
        d["value"] = g.reg("ax")
        self.events.append(d)
        self.draws += 1
        self._pending = None

    def play(self, max_screens=60, step_budget=400_000_000, max_run_on=2000, on_boundary=None):
        g = self.g
        if self.finished:
            return g.screen()
        while self.screen_i < max_screens and not self.finished:
            # All actions from the previous stop are already queued. The machine is
            # outside Unicorn and may be saved/restored without repeating a screen.
            if on_boundary:
                on_boundary(self)
            if not g.run(max_steps=step_budget):
                raise guest.GuestError(f"no key wait within {step_budget} instructions (at {g.where()})")
            sc = g.screen()
            text, low = sc.text(), sc.text().lower()
            if watched_pitch_running(g, text):
                # T10: the watched pitch polls keypressed on every tick (1998:00F1) and runs on; the
                # guest stops it after OTHER_STALL_POLLS such polls. runtime/driver/watched.py presses
                # nothing while the pitch changes, so no key here either: the run goes on.
                self.events.append({"kind": "run-on", "n": self.run_on, "digest": sc.digest(), "draws": self.draws,
                                    "caller": g.wait_caller})
                self.run_on += 1
                compact_services(g)
                if self.run_on > max_run_on:
                    raise guest.GuestError(f"the watched pitch still running after {max_run_on} stops")
                continue
            ev = {"kind": "screen", "i": self.screen_i, "digest": sc.digest(), "draws": self.draws}
            self.screen_i += 1
            hi = [t for _, t in screens.highlighted(sc)]
            if "FULL TIME" in text and ("press any key" in low or "any other key to exit" in low):
                self.board = (text, sc.digest())   # the full-time board (T10: or the watched one): the week's result
            if "GAME NAME" in text and "PLAY NEXT GAME" in text:
                if self.started:
                    ev["action"] = "main menu after the week: stop"
                    self.events.append(ev)
                    self.finished = True
                    return sc
                keys = ["Return"] if any(t.startswith("PLAY NEXT GAME") for t in hi) else ["Down"]
                self.started = keys == ["Return"]
            elif "commentary" in text and "any other key to exit" in low:
                # T10: the watched match's full-time screen (Space views the commentary, P prints it,
                # Return is the bench); runtime/driver/watched.py presses n
                keys = ["n"]
            elif "commentary" in text and ("versus" in text or "spacebar-commentary" in text):
                keys = ["space"]
            elif "PLAY GAME" in text and "Change tactics" in text:
                keys = ["Return"] if any(t.startswith("PLAY GAME") for t in hi) else ["Down"]
            elif "press any key" in low or "hit any key" in low or "any other key to continue" in low:
                keys = ["space"]
            elif "PLAYER CONTRACT" in text:
                keys = ["Return"]
            elif "(y/n)" in low:
                keys = ["n"]
            else:
                ev["action"] = "unknown screen: stop"
                self.events.append(ev)
                raise guest.GuestError(f"unknown screen at key wait {ev['i']}")
            ev["action"] = " ".join(keys)
            self.events.append(ev)
            g.press(*keys)
        raise guest.GuestError(f"no main menu after {max_screens} key waits")

    def state_digests(self):
        """The sha256 of the memory at each save block's destination (F03 R24-R51), as runtime/layouts.py
        reads them: what the week left in the game's state, without its bytes."""
        g, out = self.g, {}
        for dest, size in save.BLOCKS:
            off = int(dest.strip("[]").split(":")[1], 16)
            addr = g.far(off) if dest.startswith("[") else g.DS * 16 + off
            out[dest] = hashlib.sha256(g.mem(addr, size)).hexdigest()
        return out

    def files_written(self):
        """Files the week created or changed in the guest's folder: name, size, sha256."""
        return [{"name": n, "size": len(b), "sha256": hashlib.sha256(b).hexdigest()}
                for n, b in sorted(self.g.files.items()) if self.files_at_start.get(n) != b]


def compact_services(g):
    """T10: keep one entry of g.services per (interrupt, function) that end.services reports (AX for
    INT 33h, AH otherwise): a watched match calls the mouse driver tens of millions of times, and the
    full log (counted anyway in service_counts) grew past 4 GB in the first watched run. end.services
    is the same set either way."""
    keep = {}
    for n, ax, at in g.services:
        keep.setdefault((n, ax if n == 0x33 else ax >> 8), (n, ax, at))
    g.services[:] = list(keep.values())


def watched_pitch_running(g, text):
    """T10: the watched pitch (its footer "spacebar-commentary", no key prompt) stopped by polls of
    keypressed from outside readkey's loop: the match runs on and waits for no key."""
    low = text.lower()
    return (g.wait_caller != guest.READKEY_LOOP and "spacebar-commentary" in text
            and "press any key" not in low and "any other key" not in low)


def result(board):
    """The full-time board's score: rows 1 and 3 read `│<TEAM>│ <goals>│`; with its screen digest."""
    text, digest = board
    rows = text.splitlines()
    out = {"board_digest": digest, "teams": [], "goals": []}
    for r in (1, 3):
        parts = rows[r].split("│")
        out["teams"].append(parts[1].rstrip("-").strip())
        out["goals"].append(int(parts[2]))
    return out


def compare(trace_events, state_sha, record_path):
    """Check the trace against a DOSBox-X week record: the record starts from the same state, and its
    key-wait screens (a match board's first and last reads left out, below), in its order, occur in
    the trace's key-wait screens in that order (an ordered
    subsequence: each record screen matched by a later trace screen than the one before). Returns
    (ok, lines)."""
    rec = json.loads(Path(record_path).read_text())
    lines, ok = [], True
    rec_state = rec.get("start_state", {}).get("sha256")
    if rec_state != state_sha:
        ok = False
        lines.append(f"start state differs: the record's {rec_state}, the trace's {state_sha}")
    # A DOSBox-X record reads a match board several times (runtime/driver/weeks.py): its first read,
    # while the board may still change, its reads before Space ("unchanged for N reads"), and its last
    # read. Only a read before a key is a key wait, the only screens a trace holds; the first and last
    # reads of a board are left out (T08).
    want = [(o["field"].split(":")[0], o["value"]) for o in rec["observations"]
            if "chars+attributes" in o["field"]
            and "(match, first read)" not in o["field"] and "(match, last read)" not in o["field"]]
    have = [(e["i"], e["digest"]) for e in trace_events if e["kind"] == "screen"]
    k = 0
    for name, digest in want:
        while k < len(have) and have[k][1] != digest:
            k += 1
        if k == len(have):
            ok = False
            lines.append(f"{name} ({digest[:16]}) not met in order")
            k = 0 if not have else k
            break
        lines.append(f"{name} ({digest[:16]}) = key wait {have[k][0]}")
        k += 1
    lines.append(f"{'all' if ok else 'not all'} of the record's {len(want)} screens met in order")
    return ok, lines


def git(*a):
    return subprocess.run(["git", "-C", str(ROOT), *a], capture_output=True, text=True).stdout.strip()


def next_number(directory, pattern):
    paths = list(Path(directory).glob(pattern)) + list((Path(directory) / "partial").glob(pattern))
    numbers = [int(m[1]) for p in paths if (m := re.search(r"-r(\d+)(?:-p\d+)?$", p.stem))]
    return 1 + max(numbers, default=0)


def rel(path):
    return Path(os.path.relpath(Path(path).resolve(), ROOT)).as_posix()


def utc():
    from datetime import datetime, timezone
    return datetime.now(timezone.utc).strftime("%Y-%m-%dT%H:%M:%SZ")


def signature():
    # A docs/checkpoint publication commit may change HEAD while the running code stays
    # identical. Resume requires identical code, Unicorn and clock/input settings.
    import unicorn
    sources = sorted((ROOT / "runtime" / "emul").glob("*.py"))
    sources += sorted((ROOT / "runtime" / "driver").glob("*.py"))
    sources += [ROOT / "tools" / "data" / "save.py"]
    return {"sources": {rel(p): checkpoint.digest(p) for p in sources},
            "unicorn": unicorn.__version__, "python": platform.python_version(),
            "constants": {k: getattr(guest, k) for k in
                          ("INSTR_PER_S", "PIT_HZ", "KEY_HOLD", "STALL_POLLS", "OTHER_STALL_POLLS",
                           "IF_RETRY", "SLICE_MAX")}}


def write_record(path, record):
    path = Path(path)
    path.parent.mkdir(parents=True, exist_ok=True)
    with path.open("x", encoding="utf-8") as f:
        f.write(json.dumps(record, indent=2, ensure_ascii=False) + "\n")
        f.flush()
        os.fsync(f.fileno())


def publish_partial(chunk, receipt, private, remote_path):
    # Foreground, opt-in publication. Commit only this immutable chunk and receipt.
    subprocess.run(["rclone", "copyto", str(private), "onenildrive:" + remote_path], check=True)
    subprocess.run(["git", "-C", str(ROOT), "add", "--", rel(chunk), rel(receipt)], check=True)
    subprocess.run(["git", "-C", str(ROOT), "commit", "--only", "-m",
                    "checkpoint: " + receipt.stem, "--", rel(chunk), rel(receipt)], check=True)
    subprocess.run(["git", "-C", str(ROOT), "push", "origin", "HEAD"], check=True)


def main(argv=None):
    ap = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    state_arg = ap.add_mutually_exclusive_group(required=True)
    state_arg.add_argument("--state", help="sha256 (or a prefix) of the start savestate")
    state_arg.add_argument("--resume", help="a partial run receipt; restores its private checkpoint")
    ap.add_argument("--out")
    ap.add_argument("--runs")
    ap.add_argument("--max-screens", type=int, default=60)
    ap.add_argument("--compare", help="a DOSBox-X week record from the same start state")
    ap.add_argument("--experiment", help="run records' experiment and id prefix (default T06)")
    ap.add_argument("--checkpoint-seconds", type=float, default=300,
                    help="publish a durable partial record at guest stops, at this wall-time interval")
    ap.add_argument("--publish-checkpoints", action="store_true",
                    help="upload private checkpoints to Drive and commit/push decoded chunks/receipts")
    ap.add_argument("--stop-after-checkpoints", type=int, default=0,
                    help="stop after N checkpoints (including the initial one), for recovery checks")
    a = ap.parse_args(argv)
    if a.checkpoint_seconds <= 0:
        ap.error("--checkpoint-seconds must be positive")
    dirty = git("status", "--porcelain", "--", "runtime/emul", "runtime/driver", "tools/data/save.py")
    if dirty:
        raise SystemExit("uncommitted runtime changes: commit them first so the record names the code that ran\n" + dirty)
    if a.publish_checkpoints and git("branch", "--show-current") in ("main", ""):
        ap.error("checkpoint publication requires a task branch")
    commit = git("rev-parse", "--short", "HEAD")
    sig = signature()
    started = utc()
    prior, state, chunk_paths, chunks = None, None, [], []
    if a.resume:
        prior = json.loads((ROOT / a.resume).read_text())
        cp = next(o["value"] for o in prior["outputs"] if o["name"] == "checkpoint")
        if cp["signature"] != sig:
            raise SystemExit("checkpoint code, Unicorn, Python or guest settings differ; resume refused")
        private = ROOT / cp["private_path"]
        if checkpoint.digest(private) != cp["private_sha256"]:
            raise SystemExit("private checkpoint digest differs; resume refused")
        for c in cp["chunks"]:
            path = ROOT / c["path"]
            if checkpoint.digest(path) != c["sha256"]:
                raise SystemExit("trace checkpoint chunk digest differs; resume refused")
            chunk_paths.append(path)
        chunks = list(cp["chunks"])
        state = checkpoint.read_private(private)
        original = state["start"]
        a.state = original["state_sha256"]
        a.out = a.out or cp["out"]
        a.runs = a.runs or cp["runs"]
        a.experiment = a.experiment or prior["experiment"]
        if a.compare and a.compare != cp["compare"]:
            ap.error("--compare differs from the checkpoint")
        a.compare = cp["compare"]
    a.out, a.runs, a.experiment = a.out or "traces/T06", a.runs or "runs/T06", a.experiment or "T06"
    out, runs = ROOT / a.out, ROOT / a.runs
    out.mkdir(parents=True, exist_ok=True)
    runs.mkdir(parents=True, exist_ok=True)
    journals = ROOT / ".cache" / "emul-journals"
    number = max(next_number(runs, f"{a.experiment}-r*.json"),
                 next_number(journals, f"{a.experiment}-r*.jsonl"))
    rid = f"{a.experiment}-r{number:04d}"
    journal = checkpoint.Journal(journals / (rid + ".jsonl"), chunk_paths)
    if state is None:
        path, data = find_state(a.state)
        sha = hashlib.sha256(data).hexdigest()
        w = Week(data)
        settings = {**sig["constants"], "dos_clock": w.g.clock}
        start = {"kind": "start", "state_sha256": sha, "state_file": rel(path),
                 "start_at": w.g.where(), "settings": settings, "lcg": LCG,
                 "tools": f"runtime/emul/guest.py, runtime/emul/match.py at {commit}; unicorn {sig['unicorn']}"}
        w.events = journal
        journal.append(start)
    else:
        start = state["start"]
        sha, settings = start["state_sha256"], start["settings"]
        w = checkpoint.restore(state["machine"], Week, journal)
    n = next_number(out, f"{sha[:16]}-week-r*.jsonl")
    trace_path = out / f"{sha[:16]}-week-r{n:04d}.jsonl"
    rec = {"schema": "run/1", "run_id": rid, "experiment": a.experiment, "arm": "unicorn-week", "rep": int(rid[-4:]),
           "code_commit": commit, "machine": cycle.machine_id(),
           "artifact": {"set": "One-Nil96 (records/T01/inventory.json)", "variant": None},
           "runtime": {"harness": f"runtime/emul/match.py@{commit}", "unicorn": sig["unicorn"],
                       "python": platform.python_version(), "settings": settings},
           "interventions": [{"level": "I3", "what": "the guest serves keys, the timer, the mouse and DOS itself (runtime/emul/guest.py); the original's code runs as is"}],
           "start_state": {"id": start["state_file"], "sha256": sha,
                           "restore": "memory, CPU state and text page of the savestate loaded into Unicorn"},
           "seed": None,
           "actions": {"script": "runtime/emul/match.py", "args": [a.state] + (["--compare", a.compare] if a.compare else []),
                       "game_files": {k: hashlib.sha256(v).hexdigest() for k, v in w.files_at_start.items()}},
           "observations": [], "outputs": [], "started": started, "ended": started, "status": "aborted: in progress"}
    if prior:
        rec["actions"]["resumed_from"] = rel(ROOT / a.resume)
    count, due, latest = 0, 0.0, None

    def at_boundary(week):
        nonlocal count, due, latest
        if time.monotonic() < due:
            return
        count += 1
        pid = f"{rid}-p{count:04d}"
        chunk = out / "partial" / f"{trace_path.stem}-p{count:04d}.jsonl"
        info = journal.chunk(chunk)
        chunks.append({"path": rel(chunk), "sha256": info["sha256"]})
        private = ROOT / ".cache" / "checkpoints" / a.experiment / (pid + ".pkl.gz")
        private_sha = checkpoint.write_private(private, {"start": start, "machine": checkpoint.capture(week)})
        cp = {"private_path": rel(private), "private_sha256": private_sha,
              "drive_path": f"checkpoints/{a.experiment}/{private.name}",
              "signature": sig, "chunks": list(chunks), "draws": week.draws,
              "screens": week.screen_i, "run_on_stops": week.run_on,
              "instruction_budget": week.g.budget,
              "out": rel(out), "runs": rel(runs), "compare": a.compare}
        partial = dict(rec, run_id=pid, ended=utc(), status="aborted: partial checkpoint; run may still be active",
                       outputs=[{"name": "checkpoint", "value": cp}])
        receipt = runs / "partial" / (pid + ".json")
        write_record(receipt, partial)
        latest = rel(receipt)
        print(f"{pid}: {week.draws} draws; resume with --resume {latest}", flush=True)
        if a.publish_checkpoints:
            publish_partial(chunk, receipt, private, cp["drive_path"])
        due = time.monotonic() + a.checkpoint_seconds
        if a.stop_after_checkpoints and count >= a.stop_after_checkpoints:
            raise guest.GuestError("requested checkpoint stop")

    status = "completed"
    try:
        w.play(a.max_screens, on_boundary=at_boundary)
    except KeyboardInterrupt:
        status = "stopped: KeyboardInterrupt"
    except Exception as e:  # keep trace/receipt even when publication or a guest hook fails
        status = f"stopped: {type(e).__name__}: {e}"
    if w.g.unsupported and status == "completed":
        status = "completed with unsupported services"
    end = {"kind": "end", "status": status, "draws": w.draws,
           "screens": w.screen_i, "run_on_stops": w.run_on,
           "instruction_budget": w.g.budget, "timer_ticks": w.g.timer_ticks,
           "game_timer_ticks": w.g.game_timer_ticks,
           "result": result(w.board) if w.board else None,
           "services": sorted({f"int {n:02X} ax {ax:04X}" if n == 0x33 else f"int {n:02X} ah {ax >> 8:02X}"
                               for n, ax, _ in w.g.services}),
           "unsupported": [f"int {n:02X} ax {ax:04X} at {at}" for n, ax, at in w.g.unsupported],
           "service_counts": dict(sorted(w.g.service_counts.items())),
           "mouse_answers": dict(sorted(w.g.mouse_answers.items())),
           "dos_calls": w.g.dos_calls,
           "files_written": w.files_written(), "state_digests": w.state_digests()}
    journal.append(end)
    trace_sha = journal.finish(trace_path)
    cmp_ok, cmp_lines = (None, [])
    if a.compare:
        cmp_ok, cmp_lines = compare(journal, sha, a.compare)
        for line in cmp_lines:
            print("  " + line)
    journal.close()
    rec.update(observations=[
        {"step": 0, "source": "file", "field": "the trace written, path", "value": rel(trace_path)},
        {"step": 0, "source": "file", "field": "the trace written, sha256", "value": trace_sha},
        {"step": 1, "source": "log", "field": "comparison with a DOSBox-X week record", "value": "\n".join(cmp_lines) or "not asked"}],
        outputs=[{"name": "end", "value": end}], ended=utc(),
        status=status if cmp_ok in (None, True) else f"aborted: comparison failed ({status})")
    if latest:
        rec["actions"]["last_checkpoint"] = latest
    if rec["status"] != "completed" and not rec["status"].startswith("aborted:"):
        rec["status"] = "aborted: " + rec["status"]
    write_record(runs / (rid + ".json"), rec)
    print(f"{rid}: {rec['status']}; {w.draws} draws, {end['screens']} key waits; result {end['result']}")
    return 0 if rec["status"] == "completed" else 1


if __name__ == "__main__":
    sys.exit(main())
