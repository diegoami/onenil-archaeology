; 1-0.EXE (One-Nil 96), code segment 1B55 (image offsets 1B550..2315F), part 8 of 12
; packed 1-0.EXE sha256 89ff9c5f238f24e81a0c2440a46cdd8997280a65fc3cc3d97cb974f55280a80a (LZEXE 0.91)
; unpacked (tools/static/unlzexe.py) sha256 887ed2a92767950e5309b2052409f875668605939b69e00737aa3047022b9f51
; tool: capstone 5.0.9 (pip package; core library 5.0.1280) (CS_ARCH_X86, CS_MODE_16), recursive descent from the entry point, far calls and near calls/jumps, then routine prologues (55 89 E5 / 55 8B EC / C8 iw 00) in what remains; tools/static/listing.py
; addresses are SEGMENT:OFFSET with SEGMENT the image paragraph before relocation; image offset = SEGMENT*16+OFFSET
; ---- routine 1B55:4C4A  (found by: far)
sub_4C4A:
4C4A  C8 02 00 00     enter 2, 0
4C4E  FF 76 0A        push word ptr [bp + 0xa]
4C51  6A 01           push 1
4C53  0E              push cs
4C54  E8 F3 FE        call 0x4b4a
4C57  C1 E8 04        shr ax, 4
4C5A  89 46 FE        mov word ptr [bp - 2], ax
4C5D  83 7E FE 10     cmp word ptr [bp - 2], 0x10
4C61  76 05           jbe 0x4c68
4C63  C7 46 FE 10 00  mov word ptr [bp - 2], 0x10
loc_4C68:
4C68  83 7E FE 00     cmp word ptr [bp - 2], 0
4C6C  75 24           jne 0x4c92
4C6E  FF 76 0A        push word ptr [bp + 0xa]
4C71  0E              push cs
4C72  E8 14 03        call 0x4f89
4C75  08 C0           or al, al
4C77  74 19           je 0x4c92
4C79  BF 2D 4C        mov di, 0x4c2d
4C7C  0E              push cs
4C7D  57              push di
4C7E  8A 46 08        mov al, byte ptr [bp + 8]
4C81  50              push ax
4C82  8A 46 06        mov al, byte ptr [bp + 6]
4C85  50              push ax
4C86  BF 5C DD        mov di, 0xdd5c
4C89  1E              push ds
4C8A  57              push di
4C8B  9A 9D 03 2A 23  call far 232A:039D
4C90  EB 76           jmp 0x4d08
loc_4C92:
4C92  8B 46 0A        mov ax, word ptr [bp + 0xa]
4C95  C1 E0 03        shl ax, 3
4C98  C4 3E BA D7     les di, ptr [0xd7ba]
4C9C  03 F8           add di, ax
4C9E  26 80 7D 01 12  cmp byte ptr es:[di + 1], 0x12
4CA3  73 19           jae 0x4cbe
4CA5  BF 38 4C        mov di, 0x4c38
4CA8  0E              push cs
4CA9  57              push di
4CAA  8A 46 08        mov al, byte ptr [bp + 8]
4CAD  50              push ax
4CAE  8A 46 06        mov al, byte ptr [bp + 6]
4CB1  50              push ax
4CB2  BF 5C DD        mov di, 0xdd5c
4CB5  1E              push ds
4CB6  57              push di
4CB7  9A 9D 03 2A 23  call far 232A:039D
4CBC  EB 4A           jmp 0x4d08
loc_4CBE:
4CBE  8B 7E FE        mov di, word ptr [bp - 2]
4CC1  8A 85 8E 93     mov al, byte ptr [di - 0x6c72]
4CC5  30 E4           xor ah, ah
4CC7  8B F8           mov di, ax
4CC9  C1 E7 04        shl di, 4
4CCC  81 C7 0C 8A     add di, 0x8a0c
4CD0  1E              push ds
4CD1  57              push di
4CD2  8A 46 08        mov al, byte ptr [bp + 8]
4CD5  50              push ax
4CD6  8A 46 06        mov al, byte ptr [bp + 6]
4CD9  50              push ax
4CDA  BF 5C DD        mov di, 0xdd5c
4CDD  1E              push ds
4CDE  57              push di
4CDF  9A 9D 03 2A 23  call far 232A:039D
4CE4  8B 46 06        mov ax, word ptr [bp + 6]
4CE7  D1 E0           shl ax, 1
4CE9  8B D0           mov dx, ax
4CEB  69 46 08 A0 00  imul ax, word ptr [bp + 8], 0xa0
4CF0  C4 3E 5C DD     les di, ptr [0xdd5c]
4CF4  03 F8           add di, ax
4CF6  03 FA           add di, dx
4CF8  81 C7 5E FF     add di, 0xff5e
4CFC  06              push es
4CFD  57              push di
4CFE  6A 70           push 0x70
4D00  FF 76 FE        push word ptr [bp - 2]
4D03  9A 4B 03 BC 24  call far 24BC:034B
loc_4D08:
4D08  C9              leave
4D09  CA 06 00        retf 6

; ---- routine 1B55:4D0C  (found by: far)
sub_4D0C:
4D0C  C8 02 00 00     enter 2, 0
4D10  83 7E 0A CE     cmp word ptr [bp + 0xa], -0x32
4D14  7D 07           jge 0x4d1d
4D16  C7 46 FE 01 00  mov word ptr [bp - 2], 1
4D1B  EB 55           jmp 0x4d72
loc_4D1D:
4D1D  83 7E 0A 00     cmp word ptr [bp + 0xa], 0
4D21  7D 07           jge 0x4d2a
4D23  C7 46 FE 02 00  mov word ptr [bp - 2], 2
4D28  EB 48           jmp 0x4d72
loc_4D2A:
4D2A  83 7E 0A 14     cmp word ptr [bp + 0xa], 0x14
4D2E  7D 07           jge 0x4d37
4D30  C7 46 FE 03 00  mov word ptr [bp - 2], 3
4D35  EB 3B           jmp 0x4d72
loc_4D37:
4D37  83 7E 0A 28     cmp word ptr [bp + 0xa], 0x28
4D3B  7D 07           jge 0x4d44
4D3D  C7 46 FE 04 00  mov word ptr [bp - 2], 4
4D42  EB 2E           jmp 0x4d72
loc_4D44:
4D44  83 7E 0A 50     cmp word ptr [bp + 0xa], 0x50
4D48  7D 07           jge 0x4d51
4D4A  C7 46 FE 05 00  mov word ptr [bp - 2], 5
4D4F  EB 21           jmp 0x4d72
loc_4D51:
4D51  81 7E 0A 96 00  cmp word ptr [bp + 0xa], 0x96
4D56  7D 07           jge 0x4d5f
4D58  C7 46 FE 06 00  mov word ptr [bp - 2], 6
4D5D  EB 13           jmp 0x4d72
loc_4D5F:
4D5F  81 7E 0A 2C 01  cmp word ptr [bp + 0xa], 0x12c
4D64  7D 07           jge 0x4d6d
4D66  C7 46 FE 07 00  mov word ptr [bp - 2], 7
4D6B  EB 05           jmp 0x4d72
loc_4D6D:
4D6D  C7 46 FE 08 00  mov word ptr [bp - 2], 8
loc_4D72:
4D72  6A 06           push 6
4D74  8B 7E FE        mov di, word ptr [bp - 2]
4D77  8A 85 87 12     mov al, byte ptr [di + 0x1287]
4D7B  30 E4           xor ah, ah
4D7D  8B F8           mov di, ax
4D7F  C1 E7 04        shl di, 4
4D82  81 C7 0C 8A     add di, 0x8a0c
4D86  1E              push ds
4D87  57              push di
4D88  8A 46 08        mov al, byte ptr [bp + 8]
4D8B  50              push ax
4D8C  8A 46 06        mov al, byte ptr [bp + 6]
4D8F  50              push ax
4D90  BF 5C DD        mov di, 0xdd5c
4D93  1E              push ds
4D94  57              push di
4D95  9A 1B 04 2A 23  call far 232A:041B
4D9A  8B 46 06        mov ax, word ptr [bp + 6]
4D9D  D1 E0           shl ax, 1
4D9F  8B D0           mov dx, ax
4DA1  69 46 08 A0 00  imul ax, word ptr [bp + 8], 0xa0
4DA6  C4 3E 5C DD     les di, ptr [0xdd5c]
4DAA  03 F8           add di, ax
4DAC  03 FA           add di, dx
4DAE  81 C7 5E FF     add di, 0xff5e
4DB2  06              push es
4DB3  57              push di
4DB4  6A 70           push 0x70
4DB6  FF 76 FE        push word ptr [bp - 2]
4DB9  9A 4B 03 BC 24  call far 24BC:034B
4DBE  C9              leave
4DBF  CA 06 00        retf 6

