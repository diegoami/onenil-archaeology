; 1-095.EXE (One-Nil 95), code segment 0AB5 (image offsets 0AB50..1993F), part 10 of 22
; packed 1-095.EXE sha256 f659fb2d334500d6901fc8d6a0f06c85c0ccda2eb4a3035ae3bb0a0004d79192 (LZEXE 0.91)
; unpacked (tools/static/unlzexe.py) sha256 8df646e017e0965a5d90a58181ca764219ad847833aad0b6cb58fc53372bfb2c
; tool: capstone 5.0.9 (pip package; core library 5.0.1280) (CS_ARCH_X86, CS_MODE_16), recursive descent from the entry point, far calls and near calls/jumps, then routine prologues (55 89 E5 / 55 8B EC / C8 iw 00) in what remains; tools/static/listing.py
; addresses are SEGMENT:OFFSET with SEGMENT the image paragraph before relocation; image offset = SEGMENT*16+OFFSET
; ---- routine 0AB5:5A56  (found by: call)
sub_5A56:
5A56  55              push bp
5A57  89 E5           mov bp, sp
5A59  C6 06 A1 D0 00  mov byte ptr [0xd0a1], 0
5A5E  6A 02           push 2
5A60  9A E0 01 94 19  call far 1994:01E0
5A65  E8 C7 10        call 0x6b2f
5A68  E8 6B C2        call 0x1cd6
5A6B  50              push ax
5A6C  6A 03           push 3
5A6E  6A 0A           push 0xa
5A70  E8 8F FE        call 0x5902
5A73  6A 02           push 2
5A75  6A 39           push 0x39
5A77  E8 1C FF        call 0x5996
5A7A  C6 06 B7 D0 01  mov byte ptr [0xd0b7], 1
5A7F  C9              leave
5A80  C3              ret

; ---- routine 0AB5:5A81  (found by: call)
sub_5A81:
5A81  55              push bp
5A82  89 E5           mov bp, sp
5A84  80 3E B9 D0 00  cmp byte ptr [0xd0b9], 0
5A89  75 27           jne 0x5ab2
5A8B  C6 06 A1 D0 00  mov byte ptr [0xd0a1], 0
5A90  E8 9C 10        call 0x6b2f
5A93  8A 46 06        mov al, byte ptr [bp + 6]
5A96  50              push ax
5A97  6A 05           push 5
5A99  6A 08           push 8
5A9B  E8 64 FE        call 0x5902
5A9E  80 7E 04 00     cmp byte ptr [bp + 4], 0
5AA2  74 09           je 0x5aad
5AA4  6A 01           push 1
5AA6  6A 3A           push 0x3a
5AA8  E8 EB FE        call 0x5996
5AAB  EB 05           jmp 0x5ab2
loc_5AAD:
5AAD  6A 38           push 0x38
5AAF  E8 05 C3        call 0x1db7
loc_5AB2:
5AB2  C9              leave
5AB3  C2 04 00        ret 4

; ---- routine 0AB5:5AB6  (found by: call)
sub_5AB6:
5AB6  55              push bp
5AB7  89 E5           mov bp, sp
5AB9  C6 06 A1 D0 00  mov byte ptr [0xd0a1], 0
5ABE  E8 6E 10        call 0x6b2f
5AC1  8A 46 04        mov al, byte ptr [bp + 4]
5AC4  98              cwde
5AC5  8B F8           mov di, ax
5AC7  8A 85 56 0D     mov al, byte ptr [di + 0xd56]
5ACB  30 E4           xor ah, ah
5ACD  40              inc ax
5ACE  6B F8 19        imul di, ax, 0x19
5AD1  81 C7 EF CC     add di, 0xccef
5AD5  1E              push ds
5AD6  57              push di
5AD7  0E              push cs
5AD8  E8 F1 C3        call 0x1ecc
5ADB  98              cwde
5ADC  8B D0           mov dx, ax
5ADE  A0 47 CF        mov al, byte ptr [0xcf47]
5AE1  98              cwde
5AE2  F7 E2           mul dx
5AE4  3D 12 00        cmp ax, 0x12
5AE7  7C 1B           jl 0x5b04
5AE9  A0 46 CF        mov al, byte ptr [0xcf46]
5AEC  98              cwde
5AED  99              cdq
5AEE  31 D0           xor ax, dx
5AF0  29 D0           sub ax, dx
5AF2  3D 04 00        cmp ax, 4
5AF5  7F 0D           jg 0x5b04
5AF7  8A 46 04        mov al, byte ptr [bp + 4]
5AFA  50              push ax
5AFB  6A 04           push 4
5AFD  6A 0B           push 0xb
5AFF  E8 00 FE        call 0x5902
5B02  EB 12           jmp 0x5b16
loc_5B04:
5B04  8A 46 04        mov al, byte ptr [bp + 4]
5B07  98              cwde
5B08  8B F8           mov di, ax
5B0A  8A 85 A4 D0     mov al, byte ptr [di - 0x2f5c]
5B0E  30 E4           xor ah, ah
5B10  50              push ax
5B11  6A 0B           push 0xb
5B13  E8 CD FC        call 0x57e3
loc_5B16:
5B16  6A 01           push 1
5B18  6A 3A           push 0x3a
5B1A  E8 79 FE        call 0x5996
5B1D  C9              leave
5B1E  C2 02 00        ret 2

; ---- routine 0AB5:5B21  (found by: call)
sub_5B21:
5B21  55              push bp
5B22  89 E5           mov bp, sp
5B24  FF 36 46 CF     push word ptr [0xcf46]
5B28  A0 9F D0        mov al, byte ptr [0xd09f]
5B2B  30 E4           xor ah, ah
5B2D  6B F8 19        imul di, ax, 0x19
5B30  81 C7 EF CC     add di, 0xccef
5B34  1E              push ds
5B35  57              push di
5B36  0E              push cs
5B37  E8 45 C5        call 0x207f
5B3A  08 C0           or al, al
5B3C  74 0B           je 0x5b49
5B3E  E8 95 C1        call 0x1cd6
5B41  50              push ax
5B42  6A 01           push 1
5B44  E8 3A FF        call 0x5a81
5B47  EB 07           jmp 0x5b50
loc_5B49:
5B49  E8 8A C1        call 0x1cd6
5B4C  50              push ax
5B4D  E8 66 FF        call 0x5ab6
loc_5B50:
5B50  C9              leave
5B51  C3              ret

