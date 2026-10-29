; 1-0.EXE (One-Nil 96), code segment 0006 (image offsets 00060..01EEF), part 1 of 3
; packed 1-0.EXE sha256 89ff9c5f238f24e81a0c2440a46cdd8997280a65fc3cc3d97cb974f55280a80a (LZEXE 0.91)
; unpacked (tools/static/unlzexe.py) sha256 887ed2a92767950e5309b2052409f875668605939b69e00737aa3047022b9f51
; tool: capstone 5.0.9 (pip package; core library 5.0.1280) (CS_ARCH_X86, CS_MODE_16), recursive descent from the entry point, far calls and near calls/jumps, then routine prologues (55 89 E5 / 55 8B EC / C8 iw 00) in what remains; tools/static/listing.py
; addresses are SEGMENT:OFFSET with SEGMENT the image paragraph before relocation; image offset = SEGMENT*16+OFFSET
; data (not reached as code), 2 bytes
0000                  db 01 20   ; . 

; ---- routine 0006:0002  (found by: call)
sub_0002:
0002  C8 1C 01 00     enter 0x11c, 0
0006  8C D3           mov bx, ss
0008  8E C3           mov es, bx
000A  8C DB           mov bx, ds
000C  FC              cld
000D  8D 7E F2        lea di, [bp - 0xe]
0010  C5 76 06        lds si, ptr [bp + 6]
0013  AC              lodsb al, byte ptr [si]
0014  3C 0C           cmp al, 0xc
0016  72 02           jb 0x1a
0018  B0 0C           mov al, 0xc
loc_001A:
001A  AA              stosb byte ptr es:[di], al
001B  91              xchg cx, ax
001C  30 ED           xor ch, ch
001E  F3 A4           rep movsb byte ptr es:[di], byte ptr [si]
0020  8E DB           mov ds, bx
0022  8D BE E4 FE     lea di, [bp - 0x11c]
0026  16              push ss
0027  57              push di
0028  8B 46 0E        mov ax, word ptr [bp + 0xe]
002B  C4 3E D4 DC     les di, ptr [0xdcd4]
002F  03 F8           add di, ax
0031  26 8A 05        mov al, byte ptr es:[di]
0034  50              push ax
0035  9A 6F 0C C9 26  call far 26C9:0C6F
003A  BF 00 00        mov di, 0
003D  0E              push cs
003E  57              push di
003F  9A D2 0B C9 26  call far 26C9:0BD2
0044  6B 46 0E 0B     imul ax, word ptr [bp + 0xe], 0xb
0048  C4 3E CC DC     les di, ptr [0xdccc]
004C  03 F8           add di, ax
004E  06              push es
004F  57              push di
0050  9A D2 0B C9 26  call far 26C9:0BD2
0055  8D 7E E4        lea di, [bp - 0x1c]
0058  16              push ss
0059  57              push di
005A  6A 0C           push 0xc
005C  9A 6D 0B C9 26  call far 26C9:0B6D
0061  83 7E 0C 00     cmp word ptr [bp + 0xc], 0
0065  75 13           jne 0x7a
0067  8D 7E F2        lea di, [bp - 0xe]
006A  16              push ss
006B  57              push di
006C  8D 7E E4        lea di, [bp - 0x1c]
006F  16              push ss
0070  57              push di
0071  6A 0C           push 0xc
0073  9A 6D 0B C9 26  call far 26C9:0B6D
0078  EB 1B           jmp 0x95
loc_007A:
007A  8D 7E E4        lea di, [bp - 0x1c]
007D  16              push ss
007E  57              push di
007F  6A 0C           push 0xc
0081  8A 46 0A        mov al, byte ptr [bp + 0xa]
0084  50              push ax
0085  8B 46 0A        mov ax, word ptr [bp + 0xa]
0088  05 0C 00        add ax, 0xc
008B  50              push ax
008C  8A 46 0C        mov al, byte ptr [bp + 0xc]
008F  50              push ax
0090  9A 5C 0C 2A 23  call far 232A:0C5C
loc_0095:
0095  8A 56 E5        mov dl, byte ptr [bp - 0x1b]
0098  8B 46 0E        mov ax, word ptr [bp + 0xe]
009B  C4 3E D4 DC     les di, ptr [0xdcd4]
009F  03 F8           add di, ax
00A1  26 88 15        mov byte ptr es:[di], dl
00A4  8D 7E E4        lea di, [bp - 0x1c]
00A7  16              push ss
00A8  57              push di
00A9  6A 01           push 1
00AB  80 7E E6 20     cmp byte ptr [bp - 0x1a], 0x20
00AF  B0 00           mov al, 0
00B1  75 01           jne 0xb4
00B3  40              inc ax
loc_00B4:
00B4  30 E4           xor ah, ah
00B6  40              inc ax
00B7  50              push ax
00B8  9A FB 0C C9 26  call far 26C9:0CFB
00BD  6B 46 0E 0B     imul ax, word ptr [bp + 0xe], 0xb
00C1  C4 3E CC DC     les di, ptr [0xdccc]
00C5  03 F8           add di, ax
00C7  26 8A 45 01     mov al, byte ptr es:[di + 1]
00CB  50              push ax
00CC  9A 86 19 C9 26  call far 26C9:1986
00D1  8A D0           mov dl, al
00D3  6B 46 0E 0B     imul ax, word ptr [bp + 0xe], 0xb
00D7  C4 3E CC DC     les di, ptr [0xdccc]
00DB  03 F8           add di, ax
00DD  26 88 55 01     mov byte ptr es:[di + 1], dl
00E1  8D 7E E4        lea di, [bp - 0x1c]
00E4  16              push ss
00E5  57              push di
00E6  6B 46 0E 0B     imul ax, word ptr [bp + 0xe], 0xb
00EA  C4 3E CC DC     les di, ptr [0xdccc]
00EE  03 F8           add di, ax
00F0  06              push es
00F1  57              push di
00F2  6A 0A           push 0xa
00F4  9A 6D 0B C9 26  call far 26C9:0B6D
00F9  80 7E 04 00     cmp byte ptr [bp + 4], 0
00FD  74 0F           je 0x10e
00FF  8A 56 04        mov dl, byte ptr [bp + 4]
0102  8B 46 0E        mov ax, word ptr [bp + 0xe]
0105  C4 3E D0 DC     les di, ptr [0xdcd0]
0109  03 F8           add di, ax
010B  26 88 15        mov byte ptr es:[di], dl
loc_010E:
010E  C9              leave
010F  C2 0C 00        ret 0xc

