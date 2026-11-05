#!/usr/bin/env python3
"""Decode UI geometry from the public EXE listing; never export resource/cell buffers.

24BC:0000 consumes a one-based linear cell, row count, column count, then
literal glyphs, FF/attribute, and 00/additional-copies-of-previous-word.
Records contain identities, short labels, geometry and capture comparisons only.
"""
import argparse
import hashlib
import importlib.util
import json
from pathlib import Path
import re
import subprocess

ROOT = Path(__file__).resolve().parents[2]
TOOL = "tools/static/ui_blueprint.py"
LOW = "☺☻♥♦♣♠•◘○◙♂♀♪♫☼►◄↕‼¶§▬↨↑↓→←∟↔▲▼"
BOX = set("│┤╡╢╖╕╣║╗╝╜╛┐└┴┬├─┼╞╟╚╔╩╦╠═╬╧╨╤╥╙╘╒╓╫╪┘┌")


def sha(data):
    return hashlib.sha256(data).hexdigest()


def glyph(value):
    return " " if value == 0 else LOW[value - 1] if value < 32 else bytes([value]).decode("cp437")


def decode(data, offset=0):
    """Internal cell model; callers must not serialize its complete glyph/attribute payload."""
    pos = offset

    def take():
        nonlocal pos
        if pos >= len(data):
            raise ValueError("truncated resource")
        value = data[pos]
        pos += 1
        return value

    start = take() | (take() << 8)
    height, width = take(), take()
    x, y = (start - 1) % 80, (start - 1) // 80
    if not (1 <= start <= 2000 and 1 <= height <= 25 and 1 <= width <= 80
            and x + width <= 80 and y + height <= 25):
        raise ValueError("resource rectangle outside 80x25")
    cells = {}
    attribute = 0
    previous = (0, 0)
    for row in range(height):
        column = 0
        while column < width:
            value = take()
            if value == 255:
                attribute = take()
                continue
            if value == 0:
                count = take()
                if column + count > width:
                    raise ValueError("repetition crosses row boundary")
                # MOV AX,DX restores AH even when REP's count is zero.
                attribute = previous[1]
                for _ in range(count):
                    cells[(x + column, y + row)] = previous
                    column += 1
            else:
                previous = (value, attribute)
                cells[(x + column, y + row)] = previous
                column += 1
    return dict(start_cell=start, x=x, y=y, width=width, height=height,
                consumed=pos - offset, cells=cells)


def data_segment():
    memory = {}
    paths = sorted((ROOT / "static/1-0-exe/data").glob("ds_2864_*.hex"))
    for path in paths:
        for line in path.read_text().splitlines():
            if not re.match(r"^[0-9A-F]{4}  ", line):
                continue
            parts = line.partition("|")[0].split()
            address = int(parts[0], 16)
            for index, token in enumerate(parts[1:]):
                if not re.fullmatch("[0-9A-F]{2}", token):
                    raise ValueError("malformed listing byte")
                at = address + index
                if at in memory:
                    raise ValueError("overlapping listing ranges")
                memory[at] = int(token, 16)
    if not memory:
        raise ValueError("no generated data listing")
    return bytes(memory.get(n, 0) for n in range(max(memory) + 1)), set(memory), paths


def labels(model):
    result = []
    for y in range(model["y"], model["y"] + model["height"]):
        row = "".join(glyph(model["cells"][(x, y)][0])
                      for x in range(model["x"], model["x"] + model["width"]))
        for match in re.finditer(r"[A-Za-z0-9][A-Za-z0-9 ./#,'?!:()+-]*", row):
            label = match.group().rstrip()
            if label:
                result.append(dict(x=model["x"] + match.start(), y=y,
                                   text=label[:48], truncated=len(label) > 48))
    return result


def compose(base, overlay):
    """Apply a later resource in the original call order, retaining the base viewport."""
    if not set(overlay["cells"]).issubset(base["cells"]):
        raise ValueError("overlay outside comparison viewport")
    return {**base, "cells": {**base["cells"], **overlay["cells"]}}


def resource_callers():
    result = []
    for path in sorted((ROOT / "static/1-0-exe/code").glob("*.asm")):
        owner = None
        instructions = []
        for line in path.read_text().splitlines():
            found = re.match(r"; ---- routine ([0-9A-F]+:[0-9A-F]+)", line)
            if found:
                owner = found[1]
            found = re.match(r"^([0-9A-F]{4})\s+((?:[0-9A-F]{2}\s+)+)([a-z].*)$", line)
            if found:
                instructions.append((found[1], found[3], owner))
        for n, (address, operation, owner) in enumerate(instructions):
            found = re.fullmatch(r"mov di, 0x([0-9a-f]+)", operation)
            following = [item[1] for item in instructions[n + 1:n + 7]]
            if found and following == ["push ds", "push di", "mov di, 0xdd5c",
                                       "push ds", "push di", "call far 232A:052F"]:
                result.append(dict(resource=f"2864:{int(found[1], 16):04X}",
                                   caller=owner, pointer_instruction=address,
                                   listing=str(path.relative_to(ROOT))))
    return result


def capture(path):
    spec = importlib.util.spec_from_file_location("ui_capture_validation", ROOT / "runtime/driver/manual_session.py")
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    module.validate(path.parent)
    value = json.loads(path.read_text())
    lines = value["text"].split("\n")
    return value, [line.ljust(80) for line in lines] + [" " * 80] * (25 - len(lines))


