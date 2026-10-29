# F06 A week of One-Nil 96 runs as guest code under Unicorn from a savestate, with the same screens as in DOSBox-X, and every draw of its random generator is traced

- **Status**: proposed (revised after the O-M2 review and re-review, #22)
- **Task**: T06 (#11); fixes #23–#31, #33, #34
- **Edition**: 96.
- **Sources**: `runtime/emul/guest.py`, `runtime/emul/match.py`, `runtime/emul/listing.py` (code
  `8fbf1e8`, unicorn 2.1.4); run records `runs/T06/T06-r0003` and `T06-r0004`, and their traces
  `traces/T06/cf7eb2d04211ba88-week-r0003.jsonl` / `-r0004` (format: `runtime/emul/README.md`). The
  start state is `T04-load-r0001`'s end savestate, sha256 `cf7eb2d0…` (`.cache/states/T04/`, the
  owner's Drive `states/T04/`); the DOSBox-X run of the same week from the same state is
  `T04-week-r0001`. Earlier traces are kept as recorded and superseded: `-week.jsonl` (its callers,
  #23; another clock) and `-week-r0001`/`-r0002` (T06-r0001/r0002: a new divisor waited for the old
  deadline, #33).

## Answer

1. `[confirmed]` The guest resumes the savestate's memory and CPU state (CS:IP `26B8:00B6`, inside
   `Dos.Intr`) and its text page (DOSBox-X keeps it in the `Vga` component; it is copied to
   B800:0000), and runs `1-0.EXE`'s own code from there to every key wait of a week. The CPU
   component's layout is goal2's calibration (774473eb), not calibrated anew on 96's states; that
   the guest runs to the same screens (item 3) is the check made of it.
2. `[confirmed]` What the game needs from outside its code, read in the listing and served by the
   guest (`guest.py`'s docstring):
   - **Keys** come through the game's own IRQ 1 handler `24BC:0AD0` (IVT 9; it reads port 60h,
     keeps a held-key table at `DS:DEA3` (0B1E/0C04) and stores the key at `DS:DE8C`), polled by
     keypressed `24BC:0C58`; readkey `24BC:0C17` blocks in a loop calling it from `0C3E`. INT 16h
     is not used for keys. The guest delivers a key only while IF is set, its make at a poll, its
     break at the first poll 0.08 s of instructions later (T04's hold).
   - **The mouse** is polled while its enabled flag is set (`24BC:0996`); a position outside
     x 70..130, y 80..120 becomes a cursor key (`0A6F`–`0AA0`), and the game recentres it at
     (100, 100) (`0AAA`). The guest answers no button and the position last set: a controlled,
     stationary mouse, not the savestate's mouse driver.
   - **The timer**: `1998:00BA` installs `1998:0000` on INT 1Ch and sets the timer chip's divisor
     to 0x400; that handler counts `DS:D088` down (the waits of `1998:00D6`), steps `DS:0D5A`, and
     takes 1 off the BIOS count 0040:006C at 63 of each 64 ticks; `1998:00CD` restores the vector
     and the rate. The guest models the timer chip (the divisor read from port 40h; IRQ 0 every
     divisor x 20,000,000 / 1,193,182 instructions, the first one a new period after the divisor's
     write, #33) and DOSBox-X's BIOS tick (0040:006C + 1, then INT 1Ch). The guest's clock is off by
     less than 1,000 instructions at each early end of a slice (a key wait, a divisor write). Whether
     DOSBox-X restarts the count at the write is not checked.
   - **DOS and the mouse driver**, in this week (`end.service_counts`, `end.mouse_answers`,
     `end.dos_calls` of `-week-r0003`): INT 21h 35h once and 25h twice (the timer vector), then 3Ch
     `SAVE1.1-0`, 28 writes (40h) and 3Eh; INT 33h AX=0003h 272,087 times, each answered (0, 100,
     100); none unserved. The auto save's 28 writes have the lengths of F03's 28 save blocks, in
     order (R24–R51), confirmed in a run.
3. `[confirmed]` **Week 1's screens.** From the same savestate the guest passes 10 key waits; the
   7 screens of `T04-week-r0001` occur among them in the record's order, byte-identical (chars and
   attributes): the pre-match screen, the half-time board, the second pre-match screen, the
   full-time board, the cash flow, the last "press any key", the main menu after the week (key
   waits 3–9; 0–2 are the walk to PLAY NEXT GAME, which T04 does not read). The full-time board reads
   BLACKBURN R 0, P ST GERMAIN 2 on both. What is compared is these 7 text pages; the game state
   beneath them is not compared with DOSBox-X (T04 recorded none), and the auto save's file is
   recorded by digest only.
4. `[confirmed]` **The draws.** The week calls the generator `24BC:0CDC` 23,006 times; every draw
   satisfies `seed' = seed*0x7ABD + 0x1B0F (mod 2^16)`, `value = ((seed'*n) >> 16) + 1` (F02 item 4),
   and each `seed_before` is the previous `seed_after`. The first draw starts from 59 and is asked by
   the match seeding's fill loop: its callers read `0AB9:1A01` (in `0AB9:19CA`) and `0AB9:E24F`
   (in `E1F2`, which calls `19CA` near). Every caller address in the trace is in the listing's
   segments, and no chain ended in "?". The managed club's match runs from `0AB9:E1F2`'s entry
   (before draw 0) to its return (after draw 5,852); the other 17,153 draws are the round's other
   fixtures and the week's other work.
5. `[confirmed]` **Repeatable.** `T06-r0003` and `T06-r0004` ran from the same state at the same
   code and wrote traces with the same sha256 (`535aa149…`); so did `T06-r0001` and `r0002`
   (`0a8f5da6…`). `[confirmed]` **Three clock schedules, the same week.** The first trace (a tick
   into the game's handler every 17,000 instructions, none from the BIOS, 0040:006C + 1 at each
   read), `-week-r0001` (the timer chip, but a new divisor waiting for the old deadline: 2,893
   ticks into the game's handler) and `-week-r0003` (the timer chip, the next tick from the write:
   2,952) have identical draws (n, seeds, values; callers too for the last two), identical screens,
   and, for the last two, identical end-of-week state digests and files written. `[derived]` For
   this week, the draws, screens and the state left did not change between these three schedules.
   That is three schedules, not all of them, and none is DOSBox-X's real timing; the watched match,
   which waits on `D088` far more, is not covered.

## Open

- The watched match (Watch match on), and weeks with other screens (contracts, a sale, a league
  match with the ineligible-player stop).
- A DOSBox-X run that records game-state digests, to compare the state a week leaves (item 3).
- Which routines the draws come from, mapped to the match's rules (O-M3a): the most frequent callers
  are `0AB9:D9BD`–`D9F3` and `1998:14D0`–`19CD`.
