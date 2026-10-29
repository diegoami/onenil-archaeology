# static/1-095-exe/

Generated, never edited by hand: `python3 tools/static/listing.py .cache/<edition>/1-095.EXE static/1-095-exe` (or
`bash tools/static/regenerate.sh`) rewrites every file here byte for byte (CLAUDE.md rule 14's exception).

- Artifact: `1-095.EXE` of One-Nil 95, packed sha256 `f659fb2d334500d6901fc8d6a0f06c85c0ccda2eb4a3035ae3bb0a0004d79192` (LZEXE 0.91; records/T01/inventory.json).
- Unpacked by `tools/static/unlzexe.py`: sha256 `8df646e017e0965a5d90a58181ca764219ad847833aad0b6cb58fc53372bfb2c`, 218224 bytes (the unpacked file is never committed).
- Tool: capstone 5.0.9 (pip package; core library 5.0.1280) (CS_ARCH_X86, CS_MODE_16), recursive descent from the entry point, far calls and near calls/jumps, then routine prologues (55 89 E5 / 55 8B EC / C8 iw 00) in what remains; tools/static/listing.py.
- Image: 207472 bytes of load module (2649 relocations). Entry point 0000:0000, stack 380C:4000.  Data segment 2854.
- Addresses are `SEGMENT:OFFSET` where SEGMENT is the paragraph in the image before relocation (what the file holds);
  the image offset is `SEGMENT*16 + OFFSET`; the unpacked file's offset is that plus its header size (10752 bytes).
  A relocated segment word in an instruction is shown by its unrelocated value.
- 61397 instructions decoded; 159506 of 165184 code-segment bytes are code. The rest is reported as `data`.

| File | What |
| --- | --- |
| `code/seg_0000_01.asm` | code segment 0000 (image 00000..0004F) |
| `code/seg_0005_01.asm` | code segment 0005 (image 00050..01EDF) |
| `code/seg_0005_02.asm` | code segment 0005 (image 00050..01EDF) |
| `code/seg_0005_03.asm` | code segment 0005 (image 00050..01EDF) |
| `code/seg_01EE_01.asm` | code segment 01EE (image 01EE0..06E3F) |
| `code/seg_01EE_02.asm` | code segment 01EE (image 01EE0..06E3F) |
| `code/seg_01EE_03.asm` | code segment 01EE (image 01EE0..06E3F) |
| `code/seg_01EE_04.asm` | code segment 01EE (image 01EE0..06E3F) |
| `code/seg_01EE_05.asm` | code segment 01EE (image 01EE0..06E3F) |
| `code/seg_01EE_06.asm` | code segment 01EE (image 01EE0..06E3F) |
| `code/seg_01EE_07.asm` | code segment 01EE (image 01EE0..06E3F) |
| `code/seg_06E4_01.asm` | code segment 06E4 (image 06E40..0AB4F) |
| `code/seg_06E4_02.asm` | code segment 06E4 (image 06E40..0AB4F) |
| `code/seg_06E4_03.asm` | code segment 06E4 (image 06E40..0AB4F) |
| `code/seg_06E4_04.asm` | code segment 06E4 (image 06E40..0AB4F) |
| `code/seg_06E4_05.asm` | code segment 06E4 (image 06E40..0AB4F) |
| `code/seg_06E4_06.asm` | code segment 06E4 (image 06E40..0AB4F) |
| `code/seg_0AB5_01.asm` | code segment 0AB5 (image 0AB50..1993F) |
| `code/seg_0AB5_02.asm` | code segment 0AB5 (image 0AB50..1993F) |
| `code/seg_0AB5_03.asm` | code segment 0AB5 (image 0AB50..1993F) |
| `code/seg_0AB5_04.asm` | code segment 0AB5 (image 0AB50..1993F) |
| `code/seg_0AB5_05.asm` | code segment 0AB5 (image 0AB50..1993F) |
| `code/seg_0AB5_06.asm` | code segment 0AB5 (image 0AB50..1993F) |
| `code/seg_0AB5_07.asm` | code segment 0AB5 (image 0AB50..1993F) |
| `code/seg_0AB5_08.asm` | code segment 0AB5 (image 0AB50..1993F) |
| `code/seg_0AB5_09.asm` | code segment 0AB5 (image 0AB50..1993F) |
| `code/seg_0AB5_10.asm` | code segment 0AB5 (image 0AB50..1993F) |
| `code/seg_0AB5_11.asm` | code segment 0AB5 (image 0AB50..1993F) |
| `code/seg_0AB5_12.asm` | code segment 0AB5 (image 0AB50..1993F) |
| `code/seg_0AB5_13.asm` | code segment 0AB5 (image 0AB50..1993F) |
| `code/seg_0AB5_14.asm` | code segment 0AB5 (image 0AB50..1993F) |
| `code/seg_0AB5_15.asm` | code segment 0AB5 (image 0AB50..1993F) |
| `code/seg_0AB5_16.asm` | code segment 0AB5 (image 0AB50..1993F) |
| `code/seg_0AB5_17.asm` | code segment 0AB5 (image 0AB50..1993F) |
| `code/seg_0AB5_18.asm` | code segment 0AB5 (image 0AB50..1993F) |
| `code/seg_0AB5_19.asm` | code segment 0AB5 (image 0AB50..1993F) |
| `code/seg_0AB5_20.asm` | code segment 0AB5 (image 0AB50..1993F) |
| `code/seg_0AB5_21.asm` | code segment 0AB5 (image 0AB50..1993F) |
| `code/seg_0AB5_22.asm` | code segment 0AB5 (image 0AB50..1993F) |
| `code/seg_1994_01.asm` | code segment 1994 (image 19940..1B50F) |
| `code/seg_1994_02.asm` | code segment 1994 (image 19940..1B50F) |
| `code/seg_1994_03.asm` | code segment 1994 (image 19940..1B50F) |
| `code/seg_1B51_01.asm` | code segment 1B51 (image 1B510..2305F) |
| `code/seg_1B51_02.asm` | code segment 1B51 (image 1B510..2305F) |
| `code/seg_1B51_03.asm` | code segment 1B51 (image 1B510..2305F) |
| `code/seg_1B51_04.asm` | code segment 1B51 (image 1B510..2305F) |
| `code/seg_1B51_05.asm` | code segment 1B51 (image 1B510..2305F) |
| `code/seg_1B51_06.asm` | code segment 1B51 (image 1B510..2305F) |
| `code/seg_1B51_07.asm` | code segment 1B51 (image 1B510..2305F) |
| `code/seg_1B51_08.asm` | code segment 1B51 (image 1B510..2305F) |
| `code/seg_1B51_09.asm` | code segment 1B51 (image 1B510..2305F) |
| `code/seg_1B51_10.asm` | code segment 1B51 (image 1B510..2305F) |
| `code/seg_1B51_11.asm` | code segment 1B51 (image 1B510..2305F) |
| `code/seg_1B51_12.asm` | code segment 1B51 (image 1B510..2305F) |
| `code/seg_2306_01.asm` | code segment 2306 (image 23060..2306F) |
| `code/seg_2307_01.asm` | code segment 2307 (image 23070..2319F) |
| `code/seg_231A_01.asm` | code segment 231A (image 231A0..2449F) |
| `code/seg_231A_02.asm` | code segment 231A (image 231A0..2449F) |
| `code/seg_244A_01.asm` | code segment 244A (image 244A0..24ABF) |
| `code/seg_24AC_01.asm` | code segment 24AC (image 24AC0..26A7F) |
| `code/seg_24AC_02.asm` | code segment 24AC (image 24AC0..26A7F) |
| `code/seg_24AC_03.asm` | code segment 24AC (image 24AC0..26A7F) |
| `code/seg_24AC_04.asm` | code segment 24AC (image 24AC0..26A7F) |
| `code/seg_26A8_01.asm` | code segment 26A8 (image 26A80..26B8F) |
| `code/seg_26B9_01.asm` | code segment 26B9 (image 26B90..2853F) |
| `code/seg_26B9_02.asm` | code segment 26B9 (image 26B90..2853F) |
| `code/seg_26B9_03.asm` | code segment 26B9 (image 26B90..2853F) |
| `data/ds_2854_NN.hex` | the initialised data segment as hex with ASCII |
| `strings.tsv` | ASCII runs and Pascal strings, with addresses |
| `routines.tsv` | every routine found: address, size, callers, INT 21h functions, string and data references |
| `calls.tsv` | call edges: caller routine, callee |
| `datarefs.tsv` | data-segment offsets and the routines that reference them |

Method limits: recursive descent misses code reached only through computed jumps or procedure
variables unless a routine prologue shows it; a prologue pattern found in data can start a false
routine; bytes after the last decoded instruction of a gap are reported as data. A listing line is
capstone's decoding of the bytes, not a claim about the program.
