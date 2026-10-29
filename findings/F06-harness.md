# F06 A week of One-Nil 96 runs as guest code under Unicorn from a savestate, screen for screen as in DOSBox-X, and every draw of its random generator is traced

- **Status**: proposed
- **Task**: T06 (#11)
- **Edition**: 96.
- **Sources**: `runtime/emul/guest.py`, `runtime/emul/match.py` (code `59883d4`, unicorn 2.1.4);
  the trace `traces/T06/cf7eb2d04211ba88-week.jsonl` (format: `runtime/emul/README.md`); its start
  state is `T04-load-r0001`'s end savestate, sha256 `cf7eb2d0…` (`.cache/states/T04/`, the owner's
  Drive `states/T04/`); the DOSBox-X run of the same week from the same state: `T04-week-r0001`.

## Answer

1. `[confirmed]` The guest resumes the savestate's memory and CPU state (CS:IP at `26B8:00B6`, inside
   `Dos.Intr`, F02's unit 26B8) and its text page (DOSBox-X keeps it in the `Vga` component, copied
   to B800:0000), and runs `1-0.EXE`'s own code from there to every key wait of a week.
2. `[confirmed]` What the game needs from outside its code, read in the listing and served by the
   guest:
   - **Keys** come through the game's own IRQ 1 handler `24BC:0AD0` (IVT 9 points to it; it reads port
     60h and stores the key at `DS:DE8C`), polled by keypressed `24BC:0C58`; readkey `24BC:0C17`
     blocks in a loop calling it from `0C3E`. INT 16h is not used for keys.
   - **The mouse** is read on every poll (`24BC:098F`, `INT 33h AX=3`) and turned into cursor keys
     when it moves away from (100, 100), where the game recentres it (`0A6F`–`0AAA`). A guest
     answering another position walks the menus by itself (seen: the highlight moved with no key).
   - **The match's timer**: `1998:00BA` installs `1998:0000` on INT 1Ch and sets the timer
     chip's divisor to 0x400; that handler counts `DS:D088` down (the waits of `1998:00D6`), steps
     `DS:0D5A` and decrements the BIOS tick count through `[DS:DE26]`; `1998:00CD` restores the
     vector and the rate. Without it the match polls for ever.
   - **DOS**: in this week, INT 21h `25h`/`35h` (vectors) and `3Ch`/`40h`/`3Eh` (the auto save
     writes a file; into the guest's in-memory folder only).
3. `[confirmed]` **Week 1 replays.** From the same savestate, the guest's week (keys chosen
   closed-loop as `runtime/driver/weeks.py` chooses them) passes 10 key waits; the last 7 are byte-
   identical screens (chars and attributes) to the 7 screens of `T04-week-r0001`, in order: the
   pre-match screen, the half-time board, the second pre-match screen, the full-time board, the
   cash flow, the last "press any key", and the main menu after the week. The result is
   BLACKBURN R 0, P ST GERMAIN 2 on both (`match.py --compare`: "7 of the record's 7 screens met").
   The 3 waits before them are the menu walk to PLAY NEXT GAME, which T04's records do not read.
4. `[confirmed]` **The draws.** The week calls the generator `24BC:0CDC` 23,006 times. Every draw
   satisfies `seed' = seed*0x7ABD + 0x1B0F (mod 2^16)`, `value = ((seed'*n) >> 16) + 1` (F02 item 4),
   and each draw's `seed_before` is the previous draw's `seed_after`: one unbroken stream. The first
   draw starts from 59, asked by the match seeding's fill loop (`0AB9:1A01`, in `0AB9:19CA`): the
   game-state record holds bytes 0 and 1 = 0 and 1 at the menu, and the week advance increments byte
   0 before the match, so the seed is `1 + 58*1` (F02 item 6, now seen running).
5. `[confirmed]` **Deterministic.** Two runs from the same state give byte-identical traces
   (sha256 equal; T06 Done-when 3). The guest delivers 2,789 timer ticks, one per 17,000
   instructions (`[designed]`, about DOSBox-X's rate at cycles 20000), not DOSBox-X's timing.
   `[derived]` with item 3: this week's screens and result do not depend on when the timer ticks
   (one week shown; the watched match, which waits on `D088` far more, is not).

## Open

- The watched match (Watch match on), and weeks with other screens (contracts, a sale, a league
  match with the ineligible-player stop).
- Which routines the 23,006 draws come from, mapped to the match's rules (the next reading, O-M3a):
  the most frequent callers are `0AB9:D9BD`–`D9F3` and `1998:14D0`–`19CD`.
- Traces from other start states (more weeks, seeds), for onenil's tests.
