import os
import sys
import unittest

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
sys.path.insert(0, os.path.join(ROOT, "tools", "static"))

import drawsites  # noqa: E402


def draw(i, n, callers):
    return {"kind": "draw", "i": i, "n": n, "callers": callers}


class DrawSitesTests(unittest.TestCase):
    def test_the_site_is_the_first_caller_outside_the_library(self):
        self.assertEqual(drawsites.site_of(["24BC:0D12", "232A:0779", "0AB9:1A01", "0AB9:E24F"]), "0AB9:1A01")
        self.assertEqual(drawsites.site_of(["24BC:0D4F", "0AB9:8750", "0AB9:E2A0"]), "0AB9:8750")
        self.assertEqual(drawsites.site_of(["24BC:0D12", "?"]), "unresolved")
        self.assertEqual(drawsites.site_of(["24BC:0D12", "232A:0779"]), "unresolved")

    def test_draws_are_counted_inside_and_outside_the_match(self):
        events = [draw(0, 16, ["24BC:0D12", "232A:0779", "0AB9:1A01"]),
                  {"kind": "mark", "what": "match entry 0AB9:E1F2", "draws": 1},
                  draw(1, 90, ["24BC:0D12", "232A:0779", "0AB9:DDE4"]),
                  draw(2, 90, ["24BC:0D12", "232A:0779", "0AB9:DDE4"]),
                  {"kind": "mark", "what": "match return to 0AB9:EBE2", "draws": 3},
                  draw(3, 120, ["24BC:0D12", "232A:0779", "0AB9:DDE4"])]
        rows, entry, ret = drawsites.table(events)
        self.assertEqual((entry, ret), (1, 3))
        self.assertEqual((rows["0AB9:DDE4"]["match"], rows["0AB9:DDE4"]["rest"]), (2, 1))
        self.assertEqual(rows["0AB9:DDE4"]["n"], {90, 120})
        self.assertEqual((rows["0AB9:1A01"]["match"], rows["0AB9:1A01"]["rest"]), (0, 1))

    def test_a_trace_without_marks_is_refused(self):
        with self.assertRaises(SystemExit):
            drawsites.table([draw(0, 2, ["24BC:0D4F", "0AB9:8750"])])


if __name__ == "__main__":
    unittest.main()
