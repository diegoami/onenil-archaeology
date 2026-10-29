import hashlib
import os
import struct
import sys
import unittest

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
sys.path.insert(0, os.path.join(ROOT, "runtime"))

import layouts  # noqa: E402


def pstrs(names, width=16):
    return b"".join(bytes([len(n)]) + n.encode() + bytes(width - 1 - len(n)) for n in names)


class LayoutsTests(unittest.TestCase):
    def setUp(self):
        # guest memory: DS at 0x10000; a far pointer at DS:D7B2 to 0x2000:0x0010 (linear 0x20010)
        self.mem = bytearray(0x40000)
        self.ds = 0x10000
        self.clubs = ["Club %d" % k for k in range(176)]
        self.divs = ["DIV %d" % k for k in range(7)]
        struct.pack_into("<HH", self.mem, self.ds + 0xD7B2, 0x0010, 0x2000)
        self.mem[0x20010:0x20010 + 0xB00] = pstrs(self.clubs)
        self.mem[self.ds + 0xDCE6:self.ds + 0xDCE6 + 0x70] = pstrs(self.divs)
        self.mem[self.ds + 0xDCD8] = 9

    def read(self, a, n):
        return bytes(self.mem[a:a + n])

    def test_linear_follows_the_far_pointer(self):
        self.assertEqual(layouts.linear(self.read, self.ds, "[DS:D7B2]"), 0x20010)
        self.assertEqual(layouts.linear(self.read, self.ds, "DS:DCD8"), self.ds + 0xDCD8)

    def test_compare(self):
        blocks = [{"destination": "DS:DCD8", "size": 1, "sha256": hashlib.sha256(b"\x09").hexdigest()},
                  {"destination": "DS:DCD9", "size": 1, "sha256": hashlib.sha256(b"\x01").hexdigest()}]
        names = {"A.DAT": (self.divs, self.clubs), "B.DAT": (self.divs, self.clubs[::-1])}
        r = layouts.compare(self.read, self.ds, names, blocks)
        self.assertEqual(r["league"]["league_files_equal"], ["A.DAT"])
        self.assertEqual([b["verdict"] for b in r["save"]["blocks"]], ["equal", "differs"])
        self.assertEqual(r["save"]["equal"], 1)
        self.assertNotIn("bytes", str(r))  # digests and names only


if __name__ == "__main__":
    unittest.main()
