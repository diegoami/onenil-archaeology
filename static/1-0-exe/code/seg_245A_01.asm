; 1-0.EXE (One-Nil 96), code segment 245A (image offsets 245A0..24BBF), part 1 of 1
; packed 1-0.EXE sha256 89ff9c5f238f24e81a0c2440a46cdd8997280a65fc3cc3d97cb974f55280a80a (LZEXE 0.91)
; unpacked (tools/static/unlzexe.py) sha256 887ed2a92767950e5309b2052409f875668605939b69e00737aa3047022b9f51
; tool: capstone 5.0.9 (pip package; core library 5.0.1280) (CS_ARCH_X86, CS_MODE_16), recursive descent from the entry point, far calls and near calls/jumps, then routine prologues (55 89 E5 / 55 8B EC / C8 iw 00) in what remains; tools/static/listing.py
; addresses are SEGMENT:OFFSET with SEGMENT the image paragraph before relocation; image offset = SEGMENT*16+OFFSET

; ---- routine 245A:0000  (found by: jump, prologue)
sub_0000:
0000  55              push bp
0001  89 E5           mov bp, sp
0003  B8 FF 00        mov ax, 0xff
0006  9A 16 01 C9 26  call far 26C9:0116
000B  5D              pop bp
000C  C3              ret

; ---- routine 245A:000D  (found by: far)
sub_000D:
000D  55              push bp
000E  89 E5           mov bp, sp
0010  E8 28 00        call 0x3b
0013  BF 26 F9        mov di, 0xf926
0016  1E              push ds
0017  57              push di
0018  0E              push cs
0019  E8 20 03        call 0x33c
001C  BF 26 F9        mov di, 0xf926
001F  1E              push ds
0020  57              push di
0021  9A 6C 05 C9 26  call far 26C9:056C
0026  BF 26 FA        mov di, 0xfa26
0029  1E              push ds
002A  57              push di
002B  0E              push cs
002C  E8 0D 03        call 0x33c
002F  BF 26 FA        mov di, 0xfa26
0032  1E              push ds
0033  57              push di
0034  9A 71 05 C9 26  call far 26C9:0571
0039  5D              pop bp
003A  CB              retf

; ---- routine 245A:003B  (found by: call)
sub_003B:
003B  B4 0F           mov ah, 0xf
003D  E8 D4 05        call 0x614
0040  3C 07           cmp al, 7
0042  74 0A           je 0x4e
0044  3C 03           cmp al, 3
0046  76 06           jbe 0x4e
0048  B8 03 00        mov ax, 3
004B  E8 55 00        call 0xa3
loc_004E:
004E  E8 9F 00        call 0xf0
0051  B4 08           mov ah, 8
0053  32 FF           xor bh, bh
0055  E8 BC 05        call 0x614
0058  8A C4           mov al, ah
005A  24 7F           and al, 0x7f
005C  A2 16 DE        mov byte ptr [0xde16], al
005F  A2 0C DE        mov byte ptr [0xde0c], al
0062  33 C0           xor ax, ax
0064  A2 07 DE        mov byte ptr [0xde07], al
0067  A2 17 DE        mov byte ptr [0xde17], al
006A  A2 18 DE        mov byte ptr [0xde18], al
006D  40              inc ax
006E  A2 06 DE        mov byte ptr [0xde06], al
0071  8E 06 22 A5     mov es, word ptr [0xa522]
0075  BF 6C 00        mov di, 0x6c
0078  26 8A 1D        mov bl, byte ptr es:[di]
loc_007B:
007B  26 3A 1D        cmp bl, byte ptr es:[di]
007E  74 FB           je 0x7b
0080  26 8A 1D        mov bl, byte ptr es:[di]
0083  B8 E4 FF        mov ax, 0xffe4
0086  99              cdq
0087  E8 3C 02        call 0x2c6
008A  F7 D0           not ax
008C  F7 D2           not dx
008E  B9 37 00        mov cx, 0x37
0091  F7 F1           div cx
0093  A3 12 DE        mov word ptr [0xde12], ax
0096  1E              push ds
0097  0E              push cs
0098  1F              pop ds
0099  BA 38 01        mov dx, 0x138
009C  B8 1B 25        mov ax, 0x251b
009F  CD 21           int 0x21   ; INT 21h AH=25 set interrupt vector
00A1  1F              pop ds
00A2  C3              ret

