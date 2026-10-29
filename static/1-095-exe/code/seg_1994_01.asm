; 1-095.EXE (One-Nil 95), code segment 1994 (image offsets 19940..1B50F), part 1 of 3
; packed 1-095.EXE sha256 f659fb2d334500d6901fc8d6a0f06c85c0ccda2eb4a3035ae3bb0a0004d79192 (LZEXE 0.91)
; unpacked (tools/static/unlzexe.py) sha256 8df646e017e0965a5d90a58181ca764219ad847833aad0b6cb58fc53372bfb2c
; tool: capstone 5.0.9 (pip package; core library 5.0.1280) (CS_ARCH_X86, CS_MODE_16), recursive descent from the entry point, far calls and near calls/jumps, then routine prologues (55 89 E5 / 55 8B EC / C8 iw 00) in what remains; tools/static/listing.py
; addresses are SEGMENT:OFFSET with SEGMENT the image paragraph before relocation; image offset = SEGMENT*16+OFFSET
; data (not reached as code), 8 bytes
0000                  db 50 53 51 52 56 57 1E 06   ; PSQRVW..

; ---- routine 1994:0008  (found by: prologue)
sub_0008:
0008  55              push bp
0009  89 E5           mov bp, sp
000B  B8 54 28        mov ax, 0x2854   ; relocated segment word 2854
000E  8E D8           mov ds, ax
0010  83 3E 88 D0 00  cmp word ptr [0xd088], 0
0015  76 04           jbe 0x1b
0017  FF 0E 88 D0     dec word ptr [0xd088]
loc_001B:
001B  83 3E 5A 0D 40  cmp word ptr [0xd5a], 0x40
0020  75 08           jne 0x2a
0022  C7 06 5A 0D 01 00 mov word ptr [0xd5a], 1
0028  EB 24           jmp 0x4e
loc_002A:
002A  FF 06 5A 0D     inc word ptr [0xd5a]
002E  C4 3E 26 DE     les di, ptr [0xde26]
0032  26 83 7D 02 00  cmp word ptr es:[di + 2], 0
0037  7F 08           jg 0x41
0039  7C 13           jl 0x4e
003B  26 83 3D 00     cmp word ptr es:[di], 0
003F  76 0D           jbe 0x4e
loc_0041:
0041  C4 3E 26 DE     les di, ptr [0xde26]
0045  26 83 2D 01     sub word ptr es:[di], 1
0049  26 83 5D 02 00  sbb word ptr es:[di + 2], 0
loc_004E:
004E  C9              leave
004F  07              pop es
0050  1F              pop ds
0051  5F              pop di
0052  5E              pop si
0053  5A              pop dx
0054  59              pop cx
0055  5B              pop bx
0056  58              pop ax
0057  CF              iret

; ---- routine 1994:0058  (found by: call)
sub_0058:
0058  55              push bp
0059  89 E5           mov bp, sp
005B  80 7E 04 00     cmp byte ptr [bp + 4], 0
005F  74 11           je 0x72
0061  6A 1C           push 0x1c
0063  BF 00 00        mov di, 0
0066  B8 94 19        mov ax, 0x1994   ; relocated segment word 1994
0069  50              push ax
006A  57              push di
006B  9A 94 00 A8 26  call far 26A8:0094
0070  EB 0F           jmp 0x81
loc_0072:
0072  6A 1C           push 0x1c
0074  FF 36 D2 D1     push word ptr [0xd1d2]
0078  FF 36 D0 D1     push word ptr [0xd1d0]
007C  9A 94 00 A8 26  call far 26A8:0094
loc_0081:
0081  C9              leave
0082  C2 02 00        ret 2

; ---- routine 1994:0085  (found by: call)
sub_0085:
0085  55              push bp
0086  89 E5           mov bp, sp
0088  6A 1C           push 0x1c
008A  BF D0 D1        mov di, 0xd1d0
008D  1E              push ds
008E  57              push di
008F  9A 7C 00 A8 26  call far 26A8:007C
0094  C9              leave
0095  C3              ret

; ---- routine 1994:0096  (found by: call)
sub_0096:
0096  55              push bp
0097  89 E5           mov bp, sp
0099  B0 36           mov al, 0x36
009B  E6 43           out 0x43, al
009D  8A 46 04        mov al, byte ptr [bp + 4]
00A0  E6 40           out 0x40, al
00A2  8A 46 05        mov al, byte ptr [bp + 5]
00A5  E6 40           out 0x40, al
00A7  C9              leave
00A8  C2 02 00        ret 2

; ---- routine 1994:00AB  (found by: call, far)
sub_00AB:
00AB  55              push bp
00AC  89 E5           mov bp, sp
00AE  6A FF           push -1
00B0  E8 E3 FF        call 0x96
00B3  6A 00           push 0
00B5  E8 A0 FF        call 0x58
00B8  C9              leave
00B9  CB              retf

; ---- routine 1994:00BA  (found by: far)
sub_00BA:
00BA  55              push bp
00BB  89 E5           mov bp, sp
00BD  E8 C5 FF        call 0x85
00C0  6A 01           push 1
00C2  E8 93 FF        call 0x58
00C5  68 00 04        push 0x400
00C8  E8 CB FF        call 0x96
00CB  C9              leave
00CC  CB              retf

; ---- routine 1994:00CD  (found by: far)
sub_00CD:
00CD  55              push bp
00CE  89 E5           mov bp, sp
00D0  0E              push cs
00D1  E8 D7 FF        call 0xab
00D4  C9              leave
00D5  CB              retf

; ---- routine 1994:00D6  (found by: call, far)
sub_00D6:
00D6  55              push bp
00D7  89 E5           mov bp, sp
00D9  C4 3E D2 D7     les di, ptr [0xd7d2]
00DD  26 80 7D 02 00  cmp byte ptr es:[di + 2], 0
00E2  75 02           jne 0xe6
00E4  EB 16           jmp 0xfc
loc_00E6:
00E6  8B 46 06        mov ax, word ptr [bp + 6]
00E9  A3 88 D0        mov word ptr [0xd088], ax
loc_00EC:
00EC  9A 58 0C AC 24  call far 24AC:0C58
00F1  08 C0           or al, al
00F3  75 07           jne 0xfc
00F5  83 3E 88 D0 00  cmp word ptr [0xd088], 0
00FA  75 F0           jne 0xec
loc_00FC:
00FC  C9              leave
00FD  CA 02 00        retf 2

