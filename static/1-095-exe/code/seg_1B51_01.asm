; 1-095.EXE (One-Nil 95), code segment 1B51 (image offsets 1B510..2305F), part 1 of 12
; packed 1-095.EXE sha256 f659fb2d334500d6901fc8d6a0f06c85c0ccda2eb4a3035ae3bb0a0004d79192 (LZEXE 0.91)
; unpacked (tools/static/unlzexe.py) sha256 8df646e017e0965a5d90a58181ca764219ad847833aad0b6cb58fc53372bfb2c
; tool: capstone 5.0.9 (pip package; core library 5.0.1280) (CS_ARCH_X86, CS_MODE_16), recursive descent from the entry point, far calls and near calls/jumps, then routine prologues (55 89 E5 / 55 8B EC / C8 iw 00) in what remains; tools/static/listing.py
; addresses are SEGMENT:OFFSET with SEGMENT the image paragraph before relocation; image offset = SEGMENT*16+OFFSET

; ---- routine 1B51:0000  (found by: far)
sub_0000:
0000  C8 02 00 00     enter 2, 0
0004  80 7E 06 20     cmp byte ptr [bp + 6], 0x20
0008  76 07           jbe 0x11
000A  C7 46 FE 61 00  mov word ptr [bp - 2], 0x61
000F  EB 10           jmp 0x21
loc_0011:
0011  8A 46 06        mov al, byte ptr [bp + 6]
0014  30 E4           xor ah, ah
0016  8B F8           mov di, ax
0018  8A 85 69 0E     mov al, byte ptr [di + 0xe69]
001C  30 E4           xor ah, ah
001E  89 46 FE        mov word ptr [bp - 2], ax
loc_0021:
0021  8B 46 FE        mov ax, word ptr [bp - 2]
0024  C9              leave
0025  CA 02 00        retf 2
; data (not reached as code), 45 bytes
0028                  pstr 'Cannot load file "'
003B                  pstr '" - program terminated - '

; ---- routine 1B51:0055  (found by: call)
sub_0055:
0055  C8 16 01 00     enter 0x116, 0
0059  8C D3           mov bx, ss
005B  8E C3           mov es, bx
005D  8C DB           mov bx, ds
005F  FC              cld
0060  8D 7E EA        lea di, [bp - 0x16]
0063  C5 76 04        lds si, ptr [bp + 4]
0066  AC              lodsb al, byte ptr [si]
0067  3C 14           cmp al, 0x14
0069  72 02           jb 0x6d
006B  B0 14           mov al, 0x14
loc_006D:
006D  AA              stosb byte ptr es:[di], al
006E  91              xchg cx, ax
006F  30 ED           xor ch, ch
0071  F3 A4           rep movsb byte ptr es:[di], byte ptr [si]
0073  8E DB           mov ds, bx
0075  BF 8A 0E        mov di, 0xe8a
0078  1E              push ds
0079  57              push di
007A  BF 58 DD        mov di, 0xdd58
007D  1E              push ds
007E  57              push di
007F  9A 2F 05 1A 23  call far 231A:052F
0084  8D 7E EA        lea di, [bp - 0x16]
0087  16              push ss
0088  57              push di
0089  9A 50 12 1A 23  call far 231A:1250
008E  08 C0           or al, al
0090  75 29           jne 0xbb
0092  8D BE EA FE     lea di, [bp - 0x116]
0096  16              push ss
0097  57              push di
0098  BF 28 00        mov di, 0x28
009B  0E              push cs
009C  57              push di
009D  9A 53 0B B9 26  call far 26B9:0B53
00A2  8D 7E EA        lea di, [bp - 0x16]
00A5  16              push ss
00A6  57              push di
00A7  9A D2 0B B9 26  call far 26B9:0BD2
00AC  BF 3B 00        mov di, 0x3b
00AF  0E              push cs
00B0  57              push di
00B1  9A D2 0B B9 26  call far 26B9:0BD2
00B6  9A F6 07 1A 23  call far 231A:07F6
loc_00BB:
00BB  C9              leave
00BC  C2 04 00        ret 4
; data (not reached as code), 2 bytes
00BF                  db 01 30   ; .0

; ---- routine 1B51:00C1  (found by: call, far)
sub_00C1:
00C1  C8 0C 01 00     enter 0x10c, 0
00C5  8D BE F4 FE     lea di, [bp - 0x10c]
00C9  16              push ss
00CA  57              push di
00CB  8B 46 06        mov ax, word ptr [bp + 6]
00CE  31 D2           xor dx, dx
00D0  B9 64 00        mov cx, 0x64
00D3  F7 F1           div cx
00D5  92              xchg dx, ax
00D6  31 D2           xor dx, dx
00D8  52              push dx
00D9  50              push ax
00DA  9A C9 07 1A 23  call far 231A:07C9
00DF  8D 7E F4        lea di, [bp - 0xc]
00E2  16              push ss
00E3  57              push di
00E4  6A 0A           push 0xa
00E6  9A 6D 0B B9 26  call far 26B9:0B6D
00EB  80 7E F4 01     cmp byte ptr [bp - 0xc], 1
00EF  75 26           jne 0x117
00F1  8D BE F4 FE     lea di, [bp - 0x10c]
00F5  16              push ss
00F6  57              push di
00F7  BF BF 00        mov di, 0xbf
00FA  0E              push cs
00FB  57              push di
00FC  9A 53 0B B9 26  call far 26B9:0B53
0101  8D 7E F4        lea di, [bp - 0xc]
0104  16              push ss
0105  57              push di
0106  9A D2 0B B9 26  call far 26B9:0BD2
010B  8D 7E F4        lea di, [bp - 0xc]
010E  16              push ss
010F  57              push di
0110  6A 0A           push 0xa
0112  9A 6D 0B B9 26  call far 26B9:0B6D
loc_0117:
0117  8D 7E F4        lea di, [bp - 0xc]
011A  16              push ss
011B  57              push di
011C  C4 7E 08        les di, ptr [bp + 8]
011F  06              push es
0120  57              push di
0121  6A 0A           push 0xa
0123  9A 6D 0B B9 26  call far 26B9:0B6D
0128  C9              leave
0129  CA 02 00        retf 2
; data (not reached as code), 16 bytes
012C                  pstr 'TRIA'
0131                  db 01 2E 01 20 01 2D   ; ... .-
0137                  pstr '.DAT'

