import os
import random
import struct
import sys
import unittest

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(HERE)
sys.path.insert(0, os.path.join(ROOT, "tools"))
sys.path.insert(0, HERE)

import inventory  # noqa: E402
import lzexe_fixture as fx  # noqa: E402

RNG = random.Random(1)
SOURCE = bytes(RNG.randrange(256) for _ in range(4000))


class EmbedTests(unittest.TestCase):
    def setUp(self):
        self.index = inventory.EmbedIndex([("src", SOURCE)])

    def test_raw_window_is_found(self):
        hit = self.index.find(b"record " + SOURCE[100:100 + 64] + b" end")
        self.assertEqual(hit, ("raw", 7, "src"))

    def test_63_bytes_pass(self):
        self.assertIsNone(self.index.find(b"x" + SOURCE[100:163] + b"y"))

    def test_hex_in_either_case_and_spaced_is_found(self):
        chunk = SOURCE[500:500 + 64]
        for text in (chunk.hex(), chunk.hex().upper(), " ".join("%02x" % b for b in chunk),
                     "f" + chunk.hex()):  # odd phase
            with self.subTest(text=text[:20]):
                self.assertIsNotNone(self.index.find(('"' + text + '"').encode()))

    def test_digests_pass(self):
        import hashlib
        text = '"sha256": "%s"' % hashlib.sha256(SOURCE).hexdigest()
        self.assertIsNone(self.index.find(text.encode()))

    def test_runs_of_one_byte_pass(self):
        index = inventory.EmbedIndex([("zeros", b"\0" * 500 + SOURCE[:10])])
        self.assertIsNone(index.find(b"\0" * 200))


def tp_like_image():
    """A synthetic image laid out as a Turbo Pascal 7 program: entry far calls to System's init
    and a unit's init, a System segment with the markers, a unit with Crt's calibration."""
    img = bytearray(0x400)
    # segment 0000: entry: call far 0030:0000 (System), call far 0020:0000 (unit), retf
    img[0:5] = b"\x9a\x00\x00\x30\x00"
    img[5:10] = b"\x9a\x00\x00\x20\x00"
    img[10] = 0xCB
    # segment 0020: a unit: ENTER, Crt's tick wait and div by 55
    u = 0x200
    img[u:u + 4] = b"\xc8\x02\x00\x00"
    img[u + 0x10:u + 0x15] = inventory.CRT_TICK_WAIT
    img[u + 0x20:u + 0x25] = inventory.CRT_DIV55
    # segment 0030: System: mov dx,003C; mov ds,dx; the markers
    s = 0x300
    img[s:s + 5] = b"\xba\x3c\x00\x8e\xda"
    img[s + 0x20:s + 0x20 + len(inventory.TP_TEST8086)] = inventory.TP_TEST8086
    img[s + 0x40:s + 0x40 + len(inventory.TP_VECTORS)] = inventory.TP_VECTORS
    t = b"Runtime error Portions Copyright (c) 1983,92 Borland"
    img[s + 0x60:s + 0x60 + len(t)] = t
    # segment 003C: data
    relocs = [(0, 3), (0, 8), (0x30, 1)]
    return bytes(img), relocs


class MarkerTests(unittest.TestCase):
    def test_markers_of_a_synthetic_tp7_program(self):
        img, relocs = tp_like_image()
        exe = inventory.Exe(fx.build_lzexe(img, relocs=relocs, ip0=0, cs0=0))
        self.assertEqual(exe.segments, [0x00, 0x20, 0x30, 0x3C])
        m = inventory.tp_markers(exe)
        self.assertEqual(m["entry_far_calls"], ["0030:0000", "0020:0000"])
        self.assertEqual(m["system_segment"], "0030")
        self.assertEqual(m["data_segment"], "003C")
        self.assertEqual(m["test8086"], ["0030:0020"])
        self.assertEqual(m["saved_vectors"], ["0030:0040"])
        self.assertEqual(m["runtime_error_string"], ["0030:0060"])
        self.assertEqual(m["borland_copyright"]["at"], "0030:006E")
        self.assertEqual(m["crt_delay_calibration"], [{"tick_wait": "0020:0010", "div55": "0020:0020"}])
        self.assertEqual(m["far_routine_prologues"]["enter"], 1)

    def test_a_program_without_the_markers_has_none(self):
        img, relocs = tp_like_image()
        img = bytearray(img)
        img[0x320:0x320 + len(inventory.TP_TEST8086)] = b"\x90" * len(inventory.TP_TEST8086)
        img[0x340] = 0x01  # the vector list no longer matches
        m = inventory.tp_markers(inventory.Exe(fx.build_lzexe(bytes(img), relocs=relocs, ip0=0, cs0=0)))
        self.assertEqual(m["test8086"], [])
        self.assertEqual(m["saved_vectors"], [])


class DeltaTests(unittest.TestCase):
    def test_relocated_segment_shift_alone_is_same(self):
        img, relocs = tp_like_image()
        a = inventory.Exe(fx.build_lzexe(img, relocs=relocs, ip0=0, cs0=0))
        shifted = bytearray(img)
        struct.pack_into("<H", shifted, 3, 0x30)  # unchanged values: same layout
        b = inventory.Exe(fx.build_lzexe(bytes(shifted), relocs=relocs, ip0=0, cs0=0))
        rows = inventory.exe_delta(a, b)["segments_paired_by_order"]
        self.assertTrue(all(r["status"] == "same" for r in rows))

    def test_regions_in_place(self):
        r = inventory.regions(b"abcdefgh", b"abXdeYYh")
        self.assertEqual((r["bytes_differing"], r["regions"]), (3, 2))
        self.assertEqual(r["first_regions"], [["00002", 1], ["00005", 2]])


