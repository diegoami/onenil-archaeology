# T25 replacement capture (96)

[designed: T25] The observer follows the thirteen direct boundaries checked by
T24 at `7b39558`. It records actual AEB8 entries/returns, direct-helper semantic
arguments/results, named before/after state and draw intervals. No callee's
algorithm is evaluated in Python. Callee interiors remain opaque until separately
captured with complete input contracts.

[designed: T25] The named projection contains the entire T23 selection projection,
all typed fields of each of the 22 scene rows, canonical referenced players'
P8 fields and P15 word0/bytes2–14, both CF5E cached player identifiers, four
direction bytes, two club totals, D074, D2C/D2E/D32 and A2EC. Canonical player
identifiers are the union of T23's roster/scene players and CF5E references. Shared
identities occur once, including player zero. Full rows are decoded numeric fields,
not original memory images or binary blobs. This supplies outer-body context;
it is not a claim that every opaque callee's read set is included.

[confirmed: static sources at `7b39558`] Direct AEB8 arguments are incoming roster
slot, physical scene index and side. The caller has already swapped the roster;
the scene still holds the outgoing player. Far scene/player pointers are checked
against their physical identity and exported as scene/player identifiers. Explicit
CS pushes before near calls to far-returning routines shift the observed argument
positions. Void helper AX values are not recorded as meaningful scalar results.

[designed: T25] All six original weeks must reproduce the complete T23, T22, T20
and T16 observations plus T08 events and ordered DOSBox-X waits. Public verification
joins retained source/fixture/manifest digests and the T24 map digest. New captures
are append-only and skip only completed streams; failed attempts retain their own
record/export. No prior evidence may be changed. The measured census and residual
input exclusions are recorded in proposed F25 after capture.
