# Executable-derived squad and preparation blueprint

[confirmed] This extends the [template blueprint](executable-ui.md) using
[comparison3](../../runs/T58/blueprint-r0003.json), producer
`f50b4e1c07ec3fa12afb63d176c751d4726d1301`. It reuses decoder24BC:0000
through232A:052F. Static citations refer to generated listings introduced by
`004fb87b1237edc9eecfc55acd09c03c99c06e0d`. Original screens come from completed,
authenticated T45 and T47 sessions; no new original clickthrough was required.

## Recovered components

[confirmed] Geometry is zero-based x,y,width,height. Comparisons check fixed
text spans and border characters, not every pixel, color or runtime value.
Base attribute codes, resource/listing hashes and capture hashes are recorded.

| Component | Resource in DS2864 | Caller | Rectangle | Fixed spans | Border cells |
| --- | --- | --- | --- | --- | --- |
| Player details | 6734 | 0AB9:8D6F | 0,0,55,24 | 37/37 | 375/375 |
| Player skills | 1D5E | 1B55:478C | 0,0,55,24 | 24/24 | 150/150 |
| Squad frame with later mode footer | 3D72 +22AC +1D0E | 0AB9:9FD0 / AC87 / CBF0 | 55,0,25,24 | 4/4 | 107/107 |
| Preparation frame | 25CC | 0AB9:D5D6 | 0,0,20,24 | 7/7 | 212/212 |
| Team information | 3B82 | 1B55:3323 | 19,0,37,24 | 21/21 | 213/213 |

[confirmed] Details and squad compare with
[T45 step4](../../runs/T45/session-r0001/step-0004.json), skills with
[T45 step3](../../runs/T45/session-r0001/step-0003.json), and preparation/team
information with [T47 step11](../../runs/T47/session-r0001/step-0011.json).
Those illustrated workflows are in [squad](squad.md) and
[preparation](match-preparation.md). The 93 fixed spans and1,057 border assertions
all match; this is five verified components, not five complete screen states.

## Fixed spans, later overlays and dynamic destinations

[designed] Text extraction splits only where a template actually has two or
more spaces, retaining single spaces inside labels. Thus Age and Team remain
independent assertions even when values are later written into their gap.
Labels are capped at48characters with explicit truncation. Synthetic tests
verify coordinates, gaps, truncation and negative comparisons without game bytes.

[confirmed] [Comparison1](../../runs/T58/blueprint-r0001.json) preserves the
base-only mismatches. Details, skills and preparation already match; squad
footer text replaces11border cells, and team name/value writers replace other
border cells. These differences are explained by original drawing instructions:

- [0AB9:AC87](../../static/1-0-exe/code/seg_0AB9_17.asm) first calls9FD0,
  then draws22AC atAC94..AC9E. The outer
  [CBF0](../../static/1-0-exe/code/seg_0AB9_19.asm) draws1D0E atCD86..CD90
  for first-team mode outside a live match, replacing the bottom border with
  the reserves navigation hint. Its other-mode resource1648 is a candidate
  variant, not checked by this comparison. Comparison2 retains the intermediate
  failure before that outer footer was added; comparison3 applies both calls.
- [1B55:3323](../../static/1-0-exe/code/seg_1B55_05.asm), at3357, calls0EE3
  with row1,column23. [0EE3](../../static/1-0-exe/code/seg_1B55_02.asm)
  clears a15-character field using DS:0F10 and writes the club name there.
  Comparison3 checks that placeholder length and excludes only x22..36,y0
  from static border assertions.
- 1B55:321F calls101E at331C with row14,right column54 for team value.
  [101E:1056..10A7](../../static/1-0-exe/code/seg_1B55_02.asm) writes digits
  two columns apart, puts commas one cell to the right of the next digit
  column, and does not advance that digit column for a comma. From column54,
  the three possible group-separator destinations are zero-based x48,42,36
  at y13. These three destinations are excluded from static border assertions.
  Numeric values and formatting outputs are not asserted as fixed template text.

[confirmed] All other border cells and all fixed-span assertions stay exact.
The synthetic negative test places an unexpected border mismatch beside an
excluded dynamic destination and requires it still to fail. This distinguishes
traced runtime drawing from unexplained differences. Failed records remain
immutable; no original resource/cell buffer is exported.

## Dynamic write map

