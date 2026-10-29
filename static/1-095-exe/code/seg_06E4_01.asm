; 1-095.EXE (One-Nil 95), code segment 06E4 (image offsets 06E40..0AB4F), part 1 of 6
; packed 1-095.EXE sha256 f659fb2d334500d6901fc8d6a0f06c85c0ccda2eb4a3035ae3bb0a0004d79192 (LZEXE 0.91)
; unpacked (tools/static/unlzexe.py) sha256 8df646e017e0965a5d90a58181ca764219ad847833aad0b6cb58fc53372bfb2c
; tool: capstone 5.0.9 (pip package; core library 5.0.1280) (CS_ARCH_X86, CS_MODE_16), recursive descent from the entry point, far calls and near calls/jumps, then routine prologues (55 89 E5 / 55 8B EC / C8 iw 00) in what remains; tools/static/listing.py
; addresses are SEGMENT:OFFSET with SEGMENT the image paragraph before relocation; image offset = SEGMENT*16+OFFSET

; ---- routine 06E4:0000  (found by: call, far)
sub_0000:
0000  55              push bp
0001  89 E5           mov bp, sp
0003  9A 9B 09 1A 23  call far 231A:099B
0008  A0 88 DE        mov al, byte ptr [0xde88]
000B  3C 02           cmp al, 2
000D  74 04           je 0x13
000F  3C 0C           cmp al, 0xc
0011  75 07           jne 0x1a
loc_0013:
0013  C6 06 88 DE 06  mov byte ptr [0xde88], 6
0018  EB 14           jmp 0x2e
loc_001A:
001A  A0 88 DE        mov al, byte ptr [0xde88]
001D  3C 0B           cmp al, 0xb
001F  74 08           je 0x29
0021  3C 0E           cmp al, 0xe
0023  72 09           jb 0x2e
0025  3C 0F           cmp al, 0xf
0027  77 05           ja 0x2e
loc_0029:
0029  C6 06 88 DE 05  mov byte ptr [0xde88], 5
loc_002E:
002E  C9              leave
002F  CB              retf

; ---- routine 06E4:0030  (found by: call)
sub_0030:
0030  C8 18 00 00     enter 0x18, 0
0034  C4 3E D2 D7     les di, ptr [0xd7d2]
0038  89 7E F0        mov word ptr [bp - 0x10], di
003B  8C 46 F2        mov word ptr [bp - 0xe], es
003E  26 8A 45 04     mov al, byte ptr es:[di + 4]
0042  30 E4           xor ah, ah
0044  8B F8           mov di, ax
0046  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
004A  30 E4           xor ah, ah
004C  6B C0 3E        imul ax, ax, 0x3e
004F  C4 3E C2 D7     les di, ptr [0xd7c2]
0053  03 F8           add di, ax
0055  81 C7 C2 FF     add di, 0xffc2
0059  89 7E EC        mov word ptr [bp - 0x14], di
005C  8C 46 EE        mov word ptr [bp - 0x12], es
005F  31 C0           xor ax, ax
0061  89 46 F4        mov word ptr [bp - 0xc], ax
0064  89 46 F6        mov word ptr [bp - 0xa], ax
0067  C7 46 F8 01 00  mov word ptr [bp - 8], 1
006C  C7 46 FA 00 00  mov word ptr [bp - 6], 0
0071  EB 08           jmp 0x7b
loc_0073:
0073  83 46 F8 01     add word ptr [bp - 8], 1
0077  83 56 FA 00     adc word ptr [bp - 6], 0
loc_007B:
007B  8B 46 F8        mov ax, word ptr [bp - 8]
007E  D1 E0           shl ax, 1
0080  C4 7E EC        les di, ptr [bp - 0x14]
0083  03 F8           add di, ax
0085  26 83 7D FE 00  cmp word ptr es:[di - 2], 0
008A  74 27           je 0xb3
008C  8B 46 F8        mov ax, word ptr [bp - 8]
008F  D1 E0           shl ax, 1
0091  C4 7E EC        les di, ptr [bp - 0x14]
0094  03 F8           add di, ax
0096  26 6B 45 FE 0F  imul ax, word ptr es:[di - 2], 0xf
009B  C4 3E BE D7     les di, ptr [0xd7be]
009F  03 F8           add di, ax
00A1  26 8A 45 09     mov al, byte ptr es:[di + 9]
00A5  30 E4           xor ah, ah
00A7  50              push ax
00A8  9A 9C 47 51 1B  call far 1B51:479C
00AD  01 46 F4        add word ptr [bp - 0xc], ax
00B0  11 56 F6        adc word ptr [bp - 0xa], dx
loc_00B3:
00B3  8B 46 F8        mov ax, word ptr [bp - 8]
00B6  D1 E0           shl ax, 1
00B8  8B D0           mov dx, ax
00BA  C4 7E F0        les di, ptr [bp - 0x10]
00BD  26 8A 45 04     mov al, byte ptr es:[di + 4]
00C1  30 E4           xor ah, ah
00C3  6B C0 28        imul ax, ax, 0x28
00C6  03 F8           add di, ax
00C8  03 FA           add di, dx
00CA  26 83 7D 2E 00  cmp word ptr es:[di + 0x2e], 0
00CF  74 34           je 0x105
00D1  8B 46 F8        mov ax, word ptr [bp - 8]
00D4  D1 E0           shl ax, 1
00D6  8B D0           mov dx, ax
00D8  C4 7E F0        les di, ptr [bp - 0x10]
00DB  26 8A 45 04     mov al, byte ptr es:[di + 4]
00DF  30 E4           xor ah, ah
00E1  6B C0 28        imul ax, ax, 0x28
00E4  03 F8           add di, ax
00E6  03 FA           add di, dx
00E8  26 6B 45 2E 0F  imul ax, word ptr es:[di + 0x2e], 0xf
00ED  C4 3E BE D7     les di, ptr [0xd7be]
00F1  03 F8           add di, ax
00F3  26 8A 45 09     mov al, byte ptr es:[di + 9]
00F7  30 E4           xor ah, ah
00F9  50              push ax
00FA  9A 9C 47 51 1B  call far 1B51:479C
00FF  01 46 F4        add word ptr [bp - 0xc], ax
0102  11 56 F6        adc word ptr [bp - 0xa], dx
loc_0105:
0105  83 7E FA 00     cmp word ptr [bp - 6], 0
0109  74 03           je 0x10e
010B  E9 65 FF        jmp 0x73
loc_010E:
010E  83 7E F8 14     cmp word ptr [bp - 8], 0x14
0112  74 03           je 0x117
0114  E9 5C FF        jmp 0x73
loc_0117:
0117  C4 7E F0        les di, ptr [bp - 0x10]
011A  26 8A 05        mov al, byte ptr es:[di]
011D  30 E4           xor ah, ah
011F  8B F0           mov si, ax
0121  D1 E0           shl ax, 1
0123  01 F0           add ax, si
0125  8B D0           mov dx, ax
0127  26 8A 45 04     mov al, byte ptr es:[di + 4]
012B  30 E4           xor ah, ah
012D  8B F8           mov di, ax
012F  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
0133  30 E4           xor ah, ah
0135  69 C0 AE 00     imul ax, ax, 0xae
0139  C4 3E CA D7     les di, ptr [0xd7ca]
013D  03 F8           add di, ax
013F  03 FA           add di, dx
0141  81 C7 4F FF     add di, 0xff4f
0145  26 80 7D 01 00  cmp byte ptr es:[di + 1], 0
014A  74 63           je 0x1af
014C  26 8A 05        mov al, byte ptr es:[di]
014F  3C 01           cmp al, 1
0151  72 08           jb 0x15b
0153  3C 02           cmp al, 2
0155  76 58           jbe 0x1af
0157  3C 09           cmp al, 9
0159  74 54           je 0x1af
loc_015B:
015B  C4 7E F0        les di, ptr [bp - 0x10]
015E  26 8A 45 04     mov al, byte ptr es:[di + 4]
0162  30 E4           xor ah, ah
0164  8B F8           mov di, ax
0166  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
016A  30 E4           xor ah, ah
016C  50              push ax
016D  C4 7E F0        les di, ptr [bp - 0x10]
0170  26 8A 05        mov al, byte ptr es:[di]
0173  30 E4           xor ah, ah
0175  50              push ax
0176  9A 95 16 51 1B  call far 1B51:1695
017B  08 C0           or al, al
017D  74 30           je 0x1af
017F  8B 46 F4        mov ax, word ptr [bp - 0xc]
0182  8B 56 F6        mov dx, word ptr [bp - 0xa]
0185  B9 05 00        mov cx, 5
0188  31 DB           xor bx, bx
018A  9A 67 0A B9 26  call far 26B9:0A67
018F  8B C8           mov cx, ax
0191  8B DA           mov bx, dx
0193  C4 7E F0        les di, ptr [bp - 0x10]
0196  26 8A 45 04     mov al, byte ptr es:[di + 4]
019A  30 E4           xor ah, ah
019C  6B C0 5E        imul ax, ax, 0x5e
019F  C4 3E C4 DC     les di, ptr [0xdcc4]
01A3  03 F8           add di, ax
01A5  26 89 4D F0     mov word ptr es:[di - 0x10], cx
01A9  26 89 5D F2     mov word ptr es:[di - 0xe], bx
01AD  EB 1C           jmp 0x1cb
loc_01AF:
01AF  C4 7E F0        les di, ptr [bp - 0x10]
01B2  26 8A 45 04     mov al, byte ptr es:[di + 4]
01B6  30 E4           xor ah, ah
01B8  6B C0 5E        imul ax, ax, 0x5e
01BB  C4 3E C4 DC     les di, ptr [0xdcc4]
01BF  03 F8           add di, ax
01C1  31 C0           xor ax, ax
01C3  26 89 45 F0     mov word ptr es:[di - 0x10], ax
01C7  26 89 45 F2     mov word ptr es:[di - 0xe], ax
loc_01CB:
01CB  8B 46 F4        mov ax, word ptr [bp - 0xc]
01CE  8B 56 F6        mov dx, word ptr [bp - 0xa]
01D1  89 46 FC        mov word ptr [bp - 4], ax
01D4  89 56 FE        mov word ptr [bp - 2], dx
01D7  8B 46 FC        mov ax, word ptr [bp - 4]
01DA  8B 56 FE        mov dx, word ptr [bp - 2]
01DD  C9              leave
01DE  C3              ret

