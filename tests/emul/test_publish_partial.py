"""Checkpoint publication uses real Git index/commit operations without network access."""
import subprocess
import sys
from pathlib import Path

import pytest

sys.path.insert(0, str(Path(__file__).resolve().parents[2] / "runtime" / "emul"))
import match

REAL_RUN = subprocess.run


def git(root, *args):
    return REAL_RUN(["git", "-C", str(root), *args], check=True,
                    text=True, capture_output=True).stdout.strip()


@pytest.fixture
def repo(tmp_path, monkeypatch):
    root = tmp_path / "repo"
    root.mkdir()
    git(root, "init", "-q")
    git(root, "config", "user.name", "Synthetic checkpoint test")
    git(root, "config", "user.email", "checkpoint@example.invalid")
    git(root, "config", "commit.gpgsign", "false")
    unrelated = root / "unrelated.txt"
    unrelated.write_text("baseline\n")
    git(root, "add", "unrelated.txt")
    git(root, "commit", "-qm", "baseline")
    unrelated.write_text("unrelated staged content\n")
    git(root, "add", "unrelated.txt")
    unrelated.write_text("unrelated unstaged content\n")
    monkeypatch.setattr(match, "ROOT", root)
    return root


def evidence(root, number):
    chunk = root / f"traces/chunk {number}.jsonl"
    receipt = root / f"runs/receipt {number}.json"
    chunk.parent.mkdir(exist_ok=True)
    receipt.parent.mkdir(exist_ok=True)
    chunk.write_text('{"kind":"synthetic"}\n')
    receipt.write_text('{"status":"aborted: synthetic checkpoint"}\n')
    return chunk, receipt, root / "private-not-uploaded.pkl.gz", f"checkpoints/{number}.pkl.gz"


def fake_network(monkeypatch, fail_push=False):
    network = []

    def run(command, **kwargs):
        if command[0] == "rclone" or (command[0] == "git" and "push" in command):
            network.append(command)
            if fail_push and command[0] == "git":
                raise subprocess.CalledProcessError(1, command)
            return subprocess.CompletedProcess(command, 0)
        return REAL_RUN(command, **kwargs)

    monkeypatch.setattr(match.subprocess, "run", run)
    return network


def test_failed_commit_unstages_only_its_pair_and_later_commit_is_clean(repo, monkeypatch):
    index_before = git(repo, "ls-files", "--stage")
    original_head = git(repo, "rev-parse", "HEAD")
    chunk, receipt, private, remote = evidence(repo, 1)
    hook = repo / ".git/hooks/pre-commit"
    hook.write_text("#!/bin/sh\nexit 1\n")
    hook.chmod(0o755)
    network = fake_network(monkeypatch)

    with pytest.raises(subprocess.CalledProcessError):
        match.publish_partial(chunk, receipt, private, remote)

    assert git(repo, "ls-files", "--stage") == index_before
    assert git(repo, "rev-parse", "HEAD") == original_head
    assert chunk.exists() and receipt.exists()
    assert len(network) == 1 and network[0][0] == "rclone"

    hook.unlink()
    second = evidence(repo, 2)
    match.publish_partial(*second)
    committed = set(git(repo, "show", "--pretty=format:", "--name-only", "HEAD").splitlines())
    assert committed == {str(p.relative_to(repo)) for p in second[:2]}
    assert git(repo, "diff", "--cached", "--name-only") == "unrelated.txt"
    assert git(repo, "show", ":unrelated.txt") == "unrelated staged content"
    assert (repo / "unrelated.txt").read_text() == "unrelated unstaged content\n"
    assert git(repo, "ls-files", "--", str(chunk), str(receipt)) == ""


def test_preexisting_staged_evidence_is_rejected_without_touching_index(repo, monkeypatch):
    args = evidence(repo, 1)
    git(repo, "add", "--", str(args[0]))
    index_before = git(repo, "ls-files", "--stage")
    network = fake_network(monkeypatch)
    with pytest.raises(match.guest.GuestError, match="already have staged changes"):
        match.publish_partial(*args)
    assert git(repo, "ls-files", "--stage") == index_before
    assert network == []


def test_push_failure_keeps_the_successful_commit_and_unrelated_staged_work(repo, monkeypatch):
    args = evidence(repo, 1)
    original_head = git(repo, "rev-parse", "HEAD")
    fake_network(monkeypatch, fail_push=True)
    with pytest.raises(subprocess.CalledProcessError):
        match.publish_partial(*args)
    assert git(repo, "rev-parse", "HEAD") != original_head
    committed = set(git(repo, "show", "--pretty=format:", "--name-only", "HEAD").splitlines())
    assert committed == {str(p.relative_to(repo)) for p in args[:2]}
    assert git(repo, "diff", "--cached", "--name-only") == "unrelated.txt"
    assert git(repo, "show", ":unrelated.txt") == "unrelated staged content"
