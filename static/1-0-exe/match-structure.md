# The match of One-Nil 96: its structure and its draws (T07, F07)

Hand-written from `code/` (the listing) and `decompiled/`, with `drawsites.tsv` (the draws of
`traces/T06/cf7eb2d04211ba88-week-r0003.jsonl`, week 1 of SAVE1, a friendly with Watch match off) as
the map. Addresses are image `SEG:OFF` of `code/`. "Read" means read in the listing at the address
given; anything else says so.

## The call tree

The managed club's match is `0AB9:E1F2`'s call (from the matchday loop `0AB9:EAB6`, F02 item 5); in
the trace it spans draws 0–5,852 (the `match entry`/`match return` marks). Shortest static paths from
`E1F2` (`calls.tsv`) to the routines that draw in it:

    0AB9:E1F2  plays the managed club's match
    ├─ 0AB9:19CA  the match seed and its table                      sites 0AB9:1A01
    ├─ 0AB9:86E9  the kick-off                                      site  0AB9:8750
    ├─ 1B55:284E ─ 1B55:2735                                        site  1B55:27B1
    └─ 0AB9:E008 ─ 0AB9:7D86 ─ 0AB9:7C3F ─ 0AB9:DD02  one step of the quick result
                                             ├─ 0AB9:D983  the chances          sites D9BD D9CC D9E4 D9F3 DA0B DA1A
                                             ├─ (in DD02)  goal minutes, scorers sites DDE4 DE5C
                                             ├─ 0AB9:5083  a goal recorded       site  5190
                                             └─ 0AB9:52B6 ─ 0AB9:A4F2 ─ 0AB9:A34D  site A3A4

`D983` has one other caller, `0AB9:E8F3`, not reached from `E1F2` by direct calls; the week's other
draws at `D983`'s sites (`drawsites.tsv`, `draws_rest`) come after the match return.

## The loop

`0AB9:DD02` is one step. By the decompile (`decompiled/seg_0AB9_09.c`, `f_0AB9_DD02`), not yet
checked line by line in the listing: it zeroes the step's goals (`DS:D086`), sets up both clubs
(`1B55:50EB` twice), calls `D983` with the number of chances `DS:0CFE[DS:D0AC = 15]` (the bytes at
DS:0CFE are 8, 11), places the step's goals (the sites `DDE4`, `DE5C` below) and keeps the score
words around `DS:D086`/`D0C4`.
In the trace `D983` runs 92 times in the match (1,472 first draws of its first contest / 16 per call),
so the step runs 92 times in this specimen. What `7C3F` counts is not read: this does not establish
one step per minute. `7B7B`–`7C38` checks `DS:D0B8`, conditionally advances the clock at
`7B9B`–`7BCC`, and tests `DS:D0AC`, `D0AE` and `D0B9` before termination; its mechanism remains open.

## The draw sites of the managed match

