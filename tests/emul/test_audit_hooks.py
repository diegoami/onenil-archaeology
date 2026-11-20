"""T98/#214: the numeric audit's operand hooks do not outlive their caller.

The behavioural proof is runs/T98/probe.py against the private boundary
checkpoint: with the hooks installed the week route dies at 2864:B941 on the
sixth key, and after close() the same machine reaches the menu with the
committed week facts. These tests keep the lifetime contract itself enforced
without private bytes.
"""
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT/'runtime/emul'))
# `postmatch_tail` imports modules that put `tools/static` on sys.path, which
# shadows the emulator's `replacement` module for every later import in a shared
# pytest process (match_continuity.py documents the same hazard). Resolve that
# name first so this test cannot reorder the suite; `ratings` and `listing`
# must keep resolving to `tools/static` for their own tests.
import replacement  # noqa: E402,F401
import postmatch_tail as tail  # noqa: E402


class Mu:
    def __init__(self):
        self.added, self.deleted = [], []

    def hook_add(self, kind, callback, begin=None, end=None):
        self.added.append(dict(kind=kind, begin=begin, end=end))
        return len(self.added)

    def hook_del(self, handle):
        self.deleted.append(handle)


def audit_with_hooks():
    audit = object.__new__(tail.NumericAudit)
    audit.hooks = []
    audit.stack_lo, audit.stack_hi = 0x43C00, 0x44200
    audit.week = type('Week', (), {'g': type('Guest', (), {'mu': Mu()})()})()
    audit.install()
    return audit


def test_install_keeps_the_three_handles_and_close_deletes_them():
    audit = audit_with_hooks()
    mu = audit.week.g.mu
    assert len(audit.hooks) == 3
    # Two read hooks split around the caller's stack window, plus one write hook.
    assert [row['kind'] for row in mu.added] == [
        tail.UC_HOOK_MEM_READ, tail.UC_HOOK_MEM_READ, tail.UC_HOOK_MEM_WRITE]
    assert (mu.added[0]['begin'], mu.added[0]['end']) == (0, audit.stack_lo - 1)
    assert (mu.added[1]['begin'], mu.added[1]['end']) == (audit.stack_hi, 0x10FFFF)
    audit.close()
    assert audit.hooks == []
    assert mu.deleted == [1, 2, 3]


def test_close_is_safe_twice():
    audit = audit_with_hooks()
    audit.close()
    audit.close()
    assert audit.week.g.mu.deleted == [1, 2, 3]


def test_every_driver_closes_the_audit_after_its_play_segment():
    drivers = ('postmatch_tail', 'sevilla_match', 'sevilla_week', 'fresh_postmatch')
    for name in drivers:
        lines = (ROOT/f'runtime/emul/{name}.py').read_text().splitlines()
        closes = [i for i, line in enumerate(lines) if 'audit.close()' in line]
        assert len(closes) == 1, name
        close = closes[0]
        plays = [i for i, line in enumerate(lines) if 'week.play(' in line]
        assert plays and min(plays) < close, name
        # Deleted once `Complete` has left the play segment, never from a callback.
        window = lines[max(0, close - 8):close]
        assert any('except Complete' in line or 'except tail.Complete' in line
                   for line in window), name