; ---- routine 1B55:4DC2  (found by: far)
sub_4DC2:
4DC2  C8 06 00 00     enter 6, 0
4DC6  8B 46 06        mov ax, word ptr [bp + 6]
4DC9  C1 E0 03        shl ax, 3
4DCC  C4 3E BA D7     les di, ptr [0xd7ba]
4DD0  03 F8           add di, ax
4DD2  89 7E FA        mov word ptr [bp - 6], di
4DD5  8C 46 FC        mov word ptr [bp - 4], es
4DD8  8B 46 06        mov ax, word ptr [bp + 6]
4DDB  C4 3E A2 D7     les di, ptr [0xd7a2]
4DDF  03 F8           add di, ax
4DE1  26 8A 05        mov al, byte ptr es:[di]
4DE4  30 E4           xor ah, ah
4DE6  99              cdq
4DE7  B9 06 00        mov cx, 6
4DEA  F7 F9           idiv cx
4DEC  92              xchg dx, ax
4DED  8B D0           mov dx, ax
4DEF  C4 7E FA        les di, ptr [bp - 6]
4DF2  26 8A 45 07     mov al, byte ptr es:[di + 7]
4DF6  30 E4           xor ah, ah
4DF8  8B F8           mov di, ax
4DFA  8A 85 90 12     mov al, byte ptr [di + 0x1290]
4DFE  30 E4           xor ah, ah
4E00  03 C2           add ax, dx
4E02  89 46 FE        mov word ptr [bp - 2], ax
4E05  8B 46 FE        mov ax, word ptr [bp - 2]
4E08  C9              leave
4E09  CA 02 00        retf 2

; ---- routine 1B55:4E0C  (found by: call, far)
sub_4E0C:
4E0C  C8 08 00 00     enter 8, 0
4E10  8B 46 06        mov ax, word ptr [bp + 6]
4E13  C1 E0 03        shl ax, 3
4E16  C4 3E BA D7     les di, ptr [0xd7ba]
4E1A  03 F8           add di, ax
4E1C  89 7E F8        mov word ptr [bp - 8], di
4E1F  8C 46 FA        mov word ptr [bp - 6], es
4E22  26 80 7D 01 12  cmp byte ptr es:[di + 1], 0x12
4E27  73 34           jae 0x4e5d
4E29  26 8A 45 05     mov al, byte ptr es:[di + 5]
4E2D  30 E4           xor ah, ah
4E2F  48              dec ax
4E30  89 46 FC        mov word ptr [bp - 4], ax
4E33  26 8A 45 01     mov al, byte ptr es:[di + 1]
4E37  30 E4           xor ah, ah
4E39  8B D0           mov dx, ax
4E3B  B8 12 00        mov ax, 0x12
4E3E  2B C2           sub ax, dx
4E40  8B F0           mov si, ax
4E42  D1 E0           shl ax, 1
4E44  01 F0           add ax, si
4E46  29 46 FC        sub word ptr [bp - 4], ax
4E49  8B 46 FC        mov ax, word ptr [bp - 4]
4E4C  99              cdq
4E4D  52              push dx
4E4E  50              push ax
4E4F  6A 00           push 0
4E51  6A 00           push 0
4E53  9A C0 04 BC 24  call far 24BC:04C0
4E58  88 46 FF        mov byte ptr [bp - 1], al
4E5B  EB 1D           jmp 0x4e7a
loc_4E5D:
4E5D  C4 7E F8        les di, ptr [bp - 8]
4E60  26 8A 45 03     mov al, byte ptr es:[di + 3]
4E64  D0 E8           shr al, 1
4E66  B0 00           mov al, 0
4E68  73 01           jae 0x4e6b
4E6A  40              inc ax
loc_4E6B:
4E6B  30 E4           xor ah, ah
4E6D  8B D0           mov dx, ax
4E6F  26 8A 45 05     mov al, byte ptr es:[di + 5]
4E73  30 E4           xor ah, ah
4E75  2B C2           sub ax, dx
4E77  88 46 FF        mov byte ptr [bp - 1], al
loc_4E7A:
4E7A  8A 46 FF        mov al, byte ptr [bp - 1]
4E7D  C9              leave
4E7E  CA 02 00        retf 2

; ---- routine 1B55:4E81  (found by: call, far)
sub_4E81:
4E81  C8 06 00 00     enter 6, 0
4E85  8B 46 06        mov ax, word ptr [bp + 6]
4E88  C1 E0 03        shl ax, 3
4E8B  C4 3E BA D7     les di, ptr [0xd7ba]
4E8F  03 F8           add di, ax
4E91  26 8A 45 07     mov al, byte ptr es:[di + 7]
4E95  30 E4           xor ah, ah
4E97  8B D8           mov bx, ax
4E99  8B 46 06        mov ax, word ptr [bp + 6]
4E9C  31 D2           xor dx, dx
4E9E  B9 03 00        mov cx, 3
4EA1  F7 F1           div cx
4EA3  92              xchg dx, ax
4EA4  8B F8           mov di, ax
4EA6  8A 85 BA 12     mov al, byte ptr [di + 0x12ba]
4EAA  30 E4           xor ah, ah
4EAC  6B F8 0E        imul di, ax, 0xe
4EAF  03 FB           add di, bx
4EB1  8A 85 9E 12     mov al, byte ptr [di + 0x129e]
4EB5  88 46 FF        mov byte ptr [bp - 1], al
4EB8  8A 46 FF        mov al, byte ptr [bp - 1]
4EBB  C9              leave
4EBC  CA 02 00        retf 2

