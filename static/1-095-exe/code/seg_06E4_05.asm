; 1-095.EXE (One-Nil 95), code segment 06E4 (image offsets 06E40..0AB4F), part 5 of 6
; packed 1-095.EXE sha256 f659fb2d334500d6901fc8d6a0f06c85c0ccda2eb4a3035ae3bb0a0004d79192 (LZEXE 0.91)
; unpacked (tools/static/unlzexe.py) sha256 8df646e017e0965a5d90a58181ca764219ad847833aad0b6cb58fc53372bfb2c
; tool: capstone 5.0.9 (pip package; core library 5.0.1280) (CS_ARCH_X86, CS_MODE_16), recursive descent from the entry point, far calls and near calls/jumps, then routine prologues (55 89 E5 / 55 8B EC / C8 iw 00) in what remains; tools/static/listing.py
; addresses are SEGMENT:OFFSET with SEGMENT the image paragraph before relocation; image offset = SEGMENT*16+OFFSET
; ---- routine 06E4:2CEA  (found by: call, far)
sub_2CEA:
2CEA  C8 08 00 00     enter 8, 0
2CEE  6B 46 0C 3E     imul ax, word ptr [bp + 0xc], 0x3e
2CF2  C4 3E C2 D7     les di, ptr [0xd7c2]
2CF6  03 F8           add di, ax
2CF8  81 C7 C2 FF     add di, 0xffc2
2CFC  89 7E FC        mov word ptr [bp - 4], di
2CFF  8C 46 FE        mov word ptr [bp - 2], es
2D02  8B 56 0E        mov dx, word ptr [bp + 0xe]
2D05  8B 46 0A        mov ax, word ptr [bp + 0xa]
2D08  D1 E0           shl ax, 1
2D0A  C4 7E 06        les di, ptr [bp + 6]
2D0D  03 F8           add di, ax
2D0F  26 89 55 FE     mov word ptr es:[di - 2], dx
2D13  C4 7E FC        les di, ptr [bp - 4]
2D16  26 FE 45 32     inc byte ptr es:[di + 0x32]
2D1A  8A 56 0C        mov dl, byte ptr [bp + 0xc]
2D1D  8B 46 0E        mov ax, word ptr [bp + 0xe]
2D20  C1 E0 03        shl ax, 3
2D23  C4 3E BA D7     les di, ptr [0xd7ba]
2D27  03 F8           add di, ax
2D29  26 88 15        mov byte ptr es:[di], dl
2D2C  6B 46 0E 0F     imul ax, word ptr [bp + 0xe], 0xf
2D30  C4 3E BE D7     les di, ptr [0xd7be]
2D34  03 F8           add di, ax
2D36  31 C0           xor ax, ax
2D38  26 89 05        mov word ptr es:[di], ax
2D3B  31 C0           xor ax, ax
2D3D  26 89 45 02     mov word ptr es:[di + 2], ax
2D41  C9              leave
2D42  CA 0A 00        retf 0xa

; ---- routine 06E4:2D45  (found by: call)
sub_2D45:
2D45  C8 0A 00 00     enter 0xa, 0
2D49  6B 46 04 3E     imul ax, word ptr [bp + 4], 0x3e
2D4D  C4 3E C2 D7     les di, ptr [0xd7c2]
2D51  03 F8           add di, ax
2D53  81 C7 C2 FF     add di, 0xffc2
2D57  89 7E F6        mov word ptr [bp - 0xa], di
2D5A  8C 46 F8        mov word ptr [bp - 8], es
2D5D  31 C0           xor ax, ax
2D5F  89 46 FA        mov word ptr [bp - 6], ax
2D62  C7 46 FC 01 00  mov word ptr [bp - 4], 1
2D67  EB 03           jmp 0x2d6c
loc_2D69:
2D69  FF 46 FC        inc word ptr [bp - 4]
loc_2D6C:
2D6C  8B 46 FC        mov ax, word ptr [bp - 4]
2D6F  D1 E0           shl ax, 1
2D71  C4 7E F6        les di, ptr [bp - 0xa]
2D74  03 F8           add di, ax
2D76  26 83 7D FE 00  cmp word ptr es:[di - 2], 0
2D7B  74 21           je 0x2d9e
2D7D  8B 46 FC        mov ax, word ptr [bp - 4]
2D80  D1 E0           shl ax, 1
2D82  C4 7E F6        les di, ptr [bp - 0xa]
2D85  03 F8           add di, ax
2D87  26 8B 45 FE     mov ax, word ptr es:[di - 2]
2D8B  C1 E0 03        shl ax, 3
2D8E  C4 3E BA D7     les di, ptr [0xd7ba]
2D92  03 F8           add di, ax
2D94  26 80 7D 07 00  cmp byte ptr es:[di + 7], 0
2D99  75 03           jne 0x2d9e
2D9B  FF 46 FA        inc word ptr [bp - 6]
loc_2D9E:
2D9E  83 7E FC 14     cmp word ptr [bp - 4], 0x14
2DA2  75 C5           jne 0x2d69
2DA4  C4 7E F6        les di, ptr [bp - 0xa]
2DA7  26 8A 45 37     mov al, byte ptr es:[di + 0x37]
2DAB  98              cwde
2DAC  8B F8           mov di, ax
2DAE  8A 85 70 03     mov al, byte ptr [di + 0x370]
2DB2  30 E4           xor ah, ah
2DB4  3B 46 FA        cmp ax, word ptr [bp - 6]
2DB7  B0 00           mov al, 0
2DB9  76 01           jbe 0x2dbc
2DBB  40              inc ax
loc_2DBC:
2DBC  88 46 FF        mov byte ptr [bp - 1], al
2DBF  8A 46 FF        mov al, byte ptr [bp - 1]
2DC2  C9              leave
2DC3  C2 02 00        ret 2

