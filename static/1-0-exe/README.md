# static/1-0-exe/

Generated, never edited by hand: `python3 tools/static/listing.py .cache/<edition>/1-0.EXE static/1-0-exe` (or
`bash tools/static/regenerate.sh`) rewrites every file here byte for byte (CLAUDE.md rule 14's exception).

- Artifact: `1-0.EXE` of One-Nil 96, packed sha256 `89ff9c5f238f24e81a0c2440a46cdd8997280a65fc3cc3d97cb974f55280a80a` (LZEXE 0.91; records/T01/inventory.json).
- Unpacked by `tools/static/unlzexe.py`: sha256 `887ed2a92767950e5309b2052409f875668605939b69e00737aa3047022b9f51`, 218480 bytes (the unpacked file is never committed).
- Tool: capstone 5.0.9 (pip package; core library 5.0.1280) (CS_ARCH_X86, CS_MODE_16), recursive descent from the entry point, far calls and near calls/jumps, then routine prologues (55 89 E5 / 55 8B EC / C8 iw 00) in what remains; tools/static/listing.py.
- Image: 207728 bytes of load module (2651 relocations). Entry point 0000:0000, stack 381C:4000.  Data segment 2864.
- Addresses are `SEGMENT:OFFSET` where SEGMENT is the paragraph in the image before relocation (what the file holds);
  the image offset is `SEGMENT*16 + OFFSET`; the unpacked file's offset is that plus its header size (10752 bytes).
  A relocated segment word in an instruction is shown by its unrelocated value.
- 61435 instructions decoded; 159604 of 165440 code-segment bytes are code. The rest is reported as `data`.

| File | What |
| --- | --- |
| `code/seg_0000_01.asm` | code segment 0000 (image 00000..0005F) |
| `code/seg_0006_01.asm` | code segment 0006 (image 00060..01EEF) |
| `code/seg_0006_02.asm` | code segment 0006 (image 00060..01EEF) |
| `code/seg_0006_03.asm` | code segment 0006 (image 00060..01EEF) |
| `code/seg_01EF_01.asm` | code segment 01EF (image 01EF0..06E7F) |
| `code/seg_01EF_02.asm` | code segment 01EF (image 01EF0..06E7F) |
| `code/seg_01EF_03.asm` | code segment 01EF (image 01EF0..06E7F) |
| `code/seg_01EF_04.asm` | code segment 01EF (image 01EF0..06E7F) |
| `code/seg_01EF_05.asm` | code segment 01EF (image 01EF0..06E7F) |
| `code/seg_01EF_06.asm` | code segment 01EF (image 01EF0..06E7F) |
| `code/seg_01EF_07.asm` | code segment 01EF (image 01EF0..06E7F) |
| `code/seg_06E8_01.asm` | code segment 06E8 (image 06E80..0AB8F) |
| `code/seg_06E8_02.asm` | code segment 06E8 (image 06E80..0AB8F) |
| `code/seg_06E8_03.asm` | code segment 06E8 (image 06E80..0AB8F) |
| `code/seg_06E8_04.asm` | code segment 06E8 (image 06E80..0AB8F) |
| `code/seg_06E8_05.asm` | code segment 06E8 (image 06E80..0AB8F) |
| `code/seg_06E8_06.asm` | code segment 06E8 (image 06E80..0AB8F) |
| `code/seg_0AB9_01.asm` | code segment 0AB9 (image 0AB90..1997F) |
| `code/seg_0AB9_02.asm` | code segment 0AB9 (image 0AB90..1997F) |
| `code/seg_0AB9_03.asm` | code segment 0AB9 (image 0AB90..1997F) |
| `code/seg_0AB9_04.asm` | code segment 0AB9 (image 0AB90..1997F) |
| `code/seg_0AB9_05.asm` | code segment 0AB9 (image 0AB90..1997F) |
| `code/seg_0AB9_06.asm` | code segment 0AB9 (image 0AB90..1997F) |
| `code/seg_0AB9_07.asm` | code segment 0AB9 (image 0AB90..1997F) |
| `code/seg_0AB9_08.asm` | code segment 0AB9 (image 0AB90..1997F) |
| `code/seg_0AB9_09.asm` | code segment 0AB9 (image 0AB90..1997F) |
| `code/seg_0AB9_10.asm` | code segment 0AB9 (image 0AB90..1997F) |
| `code/seg_0AB9_11.asm` | code segment 0AB9 (image 0AB90..1997F) |
| `code/seg_0AB9_12.asm` | code segment 0AB9 (image 0AB90..1997F) |
| `code/seg_0AB9_13.asm` | code segment 0AB9 (image 0AB90..1997F) |
| `code/seg_0AB9_14.asm` | code segment 0AB9 (image 0AB90..1997F) |
| `code/seg_0AB9_15.asm` | code segment 0AB9 (image 0AB90..1997F) |
| `code/seg_0AB9_16.asm` | code segment 0AB9 (image 0AB90..1997F) |
| `code/seg_0AB9_17.asm` | code segment 0AB9 (image 0AB90..1997F) |
| `code/seg_0AB9_18.asm` | code segment 0AB9 (image 0AB90..1997F) |
| `code/seg_0AB9_19.asm` | code segment 0AB9 (image 0AB90..1997F) |
| `code/seg_0AB9_20.asm` | code segment 0AB9 (image 0AB90..1997F) |
| `code/seg_0AB9_21.asm` | code segment 0AB9 (image 0AB90..1997F) |
| `code/seg_0AB9_22.asm` | code segment 0AB9 (image 0AB90..1997F) |
| `code/seg_1998_01.asm` | code segment 1998 (image 19980..1B54F) |
| `code/seg_1998_02.asm` | code segment 1998 (image 19980..1B54F) |
| `code/seg_1998_03.asm` | code segment 1998 (image 19980..1B54F) |
| `code/seg_1B55_01.asm` | code segment 1B55 (image 1B550..2315F) |
| `code/seg_1B55_02.asm` | code segment 1B55 (image 1B550..2315F) |
| `code/seg_1B55_03.asm` | code segment 1B55 (image 1B550..2315F) |
| `code/seg_1B55_04.asm` | code segment 1B55 (image 1B550..2315F) |
| `code/seg_1B55_05.asm` | code segment 1B55 (image 1B550..2315F) |
| `code/seg_1B55_06.asm` | code segment 1B55 (image 1B550..2315F) |
| `code/seg_1B55_07.asm` | code segment 1B55 (image 1B550..2315F) |
| `code/seg_1B55_08.asm` | code segment 1B55 (image 1B550..2315F) |
| `code/seg_1B55_09.asm` | code segment 1B55 (image 1B550..2315F) |
| `code/seg_1B55_10.asm` | code segment 1B55 (image 1B550..2315F) |
| `code/seg_1B55_11.asm` | code segment 1B55 (image 1B550..2315F) |
| `code/seg_1B55_12.asm` | code segment 1B55 (image 1B550..2315F) |
| `code/seg_2316_01.asm` | code segment 2316 (image 23160..2316F) |
| `code/seg_2317_01.asm` | code segment 2317 (image 23170..2329F) |
| `code/seg_232A_01.asm` | code segment 232A (image 232A0..2459F) |
| `code/seg_232A_02.asm` | code segment 232A (image 232A0..2459F) |
| `code/seg_245A_01.asm` | code segment 245A (image 245A0..24BBF) |
| `code/seg_24BC_01.asm` | code segment 24BC (image 24BC0..26B7F) |
| `code/seg_24BC_02.asm` | code segment 24BC (image 24BC0..26B7F) |
| `code/seg_24BC_03.asm` | code segment 24BC (image 24BC0..26B7F) |
| `code/seg_24BC_04.asm` | code segment 24BC (image 24BC0..26B7F) |
| `code/seg_26B8_01.asm` | code segment 26B8 (image 26B80..26C8F) |
| `code/seg_26C9_01.asm` | code segment 26C9 (image 26C90..2863F) |
| `code/seg_26C9_02.asm` | code segment 26C9 (image 26C90..2863F) |
| `code/seg_26C9_03.asm` | code segment 26C9 (image 26C90..2863F) |
| `data/ds_2864_NN.hex` | the initialised data segment as hex with ASCII |
| `strings.tsv` | ASCII runs and Pascal strings, with addresses |
| `routines.tsv` | every routine found: address, size, callers, INT 21h functions, string and data references |
| `calls.tsv` | call edges: caller routine, callee |
| `datarefs.tsv` | data-segment offsets and the routines that reference them |

Method limits: recursive descent misses code reached only through computed jumps or procedure
variables unless a routine prologue shows it; a prologue pattern found in data can start a false
routine; bytes after the last decoded instruction of a gap are reported as data. A listing line is
capstone's decoding of the bytes, not a claim about the program.
