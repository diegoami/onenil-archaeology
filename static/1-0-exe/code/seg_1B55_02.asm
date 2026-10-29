; 1-0.EXE (One-Nil 96), code segment 1B55 (image offsets 1B550..2315F), part 2 of 12
; packed 1-0.EXE sha256 89ff9c5f238f24e81a0c2440a46cdd8997280a65fc3cc3d97cb974f55280a80a (LZEXE 0.91)
; unpacked (tools/static/unlzexe.py) sha256 887ed2a92767950e5309b2052409f875668605939b69e00737aa3047022b9f51
; tool: capstone 5.0.9 (pip package; core library 5.0.1280) (CS_ARCH_X86, CS_MODE_16), recursive descent from the entry point, far calls and near calls/jumps, then routine prologues (55 89 E5 / 55 8B EC / C8 iw 00) in what remains; tools/static/listing.py
; addresses are SEGMENT:OFFSET with SEGMENT the image paragraph before relocation; image offset = SEGMENT*16+OFFSET
; ---- routine 1B55:0AE5  (found by: call)
sub_0AE5:
0AE5  C8 00 01 00     enter 0x100, 0
0AE9  BF C6 0E        mov di, 0xec6
0AEC  1E              push ds
0AED  57              push di
0AEE  BF 5C DD        mov di, 0xdd5c
0AF1  1E              push ds
0AF2  57              push di
0AF3  9A 2F 05 2A 23  call far 232A:052F
0AF8  C4 3E 5C DD     les di, ptr [0xdd5c]
0AFC  81 C7 00 0F     add di, 0xf00
0B00  06              push es
0B01  57              push di
0B02  C4 3E 58 DD     les di, ptr [0xdd58]
0B06  81 C7 00 0F     add di, 0xf00
0B0A  06              push es
0B0B  57              push di
0B0C  68 A0 00        push 0xa0
0B0F  9A C2 01 BC 24  call far 24BC:01C2
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
0B2B  9A FE 0B C9 26  call far 26C9:0BFE
0B30  48              dec ax
0B31  50              push ax
0B32  9A 91 0B C9 26  call far 26C9:0B91
0B37  BF 3E D7        mov di, 0xd73e
0B3A  1E              push ds
0B3B  57              push di
0B3C  6A 50           push 0x50
0B3E  9A 6D 0B C9 26  call far 26C9:0B6D
0B43  BF 3E D7        mov di, 0xd73e
0B46  1E              push ds
0B47  57              push di
0B48  6A 50           push 0x50
0B4A  6A 24           push 0x24
0B4C  6A 2D           push 0x2d
0B4E  6A 19           push 0x19
0B50  9A 5C 0C 2A 23  call far 232A:0C5C
0B55  8D BE 00 FF     lea di, [bp - 0x100]
0B59  16              push ss
0B5A  57              push di
0B5B  BF 3E D7        mov di, 0xd73e
0B5E  1E              push ds
0B5F  57              push di
0B60  9A 53 0B C9 26  call far 26C9:0B53
0B65  BF E0 0A        mov di, 0xae0
0B68  0E              push cs
0B69  57              push di
0B6A  9A D2 0B C9 26  call far 26C9:0BD2
0B6F  BF EC D6        mov di, 0xd6ec
0B72  1E              push ds
0B73  57              push di
0B74  9A EE 14 BC 24  call far 24BC:14EE
0B79  8D BE 00 FF     lea di, [bp - 0x100]
0B7D  16              push ss
0B7E  57              push di
0B7F  BF EC D6        mov di, 0xd6ec
0B82  1E              push ds
0B83  57              push di
0B84  9A 53 0B C9 26  call far 26C9:0B53
0B89  BF 31 D7        mov di, 0xd731
0B8C  1E              push ds
0B8D  57              push di
0B8E  9A D2 0B C9 26  call far 26C9:0BD2
0B93  BF 3E D7        mov di, 0xd73e
0B96  1E              push ds
0B97  57              push di
0B98  6A 50           push 0x50
0B9A  9A 6D 0B C9 26  call far 26C9:0B6D
0B9F  C9              leave
0BA0  C3              ret

; ---- routine 1B55:0BA1  (found by: call)
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
0BB9  9A 2F 05 2A 23  call far 232A:052F
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
0BDF  9A 1B 04 2A 23  call far 232A:041B
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
0BFC  9A 03 02 2A 23  call far 232A:0203
0C01  BF 04 0F        mov di, 0xf04
0C04  1E              push ds
0C05  57              push di
0C06  6A 02           push 2
0C08  9A 8B 0F 2A 23  call far 232A:0F8B
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
0C26  9A 16 01 C9 26  call far 26C9:0116
loc_0C2B:
0C2B  C4 7E FC        les di, ptr [bp - 4]
0C2E  26 80 7D 03 00  cmp byte ptr es:[di + 3], 0
0C33  75 03           jne 0xc38
0C35  E9 77 FF        jmp 0xbaf
loc_0C38:
0C38  C9              leave
0C39  C3              ret

; ---- routine 1B55:0C3A  (found by: call)
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
0C65  9A 50 12 2A 23  call far 232A:1250
0C6A  88 46 FE        mov byte ptr [bp - 2], al
0C6D  EB 0D           jmp 0xc7c
loc_0C6F:
0C6F  BF 3E D7        mov di, 0xd73e
0C72  1E              push ds
0C73  57              push di
0C74  9A 1C 12 2A 23  call far 232A:121C
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
; data (not reached as code), 89 bytes
0C99                  pstr 'Do you want to load a saved game'
0CBA                  pstr 'To load a saved game you must purchase the full version'

