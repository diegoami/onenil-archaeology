; 1-095.EXE (One-Nil 95), code segment 26B9 (image offsets 26B90..2853F), part 1 of 3
; packed 1-095.EXE sha256 f659fb2d334500d6901fc8d6a0f06c85c0ccda2eb4a3035ae3bb0a0004d79192 (LZEXE 0.91)
; unpacked (tools/static/unlzexe.py) sha256 8df646e017e0965a5d90a58181ca764219ad847833aad0b6cb58fc53372bfb2c
; tool: capstone 5.0.9 (pip package; core library 5.0.1280) (CS_ARCH_X86, CS_MODE_16), recursive descent from the entry point, far calls and near calls/jumps, then routine prologues (55 89 E5 / 55 8B EC / C8 iw 00) in what remains; tools/static/listing.py
; addresses are SEGMENT:OFFSET with SEGMENT the image paragraph before relocation; image offset = SEGMENT*16+OFFSET

; ---- routine 26B9:0000  (found by: far)
sub_0000:
0000  BA 54 28        mov dx, 0x2854   ; relocated segment word 2854
0003  8E DA           mov ds, dx
0005  8C 06 16 A5     mov word ptr [0xa516], es
0009  33 ED           xor bp, bp
000B  E8 8B 19        call 0x1999
000E  E8 A0 00        call 0xb1
0011  8B C4           mov ax, sp
0013  05 13 00        add ax, 0x13
0016  B1 04           mov cl, 4
0018  D3 E8           shr ax, cl
001A  8C D2           mov dx, ss
001C  03 C2           add ax, dx
001E  A3 E8 A4        mov word ptr [0xa4e8], ax
0021  A3 EA A4        mov word ptr [0xa4ea], ax
0024  03 06 E2 A4     add ax, word ptr [0xa4e2]
0028  A3 EC A4        mov word ptr [0xa4ec], ax
002B  A3 F6 A4        mov word ptr [0xa4f6], ax
002E  A3 FA A4        mov word ptr [0xa4fa], ax
0031  A3 02 A5        mov word ptr [0xa502], ax
0034  8E 06 16 A5     mov es, word ptr [0xa516]
0038  26 A1 02 00     mov ax, word ptr es:[2]
003C  A3 FE A4        mov word ptr [0xa4fe], ax
003F  C7 06 08 A5 D6 00 mov word ptr [0xa508], 0xd6
0045  8C 0E 0A A5     mov word ptr [0xa50a], cs
0049  BF 26 FB        mov di, 0xfb26
004C  BE 39 02        mov si, 0x239
004F  B9 13 00        mov cx, 0x13
0052  90              nop
0053  FC              cld
0054  2E AC           lodsb al, byte ptr cs:[si]
0056  B4 35           mov ah, 0x35
0058  CD 21           int 0x21   ; INT 21h AH=35 get interrupt vector
005A  89 1D           mov word ptr [di], bx
005C  8C 45 02        mov word ptr [di + 2], es
005F  83 C7 04        add di, 4
0062  E2 EF           loop 0x53
0064  1E              push ds
0065  0E              push cs
0066  1F              pop ds
0067  BA 0C 01        mov dx, 0x10c
006A  B8 00 25        mov ax, 0x2500
006D  CD 21           int 0x21   ; INT 21h AH=25 set interrupt vector
006F  BA 13 01        mov dx, 0x113
0072  B8 23 25        mov ax, 0x2523
0075  CD 21           int 0x21   ; INT 21h AH=25 set interrupt vector
0077  BA DB 00        mov dx, 0xdb
007A  B8 24 25        mov ax, 0x2524
007D  CD 21           int 0x21   ; INT 21h AH=25 set interrupt vector
007F  BA 04 01        mov dx, 0x104
0082  B8 3F 25        mov ax, 0x253f
0085  CD 21           int 0x21   ; INT 21h AH=25 set interrupt vector
0087  1F              pop ds
0088  B8 26 F9        mov ax, 0xf926
008B  1E              push ds
008C  50              push ax
008D  1E              push ds
008E  50              push ax
008F  B8 63 02        mov ax, 0x263
0092  0E              push cs
0093  50              push ax
0094  0E              push cs
0095  E8 56 04        call 0x4ee
0098  0E              push cs
0099  E8 D0 04        call 0x56c
009C  B8 26 FA        mov ax, 0xfa26
009F  1E              push ds
00A0  50              push ax
00A1  1E              push ds
00A2  50              push ax
00A3  B8 63 02        mov ax, 0x263
00A6  0E              push cs
00A7  50              push ax
00A8  0E              push cs
00A9  E8 42 04        call 0x4ee
00AC  0E              push cs
00AD  E8 C1 04        call 0x571
00B0  CB              retf

; ---- routine 26B9:00B1  (found by: call)
sub_00B1:
00B1  33 C0           xor ax, ax
00B3  9C              pushf
00B4  5B              pop bx
00B5  80 E7 0F        and bh, 0xf
00B8  53              push bx
00B9  9D              popf
00BA  9C              pushf
00BB  59              pop cx
00BC  80 E5 F0        and ch, 0xf0
00BF  80 FD F0        cmp ch, 0xf0
00C2  74 0E           je 0xd2
00C4  40              inc ax
00C5  80 CF F0        or bh, 0xf0
00C8  53              push bx
00C9  9D              popf
00CA  9C              pushf
00CB  59              pop cx
00CC  80 E5 F0        and ch, 0xf0
00CF  74 01           je 0xd2
00D1  40              inc ax
loc_00D2:
00D2  A2 2A A5        mov byte ptr [0xa52a], al
00D5  C3              ret
; data (not reached as code), 57 bytes
00D6                  db 33 C0 CA 02 00 FB 83 C4 06 58 83 E7 1F 81 C7 96   ; 3........X......
00E6                  db 00 80 FC 39 73 03 BF FF FF 57 B4 54 CD 21 8B EC   ; ...9s....W.T.!..
00F6                  db 80 4E 16 01 58 5B 59 5A 5E 5F 5D 1F 07 CF B8 D0   ; .N..X[YZ^_].....
0106                  db 00 83 C4 06 EB 03 B8 C8 00   ; .........
loc_010F:
010F  59              pop cx
0110  5B              pop bx
0111  EB 07           jmp 0x11a
; data (not reached as code), 3 bytes
0113                  db B8 FF 00   ; ...