; ---- routine 1994:0100  (found by: call)
sub_0100:
0100  55              push bp
0101  89 E5           mov bp, sp
0103  80 3E EC A2 00  cmp byte ptr [0xa2ec], 0
0108  75 26           jne 0x130
010A  9A 40 02 1A 23  call far 231A:0240
010F  8B 46 04        mov ax, word ptr [bp + 4]
0112  31 D2           xor dx, dx
0114  8B C8           mov cx, ax
0116  8B DA           mov bx, dx
0118  B8 DD 34        mov ax, 0x34dd
011B  BA 12 00        mov dx, 0x12
011E  9A 67 0A B9 26  call far 26B9:0A67
0123  89 46 04        mov word ptr [bp + 4], ax
0126  8A 46 04        mov al, byte ptr [bp + 4]
0129  E6 42           out 0x42, al
012B  8A 46 05        mov al, byte ptr [bp + 5]
012E  E6 42           out 0x42, al
loc_0130:
0130  C9              leave
0131  C2 02 00        ret 2

; ---- routine 1994:0134  (found by: far)
sub_0134:
0134  55              push bp
0135  89 E5           mov bp, sp
0137  C4 3E D2 D7     les di, ptr [0xd7d2]
013B  26 80 7D 02 00  cmp byte ptr es:[di + 2], 0
0140  75 02           jne 0x144
0142  EB 12           jmp 0x156
loc_0144:
0144  FF 76 08        push word ptr [bp + 8]
0147  E8 B6 FF        call 0x100
014A  FF 76 06        push word ptr [bp + 6]
014D  0E              push cs
014E  E8 85 FF        call 0xd6
0151  9A 2E 02 1A 23  call far 231A:022E
loc_0156:
0156  C9              leave
0157  CA 04 00        retf 4

; ---- routine 1994:015A  (found by: call)
sub_015A:
015A  C8 02 00 00     enter 2, 0
015E  80 3E EC A2 00  cmp byte ptr [0xa2ec], 0
0163  75 77           jne 0x1dc
0165  A0 5E 0D        mov al, byte ptr [0xd5e]
0168  30 E4           xor ah, ah
016A  01 46 06        add word ptr [bp + 6], ax
loc_016D:
016D  83 7E 06 0B     cmp word ptr [bp + 6], 0xb
0171  76 09           jbe 0x17c
0173  FF 46 08        inc word ptr [bp + 8]
0176  83 6E 06 0C     sub word ptr [bp + 6], 0xc
017A  EB F1           jmp 0x16d
loc_017C:
017C  B8 0B 00        mov ax, 0xb
017F  2B 46 06        sub ax, word ptr [bp + 6]
0182  31 D2           xor dx, dx
0184  9A EC 12 B9 26  call far 26B9:12EC
0189  B9 84 00        mov cx, 0x84
018C  31 F6           xor si, si
018E  BF 00 40        mov di, 0x4000
0191  9A DE 12 B9 26  call far 26B9:12DE
0196  52              push dx
0197  53              push bx
0198  50              push ax
0199  B8 0F 00        mov ax, 0xf
019C  2B 46 08        sub ax, word ptr [bp + 8]
019F  31 D2           xor dx, dx
01A1  9A EC 12 B9 26  call far 26B9:12EC
01A6  59              pop cx
01A7  5E              pop si
01A8  5F              pop di
01A9  9A C6 12 B9 26  call far 26B9:12C6
01AE  52              push dx
01AF  53              push bx
01B0  50              push ax
01B1  B8 82 00        mov ax, 0x82
01B4  31 DB           xor bx, bx
01B6  31 D2           xor dx, dx
01B8  9A 9C 14 B9 26  call far 26B9:149C
01BD  59              pop cx
01BE  5E              pop si
01BF  5F              pop di
01C0  9A D8 12 B9 26  call far 26B9:12D8
01C5  9A 45 15 B9 26  call far 26B9:1545
01CA  9A F8 12 B9 26  call far 26B9:12F8
01CF  89 46 FE        mov word ptr [bp - 2], ax
01D2  8A 46 FE        mov al, byte ptr [bp - 2]
01D5  E6 42           out 0x42, al
01D7  8A 46 FF        mov al, byte ptr [bp - 1]
01DA  E6 42           out 0x42, al
loc_01DC:
01DC  C9              leave
01DD  C2 06 00        ret 6

; ---- routine 1994:01E0  (found by: far)
sub_01E0:
01E0  C8 06 00 00     enter 6, 0
01E4  C4 3E D2 D7     les di, ptr [0xd7d2]
01E8  26 80 7D 02 00  cmp byte ptr es:[di + 2], 0
01ED  75 02           jne 0x1f1
01EF  EB 36           jmp 0x227
loc_01F1:
01F1  9A 40 02 1A 23  call far 231A:0240
01F6  8B 46 06        mov ax, word ptr [bp + 6]
01F9  F7 26 5C 0D     mul word ptr [0xd5c]
01FD  A3 88 D0        mov word ptr [0xd088], ax
loc_0200:
0200  6A 06           push 6
0202  6A 09           push 9
0204  6A 01           push 1
0206  E8 51 FF        call 0x15a
0209  6A 06           push 6
020B  6A 07           push 7
020D  6A 01           push 1
020F  E8 48 FF        call 0x15a
0212  9A 58 0C AC 24  call far 24AC:0C58
0217  08 C0           or al, al
0219  75 07           jne 0x222
021B  83 3E 88 D0 00  cmp word ptr [0xd088], 0
0220  75 DE           jne 0x200
loc_0222:
0222  9A 2E 02 1A 23  call far 231A:022E
loc_0227:
0227  C9              leave
0228  CA 02 00        retf 2

