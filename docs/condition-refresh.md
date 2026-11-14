# One-Nil 96: the condition refresh after a match

[confirmed static: 61118f3, `static/1-0-exe/code/seg_1998_03.asm`,
1998:14A5–154B; `decompiled/seg_1998_01.c`, f_1998_14A5] The condition
write is **1998:1546**, copying player p15+7 to p15+8, where
`p15 = far [DS:D7BE] + 15*player_id`. The refresh changes p15+7 first;
it does not add a constant to the match-depleted p15+8. These are separate
signed byte fields. No Python engine model is introduced here.

## The positive-condition branch

[confirmed static: same source, 14B9–1527] If signed p15+8 > 0, take two
draws through 232A:076D, in this order. Write the clamped candidate to
p15+7, then copy it to p15+8:

| Caller flag | Ordered draws | Candidate for p15+7 | After clamping |
| --- | --- | --- | --- |
| Nonzero | a = R(2), b = R(8) | signed(p15+7) + b − a | No further adjustment |
| Zero | a = R(3), b = R(2) | signed(p15+7) + b − a | Increment p15+7 if its signed value is < 25 |

[confirmed static: 61118f3, `code/seg_232A_01.asm`, 076D–0780;
`code/seg_24BC_02.asm`, 0CDC–0D19] R(n) is the original shared RNG:
seed = (seed*31421 + 6927) modulo 65536, result = high16(seed*n)+1.
For these positive bounds it returns 1 through n inclusive. Intervening
caller/helper draws matter; save endpoints do not reveal their values.

[confirmed static: 61118f3, `code/seg_1998_02.asm`, 11EC–12BB;
`decompiled/seg_1998_01.c`, f_1998_11EC; `data/ds_2864_01.hex`, DS:0D60
row] The clamp receives the candidate as a **signed low byte**, not a
wide mathematical integer. With `p8 = far [D7BA]+8*player_id`:

1. Raise a signed candidate below 1 to 1 (1202–1208).
2. Cap it at 32 if unsigned p8+1 <= unsigned p8+2 + 3; otherwise cap it
   at 25 (120C–125C; DS:0D72 and DS:0D73 are 32 and 25).
3. If unsigned p8+1 > 19, apply an additional cap of
   `27 + (unsigned facility_byte >> 5)` (125F–12AE).
   The facility byte is `[DCC8] + 4*word([D7C2]+62*unsigned(p8+0)-18) + 2`.
   Preserve that address calculation, including the club indexing.

[derived from the listed branch] The zero-flag increment is **after** the
clamp and has no second clamp. A result below 25 increases by one even if
it was just capped. Treating it as part of the unclamped candidate changes
boundary behavior. The listing's `98` instructions sign-extend AL into AX
in 16-bit code, despite Capstone's printed `cwde` mnemonic. Likewise `99`
sign-extends AX into DX:AX. Ghidra's wide comparison in f_1998_11EC is
checked against 1293–12A9 rather than copied as a host-language expression.

## Which caller flag is used

[confirmed static: 61118f3, `code/seg_0AB9_21.asm`, E7DA–E819;
`code/seg_1998_03.asm`, 1897–19F8; `decompiled/seg_1998_02.c`,
f_1998_1897] Match postprocessing calls 1998:1897 for both clubs. It
walks the club's twenty roster words, skipping zeros. Slots 1–11 (one-based)
and later slots with status bit mask **0x04** set call 14A5 with flag 1
(18F3–1937). Other later slots call it with flag 0 (19BE–19F8).
24BC:0259 takes a one-based bit number: argument 3 means mask 0x04,
as verified at `code/seg_24BC_01.asm`, 025D–026A. Do not substitute
current position, present condition, or the final cleared status for this
caller decision; the status is subsequently changed by other helpers.

[confirmed static: 61118f3, `code/seg_01EF_07.asm`, 4E14–4E2C;
`code/seg_1998_03.asm`, 16B1–1869] The later week-processing path also
calls 1998:16B1 for managers 1 and 2. It visits the separate manager roster
at `[D7D2]+40*manager+48` (twenty words), skipping an inactive manager
(`[DCB9+manager]==0`) and zero player IDs. Its flag derives from the
current fixture's competition byte being nonzero; for p8+1 >= 18 it inverts
that flag before calling 14A5 (17CC–1815). This separate roster path must
not be mistaken for another unconditional update of every first-team player.
Afterward 1998:15FA scans clubs with a zero current competition byte,
visiting only players whose p15+8 is exactly zero (1608–169B).

## Nonpositive conditions and scope

[confirmed static: 61118f3, `code/seg_1998_03.asm`, 152B–1546,
13F9–14A2] If signed p15+8 <= 0, 14A5 calls 13F9 instead of the positive
branch. That helper takes R(2), then R(8), clamps `signed(p15+7)+a−b`
through 11EC, and writes p15+7. It also updates p15+14 using a further
facility-dependent draw, floors a negative signed result to zero, and
returns whether p15+14 is zero. Only a true return permits the p15+7 →
p15+8 copy. This is a static branch description, not a validated injury
or suspension model; no +12/+13 rule is claimed by T83.

## Retained original observations and validation

[confirmed: 61118f3, `records/T83/conditions-r0001.json`;
`runs/T81/session-r0007.json`, producer b80f091] The complete decoded
first-team roster contains 18 nonzero players. Seventeen condition bytes
change across the saved friendly week, including Gale 17→19; Pearce stays
31→31. Positions and instructions are stable. The record compares the
**pre-match baseline** with the **post-week save**, not a save immediately
before 14A5. It therefore does not measure the two RNG results per call,
prove that any named player took a particular branch, or isolate the
effect of the later manager-roster pass.

[designed:T83] The old receipt is immutable. Its `producer` names b79e47b,
but its week_completion.py digest matches the code committed at 61118f3;
the producer was dirty when it was captured. `conditions-r0002.json`
re-decodes the same digest-matched private saves from a clean committed
producer. The public validator authenticates that producer, the T81 session
and save identities, the roster slots, and the two independently observed
case players. It also compares the complete decoded projection with the
historically committed r0001 projection. That last comparison detects
receipt corruption; it is not an independent re-decode of private bytes.
With both private saves supplied, every bounded field is re-decoded too:

```sh
python3 runtime/driver/week_completion.py --check-conditions records/T83/conditions-r0002.json
python3 runtime/driver/week_completion.py --check-conditions records/T83/conditions-r0002.json --save-pre .cache/One-Nil96/SAVE1.1-0 --save-post .cache/T81-original-r0007/game/SAVE1.1-0
python3 -m pytest -q tests/test_week_completion.py tests/test_condition_refresh.py
```

[derived] A native implementation may translate the static positive-condition
contract using the live p15+7, the original caller flag, clamp inputs and
shared RNG stream. It must not reuse this week's eighteen output bytes as
a general refresh rule, or consume fresh arbitrary draws after match posting.
Original per-call RNG/entry-state tracing and native composed replay remain
follow-ups; this one friendly save pair establishes endpoint values only.
