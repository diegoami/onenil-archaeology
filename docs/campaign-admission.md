# Initial saved PSG preparation (T66)

[confirmed] `runs/T66/admission-r0001.json` and `admission-r0002.json`
execute the original One-Nil96 code from the same authenticated main-menu state.
The supplied SAVE1/ENGL-95 projection matches accepted T65: Blackburn R130,
manager Dalglish, week0, cash452000, next fixture slot1 at home against PSG17.
The game's already-enabled Watch setting is retained. All keys enter through the
existing IRQ1 keyboard handler. No guest gameplay data, RNG or selected players
are patched, and no Sheffield input values are used.

The existing calibrated Guest BIOS/DOS/timer/IRQ services remain in use; an empty
intervention list means no additional gameplay-data mutation, not a claim of
service-free DOSBox execution. This new case has no separate DOSBox event-stream
parity claim yet.

The observer records original sites E24C/E24F/86E9/E2D4/E2D9/E2EF/E303/E008/
7D86/7DC8/7C67 in segment0AB9. Its selected-squad/read-set projection is derived
from the actual pre86E9 observations; the first watched state is an assertion,
not an incoming seed. The two executions reproduce every named observation and
all258 ordered draws. Selector preparation uses255 draws; three later setup
calls reach the first watched entry. An additional incoming supplement joins the
same pre86E9 state and ordered draw prefix, observing management mode, previous
income and queue-zero scratch values without importing old-fixture defaults.

[confirmed] This source profile differs from the existing native exhibition:

| Field | Initial PSG capture | Existing native setup guard/profile |
| --- | --- | --- |
| Fixture/config index |1|6|
| Selected club order |17,130|130,134|
| Managed club |130, second side|130, first side|
| Incoming previous-match clock kind |0|45|
| Incoming quick gate |0|1|
| Reserve allowance |0|1|
| Reserve cell index/value |0/9|1/2|
| Watch/start-gate input |1|0 in the earlier pre-intervention input|
| Previous income |0|30989|

The table describes incoming scratch/configuration, not inferred substitution rules.
Original19CA replaces the pre-call seed23260 with season×58+week =59 before
the selector draws; the actual pre86E9 seed is40860. The
 first-entry seed/RNG/scenes and full
named context are recorded. These are source observations, not an arbitrary
replacement seed for the native editor. Existing native guards in
`engine/src/setup.rs` belong to their established profile; do not weaken them or
change this captured data merely to pass. These differences explain why changing
fixture labels on the old exhibition cannot implement the saved PSG match.

[derived] Next native work must construct a fresh-campaign preparation admission
from these source-backed fields, preserve observed side/fixture identity, and
match all first-entry fields and the RNG prefix before any live campaign result
is admitted. Additional strict memory-read coverage may be required beyond the
existing observer schemas. No complete native input importer, native PSG parity,
full-match completion, edited-XI parity, result transaction, week/table progression
or new-game setup is established by this capture. The legacy queue entry is raw
incoming scratch, not a claim that its words identify current match players.

Reproduce with the private original release and the T66 original start state
restored from the owner's private recovery folder described in docs/artifacts.md.
The original start-state identity is recorded in each public capture; original RAM
never enters git. The private recovery receipt records preservation. Run a new,
append-only record path:

```sh
python3 runtime/emul/campaign_admission.py --run <start-state.sav> --record runs/T66/<new-name>.json
python3 runtime/emul/campaign_admission.py --check runs/T66/admission-r0002.json --compare runs/T66/admission-r0001.json
python3 runtime/emul/campaign_admission.py --run <start-state.sav> --supplement-of runs/T66/admission-r0001.json --record runs/T66/<new-incoming-name>.json
python3 runtime/emul/campaign_admission.py --check runs/T66/incoming-r0001.json
```

Public checks need no original bytes; capture additionally needs the authenticated
private start RAM and unmodified original release. The observer and dependencies
must be committed before execution. Source aliases, provenance and payload digests
are checked; fixture/roster/seed/projection corruptions are rejected.
