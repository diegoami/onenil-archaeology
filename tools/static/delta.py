#!/usr/bin/env python3
"""The 95 -> 96 delta by routine: static/delta-95-96.tsv, byte for byte.

    python3 tools/static/delta.py .cache/One-Nil95/1-095.EXE .cache/One-Nil96/1-0.EXE static/delta-95-96.tsv

Both executables are unpacked and disassembled as tools/static/listing.py does (the same routine
starts). Segments are paired by order (both have 15, F01). Each routine's bytes run to the next
routine start in its segment; before comparing, every relocated segment word, the offset word of
every far call or far jump, and the displacement of every near call are zeroed, so a routine that
only calls code that moved compares equal. Within a segment pair the routines are aligned by
difflib over those masked digests:
  same      identical masked bytes at the same offset
  moved     identical masked bytes at another offset
  operands  a routine in a replaced run of the alignment, paired by order with one of the other
            edition, whose decoded instructions are the same once every immediate and
            displacement is zeroed (capstone's imm/disp offsets) and whose bytes not decoded as
            code are ignored: a string, constant or variable that moved or changed, not the code
  changed   paired the same way, and its instructions differ
  new       in 96 only (a replaced or inserted run longer on the 96 side; its extra routines)
  removed   in 95 only
"""
import difflib
import hashlib
import os
import struct
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)

import onilexe  # noqa: E402
import unlzexe  # noqa: E402

KNOWN = {
    "95": "f659fb2d334500d6901fc8d6a0f06c85c0ccda2eb4a3035ae3bb0a0004d79192",
    "96": "89ff9c5f238f24e81a0c2440a46cdd8997280a65fc3cc3d97cb974f55280a80a",
}


class Routines:
    def __init__(self, packed):
        self.img = onilexe.Image(unlzexe.unpack(packed))
        self.dis = onilexe.Disassembly(self.img)
        starts = sorted(a for a, why in self.dis.starts.items()
                        if why & {"entry", "call", "far", "prologue"})
        self.by_seg = {s: [] for s, _ in self.img.code_segments}
        for k, a in enumerate(starts):
            s = self.img.segment_of(a)
            end = dict(self.img.code_segments)[s] * 16
            b = starts[k + 1] if k + 1 < len(starts) and starts[k + 1] < end else end
            self.by_seg[s].append((a, b, self.masked_digest(a, b), self.skeleton_digest(a, b)))

    def masked_digest(self, a, b):
        raw = bytearray(self.img.data[a:b])
        for r in self.img.relocs:
            if a <= r < b - 1:
                raw[r - a:r - a + 2] = b"\0\0"
        x = a
        while x < b:
            i = self.dis.ins.get(x)
            if i is None:
                x += 1
                continue
            b0 = i.bytes[0]
            if b0 in (0x9A, 0xEA) and i.size == 5:
                raw[x - a + 1:x - a + 3] = b"\0\0"
            elif b0 == 0xE8 and i.size == 3:
                raw[x - a + 1:x - a + 3] = b"\0\0"
            x += i.size
        return hashlib.sha256(bytes(raw)).hexdigest()

    def skeleton_digest(self, a, b):
        """The routine's decoded instructions with every immediate and displacement zeroed; bytes
        that are not decoded as code (its string constants, tables) are left out."""
        out = bytearray()
        x = a
        while x < b:
            i = self.dis.ins.get(x)
            if i is None:
                x += 1
                continue
            raw = bytearray(i.bytes)
            if raw[0] in (0x9A, 0xEA) and i.size == 5:
                raw[1:5] = bytes(4)  # capstone's imm_size is not usable here
            else:
                for off, size in ((i.imm_offset, i.imm_size), (i.disp_offset, i.disp_size)):
                    if off and size:
                        end = min(off + size, i.size)  # never past the instruction
                        raw[off:end] = bytes(end - off)
            out += raw
            x += i.size
        return hashlib.sha256(bytes(out)).hexdigest()

    def addr(self, a):
        s = self.img.segment_of(a)
        return "%04X:%04X" % (s, a - s * 16)


def delta(r95, r96):
    rows = []
    segs95 = [s for s, _ in r95.img.code_segments]
    segs96 = [s for s, _ in r96.img.code_segments]
    if len(segs95) != len(segs96):
        raise SystemExit("delta: the code segments differ in number; pairing by order is not possible")
    for s5, s6 in zip(segs95, segs96):
        a5, a6 = r95.by_seg[s5], r96.by_seg[s6]
        h5, h6 = [x[2] for x in a5], [x[2] for x in a6]
        sm = difflib.SequenceMatcher(None, h5, h6, autojunk=False)
        for op, i1, i2, j1, j2 in sm.get_opcodes():
            if op == "equal":
                for k in range(i2 - i1):
                    x5, x6 = a5[i1 + k], a6[j1 + k]
                    same_off = x5[0] - s5 * 16 == x6[0] - s6 * 16
                    rows.append((r96.addr(x6[0]), r95.addr(x5[0]), "same" if same_off else "moved",
                                 x6[1] - x6[0], x5[1] - x5[0]))
                continue
            n = min(i2 - i1, j2 - j1)
            for k in range(n):
                x5, x6 = a5[i1 + k], a6[j1 + k]
                status = "operands" if x5[3] == x6[3] else "changed"
                rows.append((r96.addr(x6[0]), r95.addr(x5[0]), status, x6[1] - x6[0], x5[1] - x5[0]))
            for x6 in a6[j1 + n:j2]:
                rows.append((r96.addr(x6[0]), "", "new", x6[1] - x6[0], ""))
            for x5 in a5[i1 + n:i2]:
                rows.append(("", r95.addr(x5[0]), "removed", "", x5[1] - x5[0]))
    return rows


def main(argv):
    if len(argv) != 4:
        sys.stderr.write(__doc__)
        return 2
    packed = {}
    for ed, path in (("95", argv[1]), ("96", argv[2])):
        with open(path, "rb") as f:
            packed[ed] = f.read()
        if hashlib.sha256(packed[ed]).hexdigest() != KNOWN[ed]:
            sys.stderr.write("delta: %s is not the %s executable of records/T01/inventory.json\n" % (path, ed))
            return 1
    rows = delta(Routines(packed["95"]), Routines(packed["96"]))
    counts = {}
    for r in rows:
        counts[r[2]] = counts.get(r[2], 0) + 1
    out = ["; the 95 -> 96 delta by routine (tools/static/delta.py; see its docstring for the method)",
           "; 1-095.EXE sha256 %s, 1-0.EXE sha256 %s" % (KNOWN["95"], KNOWN["96"]),
           "; counts: " + ", ".join("%s %d" % (k, counts[k]) for k in sorted(counts)),
           "routine_96\troutine_95\tstatus\tsize_96\tsize_95"]
    out += ["%s\t%s\t%s\t%s\t%s" % r for r in rows]
    with open(argv[3], "w", newline="\n") as f:
        f.write("\n".join(out) + "\n")
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv))
