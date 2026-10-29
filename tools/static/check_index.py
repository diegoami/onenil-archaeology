#!/usr/bin/env python3
"""T02 Done-when 2: every routine of both executables is in its index exactly once, with an area of
the vocabulary (unknown included), and every anchor of static/areas.tsv is a routine of 1-0.EXE.
Reads only static/, so it runs in CI. Exit 0 when it all holds."""
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import index  # noqa: E402


def main():
    bad = 0
    for exe in ("1-0-exe", "1-095-exe"):
        names = index.routines(exe)
        idx = index.rows(os.path.join(index.STATIC, exe, "index.tsv"))
        got = [r["routine"] for r in idx]
        if sorted(got) != sorted(names) or len(set(got)) != len(got):
            print("%s: index.tsv and routines.tsv list different routines (%d vs %d)" % (exe, len(got), len(names)))
            bad += 1
        for r in idx:
            if r["area"] not in index.AREAS:
                print("%s: %s has area %r" % (exe, r["routine"], r["area"]))
                bad += 1
        known = sum(r["area"] != "unknown" for r in idx)
        print("%s: %d routines, %d with an area, %d unknown" % (exe, len(idx), known, len(idx) - known))
    _, rout = index.anchors()
    missing = set(rout) - set(index.routines("1-0-exe"))
    for a in sorted(missing):
        print("anchor %s is no routine of 1-0.EXE" % a)
        bad += 1
    print("index check: %s" % ("FAIL" if bad else "ok"))
    return 1 if bad else 0


if __name__ == "__main__":
    sys.exit(main())
