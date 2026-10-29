; 1-0.EXE (One-Nil 96), code segment 01EF (image offsets 01EF0..06E7F), part 6 of 7
; packed 1-0.EXE sha256 89ff9c5f238f24e81a0c2440a46cdd8997280a65fc3cc3d97cb974f55280a80a (LZEXE 0.91)
; unpacked (tools/static/unlzexe.py) sha256 887ed2a92767950e5309b2052409f875668605939b69e00737aa3047022b9f51
; tool: capstone 5.0.9 (pip package; core library 5.0.1280) (CS_ARCH_X86, CS_MODE_16), recursive descent from the entry point, far calls and near calls/jumps, then routine prologues (55 89 E5 / 55 8B EC / C8 iw 00) in what remains; tools/static/listing.py
; addresses are SEGMENT:OFFSET with SEGMENT the image paragraph before relocation; image offset = SEGMENT*16+OFFSET
; ---- routine 01EF:3B5C  (found by: call)
sub_3B5C:
3B5C  C8 0A 00 00     enter 0xa, 0
3B60  C7 46 FC 01 00  mov word ptr [bp - 4], 1
3B65  8B 46 08        mov ax, word ptr [bp + 8]
3B68  05 C7 00        add ax, 0xc7
3B6B  89 46 FA        mov word ptr [bp - 6], ax
3B6E  8B 46 08        mov ax, word ptr [bp + 8]
3B71  3B 46 FA        cmp ax, word ptr [bp - 6]
3B74  76 03           jbe 0x3b79
3B76  E9 34 01        jmp 0x3cad
loc_3B79:
3B79  89 46 FE        mov word ptr [bp - 2], ax
3B7C  EB 03           jmp 0x3b81
loc_3B7E:
3B7E  FF 46 FE        inc word ptr [bp - 2]
loc_3B81:
3B81  8B 46 FE        mov ax, word ptr [bp - 2]
3B84  C1 E0 02        shl ax, 2
3B87  C4 3E C8 DC     les di, ptr [0xdcc8]
3B8B  03 F8           add di, ax
3B8D  89 7E F6        mov word ptr [bp - 0xa], di
3B90  8C 46 F8        mov word ptr [bp - 8], es
3B93  8A 46 06        mov al, byte ptr [bp + 6]
3B96  26 88 45 03     mov byte ptr es:[di + 3], al
3B9A  81 7E FC B0 00  cmp word ptr [bp - 4], 0xb0
3B9F  77 08           ja 0x3ba9
3BA1  8A 46 FC        mov al, byte ptr [bp - 4]
3BA4  26 88 05        mov byte ptr es:[di], al
3BA7  EB 07           jmp 0x3bb0
loc_3BA9:
3BA9  C4 7E F6        les di, ptr [bp - 0xa]
3BAC  26 C6 05 00     mov byte ptr es:[di], 0
loc_3BB0:
3BB0  C4 7E F6        les di, ptr [bp - 0xa]
3BB3  26 80 3D 00     cmp byte ptr es:[di], 0
3BB7  74 20           je 0x3bd9
3BB9  8B 4E FE        mov cx, word ptr [bp - 2]
3BBC  26 8A 45 03     mov al, byte ptr es:[di + 3]
3BC0  98              cwde
3BC1  D1 E0           shl ax, 1
3BC3  8B D0           mov dx, ax
3BC5  26 8A 05        mov al, byte ptr es:[di]
3BC8  30 E4           xor ah, ah
3BCA  6B C0 3E        imul ax, ax, 0x3e
3BCD  C4 3E C2 D7     les di, ptr [0xd7c2]
3BD1  03 F8           add di, ax
3BD3  03 FA           add di, dx
3BD5  26 89 4D EA     mov word ptr es:[di - 0x16], cx
loc_3BD9:
3BD9  C4 7E F6        les di, ptr [bp - 0xa]
3BDC  26 80 3D 00     cmp byte ptr es:[di], 0
3BE0  75 11           jne 0x3bf3
3BE2  6A 2C           push 0x2c
3BE4  9A 6D 07 2A 23  call far 232A:076D
3BE9  C4 7E F6        les di, ptr [bp - 0xa]
3BEC  26 88 45 02     mov byte ptr es:[di + 2], al
3BF0  E9 AC 00        jmp 0x3c9f
loc_3BF3:
3BF3  C4 7E F6        les di, ptr [bp - 0xa]
3BF6  26 80 7D 03 01  cmp byte ptr es:[di + 3], 1
3BFB  75 4C           jne 0x3c49
3BFD  6A 00           push 0
3BFF  6A 01           push 1
3C01  6A 20           push 0x20
3C03  9A 6D 07 2A 23  call far 232A:076D
3C08  50              push ax
3C09  6A 20           push 0x20
3C0B  9A 6D 07 2A 23  call far 232A:076D
3C10  8B C8           mov cx, ax
3C12  C4 7E F6        les di, ptr [bp - 0xa]
3C15  26 8A 05        mov al, byte ptr es:[di]
3C18  30 E4           xor ah, ah
3C1A  6B C0 3E        imul ax, ax, 0x3e
3C1D  C4 3E C2 D7     les di, ptr [0xd7c2]
3C21  03 F8           add di, ax
3C23  26 8A 45 F5     mov al, byte ptr es:[di - 0xb]
3C27  30 E4           xor ah, ah
3C29  8B D0           mov dx, ax
3C2B  B8 B1 00        mov ax, 0xb1
3C2E  2B C2           sub ax, dx
3C30  05 E0 FF        add ax, 0xffe0
3C33  03 C1           add ax, cx
3C35  5A              pop dx
3C36  2B C2           sub ax, dx
3C38  99              cdq
3C39  52              push dx
3C3A  50              push ax
3C3B  9A C0 04 BC 24  call far 24BC:04C0
3C40  C4 7E F6        les di, ptr [bp - 0xa]
3C43  26 88 45 02     mov byte ptr es:[di + 2], al
3C47  EB 47           jmp 0x3c90
loc_3C49:
3C49  6A 00           push 0
3C4B  6A 01           push 1
3C4D  6A 20           push 0x20
3C4F  9A 6D 07 2A 23  call far 232A:076D
3C54  50              push ax
3C55  6A 20           push 0x20
3C57  9A 6D 07 2A 23  call far 232A:076D
3C5C  8B C8           mov cx, ax
3C5E  C4 7E F6        les di, ptr [bp - 0xa]
3C61  26 8A 05        mov al, byte ptr es:[di]
3C64  30 E4           xor ah, ah
3C66  6B C0 3E        imul ax, ax, 0x3e
3C69  C4 3E C2 D7     les di, ptr [0xd7c2]
3C6D  03 F8           add di, ax
3C6F  26 8A 45 F5     mov al, byte ptr es:[di - 0xb]
3C73  30 E4           xor ah, ah
3C75  8B D0           mov dx, ax
3C77  B8 B1 00        mov ax, 0xb1
3C7A  2B C2           sub ax, dx
3C7C  03 C1           add ax, cx
3C7E  5A              pop dx
3C7F  2B C2           sub ax, dx
3C81  99              cdq
3C82  52              push dx
3C83  50              push ax
3C84  9A C0 04 BC 24  call far 24BC:04C0
3C89  C4 7E F6        les di, ptr [bp - 0xa]
3C8C  26 88 45 02     mov byte ptr es:[di + 2], al
loc_3C90:
3C90  C4 7E F6        les di, ptr [bp - 0xa]
3C93  26 80 7D 02 B0  cmp byte ptr es:[di + 2], 0xb0
3C98  76 05           jbe 0x3c9f
3C9A  26 C6 45 02 B0  mov byte ptr es:[di + 2], 0xb0
loc_3C9F:
3C9F  FF 46 FC        inc word ptr [bp - 4]
3CA2  8B 46 FE        mov ax, word ptr [bp - 2]
3CA5  3B 46 FA        cmp ax, word ptr [bp - 6]
3CA8  74 03           je 0x3cad
3CAA  E9 D1 FE        jmp 0x3b7e
loc_3CAD:
3CAD  C9              leave
3CAE  C2 06 00        ret 6

