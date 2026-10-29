; 1-095.EXE (One-Nil 95), code segment 0AB5 (image offsets 0AB50..1993F), part 21 of 22
; packed 1-095.EXE sha256 f659fb2d334500d6901fc8d6a0f06c85c0ccda2eb4a3035ae3bb0a0004d79192 (LZEXE 0.91)
; unpacked (tools/static/unlzexe.py) sha256 8df646e017e0965a5d90a58181ca764219ad847833aad0b6cb58fc53372bfb2c
; tool: capstone 5.0.9 (pip package; core library 5.0.1280) (CS_ARCH_X86, CS_MODE_16), recursive descent from the entry point, far calls and near calls/jumps, then routine prologues (55 89 E5 / 55 8B EC / C8 iw 00) in what remains; tools/static/listing.py
; addresses are SEGMENT:OFFSET with SEGMENT the image paragraph before relocation; image offset = SEGMENT*16+OFFSET
; ---- routine 0AB5:DCFC  (found by: call)
sub_DCFC:
DCFC  C8 2E 00 00     enter 0x2e, 0
DD00  C4 3E 58 DD     les di, ptr [0xdd58]
DD04  06              push es
DD05  57              push di
DD06  C4 3E 60 DD     les di, ptr [0xdd60]
DD0A  06              push es
DD0B  57              push di
DD0C  68 A0 0F        push 0xfa0
DD0F  9A 12 0A B9 26  call far 26B9:0A12
DD14  C6 06 B8 D0 01  mov byte ptr [0xd0b8], 1
DD19  C6 46 DA 00     mov byte ptr [bp - 0x26], 0
DD1D  31 C0           xor ax, ax
DD1F  A3 B0 D0        mov word ptr [0xd0b0], ax
DD22  A1 C4 D0        mov ax, word ptr [0xd0c4]
DD25  86 C4           xchg ah, al
DD27  89 46 FC        mov word ptr [bp - 4], ax
DD2A  8D 7E E6        lea di, [bp - 0x1a]
DD2D  16              push ss
DD2E  57              push di
DD2F  6A 16           push 0x16
DD31  6A 00           push 0
DD33  9A 22 02 AC 24  call far 24AC:0222
DD38  8B 46 FC        mov ax, word ptr [bp - 4]
DD3B  89 46 FE        mov word ptr [bp - 2], ax
DD3E  31 C0           xor ax, ax
DD40  A3 86 D0        mov word ptr [0xd086], ax
DD43  FF 36 E6 D6     push word ptr [0xd6e6]
DD47  6A 00           push 0
DD49  A0 29 0D        mov al, byte ptr [0xd29]
DD4C  50              push ax
DD4D  9A 4B 50 51 1B  call far 1B51:504B
DD52  FF 36 E4 D6     push word ptr [0xd6e4]
DD56  6A 01           push 1
DD58  6A 00           push 0
DD5A  9A 4B 50 51 1B  call far 1B51:504B
DD5F  80 3E AC D0 0F  cmp byte ptr [0xd0ac], 0xf
DD64  B0 00           mov al, 0
DD66  75 01           jne 0xdd69
DD68  40              inc ax
loc_DD69:
DD69  98              cwde
DD6A  8B F8           mov di, ax
DD6C  8A 85 FE 0C     mov al, byte ptr [di + 0xcfe]
DD70  30 E4           xor ah, ah
DD72  50              push ax
DD73  E8 07 FC        call 0xd97d
DD76  C7 46 DE 01 00  mov word ptr [bp - 0x22], 1
DD7B  EB 03           jmp 0xdd80
loc_DD7D:
DD7D  FF 46 DE        inc word ptr [bp - 0x22]
loc_DD80:
DD80  8B 7E DE        mov di, word ptr [bp - 0x22]
DD83  8A 85 85 D0     mov al, byte ptr [di - 0x2f7b]
DD87  8B 7E DE        mov di, word ptr [bp - 0x22]
DD8A  3A 43 FD        cmp al, byte ptr [bp + di - 3]
DD8D  77 03           ja 0xdd92
DD8F  E9 94 01        jmp 0xdf26
loc_DD92:
DD92  8B 7E DE        mov di, word ptr [bp - 0x22]
DD95  8A 43 FD        mov al, byte ptr [bp + di - 3]
DD98  8B 7E DE        mov di, word ptr [bp - 0x22]
DD9B  28 85 85 D0     sub byte ptr [di - 0x2f7b], al
DD9F  C7 46 E4 01 00  mov word ptr [bp - 0x1c], 1
DDA4  EB 03           jmp 0xdda9
loc_DDA6:
DDA6  FF 46 E4        inc word ptr [bp - 0x1c]
loc_DDA9:
DDA9  8B 7E E4        mov di, word ptr [bp - 0x1c]
DDAC  8A 85 85 D0     mov al, byte ptr [di - 0x2f7b]
DDB0  30 E4           xor ah, ah
DDB2  89 46 D8        mov word ptr [bp - 0x28], ax
DDB5  B8 01 00        mov ax, 1
DDB8  3B 46 D8        cmp ax, word ptr [bp - 0x28]
DDBB  77 37           ja 0xddf4
DDBD  89 46 E2        mov word ptr [bp - 0x1e], ax
DDC0  EB 03           jmp 0xddc5
loc_DDC2:
DDC2  FF 46 E2        inc word ptr [bp - 0x1e]
loc_DDC5:
DDC5  80 3E AC D0 0F  cmp byte ptr [0xd0ac], 0xf
DDCA  B0 00           mov al, 0
DDCC  75 01           jne 0xddcf
DDCE  40              inc ax
loc_DDCF:
DDCF  98              cwde
DDD0  8B F8           mov di, ax
DDD2  8A 85 00 0D     mov al, byte ptr [di + 0xd00]
DDD6  30 E4           xor ah, ah
DDD8  50              push ax
DDD9  9A 6D 07 1A 23  call far 231A:076D
DDDE  8A D0           mov dl, al
DDE0  8B 46 E2        mov ax, word ptr [bp - 0x1e]
DDE3  6B 7E E4 0B     imul di, word ptr [bp - 0x1c], 0xb
DDE7  03 F8           add di, ax
DDE9  88 53 DA        mov byte ptr [bp + di - 0x26], dl
DDEC  8B 46 E2        mov ax, word ptr [bp - 0x1e]
DDEF  3B 46 D8        cmp ax, word ptr [bp - 0x28]
DDF2  75 CE           jne 0xddc2
loc_DDF4:
DDF4  83 7E E4 02     cmp word ptr [bp - 0x1c], 2
DDF8  75 AC           jne 0xdda6
DDFA  C7 46 E4 01 00  mov word ptr [bp - 0x1c], 1
DDFF  EB 03           jmp 0xde04
loc_DE01:
DE01  FF 46 E4        inc word ptr [bp - 0x1c]
loc_DE04:
DE04  8B 7E E4        mov di, word ptr [bp - 0x1c]
DE07  8A 85 85 D0     mov al, byte ptr [di - 0x2f7b]
DE0B  30 E4           xor ah, ah
DE0D  89 46 D8        mov word ptr [bp - 0x28], ax
DE10  B8 01 00        mov ax, 1
DE13  3B 46 D8        cmp ax, word ptr [bp - 0x28]
DE16  76 03           jbe 0xde1b
DE18  E9 02 01        jmp 0xdf1d
loc_DE1B:
DE1B  89 46 E2        mov word ptr [bp - 0x1e], ax
DE1E  EB 03           jmp 0xde23
loc_DE20:
DE20  FF 46 E2        inc word ptr [bp - 0x1e]
loc_DE23:
DE23  80 7E DA 00     cmp byte ptr [bp - 0x26], 0
DE27  74 03           je 0xde2c
DE29  E9 E6 00        jmp 0xdf12
loc_DE2C:
DE2C  8B 46 E2        mov ax, word ptr [bp - 0x1e]
DE2F  6B 7E E4 0B     imul di, word ptr [bp - 0x1c], 0xb
DE33  03 F8           add di, ax
DE35  8A 43 DA        mov al, byte ptr [bp + di - 0x26]
DE38  30 E4           xor ah, ah
DE3A  3B 06 B2 D0     cmp ax, word ptr [0xd0b2]
DE3E  74 03           je 0xde43
DE40  E9 CF 00        jmp 0xdf12
loc_DE43:
DE43  8B 7E E4        mov di, word ptr [bp - 0x1c]
DE46  80 7B FD 0F     cmp byte ptr [bp + di - 3], 0xf
DE4A  72 03           jb 0xde4f
DE4C  E9 C3 00        jmp 0xdf12
loc_DE4F:
DE4F  6A 1E           push 0x1e
DE51  9A 6D 07 1A 23  call far 231A:076D
DE56  8B F8           mov di, ax
DE58  8A 85 DF 0C     mov al, byte ptr [di + 0xcdf]
DE5C  30 E4           xor ah, ah
DE5E  89 46 DC        mov word ptr [bp - 0x24], ax
DE61  8B 46 DC        mov ax, word ptr [bp - 0x24]
DE64  D1 E0           shl ax, 1
DE66  8B D0           mov dx, ax
DE68  83 7E E4 01     cmp word ptr [bp - 0x1c], 1
DE6C  B0 00           mov al, 0
DE6E  75 01           jne 0xde71
DE70  40              inc ax
loc_DE71:
DE71  98              cwde
DE72  8B F8           mov di, ax
DE74  D1 E7           shl di, 1
DE76  6B 85 E4 D6 3E  imul ax, word ptr [di - 0x291c], 0x3e
DE7B  C4 3E C2 D7     les di, ptr [0xd7c2]
DE7F  03 F8           add di, ax
DE81  03 FA           add di, dx
DE83  26 FF 75 C0     push word ptr es:[di - 0x40]
DE87  9A E9 4E 51 1B  call far 1B51:4EE9
DE8C  08 C0           or al, al
DE8E  75 BF           jne 0xde4f
DE90  8B 7E E4        mov di, word ptr [bp - 0x1c]
DE93  FE 43 FD        inc byte ptr [bp + di - 3]
DE96  83 7E E4 01     cmp word ptr [bp - 0x1c], 1
DE9A  B0 00           mov al, 0
DE9C  75 01           jne 0xde9f
DE9E  40              inc ax
loc_DE9F:
DE9F  98              cwde
DEA0  8B F8           mov di, ax
DEA2  D1 E7           shl di, 1
DEA4  6B 85 E4 D6 3E  imul ax, word ptr [di - 0x291c], 0x3e
DEA9  C4 3E C2 D7     les di, ptr [0xd7c2]
DEAD  03 F8           add di, ax
DEAF  81 C7 C2 FF     add di, 0xffc2
DEB3  89 7E D4        mov word ptr [bp - 0x2c], di
DEB6  8C 46 D6        mov word ptr [bp - 0x2a], es
DEB9  8B 46 DC        mov ax, word ptr [bp - 0x24]
DEBC  D1 E0           shl ax, 1
DEBE  03 F8           add di, ax
DEC0  26 FF 75 FE     push word ptr es:[di - 2]
DEC4  C4 7E D4        les di, ptr [bp - 0x2c]
DEC7  06              push es
DEC8  57              push di
DEC9  9A AF 5B 51 1B  call far 1B51:5BAF
DECE  8B D0           mov dx, ax
DED0  83 7E E4 01     cmp word ptr [bp - 0x1c], 1
DED4  B0 00           mov al, 0
DED6  75 01           jne 0xded9
DED8  40              inc ax
loc_DED9:
DED9  98              cwde
DEDA  8B F8           mov di, ax
DEDC  8A 85 56 0D     mov al, byte ptr [di + 0xd56]
DEE0  30 E4           xor ah, ah
DEE2  03 C2           add ax, dx
DEE4  A2 9F D0        mov byte ptr [0xd09f], al
DEE7  83 7E E4 01     cmp word ptr [bp - 0x1c], 1
DEEB  B0 00           mov al, 0
DEED  75 01           jne 0xdef0
DEEF  40              inc ax
loc_DEF0:
DEF0  50              push ax
DEF1  A0 9F D0        mov al, byte ptr [0xd09f]
DEF4  30 E4           xor ah, ah
DEF6  50              push ax
DEF7  8B 46 E2        mov ax, word ptr [bp - 0x1e]
DEFA  6B 7E E4 0B     imul di, word ptr [bp - 0x1c], 0xb
DEFE  03 F8           add di, ax
DF00  8A 43 DA        mov al, byte ptr [bp + di - 0x26]
DF03  30 E4           xor ah, ah
DF05  50              push ax
DF06  E8 7A 71        call 0x15083
DF09  C6 46 DA 01     mov byte ptr [bp - 0x26], 1
DF0D  C7 46 DE 02 00  mov word ptr [bp - 0x22], 2
loc_DF12:
DF12  8B 46 E2        mov ax, word ptr [bp - 0x1e]
DF15  3B 46 D8        cmp ax, word ptr [bp - 0x28]
DF18  74 03           je 0xdf1d
DF1A  E9 03 FF        jmp 0xde20
loc_DF1D:
DF1D  83 7E E4 02     cmp word ptr [bp - 0x1c], 2
DF21  74 03           je 0xdf26
DF23  E9 DB FE        jmp 0xde01
loc_DF26:
DF26  83 7E DE 02     cmp word ptr [bp - 0x22], 2
DF2A  74 03           je 0xdf2f
DF2C  E9 4E FE        jmp 0xdd7d
loc_DF2F:
DF2F  8B 46 FE        mov ax, word ptr [bp - 2]
DF32  A3 86 D0        mov word ptr [0xd086], ax
DF35  A1 86 D0        mov ax, word ptr [0xd086]
DF38  86 C4           xchg ah, al
DF3A  A3 C4 D0        mov word ptr [0xd0c4], ax
DF3D  FF 36 86 D0     push word ptr [0xd086]
DF41  C4 3E D2 D7     les di, ptr [0xd7d2]
DF45  26 8A 05        mov al, byte ptr es:[di]
DF48  30 E4           xor ah, ah
DF4A  8B D0           mov dx, ax
DF4C  6B 06 E6 D6 3A  imul ax, word ptr [0xd6e6], 0x3a
DF51  C4 3E CE D7     les di, ptr [0xd7ce]
DF55  03 F8           add di, ax
DF57  03 FA           add di, dx
DF59  81 C7 C5 FF     add di, 0xffc5
DF5D  06              push es
DF5E  57              push di
DF5F  9A C5 01 1A 23  call far 231A:01C5
DF64  FF 36 AE D0     push word ptr [0xd0ae]
DF68  6A 03           push 3
DF6A  E8 69 21        call 0x100d6
DF6D  BF 58 DD        mov di, 0xdd58
DF70  1E              push ds
DF71  57              push di
DF72  9A DF 02 94 19  call far 1994:02DF
DF77  C7 46 E2 01 00  mov word ptr [bp - 0x1e], 1
DF7C  EB 03           jmp 0xdf81
loc_DF7E:
DF7E  FF 46 E2        inc word ptr [bp - 0x1e]
loc_DF81:
DF81  6B 7E E2 19     imul di, word ptr [bp - 0x1e], 0x19
DF85  81 C7 EF CC     add di, 0xccef
DF89  1E              push ds
DF8A  07              pop es
DF8B  89 7E D6        mov word ptr [bp - 0x2a], di
DF8E  8C 46 D8        mov word ptr [bp - 0x28], es
DF91  06              push es
DF92  57              push di
DF93  0E              push cs
DF94  E8 0A 3D        call 0x11ca1
DF97  08 C0           or al, al
DF99  74 0C           je 0xdfa7
DF9B  C4 7E D6        les di, ptr [bp - 0x2a]
DF9E  06              push es
DF9F  57              push di
DFA0  9A 3F 09 94 19  call far 1994:093F
DFA5  EB 28           jmp 0xdfcf
loc_DFA7:
DFA7  A1 AE D0        mov ax, word ptr [0xd0ae]
DFAA  31 D2           xor dx, dx
DFAC  B9 05 00        mov cx, 5
DFAF  F7 F1           div cx
DFB1  92              xchg dx, ax
DFB2  09 C0           or ax, ax
DFB4  75 19           jne 0xdfcf
DFB6  C4 7E D6        les di, ptr [bp - 0x2a]
DFB9  26 6B 45 0E 0F  imul ax, word ptr es:[di + 0xe], 0xf
DFBE  C4 3E BE D7     les di, ptr [0xd7be]
DFC2  03 F8           add di, ax
DFC4  26 80 7D 08 01  cmp byte ptr es:[di + 8], 1
DFC9  7E 04           jle 0xdfcf
DFCB  26 FE 4D 08     dec byte ptr es:[di + 8]
loc_DFCF:
DFCF  83 7E E2 16     cmp word ptr [bp - 0x1e], 0x16
DFD3  75 A9           jne 0xdf7e
DFD5  80 3E DD D6 00  cmp byte ptr [0xd6dd], 0
DFDA  74 0A           je 0xdfe6
DFDC  80 7E DA 00     cmp byte ptr [bp - 0x26], 0
DFE0  75 04           jne 0xdfe6
DFE2  55              push bp
DFE3  E8 DA FB        call 0xdbc0
loc_DFE6:
DFE6  80 7E DA 00     cmp byte ptr [bp - 0x26], 0
DFEA  75 05           jne 0xdff1
DFEC  E8 40 8B        call 0x6b2f
DFEF  EB 0C           jmp 0xdffd
loc_DFF1:
DFF1  6A 00           push 0
DFF3  6A 01           push 1
DFF5  9A 5C 04 94 19  call far 1994:045C
DFFA  E8 B9 72        call 0x152b6
loc_DFFD:
DFFD  E8 B7 98        call 0x78b7
E000  C9              leave
E001  C3              ret

