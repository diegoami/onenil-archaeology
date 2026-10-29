# F02 Both executables listed and indexed: the match is 299 routines under 0AB9:E1F2, the RNG is the studio's LCG on RandSeed, 95 and 96 differ in five routines, and 96's limited-build texts are switched off

- **Status**: proposed
- **Task**: T02 (#3)
- **Editions**: 96 (`1-0.EXE`) unless a claim names 95.
- **Sources**: `static/1-0-exe/` and `static/1-095-exe/` (listings by `tools/static/listing.py`,
  capstone 5.0.9), `static/delta-95-96.tsv` (`tools/static/delta.py`), `static/areas.tsv` and
  `static/*/index.tsv` (`tools/static/index.py`), `static/goal2-match.tsv`
  (`tools/static/goal2_match.py`, against goal2-archaeology's annotations at 774473eb),
  `static/1-0-exe/decompiled/` (Ghidra 12.1.4, `tools/static/decompile.sh`). All are regenerated
  byte for byte from the owner's files (`bash tools/static/regenerate.sh`; the decompile by its own
  script). Packed sha256: 96 `89ff9c5f…`, 95 `f659fb2d…` (records/T01/inventory.json).
- **Addresses**: `SEG:OFF` of the listing (image paragraph before relocation).

## The listing

1. `[confirmed]` 96 has 940 routines and 95 has 939 (routines.tsv), found by recursive descent from
   the entry point and far calls, then by prologues (`push bp; mov bp,sp` or `ENTER n,0`) in what
   remains: only 16 routines rest on a prologue alone. 159,604 of 165,440 code-segment bytes of 96
   decode as code (README).
2. `[confirmed]` The Ghidra decompile of 96 covers 937 of 940 routines (and 6 functions Ghidra adds);
   `0000:0000`, `0006:0C1E` and `0AB9:0B53` fail on an address Ghidra cannot place (the data
   segment, 2864, held as E000). A second run is byte-identical.

## The units

3. `[confirmed]` The 15 segments of 96 (95: the same order, F01 item 8), with what places each:

   | Segment | Unit | Evidence |
   | --- | --- | --- |
   | 0000 | the main program | the entry: unit inits, then 1B55:7BDE, 1B55:0CF2 |
   | 0006, 01EF, 06E8, 1B55 | game units: season and career, transfers and staff, finance, save-load and competitions | their strings and anchors (areas.tsv) |
   | 0AB9 | the match, the squad, tactics and contract screens | match entry 0AB9:E1F2 (item 5) |
   | 1998 | match helpers without strings | 1998:00D6 sets `[DS:D088]` and loops until a key (24BC:0C58) or until that word is 0, unless byte +2 of `[DS:D7D2]` is 0; 1998:1B99 tests whether either club is managed |
   | 2316, 2317 | small units: an empty init; an init storing far pointers | their code |
   | 232A | the game's helpers | loads `1-0.tfn` (232A:0008), `1-0.pal` (232A:005E); Y/N; random(n) 232A:076D |
   | 245A | TP7 Crt | F01 item 4 |
   | 24BC | the studio's library ("(c) new era software") | screen, keys, printer, the LCG (item 4) |
   | 26B8 | TP7 Dos | 26B8:0000, 003E, 00A7 byte-equal to goal's FindFirst, FindNext, MsDos (goal2-match.tsv) |
   | 26C9 | TP7 System | F01 item 3; 14 routines byte-equal to goal's System (string, real, print routines) |
   | 2864 | the data segment | loaded by System's init |

   Only 17 routines are byte-equal (masked) to a goal routine: goal used an earlier compiler and no
   `{$G+}` (F01 item 5), so goal2's names carry over only there.

## The random-number generator

4. `[confirmed]` One generator serves the whole program, the one goal used:
   - `24BC:0CDC` steps a 16-bit seed `s := s * 0x7ABD + 0x1B0F` (mod 2^16) and returns
     `((s * n) >> 16) + 1`, a value 1..n (`mul bx`, `add ax,1B0F`, `mul [bp+6]`, `inc dx`).
   - Its seed is the word at the far pointer `[DS:DE84]`, set by the library's init to `DS:A51C`
     (`24BC:1F1F`–`1F27`), which is System's `RandSeed`; `Randomize` (`26C9:181A`, INT 21h AH=2Ch)
     is called right after, so at start the seed is the DOS time's CX (hour*256 + minute).
   - Callers: `24BC:0D01` random(n) (wrapped by `232A:076D`, 153 call sites), `24BC:0D1C`
     (random(n) = 1: 31 sites), `24BC:0D3F` (a coin flip: 38 sites). TP's own `Random` is not
     linked (its factor 08088405h appears nowhere in the image).
   - The seed is written directly in four places: `0AB9:19CA`, `1B55:091D`, `1B55:5516`, `1B55:56E7`
     (datarefs.tsv, `DS:DE84`).
   - `[derived]` A model of the game needs this generator, the order of its draws, and those four
     seed writes. No other generator was found (TP's Random is absent; the constants 7ABD/1B0F occur
     once), but no exhaustive search for another was made.

## The match

5. `[confirmed]` The match is reached as: the weekly loop `0006:1B52` → the week advance `01EF:4D08`
   (increments byte 0 of the record at `[DS:D7D2]`) → the matchday loop `0AB9:EAB6` (for each of
   the `[DS:D686]` fixtures: `0AB9:E479`, then `1998:1B99`) → `0AB9:E1F2`, the only caller of
   `0AB9:19CA`. E1F2 calls 19CA, the 1998 helpers 00BA/00CD/045C/0C7A, and the result screens
   (`0AB9:E008` → the commentary print `0AB9:0577` and the penalty shoot-out `0AB9:8434`).
6. `[confirmed]` `0AB9:19CA` seeds the match: `RandSeed` low word := `b0 + 58*b1` of the record at
   `[DS:D7D2]` (19D3–19ED), then fills the 255 bytes `DS:CF72`–`D070` (`[di-0x308F]`, di 1..255)
   with random(16) − 1. `[derived]` The record at `[DS:D7D2]` holds the week (byte 0, item 5), so a
   week's match draws start from a seed fixed by that record, not by the clock: a match replays
   from the same game state. A run decides this (T04/T05).
7. `[confirmed]` The match's slot tests are goal's: `0AB9:1CBB` tests a player record's slot (+7)
   `< 12` (the side), `0AB9:0000` tests slot 1 or 12 (a goalkeeper). The commentary is a table of
   `string[20]` at `DS:0382 + 0x15*k` ("makes a pass", "tackle by", …), read at `0AB9:0403` and
   `0AB9:09E8`.
8. `[derived]` 299 routines of 96 are `match` in the index: 13 anchored, the rest because every
   caller, or every nearest classified ancestor through call cycles, is match (index.py's `callers`
   and `roots`; a routine reached only from match code can still be shared). 263 of them are
   identical in 95, 30 moved, 1 differs only in operands, 5 changed (item 10).

## The index

9. `[confirmed]` Every routine of both executables is in `static/*/index.tsv` with an area
   (`python3 tools/static/check_index.py`): 96 has 729 classified and 211 `unknown` (mostly in 1B55
   and 06E8); program 12, runtime 111, library 135, match 299, tactics 4, squad 16, transfers 21,
   staff 6, finance 7, competitions 8, season 88, career 2, save-load 20. 95's index is 96's through
   the delta pairs.

## 95 → 96

10. `[confirmed]` By routine (delta-95-96.tsv): 746 same, 151 moved, 37 differ only in operands or
    in the constants stored after their code, 5 changed, 1 new. The changed and new:

    | 96 | 95 | What changed |
    | --- | --- | --- |
    | 0000:0000 | 0000:0000 | the main program: one more unit init call (0006:1E82) |
    | 0006:1E82 | — | new: an empty unit init (F01 item 10) |
    | 0AB9:C4CD | 0AB5:C4CD | a squad screen: when clearing entries 4..6 under the flag `DS:0D18`, 96 skips entry 5 |
    | 1B55:0CF2 | 1B51:0CBB | the start-up "load a saved game?" question: the limited-build test (item 11) |
    | 1B55:0DE2 | 1B51:0D48 | the save loop: the same logic, compiled with its result stored first |
    | 1B55:56E7 | 1B51:5647 | a record setup that also writes the seed (item 4): 96 adds a branch setting byte +3 of a record to `0xB0 − [DS:D78F] + 0x50` when it is 0 |

    `[derived]` No match routine's instructions changed except through operands: the match engine
    is the same in both editions.

## The limited build (corrects F01 item 9)

11. `[confirmed]` In 96, `1B55:0CF2` asks "Do you want to load a saved game" (`232A:06E5`), then
    computes `0 and answer` with a literal (`mov al,0; or al,al; je`, 0D26–0D2A) and passes it with
    "To load a saved game you must purchase the full version" to `232A:0098`, which shows the
    message and returns true only when that flag is true (232A:00BE–00C9). The flag is always 0, so
    the message never shows and a "yes" goes on to the load loop (`1B55:0C3A(1,1)`). Ghidra's
    decompile reads the same (`f_1B55_0CF2`: the flag's low byte is 0).
12. `[confirmed]` No code of 96 references "TO CONTINUE PLAYING YOU MUST REGISTER THIS GAME" (a
    Pascal string at `01EF:4C86`, after the code of `01EF:4ACD`; F01's `01EF:4CA4` is the word
    "REGISTER" in it) or "Game saved: to load a game you must purchase the full version"
    (`1B55:0DA4`): no `mov di` or other load of either offset is in the listing, and the bytes `86 4C`
    occur once in the image, inside another instruction (1B55:4269). 95 has neither text; its
    `01EE:4E4E` loads `0x4C86`, which in 95 is "Do you want to save the full seasonal information".
13. `[derived]` The limited-build texts are behind a compile-time switch that is off in this build:
    the load test is compiled with the constant false, and the code that would show the other two
    messages was left out while their literals remain. So 96 loads saved games and has no
    registration stop. F01 item 9's derivation is wrong; a run of 96 loading `SAVE1.1-0` decides it
    (rule 12).

## Open

- What the area `unknown` routines (211) do; which match routines are the engine's loop and its
  contests (the next reading of 0AB9, O-M3a).
- The fields of the record at `[DS:D7D2]` beyond byte 0, and what `1B55:5516` / `1B55:56E7` seed.
- Item 6 and item 13 need a run.
