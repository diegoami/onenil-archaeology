; 1-095.EXE (One-Nil 95), code segment 1B51 (image offsets 1B510..2305F), part 2 of 12
; packed 1-095.EXE sha256 f659fb2d334500d6901fc8d6a0f06c85c0ccda2eb4a3035ae3bb0a0004d79192 (LZEXE 0.91)
; unpacked (tools/static/unlzexe.py) sha256 8df646e017e0965a5d90a58181ca764219ad847833aad0b6cb58fc53372bfb2c
; tool: capstone 5.0.9 (pip package; core library 5.0.1280) (CS_ARCH_X86, CS_MODE_16), recursive descent from the entry point, far calls and near calls/jumps, then routine prologues (55 89 E5 / 55 8B EC / C8 iw 00) in what remains; tools/static/listing.py
; addresses are SEGMENT:OFFSET with SEGMENT the image paragraph before relocation; image offset = SEGMENT*16+OFFSET
; ---- routine 1B51:0AE5  (found by: call)
sub_0AE5:
0AE5  C8 00 01 00     enter 0x100, 0
0AE9  BF C6 0E        mov di, 0xec6
0AEC  1E              push ds
0AED  57              push di
0AEE  BF 5C DD        mov di, 0xdd5c
0AF1  1E              push ds
0AF2  57              push di
0AF3  9A 2F 05 1A 23  call far 231A:052F
0AF8  C4 3E 5C DD     les di, ptr [0xdd5c]
0AFC  81 C7 00 0F     add di, 0xf00
0B00  06              push es
0B01  57              push di
0B02  C4 3E 58 DD     les di, ptr [0xdd58]
0B06  81 C7 00 0F     add di, 0xf00
0B0A  06              push es
0B0B  57              push di
0B0C  68 A0 00        push 0xa0
0B0F  9A C2 01 AC 24  call far 24AC:01C2
0B14  8D BE 00 FF     lea di, [bp - 0x100]
0B18  16              push ss
0B19  57              push di
0B1A  BF 31 D7        mov di, 0xd731
0B1D  1E              push ds
0B1E  57              push di
0B1F  6A 01           push 1
0B21  BF DE 0A        mov di, 0xade
0B24  0E              push cs
0B25  57              push di
0B26  BF 31 D7        mov di, 0xd731
0B29  1E              push ds
0B2A  57              push di
0B2B  9A FE 0B B9 26  call far 26B9:0BFE
0B30  48              dec ax
0B31  50              push ax
0B32  9A 91 0B B9 26  call far 26B9:0B91
0B37  BF 3E D7        mov di, 0xd73e
0B3A  1E              push ds
0B3B  57              push di
0B3C  6A 50           push 0x50
0B3E  9A 6D 0B B9 26  call far 26B9:0B6D
0B43  BF 3E D7        mov di, 0xd73e
0B46  1E              push ds
0B47  57              push di
0B48  6A 50           push 0x50
0B4A  6A 24           push 0x24
0B4C  6A 2D           push 0x2d
0B4E  6A 19           push 0x19
0B50  9A 5C 0C 1A 23  call far 231A:0C5C
0B55  8D BE 00 FF     lea di, [bp - 0x100]
0B59  16              push ss
0B5A  57              push di
0B5B  BF 3E D7        mov di, 0xd73e
0B5E  1E              push ds
0B5F  57              push di
0B60  9A 53 0B B9 26  call far 26B9:0B53
0B65  BF E0 0A        mov di, 0xae0
0B68  0E              push cs
0B69  57              push di
0B6A  9A D2 0B B9 26  call far 26B9:0BD2
0B6F  BF EC D6        mov di, 0xd6ec
0B72  1E              push ds
0B73  57              push di
0B74  9A EE 14 AC 24  call far 24AC:14EE
0B79  8D BE 00 FF     lea di, [bp - 0x100]
0B7D  16              push ss
0B7E  57              push di
0B7F  BF EC D6        mov di, 0xd6ec
0B82  1E              push ds
0B83  57              push di
0B84  9A 53 0B B9 26  call far 26B9:0B53
0B89  BF 31 D7        mov di, 0xd731
0B8C  1E              push ds
0B8D  57              push di
0B8E  9A D2 0B B9 26  call far 26B9:0BD2
0B93  BF 3E D7        mov di, 0xd73e
0B96  1E              push ds
0B97  57              push di
0B98  6A 50           push 0x50
0B9A  9A 6D 0B B9 26  call far 26B9:0B6D
0B9F  C9              leave
0BA0  C3              ret

; ---- routine 1B51:0BA1  (found by: call)
sub_0BA1:
0BA1  C8 04 00 00     enter 4, 0
0BA5  C4 3E D2 D7     les di, ptr [0xd7d2]
0BA9  89 7E FC        mov word ptr [bp - 4], di
0BAC  8C 46 FE        mov word ptr [bp - 2], es
loc_0BAF:
0BAF  BF 96 7B        mov di, 0x7b96
0BB2  1E              push ds
0BB3  57              push di
0BB4  BF 5C DD        mov di, 0xdd5c
0BB7  1E              push ds
0BB8  57              push di
0BB9  9A 2F 05 1A 23  call far 231A:052F
0BBE  6A 05           push 5
0BC0  80 3E 04 0F 02  cmp byte ptr [0xf04], 2
0BC5  B0 00           mov al, 0
0BC7  75 01           jne 0xbca
0BC9  40              inc ax
loc_0BCA:
0BCA  98              cwde
0BCB  8B F8           mov di, ax
0BCD  C1 E7 02        shl di, 2
0BD0  81 C7 08 0F     add di, 0xf08
0BD4  1E              push ds
0BD5  57              push di
0BD6  6A 18           push 0x18
0BD8  6A 24           push 0x24
0BDA  BF 5C DD        mov di, 0xdd5c
0BDD  1E              push ds
0BDE  57              push di
0BDF  9A 1B 04 1A 23  call far 231A:041B
0BE4  6A 15           push 0x15
0BE6  80 3E 04 0F 02  cmp byte ptr [0xf04], 2
0BEB  B0 00           mov al, 0
0BED  75 01           jne 0xbf0
0BEF  40              inc ax
loc_0BF0:
0BF0  98              cwde
0BF1  8B F8           mov di, ax
0BF3  8A 85 06 0F     mov al, byte ptr [di + 0xf06]
0BF7  30 E4           xor ah, ah
0BF9  50              push ax
0BFA  6A 07           push 7
0BFC  9A 03 02 1A 23  call far 231A:0203
0C01  BF 04 0F        mov di, 0xf04
0C04  1E              push ds
0C05  57              push di
0C06  6A 02           push 2
0C08  9A 8B 0F 1A 23  call far 231A:0F8B
0C0D  A0 88 DE        mov al, byte ptr [0xde88]
0C10  3C 02           cmp al, 2
0C12  75 0C           jne 0xc20
0C14  A0 04 0F        mov al, byte ptr [0xf04]
0C17  C4 7E FC        les di, ptr [bp - 4]
0C1A  26 88 45 03     mov byte ptr es:[di + 3], al
0C1E  EB 0B           jmp 0xc2b
loc_0C20:
0C20  3C 01           cmp al, 1
0C22  75 07           jne 0xc2b
0C24  31 C0           xor ax, ax
0C26  9A 16 01 B9 26  call far 26B9:0116
loc_0C2B:
0C2B  C4 7E FC        les di, ptr [bp - 4]
0C2E  26 80 7D 03 00  cmp byte ptr es:[di + 3], 0
0C33  75 03           jne 0xc38
0C35  E9 77 FF        jmp 0xbaf
loc_0C38:
0C38  C9              leave
0C39  C3              ret

