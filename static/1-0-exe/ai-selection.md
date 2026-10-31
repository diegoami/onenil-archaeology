# 96 A94B selection prefix (T23)

[confirmed: listings at `b54a8d4`, `0AB9:A94B–ABB3`] The caller supplies
mode byte, side byte, physical scene word and far roster pointer. The side offset
is subtracted to locate the roster slot. The allowance, scene player's P8+6 and
side substitution flag determine a special extra capacity. With no capacity,
an unavailable roster player can reach A837. Otherwise the routine clears fourteen
candidate cells, scans reserves through A8A0 and chooses through 9882, optionally
500B. A zero choice can reach A837 for a position-zero player. A nonzero choice
copies the outgoing P8+6 to the chosen player's P8+6, swaps two roster words, two
event-total words and two cache-selector bytes, then calls AEB8.

[confirmed: `0AB9:A8A0–A948`] The reserve scan starts at roster slot 12 and
ends at the unsigned result of `1998:0B76`. It excludes the current scene player
and players rejected by `1B55:4F89`. Each eligible player's P8+7 selects a candidate
cell; later eligible players overwrite earlier players with the same style.
`1998:0B76–0B99` adds 11, the zero-extended allowance and the table byte at
`0D58 + sign_extend(allowance)`.

[confirmed: `0AB9:9882–99C1`] A player's P8+6 selects an eight-byte preference
row at 0BF6. 9882 retains the last nonzero candidate in preference order, filtering
by `1B55:4E81` when the position character occurs in D9A. The handedness
helper indexes 12BA by player identifier modulo three, then 129E by fourteen times
that selector plus P8+7. `26C9:0C6F` constructs a one-character Pascal string;
`26C9:0BFE–0C41` searches for it in D9A and returns its one-based index or zero.
The comparison is whether this returned index is above three, not whether a
numeric conversion exceeds three.

[confirmed: `1B55:500B–50E8`] Fallback selection scans slots 12 through the
reserve limit, skips unavailable players and reads a byte weight at
`0DA6 + 14*position + style`. A nonzero D9A search index halves a weight when
handedness differs from its comparison predicate. Only strict weight improvement
replaces the chosen slot, retaining the first tie. Availability checks signed
P15+8, identifier zero and flags11 bits 8, 6, 2 and 3 (one-based bit helpers).

[designed: T23, task definition `5030a1d`] The recorded selection context extends
T22 with per-player position/style and handedness lookup cells, the actual indexed
reserve-limit cell, decoded D9A character sequence, preference/weight rows, fourteen candidate
cells and two twenty-slot cache-selector rows. All values are decoded observations;
no original image, physical pointer or byte blob is exported. Scalar helper returns
and nested order are observations, not a Python implementation of the algorithm.

[confirmed: `0AB9:AEB8–B0F2`, listings at `b54a8d4`] Replacement includes scene
rebuild (8663), motion/cache helpers, managed-club predicates and conditional UI
work, as well as player flags, reserves and event totals. A837 dispatches further
by P8+6 before its cache refresh. [designed: T23] These two routines are explicit
opaque boundaries. T23 retains their entry/return projections and actual effects,
including prefix swaps before AEB8 entry, but their internal input contracts and
native translations require a subsequent task. Render, timer, physical and arbitrary
scratch parity are not established by this named projection.

[designed: T23] New original weeks must reproduce the complete T22 calls,
T20 strategy/late-call ledger, T16 tail, T08 events and ordered DOSBox-X waits.
Public checking needs only committed fixtures. Original capture requires the six
recorded private start states and hash-identical game files under ignored `.cache/`.

[confirmed: corpus at `0be8664`, producer `a317cfb`] Six completed weeks contain
556 A94B calls, 494 candidate scans/limit results/preferred selections, 4,362
availability checks, 14 handedness checks and 25 replacements, with zero draws.
No weighted or A837 fallback is reached. The `style_text` export is the decoded
D9A position-character sequence, despite its field name. The measured limits are
20 (480 calls) and 14 (14 calls). F23 describes coverage and deferred effects.
