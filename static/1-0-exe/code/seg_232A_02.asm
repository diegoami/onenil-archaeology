; 1-0.EXE (One-Nil 96), code segment 232A (image offsets 232A0..2459F), part 2 of 2
; packed 1-0.EXE sha256 89ff9c5f238f24e81a0c2440a46cdd8997280a65fc3cc3d97cb974f55280a80a (LZEXE 0.91)
; unpacked (tools/static/unlzexe.py) sha256 887ed2a92767950e5309b2052409f875668605939b69e00737aa3047022b9f51
; tool: capstone 5.0.9 (pip package; core library 5.0.1280) (CS_ARCH_X86, CS_MODE_16), recursive descent from the entry point, far calls and near calls/jumps, then routine prologues (55 89 E5 / 55 8B EC / C8 iw 00) in what remains; tools/static/listing.py
; addresses are SEGMENT:OFFSET with SEGMENT the image paragraph before relocation; image offset = SEGMENT*16+OFFSET
; ---- routine 232A:099B  (found by: call, far)
sub_099B:
099B  55              push bp
099C  89 E5           mov bp, sp
loc_099E:
099E  9A 17 0C BC 24  call far 24BC:0C17
09A3  80 3E 88 DE CD  cmp byte ptr [0xde88], 0xcd
09A8  75 0C           jne 0x9b6
09AA  6A 01           push 1
09AC  6A 50           push 0x50
09AE  6A 01           push 1
09B0  6A 18           push 0x18
09B2  0E              push cs
09B3  E8 B3 FE        call 0x869
loc_09B6:
09B6  80 3E 88 DE CD  cmp byte ptr [0xde88], 0xcd
09BB  74 E1           je 0x99e
09BD  C9              leave
09BE  CB              retf

; ---- routine 232A:09BF  (found by: call)
sub_09BF:
09BF  C8 02 00 00     enter 2, 0
09C3  8B 46 06        mov ax, word ptr [bp + 6]
09C6  D1 E0           shl ax, 1
09C8  8B D0           mov dx, ax
09CA  69 46 08 A0 00  imul ax, word ptr [bp + 8], 0xa0
09CF  C4 3E 58 DD     les di, ptr [0xdd58]
09D3  03 F8           add di, ax
09D5  03 FA           add di, dx
09D7  26 8B 85 5E FF  mov ax, word ptr es:[di - 0xa2]
09DC  89 46 FE        mov word ptr [bp - 2], ax
loc_09DF:
09DF  9A 58 0C BC 24  call far 24BC:0C58
09E4  08 C0           or al, al
09E6  75 56           jne 0xa3e
09E8  C4 3E 26 DE     les di, ptr [0xde26]
09EC  26 8B 05        mov ax, word ptr es:[di]
09EF  31 D2           xor dx, dx
09F1  B9 03 00        mov cx, 3
09F4  F7 F1           div cx
09F6  D0 E8           shr al, 1
09F8  73 1E           jae 0xa18
09FA  8B 4E FE        mov cx, word ptr [bp - 2]
09FD  8B 46 06        mov ax, word ptr [bp + 6]
0A00  D1 E0           shl ax, 1
0A02  8B D0           mov dx, ax
0A04  69 46 08 A0 00  imul ax, word ptr [bp + 8], 0xa0
0A09  C4 3E 58 DD     les di, ptr [0xdd58]
0A0D  03 F8           add di, ax
0A0F  03 FA           add di, dx
0A11  26 89 8D 5E FF  mov word ptr es:[di - 0xa2], cx
0A16  EB 24           jmp 0xa3c
loc_0A18:
0A18  8B 46 FE        mov ax, word ptr [bp - 2]
0A1B  25 00 F0        and ax, 0xf000
0A1E  0D 02 0F        or ax, 0xf02
0A21  8B C8           mov cx, ax
0A23  8B 46 06        mov ax, word ptr [bp + 6]
0A26  D1 E0           shl ax, 1
0A28  8B D0           mov dx, ax
0A2A  69 46 08 A0 00  imul ax, word ptr [bp + 8], 0xa0
0A2F  C4 3E 58 DD     les di, ptr [0xdd58]
0A33  03 F8           add di, ax
0A35  03 FA           add di, dx
0A37  26 89 8D 5E FF  mov word ptr es:[di - 0xa2], cx
loc_0A3C:
0A3C  EB A1           jmp 0x9df
loc_0A3E:
0A3E  8B 4E FE        mov cx, word ptr [bp - 2]
0A41  8B 46 06        mov ax, word ptr [bp + 6]
0A44  D1 E0           shl ax, 1
0A46  8B D0           mov dx, ax
0A48  69 46 08 A0 00  imul ax, word ptr [bp + 8], 0xa0
0A4D  C4 3E 58 DD     les di, ptr [0xdd58]
0A51  03 F8           add di, ax
0A53  03 FA           add di, dx
0A55  26 89 8D 5E FF  mov word ptr es:[di - 0xa2], cx
0A5A  C9              leave
0A5B  C2 06 00        ret 6
; data (not reached as code), 2 bytes
0A5E                  db 01 20   ; . 

