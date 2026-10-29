; 1-0.EXE (One-Nil 96), code segment 01EF (image offsets 01EF0..06E7F), part 3 of 7
; packed 1-0.EXE sha256 89ff9c5f238f24e81a0c2440a46cdd8997280a65fc3cc3d97cb974f55280a80a (LZEXE 0.91)
; unpacked (tools/static/unlzexe.py) sha256 887ed2a92767950e5309b2052409f875668605939b69e00737aa3047022b9f51
; tool: capstone 5.0.9 (pip package; core library 5.0.1280) (CS_ARCH_X86, CS_MODE_16), recursive descent from the entry point, far calls and near calls/jumps, then routine prologues (55 89 E5 / 55 8B EC / C8 iw 00) in what remains; tools/static/listing.py
; addresses are SEGMENT:OFFSET with SEGMENT the image paragraph before relocation; image offset = SEGMENT*16+OFFSET
; ---- routine 01EF:198E  (found by: call)
sub_198E:
198E  55              push bp
198F  89 E5           mov bp, sp
1991  8B 56 0A        mov dx, word ptr [bp + 0xa]
1994  8B 46 08        mov ax, word ptr [bp + 8]
1997  D1 E0           shl ax, 1
1999  8B 7E 04        mov di, word ptr [bp + 4]
199C  03 F8           add di, ax
199E  36 89 55 EA     mov word ptr ss:[di - 0x16], dx
19A2  8B 56 06        mov dx, word ptr [bp + 6]
19A5  8B 46 08        mov ax, word ptr [bp + 8]
19A8  D1 E0           shl ax, 1
19AA  8B 7E 04        mov di, word ptr [bp + 4]
19AD  03 F8           add di, ax
19AF  36 89 55 DA     mov word ptr ss:[di - 0x26], dx
19B3  C9              leave
19B4  C2 08 00        ret 8