; ---- routine 0AB5:E002  (found by: call)
sub_E002:
E002  C8 08 00 00     enter 8, 0
E006  C6 46 FF 00     mov byte ptr [bp - 1], 0
E00A  EB 03           jmp 0xe00f
loc_E00C:
E00C  FE 46 FF        inc byte ptr [bp - 1]
loc_E00F:
E00F  8A 46 FF        mov al, byte ptr [bp - 1]
E012  98              cwde
E013  8B F8           mov di, ax
E015  D1 E7           shl di, 1
E017  6B 85 E4 D6 3E  imul ax, word ptr [di - 0x291c], 0x3e
E01C  C4 3E C2 D7     les di, ptr [0xd7c2]
E020  03 F8           add di, ax
E022  81 C7 C2 FF     add di, 0xffc2
E026  89 7E F8        mov word ptr [bp - 8], di
E029  8C 46 FA        mov word ptr [bp - 6], es
E02C  C7 46 FC 01 00  mov word ptr [bp - 4], 1
E031  EB 03           jmp 0xe036
loc_E033:
E033  FF 46 FC        inc word ptr [bp - 4]
loc_E036:
E036  8B 46 FC        mov ax, word ptr [bp - 4]
E039  D1 E0           shl ax, 1
E03B  C4 7E F8        les di, ptr [bp - 8]
E03E  03 F8           add di, ax
E040  26 FF 75 FE     push word ptr es:[di - 2]
E044  9A 6C 18 94 19  call far 1994:186C
E049  83 7E FC 0B     cmp word ptr [bp - 4], 0xb
E04D  75 E4           jne 0xe033
E04F  80 7E FF 01     cmp byte ptr [bp - 1], 1
E053  75 B7           jne 0xe00c
E055  E8 2E 9D        call 0x7d86
E058  E8 F8 9C        call 0x7d53
E05B  E8 75 9D        call 0x7dd3
E05E  9A 2E 02 1A 23  call far 231A:022E
E063  A1 C4 D0        mov ax, word ptr [0xd0c4]
E066  86 C4           xchg ah, al
E068  A3 86 D0        mov word ptr [0xd086], ax
E06B  FF 36 86 D0     push word ptr [0xd086]
E06F  8B 7E 04        mov di, word ptr [bp + 4]
E072  36 8B 55 04     mov dx, word ptr ss:[di + 4]
E076  36 6B 45 06 3A  imul ax, word ptr ss:[di + 6], 0x3a
E07B  C4 3E CE D7     les di, ptr [0xd7ce]
E07F  03 F8           add di, ax
E081  03 FA           add di, dx
E083  81 C7 C5 FF     add di, 0xffc5
E087  06              push es
E088  57              push di
E089  9A C5 01 1A 23  call far 231A:01C5
E08E  80 3E 2A 0D 00  cmp byte ptr [0xd2a], 0
E093  75 03           jne 0xe098
E095  E9 F2 00        jmp 0xe18a
loc_E098:
E098  8B 7E 04        mov di, word ptr [bp + 4]
E09B  36 FF 75 06     push word ptr ss:[di + 6]
E09F  36 FF 75 04     push word ptr ss:[di + 4]
E0A3  E8 58 F8        call 0xd8fe
E0A6  08 C0           or al, al
E0A8  75 03           jne 0xe0ad
E0AA  E9 DD 00        jmp 0xe18a
loc_E0AD:
E0AD  E8 C3 9D        call 0x7e73
E0B0  E8 0B 9E        call 0x7ebe
E0B3  A1 C4 D0        mov ax, word ptr [0xd0c4]
E0B6  86 C4           xchg ah, al
E0B8  A3 86 D0        mov word ptr [0xd086], ax
E0BB  FF 36 86 D0     push word ptr [0xd086]
E0BF  8B 7E 04        mov di, word ptr [bp + 4]
E0C2  36 8B 55 04     mov dx, word ptr ss:[di + 4]
E0C6  36 6B 45 06 3A  imul ax, word ptr ss:[di + 6], 0x3a
E0CB  C4 3E CE D7     les di, ptr [0xd7ce]
E0CF  03 F8           add di, ax
E0D1  03 FA           add di, dx
E0D3  81 C7 C5 FF     add di, 0xffc5
E0D7  06              push es
E0D8  57              push di
E0D9  9A C5 01 1A 23  call far 231A:01C5
E0DE  C6 06 B6 D0 00  mov byte ptr [0xd0b6], 0
E0E3  8B 7E 04        mov di, word ptr [bp + 4]
E0E6  36 FF 75 06     push word ptr ss:[di + 6]
E0EA  36 FF 75 04     push word ptr ss:[di + 4]
E0EE  E8 0D F8        call 0xd8fe
E0F1  08 C0           or al, al
E0F3  75 03           jne 0xe0f8
E0F5  E9 8D 00        jmp 0xe185
loc_E0F8:
E0F8  E8 39 A3        call 0x8434
E0FB  A0 C5 D0        mov al, byte ptr [0xd0c5]
E0FE  3A 06 C4 D0     cmp al, byte ptr [0xd0c4]
E102  76 32           jbe 0xe136
E104  8B 7E 04        mov di, word ptr [bp + 4]
E107  36 8B 45 04     mov ax, word ptr ss:[di + 4]
E10B  8B F0           mov si, ax
E10D  D1 E0           shl ax, 1
E10F  01 F0           add ax, si
E111  8B D0           mov dx, ax
E113  36 69 45 06 AE 00 imul ax, word ptr ss:[di + 6], 0xae
E119  C4 3E CA D7     les di, ptr [0xd7ca]
E11D  03 F8           add di, ax
E11F  03 FA           add di, dx
E121  81 C7 4F FF     add di, 0xff4f
E125  26 8A 45 02     mov al, byte ptr es:[di + 2]
E129  24 0F           and al, 0xf
E12B  30 E4           xor ah, ah
E12D  05 80 00        add ax, 0x80
E130  26 88 45 02     mov byte ptr es:[di + 2], al
E134  EB 4F           jmp 0xe185
loc_E136:
E136  8B 7E 04        mov di, word ptr [bp + 4]
E139  36 8B 45 04     mov ax, word ptr ss:[di + 4]
E13D  8B F0           mov si, ax
E13F  D1 E0           shl ax, 1
E141  01 F0           add ax, si
E143  8B C8           mov cx, ax
E145  36 8B 45 04     mov ax, word ptr ss:[di + 4]
E149  8B F0           mov si, ax
E14B  D1 E0           shl ax, 1
E14D  01 F0           add ax, si
E14F  8B D0           mov dx, ax
E151  36 69 45 06 AE 00 imul ax, word ptr ss:[di + 6], 0xae
E157  C4 3E CA D7     les di, ptr [0xd7ca]
E15B  03 F8           add di, ax
E15D  03 FA           add di, dx
E15F  26 8A 85 50 FF  mov al, byte ptr es:[di - 0xb0]
E164  30 E4           xor ah, ah
E166  69 C0 AE 00     imul ax, ax, 0xae
E16A  C4 3E CA D7     les di, ptr [0xd7ca]
E16E  03 F8           add di, ax
E170  03 F9           add di, cx
E172  81 C7 4F FF     add di, 0xff4f
E176  26 8A 45 02     mov al, byte ptr es:[di + 2]
E17A  24 0F           and al, 0xf
E17C  30 E4           xor ah, ah
E17E  05 80 00        add ax, 0x80
E181  26 88 45 02     mov byte ptr es:[di + 2], al
loc_E185:
E185  9A 2E 02 1A 23  call far 231A:022E
loc_E18A:
E18A  80 3E 74 D0 00  cmp byte ptr [0xd074], 0
E18F  74 02           je 0xe193
E191  EB 55           jmp 0xe1e8
loc_E193:
E193  A0 C5 D0        mov al, byte ptr [0xd0c5]
E196  3A 06 C4 D0     cmp al, byte ptr [0xd0c4]
E19A  74 03           je 0xe19f
E19C  E8 35 9B        call 0x7cd4
loc_E19F:
E19F  E8 B1 9B        call 0x7d53
E1A2  E8 89 D2        call 0xb42e
E1A5  C6 06 56 DD 01  mov byte ptr [0xdd56], 1
loc_E1AA:
E1AA  BF 12 4B        mov di, 0x4b12
E1AD  1E              push ds
E1AE  57              push di
E1AF  BF 58 DD        mov di, 0xdd58
E1B2  1E              push ds
E1B3  57              push di
E1B4  9A 2F 05 1A 23  call far 231A:052F
E1B9  9A 9B 09 1A 23  call far 231A:099B
E1BE  A0 88 DE        mov al, byte ptr [0xde88]
E1C1  50              push ax
E1C2  9A 86 19 B9 26  call far 26B9:1986
E1C7  3C 50           cmp al, 0x50
E1C9  75 05           jne 0xe1d0
E1CB  E8 A9 23        call 0x10577
E1CE  EB 16           jmp 0xe1e6
loc_E1D0:
E1D0  3C 20           cmp al, 0x20
E1D2  75 05           jne 0xe1d9
E1D4  E8 7C 29        call 0x10b53
E1D7  EB 0D           jmp 0xe1e6
loc_E1D9:
E1D9  3C 02           cmp al, 2
E1DB  75 07           jne 0xe1e4
E1DD  6A 01           push 1
E1DF  E8 EE F3        call 0xd5d0
E1E2  EB 02           jmp 0xe1e6
loc_E1E4:
E1E4  EB 02           jmp 0xe1e8
loc_E1E6:
E1E6  EB C2           jmp 0xe1aa
loc_E1E8:
E1E8  C9              leave
E1E9  C2 02 00        ret 2

