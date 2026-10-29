"""runtime/emul/corpus.py's index logic, on synthetic records and traces (no original bytes)."""
import hashlib
import json
import os
import sys
import tempfile
import unittest
from pathlib import Path

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
sys.path.insert(0, os.path.join(ROOT, "runtime", "emul"))

import corpus  # noqa: E402

A, B = "a" * 64, "b" * 64


def trace_text(status="completed", screens=("x", "y"), stop=False, result=True):
    evs = [{"kind": "start", "state_sha256": A}]
    for i, d in enumerate(screens):
        evs.append({"kind": "screen", "i": i, "digest": d, "draws": i * 10, "action": "space"})
    if stop:
        evs[-1]["action"] = "unknown screen: stop"
    evs.append({"kind": "end", "status": status, "draws": 42, "screens": len(screens),
                "result": {"teams": ["HOME", "AWAY"], "goals": [1, 0], "board_digest": "c" * 64} if result else None})
    return "".join(json.dumps(e, sort_keys=True) + "\n" for e in evs)


def run(rid, week_path, trace_path, text, status="completed", cmp="all of the record's 2 screens met in order",
        state=A):
    return {"run_id": rid, "status": status, "start_state": {"sha256": state},
            "actions": {"args": [state, "--compare", week_path]},
            "observations": [
                {"field": "the trace written, path", "value": trace_path},
                {"field": "the trace written, sha256", "value": hashlib.sha256(text.encode()).hexdigest()},
                {"field": "comparison with a DOSBox-X week record", "value": cmp}]}


WEEK1 = ("T04-week-r0001", "runs/T04/T04-week-r0001.json", A)
WEEK2 = ("T04-week-r0002", "runs/T04/T04-week-r0002.json", B)


class IndexTests(unittest.TestCase):
    def index(self, weeks, runs, traces):
        return corpus.build_index(weeks, runs, traces.__getitem__)

    def test_met_week(self):
        t = trace_text()
        idx = self.index([WEEK1], [run("T08-r0001", WEEK1[1], "t1", t)], {"t1": t})
        e = idx["entries"][0]
        self.assertEqual(e["verdict"], corpus.ALL_MET)
        self.assertEqual(e["result"], {"teams": ["HOME", "AWAY"], "goals": [1, 0]})
        self.assertEqual((e["draws"], e["t08_run"], e["trace"]), (42, "T08-r0001", "t1"))
        self.assertEqual(e["trace_sha256"], hashlib.sha256(t.encode()).hexdigest())
        self.assertEqual((idx["weeks"], idx["all_screens_met"]), (1, 1))

    def test_failed_comparison_names_the_screen(self):
        t = trace_text()
        cmp = "screen 1 (aaaa) = key wait 0\nscreen 2 (bbbb) not met in order\nnot all of the record's 3 screens met in order"
        r = run("T08-r0001", WEEK1[1], "t1", t, status="aborted: comparison failed (completed)", cmp=cmp)
        e = self.index([WEEK1], [r], {"t1": t})["entries"][0]
        self.assertEqual(e["verdict"], "screen 2 (bbbb) not met in order")

    def test_stopped_run_names_its_stop_screen(self):
        t = trace_text(status="stopped: unknown screen at key wait 1", stop=True, result=False)
        cmp = "screen 1 (aaaa) = key wait 0\nscreen 2 (bbbb) not met in order\nnot all of the record's 3 screens met in order"
        r = run("T08-r0001", WEEK1[1], "t1", t, status="aborted: comparison failed (stopped: ...)", cmp=cmp)
        e = self.index([WEEK1], [r], {"t1": t})["entries"][0]
        self.assertIn("screen 2 (bbbb) not met in order", e["verdict"])
        self.assertIn("stopped: unknown screen at key wait 1", e["verdict"])
        self.assertEqual(e["stopped_at"], {"key_wait": 1, "digest": "y", "draws": 10})
        self.assertIsNone(e["result"])

    def test_all_met_but_run_aborted_is_not_met(self):
        t = trace_text(status="stopped: no main menu after 60 key waits")
        r = run("T08-r0001", WEEK1[1], "t1", t, status="aborted: stopped: no main menu after 60 key waits")
        e = self.index([WEEK1], [r], {"t1": t})["entries"][0]
        self.assertNotEqual(e["verdict"], corpus.ALL_MET)
        self.assertIn("no main menu", e["verdict"])

    def test_unrun_week_listed_and_latest_run_indexed(self):
        t1, t2 = trace_text(), trace_text(screens=("x", "y", "z"))
        runs = [run("T08-r0002", WEEK1[1], "t2", t2), run("T08-r0001", WEEK1[1], "t1", t1)]
        idx = self.index([WEEK1, WEEK2], runs, {"t1": t1, "t2": t2})
        e1, e2 = idx["entries"]
        self.assertEqual((e1["t08_run"], e1["superseded_runs"]), ("T08-r0002", ["T08-r0001"]))
        self.assertEqual((e2["t04_record"], e2["verdict"]), ("T04-week-r0002", "not run"))
        self.assertEqual((idx["weeks"], idx["all_screens_met"]), (2, 1))

    def test_trace_changed_since_its_record_is_refused(self):
        t = trace_text()
        with self.assertRaises(ValueError):
            self.index([WEEK1], [run("T08-r0001", WEEK1[1], "t1", t)], {"t1": t + "\n"})

    def test_start_state_mismatch_is_flagged(self):
        t = trace_text()
        e = self.index([WEEK1], [run("T08-r0001", WEEK1[1], "t1", t, state=B)], {"t1": t})["entries"][0]
        self.assertTrue(e["verdict"].startswith("start state differs"))

    def test_week_records_keep_only_completed(self):
        with tempfile.TemporaryDirectory() as d:
            for n, st in ((1, "completed"), (2, "aborted: RuntimeError: an unknown screen (step 2); stopping"), (3, "completed")):
                Path(d, f"T04-week-r{n:04d}.json").write_text(json.dumps(
                    {"run_id": f"T04-week-r{n:04d}", "status": st, "start_state": {"sha256": A}}))
            Path(d, "T04-load-r0001.json").write_text(json.dumps({"run_id": "T04-load-r0001", "status": "completed"}))
            ids = [w[0] for w in corpus.week_records(d)]
        self.assertEqual(ids, ["T04-week-r0001", "T04-week-r0003"])


if __name__ == "__main__":
    unittest.main()