; ---- routine 0AB5:5B52  (found by: call)
sub_5B52:
5B52  55              push bp
5B53  89 E5           mov bp, sp
5B55  8B 7E 04        mov di, word ptr [bp + 4]
5B58  36 C4 7D 06     les di, ptr ss:[di + 6]
5B5C  06              push es
5B5D  57              push di
5B5E  0E              push cs
5B5F  E8 37 C4        call 0x1f99
5B62  08 C0           or al, al
5B64  74 58           je 0x5bbe
5B66  80 3E B6 D0 00  cmp byte ptr [0xd0b6], 0
5B6B  74 2B           je 0x5b98
5B6D  8B 7E 04        mov di, word ptr [bp + 4]
5B70  36 C4 7D 06     les di, ptr ss:[di + 6]
5B74  06              push es
5B75  57              push di
5B76  0E              push cs
5B77  E8 41 C1        call 0x1cbb
5B7A  98              cwde
5B7B  8B F8           mov di, ax
5B7D  8A 85 A4 D0     mov al, byte ptr [di - 0x2f5c]
5B81  30 E4           xor ah, ah
5B83  50              push ax
5B84  8B 7E 04        mov di, word ptr [bp + 4]
5B87  36 C4 7D 06     les di, ptr ss:[di + 6]
5B8B  06              push es
5B8C  57              push di
5B8D  0E              push cs
5B8E  E8 AC D0        call 0x2c3d
5B91  6A 05           push 5
5B93  E8 E8 C0        call 0x1c7e
5B96  EB 26           jmp 0x5bbe
loc_5B98:
5B98  8B 7E 04        mov di, word ptr [bp + 4]
5B9B  36 C4 7D 06     les di, ptr ss:[di + 6]
5B9F  26 80 7D 11 00  cmp byte ptr es:[di + 0x11], 0
5BA4  76 06           jbe 0x5bac
5BA6  26 FE 4D 11     dec byte ptr es:[di + 0x11]
5BAA  EB 12           jmp 0x5bbe
loc_5BAC:
5BAC  C6 06 53 CF 00  mov byte ptr [0xcf53], 0
5BB1  6A 2A           push 0x2a
5BB3  E8 01 C2        call 0x1db7
5BB6  C6 06 B6 D0 01  mov byte ptr [0xd0b6], 1
5BBB  E8 7A BE        call 0x1a38
loc_5BBE:
5BBE  C9              leave
5BBF  C2 02 00        ret 2

; ---- routine 0AB5:5BC2  (found by: call)
sub_5BC2:
5BC2  55              push bp
5BC3  89 E5           mov bp, sp
5BC5  C4 7E 06        les di, ptr [bp + 6]
5BC8  26 8A 45 07     mov al, byte ptr es:[di + 7]
5BCC  3A 06 9F D0     cmp al, byte ptr [0xd09f]
5BD0  75 06           jne 0x5bd8
5BD2  55              push bp
5BD3  E8 7C FF        call 0x5b52
5BD6  EB 6C           jmp 0x5c44
loc_5BD8:
5BD8  C4 7E 06        les di, ptr [bp + 6]
5BDB  06              push es
5BDC  57              push di
5BDD  0E              push cs
5BDE  E8 DA C0        call 0x1cbb
5BE1  98              cwde
5BE2  8B F8           mov di, ax
5BE4  8A 85 A4 D0     mov al, byte ptr [di - 0x2f5c]
5BE8  C4 7E 06        les di, ptr [bp + 6]
5BEB  26 3A 45 07     cmp al, byte ptr es:[di + 7]
5BEF  75 4A           jne 0x5c3b
5BF1  9A 3F 0D AC 24  call far 24AC:0D3F
5BF6  30 E4           xor ah, ah
5BF8  50              push ax
5BF9  9A 3F 0D AC 24  call far 24AC:0D3F
5BFE  30 E4           xor ah, ah
5C00  8B D8           mov bx, ax
5C02  A0 46 CF        mov al, byte ptr [0xcf46]
5C05  98              cwde
5C06  99              cdq
5C07  B9 02 00        mov cx, 2
5C0A  F7 F9           idiv cx
5C0C  03 C3           add ax, bx
5C0E  5A              pop dx
5C0F  2B C2           sub ax, dx
5C11  C4 7E 06        les di, ptr [bp + 6]
5C14  26 88 45 08     mov byte ptr es:[di + 8], al
5C18  06              push es
5C19  57              push di
5C1A  0E              push cs
5C1B  E8 AE C2        call 0x1ecc
5C1E  98              cwde
5C1F  50              push ax
5C20  6A 04           push 4
5C22  9A 6D 07 1A 23  call far 231A:076D
5C27  5A              pop dx
5C28  F7 E2           mul dx
5C2A  8B D0           mov dx, ax
5C2C  A0 47 CF        mov al, byte ptr [0xcf47]
5C2F  98              cwde
5C30  03 C2           add ax, dx
5C32  C4 7E 06        les di, ptr [bp + 6]
5C35  26 88 45 09     mov byte ptr es:[di + 9], al
5C39  EB 09           jmp 0x5c44
loc_5C3B:
5C3B  C4 7E 06        les di, ptr [bp + 6]
5C3E  06              push es
5C3F  57              push di
5C40  0E              push cs
5C41  E8 33 DD        call 0x3977
loc_5C44:
5C44  C9              leave
5C45  CA 04 00        retf 4

; ---- routine 0AB5:5C48  (found by: call)
sub_5C48:
5C48  55              push bp
5C49  89 E5           mov bp, sp
5C4B  8B 7E 04        mov di, word ptr [bp + 4]
5C4E  36 C4 7D 06     les di, ptr ss:[di + 6]
5C52  06              push es
5C53  57              push di
5C54  0E              push cs
5C55  E8 41 C3        call 0x1f99
5C58  08 C0           or al, al
5C5A  74 41           je 0x5c9d
5C5C  80 3E B6 D0 00  cmp byte ptr [0xd0b6], 0
5C61  74 14           je 0x5c77
5C63  8B 7E 04        mov di, word ptr [bp + 4]
5C66  36 C4 7D 06     les di, ptr ss:[di + 6]
5C6A  06              push es
5C6B  57              push di
5C6C  0E              push cs
5C6D  E8 E3 D1        call 0x2e53
5C70  6A 05           push 5
5C72  E8 09 C0        call 0x1c7e
5C75  EB 26           jmp 0x5c9d
loc_5C77:
5C77  8B 7E 04        mov di, word ptr [bp + 4]
5C7A  36 C4 7D 06     les di, ptr ss:[di + 6]
5C7E  26 80 7D 11 00  cmp byte ptr es:[di + 0x11], 0
5C83  76 06           jbe 0x5c8b
5C85  26 FE 4D 11     dec byte ptr es:[di + 0x11]
5C89  EB 12           jmp 0x5c9d
loc_5C8B:
5C8B  C6 06 53 CF 00  mov byte ptr [0xcf53], 0
5C90  6A 2C           push 0x2c
5C92  E8 22 C1        call 0x1db7
5C95  C6 06 B6 D0 01  mov byte ptr [0xd0b6], 1
5C9A  E8 9B BD        call 0x1a38
loc_5C9D:
5C9D  C9              leave
5C9E  C2 02 00        ret 2