; ---- routine 232A:0A60  (found by: call)
sub_0A60:
0A60  C8 00 01 00     enter 0x100, 0
0A64  C7 06 64 DD 06 00 mov word ptr [0xdd64], 6
0A6A  8B 7E 04        mov di, word ptr [bp + 4]
0A6D  36 C4 7D 0E     les di, ptr ss:[di + 0xe]
0A71  26 8A 45 01     mov al, byte ptr es:[di + 1]
0A75  50              push ax
0A76  9A 86 19 C9 26  call far 26C9:1986
0A7B  8B 7E 04        mov di, word ptr [bp + 4]
0A7E  36 C4 7D 0E     les di, ptr ss:[di + 0xe]
0A82  26 88 45 01     mov byte ptr es:[di + 1], al
0A86  8B 7E 04        mov di, word ptr [bp + 4]
0A89  36 8A 45 08     mov al, byte ptr ss:[di + 8]
0A8D  30 E4           xor ah, ah
0A8F  8B D0           mov dx, ax
0A91  36 8B 45 FC     mov ax, word ptr ss:[di - 4]
0A95  2B C2           sub ax, dx
0A97  40              inc ax
0A98  99              cdq
0A99  52              push dx
0A9A  50              push ax
0A9B  6A 00           push 0
0A9D  6A 01           push 1
0A9F  9A C0 04 BC 24  call far 24BC:04C0
0AA4  8B 7E 04        mov di, word ptr [bp + 4]
0AA7  36 88 45 FE     mov byte ptr ss:[di - 2], al
0AAB  8B 7E 04        mov di, word ptr [bp + 4]
0AAE  36 C4 7D 0E     les di, ptr ss:[di + 0xe]
0AB2  26 80 3D 00     cmp byte ptr es:[di], 0
0AB6  76 3B           jbe 0xaf3
0AB8  8D BE 00 FF     lea di, [bp - 0x100]
0ABC  16              push ss
0ABD  57              push di
0ABE  8B 7E 04        mov di, word ptr [bp + 4]
0AC1  36 C4 7D 0E     les di, ptr ss:[di + 0xe]
0AC5  06              push es
0AC6  57              push di
0AC7  8B 7E 04        mov di, word ptr [bp + 4]
0ACA  36 8A 45 FE     mov al, byte ptr ss:[di - 2]
0ACE  30 E4           xor ah, ah
0AD0  50              push ax
0AD1  36 8A 45 08     mov al, byte ptr ss:[di + 8]
0AD5  30 E4           xor ah, ah
0AD7  50              push ax
0AD8  9A 91 0B C9 26  call far 26C9:0B91
0ADD  8B 7E 04        mov di, word ptr [bp + 4]
0AE0  36 8A 45 06     mov al, byte ptr ss:[di + 6]
0AE4  50              push ax
0AE5  36 8A 45 0A     mov al, byte ptr ss:[di + 0xa]
0AE9  50              push ax
0AEA  BF 58 DD        mov di, 0xdd58
0AED  1E              push ds
0AEE  57              push di
0AEF  0E              push cs
0AF0  E8 AA F8        call 0x39d
loc_0AF3:
0AF3  8B 7E 04        mov di, word ptr [bp + 4]
0AF6  36 C4 7D 0E     les di, ptr ss:[di + 0xe]
0AFA  26 8A 05        mov al, byte ptr es:[di]
0AFD  8B 7E 04        mov di, word ptr [bp + 4]
0B00  36 3A 45 08     cmp al, byte ptr ss:[di + 8]
0B04  73 4F           jae 0xb55
0B06  8B 7E 04        mov di, word ptr [bp + 4]
0B09  36 C4 7D 0E     les di, ptr ss:[di + 0xe]
0B0D  26 8A 05        mov al, byte ptr es:[di]
0B10  30 E4           xor ah, ah
0B12  8B D0           mov dx, ax
0B14  8B 7E 04        mov di, word ptr [bp + 4]
0B17  36 8A 45 08     mov al, byte ptr ss:[di + 8]
0B1B  30 E4           xor ah, ah
0B1D  2B C2           sub ax, dx
0B1F  36 88 85 FC FD  mov byte ptr ss:[di - 0x204], al
0B24  81 C7 FC FD     add di, 0xfdfc
0B28  16              push ss
0B29  57              push di
0B2A  8B 7E 04        mov di, word ptr [bp + 4]
0B2D  36 8A 45 06     mov al, byte ptr ss:[di + 6]
0B31  50              push ax
0B32  8B 7E 04        mov di, word ptr [bp + 4]
0B35  36 C4 7D 0E     les di, ptr ss:[di + 0xe]
0B39  26 8A 05        mov al, byte ptr es:[di]
0B3C  30 E4           xor ah, ah
0B3E  8B D0           mov dx, ax
0B40  8B 7E 04        mov di, word ptr [bp + 4]
0B43  36 8A 45 0A     mov al, byte ptr ss:[di + 0xa]
0B47  30 E4           xor ah, ah
0B49  03 C2           add ax, dx
0B4B  50              push ax
0B4C  BF 58 DD        mov di, 0xdd58
0B4F  1E              push ds
0B50  57              push di
0B51  0E              push cs
0B52  E8 48 F8        call 0x39d
loc_0B55:
0B55  8B 7E 04        mov di, word ptr [bp + 4]
0B58  36 C4 7D 0E     les di, ptr ss:[di + 0xe]
0B5C  26 8A 05        mov al, byte ptr es:[di]
0B5F  30 E4           xor ah, ah
0B61  8B 7E 04        mov di, word ptr [bp + 4]
0B64  36 3B 45 FC     cmp ax, word ptr ss:[di - 4]
0B68  7D 4C           jge 0xbb6
0B6A  BF 5E 0A        mov di, 0xa5e
0B6D  0E              push cs
0B6E  57              push di
0B6F  8B 7E 04        mov di, word ptr [bp + 4]
0B72  36 8A 45 06     mov al, byte ptr ss:[di + 6]
0B76  50              push ax
0B77  36 8A 45 08     mov al, byte ptr ss:[di + 8]
0B7B  30 E4           xor ah, ah
0B7D  8B D0           mov dx, ax
0B7F  36 8A 45 0A     mov al, byte ptr ss:[di + 0xa]
0B83  30 E4           xor ah, ah
0B85  03 C2           add ax, dx
0B87  48              dec ax
0B88  99              cdq
0B89  52              push dx
0B8A  50              push ax
0B8B  8B 7E 04        mov di, word ptr [bp + 4]
0B8E  36 C4 7D 0E     les di, ptr ss:[di + 0xe]
0B92  26 8A 05        mov al, byte ptr es:[di]
0B95  30 E4           xor ah, ah
0B97  8B D0           mov dx, ax
0B99  8B 7E 04        mov di, word ptr [bp + 4]
0B9C  36 8A 45 0A     mov al, byte ptr ss:[di + 0xa]
0BA0  30 E4           xor ah, ah
0BA2  03 C2           add ax, dx
0BA4  99              cdq
0BA5  52              push dx
0BA6  50              push ax
0BA7  9A FA 04 BC 24  call far 24BC:04FA
0BAC  50              push ax
0BAD  BF 58 DD        mov di, 0xdd58
0BB0  1E              push ds
0BB1  57              push di
0BB2  0E              push cs
0BB3  E8 E7 F7        call 0x39d
loc_0BB6:
0BB6  C9              leave
0BB7  C2 02 00        ret 2