; ---- routine 245A:00A3  (found by: call)
sub_00A3:
00A3  8E 06 22 A5     mov es, word ptr [0xa522]
00A7  26 80 26 87 00 FE and byte ptr es:[0x87], 0xfe
00AD  3C 07           cmp al, 7
00AF  74 06           je 0xb7
00B1  3C 04           cmp al, 4
00B3  72 02           jb 0xb7
00B5  B0 03           mov al, 3
loc_00B7:
00B7  50              push ax
00B8  B4 00           mov ah, 0
00BA  E8 57 05        call 0x614
00BD  58              pop ax
00BE  0A E4           or ah, ah
00C0  74 2D           je 0xef
00C2  B8 12 11        mov ax, 0x1112
00C5  B3 00           mov bl, 0
00C7  E8 4A 05        call 0x614
00CA  B8 30 11        mov ax, 0x1130
00CD  B7 00           mov bh, 0
00CF  B2 00           mov dl, 0
00D1  E8 40 05        call 0x614
00D4  80 FA 2A        cmp dl, 0x2a
00D7  75 16           jne 0xef
00D9  26 80 0E 87 00 01 or byte ptr es:[0x87], 1
00DF  B8 00 01        mov ax, 0x100
00E2  B9 00 06        mov cx, 0x600
00E5  E8 2C 05        call 0x614
00E8  B4 12           mov ah, 0x12
00EA  B3 20           mov bl, 0x20
00EC  E8 25 05        call 0x614
loc_00EF:
00EF  C3              ret

