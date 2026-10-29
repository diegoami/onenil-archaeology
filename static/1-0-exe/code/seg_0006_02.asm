; 1-0.EXE (One-Nil 96), code segment 0006 (image offsets 00060..01EEF), part 2 of 3
; packed 1-0.EXE sha256 89ff9c5f238f24e81a0c2440a46cdd8997280a65fc3cc3d97cb974f55280a80a (LZEXE 0.91)
; unpacked (tools/static/unlzexe.py) sha256 887ed2a92767950e5309b2052409f875668605939b69e00737aa3047022b9f51
; tool: capstone 5.0.9 (pip package; core library 5.0.1280) (CS_ARCH_X86, CS_MODE_16), recursive descent from the entry point, far calls and near calls/jumps, then routine prologues (55 89 E5 / 55 8B EC / C8 iw 00) in what remains; tools/static/listing.py
; addresses are SEGMENT:OFFSET with SEGMENT the image paragraph before relocation; image offset = SEGMENT*16+OFFSET
; ---- routine 0006:0AA0  (found by: call)
sub_0AA0:
0AA0  C8 06 00 00     enter 6, 0
0AA4  BF 6C 22        mov di, 0x226c
0AA7  1E              push ds
0AA8  57              push di
0AA9  BF 5C DD        mov di, 0xdd5c
0AAC  1E              push ds
0AAD  57              push di
0AAE  9A 2F 05 2A 23  call far 232A:052F
0AB3  BF B2 49        mov di, 0x49b2
0AB6  1E              push ds
0AB7  57              push di
0AB8  BF 5C DD        mov di, 0xdd5c
0ABB  1E              push ds
0ABC  57              push di
0ABD  9A 2F 05 2A 23  call far 232A:052F
0AC2  C4 3E 5C DD     les di, ptr [0xdd5c]
0AC6  06              push es
0AC7  57              push di
0AC8  C4 3E 58 DD     les di, ptr [0xdd58]
0ACC  06              push es
0ACD  57              push di
0ACE  68 A0 0F        push 0xfa0
0AD1  9A 12 0A C9 26  call far 26C9:0A12
0AD6  FF 76 04        push word ptr [bp + 4]
0AD9  6A 17           push 0x17
0ADB  6A 04           push 4
0ADD  BF 9F 0A        mov di, 0xa9f
0AE0  0E              push cs
0AE1  57              push di
0AE2  6A 00           push 0
0AE4  E8 1B F5        call 2
0AE7  BF 38 31        mov di, 0x3138
0AEA  1E              push ds
0AEB  57              push di
0AEC  BF 5C DD        mov di, 0xdd5c
0AEF  1E              push ds
0AF0  57              push di
0AF1  9A 2F 05 2A 23  call far 232A:052F
0AF6  BF 5E 14        mov di, 0x145e
0AF9  1E              push ds
0AFA  57              push di
0AFB  BF 5C DD        mov di, 0xdd5c
0AFE  1E              push ds
0AFF  57              push di
0B00  9A 2F 05 2A 23  call far 232A:052F
0B05  C4 3E 5C DD     les di, ptr [0xdd5c]
0B09  06              push es
0B0A  57              push di
0B0B  C4 3E 58 DD     les di, ptr [0xdd58]
0B0F  06              push es
0B10  57              push di
0B11  68 A0 0F        push 0xfa0
0B14  9A 12 0A C9 26  call far 26C9:0A12
0B19  8B 46 04        mov ax, word ptr [bp + 4]
0B1C  C4 3E D0 DC     les di, ptr [0xdcd0]
0B20  03 F8           add di, ax
0B22  89 F8           mov ax, di
0B24  8C C2           mov dx, es
0B26  89 46 FC        mov word ptr [bp - 4], ax
0B29  89 56 FE        mov word ptr [bp - 2], dx
0B2C  A0 D8 DC        mov al, byte ptr [0xdcd8]
0B2F  C4 7E FC        les di, ptr [bp - 4]
0B32  26 88 05        mov byte ptr es:[di], al
0B35  C4 7E FC        les di, ptr [bp - 4]
0B38  26 8A 05        mov al, byte ptr es:[di]
0B3B  50              push ax
0B3C  9A 99 1C 55 1B  call far 1B55:1C99
0B41  88 46 FB        mov byte ptr [bp - 5], al
0B44  80 7E FB 00     cmp byte ptr [bp - 5], 0
0B48  74 09           je 0xb53
0B4A  8A 46 FB        mov al, byte ptr [bp - 5]
0B4D  C4 7E FC        les di, ptr [bp - 4]
0B50  26 88 05        mov byte ptr es:[di], al
loc_0B53:
0B53  C9              leave
0B54  C2 02 00        ret 2

; ---- routine 0006:0B57  (found by: far)
sub_0B57:
0B57  C8 04 00 00     enter 4, 0
0B5B  C4 3E D2 D7     les di, ptr [0xd7d2]
0B5F  89 7E FC        mov word ptr [bp - 4], di
0B62  8C 46 FE        mov word ptr [bp - 2], es
0B65  26 C6 45 04 00  mov byte ptr es:[di + 4], 0
loc_0B6A:
0B6A  C4 7E FC        les di, ptr [bp - 4]
0B6D  26 FE 45 04     inc byte ptr es:[di + 4]
0B71  6A 00           push 0
0B73  0E              push cs
0B74  E8 2A FC        call 0x7a1
0B77  C4 7E FC        les di, ptr [bp - 4]
0B7A  26 8A 45 04     mov al, byte ptr es:[di + 4]
0B7E  30 E4           xor ah, ah
0B80  8B F8           mov di, ax
0B82  80 BD B9 DC 00  cmp byte ptr [di - 0x2347], 0
0B87  75 07           jne 0xb90
0B89  31 C0           xor ax, ax
0B8B  9A 16 01 C9 26  call far 26C9:0116
loc_0B90:
0B90  C4 7E FC        les di, ptr [bp - 4]
0B93  26 8A 45 04     mov al, byte ptr es:[di + 4]
0B97  30 E4           xor ah, ah
0B99  8B F8           mov di, ax
0B9B  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
0B9F  30 E4           xor ah, ah
0BA1  6B C0 3E        imul ax, ax, 0x3e
0BA4  C4 3E C2 D7     les di, ptr [0xd7c2]
0BA8  03 F8           add di, ax
0BAA  26 8B 55 EA     mov dx, word ptr es:[di - 0x16]
0BAE  C4 7E FC        les di, ptr [bp - 4]
0BB1  26 8A 45 04     mov al, byte ptr es:[di + 4]
0BB5  30 E4           xor ah, ah
0BB7  D1 E0           shl ax, 1
0BB9  03 F8           add di, ax
0BBB  26 89 55 03     mov word ptr es:[di + 3], dx
0BBF  C4 7E FC        les di, ptr [bp - 4]
0BC2  26 8A 45 04     mov al, byte ptr es:[di + 4]
0BC6  30 E4           xor ah, ah
0BC8  D1 E0           shl ax, 1
0BCA  03 F8           add di, ax
0BCC  26 FF 75 03     push word ptr es:[di + 3]
0BD0  E8 CD FE        call 0xaa0
0BD3  C4 7E FC        les di, ptr [bp - 4]
0BD6  26 8A 45 04     mov al, byte ptr es:[di + 4]
0BDA  30 E4           xor ah, ah
0BDC  8B F8           mov di, ax
0BDE  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
0BE2  30 E4           xor ah, ah
0BE4  6B C0 3E        imul ax, ax, 0x3e
0BE7  C4 3E C2 D7     les di, ptr [0xd7c2]
0BEB  03 F8           add di, ax
0BED  26 C6 45 FC 01  mov byte ptr es:[di - 4], 1
0BF2  C4 7E FC        les di, ptr [bp - 4]
0BF5  26 8A 45 04     mov al, byte ptr es:[di + 4]
0BF9  30 E4           xor ah, ah
0BFB  50              push ax
0BFC  9A E1 27 EF 01  call far 01EF:27E1
0C01  C4 7E FC        les di, ptr [bp - 4]
0C04  26 8A 45 04     mov al, byte ptr es:[di + 4]
0C08  26 3A 45 03     cmp al, byte ptr es:[di + 3]
0C0C  74 03           je 0xc11
0C0E  E9 59 FF        jmp 0xb6a
loc_0C11:
0C11  26 C6 45 04 01  mov byte ptr es:[di + 4], 1
0C16  C9              leave
0C17  CB              retf
; data (not reached as code), 6 bytes
0C18                  db 01 2F 01 28 01 29   ; ./.(.)