; ---- routine 0006:0112  (found by: call)
sub_0112:
0112  55              push bp
0113  89 E5           mov bp, sp
0115  80 3E E0 DC 03  cmp byte ptr [0xdce0], 3
011A  75 07           jne 0x123
011C  C6 06 E0 DC 02  mov byte ptr [0xdce0], 2
0121  EB 05           jmp 0x128
loc_0123:
0123  C6 06 E0 DC 03  mov byte ptr [0xdce0], 3
loc_0128:
0128  C9              leave
0129  C3              ret
; data (not reached as code), 31 bytes
012A                  pstr "You can't choose the same team"

; ---- routine 0006:0149  (found by: call)
sub_0149:
0149  C8 04 00 00     enter 4, 0
014D  C4 3E D2 D7     les di, ptr [0xd7d2]
0151  89 7E FC        mov word ptr [bp - 4], di
0154  8C 46 FE        mov word ptr [bp - 2], es
0157  26 80 7D 04 02  cmp byte ptr es:[di + 4], 2
015C  75 0A           jne 0x168
015E  A0 BA DC        mov al, byte ptr [0xdcba]
0161  30 E4           xor ah, ah
0163  3B 46 08        cmp ax, word ptr [bp + 8]
0166  74 04           je 0x16c
loc_0168:
0168  B0 00           mov al, 0
016A  EB 02           jmp 0x16e
loc_016C:
016C  B0 01           mov al, 1
loc_016E:
016E  50              push ax
016F  BF 2A 01        mov di, 0x12a
0172  0E              push cs
0173  57              push di
0174  9A 98 00 2A 23  call far 232A:0098
0179  08 C0           or al, al
017B  B0 00           mov al, 0
017D  75 01           jne 0x180
017F  40              inc ax
loc_0180:
0180  C4 7E 04        les di, ptr [bp + 4]
0183  26 88 05        mov byte ptr es:[di], al
0186  26 80 3D 00     cmp byte ptr es:[di], 0
018A  74 12           je 0x19e
018C  8A 56 08        mov dl, byte ptr [bp + 8]
018F  C4 7E FC        les di, ptr [bp - 4]
0192  26 8A 45 04     mov al, byte ptr es:[di + 4]
0196  30 E4           xor ah, ah
0198  8B F8           mov di, ax
019A  88 95 B9 DC     mov byte ptr [di - 0x2347], dl
loc_019E:
019E  C9              leave
019F  C2 06 00        ret 6
; data (not reached as code), 46 bytes
01A2                  pstr ' are not interested'
01B6                  pstr ' agree to employ you - ok'

; ---- routine 0006:01D0  (found by: call)
sub_01D0:
01D0  C8 08 02 00     enter 0x208, 0
01D4  C4 3E D2 D7     les di, ptr [0xd7d2]
01D8  89 7E F8        mov word ptr [bp - 8], di
01DB  8C 46 FA        mov word ptr [bp - 6], es
01DE  C6 46 FF 00     mov byte ptr [bp - 1], 0
01E2  26 8A 45 04     mov al, byte ptr es:[di + 4]
01E6  30 E4           xor ah, ah
01E8  03 F8           add di, ax
01EA  26 8A 45 18     mov al, byte ptr es:[di + 0x18]
01EE  30 E4           xor ah, ah
01F0  3B 46 04        cmp ax, word ptr [bp + 4]
01F3  74 1D           je 0x212
01F5  C4 7E F8        les di, ptr [bp - 8]
01F8  26 8A 45 04     mov al, byte ptr es:[di + 4]
01FC  30 E4           xor ah, ah
01FE  D1 E0           shl ax, 1
0200  03 F8           add di, ax
0202  26 FF 75 03     push word ptr es:[di + 3]
0206  FF 76 04        push word ptr [bp + 4]
0209  9A 6B 6C 55 1B  call far 1B55:6C6B
020E  08 C0           or al, al
0210  74 04           je 0x216
loc_0212:
0212  B0 00           mov al, 0
0214  EB 02           jmp 0x218
loc_0216:
0216  B0 01           mov al, 1
loc_0218:
0218  50              push ax
0219  8D BE F8 FE     lea di, [bp - 0x108]
021D  16              push ss
021E  57              push di
021F  8B 46 04        mov ax, word ptr [bp + 4]
0222  C1 E0 04        shl ax, 4
0225  C4 3E B2 D7     les di, ptr [0xd7b2]
0229  03 F8           add di, ax
022B  81 C7 F0 FF     add di, 0xfff0
022F  06              push es
0230  57              push di
0231  9A 53 0B C9 26  call far 26C9:0B53
0236  BF A2 01        mov di, 0x1a2
0239  0E              push cs
023A  57              push di
023B  9A D2 0B C9 26  call far 26C9:0BD2
0240  9A 98 00 2A 23  call far 232A:0098
0245  08 C0           or al, al
0247  75 30           jne 0x279
0249  8D BE F8 FD     lea di, [bp - 0x208]
024D  16              push ss
024E  57              push di
024F  8B 46 04        mov ax, word ptr [bp + 4]
0252  C1 E0 04        shl ax, 4
0255  C4 3E B2 D7     les di, ptr [0xd7b2]
0259  03 F8           add di, ax
025B  81 C7 F0 FF     add di, 0xfff0
025F  06              push es
0260  57              push di
0261  9A 53 0B C9 26  call far 26C9:0B53
0266  BF B6 01        mov di, 0x1b6
0269  0E              push cs
026A  57              push di
026B  9A D2 0B C9 26  call far 26C9:0BD2
0270  9A E5 06 2A 23  call far 232A:06E5
0275  08 C0           or al, al
0277  75 02           jne 0x27b
loc_0279:
0279  EB 46           jmp 0x2c1
loc_027B:
027B  C7 46 FC 01 00  mov word ptr [bp - 4], 1
0280  EB 03           jmp 0x285
loc_0282:
0282  FF 46 FC        inc word ptr [bp - 4]
loc_0285:
0285  8B 46 FC        mov ax, word ptr [bp - 4]
0288  C4 7E F8        les di, ptr [bp - 8]
028B  03 F8           add di, ax
028D  26 8A 45 18     mov al, byte ptr es:[di + 0x18]
0291  30 E4           xor ah, ah
0293  3B 46 04        cmp ax, word ptr [bp + 4]
0296  75 0D           jne 0x2a5
0298  8B 46 FC        mov ax, word ptr [bp - 4]
029B  C4 7E F8        les di, ptr [bp - 8]
029E  03 F8           add di, ax
02A0  26 C6 45 18 00  mov byte ptr es:[di + 0x18], 0
loc_02A5:
02A5  83 7E FC 02     cmp word ptr [bp - 4], 2
02A9  75 D7           jne 0x282
02AB  C4 7E F8        les di, ptr [bp - 8]
02AE  26 8A 45 04     mov al, byte ptr es:[di + 4]
02B2  30 E4           xor ah, ah
02B4  50              push ax
02B5  FF 76 04        push word ptr [bp + 4]
02B8  9A C0 38 EF 01  call far 01EF:38C0
02BD  C6 46 FF 01     mov byte ptr [bp - 1], 1
loc_02C1:
02C1  8A 46 FF        mov al, byte ptr [bp - 1]
02C4  C9              leave
02C5  C2 02 00        ret 2
; data (not reached as code), 2 bytes
02C8                  db 01 FB   ; ..

