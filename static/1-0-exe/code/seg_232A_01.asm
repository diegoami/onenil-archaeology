; 1-0.EXE (One-Nil 96), code segment 232A (image offsets 232A0..2459F), part 1 of 2
; packed 1-0.EXE sha256 89ff9c5f238f24e81a0c2440a46cdd8997280a65fc3cc3d97cb974f55280a80a (LZEXE 0.91)
; unpacked (tools/static/unlzexe.py) sha256 887ed2a92767950e5309b2052409f875668605939b69e00737aa3047022b9f51
; tool: capstone 5.0.9 (pip package; core library 5.0.1280) (CS_ARCH_X86, CS_MODE_16), recursive descent from the entry point, far calls and near calls/jumps, then routine prologues (55 89 E5 / 55 8B EC / C8 iw 00) in what remains; tools/static/listing.py
; addresses are SEGMENT:OFFSET with SEGMENT the image paragraph before relocation; image offset = SEGMENT*16+OFFSET
; data (not reached as code), 8 bytes
0000                  pstr '1-0.tfn'

; ---- routine 232A:0008  (found by: call)
sub_0008:
0008  C8 14 10 00     enter 0x1014, 0
000C  BF 00 00        mov di, 0
000F  0E              push cs
0010  57              push di
0011  8D BE EC EF     lea di, [bp - 0x1014]
0015  16              push ss
0016  57              push di
0017  68 00 10        push 0x1000
001A  0E              push cs
001B  E8 66 12        call 0x1284
001E  08 C0           or al, al
0020  74 32           je 0x54
0022  C6 46 ED 11     mov byte ptr [bp - 0x13], 0x11
0026  C6 46 EC 00     mov byte ptr [bp - 0x14], 0
002A  8C D0           mov ax, ss
002C  89 46 FC        mov word ptr [bp - 4], ax
002F  8D 86 EC EF     lea ax, [bp - 0x1014]
0033  89 46 F4        mov word ptr [bp - 0xc], ax
0036  C7 46 F0 00 01  mov word ptr [bp - 0x10], 0x100
003B  31 C0           xor ax, ax
003D  89 46 F2        mov word ptr [bp - 0xe], ax
0040  C6 46 EE 00     mov byte ptr [bp - 0x12], 0
0044  C6 46 EF 10     mov byte ptr [bp - 0x11], 0x10
0048  6A 10           push 0x10
004A  8D 7E EC        lea di, [bp - 0x14]
004D  16              push ss
004E  57              push di
004F  9A B2 00 B8 26  call far 26B8:00B2
loc_0054:
0054  C9              leave
0055  C3              ret
; data (not reached as code), 8 bytes
0056                  pstr '1-0.pal'

; ---- routine 232A:005E  (found by: call)
sub_005E:
005E  C8 00 03 00     enter 0x300, 0
0062  BF 56 00        mov di, 0x56
0065  0E              push cs
0066  57              push di
0067  8D BE 00 FD     lea di, [bp - 0x300]
006B  16              push ss
006C  57              push di
006D  68 00 03        push 0x300
0070  0E              push cs
0071  E8 10 12        call 0x1284
0074  08 C0           or al, al
0076  74 0B           je 0x83
0078  8D BE 03 FD     lea di, [bp - 0x2fd]
007C  16              push ss
007D  57              push di
007E  9A D5 1A BC 24  call far 24BC:1AD5
loc_0083:
0083  C9              leave
0084  C3              ret

; ---- routine 232A:0085  (found by: far)
sub_0085:
0085  55              push bp
0086  89 E5           mov bp, sp
0088  BF EE A2        mov di, 0xa2ee
008B  1E              push ds
008C  57              push di
008D  BF 58 DD        mov di, 0xdd58
0090  1E              push ds
0091  57              push di
0092  0E              push cs
0093  E8 99 04        call 0x52f
0096  C9              leave
0097  CB              retf

; ---- routine 232A:0098  (found by: far)
sub_0098:
0098  C8 52 00 00     enter 0x52, 0
009C  8C D3           mov bx, ss
009E  8E C3           mov es, bx
00A0  8C DB           mov bx, ds
00A2  FC              cld
00A3  8D 7E AE        lea di, [bp - 0x52]
00A6  C5 76 06        lds si, ptr [bp + 6]
00A9  AC              lodsb al, byte ptr [si]
00AA  3C 50           cmp al, 0x50
00AC  72 02           jb 0xb0
00AE  B0 50           mov al, 0x50
loc_00B0:
00B0  AA              stosb byte ptr es:[di], al
00B1  91              xchg cx, ax
00B2  30 ED           xor ch, ch
00B4  F3 A4           rep movsb byte ptr es:[di], byte ptr [si]
00B6  8E DB           mov ds, bx
00B8  8A 46 0A        mov al, byte ptr [bp + 0xa]
00BB  88 46 FF        mov byte ptr [bp - 1], al
00BE  80 7E 0A 00     cmp byte ptr [bp + 0xa], 0
00C2  74 0A           je 0xce
00C4  8D 7E AE        lea di, [bp - 0x52]
00C7  16              push ss
00C8  57              push di
00C9  9A 02 07 BC 24  call far 24BC:0702
loc_00CE:
00CE  8A 46 FF        mov al, byte ptr [bp - 1]
00D1  C9              leave
00D2  CA 06 00        retf 6

; ---- routine 232A:00D5  (found by: call, far)
sub_00D5:
00D5  55              push bp
00D6  89 E5           mov bp, sp
00D8  8B 46 0A        mov ax, word ptr [bp + 0xa]
00DB  48              dec ax
00DC  8B D0           mov dx, ax
00DE  B8 01 00        mov ax, 1
00E1  8B CA           mov cx, dx
00E3  D3 E0           shl ax, cl
00E5  8B D0           mov dx, ax
00E7  C4 7E 06        les di, ptr [bp + 6]
00EA  26 8A 05        mov al, byte ptr es:[di]
00ED  30 E4           xor ah, ah
00EF  0B C2           or ax, dx
00F1  26 88 05        mov byte ptr es:[di], al
00F4  C9              leave
00F5  CA 06 00        retf 6

