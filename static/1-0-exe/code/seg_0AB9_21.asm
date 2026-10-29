; 1-0.EXE (One-Nil 96), code segment 0AB9 (image offsets 0AB90..1997F), part 21 of 22
; packed 1-0.EXE sha256 89ff9c5f238f24e81a0c2440a46cdd8997280a65fc3cc3d97cb974f55280a80a (LZEXE 0.91)
; unpacked (tools/static/unlzexe.py) sha256 887ed2a92767950e5309b2052409f875668605939b69e00737aa3047022b9f51
; tool: capstone 5.0.9 (pip package; core library 5.0.1280) (CS_ARCH_X86, CS_MODE_16), recursive descent from the entry point, far calls and near calls/jumps, then routine prologues (55 89 E5 / 55 8B EC / C8 iw 00) in what remains; tools/static/listing.py
; addresses are SEGMENT:OFFSET with SEGMENT the image paragraph before relocation; image offset = SEGMENT*16+OFFSET
; ---- routine 0AB9:DD02  (found by: call)
sub_DD02:
DD02  C8 2E 00 00     enter 0x2e, 0
DD06  C4 3E 58 DD     les di, ptr [0xdd58]
DD0A  06              push es
DD0B  57              push di
DD0C  C4 3E 60 DD     les di, ptr [0xdd60]
DD10  06              push es
DD11  57              push di
DD12  68 A0 0F        push 0xfa0
DD15  9A 12 0A C9 26  call far 26C9:0A12
DD1A  C6 06 B8 D0 01  mov byte ptr [0xd0b8], 1
DD1F  C6 46 DA 00     mov byte ptr [bp - 0x26], 0
DD23  31 C0           xor ax, ax
DD25  A3 B0 D0        mov word ptr [0xd0b0], ax
DD28  A1 C4 D0        mov ax, word ptr [0xd0c4]
DD2B  86 C4           xchg ah, al
DD2D  89 46 FC        mov word ptr [bp - 4], ax
DD30  8D 7E E6        lea di, [bp - 0x1a]
DD33  16              push ss
DD34  57              push di
DD35  6A 16           push 0x16
DD37  6A 00           push 0
DD39  9A 22 02 BC 24  call far 24BC:0222
DD3E  8B 46 FC        mov ax, word ptr [bp - 4]
DD41  89 46 FE        mov word ptr [bp - 2], ax
DD44  31 C0           xor ax, ax
DD46  A3 86 D0        mov word ptr [0xd086], ax
DD49  FF 36 E6 D6     push word ptr [0xd6e6]
DD4D  6A 00           push 0
DD4F  A0 29 0D        mov al, byte ptr [0xd29]
DD52  50              push ax
DD53  9A EB 50 55 1B  call far 1B55:50EB
DD58  FF 36 E4 D6     push word ptr [0xd6e4]
DD5C  6A 01           push 1
DD5E  6A 00           push 0
DD60  9A EB 50 55 1B  call far 1B55:50EB
DD65  80 3E AC D0 0F  cmp byte ptr [0xd0ac], 0xf
DD6A  B0 00           mov al, 0
DD6C  75 01           jne 0xdd6f
DD6E  40              inc ax
loc_DD6F:
DD6F  98              cwde
DD70  8B F8           mov di, ax
DD72  8A 85 FE 0C     mov al, byte ptr [di + 0xcfe]
DD76  30 E4           xor ah, ah
DD78  50              push ax
DD79  E8 07 FC        call 0xd983
DD7C  C7 46 DE 01 00  mov word ptr [bp - 0x22], 1
DD81  EB 03           jmp 0xdd86
loc_DD83:
DD83  FF 46 DE        inc word ptr [bp - 0x22]
loc_DD86:
DD86  8B 7E DE        mov di, word ptr [bp - 0x22]
DD89  8A 85 85 D0     mov al, byte ptr [di - 0x2f7b]
DD8D  8B 7E DE        mov di, word ptr [bp - 0x22]
DD90  3A 43 FD        cmp al, byte ptr [bp + di - 3]
DD93  77 03           ja 0xdd98
DD95  E9 94 01        jmp 0xdf2c
loc_DD98:
DD98  8B 7E DE        mov di, word ptr [bp - 0x22]
DD9B  8A 43 FD        mov al, byte ptr [bp + di - 3]
DD9E  8B 7E DE        mov di, word ptr [bp - 0x22]
DDA1  28 85 85 D0     sub byte ptr [di - 0x2f7b], al
DDA5  C7 46 E4 01 00  mov word ptr [bp - 0x1c], 1
DDAA  EB 03           jmp 0xddaf
loc_DDAC:
DDAC  FF 46 E4        inc word ptr [bp - 0x1c]
loc_DDAF:
DDAF  8B 7E E4        mov di, word ptr [bp - 0x1c]
DDB2  8A 85 85 D0     mov al, byte ptr [di - 0x2f7b]
DDB6  30 E4           xor ah, ah
DDB8  89 46 D8        mov word ptr [bp - 0x28], ax
DDBB  B8 01 00        mov ax, 1
DDBE  3B 46 D8        cmp ax, word ptr [bp - 0x28]
DDC1  77 37           ja 0xddfa
DDC3  89 46 E2        mov word ptr [bp - 0x1e], ax
DDC6  EB 03           jmp 0xddcb
loc_DDC8:
DDC8  FF 46 E2        inc word ptr [bp - 0x1e]
loc_DDCB:
DDCB  80 3E AC D0 0F  cmp byte ptr [0xd0ac], 0xf
DDD0  B0 00           mov al, 0
DDD2  75 01           jne 0xddd5
DDD4  40              inc ax
loc_DDD5:
DDD5  98              cwde
DDD6  8B F8           mov di, ax
DDD8  8A 85 00 0D     mov al, byte ptr [di + 0xd00]
DDDC  30 E4           xor ah, ah
DDDE  50              push ax
DDDF  9A 6D 07 2A 23  call far 232A:076D
DDE4  8A D0           mov dl, al
DDE6  8B 46 E2        mov ax, word ptr [bp - 0x1e]
DDE9  6B 7E E4 0B     imul di, word ptr [bp - 0x1c], 0xb
DDED  03 F8           add di, ax
DDEF  88 53 DA        mov byte ptr [bp + di - 0x26], dl
DDF2  8B 46 E2        mov ax, word ptr [bp - 0x1e]
DDF5  3B 46 D8        cmp ax, word ptr [bp - 0x28]
DDF8  75 CE           jne 0xddc8
loc_DDFA:
DDFA  83 7E E4 02     cmp word ptr [bp - 0x1c], 2
DDFE  75 AC           jne 0xddac
DE00  C7 46 E4 01 00  mov word ptr [bp - 0x1c], 1
DE05  EB 03           jmp 0xde0a
loc_DE07:
DE07  FF 46 E4        inc word ptr [bp - 0x1c]
loc_DE0A:
DE0A  8B 7E E4        mov di, word ptr [bp - 0x1c]
DE0D  8A 85 85 D0     mov al, byte ptr [di - 0x2f7b]
DE11  30 E4           xor ah, ah
DE13  89 46 D8        mov word ptr [bp - 0x28], ax
DE16  B8 01 00        mov ax, 1
DE19  3B 46 D8        cmp ax, word ptr [bp - 0x28]
DE1C  76 03           jbe 0xde21
DE1E  E9 02 01        jmp 0xdf23
loc_DE21:
DE21  89 46 E2        mov word ptr [bp - 0x1e], ax
DE24  EB 03           jmp 0xde29
loc_DE26:
DE26  FF 46 E2        inc word ptr [bp - 0x1e]
loc_DE29:
DE29  80 7E DA 00     cmp byte ptr [bp - 0x26], 0
DE2D  74 03           je 0xde32
DE2F  E9 E6 00        jmp 0xdf18
loc_DE32:
DE32  8B 46 E2        mov ax, word ptr [bp - 0x1e]
DE35  6B 7E E4 0B     imul di, word ptr [bp - 0x1c], 0xb
DE39  03 F8           add di, ax
DE3B  8A 43 DA        mov al, byte ptr [bp + di - 0x26]
DE3E  30 E4           xor ah, ah
DE40  3B 06 B2 D0     cmp ax, word ptr [0xd0b2]
DE44  74 03           je 0xde49
DE46  E9 CF 00        jmp 0xdf18
loc_DE49:
DE49  8B 7E E4        mov di, word ptr [bp - 0x1c]
DE4C  80 7B FD 0F     cmp byte ptr [bp + di - 3], 0xf
DE50  72 03           jb 0xde55
DE52  E9 C3 00        jmp 0xdf18
loc_DE55:
DE55  6A 1E           push 0x1e
DE57  9A 6D 07 2A 23  call far 232A:076D
DE5C  8B F8           mov di, ax
DE5E  8A 85 DF 0C     mov al, byte ptr [di + 0xcdf]
DE62  30 E4           xor ah, ah
DE64  89 46 DC        mov word ptr [bp - 0x24], ax
DE67  8B 46 DC        mov ax, word ptr [bp - 0x24]
DE6A  D1 E0           shl ax, 1
DE6C  8B D0           mov dx, ax
DE6E  83 7E E4 01     cmp word ptr [bp - 0x1c], 1
DE72  B0 00           mov al, 0
DE74  75 01           jne 0xde77
DE76  40              inc ax
loc_DE77:
DE77  98              cwde
DE78  8B F8           mov di, ax
DE7A  D1 E7           shl di, 1
DE7C  6B 85 E4 D6 3E  imul ax, word ptr [di - 0x291c], 0x3e
DE81  C4 3E C2 D7     les di, ptr [0xd7c2]
DE85  03 F8           add di, ax
DE87  03 FA           add di, dx
DE89  26 FF 75 C0     push word ptr es:[di - 0x40]
DE8D  9A 89 4F 55 1B  call far 1B55:4F89
DE92  08 C0           or al, al
DE94  75 BF           jne 0xde55
DE96  8B 7E E4        mov di, word ptr [bp - 0x1c]
DE99  FE 43 FD        inc byte ptr [bp + di - 3]
DE9C  83 7E E4 01     cmp word ptr [bp - 0x1c], 1
DEA0  B0 00           mov al, 0
DEA2  75 01           jne 0xdea5
DEA4  40              inc ax
loc_DEA5:
DEA5  98              cwde
DEA6  8B F8           mov di, ax
DEA8  D1 E7           shl di, 1
DEAA  6B 85 E4 D6 3E  imul ax, word ptr [di - 0x291c], 0x3e
DEAF  C4 3E C2 D7     les di, ptr [0xd7c2]
DEB3  03 F8           add di, ax
DEB5  81 C7 C2 FF     add di, 0xffc2
DEB9  89 7E D4        mov word ptr [bp - 0x2c], di
DEBC  8C 46 D6        mov word ptr [bp - 0x2a], es
DEBF  8B 46 DC        mov ax, word ptr [bp - 0x24]
DEC2  D1 E0           shl ax, 1
DEC4  03 F8           add di, ax
DEC6  26 FF 75 FE     push word ptr es:[di - 2]
DECA  C4 7E D4        les di, ptr [bp - 0x2c]
DECD  06              push es
DECE  57              push di
DECF  9A 6E 5C 55 1B  call far 1B55:5C6E
DED4  8B D0           mov dx, ax
DED6  83 7E E4 01     cmp word ptr [bp - 0x1c], 1
DEDA  B0 00           mov al, 0
DEDC  75 01           jne 0xdedf
DEDE  40              inc ax
loc_DEDF:
DEDF  98              cwde
DEE0  8B F8           mov di, ax
DEE2  8A 85 56 0D     mov al, byte ptr [di + 0xd56]
DEE6  30 E4           xor ah, ah
DEE8  03 C2           add ax, dx
DEEA  A2 9F D0        mov byte ptr [0xd09f], al
DEED  83 7E E4 01     cmp word ptr [bp - 0x1c], 1
DEF1  B0 00           mov al, 0
DEF3  75 01           jne 0xdef6
DEF5  40              inc ax
loc_DEF6:
DEF6  50              push ax
DEF7  A0 9F D0        mov al, byte ptr [0xd09f]
DEFA  30 E4           xor ah, ah
DEFC  50              push ax
DEFD  8B 46 E2        mov ax, word ptr [bp - 0x1e]
DF00  6B 7E E4 0B     imul di, word ptr [bp - 0x1c], 0xb
DF04  03 F8           add di, ax
DF06  8A 43 DA        mov al, byte ptr [bp + di - 0x26]
DF09  30 E4           xor ah, ah
DF0B  50              push ax
DF0C  E8 74 71        call 0x15083
DF0F  C6 46 DA 01     mov byte ptr [bp - 0x26], 1
DF13  C7 46 DE 02 00  mov word ptr [bp - 0x22], 2
loc_DF18:
DF18  8B 46 E2        mov ax, word ptr [bp - 0x1e]
DF1B  3B 46 D8        cmp ax, word ptr [bp - 0x28]
DF1E  74 03           je 0xdf23
DF20  E9 03 FF        jmp 0xde26
loc_DF23:
DF23  83 7E E4 02     cmp word ptr [bp - 0x1c], 2
DF27  74 03           je 0xdf2c
DF29  E9 DB FE        jmp 0xde07
loc_DF2C:
DF2C  83 7E DE 02     cmp word ptr [bp - 0x22], 2
DF30  74 03           je 0xdf35
DF32  E9 4E FE        jmp 0xdd83
loc_DF35:
DF35  8B 46 FE        mov ax, word ptr [bp - 2]
DF38  A3 86 D0        mov word ptr [0xd086], ax
DF3B  A1 86 D0        mov ax, word ptr [0xd086]
DF3E  86 C4           xchg ah, al
DF40  A3 C4 D0        mov word ptr [0xd0c4], ax
DF43  FF 36 86 D0     push word ptr [0xd086]
DF47  C4 3E D2 D7     les di, ptr [0xd7d2]
DF4B  26 8A 05        mov al, byte ptr es:[di]
DF4E  30 E4           xor ah, ah
DF50  8B D0           mov dx, ax
DF52  6B 06 E6 D6 3A  imul ax, word ptr [0xd6e6], 0x3a
DF57  C4 3E CE D7     les di, ptr [0xd7ce]
DF5B  03 F8           add di, ax
DF5D  03 FA           add di, dx
DF5F  81 C7 C5 FF     add di, 0xffc5
DF63  06              push es
DF64  57              push di
DF65  9A C5 01 2A 23  call far 232A:01C5
DF6A  FF 36 AE D0     push word ptr [0xd0ae]
DF6E  6A 03           push 3
DF70  E8 63 21        call 0x100d6
DF73  BF 58 DD        mov di, 0xdd58
DF76  1E              push ds
DF77  57              push di
DF78  9A DF 02 98 19  call far 1998:02DF
DF7D  C7 46 E2 01 00  mov word ptr [bp - 0x1e], 1
DF82  EB 03           jmp 0xdf87
loc_DF84:
DF84  FF 46 E2        inc word ptr [bp - 0x1e]
loc_DF87:
DF87  6B 7E E2 19     imul di, word ptr [bp - 0x1e], 0x19
DF8B  81 C7 EF CC     add di, 0xccef
DF8F  1E              push ds
DF90  07              pop es
DF91  89 7E D6        mov word ptr [bp - 0x2a], di
DF94  8C 46 D8        mov word ptr [bp - 0x28], es
DF97  06              push es
DF98  57              push di
DF99  0E              push cs
DF9A  E8 04 3D        call 0x11ca1
DF9D  08 C0           or al, al
DF9F  74 0C           je 0xdfad
DFA1  C4 7E D6        les di, ptr [bp - 0x2a]
DFA4  06              push es
DFA5  57              push di
DFA6  9A 3F 09 98 19  call far 1998:093F
DFAB  EB 28           jmp 0xdfd5
loc_DFAD:
DFAD  A1 AE D0        mov ax, word ptr [0xd0ae]
DFB0  31 D2           xor dx, dx
DFB2  B9 05 00        mov cx, 5
DFB5  F7 F1           div cx
DFB7  92              xchg dx, ax
DFB8  09 C0           or ax, ax
DFBA  75 19           jne 0xdfd5
DFBC  C4 7E D6        les di, ptr [bp - 0x2a]
DFBF  26 6B 45 0E 0F  imul ax, word ptr es:[di + 0xe], 0xf
DFC4  C4 3E BE D7     les di, ptr [0xd7be]
DFC8  03 F8           add di, ax
DFCA  26 80 7D 08 01  cmp byte ptr es:[di + 8], 1
DFCF  7E 04           jle 0xdfd5
DFD1  26 FE 4D 08     dec byte ptr es:[di + 8]
loc_DFD5:
DFD5  83 7E E2 16     cmp word ptr [bp - 0x1e], 0x16
DFD9  75 A9           jne 0xdf84
DFDB  80 3E DD D6 00  cmp byte ptr [0xd6dd], 0
DFE0  74 0A           je 0xdfec
DFE2  80 7E DA 00     cmp byte ptr [bp - 0x26], 0
DFE6  75 04           jne 0xdfec
DFE8  55              push bp
DFE9  E8 DA FB        call 0xdbc6
loc_DFEC:
DFEC  80 7E DA 00     cmp byte ptr [bp - 0x26], 0
DFF0  75 05           jne 0xdff7
DFF2  E8 3A 8B        call 0x6b2f
DFF5  EB 0C           jmp 0xe003
loc_DFF7:
DFF7  6A 00           push 0
DFF9  6A 01           push 1
DFFB  9A 5C 04 98 19  call far 1998:045C
E000  E8 B3 72        call 0x152b6
loc_E003:
E003  E8 B1 98        call 0x78b7
E006  C9              leave
E007  C3              ret

