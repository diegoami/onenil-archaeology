# F16 The deterministic quick-step prefix and caller clock have complete raw logical replay cases

- **Status**: proposed
- **Task**: T16 (#77)
- **Edition**: 96.
- **Sources**: `static/1-0-exe/step-tail.md`, the listings at `4f89d24`, producer
  `runtime/emul/step_tail.py` at `5ac76a9`, `runs/T16/T16-r0001.json`…`r0006.json`,
  `traces/T16/index.json`, and the retained T12/T13/T08 records named and hashed there.
- **Check**: `python3 runtime/emul/step_tail.py --check`; the public decoded records suffice.
  Neither the original game nor private savestates are needed to check the corpus.

## Answer

1. `[confirmed]` Six new original-code weeks reproduce the complete retained T12 observations
   and every T08 event/ordered DOSBox-X wait. The exports contain **558 DF35..DFDB prefixes,
   558 separate caller-clock transitions, 12,276 scene visits and 12 numeric termination events**,
   linked to **15 T08 references**. Literal T13 placement cases anchor each actual saved score,
   goal flag, temporary generated count, actor and seed entering the prefix. Source, fixture,
   record and original start-state identities are pinned; earlier observations are unchanged.
2. `[confirmed]` DF35 restores computed saved cumulative scores into D086/D087 and reversed
   D0C4/D0C5. The original history helper stores one byte using wrapping addition of side 0 and
   side 1 shifted four bits. The raw far base and selector are input observations; actual ES:DI
   at DF65 and the written byte are outputs, so expected destination metadata does not select
   the native write address. The prefix records both full raw scene/player snapshots and each
   sequential availability/update observation before the later event callees can change them.
3. `[confirmed]` Physical scenes 1..22 refer to shared player IDs. The original availability
   predicate rejects ID zero, signed byte8<1 or flags11&A6h. A rejected visit invokes 093F,
   writing D032 into that scene's word0. For an available player, unsigned remaining modulo5
   zero allows decrementing byte8 only when its signed value exceeds1. Capturing each actual
   visit avoids assuming that aliased IDs behave like separate copied records.
4. `[confirmed]` The caller clock is a separate observed boundary after unresolved late DD02
   effects. It checks active/delay, computes a wrapping remaining+added zero flag, decrements
   the appropriate word, conditionally increments elapsed, and reloads delay from byte D28.
   Termination compares zero-extended remaining with sign-extended kind, or uses the zero flag.
   The static contract specifies the original operand widths, including the two-word comparison.
5. `[confirmed]` Clock termination calls 1E14→0F94 with code 63 or64, actor 0, secondary 0, side 1.
   These are logical numeric commentary calls: the signed weight always adds into D16E, which
   aliases the older event-total projection's side 0 slot20. Queue acceptance controls side 1's
   event count, cyclic tuple insertion/next-row sentinel and paired-word copy, while duplicate
   rejection does not suppress the weighted event write. Acceptance is observed at 0FAD before
   formatting can clobber AL. The clock clears word CF51 after the call and returns 1.
6. `[confirmed]` Prefix output names the observed ordered late requests without implementing
   them: an optional DBC6 on the no-goal path, then 6B2F; or 1998:045C(1,0), then 52B6 on the
   goal path; always 78B7. Observed request counts are DBC6:184, 6B2F:541, 045C:17, 52B6:17 and 78B7:558.
   These callees have actual event, substitution, scene/reset, RNG or
   keyboard effects. A prefix result is therefore not a complete DD02 result or clock input.

## Coverage and limits

`[confirmed]` The 12,276 original visits include 2,406 changed raw byte8 values and 38 rejected
visits. Only one rejected visit changes scene word0; unchanged values still have observed calls.
The original cases contain no duplicate scene player IDs or zero player IDs. No negative
sign-extended byte8 values occur. History uses far base 6B70:0000 with selector bytes 1..6;
arbitrary far-pointer overlap with DS/player/scene/queue storage is outside the native projection.

`[confirmed]` All recorded clock inputs have active 1, delay 0 and zero 0; kind is 45. The reload byte is 32 in all 558 calls; DD02 clears its delay before the next
clock boundary. There are six
code 64 half-boundary terminations and six code 63 zero-sum terminations. Their event weights are
zero, every event is accepted and their source/target pairs already agree. CF51 starts zero.
These observations confirm the literal captured boundary but do not demonstrate a nonzero
weighted addition, a changed paired-word copy or clearing a nonzero CF51.

`[designed]` Native synthetic tests cover aliases/zero IDs, signed byte thresholds, packed-score
addition outside ordinary nibbles, wrapping pointer offsets, all clock early/late branches,
negative kind bytes, elapsed saturation, nonzero weights, duplicate/empty/wrapping queues,
unequal pairs and nonzero CF51. Expected states and helper outputs remain assertions only.
The composed native replay uses actual placement results and seed/image guards rather than
loading expected handoffs. No new Python engine model is added.

`[designed]` DBC6, 6B2F, 52B6 and 78B7 effects remain explicit pending dependencies; no direct
prefix-to-clock composition across them is claimed. Full DD02/match/week replay, watched-engine,
formatted/rendered output, timer/scratch/whole-memory parity and O-M3a completion remain pending.
F16 stays proposed; independent data verification does not by itself accept the finding.