; ---- routine 06E4:2DC6  (found by: call, far)
sub_2DC6:
2DC6  C8 0C 00 00     enter 0xc, 0
2DCA  6B 46 06 3E     imul ax, word ptr [bp + 6], 0x3e
2DCE  C4 3E C2 D7     les di, ptr [0xd7c2]
2DD2  03 F8           add di, ax
2DD4  81 C7 C2 FF     add di, 0xffc2
2DD8  89 7E F6        mov word ptr [bp - 0xa], di
2DDB  8C 46 F8        mov word ptr [bp - 8], es
2DDE  FF 76 08        push word ptr [bp + 8]
2DE1  06              push es
2DE2  57              push di
2DE3  9A AF 5B 51 1B  call far 1B51:5BAF
2DE8  89 46 FE        mov word ptr [bp - 2], ax
2DEB  8B 46 FE        mov ax, word ptr [bp - 2]
2DEE  D1 E0           shl ax, 1
2DF0  C4 7E F6        les di, ptr [bp - 0xa]
2DF3  03 F8           add di, ax
2DF5  31 C0           xor ax, ax
2DF7  26 89 45 FE     mov word ptr es:[di - 2], ax
2DFB  C4 7E F6        les di, ptr [bp - 0xa]
2DFE  26 80 7D 32 0E  cmp byte ptr es:[di + 0x32], 0xe
2E03  72 1D           jb 0x2e22
2E05  8B 46 08        mov ax, word ptr [bp + 8]
2E08  C1 E0 03        shl ax, 3
2E0B  C4 3E BA D7     les di, ptr [0xd7ba]
2E0F  03 F8           add di, ax
2E11  26 80 7D 06 00  cmp byte ptr es:[di + 6], 0
2E16  75 2B           jne 0x2e43
2E18  FF 76 06        push word ptr [bp + 6]
2E1B  E8 27 FF        call 0x2d45
2E1E  08 C0           or al, al
2E20  74 21           je 0x2e43
loc_2E22:
2E22  FF 76 06        push word ptr [bp + 6]
2E25  FF 76 FE        push word ptr [bp - 2]
2E28  8B 46 08        mov ax, word ptr [bp + 8]
2E2B  C1 E0 03        shl ax, 3
2E2E  C4 3E BA D7     les di, ptr [0xd7ba]
2E32  03 F8           add di, ax
2E34  26 8A 45 06     mov al, byte ptr es:[di + 6]
2E38  30 E4           xor ah, ah
2E3A  50              push ax
2E3B  9A B1 60 51 1B  call far 1B51:60B1
2E40  E9 6A 01        jmp 0x2fad
loc_2E43:
2E43  83 7E FE 0B     cmp word ptr [bp - 2], 0xb
2E47  76 09           jbe 0x2e52
2E49  8B 46 FE        mov ax, word ptr [bp - 2]
2E4C  89 46 FC        mov word ptr [bp - 4], ax
2E4F  E9 FB 00        jmp 0x2f4d
loc_2E52:
2E52  BF 76 D0        mov di, 0xd076
2E55  1E              push ds
2E56  57              push di
2E57  6A 0E           push 0xe
2E59  6A 00           push 0
2E5B  9A 22 02 AC 24  call far 24AC:0222
2E60  C4 7E F6        les di, ptr [bp - 0xa]
2E63  26 8A 45 32     mov al, byte ptr es:[di + 0x32]
2E67  30 E4           xor ah, ah
2E69  89 46 F4        mov word ptr [bp - 0xc], ax
2E6C  B8 0C 00        mov ax, 0xc
2E6F  3B 46 F4        cmp ax, word ptr [bp - 0xc]
2E72  77 36           ja 0x2eaa
2E74  89 46 FA        mov word ptr [bp - 6], ax
2E77  EB 03           jmp 0x2e7c
loc_2E79:
2E79  FF 46 FA        inc word ptr [bp - 6]
loc_2E7C:
2E7C  8A 56 FA        mov dl, byte ptr [bp - 6]
2E7F  8B 46 FA        mov ax, word ptr [bp - 6]
2E82  D1 E0           shl ax, 1
2E84  C4 7E F6        les di, ptr [bp - 0xa]
2E87  03 F8           add di, ax
2E89  26 8B 45 FE     mov ax, word ptr es:[di - 2]
2E8D  C1 E0 03        shl ax, 3
2E90  C4 3E BA D7     les di, ptr [0xd7ba]
2E94  03 F8           add di, ax
2E96  26 8A 45 07     mov al, byte ptr es:[di + 7]
2E9A  30 E4           xor ah, ah
2E9C  8B F8           mov di, ax
2E9E  88 95 76 D0     mov byte ptr [di - 0x2f8a], dl
2EA2  8B 46 FA        mov ax, word ptr [bp - 6]
2EA5  3B 46 F4        cmp ax, word ptr [bp - 0xc]
2EA8  75 CF           jne 0x2e79
loc_2EAA:
2EAA  FF 76 08        push word ptr [bp + 8]
2EAD  C4 7E F6        les di, ptr [bp - 0xa]
2EB0  06              push es
2EB1  57              push di
2EB2  9A 82 98 B5 0A  call far 0AB5:9882
2EB7  89 46 FC        mov word ptr [bp - 4], ax
2EBA  83 7E FC 00     cmp word ptr [bp - 4], 0
2EBE  75 3B           jne 0x2efb
2EC0  C4 7E F6        les di, ptr [bp - 0xa]
2EC3  26 8A 45 32     mov al, byte ptr es:[di + 0x32]
2EC7  30 E4           xor ah, ah
2EC9  89 46 F4        mov word ptr [bp - 0xc], ax
2ECC  B8 0C 00        mov ax, 0xc
2ECF  3B 46 F4        cmp ax, word ptr [bp - 0xc]
2ED2  77 27           ja 0x2efb
2ED4  89 46 FA        mov word ptr [bp - 6], ax
2ED7  EB 03           jmp 0x2edc
loc_2ED9:
2ED9  FF 46 FA        inc word ptr [bp - 6]
loc_2EDC:
2EDC  8B 46 FA        mov ax, word ptr [bp - 6]
2EDF  D1 E0           shl ax, 1
2EE1  C4 7E F6        les di, ptr [bp - 0xa]
2EE4  03 F8           add di, ax
2EE6  26 83 7D FE 00  cmp word ptr es:[di - 2], 0
2EEB  74 06           je 0x2ef3
2EED  8B 46 FA        mov ax, word ptr [bp - 6]
2EF0  89 46 FC        mov word ptr [bp - 4], ax
loc_2EF3:
2EF3  8B 46 FA        mov ax, word ptr [bp - 6]
2EF6  3B 46 F4        cmp ax, word ptr [bp - 0xc]
2EF9  75 DE           jne 0x2ed9
loc_2EFB:
2EFB  8B 46 08        mov ax, word ptr [bp + 8]
2EFE  C1 E0 03        shl ax, 3
2F01  C4 3E BA D7     les di, ptr [0xd7ba]
2F05  03 F8           add di, ax
2F07  26 8A 55 06     mov dl, byte ptr es:[di + 6]
2F0B  8B 46 FC        mov ax, word ptr [bp - 4]
2F0E  D1 E0           shl ax, 1
2F10  C4 7E F6        les di, ptr [bp - 0xa]
2F13  03 F8           add di, ax
2F15  26 8B 45 FE     mov ax, word ptr es:[di - 2]
2F19  C1 E0 03        shl ax, 3
2F1C  C4 3E BA D7     les di, ptr [0xd7ba]
2F20  03 F8           add di, ax
2F22  26 88 55 06     mov byte ptr es:[di + 6], dl
2F26  8B 46 FC        mov ax, word ptr [bp - 4]
2F29  D1 E0           shl ax, 1
2F2B  C4 7E F6        les di, ptr [bp - 0xa]
2F2E  03 F8           add di, ax
2F30  81 C7 FE FF     add di, 0xfffe
2F34  06              push es
2F35  57              push di
2F36  8B 46 FE        mov ax, word ptr [bp - 2]
2F39  D1 E0           shl ax, 1
2F3B  C4 7E F6        les di, ptr [bp - 0xa]
2F3E  03 F8           add di, ax
2F40  81 C7 FE FF     add di, 0xfffe
2F44  06              push es
2F45  57              push di
2F46  6A 02           push 2
2F48  9A 03 02 AC 24  call far 24AC:0203
loc_2F4D:
2F4D  83 7E FC 0B     cmp word ptr [bp - 4], 0xb
2F51  76 40           jbe 0x2f93
2F53  C4 7E F6        les di, ptr [bp - 0xa]
2F56  26 8A 45 32     mov al, byte ptr es:[di + 0x32]
2F5A  30 E4           xor ah, ah
2F5C  3B 46 FC        cmp ax, word ptr [bp - 4]
2F5F  76 32           jbe 0x2f93
2F61  8B 46 FC        mov ax, word ptr [bp - 4]
2F64  40              inc ax
2F65  D1 E0           shl ax, 1
2F67  03 F8           add di, ax
2F69  81 C7 FE FF     add di, 0xfffe
2F6D  06              push es
2F6E  57              push di
2F6F  8B 46 FC        mov ax, word ptr [bp - 4]
2F72  D1 E0           shl ax, 1
2F74  C4 7E F6        les di, ptr [bp - 0xa]
2F77  03 F8           add di, ax
2F79  81 C7 FE FF     add di, 0xfffe
2F7D  06              push es
2F7E  57              push di
2F7F  C4 7E F6        les di, ptr [bp - 0xa]
2F82  26 8A 45 32     mov al, byte ptr es:[di + 0x32]
2F86  30 E4           xor ah, ah
2F88  2B 46 FC        sub ax, word ptr [bp - 4]
2F8B  D1 E0           shl ax, 1
2F8D  50              push ax
2F8E  9A C2 01 AC 24  call far 24AC:01C2
loc_2F93:
2F93  C4 7E F6        les di, ptr [bp - 0xa]
2F96  26 8A 45 32     mov al, byte ptr es:[di + 0x32]
2F9A  30 E4           xor ah, ah
2F9C  D1 E0           shl ax, 1
2F9E  03 F8           add di, ax
2FA0  31 C0           xor ax, ax
2FA2  26 89 45 FE     mov word ptr es:[di - 2], ax
2FA6  C4 7E F6        les di, ptr [bp - 0xa]
2FA9  26 FE 4D 32     dec byte ptr es:[di + 0x32]
loc_2FAD:
2FAD  C9              leave
2FAE  CA 04 00        retf 4