; ---- routine 0AB5:E1EC  (found by: call)
sub_E1EC:
E1EC  C8 0C 00 00     enter 0xc, 0
E1F0  9A BA 00 94 19  call far 1994:00BA
E1F5  8B 46 04        mov ax, word ptr [bp + 4]
E1F8  8B F0           mov si, ax
E1FA  D1 E0           shl ax, 1
E1FC  01 F0           add ax, si
E1FE  8B D0           mov dx, ax
E200  69 46 06 AE 00  imul ax, word ptr [bp + 6], 0xae
E205  C4 3E CA D7     les di, ptr [0xd7ca]
E209  03 F8           add di, ax
E20B  03 FA           add di, dx
E20D  81 C7 4F FF     add di, 0xff4f
E211  8B 46 06        mov ax, word ptr [bp + 6]
E214  A3 E6 D6        mov word ptr [0xd6e6], ax
E217  26 8A 45 01     mov al, byte ptr es:[di + 1]
E21B  30 E4           xor ah, ah
E21D  A3 E4 D6        mov word ptr [0xd6e4], ax
E220  26 8A 45 02     mov al, byte ptr es:[di + 2]
E224  24 F0           and al, 0xf0
E226  30 E4           xor ah, ah
E228  C1 E8 04        shr ax, 4
E22B  3D 01 00        cmp ax, 1
E22E  B0 00           mov al, 0
E230  75 01           jne 0xe233
E232  40              inc ax
loc_E233:
E233  A2 2A 0D        mov byte ptr [0xd2a], al
E236  26 8A 45 02     mov al, byte ptr es:[di + 2]
E23A  24 0F           and al, 0xf
E23C  3C 01           cmp al, 1
E23E  B0 00           mov al, 0
E240  75 01           jne 0xe243
E242  40              inc ax
loc_E243:
E243  A2 29 0D        mov byte ptr [0xd29], al
E246  E8 81 37        call 0x119ca
E249  31 C0           xor ax, ax
E24B  A3 C4 D0        mov word ptr [0xd0c4], ax
E24E  C7 06 C6 D0 FF FF mov word ptr [0xd0c6], 0xffff
E254  E8 83 A6        call 0x88da
E257  BF 48 D1        mov di, 0xd148
E25A  1E              push ds
E25B  57              push di
E25C  6A 28           push 0x28
E25E  6A 37           push 0x37
E260  9A 6C 02 1A 23  call far 231A:026C
E265  BF 98 D1        mov di, 0xd198
E268  1E              push ds
E269  57              push di
E26A  6A 28           push 0x28
E26C  6A 00           push 0
E26E  9A 22 02 AC 24  call far 24AC:0222
E273  C6 46 FF 00     mov byte ptr [bp - 1], 0
E277  EB 03           jmp 0xe27c
loc_E279:
E279  FE 46 FF        inc byte ptr [bp - 1]
loc_E27C:
E27C  8A 46 FF        mov al, byte ptr [bp - 1]
E27F  98              cwde
E280  8B F8           mov di, ax
E282  D1 E7           shl di, 1
E284  FF B5 E4 D6     push word ptr [di - 0x291c]
E288  9A DA 0D 51 1B  call far 1B51:0DDA
E28D  08 C0           or al, al
E28F  75 25           jne 0xe2b6
E291  8A 46 FF        mov al, byte ptr [bp - 1]
E294  98              cwde
E295  8B F8           mov di, ax
E297  D1 E7           shl di, 1
E299  FF B5 E4 D6     push word ptr [di - 0x291c]
E29D  E8 0C BA        call 0x9cac
E2A0  8A 46 FF        mov al, byte ptr [bp - 1]
E2A3  98              cwde
E2A4  8B F8           mov di, ax
E2A6  D1 E7           shl di, 1
E2A8  FF B5 E4 D6     push word ptr [di - 0x291c]
E2AC  E8 44 BC        call 0x9ef3
E2AF  8A 46 FF        mov al, byte ptr [bp - 1]
E2B2  50              push ax
E2B3  E8 86 BF        call 0xa23c
loc_E2B6:
E2B6  80 7E FF 01     cmp byte ptr [bp - 1], 1
E2BA  75 BD           jne 0xe279
E2BC  31 C0           xor ax, ax
E2BE  A3 42 D1        mov word ptr [0xd142], ax
E2C1  31 C0           xor ax, ax
E2C3  A3 CC D0        mov word ptr [0xd0cc], ax
E2C6  31 C0           xor ax, ax
E2C8  A3 CE D0        mov word ptr [0xd0ce], ax
E2CB  E8 1B A4        call 0x86e9
E2CE  9A AE 27 51 1B  call far 1B51:27AE
E2D3  E8 65 F7        call 0xda3b
E2D6  C6 06 91 0D 01  mov byte ptr [0xd91], 1
E2DB  BF 5E CF        mov di, 0xcf5e
E2DE  1E              push ds
E2DF  57              push di
E2E0  6A 14           push 0x14
E2E2  6A 00           push 0
E2E4  9A 22 02 AC 24  call far 24AC:0222
E2E9  C6 06 CC D1 00  mov byte ptr [0xd1cc], 0
E2EE  C6 06 74 D0 00  mov byte ptr [0xd074], 0
E2F3  C6 06 75 D0 00  mov byte ptr [0xd075], 0
E2F8  6A 01           push 1
E2FA  E8 D3 F2        call 0xd5d0
E2FD  C4 3E 92 D0     les di, ptr [0xd092]
E301  06              push es
E302  57              push di
E303  C4 3E 8A D0     les di, ptr [0xd08a]
E307  06              push es
E308  57              push di
E309  68 A0 0F        push 0xfa0
E30C  9A 12 0A B9 26  call far 26B9:0A12
E311  C4 3E 92 D0     les di, ptr [0xd092]
E315  06              push es
E316  57              push di
E317  C4 3E 96 D0     les di, ptr [0xd096]
E31B  06              push es
E31C  57              push di
E31D  68 A0 0F        push 0xfa0
E320  9A 12 0A B9 26  call far 26B9:0A12
E325  C6 46 FF 00     mov byte ptr [bp - 1], 0
E329  EB 03           jmp 0xe32e
loc_E32B:
E32B  FE 46 FF        inc byte ptr [bp - 1]
loc_E32E:
E32E  C7 46 FC 01 00  mov word ptr [bp - 4], 1
E333  EB 03           jmp 0xe338
loc_E335:
E335  FF 46 FC        inc word ptr [bp - 4]
loc_E338:
E338  8A 46 FF        mov al, byte ptr [bp - 1]
E33B  98              cwde
E33C  8B F8           mov di, ax
E33E  D1 E7           shl di, 1
E340  6B 85 E4 D6 3E  imul ax, word ptr [di - 0x291c], 0x3e
E345  C4 3E C2 D7     les di, ptr [0xd7c2]
E349  03 F8           add di, ax
E34B  81 C7 C2 FF     add di, 0xffc2
E34F  89 7E F6        mov word ptr [bp - 0xa], di
E352  8C 46 F8        mov word ptr [bp - 8], es
E355  8B 46 FC        mov ax, word ptr [bp - 4]
E358  D1 E0           shl ax, 1
E35A  03 F8           add di, ax
E35C  26 83 7D FE 00  cmp word ptr es:[di - 2], 0
E361  74 29           je 0xe38c
E363  8B 46 FC        mov ax, word ptr [bp - 4]
E366  D1 E0           shl ax, 1
E368  C4 7E F6        les di, ptr [bp - 0xa]
E36B  03 F8           add di, ax
E36D  26 6B 45 FE 0F  imul ax, word ptr es:[di - 2], 0xf
E372  C4 3E BE D7     les di, ptr [0xd7be]
E376  03 F8           add di, ax
E378  26 8A 4D 06     mov cl, byte ptr es:[di + 6]
E37C  8B 56 FC        mov dx, word ptr [bp - 4]
E37F  8A 46 FF        mov al, byte ptr [bp - 1]
E382  98              cwde
E383  6B F8 14        imul di, ax, 0x14
E386  03 FA           add di, dx
E388  88 8D 97 D1     mov byte ptr [di - 0x2e69], cl
loc_E38C:
E38C  83 7E FC 14     cmp word ptr [bp - 4], 0x14
E390  75 A3           jne 0xe335
E392  8A 46 FF        mov al, byte ptr [bp - 1]
E395  98              cwde
E396  8B F8           mov di, ax
E398  8A 85 E0 D6     mov al, byte ptr [di - 0x2920]
E39C  30 E4           xor ah, ah
E39E  89 46 FA        mov word ptr [bp - 6], ax
E3A1  8A 46 FF        mov al, byte ptr [bp - 1]
E3A4  98              cwde
E3A5  8B F8           mov di, ax
E3A7  D1 E7           shl di, 1
E3A9  6B 85 E4 D6 3E  imul ax, word ptr [di - 0x291c], 0x3e
E3AE  C4 3E C2 D7     les di, ptr [0xd7c2]
E3B2  03 F8           add di, ax
E3B4  81 C7 C2 FF     add di, 0xffc2
E3B8  89 7E F6        mov word ptr [bp - 0xa], di
E3BB  8C 46 F8        mov word ptr [bp - 8], es
E3BE  8B 46 FA        mov ax, word ptr [bp - 6]
E3C1  05 0C 00        add ax, 0xc
E3C4  48              dec ax
E3C5  89 46 F4        mov word ptr [bp - 0xc], ax
E3C8  B8 0C 00        mov ax, 0xc
E3CB  3B 46 F4        cmp ax, word ptr [bp - 0xc]
E3CE  77 3E           ja 0xe40e
E3D0  89 46 FC        mov word ptr [bp - 4], ax
E3D3  EB 03           jmp 0xe3d8
loc_E3D5:
E3D5  FF 46 FC        inc word ptr [bp - 4]
loc_E3D8:
E3D8  8A 46 FF        mov al, byte ptr [bp - 1]
E3DB  98              cwde
E3DC  8B F8           mov di, ax
E3DE  80 BD E0 D6 00  cmp byte ptr [di - 0x2920], 0
E3E3  76 21           jbe 0xe406
E3E5  8B 46 FC        mov ax, word ptr [bp - 4]
E3E8  D1 E0           shl ax, 1
E3EA  C4 7E F6        les di, ptr [bp - 0xa]
E3ED  03 F8           add di, ax
E3EF  26 FF 75 FE     push word ptr es:[di - 2]
E3F3  9A E9 4E 51 1B  call far 1B51:4EE9
E3F8  08 C0           or al, al
E3FA  74 0A           je 0xe406
E3FC  8A 46 FF        mov al, byte ptr [bp - 1]
E3FF  98              cwde
E400  8B F8           mov di, ax
E402  FE 8D E0 D6     dec byte ptr [di - 0x2920]
loc_E406:
E406  8B 46 FC        mov ax, word ptr [bp - 4]
E409  3B 46 F4        cmp ax, word ptr [bp - 0xc]
E40C  75 C7           jne 0xe3d5
loc_E40E:
E40E  80 7E FF 01     cmp byte ptr [bp - 1], 1
E412  74 03           je 0xe417
E414  E9 14 FF        jmp 0xe32b
loc_E417:
E417  C4 3E D2 D7     les di, ptr [0xd7d2]
E41B  26 80 BD F2 00 00 cmp byte ptr es:[di + 0xf2], 0
E421  75 08           jne 0xe42b
E423  C6 06 B8 D0 01  mov byte ptr [0xd0b8], 1
E428  E8 37 F7        call 0xdb62
loc_E42B:
E42B  55              push bp
E42C  E8 D3 FB        call 0xe002
E42F  C4 3E 8A D0     les di, ptr [0xd08a]
E433  06              push es
E434  57              push di
E435  C4 3E 96 D0     les di, ptr [0xd096]
E439  06              push es
E43A  57              push di
E43B  68 A0 0F        push 0xfa0
E43E  9A 12 0A B9 26  call far 26B9:0A12
E443  A0 84 D0        mov al, byte ptr [0xd084]
E446  30 E4           xor ah, ah
E448  3B 46 06        cmp ax, word ptr [bp + 6]
E44B  B0 00           mov al, 0
E44D  74 01           je 0xe450
E44F  40              inc ax
loc_E450:
E450  50              push ax
E451  6A 00           push 0
E453  9A 5C 04 94 19  call far 1994:045C
E458  E8 15 D1        call 0xb570
E45B  9A 7A 0C 94 19  call far 1994:0C7A
E460  C6 06 18 0D 00  mov byte ptr [0xd18], 0
E465  C6 06 91 0D 00  mov byte ptr [0xd91], 0
E46A  9A CD 00 94 19  call far 1994:00CD
E46F  C9              leave
E470  C2 04 00        ret 4

