#!/usr/bin/env python3
"""T10: play one week of One-Nil 96 with Watch match on, from a restored savestate, in DOSBox-X.

    python3 runtime/driver/watched.py [--state .cache/states/T05/T05-r0001.sav] [--out runs/T10]

The start state is a savestate of the main menu (by default T05-r0001's end savestate: SAVE1 right
after the load, Watch match on, F05 item 4). It is RESTORED, not reloaded: a fresh DOSBox-X runs 1-0
to its title screen and the savestate is loaded over it (driver.Driver.launch with a StartState,
whose meta, written once to .cache/states/T10/start/, holds the savestate's sha256, the digest of its
own screen, the game folder, the driver's drive layout and config). Watch match is left as the state
has it.

Then the week, as runtime/driver/weeks.py plays one (its keys at the screens it knows: PLAY NEXT
GAME, PLAY GAME on the pre-match screen, Space at "press any key" / "hit any key" / "any other key to
continue", Return through PLAYER CONTRACT, N at a (Y/N) question), with one difference: a watched
match runs by itself for minutes, so a screen that is not one of those is read slowly (a savestate
every MATCH_POLL s) and no key is pressed while it changes. When a match screen (one showing
"commentary") stands still for STALL_READS reads in a row it is taken as a key wait and Space is
pressed, as weeks.py does on a match board; any other screen that stands still stops the run (an
unknown screen, recorded). The watched match's full-time screen ("spacebar-view commentary P-print
commentary ◄┘-bench any other key to exit") gets n, a key with no other use there. A screen still changing after MAX_LIVE s stops the run too.

Recorded, as weeks.py records screens: every screen a key was pressed at (its digest field holds
"chars+attributes", the screens runtime/emul/match.py's compare() looks for); of a changing screen,
its first and last reads (labelled "(match, first read)" / "(match, last read)", which compare()
leaves out) and every INTERMEDIATE_EVERY-th read in between as text and a digest whose field does not
say "chars+attributes" (so compare() does not look for it). Savestates of the start, the key waits
and the end are kept in .cache/states/T10/ (and copied to the owner's Drive by hand: rclone copy
.cache/states/T10 onenildrive:states/T10); records hold their sha256 (CLAUDE.md rule 14). Refuses to
run with uncommitted changes under runtime/driver/.
"""
import argparse
import json
import shutil
import sys
import time
import traceback
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import cycle  # noqa: E402
import driver  # noqa: E402
import savestate  # noqa: E402
import screens  # noqa: E402
import weeks  # noqa: E402

ROOT = driver.ROOT
STATES = ROOT / ".cache" / "states" / "T10"
START_STATES = STATES / "start"
DEFAULT_STATE = ROOT / ".cache" / "states" / "T05" / "T05-r0001.sav"
SCREEN_WAIT = weeks.SCREEN_WAIT   # 2 s after a key that changes the screen
MATCH_POLL = 10.0       # seconds between reads of a changing screen (a savestate each; they are slow)
STALL_READS = 3         # equal reads in a row of a match screen (about 20-30 s still) make a key wait
MAX_LIVE = 20 * 60      # seconds a screen may keep changing before the run stops
INTERMEDIATE_EVERY = 6  # of a changing screen, every 6th read (about a minute) is recorded as well
MAX_SCREENS = 400


def is_match(text):
    return "commentary" in text.lower()


def classify(text):
    """The key weeks.py presses at a still screen of this text, with its reason; None when the screen
    is not one weeks.py answers at once (a match, or an unknown screen)."""
    low = text.lower()
    if "GAME NAME" in text and "PLAY NEXT GAME" in text:
        return ("menu", "main menu")
    if "PLAY GAME" in text and "Change tactics" in text:
        return ("PLAY GAME", "pre-match: PLAY GAME, Return")
    if "any other key to exit" in low:
        # the watched match's full-time screen: Space views the commentary, P prints it, Return is the
        # bench (T10-r0001 pressed Space here and stayed in the commentary viewer); n is "any other key"
        return ("n", "full-time screen of the watched match (any other key to exit): n")
    if "press any key" in low or "any other key to continue" in low or "hit any key" in low:
        return ("space", "any-key screen: Space")
    if "PLAYER CONTRACT" in text:
        return ("Return", "contract screen: Return (next category; on OFFER CONTRACT, offer the default terms)")
    if "(y/n)" in low:
        return ("n", "(Y/N) question: N")
    return None