; ---- routine 0006:02CA  (found by: call)
sub_02CA:
02CA  C8 16 01 00     enter 0x116, 0
02CE  BF 5E 4F        mov di, 0x4f5e
02D1  1E              push ds
02D2  57              push di
02D3  BF 5C DD        mov di, 0xdd5c
02D6  1E              push ds
02D7  57              push di
02D8  9A 2F 05 2A 23  call far 232A:052F
02DD  BF D6 1A        mov di, 0x1ad6
02E0  1E              push ds
02E1  57              push di
02E2  BF 5C DD        mov di, 0xdd5c
02E5  1E              push ds
02E6  57              push di
02E7  9A 2F 05 2A 23  call far 232A:052F
02EC  BF 22 63        mov di, 0x6322
02EF  1E              push ds
02F0  57              push di
02F1  BF 5C DD        mov di, 0xdd5c
02F4  1E              push ds
02F5  57              push di
02F6  9A 2F 05 2A 23  call far 232A:052F
02FB  80 3E E2 00 2F  cmp byte ptr [0xe2], 0x2f
0300  73 13           jae 0x315
0302  C4 3E 5C DD     les di, ptr [0xdd5c]
0306  81 C7 B0 0C     add di, 0xcb0
030A  06              push es
030B  57              push di
030C  6A 0E           push 0xe
030E  6A 04           push 4
0310  9A 4B 03 BC 24  call far 24BC:034B
loc_0315:
0315  80 3E E2 00 01  cmp byte ptr [0xe2], 1
031A  76 13           jbe 0x32f
031C  C4 3E 5C DD     les di, ptr [0xdd5c]
0320  81 C7 BA 0C     add di, 0xcba
0324  06              push es
0325  57              push di
0326  6A 0E           push 0xe
0328  6A 04           push 4
032A  9A 4B 03 BC 24  call far 24BC:034B
loc_032F:
032F  C7 46 FC 04 00  mov word ptr [bp - 4], 4
0334  A0 E2 00        mov al, byte ptr [0xe2]
0337  30 E4           xor ah, ah
0339  05 0F 00        add ax, 0xf
033C  99              cdq
033D  52              push dx
033E  50              push ax
033F  6A 00           push 0
0341  6A 3A           push 0x3a
0343  9A FA 04 BC 24  call far 24BC:04FA
0348  89 46 F2        mov word ptr [bp - 0xe], ax
034B  A0 E2 00        mov al, byte ptr [0xe2]
034E  30 E4           xor ah, ah
0350  3B 46 F2        cmp ax, word ptr [bp - 0xe]
0353  76 03           jbe 0x358
0355  E9 E4 01        jmp 0x53c
loc_0358:
0358  89 46 FE        mov word ptr [bp - 2], ax
035B  EB 03           jmp 0x360
loc_035D:
035D  FF 46 FE        inc word ptr [bp - 2]
loc_0360:
0360  8B 46 FE        mov ax, word ptr [bp - 2]
0363  8B F0           mov si, ax
0365  D1 E0           shl ax, 1
0367  01 F0           add ax, si
0369  8B D0           mov dx, ax
036B  69 46 04 AE 00  imul ax, word ptr [bp + 4], 0xae
0370  C4 3E CA D7     les di, ptr [0xd7ca]
0374  03 F8           add di, ax
0376  03 FA           add di, dx
0378  81 C7 4F FF     add di, 0xff4f
037C  89 7E EE        mov word ptr [bp - 0x12], di
037F  8C 46 F0        mov word ptr [bp - 0x10], es
0382  C4 3E D2 D7     les di, ptr [0xd7d2]
0386  26 8A 05        mov al, byte ptr es:[di]
0389  30 E4           xor ah, ah
038B  40              inc ax
038C  3B 46 FE        cmp ax, word ptr [bp - 2]
038F  75 28           jne 0x3b9
0391  6B 46 04 3E     imul ax, word ptr [bp + 4], 0x3e
0395  C4 3E C2 D7     les di, ptr [0xd7c2]
0399  03 F8           add di, ax
039B  26 80 7D FC 00  cmp byte ptr es:[di - 4], 0
03A0  74 17           je 0x3b9
03A2  6A 0F           push 0xf
03A4  BF C8 02        mov di, 0x2c8
03A7  0E              push cs
03A8  57              push di
03A9  8A 46 FC        mov al, byte ptr [bp - 4]
03AC  50              push ax
03AD  6A 17           push 0x17
03AF  BF 5C DD        mov di, 0xdd5c
03B2  1E              push ds
03B3  57              push di
03B4  9A 1B 04 2A 23  call far 232A:041B
loc_03B9:
03B9  C6 46 F9 00     mov byte ptr [bp - 7], 0
03BD  C7 46 FA 01 00  mov word ptr [bp - 6], 1
03C2  EB 03           jmp 0x3c7
loc_03C4:
03C4  FF 46 FA        inc word ptr [bp - 6]
loc_03C7:
03C7  8B 46 FE        mov ax, word ptr [bp - 2]
03CA  C1 E0 02        shl ax, 2
03CD  8B D0           mov dx, ax
03CF  69 46 FA E8 00  imul ax, word ptr [bp - 6], 0xe8
03D4  C4 3E DC DC     les di, ptr [0xdcdc]
03D8  03 F8           add di, ax
03DA  03 FA           add di, dx
03DC  26 8A 85 17 FF  mov al, byte ptr es:[di - 0xe9]
03E1  30 E4           xor ah, ah
03E3  3B 46 04        cmp ax, word ptr [bp + 4]
03E6  74 03           je 0x3eb
03E8  E9 8D 00        jmp 0x478
loc_03EB:
03EB  8B 46 FE        mov ax, word ptr [bp - 2]
03EE  C1 E0 02        shl ax, 2
03F1  8B D0           mov dx, ax
03F3  69 46 FA E8 00  imul ax, word ptr [bp - 6], 0xe8
03F8  C4 3E DC DC     les di, ptr [0xdcdc]
03FC  03 F8           add di, ax
03FE  03 FA           add di, dx
0400  81 C7 14 FF     add di, 0xff14
0404  89 7E EA        mov word ptr [bp - 0x16], di
0407  8C 46 EC        mov word ptr [bp - 0x14], es
040A  C6 46 F9 01     mov byte ptr [bp - 7], 1
040E  26 8A 05        mov al, byte ptr es:[di]
0411  30 E4           xor ah, ah
0413  31 D2           xor dx, dx
0415  89 46 F4        mov word ptr [bp - 0xc], ax
0418  89 56 F6        mov word ptr [bp - 0xa], dx
041B  8B 46 F4        mov ax, word ptr [bp - 0xc]
041E  8B 56 F6        mov dx, word ptr [bp - 0xa]
0421  B9 E8 03        mov cx, 0x3e8
0424  31 DB           xor bx, bx
0426  9A 2A 0A C9 26  call far 26C9:0A2A
042B  8B C8           mov cx, ax
042D  8B DA           mov bx, dx
042F  C4 7E EA        les di, ptr [bp - 0x16]
0432  26 8B 45 01     mov ax, word ptr es:[di + 1]
0436  31 D2           xor dx, dx
0438  03 C1           add ax, cx
043A  13 D3           adc dx, bx
043C  89 46 F4        mov word ptr [bp - 0xc], ax
043F  89 56 F6        mov word ptr [bp - 0xa], dx
0442  8B 7E FE        mov di, word ptr [bp - 2]
0445  80 BD 6A A2 00  cmp byte ptr [di - 0x5d96], 0
044A  B0 00           mov al, 0
044C  75 01           jne 0x44f
044E  40              inc ax
loc_044F:
044F  98              cwde
0450  8B F8           mov di, ax
0452  8A 85 A2 0D     mov al, byte ptr [di + 0xda2]
0456  50              push ax
0457  8D BE EA FE     lea di, [bp - 0x116]
045B  16              push ss
045C  57              push di
045D  FF 76 F6        push word ptr [bp - 0xa]
0460  FF 76 F4        push word ptr [bp - 0xc]
0463  9A 95 0F 55 1B  call far 1B55:0F95
0468  8A 46 FC        mov al, byte ptr [bp - 4]
046B  50              push ax
046C  6A 1E           push 0x1e
046E  BF 5C DD        mov di, 0xdd5c
0471  1E              push ds
0472  57              push di
0473  9A 0C 03 2A 23  call far 232A:030C
loc_0478:
0478  83 7E FA 02     cmp word ptr [bp - 6], 2
047C  74 03           je 0x481
047E  E9 43 FF        jmp 0x3c4
loc_0481:
0481  80 7E F9 00     cmp byte ptr [bp - 7], 0
0485  75 0D           jne 0x494
0487  FF 76 FE        push word ptr [bp - 2]
048A  FF 76 FC        push word ptr [bp - 4]
048D  6A 1D           push 0x1d
048F  9A 02 3B 55 1B  call far 1B55:3B02
loc_0494:
0494  8D BE EE FE     lea di, [bp - 0x112]
0498  16              push ss
0499  57              push di
049A  C4 7E EE        les di, ptr [bp - 0x12]
049D  26 8A 05        mov al, byte ptr es:[di]
04A0  50              push ax
04A1  8A 46 FE        mov al, byte ptr [bp - 2]
04A4  50              push ax
04A5  9A 2B 14 55 1B  call far 1B55:142B
04AA  8A 46 FC        mov al, byte ptr [bp - 4]
04AD  50              push ax
04AE  6A 38           push 0x38
04B0  BF 5C DD        mov di, 0xdd5c
04B3  1E              push ds
04B4  57              push di
04B5  9A 9D 03 2A 23  call far 232A:039D
04BA  C4 7E EE        les di, ptr [bp - 0x12]
04BD  26 80 7D 01 00  cmp byte ptr es:[di + 1], 0
04C2  74 37           je 0x4fb
04C4  26 8A 45 01     mov al, byte ptr es:[di + 1]
04C8  30 E4           xor ah, ah
04CA  50              push ax
04CB  FF 76 FC        push word ptr [bp - 4]
04CE  6A 20           push 0x20
04D0  9A E3 0E 55 1B  call far 1B55:0EE3
04D5  C4 7E EE        les di, ptr [bp - 0x12]
04D8  26 8A 45 02     mov al, byte ptr es:[di + 2]
04DC  24 0F           and al, 0xf
04DE  30 E4           xor ah, ah
04E0  8B F8           mov di, ax
04E2  C1 E7 03        shl di, 3
04E5  81 C7 44 A2     add di, 0xa244
04E9  1E              push ds
04EA  57              push di
04EB  8A 46 FC        mov al, byte ptr [bp - 4]
04EE  50              push ax
04EF  6A 30           push 0x30
04F1  BF 5C DD        mov di, 0xdd5c
04F4  1E              push ds
04F5  57              push di
04F6  9A 9D 03 2A 23  call far 232A:039D
loc_04FB:
04FB  C4 7E EE        les di, ptr [bp - 0x12]
04FE  26 8A 45 02     mov al, byte ptr es:[di + 2]
0502  24 F0           and al, 0xf0
0504  30 E4           xor ah, ah
0506  C1 E8 04        shr ax, 4
0509  3D 01 00        cmp ax, 1
050C  7E 20           jle 0x52e
050E  8B 56 FE        mov dx, word ptr [bp - 2]
0511  6B 46 04 3A     imul ax, word ptr [bp + 4], 0x3a
0515  C4 3E CE D7     les di, ptr [0xd7ce]
0519  03 F8           add di, ax
051B  03 FA           add di, dx
051D  26 8A 45 C5     mov al, byte ptr es:[di - 0x3b]
0521  30 E4           xor ah, ah
0523  50              push ax
0524  FF 76 FC        push word ptr [bp - 4]
0527  6A 4C           push 0x4c
0529  9A 42 15 55 1B  call far 1B55:1542
loc_052E:
052E  FF 46 FC        inc word ptr [bp - 4]
0531  8B 46 FE        mov ax, word ptr [bp - 2]
0534  3B 46 F2        cmp ax, word ptr [bp - 0xe]
0537  74 03           je 0x53c
0539  E9 21 FE        jmp 0x35d
loc_053C:
053C  C9              leave
053D  C2 02 00        ret 2