; ---- routine 06E4:2FB1  (found by: call)
sub_2FB1:
2FB1  C8 04 01 00     enter 0x104, 0
2FB5  8B 46 04        mov ax, word ptr [bp + 4]
2FB8  C1 E0 03        shl ax, 3
2FBB  C4 3E BA D7     les di, ptr [0xd7ba]
2FBF  03 F8           add di, ax
2FC1  89 7E FC        mov word ptr [bp - 4], di
2FC4  8C 46 FE        mov word ptr [bp - 2], es
2FC7  C6 06 2A 9A 00  mov byte ptr [0x9a2a], 0
loc_2FCC:
2FCC  FF 76 04        push word ptr [bp + 4]
2FCF  9A B3 95 B5 0A  call far 0AB5:95B3
2FD4  C4 7E 06        les di, ptr [bp + 6]
2FD7  06              push es
2FD8  57              push di
2FD9  BF 5C DD        mov di, 0xdd5c
2FDC  1E              push ds
2FDD  57              push di
2FDE  9A 2F 05 1A 23  call far 231A:052F
2FE3  C4 7E 0A        les di, ptr [bp + 0xa]
2FE6  06              push es
2FE7  57              push di
2FE8  BF 5C DD        mov di, 0xdd5c
2FEB  1E              push ds
2FEC  57              push di
2FED  9A 2F 05 1A 23  call far 231A:052F
2FF2  FF 76 04        push word ptr [bp + 4]
2FF5  C4 7E FC        les di, ptr [bp - 4]
2FF8  26 8A 45 06     mov al, byte ptr es:[di + 6]
2FFC  30 E4           xor ah, ah
2FFE  50              push ax
2FFF  9A 8B 71 51 1B  call far 1B51:718B
3004  50              push ax
3005  8D BE FC FE     lea di, [bp - 0x104]
3009  16              push ss
300A  57              push di
300B  8B 46 04        mov ax, word ptr [bp + 4]
300E  C4 3E AA D7     les di, ptr [0xd7aa]
3012  03 F8           add di, ax
3014  26 8A 05        mov al, byte ptr es:[di]
3017  50              push ax
3018  9A 6F 0C B9 26  call far 26B9:0C6F
301D  6A 07           push 7
301F  6A 3B           push 0x3b
3021  BF 5C DD        mov di, 0xdd5c
3024  1E              push ds
3025  57              push di
3026  9A 1B 04 1A 23  call far 231A:041B
302B  8D BE FC FE     lea di, [bp - 0x104]
302F  16              push ss
3030  57              push di
3031  FF 76 04        push word ptr [bp + 4]
3034  9A 3C 44 51 1B  call far 1B51:443C
3039  6A 07           push 7
303B  6A 3D           push 0x3d
303D  BF 5C DD        mov di, 0xdd5c
3040  1E              push ds
3041  57              push di
3042  9A 9D 03 1A 23  call far 231A:039D
3047  C4 3E 5C DD     les di, ptr [0xdd5c]
304B  06              push es
304C  57              push di
304D  C4 3E 58 DD     les di, ptr [0xdd58]
3051  06              push es
3052  57              push di
3053  68 A0 0F        push 0xfa0
3056  9A 12 0A B9 26  call far 26B9:0A12
305B  9A 9B 09 1A 23  call far 231A:099B
3060  80 3E 88 DE 0D  cmp byte ptr [0xde88], 0xd
3065  75 0D           jne 0x3074
3067  80 3E 2A 9A 00  cmp byte ptr [0x9a2a], 0
306C  B0 00           mov al, 0
306E  75 01           jne 0x3071
3070  40              inc ax
loc_3071:
3071  A2 2A 9A        mov byte ptr [0x9a2a], al
loc_3074:
3074  80 3E 88 DE 0D  cmp byte ptr [0xde88], 0xd
3079  75 03           jne 0x307e
307B  E9 4E FF        jmp 0x2fcc
loc_307E:
307E  C9              leave
307F  C2 0A 00        ret 0xa

; ---- routine 06E4:3082  (found by: call, far)
sub_3082:
3082  C8 02 00 00     enter 2, 0
loc_3086:
3086  C4 7E 0C        les di, ptr [bp + 0xc]
3089  06              push es
308A  57              push di
308B  C4 7E 08        les di, ptr [bp + 8]
308E  06              push es
308F  57              push di
3090  FF 76 06        push word ptr [bp + 6]
3093  E8 1B FF        call 0x2fb1
3096  A0 88 DE        mov al, byte ptr [0xde88]
3099  50              push ax
309A  9A 86 19 B9 26  call far 26B9:1986
309F  A2 88 DE        mov byte ptr [0xde88], al
30A2  A0 88 DE        mov al, byte ptr [0xde88]
30A5  B4 01           mov ah, 1
30A7  BA 20 00        mov dx, 0x20
30AA  9A 1F 0E B9 26  call far 26B9:0E1F
30AF  8B FA           mov di, dx
30B1  84 85 CA A2     test byte ptr [di - 0x5d36], al
30B5  74 CF           je 0x3086
30B7  80 3E 88 DE 59  cmp byte ptr [0xde88], 0x59
30BC  B0 00           mov al, 0
30BE  75 01           jne 0x30c1
30C0  40              inc ax
loc_30C1:
30C1  88 46 FF        mov byte ptr [bp - 1], al
30C4  8A 46 FF        mov al, byte ptr [bp - 1]
30C7  C9              leave
30C8  CA 0A 00        retf 0xa

; ---- routine 06E4:30CB  (found by: call)
sub_30CB:
30CB  55              push bp
30CC  89 E5           mov bp, sp
30CE  BF 1A 21        mov di, 0x211a
30D1  1E              push ds
30D2  57              push di
30D3  BF 2E 22        mov di, 0x222e
30D6  1E              push ds
30D7  57              push di
30D8  FF 76 0A        push word ptr [bp + 0xa]
30DB  0E              push cs
30DC  E8 A3 FF        call 0x3082
30DF  08 C0           or al, al
30E1  75 1D           jne 0x3100
30E3  C4 7E 06        les di, ptr [bp + 6]
30E6  06              push es
30E7  57              push di
30E8  FF 76 04        push word ptr [bp + 4]
30EB  9A FE 66 51 1B  call far 1B51:66FE
30F0  6B 46 0C 3E     imul ax, word ptr [bp + 0xc], 0x3e
30F4  C4 3E C2 D7     les di, ptr [0xd7c2]
30F8  03 F8           add di, ax
30FA  26 FE 4D F4     dec byte ptr es:[di - 0xc]
30FE  EB 1F           jmp 0x311f
loc_3100:
3100  FF 76 0A        push word ptr [bp + 0xa]
3103  6A 00           push 0
3105  6A 00           push 0
3107  9A A3 C0 B5 0A  call far 0AB5:C0A3
310C  08 C0           or al, al
310E  75 0F           jne 0x311f
3110  6B 46 0A 0F     imul ax, word ptr [bp + 0xa], 0xf
3114  C4 3E BE D7     les di, ptr [0xd7be]
3118  03 F8           add di, ax
311A  26 C6 45 0D 02  mov byte ptr es:[di + 0xd], 2
loc_311F:
311F  C9              leave
3120  C2 0A 00        ret 0xa