; ---- routine 06E4:01DF  (found by: call, far)
sub_01DF:
01DF  C8 0A 00 00     enter 0xa, 0
01E3  8B 46 06        mov ax, word ptr [bp + 6]
01E6  C1 E0 02        shl ax, 2
01E9  C4 3E C8 DC     les di, ptr [0xdcc8]
01ED  03 F8           add di, ax
01EF  26 8A 45 02     mov al, byte ptr es:[di + 2]
01F3  30 E4           xor ah, ah
01F5  89 46 FA        mov word ptr [bp - 6], ax
01F8  26 8A 45 03     mov al, byte ptr es:[di + 3]
01FC  98              cwde
01FD  8B F8           mov di, ax
01FF  8A 85 DC 02     mov al, byte ptr [di + 0x2dc]
0203  30 E4           xor ah, ah
0205  F7 66 FA        mul word ptr [bp - 6]
0208  31 D2           xor dx, dx
020A  89 46 FC        mov word ptr [bp - 4], ax
020D  89 56 FE        mov word ptr [bp - 2], dx
0210  8B 46 FC        mov ax, word ptr [bp - 4]
0213  8B 56 FE        mov dx, word ptr [bp - 2]
0216  C9              leave
0217  CA 02 00        retf 2

; ---- routine 06E4:021A  (found by: call)
sub_021A:
021A  C8 0E 00 00     enter 0xe, 0
021E  C4 3E D2 D7     les di, ptr [0xd7d2]
0222  89 7E F6        mov word ptr [bp - 0xa], di
0225  8C 46 F8        mov word ptr [bp - 8], es
0228  31 C0           xor ax, ax
022A  89 46 FC        mov word ptr [bp - 4], ax
022D  C6 46 FB 01     mov byte ptr [bp - 5], 1
0231  EB 03           jmp 0x236
loc_0233:
0233  FE 46 FB        inc byte ptr [bp - 5]
loc_0236:
0236  C4 7E F6        les di, ptr [bp - 0xa]
0239  26 8A 45 04     mov al, byte ptr es:[di + 4]
023D  30 E4           xor ah, ah
023F  8B F8           mov di, ax
0241  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
0245  30 E4           xor ah, ah
0247  6B C0 3E        imul ax, ax, 0x3e
024A  C4 3E C2 D7     les di, ptr [0xd7c2]
024E  03 F8           add di, ax
0250  81 C7 C2 FF     add di, 0xffc2
0254  8A 46 FB        mov al, byte ptr [bp - 5]
0257  98              cwde
0258  D1 E0           shl ax, 1
025A  03 F8           add di, ax
025C  26 FF 75 28     push word ptr es:[di + 0x28]
0260  0E              push cs
0261  E8 7B FF        call 0x1df
0264  01 46 FC        add word ptr [bp - 4], ax
0267  80 7E FB 04     cmp byte ptr [bp - 5], 4
026B  75 C6           jne 0x233
026D  8B 46 FC        mov ax, word ptr [bp - 4]
0270  89 46 FE        mov word ptr [bp - 2], ax
0273  8B 46 FE        mov ax, word ptr [bp - 2]
0276  C9              leave
0277  C3              ret

