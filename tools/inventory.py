#!/usr/bin/env python3
"""T01: the inventory of both One-Nil editions, the compiler and run-time markers of their
executables, and the differences between 95 and 96. Reads the owner's files in .cache/ (pulled
by tools/artifacts.py); writes records that hold digests, offsets, counts and short decoded values,
never the original's bytes (CLAUDE.md rule 14).

    python3 tools/inventory.py build [--out records/T01]   write inventory.json, compiler.json and
                                                           diff-95-96.json (refuses to overwrite)
    python3 tools/inventory.py --check records/T01/inventory.json
                                     every file of the editions matches its size and sha256 (and,
                                     for LZEXE files, the unpacked size and sha256); none missing
                                     or extra. Exit 0 when it all matches.
    python3 tools/inventory.py --check-embed
                                     no tracked file outside static/ holds 64 or more consecutive
                                     bytes of an original file or of an unpacked executable.

Addresses are SEG:OFF in the unpacked load image before relocation (image offset SEG*16+OFF).
"""
import datetime
import difflib
import hashlib
import json
import re
import struct
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "tools" / "static"))
import unlzexe  # noqa: E402

CACHE = ROOT / ".cache"
EDITIONS = {"95": "One-Nil95", "96": "One-Nil96"}
# Files that are one program under another name in the other edition.
COUNTERPARTS = {("1-095.EXE", "1-0.EXE"), ("1-095.PIF", "1-0.PIF")}
EMBED_WINDOW = 64
STRING_MIN = 6
STRING_SHOWN = 48  # a recorded string is cut to this many characters, its length kept

# Turbo Pascal 7 run-time markers, as byte patterns (each documented where it is used).
TP_VECTORS = bytes([0x00, 0x02, 0x1B, 0x21, 0x23, 0x24] + list(range(0x34, 0x40)) + [0x75])
# Test8086: pushf; pop bx; and bh,0Fh; push bx; popf; pushf; pop cx; and ch,0F0h; cmp ch,0F0h
TP_TEST8086 = bytes.fromhex("9c5b80e70f539d9c5980e5f080fdf0")
# Crt's delay calibration: wait for the BIOS tick to change (cmp bl,es:[di]; je $-3), later
# mov cx,55; div cx (55 ms per tick: DelayCnt, the division that overflows on fast CPUs).
CRT_TICK_WAIT = bytes.fromhex("263a1d74fb")
CRT_DIV55 = bytes.fromhex("b93700f7f1")
RUNTIME_ERROR = b"Runtime error "
BORLAND = re.compile(rb"Portions Copyright \(c\) 19\d\d,\d\d Borland")


# ---------------------------------------------------------------------------------------------
# files

def sha256(data):
    return hashlib.sha256(data).hexdigest()


def edition_files(cache=CACHE):
    """(edition, relative path, Path) of every file of both editions, sorted."""
    out = []
    for ed, folder in EDITIONS.items():
        d = cache / folder
        if not d.is_dir():
            raise SystemExit(f"missing {d}: run python3 tools/artifacts.py pull")
        for p in sorted(d.iterdir()):
            if p.is_file():
                out.append((ed, f"{folder}/{p.name}", p))
    return out


def classify(name, data):
    if data[:2] == b"MZ":
        return "MZ executable, LZEXE 0.91" if data[0x1C:0x20] == b"LZ91" else "MZ executable"
    ext = Path(name).suffix.upper()
    if ext == ".PIF" and len(data) >= 0x187 and data[0x171:0x180] == b"MICROSOFT PIFEX":
        return "Windows program information file"
    if ext == ".BAT":
        return "DOS batch file"
    if ext == ".PAL" and len(data) == 768 and max(data) < 64:
        return "palette: 256 entries of 3 bytes, every value 0..63 (VGA DAC)"
    if ext == ".TFN" and len(data) == 4096:
        return "font: 4096 bytes (256 glyphs of 16 bytes if 8x16; layout is T03's)"
    if ext == ".DAT":
        return "league data (layout is T03's)"
    if name.upper().startswith("SAVE"):
        return "saved game (layout is T03's)"
    return "unknown"


