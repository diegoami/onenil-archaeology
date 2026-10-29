; 1-095.EXE (One-Nil 95), code segment 01EE (image offsets 01EE0..06E3F), part 1 of 7
; packed 1-095.EXE sha256 f659fb2d334500d6901fc8d6a0f06c85c0ccda2eb4a3035ae3bb0a0004d79192 (LZEXE 0.91)
; unpacked (tools/static/unlzexe.py) sha256 8df646e017e0965a5d90a58181ca764219ad847833aad0b6cb58fc53372bfb2c
; tool: capstone 5.0.9 (pip package; core library 5.0.1280) (CS_ARCH_X86, CS_MODE_16), recursive descent from the entry point, far calls and near calls/jumps, then routine prologues (55 89 E5 / 55 8B EC / C8 iw 00) in what remains; tools/static/listing.py
; addresses are SEGMENT:OFFSET with SEGMENT the image paragraph before relocation; image offset = SEGMENT*16+OFFSET

; ---- routine 01EE:0000  (found by: call)
sub_0000:
0000  C8 0A 00 00     enter 0xa, 0
0004  C7 46 FE 01 00  mov word ptr [bp - 2], 1
0009  EB 03           jmp 0xe
loc_000B:
000B  FF 46 FE        inc word ptr [bp - 2]
loc_000E:
000E  8B 46 FE        mov ax, word ptr [bp - 2]
0011  D1 E0           shl ax, 1
0013  C4 7E 06        les di, ptr [bp + 6]
0016  03 F8           add di, ax
0018  26 83 7D FE 00  cmp word ptr es:[di - 2], 0
001D  75 03           jne 0x22
001F  E9 83 01        jmp 0x1a5
loc_0022:
0022  8B 46 FE        mov ax, word ptr [bp - 2]
0025  D1 E0           shl ax, 1
0027  C4 7E 06        les di, ptr [bp + 6]
002A  03 F8           add di, ax
002C  26 6B 45 FE 0F  imul ax, word ptr es:[di - 2], 0xf
0031  C4 3E BE D7     les di, ptr [0xd7be]
0035  03 F8           add di, ax
0037  89 7E FA        mov word ptr [bp - 6], di
003A  8C 46 FC        mov word ptr [bp - 4], es
003D  8B 46 FE        mov ax, word ptr [bp - 2]
0040  D1 E0           shl ax, 1
0042  C4 7E 06        les di, ptr [bp + 6]
0045  03 F8           add di, ax
0047  26 8B 45 FE     mov ax, word ptr es:[di - 2]
004B  C1 E0 03        shl ax, 3
004E  C4 3E BA D7     les di, ptr [0xd7ba]
0052  03 F8           add di, ax
0054  89 7E F6        mov word ptr [bp - 0xa], di
0057  8C 46 F8        mov word ptr [bp - 8], es
005A  C4 7E FA        les di, ptr [bp - 6]
005D  26 80 7D 0D 02  cmp byte ptr es:[di + 0xd], 2
0062  75 68           jne 0xcc
0064  C4 3E D2 D7     les di, ptr [0xd7d2]
0068  26 8A 05        mov al, byte ptr es:[di]
006B  D0 E8           shr al, 1
006D  B0 00           mov al, 0
006F  73 01           jae 0x72
0071  40              inc ax
loc_0072:
0072  8A D0           mov dl, al
0074  C4 7E F6        les di, ptr [bp - 0xa]
0077  26 8A 45 05     mov al, byte ptr es:[di + 5]
007B  D0 E8           shr al, 1
007D  B0 00           mov al, 0
007F  73 01           jae 0x82
0081  40              inc ax
loc_0082:
0082  3A C2           cmp al, dl
0084  75 46           jne 0xcc
0086  26 8A 05        mov al, byte ptr es:[di]
0089  3A 06 BA DC     cmp al, byte ptr [0xdcba]
008D  B0 00           mov al, 0
008F  74 01           je 0x92
0091  40              inc ax
loc_0092:
0092  30 E4           xor ah, ah
0094  40              inc ax
0095  8B F8           mov di, ax
0097  D1 E7           shl di, 1
0099  8B 95 42 D1     mov dx, word ptr [di - 0x2ebe]
009D  8B 46 FE        mov ax, word ptr [bp - 2]
00A0  D1 E0           shl ax, 1
00A2  C4 7E 06        les di, ptr [bp + 6]
00A5  03 F8           add di, ax
00A7  26 8B 45 FE     mov ax, word ptr es:[di - 2]
00AB  3B C2           cmp ax, dx
00AD  74 1D           je 0xcc
00AF  C4 7E FA        les di, ptr [bp - 6]
00B2  26 80 7D 08 00  cmp byte ptr es:[di + 8], 0
00B7  7E 13           jle 0xcc
00B9  8B 46 FE        mov ax, word ptr [bp - 2]
00BC  D1 E0           shl ax, 1
00BE  C4 7E 06        les di, ptr [bp + 6]
00C1  03 F8           add di, ax
00C3  26 FF 75 FE     push word ptr es:[di - 2]
00C7  9A 9D 44 51 1B  call far 1B51:449D
loc_00CC:
00CC  C4 7E FA        les di, ptr [bp - 6]
00CF  26 80 7D 0C 00  cmp byte ptr es:[di + 0xc], 0
00D4  77 03           ja 0xd9
00D6  E9 CC 00        jmp 0x1a5
loc_00D9:
00D9  26 FE 4D 0C     dec byte ptr es:[di + 0xc]
00DD  26 80 7D 0C 0A  cmp byte ptr es:[di + 0xc], 0xa
00E2  75 3B           jne 0x11f
00E4  BF E4 44        mov di, 0x44e4
00E7  1E              push ds
00E8  57              push di
00E9  BF 2E 22        mov di, 0x222e
00EC  1E              push ds
00ED  57              push di
00EE  8B 46 FE        mov ax, word ptr [bp - 2]
00F1  D1 E0           shl ax, 1
00F3  C4 7E 06        les di, ptr [bp + 6]
00F6  03 F8           add di, ax
00F8  26 FF 75 FE     push word ptr es:[di - 2]
00FC  9A 82 30 E4 06  call far 06E4:3082
0101  08 C0           or al, al
0103  74 17           je 0x11c
0105  8B 46 FE        mov ax, word ptr [bp - 2]
0108  D1 E0           shl ax, 1
010A  C4 7E 06        les di, ptr [bp + 6]
010D  03 F8           add di, ax
010F  26 FF 75 FE     push word ptr es:[di - 2]
0113  6A 00           push 0
0115  6A 00           push 0
0117  9A A3 C0 B5 0A  call far 0AB5:C0A3
loc_011C:
011C  E9 86 00        jmp 0x1a5
loc_011F:
011F  C4 7E FA        les di, ptr [bp - 6]
0122  26 80 7D 0C 00  cmp byte ptr es:[di + 0xc], 0
0127  75 7C           jne 0x1a5
0129  C4 7E F6        les di, ptr [bp - 0xa]
012C  26 80 7D 01 12  cmp byte ptr es:[di + 1], 0x12
0131  73 45           jae 0x178
0133  8B 46 FE        mov ax, word ptr [bp - 2]
0136  D1 E0           shl ax, 1
0138  C4 7E 06        les di, ptr [bp + 6]
013B  03 F8           add di, ax
013D  26 FF 75 FE     push word ptr es:[di - 2]
0141  9A 6B 3B E4 06  call far 06E4:3B6B
0146  08 C0           or al, al
0148  75 2E           jne 0x178
014A  C4 7E 06        les di, ptr [bp + 6]
014D  06              push es
014E  57              push di
014F  FF 76 FE        push word ptr [bp - 2]
0152  9A FE 66 51 1B  call far 1B51:66FE
0157  C4 3E D2 D7     les di, ptr [0xd7d2]
015B  26 8A 45 04     mov al, byte ptr es:[di + 4]
015F  30 E4           xor ah, ah
0161  8B F8           mov di, ax
0163  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
0167  30 E4           xor ah, ah
0169  6B C0 3E        imul ax, ax, 0x3e
016C  C4 3E C2 D7     les di, ptr [0xd7c2]
0170  03 F8           add di, ax
0172  26 FE 4D F4     dec byte ptr es:[di - 0xc]
0176  EB 2D           jmp 0x1a5
loc_0178:
0178  C4 7E F6        les di, ptr [bp - 0xa]
017B  26 80 7D 01 11  cmp byte ptr es:[di + 1], 0x11
0180  76 23           jbe 0x1a5
0182  8B 46 FE        mov ax, word ptr [bp - 2]
0185  D1 E0           shl ax, 1
0187  C4 7E 06        les di, ptr [bp + 6]
018A  03 F8           add di, ax
018C  26 FF 75 FE     push word ptr es:[di - 2]
0190  6A 00           push 0
0192  6A 00           push 0
0194  9A A3 C0 B5 0A  call far 0AB5:C0A3
0199  08 C0           or al, al
019B  75 08           jne 0x1a5
019D  C4 7E FA        les di, ptr [bp - 6]
01A0  26 C6 45 0D 02  mov byte ptr es:[di + 0xd], 2
loc_01A5:
01A5  83 7E FE 14     cmp word ptr [bp - 2], 0x14
01A9  74 03           je 0x1ae
01AB  E9 5D FE        jmp 0xb
loc_01AE:
01AE  C9              leave
01AF  C2 06 00        ret 6

