; 1-095.EXE (One-Nil 95), code segment 0AB5 (image offsets 0AB50..1993F), part 22 of 22
; packed 1-095.EXE sha256 f659fb2d334500d6901fc8d6a0f06c85c0ccda2eb4a3035ae3bb0a0004d79192 (LZEXE 0.91)
; unpacked (tools/static/unlzexe.py) sha256 8df646e017e0965a5d90a58181ca764219ad847833aad0b6cb58fc53372bfb2c
; tool: capstone 5.0.9 (pip package; core library 5.0.1280) (CS_ARCH_X86, CS_MODE_16), recursive descent from the entry point, far calls and near calls/jumps, then routine prologues (55 89 E5 / 55 8B EC / C8 iw 00) in what remains; tools/static/listing.py
; addresses are SEGMENT:OFFSET with SEGMENT the image paragraph before relocation; image offset = SEGMENT*16+OFFSET
; ---- routine 0AB5:E874  (found by: call)
sub_E874:
E874  C8 08 00 00     enter 8, 0
E878  A1 86 D6        mov ax, word ptr [0xd686]
E87B  89 46 FC        mov word ptr [bp - 4], ax
E87E  B8 01 00        mov ax, 1
E881  3B 46 FC        cmp ax, word ptr [bp - 4]
E884  77 63           ja 0xe8e9
E886  89 46 FE        mov word ptr [bp - 2], ax
E889  EB 03           jmp 0xe88e
loc_E88B:
E88B  FF 46 FE        inc word ptr [bp - 2]
loc_E88E:
E88E  8B 7E 04        mov di, word ptr [bp + 4]
E891  36 8B 45 06     mov ax, word ptr ss:[di + 6]
E895  8B F0           mov si, ax
E897  D1 E0           shl ax, 1
E899  01 F0           add ax, si
E89B  8B D0           mov dx, ax
E89D  8B 7E FE        mov di, word ptr [bp - 2]
E8A0  8A 85 FB D4     mov al, byte ptr [di - 0x2b05]
E8A4  30 E4           xor ah, ah
E8A6  69 C0 AE 00     imul ax, ax, 0xae
E8AA  C4 3E CA D7     les di, ptr [0xd7ca]
E8AE  03 F8           add di, ax
E8B0  03 FA           add di, dx
E8B2  81 C7 4F FF     add di, 0xff4f
E8B6  26 8A 05        mov al, byte ptr es:[di]
E8B9  98              cwde
E8BA  8B F8           mov di, ax
E8BC  8A 85 0C 0D     mov al, byte ptr [di + 0xd0c]
E8C0  30 E4           xor ah, ah
E8C2  8B 7E 04        mov di, word ptr [bp + 4]
E8C5  36 3B 45 06     cmp ax, word ptr ss:[di + 6]
E8C9  75 16           jne 0xe8e1
E8CB  8B 7E FE        mov di, word ptr [bp - 2]
E8CE  8A 85 FB D4     mov al, byte ptr [di - 0x2b05]
E8D2  30 E4           xor ah, ah
E8D4  50              push ax
E8D5  8B 7E 04        mov di, word ptr [bp + 4]
E8D8  36 FF 75 06     push word ptr ss:[di + 6]
E8DC  9A 16 73 51 1B  call far 1B51:7316
loc_E8E1:
E8E1  8B 46 FE        mov ax, word ptr [bp - 2]
E8E4  3B 46 FC        cmp ax, word ptr [bp - 4]
E8E7  75 A2           jne 0xe88b
loc_E8E9:
E8E9  C9              leave
E8EA  C2 02 00        ret 2