def mz_image(data):
    """(header words, relocations as (seg, off), load image) of a plain MZ file."""
    w = struct.unpack("<14H", data[:0x1C])
    relocs = []
    for i in range(w[3]):
        off, seg = struct.unpack_from("<HH", data, w[12] + 4 * i)
        relocs.append((seg, off))
    size = (w[2] - 1) * 512 + w[1] if w[1] else w[2] * 512
    return w, relocs, data[w[4] * 16:size]


def header_fields(w):
    return {"entry": "%04X:%04X" % (w[11], w[10]), "stack": "%04X:%04X" % (w[7], w[8]),
            "minalloc_paras": w[5], "maxalloc_paras": w[6], "header_paras": w[4]}


def file_entry(ed, rel, p):
    data = p.read_bytes()
    st = p.stat()
    e = {"edition": ed, "path": rel, "name": p.name, "size": len(data), "sha256": sha256(data),
         "mtime": datetime.datetime.fromtimestamp(int(st.st_mtime), datetime.timezone.utc)
         .strftime("%Y-%m-%dT%H:%M:%SZ"),
         "type": classify(p.name, data)}
    if data[:2] == b"MZ" and data[0x1C:0x20] == b"LZ91":
        w, _, _ = mz_image(data)
        out = unlzexe.unpack(data)
        uw, relocs, image = mz_image(out)
        e["packed_header"] = header_fields(w)
        e["unpacked"] = {"size": len(out), "sha256": sha256(out), "relocations": len(relocs),
                         "image_size": len(image), **header_fields(uw)}
    if e["type"] == "DOS batch file":
        e["text"] = data.decode("latin-1").strip()
    return e


# ---------------------------------------------------------------------------------------------
# executables: segments and the Turbo Pascal markers

