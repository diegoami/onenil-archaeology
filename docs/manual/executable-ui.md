# Executable-derived UI blueprint

[confirmed] The executable contains compressed screen templates and separate code
for selection, changing values and transitions. This chapter records recovered
structure, alongside the illustrated workflows. It is not a proposed UI design.
Static citations below refer to generated listings introduced in commit
`004fb87b1237edc9eecfc55acd09c03c99c06e0d`; comparison evidence is
[T57 comparison 2](../../runs/T57/blueprint-r0002.json), produced by
`a18392e469ef8cbb8c848b988e1593020208323b`.

## Template format and composition

[confirmed] [24BC:0000](../../static/1-0-exe/code/seg_24BC_01.asm)
decodes resources passed through wrapper
[232A:052F](../../static/1-0-exe/code/seg_232A_01.asm). A little-endian
word gives the one-based linear destination cell, followed by row count and
column count bytes. The canvas is 80 columns by 25 rows; successive destination
rows are 160 bytes apart, with a character and attribute byte per cell.

| Instruction | Decoder behavior |
| --- | --- |
| Ordinary byte | Write character with current attribute; remember the whole cell word |
| `FF attribute` | Change current attribute without changing the remembered cell |
| `00 count` | Emit that many additional copies of the remembered cell; restore its attribute even for count zero |
| Region filled | Stop after the declared rows; no trailing terminator is required |

[designed] The public Python decoder rejects truncated instructions, repeats
crossing a declared row and regions outside the canvas. These are analysis-tool
guards, not claims that the original validates malformed resources. Synthetic
tests cover the controls, boundaries and later-overlay replacement.

[confirmed] Main-menu rendering draws a base resource and then a conditional
top-entry overlay. Comparing only the base failed at two border junctions in
[comparison 1](../../runs/T57/blueprint-r0001.json). Applying the actual
single-manager overlay in the original call order resolves both differences;
the failed record is retained. A template is therefore a component, not
necessarily a complete screen.

## Verified geometry

[confirmed] Coordinates here are zero-based. Comparison 2 authenticates existing
completed original captures and checks short static labels and border glyphs.

| Component | Resource in DS 2864 | Rectangle x,y,width,height | Matching labels | Matching border cells |
| --- | --- | --- | --- | --- |
| Main menu, with single-manager overlay | `45E6` + `5A28` | 55,0,25,24 | 20/20 | 85/85 |
| Single-manager top entry alone | `5A28` | 57,4,22,2 | 1/1 | 24/24 |
| Configuration | `49E8` | 55,0,25,24 | 8/8 | 187/187 |

[confirmed] Independent captures are [main menu](../../runs/T47/session-r0001/step-0001.json)
and [configuration](../../runs/T47/session-r0001/step-0006.json); the comparison
records include their screenshot hashes. This verifies static labels and border
geometry, not every color or pixel. Base attribute codes are recorded, while
runtime selection attributes, checkmarks and changing values are excluded from
these assertions. No derived image is presented as an original screenshot.

## Main-menu transitions

[confirmed] [0006:1B52](../../static/1-0-exe/code/seg_0006_03.asm)
draws `45E6`, then `4342`, and selects the top-entry resource at
`1B7E..1BBE`: `5A28` for one manager; `5A4E` for manager one of two;
`59EE` for manager two. Selection is stored at `DS:00E0`; the selector
`232A:0F8B` receives 18 internal slots. Slot 2 is unavailable unless current
manager is two. Space explicitly selects slot 3 and supplies activation code 2
at `1C61..1C6D`.

