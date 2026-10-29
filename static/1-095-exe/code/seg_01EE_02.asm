; 1-095.EXE (One-Nil 95), code segment 01EE (image offsets 01EE0..06E3F), part 2 of 7
; packed 1-095.EXE sha256 f659fb2d334500d6901fc8d6a0f06c85c0ccda2eb4a3035ae3bb0a0004d79192 (LZEXE 0.91)
; unpacked (tools/static/unlzexe.py) sha256 8df646e017e0965a5d90a58181ca764219ad847833aad0b6cb58fc53372bfb2c
; tool: capstone 5.0.9 (pip package; core library 5.0.1280) (CS_ARCH_X86, CS_MODE_16), recursive descent from the entry point, far calls and near calls/jumps, then routine prologues (55 89 E5 / 55 8B EC / C8 iw 00) in what remains; tools/static/listing.py
; addresses are SEGMENT:OFFSET with SEGMENT the image paragraph before relocation; image offset = SEGMENT*16+OFFSET
; ---- routine 01EE:0D49  (found by: call)
sub_0D49:
0D49  C8 00 01 00     enter 0x100, 0
0D4D  C4 3E D2 D7     les di, ptr [0xd7d2]
0D51  26 8A 45 04     mov al, byte ptr es:[di + 4]
0D55  30 E4           xor ah, ah
0D57  50              push ax
0D58  9A 3C 5C 51 1B  call far 1B51:5C3C
0D5D  08 C0           or al, al
0D5F  75 4D           jne 0xdae
0D61  C4 3E D2 D7     les di, ptr [0xd7d2]
0D65  26 8A 45 04     mov al, byte ptr es:[di + 4]
0D69  30 E4           xor ah, ah
0D6B  50              push ax
0D6C  9A 08 5D 51 1B  call far 1B51:5D08
0D71  50              push ax
0D72  BF 02 0D        mov di, 0xd02
0D75  0E              push cs
0D76  57              push di
0D77  9A 98 00 1A 23  call far 231A:0098
0D7C  08 C0           or al, al
0D7E  75 2E           jne 0xdae
0D80  FF 76 04        push word ptr [bp + 4]
0D83  E8 1C F9        call 0x6a2
0D86  50              push ax
0D87  8D BE 00 FF     lea di, [bp - 0x100]
0D8B  16              push ss
0D8C  57              push di
0D8D  FF 76 04        push word ptr [bp + 4]
0D90  9A 3C 44 51 1B  call far 1B51:443C
0D95  BF 2F 0D        mov di, 0xd2f
0D98  0E              push cs
0D99  57              push di
0D9A  9A D2 0B B9 26  call far 26B9:0BD2
0D9F  9A 98 00 1A 23  call far 231A:0098
0DA4  08 C0           or al, al
0DA6  75 06           jne 0xdae
0DA8  FF 76 04        push word ptr [bp + 4]
0DAB  E8 71 FD        call 0xb1f
loc_0DAE:
0DAE  C9              leave
0DAF  C2 02 00        ret 2

; ---- routine 01EE:0DB2  (found by: call)
sub_0DB2:
0DB2  C8 02 00 00     enter 2, 0
0DB6  FF 76 0C        push word ptr [bp + 0xc]
0DB9  FF 76 08        push word ptr [bp + 8]
0DBC  E8 67 F8        call 0x626
0DBF  8B 46 0C        mov ax, word ptr [bp + 0xc]
0DC2  03 46 0A        add ax, word ptr [bp + 0xa]
0DC5  48              dec ax
0DC6  89 46 FE        mov word ptr [bp - 2], ax
0DC9  FF 76 FE        push word ptr [bp - 2]
0DCC  6A 01           push 1
0DCE  FF 36 86 D6     push word ptr [0xd686]
0DD2  6A 18           push 0x18
0DD4  6A 3C           push 0x3c
0DD6  9A 67 01 1A 23  call far 231A:0167
0DDB  8B 46 0A        mov ax, word ptr [bp + 0xa]
0DDE  05 03 00        add ax, 3
0DE1  50              push ax
0DE2  6A 3B           push 0x3b
0DE4  6A 0E           push 0xe
0DE6  9A 03 02 1A 23  call far 231A:0203
0DEB  83 3E 86 D6 00  cmp word ptr [0xd686], 0
0DF0  75 09           jne 0xdfb
0DF2  6A 00           push 0
0DF4  9A B3 95 B5 0A  call far 0AB5:95B3
0DF9  EB 0E           jmp 0xe09
loc_0DFB:
0DFB  8B 7E FE        mov di, word ptr [bp - 2]
0DFE  D1 E7           shl di, 1
0E00  FF B5 DA D1     push word ptr [di - 0x2e26]
0E04  9A B3 95 B5 0A  call far 0AB5:95B3
loc_0E09:
0E09  BF C4 24        mov di, 0x24c4
0E0C  1E              push ds
0E0D  57              push di
0E0E  BF 5C DD        mov di, 0xdd5c
0E11  1E              push ds
0E12  57              push di
0E13  9A 2F 05 1A 23  call far 231A:052F
0E18  83 7E 08 02     cmp word ptr [bp + 8], 2
0E1C  75 1E           jne 0xe3c
0E1E  BF 5A 2B        mov di, 0x2b5a
0E21  1E              push ds
0E22  57              push di
0E23  BF 5C DD        mov di, 0xdd5c
0E26  1E              push ds
0E27  57              push di
0E28  9A 2F 05 1A 23  call far 231A:052F
0E2D  BF 64 2B        mov di, 0x2b64
0E30  1E              push ds
0E31  57              push di
0E32  BF 5C DD        mov di, 0xdd5c
0E35  1E              push ds
0E36  57              push di
0E37  9A 2F 05 1A 23  call far 231A:052F
loc_0E3C:
0E3C  C4 3E 5C DD     les di, ptr [0xdd5c]
0E40  06              push es
0E41  57              push di
0E42  C4 3E 58 DD     les di, ptr [0xdd58]
0E46  06              push es
0E47  57              push di
0E48  68 A0 0F        push 0xfa0
0E4B  9A 12 0A B9 26  call far 26B9:0A12
0E50  9A 9B 09 1A 23  call far 231A:099B
0E55  80 3E 88 DE 01  cmp byte ptr [0xde88], 1
0E5A  B0 00           mov al, 0
0E5C  75 01           jne 0xe5f
0E5E  40              inc ax
loc_0E5F:
0E5F  C4 7E 04        les di, ptr [bp + 4]
0E62  26 88 05        mov byte ptr es:[di], al
0E65  80 3E 88 DE 0D  cmp byte ptr [0xde88], 0xd
0E6A  75 0D           jne 0xe79
0E6C  80 3E 2A 9A 00  cmp byte ptr [0x9a2a], 0
0E71  B0 00           mov al, 0
0E73  75 01           jne 0xe76
0E75  40              inc ax
loc_0E76:
0E76  A2 2A 9A        mov byte ptr [0x9a2a], al
loc_0E79:
0E79  C9              leave
0E7A  C2 0A 00        ret 0xa

; ---- routine 01EE:0E7D  (found by: call)
sub_0E7D:
0E7D  55              push bp
0E7E  89 E5           mov bp, sp
0E80  8B 7E 04        mov di, word ptr [bp + 4]
0E83  36 C7 45 FE 01 00 mov word ptr ss:[di - 2], 1
0E89  36 C6 45 FB 01  mov byte ptr ss:[di - 5], 1
0E8E  9A 85 00 1A 23  call far 231A:0085
0E93  8B 7E 04        mov di, word ptr [bp + 4]
0E96  36 8A 45 FA     mov al, byte ptr ss:[di - 6]
0E9A  30 E4           xor ah, ah
0E9C  50              push ax
0E9D  E8 D2 F6        call 0x572
0EA0  C9              leave
0EA1  C2 02 00        ret 2

