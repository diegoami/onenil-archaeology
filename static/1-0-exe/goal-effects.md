# One-Nil 96: numeric goal effects, `0AB9:5083`

`[confirmed]` The static claims below are read from the listing at
`a39ac703c09f0981e073d471d61f7bce0f3642e7`: `code/seg_0AB9_09.asm`
(`5083`–`5264`), `seg_0AB9_11.asm` (`67D0`–`6846`), `seg_0AB9_03.asm`
(`1CBB`, `1CD6`, `1D89`, `1DB7`, `1E9F`), `seg_0AB9_02.asm`
(`0D7E`–`0FFD`), `seg_0AB9_05.asm` (`2CB4`–`2CCA`) and the named
runtime helpers. F12/F13 establish the preceding placement and coin boundary.
The decompile is a navigation aid; widths, signedness, argument offsets and
stores are checked in the 16-bit listing. Opcode `98` is CBW here, despite a
listing mnemonic that can read `cwde`.

## Observation and native boundaries

`[confirmed]` `5083` is a near procedure. At its entry before ENTER, its word
arguments are minute at `SS:SP+2`, actor at `SP+4`, and side flag at `SP+6`.
The routine uses the low byte of the flag. Its completed effects can be read at
`5263` before LEAVE; near `RET 6` at `5264` then removes its three arguments.

The one unconditional coin call is `518B` → `24BC:0D3F`, returning at `5190`.
It makes the underlying `random(2)` already modeled by T02. The returned coin
is 1 when the raw RNG value is 1, otherwise 0. The direct-call closure has no
other RNG path or indirect CALL. Under valid disjoint data pointers, its other
effects do not depend on when this seed-only coin step occurs relative to the
preceding logical stores. It does not write `DE84` or the placement generated
bytes `D086/D087`, nor the caller's saved-score frame or `D09F`.

`[designed]` T14 observes the original entry, coin and exit, with RNG metadata
kept separately from the logical state. The native non-RNG handler receives the
pre-5083 logical state and T02's already-consumed coin. It must not generate a
second coin or use a midpoint snapshot whose pre-coin counters have already
been changed. Composition checks can keep the engine's post-placement seed
unchanged while applying these remaining effects. Formatted strings, pixels,
render buffers, scratch registers/stack and asynchronous timer state remain
external.

## Complete typed logical projection

`[designed]` Field names here are descriptive, not a required JSON spelling.
The recorder supplies values on every goal entry rather than deriving missing
inputs from the expected outcome.

| Input/state | Width and meaning |
| --- | --- |
| event | minute `u16`, actor `u16` narrowed only where the original does so, original flag low byte 0/1 |
| consumed coin | integer 0/1, separately observed at `5190` |
| `D1CA`, `D6DD`, `D0B7`, `D0B9` | `u8` tested as zero/nonzero; no new football names assigned |
| global actors `D09F`, `D0A0` | `u8`; `D0A0=0` is a secondary-actor sentinel |
| side offsets | bytes `[0D57,0D56]` in model score-side order |
| club rosters | both 20-word rosters, model order `[club D6E6, club D6E4]` |
| scene records | referenced scene byte `+7` and player ID word `+0E` |
| shared player records | per-ID `p8+6`, `p8+7`, `p15+2` word, `p15+5` byte and `p15+6` byte |
| position weights | signed bytes read at `0D1A + p8_position`; every referenced lookup must be supplied |
| event weights | signed bytes `097A+26h` and `097A+27h` |
| weighted event table | words addressed as `D146 + 40*table_side + 2*slot` |
| scaled player cache | bytes addressed as `D197 + 20*table_side + slot` |
| accepted-event counters | words `D1C0`, `D1C2` |
| conditional counters | bytes `D0D6`, `D0E0` |
| scorer logs | bytes `D128/D129`, with all 11 player-word/minute-byte entries per row |
| numeric commentary queue | head word `0380`; structured event rows, not formatted text |
| copied pair | source words `D08A/D08C`, destination words `D09A/D09C` |