; ---- routine 1B51:0C3A  (found by: call)
sub_0C3A:
0C3A  C8 02 00 00     enter 2, 0
0C3E  80 7E 06 00     cmp byte ptr [bp + 6], 0
0C42  74 03           je 0xc47
0C44  E8 5E F7        call 0x3a5
loc_0C47:
0C47  C6 46 FE 00     mov byte ptr [bp - 2], 0
0C4B  80 3E 8A DE 01  cmp byte ptr [0xde8a], 1
0C50  75 08           jne 0xc5a
0C52  C7 06 02 DF FF 00 mov word ptr [0xdf02], 0xff
0C58  EB 22           jmp 0xc7c
loc_0C5A:
0C5A  80 7E 08 00     cmp byte ptr [bp + 8], 0
0C5E  74 0F           je 0xc6f
0C60  BF 3E D7        mov di, 0xd73e
0C63  1E              push ds
0C64  57              push di
0C65  9A 50 12 1A 23  call far 231A:1250
0C6A  88 46 FE        mov byte ptr [bp - 2], al
0C6D  EB 0D           jmp 0xc7c
loc_0C6F:
0C6F  BF 3E D7        mov di, 0xd73e
0C72  1E              push ds
0C73  57              push di
0C74  9A 1C 12 1A 23  call far 231A:121C
0C79  88 46 FE        mov byte ptr [bp - 2], al
loc_0C7C:
0C7C  80 7E FE 00     cmp byte ptr [bp - 2], 0
0C80  74 0A           je 0xc8c
0C82  8A 46 08        mov al, byte ptr [bp + 8]
0C85  50              push ax
0C86  E8 94 FC        call 0x91d
0C89  88 46 FE        mov byte ptr [bp - 2], al
loc_0C8C:
0C8C  8A 46 FE        mov al, byte ptr [bp - 2]
0C8F  88 46 FF        mov byte ptr [bp - 1], al
0C92  8A 46 FF        mov al, byte ptr [bp - 1]
0C95  C9              leave
0C96  CA 04 00        retf 4
; data (not reached as code), 34 bytes
0C99                  db 00   ; .
0C9A                  pstr 'Do you want to load a saved game'

; ---- routine 1B51:0CBB  (found by: far)
sub_0CBB:
0CBB  C8 04 00 00     enter 4, 0
0CBF  BF 34 67        mov di, 0x6734
0CC2  1E              push ds
0CC3  57              push di
0CC4  BF 5C DD        mov di, 0xdd5c
0CC7  1E              push ds
0CC8  57              push di
0CC9  9A 2F 05 1A 23  call far 231A:052F
0CCE  C4 3E 5C DD     les di, ptr [0xdd5c]
0CD2  06              push es
0CD3  57              push di
0CD4  C4 3E 58 DD     les di, ptr [0xdd58]
0CD8  06              push es
0CD9  57              push di
0CDA  68 A0 0F        push 0xfa0
0CDD  9A 12 0A B9 26  call far 26B9:0A12
0CE2  BF 9A 0C        mov di, 0xc9a
0CE5  0E              push cs
0CE6  57              push di
0CE7  9A E5 06 1A 23  call far 231A:06E5
0CEC  88 46 FE        mov byte ptr [bp - 2], al
0CEF  80 7E FE 00     cmp byte ptr [bp - 2], 0
0CF3  75 0B           jne 0xd00
0CF5  E8 ED FD        call 0xae5
0CF8  6A 01           push 1
0CFA  0E              push cs
0CFB  E8 32 FA        call 0x730
0CFE  EB 34           jmp 0xd34
loc_0D00:
0D00  6A 01           push 1
0D02  6A 01           push 1
0D04  0E              push cs
0D05  E8 32 FF        call 0xc3a
0D08  08 C0           or al, al
0D0A  75 0B           jne 0xd17
0D0C  6A 01           push 1
0D0E  9A 94 11 1A 23  call far 231A:1194
0D13  08 C0           or al, al
0D15  75 E9           jne 0xd00
loc_0D17:
0D17  6A 00           push 0
0D19  0E              push cs
0D1A  E8 13 FA        call 0x730
loc_0D1D:
0D1D  6A 01           push 1
0D1F  6A 00           push 0
0D21  0E              push cs
0D22  E8 15 FF        call 0xc3a
0D25  08 C0           or al, al
0D27  75 0B           jne 0xd34
0D29  6A 01           push 1
0D2B  9A 94 11 1A 23  call far 231A:1194
0D30  08 C0           or al, al
0D32  75 E9           jne 0xd1d
loc_0D34:
0D34  80 7E FE 00     cmp byte ptr [bp - 2], 0
0D38  75 03           jne 0xd3d
0D3A  E8 64 FE        call 0xba1
loc_0D3D:
0D3D  8A 46 FE        mov al, byte ptr [bp - 2]
0D40  88 46 FF        mov byte ptr [bp - 1], al
0D43  8A 46 FF        mov al, byte ptr [bp - 1]
0D46  C9              leave
0D47  CB              retf

