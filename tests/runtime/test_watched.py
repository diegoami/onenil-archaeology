"""runtime/driver/watched.py: which key a still screen gets (T10). No DOSBox-X needed."""
import os
import sys
import unittest
import hashlib
import json
import tempfile
from pathlib import Path
from types import SimpleNamespace
from unittest import mock

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
sys.path.insert(0, os.path.join(ROOT, "runtime", "driver"))

import watched  # noqa: E402

sys.path.insert(0, os.path.join(ROOT, "runtime"))
import validate  # noqa: E402

sys.path.insert(0, os.path.join(ROOT, "runtime", "emul"))
try:
    import guest  # noqa: E402
    import match  # noqa: E402
except ImportError:  # unicorn not installed
    match = None


class Classify(unittest.TestCase):
    def test_known_screens(self):
        self.assertEqual(watched.classify("GAME NAME: SAVE1  PLAY NEXT GAME")[0], "menu")
        self.assertEqual(watched.classify("PLAY GAME\nChange tactics")[0], "PLAY GAME")
        self.assertEqual(watched.classify("x\n   press any key")[0], "space")
        self.assertEqual(watched.classify("or any other key to continue")[0], "space")
        self.assertEqual(watched.classify("PLAYER CONTRACT")[0], "Return")
        self.assertEqual(watched.classify("commentary\n spacebar-view commentary  P-print commentary  any other key to exit")[0], "n")
        self.assertEqual(watched.classify("Do you want to print the match commentary (Y/N) ?")[0], "n")

    def test_a_match_without_a_prompt_is_not_answered_at_once(self):
        self.assertIsNone(watched.classify("FRIENDLY #1 ---- commentary ----"))
        self.assertTrue(watched.is_match("FRIENDLY #1 ---- commentary ----"))
        self.assertFalse(watched.is_match("a team screen"))


