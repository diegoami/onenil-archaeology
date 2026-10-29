; 1-095.EXE (One-Nil 95), code segment 0AB5 (image offsets 0AB50..1993F), part 7 of 22
; packed 1-095.EXE sha256 f659fb2d334500d6901fc8d6a0f06c85c0ccda2eb4a3035ae3bb0a0004d79192 (LZEXE 0.91)
; unpacked (tools/static/unlzexe.py) sha256 8df646e017e0965a5d90a58181ca764219ad847833aad0b6cb58fc53372bfb2c
; tool: capstone 5.0.9 (pip package; core library 5.0.1280) (CS_ARCH_X86, CS_MODE_16), recursive descent from the entry point, far calls and near calls/jumps, then routine prologues (55 89 E5 / 55 8B EC / C8 iw 00) in what remains; tools/static/listing.py
; addresses are SEGMENT:OFFSET with SEGMENT the image paragraph before relocation; image offset = SEGMENT*16+OFFSET
; ---- routine 0AB5:3D37  (found by: call)
sub_3D37:
3D37  C8 02 00 00     enter 2, 0
3D3B  E8 98 DF        call 0x1cd6
3D3E  08 C0           or al, al
3D40  B0 00           mov al, 0
3D42  75 01           jne 0x3d45
3D44  40              inc ax
loc_3D45:
3D45  98              cwde
3D46  8B F8           mov di, ax
3D48  8A 85 56 0D     mov al, byte ptr [di + 0xd56]
3D4C  30 E4           xor ah, ah
3D4E  40              inc ax
3D4F  6B F8 19        imul di, ax, 0x19
3D52  80 BD 02 CD 0D  cmp byte ptr [di - 0x32fe], 0xd
3D57  B0 00           mov al, 0
3D59  75 01           jne 0x3d5c
3D5B  40              inc ax
loc_3D5C:
3D5C  88 46 FF        mov byte ptr [bp - 1], al
3D5F  8A 46 FF        mov al, byte ptr [bp - 1]
3D62  C9              leave
3D63  C2 02 00        ret 2

