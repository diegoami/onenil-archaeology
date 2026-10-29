#!/usr/bin/env python3
"""Routines of 1-0.EXE whose bytes equal a routine of goal2's GOAL.EXE: static/goal2-match.tsv.

    python3 tools/static/goal2_match.py <1-0.EXE> <goal2's GOAL.EXE> <goal2's annotations/routines.tsv> <out.tsv>

goal (New Era Software, 1993) is the studio's earlier game; goal2-archaeology names many of its
routines. A 1-0.EXE routine is matched when its masked bytes (tools/static/delta.py's masking:
relocated segment words, far-call offsets and near-call displacements zeroed) equal those of a
GOAL.EXE routine of the same length, 8 bytes or more. A match carries goal2's name over as a
name only; what the routine does is established here, not there. GOAL.EXE is the owner's file
in goal2-archaeology's .cache (release goal2-original), packed sha256 a6928b0b...
"""
import hashlib
import os
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)

from delta import KNOWN, Routines  # noqa: E402

GOAL_SHA256 = "a6928b0bb7cda0303ac8daf8690efc56ef1792dddaccb5c6f3d85af1f68d3664"


def main(argv):
    if len(argv) != 5:
        sys.stderr.write(__doc__)
        return 2
    with open(argv[1], "rb") as f:
        onil = f.read()
    with open(argv[2], "rb") as f:
        goal = f.read()
    if hashlib.sha256(onil).hexdigest() != KNOWN["96"] or hashlib.sha256(goal).hexdigest() != GOAL_SHA256:
        sys.stderr.write("goal2_match: an input is not the known file\n")
        return 1
    names = {}
    with open(argv[3]) as f:
        for ln in f:
            p = ln.rstrip("\n").split("\t")
            if len(p) > 1 and ":" in p[0]:
                names[p[0]] = p[1]
    o, g = Routines(onil), Routines(goal)
    gby = {}
    for s, lst in g.by_seg.items():
        for a, b, d, _ in lst:
            gby.setdefault(d, []).append(g.addr(a))
    rows = []
    for s, lst in o.by_seg.items():
        for a, b, d, _ in lst:
            if b - a >= 8 and d in gby:
                ga = gby[d]
                rows.append((o.addr(a), b - a, " ".join(ga), " ".join(names.get(x, "-") for x in ga)))
    out = ["; 1-0.EXE routines byte-equal (masked) to a GOAL.EXE routine (tools/static/goal2_match.py)",
           "; 1-0.EXE sha256 %s; GOAL.EXE sha256 %s" % (KNOWN["96"], GOAL_SHA256),
           "routine_96\tsize\tgoal_routine\tgoal2_name"]
    out += ["%s\t%d\t%s\t%s" % r for r in sorted(rows)]
    with open(argv[4], "w", newline="\n") as f:
        f.write("\n".join(out) + "\n")
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv))