[confirmed] The text helpers use one-based row/column arguments. The address
calculation in [232A:0283](../../static/1-0-exe/code/seg_232A_01.asm) subtracts
the Pascal string length to right-align it;041B and039D start at the supplied
column. The three concrete writes below identify destination boundaries,
without claiming that this task ports the underlying value calculations.

| Dynamic field | Source and draw call | Destination |
| --- | --- | --- |
| Team name | 1B55:334F..3357→0EE3 | Starts x22,y0; cleared field width15 |
| Team formation | 1B55:33A1..33B7 calls10AF then232A:0283 | Right edge x52,y1 |
| Remaining substitutions | 0AB9:D76B..D78C calls1B55:4759, formats result then232A:0283 | Right edge x17,y9 |
| Team instructions | 1B55:3364..339F selects DS:85E8 strings through24BC:0259, then232A:0283 | Right edge x52; y15..22 for indices1..8 |

[confirmed] The team template is drawn before these values. Player details
similarly draws6734 before checking for an empty player ID at8D82..8D8E.
Empty-player and other availability states need their own comparisons; this
record checks the captured selected-player state only.

## Squad input and move boundaries

[confirmed] [0AB9:CBF0](../../static/1-0-exe/code/seg_0AB9_19.asm) owns the
outer squad loop. AC87 draws the list and calls95B3 for the selected player.
[95B3](../../static/1-0-exe/code/seg_0AB9_15.asm) tests DS:9A2A: nonzero
calls1B55:478C for skills, zero calls8D6F for details. The outer toggle write is
atD0E7..D0F5. The observed Insert transition is documented in W010; internal
input codes here are not presented as a complete raw keyboard mapping.

| Boundary | Executable evidence | Observed controls / limits |
| --- | --- | --- |
| Selection | DS:037E; AC87:AD09..AD39 accounts for list separator rows before highlighting; CBF0:D113 onward calls232A:0EC4 | Up/Down changes selected player; matched capture state only |
| First team/reserves | Local mode atBP-9; CF11..CF27 calls selector with2modes when outside a live match | Left/Right switches lists in W010; live-match branch differs |
| Begin move | Activation dispatchCEBA..CECF→C3C6; nonempty source stores selection/mode at outerBP-0C/-0B and sets BP-0A | Enter picks up; empty source is rejected byC491..C496 |
| Complete move | C3D6 clears pending flag; C421 calls24BC:0203 with size2 on selected/source entries, then calls refresh/reorder path | Enter places; lineup order may change afterward |
| Cancel/exit | CE3D..CE60 exits on code1 only if no move is pending; otherwise clears pending flag | Escape cancels a pending move before exiting the outer list |
| Options | CF2F..CF6F checks selected entry nonzero before callingC4CD | Space on empty slot does not open player options |

[confirmed] This maps the non-live management move path. It does not infer
live-match substitution legality, contract effects or roster ordering rules
from the UI handler alone. Those remain governed by original workflow evidence.

## Preparation input and play boundary

[confirmed] [0AB9:D5D6](../../static/1-0-exe/code/seg_0AB9_20.asm) sets local
selectionBP-5 to3 atD5F7. It draws25CC atD6D6..D6E0, and later uses the
four-entry selector232A:0F8B atD817. The displayed entries are opponent,
statistics, PLAY GAME and Change tactics, as independently captured in W019.

| Slot / boundary | Target or effect |
| --- | --- |
| 1 opponent | D885..D88E toggles the inspected side |
| 2 statistics | D897..D89B calls1998:045C with1and0 |
| 3 PLAY GAME | D8A6 sets the completion request; D8D2 calls admission helperD29E; a false result returns to redraw |
| 4 Change tactics | D8B0..D8C6 tests1B55:0E7A, then calls0AB9:966F |
| Exit | Input code1 only marks completion when DS:0D18 is nonzero atD81C..D830; it is conditional, not a universal preparation Escape exit |

[confirmed] Ineligible/insufficient refusals and actual match transitions are
established by the illustrated manual, not by assuming the PLAY flag starts a
match unconditionally. The initial friendly's9substitutions and later cup/league
counts are state, not a hard-coded property of the frame.

## Reproduction and limits

```sh
python3 -m pytest -q tests/test_squad_ui_blueprint.py tests/test_ui_blueprint.py
python3 tools/static/squad_ui_blueprint.py --check runs/T58
```

[designed] Next reconstruction comparisons should cover reserves, player
options, selected/moving variants and live-match preparation using their actual
component order. This blueprint is not a native stack decision. Winter, season
finish/rollover and the complete workflow/native gap audit remain required.