; ---- routine 01EF:3CB1  (found by: call)
sub_3CB1:
3CB1  C8 04 00 00     enter 4, 0
3CB5  C7 46 FE 01 00  mov word ptr [bp - 2], 1
3CBA  C6 46 FD 00     mov byte ptr [bp - 3], 0
loc_3CBE:
3CBE  FF 76 FE        push word ptr [bp - 2]
3CC1  8A 46 FD        mov al, byte ptr [bp - 3]
3CC4  50              push ax
3CC5  55              push bp
3CC6  E8 93 FE        call 0x3b5c
3CC9  81 46 FE C8 00  add word ptr [bp - 2], 0xc8
3CCE  FE 46 FD        inc byte ptr [bp - 3]
3CD1  81 7E FE E8 03  cmp word ptr [bp - 2], 0x3e8
3CD6  76 E6           jbe 0x3cbe
3CD8  C9              leave
3CD9  C3              ret

; ---- routine 01EF:3CDA  (found by: far)
sub_3CDA:
3CDA  C8 0A 00 00     enter 0xa, 0
3CDE  C6 06 BA DC 00  mov byte ptr [0xdcba], 0
3CE3  C6 06 BB DC 00  mov byte ptr [0xdcbb], 0
3CE8  C4 3E D2 D7     les di, ptr [0xd7d2]
3CEC  26 C6 45 04 01  mov byte ptr es:[di + 4], 1
3CF1  C4 3E D2 D7     les di, ptr [0xd7d2]
3CF5  26 C6 45 02 07  mov byte ptr es:[di + 2], 7
3CFA  C7 46 FE 11 00  mov word ptr [bp - 2], 0x11
3CFF  EB 03           jmp 0x3d04
loc_3D01:
3D01  FF 46 FE        inc word ptr [bp - 2]
loc_3D04:
3D04  8B 7E FE        mov di, word ptr [bp - 2]
3D07  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
3D0B  30 E4           xor ah, ah
3D0D  6B C0 3E        imul ax, ax, 0x3e
3D10  C4 3E C2 D7     les di, ptr [0xd7c2]
3D14  03 F8           add di, ax
3D16  81 C7 C2 FF     add di, 0xffc2
3D1A  89 7E FA        mov word ptr [bp - 6], di
3D1D  8C 46 FC        mov word ptr [bp - 4], es
3D20  8B 7E FE        mov di, word ptr [bp - 2]
3D23  8A 85 A1 02     mov al, byte ptr [di + 0x2a1]
3D27  C4 7E FA        les di, ptr [bp - 6]
3D2A  26 88 45 38     mov byte ptr es:[di + 0x38], al
3D2E  83 7E FE 14     cmp word ptr [bp - 2], 0x14
3D32  75 CD           jne 0x3d01
3D34  C7 46 FE 01 00  mov word ptr [bp - 2], 1
3D39  EB 03           jmp 0x3d3e
loc_3D3B:
3D3B  FF 46 FE        inc word ptr [bp - 2]
loc_3D3E:
3D3E  8B 7E FE        mov di, word ptr [bp - 2]
3D41  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
3D45  30 E4           xor ah, ah
3D47  6B C0 3E        imul ax, ax, 0x3e
3D4A  C4 3E C2 D7     les di, ptr [0xd7c2]
3D4E  03 F8           add di, ax
3D50  81 C7 C2 FF     add di, 0xffc2
3D54  89 7E FA        mov word ptr [bp - 6], di
3D57  8C 46 FC        mov word ptr [bp - 4], es
3D5A  8B 7E FE        mov di, word ptr [bp - 2]
3D5D  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
3D61  30 E4           xor ah, ah
3D63  8B F8           mov di, ax
3D65  8A 85 85 D8     mov al, byte ptr [di - 0x277b]
3D69  30 E4           xor ah, ah
3D6B  8B F8           mov di, ax
3D6D  8A 85 F7 93     mov al, byte ptr [di - 0x6c09]
3D71  C4 7E FA        les di, ptr [bp - 6]
3D74  26 88 45 39     mov byte ptr es:[di + 0x39], al
3D78  81 7E FE B0 00  cmp word ptr [bp - 2], 0xb0
3D7D  75 BC           jne 0x3d3b
3D7F  C4 3E D2 D7     les di, ptr [0xd7d2]
3D83  81 C7 A8 00     add di, 0xa8
3D87  89 7E F6        mov word ptr [bp - 0xa], di
3D8A  8C 46 F8        mov word ptr [bp - 8], es
3D8D  81 C7 1D 00     add di, 0x1d
3D91  06              push es
3D92  57              push di
3D93  6A 08           push 8
3D95  6A 01           push 1
3D97  9A 22 02 BC 24  call far 24BC:0222
3D9C  C4 7E F6        les di, ptr [bp - 0xa]
3D9F  26 C6 45 18 01  mov byte ptr es:[di + 0x18], 1
3DA4  26 C6 45 19 01  mov byte ptr es:[di + 0x19], 1
3DA9  26 C6 45 15 01  mov byte ptr es:[di + 0x15], 1
3DAE  26 C6 45 04 01  mov byte ptr es:[di + 4], 1
3DB3  C4 3E D2 D7     les di, ptr [0xd7d2]
3DB7  81 C7 A8 00     add di, 0xa8
3DBB  06              push es
3DBC  57              push di
3DBD  C4 3E D2 D7     les di, ptr [0xd7d2]
3DC1  81 C7 CD 00     add di, 0xcd
3DC5  06              push es
3DC6  57              push di
3DC7  6A 25           push 0x25
3DC9  9A 12 0A C9 26  call far 26C9:0A12
3DCE  E8 2C E8        call 0x25fd
3DD1  E8 DD FE        call 0x3cb1
3DD4  E8 FA EE        call 0x2cd1
3DD7  C9              leave
3DD8  CB              retf

