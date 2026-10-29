; 1-095.EXE (One-Nil 95), code segment 1B51 (image offsets 1B510..2305F), part 12 of 12
; packed 1-095.EXE sha256 f659fb2d334500d6901fc8d6a0f06c85c0ccda2eb4a3035ae3bb0a0004d79192 (LZEXE 0.91)
; unpacked (tools/static/unlzexe.py) sha256 8df646e017e0965a5d90a58181ca764219ad847833aad0b6cb58fc53372bfb2c
; tool: capstone 5.0.9 (pip package; core library 5.0.1280) (CS_ARCH_X86, CS_MODE_16), recursive descent from the entry point, far calls and near calls/jumps, then routine prologues (55 89 E5 / 55 8B EC / C8 iw 00) in what remains; tools/static/listing.py
; addresses are SEGMENT:OFFSET with SEGMENT the image paragraph before relocation; image offset = SEGMENT*16+OFFSET
; ---- routine 1B51:7B1F  (found by: far)
sub_7B1F:
7B1F  55              push bp
7B20  89 E5           mov bp, sp
7B22  BF F0 7A        mov di, 0x7af0
7B25  0E              push cs
7B26  57              push di
7B27  BF 31 D7        mov di, 0xd731
7B2A  1E              push ds
7B2B  57              push di
7B2C  6A 0C           push 0xc
7B2E  9A 6D 0B B9 26  call far 26B9:0B6D
7B33  9A FA 13 AC 24  call far 24AC:13FA
7B38  08 C0           or al, al
7B3A  74 11           je 0x7b4d
7B3C  BF FA 7A        mov di, 0x7afa
7B3F  0E              push cs
7B40  57              push di
7B41  9A 02 07 AC 24  call far 24AC:0702
7B46  31 C0           xor ax, ax
7B48  9A 16 01 B9 26  call far 26B9:0116
loc_7B4D:
7B4D  C9              leave
7B4E  CB              retf
; data (not reached as code), 1 bytes
7B4F                  db 00   ; .
