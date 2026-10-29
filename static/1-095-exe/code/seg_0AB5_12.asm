; 1-095.EXE (One-Nil 95), code segment 0AB5 (image offsets 0AB50..1993F), part 12 of 22
; packed 1-095.EXE sha256 f659fb2d334500d6901fc8d6a0f06c85c0ccda2eb4a3035ae3bb0a0004d79192 (LZEXE 0.91)
; unpacked (tools/static/unlzexe.py) sha256 8df646e017e0965a5d90a58181ca764219ad847833aad0b6cb58fc53372bfb2c
; tool: capstone 5.0.9 (pip package; core library 5.0.1280) (CS_ARCH_X86, CS_MODE_16), recursive descent from the entry point, far calls and near calls/jumps, then routine prologues (55 89 E5 / 55 8B EC / C8 iw 00) in what remains; tools/static/listing.py
; addresses are SEGMENT:OFFSET with SEGMENT the image paragraph before relocation; image offset = SEGMENT*16+OFFSET
; ---- routine 0AB5:6E28  (found by: call)
sub_6E28:
6E28  55              push bp
6E29  89 E5           mov bp, sp
6E2B  C4 7E 06        les di, ptr [bp + 6]
6E2E  06              push es
6E2F  57              push di
6E30  0E              push cs
6E31  E8 A3 94        call 0x2d7
6E34  C4 7E 06        les di, ptr [bp + 6]
6E37  26 8B 45 02     mov ax, word ptr es:[di + 2]
6E3B  3B 06 2E 0D     cmp ax, word ptr [0xd2e]
6E3F  74 4A           je 0x6e8b
6E41  26 8B 45 02     mov ax, word ptr es:[di + 2]
6E45  26 3B 05        cmp ax, word ptr es:[di]
6E48  74 41           je 0x6e8b
6E4A  26 8A 45 03     mov al, byte ptr es:[di + 3]
6E4E  98              cwde
6E4F  D1 E0           shl ax, 1
6E51  8B D0           mov dx, ax
6E53  26 8A 45 02     mov al, byte ptr es:[di + 2]
6E57  98              cwde
6E58  69 C0 A0 00     imul ax, ax, 0xa0
6E5C  C4 3E 92 D0     les di, ptr [0xd092]
6E60  03 F8           add di, ax
6E62  03 FA           add di, dx
6E64  26 8B 8D 0E 09  mov cx, word ptr es:[di + 0x90e]
6E69  C4 7E 06        les di, ptr [bp + 6]
6E6C  26 8A 45 03     mov al, byte ptr es:[di + 3]
6E70  98              cwde
6E71  D1 E0           shl ax, 1
6E73  8B D0           mov dx, ax
6E75  26 8A 45 02     mov al, byte ptr es:[di + 2]
6E79  98              cwde
6E7A  69 C0 A0 00     imul ax, ax, 0xa0
6E7E  C4 3E 8A D0     les di, ptr [0xd08a]
6E82  03 F8           add di, ax
6E84  03 FA           add di, dx
6E86  26 89 8D 0E 09  mov word ptr es:[di + 0x90e], cx
loc_6E8B:
6E8B  C4 7E 06        les di, ptr [bp + 6]
6E8E  26 8B 05        mov ax, word ptr es:[di]
6E91  26 89 45 02     mov word ptr es:[di + 2], ax
6E95  26 8B 05        mov ax, word ptr es:[di]
6E98  3B 06 2E 0D     cmp ax, word ptr [0xd2e]
6E9C  74 3F           je 0x6edd
6E9E  26 80 7D 04 01  cmp byte ptr es:[di + 4], 1
6EA3  75 09           jne 0x6eae
6EA5  A0 9F D0        mov al, byte ptr [0xd09f]
6EA8  26 3A 45 07     cmp al, byte ptr es:[di + 7]
6EAC  74 04           je 0x6eb2
loc_6EAE:
6EAE  B0 00           mov al, 0
6EB0  EB 02           jmp 0x6eb4
loc_6EB2:
6EB2  B0 01           mov al, 1
loc_6EB4:
6EB4  30 E4           xor ah, ah
6EB6  C4 7E 06        les di, ptr [bp + 6]
6EB9  26 03 45 04     add ax, word ptr es:[di + 4]
6EBD  8B C8           mov cx, ax
6EBF  26 8A 45 01     mov al, byte ptr es:[di + 1]
6EC3  98              cwde
6EC4  D1 E0           shl ax, 1
6EC6  8B D0           mov dx, ax
6EC8  26 8A 05        mov al, byte ptr es:[di]
6ECB  98              cwde
6ECC  69 C0 A0 00     imul ax, ax, 0xa0
6ED0  C4 3E 8A D0     les di, ptr [0xd08a]
6ED4  03 F8           add di, ax
6ED6  03 FA           add di, dx
6ED8  26 89 8D 0E 09  mov word ptr es:[di + 0x90e], cx
loc_6EDD:
6EDD  C4 7E 06        les di, ptr [bp + 6]
6EE0  06              push es
6EE1  57              push di
6EE2  0E              push cs
6EE3  E8 26 B0        call 0x1f0c
6EE6  08 C0           or al, al
6EE8  75 03           jne 0x6eed
6EEA  E9 7D 00        jmp 0x6f6a
loc_6EED:
6EED  C4 7E 06        les di, ptr [bp + 6]
6EF0  26 8B 05        mov ax, word ptr es:[di]
6EF3  A3 46 CF        mov word ptr [0xcf46], ax
6EF6  26 8A 45 07     mov al, byte ptr es:[di + 7]
6EFA  30 E4           xor ah, ah
6EFC  50              push ax
6EFD  E8 00 91        call 0
6F00  08 C0           or al, al
6F02  74 10           je 0x6f14
6F04  C4 7E 06        les di, ptr [bp + 6]
6F07  26 FF 35        push word ptr es:[di]
6F0A  06              push es
6F0B  57              push di
6F0C  0E              push cs
6F0D  E8 E5 B1        call 0x20f5
6F10  08 C0           or al, al
6F12  75 4C           jne 0x6f60
loc_6F14:
6F14  C4 7E 06        les di, ptr [bp + 6]
6F17  26 8A 45 10     mov al, byte ptr es:[di + 0x10]
6F1B  3C 01           cmp al, 1
6F1D  74 08           je 0x6f27
6F1F  3C 02           cmp al, 2
6F21  74 04           je 0x6f27
6F23  3C 05           cmp al, 5
6F25  75 0F           jne 0x6f36
loc_6F27:
6F27  C4 7E 06        les di, ptr [bp + 6]
6F2A  06              push es
6F2B  57              push di
6F2C  0E              push cs
6F2D  E8 9C AF        call 0x1ecc
6F30  00 06 47 CF     add byte ptr [0xcf47], al
6F34  EB 12           jmp 0x6f48
loc_6F36:
6F36  3C 03           cmp al, 3
6F38  75 06           jne 0x6f40
6F3A  FE 0E 47 CF     dec byte ptr [0xcf47]
6F3E  EB 08           jmp 0x6f48
loc_6F40:
6F40  3C 04           cmp al, 4
6F42  75 04           jne 0x6f48
6F44  FE 06 47 CF     inc byte ptr [0xcf47]
loc_6F48:
6F48  80 3E 47 CF 26  cmp byte ptr [0xcf47], 0x26
6F4D  75 05           jne 0x6f54
6F4F  C6 06 47 CF 24  mov byte ptr [0xcf47], 0x24
loc_6F54:
6F54  80 3E 47 CF DA  cmp byte ptr [0xcf47], 0xda
6F59  75 05           jne 0x6f60
6F5B  C6 06 47 CF DC  mov byte ptr [0xcf47], 0xdc
loc_6F60:
6F60  BF 46 CF        mov di, 0xcf46
6F63  1E              push ds
6F64  57              push di
6F65  9A 16 0A 94 19  call far 1994:0A16
loc_6F6A:
6F6A  C9              leave
6F6B  CA 04 00        retf 4

