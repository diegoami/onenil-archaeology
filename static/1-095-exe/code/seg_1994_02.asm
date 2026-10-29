; 1-095.EXE (One-Nil 95), code segment 1994 (image offsets 19940..1B50F), part 2 of 3
; packed 1-095.EXE sha256 f659fb2d334500d6901fc8d6a0f06c85c0ccda2eb4a3035ae3bb0a0004d79192 (LZEXE 0.91)
; unpacked (tools/static/unlzexe.py) sha256 8df646e017e0965a5d90a58181ca764219ad847833aad0b6cb58fc53372bfb2c
; tool: capstone 5.0.9 (pip package; core library 5.0.1280) (CS_ARCH_X86, CS_MODE_16), recursive descent from the entry point, far calls and near calls/jumps, then routine prologues (55 89 E5 / 55 8B EC / C8 iw 00) in what remains; tools/static/listing.py
; addresses are SEGMENT:OFFSET with SEGMENT the image paragraph before relocation; image offset = SEGMENT*16+OFFSET
; ---- routine 1994:09A3  (found by: far)
sub_09A3:
09A3  55              push bp
09A4  89 E5           mov bp, sp
09A6  8B 46 0C        mov ax, word ptr [bp + 0xc]
09A9  C4 7E 06        les di, ptr [bp + 6]
09AC  26 89 45 04     mov word ptr es:[di + 4], ax
09B0  26 81 7D 04 AE 0E cmp word ptr es:[di + 4], 0xeae
09B6  B0 00           mov al, 0
09B8  74 01           je 0x9bb
09BA  40              inc ax
loc_09BB:
09BB  98              cwde
09BC  8B F8           mov di, ax
09BE  8A 85 38 A3     mov al, byte ptr [di - 0x5cc8]
09C2  98              cwde
09C3  8B D0           mov dx, ax
09C5  8A 46 0B        mov al, byte ptr [bp + 0xb]
09C8  98              cwde
09C9  03 C2           add ax, dx
09CB  C4 7E 06        les di, ptr [bp + 6]
09CE  26 88 45 01     mov byte ptr es:[di + 1], al
09D2  8A 46 0A        mov al, byte ptr [bp + 0xa]
09D5  26 88 05        mov byte ptr es:[di], al
09D8  80 3E 74 D0 00  cmp byte ptr [0xd074], 0
09DD  75 06           jne 0x9e5
09DF  06              push es
09E0  57              push di
09E1  0E              push cs
09E2  E8 96 FE        call 0x87b
loc_09E5:
09E5  C9              leave
09E6  CA 08 00        retf 8

; ---- routine 1994:09E9  (found by: far)
sub_09E9:
09E9  55              push bp
09EA  89 E5           mov bp, sp
09EC  C4 7E 06        les di, ptr [bp + 6]
09EF  31 C0           xor ax, ax
09F1  26 89 45 0B     mov word ptr es:[di + 0xb], ax
09F5  26 C7 45 04 07 0F mov word ptr es:[di + 4], 0xf07
09FB  26 C6 45 0D 00  mov byte ptr es:[di + 0xd], 0
0A00  26 C6 45 0E 00  mov byte ptr es:[di + 0xe], 0
0A05  A1 2E 0D        mov ax, word ptr [0xd2e]
0A08  26 89 05        mov word ptr es:[di], ax
0A0B  26 8B 05        mov ax, word ptr es:[di]
0A0E  26 89 45 02     mov word ptr es:[di + 2], ax
0A12  C9              leave
0A13  CA 04 00        retf 4

; ---- routine 1994:0A16  (found by: far)
sub_0A16:
0A16  55              push bp
0A17  89 E5           mov bp, sp
0A19  C4 7E 06        les di, ptr [bp + 6]
0A1C  26 8B 45 02     mov ax, word ptr es:[di + 2]
0A20  3B 06 2E 0D     cmp ax, word ptr [0xd2e]
0A24  74 74           je 0xa9a
0A26  26 8B 45 02     mov ax, word ptr es:[di + 2]
0A2A  26 3B 05        cmp ax, word ptr es:[di]
0A2D  74 6B           je 0xa9a
0A2F  26 8A 45 03     mov al, byte ptr es:[di + 3]
0A33  98              cwde
0A34  D1 E0           shl ax, 1
0A36  8B D0           mov dx, ax
0A38  26 8A 45 02     mov al, byte ptr es:[di + 2]
0A3C  98              cwde
0A3D  69 C0 A0 00     imul ax, ax, 0xa0
0A41  C4 3E 8A D0     les di, ptr [0xd08a]
0A45  03 F8           add di, ax
0A47  03 FA           add di, dx
0A49  26 8A 85 0E 09  mov al, byte ptr es:[di + 0x90e]
0A4E  3C 07           cmp al, 7
0A50  74 04           je 0xa56
0A52  3C 09           cmp al, 9
0A54  75 44           jne 0xa9a
loc_0A56:
0A56  C4 7E 06        les di, ptr [bp + 6]
0A59  26 8A 45 03     mov al, byte ptr es:[di + 3]
0A5D  98              cwde
0A5E  D1 E0           shl ax, 1
0A60  8B D0           mov dx, ax
0A62  26 8A 45 02     mov al, byte ptr es:[di + 2]
0A66  98              cwde
0A67  69 C0 A0 00     imul ax, ax, 0xa0
0A6B  C4 3E 92 D0     les di, ptr [0xd092]
0A6F  03 F8           add di, ax
0A71  03 FA           add di, dx
0A73  26 8B 8D 0E 09  mov cx, word ptr es:[di + 0x90e]
0A78  C4 7E 06        les di, ptr [bp + 6]
0A7B  26 8A 45 03     mov al, byte ptr es:[di + 3]
0A7F  98              cwde
0A80  D1 E0           shl ax, 1
0A82  8B D0           mov dx, ax
0A84  26 8A 45 02     mov al, byte ptr es:[di + 2]
0A88  98              cwde
0A89  69 C0 A0 00     imul ax, ax, 0xa0
0A8D  C4 3E 8A D0     les di, ptr [0xd08a]
0A91  03 F8           add di, ax
0A93  03 FA           add di, dx
0A95  26 89 8D 0E 09  mov word ptr es:[di + 0x90e], cx
loc_0A9A:
0A9A  C4 7E 06        les di, ptr [bp + 6]
0A9D  26 8B 05        mov ax, word ptr es:[di]
0AA0  26 89 45 02     mov word ptr es:[di + 2], ax
0AA4  26 80 7D 0E 00  cmp byte ptr es:[di + 0xe], 0
0AA9  74 0B           je 0xab6
0AAB  06              push es
0AAC  57              push di
0AAD  0E              push cs
0AAE  E8 8E 00        call 0xb3f
0AB1  3D 02 00        cmp ax, 2
0AB4  77 04           ja 0xaba
loc_0AB6:
0AB6  B0 00           mov al, 0
0AB8  EB 02           jmp 0xabc
loc_0ABA:
0ABA  B0 01           mov al, 1
loc_0ABC:
0ABC  98              cwde
0ABD  8B F8           mov di, ax
0ABF  8A 85 70 0D     mov al, byte ptr [di + 0xd70]
0AC3  C4 7E 06        les di, ptr [bp + 6]
0AC6  26 88 45 04     mov byte ptr es:[di + 4], al
0ACA  26 8B 05        mov ax, word ptr es:[di]
0ACD  3B 06 2E 0D     cmp ax, word ptr [0xd2e]
0AD1  74 68           je 0xb3b
0AD3  26 8A 45 01     mov al, byte ptr es:[di + 1]
0AD7  98              cwde
0AD8  D1 E0           shl ax, 1
0ADA  8B D0           mov dx, ax
0ADC  26 8A 05        mov al, byte ptr es:[di]
0ADF  98              cwde
0AE0  69 C0 A0 00     imul ax, ax, 0xa0
0AE4  C4 3E 92 D0     les di, ptr [0xd092]
0AE8  03 F8           add di, ax
0AEA  03 FA           add di, dx
0AEC  26 8B 8D 0E 09  mov cx, word ptr es:[di + 0x90e]
0AF1  C4 7E 06        les di, ptr [bp + 6]
0AF4  26 8A 45 01     mov al, byte ptr es:[di + 1]
0AF8  98              cwde
0AF9  D1 E0           shl ax, 1
0AFB  8B D0           mov dx, ax
0AFD  26 8A 05        mov al, byte ptr es:[di]
0B00  98              cwde
0B01  69 C0 A0 00     imul ax, ax, 0xa0
0B05  C4 3E 8A D0     les di, ptr [0xd08a]
0B09  03 F8           add di, ax
0B0B  03 FA           add di, dx
0B0D  26 8B 85 0E 09  mov ax, word ptr es:[di + 0x90e]
0B12  3B C1           cmp ax, cx
0B14  75 25           jne 0xb3b
0B16  C4 7E 06        les di, ptr [bp + 6]
0B19  26 8B 4D 04     mov cx, word ptr es:[di + 4]
0B1D  26 8A 45 01     mov al, byte ptr es:[di + 1]
0B21  98              cwde
0B22  D1 E0           shl ax, 1
0B24  8B D0           mov dx, ax
0B26  26 8A 05        mov al, byte ptr es:[di]
0B29  98              cwde
0B2A  69 C0 A0 00     imul ax, ax, 0xa0
0B2E  C4 3E 8A D0     les di, ptr [0xd08a]
0B32  03 F8           add di, ax
0B34  03 FA           add di, dx
0B36  26 89 8D 0E 09  mov word ptr es:[di + 0x90e], cx
loc_0B3B:
0B3B  C9              leave
0B3C  CA 04 00        retf 4