; ---- routine 232A:0BBA  (found by: call)
sub_0BBA:
0BBA  C8 00 01 00     enter 0x100, 0
0BBE  8B 7E 04        mov di, word ptr [bp + 4]
0BC1  36 8A 45 0C     mov al, byte ptr ss:[di + 0xc]
0BC5  30 E4           xor ah, ah
0BC7  36 3B 45 FC     cmp ax, word ptr ss:[di - 4]
0BCB  7E 58           jle 0xc25
0BCD  80 3E 32 A3 00  cmp byte ptr [0xa332], 0
0BD2  75 15           jne 0xbe9
0BD4  8B 7E 04        mov di, word ptr [bp + 4]
0BD7  36 C4 7D 0E     les di, ptr ss:[di + 0xe]
0BDB  26 8A 05        mov al, byte ptr es:[di]
0BDE  30 E4           xor ah, ah
0BE0  8B 7E 04        mov di, word ptr [bp + 4]
0BE3  36 3B 45 FC     cmp ax, word ptr ss:[di - 4]
0BE7  7D 3C           jge 0xc25
loc_0BE9:
0BE9  8B 7E 04        mov di, word ptr [bp + 4]
0BEC  36 C4 7D 0E     les di, ptr ss:[di + 0xe]
0BF0  26 8A 05        mov al, byte ptr es:[di]
0BF3  8B 7E 04        mov di, word ptr [bp + 4]
0BF6  36 3A 45 0C     cmp al, byte ptr ss:[di + 0xc]
0BFA  73 29           jae 0xc25
0BFC  8D BE 00 FF     lea di, [bp - 0x100]
0C00  16              push ss
0C01  57              push di
0C02  8A 46 06        mov al, byte ptr [bp + 6]
0C05  50              push ax
0C06  9A 6F 0C C9 26  call far 26C9:0C6F
0C0B  8B 7E 04        mov di, word ptr [bp + 4]
0C0E  36 C4 7D 0E     les di, ptr ss:[di + 0xe]
0C12  06              push es
0C13  57              push di
0C14  68 FF 00        push 0xff
0C17  8B 7E 04        mov di, word ptr [bp + 4]
0C1A  36 FF 75 FC     push word ptr ss:[di - 4]
0C1E  9A 9C 0C C9 26  call far 26C9:0C9C
0C23  EB 16           jmp 0xc3b
loc_0C25:
0C25  8A 56 06        mov dl, byte ptr [bp + 6]
0C28  8B 7E 04        mov di, word ptr [bp + 4]
0C2B  36 8B 45 FC     mov ax, word ptr ss:[di - 4]
0C2F  8B 7E 04        mov di, word ptr [bp + 4]
0C32  36 C4 7D 0E     les di, ptr ss:[di + 0xe]
0C36  03 F8           add di, ax
0C38  26 88 15        mov byte ptr es:[di], dl
loc_0C3B:
0C3B  8B 7E 04        mov di, word ptr [bp + 4]
0C3E  36 8A 45 0C     mov al, byte ptr ss:[di + 0xc]
0C42  30 E4           xor ah, ah
0C44  36 3B 45 FC     cmp ax, word ptr ss:[di - 4]
0C48  75 0E           jne 0xc58
0C4A  36 8A 45 0C     mov al, byte ptr ss:[di + 0xc]
0C4E  8B 7E 04        mov di, word ptr [bp + 4]
0C51  36 C4 7D 0E     les di, ptr ss:[di + 0xe]
0C55  26 88 05        mov byte ptr es:[di], al
loc_0C58:
0C58  C9              leave
0C59  C2 04 00        ret 4

