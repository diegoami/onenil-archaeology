# Saved roster after a managed watched-match replacement

[designed:T80, issue#193] Whether the original managed halftime replacement
(fresh Pearce2582→Gale2592 case, [T74](halftime-replacement.md)) survives
match completion, saving and reloading decides which persisted mutation the
native campaign may commit in [T78](../../.cache/onenil-native/docs/tasks/T78.md)
(onenil#171). This page owns the static reading, the observation plan and the
authenticated answer; measured outputs live in `runs/T80/`.

## The exchange hits the club-record roster

[confirmed: source011a341, static listings] The successful C866 closure
([CA95..CAC4](../static/1-0-exe/code/seg_0AB9_19.asm)) computes both entry
addresses from the club-record far pointer: it loads the managed club
(game[D7D2]+4 → the manager's club byte), scales it by the 62-byte club record
stride (`imul ax,ax,0x3e`) and applies `les di,ptr [0xd7c2]`, the same far
pointer the save writer uses. It then exchanges the selected two-byte roster
entries through `24BC:0203`, the D146/D197 slot accounting, and calls AEB8 for
the scene effects ([T74](halftime-replacement.md)). The match-scene records and
the slot accounting are execution state; the two-byte roster entries live in
the club records.

[confirmed: records/T03/saves.json, tools/data/save.py] The save is the block
sequence of 1B55:091D; block `[DS:D7C2]` (0x2AA0 = 176 clubs × 62 bytes)
stores the club records, and the 15-byte player records `[DS:D7BE]` (0xE5BF)
store condition/instruction/status, while `[DS:D7BA]` (0x7A88) stores the
8-byte club/current/position records. Every byte of the file is placed.

[confirmed: runs/T80/save-projection-r0001.json] The bounded decoded
comparison binds the two: the supplied private save's club-130 twenty roster
words at `[DS:D7C2]+(club−1)×62` equal the T74 halftime projection's roster
exactly (Pearce 2582 in the first team, Gale 2592 in the bench slot before the
exchange, zero-based slots 1 and 11). The halftime exchange therefore mutates
exactly the bytes the save persists. The listing's one-record pointer offset
(`add di,0xffc2` after the club scale) cancels against the one-based slot
addressing; the effective addresses above are established by the decoded
comparison, not by the intermediate register arithmetic. The opponent's
(Blackburn, club 17) match arrangement is execution state — the original's
selection rewrites it per fixture — so only the managed club binds the save
identity.

## The original route from replacement to saved, reloaded roster

[confirmed: manual/watched-match.md W028–W030, manual/saves.md W005–W006] After
`---- FULL TIME ----`, Enter opens the completed bench where CONTINUE has
replaced PLAY GAME. CONTINUE returns to the fulltime pitch; any other key (N)
exits to the final statistics, Space continues to CASH FLOW (Insert would
offer stadium capacity), Space to TRANSFER NEWS, and Space returns to the main
menu with the next management week's fixture displayed. F7 at the main menu
saves the current game to its name without a persistent dialog; a fresh
process lists the `.1-0` saves after Y and Enter loads one. Week processing
between the fixture and the menu is part of this route, so the comparison
must separate the durable roster arrangement from week-processing effects on
availability, condition and finance fields.

## Observation plan

[designed:T80] The observer extends the established T74 procedure with the
W029/W030 route: boot and load the supplied save (scratch copy, never the
owner's release), play the prepared fixture, make the halftime replacement
through the verified highlight-checked selection, resume and wait for full
time, walk the CONTINUE → statistics → cash flow → transfer news route, record
the save-file digest before and after F7, then start a fresh process, load the
saved game and read the reloaded state. Every stage binds a savestate digest,
a decoded-screen digest and the bounded projection (clubs' twenty roster
words, the roster players' position/condition/instruction/status fields,
clock/score/seed and the week header from the save file). No original byte
enters git: records hold digests, counts and decoded values only. A second
independent session must reproduce every decoded comparison.

## Result

Pending the authenticated sessions; this section will state exactly which
persisted mutation the native campaign may commit, and which effects are
scene-local or week-processing output instead.
