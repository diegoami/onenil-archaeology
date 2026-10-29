#!/usr/bin/env python3
"""Play one week of One-Nil 96 as guest code under Unicorn from a savestate, and trace its draws (T06).

    python3 runtime/emul/match.py --state <sha256> --out traces/T06/ [--max-screens 60]

The start state is a savestate the T04 or T05 records name by sha256, found in .cache/states/. From its
main menu the run does what runtime/driver/weeks.py does in DOSBox-X, closed-loop on the guest's own text
page: select PLAY NEXT GAME, PLAY GAME on the pre-match screen, Space at a key wait on a match board or a
"press any key" / "hit any key" / "any other key to continue" screen, Return through a PLAYER CONTRACT
screen, N at a (Y/N) question, until the main menu is back. Keys go in through the game's own keyboard
handler (runtime/emul/guest.py).

The trace (one JSON object per line, written to <out>/<state sha256[:16]>-week.jsonl; the format is
runtime/emul/README.md's):
  {"kind": "start", ...}                       the state, the tools, the clock given to DOS
  {"kind": "draw", "i", "n", "seed_before", "seed_after", "value", "callers"}
                                               every call of the generator 24BC:0CDC, in order
  {"kind": "screen", "i", "digest", "draws", "action"}
                                               every key wait: the text page's sha256 (chars and
                                               attributes, as runtime/driver/savestate.Screen.digest),
                                               the draws so far, and the keys answered
  {"kind": "end", "status", "draws", "screens", "steps", "timer_ticks", "result", "services"}
                                               result: the teams and goals of the full-time board and
                                               its digest
The trace holds numbers, addresses, digests and the board's score line, no memory bytes.
"""
import argparse
import hashlib
import json
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / "runtime" / "emul"))
sys.path.insert(0, str(ROOT / "runtime" / "driver"))
import guest  # noqa: E402
import screens  # noqa: E402

LCG = "24BC:0CDC"        # F02 item 4: s := s*0x7ABD + 0x1B0F; returns ((s*n) >> 16) + 1
LCG_LEAVE = "24BC:0CFD"  # its `leave`: AX holds the value, the seed is written
GAME_DIR = ROOT / ".cache" / "One-Nil96"


def find_state(sha):
    for p in sorted((ROOT / ".cache" / "states").rglob("*.sav")):
        data = p.read_bytes()
        if hashlib.sha256(data).hexdigest().startswith(sha):
            return p, data
    raise SystemExit(f"no savestate with sha256 {sha}... under .cache/states (python3 tools/artifacts.py pull)")


class Week:
    def __init__(self, data):
        files = {p.name.upper(): p.read_bytes() for p in GAME_DIR.iterdir() if p.is_file()}
        self.g = guest.Guest(data, files=files)
        self.events = []
        self.draws = 0
        self._pending = None
        self.started = False      # PLAY NEXT GAME chosen
        self.g.code_hook(LCG, self._lcg_entry)
        self.g.code_hook(LCG_LEAVE, self._lcg_leave)

    def _callers(self):
        """The return addresses up the BP chain from 24BC:0CDC's entry: its caller's frame first."""
        g = self.g
        out, bp = [], g.reg("bp")
        ret_ip, ret_cs = g.stack_word(0), g.stack_word(2)
        out.append(g.image_address(ret_cs, ret_ip))
        ss = g.reg("ss")
        for _ in range(3):  # wrapper, its caller, one more
            if not bp:
                break
            ip, cs, nbp = g.word_at(ss * 16 + bp + 2), g.word_at(ss * 16 + bp + 4), g.word_at(ss * 16 + bp)
            out.append(g.image_address(cs, ip))
            if nbp <= bp:
                break
            bp = nbp
        return out

    def _lcg_entry(self, g):
        n = g.stack_word(4)
        ptr = g.stack_word(8) * 16 + g.stack_word(6)
        self._pending = {"kind": "draw", "i": self.draws, "n": n, "seed_before": g.word_at(ptr),
                         "callers": self._callers(), "_ptr": ptr}

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
                keys = self._select(hi, "PLAY NEXT GAME", "main menu")
                self.started = keys == ["Return"]
            elif "commentary" in text and ("versus" in text or "spacebar-commentary" in text):
                keys = ["space"]
            elif "PLAY GAME" in text and "Change tactics" in text:
                keys = self._select(hi, "PLAY GAME", "pre-match")
            elif "press any key" in low or "hit any key" in low or "any other key to continue" in low:
                keys = ["space"]
            elif "PLAYER CONTRACT" in text:
                keys = ["Return"]
            elif "(y/n)" in low:
                keys = ["n"]
            else:
                ev["action"] = "unknown screen: stop"
                ev["text"] = text
                self.events.append(ev)
                raise guest.GuestError(f"unknown screen at key wait {i}")
            ev["action"] = " ".join(keys)
            self.events.append(ev)
            g.press(*keys)
        raise guest.GuestError(f"no main menu after {max_screens} key waits")

    def _select(self, highlighted, label, where):
        if any(t.startswith(label) for t in highlighted):
            return ["Return"]
        return ["Down"]   # one step; the next key wait reads the highlight again


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