; ---- routine 232A:00F8  (found by: call, far)
sub_00F8:
00F8  55              push bp
00F9  89 E5           mov bp, sp
00FB  8B 46 0A        mov ax, word ptr [bp + 0xa]
00FE  48              dec ax
00FF  8B D0           mov dx, ax
0101  B8 01 00        mov ax, 1
0104  8B CA           mov cx, dx
0106  D3 E0           shl ax, cl
0108  F7 D0           not ax
010A  8B D0           mov dx, ax
010C  C4 7E 06        les di, ptr [bp + 6]
010F  26 8A 05        mov al, byte ptr es:[di]
0112  30 E4           xor ah, ah
0114  23 C2           and ax, dx
0116  26 88 05        mov byte ptr es:[di], al
0119  C9              leave
011A  CA 06 00        retf 6

; ---- routine 232A:011D  (found by: far)
sub_011D:
011D  55              push bp
011E  89 E5           mov bp, sp
0120  80 7E 06 00     cmp byte ptr [bp + 6], 0
0124  74 0E           je 0x134
0126  FF 76 0C        push word ptr [bp + 0xc]
0129  C4 7E 08        les di, ptr [bp + 8]
012C  06              push es
012D  57              push di
012E  0E              push cs
012F  E8 A3 FF        call 0xd5
0132  EB 0C           jmp 0x140
loc_0134:
0134  FF 76 0C        push word ptr [bp + 0xc]
0137  C4 7E 08        les di, ptr [bp + 8]
013A  06              push es
013B  57              push di
013C  0E              push cs
013D  E8 B8 FF        call 0xf8
loc_0140:
0140  C9              leave
0141  CA 08 00        retf 8

; ---- routine 232A:0144  (found by: far)
sub_0144:
0144  55              push bp
0145  89 E5           mov bp, sp
0147  8B 46 0A        mov ax, word ptr [bp + 0xa]
014A  48              dec ax
014B  8B D0           mov dx, ax
014D  B8 01 00        mov ax, 1
0150  8B CA           mov cx, dx
0152  D3 E0           shl ax, cl
0154  8B D0           mov dx, ax
0156  C4 7E 06        les di, ptr [bp + 6]
0159  26 8A 05        mov al, byte ptr es:[di]
015C  30 E4           xor ah, ah
015E  33 C2           xor ax, dx
0160  26 88 05        mov byte ptr es:[di], al
0163  C9              leave
0164  CA 06 00        retf 6

; ---- routine 232A:0167  (found by: far)
sub_0167:
0167  55              push bp
0168  89 E5           mov bp, sp
016A  8B 46 0E        mov ax, word ptr [bp + 0xe]
016D  3B 46 0C        cmp ax, word ptr [bp + 0xc]
0170  76 23           jbe 0x195
0172  8B 46 06        mov ax, word ptr [bp + 6]
0175  D1 E0           shl ax, 1
0177  8B D0           mov dx, ax
0179  69 46 08 A0 00  imul ax, word ptr [bp + 8], 0xa0
017E  C4 3E 5C DD     les di, ptr [0xdd5c]
0182  03 F8           add di, ax
0184  03 FA           add di, dx
0186  81 C7 5E FF     add di, 0xff5e
018A  06              push es
018B  57              push di
018C  6A 0E           push 0xe
018E  6A 01           push 1
0190  9A 4B 03 BC 24  call far 24BC:034B
loc_0195:
0195  8B 46 0E        mov ax, word ptr [bp + 0xe]
0198  3B 46 0A        cmp ax, word ptr [bp + 0xa]
019B  73 24           jae 0x1c1
019D  8B 46 06        mov ax, word ptr [bp + 6]
01A0  40              inc ax
01A1  D1 E0           shl ax, 1
01A3  8B D0           mov dx, ax
01A5  69 46 08 A0 00  imul ax, word ptr [bp + 8], 0xa0
01AA  C4 3E 5C DD     les di, ptr [0xdd5c]
01AE  03 F8           add di, ax
01B0  03 FA           add di, dx
01B2  81 C7 5E FF     add di, 0xff5e
01B6  06              push es
01B7  57              push di
01B8  6A 0E           push 0xe
01BA  6A 01           push 1
01BC  9A 4B 03 BC 24  call far 24BC:034B
loc_01C1:
01C1  C9              leave
01C2  CA 0A 00        retf 0xa

; ---- routine 232A:01C5  (found by: far)
sub_01C5:
01C5  55              push bp
01C6  89 E5           mov bp, sp
01C8  8A 46 0B        mov al, byte ptr [bp + 0xb]
01CB  30 E4           xor ah, ah
01CD  C1 E0 04        shl ax, 4
01D0  8B D0           mov dx, ax
01D2  8A 46 0A        mov al, byte ptr [bp + 0xa]
01D5  30 E4           xor ah, ah
01D7  03 C2           add ax, dx
01D9  C4 7E 06        les di, ptr [bp + 6]
01DC  26 88 05        mov byte ptr es:[di], al
01DF  C9              leave
01E0  CA 06 00        retf 6

; ---- routine 232A:01E3  (found by: far)
sub_01E3:
01E3  55              push bp
01E4  89 E5           mov bp, sp
01E6  8A 46 0A        mov al, byte ptr [bp + 0xa]
01E9  24 0F           and al, 0xf
01EB  C4 7E 06        les di, ptr [bp + 6]
01EE  26 88 05        mov byte ptr es:[di], al
01F1  8A 46 0A        mov al, byte ptr [bp + 0xa]
01F4  24 F0           and al, 0xf0
01F6  30 E4           xor ah, ah
01F8  C1 E8 04        shr ax, 4
01FB  26 88 45 01     mov byte ptr es:[di + 1], al
01FF  C9              leave
0200  CA 06 00        retf 6

; ---- routine 232A:0203  (found by: far)
sub_0203:
0203  55              push bp
0204  89 E5           mov bp, sp
0206  8B 46 08        mov ax, word ptr [bp + 8]
0209  D1 E0           shl ax, 1
020B  8B D0           mov dx, ax
020D  69 46 0A A0 00  imul ax, word ptr [bp + 0xa], 0xa0
0212  C4 3E 5C DD     les di, ptr [0xdd5c]
0216  03 F8           add di, ax
0218  03 FA           add di, dx
021A  81 C7 5E FF     add di, 0xff5e
021E  06              push es
021F  57              push di
0220  6A 70           push 0x70
0222  FF 76 06        push word ptr [bp + 6]
0225  9A 4B 03 BC 24  call far 24BC:034B
022A  C9              leave
022B  CA 06 00        retf 6