; ---- routine 06E4:0278  (found by: call)
sub_0278:
0278  C8 0A 00 00     enter 0xa, 0
027C  C4 3E D2 D7     les di, ptr [0xd7d2]
0280  26 8A 45 04     mov al, byte ptr es:[di + 4]
0284  30 E4           xor ah, ah
0286  6B C0 5E        imul ax, ax, 0x5e
0289  C4 3E C4 DC     les di, ptr [0xdcc4]
028D  03 F8           add di, ax
028F  81 C7 A2 FF     add di, 0xffa2
0293  89 7E FA        mov word ptr [bp - 6], di
0296  8C 46 FC        mov word ptr [bp - 4], es
0299  31 C0           xor ax, ax
029B  26 89 45 06     mov word ptr es:[di + 6], ax
029F  26 89 45 08     mov word ptr es:[di + 8], ax
02A3  31 C0           xor ax, ax
02A5  26 89 45 0A     mov word ptr es:[di + 0xa], ax
02A9  26 89 45 0C     mov word ptr es:[di + 0xc], ax
02AD  C4 3E D2 D7     les di, ptr [0xd7d2]
02B1  26 8A 45 04     mov al, byte ptr es:[di + 4]
02B5  30 E4           xor ah, ah
02B7  8B F8           mov di, ax
02B9  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
02BD  30 E4           xor ah, ah
02BF  89 46 FE        mov word ptr [bp - 2], ax
02C2  C4 3E D2 D7     les di, ptr [0xd7d2]
02C6  26 8A 05        mov al, byte ptr es:[di]
02C9  30 E4           xor ah, ah
02CB  8B F0           mov si, ax
02CD  D1 E0           shl ax, 1
02CF  01 F0           add ax, si
02D1  8B D0           mov dx, ax
02D3  69 46 FE AE 00  imul ax, word ptr [bp - 2], 0xae
02D8  C4 3E CA D7     les di, ptr [0xd7ca]
02DC  03 F8           add di, ax
02DE  03 FA           add di, dx
02E0  81 C7 4F FF     add di, 0xff4f
02E4  89 7E F6        mov word ptr [bp - 0xa], di
02E7  8C 46 F8        mov word ptr [bp - 8], es
02EA  26 80 7D 01 00  cmp byte ptr es:[di + 1], 0
02EF  74 0B           je 0x2fc
02F1  26 8A 05        mov al, byte ptr es:[di]
02F4  3C 01           cmp al, 1
02F6  72 07           jb 0x2ff
02F8  3C 02           cmp al, 2
02FA  77 03           ja 0x2ff
loc_02FC:
02FC  E9 7F 00        jmp 0x37e
loc_02FF:
02FF  C4 7E F6        les di, ptr [bp - 0xa]
0302  26 80 3D 00     cmp byte ptr es:[di], 0
0306  75 21           jne 0x329
0308  6B 46 FE 3E     imul ax, word ptr [bp - 2], 0x3e
030C  C4 3E C2 D7     les di, ptr [0xd7c2]
0310  03 F8           add di, ax
0312  26 8A 45 F9     mov al, byte ptr es:[di - 7]
0316  98              cwde
0317  8B F8           mov di, ax
0319  8A 85 E8 02     mov al, byte ptr [di + 0x2e8]
031D  30 E4           xor ah, ah
031F  50              push ax
0320  9A 1C 0D AC 24  call far 24AC:0D1C
0325  08 C0           or al, al
0327  74 0F           je 0x338
loc_0329:
0329  C4 7E FA        les di, ptr [bp - 6]
032C  26 C7 45 06 10 27 mov word ptr es:[di + 6], 0x2710
0332  26 C7 45 08 00 00 mov word ptr es:[di + 8], 0
loc_0338:
0338  C4 7E FA        les di, ptr [bp - 6]
033B  26 8B 45 06     mov ax, word ptr es:[di + 6]
033F  26 0B 45 08     or ax, word ptr es:[di + 8]
0343  75 2A           jne 0x36f
0345  C4 7E F6        les di, ptr [bp - 0xa]
0348  26 80 3D 00     cmp byte ptr es:[di], 0
034C  75 21           jne 0x36f
034E  6B 46 FE 3E     imul ax, word ptr [bp - 2], 0x3e
0352  C4 3E C2 D7     les di, ptr [0xd7c2]
0356  03 F8           add di, ax
0358  26 8A 45 F9     mov al, byte ptr es:[di - 7]
035C  98              cwde
035D  8B F8           mov di, ax
035F  8A 85 E2 02     mov al, byte ptr [di + 0x2e2]
0363  30 E4           xor ah, ah
0365  50              push ax
0366  9A 1C 0D AC 24  call far 24AC:0D1C
036B  08 C0           or al, al
036D  74 0F           je 0x37e
loc_036F:
036F  C4 7E FA        les di, ptr [bp - 6]
0372  26 C7 45 0A E8 03 mov word ptr es:[di + 0xa], 0x3e8
0378  26 C7 45 0C 00 00 mov word ptr es:[di + 0xc], 0
loc_037E:
037E  C9              leave
037F  C3              ret

; ---- routine 06E4:0380  (found by: call)
sub_0380:
0380  C8 0C 00 00     enter 0xc, 0
0384  8B 7E 04        mov di, word ptr [bp + 4]
0387  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
038B  30 E4           xor ah, ah
038D  6B C0 3E        imul ax, ax, 0x3e
0390  C4 3E C2 D7     les di, ptr [0xd7c2]
0394  03 F8           add di, ax
0396  81 C7 C2 FF     add di, 0xffc2
039A  89 7E FC        mov word ptr [bp - 4], di
039D  8C 46 FE        mov word ptr [bp - 2], es
03A0  6B 46 04 5E     imul ax, word ptr [bp + 4], 0x5e
03A4  C4 3E C4 DC     les di, ptr [0xdcc4]
03A8  03 F8           add di, ax
03AA  81 C7 A2 FF     add di, 0xffa2
03AE  89 7E F8        mov word ptr [bp - 8], di
03B1  8C 46 FA        mov word ptr [bp - 6], es
03B4  31 C0           xor ax, ax
03B6  26 89 45 12     mov word ptr es:[di + 0x12], ax
03BA  26 89 45 14     mov word ptr es:[di + 0x14], ax
03BE  C4 3E D2 D7     les di, ptr [0xd7d2]
03C2  26 8A 05        mov al, byte ptr es:[di]
03C5  30 E4           xor ah, ah
03C7  8B F0           mov si, ax
03C9  D1 E0           shl ax, 1
03CB  01 F0           add ax, si
03CD  8B D0           mov dx, ax
03CF  8B 7E 04        mov di, word ptr [bp + 4]
03D2  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
03D6  30 E4           xor ah, ah
03D8  69 C0 AE 00     imul ax, ax, 0xae
03DC  C4 3E CA D7     les di, ptr [0xd7ca]
03E0  03 F8           add di, ax
03E2  03 FA           add di, dx
03E4  81 C7 4F FF     add di, 0xff4f
03E8  26 80 7D 01 00  cmp byte ptr es:[di + 1], 0
03ED  74 0B           je 0x3fa
03EF  26 8A 05        mov al, byte ptr es:[di]
03F2  3C 01           cmp al, 1
03F4  72 13           jb 0x409
03F6  3C 02           cmp al, 2
03F8  77 0F           ja 0x409
loc_03FA:
03FA  C4 7E F8        les di, ptr [bp - 8]
03FD  31 C0           xor ax, ax
03FF  26 89 45 16     mov word ptr es:[di + 0x16], ax
0403  26 89 45 18     mov word ptr es:[di + 0x18], ax
0407  EB 36           jmp 0x43f
loc_0409:
0409  6A 00           push 0
040B  68 F4 01        push 0x1f4
040E  8B 7E 04        mov di, word ptr [bp + 4]
0411  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
0415  30 E4           xor ah, ah
0417  50              push ax
0418  9A AE 35 51 1B  call far 1B51:35AE
041D  B9 78 00        mov cx, 0x78
0420  31 DB           xor bx, bx
0422  9A 67 0A B9 26  call far 26B9:0A67
0427  05 A8 E4        add ax, 0xe4a8
042A  83 D2 FF        adc dx, -1
042D  52              push dx
042E  50              push ax
042F  9A C0 04 AC 24  call far 24AC:04C0
0434  C4 7E F8        les di, ptr [bp - 8]
0437  26 89 45 16     mov word ptr es:[di + 0x16], ax
043B  26 89 55 18     mov word ptr es:[di + 0x18], dx
loc_043F:
043F  C4 7E FC        les di, ptr [bp - 4]
0442  26 83 7D 30 00  cmp word ptr es:[di + 0x30], 0
0447  75 03           jne 0x44c
0449  E9 8B 00        jmp 0x4d7
loc_044C:
044C  C4 7E F8        les di, ptr [bp - 8]
044F  26 83 7D 54 00  cmp word ptr es:[di + 0x54], 0
0454  7C 09           jl 0x45f
0456  7F 50           jg 0x4a8
0458  26 83 7D 52 00  cmp word ptr es:[di + 0x52], 0
045D  73 49           jae 0x4a8
loc_045F:
045F  C4 7E FC        les di, ptr [bp - 4]
0462  26 8B 45 30     mov ax, word ptr es:[di + 0x30]
0466  C1 E0 02        shl ax, 2
0469  C4 3E C8 DC     les di, ptr [0xdcc8]
046D  03 F8           add di, ax
046F  26 8A 45 02     mov al, byte ptr es:[di + 2]
0473  30 E4           xor ah, ah
0475  8B D0           mov dx, ax
0477  B8 B0 00        mov ax, 0xb0
047A  2B C2           sub ax, dx
047C  05 20 00        add ax, 0x20
047F  C1 E8 02        shr ax, 2
0482  50              push ax
0483  9A 1C 0D AC 24  call far 24AC:0D1C
0488  08 C0           or al, al
048A  74 1C           je 0x4a8
048C  8B 7E 04        mov di, word ptr [bp + 4]
048F  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
0493  30 E4           xor ah, ah
0495  50              push ax
0496  9A 2A 38 51 1B  call far 1B51:382A
049B  C4 7E F8        les di, ptr [bp - 8]
049E  26 89 45 12     mov word ptr es:[di + 0x12], ax
04A2  26 89 55 14     mov word ptr es:[di + 0x14], dx
04A6  EB 2F           jmp 0x4d7
loc_04A8:
04A8  C4 7E F8        les di, ptr [bp - 8]
04AB  26 81 7D 54 E6 05 cmp word ptr es:[di + 0x54], 0x5e6
04B1  7F 0A           jg 0x4bd
04B3  7C 22           jl 0x4d7
04B5  26 81 7D 52 C0 9E cmp word ptr es:[di + 0x52], 0x9ec0
04BB  76 1A           jbe 0x4d7
loc_04BD:
04BD  C4 7E F8        les di, ptr [bp - 8]
04C0  26 8B 45 52     mov ax, word ptr es:[di + 0x52]
04C4  26 8B 55 54     mov dx, word ptr es:[di + 0x54]
04C8  2D C0 9E        sub ax, 0x9ec0
04CB  81 DA E6 05     sbb dx, 0x5e6
04CF  26 01 45 16     add word ptr es:[di + 0x16], ax
04D3  26 11 55 18     adc word ptr es:[di + 0x18], dx
loc_04D7:
04D7  C9              leave
04D8  C2 02 00        ret 2