; ---- routine 01EF:3DD9  (found by: call)
sub_3DD9:
3DD9  C8 0A 00 00     enter 0xa, 0
3DDD  BF 04 72        mov di, 0x7204
3DE0  1E              push ds
3DE1  57              push di
3DE2  BF 5C DD        mov di, 0xdd5c
3DE5  1E              push ds
3DE6  57              push di
3DE7  9A 2F 05 2A 23  call far 232A:052F
3DEC  6A 0E           push 0xe
3DEE  8B 7E 06        mov di, word ptr [bp + 6]
3DF1  C1 E7 03        shl di, 3
3DF4  81 C7 26 88     add di, 0x8826
3DF8  1E              push ds
3DF9  57              push di
3DFA  6A 03           push 3
3DFC  6A 0A           push 0xa
3DFE  BF 5C DD        mov di, 0xdd5c
3E01  1E              push ds
3E02  57              push di
3E03  9A 1B 04 2A 23  call far 232A:041B
3E08  8B 7E 04        mov di, word ptr [bp + 4]
3E0B  8A 85 FB D4     mov al, byte ptr [di - 0x2b05]
3E0F  30 E4           xor ah, ah
3E11  6B C0 3E        imul ax, ax, 0x3e
3E14  C4 3E C2 D7     les di, ptr [0xd7c2]
3E18  03 F8           add di, ax
3E1A  81 C7 C2 FF     add di, 0xffc2
3E1E  89 7E F8        mov word ptr [bp - 8], di
3E21  8C 46 FA        mov word ptr [bp - 6], es
3E24  26 8A 45 37     mov al, byte ptr es:[di + 0x37]
3E28  98              cwde
3E29  8B F8           mov di, ax
3E2B  8A 85 3C A2     mov al, byte ptr [di - 0x5dc4]
3E2F  50              push ax
3E30  C4 7E F8        les di, ptr [bp - 8]
3E33  26 8A 45 37     mov al, byte ptr es:[di + 0x37]
3E37  98              cwde
3E38  8B F8           mov di, ax
3E3A  C1 E7 04        shl di, 4
3E3D  81 C7 E6 DC     add di, 0xdce6
3E41  1E              push ds
3E42  57              push di
3E43  6A 05           push 5
3E45  6A 15           push 0x15
3E47  BF 5C DD        mov di, 0xdd5c
3E4A  1E              push ds
3E4B  57              push di
3E4C  9A 1B 04 2A 23  call far 232A:041B
3E51  C7 46 FC 04 00  mov word ptr [bp - 4], 4
3E56  8B 46 04        mov ax, word ptr [bp + 4]
3E59  05 07 00        add ax, 7
3E5C  89 46 FA        mov word ptr [bp - 6], ax
3E5F  8B 46 04        mov ax, word ptr [bp + 4]
3E62  3B 46 FA        cmp ax, word ptr [bp - 6]
3E65  77 5F           ja 0x3ec6
3E67  89 46 FE        mov word ptr [bp - 2], ax
3E6A  EB 03           jmp 0x3e6f
loc_3E6C:
3E6C  FF 46 FE        inc word ptr [bp - 2]
loc_3E6F:
3E6F  8B 46 06        mov ax, word ptr [bp + 6]
3E72  8B F0           mov si, ax
3E74  D1 E0           shl ax, 1
3E76  01 F0           add ax, si
3E78  8B D0           mov dx, ax
3E7A  8B 7E FE        mov di, word ptr [bp - 2]
3E7D  8A 85 FB D4     mov al, byte ptr [di - 0x2b05]
3E81  30 E4           xor ah, ah
3E83  69 C0 AE 00     imul ax, ax, 0xae
3E87  C4 3E CA D7     les di, ptr [0xd7ca]
3E8B  03 F8           add di, ax
3E8D  03 FA           add di, dx
3E8F  81 C7 4F FF     add di, 0xff4f
3E93  26 80 3D 00     cmp byte ptr es:[di], 0
3E97  75 25           jne 0x3ebe
3E99  26 8A 45 02     mov al, byte ptr es:[di + 2]
3E9D  24 0F           and al, 0xf
3E9F  3C 01           cmp al, 1
3EA1  75 1B           jne 0x3ebe
3EA3  83 46 FC 02     add word ptr [bp - 4], 2
3EA7  8B 7E FE        mov di, word ptr [bp - 2]
3EAA  8A 85 FB D4     mov al, byte ptr [di - 0x2b05]
3EAE  30 E4           xor ah, ah
3EB0  50              push ax
3EB1  FF 76 06        push word ptr [bp + 6]
3EB4  FF 76 FC        push word ptr [bp - 4]
3EB7  6A 26           push 0x26
3EB9  9A 7D 16 55 1B  call far 1B55:167D
loc_3EBE:
3EBE  8B 46 FE        mov ax, word ptr [bp - 2]
3EC1  3B 46 FA        cmp ax, word ptr [bp - 6]
3EC4  75 A6           jne 0x3e6c
loc_3EC6:
3EC6  C9              leave
3EC7  C2 04 00        ret 4
; data (not reached as code), 25 bytes
3ECA                  pstr 'No league results to see'

; ---- routine 01EF:3EE3  (found by: call, far)
sub_3EE3:
3EE3  C8 02 00 00     enter 2, 0
3EE7  8B 7E 08        mov di, word ptr [bp + 8]
3EEA  80 BD 6A A2 00  cmp byte ptr [di - 0x5d96], 0
3EEF  B0 00           mov al, 0
3EF1  74 01           je 0x3ef4
3EF3  40              inc ax
loc_3EF4:
3EF4  50              push ax
3EF5  BF CA 3E        mov di, 0x3eca
3EF8  0E              push cs
3EF9  57              push di
3EFA  9A 98 00 2A 23  call far 232A:0098
3EFF  08 C0           or al, al
3F01  74 03           je 0x3f06
3F03  E9 B9 00        jmp 0x3fbf
loc_3F06:
3F06  FF 76 08        push word ptr [bp + 8]
3F09  9A 1E 79 55 1B  call far 1B55:791E
3F0E  C4 3E D2 D7     les di, ptr [0xd7d2]
3F12  26 8A 45 04     mov al, byte ptr es:[di + 4]
3F16  30 E4           xor ah, ah
3F18  8B F8           mov di, ax
3F1A  80 BD B9 DC 00  cmp byte ptr [di - 0x2347], 0
3F1F  75 06           jne 0x3f27
3F21  C6 46 FF 01     mov byte ptr [bp - 1], 1
3F25  EB 25           jmp 0x3f4c
loc_3F27:
3F27  C4 3E D2 D7     les di, ptr [0xd7d2]
3F2B  26 8A 45 04     mov al, byte ptr es:[di + 4]
3F2F  30 E4           xor ah, ah
3F31  8B F8           mov di, ax
3F33  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
3F37  30 E4           xor ah, ah
3F39  6B C0 3E        imul ax, ax, 0x3e
3F3C  C4 3E C2 D7     les di, ptr [0xd7c2]
3F40  03 F8           add di, ax
3F42  26 8A 45 F9     mov al, byte ptr es:[di - 7]
3F46  30 E4           xor ah, ah
3F48  40              inc ax
3F49  88 46 FF        mov byte ptr [bp - 1], al
loc_3F4C:
3F4C  80 7E 06 00     cmp byte ptr [bp + 6], 0
3F50  74 11           je 0x3f63
3F52  BF DA 4E        mov di, 0x4eda
3F55  1E              push ds
3F56  57              push di
3F57  BF 5C DD        mov di, 0xdd5c
3F5A  1E              push ds
3F5B  57              push di
3F5C  9A 2F 05 2A 23  call far 232A:052F
3F61  EB 0F           jmp 0x3f72
loc_3F63:
3F63  BF 12 6C        mov di, 0x6c12
3F66  1E              push ds
3F67  57              push di
3F68  BF 5C DD        mov di, 0xdd5c
3F6B  1E              push ds
3F6C  57              push di
3F6D  9A 2F 05 2A 23  call far 232A:052F
loc_3F72:
3F72  FF 76 08        push word ptr [bp + 8]
3F75  8A 46 FF        mov al, byte ptr [bp - 1]
3F78  30 E4           xor ah, ah
3F7A  8B F8           mov di, ax
3F7C  8A 85 B5 02     mov al, byte ptr [di + 0x2b5]
3F80  30 E4           xor ah, ah
3F82  50              push ax
3F83  E8 53 FE        call 0x3dd9
3F86  C4 3E 5C DD     les di, ptr [0xdd5c]
3F8A  06              push es
3F8B  57              push di
3F8C  C4 3E 58 DD     les di, ptr [0xdd58]
3F90  06              push es
3F91  57              push di
3F92  68 A0 0F        push 0xfa0
3F95  9A 12 0A C9 26  call far 26C9:0A12
3F9A  9A 00 00 E8 06  call far 06E8:0000
3F9F  8D 7E FF        lea di, [bp - 1]
3FA2  16              push ss
3FA3  57              push di
3FA4  6A 05           push 5
3FA6  9A C4 0E 2A 23  call far 232A:0EC4
3FAB  80 3E 88 DE 01  cmp byte ptr [0xde88], 1
3FB0  74 0D           je 0x3fbf
3FB2  80 7E 06 00     cmp byte ptr [bp + 6], 0
3FB6  74 BA           je 0x3f72
3FB8  80 3E 88 DE 0D  cmp byte ptr [0xde88], 0xd
3FBD  74 B3           je 0x3f72
loc_3FBF:
3FBF  C9              leave
3FC0  CA 04 00        retf 4