; ---- routine 1B51:0D48  (found by: call, far)
sub_0D48:
0D48  55              push bp
0D49  89 E5           mov bp, sp
loc_0D4B:
0D4B  6A 00           push 0
0D4D  6A 00           push 0
0D4F  0E              push cs
0D50  E8 E7 FE        call 0xc3a
0D53  08 C0           or al, al
0D55  75 0B           jne 0xd62
0D57  6A 00           push 0
0D59  9A 94 11 1A 23  call far 231A:1194
0D5E  08 C0           or al, al
0D60  75 E9           jne 0xd4b
loc_0D62:
0D62  C9              leave
0D63  CB              retf
; data (not reached as code), 60 bytes
0D64                  pstr 'Are you sure you want to quit'
0D82                  pstr 'Do you want to save this game'

; ---- routine 1B51:0DA0  (found by: far)
sub_0DA0:
0DA0  55              push bp
0DA1  89 E5           mov bp, sp
0DA3  BF 64 0D        mov di, 0xd64
0DA6  0E              push cs
0DA7  57              push di
0DA8  9A E5 06 1A 23  call far 231A:06E5
0DAD  08 C0           or al, al
0DAF  75 02           jne 0xdb3
0DB1  EB 25           jmp 0xdd8
loc_0DB3:
0DB3  C4 3E D2 D7     les di, ptr [0xd7d2]
0DB7  26 80 BD F4 00 00 cmp byte ptr es:[di + 0xf4], 0
0DBD  75 0E           jne 0xdcd
0DBF  BF 82 0D        mov di, 0xd82
0DC2  0E              push cs
0DC3  57              push di
0DC4  9A E5 06 1A 23  call far 231A:06E5
0DC9  08 C0           or al, al
0DCB  74 04           je 0xdd1
loc_0DCD:
0DCD  0E              push cs
0DCE  E8 77 FF        call 0xd48
loc_0DD1:
0DD1  31 C0           xor ax, ax
0DD3  9A 16 01 B9 26  call far 26B9:0116
loc_0DD8:
0DD8  C9              leave
0DD9  CB              retf

; ---- routine 1B51:0DDA  (found by: call, far)
sub_0DDA:
0DDA  C8 02 00 00     enter 2, 0
0DDE  A0 BA DC        mov al, byte ptr [0xdcba]
0DE1  30 E4           xor ah, ah
0DE3  3B 46 06        cmp ax, word ptr [bp + 6]
0DE6  74 0E           je 0xdf6
0DE8  A0 BB DC        mov al, byte ptr [0xdcbb]
0DEB  30 E4           xor ah, ah
0DED  3B 46 06        cmp ax, word ptr [bp + 6]
0DF0  74 04           je 0xdf6
0DF2  B0 00           mov al, 0
0DF4  EB 02           jmp 0xdf8
loc_0DF6:
0DF6  B0 01           mov al, 1
loc_0DF8:
0DF8  88 46 FF        mov byte ptr [bp - 1], al
0DFB  8A 46 FF        mov al, byte ptr [bp - 1]
0DFE  C9              leave
0DFF  CA 02 00        retf 2

; ---- routine 1B51:0E02  (found by: call, far)
sub_0E02:
0E02  C8 06 00 00     enter 6, 0
0E06  6B 46 06 3E     imul ax, word ptr [bp + 6], 0x3e
0E0A  C4 3E C2 D7     les di, ptr [0xd7c2]
0E0E  03 F8           add di, ax
0E10  81 C7 C2 FF     add di, 0xffc2
0E14  89 7E FA        mov word ptr [bp - 6], di
0E17  8C 46 FC        mov word ptr [bp - 4], es
0E1A  FF 76 06        push word ptr [bp + 6]
0E1D  0E              push cs
0E1E  E8 B9 FF        call 0xdda
0E21  08 C0           or al, al
0E23  74 06           je 0xe2b
0E25  C6 46 FF 0F     mov byte ptr [bp - 1], 0xf
0E29  EB 11           jmp 0xe3c
loc_0E2B:
0E2B  C4 7E FA        les di, ptr [bp - 6]
0E2E  26 8A 45 37     mov al, byte ptr es:[di + 0x37]
0E32  98              cwde
0E33  8B F8           mov di, ax
0E35  8A 85 3C A2     mov al, byte ptr [di - 0x5dc4]
0E39  88 46 FF        mov byte ptr [bp - 1], al
loc_0E3C:
0E3C  8A 46 FF        mov al, byte ptr [bp - 1]
0E3F  C9              leave
0E40  CA 02 00        retf 2

; ---- routine 1B51:0E43  (found by: call, far)
sub_0E43:
0E43  55              push bp
0E44  89 E5           mov bp, sp
0E46  6A 09           push 9
0E48  BF 10 0F        mov di, 0xf10
0E4B  1E              push ds
0E4C  57              push di
0E4D  8A 46 08        mov al, byte ptr [bp + 8]
0E50  50              push ax
0E51  8A 46 06        mov al, byte ptr [bp + 6]
0E54  50              push ax
0E55  BF 5C DD        mov di, 0xdd5c
0E58  1E              push ds
0E59  57              push di
0E5A  9A 1B 04 1A 23  call far 231A:041B
0E5F  83 7E 0A 00     cmp word ptr [bp + 0xa], 0
0E63  75 02           jne 0xe67
0E65  EB 30           jmp 0xe97
loc_0E67:
0E67  FF 76 0A        push word ptr [bp + 0xa]
0E6A  0E              push cs
0E6B  E8 94 FF        call 0xe02
0E6E  30 E4           xor ah, ah
0E70  A3 64 DD        mov word ptr [0xdd64], ax
0E73  8B 46 0A        mov ax, word ptr [bp + 0xa]
0E76  C1 E0 04        shl ax, 4
0E79  C4 3E B2 D7     les di, ptr [0xd7b2]
0E7D  03 F8           add di, ax
0E7F  81 C7 F0 FF     add di, 0xfff0
0E83  06              push es
0E84  57              push di
0E85  8A 46 08        mov al, byte ptr [bp + 8]
0E88  50              push ax
0E89  8A 46 06        mov al, byte ptr [bp + 6]
0E8C  50              push ax
0E8D  BF 5C DD        mov di, 0xdd5c
0E90  1E              push ds
0E91  57              push di
0E92  9A 9D 03 1A 23  call far 231A:039D
loc_0E97:
0E97  C9              leave
0E98  CA 06 00        retf 6