; ---- routine 06E4:04DB  (found by: call)
sub_04DB:
04DB  C8 04 00 00     enter 4, 0
04DF  6B 46 04 5E     imul ax, word ptr [bp + 4], 0x5e
04E3  C4 3E C4 DC     les di, ptr [0xdcc4]
04E7  03 F8           add di, ax
04E9  81 C7 A2 FF     add di, 0xffa2
04ED  89 7E FC        mov word ptr [bp - 4], di
04F0  8C 46 FE        mov word ptr [bp - 2], es
04F3  8B 7E 04        mov di, word ptr [bp + 4]
04F6  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
04FA  30 E4           xor ah, ah
04FC  50              push ax
04FD  9A 60 26 51 1B  call far 1B51:2660
0502  B9 04 00        mov cx, 4
0505  31 DB           xor bx, bx
0507  9A 67 0A B9 26  call far 26B9:0A67
050C  C4 7E FC        les di, ptr [bp - 4]
050F  26 89 45 46     mov word ptr es:[di + 0x46], ax
0513  26 89 55 48     mov word ptr es:[di + 0x48], dx
0517  C9              leave
0518  C2 02 00        ret 2

; ---- routine 06E4:051B  (found by: call)
sub_051B:
051B  C8 08 00 00     enter 8, 0
051F  8B 7E 04        mov di, word ptr [bp + 4]
0522  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
0526  30 E4           xor ah, ah
0528  6B C0 3E        imul ax, ax, 0x3e
052B  C4 3E C2 D7     les di, ptr [0xd7c2]
052F  03 F8           add di, ax
0531  81 C7 C2 FF     add di, 0xffc2
0535  89 7E F8        mov word ptr [bp - 8], di
0538  8C 46 FA        mov word ptr [bp - 6], es
053B  26 80 7D 36 03  cmp byte ptr es:[di + 0x36], 3
0540  76 02           jbe 0x544
0542  EB 4E           jmp 0x592
loc_0544:
0544  C4 7E F8        les di, ptr [bp - 8]
0547  26 8A 45 36     mov al, byte ptr es:[di + 0x36]
054B  30 E4           xor ah, ah
054D  8B D0           mov dx, ax
054F  26 8A 45 37     mov al, byte ptr es:[di + 0x37]
0553  98              cwde
0554  8B F8           mov di, ax
0556  8B F7           mov si, di
0558  D1 E7           shl di, 1
055A  01 F7           add di, si
055C  03 FA           add di, dx
055E  8A 85 ED 02     mov al, byte ptr [di + 0x2ed]
0562  30 E4           xor ah, ah
0564  31 D2           xor dx, dx
0566  89 46 FC        mov word ptr [bp - 4], ax
0569  89 56 FE        mov word ptr [bp - 2], dx
056C  8B 46 FC        mov ax, word ptr [bp - 4]
056F  8B 56 FE        mov dx, word ptr [bp - 2]
0572  B9 E8 03        mov cx, 0x3e8
0575  31 DB           xor bx, bx
0577  9A 2A 0A B9 26  call far 26B9:0A2A
057C  8B C8           mov cx, ax
057E  8B DA           mov bx, dx
0580  6B 46 04 5E     imul ax, word ptr [bp + 4], 0x5e
0584  C4 3E C4 DC     les di, ptr [0xdcc4]
0588  03 F8           add di, ax
058A  26 01 4D C4     add word ptr es:[di - 0x3c], cx
058E  26 11 5D C6     adc word ptr es:[di - 0x3a], bx
loc_0592:
0592  C9              leave
0593  C2 02 00        ret 2

; ---- routine 06E4:0596  (found by: call)
sub_0596:
0596  C8 0A 00 00     enter 0xa, 0
059A  6B 46 04 5E     imul ax, word ptr [bp + 4], 0x5e
059E  C4 3E C4 DC     les di, ptr [0xdcc4]
05A2  03 F8           add di, ax
05A4  81 C7 A2 FF     add di, 0xffa2
05A8  89 7E FA        mov word ptr [bp - 6], di
05AB  8C 46 FC        mov word ptr [bp - 4], es
05AE  C4 3E D2 D7     les di, ptr [0xd7d2]
05B2  26 8A 05        mov al, byte ptr es:[di]
05B5  30 E4           xor ah, ah
05B7  99              cdq
05B8  B9 06 00        mov cx, 6
05BB  F7 F9           idiv cx
05BD  92              xchg dx, ax
05BE  09 C0           or ax, ax
05C0  74 10           je 0x5d2
05C2  C4 7E FA        les di, ptr [bp - 6]
05C5  31 C0           xor ax, ax
05C7  26 89 45 0E     mov word ptr es:[di + 0xe], ax
05CB  26 89 45 10     mov word ptr es:[di + 0x10], ax
05CF  E9 81 00        jmp 0x653
loc_05D2:
05D2  C4 3E D2 D7     les di, ptr [0xd7d2]
05D6  26 8A 45 04     mov al, byte ptr es:[di + 4]
05DA  30 E4           xor ah, ah
05DC  8B F8           mov di, ax
05DE  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
05E2  30 E4           xor ah, ah
05E4  6B C0 3E        imul ax, ax, 0x3e
05E7  C4 3E C2 D7     les di, ptr [0xd7c2]
05EB  03 F8           add di, ax
05ED  81 C7 C2 FF     add di, 0xffc2
05F1  89 7E F6        mov word ptr [bp - 0xa], di
05F4  8C 46 F8        mov word ptr [bp - 8], es
05F7  26 8A 45 37     mov al, byte ptr es:[di + 0x37]
05FB  98              cwde
05FC  8B F8           mov di, ax
05FE  8A 85 FE 02     mov al, byte ptr [di + 0x2fe]
0602  30 E4           xor ah, ah
0604  31 D2           xor dx, dx
0606  C4 7E FA        les di, ptr [bp - 6]
0609  26 89 45 0E     mov word ptr es:[di + 0xe], ax
060D  26 89 55 10     mov word ptr es:[di + 0x10], dx
0611  26 8B 45 0E     mov ax, word ptr es:[di + 0xe]
0615  26 8B 55 10     mov dx, word ptr es:[di + 0x10]
0619  B9 E8 03        mov cx, 0x3e8
061C  31 DB           xor bx, bx
061E  9A 2A 0A B9 26  call far 26B9:0A2A
0623  C4 7E FA        les di, ptr [bp - 6]
0626  26 89 45 0E     mov word ptr es:[di + 0xe], ax
062A  26 89 55 10     mov word ptr es:[di + 0x10], dx
062E  C4 7E F6        les di, ptr [bp - 0xa]
0631  26 8A 45 36     mov al, byte ptr es:[di + 0x36]
0635  30 E4           xor ah, ah
0637  8B D0           mov dx, ax
0639  B8 11 00        mov ax, 0x11
063C  2B C2           sub ax, dx
063E  89 46 FE        mov word ptr [bp - 2], ax
0641  69 46 FE E8 03  imul ax, word ptr [bp - 2], 0x3e8
0646  31 D2           xor dx, dx
0648  C4 7E FA        les di, ptr [bp - 6]
064B  26 01 45 0E     add word ptr es:[di + 0xe], ax
064F  26 11 55 10     adc word ptr es:[di + 0x10], dx
loc_0653:
0653  C9              leave
0654  C2 02 00        ret 2

