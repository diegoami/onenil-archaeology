"""Checkpoint recovery of synthetic guest code and immutable decoded event chunks."""
import hashlib
import json
import struct
import sys
import tempfile
import unittest
from pathlib import Path
from unittest import mock

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / "runtime" / "emul"))
sys.path.insert(0, str(Path(__file__).resolve().parent))

import checkpoint  # noqa: E402
import guest  # noqa: E402
import match  # noqa: E402
from test_guest import machine  # noqa: E402


def week(g):
    w = match.Week.__new__(match.Week)
    w.g, w.events = g, []
    w.files_at_start = {"BASE.DAT": b"synthetic"}
    w.draws, w._pending = 0, None
    w.started, w.board = True, ("synthetic board", "a" * 64)
    w.screen_i, w.run_on, w.finished = 3, 7, False
    w.install_hooks()
    return w


class JournalTests(unittest.TestCase):
    def test_published_chunks_are_immutable_and_reconstruct_a_complete_trace(self):
        events = [{"kind": "start", "state": "synthetic"},
                  {"kind": "draw", "value": 7},
                  {"kind": "screen", "text": "synthetic \u2192"}]
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            first = checkpoint.Journal(root / "first.live")
            self.addCleanup(first.close)
            first.append(events[0])
            # Each append is visible on disk before the next checkpoint or normal termination.
            self.assertEqual(json.loads(first.path.read_bytes()), events[0])
            c0, c1 = root / "chunk0.jsonl", root / "chunk1.jsonl"
            info = first.chunk(c0)
            original = c0.read_bytes()
            self.assertEqual(info["sha256"], hashlib.sha256(original).hexdigest())
            self.assertEqual((info["offset"], info["length"]), (0, len(original)))
            first.append(events[1])
            info1 = first.chunk(c1)
            self.assertEqual((info1["offset"], info1["length"]), (len(original), c1.stat().st_size))
            self.assertEqual(c0.read_bytes(), original)
            self.assertEqual([json.loads(line) for line in c1.read_text().splitlines()], [events[1]])
            with self.assertRaises(FileExistsError):
                first.chunk(c0)
            with self.assertRaises(FileExistsError):
                checkpoint.Journal(first.path)

            restored = checkpoint.Journal(root / "restored.live", [c0, c1])
            self.addCleanup(restored.close)
            self.assertEqual(list(restored), events[:2])
            restored.append(events[2])
            c2 = root / "chunk2.jsonl"
            restored.chunk(c2)
            self.assertEqual([json.loads(line) for line in c2.read_text().splitlines()], [events[2]])
            final = root / "finished.jsonl"
            sha = restored.finish(final)
            self.assertEqual([json.loads(line) for line in final.read_text().splitlines()], events)
            self.assertEqual(sha, hashlib.sha256(final.read_bytes()).hexdigest())
            with self.assertRaises(FileExistsError):
                restored.finish(final)
            self.assertEqual(c0.read_bytes(), original)


