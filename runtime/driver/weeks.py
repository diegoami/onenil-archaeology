#!/usr/bin/env python3
"""T04: load SAVE1.1-0 in One-Nil 96 and play it on week by week, one run/1 record per step.

    python3 runtime/driver/weeks.py --weeks 10 [--out runs/T04]

One DOSBox-X session: launch 1-0 to its title screen, answer Y to "Do you want to load a saved game"
and wait for the main menu (record T04-load-r<nnnn>: the screens, and whether a purchase or
registration text appears); turn "Watch match" off in Game configuration (an in-game option, so a
week's match is played without the watched pitch); then for each week select PLAY NEXT GAME, play the
game from the pre-match screen, pass every "press any key" and "any other key to continue" screen
with Space, answer N to any (Y/N) question, offer an expiring contract on the default terms (Return
through the PLAYER CONTRACT categories), until the main menu is back (record T04-week-r<nnnn>,
starting from the savestate the previous record ended with). Stops at a screen it does not know, and
records it. Savestates (they hold the game's memory) are kept in .cache/states/T04/ and pushed to
the owner's Drive, never to git; records hold their sha256 (CLAUDE.md rule 14).

Reads wait 3 s after the load question before the first savestate: savestates taken while the game
was still reading SAVE1.1-0 crashed DOSBox-X 2024.03.01 ("buffer overflow detected", exit -6) in
this task's first exploration; reads after that wait did not.
"""
import argparse
import json
import platform
import sys
import time
import traceback
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import cycle  # noqa: E402
import driver  # noqa: E402
import screens  # noqa: E402

ROOT = driver.ROOT
STATES = ROOT / ".cache" / "states" / "T04"
LOAD_WAIT = 3.0       # seconds after Y before the first savestate (see the docstring)
SCREEN_WAIT = 2.0     # seconds after a key that changes the screen, before the next read
MAX_SCREENS = 80      # screens per week before the week is called stuck
NEEDLES = ("REGISTER", "purchase", "Runtime error")  # texts a screen must not show


def screen_obs(step, label, sc):
    text = sc.text()
    return [
        {"step": step, "source": "screen", "field": f"{label}: text screen 80x25, chars+attributes (4000 bytes), sha256", "value": sc.digest()},
        {"step": step, "source": "ui-text", "field": f"{label}: text screen rows 0-24, CP437 decoded, trailing blanks trimmed", "value": text},
        {"step": step, "source": "ui-text", "field": f"{label}: which of {', '.join(NEEDLES)} the screen shows",
         "value": ", ".join(n for n in NEEDLES if n.lower() in text.lower()) or "none"},
    ]


def keep_state(run_id, data):
    STATES.mkdir(parents=True, exist_ok=True)
    path = STATES / f"{run_id}.sav"
    with open(path, "xb") as f:  # never overwritten
        f.write(data)
    return driver.sha256(data)


def write(rec, out_dir):
    text = json.dumps(rec, indent=2, ensure_ascii=False) + "\n"
    if str(ROOT) in text or "/home/" in text:
        raise SystemExit(f"{rec['run_id']}: a host path leaked into the record")
    with open(out_dir / f"{rec['run_id']}.json", "x", encoding="utf-8") as f:  # never overwrite
        f.write(text)
    print(f"{rec['run_id']}: {rec['status']}")


def base_record(d, run_id, experiment, rep, commit, start_state, obs, status, started, keys):
    conf_text, conf_sha = d.conf_public()
    return {
        "schema": "run/1", "run_id": run_id, "experiment": experiment, "arm": "save1-weeks", "rep": rep,
        "code_commit": commit, "machine": cycle.machine_id(),
        "artifact": {"set": driver.verify_release(driver.CACHE), "variant": None},
        "runtime": {"driver": f"runtime/driver/driver.py@{commit}", "platform": f"python-{platform.python_version()}/{cycle.machine_id()}",
                    "fingerprint": cycle.fingerprint(d, conf_sha)},
        "interventions": [
            {"level": "I1", "what": "text screens read from DOSBox-X savestates (component Vga)"},
            {"level": "I2", "what": "a savestate is written at each read (save of emulator state; neutrality not tested)"},
        ],
        "start_state": start_state, "seed": None,
        "actions": {"script": "runtime/driver/weeks.py", "sha256": driver.sha256(Path(__file__).read_bytes()), "keys": keys},
        "observations": sorted(obs, key=lambda o: o["step"]), "outputs": [],
        "started": started, "ended": driver.host_times()["utc"], "status": status,
    }


def play_week(d, obs, keys):
    """From the main menu to the next main menu. Returns the menu screen."""
    step = 0
    screens.select(d, "PLAY NEXT GAME")
    d.keys("Return"); keys.append("PLAY NEXT GAME: Return")
    time.sleep(SCREEN_WAIT)
    for _ in range(MAX_SCREENS):
        sc = d.screen()
        text, low = sc.text(), sc.text().lower()
        step += 1
        if "GAME NAME" in text and "PLAY NEXT GAME" in text:
            obs += screen_obs(step, "main menu after the week", sc)
            return sc
        obs += screen_obs(step, f"screen {step}", sc)
        if "PLAY GAME" in text and "Change tactics" in text:
            screens.select(d, "PLAY GAME"); d.keys("Return"); keys.append("pre-match: PLAY GAME, Return")
        elif "press any key" in low or "any other key to continue" in low or "hit any key" in low:
            d.keys("space"); keys.append("any-key screen: Space")
        elif "PLAYER CONTRACT" in text:
            # Return steps through the categories to OFFER CONTRACT and then offers the terms shown
            # (the game's defaults): the player is kept. A game decision, recorded with the keys.
            d.keys("Return"); keys.append("contract screen: Return (next category; on OFFER CONTRACT, offer the default terms)")
        elif "(y/n)" in low:
            d.keys("n"); keys.append("(Y/N) question: N")
        else:
            raise RuntimeError(f"an unknown screen (step {step}); stopping")
        time.sleep(SCREEN_WAIT)
    raise RuntimeError(f"no main menu after {MAX_SCREENS} screens")


