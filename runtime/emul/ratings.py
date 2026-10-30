#!/usr/bin/env python3
"""T15: complete raw original ratings inputs, helper observations and D983 links.

    python3 runtime/emul/ratings.py --run
    python3 runtime/emul/ratings.py --check

Only guest observations and literal retained-source projections are compared here.
The ratings and predicate algorithms belong to the Rust consumer, not this tool.
"""
import argparse
import hashlib
import json
import platform
from pathlib import Path

import contests
import match
import placement

ROOT = contests.ROOT
RUNS, FIXTURES = ROOT / "runs/T15", ROOT / "traces/T15"
PLAYER_FIELDS = ("p8_4", "p8_6", "p8_7", "p15_6", "p15_8", "p15_11")
TABLE_SHAPES = {"halving_group": (3, 0, 1), "position_class": (14, 0, 5),
                "drop_divisors": (2, 1, 255), "home_divisors": (2, 1, 255)}


def tables(g):
    return {"halving_group": list(g.mem(g.DS * 16 + 0x12BA, 3)),
            "halving_flags": [list(g.mem(g.DS * 16 + 0x129E + 14 * i, 14)) for i in range(2)],
            "position_class": list(g.mem(g.DS * 16 + 0x12BE, 14)),
            "drop_divisors": list(g.mem(g.DS * 16 + 0x1286, 2)),
            "home_divisors": list(g.mem(g.DS * 16 + 0x12CC, 2))}


def player(g, identifier):
    p8, p15 = g.far(0xD7BA) + identifier * 8, g.far(0xD7BE) + identifier * 15
    return {"id": identifier, "p8_4": g.mem(p8 + 4, 1)[0], "p8_6": g.mem(p8 + 6, 1)[0],
            "p8_7": g.mem(p8 + 7, 1)[0], "p15_6": g.mem(p15 + 6, 1)[0],
            "p15_8": g.mem(p15 + 8, 1)[0], "p15_11": g.mem(p15 + 11, 1)[0]}


def bonus_input(g, club):
    base = g.far(0xD7C2) + (club - 1) * 62
    identifiers = [g.word_at(base + off) for off in (0x28, 0x2A)]
    return {"club": club, "staff_ids": identifiers,
            "staff": [{"id": i, "byte2": g.mem(g.far(0xDCC8) + i * 4 + 2, 1)[0]}
                      for i in sorted(set(identifiers))]}


def rating_words(g):
    return [g.rd(0xD674 + 2 * i) for i in range(8)]