; ---- routine 1B55:4EBF  (found by: far)
sub_4EBF:
4EBF  C8 08 00 00     enter 8, 0
4EC3  8B 46 06        mov ax, word ptr [bp + 6]
4EC6  C1 E0 03        shl ax, 3
4EC9  C4 3E BA D7     les di, ptr [0xd7ba]
4ECD  03 F8           add di, ax
4ECF  26 8A 45 05     mov al, byte ptr es:[di + 5]
4ED3  30 E4           xor ah, ah
4ED5  8B D0           mov dx, ax
4ED7  26 8A 45 03     mov al, byte ptr es:[di + 3]
4EDB  30 E4           xor ah, ah
4EDD  2B C2           sub ax, dx
4EDF  99              cdq
4EE0  B9 08 00        mov cx, 8
4EE3  F7 F9           idiv cx
4EE5  92              xchg dx, ax
4EE6  89 46 FC        mov word ptr [bp - 4], ax
4EE9  26 80 7D 01 15  cmp byte ptr es:[di + 1], 0x15
4EEE  73 08           jae 0x4ef8
4EF0  8B 46 FC        mov ax, word ptr [bp - 4]
4EF3  D1 E8           shr ax, 1
4EF5  89 46 FC        mov word ptr [bp - 4], ax
loc_4EF8:
4EF8  8B 46 FC        mov ax, word ptr [bp - 4]
4EFB  89 46 FE        mov word ptr [bp - 2], ax
4EFE  8B 46 FE        mov ax, word ptr [bp - 2]
4F01  C9              leave
4F02  CA 02 00        retf 2

; ---- routine 1B55:4F05  (found by: call, far)
sub_4F05:
4F05  C8 06 00 00     enter 6, 0
4F09  8B 46 06        mov ax, word ptr [bp + 6]
4F0C  C1 E0 03        shl ax, 3
4F0F  C4 3E BA D7     les di, ptr [0xd7ba]
4F13  03 F8           add di, ax
4F15  89 7E FA        mov word ptr [bp - 6], di
4F18  8C 46 FC        mov word ptr [bp - 4], es
4F1B  FF 76 06        push word ptr [bp + 6]
4F1E  0E              push cs
4F1F  E8 5F FF        call 0x4e81
4F22  08 C0           or al, al
4F24  74 13           je 0x4f39
4F26  C4 7E FA        les di, ptr [bp - 6]
4F29  26 8A 45 06     mov al, byte ptr es:[di + 6]
4F2D  3C 03           cmp al, 3
4F2F  74 4C           je 0x4f7d
4F31  3C 07           cmp al, 7
4F33  74 48           je 0x4f7d
4F35  3C 0A           cmp al, 0xa
4F37  74 44           je 0x4f7d
loc_4F39:
4F39  FF 76 06        push word ptr [bp + 6]
4F3C  0E              push cs
4F3D  E8 41 FF        call 0x4e81
4F40  08 C0           or al, al
4F42  75 13           jne 0x4f57
4F44  C4 7E FA        les di, ptr [bp - 6]
4F47  26 8A 45 06     mov al, byte ptr es:[di + 6]
4F4B  3C 04           cmp al, 4
4F4D  74 2E           je 0x4f7d
4F4F  3C 08           cmp al, 8
4F51  74 2A           je 0x4f7d
4F53  3C 0B           cmp al, 0xb
4F55  74 26           je 0x4f7d
loc_4F57:
4F57  C4 7E FA        les di, ptr [bp - 6]
4F5A  26 80 7D 06 00  cmp byte ptr es:[di + 6], 0
4F5F  75 07           jne 0x4f68
4F61  26 80 7D 07 00  cmp byte ptr es:[di + 7], 0
4F66  75 15           jne 0x4f7d
loc_4F68:
4F68  C4 7E FA        les di, ptr [bp - 6]
4F6B  26 80 7D 07 00  cmp byte ptr es:[di + 7], 0
4F70  75 07           jne 0x4f79
4F72  26 80 7D 06 00  cmp byte ptr es:[di + 6], 0
4F77  75 04           jne 0x4f7d
loc_4F79:
4F79  B0 00           mov al, 0
4F7B  EB 02           jmp 0x4f7f
loc_4F7D:
4F7D  B0 01           mov al, 1
loc_4F7F:
4F7F  88 46 FF        mov byte ptr [bp - 1], al
4F82  8A 46 FF        mov al, byte ptr [bp - 1]
4F85  C9              leave
4F86  CA 02 00        retf 2

; ---- routine 1B55:4F89  (found by: call, far)
sub_4F89:
4F89  C8 06 00 00     enter 6, 0
4F8D  6B 46 06 0F     imul ax, word ptr [bp + 6], 0xf
4F91  C4 3E BE D7     les di, ptr [0xd7be]
4F95  03 F8           add di, ax
4F97  89 7E FA        mov word ptr [bp - 6], di
4F9A  8C 46 FC        mov word ptr [bp - 4], es
4F9D  83 7E 06 00     cmp word ptr [bp + 6], 0
4FA1  74 5C           je 0x4fff
4FA3  26 80 7D 08 01  cmp byte ptr es:[di + 8], 1
4FA8  7C 55           jl 0x4fff
4FAA  6A 08           push 8
4FAC  26 8A 45 0B     mov al, byte ptr es:[di + 0xb]
4FB0  30 E4           xor ah, ah
4FB2  50              push ax
4FB3  9A 59 02 BC 24  call far 24BC:0259
4FB8  08 C0           or al, al
4FBA  75 43           jne 0x4fff
4FBC  6A 06           push 6
4FBE  C4 7E FA        les di, ptr [bp - 6]
4FC1  26 8A 45 0B     mov al, byte ptr es:[di + 0xb]
4FC5  30 E4           xor ah, ah
4FC7  50              push ax
4FC8  9A 59 02 BC 24  call far 24BC:0259
4FCD  08 C0           or al, al
4FCF  75 2E           jne 0x4fff
4FD1  6A 02           push 2
4FD3  C4 7E FA        les di, ptr [bp - 6]
4FD6  26 8A 45 0B     mov al, byte ptr es:[di + 0xb]
4FDA  30 E4           xor ah, ah
4FDC  50              push ax
4FDD  9A 59 02 BC 24  call far 24BC:0259
4FE2  08 C0           or al, al
4FE4  75 19           jne 0x4fff
4FE6  6A 03           push 3
4FE8  C4 7E FA        les di, ptr [bp - 6]
4FEB  26 8A 45 0B     mov al, byte ptr es:[di + 0xb]
4FEF  30 E4           xor ah, ah
4FF1  50              push ax
4FF2  9A 59 02 BC 24  call far 24BC:0259
4FF7  08 C0           or al, al
4FF9  75 04           jne 0x4fff
4FFB  B0 00           mov al, 0
4FFD  EB 02           jmp 0x5001
loc_4FFF:
4FFF  B0 01           mov al, 1
loc_5001:
5001  88 46 FF        mov byte ptr [bp - 1], al
5004  8A 46 FF        mov al, byte ptr [bp - 1]
5007  C9              leave
5008  CA 02 00        retf 2

