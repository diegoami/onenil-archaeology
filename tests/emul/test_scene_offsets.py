"""T97 keeps T96's scene-offset audit a gate, not a manual command."""
import importlib.util
from pathlib import Path

import pytest

ROOT = Path(__file__).resolve().parents[2]
AUDIT = ROOT/'runs/T23/audit_scene_offsets.py'


def audit_module():
    spec = importlib.util.spec_from_file_location('audit_scene_offsets', AUDIT)
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module


def test_pinned_corpus_audit_passes(monkeypatch):
    # The audit re-reads the six committed T23 records and checks their digests
    # against its own pin; nothing original is executed and nothing is written.
    monkeypatch.setattr('sys.argv', ['audit_scene_offsets.py', '--check'])
    assert audit_module().main() == 0


def test_a_changed_record_digest_is_refused(monkeypatch):
    # The pin must be load-bearing: a record that no longer matches refuses,
    # so the A8A0 qualification cannot silently outlive the corpus it cites.
    module = audit_module()
    damaged = dict(module.DIGESTS)
    damaged['T23-r0001.json'] = '0' * 64
    monkeypatch.setattr(module, 'DIGESTS', damaged)
    with pytest.raises(SystemExit, match='digest differs'):
        module.audit()
