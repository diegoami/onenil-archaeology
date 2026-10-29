import json
import os
import sys
import tempfile
import unittest

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
sys.path.insert(0, os.path.join(ROOT, "runtime", "driver"))
sys.path.insert(0, os.path.join(ROOT, "runtime"))

import savestate  # noqa: E402
import screens  # noqa: E402
import validate  # noqa: E402


def screen_with(row_texts, highlight_row=None, bar_row=None):
    chars, attrs = bytearray(b" " * 2000), bytearray([0x07] * 2000)
    for r, t in row_texts.items():
        chars[r * 80 + 56:r * 80 + 56 + len(t)] = t.encode("cp437")
    if highlight_row is not None:
        attrs[highlight_row * 80 + 56:highlight_row * 80 + 74] = bytes([0x70]) * 18
    if bar_row is not None:
        chars[bar_row * 80 + 10:bar_row * 80 + 26] = bytes([0xFE]) * 16
        attrs[bar_row * 80 + 10:bar_row * 80 + 26] = bytes([0x70]) * 16
    return savestate.Screen(chars, attrs)


class ScreensTests(unittest.TestCase):
    def test_the_highlighted_item(self):
        sc = screen_with({4: "PLAY NEXT GAME", 6: "Players"}, highlight_row=6, bar_row=9)
        self.assertEqual(screens.highlighted(sc), [(6, "Players")])  # the bar of 0x70 cells is no item

    def test_select_presses_until_the_item_is_highlighted(self):
        frames = [screen_with({4: "A item", 6: "B item"}, highlight_row=4),
                  screen_with({4: "A item", 6: "B item"}, highlight_row=6)]

        class Fake:
            pressed = []
            def screen(self):
                return frames[min(len(self.pressed), 1)]
            def keys(self, k):
                self.pressed.append(k)
            def log(self, _):
                pass

        f = Fake()
        screens.select(f, "B item", pause=0)
        self.assertEqual(f.pressed, ["Down"])


def record(**over):
    rec = {"schema": "run/1", "run_id": "T04-r0001", "experiment": "T04", "arm": "a", "rep": 1, "code_commit": "abc",
           "machine": "m", "artifact": {}, "runtime": {}, "interventions": [], "start_state": {"sha256": None},
           "actions": {}, "observations": [{"step": 0, "source": "screen", "field": "x, sha256", "value": "0" * 64}],
           "outputs": [], "started": "2026-10-29T10:00:00Z", "ended": "2026-10-29T10:01:00Z", "status": "completed"}
    rec.update(over)
    return rec


class ValidateTests(unittest.TestCase):
    def check(self, rec, name="T04-r0001.json"):
        with tempfile.TemporaryDirectory() as d:
            p = os.path.join(d, name)
            with open(p, "w") as f:
                json.dump(rec, f)
            return validate.check(p, {})

    def test_a_good_record(self):
        self.assertEqual(self.check(record()), [])

    def test_faults_are_found(self):
        self.assertTrue(self.check(record(status="half done")))
        self.assertTrue(self.check(record(), name="other.json"))
        self.assertTrue(self.check(record(observations=[{"step": 0, "source": "screen", "field": "y, sha256", "value": "nothex"}])))
        self.assertTrue(self.check(record(arm="/home/someone/x")))
        self.assertTrue(self.check(record(started="2026-10-29T11:00:00Z")))

    def test_a_long_value_fails_unless_it_is_a_log(self):
        big = "x" * 70000
        self.assertTrue(self.check(record(observations=[{"step": 0, "source": "ui-text", "field": "t", "value": big}])))
        self.assertEqual(self.check(record(observations=[{"step": 0, "source": "log", "field": "events", "value": big}])), [])


if __name__ == "__main__":
    unittest.main()