; ---- routine 06E4:0657  (found by: call)
sub_0657:
0657  55              push bp
0658  89 E5           mov bp, sp
065A  C4 7E 06        les di, ptr [bp + 6]
065D  26 8B 05        mov ax, word ptr es:[di]
0660  26 8B 55 02     mov dx, word ptr es:[di + 2]
0664  C4 7E 0A        les di, ptr [bp + 0xa]
0667  26 89 05        mov word ptr es:[di], ax
066A  26 89 55 02     mov word ptr es:[di + 2], dx
066E  C4 7E 06        les di, ptr [bp + 6]
0671  31 C0           xor ax, ax
0673  26 89 05        mov word ptr es:[di], ax
0676  26 89 45 02     mov word ptr es:[di + 2], ax
067A  C9              leave
067B  C2 0A 00        ret 0xa

; ---- routine 06E4:067E  (found by: far)
sub_067E:
067E  C8 0C 00 00     enter 0xc, 0
0682  C4 3E D2 D7     les di, ptr [0xd7d2]
0686  89 7E FA        mov word ptr [bp - 6], di
0689  8C 46 FC        mov word ptr [bp - 4], es
068C  26 8A 45 03     mov al, byte ptr es:[di + 3]
0690  30 E4           xor ah, ah
0692  89 46 F8        mov word ptr [bp - 8], ax
0695  B8 01 00        mov ax, 1
0698  3B 46 F8        cmp ax, word ptr [bp - 8]
069B  76 03           jbe 0x6a0
069D  E9 01 02        jmp 0x8a1
loc_06A0:
06A0  89 46 FE        mov word ptr [bp - 2], ax
06A3  EB 03           jmp 0x6a8
loc_06A5:
06A5  FF 46 FE        inc word ptr [bp - 2]
loc_06A8:
06A8  8A 46 FE        mov al, byte ptr [bp - 2]
06AB  C4 7E FA        les di, ptr [bp - 6]
06AE  26 88 45 04     mov byte ptr es:[di + 4], al
06B2  8B 7E FE        mov di, word ptr [bp - 2]
06B5  80 BD B9 DC 00  cmp byte ptr [di - 0x2347], 0
06BA  75 03           jne 0x6bf
06BC  E9 D2 01        jmp 0x891
loc_06BF:
06BF  6B 46 FE 5E     imul ax, word ptr [bp - 2], 0x5e
06C3  C4 3E C4 DC     les di, ptr [0xdcc4]
06C7  03 F8           add di, ax
06C9  81 C7 A2 FF     add di, 0xffa2
06CD  89 7E F4        mov word ptr [bp - 0xc], di
06D0  8C 46 F6        mov word ptr [bp - 0xa], es
06D3  E8 5A F9        call 0x30
06D6  C4 7E F4        les di, ptr [bp - 0xc]
06D9  26 89 45 4A     mov word ptr es:[di + 0x4a], ax
06DD  26 89 55 4C     mov word ptr es:[di + 0x4c], dx
06E1  E8 36 FB        call 0x21a
06E4  C4 7E F4        les di, ptr [bp - 0xc]
06E7  26 89 45 04     mov word ptr es:[di + 4], ax
06EB  C4 7E FA        les di, ptr [bp - 6]
06EE  26 8A 45 04     mov al, byte ptr es:[di + 4]
06F2  30 E4           xor ah, ah
06F4  50              push ax
06F5  E8 9E FE        call 0x596
06F8  E8 7D FB        call 0x278
06FB  C4 7E FA        les di, ptr [bp - 6]
06FE  26 8A 45 04     mov al, byte ptr es:[di + 4]
0702  30 E4           xor ah, ah
0704  50              push ax
0705  E8 D3 FD        call 0x4db
0708  C4 7E FA        les di, ptr [bp - 6]
070B  26 8A 45 04     mov al, byte ptr es:[di + 4]
070F  30 E4           xor ah, ah
0711  50              push ax
0712  E8 6B FC        call 0x380
0715  C4 7E FA        les di, ptr [bp - 6]
0718  26 80 3D 3A     cmp byte ptr es:[di], 0x3a
071C  75 0A           jne 0x728
071E  26 8A 45 04     mov al, byte ptr es:[di + 4]
0722  30 E4           xor ah, ah
0724  50              push ax
0725  E8 F3 FD        call 0x51b
loc_0728:
0728  C4 7E F4        les di, ptr [bp - 0xc]
072B  26 8B 45 1A     mov ax, word ptr es:[di + 0x1a]
072F  26 8B 55 1C     mov dx, word ptr es:[di + 0x1c]
0733  26 03 45 22     add ax, word ptr es:[di + 0x22]
0737  26 13 55 24     adc dx, word ptr es:[di + 0x24]
073B  26 03 45 06     add ax, word ptr es:[di + 6]
073F  26 13 55 08     adc dx, word ptr es:[di + 8]
0743  26 03 45 0A     add ax, word ptr es:[di + 0xa]
0747  26 13 55 0C     adc dx, word ptr es:[di + 0xc]
074B  26 03 45 0E     add ax, word ptr es:[di + 0xe]
074F  26 13 55 10     adc dx, word ptr es:[di + 0x10]
0753  26 03 45 2A     add ax, word ptr es:[di + 0x2a]
0757  26 13 55 2C     adc dx, word ptr es:[di + 0x2c]
075B  26 03 45 12     add ax, word ptr es:[di + 0x12]
075F  26 13 55 14     adc dx, word ptr es:[di + 0x14]
0763  26 89 45 56     mov word ptr es:[di + 0x56], ax
0767  26 89 55 58     mov word ptr es:[di + 0x58], dx
076B  26 83 7D 54 FF  cmp word ptr es:[di + 0x54], -1
0770  7F 0A           jg 0x77c
0772  7C 17           jl 0x78b
0774  26 81 7D 52 6C FD cmp word ptr es:[di + 0x52], 0xfd6c
077A  72 0F           jb 0x78b
loc_077C:
077C  C4 7E F4        les di, ptr [bp - 0xc]
077F  31 C0           xor ax, ax
0781  26 89 45 42     mov word ptr es:[di + 0x42], ax
0785  26 89 45 44     mov word ptr es:[di + 0x44], ax
0789  EB 2B           jmp 0x7b6
loc_078B:
078B  C4 7E F4        les di, ptr [bp - 0xc]
078E  26 8B 45 52     mov ax, word ptr es:[di + 0x52]
0792  26 8B 55 54     mov dx, word ptr es:[di + 0x54]
0796  09 D2           or dx, dx
0798  79 07           jns 0x7a1
079A  F7 D2           not dx
079C  F7 D8           neg ax
079E  83 DA FF        sbb dx, -1
loc_07A1:
07A1  B9 94 02        mov cx, 0x294
07A4  31 DB           xor bx, bx
07A6  9A 67 0A B9 26  call far 26B9:0A67
07AB  C4 7E F4        les di, ptr [bp - 0xc]
07AE  26 89 45 42     mov word ptr es:[di + 0x42], ax
07B2  26 89 55 44     mov word ptr es:[di + 0x44], dx
loc_07B6:
07B6  C4 7E F4        les di, ptr [bp - 0xc]
07B9  26 8B 45 04     mov ax, word ptr es:[di + 4]
07BD  31 D2           xor dx, dx
07BF  8B C8           mov cx, ax
07C1  8B DA           mov bx, dx
07C3  26 8B 45 42     mov ax, word ptr es:[di + 0x42]
07C7  26 8B 55 44     mov dx, word ptr es:[di + 0x44]
07CB  26 03 45 32     add ax, word ptr es:[di + 0x32]
07CF  26 13 55 34     adc dx, word ptr es:[di + 0x34]
07D3  26 03 45 3A     add ax, word ptr es:[di + 0x3a]
07D7  26 13 55 3C     adc dx, word ptr es:[di + 0x3c]
07DB  26 03 45 16     add ax, word ptr es:[di + 0x16]
07DF  26 13 55 18     adc dx, word ptr es:[di + 0x18]
07E3  26 03 45 46     add ax, word ptr es:[di + 0x46]
07E7  26 13 55 48     adc dx, word ptr es:[di + 0x48]
07EB  26 03 45 4A     add ax, word ptr es:[di + 0x4a]
07EF  26 13 55 4C     adc dx, word ptr es:[di + 0x4c]
07F3  03 C1           add ax, cx
07F5  13 D3           adc dx, bx
07F7  26 03 45 4E     add ax, word ptr es:[di + 0x4e]
07FB  26 13 55 50     adc dx, word ptr es:[di + 0x50]
07FF  26 89 45 5A     mov word ptr es:[di + 0x5a], ax
0803  26 89 55 5C     mov word ptr es:[di + 0x5c], dx
0807  26 8B 45 5A     mov ax, word ptr es:[di + 0x5a]
080B  26 8B 55 5C     mov dx, word ptr es:[di + 0x5c]
080F  F7 D2           not dx
0811  F7 D8           neg ax
0813  83 DA FF        sbb dx, -1
0816  26 03 45 56     add ax, word ptr es:[di + 0x56]
081A  26 13 55 58     adc dx, word ptr es:[di + 0x58]
081E  26 01 45 52     add word ptr es:[di + 0x52], ax
0822  26 11 55 54     adc word ptr es:[di + 0x54], dx
0826  81 C7 1E 00     add di, 0x1e
082A  06              push es
082B  57              push di
082C  C4 7E F4        les di, ptr [bp - 0xc]
082F  81 C7 1A 00     add di, 0x1a
0833  06              push es
0834  57              push di
0835  55              push bp
0836  E8 1E FE        call 0x657
0839  C4 7E F4        les di, ptr [bp - 0xc]
083C  81 C7 26 00     add di, 0x26
0840  06              push es
0841  57              push di
0842  C4 7E F4        les di, ptr [bp - 0xc]
0845  81 C7 22 00     add di, 0x22
0849  06              push es
084A  57              push di
084B  55              push bp
084C  E8 08 FE        call 0x657
084F  C4 7E F4        les di, ptr [bp - 0xc]
0852  81 C7 2E 00     add di, 0x2e
0856  06              push es
0857  57              push di
0858  C4 7E F4        les di, ptr [bp - 0xc]
085B  81 C7 2A 00     add di, 0x2a
085F  06              push es
0860  57              push di
0861  55              push bp
0862  E8 F2 FD        call 0x657
0865  C4 7E F4        les di, ptr [bp - 0xc]
0868  81 C7 3E 00     add di, 0x3e
086C  06              push es
086D  57              push di
086E  C4 7E F4        les di, ptr [bp - 0xc]
0871  81 C7 3A 00     add di, 0x3a
0875  06              push es
0876  57              push di
0877  55              push bp
0878  E8 DC FD        call 0x657
087B  C4 7E F4        les di, ptr [bp - 0xc]
087E  81 C7 36 00     add di, 0x36
0882  06              push es
0883  57              push di
0884  C4 7E F4        les di, ptr [bp - 0xc]
0887  81 C7 32 00     add di, 0x32
088B  06              push es
088C  57              push di
088D  55              push bp
088E  E8 C6 FD        call 0x657
loc_0891:
0891  9A 4F 38 51 1B  call far 1B51:384F
0896  8B 46 FE        mov ax, word ptr [bp - 2]
0899  3B 46 F8        cmp ax, word ptr [bp - 8]
089C  74 03           je 0x8a1
089E  E9 04 FE        jmp 0x6a5
loc_08A1:
08A1  C9              leave
08A2  CB              retf