; ---- routine 0AB9:E008  (found by: call)
sub_E008:
E008  C8 08 00 00     enter 8, 0
E00C  C6 46 FF 00     mov byte ptr [bp - 1], 0
E010  EB 03           jmp 0xe015
loc_E012:
E012  FE 46 FF        inc byte ptr [bp - 1]
loc_E015:
E015  8A 46 FF        mov al, byte ptr [bp - 1]
E018  98              cwde
E019  8B F8           mov di, ax
E01B  D1 E7           shl di, 1
E01D  6B 85 E4 D6 3E  imul ax, word ptr [di - 0x291c], 0x3e
E022  C4 3E C2 D7     les di, ptr [0xd7c2]
E026  03 F8           add di, ax
E028  81 C7 C2 FF     add di, 0xffc2
E02C  89 7E F8        mov word ptr [bp - 8], di
E02F  8C 46 FA        mov word ptr [bp - 6], es
E032  C7 46 FC 01 00  mov word ptr [bp - 4], 1
E037  EB 03           jmp 0xe03c
loc_E039:
E039  FF 46 FC        inc word ptr [bp - 4]
loc_E03C:
E03C  8B 46 FC        mov ax, word ptr [bp - 4]
E03F  D1 E0           shl ax, 1
E041  C4 7E F8        les di, ptr [bp - 8]
E044  03 F8           add di, ax
E046  26 FF 75 FE     push word ptr es:[di - 2]
E04A  9A 6C 18 98 19  call far 1998:186C
E04F  83 7E FC 0B     cmp word ptr [bp - 4], 0xb
E053  75 E4           jne 0xe039
E055  80 7E FF 01     cmp byte ptr [bp - 1], 1
E059  75 B7           jne 0xe012
E05B  E8 28 9D        call 0x7d86
E05E  E8 F2 9C        call 0x7d53
E061  E8 6F 9D        call 0x7dd3
E064  9A 2E 02 2A 23  call far 232A:022E
E069  A1 C4 D0        mov ax, word ptr [0xd0c4]
E06C  86 C4           xchg ah, al
E06E  A3 86 D0        mov word ptr [0xd086], ax
E071  FF 36 86 D0     push word ptr [0xd086]
E075  8B 7E 04        mov di, word ptr [bp + 4]
E078  36 8B 55 04     mov dx, word ptr ss:[di + 4]
E07C  36 6B 45 06 3A  imul ax, word ptr ss:[di + 6], 0x3a
E081  C4 3E CE D7     les di, ptr [0xd7ce]
E085  03 F8           add di, ax
E087  03 FA           add di, dx
E089  81 C7 C5 FF     add di, 0xffc5
E08D  06              push es
E08E  57              push di
E08F  9A C5 01 2A 23  call far 232A:01C5
E094  80 3E 2A 0D 00  cmp byte ptr [0xd2a], 0
E099  75 03           jne 0xe09e
E09B  E9 F2 00        jmp 0xe190
loc_E09E:
E09E  8B 7E 04        mov di, word ptr [bp + 4]
E0A1  36 FF 75 06     push word ptr ss:[di + 6]
E0A5  36 FF 75 04     push word ptr ss:[di + 4]
E0A9  E8 58 F8        call 0xd904
E0AC  08 C0           or al, al
E0AE  75 03           jne 0xe0b3
E0B0  E9 DD 00        jmp 0xe190
loc_E0B3:
E0B3  E8 BD 9D        call 0x7e73
E0B6  E8 05 9E        call 0x7ebe
E0B9  A1 C4 D0        mov ax, word ptr [0xd0c4]
E0BC  86 C4           xchg ah, al
E0BE  A3 86 D0        mov word ptr [0xd086], ax
E0C1  FF 36 86 D0     push word ptr [0xd086]
E0C5  8B 7E 04        mov di, word ptr [bp + 4]
E0C8  36 8B 55 04     mov dx, word ptr ss:[di + 4]
E0CC  36 6B 45 06 3A  imul ax, word ptr ss:[di + 6], 0x3a
E0D1  C4 3E CE D7     les di, ptr [0xd7ce]
E0D5  03 F8           add di, ax
E0D7  03 FA           add di, dx
E0D9  81 C7 C5 FF     add di, 0xffc5
E0DD  06              push es
E0DE  57              push di
E0DF  9A C5 01 2A 23  call far 232A:01C5
E0E4  C6 06 B6 D0 00  mov byte ptr [0xd0b6], 0
E0E9  8B 7E 04        mov di, word ptr [bp + 4]
E0EC  36 FF 75 06     push word ptr ss:[di + 6]
E0F0  36 FF 75 04     push word ptr ss:[di + 4]
E0F4  E8 0D F8        call 0xd904
E0F7  08 C0           or al, al
E0F9  75 03           jne 0xe0fe
E0FB  E9 8D 00        jmp 0xe18b
loc_E0FE:
E0FE  E8 33 A3        call 0x8434
E101  A0 C5 D0        mov al, byte ptr [0xd0c5]
E104  3A 06 C4 D0     cmp al, byte ptr [0xd0c4]
E108  76 32           jbe 0xe13c
E10A  8B 7E 04        mov di, word ptr [bp + 4]
E10D  36 8B 45 04     mov ax, word ptr ss:[di + 4]
E111  8B F0           mov si, ax
E113  D1 E0           shl ax, 1
E115  01 F0           add ax, si
E117  8B D0           mov dx, ax
E119  36 69 45 06 AE 00 imul ax, word ptr ss:[di + 6], 0xae
E11F  C4 3E CA D7     les di, ptr [0xd7ca]
E123  03 F8           add di, ax
E125  03 FA           add di, dx
E127  81 C7 4F FF     add di, 0xff4f
E12B  26 8A 45 02     mov al, byte ptr es:[di + 2]
E12F  24 0F           and al, 0xf
E131  30 E4           xor ah, ah
E133  05 80 00        add ax, 0x80
E136  26 88 45 02     mov byte ptr es:[di + 2], al
E13A  EB 4F           jmp 0xe18b
loc_E13C:
E13C  8B 7E 04        mov di, word ptr [bp + 4]
E13F  36 8B 45 04     mov ax, word ptr ss:[di + 4]
E143  8B F0           mov si, ax
E145  D1 E0           shl ax, 1
E147  01 F0           add ax, si
E149  8B C8           mov cx, ax
E14B  36 8B 45 04     mov ax, word ptr ss:[di + 4]
E14F  8B F0           mov si, ax
E151  D1 E0           shl ax, 1
E153  01 F0           add ax, si
E155  8B D0           mov dx, ax
E157  36 69 45 06 AE 00 imul ax, word ptr ss:[di + 6], 0xae
E15D  C4 3E CA D7     les di, ptr [0xd7ca]
E161  03 F8           add di, ax
E163  03 FA           add di, dx
E165  26 8A 85 50 FF  mov al, byte ptr es:[di - 0xb0]
E16A  30 E4           xor ah, ah
E16C  69 C0 AE 00     imul ax, ax, 0xae
E170  C4 3E CA D7     les di, ptr [0xd7ca]
E174  03 F8           add di, ax
E176  03 F9           add di, cx
E178  81 C7 4F FF     add di, 0xff4f
E17C  26 8A 45 02     mov al, byte ptr es:[di + 2]
E180  24 0F           and al, 0xf
E182  30 E4           xor ah, ah
E184  05 80 00        add ax, 0x80
E187  26 88 45 02     mov byte ptr es:[di + 2], al
loc_E18B:
E18B  9A 2E 02 2A 23  call far 232A:022E
loc_E190:
E190  80 3E 74 D0 00  cmp byte ptr [0xd074], 0
E195  74 02           je 0xe199
E197  EB 55           jmp 0xe1ee
loc_E199:
E199  A0 C5 D0        mov al, byte ptr [0xd0c5]
E19C  3A 06 C4 D0     cmp al, byte ptr [0xd0c4]
E1A0  74 03           je 0xe1a5
E1A2  E8 2F 9B        call 0x7cd4
loc_E1A5:
E1A5  E8 AB 9B        call 0x7d53
E1A8  E8 83 D2        call 0xb42e
E1AB  C6 06 56 DD 01  mov byte ptr [0xdd56], 1
loc_E1B0:
E1B0  BF 12 4B        mov di, 0x4b12
E1B3  1E              push ds
E1B4  57              push di
E1B5  BF 58 DD        mov di, 0xdd58
E1B8  1E              push ds
E1B9  57              push di
E1BA  9A 2F 05 2A 23  call far 232A:052F
E1BF  9A 9B 09 2A 23  call far 232A:099B
E1C4  A0 88 DE        mov al, byte ptr [0xde88]
E1C7  50              push ax
E1C8  9A 86 19 C9 26  call far 26C9:1986
E1CD  3C 50           cmp al, 0x50
E1CF  75 05           jne 0xe1d6
E1D1  E8 A3 23        call 0x10577
E1D4  EB 16           jmp 0xe1ec
loc_E1D6:
E1D6  3C 20           cmp al, 0x20
E1D8  75 05           jne 0xe1df
E1DA  E8 76 29        call 0x10b53
E1DD  EB 0D           jmp 0xe1ec
loc_E1DF:
E1DF  3C 02           cmp al, 2
E1E1  75 07           jne 0xe1ea
E1E3  6A 01           push 1
E1E5  E8 EE F3        call 0xd5d6
E1E8  EB 02           jmp 0xe1ec
loc_E1EA:
E1EA  EB 02           jmp 0xe1ee
loc_E1EC:
E1EC  EB C2           jmp 0xe1b0
loc_E1EE:
E1EE  C9              leave
E1EF  C2 02 00        ret 2