class InterruptedRun(unittest.TestCase):
    def exercise(self, directory, *, launch_interrupt=False, terminate_error=False, save_error=False):
        root = Path(directory)
        sc = SimpleNamespace(text=lambda: "synthetic menu", digest=lambda: "c" * 64)
        d = mock.Mock()
        d.launch.side_effect = KeyboardInterrupt() if launch_interrupt else None
        d.launch.return_value = sc
        d.last_blob = None if launch_interrupt else b"synthetic-state-for-interruption-test"
        d.events = [{"event": "synthetic read"}]
        d.conf_public.return_value = ("synthetic config", "b" * 64)
        if terminate_error:
            d.terminate.side_effect = RuntimeError("synthetic cleanup failure")

        def interrupt_play(driver, obs, keys, run_id):
            obs.append({"step": 1, "source": "log", "field": "partial progress", "value": "retained"})
            keys.append("synthetic key")
            raise KeyboardInterrupt()

        with mock.patch.object(watched, "ROOT", root), \
             mock.patch.object(watched, "STATES", root / "private-states"), \
             mock.patch.object(watched, "start_state", return_value=SimpleNamespace(config={}, sha256="a" * 64)), \
             mock.patch.object(watched, "play_week", side_effect=interrupt_play), \
             mock.patch.object(watched.cycle, "git", side_effect=lambda *args: "" if args[0] == "status" else "abc1234"), \
             mock.patch.object(watched.cycle, "machine_id", return_value="synthetic-machine"), \
             mock.patch.object(watched.cycle, "fingerprint", return_value={"dosbox-x": "synthetic"}), \
             mock.patch.object(watched.driver, "verify_release", return_value="synthetic"), \
             mock.patch.object(watched.driver, "host_times", return_value={"utc": "2026-10-30T10:00:00Z"}), \
             mock.patch.object(watched.driver, "Driver", return_value=d), \
             mock.patch.object(watched.traceback, "print_exc"):
            if save_error:
                with mock.patch.object(watched, "keep_state", side_effect=OSError("synthetic disk failure")):
                    status = watched.main(["--state", "synthetic-start.sav", "--out", "receipts"])
            else:
                status = watched.main(["--state", "synthetic-start.sav", "--out", "receipts"])
        d.terminate.assert_called_once()
        self.assertEqual(status, 1)
        receipts = sorted((root / "receipts").glob("T10-r*.json"))
        path = receipts[-1]
        self.assertEqual(validate.check(path, {}), [])
        rec = json.loads(path.read_text())
        self.assertTrue(rec["status"].startswith("aborted: KeyboardInterrupt"))
        return path, rec

    def test_keyboard_interrupt_retains_partial_receipt_state_and_unique_run(self):
        with tempfile.TemporaryDirectory() as directory:
            first, rec = self.exercise(directory)
            original = first.read_bytes()
            self.assertIn({"step": 1, "source": "log", "field": "partial progress", "value": "retained"},
                          rec["observations"])
            self.assertEqual(rec["actions"]["keys"], ["synthetic key"])
            saved = Path(directory, "private-states", "T10-r0001-end.sav").read_bytes()
            self.assertEqual(saved, b"synthetic-state-for-interruption-test")
            self.assertIn(hashlib.sha256(saved).hexdigest(),
                          [o["value"] for o in rec["observations"] if o["source"] == "save"])
            second, _ = self.exercise(directory)
            self.assertEqual(second.name, "T10-r0002.json")
            self.assertEqual(first.read_bytes(), original)

    def test_launch_interruption_without_state_still_writes_valid_receipt(self):
        with tempfile.TemporaryDirectory() as directory:
            _, rec = self.exercise(directory, launch_interrupt=True)
            self.assertTrue(any(o["field"] == "last savestate unavailable" for o in rec["observations"]))

    def test_termination_or_save_failure_does_not_discard_receipt(self):
        for failure in ("terminate_error", "save_error"):
            with self.subTest(failure=failure), tempfile.TemporaryDirectory() as directory:
                _, rec = self.exercise(directory, **{failure: True})
                self.assertTrue(any(o["field"] == "failure during " + (
                    "driver termination" if failure == "terminate_error" else "saving the last state")
                    for o in rec["observations"]))



@unittest.skipIf(match is None, "unicorn not installed")
class HarnessRunOn(unittest.TestCase):
    PITCH = "pitch\n  ↓↑-display ←→-speed 23     R-result   spacebar-commentary  F9  Esc-bench"

    def g(self, caller):
        return type("G", (), {"wait_caller": caller})()

    def test_the_running_pitch_gets_no_key(self):
        self.assertTrue(match.watched_pitch_running(self.g("1998:00F1"), self.PITCH))

    def test_a_readkey_wait_or_a_prompt_is_a_key_wait(self):
        self.assertFalse(match.watched_pitch_running(self.g(guest.READKEY_LOOP), self.PITCH))
        self.assertFalse(match.watched_pitch_running(self.g("1998:00F1"), self.PITCH + "\npress any key"))
        self.assertFalse(match.watched_pitch_running(self.g("1998:00F1"), "commentary versus press any key"))


    def test_week_keeps_its_end_methods(self):
        # T10: a misplaced edit once moved these out of Week, and a 2-hour run failed at its end
        self.assertTrue(callable(getattr(match.Week, "files_written", None)))
        self.assertTrue(callable(getattr(match.Week, "state_digests", None)))

    def test_compact_services_keeps_the_reported_set(self):
        g = type("G", (), {})()
        g.services = [(0x33, 3, "a"), (0x33, 3, "b"), (0x33, 4, "c"), (0x21, 0x3C00, "d"), (0x21, 0x3C05, "e")]
        match.compact_services(g)
        self.assertEqual(g.services, [(0x33, 3, "a"), (0x33, 4, "c"), (0x21, 0x3C00, "d")])


if __name__ == "__main__":
    unittest.main()