; ---- routine 0006:0C1E  (found by: call)
sub_0C1E:
0C1E  C8 0E 02 00     enter 0x20e, 0
0C22  BF 7A 4B        mov di, 0x4b7a
0C25  1E              push ds
0C26  57              push di
0C27  BF 5C DD        mov di, 0xdd5c
0C2A  1E              push ds
0C2B  57              push di
0C2C  9A 2F 05 2A 23  call far 232A:052F
0C31  C7 46 FC 03 00  mov word ptr [bp - 4], 3
0C36  B8 7E 7C        mov ax, 0x7c7e
0C39  8C DA           mov dx, ds
0C3B  89 46 F8        mov word ptr [bp - 8], ax
0C3E  89 56 FA        mov word ptr [bp - 6], dx
0C41  8B 46 FC        mov ax, word ptr [bp - 4]
0C44  48              dec ax
0C45  6B C0 50        imul ax, ax, 0x50
0C48  40              inc ax
0C49  40              inc ax
0C4A  C4 7E F8        les di, ptr [bp - 8]
0C4D  26 89 05        mov word ptr es:[di], ax
0C50  8B 7E 04        mov di, word ptr [bp + 4]
0C53  36 8B 45 FC     mov ax, word ptr ss:[di - 4]
0C57  05 06 00        add ax, 6
0C5A  89 46 F6        mov word ptr [bp - 0xa], ax
0C5D  36 8B 45 FC     mov ax, word ptr ss:[di - 4]
0C61  3B 46 F6        cmp ax, word ptr [bp - 0xa]
0C64  76 03           jbe 0xc69
0C66  E9 0E 03        jmp 0xf77
loc_0C69:
0C69  89 46 FE        mov word ptr [bp - 2], ax
0C6C  EB 03           jmp 0xc71
loc_0C6E:
0C6E  FF 46 FE        inc word ptr [bp - 2]
loc_0C71:
0C71  8B 7E 04        mov di, word ptr [bp + 4]
0C74  36 8B 45 FE     mov ax, word ptr ss:[di - 2]
0C78  99              cdq
0C79  8B C8           mov cx, ax
0C7B  8B DA           mov bx, dx
0C7D  8B 46 FE        mov ax, word ptr [bp - 2]
0C80  31 D2           xor dx, dx
0C82  3B D3           cmp dx, bx
0C84  7C 0C           jl 0xc92
0C86  7E 03           jle 0xc8b
0C88  E9 E1 02        jmp 0xf6c
loc_0C8B:
0C8B  3B C1           cmp ax, cx
0C8D  76 03           jbe 0xc92
0C8F  E9 DA 02        jmp 0xf6c
loc_0C92:
0C92  6B 46 FE 12     imul ax, word ptr [bp - 2], 0x12
0C96  8B D0           mov dx, ax
0C98  C4 3E D2 D7     les di, ptr [0xd7d2]
0C9C  26 8A 45 04     mov al, byte ptr es:[di + 4]
0CA0  30 E4           xor ah, ah
0CA2  69 C0 3A 23     imul ax, ax, 0x233a
0CA6  C4 3E E2 DC     les di, ptr [0xdce2]
0CAA  03 F8           add di, ax
0CAC  03 FA           add di, dx
0CAE  81 C7 C6 DC     add di, 0xdcc6
0CB2  89 7E F2        mov word ptr [bp - 0xe], di
0CB5  8C 46 F4        mov word ptr [bp - 0xc], es
0CB8  26 80 7D 05 0E  cmp byte ptr es:[di + 5], 0xe
0CBD  77 03           ja 0xcc2
0CBF  E9 AA 02        jmp 0xf6c
loc_0CC2:
0CC2  BF 7E 7C        mov di, 0x7c7e
0CC5  1E              push ds
0CC6  57              push di
0CC7  BF 5C DD        mov di, 0xdd5c
0CCA  1E              push ds
0CCB  57              push di
0CCC  9A 2F 05 2A 23  call far 232A:052F
0CD1  C4 7E F2        les di, ptr [bp - 0xe]
0CD4  26 8A 45 03     mov al, byte ptr es:[di + 3]
0CD8  98              cwde
0CD9  8B F8           mov di, ax
0CDB  8A 85 12 00     mov al, byte ptr [di + 0x12]
0CDF  50              push ax
0CE0  8D BE F2 FE     lea di, [bp - 0x10e]
0CE4  16              push ss
0CE5  57              push di
0CE6  A1 DA DC        mov ax, word ptr [0xdcda]
0CE9  C4 7E F2        les di, ptr [bp - 0xe]
0CEC  26 03 45 0F     add ax, word ptr es:[di + 0xf]
0CF0  48              dec ax
0CF1  48              dec ax
0CF2  31 D2           xor dx, dx
0CF4  52              push dx
0CF5  50              push ax
0CF6  9A C9 07 2A 23  call far 232A:07C9
0CFB  BF 18 0C        mov di, 0xc18
0CFE  0E              push cs
0CFF  57              push di
0D00  9A D2 0B C9 26  call far 26C9:0BD2
0D05  8D BE F2 FD     lea di, [bp - 0x20e]
0D09  16              push ss
0D0A  57              push di
0D0B  A1 DA DC        mov ax, word ptr [0xdcda]
0D0E  C4 7E F2        les di, ptr [bp - 0xe]
0D11  26 03 45 0F     add ax, word ptr es:[di + 0xf]
0D15  48              dec ax
0D16  50              push ax
0D17  9A C1 00 55 1B  call far 1B55:00C1
0D1C  9A D2 0B C9 26  call far 26C9:0BD2
0D21  8A 46 FC        mov al, byte ptr [bp - 4]
0D24  50              push ax
0D25  6A 02           push 2
0D27  BF 5C DD        mov di, 0xdd5c
0D2A  1E              push ds
0D2B  57              push di
0D2C  9A 1B 04 2A 23  call far 232A:041B
0D31  8D BE F2 FE     lea di, [bp - 0x10e]
0D35  16              push ss
0D36  57              push di
0D37  C4 7E F2        les di, ptr [bp - 0xe]
0D3A  26 8A 45 11     mov al, byte ptr es:[di + 0x11]
0D3E  30 E4           xor ah, ah
0D40  31 D2           xor dx, dx
0D42  52              push dx
0D43  50              push ax
0D44  9A C9 07 2A 23  call far 232A:07C9
0D49  8A 46 FC        mov al, byte ptr [bp - 4]
0D4C  50              push ax
0D4D  6A 10           push 0x10
0D4F  BF 5C DD        mov di, 0xdd5c
0D52  1E              push ds
0D53  57              push di
0D54  9A 9D 03 2A 23  call far 232A:039D
0D59  C4 7E F2        les di, ptr [bp - 0xe]
0D5C  26 8A 45 03     mov al, byte ptr es:[di + 3]
0D60  98              cwde
0D61  6B F8 07        imul di, ax, 7
0D64  81 C7 04 00     add di, 4
0D68  1E              push ds
0D69  57              push di
0D6A  8A 46 FC        mov al, byte ptr [bp - 4]
0D6D  50              push ax
0D6E  6A 13           push 0x13
0D70  BF 5C DD        mov di, 0xdd5c
0D73  1E              push ds
0D74  57              push di
0D75  9A 9D 03 2A 23  call far 232A:039D
0D7A  8D BE F2 FE     lea di, [bp - 0x10e]
0D7E  16              push ss
0D7F  57              push di
0D80  C4 7E F2        les di, ptr [bp - 0xe]
0D83  26 8A 05        mov al, byte ptr es:[di]
0D86  50              push ax
0D87  9A 6F 0C C9 26  call far 26C9:0C6F
0D8C  8A 46 FC        mov al, byte ptr [bp - 4]
0D8F  50              push ax
0D90  6A 1A           push 0x1a
0D92  BF 5C DD        mov di, 0xdd5c
0D95  1E              push ds
0D96  57              push di
0D97  9A 9D 03 2A 23  call far 232A:039D
0D9C  8D BE F2 FE     lea di, [bp - 0x10e]
0DA0  16              push ss
0DA1  57              push di
0DA2  C4 7E F2        les di, ptr [bp - 0xe]
0DA5  26 FF 75 01     push word ptr es:[di + 1]
0DA9  9A DC 44 55 1B  call far 1B55:44DC
0DAE  8A 46 FC        mov al, byte ptr [bp - 4]
0DB1  50              push ax
0DB2  6A 1C           push 0x1c
0DB4  BF 5C DD        mov di, 0xdd5c
0DB7  1E              push ds
0DB8  57              push di
0DB9  9A 9D 03 2A 23  call far 232A:039D
0DBE  C4 7E F2        les di, ptr [bp - 0xe]
0DC1  26 8A 45 03     mov al, byte ptr es:[di + 3]
0DC5  98              cwde
0DC6  8B F8           mov di, ax
0DC8  8B F7           mov si, di
0DCA  D1 E7           shl di, 1
0DCC  D1 E7           shl di, 1
0DCE  01 F7           add di, si
0DD0  81 C7 14 00     add di, 0x14
0DD4  1E              push ds
0DD5  57              push di
0DD6  8A 46 FC        mov al, byte ptr [bp - 4]
0DD9  50              push ax
0DDA  6A 27           push 0x27
0DDC  BF 5C DD        mov di, 0xdd5c
0DDF  1E              push ds
0DE0  57              push di
0DE1  9A 9D 03 2A 23  call far 232A:039D
0DE6  C4 7E F2        les di, ptr [bp - 0xe]
0DE9  26 8A 45 04     mov al, byte ptr es:[di + 4]
0DED  30 E4           xor ah, ah
0DEF  C1 E0 04        shl ax, 4
0DF2  C4 3E B2 D7     les di, ptr [0xd7b2]
0DF6  03 F8           add di, ax
0DF8  81 C7 F0 FF     add di, 0xfff0
0DFC  06              push es
0DFD  57              push di
0DFE  8A 46 FC        mov al, byte ptr [bp - 4]
0E01  50              push ax
0E02  6A 2C           push 0x2c
0E04  BF 5C DD        mov di, 0xdd5c
0E07  1E              push ds
0E08  57              push di
0E09  9A 9D 03 2A 23  call far 232A:039D
0E0E  8D BE F2 FE     lea di, [bp - 0x10e]
0E12  16              push ss
0E13  57              push di
0E14  C4 7E F2        les di, ptr [bp - 0xe]
0E17  26 FF 75 09     push word ptr es:[di + 9]
0E1B  26 FF 75 07     push word ptr es:[di + 7]
0E1F  9A 95 0F 55 1B  call far 1B55:0F95
0E24  8A 46 FC        mov al, byte ptr [bp - 4]
0E27  50              push ax
0E28  6A 40           push 0x40
0E2A  BF 5C DD        mov di, 0xdd5c
0E2D  1E              push ds
0E2E  57              push di
0E2F  9A 9D 03 2A 23  call far 232A:039D
0E34  8D BE F2 FE     lea di, [bp - 0x10e]
0E38  16              push ss
0E39  57              push di
0E3A  C4 7E F2        les di, ptr [bp - 0xe]
0E3D  26 8A 45 05     mov al, byte ptr es:[di + 5]
0E41  30 E4           xor ah, ah
0E43  31 D2           xor dx, dx
0E45  52              push dx
0E46  50              push ax
0E47  9A C9 07 2A 23  call far 232A:07C9
0E4C  8B 46 FC        mov ax, word ptr [bp - 4]
0E4F  40              inc ax
0E50  50              push ax
0E51  6A 0A           push 0xa
0E53  BF 5C DD        mov di, 0xdd5c
0E56  1E              push ds
0E57  57              push di
0E58  9A 9D 03 2A 23  call far 232A:039D
0E5D  8D BE F2 FE     lea di, [bp - 0x10e]
0E61  16              push ss
0E62  57              push di
0E63  C4 7E F2        les di, ptr [bp - 0xe]
0E66  26 8B 45 0B     mov ax, word ptr es:[di + 0xb]
0E6A  31 D2           xor dx, dx
0E6C  52              push dx
0E6D  50              push ax
0E6E  9A C9 07 2A 23  call far 232A:07C9
0E73  8B 46 FC        mov ax, word ptr [bp - 4]
0E76  40              inc ax
0E77  50              push ax
0E78  6A 18           push 0x18
0E7A  BF 5C DD        mov di, 0xdd5c
0E7D  1E              push ds
0E7E  57              push di
0E7F  9A 9D 03 2A 23  call far 232A:039D
0E84  C4 7E F2        les di, ptr [bp - 0xe]
0E87  26 80 7D 06 00  cmp byte ptr es:[di + 6], 0
0E8C  75 48           jne 0xed6
0E8E  8D BE F2 FD     lea di, [bp - 0x20e]
0E92  16              push ss
0E93  57              push di
0E94  BF 1A 0C        mov di, 0xc1a
0E97  0E              push cs
0E98  57              push di
0E99  9A 53 0B C9 26  call far 26C9:0B53
0E9E  8D BE F2 FE     lea di, [bp - 0x10e]
0EA2  16              push ss
0EA3  57              push di
0EA4  C4 7E F2        les di, ptr [bp - 0xe]
0EA7  26 8B 45 0D     mov ax, word ptr es:[di + 0xd]
0EAB  31 D2           xor dx, dx
0EAD  52              push dx
0EAE  50              push ax
0EAF  9A C9 07 2A 23  call far 232A:07C9
0EB4  9A D2 0B C9 26  call far 26C9:0BD2
0EB9  BF 1C 0C        mov di, 0xc1c
0EBC  0E              push cs
0EBD  57              push di
0EBE  9A D2 0B C9 26  call far 26C9:0BD2
0EC3  8B 46 FC        mov ax, word ptr [bp - 4]
0EC6  40              inc ax
0EC7  50              push ax
0EC8  6A 23           push 0x23
0ECA  BF 5C DD        mov di, 0xdd5c
0ECD  1E              push ds
0ECE  57              push di
0ECF  9A 9D 03 2A 23  call far 232A:039D
0ED4  EB 27           jmp 0xefd
loc_0ED6:
0ED6  8D BE F2 FE     lea di, [bp - 0x10e]
0EDA  16              push ss
0EDB  57              push di
0EDC  C4 7E F2        les di, ptr [bp - 0xe]
0EDF  26 8B 45 0D     mov ax, word ptr es:[di + 0xd]
0EE3  31 D2           xor dx, dx
0EE5  52              push dx
0EE6  50              push ax
0EE7  9A C9 07 2A 23  call far 232A:07C9
0EEC  8B 46 FC        mov ax, word ptr [bp - 4]
0EEF  40              inc ax
0EF0  50              push ax
0EF1  6A 23           push 0x23
0EF3  BF 5C DD        mov di, 0xdd5c
0EF6  1E              push ds
0EF7  57              push di
0EF8  9A 9D 03 2A 23  call far 232A:039D
loc_0EFD:
0EFD  C4 7E F2        les di, ptr [bp - 0xe]
0F00  26 8A 45 06     mov al, byte ptr es:[di + 6]
0F04  30 E4           xor ah, ah
0F06  50              push ax
0F07  26 FF 75 0D     push word ptr es:[di + 0xd]
0F0B  26 FF 75 0B     push word ptr es:[di + 0xb]
0F0F  8B 46 FC        mov ax, word ptr [bp - 4]
0F12  40              inc ax
0F13  50              push ax
0F14  26 80 7D 06 00  cmp byte ptr es:[di + 6], 0
0F19  B0 00           mov al, 0
0F1B  75 01           jne 0xf1e
0F1D  40              inc ax
loc_0F1E:
0F1E  98              cwde
0F1F  8B F8           mov di, ax
0F21  8A 85 1E 00     mov al, byte ptr [di + 0x1e]
0F25  30 E4           xor ah, ah
0F27  50              push ax
0F28  9A 9E 0B 98 19  call far 1998:0B9E
0F2D  C4 7E F2        les di, ptr [bp - 0xe]
0F30  26 8A 45 06     mov al, byte ptr es:[di + 6]
0F34  30 E4           xor ah, ah
0F36  8B F8           mov di, ax
0F38  8A 85 08 87     mov al, byte ptr [di - 0x78f8]
0F3C  50              push ax
0F3D  C4 7E F2        les di, ptr [bp - 0xe]
0F40  26 8A 45 06     mov al, byte ptr es:[di + 6]
0F44  30 E4           xor ah, ah
0F46  6B F8 13        imul di, ax, 0x13
0F49  81 C7 24 87     add di, 0x8724
0F4D  1E              push ds
0F4E  57              push di
0F4F  8B 46 FC        mov ax, word ptr [bp - 4]
0F52  40              inc ax
0F53  50              push ax
0F54  6A 3C           push 0x3c
0F56  BF 5C DD        mov di, 0xdd5c
0F59  1E              push ds
0F5A  57              push di
0F5B  9A 1B 04 2A 23  call far 232A:041B
0F60  83 46 FC 03     add word ptr [bp - 4], 3
0F64  C4 7E F8        les di, ptr [bp - 8]
0F67  26 81 05 F0 00  add word ptr es:[di], 0xf0
loc_0F6C:
0F6C  8B 46 FE        mov ax, word ptr [bp - 2]
0F6F  3B 46 F6        cmp ax, word ptr [bp - 0xa]
0F72  74 03           je 0xf77
0F74  E9 F7 FC        jmp 0xc6e
loc_0F77:
0F77  C9              leave
0F78  C2 02 00        ret 2