; ---- routine 0AB5:E8ED  (found by: call)
sub_E8ED:
E8ED  C8 08 00 00     enter 8, 0
E8F1  8B 7E 04        mov di, word ptr [bp + 4]
E8F4  36 8B 45 06     mov ax, word ptr ss:[di + 6]
E8F8  8B F0           mov si, ax
E8FA  D1 E0           shl ax, 1
E8FC  01 F0           add ax, si
E8FE  8B D0           mov dx, ax
E900  36 8B 7D FE     mov di, word ptr ss:[di - 2]
E904  8A 85 FB D4     mov al, byte ptr [di - 0x2b05]
E908  30 E4           xor ah, ah
E90A  69 C0 AE 00     imul ax, ax, 0xae
E90E  C4 3E CA D7     les di, ptr [0xd7ca]
E912  03 F8           add di, ax
E914  03 FA           add di, dx
E916  81 C7 4F FF     add di, 0xff4f
E91A  89 7E FC        mov word ptr [bp - 4], di
E91D  8C 46 FE        mov word ptr [bp - 2], es
E920  8B 7E 04        mov di, word ptr [bp + 4]
E923  36 8B 7D FE     mov di, word ptr ss:[di - 2]
E927  8A 85 FB D4     mov al, byte ptr [di - 0x2b05]
E92B  30 E4           xor ah, ah
E92D  50              push ax
E92E  6A 00           push 0
E930  C4 7E FC        les di, ptr [bp - 4]
E933  26 8A 45 02     mov al, byte ptr es:[di + 2]
E937  24 0F           and al, 0xf
E939  3C 01           cmp al, 1
E93B  B0 00           mov al, 0
E93D  75 01           jne 0xe940
E93F  40              inc ax
loc_E940:
E940  50              push ax
E941  9A 4B 50 51 1B  call far 1B51:504B
E946  C4 7E FC        les di, ptr [bp - 4]
E949  26 8A 45 01     mov al, byte ptr es:[di + 1]
E94D  30 E4           xor ah, ah
E94F  50              push ax
E950  6A 01           push 1
E952  6A 00           push 0
E954  9A 4B 50 51 1B  call far 1B51:504B
E959  6A 08           push 8
E95B  E8 1F F0        call 0xd97d
E95E  8B 7E 04        mov di, word ptr [bp + 4]
E961  36 8B 7D FE     mov di, word ptr ss:[di - 2]
E965  8A 85 FB D4     mov al, byte ptr [di - 0x2b05]
E969  30 E4           xor ah, ah
E96B  6B C0 3E        imul ax, ax, 0x3e
E96E  C4 3E C2 D7     les di, ptr [0xd7c2]
E972  03 F8           add di, ax
E974  26 80 7D F9 00  cmp byte ptr es:[di - 7], 0
E979  75 2F           jne 0xe9aa
E97B  C4 7E FC        les di, ptr [bp - 4]
E97E  26 8A 45 01     mov al, byte ptr es:[di + 1]
E982  30 E4           xor ah, ah
E984  6B C0 3E        imul ax, ax, 0x3e
E987  C4 3E C2 D7     les di, ptr [0xd7c2]
E98B  03 F8           add di, ax
E98D  26 80 7D F9 00  cmp byte ptr es:[di - 7], 0
E992  75 16           jne 0xe9aa
E994  80 3E 86 D0 01  cmp byte ptr [0xd086], 1
E999  76 0F           jbe 0xe9aa
E99B  80 3E 87 D0 01  cmp byte ptr [0xd087], 1
E9A0  76 08           jbe 0xe9aa
E9A2  FE 0E 86 D0     dec byte ptr [0xd086]
E9A6  FE 0E 87 D0     dec byte ptr [0xd087]
loc_E9AA:
E9AA  FF 36 86 D0     push word ptr [0xd086]
E9AE  8B 7E 04        mov di, word ptr [bp + 4]
E9B1  36 8B 55 06     mov dx, word ptr ss:[di + 6]
E9B5  36 8B 7D FE     mov di, word ptr ss:[di - 2]
E9B9  8A 85 FB D4     mov al, byte ptr [di - 0x2b05]
E9BD  30 E4           xor ah, ah
E9BF  6B C0 3A        imul ax, ax, 0x3a
E9C2  C4 3E CE D7     les di, ptr [0xd7ce]
E9C6  03 F8           add di, ax
E9C8  03 FA           add di, dx
E9CA  81 C7 C5 FF     add di, 0xffc5
E9CE  06              push es
E9CF  57              push di
E9D0  9A C5 01 1A 23  call far 231A:01C5
E9D5  C4 7E FC        les di, ptr [bp - 4]
E9D8  26 8A 45 02     mov al, byte ptr es:[di + 2]
E9DC  24 F0           and al, 0xf0
E9DE  30 E4           xor ah, ah
E9E0  C1 E8 04        shr ax, 4
E9E3  3D 01 00        cmp ax, 1
E9E6  74 03           je 0xe9eb
E9E8  E9 C1 00        jmp 0xeaac
loc_E9EB:
E9EB  8B 7E 04        mov di, word ptr [bp + 4]
E9EE  36 8B 7D FE     mov di, word ptr ss:[di - 2]
E9F2  8A 85 FB D4     mov al, byte ptr [di - 0x2b05]
E9F6  30 E4           xor ah, ah
E9F8  50              push ax
E9F9  8B 7E 04        mov di, word ptr [bp + 4]
E9FC  36 FF 75 06     push word ptr ss:[di + 6]
EA00  E8 FB EE        call 0xd8fe
EA03  08 C0           or al, al
EA05  75 03           jne 0xea0a
EA07  E9 A2 00        jmp 0xeaac
loc_EA0A:
EA0A  6A 03           push 3
EA0C  E8 6E EF        call 0xd97d
EA0F  FF 36 86 D0     push word ptr [0xd086]
EA13  8B 7E 04        mov di, word ptr [bp + 4]
EA16  36 8B 55 06     mov dx, word ptr ss:[di + 6]
EA1A  36 8B 7D FE     mov di, word ptr ss:[di - 2]
EA1E  8A 85 FB D4     mov al, byte ptr [di - 0x2b05]
EA22  30 E4           xor ah, ah
EA24  6B C0 3A        imul ax, ax, 0x3a
EA27  C4 3E CE D7     les di, ptr [0xd7ce]
EA2B  03 F8           add di, ax
EA2D  03 FA           add di, dx
EA2F  81 C7 C5 FF     add di, 0xffc5
EA33  06              push es
EA34  57              push di
EA35  9A C5 01 1A 23  call far 231A:01C5
EA3A  8B 7E 04        mov di, word ptr [bp + 4]
EA3D  36 8B 7D FE     mov di, word ptr ss:[di - 2]
EA41  8A 85 FB D4     mov al, byte ptr [di - 0x2b05]
EA45  30 E4           xor ah, ah
EA47  50              push ax
EA48  8B 7E 04        mov di, word ptr [bp + 4]
EA4B  36 FF 75 06     push word ptr ss:[di + 6]
EA4F  E8 AC EE        call 0xd8fe
EA52  08 C0           or al, al
EA54  74 56           je 0xeaac
EA56  6A 02           push 2
EA58  9A 1C 0D AC 24  call far 24AC:0D1C
EA5D  08 C0           or al, al
EA5F  74 14           je 0xea75
EA61  C4 7E FC        les di, ptr [bp - 4]
EA64  26 8A 45 02     mov al, byte ptr es:[di + 2]
EA68  24 0F           and al, 0xf
EA6A  30 E4           xor ah, ah
EA6C  05 80 00        add ax, 0x80
EA6F  26 88 45 02     mov byte ptr es:[di + 2], al
EA73  EB 37           jmp 0xeaac
loc_EA75:
EA75  8B 7E 04        mov di, word ptr [bp + 4]
EA78  36 8B 45 06     mov ax, word ptr ss:[di + 6]
EA7C  8B F0           mov si, ax
EA7E  D1 E0           shl ax, 1
EA80  01 F0           add ax, si
EA82  8B D0           mov dx, ax
EA84  C4 7E FC        les di, ptr [bp - 4]
EA87  26 8A 45 01     mov al, byte ptr es:[di + 1]
EA8B  30 E4           xor ah, ah
EA8D  69 C0 AE 00     imul ax, ax, 0xae
EA91  C4 3E CA D7     les di, ptr [0xd7ca]
EA95  03 F8           add di, ax
EA97  03 FA           add di, dx
EA99  81 C7 4F FF     add di, 0xff4f
EA9D  26 8A 45 02     mov al, byte ptr es:[di + 2]
EAA1  24 0F           and al, 0xf
EAA3  30 E4           xor ah, ah
EAA5  05 80 00        add ax, 0x80
EAA8  26 88 45 02     mov byte ptr es:[di + 2], al
loc_EAAC:
EAAC  C9              leave
EAAD  C2 02 00        ret 2