; ---- routine 1B55:500B  (found by: far)
sub_500B:
500B  C8 0C 01 00     enter 0x10c, 0
500F  31 C0           xor ax, ax
5011  89 46 FC        mov word ptr [bp - 4], ax
5014  31 C0           xor ax, ax
5016  89 46 F8        mov word ptr [bp - 8], ax
5019  8D BE F4 FE     lea di, [bp - 0x10c]
501D  16              push ss
501E  57              push di
501F  8A 46 06        mov al, byte ptr [bp + 6]
5022  50              push ax
5023  9A 6F 0C C9 26  call far 26C9:0C6F
5028  BF 9A 0D        mov di, 0xd9a
502B  1E              push ds
502C  57              push di
502D  9A FE 0B C9 26  call far 26C9:0BFE
5032  89 46 F4        mov word ptr [bp - 0xc], ax
5035  8B 46 08        mov ax, word ptr [bp + 8]
5038  89 46 F2        mov word ptr [bp - 0xe], ax
503B  B8 0C 00        mov ax, 0xc
503E  3B 46 F2        cmp ax, word ptr [bp - 0xe]
5041  76 03           jbe 0x5046
5043  E9 98 00        jmp 0x50de
loc_5046:
5046  89 46 FA        mov word ptr [bp - 6], ax
5049  EB 03           jmp 0x504e
loc_504B:
504B  FF 46 FA        inc word ptr [bp - 6]
loc_504E:
504E  8B 46 FA        mov ax, word ptr [bp - 6]
5051  D1 E0           shl ax, 1
5053  C4 7E 0A        les di, ptr [bp + 0xa]
5056  03 F8           add di, ax
5058  26 FF 75 FE     push word ptr es:[di - 2]
505C  0E              push cs
505D  E8 29 FF        call 0x4f89
5060  08 C0           or al, al
5062  75 6F           jne 0x50d3
5064  8B 46 FA        mov ax, word ptr [bp - 6]
5067  D1 E0           shl ax, 1
5069  C4 7E 0A        les di, ptr [bp + 0xa]
506C  03 F8           add di, ax
506E  26 8B 45 FE     mov ax, word ptr es:[di - 2]
5072  C1 E0 03        shl ax, 3
5075  C4 3E BA D7     les di, ptr [0xd7ba]
5079  03 F8           add di, ax
507B  26 8A 45 07     mov al, byte ptr es:[di + 7]
507F  30 E4           xor ah, ah
5081  6B 7E 06 0E     imul di, word ptr [bp + 6], 0xe
5085  03 F8           add di, ax
5087  8A 85 A6 0D     mov al, byte ptr [di + 0xda6]
508B  30 E4           xor ah, ah
508D  89 46 F6        mov word ptr [bp - 0xa], ax
5090  83 7E F4 00     cmp word ptr [bp - 0xc], 0
5094  76 29           jbe 0x50bf
5096  8B 46 FA        mov ax, word ptr [bp - 6]
5099  D1 E0           shl ax, 1
509B  C4 7E 0A        les di, ptr [bp + 0xa]
509E  03 F8           add di, ax
50A0  26 FF 75 FE     push word ptr es:[di - 2]
50A4  0E              push cs
50A5  E8 D9 FD        call 0x4e81
50A8  8A D0           mov dl, al
50AA  83 7E F4 03     cmp word ptr [bp - 0xc], 3
50AE  B0 00           mov al, 0
50B0  76 01           jbe 0x50b3
50B2  40              inc ax
loc_50B3:
50B3  3A C2           cmp al, dl
50B5  74 08           je 0x50bf
50B7  8B 46 F6        mov ax, word ptr [bp - 0xa]
50BA  D1 E8           shr ax, 1
50BC  89 46 F6        mov word ptr [bp - 0xa], ax
loc_50BF:
50BF  8B 46 F6        mov ax, word ptr [bp - 0xa]
50C2  3B 46 F8        cmp ax, word ptr [bp - 8]
50C5  76 0C           jbe 0x50d3
50C7  8B 46 FA        mov ax, word ptr [bp - 6]
50CA  89 46 FC        mov word ptr [bp - 4], ax
50CD  8B 46 F6        mov ax, word ptr [bp - 0xa]
50D0  89 46 F8        mov word ptr [bp - 8], ax
loc_50D3:
50D3  8B 46 FA        mov ax, word ptr [bp - 6]
50D6  3B 46 F2        cmp ax, word ptr [bp - 0xe]
50D9  74 03           je 0x50de
50DB  E9 6D FF        jmp 0x504b
loc_50DE:
50DE  8B 46 FC        mov ax, word ptr [bp - 4]
50E1  89 46 FE        mov word ptr [bp - 2], ax
50E4  8B 46 FE        mov ax, word ptr [bp - 2]
50E7  C9              leave
50E8  CA 08 00        retf 8