; ---- routine 1B51:0E9B  (found by: call, far)
sub_0E9B:
0E9B  55              push bp
0E9C  89 E5           mov bp, sp
0E9E  6A 09           push 9
0EA0  BF 10 0F        mov di, 0xf10
0EA3  1E              push ds
0EA4  57              push di
0EA5  8A 46 08        mov al, byte ptr [bp + 8]
0EA8  50              push ax
0EA9  8A 46 06        mov al, byte ptr [bp + 6]
0EAC  50              push ax
0EAD  BF 5C DD        mov di, 0xdd5c
0EB0  1E              push ds
0EB1  57              push di
0EB2  9A 0C 03 1A 23  call far 231A:030C
0EB7  83 7E 0A 00     cmp word ptr [bp + 0xa], 0
0EBB  75 02           jne 0xebf
0EBD  EB 30           jmp 0xeef
loc_0EBF:
0EBF  FF 76 0A        push word ptr [bp + 0xa]
0EC2  0E              push cs
0EC3  E8 3C FF        call 0xe02
0EC6  30 E4           xor ah, ah
0EC8  A3 64 DD        mov word ptr [0xdd64], ax
0ECB  8B 46 0A        mov ax, word ptr [bp + 0xa]
0ECE  C1 E0 04        shl ax, 4
0ED1  C4 3E B2 D7     les di, ptr [0xd7b2]
0ED5  03 F8           add di, ax
0ED7  81 C7 F0 FF     add di, 0xfff0
0EDB  06              push es
0EDC  57              push di
0EDD  8A 46 08        mov al, byte ptr [bp + 8]
0EE0  50              push ax
0EE1  8A 46 06        mov al, byte ptr [bp + 6]
0EE4  50              push ax
0EE5  BF 5C DD        mov di, 0xdd5c
0EE8  1E              push ds
0EE9  57              push di
0EEA  9A 83 02 1A 23  call far 231A:0283
loc_0EEF:
0EEF  C9              leave
0EF0  CA 06 00        retf 6
; data (not reached as code), 2 bytes
0EF3                  db 01 2C   ; .,

; ---- routine 1B51:0EF5  (found by: call, far)
sub_0EF5:
0EF5  C8 1A 01 00     enter 0x11a, 0
0EF9  8D BE E6 FE     lea di, [bp - 0x11a]
0EFD  16              push ss
0EFE  57              push di
0EFF  FF 76 08        push word ptr [bp + 8]
0F02  FF 76 06        push word ptr [bp + 6]
0F05  9A C9 07 1A 23  call far 231A:07C9
0F0A  8D 7E E6        lea di, [bp - 0x1a]
0F0D  16              push ss
0F0E  57              push di
0F0F  6A 14           push 0x14
0F11  9A 6D 0B B9 26  call far 26B9:0B6D
0F16  31 C0           xor ax, ax
0F18  89 46 FC        mov word ptr [bp - 4], ax
0F1B  8A 46 E6        mov al, byte ptr [bp - 0x1a]
0F1E  30 E4           xor ah, ah
0F20  3D 01 00        cmp ax, 1
0F23  72 44           jb 0xf69
0F25  89 46 FE        mov word ptr [bp - 2], ax
0F28  EB 03           jmp 0xf2d
loc_0F2A:
0F2A  FF 4E FE        dec word ptr [bp - 2]
loc_0F2D:
0F2D  FF 46 FC        inc word ptr [bp - 4]
0F30  83 7E FC 03     cmp word ptr [bp - 4], 3
0F34  75 2D           jne 0xf63
0F36  8B 46 FE        mov ax, word ptr [bp - 2]
0F39  48              dec ax
0F3A  09 C0           or ax, ax
0F3C  74 25           je 0xf63
0F3E  8B 46 FE        mov ax, word ptr [bp - 2]
0F41  48              dec ax
0F42  8B F8           mov di, ax
0F44  80 7B E6 2D     cmp byte ptr [bp + di - 0x1a], 0x2d
0F48  74 19           je 0xf63
0F4A  BF F3 0E        mov di, 0xef3
0F4D  0E              push cs
0F4E  57              push di
0F4F  8D 7E E6        lea di, [bp - 0x1a]
0F52  16              push ss
0F53  57              push di
0F54  6A 14           push 0x14
0F56  FF 76 FE        push word ptr [bp - 2]
0F59  9A 9C 0C B9 26  call far 26B9:0C9C
0F5E  31 C0           xor ax, ax
0F60  89 46 FC        mov word ptr [bp - 4], ax
loc_0F63:
0F63  83 7E FE 01     cmp word ptr [bp - 2], 1
0F67  75 C1           jne 0xf2a
loc_0F69:
0F69  8D 7E E6        lea di, [bp - 0x1a]
0F6C  16              push ss
0F6D  57              push di
0F6E  C4 7E 0A        les di, ptr [bp + 0xa]
0F71  06              push es
0F72  57              push di
0F73  6A 14           push 0x14
0F75  9A 6D 0B B9 26  call far 26B9:0B6D
0F7A  C9              leave
0F7B  CA 04 00        retf 4

; ---- routine 1B51:0F7E  (found by: call, far)
sub_0F7E:
0F7E  C8 1A 01 00     enter 0x11a, 0
0F82  A0 64 DD        mov al, byte ptr [0xdd64]
0F85  A2 20 0F        mov byte ptr [0xf20], al
0F88  8D BE E6 FE     lea di, [bp - 0x11a]
0F8C  16              push ss
0F8D  57              push di
0F8E  FF 76 0C        push word ptr [bp + 0xc]
0F91  FF 76 0A        push word ptr [bp + 0xa]
0F94  0E              push cs
0F95  E8 5D FF        call 0xef5
0F98  8D 7E EA        lea di, [bp - 0x16]
0F9B  16              push ss
0F9C  57              push di
0F9D  6A 14           push 0x14
0F9F  9A 6D 0B B9 26  call far 26B9:0B6D
0FA4  8A 46 EA        mov al, byte ptr [bp - 0x16]
0FA7  30 E4           xor ah, ah
0FA9  3D 01 00        cmp ax, 1
0FAC  72 5B           jb 0x1009
0FAE  89 46 E8        mov word ptr [bp - 0x18], ax
0FB1  EB 03           jmp 0xfb6
loc_0FB3:
0FB3  FF 4E E8        dec word ptr [bp - 0x18]
loc_0FB6:
0FB6  8B 7E E8        mov di, word ptr [bp - 0x18]
0FB9  80 7B EA 2C     cmp byte ptr [bp + di - 0x16], 0x2c
0FBD  B0 00           mov al, 0
0FBF  75 01           jne 0xfc2
0FC1  40              inc ax
loc_0FC2:
0FC2  88 46 E7        mov byte ptr [bp - 0x19], al
0FC5  8A 46 E7        mov al, byte ptr [bp - 0x19]
0FC8  98              cwde
0FC9  8B F8           mov di, ax
0FCB  8A 85 20 0F     mov al, byte ptr [di + 0xf20]
0FCF  50              push ax
0FD0  8D BE E6 FE     lea di, [bp - 0x11a]
0FD4  16              push ss
0FD5  57              push di
0FD6  8B 7E E8        mov di, word ptr [bp - 0x18]
0FD9  8A 43 EA        mov al, byte ptr [bp + di - 0x16]
0FDC  50              push ax
0FDD  9A 6F 0C B9 26  call far 26B9:0C6F
0FE2  8A 46 08        mov al, byte ptr [bp + 8]
0FE5  50              push ax
0FE6  8A 46 E7        mov al, byte ptr [bp - 0x19]
0FE9  30 E4           xor ah, ah
0FEB  03 46 06        add ax, word ptr [bp + 6]
0FEE  50              push ax
0FEF  BF 5C DD        mov di, 0xdd5c
0FF2  1E              push ds
0FF3  57              push di
0FF4  9A 1B 04 1A 23  call far 231A:041B
0FF9  80 7E E7 00     cmp byte ptr [bp - 0x19], 0
0FFD  75 04           jne 0x1003
0FFF  83 6E 06 02     sub word ptr [bp + 6], 2
loc_1003:
1003  83 7E E8 01     cmp word ptr [bp - 0x18], 1
1007  75 AA           jne 0xfb3
loc_1009:
1009  C9              leave
100A  CA 08 00        retf 8
; data (not reached as code), 2 bytes
100D                  db 01 2D   ; .-

