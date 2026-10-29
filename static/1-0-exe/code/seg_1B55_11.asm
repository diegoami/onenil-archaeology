; 1-0.EXE (One-Nil 96), code segment 1B55 (image offsets 1B550..2315F), part 11 of 12
; packed 1-0.EXE sha256 89ff9c5f238f24e81a0c2440a46cdd8997280a65fc3cc3d97cb974f55280a80a (LZEXE 0.91)
; unpacked (tools/static/unlzexe.py) sha256 887ed2a92767950e5309b2052409f875668605939b69e00737aa3047022b9f51
; tool: capstone 5.0.9 (pip package; core library 5.0.1280) (CS_ARCH_X86, CS_MODE_16), recursive descent from the entry point, far calls and near calls/jumps, then routine prologues (55 89 E5 / 55 8B EC / C8 iw 00) in what remains; tools/static/listing.py
; addresses are SEGMENT:OFFSET with SEGMENT the image paragraph before relocation; image offset = SEGMENT*16+OFFSET
; ---- routine 1B55:6DE4  (found by: call)
sub_6DE4:
6DE4  C8 02 00 00     enter 2, 0
6DE8  C4 7E 06        les di, ptr [bp + 6]
6DEB  06              push es
6DEC  57              push di
6DED  8B 7E 04        mov di, word ptr [bp + 4]
6DF0  81 C7 D2 FF     add di, 0xffd2
6DF4  16              push ss
6DF5  57              push di
6DF6  6A 28           push 0x28
6DF8  9A C2 01 BC 24  call far 24BC:01C2
6DFD  C7 46 FE 01 00  mov word ptr [bp - 2], 1
6E02  EB 03           jmp 0x6e07
loc_6E04:
6E04  FF 46 FE        inc word ptr [bp - 2]
loc_6E07:
6E07  6A 14           push 0x14
6E09  9A 6D 07 2A 23  call far 232A:076D
6E0E  D1 E0           shl ax, 1
6E10  C4 7E 06        les di, ptr [bp + 6]
6E13  03 F8           add di, ax
6E15  81 C7 FE FF     add di, 0xfffe
6E19  06              push es
6E1A  57              push di
6E1B  6A 14           push 0x14
6E1D  9A 6D 07 2A 23  call far 232A:076D
6E22  D1 E0           shl ax, 1
6E24  C4 7E 06        les di, ptr [bp + 6]
6E27  03 F8           add di, ax
6E29  81 C7 FE FF     add di, 0xfffe
6E2D  06              push es
6E2E  57              push di
6E2F  6A 02           push 2
6E31  9A 03 02 BC 24  call far 24BC:0203
6E36  83 7E FE 0A     cmp word ptr [bp - 2], 0xa
6E3A  75 C8           jne 0x6e04
6E3C  C9              leave
6E3D  C2 06 00        ret 6

; ---- routine 1B55:6E40  (found by: call)
sub_6E40:
6E40  55              push bp
6E41  89 E5           mov bp, sp
6E43  C4 7E 06        les di, ptr [bp + 6]
6E46  06              push es
6E47  57              push di
6E48  8B 7E 04        mov di, word ptr [bp + 4]
6E4B  57              push di
6E4C  E8 95 FF        call 0x6de4
6E4F  C4 7E 06        les di, ptr [bp + 6]
6E52  06              push es
6E53  57              push di
6E54  8B 7E 04        mov di, word ptr [bp + 4]
6E57  57              push di
6E58  E8 A9 FE        call 0x6d04
6E5B  8B 7E 04        mov di, word ptr [bp + 4]
6E5E  81 C7 D2 FF     add di, 0xffd2
6E62  16              push ss
6E63  57              push di
6E64  C4 7E 06        les di, ptr [bp + 6]
6E67  06              push es
6E68  57              push di
6E69  6A 28           push 0x28
6E6B  9A C2 01 BC 24  call far 24BC:01C2
6E70  C9              leave
6E71  C2 06 00        ret 6

; ---- routine 1B55:6E74  (found by: far)
sub_6E74:
6E74  C8 2E 00 00     enter 0x2e, 0
6E78  C7 46 FC 01 00  mov word ptr [bp - 4], 1
6E7D  EB 03           jmp 0x6e82
loc_6E7F:
6E7F  FF 46 FC        inc word ptr [bp - 4]
loc_6E82:
6E82  8B 7E FC        mov di, word ptr [bp - 4]
6E85  80 BD B9 DC 00  cmp byte ptr [di - 0x2347], 0
6E8A  74 4B           je 0x6ed7
6E8C  31 C0           xor ax, ax
6E8E  89 46 FE        mov word ptr [bp - 2], ax
6E91  8B 7E FC        mov di, word ptr [bp - 4]
6E94  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
6E98  30 E4           xor ah, ah
6E9A  C4 3E B6 D7     les di, ptr [0xd7b6]
6E9E  03 F8           add di, ax
6EA0  26 8A 45 FF     mov al, byte ptr es:[di - 1]
6EA4  88 46 FB        mov byte ptr [bp - 5], al
6EA7  8B 7E FC        mov di, word ptr [bp - 4]
6EAA  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
6EAE  30 E4           xor ah, ah
6EB0  6B C0 3E        imul ax, ax, 0x3e
6EB3  C4 3E C2 D7     les di, ptr [0xd7c2]
6EB7  03 F8           add di, ax
6EB9  81 C7 C2 FF     add di, 0xffc2
6EBD  06              push es
6EBE  57              push di
6EBF  55              push bp
6EC0  E8 7D FF        call 0x6e40
6EC3  6B 46 FC 28     imul ax, word ptr [bp - 4], 0x28
6EC7  C4 3E D2 D7     les di, ptr [0xd7d2]
6ECB  03 F8           add di, ax
6ECD  81 C7 30 00     add di, 0x30
6ED1  06              push es
6ED2  57              push di
6ED3  55              push bp
6ED4  E8 69 FF        call 0x6e40
loc_6ED7:
6ED7  83 7E FC 02     cmp word ptr [bp - 4], 2
6EDB  75 A2           jne 0x6e7f
6EDD  C9              leave
6EDE  CB              retf