; ---- routine 232A:0C5C  (found by: far)
sub_0C5C:
0C5C  C8 06 03 00     enter 0x306, 0
0C60  8A 46 0A        mov al, byte ptr [bp + 0xa]
0C63  30 E4           xor ah, ah
0C65  8B D0           mov dx, ax
0C67  8A 46 08        mov al, byte ptr [bp + 8]
0C6A  30 E4           xor ah, ah
0C6C  2B C2           sub ax, dx
0C6E  88 46 08        mov byte ptr [bp + 8], al
0C71  8D BE FD FD     lea di, [bp - 0x203]
0C75  16              push ss
0C76  57              push di
0C77  68 FF 00        push 0xff
0C7A  68 B1 00        push 0xb1
0C7D  9A 22 02 BC 24  call far 24BC:0222
0C82  C4 7E 0E        les di, ptr [bp + 0xe]
0C85  06              push es
0C86  57              push di
0C87  8D BE FC FE     lea di, [bp - 0x104]
0C8B  16              push ss
0C8C  57              push di
0C8D  68 FF 00        push 0xff
0C90  9A 6D 0B C9 26  call far 26C9:0B6D
0C95  C7 46 FC 01 00  mov word ptr [bp - 4], 1
0C9A  C6 86 FB FD 01  mov byte ptr [bp - 0x205], 1
loc_0C9F:
0C9F  55              push bp
0CA0  E8 BD FD        call 0xa60
0CA3  8A 46 06        mov al, byte ptr [bp + 6]
0CA6  30 E4           xor ah, ah
0CA8  50              push ax
0CA9  8A 46 FE        mov al, byte ptr [bp - 2]
0CAC  30 E4           xor ah, ah
0CAE  8B D0           mov dx, ax
0CB0  8A 46 0A        mov al, byte ptr [bp + 0xa]
0CB3  30 E4           xor ah, ah
0CB5  03 46 FC        add ax, word ptr [bp - 4]
0CB8  2B C2           sub ax, dx
0CBA  50              push ax
0CBB  55              push bp
0CBC  E8 00 FD        call 0x9bf
0CBF  0E              push cs
0CC0  E8 D8 FC        call 0x99b
0CC3  A0 88 DE        mov al, byte ptr [0xde88]
0CC6  3C 20           cmp al, 0x20
0CC8  72 66           jb 0xd30
0CCA  3C 7E           cmp al, 0x7e
0CCC  77 62           ja 0xd30
0CCE  80 BE FB FD 00  cmp byte ptr [bp - 0x205], 0
0CD3  74 24           je 0xcf9
0CD5  8D BE FA FC     lea di, [bp - 0x306]
0CD9  16              push ss
0CDA  57              push di
0CDB  A0 88 DE        mov al, byte ptr [0xde88]
0CDE  50              push ax
0CDF  9A 86 19 C9 26  call far 26C9:1986
0CE4  50              push ax
0CE5  9A 6F 0C C9 26  call far 26C9:0C6F
0CEA  C4 7E 0E        les di, ptr [bp + 0xe]
0CED  06              push es
0CEE  57              push di
0CEF  68 FF 00        push 0xff
0CF2  9A 6D 0B C9 26  call far 26C9:0B6D
0CF7  EB 27           jmp 0xd20
loc_0CF9:
0CF9  8B 46 FC        mov ax, word ptr [bp - 4]
0CFC  48              dec ax
0CFD  C4 7E 0E        les di, ptr [bp + 0xe]
0D00  03 F8           add di, ax
0D02  26 80 3D 20     cmp byte ptr es:[di], 0x20
0D06  75 10           jne 0xd18
0D08  A0 88 DE        mov al, byte ptr [0xde88]
0D0B  50              push ax
0D0C  9A 86 19 C9 26  call far 26C9:1986
0D11  50              push ax
0D12  55              push bp
0D13  E8 A4 FE        call 0xbba
0D16  EB 08           jmp 0xd20
loc_0D18:
0D18  A0 88 DE        mov al, byte ptr [0xde88]
0D1B  50              push ax
0D1C  55              push bp
0D1D  E8 9A FE        call 0xbba
loc_0D20:
0D20  8A 46 0C        mov al, byte ptr [bp + 0xc]
0D23  30 E4           xor ah, ah
0D25  3B 46 FC        cmp ax, word ptr [bp - 4]
0D28  7E 03           jle 0xd2d
0D2A  FF 46 FC        inc word ptr [bp - 4]
loc_0D2D:
0D2D  E9 E3 00        jmp 0xe13
loc_0D30:
0D30  3C 0E           cmp al, 0xe
0D32  75 12           jne 0xd46
0D34  C4 7E 0E        les di, ptr [bp + 0xe]
0D37  06              push es
0D38  57              push di
0D39  FF 76 FC        push word ptr [bp - 4]
0D3C  6A 01           push 1
0D3E  9A FB 0C C9 26  call far 26C9:0CFB
0D43  E9 CD 00        jmp 0xe13
loc_0D46:
0D46  3C 0F           cmp al, 0xf
0D48  75 1B           jne 0xd65
0D4A  83 7E FC 01     cmp word ptr [bp - 4], 1
0D4E  7E 03           jle 0xd53
0D50  FF 4E FC        dec word ptr [bp - 4]
loc_0D53:
0D53  C4 7E 0E        les di, ptr [bp + 0xe]
0D56  06              push es
0D57  57              push di
0D58  FF 76 FC        push word ptr [bp - 4]
0D5B  6A 01           push 1
0D5D  9A FB 0C C9 26  call far 26C9:0CFB
0D62  E9 AE 00        jmp 0xe13
loc_0D65:
0D65  3C 01           cmp al, 1
0D67  75 16           jne 0xd7f
0D69  8D BE FC FE     lea di, [bp - 0x104]
0D6D  16              push ss
0D6E  57              push di
0D6F  C4 7E 0E        les di, ptr [bp + 0xe]
0D72  06              push es
0D73  57              push di
0D74  68 FF 00        push 0xff
0D77  9A 6D 0B C9 26  call far 26C9:0B6D
0D7C  E9 94 00        jmp 0xe13
loc_0D7F:
0D7F  3C 0D           cmp al, 0xd
0D81  75 10           jne 0xd93
0D83  80 3E 32 A3 00  cmp byte ptr [0xa332], 0
0D88  B0 00           mov al, 0
0D8A  75 01           jne 0xd8d
0D8C  40              inc ax
loc_0D8D:
0D8D  A2 32 A3        mov byte ptr [0xa332], al
0D90  E9 80 00        jmp 0xe13
loc_0D93:
0D93  3C 07           cmp al, 7
0D95  75 29           jne 0xdc0
0D97  83 7E FC 01     cmp word ptr [bp - 4], 1
0D9B  7E 21           jle 0xdbe
0D9D  FF 4E FC        dec word ptr [bp - 4]
0DA0  C4 7E 0E        les di, ptr [bp + 0xe]
0DA3  26 8A 05        mov al, byte ptr es:[di]
0DA6  30 E4           xor ah, ah
0DA8  3B 46 FC        cmp ax, word ptr [bp - 4]
0DAB  75 11           jne 0xdbe
0DAD  8B 46 FC        mov ax, word ptr [bp - 4]
0DB0  03 F8           add di, ax
0DB2  26 80 3D 20     cmp byte ptr es:[di], 0x20
0DB6  75 06           jne 0xdbe
0DB8  C4 7E 0E        les di, ptr [bp + 0xe]
0DBB  26 FE 0D        dec byte ptr es:[di]
loc_0DBE:
0DBE  EB 53           jmp 0xe13
loc_0DC0:
0DC0  3C 08           cmp al, 8
0DC2  75 23           jne 0xde7
0DC4  8A 46 0C        mov al, byte ptr [bp + 0xc]
0DC7  30 E4           xor ah, ah
0DC9  3B 46 FC        cmp ax, word ptr [bp - 4]
0DCC  7E 17           jle 0xde5
0DCE  C4 7E 0E        les di, ptr [bp + 0xe]
0DD1  26 8A 05        mov al, byte ptr es:[di]
0DD4  30 E4           xor ah, ah
0DD6  40              inc ax
0DD7  3B 46 FC        cmp ax, word ptr [bp - 4]
0DDA  75 06           jne 0xde2
0DDC  6A 20           push 0x20
0DDE  55              push bp
0DDF  E8 D8 FD        call 0xbba
loc_0DE2:
0DE2  FF 46 FC        inc word ptr [bp - 4]
loc_0DE5:
0DE5  EB 2C           jmp 0xe13
loc_0DE7:
0DE7  3C 09           cmp al, 9
0DE9  75 07           jne 0xdf2
0DEB  C7 46 FC 01 00  mov word ptr [bp - 4], 1
0DF0  EB 21           jmp 0xe13
loc_0DF2:
0DF2  3C 0A           cmp al, 0xa
0DF4  75 1D           jne 0xe13
0DF6  C4 7E 0E        les di, ptr [bp + 0xe]
0DF9  26 8A 05        mov al, byte ptr es:[di]
0DFC  30 E4           xor ah, ah
0DFE  40              inc ax
0DFF  99              cdq
0E00  52              push dx
0E01  50              push ax
0E02  8A 46 0C        mov al, byte ptr [bp + 0xc]
0E05  30 E4           xor ah, ah
0E07  31 D2           xor dx, dx
0E09  52              push dx
0E0A  50              push ax
0E0B  9A FA 04 BC 24  call far 24BC:04FA
0E10  89 46 FC        mov word ptr [bp - 4], ax
loc_0E13:
0E13  C6 86 FB FD 00  mov byte ptr [bp - 0x205], 0
0E18  A0 88 DE        mov al, byte ptr [0xde88]
0E1B  3C 01           cmp al, 1
0E1D  73 03           jae 0xe22
0E1F  E9 7D FE        jmp 0xc9f
loc_0E22:
0E22  3C 02           cmp al, 2
0E24  76 03           jbe 0xe29
0E26  E9 76 FE        jmp 0xc9f
loc_0E29:
0E29  C4 7E 0E        les di, ptr [bp + 0xe]
0E2C  26 8A 05        mov al, byte ptr es:[di]
0E2F  30 E4           xor ah, ah
0E31  03 F8           add di, ax
0E33  26 80 3D 20     cmp byte ptr es:[di], 0x20
0E37  75 0E           jne 0xe47
0E39  C4 7E 0E        les di, ptr [bp + 0xe]
0E3C  26 80 3D 00     cmp byte ptr es:[di], 0
0E40  76 05           jbe 0xe47
0E42  26 FE 0D        dec byte ptr es:[di]
0E45  EB E2           jmp 0xe29
loc_0E47:
0E47  C7 46 FC 01 00  mov word ptr [bp - 4], 1
0E4C  55              push bp
0E4D  E8 10 FC        call 0xa60
0E50  80 3E 88 DE 01  cmp byte ptr [0xde88], 1
0E55  75 05           jne 0xe5c
0E57  C6 06 88 DE 00  mov byte ptr [0xde88], 0
loc_0E5C:
0E5C  C9              leave
0E5D  CA 0C 00        retf 0xc