| Site | Routine | n | Draws | What the result decides |
| --- | --- | --- | --- | --- |
| 0AB9:1A01 | 0AB9:19CA | 16 | 255 | the table `DS:CF72`–`D070`: each byte is random(16) − 1 (`1A01`–`1A05`); read after the seed `b0 + 58*b1` (F02 item 6). Where the table is used: not read |
| 0AB9:8750 | 0AB9:86E9 | 2 | 1 | `24BC:0D3F` (a coin flip, 1 when random(2) = 1) stored at `DS:D0AD` (`8750`); [derived, not read further] the side to kick off ("wins the toss") |
| 1B55:27B1 | 1B55:2735 | 999 | 2 | random(999) widened to a long (`27B1` `cdq`) and passed to the run-time's long arithmetic (`26C9:0A67`, `27B2`–`27C3`); what it computes: not read |
| 0AB9:D9BD, D9CC | 0AB9:D983 | the clubs' values | 1,472 each | **contest 1** of a chance, for side s: random(`DS:D67C`[1−s]) at `D9B4`, then random(`DS:D67C`[s]) at `D9C3`; `D9CD` `cmp ax,dx; jle` — s goes on only if its draw is higher (a tie is the opponent's) |
| 0AB9:D9E4, D9F3 | 0AB9:D983 | the clubs' values | 739 each | **contest 2**: random(`DS:D678`[1−s]) at `D9DB` against random(`DS:D680`[s]) at `D9EA`; `D9F4` the same test |
| 0AB9:DA0B, DA1A | 0AB9:D983 | the clubs' values | 368 each | **contest 3**: random(`DS:D674`[1−s]) at `DA02` against random(`DS:D680`[s]) at `DA11`; `DA1B` the same test; won, `DA25` adds 1 to the byte `DS:D086 + s`: a goal for s |
| 0AB9:DDE4 | 0AB9:DD02 | 90 | 430 | random(`DS:0D00`[`DS:D0AC` = 15]) (90, or 120) fills the frame's minute tables (`DDEF`), compared with `DS:D0B2` at `DE40`. Both sides' tables are filled for each entered outer-side pass; see the nested loops below |
| 0AB9:DE5C | 0AB9:DD02 | 30 | 2 | random(30) returns 1–30, added to `0CDF` at `DE5E`: accesses the 30 bytes `DS:0CE0`–`0CFD` (2,3,4,5,5,6,6,7,7,8,8,8,9×6,10×6,11×6). A squad slot 2–11, drawn again until `1B55:4F89` accepts the player; the scorer |
| 0AB9:5190 | 0AB9:5083 | 2 | 2 | a coin flip (`24BC:0D3F`, `518B`) in the routine that records a goal; its use: not read |
| 0AB9:A3A4 | 0AB9:A34D | 6 | 3 | random(6) included in a set at +0x39 of a record (`232A:00F8`, Include, `A3AE`); what the set is: not read |

The minute-fill loops are read in `code/seg_0AB9_21.asm` at `dd1eff1`. The outer index
`[BP−0x22]` runs 1, 2 (`DD7C`, `DF2C`–`DF32`). A side enters the fill body only when
`DS:D085+index` exceeds its saved byte `[BP+index−3]` (`DD86`–`DD95`); `DD98`–`DDA1` subtracts
the saved byte from that selected global byte. Inside **each** entered outer pass, `[BP−0x1C]`
runs 1, 2 (`DDA5`–`DDFE`), and `[BP−0x1E]` runs 1 through that inner side's current byte at
`DS:D085+side` (`DDAF`–`DDC3`, `DDF2`–`DDF8`). Each inner iteration draws a minute and writes it
at `SS:BP + 11*side + goal_index − 0x26` (`DDDF`–`DDEF`). Thus both sides' tables can be filled
again on another outer pass. The later scan compares those entries with `DS:D0B2` and selects a
scorer on equality (`DE32`–`DE94`); after recording a goal it sets the local goal flag and outer
index to 2 (`DF0F`–`DF13`). Replacing this control flow with one minute draw per scored goal would
change the stream: this specimen has 430 minute draws for two scored goals.

`D983`'s six sites are 5,158 of the match's 5,853 draws. `D983(k)`, read whole (`D983`–`DA3D`): for each
chance 1..k and each side s = 0, 1, contests 1, 2, 3 in order, each only if the one before was won;
three won is a goal. The four word arrays of two entries, `DS:D674`, `D678`, `D67C`, `D680`, are the
sides' values; [derived, not read] by the pre-match screen's four ratings (goalkeeper, defence,
midfield, attack), contest 1 is midfield against midfield, 2 attack against defence, 3 attack against
the goalkeeper. Where the four arrays are set (`1B55:50EB`, by its call before `D983`): not read.

## Not read here

What `7C3F`'s loop counts; what the table of `19CA` is used for; the uses of the coin flips at `5190`
and of `A3A4`'s set; `1B55:2735`'s arithmetic; the watched match (Watch match on), which the trace
does not cover; the week's other draws after the match return.