; ---- routine 26B9:0116  (found by: far)
sub_0116:
0116  33 C9           xor cx, cx
0118  33 DB           xor bx, bx
loc_011A:
011A  BA 54 28        mov dx, 0x2854   ; relocated segment word 2854
011D  8E DA           mov ds, dx
011F  FB              sti
0120  A3 10 A5        mov word ptr [0xa510], ax
0123  8B C1           mov ax, cx
0125  0B C3           or ax, bx
0127  74 3D           je 0x166
0129  A1 EE A4        mov ax, word ptr [0xa4ee]
loc_012C:
012C  0B C0           or ax, ax
012E  74 2F           je 0x15f
0130  8E C0           mov es, ax
0132  26 A1 10 00     mov ax, word ptr es:[0x10]
0136  0B C0           or ax, ax
0138  74 1B           je 0x155
013A  2B C3           sub ax, bx
013C  77 17           ja 0x155
013E  F7 D8           neg ax
0140  3D 00 10        cmp ax, 0x1000
0143  73 10           jae 0x155
0145  BA 10 00        mov dx, 0x10
0148  F7 E2           mul dx
014A  03 C1           add ax, cx
014C  72 07           jb 0x155
014E  26 3B 06 08 00  cmp ax, word ptr es:[8]
0153  72 06           jb 0x15b
loc_0155:
0155  26 A1 14 00     mov ax, word ptr es:[0x14]
0159  EB D1           jmp 0x12c
loc_015B:
015B  8B C8           mov cx, ax
015D  8C C3           mov bx, es
loc_015F:
015F  2B 1E 16 A5     sub bx, word ptr [0xa516]
0163  83 EB 10        sub bx, 0x10
loc_0166:
0166  89 0E 12 A5     mov word ptr [0xa512], cx
016A  89 1E 14 A5     mov word ptr [0xa514], bx
016E  C4 1E 0C A5     les bx, ptr [0xa50c]
0172  8C C0           mov ax, es
0174  0B C3           or ax, bx
0176  74 13           je 0x18b
0178  33 C0           xor ax, ax
017A  A3 0C A5        mov word ptr [0xa50c], ax
017D  A3 0E A5        mov word ptr [0xa50e], ax
0180  A3 1A A5        mov word ptr [0xa51a], ax
0183  B8 6E 01        mov ax, 0x16e
0186  0E              push cs
0187  50              push ax
0188  06              push es
0189  53              push bx
018A  CB              retf
loc_018B:
018B  B8 26 F9        mov ax, 0xf926
018E  1E              push ds
018F  50              push ax
0190  0E              push cs
0191  E8 32 04        call 0x5c6
0194  B8 26 FA        mov ax, 0xfa26
0197  1E              push ds
0198  50              push ax
0199  0E              push cs
019A  E8 29 04        call 0x5c6
019D  BF 26 FB        mov di, 0xfb26
01A0  BE 39 02        mov si, 0x239
01A3  B9 13 00        mov cx, 0x13
01A6  90              nop
01A7  FC              cld
01A8  2E AC           lodsb al, byte ptr cs:[si]
01AA  B4 25           mov ah, 0x25
01AC  1E              push ds
01AD  C5 15           lds dx, ptr [di]
01AF  CD 21           int 0x21   ; INT 21h AH=25 set interrupt vector
01B1  1F              pop ds
01B2  83 C7 04        add di, 4
01B5  E2 F0           loop 0x1a7
01B7  A1 12 A5        mov ax, word ptr [0xa512]
01BA  0B 06 14 A5     or ax, word ptr [0xa514]
01BE  74 29           je 0x1e9
01C0  BB 4C 02        mov bx, 0x24c
01C3  E8 2A 00        call 0x1f0
01C6  A1 10 A5        mov ax, word ptr [0xa510]
01C9  E8 32 00        call 0x1fe
01CC  BB 5B 02        mov bx, 0x25b
01CF  E8 1E 00        call 0x1f0
01D2  A1 14 A5        mov ax, word ptr [0xa514]
01D5  E8 40 00        call 0x218
01D8  B0 3A           mov al, 0x3a
01DA  E8 55 00        call 0x232
01DD  A1 12 A5        mov ax, word ptr [0xa512]
01E0  E8 35 00        call 0x218
01E3  BB 60 02        mov bx, 0x260
01E6  E8 07 00        call 0x1f0
loc_01E9:
01E9  A1 10 A5        mov ax, word ptr [0xa510]
01EC  B4 4C           mov ah, 0x4c
01EE  CD 21           int 0x21   ; INT 21h AH=4C terminate

; ---- routine 26B9:01F0  (found by: call, jump)
sub_01F0:
01F0  2E 8A 07        mov al, byte ptr cs:[bx]
01F3  0A C0           or al, al
01F5  74 06           je 0x1fd
01F7  E8 38 00        call 0x232
01FA  43              inc bx
01FB  EB F3           jmp 0x1f0
loc_01FD:
01FD  C3              ret

; ---- routine 26B9:01FE  (found by: call)
sub_01FE:
01FE  B1 64           mov cl, 0x64
0200  E8 07 00        call 0x20a
0203  B1 0A           mov cl, 0xa
0205  E8 02 00        call 0x20a
0208  EB 04           jmp 0x20e

; ---- routine 26B9:020A  (found by: call)
sub_020A:
020A  32 E4           xor ah, ah
020C  F6 F1           div cl
loc_020E:
020E  04 30           add al, 0x30
0210  50              push ax
0211  E8 1E 00        call 0x232
0214  58              pop ax
0215  8A C4           mov al, ah
0217  C3              ret

; ---- routine 26B9:0218  (found by: call)
sub_0218:
0218  50              push ax
0219  8A C4           mov al, ah
021B  E8 01 00        call 0x21f
021E  58              pop ax

; ---- routine 26B9:021F  (found by: call)
sub_021F:
021F  50              push ax
0220  B1 04           mov cl, 4
0222  D2 E8           shr al, cl
0224  E8 03 00        call 0x22a
0227  58              pop ax
0228  24 0F           and al, 0xf

