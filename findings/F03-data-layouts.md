# F03 The data files: a league file is 19 blocks and 3920 byte pairs read in a fixed order, the font is a 256-glyph 8x16 VGA font, the game uses 16 of the palette's 256 entries, and a save is 28 blocks including the RNG seed

- **Status**: proposed
- **Task**: T03 (#4)
- **Editions**: the code cited is 1-0.EXE (96); the league files are identical in both editions
  (F01 item 7), and the save routine `1B55:091D` and its helper `08D9` are the same in 95
  (static/delta-95-96.tsv: `same`).
- **Records**: `records/T03/leagues.json` (`tools/data/league.py`), `records/T03/saves.json`
  (`tools/data/save.py`), committed at `80bad2d` and `419b688`; the code is cited from
  `static/1-0-exe/` (T02, F02).
- **Method**: the layouts are the game's own read and write sequences, read in the listing; the
  bytes confirm them: each sequence accounts for every byte of every file, to the byte. Fields are
  named by their place (the destination in 1-0.EXE) except where the bytes are text; no claim says
  what a number does in play.

## League files

1. `[confirmed]` The loader `1B55:0730` (called from the start-up, `1B55:0CF2`) opens the file whose
   name `1B55:013C` builds and reads it with 19 calls of `232A:1208` (→ `24BC:11E1`: `Dos.MsDos` with
   AH=3Fh, the handle at `DS:DF04`, the count and the buffer), then a loop `k = 1..3920` of two
   one-byte reads. The fourth block is a word N that sets the size of the twelfth (N+1 bytes). For
   ENGL-94 (66,924 bytes, N = 26,042), ENGL-95 (66,954, 26,072), SCOT-94 (66,976, 26,094) and ITAL-94
   (68,472, 27,590) the sequence ends exactly at the file's end (`league.py --check .cache`).
2. `[confirmed]` The fields, in file order (ENGL-94 offsets; the others shift by N after R12):

| R | Offset (ENGL-94) | Size | Destination | Field |
| --- | --- | --- | --- | --- |
| R01 | 0 | 1 | `DS:DCD8` | `header_byte_0`: the league file's first byte; ENGL 9, SCOT 25, ITAL 16; the save's first byte too (DS:DCD8) |
| R02 | 1 | 2 | `DS:DCDA` | `header_year`: the season's year: 1994 or 1995 |
| R03 | 3 | 1 | `DS:DCE0` | `header_byte_3`: a byte: 3 (ENGL-94, SCOT-94) or 2 (ENGL-95, ITAL-94) |
| R04 | 4 | 2 | `DS:D790` | `header_pool_size`: N, the size of the player-name pool less one: the loader reads N+1 pool bytes and allocates them (24BC:1485) |
| R05 | 6 | 112 | `DS:DCE6` | `division_names`: 7 Pascal strings of 16 bytes (string[15]): "SUPER LEAGUE", "PREMIER LEAGUE", ... "EUROPEAN" (ITAL: "SUPERLEGA", "SERIE A", ...) |
| R06 | 118 | 2816 | `[DS:D7B2]` | `club_names`: 176 string[15]: the clubs ("Barcelona", ..., "Norwich City", ...) |
| R07 | 2934 | 176 | `[DS:D7B6]` | `club_block_a`: 176 bytes, one per club |
| R08 | 3110 | 176 | `DS:D7D6` | `club_block_b`: 176 bytes, one per club; in each file a permutation of 1..176 |
| R09 | 3286 | 1001 | `[DS:DCD4]` | `block_1001_a`: 1001 bytes, entry 0 = 0 |
| R10 | 4287 | 11011 | `[DS:DCCC]` | `names_1001`: 1001 string[10]; entry 0 empty, then surnames ("Cruyff", "Quieros", ...) |
| R11 | 15298 | 1001 | `[DS:DCD0]` | `block_1001_b`: 1001 bytes, entry 0 = 0 |
| R12 | 16299 | N+1 | `[DS:D7A2]` | `player_name_pool`: N+1 bytes: byte 0 = 0, then the 3920 players' surnames concatenated without lengths; the last byte is in no name |
| R13 | 42342 | 7844 | `[DS:D7A6]` | `player_name_offsets`: 3922 words, 0 then rising to N: player k (1..3920) is pool[w[k] .. w[k+1]-1] |
| R14 | 50186 | 3921 | `[DS:D7AA]` | `player_block_a`: 3921 bytes, one per player with entry 0 |
| R15 | 54107 | 3921 | `[DS:D7AE]` | `player_block_b`: 3921 bytes, one per player with entry 0 |
| R16 | 58028 | 176 | `DS:D886` | `club_block_c`: 176 bytes, one per club |
| R17 | 58204 | 176 | `DS:D936` | `club_block_d`: 176 bytes, one per club |
| R18 | 58380 | 528 | `DS:DA96` | `club_block_528`: 528 bytes: 3 per club |
| R19 | 58908 | 176 | `DS:D9E6` | `club_block_e`: 176 bytes, one per club |
| R20 | 59084 | 7840 | `[DS:D7BA]+8k+1, +8k+3` | `player_pairs`: 3920 pairs of bytes: player k's bytes +1 and +3 of its 8-byte record at [DS:D7BA] + 8k |

3. `[confirmed]` Every file has 7 division names, 176 club names, 1001 entries of `names_1001` and
   3920 player names (leagues.json). Pascal strings carry text left over after their length in the
   padding of some entries (`padding_residue`: club names 171–416 bytes, `names_1001` 643–775
   bytes per file); the game reads only the length's worth.
4. `[derived]` Players are numbered 1..3920 (the pool, the pairs) and arrays of 3921 bytes keep an
   entry 0; clubs are 176; `names_1001` and its two companion blocks have an unused entry 0 and
   1000 entries.

## Font and palette

| R | File | Field |
| --- | --- | --- |
| R21 | `1-0.TFN` | `[confirmed]` 4096 bytes read whole by `232A:0008` (`232A:1284(0x1000, …)`), then `Intr($10)` with AX=1100h, BH=16, BL=0, CX=256, DX=0, ES:BP = the buffer (232A:0022–004F): 256 glyphs of 16 one-byte rows, characters 0..255, loaded as the text-mode font of block 0. 77 glyphs differ between 95 and 96 (records/T01/diff-95-96.json). |
| R22 | `1-0.PAL` | `[confirmed]` 768 bytes read whole by `232A:005E`; `24BC:1AD5` is given the buffer **plus 3** (`lea di,[bp-0x2FD]`, 232A:0078) and calls `Intr($10)` with AX=1012h, BX=0, CX=16 (24BC:1AD9–1AFF): file entries 1..16 (bytes 3..50) become DAC registers 0..15. |
| R23 | `1-0.PAL` | `[derived]` Bytes 0..2 and 51..767 (entry 0 and entries 17..255) are never used by 1-0.EXE: `232A:005E` is the only reader of `1-0.pal`. Every byte is ≤ 63 (6-bit DAC values, F01's inventory). |

5. `[derived]` The game runs in VGA text mode with its own font: a screen read (T04) reads the text
   page and the glyphs are this font's, not the BIOS's.

## The saved game

6. `[confirmed]` `1B55:091D` writes or reads a save (by the flag at `[bp+4]` of its helper
   `1B55:08D9`: write `232A:11E3`, read `232A:1208`) as 28 blocks in this order. Their sizes, from the
   listing (`push` before each `call 0x8d9`), sum to 194,426 bytes, the size of both `SAVE1.1-0`
   (`save.py --check .cache`).

| R | Offset | Size | Destination | Shape | Also in the league file | 95 = 96 |
| --- | --- | --- | --- | --- | --- | --- |
| R24 | 0 | 1 | `DS:DCD8` |  | yes | same |
| R25 | 1 | 2 | `DS:DCDA` |  | yes | differs |
| R26 | 3 | 31368 | `[DS:D7BA]` | 3921 players x 8 bytes |  | differs |
| R27 | 31371 | 58815 | `[DS:D7BE]` | 3921 players x 15 bytes |  | differs |
| R28 | 90186 | 10912 | `[DS:D7C2]` | 176 clubs x 62 bytes |  | differs |
| R29 | 101098 | 2112 | `[DS:D7C6]` | 176 clubs x 12 bytes |  | same |
| R30 | 103210 | 30624 | `[DS:D7CA]` | 176 clubs x 174 bytes |  | differs |
| R31 | 133834 | 10208 | `[DS:D7CE]` | 176 clubs x 58 bytes |  | same |
| R32 | 144042 | 247 | `[DS:D7D2]` |  (game state; byte 0 the week, F02) |  | differs |
| R33 | 144289 | 176 | `DS:D7D6` |  | yes | differs |
| R34 | 144465 | 8 | `DS:DCA6` |  |  | same |
| R35 | 144473 | 8 | `DS:DCAE` |  |  | same |
| R36 | 144481 | 96 | `[DS:DCB6]` |  |  | same |
| R37 | 144577 | 2 | `DS:DCBA` |  |  | differs |
| R38 | 144579 | 2 | `[DS:DE84]` |  (the RNG seed word, F02 item 4) |  | same |
| R39 | 144581 | 1770 | `[DS:DCBC]` |  |  | same |
| R40 | 146351 | 8096 | `[DS:DCC0]` | 176 clubs x 46 bytes |  | same |
| R41 | 154447 | 188 | `[DS:DCC4]` |  |  | differs |
| R42 | 154635 | 4004 | `[DS:DCC8]` | 1001 names_1001 x 4 bytes |  | differs |
| R43 | 158639 | 1001 | `[DS:DCD4]` |  | yes | differs |
| R44 | 159640 | 11011 | `[DS:DCCC]` | 1001 names_1001 x 11 bytes | yes | differs |
| R45 | 170651 | 1001 | `[DS:DCD0]` |  | yes | differs |
| R46 | 171652 | 3921 | `[DS:D7AA]` |  | yes | differs |
| R47 | 175573 | 176 | `DS:D936` |  | yes | differs |
| R48 | 175749 | 176 | `DS:D9E6` |  | yes | differs |
| R49 | 175925 | 464 | `[DS:DCDC]` |  |  | same |
| R50 | 176389 | 1 | `DS:DCE0` |  | yes | differs |
| R51 | 176390 | 18036 | `[DS:DCE2]` |  |  | same |

7. `[confirmed]` Both saves start with byte 9 (ENGL, as the league files' R01) and hold the years
   1994 (95's) and 1995 (96's). Both hold the RNG seed word 23260 (R38).
8. `[derived]` The save is the game's state, and the league file is still needed to load it: the
   save holds 10 of the league file's 19 blocks (the "yes" rows; loading overwrites them) and leaves
   out 9: N, the division and club names, the player-name pool and offsets, and `[DS:D7AE]`,
   `[DS:D7B6]`, `DS:D886`, `DS:DA96`, which come only from the league file (chosen, presumably, by
   R24's byte). The seed word is saved and loaded, so a loaded game continues the
   random stream it was saved with.
9. `[derived]` The record shapes follow from the sizes: 3921 players × 8 bytes at `[DS:D7BA]` (the
   pairs of R20 land in it) and × 15 at `[DS:D7BE]`; 176 clubs × 62 at `[DS:D7C2]` (F02's
   `imul 0x3E`), × 174 at `[DS:D7CA]` (`imul 0xAE`), × 12, × 58 and × 46; `[DS:DCC8]` is 1001 × 4
   only by its size. A shape is a division, not a reading.

## Open

- What each numeric field means (the next reading tasks, by the code that uses each destination).
- Why both saves hold the same seed word (23260) though they are different games.
- Whether the attribute controller maps the 16 text colours onto DAC 0..15 (the BIOS default does
  not: colours 6 and 8..15 use DAC 20 and 56..63), which decides what the palette changes on screen.
