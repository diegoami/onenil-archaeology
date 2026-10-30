"""CLI crash recovery without original bytes: a deterministic synthetic guest week."""
import hashlib
import json
import sys
from pathlib import Path
from unittest.mock import patch

import pytest

sys.path.insert(0, str(Path(__file__).resolve().parents[2] / "runtime" / "emul"))
import match
from test_guest import machine


class SyntheticWeek(match.Week):
    def __init__(self, data):
        self.g = machine()
        self.g.press("Return")
        self.files_at_start = {}
        self.events = []
        self.draws = self.screen_i = self.run_on = 0
        self.started = self.finished = False
        self.board = self._pending = None

    def install_hooks(self):
        pass  # the synthetic program has no One-Nil routines

    def play(self, max_screens=60, on_boundary=None):
        while self.screen_i < 4:
            on_boundary(self)
            self.g.run(max_steps=20_000)
            self.events.append({"kind": "draw", "i": self.draws, "value": self.g.budget})
            self.draws += 1
            self.events.append({"kind": "screen", "i": self.screen_i,
                                "digest": hashlib.sha256(self.g.mem(0, 0x110000)).hexdigest()})
            self.screen_i += 1
        self.finished = True

    def state_digests(self):
        return {"synthetic-memory": hashlib.sha256(self.g.mem(0, 0x110000)).hexdigest()}


def run(root, args):
    with patch.object(match, "ROOT", root), patch.object(match, "Week", SyntheticWeek), \
         patch.object(match, "signature", return_value={"unicorn": "test", "constants": {}}), \
         patch.object(match, "git", side_effect=lambda *a: {"rev-parse": "abc123", "branch": "fix/test"}.get(a[0], "")), \
         patch.object(match, "find_state", return_value=(root / "state.sav", b"synthetic state")):
        return match.main(args)


def test_interrupted_resume_reproduces_trace_and_preserves_evidence(tmp_path):
    full, stopped = tmp_path / "full", tmp_path / "stopped"
    assert run(full, ["--state", "abc"]) == 0
    assert run(stopped, ["--state", "abc", "--checkpoint-seconds", "0.000001",
                         "--stop-after-checkpoints", "2"]) == 1
    receipt = sorted((stopped / "runs/T06/partial").glob("*.json"))[-1]
    before = {p: p.read_bytes() for p in stopped.rglob("*") if p.is_file()}
    assert run(stopped, ["--resume", str(receipt)]) == 0
    for path, data in before.items():
        assert path.read_bytes() == data
    complete_trace = next((full / "traces/T06").glob("*.jsonl"))
    resumed_trace = sorted((stopped / "traces/T06").glob("*.jsonl"))[-1]
    assert resumed_trace.read_bytes() == complete_trace.read_bytes()
    records = sorted((stopped / "runs/T06").glob("*.json"))
    assert [json.loads(p.read_text())["status"] for p in records] == [
        "aborted: stopped: GuestError: requested checkpoint stop", "completed"]
    assert json.loads(records[-1].read_text())["actions"]["resumed_from"]


def test_resume_rejects_changed_chunk_or_runtime(tmp_path):
    import pytest
    assert run(tmp_path, ["--state", "abc", "--stop-after-checkpoints", "1"]) == 1
    receipt = next((tmp_path / "runs/T06/partial").glob("*.json"))
    rec = json.loads(receipt.read_text())
    cp = rec["outputs"][0]["value"]
    with patch.object(match, "ROOT", tmp_path), patch.object(match, "git", return_value=""), \
         patch.object(match, "signature", return_value={"different": "code"}):
        with pytest.raises(SystemExit, match="settings differ"):
            match.main(["--resume", str(receipt)])
    chunk = tmp_path / cp["chunks"][0]["path"]
    chunk.write_text("corrupt\n")
    with pytest.raises(SystemExit, match="chunk length differs"):
        run(tmp_path, ["--resume", str(receipt)])


def test_orphaned_partial_reserves_run_and_trace_numbers(tmp_path):
    assert run(tmp_path, ["--state", "abc", "--stop-after-checkpoints", "1"]) == 1
    next((tmp_path / "runs/T06").glob("*.json")).unlink()  # emulate death before final receipt
    next((tmp_path / "traces/T06").glob("*.jsonl")).unlink()
    assert run(tmp_path, ["--state", "abc"]) == 0
    assert (tmp_path / "runs/T06/T06-r0002.json").exists()
    assert len(list((tmp_path / "traces/T06").glob("*-r0002.jsonl"))) == 1


def test_publication_failure_retains_resumable_partial_and_aborted_receipt(tmp_path):
    with patch.object(match, "publish_partial", side_effect=OSError("synthetic upload failure")):
        assert run(tmp_path, ["--state", "abc", "--publish-checkpoints"]) == 1
    receipt = next((tmp_path / "runs/T06/partial").glob("*.json"))
    final = json.loads((tmp_path / "runs/T06/T06-r0001.json").read_text())
    assert final["status"] == "aborted: stopped: OSError: synthetic upload failure"
    assert run(tmp_path, ["--resume", str(receipt)]) == 0


