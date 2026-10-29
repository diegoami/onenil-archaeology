; 1-0.EXE (One-Nil 96), code segment 06E8 (image offsets 06E80..0AB8F), part 6 of 6
; packed 1-0.EXE sha256 89ff9c5f238f24e81a0c2440a46cdd8997280a65fc3cc3d97cb974f55280a80a (LZEXE 0.91)
; unpacked (tools/static/unlzexe.py) sha256 887ed2a92767950e5309b2052409f875668605939b69e00737aa3047022b9f51
; tool: capstone 5.0.9 (pip package; core library 5.0.1280) (CS_ARCH_X86, CS_MODE_16), recursive descent from the entry point, far calls and near calls/jumps, then routine prologues (55 89 E5 / 55 8B EC / C8 iw 00) in what remains; tools/static/listing.py
; addresses are SEGMENT:OFFSET with SEGMENT the image paragraph before relocation; image offset = SEGMENT*16+OFFSET
; ---- routine 06E8:3A1D  (found by: far)
sub_3A1D:
3A1D  C8 16 00 00     enter 0x16, 0
3A21  83 3E 86 D6 00  cmp word ptr [0xd686], 0
3A26  75 03           jne 0x3a2b
3A28  E9 33 01        jmp 0x3b5e
loc_3A2B:
3A2B  31 C0           xor ax, ax
3A2D  89 46 F2        mov word ptr [bp - 0xe], ax
3A30  A1 86 D6        mov ax, word ptr [0xd686]
3A33  89 46 EE        mov word ptr [bp - 0x12], ax
3A36  B8 01 00        mov ax, 1
3A39  3B 46 EE        cmp ax, word ptr [bp - 0x12]
3A3C  76 03           jbe 0x3a41
3A3E  E9 FC 00        jmp 0x3b3d
loc_3A41:
3A41  89 46 FC        mov word ptr [bp - 4], ax
3A44  EB 03           jmp 0x3a49
loc_3A46:
3A46  FF 46 FC        inc word ptr [bp - 4]
loc_3A49:
3A49  31 C0           xor ax, ax
3A4B  89 46 F4        mov word ptr [bp - 0xc], ax
3A4E  8B 7E FC        mov di, word ptr [bp - 4]
3A51  D1 E7           shl di, 1
3A53  8B 85 DA D1     mov ax, word ptr [di - 0x2e26]
3A57  C1 E0 03        shl ax, 3
3A5A  C4 3E BA D7     les di, ptr [0xd7ba]
3A5E  03 F8           add di, ax
3A60  26 8A 05        mov al, byte ptr es:[di]
3A63  30 E4           xor ah, ah
3A65  50              push ax
3A66  9A 7A 0E 55 1B  call far 1B55:0E7A
3A6B  88 46 F1        mov byte ptr [bp - 0xf], al
3A6E  80 7E F1 00     cmp byte ptr [bp - 0xf], 0
3A72  74 07           je 0x3a7b
3A74  C7 46 F6 09 00  mov word ptr [bp - 0xa], 9
3A79  EB 19           jmp 0x3a94
loc_3A7B:
3A7B  C4 3E D2 D7     les di, ptr [0xd7d2]
3A7F  26 80 3D 05     cmp byte ptr es:[di], 5
3A83  B0 00           mov al, 0
3A85  73 01           jae 0x3a88
3A87  40              inc ax
loc_3A88:
3A88  98              cwde
3A89  8B F8           mov di, ax
3A8B  8A 85 78 03     mov al, byte ptr [di + 0x378]
3A8F  30 E4           xor ah, ah
3A91  89 46 F6        mov word ptr [bp - 0xa], ax
loc_3A94:
3A94  8B 7E FC        mov di, word ptr [bp - 4]
3A97  D1 E7           shl di, 1
3A99  FF B5 DA D1     push word ptr [di - 0x2e26]
3A9D  E8 01 F1        call 0x2ba1
3AA0  89 46 FA        mov word ptr [bp - 6], ax
3AA3  FF 46 F4        inc word ptr [bp - 0xc]
3AA6  83 7E FA 00     cmp word ptr [bp - 6], 0
3AAA  75 08           jne 0x3ab4
3AAC  8B 46 F4        mov ax, word ptr [bp - 0xc]
3AAF  3B 46 F6        cmp ax, word ptr [bp - 0xa]
3AB2  72 E0           jb 0x3a94
loc_3AB4:
3AB4  83 7E FA 00     cmp word ptr [bp - 6], 0
3AB8  74 78           je 0x3b32
3ABA  80 7E F1 00     cmp byte ptr [bp - 0xf], 0
3ABE  74 0F           je 0x3acf
3AC0  8B 7E FC        mov di, word ptr [bp - 4]
3AC3  D1 E7           shl di, 1
3AC5  FF B5 DA D1     push word ptr [di - 0x2e26]
3AC9  55              push bp
3ACA  E8 1D FC        call 0x36ea
3ACD  EB 63           jmp 0x3b32
loc_3ACF:
3ACF  8B 7E FC        mov di, word ptr [bp - 4]
3AD2  D1 E7           shl di, 1
3AD4  FF B5 DA D1     push word ptr [di - 0x2e26]
3AD8  8B 7E FC        mov di, word ptr [bp - 4]
3ADB  D1 E7           shl di, 1
3ADD  8B 85 DA D1     mov ax, word ptr [di - 0x2e26]
3AE1  C1 E0 03        shl ax, 3
3AE4  C4 3E BA D7     les di, ptr [0xd7ba]
3AE8  03 F8           add di, ax
3AEA  26 8A 05        mov al, byte ptr es:[di]
3AED  30 E4           xor ah, ah
3AEF  50              push ax
3AF0  6A 00           push 0
3AF2  6A 00           push 0
3AF4  6A 00           push 0
3AF6  9A 47 64 55 1B  call far 1B55:6447
3AFB  8B 7E FC        mov di, word ptr [bp - 4]
3AFE  D1 E7           shl di, 1
3B00  FF B5 DA D1     push word ptr [di - 0x2e26]
3B04  55              push bp
3B05  E8 6E FA        call 0x3576
3B08  8B 7E FC        mov di, word ptr [bp - 4]
3B0B  D1 E7           shl di, 1
3B0D  FF B5 DA D1     push word ptr [di - 0x2e26]
3B11  FF 76 F8        push word ptr [bp - 8]
3B14  0E              push cs
3B15  E8 AE F2        call 0x2dc6
3B18  8B 7E FC        mov di, word ptr [bp - 4]
3B1B  D1 E7           shl di, 1
3B1D  8B 85 DA D1     mov ax, word ptr [di - 0x2e26]
3B21  C1 E0 03        shl ax, 3
3B24  C4 3E BA D7     les di, ptr [0xd7ba]
3B28  03 F8           add di, ax
3B2A  26 8A 45 07     mov al, byte ptr es:[di + 7]
3B2E  26 88 45 06     mov byte ptr es:[di + 6], al
loc_3B32:
3B32  8B 46 FC        mov ax, word ptr [bp - 4]
3B35  3B 46 EE        cmp ax, word ptr [bp - 0x12]
3B38  74 03           je 0x3b3d
3B3A  E9 09 FF        jmp 0x3a46
loc_3B3D:
3B3D  83 7E F2 00     cmp word ptr [bp - 0xe], 0
3B41  75 02           jne 0x3b45
3B43  EB 19           jmp 0x3b5e
loc_3B45:
3B45  C4 3E 5C DD     les di, ptr [0xdd5c]
3B49  06              push es
3B4A  57              push di
3B4B  C4 3E 58 DD     les di, ptr [0xdd58]
3B4F  06              push es
3B50  57              push di
3B51  68 A0 0F        push 0xfa0
3B54  9A 12 0A C9 26  call far 26C9:0A12
3B59  9A 9B 09 2A 23  call far 232A:099B
loc_3B5E:
3B5E  C9              leave
3B5F  CB              retf
; data (not reached as code), 11 bytes
3B60                  pstr 'Not enough'