; ---- routine 0AB5:5CA1  (found by: call)
sub_5CA1:
5CA1  55              push bp
5CA2  89 E5           mov bp, sp
5CA4  C4 7E 06        les di, ptr [bp + 6]
5CA7  26 8A 45 07     mov al, byte ptr es:[di + 7]
5CAB  3A 06 9F D0     cmp al, byte ptr [0xd09f]
5CAF  75 06           jne 0x5cb7
5CB1  55              push bp
5CB2  E8 93 FF        call 0x5c48
5CB5  EB 09           jmp 0x5cc0
loc_5CB7:
5CB7  C4 7E 06        les di, ptr [bp + 6]
5CBA  06              push es
5CBB  57              push di
5CBC  0E              push cs
5CBD  E8 B7 DC        call 0x3977
loc_5CC0:
5CC0  C9              leave
5CC1  CA 04 00        retf 4

; ---- routine 0AB5:5CC4  (found by: call)
sub_5CC4:
5CC4  C8 06 00 00     enter 6, 0
5CC8  C6 46 FB 01     mov byte ptr [bp - 5], 1
5CCC  C7 46 FC 01 00  mov word ptr [bp - 4], 1
5CD1  EB 03           jmp 0x5cd6
loc_5CD3:
5CD3  FF 46 FC        inc word ptr [bp - 4]
loc_5CD6:
5CD6  FF 76 FC        push word ptr [bp - 4]
5CD9  E8 24 A3        call 0
5CDC  08 C0           or al, al
5CDE  75 2C           jne 0x5d0c
5CE0  A0 9F D0        mov al, byte ptr [0xd09f]
5CE3  30 E4           xor ah, ah
5CE5  3B 46 FC        cmp ax, word ptr [bp - 4]
5CE8  74 22           je 0x5d0c
5CEA  6B 7E FC 19     imul di, word ptr [bp - 4], 0x19
5CEE  FF B5 EF CC     push word ptr [di - 0x3311]
5CF2  A0 9F D0        mov al, byte ptr [0xd09f]
5CF5  30 E4           xor ah, ah
5CF7  6B F8 19        imul di, ax, 0x19
5CFA  81 C7 EF CC     add di, 0xccef
5CFE  1E              push ds
5CFF  57              push di
5D00  0E              push cs
5D01  E8 F1 C3        call 0x20f5
5D04  08 C0           or al, al
5D06  74 04           je 0x5d0c
5D08  C6 46 FB 00     mov byte ptr [bp - 5], 0
loc_5D0C:
5D0C  83 7E FC 16     cmp word ptr [bp - 4], 0x16
5D10  75 C1           jne 0x5cd3
5D12  8A 46 FB        mov al, byte ptr [bp - 5]
5D15  88 46 FF        mov byte ptr [bp - 1], al
5D18  8A 46 FF        mov al, byte ptr [bp - 1]
5D1B  C9              leave
5D1C  C2 02 00        ret 2

; ---- routine 0AB5:5D1F  (found by: call)
sub_5D1F:
5D1F  55              push bp
5D20  89 E5           mov bp, sp
5D22  8B 7E 04        mov di, word ptr [bp + 4]
5D25  36 C4 7D 06     les di, ptr ss:[di + 6]
5D29  06              push es
5D2A  57              push di
5D2B  0E              push cs
5D2C  E8 6A C2        call 0x1f99
5D2F  08 C0           or al, al
5D31  74 6C           je 0x5d9f
5D33  8B 7E 04        mov di, word ptr [bp + 4]
5D36  36 C4 7D 06     les di, ptr ss:[di + 6]
5D3A  26 8B 05        mov ax, word ptr es:[di]
5D3D  3B 06 A8 D0     cmp ax, word ptr [0xd0a8]
5D41  75 47           jne 0x5d8a
5D43  80 3E B6 D0 00  cmp byte ptr [0xd0b6], 0
5D48  74 0D           je 0x5d57
5D4A  06              push es
5D4B  57              push di
5D4C  0E              push cs
5D4D  E8 76 CE        call 0x2bc6
5D50  6A 05           push 5
5D52  E8 29 BF        call 0x1c7e
5D55  EB 31           jmp 0x5d88
loc_5D57:
5D57  8B 7E 04        mov di, word ptr [bp + 4]
5D5A  57              push di
5D5B  E8 66 FF        call 0x5cc4
5D5E  08 C0           or al, al
5D60  74 26           je 0x5d88
5D62  8B 7E 04        mov di, word ptr [bp + 4]
5D65  36 C4 7D 06     les di, ptr ss:[di + 6]
5D69  06              push es
5D6A  57              push di
5D6B  0E              push cs
5D6C  E8 5D C1        call 0x1ecc
5D6F  98              cwde
5D70  6B C0 DB        imul ax, ax, -0x25
5D73  8B 7E 04        mov di, word ptr [bp + 4]
5D76  36 C4 7D 06     les di, ptr ss:[di + 6]
5D7A  26 88 45 09     mov byte ptr es:[di + 9], al
5D7E  6A 2E           push 0x2e
5D80  E8 34 C0        call 0x1db7
5D83  C6 06 B6 D0 01  mov byte ptr [0xd0b6], 1
loc_5D88:
5D88  EB 15           jmp 0x5d9f
loc_5D8A:
5D8A  8B 7E 04        mov di, word ptr [bp + 4]
5D8D  36 C4 7D 06     les di, ptr ss:[di + 6]
5D91  26 8A 45 07     mov al, byte ptr es:[di + 7]
5D95  A2 A0 D0        mov byte ptr [0xd0a0], al
5D98  A1 A8 D0        mov ax, word ptr [0xd0a8]
5D9B  26 89 45 08     mov word ptr es:[di + 8], ax
loc_5D9F:
5D9F  C9              leave
5DA0  C2 02 00        ret 2

