# F26 Original replacement rebuilds have a closed observed lookup input set

- **Status**: proposed
- **Task**: T26 (#98)
- **Edition**: 96.
- **Sources**: T25 at `9fbab34`; original observer at `fa6f9c5`; six completed
  runs/exports and manifest at `0808e11`; reader at `a28c68f`, target checks at `9461079`.
- **Check**: `python3 runtime/emul/rebuild.py --check` uses public decoded evidence.

`[confirmed: six T26 runs at 0808e11]` All **25 original 8663 rebuild boundaries**
match T25's exact helper entry/return projections and draw intervals. The new
weeks reproduce full T25/T23/T22/T20/T16 observations, T08 events and ordered
DOSBox-X waits. All rebuilds and nested helpers consume **zero draws**. Previous
evidence is unchanged.

`[confirmed: same runs]` The corpus contains **250 helper observations**: 25 each
of 8599 assignment, slot, roster-side, club-count, signed-32 minimum, half/flag,
keeper-selector and direction-side helpers, plus **50 handedness calls**. Every
half/flag call reaches both recorded handedness sites. Side results are zero in
12 cases and one in 13. All keeper predicates and half/flag predicates return
zero. Handedness itself returns one 36 times and zero fourteen times; this is
not evidence that the enclosing predicate ever returns one.

`[confirmed: same runs]` Original club-count arguments/results are 17→29 (four),
28→26 (five), 49→26 (six), 104→26 (two), 134→21 (two), 176→26 (six). Each argument
is the incoming player's P8+0. All 25 also equal their selected roster's club
identifier; no mismatch is observed. Seven canonical club lookup contexts are
exported, including unused club 130 context. Raw word40/42 indices and referenced
DCC8 byte2 cells are provided independently of the helper's expected return.

`[confirmed: same runs]` Both minimum arguments have zero high words in all cases.
Returned values are 0 (six), 8 (one), 20 (two), 21 (two), 22 (one), 26 (twelve)
and 29 (one). The intermediate assigned byte18 exceeds that measured minimum by
32 in 23 cases and 16 in two. Incoming P8+1 is above eighteen in the former group
and equals eighteen in the latter. No input at or below seventeen is observed.
Slot results cover 2 through 11; selectors 1 and 12 are not reached.

`[confirmed: static listings at 9fbab34]` 8599 writes the supplied physical index
into stored selector byte7 before calling the slot/side helpers. It loads roster
word14, applies the club-count/minimum/P8+1 character-field work and writes the
predicate into byte22. 8663 then writes default position words, a direction byte
and the remaining scene initializers. The caller's later saved-word2 handling is
outside this routine. The checked static contract names every reached read and
write; all eleven observed call/return sites and targets are checked against the
listing, including the near call wrapping from displayed 10000 to 0000.

`[designed: T26]` The logical input adds canonical player-club word40/42 indices
and both raw indexed table cells to the complete T25 named context. Far offset
arithmetic and table-index shifts are checked as sixteen-bit operations. Original
minimum arguments/results retain all 32 bits, original helper results are not
computed in Python, and 8599's intermediate scene is recorded separately. Schema,
nesting, pointer normalization, actual result/store links and immutable provenance
are validated without implementing a scene or helper engine model.

`[designed]` This is the complete named input closure for the observed valid-club
rebuild calls as read from these routines. It does not establish arbitrary physical
memory/flags/render/timer parity or accept F26 independently. Keeper direction,
half/flag true, P8+1 at/below seventeen, invalid/missing club context and the
runtime minimum's negative-high-word domain are unobserved here. Native translation
and static/synthetic tests for broader domains remain separate. The reached 164F
rearrangement and 53FB rating/flag closure remain required before full native AI
replacement parity or continuous DD02/match/week integration. No native task or
benchmark is claimed.