; ---- routine 06E8:3B6B  (found by: far)
sub_3B6B:
3B6B  C8 0C 01 00     enter 0x10c, 0
3B6F  8B 46 06        mov ax, word ptr [bp + 6]
3B72  C1 E0 03        shl ax, 3
3B75  C4 3E BA D7     les di, ptr [0xd7ba]
3B79  03 F8           add di, ax
3B7B  89 7E F8        mov word ptr [bp - 8], di
3B7E  8C 46 FA        mov word ptr [bp - 6], es
3B81  6B 46 06 0F     imul ax, word ptr [bp + 6], 0xf
3B85  C4 3E BE D7     les di, ptr [0xd7be]
3B89  03 F8           add di, ax
3B8B  89 7E F4        mov word ptr [bp - 0xc], di
3B8E  8C 46 F6        mov word ptr [bp - 0xa], es
3B91  C6 46 FF 00     mov byte ptr [bp - 1], 0
3B95  26 C6 45 0D 01  mov byte ptr es:[di + 0xd], 1
3B9A  C4 7E F8        les di, ptr [bp - 8]
3B9D  26 8A 45 04     mov al, byte ptr es:[di + 4]
3BA1  C4 7E F4        les di, ptr [bp - 0xc]
3BA4  26 88 45 09     mov byte ptr es:[di + 9], al
3BA8  FF 76 06        push word ptr [bp + 6]
3BAB  9A D7 49 55 1B  call far 1B55:49D7
3BB0  88 46 FD        mov byte ptr [bp - 3], al
3BB3  C4 7E F4        les di, ptr [bp - 0xc]
3BB6  26 C6 45 09 14  mov byte ptr es:[di + 9], 0x14
3BBB  C4 7E F8        les di, ptr [bp - 8]
3BBE  26 8A 45 04     mov al, byte ptr es:[di + 4]
3BC2  88 46 FE        mov byte ptr [bp - 2], al
3BC5  BF 5E 14        mov di, 0x145e
3BC8  1E              push ds
3BC9  57              push di
3BCA  BF 5C DD        mov di, 0xdd5c
3BCD  1E              push ds
3BCE  57              push di
3BCF  9A 2F 05 2A 23  call far 232A:052F
loc_3BD4:
3BD4  FF 76 06        push word ptr [bp + 6]
3BD7  9A B3 95 B9 0A  call far 0AB9:95B3
3BDC  BF A4 2F        mov di, 0x2fa4
3BDF  1E              push ds
3BE0  57              push di
3BE1  BF 5C DD        mov di, 0xdd5c
3BE4  1E              push ds
3BE5  57              push di
3BE6  9A 2F 05 2A 23  call far 232A:052F
3BEB  FF 76 06        push word ptr [bp + 6]
3BEE  8B 46 06        mov ax, word ptr [bp + 6]
3BF1  C1 E0 03        shl ax, 3
3BF4  C4 3E BA D7     les di, ptr [0xd7ba]
3BF8  03 F8           add di, ax
3BFA  26 8A 45 06     mov al, byte ptr es:[di + 6]
3BFE  30 E4           xor ah, ah
3C00  50              push ax
3C01  9A 4A 72 55 1B  call far 1B55:724A
3C06  50              push ax
3C07  8D BE F4 FE     lea di, [bp - 0x10c]
3C0B  16              push ss
3C0C  57              push di
3C0D  FF 76 06        push word ptr [bp + 6]
3C10  9A DC 44 55 1B  call far 1B55:44DC
3C15  6A 06           push 6
3C17  6A 3B           push 0x3b
3C19  BF 5C DD        mov di, 0xdd5c
3C1C  1E              push ds
3C1D  57              push di
3C1E  9A 1B 04 2A 23  call far 232A:041B
3C23  6A 0E           push 0xe
3C25  8D BE F4 FE     lea di, [bp - 0x10c]
3C29  16              push ss
3C2A  57              push di
3C2B  8A 46 FE        mov al, byte ptr [bp - 2]
3C2E  30 E4           xor ah, ah
3C30  50              push ax
3C31  9A 3C 48 55 1B  call far 1B55:483C
3C36  52              push dx
3C37  50              push ax
3C38  9A C9 07 2A 23  call far 232A:07C9
3C3D  6A 09           push 9
3C3F  6A 3B           push 0x3b
3C41  BF 5C DD        mov di, 0xdd5c
3C44  1E              push ds
3C45  57              push di
3C46  9A 1B 04 2A 23  call far 232A:041B
3C4B  C4 3E 5C DD     les di, ptr [0xdd5c]
3C4F  06              push es
3C50  57              push di
3C51  C4 3E 58 DD     les di, ptr [0xdd58]
3C55  06              push es
3C56  57              push di
3C57  68 A0 0F        push 0xfa0
3C5A  9A 12 0A C9 26  call far 26C9:0A12
3C5F  9A 9B 09 2A 23  call far 232A:099B
3C64  80 3E 88 DE 01  cmp byte ptr [0xde88], 1
3C69  75 03           jne 0x3c6e
3C6B  E9 95 00        jmp 0x3d03
loc_3C6E:
3C6E  80 3E 88 DE 05  cmp byte ptr [0xde88], 5
3C73  75 07           jne 0x3c7c
3C75  C6 06 88 DE 06  mov byte ptr [0xde88], 6
3C7A  EB 22           jmp 0x3c9e
loc_3C7C:
3C7C  80 3E 88 DE 06  cmp byte ptr [0xde88], 6
3C81  75 07           jne 0x3c8a
3C83  C6 06 88 DE 05  mov byte ptr [0xde88], 5
3C88  EB 14           jmp 0x3c9e
loc_3C8A:
3C8A  80 3E 88 DE 0D  cmp byte ptr [0xde88], 0xd
3C8F  75 0D           jne 0x3c9e
3C91  80 3E 2A 9A 00  cmp byte ptr [0x9a2a], 0
3C96  B0 00           mov al, 0
3C98  75 01           jne 0x3c9b
3C9A  40              inc ax
loc_3C9B:
3C9B  A2 2A 9A        mov byte ptr [0x9a2a], al
loc_3C9E:
3C9E  8D 7E FE        lea di, [bp - 2]
3CA1  16              push ss
3CA2  57              push di
3CA3  68 FF 00        push 0xff
3CA6  9A C4 0E 2A 23  call far 232A:0EC4
3CAB  80 3E 88 DE 02  cmp byte ptr [0xde88], 2
3CB0  74 03           je 0x3cb5
3CB2  E9 1F FF        jmp 0x3bd4
loc_3CB5:
3CB5  8A 46 FE        mov al, byte ptr [bp - 2]
3CB8  3A 46 FD        cmp al, byte ptr [bp - 3]
3CBB  B0 00           mov al, 0
3CBD  73 01           jae 0x3cc0
3CBF  40              inc ax
loc_3CC0:
3CC0  50              push ax
3CC1  BF 60 3B        mov di, 0x3b60
3CC4  0E              push cs
3CC5  57              push di
3CC6  9A 98 00 2A 23  call far 232A:0098
3CCB  08 C0           or al, al
3CCD  74 03           je 0x3cd2
3CCF  E9 02 FF        jmp 0x3bd4
loc_3CD2:
3CD2  BF BE 30        mov di, 0x30be
3CD5  1E              push ds
3CD6  57              push di
3CD7  BF 58 DD        mov di, 0xdd58
3CDA  1E              push ds
3CDB  57              push di
3CDC  9A 2F 05 2A 23  call far 232A:052F
3CE1  BF DA 4E        mov di, 0x4eda
3CE4  1E              push ds
3CE5  57              push di
3CE6  BF 58 DD        mov di, 0xdd58
3CE9  1E              push ds
3CEA  57              push di
3CEB  9A 2F 05 2A 23  call far 232A:052F
3CF0  9A 9B 09 2A 23  call far 232A:099B
3CF5  8A 46 FE        mov al, byte ptr [bp - 2]
3CF8  C4 7E F4        les di, ptr [bp - 0xc]
3CFB  26 88 45 09     mov byte ptr es:[di + 9], al
3CFF  C6 46 FF 01     mov byte ptr [bp - 1], 1
loc_3D03:
3D03  8A 46 FF        mov al, byte ptr [bp - 1]
3D06  C9              leave
3D07  CA 02 00        retf 2
; data (not reached as code), 6 bytes
3D0A                  db 00 00 00 00 00 00   ; ......