; ---- routine 1B51:100F  (found by: call)
sub_100F:
100F  C8 0A 03 00     enter 0x30a, 0
1013  6B 46 06 3E     imul ax, word ptr [bp + 6], 0x3e
1017  C4 3E C2 D7     les di, ptr [0xd7c2]
101B  03 F8           add di, ax
101D  81 C7 C2 FF     add di, 0xffc2
1021  89 7E F6        mov word ptr [bp - 0xa], di
1024  8C 46 F8        mov word ptr [bp - 8], es
1027  31 C0           xor ax, ax
1029  89 46 FC        mov word ptr [bp - 4], ax
102C  89 46 FE        mov word ptr [bp - 2], ax
102F  C7 46 FA 01 00  mov word ptr [bp - 6], 1
1034  EB 03           jmp 0x1039
loc_1036:
1036  FF 46 FA        inc word ptr [bp - 6]
loc_1039:
1039  8B 46 FA        mov ax, word ptr [bp - 6]
103C  D1 E0           shl ax, 1
103E  C4 7E F6        les di, ptr [bp - 0xa]
1041  03 F8           add di, ax
1043  26 FF 75 FE     push word ptr es:[di - 2]
1047  0E              push cs
1048  E8 9E 3E        call 0x4ee9
104B  08 C0           or al, al
104D  75 2A           jne 0x1079
104F  8B 46 FA        mov ax, word ptr [bp - 6]
1052  D1 E0           shl ax, 1
1054  C4 7E F6        les di, ptr [bp - 0xa]
1057  03 F8           add di, ax
1059  26 8B 45 FE     mov ax, word ptr es:[di - 2]
105D  C1 E0 03        shl ax, 3
1060  C4 3E BA D7     les di, ptr [0xd7ba]
1064  03 F8           add di, ax
1066  26 8A 45 06     mov al, byte ptr es:[di + 6]
106A  30 E4           xor ah, ah
106C  8B F8           mov di, ax
106E  8A 85 22 0F     mov al, byte ptr [di + 0xf22]
1072  30 E4           xor ah, ah
1074  8B F8           mov di, ax
1076  FE 43 FC        inc byte ptr [bp + di - 4]
loc_1079:
1079  83 7E FA 0B     cmp word ptr [bp - 6], 0xb
107D  75 B7           jne 0x1036
107F  8D BE F6 FE     lea di, [bp - 0x10a]
1083  16              push ss
1084  57              push di
1085  8A 46 FD        mov al, byte ptr [bp - 3]
1088  30 E4           xor ah, ah
108A  31 D2           xor dx, dx
108C  52              push dx
108D  50              push ax
108E  9A C9 07 1A 23  call far 231A:07C9
1093  BF 0D 10        mov di, 0x100d
1096  0E              push cs
1097  57              push di
1098  9A D2 0B B9 26  call far 26B9:0BD2
109D  8D BE F6 FD     lea di, [bp - 0x20a]
10A1  16              push ss
10A2  57              push di
10A3  8A 46 FE        mov al, byte ptr [bp - 2]
10A6  30 E4           xor ah, ah
10A8  31 D2           xor dx, dx
10AA  52              push dx
10AB  50              push ax
10AC  9A C9 07 1A 23  call far 231A:07C9
10B1  9A D2 0B B9 26  call far 26B9:0BD2
10B6  BF 0D 10        mov di, 0x100d
10B9  0E              push cs
10BA  57              push di
10BB  9A D2 0B B9 26  call far 26B9:0BD2
10C0  8D BE F6 FC     lea di, [bp - 0x30a]
10C4  16              push ss
10C5  57              push di
10C6  8A 46 FF        mov al, byte ptr [bp - 1]
10C9  30 E4           xor ah, ah
10CB  31 D2           xor dx, dx
10CD  52              push dx
10CE  50              push ax
10CF  9A C9 07 1A 23  call far 231A:07C9
10D4  9A D2 0B B9 26  call far 26B9:0BD2
10D9  C4 7E 08        les di, ptr [bp + 8]
10DC  06              push es
10DD  57              push di
10DE  6A 0A           push 0xa
10E0  9A 6D 0B B9 26  call far 26B9:0B6D
10E5  C9              leave
10E6  CA 02 00        retf 2
; data (not reached as code), 57 bytes
10E9                  pstr 'Round 1'
10F1                  pstr 'Round 2'
10F9                  pstr 'Round 3'
1101                  pstr 'Quarter Finals'
1110                  pstr 'Semi Finals'
111C                  pstr 'Final'