; ---- routine 232A:0E60  (found by: call, far)
sub_0E60:
0E60  55              push bp
0E61  89 E5           mov bp, sp
0E63  A1 88 DE        mov ax, word ptr [0xde88]
0E66  3D 05 00        cmp ax, 5
0E69  74 05           je 0xe70
0E6B  3D 07 00        cmp ax, 7
0E6E  75 0E           jne 0xe7e
loc_0E70:
0E70  C4 7E 08        les di, ptr [bp + 8]
0E73  26 80 3D 01     cmp byte ptr es:[di], 1
0E77  76 03           jbe 0xe7c
0E79  26 FE 0D        dec byte ptr es:[di]
loc_0E7C:
0E7C  EB 42           jmp 0xec0
loc_0E7E:
0E7E  3D 06 00        cmp ax, 6
0E81  74 05           je 0xe88
0E83  3D 08 00        cmp ax, 8
0E86  75 12           jne 0xe9a
loc_0E88:
0E88  C4 7E 08        les di, ptr [bp + 8]
0E8B  26 8A 05        mov al, byte ptr es:[di]
0E8E  30 E4           xor ah, ah
0E90  3B 46 06        cmp ax, word ptr [bp + 6]
0E93  7D 03           jge 0xe98
0E95  26 FE 05        inc byte ptr es:[di]
loc_0E98:
0E98  EB 26           jmp 0xec0
loc_0E9A:
0E9A  3D 09 00        cmp ax, 9
0E9D  74 05           je 0xea4
0E9F  3D 0B 00        cmp ax, 0xb
0EA2  75 09           jne 0xead
loc_0EA4:
0EA4  C4 7E 08        les di, ptr [bp + 8]
0EA7  26 C6 05 01     mov byte ptr es:[di], 1
0EAB  EB 13           jmp 0xec0
loc_0EAD:
0EAD  3D 0A 00        cmp ax, 0xa
0EB0  74 05           je 0xeb7
0EB2  3D 0C 00        cmp ax, 0xc
0EB5  75 09           jne 0xec0
loc_0EB7:
0EB7  8A 46 06        mov al, byte ptr [bp + 6]
0EBA  C4 7E 08        les di, ptr [bp + 8]
0EBD  26 88 05        mov byte ptr es:[di], al
loc_0EC0:
0EC0  C9              leave
0EC1  CA 06 00        retf 6

; ---- routine 232A:0EC4  (found by: call, far)
sub_0EC4:
0EC4  55              push bp
0EC5  89 E5           mov bp, sp
0EC7  A1 88 DE        mov ax, word ptr [0xde88]
0ECA  3D 05 00        cmp ax, 5
0ECD  74 05           je 0xed4
0ECF  3D 07 00        cmp ax, 7
0ED2  75 14           jne 0xee8
loc_0ED4:
0ED4  C4 7E 08        les di, ptr [bp + 8]
0ED7  06              push es
0ED8  57              push di
0ED9  6A 01           push 1
0EDB  8A 46 06        mov al, byte ptr [bp + 6]
0EDE  50              push ax
0EDF  6A FF           push -1
0EE1  9A 8C 04 BC 24  call far 24BC:048C
0EE6  EB 2A           jmp 0xf12
loc_0EE8:
0EE8  3D 06 00        cmp ax, 6
0EEB  74 05           je 0xef2
0EED  3D 08 00        cmp ax, 8
0EF0  75 14           jne 0xf06
loc_0EF2:
0EF2  C4 7E 08        les di, ptr [bp + 8]
0EF5  06              push es
0EF6  57              push di
0EF7  6A 01           push 1
0EF9  8A 46 06        mov al, byte ptr [bp + 6]
0EFC  50              push ax
0EFD  6A 01           push 1
0EFF  9A 8C 04 BC 24  call far 24BC:048C
0F04  EB 0C           jmp 0xf12
loc_0F06:
0F06  C4 7E 08        les di, ptr [bp + 8]
0F09  06              push es
0F0A  57              push di
0F0B  FF 76 06        push word ptr [bp + 6]
0F0E  0E              push cs
0F0F  E8 4E FF        call 0xe60
loc_0F12:
0F12  C9              leave
0F13  CA 06 00        retf 6

; ---- routine 232A:0F16  (found by: far)
sub_0F16:
0F16  55              push bp
0F17  89 E5           mov bp, sp
0F19  A1 88 DE        mov ax, word ptr [0xde88]
0F1C  3D 05 00        cmp ax, 5
0F1F  74 05           je 0xf26
0F21  3D 07 00        cmp ax, 7
0F24  75 0E           jne 0xf34
loc_0F26:
0F26  C4 7E 08        les di, ptr [bp + 8]
0F29  26 83 3D 01     cmp word ptr es:[di], 1
0F2D  7E 03           jle 0xf32
0F2F  26 FF 0D        dec word ptr es:[di]
loc_0F32:
0F32  EB 53           jmp 0xf87
loc_0F34:
0F34  3D 06 00        cmp ax, 6
0F37  74 05           je 0xf3e
0F39  3D 08 00        cmp ax, 8
0F3C  75 22           jne 0xf60
loc_0F3E:
0F3E  8B 46 06        mov ax, word ptr [bp + 6]
0F41  31 D2           xor dx, dx
0F43  8B C8           mov cx, ax
0F45  8B DA           mov bx, dx
0F47  C4 7E 08        les di, ptr [bp + 8]
0F4A  26 8B 05        mov ax, word ptr es:[di]
0F4D  99              cdq
0F4E  3B D3           cmp dx, bx
0F50  7C 06           jl 0xf58
0F52  7F 0A           jg 0xf5e
0F54  3B C1           cmp ax, cx
0F56  73 06           jae 0xf5e
loc_0F58:
0F58  C4 7E 08        les di, ptr [bp + 8]
0F5B  26 FF 05        inc word ptr es:[di]
loc_0F5E:
0F5E  EB 27           jmp 0xf87
loc_0F60:
0F60  3D 09 00        cmp ax, 9
0F63  74 05           je 0xf6a
0F65  3D 0B 00        cmp ax, 0xb
0F68  75 0A           jne 0xf74
loc_0F6A:
0F6A  C4 7E 08        les di, ptr [bp + 8]
0F6D  26 C7 05 01 00  mov word ptr es:[di], 1
0F72  EB 13           jmp 0xf87
loc_0F74:
0F74  3D 0A 00        cmp ax, 0xa
0F77  74 05           je 0xf7e
0F79  3D 0C 00        cmp ax, 0xc
0F7C  75 09           jne 0xf87
loc_0F7E:
0F7E  8B 46 06        mov ax, word ptr [bp + 6]
0F81  C4 7E 08        les di, ptr [bp + 8]
0F84  26 89 05        mov word ptr es:[di], ax
loc_0F87:
0F87  C9              leave
0F88  CA 06 00        retf 6