; ---- routine 01EE:0EA4  (found by: far)
sub_0EA4:
0EA4  C8 0C 00 00     enter 0xc, 0
0EA8  C4 3E D2 D7     les di, ptr [0xd7d2]
0EAC  89 7E F4        mov word ptr [bp - 0xc], di
0EAF  8C 46 F6        mov word ptr [bp - 0xa], es
0EB2  26 8A 45 04     mov al, byte ptr es:[di + 4]
0EB6  30 E4           xor ah, ah
0EB8  8B F8           mov di, ax
0EBA  80 BD B9 DC 00  cmp byte ptr [di - 0x2347], 0
0EBF  75 03           jne 0xec4
0EC1  E9 D2 00        jmp 0xf96
loc_0EC4:
0EC4  C4 7E F4        les di, ptr [bp - 0xc]
0EC7  26 8A 45 04     mov al, byte ptr es:[di + 4]
0ECB  30 E4           xor ah, ah
0ECD  8B F8           mov di, ax
0ECF  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
0ED3  30 E4           xor ah, ah
0ED5  6B C0 3E        imul ax, ax, 0x3e
0ED8  C4 3E C2 D7     les di, ptr [0xd7c2]
0EDC  03 F8           add di, ax
0EDE  26 8A 45 F9     mov al, byte ptr es:[di - 7]
0EE2  3C 01           cmp al, 1
0EE4  72 04           jb 0xeea
0EE6  3C 04           cmp al, 4
0EE8  76 04           jbe 0xeee
loc_0EEA:
0EEA  B0 00           mov al, 0
0EEC  EB 02           jmp 0xef0
loc_0EEE:
0EEE  B0 01           mov al, 1
loc_0EF0:
0EF0  88 46 FA        mov byte ptr [bp - 6], al
0EF3  55              push bp
0EF4  E8 86 FF        call 0xe7d
loc_0EF7:
0EF7  8A 46 FB        mov al, byte ptr [bp - 5]
0EFA  30 E4           xor ah, ah
0EFC  03 46 FE        add ax, word ptr [bp - 2]
0EFF  48              dec ax
0F00  89 46 FC        mov word ptr [bp - 4], ax
0F03  FF 76 FE        push word ptr [bp - 2]
0F06  8A 46 FB        mov al, byte ptr [bp - 5]
0F09  30 E4           xor ah, ah
0F0B  50              push ax
0F0C  8A 46 FA        mov al, byte ptr [bp - 6]
0F0F  30 E4           xor ah, ah
0F11  50              push ax
0F12  8D 7E F9        lea di, [bp - 7]
0F15  16              push ss
0F16  57              push di
0F17  E8 98 FE        call 0xdb2
0F1A  A0 88 DE        mov al, byte ptr [0xde88]
0F1D  3C 02           cmp al, 2
0F1F  75 41           jne 0xf62
0F21  83 3E 86 D6 00  cmp word ptr [0xd686], 0
0F26  76 38           jbe 0xf60
0F28  8B 7E FC        mov di, word ptr [bp - 4]
0F2B  D1 E7           shl di, 1
0F2D  FF B5 DA D1     push word ptr [di - 0x2e26]
0F31  E8 15 FE        call 0xd49
0F34  C4 7E F4        les di, ptr [bp - 0xc]
0F37  26 8A 45 04     mov al, byte ptr es:[di + 4]
0F3B  30 E4           xor ah, ah
0F3D  8B F8           mov di, ax
0F3F  8A 95 B9 DC     mov dl, byte ptr [di - 0x2347]
0F43  8B 7E FC        mov di, word ptr [bp - 4]
0F46  D1 E7           shl di, 1
0F48  8B 85 DA D1     mov ax, word ptr [di - 0x2e26]
0F4C  C1 E0 03        shl ax, 3
0F4F  C4 3E BA D7     les di, ptr [0xd7ba]
0F53  03 F8           add di, ax
0F55  26 8A 05        mov al, byte ptr es:[di]
0F58  3A C2           cmp al, dl
0F5A  75 04           jne 0xf60
0F5C  55              push bp
0F5D  E8 1D FF        call 0xe7d
loc_0F60:
0F60  EB 2B           jmp 0xf8d
loc_0F62:
0F62  3C 07           cmp al, 7
0F64  74 04           je 0xf6a
0F66  3C 08           cmp al, 8
0F68  75 0E           jne 0xf78
loc_0F6A:
0F6A  8A 46 FA        mov al, byte ptr [bp - 6]
0F6D  34 01           xor al, 1
0F6F  88 46 FA        mov byte ptr [bp - 6], al
0F72  55              push bp
0F73  E8 07 FF        call 0xe7d
0F76  EB 15           jmp 0xf8d
loc_0F78:
0F78  8D 7E FB        lea di, [bp - 5]
0F7B  16              push ss
0F7C  57              push di
0F7D  8D 7E FE        lea di, [bp - 2]
0F80  16              push ss
0F81  57              push di
0F82  6A 14           push 0x14
0F84  FF 36 86 D6     push word ptr [0xd686]
0F88  9A D7 0F 1A 23  call far 231A:0FD7
loc_0F8D:
0F8D  80 7E F9 00     cmp byte ptr [bp - 7], 0
0F91  75 03           jne 0xf96
0F93  E9 61 FF        jmp 0xef7
loc_0F96:
0F96  C9              leave
0F97  CB              retf

; ---- routine 01EE:0F98  (found by: far)
sub_0F98:
0F98  C8 06 00 00     enter 6, 0
0F9C  6B 46 06 3E     imul ax, word ptr [bp + 6], 0x3e
0FA0  C4 3E C2 D7     les di, ptr [0xd7c2]
0FA4  03 F8           add di, ax
0FA6  81 C7 C2 FF     add di, 0xffc2
0FAA  89 7E FA        mov word ptr [bp - 6], di
0FAD  8C 46 FC        mov word ptr [bp - 4], es
0FB0  80 3E 06 86 00  cmp byte ptr [0x8606], 0
0FB5  75 2A           jne 0xfe1
0FB7  C4 3E D2 D7     les di, ptr [0xd7d2]
0FBB  26 8A 45 04     mov al, byte ptr es:[di + 4]
0FBF  30 E4           xor ah, ah
0FC1  8B F8           mov di, ax
0FC3  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
0FC7  30 E4           xor ah, ah
0FC9  3B 46 06        cmp ax, word ptr [bp + 6]
0FCC  74 13           je 0xfe1
0FCE  C4 3E D2 D7     les di, ptr [0xd7d2]
0FD2  26 8A 45 04     mov al, byte ptr es:[di + 4]
0FD6  30 E4           xor ah, ah
0FD8  8B F8           mov di, ax
0FDA  80 BD B9 DC 00  cmp byte ptr [di - 0x2347], 0
0FDF  75 06           jne 0xfe7
loc_0FE1:
0FE1  C6 46 FE 00     mov byte ptr [bp - 2], 0
0FE5  EB 04           jmp 0xfeb
loc_0FE7:
0FE7  C6 46 FE 02     mov byte ptr [bp - 2], 2
loc_0FEB:
0FEB  C4 7E FA        les di, ptr [bp - 6]
0FEE  06              push es
0FEF  57              push di
0FF0  8A 46 FE        mov al, byte ptr [bp - 2]
0FF3  50              push ax
0FF4  9A 43 AD B5 0A  call far 0AB5:AD43
0FF9  80 3E 88 DE 01  cmp byte ptr [0xde88], 1
0FFE  B0 00           mov al, 0
1000  75 01           jne 0x1003
1002  40              inc ax
loc_1003:
1003  88 46 FF        mov byte ptr [bp - 1], al
1006  80 3E 88 DE 02  cmp byte ptr [0xde88], 2
100B  75 2C           jne 0x1039
100D  80 7E FE 02     cmp byte ptr [bp - 2], 2
1011  75 26           jne 0x1039
1013  A0 7E 03        mov al, byte ptr [0x37e]
1016  30 E4           xor ah, ah
1018  D1 E0           shl ax, 1
101A  C4 7E FA        les di, ptr [bp - 6]
101D  03 F8           add di, ax
101F  26 83 7D FE 00  cmp word ptr es:[di - 2], 0
1024  74 13           je 0x1039
1026  A0 7E 03        mov al, byte ptr [0x37e]
1029  30 E4           xor ah, ah
102B  D1 E0           shl ax, 1
102D  C4 7E FA        les di, ptr [bp - 6]
1030  03 F8           add di, ax
1032  26 FF 75 FE     push word ptr es:[di - 2]
1036  E8 10 FD        call 0xd49
loc_1039:
1039  80 7E FF 00     cmp byte ptr [bp - 1], 0
103D  74 AC           je 0xfeb
103F  C9              leave
1040  CA 02 00        retf 2

