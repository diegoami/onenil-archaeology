#!/usr/bin/env python3
"""The saved game (SAVE1.1-0, *.1-0): its layout, as 1-0.EXE writes and reads it (T03, F03).

    python3 tools/data/save.py --record records/T03/saves.json [<dir>]  write the record (refuses to overwrite)
    python3 tools/data/save.py --check <dir>     decode every *.1-0 under <dir> and compare with the record

The layout is the block sequence of 1B55:091D (static/1-0-exe/code/seg_1B55_*.asm): one call of
1B55:08D9 per block, which writes (232A:11E3) or reads (232A:1208) that many bytes at that place,
in this order. Field names are the destinations; record shapes are the block sizes divided by the
counts the league files hold (3921 players with entry 0, 176 clubs, 1001 names), where they divide.
A record holds each block's offset, size and sha256, and a few decoded numbers (the header byte,
the year, the RNG seed word), never a block's bytes.
"""
import hashlib
import json
import os
import struct
import sys

# (destination in 1-0.EXE, size)
BLOCKS = [
    ("DS:DCD8", 1), ("DS:DCDA", 2), ("[DS:D7BA]", 0x7A88), ("[DS:D7BE]", 0xE5BF),
    ("[DS:D7C2]", 0x2AA0), ("[DS:D7C6]", 0x840), ("[DS:D7CA]", 0x77A0), ("[DS:D7CE]", 0x27E0),
    ("[DS:D7D2]", 0xF7), ("DS:D7D6", 0xB0), ("DS:DCA6", 8), ("DS:DCAE", 8), ("[DS:DCB6]", 0x60),
    ("DS:DCBA", 2), ("[DS:DE84]", 2), ("[DS:DCBC]", 0x6EA), ("[DS:DCC0]", 0x1FA0),
    ("[DS:DCC4]", 0xBC), ("[DS:DCC8]", 0xFA4), ("[DS:DCD4]", 0x3E9), ("[DS:DCCC]", 0x2B03),
    ("[DS:DCD0]", 0x3E9), ("[DS:D7AA]", 0xF51), ("DS:D936", 0xB0), ("DS:D9E6", 0xB0),
    ("[DS:DCDC]", 0x1D0), ("DS:DCE0", 1), ("[DS:DCE2]", 0x4674),
]
SIZE = sum(s for _, s in BLOCKS)
COUNTS = ((3921, "players"), (176, "clubs"), (1001, "names_1001"))
ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))


class LayoutError(Exception):
    pass


def shape(size):
    for n, what in COUNTS:
        if size % n == 0 and size // n > 1:
            return "%d %s x %d bytes" % (n, what, size // n)
    return None


def decode(data):
    if len(data) != SIZE:
        raise LayoutError("%d bytes; the block sequence writes %d" % (len(data), SIZE))
    out, off = [], 0
    for dest, size in BLOCKS:
        b = data[off:off + size]
        e = {"destination": dest, "offset": off, "size": size, "sha256": hashlib.sha256(b).hexdigest()}
        if shape(size):
            e["shape"] = shape(size)
        if dest == "DS:DCD8":
            e["value"] = b[0]
        elif dest in ("DS:DCDA", "[DS:DE84]"):
            e["value"] = struct.unpack("<H", b)[0]
        out.append(e)
        off += size
    return out


def save_files(base):
    out = []
    for d, _, files in sorted(os.walk(base)):
        for f in sorted(files):
            if f.upper().endswith(".1-0"):
                out.append(os.path.relpath(os.path.join(d, f), base))
    return out


def build(base):
    files = {}
    for rel in save_files(base):
        with open(os.path.join(base, rel), "rb") as f:
            data = f.read()
        files[rel] = {"sha256": hashlib.sha256(data).hexdigest(), "size": len(data), "blocks": decode(data)}
    return {"tool": "tools/data/save.py", "files": files}


def main(argv):
    if len(argv) >= 2 and argv[0] == "--record":
        if os.path.exists(argv[1]):
            raise SystemExit("run records are immutable (CLAUDE.md rule 13): %s exists" % argv[1])
        rec = build(argv[2] if len(argv) > 2 else os.path.join(ROOT, ".cache"))
        os.makedirs(os.path.dirname(argv[1]), exist_ok=True)
        with open(argv[1], "w") as f:
            json.dump(rec, f, indent=1)
            f.write("\n")
        print("wrote", argv[1], "(%d files)" % len(rec["files"]))
        return 0
    if len(argv) == 2 and argv[0] == "--check":
        try:
            got = build(argv[1])
        except LayoutError as e:
            print("save check: FAIL (%s)" % e)
            return 1
        with open(os.path.join(ROOT, "records", "T03", "saves.json")) as f:
            want = json.load(f)
        ok = got["files"] == want["files"] and bool(got["files"])
        for rel, s in sorted(got["files"].items()):
            print("%s: %d bytes in %d blocks; every byte placed" % (rel, s["size"], len(s["blocks"])))
        print("save check: %s" % ("ok" if ok else "FAIL (differs from records/T03/saves.json)"))
        return 0 if ok else 1
    sys.stderr.write(__doc__)
    return 2


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