; ---- routine 01EF:3FC3  (found by: call)
sub_3FC3:
3FC3  C8 08 00 00     enter 8, 0
3FC7  8B 46 08        mov ax, word ptr [bp + 8]
3FCA  89 46 FE        mov word ptr [bp - 2], ax
3FCD  8B 46 06        mov ax, word ptr [bp + 6]
3FD0  89 46 FC        mov word ptr [bp - 4], ax
3FD3  8B 46 08        mov ax, word ptr [bp + 8]
3FD6  03 46 06        add ax, word ptr [bp + 6]
3FD9  D1 E8           shr ax, 1
3FDB  8B F8           mov di, ax
3FDD  8A 85 AD DC     mov al, byte ptr [di - 0x2353]
3FE1  30 E4           xor ah, ah
3FE3  6B C0 0C        imul ax, ax, 0xc
3FE6  C4 3E B6 DC     les di, ptr [0xdcb6]
3FEA  03 F8           add di, ax
3FEC  26 8A 45 F5     mov al, byte ptr es:[di - 0xb]
3FF0  30 E4           xor ah, ah
3FF2  89 46 F8        mov word ptr [bp - 8], ax
loc_3FF5:
3FF5  8B 7E FE        mov di, word ptr [bp - 2]
3FF8  8A 85 AD DC     mov al, byte ptr [di - 0x2353]
3FFC  30 E4           xor ah, ah
3FFE  6B C0 0C        imul ax, ax, 0xc
4001  C4 3E B6 DC     les di, ptr [0xdcb6]
4005  03 F8           add di, ax
4007  26 8A 45 F5     mov al, byte ptr es:[di - 0xb]
400B  30 E4           xor ah, ah
400D  3B 46 F8        cmp ax, word ptr [bp - 8]
4010  76 05           jbe 0x4017
4012  FF 46 FE        inc word ptr [bp - 2]
4015  EB DE           jmp 0x3ff5
loc_4017:
4017  8B 7E FC        mov di, word ptr [bp - 4]
401A  8A 85 AD DC     mov al, byte ptr [di - 0x2353]
401E  30 E4           xor ah, ah
4020  6B C0 0C        imul ax, ax, 0xc
4023  C4 3E B6 DC     les di, ptr [0xdcb6]
4027  03 F8           add di, ax
4029  26 8A 45 F5     mov al, byte ptr es:[di - 0xb]
402D  30 E4           xor ah, ah
402F  3B 46 F8        cmp ax, word ptr [bp - 8]
4032  73 05           jae 0x4039
4034  FF 4E FC        dec word ptr [bp - 4]
4037  EB DE           jmp 0x4017
loc_4039:
4039  8B 46 FE        mov ax, word ptr [bp - 2]
403C  3B 46 FC        cmp ax, word ptr [bp - 4]
403F  77 2A           ja 0x406b
4041  8B 7E FE        mov di, word ptr [bp - 2]
4044  8A 85 AD DC     mov al, byte ptr [di - 0x2353]
4048  30 E4           xor ah, ah
404A  89 46 FA        mov word ptr [bp - 6], ax
404D  8B 7E FC        mov di, word ptr [bp - 4]
4050  8A 85 AD DC     mov al, byte ptr [di - 0x2353]
4054  8B 7E FE        mov di, word ptr [bp - 2]
4057  88 85 AD DC     mov byte ptr [di - 0x2353], al
405B  8A 46 FA        mov al, byte ptr [bp - 6]
405E  8B 7E FC        mov di, word ptr [bp - 4]
4061  88 85 AD DC     mov byte ptr [di - 0x2353], al
4065  FF 46 FE        inc word ptr [bp - 2]
4068  FF 4E FC        dec word ptr [bp - 4]
loc_406B:
406B  8B 46 FE        mov ax, word ptr [bp - 2]
406E  3B 46 FC        cmp ax, word ptr [bp - 4]
4071  76 82           jbe 0x3ff5
4073  8B 46 08        mov ax, word ptr [bp + 8]
4076  3B 46 FC        cmp ax, word ptr [bp - 4]
4079  73 0D           jae 0x4088
407B  FF 76 08        push word ptr [bp + 8]
407E  FF 76 FC        push word ptr [bp - 4]
4081  8B 7E 04        mov di, word ptr [bp + 4]
4084  57              push di
4085  E8 3B FF        call 0x3fc3
loc_4088:
4088  8B 46 FE        mov ax, word ptr [bp - 2]
408B  3B 46 06        cmp ax, word ptr [bp + 6]
408E  73 0D           jae 0x409d
4090  FF 76 FE        push word ptr [bp - 2]
4093  FF 76 06        push word ptr [bp + 6]
4096  8B 7E 04        mov di, word ptr [bp + 4]
4099  57              push di
409A  E8 26 FF        call 0x3fc3
loc_409D:
409D  C9              leave
409E  C2 06 00        ret 6