; ---- routine 01EE:1043  (found by: call)
sub_1043:
1043  C8 06 00 00     enter 6, 0
1047  C4 3E D2 D7     les di, ptr [0xd7d2]
104B  26 8A 45 04     mov al, byte ptr es:[di + 4]
104F  30 E4           xor ah, ah
1051  6B C0 25        imul ax, ax, 0x25
1054  C4 3E D2 D7     les di, ptr [0xd7d2]
1058  03 F8           add di, ax
105A  81 C7 83 00     add di, 0x83
105E  89 7E FA        mov word ptr [bp - 6], di
1061  8C 46 FC        mov word ptr [bp - 4], es
1064  26 80 7D 23 00  cmp byte ptr es:[di + 0x23], 0
1069  74 16           je 0x1081
106B  8B 7E 04        mov di, word ptr [bp + 4]
106E  36 8B 45 06     mov ax, word ptr ss:[di + 6]
1072  C4 3E AE D7     les di, ptr [0xd7ae]
1076  03 F8           add di, ax
1078  26 8A 05        mov al, byte ptr es:[di]
107B  3A 06 D8 DC     cmp al, byte ptr [0xdcd8]
107F  74 24           je 0x10a5
loc_1081:
1081  C4 7E FA        les di, ptr [bp - 6]
1084  26 80 7D 24 00  cmp byte ptr es:[di + 0x24], 0
1089  74 16           je 0x10a1
108B  8B 7E 04        mov di, word ptr [bp + 4]
108E  36 8B 45 06     mov ax, word ptr ss:[di + 6]
1092  C4 3E AE D7     les di, ptr [0xd7ae]
1096  03 F8           add di, ax
1098  26 8A 05        mov al, byte ptr es:[di]
109B  3A 06 D8 DC     cmp al, byte ptr [0xdcd8]
109F  75 04           jne 0x10a5
loc_10A1:
10A1  B0 00           mov al, 0
10A3  EB 02           jmp 0x10a7
loc_10A5:
10A5  B0 01           mov al, 1
loc_10A7:
10A7  88 46 FF        mov byte ptr [bp - 1], al
10AA  8A 46 FF        mov al, byte ptr [bp - 1]
10AD  C9              leave
10AE  C2 02 00        ret 2

; ---- routine 01EE:10B1  (found by: call)
sub_10B1:
10B1  C8 0C 00 00     enter 0xc, 0
10B5  8B 7E 04        mov di, word ptr [bp + 4]
10B8  36 8B 45 06     mov ax, word ptr ss:[di + 6]
10BC  C1 E0 03        shl ax, 3
10BF  C4 3E BA D7     les di, ptr [0xd7ba]
10C3  03 F8           add di, ax
10C5  89 7E F8        mov word ptr [bp - 8], di
10C8  8C 46 FA        mov word ptr [bp - 6], es
10CB  C4 3E D2 D7     les di, ptr [0xd7d2]
10CF  26 8A 45 04     mov al, byte ptr es:[di + 4]
10D3  30 E4           xor ah, ah
10D5  6B C0 25        imul ax, ax, 0x25
10D8  C4 3E D2 D7     les di, ptr [0xd7d2]
10DC  03 F8           add di, ax
10DE  81 C7 83 00     add di, 0x83
10E2  89 7E F4        mov word ptr [bp - 0xc], di
10E5  8C 46 F6        mov word ptr [bp - 0xa], es
10E8  C6 46 FF 00     mov byte ptr [bp - 1], 0
10EC  C7 46 FC 01 00  mov word ptr [bp - 4], 1
10F1  EB 03           jmp 0x10f6
loc_10F3:
10F3  FF 46 FC        inc word ptr [bp - 4]
loc_10F6:
10F6  8B 46 FC        mov ax, word ptr [bp - 4]
10F9  C4 7E F4        les di, ptr [bp - 0xc]
10FC  03 F8           add di, ax
10FE  26 80 7D 15 00  cmp byte ptr es:[di + 0x15], 0
1103  74 29           je 0x112e
1105  C4 7E F8        les di, ptr [bp - 8]
1108  26 8A 45 01     mov al, byte ptr es:[di + 1]
110C  8B 7E FC        mov di, word ptr [bp - 4]
110F  3A 85 E3 01     cmp al, byte ptr [di + 0x1e3]
1113  72 19           jb 0x112e
1115  8B 46 FC        mov ax, word ptr [bp - 4]
1118  40              inc ax
1119  8B F8           mov di, ax
111B  8A 85 E3 01     mov al, byte ptr [di + 0x1e3]
111F  C4 7E F8        les di, ptr [bp - 8]
1122  26 3A 45 01     cmp al, byte ptr es:[di + 1]
1126  76 06           jbe 0x112e
1128  C6 46 FF 01     mov byte ptr [bp - 1], 1
112C  EB 06           jmp 0x1134
loc_112E:
112E  83 7E FC 07     cmp word ptr [bp - 4], 7
1132  75 BF           jne 0x10f3
loc_1134:
1134  8A 46 FF        mov al, byte ptr [bp - 1]
1137  C9              leave
1138  C2 02 00        ret 2

; ---- routine 01EE:113B  (found by: call)
sub_113B:
113B  C8 06 00 00     enter 6, 0
113F  C4 3E D2 D7     les di, ptr [0xd7d2]
1143  26 8A 45 04     mov al, byte ptr es:[di + 4]
1147  30 E4           xor ah, ah
1149  6B C0 25        imul ax, ax, 0x25
114C  C4 3E D2 D7     les di, ptr [0xd7d2]
1150  03 F8           add di, ax
1152  81 C7 83 00     add di, 0x83
1156  89 7E FA        mov word ptr [bp - 6], di
1159  8C 46 FC        mov word ptr [bp - 4], es
115C  26 80 7D 1D 00  cmp byte ptr es:[di + 0x1d], 0
1161  74 10           je 0x1173
1163  8B 7E 04        mov di, word ptr [bp + 4]
1166  36 FF 75 06     push word ptr ss:[di + 6]
116A  9A 6C 4D 51 1B  call far 1B51:4D6C
116F  3C 09           cmp al, 9
1171  72 1E           jb 0x1191
loc_1173:
1173  C4 7E FA        les di, ptr [bp - 6]
1176  26 80 7D 1E 00  cmp byte ptr es:[di + 0x1e], 0
117B  74 10           je 0x118d
117D  8B 7E 04        mov di, word ptr [bp + 4]
1180  36 FF 75 06     push word ptr ss:[di + 6]
1184  9A 6C 4D 51 1B  call far 1B51:4D6C
1189  3C 09           cmp al, 9
118B  73 04           jae 0x1191
loc_118D:
118D  B0 00           mov al, 0
118F  EB 02           jmp 0x1193
loc_1191:
1191  B0 01           mov al, 1
loc_1193:
1193  88 46 FF        mov byte ptr [bp - 1], al
1196  8A 46 FF        mov al, byte ptr [bp - 1]
1199  C9              leave
119A  C2 02 00        ret 2

