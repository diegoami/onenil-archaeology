; 1-095.EXE (One-Nil 95), code segment 0AB5 (image offsets 0AB50..1993F), part 1 of 22
; packed 1-095.EXE sha256 f659fb2d334500d6901fc8d6a0f06c85c0ccda2eb4a3035ae3bb0a0004d79192 (LZEXE 0.91)
; unpacked (tools/static/unlzexe.py) sha256 8df646e017e0965a5d90a58181ca764219ad847833aad0b6cb58fc53372bfb2c
; tool: capstone 5.0.9 (pip package; core library 5.0.1280) (CS_ARCH_X86, CS_MODE_16), recursive descent from the entry point, far calls and near calls/jumps, then routine prologues (55 89 E5 / 55 8B EC / C8 iw 00) in what remains; tools/static/listing.py
; addresses are SEGMENT:OFFSET with SEGMENT the image paragraph before relocation; image offset = SEGMENT*16+OFFSET

; ---- routine 0AB5:0000  (found by: call)
sub_0000:
0000  C8 02 00 00     enter 2, 0
0004  83 7E 04 01     cmp word ptr [bp + 4], 1
0008  74 0A           je 0x14
000A  83 7E 04 0C     cmp word ptr [bp + 4], 0xc
000E  74 04           je 0x14
0010  B0 00           mov al, 0
0012  EB 02           jmp 0x16
loc_0014:
0014  B0 01           mov al, 1
loc_0016:
0016  88 46 FF        mov byte ptr [bp - 1], al
0019  8A 46 FF        mov al, byte ptr [bp - 1]
001C  C9              leave
001D  C2 02 00        ret 2

; ---- routine 0AB5:0020  (found by: call)
sub_0020:
0020  55              push bp
0021  89 E5           mov bp, sp
0023  8B 7E 04        mov di, word ptr [bp + 4]
0026  36 8B 45 04     mov ax, word ptr ss:[di + 4]
002A  05 DC 00        add ax, 0xdc
002D  8B D0           mov dx, ax
002F  8B 46 06        mov ax, word ptr [bp + 6]
0032  D1 E0           shl ax, 1
0034  36 C4 7D F6     les di, ptr ss:[di - 0xa]
0038  03 F8           add di, ax
003A  26 89 55 FE     mov word ptr es:[di - 2], dx
003E  8B 7E 04        mov di, word ptr [bp + 4]
0041  36 8B 45 04     mov ax, word ptr ss:[di + 4]
0045  05 DB 00        add ax, 0xdb
0048  8B D0           mov dx, ax
004A  8B 46 06        mov ax, word ptr [bp + 6]
004D  05 50 00        add ax, 0x50
0050  D1 E0           shl ax, 1
0052  36 C4 7D F6     les di, ptr ss:[di - 0xa]
0056  03 F8           add di, ax
0058  26 89 55 FE     mov word ptr es:[di - 2], dx
005C  C9              leave
005D  C2 04 00        ret 4

; ---- routine 0AB5:0060  (found by: call)
sub_0060:
0060  C8 02 00 00     enter 2, 0
0064  C7 46 FE 01 00  mov word ptr [bp - 2], 1
0069  EB 03           jmp 0x6e
loc_006B:
006B  FF 46 FE        inc word ptr [bp - 2]
loc_006E:
006E  8A 46 08        mov al, byte ptr [bp + 8]
0071  30 E4           xor ah, ah
0073  6B 7E FE 0A     imul di, word ptr [bp - 2], 0xa
0077  03 F8           add di, ax
0079  80 BD DC 08 00  cmp byte ptr [di + 0x8dc], 0
007E  74 4C           je 0xcc
0080  83 7E FE 04     cmp word ptr [bp - 2], 4
0084  73 32           jae 0xb8
0086  8B 46 06        mov ax, word ptr [bp + 6]
0089  8B 7E FE        mov di, word ptr [bp - 2]
008C  D1 E7           shl di, 1
008E  03 85 5A 09     add ax, word ptr [di + 0x95a]
0092  40              inc ax
0093  D1 E0           shl ax, 1
0095  8B 7E 04        mov di, word ptr [bp + 4]
0098  36 C4 7D F6     les di, ptr ss:[di - 0xa]
009C  03 F8           add di, ax
009E  81 C7 FE FF     add di, 0xfffe
00A2  06              push es
00A3  57              push di
00A4  6A 04           push 4
00A6  8B 7E 04        mov di, word ptr [bp + 4]
00A9  36 8B 45 04     mov ax, word ptr ss:[di + 4]
00AD  05 DF 00        add ax, 0xdf
00B0  50              push ax
00B1  9A 6C 02 1A 23  call far 231A:026C
00B6  EB 14           jmp 0xcc
loc_00B8:
00B8  8B 46 06        mov ax, word ptr [bp + 6]
00BB  8B 7E FE        mov di, word ptr [bp - 2]
00BE  D1 E7           shl di, 1
00C0  03 85 5A 09     add ax, word ptr [di + 0x95a]
00C4  50              push ax
00C5  8B 7E 04        mov di, word ptr [bp + 4]
00C8  57              push di
00C9  E8 54 FF        call 0x20
loc_00CC:
00CC  83 7E FE 07     cmp word ptr [bp - 2], 7
00D0  75 99           jne 0x6b
00D2  C9              leave
00D3  C2 06 00        ret 6

; ---- routine 0AB5:00D6  (found by: call)
sub_00D6:
00D6  C8 0C 01 00     enter 0x10c, 0
00DA  C4 3E 58 DD     les di, ptr [0xdd58]
00DE  89 F8           mov ax, di
00E0  8C C2           mov dx, es
00E2  89 46 F6        mov word ptr [bp - 0xa], ax
00E5  89 56 F8        mov word ptr [bp - 8], dx
00E8  8B 46 04        mov ax, word ptr [bp + 4]
00EB  C1 E0 08        shl ax, 8
00EE  89 46 04        mov word ptr [bp + 4], ax
00F1  BF DE 19        mov di, 0x19de
00F4  1E              push ds
00F5  57              push di
00F6  BF 58 DD        mov di, 0xdd58
00F9  1E              push ds
00FA  57              push di
00FB  9A 2F 05 1A 23  call far 231A:052F
0100  8D BE F4 FE     lea di, [bp - 0x10c]
0104  16              push ss
0105  57              push di
0106  8B 46 06        mov ax, word ptr [bp + 6]
0109  31 D2           xor dx, dx
010B  52              push dx
010C  50              push ax
010D  9A C9 07 1A 23  call far 231A:07C9
0112  8D 7E FA        lea di, [bp - 6]
0115  16              push ss
0116  57              push di
0117  6A 05           push 5
0119  9A 6D 0B B9 26  call far 26B9:0B6D
011E  80 7E FA 02     cmp byte ptr [bp - 6], 2
0122  75 0A           jne 0x12e
0124  8A 46 FB        mov al, byte ptr [bp - 5]
0127  50              push ax
0128  6A 1D           push 0x1d
012A  55              push bp
012B  E8 32 FF        call 0x60
loc_012E:
012E  8A 46 FA        mov al, byte ptr [bp - 6]
0131  30 E4           xor ah, ah
0133  8B F8           mov di, ax
0135  8A 43 FA        mov al, byte ptr [bp + di - 6]
0138  50              push ax
0139  6A 23           push 0x23
013B  55              push bp
013C  E8 21 FF        call 0x60
013F  C9              leave
0140  C2 04 00        ret 4