; ---- routine 232A:022E  (found by: call, far)
sub_022E:
022E  55              push bp
022F  89 E5           mov bp, sp
0231  80 3E EC A2 00  cmp byte ptr [0xa2ec], 0
0236  75 06           jne 0x23e
0238  E4 61           in al, 0x61
023A  24 FC           and al, 0xfc
023C  E6 61           out 0x61, al
loc_023E:
023E  C9              leave
023F  CB              retf

; ---- routine 232A:0240  (found by: far)
sub_0240:
0240  55              push bp
0241  89 E5           mov bp, sp
0243  80 3E EC A2 00  cmp byte ptr [0xa2ec], 0
0248  75 0A           jne 0x254
024A  B0 B6           mov al, 0xb6
024C  E6 43           out 0x43, al
024E  E4 61           in al, 0x61
0250  0C 03           or al, 3
0252  E6 61           out 0x61, al
loc_0254:
0254  C9              leave
0255  CB              retf

; ---- routine 232A:0256  (found by: far)
sub_0256:
0256  55              push bp
0257  89 E5           mov bp, sp
0259  0E              push cs
025A  E8 D1 FF        call 0x22e
025D  80 3E EC A2 00  cmp byte ptr [0xa2ec], 0
0262  B0 00           mov al, 0
0264  75 01           jne 0x267
0266  40              inc ax
loc_0267:
0267  A2 EC A2        mov byte ptr [0xa2ec], al
026A  C9              leave
026B  CB              retf

; ---- routine 232A:026C  (found by: call, far)
sub_026C:
026C  55              push bp
026D  89 E5           mov bp, sp
026F  C4 7E 0A        les di, ptr [bp + 0xa]
0272  06              push es
0273  57              push di
0274  FF 76 08        push word ptr [bp + 8]
0277  FF 76 06        push word ptr [bp + 6]
027A  9A 43 02 BC 24  call far 24BC:0243
027F  C9              leave
0280  CA 08 00        retf 8

; ---- routine 232A:0283  (found by: far)
sub_0283:
0283  C8 00 01 00     enter 0x100, 0
0287  8C D3           mov bx, ss
0289  8E C3           mov es, bx
028B  8C DB           mov bx, ds
028D  FC              cld
028E  8D BE 00 FF     lea di, [bp - 0x100]
0292  C5 76 0E        lds si, ptr [bp + 0xe]
0295  AC              lodsb al, byte ptr [si]
0296  AA              stosb byte ptr es:[di], al
0297  91              xchg cx, ax
0298  30 ED           xor ch, ch
029A  F3 A4           rep movsb byte ptr es:[di], byte ptr [si]
029C  8E DB           mov ds, bx
029E  8A 86 00 FF     mov al, byte ptr [bp - 0x100]
02A2  30 E4           xor ah, ah
02A4  8B D0           mov dx, ax
02A6  8A 46 0A        mov al, byte ptr [bp + 0xa]
02A9  30 E4           xor ah, ah
02AB  2B C2           sub ax, dx
02AD  40              inc ax
02AE  D1 E0           shl ax, 1
02B0  8B D0           mov dx, ax
02B2  8A 46 0C        mov al, byte ptr [bp + 0xc]
02B5  30 E4           xor ah, ah
02B7  69 C0 A0 00     imul ax, ax, 0xa0
02BB  C4 7E 06        les di, ptr [bp + 6]
02BE  26 C4 3D        les di, ptr es:[di]
02C1  03 F8           add di, ax
02C3  03 FA           add di, dx
02C5  81 C7 5E FF     add di, 0xff5e
02C9  06              push es
02CA  57              push di
02CB  A0 64 DD        mov al, byte ptr [0xdd64]
02CE  50              push ax
02CF  8A 86 00 FF     mov al, byte ptr [bp - 0x100]
02D3  30 E4           xor ah, ah
02D5  50              push ax
02D6  9A 4B 03 BC 24  call far 24BC:034B
02DB  8D BE 00 FF     lea di, [bp - 0x100]
02DF  16              push ss
02E0  57              push di
02E1  8A 46 0A        mov al, byte ptr [bp + 0xa]
02E4  30 E4           xor ah, ah
02E6  D1 E0           shl ax, 1
02E8  8B D0           mov dx, ax
02EA  8A 46 0C        mov al, byte ptr [bp + 0xc]
02ED  30 E4           xor ah, ah
02EF  69 C0 A0 00     imul ax, ax, 0xa0
02F3  C4 7E 06        les di, ptr [bp + 6]
02F6  26 C4 3D        les di, ptr es:[di]
02F9  03 F8           add di, ax
02FB  03 FA           add di, dx
02FD  81 C7 5E FF     add di, 0xff5e
0301  06              push es
0302  57              push di
0303  9A 94 02 BC 24  call far 24BC:0294
0308  C9              leave
0309  CA 0C 00        retf 0xc