; ---- routine 0AB5:5DA3  (found by: call)
sub_5DA3:
5DA3  55              push bp
5DA4  89 E5           mov bp, sp
5DA6  C4 7E 06        les di, ptr [bp + 6]
5DA9  26 8A 45 07     mov al, byte ptr es:[di + 7]
5DAD  3A 06 9F D0     cmp al, byte ptr [0xd09f]
5DB1  75 06           jne 0x5db9
5DB3  55              push bp
5DB4  E8 68 FF        call 0x5d1f
5DB7  EB 4C           jmp 0x5e05
loc_5DB9:
5DB9  C4 7E 06        les di, ptr [bp + 6]
5DBC  26 8A 45 07     mov al, byte ptr es:[di + 7]
5DC0  30 E4           xor ah, ah
5DC2  50              push ax
5DC3  E8 3A A2        call 0
5DC6  08 C0           or al, al
5DC8  74 0B           je 0x5dd5
5DCA  C4 7E 06        les di, ptr [bp + 6]
5DCD  06              push es
5DCE  57              push di
5DCF  0E              push cs
5DD0  E8 07 D5        call 0x32da
5DD3  EB 30           jmp 0x5e05
loc_5DD5:
5DD5  C4 7E 06        les di, ptr [bp + 6]
5DD8  26 FF 35        push word ptr es:[di]
5DDB  A0 9F D0        mov al, byte ptr [0xd09f]
5DDE  30 E4           xor ah, ah
5DE0  6B F8 19        imul di, ax, 0x19
5DE3  81 C7 EF CC     add di, 0xccef
5DE7  1E              push ds
5DE8  57              push di
5DE9  0E              push cs
5DEA  E8 08 C3        call 0x20f5
5DED  08 C0           or al, al
5DEF  74 0B           je 0x5dfc
5DF1  C4 7E 06        les di, ptr [bp + 6]
5DF4  31 C0           xor ax, ax
5DF6  26 89 45 08     mov word ptr es:[di + 8], ax
5DFA  EB 09           jmp 0x5e05
loc_5DFC:
5DFC  C4 7E 06        les di, ptr [bp + 6]
5DFF  06              push es
5E00  57              push di
5E01  0E              push cs
5E02  E8 72 DB        call 0x3977
loc_5E05:
5E05  C9              leave
5E06  CA 04 00        retf 4

; ---- routine 0AB5:5E09  (found by: call)
sub_5E09:
5E09  55              push bp
5E0A  89 E5           mov bp, sp
5E0C  8B 7E 04        mov di, word ptr [bp + 4]
5E0F  36 C4 7D 06     les di, ptr ss:[di + 6]
5E13  06              push es
5E14  57              push di
5E15  0E              push cs
5E16  E8 80 C1        call 0x1f99
5E19  08 C0           or al, al
5E1B  75 03           jne 0x5e20
5E1D  E9 8F 00        jmp 0x5eaf
loc_5E20:
5E20  8B 7E 04        mov di, word ptr [bp + 4]
5E23  36 C4 7D 06     les di, ptr ss:[di + 6]
5E27  26 8B 05        mov ax, word ptr es:[di]
5E2A  3B 06 A8 D0     cmp ax, word ptr [0xd0a8]
5E2E  75 57           jne 0x5e87
5E30  80 3E B6 D0 00  cmp byte ptr [0xd0b6], 0
5E35  74 11           je 0x5e48
5E37  6A 11           push 0x11
5E39  6A 03           push 3
5E3B  06              push es
5E3C  57              push di
5E3D  0E              push cs
5E3E  E8 8C CE        call 0x2ccd
5E41  6A 05           push 5
5E43  E8 38 BE        call 0x1c7e
5E46  EB 3D           jmp 0x5e85
loc_5E48:
5E48  6A 00           push 0
5E4A  E8 D1 BD        call 0x1c1e
5E4D  08 C0           or al, al
5E4F  74 34           je 0x5e85
5E51  8B 7E 04        mov di, word ptr [bp + 4]
5E54  36 C4 7D 06     les di, ptr ss:[di + 6]
5E58  06              push es
5E59  57              push di
5E5A  0E              push cs
5E5B  E8 6E C0        call 0x1ecc
5E5E  98              cwde
5E5F  6B C0 18        imul ax, ax, 0x18
5E62  8B 7E 04        mov di, word ptr [bp + 4]
5E65  36 C4 7D 06     les di, ptr ss:[di + 6]
5E69  26 88 45 09     mov byte ptr es:[di + 9], al
5E6D  80 3E B9 D0 00  cmp byte ptr [0xd0b9], 0
5E72  74 07           je 0x5e7b
5E74  6A 3C           push 0x3c
5E76  E8 3E BF        call 0x1db7
5E79  EB 05           jmp 0x5e80
loc_5E7B:
5E7B  6A 2F           push 0x2f
5E7D  E8 37 BF        call 0x1db7
loc_5E80:
5E80  C6 06 B6 D0 01  mov byte ptr [0xd0b6], 1
loc_5E85:
5E85  EB 28           jmp 0x5eaf
loc_5E87:
5E87  C4 3E D2 D7     les di, ptr [0xd7d2]
5E8B  26 8A 45 02     mov al, byte ptr es:[di + 2]
5E8F  30 E4           xor ah, ah
5E91  C1 E0 02        shl ax, 2
5E94  50              push ax
5E95  9A D6 00 94 19  call far 1994:00D6
5E9A  8B 7E 04        mov di, word ptr [bp + 4]
5E9D  36 C4 7D 06     les di, ptr ss:[di + 6]
5EA1  26 8A 45 07     mov al, byte ptr es:[di + 7]
5EA5  A2 A0 D0        mov byte ptr [0xd0a0], al
5EA8  A1 A8 D0        mov ax, word ptr [0xd0a8]
5EAB  26 89 45 08     mov word ptr es:[di + 8], ax
loc_5EAF:
5EAF  C9              leave
5EB0  C2 02 00        ret 2

