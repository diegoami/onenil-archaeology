import os
import sys
import unittest
from unittest import mock

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname(HERE)), "tools", "static"))

import index  # noqa: E402

# A:0001 match anchor -> 0002 -> 0003 <-> 0004 (a cycle); 0005 called by match and season;
# 0006 called by nobody; B:0001 in a library segment; 0007 reached only through the cycle.
ROUTINES = ["A:0001", "A:0002", "A:0003", "A:0004", "A:0005", "A:0006", "A:0007", "A:0008", "B:0001"]
CALLERS = {"A:0002": {"A:0001"}, "A:0003": {"A:0002", "A:0004"}, "A:0004": {"A:0003"},
           "A:0005": {"A:0001", "A:0008"}, "A:0007": {"A:0004"}}
ANCHORS = ({"B": "library"}, {"A:0001": "match", "A:0008": "season"})


class IndexTests(unittest.TestCase):
    def run_index(self):
        with mock.patch.object(index, "routines", return_value=ROUTINES), \
                mock.patch.object(index, "callers_of", return_value=CALLERS), \
                mock.patch.object(index, "anchors", return_value=ANCHORS):
            return {a: (ar, b.split(":")[0]) for a, ar, b in index.index_96()}

    def test_rules(self):
        got = self.run_index()
        self.assertEqual(got["A:0001"], ("match", "anchor"))
        self.assertEqual(got["B:0001"], ("library", "segment"))
        self.assertEqual(got["A:0002"], ("match", "callers"))
        self.assertEqual(got["A:0003"], ("match", "roots"))  # the cycle stops the callers rule
        self.assertEqual(got["A:0004"], ("match", "roots"))
        self.assertEqual(got["A:0007"], ("match", "roots"))
        self.assertEqual(got["A:0005"], ("unknown", "unknown"))  # match and season callers
        self.assertEqual(got["A:0006"], ("unknown", "unknown"))  # nobody calls it

    def test_an_anchor_that_is_no_routine_is_refused(self):
        bad = (ANCHORS[0], {"A:0099": "match"})
        with mock.patch.object(index, "routines", return_value=ROUTINES), \
                mock.patch.object(index, "callers_of", return_value=CALLERS), \
                mock.patch.object(index, "anchors", return_value=bad):
            with self.assertRaises(SystemExit):
                index.index_96()


if __name__ == "__main__":
    unittest.main()