; ---- routine 1B55:0CF2  (found by: far)
sub_0CF2:
0CF2  C8 04 00 00     enter 4, 0
0CF6  BF E8 6A        mov di, 0x6ae8
0CF9  1E              push ds
0CFA  57              push di
0CFB  BF 5C DD        mov di, 0xdd5c
0CFE  1E              push ds
0CFF  57              push di
0D00  9A 2F 05 2A 23  call far 232A:052F
0D05  C4 3E 5C DD     les di, ptr [0xdd5c]
0D09  06              push es
0D0A  57              push di
0D0B  C4 3E 58 DD     les di, ptr [0xdd58]
0D0F  06              push es
0D10  57              push di
0D11  68 A0 0F        push 0xfa0
0D14  9A 12 0A C9 26  call far 26C9:0A12
0D19  BF 99 0C        mov di, 0xc99
0D1C  0E              push cs
0D1D  57              push di
0D1E  9A E5 06 2A 23  call far 232A:06E5
0D23  88 46 FE        mov byte ptr [bp - 2], al
0D26  B0 00           mov al, 0
0D28  08 C0           or al, al
0D2A  74 06           je 0xd32
0D2C  80 7E FE 00     cmp byte ptr [bp - 2], 0
0D30  75 04           jne 0xd36
loc_0D32:
0D32  B0 00           mov al, 0
0D34  EB 02           jmp 0xd38
loc_0D36:
0D36  B0 01           mov al, 1
loc_0D38:
0D38  50              push ax
0D39  BF BA 0C        mov di, 0xcba
0D3C  0E              push cs
0D3D  57              push di
0D3E  9A 98 00 2A 23  call far 232A:0098
0D43  08 C0           or al, al
0D45  74 04           je 0xd4b
0D47  C6 46 FE 00     mov byte ptr [bp - 2], 0
loc_0D4B:
0D4B  80 7E FE 00     cmp byte ptr [bp - 2], 0
0D4F  75 0B           jne 0xd5c
0D51  E8 91 FD        call 0xae5
0D54  6A 01           push 1
0D56  0E              push cs
0D57  E8 D6 F9        call 0x730
0D5A  EB 34           jmp 0xd90
loc_0D5C:
0D5C  6A 01           push 1
0D5E  6A 01           push 1
0D60  0E              push cs
0D61  E8 D6 FE        call 0xc3a
0D64  08 C0           or al, al
0D66  75 0B           jne 0xd73
0D68  6A 01           push 1
0D6A  9A 94 11 2A 23  call far 232A:1194
0D6F  08 C0           or al, al
0D71  75 E9           jne 0xd5c
loc_0D73:
0D73  6A 00           push 0
0D75  0E              push cs
0D76  E8 B7 F9        call 0x730
loc_0D79:
0D79  6A 01           push 1
0D7B  6A 00           push 0
0D7D  0E              push cs
0D7E  E8 B9 FE        call 0xc3a
0D81  08 C0           or al, al
0D83  75 0B           jne 0xd90
0D85  6A 01           push 1
0D87  9A 94 11 2A 23  call far 232A:1194
0D8C  08 C0           or al, al
0D8E  75 E9           jne 0xd79
loc_0D90:
0D90  80 7E FE 00     cmp byte ptr [bp - 2], 0
0D94  75 03           jne 0xd99
0D96  E8 08 FE        call 0xba1
loc_0D99:
0D99  8A 46 FE        mov al, byte ptr [bp - 2]
0D9C  88 46 FF        mov byte ptr [bp - 1], al
0D9F  8A 46 FF        mov al, byte ptr [bp - 1]
0DA2  C9              leave
0DA3  CB              retf
; data (not reached as code), 62 bytes
0DA4                  pstr 'Game saved: to load a game you must purchase the full version'

; ---- routine 1B55:0DE2  (found by: call, far)
sub_0DE2:
0DE2  C8 02 00 00     enter 2, 0
loc_0DE6:
0DE6  6A 00           push 0
0DE8  6A 00           push 0
0DEA  0E              push cs
0DEB  E8 4C FE        call 0xc3a
0DEE  88 46 FF        mov byte ptr [bp - 1], al
0DF1  80 7E FF 00     cmp byte ptr [bp - 1], 0
0DF5  75 0B           jne 0xe02
0DF7  6A 00           push 0
0DF9  9A 94 11 2A 23  call far 232A:1194
0DFE  08 C0           or al, al
0E00  75 E4           jne 0xde6
loc_0E02:
0E02  C9              leave
0E03  CB              retf
; data (not reached as code), 60 bytes
0E04                  pstr 'Are you sure you want to quit'
0E22                  pstr 'Do you want to save this game'

; ---- routine 1B55:0E40  (found by: far)
sub_0E40:
0E40  55              push bp
0E41  89 E5           mov bp, sp
0E43  BF 04 0E        mov di, 0xe04
0E46  0E              push cs
0E47  57              push di
0E48  9A E5 06 2A 23  call far 232A:06E5
0E4D  08 C0           or al, al
0E4F  75 02           jne 0xe53
0E51  EB 25           jmp 0xe78
loc_0E53:
0E53  C4 3E D2 D7     les di, ptr [0xd7d2]
0E57  26 80 BD F4 00 00 cmp byte ptr es:[di + 0xf4], 0
0E5D  75 0E           jne 0xe6d
0E5F  BF 22 0E        mov di, 0xe22
0E62  0E              push cs
0E63  57              push di
0E64  9A E5 06 2A 23  call far 232A:06E5
0E69  08 C0           or al, al
0E6B  74 04           je 0xe71
loc_0E6D:
0E6D  0E              push cs
0E6E  E8 71 FF        call 0xde2
loc_0E71:
0E71  31 C0           xor ax, ax
0E73  9A 16 01 C9 26  call far 26C9:0116
loc_0E78:
0E78  C9              leave
0E79  CB              retf