; ---- routine 0AB9:E1F2  (found by: call)
sub_E1F2:
E1F2  C8 0C 00 00     enter 0xc, 0
E1F6  9A BA 00 98 19  call far 1998:00BA
E1FB  8B 46 04        mov ax, word ptr [bp + 4]
E1FE  8B F0           mov si, ax
E200  D1 E0           shl ax, 1
E202  01 F0           add ax, si
E204  8B D0           mov dx, ax
E206  69 46 06 AE 00  imul ax, word ptr [bp + 6], 0xae
E20B  C4 3E CA D7     les di, ptr [0xd7ca]
E20F  03 F8           add di, ax
E211  03 FA           add di, dx
E213  81 C7 4F FF     add di, 0xff4f
E217  8B 46 06        mov ax, word ptr [bp + 6]
E21A  A3 E6 D6        mov word ptr [0xd6e6], ax
E21D  26 8A 45 01     mov al, byte ptr es:[di + 1]
E221  30 E4           xor ah, ah
E223  A3 E4 D6        mov word ptr [0xd6e4], ax
E226  26 8A 45 02     mov al, byte ptr es:[di + 2]
E22A  24 F0           and al, 0xf0
E22C  30 E4           xor ah, ah
E22E  C1 E8 04        shr ax, 4
E231  3D 01 00        cmp ax, 1
E234  B0 00           mov al, 0
E236  75 01           jne 0xe239
E238  40              inc ax
loc_E239:
E239  A2 2A 0D        mov byte ptr [0xd2a], al
E23C  26 8A 45 02     mov al, byte ptr es:[di + 2]
E240  24 0F           and al, 0xf
E242  3C 01           cmp al, 1
E244  B0 00           mov al, 0
E246  75 01           jne 0xe249
E248  40              inc ax
loc_E249:
E249  A2 29 0D        mov byte ptr [0xd29], al
E24C  E8 7B 37        call 0x119ca
E24F  31 C0           xor ax, ax
E251  A3 C4 D0        mov word ptr [0xd0c4], ax
E254  C7 06 C6 D0 FF FF mov word ptr [0xd0c6], 0xffff
E25A  E8 7D A6        call 0x88da
E25D  BF 48 D1        mov di, 0xd148
E260  1E              push ds
E261  57              push di
E262  6A 28           push 0x28
E264  6A 37           push 0x37
E266  9A 6C 02 2A 23  call far 232A:026C
E26B  BF 98 D1        mov di, 0xd198
E26E  1E              push ds
E26F  57              push di
E270  6A 28           push 0x28
E272  6A 00           push 0
E274  9A 22 02 BC 24  call far 24BC:0222
E279  C6 46 FF 00     mov byte ptr [bp - 1], 0
E27D  EB 03           jmp 0xe282
loc_E27F:
E27F  FE 46 FF        inc byte ptr [bp - 1]
loc_E282:
E282  8A 46 FF        mov al, byte ptr [bp - 1]
E285  98              cwde
E286  8B F8           mov di, ax
E288  D1 E7           shl di, 1
E28A  FF B5 E4 D6     push word ptr [di - 0x291c]
E28E  9A 7A 0E 55 1B  call far 1B55:0E7A
E293  08 C0           or al, al
E295  75 25           jne 0xe2bc
E297  8A 46 FF        mov al, byte ptr [bp - 1]
E29A  98              cwde
E29B  8B F8           mov di, ax
E29D  D1 E7           shl di, 1
E29F  FF B5 E4 D6     push word ptr [di - 0x291c]
E2A3  E8 06 BA        call 0x9cac
E2A6  8A 46 FF        mov al, byte ptr [bp - 1]
E2A9  98              cwde
E2AA  8B F8           mov di, ax
E2AC  D1 E7           shl di, 1
E2AE  FF B5 E4 D6     push word ptr [di - 0x291c]
E2B2  E8 3E BC        call 0x9ef3
E2B5  8A 46 FF        mov al, byte ptr [bp - 1]
E2B8  50              push ax
E2B9  E8 80 BF        call 0xa23c
loc_E2BC:
E2BC  80 7E FF 01     cmp byte ptr [bp - 1], 1
E2C0  75 BD           jne 0xe27f
E2C2  31 C0           xor ax, ax
E2C4  A3 42 D1        mov word ptr [0xd142], ax
E2C7  31 C0           xor ax, ax
E2C9  A3 CC D0        mov word ptr [0xd0cc], ax
E2CC  31 C0           xor ax, ax
E2CE  A3 CE D0        mov word ptr [0xd0ce], ax
E2D1  E8 15 A4        call 0x86e9
E2D4  9A 4E 28 55 1B  call far 1B55:284E
E2D9  E8 65 F7        call 0xda41
E2DC  C6 06 91 0D 01  mov byte ptr [0xd91], 1
E2E1  BF 5E CF        mov di, 0xcf5e
E2E4  1E              push ds
E2E5  57              push di
E2E6  6A 14           push 0x14
E2E8  6A 00           push 0
E2EA  9A 22 02 BC 24  call far 24BC:0222
E2EF  C6 06 CC D1 00  mov byte ptr [0xd1cc], 0
E2F4  C6 06 74 D0 00  mov byte ptr [0xd074], 0
E2F9  C6 06 75 D0 00  mov byte ptr [0xd075], 0
E2FE  6A 01           push 1
E300  E8 D3 F2        call 0xd5d6
E303  C4 3E 92 D0     les di, ptr [0xd092]
E307  06              push es
E308  57              push di
E309  C4 3E 8A D0     les di, ptr [0xd08a]
E30D  06              push es
E30E  57              push di
E30F  68 A0 0F        push 0xfa0
E312  9A 12 0A C9 26  call far 26C9:0A12
E317  C4 3E 92 D0     les di, ptr [0xd092]
E31B  06              push es
E31C  57              push di
E31D  C4 3E 96 D0     les di, ptr [0xd096]
E321  06              push es
E322  57              push di
E323  68 A0 0F        push 0xfa0
E326  9A 12 0A C9 26  call far 26C9:0A12
E32B  C6 46 FF 00     mov byte ptr [bp - 1], 0
E32F  EB 03           jmp 0xe334
loc_E331:
E331  FE 46 FF        inc byte ptr [bp - 1]
loc_E334:
E334  C7 46 FC 01 00  mov word ptr [bp - 4], 1
E339  EB 03           jmp 0xe33e
loc_E33B:
E33B  FF 46 FC        inc word ptr [bp - 4]
loc_E33E:
E33E  8A 46 FF        mov al, byte ptr [bp - 1]
E341  98              cwde
E342  8B F8           mov di, ax
E344  D1 E7           shl di, 1
E346  6B 85 E4 D6 3E  imul ax, word ptr [di - 0x291c], 0x3e
E34B  C4 3E C2 D7     les di, ptr [0xd7c2]
E34F  03 F8           add di, ax
E351  81 C7 C2 FF     add di, 0xffc2
E355  89 7E F6        mov word ptr [bp - 0xa], di
E358  8C 46 F8        mov word ptr [bp - 8], es
E35B  8B 46 FC        mov ax, word ptr [bp - 4]
E35E  D1 E0           shl ax, 1
E360  03 F8           add di, ax
E362  26 83 7D FE 00  cmp word ptr es:[di - 2], 0
E367  74 29           je 0xe392
E369  8B 46 FC        mov ax, word ptr [bp - 4]
E36C  D1 E0           shl ax, 1
E36E  C4 7E F6        les di, ptr [bp - 0xa]
E371  03 F8           add di, ax
E373  26 6B 45 FE 0F  imul ax, word ptr es:[di - 2], 0xf
E378  C4 3E BE D7     les di, ptr [0xd7be]
E37C  03 F8           add di, ax
E37E  26 8A 4D 06     mov cl, byte ptr es:[di + 6]
E382  8B 56 FC        mov dx, word ptr [bp - 4]
E385  8A 46 FF        mov al, byte ptr [bp - 1]
E388  98              cwde
E389  6B F8 14        imul di, ax, 0x14
E38C  03 FA           add di, dx
E38E  88 8D 97 D1     mov byte ptr [di - 0x2e69], cl
loc_E392:
E392  83 7E FC 14     cmp word ptr [bp - 4], 0x14
E396  75 A3           jne 0xe33b
E398  8A 46 FF        mov al, byte ptr [bp - 1]
E39B  98              cwde
E39C  8B F8           mov di, ax
E39E  8A 85 E0 D6     mov al, byte ptr [di - 0x2920]
E3A2  30 E4           xor ah, ah
E3A4  89 46 FA        mov word ptr [bp - 6], ax
E3A7  8A 46 FF        mov al, byte ptr [bp - 1]
E3AA  98              cwde
E3AB  8B F8           mov di, ax
E3AD  D1 E7           shl di, 1
E3AF  6B 85 E4 D6 3E  imul ax, word ptr [di - 0x291c], 0x3e
E3B4  C4 3E C2 D7     les di, ptr [0xd7c2]
E3B8  03 F8           add di, ax
E3BA  81 C7 C2 FF     add di, 0xffc2
E3BE  89 7E F6        mov word ptr [bp - 0xa], di
E3C1  8C 46 F8        mov word ptr [bp - 8], es
E3C4  8B 46 FA        mov ax, word ptr [bp - 6]
E3C7  05 0C 00        add ax, 0xc
E3CA  48              dec ax
E3CB  89 46 F4        mov word ptr [bp - 0xc], ax
E3CE  B8 0C 00        mov ax, 0xc
E3D1  3B 46 F4        cmp ax, word ptr [bp - 0xc]
E3D4  77 3E           ja 0xe414
E3D6  89 46 FC        mov word ptr [bp - 4], ax
E3D9  EB 03           jmp 0xe3de
loc_E3DB:
E3DB  FF 46 FC        inc word ptr [bp - 4]
loc_E3DE:
E3DE  8A 46 FF        mov al, byte ptr [bp - 1]
E3E1  98              cwde
E3E2  8B F8           mov di, ax
E3E4  80 BD E0 D6 00  cmp byte ptr [di - 0x2920], 0
E3E9  76 21           jbe 0xe40c
E3EB  8B 46 FC        mov ax, word ptr [bp - 4]
E3EE  D1 E0           shl ax, 1
E3F0  C4 7E F6        les di, ptr [bp - 0xa]
E3F3  03 F8           add di, ax
E3F5  26 FF 75 FE     push word ptr es:[di - 2]
E3F9  9A 89 4F 55 1B  call far 1B55:4F89
E3FE  08 C0           or al, al
E400  74 0A           je 0xe40c
E402  8A 46 FF        mov al, byte ptr [bp - 1]
E405  98              cwde
E406  8B F8           mov di, ax
E408  FE 8D E0 D6     dec byte ptr [di - 0x2920]
loc_E40C:
E40C  8B 46 FC        mov ax, word ptr [bp - 4]
E40F  3B 46 F4        cmp ax, word ptr [bp - 0xc]
E412  75 C7           jne 0xe3db
loc_E414:
E414  80 7E FF 01     cmp byte ptr [bp - 1], 1
E418  74 03           je 0xe41d
E41A  E9 14 FF        jmp 0xe331
loc_E41D:
E41D  C4 3E D2 D7     les di, ptr [0xd7d2]
E421  26 80 BD F2 00 00 cmp byte ptr es:[di + 0xf2], 0
E427  75 08           jne 0xe431
E429  C6 06 B8 D0 01  mov byte ptr [0xd0b8], 1
E42E  E8 37 F7        call 0xdb68
loc_E431:
E431  55              push bp
E432  E8 D3 FB        call 0xe008
E435  C4 3E 8A D0     les di, ptr [0xd08a]
E439  06              push es
E43A  57              push di
E43B  C4 3E 96 D0     les di, ptr [0xd096]
E43F  06              push es
E440  57              push di
E441  68 A0 0F        push 0xfa0
E444  9A 12 0A C9 26  call far 26C9:0A12
E449  A0 84 D0        mov al, byte ptr [0xd084]
E44C  30 E4           xor ah, ah
E44E  3B 46 06        cmp ax, word ptr [bp + 6]
E451  B0 00           mov al, 0
E453  74 01           je 0xe456
E455  40              inc ax
loc_E456:
E456  50              push ax
E457  6A 00           push 0
E459  9A 5C 04 98 19  call far 1998:045C
E45E  E8 0F D1        call 0xb570
E461  9A 7A 0C 98 19  call far 1998:0C7A
E466  C6 06 18 0D 00  mov byte ptr [0xd18], 0
E46B  C6 06 91 0D 00  mov byte ptr [0xd91], 0
E470  9A CD 00 98 19  call far 1998:00CD
E475  C9              leave
E476  C2 04 00        ret 4