The copied words are not assumed to be coordinates: other code uses LES on
`D08A` and copies 4,000-byte buffers (`0D63`–`0D72`). They can be represented as
opaque paired words in this numeric projection; no native pointer dereference
or buffer rendering is implied.

Supported actors/global actor and scene byte `+7` are 1–22, secondary actor is
0–22, and the two log counts are at most 11. Player IDs are shared identities:
if scorer and keeper refer to the same player, sequential stores must update
one record. They must not update independent copies that discard each other's
changes. This bounded projection does not claim safe behavior for invalid
scene zero, overflowing table indices or aliased game buffers.

### One-based matrix views

`[confirmed]` Helper `1E9F` subtracts 11 from scene byte `+7` only when it exceeds
11; under the supported scene domain its result is 1–11. `1CBB` returns 1 when
that byte is below 12, otherwise 0. `1CD6` instead applies the below-12 test to
global `D09F`. Their table-side results must not be relabeled uniformly as model
score side, home/away or managed-club indices.

`[designed]` A complete 2×20 view can use slots 1–20:

- Event words: `D146 + 40*side + 2*slot`, contiguous words `D148..D197`.
- Cache bytes: `D197 + 20*side + slot`, contiguous bytes `D198..D1BF`.

These are views of exact addressing, not proof of the original Pascal array
bounds. Other commentary paths can use slot zero, creating aliases at a view's
edge. Supported 5083 actors normalize to slots 1–11, so those aliases are not
part of this handler. All unused cells of the chosen view are preserved.

## Update order

### 1. Event weight and numeric commentary acceptance

`[confirmed]` At `5097`–`50A7`, event code is `27h` when `D1CA!=0`, otherwise
`26h`. `1DB7` uses **global `D09F`**, independently of the actor argument:

1. `event_side = (D09F < 12)` through `1CD6`.
2. `actor_slot = normalize(scene[D09F].byte7)` through `1E9F`.
3. Secondary slot is zero when `D0A0==0`, else the normalized byte `+7` of that
   scene (`1D89`).

`0F94` first calls `0F42`, which always wrapping-adds the sign-extended event
weight `097A[event_code]` to word `D146 + 40*event_side + 2*actor_slot`
(`0F70`–`0F8C`). Commentary deduplication does **not** suppress this update.

`0E45` then forms a six-byte numeric event:

```text
(code byte, actor-player word, secondary-player word, event-side byte)
```

The player IDs are roster lookups in club `D6E4 + 2*event_side`; slot zero
produces ID zero (`0D7E`–`0E42`). If head `0380` is nonzero and the current row
equals all four fields, the event is suppressed. Otherwise it wrapping-increments
word `D1C0 + 2*event_side`, advances head cyclically through 1..1700, stores the
new row, and sets the next row's code byte to `FFh`, preserving that row's other
five bytes (`0E5F`–`0F37`, runtime `24BC:042B`). There is no minute in the dedup
key. These counters are accepted-event counters, not established goal counts.

On acceptance, `0F94` also copies `D08A/D08C` to `D09A/D09C` (`0FEE`–`0FF8`).
Formatted rendering by `09BD` and its buffers remains external, but the numeric
updates above cannot be discarded merely because they are reached through a
commentary helper.

`[designed]` The queue projection captures exactly three indices selected from
the **before** head and its next two cyclic indices. For head zero these are
`[0,1,2]`; for 1700 they are `[1700,1,2]`. The after snapshot uses the same three
indices even when head advances. This preserves the old row, newly written row
and next sentinel without dumping the full queue or changing the projection's
identity midway through a call. Stored row fields are full bytes/words; an
unused sentinel row is not required to have a meaningful side value.

### 2. Scorer counters and player-byte update

`[confirmed]` The scorer scene comes from the actor argument, not global
`D09F` (`5087`–`5094`). Only when `D1CA==0`, `D6DD!=0` and its player's
`p8+7!=0`, the routine increments player word `p15+2` and byte `p15+5`, each
wrapping at its own width (`50AA`–`50E8`). These offsets are retained without
inventing universal football meanings for the fields.