; ---- routine 01EF:40A1  (found by: call)
sub_40A1:
40A1  C8 0C 00 00     enter 0xc, 0
40A5  8B 46 06        mov ax, word ptr [bp + 6]
40A8  89 46 FA        mov word ptr [bp - 6], ax
40AB  8B 46 08        mov ax, word ptr [bp + 8]
40AE  40              inc ax
40AF  3B 46 FA        cmp ax, word ptr [bp - 6]
40B2  76 03           jbe 0x40b7
40B4  E9 31 01        jmp 0x41e8
loc_40B7:
40B7  89 46 FE        mov word ptr [bp - 2], ax
40BA  EB 03           jmp 0x40bf
loc_40BC:
40BC  FF 46 FE        inc word ptr [bp - 2]
loc_40BF:
40BF  8B 46 FE        mov ax, word ptr [bp - 2]
40C2  89 46 F8        mov word ptr [bp - 8], ax
40C5  8B 46 06        mov ax, word ptr [bp + 6]
40C8  3B 46 F8        cmp ax, word ptr [bp - 8]
40CB  73 03           jae 0x40d0
40CD  E9 0D 01        jmp 0x41dd
loc_40D0:
40D0  89 46 FC        mov word ptr [bp - 4], ax
40D3  EB 03           jmp 0x40d8
loc_40D5:
40D5  FF 4E FC        dec word ptr [bp - 4]
loc_40D8:
40D8  8B 46 FC        mov ax, word ptr [bp - 4]
40DB  48              dec ax
40DC  8B F8           mov di, ax
40DE  8A 85 AD DC     mov al, byte ptr [di - 0x2353]
40E2  30 E4           xor ah, ah
40E4  6B C0 0C        imul ax, ax, 0xc
40E7  C4 3E B6 DC     les di, ptr [0xdcb6]
40EB  03 F8           add di, ax
40ED  81 C7 F4 FF     add di, 0xfff4
40F1  89 7E F4        mov word ptr [bp - 0xc], di
40F4  8C 46 F6        mov word ptr [bp - 0xa], es
40F7  8B 7E FC        mov di, word ptr [bp - 4]
40FA  8A 85 AD DC     mov al, byte ptr [di - 0x2353]
40FE  30 E4           xor ah, ah
4100  6B C0 0C        imul ax, ax, 0xc
4103  C4 3E B6 DC     les di, ptr [0xdcb6]
4107  03 F8           add di, ax
4109  26 8A 45 F5     mov al, byte ptr es:[di - 0xb]
410D  C4 7E F4        les di, ptr [bp - 0xc]
4110  26 3A 45 01     cmp al, byte ptr es:[di + 1]
4114  74 03           je 0x4119
4116  E9 B9 00        jmp 0x41d2
loc_4119:
4119  8B 7E FC        mov di, word ptr [bp - 4]
411C  8A 85 AD DC     mov al, byte ptr [di - 0x2353]
4120  30 E4           xor ah, ah
4122  6B C0 0C        imul ax, ax, 0xc
4125  C4 3E B6 DC     les di, ptr [0xdcb6]
4129  03 F8           add di, ax
412B  26 8B 55 FE     mov dx, word ptr es:[di - 2]
412F  8B 7E FC        mov di, word ptr [bp - 4]
4132  8A 85 AD DC     mov al, byte ptr [di - 0x2353]
4136  30 E4           xor ah, ah
4138  6B C0 0C        imul ax, ax, 0xc
413B  C4 3E B6 DC     les di, ptr [0xdcb6]
413F  03 F8           add di, ax
4141  26 8B 45 FC     mov ax, word ptr es:[di - 4]
4145  2B C2           sub ax, dx
4147  8A D0           mov dl, al
4149  C4 7E F4        les di, ptr [bp - 0xc]
414C  26 8B 45 08     mov ax, word ptr es:[di + 8]
4150  26 2B 45 0A     sub ax, word ptr es:[di + 0xa]
4154  3A C2           cmp al, dl
4156  7C 5E           jl 0x41b6
4158  8B 7E FC        mov di, word ptr [bp - 4]
415B  8A 85 AD DC     mov al, byte ptr [di - 0x2353]
415F  30 E4           xor ah, ah
4161  6B C0 0C        imul ax, ax, 0xc
4164  C4 3E B6 DC     les di, ptr [0xdcb6]
4168  03 F8           add di, ax
416A  26 8B 55 FE     mov dx, word ptr es:[di - 2]
416E  8B 7E FC        mov di, word ptr [bp - 4]
4171  8A 85 AD DC     mov al, byte ptr [di - 0x2353]
4175  30 E4           xor ah, ah
4177  6B C0 0C        imul ax, ax, 0xc
417A  C4 3E B6 DC     les di, ptr [0xdcb6]
417E  03 F8           add di, ax
4180  26 8B 45 FC     mov ax, word ptr es:[di - 4]
4184  2B C2           sub ax, dx
4186  8A D0           mov dl, al
4188  C4 7E F4        les di, ptr [bp - 0xc]
418B  26 8B 45 08     mov ax, word ptr es:[di + 8]
418F  26 2B 45 0A     sub ax, word ptr es:[di + 0xa]
4193  3A C2           cmp al, dl
4195  75 3B           jne 0x41d2
4197  8B 7E FC        mov di, word ptr [bp - 4]
419A  8A 85 AD DC     mov al, byte ptr [di - 0x2353]
419E  30 E4           xor ah, ah
41A0  6B C0 0C        imul ax, ax, 0xc
41A3  C4 3E B6 DC     les di, ptr [0xdcb6]
41A7  03 F8           add di, ax
41A9  26 8B 45 FC     mov ax, word ptr es:[di - 4]
41AD  C4 7E F4        les di, ptr [bp - 0xc]
41B0  26 3B 45 08     cmp ax, word ptr es:[di + 8]
41B4  76 1C           jbe 0x41d2
loc_41B6:
41B6  8B 7E FC        mov di, word ptr [bp - 4]
41B9  81 C7 AD DC     add di, 0xdcad
41BD  1E              push ds
41BE  57              push di
41BF  8B 46 FC        mov ax, word ptr [bp - 4]
41C2  48              dec ax
41C3  8B F8           mov di, ax
41C5  81 C7 AD DC     add di, 0xdcad
41C9  1E              push ds
41CA  57              push di
41CB  6A 01           push 1
41CD  9A 03 02 BC 24  call far 24BC:0203
loc_41D2:
41D2  8B 46 FC        mov ax, word ptr [bp - 4]
41D5  3B 46 F8        cmp ax, word ptr [bp - 8]
41D8  74 03           je 0x41dd
41DA  E9 F8 FE        jmp 0x40d5
loc_41DD:
41DD  8B 46 FE        mov ax, word ptr [bp - 2]
41E0  3B 46 FA        cmp ax, word ptr [bp - 6]
41E3  74 03           je 0x41e8
41E5  E9 D4 FE        jmp 0x40bc
loc_41E8:
41E8  C9              leave
41E9  C2 06 00        ret 6

; ---- routine 01EF:41EC  (found by: call)
sub_41EC:
41EC  C8 04 00 00     enter 4, 0
41F0  C7 46 FC 01 00  mov word ptr [bp - 4], 1
41F5  C7 46 FE 01 00  mov word ptr [bp - 2], 1
41FA  EB 03           jmp 0x41ff
loc_41FC:
41FC  FF 46 FE        inc word ptr [bp - 2]
loc_41FF:
41FF  FF 76 FC        push word ptr [bp - 4]
4202  8B 46 FC        mov ax, word ptr [bp - 4]
4205  05 03 00        add ax, 3
4208  50              push ax
4209  55              push bp
420A  E8 B6 FD        call 0x3fc3
420D  FF 76 FC        push word ptr [bp - 4]
4210  8B 46 FC        mov ax, word ptr [bp - 4]
4213  05 03 00        add ax, 3
4216  50              push ax
4217  55              push bp
4218  E8 86 FE        call 0x40a1
421B  83 46 FC 04     add word ptr [bp - 4], 4
421F  83 7E FE 02     cmp word ptr [bp - 2], 2
4223  75 D7           jne 0x41fc
4225  C9              leave
4226  C3              ret

