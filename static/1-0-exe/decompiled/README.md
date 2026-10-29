# static/1-0-exe/decompiled/

Generated, never edited by hand: `bash tools/static/decompile.sh .cache/One-Nil96/1-0.EXE static/1-0-exe/decompiled` rewrites every file here byte for byte.

- Artifact: `1-0.EXE` of One-Nil 96 (packed sha256 `89ff9c5f238f24e81a0c2440a46cdd8997280a65fc3cc3d97cb974f55280a80a`, LZEXE 0.91), unpacked by `tools/static/unlzexe.py` to sha256 `887ed2a92767950e5309b2052409f875668605939b69e00737aa3047022b9f51` (checked by the tool; the unpacked file is never committed).
- Ghidra 12.1.4 (revision 8b6bbb857accdfa20dc5b2f5dea471178c2e9fbc), JDK 21.0.12.1, run headless with `-max-cpu 2`: the MZ loader, language `x86:LE:16:Real Mode` (compiler spec `default`), Ghidra's default auto-analysis options, the default decompiler options. Scripts: `tools/static/ghidra/OnilSetup.java` (before the analysis), `OnilDecompile.java` (after it); `tools/static/decompiled.py` writes these files.
- One function per routine of `../routines.tsv`, named `f_SSSS_OOOO` after its listing address, near or far by whether it returns with RETF. Ghidra's analysis may add functions; they are named the same way and marked in `index.tsv`.
- Ghidra's output is evidence to check, not truth (CLAUDE.md rule 11): signedness, 16-bit segments, flags and calling conventions are verified against `../code/` before a claim rests on it.

## Addresses

Every heading, function name and label gives the listing address `SEGMENT:OFFSET` of `../code/`. Ghidra holds listing segment k (ascending) at its segment k×0x1000, so that each segment starts on a 64K boundary; at the listing's own segment numbers Ghidra's x86 language computes near call and jump targets wrongly (`OnilSetup.java` says why). Each heading also gives the Ghidra address. The map:

| listing | Ghidra |
| --- | --- |
| 0000 | 0000 |
| 0006 | 1000 |
| 01EF | 2000 |
| 06E8 | 3000 |
| 0AB9 | 4000 |
| 1998 | 5000 |
| 1B55 | 6000 |
| 2316 | 7000 |
| 2317 | 8000 |
| 232A | 9000 |
| 245A | A000 |
| 24BC | B000 |
| 26B8 | C000 |
| 26C9 | D000 |
| 2864 | E000 |

- `DS:9A3E` is offset 9A3E of the data segment 2864 (Ghidra's `DAT_e000_9a3e`, or `_DAT_e000_9a3e` for a wider access over smaller symbols).
- A segment number written in the code (a pushed segment, a far pointer's segment) is Ghidra's, from the table above: `0xe000` is the data segment 2864.
- A data address that Ghidra did not resolve stays a number, often signed: `*(char *)(i + -0x7f10)` is `DS:80F0 + i`.
- `ABS_XXXXX` is a physical address outside the program (e.g. `ABS_00449`, the BIOS data area's video mode at 0040:0049).

## Counts

- Routines of `routines.tsv`: 940; decompiled 937, failed 3, no function 0.
- Functions Ghidra's analysis added (not in `routines.tsv`): 6: `0006:0000`, `26C9:010F`, `26C9:031C`, `26C9:0323`, `26C9:0579`, `26C9:1174`.
- Not decompiled:
  - `0000:0000` (failed): Offset must be between 0x0 and 0x10ffef, got 0xffffffff instead!
  - `0006:0C1E` (failed): Exception while decompiling 1000:0c1e: ghidra.program.model.address.AddressOutOfBoundsException: Offset must be between 0x0 and 0x10ffef, got 0xe0007c7e instead!
  - `0AB9:0B53` (failed): Exception while decompiling 4000:0b53: ghidra.program.model.address.AddressOutOfBoundsException: Offset must be between 0x0 and 0x10ffef, got 0xe0001a1c instead!
- The scripts' own report: ONILSETUP moved 5 bytes back to segment 2316; ONILSETUP segments 15 relocations 2651; ONILSETUP routines 940 functions 940; ONILDECOMPILE functions 946 renamed 6 ok 943 failed 3.

| File | What |
| --- | --- |
| `index.tsv` | per function: listing address, decompiled or not, file and line of its heading, Ghidra address, found in `routines.tsv` or by Ghidra, why it failed |
| `seg_0006_01.c` | code segment 0006, part 1 |
| `seg_0006_02.c` | code segment 0006, part 2 |
| `seg_01EF_01.c` | code segment 01EF, part 1 |
| `seg_01EF_02.c` | code segment 01EF, part 2 |
| `seg_01EF_03.c` | code segment 01EF, part 3 |
| `seg_06E8_01.c` | code segment 06E8, part 1 |
| `seg_06E8_02.c` | code segment 06E8, part 2 |
| `seg_06E8_03.c` | code segment 06E8, part 3 |
| `seg_0AB9_01.c` | code segment 0AB9, part 1 |
| `seg_0AB9_02.c` | code segment 0AB9, part 2 |
| `seg_0AB9_03.c` | code segment 0AB9, part 3 |
| `seg_0AB9_04.c` | code segment 0AB9, part 4 |
| `seg_0AB9_05.c` | code segment 0AB9, part 5 |
| `seg_0AB9_06.c` | code segment 0AB9, part 6 |
| `seg_0AB9_07.c` | code segment 0AB9, part 7 |
| `seg_0AB9_08.c` | code segment 0AB9, part 8 |
| `seg_0AB9_09.c` | code segment 0AB9, part 9 |
| `seg_0AB9_10.c` | code segment 0AB9, part 10 |
| `seg_1998_01.c` | code segment 1998, part 1 |
| `seg_1998_02.c` | code segment 1998, part 2 |
| `seg_1B55_01.c` | code segment 1B55, part 1 |
| `seg_1B55_02.c` | code segment 1B55, part 2 |
| `seg_1B55_03.c` | code segment 1B55, part 3 |
| `seg_1B55_04.c` | code segment 1B55, part 4 |
| `seg_1B55_05.c` | code segment 1B55, part 5 |
| `seg_2316_01.c` | code segment 2316, part 1 |
| `seg_2317_01.c` | code segment 2317, part 1 |
| `seg_232A_01.c` | code segment 232A, part 1 |
| `seg_245A_01.c` | code segment 245A, part 1 |
| `seg_24BC_01.c` | code segment 24BC, part 1 |
| `seg_24BC_02.c` | code segment 24BC, part 2 |
| `seg_26B8_01.c` | code segment 26B8, part 1 |
| `seg_26C9_01.c` | code segment 26C9, part 1 |
| `seg_26C9_02.c` | code segment 26C9, part 2 |