; ---- routine 1B55:50EB  (found by: call, far)
sub_50EB:
50EB  C8 0E 00 00     enter 0xe, 0
50EF  6B 46 0A 3E     imul ax, word ptr [bp + 0xa], 0x3e
50F3  C4 3E C2 D7     les di, ptr [0xd7c2]
50F7  03 F8           add di, ax
50F9  81 C7 C2 FF     add di, 0xffc2
50FD  89 7E F6        mov word ptr [bp - 0xa], di
5100  8C 46 F8        mov word ptr [bp - 8], es
5103  FF 76 0A        push word ptr [bp + 0xa]
5106  0E              push cs
5107  E8 2D F9        call 0x4a37
510A  89 46 FC        mov word ptr [bp - 4], ax
510D  31 C0           xor ax, ax
510F  89 46 FE        mov word ptr [bp - 2], ax
5112  EB 03           jmp 0x5117
loc_5114:
5114  FF 46 FE        inc word ptr [bp - 2]
loc_5117:
5117  8B 46 08        mov ax, word ptr [bp + 8]
511A  D1 E0           shl ax, 1
511C  8B 7E FE        mov di, word ptr [bp - 2]
511F  C1 E7 02        shl di, 2
5122  03 F8           add di, ax
5124  31 C0           xor ax, ax
5126  89 85 74 D6     mov word ptr [di - 0x298c], ax
512A  83 7E FE 03     cmp word ptr [bp - 2], 3
512E  75 E4           jne 0x5114
5130  C7 46 FE 01 00  mov word ptr [bp - 2], 1
5135  EB 03           jmp 0x513a
loc_5137:
5137  FF 46 FE        inc word ptr [bp - 2]
loc_513A:
513A  8B 46 FE        mov ax, word ptr [bp - 2]
513D  D1 E0           shl ax, 1
513F  C4 7E F6        les di, ptr [bp - 0xa]
5142  03 F8           add di, ax
5144  26 83 7D FE 00  cmp word ptr es:[di - 2], 0
5149  75 03           jne 0x514e
514B  E9 D3 00        jmp 0x5221
loc_514E:
514E  8B 46 FE        mov ax, word ptr [bp - 2]
5151  D1 E0           shl ax, 1
5153  C4 7E F6        les di, ptr [bp - 0xa]
5156  03 F8           add di, ax
5158  26 8B 45 FE     mov ax, word ptr es:[di - 2]
515C  C1 E0 03        shl ax, 3
515F  C4 3E BA D7     les di, ptr [0xd7ba]
5163  03 F8           add di, ax
5165  89 7E F2        mov word ptr [bp - 0xe], di
5168  8C 46 F4        mov word ptr [bp - 0xc], es
516B  8B 46 FE        mov ax, word ptr [bp - 2]
516E  D1 E0           shl ax, 1
5170  C4 7E F6        les di, ptr [bp - 0xa]
5173  03 F8           add di, ax
5175  26 FF 75 FE     push word ptr es:[di - 2]
5179  6A 00           push 0
517B  0E              push cs
517C  E8 CB F9        call 0x4b4a
517F  89 46 FA        mov word ptr [bp - 6], ax
5182  83 7E FA 00     cmp word ptr [bp - 6], 0
5186  74 06           je 0x518e
5188  8B 46 FC        mov ax, word ptr [bp - 4]
518B  01 46 FA        add word ptr [bp - 6], ax
loc_518E:
518E  C4 7E F2        les di, ptr [bp - 0xe]
5191  26 8A 45 06     mov al, byte ptr es:[di + 6]
5195  30 E4           xor ah, ah
5197  8B F8           mov di, ax
5199  80 BD BE 12 04  cmp byte ptr [di + 0x12be], 4
519E  73 28           jae 0x51c8
51A0  8B 4E FA        mov cx, word ptr [bp - 6]
51A3  8B 46 08        mov ax, word ptr [bp + 8]
51A6  D1 E0           shl ax, 1
51A8  8B D0           mov dx, ax
51AA  C4 7E F2        les di, ptr [bp - 0xe]
51AD  26 8A 45 06     mov al, byte ptr es:[di + 6]
51B1  30 E4           xor ah, ah
51B3  8B F8           mov di, ax
51B5  8A 85 BE 12     mov al, byte ptr [di + 0x12be]
51B9  30 E4           xor ah, ah
51BB  8B F8           mov di, ax
51BD  C1 E7 02        shl di, 2
51C0  03 FA           add di, dx
51C2  01 8D 74 D6     add word ptr [di - 0x298c], cx
51C6  EB 59           jmp 0x5221
loc_51C8:
51C8  8B 46 FA        mov ax, word ptr [bp - 6]
51CB  D1 E8           shr ax, 1
51CD  89 46 FA        mov word ptr [bp - 6], ax
51D0  8B 4E FA        mov cx, word ptr [bp - 6]
51D3  8B 46 08        mov ax, word ptr [bp + 8]
51D6  D1 E0           shl ax, 1
51D8  8B D0           mov dx, ax
51DA  C4 7E F2        les di, ptr [bp - 0xe]
51DD  26 8A 45 06     mov al, byte ptr es:[di + 6]
51E1  30 E4           xor ah, ah
51E3  8B F8           mov di, ax
51E5  8A 85 BE 12     mov al, byte ptr [di + 0x12be]
51E9  30 E4           xor ah, ah
51EB  2D 03 00        sub ax, 3
51EE  8B F8           mov di, ax
51F0  C1 E7 02        shl di, 2
51F3  03 FA           add di, dx
51F5  01 8D 74 D6     add word ptr [di - 0x298c], cx
51F9  8B 4E FA        mov cx, word ptr [bp - 6]
51FC  8B 46 08        mov ax, word ptr [bp + 8]
51FF  D1 E0           shl ax, 1
5201  8B D0           mov dx, ax
5203  C4 7E F2        les di, ptr [bp - 0xe]
5206  26 8A 45 06     mov al, byte ptr es:[di + 6]
520A  30 E4           xor ah, ah
520C  8B F8           mov di, ax
520E  8A 85 BE 12     mov al, byte ptr [di + 0x12be]
5212  30 E4           xor ah, ah
5214  48              dec ax
5215  48              dec ax
5216  8B F8           mov di, ax
5218  C1 E7 02        shl di, 2
521B  03 FA           add di, dx
521D  01 8D 74 D6     add word ptr [di - 0x298c], cx
loc_5221:
5221  83 7E FE 0B     cmp word ptr [bp - 2], 0xb
5225  74 03           je 0x522a
5227  E9 0D FF        jmp 0x5137
loc_522A:
522A  80 7E 06 00     cmp byte ptr [bp + 6], 0
522E  74 50           je 0x5280
5230  31 C0           xor ax, ax
5232  89 46 FE        mov word ptr [bp - 2], ax
5235  EB 03           jmp 0x523a
loc_5237:
5237  FF 46 FE        inc word ptr [bp - 2]
loc_523A:
523A  C4 7E F6        les di, ptr [bp - 0xa]
523D  26 80 7D 37 00  cmp byte ptr es:[di + 0x37], 0
5242  B0 00           mov al, 0
5244  75 01           jne 0x5247
5246  40              inc ax
loc_5247:
5247  98              cwde
5248  8B F8           mov di, ax
524A  8A 85 CC 12     mov al, byte ptr [di + 0x12cc]
524E  30 E4           xor ah, ah
5250  8B C8           mov cx, ax
5252  8B 46 08        mov ax, word ptr [bp + 8]
5255  D1 E0           shl ax, 1
5257  8B 7E FE        mov di, word ptr [bp - 2]
525A  C1 E7 02        shl di, 2
525D  03 F8           add di, ax
525F  8B 85 74 D6     mov ax, word ptr [di - 0x298c]
5263  31 D2           xor dx, dx
5265  F7 F1           div cx
5267  8B D0           mov dx, ax
5269  8B 46 08        mov ax, word ptr [bp + 8]
526C  D1 E0           shl ax, 1
526E  8B 7E FE        mov di, word ptr [bp - 2]
5271  C1 E7 02        shl di, 2
5274  03 F8           add di, ax
5276  01 95 74 D6     add word ptr [di - 0x298c], dx
527A  83 7E FE 03     cmp word ptr [bp - 2], 3
527E  75 B7           jne 0x5237
loc_5280:
5280  C9              leave
5281  CA 06 00        retf 6