; ---- routine 0AB5:E473  (found by: call)
sub_E473:
E473  C8 06 00 00     enter 6, 0
E477  8B 46 04        mov ax, word ptr [bp + 4]
E47A  8B F0           mov si, ax
E47C  D1 E0           shl ax, 1
E47E  01 F0           add ax, si
E480  8B D0           mov dx, ax
E482  69 46 06 AE 00  imul ax, word ptr [bp + 6], 0xae
E487  C4 3E CA D7     les di, ptr [0xd7ca]
E48B  03 F8           add di, ax
E48D  03 FA           add di, dx
E48F  81 C7 4F FF     add di, 0xff4f
E493  26 80 7D 01 00  cmp byte ptr es:[di + 1], 0
E498  74 1A           je 0xe4b4
E49A  26 8A 45 02     mov al, byte ptr es:[di + 2]
E49E  24 0F           and al, 0xf
E4A0  08 C0           or al, al
E4A2  74 10           je 0xe4b4
E4A4  26 8A 45 02     mov al, byte ptr es:[di + 2]
E4A8  24 F0           and al, 0xf0
E4AA  30 E4           xor ah, ah
E4AC  C1 E8 04        shr ax, 4
E4AF  3D 01 00        cmp ax, 1
E4B2  7E 04           jle 0xe4b8
loc_E4B4:
E4B4  B0 00           mov al, 0
E4B6  EB 02           jmp 0xe4ba
loc_E4B8:
E4B8  B0 01           mov al, 1
loc_E4BA:
E4BA  88 46 FF        mov byte ptr [bp - 1], al
E4BD  8A 46 FF        mov al, byte ptr [bp - 1]
E4C0  C9              leave
E4C1  C2 04 00        ret 4