; ---- routine 1B51:013C  (found by: call)
sub_013C:
013C  C8 22 02 00     enter 0x222, 0
0140  80 3E D8 DC 02  cmp byte ptr [0xdcd8], 2
0145  75 13           jne 0x15a
0147  BF 2C 01        mov di, 0x12c
014A  0E              push cs
014B  57              push di
014C  8D 7E F0        lea di, [bp - 0x10]
014F  16              push ss
0150  57              push di
0151  6A 0F           push 0xf
0153  9A 6D 0B B9 26  call far 26B9:0B6D
0158  EB 27           jmp 0x181
loc_015A:
015A  8D BE DE FE     lea di, [bp - 0x122]
015E  16              push ss
015F  57              push di
0160  A0 D8 DC        mov al, byte ptr [0xdcd8]
0163  30 E4           xor ah, ah
0165  8B F8           mov di, ax
0167  C1 E7 04        shl di, 4
016A  81 C7 2C 9A     add di, 0x9a2c
016E  1E              push ds
016F  57              push di
0170  9A 5A 00 AC 24  call far 24AC:005A
0175  8D 7E F0        lea di, [bp - 0x10]
0178  16              push ss
0179  57              push di
017A  6A 0F           push 0xf
017C  9A 6D 0B B9 26  call far 26B9:0B6D
loc_0181:
0181  BF 31 01        mov di, 0x131
0184  0E              push cs
0185  57              push di
0186  8D 7E F0        lea di, [bp - 0x10]
0189  16              push ss
018A  57              push di
018B  9A FE 0B B9 26  call far 26B9:0BFE
0190  89 46 DE        mov word ptr [bp - 0x22], ax
loc_0193:
0193  83 7E DE 00     cmp word ptr [bp - 0x22], 0
0197  74 1B           je 0x1b4
0199  8B 7E DE        mov di, word ptr [bp - 0x22]
019C  C6 43 F0 20     mov byte ptr [bp + di - 0x10], 0x20
01A0  BF 31 01        mov di, 0x131
01A3  0E              push cs
01A4  57              push di
01A5  8D 7E F0        lea di, [bp - 0x10]
01A8  16              push ss
01A9  57              push di
01AA  9A FE 0B B9 26  call far 26B9:0BFE
01AF  89 46 DE        mov word ptr [bp - 0x22], ax
01B2  EB DF           jmp 0x193
loc_01B4:
01B4  BF 33 01        mov di, 0x133
01B7  0E              push cs
01B8  57              push di
01B9  8D 7E F0        lea di, [bp - 0x10]
01BC  16              push ss
01BD  57              push di
01BE  9A FE 0B B9 26  call far 26B9:0BFE
01C3  09 C0           or ax, ax
01C5  74 1E           je 0x1e5
01C7  8D 7E F0        lea di, [bp - 0x10]
01CA  16              push ss
01CB  57              push di
01CC  BF 33 01        mov di, 0x133
01CF  0E              push cs
01D0  57              push di
01D1  8D 7E F0        lea di, [bp - 0x10]
01D4  16              push ss
01D5  57              push di
01D6  9A FE 0B B9 26  call far 26B9:0BFE
01DB  50              push ax
01DC  6A 01           push 1
01DE  9A FB 0C B9 26  call far 26B9:0CFB
01E3  EB CF           jmp 0x1b4
loc_01E5:
01E5  80 7E F0 04     cmp byte ptr [bp - 0x10], 4
01E9  73 28           jae 0x213
01EB  8D BE DE FE     lea di, [bp - 0x122]
01EF  16              push ss
01F0  57              push di
01F1  8D 7E F0        lea di, [bp - 0x10]
01F4  16              push ss
01F5  57              push di
01F6  9A 53 0B B9 26  call far 26B9:0B53
01FB  BF 35 01        mov di, 0x135
01FE  0E              push cs
01FF  57              push di
0200  9A D2 0B B9 26  call far 26B9:0BD2
0205  8D 7E F0        lea di, [bp - 0x10]
0208  16              push ss
0209  57              push di
020A  6A 0F           push 0xf
020C  9A 6D 0B B9 26  call far 26B9:0B6D
0211  EB D2           jmp 0x1e5
loc_0213:
0213  C6 46 F5 2D     mov byte ptr [bp - 0xb], 0x2d
0217  C6 46 F0 05     mov byte ptr [bp - 0x10], 5
021B  8D BE DE FD     lea di, [bp - 0x222]
021F  16              push ss
0220  57              push di
0221  8D 7E F0        lea di, [bp - 0x10]
0224  16              push ss
0225  57              push di
0226  9A 53 0B B9 26  call far 26B9:0B53
022B  8D BE DE FE     lea di, [bp - 0x122]
022F  16              push ss
0230  57              push di
0231  FF 36 DA DC     push word ptr [0xdcda]
0235  0E              push cs
0236  E8 88 FE        call 0xc1
0239  9A D2 0B B9 26  call far 26B9:0BD2
023E  BF 37 01        mov di, 0x137
0241  0E              push cs
0242  57              push di
0243  9A D2 0B B9 26  call far 26B9:0BD2
0248  BF 8C D6        mov di, 0xd68c
024B  1E              push ds
024C  57              push di
024D  6A 50           push 0x50
024F  9A 6D 0B B9 26  call far 26B9:0B6D
0254  C9              leave
0255  C3              ret
; data (not reached as code), 2 bytes
0256                  db 01 2E   ; ..

; ---- routine 1B51:0258  (found by: call)
sub_0258:
0258  C8 00 01 00     enter 0x100, 0
025C  8B 7E 04        mov di, word ptr [bp + 4]
025F  36 FF 45 FE     inc word ptr ss:[di - 2]
0263  8D BE 00 FF     lea di, [bp - 0x100]
0267  16              push ss
0268  57              push di
0269  8B 7E 04        mov di, word ptr [bp + 4]
026C  81 C7 DC FF     add di, 0xffdc
0270  16              push ss
0271  57              push di
0272  6A 01           push 1
0274  BF 56 02        mov di, 0x256
0277  0E              push cs
0278  57              push di
0279  8B 7E 04        mov di, word ptr [bp + 4]
027C  81 C7 DC FF     add di, 0xffdc
0280  16              push ss
0281  57              push di
0282  9A FE 0B B9 26  call far 26B9:0BFE
0287  48              dec ax
0288  50              push ax
0289  9A 91 0B B9 26  call far 26B9:0B91
028E  8B 7E 04        mov di, word ptr [bp + 4]
0291  36 6B 45 FE 0D  imul ax, word ptr ss:[di - 2], 0xd
0296  03 F8           add di, ax
0298  81 C7 A9 FD     add di, 0xfda9
029C  16              push ss
029D  57              push di
029E  6A 0C           push 0xc
02A0  9A 6D 0B B9 26  call far 26B9:0B6D
02A5  C9              leave
02A6  C2 02 00        ret 2