It next calls `67D0` on that scene with display flag 1 and delta:

- `-1` when `D1CA!=0` (`50EC`–`5100`);
- otherwise the sign-extended byte `0D1A[p8+6]` (`5102`–`5128`).

### 3. Keeper counters and supplied-coin update

`[confirmed]` The selected keeper ID is the first roster word of the opposing
club: original flag 1 selects `D6E4`, flag 0 selects `D6E6` (`512B`–`5148`).
When `D6DD!=0` and that player's `p8+7==0`, its word `p15+2` and byte `p15+5`
increment, even on the `D1CA!=0` branch (`516D`–`5185`).

The routine calls `67D0` with delta `-1`, display flag equal to the coin, and
the keeper scene `1 + byte[0D56 + !original_flag]` (`5189`–`51AE`). A zero coin
therefore still changes the selected scene player's byte `p15+6`; it suppresses
only the cache write. Preserve update order if different scene/roster selectors
resolve to shared player IDs.

### `67D0`: signed reload and two different clamps

`[confirmed]` `67D0` resolves the player through scene word `+0E`. It reads
player byte `+6` with CBW, adds the signed word delta with 16-bit wrapping,
signed-clamps that word to 1..255 through `24BC:03D9`, and stores its low byte
(`67D4`–`6808`). In symbols:

```text
word = wrapping_i16(sign_extend(old_byte6) + delta)
stored_byte6 = low8(signed_clamp(word, 1, 255))
```

When display flag is nonzero, it reloads the stored byte with **another signed
extension**, computes signed `min(value,32)` using `24BC:04FA`, and stores the
low byte at `D197 + 20*scene_side + normalized_scene_slot` (`6812`–`6841`).
Thus a stored byte 128..255 reloads negative; an unsigned clamp to 0..32 would
be incorrect. The helper returns far at `6846` with eight argument bytes removed.
Its clamp pointer targets its own frame argument, not DD02's saved-score locals.

### 4. Scorer-log write and conditional counter

`[confirmed]` The original side flag is saved before the local flag byte is
flipped when `D1CA!=0` (`51B1`–`51C7`). The log row is therefore
`original_flag XOR (D1CA!=0)`. Its count byte `D128+row` increments only below 11;
at 11, further goals overwrite entry 11 (`51CA`–`5207`).

The player word comes from the **original flag's club** roster, using the scorer
scene's normalized byte `+7`, not the possibly flipped log row (`520A`–`5235`).
The entry's minute byte is `low8(minute)`, followed by a wrapping addition of
`80h` when `D0B7!=0` or `D1CA!=0` (`5238`–`5250`). This is addition, not OR:
a byte already containing its high bit can wrap.

Finally, only when `D1CA==0`, `2CB4` is called with the original flag. It increments
byte `D0D6 + 10*flag` only while `D0B9==0` (`5255`–`5260`, `2CB7`–`2CC5`).

For model rosters `[D6E6,D6E4]` and offsets `[D57,D56]`, the exact adapters are:

| Selection | Model index/value |
| --- | --- |
| scorer/log player roster | `1 - original_flag` |
| opposing keeper roster | `original_flag` |
| keeper scene | `side_offsets[original_flag] + 1` |
| commentary candidate roster | `1 - event_side` |
| event-word/cache/counter row | raw helper side, not the roster index |
| scorer-log row | `original_flag XOR (D1CA!=0)` |

## Replay scope and remaining work

`[designed]` T14 supplies the complete numeric inputs, full selected logical
before/after state and per-call `67D0` observations. The Rust handler applies
these logical writes using the supplied coin and no RNG operation. Composition
with placement must preserve its post-coin seed and consume each pending effect
exactly once. Expected outputs or an expected commentary-accepted boolean are
checks, not control inputs; deduplication is computed from the before metadata.

This contract does not claim formatted commentary/render-buffer, whole-machine,
scratch/timer or full DD02 equivalence. Native ratings, clock, remaining events,
setup/shared random streams, whole-match/week parity and the watched engine remain
separate work. No original asset bytes or Python effects model belong in the cases.