; ---- routine 0AB5:3D66  (found by: call)
sub_3D66:
3D66  C8 04 00 00     enter 4, 0
3D6A  8B 7E 04        mov di, word ptr [bp + 4]
3D6D  36 C4 7D 06     les di, ptr ss:[di + 6]
3D71  06              push es
3D72  57              push di
3D73  0E              push cs
3D74  E8 95 E1        call 0x1f0c
3D77  08 C0           or al, al
3D79  75 03           jne 0x3d7e
3D7B  E9 E1 02        jmp 0x405f
loc_3D7E:
3D7E  C6 46 FF 01     mov byte ptr [bp - 1], 1
3D82  8B 7E 04        mov di, word ptr [bp + 4]
3D85  36 C4 7D 06     les di, ptr ss:[di + 6]
3D89  06              push es
3D8A  57              push di
3D8B  0E              push cs
3D8C  E8 69 F8        call 0x35f8
3D8F  8B 7E 04        mov di, word ptr [bp + 4]
3D92  36 C4 7D 06     les di, ptr ss:[di + 6]
3D96  26 8A 45 07     mov al, byte ptr es:[di + 7]
3D9A  30 E4           xor ah, ah
3D9C  50              push ax
3D9D  E8 60 C2        call 0
3DA0  08 C0           or al, al
3DA2  74 61           je 0x3e05
3DA4  8B 7E 04        mov di, word ptr [bp + 4]
3DA7  36 C4 7D 06     les di, ptr ss:[di + 6]
3DAB  26 8A 45 01     mov al, byte ptr es:[di + 1]
3DAF  98              cwde
3DB0  99              cdq
3DB1  31 D0           xor ax, dx
3DB3  29 D0           sub ax, dx
3DB5  3D 1A 00        cmp ax, 0x1a
3DB8  75 08           jne 0x3dc2
3DBA  06              push es
3DBB  57              push di
3DBC  0E              push cs
3DBD  E8 C4 EE        call 0x2c84
3DC0  EB 40           jmp 0x3e02
loc_3DC2:
3DC2  8B 7E 04        mov di, word ptr [bp + 4]
3DC5  36 C4 7D 06     les di, ptr ss:[di + 6]
3DC9  26 8A 45 09     mov al, byte ptr es:[di + 9]
3DCD  98              cwde
3DCE  99              cdq
3DCF  31 D0           xor ax, dx
3DD1  29 D0           sub ax, dx
3DD3  3D 1A 00        cmp ax, 0x1a
3DD6  74 2A           je 0x3e02
3DD8  06              push es
3DD9  57              push di
3DDA  0E              push cs
3DDB  E8 EE E0        call 0x1ecc
3DDE  98              cwde
3DDF  6B C0 E6        imul ax, ax, -0x1a
3DE2  8B 7E 04        mov di, word ptr [bp + 4]
3DE5  36 C4 7D 06     les di, ptr ss:[di + 6]
3DE9  26 88 45 09     mov byte ptr es:[di + 9], al
3DED  6A 09           push 9
3DEF  9A 6D 07 1A 23  call far 231A:076D
3DF4  05 FB FF        add ax, 0xfffb
3DF7  8B 7E 04        mov di, word ptr [bp + 4]
3DFA  36 C4 7D 06     les di, ptr ss:[di + 6]
3DFE  26 88 45 08     mov byte ptr es:[di + 8], al
loc_3E02:
3E02  E9 58 02        jmp 0x405d
loc_3E05:
3E05  8B 7E 04        mov di, word ptr [bp + 4]
3E08  36 C4 7D 06     les di, ptr ss:[di + 6]
3E0C  06              push es
3E0D  57              push di
3E0E  0E              push cs
3E0F  E8 C8 F4        call 0x32da
3E12  E8 83 F2        call 0x3098
3E15  08 C0           or al, al
3E17  75 03           jne 0x3e1c
3E19  E9 97 00        jmp 0x3eb3
loc_3E1C:
3E1C  FF 36 34 0D     push word ptr [0xd34]
3E20  8B 7E 04        mov di, word ptr [bp + 4]
3E23  36 C4 7D 06     les di, ptr ss:[di + 6]
3E27  06              push es
3E28  57              push di
3E29  0E              push cs
3E2A  E8 31 E1        call 0x1f5e
3E2D  8B 7E 04        mov di, word ptr [bp + 4]
3E30  36 C4 7D 06     les di, ptr ss:[di + 6]
3E34  26 89 45 08     mov word ptr es:[di + 8], ax
3E38  55              push bp
3E39  E8 FB FE        call 0x3d37
3E3C  08 C0           or al, al
3E3E  75 3F           jne 0x3e7f
3E40  8B 7E 04        mov di, word ptr [bp + 4]
3E43  36 C4 7D 06     les di, ptr ss:[di + 6]
3E47  26 8A 05        mov al, byte ptr es:[di]
3E4A  98              cwde
3E4B  99              cdq
3E4C  31 D0           xor ax, dx
3E4E  29 D0           sub ax, dx
3E50  3D 02 00        cmp ax, 2
3E53  7D 4F           jge 0x3ea4
3E55  E8 48 DB        call 0x19a0
3E58  05 14 00        add ax, 0x14
3E5B  50              push ax
3E5C  8B 7E 04        mov di, word ptr [bp + 4]
3E5F  36 C4 7D 06     les di, ptr ss:[di + 6]
3E63  06              push es
3E64  57              push di
3E65  0E              push cs
3E66  E8 63 E0        call 0x1ecc
3E69  98              cwde
3E6A  8B D0           mov dx, ax
3E6C  8B 7E 04        mov di, word ptr [bp + 4]
3E6F  36 C4 7D 06     les di, ptr ss:[di + 6]
3E73  26 8A 45 01     mov al, byte ptr es:[di + 1]
3E77  98              cwde
3E78  F7 E2           mul dx
3E7A  5A              pop dx
3E7B  3B C2           cmp ax, dx
3E7D  7E 25           jle 0x3ea4
loc_3E7F:
3E7F  80 3E 54 CF 00  cmp byte ptr [0xcf54], 0
3E84  74 0F           je 0x3e95
3E86  8B 7E 04        mov di, word ptr [bp + 4]
3E89  36 C4 7D 06     les di, ptr ss:[di + 6]
3E8D  06              push es
3E8E  57              push di
3E8F  0E              push cs
3E90  E8 57 F0        call 0x2eea
3E93  EB 0F           jmp 0x3ea4
loc_3E95:
3E95  6A 11           push 0x11
3E97  8B 7E 04        mov di, word ptr [bp + 4]
3E9A  36 C4 7D 06     les di, ptr ss:[di + 6]
3E9E  06              push es
3E9F  57              push di
3EA0  0E              push cs
3EA1  E8 30 F0        call 0x2ed4
loc_3EA4:
3EA4  80 3E 54 CF 00  cmp byte ptr [0xcf54], 0
3EA9  74 05           je 0x3eb0
3EAB  C6 06 54 CF 00  mov byte ptr [0xcf54], 0
loc_3EB0:
3EB0  E9 AA 01        jmp 0x405d
loc_3EB3:
3EB3  8B 7E 04        mov di, word ptr [bp + 4]
3EB6  36 C4 7D 06     les di, ptr ss:[di + 6]
3EBA  06              push es
3EBB  57              push di
3EBC  0E              push cs
3EBD  E8 9D E2        call 0x215d
3EC0  08 C0           or al, al
3EC2  75 03           jne 0x3ec7
3EC4  E9 C3 00        jmp 0x3f8a
loc_3EC7:
3EC7  80 3E 54 CF 00  cmp byte ptr [0xcf54], 0
3ECC  75 37           jne 0x3f05
3ECE  55              push bp
3ECF  E8 65 FE        call 0x3d37
3ED2  08 C0           or al, al
3ED4  75 2F           jne 0x3f05
3ED6  8B 7E 04        mov di, word ptr [bp + 4]
3ED9  36 C4 7D 06     les di, ptr ss:[di + 6]
3EDD  26 8B 45 0E     mov ax, word ptr es:[di + 0xe]
3EE1  C1 E0 03        shl ax, 3
3EE4  C4 3E BA D7     les di, ptr [0xd7ba]
3EE8  03 F8           add di, ax
3EEA  26 8A 45 06     mov al, byte ptr es:[di + 6]
3EEE  30 E4           xor ah, ah
3EF0  8B F8           mov di, ax
3EF2  8A 85 81 0A     mov al, byte ptr [di + 0xa81]
3EF6  30 E4           xor ah, ah
3EF8  50              push ax
3EF9  9A 1C 0D AC 24  call far 24AC:0D1C
3EFE  08 C0           or al, al
3F00  75 03           jne 0x3f05
3F02  E9 85 00        jmp 0x3f8a
loc_3F05:
3F05  80 3E 54 CF 00  cmp byte ptr [0xcf54], 0
3F0A  74 60           je 0x3f6c
3F0C  8B 7E 04        mov di, word ptr [bp + 4]
3F0F  36 C4 7D 06     les di, ptr ss:[di + 6]
3F13  26 FF 35        push word ptr es:[di]
3F16  06              push es
3F17  57              push di
3F18  0E              push cs
3F19  E8 0D E2        call 0x2129
3F1C  08 C0           or al, al
3F1E  74 0F           je 0x3f2f
3F20  8B 7E 04        mov di, word ptr [bp + 4]
3F23  36 C4 7D 06     les di, ptr ss:[di + 6]
3F27  06              push es
3F28  57              push di
3F29  0E              push cs
3F2A  E8 BD EF        call 0x2eea
3F2D  EB 3B           jmp 0x3f6a
loc_3F2F:
3F2F  8B 7E 04        mov di, word ptr [bp + 4]
3F32  36 C4 7D 06     les di, ptr ss:[di + 6]
3F36  26 8B 45 0E     mov ax, word ptr es:[di + 0xe]
3F3A  C1 E0 03        shl ax, 3
3F3D  C4 3E BA D7     les di, ptr [0xd7ba]
3F41  03 F8           add di, ax
3F43  26 8A 45 06     mov al, byte ptr es:[di + 6]
3F47  30 E4           xor ah, ah
3F49  8B F8           mov di, ax
3F4B  8A 85 81 0A     mov al, byte ptr [di + 0xa81]
3F4F  30 E4           xor ah, ah
3F51  50              push ax
3F52  9A 1C 0D AC 24  call far 24AC:0D1C
3F57  08 C0           or al, al
3F59  74 0F           je 0x3f6a
3F5B  6A 12           push 0x12
3F5D  8B 7E 04        mov di, word ptr [bp + 4]
3F60  36 C4 7D 06     les di, ptr ss:[di + 6]
3F64  06              push es
3F65  57              push di
3F66  0E              push cs
3F67  E8 6A EF        call 0x2ed4
loc_3F6A:
3F6A  EB 0F           jmp 0x3f7b
loc_3F6C:
3F6C  6A 11           push 0x11
3F6E  8B 7E 04        mov di, word ptr [bp + 4]
3F71  36 C4 7D 06     les di, ptr ss:[di + 6]
3F75  06              push es
3F76  57              push di
3F77  0E              push cs
3F78  E8 59 EF        call 0x2ed4
loc_3F7B:
3F7B  80 3E 54 CF 00  cmp byte ptr [0xcf54], 0
3F80  74 05           je 0x3f87
3F82  C6 06 54 CF 00  mov byte ptr [0xcf54], 0
loc_3F87:
3F87  E9 D3 00        jmp 0x405d
loc_3F8A:
3F8A  8B 7E 04        mov di, word ptr [bp + 4]
3F8D  36 C4 7D 06     les di, ptr ss:[di + 6]
3F91  06              push es
3F92  57              push di
3F93  0E              push cs
3F94  E8 35 DF        call 0x1ecc
3F97  98              cwde
3F98  8B D0           mov dx, ax
3F9A  8B 7E 04        mov di, word ptr [bp + 4]
3F9D  36 C4 7D 06     les di, ptr ss:[di + 6]
3FA1  26 8A 45 01     mov al, byte ptr es:[di + 1]
3FA5  98              cwde
3FA6  F7 E2           mul dx
3FA8  3D EC FF        cmp ax, 0xffec
3FAB  7D 26           jge 0x3fd3
3FAD  6A 04           push 4
3FAF  9A 1C 0D AC 24  call far 24AC:0D1C
3FB4  08 C0           or al, al
3FB6  74 11           je 0x3fc9
3FB8  6A 09           push 9
3FBA  8B 7E 04        mov di, word ptr [bp + 4]
3FBD  36 C4 7D 06     les di, ptr ss:[di + 6]
3FC1  06              push es
3FC2  57              push di
3FC3  0E              push cs
3FC4  E8 37 EF        call 0x2efe
3FC7  EB 07           jmp 0x3fd0
loc_3FC9:
3FC9  8B 7E 04        mov di, word ptr [bp + 4]
3FCC  57              push di
3FCD  E8 FF FB        call 0x3bcf
loc_3FD0:
3FD0  E9 8A 00        jmp 0x405d
loc_3FD3:
3FD3  E8 CA D9        call 0x19a0
3FD6  05 14 00        add ax, 0x14
3FD9  50              push ax
3FDA  8B 7E 04        mov di, word ptr [bp + 4]
3FDD  36 C4 7D 06     les di, ptr ss:[di + 6]
3FE1  06              push es
3FE2  57              push di
3FE3  0E              push cs
3FE4  E8 E5 DE        call 0x1ecc
3FE7  98              cwde
3FE8  8B D0           mov dx, ax
3FEA  8B 7E 04        mov di, word ptr [bp + 4]
3FED  36 C4 7D 06     les di, ptr ss:[di + 6]
3FF1  26 8A 45 01     mov al, byte ptr es:[di + 1]
3FF5  98              cwde
3FF6  F7 E2           mul dx
3FF8  5A              pop dx
3FF9  3B C2           cmp ax, dx
3FFB  7E 16           jle 0x4013
3FFD  26 8A 05        mov al, byte ptr es:[di]
4000  98              cwde
4001  99              cdq
4002  31 D0           xor ax, dx
4004  29 D0           sub ax, dx
4006  3D 03 00        cmp ax, 3
4009  7E 08           jle 0x4013
400B  06              push es
400C  57              push di
400D  0E              push cs
400E  E8 42 EE        call 0x2e53
4011  EB 4A           jmp 0x405d
loc_4013:
4013  6A 02           push 2
4015  8B 7E 04        mov di, word ptr [bp + 4]
4018  36 C4 7D 06     les di, ptr ss:[di + 6]
401C  06              push es
401D  57              push di
401E  0E              push cs
401F  E8 2A DA        call 0x1a4c
4022  08 C0           or al, al
4024  74 09           je 0x402f
4026  9A 3F 0D AC 24  call far 24AC:0D3F
402B  08 C0           or al, al
402D  75 27           jne 0x4056
loc_402F:
402F  8B 7E 04        mov di, word ptr [bp + 4]
4032  36 C4 7D 06     les di, ptr ss:[di + 6]
4036  26 6B 45 0E 0F  imul ax, word ptr es:[di + 0xe], 0xf
403B  C4 3E BE D7     les di, ptr [0xd7be]
403F  03 F8           add di, ax
4041  26 8A 45 08     mov al, byte ptr es:[di + 8]
4045  98              cwde
4046  99              cdq
4047  B9 02 00        mov cx, 2
404A  F7 F9           idiv cx
404C  50              push ax
404D  9A 1C 0D AC 24  call far 24AC:0D1C
4052  08 C0           or al, al
4054  74 07           je 0x405d
loc_4056:
4056  8B 7E 04        mov di, word ptr [bp + 4]
4059  57              push di
405A  E8 72 FB        call 0x3bcf
loc_405D:
405D  EB 04           jmp 0x4063
loc_405F:
405F  C6 46 FF 00     mov byte ptr [bp - 1], 0
loc_4063:
4063  8A 46 FF        mov al, byte ptr [bp - 1]
4066  C9              leave
4067  C2 02 00        ret 2