; ---- routine 1B51:02A9  (found by: call)
sub_02A9:
02A9  C8 0E 00 00     enter 0xe, 0
02AD  8C D3           mov bx, ss
02AF  8E C3           mov es, bx
02B1  8C DB           mov bx, ds
02B3  FC              cld
02B4  8D 7E F2        lea di, [bp - 0xe]
02B7  C5 76 06        lds si, ptr [bp + 6]
02BA  AC              lodsb al, byte ptr [si]
02BB  3C 0C           cmp al, 0xc
02BD  72 02           jb 0x2c1
02BF  B0 0C           mov al, 0xc
loc_02C1:
02C1  AA              stosb byte ptr es:[di], al
02C2  91              xchg cx, ax
02C3  30 ED           xor ch, ch
02C5  F3 A4           rep movsb byte ptr es:[di], byte ptr [si]
02C7  8E DB           mov ds, bx
02C9  8D 7E F2        lea di, [bp - 0xe]
02CC  16              push ss
02CD  57              push di
02CE  6A 20           push 0x20
02D0  8B 7E 04        mov di, word ptr [bp + 4]
02D3  81 C7 BE FF     add di, 0xffbe
02D7  16              push ss
02D8  57              push di
02D9  9A 00 00 A8 26  call far 26A8:0000
loc_02DE:
02DE  83 3E 24 F9 00  cmp word ptr [0xf924], 0
02E3  75 1E           jne 0x303
02E5  8B 7E 04        mov di, word ptr [bp + 4]
02E8  36 83 7D FE 28  cmp word ptr ss:[di - 2], 0x28
02ED  73 14           jae 0x303
02EF  57              push di
02F0  E8 65 FF        call 0x258
02F3  8B 7E 04        mov di, word ptr [bp + 4]
02F6  81 C7 BE FF     add di, 0xffbe
02FA  16              push ss
02FB  57              push di
02FC  9A 3E 00 A8 26  call far 26A8:003E
0301  EB DB           jmp 0x2de
loc_0303:
0303  C9              leave
0304  C2 06 00        ret 6
; data (not reached as code), 5 bytes
0307                  pstr '.1-0'

; ---- routine 1B51:030C  (found by: call)
sub_030C:
030C  C8 00 01 00     enter 0x100, 0
0310  8D BE 00 FF     lea di, [bp - 0x100]
0314  16              push ss
0315  57              push di
0316  6B 46 06 0D     imul ax, word ptr [bp + 6], 0xd
031A  8B 7E 04        mov di, word ptr [bp + 4]
031D  03 F8           add di, ax
031F  81 C7 A9 FD     add di, 0xfda9
0323  16              push ss
0324  57              push di
0325  9A 53 0B B9 26  call far 26B9:0B53
032A  BF 07 03        mov di, 0x307
032D  0E              push cs
032E  57              push di
032F  9A D2 0B B9 26  call far 26B9:0BD2
0334  BF EC D6        mov di, 0xd6ec
0337  1E              push ds
0338  57              push di
0339  9A EE 14 AC 24  call far 24AC:14EE
033E  8D BE 00 FF     lea di, [bp - 0x100]
0342  16              push ss
0343  57              push di
0344  BF EC D6        mov di, 0xd6ec
0347  1E              push ds
0348  57              push di
0349  9A 53 0B B9 26  call far 26B9:0B53
034E  BF 31 D7        mov di, 0xd731
0351  1E              push ds
0352  57              push di
0353  9A D2 0B B9 26  call far 26B9:0BD2
0358  BF 3E D7        mov di, 0xd73e
035B  1E              push ds
035C  57              push di
035D  6A 50           push 0x50
035F  9A 6D 0B B9 26  call far 26B9:0B6D
0364  C9              leave
0365  C2 04 00        ret 4
; data (not reached as code), 61 bytes
0368                  pstr 'Looking for saved games...'
0383                  pstr '*.1-0'
0389                  pstr 'Cannot find any saved games'