; ---- routine 26B9:022A  (found by: call)
sub_022A:
022A  04 30           add al, 0x30
022C  3C 3A           cmp al, 0x3a
022E  72 02           jb 0x232
0230  04 07           add al, 7

; ---- routine 26B9:0232  (found by: call, jump)
sub_0232:
0232  8A D0           mov dl, al
0234  B4 06           mov ah, 6
0236  CD 21           int 0x21   ; INT 21h AH=06 ?
0238  C3              ret
; data (not reached as code), 81 bytes
0239                  db 00 02   ; ..
023B                  pstr '!#$456789:;<=>?uRuntime err'
0257                  db 6F 72 20 00 20 61 74 20 00 2E 0D 0A 00 50 6F 72   ; or . at .....Por
0267                  db 74 69 6F 6E 73 20 43 6F 70 79 72 69 67 68 74 20   ; tions Copyright 
0277                  db 28 63 29 20 31 39 38 33 2C 39 32 20 42 6F 72 6C   ; (c) 1983,92 Borl
0287                  db 61 6E 64   ; and

; ---- routine 26B9:028A  (found by: far)
sub_028A:
028A  55              push bp
028B  8B EC           mov bp, sp
028D  8B 46 06        mov ax, word ptr [bp + 6]
0290  E8 C0 00        call 0x353
0293  5D              pop bp
0294  72 03           jb 0x299
0296  CA 02 00        retf 2
loc_0299:
0299  B8 CB 00        mov ax, 0xcb
029C  E9 70 FE        jmp 0x10f

; ---- routine 26B9:029F  (found by: prologue)
sub_029F:
029F  55              push bp
02A0  8B EC           mov bp, sp
02A2  8B 46 06        mov ax, word ptr [bp + 6]
02A5  C4 4E 08        les cx, ptr [bp + 8]
02A8  8C C3           mov bx, es
02AA  E8 71 01        call 0x41e
02AD  5D              pop bp
02AE  72 03           jb 0x2b3
02B0  CA 06 00        retf 6
loc_02B3:
02B3  B8 CC 00        mov ax, 0xcc
02B6  E9 56 FE        jmp 0x10f
; data (not reached as code), 74 bytes
02B9                  db 8B DC 36 C4 7F 04 FC A1 F8 A4 AB A1 FA A4 AB CA   ; ..6.............
02C9                  db 04 00 8B DC 36 C4 7F 04 26 C4 3D 89 3E F8 A4 8C   ; ....6...&.=.>...
02D9                  db 06 FA A4 89 3E 00 A5 8C 06 02 A5 CA 04 00 BB FC   ; ....>...........
02E9                  db 02 EB 37 81 C2 00 10 EB 05 03 44 04 72 F5 03 54   ; ..7.......D.r..T
02F9                  db 06 C5 34 8C DB 3B DF 75 F0 C3   ; ..4..;.u..

; ---- routine 26B9:0303  (found by: far)
sub_0303:
0303  BB 1C 03        mov bx, 0x31c
0306  EB 1B           jmp 0x323
; data (not reached as code), 27 bytes
0308                  db 3B 54 06 77 0D 72 05 3B 44 04 73 06 8B 44 04 8B   ; ;T.w.r.;D.s..D..
0318                  db 54 06 C5 34 8C DB 3B DF 75 E6 C3   ; T..4..;.u..
loc_0323:
0323  A1 FC A4        mov ax, word ptr [0xa4fc]
0326  8B 16 FE A4     mov dx, word ptr [0xa4fe]
032A  2B 06 F8 A4     sub ax, word ptr [0xa4f8]
032E  1B 16 FA A4     sbb dx, word ptr [0xa4fa]
0332  25 0F 00        and ax, 0xf
0335  1E              push ds
0336  8B 3E FA A4     mov di, word ptr [0xa4fa]
033A  C5 36 00 A5     lds si, ptr [0xa500]
033E  FF D3           call bx
0340  1F              pop ds
0341  B1 04           mov cl, 4
0343  D3 C2           rol dx, cl
0345  8B CA           mov cx, dx
0347  80 E1 F0        and cl, 0xf0
034A  83 E2 0F        and dx, 0xf
034D  03 C1           add ax, cx
034F  83 D2 00        adc dx, 0
0352  CB              retf

