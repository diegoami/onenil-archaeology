import os
import random
import struct
import sys
import unittest

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(HERE)
sys.path.insert(0, os.path.join(ROOT, "tools"))
sys.path.insert(0, HERE)

import inventory  # noqa: E402
import lzexe_fixture as fx  # noqa: E402

RNG = random.Random(1)
SOURCE = bytes(RNG.randrange(256) for _ in range(4000))


class EmbedTests(unittest.TestCase):
    def setUp(self):
        self.index = inventory.EmbedIndex([("src", SOURCE)])

    def test_raw_window_is_found(self):
        hit = self.index.find(b"record " + SOURCE[100:100 + 64] + b" end")
        self.assertEqual(hit, ("raw", 7, "src"))

    def test_63_bytes_pass(self):
        self.assertIsNone(self.index.find(b"x" + SOURCE[100:163] + b"y"))

    def test_hex_in_either_case_and_spaced_is_found(self):
        chunk = SOURCE[500:500 + 64]
        for text in (chunk.hex(), chunk.hex().upper(), " ".join("%02x" % b for b in chunk),
                     "f" + chunk.hex()):  # odd phase
            with self.subTest(text=text[:20]):
                self.assertIsNotNone(self.index.find(('"' + text + '"').encode()))

    def test_digests_pass(self):
        import hashlib
        text = '"sha256": "%s"' % hashlib.sha256(SOURCE).hexdigest()
        self.assertIsNone(self.index.find(text.encode()))

    def test_runs_of_one_byte_pass(self):
        index = inventory.EmbedIndex([("zeros", b"\0" * 500 + SOURCE[:10])])
        self.assertIsNone(index.find(b"\0" * 200))


def tp_like_image():
    """A synthetic image laid out as a Turbo Pascal 7 program: entry far calls to System's init
    and a unit's init, a System segment with the markers, a unit with Crt's calibration."""
    img = bytearray(0x400)
    # segment 0000: entry: call far 0030:0000 (System), call far 0020:0000 (unit), retf
    img[0:5] = b"\x9a\x00\x00\x30\x00"
    img[5:10] = b"\x9a\x00\x00\x20\x00"
    img[10] = 0xCB
    # segment 0020: a unit: ENTER, Crt's tick wait and div by 55
    u = 0x200
    img[u:u + 4] = b"\xc8\x02\x00\x00"
    img[u + 0x10:u + 0x15] = inventory.CRT_TICK_WAIT
    img[u + 0x20:u + 0x25] = inventory.CRT_DIV55
    # segment 0030: System: mov dx,003C; mov ds,dx; the markers
    s = 0x300
    img[s:s + 5] = b"\xba\x3c\x00\x8e\xda"
    img[s + 0x20:s + 0x20 + len(inventory.TP_TEST8086)] = inventory.TP_TEST8086
    img[s + 0x40:s + 0x40 + len(inventory.TP_VECTORS)] = inventory.TP_VECTORS
    t = b"Runtime error Portions Copyright (c) 1983,92 Borland"
    img[s + 0x60:s + 0x60 + len(t)] = t
    # segment 003C: data
    relocs = [(0, 3), (0, 8), (0x30, 1)]
    return bytes(img), relocs


class MarkerTests(unittest.TestCase):
    def test_markers_of_a_synthetic_tp7_program(self):
        img, relocs = tp_like_image()
        exe = inventory.Exe(fx.build_lzexe(img, relocs=relocs, ip0=0, cs0=0))
        self.assertEqual(exe.segments, [0x00, 0x20, 0x30, 0x3C])
        m = inventory.tp_markers(exe)
        self.assertEqual(m["entry_far_calls"], ["0030:0000", "0020:0000"])
        self.assertEqual(m["system_segment"], "0030")
        self.assertEqual(m["data_segment"], "003C")
        self.assertEqual(m["test8086"], ["0030:0020"])
        self.assertEqual(m["saved_vectors"], ["0030:0040"])
        self.assertEqual(m["runtime_error_string"], ["0030:0060"])
        self.assertEqual(m["borland_copyright"]["at"], "0030:006E")
        self.assertEqual(m["crt_delay_calibration"], [{"tick_wait": "0020:0010", "div55": "0020:0020"}])
        self.assertEqual(m["far_routine_prologues"]["enter"], 1)

    def test_a_program_without_the_markers_has_none(self):
        img, relocs = tp_like_image()
        img = bytearray(img)
        img[0x320:0x320 + len(inventory.TP_TEST8086)] = b"\x90" * len(inventory.TP_TEST8086)
        img[0x340] = 0x01  # the vector list no longer matches
        m = inventory.tp_markers(inventory.Exe(fx.build_lzexe(bytes(img), relocs=relocs, ip0=0, cs0=0)))
        self.assertEqual(m["test8086"], [])
        self.assertEqual(m["saved_vectors"], [])


class DeltaTests(unittest.TestCase):
    def test_relocated_segment_shift_alone_is_same(self):
        img, relocs = tp_like_image()
        a = inventory.Exe(fx.build_lzexe(img, relocs=relocs, ip0=0, cs0=0))
        shifted = bytearray(img)
        struct.pack_into("<H", shifted, 3, 0x30)  # unchanged values: same layout
        b = inventory.Exe(fx.build_lzexe(bytes(shifted), relocs=relocs, ip0=0, cs0=0))
        rows = inventory.exe_delta(a, b)["segments_paired_by_order"]
        self.assertTrue(all(r["status"] == "same" for r in rows))

    def test_regions_in_place(self):
        r = inventory.regions(b"abcdefgh", b"abXdeYYh")
        self.assertEqual((r["bytes_differing"], r["regions"]), (3, 2))
        self.assertEqual(r["first_regions"], [["00002", 1], ["00005", 2]])


if __name__ == "__main__":
    unittest.main()