; ---- routine 0AB5:5EB3  (found by: call)
sub_5EB3:
5EB3  55              push bp
5EB4  89 E5           mov bp, sp
5EB6  C4 7E 06        les di, ptr [bp + 6]
5EB9  26 8A 45 07     mov al, byte ptr es:[di + 7]
5EBD  3A 06 9F D0     cmp al, byte ptr [0xd09f]
5EC1  75 07           jne 0x5eca
5EC3  55              push bp
5EC4  E8 42 FF        call 0x5e09
5EC7  E9 DD 00        jmp 0x5fa7
loc_5ECA:
5ECA  80 3E B9 D0 00  cmp byte ptr [0xd0b9], 0
5ECF  75 75           jne 0x5f46
5ED1  C4 7E 06        les di, ptr [bp + 6]
5ED4  26 8A 45 07     mov al, byte ptr es:[di + 7]
5ED8  30 E4           xor ah, ah
5EDA  50              push ax
5EDB  E8 22 A1        call 0
5EDE  08 C0           or al, al
5EE0  74 16           je 0x5ef8
5EE2  FF 36 E6 0A     push word ptr [0xae6]
5EE6  C4 7E 06        les di, ptr [bp + 6]
5EE9  06              push es
5EEA  57              push di
5EEB  0E              push cs
5EEC  E8 6F C0        call 0x1f5e
5EEF  C4 7E 06        les di, ptr [bp + 6]
5EF2  26 89 45 08     mov word ptr es:[di + 8], ax
5EF6  EB 4C           jmp 0x5f44
loc_5EF8:
5EF8  C4 7E 06        les di, ptr [bp + 6]
5EFB  06              push es
5EFC  57              push di
5EFD  0E              push cs
5EFE  E8 9E BF        call 0x1e9f
5F01  30 E4           xor ah, ah
5F03  D1 E0           shl ax, 1
5F05  50              push ax
5F06  C4 7E 06        les di, ptr [bp + 6]
5F09  06              push es
5F0A  57              push di
5F0B  0E              push cs
5F0C  E8 3F BF        call 0x1e4e
5F0F  98              cwde
5F10  6B F8 14        imul di, ax, 0x14
5F13  58              pop ax
5F14  03 F8           add di, ax
5F16  8B 85 BA 0A     mov ax, word ptr [di + 0xaba]
5F1A  C4 7E 06        les di, ptr [bp + 6]
5F1D  26 89 45 08     mov word ptr es:[di + 8], ax
5F21  A0 9F D0        mov al, byte ptr [0xd09f]
5F24  30 E4           xor ah, ah
5F26  6B F8 19        imul di, ax, 0x19
5F29  81 C7 EF CC     add di, 0xccef
5F2D  1E              push ds
5F2E  57              push di
5F2F  0E              push cs
5F30  E8 99 BF        call 0x1ecc
5F33  98              cwde
5F34  8B D0           mov dx, ax
5F36  C4 7E 06        les di, ptr [bp + 6]
5F39  26 8A 45 09     mov al, byte ptr es:[di + 9]
5F3D  98              cwde
5F3E  F7 E2           mul dx
5F40  26 88 45 09     mov byte ptr es:[di + 9], al
loc_5F44:
5F44  EB 4C           jmp 0x5f92
loc_5F46:
5F46  C4 7E 06        les di, ptr [bp + 6]
5F49  06              push es
5F4A  57              push di
5F4B  0E              push cs
5F4C  E8 FF BE        call 0x1e4e
5F4F  08 C0           or al, al
5F51  75 27           jne 0x5f7a
5F53  C4 7E 06        les di, ptr [bp + 6]
5F56  26 8A 45 07     mov al, byte ptr es:[di + 7]
5F5A  30 E4           xor ah, ah
5F5C  50              push ax
5F5D  E8 A0 A0        call 0
5F60  08 C0           or al, al
5F62  74 16           je 0x5f7a
5F64  FF 36 E6 0A     push word ptr [0xae6]
5F68  C4 7E 06        les di, ptr [bp + 6]
5F6B  06              push es
5F6C  57              push di
5F6D  0E              push cs
5F6E  E8 ED BF        call 0x1f5e
5F71  C4 7E 06        les di, ptr [bp + 6]
5F74  26 89 45 08     mov word ptr es:[di + 8], ax
5F78  EB 18           jmp 0x5f92
loc_5F7A:
5F7A  C4 7E 06        les di, ptr [bp + 6]
5F7D  26 8A 45 07     mov al, byte ptr es:[di + 7]
5F81  30 E4           xor ah, ah
5F83  8B F8           mov di, ax
5F85  D1 E7           shl di, 1
5F87  8B 85 E6 0A     mov ax, word ptr [di + 0xae6]
5F8B  C4 7E 06        les di, ptr [bp + 6]
5F8E  26 89 45 08     mov word ptr es:[di + 8], ax
loc_5F92:
5F92  C4 7E 06        les di, ptr [bp + 6]
5F95  06              push es
5F96  57              push di
5F97  0E              push cs
5F98  E8 FE BF        call 0x1f99
5F9B  08 C0           or al, al
5F9D  74 08           je 0x5fa7
5F9F  C4 7E 06        les di, ptr [bp + 6]
5FA2  26 C6 45 13 00  mov byte ptr es:[di + 0x13], 0
loc_5FA7:
5FA7  C9              leave
5FA8  CA 04 00        retf 4