; ---- routine 01EF:19B7  (found by: call)
sub_19B7:
19B7  C8 2A 01 00     enter 0x12a, 0
19BB  8B 7E 04        mov di, word ptr [bp + 4]
19BE  36 8A 45 FF     mov al, byte ptr ss:[di - 1]
19C2  30 E4           xor ah, ah
19C4  48              dec ax
19C5  C1 E0 04        shl ax, 4
19C8  40              inc ax
19C9  89 46 FC        mov word ptr [bp - 4], ax
19CC  8D 7E DC        lea di, [bp - 0x24]
19CF  16              push ss
19D0  57              push di
19D1  6A 10           push 0x10
19D3  6A 00           push 0
19D5  9A 22 02 BC 24  call far 24BC:0222
19DA  8D 7E EC        lea di, [bp - 0x14]
19DD  16              push ss
19DE  57              push di
19DF  6A 10           push 0x10
19E1  6A 00           push 0
19E3  9A 22 02 BC 24  call far 24BC:0222
19E8  C7 46 DE FF 00  mov word ptr [bp - 0x22], 0xff
19ED  C7 46 E0 FF 00  mov word ptr [bp - 0x20], 0xff
19F2  8B 46 FC        mov ax, word ptr [bp - 4]
19F5  05 0F 00        add ax, 0xf
19F8  89 46 D8        mov word ptr [bp - 0x28], ax
19FB  8B 46 FC        mov ax, word ptr [bp - 4]
19FE  3B 46 D8        cmp ax, word ptr [bp - 0x28]
1A01  76 03           jbe 0x1a06
1A03  E9 58 01        jmp 0x1b5e
loc_1A06:
1A06  89 46 FE        mov word ptr [bp - 2], ax
1A09  EB 03           jmp 0x1a0e
loc_1A0B:
1A0B  FF 46 FE        inc word ptr [bp - 2]
loc_1A0E:
1A0E  8B 7E FE        mov di, word ptr [bp - 2]
1A11  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
1A15  30 E4           xor ah, ah
1A17  6B C0 0C        imul ax, ax, 0xc
1A1A  C4 3E C6 D7     les di, ptr [0xd7c6]
1A1E  03 F8           add di, ax
1A20  81 C7 F4 FF     add di, 0xfff4
1A24  89 7E D4        mov word ptr [bp - 0x2c], di
1A27  8C 46 D6        mov word ptr [bp - 0x2a], es
1A2A  26 8B 45 08     mov ax, word ptr es:[di + 8]
1A2E  3B 46 DC        cmp ax, word ptr [bp - 0x24]
1A31  76 17           jbe 0x1a4a
1A33  8B 7E FE        mov di, word ptr [bp - 2]
1A36  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
1A3A  30 E4           xor ah, ah
1A3C  50              push ax
1A3D  6A 01           push 1
1A3F  C4 7E D4        les di, ptr [bp - 0x2c]
1A42  26 FF 75 08     push word ptr es:[di + 8]
1A46  55              push bp
1A47  E8 44 FF        call 0x198e
loc_1A4A:
1A4A  C4 7E D4        les di, ptr [bp - 0x2c]
1A4D  26 8B 45 08     mov ax, word ptr es:[di + 8]
1A51  3B 46 DE        cmp ax, word ptr [bp - 0x22]
1A54  73 17           jae 0x1a6d
1A56  8B 7E FE        mov di, word ptr [bp - 2]
1A59  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
1A5D  30 E4           xor ah, ah
1A5F  50              push ax
1A60  6A 02           push 2
1A62  C4 7E D4        les di, ptr [bp - 0x2c]
1A65  26 FF 75 08     push word ptr es:[di + 8]
1A69  55              push bp
1A6A  E8 21 FF        call 0x198e
loc_1A6D:
1A6D  C4 7E D4        les di, ptr [bp - 0x2c]
1A70  26 8B 45 0A     mov ax, word ptr es:[di + 0xa]
1A74  3B 46 E0        cmp ax, word ptr [bp - 0x20]
1A77  73 17           jae 0x1a90
1A79  8B 7E FE        mov di, word ptr [bp - 2]
1A7C  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
1A80  30 E4           xor ah, ah
1A82  50              push ax
1A83  6A 03           push 3
1A85  C4 7E D4        les di, ptr [bp - 0x2c]
1A88  26 FF 75 0A     push word ptr es:[di + 0xa]
1A8C  55              push bp
1A8D  E8 FE FE        call 0x198e
loc_1A90:
1A90  C4 7E D4        les di, ptr [bp - 0x2c]
1A93  26 8B 45 0A     mov ax, word ptr es:[di + 0xa]
1A97  3B 46 E2        cmp ax, word ptr [bp - 0x1e]
1A9A  76 17           jbe 0x1ab3
1A9C  8B 7E FE        mov di, word ptr [bp - 2]
1A9F  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
1AA3  30 E4           xor ah, ah
1AA5  50              push ax
1AA6  6A 04           push 4
1AA8  C4 7E D4        les di, ptr [bp - 0x2c]
1AAB  26 FF 75 0A     push word ptr es:[di + 0xa]
1AAF  55              push bp
1AB0  E8 DB FE        call 0x198e
loc_1AB3:
1AB3  C4 7E D4        les di, ptr [bp - 0x2c]
1AB6  26 8A 45 02     mov al, byte ptr es:[di + 2]
1ABA  30 E4           xor ah, ah
1ABC  3B 46 E4        cmp ax, word ptr [bp - 0x1c]
1ABF  76 1A           jbe 0x1adb
1AC1  8B 7E FE        mov di, word ptr [bp - 2]
1AC4  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
1AC8  30 E4           xor ah, ah
1ACA  50              push ax
1ACB  6A 05           push 5
1ACD  C4 7E D4        les di, ptr [bp - 0x2c]
1AD0  26 8A 45 02     mov al, byte ptr es:[di + 2]
1AD4  30 E4           xor ah, ah
1AD6  50              push ax
1AD7  55              push bp
1AD8  E8 B3 FE        call 0x198e
loc_1ADB:
1ADB  C4 7E D4        les di, ptr [bp - 0x2c]
1ADE  26 8A 45 06     mov al, byte ptr es:[di + 6]
1AE2  30 E4           xor ah, ah
1AE4  3B 46 E6        cmp ax, word ptr [bp - 0x1a]
1AE7  76 1A           jbe 0x1b03
1AE9  8B 7E FE        mov di, word ptr [bp - 2]
1AEC  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
1AF0  30 E4           xor ah, ah
1AF2  50              push ax
1AF3  6A 06           push 6
1AF5  C4 7E D4        les di, ptr [bp - 0x2c]
1AF8  26 8A 45 06     mov al, byte ptr es:[di + 6]
1AFC  30 E4           xor ah, ah
1AFE  50              push ax
1AFF  55              push bp
1B00  E8 8B FE        call 0x198e
loc_1B03:
1B03  C4 7E D4        les di, ptr [bp - 0x2c]
1B06  26 8A 45 03     mov al, byte ptr es:[di + 3]
1B0A  30 E4           xor ah, ah
1B0C  3B 46 E8        cmp ax, word ptr [bp - 0x18]
1B0F  76 1A           jbe 0x1b2b
1B11  8B 7E FE        mov di, word ptr [bp - 2]
1B14  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
1B18  30 E4           xor ah, ah
1B1A  50              push ax
1B1B  6A 07           push 7
1B1D  C4 7E D4        les di, ptr [bp - 0x2c]
1B20  26 8A 45 03     mov al, byte ptr es:[di + 3]
1B24  30 E4           xor ah, ah
1B26  50              push ax
1B27  55              push bp
1B28  E8 63 FE        call 0x198e
loc_1B2B:
1B2B  C4 7E D4        les di, ptr [bp - 0x2c]
1B2E  26 8A 45 07     mov al, byte ptr es:[di + 7]
1B32  30 E4           xor ah, ah
1B34  3B 46 EA        cmp ax, word ptr [bp - 0x16]
1B37  76 1A           jbe 0x1b53
1B39  8B 7E FE        mov di, word ptr [bp - 2]
1B3C  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
1B40  30 E4           xor ah, ah
1B42  50              push ax
1B43  6A 08           push 8
1B45  C4 7E D4        les di, ptr [bp - 0x2c]
1B48  26 8A 45 07     mov al, byte ptr es:[di + 7]
1B4C  30 E4           xor ah, ah
1B4E  50              push ax
1B4F  55              push bp
1B50  E8 3B FE        call 0x198e
loc_1B53:
1B53  8B 46 FE        mov ax, word ptr [bp - 2]
1B56  3B 46 D8        cmp ax, word ptr [bp - 0x28]
1B59  74 03           je 0x1b5e
1B5B  E9 AD FE        jmp 0x1a0b
loc_1B5E:
1B5E  C7 46 FE 01 00  mov word ptr [bp - 2], 1
1B63  EB 03           jmp 0x1b68
loc_1B65:
1B65  FF 46 FE        inc word ptr [bp - 2]
loc_1B68:
1B68  8B 7E FE        mov di, word ptr [bp - 2]
1B6B  D1 E7           shl di, 1
1B6D  83 7B EA 00     cmp word ptr [bp + di - 0x16], 0
1B71  74 40           je 0x1bb3
1B73  8B 7E FE        mov di, word ptr [bp - 2]
1B76  D1 E7           shl di, 1
1B78  FF 73 EA        push word ptr [bp + di - 0x16]
1B7B  8B 46 FE        mov ax, word ptr [bp - 2]
1B7E  05 05 00        add ax, 5
1B81  50              push ax
1B82  6A 3E           push 0x3e
1B84  9A E3 0E 55 1B  call far 1B55:0EE3
1B89  8D BE DA FE     lea di, [bp - 0x126]
1B8D  16              push ss
1B8E  57              push di
1B8F  8B 7E FE        mov di, word ptr [bp - 2]
1B92  D1 E7           shl di, 1
1B94  8B 43 DA        mov ax, word ptr [bp + di - 0x26]
1B97  31 D2           xor dx, dx
1B99  52              push dx
1B9A  50              push ax
1B9B  9A C9 07 2A 23  call far 232A:07C9
1BA0  8B 46 FE        mov ax, word ptr [bp - 2]
1BA3  05 05 00        add ax, 5
1BA6  50              push ax
1BA7  6A 50           push 0x50
1BA9  BF 5C DD        mov di, 0xdd5c
1BAC  1E              push ds
1BAD  57              push di
1BAE  9A 83 02 2A 23  call far 232A:0283
loc_1BB3:
1BB3  83 7E FE 08     cmp word ptr [bp - 2], 8
1BB7  75 AC           jne 0x1b65
1BB9  8B 7E 04        mov di, word ptr [bp + 4]
1BBC  36 8A 45 FF     mov al, byte ptr ss:[di - 1]
1BC0  30 E4           xor ah, ah
1BC2  48              dec ax
1BC3  88 46 DB        mov byte ptr [bp - 0x25], al
1BC6  C7 46 FE 01 00  mov word ptr [bp - 2], 1
1BCB  EB 03           jmp 0x1bd0
loc_1BCD:
1BCD  FF 46 FE        inc word ptr [bp - 2]
loc_1BD0:
1BD0  C4 3E D2 D7     les di, ptr [0xd7d2]
1BD4  89 7E D6        mov word ptr [bp - 0x2a], di
1BD7  8C 46 D8        mov word ptr [bp - 0x28], es
1BDA  8B 56 FE        mov dx, word ptr [bp - 2]
1BDD  8A 46 DB        mov al, byte ptr [bp - 0x25]
1BE0  98              cwde
1BE1  C1 E0 02        shl ax, 2
1BE4  03 F8           add di, ax
1BE6  03 FA           add di, dx
1BE8  26 80 7D 2F 00  cmp byte ptr es:[di + 0x2f], 0
1BED  74 5F           je 0x1c4e
1BEF  8B 56 FE        mov dx, word ptr [bp - 2]
1BF2  8A 46 DB        mov al, byte ptr [bp - 0x25]
1BF5  98              cwde
1BF6  C1 E0 02        shl ax, 2
1BF9  C4 7E D6        les di, ptr [bp - 0x2a]
1BFC  03 F8           add di, ax
1BFE  03 FA           add di, dx
1C00  26 8A 45 2F     mov al, byte ptr es:[di + 0x2f]
1C04  30 E4           xor ah, ah
1C06  50              push ax
1C07  8B 46 FE        mov ax, word ptr [bp - 2]
1C0A  05 10 00        add ax, 0x10
1C0D  50              push ax
1C0E  6A 3E           push 0x3e
1C10  9A E3 0E 55 1B  call far 1B55:0EE3
1C15  8D BE D6 FE     lea di, [bp - 0x12a]
1C19  16              push ss
1C1A  57              push di
1C1B  8B 56 FE        mov dx, word ptr [bp - 2]
1C1E  8A 46 DB        mov al, byte ptr [bp - 0x25]
1C21  98              cwde
1C22  C1 E0 02        shl ax, 2
1C25  C4 7E D6        les di, ptr [bp - 0x2a]
1C28  03 F8           add di, ax
1C2A  03 FA           add di, dx
1C2C  26 8A 45 43     mov al, byte ptr es:[di + 0x43]
1C30  30 E4           xor ah, ah
1C32  31 D2           xor dx, dx
1C34  52              push dx
1C35  50              push ax
1C36  9A C9 07 2A 23  call far 232A:07C9
1C3B  8B 46 FE        mov ax, word ptr [bp - 2]
1C3E  05 10 00        add ax, 0x10
1C41  50              push ax
1C42  6A 50           push 0x50
1C44  BF 5C DD        mov di, 0xdd5c
1C47  1E              push ds
1C48  57              push di
1C49  9A 83 02 2A 23  call far 232A:0283
loc_1C4E:
1C4E  83 7E FE 04     cmp word ptr [bp - 2], 4
1C52  74 03           je 0x1c57
1C54  E9 76 FF        jmp 0x1bcd
loc_1C57:
1C57  C9              leave
1C58  C2 02 00        ret 2

