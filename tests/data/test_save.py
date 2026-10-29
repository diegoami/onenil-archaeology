import os
import struct
import sys
import unittest

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname(HERE)), "tools", "data"))

import save  # noqa: E402


def fake(year=2001, seed=0x1234):
    out = bytearray()
    for dest, size in save.BLOCKS:
        if dest == "DS:DCDA":
            out += struct.pack("<H", year)
        elif dest == "[DS:DE84]":
            out += struct.pack("<H", seed)
        else:
            out += bytes((len(out) + k) & 0xFF for k in range(size))
    return bytes(out)


class SaveTests(unittest.TestCase):
    def test_size_is_the_sum_of_the_blocks(self):
        self.assertEqual(save.SIZE, 194426)

    def test_decode(self):
        blocks = save.decode(fake())
        by = {b["destination"]: b for b in blocks}
        self.assertEqual(by["DS:DCDA"]["value"], 2001)
        self.assertEqual(by["[DS:DE84]"]["value"], 0x1234)
        self.assertEqual(by["[DS:D7BA]"]["shape"], "3921 players x 8 bytes")
        self.assertEqual(blocks[-1]["offset"] + blocks[-1]["size"], save.SIZE)
        self.assertTrue(all(set(b) <= {"destination", "offset", "size", "sha256", "shape", "value"} for b in blocks))

    def test_another_size_is_refused(self):
        with self.assertRaises(save.LayoutError):
            save.decode(fake() + b"\0")
        with self.assertRaises(save.LayoutError):
            save.decode(fake()[:-1])

    def test_only_the_editions_folders_are_searched(self):
        import tempfile
        with tempfile.TemporaryDirectory() as d:
            for sub in ("One-Nil95", "One-Nil96", "driver/game"):
                os.makedirs(os.path.join(d, sub))
                open(os.path.join(d, sub, "SAVE1.1-0"), "wb").close()
            self.assertEqual(save.save_files(d), ["One-Nil95/SAVE1.1-0", "One-Nil96/SAVE1.1-0"])


if __name__ == "__main__":
    unittest.main()
