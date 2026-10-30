# F15 Complete raw ratings inputs let the native consumer compute the helper predicates and hand off all 558 quick contests

- **Status**: proposed
- **Task**: T15 (#75)
- **Edition**: 96.
- **Sources**: `static/1-0-exe/ratings-contract.md`, the 1B55 listing at `da4f9af`,
  `runtime/emul/ratings.py` at producer `b2ec147`, `runs/T15/T15-r0001.json`…`r0006.json`,
  `traces/T15/index.json`, and the retained T09/T11/T08 sources named and hashed by those exports.
- **Check**: `python3 runtime/emul/ratings.py --check`. This reads public decoded observations;
  neither the original nor private savestates are needed for the checker. No Python ratings or
  predicate model is added.

## Answer

1. `[confirmed]` All six new original-code weeks reproduce the complete prior T09 projections:
   **12,614 player values, 2,495 club bonuses, 1,128 side calls and 558 D983 entries**. Every new
   week's events and ordered DOSBox-X waits match the retained corpus. Exact T11 input/output
   and draw spans link all 558 contests to **15 T08 references** through six distinct full draw
   streams. Their original start-state identities and all source/record/fixture digests are pinned.
2. `[confirmed]` The side cases now include complete eleven-player rosters and referenced raw
   player/staff fields, the class/divisor/halving tables, all eight before/after rating words,
   seed/draw boundaries and actual nested helper results. Exact indices anchor those helper
   calls in the all-player/all-bonus streams. Expected predicate returns are outputs only;
   unavailable calls retain `halved:null` and no selector returns rather than a fabricated input.
3. `[confirmed]` `4F89` rejects player zero, signed r15 byte +8 below 1, or set mask A6h in r15
   byte +0Bh (4F9D..4FF9). `4E81` looks up `129E[14*12BA[player%3]+r8[7]]`; `4F05` tests this
   byte, position and r8 byte +7, with one or two actual selector calls depending on its first
   short-circuit branch (4E85..4F82). The static contract defines these rules, arithmetic widths,
   raw tables and precise return boundaries for the Rust consumer.
4. `[confirmed]` `50EB` obtains the staff bonus **before** clearing its side's four words
   (5103..5126). It calls `4B4A` with mode zero for each nonzero roster ID, adds the bonus only
   for a nonzero player result, and partitions that value by the position class, using a logical
   half before both split-class additions. A nonzero flag adds an unsigned fraction selected by
   club byte +37h. The other side's four words, seed and draw count are unchanged in every one
   of the 1,128 recorded calls. The twelve calls beyond twice the contest count are setup calls
   on side 1, not additional contests.
5. `[confirmed]` All 558 handoffs identify the latest actual call of each side in execution
   order. The first call's outgoing eight words equal the second's incoming words, and the
   second's output equals the literal T11 D983 input. Both calls preserve its incoming seed and
   draw boundary. This supplies a native composition test that computes ratings before entering
   D983, rather than loading expected rating words into that transition.

## Coverage and limits

`[confirmed]` The 12,408 mode-zero calls are nested in side ratings; 206 other player calls use
mode one. There are 12,576 available calls, all with `halved=0` and two selector returns, plus
38 rejected calls with no halving calls. The 25,152 actual selector returns include 14,752 ones
and 10,400 zeros. All fourteen positions and all fourteen selector-byte values occur. The tables
have one observed fixed set. Actual bonuses range from 21 to 29; staff byte +2 ranges 44..170.

`[confirmed]` The earlier branch counts remain unchanged: 12,410 available calls take signed
byte +6 below 32, 165 take neither adjustment, and one mode-one call takes the division branch.
No available call returns zero or 256; all 38 zeros are rejected players. Side 0's 558 calls
have flag one, side 1's 570 calls flag zero; club byte +37h is always nonzero (1 or 6), so the
flagged side uses divisor 16.

`[confirmed]` These original weeks do not exercise the +16 branch, either clamp, actual halving,
the first halving condition's one-call short circuit, divisor 64, negative sign-extended player
bytes (raw 128..255), zero
roster entries, duplicate roster IDs or staff ID zero. Their semantics are static readings with
separate synthetic native checks, not confirmations by these runs. The numeric fields' football
or staff-role meanings are not inferred here.

`[designed]` onenil T04 consumes byte-identical exports, computes predicates/values from raw inputs
and composes actual ratings into D983 without expected outputs steering updates. This remains a
routine slice: native setup/clock/player/event integration, full DD02/match/week replay, watched
engine, timer/scratch/whole-memory and rendered-output parity are outside this finding. F15 remains
proposed; the data audit does not by itself accept a finding or complete O-M3a.