; ---- routine 1994:022B  (found by: call, far)
sub_022B:
022B  C8 02 00 00     enter 2, 0
022F  8B 46 06        mov ax, word ptr [bp + 6]
0232  3D 0C 00        cmp ax, 0xc
0235  75 07           jne 0x23e
0237  C7 46 FE 0A 00  mov word ptr [bp - 2], 0xa
023C  EB 2E           jmp 0x26c
loc_023E:
023E  3D 16 00        cmp ax, 0x16
0241  75 07           jne 0x24a
0243  C7 46 FE 14 00  mov word ptr [bp - 2], 0x14
0248  EB 22           jmp 0x26c
loc_024A:
024A  3D 21 00        cmp ax, 0x21
024D  75 07           jne 0x256
024F  C7 46 FE 1B 00  mov word ptr [bp - 2], 0x1b
0254  EB 16           jmp 0x26c
loc_0256:
0256  3D 2B 00        cmp ax, 0x2b
0259  75 07           jne 0x262
025B  C7 46 FE 27 00  mov word ptr [bp - 2], 0x27
0260  EB 0A           jmp 0x26c
loc_0262:
0262  3D 35 00        cmp ax, 0x35
0265  75 05           jne 0x26c
0267  C7 46 FE 30 00  mov word ptr [bp - 2], 0x30
loc_026C:
026C  8B 46 FE        mov ax, word ptr [bp - 2]
026F  C9              leave
0270  CA 02 00        retf 2

; ---- routine 1994:0273  (found by: call, far)
sub_0273:
0273  C8 06 00 00     enter 6, 0
0277  8B 46 06        mov ax, word ptr [bp + 6]
027A  8B F0           mov si, ax
027C  D1 E0           shl ax, 1
027E  01 F0           add ax, si
0280  8B D0           mov dx, ax
0282  69 46 08 AE 00  imul ax, word ptr [bp + 8], 0xae
0287  C4 3E CA D7     les di, ptr [0xd7ca]
028B  03 F8           add di, ax
028D  03 FA           add di, dx
028F  81 C7 4F FF     add di, 0xff4f
0293  89 7E FA        mov word ptr [bp - 6], di
0296  8C 46 FC        mov word ptr [bp - 4], es
0299  26 80 3D 06     cmp byte ptr es:[di], 6
029D  75 0B           jne 0x2aa
029F  8A 46 06        mov al, byte ptr [bp + 6]
02A2  3C 0C           cmp al, 0xc
02A4  74 2D           je 0x2d3
02A6  3C 16           cmp al, 0x16
02A8  74 29           je 0x2d3
loc_02AA:
02AA  C4 7E FA        les di, ptr [bp - 6]
02AD  26 8A 05        mov al, byte ptr es:[di]
02B0  3C 07           cmp al, 7
02B2  72 1B           jb 0x2cf
02B4  3C 08           cmp al, 8
02B6  77 17           ja 0x2cf
02B8  8A 46 06        mov al, byte ptr [bp + 6]
02BB  3C 0C           cmp al, 0xc
02BD  74 14           je 0x2d3
02BF  3C 16           cmp al, 0x16
02C1  74 10           je 0x2d3
02C3  3C 21           cmp al, 0x21
02C5  74 0C           je 0x2d3
02C7  3C 2B           cmp al, 0x2b
02C9  74 08           je 0x2d3
02CB  3C 35           cmp al, 0x35
02CD  74 04           je 0x2d3
loc_02CF:
02CF  B0 00           mov al, 0
02D1  EB 02           jmp 0x2d5
loc_02D3:
02D3  B0 01           mov al, 1
loc_02D5:
02D5  88 46 FF        mov byte ptr [bp - 1], al
02D8  8A 46 FF        mov al, byte ptr [bp - 1]
02DB  C9              leave
02DC  CA 04 00        retf 4

; ---- routine 1994:02DF  (found by: call, far)
sub_02DF:
02DF  C8 04 01 00     enter 0x104, 0
02E3  C4 7E 06        les di, ptr [bp + 6]
02E6  89 7E FC        mov word ptr [bp - 4], di
02E9  8C 46 FE        mov word ptr [bp - 2], es
02EC  6A 70           push 0x70
02EE  8D BE FC FE     lea di, [bp - 0x104]
02F2  16              push ss
02F3  57              push di
02F4  A0 C5 D0        mov al, byte ptr [0xd0c5]
02F7  30 E4           xor ah, ah
02F9  31 D2           xor dx, dx
02FB  52              push dx
02FC  50              push ax
02FD  9A C9 07 1A 23  call far 231A:07C9
0302  6A 02           push 2
0304  6A 13           push 0x13
0306  C4 7E FC        les di, ptr [bp - 4]
0309  06              push es
030A  57              push di
030B  9A 0C 03 1A 23  call far 231A:030C
0310  6A 70           push 0x70
0312  8D BE FC FE     lea di, [bp - 0x104]
0316  16              push ss
0317  57              push di
0318  A0 C4 D0        mov al, byte ptr [0xd0c4]
031B  30 E4           xor ah, ah
031D  31 D2           xor dx, dx
031F  52              push dx
0320  50              push ax
0321  9A C9 07 1A 23  call far 231A:07C9
0326  6A 04           push 4
0328  6A 13           push 0x13
032A  C4 7E FC        les di, ptr [bp - 4]
032D  06              push es
032E  57              push di
032F  9A 0C 03 1A 23  call far 231A:030C
0334  C9              leave
0335  CA 04 00        retf 4

; ---- routine 1994:0338  (found by: call)
sub_0338:
0338  C8 00 01 00     enter 0x100, 0
033C  80 3E C7 D0 FF  cmp byte ptr [0xd0c7], 0xff
0341  73 55           jae 0x398
0343  BF 10 1B        mov di, 0x1b10
0346  1E              push ds
0347  57              push di
0348  BF 5C DD        mov di, 0xdd5c
034B  1E              push ds
034C  57              push di
034D  9A 2F 05 1A 23  call far 231A:052F
0352  6A 07           push 7
0354  8D BE 00 FF     lea di, [bp - 0x100]
0358  16              push ss
0359  57              push di
035A  A0 C7 D0        mov al, byte ptr [0xd0c7]
035D  30 E4           xor ah, ah
035F  31 D2           xor dx, dx
0361  52              push dx
0362  50              push ax
0363  9A C9 07 1A 23  call far 231A:07C9
0368  6A 06           push 6
036A  6A 0E           push 0xe
036C  BF 5C DD        mov di, 0xdd5c
036F  1E              push ds
0370  57              push di
0371  9A 0C 03 1A 23  call far 231A:030C
0376  8D BE 00 FF     lea di, [bp - 0x100]
037A  16              push ss
037B  57              push di
037C  A0 C6 D0        mov al, byte ptr [0xd0c6]
037F  30 E4           xor ah, ah
0381  31 D2           xor dx, dx
0383  52              push dx
0384  50              push ax
0385  9A C9 07 1A 23  call far 231A:07C9
038A  6A 06           push 6
038C  6A 10           push 0x10
038E  BF 5C DD        mov di, 0xdd5c
0391  1E              push ds
0392  57              push di
0393  9A 9D 03 1A 23  call far 231A:039D
loc_0398:
0398  C9              leave
0399  C3              ret