class MachineCheckpointTests(unittest.TestCase):
    def roundtrip(self, w):
        with tempfile.TemporaryDirectory() as directory:
            path = Path(directory, "private-checkpoint.gz")
            state = checkpoint.capture(w)
            sha = checkpoint.write_private(path, state)
            self.assertEqual(sha, hashlib.sha256(path.read_bytes()).hexdigest())
            with self.assertRaises(FileExistsError):
                checkpoint.write_private(path, state)
            # Round-trip through disk to ensure mutable queues, audits and file handles belong to
            # independent machines, and that the Unicorn CPU context is actually serializable.
            restored = checkpoint.restore(checkpoint.read_private(path), match.Week, [])
        return restored

    def assert_machine_equal(self, original, restored):
        for name in ("eax", "ebx", "ecx", "edx", "esi", "edi", "ebp", "esp",
                     "eip", "eflags", "cs", "ss", "ds", "es", "fs", "gs"):
            self.assertEqual(original.g.reg(name), restored.g.reg(name), name)
        self.assertEqual(original.g.mem(0, 0x110000), restored.g.mem(0, 0x110000))
        self.assertEqual({k: v for k, v in vars(original.g).items() if k != "mu"},
                         {k: v for k, v in vars(restored.g).items() if k != "mu"})
        self.assertEqual({k: v for k, v in vars(original).items() if k not in ("g", "events")},
                         {k: v for k, v in vars(restored).items() if k not in ("g", "events")})

    def test_resume_preserves_timer_held_key_queues_file_handles_and_audits(self):
        g = machine(extra=[(0x700, b"TEST.DAT\0"), (0x800, b"abc")])
        g.files = {"BASE.DAT": b"synthetic"}
        g.put(0x1C * 4, struct.pack("<HH", 0, 0x2100))
        g.divisor = 0x400
        g.set_reg("ax", 0x3C00)
        g.set_reg("dx", 0x700)
        g.set_reg("cx", 0)
        g._intr(g.mu, 0x21, None)
        handle = g.reg("ax")
        g.set_reg("bx", handle)
        g.set_reg("cx", 3)
        g.set_reg("dx", 0x800)
        g.set_reg("ax", 0x4000)
        g._intr(g.mu, 0x21, None)
        g.set_reg("ax", 3)
        g._intr(g.mu, 0x33, None)
        w = week(g)
        with mock.patch.object(guest, "KEY_HOLD", 20_000):
            g.press("Down", "Return")
            g.run(max_steps=5_000)
            self.assertIsNotNone(g.held_since)
            self.assertTrue(g.scancodes)
            restored = self.roundtrip(w)
            self.assert_machine_equal(w, restored)
            # The held break and queued second key must fire at the same budgets after restore.
            for current in (w, restored):
                current.g.run(max_steps=80_000)
                current.g.put(0x800, b"DEF")
                for reg, value in (("ax", 0x4000), ("bx", handle), ("cx", 3), ("dx", 0x800)):
                    current.g.set_reg(reg, value)
                current.g._intr(current.g.mu, 0x21, None)
                current.g.set_reg("ax", 0x3E00)
                current.g._intr(current.g.mu, 0x21, None)
            self.assert_machine_equal(w, restored)
        self.assertEqual(g.files["TEST.DAT"], b"abcDEF")
        self.assertGreater(g.game_timer_ticks, 0)
        self.assertEqual([name for name, _ in g.keys_delivered], ["Down", "Return"])
        self.assertEqual(g.scancodes, [])
        self.assertEqual(g.handles, {})

    def test_pending_rng_call_survives_and_restored_week_hooks_emit_the_same_draw(self):
        # A synthetic far call to the hooked RNG-return address, followed by an infinite loop.
        # No original instruction bytes or private state are used.
        leave = 0x24BC * 16 + 0x0CFD
        g = machine(extra=[(0x10000, bytes.fromhex("9afd0cbc24ebfe")), (leave, b"\xcb")])
        g.put(0x900, struct.pack("<H", 42))
        g.set_reg("ax", 6)
        w = week(g)
        w.draws = 4
        w._pending = {"kind": "draw", "i": 4, "n": 8, "seed_before": 9,
                      "callers": ["synthetic"], "_ptr": 0x900}
        restored = self.roundtrip(w)
        self.assertEqual(restored._pending, w._pending)
        for current in (w, restored):
            current.g.run(max_steps=1_000)
        self.assertEqual(restored.events, w.events)
        self.assertEqual(restored.events, [{"kind": "draw", "i": 4, "n": 8,
                                           "seed_before": 9, "seed_after": 42, "value": 6,
                                           "callers": ["synthetic"]}])
        self.assertEqual(restored.draws, 5)
        self.assertIsNone(restored._pending)
        self.assert_machine_equal(w, restored)

    def test_guest_with_pending_error_cannot_be_checkpointed(self):
        w = week(machine())
        w.g.error = guest.GuestError("synthetic pending failure")
        with self.assertRaisesRegex(ValueError, "pending error"):
            checkpoint.capture(w)


if __name__ == "__main__":
    unittest.main()