; ---- routine 0AB5:E4C4  (found by: call)
sub_E4C4:
E4C4  C8 04 00 00     enter 4, 0
E4C8  C4 7E 06        les di, ptr [bp + 6]
E4CB  89 7E FC        mov word ptr [bp - 4], di
E4CE  8C 46 FE        mov word ptr [bp - 2], es
E4D1  FF 36 86 D0     push word ptr [0xd086]
E4D5  81 C7 02 00     add di, 2
E4D9  06              push es
E4DA  57              push di
E4DB  9A C5 01 1A 23  call far 231A:01C5
E4E0  8B 7E 04        mov di, word ptr [bp + 4]
E4E3  36 8B 7D 04     mov di, word ptr ss:[di + 4]
E4E7  36 8B 45 06     mov ax, word ptr ss:[di + 6]
E4EB  8B F0           mov si, ax
E4ED  D1 E0           shl ax, 1
E4EF  01 F0           add ax, si
E4F1  8B D0           mov dx, ax
E4F3  8B 7E 04        mov di, word ptr [bp + 4]
E4F6  36 69 45 06 AE 00 imul ax, word ptr ss:[di + 6], 0xae
E4FC  C4 3E CA D7     les di, ptr [0xd7ca]
E500  03 F8           add di, ax
E502  03 FA           add di, dx
E504  26 8A 85 50 FF  mov al, byte ptr es:[di - 0xb0]
E509  C4 7E FC        les di, ptr [bp - 4]
E50C  26 88 05        mov byte ptr es:[di], al
E50F  26 8A 05        mov al, byte ptr es:[di]
E512  30 E4           xor ah, ah
E514  6B C0 3E        imul ax, ax, 0x3e
E517  C4 3E C2 D7     les di, ptr [0xd7c2]
E51B  03 F8           add di, ax
E51D  26 8A 45 F9     mov al, byte ptr es:[di - 7]
E521  C4 7E FC        les di, ptr [bp - 4]
E524  26 88 45 01     mov byte ptr es:[di + 1], al
E528  C9              leave
E529  C2 06 00        ret 6