; ---- routine 01EF:4227  (found by: call)
sub_4227:
4227  C8 08 00 00     enter 8, 0
422B  8B 46 08        mov ax, word ptr [bp + 8]
422E  89 46 FE        mov word ptr [bp - 2], ax
4231  8B 46 06        mov ax, word ptr [bp + 6]
4234  89 46 FC        mov word ptr [bp - 4], ax
4237  8B 46 08        mov ax, word ptr [bp + 8]
423A  03 46 06        add ax, word ptr [bp + 6]
423D  D1 E8           shr ax, 1
423F  8B F8           mov di, ax
4241  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
4245  30 E4           xor ah, ah
4247  6B C0 0C        imul ax, ax, 0xc
424A  C4 3E C6 D7     les di, ptr [0xd7c6]
424E  03 F8           add di, ax
4250  26 8A 45 F5     mov al, byte ptr es:[di - 0xb]
4254  30 E4           xor ah, ah
4256  89 46 F8        mov word ptr [bp - 8], ax
loc_4259:
4259  8B 7E FE        mov di, word ptr [bp - 2]
425C  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
4260  30 E4           xor ah, ah
4262  6B C0 0C        imul ax, ax, 0xc
4265  C4 3E C6 D7     les di, ptr [0xd7c6]
4269  03 F8           add di, ax
426B  26 8A 45 F5     mov al, byte ptr es:[di - 0xb]
426F  30 E4           xor ah, ah
4271  3B 46 F8        cmp ax, word ptr [bp - 8]
4274  76 05           jbe 0x427b
4276  FF 46 FE        inc word ptr [bp - 2]
4279  EB DE           jmp 0x4259
loc_427B:
427B  8B 7E FC        mov di, word ptr [bp - 4]
427E  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
4282  30 E4           xor ah, ah
4284  6B C0 0C        imul ax, ax, 0xc
4287  C4 3E C6 D7     les di, ptr [0xd7c6]
428B  03 F8           add di, ax
428D  26 8A 45 F5     mov al, byte ptr es:[di - 0xb]
4291  30 E4           xor ah, ah
4293  3B 46 F8        cmp ax, word ptr [bp - 8]
4296  73 05           jae 0x429d
4298  FF 4E FC        dec word ptr [bp - 4]
429B  EB DE           jmp 0x427b
loc_429D:
429D  8B 46 FE        mov ax, word ptr [bp - 2]
42A0  3B 46 FC        cmp ax, word ptr [bp - 4]
42A3  77 2A           ja 0x42cf
42A5  8B 7E FE        mov di, word ptr [bp - 2]
42A8  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
42AC  30 E4           xor ah, ah
42AE  89 46 FA        mov word ptr [bp - 6], ax
42B1  8B 7E FC        mov di, word ptr [bp - 4]
42B4  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
42B8  8B 7E FE        mov di, word ptr [bp - 2]
42BB  88 85 D5 D7     mov byte ptr [di - 0x282b], al
42BF  8A 46 FA        mov al, byte ptr [bp - 6]
42C2  8B 7E FC        mov di, word ptr [bp - 4]
42C5  88 85 D5 D7     mov byte ptr [di - 0x282b], al
42C9  FF 46 FE        inc word ptr [bp - 2]
42CC  FF 4E FC        dec word ptr [bp - 4]
loc_42CF:
42CF  8B 46 FE        mov ax, word ptr [bp - 2]
42D2  3B 46 FC        cmp ax, word ptr [bp - 4]
42D5  76 82           jbe 0x4259
42D7  8B 46 08        mov ax, word ptr [bp + 8]
42DA  3B 46 FC        cmp ax, word ptr [bp - 4]
42DD  73 0D           jae 0x42ec
42DF  FF 76 08        push word ptr [bp + 8]
42E2  FF 76 FC        push word ptr [bp - 4]
42E5  8B 7E 04        mov di, word ptr [bp + 4]
42E8  57              push di
42E9  E8 3B FF        call 0x4227
loc_42EC:
42EC  8B 46 FE        mov ax, word ptr [bp - 2]
42EF  3B 46 06        cmp ax, word ptr [bp + 6]
42F2  73 0D           jae 0x4301
42F4  FF 76 FE        push word ptr [bp - 2]
42F7  FF 76 06        push word ptr [bp + 6]
42FA  8B 7E 04        mov di, word ptr [bp + 4]
42FD  57              push di
42FE  E8 26 FF        call 0x4227
loc_4301:
4301  C9              leave
4302  C2 06 00        ret 6