; ---- routine 01EE:01B2  (found by: call)
sub_01B2:
01B2  C8 BE 00 00     enter 0xbe, 0
01B6  8D BE 4A FF     lea di, [bp - 0xb6]
01BA  16              push ss
01BB  57              push di
01BC  68 B1 00        push 0xb1
01BF  6A 01           push 1
01C1  9A 22 02 AC 24  call far 24AC:0222
01C6  A0 BA DC        mov al, byte ptr [0xdcba]
01C9  30 E4           xor ah, ah
01CB  8B F8           mov di, ax
01CD  C6 83 4A FF 00  mov byte ptr [bp + di - 0xb6], 0
01D2  A0 BB DC        mov al, byte ptr [0xdcbb]
01D5  30 E4           xor ah, ah
01D7  8B F8           mov di, ax
01D9  C6 83 4A FF 00  mov byte ptr [bp + di - 0xb6], 0
01DE  31 C0           xor ax, ax
01E0  A3 86 D6        mov word ptr [0xd686], ax
01E3  C4 3E D2 D7     les di, ptr [0xd7d2]
01E7  26 8A 45 03     mov al, byte ptr es:[di + 3]
01EB  30 E4           xor ah, ah
01ED  89 86 48 FF     mov word ptr [bp - 0xb8], ax
01F1  B8 01 00        mov ax, 1
01F4  3B 86 48 FF     cmp ax, word ptr [bp - 0xb8]
01F8  77 70           ja 0x26a
01FA  89 46 FE        mov word ptr [bp - 2], ax
01FD  EB 03           jmp 0x202
loc_01FF:
01FF  FF 46 FE        inc word ptr [bp - 2]
loc_0202:
0202  8B 7E FE        mov di, word ptr [bp - 2]
0205  80 BD B9 DC 00  cmp byte ptr [di - 0x2347], 0
020A  74 55           je 0x261
020C  8A 46 FE        mov al, byte ptr [bp - 2]
020F  C4 3E D2 D7     les di, ptr [0xd7d2]
0213  26 88 45 04     mov byte ptr es:[di + 4], al
0217  8B 7E FE        mov di, word ptr [bp - 2]
021A  D1 E7           shl di, 1
021C  83 BD 42 D1 00  cmp word ptr [di - 0x2ebe], 0
0221  74 0E           je 0x231
0223  8B 7E FE        mov di, word ptr [bp - 2]
0226  D1 E7           shl di, 1
0228  FF B5 42 D1     push word ptr [di - 0x2ebe]
022C  9A 9D 44 51 1B  call far 1B51:449D
loc_0231:
0231  8B 7E FE        mov di, word ptr [bp - 2]
0234  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
0238  30 E4           xor ah, ah
023A  6B C0 3E        imul ax, ax, 0x3e
023D  C4 3E C2 D7     les di, ptr [0xd7c2]
0241  03 F8           add di, ax
0243  81 C7 C2 FF     add di, 0xffc2
0247  06              push es
0248  57              push di
0249  55              push bp
024A  E8 B3 FD        call 0
024D  6B 46 FE 28     imul ax, word ptr [bp - 2], 0x28
0251  C4 3E D2 D7     les di, ptr [0xd7d2]
0255  03 F8           add di, ax
0257  81 C7 30 00     add di, 0x30
025B  06              push es
025C  57              push di
025D  55              push bp
025E  E8 9F FD        call 0
loc_0261:
0261  8B 46 FE        mov ax, word ptr [bp - 2]
0264  3B 86 48 FF     cmp ax, word ptr [bp - 0xb8]
0268  75 95           jne 0x1ff
loc_026A:
026A  C7 46 FE 01 00  mov word ptr [bp - 2], 1
026F  EB 03           jmp 0x274
loc_0271:
0271  FF 46 FE        inc word ptr [bp - 2]
loc_0274:
0274  8B 7E FE        mov di, word ptr [bp - 2]
0277  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
027B  30 E4           xor ah, ah
027D  6B C0 3E        imul ax, ax, 0x3e
0280  C4 3E C2 D7     les di, ptr [0xd7c2]
0284  03 F8           add di, ax
0286  81 C7 C2 FF     add di, 0xffc2
028A  89 BE 46 FF     mov word ptr [bp - 0xba], di
028E  8C 86 48 FF     mov word ptr [bp - 0xb8], es
0292  8B 7E FE        mov di, word ptr [bp - 2]
0295  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
0299  30 E4           xor ah, ah
029B  8B F8           mov di, ax
029D  80 BB 4A FF 00  cmp byte ptr [bp + di - 0xb6], 0
02A2  75 03           jne 0x2a7
02A4  E9 0A 01        jmp 0x3b1
loc_02A7:
02A7  C7 46 FC 01 00  mov word ptr [bp - 4], 1
02AC  EB 03           jmp 0x2b1
loc_02AE:
02AE  FF 46 FC        inc word ptr [bp - 4]
loc_02B1:
02B1  8B 46 FC        mov ax, word ptr [bp - 4]
02B4  D1 E0           shl ax, 1
02B6  C4 BE 46 FF     les di, ptr [bp - 0xba]
02BA  03 F8           add di, ax
02BC  26 83 7D FE 00  cmp word ptr es:[di - 2], 0
02C1  75 03           jne 0x2c6
02C3  E9 E2 00        jmp 0x3a8
loc_02C6:
02C6  8B 46 FC        mov ax, word ptr [bp - 4]
02C9  D1 E0           shl ax, 1
02CB  C4 BE 46 FF     les di, ptr [bp - 0xba]
02CF  03 F8           add di, ax
02D1  26 6B 45 FE 0F  imul ax, word ptr es:[di - 2], 0xf
02D6  C4 3E BE D7     les di, ptr [0xd7be]
02DA  03 F8           add di, ax
02DC  89 BE 42 FF     mov word ptr [bp - 0xbe], di
02E0  8C 86 44 FF     mov word ptr [bp - 0xbc], es
02E4  26 80 7D 0D 02  cmp byte ptr es:[di + 0xd], 2
02E9  75 52           jne 0x33d
02EB  26 80 7D 08 00  cmp byte ptr es:[di + 8], 0
02F0  7E 4B           jle 0x33d
02F2  C4 3E D2 D7     les di, ptr [0xd7d2]
02F6  26 8A 05        mov al, byte ptr es:[di]
02F9  D0 E8           shr al, 1
02FB  B0 00           mov al, 0
02FD  73 01           jae 0x300
02FF  40              inc ax
loc_0300:
0300  8A D0           mov dl, al
0302  8B 46 FC        mov ax, word ptr [bp - 4]
0305  D1 E0           shl ax, 1
0307  C4 BE 46 FF     les di, ptr [bp - 0xba]
030B  03 F8           add di, ax
030D  26 8B 45 FE     mov ax, word ptr es:[di - 2]
0311  C1 E0 03        shl ax, 3
0314  C4 3E BA D7     les di, ptr [0xd7ba]
0318  03 F8           add di, ax
031A  26 8A 45 05     mov al, byte ptr es:[di + 5]
031E  D0 E8           shr al, 1
0320  B0 00           mov al, 0
0322  73 01           jae 0x325
0324  40              inc ax
loc_0325:
0325  3A C2           cmp al, dl
0327  75 14           jne 0x33d
0329  8B 46 FC        mov ax, word ptr [bp - 4]
032C  D1 E0           shl ax, 1
032E  C4 BE 46 FF     les di, ptr [bp - 0xba]
0332  03 F8           add di, ax
0334  26 FF 75 FE     push word ptr es:[di - 2]
0338  9A 9D 44 51 1B  call far 1B51:449D
loc_033D:
033D  C4 BE 42 FF     les di, ptr [bp - 0xbe]
0341  26 80 7D 0C 00  cmp byte ptr es:[di + 0xc], 0
0346  76 60           jbe 0x3a8
0348  26 FE 4D 0C     dec byte ptr es:[di + 0xc]
034C  26 80 7D 0C 00  cmp byte ptr es:[di + 0xc], 0
0351  75 55           jne 0x3a8
0353  C4 BE 46 FF     les di, ptr [bp - 0xba]
0357  26 8A 45 32     mov al, byte ptr es:[di + 0x32]
035B  30 E4           xor ah, ah
035D  50              push ax
035E  9A 1C 0D AC 24  call far 24AC:0D1C
0363  08 C0           or al, al
0365  75 22           jne 0x389
0367  8B 46 FC        mov ax, word ptr [bp - 4]
036A  D1 E0           shl ax, 1
036C  C4 BE 46 FF     les di, ptr [bp - 0xba]
0370  03 F8           add di, ax
0372  26 FF 75 FE     push word ptr es:[di - 2]
0376  8B 7E FE        mov di, word ptr [bp - 2]
0379  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
037D  30 E4           xor ah, ah
037F  50              push ax
0380  9A A4 7A 51 1B  call far 1B51:7AA4
0385  08 C0           or al, al
0387  74 0B           je 0x394
loc_0389:
0389  C4 BE 42 FF     les di, ptr [bp - 0xbe]
038D  26 C6 45 0D 02  mov byte ptr es:[di + 0xd], 2
0392  EB 14           jmp 0x3a8
loc_0394:
0394  8B 46 FC        mov ax, word ptr [bp - 4]
0397  D1 E0           shl ax, 1
0399  C4 BE 46 FF     les di, ptr [bp - 0xba]
039D  03 F8           add di, ax
039F  26 FF 75 FE     push word ptr es:[di - 2]
03A3  9A 98 64 51 1B  call far 1B51:6498
loc_03A8:
03A8  83 7E FC 14     cmp word ptr [bp - 4], 0x14
03AC  74 03           je 0x3b1
03AE  E9 FD FE        jmp 0x2ae
loc_03B1:
03B1  81 7E FE B0 00  cmp word ptr [bp - 2], 0xb0
03B6  74 03           je 0x3bb
03B8  E9 B6 FE        jmp 0x271
loc_03BB:
03BB  C9              leave
03BC  C3              ret