; ---- routine 245A:00F0  (found by: call)
sub_00F0:
00F0  B4 0F           mov ah, 0xf
00F2  E8 1F 05        call 0x614
00F5  50              push ax
00F6  B8 30 11        mov ax, 0x1130
00F9  B7 00           mov bh, 0
00FB  B2 00           mov dl, 0
00FD  E8 14 05        call 0x614
0100  58              pop ax
0101  B1 00           mov cl, 0
0103  0A D2           or dl, dl
0105  75 08           jne 0x10f
0107  B2 18           mov dl, 0x18
0109  3C 03           cmp al, 3
010B  77 02           ja 0x10f
010D  B1 01           mov cl, 1
loc_010F:
010F  8A F2           mov dh, dl
0111  8A D4           mov dl, ah
0113  FE CA           dec dl
0115  B4 00           mov ah, 0
0117  80 FE 18        cmp dh, 0x18
011A  76 02           jbe 0x11e
011C  B4 01           mov ah, 1
loc_011E:
011E  A3 0A DE        mov word ptr [0xde0a], ax
0121  89 16 14 DE     mov word ptr [0xde14], dx
0125  88 0E 09 DE     mov byte ptr [0xde09], cl
0129  C6 06 08 DE 01  mov byte ptr [0xde08], 1
012E  33 C0           xor ax, ax
0130  A3 0E DE        mov word ptr [0xde0e], ax
0133  89 16 10 DE     mov word ptr [0xde10], dx
0137  C3              ret
; data (not reached as code), 22 bytes
0138                  db 50 1E B8 64 28 8E D8 80 3E 06 DE 00 74 05 C6 06   ; P..d(...>...t...
0148                  db 18 DE 01 1F 58 CF   ; ....X.

; ---- routine 245A:014E  (found by: call)
sub_014E:
014E  80 3E 18 DE 00  cmp byte ptr [0xde18], 0
0153  75 01           jne 0x156
0155  C3              ret
loc_0156:
0156  C6 06 18 DE 00  mov byte ptr [0xde18], 0
loc_015B:
015B  B4 01           mov ah, 1
015D  CD 16           int 0x16
015F  74 06           je 0x167
0161  B4 00           mov ah, 0
0163  CD 16           int 0x16
0165  EB F4           jmp 0x15b
loc_0167:
0167  B0 5E           mov al, 0x5e
0169  E8 1D 03        call 0x489
016C  B0 43           mov al, 0x43
016E  E8 18 03        call 0x489
0171  E8 0E 03        call 0x482
0174  E9 89 FE        jmp 0
; data (not reached as code), 335 bytes
0177                  db 8B DC 36 8B 47 04 E8 23 FF E8 6D FF A0 16 DE A2   ; ..6.G..#..m.....
0187                  db 0C DE CA 02 00 8B DC 36 8A 57 0A 36 8A 77 08 36   ; .......6.W.6.w.6
0197                  db 8A 4F 06 36 8A 6F 04 3A D1 77 27 3A F5 77 23 FE   ; .O.6.o.:.w':.w#.
01A7                  db CA 78 1F FE CE 78 1B FE C9 3A 0E 14 DE 77 13 FE   ; .x...x...:...w..
01B7                  db CD 3A 2E 15 DE 77 0B 89 16 0E DE 89 0E 10 DE E8   ; .:...w..........
01C7                  db 41 03 CA 08 00 B8 00 06 8A 3E 0C DE 8B 0E 0E DE   ; A........>......
01D7                  db 8B 16 10 DE E8 36 04 8B 16 0E DE E8 25 03 CB E8   ; .....6......%...
01E7                  db 1A 03 B8 00 06 8A 3E 0C DE 8B CA 8A 16 10 DE E8   ; ......>.........
01F7                  db 1B 04 CB B8 01 07 EB 03 B8 01 06 50 E8 FD 02 58   ; ...........P...X
0207                  db 8A 3E 0C DE 8A 0E 0E DE 8A EE 8B 16 10 DE 3A EE   ; .>............:.
0217                  db 75 02 32 C0 E8 F6 03 CB 8B DC 36 8A 57 06 36 8A   ; u.2.......6.W.6.
0227                  db 77 04 FE CA 02 16 0E DE 72 17 3A 16 10 DE 77 11   ; w.......r.:...w.
0237                  db FE CE 02 36 0F DE 72 09 3A 36 11 DE 77 03 E8 C2   ; ...6..r.:6..w...
0247                  db 02 CA 04 00 E8 B5 02 8A C2 2A 06 0E DE FE C0 CB   ; .........*......
0257                  db E8 A9 02 8A C6 2A 06 0F DE FE C0 CB 8B DC 36 8A   ; .....*........6.
0267                  db 47 04 A8 F0 74 04 24 0F 0C 80 80 26 0C DE 70 08   ; G...t.$....&..p.
0277                  db 06 0C DE CA 02 00 8B DC 36 8A 47 04 24 07 B1 04   ; ........6.G.$...
0287                  db D2 E0 80 26 0C DE 8F 08 06 0C DE CA 02 00 80 26   ; ...&...........&
0297                  db 0C DE F7 CB 80 0E 0C DE 08 CB A0 16 DE A2 0C DE   ; ................
02A7                  db CB 8B DC 36 8B 4F 04 E3 13 8E 06 22 A5 33 FF 26   ; ...6.O.....".3.&
02B7                  db 8A 1D A1 12 DE 33 D2 E8 05 00 E2 F6 CA 02 00   ; .....3.........

; ---- routine 245A:02C6  (found by: call, jump)
sub_02C6:
02C6  2D 01 00        sub ax, 1
02C9  83 DA 00        sbb dx, 0
02CC  72 05           jb 0x2d3
02CE  26 3A 1D        cmp bl, byte ptr es:[di]
02D1  74 F3           je 0x2c6
loc_02D3:
02D3  C3              ret
; data (not reached as code), 70 bytes
02D4                  db 8B DC 36 8B 5F 04 B8 DD 34 BA 12 00 3B D3 73 1A   ; ..6._...4...;.s.
02E4                  db F7 F3 8B D8 E4 61 A8 03 75 08 0C 03 E6 61 B0 B6   ; .....a..u....a..
02F4                  db E6 43 8A C3 E6 42 8A C7 E6 42 CA 02 00 E4 61 24   ; .C...B...B....a$
0304                  db FC E6 61 CB 80 3E 17 DE 00 75 08 B4 01 CD 16 B0   ; ..a..>...u......
0314                  db 00 74 02 B0 01 CB   ; .t....

; ---- routine 245A:031A  (found by: call)
sub_031A:
031A  A0 17 DE        mov al, byte ptr [0xde17]
031D  C6 06 17 DE 00  mov byte ptr [0xde17], 0
0322  0A C0           or al, al
0324  75 12           jne 0x338
0326  32 E4           xor ah, ah
0328  CD 16           int 0x16
032A  0A C0           or al, al
032C  75 0A           jne 0x338
032E  88 26 17 DE     mov byte ptr [0xde17], ah
0332  0A E4           or ah, ah
0334  75 02           jne 0x338
0336  B0 03           mov al, 3
loc_0338:
0338  E8 13 FE        call 0x14e
033B  CB              retf

; ---- routine 245A:033C  (found by: call)
sub_033C:
033C  8B DC           mov bx, sp
033E  1E              push ds
033F  36 C5 7F 04     lds di, ptr ss:[bx + 4]
0343  C7 45 02 B0 D7  mov word ptr [di + 2], 0xd7b0
0348  C7 45 04 80 00  mov word ptr [di + 4], 0x80
034D  8D 85 80 00     lea ax, [di + 0x80]
0351  89 45 0C        mov word ptr [di + 0xc], ax
0354  8C 5D 0E        mov word ptr [di + 0xe], ds
0357  C7 45 10 67 03  mov word ptr [di + 0x10], 0x367
035C  8C 4D 12        mov word ptr [di + 0x12], cs
035F  C6 45 30 00     mov byte ptr [di + 0x30], 0
0363  1F              pop ds
0364  CA 04 00        retf 4
; data (not reached as code), 56 bytes
0367                  db 8B DC 1E 36 C5 7F 04 B8 9F 03 BB 7D 04 8B CB 81   ; ...6.......}....
0377                  db 7D 02 B1 D7 74 0A C7 45 02 B2 D7 B8 4C 04 8B D8   ; }...t..E....L...
0387                  db 89 45 14 8C 4D 16 89 5D 18 8C 4D 1A 89 4D 1C 8C   ; .E..M..]..M..M..
0397                  db 4D 1E 33 C0 1F CA 04 00   ; M.3.....

