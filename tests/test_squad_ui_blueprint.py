"""Invented templates exercise fixed labels and gaps without original bytes."""
import importlib.util
from pathlib import Path
import struct

spec = importlib.util.spec_from_file_location("squad_blueprint", Path(__file__).resolve().parents[1]/"tools/static/squad_ui_blueprint.py")
ui = importlib.util.module_from_spec(spec)
spec.loader.exec_module(ui)


def model(text, start=1):
    return ui.ui.decode(struct.pack("<HBB", start, 1, len(text)) + text.encode("ascii"))


def test_gaps_split_fields_but_single_spaces_stay_in_labels():
    assert ui.fixed_spans(model("First name   Age     Team", 83)) == [
        dict(x=2,y=1,text="First name",truncated=False),
        dict(x=15,y=1,text="Age",truncated=False),
        dict(x=23,y=1,text="Team",truncated=False),
    ]


def test_leading_trailing_and_multiple_dynamic_gaps():
    assert ui.fixed_spans(model("   A  B   C   ")) == [
        dict(x=3,y=0,text="A",truncated=False),dict(x=6,y=0,text="B",truncated=False),
        dict(x=10,y=0,text="C",truncated=False),
    ]


def test_bounded_label_marks_truncation():
    assert ui.fixed_spans(model("A"*60)) == [dict(x=0,y=0,text="A"*48,truncated=True)]
    assert ui.fixed_spans(model("A"*48))[0]["truncated"] is False


def test_dynamic_gap_contents_do_not_change_asserted_spans():
    r=model("Age     Team",83)
    lines=[" "*80 for _ in range(25)]
    lines[1]="  Age 27  Team".ljust(80)
    assert ui.compare(r,lines)["labels_matched"] == 2
    lines[1]="   Age 27 Team".ljust(80)
    c=ui.compare(r,lines)
    assert c["labels_matched"] == 1
    assert c["label_mismatches"] == [dict(x=2,y=1,text="Age",truncated=False)]


def test_empty_templates_have_no_asserted_labels():
    assert ui.fixed_spans(model("     ")) == []


def test_overlay_projects_only_intersection_and_preserves_base():
    base=model("ABC",83)
    later=model("12345",81)
    composed=ui.overlay_component(base,later)
    assert [chr(c) for c,a in composed["cells"].values()] == list("345")
    assert [chr(c) for c,a in base["cells"].values()] == list("ABC")


def test_traced_dynamic_border_destination_does_not_hide_other_mismatches():
    import pytest
    r=ui.ui.decode(struct.pack("<HBB",1,1,3)+bytes([0xC4,0xC4,0xC4]))
    lines=[" "*80 for _ in range(25)]
    lines[0]="X─!".ljust(80)
    c=ui.compare(r,lines,[(0,0)])
    assert c["border_cells"] == 2 and c["border_mismatch_count"] == 1
    assert c["border_mismatch_sample"][0][:2] == (2,0)
    with pytest.raises(ValueError,match="outside"):
        ui.compare(r,lines,[(10,0)])