def test_comparison_errors_close_journal_and_write_valid_aborted_receipt(tmp_path):
    import checkpoint
    sys.path.insert(0, str(Path(__file__).resolve().parents[2] / "runtime"))
    import validate

    closed = []
    original_close = checkpoint.Journal.close

    def close(journal):
        original_close(journal)
        closed.append(journal.f.closed)

    for reference, content, error in (("missing.json", None, "FileNotFoundError"),
                                      ("bad.json", "{", "JSONDecodeError")):
        root = tmp_path / error
        root.mkdir()
        if content is not None:
            (root / reference).write_text(content)
        with patch.object(checkpoint.Journal, "close", close):
            assert run(root, ["--state", "abc", "--compare", reference]) == 1
        path = root / "runs/T06/T06-r0001.json"
        rec = json.loads(path.read_text())
        assert rec["status"] == "aborted: comparison failed (completed)"
        assert error in rec["observations"][-1]["value"]
        assert (root / rec["observations"][0]["value"]).exists()
        assert validate.check(path, {}) == []
    assert closed == [True, True]


def test_resume_resolves_stored_comparison_against_root_from_another_cwd(tmp_path, monkeypatch):
    root, elsewhere = tmp_path / "repo", tmp_path / "elsewhere"
    root.mkdir()
    elsewhere.mkdir()
    reference = root / "comparison.json"
    reference.write_text(json.dumps({"start_state": {"sha256": hashlib.sha256(b"synthetic state").hexdigest()},
                                     "observations": []}))
    assert run(root, ["--state", "abc", "--compare", "comparison.json", "--stop-after-checkpoints", "1"]) == 1
    receipt = next((root / "runs/T06/partial").glob("*.json"))
    monkeypatch.chdir(elsewhere)
    assert run(root, ["--resume", str(receipt)]) == 0
    assert json.loads((root / "runs/T06/T06-r0002.json").read_text())["status"] == "completed"


def test_resume_rejects_experiment_override_before_creating_outputs(tmp_path, capsys):
    assert run(tmp_path, ["--state", "abc", "--stop-after-checkpoints", "1"]) == 1
    receipt = next((tmp_path / "runs/T06/partial").glob("*.json"))
    before = {p: p.read_bytes() for p in tmp_path.rglob("*") if p.is_file()}
    with pytest.raises(SystemExit, match="2"):
        run(tmp_path, ["--resume", str(receipt), "--experiment", "T99"])
    assert "--experiment differs from the checkpoint" in capsys.readouterr().err
    assert before == {p: p.read_bytes() for p in tmp_path.rglob("*") if p.is_file()}
    assert run(tmp_path, ["--resume", str(receipt), "--experiment", "T06"]) == 0


@pytest.mark.parametrize("tamper", ["middle", "last", "reorder", "overlap", "length", "reindex"])
def test_resume_rejects_noncontiguous_or_modified_manifest_before_outputs(tmp_path, tamper):
    assert run(tmp_path, ["--state", "abc", "--checkpoint-seconds", "0.000001",
                          "--stop-after-checkpoints", "3"]) == 1
    receipt = sorted((tmp_path / "runs/T06/partial").glob("*.json"))[-1]
    rec = json.loads(receipt.read_text())
    cp = rec["outputs"][0]["value"]
    chunks = cp["chunks"]
    assert len(chunks) == 3
    if tamper == "middle":
        del chunks[1]
    elif tamper == "last":
        chunks.pop()
    elif tamper == "reorder":
        chunks[0], chunks[1] = chunks[1], chunks[0]
    elif tamper == "overlap":
        chunks[1]["offset"] = 0
    elif tamper == "length":
        chunks[1]["length"] += 1
    else:
        # Even a self-consistent shortened manifest must match the private image's manifest.
        chunks.pop()
        cp["trace_bytes"] = sum(c["length"] for c in chunks)
    receipt.write_text(json.dumps(rec))
    before = {p: p.read_bytes() for p in tmp_path.rglob("*") if p.is_file()}
    with pytest.raises(SystemExit, match="manifest"):
        run(tmp_path, ["--resume", str(receipt)])
    assert before == {p: p.read_bytes() for p in tmp_path.rglob("*") if p.is_file()}


def test_resume_rejects_same_length_chunk_content_change(tmp_path):
    assert run(tmp_path, ["--state", "abc", "--stop-after-checkpoints", "1"]) == 1
    receipt = next((tmp_path / "runs/T06/partial").glob("*.json"))
    cp = json.loads(receipt.read_text())["outputs"][0]["value"]
    path = tmp_path / cp["chunks"][0]["path"]
    content = path.read_bytes()
    path.write_bytes(b"!" + content[1:])
    with pytest.raises(SystemExit, match="chunk digest differs"):
        run(tmp_path, ["--resume", str(receipt)])