; ---- routine 1B55:6EDF  (found by: call)
sub_6EDF:
6EDF  C8 52 00 00     enter 0x52, 0
6EE3  8C D3           mov bx, ss
6EE5  8E C3           mov es, bx
6EE7  8C DB           mov bx, ds
6EE9  FC              cld
6EEA  8D 7E AE        lea di, [bp - 0x52]
6EED  C5 76 06        lds si, ptr [bp + 6]
6EF0  AC              lodsb al, byte ptr [si]
6EF1  3C 50           cmp al, 0x50
6EF3  72 02           jb 0x6ef7
6EF5  B0 50           mov al, 0x50
loc_6EF7:
6EF7  AA              stosb byte ptr es:[di], al
6EF8  91              xchg cx, ax
6EF9  30 ED           xor ch, ch
6EFB  F3 A4           rep movsb byte ptr es:[di], byte ptr [si]
6EFD  8E DB           mov ds, bx
6EFF  BF 70 2B        mov di, 0x2b70
6F02  1E              push ds
6F03  57              push di
6F04  BF 5C DD        mov di, 0xdd5c
6F07  1E              push ds
6F08  57              push di
6F09  9A 2F 05 2A 23  call far 232A:052F
6F0E  8B 7E 04        mov di, word ptr [bp + 4]
6F11  36 8B 7D 08     mov di, word ptr ss:[di + 8]
6F15  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
6F19  30 E4           xor ah, ah
6F1B  50              push ax
6F1C  6A 01           push 1
6F1E  6A 01           push 1
6F20  0E              push cs
6F21  E8 BF 9F        call 0xee3
6F24  BF DA 4E        mov di, 0x4eda
6F27  1E              push ds
6F28  57              push di
6F29  BF 5C DD        mov di, 0xdd5c
6F2C  1E              push ds
6F2D  57              push di
6F2E  9A 2F 05 2A 23  call far 232A:052F
6F33  6A 0F           push 0xf
6F35  8D 7E AE        lea di, [bp - 0x52]
6F38  16              push ss
6F39  57              push di
6F3A  6A 17           push 0x17
6F3C  6A 01           push 1
6F3E  BF 5C DD        mov di, 0xdd5c
6F41  1E              push ds
6F42  57              push di
6F43  9A 1B 04 2A 23  call far 232A:041B
6F48  C4 3E 5C DD     les di, ptr [0xdd5c]
6F4C  06              push es
6F4D  57              push di
6F4E  C4 3E 58 DD     les di, ptr [0xdd58]
6F52  06              push es
6F53  57              push di
6F54  68 A0 0F        push 0xfa0
6F57  9A 12 0A C9 26  call far 26C9:0A12
6F5C  9A 9B 09 2A 23  call far 232A:099B
6F61  C9              leave
6F62  C2 06 00        ret 6
; data (not reached as code), 26 bytes
6F65                  pstr 'THE '
6F6A                  pstr 'ON GAINING PROMOTION'

; ---- routine 1B55:6F7F  (found by: call, far)
sub_6F7F:
6F7F  C8 04 02 00     enter 0x204, 0
6F83  8B 7E 08        mov di, word ptr [bp + 8]
6F86  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
6F8A  30 E4           xor ah, ah
6F8C  6B C0 3E        imul ax, ax, 0x3e
6F8F  C4 3E C2 D7     les di, ptr [0xd7c2]
6F93  03 F8           add di, ax
6F95  81 C7 C2 FF     add di, 0xffc2
6F99  89 7E FC        mov word ptr [bp - 4], di
6F9C  8C 46 FE        mov word ptr [bp - 2], es
6F9F  80 7E 06 00     cmp byte ptr [bp + 6], 0
6FA3  74 3C           je 0x6fe1
6FA5  8D BE FC FE     lea di, [bp - 0x104]
6FA9  16              push ss
6FAA  57              push di
6FAB  BF 18 13        mov di, 0x1318
6FAE  1E              push ds
6FAF  57              push di
6FB0  9A 53 0B C9 26  call far 26C9:0B53
6FB5  BF 65 6F        mov di, 0x6f65
6FB8  0E              push cs
6FB9  57              push di
6FBA  9A D2 0B C9 26  call far 26C9:0BD2
6FBF  8D BE FC FD     lea di, [bp - 0x204]
6FC3  16              push ss
6FC4  57              push di
6FC5  8A 46 06        mov al, byte ptr [bp + 6]
6FC8  50              push ax
6FC9  C4 3E D2 D7     les di, ptr [0xd7d2]
6FCD  26 8A 05        mov al, byte ptr es:[di]
6FD0  50              push ax
6FD1  0E              push cs
6FD2  E8 DC A2        call 0x12b1
6FD5  9A D2 0B C9 26  call far 26C9:0BD2
6FDA  55              push bp
6FDB  E8 01 FF        call 0x6edf
6FDE  E9 AB 00        jmp 0x708c
loc_6FE1:
6FE1  6B 46 08 09     imul ax, word ptr [bp + 8], 9
6FE5  C4 3E BC DC     les di, ptr [0xdcbc]
6FE9  03 F8           add di, ax
6FEB  26 8A 45 20     mov al, byte ptr es:[di + 0x20]
6FEF  C4 7E FC        les di, ptr [bp - 4]
6FF2  26 3A 45 37     cmp al, byte ptr es:[di + 0x37]
6FF6  75 74           jne 0x706c
6FF8  26 80 7D 36 01  cmp byte ptr es:[di + 0x36], 1
6FFD  75 6D           jne 0x706c
6FFF  26 80 7D 37 00  cmp byte ptr es:[di + 0x37], 0
7004  75 38           jne 0x703e
7006  8D BE FC FE     lea di, [bp - 0x104]
700A  16              push ss
700B  57              push di
700C  BF 18 13        mov di, 0x1318
700F  1E              push ds
7010  57              push di
7011  9A 53 0B C9 26  call far 26C9:0B53
7016  BF 65 6F        mov di, 0x6f65
7019  0E              push cs
701A  57              push di
701B  9A D2 0B C9 26  call far 26C9:0BD2
7020  C4 7E FC        les di, ptr [bp - 4]
7023  26 8A 45 37     mov al, byte ptr es:[di + 0x37]
7027  98              cwde
7028  8B F8           mov di, ax
702A  C1 E7 04        shl di, 4
702D  81 C7 E6 DC     add di, 0xdce6
7031  1E              push ds
7032  57              push di
7033  9A D2 0B C9 26  call far 26C9:0BD2
7038  55              push bp
7039  E8 A3 FE        call 0x6edf
703C  EB 2C           jmp 0x706a
loc_703E:
703E  8D BE FC FE     lea di, [bp - 0x104]
7042  16              push ss
7043  57              push di
7044  BF 18 13        mov di, 0x1318
7047  1E              push ds
7048  57              push di
7049  9A 53 0B C9 26  call far 26C9:0B53
704E  C4 7E FC        les di, ptr [bp - 4]
7051  26 8A 45 37     mov al, byte ptr es:[di + 0x37]
7055  98              cwde
7056  8B F8           mov di, ax
7058  C1 E7 04        shl di, 4
705B  81 C7 E6 DC     add di, 0xdce6
705F  1E              push ds
7060  57              push di
7061  9A D2 0B C9 26  call far 26C9:0BD2
7066  55              push bp
7067  E8 75 FE        call 0x6edf
loc_706A:
706A  EB 20           jmp 0x708c
loc_706C:
706C  6B 46 08 09     imul ax, word ptr [bp + 8], 9
7070  C4 3E BC DC     les di, ptr [0xdcbc]
7074  03 F8           add di, ax
7076  26 8A 45 20     mov al, byte ptr es:[di + 0x20]
707A  C4 7E FC        les di, ptr [bp - 4]
707D  26 3A 45 37     cmp al, byte ptr es:[di + 0x37]
7081  7E 09           jle 0x708c
7083  BF 6A 6F        mov di, 0x6f6a
7086  0E              push cs
7087  57              push di
7088  55              push bp
7089  E8 53 FE        call 0x6edf
loc_708C:
708C  C9              leave
708D  CA 04 00        retf 4

