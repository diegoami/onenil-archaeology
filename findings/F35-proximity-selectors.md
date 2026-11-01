# F35 Original proximity selectors initialize and restore the same final values

- **Status**: proposed
- **Task**: T35 (#117)
- **Edition**: 96.
- **Sources**: T34 merged at `4b21d90`; observer/static producer `46ec8b5`;
  original `runs/T35/T35-r0001.json` and decoded exports `2a0216c`.
- **Check**: `python3 runtime/emul/proximity_selectors.py --check`; no private bytes.

[derived: listings at4b21d90,0AB9:21D7–2303,1CA1,1ECC,1CBB;
1B55:4F89 and24BC:0259]21D7's logical input set closes over retained T31
scene/player/availability/actor state plus CF46/47,D0AC,D0AE,A338/A339 and
D0A2/D0A4 selector pairs. It initializes near to offset+1 and ahead to0,
then visits slots2–11 per side. Unavailable players,the actor's scene.byte7,
and byte19==13 skip selection. Remaining candidates can improve nearest and
ahead selectors. Coordinate bytes/direction returns sign-extend; distance
threshold comparisons are unsigned,while the low-word product comparison
for ahead selection is signed. Ties preserve prior selectors. The complete
contract is in [proximity-selectors.md](../static/1-0-exe/proximity-selectors.md).

[confirmed: producer46ec8b5,record/export2a0216c] Two original calls from one
week retain40 visits,four side initializations,four near stores and zero ahead
stores. Helpers:40 original1CA1 plus40 nested4F89,36 calls at each1ECC site,
72 nested1CBB. Every interval is4025→4025. Each call has nineteen available
candidates,one unavailable,and one other actor skip;no byte19==13 skip.
Eighteen candidates per call receive both direction calls. Each direction site
returns255 nine times and1 nine times per call. Nested side results split18
between0 and1. The4F89 bit-helper census remains static,not independently
recorded here. All helper/visit scene rows are read-only.

[confirmed: same capture] Raw target[11,0],phase45,time34,signs[255,1] and
offsets[11,0] are constant. The near pair is[13,2] on entry and return;the
ahead pair is[0,0]. Side0 initializes near12 then slot2/physical scene13
stores13. Side1 initializes near1 then slot2/physical scene2 stores2.
Initialization/restoration therefore occurs even though the full named root
input equals output. Actual store branches and literal continuations are
recorded independently of distance or winner calculations.

[confirmed: immutable T34 rows at1ba264e] Side0/slot3 in F34 is physical
scene14 and previous13,not physical3/2. The earlier prose confused slot and
physical identities. This task corrects F34/static prose only; the original
record/fixture identities,word values and checks already used14/13 correctly.
No evidence is overwritten. T35 entry binds exact final T34 state,its endpoints
bind T28 context,and the complete original week retains all T34/T33/upstream
observers,T08 events and ordered DOSBox-X comparison.

[designed] Python records inputs,helper returns and actual selector stores,
then validates schema,branches,scene/player identities,literal continuations
and hashes. It does not calculate distances,directions,winners or product
comparisons. Public checks and mutation tests bind immutable provenance and
reject missing inputs/order,malformed results,broken stores and unrelated
writes. Byte19==13 skips,ahead stores,other input/sign/phase/target domains,
other weeks,managed/native/full AI and whole-match parity remain unestablished.
F35 awaits independent acceptance; this closes the last identified helper on
the targeted path,not all recorded-week coverage.
