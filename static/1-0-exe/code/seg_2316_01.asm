; 1-0.EXE (One-Nil 96), code segment 2316 (image offsets 23160..2316F), part 1 of 1
; packed 1-0.EXE sha256 89ff9c5f238f24e81a0c2440a46cdd8997280a65fc3cc3d97cb974f55280a80a (LZEXE 0.91)
; unpacked (tools/static/unlzexe.py) sha256 887ed2a92767950e5309b2052409f875668605939b69e00737aa3047022b9f51
; tool: capstone 5.0.9 (pip package; core library 5.0.1280) (CS_ARCH_X86, CS_MODE_16), recursive descent from the entry point, far calls and near calls/jumps, then routine prologues (55 89 E5 / 55 8B EC / C8 iw 00) in what remains; tools/static/listing.py
; addresses are SEGMENT:OFFSET with SEGMENT the image paragraph before relocation; image offset = SEGMENT*16+OFFSET

; ---- routine 2316:0000  (found by: far)
sub_0000:
0000  55              push bp
0001  89 E5           mov bp, sp
0003  C9              leave
0004  CB              retf
; data (not reached as code), 11 bytes
0005                  db 00 00 00 00 00 00 00 00 00 00 00   ; ...........