; ---- routine 232A:0F8B  (found by: far)
sub_0F8B:
0F8B  55              push bp
0F8C  89 E5           mov bp, sp
0F8E  C4 3E 5C DD     les di, ptr [0xdd5c]
0F92  06              push es
0F93  57              push di
0F94  C4 3E 58 DD     les di, ptr [0xdd58]
0F98  06              push es
0F99  57              push di
0F9A  68 A0 0F        push 0xfa0
0F9D  9A 12 0A C9 26  call far 26C9:0A12
0FA2  0E              push cs
0FA3  E8 F5 F9        call 0x99b
0FA6  C4 7E 08        les di, ptr [bp + 8]
0FA9  06              push es
0FAA  57              push di
0FAB  FF 76 06        push word ptr [bp + 6]
0FAE  0E              push cs
0FAF  E8 12 FF        call 0xec4
0FB2  C9              leave
0FB3  CA 06 00        retf 6

; ---- routine 232A:0FB6  (found by: call)
sub_0FB6:
0FB6  55              push bp
0FB7  89 E5           mov bp, sp
0FB9  8A 46 08        mov al, byte ptr [bp + 8]
0FBC  8B 7E 04        mov di, word ptr [bp + 4]
0FBF  36 C4 7D 0E     les di, ptr ss:[di + 0xe]
0FC3  26 88 05        mov byte ptr es:[di], al
0FC6  8B 46 06        mov ax, word ptr [bp + 6]
0FC9  8B 7E 04        mov di, word ptr [bp + 4]
0FCC  36 C4 7D 0A     les di, ptr ss:[di + 0xa]
0FD0  26 89 05        mov word ptr es:[di], ax
0FD3  C9              leave
0FD4  C2 06 00        ret 6

