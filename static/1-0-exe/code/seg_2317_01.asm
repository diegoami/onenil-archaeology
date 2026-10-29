; 1-0.EXE (One-Nil 96), code segment 2317 (image offsets 23170..2329F), part 1 of 1
; packed 1-0.EXE sha256 89ff9c5f238f24e81a0c2440a46cdd8997280a65fc3cc3d97cb974f55280a80a (LZEXE 0.91)
; unpacked (tools/static/unlzexe.py) sha256 887ed2a92767950e5309b2052409f875668605939b69e00737aa3047022b9f51
; tool: capstone 5.0.9 (pip package; core library 5.0.1280) (CS_ARCH_X86, CS_MODE_16), recursive descent from the entry point, far calls and near calls/jumps, then routine prologues (55 89 E5 / 55 8B EC / C8 iw 00) in what remains; tools/static/listing.py
; addresses are SEGMENT:OFFSET with SEGMENT the image paragraph before relocation; image offset = SEGMENT*16+OFFSET

; ---- routine 2317:0000  (found by: far)
sub_0000:
0000  55              push bp
0001  89 E5           mov bp, sp
0003  BF A6 D7        mov di, 0xd7a6
0006  1E              push ds
0007  57              push di
0008  68 A4 1E        push 0x1ea4
000B  9A 85 14 BC 24  call far 24BC:1485
0010  BF AA D7        mov di, 0xd7aa
0013  1E              push ds
0014  57              push di
0015  68 51 0F        push 0xf51
0018  9A 85 14 BC 24  call far 24BC:1485
001D  BF AE D7        mov di, 0xd7ae
0020  1E              push ds
0021  57              push di
0022  68 51 0F        push 0xf51
0025  9A 85 14 BC 24  call far 24BC:1485
002A  BF B2 D7        mov di, 0xd7b2
002D  1E              push ds
002E  57              push di
002F  68 00 0B        push 0xb00
0032  9A 85 14 BC 24  call far 24BC:1485
0037  BF B6 D7        mov di, 0xd7b6
003A  1E              push ds
003B  57              push di
003C  68 B0 00        push 0xb0
003F  9A 85 14 BC 24  call far 24BC:1485
0044  BF BA D7        mov di, 0xd7ba
0047  1E              push ds
0048  57              push di
0049  68 88 7A        push 0x7a88
004C  9A 85 14 BC 24  call far 24BC:1485
0051  BF BE D7        mov di, 0xd7be
0054  1E              push ds
0055  57              push di
0056  68 BF E5        push 0xe5bf
0059  9A 85 14 BC 24  call far 24BC:1485
005E  BF C2 D7        mov di, 0xd7c2
0061  1E              push ds
0062  57              push di
0063  68 A0 2A        push 0x2aa0
0066  9A 85 14 BC 24  call far 24BC:1485
006B  BF C6 D7        mov di, 0xd7c6
006E  1E              push ds
006F  57              push di
0070  68 40 08        push 0x840
0073  9A 85 14 BC 24  call far 24BC:1485
0078  BF CA D7        mov di, 0xd7ca
007B  1E              push ds
007C  57              push di
007D  68 A0 77        push 0x77a0
0080  9A 85 14 BC 24  call far 24BC:1485
0085  BF CE D7        mov di, 0xd7ce
0088  1E              push ds
0089  57              push di
008A  68 E0 27        push 0x27e0
008D  9A 85 14 BC 24  call far 24BC:1485
0092  BF D2 D7        mov di, 0xd7d2
0095  1E              push ds
0096  57              push di
0097  68 F7 00        push 0xf7
009A  9A 85 14 BC 24  call far 24BC:1485
009F  BF B6 DC        mov di, 0xdcb6
00A2  1E              push ds
00A3  57              push di
00A4  6A 60           push 0x60
00A6  9A 85 14 BC 24  call far 24BC:1485
00AB  BF BC DC        mov di, 0xdcbc
00AE  1E              push ds
00AF  57              push di
00B0  68 EA 06        push 0x6ea
00B3  9A 85 14 BC 24  call far 24BC:1485
00B8  BF C0 DC        mov di, 0xdcc0
00BB  1E              push ds
00BC  57              push di
00BD  68 A0 1F        push 0x1fa0
00C0  9A 85 14 BC 24  call far 24BC:1485
00C5  BF C4 DC        mov di, 0xdcc4
00C8  1E              push ds
00C9  57              push di
00CA  68 BC 00        push 0xbc
00CD  9A 85 14 BC 24  call far 24BC:1485
00D2  BF C8 DC        mov di, 0xdcc8
00D5  1E              push ds
00D6  57              push di
00D7  68 A4 0F        push 0xfa4
00DA  9A 85 14 BC 24  call far 24BC:1485
00DF  BF CC DC        mov di, 0xdccc
00E2  1E              push ds
00E3  57              push di
00E4  68 03 2B        push 0x2b03
00E7  9A 85 14 BC 24  call far 24BC:1485
00EC  BF D0 DC        mov di, 0xdcd0
00EF  1E              push ds
00F0  57              push di
00F1  68 E9 03        push 0x3e9
00F4  9A 85 14 BC 24  call far 24BC:1485
00F9  BF D4 DC        mov di, 0xdcd4
00FC  1E              push ds
00FD  57              push di
00FE  68 E9 03        push 0x3e9
0101  9A 85 14 BC 24  call far 24BC:1485
0106  BF DC DC        mov di, 0xdcdc
0109  1E              push ds
010A  57              push di
010B  68 D0 01        push 0x1d0
010E  9A 85 14 BC 24  call far 24BC:1485
0113  BF E2 DC        mov di, 0xdce2
0116  1E              push ds
0117  57              push di
0118  68 74 46        push 0x4674
011B  9A 85 14 BC 24  call far 24BC:1485
0120  C9              leave
0121  CB              retf
; data (not reached as code), 14 bytes
0122                  db 00 00 00 00 00 00 00 00 00 00 00 00 00 00   ; ..............