; ---- routine 0AB5:E52C  (found by: call)
sub_E52C:
E52C  C8 04 00 00     enter 4, 0
E530  80 3E DD D6 00  cmp byte ptr [0xd6dd], 0
E535  75 03           jne 0xe53a
E537  E9 AB 00        jmp 0xe5e5
loc_E53A:
E53A  A0 87 D0        mov al, byte ptr [0xd087]
E53D  30 E4           xor ah, ah
E53F  8B D0           mov dx, ax
E541  A0 86 D0        mov al, byte ptr [0xd086]
E544  30 E4           xor ah, ah
E546  2B C2           sub ax, dx
E548  88 46 FF        mov byte ptr [bp - 1], al
E54B  6B 46 06 2E     imul ax, word ptr [bp + 6], 0x2e
E54F  C4 3E C0 DC     les di, ptr [0xdcc0]
E553  03 F8           add di, ax
E555  26 8A 45 E8     mov al, byte ptr es:[di - 0x18]
E559  50              push ax
E55A  8D 7E FC        lea di, [bp - 4]
E55D  16              push ss
E55E  57              push di
E55F  9A E3 01 1A 23  call far 231A:01E3
E564  8A 46 FD        mov al, byte ptr [bp - 3]
E567  30 E4           xor ah, ah
E569  8B D0           mov dx, ax
E56B  8A 46 FC        mov al, byte ptr [bp - 4]
E56E  30 E4           xor ah, ah
E570  2B C2           sub ax, dx
E572  88 46 FE        mov byte ptr [bp - 2], al
E575  8A 46 FF        mov al, byte ptr [bp - 1]
E578  3A 46 FE        cmp al, byte ptr [bp - 2]
E57B  7E 1C           jle 0xe599
E57D  80 7E FF 00     cmp byte ptr [bp - 1], 0
E581  7E 16           jle 0xe599
E583  6B 46 06 2E     imul ax, word ptr [bp + 6], 0x2e
E587  C4 3E C0 DC     les di, ptr [0xdcc0]
E58B  03 F8           add di, ax
E58D  81 C7 E6 FF     add di, 0xffe6
E591  06              push es
E592  57              push di
E593  55              push bp
E594  E8 2D FF        call 0xe4c4
E597  EB 4C           jmp 0xe5e5
loc_E599:
E599  6B 46 06 2E     imul ax, word ptr [bp + 6], 0x2e
E59D  C4 3E C0 DC     les di, ptr [0xdcc0]
E5A1  03 F8           add di, ax
E5A3  26 8A 45 EC     mov al, byte ptr es:[di - 0x14]
E5A7  50              push ax
E5A8  8D 7E FC        lea di, [bp - 4]
E5AB  16              push ss
E5AC  57              push di
E5AD  9A E3 01 1A 23  call far 231A:01E3
E5B2  8A 46 FD        mov al, byte ptr [bp - 3]
E5B5  30 E4           xor ah, ah
E5B7  8B D0           mov dx, ax
E5B9  8A 46 FC        mov al, byte ptr [bp - 4]
E5BC  30 E4           xor ah, ah
E5BE  2B C2           sub ax, dx
E5C0  88 46 FE        mov byte ptr [bp - 2], al
E5C3  8A 46 FF        mov al, byte ptr [bp - 1]
E5C6  3A 46 FE        cmp al, byte ptr [bp - 2]
E5C9  7D 1A           jge 0xe5e5
E5CB  80 7E FF 00     cmp byte ptr [bp - 1], 0
E5CF  7D 14           jge 0xe5e5
E5D1  6B 46 06 2E     imul ax, word ptr [bp + 6], 0x2e
E5D5  C4 3E C0 DC     les di, ptr [0xdcc0]
E5D9  03 F8           add di, ax
E5DB  81 C7 EA FF     add di, 0xffea
E5DF  06              push es
E5E0  57              push di
E5E1  55              push bp
E5E2  E8 DF FE        call 0xe4c4
loc_E5E5:
E5E5  C9              leave
E5E6  C2 04 00        ret 4