; ---- routine 1994:039A  (found by: call)
sub_039A:
039A  55              push bp
039B  89 E5           mov bp, sp
039D  BF DC 1C        mov di, 0x1cdc
03A0  1E              push ds
03A1  57              push di
03A2  BF 5C DD        mov di, 0xdd5c
03A5  1E              push ds
03A6  57              push di
03A7  9A 2F 05 1A 23  call far 231A:052F
03AC  C4 3E D2 D7     les di, ptr [0xd7d2]
03B0  26 8A 05        mov al, byte ptr es:[di]
03B3  30 E4           xor ah, ah
03B5  50              push ax
03B6  0E              push cs
03B7  E8 71 FE        call 0x22b
03BA  8B D0           mov dx, ax
03BC  6B 06 E6 D6 3A  imul ax, word ptr [0xd6e6], 0x3a
03C1  C4 3E CE D7     les di, ptr [0xd7ce]
03C5  03 F8           add di, ax
03C7  03 FA           add di, dx
03C9  26 8A 45 C5     mov al, byte ptr es:[di - 0x3b]
03CD  30 E4           xor ah, ah
03CF  50              push ax
03D0  6A 06           push 6
03D2  6A 4B           push 0x4b
03D4  9A A2 14 51 1B  call far 1B51:14A2
03D9  C9              leave
03DA  C3              ret

; ---- routine 1994:03DB  (found by: call)
sub_03DB:
03DB  C8 02 00 00     enter 2, 0
03DF  C4 7E 08        les di, ptr [bp + 8]
03E2  26 8B 45 02     mov ax, word ptr es:[di + 2]
03E6  26 03 05        add ax, word ptr es:[di]
03E9  09 C0           or ax, ax
03EB  75 02           jne 0x3ef
03ED  EB 62           jmp 0x451
loc_03EF:
03EF  C4 7E 08        les di, ptr [bp + 8]
03F2  26 8B 45 02     mov ax, word ptr es:[di + 2]
03F6  26 03 05        add ax, word ptr es:[di]
03F9  8B C8           mov cx, ax
03FB  26 6B 45 02 18  imul ax, word ptr es:[di + 2], 0x18
0400  31 D2           xor dx, dx
0402  F7 F1           div cx
0404  89 46 FE        mov word ptr [bp - 2], ax
0407  69 46 06 A0 00  imul ax, word ptr [bp + 6], 0xa0
040C  C4 3E 5C DD     les di, ptr [0xdd5c]
0410  03 F8           add di, ax
0412  81 C7 A4 FF     add di, 0xffa4
0416  06              push es
0417  57              push di
0418  A0 C9 D0        mov al, byte ptr [0xd0c9]
041B  50              push ax
041C  FF 76 FE        push word ptr [bp - 2]
041F  9A 4B 03 AC 24  call far 24AC:034B
0424  8B 46 FE        mov ax, word ptr [bp - 2]
0427  05 23 00        add ax, 0x23
042A  D1 E0           shl ax, 1
042C  8B D0           mov dx, ax
042E  69 46 06 A0 00  imul ax, word ptr [bp + 6], 0xa0
0433  C4 3E 5C DD     les di, ptr [0xdd5c]
0437  03 F8           add di, ax
0439  03 FA           add di, dx
043B  81 C7 5E FF     add di, 0xff5e
043F  06              push es
0440  57              push di
0441  A0 C8 D0        mov al, byte ptr [0xd0c8]
0444  50              push ax
0445  B8 18 00        mov ax, 0x18
0448  2B 46 FE        sub ax, word ptr [bp - 2]
044B  50              push ax
044C  9A 4B 03 AC 24  call far 24AC:034B
loc_0451:
0451  C9              leave
0452  C2 08 00        ret 8
; data (not reached as code), 7 bytes
0455                  db 01 20 01 50 02 6F 67   ; . .P.og

