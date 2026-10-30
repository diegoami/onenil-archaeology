#!/usr/bin/env python3
"""The match's ratings (T09, F09): the four values 0AB9:D983 contests, as 1-0.EXE computes them, read
in the harness and checked against the formula read in the listing (static/1-0-exe/ratings.md).

    python3 tools/static/ratings.py --run <T04 week record> [<T04 week record> ...] [--runs runs/T09]
    python3 tools/static/ratings.py --check runs/T09

`--run` plays each week in the harness (runtime/emul/match.py's Week) from the start state the T04
record names, and records, during the managed match (between 0AB9:E1F2's entry and its return):
  - every call of 1B55:4B4A (a player's value): its mode and player, the fields it reads (byte +4,
    +6, +7 of the player's 8-byte record at [DS:D7BA], signed bytes +6, +8 of his 15-byte record at
    [DS:D7BE]), what its callees 1B55:4F89 and 1B55:4F05 returned, and what it returned;
  - every call of 1B55:4A37 (a club's bonus): the club, its words +0x28 and +0x2A, the bytes +2 of the
    4-byte records [DS:DCC8] they index, and what it returned;
  - every call of 1B55:50EB (a side's four values): flag, side, club, the club's byte +0x37, the
    players it valued in order, and the side's four words DS:D674 + 4k + 2*side at its return;
  - every entry of 0AB9:D983: the eight words DS:D674..D683.
One run record runs/T09/T09-r<nnnn>.json per week, values only (no memory bytes). `--check` recomputes
each value from its recorded inputs with the formulas below and exits 0 when all agree.
"""
import argparse
import hashlib
import json
import platform
import sys
from datetime import datetime, timezone
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / "runtime" / "emul"))
sys.path.insert(0, str(ROOT / "runtime" / "driver"))

POSITION_CLASS = [0, 1, 1, 4, 4, 2, 2, 2, 2, 5, 5, 5, 3, 3]   # DS:12BE (static/1-0-exe/data)
HOME_DIVISOR = [16, 64]                                         # DS:12CC, by club byte +0x37 == 0
DROP_DIVISOR = [8, 16]                                          # DS:1286, by player byte +7 == 0
VALUES = 0xD674                                                 # D674 + 4k + 2*side, k = 0..3


def s8(b):
    return b - 256 if b > 127 else b


def player_value(c):
    """1B55:4B4A (4B4A-4C2A), from a recorded call's inputs."""
    if c["unavailable"]:                       # 4F89 returned non-zero (4B77-4B80)
        return 0
    v = c["p8_4"] - 62 + c["p15_8"]            # 4B83-4B9B
    if c["p15_6"] < 32:                        # 4BA1, signed
        v += c["p15_6"]
    elif c["mode"] != 0 and c["p8_7"] == 0:    # 4BB2-4BDD: v -= v / DS:1286[p8_7 == 0], idiv
        d = DROP_DIVISOR[1]
        q = abs(v) // d * (1 if v >= 0 else -1)
        v -= q
    elif c["p8_7"] == 0:                       # 4BE2-4BEC
        v += 16
    v = max(0, min(v, 0x100))                  # 4BF0-4C04
    if c["halved"]:                            # 4F05 returned non-zero
        v = v // 2 if v >= 0 else -((-v) // 2)
    return v


def club_bonus(c):
    """1B55:4A37 (4A37-4A8C), the byte it returns."""
    return ((c["staff_a"] >> 5) + 16 + (c["staff_b"] >> 4)) & 0xFF