; ---- routine 1B51:03A5  (found by: call)
sub_03A5:
03A5  C8 4C 02 00     enter 0x24c, 0
03A9  6A 19           push 0x19
03AB  BF 68 03        mov di, 0x368
03AE  0E              push cs
03AF  57              push di
03B0  BF 58 DD        mov di, 0xdd58
03B3  1E              push ds
03B4  57              push di
03B5  9A 55 05 1A 23  call far 231A:0555
03BA  31 C0           xor ax, ax
03BC  89 46 FE        mov word ptr [bp - 2], ax
03BF  BF 83 03        mov di, 0x383
03C2  0E              push cs
03C3  57              push di
03C4  55              push bp
03C5  E8 E1 FE        call 0x2a9
03C8  83 7E FE 00     cmp word ptr [bp - 2], 0
03CC  75 14           jne 0x3e2
03CE  BF 89 03        mov di, 0x389
03D1  0E              push cs
03D2  57              push di
03D3  9A 02 07 AC 24  call far 24AC:0702
03D8  31 C0           xor ax, ax
03DA  9A 16 01 B9 26  call far 26B9:0116
03DF  E9 D7 00        jmp 0x4b9
loc_03E2:
03E2  83 7E FE 01     cmp word ptr [bp - 2], 1
03E6  75 09           jne 0x3f1
03E8  6A 01           push 1
03EA  55              push bp
03EB  E8 1E FF        call 0x30c
03EE  E9 C8 00        jmp 0x4b9
loc_03F1:
03F1  BF 38 82        mov di, 0x8238
03F4  1E              push ds
03F5  57              push di
03F6  BF 5C DD        mov di, 0xdd5c
03F9  1E              push ds
03FA  57              push di
03FB  9A 2F 05 1A 23  call far 231A:052F
0400  BF 66 43        mov di, 0x4366
0403  1E              push ds
0404  57              push di
0405  BF 5C DD        mov di, 0xdd5c
0408  1E              push ds
0409  57              push di
040A  9A 2F 05 1A 23  call far 231A:052F
040F  C7 46 FA 0E 00  mov word ptr [bp - 6], 0xe
0414  A1 A8 0E        mov ax, word ptr [0xea8]
0417  05 08 00        add ax, 8
041A  89 86 B4 FD     mov word ptr [bp - 0x24c], ax
041E  A1 A8 0E        mov ax, word ptr [0xea8]
0421  3B 86 B4 FD     cmp ax, word ptr [bp - 0x24c]
0425  77 38           ja 0x45f
0427  89 46 FC        mov word ptr [bp - 4], ax
042A  EB 03           jmp 0x42f
loc_042C:
042C  FF 46 FC        inc word ptr [bp - 4]
loc_042F:
042F  8B 46 FC        mov ax, word ptr [bp - 4]
0432  3B 46 FE        cmp ax, word ptr [bp - 2]
0435  77 1F           ja 0x456
0437  FF 46 FA        inc word ptr [bp - 6]
043A  6A 1F           push 0x1f
043C  6B 7E FC 0D     imul di, word ptr [bp - 4], 0xd
0440  8D BB A9 FD     lea di, [bp + di - 0x257]
0444  16              push ss
0445  57              push di
0446  8A 46 FA        mov al, byte ptr [bp - 6]
0449  50              push ax
044A  6A 1C           push 0x1c
044C  BF 5C DD        mov di, 0xdd5c
044F  1E              push ds
0450  57              push di
0451  9A 1B 04 1A 23  call far 231A:041B
loc_0456:
0456  8B 46 FC        mov ax, word ptr [bp - 4]
0459  3B 86 B4 FD     cmp ax, word ptr [bp - 0x24c]
045D  75 CD           jne 0x42c
loc_045F:
045F  A0 A6 0E        mov al, byte ptr [0xea6]
0462  30 E4           xor ah, ah
0464  05 0E 00        add ax, 0xe
0467  50              push ax
0468  6A 1B           push 0x1b
046A  6A 12           push 0x12
046C  9A 03 02 1A 23  call far 231A:0203
0471  C4 3E 5C DD     les di, ptr [0xdd5c]
0475  06              push es
0476  57              push di
0477  C4 3E 58 DD     les di, ptr [0xdd58]
047B  06              push es
047C  57              push di
047D  68 A0 0F        push 0xfa0
0480  9A 12 0A B9 26  call far 26B9:0A12
0485  9A 9B 09 1A 23  call far 231A:099B
048A  BF A6 0E        mov di, 0xea6
048D  1E              push ds
048E  57              push di
048F  BF A8 0E        mov di, 0xea8
0492  1E              push ds
0493  57              push di
0494  6A 09           push 9
0496  FF 76 FE        push word ptr [bp - 2]
0499  9A D7 0F 1A 23  call far 231A:0FD7
049E  80 3E 88 DE 02  cmp byte ptr [0xde88], 2
04A3  75 11           jne 0x4b6
04A5  A0 A6 0E        mov al, byte ptr [0xea6]
04A8  30 E4           xor ah, ah
04AA  03 06 A8 0E     add ax, word ptr [0xea8]
04AE  48              dec ax
04AF  50              push ax
04B0  55              push bp
04B1  E8 58 FE        call 0x30c
04B4  EB 03           jmp 0x4b9
loc_04B6:
04B6  E9 38 FF        jmp 0x3f1
loc_04B9:
04B9  C9              leave
04BA  C3              ret

; ---- routine 1B51:04BB  (found by: call)
sub_04BB:
04BB  55              push bp
04BC  89 E5           mov bp, sp
04BE  8B 7E 04        mov di, word ptr [bp + 4]
04C1  81 C7 DC FF     add di, 0xffdc
04C5  16              push ss
04C6  57              push di
04C7  9A 50 12 1A 23  call far 231A:1250
04CC  08 C0           or al, al
04CE  74 32           je 0x502
04D0  8B 7E 04        mov di, word ptr [bp + 4]
04D3  36 FF 45 FE     inc word ptr ss:[di - 2]
04D7  36 8B 45 FE     mov ax, word ptr ss:[di - 2]
04DB  03 F8           add di, ax
04DD  81 C7 95 FF     add di, 0xff95
04E1  16              push ss
04E2  57              push di
04E3  6A 01           push 1
04E5  9A 08 12 1A 23  call far 231A:1208
04EA  8B 7E 04        mov di, word ptr [bp + 4]
04ED  36 8B 45 FE     mov ax, word ptr ss:[di - 2]
04F1  D1 E0           shl ax, 1
04F3  03 F8           add di, ax
04F5  81 C7 44 FF     add di, 0xff44
04F9  16              push ss
04FA  57              push di
04FB  6A 02           push 2
04FD  9A 08 12 1A 23  call far 231A:1208
loc_0502:
0502  9A 54 10 AC 24  call far 24AC:1054
0507  C9              leave
0508  C2 02 00        ret 2

; ---- routine 1B51:050B  (found by: call)
sub_050B:
050B  55              push bp
050C  89 E5           mov bp, sp
050E  A0 AA 0E        mov al, byte ptr [0xeaa]
0511  30 E4           xor ah, ah
0513  03 06 AC 0E     add ax, word ptr [0xeac]
0517  48              dec ax
0518  D1 E0           shl ax, 1
051A  8B 7E 04        mov di, word ptr [bp + 4]
051D  03 F8           add di, ax
051F  36 8B 85 44 FF  mov ax, word ptr ss:[di - 0xbc]
0524  A3 DA DC        mov word ptr [0xdcda], ax
0527  A0 AA 0E        mov al, byte ptr [0xeaa]
052A  30 E4           xor ah, ah
052C  03 06 AC 0E     add ax, word ptr [0xeac]
0530  48              dec ax
0531  8B 7E 04        mov di, word ptr [bp + 4]
0534  03 F8           add di, ax
0536  36 8A 45 95     mov al, byte ptr ss:[di - 0x6b]
053A  A2 D8 DC        mov byte ptr [0xdcd8], al
053D  C9              leave
053E  C2 02 00        ret 2

