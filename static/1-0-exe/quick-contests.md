# One-Nil 96: the quick engine's contests, `0AB9:D983`

`[confirmed]` This contract is read from the committed listing at archaeology commit
`7859d7d1903d497cdab24466f2cc2cfcee005f05`: `code/seg_0AB9_20.asm` (`D983`–`DA3E`),
`code/seg_232A_01.asm` (`076D`–`0780`), `code/seg_24BC_02.asm` (`0CDC`–`0D19`) and
`code/seg_24BC_04.asm` (`1F1F`–`1F27`). It specifies this routine's semantic inputs,
draws and outputs, not the surrounding match loop or a complete match.

## Inputs and persistent state

`[confirmed]` `D983` is a near procedure with one word argument, `k`. Before its `ENTER 8,0`
at `D983`, `k` is at `SS:SP+2`; after `ENTER`, `D987` reads it from `[BP+4]`. The initial
`CMP`/`JBE` at `D990`–`D993` is unsigned: `k=0` reaches the epilogue without any draw or goal
write, and each positive 16-bit `k` runs exactly `k` chances (`D998`, `D99D`, `DA32`–`DA3A`).

`[confirmed]` The four ratings per side are words at `DS:D674 + 4*c + 2*s`, for class
`c=0..3` and side `s=0,1`. In address order the eight words are:

| Addresses | Class (F09's semantic names) | Order |
| --- | --- | --- |
| `D674`, `D676` | goalkeeper | side 0, side 1 |
| `D678`, `D67A` | defence | side 0, side 1 |
| `D67C`, `D67E` | midfield | side 0, side 1 |
| `D680`, `D682` | attack | side 0, side 1 |

The addresses and operands are read at `D9B4`, `D9C3`, `D9DB`, `D9EA`, `DA02` and `DA11`.
The routine reads these words but does not write them. `[derived]` The football names follow
F09 item 4's rating-class reading; they are labels for the address groups, not additional
semantic inputs.

`[confirmed]` The accumulated goals are the two bytes `DS:D086+s`. D983 does not clear them:
its only direct goal write is the byte increment at `DA25`. Its DD02 caller clears both bytes
at `DD44`–`DD46` before setting ratings and calling D983 at `DD79`
(`code/seg_0AB9_21.asm`), but that caller behaviour must not be substituted for the procedure's
general input contract.

`[confirmed]` The random generator's state is the word through the far pointer at `DS:DE84`.
`24BC:1F1F`–`1F27` initializes that pointer to `DS:A51C`; `24BC:0D05` reads the pointer on
each call. A recorder should read or verify the pointer rather than assume that its target is
always fixed.

## Chance order and draws

`[confirmed]` For each chance, D983 processes side 0, then side 1 (`D9A0`–`D9AA`,
`DA29`–`DA2F`). Each side has at most three contests, in the following order. Within a contest,
the opponent's draw is first and the side's own draw is second. `s xor 1` selects the opponent.

| Contest | First request and return site | Second request and return site |
| --- | --- | --- |
| 1 | opponent midfield (`D9B4` → `D9BD`) | own midfield (`D9C3` → `D9CC`) |
| 2 | opponent defence (`D9DB` → `D9E4`) | own attack (`D9EA` → `D9F3`) |
| 3 | opponent goalkeeper (`DA02` → `DA0B`) | own attack (`DA11` → `DA1A`) |

`[confirmed]` The side continues only if its own draw is strictly greater than the opponent's
as a **signed 16-bit** word. The listing uses `CMP AX,DX; JLE` at `D9CD`–`D9CF`,
`D9F4`–`D9F6` and `DA1B`–`DA1D`. Ties lose. A loss skips the remaining contests for that side,
but not the next side or chance. Winning all three increments `DS:D086+s` by one, modulo 256
(`DA1F`–`DA25`). A positive chance therefore consumes between four and twelve generator calls
across both sides.

`[confirmed]` All six calls use `232A:076D`, which forwards the word argument to `24BC:0D01`
(`232A:0771`–`0774`); that wrapper passes the seed pointer and argument to `24BC:0CDC`
(`24BC:0D05`–`0D0F`). The generator uses unsigned multiplication and a wrapping word update:

```text
seed_after = (seed_before * 0x7ABD + 0x1B0F) mod 65536
value      = ((seed_after * n) >> 16) + 1
```

The first multiply's low word and the wrapping addition are at `0CE6`–`0CF1`; the unsigned
multiply by `n` and increment of its high word are at `0CF2`–`0CF6`. In particular, `n=0`
still advances the seed and returns 1. Nonzero `n` returns a word in `1..n`. The signedness of
the later contest comparisons is separate from this unsigned generator arithmetic.

## Recording boundary and replay scope

`[confirmed]` Entry hook `0AB9:D983` can read `k`, the eight ratings, input goal bytes and the
pointed seed before the routine executes. Exit hook `0AB9:DA3D`, immediately before `LEAVE`,
can read the completed seed and goals. Every path uses that epilogue, including `k=0`; the near
`RET 2` at `DA3E` then removes the return address and argument. At the exit hook, SP and BP still
belong to the callee, so this is a pre-epilogue observation, not a returned CPU snapshot.

`[confirmed]` Excluding ordinary stack-frame writes, the routine and its random wrappers directly
persist changes only to the pointed seed word and the goal bytes. Scratch registers and flags
are not preserved as part of this semantic contract. Separately, the installed timer handler can
run during the call and update `DS:D088`, `DS:0D5A` and BIOS time
(`code/seg_1998_01.asm`, `0000`–`0057`). Seed/goal replay therefore does not establish equality
of the whole machine's memory, registers, instruction timing or clock state.

`[designed]` T11's `runtime/emul/contests.py` records the entry/exit contract with read-only code
hooks at D983/DA3D and compares the intervening draw sequence with T08's retained trace. The
consumer in onenil reproduces the requests, seed transitions, values and final goal bytes from
those routine inputs. Ratings production, DD02's minute/scorer work, match-loop termination,
other fixtures and the watched engine remain separate work.