; ---- routine 0006:0F7B  (found by: call)
sub_0F7B:
0F7B  C8 06 00 00     enter 6, 0
0F7F  31 C0           xor ax, ax
0F81  89 46 FE        mov word ptr [bp - 2], ax
0F84  C7 46 FA 01 00  mov word ptr [bp - 6], 1
0F89  EB 03           jmp 0xf8e
loc_0F8B:
0F8B  FF 46 FA        inc word ptr [bp - 6]
loc_0F8E:
0F8E  6B 46 FA 12     imul ax, word ptr [bp - 6], 0x12
0F92  8B D0           mov dx, ax
0F94  C4 3E D2 D7     les di, ptr [0xd7d2]
0F98  26 8A 45 04     mov al, byte ptr es:[di + 4]
0F9C  30 E4           xor ah, ah
0F9E  69 C0 3A 23     imul ax, ax, 0x233a
0FA2  C4 3E E2 DC     les di, ptr [0xdce2]
0FA6  03 F8           add di, ax
0FA8  03 FA           add di, dx
0FAA  26 83 BD D5 DC 00 cmp word ptr es:[di - 0x232b], 0
0FB0  74 06           je 0xfb8
0FB2  8B 46 FA        mov ax, word ptr [bp - 6]
0FB5  89 46 FE        mov word ptr [bp - 2], ax
loc_0FB8:
0FB8  81 7E FA F4 01  cmp word ptr [bp - 6], 0x1f4
0FBD  75 CC           jne 0xf8b
0FBF  C7 46 FC 01 00  mov word ptr [bp - 4], 1
loc_0FC4:
0FC4  55              push bp
0FC5  E8 56 FC        call 0xc1e
0FC8  C4 3E 5C DD     les di, ptr [0xdd5c]
0FCC  06              push es
0FCD  57              push di
0FCE  C4 3E 58 DD     les di, ptr [0xdd58]
0FD2  06              push es
0FD3  57              push di
0FD4  68 A0 0F        push 0xfa0
0FD7  9A 12 0A C9 26  call far 26C9:0A12
0FDC  9A 9B 09 2A 23  call far 232A:099B
0FE1  A0 88 DE        mov al, byte ptr [0xde88]
0FE4  3C 0B           cmp al, 0xb
0FE6  75 14           jne 0xffc
0FE8  83 7E FC 07     cmp word ptr [bp - 4], 7
0FEC  7E 06           jle 0xff4
0FEE  83 6E FC 07     sub word ptr [bp - 4], 7
0FF2  EB 05           jmp 0xff9
loc_0FF4:
0FF4  C7 46 FC 01 00  mov word ptr [bp - 4], 1
loc_0FF9:
0FF9  E9 82 00        jmp 0x107e
loc_0FFC:
0FFC  3C 0C           cmp al, 0xc
0FFE  75 2F           jne 0x102f
1000  8B 46 FE        mov ax, word ptr [bp - 2]
1003  2D 06 00        sub ax, 6
1006  8B D0           mov dx, ax
1008  8B 46 FC        mov ax, word ptr [bp - 4]
100B  05 07 00        add ax, 7
100E  3B C2           cmp ax, dx
1010  7D 06           jge 0x1018
1012  83 46 FC 07     add word ptr [bp - 4], 7
1016  EB 15           jmp 0x102d
loc_1018:
1018  6A 00           push 0
101A  6A 01           push 1
101C  8B 46 FE        mov ax, word ptr [bp - 2]
101F  2D 06 00        sub ax, 6
1022  99              cdq
1023  52              push dx
1024  50              push ax
1025  9A C0 04 BC 24  call far 24BC:04C0
102A  89 46 FC        mov word ptr [bp - 4], ax
loc_102D:
102D  EB 4F           jmp 0x107e
loc_102F:
102F  3C 09           cmp al, 9
1031  75 07           jne 0x103a
1033  C7 46 FC 01 00  mov word ptr [bp - 4], 1
1038  EB 44           jmp 0x107e
loc_103A:
103A  3C 0A           cmp al, 0xa
103C  75 17           jne 0x1055
103E  6A 00           push 0
1040  6A 01           push 1
1042  8B 46 FE        mov ax, word ptr [bp - 2]
1045  2D 06 00        sub ax, 6
1048  99              cdq
1049  52              push dx
104A  50              push ax
104B  9A C0 04 BC 24  call far 24BC:04C0
1050  89 46 FC        mov word ptr [bp - 4], ax
1053  EB 29           jmp 0x107e
loc_1055:
1055  3C 02           cmp al, 2
1057  75 08           jne 0x1061
1059  6A 03           push 3
105B  0E              push cs
105C  E8 42 F7        call 0x7a1
105F  EB 1D           jmp 0x107e
loc_1061:
1061  8D 7E FC        lea di, [bp - 4]
1064  16              push ss
1065  57              push di
1066  6A 00           push 0
1068  6A 01           push 1
106A  8B 46 FE        mov ax, word ptr [bp - 2]
106D  2D 06 00        sub ax, 6
1070  99              cdq
1071  52              push dx
1072  50              push ax
1073  9A C0 04 BC 24  call far 24BC:04C0
1078  50              push ax
1079  9A 16 0F 2A 23  call far 232A:0F16
loc_107E:
107E  80 3E 88 DE 01  cmp byte ptr [0xde88], 1
1083  74 03           je 0x1088
1085  E9 3C FF        jmp 0xfc4
loc_1088:
1088  C6 06 88 DE 00  mov byte ptr [0xde88], 0
108D  C9              leave
108E  C3              ret