; ---- routine 26B9:0353  (found by: call)
sub_0353:
0353  0B C0           or ax, ax
0355  74 77           je 0x3ce
0357  A3 72 FB        mov word ptr [0xfb72], ax
loc_035A:
035A  E8 7F 01        call 0x4dc
035D  BF 00 A5        mov di, 0xa500
0360  8C D9           mov cx, ds
0362  8E C1           mov es, cx
loc_0364:
0364  8B CF           mov cx, di
0366  8C C3           mov bx, es
0368  26 C4 3D        les di, ptr es:[di]
036B  8C C6           mov si, es
036D  3B 36 FA A4     cmp si, word ptr [0xa4fa]
0371  74 5F           je 0x3d2
0373  26 3B 55 06     cmp dx, word ptr es:[di + 6]
0377  77 EB           ja 0x364
0379  72 06           jb 0x381
037B  26 3B 45 04     cmp ax, word ptr es:[di + 4]
037F  77 E3           ja 0x364
loc_0381:
0381  06              push es
0382  57              push di
0383  53              push bx
0384  51              push cx
0385  26 8B 0D        mov cx, word ptr es:[di]
0388  26 8B 5D 02     mov bx, word ptr es:[di + 2]
038C  74 33           je 0x3c1
038E  53              push bx
038F  51              push cx
0390  26 8B 4D 04     mov cx, word ptr es:[di + 4]
0394  26 8B 5D 06     mov bx, word ptr es:[di + 6]
0398  2B C8           sub cx, ax
039A  1B DA           sbb bx, dx
039C  83 E1 0F        and cx, 0xf
039F  03 C7           add ax, di
03A1  03 D6           add dx, si
03A3  04 F0           add al, 0xf0
03A5  83 D2 00        adc dx, 0
03A8  24 0F           and al, 0xf
03AA  8B F8           mov di, ax
03AC  8E C2           mov es, dx
03AE  26 8F 05        pop word ptr es:[di]
03B1  26 8F 45 02     pop word ptr es:[di + 2]
03B5  26 89 4D 04     mov word ptr es:[di + 4], cx
03B9  26 89 5D 06     mov word ptr es:[di + 6], bx
03BD  8B CF           mov cx, di
03BF  8C C3           mov bx, es
loc_03C1:
03C1  5F              pop di
03C2  07              pop es
03C3  26 89 0D        mov word ptr es:[di], cx
03C6  26 89 5D 02     mov word ptr es:[di + 2], bx
03CA  58              pop ax
03CB  5A              pop dx
03CC  F8              clc
loc_03CD:
03CD  C3              ret
loc_03CE:
03CE  33 C0           xor ax, ax
03D0  99              cdq
03D1  C3              ret
loc_03D2:
03D2  03 C7           add ax, di
03D4  03 D6           add dx, si
03D6  04 F0           add al, 0xf0
03D8  83 D2 00        adc dx, 0
03DB  24 0F           and al, 0xf
03DD  3B 16 FE A4     cmp dx, word ptr [0xa4fe]
03E1  72 08           jb 0x3eb
03E3  77 25           ja 0x40a
03E5  3B 06 FC A4     cmp ax, word ptr [0xa4fc]
03E9  77 1F           ja 0x40a
loc_03EB:
03EB  06              push es
03EC  57              push di
03ED  8B F9           mov di, cx
03EF  8E C3           mov es, bx
03F1  A3 F8 A4        mov word ptr [0xa4f8], ax
03F4  89 16 FA A4     mov word ptr [0xa4fa], dx
03F8  26 89 05        mov word ptr es:[di], ax
03FB  26 89 55 02     mov word ptr es:[di + 2], dx
03FF  33 C0           xor ax, ax
0401  50              push ax
0402  FF 1E 08 A5     lcall [0xa508]
0406  58              pop ax
0407  5A              pop dx
0408  F8              clc
0409  C3              ret
loc_040A:
040A  FF 36 72 FB     push word ptr [0xfb72]
040E  FF 1E 08 A5     lcall [0xa508]
0412  3C 01           cmp al, 1
0414  72 B7           jb 0x3cd
0416  74 B6           je 0x3ce
0418  A1 72 FB        mov ax, word ptr [0xfb72]
041B  E9 3C FF        jmp 0x35a

; ---- routine 26B9:041E  (found by: call)
sub_041E:
041E  0B C0           or ax, ax
0420  74 5A           je 0x47c
0422  F7 C1 F7 FF     test cx, 0xfff7
0426  75 53           jne 0x47b
0428  3B 1E F6 A4     cmp bx, word ptr [0xa4f6]
042C  77 08           ja 0x436
042E  72 4B           jb 0x47b
0430  3B 0E F4 A4     cmp cx, word ptr [0xa4f4]
0434  72 45           jb 0x47b
loc_0436:
0436  3B 1E FA A4     cmp bx, word ptr [0xa4fa]
043A  72 08           jb 0x444
043C  77 3D           ja 0x47b
043E  3B 0E F8 A4     cmp cx, word ptr [0xa4f8]
0442  73 37           jae 0x47b
loc_0444:
0444  E8 95 00        call 0x4dc
0447  8B F9           mov di, cx
0449  8E C3           mov es, bx
044B  26 89 45 04     mov word ptr es:[di + 4], ax
044F  26 89 55 06     mov word ptr es:[di + 6], dx
0453  BF 00 A5        mov di, 0xa500
0456  8C D8           mov ax, ds
0458  8E C0           mov es, ax
loc_045A:
045A  8B C7           mov ax, di
045C  8C C2           mov dx, es
045E  26 C4 3D        les di, ptr es:[di]
0461  8C C6           mov si, es
0463  3B DE           cmp bx, si
0465  77 F3           ja 0x45a
0467  72 06           jb 0x46f
0469  3B CF           cmp cx, di
046B  77 ED           ja 0x45a
046D  74 0C           je 0x47b
loc_046F:
046F  52              push dx
0470  50              push ax
0471  E8 09 00        call 0x47d
0474  59              pop cx
0475  5B              pop bx
0476  E8 04 00        call 0x47d
0479  F8              clc
047A  C3              ret
loc_047B:
047B  F9              stc
loc_047C:
047C  C3              ret

; ---- routine 26B9:047D  (found by: call)
sub_047D:
047D  8B C7           mov ax, di
047F  8C C2           mov dx, es
0481  8B F9           mov di, cx
0483  8E C3           mov es, bx
0485  26 03 4D 04     add cx, word ptr es:[di + 4]
0489  26 03 5D 06     add bx, word ptr es:[di + 6]
048D  80 C1 F0        add cl, 0xf0
0490  83 D3 00        adc bx, 0
0493  80 E1 0F        and cl, 0xf
0496  3B DA           cmp bx, dx
0498  75 3A           jne 0x4d4
049A  3B C8           cmp cx, ax
049C  75 36           jne 0x4d4
049E  3B 16 FA A4     cmp dx, word ptr [0xa4fa]
04A2  75 0F           jne 0x4b3
04A4  3B 06 F8 A4     cmp ax, word ptr [0xa4f8]
04A8  75 09           jne 0x4b3
04AA  89 3E F8 A4     mov word ptr [0xa4f8], di
04AE  8C 06 FA A4     mov word ptr [0xa4fa], es
04B2  C3              ret
loc_04B3:
04B3  1E              push ds
04B4  57              push di
04B5  8B F0           mov si, ax
04B7  8E DA           mov ds, dx
04B9  FC              cld
04BA  A5              movsw word ptr es:[di], word ptr [si]
04BB  A5              movsw word ptr es:[di], word ptr [si]
04BC  AD              lodsw ax, word ptr [si]
04BD  92              xchg dx, ax
04BE  AD              lodsw ax, word ptr [si]
04BF  92              xchg dx, ax
04C0  26 03 05        add ax, word ptr es:[di]
04C3  26 03 55 02     add dx, word ptr es:[di + 2]
04C7  04 F0           add al, 0xf0
04C9  83 D2 00        adc dx, 0
04CC  24 0F           and al, 0xf
04CE  AB              stosw word ptr es:[di], ax
04CF  92              xchg dx, ax
04D0  AB              stosw word ptr es:[di], ax
04D1  5F              pop di
04D2  1F              pop ds
04D3  C3              ret
loc_04D4:
04D4  26 89 05        mov word ptr es:[di], ax
04D7  26 89 55 02     mov word ptr es:[di + 2], dx
04DB  C3              ret