def compare(trace_events, record_path):
    """Which key-wait screens of the trace are screens of a T04 week record (by digest)."""
    rec = json.loads(Path(record_path).read_text())
    dos = {o["value"]: o["field"].split(":")[0] for o in rec["observations"] if "chars+attributes" in o["field"]}
    rows = [(e["i"], e["digest"], dos.get(e["digest"])) for e in trace_events if e["kind"] == "screen"]
    return rows, len(dos)


def main(argv=None):
    ap = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    ap.add_argument("--state", required=True, help="sha256 (or a prefix) of the start savestate")
    ap.add_argument("--out", default="traces/T06")
    ap.add_argument("--max-screens", type=int, default=60)
    ap.add_argument("--compare", help="a T04 week record: print which key-wait screens are its screens")
    a = ap.parse_args(argv)
    path, data = find_state(a.state)
    sha = hashlib.sha256(data).hexdigest()
    w = Week(data)
    w.board = None
    start = {"kind": "start", "state_sha256": sha, "state_file": path.relative_to(ROOT).as_posix(),
             "start_at": w.g.where(), "dos_clock": w.g.clock, "tools": "runtime/emul/guest.py, runtime/emul/match.py; unicorn "
             + __import__("unicorn").__version__, "lcg": LCG}
    status = "completed"
    try:
        w.play(a.max_screens)
    except guest.GuestError as e:
        status = f"stopped: {e}"
    end = {"kind": "end", "status": status, "draws": w.draws,
           "screens": sum(e["kind"] == "screen" for e in w.events), "steps": w.g.steps,
           "result": result(w.board) if w.board else None,
           "timer_ticks": w.g.timer_ticks,
           "services": sorted({f"int {n:02X} ah {ah:02X}" for n, ah, _ in w.g.services})}
    out = ROOT / a.out
    out.mkdir(parents=True, exist_ok=True)
    path_out = out / f"{sha[:16]}-week.jsonl"
    with open(path_out, "w", newline="\n") as f:
        for ev in [start] + w.events + [end]:
            f.write(json.dumps(ev, ensure_ascii=False, sort_keys=True) + "\n")
    print(f"{path_out.relative_to(ROOT)}: {status}; {w.draws} draws, {end['screens']} key waits; result {end['result']}")
    if a.compare:
        rows, n = compare(w.events, a.compare)
        for i, d, where in rows:
            print(f"  key wait {i:2d} {d[:16]} {('= ' + where) if where else '(not a screen of the record)'}")
        print(f"  {sum(1 for r in rows if r[2])} of the record's {n} screens met")
    return 0 if status == "completed" else 1


if __name__ == "__main__":
    sys.exit(main())