; ---- routine 06E4:08A3  (found by: call)
sub_08A3:
08A3  C8 06 00 00     enter 6, 0
08A7  8B 46 0A        mov ax, word ptr [bp + 0xa]
08AA  D1 E8           shr ax, 1
08AC  89 46 FA        mov word ptr [bp - 6], ax
08AF  B8 01 00        mov ax, 1
08B2  3B 46 FA        cmp ax, word ptr [bp - 6]
08B5  77 6B           ja 0x922
08B7  89 46 FE        mov word ptr [bp - 2], ax
08BA  EB 03           jmp 0x8bf
loc_08BC:
08BC  FF 46 FE        inc word ptr [bp - 2]
loc_08BF:
08BF  C7 46 FC 01 00  mov word ptr [bp - 4], 1
08C4  EB 03           jmp 0x8c9
loc_08C6:
08C6  FF 46 FC        inc word ptr [bp - 4]
loc_08C9:
08C9  FF 76 0A        push word ptr [bp + 0xa]
08CC  9A 6D 07 1A 23  call far 231A:076D
08D1  8B F8           mov di, ax
08D3  81 C7 FB D4     add di, 0xd4fb
08D7  1E              push ds
08D8  57              push di
08D9  8B 7E 0A        mov di, word ptr [bp + 0xa]
08DC  81 C7 FB D4     add di, 0xd4fb
08E0  1E              push ds
08E1  57              push di
08E2  6A 01           push 1
08E4  9A 03 02 AC 24  call far 24AC:0203
08E9  FF 4E 0A        dec word ptr [bp + 0xa]
08EC  83 7E FC 02     cmp word ptr [bp - 4], 2
08F0  75 D4           jne 0x8c6
08F2  8B 46 0A        mov ax, word ptr [bp + 0xa]
08F5  40              inc ax
08F6  8B F8           mov di, ax
08F8  8A 85 FB D4     mov al, byte ptr [di - 0x2b05]
08FC  50              push ax
08FD  8B 46 0A        mov ax, word ptr [bp + 0xa]
0900  40              inc ax
0901  40              inc ax
0902  8B F8           mov di, ax
0904  8A 85 FB D4     mov al, byte ptr [di - 0x2b05]
0908  50              push ax
0909  8A 46 08        mov al, byte ptr [bp + 8]
090C  50              push ax
090D  8A 46 06        mov al, byte ptr [bp + 6]
0910  50              push ax
0911  8A 46 04        mov al, byte ptr [bp + 4]
0914  50              push ax
0915  9A F9 3A 51 1B  call far 1B51:3AF9
091A  8B 46 FE        mov ax, word ptr [bp - 2]
091D  3B 46 FA        cmp ax, word ptr [bp - 6]
0920  75 9A           jne 0x8bc
loc_0922:
0922  C9              leave
0923  C2 08 00        ret 8

