#!/usr/bin/env python3
"""The league data files (ENGL-94.DAT, ENGL-95.DAT, SCOT-94.DAT, ITAL-94.DAT): their layout, read
as the game reads them (T03, F03).

    python3 tools/data/league.py --record records/T03/leagues.json [<dir>]  write the record (refuses to overwrite)
    python3 tools/data/league.py --check <dir>     decode every league file under <dir> (searched
                                                   recursively, one copy per sha256) and compare
                                                   with records/T03/leagues.json; exit 0 when equal
    python3 tools/data/league.py --show <file.DAT> print the decoded file (local use; never commit it)

The layout is the read sequence of 1-0.EXE's loader 1B55:0730 (static/1-0-exe/decompiled,
static/1-0-exe/code/seg_1B55_*.asm): one read per block, in this order (232A:1208 -> 24BC:11E1,
which calls Dos.MsDos 26B8:00A7 with AH=3Fh, the handle at DS:DF04, the count and the buffer), then
3920 pairs of single bytes. Field names are positional (`block_NN_<destination>`) except
where the bytes are text; what a number means is not decided here. A record holds decoded strings,
counts, offsets and, for a numeric block, its range and number of distinct values, never the
values themselves (CLAUDE.md rule 14).
"""
import hashlib
import json
import os
import struct
import sys

# (name, size or None for the text pool, destination in 1-0.EXE, kind)
# kind: u8 / u16 a number; str<w> Pascal strings of w bytes; pool / offsets the player names.
BLOCKS = [
    ("header_byte_0", 1, "DS:DCD8", "u8"),
    ("header_year", 2, "DS:DCDA", "u16"),
    ("header_byte_3", 1, "DS:DCE0", "u8"),
    ("header_pool_size", 2, "DS:D790", "u16"),
    ("division_names", 0x70, "DS:DCE6", "str16"),
    ("club_names", 0xB00, "[DS:D7B2]", "str16"),
    ("club_block_a", 0xB0, "[DS:D7B6]", "u8"),
    ("club_block_b", 0xB0, "DS:D7D6", "u8"),
    ("block_1001_a", 0x3E9, "[DS:DCD4]", "u8"),
    ("names_1001", 0x2B03, "[DS:DCCC]", "str11"),
    ("block_1001_b", 0x3E9, "[DS:DCD0]", "u8"),
    ("player_name_pool", None, "[DS:D7A2]", "pool"),
    ("player_name_offsets", 0x1EA4, "[DS:D7A6]", "offsets"),
    ("player_block_a", 0xF51, "[DS:D7AA]", "u8"),
    ("player_block_b", 0xF51, "[DS:D7AE]", "u8"),
    ("club_block_c", 0xB0, "DS:D886", "u8"),
    ("club_block_d", 0xB0, "DS:D936", "u8"),
    ("club_block_528", 0x210, "DS:DA96", "u8"),
    ("club_block_e", 0xB0, "DS:D9E6", "u8"),
]
PAIRS = 0xF50  # k = 1..3920: one byte to [DS:D7BA] + 8k + 1, one to + 8k + 3
LEAGUE_FILES = ("ENGL-94.DAT", "ENGL-95.DAT", "SCOT-94.DAT", "ITAL-94.DAT")
ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))


class LayoutError(Exception):
    pass


def pascal_strings(b, width):
    """Strings of `width` bytes: a length byte, the text, then padding. Returns the texts and the
    number of padding bytes that are not zero (text left over from a longer earlier value)."""
    out, residue = [], 0
    for i in range(0, len(b), width):
        n = b[i]
        if n >= width:
            raise LayoutError("string at +%d has length %d, more than its %d bytes" % (i, n, width - 1))
        out.append(b[i + 1:i + 1 + n].decode("latin-1"))
        residue += sum(1 for x in b[i + 1 + n:i + width] if x)
    return out, residue


