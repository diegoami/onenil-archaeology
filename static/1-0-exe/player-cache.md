# Targeted original 1539 player-cache boundary contract (96, T31)

[confirmed: listings at `2f1a6ca`, 0AB9:1539–164E] 1539 visits both match sides.
It tests the actual club ID through1B55:0E7A. Unmanaged sides call13B8 and store
its original return at CF5E+10*side. An unmanaged side, or any side with D18=0,
calls1455 four times, kinds2–5, with the raw09F6+kind criterion and side. A managed
side with D18 nonzero instead checks its cached player's4F89 availability. If
available it asks577F for its roster slot; unavailable or slot12 invokes B6BD
with kind1/side, then stores the returned player. The near B6BD target displayed
as FFFFB6BD wraps to16-bit B6BD. These branches are validated from original
helper returns, not computed predicates.

[confirmed: same source] Five cache words for each side occupy
CF5C+10*side+2*kind, kinds1–5. Kind1 is the existing T28 cached-player alias;
kinds2–5 were absent.09F6+kind supplies four criteria;1455 separately reads09F6
or09F7 as a start limit according to whether kind equals5. T31 records all six
cells and D18, plus the complete T28 context. Cache words contain player IDs,
not physical scene indices. Pointers are checked while live and not serialized.

[confirmed: same source, 1625–163E] For each side's eleven slots the caller
repeatedly invokes1B55:4EBF with the kind1 cached player, doubles its returned
word and adds AL to scene byte18. The addition wraps as a byte. It does not read
the current scene's own player as the helper argument. T31 observes each actual
argument/return and the following stored row at163E; Python does not calculate
the helper or addition. Physical targets come from the measured side offset plus
slot, checked against the caller's saved far scene pointer.

[confirmed: same listings, 1B55:4EBF–4F02] 4EBF is read-only. It subtracts raw
P8+5 from raw P8+3, sign-extends the word and uses signed IDIV by8. XCHG takes
the signed remainder, not the quotient. If P8+1<21 it logically shifts the word
right once; this is not an arithmetic signed shift. All16 return bits are
observed, including possible large unsigned interpretations. No helper is called.

[confirmed: 0AB9:13B8–1452 and1455–1536, same source] 13B8 scans the first eleven
roster words, calls4F89, and compares/stores4EBF results for eligible players.
Its current score is sign-extended while candidate returns are zero-extended;
the comparison must not be replaced by a naive unsigned maximum. No eligible
player leaves its selected-player local uninitialized.1455 clears one role cache,
visits scenes after its limit and uses4F89,8973 and1AE2 to replace that cache
conditionally. Those original boundaries remain opaque here; this is not their
complete input contract or independent nested helper census.

[confirmed: 0AB9:1AE2, same source] In the P15+6≥32 branch, the D1CE/D1CF-zero
path adds32 to local BP-4 before a dominating initialization. This is a physical
scratch dependency, not permission to supply zero. T31 does not infer those
inputs from final cache choices.8973 also needs a player's club roster and side
mapping; B6BD has wider managed/UI branches through save and screen buffers.
Separate tasks must close reached helpers and diagnose unsupported domains.
1AE2 also calls9F6E, whose read-only calculation indexes tables957D/96B1 using
player fields and the criterion; later1AE2 inputs include09FB+criterion and D29.
These table/global closures are deliberately not supplied by the six outer cells.

[designed: T31] Capture the two1539 boundaries at198B→198E in the same original
T04-week-r0017. Retain full expanded snapshots at every direct helper, normalized
arguments, original scalar returns and draw intervals; add caller marks after
the44 byte18 stores. The checker joins exact T28 roots, checks phase order from
observed branch results, literal selected-player alias stores, role-helper write
footprints, read-only helper equality and observed scene-row continuation. It
preserves T30/T29/T28/upstream and T08/DOSBox-X comparisons.

[designed] This outer capture does not close every nested helper read set,
uninitialized local, managed fallback, arbitrary physical/render/timer state,
native AI or continuous DD02/match/week parity. Proposed F31 will report the
measured branch/helper/store census and named changes after the original run.