; ---- routine 1B51:0541  (found by: call)
sub_0541:
0541  C8 0E 00 00     enter 0xe, 0
0545  8C D3           mov bx, ss
0547  8E C3           mov es, bx
0549  8C DB           mov bx, ds
054B  FC              cld
054C  8D 7E F2        lea di, [bp - 0xe]
054F  C5 76 06        lds si, ptr [bp + 6]
0552  AC              lodsb al, byte ptr [si]
0553  3C 0C           cmp al, 0xc
0555  72 02           jb 0x559
0557  B0 0C           mov al, 0xc
loc_0559:
0559  AA              stosb byte ptr es:[di], al
055A  91              xchg cx, ax
055B  30 ED           xor ch, ch
055D  F3 A4           rep movsb byte ptr es:[di], byte ptr [si]
055F  8E DB           mov ds, bx
0561  8D 7E F2        lea di, [bp - 0xe]
0564  16              push ss
0565  57              push di
0566  6A 20           push 0x20
0568  8B 7E 04        mov di, word ptr [bp + 4]
056B  81 C7 BE FF     add di, 0xffbe
056F  16              push ss
0570  57              push di
0571  9A 00 00 A8 26  call far 26A8:0000
loc_0576:
0576  83 3E 24 F9 00  cmp word ptr [0xf924], 0
057B  75 1E           jne 0x59b
057D  8B 7E 04        mov di, word ptr [bp + 4]
0580  36 83 7D FE 28  cmp word ptr ss:[di - 2], 0x28
0585  73 14           jae 0x59b
0587  57              push di
0588  E8 30 FF        call 0x4bb
058B  8B 7E 04        mov di, word ptr [bp + 4]
058E  81 C7 BE FF     add di, 0xffbe
0592  16              push ss
0593  57              push di
0594  9A 3E 00 A8 26  call far 26A8:003E
0599  EB DB           jmp 0x576
loc_059B:
059B  C9              leave
059C  C2 06 00        ret 6
; data (not reached as code), 57 bytes
059F                  pstr 'Finding data files...'
05B5                  pstr '*.DAT'
05BB                  pstr 'Cannot find any data files'
05D6                  db 01 2F   ; ./

; ---- routine 1B51:05D8  (found by: call)
sub_05D8:
05D8  C8 BC 02 00     enter 0x2bc, 0
05DC  6A 19           push 0x19
05DE  BF 9F 05        mov di, 0x59f
05E1  0E              push cs
05E2  57              push di
05E3  BF 58 DD        mov di, 0xdd58
05E6  1E              push ds
05E7  57              push di
05E8  9A 55 05 1A 23  call far 231A:0555
05ED  31 C0           xor ax, ax
05EF  89 46 FE        mov word ptr [bp - 2], ax
05F2  BF B5 05        mov di, 0x5b5
05F5  0E              push cs
05F6  57              push di
05F7  55              push bp
05F8  E8 46 FF        call 0x541
05FB  83 7E FE 01     cmp word ptr [bp - 2], 1
05FF  75 07           jne 0x608
0601  55              push bp
0602  E8 06 FF        call 0x50b
0605  E9 24 01        jmp 0x72c
loc_0608:
0608  83 7E FE 00     cmp word ptr [bp - 2], 0
060C  75 14           jne 0x622
060E  BF BB 05        mov di, 0x5bb
0611  0E              push cs
0612  57              push di
0613  9A 02 07 AC 24  call far 24AC:0702
0618  31 C0           xor ax, ax
061A  9A 16 01 B9 26  call far 26B9:0116
061F  E9 0A 01        jmp 0x72c
loc_0622:
0622  BF 38 82        mov di, 0x8238
0625  1E              push ds
0626  57              push di
0627  BF 5C DD        mov di, 0xdd5c
062A  1E              push ds
062B  57              push di
062C  9A 2F 05 1A 23  call far 231A:052F
0631  C7 46 FA 0E 00  mov word ptr [bp - 6], 0xe
0636  A1 AC 0E        mov ax, word ptr [0xeac]
0639  05 08 00        add ax, 8
063C  89 86 44 FF     mov word ptr [bp - 0xbc], ax
0640  A1 AC 0E        mov ax, word ptr [0xeac]
0643  3B 86 44 FF     cmp ax, word ptr [bp - 0xbc]
0647  76 03           jbe 0x64c
0649  E9 91 00        jmp 0x6dd
loc_064C:
064C  89 46 FC        mov word ptr [bp - 4], ax
064F  EB 03           jmp 0x654
loc_0651:
0651  FF 46 FC        inc word ptr [bp - 4]
loc_0654:
0654  8B 46 FC        mov ax, word ptr [bp - 4]
0657  3B 46 FE        cmp ax, word ptr [bp - 2]
065A  77 75           ja 0x6d1
065C  FF 46 FA        inc word ptr [bp - 6]
065F  6A 1F           push 0x1f
0661  8B 7E FC        mov di, word ptr [bp - 4]
0664  8A 43 95        mov al, byte ptr [bp + di - 0x6b]
0667  30 E4           xor ah, ah
0669  8B F8           mov di, ax
066B  C1 E7 04        shl di, 4
066E  81 C7 2C 9A     add di, 0x9a2c
0672  1E              push ds
0673  57              push di
0674  8A 46 FA        mov al, byte ptr [bp - 6]
0677  50              push ax
0678  6A 1C           push 0x1c
067A  BF 5C DD        mov di, 0xdd5c
067D  1E              push ds
067E  57              push di
067F  9A 1B 04 1A 23  call far 231A:041B
0684  6A 17           push 0x17
0686  8D BE 44 FE     lea di, [bp - 0x1bc]
068A  16              push ss
068B  57              push di
068C  8B 7E FC        mov di, word ptr [bp - 4]
068F  D1 E7           shl di, 1
0691  8B 83 44 FF     mov ax, word ptr [bp + di - 0xbc]
0695  48              dec ax
0696  31 D2           xor dx, dx
0698  52              push dx
0699  50              push ax
069A  9A C9 07 1A 23  call far 231A:07C9
069F  BF D6 05        mov di, 0x5d6
06A2  0E              push cs
06A3  57              push di
06A4  9A D2 0B B9 26  call far 26B9:0BD2
06A9  8D BE 44 FD     lea di, [bp - 0x2bc]
06AD  16              push ss
06AE  57              push di
06AF  8B 7E FC        mov di, word ptr [bp - 4]
06B2  D1 E7           shl di, 1
06B4  FF B3 44 FF     push word ptr [bp + di - 0xbc]
06B8  0E              push cs
06B9  E8 05 FA        call 0xc1
06BC  9A D2 0B B9 26  call far 26B9:0BD2
06C1  8A 46 FA        mov al, byte ptr [bp - 6]
06C4  50              push ax
06C5  6A 25           push 0x25
06C7  BF 5C DD        mov di, 0xdd5c
06CA  1E              push ds
06CB  57              push di
06CC  9A 1B 04 1A 23  call far 231A:041B
loc_06D1:
06D1  8B 46 FC        mov ax, word ptr [bp - 4]
06D4  3B 86 44 FF     cmp ax, word ptr [bp - 0xbc]
06D8  74 03           je 0x6dd
06DA  E9 74 FF        jmp 0x651
loc_06DD:
06DD  A0 AA 0E        mov al, byte ptr [0xeaa]
06E0  30 E4           xor ah, ah
06E2  05 0E 00        add ax, 0xe
06E5  50              push ax
06E6  6A 1B           push 0x1b
06E8  6A 12           push 0x12
06EA  9A 03 02 1A 23  call far 231A:0203
06EF  C4 3E 5C DD     les di, ptr [0xdd5c]
06F3  06              push es
06F4  57              push di
06F5  C4 3E 58 DD     les di, ptr [0xdd58]
06F9  06              push es
06FA  57              push di
06FB  68 A0 0F        push 0xfa0
06FE  9A 12 0A B9 26  call far 26B9:0A12
0703  9A 9B 09 1A 23  call far 231A:099B
0708  BF AA 0E        mov di, 0xeaa
070B  1E              push ds
070C  57              push di
070D  BF AC 0E        mov di, 0xeac
0710  1E              push ds
0711  57              push di
0712  6A 09           push 9
0714  FF 76 FE        push word ptr [bp - 2]
0717  9A D7 0F 1A 23  call far 231A:0FD7
071C  80 3E 88 DE 02  cmp byte ptr [0xde88], 2
0721  75 06           jne 0x729
0723  55              push bp
0724  E8 E4 FD        call 0x50b
0727  EB 03           jmp 0x72c
loc_0729:
0729  E9 F6 FE        jmp 0x622
loc_072C:
072C  C9              leave
072D  C2 02 00        ret 2