; ---- routine 232A:030C  (found by: far)
sub_030C:
030C  C8 00 01 00     enter 0x100, 0
0310  8C D3           mov bx, ss
0312  8E C3           mov es, bx
0314  8C DB           mov bx, ds
0316  FC              cld
0317  8D BE 00 FF     lea di, [bp - 0x100]
031B  C5 76 0E        lds si, ptr [bp + 0xe]
031E  AC              lodsb al, byte ptr [si]
031F  AA              stosb byte ptr es:[di], al
0320  91              xchg cx, ax
0321  30 ED           xor ch, ch
0323  F3 A4           rep movsb byte ptr es:[di], byte ptr [si]
0325  8E DB           mov ds, bx
0327  8A 46 12        mov al, byte ptr [bp + 0x12]
032A  30 E4           xor ah, ah
032C  A3 64 DD        mov word ptr [0xdd64], ax
032F  8A 86 00 FF     mov al, byte ptr [bp - 0x100]
0333  30 E4           xor ah, ah
0335  8B D0           mov dx, ax
0337  8A 46 0A        mov al, byte ptr [bp + 0xa]
033A  30 E4           xor ah, ah
033C  2B C2           sub ax, dx
033E  40              inc ax
033F  D1 E0           shl ax, 1
0341  8B D0           mov dx, ax
0343  8A 46 0C        mov al, byte ptr [bp + 0xc]
0346  30 E4           xor ah, ah
0348  69 C0 A0 00     imul ax, ax, 0xa0
034C  C4 7E 06        les di, ptr [bp + 6]
034F  26 C4 3D        les di, ptr es:[di]
0352  03 F8           add di, ax
0354  03 FA           add di, dx
0356  81 C7 5E FF     add di, 0xff5e
035A  06              push es
035B  57              push di
035C  A0 64 DD        mov al, byte ptr [0xdd64]
035F  50              push ax
0360  8A 86 00 FF     mov al, byte ptr [bp - 0x100]
0364  30 E4           xor ah, ah
0366  50              push ax
0367  9A 4B 03 BC 24  call far 24BC:034B
036C  8D BE 00 FF     lea di, [bp - 0x100]
0370  16              push ss
0371  57              push di
0372  8A 46 0A        mov al, byte ptr [bp + 0xa]
0375  30 E4           xor ah, ah
0377  D1 E0           shl ax, 1
0379  8B D0           mov dx, ax
037B  8A 46 0C        mov al, byte ptr [bp + 0xc]
037E  30 E4           xor ah, ah
0380  69 C0 A0 00     imul ax, ax, 0xa0
0384  C4 7E 06        les di, ptr [bp + 6]
0387  26 C4 3D        les di, ptr es:[di]
038A  03 F8           add di, ax
038C  03 FA           add di, dx
038E  81 C7 5E FF     add di, 0xff5e
0392  06              push es
0393  57              push di
0394  9A 94 02 BC 24  call far 24BC:0294
0399  C9              leave
039A  CA 0E 00        retf 0xe

; ---- routine 232A:039D  (found by: call, far)
sub_039D:
039D  C8 00 01 00     enter 0x100, 0
03A1  8C D3           mov bx, ss
03A3  8E C3           mov es, bx
03A5  8C DB           mov bx, ds
03A7  FC              cld
03A8  8D BE 00 FF     lea di, [bp - 0x100]
03AC  C5 76 0E        lds si, ptr [bp + 0xe]
03AF  AC              lodsb al, byte ptr [si]
03B0  AA              stosb byte ptr es:[di], al
03B1  91              xchg cx, ax
03B2  30 ED           xor ch, ch
03B4  F3 A4           rep movsb byte ptr es:[di], byte ptr [si]
03B6  8E DB           mov ds, bx
03B8  8A 46 0A        mov al, byte ptr [bp + 0xa]
03BB  30 E4           xor ah, ah
03BD  D1 E0           shl ax, 1
03BF  8B D0           mov dx, ax
03C1  8A 46 0C        mov al, byte ptr [bp + 0xc]
03C4  30 E4           xor ah, ah
03C6  69 C0 A0 00     imul ax, ax, 0xa0
03CA  C4 7E 06        les di, ptr [bp + 6]
03CD  26 C4 3D        les di, ptr es:[di]
03D0  03 F8           add di, ax
03D2  03 FA           add di, dx
03D4  81 C7 5E FF     add di, 0xff5e
03D8  06              push es
03D9  57              push di
03DA  A0 64 DD        mov al, byte ptr [0xdd64]
03DD  50              push ax
03DE  8A 86 00 FF     mov al, byte ptr [bp - 0x100]
03E2  30 E4           xor ah, ah
03E4  50              push ax
03E5  9A 4B 03 BC 24  call far 24BC:034B
03EA  8D BE 00 FF     lea di, [bp - 0x100]
03EE  16              push ss
03EF  57              push di
03F0  8A 46 0A        mov al, byte ptr [bp + 0xa]
03F3  30 E4           xor ah, ah
03F5  D1 E0           shl ax, 1
03F7  8B D0           mov dx, ax
03F9  8A 46 0C        mov al, byte ptr [bp + 0xc]
03FC  30 E4           xor ah, ah
03FE  69 C0 A0 00     imul ax, ax, 0xa0
0402  C4 7E 06        les di, ptr [bp + 6]
0405  26 C4 3D        les di, ptr es:[di]
0408  03 F8           add di, ax
040A  03 FA           add di, dx
040C  81 C7 5E FF     add di, 0xff5e
0410  06              push es
0411  57              push di
0412  9A 77 02 BC 24  call far 24BC:0277
0417  C9              leave
0418  CA 0C 00        retf 0xc

; ---- routine 232A:041B  (found by: call, far)
sub_041B:
041B  C8 00 01 00     enter 0x100, 0
041F  8C D3           mov bx, ss
0421  8E C3           mov es, bx
0423  8C DB           mov bx, ds
0425  FC              cld
0426  8D BE 00 FF     lea di, [bp - 0x100]
042A  C5 76 0E        lds si, ptr [bp + 0xe]
042D  AC              lodsb al, byte ptr [si]
042E  AA              stosb byte ptr es:[di], al
042F  91              xchg cx, ax
0430  30 ED           xor ch, ch
0432  F3 A4           rep movsb byte ptr es:[di], byte ptr [si]
0434  8E DB           mov ds, bx
0436  8A 46 12        mov al, byte ptr [bp + 0x12]
0439  30 E4           xor ah, ah
043B  A3 64 DD        mov word ptr [0xdd64], ax
043E  8A 46 0A        mov al, byte ptr [bp + 0xa]
0441  30 E4           xor ah, ah
0443  D1 E0           shl ax, 1
0445  8B D0           mov dx, ax
0447  8A 46 0C        mov al, byte ptr [bp + 0xc]
044A  30 E4           xor ah, ah
044C  69 C0 A0 00     imul ax, ax, 0xa0
0450  C4 7E 06        les di, ptr [bp + 6]
0453  26 C4 3D        les di, ptr es:[di]
0456  03 F8           add di, ax
0458  03 FA           add di, dx
045A  81 C7 5E FF     add di, 0xff5e
045E  06              push es
045F  57              push di
0460  A0 64 DD        mov al, byte ptr [0xdd64]
0463  50              push ax
0464  8A 86 00 FF     mov al, byte ptr [bp - 0x100]
0468  30 E4           xor ah, ah
046A  50              push ax
046B  9A 4B 03 BC 24  call far 24BC:034B
0470  8D BE 00 FF     lea di, [bp - 0x100]
0474  16              push ss
0475  57              push di
0476  8A 46 0A        mov al, byte ptr [bp + 0xa]
0479  30 E4           xor ah, ah
047B  D1 E0           shl ax, 1
047D  8B D0           mov dx, ax
047F  8A 46 0C        mov al, byte ptr [bp + 0xc]
0482  30 E4           xor ah, ah
0484  69 C0 A0 00     imul ax, ax, 0xa0
0488  C4 7E 06        les di, ptr [bp + 6]
048B  26 C4 3D        les di, ptr es:[di]
048E  03 F8           add di, ax
0490  03 FA           add di, dx
0492  81 C7 5E FF     add di, 0xff5e
0496  06              push es
0497  57              push di
0498  9A 77 02 BC 24  call far 24BC:0277
049D  C9              leave
049E  CA 0E 00        retf 0xe