; ---- routine 0AB5:0143  (found by: call)
sub_0143:
0143  C8 06 00 00     enter 6, 0
0147  C4 7E 06        les di, ptr [bp + 6]
014A  06              push es
014B  57              push di
014C  0E              push cs
014D  E8 7C 1D        call 0x1ecc
0150  3C FF           cmp al, 0xff
0152  B0 00           mov al, 0
0154  75 01           jne 0x157
0156  40              inc ax
loc_0157:
0157  88 46 FD        mov byte ptr [bp - 3], al
015A  8A 46 FD        mov al, byte ptr [bp - 3]
015D  98              cwde
015E  8B F8           mov di, ax
0160  8A 85 6A 09     mov al, byte ptr [di + 0x96a]
0164  30 E4           xor ah, ah
0166  89 46 FA        mov word ptr [bp - 6], ax
0169  8A 46 0B        mov al, byte ptr [bp + 0xb]
016C  3A 46 0D        cmp al, byte ptr [bp + 0xd]
016F  74 49           je 0x1ba
0171  C4 7E 06        les di, ptr [bp + 6]
0174  06              push es
0175  57              push di
0176  0E              push cs
0177  E8 52 1D        call 0x1ecc
017A  98              cwde
017B  8B D0           mov dx, ax
017D  8A 46 0B        mov al, byte ptr [bp + 0xb]
0180  98              cwde
0181  F7 E2           mul dx
0183  50              push ax
0184  C4 7E 06        les di, ptr [bp + 6]
0187  06              push es
0188  57              push di
0189  0E              push cs
018A  E8 3F 1D        call 0x1ecc
018D  98              cwde
018E  8B D0           mov dx, ax
0190  8A 46 0D        mov al, byte ptr [bp + 0xd]
0193  98              cwde
0194  F7 E2           mul dx
0196  5A              pop dx
0197  3B C2           cmp ax, dx
0199  B0 00           mov al, 0
019B  7E 01           jle 0x19e
019D  40              inc ax
loc_019E:
019E  3A 46 FD        cmp al, byte ptr [bp - 3]
01A1  B0 00           mov al, 0
01A3  75 01           jne 0x1a6
01A5  40              inc ax
loc_01A6:
01A6  88 46 FD        mov byte ptr [bp - 3], al
01A9  8A 46 FD        mov al, byte ptr [bp - 3]
01AC  98              cwde
01AD  8B F8           mov di, ax
01AF  8A 85 6A 09     mov al, byte ptr [di + 0x96a]
01B3  30 E4           xor ah, ah
01B5  89 46 FA        mov word ptr [bp - 6], ax
01B8  EB 12           jmp 0x1cc
loc_01BA:
01BA  8A 46 0A        mov al, byte ptr [bp + 0xa]
01BD  3A 46 0C        cmp al, byte ptr [bp + 0xc]
01C0  74 0A           je 0x1cc
01C2  A0 6B 09        mov al, byte ptr [0x96b]
01C5  30 E4           xor ah, ah
01C7  40              inc ax
01C8  40              inc ax
01C9  89 46 FA        mov word ptr [bp - 6], ax
loc_01CC:
01CC  83 46 FA 06     add word ptr [bp - 6], 6
01D0  C4 7E 06        les di, ptr [bp + 6]
01D3  26 8A 45 06     mov al, byte ptr es:[di + 6]
01D7  30 E4           xor ah, ah
01D9  03 46 FA        add ax, word ptr [bp - 6]
01DC  89 46 FE        mov word ptr [bp - 2], ax
01DF  8A 46 0A        mov al, byte ptr [bp + 0xa]
01E2  3A 46 0C        cmp al, byte ptr [bp + 0xc]
01E5  75 08           jne 0x1ef
01E7  8A 46 0B        mov al, byte ptr [bp + 0xb]
01EA  3A 46 0D        cmp al, byte ptr [bp + 0xd]
01ED  74 11           je 0x200
loc_01EF:
01EF  C4 7E 06        les di, ptr [bp + 6]
01F2  26 80 7D 06 00  cmp byte ptr es:[di + 6], 0
01F7  B0 00           mov al, 0
01F9  75 01           jne 0x1fc
01FB  40              inc ax
loc_01FC:
01FC  26 88 45 06     mov byte ptr es:[di + 6], al
loc_0200:
0200  8B 46 FE        mov ax, word ptr [bp - 2]
0203  C9              leave
0204  CA 08 00        retf 8