; ---- routine 06E4:3123  (found by: call)
sub_3123:
3123  C8 0C 00 00     enter 0xc, 0
3127  C7 46 FE 01 00  mov word ptr [bp - 2], 1
312C  EB 03           jmp 0x3131
loc_312E:
312E  FF 46 FE        inc word ptr [bp - 2]
loc_3131:
3131  8B 46 FE        mov ax, word ptr [bp - 2]
3134  D1 E0           shl ax, 1
3136  C4 7E 06        les di, ptr [bp + 6]
3139  03 F8           add di, ax
313B  26 83 7D FE 00  cmp word ptr es:[di - 2], 0
3140  75 03           jne 0x3145
3142  E9 91 01        jmp 0x32d6
loc_3145:
3145  8B 46 FE        mov ax, word ptr [bp - 2]
3148  D1 E0           shl ax, 1
314A  C4 7E 06        les di, ptr [bp + 6]
314D  03 F8           add di, ax
314F  26 6B 45 FE 0F  imul ax, word ptr es:[di - 2], 0xf
3154  C4 3E BE D7     les di, ptr [0xd7be]
3158  03 F8           add di, ax
315A  89 7E F8        mov word ptr [bp - 8], di
315D  8C 46 FA        mov word ptr [bp - 6], es
3160  8B 46 FE        mov ax, word ptr [bp - 2]
3163  D1 E0           shl ax, 1
3165  C4 7E 06        les di, ptr [bp + 6]
3168  03 F8           add di, ax
316A  26 8B 45 FE     mov ax, word ptr es:[di - 2]
316E  C1 E0 03        shl ax, 3
3171  C4 3E BA D7     les di, ptr [0xd7ba]
3175  03 F8           add di, ax
3177  89 7E F4        mov word ptr [bp - 0xc], di
317A  8C 46 F6        mov word ptr [bp - 0xa], es
317D  C4 7E F8        les di, ptr [bp - 8]
3180  26 C6 45 04 00  mov byte ptr es:[di + 4], 0
3185  26 C6 45 05 00  mov byte ptr es:[di + 5], 0
318A  C4 7E F4        les di, ptr [bp - 0xc]
318D  26 FE 45 01     inc byte ptr es:[di + 1]
3191  8B 46 FE        mov ax, word ptr [bp - 2]
3194  D1 E0           shl ax, 1
3196  C4 7E 06        les di, ptr [bp + 6]
3199  03 F8           add di, ax
319B  26 FF 75 FE     push word ptr es:[di - 2]
319F  9A 06 54 51 1B  call far 1B51:5406
31A4  6A 20           push 0x20
31A6  9A 6D 07 1A 23  call far 231A:076D
31AB  C4 7E F8        les di, ptr [bp - 8]
31AE  26 88 45 06     mov byte ptr es:[di + 6], al
31B2  C4 7E F4        les di, ptr [bp - 0xc]
31B5  26 8A 45 02     mov al, byte ptr es:[di + 2]
31B9  30 E4           xor ah, ah
31BB  05 06 00        add ax, 6
31BE  8B D0           mov dx, ax
31C0  26 8A 45 01     mov al, byte ptr es:[di + 1]
31C4  30 E4           xor ah, ah
31C6  3B C2           cmp ax, dx
31C8  7C 03           jl 0x31cd
31CA  E9 9A 00        jmp 0x3267
loc_31CD:
31CD  8B 7E 04        mov di, word ptr [bp + 4]
31D0  36 80 7D FD 00  cmp byte ptr ss:[di - 3], 0
31D5  75 23           jne 0x31fa
31D7  8B 46 FE        mov ax, word ptr [bp - 2]
31DA  D1 E0           shl ax, 1
31DC  C4 7E 06        les di, ptr [bp + 6]
31DF  03 F8           add di, ax
31E1  26 FF 75 FE     push word ptr es:[di - 2]
31E5  9A E4 51 51 1B  call far 1B51:51E4
31EA  C4 7E F4        les di, ptr [bp - 0xc]
31ED  26 8A 45 04     mov al, byte ptr es:[di + 4]
31F1  C4 7E F8        les di, ptr [bp - 8]
31F4  26 88 45 09     mov byte ptr es:[di + 9], al
31F8  EB 6B           jmp 0x3265
loc_31FA:
31FA  C4 7E F4        les di, ptr [bp - 0xc]
31FD  26 8A 45 02     mov al, byte ptr es:[di + 2]
3201  30 E4           xor ah, ah
3203  05 05 00        add ax, 5
3206  8B D0           mov dx, ax
3208  26 8A 45 01     mov al, byte ptr es:[di + 1]
320C  30 E4           xor ah, ah
320E  3B C2           cmp ax, dx
3210  75 1D           jne 0x322f
3212  BF 72 48        mov di, 0x4872
3215  1E              push ds
3216  57              push di
3217  BF DA 4E        mov di, 0x4eda
321A  1E              push ds
321B  57              push di
321C  8B 46 FE        mov ax, word ptr [bp - 2]
321F  D1 E0           shl ax, 1
3221  C4 7E 06        les di, ptr [bp + 6]
3224  03 F8           add di, ax
3226  26 FF 75 FE     push word ptr es:[di - 2]
322A  E8 84 FD        call 0x2fb1
322D  EB 36           jmp 0x3265
loc_322F:
322F  C4 7E F4        les di, ptr [bp - 0xc]
3232  26 80 7D 01 11  cmp byte ptr es:[di + 1], 0x11
3237  76 2C           jbe 0x3265
3239  C4 7E F8        les di, ptr [bp - 8]
323C  26 80 7D 0D 01  cmp byte ptr es:[di + 0xd], 1
3241  75 22           jne 0x3265
3243  C4 7E F4        les di, ptr [bp - 0xc]
3246  26 8A 05        mov al, byte ptr es:[di]
3249  30 E4           xor ah, ah
324B  50              push ax
324C  8B 46 FE        mov ax, word ptr [bp - 2]
324F  D1 E0           shl ax, 1
3251  C4 7E 06        les di, ptr [bp + 6]
3254  03 F8           add di, ax
3256  26 FF 75 FE     push word ptr es:[di - 2]
325A  C4 7E 06        les di, ptr [bp + 6]
325D  06              push es
325E  57              push di
325F  FF 76 FE        push word ptr [bp - 2]
3262  E8 66 FE        call 0x30cb
loc_3265:
3265  EB 6F           jmp 0x32d6
loc_3267:
3267  8B 46 FE        mov ax, word ptr [bp - 2]
326A  D1 E0           shl ax, 1
326C  C4 7E 06        les di, ptr [bp + 6]
326F  03 F8           add di, ax
3271  26 8B 45 FE     mov ax, word ptr es:[di - 2]
3275  89 46 FC        mov word ptr [bp - 4], ax
3278  8B 7E 04        mov di, word ptr [bp + 4]
327B  36 80 7D FD 00  cmp byte ptr ss:[di - 3], 0
3280  75 22           jne 0x32a4
3282  C4 7E F4        les di, ptr [bp - 0xc]
3285  26 8A 05        mov al, byte ptr es:[di]
3288  30 E4           xor ah, ah
328A  50              push ax
328B  FF 76 FE        push word ptr [bp - 2]
328E  26 8A 45 06     mov al, byte ptr es:[di + 6]
3292  30 E4           xor ah, ah
3294  50              push ax
3295  9A B1 60 51 1B  call far 1B51:60B1
329A  FF 76 FC        push word ptr [bp - 4]
329D  9A CB 66 51 1B  call far 1B51:66CB
32A2  EB 32           jmp 0x32d6
loc_32A4:
32A4  BF 98 20        mov di, 0x2098
32A7  1E              push ds
32A8  57              push di
32A9  BF DA 4E        mov di, 0x4eda
32AC  1E              push ds
32AD  57              push di
32AE  FF 76 FC        push word ptr [bp - 4]
32B1  E8 FD FC        call 0x2fb1
32B4  C4 7E 06        les di, ptr [bp + 6]
32B7  06              push es
32B8  57              push di
32B9  FF 76 FE        push word ptr [bp - 2]
32BC  9A FE 66 51 1B  call far 1B51:66FE
32C1  C4 7E F4        les di, ptr [bp - 0xc]
32C4  26 8A 05        mov al, byte ptr es:[di]
32C7  30 E4           xor ah, ah
32C9  6B C0 3E        imul ax, ax, 0x3e
32CC  C4 3E C2 D7     les di, ptr [0xd7c2]
32D0  03 F8           add di, ax
32D2  26 FE 4D F4     dec byte ptr es:[di - 0xc]
loc_32D6:
32D6  83 7E FE 14     cmp word ptr [bp - 2], 0x14
32DA  74 03           je 0x32df
32DC  E9 4F FE        jmp 0x312e
loc_32DF:
32DF  C9              leave
32E0  C2 06 00        ret 6