; ---- routine 245A:039F  (found by: prologue)
sub_039F:
039F  55              push bp
03A0  8B EC           mov bp, sp
03A2  C4 7E 06        les di, ptr [bp + 6]
03A5  26 8B 55 04     mov dx, word ptr es:[di + 4]
03A9  4A              dec dx
03AA  4A              dec dx
03AB  26 8B 75 08     mov si, word ptr es:[di + 8]
03AF  26 C4 7D 0C     les di, ptr es:[di + 0xc]
03B3  33 DB           xor bx, bx
loc_03B5:
03B5  C6 06 17 DE 00  mov byte ptr [0xde17], 0
03BA  0E              push cs
03BB  E8 5C FF        call 0x31a
03BE  B9 01 00        mov cx, 1
03C1  3C 08           cmp al, 8
03C3  74 34           je 0x3f9
03C5  3C 13           cmp al, 0x13
03C7  74 30           je 0x3f9
03C9  3C 04           cmp al, 4
03CB  74 44           je 0x411
03CD  49              dec cx
03CE  3C 1B           cmp al, 0x1b
03D0  74 27           je 0x3f9
03D2  3C 01           cmp al, 1
03D4  74 23           je 0x3f9
03D6  3C 06           cmp al, 6
03D8  74 37           je 0x411
03DA  3C 1A           cmp al, 0x1a
03DC  74 46           je 0x424
03DE  3C 0D           cmp al, 0xd
03E0  74 4F           je 0x431
03E2  3C 20           cmp al, 0x20
03E4  72 CF           jb 0x3b5
03E6  3B DA           cmp bx, dx
03E8  74 CB           je 0x3b5
03EA  26 88 01        mov byte ptr es:[bx + di], al
03ED  43              inc bx
03EE  E8 98 00        call 0x489
03F1  3B DE           cmp bx, si
03F3  76 C0           jbe 0x3b5
03F5  8B F3           mov si, bx
03F7  EB BC           jmp 0x3b5
loc_03F9:
03F9  0B DB           or bx, bx
03FB  74 B8           je 0x3b5
03FD  B0 08           mov al, 8
03FF  E8 87 00        call 0x489
0402  B0 20           mov al, 0x20
0404  E8 82 00        call 0x489
0407  B0 08           mov al, 8
0409  E8 7D 00        call 0x489
040C  4B              dec bx
040D  E2 EA           loop 0x3f9
040F  EB A4           jmp 0x3b5
loc_0411:
0411  3B DE           cmp bx, si
0413  74 A0           je 0x3b5
0415  26 8A 01        mov al, byte ptr es:[bx + di]
0418  3C 20           cmp al, 0x20
041A  72 99           jb 0x3b5
041C  E8 6A 00        call 0x489
041F  43              inc bx
0420  E2 EF           loop 0x411
0422  EB 91           jmp 0x3b5
loc_0424:
0424  80 3E 07 DE 00  cmp byte ptr [0xde07], 0
0429  74 8A           je 0x3b5
042B  26 88 01        mov byte ptr es:[bx + di], al
042E  43              inc bx
042F  EB 0A           jmp 0x43b
loc_0431:
0431  E8 4E 00        call 0x482
0434  26 C7 01 0D 0A  mov word ptr es:[bx + di], 0xa0d
0439  43              inc bx
043A  43              inc bx
loc_043B:
043B  C4 7E 06        les di, ptr [bp + 6]
043E  33 C0           xor ax, ax
0440  26 89 45 08     mov word ptr es:[di + 8], ax
0444  26 89 5D 0A     mov word ptr es:[di + 0xa], bx
0448  5D              pop bp
0449  CA 04 00        retf 4
; data (not reached as code), 54 bytes
044C                  db 8B DC 36 C4 7F 04 26 8B 4D 08 26 29 4D 08 E3 19   ; ..6...&.M.&)M...
045C                  db 26 C4 7D 0C 80 3E 08 DE 00 75 0B 26 8A 05 E8 1C   ; &.}..>...u.&....
046C                  db 00 47 E2 F7 EB 03 E8 9C 00 E8 D6 FC 33 C0 CA 04   ; .G..........3...
047C                  db 00 33 C0 CA 04 00   ; .3....