class Exe:
    def __init__(self, data):
        self.packed = data
        self.raw = unlzexe.unpack(data) if data[0x1C:0x20] == b"LZ91" else data
        self.w, self.relocs, self.image = mz_image(self.raw)
        self.reloc_at = {s * 16 + o for s, o in self.relocs}
        bases = {struct.unpack_from("<H", self.image, a)[0] for a in self.reloc_at}
        bases.add(self.w[11])
        self.segments = sorted(b for b in bases if b * 16 < len(self.image))
        self.entry = self.w[11] * 16 + self.w[10]

    def seg_bounds(self):
        ends = self.segments[1:] + [(len(self.image) + 15) // 16]
        return list(zip(self.segments, ends))

    def seg_of(self, a):
        for s, e in self.seg_bounds():
            if s * 16 <= a < e * 16:
                return s
        return None

    def addr(self, a):
        s = self.seg_of(a)
        return "%04X:%04X" % (s, a - s * 16) if s is not None else "image+%05X" % a

    def far_call(self, a):
        """(seg, off) of a far call `9A off seg` at image offset a whose segment is relocated."""
        if self.image[a] == 0x9A and a + 3 in self.reloc_at:
            off, seg = struct.unpack_from("<HH", self.image, a + 1)
            return seg, off
        return None

    def init_calls(self):
        """The far calls at the entry point, in order, up to the first other instruction: a
        Turbo Pascal program's body starts with System's init, then each unit's init."""
        calls, a = [], self.entry
        while True:
            c = self.far_call(a)
            if not c:
                return calls
            calls.append(c)
            a += 5

    def find(self, pat, start=0, end=None):
        end = len(self.image) if end is None else end
        return [start + m.start() for m in re.finditer(re.escape(pat), self.image[start:end])]

    def far_targets(self):
        """Image offsets of the targets of every relocated far call, from the relocation table."""
        out = set()
        for r in self.reloc_at:
            a = r - 3
            if a >= 0 and self.far_call(a):
                seg, off = self.far_call(a)
                out.add(seg * 16 + off)
        return sorted(t for t in out if t < len(self.image))

    def strings(self):
        return [m.group().decode("latin-1")
                for m in re.finditer(rb"[\x20-\x7e]{%d,}" % STRING_MIN, self.image)]


def shown(s):
    return s if len(s) <= STRING_SHOWN else s[:STRING_SHOWN] + f"... ({len(s)} chars)"


def tp_markers(exe):
    """The Turbo Pascal run-time markers of one executable, each with where it is."""
    m = {"image_size": len(exe.image), "relocations": len(exe.relocs),
         "segments": len(exe.segments), "entry": "%04X:%04X" % (exe.w[11], exe.w[10])}
    calls = exe.init_calls()
    m["entry_far_calls"] = ["%04X:%04X" % c for c in calls]
    if not calls:
        m["system_segment"] = None
        return m
    sys_seg = calls[0][0]
    bounds = dict(exe.seg_bounds())
    lo, hi = sys_seg * 16, bounds[sys_seg] * 16
    m["system_segment"] = "%04X" % sys_seg
    m["system_size"] = hi - lo
    img = exe.image
    # System init: mov dx,DATA; mov ds,dx (BA lo hi 8E DA) at its first byte.
    if img[lo] == 0xBA and img[lo + 3:lo + 5] == b"\x8e\xda" and lo + 1 in exe.reloc_at:
        m["data_segment"] = "%04X" % struct.unpack_from("<H", img, lo + 1)[0]
    m["saved_vectors"] = ["%04X:%04X" % (sys_seg, a - lo) for a in exe.find(TP_VECTORS, lo, hi)]
    m["saved_vector_list"] = " ".join("%02X" % b for b in TP_VECTORS)
    m["test8086"] = [exe.addr(a) for a in exe.find(TP_TEST8086, lo, hi)]
    m["runtime_error_string"] = [exe.addr(a) for a in exe.find(RUNTIME_ERROR, lo, hi)]
    b = BORLAND.search(img, lo, hi)
    m["borland_copyright"] = {"at": exe.addr(b.start()), "text": b.group().decode()} if b else None
    nc = re.search(rb"\(c\) [\x20-\x7e]{3,40}", img[:lo])
    m["other_copyright"] = {"at": exe.addr(nc.start()), "text": nc.group().decode()} if nc else None
    crt = []
    for a in exe.find(CRT_DIV55):
        w0 = img.rfind(CRT_TICK_WAIT, max(0, a - 48), a)
        if w0 >= 0:
            crt.append({"tick_wait": exe.addr(w0), "div55": exe.addr(a)})
    m["crt_delay_calibration"] = crt
    # Prologues of far-called routines: 8086 (push bp; mov bp,sp) or 80186 ENTER.
    pro = {"push_bp_mov_bp_sp": 0, "enter": 0, "other": 0}
    for t in exe.far_targets():
        if img[t:t + 3] in (b"\x55\x89\xe5", b"\x55\x8b\xec"):
            pro["push_bp_mov_bp_sp"] += 1
        elif img[t] == 0xC8:
            pro["enter"] += 1
        else:
            pro["other"] += 1
    m["far_routine_prologues"] = pro
    m["leave_count"] = len(exe.find(b"\xc9\xca")) + len(exe.find(b"\xc9\xcb"))
    return m


# ---------------------------------------------------------------------------------------------
# 95 vs 96

def normalized(exe):
    """The image with every relocated segment word replaced by the index of its segment, so
    two builds whose segments sit at other paragraphs compare equal where the code is equal."""
    img = bytearray(exe.image)
    index = {s: i for i, s in enumerate(exe.segments)}
    for a in exe.reloc_at:
        v = struct.unpack_from("<H", img, a)[0]
        struct.pack_into("<H", img, a, 0xF000 | index.get(v, 0xFFF))
    return bytes(img)


def regions(a, b):
    """Changed byte regions between two byte strings: same length compares in place, else by
    difflib's matching blocks. Returns a summary with no byte of either."""
    if len(a) == len(b):
        diff = [i for i in range(len(a)) if a[i] != b[i]]
        runs, prev = [], None
        for i in diff:
            if prev is None or i > prev + 1:
                runs.append([i, i])
            else:
                runs[-1][1] = i
            prev = i
        return {"method": "in place", "bytes_differing": len(diff), "regions": len(runs),
                "first_regions": [["%05X" % s, e - s + 1] for s, e in runs[:20]]}
    sm = difflib.SequenceMatcher(None, a, b, autojunk=False)
    ops = [o for o in sm.get_opcodes() if o[0] != "equal"]
    return {"method": "difflib", "regions": len(ops),
            "bytes_equal": sum(bl.size for bl in sm.get_matching_blocks()),
            "first_regions": [[o[0], "%05X" % o[1], o[2] - o[1], "%05X" % o[3], o[4] - o[3]]
                              for o in ops[:20]]}


def exe_delta(e95, e96):
    out = {"header_95": header_fields(e95.w), "header_96": header_fields(e96.w),
           "image_size": [len(e95.image), len(e96.image)],
           "relocations": [len(e95.relocs), len(e96.relocs)]}
    n95, n96 = normalized(e95), normalized(e96)
    init95 = {c[0] for c in e95.init_calls()}
    init96 = {c[0] for c in e96.init_calls()}
    segs = []
    if len(e95.segments) == len(e96.segments):
        for (s5, t5), (s6, t6) in zip(e95.seg_bounds(), e96.seg_bounds()):
            a, b = n95[s5 * 16:t5 * 16], n96[s6 * 16:t6 * 16]
            row = {"seg_95": "%04X" % s5, "seg_96": "%04X" % s6, "size": [len(a), len(b)],
                   "init": [s5 in init95, s6 in init96]}
            if a == b:
                row["status"] = "same"
            else:
                row["status"] = "changed"
                row["diff"] = regions(a, b)
            segs.append(row)
        out["segments_paired_by_order"] = segs
    else:
        out["segments_paired_by_order"] = None
        out["segments"] = [["%04X" % s for s in e95.segments], ["%04X" % s for s in e96.segments]]
    s95, s96 = set(e95.strings()), set(e96.strings())
    out["strings"] = {"min_length": STRING_MIN, "count": [len(s95), len(s96)],
                      "only_95": sorted(shown(s) for s in s95 - s96),
                      "only_96": sorted(shown(s) for s in s96 - s95)}
    return out


def file_delta(name, a, b):
    d = {"size": [len(a), len(b)]}
    if a[:2] == b"MZ" and b[:2] == b"MZ":
        return {**d, "executable": exe_delta(Exe(a), Exe(b))}
    if name.upper().endswith(".TFN") and len(a) == len(b) == 4096:
        d["glyphs_changed_if_8x16"] = [i for i in range(256) if a[i * 16:i * 16 + 16] != b[i * 16:i * 16 + 16]]
    if name.upper().endswith(".BAT"):
        d["text"] = [a.decode("latin-1").strip(), b.decode("latin-1").strip()]
        return d
    d["bytes"] = regions(a, b)
    return d


def diff_editions(files):
    by = {ed: {Path(rel).name: p for e, rel, p in files if e == ed} for ed in EDITIONS}
    counterpart = {}
    for a, b in COUNTERPARTS:
        counterpart[a], counterpart[b] = b, a
    rows = []
    for name in sorted(set(by["95"]) | set(by["96"])):
        p5, p6 = by["95"].get(name), by["96"].get(name)
        row = {"name": name}
        if p5 and p6:
            a, b = p5.read_bytes(), p6.read_bytes()
            row["status"] = "same" if a == b else "differs"
            if a != b:
                row["delta"] = file_delta(name, a, b)
        else:
            row["status"] = "95 only" if p5 else "96 only"
            other = counterpart.get(name)
            if other:
                row["counterpart"] = other
                if p5 and other in by["96"]:
                    row["delta_to_counterpart"] = file_delta(name, p5.read_bytes(), by["96"][other].read_bytes())
        rows.append(row)
    return rows


# ---------------------------------------------------------------------------------------------
# commands

def build(out_dir):
    out_dir = ROOT / out_dir
    targets = [out_dir / n for n in ("inventory.json", "compiler.json", "diff-95-96.json")]
    existing = [t for t in targets if t.exists()]
    if existing:
        raise SystemExit("run records are immutable (CLAUDE.md rule 13): %s exists" % existing[0])
    out_dir.mkdir(parents=True, exist_ok=True)
    files = edition_files()
    inv = {"tool": "tools/inventory.py", "files": [file_entry(*f) for f in files]}
    comp = {"tool": "tools/inventory.py",
            "executables": {rel: tp_markers(Exe(p.read_bytes()))
                            for _, rel, p in files if p.read_bytes()[:2] == b"MZ"}}
    diff = {"tool": "tools/inventory.py", "files": diff_editions(files)}
    for t, obj in zip(targets, (inv, comp, diff)):
        t.write_text(json.dumps(obj, indent=1) + "\n")
        print("wrote", t)
    return 0


def check(record):
    rec = json.loads(Path(record).read_text())
    want = {e["path"]: e for e in rec["files"]}
    have = {rel: p for _, rel, p in edition_files()}
    bad = 0
    for rel in sorted(set(want) | set(have)):
        if rel not in have:
            print("missing:", rel); bad += 1; continue
        if rel not in want:
            print("extra:", rel); bad += 1; continue
        data, e = have[rel].read_bytes(), want[rel]
        if len(data) != e["size"] or sha256(data) != e["sha256"]:
            print("differs:", rel); bad += 1; continue
        if "unpacked" in e:
            out = unlzexe.unpack(data)
            if len(out) != e["unpacked"]["size"] or sha256(out) != e["unpacked"]["sha256"]:
                print("unpacked differs:", rel); bad += 1
    print("inventory check: %s (%d files)" % ("FAIL" if bad else "ok", len(have)))
    return 1 if bad else 0


class EmbedIndex:
    """Every EMBED_WINDOW-byte window of the source files, for finding one inside another file.
    A window of one repeated byte is skipped: it identifies nothing."""

    def __init__(self, sources):
        self.sources = sources
        self.windows = {}
        for rel, data in sources:
            for i in range(len(data) - EMBED_WINDOW + 1):
                win = data[i:i + EMBED_WINDOW]
                if win.count(win[0]) != EMBED_WINDOW:
                    self.windows.setdefault(hash(win), rel)

    def _scan(self, data):
        for i in range(len(data) - EMBED_WINDOW + 1):
            win = data[i:i + EMBED_WINDOW]
            rel = self.windows.get(hash(win))
            if rel and win.count(win[0]) != EMBED_WINDOW and any(win in d for _, d in self.sources):
                return i, rel
        return None

    def find(self, data):
        """(how, offset, source) of the first embedded window in data: as raw bytes, or inside a
        run of hex digits (either case, optionally separated by single spaces) decoded to bytes;
        None when there is none."""
        hit = self._scan(data)
        if hit:
            return ("raw",) + hit
        for m in HEX_RUN.finditer(data):
            digits = re.sub(rb"\s", b"", m.group())
            for phase in (0, 1):
                chunk = digits[phase:]
                chunk = chunk[:len(chunk) // 2 * 2]
                hit = self._scan(bytes.fromhex(chunk.decode()))
                if hit:
                    return ("hex", m.start(), hit[1])
        return None


HEX_RUN = re.compile(rb"[0-9A-Fa-f](?:\s?[0-9A-Fa-f]){%d,}" % (2 * EMBED_WINDOW - 1))


def original_sources():
    sources = []
    for _, rel, p in edition_files():
        data = p.read_bytes()
        sources.append((rel, data))
        if data[:2] == b"MZ" and data[0x1C:0x20] == b"LZ91":
            sources.append((rel + " (unpacked)", unlzexe.unpack(data)))
    return sources


def check_embed():
    index = EmbedIndex(original_sources())
    tracked = subprocess.run(["git", "ls-files", "-z"], cwd=ROOT, capture_output=True, check=True)
    bad = 0
    for f in tracked.stdout.decode().split("\0"):
        if not f or f.startswith("static/"):
            continue  # static/: generated listings, CLAUDE.md rule 14's exception
        p = ROOT / f
        if not p.is_file():
            continue
        hit = index.find(p.read_bytes())
        if hit:
            print("%s: %d bytes of %s (%s, at %d)" % (f, EMBED_WINDOW, hit[2], hit[0], hit[1]))
            bad += 1
    print("embed check: %s" % ("FAIL" if bad else "ok"))
    return 1 if bad else 0


def main(argv):
    if argv[:1] == ["build"]:
        out = argv[argv.index("--out") + 1] if "--out" in argv else "records/T01"
        return build(out)
    if argv[:1] == ["--check"] and len(argv) == 2:
        return check(argv[1])
    if argv == ["--check-embed"]:
        return check_embed()
    sys.stderr.write(__doc__)
    return 2


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