; ---- routine 0AB9:E479  (found by: call)
sub_E479:
E479  C8 06 00 00     enter 6, 0
E47D  8B 46 04        mov ax, word ptr [bp + 4]
E480  8B F0           mov si, ax
E482  D1 E0           shl ax, 1
E484  01 F0           add ax, si
E486  8B D0           mov dx, ax
E488  69 46 06 AE 00  imul ax, word ptr [bp + 6], 0xae
E48D  C4 3E CA D7     les di, ptr [0xd7ca]
E491  03 F8           add di, ax
E493  03 FA           add di, dx
E495  81 C7 4F FF     add di, 0xff4f
E499  26 80 7D 01 00  cmp byte ptr es:[di + 1], 0
E49E  74 1A           je 0xe4ba
E4A0  26 8A 45 02     mov al, byte ptr es:[di + 2]
E4A4  24 0F           and al, 0xf
E4A6  08 C0           or al, al
E4A8  74 10           je 0xe4ba
E4AA  26 8A 45 02     mov al, byte ptr es:[di + 2]
E4AE  24 F0           and al, 0xf0
E4B0  30 E4           xor ah, ah
E4B2  C1 E8 04        shr ax, 4
E4B5  3D 01 00        cmp ax, 1
E4B8  7E 04           jle 0xe4be
loc_E4BA:
E4BA  B0 00           mov al, 0
E4BC  EB 02           jmp 0xe4c0
loc_E4BE:
E4BE  B0 01           mov al, 1
loc_E4C0:
E4C0  88 46 FF        mov byte ptr [bp - 1], al
E4C3  8A 46 FF        mov al, byte ptr [bp - 1]
E4C6  C9              leave
E4C7  C2 04 00        ret 4