; ---- routine 1B55:5284  (found by: call, far)
sub_5284:
5284  C8 08 00 00     enter 8, 0
5288  8B 46 06        mov ax, word ptr [bp + 6]
528B  C1 E0 03        shl ax, 3
528E  C4 3E BA D7     les di, ptr [0xd7ba]
5292  03 F8           add di, ax
5294  89 7E F8        mov word ptr [bp - 8], di
5297  8C 46 FA        mov word ptr [bp - 6], es
529A  26 8A 45 01     mov al, byte ptr es:[di + 1]
529E  26 3A 45 02     cmp al, byte ptr es:[di + 2]
52A2  72 20           jb 0x52c4
52A4  26 8A 45 02     mov al, byte ptr es:[di + 2]
52A8  30 E4           xor ah, ah
52AA  05 03 00        add ax, 3
52AD  8B D0           mov dx, ax
52AF  26 8A 45 01     mov al, byte ptr es:[di + 1]
52B3  30 E4           xor ah, ah
52B5  3B C2           cmp ax, dx
52B7  7F 0B           jg 0x52c4
52B9  26 8A 45 03     mov al, byte ptr es:[di + 3]
52BD  26 88 45 04     mov byte ptr es:[di + 4], al
52C1  E9 93 00        jmp 0x5357
loc_52C4:
52C4  C4 7E F8        les di, ptr [bp - 8]
52C7  26 8A 45 03     mov al, byte ptr es:[di + 3]
52CB  30 E4           xor ah, ah
52CD  89 46 FC        mov word ptr [bp - 4], ax
52D0  26 8A 45 02     mov al, byte ptr es:[di + 2]
52D4  30 E4           xor ah, ah
52D6  05 03 00        add ax, 3
52D9  8B D0           mov dx, ax
52DB  26 8A 45 01     mov al, byte ptr es:[di + 1]
52DF  30 E4           xor ah, ah
52E1  3B C2           cmp ax, dx
52E3  7E 31           jle 0x5316
52E5  6A 00           push 0
52E7  6A 0F           push 0xf
52E9  26 8A 45 02     mov al, byte ptr es:[di + 2]
52ED  30 E4           xor ah, ah
52EF  05 03 00        add ax, 3
52F2  8B D0           mov dx, ax
52F4  26 8A 45 01     mov al, byte ptr es:[di + 1]
52F8  30 E4           xor ah, ah
52FA  2B C2           sub ax, dx
52FC  99              cdq
52FD  52              push dx
52FE  50              push ax
52FF  9A FA 04 BC 24  call far 24BC:04FA
5304  8B C8           mov cx, ax
5306  8B DA           mov bx, dx
5308  B8 10 00        mov ax, 0x10
530B  31 D2           xor dx, dx
530D  2B C1           sub ax, cx
530F  1B D3           sbb dx, bx
5311  89 46 FE        mov word ptr [bp - 2], ax
5314  EB 31           jmp 0x5347
loc_5316:
5316  6A 00           push 0
5318  6A 0F           push 0xf
531A  C4 7E F8        les di, ptr [bp - 8]
531D  26 8A 45 01     mov al, byte ptr es:[di + 1]
5321  30 E4           xor ah, ah
5323  8B D0           mov dx, ax
5325  26 8A 45 02     mov al, byte ptr es:[di + 2]
5329  30 E4           xor ah, ah
532B  2B C2           sub ax, dx
532D  D1 E8           shr ax, 1
532F  99              cdq
5330  52              push dx
5331  50              push ax
5332  9A FA 04 BC 24  call far 24BC:04FA
5337  8B C8           mov cx, ax
5339  8B DA           mov bx, dx
533B  B8 10 00        mov ax, 0x10
533E  31 D2           xor dx, dx
5340  2B C1           sub ax, cx
5342  1B D3           sbb dx, bx
5344  89 46 FE        mov word ptr [bp - 2], ax
loc_5347:
5347  8B 46 FC        mov ax, word ptr [bp - 4]
534A  F7 66 FE        mul word ptr [bp - 2]
534D  C1 E8 04        shr ax, 4
5350  C4 7E F8        les di, ptr [bp - 8]
5353  26 88 45 04     mov byte ptr es:[di + 4], al
loc_5357:
5357  C9              leave
5358  CA 02 00        retf 2

; ---- routine 1B55:535B  (found by: call)
sub_535B:
535B  C8 04 00 00     enter 4, 0
535F  8B 46 06        mov ax, word ptr [bp + 6]
5362  C1 E0 03        shl ax, 3
5365  C4 3E BA D7     les di, ptr [0xd7ba]
5369  03 F8           add di, ax
536B  89 7E FC        mov word ptr [bp - 4], di
536E  8C 46 FE        mov word ptr [bp - 2], es
5371  6A 03           push 3
5373  9A 6D 07 2A 23  call far 232A:076D
5378  50              push ax
5379  6A 03           push 3
537B  9A 6D 07 2A 23  call far 232A:076D
5380  8B D0           mov dx, ax
5382  C4 7E FC        les di, ptr [bp - 4]
5385  26 80 7D 07 00  cmp byte ptr es:[di + 7], 0
538A  B0 00           mov al, 0
538C  75 01           jne 0x538f
538E  40              inc ax
loc_538F:
538F  98              cwde
5390  8B F8           mov di, ax
5392  8A 85 CE 12     mov al, byte ptr [di + 0x12ce]
5396  30 E4           xor ah, ah
5398  03 C2           add ax, dx
539A  5A              pop dx
539B  2B C2           sub ax, dx
539D  C4 7E FC        les di, ptr [bp - 4]
53A0  26 88 45 02     mov byte ptr es:[di + 2], al
loc_53A4:
53A4  C4 7E FC        les di, ptr [bp - 4]
53A7  26 8A 45 01     mov al, byte ptr es:[di + 1]
53AB  30 E4           xor ah, ah
53AD  8B D0           mov dx, ax
53AF  26 8A 45 02     mov al, byte ptr es:[di + 2]
53B3  30 E4           xor ah, ah
53B5  05 06 00        add ax, 6
53B8  3B C2           cmp ax, dx
53BA  7D 06           jge 0x53c2
53BC  26 FE 45 02     inc byte ptr es:[di + 2]
53C0  EB E2           jmp 0x53a4
loc_53C2:
53C2  C9              leave
53C3  CA 02 00        retf 2

; ---- routine 1B55:53C6  (found by: call, far)
sub_53C6:
53C6  C8 04 00 00     enter 4, 0
53CA  6B 46 06 0F     imul ax, word ptr [bp + 6], 0xf
53CE  C4 3E BE D7     les di, ptr [0xd7be]
53D2  03 F8           add di, ax
53D4  89 7E FC        mov word ptr [bp - 4], di
53D7  8C 46 FE        mov word ptr [bp - 2], es
53DA  6A 08           push 8
53DC  81 C7 0A 00     add di, 0xa
53E0  06              push es
53E1  57              push di
53E2  9A D5 00 2A 23  call far 232A:00D5
53E7  6A 04           push 4
53E9  C4 7E FC        les di, ptr [bp - 4]
53EC  81 C7 0A 00     add di, 0xa
53F0  06              push es
53F1  57              push di
53F2  9A F8 00 2A 23  call far 232A:00F8
53F7  C9              leave
53F8  CA 02 00        retf 2