; ---- routine 01EF:1C5B  (found by: call)
sub_1C5B:
1C5B  C8 04 01 00     enter 0x104, 0
1C5F  C7 46 FE 01 00  mov word ptr [bp - 2], 1
1C64  EB 03           jmp 0x1c69
loc_1C66:
1C66  FF 46 FE        inc word ptr [bp - 2]
loc_1C69:
1C69  8B 46 FE        mov ax, word ptr [bp - 2]
1C6C  D1 E0           shl ax, 1
1C6E  8B D0           mov dx, ax
1C70  8A 46 06        mov al, byte ptr [bp + 6]
1C73  98              cwde
1C74  6B F8 28        imul di, ax, 0x28
1C77  03 FA           add di, dx
1C79  8B 85 AA D5     mov ax, word ptr [di - 0x2a56]
1C7D  89 46 FC        mov word ptr [bp - 4], ax
1C80  8B 46 FC        mov ax, word ptr [bp - 4]
1C83  C1 E0 03        shl ax, 3
1C86  C4 3E BA D7     les di, ptr [0xd7ba]
1C8A  03 F8           add di, ax
1C8C  26 8A 45 06     mov al, byte ptr es:[di + 6]
1C90  30 E4           xor ah, ah
1C92  8B F8           mov di, ax
1C94  8A 85 08 87     mov al, byte ptr [di - 0x78f8]
1C98  50              push ax
1C99  8D BE FC FE     lea di, [bp - 0x104]
1C9D  16              push ss
1C9E  57              push di
1C9F  8B 46 FC        mov ax, word ptr [bp - 4]
1CA2  C1 E0 03        shl ax, 3
1CA5  C4 3E BA D7     les di, ptr [0xd7ba]
1CA9  03 F8           add di, ax
1CAB  26 8A 45 06     mov al, byte ptr es:[di + 6]
1CAF  30 E4           xor ah, ah
1CB1  8B F8           mov di, ax
1CB3  8A 85 16 87     mov al, byte ptr [di - 0x78ea]
1CB7  50              push ax
1CB8  9A 6F 0C C9 26  call far 26C9:0C6F
1CBD  8B 46 FE        mov ax, word ptr [bp - 2]
1CC0  05 03 00        add ax, 3
1CC3  50              push ax
1CC4  6A 04           push 4
1CC6  BF 5C DD        mov di, 0xdd5c
1CC9  1E              push ds
1CCA  57              push di
1CCB  9A 1B 04 2A 23  call far 232A:041B
1CD0  8D BE FC FE     lea di, [bp - 0x104]
1CD4  16              push ss
1CD5  57              push di
1CD6  FF 76 FC        push word ptr [bp - 4]
1CD9  9A DC 44 55 1B  call far 1B55:44DC
1CDE  8B 46 FE        mov ax, word ptr [bp - 2]
1CE1  05 03 00        add ax, 3
1CE4  50              push ax
1CE5  6A 06           push 6
1CE7  BF 5C DD        mov di, 0xdd5c
1CEA  1E              push ds
1CEB  57              push di
1CEC  9A 9D 03 2A 23  call far 232A:039D
1CF1  8D BE FC FE     lea di, [bp - 0x104]
1CF5  16              push ss
1CF6  57              push di
1CF7  6B 46 FC 0F     imul ax, word ptr [bp - 4], 0xf
1CFB  C4 3E BE D7     les di, ptr [0xd7be]
1CFF  03 F8           add di, ax
1D01  26 8A 45 05     mov al, byte ptr es:[di + 5]
1D05  30 E4           xor ah, ah
1D07  31 D2           xor dx, dx
1D09  52              push dx
1D0A  50              push ax
1D0B  9A C9 07 2A 23  call far 232A:07C9
1D10  8B 46 FE        mov ax, word ptr [bp - 2]
1D13  05 03 00        add ax, 3
1D16  50              push ax
1D17  6A 24           push 0x24
1D19  BF 5C DD        mov di, 0xdd5c
1D1C  1E              push ds
1D1D  57              push di
1D1E  9A 83 02 2A 23  call far 232A:0283
1D23  8B 46 FC        mov ax, word ptr [bp - 4]
1D26  C1 E0 03        shl ax, 3
1D29  C4 3E BA D7     les di, ptr [0xd7ba]
1D2D  03 F8           add di, ax
1D2F  26 8A 05        mov al, byte ptr es:[di]
1D32  30 E4           xor ah, ah
1D34  50              push ax
1D35  8B 46 FE        mov ax, word ptr [bp - 2]
1D38  05 03 00        add ax, 3
1D3B  50              push ax
1D3C  6A 12           push 0x12
1D3E  9A E3 0E 55 1B  call far 1B55:0EE3
1D43  83 7E FE 14     cmp word ptr [bp - 2], 0x14
1D47  74 03           je 0x1d4c
1D49  E9 1A FF        jmp 0x1c66
loc_1D4C:
1D4C  C9              leave
1D4D  C2 04 00        ret 4
; data (not reached as code), 42 bytes
1D50                  pstr 'Not available until after league match #4'