; ---- routine 0006:108F  (found by: call)
sub_108F:
108F  C8 00 01 00     enter 0x100, 0
1093  6A 0E           push 0xe
1095  8D BE 00 FF     lea di, [bp - 0x100]
1099  16              push ss
109A  57              push di
109B  8A 46 08        mov al, byte ptr [bp + 8]
109E  98              cwde
109F  8B F8           mov di, ax
10A1  8A 85 EA A2     mov al, byte ptr [di - 0x5d16]
10A5  50              push ax
10A6  9A 6F 0C C9 26  call far 26C9:0C6F
10AB  8A 46 06        mov al, byte ptr [bp + 6]
10AE  50              push ax
10AF  6A 4F           push 0x4f
10B1  BF 5C DD        mov di, 0xdd5c
10B4  1E              push ds
10B5  57              push di
10B6  9A 1B 04 2A 23  call far 232A:041B
10BB  C9              leave
10BC  C2 06 00        ret 6

; ---- routine 0006:10BF  (found by: call)
sub_10BF:
10BF  C8 0A 00 00     enter 0xa, 0
10C3  C4 3E D2 D7     les di, ptr [0xd7d2]
10C7  C4 3E D2 D7     les di, ptr [0xd7d2]
10CB  26 8D 85 F2 00  lea ax, es:[di + 0xf2]
10D0  8C C2           mov dx, es
10D2  89 46 FC        mov word ptr [bp - 4], ax
10D5  89 56 FE        mov word ptr [bp - 2], dx
10D8  BF 5E 14        mov di, 0x145e
10DB  1E              push ds
10DC  57              push di
10DD  BF 5C DD        mov di, 0xdd5c
10E0  1E              push ds
10E1  57              push di
10E2  9A 2F 05 2A 23  call far 232A:052F
loc_10E7:
10E7  BF E8 49        mov di, 0x49e8
10EA  1E              push ds
10EB  57              push di
10EC  BF 5C DD        mov di, 0xdd5c
10EF  1E              push ds
10F0  57              push di
10F1  9A 2F 05 2A 23  call far 232A:052F
10F6  A0 20 00        mov al, byte ptr [0x20]
10F9  30 E4           xor ah, ah
10FB  8B F8           mov di, ax
10FD  8A 85 21 00     mov al, byte ptr [di + 0x21]
1101  30 E4           xor ah, ah
1103  50              push ax
1104  6A 3A           push 0x3a
1106  6A 14           push 0x14
1108  9A 03 02 2A 23  call far 232A:0203
110D  C7 46 FA 01 00  mov word ptr [bp - 6], 1
1112  EB 03           jmp 0x1117
loc_1114:
1114  FF 46 FA        inc word ptr [bp - 6]
loc_1117:
1117  8B 46 FA        mov ax, word ptr [bp - 6]
111A  C4 7E FC        les di, ptr [bp - 4]
111D  03 F8           add di, ax
111F  26 8A 45 FF     mov al, byte ptr es:[di - 1]
1123  50              push ax
1124  8B 7E FA        mov di, word ptr [bp - 6]
1127  8A 85 21 00     mov al, byte ptr [di + 0x21]
112B  30 E4           xor ah, ah
112D  50              push ax
112E  55              push bp
112F  E8 5D FF        call 0x108f
1132  83 7E FA 05     cmp word ptr [bp - 6], 5
1136  75 DC           jne 0x1114
1138  6A 01           push 1
113A  A0 27 00        mov al, byte ptr [0x27]
113D  30 E4           xor ah, ah
113F  50              push ax
1140  55              push bp
1141  E8 4B FF        call 0x108f
1144  BF 20 00        mov di, 0x20
1147  1E              push ds
1148  57              push di
1149  6A 06           push 6
114B  9A 8B 0F 2A 23  call far 232A:0F8B
1150  80 3E 88 DE 02  cmp byte ptr [0xde88], 2
1155  75 32           jne 0x1189
1157  80 3E 20 00 06  cmp byte ptr [0x20], 6
115C  75 07           jne 0x1165
115E  C6 06 88 DE 01  mov byte ptr [0xde88], 1
1163  EB 24           jmp 0x1189
loc_1165:
1165  A0 20 00        mov al, byte ptr [0x20]
1168  30 E4           xor ah, ah
116A  C4 7E FC        les di, ptr [bp - 4]
116D  03 F8           add di, ax
116F  26 80 7D FF 00  cmp byte ptr es:[di - 1], 0
1174  B0 00           mov al, 0
1176  75 01           jne 0x1179
1178  40              inc ax
loc_1179:
1179  8A D0           mov dl, al
117B  A0 20 00        mov al, byte ptr [0x20]
117E  30 E4           xor ah, ah
1180  C4 7E FC        les di, ptr [bp - 4]
1183  03 F8           add di, ax
1185  26 88 55 FF     mov byte ptr es:[di - 1], dl
loc_1189:
1189  80 3E 88 DE 01  cmp byte ptr [0xde88], 1
118E  74 03           je 0x1193
1190  E9 54 FF        jmp 0x10e7
loc_1193:
1193  C9              leave
1194  C3              ret
; data (not reached as code), 2 bytes
1195                  db 01 2F   ; ./