; ---- routine 01EE:03BD  (found by: call)
sub_03BD:
03BD  C8 08 00 00     enter 8, 0
03C1  8B 46 08        mov ax, word ptr [bp + 8]
03C4  89 46 FE        mov word ptr [bp - 2], ax
03C7  8B 46 06        mov ax, word ptr [bp + 6]
03CA  89 46 FC        mov word ptr [bp - 4], ax
03CD  8B 46 08        mov ax, word ptr [bp + 8]
03D0  03 46 06        add ax, word ptr [bp + 6]
03D3  D1 E8           shr ax, 1
03D5  8B F8           mov di, ax
03D7  D1 E7           shl di, 1
03D9  8B 85 DA D1     mov ax, word ptr [di - 0x2e26]
03DD  C1 E0 03        shl ax, 3
03E0  C4 3E BA D7     les di, ptr [0xd7ba]
03E4  03 F8           add di, ax
03E6  26 8A 45 07     mov al, byte ptr es:[di + 7]
03EA  30 E4           xor ah, ah
03EC  89 46 F8        mov word ptr [bp - 8], ax
loc_03EF:
03EF  8B 7E FE        mov di, word ptr [bp - 2]
03F2  D1 E7           shl di, 1
03F4  8B 85 DA D1     mov ax, word ptr [di - 0x2e26]
03F8  C1 E0 03        shl ax, 3
03FB  C4 3E BA D7     les di, ptr [0xd7ba]
03FF  03 F8           add di, ax
0401  26 8A 45 07     mov al, byte ptr es:[di + 7]
0405  30 E4           xor ah, ah
0407  3B 46 F8        cmp ax, word ptr [bp - 8]
040A  73 05           jae 0x411
040C  FF 46 FE        inc word ptr [bp - 2]
040F  EB DE           jmp 0x3ef
loc_0411:
0411  8B 7E FC        mov di, word ptr [bp - 4]
0414  D1 E7           shl di, 1
0416  8B 85 DA D1     mov ax, word ptr [di - 0x2e26]
041A  C1 E0 03        shl ax, 3
041D  C4 3E BA D7     les di, ptr [0xd7ba]
0421  03 F8           add di, ax
0423  26 8A 45 07     mov al, byte ptr es:[di + 7]
0427  30 E4           xor ah, ah
0429  3B 46 F8        cmp ax, word ptr [bp - 8]
042C  76 05           jbe 0x433
042E  FF 4E FC        dec word ptr [bp - 4]
0431  EB DE           jmp 0x411
loc_0433:
0433  8B 46 FE        mov ax, word ptr [bp - 2]
0436  3B 46 FC        cmp ax, word ptr [bp - 4]
0439  77 30           ja 0x46b
043B  8B 7E FE        mov di, word ptr [bp - 2]
043E  D1 E7           shl di, 1
0440  8B 85 DA D1     mov ax, word ptr [di - 0x2e26]
0444  89 46 FA        mov word ptr [bp - 6], ax
0447  8B 7E FC        mov di, word ptr [bp - 4]
044A  D1 E7           shl di, 1
044C  8B 85 DA D1     mov ax, word ptr [di - 0x2e26]
0450  8B 7E FE        mov di, word ptr [bp - 2]
0453  D1 E7           shl di, 1
0455  89 85 DA D1     mov word ptr [di - 0x2e26], ax
0459  8B 46 FA        mov ax, word ptr [bp - 6]
045C  8B 7E FC        mov di, word ptr [bp - 4]
045F  D1 E7           shl di, 1
0461  89 85 DA D1     mov word ptr [di - 0x2e26], ax
0465  FF 46 FE        inc word ptr [bp - 2]
0468  FF 4E FC        dec word ptr [bp - 4]
loc_046B:
046B  8B 46 FE        mov ax, word ptr [bp - 2]
046E  3B 46 FC        cmp ax, word ptr [bp - 4]
0471  77 03           ja 0x476
0473  E9 79 FF        jmp 0x3ef
loc_0476:
0476  8B 46 08        mov ax, word ptr [bp + 8]
0479  3B 46 FC        cmp ax, word ptr [bp - 4]
047C  73 0D           jae 0x48b
047E  FF 76 08        push word ptr [bp + 8]
0481  FF 76 FC        push word ptr [bp - 4]
0484  8B 7E 04        mov di, word ptr [bp + 4]
0487  57              push di
0488  E8 32 FF        call 0x3bd
loc_048B:
048B  8B 46 FE        mov ax, word ptr [bp - 2]
048E  3B 46 06        cmp ax, word ptr [bp + 6]
0491  73 0D           jae 0x4a0
0493  FF 76 FE        push word ptr [bp - 2]
0496  FF 76 06        push word ptr [bp + 6]
0499  8B 7E 04        mov di, word ptr [bp + 4]
049C  57              push di
049D  E8 1D FF        call 0x3bd
loc_04A0:
04A0  C9              leave
04A1  C2 06 00        ret 6