; ---- routine 1B51:0730  (found by: call)
sub_0730:
0730  C8 0A 00 00     enter 0xa, 0
0734  6A 10           push 0x10
0736  6A 01           push 1
0738  6A 50           push 0x50
073A  6A 19           push 0x19
073C  6A 19           push 0x19
073E  BF 5C DD        mov di, 0xdd5c
0741  1E              push ds
0742  57              push di
0743  9A 07 05 1A 23  call far 231A:0507
0748  80 7E 06 00     cmp byte ptr [bp + 6], 0
074C  74 04           je 0x752
074E  55              push bp
074F  E8 86 FE        call 0x5d8
loc_0752:
0752  E8 E7 F9        call 0x13c
0755  BF 8C D6        mov di, 0xd68c
0758  1E              push ds
0759  57              push di
075A  E8 F8 F8        call 0x55
075D  BF D8 DC        mov di, 0xdcd8
0760  1E              push ds
0761  57              push di
0762  6A 01           push 1
0764  9A 08 12 1A 23  call far 231A:1208
0769  BF DA DC        mov di, 0xdcda
076C  1E              push ds
076D  57              push di
076E  6A 02           push 2
0770  9A 08 12 1A 23  call far 231A:1208
0775  BF E0 DC        mov di, 0xdce0
0778  1E              push ds
0779  57              push di
077A  6A 01           push 1
077C  9A 08 12 1A 23  call far 231A:1208
0781  BF 90 D7        mov di, 0xd790
0784  1E              push ds
0785  57              push di
0786  6A 02           push 2
0788  9A 08 12 1A 23  call far 231A:1208
078D  BF E6 DC        mov di, 0xdce6
0790  1E              push ds
0791  57              push di
0792  6A 70           push 0x70
0794  9A 08 12 1A 23  call far 231A:1208
0799  C4 3E B2 D7     les di, ptr [0xd7b2]
079D  06              push es
079E  57              push di
079F  68 00 0B        push 0xb00
07A2  9A 08 12 1A 23  call far 231A:1208
07A7  C4 3E B6 D7     les di, ptr [0xd7b6]
07AB  06              push es
07AC  57              push di
07AD  68 B0 00        push 0xb0
07B0  9A 08 12 1A 23  call far 231A:1208
07B5  BF D6 D7        mov di, 0xd7d6
07B8  1E              push ds
07B9  57              push di
07BA  68 B0 00        push 0xb0
07BD  9A 08 12 1A 23  call far 231A:1208
07C2  C4 3E D4 DC     les di, ptr [0xdcd4]
07C6  06              push es
07C7  57              push di
07C8  68 E9 03        push 0x3e9
07CB  9A 08 12 1A 23  call far 231A:1208
07D0  C4 3E CC DC     les di, ptr [0xdccc]
07D4  06              push es
07D5  57              push di
07D6  68 03 2B        push 0x2b03
07D9  9A 08 12 1A 23  call far 231A:1208
07DE  C4 3E D0 DC     les di, ptr [0xdcd0]
07E2  06              push es
07E3  57              push di
07E4  68 E9 03        push 0x3e9
07E7  9A 08 12 1A 23  call far 231A:1208
07EC  BF A2 D7        mov di, 0xd7a2
07EF  1E              push ds
07F0  57              push di
07F1  A1 90 D7        mov ax, word ptr [0xd790]
07F4  40              inc ax
07F5  50              push ax
07F6  9A 85 14 AC 24  call far 24AC:1485
07FB  C4 3E A2 D7     les di, ptr [0xd7a2]
07FF  06              push es
0800  57              push di
0801  A1 90 D7        mov ax, word ptr [0xd790]
0804  40              inc ax
0805  50              push ax
0806  9A 08 12 1A 23  call far 231A:1208
080B  C4 3E A6 D7     les di, ptr [0xd7a6]
080F  06              push es
0810  57              push di
0811  68 A4 1E        push 0x1ea4
0814  9A 08 12 1A 23  call far 231A:1208
0819  C4 3E AA D7     les di, ptr [0xd7aa]
081D  06              push es
081E  57              push di
081F  68 51 0F        push 0xf51
0822  9A 08 12 1A 23  call far 231A:1208
0827  C4 3E AE D7     les di, ptr [0xd7ae]
082B  06              push es
082C  57              push di
082D  68 51 0F        push 0xf51
0830  9A 08 12 1A 23  call far 231A:1208
0835  BF 86 D8        mov di, 0xd886
0838  1E              push ds
0839  57              push di
083A  68 B0 00        push 0xb0
083D  9A 08 12 1A 23  call far 231A:1208
0842  BF 36 D9        mov di, 0xd936
0845  1E              push ds
0846  57              push di
0847  68 B0 00        push 0xb0
084A  9A 08 12 1A 23  call far 231A:1208
084F  BF 96 DA        mov di, 0xda96
0852  1E              push ds
0853  57              push di
0854  68 10 02        push 0x210
0857  9A 08 12 1A 23  call far 231A:1208
085C  BF E6 D9        mov di, 0xd9e6
085F  1E              push ds
0860  57              push di
0861  68 B0 00        push 0xb0
0864  9A 08 12 1A 23  call far 231A:1208
0869  C7 46 FE 01 00  mov word ptr [bp - 2], 1
086E  EB 03           jmp 0x873
loc_0870:
0870  FF 46 FE        inc word ptr [bp - 2]
loc_0873:
0873  8B 46 FE        mov ax, word ptr [bp - 2]
0876  C1 E0 03        shl ax, 3
0879  C4 3E BA D7     les di, ptr [0xd7ba]
087D  03 F8           add di, ax
087F  89 7E F6        mov word ptr [bp - 0xa], di
0882  8C 46 F8        mov word ptr [bp - 8], es
0885  81 C7 01 00     add di, 1
0889  06              push es
088A  57              push di
088B  6A 01           push 1
088D  9A 08 12 1A 23  call far 231A:1208
0892  C4 7E F6        les di, ptr [bp - 0xa]
0895  81 C7 03 00     add di, 3
0899  06              push es
089A  57              push di
089B  6A 01           push 1
089D  9A 08 12 1A 23  call far 231A:1208
08A2  81 7E FE 50 0F  cmp word ptr [bp - 2], 0xf50
08A7  75 C7           jne 0x870
08A9  9A 54 10 AC 24  call far 24AC:1054
08AE  C4 3E D2 D7     les di, ptr [0xd7d2]
08B2  81 C7 F2 00     add di, 0xf2
08B6  06              push es
08B7  57              push di
08B8  6A 05           push 5
08BA  6A 01           push 1
08BC  9A 22 02 AC 24  call far 24AC:0222
08C1  6A 10           push 0x10
08C3  6A 1A           push 0x1a
08C5  6A 3F           push 0x3f
08C7  6A 0E           push 0xe
08C9  6A 19           push 0x19
08CB  BF 5C DD        mov di, 0xdd5c
08CE  1E              push ds
08CF  57              push di
08D0  9A 07 05 1A 23  call far 231A:0507
08D5  C9              leave
08D6  CA 02 00        retf 2