def side_values(c):
    """1B55:50EB, the side's four words from the recorded player values and bonus."""
    v = [0, 0, 0, 0]
    for p in c["players"]:
        x = p["value"]
        if x != 0:
            x = (x + c["bonus"]) & 0xFFFF
        cls = POSITION_CLASS[p["position"]]
        if cls < 4:
            v[cls] = (v[cls] + x) & 0xFFFF
        else:
            v[cls - 3] = (v[cls - 3] + (x >> 1)) & 0xFFFF
            v[cls - 2] = (v[cls - 2] + (x >> 1)) & 0xFFFF
    if c["flag"]:
        d = HOME_DIVISOR[1 if c["club_37"] == 0 else 0]
        v = [(w + w // d) & 0xFFFF for w in v]
    return v


class Recorder:
    def __init__(self, week):
        self.w = week
        g = week.g
        self.in_match = False
        self.players, self.bonuses, self.sides, self.contests = [], [], [], []
        self._p, self._side = None, None
        g.code_hook("0AB9:E1F2", lambda g: setattr(self, "in_match", True))
        g.code_hook("0AB9:EBE2", lambda g: setattr(self, "in_match", False))
        g.code_hook("1B55:4B4A", self._p_entry)
        g.code_hook("1B55:4C2A", self._p_return)
        g.code_hook("1B55:5008", lambda g: self._pred("unavailable"))
        g.code_hook("1B55:4F86", lambda g: self._pred("halved"))
        g.code_hook("1B55:4A37", self._b_entry)
        g.code_hook("1B55:4A8C", self._b_return)
        g.code_hook("1B55:50EB", self._s_entry)
        g.code_hook("1B55:5281", self._s_return)
        g.code_hook("0AB9:D983", self._contest)

    def _p_entry(self, g):
        if not self.in_match:
            return
        mode, player = g.stack_word(4) & 0xFF, g.stack_word(6)
        r8 = g.far(0xD7BA) + player * 8
        r15 = g.far(0xD7BE) + player * 15
        b8, b15 = g.mem(r8, 8), g.mem(r15, 15)
        self._p = {"mode": mode, "player": player, "p8_4": b8[4], "position": b8[6], "p8_7": b8[7],
                   "p15_6": s8(b15[6]), "p15_8": s8(b15[8]), "unavailable": None, "halved": None}

    def _pred(self, name):
        if self._p is not None and self._p[name] is None:
            self._p[name] = self.w.g.reg("ax") & 0xFF

    def _p_return(self, g):
        if self._p is None:
            return
        p = self._p
        p["halved"] = p["halved"] or 0
        p["value"] = g.reg("ax")
        self.players.append(p)
        if self._side is not None:
            self._side["players"].append({"player": p["player"], "position": p["position"], "value": p["value"]})
        self._p = None

    def _b_entry(self, g):
        if not self.in_match:
            return
        club = g.stack_word(4)
        base = g.far(0xD7C2) + (club - 1) * 0x3E
        wa, wb = g.word_at(base + 0x28), g.word_at(base + 0x2A)
        staff = g.far(0xDCC8)
        self._b = {"club": club, "word_28": wa, "word_2A": wb,
                   "staff_a": g.mem(staff + wa * 4 + 2, 1)[0], "staff_b": g.mem(staff + wb * 4 + 2, 1)[0]}

    def _b_return(self, g):
        if not self.in_match or getattr(self, "_b", None) is None:
            return
        self._b["bonus"] = g.reg("ax") & 0xFF
        self.bonuses.append(self._b)
        if self._side is not None:
            self._side["bonus"] = self._b["bonus"]
        self._b = None

    def _s_entry(self, g):
        if not self.in_match:
            return
        # 50EB(club, side, flag) in push order: the club at [bp+0Ah], the side at [bp+8], the flag byte
        # at [bp+6] (50EF, 5117, 522A); at the entry, before its ENTER: flag sp+4, side sp+6, club sp+8
        flag, side, club = g.stack_word(4) & 0xFF, g.stack_word(6), g.stack_word(8)
        base = g.far(0xD7C2) + (club - 1) * 0x3E
        self._side = {"flag": flag, "side": side, "club": club, "club_37": g.mem(base + 0x37, 1)[0],
                      "players": [], "bonus": None}

    def _s_return(self, g):
        if self._side is None:
            return
        s = self._side
        s["values"] = [g.rd(VALUES + 4 * k + 2 * s["side"]) for k in range(4)]
        self.sides.append(s)
        self._side = None

    def _contest(self, g):
        if self.in_match:
            self.contests.append({"after_sides": len(self.sides), "values": [g.rd(VALUES + 2 * i) for i in range(8)]})


def git(*a):
    import subprocess
    return subprocess.run(["git", "-C", str(ROOT), *a], capture_output=True, text=True).stdout.strip()


def run(records, runs_dir):
    import match  # noqa: E402
    import cycle  # noqa: E402
    if git("status", "--porcelain", "--", "tools/static/ratings.py", "runtime/emul"):
        raise SystemExit("commit tools/static/ratings.py and runtime/emul first")
    commit = git("rev-parse", "--short", "HEAD")
    out = ROOT / runs_dir
    out.mkdir(parents=True, exist_ok=True)
    for rec_path in records:
        t04 = json.loads(Path(rec_path).read_text())
        sha = t04["start_state"]["sha256"]
        started = datetime.now(timezone.utc).strftime("%Y-%m-%dT%H:%M:%SZ")
        path, data = match.find_state(sha)
        w = match.Week(data)
        rcd = Recorder(w)
        status = "completed"
        try:
            w.play()
        except Exception as e:  # noqa: BLE001
            status = f"aborted: {type(e).__name__}: {e}"[:300]
        n = match.next_number(out, "T09-r*.json")
        rid = f"T09-r{n:04d}"
        rec = {"schema": "run/1", "run_id": rid, "experiment": "T09", "arm": "ratings", "rep": n,
               "code_commit": commit, "machine": cycle.machine_id(),
               "artifact": {"set": "One-Nil96 (records/T01/inventory.json)", "variant": None},
               "runtime": {"harness": f"runtime/emul/match.py@{commit}", "python": platform.python_version()},
               "interventions": [{"level": "I3", "what": "runtime/emul/guest.py's stand-ins; code hooks that read registers and memory only"}],
               "start_state": {"id": path.relative_to(ROOT).as_posix(), "sha256": sha,
                               "restore": "the savestate loaded into Unicorn (runtime/emul/guest.py)"},
               "seed": None,
               "actions": {"script": "tools/static/ratings.py", "week_record": str(Path(rec_path).as_posix())},
               "observations": [{"step": 0, "source": "log", "field": "the managed match's result",
                                 "value": json.dumps(match.result(w.board) if w.board else None)}],
               "outputs": [{"name": "players", "value": rcd.players}, {"name": "bonuses", "value": rcd.bonuses},
                           {"name": "sides", "value": rcd.sides}, {"name": "contests", "value": rcd.contests}],
               "started": started, "ended": datetime.now(timezone.utc).strftime("%Y-%m-%dT%H:%M:%SZ"),
               "status": status}
        with open(out / f"{rid}.json", "x") as f:
            f.write(json.dumps(rec, indent=1) + "\n")
        print(f"{rid}: {status}; {len(rcd.players)} player values, {len(rcd.sides)} sides, {len(rcd.contests)} D983 entries")


def check(runs_dir):
    bad = total_records = total_values = 0
    files = sorted((ROOT / runs_dir).glob("T09-r*.json"))
    for f in files:
        rec = json.loads(f.read_text())
        out = {o["name"]: o["value"] for o in rec["outputs"]}
        errs = []
        for p in out["players"]:
            if player_value(p) != p["value"]:
                errs.append(f"player {p['player']}: formula {player_value(p)}, original {p['value']}")
        for b in out["bonuses"]:
            if club_bonus(b) != b["bonus"]:
                errs.append(f"club {b['club']}: bonus formula {club_bonus(b)}, original {b['bonus']}")
        for s in out["sides"]:
            if side_values(s) != s["values"]:
                errs.append(f"side {s['side']} club {s['club']}: formula {side_values(s)}, original {s['values']}")
        for c in out["contests"]:
            # D983's eight words, k-major [k][side], against the latest 50EB values of each side before it
            last = {}
            for s in out["sides"][:c["after_sides"]]:
                last[s["side"]] = s["values"]
            want = [last.get(side, [None] * 4)[k] for k in range(4) for side in (0, 1)]
            if c["values"] != want:
                errs.append(f"D983 entry after {c['after_sides']} sides: {c['values']}, the 50EB values {want}")
        n = len(out["players"]) + len(out["bonuses"]) + len(out["sides"]) + len(out["contests"])
        values = (len(out["players"]) + len(out["bonuses"])
                  + sum(len(s["values"]) for s in out["sides"])
                  + sum(len(c["values"]) for c in out["contests"]))
        total_records += n
        total_values += values
        bad += len(errs)
        print(f"{f.name}: {n} call records / {values} scalar values checked, {len(errs)} differing records"
              + "".join("\n  " + e for e in errs[:10]))
    print(f"ratings check: {'ok' if files and not bad else 'FAIL'} ({total_records} call records, "
          f"{total_values} scalar values, {bad} differing records, {len(files)} run records)")
    return 0 if files and not bad else 1


def main(argv=None):
    ap = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    ap.add_argument("--run", nargs="+")
    ap.add_argument("--runs", default="runs/T09")
    ap.add_argument("--check")
    a = ap.parse_args(argv)
    if a.check:
        return check(a.check)
    if a.run:
        run(a.run, a.runs)
        return 0
    ap.print_help()
    return 2


if __name__ == "__main__":
    sys.exit(main())