; ---- routine 1B55:7090  (found by: call)
sub_7090:
7090  C8 06 00 00     enter 6, 0
7094  BF 6A 71        mov di, 0x716a
7097  1E              push ds
7098  57              push di
7099  BF 5C DD        mov di, 0xdd5c
709C  1E              push ds
709D  57              push di
709E  9A 2F 05 2A 23  call far 232A:052F
70A3  BF DA 4E        mov di, 0x4eda
70A6  1E              push ds
70A7  57              push di
70A8  BF 5C DD        mov di, 0xdd5c
70AB  1E              push ds
70AC  57              push di
70AD  9A 2F 05 2A 23  call far 232A:052F
70B2  C6 46 FF 00     mov byte ptr [bp - 1], 0
70B6  EB 03           jmp 0x70bb
loc_70B8:
70B8  FE 46 FF        inc byte ptr [bp - 1]
loc_70BB:
70BB  C4 3E D2 D7     les di, ptr [0xd7d2]
70BF  89 7E FA        mov word ptr [bp - 6], di
70C2  8C 46 FC        mov word ptr [bp - 4], es
70C5  8A 46 FF        mov al, byte ptr [bp - 1]
70C8  98              cwde
70C9  8B F8           mov di, ax
70CB  8A 85 3C A2     mov al, byte ptr [di - 0x5dc4]
70CF  50              push ax
70D0  8A 46 FF        mov al, byte ptr [bp - 1]
70D3  98              cwde
70D4  8B F8           mov di, ax
70D6  C1 E7 04        shl di, 4
70D9  81 C7 E6 DC     add di, 0xdce6
70DD  1E              push ds
70DE  57              push di
70DF  8A 46 FF        mov al, byte ptr [bp - 1]
70E2  30 E4           xor ah, ah
70E4  05 13 00        add ax, 0x13
70E7  50              push ax
70E8  6A 0F           push 0xf
70EA  BF 5C DD        mov di, 0xdd5c
70ED  1E              push ds
70EE  57              push di
70EF  9A 1B 04 2A 23  call far 232A:041B
70F4  8A 46 FF        mov al, byte ptr [bp - 1]
70F7  98              cwde
70F8  C4 7E FA        les di, ptr [bp - 6]
70FB  03 F8           add di, ax
70FD  26 8A 45 21     mov al, byte ptr es:[di + 0x21]
7101  30 E4           xor ah, ah
7103  50              push ax
7104  8A 46 FF        mov al, byte ptr [bp - 1]
7107  30 E4           xor ah, ah
7109  05 13 00        add ax, 0x13
710C  50              push ax
710D  6A 33           push 0x33
710F  0E              push cs
7110  E8 D0 9D        call 0xee3
7113  8A 46 FF        mov al, byte ptr [bp - 1]
7116  98              cwde
7117  D1 E0           shl ax, 1
7119  C4 7E FA        les di, ptr [bp - 6]
711C  03 F8           add di, ax
711E  26 6B 45 26 0B  imul ax, word ptr es:[di + 0x26], 0xb
7123  C4 3E CC DC     les di, ptr [0xdccc]
7127  03 F8           add di, ax
7129  06              push es
712A  57              push di
712B  8A 46 FF        mov al, byte ptr [bp - 1]
712E  30 E4           xor ah, ah
7130  05 13 00        add ax, 0x13
7133  50              push ax
7134  6A 20           push 0x20
7136  BF 5C DD        mov di, 0xdd5c
7139  1E              push ds
713A  57              push di
713B  9A 9D 03 2A 23  call far 232A:039D
7140  80 7E FF 04     cmp byte ptr [bp - 1], 4
7144  74 03           je 0x7149
7146  E9 6F FF        jmp 0x70b8
loc_7149:
7149  C4 3E 5C DD     les di, ptr [0xdd5c]
714D  06              push es
714E  57              push di
714F  C4 3E 58 DD     les di, ptr [0xdd58]
7153  06              push es
7154  57              push di
7155  68 A0 0F        push 0xfa0
7158  9A 12 0A C9 26  call far 26C9:0A12
715D  9A 9B 09 2A 23  call far 232A:099B
7162  C9              leave
7163  C3              ret