; ---- routine 1B55:0E7A  (found by: call, far)
sub_0E7A:
0E7A  C8 02 00 00     enter 2, 0
0E7E  A0 BA DC        mov al, byte ptr [0xdcba]
0E81  30 E4           xor ah, ah
0E83  3B 46 06        cmp ax, word ptr [bp + 6]
0E86  74 0E           je 0xe96
0E88  A0 BB DC        mov al, byte ptr [0xdcbb]
0E8B  30 E4           xor ah, ah
0E8D  3B 46 06        cmp ax, word ptr [bp + 6]
0E90  74 04           je 0xe96
0E92  B0 00           mov al, 0
0E94  EB 02           jmp 0xe98
loc_0E96:
0E96  B0 01           mov al, 1
loc_0E98:
0E98  88 46 FF        mov byte ptr [bp - 1], al
0E9B  8A 46 FF        mov al, byte ptr [bp - 1]
0E9E  C9              leave
0E9F  CA 02 00        retf 2

; ---- routine 1B55:0EA2  (found by: call, far)
sub_0EA2:
0EA2  C8 06 00 00     enter 6, 0
0EA6  6B 46 06 3E     imul ax, word ptr [bp + 6], 0x3e
0EAA  C4 3E C2 D7     les di, ptr [0xd7c2]
0EAE  03 F8           add di, ax
0EB0  81 C7 C2 FF     add di, 0xffc2
0EB4  89 7E FA        mov word ptr [bp - 6], di
0EB7  8C 46 FC        mov word ptr [bp - 4], es
0EBA  FF 76 06        push word ptr [bp + 6]
0EBD  0E              push cs
0EBE  E8 B9 FF        call 0xe7a
0EC1  08 C0           or al, al
0EC3  74 06           je 0xecb
0EC5  C6 46 FF 0F     mov byte ptr [bp - 1], 0xf
0EC9  EB 11           jmp 0xedc
loc_0ECB:
0ECB  C4 7E FA        les di, ptr [bp - 6]
0ECE  26 8A 45 37     mov al, byte ptr es:[di + 0x37]
0ED2  98              cwde
0ED3  8B F8           mov di, ax
0ED5  8A 85 3C A2     mov al, byte ptr [di - 0x5dc4]
0ED9  88 46 FF        mov byte ptr [bp - 1], al
loc_0EDC:
0EDC  8A 46 FF        mov al, byte ptr [bp - 1]
0EDF  C9              leave
0EE0  CA 02 00        retf 2

; ---- routine 1B55:0EE3  (found by: call, far)
sub_0EE3:
0EE3  55              push bp
0EE4  89 E5           mov bp, sp
0EE6  6A 09           push 9
0EE8  BF 10 0F        mov di, 0xf10
0EEB  1E              push ds
0EEC  57              push di
0EED  8A 46 08        mov al, byte ptr [bp + 8]
0EF0  50              push ax
0EF1  8A 46 06        mov al, byte ptr [bp + 6]
0EF4  50              push ax
0EF5  BF 5C DD        mov di, 0xdd5c
0EF8  1E              push ds
0EF9  57              push di
0EFA  9A 1B 04 2A 23  call far 232A:041B
0EFF  83 7E 0A 00     cmp word ptr [bp + 0xa], 0
0F03  75 02           jne 0xf07
0F05  EB 30           jmp 0xf37
loc_0F07:
0F07  FF 76 0A        push word ptr [bp + 0xa]
0F0A  0E              push cs
0F0B  E8 94 FF        call 0xea2
0F0E  30 E4           xor ah, ah
0F10  A3 64 DD        mov word ptr [0xdd64], ax
0F13  8B 46 0A        mov ax, word ptr [bp + 0xa]
0F16  C1 E0 04        shl ax, 4
0F19  C4 3E B2 D7     les di, ptr [0xd7b2]
0F1D  03 F8           add di, ax
0F1F  81 C7 F0 FF     add di, 0xfff0
0F23  06              push es
0F24  57              push di
0F25  8A 46 08        mov al, byte ptr [bp + 8]
0F28  50              push ax
0F29  8A 46 06        mov al, byte ptr [bp + 6]
0F2C  50              push ax
0F2D  BF 5C DD        mov di, 0xdd5c
0F30  1E              push ds
0F31  57              push di
0F32  9A 9D 03 2A 23  call far 232A:039D
loc_0F37:
0F37  C9              leave
0F38  CA 06 00        retf 6

; ---- routine 1B55:0F3B  (found by: call, far)
sub_0F3B:
0F3B  55              push bp
0F3C  89 E5           mov bp, sp
0F3E  6A 09           push 9
0F40  BF 10 0F        mov di, 0xf10
0F43  1E              push ds
0F44  57              push di
0F45  8A 46 08        mov al, byte ptr [bp + 8]
0F48  50              push ax
0F49  8A 46 06        mov al, byte ptr [bp + 6]
0F4C  50              push ax
0F4D  BF 5C DD        mov di, 0xdd5c
0F50  1E              push ds
0F51  57              push di
0F52  9A 0C 03 2A 23  call far 232A:030C
0F57  83 7E 0A 00     cmp word ptr [bp + 0xa], 0
0F5B  75 02           jne 0xf5f
0F5D  EB 30           jmp 0xf8f
loc_0F5F:
0F5F  FF 76 0A        push word ptr [bp + 0xa]
0F62  0E              push cs
0F63  E8 3C FF        call 0xea2
0F66  30 E4           xor ah, ah
0F68  A3 64 DD        mov word ptr [0xdd64], ax
0F6B  8B 46 0A        mov ax, word ptr [bp + 0xa]
0F6E  C1 E0 04        shl ax, 4
0F71  C4 3E B2 D7     les di, ptr [0xd7b2]
0F75  03 F8           add di, ax
0F77  81 C7 F0 FF     add di, 0xfff0
0F7B  06              push es
0F7C  57              push di
0F7D  8A 46 08        mov al, byte ptr [bp + 8]
0F80  50              push ax
0F81  8A 46 06        mov al, byte ptr [bp + 6]
0F84  50              push ax
0F85  BF 5C DD        mov di, 0xdd5c
0F88  1E              push ds
0F89  57              push di
0F8A  9A 83 02 2A 23  call far 232A:0283
loc_0F8F:
0F8F  C9              leave
0F90  CA 06 00        retf 6
; data (not reached as code), 2 bytes
0F93                  db 01 2C   ; .,