; ---- routine 0AB5:406A  (found by: call)
sub_406A:
406A  C8 02 00 00     enter 2, 0
406E  8B 7E 04        mov di, word ptr [bp + 4]
4071  36 C4 7D 06     les di, ptr ss:[di + 6]
4075  26 8A 45 07     mov al, byte ptr es:[di + 7]
4079  3A 06 A0 D0     cmp al, byte ptr [0xd0a0]
407D  75 39           jne 0x40b8
407F  C6 46 FF 01     mov byte ptr [bp - 1], 1
4083  26 8A 45 07     mov al, byte ptr es:[di + 7]
4087  30 E4           xor ah, ah
4089  50              push ax
408A  E8 73 BF        call 0
408D  08 C0           or al, al
408F  75 07           jne 0x4098
4091  83 3E 51 CF 0A  cmp word ptr [0xcf51], 0xa
4096  73 10           jae 0x40a8
loc_4098:
4098  A1 46 CF        mov ax, word ptr [0xcf46]
409B  8B 7E 04        mov di, word ptr [bp + 4]
409E  36 C4 7D 06     les di, ptr ss:[di + 6]
40A2  26 89 45 08     mov word ptr es:[di + 8], ax
40A6  EB 0E           jmp 0x40b6
loc_40A8:
40A8  A1 A6 D0        mov ax, word ptr [0xd0a6]
40AB  8B 7E 04        mov di, word ptr [bp + 4]
40AE  36 C4 7D 06     les di, ptr ss:[di + 6]
40B2  26 89 45 08     mov word ptr es:[di + 8], ax
loc_40B6:
40B6  EB 04           jmp 0x40bc
loc_40B8:
40B8  C6 46 FF 00     mov byte ptr [bp - 1], 0
loc_40BC:
40BC  8A 46 FF        mov al, byte ptr [bp - 1]
40BF  C9              leave
40C0  C2 02 00        ret 2