class Recorder:
    def __init__(self, week):
        self.week, self.active = week, False
        self.sides, self.players, self.bonuses, self.handoffs = [], [], [], []
        self.side, self.player, self.bonus = None, None, None
        self.contests = contests.Recorder(week)
        self.last_sides = {}
        hooks = {match.MATCH: lambda g: setattr(self, "active", True),
                 match.MATCH_RETURN: lambda g: setattr(self, "active", False),
                 "1B55:50EB": self.side_enter, "1B55:5281": self.side_leave,
                 "1B55:4B4A": self.player_enter, "1B55:4C2A": self.player_leave,
                 "1B55:4A37": self.bonus_enter, "1B55:4A8C": self.bonus_leave,
                 "1B55:5008": self.unavailable_leave, "1B55:4F86": self.halved_leave,
                 "1B55:4EBC": self.selector_leave, "0AB9:D983": self.contest_enter}
        for address, callback in hooks.items():
            week.g.code_hook(address, callback)

    def side_enter(self, g):
        if not self.active:
            return
        if self.side is not None or g.reg("ds") != g.DS:
            raise ValueError("nested ratings call or wrong data segment")
        flag, side, club = g.stack_word(4) & 255, g.stack_word(6), g.stack_word(8)
        base = g.far(0xD7C2) + (club - 1) * 62
        roster = [g.word_at(base + 2 * i) for i in range(11)]
        inputs = {"club": club, "side": side, "flag": flag, "club_37": g.mem(base + 0x37, 1)[0],
                  "roster": roster, "players": [player(g, i) for i in sorted(set(roster) - {0})],
                  "tables": tables(g), "ratings": rating_words(g), "seed": g.word_at(g.far(0xDE84)),
                  **{k: v for k, v in bonus_input(g, club).items() if k != "club"}}
        self.side = {"input": inputs, "draw_start": self.week.draws,
                     "helpers": {"bonus": None, "players": []},
                     "helper_indices": {"player_start": len(self.players), "bonus_start": len(self.bonuses)}}

    def side_leave(self, g):
        if self.side is None:
            return
        self.side.update(output={"ratings": rating_words(g), "seed": g.word_at(g.far(0xDE84))},
                         draw_end=self.week.draws)
        self.side["helper_indices"].update(player_end=len(self.players), bonus_end=len(self.bonuses))
        self.last_sides[self.side["input"]["side"]] = len(self.sides)
        self.sides.append(self.side)
        self.side = None

    def player_enter(self, g):
        if not self.active:
            return
        if self.player is not None:
            raise ValueError("nested player ratings call")
        self.player = {"input": {"player": player(g, g.stack_word(6)), "mode": g.stack_word(4) & 255,
                                 "tables": tables(g)},
                       "output": {"unavailable": None, "halved": None, "halving_selectors": []}}

    def unavailable_leave(self, g):
        if self.player is not None:
            if self.player["output"]["unavailable"] is not None:
                raise ValueError("multiple unavailable returns within player call")
            self.player["output"]["unavailable"] = g.reg("ax") & 255

    def halved_leave(self, g):
        if self.player is not None:
            if self.player["output"]["halved"] is not None:
                raise ValueError("multiple halved returns within player call")
            self.player["output"]["halved"] = g.reg("ax") & 255

    def selector_leave(self, g):
        if self.player is not None:
            self.player["output"]["halving_selectors"].append(g.reg("ax") & 255)

    def player_leave(self, g):
        if self.player is None:
            return
        self.player["output"]["value"] = g.reg("ax")
        self.players.append(self.player)
        if self.side is not None:
            self.side["helpers"]["players"].append(self.player)
        self.player = None

    def bonus_enter(self, g):
        if not self.active:
            return
        if self.bonus is not None:
            raise ValueError("nested bonus call")
        self.bonus = {"input": bonus_input(g, g.stack_word(4))}

    def bonus_leave(self, g):
        if self.bonus is not None:
            self.bonus["output"] = {"bonus": g.reg("ax")}
            self.bonuses.append(self.bonus)
            if self.side is not None:
                self.side["helpers"]["bonus"] = self.bonus
            self.bonus = None

    def contest_enter(self, g):
        if self.active:
            if self.side is not None or set(self.last_sides) != {0, 1}:
                raise ValueError("missing completed side ratings before D983")
            self.handoffs.append({"after_sides": len(self.sides),
                                  "sides": sorted(self.last_sides.values()), "ratings": rating_words(g),
                                  "seed": g.word_at(g.far(0xDE84)), "draw_start": self.week.draws})


def exact_ints(values, low, high, length):
    return isinstance(values, list) and len(values) == length and all(placement.integer(v, low, high) for v in values)


def reject_numeric_aliases(value):
    if type(value) in (bool, float):
        raise ValueError("ratings numeric fields require exact integers")
    if isinstance(value, dict):
        for item in value.values():
            reject_numeric_aliases(item)
    elif isinstance(value, list):
        for item in value:
            reject_numeric_aliases(item)


def validate_tables(value):
    if set(value) != set(TABLE_SHAPES) | {"halving_flags"}:
        raise ValueError("missing ratings tables")
    for name, (length, low, high) in TABLE_SHAPES.items():
        if not exact_ints(value[name], low, high, length):
            raise ValueError(f"invalid table {name}")
    if not isinstance(value["halving_flags"], list) or len(value["halving_flags"]) != 2 or any(
            not exact_ints(row, 0, 255, 14) for row in value["halving_flags"]):
        raise ValueError("invalid halving flags")


