# F04 One-Nil 96 runs unattended under DOSBox-X 2024.03.01: launched, keyed, read, saved and restored; it loads SAVE1.1-0 and plays on, with no registration text, the same way each time

- **Status**: proposed
- **Task**: T04 (#7)
- **Edition**: 96 (`1-0.EXE`, records/T01/inventory.json).
- **Records**: `runs/T04/` — the cycle `T04-r0001`…`r0010` (code `30a6840`); three load runs
  `T04-load-r0001` (`0143430`), `r0002` (`052b13e`), `r0003` (`9253999`), each followed by the week
  records of its session: `T04-week-r0001`…`r0005`, `r0006`…`r0011`, `r0012`…`r0018`. The last
  week of each session is `aborted` (the reason is in its status and below). Savestates are kept
  in `.cache/states/T04/` and on the owner's Drive (`states/T04/`, 21 files, `rclone check`: 0
  differences); records hold their sha256. `python3 runtime/validate.py runs/T04` passes.
- **Machine and tools**: Ubuntu in WSL2; DOSBox-X 2024.03.01 SDL2 (`~/tools/dosbox-x-2024.03.01`),
  Xvfb, xdotool; machine `svga_s3`, memsize 16, core `normal`, **cycles 20000** (fixed); each
  record's `runtime.fingerprint` has the versions. The driver is goal2-archaeology's (`774473eb`),
  ported: `runtime/driver/`.

## Answer

1. `[confirmed]` The cycle — a fresh DOSBox-X process, 1-0 run to its title screen, a key `n`, a
   savestate restored (the print-screen load key), the key again, the start state restored again —
   completed 10 of 10 times (`T04-r0001`…`r0010`), every `before` screen with sha256
   `bd2633ce…`, every reset equal to it. The BIOS video mode byte is 03 (80×25 text) at every read.
2. `[confirmed]` At cycles 20000 no screen shows "Runtime error" (575 screens of the T04 records,
   each checked for "REGISTER", "purchase" and "Runtime error": none). F01 item 4's hazard (TP7 Crt's
   division by 55) does not occur at this speed; higher speeds were not tried.
3. `[confirmed]` **96 loads a saved game.** In each of the three load records, Y at "Do you want to
   load a saved game? (Y/N)" leads, without a purchase message, to the main menu of `SAVE1`
   ("GAME NAME: SAVE1", Blackburn R, manager Dalglish, money 452,000, season 1994/95). This decides
   F02 item 13 for the load: the load test is compiled false, as read.
4. `[confirmed]` **96 plays on.** After a load, 4, 5 and 6 consecutive weeks completed
   (`T04-week-r0012`…`r0017`: Friendlies #1–#4, then League matches #1–#2), each from the main
   menu through PLAY NEXT GAME to the next main menu; no screen showed the registration text.
   `[derived]` with F02 item 12 (no code references the text): no registration stop in this build.
   Six weeks do not show that none occurs later in a season.
5. `[confirmed]` **The same week replays the same way.** The main-menu screen after week k is
   byte-identical across the sessions that reached it: weeks 1–4 in all three, week 5 in two
   (`T04-week-r0001`/`r0006`/`r0012`, …). The sessions started at different host times (13:12, 13:17,
   13:20 UTC). `[derived]` consistent with F02 items 4 and 6 (the seed is saved, and a match's seed
   comes from the game state, not the clock); the screens compared are the menus, not each draw.
6. `[confirmed]` What a week needs, as the runner (`runtime/driver/weeks.py`) does it: select PLAY
   NEXT GAME, then PLAY GAME on the pre-match screen; pass "press any key", "hit any key" and "any other
   key to continue" with Space (match statistics, the cash flow, transfer news); answer N to a (Y/N)
   question (one met: "Do you agree to sell Sutton (Y/N) ?", `T04-week-r0017`, declined); on PLAYER CONTRACT, Return through the categories to OFFER CONTRACT and
   offer the default terms ("CONTRACT ACCEPTED", `T04-week-r0010` and `r0016`); wait while a match
   board is on screen. "Watch match" was turned off in Game configuration in every load record; a
   league match still shows the quick-result board (`T04-week-r0011`).
7. `[confirmed]` The three aborted weeks: `T04-week-r0005` stopped on the contract screen (the rule
   came after it), `r0011` on the league match board (the match rule came after it), `r0018` on
   League match #3, where the game answers PLAY GAME with "Blackburn R has an ineligible player in
   the first team : hit any key" and returns to the pre-match screen (400 reads). Choosing the team
   is beyond T04 (its Done-when 3 was amended for this, `34d3308`).

## Hazards found

- **Savestates during a load crash DOSBox-X 2024.03.01.** Reading screens in quick succession right
  after Y crashed it ("*** buffer overflow detected ***", exit -6) in the first exploration; the
  runner waits 3 s after Y before its first read, and no crash recurred in 3 loads. goal2 saw the
  same abort after its help viewer (its F001, docs/environment.md).
- **A key can be lost on a menu**: 15 Downs once reached the 15th item, not the 16th; the runner
  selects menu items closed-loop by the highlighted row (attribute 0x70, `runtime/driver/screens.py`).
- **A watched match is paced in real time**: a half took about 3.5 minutes of wall time at cycles
  20000 (exploration, no record); with Watch match off, a friendly takes seconds.

## Open

- Choosing the team (the squad screen), so a run can play a whole season.
- Whether a match's draws, not only the menus, replay exactly (the harness task, T05).