; ---- routine 0AB5:40C3  (found by: call)
sub_40C3:
40C3  55              push bp
40C4  89 E5           mov bp, sp
40C6  A0 9F D0        mov al, byte ptr [0xd09f]
40C9  30 E4           xor ah, ah
40CB  50              push ax
40CC  E8 31 BF        call 0
40CF  08 C0           or al, al
40D1  74 03           je 0x40d6
40D3  E9 A6 00        jmp 0x417c
loc_40D6:
40D6  A0 9F D0        mov al, byte ptr [0xd09f]
40D9  30 E4           xor ah, ah
40DB  6B F8 19        imul di, ax, 0x19
40DE  81 C7 EF CC     add di, 0xccef
40E2  1E              push ds
40E3  57              push di
40E4  0E              push cs
40E5  E8 39 FA        call 0x3b21
40E8  80 3E 54 CF 00  cmp byte ptr [0xcf54], 0
40ED  75 09           jne 0x40f8
40EF  6A 64           push 0x64
40F1  6A 05           push 5
40F3  9A 34 01 94 19  call far 1994:0134
loc_40F8:
40F8  80 3E 54 CF 00  cmp byte ptr [0xcf54], 0
40FD  75 2F           jne 0x412e
40FF  6A 06           push 6
4101  8B 7E 04        mov di, word ptr [bp + 4]
4104  36 8B 7D 04     mov di, word ptr ss:[di + 4]
4108  36 C4 7D 06     les di, ptr ss:[di + 6]
410C  06              push es
410D  57              push di
410E  0E              push cs
410F  E8 C4 DA        call 0x1bd6
4112  08 C0           or al, al
4114  74 18           je 0x412e
4116  8B 7E 04        mov di, word ptr [bp + 4]
4119  36 8B 7D 04     mov di, word ptr ss:[di + 4]
411D  36 C4 7D 06     les di, ptr ss:[di + 6]
4121  06              push es
4122  57              push di
4123  0E              push cs
4124  E8 47 2E        call 0x6f6e
4127  6A 0E           push 0xe
4129  E8 8B DC        call 0x1db7
412C  EB 4E           jmp 0x417c
loc_412E:
412E  80 3E 54 CF 00  cmp byte ptr [0xcf54], 0
4133  74 2C           je 0x4161
4135  FF 36 46 CF     push word ptr [0xcf46]
4139  8B 7E 04        mov di, word ptr [bp + 4]
413C  36 8B 7D 04     mov di, word ptr ss:[di + 4]
4140  36 C4 7D 06     les di, ptr ss:[di + 6]
4144  06              push es
4145  57              push di
4146  0E              push cs
4147  E8 AB DF        call 0x20f5
414A  08 C0           or al, al
414C  74 13           je 0x4161
414E  8B 7E 04        mov di, word ptr [bp + 4]
4151  36 8B 7D 04     mov di, word ptr ss:[di + 4]
4155  36 C4 7D 06     les di, ptr ss:[di + 6]
4159  06              push es
415A  57              push di
415B  0E              push cs
415C  E8 11 EF        call 0x3070
415F  EB 1B           jmp 0x417c
loc_4161:
4161  8B 7E 04        mov di, word ptr [bp + 4]
4164  36 8B 7D 04     mov di, word ptr ss:[di + 4]
4168  36 C4 7D 06     les di, ptr ss:[di + 6]
416C  06              push es
416D  57              push di
416E  0E              push cs
416F  E8 3F 09        call 0x4ab1
4172  6A 0E           push 0xe
4174  E8 40 DC        call 0x1db7
4177  6A 21           push 0x21
4179  E8 3B DC        call 0x1db7
loc_417C:
417C  C9              leave
417D  C2 02 00        ret 2

; ---- routine 0AB5:4180  (found by: call)
sub_4180:
4180  C8 02 00 00     enter 2, 0
4184  C6 46 FF 00     mov byte ptr [bp - 1], 0
4188  A0 54 CF        mov al, byte ptr [0xcf54]
418B  98              cwde
418C  8B F8           mov di, ax
418E  8A 85 92 0A     mov al, byte ptr [di + 0xa92]
4192  30 E4           xor ah, ah
4194  50              push ax
4195  A0 9F D0        mov al, byte ptr [0xd09f]
4198  30 E4           xor ah, ah
419A  6B F8 19        imul di, ax, 0x19
419D  81 C7 EF CC     add di, 0xccef
41A1  1E              push ds
41A2  57              push di
41A3  0E              push cs
41A4  E8 3B D9        call 0x1ae2
41A7  50              push ax
41A8  9A 6D 07 1A 23  call far 231A:076D
41AD  50              push ax
41AE  80 3E 54 CF 00  cmp byte ptr [0xcf54], 0
41B3  75 19           jne 0x41ce
41B5  8B 7E 04        mov di, word ptr [bp + 4]
41B8  36 8B 7D 04     mov di, word ptr ss:[di + 4]
41BC  36 C4 7D 06     les di, ptr ss:[di + 6]
41C0  06              push es
41C1  57              push di
41C2  0E              push cs
41C3  E8 6D DD        call 0x1f33
41C6  08 C0           or al, al
41C8  74 04           je 0x41ce
41CA  B0 00           mov al, 0
41CC  EB 02           jmp 0x41d0
loc_41CE:
41CE  B0 01           mov al, 1
loc_41D0:
41D0  98              cwde
41D1  8B F8           mov di, ax
41D3  8A 85 94 0A     mov al, byte ptr [di + 0xa94]
41D7  30 E4           xor ah, ah
41D9  50              push ax
41DA  A0 54 CF        mov al, byte ptr [0xcf54]
41DD  98              cwde
41DE  8B F8           mov di, ax
41E0  8A 85 90 0A     mov al, byte ptr [di + 0xa90]
41E4  30 E4           xor ah, ah
41E6  50              push ax
41E7  8B 7E 04        mov di, word ptr [bp + 4]
41EA  36 8B 7D 04     mov di, word ptr ss:[di + 4]
41EE  36 C4 7D 06     les di, ptr ss:[di + 6]
41F2  06              push es
41F3  57              push di
41F4  0E              push cs
41F5  E8 EA D8        call 0x1ae2
41F8  5A              pop dx
41F9  F7 E2           mul dx
41FB  50              push ax
41FC  9A 6D 07 1A 23  call far 231A:076D
4201  5A              pop dx
4202  3B C2           cmp ax, dx
4204  7E 0B           jle 0x4211
4206  8B 7E 04        mov di, word ptr [bp + 4]
4209  57              push di
420A  E8 B6 FE        call 0x40c3
420D  C6 46 FF 01     mov byte ptr [bp - 1], 1
loc_4211:
4211  8A 46 FF        mov al, byte ptr [bp - 1]
4214  C9              leave
4215  C2 02 00        ret 2

