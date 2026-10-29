import os
import struct
import sys
import unittest

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(os.path.dirname(HERE))
sys.path.insert(0, os.path.join(ROOT, "tools", "static"))

import onilexe  # noqa: E402


def mz(img, relocs, cs=0, ip=0):
    hdr = bytearray(0x200)
    total = 0x200 + len(img)
    struct.pack_into("<14H", hdr, 0, 0x5A4D, total % 512, (total + 511) // 512, len(relocs), 0x20,
                     0, 0xFFFF, 0, 0x100, 0, ip, cs, 0x1C, 0)
    for k, (seg, off) in enumerate(relocs):
        struct.pack_into("<HH", hdr, 0x1C + 4 * k, off, seg)
    return bytes(hdr) + bytes(img)


def tp_program():
    """seg 0: call far 0003:0000 (System); call far 0002:0000 (a unit); retf.
    seg 2 (0x20): a unit: ENTER 2,0 ; leave ; retf, then an unreached ENTER routine at 0x28.
    seg 3 (0x30): System: mov dx,0005 ; mov ds,dx ; retf.
    seg 4 (0x40): referenced more often by a non-call relocation than seg 5, which is DS.
    seg 5 (0x50): data."""
    img = bytearray(0x60)
    img[0:5] = b"\x9a\x00\x00\x03\x00"
    img[5:10] = b"\x9a\x00\x00\x02\x00"
    img[10] = 0xCB
    img[0x20:0x26] = b"\xc8\x02\x00\x00\xc9\xcb"
    img[0x28:0x2E] = b"\xc8\x04\x00\x00\xc9\xcb"
    img[0x30:0x36] = b"\xba\x05\x00\x8e\xda\xcb"
    img[0x36:0x3C] = b"\xb8\x04\x00\xb8\x04\x00"  # unreached data holding seg 4 twice
    return mz(img, [(0, 3), (0, 8), (3, 1), (3, 7), (3, 10)])


class OnilExeTests(unittest.TestCase):
    def test_data_segment_is_what_system_init_loads(self):
        img = onilexe.Image(tp_program())
        self.assertEqual(img.ds, 5)

    def test_enter_prologue_starts_a_routine(self):
        dis = onilexe.Disassembly(onilexe.Image(tp_program()))
        self.assertIn("prologue", dis.starts.get(0x28, set()))
        self.assertIn(0x28, dis.ins)

    def test_enter_with_nesting_level_is_not_a_prologue(self):
        self.assertTrue(onilexe.Disassembly.is_prologue(b"\xc8\x02\x00\x00"))
        self.assertFalse(onilexe.Disassembly.is_prologue(b"\xc8\x02\x00\x01"))
        self.assertTrue(onilexe.Disassembly.is_prologue(b"\x55\x89\xe5\x00"))


if __name__ == "__main__":
    unittest.main()
