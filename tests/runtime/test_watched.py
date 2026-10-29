"""runtime/driver/watched.py: which key a still screen gets (T10). No DOSBox-X needed."""
import os
import sys
import unittest

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
sys.path.insert(0, os.path.join(ROOT, "runtime", "driver"))

import watched  # noqa: E402


class Classify(unittest.TestCase):
    def test_known_screens(self):
        self.assertEqual(watched.classify("GAME NAME: SAVE1  PLAY NEXT GAME")[0], "menu")
        self.assertEqual(watched.classify("PLAY GAME\nChange tactics")[0], "PLAY GAME")
        self.assertEqual(watched.classify("x\n   press any key")[0], "space")
        self.assertEqual(watched.classify("or any other key to continue")[0], "space")
        self.assertEqual(watched.classify("PLAYER CONTRACT")[0], "Return")
        self.assertEqual(watched.classify("Do you want to print the match commentary (Y/N) ?")[0], "n")

    def test_a_match_without_a_prompt_is_not_answered_at_once(self):
        self.assertIsNone(watched.classify("FRIENDLY #1 ---- commentary ----"))
        self.assertTrue(watched.is_match("FRIENDLY #1 ---- commentary ----"))
        self.assertFalse(watched.is_match("a team screen"))


if __name__ == "__main__":
    unittest.main()