; ---- routine 0AB5:4218  (found by: call)
sub_4218:
4218  C8 02 00 00     enter 2, 0
421C  C6 46 FF 00     mov byte ptr [bp - 1], 0
4220  8B 7E 04        mov di, word ptr [bp + 4]
4223  36 8B 7D 04     mov di, word ptr ss:[di + 4]
4227  36 C4 7D 06     les di, ptr ss:[di + 6]
422B  06              push es
422C  57              push di
422D  0E              push cs
422E  E8 29 F9        call 0x3b5a
4231  08 C0           or al, al
4233  74 2B           je 0x4260
4235  9A 3F 0D AC 24  call far 24AC:0D3F
423A  08 C0           or al, al
423C  74 17           je 0x4255
423E  8B 7E 04        mov di, word ptr [bp + 4]
4241  36 8B 7D 04     mov di, word ptr ss:[di + 4]
4245  36 C4 7D 06     les di, ptr ss:[di + 6]
4249  26 8A 45 07     mov al, byte ptr es:[di + 7]
424D  30 E4           xor ah, ah
424F  50              push ax
4250  E8 7B 2A        call 0x6cce
4253  EB 07           jmp 0x425c
loc_4255:
4255  8B 7E 04        mov di, word ptr [bp + 4]
4258  57              push di
4259  E8 67 FE        call 0x40c3
loc_425C:
425C  C6 46 FF 01     mov byte ptr [bp - 1], 1
loc_4260:
4260  8A 46 FF        mov al, byte ptr [bp - 1]
4263  C9              leave
4264  C2 02 00        ret 2

