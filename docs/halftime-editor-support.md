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
post-replacement snapshot. The independent second session0357be3 agrees; repeat-r0001 binds both runs and input extractions.

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

[confirmed:runs/T75/inputs-r0002.json and inputs-r0003.json] Native retry then
identified DS:037E's initial write baseline at CCB2. This byte is the editor
player cursor; CCB2 stores1 before ordinary Down moves it. Both authentic
halftime states independently read1 at this concrete field. No broad memory
range was copied. Selected-team CONFIG+4 also independently remains1.

[confirmed:static1d6b5b9,CBF0;232A:052F..0545] CBF0's template calls at
CD74/CD90/CDA1/CDB6/CE1F and the player panel's1B55:479A use the same generic
232A:052F destination-page copy. It obtains the destination through its passed
header, passes the template to24BC:0000, and restores its frame. The existing
T41 presentation-boundary evidence owns that generic copy. Native projection
admission must retain the exact source template/caller/header and owned interval
checks; this does not permit bypassing editor/gameplay algorithms.

[designed:recovery] Both original processes exited. Private boundary states are
also packed in ignored `.cache/recovery/T75-editor-states-r0001.tar.gz`,
6,183,224 bytes, SHA256
`4fb1933638c4c8d4270b6ed161ff8b8043415e556396d3eee3e100c6e80be5f5`.
The upload to the owner's private1-0 Drive folder is pending archive-specific
approval after automatic approval review rejected it. Local states remain
available; no private bytes are published with these records.

[confirmed:runs/T75/inputs-r0004.json,inputs-r0005.json,repeat-r0002.json]
The reached player-panel dispatch95B6 reads DS:9A2A. Both original halftime
states independently yield1, selecting the1B55:478C panel. This third bounded
input is separate from the selected-team and player-cursor baselines.

[confirmed:static1d6b5b9,232A:0098..00D2;C866] The warning helper first copies
its supplied string into local scratch, then calls24BC:0702 only if the supplied
predicate is nonzero; it returns the original predicate byte inAL. C866 computes
and immediately tests each predicate. For false predicates the helper has only
local scratch effects; no warning is shown. The original successful T74/T75
transaction independently establishes the non-warning successful path. Native
projection may retain this false-only return under exact C866 caller/string
checks, while refusing every true predicate; the eligibility computation stays
in original C866. This avoids embedding original warning-string bytes.
