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

## T84 controlled original-call replay contract

[confirmed: records/T84/calls-r0007.json and calls-r0008.json, producer e04ca81]
Two separate fresh-machine executions each reproduce **21 isolated calls / 47
RNG draws** of the original 1998:14A5. The program is loaded from the known
packed executable (89ff9c5f…) through the pinned unpacker (unpacked digest
887ed2a9…). Every executed instruction is compared with that loaded image.
The harness supplies controlled scalar inputs and a scratch stack, executes the
actual original helpers and RNG, and stops only after the near `ret 4` reaches
the declared sentinel with the expected CS and SP. No helper or output is
implemented in Python. These are **controlled routine calls**, not observations
of the naturally reached match-postprocessing caller or the completed T81 week.

[confirmed: same records] The cases exercise both positive-condition flags,
flag 255, seeds 0/7/65535, the 19→20 facility-cap boundary, equality/inequality
at age_reference+3, both original table caps, the signed floor, and the
post-clamp unused-player increment. For example, the signed-max case starts
p15+7=127 and seed 0; actual R(2)=1 then R(8)=2 produces the signed-byte
wrap and original output 1. The signed-underflow case starts −128 with flag 0;
actual draws are R(3)=2 then R(2)=1, and the original output is 31. Nonpositive
cases separately observe recovery (copy at 1546), a blocked copy, a negative
counter floored to zero, and −128 decrementing with byte wrap to 127. The
blocked case leaves condition zero; the nonpositive examples establish only
this helper's controlled effects, not an injury/suspension model.

[designed:T84] Each case's `input` contains the player/club IDs, age and age
reference, facility byte, original cap values, p15+7/+8/+14 signed bytes, flag
and seed. The consumer must calculate `output` (the three signed bytes and
seed), ordered `draws` and numeric writes. Expected outputs never initialize or
steer a native replay. Memory layout and stack are controlled harness details;
the memory-field map in condition_refresh.py declares the pointers and scalar
operands. Reads outside those fields refuse, and every non-stack write is
recorded with field, width, previous value and new value. The public checker
binds both immutable run files by digest, authenticates their producer files
and code identities, checks full controlled input/branch/read censuses, return,
literal write and draw continuity, and requires byte-equivalent decoded cases
between the two fresh-machine runs. With the private executable available, the
focused test independently executes the cases again and compares observations.

[confirmed: records/T84/calls-r0001.json and calls-r0002.json] The first two
attempts aborted before a completed case because Unicorn 2.1.4's global
memory-read instrumentation re-entered a `RETF` during stack pops. The recorder
now excludes the declared scratch-stack window from read hooks; semantic reads
elsewhere and all write bounds remain audited. No guest instructions change.
The earlier completed r0003/r0004 (16 cases) and r0005/r0006 (21 cases before
explicit cap inputs) remain immutable at their own producer versions. The
current index selects r0007/r0008; earlier attempts are not current acceptance
fixtures. The index is a derived pointer manifest, not a measured output.

```sh
.cache/venv/bin/python runtime/emul/condition_refresh.py --check
.cache/venv/bin/python -m pytest -q tests/emul/test_condition_calls.py
```

[derived] This supplies original-code cases for a bounded native 14A5 port.
It does not yet establish the live p15+7 handoff, all intervening caller draws,
the distinct manager-roster pass, or the campaign's persistence of those fields.
Those remain prerequisites to enabling a faithful desktop week refresh. The
T83 save endpoint record and the native B5 exclusion are unchanged.
