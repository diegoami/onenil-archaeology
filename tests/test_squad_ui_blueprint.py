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