; ---- routine 1B55:0F95  (found by: call, far)
sub_0F95:
0F95  C8 1A 01 00     enter 0x11a, 0
0F99  8D BE E6 FE     lea di, [bp - 0x11a]
0F9D  16              push ss
0F9E  57              push di
0F9F  FF 76 08        push word ptr [bp + 8]
0FA2  FF 76 06        push word ptr [bp + 6]
0FA5  9A C9 07 2A 23  call far 232A:07C9
0FAA  8D 7E E6        lea di, [bp - 0x1a]
0FAD  16              push ss
0FAE  57              push di
0FAF  6A 14           push 0x14
0FB1  9A 6D 0B C9 26  call far 26C9:0B6D
0FB6  31 C0           xor ax, ax
0FB8  89 46 FC        mov word ptr [bp - 4], ax
0FBB  8A 46 E6        mov al, byte ptr [bp - 0x1a]
0FBE  30 E4           xor ah, ah
0FC0  3D 01 00        cmp ax, 1
0FC3  72 44           jb 0x1009
0FC5  89 46 FE        mov word ptr [bp - 2], ax
0FC8  EB 03           jmp 0xfcd
loc_0FCA:
0FCA  FF 4E FE        dec word ptr [bp - 2]
loc_0FCD:
0FCD  FF 46 FC        inc word ptr [bp - 4]
0FD0  83 7E FC 03     cmp word ptr [bp - 4], 3
0FD4  75 2D           jne 0x1003
0FD6  8B 46 FE        mov ax, word ptr [bp - 2]
0FD9  48              dec ax
0FDA  09 C0           or ax, ax
0FDC  74 25           je 0x1003
0FDE  8B 46 FE        mov ax, word ptr [bp - 2]
0FE1  48              dec ax
0FE2  8B F8           mov di, ax
0FE4  80 7B E6 2D     cmp byte ptr [bp + di - 0x1a], 0x2d
0FE8  74 19           je 0x1003
0FEA  BF 93 0F        mov di, 0xf93
0FED  0E              push cs
0FEE  57              push di
0FEF  8D 7E E6        lea di, [bp - 0x1a]
0FF2  16              push ss
0FF3  57              push di
0FF4  6A 14           push 0x14
0FF6  FF 76 FE        push word ptr [bp - 2]
0FF9  9A 9C 0C C9 26  call far 26C9:0C9C
0FFE  31 C0           xor ax, ax
1000  89 46 FC        mov word ptr [bp - 4], ax
loc_1003:
1003  83 7E FE 01     cmp word ptr [bp - 2], 1
1007  75 C1           jne 0xfca
loc_1009:
1009  8D 7E E6        lea di, [bp - 0x1a]
100C  16              push ss
100D  57              push di
100E  C4 7E 0A        les di, ptr [bp + 0xa]
1011  06              push es
1012  57              push di
1013  6A 14           push 0x14
1015  9A 6D 0B C9 26  call far 26C9:0B6D
101A  C9              leave
101B  CA 04 00        retf 4

; ---- routine 1B55:101E  (found by: call, far)
sub_101E:
101E  C8 1A 01 00     enter 0x11a, 0
1022  A0 64 DD        mov al, byte ptr [0xdd64]
1025  A2 20 0F        mov byte ptr [0xf20], al
1028  8D BE E6 FE     lea di, [bp - 0x11a]
102C  16              push ss
102D  57              push di
102E  FF 76 0C        push word ptr [bp + 0xc]
1031  FF 76 0A        push word ptr [bp + 0xa]
1034  0E              push cs
1035  E8 5D FF        call 0xf95
1038  8D 7E EA        lea di, [bp - 0x16]
103B  16              push ss
103C  57              push di
103D  6A 14           push 0x14
103F  9A 6D 0B C9 26  call far 26C9:0B6D
1044  8A 46 EA        mov al, byte ptr [bp - 0x16]
1047  30 E4           xor ah, ah
1049  3D 01 00        cmp ax, 1
104C  72 5B           jb 0x10a9
104E  89 46 E8        mov word ptr [bp - 0x18], ax
1051  EB 03           jmp 0x1056
loc_1053:
1053  FF 4E E8        dec word ptr [bp - 0x18]
loc_1056:
1056  8B 7E E8        mov di, word ptr [bp - 0x18]
1059  80 7B EA 2C     cmp byte ptr [bp + di - 0x16], 0x2c
105D  B0 00           mov al, 0
105F  75 01           jne 0x1062
1061  40              inc ax
loc_1062:
1062  88 46 E7        mov byte ptr [bp - 0x19], al
1065  8A 46 E7        mov al, byte ptr [bp - 0x19]
1068  98              cwde
1069  8B F8           mov di, ax
106B  8A 85 20 0F     mov al, byte ptr [di + 0xf20]
106F  50              push ax
1070  8D BE E6 FE     lea di, [bp - 0x11a]
1074  16              push ss
1075  57              push di
1076  8B 7E E8        mov di, word ptr [bp - 0x18]
1079  8A 43 EA        mov al, byte ptr [bp + di - 0x16]
107C  50              push ax
107D  9A 6F 0C C9 26  call far 26C9:0C6F
1082  8A 46 08        mov al, byte ptr [bp + 8]
1085  50              push ax
1086  8A 46 E7        mov al, byte ptr [bp - 0x19]
1089  30 E4           xor ah, ah
108B  03 46 06        add ax, word ptr [bp + 6]
108E  50              push ax
108F  BF 5C DD        mov di, 0xdd5c
1092  1E              push ds
1093  57              push di
1094  9A 1B 04 2A 23  call far 232A:041B
1099  80 7E E7 00     cmp byte ptr [bp - 0x19], 0
109D  75 04           jne 0x10a3
109F  83 6E 06 02     sub word ptr [bp + 6], 2
loc_10A3:
10A3  83 7E E8 01     cmp word ptr [bp - 0x18], 1
10A7  75 AA           jne 0x1053
loc_10A9:
10A9  C9              leave
10AA  CA 08 00        retf 8
; data (not reached as code), 2 bytes
10AD                  db 01 2D   ; .-