; ---- routine 01EF:1D7A  (found by: far)
sub_1D7A:
1D7A  C8 08 00 00     enter 8, 0
1D7E  C4 3E D2 D7     les di, ptr [0xd7d2]
1D82  89 7E F8        mov word ptr [bp - 8], di
1D85  8C 46 FA        mov word ptr [bp - 6], es
1D88  26 80 3D 09     cmp byte ptr es:[di], 9
1D8C  B0 00           mov al, 0
1D8E  73 01           jae 0x1d91
1D90  40              inc ax
loc_1D91:
1D91  50              push ax
1D92  BF 50 1D        mov di, 0x1d50
1D95  0E              push cs
1D96  57              push di
1D97  9A 98 00 2A 23  call far 232A:0098
1D9C  08 C0           or al, al
1D9E  74 03           je 0x1da3
1DA0  E9 05 01        jmp 0x1ea8
loc_1DA3:
1DA3  9A 85 00 2A 23  call far 232A:0085
1DA8  C7 46 FC 01 00  mov word ptr [bp - 4], 1
1DAD  C6 46 FF 01     mov byte ptr [bp - 1], 1
1DB1  EB 03           jmp 0x1db6
loc_1DB3:
1DB3  FE 46 FF        inc byte ptr [bp - 1]
loc_1DB6:
1DB6  8D 7E FC        lea di, [bp - 4]
1DB9  16              push ss
1DBA  57              push di
1DBB  9A 94 46 55 1B  call far 1B55:4694
1DC0  80 7E FF 05     cmp byte ptr [bp - 1], 5
1DC4  75 ED           jne 0x1db3
1DC6  C6 46 FF 01     mov byte ptr [bp - 1], 1
1DCA  C4 7E F8        les di, ptr [bp - 8]
1DCD  26 8A 45 04     mov al, byte ptr es:[di + 4]
1DD1  30 E4           xor ah, ah
1DD3  8B F8           mov di, ax
1DD5  80 BD B9 DC 00  cmp byte ptr [di - 0x2347], 0
1DDA  74 24           je 0x1e00
1DDC  C4 7E F8        les di, ptr [bp - 8]
1DDF  26 8A 45 04     mov al, byte ptr es:[di + 4]
1DE3  30 E4           xor ah, ah
1DE5  8B F8           mov di, ax
1DE7  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
1DEB  30 E4           xor ah, ah
1DED  6B C0 3E        imul ax, ax, 0x3e
1DF0  C4 3E C2 D7     les di, ptr [0xd7c2]
1DF4  03 F8           add di, ax
1DF6  26 8A 45 F9     mov al, byte ptr es:[di - 7]
1DFA  30 E4           xor ah, ah
1DFC  40              inc ax
1DFD  88 46 FF        mov byte ptr [bp - 1], al
loc_1E00:
1E00  BF 76 33        mov di, 0x3376
1E03  1E              push ds
1E04  57              push di
1E05  BF 5C DD        mov di, 0xdd5c
1E08  1E              push ds
1E09  57              push di
1E0A  9A 2F 05 2A 23  call far 232A:052F
1E0F  BF 22 63        mov di, 0x6322
1E12  1E              push ds
1E13  57              push di
1E14  BF 5C DD        mov di, 0xdd5c
1E17  1E              push ds
1E18  57              push di
1E19  9A 2F 05 2A 23  call far 232A:052F
1E1E  8A 46 FF        mov al, byte ptr [bp - 1]
1E21  30 E4           xor ah, ah
1E23  48              dec ax
1E24  98              cwde
1E25  8B F8           mov di, ax
1E27  8A 85 3C A2     mov al, byte ptr [di - 0x5dc4]
1E2B  50              push ax
1E2C  8A 46 FF        mov al, byte ptr [bp - 1]
1E2F  30 E4           xor ah, ah
1E31  48              dec ax
1E32  98              cwde
1E33  8B F8           mov di, ax
1E35  C1 E7 04        shl di, 4
1E38  81 C7 E6 DC     add di, 0xdce6
1E3C  1E              push ds
1E3D  57              push di
1E3E  6A 01           push 1
1E40  6A 29           push 0x29
1E42  BF 5C DD        mov di, 0xdd5c
1E45  1E              push ds
1E46  57              push di
1E47  9A 1B 04 2A 23  call far 232A:041B
1E4C  8A 46 FF        mov al, byte ptr [bp - 1]
1E4F  30 E4           xor ah, ah
1E51  48              dec ax
1E52  50              push ax
1E53  55              push bp
1E54  E8 04 FE        call 0x1c5b
1E57  55              push bp
1E58  E8 5C FB        call 0x19b7
1E5B  C4 3E 5C DD     les di, ptr [0xdd5c]
1E5F  06              push es
1E60  57              push di
1E61  C4 3E 58 DD     les di, ptr [0xdd58]
1E65  06              push es
1E66  57              push di
1E67  68 A0 0F        push 0xfa0
1E6A  9A 12 0A C9 26  call far 26C9:0A12
1E6F  9A 9B 09 2A 23  call far 232A:099B
1E74  80 3E 88 DE 02  cmp byte ptr [0xde88], 2
1E79  75 07           jne 0x1e82
1E7B  C6 06 88 DE 06  mov byte ptr [0xde88], 6
1E80  EB 10           jmp 0x1e92
loc_1E82:
1E82  A0 88 DE        mov al, byte ptr [0xde88]
1E85  3C 0E           cmp al, 0xe
1E87  72 09           jb 0x1e92
1E89  3C 0F           cmp al, 0xf
1E8B  77 05           ja 0x1e92
1E8D  C6 06 88 DE 05  mov byte ptr [0xde88], 5
loc_1E92:
1E92  8D 7E FF        lea di, [bp - 1]
1E95  16              push ss
1E96  57              push di
1E97  6A 05           push 5
1E99  9A C4 0E 2A 23  call far 232A:0EC4
1E9E  80 3E 88 DE 01  cmp byte ptr [0xde88], 1
1EA3  74 03           je 0x1ea8
1EA5  E9 58 FF        jmp 0x1e00
loc_1EA8:
1EA8  C9              leave
1EA9  CB              retf