; ---- routine 0006:0540  (found by: call)
sub_0540:
0540  C8 08 00 00     enter 8, 0
0544  8B 46 08        mov ax, word ptr [bp + 8]
0547  89 46 FE        mov word ptr [bp - 2], ax
054A  8B 46 06        mov ax, word ptr [bp + 6]
054D  89 46 FC        mov word ptr [bp - 4], ax
0550  8B 46 08        mov ax, word ptr [bp + 8]
0553  03 46 06        add ax, word ptr [bp + 6]
0556  D1 E8           shr ax, 1
0558  8B F8           mov di, ax
055A  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
055E  30 E4           xor ah, ah
0560  C4 3E B6 D7     les di, ptr [0xd7b6]
0564  03 F8           add di, ax
0566  26 8A 45 FF     mov al, byte ptr es:[di - 1]
056A  88 46 F9        mov byte ptr [bp - 7], al
loc_056D:
056D  8B 7E FE        mov di, word ptr [bp - 2]
0570  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
0574  30 E4           xor ah, ah
0576  C4 3E B6 D7     les di, ptr [0xd7b6]
057A  03 F8           add di, ax
057C  26 8A 45 FF     mov al, byte ptr es:[di - 1]
0580  3A 46 F9        cmp al, byte ptr [bp - 7]
0583  73 05           jae 0x58a
0585  FF 46 FE        inc word ptr [bp - 2]
0588  EB E3           jmp 0x56d
loc_058A:
058A  8B 7E FC        mov di, word ptr [bp - 4]
058D  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
0591  30 E4           xor ah, ah
0593  C4 3E B6 D7     les di, ptr [0xd7b6]
0597  03 F8           add di, ax
0599  26 8A 45 FF     mov al, byte ptr es:[di - 1]
059D  3A 46 F9        cmp al, byte ptr [bp - 7]
05A0  76 05           jbe 0x5a7
05A2  FF 4E FC        dec word ptr [bp - 4]
05A5  EB E3           jmp 0x58a
loc_05A7:
05A7  8B 46 FE        mov ax, word ptr [bp - 2]
05AA  3B 46 FC        cmp ax, word ptr [bp - 4]
05AD  77 2A           ja 0x5d9
05AF  8B 7E FE        mov di, word ptr [bp - 2]
05B2  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
05B6  30 E4           xor ah, ah
05B8  89 46 FA        mov word ptr [bp - 6], ax
05BB  8B 7E FC        mov di, word ptr [bp - 4]
05BE  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
05C2  8B 7E FE        mov di, word ptr [bp - 2]
05C5  88 85 D5 D7     mov byte ptr [di - 0x282b], al
05C9  8A 46 FA        mov al, byte ptr [bp - 6]
05CC  8B 7E FC        mov di, word ptr [bp - 4]
05CF  88 85 D5 D7     mov byte ptr [di - 0x282b], al
05D3  FF 46 FE        inc word ptr [bp - 2]
05D6  FF 4E FC        dec word ptr [bp - 4]
loc_05D9:
05D9  8B 46 FE        mov ax, word ptr [bp - 2]
05DC  3B 46 FC        cmp ax, word ptr [bp - 4]
05DF  76 8C           jbe 0x56d
05E1  8B 46 08        mov ax, word ptr [bp + 8]
05E4  3B 46 FC        cmp ax, word ptr [bp - 4]
05E7  73 0D           jae 0x5f6
05E9  FF 76 08        push word ptr [bp + 8]
05EC  FF 76 FC        push word ptr [bp - 4]
05EF  8B 7E 04        mov di, word ptr [bp + 4]
05F2  57              push di
05F3  E8 4A FF        call 0x540
loc_05F6:
05F6  8B 46 FE        mov ax, word ptr [bp - 2]
05F9  3B 46 06        cmp ax, word ptr [bp + 6]
05FC  73 0D           jae 0x60b
05FE  FF 76 FE        push word ptr [bp - 2]
0601  FF 76 06        push word ptr [bp + 6]
0604  8B 7E 04        mov di, word ptr [bp + 4]
0607  57              push di
0608  E8 35 FF        call 0x540
loc_060B:
060B  C9              leave
060C  C2 06 00        ret 6