; ---- routine 245A:0482  (found by: call)
sub_0482:
0482  B0 0D           mov al, 0xd
0484  E8 02 00        call 0x489
0487  B0 0A           mov al, 0xa

; ---- routine 245A:0489  (found by: call)
sub_0489:
0489  53              push bx
048A  51              push cx
048B  52              push dx
048C  06              push es
048D  50              push ax
048E  E8 72 00        call 0x503
0491  58              pop ax
0492  3C 07           cmp al, 7
0494  74 2A           je 0x4c0
0496  3C 08           cmp al, 8
0498  74 2D           je 0x4c7
049A  3C 0D           cmp al, 0xd
049C  74 33           je 0x4d1
049E  3C 0A           cmp al, 0xa
04A0  74 35           je 0x4d7
04A2  B4 09           mov ah, 9
04A4  8A 1E 0C DE     mov bl, byte ptr [0xde0c]
04A8  32 FF           xor bh, bh
04AA  B9 01 00        mov cx, 1
04AD  52              push dx
04AE  E8 63 01        call 0x614
04B1  5A              pop dx
04B2  FE C2           inc dl
04B4  3A 16 10 DE     cmp dl, byte ptr [0xde10]
04B8  76 20           jbe 0x4da
04BA  8A 16 0E DE     mov dl, byte ptr [0xde0e]
04BE  EB 17           jmp 0x4d7
loc_04C0:
04C0  B4 0E           mov ah, 0xe
04C2  E8 4F 01        call 0x614
04C5  EB 13           jmp 0x4da
loc_04C7:
04C7  3A 16 0E DE     cmp dl, byte ptr [0xde0e]
04CB  74 0D           je 0x4da
04CD  FE CA           dec dl
04CF  EB 09           jmp 0x4da
loc_04D1:
04D1  8A 16 0E DE     mov dl, byte ptr [0xde0e]
04D5  EB 03           jmp 0x4da
loc_04D7:
04D7  E8 08 00        call 0x4e2
loc_04DA:
04DA  E8 2D 00        call 0x50a
04DD  07              pop es
04DE  5A              pop dx
04DF  59              pop cx
04E0  5B              pop bx
04E1  C3              ret