| Slot | Entry | Label x,y in single-manager base | Dispatch target / boundary |
| --- | --- | --- | --- |
| 1 | PLAY NEXT GAME / NEXT PLAYER | 59,4 | Advance via `01EF:4D08` for one manager or manager two; otherwise increment current manager |
| 2 | Previous player | Conditional overlay | Decrement current manager and reset cursor to 1 |
| 3 | Players | 59,6 | `0AB9:CBF0`, argument 1; requires managed club |
| 4 | Next opponents | 59,7 | Fixture lookup `1B55:40DF`, then `0006:07A1`, argument 4, if fixture exists and club is managed |
| 5 | Transfer market | 59,8 | `01EF:0EA4` |
| 6 | Use scout | 59,9 | `01EF:1569` |
| 7 | New staff | 59,10 | `01EF:3524`; requires managed club |
| 8 | League tables | 59,11 | `01EF:4743`, argument 1 |
| 9 | League results | 59,12 | `01EF:3EE3`, current week and 0 |
| 10 | Cup results | 59,13 | `01EF:48DB` |
| 11 | Weekly fixtures | 59,14 | `1B55:42D7`, current week + 1 |
| 12 | Fixture list | 59,15 | `0006:07A1`, argument 2 |
| 13 | Statistics | 59,16 | `01EF:1D7A` |
| 14 | Player/team history | 59,17 | `0006:0F7B` |
| 15 | Seasonal history | 59,18 | `0006:1A67` |
| 16 | Other teams | 59,19 | `0006:07A1`, argument 5 |
| 17 | Game configuration | 59,20 | `0006:10BF` |
| 18 | Cashflow | 59,21 | `1B55:38EF` |

[confirmed] Dispatch is at `0006:1CFF..1E78`; all paths return to the redraw
loop at `1E7D`. After advancing, nonzero game byte `+F4` queues command `CF`
through `232A:0783`. Additional input codes at `1C8F..1CB9` call
`1B55:0E40` (`D2`), `1B55:0DE2` (`CF`) and `1B55:3108` (`0D`).
These are internal input codes, not ASCII/key-scan assertions. The observed
Insert/F7/F10 workflows remain documented in [squad](squad.md) and
[saving](saves.md); this blueprint does not claim a complete keyboard decoder.

## Configuration state

[confirmed] [0006:10BF](../../static/1-0-exe/code/seg_0006_02.asm)
uses five bytes beginning at game pointer `+F2`, in displayed order:

| Index | Label | Label x,y | Game-relative byte |
| --- | --- | --- | --- |
| 1 | Watch match | 58,7 | F2 |
| 2 | Sacking | 58,9 | F3 |
| 3 | Auto save game | 58,11 | F4 |
| 4 | Friendlies | 58,13 | F5 |
| 5 | Auto player select | 58,15 | F6 |
| 6 | Continue | 58,17 | No option byte |

[confirmed] The selected row is at `DS:0020`. The loop draws all five stored
values and separately draws Continue with a literal true value
(`1117..1141`). The selector receives six entries. Activation code 2 toggles a
selected option between zero and one (`1165..1185`); activating Continue sets
exit code 1 (`1157..1163`). Exit code 1 returns from the routine (`1189..1194`).
This establishes editing/storage boundaries, not every downstream engine effect.

## Remaining reconstruction work

[confirmed] Comparison 2 inventories 148 direct template callsites referencing
112 distinct resource addresses. At 146 callsites the resource decodes; these
are candidate components with caller addresses, geometry, hashes and short label
samples, not 146 verified screens. Resources `2864:7076` (caller `1B55:1BFB`)
and `2864:136A` (caller `1B55:5A60`) fail the strict row-boundary guard and
remain unresolved. The decoder has not been relaxed to accept them.

[derived] The inventory supplies a concrete starting map for remaining screens.
For each workflow, recover its component order and dynamic draw/input handlers,
then compare the assembled structure with an existing original capture. New
play is needed for unobserved state-dependent branches and season transitions.
The remaining full-season manual work and native gap audit are still required;
this extraction does not establish their completion or choose a native UI stack.

## Reproduction

```sh
python3 -m pytest -q tests/test_ui_blueprint.py
python3 tools/static/ui_blueprint.py --check runs/T57
```

[designed] These checks use generated public listings and authenticated captures.
Public records contain hashes, geometry and bounded labels, without complete
encoded resources, original cell buffers, font or palette assets.
