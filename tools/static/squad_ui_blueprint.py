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


def overlay_component(base, overlay):
    """Project a later original draw into the component's comparison viewport."""
    return {**base, "cells": {p:overlay["cells"].get(p, cell) for p,cell in base["cells"].items()}}


def compare(model, lines, dynamic_border_cells=()):
    # Keep fixed text assertions intact. Exclude only statically traced runtime
    # destinations from the border assertions; all other border cells stay exact.
    dynamic = set(dynamic_border_cells)
    if not dynamic.issubset(model["cells"]):
        raise ValueError("dynamic destination outside component")
    border_model = {**model, "cells": {p:((32,a) if p in dynamic else (c,a))
                                    for p,(c,a) in model["cells"].items()}}
    result = ui.compare(border_model, lines)
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
        overlays = []
        dynamic = []
        comparison_model = model
        if name == "squad_frame":
            # AC87 draws 9FD0's frame, then DS:22AC. CBF0 subsequently
            # draws DS:1D0E for first-team mode outside a live match.
            for offset, caller_path in [(0x22AC,"0AB9:AC94..AC9E"),
                                        (0x1D0E,"0AB9:CD79..CD90")]:
                overlay = ui.decode(data, offset)
                comparison_model = overlay_component(comparison_model, overlay)
                overlays.append(dict(resource=f"2864:{offset:04X}", caller_path=caller_path,
                                     resource_sha256=ui.sha(data[offset:offset+overlay["consumed"]])))
        if name == "team_information":
            # 3357 -> 0EE3: club name/15-space field, row1/column23.
            # 331C -> 101E: row14/right column54; comma writes are one cell
            # right of the next digit column. Three groups give x48,42,36.
            if data[0x0F10] != 15:
                raise ValueError("club-name placeholder length differs from traced field")
            dynamic = [dict(cells=[[x,0] for x in range(22,22+data[0x0F10])],
                            reason="club name field", writer="1B55:3357 -> 0EE3"),
                       dict(cells=[[x,13] for x in (36,42,48)],
                            reason="numeric group separators", writer="1B55:331C -> 101E:1056..10A7")]
        p = ROOT / captured
        record, lines = ui.capture(p)
        resources.append(dict(name=name, resource=f"2864:{address:04X}", caller=caller,
                              rectangle={k:model[k] for k in ["x", "y", "width", "height"]},
                              resource_sha256=ui.sha(data[address:address+model["consumed"]]),
                              base_attribute_codes=sorted({a for c,a in model["cells"].values()}),
                              captured_record=captured, captured_record_sha256=ui.sha(p.read_bytes()),
                              screenshot_sha256=record["screenshot_sha256"], later_overlays=overlays,
                              dynamic_border_destinations=dynamic,
                              comparison=compare(comparison_model, lines,
                                                 [tuple(p) for d in dynamic for p in d["cells"]])))
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