; ---- routine 26B9:04DC  (found by: call)
sub_04DC:
04DC  05 07 00        add ax, 7
04DF  8B D0           mov dx, ax
04E1  D1 DA           rcr dx, 1
04E3  D1 EA           shr dx, 1
04E5  D1 EA           shr dx, 1
04E7  D1 EA           shr dx, 1
04E9  25 08 00        and ax, 8
04EC  C3              ret
; data (not reached as code), 1 bytes
04ED                  db BA   ; .

; ---- routine 26B9:04EE  (found by: call)
sub_04EE:
04EE  33 D2           xor dx, dx
04F0  8B DC           mov bx, sp
04F2  1E              push ds
04F3  36 C4 7F 08     les di, ptr ss:[bx + 8]
04F7  36 C5 77 04     lds si, ptr ss:[bx + 4]
04FB  FC              cld
04FC  33 C0           xor ax, ax
04FE  AB              stosw word ptr es:[di], ax
04FF  B8 B0 D7        mov ax, 0xd7b0
0502  AB              stosw word ptr es:[di], ax
0503  B8 80 00        mov ax, 0x80
0506  AB              stosw word ptr es:[di], ax
0507  33 C0           xor ax, ax
0509  AB              stosw word ptr es:[di], ax
050A  AB              stosw word ptr es:[di], ax
050B  AB              stosw word ptr es:[di], ax
050C  8D 45 74        lea ax, [di + 0x74]
050F  AB              stosw word ptr es:[di], ax
0510  8C C0           mov ax, es
0512  AB              stosw word ptr es:[di], ax
0513  B8 CA 0E        mov ax, 0xeca
0516  AB              stosw word ptr es:[di], ax
0517  B8 B9 26        mov ax, 0x26b9   ; relocated segment word 26B9
051A  AB              stosw word ptr es:[di], ax
051B  33 C0           xor ax, ax
051D  B9 0E 00        mov cx, 0xe
0520  F3 AB           rep stosw word ptr es:[di], ax
0522  B9 4F 00        mov cx, 0x4f
0525  0B D2           or dx, dx
0527  75 09           jne 0x532
0529  AC              lodsb al, byte ptr [si]
052A  3A C8           cmp cl, al
052C  76 04           jbe 0x532
052E  8A C8           mov cl, al
0530  E3 08           jcxz 0x53a
loc_0532:
0532  AC              lodsb al, byte ptr [si]
0533  0A C0           or al, al
0535  74 03           je 0x53a
0537  AA              stosb byte ptr es:[di], al
0538  E2 F8           loop 0x532
loc_053A:
053A  32 C0           xor al, al
053C  AA              stosb byte ptr es:[di], al
053D  1F              pop ds
053E  CA 08 00        retf 8
; data (not reached as code), 43 bytes
0541                  db 8B DC 36 C4 7F 0A 36 8B 47 04 26 89 45 04 36 8B   ; ..6...6.G.&.E.6.
0551                  db 47 06 26 89 45 0C 36 8B 47 08 26 89 45 0E 33 C0   ; G.&.E.6.G.&.E.3.
0561                  db 26 89 45 08 26 89 45 0A CA 0A 00   ; &.E.&.E....

; ---- routine 26B9:056C  (found by: call, far)
sub_056C:
056C  BA B1 D7        mov dx, 0xd7b1
056F  EB 08           jmp 0x579

; ---- routine 26B9:0571  (found by: call, far)
sub_0571:
0571  BA B2 D7        mov dx, 0xd7b2
0574  EB 03           jmp 0x579
; data (not reached as code), 3 bytes
0576                  db BA B3 D7   ; ...
loc_0579:
0579  55              push bp
057A  8B EC           mov bp, sp
057C  C4 7E 06        les di, ptr [bp + 6]
057F  26 8B 45 02     mov ax, word ptr es:[di + 2]
0583  3D B1 D7        cmp ax, 0xd7b1
0586  74 12           je 0x59a
0588  3D B2 D7        cmp ax, 0xd7b2
058B  74 0D           je 0x59a
058D  3D B0 D7        cmp ax, 0xd7b0
0590  74 10           je 0x5a2
0592  C7 06 1A A5 66 00 mov word ptr [0xa51a], 0x66
0598  EB 24           jmp 0x5be
loc_059A:
059A  52              push dx
059B  06              push es
059C  57              push di
059D  0E              push cs
059E  E8 25 00        call 0x5c6
05A1  5A              pop dx
loc_05A2:
05A2  33 C0           xor ax, ax
05A4  26 89 55 02     mov word ptr es:[di + 2], dx
05A8  26 89 45 08     mov word ptr es:[di + 8], ax
05AC  26 89 45 0A     mov word ptr es:[di + 0xa], ax
05B0  BB 10 00        mov bx, 0x10
05B3  E8 4C 00        call 0x602
05B6  74 06           je 0x5be
05B8  26 C7 45 02 B0 D7 mov word ptr es:[di + 2], 0xd7b0
loc_05BE:
05BE  5D              pop bp
05BF  CA 04 00        retf 4
; data (not reached as code), 4 bytes
05C2                  db B0 00 EB 02   ; ....