def start_state(sav):
    """A driver.StartState for the savestate `sav`, its meta written once under START_STATES."""
    data = Path(sav).read_bytes()
    name = Path(sav).stem
    START_STATES.mkdir(parents=True, exist_ok=True)
    dst, meta_path = START_STATES / f"{name}.sav", START_STATES / f"{name}.json"
    if not dst.exists():
        shutil.copyfile(sav, dst)
    if not meta_path.exists():
        d = driver.Driver(workdir=driver.SCRATCH / "watched")
        meta = {"sha256": driver.sha256(data), "screen_digest": savestate.Savestate(data).screen().digest(),
                "game_dir": str(driver.GAME_DIR.resolve()), "drive_layout": d.drive_layout(), "config": d.config}
        meta_path.write_text(json.dumps(meta, indent=1))
    return driver.StartState(name, START_STATES)


def keep_state(run_id, tag, data):
    STATES.mkdir(parents=True, exist_ok=True)
    path = STATES / f"{run_id}-{tag}.sav"
    with open(path, "xb") as f:  # never overwritten
        f.write(data)
    return driver.sha256(data)


def intermediate_obs(step, label, sc):
    return [
        {"step": step, "source": "screen", "field": f"{label}: sha256 of the text page (an intermediate read, not a key wait)", "value": sc.digest()},
        {"step": step, "source": "ui-text", "field": f"{label}: text, CP437 decoded, trailing blanks trimmed", "value": sc.text()},
    ]


def play_week(d, obs, keys, run_id):
    """From the main menu to the next main menu. Returns the menu screen."""
    step, started = 0, False
    for _ in range(MAX_SCREENS):
        sc = d.screen()
        text = sc.text()
        step += 1
        rule = classify(text)
        if rule and rule[0] == "menu":
            if started:
                obs += weeks.screen_obs(step, "main menu after the week", sc)
                return sc
            screens.select(d, "PLAY NEXT GAME")
            d.keys("Return"); keys.append("PLAY NEXT GAME: Return")
            started = True
            time.sleep(SCREEN_WAIT)
            continue
        if rule is None:
            # A screen weeks.py does not answer at once: read it slowly while it changes.
            t0, reads, still, last, live = time.monotonic(), 0, 0, None, sc
            obs += weeks.screen_obs(step, f"screen {step} (match, first read)", sc)
            while True:
                if sc.digest() == last:
                    still += 1
                else:
                    still = 0
                    if last is not None:
                        reads += 1
                        if reads % INTERMEDIATE_EVERY == 0:
                            obs += intermediate_obs(step, f"screen {step}, read {reads} (after {round(time.monotonic() - t0)} s)", sc)
                last = sc.digest()
                if still + 1 >= STALL_READS:
                    break
                if time.monotonic() - t0 > MAX_LIVE:
                    obs += weeks.screen_obs(step, f"screen {step} (match, last read)", sc)
                    raise RuntimeError(f"screen {step} still changing after {MAX_LIVE} s; stopping")
                time.sleep(MATCH_POLL)
                live = sc
                sc = d.screen()
                text = sc.text()
                if classify(text) is not None:
                    break
            rule = classify(text)
            if rule is None:
                if not is_match(text):
                    obs += weeks.screen_obs(step, f"screen {step} (an unknown screen, unchanged for {STALL_READS} reads)", sc)
                    raise RuntimeError(f"an unknown screen (step {step}); stopping")
                obs += weeks.screen_obs(step, f"screen {step} (match, unchanged for {STALL_READS} reads)", sc)
                obs.append({"step": step, "source": "save", "field": f"screen {step}: sha256 of the savestate of this read (.cache/states/T10/)",
                            "value": keep_state(run_id, f"s{step:03d}", d.last_blob)})
                d.keys("space"); keys.append(f"match screen unchanged for {STALL_READS} reads: Space")
                time.sleep(SCREEN_WAIT)
                continue
            # the changing screen gave way to a known one: record the change, then answer that one below
            obs += weeks.screen_obs(step, f"screen {step} (match, last read)", live)
            step += 1
            if rule[0] == "menu":
                obs += weeks.screen_obs(step, "main menu after the week", sc)
                return sc
        obs += weeks.screen_obs(step, f"screen {step}", sc)
        obs.append({"step": step, "source": "save", "field": f"screen {step}: sha256 of the savestate of this read (.cache/states/T10/)",
                    "value": keep_state(run_id, f"s{step:03d}", d.last_blob)})
        if rule[0] == "PLAY GAME":
            screens.select(d, "PLAY GAME"); d.keys("Return")
        else:
            d.keys(rule[0])
        keys.append(rule[1])
        time.sleep(SCREEN_WAIT)
    raise RuntimeError(f"no main menu after {MAX_SCREENS} screens")