; ---- routine 232A:04A1  (found by: call)
sub_04A1:
04A1  C8 02 00 00     enter 2, 0
04A5  8A 46 0A        mov al, byte ptr [bp + 0xa]
04A8  88 46 FE        mov byte ptr [bp - 2], al
04AB  8A 46 0C        mov al, byte ptr [bp + 0xc]
04AE  3A 46 FE        cmp al, byte ptr [bp - 2]
04B1  77 50           ja 0x503
04B3  88 46 FF        mov byte ptr [bp - 1], al
04B6  EB 03           jmp 0x4bb
loc_04B8:
04B8  FE 46 FF        inc byte ptr [bp - 1]
loc_04BB:
04BB  8A 46 10        mov al, byte ptr [bp + 0x10]
04BE  30 E4           xor ah, ah
04C0  D1 E0           shl ax, 1
04C2  8B D0           mov dx, ax
04C4  8A 46 FF        mov al, byte ptr [bp - 1]
04C7  30 E4           xor ah, ah
04C9  69 C0 A0 00     imul ax, ax, 0xa0
04CD  C4 7E 06        les di, ptr [bp + 6]
04D0  26 C4 3D        les di, ptr es:[di]
04D3  03 F8           add di, ax
04D5  03 FA           add di, dx
04D7  81 C7 5E FF     add di, 0xff5e
04DB  06              push es
04DC  57              push di
04DD  8A 46 10        mov al, byte ptr [bp + 0x10]
04E0  30 E4           xor ah, ah
04E2  8B D0           mov dx, ax
04E4  8A 46 0E        mov al, byte ptr [bp + 0xe]
04E7  30 E4           xor ah, ah
04E9  2B C2           sub ax, dx
04EB  40              inc ax
04EC  50              push ax
04ED  A1 64 DD        mov ax, word ptr [0xdd64]
04F0  C1 E0 08        shl ax, 8
04F3  05 20 00        add ax, 0x20
04F6  50              push ax
04F7  0E              push cs
04F8  E8 71 FD        call 0x26c
04FB  8A 46 FF        mov al, byte ptr [bp - 1]
04FE  3A 46 FE        cmp al, byte ptr [bp - 2]
0501  75 B5           jne 0x4b8
loc_0503:
0503  C9              leave
0504  CA 0C 00        retf 0xc

; ---- routine 232A:0507  (found by: far)
sub_0507:
0507  55              push bp
0508  89 E5           mov bp, sp
050A  8A 46 12        mov al, byte ptr [bp + 0x12]
050D  30 E4           xor ah, ah
050F  A3 64 DD        mov word ptr [0xdd64], ax
0512  8A 46 10        mov al, byte ptr [bp + 0x10]
0515  50              push ax
0516  8A 46 0E        mov al, byte ptr [bp + 0xe]
0519  50              push ax
051A  8A 46 0C        mov al, byte ptr [bp + 0xc]
051D  50              push ax
051E  8A 46 0A        mov al, byte ptr [bp + 0xa]
0521  50              push ax
0522  C4 7E 06        les di, ptr [bp + 6]
0525  06              push es
0526  57              push di
0527  0E              push cs
0528  E8 76 FF        call 0x4a1
052B  C9              leave
052C  CA 0E 00        retf 0xe

; ---- routine 232A:052F  (found by: call, far)
sub_052F:
052F  55              push bp
0530  89 E5           mov bp, sp
0532  C4 7E 06        les di, ptr [bp + 6]
0535  26 C4 3D        les di, ptr es:[di]
0538  06              push es
0539  57              push di
053A  C4 7E 0A        les di, ptr [bp + 0xa]
053D  06              push es
053E  57              push di
053F  9A 00 00 BC 24  call far 24BC:0000
0544  C9              leave
0545  CA 08 00        retf 8
; data (not reached as code), 13 bytes
0548                  db 01 20 02 2E 2E   ; . ...
054D                  pstr '? (Y/N)'