; ---- routine 01EE:04A4  (found by: call)
sub_04A4:
04A4  C8 04 00 00     enter 4, 0
04A8  C4 3E D2 D7     les di, ptr [0xd7d2]
04AC  26 8A 45 04     mov al, byte ptr es:[di + 4]
04B0  30 E4           xor ah, ah
04B2  8B F8           mov di, ax
04B4  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
04B8  30 E4           xor ah, ah
04BA  89 46 FC        mov word ptr [bp - 4], ax
04BD  C7 46 FE 01 00  mov word ptr [bp - 2], 1
04C2  EB 03           jmp 0x4c7
loc_04C4:
04C4  FF 46 FE        inc word ptr [bp - 2]
loc_04C7:
04C7  8B 46 FE        mov ax, word ptr [bp - 2]
04CA  D1 E0           shl ax, 1
04CC  C4 7E 06        les di, ptr [bp + 6]
04CF  03 F8           add di, ax
04D1  26 83 7D FE 00  cmp word ptr es:[di - 2], 0
04D6  75 03           jne 0x4db
04D8  E9 8A 00        jmp 0x565
loc_04DB:
04DB  8B 46 FE        mov ax, word ptr [bp - 2]
04DE  D1 E0           shl ax, 1
04E0  C4 7E 06        les di, ptr [bp + 6]
04E3  03 F8           add di, ax
04E5  26 8B 45 FE     mov ax, word ptr es:[di - 2]
04E9  C1 E0 03        shl ax, 3
04EC  C4 3E BA D7     les di, ptr [0xd7ba]
04F0  03 F8           add di, ax
04F2  26 8A 05        mov al, byte ptr es:[di]
04F5  30 E4           xor ah, ah
04F7  3B 46 FC        cmp ax, word ptr [bp - 4]
04FA  74 69           je 0x565
04FC  8B 46 FE        mov ax, word ptr [bp - 2]
04FF  D1 E0           shl ax, 1
0501  C4 7E 06        les di, ptr [bp + 6]
0504  03 F8           add di, ax
0506  26 8B 45 FE     mov ax, word ptr es:[di - 2]
050A  C1 E0 03        shl ax, 3
050D  C4 3E BA D7     les di, ptr [0xd7ba]
0511  03 F8           add di, ax
0513  26 80 7D 01 11  cmp byte ptr es:[di + 1], 0x11
0518  76 4B           jbe 0x565
051A  8B 46 FE        mov ax, word ptr [bp - 2]
051D  D1 E0           shl ax, 1
051F  C4 7E 06        les di, ptr [bp + 6]
0522  03 F8           add di, ax
0524  26 6B 45 FE 0F  imul ax, word ptr es:[di - 2], 0xf
0529  C4 3E BE D7     les di, ptr [0xd7be]
052D  03 F8           add di, ax
052F  26 80 7D 0D 02  cmp byte ptr es:[di + 0xd], 2
0534  74 1C           je 0x552
0536  8B 46 FE        mov ax, word ptr [bp - 2]
0539  D1 E0           shl ax, 1
053B  C4 7E 06        les di, ptr [bp + 6]
053E  03 F8           add di, ax
0540  26 6B 45 FE 0F  imul ax, word ptr es:[di - 2], 0xf
0545  C4 3E BE D7     les di, ptr [0xd7be]
0549  03 F8           add di, ax
054B  26 80 7D 0C 00  cmp byte ptr es:[di + 0xc], 0
0550  75 13           jne 0x565
loc_0552:
0552  8B 46 FE        mov ax, word ptr [bp - 2]
0555  D1 E0           shl ax, 1
0557  C4 7E 06        les di, ptr [bp + 6]
055A  03 F8           add di, ax
055C  26 FF 75 FE     push word ptr es:[di - 2]
0560  9A 9D 44 51 1B  call far 1B51:449D
loc_0565:
0565  83 7E FE 14     cmp word ptr [bp - 2], 0x14
0569  74 03           je 0x56e
056B  E9 56 FF        jmp 0x4c4
loc_056E:
056E  C9              leave
056F  C2 06 00        ret 6

; ---- routine 01EE:0572  (found by: call)
sub_0572:
0572  C8 06 00 00     enter 6, 0
0576  31 C0           xor ax, ax
0578  A3 86 D6        mov word ptr [0xd686], ax
057B  31 C0           xor ax, ax
057D  A3 DC D1        mov word ptr [0xd1dc], ax
0580  C7 46 FE 01 00  mov word ptr [bp - 2], 1
0585  EB 03           jmp 0x58a
loc_0587:
0587  FF 46 FE        inc word ptr [bp - 2]
loc_058A:
058A  8B 7E FE        mov di, word ptr [bp - 2]
058D  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
0591  30 E4           xor ah, ah
0593  6B C0 3E        imul ax, ax, 0x3e
0596  C4 3E C2 D7     les di, ptr [0xd7c2]
059A  03 F8           add di, ax
059C  26 8A 45 F9     mov al, byte ptr es:[di - 7]
05A0  3C 01           cmp al, 1
05A2  72 04           jb 0x5a8
05A4  3C 05           cmp al, 5
05A6  76 04           jbe 0x5ac
loc_05A8:
05A8  B0 00           mov al, 0
05AA  EB 02           jmp 0x5ae
loc_05AC:
05AC  B0 01           mov al, 1
loc_05AE:
05AE  3A 46 04        cmp al, byte ptr [bp + 4]
05B1  75 54           jne 0x607
05B3  8B 7E FE        mov di, word ptr [bp - 2]
05B6  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
05BA  30 E4           xor ah, ah
05BC  6B C0 3E        imul ax, ax, 0x3e
05BF  C4 3E C2 D7     les di, ptr [0xd7c2]
05C3  03 F8           add di, ax
05C5  81 C7 C2 FF     add di, 0xffc2
05C9  06              push es
05CA  57              push di
05CB  55              push bp
05CC  E8 D5 FE        call 0x4a4
05CF  8B 7E FE        mov di, word ptr [bp - 2]
05D2  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
05D6  3A 06 BA DC     cmp al, byte ptr [0xdcba]
05DA  75 10           jne 0x5ec
05DC  C4 3E D2 D7     les di, ptr [0xd7d2]
05E0  81 C7 58 00     add di, 0x58
05E4  06              push es
05E5  57              push di
05E6  55              push bp
05E7  E8 BA FE        call 0x4a4
05EA  EB 1B           jmp 0x607
loc_05EC:
05EC  8B 7E FE        mov di, word ptr [bp - 2]
05EF  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
05F3  3A 06 BB DC     cmp al, byte ptr [0xdcbb]
05F7  75 0E           jne 0x607
05F9  C4 3E D2 D7     les di, ptr [0xd7d2]
05FD  81 C7 80 00     add di, 0x80
0601  06              push es
0602  57              push di
0603  55              push bp
0604  E8 9D FE        call 0x4a4
loc_0607:
0607  81 7E FE B0 00  cmp word ptr [bp - 2], 0xb0
060C  74 03           je 0x611
060E  E9 76 FF        jmp 0x587
loc_0611:
0611  83 3E 86 D6 01  cmp word ptr [0xd686], 1
0616  76 0A           jbe 0x622
0618  6A 01           push 1
061A  FF 36 86 D6     push word ptr [0xd686]
061E  55              push bp
061F  E8 9B FD        call 0x3bd
loc_0622:
0622  C9              leave
0623  C2 02 00        ret 2

; ---- routine 01EE:0626  (found by: call)
sub_0626:
0626  C8 06 00 00     enter 6, 0
062A  C7 46 FC 04 00  mov word ptr [bp - 4], 4
062F  BF 7C 31        mov di, 0x317c
0632  1E              push ds
0633  57              push di
0634  BF 5C DD        mov di, 0xdd5c
0637  1E              push ds
0638  57              push di
0639  9A 2F 05 1A 23  call far 231A:052F
063E  6A 07           push 7
0640  6B 7E 04 09     imul di, word ptr [bp + 4], 9
0644  81 C7 E4 00     add di, 0xe4
0648  1E              push ds
0649  57              push di
064A  6A 02           push 2
064C  6A 3C           push 0x3c
064E  BF 5C DD        mov di, 0xdd5c
0651  1E              push ds
0652  57              push di
0653  9A 1B 04 1A 23  call far 231A:041B
0658  83 7E 06 00     cmp word ptr [bp + 6], 0
065C  76 40           jbe 0x69e
065E  8B 46 06        mov ax, word ptr [bp + 6]
0661  05 13 00        add ax, 0x13
0664  89 46 FA        mov word ptr [bp - 6], ax
0667  8B 46 06        mov ax, word ptr [bp + 6]
066A  3B 46 FA        cmp ax, word ptr [bp - 6]
066D  77 2F           ja 0x69e
066F  89 46 FE        mov word ptr [bp - 2], ax
0672  EB 03           jmp 0x677
loc_0674:
0674  FF 46 FE        inc word ptr [bp - 2]
loc_0677:
0677  8B 46 FE        mov ax, word ptr [bp - 2]
067A  3B 06 86 D6     cmp ax, word ptr [0xd686]
067E  77 16           ja 0x696
0680  8B 7E FE        mov di, word ptr [bp - 2]
0683  D1 E7           shl di, 1
0685  FF B5 DA D1     push word ptr [di - 0x2e26]
0689  FF 76 FC        push word ptr [bp - 4]
068C  6A 3C           push 0x3c
068E  9A 51 1F 51 1B  call far 1B51:1F51
0693  FF 46 FC        inc word ptr [bp - 4]
loc_0696:
0696  8B 46 FE        mov ax, word ptr [bp - 2]
0699  3B 46 FA        cmp ax, word ptr [bp - 6]
069C  75 D6           jne 0x674
loc_069E:
069E  C9              leave
069F  C2 04 00        ret 4