; ---- routine 01EE:119D  (found by: call)
sub_119D:
119D  C8 0A 00 00     enter 0xa, 0
11A1  8B 7E 04        mov di, word ptr [bp + 4]
11A4  36 6B 45 06 0F  imul ax, word ptr ss:[di + 6], 0xf
11A9  C4 3E BE D7     les di, ptr [0xd7be]
11AD  03 F8           add di, ax
11AF  89 7E FA        mov word ptr [bp - 6], di
11B2  8C 46 FC        mov word ptr [bp - 4], es
11B5  C4 3E D2 D7     les di, ptr [0xd7d2]
11B9  26 8A 45 04     mov al, byte ptr es:[di + 4]
11BD  30 E4           xor ah, ah
11BF  6B C0 25        imul ax, ax, 0x25
11C2  C4 3E D2 D7     les di, ptr [0xd7d2]
11C6  03 F8           add di, ax
11C8  81 C7 83 00     add di, 0x83
11CC  89 7E F6        mov word ptr [bp - 0xa], di
11CF  8C 46 F8        mov word ptr [bp - 8], es
11D2  26 80 7D 1F 00  cmp byte ptr es:[di + 0x1f], 0
11D7  74 0A           je 0x11e3
11D9  C4 7E FA        les di, ptr [bp - 6]
11DC  26 80 7D 06 11  cmp byte ptr es:[di + 6], 0x11
11E1  7C 18           jl 0x11fb
loc_11E3:
11E3  C4 7E F6        les di, ptr [bp - 0xa]
11E6  26 80 7D 20 00  cmp byte ptr es:[di + 0x20], 0
11EB  74 0A           je 0x11f7
11ED  C4 7E FA        les di, ptr [bp - 6]
11F0  26 80 7D 06 11  cmp byte ptr es:[di + 6], 0x11
11F5  7D 04           jge 0x11fb
loc_11F7:
11F7  B0 00           mov al, 0
11F9  EB 02           jmp 0x11fd
loc_11FB:
11FB  B0 01           mov al, 1
loc_11FD:
11FD  88 46 FF        mov byte ptr [bp - 1], al
1200  8A 46 FF        mov al, byte ptr [bp - 1]
1203  C9              leave
1204  C2 02 00        ret 2

; ---- routine 01EE:1207  (found by: call)
sub_1207:
1207  C8 0A 00 00     enter 0xa, 0
120B  8B 7E 04        mov di, word ptr [bp + 4]
120E  36 6B 45 06 0F  imul ax, word ptr ss:[di + 6], 0xf
1213  C4 3E BE D7     les di, ptr [0xd7be]
1217  03 F8           add di, ax
1219  89 7E FA        mov word ptr [bp - 6], di
121C  8C 46 FC        mov word ptr [bp - 4], es
121F  C4 3E D2 D7     les di, ptr [0xd7d2]
1223  26 8A 45 04     mov al, byte ptr es:[di + 4]
1227  30 E4           xor ah, ah
1229  6B C0 25        imul ax, ax, 0x25
122C  C4 3E D2 D7     les di, ptr [0xd7d2]
1230  03 F8           add di, ax
1232  81 C7 83 00     add di, 0x83
1236  89 7E F6        mov word ptr [bp - 0xa], di
1239  8C 46 F8        mov word ptr [bp - 8], es
123C  26 80 7D 21 00  cmp byte ptr es:[di + 0x21], 0
1241  74 11           je 0x1254
1243  C4 7E FA        les di, ptr [bp - 6]
1246  26 80 7D 08 00  cmp byte ptr es:[di + 8], 0
124B  74 1F           je 0x126c
124D  26 80 7D 07 09  cmp byte ptr es:[di + 7], 9
1252  7C 18           jl 0x126c
loc_1254:
1254  C4 7E F6        les di, ptr [bp - 0xa]
1257  26 80 7D 22 00  cmp byte ptr es:[di + 0x22], 0
125C  74 0A           je 0x1268
125E  C4 7E FA        les di, ptr [bp - 6]
1261  26 80 7D 07 09  cmp byte ptr es:[di + 7], 9
1266  7D 04           jge 0x126c
loc_1268:
1268  B0 00           mov al, 0
126A  EB 02           jmp 0x126e
loc_126C:
126C  B0 01           mov al, 1
loc_126E:
126E  88 46 FF        mov byte ptr [bp - 1], al
1271  8A 46 FF        mov al, byte ptr [bp - 1]
1274  C9              leave
1275  C2 02 00        ret 2

; ---- routine 01EE:1278  (found by: call)
sub_1278:
1278  C8 0C 00 00     enter 0xc, 0
127C  8B 7E 04        mov di, word ptr [bp + 4]
127F  36 8B 45 06     mov ax, word ptr ss:[di + 6]
1283  C1 E0 03        shl ax, 3
1286  C4 3E BA D7     les di, ptr [0xd7ba]
128A  03 F8           add di, ax
128C  C4 3E D2 D7     les di, ptr [0xd7d2]
1290  26 8A 45 04     mov al, byte ptr es:[di + 4]
1294  30 E4           xor ah, ah
1296  6B C0 25        imul ax, ax, 0x25
1299  C4 3E D2 D7     les di, ptr [0xd7d2]
129D  03 F8           add di, ax
129F  81 C7 83 00     add di, 0x83
12A3  89 7E F4        mov word ptr [bp - 0xc], di
12A6  8C 46 F6        mov word ptr [bp - 0xa], es
12A9  C6 46 FF 00     mov byte ptr [bp - 1], 0
12AD  C7 46 FC 01 00  mov word ptr [bp - 4], 1
12B2  EB 03           jmp 0x12b7
loc_12B4:
12B4  FF 46 FC        inc word ptr [bp - 4]
loc_12B7:
12B7  8B 46 FC        mov ax, word ptr [bp - 4]
12BA  C4 7E F4        les di, ptr [bp - 0xc]
12BD  03 F8           add di, ax
12BF  26 80 7D FF 00  cmp byte ptr es:[di - 1], 0
12C4  74 51           je 0x1317
12C6  8B 7E 04        mov di, word ptr [bp + 4]
12C9  36 FF 75 06     push word ptr ss:[di + 6]
12CD  9A BD 47 51 1B  call far 1B51:47BD
12D2  8B 7E FC        mov di, word ptr [bp - 4]
12D5  C1 E7 02        shl di, 2
12D8  3B 95 EA 01     cmp dx, word ptr [di + 0x1ea]
12DC  7F 08           jg 0x12e6
12DE  7C 37           jl 0x1317
12E0  3B 85 E8 01     cmp ax, word ptr [di + 0x1e8]
12E4  72 31           jb 0x1317
loc_12E6:
12E6  8B 7E 04        mov di, word ptr [bp + 4]
12E9  36 FF 75 06     push word ptr ss:[di + 6]
12ED  9A BD 47 51 1B  call far 1B51:47BD
12F2  8B C8           mov cx, ax
12F4  8B DA           mov bx, dx
12F6  8B 46 FC        mov ax, word ptr [bp - 4]
12F9  40              inc ax
12FA  8B F8           mov di, ax
12FC  C1 E7 02        shl di, 2
12FF  8B 85 E8 01     mov ax, word ptr [di + 0x1e8]
1303  8B 95 EA 01     mov dx, word ptr [di + 0x1ea]
1307  3B D3           cmp dx, bx
1309  7F 06           jg 0x1311
130B  7C 0A           jl 0x1317
130D  3B C1           cmp ax, cx
130F  76 06           jbe 0x1317
loc_1311:
1311  C6 46 FF 01     mov byte ptr [bp - 1], 1
1315  EB 06           jmp 0x131d
loc_1317:
1317  83 7E FC 09     cmp word ptr [bp - 4], 9
131B  75 97           jne 0x12b4
loc_131D:
131D  8A 46 FF        mov al, byte ptr [bp - 1]
1320  C9              leave
1321  C2 02 00        ret 2