; ---- routine 1994:045C  (found by: far)
sub_045C:
045C  C8 08 02 00     enter 0x208, 0
0460  80 3E 18 0D 00  cmp byte ptr [0xd18], 0
0465  74 16           je 0x47d
0467  C4 3E 96 D0     les di, ptr [0xd096]
046B  06              push es
046C  57              push di
046D  C4 3E 8E D0     les di, ptr [0xd08e]
0471  06              push es
0472  57              push di
0473  68 A0 0F        push 0xfa0
0476  9A 12 0A B9 26  call far 26B9:0A12
047B  EB 14           jmp 0x491
loc_047D:
047D  C4 3E 92 D0     les di, ptr [0xd092]
0481  06              push es
0482  57              push di
0483  C4 3E 8E D0     les di, ptr [0xd08e]
0487  06              push es
0488  57              push di
0489  68 A0 0F        push 0xfa0
048C  9A 12 0A B9 26  call far 26B9:0A12
loc_0491:
0491  80 7E 06 00     cmp byte ptr [bp + 6], 0
0495  74 11           je 0x4a8
0497  BF B4 66        mov di, 0x66b4
049A  1E              push ds
049B  57              push di
049C  BF 5C DD        mov di, 0xdd5c
049F  1E              push ds
04A0  57              push di
04A1  9A 2F 05 1A 23  call far 231A:052F
04A6  EB 0F           jmp 0x4b7
loc_04A8:
04A8  BF DA 4E        mov di, 0x4eda
04AB  1E              push ds
04AC  57              push di
04AD  BF 5C DD        mov di, 0xdd5c
04B0  1E              push ds
04B1  57              push di
04B2  9A 2F 05 1A 23  call far 231A:052F
loc_04B7:
04B7  BF AC 35        mov di, 0x35ac
04BA  1E              push ds
04BB  57              push di
04BC  BF 5C DD        mov di, 0xdd5c
04BF  1E              push ds
04C0  57              push di
04C1  9A 2F 05 1A 23  call far 231A:052F
04C6  BF 5C DD        mov di, 0xdd5c
04C9  1E              push ds
04CA  57              push di
04CB  0E              push cs
04CC  E8 10 FE        call 0x2df
04CF  80 3E 75 D0 00  cmp byte ptr [0xd075], 0
04D4  74 12           je 0x4e8
04D6  BF 88 61        mov di, 0x6188
04D9  1E              push ds
04DA  57              push di
04DB  BF 5C DD        mov di, 0xdd5c
04DE  1E              push ds
04DF  57              push di
04E0  9A 2F 05 1A 23  call far 231A:052F
04E5  E9 13 01        jmp 0x5fb
loc_04E8:
04E8  E8 4D FE        call 0x338
04EB  FF 36 E6 D6     push word ptr [0xd6e6]
04EF  C4 3E D2 D7     les di, ptr [0xd7d2]
04F3  26 8A 05        mov al, byte ptr es:[di]
04F6  30 E4           xor ah, ah
04F8  50              push ax
04F9  0E              push cs
04FA  E8 76 FD        call 0x273
04FD  08 C0           or al, al
04FF  74 03           je 0x504
0501  E8 96 FE        call 0x39a
loc_0504:
0504  83 3E 42 D1 00  cmp word ptr [0xd142], 0
0509  74 6F           je 0x57a
050B  BF 30 1B        mov di, 0x1b30
050E  1E              push ds
050F  57              push di
0510  BF 5C DD        mov di, 0xdd5c
0513  1E              push ds
0514  57              push di
0515  9A 2F 05 1A 23  call far 231A:052F
051A  FF 36 42 D1     push word ptr [0xd142]
051E  A1 42 D1        mov ax, word ptr [0xd142]
0521  C1 E0 03        shl ax, 3
0524  C4 3E BA D7     les di, ptr [0xd7ba]
0528  03 F8           add di, ax
052A  26 8A 45 06     mov al, byte ptr es:[di + 6]
052E  30 E4           xor ah, ah
0530  50              push ax
0531  9A 8B 71 51 1B  call far 1B51:718B
0536  50              push ax
0537  8D BE FC FE     lea di, [bp - 0x104]
053B  16              push ss
053C  57              push di
053D  A1 42 D1        mov ax, word ptr [0xd142]
0540  C4 3E AA D7     les di, ptr [0xd7aa]
0544  03 F8           add di, ax
0546  26 8A 05        mov al, byte ptr es:[di]
0549  50              push ax
054A  9A 6F 0C B9 26  call far 26B9:0C6F
054F  6A 16           push 0x16
0551  6A 2B           push 0x2b
0553  BF 5C DD        mov di, 0xdd5c
0556  1E              push ds
0557  57              push di
0558  9A 1B 04 1A 23  call far 231A:041B
055D  8D BE FC FE     lea di, [bp - 0x104]
0561  16              push ss
0562  57              push di
0563  FF 36 42 D1     push word ptr [0xd142]
0567  9A 3C 44 51 1B  call far 1B51:443C
056C  6A 16           push 0x16
056E  6A 2D           push 0x2d
0570  BF 5C DD        mov di, 0xdd5c
0573  1E              push ds
0574  57              push di
0575  9A 9D 03 1A 23  call far 231A:039D
loc_057A:
057A  C6 46 FC 00     mov byte ptr [bp - 4], 0
057E  EB 03           jmp 0x583
loc_0580:
0580  FE 46 FC        inc byte ptr [bp - 4]
loc_0583:
0583  C6 46 FD 00     mov byte ptr [bp - 3], 0
0587  EB 03           jmp 0x58c
loc_0589:
0589  FE 46 FD        inc byte ptr [bp - 3]
loc_058C:
058C  8A 46 FD        mov al, byte ptr [bp - 3]
058F  98              cwde
0590  8B F8           mov di, ax
0592  8A 85 66 0D     mov al, byte ptr [di + 0xd66]
0596  50              push ax
0597  8D BE FC FE     lea di, [bp - 0x104]
059B  16              push ss
059C  57              push di
059D  8A 46 FD        mov al, byte ptr [bp - 3]
05A0  98              cwde
05A1  8B D0           mov dx, ax
05A3  8A 46 FC        mov al, byte ptr [bp - 4]
05A6  98              cwde
05A7  6B F8 0A        imul di, ax, 0xa
05AA  03 FA           add di, dx
05AC  8A 85 D2 D0     mov al, byte ptr [di - 0x2f2e]
05B0  30 E4           xor ah, ah
05B2  31 D2           xor dx, dx
05B4  52              push dx
05B5  50              push ax
05B6  9A C9 07 1A 23  call far 231A:07C9
05BB  8A 46 FD        mov al, byte ptr [bp - 3]
05BE  30 E4           xor ah, ah
05C0  05 09 00        add ax, 9
05C3  50              push ax
05C4  8A 46 FC        mov al, byte ptr [bp - 4]
05C7  98              cwde
05C8  8B F8           mov di, ax
05CA  8A 85 64 0D     mov al, byte ptr [di + 0xd64]
05CE  50              push ax
05CF  BF 5C DD        mov di, 0xdd5c
05D2  1E              push ds
05D3  57              push di
05D4  9A 0C 03 1A 23  call far 231A:030C
05D9  80 7E FD 08     cmp byte ptr [bp - 3], 8
05DD  75 AA           jne 0x589
05DF  80 7E FC 01     cmp byte ptr [bp - 4], 1
05E3  75 9B           jne 0x580
05E5  BF C0 D1        mov di, 0xd1c0
05E8  1E              push ds
05E9  57              push di
05EA  6A 13           push 0x13
05EC  55              push bp
05ED  E8 EB FD        call 0x3db
05F0  BF C4 D1        mov di, 0xd1c4
05F3  1E              push ds
05F4  57              push di
05F5  6A 14           push 0x14
05F7  55              push bp
05F8  E8 E0 FD        call 0x3db
loc_05FB:
05FB  C6 46 FC 00     mov byte ptr [bp - 4], 0
05FF  EB 03           jmp 0x604
loc_0601:
0601  FE 46 FC        inc byte ptr [bp - 4]
loc_0604:
0604  8A 46 FC        mov al, byte ptr [bp - 4]
0607  98              cwde
0608  8B F8           mov di, ax
060A  8A 85 C8 D0     mov al, byte ptr [di - 0x2f38]
060E  50              push ax
060F  8A 46 FC        mov al, byte ptr [bp - 4]
0612  98              cwde
0613  8B F8           mov di, ax
0615  D1 E7           shl di, 1
0617  8B 85 E4 D6     mov ax, word ptr [di - 0x291c]
061B  C1 E0 04        shl ax, 4
061E  C4 3E B2 D7     les di, ptr [0xd7b2]
0622  03 F8           add di, ax
0624  81 C7 F0 FF     add di, 0xfff0
0628  06              push es
0629  57              push di
062A  6A 07           push 7
062C  8A 46 FC        mov al, byte ptr [bp - 4]
062F  98              cwde
0630  8B F8           mov di, ax
0632  8A 85 60 0D     mov al, byte ptr [di + 0xd60]
0636  50              push ax
0637  BF 5C DD        mov di, 0xdd5c
063A  1E              push ds
063B  57              push di
063C  9A 1B 04 1A 23  call far 231A:041B
0641  C7 46 FE 01 00  mov word ptr [bp - 2], 1
0646  EB 03           jmp 0x64b
loc_0648:
0648  FF 46 FE        inc word ptr [bp - 2]
loc_064B:
064B  8B 46 FE        mov ax, word ptr [bp - 2]
064E  8B F0           mov si, ax
0650  D1 E0           shl ax, 1
0652  01 F0           add ax, si
0654  8B D0           mov dx, ax
0656  8A 46 FC        mov al, byte ptr [bp - 4]
0659  98              cwde
065A  6B F8 21        imul di, ax, 0x21
065D  03 FA           add di, dx
065F  81 C7 E3 D0     add di, 0xd0e3
0663  1E              push ds
0664  07              pop es
0665  89 7E F8        mov word ptr [bp - 8], di
0668  8C 46 FA        mov word ptr [bp - 6], es
066B  26 83 3D 00     cmp word ptr es:[di], 0
066F  77 03           ja 0x674
0671  E9 6D 01        jmp 0x7e1
loc_0674:
0674  26 8B 05        mov ax, word ptr es:[di]
0677  C1 E0 03        shl ax, 3
067A  C4 3E BA D7     les di, ptr [0xd7ba]
067E  03 F8           add di, ax
0680  26 8A 45 06     mov al, byte ptr es:[di + 6]
0684  30 E4           xor ah, ah
0686  8B F8           mov di, ax
0688  8A 85 08 87     mov al, byte ptr [di - 0x78f8]
068C  50              push ax
068D  8D BE F8 FE     lea di, [bp - 0x108]
0691  16              push ss
0692  57              push di
0693  C4 7E F8        les di, ptr [bp - 8]
0696  26 8B 05        mov ax, word ptr es:[di]
0699  C4 3E AA D7     les di, ptr [0xd7aa]
069D  03 F8           add di, ax
069F  26 8A 05        mov al, byte ptr es:[di]
06A2  50              push ax
06A3  9A 6F 0C B9 26  call far 26B9:0C6F
06A8  BF 55 04        mov di, 0x455
06AB  0E              push cs
06AC  57              push di
06AD  9A D2 0B B9 26  call far 26B9:0BD2
06B2  8D BE F8 FD     lea di, [bp - 0x208]
06B6  16              push ss
06B7  57              push di
06B8  C4 7E F8        les di, ptr [bp - 8]
06BB  26 FF 35        push word ptr es:[di]
06BE  9A 3C 44 51 1B  call far 1B51:443C
06C3  9A D2 0B B9 26  call far 26B9:0BD2
06C8  8B 46 FE        mov ax, word ptr [bp - 2]
06CB  05 0B 00        add ax, 0xb
06CE  50              push ax
06CF  8A 46 FC        mov al, byte ptr [bp - 4]
06D2  98              cwde
06D3  8B F8           mov di, ax
06D5  8A 85 62 0D     mov al, byte ptr [di + 0xd62]
06D9  50              push ax
06DA  BF 5C DD        mov di, 0xdd5c
06DD  1E              push ds
06DE  57              push di
06DF  9A 1B 04 1A 23  call far 231A:041B
06E4  C7 06 64 DD 04 00 mov word ptr [0xdd64], 4
06EA  C4 7E F8        les di, ptr [bp - 8]
06ED  26 80 7D 02 80  cmp byte ptr es:[di + 2], 0x80
06F2  77 3C           ja 0x730
06F4  8D BE F8 FE     lea di, [bp - 0x108]
06F8  16              push ss
06F9  57              push di
06FA  C4 7E F8        les di, ptr [bp - 8]
06FD  26 8A 45 02     mov al, byte ptr es:[di + 2]
0701  30 E4           xor ah, ah
0703  31 D2           xor dx, dx
0705  52              push dx
0706  50              push ax
0707  9A C9 07 1A 23  call far 231A:07C9
070C  8B 46 FE        mov ax, word ptr [bp - 2]
070F  05 0B 00        add ax, 0xb
0712  50              push ax
0713  8A 46 FC        mov al, byte ptr [bp - 4]
0716  98              cwde
0717  8B F8           mov di, ax
0719  8A 85 62 0D     mov al, byte ptr [di + 0xd62]
071D  30 E4           xor ah, ah
071F  05 12 00        add ax, 0x12
0722  50              push ax
0723  BF 5C DD        mov di, 0xdd5c
0726  1E              push ds
0727  57              push di
0728  9A 83 02 1A 23  call far 231A:0283
072D  E9 B1 00        jmp 0x7e1
loc_0730:
0730  C4 7E F8        les di, ptr [bp - 8]
0733  26 FF 35        push word ptr es:[di]
0736  8A 46 FC        mov al, byte ptr [bp - 4]
0739  98              cwde
073A  8B F8           mov di, ax
073C  D1 E7           shl di, 1
073E  6B 85 E4 D6 3E  imul ax, word ptr [di - 0x291c], 0x3e
0743  C4 3E C2 D7     les di, ptr [0xd7c2]
0747  03 F8           add di, ax
0749  81 C7 C2 FF     add di, 0xffc2
074D  06              push es
074E  57              push di
074F  9A AF 5B 51 1B  call far 1B51:5BAF
0754  09 C0           or ax, ax
0756  74 28           je 0x780
0758  BF 57 04        mov di, 0x457
075B  0E              push cs
075C  57              push di
075D  8B 46 FE        mov ax, word ptr [bp - 2]
0760  05 0B 00        add ax, 0xb
0763  50              push ax
0764  8A 46 FC        mov al, byte ptr [bp - 4]
0767  98              cwde
0768  8B F8           mov di, ax
076A  8A 85 62 0D     mov al, byte ptr [di + 0xd62]
076E  30 E4           xor ah, ah
0770  05 0E 00        add ax, 0xe
0773  50              push ax
0774  BF 5C DD        mov di, 0xdd5c
0777  1E              push ds
0778  57              push di
0779  9A 9D 03 1A 23  call far 231A:039D
077E  EB 26           jmp 0x7a6
loc_0780:
0780  BF 59 04        mov di, 0x459
0783  0E              push cs
0784  57              push di
0785  8B 46 FE        mov ax, word ptr [bp - 2]
0788  05 0B 00        add ax, 0xb
078B  50              push ax
078C  8A 46 FC        mov al, byte ptr [bp - 4]
078F  98              cwde
0790  8B F8           mov di, ax
0792  8A 85 62 0D     mov al, byte ptr [di + 0xd62]
0796  30 E4           xor ah, ah
0798  05 0D 00        add ax, 0xd
079B  50              push ax
079C  BF 5C DD        mov di, 0xdd5c
079F  1E              push ds
07A0  57              push di
07A1  9A 9D 03 1A 23  call far 231A:039D
loc_07A6:
07A6  8D BE F8 FE     lea di, [bp - 0x108]
07AA  16              push ss
07AB  57              push di
07AC  C4 7E F8        les di, ptr [bp - 8]
07AF  26 8A 45 02     mov al, byte ptr es:[di + 2]
07B3  30 E4           xor ah, ah
07B5  2D 80 00        sub ax, 0x80
07B8  99              cdq
07B9  52              push dx
07BA  50              push ax
07BB  9A C9 07 1A 23  call far 231A:07C9
07C0  8B 46 FE        mov ax, word ptr [bp - 2]
07C3  05 0B 00        add ax, 0xb
07C6  50              push ax
07C7  8A 46 FC        mov al, byte ptr [bp - 4]
07CA  98              cwde
07CB  8B F8           mov di, ax
07CD  8A 85 62 0D     mov al, byte ptr [di + 0xd62]
07D1  30 E4           xor ah, ah
07D3  05 12 00        add ax, 0x12
07D6  50              push ax
07D7  BF 5C DD        mov di, 0xdd5c
07DA  1E              push ds
07DB  57              push di
07DC  9A 83 02 1A 23  call far 231A:0283
loc_07E1:
07E1  83 7E FE 0B     cmp word ptr [bp - 2], 0xb
07E5  74 03           je 0x7ea
07E7  E9 5E FE        jmp 0x648
loc_07EA:
07EA  80 7E FC 01     cmp byte ptr [bp - 4], 1
07EE  74 03           je 0x7f3
07F0  E9 0E FE        jmp 0x601
loc_07F3:
07F3  C4 3E 5C DD     les di, ptr [0xdd5c]
07F7  06              push es
07F8  57              push di
07F9  C4 3E 58 DD     les di, ptr [0xdd58]
07FD  06              push es
07FE  57              push di
07FF  68 A0 0F        push 0xfa0
0802  9A 12 0A B9 26  call far 26B9:0A12
0807  80 7E 08 00     cmp byte ptr [bp + 8], 0
080B  74 05           je 0x812
080D  9A 9B 09 1A 23  call far 231A:099B
loc_0812:
0812  C6 06 88 DE 00  mov byte ptr [0xde88], 0
0817  C9              leave
0818  CA 04 00        retf 4