; ---- routine 01EE:06A2  (found by: call)
sub_06A2:
06A2  C8 06 00 00     enter 6, 0
06A6  8B 46 04        mov ax, word ptr [bp + 4]
06A9  C1 E0 03        shl ax, 3
06AC  C4 3E BA D7     les di, ptr [0xd7ba]
06B0  03 F8           add di, ax
06B2  89 7E FA        mov word ptr [bp - 6], di
06B5  8C 46 FC        mov word ptr [bp - 4], es
06B8  26 8A 05        mov al, byte ptr es:[di]
06BB  30 E4           xor ah, ah
06BD  50              push ax
06BE  9A DA 0D 51 1B  call far 1B51:0DDA
06C3  08 C0           or al, al
06C5  75 35           jne 0x6fc
06C7  C4 7E FA        les di, ptr [bp - 6]
06CA  26 8A 05        mov al, byte ptr es:[di]
06CD  30 E4           xor ah, ah
06CF  6B C0 3E        imul ax, ax, 0x3e
06D2  C4 3E C2 D7     les di, ptr [0xd7c2]
06D6  03 F8           add di, ax
06D8  26 8A 45 F9     mov al, byte ptr es:[di - 7]
06DC  98              cwde
06DD  8B F8           mov di, ax
06DF  8A 95 62 A2     mov dl, byte ptr [di - 0x5d9e]
06E3  C4 7E FA        les di, ptr [bp - 6]
06E6  26 8A 05        mov al, byte ptr es:[di]
06E9  30 E4           xor ah, ah
06EB  6B C0 3E        imul ax, ax, 0x3e
06EE  C4 3E C2 D7     les di, ptr [0xd7c2]
06F2  03 F8           add di, ax
06F4  26 8A 45 F4     mov al, byte ptr es:[di - 0xc]
06F8  3A C2           cmp al, dl
06FA  72 04           jb 0x700
loc_06FC:
06FC  B0 00           mov al, 0
06FE  EB 02           jmp 0x702
loc_0700:
0700  B0 01           mov al, 1
loc_0702:
0702  88 46 FF        mov byte ptr [bp - 1], al
0705  8A 46 FF        mov al, byte ptr [bp - 1]
0708  C9              leave
0709  C2 02 00        ret 2

; ---- routine 01EE:070C  (found by: call)
sub_070C:
070C  C8 10 00 00     enter 0x10, 0
0710  8B 46 06        mov ax, word ptr [bp + 6]
0713  C1 E0 03        shl ax, 3
0716  C4 3E BA D7     les di, ptr [0xd7ba]
071A  03 F8           add di, ax
071C  89 7E F4        mov word ptr [bp - 0xc], di
071F  8C 46 F6        mov word ptr [bp - 0xa], es
0722  6B 46 04 3E     imul ax, word ptr [bp + 4], 0x3e
0726  C4 3E C2 D7     les di, ptr [0xd7c2]
072A  03 F8           add di, ax
072C  81 C7 C2 FF     add di, 0xffc2
0730  C4 7E F4        les di, ptr [bp - 0xc]
0733  26 8A 45 04     mov al, byte ptr es:[di + 4]
0737  30 E4           xor ah, ah
0739  89 46 FA        mov word ptr [bp - 6], ax
073C  26 8A 45 04     mov al, byte ptr es:[di + 4]
0740  30 E4           xor ah, ah
0742  89 46 F8        mov word ptr [bp - 8], ax
0745  FF 76 04        push word ptr [bp + 4]
0748  9A BB 25 51 1B  call far 1B51:25BB
074D  99              cdq
074E  52              push dx
074F  50              push ax
0750  C4 7E F4        les di, ptr [bp - 0xc]
0753  26 8A 45 04     mov al, byte ptr es:[di + 4]
0757  30 E4           xor ah, ah
0759  05 B0 FF        add ax, 0xffb0
075C  99              cdq
075D  8B C8           mov cx, ax
075F  8B DA           mov bx, dx
0761  8B 46 F8        mov ax, word ptr [bp - 8]
0764  31 D2           xor dx, dx
0766  03 C1           add ax, cx
0768  13 D3           adc dx, bx
076A  59              pop cx
076B  5B              pop bx
076C  2B C1           sub ax, cx
076E  1B D3           sbb dx, bx
0770  89 46 F8        mov word ptr [bp - 8], ax
0773  6A 00           push 0
0775  68 FF 00        push 0xff
0778  8B 46 F8        mov ax, word ptr [bp - 8]
077B  31 D2           xor dx, dx
077D  52              push dx
077E  50              push ax
077F  9A FA 04 AC 24  call far 24AC:04FA
0784  C4 7E F4        les di, ptr [bp - 0xc]
0787  26 88 45 04     mov byte ptr es:[di + 4], al
078B  FF 76 06        push word ptr [bp + 6]
078E  9A 37 49 51 1B  call far 1B51:4937
0793  C4 7E F4        les di, ptr [bp - 0xc]
0796  26 88 45 04     mov byte ptr es:[di + 4], al
079A  FF 76 06        push word ptr [bp + 6]
079D  9A BD 47 51 1B  call far 1B51:47BD
07A2  89 46 FC        mov word ptr [bp - 4], ax
07A5  89 56 FE        mov word ptr [bp - 2], dx
07A8  8A 46 FA        mov al, byte ptr [bp - 6]
07AB  C4 7E F4        les di, ptr [bp - 0xc]
07AE  26 88 45 04     mov byte ptr es:[di + 4], al
07B2  8B 46 FC        mov ax, word ptr [bp - 4]
07B5  8B 56 FE        mov dx, word ptr [bp - 2]
07B8  C9              leave
07B9  C2 04 00        ret 4
; data (not reached as code), 16 bytes
07BC                  pstr 'Do you accept, '