; ---- routine 0AB5:0207  (found by: call)
sub_0207:
0207  C8 02 00 00     enter 2, 0
020B  C4 3E C0 D0     les di, ptr [0xd0c0]
020F  26 8A 05        mov al, byte ptr es:[di]
0212  3C 00           cmp al, 0
0214  75 1A           jne 0x230
0216  8B 7E 04        mov di, word ptr [bp + 4]
0219  36 C4 7D 06     les di, ptr ss:[di + 6]
021D  26 FF 35        push word ptr es:[di]
0220  26 FF 75 02     push word ptr es:[di + 2]
0224  06              push es
0225  57              push di
0226  0E              push cs
0227  E8 19 FF        call 0x143
022A  88 46 FF        mov byte ptr [bp - 1], al
022D  E9 A0 00        jmp 0x2d0
loc_0230:
0230  3C 01           cmp al, 1
0232  75 26           jne 0x25a
0234  8B 7E 04        mov di, word ptr [bp + 4]
0237  36 6B 7D FE 19  imul di, word ptr ss:[di - 2], 0x19
023C  8B 85 FD CC     mov ax, word ptr [di - 0x3303]
0240  C1 E0 03        shl ax, 3
0243  C4 3E BA D7     les di, ptr [0xd7ba]
0247  03 F8           add di, ax
0249  26 8A 45 06     mov al, byte ptr es:[di + 6]
024D  30 E4           xor ah, ah
024F  8B F8           mov di, ax
0251  8A 85 16 87     mov al, byte ptr [di - 0x78ea]
0255  88 46 FF        mov byte ptr [bp - 1], al
0258  EB 76           jmp 0x2d0
loc_025A:
025A  3C 02           cmp al, 2
025C  75 3B           jne 0x299
025E  A0 AC D0        mov al, byte ptr [0xd0ac]
0261  98              cwde
0262  99              cdq
0263  8B C8           mov cx, ax
0265  8B DA           mov bx, dx
0267  A1 AE D0        mov ax, word ptr [0xd0ae]
026A  31 D2           xor dx, dx
026C  3B D3           cmp dx, bx
026E  7F 0A           jg 0x27a
0270  7C 04           jl 0x276
0272  3B C1           cmp ax, cx
0274  77 04           ja 0x27a
loc_0276:
0276  B0 00           mov al, 0
0278  EB 02           jmp 0x27c
loc_027A:
027A  B0 01           mov al, 1
loc_027C:
027C  8A D0           mov dl, al
027E  8B 7E 04        mov di, word ptr [bp + 4]
0281  36 83 7D FE 0C  cmp word ptr ss:[di - 2], 0xc
0286  B0 00           mov al, 0
0288  73 01           jae 0x28b
028A  40              inc ax
loc_028B:
028B  32 C2           xor al, dl
028D  98              cwde
028E  8B F8           mov di, ax
0290  8A 85 6E 09     mov al, byte ptr [di + 0x96e]
0294  88 46 FF        mov byte ptr [bp - 1], al
0297  EB 37           jmp 0x2d0
loc_0299:
0299  3C 03           cmp al, 3
029B  75 19           jne 0x2b6
029D  8B 7E 04        mov di, word ptr [bp + 4]
02A0  36 83 7D FE 0C  cmp word ptr ss:[di - 2], 0xc
02A5  B0 00           mov al, 0
02A7  73 01           jae 0x2aa
02A9  40              inc ax
loc_02AA:
02AA  98              cwde
02AB  8B F8           mov di, ax
02AD  8A 85 6C 09     mov al, byte ptr [di + 0x96c]
02B1  88 46 FF        mov byte ptr [bp - 1], al
02B4  EB 1A           jmp 0x2d0
loc_02B6:
02B6  3C 04           cmp al, 4
02B8  75 16           jne 0x2d0
02BA  8B 7E 04        mov di, word ptr [bp + 4]
02BD  36 8B 45 FE     mov ax, word ptr ss:[di - 2]
02C1  48              dec ax
02C2  31 D2           xor dx, dx
02C4  B9 0B 00        mov cx, 0xb
02C7  F7 F1           div cx
02C9  92              xchg dx, ax
02CA  05 2F 00        add ax, 0x2f
02CD  88 46 FF        mov byte ptr [bp - 1], al
loc_02D0:
02D0  8A 46 FF        mov al, byte ptr [bp - 1]
02D3  C9              leave
02D4  C2 02 00        ret 2

; ---- routine 0AB5:02D7  (found by: call)
sub_02D7:
02D7  C8 02 00 00     enter 2, 0
02DB  C4 7E 06        les di, ptr [bp + 6]
02DE  26 8A 45 07     mov al, byte ptr es:[di + 7]
02E2  30 E4           xor ah, ah
02E4  89 46 FE        mov word ptr [bp - 2], ax
02E7  26 8A 45 07     mov al, byte ptr es:[di + 7]
02EB  30 E4           xor ah, ah
02ED  50              push ax
02EE  E8 0F FD        call 0
02F1  08 C0           or al, al
02F3  74 1F           je 0x314
02F5  C4 7E 06        les di, ptr [bp + 6]
02F8  06              push es
02F9  57              push di
02FA  0E              push cs
02FB  E8 BD 19        call 0x1cbb
02FE  98              cwde
02FF  8B F8           mov di, ax
0301  8A 85 CA D0     mov al, byte ptr [di - 0x2f36]
0305  30 E4           xor ah, ah
0307  C1 E0 08        shl ax, 8
030A  40              inc ax
030B  C4 7E 06        les di, ptr [bp + 6]
030E  26 89 45 04     mov word ptr es:[di + 4], ax
0312  EB 26           jmp 0x33a
loc_0314:
0314  55              push bp
0315  E8 EF FE        call 0x207
0318  30 E4           xor ah, ah
031A  50              push ax
031B  C4 7E 06        les di, ptr [bp + 6]
031E  06              push es
031F  57              push di
0320  0E              push cs
0321  E8 97 19        call 0x1cbb
0324  98              cwde
0325  8B F8           mov di, ax
0327  8A 85 C8 D0     mov al, byte ptr [di - 0x2f38]
032B  30 E4           xor ah, ah
032D  C1 E0 08        shl ax, 8
0330  5A              pop dx
0331  03 C2           add ax, dx
0333  C4 7E 06        les di, ptr [bp + 6]
0336  26 89 45 04     mov word ptr es:[di + 4], ax
loc_033A:
033A  C9              leave
033B  CA 04 00        retf 4

; ---- routine 0AB5:033E  (found by: call)
sub_033E:
033E  C8 02 00 00     enter 2, 0
0342  C6 46 FF 00     mov byte ptr [bp - 1], 0
0346  EB 03           jmp 0x34b
loc_0348:
0348  FE 46 FF        inc byte ptr [bp - 1]
loc_034B:
034B  8A 46 FF        mov al, byte ptr [bp - 1]
034E  98              cwde
034F  6B F8 07        imul di, ax, 7
0352  FF B5 2E CF     push word ptr [di - 0x30d2]
0356  8A 46 FF        mov al, byte ptr [bp - 1]
0359  98              cwde
035A  6B F8 07        imul di, ax, 7
035D  FF B5 30 CF     push word ptr [di - 0x30d0]
0361  E8 72 19        call 0x1cd6
0364  98              cwde
0365  8B F8           mov di, ax
0367  8A 85 56 0D     mov al, byte ptr [di + 0xd56]
036B  30 E4           xor ah, ah
036D  40              inc ax
036E  6B F8 19        imul di, ax, 0x19
0371  81 C7 EF CC     add di, 0xccef
0375  1E              push ds
0376  57              push di
0377  0E              push cs
0378  E8 C8 FD        call 0x143
037B  05 00 05        add ax, 0x500
037E  8B D0           mov dx, ax
0380  8A 46 FF        mov al, byte ptr [bp - 1]
0383  98              cwde
0384  6B F8 07        imul di, ax, 7
0387  89 95 32 CF     mov word ptr [di - 0x30ce], dx
038B  80 7E FF 01     cmp byte ptr [bp - 1], 1
038F  75 B7           jne 0x348
0391  FF 36 3C CF     push word ptr [0xcf3c]
0395  FF 36 3E CF     push word ptr [0xcf3e]
0399  E8 3A 19        call 0x1cd6
039C  98              cwde
039D  8B F8           mov di, ax
039F  8A 85 56 0D     mov al, byte ptr [di + 0xd56]
03A3  30 E4           xor ah, ah
03A5  40              inc ax
03A6  6B F8 19        imul di, ax, 0x19
03A9  81 C7 EF CC     add di, 0xccef
03AD  1E              push ds
03AE  57              push di
03AF  0E              push cs
03B0  E8 90 FD        call 0x143
03B3  05 00 05        add ax, 0x500
03B6  A3 40 CF        mov word ptr [0xcf40], ax
03B9  C9              leave
03BA  C3              ret

