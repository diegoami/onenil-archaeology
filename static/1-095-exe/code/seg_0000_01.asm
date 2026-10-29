; 1-095.EXE (One-Nil 95), code segment 0000 (image offsets 00000..0004F), part 1 of 1
; packed 1-095.EXE sha256 f659fb2d334500d6901fc8d6a0f06c85c0ccda2eb4a3035ae3bb0a0004d79192 (LZEXE 0.91)
; unpacked (tools/static/unlzexe.py) sha256 8df646e017e0965a5d90a58181ca764219ad847833aad0b6cb58fc53372bfb2c
; tool: capstone 5.0.9 (pip package; core library 5.0.1280) (CS_ARCH_X86, CS_MODE_16), recursive descent from the entry point, far calls and near calls/jumps, then routine prologues (55 89 E5 / 55 8B EC / C8 iw 00) in what remains; tools/static/listing.py
; addresses are SEGMENT:OFFSET with SEGMENT the image paragraph before relocation; image offset = SEGMENT*16+OFFSET

; ---- routine 0000:0000  (found by: entry)
sub_0000:
0000  9A 00 00 B9 26  call far 26B9:0000
0005  9A EE 1E AC 24  call far 24AC:1EEE
000A  9A 0D 00 4A 24  call far 244A:000D
000F  9A C0 12 1A 23  call far 231A:12C0
0014  9A 00 00 07 23  call far 2307:0000
0019  9A 00 00 06 23  call far 2306:0000
001E  9A 1F 7B 51 1B  call far 1B51:7B1F
0023  9A 89 ED B5 0A  call far 0AB5:ED89
0028  55              push bp
0029  89 E5           mov bp, sp
002B  9A BB 0C 51 1B  call far 1B51:0CBB
0030  08 C0           or al, al
0032  75 0F           jne 0x43
0034  9A 85 00 1A 23  call far 231A:0085
0039  9A DA 3C EE 01  call far 01EE:3CDA
003E  9A 57 0B 05 00  call far 0005:0B57
loc_0043:
0043  9A 52 1B 05 00  call far 0005:1B52
0048  C9              leave
0049  31 C0           xor ax, ax
004B  9A 16 01 B9 26  call far 26B9:0116
