#!/usr/bin/env python3
"""The draw sites of a week trace (T07): static/1-0-exe/drawsites.tsv, byte for byte.

    python3 tools/static/drawsites.py <trace.jsonl> <out.tsv>

A draw's site is the first return address in its `callers` (runtime/emul/README.md) that lies outside
the library segments 24BC (the generator and its wrappers) and 232A (random(n), 232A:076D): the
instruction after the game code's call that asked for the draw. Rows are sites, sorted by address;
each gives the routine of the listing that holds it, its area (static/1-0-exe/index.tsv), the n values
asked there, and its draws inside the managed match (between the trace's `match entry` and `match
return` marks) and in the rest of the week. A draw whose callers end before leaving the library ("?"
or too short a chain) is counted under the site "unresolved".
"""
import json
import os
import sys
from collections import defaultdict

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
sys.path.insert(0, os.path.join(ROOT, "runtime", "emul"))
import listing  # noqa: E402

LIBRARY = ("24BC", "232A")


def site_of(callers):
    for c in callers:
        if c == "?":
            return "unresolved"
        if c[:4] not in LIBRARY:
            return c
    return "unresolved"


def areas():
    out = {}
    with open(os.path.join(ROOT, "static", "1-0-exe", "index.tsv")) as f:
        for line in f:
            p = line.rstrip("\n").split("\t")
            if len(p) >= 2 and ":" in p[0] and not p[0].startswith(";"):
                out[p[0]] = p[1]
    return out


def table(events):
    """Rows from a trace's events: {site: {"n": set, "match": int, "rest": int}}."""
    rows = defaultdict(lambda: {"n": set(), "match": 0, "rest": 0})
    entry = ret = None
    for e in events:
        if e["kind"] == "mark":
            if e["what"].startswith("match entry"):
                entry = e["draws"]
            elif e["what"].startswith("match return"):
                ret = e["draws"]
    if entry is None or ret is None:
        raise SystemExit("drawsites: the trace has no match entry and return marks")
    for e in events:
        if e["kind"] != "draw":
            continue
        r = rows[site_of(e["callers"])]
        r["n"].add(e["n"])
        r["match" if entry <= e["i"] < ret else "rest"] += 1
    return rows, entry, ret


def main(argv):
    if len(argv) != 3:
        sys.stderr.write(__doc__)
        return 2
    with open(argv[1]) as f:
        events = [json.loads(line) for line in f]
    rows, entry, ret = table(events)
    area = areas()
    trace = os.path.relpath(argv[1], ROOT)
    out = [f"; draw sites of {trace} (tools/static/drawsites.py); the managed match is draws {entry}..{ret - 1}",
           "site\troutine\tarea\tn\tdraws_match\tdraws_rest"]
    for site in sorted(rows):
        r = rows[site]
        if site == "unresolved":
            routine = ar = "-"
        else:
            rt = listing.routine_of(int(site[:4], 16), int(site[5:], 16))
            routine = "%04X:%04X" % rt if rt else "-"
            ar = area.get(routine, "-")
        ns = ",".join(str(n) for n in sorted(r["n"]))
        out.append(f"{site}\t{routine}\t{ar}\t{ns}\t{r['match']}\t{r['rest']}")
    with open(argv[2], "w", newline="\n") as f:
        f.write("\n".join(out) + "\n")
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv))