; ---- routine 1994:0B3F  (found by: call, far)
sub_0B3F:
0B3F  C8 02 00 00     enter 2, 0
0B43  C4 7E 06        les di, ptr [bp + 6]
0B46  26 8B 45 07     mov ax, word ptr es:[di + 7]
0B4A  99              cdq
0B4B  31 D0           xor ax, dx
0B4D  29 D0           sub ax, dx
0B4F  8B C8           mov cx, ax
0B51  26 8B 45 09     mov ax, word ptr es:[di + 9]
0B55  99              cdq
0B56  31 D0           xor ax, dx
0B58  29 D0           sub ax, dx
0B5A  03 C1           add ax, cx
0B5C  99              cdq
0B5D  8B C8           mov cx, ax
0B5F  8B DA           mov bx, dx
0B61  26 8B 45 0B     mov ax, word ptr es:[di + 0xb]
0B65  31 D2           xor dx, dx
0B67  9A 2A 0A B9 26  call far 26B9:0A2A
0B6C  89 46 FE        mov word ptr [bp - 2], ax
0B6F  8B 46 FE        mov ax, word ptr [bp - 2]
0B72  C9              leave
0B73  CA 04 00        retf 4

; ---- routine 1994:0B76  (found by: far)
sub_0B76:
0B76  C8 02 00 00     enter 2, 0
0B7A  A0 DD D6        mov al, byte ptr [0xd6dd]
0B7D  30 E4           xor ah, ah
0B7F  8B D0           mov dx, ax
0B81  A0 DD D6        mov al, byte ptr [0xd6dd]
0B84  98              cwde
0B85  8B F8           mov di, ax
0B87  8A 85 58 0D     mov al, byte ptr [di + 0xd58]
0B8B  30 E4           xor ah, ah
0B8D  05 0B 00        add ax, 0xb
0B90  03 C2           add ax, dx
0B92  89 46 FE        mov word ptr [bp - 2], ax
0B95  8B 46 FE        mov ax, word ptr [bp - 2]
0B98  C9              leave
0B99  CB              retf
; data (not reached as code), 4 bytes
0B9A                  db 01 28 01 29   ; .(.)

; ---- routine 1994:0B9E  (found by: far)
sub_0B9E:
0B9E  C8 00 02 00     enter 0x200, 0
0BA2  83 7E 0E 00     cmp word ptr [bp + 0xe], 0
0BA6  75 4C           jne 0xbf4
0BA8  8D BE 00 FE     lea di, [bp - 0x200]
0BAC  16              push ss
0BAD  57              push di
0BAE  BF 9A 0B        mov di, 0xb9a
0BB1  0E              push cs
0BB2  57              push di
0BB3  9A 53 0B B9 26  call far 26B9:0B53
0BB8  8D BE 00 FF     lea di, [bp - 0x100]
0BBC  16              push ss
0BBD  57              push di
0BBE  8B 46 0C        mov ax, word ptr [bp + 0xc]
0BC1  31 D2           xor dx, dx
0BC3  52              push dx
0BC4  50              push ax
0BC5  8B 46 0A        mov ax, word ptr [bp + 0xa]
0BC8  31 D2           xor dx, dx
0BCA  52              push dx
0BCB  50              push ax
0BCC  9A 94 55 51 1B  call far 1B51:5594
0BD1  9A D2 0B B9 26  call far 26B9:0BD2
0BD6  BF 9C 0B        mov di, 0xb9c
0BD9  0E              push cs
0BDA  57              push di
0BDB  9A D2 0B B9 26  call far 26B9:0BD2
0BE0  8A 46 08        mov al, byte ptr [bp + 8]
0BE3  50              push ax
0BE4  8A 46 06        mov al, byte ptr [bp + 6]
0BE7  50              push ax
0BE8  BF 5C DD        mov di, 0xdd5c
0BEB  1E              push ds
0BEC  57              push di
0BED  9A 83 02 1A 23  call far 231A:0283
0BF2  EB 2B           jmp 0xc1f
loc_0BF4:
0BF4  8D BE 00 FF     lea di, [bp - 0x100]
0BF8  16              push ss
0BF9  57              push di
0BFA  8B 46 0C        mov ax, word ptr [bp + 0xc]
0BFD  31 D2           xor dx, dx
0BFF  52              push dx
0C00  50              push ax
0C01  8B 46 0A        mov ax, word ptr [bp + 0xa]
0C04  31 D2           xor dx, dx
0C06  52              push dx
0C07  50              push ax
0C08  9A 94 55 51 1B  call far 1B51:5594
0C0D  8A 46 08        mov al, byte ptr [bp + 8]
0C10  50              push ax
0C11  8A 46 06        mov al, byte ptr [bp + 6]
0C14  50              push ax
0C15  BF 5C DD        mov di, 0xdd5c
0C18  1E              push ds
0C19  57              push di
0C1A  9A 83 02 1A 23  call far 231A:0283
loc_0C1F:
0C1F  C9              leave
0C20  CA 0A 00        retf 0xa