; ---- routine 1B51:1122  (found by: call)
sub_1122:
1122  55              push bp
1123  89 E5           mov bp, sp
1125  C4 7E 06        les di, ptr [bp + 6]
1128  26 C6 05 00     mov byte ptr es:[di], 0
112C  8B 7E 04        mov di, word ptr [bp + 4]
112F  36 8A 45 06     mov al, byte ptr ss:[di + 6]
1133  3C 0A           cmp al, 0xa
1135  74 0C           je 0x1143
1137  3C 0C           cmp al, 0xc
1139  74 08           je 0x1143
113B  3C 08           cmp al, 8
113D  74 04           je 0x1143
113F  3C 17           cmp al, 0x17
1141  75 14           jne 0x1157
loc_1143:
1143  BF E9 10        mov di, 0x10e9
1146  0E              push cs
1147  57              push di
1148  C4 7E 06        les di, ptr [bp + 6]
114B  06              push es
114C  57              push di
114D  6A 0F           push 0xf
114F  9A 6D 0B B9 26  call far 26B9:0B6D
1154  E9 B4 00        jmp 0x120b
loc_1157:
1157  3C 14           cmp al, 0x14
1159  74 0C           je 0x1167
115B  3C 16           cmp al, 0x16
115D  74 08           je 0x1167
115F  3C 0E           cmp al, 0xe
1161  74 04           je 0x1167
1163  3C 1D           cmp al, 0x1d
1165  75 14           jne 0x117b
loc_1167:
1167  BF F1 10        mov di, 0x10f1
116A  0E              push cs
116B  57              push di
116C  C4 7E 06        les di, ptr [bp + 6]
116F  06              push es
1170  57              push di
1171  6A 0F           push 0xf
1173  9A 6D 0B B9 26  call far 26B9:0B6D
1178  E9 90 00        jmp 0x120b
loc_117B:
117B  3C 12           cmp al, 0x12
117D  74 04           je 0x1183
117F  3C 23           cmp al, 0x23
1181  75 13           jne 0x1196
loc_1183:
1183  BF F9 10        mov di, 0x10f9
1186  0E              push cs
1187  57              push di
1188  C4 7E 06        les di, ptr [bp + 6]
118B  06              push es
118C  57              push di
118D  6A 0F           push 0xf
118F  9A 6D 0B B9 26  call far 26B9:0B6D
1194  EB 75           jmp 0x120b
loc_1196:
1196  3C 1B           cmp al, 0x1b
1198  74 0C           je 0x11a6
119A  3C 21           cmp al, 0x21
119C  74 08           je 0x11a6
119E  3C 19           cmp al, 0x19
11A0  74 04           je 0x11a6
11A2  3C 29           cmp al, 0x29
11A4  75 13           jne 0x11b9
loc_11A6:
11A6  BF 01 11        mov di, 0x1101
11A9  0E              push cs
11AA  57              push di
11AB  C4 7E 06        les di, ptr [bp + 6]
11AE  06              push es
11AF  57              push di
11B0  6A 0F           push 0xf
11B2  9A 6D 0B B9 26  call far 26B9:0B6D
11B7  EB 52           jmp 0x120b
loc_11B9:
11B9  3C 27           cmp al, 0x27
11BB  74 0C           je 0x11c9
11BD  3C 2B           cmp al, 0x2b
11BF  74 08           je 0x11c9
11C1  3C 1F           cmp al, 0x1f
11C3  74 04           je 0x11c9
11C5  3C 2E           cmp al, 0x2e
11C7  75 13           jne 0x11dc
loc_11C9:
11C9  BF 10 11        mov di, 0x1110
11CC  0E              push cs
11CD  57              push di
11CE  C4 7E 06        les di, ptr [bp + 6]
11D1  06              push es
11D2  57              push di
11D3  6A 0F           push 0xf
11D5  9A 6D 0B B9 26  call far 26B9:0B6D
11DA  EB 2F           jmp 0x120b
loc_11DC:
11DC  3C 30           cmp al, 0x30
11DE  74 10           je 0x11f0
11E0  3C 35           cmp al, 0x35
11E2  74 0C           je 0x11f0
11E4  3C 25           cmp al, 0x25
11E6  74 08           je 0x11f0
11E8  3C 33           cmp al, 0x33
11EA  74 04           je 0x11f0
11EC  3C 39           cmp al, 0x39
11EE  75 1B           jne 0x120b
loc_11F0:
11F0  8B 7E 04        mov di, word ptr [bp + 4]
11F3  36 80 7D 08 07  cmp byte ptr ss:[di + 8], 7
11F8  75 11           jne 0x120b
11FA  BF 1C 11        mov di, 0x111c
11FD  0E              push cs
11FE  57              push di
11FF  C4 7E 06        les di, ptr [bp + 6]
1202  06              push es
1203  57              push di
1204  6A 0F           push 0xf
1206  9A 6D 0B B9 26  call far 26B9:0B6D
loc_120B:
120B  C9              leave
120C  C2 02 00        ret 2
; data (not reached as code), 2 bytes
120F                  db 01 20   ; . 

; ---- routine 1B51:1211  (found by: call, far)
sub_1211:
1211  C8 00 02 00     enter 0x200, 0
1215  8D BE 00 FF     lea di, [bp - 0x100]
1219  16              push ss
121A  57              push di
121B  8A 46 08        mov al, byte ptr [bp + 8]
121E  98              cwde
121F  8B F8           mov di, ax
1221  C1 E7 04        shl di, 4
1224  81 C7 30 0F     add di, 0xf30
1228  1E              push ds
1229  57              push di
122A  9A 53 0B B9 26  call far 26B9:0B53
122F  BF 0F 12        mov di, 0x120f
1232  0E              push cs
1233  57              push di
1234  9A D2 0B B9 26  call far 26B9:0BD2
1239  8D BE 00 FE     lea di, [bp - 0x200]
123D  16              push ss
123E  57              push di
123F  55              push bp
1240  E8 DF FE        call 0x1122
1243  9A D2 0B B9 26  call far 26B9:0BD2
1248  C4 7E 0A        les di, ptr [bp + 0xa]
124B  06              push es
124C  57              push di
124D  6A 1E           push 0x1e
124F  9A 6D 0B B9 26  call far 26B9:0B6D
1254  C9              leave
1255  CA 04 00        retf 4
; data (not reached as code), 60 bytes
1258                  pstr 'QF L#1'
125F                  pstr 'QF L#2'
1266                  pstr 'SF L#1'
126D                  pstr 'SF L#2'
1274                  pstr 'Final'
127A                  pstr 'Final L#1'
1284                  pstr 'Final L#2'
128E                  pstr 'Group'