; ---- routine 0AB9:E4CA  (found by: call)
sub_E4CA:
E4CA  C8 04 00 00     enter 4, 0
E4CE  C4 7E 06        les di, ptr [bp + 6]
E4D1  89 7E FC        mov word ptr [bp - 4], di
E4D4  8C 46 FE        mov word ptr [bp - 2], es
E4D7  FF 36 86 D0     push word ptr [0xd086]
E4DB  81 C7 02 00     add di, 2
E4DF  06              push es
E4E0  57              push di
E4E1  9A C5 01 2A 23  call far 232A:01C5
E4E6  8B 7E 04        mov di, word ptr [bp + 4]
E4E9  36 8B 7D 04     mov di, word ptr ss:[di + 4]
E4ED  36 8B 45 06     mov ax, word ptr ss:[di + 6]
E4F1  8B F0           mov si, ax
E4F3  D1 E0           shl ax, 1
E4F5  01 F0           add ax, si
E4F7  8B D0           mov dx, ax
E4F9  8B 7E 04        mov di, word ptr [bp + 4]
E4FC  36 69 45 06 AE 00 imul ax, word ptr ss:[di + 6], 0xae
E502  C4 3E CA D7     les di, ptr [0xd7ca]
E506  03 F8           add di, ax
E508  03 FA           add di, dx
E50A  26 8A 85 50 FF  mov al, byte ptr es:[di - 0xb0]
E50F  C4 7E FC        les di, ptr [bp - 4]
E512  26 88 05        mov byte ptr es:[di], al
E515  26 8A 05        mov al, byte ptr es:[di]
E518  30 E4           xor ah, ah
E51A  6B C0 3E        imul ax, ax, 0x3e
E51D  C4 3E C2 D7     les di, ptr [0xd7c2]
E521  03 F8           add di, ax
E523  26 8A 45 F9     mov al, byte ptr es:[di - 7]
E527  C4 7E FC        les di, ptr [bp - 4]
E52A  26 88 45 01     mov byte ptr es:[di + 1], al
E52E  C9              leave
E52F  C2 06 00        ret 6