if __name__ == "__main__":
    unittest.main()

# A real producer/release/chain validation gates the UI-only exception. These
# synthetic records contain no private game bytes and use the public inventory.
import hashlib
import json
import pathlib
import subprocess

import pytest

UI_HEADING = b"Choose the player qualities, positions, ages and nationalities below."


def ui_evidence(root, text=UI_HEADING.decode(), extra=None):
    directory = root / 'runs/T55/session-r0001'
    directory.mkdir(parents=True)
    commit = subprocess.check_output(
        ['git', '-C', str(inventory.ROOT), 'rev-parse', 'HEAD'], text=True).strip()
    producer = subprocess.check_output(
        ['git', '-C', str(inventory.ROOT), 'show', commit + ':runtime/driver/manual_session.py'])
    releases = json.loads((inventory.ROOT / 'records/T01/inventory.json').read_text())
    header = dict(schema='original-ui-session/1', edition='96',
                  game_files={p['name']: p['sha256'] for p in releases['files'] if p['edition'] == '96'},
                  dosbox_version='2024.03.01', code_commit=commit,
                  source_sha256=hashlib.sha256(producer).hexdigest())
    def write(path, value):
        path.write_text(json.dumps(value, indent=2) + '\n')
    write(directory / 'session.json', header)
    previous = None
    for n in range(2):
        png = b'\x89PNG\r\n\x1a\nsynthetic-render-fixtureIEND\xaeB`\x82'
        name = f'step-{n:04d}.png'
        (directory / name).write_bytes(png)
        record = dict(number=n, previous=previous, id=f'S{n+1:03d}', keys=[],
                      text=text, text_sha256=hashlib.sha256(text.encode()).hexdigest(),
                      screenshot=name, screenshot_sha256=hashlib.sha256(png).hexdigest())
        if n == 1 and extra:
            record.update(extra)
        path = directory / f'step-{n:04d}.json'
        write(path, record)
        previous = hashlib.sha256(path.read_bytes()).hexdigest()
    write(directory / 'end.json', dict(status='completed', processes_exited=True,
                                       steps=2, last_step=previous))
    return directory / 'step-0001.json'


def test_authenticated_ui_exception_preserves_every_other_byte(tmp_path):
    path = ui_evidence(tmp_path)
    raw = path.read_bytes()
    index = inventory.EmbedIndex([('synthetic-executable', UI_HEADING)])
    assert index.find(raw) is not None
    scanned = inventory.embed_scan_bytes(path, root=tmp_path)
    assert scanned == raw.replace(json.dumps(UI_HEADING.decode()).encode(), b'""', 1)
    assert index.find(scanned) is None


@pytest.mark.parametrize('damage', [
    'text_digest', 'screenshot', 'chain', 'incomplete', 'source', 'release',
    'outside', 'height', 'width', 'duplicate_key', 'noncanonical',
])
def test_ui_exception_fails_closed(tmp_path, damage):
    text = UI_HEADING.decode()
    if damage == 'height':
        text = (text + '\n') * 26
    elif damage == 'width':
        text += 'x' * 81
    path = ui_evidence(tmp_path, text=text)
    if damage in ('text_digest', 'chain'):
        record = json.loads(path.read_text())
        record['text_sha256' if damage == 'text_digest' else 'previous'] = '0' * 64
        path.write_text(json.dumps(record, indent=2) + '\n')
    elif damage == 'screenshot':
        path.with_suffix('.png').write_bytes(b'changed screenshot')
    elif damage in ('incomplete', 'source', 'release'):
        target = path.parent / ('end.json' if damage == 'incomplete' else 'session.json')
        record = json.loads(target.read_text())
        if damage == 'incomplete':
            record['status'] = 'aborted'
        elif damage == 'source':
            record['source_sha256'] = '0' * 64
        else:
            record['game_files'] = {}
        target.write_text(json.dumps(record, indent=2) + '\n')
    elif damage == 'outside':
        outside = tmp_path / 'unrelated.json'
        outside.write_bytes(path.read_bytes())
        path = outside
    elif damage == 'duplicate_key':
        path.write_bytes(path.read_bytes().replace(b'{\n', b'{\n  "text": "duplicate",\n', 1))
    elif damage == 'noncanonical':
        path.write_text(json.dumps(json.loads(path.read_text()), indent=1))
    index = inventory.EmbedIndex([('synthetic-executable', UI_HEADING)])
    assert index.find(inventory.embed_scan_bytes(path, root=tmp_path)) is not None


@pytest.mark.parametrize('extra', [
    {'metadata': UI_HEADING.decode()},
    {'metadata': UI_HEADING.hex()},
    {'highlighted': [[0, UI_HEADING.decode()]]},
])
def test_ui_exception_still_scans_non_text_payloads(tmp_path, extra):
    path = ui_evidence(tmp_path, extra=extra)
    raw = path.read_bytes()
    scanned = inventory.embed_scan_bytes(path, root=tmp_path)
    assert scanned != raw  # authentication passed; only text was excluded
    index = inventory.EmbedIndex([('synthetic-executable', UI_HEADING)])
    assert index.find(scanned) is not None


def test_ui_authentication_cache_binds_exact_record_bytes(tmp_path):
    path = ui_evidence(tmp_path)
    cache = {}
    assert inventory.embed_scan_bytes(path, root=tmp_path, authenticated=cache) != path.read_bytes()
    record = json.loads(path.read_text())
    record['metadata'] = UI_HEADING.decode()
    path.write_text(json.dumps(record, indent=2) + '\n')
    assert inventory.embed_scan_bytes(path, root=tmp_path, authenticated=cache) == path.read_bytes()
