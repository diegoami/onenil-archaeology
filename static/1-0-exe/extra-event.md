# DBC6 quick-step decision contract (T17)

`[confirmed]` The 96 listing at `99c4dc1`, `code/seg_0AB9_20.asm` DBC6..DCFF,
selects an extra-event candidate after the deterministic prefix. DD02 calls it only on
the zero local goal-flag path when D6DD is nonzero (F16 at `f6841e0`). Its parent-frame
argument is removed by `RET 2` and never dereferenced.

`[confirmed]` The first `232A:076D(10)` result is incremented, stored at BP-4, and
used to read the other candidate from byte D00+index into BP-6. Each candidate gains
the byte at D56+its local array index. Physical scenes are DS:CCEF+25*index. The call
order is availability on BP-4 then BP-6, short-circuiting on nonzero. Two available
candidates cause the `24BC:0D3F` coin, selecting array index 0 or 1. This is the wrapper's
boolean result (`raw draw == 1`), not the raw RNG value.

`[confirmed]` The opposite candidate's scene rating uses mode14 and the selected candidate's
uses mode6. Their comparison is unsigned (`DC80 JAE`). Only a strictly smaller selected
rating continues. Predicate `1A4C(mode4)` is tried first; on false, `0D1C(20)` must return
true to continue. `4E0C` then provides each candidate's random bound: opposite first,
selected second. The selected draw must be strictly greater under signed word comparison
(`DCD7 JLE`). On success D0A0 gets the selected candidate's low byte, D09F the opposite
candidate's low byte, then `69B8` runs. No other DBC6 instruction writes those globals.

## Helper inputs and arithmetic to preserve in the native task

`[confirmed]` `1CA1` calls `4F89` with scene+14's player ID (F16). `1A4C` tests
one-based membership via `24BC:0259`. For mode4, D6DD=0 forces false. Otherwise player
byte10 bit8 chooses a player override bit4; without the override the scene's slot byte
at+7 chooses club D6E4 or D6E6 and club byte57 supplies bit4. These are control flags,
not evidence of an English game-level event name. Listing: `seg_0AB9_03.asm` 1A4C..1ADF.

`[confirmed]` `1AE2(mode6/14)` reads player15 bytes6/8, player8 byte0, scene bytes7/18/22,
D6E6, D1CE/D1CF, D29 and 9FB+mode. Its base-skill helper `9F6E` reads player8
bytes4/5/7 and two tables: byte at `957D+22*byte7+mode`, then byte at
`96B1+22*byte5+first_cell`. It multiplies that second cell by byte4+1, retains the low
word and shifts it right5. The recorder exports these as named raw lookup cells per
player/mode, not copies of table memory. Listing: `seg_0AB9_15.asm` 9F6E..9FCD.

`[confirmed]` The scene-rating helper uses signed player15 bytes6 and8. When signed
byte6<32, local BP-4 becomes byte6+1. Otherwise, if the side flag selected by player8
byte0==D6E6 is nonzero, local BP-4 becomes zero; if the flag is zero it adds32 to the
existing local BP-4 without first assigning it in this invocation. The preexisting stack
word is therefore an explicit observation, not an assumed zero. Modes6/14 add signed
byte8 to this word. A nonzero scene byte22 halves the base skill. The subsequent unsigned
multiply retains its low word before shifting8 and adding base_skill>>2. Optional unsigned
scene byte18 and the D29/slot<12 sixteenth bonus follow; unsigned values below1 become1.
Listing: `seg_0AB9_03.asm` 1AE2..1BD3. The generated decompile hides the stack dependency.

`[confirmed]` `4E0C` uses player8 bytes1/3/5. Unsigned byte1<18 takes the signed
maximum of `byte5-1-3*(18-byte1)` and zero, then returns its low byte. Otherwise it
returns the low byte of `byte5-(byte3&1)`. Listing: `seg_1B55_08.asm` 4E0C..4E7E.

## Capture boundary

`[designed]` Inputs contain 22 ordered physical scenes, canonical player definitions,
two clubs' byte57, selection/bonus flags, opponent selector cells, raw skill lookup cells,
actor/secondary and seed. Direct helper observations retain caller, arguments, result and
draw position. Each scene-rating invocation retains the preexisting stack word. DBC6's
draws are copied literally from the independent T08 trace; its five return sites are
DBD1/DC38/DC98/DCBF/DCD4. All 69B8 draws are separately owned by its boundary.

`[designed]` The optional dispatch snapshot is taken before DCFB calls 69B8; the DBC6
return snapshot is after that call. They are observations of a still external handler,
not an implemented handler or a license to replace computed state with expected outputs.
The named snapshot is not a whole-memory projection. 6B2F,52B6,78B7, continuous DD02,
whole-match/week, watched-engine and timer/render parity remain pending.

`[confirmed]` T18/F18 at `b41656a` corrects the **input coverage**, preserving T17
records: `232A:076D(10)` returns 1..10 and DBD1 increments it, so the lookup uses
D02..D0B. T17's raw `opponents` array contains D01..D0A and is missing D0B.
The two supplementary original runs directly capture D0B at all 184 DBC6 entries
and reproduce the complete T17 observations, T08 events and ordered DOSBox-X waits.
The native consumer must load the separately pinned raw cell, not infer it from
expected helper arguments. Its observed value is 2 in every entry.

## Observed coverage

`[confirmed]` Six completed original captures at `a455882`, produced by `e26e7b4`,
match the retained T16 observations and T08 events/screens. They cover 184 DBC6 calls,
499 decision draws, 909 direct helpers and 22 external dispatches (17 further draws),
with all 15 T08 references checked. See proposed F17 for the observed branch counts and
the unobserved stack-dependent branch. `python3 runtime/emul/extra_event.py --check`
checks the literal source links and exported inputs without any Python engine formula.