; ---- routine 0006:060F  (found by: call)
sub_060F:
060F  C8 02 00 00     enter 2, 0
0613  C7 46 FE 50 00  mov word ptr [bp - 2], 0x50
0618  EB 03           jmp 0x61d
loc_061A:
061A  FF 46 FE        inc word ptr [bp - 2]
loc_061D:
061D  8B 7E FE        mov di, word ptr [bp - 2]
0620  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
0624  30 E4           xor ah, ah
0626  50              push ax
0627  9A 8E 1B 55 1B  call far 1B55:1B8E
062C  08 C0           or al, al
062E  75 0C           jne 0x63c
0630  FF 76 FE        push word ptr [bp - 2]
0633  68 B0 00        push 0xb0
0636  55              push bp
0637  E8 06 FF        call 0x540
063A  EB 07           jmp 0x643
loc_063C:
063C  81 7E FE B0 00  cmp word ptr [bp - 2], 0xb0
0641  75 D7           jne 0x61a
loc_0643:
0643  C9              leave
0644  C3              ret

; ---- routine 0006:0645  (found by: call)
sub_0645:
0645  C8 00 01 00     enter 0x100, 0
0649  BF 48 71        mov di, 0x7148
064C  1E              push ds
064D  57              push di
064E  BF 5C DD        mov di, 0xdd5c
0651  1E              push ds
0652  57              push di
0653  9A 2F 05 2A 23  call far 232A:052F
0658  6A 4F           push 0x4f
065A  8D BE 00 FF     lea di, [bp - 0x100]
065E  16              push ss
065F  57              push di
0660  C4 3E D2 D7     les di, ptr [0xd7d2]
0664  26 8A 45 04     mov al, byte ptr es:[di + 4]
0668  30 E4           xor ah, ah
066A  31 D2           xor dx, dx
066C  52              push dx
066D  50              push ax
066E  9A C9 07 2A 23  call far 232A:07C9
0673  6A 19           push 0x19
0675  6A 4E           push 0x4e
0677  BF 5C DD        mov di, 0xdd5c
067A  1E              push ds
067B  57              push di
067C  9A 1B 04 2A 23  call far 232A:041B
0681  C9              leave
0682  C2 02 00        ret 2