; ---- routine 26B9:05C6  (found by: call)
sub_05C6:
05C6  B0 01           mov al, 1
05C8  55              push bp
05C9  8B EC           mov bp, sp
05CB  C4 7E 06        les di, ptr [bp + 6]
05CE  26 81 7D 02 B1 D7 cmp word ptr es:[di + 2], 0xd7b1
05D4  74 18           je 0x5ee
05D6  26 81 7D 02 B2 D7 cmp word ptr es:[di + 2], 0xd7b2
05DC  74 08           je 0x5e6
05DE  C7 06 1A A5 67 00 mov word ptr [0xa51a], 0x67
05E4  EB 18           jmp 0x5fe
loc_05E6:
05E6  50              push ax
05E7  BB 14 00        mov bx, 0x14
05EA  E8 15 00        call 0x602
05ED  58              pop ax
loc_05EE:
05EE  0A C0           or al, al
05F0  74 0C           je 0x5fe
05F2  BB 1C 00        mov bx, 0x1c
05F5  E8 0A 00        call 0x602
05F8  26 C7 45 02 B0 D7 mov word ptr es:[di + 2], 0xd7b0
loc_05FE:
05FE  5D              pop bp
05FF  CA 04 00        retf 4

; ---- routine 26B9:0602  (found by: call)
sub_0602:
0602  06              push es
0603  57              push di
0604  06              push es
0605  57              push di
0606  26 FF 19        lcall es:[bx + di]
0609  0B C0           or ax, ax
060B  74 03           je 0x610
060D  A3 1A A5        mov word ptr [0xa51a], ax
loc_0610:
0610  5F              pop di
0611  07              pop es
0612  C3              ret
; data (not reached as code), 142 bytes
0613                  db 8B DC 1E 36 C4 7F 04 26 C5 55 0C 26 8B 4D 04 26   ; ...6...&.U.&.M.&
0623                  db 8B 1D B4 3F CD 21 72 10 26 89 45 0A 33 C0 26 C7   ; ...?.!r.&.E.3.&.
0633                  db 45 08 00 00 1F CA 04 00 26 C7 45 0A 00 00 EB EE   ; E.......&.E.....
0643                  db 8B DC 1E 36 C4 7F 04 26 C5 55 0C 33 C9 26 87 4D   ; ...6...&.U.3.&.M
0653                  db 08 26 8B 1D B4 40 CD 21 72 07 2B C1 74 03 B8 65   ; .&...@.!r.+.t..e
0663                  db 00 1F CA 04 00 8B DC 1E 36 C4 7F 04 26 C5 55 0C   ; ........6...&.U.
0673                  db 33 C9 26 87 4D 08 26 8B 1D B4 40 CD 21 72 02 33   ; 3.&.M.&...@.!r.3
0683                  db C0 1F CA 04 00 8B DC 36 C4 7F 04 26 8B 1D 83 FB   ; .......6...&....
0693                  db 04 76 06 B4 3E CD 21 72 02 33 C0 CA 04 00   ; .v..>.!r.3....

; ---- routine 26B9:06A1  (found by: call)
sub_06A1:
06A1  83 3E 1A A5 00  cmp word ptr [0xa51a], 0
06A6  75 35           jne 0x6dd
06A8  26 81 7F 02 B1 D7 cmp word ptr es:[bx + 2], 0xd7b1
06AE  75 2E           jne 0x6de
06B0  26 8B 77 08     mov si, word ptr es:[bx + 8]
06B4  26 3B 77 0A     cmp si, word ptr es:[bx + 0xa]
06B8  74 2B           je 0x6e5
loc_06BA:
06BA  1E              push ds
06BB  06              push es
06BC  53              push bx
06BD  52              push dx
06BE  26 C5 57 0C     lds dx, ptr es:[bx + 0xc]
06C2  26 8B 5F 0A     mov bx, word ptr es:[bx + 0xa]
06C6  07              pop es
06C7  03 DA           add bx, dx
06C9  03 F2           add si, dx
06CB  FC              cld
06CC  FF D0           call ax
06CE  2B F2           sub si, dx
06D0  8C C2           mov dx, es
06D2  5B              pop bx
06D3  07              pop es
06D4  1F              pop ds
06D5  26 89 77 08     mov word ptr es:[bx + 8], si
06D9  0B C0           or ax, ax
06DB  75 08           jne 0x6e5
loc_06DD:
06DD  C3              ret
loc_06DE:
06DE  C7 06 1A A5 68 00 mov word ptr [0xa51a], 0x68
06E4  C3              ret
loc_06E5:
06E5  50              push ax
06E6  51              push cx
06E7  52              push dx
06E8  57              push di
06E9  06              push es
06EA  53              push bx
06EB  E8 33 01        call 0x821
06EE  5B              pop bx
06EF  07              pop es
06F0  5F              pop di
06F1  5A              pop dx
06F2  59              pop cx
06F3  58              pop ax
06F4  26 8B 77 08     mov si, word ptr es:[bx + 8]
06F8  26 3B 77 0A     cmp si, word ptr es:[bx + 0xa]
06FC  75 BC           jne 0x6ba
06FE  C3              ret

; ---- routine 26B9:06FF  (found by: call)
sub_06FF:
06FF  83 3E 1A A5 00  cmp word ptr [0xa51a], 0
0704  75 40           jne 0x746
0706  26 81 7F 02 B2 D7 cmp word ptr es:[bx + 2], 0xd7b2
070C  75 39           jne 0x747
loc_070E:
070E  26 8B 4F 04     mov cx, word ptr es:[bx + 4]
0712  26 8B 7F 08     mov di, word ptr es:[bx + 8]
0716  2B CF           sub cx, di
0718  2B D1           sub dx, cx
071A  73 04           jae 0x720
071C  03 CA           add cx, dx
071E  33 D2           xor dx, dx
loc_0720:
0720  06              push es
0721  26 C4 77 0C     les si, ptr es:[bx + 0xc]
0725  03 FE           add di, si
0727  B0 20           mov al, 0x20
0729  FC              cld
072A  F3 AA           rep stosb byte ptr es:[di], al
072C  2B FE           sub di, si
072E  07              pop es
072F  26 89 7F 08     mov word ptr es:[bx + 8], di
0733  26 3B 7F 04     cmp di, word ptr es:[bx + 4]
0737  75 09           jne 0x742
0739  52              push dx
073A  06              push es
073B  53              push bx
073C  E8 E2 00        call 0x821
073F  5B              pop bx
0740  07              pop es
0741  5A              pop dx
loc_0742:
0742  0B D2           or dx, dx
0744  75 C8           jne 0x70e
loc_0746:
0746  C3              ret
loc_0747:
0747  C7 06 1A A5 69 00 mov word ptr [0xa51a], 0x69
074D  C3              ret