; ---- routine 1B51:1294  (found by: call)
sub_1294:
1294  55              push bp
1295  89 E5           mov bp, sp
1297  C4 7E 06        les di, ptr [bp + 6]
129A  26 C6 05 00     mov byte ptr es:[di], 0
129E  8B 7E 04        mov di, word ptr [bp + 4]
12A1  36 80 7D 08 06  cmp byte ptr ss:[di + 8], 6
12A6  75 03           jne 0x12ab
12A8  E9 AC 00        jmp 0x1357
loc_12AB:
12AB  36 8A 45 06     mov al, byte ptr ss:[di + 6]
12AF  3C 1B           cmp al, 0x1b
12B1  75 14           jne 0x12c7
12B3  BF 58 12        mov di, 0x1258
12B6  0E              push cs
12B7  57              push di
12B8  C4 7E 06        les di, ptr [bp + 6]
12BB  06              push es
12BC  57              push di
12BD  6A 0A           push 0xa
12BF  9A 6D 0B B9 26  call far 26B9:0B6D
12C4  E9 8E 00        jmp 0x1355
loc_12C7:
12C7  3C 21           cmp al, 0x21
12C9  75 13           jne 0x12de
12CB  BF 5F 12        mov di, 0x125f
12CE  0E              push cs
12CF  57              push di
12D0  C4 7E 06        les di, ptr [bp + 6]
12D3  06              push es
12D4  57              push di
12D5  6A 0A           push 0xa
12D7  9A 6D 0B B9 26  call far 26B9:0B6D
12DC  EB 77           jmp 0x1355
loc_12DE:
12DE  3C 27           cmp al, 0x27
12E0  75 13           jne 0x12f5
12E2  BF 66 12        mov di, 0x1266
12E5  0E              push cs
12E6  57              push di
12E7  C4 7E 06        les di, ptr [bp + 6]
12EA  06              push es
12EB  57              push di
12EC  6A 0A           push 0xa
12EE  9A 6D 0B B9 26  call far 26B9:0B6D
12F3  EB 60           jmp 0x1355
loc_12F5:
12F5  3C 2B           cmp al, 0x2b
12F7  75 13           jne 0x130c
12F9  BF 6D 12        mov di, 0x126d
12FC  0E              push cs
12FD  57              push di
12FE  C4 7E 06        les di, ptr [bp + 6]
1301  06              push es
1302  57              push di
1303  6A 0A           push 0xa
1305  9A 6D 0B B9 26  call far 26B9:0B6D
130A  EB 49           jmp 0x1355
loc_130C:
130C  3C 30           cmp al, 0x30
130E  75 30           jne 0x1340
1310  8B 7E 04        mov di, word ptr [bp + 4]
1313  36 80 7D 08 07  cmp byte ptr ss:[di + 8], 7
1318  75 13           jne 0x132d
131A  BF 74 12        mov di, 0x1274
131D  0E              push cs
131E  57              push di
131F  C4 7E 06        les di, ptr [bp + 6]
1322  06              push es
1323  57              push di
1324  6A 0A           push 0xa
1326  9A 6D 0B B9 26  call far 26B9:0B6D
132B  EB 11           jmp 0x133e
loc_132D:
132D  BF 7A 12        mov di, 0x127a
1330  0E              push cs
1331  57              push di
1332  C4 7E 06        les di, ptr [bp + 6]
1335  06              push es
1336  57              push di
1337  6A 0A           push 0xa
1339  9A 6D 0B B9 26  call far 26B9:0B6D
loc_133E:
133E  EB 15           jmp 0x1355
loc_1340:
1340  3C 35           cmp al, 0x35
1342  75 11           jne 0x1355
1344  BF 84 12        mov di, 0x1284
1347  0E              push cs
1348  57              push di
1349  C4 7E 06        les di, ptr [bp + 6]
134C  06              push es
134D  57              push di
134E  6A 0A           push 0xa
1350  9A 6D 0B B9 26  call far 26B9:0B6D
loc_1355:
1355  EB 2E           jmp 0x1385
loc_1357:
1357  8B 7E 04        mov di, word ptr [bp + 4]
135A  36 80 7D 06 39  cmp byte ptr ss:[di + 6], 0x39
135F  74 13           je 0x1374
1361  BF 8E 12        mov di, 0x128e
1364  0E              push cs
1365  57              push di
1366  C4 7E 06        les di, ptr [bp + 6]
1369  06              push es
136A  57              push di
136B  6A 0A           push 0xa
136D  9A 6D 0B B9 26  call far 26B9:0B6D
1372  EB 11           jmp 0x1385
loc_1374:
1374  BF 74 12        mov di, 0x1274
1377  0E              push cs
1378  57              push di
1379  C4 7E 06        les di, ptr [bp + 6]
137C  06              push es
137D  57              push di
137E  6A 0A           push 0xa
1380  9A 6D 0B B9 26  call far 26B9:0B6D
loc_1385:
1385  C9              leave
1386  C2 02 00        ret 2
; data (not reached as code), 2 bytes
1389                  db 01 20   ; . 