def compare(model, lines):
    found_labels = labels(model)
    label_mismatches = [item for item in found_labels
                        if lines[item["y"]][item["x"]:item["x"] + len(item["text"])] != item["text"]]
    borders = [(x, y, glyph(c)) for (x, y), (c, a) in model["cells"].items() if glyph(c) in BOX]
    border_mismatches = [(x, y, ord(c), ord(lines[y][x])) for x, y, c in borders if lines[y][x] != c]
    return dict(labels=found_labels, label_count=len(found_labels),
                labels_matched=len(found_labels) - len(label_mismatches),
                label_mismatches=label_mismatches, border_cells=len(borders),
                borders_matched=len(borders) - len(border_mismatches),
                border_mismatch_count=len(border_mismatches), border_mismatch_sample=border_mismatches[:16])


def analyse():
    data, covered, paths = data_segment()
    resources = []
    for name, offset, caller, observed in [
        ("main_menu", 0x45E6, "0006:1B52", "runs/T47/session-r0001/step-0001.json"),
        ("main_single_player_entry", 0x5A28, "0006:1B52", "runs/T47/session-r0001/step-0001.json"),
        ("configuration", 0x49E8, "0006:10BF", "runs/T47/session-r0001/step-0006.json"),
    ]:
        model = decode(data, offset)
        if not set(range(offset, offset + model["consumed"])).issubset(covered):
            raise ValueError("resource crosses a missing listing range")
        observed_path = ROOT / observed
        record, lines = capture(observed_path)
        comparison_model = model
        overlays = []
        if name == "main_menu":
            # 0006:1B88..1B92 draws this AFTER DS:45E6 for one manager.
            # It replaces two side-border cells with separator junctions.
            overlay = decode(data, 0x5A28)
            comparison_model = compose(model, overlay)
            overlays.append(dict(resource="2864:5A28", caller_path="0006:1B88..1B92",
                                 resource_sha256=sha(data[0x5A28:0x5A28 + overlay["consumed"]])))
        resources.append(dict(name=name, resource=f"2864:{offset:04X}", caller=caller,
                              rectangle={k: model[k] for k in ["start_cell", "x", "y", "width", "height"]},
                              resource_bytes_consumed=model["consumed"],
                              resource_sha256=sha(data[offset:offset + model["consumed"]]),
                              base_attribute_codes=sorted({a for c, a in model["cells"].values()}),
                              later_resource_overlays=overlays,
                              captured_record=observed, captured_record_sha256=sha(observed_path.read_bytes()),
                              screenshot_sha256=record["screenshot_sha256"], comparison=compare(comparison_model, lines)))
    candidates = resource_callers()
    for item in candidates:
        offset = int(item["resource"].split(":")[1], 16)
        try:
            model = decode(data, offset)
            if not set(range(offset, offset + model["consumed"])).issubset(covered):
                raise ValueError("missing listing range")
            item.update(status="decoded component; composite/runtime unverified",
                        rectangle={k:model[k] for k in ["x","y","width","height"]},
                        resource_sha256=sha(data[offset:offset + model["consumed"]]),
                        short_label_sample=labels(model)[:3])
        except ValueError as error:
            item.update(status="unresolved resource", reason=str(error))
    return dict(decoder="24BC:0000", wrapper="232A:052F", coordinates="zero-based x/y; resource start cell is one-based linear",
                listing_sha256={str(p.relative_to(ROOT)):sha(p.read_bytes()) for p in paths},
                resources=resources, candidate_resource_callers=candidates)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--record", type=Path)
    parser.add_argument("--check", type=Path)
    args = parser.parse_args()
    if bool(args.record) == bool(args.check):
        parser.error("choose --record or --check")
    if args.record:
        if subprocess.check_output(["git", "-C", str(ROOT), "status", "--porcelain", "--", TOOL]).strip():
            raise ValueError("commit decoder source before measuring original resources")
    result = analyse()
    if args.record:
        args.record.mkdir(parents=True, exist_ok=True)
        number = 1
        while (args.record / f"blueprint-r{number:04d}.json").exists():
            number += 1
        passed = all(not r["comparison"]["label_mismatches"] and not r["comparison"]["border_mismatch_count"] for r in result["resources"])
        record = dict(status="passed" if passed else "failed", code_commit=subprocess.check_output(["git", "-C", str(ROOT), "rev-parse", "HEAD"],text=True).strip(), tool_sha256=sha((ROOT/TOOL).read_bytes()), result=result)
        with (args.record / f"blueprint-r{number:04d}.json").open("x") as out:
            json.dump(record, out, indent=2); out.write("\n")
        print(json.dumps({r["name"]:{k:r["comparison"][k] for k in ["label_count","labels_matched","border_cells","borders_matched","border_mismatch_count"]} for r in result["resources"]}))
        return 0 if passed else 1
    records = [json.loads(p.read_text()) for p in args.check.glob("blueprint-r*.json")]
    passed = [r for r in records if r["status"] == "passed"]
    if not passed:
        raise ValueError("no passing blueprint comparison")
    for record in passed:
        source = subprocess.check_output(["git", "-C", str(ROOT), "show", record["code_commit"]+":"+TOOL])
        if sha(source) != record["tool_sha256"] or record["result"] != result:
            raise ValueError("blueprint identity or reproducibility mismatch")
    print(f"{len(passed)} blueprint comparisons verified")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