; ---- routine 0AB5:E5E9  (found by: call)
sub_E5E9:
E5E9  C8 04 00 00     enter 4, 0
E5ED  8B 7E 04        mov di, word ptr [bp + 4]
E5F0  36 8B 45 06     mov ax, word ptr ss:[di + 6]
E5F4  8B F0           mov si, ax
E5F6  D1 E0           shl ax, 1
E5F8  01 F0           add ax, si
E5FA  8B D0           mov dx, ax
E5FC  36 8B 7D FE     mov di, word ptr ss:[di - 2]
E600  8A 85 FB D4     mov al, byte ptr [di - 0x2b05]
E604  30 E4           xor ah, ah
E606  69 C0 AE 00     imul ax, ax, 0xae
E60A  C4 3E CA D7     les di, ptr [0xd7ca]
E60E  03 F8           add di, ax
E610  03 FA           add di, dx
E612  81 C7 4F FF     add di, 0xff4f
E616  89 7E FC        mov word ptr [bp - 4], di
E619  8C 46 FE        mov word ptr [bp - 2], es
E61C  26 80 3D 01     cmp byte ptr es:[di], 1
E620  74 0C           je 0xe62e
E622  26 80 3D 02     cmp byte ptr es:[di], 2
E626  74 06           je 0xe62e
E628  26 80 3D 09     cmp byte ptr es:[di], 9
E62C  75 04           jne 0xe632
loc_E62E:
E62E  B0 00           mov al, 0
E630  EB 02           jmp 0xe634
loc_E632:
E632  B0 01           mov al, 1
loc_E634:
E634  A2 DD D6        mov byte ptr [0xd6dd], al
E637  31 C0           xor ax, ax
E639  A3 86 D0        mov word ptr [0xd086], ax
E63C  8A 46 06        mov al, byte ptr [bp + 6]
E63F  8B 7E 04        mov di, word ptr [bp + 4]
E642  36 88 45 F9     mov byte ptr ss:[di - 7], al
E646  36 8B 7D FE     mov di, word ptr ss:[di - 2]
E64A  8A 85 FB D4     mov al, byte ptr [di - 0x2b05]
E64E  30 E4           xor ah, ah
E650  A3 E6 D6        mov word ptr [0xd6e6], ax
E653  C4 7E FC        les di, ptr [bp - 4]
E656  26 8A 45 01     mov al, byte ptr es:[di + 1]
E65A  30 E4           xor ah, ah
E65C  A3 E4 D6        mov word ptr [0xd6e4], ax
E65F  26 8A 45 02     mov al, byte ptr es:[di + 2]
E663  24 0F           and al, 0xf
E665  3C 01           cmp al, 1
E667  B0 00           mov al, 0
E669  75 01           jne 0xe66c
E66B  40              inc ax
loc_E66C:
E66C  A2 29 0D        mov byte ptr [0xd29], al
E66F  C9              leave
E670  C2 04 00        ret 4