; ---- routine 0AB5:EAB0  (found by: far)
sub_EAB0:
EAB0  C8 0E 00 00     enter 0xe, 0
EAB4  C6 06 84 D0 00  mov byte ptr [0xd084], 0
EAB9  31 C0           xor ax, ax
EABB  A3 44 D1        mov word ptr [0xd144], ax
EABE  A3 46 D1        mov word ptr [0xd146], ax
EAC1  FF 76 06        push word ptr [bp + 6]
EAC4  9A 7A 41 51 1B  call far 1B51:417A
EAC9  A1 86 D6        mov ax, word ptr [0xd686]
EACC  89 46 F6        mov word ptr [bp - 0xa], ax
EACF  B8 01 00        mov ax, 1
EAD2  3B 46 F6        cmp ax, word ptr [bp - 0xa]
EAD5  77 75           ja 0xeb4c
EAD7  89 46 FE        mov word ptr [bp - 2], ax
EADA  EB 03           jmp 0xeadf
loc_EADC:
EADC  FF 46 FE        inc word ptr [bp - 2]
loc_EADF:
EADF  8B 46 06        mov ax, word ptr [bp + 6]
EAE2  8B F0           mov si, ax
EAE4  D1 E0           shl ax, 1
EAE6  01 F0           add ax, si
EAE8  8B D0           mov dx, ax
EAEA  8B 7E FE        mov di, word ptr [bp - 2]
EAED  8A 85 FB D4     mov al, byte ptr [di - 0x2b05]
EAF1  30 E4           xor ah, ah
EAF3  69 C0 AE 00     imul ax, ax, 0xae
EAF7  C4 3E CA D7     les di, ptr [0xd7ca]
EAFB  03 F8           add di, ax
EAFD  03 FA           add di, dx
EAFF  81 C7 4F FF     add di, 0xff4f
EB03  89 7E F2        mov word ptr [bp - 0xe], di
EB06  8C 46 F4        mov word ptr [bp - 0xc], es
EB09  8B 7E FE        mov di, word ptr [bp - 2]
EB0C  8A 85 FB D4     mov al, byte ptr [di - 0x2b05]
EB10  30 E4           xor ah, ah
EB12  50              push ax
EB13  FF 76 06        push word ptr [bp + 6]
EB16  E8 5A F9        call 0xe473
EB19  08 C0           or al, al
EB1B  74 27           je 0xeb44
EB1D  8B 7E FE        mov di, word ptr [bp - 2]
EB20  8A 85 FB D4     mov al, byte ptr [di - 0x2b05]
EB24  30 E4           xor ah, ah
EB26  50              push ax
EB27  C4 7E F2        les di, ptr [bp - 0xe]
EB2A  26 8A 45 01     mov al, byte ptr es:[di + 1]
EB2E  30 E4           xor ah, ah
EB30  50              push ax
EB31  9A 99 1B 94 19  call far 1994:1B99
EB36  08 C0           or al, al
EB38  74 0A           je 0xeb44
EB3A  8B 7E FE        mov di, word ptr [bp - 2]
EB3D  8A 85 FB D4     mov al, byte ptr [di - 0x2b05]
EB41  A2 84 D0        mov byte ptr [0xd084], al
loc_EB44:
EB44  8B 46 FE        mov ax, word ptr [bp - 2]
EB47  3B 46 F6        cmp ax, word ptr [bp - 0xa]
EB4A  75 90           jne 0xeadc
loc_EB4C:
EB4C  A1 86 D6        mov ax, word ptr [0xd686]
EB4F  89 46 F6        mov word ptr [bp - 0xa], ax
EB52  B8 01 00        mov ax, 1
EB55  3B 46 F6        cmp ax, word ptr [bp - 0xa]
EB58  76 03           jbe 0xeb5d
EB5A  E9 8E 00        jmp 0xebeb
loc_EB5D:
EB5D  89 46 FE        mov word ptr [bp - 2], ax
EB60  EB 03           jmp 0xeb65
loc_EB62:
EB62  FF 46 FE        inc word ptr [bp - 2]
loc_EB65:
EB65  8B 46 06        mov ax, word ptr [bp + 6]
EB68  8B F0           mov si, ax
EB6A  D1 E0           shl ax, 1
EB6C  01 F0           add ax, si
EB6E  8B D0           mov dx, ax
EB70  8B 7E FE        mov di, word ptr [bp - 2]
EB73  8A 85 FB D4     mov al, byte ptr [di - 0x2b05]
EB77  30 E4           xor ah, ah
EB79  69 C0 AE 00     imul ax, ax, 0xae
EB7D  C4 3E CA D7     les di, ptr [0xd7ca]
EB81  03 F8           add di, ax
EB83  03 FA           add di, dx
EB85  81 C7 4F FF     add di, 0xff4f
EB89  89 7E F2        mov word ptr [bp - 0xe], di
EB8C  8C 46 F4        mov word ptr [bp - 0xc], es
EB8F  8B 7E FE        mov di, word ptr [bp - 2]
EB92  8A 85 FB D4     mov al, byte ptr [di - 0x2b05]
EB96  30 E4           xor ah, ah
EB98  50              push ax
EB99  FF 76 06        push word ptr [bp + 6]
EB9C  E8 D4 F8        call 0xe473
EB9F  08 C0           or al, al
EBA1  74 3D           je 0xebe0
EBA3  8B 7E FE        mov di, word ptr [bp - 2]
EBA6  8A 85 FB D4     mov al, byte ptr [di - 0x2b05]
EBAA  30 E4           xor ah, ah
EBAC  50              push ax
EBAD  C4 7E F2        les di, ptr [bp - 0xe]
EBB0  26 8A 45 01     mov al, byte ptr es:[di + 1]
EBB4  30 E4           xor ah, ah
EBB6  50              push ax
EBB7  9A 99 1B 94 19  call far 1994:1B99
EBBC  08 C0           or al, al
EBBE  74 20           je 0xebe0
EBC0  6A 01           push 1
EBC2  55              push bp
EBC3  E8 23 FA        call 0xe5e9
EBC6  80 7E F9 00     cmp byte ptr [bp - 7], 0
EBCA  74 14           je 0xebe0
EBCC  8B 7E FE        mov di, word ptr [bp - 2]
EBCF  8A 85 FB D4     mov al, byte ptr [di - 0x2b05]
EBD3  30 E4           xor ah, ah
EBD5  50              push ax
EBD6  FF 76 06        push word ptr [bp + 6]
EBD9  E8 10 F6        call 0xe1ec
EBDC  55              push bp
EBDD  E8 93 FA        call 0xe673
loc_EBE0:
EBE0  8B 46 FE        mov ax, word ptr [bp - 2]
EBE3  3B 46 F6        cmp ax, word ptr [bp - 0xa]
EBE6  74 03           je 0xebeb
EBE8  E9 77 FF        jmp 0xeb62
loc_EBEB:
EBEB  A1 86 D6        mov ax, word ptr [0xd686]
EBEE  89 46 F6        mov word ptr [bp - 0xa], ax
EBF1  B8 01 00        mov ax, 1
EBF4  3B 46 F6        cmp ax, word ptr [bp - 0xa]
EBF7  76 03           jbe 0xebfc
EBF9  E9 D6 00        jmp 0xecd2
loc_EBFC:
EBFC  89 46 FE        mov word ptr [bp - 2], ax
EBFF  EB 03           jmp 0xec04
loc_EC01:
EC01  FF 46 FE        inc word ptr [bp - 2]
loc_EC04:
EC04  8B 46 06        mov ax, word ptr [bp + 6]
EC07  8B F0           mov si, ax
EC09  D1 E0           shl ax, 1
EC0B  01 F0           add ax, si
EC0D  8B D0           mov dx, ax
EC0F  8B 7E FE        mov di, word ptr [bp - 2]
EC12  8A 85 FB D4     mov al, byte ptr [di - 0x2b05]
EC16  30 E4           xor ah, ah
EC18  69 C0 AE 00     imul ax, ax, 0xae
EC1C  C4 3E CA D7     les di, ptr [0xd7ca]
EC20  03 F8           add di, ax
EC22  03 FA           add di, dx
EC24  81 C7 4F FF     add di, 0xff4f
EC28  89 7E F2        mov word ptr [bp - 0xe], di
EC2B  8C 46 F4        mov word ptr [bp - 0xc], es
EC2E  8B 7E FE        mov di, word ptr [bp - 2]
EC31  8A 85 FB D4     mov al, byte ptr [di - 0x2b05]
EC35  30 E4           xor ah, ah
EC37  50              push ax
EC38  FF 76 06        push word ptr [bp + 6]
EC3B  E8 35 F8        call 0xe473
EC3E  08 C0           or al, al
EC40  75 03           jne 0xec45
EC42  E9 82 00        jmp 0xecc7
loc_EC45:
EC45  6A 00           push 0
EC47  55              push bp
EC48  E8 9E F9        call 0xe5e9
EC4B  8B 7E FE        mov di, word ptr [bp - 2]
EC4E  8A 85 FB D4     mov al, byte ptr [di - 0x2b05]
EC52  30 E4           xor ah, ah
EC54  50              push ax
EC55  E8 54 B0        call 0x9cac
EC58  C4 7E F2        les di, ptr [bp - 0xe]
EC5B  26 8A 45 01     mov al, byte ptr es:[di + 1]
EC5F  30 E4           xor ah, ah
EC61  50              push ax
EC62  E8 47 B0        call 0x9cac
EC65  55              push bp
EC66  E8 84 FC        call 0xe8ed
EC69  55              push bp
EC6A  E8 06 FA        call 0xe673
EC6D  BF E8 30        mov di, 0x30e8
EC70  1E              push ds
EC71  57              push di
EC72  BF 5C DD        mov di, 0xdd5c
EC75  1E              push ds
EC76  57              push di
EC77  9A 2F 05 1A 23  call far 231A:052F
EC7C  C4 3E 5C DD     les di, ptr [0xdd5c]
EC80  81 C7 00 0F     add di, 0xf00
EC84  06              push es
EC85  57              push di
EC86  6A 70           push 0x70
EC88  6B 46 FE 50     imul ax, word ptr [bp - 2], 0x50
EC8C  31 D2           xor dx, dx
EC8E  F7 36 86 D6     div word ptr [0xd686]
EC92  50              push ax
EC93  9A 4B 03 AC 24  call far 24AC:034B
EC98  C4 3E 5C DD     les di, ptr [0xdd5c]
EC9C  81 C7 00 0F     add di, 0xf00
ECA0  06              push es
ECA1  57              push di
ECA2  C4 3E 58 DD     les di, ptr [0xdd58]
ECA6  81 C7 00 0F     add di, 0xf00
ECAA  06              push es
ECAB  57              push di
ECAC  68 A0 00        push 0xa0
ECAF  9A 12 0A B9 26  call far 26B9:0A12
ECB4  9A 58 0C AC 24  call far 24AC:0C58
ECB9  08 C0           or al, al
ECBB  74 0A           je 0xecc7
ECBD  9A 9B 09 1A 23  call far 231A:099B
ECC2  C6 06 84 D0 00  mov byte ptr [0xd084], 0
loc_ECC7:
ECC7  8B 46 FE        mov ax, word ptr [bp - 2]
ECCA  3B 46 F6        cmp ax, word ptr [bp - 0xa]
ECCD  74 03           je 0xecd2
ECCF  E9 2F FF        jmp 0xec01
loc_ECD2:
ECD2  8B 7E 06        mov di, word ptr [bp + 6]
ECD5  80 BD 6A A2 00  cmp byte ptr [di - 0x5d96], 0
ECDA  74 03           je 0xecdf
ECDC  E9 7D 00        jmp 0xed5c
loc_ECDF:
ECDF  E8 5E AB        call 0x9840
ECE2  C7 46 FE 51 00  mov word ptr [bp - 2], 0x51
ECE7  EB 03           jmp 0xecec
loc_ECE9:
ECE9  FF 46 FE        inc word ptr [bp - 2]
loc_ECEC:
ECEC  8B 46 06        mov ax, word ptr [bp + 6]
ECEF  8B F0           mov si, ax
ECF1  D1 E0           shl ax, 1
ECF3  01 F0           add ax, si
ECF5  8B D0           mov dx, ax
ECF7  8B 7E FE        mov di, word ptr [bp - 2]
ECFA  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
ECFE  30 E4           xor ah, ah
ED00  69 C0 AE 00     imul ax, ax, 0xae
ED04  C4 3E CA D7     les di, ptr [0xd7ca]
ED08  03 F8           add di, ax
ED0A  03 FA           add di, dx
ED0C  81 C7 4F FF     add di, 0xff4f
ED10  26 80 7D 01 00  cmp byte ptr es:[di + 1], 0
ED15  75 3E           jne 0xed55
ED17  6A 04           push 4
ED19  9A 6D 07 1A 23  call far 231A:076D
ED1E  48              dec ax
ED1F  A2 86 D0        mov byte ptr [0xd086], al
ED22  6A 04           push 4
ED24  9A 6D 07 1A 23  call far 231A:076D
ED29  48              dec ax
ED2A  A2 87 D0        mov byte ptr [0xd087], al
ED2D  8B 7E FE        mov di, word ptr [bp - 2]
ED30  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
ED34  30 E4           xor ah, ah
ED36  50              push ax
ED37  E8 72 AF        call 0x9cac
ED3A  8B 7E FE        mov di, word ptr [bp - 2]
ED3D  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
ED41  30 E4           xor ah, ah
ED43  50              push ax
ED44  A0 86 D0        mov al, byte ptr [0xd086]
ED47  30 E4           xor ah, ah
ED49  50              push ax
ED4A  A0 87 D0        mov al, byte ptr [0xd087]
ED4D  30 E4           xor ah, ah
ED4F  50              push ax
ED50  9A 97 18 94 19  call far 1994:1897
loc_ED55:
ED55  81 7E FE B0 00  cmp word ptr [bp - 2], 0xb0
ED5A  75 8D           jne 0xece9
loc_ED5C:
ED5C  80 3E 84 D0 00  cmp byte ptr [0xd084], 0
ED61  74 14           je 0xed77
ED63  BF DA 4E        mov di, 0x4eda
ED66  1E              push ds
ED67  57              push di
ED68  BF 58 DD        mov di, 0xdd58
ED6B  1E              push ds
ED6C  57              push di
ED6D  9A 2F 05 1A 23  call far 231A:052F
ED72  9A 9B 09 1A 23  call far 231A:099B
loc_ED77:
ED77  8B 7E 06        mov di, word ptr [bp + 6]
ED7A  80 BD 6A A2 00  cmp byte ptr [di - 0x5d96], 0
ED7F  74 04           je 0xed85
ED81  55              push bp
ED82  E8 EF FA        call 0xe874
loc_ED85:
ED85  C9              leave
ED86  CA 02 00        retf 2