def validate_player(value):
    if set(value) != {"id", *PLAYER_FIELDS} or not placement.integer(value["id"], 0, 3920):
        raise ValueError("invalid player record/ID")
    if any(not placement.integer(value[k], 0, 255) for k in PLAYER_FIELDS):
        raise ValueError("player fields require raw bytes")
    if value["p8_6"] > 13 or value["p8_7"] > 13:
        raise ValueError("player position/selector leaves named table projection")


def validate_bonus(value):
    inp, out = value["input"], value["output"]
    if not placement.integer(inp["club"], 1, 176) or not exact_ints(inp["staff_ids"], 0, 1000, 2):
        raise ValueError("invalid club/staff IDs")
    staff = inp["staff"]
    if (not isinstance(staff, list) or len({s["id"] for s in staff}) != len(staff)
            or [s["id"] for s in staff] != sorted(set(inp["staff_ids"]))
            or any(set(s) != {"id", "byte2"} or not placement.integer(s["byte2"], 0, 255) for s in staff)
            or not placement.integer(out["bonus"], 0, 65535)):
        raise ValueError("incomplete/malformed staff or bonus result")


def validate_player_call(value):
    inp, out = value["input"], value["output"]
    validate_player(inp["player"])
    validate_tables(inp["tables"])
    if (not placement.integer(inp["mode"], 0, 255) or not placement.integer(out["value"], 0, 256)
            or not placement.integer(out["unavailable"], 0, 1)
            or (out["halved"] is not None and not placement.integer(out["halved"], 0, 1))
            or not isinstance(out["halving_selectors"], list)
            or not all(placement.integer(v, 0, 255) for v in out["halving_selectors"])):
        raise ValueError("invalid player helper observation")
    if out["unavailable"]:
        if out["halved"] is not None or out["halving_selectors"]:
            raise ValueError("absent helper calls must remain absent")
    elif out["halved"] is None or len(out["halving_selectors"]) not in (1, 2):
        raise ValueError("missing reached halving helpers")


def validate_side(call):
    inp, out, helpers = call["input"], call["output"], call["helpers"]
    validate_tables(inp["tables"])
    if (not placement.integer(inp["club"], 1, 176) or not placement.integer(inp["side"], 0, 1)
            or not placement.integer(inp["flag"], 0, 255) or not placement.integer(inp["club_37"], 0, 255)
            or not exact_ints(inp["roster"], 0, 3920, 11)
            or not exact_ints(inp["ratings"], 0, 65535, 8) or not exact_ints(out["ratings"], 0, 65535, 8)
            or not placement.integer(inp["seed"], 0, 65535) or not placement.integer(out["seed"], 0, 65535)
            or not placement.integer(call["draw_start"], 0, 2**32)
            or not placement.integer(call["draw_end"], 0, 2**32) or call["draw_start"] != call["draw_end"]
            or inp["seed"] != out["seed"]):
        raise ValueError("invalid side input/output or unexpected RNG change")
    side = inp["side"]
    if inp["ratings"][1-side::2] != out["ratings"][1-side::2]:
        raise ValueError("side rating call changed other side")
    players = inp["players"]
    if (not isinstance(players, list) or [p["id"] for p in players] != sorted(set(inp["roster"]) - {0})):
        raise ValueError("missing/duplicate/noncanonical roster players")
    for p in players:
        validate_player(p)
    validate_bonus(helpers["bonus"])
    if not placement.same_json(helpers["bonus"]["input"], {k: inp[k] for k in ("club", "staff_ids", "staff")}):
        raise ValueError("bonus helper input differs from raw side input")
    actual = helpers["players"]
    if [p["input"]["player"]["id"] for p in actual] != [p for p in inp["roster"] if p]:
        raise ValueError("player helper sequence differs from roster")
    lookup = {p["id"]: p for p in players}
    for p in actual:
        validate_player_call(p)
        if (p["input"]["mode"] != 0 or not placement.same_json(p["input"]["player"], lookup[p["input"]["player"]["id"]])
                or not placement.same_json(p["input"]["tables"], inp["tables"])):
            raise ValueError("player helper raw input differs from side snapshot")