; ---- routine 26B9:074E  (found by: call)
sub_074E:
074E  83 3E 1A A5 00  cmp word ptr [0xa51a], 0
0753  75 48           jne 0x79d
0755  26 81 7F 02 B2 D7 cmp word ptr es:[bx + 2], 0xd7b2
075B  75 41           jne 0x79e
loc_075D:
075D  26 8B 4F 04     mov cx, word ptr es:[bx + 4]
0761  26 8B 7F 08     mov di, word ptr es:[bx + 8]
0765  2B CF           sub cx, di
0767  2B C1           sub ax, cx
0769  73 04           jae 0x76f
076B  03 C8           add cx, ax
076D  33 C0           xor ax, ax
loc_076F:
076F  1E              push ds
0770  06              push es
0771  53              push bx
0772  8E DA           mov ds, dx
0774  26 C4 5F 0C     les bx, ptr es:[bx + 0xc]
0778  03 FB           add di, bx
077A  FC              cld
077B  F3 A4           rep movsb byte ptr es:[di], byte ptr [si]
077D  2B FB           sub di, bx
077F  5B              pop bx
0780  07              pop es
0781  1F              pop ds
0782  26 89 7F 08     mov word ptr es:[bx + 8], di
0786  26 3B 7F 04     cmp di, word ptr es:[bx + 4]
078A  75 0D           jne 0x799
078C  50              push ax
078D  52              push dx
078E  56              push si
078F  06              push es
0790  53              push bx
0791  E8 8D 00        call 0x821
0794  5B              pop bx
0795  07              pop es
0796  5E              pop si
0797  5A              pop dx
0798  58              pop ax
loc_0799:
0799  0B C0           or ax, ax
079B  75 C0           jne 0x75d
loc_079D:
079D  C3              ret
loc_079E:
079E  C7 06 1A A5 69 00 mov word ptr [0xa51a], 0x69
07A4  C3              ret

; ---- routine 26B9:07A5  (found by: prologue)
sub_07A5:
07A5  55              push bp
07A6  8B EC           mov bp, sp
07A8  C4 5E 06        les bx, ptr [bp + 6]
07AB  B8 C3 07        mov ax, 0x7c3
07AE  33 D2           xor dx, dx
07B0  E8 EE FE        call 0x6a1
07B3  75 0A           jne 0x7bf
07B5  26 83 7F 1A 00  cmp word ptr es:[bx + 0x1a], 0
07BA  74 03           je 0x7bf
07BC  E8 70 00        call 0x82f
loc_07BF:
07BF  5D              pop bp
07C0  CA 04 00        retf 4
; data (not reached as code), 34 bytes
07C3                  db AC 3C 0D 74 0C 3C 1A 74 11 3B F3 75 F3 B8 C3 07   ; .<.t.<.t.;.u....
07D3                  db C3 3B F3 74 09 AC 3C 0A 74 01 4E 33 C0 C3 B8 D8   ; .;.t..<.t.N3....
07E3                  db 07 C3   ; ..

; ---- routine 26B9:07E5  (found by: far)
sub_07E5:
07E5  55              push bp
07E6  8B EC           mov bp, sp
07E8  C4 5E 06        les bx, ptr [bp + 6]
07EB  B8 02 00        mov ax, 2
07EE  BE 2E A5        mov si, 0xa52e
07F1  8C DA           mov dx, ds
07F3  E8 58 FF        call 0x74e
07F6  75 0A           jne 0x802
07F8  26 83 7F 1A 00  cmp word ptr es:[bx + 0x1a], 0
07FD  74 03           je 0x802
07FF  E8 2D 00        call 0x82f
loc_0802:
0802  5D              pop bp
0803  CA 04 00        retf 4

; ---- routine 26B9:0806  (found by: prologue)
sub_0806:
0806  55              push bp
0807  8B EC           mov bp, sp
0809  C4 5E 06        les bx, ptr [bp + 6]
080C  26 83 7F 1A 00  cmp word ptr es:[bx + 0x1a], 0
0811  74 0A           je 0x81d
0813  83 3E 1A A5 00  cmp word ptr [0xa51a], 0
0818  75 03           jne 0x81d
081A  E8 12 00        call 0x82f
loc_081D:
081D  5D              pop bp
081E  CA 04 00        retf 4

; ---- routine 26B9:0821  (found by: call)
sub_0821:
0821  06              push es
0822  53              push bx
0823  26 FF 5F 14     lcall es:[bx + 0x14]
0827  0B C0           or ax, ax
0829  74 03           je 0x82e
082B  A3 1A A5        mov word ptr [0xa51a], ax
loc_082E:
082E  C3              ret

; ---- routine 26B9:082F  (found by: call)
sub_082F:
082F  06              push es
0830  53              push bx
0831  26 FF 5F 18     lcall es:[bx + 0x18]
0835  0B C0           or ax, ax
0837  74 03           je 0x83c
0839  A3 1A A5        mov word ptr [0xa51a], ax
loc_083C:
083C  C3              ret