; ---- routine 1B55:7164  (found by: far)
sub_7164:
7164  C8 0E 00 00     enter 0xe, 0
7168  C7 46 FA 01 00  mov word ptr [bp - 6], 1
716D  C6 46 F9 00     mov byte ptr [bp - 7], 0
7171  EB 03           jmp 0x7176
loc_7173:
7173  FE 46 F9        inc byte ptr [bp - 7]
loc_7176:
7176  31 C0           xor ax, ax
7178  89 46 FE        mov word ptr [bp - 2], ax
717B  8B 46 FA        mov ax, word ptr [bp - 6]
717E  05 0F 00        add ax, 0xf
7181  89 46 F6        mov word ptr [bp - 0xa], ax
7184  8B 46 FA        mov ax, word ptr [bp - 6]
7187  3B 46 F6        cmp ax, word ptr [bp - 0xa]
718A  77 75           ja 0x7201
718C  89 46 FC        mov word ptr [bp - 4], ax
718F  EB 03           jmp 0x7194
loc_7191:
7191  FF 46 FC        inc word ptr [bp - 4]
loc_7194:
7194  8B 7E FC        mov di, word ptr [bp - 4]
7197  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
719B  30 E4           xor ah, ah
719D  6B C0 3E        imul ax, ax, 0x3e
71A0  C4 3E C2 D7     les di, ptr [0xd7c2]
71A4  03 F8           add di, ax
71A6  81 C7 C2 FF     add di, 0xffc2
71AA  26 8A 45 35     mov al, byte ptr es:[di + 0x35]
71AE  30 E4           xor ah, ah
71B0  3B 46 FE        cmp ax, word ptr [bp - 2]
71B3  76 44           jbe 0x71f9
71B5  26 8A 45 35     mov al, byte ptr es:[di + 0x35]
71B9  30 E4           xor ah, ah
71BB  89 46 FE        mov word ptr [bp - 2], ax
71BE  8B 7E FC        mov di, word ptr [bp - 4]
71C1  8A 95 D5 D7     mov dl, byte ptr [di - 0x282b]
71C5  8A 46 F9        mov al, byte ptr [bp - 7]
71C8  98              cwde
71C9  C4 3E D2 D7     les di, ptr [0xd7d2]
71CD  03 F8           add di, ax
71CF  26 88 55 21     mov byte ptr es:[di + 0x21], dl
71D3  8B 7E FC        mov di, word ptr [bp - 4]
71D6  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
71DA  30 E4           xor ah, ah
71DC  6B C0 3E        imul ax, ax, 0x3e
71DF  C4 3E C2 D7     les di, ptr [0xd7c2]
71E3  03 F8           add di, ax
71E5  26 8B 55 EA     mov dx, word ptr es:[di - 0x16]
71E9  8A 46 F9        mov al, byte ptr [bp - 7]
71EC  98              cwde
71ED  D1 E0           shl ax, 1
71EF  C4 3E D2 D7     les di, ptr [0xd7d2]
71F3  03 F8           add di, ax
71F5  26 89 55 26     mov word ptr es:[di + 0x26], dx
loc_71F9:
71F9  8B 46 FC        mov ax, word ptr [bp - 4]
71FC  3B 46 F6        cmp ax, word ptr [bp - 0xa]
71FF  75 90           jne 0x7191
loc_7201:
7201  83 46 FA 10     add word ptr [bp - 6], 0x10
7205  8A 46 F9        mov al, byte ptr [bp - 7]
7208  98              cwde
7209  C4 3E D2 D7     les di, ptr [0xd7d2]
720D  03 F8           add di, ax
720F  26 8A 45 21     mov al, byte ptr es:[di + 0x21]
7213  30 E4           xor ah, ah
7215  50              push ax
7216  6A 04           push 4
7218  0E              push cs
7219  E8 73 D8        call 0x4a8f
721C  80 7E F9 04     cmp byte ptr [bp - 7], 4
7220  74 03           je 0x7225
7222  E9 4E FF        jmp 0x7173
loc_7225:
7225  C7 46 FC 01 00  mov word ptr [bp - 4], 1
722A  EB 03           jmp 0x722f
loc_722C:
722C  FF 46 FC        inc word ptr [bp - 4]
loc_722F:
722F  6B 46 FC 3E     imul ax, word ptr [bp - 4], 0x3e
7233  C4 3E C2 D7     les di, ptr [0xd7c2]
7237  03 F8           add di, ax
7239  26 C6 45 F7 00  mov byte ptr es:[di - 9], 0
723E  81 7E FC B0 00  cmp word ptr [bp - 4], 0xb0
7243  75 E7           jne 0x722c
7245  E8 48 FE        call 0x7090
7248  C9              leave
7249  CB              retf

; ---- routine 1B55:724A  (found by: call, far)
sub_724A:
724A  C8 0A 00 00     enter 0xa, 0
724E  6B 46 08 0F     imul ax, word ptr [bp + 8], 0xf
7252  C4 3E BE D7     les di, ptr [0xd7be]
7256  03 F8           add di, ax
7258  89 7E FA        mov word ptr [bp - 6], di
725B  8C 46 FC        mov word ptr [bp - 4], es
725E  8B 46 08        mov ax, word ptr [bp + 8]
7261  C1 E0 03        shl ax, 3
7264  C4 3E BA D7     les di, ptr [0xd7ba]
7268  03 F8           add di, ax
726A  C4 7E FA        les di, ptr [bp - 6]
726D  26 80 7D 08 00  cmp byte ptr es:[di + 8], 0
7272  75 06           jne 0x727a
7274  C6 46 FF 06     mov byte ptr [bp - 1], 6
7278  EB 55           jmp 0x72cf
loc_727A:
727A  6A 08           push 8
727C  C4 7E FA        les di, ptr [bp - 6]
727F  26 8A 45 0B     mov al, byte ptr es:[di + 0xb]
7283  30 E4           xor ah, ah
7285  50              push ax
7286  9A 59 02 BC 24  call far 24BC:0259
728B  08 C0           or al, al
728D  75 15           jne 0x72a4
728F  6A 06           push 6
7291  C4 7E FA        les di, ptr [bp - 6]
7294  26 8A 45 0B     mov al, byte ptr es:[di + 0xb]
7298  30 E4           xor ah, ah
729A  50              push ax
729B  9A 59 02 BC 24  call far 24BC:0259
72A0  08 C0           or al, al
72A2  74 06           je 0x72aa
loc_72A4:
72A4  C6 46 FF 05     mov byte ptr [bp - 1], 5
72A8  EB 25           jmp 0x72cf
loc_72AA:
72AA  6A 02           push 2
72AC  C4 7E FA        les di, ptr [bp - 6]
72AF  26 8A 45 0B     mov al, byte ptr es:[di + 0xb]
72B3  30 E4           xor ah, ah
72B5  50              push ax
72B6  9A 59 02 BC 24  call far 24BC:0259
72BB  08 C0           or al, al
72BD  74 06           je 0x72c5
72BF  C6 46 FF 04     mov byte ptr [bp - 1], 4
72C3  EB 0A           jmp 0x72cf
loc_72C5:
72C5  8B 7E 06        mov di, word ptr [bp + 6]
72C8  8A 85 08 87     mov al, byte ptr [di - 0x78f8]
72CC  88 46 FF        mov byte ptr [bp - 1], al
loc_72CF:
72CF  8A 46 FF        mov al, byte ptr [bp - 1]
72D2  C9              leave
72D3  CA 04 00        retf 4