def numeric(b, kind):
    vals = list(b) if kind == "u8" else list(struct.unpack("<%dH" % (len(b) // 2), b))
    return {"count": len(vals), "min": min(vals), "max": max(vals), "distinct": len(set(vals))}


def decode(data):
    """The decoded file: every block with its offset and size, and the pairs; raises LayoutError
    when the bytes do not fit the read sequence exactly."""
    if len(data) < 6:
        raise LayoutError("shorter than the header")
    pool_size = struct.unpack_from("<H", data, 4)[0]
    off, blocks = 0, []
    for name, size, dest, kind in BLOCKS:
        size = pool_size + 1 if size is None else size
        b = data[off:off + size]
        if len(b) != size:
            raise LayoutError("%s ends past the end of the file" % name)
        e = {"name": name, "offset": off, "size": size, "destination": dest}
        if kind == "u8" and size == 1:
            e["value"] = b[0]
        elif kind == "u16" and size == 2:
            e["value"] = struct.unpack("<H", b)[0]
        elif kind.startswith("str"):
            width = int(kind[3:])
            e["strings"], e["padding_residue"] = pascal_strings(b, width)
        elif kind in ("u8", "u16"):
            e.update(numeric(b, kind))
        blocks.append((e, b, kind))
        off += size
    pairs = data[off:off + 2 * PAIRS]
    if len(pairs) != 2 * PAIRS:
        raise LayoutError("the pairs end past the end of the file")
    if off + 2 * PAIRS != len(data):
        raise LayoutError("%d bytes after the last read" % (len(data) - off - 2 * PAIRS))
    by = {e["name"]: (e, b) for e, b, _ in blocks}
    pool = by["player_name_pool"][1]
    offs = struct.unpack("<%dH" % (0x1EA4 // 2), by["player_name_offsets"][1])
    if offs[0] != 0 or any(offs[i] > offs[i + 1] for i in range(len(offs) - 1)) or offs[-1] != pool_size:
        raise LayoutError("the name offsets are not 0, rising, up to the pool size")
    names = [pool[offs[k]:offs[k + 1]].decode("latin-1") for k in range(1, len(offs) - 1)]
    if pool[0] != 0:
        raise LayoutError("the pool does not start with its unused byte 0")
    pe = by["player_name_pool"][0]
    pe["player_names"] = names
    pe["players"] = len(names)
    pe["bytes_in_no_name"] = "pool byte 0 (always 0) and pool byte %d, the last" % pool_size
    pair = {"name": "player_pairs", "offset": off, "size": 2 * PAIRS, "destination": "[DS:D7BA]+8k+1, +8k+3",
            "count": PAIRS, "first": numeric(pairs[0::2], "u8"), "second": numeric(pairs[1::2], "u8")}
    return [e for e, _, _ in blocks] + [pair]


def summary(data):
    blocks = decode(data)
    by = {b["name"]: b for b in blocks}
    return {
        "sha256": hashlib.sha256(data).hexdigest(),
        "size": len(data),
        "year": by["header_year"]["value"],
        "header_byte_0": by["header_byte_0"]["value"],
        "header_byte_3": by["header_byte_3"]["value"],
        "pool_size": by["header_pool_size"]["value"],
        "divisions": len(by["division_names"]["strings"]),
        "clubs": len(by["club_names"]["strings"]),
        "names_1001": len(by["names_1001"]["strings"]),
        "players": by["player_name_pool"]["players"],
        "blocks": blocks,
    }


def league_files(base):
    """One path per distinct sha256 of the four league files under base, sorted by name."""
    seen, out = set(), []
    for d, _, files in sorted(os.walk(base)):
        for f in sorted(files):
            if f.upper() in LEAGUE_FILES:
                p = os.path.join(d, f)
                with open(p, "rb") as fh:
                    h = hashlib.sha256(fh.read()).hexdigest()
                if h not in seen:
                    seen.add(h)
                    out.append((f.upper(), p))
    return sorted(out)


def build(base):
    out = {}
    for name, p in league_files(base):
        with open(p, "rb") as fh:
            out[name] = summary(fh.read())
    return {"tool": "tools/data/league.py", "files": out}


def main(argv):
    if len(argv) >= 2 and argv[0] == "--record":
        path = argv[1]
        if os.path.exists(path):
            raise SystemExit("run records are immutable (CLAUDE.md rule 13): %s exists" % path)
        rec = build(argv[2] if len(argv) > 2 else os.path.join(ROOT, ".cache"))
        os.makedirs(os.path.dirname(path), exist_ok=True)
        with open(path, "w") as f:
            json.dump(rec, f, indent=1, ensure_ascii=False)
            f.write("\n")
        print("wrote", path, "(%d files)" % len(rec["files"]))
        return 0
    if len(argv) == 2 and argv[0] == "--check":
        try:
            got = build(argv[1])
        except LayoutError as e:
            print("league check: FAIL (%s)" % e)
            return 1
        with open(os.path.join(ROOT, "records", "T03", "leagues.json")) as f:
            want = json.load(f)
        ok = got["files"] == want["files"] and set(got["files"]) == set(LEAGUE_FILES)
        for n, s in sorted(got["files"].items()):
            print("%s: %d bytes, year %d, %d divisions, %d clubs, %d names_1001, %d players; every byte read"
                  % (n, s["size"], s["year"], s["divisions"], s["clubs"], s["names_1001"], s["players"]))
        print("league check: %s" % ("ok" if ok else "FAIL (differs from records/T03/leagues.json or a file is missing)"))
        return 0 if ok else 1
    if len(argv) == 2 and argv[0] == "--show":
        with open(argv[1], "rb") as f:
            print(json.dumps(summary(f.read()), indent=1, ensure_ascii=False))
        return 0
    sys.stderr.write(__doc__)
    return 2


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