; ---- routine 0AB5:6F6E  (found by: call)
sub_6F6E:
6F6E  55              push bp
6F6F  89 E5           mov bp, sp
6F71  C4 7E 06        les di, ptr [bp + 6]
6F74  26 8A 45 07     mov al, byte ptr es:[di + 7]
6F78  A2 9F D0        mov byte ptr [0xd09f], al
6F7B  31 C0           xor ax, ax
6F7D  A3 51 CF        mov word ptr [0xcf51], ax
6F80  C6 06 A0 D0 00  mov byte ptr [0xd0a0], 0
6F85  C6 06 53 CF 00  mov byte ptr [0xcf53], 0
6F8A  C6 06 54 CF 00  mov byte ptr [0xcf54], 0
6F8F  C6 06 BB D0 00  mov byte ptr [0xd0bb], 0
6F94  C9              leave
6F95  CA 04 00        retf 4

; ---- routine 0AB5:6F98  (found by: call)
sub_6F98:
6F98  C8 02 00 00     enter 2, 0
6F9C  8B 7E 04        mov di, word ptr [bp + 4]
6F9F  36 8B 7D 04     mov di, word ptr ss:[di + 4]
6FA3  36 C4 7D 06     les di, ptr ss:[di + 6]
6FA7  26 8B 45 02     mov ax, word ptr es:[di + 2]
6FAB  26 89 05        mov word ptr es:[di], ax
6FAE  26 8A 45 10     mov al, byte ptr es:[di + 0x10]
6FB2  3C 01           cmp al, 1
6FB4  75 05           jne 0x6fbb
6FB6  26 FE 0D        dec byte ptr es:[di]
6FB9  EB 3C           jmp 0x6ff7
loc_6FBB:
6FBB  3C 02           cmp al, 2
6FBD  75 10           jne 0x6fcf
6FBF  8B 7E 04        mov di, word ptr [bp + 4]
6FC2  36 8B 7D 04     mov di, word ptr ss:[di + 4]
6FC6  36 C4 7D 06     les di, ptr ss:[di + 6]
6FCA  26 FE 05        inc byte ptr es:[di]
6FCD  EB 28           jmp 0x6ff7
loc_6FCF:
6FCF  3C 03           cmp al, 3
6FD1  75 11           jne 0x6fe4
6FD3  8B 7E 04        mov di, word ptr [bp + 4]
6FD6  36 8B 7D 04     mov di, word ptr ss:[di + 4]
6FDA  36 C4 7D 06     les di, ptr ss:[di + 6]
6FDE  26 FE 4D 01     dec byte ptr es:[di + 1]
6FE2  EB 13           jmp 0x6ff7
loc_6FE4:
6FE4  3C 04           cmp al, 4
6FE6  75 0F           jne 0x6ff7
6FE8  8B 7E 04        mov di, word ptr [bp + 4]
6FEB  36 8B 7D 04     mov di, word ptr ss:[di + 4]
6FEF  36 C4 7D 06     les di, ptr ss:[di + 6]
6FF3  26 FE 45 01     inc byte ptr es:[di + 1]
loc_6FF7:
6FF7  8B 7E 04        mov di, word ptr [bp + 4]
6FFA  36 8B 7D 04     mov di, word ptr ss:[di + 4]
6FFE  36 C4 7D 06     les di, ptr ss:[di + 6]
7002  26 80 7D 10 05  cmp byte ptr es:[di + 0x10], 5
7007  75 03           jne 0x700c
7009  E9 BD 00        jmp 0x70c9
loc_700C:
700C  26 FF 35        push word ptr es:[di]
700F  9A 4B 08 94 19  call far 1994:084B
7014  08 C0           or al, al
7016  75 03           jne 0x701b
7018  E9 AA 00        jmp 0x70c5
loc_701B:
701B  80 3E B8 D0 00  cmp byte ptr [0xd0b8], 0
7020  75 03           jne 0x7025
7022  E9 A4 00        jmp 0x70c9
loc_7025:
7025  8B 7E 04        mov di, word ptr [bp + 4]
7028  36 8B 7D 04     mov di, word ptr ss:[di + 4]
702C  36 C4 7D 06     les di, ptr ss:[di + 6]
7030  26 8A 45 07     mov al, byte ptr es:[di + 7]
7034  3A 06 A0 D0     cmp al, byte ptr [0xd0a0]
7038  75 03           jne 0x703d
703A  E9 8C 00        jmp 0x70c9
loc_703D:
703D  26 8A 45 07     mov al, byte ptr es:[di + 7]
7041  3A 06 9F D0     cmp al, byte ptr [0xd09f]
7045  75 03           jne 0x704a
7047  E9 7F 00        jmp 0x70c9
loc_704A:
704A  26 8B 45 0E     mov ax, word ptr es:[di + 0xe]
704E  C1 E0 03        shl ax, 3
7051  C4 3E BA D7     les di, ptr [0xd7ba]
7055  03 F8           add di, ax
7057  26 80 7D 06 00  cmp byte ptr es:[di + 6], 0
705C  74 6B           je 0x70c9
705E  8B 7E 04        mov di, word ptr [bp + 4]
7061  36 8B 7D 04     mov di, word ptr ss:[di + 4]
7065  36 C4 7D 06     les di, ptr ss:[di + 6]
7069  26 8A 45 01     mov al, byte ptr es:[di + 1]
706D  98              cwde
706E  D1 E0           shl ax, 1
7070  8B D0           mov dx, ax
7072  26 8A 05        mov al, byte ptr es:[di]
7075  98              cwde
7076  69 C0 A0 00     imul ax, ax, 0xa0
707A  C4 3E 8A D0     les di, ptr [0xd08a]
707E  03 F8           add di, ax
7080  03 FA           add di, dx
7082  26 80 BD 0F 09 05 cmp byte ptr es:[di + 0x90f], 5
7088  74 3F           je 0x70c9
708A  8B 7E 04        mov di, word ptr [bp + 4]
708D  36 8B 7D 04     mov di, word ptr ss:[di + 4]
7091  36 C4 7D 06     les di, ptr ss:[di + 6]
7095  26 8A 45 01     mov al, byte ptr es:[di + 1]
7099  98              cwde
709A  D1 E0           shl ax, 1
709C  8B D0           mov dx, ax
709E  26 8A 05        mov al, byte ptr es:[di]
70A1  98              cwde
70A2  69 C0 A0 00     imul ax, ax, 0xa0
70A6  C4 3E 8A D0     les di, ptr [0xd08a]
70AA  03 F8           add di, ax
70AC  03 FA           add di, dx
70AE  26 8A 85 0E 09  mov al, byte ptr es:[di + 0x90e]
70B3  B4 01           mov ah, 1
70B5  BA 20 00        mov dx, 0x20
70B8  9A 1F 0E B9 26  call far 26B9:0E1F
70BD  8B FA           mov di, dx
70BF  84 85 36 0D     test byte ptr [di + 0xd36], al
70C3  74 04           je 0x70c9
loc_70C5:
70C5  B0 00           mov al, 0
70C7  EB 02           jmp 0x70cb
loc_70C9:
70C9  B0 01           mov al, 1
loc_70CB:
70CB  88 46 FF        mov byte ptr [bp - 1], al
70CE  8A 46 FF        mov al, byte ptr [bp - 1]
70D1  C9              leave
70D2  C2 02 00        ret 2