; ---- routine 01EF:1EAA  (found by: call)
sub_1EAA:
1EAA  C8 0C 00 00     enter 0xc, 0
1EAE  C7 46 FC 01 00  mov word ptr [bp - 4], 1
1EB3  8B 46 08        mov ax, word ptr [bp + 8]
1EB6  89 46 F8        mov word ptr [bp - 8], ax
1EB9  8B 46 0A        mov ax, word ptr [bp + 0xa]
1EBC  3B 46 F8        cmp ax, word ptr [bp - 8]
1EBF  76 03           jbe 0x1ec4
1EC1  E9 2A 01        jmp 0x1fee
loc_1EC4:
1EC4  89 46 FE        mov word ptr [bp - 2], ax
1EC7  EB 03           jmp 0x1ecc
loc_1EC9:
1EC9  FF 46 FE        inc word ptr [bp - 2]
loc_1ECC:
1ECC  8B 7E FE        mov di, word ptr [bp - 2]
1ECF  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
1ED3  30 E4           xor ah, ah
1ED5  6B C0 3E        imul ax, ax, 0x3e
1ED8  C4 3E C2 D7     les di, ptr [0xd7c2]
1EDC  03 F8           add di, ax
1EDE  81 C7 C2 FF     add di, 0xffc2
1EE2  89 7E F4        mov word ptr [bp - 0xc], di
1EE5  8C 46 F6        mov word ptr [bp - 0xa], es
1EE8  26 8A 45 37     mov al, byte ptr es:[di + 0x37]
1EEC  88 46 FB        mov byte ptr [bp - 5], al
1EEF  80 7E 06 05     cmp byte ptr [bp + 6], 5
1EF3  75 1D           jne 0x1f12
1EF5  8B 7E FE        mov di, word ptr [bp - 2]
1EF8  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
1EFC  30 E4           xor ah, ah
1EFE  50              push ax
1EFF  9A 8E 1B 55 1B  call far 1B55:1B8E
1F04  08 C0           or al, al
1F06  75 0A           jne 0x1f12
1F08  C4 7E F4        les di, ptr [bp - 0xc]
1F0B  26 C6 45 37 06  mov byte ptr es:[di + 0x37], 6
1F10  EB 0A           jmp 0x1f1c
loc_1F12:
1F12  8A 46 06        mov al, byte ptr [bp + 6]
1F15  C4 7E F4        les di, ptr [bp - 0xc]
1F18  26 88 45 37     mov byte ptr es:[di + 0x37], al
loc_1F1C:
1F1C  C4 7E F4        les di, ptr [bp - 0xc]
1F1F  26 80 7D 37 05  cmp byte ptr es:[di + 0x37], 5
1F24  7D 09           jge 0x1f2f
1F26  8A 46 FC        mov al, byte ptr [bp - 4]
1F29  26 88 45 36     mov byte ptr es:[di + 0x36], al
1F2D  EB 08           jmp 0x1f37
loc_1F2F:
1F2F  C4 7E F4        les di, ptr [bp - 0xc]
1F32  26 C6 45 36 00  mov byte ptr es:[di + 0x36], 0
loc_1F37:
1F37  FF 46 FC        inc word ptr [bp - 4]
1F3A  C4 3E D2 D7     les di, ptr [0xd7d2]
1F3E  26 80 7D 01 01  cmp byte ptr es:[di + 1], 1
1F43  75 03           jne 0x1f48
1F45  E9 9B 00        jmp 0x1fe3
loc_1F48:
1F48  8A 46 FB        mov al, byte ptr [bp - 5]
1F4B  C4 7E F4        les di, ptr [bp - 0xc]
1F4E  26 3A 45 37     cmp al, byte ptr es:[di + 0x37]
1F52  75 03           jne 0x1f57
1F54  E9 8C 00        jmp 0x1fe3
loc_1F57:
1F57  8A 46 FB        mov al, byte ptr [bp - 5]
1F5A  26 3A 45 37     cmp al, byte ptr es:[di + 0x37]
1F5E  7E 47           jle 0x1fa7
1F60  26 8A 45 37     mov al, byte ptr es:[di + 0x37]
1F64  98              cwde
1F65  8B 7E 04        mov di, word ptr [bp + 4]
1F68  03 F8           add di, ax
1F6A  36 FE 45 A4     inc byte ptr ss:[di - 0x5c]
1F6E  8B 7E FE        mov di, word ptr [bp - 2]
1F71  8A 8D D5 D7     mov cl, byte ptr [di - 0x282b]
1F75  C4 7E F4        les di, ptr [bp - 0xc]
1F78  26 8A 45 37     mov al, byte ptr es:[di + 0x37]
1F7C  98              cwde
1F7D  8B 7E 04        mov di, word ptr [bp + 4]
1F80  03 F8           add di, ax
1F82  36 8A 45 A4     mov al, byte ptr ss:[di - 0x5c]
1F86  30 E4           xor ah, ah
1F88  8B D0           mov dx, ax
1F8A  C4 7E F4        les di, ptr [bp - 0xc]
1F8D  26 8A 45 37     mov al, byte ptr es:[di + 0x37]
1F91  98              cwde
1F92  D1 E0           shl ax, 1
1F94  8B F0           mov si, ax
1F96  D1 E0           shl ax, 1
1F98  01 F0           add ax, si
1F9A  8B 7E 04        mov di, word ptr [bp + 4]
1F9D  03 F8           add di, ax
1F9F  03 FA           add di, dx
1FA1  36 88 4D D5     mov byte ptr ss:[di - 0x2b], cl
1FA5  EB 3C           jmp 0x1fe3
loc_1FA7:
1FA7  8A 46 FB        mov al, byte ptr [bp - 5]
1FAA  98              cwde
1FAB  8B 7E 04        mov di, word ptr [bp + 4]
1FAE  03 F8           add di, ax
1FB0  36 FE 45 9C     inc byte ptr ss:[di - 0x64]
1FB4  8B 7E FE        mov di, word ptr [bp - 2]
1FB7  8A 8D D5 D7     mov cl, byte ptr [di - 0x282b]
1FBB  8A 46 FB        mov al, byte ptr [bp - 5]
1FBE  98              cwde
1FBF  8B 7E 04        mov di, word ptr [bp + 4]
1FC2  03 F8           add di, ax
1FC4  36 8A 45 9C     mov al, byte ptr ss:[di - 0x64]
1FC8  30 E4           xor ah, ah
1FCA  8B D0           mov dx, ax
1FCC  8A 46 FB        mov al, byte ptr [bp - 5]
1FCF  98              cwde
1FD0  D1 E0           shl ax, 1
1FD2  8B F0           mov si, ax
1FD4  D1 E0           shl ax, 1
1FD6  01 F0           add ax, si
1FD8  8B 7E 04        mov di, word ptr [bp + 4]
1FDB  03 F8           add di, ax
1FDD  03 FA           add di, dx
1FDF  36 88 4D AB     mov byte ptr ss:[di - 0x55], cl
loc_1FE3:
1FE3  8B 46 FE        mov ax, word ptr [bp - 2]
1FE6  3B 46 F8        cmp ax, word ptr [bp - 8]
1FE9  74 03           je 0x1fee
1FEB  E9 DB FE        jmp 0x1ec9
loc_1FEE:
1FEE  C9              leave
1FEF  C2 08 00        ret 8