; ---- routine 1994:0C23  (found by: call, far)
sub_0C23:
0C23  C8 06 00 00     enter 6, 0
0C27  6B 46 08 3E     imul ax, word ptr [bp + 8], 0x3e
0C2B  C4 3E C2 D7     les di, ptr [0xd7c2]
0C2F  03 F8           add di, ax
0C31  81 C7 C2 FF     add di, 0xffc2
0C35  89 7E FA        mov word ptr [bp - 6], di
0C38  8C 46 FC        mov word ptr [bp - 4], es
0C3B  8A 46 06        mov al, byte ptr [bp + 6]
0C3E  26 88 45 39     mov byte ptr es:[di + 0x39], al
0C42  C7 46 FE 01 00  mov word ptr [bp - 2], 1
0C47  EB 03           jmp 0xc4c
loc_0C49:
0C49  FF 46 FE        inc word ptr [bp - 2]
loc_0C4C:
0C4C  8B 46 FE        mov ax, word ptr [bp - 2]
0C4F  D1 E0           shl ax, 1
0C51  C4 7E FA        les di, ptr [bp - 6]
0C54  03 F8           add di, ax
0C56  26 83 7D FE 00  cmp word ptr es:[di - 2], 0
0C5B  74 13           je 0xc70
0C5D  8B 46 FE        mov ax, word ptr [bp - 2]
0C60  D1 E0           shl ax, 1
0C62  C4 7E FA        les di, ptr [bp - 6]
0C65  03 F8           add di, ax
0C67  26 FF 75 FE     push word ptr es:[di - 2]
0C6B  9A 5B 53 51 1B  call far 1B51:535B
loc_0C70:
0C70  83 7E FE 14     cmp word ptr [bp - 2], 0x14
0C74  75 D3           jne 0xc49
0C76  C9              leave
0C77  CA 04 00        retf 4

; ---- routine 1994:0C7A  (found by: far)
sub_0C7A:
0C7A  C8 08 00 00     enter 8, 0
0C7E  C6 46 FF 00     mov byte ptr [bp - 1], 0
0C82  EB 03           jmp 0xc87
loc_0C84:
0C84  FE 46 FF        inc byte ptr [bp - 1]
loc_0C87:
0C87  8A 46 FF        mov al, byte ptr [bp - 1]
0C8A  98              cwde
0C8B  8B F8           mov di, ax
0C8D  D1 E7           shl di, 1
0C8F  FF B5 E4 D6     push word ptr [di - 0x291c]
0C93  9A DA 0D 51 1B  call far 1B51:0DDA
0C98  08 C0           or al, al
0C9A  74 03           je 0xc9f
0C9C  E9 CF 00        jmp 0xd6e
loc_0C9F:
0C9F  8A 46 FF        mov al, byte ptr [bp - 1]
0CA2  98              cwde
0CA3  8B F8           mov di, ax
0CA5  D1 E7           shl di, 1
0CA7  6B 85 E4 D6 3E  imul ax, word ptr [di - 0x291c], 0x3e
0CAC  C4 3E C2 D7     les di, ptr [0xd7c2]
0CB0  03 F8           add di, ax
0CB2  81 C7 C2 FF     add di, 0xffc2
0CB6  89 7E F8        mov word ptr [bp - 8], di
0CB9  8C 46 FA        mov word ptr [bp - 6], es
0CBC  C7 46 FC 01 00  mov word ptr [bp - 4], 1
0CC1  EB 03           jmp 0xcc6
loc_0CC3:
0CC3  FF 46 FC        inc word ptr [bp - 4]
loc_0CC6:
0CC6  8B 46 FC        mov ax, word ptr [bp - 4]
0CC9  D1 E0           shl ax, 1
0CCB  C4 7E F8        les di, ptr [bp - 8]
0CCE  03 F8           add di, ax
0CD0  26 6B 45 FE 0F  imul ax, word ptr es:[di - 2], 0xf
0CD5  C4 3E BE D7     les di, ptr [0xd7be]
0CD9  03 F8           add di, ax
0CDB  26 C6 45 0A 00  mov byte ptr es:[di + 0xa], 0
0CE0  83 7E FC 14     cmp word ptr [bp - 4], 0x14
0CE4  75 DD           jne 0xcc3
0CE6  8A 46 FF        mov al, byte ptr [bp - 1]
0CE9  98              cwde
0CEA  8B F8           mov di, ax
0CEC  D1 E7           shl di, 1
0CEE  FF B5 E4 D6     push word ptr [di - 0x291c]
0CF2  8A 46 FF        mov al, byte ptr [bp - 1]
0CF5  98              cwde
0CF6  8B F8           mov di, ax
0CF8  D1 E7           shl di, 1
0CFA  8B BD E4 D6     mov di, word ptr [di - 0x291c]
0CFE  8A 85 85 D8     mov al, byte ptr [di - 0x277b]
0D02  30 E4           xor ah, ah
0D04  8B F8           mov di, ax
0D06  8A 85 F7 93     mov al, byte ptr [di - 0x6c09]
0D0A  50              push ax
0D0B  0E              push cs
0D0C  E8 14 FF        call 0xc23
0D0F  C4 7E F8        les di, ptr [bp - 8]
0D12  06              push es
0D13  57              push di
0D14  8A 46 FF        mov al, byte ptr [bp - 1]
0D17  98              cwde
0D18  8B F8           mov di, ax
0D1A  D1 E7           shl di, 1
0D1C  FF B5 E4 D6     push word ptr [di - 0x291c]
0D20  9A B8 76 51 1B  call far 1B51:76B8
0D25  C7 46 FC 01 00  mov word ptr [bp - 4], 1
0D2A  EB 03           jmp 0xd2f
loc_0D2C:
0D2C  FF 46 FC        inc word ptr [bp - 4]
loc_0D2F:
0D2F  8B 56 FC        mov dx, word ptr [bp - 4]
0D32  8A 46 FF        mov al, byte ptr [bp - 1]
0D35  98              cwde
0D36  8B F8           mov di, ax
0D38  D1 E7           shl di, 1
0D3A  8B BD E4 D6     mov di, word ptr [di - 0x291c]
0D3E  8A 85 85 D8     mov al, byte ptr [di - 0x277b]
0D42  30 E4           xor ah, ah
0D44  6B F8 0E        imul di, ax, 0xe
0D47  03 FA           add di, dx
0D49  8A 95 04 94     mov dl, byte ptr [di - 0x6bfc]
0D4D  8B 46 FC        mov ax, word ptr [bp - 4]
0D50  D1 E0           shl ax, 1
0D52  C4 7E F8        les di, ptr [bp - 8]
0D55  03 F8           add di, ax
0D57  26 8B 45 FE     mov ax, word ptr es:[di - 2]
0D5B  C1 E0 03        shl ax, 3
0D5E  C4 3E BA D7     les di, ptr [0xd7ba]
0D62  03 F8           add di, ax
0D64  26 88 55 06     mov byte ptr es:[di + 6], dl
0D68  83 7E FC 0B     cmp word ptr [bp - 4], 0xb
0D6C  75 BE           jne 0xd2c
loc_0D6E:
0D6E  80 7E FF 01     cmp byte ptr [bp - 1], 1
0D72  74 03           je 0xd77
0D74  E9 0D FF        jmp 0xc84
loc_0D77:
0D77  C9              leave
0D78  CB              retf

