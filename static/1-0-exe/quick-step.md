# One-Nil 96: the quick step, `0AB9:DD02`

`[confirmed]` The static claims below are read from the listing at archaeology commit
`78bdebc10d0051fa52b080a72312d894bfab5560`: `code/seg_0AB9_21.asm` (`DD02`–`E007`),
with the callees and caller addresses named below. The decompile in
`decompiled/seg_0AB9_09.c` is a navigation aid; operand widths, signedness, frame offsets,
byte order and control flow are checked in the listing. F07, F09 and F11 supply the earlier
contest/rating evidence. This reading does not itself establish the measured effects of T12.

## Boundary and state

`[confirmed]` DD02 is a near procedure with no explicit value arguments. It allocates a
`0x2E`-byte frame at `DD02`; every path reaches `LEAVE` at `E006` and near `RET` at `E007`.
A hook at `E006` observes completed routine effects before the epilogue, not a returned CPU
state. Registers, stack locals and asynchronous timer effects are separate from a semantic
state contract.

`[confirmed]` The directly used fields and selected persistent outputs are:

| State | Width | Role established by these instructions |
| --- | --- | --- |
| `D6E6`, `D6E4` | word each | clubs passed to rating production for sides 0 and 1 (`DD49`–`DD60`) |
| `0D29` | byte | flag passed only for side 0's ratings (`DD4F`–`DD53`) |
| `D674`–`D683` | eight words | rating outputs of `50EB`, inputs of D983; layout in F09/F11 |
| `D0AC` | byte | equality-to-15 selector for chance/minute tables (`DD65`, `DDCB`) |
| `0CFE + (D0AC==15)` | byte | D983's chance count (`DD72`) |
| `0D00 + (D0AC==15)` | byte | minute-draw bound (`DDD8`) |
| `D0B2` | word | exact value compared with each generated minute (`DE40`) |
| `D0AE` | word | display argument and unsigned modulo-five input (`DF6A`, `DFAD`–`DFB5`) |
| `D0B8`, `D0B0` | byte, word | set to 1 and 0 before step work (`DD1A`, `DD25`); also caller clock inputs |
| `D0C4`, `D0C5` | byte each | cumulative score, in the reverse byte order from `D086/D087` |
| `D086`, `D087` | byte each | cleared, then temporary D983 counts; finally restored as cumulative side-0/side-1 scores |
| `[DE84]` | far pointer to word | RNG seed target, as in F02/F11 |
| `0D56`, `0D57` | byte each | offsets added to the scorer's roster index (`DEE2`) |
| `D09F` | byte | resolved scorer scene index, low byte of that sum (`DEEA`) |
| `D6DD` | byte | gates extra no-goal work and some goal-helper statistic effects |
| `[D7C2]`, `[D7BE]`, `[D7CE]`, `[D7D2]` | far pointers | club/player/history/configuration destinations named below |
| `[DD58]`, `[DD60]` | far pointers | display-buffer copy at entry; publish hashes rather than original screen bytes |

The football names of the rating classes are `[derived]` from F09, rather than new meanings
inferred merely from their order. Fields such as player byte `+8` remain named by record and
offset unless a separate finding establishes their game terminology.

## Setup, ratings and generated counts

`[confirmed]` `DD06`–`DD15` copies 4,000 bytes from the buffer pointed to by `DS:DD58` to
the buffer pointed to by `DS:DD60`. The far runtime call `26C9:0A12` reads source/destination
from its stack and executes `REP MOVSB` (`seg_26C9_02.asm`, `0A12`–`0A27`).

`[confirmed]` DD02 sets `D0B8=1`, clears local `[BP-26h]` and word `D0B0`, byte-swaps the
word at `D0C4` into `[BP-4]`, and copies it into `[BP-2]` (`DD1A`–`DD41`). It zeroes the
22-byte local minute storage `[BP-1Ah..BP-5]` through `24BC:0222` (`DD30`–`DD39`;
`seg_24BC_01.asm`, `0222`–`0240`). The one-byte flag at `[BP-26h]` is separate from those
22 bytes. It records whether this step has called the goal helper.

`[confirmed]` The word `D086` is then cleared (`DD44`–`DD46`). `1B55:50EB` is called for
club `D6E6`, side 0, flag `0D29`, then club `D6E4`, side 1, flag 0. The four ratings per side
are described in F09. The byte selected from `0CFE` is zero-extended and passed to D983
(`DD65`–`DD79`); the routine contract is in `quick-contests.md`.

`[confirmed]` D983's output bytes at this point are generated candidate counts. DD02 does not
simply add all of them to the score. It uses them in the following minute-placement scan, then
restores the accumulated score from its local copy.

## Repeated minute fills and scorer selection

`[confirmed]` The outer side index `[BP-22h]` runs 1, 2 (`DD7C`, `DD83`, `DF2C`–`DF32`).
For selected side `b`, it enters the fill body only when unsigned byte `D085+b` exceeds saved
score byte `[BP+b-3]` (`DD86`–`DD95`). It first subtracts that saved byte from the selected
global count (`DD98`–`DDA1`). The other global count is not subtracted by this operation.