; ---- routine 1B55:53FB  (found by: call, far)
sub_53FB:
53FB  C8 08 00 00     enter 8, 0
53FF  6B 46 06 0F     imul ax, word ptr [bp + 6], 0xf
5403  C4 3E BE D7     les di, ptr [0xd7be]
5407  03 F8           add di, ax
5409  89 7E FC        mov word ptr [bp - 4], di
540C  8C 46 FE        mov word ptr [bp - 2], es
540F  8B 46 06        mov ax, word ptr [bp + 6]
5412  C1 E0 03        shl ax, 3
5415  C4 3E BA D7     les di, ptr [0xd7ba]
5419  03 F8           add di, ax
541B  89 7E F8        mov word ptr [bp - 8], di
541E  8C 46 FA        mov word ptr [bp - 6], es
5421  FF 76 06        push word ptr [bp + 6]
5424  0E              push cs
5425  E8 E4 F9        call 0x4e0c
5428  3C 04           cmp al, 4
542A  73 07           jae 0x5433
542C  FF 76 06        push word ptr [bp + 6]
542F  0E              push cs
5430  E8 93 FF        call 0x53c6
loc_5433:
5433  C4 7E F8        les di, ptr [bp - 8]
5436  26 8A 45 06     mov al, byte ptr es:[di + 6]
543A  3C 01           cmp al, 1
543C  76 08           jbe 0x5446
543E  3C 03           cmp al, 3
5440  72 26           jb 0x5468
5442  3C 04           cmp al, 4
5444  77 22           ja 0x5468
loc_5446:
5446  6A 05           push 5
5448  C4 7E FC        les di, ptr [bp - 4]
544B  81 C7 0A 00     add di, 0xa
544F  06              push es
5450  57              push di
5451  9A D5 00 2A 23  call far 232A:00D5
5456  6A 01           push 1
5458  C4 7E FC        les di, ptr [bp - 4]
545B  81 C7 0A 00     add di, 0xa
545F  06              push es
5460  57              push di
5461  9A D5 00 2A 23  call far 232A:00D5
5466  EB 3A           jmp 0x54a2
loc_5468:
5468  C4 7E F8        les di, ptr [bp - 8]
546B  26 80 7D 06 02  cmp byte ptr es:[di + 6], 2
5470  75 30           jne 0x54a2
5472  6A 05           push 5
5474  C4 7E FC        les di, ptr [bp - 4]
5477  81 C7 0A 00     add di, 0xa
547B  06              push es
547C  57              push di
547D  9A D5 00 2A 23  call far 232A:00D5
5482  6A 06           push 6
5484  C4 7E FC        les di, ptr [bp - 4]
5487  81 C7 0A 00     add di, 0xa
548B  06              push es
548C  57              push di
548D  9A D5 00 2A 23  call far 232A:00D5
5492  6A 02           push 2
5494  C4 7E FC        les di, ptr [bp - 4]
5497  81 C7 0A 00     add di, 0xa
549B  06              push es
549C  57              push di
549D  9A D5 00 2A 23  call far 232A:00D5
loc_54A2:
54A2  C9              leave
54A3  CA 02 00        retf 2

; ---- routine 1B55:54A6  (found by: call, far)
sub_54A6:
54A6  C8 08 00 00     enter 8, 0
54AA  8B 46 06        mov ax, word ptr [bp + 6]
54AD  C1 E0 03        shl ax, 3
54B0  C4 3E BA D7     les di, ptr [0xd7ba]
54B4  03 F8           add di, ax
54B6  89 7E FC        mov word ptr [bp - 4], di
54B9  8C 46 FE        mov word ptr [bp - 2], es
54BC  6B 46 06 0F     imul ax, word ptr [bp + 6], 0xf
54C0  C4 3E BE D7     les di, ptr [0xd7be]
54C4  03 F8           add di, ax
54C6  89 7E F8        mov word ptr [bp - 8], di
54C9  8C 46 FA        mov word ptr [bp - 6], es
54CC  C4 7E FC        les di, ptr [bp - 4]
54CF  26 8A 45 02     mov al, byte ptr es:[di + 2]
54D3  30 E4           xor ah, ah
54D5  05 04 00        add ax, 4
54D8  8B D0           mov dx, ax
54DA  26 8A 45 01     mov al, byte ptr es:[di + 1]
54DE  30 E4           xor ah, ah
54E0  3B C2           cmp ax, dx
54E2  7E 10           jle 0x54f4
54E4  6A 19           push 0x19
54E6  9A 6D 07 2A 23  call far 232A:076D
54EB  C4 7E F8        les di, ptr [bp - 8]
54EE  26 88 45 07     mov byte ptr es:[di + 7], al
54F2  EB 0E           jmp 0x5502
loc_54F4:
54F4  6A 20           push 0x20
54F6  9A 6D 07 2A 23  call far 232A:076D
54FB  C4 7E F8        les di, ptr [bp - 8]
54FE  26 88 45 07     mov byte ptr es:[di + 7], al
loc_5502:
5502  C4 7E F8        les di, ptr [bp - 8]
5505  26 8A 45 07     mov al, byte ptr es:[di + 7]
5509  26 88 45 08     mov byte ptr es:[di + 8], al
550D  26 C6 45 0E 00  mov byte ptr es:[di + 0xe], 0
5512  C9              leave
5513  CA 02 00        retf 2