; ---- routine 1994:0D79  (found by: far)
sub_0D79:
0D79  C8 08 00 00     enter 8, 0
0D7D  8B 7E 06        mov di, word ptr [bp + 6]
0D80  D1 E7           shl di, 1
0D82  8B 85 28 98     mov ax, word ptr [di - 0x67d8]
0D86  31 D2           xor dx, dx
0D88  89 46 F8        mov word ptr [bp - 8], ax
0D8B  89 56 FA        mov word ptr [bp - 6], dx
0D8E  8B 46 F8        mov ax, word ptr [bp - 8]
0D91  8B 56 FA        mov dx, word ptr [bp - 6]
0D94  B9 64 00        mov cx, 0x64
0D97  31 DB           xor bx, bx
0D99  9A 2A 0A B9 26  call far 26B9:0A2A
0D9E  89 46 FC        mov word ptr [bp - 4], ax
0DA1  89 56 FE        mov word ptr [bp - 2], dx
0DA4  8B 46 FC        mov ax, word ptr [bp - 4]
0DA7  8B 56 FE        mov dx, word ptr [bp - 2]
0DAA  C9              leave
0DAB  CA 02 00        retf 2

; ---- routine 1994:0DAE  (found by: call, far)
sub_0DAE:
0DAE  C8 02 00 00     enter 2, 0
0DB2  80 7E 06 01     cmp byte ptr [bp + 6], 1
0DB6  7D 06           jge 0xdbe
0DB8  C6 46 06 01     mov byte ptr [bp + 6], 1
0DBC  EB 0A           jmp 0xdc8
loc_0DBE:
0DBE  80 7E 06 20     cmp byte ptr [bp + 6], 0x20
0DC2  7E 04           jle 0xdc8
0DC4  C6 46 06 20     mov byte ptr [bp + 6], 0x20
loc_0DC8:
0DC8  8A 46 06        mov al, byte ptr [bp + 6]
0DCB  88 46 FF        mov byte ptr [bp - 1], al
0DCE  8A 46 FF        mov al, byte ptr [bp - 1]
0DD1  C9              leave
0DD2  CA 02 00        retf 2

; ---- routine 1994:0DD5  (found by: call)
sub_0DD5:
0DD5  C8 06 00 00     enter 6, 0
0DD9  6B 46 06 0F     imul ax, word ptr [bp + 6], 0xf
0DDD  C4 3E BE D7     les di, ptr [0xd7be]
0DE1  03 F8           add di, ax
0DE3  89 7E FA        mov word ptr [bp - 6], di
0DE6  8C 46 FC        mov word ptr [bp - 4], es
0DE9  26 80 7D 06 08  cmp byte ptr es:[di + 6], 8
0DEE  7D 07           jge 0xdf7
0DF0  C7 46 FE 02 00  mov word ptr [bp - 2], 2
0DF5  EB 27           jmp 0xe1e
loc_0DF7:
0DF7  C4 7E FA        les di, ptr [bp - 6]
0DFA  26 80 7D 06 10  cmp byte ptr es:[di + 6], 0x10
0DFF  7D 07           jge 0xe08
0E01  C7 46 FE 01 00  mov word ptr [bp - 2], 1
0E06  EB 16           jmp 0xe1e
loc_0E08:
0E08  C4 7E FA        les di, ptr [bp - 6]
0E0B  26 80 7D 06 18  cmp byte ptr es:[di + 6], 0x18
0E10  7D 07           jge 0xe19
0E12  31 C0           xor ax, ax
0E14  89 46 FE        mov word ptr [bp - 2], ax
0E17  EB 05           jmp 0xe1e
loc_0E19:
0E19  C7 46 FE FF FF  mov word ptr [bp - 2], 0xffff
loc_0E1E:
0E1E  8B 46 FE        mov ax, word ptr [bp - 2]
0E21  C9              leave
0E22  C2 04 00        ret 4