`[confirmed]` Inside each entered outer pass, inner side `[BP-1Ch]` runs 1, 2. For each inner
side, `[BP-1Eh]` runs 1 through that side's current unsigned byte at `D085+side`, with zero
skipping the loop (`DDA5`–`DDC3`). Each iteration draws with the selected minute bound, keeps
the returned low byte, and writes it at `SS:BP + 11*side + goal_index - 26h`
(`DDCB`–`DDEF`). Both sides' minute tables can therefore be filled again on another outer
pass; this is not one draw per final goal. Draw return site `DDE4` belongs to this fill.

`[confirmed]` The scan again visits both sides and their current counts (`DE00`–`DE26`). A
candidate reaches scorer selection only when all three conditions hold: local goal flag is
zero (`DE29`–`DE2F`), its zero-extended minute equals word `D0B2` (`DE32`–`DE46`), and that
side's saved unsigned score byte is less than 15 (`DE49`–`DE52`). The score cap 15 here is
distinct from the goal-log count limit used by `5083`.

`[confirmed]` Scorer selection draws `random(30)` at return site `DE5C`. The result 1–30
indexes `[di+0CDF]`, so the effective 30-byte range is `0CE0`–`0CFD`, with values
`2,3,4,5,5,6,6,7,7,8,8,8,9×6,10×6,11×6` (F07's corrected reading). The selected slot reads a
player ID from club `D6E6` for inner side 1, or `D6E4` for inner side 2. Selection repeats while
`1B55:4F89(player)` returns nonzero (`DE55`–`DE94`).

`[confirmed]` That predicate rejects player zero, signed player-record byte `+8 < 1`, or any
of one-based flag bits 8, 6, 2 or 3 in player-record byte `+0Bh`
(`seg_1B55_08.asm`, `4F89`–`5008`; `seg_24BC_01.asm`, `0259`–`0274`). These are the 15-byte
records at `[D7BE]`. No injury/suspension terminology is inferred for those bits here.

`[confirmed]` Once accepted, `[BP+side-3]` is incremented (`DE96`–`DE99`). The selected ID
is also passed to `1B55:5C6E` with that club's roster pointer (`DEAA`–`DECF`). This helper
searches all 20 roster words and returns the **first** matching index 1–20, or zero
(`seg_1B55_09.asm`, `5C6E`–`5CA6`). With duplicate IDs it need not equal the initially drawn
slot. The matching roster index plus the corresponding `0D56/0D57` offset is stored as a byte
at `D09F` (`DED4`–`DEEA`).

`[confirmed]` DD02 calls `5083` with the generated minute, `D09F` and a side flag that is 1
for inner side 1 and 0 for inner side 2 (`DEED`–`DF0C`). At that near callee's entry these are
SP+2, SP+4 and SP+6 respectively; after its ENTER they are BP+4, BP+6 and BP+8. On return,
DD02 sets the local goal flag and forces the outer index to 2 (`DF0F`–`DF13`). All later scan
candidates skip the goal path, and the outer loop then exits. **At most one goal-helper call
can occur in one DD02 step**, even when D983 generated several candidate goals.

## Cumulative score and packed history

`[confirmed]` Because `DD2B` exchanges AH/AL, local byte `[BP-2]` starts as old `D0C5` and
`[BP-1]` as old `D0C4`. They are the mutable side-0 and side-1 cumulative scores. At
`DF35`–`DF38` these bytes replace temporary `D086/D087`. `DF3B`–`DF40` swaps them back into
`D0C4/D0C5`. The generated candidate counts are not the step's final score.

`[confirmed]` `DF43`–`DF65` passes the score word and a far destination to `232A:01C5`.
Its destination is `[D7CE] + D6E6*3Ah + byte([D7D2]) - 3Bh`. The helper writes **one packed
byte**: low score byte plus the high score byte shifted left four, truncated to AL
(`seg_232A_01.asm`, `01C5`–`01E0`). It does not write the source score word. For ordinary
scores below 16, the low nibble is side 0's score and the high nibble side 1's score.

## Post-step effects and dependencies

`[confirmed]` DD02 displays word `D0AE` through `00D6` and draws the scores through
`1998:02DF` (`DF6A`–`DF78`). It then processes scene records 1–22 at
`DS:CCEF + index*19h` (`DF7D`–`DFD9`). `1CA1` reads the scene record's player ID at `+0Eh`
and returns `4F89`'s availability result (`seg_0AB9_03.asm`, `1CA1`–`1CB8`).

`[confirmed]` A nonzero result invokes `1998:093F`. That helper writes scene-record word
`+0` from `DS:0D32` and, when `D074=0`, performs display work
(`seg_1998_01.asm`, `093F`–`0984`). Calling it does not by itself establish a newly created
injury. Otherwise, if unsigned word `D0AE % 5 == 0`, DD02 locates the scene record's player in
`[D7BE]` and decrements byte `+8` only when its **signed** value is greater than 1
(`DFAD`–`DFD1`). The dividend is zero-extended before unsigned `DIV`; the byte threshold uses
`CMP`/`JLE`.

`[confirmed]` If `D6DD!=0` and the local goal flag is still zero, DD02 calls `DBC6` with a
parent-frame link (`DFDB`–`DFE9`). It then calls `6B2F` on the no-goal path, or
`1998:045C(1,0)` and `52B6` on the goal path; `78B7` is called on either path before return
(`DFEC`–`E003`). Relevant dependencies include:

| Callee | Effects or limits requiring a separate contract |
| --- | --- |
| `1B55:50EB` | rating production and its player predicates/fields (F09); not part of the minute kernel |
| `0AB9:5083` | goal statistics and log records; consumes RNG at `5190`; log count is capped separately at 11 (`seg_0AB9_09.asm`, `5083`–`5264`) |
| `0AB9:DBC6` | contingent extra random draws and possible `69B8` call (`seg_0AB9_20.asm`, `DBC6`–`DCFF`); its game-level event semantics remain outside this reading |
| `0AB9:6B2F` | availability/substitution interactions and possible UI/state changes; not a pure no-op |
| `0AB9:52B6` | scene reset and further calls, including `A4F2/A34D` that can draw; not merely a display flush |
| `0AB9:78B7` | keyboard polling and handling; can change configuration or enter other UI paths (`seg_0AB9_13.asm`, `78B7`–`79EC`) |
| display and timer helpers | screen-buffer effects and asynchronous timer/BIOS state are outside score/seed equivalence |

The relative-call operands printed as `15083`, `152B6` and `100D6` wrap within 16-bit IP to
`5083`, `52B6` and `00D6`. Opcode `98` printed as `cwde` is CBW in this 16-bit code; a Rust
translation must preserve the actual instruction width rather than that mnemonic's spelling.

## Caller clock boundary

`[confirmed]` `7C3F` selects DD02 only when byte `D074` is nonzero (`7C67`–`7C71`); the other
path enters `7A02` and watched/movement work. After either path, the caller invokes `7B7B`
with a parent-frame link, examines AL at `7C92`, and repeats while zero (`7C8E`–`7C94`). DD02
itself reads `D0B2` and `D0AE`, but does not directly advance those clock words.

`[confirmed]` In `7B7B`, zero `D0B8` returns false without advancing. A positive unsigned
`D0B0` is decremented and also returns false (`7B83`–`7B98`). Otherwise, `D0B9` is set from
whether the wrapping word sum `D0AE+D0B4` is zero. If that flag is false, the routine decrements
`D0AE` when nonzero, otherwise `D0B4`, and increments `D0B2` only while it is below `0x80`
(`7B9B`–`7BCC`). It refreshes display state and reloads `D0B0` from zero-extended byte `0D28`
(`7BD0`–`7BDE`).

`[confirmed]` Termination is then selected when the zero-extended word `D0AE` equals the
sign-extended byte `D0AC`, or when `D0B9` is set (`7BE1`–`7C16`). The comparison is prepared
as two-word values: sign extension of `D0AC` is significant. The routine performs display/event
calls on that path and returns a true byte. The return value is available at caller address
`7C92`; before the callee's final `MOV` at `7C38`, it is still local `[BP-1]`, not necessarily AL.

`[derived]` T11's 92/95 D983-call counts suggest corresponding quick-step counts because DD02
contains one unconditional D983 call. T12 must measure the full DD02 and subsequent clock
boundaries before attributing those counts to a clock mechanism. This reading does not identify
one DD02 call with one minute or prove timer independence.

## Recording and the next Rust boundary

`[designed]` T12 records decoded fields and literal expected draws from original execution.
Useful hook locations are:

| Hook | Observation point |
| --- | --- |
| `DD02` | entry before ENTER; globals, seed pointer, score/clock inputs |
| `DD65` | both rating calls completed, before chance selection |
| `DD7C` | D983 completed; generated counts, seed and saved-score frame |
| `DDE4`, `DDEF`, `DE00` | minute return/store and completed fill; repeated fills retain outer/inner indices |
| `DE5C`, `DE92`, `DED4` | scorer draw, availability result, resolved roster index |
| `5083` / return `DF0F` | helper arguments, nested draw span and observed state changes |
| `DF35` | goal-placement block completed, before restoring global score |
| `DF65` / `DF6A` | history write arguments and packed destination byte after return |
| `E006` | DD02 completed before epilogue, including post-step player changes |
| `7B7B` / caller `7C92` | subsequent clock inputs, outputs and returned termination byte |

`[designed]` A bounded next Rust target is `DD7C..DF35`, supplied with the measured post-D983
state and explicit callback contracts for availability, roster mapping and goal recording.
`5083`'s nested RNG consumption must remain part of that contract. Alternatively, port ratings
production before enlarging the Rust step. Full DD02 entry/exit observations are useful evidence,
but are not a claim that the whole routine is closed over only seed and scores: its helpers can
modify player records, logs, scene/configuration state and screens. No Python engine model,
whole-memory/CPU/timing equivalence, full-match replay or watched-engine parity follows here.