; ---- routine 0006:0685  (found by: call)
sub_0685:
0685  C8 0A 00 00     enter 0xa, 0
0689  C4 3E D2 D7     les di, ptr [0xd7d2]
068D  89 7E F6        mov word ptr [bp - 0xa], di
0690  8C 46 F8        mov word ptr [bp - 8], es
0693  8B 7E 04        mov di, word ptr [bp + 4]
0696  36 C7 45 F8 01 00 mov word ptr ss:[di - 8], 1
069C  36 C6 45 F3 01  mov byte ptr ss:[di - 0xd], 1
06A1  36 80 7D 06 04  cmp byte ptr ss:[di + 6], 4
06A6  75 37           jne 0x6df
06A8  C4 7E F6        les di, ptr [bp - 0xa]
06AB  26 8A 05        mov al, byte ptr es:[di]
06AE  30 E4           xor ah, ah
06B0  40              inc ax
06B1  8B F0           mov si, ax
06B3  D1 E0           shl ax, 1
06B5  01 F0           add ax, si
06B7  8B D0           mov dx, ax
06B9  26 8A 45 04     mov al, byte ptr es:[di + 4]
06BD  30 E4           xor ah, ah
06BF  8B F8           mov di, ax
06C1  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
06C5  30 E4           xor ah, ah
06C7  69 C0 AE 00     imul ax, ax, 0xae
06CB  C4 3E CA D7     les di, ptr [0xd7ca]
06CF  03 F8           add di, ax
06D1  03 FA           add di, dx
06D3  26 8A 85 50 FF  mov al, byte ptr es:[di - 0xb0]
06D8  30 E4           xor ah, ah
06DA  89 46 FE        mov word ptr [bp - 2], ax
06DD  EB 14           jmp 0x6f3
loc_06DF:
06DF  C4 7E F6        les di, ptr [bp - 0xa]
06E2  26 8A 45 04     mov al, byte ptr es:[di + 4]
06E6  30 E4           xor ah, ah
06E8  8B F8           mov di, ax
06EA  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
06EE  30 E4           xor ah, ah
06F0  89 46 FE        mov word ptr [bp - 2], ax
loc_06F3:
06F3  83 7E FE 00     cmp word ptr [bp - 2], 0
06F7  75 0B           jne 0x704
06F9  8B 7E 04        mov di, word ptr [bp + 4]
06FC  36 C7 45 F8 11 00 mov word ptr ss:[di - 8], 0x11
0702  EB 55           jmp 0x759
loc_0704:
0704  31 C0           xor ax, ax
0706  89 46 FC        mov word ptr [bp - 4], ax
0709  C7 46 FA 01 00  mov word ptr [bp - 6], 1
070E  EB 03           jmp 0x713
loc_0710:
0710  FF 46 FA        inc word ptr [bp - 6]
loc_0713:
0713  8B 7E FA        mov di, word ptr [bp - 6]
0716  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
071A  30 E4           xor ah, ah
071C  3B 46 FE        cmp ax, word ptr [bp - 2]
071F  75 06           jne 0x727
0721  8B 46 FA        mov ax, word ptr [bp - 6]
0724  89 46 FC        mov word ptr [bp - 4], ax
loc_0727:
0727  81 7E FA B0 00  cmp word ptr [bp - 6], 0xb0
072C  75 E2           jne 0x710
072E  83 7E FC 00     cmp word ptr [bp - 4], 0
0732  75 02           jne 0x736
0734  EB 23           jmp 0x759
loc_0736:
0736  8B 46 FC        mov ax, word ptr [bp - 4]
0739  48              dec ax
073A  C1 E8 04        shr ax, 4
073D  C1 E0 04        shl ax, 4
0740  40              inc ax
0741  8B 7E 04        mov di, word ptr [bp + 4]
0744  36 89 45 F8     mov word ptr ss:[di - 8], ax
0748  8B 46 FC        mov ax, word ptr [bp - 4]
074B  48              dec ax
074C  31 D2           xor dx, dx
074E  B9 10 00        mov cx, 0x10
0751  F7 F1           div cx
0753  92              xchg dx, ax
0754  40              inc ax
0755  36 88 45 F3     mov byte ptr ss:[di - 0xd], al
loc_0759:
0759  C9              leave
075A  C2 02 00        ret 2

; ---- routine 0006:075D  (found by: call)
sub_075D:
075D  C8 04 00 00     enter 4, 0
0761  C4 3E D2 D7     les di, ptr [0xd7d2]
0765  89 7E FC        mov word ptr [bp - 4], di
0768  8C 46 FE        mov word ptr [bp - 2], es
076B  26 80 3D 10     cmp byte ptr es:[di], 0x10
076F  73 07           jae 0x778
0771  C6 06 E2 00 01  mov byte ptr [0xe2], 1
0776  EB 25           jmp 0x79d
loc_0778:
0778  C4 7E FC        les di, ptr [bp - 4]
077B  26 80 3D 20     cmp byte ptr es:[di], 0x20
077F  73 07           jae 0x788
0781  C6 06 E2 00 11  mov byte ptr [0xe2], 0x11
0786  EB 15           jmp 0x79d
loc_0788:
0788  C4 7E FC        les di, ptr [bp - 4]
078B  26 80 3D 30     cmp byte ptr es:[di], 0x30
078F  73 07           jae 0x798
0791  C6 06 E2 00 21  mov byte ptr [0xe2], 0x21
0796  EB 05           jmp 0x79d
loc_0798:
0798  C6 06 E2 00 31  mov byte ptr [0xe2], 0x31
loc_079D:
079D  C9              leave
079E  C2 02 00        ret 2