; ---- routine 1994:0E25  (found by: call)
sub_0E25:
0E25  C8 04 00 00     enter 4, 0
0E29  6B 46 0A 0F     imul ax, word ptr [bp + 0xa], 0xf
0E2D  C4 3E BE D7     les di, ptr [0xd7be]
0E31  03 F8           add di, ax
0E33  89 7E FC        mov word ptr [bp - 4], di
0E36  8C 46 FE        mov word ptr [bp - 2], es
0E39  83 7E 08 00     cmp word ptr [bp + 8], 0
0E3D  7E 3F           jle 0xe7e
0E3F  FF 76 0A        push word ptr [bp + 0xa]
0E42  8B 7E 04        mov di, word ptr [bp + 4]
0E45  57              push di
0E46  E8 8C FF        call 0xdd5
0E49  50              push ax
0E4A  6A 02           push 2
0E4C  9A 6D 07 1A 23  call far 231A:076D
0E51  50              push ax
0E52  8B 46 06        mov ax, word ptr [bp + 6]
0E55  40              inc ax
0E56  40              inc ax
0E57  50              push ax
0E58  9A 6D 07 1A 23  call far 231A:076D
0E5D  8B D0           mov dx, ax
0E5F  C4 7E FC        les di, ptr [bp - 4]
0E62  26 8A 45 06     mov al, byte ptr es:[di + 6]
0E66  98              cwde
0E67  03 C2           add ax, dx
0E69  5A              pop dx
0E6A  2B C2           sub ax, dx
0E6C  5A              pop dx
0E6D  03 C2           add ax, dx
0E6F  50              push ax
0E70  0E              push cs
0E71  E8 3A FF        call 0xdae
0E74  C4 7E FC        les di, ptr [bp - 4]
0E77  26 88 45 06     mov byte ptr es:[di + 6], al
0E7B  E9 84 00        jmp 0xf02
loc_0E7E:
0E7E  83 7E 08 00     cmp word ptr [bp + 8], 0
0E82  7D 3E           jge 0xec2
0E84  FF 76 0A        push word ptr [bp + 0xa]
0E87  8B 7E 04        mov di, word ptr [bp + 4]
0E8A  57              push di
0E8B  E8 47 FF        call 0xdd5
0E8E  50              push ax
0E8F  6A 02           push 2
0E91  9A 6D 07 1A 23  call far 231A:076D
0E96  50              push ax
0E97  8B 46 06        mov ax, word ptr [bp + 6]
0E9A  40              inc ax
0E9B  40              inc ax
0E9C  50              push ax
0E9D  9A 6D 07 1A 23  call far 231A:076D
0EA2  8B D0           mov dx, ax
0EA4  C4 7E FC        les di, ptr [bp - 4]
0EA7  26 8A 45 06     mov al, byte ptr es:[di + 6]
0EAB  98              cwde
0EAC  2B C2           sub ax, dx
0EAE  5A              pop dx
0EAF  03 C2           add ax, dx
0EB1  5A              pop dx
0EB2  03 C2           add ax, dx
0EB4  50              push ax
0EB5  0E              push cs
0EB6  E8 F5 FE        call 0xdae
0EB9  C4 7E FC        les di, ptr [bp - 4]
0EBC  26 88 45 06     mov byte ptr es:[di + 6], al
0EC0  EB 40           jmp 0xf02
loc_0EC2:
0EC2  FF 76 0A        push word ptr [bp + 0xa]
0EC5  8B 7E 04        mov di, word ptr [bp + 4]
0EC8  57              push di
0EC9  E8 09 FF        call 0xdd5
0ECC  50              push ax
0ECD  8B 46 06        mov ax, word ptr [bp + 6]
0ED0  40              inc ax
0ED1  40              inc ax
0ED2  50              push ax
0ED3  9A 6D 07 1A 23  call far 231A:076D
0ED8  50              push ax
0ED9  8B 46 06        mov ax, word ptr [bp + 6]
0EDC  40              inc ax
0EDD  40              inc ax
0EDE  50              push ax
0EDF  9A 6D 07 1A 23  call far 231A:076D
0EE4  8B D0           mov dx, ax
0EE6  C4 7E FC        les di, ptr [bp - 4]
0EE9  26 8A 45 06     mov al, byte ptr es:[di + 6]
0EED  98              cwde
0EEE  03 C2           add ax, dx
0EF0  5A              pop dx
0EF1  2B C2           sub ax, dx
0EF3  5A              pop dx
0EF4  03 C2           add ax, dx
0EF6  50              push ax
0EF7  0E              push cs
0EF8  E8 B3 FE        call 0xdae
0EFB  C4 7E FC        les di, ptr [bp - 4]
0EFE  26 88 45 06     mov byte ptr es:[di + 6], al
loc_0F02:
0F02  C9              leave
0F03  C2 08 00        ret 8

; ---- routine 1994:0F06  (found by: call)
sub_0F06:
0F06  C8 02 00 00     enter 2, 0
0F0A  C7 46 FE 01 00  mov word ptr [bp - 2], 1
0F0F  EB 03           jmp 0xf14
loc_0F11:
0F11  FF 46 FE        inc word ptr [bp - 2]
loc_0F14:
0F14  8B 46 FE        mov ax, word ptr [bp - 2]
0F17  D1 E0           shl ax, 1
0F19  8B D0           mov dx, ax
0F1B  8B 7E 04        mov di, word ptr [bp + 4]
0F1E  36 6B 45 08 3E  imul ax, word ptr ss:[di + 8], 0x3e
0F23  C4 3E C2 D7     les di, ptr [0xd7c2]
0F27  03 F8           add di, ax
0F29  03 FA           add di, dx
0F2B  26 FF 75 C0     push word ptr es:[di - 0x40]
0F2F  8B 7E 04        mov di, word ptr [bp + 4]
0F32  36 FF 75 FE     push word ptr ss:[di - 2]
0F36  36 8B 45 FE     mov ax, word ptr ss:[di - 2]
0F3A  99              cdq
0F3B  31 D0           xor ax, dx
0F3D  29 D0           sub ax, dx
0F3F  50              push ax
0F40  57              push di
0F41  E8 E1 FE        call 0xe25
0F44  8B 46 FE        mov ax, word ptr [bp - 2]
0F47  D1 E0           shl ax, 1
0F49  8B D0           mov dx, ax
0F4B  8B 7E 04        mov di, word ptr [bp + 4]
0F4E  36 6B 45 06 3E  imul ax, word ptr ss:[di + 6], 0x3e
0F53  C4 3E C2 D7     les di, ptr [0xd7c2]
0F57  03 F8           add di, ax
0F59  03 FA           add di, dx
0F5B  26 FF 75 C0     push word ptr es:[di - 0x40]
0F5F  8B 7E 04        mov di, word ptr [bp + 4]
0F62  36 FF 75 FC     push word ptr ss:[di - 4]
0F66  36 8B 45 FC     mov ax, word ptr ss:[di - 4]
0F6A  99              cdq
0F6B  31 D0           xor ax, dx
0F6D  29 D0           sub ax, dx
0F6F  50              push ax
0F70  57              push di
0F71  E8 B1 FE        call 0xe25
0F74  83 7E FE 0B     cmp word ptr [bp - 2], 0xb
0F78  75 97           jne 0xf11
0F7A  C9              leave
0F7B  C2 02 00        ret 2