; ---- routine 06E4:0926  (found by: call)
sub_0926:
0926  C8 04 00 00     enter 4, 0
092A  8B 7E 04        mov di, word ptr [bp + 4]
092D  36 C7 45 FC 40 00 mov word ptr ss:[di - 4], 0x40
0933  36 80 7D 06 03  cmp byte ptr ss:[di + 6], 3
0938  75 25           jne 0x95f
093A  C7 46 FE 11 00  mov word ptr [bp - 2], 0x11
093F  EB 03           jmp 0x944
loc_0941:
0941  FF 46 FE        inc word ptr [bp - 2]
loc_0944:
0944  8B 7E FE        mov di, word ptr [bp - 2]
0947  8A 95 D5 D7     mov dl, byte ptr [di - 0x282b]
094B  8B 46 FE        mov ax, word ptr [bp - 2]
094E  2D 10 00        sub ax, 0x10
0951  8B F8           mov di, ax
0953  88 95 FB D4     mov byte ptr [di - 0x2b05], dl
0957  83 7E FE 50     cmp word ptr [bp - 2], 0x50
095B  75 E4           jne 0x941
095D  EB 4B           jmp 0x9aa
loc_095F:
095F  31 C0           xor ax, ax
0961  89 46 FC        mov word ptr [bp - 4], ax
0964  C7 46 FE 01 00  mov word ptr [bp - 2], 1
0969  EB 03           jmp 0x96e
loc_096B:
096B  FF 46 FE        inc word ptr [bp - 2]
loc_096E:
096E  8B 7E FE        mov di, word ptr [bp - 2]
0971  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
0975  30 E4           xor ah, ah
0977  50              push ax
0978  9A EE 1A 51 1B  call far 1B51:1AEE
097D  08 C0           or al, al
097F  74 22           je 0x9a3
0981  FF 46 FC        inc word ptr [bp - 4]
0984  8B 7E FE        mov di, word ptr [bp - 2]
0987  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
098B  8B 7E FC        mov di, word ptr [bp - 4]
098E  88 85 FB D4     mov byte ptr [di - 0x2b05], al
0992  8B 46 FC        mov ax, word ptr [bp - 4]
0995  8B 7E 04        mov di, word ptr [bp + 4]
0998  36 3B 45 FC     cmp ax, word ptr ss:[di - 4]
099C  75 05           jne 0x9a3
099E  C7 46 FE B0 00  mov word ptr [bp - 2], 0xb0
loc_09A3:
09A3  81 7E FE B0 00  cmp word ptr [bp - 2], 0xb0
09A8  75 C1           jne 0x96b
loc_09AA:
09AA  C9              leave
09AB  C2 02 00        ret 2

; ---- routine 06E4:09AE  (found by: call)
sub_09AE:
09AE  C8 06 00 00     enter 6, 0
09B2  8B 7E 04        mov di, word ptr [bp + 4]
09B5  36 8A 45 08     mov al, byte ptr ss:[di + 8]
09B9  3C 25           cmp al, 0x25
09BB  74 08           je 0x9c5
09BD  3C 33           cmp al, 0x33
09BF  74 04           je 0x9c5
09C1  B0 00           mov al, 0
09C3  EB 02           jmp 0x9c7
loc_09C5:
09C5  B0 01           mov al, 1
loc_09C7:
09C7  30 E4           xor ah, ah
09C9  40              inc ax
09CA  89 46 FC        mov word ptr [bp - 4], ax
09CD  8B 7E 04        mov di, word ptr [bp + 4]
09D0  36 8B 45 FC     mov ax, word ptr ss:[di - 4]
09D4  89 46 FA        mov word ptr [bp - 6], ax
09D7  B8 01 00        mov ax, 1
09DA  3B 46 FA        cmp ax, word ptr [bp - 6]
09DD  77 22           ja 0xa01
09DF  89 46 FE        mov word ptr [bp - 2], ax
09E2  EB 03           jmp 0x9e7
loc_09E4:
09E4  FF 46 FE        inc word ptr [bp - 2]
loc_09E7:
09E7  8B 7E FE        mov di, word ptr [bp - 2]
09EA  8A 85 FB D4     mov al, byte ptr [di - 0x2b05]
09EE  30 E4           xor ah, ah
09F0  50              push ax
09F1  FF 76 FC        push word ptr [bp - 4]
09F4  9A 7C 4A 51 1B  call far 1B51:4A7C
09F9  8B 46 FE        mov ax, word ptr [bp - 2]
09FC  3B 46 FA        cmp ax, word ptr [bp - 6]
09FF  75 E3           jne 0x9e4
loc_0A01:
0A01  8B 7E 04        mov di, word ptr [bp + 4]
0A04  36 83 7D FC 02  cmp word ptr ss:[di - 4], 2
0A09  75 35           jne 0xa40
0A0B  36 80 7D 06 03  cmp byte ptr ss:[di + 6], 3
0A10  75 18           jne 0xa2a
0A12  BF FC D4        mov di, 0xd4fc
0A15  1E              push ds
0A16  57              push di
0A17  C4 3E D2 D7     les di, ptr [0xd7d2]
0A1B  81 C7 0F 00     add di, 0xf
0A1F  06              push es
0A20  57              push di
0A21  6A 02           push 2
0A23  9A C2 01 AC 24  call far 24AC:01C2
0A28  EB 16           jmp 0xa40
loc_0A2A:
0A2A  BF FC D4        mov di, 0xd4fc
0A2D  1E              push ds
0A2E  57              push di
0A2F  C4 3E D2 D7     les di, ptr [0xd7d2]
0A33  81 C7 11 00     add di, 0x11
0A37  06              push es
0A38  57              push di
0A39  6A 02           push 2
0A3B  9A C2 01 AC 24  call far 24AC:01C2
loc_0A40:
0A40  C9              leave
0A41  C2 02 00        ret 2

; ---- routine 06E4:0A44  (found by: call)
sub_0A44:
0A44  C8 08 00 00     enter 8, 0
0A48  8B 46 08        mov ax, word ptr [bp + 8]
0A4B  8B 7E 04        mov di, word ptr [bp + 4]
0A4E  36 89 45 FC     mov word ptr ss:[di - 4], ax
0A52  31 C0           xor ax, ax
0A54  89 46 FC        mov word ptr [bp - 4], ax
0A57  C7 46 FE 01 00  mov word ptr [bp - 2], 1
0A5C  EB 03           jmp 0xa61
loc_0A5E:
0A5E  FF 46 FE        inc word ptr [bp - 2]
loc_0A61:
0A61  8B 46 06        mov ax, word ptr [bp + 6]
0A64  8B F0           mov si, ax
0A66  D1 E0           shl ax, 1
0A68  01 F0           add ax, si
0A6A  8B D0           mov dx, ax
0A6C  8B 7E FE        mov di, word ptr [bp - 2]
0A6F  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
0A73  30 E4           xor ah, ah
0A75  69 C0 AE 00     imul ax, ax, 0xae
0A79  C4 3E CA D7     les di, ptr [0xd7ca]
0A7D  03 F8           add di, ax
0A7F  03 FA           add di, dx
0A81  81 C7 4F FF     add di, 0xff4f
0A85  26 80 7D 01 00  cmp byte ptr es:[di + 1], 0
0A8A  74 33           je 0xabf
0A8C  26 8A 05        mov al, byte ptr es:[di]
0A8F  8B 7E 04        mov di, word ptr [bp + 4]
0A92  36 3A 45 06     cmp al, byte ptr ss:[di + 6]
0A96  75 27           jne 0xabf
0A98  8B 7E FE        mov di, word ptr [bp - 2]
0A9B  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
0A9F  30 E4           xor ah, ah
0AA1  50              push ax
0AA2  FF 76 06        push word ptr [bp + 6]
0AA5  9A 95 16 51 1B  call far 1B51:1695
0AAA  08 C0           or al, al
0AAC  74 11           je 0xabf
0AAE  FF 46 FC        inc word ptr [bp - 4]
0AB1  8B 7E FE        mov di, word ptr [bp - 2]
0AB4  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
0AB8  8B 7E FC        mov di, word ptr [bp - 4]
0ABB  88 85 FB D4     mov byte ptr [di - 0x2b05], al
loc_0ABF:
0ABF  81 7E FE B0 00  cmp word ptr [bp - 2], 0xb0
0AC4  75 98           jne 0xa5e
0AC6  8B 7E 04        mov di, word ptr [bp + 4]
0AC9  57              push di
0ACA  E8 E1 FE        call 0x9ae
0ACD  C9              leave
0ACE  C2 06 00        ret 6