; ---- routine 0006:07A1  (found by: call)
sub_07A1:
07A1  C8 BE 01 00     enter 0x1be, 0
07A5  BF D6 D7        mov di, 0xd7d6
07A8  1E              push ds
07A9  57              push di
07AA  8D BE 42 FF     lea di, [bp - 0xbe]
07AE  16              push ss
07AF  57              push di
07B0  68 B0 00        push 0xb0
07B3  9A C2 01 BC 24  call far 24BC:01C2
07B8  E8 54 FE        call 0x60f
07BB  C6 46 FD 00     mov byte ptr [bp - 3], 0
07BF  55              push bp
07C0  E8 C2 FE        call 0x685
07C3  80 7E 06 02     cmp byte ptr [bp + 6], 2
07C7  75 04           jne 0x7cd
07C9  55              push bp
07CA  E8 90 FF        call 0x75d
loc_07CD:
07CD  8A 46 06        mov al, byte ptr [bp + 6]
07D0  3C 01           cmp al, 1
07D2  76 0C           jbe 0x7e0
07D4  3C 04           cmp al, 4
07D6  72 04           jb 0x7dc
07D8  3C 05           cmp al, 5
07DA  76 04           jbe 0x7e0
loc_07DC:
07DC  B0 00           mov al, 0
07DE  EB 02           jmp 0x7e2
loc_07E0:
07E0  B0 01           mov al, 1
loc_07E2:
07E2  88 46 FE        mov byte ptr [bp - 2], al
07E5  B0 00           mov al, 0
07E7  08 C0           or al, al
07E9  75 13           jne 0x7fe
07EB  8A 46 06        mov al, byte ptr [bp + 6]
07EE  3C 01           cmp al, 1
07F0  74 0C           je 0x7fe
07F2  3C 04           cmp al, 4
07F4  72 04           jb 0x7fa
07F6  3C 05           cmp al, 5
07F8  76 04           jbe 0x7fe
loc_07FA:
07FA  B0 00           mov al, 0
07FC  EB 02           jmp 0x800
loc_07FE:
07FE  B0 01           mov al, 1
loc_0800:
0800  88 46 FC        mov byte ptr [bp - 4], al
loc_0803:
0803  FF 76 F8        push word ptr [bp - 8]
0806  9A EE 49 EF 01  call far 01EF:49EE
080B  8A 46 F3        mov al, byte ptr [bp - 0xd]
080E  30 E4           xor ah, ah
0810  03 46 F8        add ax, word ptr [bp - 8]
0813  48              dec ax
0814  8B F8           mov di, ax
0816  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
081A  30 E4           xor ah, ah
081C  89 46 F6        mov word ptr [bp - 0xa], ax
081F  80 3E 06 86 00  cmp byte ptr [0x8606], 0
0824  75 20           jne 0x846
0826  80 7E 06 05     cmp byte ptr [bp + 6], 5
082A  75 1A           jne 0x846
082C  8A 46 F3        mov al, byte ptr [bp - 0xd]
082F  30 E4           xor ah, ah
0831  03 46 F8        add ax, word ptr [bp - 8]
0834  48              dec ax
0835  3D 51 00        cmp ax, 0x51
0838  73 0C           jae 0x846
083A  FF 76 F6        push word ptr [bp - 0xa]
083D  9A 7A 0E 55 1B  call far 1B55:0E7A
0842  08 C0           or al, al
0844  74 04           je 0x84a
loc_0846:
0846  B0 00           mov al, 0
0848  EB 02           jmp 0x84c
loc_084A:
084A  B0 01           mov al, 1
loc_084C:
084C  88 46 FB        mov byte ptr [bp - 5], al
084F  80 7E 06 02     cmp byte ptr [bp + 6], 2
0853  75 08           jne 0x85d
0855  FF 76 F6        push word ptr [bp - 0xa]
0858  E8 6F FA        call 0x2ca
085B  EB 38           jmp 0x895
loc_085D:
085D  80 7E 06 03     cmp byte ptr [bp + 6], 3
0861  75 0A           jne 0x86d
0863  FF 76 F6        push word ptr [bp - 0xa]
0866  9A 98 1E E8 06  call far 06E8:1E98
086B  EB 28           jmp 0x895
loc_086D:
086D  80 7E FE 00     cmp byte ptr [bp - 2], 0
0871  74 22           je 0x895
0873  FF 76 F6        push word ptr [bp - 0xa]
0876  B0 00           mov al, 0
0878  08 C0           or al, al
087A  74 07           je 0x883
087C  80 3E 90 0D 03  cmp byte ptr [0xd90], 3
0881  75 0A           jne 0x88d
loc_0883:
0883  80 7E 06 00     cmp byte ptr [bp + 6], 0
0887  74 04           je 0x88d
0889  B0 00           mov al, 0
088B  EB 02           jmp 0x88f
loc_088D:
088D  B0 01           mov al, 1
loc_088F:
088F  50              push ax
0890  9A 02 97 B9 0A  call far 0AB9:9702
loc_0895:
0895  80 7E 06 00     cmp byte ptr [bp + 6], 0
0899  75 06           jne 0x8a1
089B  55              push bp
089C  E8 A6 FD        call 0x645
089F  EB 15           jmp 0x8b6
loc_08A1:
08A1  80 7E FB 00     cmp byte ptr [bp - 5], 0
08A5  74 0F           je 0x8b6
08A7  BF A8 63        mov di, 0x63a8
08AA  1E              push ds
08AB  57              push di
08AC  BF 5C DD        mov di, 0xdd5c
08AF  1E              push ds
08B0  57              push di
08B1  9A 2F 05 2A 23  call far 232A:052F
loc_08B6:
08B6  8A 46 F3        mov al, byte ptr [bp - 0xd]
08B9  30 E4           xor ah, ah
08BB  05 04 00        add ax, 4
08BE  50              push ax
08BF  6A 02           push 2
08C1  6A 11           push 0x11
08C3  9A 03 02 2A 23  call far 232A:0203
08C8  C4 3E 5C DD     les di, ptr [0xdd5c]
08CC  06              push es
08CD  57              push di
08CE  C4 3E 58 DD     les di, ptr [0xdd58]
08D2  06              push es
08D3  57              push di
08D4  68 A0 0F        push 0xfa0
08D7  9A 12 0A C9 26  call far 26C9:0A12
08DC  9A 9B 09 2A 23  call far 232A:099B
08E1  B0 01           mov al, 1
08E3  08 C0           or al, al
08E5  74 07           je 0x8ee
08E7  80 3E 88 DE 01  cmp byte ptr [0xde88], 1
08EC  74 04           je 0x8f2
loc_08EE:
08EE  B0 00           mov al, 0
08F0  EB 02           jmp 0x8f4
loc_08F2:
08F2  B0 01           mov al, 1
loc_08F4:
08F4  88 46 FF        mov byte ptr [bp - 1], al
08F7  80 7E FD 00     cmp byte ptr [bp - 3], 0
08FB  74 0B           je 0x908
08FD  80 3E 88 DE 01  cmp byte ptr [0xde88], 1
0902  75 04           jne 0x908
0904  C6 46 FD 00     mov byte ptr [bp - 3], 0
loc_0908:
0908  A0 88 DE        mov al, byte ptr [0xde88]
090B  50              push ax
090C  9A 86 19 C9 26  call far 26C9:1986
0911  3C 0B           cmp al, 0xb
0913  75 1B           jne 0x930
0915  80 7E 06 02     cmp byte ptr [bp + 6], 2
0919  74 06           je 0x921
091B  C6 46 F3 01     mov byte ptr [bp - 0xd], 1
091F  EB 0C           jmp 0x92d
loc_0921:
0921  80 3E E2 00 01  cmp byte ptr [0xe2], 1
0926  74 05           je 0x92d
0928  80 2E E2 00 10  sub byte ptr [0xe2], 0x10
loc_092D:
092D  E9 4F 01        jmp 0xa7f
loc_0930:
0930  3C 0C           cmp al, 0xc
0932  75 1B           jne 0x94f
0934  80 7E 06 02     cmp byte ptr [bp + 6], 2
0938  74 06           je 0x940
093A  C6 46 F3 10     mov byte ptr [bp - 0xd], 0x10
093E  EB 0C           jmp 0x94c
loc_0940:
0940  80 3E E2 00 31  cmp byte ptr [0xe2], 0x31
0945  74 05           je 0x94c
0947  80 06 E2 00 10  add byte ptr [0xe2], 0x10
loc_094C:
094C  E9 30 01        jmp 0xa7f
loc_094F:
094F  3C 05           cmp al, 5
0951  74 04           je 0x957
0953  3C 06           cmp al, 6
0955  75 0F           jne 0x966
loc_0957:
0957  8D 7E F3        lea di, [bp - 0xd]
095A  16              push ss
095B  57              push di
095C  6A 10           push 0x10
095E  9A C4 0E 2A 23  call far 232A:0EC4
0963  E9 19 01        jmp 0xa7f
loc_0966:
0966  3C 07           cmp al, 7
0968  75 1E           jne 0x988
096A  83 7E F8 01     cmp word ptr [bp - 8], 1
096E  74 06           je 0x976
0970  83 6E F8 10     sub word ptr [bp - 8], 0x10
0974  EB 0F           jmp 0x985
loc_0976:
0976  8A 46 FC        mov al, byte ptr [bp - 4]
0979  98              cwde
097A  8B F8           mov di, ax
097C  8A 85 02 00     mov al, byte ptr [di + 2]
0980  30 E4           xor ah, ah
0982  89 46 F8        mov word ptr [bp - 8], ax
loc_0985:
0985  E9 F7 00        jmp 0xa7f
loc_0988:
0988  3C 08           cmp al, 8
098A  75 1F           jne 0x9ab
098C  8A 46 FC        mov al, byte ptr [bp - 4]
098F  98              cwde
0990  8B F8           mov di, ax
0992  8A 85 02 00     mov al, byte ptr [di + 2]
0996  30 E4           xor ah, ah
0998  3B 46 F8        cmp ax, word ptr [bp - 8]
099B  74 06           je 0x9a3
099D  83 46 F8 10     add word ptr [bp - 8], 0x10
09A1  EB 05           jmp 0x9a8
loc_09A3:
09A3  C7 46 F8 01 00  mov word ptr [bp - 8], 1
loc_09A8:
09A8  E9 D4 00        jmp 0xa7f
loc_09AB:
09AB  3C 09           cmp al, 9
09AD  75 08           jne 0x9b7
09AF  C7 46 F8 01 00  mov word ptr [bp - 8], 1
09B4  E9 C8 00        jmp 0xa7f
loc_09B7:
09B7  3C 0A           cmp al, 0xa
09B9  75 12           jne 0x9cd
09BB  8A 46 FC        mov al, byte ptr [bp - 4]
09BE  98              cwde
09BF  8B F8           mov di, ax
09C1  8A 85 02 00     mov al, byte ptr [di + 2]
09C5  30 E4           xor ah, ah
09C7  89 46 F8        mov word ptr [bp - 8], ax
09CA  E9 B2 00        jmp 0xa7f
loc_09CD:
09CD  3C 02           cmp al, 2
09CF  75 45           jne 0xa16
09D1  80 7E 06 00     cmp byte ptr [bp + 6], 0
09D5  75 0D           jne 0x9e4
09D7  FF 76 F6        push word ptr [bp - 0xa]
09DA  8D 7E FF        lea di, [bp - 1]
09DD  16              push ss
09DE  57              push di
09DF  E8 67 F7        call 0x149
09E2  EB 30           jmp 0xa14
loc_09E4:
09E4  80 7E 06 03     cmp byte ptr [bp + 6], 3
09E8  75 06           jne 0x9f0
09EA  C6 46 FF 01     mov byte ptr [bp - 1], 1
09EE  EB 24           jmp 0xa14
loc_09F0:
09F0  80 7E 06 02     cmp byte ptr [bp + 6], 2
09F4  75 0A           jne 0xa00
09F6  FF 76 F6        push word ptr [bp - 0xa]
09F9  9A 19 41 55 1B  call far 1B55:4119
09FE  EB 14           jmp 0xa14
loc_0A00:
0A00  80 7E FB 00     cmp byte ptr [bp - 5], 0
0A04  74 0E           je 0xa14
0A06  FF 76 F6        push word ptr [bp - 0xa]
0A09  E8 C4 F7        call 0x1d0
0A0C  08 C0           or al, al
0A0E  74 04           je 0xa14
0A10  C6 46 FF 01     mov byte ptr [bp - 1], 1
loc_0A14:
0A14  EB 69           jmp 0xa7f
loc_0A16:
0A16  3C 0D           cmp al, 0xd
0A18  75 0D           jne 0xa27
0A1A  80 7E FE 00     cmp byte ptr [bp - 2], 0
0A1E  74 05           je 0xa25
0A20  9A 08 31 55 1B  call far 1B55:3108
loc_0A25:
0A25  EB 58           jmp 0xa7f
loc_0A27:
0A27  3C 04           cmp al, 4
0A29  75 05           jne 0xa30
0A2B  E8 E4 F6        call 0x112
0A2E  EB 4F           jmp 0xa7f
loc_0A30:
0A30  3C 20           cmp al, 0x20
0A32  75 29           jne 0xa5d
0A34  80 7E 06 00     cmp byte ptr [bp + 6], 0
0A38  75 19           jne 0xa53
0A3A  6B 46 F6 3E     imul ax, word ptr [bp - 0xa], 0x3e
0A3E  C4 3E C2 D7     les di, ptr [0xd7c2]
0A42  03 F8           add di, ax
0A44  81 C7 C2 FF     add di, 0xffc2
0A48  06              push es
0A49  57              push di
0A4A  6A 00           push 0
0A4C  9A 43 AD B9 0A  call far 0AB9:AD43
0A51  EB 08           jmp 0xa5b
loc_0A53:
0A53  FF 76 F6        push word ptr [bp - 0xa]
0A56  9A 98 0F EF 01  call far 01EF:0F98
loc_0A5B:
0A5B  EB 22           jmp 0xa7f
loc_0A5D:
0A5D  3C 53           cmp al, 0x53
0A5F  75 02           jne 0xa63
0A61  EB 1C           jmp 0xa7f
loc_0A63:
0A63  3C 4D           cmp al, 0x4d
0A65  75 02           jne 0xa69
0A67  EB 16           jmp 0xa7f
loc_0A69:
0A69  3C 59           cmp al, 0x59
0A6B  75 02           jne 0xa6f
0A6D  EB 10           jmp 0xa7f
loc_0A6F:
0A6F  3C D2           cmp al, 0xd2
0A71  75 02           jne 0xa75
0A73  EB 0A           jmp 0xa7f
loc_0A75:
0A75  3C CB           cmp al, 0xcb
0A77  75 02           jne 0xa7b
0A79  EB 04           jmp 0xa7f
loc_0A7B:
0A7B  3C CF           cmp al, 0xcf
0A7D  75 00           jne 0xa7f
loc_0A7F:
0A7F  80 7E FF 00     cmp byte ptr [bp - 1], 0
0A83  75 03           jne 0xa88
0A85  E9 7B FD        jmp 0x803
loc_0A88:
0A88  8D BE 42 FF     lea di, [bp - 0xbe]
0A8C  16              push ss
0A8D  57              push di
0A8E  BF D6 D7        mov di, 0xd7d6
0A91  1E              push ds
0A92  57              push di
0A93  68 B0 00        push 0xb0
0A96  9A C2 01 BC 24  call far 24BC:01C2
0A9B  C9              leave
0A9C  CA 02 00        retf 2
; data (not reached as code), 1 bytes
0A9F                  db 00   ; .

