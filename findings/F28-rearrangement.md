# F28 Targeted rearrangement couples five exchanges and moves a scene selector

- **Status**: proposed
- **Task**: T28 (#102)
- **Edition**: 96.
- **Sources**: original `runs/T28/T28-r0001.json`, decoded
  `traces/T28/T28-r0001.jsonl` and manifest at `d598c29`; observer producer
  `3c29a9e`; static contract/listings at `3c29a9e` and `cdbcf8a`.
- **Check**: `python3 runtime/emul/rearrangement.py --check`; no private bytes.

`[confirmed: T28-r0001 at d598c29]` The selected original week T04-week-r0017
contains two ordered AEB8→164F refreshes, arguments [14,8,1] then [13,6,1].
Both consume zero draws. The new run reproduces the retained T26/T25/T23/T22/
T20/T16 observations, T08 week events and ordered DOSBox-X comparison for this
week. It uses the same original game and start-state digests.

`[confirmed: same record]` The first refresh performs three transactions on
side0, exchanging slots (8,9), (9,10) and (10,11). Each transaction contains five
ordered original helper calls: a roster word, local role byte, complete 25-byte
scene, event-total word and cache-selector byte. Typed before/after participant
values show each exchange. After the five helpers, caller marks show secondary
D0A0 moving 19→20→21→22. Actor D09F stays5. The second refresh has no exchanges;
secondary stays22 and actor stays5. The triggering replacements belong to side1,
so rearrangement effects cannot be restricted to the triggering side.

`[confirmed: same record]` Across both refreshes the measured direct events are:

| Kind | Count |
| --- | ---: |
| Sum availability | 44 |
| Role availability | 44 |
| Division | 4 |
| Roster / role / scene / event / cache exchange | 3 each |
| Caller selector mark | 3 |
| Scene assignment | 44 |
| Opaque tail helper | 10 |

There are161 helper calls and3 caller marks. Both invocations scan each side's
eleven entries in each availability phase and assign all22 scenes. The four
division calls observe raw CPU class2 and denominator22: side0 dividend2060
returns quotient93/remainder14, and side1 dividend1837 returns83/remainder11,
repeated in the companion refresh. Python records these registers; it does not
evaluate availability, sorting, division or assignment decisions.

`[confirmed: listings at cdbcf8a, 0AB9:164F–199F]` The caller visits both sides,
uses strict unsigned local-role comparisons, performs the five coupled exchanges,
and reindexes actor/secondary using physical scene indices. Scene assignments
follow each side's exchanges. Five final helpers remain opaque; after them the
caller clears scene1 and12 word12. The checker binds these boundaries and state
continuations without claiming a complete read set for the opaque callees.

`[designed: T28]` Root snapshots add actor, secondary and CPU class to complete
T26 named context. Availability calls retain canonical player and roster inputs;
local roles are stack observations, scenes are individually decoded fields, and
pointer identities are checked live without export. Source record, fixture and
manifest digests bind the original provenance. Negative tests reject missing or
reordered phases, partial transactions, inconsistent exchanges, malformed typed
values, selector discontinuity and altered provenance.

`[designed]` This is one selected week and two of the retained25 refreshes.
It does not establish the other weeks' transaction census, actor movement cases,
complete callee inputs, arbitrary signed division behavior, physical scratch/
flags/register/render/timer parity, native implementation or continuous AI/DD02/
match/week parity. F28 remains proposed pending an independent check.
