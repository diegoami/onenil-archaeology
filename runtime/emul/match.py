#!/usr/bin/env python3
"""Play one week of One-Nil 96 as guest code under Unicorn from a savestate, and trace its draws (T06).

    python3 runtime/emul/match.py --state <sha256> [--out traces/T06] [--runs runs/T06]
                                  [--compare runs/T04/<week record>.json] [--max-screens 60]
                                  [--experiment T06]

The start state is a savestate the T04 or T05 records name by sha256, found in .cache/states/. From its
main menu the run does what runtime/driver/weeks.py does in DOSBox-X, closed-loop on the guest's own text
page: select PLAY NEXT GAME, PLAY GAME on the pre-match screen, Space at a key wait on a match board or a
"press any key" / "hit any key" / "any other key to continue" screen, Return through a PLAYER CONTRACT
screen, N at a (Y/N) question, until the main menu is back. Keys go in through the game's own keyboard
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
import platform
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / "runtime" / "emul"))
sys.path.insert(0, str(ROOT / "runtime" / "driver"))
sys.path.insert(0, str(ROOT / "tools" / "data"))
import cycle  # noqa: E402
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

    def play(self, max_screens=60, step_budget=400_000_000):
        g = self.g
        for i in range(max_screens):
            if not g.run(max_steps=step_budget):
                raise guest.GuestError(f"no key wait within {step_budget} instructions (at {g.where()})")
            sc = g.screen()
            text, low = sc.text(), sc.text().lower()
            ev = {"kind": "screen", "i": i, "digest": sc.digest(), "draws": self.draws}
            hi = [t for _, t in screens.highlighted(sc)]
            if "FULL TIME" in text and "press any key" in low:
                self.board = (text, sc.digest())   # the full-time board: the week's result
            if "GAME NAME" in text and "PLAY NEXT GAME" in text:
                if self.started:
                    ev["action"] = "main menu after the week: stop"
                    self.events.append(ev)
                    return sc
                keys = ["Return"] if any(t.startswith("PLAY NEXT GAME") for t in hi) else ["Down"]
                self.started = keys == ["Return"]
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
                raise guest.GuestError(f"unknown screen at key wait {i}")
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
    return 1 + max((int(p.stem.split("-r")[-1]) for p in Path(directory).glob(pattern)), default=0)


def main(argv=None):
    ap = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    ap.add_argument("--state", required=True, help="sha256 (or a prefix) of the start savestate")
    ap.add_argument("--out", default="traces/T06")
    ap.add_argument("--runs", default="runs/T06")
    ap.add_argument("--max-screens", type=int, default=60)
    ap.add_argument("--compare", help="a T04 week record from the same start state")
    ap.add_argument("--experiment", default="T06", help="the run records' experiment and id prefix (T08: runtime/emul/corpus.py)")
    a = ap.parse_args(argv)
    dirty = git("status", "--porcelain", "--", "runtime/emul")
    if dirty:
        raise SystemExit("uncommitted changes under runtime/emul/: commit them first so the record names the code that ran\n" + dirty)
    commit = git("rev-parse", "--short", "HEAD")
    from datetime import datetime, timezone

    def utc():
        return datetime.now(timezone.utc).strftime("%Y-%m-%dT%H:%M:%SZ")
    started = utc()
    path, data = find_state(a.state)
    sha = hashlib.sha256(data).hexdigest()
    w = Week(data)
    import unicorn
    settings = {"INSTR_PER_S": guest.INSTR_PER_S, "PIT_HZ": guest.PIT_HZ, "KEY_HOLD": guest.KEY_HOLD,
                "STALL_POLLS": guest.STALL_POLLS, "OTHER_STALL_POLLS": guest.OTHER_STALL_POLLS,
                "IF_RETRY": guest.IF_RETRY, "dos_clock": w.g.clock}
    start = {"kind": "start", "state_sha256": sha, "state_file": path.relative_to(ROOT).as_posix(),
             "start_at": w.g.where(), "settings": settings, "lcg": LCG,
             "tools": f"runtime/emul/guest.py, runtime/emul/match.py at {commit}; unicorn {unicorn.__version__}"}
    status = "completed"
    try:
        w.play(a.max_screens)
    except guest.GuestError as e:
        status = f"stopped: {e}"
    if w.g.unsupported and status == "completed":
        status = "completed with unsupported services"
    end = {"kind": "end", "status": status, "draws": w.draws,
           "screens": sum(e["kind"] == "screen" for e in w.events),
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
    out = ROOT / a.out
    out.mkdir(parents=True, exist_ok=True)
    n = next_number(out, f"{sha[:16]}-week-r*.jsonl")
    trace_path = out / f"{sha[:16]}-week-r{n:04d}.jsonl"
    text = "".join(json.dumps(ev, ensure_ascii=False, sort_keys=True) + "\n" for ev in [start] + w.events + [end])
    with open(trace_path, "x", newline="\n") as f:
        f.write(text)
    trace_sha = hashlib.sha256(text.encode()).hexdigest()
    print(f"{trace_path.relative_to(ROOT)}: {status}; {w.draws} draws, {end['screens']} key waits; result {end['result']}")
    cmp_ok, cmp_lines = (None, [])
    if a.compare:
        cmp_ok, cmp_lines = compare(w.events, sha, a.compare)
        for line in cmp_lines:
            print("  " + line)
    runs = ROOT / a.runs
    runs.mkdir(parents=True, exist_ok=True)
    rid = f"{a.experiment}-r{next_number(runs, f'{a.experiment}-r*.json'):04d}"
    rec = {"schema": "run/1", "run_id": rid, "experiment": a.experiment, "arm": "unicorn-week", "rep": int(rid[-4:]),
           "code_commit": commit, "machine": cycle.machine_id(),
           "artifact": {"set": "One-Nil96 (records/T01/inventory.json)", "variant": None},
           "runtime": {"harness": f"runtime/emul/match.py@{commit}", "unicorn": unicorn.__version__,
                       "python": platform.python_version(), "settings": settings},
           "interventions": [{"level": "I3", "what": "the guest serves keys, the timer, the mouse and DOS itself (runtime/emul/guest.py); the original's code runs as is"}],
           "start_state": {"id": path.relative_to(ROOT).as_posix(), "sha256": sha,
                           "restore": "memory, CPU state and text page of the savestate loaded into Unicorn"},
           "seed": None,
           "actions": {"script": "runtime/emul/match.py", "args": [a.state] + (["--compare", a.compare] if a.compare else []),
                       "game_files": {k: hashlib.sha256(v).hexdigest() for k, v in w.files_at_start.items()}},
           "observations": [
               {"step": 0, "source": "file", "field": "the trace written, path", "value": trace_path.relative_to(ROOT).as_posix()},
               {"step": 0, "source": "file", "field": "the trace written, sha256", "value": trace_sha},
               {"step": 1, "source": "log", "field": "comparison with a DOSBox-X week record", "value": "\n".join(cmp_lines) or "not asked"},
           ],
           "outputs": [{"name": "end", "value": end}],
           "started": "", "ended": "", "status": status if cmp_ok in (None, True) else f"aborted: comparison failed ({status})"}
    rec["started"], rec["ended"] = started, utc()
    if not (rec["status"] == "completed" or rec["status"].startswith("aborted:")):
        rec["status"] = "aborted: " + rec["status"]
    with open(runs / f"{rid}.json", "x", encoding="utf-8") as f:
        f.write(json.dumps(rec, indent=2, ensure_ascii=False) + "\n")
    print(f"{rid}: {rec['status']}")
    return 0 if rec["status"] == "completed" else 1


if __name__ == "__main__":
    sys.exit(main())