; ---- routine 01EE:1324  (found by: call)
sub_1324:
1324  C8 0A 00 00     enter 0xa, 0
1328  8B 46 06        mov ax, word ptr [bp + 6]
132B  C1 E0 03        shl ax, 3
132E  C4 3E BA D7     les di, ptr [0xd7ba]
1332  03 F8           add di, ax
1334  89 7E FA        mov word ptr [bp - 6], di
1337  8C 46 FC        mov word ptr [bp - 4], es
133A  C4 3E D2 D7     les di, ptr [0xd7d2]
133E  26 8A 45 04     mov al, byte ptr es:[di + 4]
1342  30 E4           xor ah, ah
1344  6B C0 25        imul ax, ax, 0x25
1347  C4 3E D2 D7     les di, ptr [0xd7d2]
134B  03 F8           add di, ax
134D  81 C7 83 00     add di, 0x83
1351  89 7E F6        mov word ptr [bp - 0xa], di
1354  8C 46 F8        mov word ptr [bp - 8], es
1357  C4 7E FA        les di, ptr [bp - 6]
135A  26 8A 05        mov al, byte ptr es:[di]
135D  30 E4           xor ah, ah
135F  8B 7E 04        mov di, word ptr [bp + 4]
1362  36 3B 45 FC     cmp ax, word ptr ss:[di - 4]
1366  74 45           je 0x13ad
1368  C4 7E FA        les di, ptr [bp - 6]
136B  26 8A 45 07     mov al, byte ptr es:[di + 7]
136F  30 E4           xor ah, ah
1371  C4 7E F6        les di, ptr [bp - 0xa]
1374  03 F8           add di, ax
1376  26 80 7D 08 00  cmp byte ptr es:[di + 8], 0
137B  74 30           je 0x13ad
137D  55              push bp
137E  E8 C2 FC        call 0x1043
1381  08 C0           or al, al
1383  74 28           je 0x13ad
1385  55              push bp
1386  E8 28 FD        call 0x10b1
1389  08 C0           or al, al
138B  74 20           je 0x13ad
138D  55              push bp
138E  E8 AA FD        call 0x113b
1391  08 C0           or al, al
1393  74 18           je 0x13ad
1395  55              push bp
1396  E8 04 FE        call 0x119d
1399  08 C0           or al, al
139B  74 10           je 0x13ad
139D  55              push bp
139E  E8 66 FE        call 0x1207
13A1  08 C0           or al, al
13A3  74 08           je 0x13ad
13A5  55              push bp
13A6  E8 CF FE        call 0x1278
13A9  08 C0           or al, al
13AB  75 04           jne 0x13b1
loc_13AD:
13AD  B0 00           mov al, 0
13AF  EB 02           jmp 0x13b3
loc_13B1:
13B1  B0 01           mov al, 1
loc_13B3:
13B3  88 46 FF        mov byte ptr [bp - 1], al
13B6  8A 46 FF        mov al, byte ptr [bp - 1]
13B9  C9              leave
13BA  C2 04 00        ret 4

; ---- routine 01EE:13BD  (found by: call)
sub_13BD:
13BD  C8 08 00 00     enter 8, 0
13C1  31 C0           xor ax, ax
13C3  A3 86 D6        mov word ptr [0xd686], ax
13C6  8B 7E 04        mov di, word ptr [bp + 4]
13C9  36 C7 45 FA 01 00 mov word ptr ss:[di - 6], 1
13CF  C6 06 E3 01 01  mov byte ptr [0x1e3], 1
13D4  C7 46 FC 01 00  mov word ptr [bp - 4], 1
13D9  EB 03           jmp 0x13de
loc_13DB:
13DB  FF 46 FC        inc word ptr [bp - 4]
loc_13DE:
13DE  8B 7E FC        mov di, word ptr [bp - 4]
13E1  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
13E5  30 E4           xor ah, ah
13E7  8B 7E 04        mov di, word ptr [bp + 4]
13EA  36 3B 45 FC     cmp ax, word ptr ss:[di - 4]
13EE  74 66           je 0x1456
13F0  C7 46 FE 01 00  mov word ptr [bp - 2], 1
13F5  EB 03           jmp 0x13fa
loc_13F7:
13F7  FF 46 FE        inc word ptr [bp - 2]
loc_13FA:
13FA  8B 7E FC        mov di, word ptr [bp - 4]
13FD  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
1401  30 E4           xor ah, ah
1403  6B C0 3E        imul ax, ax, 0x3e
1406  C4 3E C2 D7     les di, ptr [0xd7c2]
140A  03 F8           add di, ax
140C  81 C7 C2 FF     add di, 0xffc2
1410  89 7E F8        mov word ptr [bp - 8], di
1413  8C 46 FA        mov word ptr [bp - 6], es
1416  8B 46 FE        mov ax, word ptr [bp - 2]
1419  D1 E0           shl ax, 1
141B  03 F8           add di, ax
141D  26 83 7D FE 00  cmp word ptr es:[di - 2], 0
1422  74 2C           je 0x1450
1424  8B 46 FE        mov ax, word ptr [bp - 2]
1427  D1 E0           shl ax, 1
1429  C4 7E F8        les di, ptr [bp - 8]
142C  03 F8           add di, ax
142E  26 FF 75 FE     push word ptr es:[di - 2]
1432  8B 7E 04        mov di, word ptr [bp + 4]
1435  57              push di
1436  E8 EB FE        call 0x1324
1439  08 C0           or al, al
143B  74 13           je 0x1450
143D  8B 46 FE        mov ax, word ptr [bp - 2]
1440  D1 E0           shl ax, 1
1442  C4 7E F8        les di, ptr [bp - 8]
1445  03 F8           add di, ax
1447  26 FF 75 FE     push word ptr es:[di - 2]
144B  9A 9D 44 51 1B  call far 1B51:449D
loc_1450:
1450  83 7E FE 14     cmp word ptr [bp - 2], 0x14
1454  75 A1           jne 0x13f7
loc_1456:
1456  81 7E FC B0 00  cmp word ptr [bp - 4], 0xb0
145B  74 03           je 0x1460
145D  E9 7B FF        jmp 0x13db
loc_1460:
1460  C4 3E D2 D7     les di, ptr [0xd7d2]
1464  26 8A 45 04     mov al, byte ptr es:[di + 4]
1468  30 E4           xor ah, ah
146A  8B F8           mov di, ax
146C  8A 85 0F 02     mov al, byte ptr [di + 0x20f]
1470  30 E4           xor ah, ah
1472  8B F8           mov di, ax
1474  80 BD B9 DC 00  cmp byte ptr [di - 0x2347], 0
1479  75 03           jne 0x147e
147B  E9 A2 00        jmp 0x1520
loc_147E:
147E  C4 3E D2 D7     les di, ptr [0xd7d2]
1482  89 7E F8        mov word ptr [bp - 8], di
1485  8C 46 FA        mov word ptr [bp - 6], es
1488  C7 46 FE 01 00  mov word ptr [bp - 2], 1
148D  EB 03           jmp 0x1492
loc_148F:
148F  FF 46 FE        inc word ptr [bp - 2]
loc_1492:
1492  8B 46 FE        mov ax, word ptr [bp - 2]
1495  D1 E0           shl ax, 1
1497  8B D0           mov dx, ax
1499  C4 7E F8        les di, ptr [bp - 8]
149C  26 8A 45 04     mov al, byte ptr es:[di + 4]
14A0  30 E4           xor ah, ah
14A2  8B F8           mov di, ax
14A4  8A 85 0F 02     mov al, byte ptr [di + 0x20f]
14A8  30 E4           xor ah, ah
14AA  6B C0 28        imul ax, ax, 0x28
14AD  C4 7E F8        les di, ptr [bp - 8]
14B0  03 F8           add di, ax
14B2  03 FA           add di, dx
14B4  26 83 7D 2E 00  cmp word ptr es:[di + 0x2e], 0
14B9  74 5C           je 0x1517
14BB  8B 46 FE        mov ax, word ptr [bp - 2]
14BE  D1 E0           shl ax, 1
14C0  8B D0           mov dx, ax
14C2  C4 7E F8        les di, ptr [bp - 8]
14C5  26 8A 45 04     mov al, byte ptr es:[di + 4]
14C9  30 E4           xor ah, ah
14CB  8B F8           mov di, ax
14CD  8A 85 0F 02     mov al, byte ptr [di + 0x20f]
14D1  30 E4           xor ah, ah
14D3  6B C0 28        imul ax, ax, 0x28
14D6  C4 7E F8        les di, ptr [bp - 8]
14D9  03 F8           add di, ax
14DB  03 FA           add di, dx
14DD  26 FF 75 2E     push word ptr es:[di + 0x2e]
14E1  8B 7E 04        mov di, word ptr [bp + 4]
14E4  57              push di
14E5  E8 3C FE        call 0x1324
14E8  08 C0           or al, al
14EA  74 2B           je 0x1517
14EC  8B 46 FE        mov ax, word ptr [bp - 2]
14EF  D1 E0           shl ax, 1
14F1  8B D0           mov dx, ax
14F3  C4 7E F8        les di, ptr [bp - 8]
14F6  26 8A 45 04     mov al, byte ptr es:[di + 4]
14FA  30 E4           xor ah, ah
14FC  8B F8           mov di, ax
14FE  8A 85 0F 02     mov al, byte ptr [di + 0x20f]
1502  30 E4           xor ah, ah
1504  6B C0 28        imul ax, ax, 0x28
1507  C4 7E F8        les di, ptr [bp - 8]
150A  03 F8           add di, ax
150C  03 FA           add di, dx
150E  26 FF 75 2E     push word ptr es:[di + 0x2e]
1512  9A 9D 44 51 1B  call far 1B51:449D
loc_1517:
1517  83 7E FE 14     cmp word ptr [bp - 2], 0x14
151B  74 03           je 0x1520
151D  E9 6F FF        jmp 0x148f
loc_1520:
1520  C9              leave
1521  C2 02 00        ret 2
; data (not reached as code), 69 bytes
1524                  pstr "You don't have a scout"
153B                  pstr 'There are no players fitting these conditions'

