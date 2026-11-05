#!/usr/bin/env python3
"""Recover fixed squad/preparation spans from original screen templates."""
import argparse
import importlib.util
import json
from pathlib import Path
import re
import subprocess

ROOT = Path(__file__).resolve().parents[2]
TOOL = "tools/static/squad_ui_blueprint.py"
DECODER = "tools/static/ui_blueprint.py"
spec = importlib.util.spec_from_file_location("template_decoder", ROOT / DECODER)
ui = importlib.util.module_from_spec(spec)
spec.loader.exec_module(ui)


def fixed_spans(model):
    """Split only at actual template gaps of two or more spaces; cap labels at48."""
    result = []
    for y in range(model["y"], model["y"] + model["height"]):
        row = "".join(ui.glyph(model["cells"][(x, y)][0])
                      for x in range(model["x"], model["x"] + model["width"]))
        for region in re.finditer(r"[A-Za-z0-9][A-Za-z0-9 ./#,'?!:()+-]*", row):
            for span in re.finditer(r"\S+(?: \S+)*", region.group().rstrip()):
                label = span.group()
                result.append(dict(x=model["x"] + region.start() + span.start(), y=y,
                                   text=label[:48], truncated=len(label) > 48))
    return result


def compare(model, lines):
    result = ui.compare(model, lines)
    labels = fixed_spans(model)
    mismatches = [s for s in labels if lines[s["y"]][s["x"]:s["x"] + len(s["text"])] != s["text"]]
    result.update(labels=labels, label_count=len(labels), labels_matched=len(labels)-len(mismatches),
                  label_mismatches=mismatches)
    return result


def analyse():
    data, covered, paths = ui.data_segment()
    resources = []
    for name, address, caller, captured in [
        ("player_details", 0x6734, "0AB9:8D6F", "runs/T45/session-r0001/step-0004.json"),
        ("player_skills", 0x1D5E, "1B55:478C", "runs/T45/session-r0001/step-0003.json"),
        ("squad_frame", 0x3D72, "0AB9:9FD0", "runs/T45/session-r0001/step-0004.json"),
        ("preparation_frame", 0x25CC, "0AB9:D5D6", "runs/T47/session-r0001/step-0011.json"),
        ("team_information", 0x3B82, "1B55:3323", "runs/T47/session-r0001/step-0011.json"),
    ]:
        model = ui.decode(data, address)
        if not set(range(address, address + model["consumed"])).issubset(covered):
            raise ValueError("resource crosses missing listing range")
        p = ROOT / captured
        record, lines = ui.capture(p)
        resources.append(dict(name=name, resource=f"2864:{address:04X}", caller=caller,
                              rectangle={k:model[k] for k in ["x", "y", "width", "height"]},
                              resource_sha256=ui.sha(data[address:address+model["consumed"]]),
                              base_attribute_codes=sorted({a for c,a in model["cells"].values()}),
                              captured_record=captured, captured_record_sha256=ui.sha(p.read_bytes()),
                              screenshot_sha256=record["screenshot_sha256"], comparison=compare(model, lines)))
    return dict(decoder="24BC:0000", fixed_span_rule="split at template gaps of at least two spaces; cap48",
                listing_sha256={str(p.relative_to(ROOT)):ui.sha(p.read_bytes()) for p in paths}, resources=resources)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    group = parser.add_mutually_exclusive_group(required=True)
    group.add_argument("--record", type=Path)
    group.add_argument("--check", type=Path)
    args = parser.parse_args()
    sources = [TOOL, DECODER]
    if args.record and subprocess.check_output(["git", "-C", str(ROOT), "status", "--porcelain", "--", *sources]).strip():
        raise ValueError("commit producer and decoder before measurement")
    result = analyse()
    if args.record:
        args.record.mkdir(parents=True, exist_ok=True)
        number = 1
        while (args.record / f"blueprint-r{number:04d}.json").exists():
            number += 1
        passed = all(not r["comparison"]["label_mismatches"] and not r["comparison"]["border_mismatch_count"]
                     for r in result["resources"])
        record = dict(status="passed" if passed else "failed",
                      code_commit=subprocess.check_output(["git", "-C", str(ROOT), "rev-parse", "HEAD"], text=True).strip(),
                      source_sha256={s:ui.sha((ROOT/s).read_bytes()) for s in sources}, result=result)
        with (args.record / f"blueprint-r{number:04d}.json").open("x") as f:
            json.dump(record, f, indent=2); f.write("\n")
        print(json.dumps({r["name"]:r["comparison"] for r in result["resources"]}))
        return 0 if passed else 1
    passed = [json.loads(p.read_text()) for p in args.check.glob("blueprint-r*.json")
              if json.loads(p.read_text())["status"] == "passed"]
    if not passed:
        raise ValueError("no passing blueprint comparison")
    for record in passed:
        for s in sources:
            committed = subprocess.check_output(["git", "-C", str(ROOT), "show", record["code_commit"]+":"+s])
            if ui.sha(committed) != record["source_sha256"][s]:
                raise ValueError("producer identity mismatch")
        if record["result"] != result:
            raise ValueError("blueprint reproducibility mismatch")
    print(f"{len(passed)} squad/preparation comparisons verified")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