def legacy_player(call):
    inp, out = call["input"], call["output"]
    p = inp["player"]
    signed = lambda v: v - 256 if v >= 128 else v
    return {"mode": inp["mode"], "player": p["id"], "p8_4": p["p8_4"], "position": p["p8_6"],
            "p8_7": p["p8_7"], "p15_6": signed(p["p15_6"]), "p15_8": signed(p["p15_8"]),
            "unavailable": out["unavailable"], "halved": out["halved"] or 0, "value": out["value"]}


def legacy_bonus(call):
    inp, out = call["input"], call["output"]
    staff = {s["id"]: s["byte2"] for s in inp["staff"]}
    a, b = inp["staff_ids"]
    return {"club": inp["club"], "word_28": a, "word_2A": b,
            "staff_a": staff[a], "staff_b": staff[b], "bonus": out["bonus"] & 255}


def legacy_side(call):
    inp, out, helpers = call["input"], call["output"], call["helpers"]
    return {"flag": inp["flag"], "side": inp["side"], "club": inp["club"], "club_37": inp["club_37"],
            "players": [{"player": p["input"]["player"]["id"], "position": p["input"]["player"]["p8_6"],
                         "value": p["output"]["value"]} for p in helpers["players"]],
            "bonus": helpers["bonus"]["output"]["bonus"] & 255, "values": out["ratings"][inp["side"]::2]}


def sources(week):
    t09 = []
    for path in sorted((ROOT / "runs/T09").glob("T09-r*.json")):
        record = json.loads(path.read_text())
        if Path(record["actions"]["week_record"]).stem == week:
            t09.append((path, record))
    if len(t09) != 1 or t09[0][1]["status"] != "completed":
        raise ValueError("missing unique completed T09 source")
    index = json.loads((ROOT / "traces/T11/index.json").read_text())
    meta = next(r for r in index["records"] if r["week"] == week)
    record, fixture = ROOT / meta["record"], ROOT / "traces/T11" / meta["cases"]
    if contests.sha(record) != meta["record_sha256"] or contests.sha(fixture) != meta["cases_sha256"]:
        raise ValueError("T11 source digest differs")
    return t09[0], meta, json.loads(record.read_text()), contests.events(fixture)


def cases_for(observed, source, trace, reference_source=None):
    """Validate literal links; deliberately do not compute rating/predicate results."""
    try:
        return _cases_for(observed, source, trace, reference_source)
    except (KeyError, TypeError, IndexError, AttributeError, StopIteration) as e:
        raise ValueError(f"incomplete/malformed ratings observations: {e}") from e