; ---- routine 0AB5:70D5  (found by: call)
sub_70D5:
70D5  C8 02 00 00     enter 2, 0
70D9  80 3E 53 CF 00  cmp byte ptr [0xcf53], 0
70DE  74 36           je 0x7116
70E0  8B 7E 04        mov di, word ptr [bp + 4]
70E3  36 C4 7D 06     les di, ptr ss:[di + 6]
70E7  06              push es
70E8  57              push di
70E9  0E              push cs
70EA  E8 DF AD        call 0x1ecc
70ED  98              cwde
70EE  8B D0           mov dx, ax
70F0  8B 7E 04        mov di, word ptr [bp + 4]
70F3  36 C4 7D 06     les di, ptr ss:[di + 6]
70F7  26 8A 45 01     mov al, byte ptr es:[di + 1]
70FB  98              cwde
70FC  F7 E2           mul dx
70FE  50              push ax
70FF  06              push es
7100  57              push di
7101  0E              push cs
7102  E8 C7 AD        call 0x1ecc
7105  98              cwde
7106  8B D0           mov dx, ax
7108  A0 47 CF        mov al, byte ptr [0xcf47]
710B  98              cwde
710C  F7 E2           mul dx
710E  5A              pop dx
710F  3B C2           cmp ax, dx
7111  7E 03           jle 0x7116
7113  E9 C8 00        jmp 0x71de
loc_7116:
7116  8B 7E 04        mov di, word ptr [bp + 4]
7119  36 C4 7D 06     les di, ptr ss:[di + 6]
711D  26 8A 45 07     mov al, byte ptr es:[di + 7]
7121  3A 06 9F D0     cmp al, byte ptr [0xd09f]
7125  75 03           jne 0x712a
7127  E9 B4 00        jmp 0x71de
loc_712A:
712A  26 8A 45 07     mov al, byte ptr es:[di + 7]
712E  3A 06 A0 D0     cmp al, byte ptr [0xd0a0]
7132  75 03           jne 0x7137
7134  E9 A7 00        jmp 0x71de
loc_7137:
7137  06              push es
7138  57              push di
7139  0E              push cs
713A  E8 8F AD        call 0x1ecc
713D  08 C0           or al, al
713F  B0 00           mov al, 0
7141  7E 01           jle 0x7144
7143  40              inc ax
loc_7144:
7144  8A D0           mov dl, al
7146  8B 7E 04        mov di, word ptr [bp + 4]
7149  36 C4 7D 06     les di, ptr ss:[di + 6]
714D  26 80 7D 09 00  cmp byte ptr es:[di + 9], 0
7152  B0 00           mov al, 0
7154  7E 01           jle 0x7157
7156  40              inc ax
loc_7157:
7157  3A C2           cmp al, dl
7159  74 03           je 0x715e
715B  E9 80 00        jmp 0x71de
loc_715E:
715E  06              push es
715F  57              push di
7160  0E              push cs
7161  E8 57 AB        call 0x1cbb
7164  08 C0           or al, al
7166  B0 00           mov al, 0
7168  75 01           jne 0x716b
716A  40              inc ax
loc_716B:
716B  98              cwde
716C  6B F8 07        imul di, ax, 7
716F  8A 85 2F CF     mov al, byte ptr [di - 0x30d1]
7173  98              cwde
7174  99              cdq
7175  31 D0           xor ax, dx
7177  29 D0           sub ax, dx
7179  8B C8           mov cx, ax
717B  8B 7E 04        mov di, word ptr [bp + 4]
717E  36 C4 7D 06     les di, ptr ss:[di + 6]
7182  26 8A 45 09     mov al, byte ptr es:[di + 9]
7186  98              cwde
7187  99              cdq
7188  31 D0           xor ax, dx
718A  29 D0           sub ax, dx
718C  3B C1           cmp ax, cx
718E  7C 4E           jl 0x71de
7190  26 8A 45 13     mov al, byte ptr es:[di + 0x13]
7194  3C 05           cmp al, 5
7196  74 0C           je 0x71a4
7198  3C 07           cmp al, 7
719A  72 42           jb 0x71de
719C  3C 08           cmp al, 8
719E  76 04           jbe 0x71a4
71A0  3C 0B           cmp al, 0xb
71A2  75 3A           jne 0x71de
loc_71A4:
71A4  8B 7E 04        mov di, word ptr [bp + 4]
71A7  36 C4 7D 06     les di, ptr ss:[di + 6]
71AB  06              push es
71AC  57              push di
71AD  0E              push cs
71AE  E8 1B AD        call 0x1ecc
71B1  98              cwde
71B2  50              push ax
71B3  8B 7E 04        mov di, word ptr [bp + 4]
71B6  36 C4 7D 06     les di, ptr ss:[di + 6]
71BA  06              push es
71BB  57              push di
71BC  0E              push cs
71BD  E8 FB AA        call 0x1cbb
71C0  08 C0           or al, al
71C2  B0 00           mov al, 0
71C4  75 01           jne 0x71c7
71C6  40              inc ax
loc_71C7:
71C7  98              cwde
71C8  6B F8 07        imul di, ax, 7
71CB  8A 85 2F CF     mov al, byte ptr [di - 0x30d1]
71CF  98              cwde
71D0  5A              pop dx
71D1  2B C2           sub ax, dx
71D3  8B 7E 04        mov di, word ptr [bp + 4]
71D6  36 C4 7D 06     les di, ptr ss:[di + 6]
71DA  26 88 45 09     mov byte ptr es:[di + 9], al
loc_71DE:
71DE  8B 7E 04        mov di, word ptr [bp + 4]
71E1  36 C4 7D 06     les di, ptr ss:[di + 6]
71E5  26 8B 45 08     mov ax, word ptr es:[di + 8]
71E9  89 46 FE        mov word ptr [bp - 2], ax
71EC  26 8A 05        mov al, byte ptr es:[di]
71EF  28 46 FE        sub byte ptr [bp - 2], al
71F2  26 8A 45 01     mov al, byte ptr es:[di + 1]
71F6  28 46 FF        sub byte ptr [bp - 1], al
71F9  06              push es
71FA  57              push di
71FB  0E              push cs
71FC  E8 9A AD        call 0x1f99
71FF  08 C0           or al, al
7201  74 0F           je 0x7212
7203  8B 7E 04        mov di, word ptr [bp + 4]
7206  36 C4 7D 06     les di, ptr ss:[di + 6]
720A  26 C6 45 10 05  mov byte ptr es:[di + 0x10], 5
720F  E9 89 00        jmp 0x729b
loc_7212:
7212  9A 3F 0D AC 24  call far 24AC:0D3F
7217  08 C0           or al, al
7219  74 41           je 0x725c
721B  8A 46 FE        mov al, byte ptr [bp - 2]
721E  98              cwde
721F  99              cdq
7220  31 D0           xor ax, dx
7222  29 D0           sub ax, dx
7224  09 C0           or ax, ax
7226  7E 19           jle 0x7241
7228  80 7E FE 00     cmp byte ptr [bp - 2], 0
722C  B0 00           mov al, 0
722E  7E 01           jle 0x7231
7230  40              inc ax
loc_7231:
7231  30 E4           xor ah, ah
7233  40              inc ax
7234  8B 7E 04        mov di, word ptr [bp + 4]
7237  36 C4 7D 06     les di, ptr ss:[di + 6]
723B  26 88 45 10     mov byte ptr es:[di + 0x10], al
723F  EB 19           jmp 0x725a
loc_7241:
7241  80 7E FF 00     cmp byte ptr [bp - 1], 0
7245  B0 00           mov al, 0
7247  7E 01           jle 0x724a
7249  40              inc ax
loc_724A:
724A  30 E4           xor ah, ah
724C  05 03 00        add ax, 3
724F  8B 7E 04        mov di, word ptr [bp + 4]
7252  36 C4 7D 06     les di, ptr ss:[di + 6]
7256  26 88 45 10     mov byte ptr es:[di + 0x10], al
loc_725A:
725A  EB 3F           jmp 0x729b
loc_725C:
725C  8A 46 FF        mov al, byte ptr [bp - 1]
725F  98              cwde
7260  99              cdq
7261  31 D0           xor ax, dx
7263  29 D0           sub ax, dx
7265  09 C0           or ax, ax
7267  7E 1B           jle 0x7284
7269  80 7E FF 00     cmp byte ptr [bp - 1], 0
726D  B0 00           mov al, 0
726F  7E 01           jle 0x7272
7271  40              inc ax
loc_7272:
7272  30 E4           xor ah, ah
7274  05 03 00        add ax, 3
7277  8B 7E 04        mov di, word ptr [bp + 4]
727A  36 C4 7D 06     les di, ptr ss:[di + 6]
727E  26 88 45 10     mov byte ptr es:[di + 0x10], al
7282  EB 17           jmp 0x729b
loc_7284:
7284  80 7E FE 00     cmp byte ptr [bp - 2], 0
7288  B0 00           mov al, 0
728A  7E 01           jle 0x728d
728C  40              inc ax
loc_728D:
728D  30 E4           xor ah, ah
728F  40              inc ax
7290  8B 7E 04        mov di, word ptr [bp + 4]
7293  36 C4 7D 06     les di, ptr ss:[di + 6]
7297  26 88 45 10     mov byte ptr es:[di + 0x10], al
loc_729B:
729B  55              push bp
729C  E8 F9 FC        call 0x6f98
729F  08 C0           or al, al
72A1  75 14           jne 0x72b7
72A3  6A 05           push 5
72A5  9A 6D 07 1A 23  call far 231A:076D
72AA  8B 7E 04        mov di, word ptr [bp + 4]
72AD  36 C4 7D 06     les di, ptr ss:[di + 6]
72B1  26 88 45 10     mov byte ptr es:[di + 0x10], al
72B5  EB E4           jmp 0x729b
loc_72B7:
72B7  C9              leave
72B8  C2 02 00        ret 2