; ---- routine 1B55:72D6  (found by: call)
sub_72D6:
72D6  C8 06 00 00     enter 6, 0
72DA  80 7E 0A 08     cmp byte ptr [bp + 0xa], 8
72DE  75 48           jne 0x7328
72E0  8B 7E 04        mov di, word ptr [bp + 4]
72E3  36 FF 75 08     push word ptr ss:[di + 8]
72E7  6A 30           push 0x30
72E9  6A 35           push 0x35
72EB  0E              push cs
72EC  E8 EB A7        call 0x1ada
72EF  08 C0           or al, al
72F1  74 0C           je 0x72ff
72F3  8B 7E 04        mov di, word ptr [bp + 4]
72F6  36 8B 45 08     mov ax, word ptr ss:[di + 8]
72FA  89 46 FE        mov word ptr [bp - 2], ax
72FD  EB 27           jmp 0x7326
loc_72FF:
72FF  8B 7E 04        mov di, word ptr [bp + 4]
7302  36 8B 45 06     mov ax, word ptr ss:[di + 6]
7306  8B F0           mov si, ax
7308  D1 E0           shl ax, 1
730A  01 F0           add ax, si
730C  8B D0           mov dx, ax
730E  36 69 45 08 AE 00 imul ax, word ptr ss:[di + 8], 0xae
7314  C4 3E CA D7     les di, ptr [0xd7ca]
7318  03 F8           add di, ax
731A  03 FA           add di, dx
731C  26 8A 85 50 FF  mov al, byte ptr es:[di - 0xb0]
7321  30 E4           xor ah, ah
7323  89 46 FE        mov word ptr [bp - 2], ax
loc_7326:
7326  EB 46           jmp 0x736e
loc_7328:
7328  8B 7E 04        mov di, word ptr [bp + 4]
732B  36 FF 75 08     push word ptr ss:[di + 8]
732F  36 FF 75 06     push word ptr ss:[di + 6]
7333  0E              push cs
7334  E8 FE A3        call 0x1735
7337  08 C0           or al, al
7339  74 0C           je 0x7347
733B  8B 7E 04        mov di, word ptr [bp + 4]
733E  36 8B 45 08     mov ax, word ptr ss:[di + 8]
7342  89 46 FE        mov word ptr [bp - 2], ax
7345  EB 27           jmp 0x736e
loc_7347:
7347  8B 7E 04        mov di, word ptr [bp + 4]
734A  36 8B 45 06     mov ax, word ptr ss:[di + 6]
734E  8B F0           mov si, ax
7350  D1 E0           shl ax, 1
7352  01 F0           add ax, si
7354  8B D0           mov dx, ax
7356  36 69 45 08 AE 00 imul ax, word ptr ss:[di + 8], 0xae
735C  C4 3E CA D7     les di, ptr [0xd7ca]
7360  03 F8           add di, ax
7362  03 FA           add di, dx
7364  26 8A 85 50 FF  mov al, byte ptr es:[di - 0xb0]
7369  30 E4           xor ah, ah
736B  89 46 FE        mov word ptr [bp - 2], ax
loc_736E:
736E  FF 76 FE        push word ptr [bp - 2]
7371  FF 76 06        push word ptr [bp + 6]
7374  0E              push cs
7375  E8 A4 D7        call 0x4b1c
7378  6B 46 FE 3E     imul ax, word ptr [bp - 2], 0x3e
737C  C4 3E C2 D7     les di, ptr [0xd7c2]
7380  03 F8           add di, ax
7382  81 C7 C2 FF     add di, 0xffc2
7386  8A 46 08        mov al, byte ptr [bp + 8]
7389  26 88 45 38     mov byte ptr es:[di + 0x38], al
738D  FF 76 FE        push word ptr [bp - 2]
7390  0E              push cs
7391  E8 E6 9A        call 0xe7a
7394  08 C0           or al, al
7396  74 39           je 0x73d1
7398  A0 BA DC        mov al, byte ptr [0xdcba]
739B  30 E4           xor ah, ah
739D  3B 46 FE        cmp ax, word ptr [bp - 2]
73A0  B0 00           mov al, 0
73A2  74 01           je 0x73a5
73A4  40              inc ax
loc_73A5:
73A5  30 E4           xor ah, ah
73A7  40              inc ax
73A8  50              push ax
73A9  8A 46 0A        mov al, byte ptr [bp + 0xa]
73AC  50              push ax
73AD  0E              push cs
73AE  E8 CE FB        call 0x6f7f
73B1  A0 BA DC        mov al, byte ptr [0xdcba]
73B4  30 E4           xor ah, ah
73B6  3B 46 FE        cmp ax, word ptr [bp - 2]
73B9  B0 00           mov al, 0
73BB  74 01           je 0x73be
73BD  40              inc ax
loc_73BE:
73BE  30 E4           xor ah, ah
73C0  40              inc ax
73C1  50              push ax
73C2  8B 7E 04        mov di, word ptr [bp + 4]
73C5  36 FF 75 06     push word ptr ss:[di + 6]
73C9  8A 46 0A        mov al, byte ptr [bp + 0xa]
73CC  50              push ax
73CD  0E              push cs
73CE  E8 E0 C0        call 0x34b1
loc_73D1:
73D1  C9              leave
73D2  C2 08 00        ret 8

; ---- routine 1B55:73D5  (found by: far)
sub_73D5:
73D5  C8 04 00 00     enter 4, 0
73D9  C4 3E D2 D7     les di, ptr [0xd7d2]
73DD  26 8A 05        mov al, byte ptr es:[di]
73E0  3C 25           cmp al, 0x25
73E2  75 0C           jne 0x73f0
73E4  6A 03           push 3
73E6  6A 08           push 8
73E8  6A 02           push 2
73EA  55              push bp
73EB  E8 E8 FE        call 0x72d6
73EE  EB 3E           jmp 0x742e
loc_73F0:
73F0  3C 33           cmp al, 0x33
73F2  75 0C           jne 0x7400
73F4  6A 04           push 4
73F6  6A 07           push 7
73F8  6A 02           push 2
73FA  55              push bp
73FB  E8 D8 FE        call 0x72d6
73FE  EB 2E           jmp 0x742e
loc_7400:
7400  3C 30           cmp al, 0x30
7402  75 0C           jne 0x7410
7404  6A 07           push 7
7406  6A 07           push 7
7408  6A 04           push 4
740A  55              push bp
740B  E8 C8 FE        call 0x72d6
740E  EB 1E           jmp 0x742e
loc_7410:
7410  3C 35           cmp al, 0x35
7412  75 0C           jne 0x7420
7414  6A 08           push 8
7416  6A 08           push 8
7418  6A 04           push 4
741A  55              push bp
741B  E8 B8 FE        call 0x72d6
741E  EB 0E           jmp 0x742e
loc_7420:
7420  3C 39           cmp al, 0x39
7422  75 0A           jne 0x742e
7424  6A 06           push 6
7426  6A 06           push 6
7428  6A 06           push 6
742A  55              push bp
742B  E8 A8 FE        call 0x72d6
loc_742E:
742E  C9              leave
742F  CA 04 00        retf 4

; ---- routine 1B55:7432  (found by: call)
sub_7432:
7432  C8 02 00 00     enter 2, 0
7436  C7 46 FE 12 00  mov word ptr [bp - 2], 0x12
loc_743B:
743B  8B 7E FE        mov di, word ptr [bp - 2]
743E  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
7442  30 E4           xor ah, ah
7444  6B C0 3E        imul ax, ax, 0x3e
7447  C4 3E C2 D7     les di, ptr [0xd7c2]
744B  03 F8           add di, ax
744D  26 8A 45 FA     mov al, byte ptr es:[di - 6]
7451  3A 46 06        cmp al, byte ptr [bp + 6]
7454  7F 05           jg 0x745b
7456  FF 46 FE        inc word ptr [bp - 2]
7459  EB E0           jmp 0x743b
loc_745B:
745B  8A 56 06        mov dl, byte ptr [bp + 6]
745E  8B 7E FE        mov di, word ptr [bp - 2]
7461  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
7465  30 E4           xor ah, ah
7467  6B C0 3E        imul ax, ax, 0x3e
746A  C4 3E C2 D7     les di, ptr [0xd7c2]
746E  03 F8           add di, ax
7470  26 88 55 FA     mov byte ptr es:[di - 6], dl
7474  C9              leave
7475  C2 04 00        ret 4