; ---- routine 1994:081B  (found by: far)
sub_081B:
081B  C8 02 00 00     enter 2, 0
081F  8A 46 06        mov al, byte ptr [bp + 6]
0822  98              cwde
0823  99              cdq
0824  31 D0           xor ax, dx
0826  29 D0           sub ax, dx
0828  3D 09 00        cmp ax, 9
082B  7F 0E           jg 0x83b
082D  8A 46 07        mov al, byte ptr [bp + 7]
0830  98              cwde
0831  99              cdq
0832  31 D0           xor ax, dx
0834  29 D0           sub ax, dx
0836  3D 27 00        cmp ax, 0x27
0839  7E 04           jle 0x83f
loc_083B:
083B  B0 00           mov al, 0
083D  EB 02           jmp 0x841
loc_083F:
083F  B0 01           mov al, 1
loc_0841:
0841  88 46 FF        mov byte ptr [bp - 1], al
0844  8A 46 FF        mov al, byte ptr [bp - 1]
0847  C9              leave
0848  CA 02 00        retf 2

; ---- routine 1994:084B  (found by: far)
sub_084B:
084B  C8 02 00 00     enter 2, 0
084F  8A 46 06        mov al, byte ptr [bp + 6]
0852  98              cwde
0853  99              cdq
0854  31 D0           xor ax, dx
0856  29 D0           sub ax, dx
0858  3D 08 00        cmp ax, 8
085B  7F 0E           jg 0x86b
085D  8A 46 07        mov al, byte ptr [bp + 7]
0860  98              cwde
0861  99              cdq
0862  31 D0           xor ax, dx
0864  29 D0           sub ax, dx
0866  3D 25 00        cmp ax, 0x25
0869  7E 04           jle 0x86f
loc_086B:
086B  B0 00           mov al, 0
086D  EB 02           jmp 0x871
loc_086F:
086F  B0 01           mov al, 1
loc_0871:
0871  88 46 FF        mov byte ptr [bp - 1], al
0874  8A 46 FF        mov al, byte ptr [bp - 1]
0877  C9              leave
0878  CA 02 00        retf 2