; ---- routine 0AB9:E532  (found by: call)
sub_E532:
E532  C8 04 00 00     enter 4, 0
E536  80 3E DD D6 00  cmp byte ptr [0xd6dd], 0
E53B  75 03           jne 0xe540
E53D  E9 AB 00        jmp 0xe5eb
loc_E540:
E540  A0 87 D0        mov al, byte ptr [0xd087]
E543  30 E4           xor ah, ah
E545  8B D0           mov dx, ax
E547  A0 86 D0        mov al, byte ptr [0xd086]
E54A  30 E4           xor ah, ah
E54C  2B C2           sub ax, dx
E54E  88 46 FF        mov byte ptr [bp - 1], al
E551  6B 46 06 2E     imul ax, word ptr [bp + 6], 0x2e
E555  C4 3E C0 DC     les di, ptr [0xdcc0]
E559  03 F8           add di, ax
E55B  26 8A 45 E8     mov al, byte ptr es:[di - 0x18]
E55F  50              push ax
E560  8D 7E FC        lea di, [bp - 4]
E563  16              push ss
E564  57              push di
E565  9A E3 01 2A 23  call far 232A:01E3
E56A  8A 46 FD        mov al, byte ptr [bp - 3]
E56D  30 E4           xor ah, ah
E56F  8B D0           mov dx, ax
E571  8A 46 FC        mov al, byte ptr [bp - 4]
E574  30 E4           xor ah, ah
E576  2B C2           sub ax, dx
E578  88 46 FE        mov byte ptr [bp - 2], al
E57B  8A 46 FF        mov al, byte ptr [bp - 1]
E57E  3A 46 FE        cmp al, byte ptr [bp - 2]
E581  7E 1C           jle 0xe59f
E583  80 7E FF 00     cmp byte ptr [bp - 1], 0
E587  7E 16           jle 0xe59f
E589  6B 46 06 2E     imul ax, word ptr [bp + 6], 0x2e
E58D  C4 3E C0 DC     les di, ptr [0xdcc0]
E591  03 F8           add di, ax
E593  81 C7 E6 FF     add di, 0xffe6
E597  06              push es
E598  57              push di
E599  55              push bp
E59A  E8 2D FF        call 0xe4ca
E59D  EB 4C           jmp 0xe5eb
loc_E59F:
E59F  6B 46 06 2E     imul ax, word ptr [bp + 6], 0x2e
E5A3  C4 3E C0 DC     les di, ptr [0xdcc0]
E5A7  03 F8           add di, ax
E5A9  26 8A 45 EC     mov al, byte ptr es:[di - 0x14]
E5AD  50              push ax
E5AE  8D 7E FC        lea di, [bp - 4]
E5B1  16              push ss
E5B2  57              push di
E5B3  9A E3 01 2A 23  call far 232A:01E3
E5B8  8A 46 FD        mov al, byte ptr [bp - 3]
E5BB  30 E4           xor ah, ah
E5BD  8B D0           mov dx, ax
E5BF  8A 46 FC        mov al, byte ptr [bp - 4]
E5C2  30 E4           xor ah, ah
E5C4  2B C2           sub ax, dx
E5C6  88 46 FE        mov byte ptr [bp - 2], al
E5C9  8A 46 FF        mov al, byte ptr [bp - 1]
E5CC  3A 46 FE        cmp al, byte ptr [bp - 2]
E5CF  7D 1A           jge 0xe5eb
E5D1  80 7E FF 00     cmp byte ptr [bp - 1], 0
E5D5  7D 14           jge 0xe5eb
E5D7  6B 46 06 2E     imul ax, word ptr [bp + 6], 0x2e
E5DB  C4 3E C0 DC     les di, ptr [0xdcc0]
E5DF  03 F8           add di, ax
E5E1  81 C7 EA FF     add di, 0xffea
E5E5  06              push es
E5E6  57              push di
E5E7  55              push bp
E5E8  E8 DF FE        call 0xe4ca
loc_E5EB:
E5EB  C9              leave
E5EC  C2 04 00        ret 4