; ---- routine 1B55:7478  (found by: call)
sub_7478:
7478  C8 08 00 00     enter 8, 0
747C  C4 3E BC DC     les di, ptr [0xdcbc]
7480  8A 46 08        mov al, byte ptr [bp + 8]
7483  98              cwde
7484  D1 E0           shl ax, 1
7486  03 F8           add di, ax
7488  26 8A 45 FA     mov al, byte ptr es:[di - 6]
748C  30 E4           xor ah, ah
748E  6B C0 3E        imul ax, ax, 0x3e
7491  C4 3E C2 D7     les di, ptr [0xd7c2]
7495  03 F8           add di, ax
7497  81 C7 C2 FF     add di, 0xffc2
749B  26 8A 45 38     mov al, byte ptr es:[di + 0x38]
749F  3A 46 06        cmp al, byte ptr [bp + 6]
74A2  7E 07           jle 0x74ab
74A4  8A 46 06        mov al, byte ptr [bp + 6]
74A7  26 88 45 38     mov byte ptr es:[di + 0x38], al
loc_74AB:
74AB  C9              leave
74AC  C2 06 00        ret 6

; ---- routine 1B55:74AF  (found by: far)
sub_74AF:
74AF  C8 0A 00 00     enter 0xa, 0
74B3  C4 3E BC DC     les di, ptr [0xdcbc]
74B7  89 7E FA        mov word ptr [bp - 6], di
74BA  8C 46 FC        mov word ptr [bp - 4], es
74BD  26 8A 45 03     mov al, byte ptr es:[di + 3]
74C1  30 E4           xor ah, ah
74C3  89 46 FE        mov word ptr [bp - 2], ax
74C6  6B 46 FE 3E     imul ax, word ptr [bp - 2], 0x3e
74CA  C4 3E C2 D7     les di, ptr [0xd7c2]
74CE  03 F8           add di, ax
74D0  81 C7 C2 FF     add di, 0xffc2
74D4  26 80 7D 38 06  cmp byte ptr es:[di + 0x38], 6
74D9  74 0A           je 0x74e5
74DB  A0 E6 D7        mov al, byte ptr [0xd7e6]
74DE  30 E4           xor ah, ah
74E0  3B 46 FE        cmp ax, word ptr [bp - 2]
74E3  75 08           jne 0x74ed
loc_74E5:
74E5  6A 04           push 4
74E7  6A 07           push 7
74E9  55              push bp
74EA  E8 8B FF        call 0x7478
loc_74ED:
74ED  C4 7E FA        les di, ptr [bp - 6]
74F0  26 8A 45 01     mov al, byte ptr es:[di + 1]
74F4  30 E4           xor ah, ah
74F6  89 46 FE        mov word ptr [bp - 2], ax
74F9  6B 46 FE 3E     imul ax, word ptr [bp - 2], 0x3e
74FD  C4 3E C2 D7     les di, ptr [0xd7c2]
7501  03 F8           add di, ax
7503  81 C7 C2 FF     add di, 0xffc2
7507  26 80 7D 38 08  cmp byte ptr es:[di + 0x38], 8
750C  7C 0A           jl 0x7518
750E  A0 E6 D7        mov al, byte ptr [0xd7e6]
7511  30 E4           xor ah, ah
7513  3B 46 FE        cmp ax, word ptr [bp - 2]
7516  75 08           jne 0x7520
loc_7518:
7518  6A 03           push 3
751A  6A 08           push 8
751C  55              push bp
751D  E8 58 FF        call 0x7478
loc_7520:
7520  A0 E7 D7        mov al, byte ptr [0xd7e7]
7523  30 E4           xor ah, ah
7525  6B C0 3E        imul ax, ax, 0x3e
7528  C4 3E C2 D7     les di, ptr [0xd7c2]
752C  03 F8           add di, ax
752E  81 C7 C2 FF     add di, 0xffc2
7532  26 80 7D 38 08  cmp byte ptr es:[di + 0x38], 8
7537  7F 06           jg 0x753f
7539  6A 08           push 8
753B  55              push bp
753C  E8 F3 FE        call 0x7432
loc_753F:
753F  C9              leave
7540  CB              retf