; ---- routine 01EE:07CC  (found by: call)
sub_07CC:
07CC  C8 0C 01 00     enter 0x10c, 0
07D0  8B 7E 04        mov di, word ptr [bp + 4]
07D3  36 8B 45 04     mov ax, word ptr ss:[di + 4]
07D7  C1 E0 03        shl ax, 3
07DA  C4 3E BA D7     les di, ptr [0xd7ba]
07DE  03 F8           add di, ax
07E0  89 7E F4        mov word ptr [bp - 0xc], di
07E3  8C 46 F6        mov word ptr [bp - 0xa], es
07E6  C4 3E D2 D7     les di, ptr [0xd7d2]
07EA  26 8A 45 04     mov al, byte ptr es:[di + 4]
07EE  30 E4           xor ah, ah
07F0  8B F8           mov di, ax
07F2  8A 85 1F 01     mov al, byte ptr [di + 0x11f]
07F6  30 E4           xor ah, ah
07F8  89 46 FC        mov word ptr [bp - 4], ax
07FB  C4 7E F4        les di, ptr [bp - 0xc]
07FE  26 8A 05        mov al, byte ptr es:[di]
0801  8B 7E FC        mov di, word ptr [bp - 4]
0804  3A 85 B9 DC     cmp al, byte ptr [di - 0x2347]
0808  75 37           jne 0x841
080A  8D BE F4 FE     lea di, [bp - 0x10c]
080E  16              push ss
080F  57              push di
0810  BF BC 07        mov di, 0x7bc
0813  0E              push cs
0814  57              push di
0815  9A 53 0B B9 26  call far 26B9:0B53
081A  8B 46 FC        mov ax, word ptr [bp - 4]
081D  D1 E0           shl ax, 1
081F  C4 3E D2 D7     les di, ptr [0xd7d2]
0823  03 F8           add di, ax
0825  26 6B 45 03 0B  imul ax, word ptr es:[di + 3], 0xb
082A  C4 3E CC DC     les di, ptr [0xdccc]
082E  03 F8           add di, ax
0830  06              push es
0831  57              push di
0832  9A D2 0B B9 26  call far 26B9:0BD2
0837  9A E5 06 1A 23  call far 231A:06E5
083C  88 46 FE        mov byte ptr [bp - 2], al
083F  EB 27           jmp 0x868
loc_0841:
0841  8B 7E 04        mov di, word ptr [bp + 4]
0844  36 8B 45 F8     mov ax, word ptr ss:[di - 8]
0848  36 8B 55 FA     mov dx, word ptr ss:[di - 6]
084C  36 3B 55 FE     cmp dx, word ptr ss:[di - 2]
0850  7F 0C           jg 0x85e
0852  7C 06           jl 0x85a
0854  36 3B 45 FC     cmp ax, word ptr ss:[di - 4]
0858  73 04           jae 0x85e
loc_085A:
085A  B0 00           mov al, 0
085C  EB 02           jmp 0x860
loc_085E:
085E  B0 01           mov al, 1
loc_0860:
0860  88 46 FE        mov byte ptr [bp - 2], al
0863  31 C0           xor ax, ax
0865  89 46 FC        mov word ptr [bp - 4], ax
loc_0868:
0868  80 7E FE 00     cmp byte ptr [bp - 2], 0
086C  75 11           jne 0x87f
086E  BF 1E 17        mov di, 0x171e
0871  1E              push ds
0872  57              push di
0873  BF 5C DD        mov di, 0xdd5c
0876  1E              push ds
0877  57              push di
0878  9A 2F 05 1A 23  call far 231A:052F
087D  EB 1F           jmp 0x89e
loc_087F:
087F  8B 7E 04        mov di, word ptr [bp + 4]
0882  36 FF 75 04     push word ptr ss:[di + 4]
0886  36 FF 75 FA     push word ptr ss:[di - 6]
088A  36 FF 75 F8     push word ptr ss:[di - 8]
088E  9A A3 C0 B5 0A  call far 0AB5:C0A3
0893  88 46 FE        mov byte ptr [bp - 2], al
0896  8B 7E 04        mov di, word ptr [bp + 4]
0899  36 C6 45 F7 01  mov byte ptr ss:[di - 9], 1
loc_089E:
089E  80 7E FE 00     cmp byte ptr [bp - 2], 0
08A2  75 03           jne 0x8a7
08A4  E9 6B 02        jmp 0xb12
loc_08A7:
08A7  C4 7E F4        les di, ptr [bp - 0xc]
08AA  26 8A 05        mov al, byte ptr es:[di]
08AD  30 E4           xor ah, ah
08AF  89 46 FA        mov word ptr [bp - 6], ax
08B2  8B 7E 04        mov di, word ptr [bp + 4]
08B5  36 FF 75 04     push word ptr ss:[di + 4]
08B9  36 8B 45 04     mov ax, word ptr ss:[di + 4]
08BD  C1 E0 03        shl ax, 3
08C0  C4 3E BA D7     les di, ptr [0xd7ba]
08C4  03 F8           add di, ax
08C6  26 8A 05        mov al, byte ptr es:[di]
08C9  30 E4           xor ah, ah
08CB  50              push ax
08CC  6A 01           push 1
08CE  C4 3E D2 D7     les di, ptr [0xd7d2]
08D2  26 8A 45 04     mov al, byte ptr es:[di + 4]
08D6  30 E4           xor ah, ah
08D8  50              push ax
08D9  8B 7E 04        mov di, word ptr [bp + 4]
08DC  36 8B 45 04     mov ax, word ptr ss:[di + 4]
08E0  C1 E0 03        shl ax, 3
08E3  C4 3E BA D7     les di, ptr [0xd7ba]
08E7  03 F8           add di, ax
08E9  26 8A 05        mov al, byte ptr es:[di]
08EC  30 E4           xor ah, ah
08EE  50              push ax
08EF  9A 88 63 51 1B  call far 1B51:6388
08F4  8B 7E 04        mov di, word ptr [bp + 4]
08F7  36 8B 4D F8     mov cx, word ptr ss:[di - 8]
08FB  36 8B 5D FA     mov bx, word ptr ss:[di - 6]
08FF  C4 3E D2 D7     les di, ptr [0xd7d2]
0903  26 8A 45 04     mov al, byte ptr es:[di + 4]
0907  30 E4           xor ah, ah
0909  6B C0 5E        imul ax, ax, 0x5e
090C  C4 3E C4 DC     les di, ptr [0xdcc4]
0910  03 F8           add di, ax
0912  26 01 4D D4     add word ptr es:[di - 0x2c], cx
0916  26 11 5D D6     adc word ptr es:[di - 0x2a], bx
091A  8B 7E 04        mov di, word ptr [bp + 4]
091D  36 8B 4D F8     mov cx, word ptr ss:[di - 8]
0921  36 8B 5D FA     mov bx, word ptr ss:[di - 6]
0925  C4 3E D2 D7     les di, ptr [0xd7d2]
0929  26 8A 45 04     mov al, byte ptr es:[di + 4]
092D  30 E4           xor ah, ah
092F  69 C0 3A 23     imul ax, ax, 0x233a
0933  C4 3E E2 DC     les di, ptr [0xdce2]
0937  03 F8           add di, ax
0939  26 89 8D DF DC  mov word ptr es:[di - 0x2321], cx
093E  26 89 9D E1 DC  mov word ptr es:[di - 0x231f], bx
0943  83 7E FC 00     cmp word ptr [bp - 4], 0
0947  74 69           je 0x9b2
0949  8B 7E 04        mov di, word ptr [bp + 4]
094C  36 8B 4D F8     mov cx, word ptr ss:[di - 8]
0950  36 8B 5D FA     mov bx, word ptr ss:[di - 6]
0954  6B 46 FC 5E     imul ax, word ptr [bp - 4], 0x5e
0958  C4 3E C4 DC     les di, ptr [0xdcc4]
095C  03 F8           add di, ax
095E  26 01 4D CC     add word ptr es:[di - 0x34], cx
0962  26 11 5D CE     adc word ptr es:[di - 0x32], bx
0966  8B 7E 04        mov di, word ptr [bp + 4]
0969  36 FF 75 04     push word ptr ss:[di + 4]
096D  8B 7E FC        mov di, word ptr [bp - 4]
0970  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
0974  30 E4           xor ah, ah
0976  50              push ax
0977  FF 76 FC        push word ptr [bp - 4]
097A  C4 3E D2 D7     les di, ptr [0xd7d2]
097E  26 8A 45 04     mov al, byte ptr es:[di + 4]
0982  30 E4           xor ah, ah
0984  8B F8           mov di, ax
0986  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
098A  30 E4           xor ah, ah
098C  50              push ax
098D  9A 91 62 51 1B  call far 1B51:6291
0992  8B 7E 04        mov di, word ptr [bp + 4]
0995  36 8B 4D F8     mov cx, word ptr ss:[di - 8]
0999  36 8B 5D FA     mov bx, word ptr ss:[di - 6]
099D  69 46 FC 3A 23  imul ax, word ptr [bp - 4], 0x233a
09A2  C4 3E E2 DC     les di, ptr [0xdce2]
09A6  03 F8           add di, ax
09A8  26 89 8D DF DC  mov word ptr es:[di - 0x2321], cx
09AD  26 89 9D E1 DC  mov word ptr es:[di - 0x231f], bx
loc_09B2:
09B2  C4 3E D2 D7     les di, ptr [0xd7d2]
09B6  26 8A 45 04     mov al, byte ptr es:[di + 4]
09BA  30 E4           xor ah, ah
09BC  8B F8           mov di, ax
09BE  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
09C2  30 E4           xor ah, ah
09C4  89 46 F8        mov word ptr [bp - 8], ax
09C7  6B 46 F8 3E     imul ax, word ptr [bp - 8], 0x3e
09CB  C4 3E C2 D7     les di, ptr [0xd7c2]
09CF  03 F8           add di, ax
09D1  81 C7 C2 FF     add di, 0xffc2
09D5  06              push es
09D6  57              push di
09D7  9A EA 5B 51 1B  call far 1B51:5BEA
09DC  09 C0           or ax, ax
09DE  76 37           jbe 0xa17
09E0  8B 7E 04        mov di, word ptr [bp + 4]
09E3  36 FF 75 04     push word ptr ss:[di + 4]
09E7  FF 76 F8        push word ptr [bp - 8]
09EA  6B 46 F8 3E     imul ax, word ptr [bp - 8], 0x3e
09EE  C4 3E C2 D7     les di, ptr [0xd7c2]
09F2  03 F8           add di, ax
09F4  81 C7 C2 FF     add di, 0xffc2
09F8  06              push es
09F9  57              push di
09FA  9A EA 5B 51 1B  call far 1B51:5BEA
09FF  50              push ax
0A00  6B 46 F8 3E     imul ax, word ptr [bp - 8], 0x3e
0A04  C4 3E C2 D7     les di, ptr [0xd7c2]
0A08  03 F8           add di, ax
0A0A  81 C7 C2 FF     add di, 0xffc2
0A0E  06              push es
0A0F  57              push di
0A10  9A EA 2C E4 06  call far 06E4:2CEA
0A15  EB 47           jmp 0xa5e
loc_0A17:
0A17  8B 7E 04        mov di, word ptr [bp + 4]
0A1A  36 FF 75 04     push word ptr ss:[di + 4]
0A1E  FF 76 F8        push word ptr [bp - 8]
0A21  C4 3E D2 D7     les di, ptr [0xd7d2]
0A25  26 8A 45 04     mov al, byte ptr es:[di + 4]
0A29  30 E4           xor ah, ah
0A2B  6B C0 28        imul ax, ax, 0x28
0A2E  C4 3E D2 D7     les di, ptr [0xd7d2]
0A32  03 F8           add di, ax
0A34  81 C7 30 00     add di, 0x30
0A38  06              push es
0A39  57              push di
0A3A  9A EA 5B 51 1B  call far 1B51:5BEA
0A3F  50              push ax
0A40  C4 3E D2 D7     les di, ptr [0xd7d2]
0A44  26 8A 45 04     mov al, byte ptr es:[di + 4]
0A48  30 E4           xor ah, ah
0A4A  6B C0 28        imul ax, ax, 0x28
0A4D  C4 3E D2 D7     les di, ptr [0xd7d2]
0A51  03 F8           add di, ax
0A53  81 C7 30 00     add di, 0x30
0A57  06              push es
0A58  57              push di
0A59  9A EA 2C E4 06  call far 06E4:2CEA
loc_0A5E:
0A5E  83 7E FC 00     cmp word ptr [bp - 4], 0
0A62  75 12           jne 0xa76
0A64  8B 7E 04        mov di, word ptr [bp + 4]
0A67  36 FF 75 04     push word ptr ss:[di + 4]
0A6B  FF 76 FA        push word ptr [bp - 6]
0A6E  9A C6 2D E4 06  call far 06E4:2DC6
0A73  E9 9C 00        jmp 0xb12
loc_0A76:
0A76  8B 7E FC        mov di, word ptr [bp - 4]
0A79  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
0A7D  30 E4           xor ah, ah
0A7F  6B C0 3E        imul ax, ax, 0x3e
0A82  C4 3E C2 D7     les di, ptr [0xd7c2]
0A86  03 F8           add di, ax
0A88  81 C7 C2 FF     add di, 0xffc2
0A8C  89 7E F0        mov word ptr [bp - 0x10], di
0A8F  8C 46 F2        mov word ptr [bp - 0xe], es
0A92  8B 7E 04        mov di, word ptr [bp + 4]
0A95  36 FF 75 04     push word ptr ss:[di + 4]
0A99  C4 7E F0        les di, ptr [bp - 0x10]
0A9C  06              push es
0A9D  57              push di
0A9E  9A AF 5B 51 1B  call far 1B51:5BAF
0AA3  09 C0           or ax, ax
0AA5  74 20           je 0xac7
0AA7  8B 7E 04        mov di, word ptr [bp + 4]
0AAA  36 FF 75 04     push word ptr ss:[di + 4]
0AAE  C4 7E F0        les di, ptr [bp - 0x10]
0AB1  06              push es
0AB2  57              push di
0AB3  9A AF 5B 51 1B  call far 1B51:5BAF
0AB8  D1 E0           shl ax, 1
0ABA  C4 7E F0        les di, ptr [bp - 0x10]
0ABD  03 F8           add di, ax
0ABF  31 C0           xor ax, ax
0AC1  26 89 45 FE     mov word ptr es:[di - 2], ax
0AC5  EB 44           jmp 0xb0b
loc_0AC7:
0AC7  8B 7E 04        mov di, word ptr [bp + 4]
0ACA  36 FF 75 04     push word ptr ss:[di + 4]
0ACE  C4 3E D2 D7     les di, ptr [0xd7d2]
0AD2  26 8A 45 04     mov al, byte ptr es:[di + 4]
0AD6  30 E4           xor ah, ah
0AD8  6B C0 28        imul ax, ax, 0x28
0ADB  C4 3E D2 D7     les di, ptr [0xd7d2]
0ADF  03 F8           add di, ax
0AE1  81 C7 30 00     add di, 0x30
0AE5  06              push es
0AE6  57              push di
0AE7  9A AF 5B 51 1B  call far 1B51:5BAF
0AEC  D1 E0           shl ax, 1
0AEE  8B D0           mov dx, ax
0AF0  C4 3E D2 D7     les di, ptr [0xd7d2]
0AF4  26 8A 45 04     mov al, byte ptr es:[di + 4]
0AF8  30 E4           xor ah, ah
0AFA  6B C0 28        imul ax, ax, 0x28
0AFD  C4 3E D2 D7     les di, ptr [0xd7d2]
0B01  03 F8           add di, ax
0B03  03 FA           add di, dx
0B05  31 C0           xor ax, ax
0B07  26 89 45 2E     mov word ptr es:[di + 0x2e], ax
loc_0B0B:
0B0B  C4 7E F0        les di, ptr [bp - 0x10]
0B0E  26 FE 4D 32     dec byte ptr es:[di + 0x32]
loc_0B12:
0B12  8A 46 FE        mov al, byte ptr [bp - 2]
0B15  88 46 FF        mov byte ptr [bp - 1], al
0B18  8A 46 FF        mov al, byte ptr [bp - 1]
0B1B  C9              leave
0B1C  C2 02 00        ret 2