; ---- routine 1B55:5516  (found by: call)
sub_5516:
5516  C8 0E 00 00     enter 0xe, 0
551A  8B 46 04        mov ax, word ptr [bp + 4]
551D  C1 E0 03        shl ax, 3
5520  C4 3E BA D7     les di, ptr [0xd7ba]
5524  03 F8           add di, ax
5526  89 7E F8        mov word ptr [bp - 8], di
5529  8C 46 FA        mov word ptr [bp - 6], es
552C  6B 46 04 0F     imul ax, word ptr [bp + 4], 0xf
5530  C4 3E BE D7     les di, ptr [0xd7be]
5534  03 F8           add di, ax
5536  89 7E F4        mov word ptr [bp - 0xc], di
5539  8C 46 F6        mov word ptr [bp - 0xa], es
553C  8B 46 04        mov ax, word ptr [bp + 4]
553F  C4 3E 84 DE     les di, ptr [0xde84]
5543  26 89 05        mov word ptr es:[di], ax
5546  C4 7E F4        les di, ptr [bp - 0xc]
5549  31 C0           xor ax, ax
554B  26 89 05        mov word ptr es:[di], ax
554E  31 C0           xor ax, ax
5550  26 89 45 02     mov word ptr es:[di + 2], ax
5554  C4 7E F8        les di, ptr [bp - 8]
5557  26 8A 45 01     mov al, byte ptr es:[di + 1]
555B  30 E4           xor ah, ah
555D  89 46 F2        mov word ptr [bp - 0xe], ax
5560  B8 14 00        mov ax, 0x14
5563  3B 46 F2        cmp ax, word ptr [bp - 0xe]
5566  77 26           ja 0x558e
5568  89 46 FE        mov word ptr [bp - 2], ax
556B  EB 03           jmp 0x5570
loc_556D:
556D  FF 46 FE        inc word ptr [bp - 2]
loc_5570:
5570  9A 3F 0D BC 24  call far 24BC:0D3F
5575  08 C0           or al, al
5577  74 0D           je 0x5586
5579  6A 20           push 0x20
557B  9A 6D 07 2A 23  call far 232A:076D
5580  C4 7E F4        les di, ptr [bp - 0xc]
5583  26 01 05        add word ptr es:[di], ax
loc_5586:
5586  8B 46 FE        mov ax, word ptr [bp - 2]
5589  3B 46 F2        cmp ax, word ptr [bp - 0xe]
558C  75 DF           jne 0x556d
loc_558E:
558E  C4 7E F4        les di, ptr [bp - 0xc]
5591  26 83 3D 00     cmp word ptr es:[di], 0
5595  77 03           ja 0x559a
5597  E9 94 00        jmp 0x562e
loc_559A:
559A  C4 7E F8        les di, ptr [bp - 8]
559D  26 80 7D 07 00  cmp byte ptr es:[di + 7], 0
55A2  75 39           jne 0x55dd
55A4  C4 7E F4        les di, ptr [bp - 0xc]
55A7  26 8B 05        mov ax, word ptr es:[di]
55AA  D1 E8           shr ax, 1
55AC  50              push ax
55AD  9A 6D 07 2A 23  call far 232A:076D
55B2  99              cdq
55B3  52              push dx
55B4  50              push ax
55B5  C4 7E F4        les di, ptr [bp - 0xc]
55B8  26 FF 35        push word ptr es:[di]
55BB  9A 6D 07 2A 23  call far 232A:076D
55C0  99              cdq
55C1  8B C8           mov cx, ax
55C3  8B DA           mov bx, dx
55C5  C4 7E F4        les di, ptr [bp - 0xc]
55C8  26 8B 05        mov ax, word ptr es:[di]
55CB  31 D2           xor dx, dx
55CD  03 C1           add ax, cx
55CF  13 D3           adc dx, bx
55D1  59              pop cx
55D2  5B              pop bx
55D3  2B C1           sub ax, cx
55D5  1B D3           sbb dx, bx
55D7  26 89 45 02     mov word ptr es:[di + 2], ax
55DB  EB 51           jmp 0x562e
loc_55DD:
55DD  C4 7E F8        les di, ptr [bp - 8]
55E0  26 8A 45 07     mov al, byte ptr es:[di + 7]
55E4  30 E4           xor ah, ah
55E6  8B F8           mov di, ax
55E8  8A 85 CF 12     mov al, byte ptr [di + 0x12cf]
55EC  30 E4           xor ah, ah
55EE  8B C8           mov cx, ax
55F0  C4 7E F4        les di, ptr [bp - 0xc]
55F3  26 8B 05        mov ax, word ptr es:[di]
55F6  31 D2           xor dx, dx
55F8  F7 F1           div cx
55FA  89 46 FC        mov word ptr [bp - 4], ax
55FD  8B 46 FC        mov ax, word ptr [bp - 4]
5600  99              cdq
5601  B9 02 00        mov cx, 2
5604  F7 F9           idiv cx
5606  50              push ax
5607  9A 6D 07 2A 23  call far 232A:076D
560C  50              push ax
560D  FF 76 FC        push word ptr [bp - 4]
5610  9A 6D 07 2A 23  call far 232A:076D
5615  03 46 FC        add ax, word ptr [bp - 4]
5618  5A              pop dx
5619  2B C2           sub ax, dx
561B  89 46 FC        mov word ptr [bp - 4], ax
561E  83 7E FC 00     cmp word ptr [bp - 4], 0
5622  7E 0A           jle 0x562e
5624  8B 46 FC        mov ax, word ptr [bp - 4]
5627  C4 7E F4        les di, ptr [bp - 0xc]
562A  26 89 45 02     mov word ptr es:[di + 2], ax
loc_562E:
562E  C9              leave
562F  C2 02 00        ret 2
; data (not reached as code), 2 bytes
5632                  db 01 2E   ; ..

; ---- routine 1B55:5634  (found by: far)
sub_5634:
5634  C8 10 01 00     enter 0x110, 0
5638  8B 46 0A        mov ax, word ptr [bp + 0xa]
563B  0B 46 0C        or ax, word ptr [bp + 0xc]
563E  75 0A           jne 0x564a
5640  31 C0           xor ax, ax
5642  89 46 FC        mov word ptr [bp - 4], ax
5645  89 46 FE        mov word ptr [bp - 2], ax
5648  EB 2E           jmp 0x5678
loc_564A:
564A  FF 76 08        push word ptr [bp + 8]
564D  FF 76 06        push word ptr [bp + 6]
5650  6A 00           push 0
5652  6A 01           push 1
5654  9A C0 04 BC 24  call far 24BC:04C0
5659  52              push dx
565A  50              push ax
565B  8B 46 0A        mov ax, word ptr [bp + 0xa]
565E  8B 56 0C        mov dx, word ptr [bp + 0xc]
5661  B9 64 00        mov cx, 0x64
5664  31 DB           xor bx, bx
5666  9A 2A 0A C9 26  call far 26C9:0A2A
566B  59              pop cx
566C  5B              pop bx
566D  9A 67 0A C9 26  call far 26C9:0A67
5672  89 46 FC        mov word ptr [bp - 4], ax
5675  89 56 FE        mov word ptr [bp - 2], dx
loc_5678:
5678  8B 46 FC        mov ax, word ptr [bp - 4]
567B  8B 56 FE        mov dx, word ptr [bp - 2]
567E  B9 64 00        mov cx, 0x64
5681  31 DB           xor bx, bx
5683  9A 67 0A C9 26  call far 26C9:0A67
5688  89 C8           mov ax, cx
568A  89 DA           mov dx, bx
568C  52              push dx
568D  50              push ax
568E  6A 02           push 2
5690  8D 7E F0        lea di, [bp - 0x10]
5693  16              push ss
5694  57              push di
5695  6A 0A           push 0xa
5697  9A 0A 19 C9 26  call far 26C9:190A
569C  80 7E F1 20     cmp byte ptr [bp - 0xf], 0x20
56A0  75 04           jne 0x56a6
56A2  C6 46 F1 30     mov byte ptr [bp - 0xf], 0x30
loc_56A6:
56A6  8D BE F0 FE     lea di, [bp - 0x110]
56AA  16              push ss
56AB  57              push di
56AC  8B 46 FC        mov ax, word ptr [bp - 4]
56AF  8B 56 FE        mov dx, word ptr [bp - 2]
56B2  B9 64 00        mov cx, 0x64
56B5  31 DB           xor bx, bx
56B7  9A 67 0A C9 26  call far 26C9:0A67
56BC  52              push dx
56BD  50              push ax
56BE  9A C9 07 2A 23  call far 232A:07C9
56C3  BF 32 56        mov di, 0x5632
56C6  0E              push cs
56C7  57              push di
56C8  9A D2 0B C9 26  call far 26C9:0BD2
56CD  8D 7E F0        lea di, [bp - 0x10]
56D0  16              push ss
56D1  57              push di
56D2  9A D2 0B C9 26  call far 26C9:0BD2
56D7  C4 7E 0E        les di, ptr [bp + 0xe]
56DA  06              push es
56DB  57              push di
56DC  6A 0A           push 0xa
56DE  9A 6D 0B C9 26  call far 26C9:0B6D
56E3  C9              leave
56E4  CA 08 00        retf 8

