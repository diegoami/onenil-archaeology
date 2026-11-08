# Fresh halftime editor input support

[confirmed:T74,1d6b5b9] The original Pearce→Gale transaction is documented in
[halftime-replacement.md](halftime-replacement.md). This follow-up authenticates
bounded inputs needed to execute that same editor path in the native engine.

[confirmed:static1d6b5b9,0AB9:D1DD..D23B] D1DD compares the inspected club with
DCBA/DCBB. For the first managed club D1F1 stores1 through the far pointer at
DS:D7D2 plus4; the second managed club branch D20F stores2. CBF0 then reads the
selected managed-club index. This is a managed selection, distinct from the
club's home/away side in the watched match. D23A returns without restoring it.

[confirmed:runs/T75/session-r0001.json,producer42ae2c6] A new original process
completed the established ordinary-key procedure. Selected-team CONFIG+4 was1
at every observed boundary, including halftime, Players, pick/cancel, confirm,
bench return and second-half elapsed47. The original transaction still changes
capacity7→6 exactly once. Its pointer offset/segment, physical field address,
value, stage, rendered-screen and private savestate digests are retained.
`inputs-r0001.json` extracts just this concrete D1F1 incoming write baseline
from the authenticated halftime state; it is not a guessed zero or an expected
post-replacement snapshot. Independent repeat is still pending.

[designed:T75] Private boundary savestates are retained under the ignored
`.cache/T75-original-rNNNN` directories for bounded later queries. Each extraction
first checks the source record's producer/release/transaction, then hashes the
actual private state against the corresponding committed observation. Queries
must name a stage, area, offset, width and concrete source consumer. Publish
only requested numeric input facts; original bytes never enter git.

```sh
python3 runtime/driver/halftime_editor_support.py --run runs/T75/session-NEW.json --scratch .cache/T75-original-NEW
python3 runtime/driver/halftime_support_query.py --source runs/T75/session-NEW.json --scratch .cache/T75-original-NEW --queries runs/T75/query-requests-r0001.json --output runs/T75/inputs-NEW.json
python3 -m pytest -q tests/test_halftime_editor_support.py tests/test_halftime_replacement.py
```

Native#166 remains an unfinished draft; desktop replacement controls and
substituted full-match parity are not established by this source input record.