def main(argv=None):
    ap = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    ap.add_argument("--state", default=str(DEFAULT_STATE), help="the start savestate (a main menu)")
    ap.add_argument("--out", default="runs/T10")
    a = ap.parse_args(argv)
    dirty = cycle.git("status", "--porcelain", "--", "runtime/driver")
    if dirty:
        raise SystemExit("uncommitted changes under runtime/driver/: commit them first so code_commit names the code that ran\n" + dirty)
    commit = cycle.git("rev-parse", "--short", "HEAD")
    out_dir = ROOT / a.out
    out_dir.mkdir(parents=True, exist_ok=True)
    # run numbers also skip savestates kept by a run that left no record (T10-r0001, interrupted)
    rep = 1 + max([int(p.stem.split("-r")[1]) for p in out_dir.glob("T10-r*.json")]
                  + [int(p.stem.split("-")[1][1:]) for p in STATES.glob("T10-r*.sav")], default=0)
    run_id = f"T10-r{rep:04d}"
    st = start_state(a.state)
    d = driver.Driver(st.config, workdir=driver.SCRATCH / "watched")
    obs, keys, status = [], [], "completed"
    started = driver.host_times()["utc"]
    try:
        try:
            sc = d.launch(st)
            obs += weeks.screen_obs(0, "the start state restored", sc)
            play_week(d, obs, keys, run_id)
        except Exception as e:  # noqa: BLE001
            status = f"aborted: {type(e).__name__}: {e}".splitlines()[0][:300]
            traceback.print_exc()
        end_sha = keep_state(run_id, "end", d.last_blob) if d.last_blob else None
    finally:
        d.terminate()
    obs.append({"step": 999, "source": "save", "field": "sha256 of the savestate of the last read (kept in .cache/states/T10/, copied to the owner's Drive)", "value": end_sha or "none"})
    obs.append({"step": 999, "source": "log", "field": "waits, polls and key holds, seconds since launch", "value": json.dumps(d.events, separators=(",", ":"))})
    start = {"id": f"{Path(a.state).stem} end savestate", "sha256": st.sha256,
             "restore": "fresh DOSBox-X process; C: mounted from a copy of One-Nil 96's files (records/T01/inventory.json); "
                        "1-0 run to its title screen, a key, then the savestate loaded (driver.Driver.launch, the load key) "
                        "and its screen digest awaited; host clock not controlled"}
    rec = weeks.base_record(d, run_id, "T10", rep, commit, start, obs, status, started, keys)
    rec["arm"] = "watched-week"
    rec["actions"]["script"] = "runtime/driver/watched.py"
    rec["actions"]["sha256"] = driver.sha256(Path(__file__).read_bytes())
    rec["actions"]["settings"] = {"MATCH_POLL": MATCH_POLL, "STALL_READS": STALL_READS, "SCREEN_WAIT": SCREEN_WAIT,
                                  "MAX_LIVE": MAX_LIVE, "INTERMEDIATE_EVERY": INTERMEDIATE_EVERY}
    rec["interventions"].append({"level": "I2", "what": "the start state loaded into a running DOSBox-X (a restore)"})
    weeks.write(rec, out_dir)
    return 0 if status == "completed" else 1


if __name__ == "__main__":
    sys.exit(main())