; ---- routine 0AB5:5FAB  (found by: call)
sub_5FAB:
5FAB  C8 02 00 00     enter 2, 0
5FAF  8B 7E 04        mov di, word ptr [bp + 4]
5FB2  36 C4 7D 06     les di, ptr ss:[di + 6]
5FB6  06              push es
5FB7  57              push di
5FB8  0E              push cs
5FB9  E8 DD BF        call 0x1f99
5FBC  08 C0           or al, al
5FBE  75 03           jne 0x5fc3
5FC0  E9 03 01        jmp 0x60c6
loc_5FC3:
5FC3  80 3E B6 D0 00  cmp byte ptr [0xd0b6], 0
5FC8  75 03           jne 0x5fcd
5FCA  E9 D6 00        jmp 0x60a3
loc_5FCD:
5FCD  E8 06 BD        call 0x1cd6
5FD0  08 C0           or al, al
5FD2  B0 00           mov al, 0
5FD4  75 01           jne 0x5fd7
5FD6  40              inc ax
loc_5FD7:
5FD7  98              cwde
5FD8  8B F8           mov di, ax
5FDA  8A 85 56 0D     mov al, byte ptr [di + 0xd56]
5FDE  30 E4           xor ah, ah
5FE0  40              inc ax
5FE1  6B F8 19        imul di, ax, 0x19
5FE4  8A 85 F0 CC     mov al, byte ptr [di - 0x3310]
5FE8  98              cwde
5FE9  99              cdq
5FEA  31 D0           xor ax, dx
5FEC  29 D0           sub ax, dx
5FEE  3D 25 00        cmp ax, 0x25
5FF1  74 03           je 0x5ff6
5FF3  E9 D0 00        jmp 0x60c6
loc_5FF6:
5FF6  8B 7E 04        mov di, word ptr [bp + 4]
5FF9  36 C4 7D 06     les di, ptr ss:[di + 6]
5FFD  26 8B 45 0E     mov ax, word ptr es:[di + 0xe]
6001  C1 E0 03        shl ax, 3
6004  C4 3E BA D7     les di, ptr [0xd7ba]
6008  03 F8           add di, ax
600A  26 8A 45 06     mov al, byte ptr es:[di + 6]
600E  30 E4           xor ah, ah
6010  89 46 FE        mov word ptr [bp - 2], ax
6013  8B 7E 04        mov di, word ptr [bp + 4]
6016  36 C4 7D 06     les di, ptr ss:[di + 6]
601A  26 8B 45 0E     mov ax, word ptr es:[di + 0xe]
601E  C1 E0 03        shl ax, 3
6021  C4 3E BA D7     les di, ptr [0xd7ba]
6025  03 F8           add di, ax
6027  26 C6 45 06 01  mov byte ptr es:[di + 6], 1
602C  9A 3F 0D AC 24  call far 24AC:0D3F
6031  08 C0           or al, al
6033  74 3F           je 0x6074
6035  8B 7E 04        mov di, word ptr [bp + 4]
6038  36 C4 7D 06     les di, ptr ss:[di + 6]
603C  06              push es
603D  57              push di
603E  0E              push cs
603F  E8 1B C1        call 0x215d
6042  08 C0           or al, al
6044  74 2E           je 0x6074
6046  8A 56 FE        mov dl, byte ptr [bp - 2]
6049  8B 7E 04        mov di, word ptr [bp + 4]
604C  36 C4 7D 06     les di, ptr ss:[di + 6]
6050  26 8B 45 0E     mov ax, word ptr es:[di + 0xe]
6054  C1 E0 03        shl ax, 3
6057  C4 3E BA D7     les di, ptr [0xd7ba]
605B  03 F8           add di, ax
605D  26 88 55 06     mov byte ptr es:[di + 6], dl
6061  6A 11           push 0x11
6063  6A 04           push 4
6065  8B 7E 04        mov di, word ptr [bp + 4]
6068  36 C4 7D 06     les di, ptr ss:[di + 6]
606C  06              push es
606D  57              push di
606E  0E              push cs
606F  E8 5B CC        call 0x2ccd
6072  EB 28           jmp 0x609c
loc_6074:
6074  8A 56 FE        mov dl, byte ptr [bp - 2]
6077  8B 7E 04        mov di, word ptr [bp + 4]
607A  36 C4 7D 06     les di, ptr ss:[di + 6]
607E  26 8B 45 0E     mov ax, word ptr es:[di + 0xe]
6082  C1 E0 03        shl ax, 3
6085  C4 3E BA D7     les di, ptr [0xd7ba]
6089  03 F8           add di, ax
608B  26 88 55 06     mov byte ptr es:[di + 6], dl
608F  8B 7E 04        mov di, word ptr [bp + 4]
6092  36 C4 7D 06     les di, ptr ss:[di + 6]
6096  06              push es
6097  57              push di
6098  0E              push cs
6099  E8 4F C4        call 0x24eb
loc_609C:
609C  6A 05           push 5
609E  E8 DD BB        call 0x1c7e
60A1  EB 23           jmp 0x60c6
loc_60A3:
60A3  8B 7E 04        mov di, word ptr [bp + 4]
60A6  36 C4 7D 06     les di, ptr ss:[di + 6]
60AA  26 80 7D 11 00  cmp byte ptr es:[di + 0x11], 0
60AF  76 06           jbe 0x60b7
60B1  26 FE 4D 11     dec byte ptr es:[di + 0x11]
60B5  EB 0F           jmp 0x60c6
loc_60B7:
60B7  C6 06 53 CF 00  mov byte ptr [0xcf53], 0
60BC  6A 30           push 0x30
60BE  E8 F6 BC        call 0x1db7
60C1  C6 06 B6 D0 01  mov byte ptr [0xd0b6], 1
loc_60C6:
60C6  C9              leave
60C7  C2 02 00        ret 2