; ---- routine 1B51:08D9  (found by: call)
sub_08D9:
08D9  55              push bp
08DA  89 E5           mov bp, sp
08DC  8B 7E 04        mov di, word ptr [bp + 4]
08DF  36 80 7D 04 00  cmp byte ptr ss:[di + 4], 0
08E4  74 0F           je 0x8f5
08E6  C4 7E 08        les di, ptr [bp + 8]
08E9  06              push es
08EA  57              push di
08EB  FF 76 06        push word ptr [bp + 6]
08EE  9A 08 12 1A 23  call far 231A:1208
08F3  EB 1E           jmp 0x913
loc_08F5:
08F5  8B 7E 04        mov di, word ptr [bp + 4]
08F8  36 80 7D FE 00  cmp byte ptr ss:[di - 2], 0
08FD  74 14           je 0x913
08FF  C4 7E 08        les di, ptr [bp + 8]
0902  06              push es
0903  57              push di
0904  FF 76 06        push word ptr [bp + 6]
0907  9A E3 11 1A 23  call far 231A:11E3
090C  8B 7E 04        mov di, word ptr [bp + 4]
090F  36 88 45 FE     mov byte ptr ss:[di - 2], al
loc_0913:
0913  C9              leave
0914  C2 08 00        ret 8
; data (not reached as code), 6 bytes
0917                  pstr '.....'