; ---- routine 26B9:083D  (found by: prologue)
sub_083D:
083D  55              push bp
083E  8B EC           mov bp, sp
0840  C4 5E 0C        les bx, ptr [bp + 0xc]
0843  B8 60 08        mov ax, 0x860
0846  8B 4E 06        mov cx, word ptr [bp + 6]
0849  8B 7E 08        mov di, word ptr [bp + 8]
084C  8B 56 0A        mov dx, word ptr [bp + 0xa]
084F  47              inc di
0850  E8 4E FE        call 0x6a1
0853  8B C7           mov ax, di
0855  C4 7E 08        les di, ptr [bp + 8]
0858  2B C7           sub ax, di
085A  48              dec ax
085B  AA              stosb byte ptr es:[di], al
085C  5D              pop bp
085D  CA 06 00        retf 6
; data (not reached as code), 24 bytes
0860                  db AC 3C 0D 74 0F 3C 1A 74 0B AA 3B F3 E0 F2 E3 05   ; .<.t.<.t..;.....
0870                  db B8 60 08 C3 4E 33 C0 C3   ; .`..N3..

; ---- routine 26B9:0878  (found by: far)
sub_0878:
0878  55              push bp
0879  8B EC           mov bp, sp
087B  C4 5E 08        les bx, ptr [bp + 8]
087E  26 8A 07        mov al, byte ptr es:[bx]
0881  32 E4           xor ah, ah
0883  C4 5E 0C        les bx, ptr [bp + 0xc]
0886  8B 56 06        mov dx, word ptr [bp + 6]
0889  2B D0           sub dx, ax
088B  7E 05           jle 0x892
088D  50              push ax
088E  E8 6E FE        call 0x6ff
0891  58              pop ax
loc_0892:
0892  0B C0           or ax, ax
0894  74 0A           je 0x8a0
0896  8B 76 08        mov si, word ptr [bp + 8]
0899  8B 56 0A        mov dx, word ptr [bp + 0xa]
089C  46              inc si
089D  E8 AE FE        call 0x74e
loc_08A0:
08A0  5D              pop bp
08A1  CA 06 00        retf 6

; ---- routine 26B9:08A4  (found by: far)
sub_08A4:
08A4  55              push bp
08A5  8B EC           mov bp, sp
08A7  8B 56 06        mov dx, word ptr [bp + 6]
08AA  0B D2           or dx, dx
08AC  74 05           je 0x8b3
08AE  E8 49 00        call 0x8fa
08B1  EB 30           jmp 0x8e3
loc_08B3:
08B3  B4 30           mov ah, 0x30
08B5  CD 21           int 0x21   ; INT 21h AH=30 get DOS version
08B7  3C 03           cmp al, 3
08B9  B8 00 00        mov ax, 0
08BC  72 25           jb 0x8e3
08BE  8E 06 16 A5     mov es, word ptr [0xa516]
08C2  26 8E 06 2C 00  mov es, word ptr es:[0x2c]
08C7  33 FF           xor di, di
08C9  FC              cld
loc_08CA:
08CA  26 3A 05        cmp al, byte ptr es:[di]
08CD  74 07           je 0x8d6
08CF  B9 FF FF        mov cx, 0xffff
08D2  F2 AE           repne scasb al, byte ptr es:[di]
08D4  EB F4           jmp 0x8ca
loc_08D6:
08D6  83 C7 03        add di, 3
08D9  8B F7           mov si, di
08DB  B9 00 01        mov cx, 0x100
08DE  F2 AE           repne scasb al, byte ptr es:[di]
08E0  91              xchg cx, ax
08E1  F6 D0           not al
loc_08E3:
08E3  1E              push ds
08E4  06              push es
08E5  1F              pop ds
08E6  C4 7E 08        les di, ptr [bp + 8]
08E9  FC              cld
08EA  AA              stosb byte ptr es:[di], al
08EB  91              xchg cx, ax
08EC  F3 A4           rep movsb byte ptr es:[di], byte ptr [si]
08EE  1F              pop ds
08EF  5D              pop bp
08F0  CA 02 00        retf 2
; data (not reached as code), 7 bytes
08F3                  db 33 D2 E8 02 00 93 CB   ; 3......

; ---- routine 26B9:08FA  (found by: call)
sub_08FA:
08FA  8E 06 16 A5     mov es, word ptr [0xa516]
08FE  BF 80 00        mov di, 0x80
0901  26 8A 0D        mov cl, byte ptr es:[di]
0904  32 ED           xor ch, ch
0906  47              inc di
0907  33 DB           xor bx, bx
loc_0909:
0909  E3 09           jcxz 0x914
090B  26 80 3D 20     cmp byte ptr es:[di], 0x20
090F  77 03           ja 0x914
0911  47              inc di
0912  E2 F7           loop 0x90b
loc_0914:
0914  8B F7           mov si, di
0916  E3 09           jcxz 0x921
0918  26 80 3D 20     cmp byte ptr es:[di], 0x20
091C  76 03           jbe 0x921
091E  47              inc di
091F  E2 F7           loop 0x918
loc_0921:
0921  8B C7           mov ax, di
0923  2B C6           sub ax, si
0925  74 04           je 0x92b
0927  43              inc bx
0928  4A              dec dx
0929  75 DE           jne 0x909
loc_092B:
092B  C3              ret

; ---- routine 26B9:092C  (found by: far)
sub_092C:
092C  55              push bp
092D  8B EC           mov bp, sp
092F  81 EC 80 00     sub sp, 0x80
0933  1E              push ds
0934  8D 76 80        lea si, [bp - 0x80]
0937  16              push ss
0938  1F              pop ds
0939  8A 46 0C        mov al, byte ptr [bp + 0xc]
093C  0A C0           or al, al
093E  75 06           jne 0x946
0940  B4 19           mov ah, 0x19
0942  CD 21           int 0x21   ; INT 21h AH=19 get drive
0944  FE C0           inc al
loc_0946:
0946  8A D0           mov dl, al
0948  04 40           add al, 0x40
094A  88 04           mov byte ptr [si], al
094C  46              inc si
094D  C7 04 3A 5C     mov word ptr [si], 0x5c3a
0951  46              inc si
0952  46              inc si
0953  B4 47           mov ah, 0x47
0955  CD 21           int 0x21   ; INT 21h AH=47 get current directory
0957  73 03           jae 0x95c
0959  C6 04 00        mov byte ptr [si], 0
loc_095C:
095C  8D 76 80        lea si, [bp - 0x80]
095F  C4 7E 08        les di, ptr [bp + 8]
0962  8B 4E 06        mov cx, word ptr [bp + 6]
0965  33 DB           xor bx, bx
0967  FC              cld
0968  AC              lodsb al, byte ptr [si]
0969  0A C0           or al, al
096B  74 06           je 0x973
096D  43              inc bx
096E  26 88 01        mov byte ptr es:[bx + di], al
0971  E2 F5           loop 0x968
loc_0973:
0973  26 88 1D        mov byte ptr es:[di], bl
0976  1F              pop ds
0977  8B E5           mov sp, bp
0979  5D              pop bp
097A  CA 08 00        retf 8