; ---- routine 01EE:1569  (found by: far)
sub_1569:
1569  C8 1C 01 00     enter 0x11c, 0
156D  C4 3E D2 D7     les di, ptr [0xd7d2]
1571  89 7E E8        mov word ptr [bp - 0x18], di
1574  8C 46 EA        mov word ptr [bp - 0x16], es
1577  26 8A 45 04     mov al, byte ptr es:[di + 4]
157B  30 E4           xor ah, ah
157D  6B C0 25        imul ax, ax, 0x25
1580  03 F8           add di, ax
1582  81 C7 83 00     add di, 0x83
1586  89 7E E4        mov word ptr [bp - 0x1c], di
1589  8C 46 E6        mov word ptr [bp - 0x1a], es
158C  C4 7E E8        les di, ptr [bp - 0x18]
158F  26 8A 45 04     mov al, byte ptr es:[di + 4]
1593  30 E4           xor ah, ah
1595  8B F8           mov di, ax
1597  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
159B  30 E4           xor ah, ah
159D  89 46 FC        mov word ptr [bp - 4], ax
15A0  83 7E FC 00     cmp word ptr [bp - 4], 0
15A4  74 23           je 0x15c9
15A6  6B 46 FC 3E     imul ax, word ptr [bp - 4], 0x3e
15AA  C4 3E C2 D7     les di, ptr [0xd7c2]
15AE  03 F8           add di, ax
15B0  26 83 7D F0 00  cmp word ptr es:[di - 0x10], 0
15B5  B0 00           mov al, 0
15B7  75 01           jne 0x15ba
15B9  40              inc ax
loc_15BA:
15BA  50              push ax
15BB  BF 24 15        mov di, 0x1524
15BE  0E              push cs
15BF  57              push di
15C0  9A 98 00 1A 23  call far 231A:0098
15C5  08 C0           or al, al
15C7  74 03           je 0x15cc
loc_15C9:
15C9  E9 C0 03        jmp 0x198c
loc_15CC:
15CC  C6 46 F5 00     mov byte ptr [bp - 0xb], 0
15D0  C4 7E E8        les di, ptr [bp - 0x18]
15D3  26 8A 45 04     mov al, byte ptr es:[di + 4]
15D7  30 E4           xor ah, ah
15D9  6B C0 25        imul ax, ax, 0x25
15DC  03 F8           add di, ax
15DE  26 8D 85 83 00  lea ax, es:[di + 0x83]
15E3  8C C2           mov dx, es
15E5  89 46 F0        mov word ptr [bp - 0x10], ax
15E8  89 56 F2        mov word ptr [bp - 0xe], dx
loc_15EB:
15EB  C6 06 E3 01 1D  mov byte ptr [0x1e3], 0x1d
15F0  A0 E3 01        mov al, byte ptr [0x1e3]
15F3  30 E4           xor ah, ah
15F5  C4 7E F0        les di, ptr [bp - 0x10]
15F8  03 F8           add di, ax
15FA  26 C6 45 FF 00  mov byte ptr es:[di - 1], 0
15FF  BF 22 63        mov di, 0x6322
1602  1E              push ds
1603  57              push di
1604  BF 5C DD        mov di, 0xdd5c
1607  1E              push ds
1608  57              push di
1609  9A 2F 05 1A 23  call far 231A:052F
loc_160E:
160E  BF BC 3E        mov di, 0x3ebc
1611  1E              push ds
1612  57              push di
1613  BF 5C DD        mov di, 0xdd5c
1616  1E              push ds
1617  57              push di
1618  9A 2F 05 1A 23  call far 231A:052F
161D  31 C0           xor ax, ax
161F  89 46 FE        mov word ptr [bp - 2], ax
1622  EB 03           jmp 0x1627
loc_1624:
1624  FF 46 FE        inc word ptr [bp - 2]
loc_1627:
1627  8B 7E FE        mov di, word ptr [bp - 2]
162A  8A 85 08 87     mov al, byte ptr [di - 0x78f8]
162E  50              push ax
162F  6B 7E FE 13     imul di, word ptr [bp - 2], 0x13
1633  81 C7 24 87     add di, 0x8724
1637  1E              push ds
1638  57              push di
1639  8B 46 FE        mov ax, word ptr [bp - 2]
163C  05 09 00        add ax, 9
163F  8B F8           mov di, ax
1641  8A 85 25 01     mov al, byte ptr [di + 0x125]
1645  50              push ax
1646  8B 46 FE        mov ax, word ptr [bp - 2]
1649  05 09 00        add ax, 9
164C  8B F8           mov di, ax
164E  8A 85 97 01     mov al, byte ptr [di + 0x197]
1652  30 E4           xor ah, ah
1654  40              inc ax
1655  50              push ax
1656  BF 5C DD        mov di, 0xdd5c
1659  1E              push ds
165A  57              push di
165B  9A 1B 04 1A 23  call far 231A:041B
1660  83 7E FE 0D     cmp word ptr [bp - 2], 0xd
1664  75 BE           jne 0x1624
1666  C7 46 FE 01 00  mov word ptr [bp - 2], 1
166B  EB 03           jmp 0x1670
loc_166D:
166D  FF 46 FE        inc word ptr [bp - 2]
loc_1670:
1670  8B 46 FE        mov ax, word ptr [bp - 2]
1673  C4 7E E4        les di, ptr [bp - 0x1c]
1676  03 F8           add di, ax
1678  26 8A 45 1C     mov al, byte ptr es:[di + 0x1c]
167C  98              cwde
167D  8B F8           mov di, ax
167F  8A 85 24 01     mov al, byte ptr [di + 0x124]
1683  50              push ax
1684  8D BE E4 FE     lea di, [bp - 0x11c]
1688  16              push ss
1689  57              push di
168A  8B 46 FE        mov ax, word ptr [bp - 2]
168D  C4 7E E4        les di, ptr [bp - 0x1c]
1690  03 F8           add di, ax
1692  26 8A 45 1C     mov al, byte ptr es:[di + 0x1c]
1696  98              cwde
1697  8B F8           mov di, ax
1699  8A 85 22 01     mov al, byte ptr [di + 0x122]
169D  50              push ax
169E  9A 6F 0C B9 26  call far 26B9:0C6F
16A3  8B 46 FE        mov ax, word ptr [bp - 2]
16A6  05 1D 00        add ax, 0x1d
16A9  8B F8           mov di, ax
16AB  8A 85 25 01     mov al, byte ptr [di + 0x125]
16AF  50              push ax
16B0  6A 4E           push 0x4e
16B2  BF 5C DD        mov di, 0xdd5c
16B5  1E              push ds
16B6  57              push di
16B7  9A 1B 04 1A 23  call far 231A:041B
16BC  83 7E FE 08     cmp word ptr [bp - 2], 8
16C0  75 AB           jne 0x166d
16C2  31 C0           xor ax, ax
16C4  89 46 FE        mov word ptr [bp - 2], ax
16C7  EB 03           jmp 0x16cc
loc_16C9:
16C9  FF 46 FE        inc word ptr [bp - 2]
loc_16CC:
16CC  8B 46 FE        mov ax, word ptr [bp - 2]
16CF  C4 7E E4        les di, ptr [bp - 0x1c]
16D2  03 F8           add di, ax
16D4  26 8A 45 08     mov al, byte ptr es:[di + 8]
16D8  98              cwde
16D9  8B F8           mov di, ax
16DB  8A 85 24 01     mov al, byte ptr [di + 0x124]
16DF  50              push ax
16E0  8D BE E4 FE     lea di, [bp - 0x11c]
16E4  16              push ss
16E5  57              push di
16E6  8B 46 FE        mov ax, word ptr [bp - 2]
16E9  C4 7E E4        les di, ptr [bp - 0x1c]
16EC  03 F8           add di, ax
16EE  26 8A 45 08     mov al, byte ptr es:[di + 8]
16F2  98              cwde
16F3  8B F8           mov di, ax
16F5  8A 85 22 01     mov al, byte ptr [di + 0x122]
16F9  50              push ax
16FA  9A 6F 0C B9 26  call far 26B9:0C6F
16FF  8B 46 FE        mov ax, word ptr [bp - 2]
1702  05 09 00        add ax, 9
1705  8B F8           mov di, ax
1707  8A 85 25 01     mov al, byte ptr [di + 0x125]
170B  50              push ax
170C  6A 31           push 0x31
170E  BF 5C DD        mov di, 0xdd5c
1711  1E              push ds
1712  57              push di
1713  9A 1B 04 1A 23  call far 231A:041B
1718  83 7E FE 0D     cmp word ptr [bp - 2], 0xd
171C  75 AB           jne 0x16c9
171E  C7 46 FE 01 00  mov word ptr [bp - 2], 1
1723  EB 03           jmp 0x1728
loc_1725:
1725  FF 46 FE        inc word ptr [bp - 2]
loc_1728:
1728  8B 46 FE        mov ax, word ptr [bp - 2]
172B  C4 7E E4        les di, ptr [bp - 0x1c]
172E  03 F8           add di, ax
1730  26 8A 45 FF     mov al, byte ptr es:[di - 1]
1734  98              cwde
1735  8B F8           mov di, ax
1737  8A 85 24 01     mov al, byte ptr [di + 0x124]
173B  50              push ax
173C  8D BE E4 FE     lea di, [bp - 0x11c]
1740  16              push ss
1741  57              push di
1742  8B 46 FE        mov ax, word ptr [bp - 2]
1745  C4 7E E4        les di, ptr [bp - 0x1c]
1748  03 F8           add di, ax
174A  26 8A 45 FF     mov al, byte ptr es:[di - 1]
174E  98              cwde
174F  8B F8           mov di, ax
1751  8A 85 22 01     mov al, byte ptr [di + 0x122]
1755  50              push ax
1756  9A 6F 0C B9 26  call far 26B9:0C6F
175B  8B 7E FE        mov di, word ptr [bp - 2]
175E  8A 85 25 01     mov al, byte ptr [di + 0x125]
1762  50              push ax
1763  6A 1A           push 0x1a
1765  BF 5C DD        mov di, 0xdd5c
1768  1E              push ds
1769  57              push di
176A  9A 1B 04 1A 23  call far 231A:041B
176F  83 7E FE 08     cmp word ptr [bp - 2], 8
1773  75 B0           jne 0x1725
1775  C7 46 FE 01 00  mov word ptr [bp - 2], 1
177A  EB 03           jmp 0x177f
loc_177C:
177C  FF 46 FE        inc word ptr [bp - 2]
loc_177F:
177F  8B 46 FE        mov ax, word ptr [bp - 2]
1782  C4 7E E4        les di, ptr [bp - 0x1c]
1785  03 F8           add di, ax
1787  26 8A 45 15     mov al, byte ptr es:[di + 0x15]
178B  98              cwde
178C  8B F8           mov di, ax
178E  8A 85 24 01     mov al, byte ptr [di + 0x124]
1792  50              push ax
1793  8D BE E4 FE     lea di, [bp - 0x11c]
1797  16              push ss
1798  57              push di
1799  8B 46 FE        mov ax, word ptr [bp - 2]
179C  C4 7E E4        les di, ptr [bp - 0x1c]
179F  03 F8           add di, ax
17A1  26 8A 45 15     mov al, byte ptr es:[di + 0x15]
17A5  98              cwde
17A6  8B F8           mov di, ax
17A8  8A 85 22 01     mov al, byte ptr [di + 0x122]
17AC  50              push ax
17AD  9A 6F 0C B9 26  call far 26B9:0C6F
17B2  8B 46 FE        mov ax, word ptr [bp - 2]
17B5  05 16 00        add ax, 0x16
17B8  8B F8           mov di, ax
17BA  8A 85 25 01     mov al, byte ptr [di + 0x125]
17BE  50              push ax
17BF  6A 3D           push 0x3d
17C1  BF 5C DD        mov di, 0xdd5c
17C4  1E              push ds
17C5  57              push di
17C6  9A 1B 04 1A 23  call far 231A:041B
17CB  83 7E FE 06     cmp word ptr [bp - 2], 6
17CF  75 AB           jne 0x177c
17D1  A0 E3 01        mov al, byte ptr [0x1e3]
17D4  30 E4           xor ah, ah
17D6  8B F8           mov di, ax
17D8  8A 85 25 01     mov al, byte ptr [di + 0x125]
17DC  30 E4           xor ah, ah
17DE  50              push ax
17DF  A0 E3 01        mov al, byte ptr [0x1e3]
17E2  30 E4           xor ah, ah
17E4  8B F8           mov di, ax
17E6  8A 85 97 01     mov al, byte ptr [di + 0x197]
17EA  30 E4           xor ah, ah
17EC  50              push ax
17ED  A0 E3 01        mov al, byte ptr [0x1e3]
17F0  30 E4           xor ah, ah
17F2  8B F8           mov di, ax
17F4  8A 85 BD 01     mov al, byte ptr [di + 0x1bd]
17F8  30 E4           xor ah, ah
17FA  50              push ax
17FB  9A 03 02 1A 23  call far 231A:0203
1800  C4 3E 5C DD     les di, ptr [0xdd5c]
1804  06              push es
1805  57              push di
1806  C4 3E 58 DD     les di, ptr [0xdd58]
180A  06              push es
180B  57              push di
180C  68 A0 0F        push 0xfa0
180F  9A 12 0A B9 26  call far 26B9:0A12
1814  9A 9B 09 1A 23  call far 231A:099B
1819  80 3E 88 DE 07  cmp byte ptr [0xde88], 7
181E  75 10           jne 0x1830
1820  A0 E3 01        mov al, byte ptr [0x1e3]
1823  30 E4           xor ah, ah
1825  8B F8           mov di, ax
1827  8A 85 4B 01     mov al, byte ptr [di + 0x14b]
182B  A2 E3 01        mov byte ptr [0x1e3], al
182E  EB 2F           jmp 0x185f
loc_1830:
1830  80 3E 88 DE 08  cmp byte ptr [0xde88], 8
1835  75 10           jne 0x1847
1837  A0 E3 01        mov al, byte ptr [0x1e3]
183A  30 E4           xor ah, ah
183C  8B F8           mov di, ax
183E  8A 85 71 01     mov al, byte ptr [di + 0x171]
1842  A2 E3 01        mov byte ptr [0x1e3], al
1845  EB 18           jmp 0x185f
loc_1847:
1847  80 3E 88 DE 01  cmp byte ptr [0xde88], 1
184C  75 05           jne 0x1853
184E  E9 3B 01        jmp 0x198c
; data (not reached as code), 2 bytes
1851                  db EB 0C   ; ..
loc_1853:
1853  BF E3 01        mov di, 0x1e3
1856  1E              push ds
1857  57              push di
1858  6A 25           push 0x25
185A  9A C4 0E 1A 23  call far 231A:0EC4
loc_185F:
185F  80 3E 88 DE 02  cmp byte ptr [0xde88], 2
1864  75 77           jne 0x18dd
1866  A0 E3 01        mov al, byte ptr [0x1e3]
1869  30 E4           xor ah, ah
186B  C4 7E F0        les di, ptr [bp - 0x10]
186E  03 F8           add di, ax
1870  26 80 7D FF 00  cmp byte ptr es:[di - 1], 0
1875  B0 00           mov al, 0
1877  75 01           jne 0x187a
1879  40              inc ax
loc_187A:
187A  8A D0           mov dl, al
187C  A0 E3 01        mov al, byte ptr [0x1e3]
187F  30 E4           xor ah, ah
1881  C4 7E F0        les di, ptr [bp - 0x10]
1884  03 F8           add di, ax
1886  26 88 55 FF     mov byte ptr es:[di - 1], dl
188A  A0 E3 01        mov al, byte ptr [0x1e3]
188D  3C 1E           cmp al, 0x1e
188F  72 4C           jb 0x18dd
1891  3C 25           cmp al, 0x25
1893  77 48           ja 0x18dd
1895  A0 E3 01        mov al, byte ptr [0x1e3]
1898  D0 E8           shr al, 1
189A  B0 00           mov al, 0
189C  73 01           jae 0x189f
189E  40              inc ax
loc_189F:
189F  30 E4           xor ah, ah
18A1  8B D0           mov dx, ax
18A3  A0 E3 01        mov al, byte ptr [0x1e3]
18A6  30 E4           xor ah, ah
18A8  2B C2           sub ax, dx
18AA  C4 7E F0        les di, ptr [bp - 0x10]
18AD  03 F8           add di, ax
18AF  26 8A 45 FF     mov al, byte ptr es:[di - 1]
18B3  98              cwde
18B4  09 C0           or ax, ax
18B6  75 25           jne 0x18dd
18B8  A0 E3 01        mov al, byte ptr [0x1e3]
18BB  D0 E8           shr al, 1
18BD  B0 00           mov al, 0
18BF  72 01           jb 0x18c2
18C1  40              inc ax
loc_18C2:
18C2  98              cwde
18C3  8B F8           mov di, ax
18C5  8A 85 38 A3     mov al, byte ptr [di - 0x5cc8]
18C9  98              cwde
18CA  8B D0           mov dx, ax
18CC  A0 E3 01        mov al, byte ptr [0x1e3]
18CF  30 E4           xor ah, ah
18D1  03 C2           add ax, dx
18D3  C4 7E F0        les di, ptr [bp - 0x10]
18D6  03 F8           add di, ax
18D8  26 C6 45 FF 01  mov byte ptr es:[di - 1], 1
loc_18DD:
18DD  C4 7E F0        les di, ptr [bp - 0x10]
18E0  26 80 7D 1C 00  cmp byte ptr es:[di + 0x1c], 0
18E5  75 03           jne 0x18ea
18E7  E9 24 FD        jmp 0x160e
loc_18EA:
18EA  55              push bp
18EB  E8 CF FA        call 0x13bd
18EE  83 3E 86 D6 00  cmp word ptr [0xd686], 0
18F3  B0 00           mov al, 0
18F5  75 01           jne 0x18f8
18F7  40              inc ax
loc_18F8:
18F8  50              push ax
18F9  BF 3B 15        mov di, 0x153b
18FC  0E              push cs
18FD  57              push di
18FE  9A 98 00 1A 23  call far 231A:0098
1903  08 C0           or al, al
1905  74 03           je 0x190a
1907  E9 7F 00        jmp 0x1989
loc_190A:
190A  FF 76 FA        push word ptr [bp - 6]
190D  A0 E3 01        mov al, byte ptr [0x1e3]
1910  30 E4           xor ah, ah
1912  50              push ax
1913  6A 02           push 2
1915  8D 7E F5        lea di, [bp - 0xb]
1918  16              push ss
1919  57              push di
191A  E8 95 F4        call 0xdb2
191D  80 3E 88 DE 02  cmp byte ptr [0xde88], 2
1922  74 17           je 0x193b
1924  BF E3 01        mov di, 0x1e3
1927  1E              push ds
1928  57              push di
1929  8D 7E FA        lea di, [bp - 6]
192C  16              push ss
192D  57              push di
192E  6A 14           push 0x14
1930  FF 36 86 D6     push word ptr [0xd686]
1934  9A D7 0F 1A 23  call far 231A:0FD7
1939  EB 48           jmp 0x1983
loc_193B:
193B  83 3E 86 D6 00  cmp word ptr [0xd686], 0
1940  76 41           jbe 0x1983
1942  A0 E3 01        mov al, byte ptr [0x1e3]
1945  30 E4           xor ah, ah
1947  03 46 FA        add ax, word ptr [bp - 6]
194A  48              dec ax
194B  8B F8           mov di, ax
194D  D1 E7           shl di, 1
194F  8B 85 DA D1     mov ax, word ptr [di - 0x2e26]
1953  89 46 F8        mov word ptr [bp - 8], ax
1956  FF 76 F8        push word ptr [bp - 8]
1959  E8 ED F3        call 0xd49
195C  C4 3E D2 D7     les di, ptr [0xd7d2]
1960  26 8A 45 04     mov al, byte ptr es:[di + 4]
1964  30 E4           xor ah, ah
1966  8B F8           mov di, ax
1968  8A 95 B9 DC     mov dl, byte ptr [di - 0x2347]
196C  8B 46 F8        mov ax, word ptr [bp - 8]
196F  C1 E0 03        shl ax, 3
1972  C4 3E BA D7     les di, ptr [0xd7ba]
1976  03 F8           add di, ax
1978  26 8A 05        mov al, byte ptr es:[di]
197B  3A C2           cmp al, dl
197D  75 04           jne 0x1983
197F  55              push bp
1980  E8 3A FA        call 0x13bd
loc_1983:
1983  80 7E F5 00     cmp byte ptr [bp - 0xb], 0
1987  74 81           je 0x190a
loc_1989:
1989  E9 5F FC        jmp 0x15eb
loc_198C:
198C  C9              leave
198D  CB              retf