; ---- routine 1994:087B  (found by: call, far)
sub_087B:
087B  C8 04 00 00     enter 4, 0
087F  C4 7E 06        les di, ptr [bp + 6]
0882  26 8A 45 03     mov al, byte ptr es:[di + 3]
0886  98              cwde
0887  D1 E0           shl ax, 1
0889  8B D0           mov dx, ax
088B  26 8A 45 02     mov al, byte ptr es:[di + 2]
088F  98              cwde
0890  69 C0 A0 00     imul ax, ax, 0xa0
0894  C4 3E 8A D0     les di, ptr [0xd08a]
0898  03 F8           add di, ax
089A  03 FA           add di, dx
089C  26 8D 85 0E 09  lea ax, es:[di + 0x90e]
08A1  8C C2           mov dx, es
08A3  89 46 FC        mov word ptr [bp - 4], ax
08A6  89 56 FE        mov word ptr [bp - 2], dx
08A9  C4 7E 06        les di, ptr [bp + 6]
08AC  26 8B 45 02     mov ax, word ptr es:[di + 2]
08B0  26 3B 05        cmp ax, word ptr es:[di]
08B3  74 5A           je 0x90f
08B5  C4 7E FC        les di, ptr [bp - 4]
08B8  26 80 7D 01 05  cmp byte ptr es:[di + 1], 5
08BD  74 28           je 0x8e7
08BF  C4 7E FC        les di, ptr [bp - 4]
08C2  26 81 3D FE 0C  cmp word ptr es:[di], 0xcfe
08C7  74 1E           je 0x8e7
08C9  C4 7E FC        les di, ptr [bp - 4]
08CC  26 81 3D FE 0E  cmp word ptr es:[di], 0xefe
08D1  74 14           je 0x8e7
08D3  C4 7E FC        les di, ptr [bp - 4]
08D6  26 81 3D AF 0E  cmp word ptr es:[di], 0xeaf
08DB  74 0A           je 0x8e7
08DD  C4 7E FC        les di, ptr [bp - 4]
08E0  26 81 3D AE 0E  cmp word ptr es:[di], 0xeae
08E5  75 28           jne 0x90f
loc_08E7:
08E7  C4 7E 06        les di, ptr [bp + 6]
08EA  26 8A 45 03     mov al, byte ptr es:[di + 3]
08EE  98              cwde
08EF  D1 E0           shl ax, 1
08F1  8B D0           mov dx, ax
08F3  26 8A 45 02     mov al, byte ptr es:[di + 2]
08F7  98              cwde
08F8  69 C0 A0 00     imul ax, ax, 0xa0
08FC  C4 3E 92 D0     les di, ptr [0xd092]
0900  03 F8           add di, ax
0902  03 FA           add di, dx
0904  26 8B 85 0E 09  mov ax, word ptr es:[di + 0x90e]
0909  C4 7E FC        les di, ptr [bp - 4]
090C  26 89 05        mov word ptr es:[di], ax
loc_090F:
090F  C4 7E 06        les di, ptr [bp + 6]
0912  26 8B 05        mov ax, word ptr es:[di]
0915  26 89 45 02     mov word ptr es:[di + 2], ax
0919  26 8B 4D 04     mov cx, word ptr es:[di + 4]
091D  26 8A 45 01     mov al, byte ptr es:[di + 1]
0921  98              cwde
0922  D1 E0           shl ax, 1
0924  8B D0           mov dx, ax
0926  26 8A 05        mov al, byte ptr es:[di]
0929  98              cwde
092A  69 C0 A0 00     imul ax, ax, 0xa0
092E  C4 3E 8A D0     les di, ptr [0xd08a]
0932  03 F8           add di, ax
0934  03 FA           add di, dx
0936  26 89 8D 0E 09  mov word ptr es:[di + 0x90e], cx
093B  C9              leave
093C  CA 04 00        retf 4