; ---- routine 232A:0FD7  (found by: far)
sub_0FD7:
0FD7  C8 02 00 00     enter 2, 0
0FDB  C4 7E 0E        les di, ptr [bp + 0xe]
0FDE  26 8A 05        mov al, byte ptr es:[di]
0FE1  30 E4           xor ah, ah
0FE3  C4 7E 0A        les di, ptr [bp + 0xa]
0FE6  26 03 05        add ax, word ptr es:[di]
0FE9  48              dec ax
0FEA  89 46 FE        mov word ptr [bp - 2], ax
0FED  A0 88 DE        mov al, byte ptr [0xde88]
0FF0  3C 06           cmp al, 6
0FF2  75 40           jne 0x1034
0FF4  8B 46 FE        mov ax, word ptr [bp - 2]
0FF7  3B 46 06        cmp ax, word ptr [bp + 6]
0FFA  73 35           jae 0x1031
0FFC  C4 7E 0E        les di, ptr [bp + 0xe]
0FFF  26 8A 05        mov al, byte ptr es:[di]
1002  30 E4           xor ah, ah
1004  3B 46 08        cmp ax, word ptr [bp + 8]
1007  75 14           jne 0x101d
1009  26 8A 05        mov al, byte ptr es:[di]
100C  30 E4           xor ah, ah
100E  50              push ax
100F  C4 7E 0A        les di, ptr [bp + 0xa]
1012  26 8B 05        mov ax, word ptr es:[di]
1015  40              inc ax
1016  50              push ax
1017  55              push bp
1018  E8 9B FF        call 0xfb6
101B  EB 14           jmp 0x1031
loc_101D:
101D  C4 7E 0E        les di, ptr [bp + 0xe]
1020  26 8A 05        mov al, byte ptr es:[di]
1023  30 E4           xor ah, ah
1025  40              inc ax
1026  50              push ax
1027  C4 7E 0A        les di, ptr [bp + 0xa]
102A  26 FF 35        push word ptr es:[di]
102D  55              push bp
102E  E8 85 FF        call 0xfb6
loc_1031:
1031  E9 52 01        jmp 0x1186
loc_1034:
1034  3C 05           cmp al, 5
1036  75 3A           jne 0x1072
1038  83 7E FE 01     cmp word ptr [bp - 2], 1
103C  76 31           jbe 0x106f
103E  C4 7E 0E        les di, ptr [bp + 0xe]
1041  26 80 3D 01     cmp byte ptr es:[di], 1
1045  75 14           jne 0x105b
1047  26 8A 05        mov al, byte ptr es:[di]
104A  30 E4           xor ah, ah
104C  50              push ax
104D  C4 7E 0A        les di, ptr [bp + 0xa]
1050  26 8B 05        mov ax, word ptr es:[di]
1053  48              dec ax
1054  50              push ax
1055  55              push bp
1056  E8 5D FF        call 0xfb6
1059  EB 14           jmp 0x106f
loc_105B:
105B  C4 7E 0E        les di, ptr [bp + 0xe]
105E  26 8A 05        mov al, byte ptr es:[di]
1061  30 E4           xor ah, ah
1063  48              dec ax
1064  50              push ax
1065  C4 7E 0A        les di, ptr [bp + 0xa]
1068  26 FF 35        push word ptr es:[di]
106B  55              push bp
106C  E8 47 FF        call 0xfb6
loc_106F:
106F  E9 14 01        jmp 0x1186
loc_1072:
1072  3C 0B           cmp al, 0xb
1074  75 4B           jne 0x10c1
1076  C4 7E 0A        les di, ptr [bp + 0xa]
1079  26 83 3D 01     cmp word ptr es:[di], 1
107D  76 33           jbe 0x10b2
107F  8B 46 08        mov ax, word ptr [bp + 8]
1082  40              inc ax
1083  26 3B 05        cmp ax, word ptr es:[di]
1086  77 19           ja 0x10a1
1088  C4 7E 0E        les di, ptr [bp + 0xe]
108B  26 8A 05        mov al, byte ptr es:[di]
108E  30 E4           xor ah, ah
1090  50              push ax
1091  C4 7E 0A        les di, ptr [bp + 0xa]
1094  26 8B 05        mov ax, word ptr es:[di]
1097  2B 46 08        sub ax, word ptr [bp + 8]
109A  50              push ax
109B  55              push bp
109C  E8 17 FF        call 0xfb6
109F  EB 0F           jmp 0x10b0
loc_10A1:
10A1  C4 7E 0E        les di, ptr [bp + 0xe]
10A4  26 8A 05        mov al, byte ptr es:[di]
10A7  30 E4           xor ah, ah
10A9  50              push ax
10AA  6A 01           push 1
10AC  55              push bp
10AD  E8 06 FF        call 0xfb6
loc_10B0:
10B0  EB 0C           jmp 0x10be
loc_10B2:
10B2  6A 01           push 1
10B4  C4 7E 0A        les di, ptr [bp + 0xa]
10B7  26 FF 35        push word ptr es:[di]
10BA  55              push bp
10BB  E8 F8 FE        call 0xfb6
loc_10BE:
10BE  E9 C5 00        jmp 0x1186
loc_10C1:
10C1  3C 0C           cmp al, 0xc
10C3  75 6C           jne 0x1131
10C5  C4 7E 0A        les di, ptr [bp + 0xa]
10C8  26 8B 05        mov ax, word ptr es:[di]
10CB  03 46 08        add ax, word ptr [bp + 8]
10CE  48              dec ax
10CF  3B 46 06        cmp ax, word ptr [bp + 6]
10D2  73 3D           jae 0x1111
10D4  8B 46 08        mov ax, word ptr [bp + 8]
10D7  D1 E0           shl ax, 1
10D9  26 03 05        add ax, word ptr es:[di]
10DC  3B 46 06        cmp ax, word ptr [bp + 6]
10DF  77 19           ja 0x10fa
10E1  C4 7E 0E        les di, ptr [bp + 0xe]
10E4  26 8A 05        mov al, byte ptr es:[di]
10E7  30 E4           xor ah, ah
10E9  50              push ax
10EA  C4 7E 0A        les di, ptr [bp + 0xa]
10ED  26 8B 05        mov ax, word ptr es:[di]
10F0  03 46 08        add ax, word ptr [bp + 8]
10F3  50              push ax
10F4  55              push bp
10F5  E8 BE FE        call 0xfb6
10F8  EB 15           jmp 0x110f
loc_10FA:
10FA  C4 7E 0E        les di, ptr [bp + 0xe]
10FD  26 8A 05        mov al, byte ptr es:[di]
1100  30 E4           xor ah, ah
1102  50              push ax
1103  8B 46 06        mov ax, word ptr [bp + 6]
1106  2B 46 08        sub ax, word ptr [bp + 8]
1109  40              inc ax
110A  50              push ax
110B  55              push bp
110C  E8 A7 FE        call 0xfb6
loc_110F:
110F  EB 1E           jmp 0x112f
loc_1111:
1111  8B 46 06        mov ax, word ptr [bp + 6]
1114  31 D2           xor dx, dx
1116  52              push dx
1117  50              push ax
1118  8B 46 08        mov ax, word ptr [bp + 8]
111B  31 D2           xor dx, dx
111D  52              push dx
111E  50              push ax
111F  9A FA 04 BC 24  call far 24BC:04FA
1124  50              push ax
1125  C4 7E 0A        les di, ptr [bp + 0xa]
1128  26 FF 35        push word ptr es:[di]
112B  55              push bp
112C  E8 87 FE        call 0xfb6
loc_112F:
112F  EB 55           jmp 0x1186
loc_1131:
1131  3C 09           cmp al, 9
1133  75 0A           jne 0x113f
1135  6A 01           push 1
1137  6A 01           push 1
1139  55              push bp
113A  E8 79 FE        call 0xfb6
113D  EB 47           jmp 0x1186
loc_113F:
113F  3C 0A           cmp al, 0xa
1141  75 43           jne 0x1186
1143  8B 46 08        mov ax, word ptr [bp + 8]
1146  31 D2           xor dx, dx
1148  52              push dx
1149  50              push ax
114A  8B 46 06        mov ax, word ptr [bp + 6]
114D  31 D2           xor dx, dx
114F  52              push dx
1150  50              push ax
1151  9A FA 04 BC 24  call far 24BC:04FA
1156  50              push ax
1157  6A 00           push 0
1159  6A 01           push 1
115B  8B 46 06        mov ax, word ptr [bp + 6]
115E  31 D2           xor dx, dx
1160  8B C8           mov cx, ax
1162  8B DA           mov bx, dx
1164  8B 46 08        mov ax, word ptr [bp + 8]
1167  31 D2           xor dx, dx
1169  F7 D2           not dx
116B  F7 D8           neg ax
116D  83 DA FF        sbb dx, -1
1170  05 01 00        add ax, 1
1173  83 D2 00        adc dx, 0
1176  03 C1           add ax, cx
1178  13 D3           adc dx, bx
117A  52              push dx
117B  50              push ax
117C  9A C0 04 BC 24  call far 24BC:04C0
1181  50              push ax
1182  55              push bp
1183  E8 30 FE        call 0xfb6
loc_1186:
1186  C9              leave
1187  CA 0C 00        retf 0xc
; data (not reached as code), 10 bytes
118A                  pstr 'try again'

; ---- routine 232A:1194  (found by: far)
sub_1194:
1194  C8 02 00 00     enter 2, 0
1198  83 3E 02 DF 00  cmp word ptr [0xdf02], 0
119D  B0 00           mov al, 0
119F  74 01           je 0x11a2
11A1  40              inc ax
loc_11A2:
11A2  88 46 FF        mov byte ptr [bp - 1], al
11A5  83 3E 02 DF 00  cmp word ptr [0xdf02], 0
11AA  75 02           jne 0x11ae
11AC  EB 2E           jmp 0x11dc
loc_11AE:
11AE  81 3E 02 DF FF 00 cmp word ptr [0xdf02], 0xff
11B4  74 13           je 0x11c9
11B6  BF 8A 11        mov di, 0x118a
11B9  0E              push cs
11BA  57              push di
11BB  0E              push cs
11BC  E8 26 F5        call 0x6e5
11BF  08 C0           or al, al
11C1  74 06           je 0x11c9
11C3  C6 46 FF 01     mov byte ptr [bp - 1], 1
11C7  EB 13           jmp 0x11dc
loc_11C9:
11C9  80 7E 06 00     cmp byte ptr [bp + 6], 0
11CD  74 09           je 0x11d8
11CF  31 C0           xor ax, ax
11D1  9A 16 01 C9 26  call far 26C9:0116
11D6  EB 04           jmp 0x11dc
loc_11D8:
11D8  C6 46 FF 00     mov byte ptr [bp - 1], 0
loc_11DC:
11DC  8A 46 FF        mov al, byte ptr [bp - 1]
11DF  C9              leave
11E0  CA 02 00        retf 2

