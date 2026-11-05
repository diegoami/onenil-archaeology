"""Screen bytecode semantics from 24BC:0000, exercised with invented resources."""
import importlib.util
from pathlib import Path
import struct

import pytest

ROOT = Path(__file__).resolve().parents[1]
spec = importlib.util.spec_from_file_location("ui_blueprint", ROOT / "tools/static/ui_blueprint.py")
ui = importlib.util.module_from_spec(spec)
spec.loader.exec_module(ui)


def resource(body, start=1, height=1, width=None):
    return struct.pack("<HBB", start, height, width or len(body)) + body


def test_linear_start_and_physical_row_stride():
    r = ui.decode(resource(b"ABCDEF", start=83, height=2, width=3))
    assert (r["x"], r["y"], r["width"], r["height"]) == (2, 1, 3, 2)
    assert {p: chr(c) for p, (c, a) in r["cells"].items()} == {
        (2, 1): "A", (3, 1): "B", (4, 1): "C",
        (2, 2): "D", (3, 2): "E", (4, 2): "F",
    }
    assert r["consumed"] == 10


def test_literal_attribute_and_additional_copy_count():
    r = ui.decode(resource(b"\xff\x07A\x00\x02\xff\x02B", width=4))
    assert list(r["cells"].values()) == [(65, 7), (65, 7), (65, 7), (66, 2)]


@pytest.mark.parametrize("count,width,expected", [
    (1, 3, [(65, 7), (65, 7), (66, 7)]),
    (0, 2, [(65, 7), (66, 7)]),
])
def test_repeat_restores_previous_attribute_even_for_zero_count(count, width, expected):
    r = ui.decode(resource(b"\xff\x07A\xff\x02\x00" + bytes([count]) + b"B", width=width))
    assert list(r["cells"].values()) == expected


def test_previous_word_initially_zero():
    r = ui.decode(resource(b"\xff\x07\x00\x01A", width=2))
    assert list(r["cells"].values()) == [(0, 0), (65, 0)]
    assert ui.glyph(0) == " "


def test_region_completion_does_not_consume_next_resource():
    a = resource(b"A")
    r = ui.decode(a + resource(b"B"))
    assert r["consumed"] == len(a)
    assert list(ui.decode(a + resource(b"B"), len(a))["cells"].values()) == [(66, 0)]


@pytest.mark.parametrize("data", [
    b"", b"\x01\x00\x01", resource(b"A", width=2),
    resource(b"\xff", width=1), resource(b"\x00", width=1),
    resource(b"A\x00\x02", width=2),
    resource(b"A", start=0), resource(b"A", start=2001),
    resource(b"A", start=80, width=2), resource(b"A", start=1921, height=2),
    struct.pack("<HBB", 1, 0, 1), struct.pack("<HBB", 1, 1, 0),
])
def test_rejects_malformed_or_out_of_canvas_resources(data):
    with pytest.raises(ValueError):
        ui.decode(data)


def test_static_label_coordinates_and_border_comparison():
    r = ui.decode(resource(b"\xdaName \xbf", start=83, width=7))
    assert ui.labels(r) == [dict(x=3, y=1, text="Name", truncated=False)]
    lines = [" " * 80 for _ in range(25)]
    lines[1] = "  ┌Name ┐".ljust(80)
    c = ui.compare(r, lines)
    assert (c["label_count"], c["labels_matched"], c["border_cells"], c["borders_matched"]) == (1, 1, 2, 2)
    lines[1] = " " * 80
    c = ui.compare(r, lines)
    assert len(c["label_mismatches"]) == 1 and c["border_mismatch_count"] == 2


def test_later_resource_replaces_border_cells_without_mutating_base():
    base = ui.decode(resource(b"\xba   \xba", width=5))
    overlay = ui.decode(resource(b"\xc7", start=1))
    combined = ui.compose(base, overlay)
    assert combined["cells"][(0, 0)][0] == 0xC7
    assert base["cells"][(0, 0)][0] == 0xBA
    assert combined["cells"][(4, 0)] == base["cells"][(4, 0)]
    with pytest.raises(ValueError, match="outside"):
        ui.compose(base, ui.decode(resource(b"X", start=81)))