; ---- routine 232A:0555  (found by: call, far)
sub_0555:
0555  C8 5A 01 00     enter 0x15a, 0
0559  8C D3           mov bx, ss
055B  8E C3           mov es, bx
055D  8C DB           mov bx, ds
055F  FC              cld
0560  8D 7E AE        lea di, [bp - 0x52]
0563  C5 76 0A        lds si, ptr [bp + 0xa]
0566  AC              lodsb al, byte ptr [si]
0567  3C 50           cmp al, 0x50
0569  72 02           jb 0x56d
056B  B0 50           mov al, 0x50
loc_056D:
056D  AA              stosb byte ptr es:[di], al
056E  91              xchg cx, ax
056F  30 ED           xor ch, ch
0571  F3 A4           rep movsb byte ptr es:[di], byte ptr [si]
0573  8E DB           mov ds, bx
0575  80 7E AF 20     cmp byte ptr [bp - 0x51], 0x20
0579  74 26           je 0x5a1
057B  8D BE A6 FE     lea di, [bp - 0x15a]
057F  16              push ss
0580  57              push di
0581  BF 48 05        mov di, 0x548
0584  0E              push cs
0585  57              push di
0586  9A 53 0B C9 26  call far 26C9:0B53
058B  8D 7E AE        lea di, [bp - 0x52]
058E  16              push ss
058F  57              push di
0590  9A D2 0B C9 26  call far 26C9:0BD2
0595  8D 7E AE        lea di, [bp - 0x52]
0598  16              push ss
0599  57              push di
059A  6A 50           push 0x50
059C  9A 6D 0B C9 26  call far 26C9:0B6D
loc_05A1:
05A1  8D BE A6 FE     lea di, [bp - 0x15a]
05A5  16              push ss
05A6  57              push di
05A7  8D 7E AE        lea di, [bp - 0x52]
05AA  16              push ss
05AB  57              push di
05AC  9A 53 0B C9 26  call far 26C9:0B53
05B1  BF 48 05        mov di, 0x548
05B4  0E              push cs
05B5  57              push di
05B6  9A D2 0B C9 26  call far 26C9:0BD2
05BB  8D 7E AE        lea di, [bp - 0x52]
05BE  16              push ss
05BF  57              push di
05C0  6A 50           push 0x50
05C2  9A 6D 0B C9 26  call far 26C9:0B6D
05C7  8A 46 AE        mov al, byte ptr [bp - 0x52]
05CA  30 E4           xor ah, ah
05CC  89 46 AC        mov word ptr [bp - 0x54], ax
05CF  8B 46 AC        mov ax, word ptr [bp - 0x54]
05D2  40              inc ax
05D3  8B F8           mov di, ax
05D5  8D 7B AE        lea di, [bp + di - 0x52]
05D8  16              push ss
05D9  57              push di
05DA  B8 50 00        mov ax, 0x50
05DD  2B 46 AC        sub ax, word ptr [bp - 0x54]
05E0  50              push ax
05E1  68 FE 00        push 0xfe
05E4  9A 22 02 BC 24  call far 24BC:0222
05E9  B8 50 00        mov ax, 0x50
05EC  2B 46 AC        sub ax, word ptr [bp - 0x54]
05EF  D1 E8           shr ax, 1
05F1  40              inc ax
05F2  89 46 AA        mov word ptr [bp - 0x56], ax
05F5  8D 7E AF        lea di, [bp - 0x51]
05F8  16              push ss
05F9  57              push di
05FA  8B 7E AA        mov di, word ptr [bp - 0x56]
05FD  8D 7B AE        lea di, [bp + di - 0x52]
0600  16              push ss
0601  57              push di
0602  FF 76 AC        push word ptr [bp - 0x54]
0605  9A C2 01 BC 24  call far 24BC:01C2
060A  8D 7E AF        lea di, [bp - 0x51]
060D  16              push ss
060E  57              push di
060F  8B 46 AA        mov ax, word ptr [bp - 0x56]
0612  48              dec ax
0613  50              push ax
0614  68 FE 00        push 0xfe
0617  9A 22 02 BC 24  call far 24BC:0222
061C  C6 46 AE 50     mov byte ptr [bp - 0x52], 0x50
0620  BF 4A 05        mov di, 0x54a
0623  0E              push cs
0624  57              push di
0625  8D 7E AE        lea di, [bp - 0x52]
0628  16              push ss
0629  57              push di
062A  9A FE 0B C9 26  call far 26C9:0BFE
062F  09 C0           or ax, ax
0631  75 1A           jne 0x64d
0633  A0 A6 A2        mov al, byte ptr [0xa2a6]
0636  50              push ax
0637  8D 7E AE        lea di, [bp - 0x52]
063A  16              push ss
063B  57              push di
063C  8A 46 0E        mov al, byte ptr [bp + 0xe]
063F  50              push ax
0640  6A 01           push 1
0642  C4 7E 06        les di, ptr [bp + 6]
0645  06              push es
0646  57              push di
0647  0E              push cs
0648  E8 D0 FD        call 0x41b
064B  EB 16           jmp 0x663
loc_064D:
064D  6A 82           push -0x7e
064F  8D 7E AE        lea di, [bp - 0x52]
0652  16              push ss
0653  57              push di
0654  8A 46 0E        mov al, byte ptr [bp + 0xe]
0657  50              push ax
0658  6A 01           push 1
065A  C4 7E 06        les di, ptr [bp + 6]
065D  06              push es
065E  57              push di
065F  0E              push cs
0660  E8 B8 FD        call 0x41b
loc_0663:
0663  BF 4D 05        mov di, 0x54d
0666  0E              push cs
0667  57              push di
0668  8D 7E AE        lea di, [bp - 0x52]
066B  16              push ss
066C  57              push di
066D  9A FE 0B C9 26  call far 26C9:0BFE
0672  89 46 A8        mov word ptr [bp - 0x58], ax
0675  83 7E A8 00     cmp word ptr [bp - 0x58], 0
0679  75 02           jne 0x67d
067B  EB 5C           jmp 0x6d9
loc_067D:
067D  8B 46 A8        mov ax, word ptr [bp - 0x58]
0680  05 03 00        add ax, 3
0683  D1 E0           shl ax, 1
0685  8B D0           mov dx, ax
0687  8A 46 0E        mov al, byte ptr [bp + 0xe]
068A  30 E4           xor ah, ah
068C  69 C0 A0 00     imul ax, ax, 0xa0
0690  C4 7E 06        les di, ptr [bp + 6]
0693  26 C4 3D        les di, ptr es:[di]
0696  03 F8           add di, ax
0698  03 FA           add di, dx
069A  81 C7 5E FF     add di, 0xff5e
069E  06              push es
069F  57              push di
06A0  A0 A7 A2        mov al, byte ptr [0xa2a7]
06A3  50              push ax
06A4  6A 01           push 1
06A6  9A 4B 03 BC 24  call far 24BC:034B
06AB  8B 46 A8        mov ax, word ptr [bp - 0x58]
06AE  05 05 00        add ax, 5
06B1  D1 E0           shl ax, 1
06B3  8B D0           mov dx, ax
06B5  8A 46 0E        mov al, byte ptr [bp + 0xe]
06B8  30 E4           xor ah, ah
06BA  69 C0 A0 00     imul ax, ax, 0xa0
06BE  C4 7E 06        les di, ptr [bp + 6]
06C1  26 C4 3D        les di, ptr es:[di]
06C4  03 F8           add di, ax
06C6  03 FA           add di, dx
06C8  81 C7 5E FF     add di, 0xff5e
06CC  06              push es
06CD  57              push di
06CE  A0 A7 A2        mov al, byte ptr [0xa2a7]
06D1  50              push ax
06D2  6A 01           push 1
06D4  9A 4B 03 BC 24  call far 24BC:034B
loc_06D9:
06D9  C9              leave
06DA  CA 0A 00        retf 0xa
; data (not reached as code), 8 bytes
06DD                  pstr '? (Y/N)'