; ---- routine 0AB5:E673  (found by: call)
sub_E673:
E673  C8 08 00 00     enter 8, 0
E677  8B 7E 04        mov di, word ptr [bp + 4]
E67A  36 8B 45 06     mov ax, word ptr ss:[di + 6]
E67E  8B F0           mov si, ax
E680  D1 E0           shl ax, 1
E682  01 F0           add ax, si
E684  8B D0           mov dx, ax
E686  36 8B 7D FE     mov di, word ptr ss:[di - 2]
E68A  8A 85 FB D4     mov al, byte ptr [di - 0x2b05]
E68E  30 E4           xor ah, ah
E690  69 C0 AE 00     imul ax, ax, 0xae
E694  C4 3E CA D7     les di, ptr [0xd7ca]
E698  03 F8           add di, ax
E69A  03 FA           add di, dx
E69C  81 C7 4F FF     add di, 0xff4f
E6A0  89 7E FC        mov word ptr [bp - 4], di
E6A3  8C 46 FE        mov word ptr [bp - 2], es
E6A6  FF 36 86 D0     push word ptr [0xd086]
E6AA  8B 7E 04        mov di, word ptr [bp + 4]
E6AD  36 8B 55 06     mov dx, word ptr ss:[di + 6]
E6B1  36 8B 7D FE     mov di, word ptr ss:[di - 2]
E6B5  8A 85 FB D4     mov al, byte ptr [di - 0x2b05]
E6B9  30 E4           xor ah, ah
E6BB  6B C0 3A        imul ax, ax, 0x3a
E6BE  C4 3E CE D7     les di, ptr [0xd7ce]
E6C2  03 F8           add di, ax
E6C4  03 FA           add di, dx
E6C6  81 C7 C5 FF     add di, 0xffc5
E6CA  06              push es
E6CB  57              push di
E6CC  9A C5 01 1A 23  call far 231A:01C5
E6D1  C4 7E FC        les di, ptr [bp - 4]
E6D4  26 8A 45 02     mov al, byte ptr es:[di + 2]
E6D8  24 F0           and al, 0xf0
E6DA  30 E4           xor ah, ah
E6DC  C1 E8 04        shr ax, 4
E6DF  3D 08 00        cmp ax, 8
E6E2  74 0F           je 0xe6f3
E6E4  26 8A 45 02     mov al, byte ptr es:[di + 2]
E6E8  24 0F           and al, 0xf
E6EA  30 E4           xor ah, ah
E6EC  05 40 00        add ax, 0x40
E6EF  26 88 45 02     mov byte ptr es:[di + 2], al
loc_E6F3:
E6F3  8B 7E 04        mov di, word ptr [bp + 4]
E6F6  36 8B 45 06     mov ax, word ptr ss:[di + 6]
E6FA  8B F0           mov si, ax
E6FC  D1 E0           shl ax, 1
E6FE  01 F0           add ax, si
E700  8B D0           mov dx, ax
E702  C4 7E FC        les di, ptr [bp - 4]
E705  26 8A 45 01     mov al, byte ptr es:[di + 1]
E709  30 E4           xor ah, ah
E70B  69 C0 AE 00     imul ax, ax, 0xae
E70F  C4 3E CA D7     les di, ptr [0xd7ca]
E713  03 F8           add di, ax
E715  03 FA           add di, dx
E717  81 C7 4F FF     add di, 0xff4f
E71B  26 8A 45 02     mov al, byte ptr es:[di + 2]
E71F  24 F0           and al, 0xf0
E721  30 E4           xor ah, ah
E723  C1 E8 04        shr ax, 4
E726  3D 08 00        cmp ax, 8
E729  74 0F           je 0xe73a
E72B  26 8A 45 02     mov al, byte ptr es:[di + 2]
E72F  24 0F           and al, 0xf
E731  30 E4           xor ah, ah
E733  05 40 00        add ax, 0x40
E736  26 88 45 02     mov byte ptr es:[di + 2], al
loc_E73A:
E73A  8B 7E 04        mov di, word ptr [bp + 4]
E73D  36 8B 7D FE     mov di, word ptr ss:[di - 2]
E741  8A 85 FB D4     mov al, byte ptr [di - 0x2b05]
E745  30 E4           xor ah, ah
E747  50              push ax
E748  8B 7E 04        mov di, word ptr [bp + 4]
E74B  57              push di
E74C  E8 DD FD        call 0xe52c
E74F  8B 7E 04        mov di, word ptr [bp + 4]
E752  36 8B 7D FE     mov di, word ptr ss:[di - 2]
E756  8A 85 FB D4     mov al, byte ptr [di - 0x2b05]
E75A  30 E4           xor ah, ah
E75C  50              push ax
E75D  C4 7E FC        les di, ptr [bp - 4]
E760  26 8A 45 01     mov al, byte ptr es:[di + 1]
E764  30 E4           xor ah, ah
E766  50              push ax
E767  9A 26 11 94 19  call far 1994:1126
E76C  BF 86 D0        mov di, 0xd086
E76F  1E              push ds
E770  57              push di
E771  BF 87 D0        mov di, 0xd087
E774  1E              push ds
E775  57              push di
E776  6A 01           push 1
E778  9A 03 02 AC 24  call far 24AC:0203
E77D  FF 36 86 D0     push word ptr [0xd086]
E781  8B 7E 04        mov di, word ptr [bp + 4]
E784  36 8B 55 06     mov dx, word ptr ss:[di + 6]
E788  C4 7E FC        les di, ptr [bp - 4]
E78B  26 8A 45 01     mov al, byte ptr es:[di + 1]
E78F  30 E4           xor ah, ah
E791  6B C0 3A        imul ax, ax, 0x3a
E794  C4 3E CE D7     les di, ptr [0xd7ce]
E798  03 F8           add di, ax
E79A  03 FA           add di, dx
E79C  81 C7 C5 FF     add di, 0xffc5
E7A0  06              push es
E7A1  57              push di
E7A2  9A C5 01 1A 23  call far 231A:01C5
E7A7  C4 7E FC        les di, ptr [bp - 4]
E7AA  26 8A 45 01     mov al, byte ptr es:[di + 1]
E7AE  30 E4           xor ah, ah
E7B0  50              push ax
E7B1  8B 7E 04        mov di, word ptr [bp + 4]
E7B4  57              push di
E7B5  E8 74 FD        call 0xe52c
E7B8  8B 7E 04        mov di, word ptr [bp + 4]
E7BB  36 80 7D F9 00  cmp byte ptr ss:[di - 7], 0
E7C0  74 08           je 0xe7ca
E7C2  36 C7 45 FA FF FF mov word ptr ss:[di - 6], 0xffff
E7C8  EB 0A           jmp 0xe7d4
loc_E7CA:
E7CA  A1 86 D0        mov ax, word ptr [0xd086]
E7CD  8B 7E 04        mov di, word ptr [bp + 4]
E7D0  36 89 45 FA     mov word ptr ss:[di - 6], ax
loc_E7D4:
E7D4  8B 7E 04        mov di, word ptr [bp + 4]
E7D7  36 8B 7D FE     mov di, word ptr ss:[di - 2]
E7DB  8A 85 FB D4     mov al, byte ptr [di - 0x2b05]
E7DF  30 E4           xor ah, ah
E7E1  50              push ax
E7E2  8B 7E 04        mov di, word ptr [bp + 4]
E7E5  36 8A 45 FB     mov al, byte ptr ss:[di - 5]
E7E9  30 E4           xor ah, ah
E7EB  50              push ax
E7EC  36 8A 45 FA     mov al, byte ptr ss:[di - 6]
E7F0  30 E4           xor ah, ah
E7F2  50              push ax
E7F3  9A 97 18 94 19  call far 1994:1897
E7F8  C4 7E FC        les di, ptr [bp - 4]
E7FB  26 8A 45 01     mov al, byte ptr es:[di + 1]
E7FF  30 E4           xor ah, ah
E801  50              push ax
E802  8B 7E 04        mov di, word ptr [bp + 4]
E805  36 8A 45 FA     mov al, byte ptr ss:[di - 6]
E809  30 E4           xor ah, ah
E80B  50              push ax
E80C  36 8A 45 FB     mov al, byte ptr ss:[di - 5]
E810  30 E4           xor ah, ah
E812  50              push ax
E813  9A 97 18 94 19  call far 1994:1897
E818  C4 7E FC        les di, ptr [bp - 4]
E81B  26 80 3D 00     cmp byte ptr es:[di], 0
E81F  75 1C           jne 0xe83d
E821  8B 7E 04        mov di, word ptr [bp + 4]
E824  36 8B 7D FE     mov di, word ptr ss:[di - 2]
E828  8A 85 FB D4     mov al, byte ptr [di - 0x2b05]
E82C  30 E4           xor ah, ah
E82E  50              push ax
E82F  8B 7E 04        mov di, word ptr [bp + 4]
E832  36 FF 75 06     push word ptr ss:[di + 6]
E836  9A 61 22 51 1B  call far 1B51:2261
E83B  EB 33           jmp 0xe870
loc_E83D:
E83D  C4 7E FC        les di, ptr [bp - 4]
E840  26 80 3D 06     cmp byte ptr es:[di], 6
E844  75 2A           jne 0xe870
E846  8B 7E 04        mov di, word ptr [bp + 4]
E849  36 FF 75 06     push word ptr ss:[di + 6]
E84D  9A F8 16 51 1B  call far 1B51:16F8
E852  08 C0           or al, al
E854  74 1A           je 0xe870
E856  8B 7E 04        mov di, word ptr [bp + 4]
E859  36 8B 7D FE     mov di, word ptr ss:[di - 2]
E85D  8A 85 FB D4     mov al, byte ptr [di - 0x2b05]
E861  30 E4           xor ah, ah
E863  50              push ax
E864  8B 7E 04        mov di, word ptr [bp + 4]
E867  36 FF 75 06     push word ptr ss:[di + 6]
E86B  9A 23 24 51 1B  call far 1B51:2423
loc_E870:
E870  C9              leave
E871  C2 02 00        ret 2