def _cases_for(observed, source, trace, reference_source=None):
    reject_numeric_aliases(observed)
    (p09, r09), meta11, r11, cases11 = sources(source["t04_record"])
    reference_source = reference_source or source
    if (r09["start_state"]["sha256"] != source["start_state_sha256"]
            or r11["start_state"]["sha256"] != source["start_state_sha256"]
            or trace[0]["state_sha256"] != reference_source["start_state_sha256"]
            or trace[-1].get("status") != "completed"):
        raise ValueError("ratings source/state/completion differs")
    old = contests.outputs(r09)
    sides, players, bonuses, handoffs = (observed[k] for k in ("sides", "players", "bonuses", "handoffs"))
    for p in players:
        validate_player_call(p)
    for b in bonuses:
        validate_bonus(b)
    for s in sides:
        validate_side(s)
    actual = {"players": [legacy_player(p) for p in players], "bonuses": [legacy_bonus(b) for b in bonuses],
              "sides": [legacy_side(s) for s in sides],
              "contests": [{"after_sides": c["after_sides"], "values": c["ratings"]} for c in handoffs]}
    if not placement.same_json(actual, old):
        raise ValueError("ratings observations differ from retained T09")
    # Anchor nested observations in the exact measured all-call sequence; identical
    # players at later calls cannot substitute for missing observations.
    previous_player = previous_bonus = 0
    for s in sides:
        indices = s["helper_indices"]
        begin, end = indices["player_start"], indices["player_end"]
        bbegin, bend = indices["bonus_start"], indices["bonus_end"]
        if (not placement.integer(begin, previous_player, len(players))
                or not placement.integer(end, begin, len(players))
                or not placement.integer(bbegin, previous_bonus, len(bonuses))
                or not placement.integer(bend, bbegin, len(bonuses)) or bend != bbegin + 1
                or not placement.same_json(players[begin:end], s["helpers"]["players"])
                or not placement.same_json(bonuses[bbegin:bend], [s["helpers"]["bonus"]])):
            raise ValueError("nested side helpers differ from measured all-call indices")
        previous_player, previous_bonus = end, bend
    calls = observed["contests"]
    # Every D983 draw remains checked against every retained stream, not just the canonical one.
    projected11 = contests.cases_for(calls, trace, reference_source, source["t04_record"])
    if not placement.same_json(projected11, cases11):
        # The repeated trace identity itself changes only source metadata.
        for new, old11 in zip(projected11, cases11):
            new["source"] = old11["source"]
        if not placement.same_json(projected11, cases11):
            raise ValueError("D983 observations differ from T11")
    if len(handoffs) != len(cases11):
        raise ValueError("missing ratings/D983 handoff")
    provenance = {"t09_record": match.rel(p09), "t09_record_sha256": contests.sha(p09),
                  "t11_record": meta11["record"], "t11_record_sha256": meta11["record_sha256"],
                  "t11_cases": meta11["cases"], "t11_cases_sha256": meta11["cases_sha256"],
                  "t08_trace": source["trace"], "t08_trace_sha256": source["trace_sha256"]}
    exported = [{"schema": "ratings-case/1", "week": source["t04_record"], "call": i,
                 **s, "source": provenance} for i, s in enumerate(sides)]
    pairs = []
    for i, (h, c) in enumerate(zip(handoffs, cases11)):
        end = h["after_sides"]
        if (not placement.integer(end, 2, len(sides)) or not exact_ints(h["sides"], 0, end - 1, 2)
                or h["sides"] != sorted(h["sides"]) or h["sides"][0] == h["sides"][1]):
            raise ValueError("invalid side-call handoff indices")
        latest = {}
        for j, s in enumerate(sides[:end]):
            latest[s["input"]["side"]] = j
        if h["sides"] != sorted(latest.values()):
            raise ValueError("handoff does not use latest actual side calls")
        selected = [sides[j] for j in h["sides"]]
        if (set(s["input"]["side"] for s in selected) != {0, 1}
                or selected[0]["output"]["ratings"] != selected[1]["input"]["ratings"]
                or h["ratings"] != selected[-1]["output"]["ratings"]
                or h["ratings"] != c["input"]["ratings"] or h["seed"] != c["input"]["seed"]
                or h["draw_start"] != c["source"]["draw_start"]
                or any(s["input"]["seed"] != h["seed"] or s["draw_start"] != h["draw_start"] for s in selected)):
            raise ValueError("ratings→D983 image/seed/draw boundary differs")
        pairs.append({"schema": "ratings-contest-case/1", "week": source["t04_record"], "call": i,
                      "sides": h["sides"], "contest": c, "source": provenance})
    helper = [{"schema": "ratings-helper-case/1", "week": source["t04_record"], "kind": kind,
               "call": i, **v, "source": provenance}
              for kind, values in (("player", players), ("bonus", bonuses)) for i, v in enumerate(values)]
    return exported, pairs, helper


def selected_runs():
    chosen = {}
    for path in sorted(RUNS.glob("T15-r*.json")):
        record = json.loads(path.read_text())
        chosen[record["actions"]["stream_key"]] = (path, record)
    return {k: v for k, v in chosen.items() if v[1]["status"] == "completed"}