; ---- routine 232A:11E3  (found by: call, far)
sub_11E3:
11E3  C8 02 00 00     enter 2, 0
11E7  C4 7E 08        les di, ptr [bp + 8]
11EA  06              push es
11EB  57              push di
11EC  FF 76 06        push word ptr [bp + 6]
11EF  9A 6A 11 BC 24  call far 24BC:116A
11F4  83 3E 02 DF 00  cmp word ptr [0xdf02], 0
11F9  B0 00           mov al, 0
11FB  75 01           jne 0x11fe
11FD  40              inc ax
loc_11FE:
11FE  88 46 FF        mov byte ptr [bp - 1], al
1201  8A 46 FF        mov al, byte ptr [bp - 1]
1204  C9              leave
1205  CA 06 00        retf 6

; ---- routine 232A:1208  (found by: far)
sub_1208:
1208  55              push bp
1209  89 E5           mov bp, sp
120B  C4 7E 08        les di, ptr [bp + 8]
120E  06              push es
120F  57              push di
1210  FF 76 06        push word ptr [bp + 6]
1213  9A E1 11 BC 24  call far 24BC:11E1
1218  C9              leave
1219  CA 06 00        retf 6

; ---- routine 232A:121C  (found by: far)
sub_121C:
121C  C8 52 00 00     enter 0x52, 0
1220  8C D3           mov bx, ss
1222  8E C3           mov es, bx
1224  8C DB           mov bx, ds
1226  FC              cld
1227  8D 7E AE        lea di, [bp - 0x52]
122A  C5 76 06        lds si, ptr [bp + 6]
122D  AC              lodsb al, byte ptr [si]
122E  3C 50           cmp al, 0x50
1230  72 02           jb 0x1234
1232  B0 50           mov al, 0x50
loc_1234:
1234  AA              stosb byte ptr es:[di], al
1235  91              xchg cx, ax
1236  30 ED           xor ch, ch
1238  F3 A4           rep movsb byte ptr es:[di], byte ptr [si]
123A  8E DB           mov ds, bx
123C  8D 7E AE        lea di, [bp - 0x52]
123F  16              push ss
1240  57              push di
1241  9A 04 13 BC 24  call far 24BC:1304
1246  88 46 FF        mov byte ptr [bp - 1], al
1249  8A 46 FF        mov al, byte ptr [bp - 1]
124C  C9              leave
124D  CA 04 00        retf 4

; ---- routine 232A:1250  (found by: far)
sub_1250:
1250  C8 52 00 00     enter 0x52, 0
1254  8C D3           mov bx, ss
1256  8E C3           mov es, bx
1258  8C DB           mov bx, ds
125A  FC              cld
125B  8D 7E AE        lea di, [bp - 0x52]
125E  C5 76 06        lds si, ptr [bp + 6]
1261  AC              lodsb al, byte ptr [si]
1262  3C 50           cmp al, 0x50
1264  72 02           jb 0x1268
1266  B0 50           mov al, 0x50
loc_1268:
1268  AA              stosb byte ptr es:[di], al
1269  91              xchg cx, ax
126A  30 ED           xor ch, ch
126C  F3 A4           rep movsb byte ptr es:[di], byte ptr [si]
126E  8E DB           mov ds, bx
1270  8D 7E AE        lea di, [bp - 0x52]
1273  16              push ss
1274  57              push di
1275  9A 41 13 BC 24  call far 24BC:1341
127A  88 46 FF        mov byte ptr [bp - 1], al
127D  8A 46 FF        mov al, byte ptr [bp - 1]
1280  C9              leave
1281  CA 04 00        retf 4

; ---- routine 232A:1284  (found by: call)
sub_1284:
1284  C8 52 00 00     enter 0x52, 0
1288  8C D3           mov bx, ss
128A  8E C3           mov es, bx
128C  8C DB           mov bx, ds
128E  FC              cld
128F  8D 7E AE        lea di, [bp - 0x52]
1292  C5 76 0C        lds si, ptr [bp + 0xc]
1295  AC              lodsb al, byte ptr [si]
1296  3C 50           cmp al, 0x50
1298  72 02           jb 0x129c
129A  B0 50           mov al, 0x50
loc_129C:
129C  AA              stosb byte ptr es:[di], al
129D  91              xchg cx, ax
129E  30 ED           xor ch, ch
12A0  F3 A4           rep movsb byte ptr es:[di], byte ptr [si]
12A2  8E DB           mov ds, bx
12A4  8D 7E AE        lea di, [bp - 0x52]
12A7  16              push ss
12A8  57              push di
12A9  C4 7E 08        les di, ptr [bp + 8]
12AC  06              push es
12AD  57              push di
12AE  FF 76 06        push word ptr [bp + 6]
12B1  9A 89 13 BC 24  call far 24BC:1389
12B6  88 46 FF        mov byte ptr [bp - 1], al
12B9  8A 46 FF        mov al, byte ptr [bp - 1]
12BC  C9              leave
12BD  CA 0A 00        retf 0xa

; ---- routine 232A:12C0  (found by: far)
sub_12C0:
12C0  55              push bp
12C1  89 E5           mov bp, sp
12C3  A1 1E DE        mov ax, word ptr [0xde1e]
12C6  8B 16 20 DE     mov dx, word ptr [0xde20]
12CA  A3 58 DD        mov word ptr [0xdd58], ax
12CD  89 16 5A DD     mov word ptr [0xdd5a], dx
12D1  A1 22 DE        mov ax, word ptr [0xde22]
12D4  8B 16 24 DE     mov dx, word ptr [0xde24]
12D8  A3 5C DD        mov word ptr [0xdd5c], ax
12DB  89 16 5E DD     mov word ptr [0xdd5e], dx
12DF  BF 60 DD        mov di, 0xdd60
12E2  1E              push ds
12E3  57              push di
12E4  68 A0 0F        push 0xfa0
12E7  9A 85 14 BC 24  call far 24BC:1485
12EC  E8 19 ED        call 8
12EF  E8 6C ED        call 0x5e
12F2  C9              leave
12F3  CB              retf
; data (not reached as code), 12 bytes
12F4                  db 00 00 00 00 00 00 00 00 00 00 00 00   ; ............