; ---- routine 0AB5:72BB  (found by: call)
sub_72BB:
72BB  C8 06 00 00     enter 6, 0
72BF  C4 7E 06        les di, ptr [bp + 6]
72C2  26 6B 45 0E 0F  imul ax, word ptr es:[di + 0xe], 0xf
72C7  C4 3E BE D7     les di, ptr [0xd7be]
72CB  03 F8           add di, ax
72CD  89 7E FA        mov word ptr [bp - 6], di
72D0  8C 46 FC        mov word ptr [bp - 4], es
72D3  C4 7E 06        les di, ptr [bp + 6]
72D6  26 8A 45 13     mov al, byte ptr es:[di + 0x13]
72DA  3C 05           cmp al, 5
72DC  75 09           jne 0x72e7
72DE  06              push es
72DF  57              push di
72E0  0E              push cs
72E1  E8 A8 D1        call 0x448c
72E4  E9 95 00        jmp 0x737c
loc_72E7:
72E7  3C 0D           cmp al, 0xd
72E9  75 0C           jne 0x72f7
72EB  C4 7E 06        les di, ptr [bp + 6]
72EE  06              push es
72EF  57              push di
72F0  0E              push cs
72F1  E8 1F D3        call 0x4613
72F4  E9 85 00        jmp 0x737c
loc_72F7:
72F7  3C 01           cmp al, 1
72F9  75 0B           jne 0x7306
72FB  C4 7E 06        les di, ptr [bp + 6]
72FE  06              push es
72FF  57              push di
7300  0E              push cs
7301  E8 1A E3        call 0x561e
7304  EB 76           jmp 0x737c
loc_7306:
7306  3C 02           cmp al, 2
7308  75 0B           jne 0x7315
730A  C4 7E 06        les di, ptr [bp + 6]
730D  06              push es
730E  57              push di
730F  0E              push cs
7310  E8 DB E3        call 0x56ee
7313  EB 67           jmp 0x737c
loc_7315:
7315  3C 03           cmp al, 3
7317  75 0B           jne 0x7324
7319  C4 7E 06        les di, ptr [bp + 6]
731C  06              push es
731D  57              push di
731E  0E              push cs
731F  E8 06 E4        call 0x5728
7322  EB 58           jmp 0x737c
loc_7324:
7324  3C 06           cmp al, 6
7326  75 0B           jne 0x7333
7328  C4 7E 06        les di, ptr [bp + 6]
732B  06              push es
732C  57              push di
732D  0E              push cs
732E  E8 79 DB        call 0x4eaa
7331  EB 49           jmp 0x737c
loc_7333:
7333  3C 07           cmp al, 7
7335  75 0B           jne 0x7342
7337  C4 7E 06        les di, ptr [bp + 6]
733A  06              push es
733B  57              push di
733C  0E              push cs
733D  E8 82 E8        call 0x5bc2
7340  EB 3A           jmp 0x737c
loc_7342:
7342  3C 08           cmp al, 8
7344  75 0B           jne 0x7351
7346  C4 7E 06        les di, ptr [bp + 6]
7349  06              push es
734A  57              push di
734B  0E              push cs
734C  E8 54 EA        call 0x5da3
734F  EB 2B           jmp 0x737c
loc_7351:
7351  3C 09           cmp al, 9
7353  75 0B           jne 0x7360
7355  C4 7E 06        les di, ptr [bp + 6]
7358  06              push es
7359  57              push di
735A  0E              push cs
735B  E8 43 E9        call 0x5ca1
735E  EB 1C           jmp 0x737c
loc_7360:
7360  3C 0A           cmp al, 0xa
7362  75 0B           jne 0x736f
7364  C4 7E 06        les di, ptr [bp + 6]
7367  06              push es
7368  57              push di
7369  0E              push cs
736A  E8 46 EB        call 0x5eb3
736D  EB 0D           jmp 0x737c
loc_736F:
736F  3C 0B           cmp al, 0xb
7371  75 09           jne 0x737c
7373  C4 7E 06        les di, ptr [bp + 6]
7376  06              push es
7377  57              push di
7378  0E              push cs
7379  E8 4E ED        call 0x60ca
loc_737C:
737C  55              push bp
737D  E8 55 FD        call 0x70d5
7380  C4 7E 06        les di, ptr [bp + 6]
7383  26 80 7D 10 05  cmp byte ptr es:[di + 0x10], 5
7388  B0 00           mov al, 0
738A  73 01           jae 0x738d
738C  40              inc ax
loc_738D:
738D  30 E4           xor ah, ah
738F  26 01 45 17     add word ptr es:[di + 0x17], ax
7393  80 3E 53 CF 00  cmp byte ptr [0xcf53], 0
7398  74 48           je 0x73e2
739A  26 8A 45 07     mov al, byte ptr es:[di + 7]
739E  3A 06 A0 D0     cmp al, byte ptr [0xd0a0]
73A2  75 3E           jne 0x73e2
73A4  06              push es
73A5  57              push di
73A6  0E              push cs
73A7  E8 0C AC        call 0x1fb6
73AA  08 C0           or al, al
73AC  74 34           je 0x73e2
73AE  C4 7E 06        les di, ptr [bp + 6]
73B1  26 80 7D 13 0C  cmp byte ptr es:[di + 0x13], 0xc
73B6  74 2A           je 0x73e2
73B8  A0 54 CF        mov al, byte ptr [0xcf54]
73BB  88 46 FF        mov byte ptr [bp - 1], al
73BE  A0 9F D0        mov al, byte ptr [0xd09f]
73C1  3A 06 A0 D0     cmp al, byte ptr [0xd0a0]
73C5  74 0C           je 0x73d3
73C7  80 3E 54 CF 00  cmp byte ptr [0xcf54], 0
73CC  75 05           jne 0x73d3
73CE  6A 19           push 0x19
73D0  E8 0F AA        call 0x1de2
loc_73D3:
73D3  C4 7E 06        les di, ptr [bp + 6]
73D6  06              push es
73D7  57              push di
73D8  0E              push cs
73D9  E8 92 FB        call 0x6f6e
73DC  8A 46 FF        mov al, byte ptr [bp - 1]
73DF  A2 54 CF        mov byte ptr [0xcf54], al
loc_73E2:
73E2  C4 7E 06        les di, ptr [bp + 6]
73E5  06              push es
73E6  57              push di
73E7  0E              push cs
73E8  E8 3D FA        call 0x6e28
73EB  80 3E B8 D0 00  cmp byte ptr [0xd0b8], 0
73F0  74 2D           je 0x741f
73F2  A0 28 0D        mov al, byte ptr [0xd28]
73F5  30 E4           xor ah, ah
73F7  8B F0           mov si, ax
73F9  D1 E0           shl ax, 1
73FB  D1 E0           shl ax, 1
73FD  01 F0           add ax, si
73FF  C4 7E 06        les di, ptr [bp + 6]
7402  26 3B 45 17     cmp ax, word ptr es:[di + 0x17]
7406  73 17           jae 0x741f
7408  C4 7E FA        les di, ptr [bp - 6]
740B  26 80 7D 08 01  cmp byte ptr es:[di + 8], 1
7410  7E 04           jle 0x7416
7412  26 FE 4D 08     dec byte ptr es:[di + 8]
loc_7416:
7416  C4 7E 06        les di, ptr [bp + 6]
7419  31 C0           xor ax, ax
741B  26 89 45 17     mov word ptr es:[di + 0x17], ax
loc_741F:
741F  C9              leave
7420  CA 04 00        retf 4

