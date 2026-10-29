; 1-095.EXE (One-Nil 95), code segment 2306 (image offsets 23060..2306F), part 1 of 1
; packed 1-095.EXE sha256 f659fb2d334500d6901fc8d6a0f06c85c0ccda2eb4a3035ae3bb0a0004d79192 (LZEXE 0.91)
; unpacked (tools/static/unlzexe.py) sha256 8df646e017e0965a5d90a58181ca764219ad847833aad0b6cb58fc53372bfb2c
; tool: capstone 5.0.9 (pip package; core library 5.0.1280) (CS_ARCH_X86, CS_MODE_16), recursive descent from the entry point, far calls and near calls/jumps, then routine prologues (55 89 E5 / 55 8B EC / C8 iw 00) in what remains; tools/static/listing.py
; addresses are SEGMENT:OFFSET with SEGMENT the image paragraph before relocation; image offset = SEGMENT*16+OFFSET

; ---- routine 2306:0000  (found by: far)
sub_0000:
0000  55              push bp
0001  89 E5           mov bp, sp
0003  C9              leave
0004  CB              retf
; data (not reached as code), 11 bytes
0005                  db 00 00 00 00 00 00 00 00 00 00 00   ; ...........