; ---- routine 1B55:10AF  (found by: call)
sub_10AF:
10AF  C8 0A 03 00     enter 0x30a, 0
10B3  6B 46 06 3E     imul ax, word ptr [bp + 6], 0x3e
10B7  C4 3E C2 D7     les di, ptr [0xd7c2]
10BB  03 F8           add di, ax
10BD  81 C7 C2 FF     add di, 0xffc2
10C1  89 7E F6        mov word ptr [bp - 0xa], di
10C4  8C 46 F8        mov word ptr [bp - 8], es
10C7  31 C0           xor ax, ax
10C9  89 46 FC        mov word ptr [bp - 4], ax
10CC  89 46 FE        mov word ptr [bp - 2], ax
10CF  C7 46 FA 01 00  mov word ptr [bp - 6], 1
10D4  EB 03           jmp 0x10d9
loc_10D6:
10D6  FF 46 FA        inc word ptr [bp - 6]
loc_10D9:
10D9  8B 46 FA        mov ax, word ptr [bp - 6]
10DC  D1 E0           shl ax, 1
10DE  C4 7E F6        les di, ptr [bp - 0xa]
10E1  03 F8           add di, ax
10E3  26 FF 75 FE     push word ptr es:[di - 2]
10E7  0E              push cs
10E8  E8 9E 3E        call 0x4f89
10EB  08 C0           or al, al
10ED  75 2A           jne 0x1119
10EF  8B 46 FA        mov ax, word ptr [bp - 6]
10F2  D1 E0           shl ax, 1
10F4  C4 7E F6        les di, ptr [bp - 0xa]
10F7  03 F8           add di, ax
10F9  26 8B 45 FE     mov ax, word ptr es:[di - 2]
10FD  C1 E0 03        shl ax, 3
1100  C4 3E BA D7     les di, ptr [0xd7ba]
1104  03 F8           add di, ax
1106  26 8A 45 06     mov al, byte ptr es:[di + 6]
110A  30 E4           xor ah, ah
110C  8B F8           mov di, ax
110E  8A 85 22 0F     mov al, byte ptr [di + 0xf22]
1112  30 E4           xor ah, ah
1114  8B F8           mov di, ax
1116  FE 43 FC        inc byte ptr [bp + di - 4]
loc_1119:
1119  83 7E FA 0B     cmp word ptr [bp - 6], 0xb
111D  75 B7           jne 0x10d6
111F  8D BE F6 FE     lea di, [bp - 0x10a]
1123  16              push ss
1124  57              push di
1125  8A 46 FD        mov al, byte ptr [bp - 3]
1128  30 E4           xor ah, ah
112A  31 D2           xor dx, dx
112C  52              push dx
112D  50              push ax
112E  9A C9 07 2A 23  call far 232A:07C9
1133  BF AD 10        mov di, 0x10ad
1136  0E              push cs
1137  57              push di
1138  9A D2 0B C9 26  call far 26C9:0BD2
113D  8D BE F6 FD     lea di, [bp - 0x20a]
1141  16              push ss
1142  57              push di
1143  8A 46 FE        mov al, byte ptr [bp - 2]
1146  30 E4           xor ah, ah
1148  31 D2           xor dx, dx
114A  52              push dx
114B  50              push ax
114C  9A C9 07 2A 23  call far 232A:07C9
1151  9A D2 0B C9 26  call far 26C9:0BD2
1156  BF AD 10        mov di, 0x10ad
1159  0E              push cs
115A  57              push di
115B  9A D2 0B C9 26  call far 26C9:0BD2
1160  8D BE F6 FC     lea di, [bp - 0x30a]
1164  16              push ss
1165  57              push di
1166  8A 46 FF        mov al, byte ptr [bp - 1]
1169  30 E4           xor ah, ah
116B  31 D2           xor dx, dx
116D  52              push dx
116E  50              push ax
116F  9A C9 07 2A 23  call far 232A:07C9
1174  9A D2 0B C9 26  call far 26C9:0BD2
1179  C4 7E 08        les di, ptr [bp + 8]
117C  06              push es
117D  57              push di
117E  6A 0A           push 0xa
1180  9A 6D 0B C9 26  call far 26C9:0B6D
1185  C9              leave
1186  CA 02 00        retf 2
; data (not reached as code), 57 bytes
1189                  pstr 'Round 1'
1191                  pstr 'Round 2'
1199                  pstr 'Round 3'
11A1                  pstr 'Quarter Finals'
11B0                  pstr 'Semi Finals'
11BC                  pstr 'Final'