; ---- routine 1994:0F7E  (found by: call)
sub_0F7E:
0F7E  C8 08 00 00     enter 8, 0
0F82  83 7E 08 00     cmp word ptr [bp + 8], 0
0F86  75 03           jne 0xf8b
0F88  E9 3B 01        jmp 0x10c6
loc_0F8B:
0F8B  83 7E 06 0C     cmp word ptr [bp + 6], 0xc
0F8F  72 1F           jb 0xfb0
0F91  6A 03           push 3
0F93  6B 46 08 0F     imul ax, word ptr [bp + 8], 0xf
0F97  C4 3E BE D7     les di, ptr [0xd7be]
0F9B  03 F8           add di, ax
0F9D  26 8A 45 0B     mov al, byte ptr es:[di + 0xb]
0FA1  30 E4           xor ah, ah
0FA3  50              push ax
0FA4  9A 59 02 AC 24  call far 24AC:0259
0FA9  08 C0           or al, al
0FAB  75 03           jne 0xfb0
0FAD  E9 16 01        jmp 0x10c6
loc_0FB0:
0FB0  8B 46 08        mov ax, word ptr [bp + 8]
0FB3  C1 E0 03        shl ax, 3
0FB6  C4 3E BA D7     les di, ptr [0xd7ba]
0FBA  03 F8           add di, ax
0FBC  26 80 7D 07 00  cmp byte ptr es:[di + 7], 0
0FC1  75 2B           jne 0xfee
0FC3  8B 46 08        mov ax, word ptr [bp + 8]
0FC6  C1 E0 03        shl ax, 3
0FC9  C4 3E BA D7     les di, ptr [0xd7ba]
0FCD  03 F8           add di, ax
0FCF  26 8A 05        mov al, byte ptr es:[di]
0FD2  30 E4           xor ah, ah
0FD4  3B 06 E4 D6     cmp ax, word ptr [0xd6e4]
0FD8  B0 00           mov al, 0
0FDA  75 01           jne 0xfdd
0FDC  40              inc ax
loc_0FDD:
0FDD  98              cwde
0FDE  8B F8           mov di, ax
0FE0  80 BD C4 D0 00  cmp byte ptr [di - 0x2f3c], 0
0FE5  75 07           jne 0xfee
0FE7  C7 46 FC 90 01  mov word ptr [bp - 4], 0x190
0FEC  EB 31           jmp 0x101f
loc_0FEE:
0FEE  8B 46 06        mov ax, word ptr [bp + 6]
0FF1  D1 E0           shl ax, 1
0FF3  8B D0           mov dx, ax
0FF5  8B 46 08        mov ax, word ptr [bp + 8]
0FF8  C1 E0 03        shl ax, 3
0FFB  C4 3E BA D7     les di, ptr [0xd7ba]
0FFF  03 F8           add di, ax
1001  26 8A 05        mov al, byte ptr es:[di]
1004  30 E4           xor ah, ah
1006  3B 06 E6 D6     cmp ax, word ptr [0xd6e6]
100A  B0 00           mov al, 0
100C  75 01           jne 0x100f
100E  40              inc ax
loc_100F:
100F  98              cwde
1010  6B F8 28        imul di, ax, 0x28
1013  03 FA           add di, dx
1015  8B 85 46 D1     mov ax, word ptr [di - 0x2eba]
1019  2D 37 00        sub ax, 0x37
101C  89 46 FC        mov word ptr [bp - 4], ax
loc_101F:
101F  81 7E FC 88 13  cmp word ptr [bp - 4], 0x1388
1024  7E 05           jle 0x102b
1026  81 6E FC 10 27  sub word ptr [bp - 4], 0x2710
loc_102B:
102B  83 7E FC CE     cmp word ptr [bp - 4], -0x32
102F  7D 07           jge 0x1038
1031  C7 46 FE FC FF  mov word ptr [bp - 2], 0xfffc
1036  EB 55           jmp 0x108d
loc_1038:
1038  83 7E FC 00     cmp word ptr [bp - 4], 0
103C  7D 07           jge 0x1045
103E  C7 46 FE FD FF  mov word ptr [bp - 2], 0xfffd
1043  EB 48           jmp 0x108d
loc_1045:
1045  83 7E FC 14     cmp word ptr [bp - 4], 0x14
1049  7D 07           jge 0x1052
104B  C7 46 FE FE FF  mov word ptr [bp - 2], 0xfffe
1050  EB 3B           jmp 0x108d
loc_1052:
1052  83 7E FC 28     cmp word ptr [bp - 4], 0x28
1056  7D 07           jge 0x105f
1058  C7 46 FE FF FF  mov word ptr [bp - 2], 0xffff
105D  EB 2E           jmp 0x108d
loc_105F:
105F  83 7E FC 50     cmp word ptr [bp - 4], 0x50
1063  7D 07           jge 0x106c
1065  31 C0           xor ax, ax
1067  89 46 FE        mov word ptr [bp - 2], ax
106A  EB 21           jmp 0x108d
loc_106C:
106C  81 7E FC 96 00  cmp word ptr [bp - 4], 0x96
1071  7D 07           jge 0x107a
1073  C7 46 FE 01 00  mov word ptr [bp - 2], 1
1078  EB 13           jmp 0x108d
loc_107A:
107A  81 7E FC 2C 01  cmp word ptr [bp - 4], 0x12c
107F  7D 07           jge 0x1088
1081  C7 46 FE 02 00  mov word ptr [bp - 2], 2
1086  EB 05           jmp 0x108d
loc_1088:
1088  C7 46 FE 03 00  mov word ptr [bp - 2], 3
loc_108D:
108D  6B 46 08 0F     imul ax, word ptr [bp + 8], 0xf
1091  C4 3E BE D7     les di, ptr [0xd7be]
1095  03 F8           add di, ax
1097  89 7E F8        mov word ptr [bp - 8], di
109A  8C 46 FA        mov word ptr [bp - 6], es
109D  FF 76 08        push word ptr [bp + 8]
10A0  8B 7E 04        mov di, word ptr [bp + 4]
10A3  36 8B 7D 04     mov di, word ptr ss:[di + 4]
10A7  57              push di
10A8  E8 2A FD        call 0xdd5
10AB  8B D0           mov dx, ax
10AD  C4 7E F8        les di, ptr [bp - 8]
10B0  26 8A 45 06     mov al, byte ptr es:[di + 6]
10B4  98              cwde
10B5  03 46 FE        add ax, word ptr [bp - 2]
10B8  03 C2           add ax, dx
10BA  50              push ax
10BB  0E              push cs
10BC  E8 EF FC        call 0xdae
10BF  C4 7E F8        les di, ptr [bp - 8]
10C2  26 88 45 06     mov byte ptr es:[di + 6], al
loc_10C6:
10C6  C9              leave
10C7  C2 06 00        ret 6

; ---- routine 1994:10CA  (found by: call)
sub_10CA:
10CA  C8 02 00 00     enter 2, 0
10CE  C7 46 FE 01 00  mov word ptr [bp - 2], 1
10D3  EB 03           jmp 0x10d8
loc_10D5:
10D5  FF 46 FE        inc word ptr [bp - 2]
loc_10D8:
10D8  8B 46 FE        mov ax, word ptr [bp - 2]
10DB  D1 E0           shl ax, 1
10DD  8B D0           mov dx, ax
10DF  8B 7E 04        mov di, word ptr [bp + 4]
10E2  36 6B 45 08 3E  imul ax, word ptr ss:[di + 8], 0x3e
10E7  C4 3E C2 D7     les di, ptr [0xd7c2]
10EB  03 F8           add di, ax
10ED  03 FA           add di, dx
10EF  26 FF 75 C0     push word ptr es:[di - 0x40]
10F3  FF 76 FE        push word ptr [bp - 2]
10F6  55              push bp
10F7  E8 84 FE        call 0xf7e
10FA  8B 46 FE        mov ax, word ptr [bp - 2]
10FD  D1 E0           shl ax, 1
10FF  8B D0           mov dx, ax
1101  8B 7E 04        mov di, word ptr [bp + 4]
1104  36 6B 45 06 3E  imul ax, word ptr ss:[di + 6], 0x3e
1109  C4 3E C2 D7     les di, ptr [0xd7c2]
110D  03 F8           add di, ax
110F  03 FA           add di, dx
1111  26 FF 75 C0     push word ptr es:[di - 0x40]
1115  FF 76 FE        push word ptr [bp - 2]
1118  55              push bp
1119  E8 62 FE        call 0xf7e
111C  83 7E FE 14     cmp word ptr [bp - 2], 0x14
1120  75 B3           jne 0x10d5
1122  C9              leave
1123  C2 02 00        ret 2