; ---- routine 0AB5:4267  (found by: call)
sub_4267:
4267  C8 02 00 00     enter 2, 0
426B  C6 46 FF 00     mov byte ptr [bp - 1], 0
426F  80 3E B8 D0 00  cmp byte ptr [0xd0b8], 0
4274  75 03           jne 0x4279
4276  E9 8D 00        jmp 0x4306
loc_4279:
4279  8B 7E 04        mov di, word ptr [bp + 4]
427C  36 C4 7D 06     les di, ptr ss:[di + 6]
4280  06              push es
4281  57              push di
4282  0E              push cs
4283  E8 30 DD        call 0x1fb6
4286  08 C0           or al, al
4288  75 18           jne 0x42a2
428A  A0 9F D0        mov al, byte ptr [0xd09f]
428D  30 E4           xor ah, ah
428F  6B F8 19        imul di, ax, 0x19
4292  8B 85 EF CC     mov ax, word ptr [di - 0x3311]
4296  8B 7E 04        mov di, word ptr [bp + 4]
4299  36 C4 7D 06     les di, ptr ss:[di + 6]
429D  26 3B 05        cmp ax, word ptr es:[di]
42A0  75 64           jne 0x4306
loc_42A2:
42A2  8B 7E 04        mov di, word ptr [bp + 4]
42A5  36 C4 7D 06     les di, ptr ss:[di + 6]
42A9  06              push es
42AA  57              push di
42AB  0E              push cs
42AC  E8 9F DB        call 0x1e4e
42AF  08 C0           or al, al
42B1  75 53           jne 0x4306
42B3  80 3E 53 CF 00  cmp byte ptr [0xcf53], 0
42B8  75 4C           jne 0x4306
42BA  A0 9F D0        mov al, byte ptr [0xd09f]
42BD  30 E4           xor ah, ah
42BF  50              push ax
42C0  E8 3D BD        call 0
42C3  08 C0           or al, al
42C5  75 3F           jne 0x4306
42C7  8B 7E 04        mov di, word ptr [bp + 4]
42CA  36 C4 7D 06     les di, ptr ss:[di + 6]
42CE  06              push es
42CF  57              push di
42D0  0E              push cs
42D1  E8 89 DE        call 0x215d
42D4  08 C0           or al, al
42D6  75 2E           jne 0x4306
42D8  8B 7E 04        mov di, word ptr [bp + 4]
42DB  36 C4 7D 06     les di, ptr ss:[di + 6]
42DF  06              push es
42E0  57              push di
42E1  0E              push cs
42E2  E8 E7 DB        call 0x1ecc
42E5  98              cwde
42E6  8B D0           mov dx, ax
42E8  8B 7E 04        mov di, word ptr [bp + 4]
42EB  36 C4 7D 06     les di, ptr ss:[di + 6]
42EF  26 8A 45 01     mov al, byte ptr es:[di + 1]
42F3  98              cwde
42F4  F7 E2           mul dx
42F6  09 C0           or ax, ax
42F8  7E 0F           jle 0x4309
42FA  6A 06           push 6
42FC  06              push es
42FD  57              push di
42FE  0E              push cs
42FF  E8 D4 D8        call 0x1bd6
4302  08 C0           or al, al
4304  75 03           jne 0x4309
loc_4306:
4306  E9 C2 00        jmp 0x43cb
loc_4309:
4309  C6 46 FF 01     mov byte ptr [bp - 1], 1
430D  80 3E A1 D0 00  cmp byte ptr [0xd0a1], 0
4312  76 06           jbe 0x431a
4314  E8 A9 2A        call 0x6dc0
4317  E9 B1 00        jmp 0x43cb
loc_431A:
431A  8B 7E 04        mov di, word ptr [bp + 4]
431D  36 C4 7D 06     les di, ptr ss:[di + 6]
4321  26 8A 45 07     mov al, byte ptr es:[di + 7]
4325  30 E4           xor ah, ah
4327  50              push ax
4328  E8 D5 BC        call 0
432B  08 C0           or al, al
432D  74 10           je 0x433f
432F  8B 7E 04        mov di, word ptr [bp + 4]
4332  36 C4 7D 06     les di, ptr ss:[di + 6]
4336  06              push es
4337  57              push di
4338  0E              push cs
4339  E8 B5 04        call 0x47f1
433C  E9 8C 00        jmp 0x43cb
loc_433F:
433F  80 3E 54 CF 00  cmp byte ptr [0xcf54], 0
4344  74 11           je 0x4357
4346  6A 41           push 0x41
4348  8B 7E 04        mov di, word ptr [bp + 4]
434B  36 C4 7D 06     les di, ptr ss:[di + 6]
434F  06              push es
4350  57              push di
4351  0E              push cs
4352  E8 D3 DA        call 0x1e28
4355  EB 0F           jmp 0x4366
loc_4357:
4357  6A 0B           push 0xb
4359  8B 7E 04        mov di, word ptr [bp + 4]
435C  36 C4 7D 06     les di, ptr ss:[di + 6]
4360  06              push es
4361  57              push di
4362  0E              push cs
4363  E8 C2 DA        call 0x1e28
loc_4366:
4366  55              push bp
4367  E8 16 FE        call 0x4180
436A  08 C0           or al, al
436C  75 5D           jne 0x43cb
436E  55              push bp
436F  E8 A6 FE        call 0x4218
4372  08 C0           or al, al
4374  75 55           jne 0x43cb
4376  E8 89 ED        call 0x3102
4379  08 C0           or al, al
437B  75 4E           jne 0x43cb
437D  A0 9F D0        mov al, byte ptr [0xd09f]
4380  30 E4           xor ah, ah
4382  50              push ax
4383  E8 7A BC        call 0
4386  08 C0           or al, al
4388  75 41           jne 0x43cb
438A  8B 7E 04        mov di, word ptr [bp + 4]
438D  36 C4 7D 06     les di, ptr ss:[di + 6]
4391  06              push es
4392  57              push di
4393  0E              push cs
4394  E8 8A F7        call 0x3b21
4397  80 3E 54 CF 00  cmp byte ptr [0xcf54], 0
439C  75 07           jne 0x43a5
439E  6A 0C           push 0xc
43A0  E8 14 DA        call 0x1db7
43A3  EB 26           jmp 0x43cb
loc_43A5:
43A5  A0 9F D0        mov al, byte ptr [0xd09f]
43A8  30 E4           xor ah, ah
43AA  6B F8 19        imul di, ax, 0x19
43AD  81 C7 EF CC     add di, 0xccef
43B1  1E              push ds
43B2  57              push di
43B3  0E              push cs
43B4  E8 E8 DA        call 0x1e9f
43B7  30 E4           xor ah, ah
43B9  D1 E0           shl ax, 1
43BB  50              push ax
43BC  E8 17 D9        call 0x1cd6
43BF  98              cwde
43C0  6B F8 28        imul di, ax, 0x28
43C3  58              pop ax
43C4  03 F8           add di, ax
43C6  83 85 46 D1 0A  add word ptr [di - 0x2eba], 0xa
loc_43CB:
43CB  8A 46 FF        mov al, byte ptr [bp - 1]
43CE  C9              leave
43CF  C2 02 00        ret 2

; ---- routine 0AB5:43D2  (found by: call)
sub_43D2:
43D2  C8 02 00 00     enter 2, 0
43D6  C6 46 FF 00     mov byte ptr [bp - 1], 0
43DA  80 3E A1 D0 00  cmp byte ptr [0xd0a1], 0
43DF  76 2E           jbe 0x440f
43E1  A0 A1 D0        mov al, byte ptr [0xd0a1]
43E4  30 E4           xor ah, ah
43E6  6B F8 19        imul di, ax, 0x19
43E9  81 C7 EF CC     add di, 0xccef
43ED  1E              push ds
43EE  57              push di
43EF  0E              push cs
43F0  E8 D9 DA        call 0x1ecc
43F3  08 C0           or al, al
43F5  B0 00           mov al, 0
43F7  7D 01           jge 0x43fa
43F9  40              inc ax
loc_43FA:
43FA  50              push ax
43FB  E8 1A D6        call 0x1a18
43FE  80 3E BD D0 00  cmp byte ptr [0xd0bd], 0
4403  75 05           jne 0x440a
4405  6A 43           push 0x43
4407  E8 0A DA        call 0x1e14
loc_440A:
440A  C6 06 BD D0 01  mov byte ptr [0xd0bd], 1
loc_440F:
440F  8A 46 FF        mov al, byte ptr [bp - 1]
4412  C9              leave
4413  C2 02 00        ret 2

; ---- routine 0AB5:4416  (found by: call)
sub_4416:
4416  C8 02 00 00     enter 2, 0
441A  8B 7E 04        mov di, word ptr [bp + 4]
441D  36 C4 7D 06     les di, ptr ss:[di + 6]
4421  26 8A 45 07     mov al, byte ptr es:[di + 7]
4425  30 E4           xor ah, ah
4427  50              push ax
4428  E8 D5 BB        call 0
442B  08 C0           or al, al
442D  75 4D           jne 0x447c
442F  8B 7E 04        mov di, word ptr [bp + 4]
4432  36 C4 7D 06     les di, ptr ss:[di + 6]
4436  06              push es
4437  57              push di
4438  0E              push cs
4439  E8 12 DA        call 0x1e4e
443C  08 C0           or al, al
443E  75 3C           jne 0x447c
4440  FF 36 46 CF     push word ptr [0xcf46]
4444  8B 7E 04        mov di, word ptr [bp + 4]
4447  36 C4 7D 06     les di, ptr ss:[di + 6]
444B  06              push es
444C  57              push di
444D  0E              push cs
444E  E8 A4 DC        call 0x20f5
4451  08 C0           or al, al
4453  74 27           je 0x447c
4455  8B 7E 04        mov di, word ptr [bp + 4]
4458  36 C4 7D 06     les di, ptr ss:[di + 6]
445C  26 FF 35        push word ptr es:[di]
445F  06              push es
4460  57              push di
4461  0E              push cs
4462  E8 C4 DC        call 0x2129
4465  08 C0           or al, al
4467  75 17           jne 0x4480
4469  6A 06           push 6
446B  8B 7E 04        mov di, word ptr [bp + 4]
446E  36 C4 7D 06     les di, ptr ss:[di + 6]
4472  06              push es
4473  57              push di
4474  0E              push cs
4475  E8 D4 D5        call 0x1a4c
4478  08 C0           or al, al
447A  74 04           je 0x4480
loc_447C:
447C  B0 00           mov al, 0
447E  EB 02           jmp 0x4482
loc_4480:
4480  B0 01           mov al, 1
loc_4482:
4482  88 46 FF        mov byte ptr [bp - 1], al
4485  8A 46 FF        mov al, byte ptr [bp - 1]
4488  C9              leave
4489  C2 02 00        ret 2