; ---- routine 0AB5:03BB  (found by: call)
sub_03BB:
03BB  C8 02 00 00     enter 2, 0
03BF  C7 46 FE 01 00  mov word ptr [bp - 2], 1
03C4  EB 03           jmp 0x3c9
loc_03C6:
03C6  FF 46 FE        inc word ptr [bp - 2]
loc_03C9:
03C9  6B 7E FE 19     imul di, word ptr [bp - 2], 0x19
03CD  81 C7 EF CC     add di, 0xccef
03D1  1E              push ds
03D2  57              push di
03D3  0E              push cs
03D4  E8 00 FF        call 0x2d7
03D7  83 7E FE 16     cmp word ptr [bp - 2], 0x16
03DB  75 E9           jne 0x3c6
03DD  E8 5E FF        call 0x33e
03E0  C9              leave
03E1  C3              ret
; data (not reached as code), 2 bytes
03E2                  db 01 20   ; . 

; ---- routine 0AB5:03E4  (found by: call)
sub_03E4:
03E4  C8 28 02 00     enter 0x228, 0
03E8  8B 7E 06        mov di, word ptr [bp + 6]
03EB  D1 E7           shl di, 1
03ED  8B F7           mov si, di
03EF  D1 E7           shl di, 1
03F1  01 F7           add di, si
03F3  81 C7 2A A5     add di, 0xa52a
03F7  1E              push ds
03F8  07              pop es
03F9  89 7E D8        mov word ptr [bp - 0x28], di
03FC  8C 46 DA        mov word ptr [bp - 0x26], es
03FF  26 8A 05        mov al, byte ptr es:[di]
0402  98              cwde
0403  6B F8 15        imul di, ax, 0x15
0406  81 C7 82 03     add di, 0x382
040A  1E              push ds
040B  57              push di
040C  8D 7E DC        lea di, [bp - 0x24]
040F  16              push ss
0410  57              push di
0411  6A 23           push 0x23
0413  9A 6D 0B B9 26  call far 26B9:0B6D
0418  80 7E DC 00     cmp byte ptr [bp - 0x24], 0
041C  75 03           jne 0x421
041E  E9 CC 00        jmp 0x4ed
loc_0421:
0421  80 7E DD 01     cmp byte ptr [bp - 0x23], 1
0425  75 2C           jne 0x453
0427  C6 46 DD 20     mov byte ptr [bp - 0x23], 0x20
042B  8D BE D8 FE     lea di, [bp - 0x128]
042F  16              push ss
0430  57              push di
0431  C4 7E D8        les di, ptr [bp - 0x28]
0434  26 FF 75 01     push word ptr es:[di + 1]
0438  9A 3C 44 51 1B  call far 1B51:443C
043D  8D 7E DC        lea di, [bp - 0x24]
0440  16              push ss
0441  57              push di
0442  9A D2 0B B9 26  call far 26B9:0BD2
0447  8D 7E DC        lea di, [bp - 0x24]
044A  16              push ss
044B  57              push di
044C  6A 23           push 0x23
044E  9A 6D 0B B9 26  call far 26B9:0B6D
loc_0453:
0453  8A 46 DC        mov al, byte ptr [bp - 0x24]
0456  30 E4           xor ah, ah
0458  8B F8           mov di, ax
045A  80 7B DC 01     cmp byte ptr [bp + di - 0x24], 1
045E  75 40           jne 0x4a0
0460  FE 4E DC        dec byte ptr [bp - 0x24]
0463  8D BE D8 FE     lea di, [bp - 0x128]
0467  16              push ss
0468  57              push di
0469  8D 7E DC        lea di, [bp - 0x24]
046C  16              push ss
046D  57              push di
046E  9A 53 0B B9 26  call far 26B9:0B53
0473  BF E2 03        mov di, 0x3e2
0476  0E              push cs
0477  57              push di
0478  9A D2 0B B9 26  call far 26B9:0BD2
047D  8D BE D8 FD     lea di, [bp - 0x228]
0481  16              push ss
0482  57              push di
0483  C4 7E D8        les di, ptr [bp - 0x28]
0486  26 FF 75 01     push word ptr es:[di + 1]
048A  9A 3C 44 51 1B  call far 1B51:443C
048F  9A D2 0B B9 26  call far 26B9:0BD2
0494  8D 7E DC        lea di, [bp - 0x24]
0497  16              push ss
0498  57              push di
0499  6A 23           push 0x23
049B  9A 6D 0B B9 26  call far 26B9:0B6D
loc_04A0:
04A0  8A 46 DC        mov al, byte ptr [bp - 0x24]
04A3  30 E4           xor ah, ah
04A5  8B F8           mov di, ax
04A7  80 7B DC 02     cmp byte ptr [bp + di - 0x24], 2
04AB  75 40           jne 0x4ed
04AD  FE 4E DC        dec byte ptr [bp - 0x24]
04B0  8D BE D8 FE     lea di, [bp - 0x128]
04B4  16              push ss
04B5  57              push di
04B6  8D 7E DC        lea di, [bp - 0x24]
04B9  16              push ss
04BA  57              push di
04BB  9A 53 0B B9 26  call far 26B9:0B53
04C0  BF E2 03        mov di, 0x3e2
04C3  0E              push cs
04C4  57              push di
04C5  9A D2 0B B9 26  call far 26B9:0BD2
04CA  8D BE D8 FD     lea di, [bp - 0x228]
04CE  16              push ss
04CF  57              push di
04D0  C4 7E D8        les di, ptr [bp - 0x28]
04D3  26 FF 75 03     push word ptr es:[di + 3]
04D7  9A 3C 44 51 1B  call far 1B51:443C
04DC  9A D2 0B B9 26  call far 26B9:0BD2
04E1  8D 7E DC        lea di, [bp - 0x24]
04E4  16              push ss
04E5  57              push di
04E6  6A 23           push 0x23
04E8  9A 6D 0B B9 26  call far 26B9:0B6D
loc_04ED:
04ED  8D 7E DC        lea di, [bp - 0x24]
04F0  16              push ss
04F1  57              push di
04F2  C4 7E 08        les di, ptr [bp + 8]
04F5  06              push es
04F6  57              push di
04F7  6A 23           push 0x23
04F9  9A 6D 0B B9 26  call far 26B9:0B6D
04FE  C9              leave
04FF  C2 04 00        ret 4
; data (not reached as code), 117 bytes
0502                  pstr 'Do you want to print the match commentary'
052C                  pstr 'Printing.....'
053A                  pstr ' versus '
0543                  pstr ' - '
0547                  pstr 'FINAL SCORE: '
0555                  db 01 20   ; . 
0557                  pstr "something's up with the printer"