def main(argv=None):
    ap = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    ap.add_argument("--weeks", type=int, default=10)
    ap.add_argument("--out", default="runs/T04")
    a = ap.parse_args(argv)
    dirty = cycle.git("status", "--porcelain", "--", "runtime/driver")
    if dirty:
        raise SystemExit("uncommitted changes under runtime/driver/: commit them first so code_commit names the code that ran\n" + dirty)
    commit = cycle.git("rev-parse", "--short", "HEAD")
    out_dir = ROOT / a.out
    out_dir.mkdir(parents=True, exist_ok=True)
    rep = 1 + max((int(p.stem.split("-r")[1]) for p in out_dir.glob("T04-load-r*.json")), default=0)
    week_n = 1 + max((int(p.stem.split("-r")[1]) for p in out_dir.glob("T04-week-r*.json")), default=0)
    d = driver.Driver(workdir=driver.SCRATCH / "weeks")
    ok = True
    try:
        # ---- the load
        run_id, obs, keys, status = f"T04-load-r{rep:04d}", [], [], "completed"
        try:
            sc = d.launch(None)
            obs += screen_obs(0, "title screen", sc)
            d.keys("y"); keys.append("title: y")
            time.sleep(LOAD_WAIT)
            sc = d.wait_screen(lambda s: "PLAY NEXT GAME" in s.text() or "(Y/N)" in s.text(), 30, "after Y")
            obs += screen_obs(1, "after Y, the first screen that is a menu or a question", sc)
            if "PLAY NEXT GAME" not in sc.text():
                raise RuntimeError("Y did not lead to the main menu")
            screens.select(d, "Game config"); d.keys("Return"); keys.append("main menu: Game configuration, Return")
            time.sleep(SCREEN_WAIT)
            sc = screens.select(d, "Watch match")
            obs += screen_obs(2, "Game configuration before the change", sc)
            d.keys("Return"); keys.append("Game configuration: Watch match, Return (toggle)")
            time.sleep(1)
            obs += screen_obs(3, "Game configuration after toggling Watch match", d.screen())
            screens.select(d, "Continue"); d.keys("Return"); keys.append("Game configuration: Continue, Return")
            time.sleep(SCREEN_WAIT)
            sc = d.wait_screen(lambda s: "PLAY NEXT GAME" in s.text(), 20, "main menu")
            obs += screen_obs(4, "main menu, ready for week 1", sc)
        except Exception as e:  # noqa: BLE001
            status, ok = f"aborted: {type(e).__name__}: {e}".splitlines()[0][:300], False
            traceback.print_exc()
        end_sha = keep_state(run_id, d.last_blob) if d.last_blob else None
        obs.append({"step": 5, "source": "save", "field": "sha256 of the savestate of the last read (kept in .cache/states/T04/, pushed to the owner's Drive)", "value": end_sha or "none"})
        obs.append({"step": 5, "source": "log", "field": "waits, polls and key holds, seconds since launch", "value": json.dumps(d.events, separators=(",", ":"))})
        start = {"id": "fresh launch", "sha256": None,
                 "restore": "fresh DOSBox-X process; C: mounted from a copy of One-Nil 96's files (records/T01/inventory.json), SAVE1.1-0 among them; 1-0 run to its title screen; host clock not controlled"}
        write(base_record(d, run_id, "T04-load", rep, commit, start, obs, status, d.launched["utc"], keys), out_dir)
        prev = (run_id, end_sha)
        # ---- the weeks
        for w in range(a.weeks if ok else 0):
            run_id, obs, keys, status = f"T04-week-r{week_n + w:04d}", [], [], "completed"
            started = driver.host_times()["utc"]
            d.events.clear()
            try:
                play_week(d, obs, keys)
            except Exception as e:  # noqa: BLE001
                status, ok = f"aborted: {type(e).__name__}: {e}".splitlines()[0][:300], False
                traceback.print_exc()
            end_sha = keep_state(run_id, d.last_blob)
            obs.append({"step": 99, "source": "save", "field": "sha256 of the savestate of the last read (kept in .cache/states/T04/, pushed to the owner's Drive)", "value": end_sha})
            obs.append({"step": 99, "source": "log", "field": "waits, polls and key holds, seconds since launch", "value": json.dumps(d.events, separators=(",", ":"))})
            start = {"id": prev[0], "sha256": prev[1],
                     "restore": f"the same DOSBox-X session, continued from the end of {prev[0]} (its last savestate's sha256 given), not restored"}
            write(base_record(d, run_id, "T04-week", week_n + w, commit, start, obs, status, started, keys), out_dir)
            prev = (run_id, end_sha)
            if not ok:
                break
    finally:
        d.terminate()
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main())