; ---- routine 1B55:7541  (found by: call)
sub_7541:
7541  C8 08 00 00     enter 8, 0
7545  8B 46 08        mov ax, word ptr [bp + 8]
7548  89 46 FE        mov word ptr [bp - 2], ax
754B  8B 46 06        mov ax, word ptr [bp + 6]
754E  89 46 FC        mov word ptr [bp - 4], ax
7551  8B 46 08        mov ax, word ptr [bp + 8]
7554  03 46 06        add ax, word ptr [bp + 6]
7557  D1 E8           shr ax, 1
7559  D1 E0           shl ax, 1
755B  8B 7E 04        mov di, word ptr [bp + 4]
755E  36 C4 7D 08     les di, ptr ss:[di + 8]
7562  03 F8           add di, ax
7564  26 8B 45 FE     mov ax, word ptr es:[di - 2]
7568  C1 E0 03        shl ax, 3
756B  C4 3E BA D7     les di, ptr [0xd7ba]
756F  03 F8           add di, ax
7571  26 8A 45 06     mov al, byte ptr es:[di + 6]
7575  30 E4           xor ah, ah
7577  89 46 F8        mov word ptr [bp - 8], ax
loc_757A:
757A  8B 46 FE        mov ax, word ptr [bp - 2]
757D  D1 E0           shl ax, 1
757F  8B 7E 04        mov di, word ptr [bp + 4]
7582  36 C4 7D 08     les di, ptr ss:[di + 8]
7586  03 F8           add di, ax
7588  26 8B 45 FE     mov ax, word ptr es:[di - 2]
758C  C1 E0 03        shl ax, 3
758F  C4 3E BA D7     les di, ptr [0xd7ba]
7593  03 F8           add di, ax
7595  26 8A 45 06     mov al, byte ptr es:[di + 6]
7599  30 E4           xor ah, ah
759B  3B 46 F8        cmp ax, word ptr [bp - 8]
759E  73 05           jae 0x75a5
75A0  FF 46 FE        inc word ptr [bp - 2]
75A3  EB D5           jmp 0x757a
loc_75A5:
75A5  8B 46 FC        mov ax, word ptr [bp - 4]
75A8  D1 E0           shl ax, 1
75AA  8B 7E 04        mov di, word ptr [bp + 4]
75AD  36 C4 7D 08     les di, ptr ss:[di + 8]
75B1  03 F8           add di, ax
75B3  26 8B 45 FE     mov ax, word ptr es:[di - 2]
75B7  C1 E0 03        shl ax, 3
75BA  C4 3E BA D7     les di, ptr [0xd7ba]
75BE  03 F8           add di, ax
75C0  26 8A 45 06     mov al, byte ptr es:[di + 6]
75C4  30 E4           xor ah, ah
75C6  3B 46 F8        cmp ax, word ptr [bp - 8]
75C9  76 05           jbe 0x75d0
75CB  FF 4E FC        dec word ptr [bp - 4]
75CE  EB D5           jmp 0x75a5
loc_75D0:
75D0  8B 46 FE        mov ax, word ptr [bp - 2]
75D3  3B 46 FC        cmp ax, word ptr [bp - 4]
75D6  77 77           ja 0x764f
75D8  8B 46 FE        mov ax, word ptr [bp - 2]
75DB  D1 E0           shl ax, 1
75DD  8B 7E 04        mov di, word ptr [bp + 4]
75E0  36 C4 7D 08     les di, ptr ss:[di + 8]
75E4  03 F8           add di, ax
75E6  26 8B 45 FE     mov ax, word ptr es:[di - 2]
75EA  89 46 FA        mov word ptr [bp - 6], ax
75ED  8B 46 FC        mov ax, word ptr [bp - 4]
75F0  D1 E0           shl ax, 1
75F2  8B 7E 04        mov di, word ptr [bp + 4]
75F5  36 C4 7D 08     les di, ptr ss:[di + 8]
75F9  03 F8           add di, ax
75FB  26 8B 55 FE     mov dx, word ptr es:[di - 2]
75FF  8B 46 FE        mov ax, word ptr [bp - 2]
7602  D1 E0           shl ax, 1
7604  8B 7E 04        mov di, word ptr [bp + 4]
7607  36 C4 7D 08     les di, ptr ss:[di + 8]
760B  03 F8           add di, ax
760D  26 89 55 FE     mov word ptr es:[di - 2], dx
7611  8B 56 FA        mov dx, word ptr [bp - 6]
7614  8B 46 FC        mov ax, word ptr [bp - 4]
7617  D1 E0           shl ax, 1
7619  8B 7E 04        mov di, word ptr [bp + 4]
761C  36 C4 7D 08     les di, ptr ss:[di + 8]
7620  03 F8           add di, ax
7622  26 89 55 FE     mov word ptr es:[di - 2], dx
7626  8B 46 FE        mov ax, word ptr [bp - 2]
7629  8B 7E 04        mov di, word ptr [bp + 4]
762C  03 F8           add di, ax
762E  81 C7 F3 FF     add di, 0xfff3
7632  16              push ss
7633  57              push di
7634  8B 46 FC        mov ax, word ptr [bp - 4]
7637  8B 7E 04        mov di, word ptr [bp + 4]
763A  03 F8           add di, ax
763C  81 C7 F3 FF     add di, 0xfff3
7640  16              push ss
7641  57              push di
7642  6A 01           push 1
7644  9A 03 02 BC 24  call far 24BC:0203
7649  FF 46 FE        inc word ptr [bp - 2]
764C  FF 4E FC        dec word ptr [bp - 4]
loc_764F:
764F  8B 46 FE        mov ax, word ptr [bp - 2]
7652  3B 46 FC        cmp ax, word ptr [bp - 4]
7655  77 03           ja 0x765a
7657  E9 20 FF        jmp 0x757a
loc_765A:
765A  8B 46 08        mov ax, word ptr [bp + 8]
765D  3B 46 FC        cmp ax, word ptr [bp - 4]
7660  73 0D           jae 0x766f
7662  FF 76 08        push word ptr [bp + 8]
7665  FF 76 FC        push word ptr [bp - 4]
7668  8B 7E 04        mov di, word ptr [bp + 4]
766B  57              push di
766C  E8 D2 FE        call 0x7541
loc_766F:
766F  8B 46 FE        mov ax, word ptr [bp - 2]
7672  3B 46 06        cmp ax, word ptr [bp + 6]
7675  73 0D           jae 0x7684
7677  FF 76 FE        push word ptr [bp - 2]
767A  FF 76 06        push word ptr [bp + 6]
767D  8B 7E 04        mov di, word ptr [bp + 4]
7680  57              push di
7681  E8 BD FE        call 0x7541
loc_7684:
7684  C9              leave
7685  C2 06 00        ret 6