; ---- routine 06E4:32E3  (found by: far)
sub_32E3:
32E3  C8 04 00 00     enter 4, 0
32E7  C7 46 FE 01 00  mov word ptr [bp - 2], 1
32EC  EB 03           jmp 0x32f1
loc_32EE:
32EE  FF 46 FE        inc word ptr [bp - 2]
loc_32F1:
32F1  8B 7E FE        mov di, word ptr [bp - 2]
32F4  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
32F8  30 E4           xor ah, ah
32FA  50              push ax
32FB  9A DA 0D 51 1B  call far 1B51:0DDA
3300  88 46 FD        mov byte ptr [bp - 3], al
3303  80 7E FD 00     cmp byte ptr [bp - 3], 0
3307  74 1B           je 0x3324
3309  8B 7E FE        mov di, word ptr [bp - 2]
330C  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
3310  3A 06 BA DC     cmp al, byte ptr [0xdcba]
3314  B0 00           mov al, 0
3316  74 01           je 0x3319
3318  40              inc ax
loc_3319:
3319  30 E4           xor ah, ah
331B  40              inc ax
331C  C4 3E D2 D7     les di, ptr [0xd7d2]
3320  26 88 45 04     mov byte ptr es:[di + 4], al
loc_3324:
3324  8B 7E FE        mov di, word ptr [bp - 2]
3327  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
332B  30 E4           xor ah, ah
332D  6B C0 3E        imul ax, ax, 0x3e
3330  C4 3E C2 D7     les di, ptr [0xd7c2]
3334  03 F8           add di, ax
3336  81 C7 C2 FF     add di, 0xffc2
333A  06              push es
333B  57              push di
333C  55              push bp
333D  E8 E3 FD        call 0x3123
3340  80 7E FD 00     cmp byte ptr [bp - 3], 0
3344  74 26           je 0x336c
3346  8B 7E FE        mov di, word ptr [bp - 2]
3349  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
334D  3A 06 BA DC     cmp al, byte ptr [0xdcba]
3351  B0 00           mov al, 0
3353  74 01           je 0x3356
3355  40              inc ax
loc_3356:
3356  30 E4           xor ah, ah
3358  40              inc ax
3359  6B C0 28        imul ax, ax, 0x28
335C  C4 3E D2 D7     les di, ptr [0xd7d2]
3360  03 F8           add di, ax
3362  81 C7 30 00     add di, 0x30
3366  06              push es
3367  57              push di
3368  55              push bp
3369  E8 B7 FD        call 0x3123
loc_336C:
336C  81 7E FE B0 00  cmp word ptr [bp - 2], 0xb0
3371  74 03           je 0x3376
3373  E9 78 FF        jmp 0x32ee
loc_3376:
3376  C9              leave
3377  CB              retf

; ---- routine 06E4:3378  (found by: call)
sub_3378:
3378  C8 06 00 00     enter 6, 0
337C  8B 46 04        mov ax, word ptr [bp + 4]
337F  C1 E0 03        shl ax, 3
3382  C4 3E BA D7     les di, ptr [0xd7ba]
3386  03 F8           add di, ax
3388  26 8A 05        mov al, byte ptr es:[di]
338B  30 E4           xor ah, ah
338D  6B C0 3E        imul ax, ax, 0x3e
3390  C4 3E C2 D7     les di, ptr [0xd7c2]
3394  03 F8           add di, ax
3396  81 C7 C2 FF     add di, 0xffc2
339A  89 7E FA        mov word ptr [bp - 6], di
339D  8C 46 FC        mov word ptr [bp - 4], es
33A0  26 8A 45 32     mov al, byte ptr es:[di + 0x32]
33A4  30 E4           xor ah, ah
33A6  3D 01 00        cmp ax, 1
33A9  73 03           jae 0x33ae
33AB  E9 7D 00        jmp 0x342b
loc_33AE:
33AE  89 46 FE        mov word ptr [bp - 2], ax
33B1  EB 03           jmp 0x33b6
loc_33B3:
33B3  FF 4E FE        dec word ptr [bp - 2]
loc_33B6:
33B6  8B 46 FE        mov ax, word ptr [bp - 2]
33B9  D1 E0           shl ax, 1
33BB  C4 7E FA        les di, ptr [bp - 6]
33BE  03 F8           add di, ax
33C0  26 83 7D FE 00  cmp word ptr es:[di - 2], 0
33C5  74 5E           je 0x3425
33C7  8B 46 FE        mov ax, word ptr [bp - 2]
33CA  D1 E0           shl ax, 1
33CC  C4 7E FA        les di, ptr [bp - 6]
33CF  03 F8           add di, ax
33D1  26 8B 45 FE     mov ax, word ptr es:[di - 2]
33D5  3B 46 04        cmp ax, word ptr [bp + 4]
33D8  74 4B           je 0x3425
33DA  8B 46 04        mov ax, word ptr [bp + 4]
33DD  C1 E0 03        shl ax, 3
33E0  C4 3E BA D7     les di, ptr [0xd7ba]
33E4  03 F8           add di, ax
33E6  26 8A 55 07     mov dl, byte ptr es:[di + 7]
33EA  8B 46 FE        mov ax, word ptr [bp - 2]
33ED  D1 E0           shl ax, 1
33EF  C4 7E FA        les di, ptr [bp - 6]
33F2  03 F8           add di, ax
33F4  26 8B 45 FE     mov ax, word ptr es:[di - 2]
33F8  C1 E0 03        shl ax, 3
33FB  C4 3E BA D7     les di, ptr [0xd7ba]
33FF  03 F8           add di, ax
3401  26 8A 45 07     mov al, byte ptr es:[di + 7]
3405  3A C2           cmp al, dl
3407  75 1C           jne 0x3425
3409  8B 46 FE        mov ax, word ptr [bp - 2]
340C  D1 E0           shl ax, 1
340E  C4 7E FA        les di, ptr [bp - 6]
3411  03 F8           add di, ax
3413  26 6B 45 FE 0F  imul ax, word ptr es:[di - 2], 0xf
3418  C4 3E BE D7     les di, ptr [0xd7be]
341C  03 F8           add di, ax
341E  26 C6 45 0D 02  mov byte ptr es:[di + 0xd], 2
3423  EB 06           jmp 0x342b
loc_3425:
3425  83 7E FE 01     cmp word ptr [bp - 2], 1
3429  75 88           jne 0x33b3
loc_342B:
342B  C9              leave
342C  C2 02 00        ret 2

; ---- routine 06E4:342F  (found by: call, far)
sub_342F:
342F  55              push bp
3430  89 E5           mov bp, sp
3432  6B 46 0A 0F     imul ax, word ptr [bp + 0xa], 0xf
3436  C4 3E BE D7     les di, ptr [0xd7be]
343A  03 F8           add di, ax
343C  26 80 7D 0D 00  cmp byte ptr es:[di + 0xd], 0
3441  75 28           jne 0x346b
3443  C4 7E 06        les di, ptr [bp + 6]
3446  26 8B 05        mov ax, word ptr es:[di]
3449  26 8B 55 02     mov dx, word ptr es:[di + 2]
344D  B9 04 00        mov cx, 4
3450  31 DB           xor bx, bx
3452  9A 2A 0A B9 26  call far 26B9:0A2A
3457  B9 03 00        mov cx, 3
345A  31 DB           xor bx, bx
345C  9A 67 0A B9 26  call far 26B9:0A67
3461  C4 7E 06        les di, ptr [bp + 6]
3464  26 89 05        mov word ptr es:[di], ax
3467  26 89 55 02     mov word ptr es:[di + 2], dx
loc_346B:
346B  C9              leave
346C  CA 06 00        retf 6