; ---- routine 0AB5:7423  (found by: call)
sub_7423:
7423  C8 04 00 00     enter 4, 0
7427  C4 7E 06        les di, ptr [bp + 6]
742A  26 8B 05        mov ax, word ptr es:[di]
742D  89 46 FE        mov word ptr [bp - 2], ax
7430  26 8A 45 07     mov al, byte ptr es:[di + 7]
7434  00 46 FE        add byte ptr [bp - 2], al
7437  26 8A 45 09     mov al, byte ptr es:[di + 9]
743B  00 46 FF        add byte ptr [bp - 1], al
743E  26 83 7D 0B 00  cmp word ptr es:[di + 0xb], 0
7443  76 04           jbe 0x7449
7445  26 FF 4D 0B     dec word ptr es:[di + 0xb]
loc_7449:
7449  C4 7E 06        les di, ptr [bp + 6]
744C  26 80 7D 0E 00  cmp byte ptr es:[di + 0xe], 0
7451  74 0C           je 0x745f
7453  06              push es
7454  57              push di
7455  9A 3F 0B 94 19  call far 1994:0B3F
745A  3D 02 00        cmp ax, 2
745D  77 04           ja 0x7463
loc_745F:
745F  B0 00           mov al, 0
7461  EB 02           jmp 0x7465
loc_7463:
7463  B0 01           mov al, 1
loc_7465:
7465  C4 7E 06        les di, ptr [bp + 6]
7468  26 88 45 0E     mov byte ptr es:[di + 0xe], al
746C  FF 76 FE        push word ptr [bp - 2]
746F  9A 1B 08 94 19  call far 1994:081B
7474  08 C0           or al, al
7476  74 09           je 0x7481
7478  8B 46 FE        mov ax, word ptr [bp - 2]
747B  C4 7E 06        les di, ptr [bp + 6]
747E  26 89 05        mov word ptr es:[di], ax
loc_7481:
7481  C4 7E 06        les di, ptr [bp + 6]
7484  06              push es
7485  57              push di
7486  9A 16 0A 94 19  call far 1994:0A16
748B  C4 7E 06        les di, ptr [bp + 6]
748E  26 FF 35        push word ptr es:[di]
7491  9A 4B 08 94 19  call far 1994:084B
7496  08 C0           or al, al
7498  74 03           je 0x749d
749A  E9 F9 00        jmp 0x7596
loc_749D:
749D  6A 02           push 2
749F  9A E0 01 94 19  call far 1994:01E0
74A4  80 3E A1 D0 00  cmp byte ptr [0xd0a1], 0
74A9  76 41           jbe 0x74ec
74AB  C4 7E 06        les di, ptr [bp + 6]
74AE  26 8A 05        mov al, byte ptr es:[di]
74B1  98              cwde
74B2  99              cdq
74B3  31 D0           xor ax, dx
74B5  29 D0           sub ax, dx
74B7  3D 01 00        cmp ax, 1
74BA  7F 23           jg 0x74df
74BC  A0 9F D0        mov al, byte ptr [0xd09f]
74BF  30 E4           xor ah, ah
74C1  6B F8 19        imul di, ax, 0x19
74C4  81 C7 EF CC     add di, 0xccef
74C8  1E              push ds
74C9  57              push di
74CA  0E              push cs
74CB  E8 FE A9        call 0x1ecc
74CE  98              cwde
74CF  8B D0           mov dx, ax
74D1  C4 7E 06        les di, ptr [bp + 6]
74D4  26 8A 45 01     mov al, byte ptr es:[di + 1]
74D8  98              cwde
74D9  F7 E2           mul dx
74DB  09 C0           or ax, ax
74DD  7D 0D           jge 0x74ec
loc_74DF:
74DF  E8 A1 F8        call 0x6d83
74E2  08 C0           or al, al
74E4  75 06           jne 0x74ec
74E6  E8 D7 F8        call 0x6dc0
74E9  E9 AA 00        jmp 0x7596
loc_74EC:
74EC  C6 06 A0 D0 00  mov byte ptr [0xd0a0], 0
74F1  C6 06 9E D0 00  mov byte ptr [0xd09e], 0
74F6  C6 06 B8 D0 00  mov byte ptr [0xd0b8], 0
74FB  C4 7E 06        les di, ptr [bp + 6]
74FE  26 8A 05        mov al, byte ptr es:[di]
7501  98              cwde
7502  99              cdq
7503  31 D0           xor ax, dx
7505  29 D0           sub ax, dx
7507  3D 01 00        cmp ax, 1
750A  7F 2D           jg 0x7539
750C  A0 9F D0        mov al, byte ptr [0xd09f]
750F  30 E4           xor ah, ah
7511  6B F8 19        imul di, ax, 0x19
7514  81 C7 EF CC     add di, 0xccef
7518  1E              push ds
7519  57              push di
751A  0E              push cs
751B  E8 AE A9        call 0x1ecc
751E  98              cwde
751F  8B D0           mov dx, ax
7521  C4 7E 06        les di, ptr [bp + 6]
7524  26 8A 45 01     mov al, byte ptr es:[di + 1]
7528  98              cwde
7529  F7 E2           mul dx
752B  09 C0           or ax, ax
752D  7D 05           jge 0x7534
752F  E8 BD E0        call 0x55ef
7532  EB 03           jmp 0x7537
loc_7534:
7534  E8 AB DF        call 0x54e2
loc_7537:
7537  EB 4F           jmp 0x7588
loc_7539:
7539  C4 7E 06        les di, ptr [bp + 6]
753C  26 8A 45 01     mov al, byte ptr es:[di + 1]
7540  98              cwde
7541  99              cdq
7542  31 D0           xor ax, dx
7544  29 D0           sub ax, dx
7546  3D 26 00        cmp ax, 0x26
7549  7D 05           jge 0x7550
754B  E8 69 E4        call 0x59b7
754E  EB 38           jmp 0x7588
loc_7550:
7550  A0 9F D0        mov al, byte ptr [0xd09f]
7553  30 E4           xor ah, ah
7555  6B F8 19        imul di, ax, 0x19
7558  81 C7 EF CC     add di, 0xccef
755C  1E              push ds
755D  57              push di
755E  0E              push cs
755F  E8 6A A9        call 0x1ecc
7562  98              cwde
7563  8B D0           mov dx, ax
7565  C4 7E 06        les di, ptr [bp + 6]
7568  26 8A 45 01     mov al, byte ptr es:[di + 1]
756C  98              cwde
756D  F7 E2           mul dx
756F  09 C0           or ax, ax
7571  7D 05           jge 0x7578
7573  E8 90 E4        call 0x5a06
7576  EB 10           jmp 0x7588
loc_7578:
7578  E8 5B A7        call 0x1cd6
757B  08 C0           or al, al
757D  B0 00           mov al, 0
757F  75 01           jne 0x7582
7581  40              inc ax
loc_7582:
7582  50              push ax
7583  6A 00           push 0
7585  E8 F9 E4        call 0x5a81
loc_7588:
7588  C4 7E 06        les di, ptr [bp + 6]
758B  31 C0           xor ax, ax
758D  26 89 45 0B     mov word ptr es:[di + 0xb], ax
7591  C6 06 BB D0 00  mov byte ptr [0xd0bb], 0
loc_7596:
7596  C9              leave
7597  CA 04 00        retf 4

