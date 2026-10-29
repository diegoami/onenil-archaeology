# Environment

What a session needs to run the original (T04, F04) and the static tools (T02).

- **Python** 3.11 or later; `pip install -r requirements.txt` (pytest, capstone 5.0.9) into a venv,
  e.g. `.cache/venv`.
- **The game files**: `python3 tools/artifacts.py pull` (docs/artifacts.md) into `.cache/`.
- **DOSBox-X 2024.03.01**, exactly: the driver refuses another version (its savestate layout is the
  one the screen reader is calibrated to, goal2's F001). Ubuntu 26.04's apt has only 2026.01.02;
  `bash setup/dosbox-x-2024.03.01.sh` unpacks Ubuntu 24.04's package into `~/tools/dosbox-x-2024.03.01`
  without sudo (shared with goal2-archaeology). `$DOSBOX_X` overrides the path.
- **Xvfb and xdotool** (apt), for the headless display and the window search; keys go as raw XTEST
  keycodes (`runtime/driver/xkeys.py`).
- **Ghidra 12.1.4 and a JDK 21** under `~/tools` (or `GHIDRA_HOME`, `JAVA_HOME`), only for
  `tools/static/decompile.sh`.

`bash setup/onenil-runtime.sh` checks the run's needs and prints `ready`.

Running: `python3 runtime/driver/cycle.py --runs 10 --start-state title` (the cycle);
`python3 runtime/driver/weeks.py --weeks N` (load SAVE1.1-0 and play on). Both refuse to run with
uncommitted changes under `runtime/driver/`, so a record's `code_commit` names the code that ran.
Run them one at a time: they share the game folder `.cache/driver/game`. Savestates go to
`.cache/states/T04/` and to the owner's Drive (`rclone copy .cache/states/T04 onenildrive:states/T04`),
never to git. Never press F1 under the driver (goal2: the help viewer breaks every later savestate).