; ---- routine 1B51:138B  (found by: call, far)
sub_138B:
138B  C8 16 02 00     enter 0x216, 0
138F  8D BE EA FE     lea di, [bp - 0x116]
1393  16              push ss
1394  57              push di
1395  8A 46 08        mov al, byte ptr [bp + 8]
1398  98              cwde
1399  8B F8           mov di, ax
139B  C1 E7 04        shl di, 4
139E  81 C7 30 0F     add di, 0xf30
13A2  1E              push ds
13A3  57              push di
13A4  9A 53 0B B9 26  call far 26B9:0B53
13A9  BF 89 13        mov di, 0x1389
13AC  0E              push cs
13AD  57              push di
13AE  9A D2 0B B9 26  call far 26B9:0BD2
13B3  8D 7E EA        lea di, [bp - 0x16]
13B6  16              push ss
13B7  57              push di
13B8  6A 14           push 0x14
13BA  9A 6D 0B B9 26  call far 26B9:0B6D
13BF  8A 46 06        mov al, byte ptr [bp + 6]
13C2  30 E4           xor ah, ah
13C4  8B F8           mov di, ax
13C6  8A 85 6A A2     mov al, byte ptr [di - 0x5d96]
13CA  3A 46 08        cmp al, byte ptr [bp + 8]
13CD  75 31           jne 0x1400
13CF  8D BE EA FE     lea di, [bp - 0x116]
13D3  16              push ss
13D4  57              push di
13D5  8D 7E EA        lea di, [bp - 0x16]
13D8  16              push ss
13D9  57              push di
13DA  9A 53 0B B9 26  call far 26B9:0B53
13DF  8A 46 06        mov al, byte ptr [bp + 6]
13E2  30 E4           xor ah, ah
13E4  8B F8           mov di, ax
13E6  C1 E7 03        shl di, 3
13E9  81 C7 26 88     add di, 0x8826
13ED  1E              push ds
13EE  57              push di
13EF  9A D2 0B B9 26  call far 26B9:0BD2
13F4  8D 7E EA        lea di, [bp - 0x16]
13F7  16              push ss
13F8  57              push di
13F9  6A 14           push 0x14
13FB  9A 6D 0B B9 26  call far 26B9:0B6D
loc_1400:
1400  8A 46 06        mov al, byte ptr [bp + 6]
1403  30 E4           xor ah, ah
1405  8B F8           mov di, ax
1407  80 BD 6A A2 05  cmp byte ptr [di - 0x5d96], 5
140C  75 6F           jne 0x147d
140E  8A 46 08        mov al, byte ptr [bp + 8]
1411  3C 06           cmp al, 6
1413  72 68           jb 0x147d
1415  3C 08           cmp al, 8
1417  77 64           ja 0x147d
1419  80 7E 06 16     cmp byte ptr [bp + 6], 0x16
141D  77 33           ja 0x1452
141F  8D BE EA FE     lea di, [bp - 0x116]
1423  16              push ss
1424  57              push di
1425  8D 7E EA        lea di, [bp - 0x16]
1428  16              push ss
1429  57              push di
142A  9A 53 0B B9 26  call far 26B9:0B53
142F  8A 46 06        mov al, byte ptr [bp + 6]
1432  30 E4           xor ah, ah
1434  8B F8           mov di, ax
1436  C1 E7 03        shl di, 3
1439  81 C7 26 88     add di, 0x8826
143D  1E              push ds
143E  57              push di
143F  9A D2 0B B9 26  call far 26B9:0BD2
1444  8D 7E EA        lea di, [bp - 0x16]
1447  16              push ss
1448  57              push di
1449  6A 14           push 0x14
144B  9A 6D 0B B9 26  call far 26B9:0B6D
1450  EB 2B           jmp 0x147d
loc_1452:
1452  8D BE EA FD     lea di, [bp - 0x216]
1456  16              push ss
1457  57              push di
1458  8D 7E EA        lea di, [bp - 0x16]
145B  16              push ss
145C  57              push di
145D  9A 53 0B B9 26  call far 26B9:0B53
1462  8D BE EA FE     lea di, [bp - 0x116]
1466  16              push ss
1467  57              push di
1468  55              push bp
1469  E8 28 FE        call 0x1294
146C  9A D2 0B B9 26  call far 26B9:0BD2
1471  8D 7E EA        lea di, [bp - 0x16]
1474  16              push ss
1475  57              push di
1476  6A 14           push 0x14
1478  9A 6D 0B B9 26  call far 26B9:0B6D
loc_147D:
147D  8A 46 EA        mov al, byte ptr [bp - 0x16]
1480  30 E4           xor ah, ah
1482  8B F8           mov di, ax
1484  80 7B EA 20     cmp byte ptr [bp + di - 0x16], 0x20
1488  75 03           jne 0x148d
148A  FE 4E EA        dec byte ptr [bp - 0x16]
loc_148D:
148D  8D 7E EA        lea di, [bp - 0x16]
1490  16              push ss
1491  57              push di
1492  C4 7E 0A        les di, ptr [bp + 0xa]
1495  06              push es
1496  57              push di
1497  6A 14           push 0x14
1499  9A 6D 0B B9 26  call far 26B9:0B6D
149E  C9              leave
149F  CA 04 00        retf 4

; ---- routine 1B51:14A2  (found by: call, far)
sub_14A2:
14A2  C8 02 01 00     enter 0x102, 0
14A6  8A 46 0A        mov al, byte ptr [bp + 0xa]
14A9  50              push ax
14AA  8D 7E FE        lea di, [bp - 2]
14AD  16              push ss
14AE  57              push di
14AF  9A E3 01 1A 23  call far 231A:01E3
14B4  8A 46 FE        mov al, byte ptr [bp - 2]
14B7  3A 46 FF        cmp al, byte ptr [bp - 1]
14BA  74 19           je 0x14d5
14BC  8A 46 FE        mov al, byte ptr [bp - 2]
14BF  3A 46 FF        cmp al, byte ptr [bp - 1]
14C2  B0 00           mov al, 0
14C4  76 01           jbe 0x14c7
14C6  40              inc ax
loc_14C7:
14C7  98              cwde
14C8  8B F8           mov di, ax
14CA  8A 85 E0 0F     mov al, byte ptr [di + 0xfe0]
14CE  30 E4           xor ah, ah
14D0  A3 64 DD        mov word ptr [0xdd64], ax
14D3  EB 06           jmp 0x14db
loc_14D5:
14D5  C7 06 64 DD 06 00 mov word ptr [0xdd64], 6
loc_14DB:
14DB  8D BE FE FE     lea di, [bp - 0x102]
14DF  16              push ss
14E0  57              push di
14E1  8A 46 FE        mov al, byte ptr [bp - 2]
14E4  30 E4           xor ah, ah
14E6  31 D2           xor dx, dx
14E8  52              push dx
14E9  50              push ax
14EA  9A C9 07 1A 23  call far 231A:07C9
14EF  8A 46 08        mov al, byte ptr [bp + 8]
14F2  50              push ax
14F3  8A 46 06        mov al, byte ptr [bp + 6]
14F6  50              push ax
14F7  BF 5C DD        mov di, 0xdd5c
14FA  1E              push ds
14FB  57              push di
14FC  9A 83 02 1A 23  call far 231A:0283
1501  8D BE FE FE     lea di, [bp - 0x102]
1505  16              push ss
1506  57              push di
1507  8A 46 FF        mov al, byte ptr [bp - 1]
150A  30 E4           xor ah, ah
150C  31 D2           xor dx, dx
150E  52              push dx
150F  50              push ax
1510  9A C9 07 1A 23  call far 231A:07C9
1515  8A 46 08        mov al, byte ptr [bp + 8]
1518  50              push ax
1519  8B 46 06        mov ax, word ptr [bp + 6]
151C  40              inc ax
151D  40              inc ax
151E  50              push ax
151F  BF 5C DD        mov di, 0xdd5c
1522  1E              push ds
1523  57              push di
1524  9A 9D 03 1A 23  call far 231A:039D
1529  C9              leave
152A  CA 06 00        retf 6
; data (not reached as code), 2 bytes
152D                  db 01 FB   ; ..