; ---- routine 1B55:11C2  (found by: call)
sub_11C2:
11C2  55              push bp
11C3  89 E5           mov bp, sp
11C5  C4 7E 06        les di, ptr [bp + 6]
11C8  26 C6 05 00     mov byte ptr es:[di], 0
11CC  8B 7E 04        mov di, word ptr [bp + 4]
11CF  36 8A 45 06     mov al, byte ptr ss:[di + 6]
11D3  3C 0A           cmp al, 0xa
11D5  74 0C           je 0x11e3
11D7  3C 0C           cmp al, 0xc
11D9  74 08           je 0x11e3
11DB  3C 08           cmp al, 8
11DD  74 04           je 0x11e3
11DF  3C 17           cmp al, 0x17
11E1  75 14           jne 0x11f7
loc_11E3:
11E3  BF 89 11        mov di, 0x1189
11E6  0E              push cs
11E7  57              push di
11E8  C4 7E 06        les di, ptr [bp + 6]
11EB  06              push es
11EC  57              push di
11ED  6A 0F           push 0xf
11EF  9A 6D 0B C9 26  call far 26C9:0B6D
11F4  E9 B4 00        jmp 0x12ab
loc_11F7:
11F7  3C 14           cmp al, 0x14
11F9  74 0C           je 0x1207
11FB  3C 16           cmp al, 0x16
11FD  74 08           je 0x1207
11FF  3C 0E           cmp al, 0xe
1201  74 04           je 0x1207
1203  3C 1D           cmp al, 0x1d
1205  75 14           jne 0x121b
loc_1207:
1207  BF 91 11        mov di, 0x1191
120A  0E              push cs
120B  57              push di
120C  C4 7E 06        les di, ptr [bp + 6]
120F  06              push es
1210  57              push di
1211  6A 0F           push 0xf
1213  9A 6D 0B C9 26  call far 26C9:0B6D
1218  E9 90 00        jmp 0x12ab
loc_121B:
121B  3C 12           cmp al, 0x12
121D  74 04           je 0x1223
121F  3C 23           cmp al, 0x23
1221  75 13           jne 0x1236
loc_1223:
1223  BF 99 11        mov di, 0x1199
1226  0E              push cs
1227  57              push di
1228  C4 7E 06        les di, ptr [bp + 6]
122B  06              push es
122C  57              push di
122D  6A 0F           push 0xf
122F  9A 6D 0B C9 26  call far 26C9:0B6D
1234  EB 75           jmp 0x12ab
loc_1236:
1236  3C 1B           cmp al, 0x1b
1238  74 0C           je 0x1246
123A  3C 21           cmp al, 0x21
123C  74 08           je 0x1246
123E  3C 19           cmp al, 0x19
1240  74 04           je 0x1246
1242  3C 29           cmp al, 0x29
1244  75 13           jne 0x1259
loc_1246:
1246  BF A1 11        mov di, 0x11a1
1249  0E              push cs
124A  57              push di
124B  C4 7E 06        les di, ptr [bp + 6]
124E  06              push es
124F  57              push di
1250  6A 0F           push 0xf
1252  9A 6D 0B C9 26  call far 26C9:0B6D
1257  EB 52           jmp 0x12ab
loc_1259:
1259  3C 27           cmp al, 0x27
125B  74 0C           je 0x1269
125D  3C 2B           cmp al, 0x2b
125F  74 08           je 0x1269
1261  3C 1F           cmp al, 0x1f
1263  74 04           je 0x1269
1265  3C 2E           cmp al, 0x2e
1267  75 13           jne 0x127c
loc_1269:
1269  BF B0 11        mov di, 0x11b0
126C  0E              push cs
126D  57              push di
126E  C4 7E 06        les di, ptr [bp + 6]
1271  06              push es
1272  57              push di
1273  6A 0F           push 0xf
1275  9A 6D 0B C9 26  call far 26C9:0B6D
127A  EB 2F           jmp 0x12ab
loc_127C:
127C  3C 30           cmp al, 0x30
127E  74 10           je 0x1290
1280  3C 35           cmp al, 0x35
1282  74 0C           je 0x1290
1284  3C 25           cmp al, 0x25
1286  74 08           je 0x1290
1288  3C 33           cmp al, 0x33
128A  74 04           je 0x1290
128C  3C 39           cmp al, 0x39
128E  75 1B           jne 0x12ab
loc_1290:
1290  8B 7E 04        mov di, word ptr [bp + 4]
1293  36 80 7D 08 07  cmp byte ptr ss:[di + 8], 7
1298  75 11           jne 0x12ab
129A  BF BC 11        mov di, 0x11bc
129D  0E              push cs
129E  57              push di
129F  C4 7E 06        les di, ptr [bp + 6]
12A2  06              push es
12A3  57              push di
12A4  6A 0F           push 0xf
12A6  9A 6D 0B C9 26  call far 26C9:0B6D
loc_12AB:
12AB  C9              leave
12AC  C2 02 00        ret 2
; data (not reached as code), 2 bytes
12AF                  db 01 20   ; . 