def build_index():
    _, groups = contests.read_corpus()
    chosen, records, coverage, all_pairs, all_helpers = selected_runs(), [], [], [], []
    for key, members in groups.items():
        if key not in chosen:
            raise ValueError("missing completed ratings run")
        path, record = chosen[key]
        source = record["actions"]["source"]
        trace = next((t for e, t in members if placement.same_json(e, source)), None)
        if trace is None or record["start_state"]["sha256"] != source["start_state_sha256"]:
            raise ValueError("ratings source/state differs")
        cases, pairs, helpers = cases_for(contests.outputs(record), source, trace)
        obs = {o["field"]: o["value"] for o in record["observations"]}
        fixture = ROOT / obs["fixture path"]
        if contests.sha(fixture) != obs["fixture sha256"] or not placement.same_json(contests.events(fixture), cases):
            raise ValueError("ratings fixture differs from original observations")
        all_pairs.extend(pairs)
        all_helpers.extend(helpers)
        records.append({"record": match.rel(path), "record_sha256": contests.sha(path), "cases": fixture.name,
                        "cases_sha256": contests.sha(fixture), "week": source["t04_record"], "calls": len(cases),
                        "producer_commit": record["code_commit"]})
        for entry, repeated in members:
            cases_for(contests.outputs(record), source, repeated, entry)
            coverage.append({"t04_record": entry["t04_record"], "trace": entry["trace"],
                             "trace_sha256": entry["trace_sha256"], "cases": fixture.name})
    checks = {}
    for name, expected in (("handoffs", all_pairs), ("helpers", all_helpers)):
        file = FIXTURES / (name + ".jsonl")
        if not placement.same_json(contests.events(file), expected):
            raise ValueError(f"{name} export differs from original observations")
        checks[name] = {"file": file.name, "sha256": contests.sha(file), "cases": len(expected)}
    return {"schema": "ratings-corpus/1", "records": records, "coverage": coverage,
            "calls": sum(r["calls"] for r in records), "weeks": len(records), "traces": len(coverage),
            **checks, "player_helpers": sum(h["kind"] == "player" for h in all_helpers),
            "bonus_helpers": sum(h["kind"] == "bonus" for h in all_helpers),
            "t11_index_sha256": contests.sha(ROOT / "traces/T11/index.json")}