; ---- routine 1994:1126  (found by: far)
sub_1126:
1126  C8 08 00 00     enter 8, 0
112A  A0 87 D0        mov al, byte ptr [0xd087]
112D  30 E4           xor ah, ah
112F  8B D0           mov dx, ax
1131  A0 86 D0        mov al, byte ptr [0xd086]
1134  30 E4           xor ah, ah
1136  2B C2           sub ax, dx
1138  99              cdq
1139  31 D0           xor ax, dx
113B  29 D0           sub ax, dx
113D  89 46 F8        mov word ptr [bp - 8], ax
1140  FF 76 08        push word ptr [bp + 8]
1143  9A BB 25 51 1B  call far 1B51:25BB
1148  50              push ax
1149  FF 76 06        push word ptr [bp + 6]
114C  9A BB 25 51 1B  call far 1B51:25BB
1151  5A              pop dx
1152  2B C2           sub ax, dx
1154  99              cdq
1155  B9 20 00        mov cx, 0x20
1158  F7 F9           idiv cx
115A  89 46 FE        mov word ptr [bp - 2], ax
115D  A0 86 D0        mov al, byte ptr [0xd086]
1160  3A 06 87 D0     cmp al, byte ptr [0xd087]
1164  76 08           jbe 0x116e
1166  8B 46 F8        mov ax, word ptr [bp - 8]
1169  01 46 FE        add word ptr [bp - 2], ax
116C  EB 08           jmp 0x1176
loc_116E:
116E  8B 46 F8        mov ax, word ptr [bp - 8]
1171  D1 E0           shl ax, 1
1173  29 46 FE        sub word ptr [bp - 2], ax
loc_1176:
1176  FF 76 06        push word ptr [bp + 6]
1179  9A BB 25 51 1B  call far 1B51:25BB
117E  50              push ax
117F  FF 76 08        push word ptr [bp + 8]
1182  9A BB 25 51 1B  call far 1B51:25BB
1187  5A              pop dx
1188  2B C2           sub ax, dx
118A  99              cdq
118B  B9 20 00        mov cx, 0x20
118E  F7 F9           idiv cx
1190  89 46 FC        mov word ptr [bp - 4], ax
1193  A0 87 D0        mov al, byte ptr [0xd087]
1196  3A 06 86 D0     cmp al, byte ptr [0xd086]
119A  76 0A           jbe 0x11a6
119C  8B 46 F8        mov ax, word ptr [bp - 8]
119F  D1 E0           shl ax, 1
11A1  01 46 FC        add word ptr [bp - 4], ax
11A4  EB 06           jmp 0x11ac
loc_11A6:
11A6  8B 46 F8        mov ax, word ptr [bp - 8]
11A9  29 46 FC        sub word ptr [bp - 4], ax
loc_11AC:
11AC  80 3E DD D6 00  cmp byte ptr [0xd6dd], 0
11B1  74 16           je 0x11c9
11B3  FF 76 08        push word ptr [bp + 8]
11B6  FF 76 FE        push word ptr [bp - 2]
11B9  9A EF 49 51 1B  call far 1B51:49EF
11BE  FF 76 06        push word ptr [bp + 6]
11C1  FF 76 FC        push word ptr [bp - 4]
11C4  9A EF 49 51 1B  call far 1B51:49EF
loc_11C9:
11C9  FF 76 08        push word ptr [bp + 8]
11CC  FF 76 06        push word ptr [bp + 6]
11CF  0E              push cs
11D0  E8 C6 09        call 0x1b99
11D3  08 C0           or al, al
11D5  74 0D           je 0x11e4
11D7  80 3E 75 D0 00  cmp byte ptr [0xd075], 0
11DC  75 06           jne 0x11e4
11DE  55              push bp
11DF  E8 E8 FE        call 0x10ca
11E2  EB 04           jmp 0x11e8
loc_11E4:
11E4  55              push bp
11E5  E8 1E FD        call 0xf06
loc_11E8:
11E8  C9              leave
11E9  CA 04 00        retf 4

; ---- routine 1994:11EC  (found by: call)
sub_11EC:
11EC  C8 08 00 00     enter 8, 0
11F0  8B 46 06        mov ax, word ptr [bp + 6]
11F3  C1 E0 03        shl ax, 3
11F6  C4 3E BA D7     les di, ptr [0xd7ba]
11FA  03 F8           add di, ax
11FC  89 7E F8        mov word ptr [bp - 8], di
11FF  8C 46 FA        mov word ptr [bp - 6], es
1202  80 7E 04 01     cmp byte ptr [bp + 4], 1
1206  7D 04           jge 0x120c
1208  C6 46 04 01     mov byte ptr [bp + 4], 1
loc_120C:
120C  C4 7E F8        les di, ptr [bp - 8]
120F  26 8A 45 02     mov al, byte ptr es:[di + 2]
1213  30 E4           xor ah, ah
1215  05 03 00        add ax, 3
1218  8B D0           mov dx, ax
121A  26 8A 45 01     mov al, byte ptr es:[di + 1]
121E  30 E4           xor ah, ah
1220  3B C2           cmp ax, dx
1222  B0 00           mov al, 0
1224  7E 01           jle 0x1227
1226  40              inc ax
loc_1227:
1227  98              cwde
1228  8B F8           mov di, ax
122A  8A 85 72 0D     mov al, byte ptr [di + 0xd72]
122E  30 E4           xor ah, ah
1230  8B D0           mov dx, ax
1232  8A 46 04        mov al, byte ptr [bp + 4]
1235  98              cwde
1236  3B C2           cmp ax, dx
1238  7E 25           jle 0x125f
123A  C4 7E F8        les di, ptr [bp - 8]
123D  26 8A 45 02     mov al, byte ptr es:[di + 2]
1241  30 E4           xor ah, ah
1243  05 03 00        add ax, 3
1246  8B D0           mov dx, ax
1248  26 8A 45 01     mov al, byte ptr es:[di + 1]
124C  30 E4           xor ah, ah
124E  3B C2           cmp ax, dx
1250  B0 00           mov al, 0
1252  7E 01           jle 0x1255
1254  40              inc ax
loc_1255:
1255  98              cwde
1256  8B F8           mov di, ax
1258  8A 85 72 0D     mov al, byte ptr [di + 0xd72]
125C  88 46 04        mov byte ptr [bp + 4], al
loc_125F:
125F  C4 7E F8        les di, ptr [bp - 8]
1262  26 80 7D 01 13  cmp byte ptr es:[di + 1], 0x13
1267  76 48           jbe 0x12b1
1269  26 8A 05        mov al, byte ptr es:[di]
126C  30 E4           xor ah, ah
126E  6B C0 3E        imul ax, ax, 0x3e
1271  C4 3E C2 D7     les di, ptr [0xd7c2]
1275  03 F8           add di, ax
1277  26 8B 45 EE     mov ax, word ptr es:[di - 0x12]
127B  C1 E0 02        shl ax, 2
127E  C4 3E C8 DC     les di, ptr [0xdcc8]
1282  03 F8           add di, ax
1284  26 8A 45 02     mov al, byte ptr es:[di + 2]
1288  30 E4           xor ah, ah
128A  C1 E8 05        shr ax, 5
128D  05 1B 00        add ax, 0x1b
1290  89 46 FC        mov word ptr [bp - 4], ax
1293  8B 46 FC        mov ax, word ptr [bp - 4]
1296  31 D2           xor dx, dx
1298  8B C8           mov cx, ax
129A  8B DA           mov bx, dx
129C  8A 46 04        mov al, byte ptr [bp + 4]
129F  98              cwde
12A0  99              cdq
12A1  3B D3           cmp dx, bx
12A3  7F 06           jg 0x12ab
12A5  7C 0A           jl 0x12b1
12A7  3B C1           cmp ax, cx
12A9  76 06           jbe 0x12b1
loc_12AB:
12AB  8A 46 FC        mov al, byte ptr [bp - 4]
12AE  88 46 04        mov byte ptr [bp + 4], al
loc_12B1:
12B1  8A 46 04        mov al, byte ptr [bp + 4]
12B4  88 46 FF        mov byte ptr [bp - 1], al
12B7  8A 46 FF        mov al, byte ptr [bp - 1]
12BA  C9              leave
12BB  C2 04 00        ret 4