; ---- routine 06E4:0AD1  (found by: far)
sub_0AD1:
0AD1  C8 0C 00 00     enter 0xc, 0
0AD5  C4 3E D2 D7     les di, ptr [0xd7d2]
0AD9  89 7E F6        mov word ptr [bp - 0xa], di
0ADC  8C 46 F8        mov word ptr [bp - 8], es
0ADF  80 7E 06 03     cmp byte ptr [bp + 6], 3
0AE3  75 53           jne 0xb38
0AE5  8A 46 08        mov al, byte ptr [bp + 8]
0AE8  3C 08           cmp al, 8
0AEA  75 06           jne 0xaf2
0AEC  55              push bp
0AED  E8 36 FE        call 0x926
0AF0  EB 44           jmp 0xb36
loc_0AF2:
0AF2  3C 0E           cmp al, 0xe
0AF4  75 0A           jne 0xb00
0AF6  6A 20           push 0x20
0AF8  6A 08           push 8
0AFA  55              push bp
0AFB  E8 46 FF        call 0xa44
0AFE  EB 36           jmp 0xb36
loc_0B00:
0B00  3C 12           cmp al, 0x12
0B02  75 0A           jne 0xb0e
0B04  6A 10           push 0x10
0B06  6A 0E           push 0xe
0B08  55              push bp
0B09  E8 38 FF        call 0xa44
0B0C  EB 28           jmp 0xb36
loc_0B0E:
0B0E  3C 19           cmp al, 0x19
0B10  75 0A           jne 0xb1c
0B12  6A 08           push 8
0B14  6A 12           push 0x12
0B16  55              push bp
0B17  E8 2A FF        call 0xa44
0B1A  EB 1A           jmp 0xb36
loc_0B1C:
0B1C  3C 1F           cmp al, 0x1f
0B1E  75 0A           jne 0xb2a
0B20  6A 04           push 4
0B22  6A 19           push 0x19
0B24  55              push bp
0B25  E8 1C FF        call 0xa44
0B28  EB 0C           jmp 0xb36
loc_0B2A:
0B2A  3C 25           cmp al, 0x25
0B2C  75 08           jne 0xb36
0B2E  6A 02           push 2
0B30  6A 1F           push 0x1f
0B32  55              push bp
0B33  E8 0E FF        call 0xa44
loc_0B36:
0B36  EB 57           jmp 0xb8f
loc_0B38:
0B38  80 7E 06 04     cmp byte ptr [bp + 6], 4
0B3C  75 51           jne 0xb8f
0B3E  8A 46 08        mov al, byte ptr [bp + 8]
0B41  3C 17           cmp al, 0x17
0B43  75 06           jne 0xb4b
0B45  55              push bp
0B46  E8 DD FD        call 0x926
0B49  EB 44           jmp 0xb8f
loc_0B4B:
0B4B  3C 1D           cmp al, 0x1d
0B4D  75 0A           jne 0xb59
0B4F  6A 20           push 0x20
0B51  6A 17           push 0x17
0B53  55              push bp
0B54  E8 ED FE        call 0xa44
0B57  EB 36           jmp 0xb8f
loc_0B59:
0B59  3C 23           cmp al, 0x23
0B5B  75 0A           jne 0xb67
0B5D  6A 10           push 0x10
0B5F  6A 1D           push 0x1d
0B61  55              push bp
0B62  E8 DF FE        call 0xa44
0B65  EB 28           jmp 0xb8f
loc_0B67:
0B67  3C 29           cmp al, 0x29
0B69  75 0A           jne 0xb75
0B6B  6A 08           push 8
0B6D  6A 23           push 0x23
0B6F  55              push bp
0B70  E8 D1 FE        call 0xa44
0B73  EB 1A           jmp 0xb8f
loc_0B75:
0B75  3C 2E           cmp al, 0x2e
0B77  75 0A           jne 0xb83
0B79  6A 04           push 4
0B7B  6A 29           push 0x29
0B7D  55              push bp
0B7E  E8 C3 FE        call 0xa44
0B81  EB 0C           jmp 0xb8f
loc_0B83:
0B83  3C 33           cmp al, 0x33
0B85  75 08           jne 0xb8f
0B87  6A 02           push 2
0B89  6A 2E           push 0x2e
0B8B  55              push bp
0B8C  E8 B5 FE        call 0xa44
loc_0B8F:
0B8F  FF 76 FC        push word ptr [bp - 4]
0B92  8A 46 08        mov al, byte ptr [bp + 8]
0B95  30 E4           xor ah, ah
0B97  50              push ax
0B98  8A 46 06        mov al, byte ptr [bp + 6]
0B9B  50              push ax
0B9C  6A 01           push 1
0B9E  E8 02 FD        call 0x8a3
0BA1  80 7E 08 08     cmp byte ptr [bp + 8], 8
0BA5  74 06           je 0xbad
0BA7  80 7E 08 17     cmp byte ptr [bp + 8], 0x17
0BAB  75 02           jne 0xbaf
loc_0BAD:
0BAD  EB 70           jmp 0xc1f
loc_0BAF:
0BAF  C6 06 D6 02 01  mov byte ptr [0x2d6], 1
0BB4  8A 46 06        mov al, byte ptr [bp + 6]
0BB7  50              push ax
0BB8  6A 01           push 1
0BBA  0E              push cs
0BBB  E8 73 0F        call 0x1b31
0BBE  C6 06 D6 02 00  mov byte ptr [0x2d6], 0
0BC3  8A 46 08        mov al, byte ptr [bp + 8]
0BC6  3C 0E           cmp al, 0xe
0BC8  74 14           je 0xbde
0BCA  3C 12           cmp al, 0x12
0BCC  74 10           je 0xbde
0BCE  3C 19           cmp al, 0x19
0BD0  74 0C           je 0xbde
0BD2  3C 1D           cmp al, 0x1d
0BD4  74 08           je 0xbde
0BD6  3C 23           cmp al, 0x23
0BD8  74 04           je 0xbde
0BDA  3C 29           cmp al, 0x29
0BDC  75 0B           jne 0xbe9
loc_0BDE:
0BDE  8A 46 08        mov al, byte ptr [bp + 8]
0BE1  30 E4           xor ah, ah
0BE3  50              push ax
0BE4  9A CD 3C 51 1B  call far 1B51:3CCD
loc_0BE9:
0BE9  C4 7E F6        les di, ptr [bp - 0xa]
0BEC  26 8A 45 03     mov al, byte ptr es:[di + 3]
0BF0  30 E4           xor ah, ah
0BF2  89 46 F4        mov word ptr [bp - 0xc], ax
0BF5  B8 01 00        mov ax, 1
0BF8  3B 46 F4        cmp ax, word ptr [bp - 0xc]
0BFB  77 22           ja 0xc1f
0BFD  89 46 FE        mov word ptr [bp - 2], ax
0C00  EB 03           jmp 0xc05
loc_0C02:
0C02  FF 46 FE        inc word ptr [bp - 2]
loc_0C05:
0C05  FF 76 FE        push word ptr [bp - 2]
0C08  8A 46 08        mov al, byte ptr [bp + 8]
0C0B  30 E4           xor ah, ah
0C0D  50              push ax
0C0E  8A 46 06        mov al, byte ptr [bp + 6]
0C11  50              push ax
0C12  9A 11 34 51 1B  call far 1B51:3411
0C17  8B 46 FE        mov ax, word ptr [bp - 2]
0C1A  3B 46 F4        cmp ax, word ptr [bp - 0xc]
0C1D  75 E3           jne 0xc02
loc_0C1F:
0C1F  C9              leave
0C20  CA 04 00        retf 4