; ---- routine 0AB5:ED89  (found by: far)
sub_ED89:
ED89  55              push bp
ED8A  89 E5           mov bp, sp
ED8C  C4 3E 58 DD     les di, ptr [0xdd58]
ED90  89 F8           mov ax, di
ED92  8C C2           mov dx, es
ED94  A3 9A D0        mov word ptr [0xd09a], ax
ED97  89 16 9C D0     mov word ptr [0xd09c], dx
ED9B  C4 3E 9A D0     les di, ptr [0xd09a]
ED9F  89 F8           mov ax, di
EDA1  8C C2           mov dx, es
EDA3  A3 8A D0        mov word ptr [0xd08a], ax
EDA6  89 16 8C D0     mov word ptr [0xd08c], dx
EDAA  C4 3E 5C DD     les di, ptr [0xdd5c]
EDAE  89 F8           mov ax, di
EDB0  8C C2           mov dx, es
EDB2  A3 8E D0        mov word ptr [0xd08e], ax
EDB5  89 16 90 D0     mov word ptr [0xd090], dx
EDB9  BF 92 D0        mov di, 0xd092
EDBC  1E              push ds
EDBD  57              push di
EDBE  68 A0 0F        push 0xfa0
EDC1  9A 85 14 AC 24  call far 24AC:1485
EDC6  C4 3E 60 DD     les di, ptr [0xdd60]
EDCA  89 F8           mov ax, di
EDCC  8C C2           mov dx, es
EDCE  A3 96 D0        mov word ptr [0xd096], ax
EDD1  89 16 98 D0     mov word ptr [0xd098], dx
EDD5  C4 3E 26 DE     les di, ptr [0xde26]
EDD9  26 8B 05        mov ax, word ptr es:[di]
EDDC  A3 D0 D0        mov word ptr [0xd0d0], ax
EDDF  C9              leave
EDE0  CB              retf
; data (not reached as code), 15 bytes
EDE1                  db 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00   ; ...............