; ---- routine 01EF:4305  (found by: call)
sub_4305:
4305  C8 0C 00 00     enter 0xc, 0
4309  8B 46 06        mov ax, word ptr [bp + 6]
430C  89 46 FA        mov word ptr [bp - 6], ax
430F  8B 46 08        mov ax, word ptr [bp + 8]
4312  40              inc ax
4313  3B 46 FA        cmp ax, word ptr [bp - 6]
4316  76 03           jbe 0x431b
4318  E9 31 01        jmp 0x444c
loc_431B:
431B  89 46 FE        mov word ptr [bp - 2], ax
431E  EB 03           jmp 0x4323
loc_4320:
4320  FF 46 FE        inc word ptr [bp - 2]
loc_4323:
4323  8B 46 FE        mov ax, word ptr [bp - 2]
4326  89 46 F8        mov word ptr [bp - 8], ax
4329  8B 46 06        mov ax, word ptr [bp + 6]
432C  3B 46 F8        cmp ax, word ptr [bp - 8]
432F  73 03           jae 0x4334
4331  E9 0D 01        jmp 0x4441
loc_4334:
4334  89 46 FC        mov word ptr [bp - 4], ax
4337  EB 03           jmp 0x433c
loc_4339:
4339  FF 4E FC        dec word ptr [bp - 4]
loc_433C:
433C  8B 46 FC        mov ax, word ptr [bp - 4]
433F  48              dec ax
4340  8B F8           mov di, ax
4342  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
4346  30 E4           xor ah, ah
4348  6B C0 0C        imul ax, ax, 0xc
434B  C4 3E C6 D7     les di, ptr [0xd7c6]
434F  03 F8           add di, ax
4351  81 C7 F4 FF     add di, 0xfff4
4355  89 7E F4        mov word ptr [bp - 0xc], di
4358  8C 46 F6        mov word ptr [bp - 0xa], es
435B  8B 7E FC        mov di, word ptr [bp - 4]
435E  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
4362  30 E4           xor ah, ah
4364  6B C0 0C        imul ax, ax, 0xc
4367  C4 3E C6 D7     les di, ptr [0xd7c6]
436B  03 F8           add di, ax
436D  26 8A 45 F5     mov al, byte ptr es:[di - 0xb]
4371  C4 7E F4        les di, ptr [bp - 0xc]
4374  26 3A 45 01     cmp al, byte ptr es:[di + 1]
4378  74 03           je 0x437d
437A  E9 B9 00        jmp 0x4436
loc_437D:
437D  8B 7E FC        mov di, word ptr [bp - 4]
4380  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
4384  30 E4           xor ah, ah
4386  6B C0 0C        imul ax, ax, 0xc
4389  C4 3E C6 D7     les di, ptr [0xd7c6]
438D  03 F8           add di, ax
438F  26 8B 55 FE     mov dx, word ptr es:[di - 2]
4393  8B 7E FC        mov di, word ptr [bp - 4]
4396  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
439A  30 E4           xor ah, ah
439C  6B C0 0C        imul ax, ax, 0xc
439F  C4 3E C6 D7     les di, ptr [0xd7c6]
43A3  03 F8           add di, ax
43A5  26 8B 45 FC     mov ax, word ptr es:[di - 4]
43A9  2B C2           sub ax, dx
43AB  8A D0           mov dl, al
43AD  C4 7E F4        les di, ptr [bp - 0xc]
43B0  26 8B 45 08     mov ax, word ptr es:[di + 8]
43B4  26 2B 45 0A     sub ax, word ptr es:[di + 0xa]
43B8  3A C2           cmp al, dl
43BA  7C 5E           jl 0x441a
43BC  8B 7E FC        mov di, word ptr [bp - 4]
43BF  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
43C3  30 E4           xor ah, ah
43C5  6B C0 0C        imul ax, ax, 0xc
43C8  C4 3E C6 D7     les di, ptr [0xd7c6]
43CC  03 F8           add di, ax
43CE  26 8B 55 FE     mov dx, word ptr es:[di - 2]
43D2  8B 7E FC        mov di, word ptr [bp - 4]
43D5  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
43D9  30 E4           xor ah, ah
43DB  6B C0 0C        imul ax, ax, 0xc
43DE  C4 3E C6 D7     les di, ptr [0xd7c6]
43E2  03 F8           add di, ax
43E4  26 8B 45 FC     mov ax, word ptr es:[di - 4]
43E8  2B C2           sub ax, dx
43EA  8A D0           mov dl, al
43EC  C4 7E F4        les di, ptr [bp - 0xc]
43EF  26 8B 45 08     mov ax, word ptr es:[di + 8]
43F3  26 2B 45 0A     sub ax, word ptr es:[di + 0xa]
43F7  3A C2           cmp al, dl
43F9  75 3B           jne 0x4436
43FB  8B 7E FC        mov di, word ptr [bp - 4]
43FE  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
4402  30 E4           xor ah, ah
4404  6B C0 0C        imul ax, ax, 0xc
4407  C4 3E C6 D7     les di, ptr [0xd7c6]
440B  03 F8           add di, ax
440D  26 8B 45 FC     mov ax, word ptr es:[di - 4]
4411  C4 7E F4        les di, ptr [bp - 0xc]
4414  26 3B 45 08     cmp ax, word ptr es:[di + 8]
4418  76 1C           jbe 0x4436
loc_441A:
441A  8B 7E FC        mov di, word ptr [bp - 4]
441D  81 C7 D5 D7     add di, 0xd7d5
4421  1E              push ds
4422  57              push di
4423  8B 46 FC        mov ax, word ptr [bp - 4]
4426  48              dec ax
4427  8B F8           mov di, ax
4429  81 C7 D5 D7     add di, 0xd7d5
442D  1E              push ds
442E  57              push di
442F  6A 01           push 1
4431  9A 03 02 BC 24  call far 24BC:0203
loc_4436:
4436  8B 46 FC        mov ax, word ptr [bp - 4]
4439  3B 46 F8        cmp ax, word ptr [bp - 8]
443C  74 03           je 0x4441
443E  E9 F8 FE        jmp 0x4339
loc_4441:
4441  8B 46 FE        mov ax, word ptr [bp - 2]
4444  3B 46 FA        cmp ax, word ptr [bp - 6]
4447  74 03           je 0x444c
4449  E9 D4 FE        jmp 0x4320
loc_444C:
444C  C9              leave
444D  C2 06 00        ret 6

; ---- routine 01EF:4450  (found by: call)
sub_4450:
4450  C8 0E 00 00     enter 0xe, 0
4454  C7 46 FA 01 00  mov word ptr [bp - 6], 1
4459  C7 46 FC 01 00  mov word ptr [bp - 4], 1
445E  EB 03           jmp 0x4463
loc_4460:
4460  FF 46 FC        inc word ptr [bp - 4]
loc_4463:
4463  FF 76 FA        push word ptr [bp - 6]
4466  8B 46 FA        mov ax, word ptr [bp - 6]
4469  05 0F 00        add ax, 0xf
446C  50              push ax
446D  55              push bp
446E  E8 B6 FD        call 0x4227
4471  FF 76 FA        push word ptr [bp - 6]
4474  8B 46 FA        mov ax, word ptr [bp - 6]
4477  05 0F 00        add ax, 0xf
447A  50              push ax
447B  55              push bp
447C  E8 86 FE        call 0x4305
447F  31 C0           xor ax, ax
4481  89 46 F8        mov word ptr [bp - 8], ax
4484  8B 46 FA        mov ax, word ptr [bp - 6]
4487  05 0F 00        add ax, 0xf
448A  89 46 F6        mov word ptr [bp - 0xa], ax
448D  8B 46 FA        mov ax, word ptr [bp - 6]
4490  3B 46 F6        cmp ax, word ptr [bp - 0xa]
4493  77 30           ja 0x44c5
4495  89 46 FE        mov word ptr [bp - 2], ax
4498  EB 03           jmp 0x449d
loc_449A:
449A  FF 46 FE        inc word ptr [bp - 2]
loc_449D:
449D  8B 7E FE        mov di, word ptr [bp - 2]
44A0  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
44A4  30 E4           xor ah, ah
44A6  6B C0 3E        imul ax, ax, 0x3e
44A9  C4 3E C2 D7     les di, ptr [0xd7c2]
44AD  03 F8           add di, ax
44AF  81 C7 C2 FF     add di, 0xffc2
44B3  FF 46 F8        inc word ptr [bp - 8]
44B6  8A 46 F8        mov al, byte ptr [bp - 8]
44B9  26 88 45 36     mov byte ptr es:[di + 0x36], al
44BD  8B 46 FE        mov ax, word ptr [bp - 2]
44C0  3B 46 F6        cmp ax, word ptr [bp - 0xa]
44C3  75 D5           jne 0x449a
loc_44C5:
44C5  83 46 FA 10     add word ptr [bp - 6], 0x10
44C9  83 7E FC 05     cmp word ptr [bp - 4], 5
44CD  75 91           jne 0x4460
44CF  C9              leave
44D0  C3              ret