; ---- routine 0AB5:60CA  (found by: call)
sub_60CA:
60CA  C8 04 00 00     enter 4, 0
60CE  C4 7E 06        les di, ptr [bp + 6]
60D1  26 8A 45 07     mov al, byte ptr es:[di + 7]
60D5  3A 06 9F D0     cmp al, byte ptr [0xd09f]
60D9  75 07           jne 0x60e2
60DB  55              push bp
60DC  E8 CC FE        call 0x5fab
60DF  E9 1F 02        jmp 0x6301
loc_60E2:
60E2  C4 7E 06        les di, ptr [bp + 6]
60E5  06              push es
60E6  57              push di
60E7  0E              push cs
60E8  E8 63 BD        call 0x1e4e
60EB  08 C0           or al, al
60ED  74 03           je 0x60f2
60EF  E9 9F 01        jmp 0x6291
loc_60F2:
60F2  A0 9F D0        mov al, byte ptr [0xd09f]
60F5  30 E4           xor ah, ah
60F7  6B F8 19        imul di, ax, 0x19
60FA  81 C7 EF CC     add di, 0xccef
60FE  1E              push ds
60FF  57              push di
6100  0E              push cs
6101  E8 C8 BD        call 0x1ecc
6104  98              cwde
6105  8B D0           mov dx, ax
6107  A0 A9 D0        mov al, byte ptr [0xd0a9]
610A  98              cwde
610B  F7 E2           mul dx
610D  09 C0           or ax, ax
610F  7F 03           jg 0x6114
6111  E9 7D 01        jmp 0x6291
loc_6114:
6114  A0 A8 D0        mov al, byte ptr [0xd0a8]
6117  98              cwde
6118  99              cdq
6119  31 D0           xor ax, dx
611B  29 D0           sub ax, dx
611D  8B C8           mov cx, ax
611F  A0 A9 D0        mov al, byte ptr [0xd0a9]
6122  98              cwde
6123  99              cdq
6124  31 D0           xor ax, dx
6126  29 D0           sub ax, dx
6128  2B C1           sub ax, cx
612A  3D 0A 00        cmp ax, 0xa
612D  7F 03           jg 0x6132
612F  E9 5F 01        jmp 0x6291
loc_6132:
6132  C4 7E 06        les di, ptr [bp + 6]
6135  06              push es
6136  57              push di
6137  0E              push cs
6138  E8 64 BD        call 0x1e9f
613B  3C 07           cmp al, 7
613D  73 03           jae 0x6142
613F  E9 4F 01        jmp 0x6291
loc_6142:
6142  3C 0B           cmp al, 0xb
6144  76 03           jbe 0x6149
6146  E9 48 01        jmp 0x6291
loc_6149:
6149  A0 A9 D0        mov al, byte ptr [0xd0a9]
614C  98              cwde
614D  99              cdq
614E  31 D0           xor ax, dx
6150  29 D0           sub ax, dx
6152  3D 1A 00        cmp ax, 0x1a
6155  7C 03           jl 0x615a
6157  E9 83 00        jmp 0x61dd
loc_615A:
615A  80 3E A8 D0 00  cmp byte ptr [0xd0a8], 0
615F  7E 06           jle 0x6167
6161  C6 46 FC 01     mov byte ptr [bp - 4], 1
6165  EB 04           jmp 0x616b
loc_6167:
6167  C6 46 FC FF     mov byte ptr [bp - 4], 0xff
loc_616B:
616B  A0 A8 D0        mov al, byte ptr [0xd0a8]
616E  98              cwde
616F  99              cdq
6170  31 D0           xor ax, dx
6172  29 D0           sub ax, dx
6174  3D 04 00        cmp ax, 4
6177  7E 17           jle 0x6190
6179  A0 9F D0        mov al, byte ptr [0xd09f]
617C  30 E4           xor ah, ah
617E  6B F8 19        imul di, ax, 0x19
6181  81 C7 EF CC     add di, 0xccef
6185  1E              push ds
6186  57              push di
6187  0E              push cs
6188  E8 41 BD        call 0x1ecc
618B  88 46 FD        mov byte ptr [bp - 3], al
618E  EB 04           jmp 0x6194
loc_6190:
6190  C6 46 FD 00     mov byte ptr [bp - 3], 0
loc_6194:
6194  8A 46 FC        mov al, byte ptr [bp - 4]
6197  98              cwde
6198  D1 E0           shl ax, 1
619A  8B D8           mov bx, ax
619C  A0 A8 D0        mov al, byte ptr [0xd0a8]
619F  98              cwde
61A0  99              cdq
61A1  B9 02 00        mov cx, 2
61A4  F7 F9           idiv cx
61A6  2B C3           sub ax, bx
61A8  88 46 FE        mov byte ptr [bp - 2], al
61AB  8A 46 FD        mov al, byte ptr [bp - 3]
61AE  98              cwde
61AF  D1 E0           shl ax, 1
61B1  50              push ax
61B2  A0 9F D0        mov al, byte ptr [0xd09f]
61B5  30 E4           xor ah, ah
61B7  6B F8 19        imul di, ax, 0x19
61BA  81 C7 EF CC     add di, 0xccef
61BE  1E              push ds
61BF  57              push di
61C0  0E              push cs
61C1  E8 08 BD        call 0x1ecc
61C4  98              cwde
61C5  8B F0           mov si, ax
61C7  D1 E0           shl ax, 1
61C9  D1 E0           shl ax, 1
61CB  01 F0           add ax, si
61CD  8B D0           mov dx, ax
61CF  A0 A9 D0        mov al, byte ptr [0xd0a9]
61D2  98              cwde
61D3  03 C2           add ax, dx
61D5  5A              pop dx
61D6  2B C2           sub ax, dx
61D8  88 46 FF        mov byte ptr [bp - 1], al
61DB  EB 59           jmp 0x6236
loc_61DD:
61DD  C6 46 FC 00     mov byte ptr [bp - 4], 0
61E1  C6 46 FD 01     mov byte ptr [bp - 3], 1
61E5  80 3E A8 D0 00  cmp byte ptr [0xd0a8], 0
61EA  B0 00           mov al, 0
61EC  7D 01           jge 0x61ef
61EE  40              inc ax
loc_61EF:
61EF  98              cwde
61F0  8B F8           mov di, ax
61F2  8A 85 38 A3     mov al, byte ptr [di - 0x5cc8]
61F6  98              cwde
61F7  8B F0           mov si, ax
61F9  D1 E0           shl ax, 1
61FB  01 F0           add ax, si
61FD  8B D0           mov dx, ax
61FF  A0 A8 D0        mov al, byte ptr [0xd0a8]
6202  98              cwde
6203  03 C2           add ax, dx
6205  88 46 FE        mov byte ptr [bp - 2], al
6208  80 3E A9 D0 00  cmp byte ptr [0xd0a9], 0
620D  B0 00           mov al, 0
620F  7D 01           jge 0x6212
6211  40              inc ax
loc_6212:
6212  98              cwde
6213  8B F8           mov di, ax
6215  8A 85 38 A3     mov al, byte ptr [di - 0x5cc8]
6219  98              cwde
621A  8B D8           mov bx, ax
621C  A0 A9 D0        mov al, byte ptr [0xd0a9]
621F  98              cwde
6220  99              cdq
6221  31 D0           xor ax, dx
6223  29 D0           sub ax, dx
6225  05 E6 FF        add ax, 0xffe6
6228  99              cdq
6229  B9 02 00        mov cx, 2
622C  F7 F9           idiv cx
622E  05 1C 00        add ax, 0x1c
6231  F7 E3           mul bx
6233  88 46 FF        mov byte ptr [bp - 1], al
loc_6236:
6236  C4 7E 06        les di, ptr [bp + 6]
6239  06              push es
623A  57              push di
623B  0E              push cs
623C  E8 60 BC        call 0x1e9f
623F  30 E4           xor ah, ah
6241  2D 07 00        sub ax, 7
6244  8B D0           mov dx, ax
6246  8A 46 FD        mov al, byte ptr [bp - 3]
6249  98              cwde
624A  F7 E2           mul dx
624C  8B D0           mov dx, ax
624E  8A 46 FF        mov al, byte ptr [bp - 1]
6251  98              cwde
6252  03 C2           add ax, dx
6254  C4 7E 06        les di, ptr [bp + 6]
6257  26 88 45 09     mov byte ptr es:[di + 9], al
625B  06              push es
625C  57              push di
625D  0E              push cs
625E  E8 3E BC        call 0x1e9f
6261  30 E4           xor ah, ah
6263  2D 07 00        sub ax, 7
6266  8B D0           mov dx, ax
6268  8A 46 FC        mov al, byte ptr [bp - 4]
626B  98              cwde
626C  F7 E2           mul dx
626E  8B D0           mov dx, ax
6270  8A 46 FE        mov al, byte ptr [bp - 2]
6273  98              cwde
6274  03 C2           add ax, dx
6276  C4 7E 06        les di, ptr [bp + 6]
6279  26 88 45 08     mov byte ptr es:[di + 8], al
627D  06              push es
627E  57              push di
627F  0E              push cs
6280  E8 16 BD        call 0x1f99
6283  08 C0           or al, al
6285  74 08           je 0x628f
6287  C4 7E 06        les di, ptr [bp + 6]
628A  26 C6 45 13 00  mov byte ptr es:[di + 0x13], 0
loc_628F:
628F  EB 70           jmp 0x6301
loc_6291:
6291  C4 7E 06        les di, ptr [bp + 6]
6294  06              push es
6295  57              push di
6296  0E              push cs
6297  E8 DD D6        call 0x3977
629A  C4 7E 06        les di, ptr [bp + 6]
629D  06              push es
629E  57              push di
629F  0E              push cs
62A0  E8 AB BB        call 0x1e4e
62A3  08 C0           or al, al
62A5  75 5A           jne 0x6301
loc_62A7:
62A7  A0 A9 D0        mov al, byte ptr [0xd0a9]
62AA  98              cwde
62AB  99              cdq
62AC  31 D0           xor ax, dx
62AE  29 D0           sub ax, dx
62B0  8B C8           mov cx, ax
62B2  C4 7E 06        les di, ptr [bp + 6]
62B5  26 8A 45 09     mov al, byte ptr es:[di + 9]
62B9  98              cwde
62BA  99              cdq
62BB  31 D0           xor ax, dx
62BD  29 D0           sub ax, dx
62BF  2B C1           sub ax, cx
62C1  3D 04 00        cmp ax, 4
62C4  7D 1B           jge 0x62e1
62C6  A0 9F D0        mov al, byte ptr [0xd09f]
62C9  30 E4           xor ah, ah
62CB  6B F8 19        imul di, ax, 0x19
62CE  81 C7 EF CC     add di, 0xccef
62D2  1E              push ds
62D3  57              push di
62D4  0E              push cs
62D5  E8 F4 BB        call 0x1ecc
62D8  C4 7E 06        les di, ptr [bp + 6]
62DB  26 00 45 09     add byte ptr es:[di + 9], al
62DF  EB C6           jmp 0x62a7
loc_62E1:
62E1  C4 7E 06        les di, ptr [bp + 6]
62E4  26 8A 45 08     mov al, byte ptr es:[di + 8]
62E8  3A 06 A8 D0     cmp al, byte ptr [0xd0a8]
62EC  75 13           jne 0x6301
62EE  9A 3F 0D AC 24  call far 24AC:0D3F
62F3  98              cwde
62F4  8B F8           mov di, ax
62F6  8A 85 38 A3     mov al, byte ptr [di - 0x5cc8]
62FA  C4 7E 06        les di, ptr [bp + 6]
62FD  26 00 45 08     add byte ptr es:[di + 8], al
loc_6301:
6301  C9              leave
6302  CA 04 00        retf 4