; ---- routine 245A:04E2  (found by: call)
sub_04E2:
04E2  FE C6           inc dh
04E4  3A 36 11 DE     cmp dh, byte ptr [0xde11]
04E8  76 18           jbe 0x502
04EA  FE CE           dec dh
04EC  51              push cx
04ED  52              push dx
04EE  B8 01 06        mov ax, 0x601
04F1  8A 3E 0C DE     mov bh, byte ptr [0xde0c]
04F5  8B 0E 0E DE     mov cx, word ptr [0xde0e]
04F9  8B 16 10 DE     mov dx, word ptr [0xde10]
04FD  E8 14 01        call 0x614
0500  5A              pop dx
0501  59              pop cx
loc_0502:
0502  C3              ret

; ---- routine 245A:0503  (found by: call)
sub_0503:
0503  B4 03           mov ah, 3
0505  32 FF           xor bh, bh
0507  E9 0A 01        jmp 0x614

; ---- routine 245A:050A  (found by: call)
sub_050A:
050A  B4 02           mov ah, 2
050C  32 FF           xor bh, bh
050E  E9 03 01        jmp 0x614
; data (not reached as code), 259 bytes
0511                  db 1E 8E 1E 22 A5 8B 16 50 00 1F 8B DA 8B F7 26 8A   ; ..."...P......&.
0521                  db 05 3C 07 74 21 3C 08 74 2C 3C 0A 74 35 3C 0D 74   ; .<.t!<.t,<.t5<.t
0531                  db 39 47 FE C2 3A 16 10 DE 76 3C E8 6E 00 E8 A1 FF   ; 9G..:...v<.n....
0541                  db 8A 16 0E DE EB 2C E8 62 00 51 52 B8 07 0E E8 C2   ; .....,.b.QR.....
0551                  db 00 5A 59 EB 1C E8 53 00 3A 16 0E DE 74 13 FE CA   ; .ZY...S.:...t...
0561                  db EB 0F E8 46 00 E8 79 FF EB 07 E8 3E 00 8A 16 0E   ; ...F..y....>....
0571                  db DE 47 8B F7 8B DA E2 A6 E8 30 00 1E 8E 1E 22 A5   ; .G.......0....".
0581                  db 89 16 50 00 8A C6 F6 26 4A 00 32 F6 03 C2 8B C8   ; ..P....&J.2.....
0591                  db 8B 16 63 00 B0 0E EE EB 00 8A C5 42 EE EB 00 4A   ; ..c........B...J
05A1                  db B0 0F EE EB 00 8A C1 42 EE 1F C3 3B F7 74 63 51   ; .......B...;.tcQ
05B1                  db 52 57 1E 06 8B CF 2B CE 1E 8E 1E 22 A5 8A C7 F6   ; RW....+...."....
05C1                  db 26 4A 00 32 FF 03 C3 D1 E0 8B F8 8B 16 63 00 83   ; &J.2.........c..
05D1                  db C2 06 80 3E 49 00 07 1F A1 28 A5 75 03 A1 26 A5   ; ...>I....(.u..&.
05E1                  db 8A 1E 09 DE 8A 3E 0C DE 06 1F 8E C0 FC 0A DB 74   ; .....>.........t
05F1                  db 16 AC 8A D8 EC A8 01 75 FB FA EC A8 01 74 FB 8B   ; .......u.....t..
0601                  db C3 AB FB E2 EC EB 06 8A E7 AC AB E2 FC 07 1F 5F   ; ..............._
0611                  db 5A 59 C3   ; ZY.

; ---- routine 245A:0614  (found by: call, jump)
sub_0614:
0614  56              push si
0615  57              push di
0616  55              push bp
0617  06              push es
0618  CD 10           int 0x10
061A  07              pop es
061B  5D              pop bp
061C  5F              pop di
061D  5E              pop si
061E  C3              ret
; data (not reached as code), 1 bytes
061F                  db 00   ; .