; ---- routine 0AB5:448C  (found by: call)
sub_448C:
448C  55              push bp
448D  89 E5           mov bp, sp
448F  55              push bp
4490  E8 3F FF        call 0x43d2
4493  08 C0           or al, al
4495  75 18           jne 0x44af
4497  55              push bp
4498  E8 CB F8        call 0x3d66
449B  08 C0           or al, al
449D  75 10           jne 0x44af
449F  55              push bp
44A0  E8 C7 FB        call 0x406a
44A3  08 C0           or al, al
44A5  75 08           jne 0x44af
44A7  55              push bp
44A8  E8 BC FD        call 0x4267
44AB  08 C0           or al, al
44AD  74 03           je 0x44b2
loc_44AF:
44AF  E9 5D 01        jmp 0x460f
loc_44B2:
44B2  A0 9F D0        mov al, byte ptr [0xd09f]
44B5  30 E4           xor ah, ah
44B7  50              push ax
44B8  E8 45 BB        call 0
44BB  08 C0           or al, al
44BD  74 13           je 0x44d2
44BF  80 3E 53 CF 00  cmp byte ptr [0xcf53], 0
44C4  75 0C           jne 0x44d2
44C6  C4 7E 06        les di, ptr [bp + 6]
44C9  06              push es
44CA  57              push di
44CB  0E              push cs
44CC  E8 A8 F4        call 0x3977
44CF  E9 3D 01        jmp 0x460f
loc_44D2:
44D2  C4 7E 06        les di, ptr [bp + 6]
44D5  06              push es
44D6  57              push di
44D7  0E              push cs
44D8  E8 58 DA        call 0x1f33
44DB  08 C0           or al, al
44DD  75 67           jne 0x4546
44DF  C4 7E 06        les di, ptr [bp + 6]
44E2  06              push es
44E3  57              push di
44E4  0E              push cs
44E5  E8 66 D9        call 0x1e4e
44E8  08 C0           or al, al
44EA  74 5A           je 0x4546
44EC  A0 47 CF        mov al, byte ptr [0xcf47]
44EF  98              cwde
44F0  99              cdq
44F1  31 D0           xor ax, dx
44F3  29 D0           sub ax, dx
44F5  3D 14 00        cmp ax, 0x14
44F8  7E 4C           jle 0x4546
44FA  A0 46 CF        mov al, byte ptr [0xcf46]
44FD  98              cwde
44FE  99              cdq
44FF  31 D0           xor ax, dx
4501  29 D0           sub ax, dx
4503  3D 03 00        cmp ax, 3
4506  7E 3E           jle 0x4546
4508  C4 7E 06        les di, ptr [bp + 6]
450B  06              push es
450C  57              push di
450D  0E              push cs
450E  E8 BB D9        call 0x1ecc
4511  98              cwde
4512  50              push ax
4513  6A 04           push 4
4515  9A 6D 07 1A 23  call far 231A:076D
451A  05 19 00        add ax, 0x19
451D  5A              pop dx
451E  F7 E2           mul dx
4520  C4 7E 06        les di, ptr [bp + 6]
4523  26 88 45 09     mov byte ptr es:[di + 9], al
4527  6A 03           push 3
4529  9A 6D 07 1A 23  call far 231A:076D
452E  50              push ax
452F  6A 03           push 3
4531  9A 6D 07 1A 23  call far 231A:076D
4536  05 00 00        add ax, 0
4539  5A              pop dx
453A  2B C2           sub ax, dx
453C  C4 7E 06        les di, ptr [bp + 6]
453F  26 88 45 08     mov byte ptr es:[di + 8], al
4543  E9 B0 00        jmp 0x45f6
loc_4546:
4546  80 3E BB D0 05  cmp byte ptr [0xd0bb], 5
454B  75 14           jne 0x4561
454D  83 3E 51 CF 00  cmp word ptr [0xcf51], 0
4552  76 0D           jbe 0x4561
4554  A1 46 CF        mov ax, word ptr [0xcf46]
4557  C4 7E 06        les di, ptr [bp + 6]
455A  26 89 45 08     mov word ptr es:[di + 8], ax
455E  E9 95 00        jmp 0x45f6
loc_4561:
4561  80 3E B8 D0 00  cmp byte ptr [0xd0b8], 0
4566  75 03           jne 0x456b
4568  E9 82 00        jmp 0x45ed
loc_456B:
456B  80 3E A0 D0 00  cmp byte ptr [0xd0a0], 0
4570  74 24           je 0x4596
4572  C4 7E 06        les di, ptr [bp + 6]
4575  06              push es
4576  57              push di
4577  0E              push cs
4578  E8 24 D9        call 0x1e9f
457B  3C 02           cmp al, 2
457D  74 17           je 0x4596
457F  C4 7E 06        les di, ptr [bp + 6]
4582  26 8B 45 0E     mov ax, word ptr es:[di + 0xe]
4586  C1 E0 03        shl ax, 3
4589  C4 3E BA D7     les di, ptr [0xd7ba]
458D  03 F8           add di, ax
458F  26 80 7D 06 01  cmp byte ptr es:[di + 6], 1
4594  75 57           jne 0x45ed
loc_4596:
4596  80 3E 53 CF 00  cmp byte ptr [0xcf53], 0
459B  75 0D           jne 0x45aa
459D  C4 7E 06        les di, ptr [bp + 6]
45A0  06              push es
45A1  57              push di
45A2  0E              push cs
45A3  E8 A8 D8        call 0x1e4e
45A6  08 C0           or al, al
45A8  75 43           jne 0x45ed
loc_45AA:
45AA  55              push bp
45AB  E8 68 FE        call 0x4416
45AE  08 C0           or al, al
45B0  75 2F           jne 0x45e1
45B2  C4 7E 06        les di, ptr [bp + 6]
45B5  06              push es
45B6  57              push di
45B7  0E              push cs
45B8  E8 00 D7        call 0x1cbb
45BB  98              cwde
45BC  8B F8           mov di, ax
45BE  8A 85 A4 D0     mov al, byte ptr [di - 0x2f5c]
45C2  C4 7E 06        les di, ptr [bp + 6]
45C5  26 3A 45 07     cmp al, byte ptr es:[di + 7]
45C9  74 16           je 0x45e1
45CB  06              push es
45CC  57              push di
45CD  0E              push cs
45CE  E8 EA D6        call 0x1cbb
45D1  98              cwde
45D2  8B F8           mov di, ax
45D4  8A 85 A2 D0     mov al, byte ptr [di - 0x2f5e]
45D8  C4 7E 06        les di, ptr [bp + 6]
45DB  26 3A 45 07     cmp al, byte ptr es:[di + 7]
45DF  75 0C           jne 0x45ed
loc_45E1:
45E1  A1 46 CF        mov ax, word ptr [0xcf46]
45E4  C4 7E 06        les di, ptr [bp + 6]
45E7  26 89 45 08     mov word ptr es:[di + 8], ax
45EB  EB 09           jmp 0x45f6
loc_45ED:
45ED  C4 7E 06        les di, ptr [bp + 6]
45F0  06              push es
45F1  57              push di
45F2  0E              push cs
45F3  E8 50 F2        call 0x3846
loc_45F6:
45F6  C4 7E 06        les di, ptr [bp + 6]
45F9  06              push es
45FA  57              push di
45FB  0E              push cs
45FC  E8 F9 EF        call 0x35f8
45FF  80 3E 53 CF 00  cmp byte ptr [0xcf53], 0
4604  74 09           je 0x460f
4606  C4 7E 06        les di, ptr [bp + 6]
4609  06              push es
460A  57              push di
460B  0E              push cs
460C  E8 F0 07        call 0x4dff
loc_460F:
460F  C9              leave
4610  CA 04 00        retf 4