; ---- routine 0006:1197  (found by: call)
sub_1197:
1197  C8 06 02 00     enter 0x206, 0
119B  C4 3E D2 D7     les di, ptr [0xd7d2]
119F  89 7E FA        mov word ptr [bp - 6], di
11A2  8C 46 FC        mov word ptr [bp - 4], es
11A5  BF C4 69        mov di, 0x69c4
11A8  1E              push ds
11A9  57              push di
11AA  BF 5C DD        mov di, 0xdd5c
11AD  1E              push ds
11AE  57              push di
11AF  9A 2F 05 2A 23  call far 232A:052F
11B4  C4 7E FA        les di, ptr [bp - 6]
11B7  26 8A 45 04     mov al, byte ptr es:[di + 4]
11BB  30 E4           xor ah, ah
11BD  8B F8           mov di, ax
11BF  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
11C3  30 E4           xor ah, ah
11C5  89 46 FE        mov word ptr [bp - 2], ax
11C8  6A 07           push 7
11CA  C4 7E FA        les di, ptr [bp - 6]
11CD  26 8A 45 04     mov al, byte ptr es:[di + 4]
11D1  30 E4           xor ah, ah
11D3  D1 E0           shl ax, 1
11D5  03 F8           add di, ax
11D7  26 6B 45 03 0B  imul ax, word ptr es:[di + 3], 0xb
11DC  C4 3E CC DC     les di, ptr [0xdccc]
11E0  03 F8           add di, ax
11E2  06              push es
11E3  57              push di
11E4  6A 05           push 5
11E6  6A 03           push 3
11E8  BF 5C DD        mov di, 0xdd5c
11EB  1E              push ds
11EC  57              push di
11ED  9A 1B 04 2A 23  call far 232A:041B
11F2  C4 7E FA        les di, ptr [bp - 6]
11F5  26 8A 45 04     mov al, byte ptr es:[di + 4]
11F9  30 E4           xor ah, ah
11FB  8B F8           mov di, ax
11FD  80 BD B9 DC 00  cmp byte ptr [di - 0x2347], 0
1202  75 03           jne 0x1207
1204  E9 42 02        jmp 0x1449
loc_1207:
1207  8D BE FA FE     lea di, [bp - 0x106]
120B  16              push ss
120C  57              push di
120D  C4 7E FA        les di, ptr [bp - 6]
1210  26 8A 45 04     mov al, byte ptr es:[di + 4]
1214  30 E4           xor ah, ah
1216  6B C0 5E        imul ax, ax, 0x5e
1219  C4 3E C4 DC     les di, ptr [0xdcc4]
121D  03 F8           add di, ax
121F  26 FF 75 F6     push word ptr es:[di - 0xa]
1223  26 FF 75 F4     push word ptr es:[di - 0xc]
1227  9A 95 0F 55 1B  call far 1B55:0F95
122C  6A 07           push 7
122E  6A 03           push 3
1230  BF 5C DD        mov di, 0xdd5c
1233  1E              push ds
1234  57              push di
1235  9A 9D 03 2A 23  call far 232A:039D
123A  FF 76 FE        push word ptr [bp - 2]
123D  6A 03           push 3
123F  6A 03           push 3
1241  9A E3 0E 55 1B  call far 1B55:0EE3
1246  8D BE FA FE     lea di, [bp - 0x106]
124A  16              push ss
124B  57              push di
124C  6B 46 FE 3E     imul ax, word ptr [bp - 2], 0x3e
1250  C4 3E C2 D7     les di, ptr [0xd7c2]
1254  03 F8           add di, ax
1256  26 8A 45 F8     mov al, byte ptr es:[di - 8]
125A  30 E4           xor ah, ah
125C  31 D2           xor dx, dx
125E  52              push dx
125F  50              push ax
1260  9A C9 07 2A 23  call far 232A:07C9
1265  6A 08           push 8
1267  6A 11           push 0x11
1269  BF 5C DD        mov di, 0xdd5c
126C  1E              push ds
126D  57              push di
126E  9A 83 02 2A 23  call far 232A:0283
1273  6A 0B           push 0xb
1275  8D BE FA FE     lea di, [bp - 0x106]
1279  16              push ss
127A  57              push di
127B  C4 7E FA        les di, ptr [bp - 6]
127E  26 8A 45 01     mov al, byte ptr es:[di + 1]
1282  30 E4           xor ah, ah
1284  03 06 DA DC     add ax, word ptr [0xdcda]
1288  48              dec ax
1289  48              dec ax
128A  31 D2           xor dx, dx
128C  52              push dx
128D  50              push ax
128E  9A C9 07 2A 23  call far 232A:07C9
1293  BF 95 11        mov di, 0x1195
1296  0E              push cs
1297  57              push di
1298  9A D2 0B C9 26  call far 26C9:0BD2
129D  8D BE FA FD     lea di, [bp - 0x206]
12A1  16              push ss
12A2  57              push di
12A3  C4 7E FA        les di, ptr [bp - 6]
12A6  26 8A 45 01     mov al, byte ptr es:[di + 1]
12AA  30 E4           xor ah, ah
12AC  03 06 DA DC     add ax, word ptr [0xdcda]
12B0  48              dec ax
12B1  50              push ax
12B2  9A C1 00 55 1B  call far 1B55:00C1
12B7  9A D2 0B C9 26  call far 26C9:0BD2
12BC  6A 09           push 9
12BE  6A 11           push 0x11
12C0  BF 5C DD        mov di, 0xdd5c
12C3  1E              push ds
12C4  57              push di
12C5  9A 0C 03 2A 23  call far 232A:030C
12CA  6A 05           push 5
12CC  8D BE FA FE     lea di, [bp - 0x106]
12D0  16              push ss
12D1  57              push di
12D2  C4 7E FA        les di, ptr [bp - 6]
12D5  26 8A 05        mov al, byte ptr es:[di]
12D8  30 E4           xor ah, ah
12DA  40              inc ax
12DB  8B F0           mov si, ax
12DD  D1 E0           shl ax, 1
12DF  01 F0           add ax, si
12E1  8B D0           mov dx, ax
12E3  69 46 FE AE 00  imul ax, word ptr [bp - 2], 0xae
12E8  C4 3E CA D7     les di, ptr [0xd7ca]
12EC  03 F8           add di, ax
12EE  03 FA           add di, dx
12F0  26 8A 85 4F FF  mov al, byte ptr es:[di - 0xb1]
12F5  50              push ax
12F6  C4 7E FA        les di, ptr [bp - 6]
12F9  26 8A 05        mov al, byte ptr es:[di]
12FC  30 E4           xor ah, ah
12FE  40              inc ax
12FF  50              push ax
1300  9A 2B 14 55 1B  call far 1B55:142B
1305  6A 15           push 0x15
1307  6A 02           push 2
1309  BF 5C DD        mov di, 0xdd5c
130C  1E              push ds
130D  57              push di
130E  9A 1B 04 2A 23  call far 232A:041B
1313  FF 76 FE        push word ptr [bp - 2]
1316  C4 7E FA        les di, ptr [bp - 6]
1319  26 8A 05        mov al, byte ptr es:[di]
131C  30 E4           xor ah, ah
131E  40              inc ax
131F  50              push ax
1320  9A DF 40 55 1B  call far 1B55:40DF
1325  08 C0           or al, al
1327  74 03           je 0x132c
1329  E9 1D 01        jmp 0x1449
loc_132C:
132C  C4 7E FA        les di, ptr [bp - 6]
132F  26 8A 05        mov al, byte ptr es:[di]
1332  30 E4           xor ah, ah
1334  40              inc ax
1335  8B F0           mov si, ax
1337  D1 E0           shl ax, 1
1339  01 F0           add ax, si
133B  8B D0           mov dx, ax
133D  69 46 FE AE 00  imul ax, word ptr [bp - 2], 0xae
1342  C4 3E CA D7     les di, ptr [0xd7ca]
1346  03 F8           add di, ax
1348  03 FA           add di, dx
134A  26 8A 85 50 FF  mov al, byte ptr es:[di - 0xb0]
134F  30 E4           xor ah, ah
1351  89 46 FE        mov word ptr [bp - 2], ax
1354  6B 46 FE 3E     imul ax, word ptr [bp - 2], 0x3e
1358  C4 3E C2 D7     les di, ptr [0xd7c2]
135C  03 F8           add di, ax
135E  26 C6 45 FC 01  mov byte ptr es:[di - 4], 1
1363  FF 76 FE        push word ptr [bp - 2]
1366  6A 0D           push 0xd
1368  6A 03           push 3
136A  9A E3 0E 55 1B  call far 1B55:0EE3
136F  6B 46 FE 3E     imul ax, word ptr [bp - 2], 0x3e
1373  C4 3E C2 D7     les di, ptr [0xd7c2]
1377  03 F8           add di, ax
1379  26 6B 45 EA 0B  imul ax, word ptr es:[di - 0x16], 0xb
137E  C4 3E CC DC     les di, ptr [0xdccc]
1382  03 F8           add di, ax
1384  06              push es
1385  57              push di
1386  6A 0F           push 0xf
1388  6A 03           push 3
138A  BF 5C DD        mov di, 0xdd5c
138D  1E              push ds
138E  57              push di
138F  9A 9D 03 2A 23  call far 232A:039D
1394  6B 46 FE 3E     imul ax, word ptr [bp - 2], 0x3e
1398  C4 3E C2 D7     les di, ptr [0xd7c2]
139C  03 F8           add di, ax
139E  26 8A 45 F9     mov al, byte ptr es:[di - 7]
13A2  98              cwde
13A3  8B F8           mov di, ax
13A5  C1 E7 04        shl di, 4
13A8  81 C7 E6 DC     add di, 0xdce6
13AC  1E              push ds
13AD  57              push di
13AE  6A 11           push 0x11
13B0  6A 03           push 3
13B2  BF 5C DD        mov di, 0xdd5c
13B5  1E              push ds
13B6  57              push di
13B7  9A 9D 03 2A 23  call far 232A:039D
13BC  6B 46 FE 3E     imul ax, word ptr [bp - 2], 0x3e
13C0  C4 3E C2 D7     les di, ptr [0xd7c2]
13C4  03 F8           add di, ax
13C6  26 80 7D F9 05  cmp byte ptr es:[di - 7], 5
13CB  7D 2D           jge 0x13fa
13CD  8D BE FA FE     lea di, [bp - 0x106]
13D1  16              push ss
13D2  57              push di
13D3  6B 46 FE 3E     imul ax, word ptr [bp - 2], 0x3e
13D7  C4 3E C2 D7     les di, ptr [0xd7c2]
13DB  03 F8           add di, ax
13DD  26 8A 45 F8     mov al, byte ptr es:[di - 8]
13E1  30 E4           xor ah, ah
13E3  31 D2           xor dx, dx
13E5  52              push dx
13E6  50              push ax
13E7  9A C9 07 2A 23  call far 232A:07C9
13EC  6A 12           push 0x12
13EE  6A 11           push 0x11
13F0  BF 5C DD        mov di, 0xdd5c
13F3  1E              push ds
13F4  57              push di
13F5  9A 83 02 2A 23  call far 232A:0283
loc_13FA:
13FA  6A 05           push 5
13FC  C4 7E FA        les di, ptr [bp - 6]
13FF  26 8A 05        mov al, byte ptr es:[di]
1402  30 E4           xor ah, ah
1404  40              inc ax
1405  8B F0           mov si, ax
1407  D1 E0           shl ax, 1
1409  01 F0           add ax, si
140B  8B D0           mov dx, ax
140D  26 8A 45 04     mov al, byte ptr es:[di + 4]
1411  30 E4           xor ah, ah
1413  8B F8           mov di, ax
1415  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
1419  30 E4           xor ah, ah
141B  69 C0 AE 00     imul ax, ax, 0xae
141F  C4 3E CA D7     les di, ptr [0xd7ca]
1423  03 F8           add di, ax
1425  03 FA           add di, dx
1427  26 8A 85 51 FF  mov al, byte ptr es:[di - 0xaf]
142C  24 0F           and al, 0xf
142E  30 E4           xor ah, ah
1430  8B F8           mov di, ax
1432  C1 E7 03        shl di, 3
1435  81 C7 44 A2     add di, 0xa244
1439  1E              push ds
143A  57              push di
143B  6A 16           push 0x16
143D  6A 11           push 0x11
143F  BF 5C DD        mov di, 0xdd5c
1442  1E              push ds
1443  57              push di
1444  9A 0C 03 2A 23  call far 232A:030C
loc_1449:
1449  C9              leave
144A  C3              ret