; ---- routine 0AB5:0577  (found by: call)
sub_0577:
0577  C8 0A 04 00     enter 0x40a, 0
057B  9A 6D 12 AC 24  call far 24AC:126D
0580  08 C0           or al, al
0582  75 11           jne 0x595
0584  BF 02 05        mov di, 0x502
0587  0E              push cs
0588  57              push di
0589  9A E5 06 1A 23  call far 231A:06E5
058E  08 C0           or al, al
0590  75 03           jne 0x595
0592  E9 24 04        jmp 0x9b9
loc_0595:
0595  6A 19           push 0x19
0597  BF 2C 05        mov di, 0x52c
059A  0E              push cs
059B  57              push di
059C  BF 58 DD        mov di, 0xdd58
059F  1E              push ds
05A0  57              push di
05A1  9A 55 05 1A 23  call far 231A:0555
05A6  31 C0           xor ax, ax
05A8  A3 02 DF        mov word ptr [0xdf02], ax
05AB  A1 04 DF        mov ax, word ptr [0xdf04]
05AE  89 46 FE        mov word ptr [bp - 2], ax
05B1  C7 06 04 DF 04 00 mov word ptr [0xdf04], 4
05B7  BF 70 09        mov di, 0x970
05BA  1E              push ds
05BB  57              push di
05BC  6A 02           push 2
05BE  9A E3 11 1A 23  call far 231A:11E3
05C3  88 46 FA        mov byte ptr [bp - 6], al
05C6  8D BE F6 FD     lea di, [bp - 0x20a]
05CA  16              push ss
05CB  57              push di
05CC  A1 E6 D6        mov ax, word ptr [0xd6e6]
05CF  C1 E0 04        shl ax, 4
05D2  C4 3E B2 D7     les di, ptr [0xd7b2]
05D6  03 F8           add di, ax
05D8  81 C7 F0 FF     add di, 0xfff0
05DC  06              push es
05DD  57              push di
05DE  9A 53 0B B9 26  call far 26B9:0B53
05E3  BF 3A 05        mov di, 0x53a
05E6  0E              push cs
05E7  57              push di
05E8  9A D2 0B B9 26  call far 26B9:0BD2
05ED  A1 E4 D6        mov ax, word ptr [0xd6e4]
05F0  C1 E0 04        shl ax, 4
05F3  C4 3E B2 D7     les di, ptr [0xd7b2]
05F7  03 F8           add di, ax
05F9  81 C7 F0 FF     add di, 0xfff0
05FD  06              push es
05FE  57              push di
05FF  9A D2 0B B9 26  call far 26B9:0BD2
0604  8D BE F6 FC     lea di, [bp - 0x30a]
0608  16              push ss
0609  57              push di
060A  BF 70 09        mov di, 0x970
060D  1E              push ds
060E  57              push di
060F  6A 02           push 2
0611  9A 81 0C B9 26  call far 26B9:0C81
0616  9A D2 0B B9 26  call far 26B9:0BD2
061B  8D BE 78 FF     lea di, [bp - 0x88]
061F  16              push ss
0620  57              push di
0621  68 80 00        push 0x80
0624  9A 6D 0B B9 26  call far 26B9:0B6D
0629  8D BE 79 FF     lea di, [bp - 0x87]
062D  16              push ss
062E  57              push di
062F  8A 86 78 FF     mov al, byte ptr [bp - 0x88]
0633  30 E4           xor ah, ah
0635  50              push ax
0636  9A E3 11 1A 23  call far 231A:11E3
063B  88 46 FA        mov byte ptr [bp - 6], al
063E  8D BE F6 FC     lea di, [bp - 0x30a]
0642  16              push ss
0643  57              push di
0644  8D BE F6 FD     lea di, [bp - 0x20a]
0648  16              push ss
0649  57              push di
064A  C4 3E D2 D7     les di, ptr [0xd7d2]
064E  26 8A 05        mov al, byte ptr es:[di]
0651  30 E4           xor ah, ah
0653  8B F0           mov si, ax
0655  D1 E0           shl ax, 1
0657  01 F0           add ax, si
0659  8B D0           mov dx, ax
065B  69 06 E6 D6 AE 00 imul ax, word ptr [0xd6e6], 0xae
0661  C4 3E CA D7     les di, ptr [0xd7ca]
0665  03 F8           add di, ax
0667  03 FA           add di, dx
0669  26 8A 85 4F FF  mov al, byte ptr es:[di - 0xb1]
066E  50              push ax
066F  C4 3E D2 D7     les di, ptr [0xd7d2]
0673  26 8A 05        mov al, byte ptr es:[di]
0676  50              push ax
0677  9A 8B 13 51 1B  call far 1B51:138B
067C  9A 5A 00 AC 24  call far 24AC:005A
0681  8D BE F6 FB     lea di, [bp - 0x40a]
0685  16              push ss
0686  57              push di
0687  BF 70 09        mov di, 0x970
068A  1E              push ds
068B  57              push di
068C  6A 02           push 2
068E  9A 81 0C B9 26  call far 26B9:0C81
0693  9A D2 0B B9 26  call far 26B9:0BD2
0698  8D BE 78 FF     lea di, [bp - 0x88]
069C  16              push ss
069D  57              push di
069E  68 80 00        push 0x80
06A1  9A 6D 0B B9 26  call far 26B9:0B6D
06A6  8D BE 79 FF     lea di, [bp - 0x87]
06AA  16              push ss
06AB  57              push di
06AC  8A 86 78 FF     mov al, byte ptr [bp - 0x88]
06B0  30 E4           xor ah, ah
06B2  50              push ax
06B3  9A E3 11 1A 23  call far 231A:11E3
06B8  08 C0           or al, al
06BA  74 10           je 0x6cc
06BC  BF 70 09        mov di, 0x970
06BF  1E              push ds
06C0  57              push di
06C1  6A 02           push 2
06C3  9A E3 11 1A 23  call far 231A:11E3
06C8  08 C0           or al, al
06CA  75 04           jne 0x6d0
loc_06CC:
06CC  B0 00           mov al, 0
06CE  EB 02           jmp 0x6d2
loc_06D0:
06D0  B0 01           mov al, 1
loc_06D2:
06D2  88 46 FA        mov byte ptr [bp - 6], al
06D5  C6 86 78 FF 00  mov byte ptr [bp - 0x88], 0
06DA  A1 80 03        mov ax, word ptr [0x380]
06DD  89 86 F4 FE     mov word ptr [bp - 0x10c], ax
06E1  B8 01 00        mov ax, 1
06E4  3B 86 F4 FE     cmp ax, word ptr [bp - 0x10c]
06E8  76 03           jbe 0x6ed
06EA  E9 D0 01        jmp 0x8bd
loc_06ED:
06ED  89 46 FC        mov word ptr [bp - 4], ax
06F0  EB 03           jmp 0x6f5
loc_06F2:
06F2  FF 46 FC        inc word ptr [bp - 4]
loc_06F5:
06F5  8B 7E FC        mov di, word ptr [bp - 4]
06F8  D1 E7           shl di, 1
06FA  8B F7           mov si, di
06FC  D1 E7           shl di, 1
06FE  01 F7           add di, si
0700  81 C7 2A A5     add di, 0xa52a
0704  1E              push ds
0705  07              pop es
0706  26 80 3D FF     cmp byte ptr es:[di], 0xff
070A  75 08           jne 0x714
070C  C7 46 FC A4 06  mov word ptr [bp - 4], 0x6a4
0711  E9 9D 01        jmp 0x8b1
loc_0714:
0714  8D BE F0 FC     lea di, [bp - 0x310]
0718  16              push ss
0719  57              push di
071A  8D BE 78 FF     lea di, [bp - 0x88]
071E  16              push ss
071F  57              push di
0720  9A 53 0B B9 26  call far 26B9:0B53
0725  8D BE F0 FD     lea di, [bp - 0x210]
0729  16              push ss
072A  57              push di
072B  FF 76 FC        push word ptr [bp - 4]
072E  55              push bp
072F  E8 B2 FC        call 0x3e4
0732  9A D2 0B B9 26  call far 26B9:0BD2
0737  8D BE 78 FF     lea di, [bp - 0x88]
073B  16              push ss
073C  57              push di
073D  68 80 00        push 0x80
0740  9A 6D 0B B9 26  call far 26B9:0B6D
0745  A1 80 03        mov ax, word ptr [0x380]
0748  99              cdq
0749  8B C8           mov cx, ax
074B  8B DA           mov bx, dx
074D  8B 46 FC        mov ax, word ptr [bp - 4]
0750  31 D2           xor dx, dx
0752  3B D3           cmp dx, bx
0754  7C 06           jl 0x75c
0756  7F 2D           jg 0x785
0758  3B C1           cmp ax, cx
075A  73 29           jae 0x785
loc_075C:
075C  8D BE F0 FD     lea di, [bp - 0x210]
0760  16              push ss
0761  57              push di
0762  8D BE 78 FF     lea di, [bp - 0x88]
0766  16              push ss
0767  57              push di
0768  9A 53 0B B9 26  call far 26B9:0B53
076D  BF 43 05        mov di, 0x543
0770  0E              push cs
0771  57              push di
0772  9A D2 0B B9 26  call far 26B9:0BD2
0777  8D BE 78 FF     lea di, [bp - 0x88]
077B  16              push ss
077C  57              push di
077D  68 80 00        push 0x80
0780  9A 6D 0B B9 26  call far 26B9:0B6D
loc_0785:
0785  80 BE 78 FF 48  cmp byte ptr [bp - 0x88], 0x48
078A  73 03           jae 0x78f
078C  E9 BC 00        jmp 0x84b
loc_078F:
078F  C6 46 FB 48     mov byte ptr [bp - 5], 0x48
loc_0793:
0793  8A 46 FB        mov al, byte ptr [bp - 5]
0796  30 E4           xor ah, ah
0798  8B F8           mov di, ax
079A  80 BB 78 FF 20  cmp byte ptr [bp + di - 0x88], 0x20
079F  74 05           je 0x7a6
07A1  FE 4E FB        dec byte ptr [bp - 5]
07A4  EB ED           jmp 0x793
loc_07A6:
07A6  8D BE F0 FD     lea di, [bp - 0x210]
07AA  16              push ss
07AB  57              push di
07AC  8D BE 78 FF     lea di, [bp - 0x88]
07B0  16              push ss
07B1  57              push di
07B2  8A 46 FB        mov al, byte ptr [bp - 5]
07B5  30 E4           xor ah, ah
07B7  40              inc ax
07B8  50              push ax
07B9  8A 46 FB        mov al, byte ptr [bp - 5]
07BC  30 E4           xor ah, ah
07BE  8B D0           mov dx, ax
07C0  8A 86 78 FF     mov al, byte ptr [bp - 0x88]
07C4  30 E4           xor ah, ah
07C6  2B C2           sub ax, dx
07C8  50              push ax
07C9  9A 91 0B B9 26  call far 26B9:0B91
07CE  8D BE F6 FE     lea di, [bp - 0x10a]
07D2  16              push ss
07D3  57              push di
07D4  68 80 00        push 0x80
07D7  9A 6D 0B B9 26  call far 26B9:0B6D
07DC  8A 46 FB        mov al, byte ptr [bp - 5]
07DF  30 E4           xor ah, ah
07E1  48              dec ax
07E2  88 86 78 FF     mov byte ptr [bp - 0x88], al
07E6  8D BE F0 FC     lea di, [bp - 0x310]
07EA  16              push ss
07EB  57              push di
07EC  8D BE 78 FF     lea di, [bp - 0x88]
07F0  16              push ss
07F1  57              push di
07F2  9A 53 0B B9 26  call far 26B9:0B53
07F7  8D BE F0 FD     lea di, [bp - 0x210]
07FB  16              push ss
07FC  57              push di
07FD  BF 70 09        mov di, 0x970
0800  1E              push ds
0801  57              push di
0802  6A 02           push 2
0804  9A 81 0C B9 26  call far 26B9:0C81
0809  9A D2 0B B9 26  call far 26B9:0BD2
080E  8D BE 78 FF     lea di, [bp - 0x88]
0812  16              push ss
0813  57              push di
0814  68 80 00        push 0x80
0817  9A 6D 0B B9 26  call far 26B9:0B6D
081C  80 7E FA 00     cmp byte ptr [bp - 6], 0
0820  74 15           je 0x837
0822  8D BE 79 FF     lea di, [bp - 0x87]
0826  16              push ss
0827  57              push di
0828  8A 86 78 FF     mov al, byte ptr [bp - 0x88]
082C  30 E4           xor ah, ah
082E  50              push ax
082F  9A E3 11 1A 23  call far 231A:11E3
0834  88 46 FA        mov byte ptr [bp - 6], al
loc_0837:
0837  8D BE F6 FE     lea di, [bp - 0x10a]
083B  16              push ss
083C  57              push di
083D  8D BE 78 FF     lea di, [bp - 0x88]
0841  16              push ss
0842  57              push di
0843  68 80 00        push 0x80
0846  9A 6D 0B B9 26  call far 26B9:0B6D
loc_084B:
084B  A1 80 03        mov ax, word ptr [0x380]
084E  99              cdq
084F  8B C8           mov cx, ax
0851  8B DA           mov bx, dx
0853  8B 46 FC        mov ax, word ptr [bp - 4]
0856  31 D2           xor dx, dx
0858  3B D3           cmp dx, bx
085A  75 55           jne 0x8b1
085C  3B C1           cmp ax, cx
085E  75 51           jne 0x8b1
0860  8D BE F0 FC     lea di, [bp - 0x310]
0864  16              push ss
0865  57              push di
0866  8D BE 78 FF     lea di, [bp - 0x88]
086A  16              push ss
086B  57              push di
086C  9A 53 0B B9 26  call far 26B9:0B53
0871  8D BE F0 FD     lea di, [bp - 0x210]
0875  16              push ss
0876  57              push di
0877  BF 70 09        mov di, 0x970
087A  1E              push ds
087B  57              push di
087C  6A 02           push 2
087E  9A 81 0C B9 26  call far 26B9:0C81
0883  9A D2 0B B9 26  call far 26B9:0BD2
0888  8D BE 78 FF     lea di, [bp - 0x88]
088C  16              push ss
088D  57              push di
088E  68 80 00        push 0x80
0891  9A 6D 0B B9 26  call far 26B9:0B6D
0896  80 7E FA 00     cmp byte ptr [bp - 6], 0
089A  74 15           je 0x8b1
089C  8D BE 79 FF     lea di, [bp - 0x87]
08A0  16              push ss
08A1  57              push di
08A2  8A 86 78 FF     mov al, byte ptr [bp - 0x88]
08A6  30 E4           xor ah, ah
08A8  50              push ax
08A9  9A E3 11 1A 23  call far 231A:11E3
08AE  88 46 FA        mov byte ptr [bp - 6], al
loc_08B1:
08B1  8B 46 FC        mov ax, word ptr [bp - 4]
08B4  3B 86 F4 FE     cmp ax, word ptr [bp - 0x10c]
08B8  74 03           je 0x8bd
08BA  E9 35 FE        jmp 0x6f2
loc_08BD:
08BD  80 7E FA 00     cmp byte ptr [bp - 6], 0
08C1  74 0F           je 0x8d2
08C3  BF 70 09        mov di, 0x970
08C6  1E              push ds
08C7  57              push di
08C8  6A 02           push 2
08CA  9A E3 11 1A 23  call far 231A:11E3
08CF  88 46 FA        mov byte ptr [bp - 6], al
loc_08D2:
08D2  8D BE F6 FD     lea di, [bp - 0x20a]
08D6  16              push ss
08D7  57              push di
08D8  BF 47 05        mov di, 0x547
08DB  0E              push cs
08DC  57              push di
08DD  9A 53 0B B9 26  call far 26B9:0B53
08E2  A1 E6 D6        mov ax, word ptr [0xd6e6]
08E5  C1 E0 04        shl ax, 4
08E8  C4 3E B2 D7     les di, ptr [0xd7b2]
08EC  03 F8           add di, ax
08EE  81 C7 F0 FF     add di, 0xfff0
08F2  06              push es
08F3  57              push di
08F4  9A D2 0B B9 26  call far 26B9:0BD2
08F9  BF 55 05        mov di, 0x555
08FC  0E              push cs
08FD  57              push di
08FE  9A D2 0B B9 26  call far 26B9:0BD2
0903  8D BE F6 FC     lea di, [bp - 0x30a]
0907  16              push ss
0908  57              push di
0909  A0 C5 D0        mov al, byte ptr [0xd0c5]
090C  30 E4           xor ah, ah
090E  31 D2           xor dx, dx
0910  52              push dx
0911  50              push ax
0912  9A C9 07 1A 23  call far 231A:07C9
0917  9A D2 0B B9 26  call far 26B9:0BD2
091C  BF 55 05        mov di, 0x555
091F  0E              push cs
0920  57              push di
0921  9A D2 0B B9 26  call far 26B9:0BD2
0926  A1 E4 D6        mov ax, word ptr [0xd6e4]
0929  C1 E0 04        shl ax, 4
092C  C4 3E B2 D7     les di, ptr [0xd7b2]
0930  03 F8           add di, ax
0932  81 C7 F0 FF     add di, 0xfff0
0936  06              push es
0937  57              push di
0938  9A D2 0B B9 26  call far 26B9:0BD2
093D  BF 55 05        mov di, 0x555
0940  0E              push cs
0941  57              push di
0942  9A D2 0B B9 26  call far 26B9:0BD2
0947  8D BE F6 FB     lea di, [bp - 0x40a]
094B  16              push ss
094C  57              push di
094D  A0 C4 D0        mov al, byte ptr [0xd0c4]
0950  30 E4           xor ah, ah
0952  31 D2           xor dx, dx
0954  52              push dx
0955  50              push ax
0956  9A C9 07 1A 23  call far 231A:07C9
095B  9A D2 0B B9 26  call far 26B9:0BD2
0960  8D BE 78 FF     lea di, [bp - 0x88]
0964  16              push ss
0965  57              push di
0966  68 80 00        push 0x80
0969  9A 6D 0B B9 26  call far 26B9:0B6D
096E  80 7E FA 00     cmp byte ptr [bp - 6], 0
0972  74 2F           je 0x9a3
0974  8D BE 79 FF     lea di, [bp - 0x87]
0978  16              push ss
0979  57              push di
097A  8A 86 78 FF     mov al, byte ptr [bp - 0x88]
097E  30 E4           xor ah, ah
0980  50              push ax
0981  9A E3 11 1A 23  call far 231A:11E3
0986  08 C0           or al, al
0988  74 10           je 0x99a
098A  BF 72 09        mov di, 0x972
098D  1E              push ds
098E  57              push di
098F  6A 01           push 1
0991  9A E3 11 1A 23  call far 231A:11E3
0996  08 C0           or al, al
0998  75 04           jne 0x99e
loc_099A:
099A  B0 00           mov al, 0
099C  EB 02           jmp 0x9a0
loc_099E:
099E  B0 01           mov al, 1
loc_09A0:
09A0  88 46 FA        mov byte ptr [bp - 6], al
loc_09A3:
09A3  80 7E FA 00     cmp byte ptr [bp - 6], 0
09A7  75 0A           jne 0x9b3
09A9  BF 57 05        mov di, 0x557
09AC  0E              push cs
09AD  57              push di
09AE  9A 02 07 AC 24  call far 24AC:0702
loc_09B3:
09B3  8B 46 FE        mov ax, word ptr [bp - 2]
09B6  A3 04 DF        mov word ptr [0xdf04], ax
loc_09B9:
09B9  C9              leave
09BA  C3              ret
; data (not reached as code), 2 bytes
09BB                  db 01 20   ; . 