; ---- routine 1994:12BE  (found by: call, far)
sub_12BE:
12BE  C8 04 00 00     enter 4, 0
12C2  6B 46 06 0F     imul ax, word ptr [bp + 6], 0xf
12C6  C4 3E BE D7     les di, ptr [0xd7be]
12CA  03 F8           add di, ax
12CC  89 7E FC        mov word ptr [bp - 4], di
12CF  8C 46 FE        mov word ptr [bp - 2], es
12D2  6A 02           push 2
12D4  81 C7 0B 00     add di, 0xb
12D8  06              push es
12D9  57              push di
12DA  9A F8 00 1A 23  call far 231A:00F8
12DF  6A 08           push 8
12E1  C4 7E FC        les di, ptr [bp - 4]
12E4  81 C7 0B 00     add di, 0xb
12E8  06              push es
12E9  57              push di
12EA  9A F8 00 1A 23  call far 231A:00F8
12EF  6A 06           push 6
12F1  C4 7E FC        les di, ptr [bp - 4]
12F4  26 8A 45 0B     mov al, byte ptr es:[di + 0xb]
12F8  30 E4           xor ah, ah
12FA  50              push ax
12FB  9A 59 02 AC 24  call far 24AC:0259
1300  08 C0           or al, al
1302  74 10           je 0x1314
1304  6A 08           push 8
1306  C4 7E FC        les di, ptr [bp - 4]
1309  81 C7 0B 00     add di, 0xb
130D  06              push es
130E  57              push di
130F  9A D5 00 1A 23  call far 231A:00D5
loc_1314:
1314  6A 06           push 6
1316  C4 7E FC        les di, ptr [bp - 4]
1319  81 C7 0B 00     add di, 0xb
131D  06              push es
131E  57              push di
131F  9A F8 00 1A 23  call far 231A:00F8
1324  6A 05           push 5
1326  C4 7E FC        les di, ptr [bp - 4]
1329  26 8A 45 0B     mov al, byte ptr es:[di + 0xb]
132D  30 E4           xor ah, ah
132F  50              push ax
1330  9A 59 02 AC 24  call far 24AC:0259
1335  08 C0           or al, al
1337  74 47           je 0x1380
1339  6A 04           push 4
133B  C4 7E FC        les di, ptr [bp - 4]
133E  26 8A 45 0B     mov al, byte ptr es:[di + 0xb]
1342  30 E4           xor ah, ah
1344  50              push ax
1345  9A 59 02 AC 24  call far 24AC:0259
134A  08 C0           or al, al
134C  75 12           jne 0x1360
134E  6A 04           push 4
1350  C4 7E FC        les di, ptr [bp - 4]
1353  81 C7 0B 00     add di, 0xb
1357  06              push es
1358  57              push di
1359  9A D5 00 1A 23  call far 231A:00D5
135E  EB 20           jmp 0x1380
loc_1360:
1360  6A 08           push 8
1362  C4 7E FC        les di, ptr [bp - 4]
1365  81 C7 0B 00     add di, 0xb
1369  06              push es
136A  57              push di
136B  9A D5 00 1A 23  call far 231A:00D5
1370  6A 04           push 4
1372  C4 7E FC        les di, ptr [bp - 4]
1375  81 C7 0B 00     add di, 0xb
1379  06              push es
137A  57              push di
137B  9A F8 00 1A 23  call far 231A:00F8
loc_1380:
1380  6A 05           push 5
1382  C4 7E FC        les di, ptr [bp - 4]
1385  81 C7 0B 00     add di, 0xb
1389  06              push es
138A  57              push di
138B  9A F8 00 1A 23  call far 231A:00F8
1390  C9              leave
1391  CA 02 00        retf 2

; ---- routine 1994:1394  (found by: far)
sub_1394:
1394  C8 0C 00 00     enter 0xc, 0
1398  8B 46 06        mov ax, word ptr [bp + 6]
139B  C1 E0 03        shl ax, 3
139E  C4 3E BA D7     les di, ptr [0xd7ba]
13A2  03 F8           add di, ax
13A4  89 7E FC        mov word ptr [bp - 4], di
13A7  8C 46 FE        mov word ptr [bp - 2], es
13AA  6B 46 06 0F     imul ax, word ptr [bp + 6], 0xf
13AE  C4 3E BE D7     les di, ptr [0xd7be]
13B2  03 F8           add di, ax
13B4  89 7E F8        mov word ptr [bp - 8], di
13B7  8C 46 FA        mov word ptr [bp - 6], es
13BA  C4 7E FC        les di, ptr [bp - 4]
13BD  26 8A 05        mov al, byte ptr es:[di]
13C0  30 E4           xor ah, ah
13C2  6B C0 3E        imul ax, ax, 0x3e
13C5  C4 3E C2 D7     les di, ptr [0xd7c2]
13C9  03 F8           add di, ax
13CB  81 C7 C2 FF     add di, 0xffc2
13CF  C4 7E F8        les di, ptr [bp - 8]
13D2  26 C6 45 08 00  mov byte ptr es:[di + 8], 0
13D7  FF 76 06        push word ptr [bp + 6]
13DA  9A 6C 4D 51 1B  call far 1B51:4D6C
13DF  30 E4           xor ah, ah
13E1  8B D0           mov dx, ax
13E3  B8 14 00        mov ax, 0x14
13E6  2B C2           sub ax, dx
13E8  50              push ax
13E9  9A 6D 07 1A 23  call far 231A:076D
13EE  C4 7E F8        les di, ptr [bp - 8]
13F1  26 88 45 0E     mov byte ptr es:[di + 0xe], al
13F5  C9              leave
13F6  CA 02 00        retf 2