; ---- routine 0AB9:E5EF  (found by: call)
sub_E5EF:
E5EF  C8 04 00 00     enter 4, 0
E5F3  8B 7E 04        mov di, word ptr [bp + 4]
E5F6  36 8B 45 06     mov ax, word ptr ss:[di + 6]
E5FA  8B F0           mov si, ax
E5FC  D1 E0           shl ax, 1
E5FE  01 F0           add ax, si
E600  8B D0           mov dx, ax
E602  36 8B 7D FE     mov di, word ptr ss:[di - 2]
E606  8A 85 FB D4     mov al, byte ptr [di - 0x2b05]
E60A  30 E4           xor ah, ah
E60C  69 C0 AE 00     imul ax, ax, 0xae
E610  C4 3E CA D7     les di, ptr [0xd7ca]
E614  03 F8           add di, ax
E616  03 FA           add di, dx
E618  81 C7 4F FF     add di, 0xff4f
E61C  89 7E FC        mov word ptr [bp - 4], di
E61F  8C 46 FE        mov word ptr [bp - 2], es
E622  26 80 3D 01     cmp byte ptr es:[di], 1
E626  74 0C           je 0xe634
E628  26 80 3D 02     cmp byte ptr es:[di], 2
E62C  74 06           je 0xe634
E62E  26 80 3D 09     cmp byte ptr es:[di], 9
E632  75 04           jne 0xe638
loc_E634:
E634  B0 00           mov al, 0
E636  EB 02           jmp 0xe63a
loc_E638:
E638  B0 01           mov al, 1
loc_E63A:
E63A  A2 DD D6        mov byte ptr [0xd6dd], al
E63D  31 C0           xor ax, ax
E63F  A3 86 D0        mov word ptr [0xd086], ax
E642  8A 46 06        mov al, byte ptr [bp + 6]
E645  8B 7E 04        mov di, word ptr [bp + 4]
E648  36 88 45 F9     mov byte ptr ss:[di - 7], al
E64C  36 8B 7D FE     mov di, word ptr ss:[di - 2]
E650  8A 85 FB D4     mov al, byte ptr [di - 0x2b05]
E654  30 E4           xor ah, ah
E656  A3 E6 D6        mov word ptr [0xd6e6], ax
E659  C4 7E FC        les di, ptr [bp - 4]
E65C  26 8A 45 01     mov al, byte ptr es:[di + 1]
E660  30 E4           xor ah, ah
E662  A3 E4 D6        mov word ptr [0xd6e4], ax
E665  26 8A 45 02     mov al, byte ptr es:[di + 2]
E669  24 0F           and al, 0xf
E66B  3C 01           cmp al, 1
E66D  B0 00           mov al, 0
E66F  75 01           jne 0xe672
E671  40              inc ax
loc_E672:
E672  A2 29 0D        mov byte ptr [0xd29], al
E675  C9              leave
E676  C2 04 00        ret 4

