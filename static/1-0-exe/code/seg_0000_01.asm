; 1-0.EXE (One-Nil 96), code segment 0000 (image offsets 00000..0005F), part 1 of 1
; packed 1-0.EXE sha256 89ff9c5f238f24e81a0c2440a46cdd8997280a65fc3cc3d97cb974f55280a80a (LZEXE 0.91)
; unpacked (tools/static/unlzexe.py) sha256 887ed2a92767950e5309b2052409f875668605939b69e00737aa3047022b9f51
; tool: capstone 5.0.9 (pip package; core library 5.0.1280) (CS_ARCH_X86, CS_MODE_16), recursive descent from the entry point, far calls and near calls/jumps, then routine prologues (55 89 E5 / 55 8B EC / C8 iw 00) in what remains; tools/static/listing.py
; addresses are SEGMENT:OFFSET with SEGMENT the image paragraph before relocation; image offset = SEGMENT*16+OFFSET

; ---- routine 0000:0000  (found by: entry)
sub_0000:
0000  9A 00 00 C9 26  call far 26C9:0000
0005  9A EE 1E BC 24  call far 24BC:1EEE
000A  9A 0D 00 5A 24  call far 245A:000D
000F  9A C0 12 2A 23  call far 232A:12C0
0014  9A 00 00 17 23  call far 2317:0000
0019  9A 00 00 16 23  call far 2316:0000
001E  9A DE 7B 55 1B  call far 1B55:7BDE
0023  9A 8F ED B9 0A  call far 0AB9:ED8F
0028  9A 82 1E 06 00  call far 0006:1E82
002D  55              push bp
002E  89 E5           mov bp, sp
0030  9A F2 0C 55 1B  call far 1B55:0CF2
0035  08 C0           or al, al
0037  75 0F           jne 0x48
0039  9A 85 00 2A 23  call far 232A:0085
003E  9A DA 3C EF 01  call far 01EF:3CDA
0043  9A 57 0B 06 00  call far 0006:0B57
loc_0048:
0048  9A 52 1B 06 00  call far 0006:1B52
004D  C9              leave
004E  31 C0           xor ax, ax
0050  9A 16 01 C9 26  call far 26C9:0116
0055  00 00           add byte ptr [bx + si], al
0057  00 00           add byte ptr [bx + si], al
0059  00 00           add byte ptr [bx + si], al
005B  00 00           add byte ptr [bx + si], al
005D  00 00           add byte ptr [bx + si], al
; data (not reached as code), 1 bytes
005F                  db 00   ; .