; ---- routine 1B55:12B1  (found by: call, far)
sub_12B1:
12B1  C8 00 02 00     enter 0x200, 0
12B5  8D BE 00 FF     lea di, [bp - 0x100]
12B9  16              push ss
12BA  57              push di
12BB  8A 46 08        mov al, byte ptr [bp + 8]
12BE  98              cwde
12BF  8B F8           mov di, ax
12C1  C1 E7 04        shl di, 4
12C4  81 C7 30 0F     add di, 0xf30
12C8  1E              push ds
12C9  57              push di
12CA  9A 53 0B C9 26  call far 26C9:0B53
12CF  BF AF 12        mov di, 0x12af
12D2  0E              push cs
12D3  57              push di
12D4  9A D2 0B C9 26  call far 26C9:0BD2
12D9  8D BE 00 FE     lea di, [bp - 0x200]
12DD  16              push ss
12DE  57              push di
12DF  55              push bp
12E0  E8 DF FE        call 0x11c2
12E3  9A D2 0B C9 26  call far 26C9:0BD2
12E8  C4 7E 0A        les di, ptr [bp + 0xa]
12EB  06              push es
12EC  57              push di
12ED  6A 1E           push 0x1e
12EF  9A 6D 0B C9 26  call far 26C9:0B6D
12F4  C9              leave
12F5  CA 04 00        retf 4
; data (not reached as code), 60 bytes
12F8                  pstr 'QF L#1'
12FF                  pstr 'QF L#2'
1306                  pstr 'SF L#1'
130D                  pstr 'SF L#2'
1314                  pstr 'Final'
131A                  pstr 'Final L#1'
1324                  pstr 'Final L#2'
132E                  pstr 'Group'

; ---- routine 1B55:1334  (found by: call)
sub_1334:
1334  55              push bp
1335  89 E5           mov bp, sp
1337  C4 7E 06        les di, ptr [bp + 6]
133A  26 C6 05 00     mov byte ptr es:[di], 0
133E  8B 7E 04        mov di, word ptr [bp + 4]
1341  36 80 7D 08 06  cmp byte ptr ss:[di + 8], 6
1346  75 03           jne 0x134b
1348  E9 AC 00        jmp 0x13f7
loc_134B:
134B  36 8A 45 06     mov al, byte ptr ss:[di + 6]
134F  3C 1B           cmp al, 0x1b
1351  75 14           jne 0x1367
1353  BF F8 12        mov di, 0x12f8
1356  0E              push cs
1357  57              push di
1358  C4 7E 06        les di, ptr [bp + 6]
135B  06              push es
135C  57              push di
135D  6A 0A           push 0xa
135F  9A 6D 0B C9 26  call far 26C9:0B6D
1364  E9 8E 00        jmp 0x13f5
loc_1367:
1367  3C 21           cmp al, 0x21
1369  75 13           jne 0x137e
136B  BF FF 12        mov di, 0x12ff
136E  0E              push cs
136F  57              push di
1370  C4 7E 06        les di, ptr [bp + 6]
1373  06              push es
1374  57              push di
1375  6A 0A           push 0xa
1377  9A 6D 0B C9 26  call far 26C9:0B6D
137C  EB 77           jmp 0x13f5
loc_137E:
137E  3C 27           cmp al, 0x27
1380  75 13           jne 0x1395
1382  BF 06 13        mov di, 0x1306
1385  0E              push cs
1386  57              push di
1387  C4 7E 06        les di, ptr [bp + 6]
138A  06              push es
138B  57              push di
138C  6A 0A           push 0xa
138E  9A 6D 0B C9 26  call far 26C9:0B6D
1393  EB 60           jmp 0x13f5
loc_1395:
1395  3C 2B           cmp al, 0x2b
1397  75 13           jne 0x13ac
1399  BF 0D 13        mov di, 0x130d
139C  0E              push cs
139D  57              push di
139E  C4 7E 06        les di, ptr [bp + 6]
13A1  06              push es
13A2  57              push di
13A3  6A 0A           push 0xa
13A5  9A 6D 0B C9 26  call far 26C9:0B6D
13AA  EB 49           jmp 0x13f5
loc_13AC:
13AC  3C 30           cmp al, 0x30
13AE  75 30           jne 0x13e0
13B0  8B 7E 04        mov di, word ptr [bp + 4]
13B3  36 80 7D 08 07  cmp byte ptr ss:[di + 8], 7
13B8  75 13           jne 0x13cd
13BA  BF 14 13        mov di, 0x1314
13BD  0E              push cs
13BE  57              push di
13BF  C4 7E 06        les di, ptr [bp + 6]
13C2  06              push es
13C3  57              push di
13C4  6A 0A           push 0xa
13C6  9A 6D 0B C9 26  call far 26C9:0B6D
13CB  EB 11           jmp 0x13de
loc_13CD:
13CD  BF 1A 13        mov di, 0x131a
13D0  0E              push cs
13D1  57              push di
13D2  C4 7E 06        les di, ptr [bp + 6]
13D5  06              push es
13D6  57              push di
13D7  6A 0A           push 0xa
13D9  9A 6D 0B C9 26  call far 26C9:0B6D
loc_13DE:
13DE  EB 15           jmp 0x13f5
loc_13E0:
13E0  3C 35           cmp al, 0x35
13E2  75 11           jne 0x13f5
13E4  BF 24 13        mov di, 0x1324
13E7  0E              push cs
13E8  57              push di
13E9  C4 7E 06        les di, ptr [bp + 6]
13EC  06              push es
13ED  57              push di
13EE  6A 0A           push 0xa
13F0  9A 6D 0B C9 26  call far 26C9:0B6D
loc_13F5:
13F5  EB 2E           jmp 0x1425
loc_13F7:
13F7  8B 7E 04        mov di, word ptr [bp + 4]
13FA  36 80 7D 06 39  cmp byte ptr ss:[di + 6], 0x39
13FF  74 13           je 0x1414
1401  BF 2E 13        mov di, 0x132e
1404  0E              push cs
1405  57              push di
1406  C4 7E 06        les di, ptr [bp + 6]
1409  06              push es
140A  57              push di
140B  6A 0A           push 0xa
140D  9A 6D 0B C9 26  call far 26C9:0B6D
1412  EB 11           jmp 0x1425
loc_1414:
1414  BF 14 13        mov di, 0x1314
1417  0E              push cs
1418  57              push di
1419  C4 7E 06        les di, ptr [bp + 6]
141C  06              push es
141D  57              push di
141E  6A 0A           push 0xa
1420  9A 6D 0B C9 26  call far 26C9:0B6D
loc_1425:
1425  C9              leave
1426  C2 02 00        ret 2
; data (not reached as code), 2 bytes
1429                  db 01 20   ; . 