; ---- routine 1994:093F  (found by: far)
sub_093F:
093F  55              push bp
0940  89 E5           mov bp, sp
0942  A1 32 0D        mov ax, word ptr [0xd32]
0945  C4 7E 06        les di, ptr [bp + 6]
0948  26 89 05        mov word ptr es:[di], ax
094B  80 3E 74 D0 00  cmp byte ptr [0xd074], 0
0950  74 02           je 0x954
0952  EB 2F           jmp 0x983
loc_0954:
0954  C4 7E 06        les di, ptr [bp + 6]
0957  06              push es
0958  57              push di
0959  0E              push cs
095A  E8 1E FF        call 0x87b
095D  A0 32 0D        mov al, byte ptr [0xd32]
0960  98              cwde
0961  69 C0 A0 00     imul ax, ax, 0xa0
0965  C4 3E 92 D0     les di, ptr [0xd092]
0969  03 F8           add di, ax
096B  26 8B 95 0E 09  mov dx, word ptr es:[di + 0x90e]
0970  A0 32 0D        mov al, byte ptr [0xd32]
0973  98              cwde
0974  69 C0 A0 00     imul ax, ax, 0xa0
0978  C4 3E 8A D0     les di, ptr [0xd08a]
097C  03 F8           add di, ax
097E  26 89 95 0E 09  mov word ptr es:[di + 0x90e], dx
loc_0983:
0983  C9              leave
0984  CA 04 00        retf 4

; ---- routine 1994:0987  (found by: far)
sub_0987:
0987  55              push bp
0988  89 E5           mov bp, sp
098A  A1 32 0D        mov ax, word ptr [0xd32]
098D  C4 7E 06        les di, ptr [bp + 6]
0990  26 89 05        mov word ptr es:[di], ax
0993  26 8B 05        mov ax, word ptr es:[di]
0996  26 89 45 02     mov word ptr es:[di + 2], ax
099A  26 C6 45 06 00  mov byte ptr es:[di + 6], 0
099F  C9              leave
09A0  CA 04 00        retf 4