; ---- routine 0AB9:E679  (found by: call)
sub_E679:
E679  C8 08 00 00     enter 8, 0
E67D  8B 7E 04        mov di, word ptr [bp + 4]
E680  36 8B 45 06     mov ax, word ptr ss:[di + 6]
E684  8B F0           mov si, ax
E686  D1 E0           shl ax, 1
E688  01 F0           add ax, si
E68A  8B D0           mov dx, ax
E68C  36 8B 7D FE     mov di, word ptr ss:[di - 2]
E690  8A 85 FB D4     mov al, byte ptr [di - 0x2b05]
E694  30 E4           xor ah, ah
E696  69 C0 AE 00     imul ax, ax, 0xae
E69A  C4 3E CA D7     les di, ptr [0xd7ca]
E69E  03 F8           add di, ax
E6A0  03 FA           add di, dx
E6A2  81 C7 4F FF     add di, 0xff4f
E6A6  89 7E FC        mov word ptr [bp - 4], di
E6A9  8C 46 FE        mov word ptr [bp - 2], es
E6AC  FF 36 86 D0     push word ptr [0xd086]
E6B0  8B 7E 04        mov di, word ptr [bp + 4]
E6B3  36 8B 55 06     mov dx, word ptr ss:[di + 6]
E6B7  36 8B 7D FE     mov di, word ptr ss:[di - 2]
E6BB  8A 85 FB D4     mov al, byte ptr [di - 0x2b05]
E6BF  30 E4           xor ah, ah
E6C1  6B C0 3A        imul ax, ax, 0x3a
E6C4  C4 3E CE D7     les di, ptr [0xd7ce]
E6C8  03 F8           add di, ax
E6CA  03 FA           add di, dx
E6CC  81 C7 C5 FF     add di, 0xffc5
E6D0  06              push es
E6D1  57              push di
E6D2  9A C5 01 2A 23  call far 232A:01C5
E6D7  C4 7E FC        les di, ptr [bp - 4]
E6DA  26 8A 45 02     mov al, byte ptr es:[di + 2]
E6DE  24 F0           and al, 0xf0
E6E0  30 E4           xor ah, ah
E6E2  C1 E8 04        shr ax, 4
E6E5  3D 08 00        cmp ax, 8
E6E8  74 0F           je 0xe6f9
E6EA  26 8A 45 02     mov al, byte ptr es:[di + 2]
E6EE  24 0F           and al, 0xf
E6F0  30 E4           xor ah, ah
E6F2  05 40 00        add ax, 0x40
E6F5  26 88 45 02     mov byte ptr es:[di + 2], al
loc_E6F9:
E6F9  8B 7E 04        mov di, word ptr [bp + 4]
E6FC  36 8B 45 06     mov ax, word ptr ss:[di + 6]
E700  8B F0           mov si, ax
E702  D1 E0           shl ax, 1
E704  01 F0           add ax, si
E706  8B D0           mov dx, ax
E708  C4 7E FC        les di, ptr [bp - 4]
E70B  26 8A 45 01     mov al, byte ptr es:[di + 1]
E70F  30 E4           xor ah, ah
E711  69 C0 AE 00     imul ax, ax, 0xae
E715  C4 3E CA D7     les di, ptr [0xd7ca]
E719  03 F8           add di, ax
E71B  03 FA           add di, dx
E71D  81 C7 4F FF     add di, 0xff4f
E721  26 8A 45 02     mov al, byte ptr es:[di + 2]
E725  24 F0           and al, 0xf0
E727  30 E4           xor ah, ah
E729  C1 E8 04        shr ax, 4
E72C  3D 08 00        cmp ax, 8
E72F  74 0F           je 0xe740
E731  26 8A 45 02     mov al, byte ptr es:[di + 2]
E735  24 0F           and al, 0xf
E737  30 E4           xor ah, ah
E739  05 40 00        add ax, 0x40
E73C  26 88 45 02     mov byte ptr es:[di + 2], al
loc_E740:
E740  8B 7E 04        mov di, word ptr [bp + 4]
E743  36 8B 7D FE     mov di, word ptr ss:[di - 2]
E747  8A 85 FB D4     mov al, byte ptr [di - 0x2b05]
E74B  30 E4           xor ah, ah
E74D  50              push ax
E74E  8B 7E 04        mov di, word ptr [bp + 4]
E751  57              push di
E752  E8 DD FD        call 0xe532
E755  8B 7E 04        mov di, word ptr [bp + 4]
E758  36 8B 7D FE     mov di, word ptr ss:[di - 2]
E75C  8A 85 FB D4     mov al, byte ptr [di - 0x2b05]
E760  30 E4           xor ah, ah
E762  50              push ax
E763  C4 7E FC        les di, ptr [bp - 4]
E766  26 8A 45 01     mov al, byte ptr es:[di + 1]
E76A  30 E4           xor ah, ah
E76C  50              push ax
E76D  9A 26 11 98 19  call far 1998:1126
E772  BF 86 D0        mov di, 0xd086
E775  1E              push ds
E776  57              push di
E777  BF 87 D0        mov di, 0xd087
E77A  1E              push ds
E77B  57              push di
E77C  6A 01           push 1
E77E  9A 03 02 BC 24  call far 24BC:0203
E783  FF 36 86 D0     push word ptr [0xd086]
E787  8B 7E 04        mov di, word ptr [bp + 4]
E78A  36 8B 55 06     mov dx, word ptr ss:[di + 6]
E78E  C4 7E FC        les di, ptr [bp - 4]
E791  26 8A 45 01     mov al, byte ptr es:[di + 1]
E795  30 E4           xor ah, ah
E797  6B C0 3A        imul ax, ax, 0x3a
E79A  C4 3E CE D7     les di, ptr [0xd7ce]
E79E  03 F8           add di, ax
E7A0  03 FA           add di, dx
E7A2  81 C7 C5 FF     add di, 0xffc5
E7A6  06              push es
E7A7  57              push di
E7A8  9A C5 01 2A 23  call far 232A:01C5
E7AD  C4 7E FC        les di, ptr [bp - 4]
E7B0  26 8A 45 01     mov al, byte ptr es:[di + 1]
E7B4  30 E4           xor ah, ah
E7B6  50              push ax
E7B7  8B 7E 04        mov di, word ptr [bp + 4]
E7BA  57              push di
E7BB  E8 74 FD        call 0xe532
E7BE  8B 7E 04        mov di, word ptr [bp + 4]
E7C1  36 80 7D F9 00  cmp byte ptr ss:[di - 7], 0
E7C6  74 08           je 0xe7d0
E7C8  36 C7 45 FA FF FF mov word ptr ss:[di - 6], 0xffff
E7CE  EB 0A           jmp 0xe7da
loc_E7D0:
E7D0  A1 86 D0        mov ax, word ptr [0xd086]
E7D3  8B 7E 04        mov di, word ptr [bp + 4]
E7D6  36 89 45 FA     mov word ptr ss:[di - 6], ax
loc_E7DA:
E7DA  8B 7E 04        mov di, word ptr [bp + 4]
E7DD  36 8B 7D FE     mov di, word ptr ss:[di - 2]
E7E1  8A 85 FB D4     mov al, byte ptr [di - 0x2b05]
E7E5  30 E4           xor ah, ah
E7E7  50              push ax
E7E8  8B 7E 04        mov di, word ptr [bp + 4]
E7EB  36 8A 45 FB     mov al, byte ptr ss:[di - 5]
E7EF  30 E4           xor ah, ah
E7F1  50              push ax
E7F2  36 8A 45 FA     mov al, byte ptr ss:[di - 6]
E7F6  30 E4           xor ah, ah
E7F8  50              push ax
E7F9  9A 97 18 98 19  call far 1998:1897
E7FE  C4 7E FC        les di, ptr [bp - 4]
E801  26 8A 45 01     mov al, byte ptr es:[di + 1]
E805  30 E4           xor ah, ah
E807  50              push ax
E808  8B 7E 04        mov di, word ptr [bp + 4]
E80B  36 8A 45 FA     mov al, byte ptr ss:[di - 6]
E80F  30 E4           xor ah, ah
E811  50              push ax
E812  36 8A 45 FB     mov al, byte ptr ss:[di - 5]
E816  30 E4           xor ah, ah
E818  50              push ax
E819  9A 97 18 98 19  call far 1998:1897
E81E  C4 7E FC        les di, ptr [bp - 4]
E821  26 80 3D 00     cmp byte ptr es:[di], 0
E825  75 1C           jne 0xe843
E827  8B 7E 04        mov di, word ptr [bp + 4]
E82A  36 8B 7D FE     mov di, word ptr ss:[di - 2]
E82E  8A 85 FB D4     mov al, byte ptr [di - 0x2b05]
E832  30 E4           xor ah, ah
E834  50              push ax
E835  8B 7E 04        mov di, word ptr [bp + 4]
E838  36 FF 75 06     push word ptr ss:[di + 6]
E83C  9A 01 23 55 1B  call far 1B55:2301
E841  EB 33           jmp 0xe876
loc_E843:
E843  C4 7E FC        les di, ptr [bp - 4]
E846  26 80 3D 06     cmp byte ptr es:[di], 6
E84A  75 2A           jne 0xe876
E84C  8B 7E 04        mov di, word ptr [bp + 4]
E84F  36 FF 75 06     push word ptr ss:[di + 6]
E853  9A 98 17 55 1B  call far 1B55:1798
E858  08 C0           or al, al
E85A  74 1A           je 0xe876
E85C  8B 7E 04        mov di, word ptr [bp + 4]
E85F  36 8B 7D FE     mov di, word ptr ss:[di - 2]
E863  8A 85 FB D4     mov al, byte ptr [di - 0x2b05]
E867  30 E4           xor ah, ah
E869  50              push ax
E86A  8B 7E 04        mov di, word ptr [bp + 4]
E86D  36 FF 75 06     push word ptr ss:[di + 6]
E871  9A C3 24 55 1B  call far 1B55:24C3
loc_E876:
E876  C9              leave
E877  C2 02 00        ret 2

