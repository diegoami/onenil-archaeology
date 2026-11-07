# T71 long original capture job

[designed] The local runner executes T70's full original continuation and then a fresh independent
repeat, using the preserved private T66 start. It never publishes observations. The original
observer verifies retained chunks on replay and only appends new leaves; no old T70 record is
edited. A completed edited match is claimed only after the real return and full repeat checker.

Run on branch `task/T71-edited-full` after committing the runner and observer dependencies:

```
.cache/venv/bin/python tools/edited_capture_job.py --state .cache/driver/manual/T41-r0002/state.sav > .cache/T71-full.log 2>&1
```

The control file `.cache/recovery/T71-job.json` records the runner/child PIDs, phase, error or
completion. The log shows actual original chunk progress. `running` is never completion.
The runner checks new observations and commits local checkpoints at least every ten minutes,
retrying an in-progress writer snapshot. Receipts under `runs/T71/checkpoints/` bind precisely
which verified leaves were committed. These are retained-prefix counts, not an assertion of a
new attempt's replay position. No git push or network operation exists in the runner.

[designed] Checkpoints refuse foreign/symlinked/non-JSON leaves, changed tracked files, an existing
staged index, wrong branches, failed proof validation and file changes during verification.
Only validated stream leaves and their new immutable receipt are staged. Failed/interrupted
original attempts are classified separately and cannot become completed-match evidence.
Unknown services or malformed failure evidence stop checkpointing for explicit investigation.

To stop, send SIGINT only to the runner PID recorded in its control file. It interrupts/reaps its
owned child and attempts a last validated local checkpoint; the control file records interruption
or failure. Restart the same command on the same branch. A retained partial prefix is replayed
from the authenticated private start, checked and extended; a verified complete pair is reused.
This may take hours, but preserves original execution rather than importing expected state.

Public verification after the complete pair exists:

```
python3 runtime/emul/edited_watched.py --check --directory runs/T70/reference-r0001
python3 -m pytest -q tests/test_edited_capture_job.py tests/emul/test_edited_watched.py
```

The bounded checker remains applicable to the old64-tick proof. Full publication still needs its
payload checks/authorization, exact-head CI and pinned research merge. Native edited-XI admission
is unchanged; full source evidence and any missing incoming support must precede native parity.
