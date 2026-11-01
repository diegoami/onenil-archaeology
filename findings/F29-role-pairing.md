# F29 Original role pairing requires preferences and match-club flags

- **Status**: proposed
- **Task**: T29 (#104)
- **Edition**: 96.
- **Sources**: listings at `3f59c97`; static contract at `4d80ead`, clarified
  at `f00db10`; T28 boundaries at `d598c29`; original T29-r0002 and its decoded
  export/manifest at `d9a59df`, observer producer `f00db10`.
- **Check**: `python3 runtime/emul/role_pairing.py --check`; no private bytes.

`[derived: complete static graph, listings at 3f59c97]` 0AB9:10B9's complete
logical input set consists of the following fields:

| Input | Use |
| --- | --- |
| Match-club IDs D6E4 and side offsets D56 | Select both participating clubs and physical scenes |
| Scene word14 | Select player records for both sides' slots2–11 |
| Scene word20 | Preserve or exclude existing opposing player IDs |
| Both club rosters, slots2–11 | Resolve assignments and existing IDs |
| Referenced players' P8+6 | Role bytes and special role1 checks |
| Referenced players' signed P15+8 and flags11 | Availability and one-based bit7 handling |
| Both match clubs' raw record byte57 | Enable assignment writes through one-based bit8 |
| 52 preference cells at09B0+14*pass+role | Four passes and roles1–13 |

T28 contains the first six categories; the last two require new original
observations. The match-club list differs from the human-manager slots: the latter
can contain0 when only one manager is active and must not select these flag bytes.

`[confirmed: same listings, 0AB9:1000–13B7]` The five ranges are12–13,9–11,
5–8,1–1,2–4, visited in that order for side0 then side1. Each range makes four
passes, scanning opposing slots11 down to2. It looks up a preference character
and searches the own-role Pascal string. A successful match clears both role
cells and stores the opposing slot in the assignment array. The complete static
graph includes1000,1CA1→4F89 and bit/fill/character-string/Pos primitives; no RNG
call is reachable. Pascal lengths, one-based bit arguments, signed availability
and the range/pass/reverse-slot order are material parts of the contract.

`[confirmed: same source]` The only logical game writes are scene word20.
Local assigned values are opposing roster slots0 or2–11; word20 stores opposing
player IDs. Bit7-set own players retain their old word20 and exclude those IDs
from opponent candidates. Bit7-clear players first clear word20; their club's
bit8 then permits writing the ID selected by the original assignment. The two
local role arrays and assignment array are initialized by the caller, not extra
uninitialized engine inputs.

`[designed: T29]` Full T28 context is retained to detect unrelated named writes,
with new match-club flags and all52 individually decoded preference cells.
Original1000 boundaries expose actual range arguments and the three local arrays;
parent-frame pointers are checked live and not serialized. Python checks types,
source joins, write closure and state continuation without evaluating pairings,
availability, preferences or string searches.

`[confirmed: T29-r0002 at d9a59df]` One original T04-week-r0017 completed with
two ordered10B9 invocations, matching both T28 boundaries and every retained
upstream observation, T08 event and ordered DOSBox-X comparison. Arguments of
the enclosing replacements are[14,8,1] and[13,6,1]. All twenty range boundaries
consume zero draws; both root intervals are4025→4025. Match clubs130 and134 have
raw bytes57 of75 and133 respectively. All52 preference cells are recorded,
unchanged between entry/return and between the two cases. Recording the complete
potential read set does not mean every cell was dynamically read.

`[confirmed: same record]` Final local assignments are identical across the two
invocations. Entries below correspond to own slots2–11 and contain opposing
roster slots, with0 denoting no assignment:

| Side | Final assignment slots | Nonzero entries |
| --- | --- | ---: |
| 0 | 11,8,10,9,7,6,4,3,2,0 | 9 |
| 1 | 0,10,9,0,8,6,2,5,4,3 | 8 |

The five ranges change1,3,2,1,2 assignment cells for side0 and2,1,1,0,4 for
side1, repeated in the companion case. This is34 observed assignment-cell changes
across20 helper boundaries, including two boundaries with no local changes.
These are before/after counts, not a nested search-call or match-attempt census.

`[confirmed: same record]` The first invocation changes scene5 word20 from2588
to0 and scene8 from0 to2582; the second changes scene6 from0 to2589. All other
named fields are unchanged. Actor5 and secondary22 stay unchanged. Thus17 nonzero
local assignments per invocation do not imply17 changed scene words: flags and
existing state govern which assignments become writes or visible differences.

`[designed: retained abort at f00db10]` T29-r0001 remains immutable with aborted
status and an empty decoded export. Its producer4d80ead selected human-manager
slots instead of match-club IDs; strict input validation rejected club0 after the
week's upstream comparisons passed. The corrected observer and regression test
use match participants130/134. The completed corpus contains onlyr0002; no result
from the aborted attempt is substituted into its input closure.

`[designed]` Other weeks, arbitrary input combinations, separate nested bit/search
observations, physical scratch/register/flags behavior, native implementation,
remaining opaque164F callees and full rearrangement/AI/DD02/match/week parity are
outside this task. F29 remains proposed until independently checked.