; ---- routine 0AB5:09BD  (found by: call)
sub_09BD:
09BD  C8 28 02 00     enter 0x228, 0
09C1  8B 7E 08        mov di, word ptr [bp + 8]
09C4  D1 E7           shl di, 1
09C6  8B F7           mov si, di
09C8  D1 E7           shl di, 1
09CA  01 F7           add di, si
09CC  81 C7 2A A5     add di, 0xa52a
09D0  1E              push ds
09D1  07              pop es
09D2  89 7E D8        mov word ptr [bp - 0x28], di
09D5  8C 46 DA        mov word ptr [bp - 0x26], es
09D8  26 80 3D FF     cmp byte ptr es:[di], 0xff
09DC  75 03           jne 0x9e1
09DE  E9 6E 01        jmp 0xb4f
loc_09E1:
09E1  C4 7E D8        les di, ptr [bp - 0x28]
09E4  26 8A 05        mov al, byte ptr es:[di]
09E7  98              cwde
09E8  6B F8 15        imul di, ax, 0x15
09EB  81 C7 82 03     add di, 0x382
09EF  1E              push ds
09F0  57              push di
09F1  8D 7E DC        lea di, [bp - 0x24]
09F4  16              push ss
09F5  57              push di
09F6  6A 23           push 0x23
09F8  9A 6D 0B B9 26  call far 26B9:0B6D
09FD  80 7E DC 00     cmp byte ptr [bp - 0x24], 0
0A01  75 03           jne 0xa06
0A03  E9 CC 00        jmp 0xad2
loc_0A06:
0A06  80 7E DD 01     cmp byte ptr [bp - 0x23], 1
0A0A  75 2C           jne 0xa38
0A0C  C6 46 DD 20     mov byte ptr [bp - 0x23], 0x20
0A10  8D BE D8 FE     lea di, [bp - 0x128]
0A14  16              push ss
0A15  57              push di
0A16  C4 7E D8        les di, ptr [bp - 0x28]
0A19  26 FF 75 01     push word ptr es:[di + 1]
0A1D  9A 3C 44 51 1B  call far 1B51:443C
0A22  8D 7E DC        lea di, [bp - 0x24]
0A25  16              push ss
0A26  57              push di
0A27  9A D2 0B B9 26  call far 26B9:0BD2
0A2C  8D 7E DC        lea di, [bp - 0x24]
0A2F  16              push ss
0A30  57              push di
0A31  6A 23           push 0x23
0A33  9A 6D 0B B9 26  call far 26B9:0B6D
loc_0A38:
0A38  8A 46 DC        mov al, byte ptr [bp - 0x24]
0A3B  30 E4           xor ah, ah
0A3D  8B F8           mov di, ax
0A3F  80 7B DC 01     cmp byte ptr [bp + di - 0x24], 1
0A43  75 40           jne 0xa85
0A45  FE 4E DC        dec byte ptr [bp - 0x24]
0A48  8D BE D8 FE     lea di, [bp - 0x128]
0A4C  16              push ss
0A4D  57              push di
0A4E  8D 7E DC        lea di, [bp - 0x24]
0A51  16              push ss
0A52  57              push di
0A53  9A 53 0B B9 26  call far 26B9:0B53
0A58  BF BB 09        mov di, 0x9bb
0A5B  0E              push cs
0A5C  57              push di
0A5D  9A D2 0B B9 26  call far 26B9:0BD2
0A62  8D BE D8 FD     lea di, [bp - 0x228]
0A66  16              push ss
0A67  57              push di
0A68  C4 7E D8        les di, ptr [bp - 0x28]
0A6B  26 FF 75 01     push word ptr es:[di + 1]
0A6F  9A 3C 44 51 1B  call far 1B51:443C
0A74  9A D2 0B B9 26  call far 26B9:0BD2
0A79  8D 7E DC        lea di, [bp - 0x24]
0A7C  16              push ss
0A7D  57              push di
0A7E  6A 23           push 0x23
0A80  9A 6D 0B B9 26  call far 26B9:0B6D
loc_0A85:
0A85  8A 46 DC        mov al, byte ptr [bp - 0x24]
0A88  30 E4           xor ah, ah
0A8A  8B F8           mov di, ax
0A8C  80 7B DC 02     cmp byte ptr [bp + di - 0x24], 2
0A90  75 40           jne 0xad2
0A92  FE 4E DC        dec byte ptr [bp - 0x24]
0A95  8D BE D8 FE     lea di, [bp - 0x128]
0A99  16              push ss
0A9A  57              push di
0A9B  8D 7E DC        lea di, [bp - 0x24]
0A9E  16              push ss
0A9F  57              push di
0AA0  9A 53 0B B9 26  call far 26B9:0B53
0AA5  BF BB 09        mov di, 0x9bb
0AA8  0E              push cs
0AA9  57              push di
0AAA  9A D2 0B B9 26  call far 26B9:0BD2
0AAF  8D BE D8 FD     lea di, [bp - 0x228]
0AB3  16              push ss
0AB4  57              push di
0AB5  C4 7E D8        les di, ptr [bp - 0x28]
0AB8  26 FF 75 03     push word ptr es:[di + 3]
0ABC  9A 3C 44 51 1B  call far 1B51:443C
0AC1  9A D2 0B B9 26  call far 26B9:0BD2
0AC6  8D 7E DC        lea di, [bp - 0x24]
0AC9  16              push ss
0ACA  57              push di
0ACB  6A 23           push 0x23
0ACD  9A 6D 0B B9 26  call far 26B9:0B6D
loc_0AD2:
0AD2  80 7E DC 20     cmp byte ptr [bp - 0x24], 0x20
0AD6  73 21           jae 0xaf9
0AD8  8A 46 DC        mov al, byte ptr [bp - 0x24]
0ADB  30 E4           xor ah, ah
0ADD  40              inc ax
0ADE  8B F8           mov di, ax
0AE0  8D 7B DC        lea di, [bp + di - 0x24]
0AE3  16              push ss
0AE4  57              push di
0AE5  8A 46 DC        mov al, byte ptr [bp - 0x24]
0AE8  30 E4           xor ah, ah
0AEA  8B D0           mov dx, ax
0AEC  B8 20 00        mov ax, 0x20
0AEF  2B C2           sub ax, dx
0AF1  50              push ax
0AF2  6A 20           push 0x20
0AF4  9A 22 02 AC 24  call far 24AC:0222
loc_0AF9:
0AF9  C6 46 DC 20     mov byte ptr [bp - 0x24], 0x20
0AFD  C4 7E D8        les di, ptr [bp - 0x28]
0B00  26 8A 45 05     mov al, byte ptr es:[di + 5]
0B04  98              cwde
0B05  8B F8           mov di, ax
0B07  8A 85 C8 D0     mov al, byte ptr [di - 0x2f38]
0B0B  50              push ax
0B0C  8D 7E DC        lea di, [bp - 0x24]
0B0F  16              push ss
0B10  57              push di
0B11  8A 46 06        mov al, byte ptr [bp + 6]
0B14  50              push ax
0B15  8A 46 04        mov al, byte ptr [bp + 4]
0B18  50              push ax
0B19  BF 58 DD        mov di, 0xdd58
0B1C  1E              push ds
0B1D  57              push di
0B1E  9A 1B 04 1A 23  call far 231A:041B
0B23  83 7E 06 04     cmp word ptr [bp + 6], 4
0B27  77 26           ja 0xb4f
0B29  C4 7E D8        les di, ptr [bp - 0x28]
0B2C  26 8A 45 05     mov al, byte ptr es:[di + 5]
0B30  98              cwde
0B31  8B F8           mov di, ax
0B33  8A 85 C8 D0     mov al, byte ptr [di - 0x2f38]
0B37  50              push ax
0B38  8D 7E DC        lea di, [bp - 0x24]
0B3B  16              push ss
0B3C  57              push di
0B3D  8A 46 06        mov al, byte ptr [bp + 6]
0B40  50              push ax
0B41  8A 46 04        mov al, byte ptr [bp + 4]
0B44  50              push ax
0B45  BF 60 DD        mov di, 0xdd60
0B48  1E              push ds
0B49  57              push di
0B4A  9A 1B 04 1A 23  call far 231A:041B
loc_0B4F:
0B4F  C9              leave
0B50  C2 06 00        ret 6