; ---- routine 0AB5:6305  (found by: call)
sub_6305:
6305  C8 08 00 00     enter 8, 0
6309  6B 7E 04 19     imul di, word ptr [bp + 4], 0x19
630D  81 C7 EF CC     add di, 0xccef
6311  1E              push ds
6312  07              pop es
6313  89 7E F8        mov word ptr [bp - 8], di
6316  8C 46 FA        mov word ptr [bp - 6], es
6319  26 8B 05        mov ax, word ptr es:[di]
631C  3B 06 2E 0D     cmp ax, word ptr [0xd2e]
6320  75 03           jne 0x6325
6322  E9 BA 00        jmp 0x63df
loc_6325:
6325  C6 06 53 CF 01  mov byte ptr [0xcf53], 1
632A  26 C6 45 13 0C  mov byte ptr es:[di + 0x13], 0xc
632F  31 C0           xor ax, ax
6331  26 89 45 14     mov word ptr es:[di + 0x14], ax
6335  A1 30 0D        mov ax, word ptr [0xd30]
6338  26 89 45 08     mov word ptr es:[di + 8], ax
633C  A0 B8 D0        mov al, byte ptr [0xd0b8]
633F  88 46 FD        mov byte ptr [bp - 3], al
6342  C6 06 B8 D0 00  mov byte ptr [0xd0b8], 0
6347  A0 BA D0        mov al, byte ptr [0xd0ba]
634A  88 46 FC        mov byte ptr [bp - 4], al
634D  C6 06 BA D0 00  mov byte ptr [0xd0ba], 0
6352  80 3E 74 D0 00  cmp byte ptr [0xd074], 0
6357  75 5C           jne 0x63b5
loc_6359:
6359  C4 7E F8        les di, ptr [bp - 8]
635C  06              push es
635D  57              push di
635E  0E              push cs
635F  E8 59 0F        call 0x72bb
6362  C7 46 FE 01 00  mov word ptr [bp - 2], 1
6367  EB 03           jmp 0x636c
loc_6369:
6369  FF 46 FE        inc word ptr [bp - 2]
loc_636C:
636C  E8 7E 16        call 0x79ed
636F  C4 3E D2 D7     les di, ptr [0xd7d2]
6373  26 8A 45 02     mov al, byte ptr es:[di + 2]
6377  30 E4           xor ah, ah
6379  50              push ax
637A  9A D6 00 94 19  call far 1994:00D6
637F  9A 58 0C AC 24  call far 24AC:0C58
6384  08 C0           or al, al
6386  74 05           je 0x638d
6388  9A 9B 09 1A 23  call far 231A:099B
loc_638D:
638D  6B 7E FE 19     imul di, word ptr [bp - 2], 0x19
6391  81 C7 EF CC     add di, 0xccef
6395  1E              push ds
6396  57              push di
6397  0E              push cs
6398  E8 8D 0A        call 0x6e28
639B  83 7E FE 16     cmp word ptr [bp - 2], 0x16
639F  75 C8           jne 0x6369
63A1  C4 7E F8        les di, ptr [bp - 8]
63A4  06              push es
63A5  57              push di
63A6  0E              push cs
63A7  E8 EF BB        call 0x1f99
63AA  08 C0           or al, al
63AC  75 07           jne 0x63b5
63AE  80 3E 74 D0 00  cmp byte ptr [0xd074], 0
63B3  74 A4           je 0x6359
loc_63B5:
63B5  8A 46 FC        mov al, byte ptr [bp - 4]
63B8  A2 BA D0        mov byte ptr [0xd0ba], al
63BB  8A 46 FD        mov al, byte ptr [bp - 3]
63BE  A2 B8 D0        mov byte ptr [0xd0b8], al
63C1  A1 2E 0D        mov ax, word ptr [0xd2e]
63C4  C4 7E F8        les di, ptr [bp - 8]
63C7  26 89 05        mov word ptr es:[di], ax
63CA  80 3E 74 D0 00  cmp byte ptr [0xd074], 0
63CF  75 06           jne 0x63d7
63D1  06              push es
63D2  57              push di
63D3  0E              push cs
63D4  E8 51 0A        call 0x6e28
loc_63D7:
63D7  C4 7E F8        les di, ptr [bp - 8]
63DA  26 C6 45 13 00  mov byte ptr es:[di + 0x13], 0
loc_63DF:
63DF  C9              leave
63E0  C2 02 00        ret 2