; ---- routine 1B55:142B  (found by: call, far)
sub_142B:
142B  C8 16 02 00     enter 0x216, 0
142F  8D BE EA FE     lea di, [bp - 0x116]
1433  16              push ss
1434  57              push di
1435  8A 46 08        mov al, byte ptr [bp + 8]
1438  98              cwde
1439  8B F8           mov di, ax
143B  C1 E7 04        shl di, 4
143E  81 C7 30 0F     add di, 0xf30
1442  1E              push ds
1443  57              push di
1444  9A 53 0B C9 26  call far 26C9:0B53
1449  BF 29 14        mov di, 0x1429
144C  0E              push cs
144D  57              push di
144E  9A D2 0B C9 26  call far 26C9:0BD2
1453  8D 7E EA        lea di, [bp - 0x16]
1456  16              push ss
1457  57              push di
1458  6A 14           push 0x14
145A  9A 6D 0B C9 26  call far 26C9:0B6D
145F  8A 46 06        mov al, byte ptr [bp + 6]
1462  30 E4           xor ah, ah
1464  8B F8           mov di, ax
1466  8A 85 6A A2     mov al, byte ptr [di - 0x5d96]
146A  3A 46 08        cmp al, byte ptr [bp + 8]
146D  75 31           jne 0x14a0
146F  8D BE EA FE     lea di, [bp - 0x116]
1473  16              push ss
1474  57              push di
1475  8D 7E EA        lea di, [bp - 0x16]
1478  16              push ss
1479  57              push di
147A  9A 53 0B C9 26  call far 26C9:0B53
147F  8A 46 06        mov al, byte ptr [bp + 6]
1482  30 E4           xor ah, ah
1484  8B F8           mov di, ax
1486  C1 E7 03        shl di, 3
1489  81 C7 26 88     add di, 0x8826
148D  1E              push ds
148E  57              push di
148F  9A D2 0B C9 26  call far 26C9:0BD2
1494  8D 7E EA        lea di, [bp - 0x16]
1497  16              push ss
1498  57              push di
1499  6A 14           push 0x14
149B  9A 6D 0B C9 26  call far 26C9:0B6D
loc_14A0:
14A0  8A 46 06        mov al, byte ptr [bp + 6]
14A3  30 E4           xor ah, ah
14A5  8B F8           mov di, ax
14A7  80 BD 6A A2 05  cmp byte ptr [di - 0x5d96], 5
14AC  75 6F           jne 0x151d
14AE  8A 46 08        mov al, byte ptr [bp + 8]
14B1  3C 06           cmp al, 6
14B3  72 68           jb 0x151d
14B5  3C 08           cmp al, 8
14B7  77 64           ja 0x151d
14B9  80 7E 06 16     cmp byte ptr [bp + 6], 0x16
14BD  77 33           ja 0x14f2
14BF  8D BE EA FE     lea di, [bp - 0x116]
14C3  16              push ss
14C4  57              push di
14C5  8D 7E EA        lea di, [bp - 0x16]
14C8  16              push ss
14C9  57              push di
14CA  9A 53 0B C9 26  call far 26C9:0B53
14CF  8A 46 06        mov al, byte ptr [bp + 6]
14D2  30 E4           xor ah, ah
14D4  8B F8           mov di, ax
14D6  C1 E7 03        shl di, 3
14D9  81 C7 26 88     add di, 0x8826
14DD  1E              push ds
14DE  57              push di
14DF  9A D2 0B C9 26  call far 26C9:0BD2
14E4  8D 7E EA        lea di, [bp - 0x16]
14E7  16              push ss
14E8  57              push di
14E9  6A 14           push 0x14
14EB  9A 6D 0B C9 26  call far 26C9:0B6D
14F0  EB 2B           jmp 0x151d
loc_14F2:
14F2  8D BE EA FD     lea di, [bp - 0x216]
14F6  16              push ss
14F7  57              push di
14F8  8D 7E EA        lea di, [bp - 0x16]
14FB  16              push ss
14FC  57              push di
14FD  9A 53 0B C9 26  call far 26C9:0B53
1502  8D BE EA FE     lea di, [bp - 0x116]
1506  16              push ss
1507  57              push di
1508  55              push bp
1509  E8 28 FE        call 0x1334
150C  9A D2 0B C9 26  call far 26C9:0BD2
1511  8D 7E EA        lea di, [bp - 0x16]
1514  16              push ss
1515  57              push di
1516  6A 14           push 0x14
1518  9A 6D 0B C9 26  call far 26C9:0B6D
loc_151D:
151D  8A 46 EA        mov al, byte ptr [bp - 0x16]
1520  30 E4           xor ah, ah
1522  8B F8           mov di, ax
1524  80 7B EA 20     cmp byte ptr [bp + di - 0x16], 0x20
1528  75 03           jne 0x152d
152A  FE 4E EA        dec byte ptr [bp - 0x16]
loc_152D:
152D  8D 7E EA        lea di, [bp - 0x16]
1530  16              push ss
1531  57              push di
1532  C4 7E 0A        les di, ptr [bp + 0xa]
1535  06              push es
1536  57              push di
1537  6A 14           push 0x14
1539  9A 6D 0B C9 26  call far 26C9:0B6D
153E  C9              leave
153F  CA 04 00        retf 4

