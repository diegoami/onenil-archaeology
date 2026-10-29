import os
import struct
import sys
import unittest

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname(HERE)), "tools", "data"))

import league  # noqa: E402


def pstr(text, width, pad=b"\0"):
    b = bytes([len(text)]) + text.encode("latin-1")
    return b + pad * (width - len(b))


def fake(extra=b"", names=None, bad_offset=False, long_club=False):
    """A league file of the layout with invented content: 3920 players named P1..P3920."""
    names = names or ["P%d" % k for k in range(1, 3921)]
    pool = b"\0" + "".join(names).encode() + b"x"  # byte 0 and the last byte are in no name
    offs, o = [0], 1
    for n in names:
        offs.append(o)
        o += len(n)
    offs.append(o)
    if bad_offset:
        offs[5], offs[6] = offs[6], offs[5]
    out = bytes([7]) + struct.pack("<H", 1999) + bytes([1]) + struct.pack("<H", len(pool) - 1)
    out += b"".join(pstr("DIV %d" % k, 16) for k in range(7))
    clubs = [pstr("Club %d" % k, 16) for k in range(176)]
    if long_club:
        clubs[3] = bytes([16]) + b"x" * 15
    out += b"".join(clubs)
    out += bytes(range(176)) * 2
    out += bytes(1001)
    out += pstr("", 11) + b"".join(pstr("Mgr%d" % k, 11) for k in range(1, 1001))
    out += bytes(1001)
    out += pool
    out += struct.pack("<%dH" % len(offs), *offs)
    out += bytes(3921) * 2 + bytes(176) * 2 + bytes(528) + bytes(176)
    out += bytes([25, 200]) * 3920
    return out + extra


class LeagueTests(unittest.TestCase):
    def test_decode(self):
        s = league.summary(fake())
        self.assertEqual((s["year"], s["divisions"], s["clubs"], s["names_1001"], s["players"]),
                         (1999, 7, 176, 1001, 3920))
        by = {b["name"]: b for b in s["blocks"]}
        self.assertEqual(by["player_name_pool"]["player_names"][:2], ["P1", "P2"])
        self.assertEqual(by["names_1001"]["strings"][1], "Mgr1")
        self.assertEqual(by["player_pairs"]["first"]["max"], 25)
        last = s["blocks"][-1]
        self.assertEqual(last["offset"] + last["size"], len(fake()))

    def test_a_byte_left_over_is_refused(self):
        with self.assertRaises(league.LayoutError):
            league.decode(fake(extra=b"\0"))

    def test_a_short_file_is_refused(self):
        with self.assertRaises(league.LayoutError):
            league.decode(fake()[:-1])

    def test_offsets_that_fall_are_refused(self):
        with self.assertRaises(league.LayoutError):
            league.decode(fake(bad_offset=True))

    def test_a_string_longer_than_its_field_is_refused(self):
        with self.assertRaises(league.LayoutError):
            league.decode(fake(long_club=True))

    def test_padding_residue_is_counted(self):
        f = bytearray(fake())
        f[6 + 16 + 10] = ord("Z")  # inside the padding of division 1
        by = {b["name"]: b for b in league.decode(bytes(f))}
        self.assertEqual(by["division_names"]["padding_residue"], 1)

    def test_records_hold_no_numeric_values(self):
        for b in league.decode(fake()):
            for k, v in b.items():
                if isinstance(v, list):
                    self.assertTrue(all(isinstance(x, str) for x in v), (b["name"], k))


if __name__ == "__main__":
    unittest.main()
