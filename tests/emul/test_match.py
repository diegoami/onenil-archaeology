import json
import os
import sys
import tempfile
import unittest

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
sys.path.insert(0, os.path.join(ROOT, "runtime", "emul"))

import match  # noqa: E402

STATE = "a" * 64


def record(digests, state=STATE):
    return {"start_state": {"sha256": state},
            "observations": [{"field": f"screen {k}: text screen 80x25, chars+attributes (4000 bytes), sha256", "value": d}
                             for k, d in enumerate(digests, 1)]}


def trace(digests):
    return [{"kind": "screen", "i": i, "digest": d} for i, d in enumerate(digests)]


class CompareTests(unittest.TestCase):
    def check(self, rec, tr, state=STATE):
        with tempfile.TemporaryDirectory() as d:
            p = os.path.join(d, "r.json")
            with open(p, "w") as f:
                json.dump(rec, f)
            return match.compare(tr, state, p)[0]

    def test_in_order_with_extra_screens_between(self):
        self.assertTrue(self.check(record(["b", "c", "d"]), trace(["a", "b", "x", "c", "d", "e"])))

    def test_reversed_order_fails(self):
        self.assertFalse(self.check(record(["b", "c", "d"]), trace(["d", "c", "b"])))

    def test_one_screen_for_several_fails(self):
        self.assertFalse(self.check(record(["b", "b", "b"]), trace(["b"])))
        self.assertFalse(self.check(record(["b", "c"]), trace(["b", "b", "b"])))

    def test_another_start_state_fails(self):
        self.assertFalse(self.check(record(["b"], state="c" * 64), trace(["b"])))


if __name__ == "__main__":
    unittest.main()