; ---- routine 01EE:0B1F  (found by: call)
sub_0B1F:
0B1F  C8 10 00 00     enter 0x10, 0
0B23  8B 46 04        mov ax, word ptr [bp + 4]
0B26  C1 E0 03        shl ax, 3
0B29  C4 3E BA D7     les di, ptr [0xd7ba]
0B2D  03 F8           add di, ax
0B2F  89 7E F0        mov word ptr [bp - 0x10], di
0B32  8C 46 F2        mov word ptr [bp - 0xe], es
0B35  C4 3E D2 D7     les di, ptr [0xd7d2]
0B39  26 8A 45 04     mov al, byte ptr es:[di + 4]
0B3D  30 E4           xor ah, ah
0B3F  8B F8           mov di, ax
0B41  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
0B45  30 E4           xor ah, ah
0B47  50              push ax
0B48  9A BB 25 51 1B  call far 1B51:25BB
0B4D  8B D0           mov dx, ax
0B4F  C4 7E F0        les di, ptr [bp - 0x10]
0B52  26 8A 45 04     mov al, byte ptr es:[di + 4]
0B56  30 E4           xor ah, ah
0B58  05 B0 FF        add ax, 0xffb0
0B5B  3B C2           cmp ax, dx
0B5D  7D 32           jge 0xb91
0B5F  26 8A 45 04     mov al, byte ptr es:[di + 4]
0B63  30 E4           xor ah, ah
0B65  89 46 F4        mov word ptr [bp - 0xc], ax
0B68  FF 76 04        push word ptr [bp + 4]
0B6B  9A 37 49 51 1B  call far 1B51:4937
0B70  C4 7E F0        les di, ptr [bp - 0x10]
0B73  26 88 45 04     mov byte ptr es:[di + 4], al
0B77  FF 76 04        push word ptr [bp + 4]
0B7A  9A BD 47 51 1B  call far 1B51:47BD
0B7F  89 46 FC        mov word ptr [bp - 4], ax
0B82  89 56 FE        mov word ptr [bp - 2], dx
0B85  8A 46 F4        mov al, byte ptr [bp - 0xc]
0B88  C4 7E F0        les di, ptr [bp - 0x10]
0B8B  26 88 45 04     mov byte ptr es:[di + 4], al
0B8F  EB 1F           jmp 0xbb0
loc_0B91:
0B91  FF 76 04        push word ptr [bp + 4]
0B94  C4 3E D2 D7     les di, ptr [0xd7d2]
0B98  26 8A 45 04     mov al, byte ptr es:[di + 4]
0B9C  30 E4           xor ah, ah
0B9E  8B F8           mov di, ax
0BA0  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
0BA4  30 E4           xor ah, ah
0BA6  50              push ax
0BA7  E8 62 FB        call 0x70c
0BAA  89 46 FC        mov word ptr [bp - 4], ax
0BAD  89 56 FE        mov word ptr [bp - 2], dx
loc_0BB0:
0BB0  FF 76 04        push word ptr [bp + 4]
0BB3  8D 7E FC        lea di, [bp - 4]
0BB6  16              push ss
0BB7  57              push di
0BB8  9A 2F 34 E4 06  call far 06E4:342F
0BBD  FF 76 04        push word ptr [bp + 4]
0BC0  9A BD 47 51 1B  call far 1B51:47BD
0BC5  89 46 F8        mov word ptr [bp - 8], ax
0BC8  89 56 FA        mov word ptr [bp - 6], dx
0BCB  C6 06 2A 9A 00  mov byte ptr [0x9a2a], 0
0BD0  FF 76 04        push word ptr [bp + 4]
0BD3  9A B3 95 B5 0A  call far 0AB5:95B3
0BD8  BF 5E 14        mov di, 0x145e
0BDB  1E              push ds
0BDC  57              push di
0BDD  BF 5C DD        mov di, 0xdd5c
0BE0  1E              push ds
0BE1  57              push di
0BE2  9A 2F 05 1A 23  call far 231A:052F
0BE7  C6 46 F7 00     mov byte ptr [bp - 9], 0
loc_0BEB:
0BEB  80 7E F7 00     cmp byte ptr [bp - 9], 0
0BEF  74 03           je 0xbf4
0BF1  E9 0A 01        jmp 0xcfe
loc_0BF4:
0BF4  BF 62 18        mov di, 0x1862
0BF7  1E              push ds
0BF8  57              push di
0BF9  BF 5C DD        mov di, 0xdd5c
0BFC  1E              push ds
0BFD  57              push di
0BFE  9A 2F 05 1A 23  call far 231A:052F
0C03  BF 46 17        mov di, 0x1746
0C06  1E              push ds
0C07  57              push di
0C08  BF 5C DD        mov di, 0xdd5c
0C0B  1E              push ds
0C0C  57              push di
0C0D  9A 2F 05 1A 23  call far 231A:052F
0C12  C7 06 64 DD 70 00 mov word ptr [0xdd64], 0x70
0C18  FF 76 FA        push word ptr [bp - 6]
0C1B  FF 76 F8        push word ptr [bp - 8]
0C1E  6A 0C           push 0xc
0C20  6A 4C           push 0x4c
0C22  9A 7E 0F 51 1B  call far 1B51:0F7E
0C27  C4 3E 5C DD     les di, ptr [0xdd5c]
0C2B  06              push es
0C2C  57              push di
0C2D  C4 3E 58 DD     les di, ptr [0xdd58]
0C31  06              push es
0C32  57              push di
0C33  68 A0 0F        push 0xfa0
0C36  9A 12 0A B9 26  call far 26B9:0A12
0C3B  9A 9B 09 1A 23  call far 231A:099B
0C40  80 3E 88 DE 01  cmp byte ptr [0xde88], 1
0C45  75 03           jne 0xc4a
0C47  E9 B4 00        jmp 0xcfe
loc_0C4A:
0C4A  A0 88 DE        mov al, byte ptr [0xde88]
0C4D  3C 05           cmp al, 5
0C4F  72 5F           jb 0xcb0
0C51  3C 0C           cmp al, 0xc
0C53  77 5B           ja 0xcb0
0C55  BF 5E 14        mov di, 0x145e
0C58  1E              push ds
0C59  57              push di
0C5A  BF 5C DD        mov di, 0xdd5c
0C5D  1E              push ds
0C5E  57              push di
0C5F  9A 2F 05 1A 23  call far 231A:052F
0C64  A0 88 DE        mov al, byte ptr [0xde88]
0C67  30 E4           xor ah, ah
0C69  8B F8           mov di, ax
0C6B  C1 E7 02        shl di, 2
0C6E  8B 85 EC 00     mov ax, word ptr [di + 0xec]
0C72  8B 95 EE 00     mov dx, word ptr [di + 0xee]
0C76  01 46 F8        add word ptr [bp - 8], ax
0C79  11 56 FA        adc word ptr [bp - 6], dx
0C7C  81 7E FA F5 05  cmp word ptr [bp - 6], 0x5f5
0C81  7F 09           jg 0xc8c
0C83  7C 13           jl 0xc98
0C85  81 7E F8 FF E0  cmp word ptr [bp - 8], 0xe0ff
0C8A  76 0C           jbe 0xc98
loc_0C8C:
0C8C  C7 46 F8 FF E0  mov word ptr [bp - 8], 0xe0ff
0C91  C7 46 FA F5 05  mov word ptr [bp - 6], 0x5f5
0C96  EB 16           jmp 0xcae
loc_0C98:
0C98  83 7E FA 00     cmp word ptr [bp - 6], 0
0C9C  7C 08           jl 0xca6
0C9E  7F 0E           jg 0xcae
0CA0  83 7E F8 00     cmp word ptr [bp - 8], 0
0CA4  73 08           jae 0xcae
loc_0CA6:
0CA6  31 C0           xor ax, ax
0CA8  89 46 F8        mov word ptr [bp - 8], ax
0CAB  89 46 FA        mov word ptr [bp - 6], ax
loc_0CAE:
0CAE  EB 1C           jmp 0xccc
loc_0CB0:
0CB0  80 3E 88 DE 0D  cmp byte ptr [0xde88], 0xd
0CB5  75 15           jne 0xccc
0CB7  80 3E 2A 9A 00  cmp byte ptr [0x9a2a], 0
0CBC  B0 00           mov al, 0
0CBE  75 01           jne 0xcc1
0CC0  40              inc ax
loc_0CC1:
0CC1  A2 2A 9A        mov byte ptr [0x9a2a], al
0CC4  FF 76 04        push word ptr [bp + 4]
0CC7  9A B3 95 B5 0A  call far 0AB5:95B3
loc_0CCC:
0CCC  80 3E 88 DE 02  cmp byte ptr [0xde88], 2
0CD1  74 03           je 0xcd6
0CD3  E9 15 FF        jmp 0xbeb
loc_0CD6:
0CD6  C4 3E D2 D7     les di, ptr [0xd7d2]
0CDA  26 8A 45 04     mov al, byte ptr es:[di + 4]
0CDE  30 E4           xor ah, ah
0CE0  50              push ax
0CE1  FF 76 FA        push word ptr [bp - 6]
0CE4  FF 76 F8        push word ptr [bp - 8]
0CE7  9A D5 37 51 1B  call far 1B51:37D5
0CEC  08 C0           or al, al
0CEE  74 03           je 0xcf3
0CF0  E9 F8 FE        jmp 0xbeb
loc_0CF3:
0CF3  55              push bp
0CF4  E8 D5 FA        call 0x7cc
0CF7  08 C0           or al, al
0CF9  75 03           jne 0xcfe
0CFB  E9 ED FE        jmp 0xbeb
loc_0CFE:
0CFE  C9              leave
0CFF  C2 02 00        ret 2
; data (not reached as code), 71 bytes
0D02                  pstr 'Your chairman thinks you have enough players'
0D2F                  pstr " doesn't want to join you"

