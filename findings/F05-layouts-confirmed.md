# F05 After 96 loads SAVE1.1-0, its memory holds ENGL-95.DAT's names and all 28 save blocks byte for byte, as F03 lays them out; byte +0xF2 of the game state is "Watch match"

- **Status**: proposed
- **Task**: T05 (#10)
- **Edition**: 96.
- **Records**: `runs/T05/T05-r0001.json` (code `2b5f3b8`), its savestate sha256 `64af71e7e4d2e1dc…`
  (`.cache/states/T05/`, the owner's Drive `states/T05/`); `T04-load-r0001`'s end savestate
  (F04) for item 4. Method: `runtime/layouts.py`.

## Answer

1. `[confirmed]` 96 was launched, Y answered, the main menu of SAVE1 reached (F04's 3 s wait), and
   one savestate read. 1-0.EXE's data segment is at paragraph 3087 (load segment 0823 + 2864, F02;
   its MCB at 0812, named "1-0").
2. `[confirmed]` **League layout (F03 R05, R06).** The 7 division names at `DS:DCE6` and the 176
   club names at the far pointer `[DS:D7B2]`, decoded as `string[15]`s, equal those of
   `ENGL-95.DAT` and of no other league file. Club names are not in the save (F03 item 8), so they
   came from the league file through the loader `1B55:0730`, as F03 reads it.
3. `[confirmed]` **Save layout (F03 R24–R51).** For each of the 28 blocks, the sha256 of the
   memory at its destination (a `DS:` offset, or the far pointer stored at one) equals the
   block's sha256 in SAVE1.1-0 (records/T03/saves.json): 28 of 28. Among them the seed word at
   `[DS:DE84]`, which points to `DS:A51C` (F02 item 4's RandSeed).
4. `[confirmed]` In T04's load runs, which turned "Watch match" off before their last savestate,
   27 of 28 blocks are equal; the one that differs is `[DS:D7D2]` (the game state), in one byte:
   +0xF2 (242), 1 in T05's savestate, 0 after the toggle. `[derived]` +0xF2 holds "Watch match";
   the loader's `24BC:0222(1, 5, [DS:D7D2] + 0xF2)` (F03, `1B55:0730`) sets five bytes from +0xF2 to
   1, so the five on/off options of Game configuration (Watch match, Sacking, Auto save game,
   Friendlies, Auto player select, F04) are likely +0xF2…+0xF6, on by default for a new game; only
   +0xF2 is shown.
5. `[derived]` O-M1's exit check is met: a league-file claim (R05, R06) and the save's layout
   (R24–R51) are confirmed by a run of the original. Which league file a save uses is chosen by
   something not yet read: SAVE1 holds the year 1995 and byte 9 (F03 item 7), and ENGL-95 was loaded.