; ---- routine 232A:06E5  (found by: call, far)
sub_06E5:
06E5  C8 52 01 00     enter 0x152, 0
06E9  8C D3           mov bx, ss
06EB  8E C3           mov es, bx
06ED  8C DB           mov bx, ds
06EF  FC              cld
06F0  8D 7E AE        lea di, [bp - 0x52]
06F3  C5 76 06        lds si, ptr [bp + 6]
06F6  AC              lodsb al, byte ptr [si]
06F7  3C 50           cmp al, 0x50
06F9  72 02           jb 0x6fd
06FB  B0 50           mov al, 0x50
loc_06FD:
06FD  AA              stosb byte ptr es:[di], al
06FE  91              xchg cx, ax
06FF  30 ED           xor ch, ch
0701  F3 A4           rep movsb byte ptr es:[di], byte ptr [si]
0703  8E DB           mov ds, bx
0705  9A 68 05 BC 24  call far 24BC:0568
070A  8D BE AE FE     lea di, [bp - 0x152]
070E  16              push ss
070F  57              push di
0710  8D 7E AE        lea di, [bp - 0x52]
0713  16              push ss
0714  57              push di
0715  9A 53 0B C9 26  call far 26C9:0B53
071A  BF DD 06        mov di, 0x6dd
071D  0E              push cs
071E  57              push di
071F  9A D2 0B C9 26  call far 26C9:0BD2
0724  8D 7E AE        lea di, [bp - 0x52]
0727  16              push ss
0728  57              push di
0729  6A 50           push 0x50
072B  9A 6D 0B C9 26  call far 26C9:0B6D
0730  6A 19           push 0x19
0732  8D 7E AE        lea di, [bp - 0x52]
0735  16              push ss
0736  57              push di
0737  BF 58 DD        mov di, 0xdd58
073A  1E              push ds
073B  57              push di
073C  0E              push cs
073D  E8 15 FE        call 0x555
0740  BF CA A2        mov di, 0xa2ca
0743  1E              push ds
0744  57              push di
0745  0E              push cs
0746  E8 4C 00        call 0x795
0749  A0 88 DE        mov al, byte ptr [0xde88]
074C  50              push ax
074D  9A 86 19 C9 26  call far 26C9:1986
0752  3C 59           cmp al, 0x59
0754  B0 00           mov al, 0
0756  75 01           jne 0x759
0758  40              inc ax
loc_0759:
0759  88 46 FF        mov byte ptr [bp - 1], al
075C  9A 98 05 BC 24  call far 24BC:0598
0761  C6 06 88 DE 00  mov byte ptr [0xde88], 0
0766  8A 46 FF        mov al, byte ptr [bp - 1]
0769  C9              leave
076A  CA 04 00        retf 4

; ---- routine 232A:076D  (found by: far)
sub_076D:
076D  C8 02 00 00     enter 2, 0
0771  FF 76 06        push word ptr [bp + 6]
0774  9A 01 0D BC 24  call far 24BC:0D01
0779  89 46 FE        mov word ptr [bp - 2], ax
077C  8B 46 FE        mov ax, word ptr [bp - 2]
077F  C9              leave
0780  CA 02 00        retf 2

; ---- routine 232A:0783  (found by: far)
sub_0783:
0783  55              push bp
0784  89 E5           mov bp, sp
0786  8A 46 06        mov al, byte ptr [bp + 6]
0789  30 E4           xor ah, ah
078B  50              push ax
078C  9A 81 0C BC 24  call far 24BC:0C81
0791  C9              leave
0792  CA 02 00        retf 2

; ---- routine 232A:0795  (found by: call, far)
sub_0795:
0795  C8 20 00 00     enter 0x20, 0
0799  8C D3           mov bx, ss
079B  8E C3           mov es, bx
079D  8C DB           mov bx, ds
079F  FC              cld
07A0  8D 7E E0        lea di, [bp - 0x20]
07A3  C5 76 06        lds si, ptr [bp + 6]
07A6  B9 20 00        mov cx, 0x20
07A9  F3 A4           rep movsb byte ptr es:[di], byte ptr [si]
07AB  8E DB           mov ds, bx
loc_07AD:
07AD  0E              push cs
07AE  E8 EA 01        call 0x99b
07B1  A0 88 DE        mov al, byte ptr [0xde88]
07B4  B4 01           mov ah, 1
07B6  BA 20 00        mov dx, 0x20
07B9  9A 1F 0E C9 26  call far 26C9:0E1F
07BE  8B FA           mov di, dx
07C0  84 43 E0        test byte ptr [bp + di - 0x20], al
07C3  74 E8           je 0x7ad
07C5  C9              leave
07C6  CA 04 00        retf 4

; ---- routine 232A:07C9  (found by: far)
sub_07C9:
07C9  C8 16 00 00     enter 0x16, 0
07CD  FF 76 08        push word ptr [bp + 8]
07D0  FF 76 06        push word ptr [bp + 6]
07D3  6A 00           push 0
07D5  8D 7E EA        lea di, [bp - 0x16]
07D8  16              push ss
07D9  57              push di
07DA  6A 14           push 0x14
07DC  9A 0A 19 C9 26  call far 26C9:190A
07E1  8D 7E EA        lea di, [bp - 0x16]
07E4  16              push ss
07E5  57              push di
07E6  C4 7E 0A        les di, ptr [bp + 0xa]
07E9  06              push es
07EA  57              push di
07EB  6A 14           push 0x14
07ED  9A 6D 0B C9 26  call far 26C9:0B6D
07F2  C9              leave
07F3  CA 04 00        retf 4

; ---- routine 232A:07F6  (found by: far)
sub_07F6:
07F6  C8 52 00 00     enter 0x52, 0
07FA  8C D3           mov bx, ss
07FC  8E C3           mov es, bx
07FE  8C DB           mov bx, ds
0800  FC              cld
0801  8D 7E AE        lea di, [bp - 0x52]
0804  C5 76 06        lds si, ptr [bp + 6]
0807  AC              lodsb al, byte ptr [si]
0808  3C 50           cmp al, 0x50
080A  72 02           jb 0x80e
080C  B0 50           mov al, 0x50
loc_080E:
080E  AA              stosb byte ptr es:[di], al
080F  91              xchg cx, ax
0810  30 ED           xor ch, ch
0812  F3 A4           rep movsb byte ptr es:[di], byte ptr [si]
0814  8E DB           mov ds, bx
0816  8D 7E AE        lea di, [bp - 0x52]
0819  16              push ss
081A  57              push di
081B  9A BE 06 BC 24  call far 24BC:06BE
0820  C9              leave
0821  CA 04 00        retf 4
; data (not reached as code), 69 bytes
0824                  pstr 'Do you want to print out this screen'
0849                  pstr "something's up with the printer"