; ---- routine 1B51:091D  (found by: call)
sub_091D:
091D  C8 04 01 00     enter 0x104, 0
0921  C6 46 FF 01     mov byte ptr [bp - 1], 1
0925  C6 46 FE 01     mov byte ptr [bp - 2], 1
0929  6A 19           push 0x19
092B  8D BE FC FE     lea di, [bp - 0x104]
092F  16              push ss
0930  57              push di
0931  8A 46 04        mov al, byte ptr [bp + 4]
0934  98              cwde
0935  6B F8 0B        imul di, ax, 0xb
0938  81 C7 AE 0E     add di, 0xeae
093C  1E              push ds
093D  57              push di
093E  9A 53 0B B9 26  call far 26B9:0B53
0943  BF 17 09        mov di, 0x917
0946  0E              push cs
0947  57              push di
0948  9A D2 0B B9 26  call far 26B9:0BD2
094D  BF 58 DD        mov di, 0xdd58
0950  1E              push ds
0951  57              push di
0952  9A 55 05 1A 23  call far 231A:0555
0957  BF D8 DC        mov di, 0xdcd8
095A  1E              push ds
095B  57              push di
095C  6A 01           push 1
095E  55              push bp
095F  E8 77 FF        call 0x8d9
0962  BF DA DC        mov di, 0xdcda
0965  1E              push ds
0966  57              push di
0967  6A 02           push 2
0969  55              push bp
096A  E8 6C FF        call 0x8d9
096D  80 3E C4 0E 00  cmp byte ptr [0xec4], 0
0972  74 13           je 0x987
0974  80 7E 04 00     cmp byte ptr [bp + 4], 0
0978  74 0D           je 0x987
097A  C6 06 C4 0E 00  mov byte ptr [0xec4], 0
097F  9A 54 10 AC 24  call far 24AC:1054
0984  E9 50 01        jmp 0xad7
loc_0987:
0987  C4 3E BA D7     les di, ptr [0xd7ba]
098B  06              push es
098C  57              push di
098D  68 88 7A        push 0x7a88
0990  55              push bp
0991  E8 45 FF        call 0x8d9
0994  C4 3E BE D7     les di, ptr [0xd7be]
0998  06              push es
0999  57              push di
099A  68 BF E5        push 0xe5bf
099D  55              push bp
099E  E8 38 FF        call 0x8d9
09A1  C4 3E C2 D7     les di, ptr [0xd7c2]
09A5  06              push es
09A6  57              push di
09A7  68 A0 2A        push 0x2aa0
09AA  55              push bp
09AB  E8 2B FF        call 0x8d9
09AE  C4 3E C6 D7     les di, ptr [0xd7c6]
09B2  06              push es
09B3  57              push di
09B4  68 40 08        push 0x840
09B7  55              push bp
09B8  E8 1E FF        call 0x8d9
09BB  C4 3E CA D7     les di, ptr [0xd7ca]
09BF  06              push es
09C0  57              push di
09C1  68 A0 77        push 0x77a0
09C4  55              push bp
09C5  E8 11 FF        call 0x8d9
09C8  C4 3E CE D7     les di, ptr [0xd7ce]
09CC  06              push es
09CD  57              push di
09CE  68 E0 27        push 0x27e0
09D1  55              push bp
09D2  E8 04 FF        call 0x8d9
09D5  C4 3E D2 D7     les di, ptr [0xd7d2]
09D9  06              push es
09DA  57              push di
09DB  68 F7 00        push 0xf7
09DE  55              push bp
09DF  E8 F7 FE        call 0x8d9
09E2  BF D6 D7        mov di, 0xd7d6
09E5  1E              push ds
09E6  57              push di
09E7  68 B0 00        push 0xb0
09EA  55              push bp
09EB  E8 EB FE        call 0x8d9
09EE  BF A6 DC        mov di, 0xdca6
09F1  1E              push ds
09F2  57              push di
09F3  6A 08           push 8
09F5  55              push bp
09F6  E8 E0 FE        call 0x8d9
09F9  BF AE DC        mov di, 0xdcae
09FC  1E              push ds
09FD  57              push di
09FE  6A 08           push 8
0A00  55              push bp
0A01  E8 D5 FE        call 0x8d9
0A04  C4 3E B6 DC     les di, ptr [0xdcb6]
0A08  06              push es
0A09  57              push di
0A0A  6A 60           push 0x60
0A0C  55              push bp
0A0D  E8 C9 FE        call 0x8d9
0A10  BF BA DC        mov di, 0xdcba
0A13  1E              push ds
0A14  57              push di
0A15  6A 02           push 2
0A17  55              push bp
0A18  E8 BE FE        call 0x8d9
0A1B  C4 3E 84 DE     les di, ptr [0xde84]
0A1F  06              push es
0A20  57              push di
0A21  6A 02           push 2
0A23  55              push bp
0A24  E8 B2 FE        call 0x8d9
0A27  C4 3E BC DC     les di, ptr [0xdcbc]
0A2B  06              push es
0A2C  57              push di
0A2D  68 EA 06        push 0x6ea
0A30  55              push bp
0A31  E8 A5 FE        call 0x8d9
0A34  C4 3E C0 DC     les di, ptr [0xdcc0]
0A38  06              push es
0A39  57              push di
0A3A  68 A0 1F        push 0x1fa0
0A3D  55              push bp
0A3E  E8 98 FE        call 0x8d9
0A41  C4 3E C4 DC     les di, ptr [0xdcc4]
0A45  06              push es
0A46  57              push di
0A47  68 BC 00        push 0xbc
0A4A  55              push bp
0A4B  E8 8B FE        call 0x8d9
0A4E  C4 3E C8 DC     les di, ptr [0xdcc8]
0A52  06              push es
0A53  57              push di
0A54  68 A4 0F        push 0xfa4
0A57  55              push bp
0A58  E8 7E FE        call 0x8d9
0A5B  C4 3E D4 DC     les di, ptr [0xdcd4]
0A5F  06              push es
0A60  57              push di
0A61  68 E9 03        push 0x3e9
0A64  55              push bp
0A65  E8 71 FE        call 0x8d9
0A68  C4 3E CC DC     les di, ptr [0xdccc]
0A6C  06              push es
0A6D  57              push di
0A6E  68 03 2B        push 0x2b03
0A71  55              push bp
0A72  E8 64 FE        call 0x8d9
0A75  C4 3E D0 DC     les di, ptr [0xdcd0]
0A79  06              push es
0A7A  57              push di
0A7B  68 E9 03        push 0x3e9
0A7E  55              push bp
0A7F  E8 57 FE        call 0x8d9
0A82  C4 3E AA D7     les di, ptr [0xd7aa]
0A86  06              push es
0A87  57              push di
0A88  68 51 0F        push 0xf51
0A8B  55              push bp
0A8C  E8 4A FE        call 0x8d9
0A8F  BF 36 D9        mov di, 0xd936
0A92  1E              push ds
0A93  57              push di
0A94  68 B0 00        push 0xb0
0A97  55              push bp
0A98  E8 3E FE        call 0x8d9
0A9B  BF E6 D9        mov di, 0xd9e6
0A9E  1E              push ds
0A9F  57              push di
0AA0  68 B0 00        push 0xb0
0AA3  55              push bp
0AA4  E8 32 FE        call 0x8d9
0AA7  C4 3E DC DC     les di, ptr [0xdcdc]
0AAB  06              push es
0AAC  57              push di
0AAD  68 D0 01        push 0x1d0
0AB0  55              push bp
0AB1  E8 25 FE        call 0x8d9
0AB4  BF E0 DC        mov di, 0xdce0
0AB7  1E              push ds
0AB8  57              push di
0AB9  6A 01           push 1
0ABB  55              push bp
0ABC  E8 1A FE        call 0x8d9
0ABF  C4 3E E2 DC     les di, ptr [0xdce2]
0AC3  06              push es
0AC4  57              push di
0AC5  68 74 46        push 0x4674
0AC8  55              push bp
0AC9  E8 0D FE        call 0x8d9
0ACC  9A 54 10 AC 24  call far 24AC:1054
0AD1  8A 46 FE        mov al, byte ptr [bp - 2]
0AD4  88 46 FF        mov byte ptr [bp - 1], al
loc_0AD7:
0AD7  8A 46 FF        mov al, byte ptr [bp - 1]
0ADA  C9              leave
0ADB  C2 02 00        ret 2
; data (not reached as code), 7 bytes
0ADE                  db 01 2E   ; ..
0AE0                  pstr '.1-0'