; ---- routine 06E4:346F  (found by: call)
sub_346F:
346F  C8 02 01 00     enter 0x102, 0
3473  8B 7E 04        mov di, word ptr [bp + 4]
3476  36 FF 45 F2     inc word ptr ss:[di - 0xe]
347A  36 83 7D F2 01  cmp word ptr ss:[di - 0xe], 1
347F  75 4F           jne 0x34d0
3481  BF 06 27        mov di, 0x2706
3484  1E              push ds
3485  57              push di
3486  BF 5C DD        mov di, 0xdd5c
3489  1E              push ds
348A  57              push di
348B  9A 2F 05 1A 23  call far 231A:052F
3490  BF DA 4E        mov di, 0x4eda
3493  1E              push ds
3494  57              push di
3495  BF 5C DD        mov di, 0xdd5c
3498  1E              push ds
3499  57              push di
349A  9A 2F 05 1A 23  call far 231A:052F
349F  C7 46 FE 03 00  mov word ptr [bp - 2], 3
34A4  EB 03           jmp 0x34a9
loc_34A6:
34A6  FF 46 FE        inc word ptr [bp - 2]
loc_34A9:
34A9  6A 00           push 0
34AB  FF 76 FE        push word ptr [bp - 2]
34AE  6A 21           push 0x21
34B0  9A 43 0E 51 1B  call far 1B51:0E43
34B5  6A 00           push 0
34B7  FF 76 FE        push word ptr [bp - 2]
34BA  6A 36           push 0x36
34BC  9A 43 0E 51 1B  call far 1B51:0E43
34C1  83 7E FE 0E     cmp word ptr [bp - 2], 0xe
34C5  75 DF           jne 0x34a6
34C7  8B 7E 04        mov di, word ptr [bp + 4]
34CA  36 C7 45 FE 02 00 mov word ptr ss:[di - 2], 2
loc_34D0:
34D0  8B 7E 04        mov di, word ptr [bp + 4]
34D3  36 83 7D FE 0E  cmp word ptr ss:[di - 2], 0xe
34D8  72 03           jb 0x34dd
34DA  E9 95 00        jmp 0x3572
loc_34DD:
34DD  8B 7E 04        mov di, word ptr [bp + 4]
34E0  36 FF 45 FE     inc word ptr ss:[di - 2]
34E4  FF 76 06        push word ptr [bp + 6]
34E7  8B 46 06        mov ax, word ptr [bp + 6]
34EA  C1 E0 03        shl ax, 3
34ED  C4 3E BA D7     les di, ptr [0xd7ba]
34F1  03 F8           add di, ax
34F3  26 8A 45 07     mov al, byte ptr es:[di + 7]
34F7  30 E4           xor ah, ah
34F9  50              push ax
34FA  9A 8B 71 51 1B  call far 1B51:718B
34FF  50              push ax
3500  8D BE FE FE     lea di, [bp - 0x102]
3504  16              push ss
3505  57              push di
3506  8B 46 06        mov ax, word ptr [bp + 6]
3509  C4 3E AA D7     les di, ptr [0xd7aa]
350D  03 F8           add di, ax
350F  26 8A 05        mov al, byte ptr es:[di]
3512  50              push ax
3513  9A 6F 0C B9 26  call far 26B9:0C6F
3518  8B 7E 04        mov di, word ptr [bp + 4]
351B  36 8A 45 FE     mov al, byte ptr ss:[di - 2]
351F  50              push ax
3520  6A 0C           push 0xc
3522  BF 5C DD        mov di, 0xdd5c
3525  1E              push ds
3526  57              push di
3527  9A 1B 04 1A 23  call far 231A:041B
352C  8D BE FE FE     lea di, [bp - 0x102]
3530  16              push ss
3531  57              push di
3532  FF 76 06        push word ptr [bp + 6]
3535  9A 3C 44 51 1B  call far 1B51:443C
353A  8B 7E 04        mov di, word ptr [bp + 4]
353D  36 8A 45 FE     mov al, byte ptr ss:[di - 2]
3541  50              push ax
3542  6A 0E           push 0xe
3544  BF 5C DD        mov di, 0xdd5c
3547  1E              push ds
3548  57              push di
3549  9A 9D 03 1A 23  call far 231A:039D
354E  8B 7E 04        mov di, word ptr [bp + 4]
3551  36 FF 75 F8     push word ptr ss:[di - 8]
3555  36 FF 75 FE     push word ptr ss:[di - 2]
3559  6A 21           push 0x21
355B  9A 43 0E 51 1B  call far 1B51:0E43
3560  8B 7E 04        mov di, word ptr [bp + 4]
3563  36 FF 75 FA     push word ptr ss:[di - 6]
3567  36 FF 75 FE     push word ptr ss:[di - 2]
356B  6A 36           push 0x36
356D  9A 43 0E 51 1B  call far 1B51:0E43
loc_3572:
3572  C9              leave
3573  C2 04 00        ret 4

; ---- routine 06E4:3576  (found by: call)
sub_3576:
3576  55              push bp
3577  89 E5           mov bp, sp
3579  8B 46 06        mov ax, word ptr [bp + 6]
357C  C1 E0 03        shl ax, 3
357F  C4 3E BA D7     les di, ptr [0xd7ba]
3583  03 F8           add di, ax
3585  26 8A 05        mov al, byte ptr es:[di]
3588  30 E4           xor ah, ah
358A  8B 7E 04        mov di, word ptr [bp + 4]
358D  36 89 45 F8     mov word ptr ss:[di - 8], ax
3591  FF 76 06        push word ptr [bp + 6]
3594  57              push di
3595  E8 D7 FE        call 0x346f
3598  FF 76 06        push word ptr [bp + 6]
359B  8B 7E 04        mov di, word ptr [bp + 4]
359E  36 FF 75 FA     push word ptr ss:[di - 6]
35A2  36 6B 45 FA 3E  imul ax, word ptr ss:[di - 6], 0x3e
35A7  C4 3E C2 D7     les di, ptr [0xd7c2]
35AB  03 F8           add di, ax
35AD  26 8A 45 F4     mov al, byte ptr es:[di - 0xc]
35B1  30 E4           xor ah, ah
35B3  40              inc ax
35B4  50              push ax
35B5  8B 7E 04        mov di, word ptr [bp + 4]
35B8  36 6B 45 FA 3E  imul ax, word ptr ss:[di - 6], 0x3e
35BD  C4 3E C2 D7     les di, ptr [0xd7c2]
35C1  03 F8           add di, ax
35C3  81 C7 C2 FF     add di, 0xffc2
35C7  06              push es
35C8  57              push di
35C9  0E              push cs
35CA  E8 1D F7        call 0x2cea
35CD  FF 76 06        push word ptr [bp + 6]
35D0  9A 98 64 51 1B  call far 1B51:6498
35D5  8B 46 06        mov ax, word ptr [bp + 6]
35D8  C1 E0 03        shl ax, 3
35DB  C4 3E BA D7     les di, ptr [0xd7ba]
35DF  03 F8           add di, ax
35E1  26 80 7D 07 00  cmp byte ptr es:[di + 7], 0
35E6  74 09           je 0x35f1
35E8  9A 3F 0D AC 24  call far 24AC:0D3F
35ED  08 C0           or al, al
35EF  74 06           je 0x35f7
loc_35F1:
35F1  FF 76 06        push word ptr [bp + 6]
35F4  E8 81 FD        call 0x3378
loc_35F7:
35F7  C9              leave
35F8  C2 04 00        ret 4

; ---- routine 06E4:35FB  (found by: call)
sub_35FB:
35FB  C8 04 01 00     enter 0x104, 0
35FF  8B 7E 04        mov di, word ptr [bp + 4]
3602  36 8B 45 06     mov ax, word ptr ss:[di + 6]
3606  C1 E0 03        shl ax, 3
3609  C4 3E BA D7     les di, ptr [0xd7ba]
360D  03 F8           add di, ax
360F  89 7E FC        mov word ptr [bp - 4], di
3612  8C 46 FE        mov word ptr [bp - 2], es
3615  C4 7E 08        les di, ptr [bp + 8]
3618  06              push es
3619  57              push di
361A  BF 5C DD        mov di, 0xdd5c
361D  1E              push ds
361E  57              push di
361F  9A 2F 05 1A 23  call far 231A:052F
3624  8B 7E 04        mov di, word ptr [bp + 4]
3627  36 FF 75 06     push word ptr ss:[di + 6]
362B  9A BD 47 51 1B  call far 1B51:47BD
3630  8B 7E 04        mov di, word ptr [bp + 4]
3633  36 89 45 F8     mov word ptr ss:[di - 8], ax
3637  36 89 55 FA     mov word ptr ss:[di - 6], dx
363B  36 80 7D FE 00  cmp byte ptr ss:[di - 2], 0
3640  75 38           jne 0x367a
3642  6A 03           push 3
3644  9A 6D 07 1A 23  call far 231A:076D
3649  8B F8           mov di, ax
364B  8A 85 79 03     mov al, byte ptr [di + 0x379]
364F  30 E4           xor ah, ah
3651  31 D2           xor dx, dx
3653  8B 7E 04        mov di, word ptr [bp + 4]
3656  36 8B 4D F8     mov cx, word ptr ss:[di - 8]
365A  36 8B 5D FA     mov bx, word ptr ss:[di - 6]
365E  9A 2A 0A B9 26  call far 26B9:0A2A
3663  B9 0A 00        mov cx, 0xa
3666  31 DB           xor bx, bx
3668  9A 67 0A B9 26  call far 26B9:0A67
366D  8B 7E 04        mov di, word ptr [bp + 4]
3670  36 89 45 F8     mov word ptr ss:[di - 8], ax
3674  36 89 55 FA     mov word ptr ss:[di - 6], dx
3678  EB 11           jmp 0x368b
loc_367A:
367A  8B 7E 04        mov di, word ptr [bp + 4]
367D  36 FF 75 06     push word ptr ss:[di + 6]
3681  81 C7 F8 FF     add di, 0xfff8
3685  16              push ss
3686  57              push di
3687  0E              push cs
3688  E8 A4 FD        call 0x342f
loc_368B:
368B  8B 7E 04        mov di, word ptr [bp + 4]
368E  36 FF 75 06     push word ptr ss:[di + 6]
3692  C4 7E FC        les di, ptr [bp - 4]
3695  26 8A 45 06     mov al, byte ptr es:[di + 6]
3699  30 E4           xor ah, ah
369B  50              push ax
369C  9A 8B 71 51 1B  call far 1B51:718B
36A1  50              push ax
36A2  8D BE FC FE     lea di, [bp - 0x104]
36A6  16              push ss
36A7  57              push di
36A8  8B 7E 04        mov di, word ptr [bp + 4]
36AB  36 FF 75 06     push word ptr ss:[di + 6]
36AF  9A 3C 44 51 1B  call far 1B51:443C
36B4  6A 19           push 0x19
36B6  8A 46 06        mov al, byte ptr [bp + 6]
36B9  50              push ax
36BA  BF 5C DD        mov di, 0xdd5c
36BD  1E              push ds
36BE  57              push di
36BF  9A 1B 04 1A 23  call far 231A:041B
36C4  C9              leave
36C5  C2 08 00        ret 8
; data (not reached as code), 34 bytes
36C8                  pstr ' PAY '
36CE                  pstr 'Your chairman overrules you'