; ---- routine 0006:144B  (found by: call)
sub_144B:
144B  C8 04 00 00     enter 4, 0
144F  C4 3E D2 D7     les di, ptr [0xd7d2]
1453  89 7E FC        mov word ptr [bp - 4], di
1456  8C 46 FE        mov word ptr [bp - 2], es
1459  BF 66 50        mov di, 0x5066
145C  1E              push ds
145D  57              push di
145E  BF 5C DD        mov di, 0xdd5c
1461  1E              push ds
1462  57              push di
1463  9A 2F 05 2A 23  call far 232A:052F
1468  C4 7E FC        les di, ptr [bp - 4]
146B  26 8A 45 04     mov al, byte ptr es:[di + 4]
146F  30 E4           xor ah, ah
1471  03 F8           add di, ax
1473  26 80 7D 18 00  cmp byte ptr es:[di + 0x18], 0
1478  75 11           jne 0x148b
147A  BF 6E 51        mov di, 0x516e
147D  1E              push ds
147E  57              push di
147F  BF 5C DD        mov di, 0xdd5c
1482  1E              push ds
1483  57              push di
1484  9A 2F 05 2A 23  call far 232A:052F
1489  EB 2A           jmp 0x14b5
loc_148B:
148B  BF D6 55        mov di, 0x55d6
148E  1E              push ds
148F  57              push di
1490  BF 5C DD        mov di, 0xdd5c
1493  1E              push ds
1494  57              push di
1495  9A 2F 05 2A 23  call far 232A:052F
149A  C4 7E FC        les di, ptr [bp - 4]
149D  26 8A 45 04     mov al, byte ptr es:[di + 4]
14A1  30 E4           xor ah, ah
14A3  03 F8           add di, ax
14A5  26 8A 45 18     mov al, byte ptr es:[di + 0x18]
14A9  30 E4           xor ah, ah
14AB  50              push ax
14AC  6A 0E           push 0xe
14AE  6A 1D           push 0x1d
14B0  9A E3 0E 55 1B  call far 1B55:0EE3
loc_14B5:
14B5  C9              leave
14B6  C3              ret
; data (not reached as code), 43 bytes
14B7                  pstr 'Cannot find seasonal info for this year...'

