"""What the committed listing of 1-0.EXE says about a routine (static/1-0-exe/code/*.asm): where it
starts and ends, how it returns, and whether it sets up a BP frame. Used to walk the BP chain of a
running guest (match.py's callers) without guessing a frame's form."""
import re
from bisect import bisect_right
from functools import lru_cache
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
CODE = ROOT / "static" / "1-0-exe" / "code"
HEAD = re.compile(r"^; ---- routine ([0-9A-F]{4}):([0-9A-F]{4}) ")
INS = re.compile(r"^([0-9A-F]{4})  ([0-9A-F ]+?)\s{2,}(\S.*)$")


@lru_cache(maxsize=1)
def routines():
    """{(seg, off): {"returns": {"near"|"far"|"iret"}, "frame": bool}} for every routine of the listing."""
    out = {}
    for path in sorted(CODE.glob("seg_*.asm")):
        cur = None
        for line in path.read_text().splitlines():
            m = HEAD.match(line)
            if m:
                cur = (int(m.group(1), 16), int(m.group(2), 16))
                out[cur] = {"returns": set(), "frame": None}
                continue
            if cur is None:
                continue
            m = INS.match(line)
            if not m:
                continue
            text = m.group(3).split(";")[0].strip()
            r = out[cur]
            if r["frame"] is None:   # the routine's first instruction
                r["frame"] = text.startswith("enter ") or text == "push bp"
            word = text.split()[0]
            if word in ("ret", "retf", "iret"):
                r["returns"].add({"ret": "near", "retf": "far", "iret": "iret"}[word])
    return out


@lru_cache(maxsize=1)
def _starts():
    by = {}
    for seg, off in routines():
        by.setdefault(seg, []).append(off)
    return {s: sorted(v) for s, v in by.items()}


def routine_of(seg, off):
    """The (seg, off) of the routine of the listing that holds image address seg:off, or None."""
    offs = _starts().get(seg)
    if not offs:
        return None
    k = bisect_right(offs, off) - 1
    return (seg, offs[k]) if k >= 0 else None


def frame_form(seg, off):
    """How the routine holding seg:off returns, when it has a BP frame and one return form:
    "near" or "far"; None when the listing cannot say (no routine, no frame, several forms)."""
    r = routine_of(seg, off)
    if r is None:
        return None
    info = routines()[r]
    if not info["frame"] or len(info["returns"]) != 1:
        return None
    form = next(iter(info["returns"]))
    return form if form in ("near", "far") else None