; ---- routine 06E4:36EA  (found by: call)
sub_36EA:
36EA  C8 14 01 00     enter 0x114, 0
36EE  8B 46 06        mov ax, word ptr [bp + 6]
36F1  C1 E0 03        shl ax, 3
36F4  C4 3E BA D7     les di, ptr [0xd7ba]
36F8  03 F8           add di, ax
36FA  89 7E F0        mov word ptr [bp - 0x10], di
36FD  8C 46 F2        mov word ptr [bp - 0xe], es
3700  6B 46 06 0F     imul ax, word ptr [bp + 6], 0xf
3704  C4 3E BE D7     les di, ptr [0xd7be]
3708  03 F8           add di, ax
370A  89 7E EC        mov word ptr [bp - 0x14], di
370D  8C 46 EE        mov word ptr [bp - 0x12], es
3710  C4 3E 5C DD     les di, ptr [0xdd5c]
3714  06              push es
3715  57              push di
3716  C4 3E 60 DD     les di, ptr [0xdd60]
371A  06              push es
371B  57              push di
371C  68 A0 0F        push 0xfa0
371F  9A 12 0A B9 26  call far 26B9:0A12
3724  C4 7E F0        les di, ptr [bp - 0x10]
3727  26 8A 05        mov al, byte ptr es:[di]
372A  3A 06 BA DC     cmp al, byte ptr [0xdcba]
372E  B0 00           mov al, 0
3730  74 01           je 0x3733
3732  40              inc ax
loc_3733:
3733  30 E4           xor ah, ah
3735  40              inc ax
3736  89 46 F6        mov word ptr [bp - 0xa], ax
3739  C4 7E EC        les di, ptr [bp - 0x14]
373C  26 80 7D 0C 00  cmp byte ptr es:[di + 0xc], 0
3741  B0 00           mov al, 0
3743  76 01           jbe 0x3746
3745  40              inc ax
loc_3746:
3746  88 46 FE        mov byte ptr [bp - 2], al
3749  80 7E FE 00     cmp byte ptr [bp - 2], 0
374D  B0 00           mov al, 0
374F  75 01           jne 0x3752
3751  40              inc ax
loc_3752:
3752  88 46 FD        mov byte ptr [bp - 3], al
3755  C4 7E F0        les di, ptr [bp - 0x10]
3758  26 8A 45 04     mov al, byte ptr es:[di + 4]
375C  30 E4           xor ah, ah
375E  89 46 F4        mov word ptr [bp - 0xc], ax
3761  FF 76 06        push word ptr [bp + 6]
3764  9A 37 49 51 1B  call far 1B51:4937
3769  C4 7E F0        les di, ptr [bp - 0x10]
376C  26 88 45 04     mov byte ptr es:[di + 4], al
3770  80 7E FE 00     cmp byte ptr [bp - 2], 0
3774  74 0D           je 0x3783
3776  BF 30 20        mov di, 0x2030
3779  1E              push ds
377A  57              push di
377B  6A 16           push 0x16
377D  55              push bp
377E  E8 7A FE        call 0x35fb
3781  EB 0B           jmp 0x378e
loc_3783:
3783  BF 60 20        mov di, 0x2060
3786  1E              push ds
3787  57              push di
3788  6A 01           push 1
378A  55              push bp
378B  E8 6D FE        call 0x35fb
loc_378E:
378E  8A 46 F4        mov al, byte ptr [bp - 0xc]
3791  C4 7E F0        les di, ptr [bp - 0x10]
3794  26 88 45 04     mov byte ptr es:[di + 4], al
loc_3798:
3798  FF 76 06        push word ptr [bp + 6]
379B  9A B3 95 B5 0A  call far 0AB5:95B3
37A0  BF 28 28        mov di, 0x2828
37A3  1E              push ds
37A4  57              push di
37A5  BF 5C DD        mov di, 0xdd5c
37A8  1E              push ds
37A9  57              push di
37AA  9A 2F 05 1A 23  call far 231A:052F
37AF  8B 7E 04        mov di, word ptr [bp + 4]
37B2  36 FF 75 FA     push word ptr ss:[di - 6]
37B6  6A 04           push 4
37B8  6A 3D           push 0x3d
37BA  9A 43 0E 51 1B  call far 1B51:0E43
37BF  80 7E FE 00     cmp byte ptr [bp - 2], 0
37C3  75 24           jne 0x37e9
37C5  BF 04 20        mov di, 0x2004
37C8  1E              push ds
37C9  57              push di
37CA  BF 5C DD        mov di, 0xdd5c
37CD  1E              push ds
37CE  57              push di
37CF  9A 2F 05 1A 23  call far 231A:052F
37D4  6A 0B           push 0xb
37D6  BF C8 36        mov di, 0x36c8
37D9  0E              push cs
37DA  57              push di
37DB  6A 07           push 7
37DD  6A 42           push 0x42
37DF  BF 5C DD        mov di, 0xdd5c
37E2  1E              push ds
37E3  57              push di
37E4  9A 1B 04 1A 23  call far 231A:041B
loc_37E9:
37E9  FF 76 06        push word ptr [bp + 6]
37EC  C4 7E F0        les di, ptr [bp - 0x10]
37EF  26 8A 45 06     mov al, byte ptr es:[di + 6]
37F3  30 E4           xor ah, ah
37F5  50              push ax
37F6  9A 8B 71 51 1B  call far 1B51:718B
37FB  50              push ax
37FC  8D BE EC FE     lea di, [bp - 0x114]
3800  16              push ss
3801  57              push di
3802  8B 46 06        mov ax, word ptr [bp + 6]
3805  C4 3E AA D7     les di, ptr [0xd7aa]
3809  03 F8           add di, ax
380B  26 8A 05        mov al, byte ptr es:[di]
380E  50              push ax
380F  9A 6F 0C B9 26  call far 26B9:0C6F
3814  6A 12           push 0x12
3816  6A 43           push 0x43
3818  BF 5C DD        mov di, 0xdd5c
381B  1E              push ds
381C  57              push di
381D  9A 1B 04 1A 23  call far 231A:041B
3822  8D BE EC FE     lea di, [bp - 0x114]
3826  16              push ss
3827  57              push di
3828  FF 76 06        push word ptr [bp + 6]
382B  9A 3C 44 51 1B  call far 1B51:443C
3830  6A 12           push 0x12
3832  6A 45           push 0x45
3834  BF 5C DD        mov di, 0xdd5c
3837  1E              push ds
3838  57              push di
3839  9A 9D 03 1A 23  call far 231A:039D
383E  C7 06 64 DD 70 00 mov word ptr [0xdd64], 0x70
3844  FF 76 FA        push word ptr [bp - 6]
3847  FF 76 F8        push word ptr [bp - 8]
384A  6A 0C           push 0xc
384C  6A 4C           push 0x4c
384E  9A 7E 0F 51 1B  call far 1B51:0F7E
3853  C4 3E 5C DD     les di, ptr [0xdd5c]
3857  06              push es
3858  57              push di
3859  C4 3E 58 DD     les di, ptr [0xdd58]
385D  06              push es
385E  57              push di
385F  68 A0 0F        push 0xfa0
3862  9A 12 0A B9 26  call far 26B9:0A12
3867  9A 9B 09 1A 23  call far 231A:099B
386C  A0 88 DE        mov al, byte ptr [0xde88]
386F  50              push ax
3870  9A 86 19 B9 26  call far 26B9:1986
3875  A2 88 DE        mov byte ptr [0xde88], al
3878  80 3E 88 DE 0D  cmp byte ptr [0xde88], 0xd
387D  74 1B           je 0x389a
387F  80 7E FE 00     cmp byte ptr [bp - 2], 0
3883  74 19           je 0x389e
3885  A0 88 DE        mov al, byte ptr [0xde88]
3888  B4 01           mov ah, 1
388A  BA 20 00        mov dx, 0x20
388D  9A 1F 0E B9 26  call far 26B9:0E1F
3892  8B FA           mov di, dx
3894  84 85 CA A2     test byte ptr [di - 0x5d36], al
3898  75 04           jne 0x389e
loc_389A:
389A  B0 00           mov al, 0
389C  EB 02           jmp 0x38a0
loc_389E:
389E  B0 01           mov al, 1
loc_38A0:
38A0  88 46 FF        mov byte ptr [bp - 1], al
38A3  A0 88 DE        mov al, byte ptr [0xde88]
38A6  3C 0D           cmp al, 0xd
38A8  75 0F           jne 0x38b9
38AA  80 3E 2A 9A 00  cmp byte ptr [0x9a2a], 0
38AF  B0 00           mov al, 0
38B1  75 01           jne 0x38b4
38B3  40              inc ax
loc_38B4:
38B4  A2 2A 9A        mov byte ptr [0x9a2a], al
38B7  EB 34           jmp 0x38ed
loc_38B9:
38B9  3C 59           cmp al, 0x59
38BB  75 0C           jne 0x38c9
38BD  80 7E FE 00     cmp byte ptr [bp - 2], 0
38C1  74 04           je 0x38c7
38C3  C6 46 FD 01     mov byte ptr [bp - 3], 1
loc_38C7:
38C7  EB 24           jmp 0x38ed
loc_38C9:
38C9  3C 4E           cmp al, 0x4e
38CB  74 04           je 0x38d1
38CD  3C 01           cmp al, 1
38CF  75 1C           jne 0x38ed
loc_38D1:
38D1  80 7E FE 00     cmp byte ptr [bp - 2], 0
38D5  74 16           je 0x38ed
38D7  FF 76 F6        push word ptr [bp - 0xa]
38DA  9A 15 36 51 1B  call far 1B51:3615
38DF  50              push ax
38E0  BF CE 36        mov di, 0x36ce
38E3  0E              push cs
38E4  57              push di
38E5  9A 98 00 1A 23  call far 231A:0098
38EA  88 46 FD        mov byte ptr [bp - 3], al
loc_38ED:
38ED  80 7E FF 00     cmp byte ptr [bp - 1], 0
38F1  75 03           jne 0x38f6
38F3  E9 A2 FE        jmp 0x3798
loc_38F6:
38F6  C4 3E 60 DD     les di, ptr [0xdd60]
38FA  06              push es
38FB  57              push di
38FC  C4 3E 5C DD     les di, ptr [0xdd5c]
3900  06              push es
3901  57              push di
3902  68 A0 0F        push 0xfa0
3905  9A 12 0A B9 26  call far 26B9:0A12
390A  80 7E FD 00     cmp byte ptr [bp - 3], 0
390E  75 03           jne 0x3913
3910  E9 06 01        jmp 0x3a19
loc_3913:
3913  FF 76 06        push word ptr [bp + 6]
3916  8B 46 06        mov ax, word ptr [bp + 6]
3919  C1 E0 03        shl ax, 3
391C  C4 3E BA D7     les di, ptr [0xd7ba]
3920  03 F8           add di, ax
3922  26 8A 05        mov al, byte ptr es:[di]
3925  30 E4           xor ah, ah
3927  50              push ax
3928  6A 01           push 1
392A  FF 76 F6        push word ptr [bp - 0xa]
392D  8B 7E 04        mov di, word ptr [bp + 4]
3930  36 FF 75 FA     push word ptr ss:[di - 6]
3934  9A 88 63 51 1B  call far 1B51:6388
3939  FF 76 06        push word ptr [bp + 6]
393C  8B 7E 04        mov di, word ptr [bp + 4]
393F  57              push di
3940  E8 33 FC        call 0x3576
3943  FF 76 06        push word ptr [bp + 6]
3946  8B 7E 04        mov di, word ptr [bp + 4]
3949  36 6B 45 F8 3E  imul ax, word ptr ss:[di - 8], 0x3e
394E  C4 3E C2 D7     les di, ptr [0xd7c2]
3952  03 F8           add di, ax
3954  81 C7 C2 FF     add di, 0xffc2
3958  06              push es
3959  57              push di
395A  9A AF 5B 51 1B  call far 1B51:5BAF
395F  09 C0           or ax, ax
3961  74 38           je 0x399b
3963  FF 76 06        push word ptr [bp + 6]
3966  8B 7E 04        mov di, word ptr [bp + 4]
3969  36 6B 45 F8 3E  imul ax, word ptr ss:[di - 8], 0x3e
396E  C4 3E C2 D7     les di, ptr [0xd7c2]
3972  03 F8           add di, ax
3974  81 C7 C2 FF     add di, 0xffc2
3978  06              push es
3979  57              push di
397A  9A AF 5B 51 1B  call far 1B51:5BAF
397F  D1 E0           shl ax, 1
3981  8B D0           mov dx, ax
3983  8B 7E 04        mov di, word ptr [bp + 4]
3986  36 6B 45 F8 3E  imul ax, word ptr ss:[di - 8], 0x3e
398B  C4 3E C2 D7     les di, ptr [0xd7c2]
398F  03 F8           add di, ax
3991  03 FA           add di, dx
3993  31 C0           xor ax, ax
3995  26 89 45 C0     mov word ptr es:[di - 0x40], ax
3999  EB 2E           jmp 0x39c9
loc_399B:
399B  FF 76 06        push word ptr [bp + 6]
399E  6B 46 F6 28     imul ax, word ptr [bp - 0xa], 0x28
39A2  C4 3E D2 D7     les di, ptr [0xd7d2]
39A6  03 F8           add di, ax
39A8  81 C7 30 00     add di, 0x30
39AC  06              push es
39AD  57              push di
39AE  9A AF 5B 51 1B  call far 1B51:5BAF
39B3  D1 E0           shl ax, 1
39B5  8B D0           mov dx, ax
39B7  6B 46 F6 28     imul ax, word ptr [bp - 0xa], 0x28
39BB  C4 3E D2 D7     les di, ptr [0xd7d2]
39BF  03 F8           add di, ax
39C1  03 FA           add di, dx
39C3  31 C0           xor ax, ax
39C5  26 89 45 2E     mov word ptr es:[di + 0x2e], ax
loc_39C9:
39C9  8B 7E 04        mov di, word ptr [bp + 4]
39CC  36 6B 45 F8 3E  imul ax, word ptr ss:[di - 8], 0x3e
39D1  C4 3E C2 D7     les di, ptr [0xd7c2]
39D5  03 F8           add di, ax
39D7  26 FE 4D F4     dec byte ptr es:[di - 0xc]
39DB  8B 4E F8        mov cx, word ptr [bp - 8]
39DE  8B 5E FA        mov bx, word ptr [bp - 6]
39E1  6B 46 F6 5E     imul ax, word ptr [bp - 0xa], 0x5e
39E5  C4 3E C4 DC     les di, ptr [0xdcc4]
39E9  03 F8           add di, ax
39EB  26 01 4D CC     add word ptr es:[di - 0x34], cx
39EF  26 11 5D CE     adc word ptr es:[di - 0x32], bx
39F3  8B 4E F8        mov cx, word ptr [bp - 8]
39F6  8B 5E FA        mov bx, word ptr [bp - 6]
39F9  69 46 F6 3A 23  imul ax, word ptr [bp - 0xa], 0x233a
39FE  C4 3E E2 DC     les di, ptr [0xdce2]
3A02  03 F8           add di, ax
3A04  26 89 8D DF DC  mov word ptr es:[di - 0x2321], cx
3A09  26 89 9D E1 DC  mov word ptr es:[di - 0x231f], bx
3A0E  C4 7E F0        les di, ptr [bp - 0x10]
3A11  26 8A 45 07     mov al, byte ptr es:[di + 7]
3A15  26 88 45 06     mov byte ptr es:[di + 6], al
loc_3A19:
3A19  C9              leave
3A1A  C2 04 00        ret 4

