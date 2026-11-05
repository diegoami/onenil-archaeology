# onenil-archaeology

Evidence for a faithful rebuild of *One-Nil* (Wizard, 1995/1996): findings, run records and the
Python tools that produce them. The rebuild is [onenil](https://github.com/diegoami/onenil). No
byte of the original game is in this repository; see [docs/artifacts.md](docs/artifacts.md).
Rules: [CLAUDE.md](CLAUDE.md). Process: [docs/process.md](docs/process.md).

## Public checks

From a fresh clone, with Python 3.12 or newer (Linux or WSL shell):

```sh
python3 -m venv .cache/venv
.cache/venv/bin/python -m pip install -r requirements.txt
.cache/venv/bin/python -m pytest -q tests
.cache/venv/bin/python tools/check_originals.py
```

The committed decoded observations suffice for the public corpus checks. Tests requiring the
original game skip when its private artifacts are absent. Native Rust/PyO3 replay and build
commands are in [onenil's README](https://github.com/diegoami/onenil#readme).

To continue on another computer, follow [Stop and resume](docs/process.md#4-stop-and-resume),
then [restore private artifacts](docs/artifacts.md#restoring-on-another-computer) only if the next
task needs new runs of the original. Current task status is in the checkpoint issues, not here.

The original full watched-match reference can be verified without private game
bytes:

```sh
.cache/venv/bin/python runtime/emul/watched_complete.py --check
.cache/venv/bin/python runs/T40/audit_completed.py
```

See [proposed F40](findings/F40.md) for counts,termination evidence and the
important distinction between the retained scratch-goal field and a running
score. This reference does not deliver a native playable match.

## Original-game manual and management roadmap

[Owner-directed roadmap](docs/roadmap.md): play and document the original
with screenshots, audit rebuild gaps, decide UI technology, then implement
a complete management week and season. The [manual](docs/manual/README.md)
keeps observed workflows separate from unvisited paths.
