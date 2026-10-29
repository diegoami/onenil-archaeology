#!/usr/bin/env python3
"""The area index: static/1-0-exe/index.tsv and static/1-095-exe/index.tsv, byte for byte.

    python3 tools/static/index.py      (after listing.py and delta.py; reads only static/)

For 1-0.EXE (96), every routine of static/1-0-exe/routines.tsv gets an area:
  anchor     a `routine` row of static/areas.tsv (hand-curated, with its evidence)
  segment    a `segment` row of static/areas.tsv: the run-time and library segments
  callers    every caller of the routine (static/1-0-exe/calls.tsv) has an area, and all the same;
             applied until nothing changes, so a routine reached only from match code is match
  roots      after that: walking up the callers of a routine still without an area (through call
             cycles, which stop the rule above), the nearest routines with an area all have the
             same one, and no path ends in a routine nobody calls
  unknown    none of these
For 1-095.EXE (95), a routine paired with a 96 routine in static/delta-95-96.tsv takes that
routine's area (basis `96 pair: <address> <status>`); an unpaired one is `unknown`.
The `callers` and `roots` bases are inferred: a routine called only from match code can still be
shared code.
"""
import os
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
STATIC = os.path.join(ROOT, "static")
AREAS = ["program", "runtime", "library", "match", "tactics", "squad", "transfers", "staff",
         "finance", "competitions", "season", "career", "save-load", "unknown"]


def rows(path):
    with open(path) as f:
        lines = [ln.rstrip("\n") for ln in f if ln.strip() and not ln.startswith(";")]
    head = lines[0].split("\t")
    return [dict(zip(head, ln.split("\t"))) for ln in lines[1:]]


def routines(exe):
    return [r["segment:offset"] for r in rows(os.path.join(STATIC, exe, "routines.tsv"))]


def callers_of(exe):
    out = {}
    for r in rows(os.path.join(STATIC, exe, "calls.tsv")):
        out.setdefault(r["callee"], set()).add(r["caller"])
    return out


def anchors():
    seg, rout = {}, {}
    for r in rows(os.path.join(STATIC, "areas.tsv")):
        if r["area"] not in AREAS:
            raise SystemExit("index: unknown area %r in static/areas.tsv" % r["area"])
        (seg if r["scope"] == "segment" else rout)[r["address"]] = r["area"]
    return seg, rout


def index_96():
    names = routines("1-0-exe")
    seg, rout = anchors()
    missing = sorted(set(rout) - set(names))
    if missing:
        raise SystemExit("index: anchors that are no routine of 1-0.EXE: %s" % " ".join(missing))
    area, basis = {}, {}
    for a in names:
        if a in rout:
            area[a], basis[a] = rout[a], "anchor"
        elif a.split(":")[0] in seg:
            area[a], basis[a] = seg[a.split(":")[0]], "segment"
    callers = callers_of("1-0-exe")
    changed = True
    while changed:
        changed = False
        for a in names:
            if a in area:
                continue
            cs = callers.get(a, set()) - {a}
            if cs and all(c in area for c in cs) and len({area[c] for c in cs}) == 1:
                area[a] = area[next(iter(cs))]
                basis[a] = "callers: " + " ".join(sorted(cs)[:4]) + (" ..." if len(cs) > 4 else "")
                changed = True
    found = {}
    for a in names:
        if a in area:
            continue
        roots, seen, work, open_end = set(), {a}, [a], False
        while work:
            x = work.pop()
            cs = callers.get(x, set()) - {x}
            if not cs:
                open_end = True
                break
            for c in cs:
                if c in area:
                    roots.add(c)
                elif c not in seen:
                    seen.add(c)
                    work.append(c)
        if not open_end and roots and len({area[r] for r in roots}) == 1:
            found[a] = (area[next(iter(roots))], "roots: " + " ".join(sorted(roots)[:4]) + (" ..." if len(roots) > 4 else ""))
    for a, (ar, b) in found.items():
        area[a], basis[a] = ar, b
    return [(a, area.get(a, "unknown"), basis.get(a, "unknown")) for a in names]


def index_95(idx96):
    by96 = {a: (ar, b) for a, ar, b in idx96}
    pair = {}
    for r in rows(os.path.join(STATIC, "delta-95-96.tsv")):
        if r["routine_95"] and r["routine_96"]:
            pair[r["routine_95"]] = (r["routine_96"], r["status"])
    out = []
    for a in routines("1-095-exe"):
        if a in pair:
            a96, status = pair[a]
            out.append((a, by96[a96][0], "96 pair: %s %s" % (a96, status)))
        else:
            out.append((a, "unknown", "unknown"))
    return out


def write(exe, idx):
    counts = {}
    for _, ar, _ in idx:
        counts[ar] = counts.get(ar, 0) + 1
    lines = ["; the area of every routine (tools/static/index.py; method in its docstring); anchors in static/areas.tsv",
             "; counts: " + ", ".join("%s %d" % (k, counts[k]) for k in AREAS if k in counts),
             "routine\tarea\tbasis"]
    lines += ["%s\t%s\t%s" % r for r in idx]
    with open(os.path.join(STATIC, exe, "index.tsv"), "w", newline="\n") as f:
        f.write("\n".join(lines) + "\n")


def main():
    i96 = index_96()
    write("1-0-exe", i96)
    write("1-095-exe", index_95(i96))
    return 0


if __name__ == "__main__":
    sys.exit(main())
