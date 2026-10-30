# 96 substitution dispatcher (T22)

[confirmed: static listings at `3223aa9`] `0AB9:6B2F–6CCD` visits DS side 0 then 1.
`1B55:0E7A–0E9F` compares the word club identifier with the two zero-extended managed
club bytes. Managed clubs call `1B55:4F89` on physical scene `offset[side]+1`'s player.

[confirmed: same listings] Managed pending byte D6E2 gates all prompt work. An available
keeper additionally requires nonzero wrapping remaining+added time and nonzero capacity.
An unavailable keeper bypasses those gates. A second capacity call conditionally sets
D0BA=1; keyboard flush precedes `6A7A(side, keeper-unavailable)`. DE8A other than 1, or
an unavailable keeper, calls the D5D6 editor with argument 1. The dispatcher then clears
D0BA. It does not clear D6E2.

[confirmed: `1B55:4759–4789`] Capacity is the 16-bit wrapping sum of zero-extended
D6E0[side] (reserves) and D6DD (allowance), minus zero-extended D6DE[side] (flags/count).
The caller tests unsigned above zero, so underflow is a large nonzero capacity.

[confirmed: `6BD1–6CC0`] AI sides require nonzero capacity, scan physical slots 11 down
to 1, skip flags11 mask 0x20 and nonpositive signed player byte8, then require remaining
in 2..34 and slot above 1. The signed event-total word at D146+40*side+2*slot is compared
as a signed 32-bit extension against zero-extended (90-remaining). A strictly smaller
total calls A94B with mode 0, side, the scene's stored slot and club roster pointer.
Zero reserves after this call terminates the scan.

[confirmed: `6A7A–6B2C`] Prompt saves/restores 160 display bytes, renders the appropriate
message, waits using table B14 indexed by keeper status, then polls keyboard. A pending
key is read through 232A:099B; absence sets DE8A=1. These operations and the D5D6 editor
are separate from the dispatcher's predicates.

[designed: T22] Export a named projection, not physical memory parity: seed, clubs and
rosters, canonical player byte8/flags11, physical scene/player/stored-slot selectors,
managed identifiers, time, allowance, reserves, substitution flags, pending/control/key
and both complete event-total rows. Outbound routines are observed as opaque entry/return
boundaries, including actual draw intervals. AI pointer arguments are decoded to club
identity. No UI, AI editor or replacement algorithm is claimed implemented. Rendering,
other player fields and arbitrary scratch bytes are outside this projection.

[designed: T22] Public replay checks join the entire T16/T20 ledger and trace, while the
new original run must also reproduce full T08 events and ordered DOSBox-X waits.
Measured coverage and limitations will be recorded in proposed F22 after capture.

[confirmed: static `A94B–ABB3`, `A8A0–A948`, listing at `3223aa9`] A94B's closure
reads additional context outside this dispatcher projection: P8 position/style fields,
reserve availability, the reserve-limit helper 1998:0B76, candidate selection 9882 and
possibly 500B, D076 scratch candidates, cache cells, and the AEB8 replacement closure.
A837 is another outbound fallback. T22 cannot supply complete native AI inputs merely
by exporting the dispatcher projection. A subsequent capture task must observe these
inputs/helpers and the full named replacement outputs, preserving the T22 boundaries.