; ---- routine 0AB5:759A  (found by: call)
sub_759A:
759A  C8 04 00 00     enter 4, 0
759E  8A 46 06        mov al, byte ptr [bp + 6]
75A1  98              cwde
75A2  6B F8 07        imul di, ax, 7
75A5  81 C7 2E CF     add di, 0xcf2e
75A9  1E              push ds
75AA  07              pop es
75AB  89 7E FC        mov word ptr [bp - 4], di
75AE  8C 46 FE        mov word ptr [bp - 2], es
75B1  8A 46 06        mov al, byte ptr [bp + 6]
75B4  98              cwde
75B5  8B F8           mov di, ax
75B7  8A 85 56 0D     mov al, byte ptr [di + 0xd56]
75BB  30 E4           xor ah, ah
75BD  40              inc ax
75BE  6B F8 19        imul di, ax, 0x19
75C1  81 C7 EF CC     add di, 0xccef
75C5  1E              push ds
75C6  57              push di
75C7  0E              push cs
75C8  E8 01 A9        call 0x1ecc
75CB  98              cwde
75CC  C1 E0 03        shl ax, 3
75CF  C4 7E FC        les di, ptr [bp - 4]
75D2  26 88 05        mov byte ptr es:[di], al
75D5  26 C6 45 01 00  mov byte ptr es:[di + 1], 0
75DA  26 8B 05        mov ax, word ptr es:[di]
75DD  26 89 45 02     mov word ptr es:[di + 2], ax
75E1  C9              leave
75E2  C2 04 00        ret 4