; ---- routine 01EF:1FF2  (found by: call)
sub_1FF2:
1FF2  C8 0A 00 00     enter 0xa, 0
loc_1FF6:
1FF6  C4 7E 06        les di, ptr [bp + 6]
1FF9  06              push es
1FFA  57              push di
1FFB  BF 5C DD        mov di, 0xdd5c
1FFE  1E              push ds
1FFF  57              push di
2000  9A 2F 05 2A 23  call far 232A:052F
2005  BF 76 5A        mov di, 0x5a76
2008  1E              push ds
2009  57              push di
200A  BF 5C DD        mov di, 0xdd5c
200D  1E              push ds
200E  57              push di
200F  9A 2F 05 2A 23  call far 232A:052F
2014  C6 46 FF 00     mov byte ptr [bp - 1], 0
2018  EB 03           jmp 0x201d
loc_201A:
201A  FE 46 FF        inc byte ptr [bp - 1]
loc_201D:
201D  80 7E FF 03     cmp byte ptr [bp - 1], 3
2021  B0 00           mov al, 0
2023  7C 01           jl 0x2026
2025  40              inc ax
loc_2026:
2026  98              cwde
2027  8B F8           mov di, ax
2029  8A 85 12 02     mov al, byte ptr [di + 0x212]
202D  30 E4           xor ah, ah
202F  89 46 FA        mov word ptr [bp - 6], ax
2032  8A 46 FF        mov al, byte ptr [bp - 1]
2035  98              cwde
2036  8B F8           mov di, ax
2038  8A 85 3C A2     mov al, byte ptr [di - 0x5dc4]
203C  50              push ax
203D  8A 46 FF        mov al, byte ptr [bp - 1]
2040  98              cwde
2041  8B F8           mov di, ax
2043  C1 E7 04        shl di, 4
2046  81 C7 E6 DC     add di, 0xdce6
204A  1E              push ds
204B  57              push di
204C  8B 46 FA        mov ax, word ptr [bp - 6]
204F  48              dec ax
2050  50              push ax
2051  8A 46 FF        mov al, byte ptr [bp - 1]
2054  98              cwde
2055  8B F8           mov di, ax
2057  8A 85 14 02     mov al, byte ptr [di + 0x214]
205B  50              push ax
205C  BF 5C DD        mov di, 0xdd5c
205F  1E              push ds
2060  57              push di
2061  9A 1B 04 2A 23  call far 232A:041B
2066  C7 46 FC 01 00  mov word ptr [bp - 4], 1
206B  EB 03           jmp 0x2070
loc_206D:
206D  FF 46 FC        inc word ptr [bp - 4]
loc_2070:
2070  8B 56 FC        mov dx, word ptr [bp - 4]
2073  8A 46 FF        mov al, byte ptr [bp - 1]
2076  98              cwde
2077  D1 E0           shl ax, 1
2079  8B F0           mov si, ax
207B  D1 E0           shl ax, 1
207D  01 F0           add ax, si
207F  C4 7E 0A        les di, ptr [bp + 0xa]
2082  03 F8           add di, ax
2084  03 FA           add di, dx
2086  26 80 7D FF 00  cmp byte ptr es:[di - 1], 0
208B  74 7C           je 0x2109
208D  8B 56 FC        mov dx, word ptr [bp - 4]
2090  8A 46 FF        mov al, byte ptr [bp - 1]
2093  98              cwde
2094  D1 E0           shl ax, 1
2096  8B F0           mov si, ax
2098  D1 E0           shl ax, 1
209A  01 F0           add ax, si
209C  C4 7E 0A        les di, ptr [bp + 0xa]
209F  03 F8           add di, ax
20A1  03 FA           add di, dx
20A3  26 8A 45 FF     mov al, byte ptr es:[di - 1]
20A7  30 E4           xor ah, ah
20A9  6B C0 3E        imul ax, ax, 0x3e
20AC  C4 3E C2 D7     les di, ptr [0xd7c2]
20B0  03 F8           add di, ax
20B2  81 C7 C2 FF     add di, 0xffc2
20B6  89 7E F6        mov word ptr [bp - 0xa], di
20B9  8C 46 F8        mov word ptr [bp - 8], es
20BC  FF 46 FA        inc word ptr [bp - 6]
20BF  26 8A 45 37     mov al, byte ptr es:[di + 0x37]
20C3  88 46 FE        mov byte ptr [bp - 2], al
20C6  8A 46 FF        mov al, byte ptr [bp - 1]
20C9  26 88 45 37     mov byte ptr es:[di + 0x37], al
20CD  8B 56 FC        mov dx, word ptr [bp - 4]
20D0  8A 46 FF        mov al, byte ptr [bp - 1]
20D3  98              cwde
20D4  D1 E0           shl ax, 1
20D6  8B F0           mov si, ax
20D8  D1 E0           shl ax, 1
20DA  01 F0           add ax, si
20DC  C4 7E 0A        les di, ptr [bp + 0xa]
20DF  03 F8           add di, ax
20E1  03 FA           add di, dx
20E3  26 8A 45 FF     mov al, byte ptr es:[di - 1]
20E7  30 E4           xor ah, ah
20E9  50              push ax
20EA  FF 76 FA        push word ptr [bp - 6]
20ED  8A 46 FF        mov al, byte ptr [bp - 1]
20F0  98              cwde
20F1  8B F8           mov di, ax
20F3  8A 85 14 02     mov al, byte ptr [di + 0x214]
20F7  30 E4           xor ah, ah
20F9  50              push ax
20FA  9A E3 0E 55 1B  call far 1B55:0EE3
20FF  8A 46 FE        mov al, byte ptr [bp - 2]
2102  C4 7E F6        les di, ptr [bp - 0xa]
2105  26 88 45 37     mov byte ptr es:[di + 0x37], al
loc_2109:
2109  83 7E FC 06     cmp word ptr [bp - 4], 6
210D  74 03           je 0x2112
210F  E9 5B FF        jmp 0x206d
loc_2112:
2112  80 7E FF 04     cmp byte ptr [bp - 1], 4
2116  74 03           je 0x211b
2118  E9 FF FE        jmp 0x201a
loc_211B:
211B  C4 3E 5C DD     les di, ptr [0xdd5c]
211F  06              push es
2120  57              push di
2121  C4 3E 58 DD     les di, ptr [0xdd58]
2125  06              push es
2126  57              push di
2127  68 A0 0F        push 0xfa0
212A  9A 12 0A C9 26  call far 26C9:0A12
212F  9A 00 00 E8 06  call far 06E8:0000
2134  80 3E 88 DE 0D  cmp byte ptr [0xde88], 0xd
2139  75 03           jne 0x213e
213B  E9 B8 FE        jmp 0x1ff6
loc_213E:
213E  C9              leave
213F  C2 0A 00        ret 0xa

; ---- routine 01EF:2142  (found by: call)
sub_2142:
2142  C8 64 00 00     enter 0x64, 0
2146  8D 7E D6        lea di, [bp - 0x2a]
2149  16              push ss
214A  57              push di
214B  6A 2A           push 0x2a
214D  6A 00           push 0
214F  9A 22 02 BC 24  call far 24BC:0222
2154  8D 7E AC        lea di, [bp - 0x54]
2157  16              push ss
2158  57              push di
2159  6A 2A           push 0x2a
215B  6A 00           push 0
215D  9A 22 02 BC 24  call far 24BC:0222
2162  8D 7E A4        lea di, [bp - 0x5c]
2165  16              push ss
2166  57              push di
2167  6A 07           push 7
2169  6A 00           push 0
216B  9A 22 02 BC 24  call far 24BC:0222
2170  8D 7E 9C        lea di, [bp - 0x64]
2173  16              push ss
2174  57              push di
2175  6A 07           push 7
2177  6A 00           push 0
2179  9A 22 02 BC 24  call far 24BC:0222
217E  6A 01           push 1
2180  6A 10           push 0x10
2182  6A 00           push 0
2184  55              push bp
2185  E8 22 FD        call 0x1eaa
2188  6A 11           push 0x11
218A  6A 20           push 0x20
218C  6A 01           push 1
218E  55              push bp
218F  E8 18 FD        call 0x1eaa
2192  6A 21           push 0x21
2194  6A 30           push 0x30
2196  6A 02           push 2
2198  55              push bp
2199  E8 0E FD        call 0x1eaa
219C  6A 31           push 0x31
219E  6A 40           push 0x40
21A0  6A 03           push 3
21A2  55              push bp
21A3  E8 04 FD        call 0x1eaa
21A6  6A 41           push 0x41
21A8  6A 50           push 0x50
21AA  6A 04           push 4
21AC  55              push bp
21AD  E8 FA FC        call 0x1eaa
21B0  6A 51           push 0x51
21B2  6A 60           push 0x60
21B4  6A 05           push 5
21B6  55              push bp
21B7  E8 F0 FC        call 0x1eaa
21BA  6A 61           push 0x61
21BC  68 B0 00        push 0xb0
21BF  6A 06           push 6
21C1  55              push bp
21C2  E8 E5 FC        call 0x1eaa
21C5  C4 3E D2 D7     les di, ptr [0xd7d2]
21C9  26 80 7D 01 01  cmp byte ptr es:[di + 1], 1
21CE  75 02           jne 0x21d2
21D0  EB 1C           jmp 0x21ee
loc_21D2:
21D2  8D 7E D6        lea di, [bp - 0x2a]
21D5  16              push ss
21D6  57              push di
21D7  BF 10 5E        mov di, 0x5e10
21DA  1E              push ds
21DB  57              push di
21DC  55              push bp
21DD  E8 12 FE        call 0x1ff2
21E0  8D 7E AC        lea di, [bp - 0x54]
21E3  16              push ss
21E4  57              push di
21E5  BF 8A 5A        mov di, 0x5a8a
21E8  1E              push ds
21E9  57              push di
21EA  55              push bp
21EB  E8 04 FE        call 0x1ff2
loc_21EE:
21EE  C9              leave
21EF  CB              retf

