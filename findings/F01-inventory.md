# F01 The two editions: 30 files, six LZEXE executables built with Turbo Pascal 7 (HELP.EXE with an earlier one), and a 96 executable that is a limited build

- **Status**: proposed
- **Task**: T01 (#2)
- **Editions**: both; each claim says which.
- **Records**: `records/T01/inventory.json`, `records/T01/compiler.json`, `records/T01/diff-95-96.json`,
  written by one run of `python3 tools/inventory.py build` at commit `a775a69` (the tool's code as
  committed there); `tools/static/unlzexe.py` from goal2-archaeology `aefd8d30`.
- **Addresses**: `SEG:OFF` in the unpacked load image before relocation (image offset `SEG*16+OFF`).
  Strings below are quoted from the records (at most 48 characters each).

## Answer

1. `[confirmed]` The owner's folder holds 16 files for 95 and 14 for 96 (inventory.json: name, size,
   sha256, modification time as on the Drive). 95 has `HELP.EXE`, `HELP.PIF`, `INSTALL.PIF`; 96 has
   `ITAL-94.DAT`; the main program is `1-095.EXE` in 95 and `1-0.EXE` in 96.
2. `[confirmed]` Six executables are LZEXE 0.91 (`LZ91` at 0x1C): `1-095.EXE`, `1-0.EXE`, both
   `ALTER.EXE`, `HELP.EXE`, `INSTALL.EXE`. Each unpacks with `tools/static/unlzexe.py` to the size and
   sha256 in inventory.json (`1-095.EXE` 218,224 bytes `8df646e0…`; `1-0.EXE` 218,480 bytes
   `887ed2a9…`); `python3 -m pytest tests/test_unlzexe.py` checks this where `.cache/` holds the files.
3. `[confirmed]` `1-095.EXE`, `1-0.EXE`, both `ALTER.EXE` and `INSTALL.EXE` are Turbo Pascal programs
   with the **Turbo Pascal 7 System run-time**: each entry point is a run of far calls whose first
   goes to System's init (`1-0.EXE`: `26C9:0000`; `1-095.EXE`: `26B9:0000`), which loads DS
   (`2864`/`2854`), saves the 19 vectors `00 02 1B 21 23 24 34–3F 75` (list at `26C9:0239`), runs the
   `Test8086` CPU check (`26C9:00B3`: the pushf/popf test of flag bits 12–15, storing 0, 1 or 2), and
   holds "Runtime error " (`26C9:024C`) and "Portions Copyright (c) 1983,92 Borland" (`26C9:0264`).
   The markers sit at the same offsets of System in all five, though its size differs (6,576 bytes
   in both main programs, 4,576 in `ALTER.EXE`, 4,736 in `INSTALL.EXE`) (compiler.json).
   - `[derived]` Turbo Pascal 7.0 or Borland Pascal 7.0's real-mode target: the copyright year 1992,
     `Test8086` and the saved `21` vector are TP7's; HELP.EXE (item 5) shows the older layout.
     Which of 7.0, 7.01 or BP 7.0 is **not established**: no reference run-time was compared.
4. `[confirmed]` The same five link the **Crt** unit: its init waits for the BIOS tick at
   `0040:006C`, times a loop and divides by 55 (`mov cx,55; div cx`) into the delay count, then hooks
   INT 1Bh (`1-0.EXE` `245A:007B`–`245A:009F`). `[derived]` This is the division that fails with
   runtime error 200 on fast CPUs: a DOSBox-X run (T04) must keep the emulated speed below that.
5. `[confirmed]` `HELP.EXE` (95 only) has an earlier System: 18 saved vectors (`00 02 1B 23 24
   34–3F 75`, no `21`, at `0287:01DD`), no `Test8086`, no Borland copyright string, no ENTER
   prologue, "Runtime error " at `0287:01EF`. goal2's `GOAL.EXE` has "Runtime error " at the same
   offset of its System, and the two System segments share 4,237 of HELP's 4,464 bytes (difflib,
   relocated segment words normalised; checked in this session against goal2's cached GOAL.EXE, not
   recorded). `[derived]` HELP.EXE was built with the compiler goal used, earlier than TP7. Its text
   speaks of "the soccer game": a viewer carried over, not One-Nil-specific.
6. `[confirmed]` The two main programs use 80186 instructions: of the far-called routines, 200
   (95) and 201 (96) start with ENTER, 83 with `push bp; mov bp,sp`; `leave` before `retf` appears
   397 / 398 times. `[derived]` Compiled with `{$G+}`: they need an 80186 or later.

## 95 → 96

7. `[confirmed]` Same in both: `1-0.PAL`, `ENGL-94.DAT`, `ENGL-95.DAT`, `SCOT-94.DAT`, `INSTALL.EXE`.
   Differ: `1-0.TFN` (77 of 256 16-byte glyphs: digits, most letters, some symbols), `ALTER.EXE`,
   `RUN.BAT` (`1-095` → `1-0`), the PIFs, `SAVE1.1-0` (same size, 27,949 bytes differ).
8. `[confirmed]` `1-095.EXE` and `1-0.EXE` have the same 15 segments in the same order. With
   relocated segment words normalised, the last seven segments (`2316`–`26C9` in 96: System, Crt
   and five units that hold the studio's own file, screen and keyboard routines and "(c) new era
   software") are identical; the game's segments `0000`, `0006`, `01EF`, `06E8`,
   `0AB9`, `1998`, `1B55` and the data segment differ, `0AB9` the most (10,455 of 60,912 bytes in
   place); `01EF` grows by 48 bytes and `1B55` by 192 (diff-95-96.json). What changed in the code is
   T02's.
9. `[confirmed]` **The 96 executable is a limited build.** Strings only in `1-0.EXE`:
   "To load a saved game you must purchase the full version" (`1B55:0CD9`), "Game saved: to load a game
   you must purchase the full version" (`1B55:0DC9`) and "TO CONTINUE PLAYING YOU MUST REGISTER THIS
   GAME" (`01EF:4CA4`); 95 has none of them, and no "register" or "purchase" text at all.
   `[derived]` In 96, saving works, loading a saved game is refused, and play stops at some point
   until registered. When, and on what condition, is not established (T02, then a run).
10. `[confirmed]` In 96, the units at `0006` (`1-0.EXE`) and `0007` (`ALTER.EXE`) gained an
    initialization section that is empty (`push bp; mov bp,sp; leave; retf`): one more entry far
    call, no effect. The year string changes from "1992-95 " to "1992-96 " in both programs.

## Open

- The exact compiler version (item 3); the condition of the registration stop (item 9).
- The file times are the Drive copy's; the PIFs and saves date from 2001, and `ENGL-95.DAT`
  (1996-08-06) postdates `1-095.EXE`, so whether 95 reads it is a run question.
