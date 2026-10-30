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