; ---- routine 01EF:21F0  (found by: call)
sub_21F0:
21F0  C8 08 00 00     enter 8, 0
21F4  8B 46 08        mov ax, word ptr [bp + 8]
21F7  89 46 FE        mov word ptr [bp - 2], ax
21FA  8B 46 06        mov ax, word ptr [bp + 6]
21FD  89 46 FC        mov word ptr [bp - 4], ax
2200  8B 46 08        mov ax, word ptr [bp + 8]
2203  03 46 06        add ax, word ptr [bp + 6]
2206  D1 E8           shr ax, 1
2208  8B F8           mov di, ax
220A  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
220E  30 E4           xor ah, ah
2210  6B C0 3E        imul ax, ax, 0x3e
2213  C4 3E C2 D7     les di, ptr [0xd7c2]
2217  03 F8           add di, ax
2219  26 8A 45 F6     mov al, byte ptr es:[di - 0xa]
221D  30 E4           xor ah, ah
221F  89 46 F8        mov word ptr [bp - 8], ax
loc_2222:
2222  8B 7E FE        mov di, word ptr [bp - 2]
2225  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
2229  30 E4           xor ah, ah
222B  6B C0 3E        imul ax, ax, 0x3e
222E  C4 3E C2 D7     les di, ptr [0xd7c2]
2232  03 F8           add di, ax
2234  26 8A 45 F6     mov al, byte ptr es:[di - 0xa]
2238  30 E4           xor ah, ah
223A  3B 46 F8        cmp ax, word ptr [bp - 8]
223D  76 05           jbe 0x2244
223F  FF 46 FE        inc word ptr [bp - 2]
2242  EB DE           jmp 0x2222
loc_2244:
2244  8B 7E FC        mov di, word ptr [bp - 4]
2247  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
224B  30 E4           xor ah, ah
224D  6B C0 3E        imul ax, ax, 0x3e
2250  C4 3E C2 D7     les di, ptr [0xd7c2]
2254  03 F8           add di, ax
2256  26 8A 45 F6     mov al, byte ptr es:[di - 0xa]
225A  30 E4           xor ah, ah
225C  3B 46 F8        cmp ax, word ptr [bp - 8]
225F  73 05           jae 0x2266
2261  FF 4E FC        dec word ptr [bp - 4]
2264  EB DE           jmp 0x2244
loc_2266:
2266  8B 46 FE        mov ax, word ptr [bp - 2]
2269  3B 46 FC        cmp ax, word ptr [bp - 4]
226C  77 2A           ja 0x2298
226E  8B 7E FE        mov di, word ptr [bp - 2]
2271  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
2275  30 E4           xor ah, ah
2277  89 46 FA        mov word ptr [bp - 6], ax
227A  8B 7E FC        mov di, word ptr [bp - 4]
227D  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
2281  8B 7E FE        mov di, word ptr [bp - 2]
2284  88 85 D5 D7     mov byte ptr [di - 0x282b], al
2288  8A 46 FA        mov al, byte ptr [bp - 6]
228B  8B 7E FC        mov di, word ptr [bp - 4]
228E  88 85 D5 D7     mov byte ptr [di - 0x282b], al
2292  FF 46 FE        inc word ptr [bp - 2]
2295  FF 4E FC        dec word ptr [bp - 4]
loc_2298:
2298  8B 46 FE        mov ax, word ptr [bp - 2]
229B  3B 46 FC        cmp ax, word ptr [bp - 4]
229E  76 82           jbe 0x2222
22A0  8B 46 08        mov ax, word ptr [bp + 8]
22A3  3B 46 FC        cmp ax, word ptr [bp - 4]
22A6  73 0D           jae 0x22b5
22A8  FF 76 08        push word ptr [bp + 8]
22AB  FF 76 FC        push word ptr [bp - 4]
22AE  8B 7E 04        mov di, word ptr [bp + 4]
22B1  57              push di
22B2  E8 3B FF        call 0x21f0
loc_22B5:
22B5  8B 46 FE        mov ax, word ptr [bp - 2]
22B8  3B 46 06        cmp ax, word ptr [bp + 6]
22BB  73 0D           jae 0x22ca
22BD  FF 76 FE        push word ptr [bp - 2]
22C0  FF 76 06        push word ptr [bp + 6]
22C3  8B 7E 04        mov di, word ptr [bp + 4]
22C6  57              push di
22C7  E8 26 FF        call 0x21f0
loc_22CA:
22CA  C9              leave
22CB  C2 06 00        ret 6

; ---- routine 01EF:22CE  (found by: call)
sub_22CE:
22CE  C8 06 00 00     enter 6, 0
22D2  BF D6 D7        mov di, 0xd7d6
22D5  1E              push ds
22D6  57              push di
22D7  BF FC D4        mov di, 0xd4fc
22DA  1E              push ds
22DB  57              push di
22DC  68 B0 00        push 0xb0
22DF  9A C2 01 BC 24  call far 24BC:01C2
22E4  6A 01           push 1
22E6  68 B0 00        push 0xb0
22E9  55              push bp
22EA  E8 03 FF        call 0x21f0
22ED  C7 46 FE 01 00  mov word ptr [bp - 2], 1
22F2  EB 03           jmp 0x22f7
loc_22F4:
22F4  FF 46 FE        inc word ptr [bp - 2]
loc_22F7:
22F7  8B 7E FE        mov di, word ptr [bp - 2]
22FA  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
22FE  30 E4           xor ah, ah
2300  6B C0 3E        imul ax, ax, 0x3e
2303  C4 3E C2 D7     les di, ptr [0xd7c2]
2307  03 F8           add di, ax
2309  81 C7 C2 FF     add di, 0xffc2
230D  8A 46 FE        mov al, byte ptr [bp - 2]
2310  26 88 45 33     mov byte ptr es:[di + 0x33], al
2314  81 7E FE B0 00  cmp word ptr [bp - 2], 0xb0
2319  75 D9           jne 0x22f4
231B  BF FC D4        mov di, 0xd4fc
231E  1E              push ds
231F  57              push di
2320  BF D6 D7        mov di, 0xd7d6
2323  1E              push ds
2324  57              push di
2325  68 B0 00        push 0xb0
2328  9A 03 02 BC 24  call far 24BC:0203
232D  C9              leave
232E  C3              ret