; ---- routine 0AB5:75E5  (found by: call)
sub_75E5:
75E5  55              push bp
75E6  89 E5           mov bp, sp
75E8  6A 01           push 1
75EA  55              push bp
75EB  E8 AC FF        call 0x759a
75EE  6A 00           push 0
75F0  55              push bp
75F1  E8 A6 FF        call 0x759a
75F4  C6 06 3D CF 00  mov byte ptr [0xcf3d], 0
75F9  C6 06 3C CF 01  mov byte ptr [0xcf3c], 1
75FE  A1 3C CF        mov ax, word ptr [0xcf3c]
7601  A3 3E CF        mov word ptr [0xcf3e], ax
7604  A1 3C CF        mov ax, word ptr [0xcf3c]
7607  A3 43 CF        mov word ptr [0xcf43], ax
760A  C9              leave
760B  C3              ret

; ---- routine 0AB5:760C  (found by: call)
sub_760C:
760C  C8 0C 00 00     enter 0xc, 0
7610  C6 46 FF 00     mov byte ptr [bp - 1], 0
7614  EB 03           jmp 0x7619
loc_7616:
7616  FE 46 FF        inc byte ptr [bp - 1]
loc_7619:
7619  8A 46 FF        mov al, byte ptr [bp - 1]
761C  98              cwde
761D  6B F8 07        imul di, ax, 7
7620  81 C7 2E CF     add di, 0xcf2e
7624  1E              push ds
7625  07              pop es
7626  89 7E F6        mov word ptr [bp - 0xa], di
7629  8C 46 F8        mov word ptr [bp - 8], es
762C  26 C6 45 01 00  mov byte ptr es:[di + 1], 0
7631  8A 46 FF        mov al, byte ptr [bp - 1]
7634  98              cwde
7635  8B F8           mov di, ax
7637  8A 85 56 0D     mov al, byte ptr [di + 0xd56]
763B  30 E4           xor ah, ah
763D  40              inc ax
763E  6B F8 19        imul di, ax, 0x19
7641  81 C7 EF CC     add di, 0xccef
7645  1E              push ds
7646  57              push di
7647  0E              push cs
7648  E8 81 A8        call 0x1ecc
764B  98              cwde
764C  89 46 FA        mov word ptr [bp - 6], ax
764F  8A 46 FF        mov al, byte ptr [bp - 1]
7652  98              cwde
7653  8B F8           mov di, ax
7655  8A 85 56 0D     mov al, byte ptr [di + 0xd56]
7659  30 E4           xor ah, ah
765B  05 0B 00        add ax, 0xb
765E  89 46 F4        mov word ptr [bp - 0xc], ax
7661  8A 46 FF        mov al, byte ptr [bp - 1]
7664  98              cwde
7665  8B F8           mov di, ax
7667  8A 85 56 0D     mov al, byte ptr [di + 0xd56]
766B  30 E4           xor ah, ah
766D  40              inc ax
766E  40              inc ax
766F  3B 46 F4        cmp ax, word ptr [bp - 0xc]
7672  7F 3D           jg 0x76b1
7674  89 46 FC        mov word ptr [bp - 4], ax
7677  EB 03           jmp 0x767c
loc_7679:
7679  FF 46 FC        inc word ptr [bp - 4]
loc_767C:
767C  C4 7E F6        les di, ptr [bp - 0xa]
767F  26 8A 45 01     mov al, byte ptr es:[di + 1]
7683  98              cwde
7684  8B C8           mov cx, ax
7686  6B 7E FC 19     imul di, word ptr [bp - 4], 0x19
768A  8A 85 F0 CC     mov al, byte ptr [di - 0x3310]
768E  98              cwde
768F  F7 66 FA        mul word ptr [bp - 6]
7692  3B C1           cmp ax, cx
7694  7D 13           jge 0x76a9
7696  6B 7E FC 19     imul di, word ptr [bp - 4], 0x19
769A  8A 85 F0 CC     mov al, byte ptr [di - 0x3310]
769E  98              cwde
769F  F7 66 FA        mul word ptr [bp - 6]
76A2  C4 7E F6        les di, ptr [bp - 0xa]
76A5  26 88 45 01     mov byte ptr es:[di + 1], al
loc_76A9:
76A9  8B 46 FC        mov ax, word ptr [bp - 4]
76AC  3B 46 F4        cmp ax, word ptr [bp - 0xc]
76AF  75 C8           jne 0x7679
loc_76B1:
76B1  C4 7E F6        les di, ptr [bp - 0xa]
76B4  26 8A 45 01     mov al, byte ptr es:[di + 1]
76B8  98              cwde
76B9  F7 66 FA        mul word ptr [bp - 6]
76BC  26 88 45 01     mov byte ptr es:[di + 1], al
76C0  06              push es
76C1  57              push di
76C2  9A 7B 08 94 19  call far 1994:087B
76C7  C4 7E F6        les di, ptr [bp - 0xa]
76CA  26 80 7D 01 00  cmp byte ptr es:[di + 1], 0
76CF  B0 00           mov al, 0
76D1  7E 01           jle 0x76d4
76D3  40              inc ax
loc_76D4:
76D4  8A D0           mov dl, al
76D6  80 3E 47 CF 00  cmp byte ptr [0xcf47], 0
76DB  B0 00           mov al, 0
76DD  7E 01           jle 0x76e0
76DF  40              inc ax
loc_76E0:
76E0  3A C2           cmp al, dl
76E2  75 1F           jne 0x7703
76E4  80 3E BC D0 00  cmp byte ptr [0xd0bc], 0
76E9  74 18           je 0x7703
76EB  26 80 7D 01 00  cmp byte ptr es:[di + 1], 0
76F0  74 11           je 0x7703
76F2  FF 36 5A CF     push word ptr [0xcf5a]
76F6  26 FF 35        push word ptr es:[di]
76F9  BF 56 CF        mov di, 0xcf56
76FC  1E              push ds
76FD  57              push di
76FE  9A A3 09 94 19  call far 1994:09A3
loc_7703:
7703  80 7E FF 01     cmp byte ptr [bp - 1], 1
7707  74 03           je 0x770c
7709  E9 0A FF        jmp 0x7616
loc_770C:
770C  C9              leave
770D  C3              ret

