# F31 Original player-cache refresh changes role caches and every scene's byte18

- **Status**: proposed
- **Task**: T31 (#109)
- **Edition**: 96.
- **Sources**: listings at `2f1a6ca`; observer/static contract at `98180e5`;
  original T31-r0001/export/manifest at `96f7ff4`, producer `98180e5`.
- **Check**: `python3 runtime/emul/player_cache.py --check`; no private bytes.

`[confirmed: T31-r0001 at 96f7ff4]` One original T04-week-r0017 completed with
two ordered1539 calls, preserving all T30/T29/T28/upstream observations, T08
events and ordered DOSBox-X comparison. Enclosing replacements are[14,8,1]
and[13,6,1]. Both intervals are4025→4025 and every observed event consumes zero
draws. The measured census is:

| Kind | Count across both invocations |
| --- | ---: |
| Managed predicate0E7A | 4 |
| Selector13B8 | 2 |
| Role-cache helper1455 | 8 |
| Cached availability4F89 | 2 |
| Cached slot577F | 2 |
| Managed fallbackB6BD | 0 |
| Final rating4EBF | 44 |
| Caller byte18 store mark | 44 |

This is62 original direct helper boundaries and44 caller marks. It does not
include independent nested helper observations inside13B8 or1455.

`[confirmed: same record]` Raw D18 is1 and09F6's six cells are[1,0,13,21,22,4]
in both cases. Side0 club130 is managed: cached player2590 is available (return0)
and577F returns slot9. Side1 club134 is unmanaged:13B8 returns2661, and the four
1455 arguments are[2,13,1],[3,21,1],[4,22,1],[5,4,1]. No fallback or gate-zero
path is exercised. Managed identifiers and match clubs remain distinct inputs.

`[confirmed: same record]` Kind1 selected-player caches stay[2590,2661]. The
newly captured role caches reveal two changes outside T28's projection:

| Invocation | Side/kind | Cache word | Before | After |
| --- | --- | --- | ---: | ---: |
| [14,8,1] | side1/kind4 | CF6E | 2669 | 2668 |
| [13,6,1] | side1/kind2 | CF6A | 2664 | 2672 |

Every role-helper boundary changes only its own role-cache word within the
expanded named state. All other role-cache entries stay unchanged. Full typed
snapshots retain both five-player rows, the six cells and complete T28 context.

`[confirmed: same record]` Side0's selected2590 returns rating3 on all22 final
calls; side1's selected2661 returns7 on all22. Each side applies its selected
player's return to all eleven physical scenes. All44 observed stores change
byte18, with the following exact before/after census:

| Side | Byte18 before | Byte18 after | Stores |
| --- | ---: | ---: | ---: |
| 0 | 59 | 65 | 20 |
| 0 | 56 | 62 | 2 |
| 1 | 53 | 67 | 22 |

Only byte18 changes in these store rows; no wrapping case is reached. Original
helper returns and actual stored rows are separate observations. Python does
not calculate the rating or addition. Actor5 and secondary22 stay unchanged.

`[confirmed: listings at 2f1a6ca, 1B55:4EBF–4F02]` The helper returns signed
division's remainder, not quotient, and P8+1 below21 selects a logical word shift.
Signed remainder words need all16 bits even though this specimen returns3/7.
13B8 compares a sign-extended current word against zero-extended candidates;
all-unavailable input can leave its selected-player local uninitialized.

`[designed: T31]` This is an outer boundary contract.13B8/1455 and managed fallback
remain explicit opaque boundaries, not complete nested input closures.1AE2's
P15+6≥32 path can read an uninitialized local; its9F6E tables and later global
inputs need separate work. At these roots, scene-player raw P15+6 spans2–27;
no independent nested-call or physical-scratch coverage follows from that fact.
Other weeks, managed fallback/gate-zero branches, no-eligible selection, arbitrary
signed/wrapping ratings, native translation and full rearrangement/AI/DD02/match/
week parity remain excluded. F31 remains proposed pending independent checking.