; ---- routine 01EF:44D1  (found by: call)
sub_44D1:
44D1  C8 04 01 00     enter 0x104, 0
44D5  C4 7E 08        les di, ptr [bp + 8]
44D8  89 7E FC        mov word ptr [bp - 4], di
44DB  8C 46 FE        mov word ptr [bp - 2], es
44DE  FF 76 06        push word ptr [bp + 6]
44E1  FF 76 04        push word ptr [bp + 4]
44E4  6A 07           push 7
44E6  9A E3 0E 55 1B  call far 1B55:0EE3
44EB  8D BE FC FE     lea di, [bp - 0x104]
44EF  16              push ss
44F0  57              push di
44F1  C4 7E FC        les di, ptr [bp - 4]
44F4  26 8A 05        mov al, byte ptr es:[di]
44F7  30 E4           xor ah, ah
44F9  31 D2           xor dx, dx
44FB  52              push dx
44FC  50              push ax
44FD  9A C9 07 2A 23  call far 232A:07C9
4502  8A 46 04        mov al, byte ptr [bp + 4]
4505  50              push ax
4506  6A 1A           push 0x1a
4508  BF 5C DD        mov di, 0xdd5c
450B  1E              push ds
450C  57              push di
450D  9A 83 02 2A 23  call far 232A:0283
4512  8D BE FC FE     lea di, [bp - 0x104]
4516  16              push ss
4517  57              push di
4518  C4 7E FC        les di, ptr [bp - 4]
451B  26 8A 45 02     mov al, byte ptr es:[di + 2]
451F  30 E4           xor ah, ah
4521  31 D2           xor dx, dx
4523  52              push dx
4524  50              push ax
4525  9A C9 07 2A 23  call far 232A:07C9
452A  8A 46 04        mov al, byte ptr [bp + 4]
452D  50              push ax
452E  6A 1F           push 0x1f
4530  BF 5C DD        mov di, 0xdd5c
4533  1E              push ds
4534  57              push di
4535  9A 83 02 2A 23  call far 232A:0283
453A  8D BE FC FE     lea di, [bp - 0x104]
453E  16              push ss
453F  57              push di
4540  C4 7E FC        les di, ptr [bp - 4]
4543  26 8A 45 04     mov al, byte ptr es:[di + 4]
4547  30 E4           xor ah, ah
4549  31 D2           xor dx, dx
454B  52              push dx
454C  50              push ax
454D  9A C9 07 2A 23  call far 232A:07C9
4552  8A 46 04        mov al, byte ptr [bp + 4]
4555  50              push ax
4556  6A 24           push 0x24
4558  BF 5C DD        mov di, 0xdd5c
455B  1E              push ds
455C  57              push di
455D  9A 83 02 2A 23  call far 232A:0283
4562  8D BE FC FE     lea di, [bp - 0x104]
4566  16              push ss
4567  57              push di
4568  C4 7E FC        les di, ptr [bp - 4]
456B  26 8A 45 06     mov al, byte ptr es:[di + 6]
456F  30 E4           xor ah, ah
4571  31 D2           xor dx, dx
4573  52              push dx
4574  50              push ax
4575  9A C9 07 2A 23  call far 232A:07C9
457A  8A 46 04        mov al, byte ptr [bp + 4]
457D  50              push ax
457E  6A 29           push 0x29
4580  BF 5C DD        mov di, 0xdd5c
4583  1E              push ds
4584  57              push di
4585  9A 83 02 2A 23  call far 232A:0283
458A  8D BE FC FE     lea di, [bp - 0x104]
458E  16              push ss
458F  57              push di
4590  C4 7E FC        les di, ptr [bp - 4]
4593  26 8A 45 03     mov al, byte ptr es:[di + 3]
4597  30 E4           xor ah, ah
4599  31 D2           xor dx, dx
459B  52              push dx
459C  50              push ax
459D  9A C9 07 2A 23  call far 232A:07C9
45A2  8A 46 04        mov al, byte ptr [bp + 4]
45A5  50              push ax
45A6  6A 2E           push 0x2e
45A8  BF 5C DD        mov di, 0xdd5c
45AB  1E              push ds
45AC  57              push di
45AD  9A 83 02 2A 23  call far 232A:0283
45B2  8D BE FC FE     lea di, [bp - 0x104]
45B6  16              push ss
45B7  57              push di
45B8  C4 7E FC        les di, ptr [bp - 4]
45BB  26 8A 45 05     mov al, byte ptr es:[di + 5]
45BF  30 E4           xor ah, ah
45C1  31 D2           xor dx, dx
45C3  52              push dx
45C4  50              push ax
45C5  9A C9 07 2A 23  call far 232A:07C9
45CA  8A 46 04        mov al, byte ptr [bp + 4]
45CD  50              push ax
45CE  6A 33           push 0x33
45D0  BF 5C DD        mov di, 0xdd5c
45D3  1E              push ds
45D4  57              push di
45D5  9A 83 02 2A 23  call far 232A:0283
45DA  8D BE FC FE     lea di, [bp - 0x104]
45DE  16              push ss
45DF  57              push di
45E0  C4 7E FC        les di, ptr [bp - 4]
45E3  26 8A 45 07     mov al, byte ptr es:[di + 7]
45E7  30 E4           xor ah, ah
45E9  31 D2           xor dx, dx
45EB  52              push dx
45EC  50              push ax
45ED  9A C9 07 2A 23  call far 232A:07C9
45F2  8A 46 04        mov al, byte ptr [bp + 4]
45F5  50              push ax
45F6  6A 38           push 0x38
45F8  BF 5C DD        mov di, 0xdd5c
45FB  1E              push ds
45FC  57              push di
45FD  9A 83 02 2A 23  call far 232A:0283
4602  8D BE FC FE     lea di, [bp - 0x104]
4606  16              push ss
4607  57              push di
4608  C4 7E FC        les di, ptr [bp - 4]
460B  26 8B 45 08     mov ax, word ptr es:[di + 8]
460F  31 D2           xor dx, dx
4611  52              push dx
4612  50              push ax
4613  9A C9 07 2A 23  call far 232A:07C9
4618  8A 46 04        mov al, byte ptr [bp + 4]
461B  50              push ax
461C  6A 3E           push 0x3e
461E  BF 5C DD        mov di, 0xdd5c
4621  1E              push ds
4622  57              push di
4623  9A 83 02 2A 23  call far 232A:0283
4628  8D BE FC FE     lea di, [bp - 0x104]
462C  16              push ss
462D  57              push di
462E  C4 7E FC        les di, ptr [bp - 4]
4631  26 8B 45 0A     mov ax, word ptr es:[di + 0xa]
4635  31 D2           xor dx, dx
4637  52              push dx
4638  50              push ax
4639  9A C9 07 2A 23  call far 232A:07C9
463E  8A 46 04        mov al, byte ptr [bp + 4]
4641  50              push ax
4642  6A 44           push 0x44
4644  BF 5C DD        mov di, 0xdd5c
4647  1E              push ds
4648  57              push di
4649  9A 83 02 2A 23  call far 232A:0283
464E  8D BE FC FE     lea di, [bp - 0x104]
4652  16              push ss
4653  57              push di
4654  C4 7E FC        les di, ptr [bp - 4]
4657  26 8A 45 01     mov al, byte ptr es:[di + 1]
465B  30 E4           xor ah, ah
465D  31 D2           xor dx, dx
465F  52              push dx
4660  50              push ax
4661  9A C9 07 2A 23  call far 232A:07C9
4666  8A 46 04        mov al, byte ptr [bp + 4]
4669  50              push ax
466A  6A 4A           push 0x4a
466C  BF 5C DD        mov di, 0xdd5c
466F  1E              push ds
4670  57              push di
4671  9A 83 02 2A 23  call far 232A:0283
4676  C9              leave
4677  C2 08 00        ret 8

