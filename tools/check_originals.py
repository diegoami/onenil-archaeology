#!/usr/bin/env python3
"""[designed: owner, 2026-10-29] No byte of the original game is tracked: refuse any tracked file
with one of its file types (CLAUDE.md, docs/artifacts.md). Exit 0 when clean, 1 otherwise.

[incident 2026-11-20, #221] The private `.cache` is never tracked, not even as a symlink:
`.gitignore`'s `.cache/` matches a directory but not a symlink of that name, so one `git add -A`
committed `.cache` and the next checkout replaced the real artifact directory with the link.

    python3 tools/check_originals.py
"""
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
# One-Nil 95/96's files: executables, data, palettes, fonts, PIFs, batch files and its saves.
FORBIDDEN = {".exe", ".dat", ".pif", ".bat", ".pal", ".tfn", ".1-0", ".sav", ".com", ".ovl"}


def tracked(root):
    """Every tracked path of `root`, decoded, in git's own order."""
    out = subprocess.run(["git", "ls-files", "-z"], cwd=root, capture_output=True, check=True).stdout
    return [name.decode() for name in out.split(b"\0") if name]


def violations(names):
    """Original-game file types and private cache paths among tracked `names`."""
    originals = [name for name in names if Path(name).suffix.lower() in FORBIDDEN]
    # any path component named .cache, at any depth (rule 17's backstop):
    # `nested/.cache` and `nested/.cache/x` are caught like the root cache
    cache = [name for name in names
             if ".cache" in Path(name).parts or name == ".cache"]
    return originals, cache


def main() -> int:
    originals, cache = violations(tracked(ROOT))
    for name in originals:
        print(f"original-game file type tracked: {name}")
    for name in cache:
        print(f"private cache path tracked: {name}")
    ok = not originals and not cache
    print("original-file check: " + ("ok" if ok else "FAIL"))
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main())