def run():
    import cycle
    import guest
    import unicorn
    if match.git("status", "--porcelain", "--", "runtime/emul"):
        raise SystemExit("commit runtime/emul before recording")
    commit = match.git("rev-parse", "--short", "HEAD")
    _, groups = contests.read_corpus()
    RUNS.mkdir(parents=True, exist_ok=True)
    FIXTURES.mkdir(parents=True, exist_ok=True)
    chosen, all_pairs, all_helpers = selected_runs(), [], []
    for key, members in groups.items():
        if key in chosen:
            print(f"already recorded {chosen[key][1]['run_id']}", flush=True)
            _, pairs, helpers = cases_for(contests.outputs(chosen[key][1]), *members[-1])
            all_pairs.extend(pairs)
            all_helpers.extend(helpers)
            continue
        source, reference = members[-1]
        started = match.utc()
        path, data = match.find_state(source["start_state_sha256"])
        week, status, lines, cases, pairs, helpers = match.Week(data), "completed", [], [], [], []
        recorder = Recorder(week)
        try:
            week.play()
            if (week.g.unsupported or recorder.side is not None or recorder.player is not None
                    or recorder.bonus is not None or recorder.contests.pending is not None):
                raise ValueError("unsupported service or incomplete ratings call")
            if week.events != reference[1:-1]:
                raise ValueError("new week differs from retained T08 events")
            ok, lines = match.compare(week.events, source["start_state_sha256"], ROOT / source["t04_record_path"])
            if not ok:
                raise ValueError("DOSBox-X comparison failed")
            observed = {"sides": recorder.sides, "players": recorder.players, "bonuses": recorder.bonuses,
                        "handoffs": recorder.handoffs, "contests": recorder.contests.calls}
            cases, pairs, helpers = cases_for(observed, source, reference)
        except (Exception, KeyboardInterrupt) as e:
            status = f"aborted: {type(e).__name__}: {e}"
        observed = {"sides": recorder.sides, "players": recorder.players, "bonuses": recorder.bonuses,
                    "handoffs": recorder.handoffs, "contests": recorder.contests.calls}
        n = max(match.next_number(RUNS, "T15-r*.json"), match.next_number(FIXTURES, "T15-r*.jsonl"))
        rid = f"T15-r{n:04d}"
        fixture = FIXTURES / (rid + ".jsonl")
        placement.write_lines(fixture, cases)
        record = {"schema": "run/1", "run_id": rid, "experiment": "T15", "arm": "ratings", "rep": n,
                  "code_commit": commit, "machine": cycle.machine_id(),
                  "artifact": {"set": "One-Nil96 (records/T01/inventory.json)", "variant": None},
                  "runtime": {"harness": f"runtime/emul/ratings.py@{commit}", "unicorn": unicorn.__version__,
                              "python": platform.python_version(), "dos_clock": week.g.clock,
                              "settings": {k: getattr(guest, k) for k in ("INSTR_PER_S", "KEY_HOLD", "PIT_HZ", "SLICE_MAX")}},
                  "interventions": [{"level": "I3", "what": "guest.py services and read-only raw ratings/helper hooks"}],
                  "start_state": {"id": match.rel(path), "sha256": source["start_state_sha256"],
                                  "restore": "DOSBox-X savestate restored by guest.py"}, "seed": None,
                  "actions": {"script": "runtime/emul/ratings.py", "source": source, "stream_key": key,
                              "game_files": {name: hashlib.sha256(raw).hexdigest() for name, raw in week.files_at_start.items()}},
                  "observations": [{"step": 0, "source": "file", "field": "fixture path", "value": match.rel(fixture)},
                                   {"step": 0, "source": "file", "field": "fixture sha256", "value": contests.sha(fixture)},
                                   {"step": 1, "source": "log", "field": "ordered DOSBox-X comparison", "value": "\n".join(lines)}],
                  "outputs": [{"name": name, "value": value} for name, value in observed.items()],
                  "started": started, "ended": match.utc(), "status": status}
        match.write_record(RUNS / (rid + ".json"), record)
        print(f"{rid}: {status}; {len(recorder.sides)} sides, {len(recorder.players)} players, "
              f"{len(recorder.bonuses)} bonuses, {len(cases)} cases", flush=True)
        if status != "completed":
            raise SystemExit(1)
        all_pairs.extend(pairs)
        all_helpers.extend(helpers)
    for name, values in (("handoffs", all_pairs), ("helpers", all_helpers)):
        file = FIXTURES / (name + ".jsonl")
        if not file.exists():
            placement.write_lines(file, values)
        elif not placement.same_json(contests.events(file), values):
            raise ValueError(f"immutable {name} export differs")
    (FIXTURES / "index.json").write_text(json.dumps(build_index(), indent=2) + "\n")


def main(argv=None):
    ap = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    mode = ap.add_mutually_exclusive_group(required=True)
    mode.add_argument("--run", action="store_true")
    mode.add_argument("--check", action="store_true")
    args = ap.parse_args(argv)
    if args.run:
        run()
        return 0
    try:
        index = build_index()
        if (index["calls"], index["weeks"], index["traces"], index["handoffs"]["cases"],
                index["player_helpers"], index["bonus_helpers"]) != (1128, 6, 15, 558, 12614, 2495):
            raise ValueError("expected 1,128 sides, six weeks, 15 references, 558 handoffs and complete T09 helpers")
        if not placement.same_json(index, json.loads((FIXTURES / "index.json").read_text())):
            raise ValueError("ratings index differs")
    except (ValueError, OSError, KeyError, TypeError, StopIteration) as e:
        print(f"ratings check: FAIL: {e}")
        return 1
    print("ratings check: ok (1,128 side cases, 558 handoffs, 12,614 player/2,495 bonus helpers, six weeks, 15 T08 references)")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