; ---- routine 1B55:7688  (found by: call)
sub_7688:
7688  C8 0C 00 00     enter 0xc, 0
768C  8B 46 06        mov ax, word ptr [bp + 6]
768F  89 46 FA        mov word ptr [bp - 6], ax
7692  8B 46 08        mov ax, word ptr [bp + 8]
7695  40              inc ax
7696  3B 46 FA        cmp ax, word ptr [bp - 6]
7699  76 03           jbe 0x769e
769B  E9 D5 00        jmp 0x7773
loc_769E:
769E  89 46 FE        mov word ptr [bp - 2], ax
76A1  EB 03           jmp 0x76a6
loc_76A3:
76A3  FF 46 FE        inc word ptr [bp - 2]
loc_76A6:
76A6  8B 46 FE        mov ax, word ptr [bp - 2]
76A9  89 46 F8        mov word ptr [bp - 8], ax
76AC  8B 46 06        mov ax, word ptr [bp + 6]
76AF  3B 46 F8        cmp ax, word ptr [bp - 8]
76B2  73 03           jae 0x76b7
76B4  E9 B1 00        jmp 0x7768
loc_76B7:
76B7  89 46 FC        mov word ptr [bp - 4], ax
76BA  EB 03           jmp 0x76bf
loc_76BC:
76BC  FF 4E FC        dec word ptr [bp - 4]
loc_76BF:
76BF  8B 46 FC        mov ax, word ptr [bp - 4]
76C2  48              dec ax
76C3  D1 E0           shl ax, 1
76C5  8B 7E 04        mov di, word ptr [bp + 4]
76C8  36 C4 7D 08     les di, ptr ss:[di + 8]
76CC  03 F8           add di, ax
76CE  26 8B 45 FE     mov ax, word ptr es:[di - 2]
76D2  C1 E0 03        shl ax, 3
76D5  C4 3E BA D7     les di, ptr [0xd7ba]
76D9  03 F8           add di, ax
76DB  89 7E F4        mov word ptr [bp - 0xc], di
76DE  8C 46 F6        mov word ptr [bp - 0xa], es
76E1  8B 46 FC        mov ax, word ptr [bp - 4]
76E4  D1 E0           shl ax, 1
76E6  8B 7E 04        mov di, word ptr [bp + 4]
76E9  36 C4 7D 08     les di, ptr ss:[di + 8]
76ED  03 F8           add di, ax
76EF  26 8B 45 FE     mov ax, word ptr es:[di - 2]
76F3  C1 E0 03        shl ax, 3
76F6  C4 3E BA D7     les di, ptr [0xd7ba]
76FA  03 F8           add di, ax
76FC  26 8A 45 06     mov al, byte ptr es:[di + 6]
7700  C4 7E F4        les di, ptr [bp - 0xc]
7703  26 3A 45 06     cmp al, byte ptr es:[di + 6]
7707  73 54           jae 0x775d
7709  8B 46 FC        mov ax, word ptr [bp - 4]
770C  8B 7E 04        mov di, word ptr [bp + 4]
770F  03 F8           add di, ax
7711  81 C7 F3 FF     add di, 0xfff3
7715  16              push ss
7716  57              push di
7717  8B 46 FC        mov ax, word ptr [bp - 4]
771A  48              dec ax
771B  8B 7E 04        mov di, word ptr [bp + 4]
771E  03 F8           add di, ax
7720  81 C7 F3 FF     add di, 0xfff3
7724  16              push ss
7725  57              push di
7726  6A 01           push 1
7728  9A 03 02 BC 24  call far 24BC:0203
772D  8B 46 FC        mov ax, word ptr [bp - 4]
7730  D1 E0           shl ax, 1
7732  8B 7E 04        mov di, word ptr [bp + 4]
7735  36 C4 7D 08     les di, ptr ss:[di + 8]
7739  03 F8           add di, ax
773B  81 C7 FE FF     add di, 0xfffe
773F  06              push es
7740  57              push di
7741  8B 46 FC        mov ax, word ptr [bp - 4]
7744  48              dec ax
7745  D1 E0           shl ax, 1
7747  8B 7E 04        mov di, word ptr [bp + 4]
774A  36 C4 7D 08     les di, ptr ss:[di + 8]
774E  03 F8           add di, ax
7750  81 C7 FE FF     add di, 0xfffe
7754  06              push es
7755  57              push di
7756  6A 02           push 2
7758  9A 03 02 BC 24  call far 24BC:0203
loc_775D:
775D  8B 46 FC        mov ax, word ptr [bp - 4]
7760  3B 46 F8        cmp ax, word ptr [bp - 8]
7763  74 03           je 0x7768
7765  E9 54 FF        jmp 0x76bc
loc_7768:
7768  8B 46 FE        mov ax, word ptr [bp - 2]
776B  3B 46 FA        cmp ax, word ptr [bp - 6]
776E  74 03           je 0x7773
7770  E9 30 FF        jmp 0x76a3
loc_7773:
7773  C9              leave
7774  C2 06 00        ret 6

; ---- routine 1B55:7777  (found by: call, far)
sub_7777:
7777  C8 12 00 00     enter 0x12, 0
777B  C7 46 F2 01 00  mov word ptr [bp - 0xe], 1
7780  EB 03           jmp 0x7785
loc_7782:
7782  FF 46 F2        inc word ptr [bp - 0xe]
loc_7785:
7785  8B 46 F2        mov ax, word ptr [bp - 0xe]
7788  D1 E0           shl ax, 1
778A  C4 7E 08        les di, ptr [bp + 8]
778D  03 F8           add di, ax
778F  26 8B 45 FE     mov ax, word ptr es:[di - 2]
7793  C1 E0 03        shl ax, 3
7796  C4 3E BA D7     les di, ptr [0xd7ba]
779A  03 F8           add di, ax
779C  89 7E EE        mov word ptr [bp - 0x12], di
779F  8C 46 F0        mov word ptr [bp - 0x10], es
77A2  26 8A 45 06     mov al, byte ptr es:[di + 6]
77A6  8B 7E F2        mov di, word ptr [bp - 0xe]
77A9  88 43 F3        mov byte ptr [bp + di - 0xd], al
77AC  8B 46 F2        mov ax, word ptr [bp - 0xe]
77AF  D1 E0           shl ax, 1
77B1  C4 7E 08        les di, ptr [bp + 8]
77B4  03 F8           add di, ax
77B6  26 83 7D FE 00  cmp word ptr es:[di - 2], 0
77BB  75 08           jne 0x77c5
77BD  C4 7E EE        les di, ptr [bp - 0x12]
77C0  26 C6 45 06 0E  mov byte ptr es:[di + 6], 0xe
loc_77C5:
77C5  83 7E F2 0B     cmp word ptr [bp - 0xe], 0xb
77C9  75 B7           jne 0x7782
77CB  FF 76 06        push word ptr [bp + 6]
77CE  0E              push cs
77CF  E8 A8 96        call 0xe7a
77D2  08 C0           or al, al
77D4  74 0A           je 0x77e0
77D6  6A 01           push 1
77D8  6A 0B           push 0xb
77DA  55              push bp
77DB  E8 AA FE        call 0x7688
77DE  EB 08           jmp 0x77e8
loc_77E0:
77E0  6A 01           push 1
77E2  6A 0B           push 0xb
77E4  55              push bp
77E5  E8 59 FD        call 0x7541
loc_77E8:
77E8  C7 46 F2 01 00  mov word ptr [bp - 0xe], 1
77ED  EB 03           jmp 0x77f2
loc_77EF:
77EF  FF 46 F2        inc word ptr [bp - 0xe]
loc_77F2:
77F2  8B 46 F2        mov ax, word ptr [bp - 0xe]
77F5  D1 E0           shl ax, 1
77F7  C4 7E 08        les di, ptr [bp + 8]
77FA  03 F8           add di, ax
77FC  26 8B 45 FE     mov ax, word ptr es:[di - 2]
7800  C1 E0 03        shl ax, 3
7803  C4 3E BA D7     les di, ptr [0xd7ba]
7807  03 F8           add di, ax
7809  89 7E EE        mov word ptr [bp - 0x12], di
780C  8C 46 F0        mov word ptr [bp - 0x10], es
780F  8B 7E F2        mov di, word ptr [bp - 0xe]
7812  8A 43 F3        mov al, byte ptr [bp + di - 0xd]
7815  C4 7E EE        les di, ptr [bp - 0x12]
7818  26 88 45 06     mov byte ptr es:[di + 6], al
781C  83 7E F2 0B     cmp word ptr [bp - 0xe], 0xb
7820  75 CD           jne 0x77ef
7822  C9              leave
7823  CA 06 00        retf 6

