# F33 Reached role-cache calls have recorded scoring inputs and nested returns

- **Status**: proposed
- **Task**: T33 (#113)
- **Edition**: 96.
- **Sources**: T31/T32 merged at `03288c0`; observer/static contract `89252c4`;
  original `runs/T33/T33-r0001.json` and decoded exports `c7fc301`.
- **Check**: `python3 runtime/emul/role_scoring.py --check`; no private bytes.

[derived: listings at89252c4,0AB9:1455–1538,1AE2–1BD3,8973–89FF,9F6E–9FCD]
The reached1455 logical input set closes over T31's named state plus D29,
D1CE/D1CF,09FB+criterion, actual indexed957D/96B1 table bytes and first-eleven
player-club rosters. Canonical P8+4/+5/+7 aliases determine the normalized
16-bit indices; the observer reads each cell directly, including at nested
9F6E entry. It never infers a table cell from a score. The complete bounded
contract and arithmetic/calling conventions are in
[role-scoring.md](../static/1-0-exe/role-scoring.md).

[confirmed: c7fc301] Eight original1455 boundaries from T04-week-r0017 preserve
exact T31 input/output context and event order. All are side1 club134, kinds2–5
and criteria13/21/22/4, repeated across two enclosing replacements. Each
snapshot adds36 canonical lookup rows and club rosters130/134.82 candidates
produce82 availability calls (all return0),74 slot calls,148 score calls and
148 nested9F6E calls.27 actual1511 store branches comprise eight first-candidate
stores and19 later stores. Two observed score ties retain the previous player.
Kinds2–4 visit ten candidates per call; kind5 visits eleven.

[confirmed: same capture] Final role-cache players per replacement are
[2664,2669,2668,2661] and[2672,2669,2668,2661]. The first kind4 call changes
2669→2668; the second kind2 changes2664→2672. Cache clearing and intermediate
stores are recorded even where the final value equals entry. Helper/scene
identities distinguish player IDs,roster slots and physical scenes. Score
returns span5–131, nested table returns17–175. Every root/helper draw interval
is4025→4025. All score-scene rows are read-only; root snapshots allow only
the selected cache word to differ. The original week retains exact T31/T30/
T29/T28/T26/T25/T23/T22/T20/T16 observations, T08 trace and DOSBox-X comparison.

[confirmed: same capture] Scored raw P15+6 values are2,5,10,12,13,16,18,19,25,27.
All fall within the admitted0–31 domain. D29=1,D1CE/D1CF=[1,1]; the criterion
cell is0 for13 and1 for21,22,4. All148 score-scene byte22 values are0, leaving
the logical-halving branch unobserved. Static code shows that signed P15+6
values32–127 with a zero selected flag add to an uninitialized local; arbitrary
scratch is outside this contract. The observer diagnoses unsupported raw values
rather than inventing zero. Negative raw signed domains are also excluded.

[designed] Python records original helper returns and taken store branches,
then validates schema, literal continuity, read sets, pointer identities and
provenance. It does not compute scores,availability,winners or comparisons.
Public checks reconstruct exact decoded cases and bind source/manifest/static
hashes; mutation tests reject missing/malformed inputs,changed observations,
unsupported domains,wrong order/pointers and unrelated writes. Unobserved
availability branches,missing roster players,scene halving,D29-off/other flag
branches,other weeks,managed fallback,3155/21D7,native replay and whole-match
parity remain separate. F33 has not had independent acceptance.