; ---- routine 0006:14E2  (found by: call)
sub_14E2:
14E2  C8 10 01 00     enter 0x110, 0
14E6  8C D3           mov bx, ss
14E8  8E C3           mov es, bx
14EA  8C DB           mov bx, ds
14EC  FC              cld
14ED  8D 7E F2        lea di, [bp - 0xe]
14F0  C5 76 04        lds si, ptr [bp + 4]
14F3  AC              lodsb al, byte ptr [si]
14F4  3C 0C           cmp al, 0xc
14F6  72 02           jb 0x14fa
14F8  B0 0C           mov al, 0xc
loc_14FA:
14FA  AA              stosb byte ptr es:[di], al
14FB  91              xchg cx, ax
14FC  30 ED           xor ch, ch
14FE  F3 A4           rep movsb byte ptr es:[di], byte ptr [si]
1500  8E DB           mov ds, bx
1502  8D 7E F2        lea di, [bp - 0xe]
1505  16              push ss
1506  57              push di
1507  9A 50 12 2A 23  call far 232A:1250
150C  08 C0           or al, al
150E  B0 00           mov al, 0
1510  75 01           jne 0x1513
1512  40              inc ax
loc_1513:
1513  50              push ax
1514  BF B7 14        mov di, 0x14b7
1517  0E              push cs
1518  57              push di
1519  9A 98 00 2A 23  call far 232A:0098
151E  08 C0           or al, al
1520  74 03           je 0x1525
1522  E9 8E 01        jmp 0x16b3
loc_1525:
1525  C6 46 F0 00     mov byte ptr [bp - 0x10], 0
1529  9A E2 0D 55 1B  call far 1B55:0DE2
152E  C4 3E D2 D7     les di, ptr [0xd7d2]
1532  26 8A 45 04     mov al, byte ptr es:[di + 4]
1536  88 46 F1        mov byte ptr [bp - 0xf], al
1539  8D 7E F2        lea di, [bp - 0xe]
153C  16              push ss
153D  57              push di
153E  9A 5D 7A 55 1B  call far 1B55:7A5D
1543  8A 46 F1        mov al, byte ptr [bp - 0xf]
1546  C4 3E D2 D7     les di, ptr [0xd7d2]
154A  26 88 45 04     mov byte ptr es:[di + 4], al
154E  C6 06 06 86 01  mov byte ptr [0x8606], 1
loc_1553:
1553  BF 6E 4C        mov di, 0x4c6e
1556  1E              push ds
1557  57              push di
1558  BF 5C DD        mov di, 0xdd5c
155B  1E              push ds
155C  57              push di
155D  9A 2F 05 2A 23  call far 232A:052F
1562  BF 42 43        mov di, 0x4342
1565  1E              push ds
1566  57              push di
1567  BF 5C DD        mov di, 0xdd5c
156A  1E              push ds
156B  57              push di
156C  9A 2F 05 2A 23  call far 232A:052F
1571  6A 0B           push 0xb
1573  8D BE F0 FE     lea di, [bp - 0x110]
1577  16              push ss
1578  57              push di
1579  9A 5A 79 55 1B  call far 1B55:795A
157E  6A 02           push 2
1580  6A 47           push 0x47
1582  BF 5C DD        mov di, 0xdd5c
1585  1E              push ds
1586  57              push di
1587  9A 1B 04 2A 23  call far 232A:041B
158C  A0 28 00        mov al, byte ptr [0x28]
158F  30 E4           xor ah, ah
1591  8B F8           mov di, ax
1593  8A 85 29 00     mov al, byte ptr [di + 0x29]
1597  30 E4           xor ah, ah
1599  50              push ax
159A  6A 3B           push 0x3b
159C  6A 14           push 0x14
159E  9A 03 02 2A 23  call far 232A:0203
15A3  E8 F1 FB        call 0x1197
15A6  6A 00           push 0
15A8  6A 01           push 1
15AA  6A 13           push 0x13
15AC  6A 0B           push 0xb
15AE  6A 17           push 0x17
15B0  BF 5C DD        mov di, 0xdd5c
15B3  1E              push ds
15B4  57              push di
15B5  9A 07 05 2A 23  call far 232A:0507
15BA  C4 3E D2 D7     les di, ptr [0xd7d2]
15BE  26 8A 45 04     mov al, byte ptr es:[di + 4]
15C2  30 E4           xor ah, ah
15C4  8B F8           mov di, ax
15C6  80 BD B9 DC 00  cmp byte ptr [di - 0x2347], 0
15CB  75 05           jne 0x15d2
15CD  E8 7B FE        call 0x144b
15D0  EB 1A           jmp 0x15ec
loc_15D2:
15D2  C4 3E D2 D7     les di, ptr [0xd7d2]
15D6  26 8A 45 04     mov al, byte ptr es:[di + 4]
15DA  30 E4           xor ah, ah
15DC  8B F8           mov di, ax
15DE  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
15E2  30 E4           xor ah, ah
15E4  50              push ax
15E5  6A 01           push 1
15E7  9A 5A 34 55 1B  call far 1B55:345A
loc_15EC:
15EC  BF 22 63        mov di, 0x6322
15EF  1E              push ds
15F0  57              push di
15F1  BF 5C DD        mov di, 0xdd5c
15F4  1E              push ds
15F5  57              push di
15F6  9A 2F 05 2A 23  call far 232A:052F
15FB  BF 4A 4C        mov di, 0x4c4a
15FE  1E              push ds
15FF  57              push di
1600  BF 5C DD        mov di, 0xdd5c
1603  1E              push ds
1604  57              push di
1605  9A 2F 05 2A 23  call far 232A:052F
160A  BF 28 00        mov di, 0x28
160D  1E              push ds
160E  57              push di
160F  6A 07           push 7
1611  9A 8B 0F 2A 23  call far 232A:0F8B
1616  80 3E 88 DE 01  cmp byte ptr [0xde88], 1
161B  75 06           jne 0x1623
161D  C6 46 F0 01     mov byte ptr [bp - 0x10], 1
1621  EB 64           jmp 0x1687
loc_1623:
1623  80 3E 88 DE 0D  cmp byte ptr [0xde88], 0xd
1628  75 07           jne 0x1631
162A  9A 08 31 55 1B  call far 1B55:3108
162F  EB 56           jmp 0x1687
loc_1631:
1631  80 3E 88 DE 02  cmp byte ptr [0xde88], 2
1636  75 4F           jne 0x1687
1638  A0 28 00        mov al, byte ptr [0x28]
163B  3C 01           cmp al, 1
163D  75 09           jne 0x1648
163F  6A 01           push 1
1641  9A 43 47 EF 01  call far 01EF:4743
1646  EB 3F           jmp 0x1687
loc_1648:
1648  3C 02           cmp al, 2
164A  75 07           jne 0x1653
164C  9A DB 48 EF 01  call far 01EF:48DB
1651  EB 34           jmp 0x1687
loc_1653:
1653  3C 03           cmp al, 3
1655  75 08           jne 0x165f
1657  6A 02           push 2
1659  0E              push cs
165A  E8 44 F1        call 0x7a1
165D  EB 28           jmp 0x1687
loc_165F:
165F  3C 04           cmp al, 4
1661  75 07           jne 0x166a
1663  9A 7A 1D EF 01  call far 01EF:1D7A
1668  EB 1D           jmp 0x1687
loc_166A:
166A  3C 05           cmp al, 5
166C  75 05           jne 0x1673
166E  E8 0A F9        call 0xf7b
1671  EB 14           jmp 0x1687
loc_1673:
1673  3C 06           cmp al, 6
1675  75 08           jne 0x167f
1677  6A 05           push 5
1679  0E              push cs
167A  E8 24 F1        call 0x7a1
167D  EB 08           jmp 0x1687
loc_167F:
167F  3C 07           cmp al, 7
1681  75 04           jne 0x1687
1683  C6 46 F0 01     mov byte ptr [bp - 0x10], 1
loc_1687:
1687  80 7E F0 00     cmp byte ptr [bp - 0x10], 0
168B  75 03           jne 0x1690
168D  E9 C3 FE        jmp 0x1553
loc_1690:
1690  C6 06 88 DE 00  mov byte ptr [0xde88], 0
1695  C6 06 8A DE 00  mov byte ptr [0xde8a], 0
169A  9A 54 10 BC 24  call far 24BC:1054
169F  BF 31 D7        mov di, 0xd731
16A2  1E              push ds
16A3  57              push di
16A4  9A 5D 7A 55 1B  call far 1B55:7A5D
16A9  9A 54 10 BC 24  call far 24BC:1054
16AE  C6 06 06 86 00  mov byte ptr [0x8606], 0
loc_16B3:
16B3  C9              leave
16B4  C2 04 00        ret 4