; ---- routine 0AB5:4613  (found by: call)
sub_4613:
4613  55              push bp
4614  89 E5           mov bp, sp
4616  C4 7E 06        les di, ptr [bp + 6]
4619  26 8A 45 07     mov al, byte ptr es:[di + 7]
461D  30 E4           xor ah, ah
461F  50              push ax
4620  E8 DD B9        call 0
4623  08 C0           or al, al
4625  74 18           je 0x463f
4627  80 3E 53 CF 00  cmp byte ptr [0xcf53], 0
462C  74 11           je 0x463f
462E  83 3E 51 CF 00  cmp word ptr [0xcf51], 0
4633  75 0A           jne 0x463f
4635  C4 7E 06        les di, ptr [bp + 6]
4638  26 C6 45 13 05  mov byte ptr es:[di + 0x13], 5
463D  EB 18           jmp 0x4657
loc_463F:
463F  C4 7E 06        les di, ptr [bp + 6]
4642  26 80 7D 11 00  cmp byte ptr es:[di + 0x11], 0
4647  76 06           jbe 0x464f
4649  26 FE 4D 11     dec byte ptr es:[di + 0x11]
464D  EB 08           jmp 0x4657
loc_464F:
464F  C4 7E 06        les di, ptr [bp + 6]
4652  26 C6 45 13 05  mov byte ptr es:[di + 0x13], 5
loc_4657:
4657  C4 7E 06        les di, ptr [bp + 6]
465A  26 8B 05        mov ax, word ptr es:[di]
465D  26 89 45 08     mov word ptr es:[di + 8], ax
4661  C9              leave
4662  CA 04 00        retf 4

; ---- routine 0AB5:4665  (found by: call)
sub_4665:
4665  55              push bp
4666  89 E5           mov bp, sp
4668  A0 B7 D0        mov al, byte ptr [0xd0b7]
466B  98              cwde
466C  8B F8           mov di, ax
466E  8A 85 98 0A     mov al, byte ptr [di + 0xa98]
4672  30 E4           xor ah, ah
4674  50              push ax
4675  9A 1C 0D AC 24  call far 24AC:0D1C
467A  08 C0           or al, al
467C  74 52           je 0x46d0
467E  80 3E BB D0 05  cmp byte ptr [0xd0bb], 5
4683  74 0F           je 0x4694
4685  80 7E 06 1B     cmp byte ptr [bp + 6], 0x1b
4689  75 0B           jne 0x4696
468B  9A 3F 0D AC 24  call far 24AC:0D3F
4690  08 C0           or al, al
4692  74 02           je 0x4696
loc_4694:
4694  EB 3A           jmp 0x46d0
loc_4696:
4696  A1 4F CF        mov ax, word ptr [0xcf4f]
4699  F7 D8           neg ax
469B  A3 4F CF        mov word ptr [0xcf4f], ax
469E  A1 4D CF        mov ax, word ptr [0xcf4d]
46A1  F7 D8           neg ax
46A3  A3 4D CF        mov word ptr [0xcf4d], ax
46A6  6A 00           push 0
46A8  6A 01           push 1
46AA  A1 51 CF        mov ax, word ptr [0xcf51]
46AD  C1 E8 02        shr ax, 2
46B0  31 D2           xor dx, dx
46B2  52              push dx
46B3  50              push ax
46B4  9A C0 04 AC 24  call far 24AC:04C0
46B9  A3 51 CF        mov word ptr [0xcf51], ax
46BC  8A 46 06        mov al, byte ptr [bp + 6]
46BF  50              push ax
46C0  E8 F4 D6        call 0x1db7
46C3  8B 7E 04        mov di, word ptr [bp + 4]
46C6  36 C6 45 FF 01  mov byte ptr ss:[di - 1], 1
46CB  C6 06 B7 D0 00  mov byte ptr [0xd0b7], 0
loc_46D0:
46D0  C9              leave
46D1  C2 04 00        ret 4