; ---- routine 232A:0869  (found by: call)
sub_0869:
0869  C8 8C 00 00     enter 0x8c, 0
086D  81 3E 72 F8 C8 00 cmp word ptr [0xf872], 0xc8
0873  74 16           je 0x88b
0875  9A 6D 12 BC 24  call far 24BC:126D
087A  08 C0           or al, al
087C  74 0D           je 0x88b
087E  BF 24 08        mov di, 0x824
0881  0E              push cs
0882  57              push di
0883  0E              push cs
0884  E8 5E FE        call 0x6e5
0887  08 C0           or al, al
0889  75 03           jne 0x88e
loc_088B:
088B  E9 09 01        jmp 0x997
loc_088E:
088E  9A 68 05 BC 24  call far 24BC:0568
0893  31 C0           xor ax, ax
0895  A3 02 DF        mov word ptr [0xdf02], ax
0898  A1 04 DF        mov ax, word ptr [0xdf04]
089B  89 46 FE        mov word ptr [bp - 2], ax
089E  C7 06 04 DF 04 00 mov word ptr [0xdf04], 4
08A4  BF 2E A3        mov di, 0xa32e
08A7  1E              push ds
08A8  57              push di
08A9  6A 02           push 2
08AB  0E              push cs
08AC  E8 34 09        call 0x11e3
08AF  88 86 78 FF     mov byte ptr [bp - 0x88], al
08B3  8A 46 06        mov al, byte ptr [bp + 6]
08B6  30 E4           xor ah, ah
08B8  89 86 76 FF     mov word ptr [bp - 0x8a], ax
08BC  8A 46 08        mov al, byte ptr [bp + 8]
08BF  30 E4           xor ah, ah
08C1  3B 86 76 FF     cmp ax, word ptr [bp - 0x8a]
08C5  76 03           jbe 0x8ca
08C7  E9 96 00        jmp 0x960
loc_08CA:
08CA  89 46 FA        mov word ptr [bp - 6], ax
08CD  EB 03           jmp 0x8d2
loc_08CF:
08CF  FF 46 FA        inc word ptr [bp - 6]
loc_08D2:
08D2  8A 46 0A        mov al, byte ptr [bp + 0xa]
08D5  30 E4           xor ah, ah
08D7  89 86 74 FF     mov word ptr [bp - 0x8c], ax
08DB  8A 46 0C        mov al, byte ptr [bp + 0xc]
08DE  30 E4           xor ah, ah
08E0  3B 86 74 FF     cmp ax, word ptr [bp - 0x8c]
08E4  77 58           ja 0x93e
08E6  89 46 FC        mov word ptr [bp - 4], ax
08E9  EB 03           jmp 0x8ee
loc_08EB:
08EB  FF 46 FC        inc word ptr [bp - 4]
loc_08EE:
08EE  8B 46 FC        mov ax, word ptr [bp - 4]
08F1  D1 E0           shl ax, 1
08F3  8B D0           mov dx, ax
08F5  69 46 FA A0 00  imul ax, word ptr [bp - 6], 0xa0
08FA  C4 3E 5C DD     les di, ptr [0xdd5c]
08FE  03 F8           add di, ax
0900  03 FA           add di, dx
0902  26 8A 85 5E FF  mov al, byte ptr es:[di - 0xa2]
0907  88 86 79 FF     mov byte ptr [bp - 0x87], al
090B  80 BE 79 FF 20  cmp byte ptr [bp - 0x87], 0x20
0910  72 07           jb 0x919
0912  80 BE 79 FF 80  cmp byte ptr [bp - 0x87], 0x80
0917  76 05           jbe 0x91e
loc_0919:
0919  C6 86 79 FF 20  mov byte ptr [bp - 0x87], 0x20
loc_091E:
091E  80 BE 78 FF 00  cmp byte ptr [bp - 0x88], 0
0923  74 10           je 0x935
0925  8D BE 79 FF     lea di, [bp - 0x87]
0929  16              push ss
092A  57              push di
092B  6A 01           push 1
092D  0E              push cs
092E  E8 B2 08        call 0x11e3
0931  88 86 78 FF     mov byte ptr [bp - 0x88], al
loc_0935:
0935  8B 46 FC        mov ax, word ptr [bp - 4]
0938  3B 86 74 FF     cmp ax, word ptr [bp - 0x8c]
093C  75 AD           jne 0x8eb
loc_093E:
093E  80 BE 78 FF 00  cmp byte ptr [bp - 0x88], 0
0943  74 0F           je 0x954
0945  BF 2E A3        mov di, 0xa32e
0948  1E              push ds
0949  57              push di
094A  6A 02           push 2
094C  0E              push cs
094D  E8 93 08        call 0x11e3
0950  88 86 78 FF     mov byte ptr [bp - 0x88], al
loc_0954:
0954  8B 46 FA        mov ax, word ptr [bp - 6]
0957  3B 86 76 FF     cmp ax, word ptr [bp - 0x8a]
095B  74 03           je 0x960
095D  E9 6F FF        jmp 0x8cf
loc_0960:
0960  80 BE 78 FF 00  cmp byte ptr [bp - 0x88], 0
0965  74 0F           je 0x976
0967  BF 30 A3        mov di, 0xa330
096A  1E              push ds
096B  57              push di
096C  6A 01           push 1
096E  0E              push cs
096F  E8 71 08        call 0x11e3
0972  88 86 78 FF     mov byte ptr [bp - 0x88], al
loc_0976:
0976  80 BE 78 FF 00  cmp byte ptr [bp - 0x88], 0
097B  75 0A           jne 0x987
097D  BF 49 08        mov di, 0x849
0980  0E              push cs
0981  57              push di
0982  9A 02 07 BC 24  call far 24BC:0702
loc_0987:
0987  8B 46 FE        mov ax, word ptr [bp - 2]
098A  A3 04 DF        mov word ptr [0xdf04], ax
098D  9A 98 05 BC 24  call far 24BC:0598
0992  C6 06 88 DE CD  mov byte ptr [0xde88], 0xcd
loc_0997:
0997  C9              leave
0998  CA 08 00        retf 8