; ---- routine 01EF:232F  (found by: call)
sub_232F:
232F  C8 06 00 00     enter 6, 0
2333  C7 46 FE 01 00  mov word ptr [bp - 2], 1
2338  EB 03           jmp 0x233d
loc_233A:
233A  FF 46 FE        inc word ptr [bp - 2]
loc_233D:
233D  8B 7E FE        mov di, word ptr [bp - 2]
2340  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
2344  30 E4           xor ah, ah
2346  6B C0 3E        imul ax, ax, 0x3e
2349  C4 3E C2 D7     les di, ptr [0xd7c2]
234D  03 F8           add di, ax
234F  81 C7 C2 FF     add di, 0xffc2
2353  89 7E FA        mov word ptr [bp - 6], di
2356  8C 46 FC        mov word ptr [bp - 4], es
2359  C4 3E D2 D7     les di, ptr [0xd7d2]
235D  26 80 7D 01 01  cmp byte ptr es:[di + 1], 1
2362  74 4C           je 0x23b0
2364  C4 7E FA        les di, ptr [bp - 6]
2367  26 8A 45 33     mov al, byte ptr es:[di + 0x33]
236B  30 E4           xor ah, ah
236D  8B D0           mov dx, ax
236F  26 8A 45 37     mov al, byte ptr es:[di + 0x37]
2373  98              cwde
2374  8B F8           mov di, ax
2376  8A 85 1A 02     mov al, byte ptr [di + 0x21a]
237A  30 E4           xor ah, ah
237C  2B C2           sub ax, dx
237E  8B D0           mov dx, ax
2380  8B 7E FE        mov di, word ptr [bp - 2]
2383  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
2387  30 E4           xor ah, ah
2389  8B F8           mov di, ax
238B  8A 85 35 D9     mov al, byte ptr [di - 0x26cb]
238F  30 E4           xor ah, ah
2391  8B F0           mov si, ax
2393  D1 E0           shl ax, 1
2395  01 F0           add ax, si
2397  05 03 00        add ax, 3
239A  03 C2           add ax, dx
239C  C1 E8 02        shr ax, 2
239F  8A D0           mov dl, al
23A1  8B 7E FE        mov di, word ptr [bp - 2]
23A4  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
23A8  30 E4           xor ah, ah
23AA  8B F8           mov di, ax
23AC  88 95 35 D9     mov byte ptr [di - 0x26cb], dl
loc_23B0:
23B0  81 7E FE B0 00  cmp word ptr [bp - 2], 0xb0
23B5  75 83           jne 0x233a
23B7  C9              leave
23B8  C3              ret

; ---- routine 01EF:23B9  (found by: call)
sub_23B9:
23B9  C8 04 00 00     enter 4, 0
23BD  6B 46 04 3E     imul ax, word ptr [bp + 4], 0x3e
23C1  C4 3E C2 D7     les di, ptr [0xd7c2]
23C5  03 F8           add di, ax
23C7  81 C7 C2 FF     add di, 0xffc2
23CB  89 7E FC        mov word ptr [bp - 4], di
23CE  8C 46 FE        mov word ptr [bp - 2], es
23D1  FF 76 04        push word ptr [bp + 4]
23D4  9A 7A 0E 55 1B  call far 1B55:0E7A
23D9  08 C0           or al, al
23DB  75 3A           jne 0x2417
23DD  C4 7E FC        les di, ptr [bp - 4]
23E0  26 83 7D 2A 00  cmp word ptr es:[di + 0x2a], 0
23E5  74 30           je 0x2417
23E7  26 83 7D 28 00  cmp word ptr es:[di + 0x28], 0
23EC  74 29           je 0x2417
23EE  26 8B 45 28     mov ax, word ptr es:[di + 0x28]
23F2  C1 E0 02        shl ax, 2
23F5  C4 3E C8 DC     les di, ptr [0xdcc8]
23F9  03 F8           add di, ax
23FB  26 8A 55 02     mov dl, byte ptr es:[di + 2]
23FF  C4 7E FC        les di, ptr [bp - 4]
2402  26 8B 45 2A     mov ax, word ptr es:[di + 0x2a]
2406  C1 E0 02        shl ax, 2
2409  C4 3E C8 DC     les di, ptr [0xdcc8]
240D  03 F8           add di, ax
240F  26 8A 45 02     mov al, byte ptr es:[di + 2]
2413  3A C2           cmp al, dl
2415  77 03           ja 0x241a
loc_2417:
2417  E9 C6 00        jmp 0x24e0
loc_241A:
241A  C4 7E FC        les di, ptr [bp - 4]
241D  26 8B 45 2A     mov ax, word ptr es:[di + 0x2a]
2421  C4 3E D4 DC     les di, ptr [0xdcd4]
2425  03 F8           add di, ax
2427  06              push es
2428  57              push di
2429  C4 7E FC        les di, ptr [bp - 4]
242C  26 8B 45 28     mov ax, word ptr es:[di + 0x28]
2430  C4 3E D4 DC     les di, ptr [0xdcd4]
2434  03 F8           add di, ax
2436  06              push es
2437  57              push di
2438  6A 01           push 1
243A  9A 03 02 BC 24  call far 24BC:0203
243F  C4 7E FC        les di, ptr [bp - 4]
2442  26 6B 45 2A 0B  imul ax, word ptr es:[di + 0x2a], 0xb
2447  C4 3E CC DC     les di, ptr [0xdccc]
244B  03 F8           add di, ax
244D  06              push es
244E  57              push di
244F  C4 7E FC        les di, ptr [bp - 4]
2452  26 6B 45 28 0B  imul ax, word ptr es:[di + 0x28], 0xb
2457  C4 3E CC DC     les di, ptr [0xdccc]
245B  03 F8           add di, ax
245D  06              push es
245E  57              push di
245F  6A 0B           push 0xb
2461  9A 03 02 BC 24  call far 24BC:0203
2466  C4 7E FC        les di, ptr [bp - 4]
2469  26 8B 45 2A     mov ax, word ptr es:[di + 0x2a]
246D  C1 E0 02        shl ax, 2
2470  C4 3E C8 DC     les di, ptr [0xdcc8]
2474  03 F8           add di, ax
2476  06              push es
2477  57              push di
2478  C4 7E FC        les di, ptr [bp - 4]
247B  26 8B 45 28     mov ax, word ptr es:[di + 0x28]
247F  C1 E0 02        shl ax, 2
2482  C4 3E C8 DC     les di, ptr [0xdcc8]
2486  03 F8           add di, ax
2488  06              push es
2489  57              push di
248A  6A 04           push 4
248C  9A 03 02 BC 24  call far 24BC:0203
2491  C4 7E FC        les di, ptr [bp - 4]
2494  26 8B 45 2A     mov ax, word ptr es:[di + 0x2a]
2498  C4 3E D0 DC     les di, ptr [0xdcd0]
249C  03 F8           add di, ax
249E  06              push es
249F  57              push di
24A0  C4 7E FC        les di, ptr [bp - 4]
24A3  26 8B 45 28     mov ax, word ptr es:[di + 0x28]
24A7  C4 3E D0 DC     les di, ptr [0xdcd0]
24AB  03 F8           add di, ax
24AD  06              push es
24AE  57              push di
24AF  6A 01           push 1
24B1  9A 03 02 BC 24  call far 24BC:0203
24B6  C4 7E FC        les di, ptr [bp - 4]
24B9  26 8B 45 28     mov ax, word ptr es:[di + 0x28]
24BD  C1 E0 02        shl ax, 2
24C0  C4 3E C8 DC     les di, ptr [0xdcc8]
24C4  03 F8           add di, ax
24C6  26 C6 45 03 00  mov byte ptr es:[di + 3], 0
24CB  C4 7E FC        les di, ptr [bp - 4]
24CE  26 8B 45 2A     mov ax, word ptr es:[di + 0x2a]
24D2  C1 E0 02        shl ax, 2
24D5  C4 3E C8 DC     les di, ptr [0xdcc8]
24D9  03 F8           add di, ax
24DB  26 C6 45 03 01  mov byte ptr es:[di + 3], 1
loc_24E0:
24E0  C9              leave
24E1  C2 02 00        ret 2