; ---- routine 0AB5:770E  (found by: call)
sub_770E:
770E  55              push bp
770F  89 E5           mov bp, sp
7711  80 7E 0A 00     cmp byte ptr [bp + 0xa], 0
7715  74 7C           je 0x7793
7717  A0 47 CF        mov al, byte ptr [0xcf47]
771A  C4 7E 06        les di, ptr [bp + 6]
771D  26 88 45 08     mov byte ptr es:[di + 8], al
7721  A0 46 CF        mov al, byte ptr [0xcf46]
7724  98              cwde
7725  40              inc ax
7726  26 88 45 07     mov byte ptr es:[di + 7], al
772A  26 8A 45 08     mov al, byte ptr es:[di + 8]
772E  26 3A 45 01     cmp al, byte ptr es:[di + 1]
7732  B0 00           mov al, 0
7734  7E 01           jle 0x7737
7736  40              inc ax
loc_7737:
7737  98              cwde
7738  8B F8           mov di, ax
773A  8A 85 38 A3     mov al, byte ptr [di - 0x5cc8]
773E  C4 7E 06        les di, ptr [bp + 6]
7741  26 00 45 01     add byte ptr es:[di + 1], al
7745  26 8A 45 07     mov al, byte ptr es:[di + 7]
7749  26 3A 05        cmp al, byte ptr es:[di]
774C  B0 00           mov al, 0
774E  7E 01           jle 0x7751
7750  40              inc ax
loc_7751:
7751  98              cwde
7752  8B F8           mov di, ax
7754  8A 85 38 A3     mov al, byte ptr [di - 0x5cc8]
7758  C4 7E 06        les di, ptr [bp + 6]
775B  26 00 05        add byte ptr es:[di], al
775E  E8 DD 8B        call 0x33e
7761  C4 7E 06        les di, ptr [bp + 6]
7764  06              push es
7765  57              push di
7766  9A 7B 08 94 19  call far 1994:087B
776B  C4 7E 06        les di, ptr [bp + 6]
776E  26 8B 4D 04     mov cx, word ptr es:[di + 4]
7772  26 8A 45 01     mov al, byte ptr es:[di + 1]
7776  98              cwde
7777  D1 E0           shl ax, 1
7779  8B D0           mov dx, ax
777B  26 8A 05        mov al, byte ptr es:[di]
777E  98              cwde
777F  69 C0 A0 00     imul ax, ax, 0xa0
7783  C4 3E 8A D0     les di, ptr [0xd08a]
7787  03 F8           add di, ax
7789  03 FA           add di, dx
778B  26 89 8D 0E 09  mov word ptr es:[di + 0x90e], cx
7790  E9 15 01        jmp 0x78a8
loc_7793:
7793  80 3E 47 CF 00  cmp byte ptr [0xcf47], 0
7798  7E 23           jle 0x77bd
779A  A0 47 CF        mov al, byte ptr [0xcf47]
779D  98              cwde
779E  40              inc ax
779F  99              cdq
77A0  52              push dx
77A1  50              push ax
77A2  6A 02           push 2
77A4  9A 6D 07 1A 23  call far 231A:076D
77A9  05 1E 00        add ax, 0x1e
77AC  99              cdq
77AD  52              push dx
77AE  50              push ax
77AF  9A FA 04 AC 24  call far 24AC:04FA
77B4  C4 7E 06        les di, ptr [bp + 6]
77B7  26 88 45 08     mov byte ptr es:[di + 8], al
77BB  EB 25           jmp 0x77e2
loc_77BD:
77BD  A0 47 CF        mov al, byte ptr [0xcf47]
77C0  98              cwde
77C1  48              dec ax
77C2  99              cdq
77C3  52              push dx
77C4  50              push ax
77C5  6A 02           push 2
77C7  9A 6D 07 1A 23  call far 231A:076D
77CC  8B D0           mov dx, ax
77CE  B8 E2 FF        mov ax, 0xffe2
77D1  2B C2           sub ax, dx
77D3  99              cdq
77D4  52              push dx
77D5  50              push ax
77D6  9A C0 04 AC 24  call far 24AC:04C0
77DB  C4 7E 06        les di, ptr [bp + 6]
77DE  26 88 45 08     mov byte ptr es:[di + 8], al
loc_77E2:
77E2  C4 7E 06        les di, ptr [bp + 6]
77E5  26 8A 45 08     mov al, byte ptr es:[di + 8]
77E9  98              cwde
77EA  99              cdq
77EB  B9 04 00        mov cx, 4
77EE  F7 F9           idiv cx
77F0  40              inc ax
77F1  26 88 45 07     mov byte ptr es:[di + 7], al
77F5  81 C7 07 00     add di, 7
77F9  06              push es
77FA  57              push di
77FB  6A FB           push -5
77FD  6A 05           push 5
77FF  9A 02 04 AC 24  call far 24AC:0402
7804  C4 7E 06        les di, ptr [bp + 6]
7807  26 8B 45 07     mov ax, word ptr es:[di + 7]
780B  26 3B 45 02     cmp ax, word ptr es:[di + 2]
780F  75 03           jne 0x7814
7811  E9 87 00        jmp 0x789b
loc_7814:
7814  26 8A 45 08     mov al, byte ptr es:[di + 8]
7818  26 3A 45 01     cmp al, byte ptr es:[di + 1]
781C  74 1B           je 0x7839
781E  26 8A 45 08     mov al, byte ptr es:[di + 8]
7822  26 3A 45 01     cmp al, byte ptr es:[di + 1]
7826  B0 00           mov al, 0
7828  7E 01           jle 0x782b
782A  40              inc ax
loc_782B:
782B  98              cwde
782C  8B F8           mov di, ax
782E  8A 85 38 A3     mov al, byte ptr [di - 0x5cc8]
7832  C4 7E 06        les di, ptr [bp + 6]
7835  26 00 45 01     add byte ptr es:[di + 1], al
loc_7839:
7839  C4 7E 06        les di, ptr [bp + 6]
783C  26 8A 45 07     mov al, byte ptr es:[di + 7]
7840  26 3A 05        cmp al, byte ptr es:[di]
7843  74 19           je 0x785e
7845  26 8A 45 07     mov al, byte ptr es:[di + 7]
7849  26 3A 05        cmp al, byte ptr es:[di]
784C  B0 00           mov al, 0
784E  7E 01           jle 0x7851
7850  40              inc ax
loc_7851:
7851  98              cwde
7852  8B F8           mov di, ax
7854  8A 85 38 A3     mov al, byte ptr [di - 0x5cc8]
7858  C4 7E 06        les di, ptr [bp + 6]
785B  26 00 05        add byte ptr es:[di], al
loc_785E:
785E  C4 7E 06        les di, ptr [bp + 6]
7861  26 8A 45 01     mov al, byte ptr es:[di + 1]
7865  98              cwde
7866  D1 E0           shl ax, 1
7868  8B D0           mov dx, ax
786A  26 8A 05        mov al, byte ptr es:[di]
786D  98              cwde
786E  69 C0 A0 00     imul ax, ax, 0xa0
7872  C4 3E 92 D0     les di, ptr [0xd092]
7876  03 F8           add di, ax
7878  03 FA           add di, dx
787A  26 8A 85 0E 09  mov al, byte ptr es:[di + 0x90e]
787F  B4 01           mov ah, 1
7881  BA 20 00        mov dx, 0x20
7884  9A 1F 0E B9 26  call far 26B9:0E1F
7889  8B FA           mov di, dx
788B  84 85 36 0D     test byte ptr [di + 0xd36], al
788F  74 0A           je 0x789b
7891  C4 7E 06        les di, ptr [bp + 6]
7894  26 8B 45 02     mov ax, word ptr es:[di + 2]
7898  26 89 05        mov word ptr es:[di], ax
loc_789B:
789B  E8 A0 8A        call 0x33e
789E  C4 7E 06        les di, ptr [bp + 6]
78A1  06              push es
78A2  57              push di
78A3  9A 7B 08 94 19  call far 1994:087B
loc_78A8:
78A8  C9              leave
78A9  CA 06 00        retf 6
; data (not reached as code), 11 bytes
78AC                  pstr 'turbo'
78B2                  pstr '    '

