; 1-0.EXE (One-Nil 96), code segment 24BC (image offsets 24BC0..26B7F), part 1 of 4
; packed 1-0.EXE sha256 89ff9c5f238f24e81a0c2440a46cdd8997280a65fc3cc3d97cb974f55280a80a (LZEXE 0.91)
; unpacked (tools/static/unlzexe.py) sha256 887ed2a92767950e5309b2052409f875668605939b69e00737aa3047022b9f51
; tool: capstone 5.0.9 (pip package; core library 5.0.1280) (CS_ARCH_X86, CS_MODE_16), recursive descent from the entry point, far calls and near calls/jumps, then routine prologues (55 89 E5 / 55 8B EC / C8 iw 00) in what remains; tools/static/listing.py
; addresses are SEGMENT:OFFSET with SEGMENT the image paragraph before relocation; image offset = SEGMENT*16+OFFSET

; ---- routine 24BC:0000  (found by: far)
sub_0000:
0000  55              push bp
0001  89 E5           mov bp, sp
0003  1E              push ds
0004  FC              cld
0005  C5 76 06        lds si, ptr [bp + 6]
0008  C4 7E 0A        les di, ptr [bp + 0xa]
000B  AD              lodsw ax, word ptr [si]
000C  48              dec ax
000D  D1 E0           shl ax, 1
000F  01 C7           add di, ax
0011  33 D2           xor dx, dx
0013  33 C0           xor ax, ax
0015  AC              lodsb al, byte ptr [si]
0016  8B D8           mov bx, ax
0018  AC              lodsb al, byte ptr [si]
0019  89 C1           mov cx, ax
001B  D1 E1           shl cx, 1
001D  55              push bp
loc_001E:
001E  8B EF           mov bp, di
0020  03 E9           add bp, cx
loc_0022:
0022  39 EF           cmp di, bp
0024  74 0E           je 0x34
loc_0026:
0026  AC              lodsb al, byte ptr [si]
0027  3C FF           cmp al, 0xff
0029  74 17           je 0x42
002B  3C 00           cmp al, 0
002D  74 18           je 0x47
002F  AB              stosw word ptr es:[di], ax
0030  8B D0           mov dx, ax
0032  EB EE           jmp 0x22
loc_0034:
0034  4B              dec bx
0035  83 FB 00        cmp bx, 0
0038  74 1A           je 0x54
003A  29 CF           sub di, cx
003C  81 C7 A0 00     add di, 0xa0
0040  EB DC           jmp 0x1e
loc_0042:
0042  AC              lodsb al, byte ptr [si]
0043  88 C4           mov ah, al
0045  EB DF           jmp 0x26
loc_0047:
0047  51              push cx
0048  AC              lodsb al, byte ptr [si]
0049  33 C9           xor cx, cx
004B  88 C1           mov cl, al
004D  8B C2           mov ax, dx
004F  F3 AB           rep stosw word ptr es:[di], ax
0051  59              pop cx
0052  EB CE           jmp 0x22
loc_0054:
0054  5D              pop bp
0055  1F              pop ds
0056  C9              leave
0057  CA 08 00        retf 8

; ---- routine 24BC:005A  (found by: call, far)
sub_005A:
005A  C8 00 01 00     enter 0x100, 0
005E  8C D3           mov bx, ss
0060  8E C3           mov es, bx
0062  8C DB           mov bx, ds
0064  FC              cld
0065  8D BE 00 FF     lea di, [bp - 0x100]
0069  C5 76 06        lds si, ptr [bp + 6]
006C  AC              lodsb al, byte ptr [si]
006D  AA              stosb byte ptr es:[di], al
006E  91              xchg cx, ax
006F  30 ED           xor ch, ch
0071  F3 A4           rep movsb byte ptr es:[di], byte ptr [si]
0073  8E DB           mov ds, bx
0075  1E              push ds
0076  C5 76 06        lds si, ptr [bp + 6]
0079  C4 7E 0A        les di, ptr [bp + 0xa]
007C  FC              cld
007D  AC              lodsb al, byte ptr [si]
007E  AA              stosb byte ptr es:[di], al
007F  88 C1           mov cl, al
0081  32 ED           xor ch, ch
0083  E3 0E           jcxz 0x93
0085  AC              lodsb al, byte ptr [si]
0086  3C 61           cmp al, 0x61
0088  72 06           jb 0x90
008A  3C 7A           cmp al, 0x7a
008C  77 02           ja 0x90
008E  2C 20           sub al, 0x20
loc_0090:
0090  AA              stosb byte ptr es:[di], al
0091  E2 F2           loop 0x85
loc_0093:
0093  1F              pop ds
0094  C9              leave
0095  CA 04 00        retf 4

; ---- routine 24BC:0098  (found by: call)
sub_0098:
0098  C8 52 00 00     enter 0x52, 0
009C  8C D3           mov bx, ss
009E  8E C3           mov es, bx
00A0  8C DB           mov bx, ds
00A2  FC              cld
00A3  8D 7E AE        lea di, [bp - 0x52]
00A6  C5 76 08        lds si, ptr [bp + 8]
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
00B8  1E              push ds
00B9  C5 76 08        lds si, ptr [bp + 8]
00BC  C4 7E 0C        les di, ptr [bp + 0xc]
00BF  8A 4E 06        mov cl, byte ptr [bp + 6]
00C2  FC              cld
00C3  30 ED           xor ch, ch
00C5  30 D2           xor dl, dl
00C7  88 C8           mov al, cl
00C9  AA              stosb byte ptr es:[di], al
00CA  AC              lodsb al, byte ptr [si]
00CB  38 C1           cmp cl, al
00CD  72 06           jb 0xd5
00CF  88 CA           mov dl, cl
00D1  88 C1           mov cl, al
00D3  28 C2           sub dl, al
loc_00D5:
00D5  F3 A4           rep movsb byte ptr es:[di], byte ptr [si]
00D7  88 D1           mov cl, dl
00D9  B0 20           mov al, 0x20
00DB  F3 AA           rep stosb byte ptr es:[di], al
00DD  1F              pop ds
00DE  C9              leave
00DF  CA 06 00        retf 6
; data (not reached as code), 2 bytes
00E2                  db 01 20   ; . 

; ---- routine 24BC:00E4  (found by: call)
sub_00E4:
00E4  C8 A4 01 00     enter 0x1a4, 0
00E8  8C D3           mov bx, ss
00EA  8E C3           mov es, bx
00EC  8C DB           mov bx, ds
00EE  FC              cld
00EF  8D 7E AE        lea di, [bp - 0x52]
00F2  C5 76 08        lds si, ptr [bp + 8]
00F5  AC              lodsb al, byte ptr [si]
00F6  3C 50           cmp al, 0x50
00F8  72 02           jb 0xfc
00FA  B0 50           mov al, 0x50
loc_00FC:
00FC  AA              stosb byte ptr es:[di], al
00FD  91              xchg cx, ax
00FE  30 ED           xor ch, ch
0100  F3 A4           rep movsb byte ptr es:[di], byte ptr [si]
0102  8E DB           mov ds, bx
0104  8A 46 AE        mov al, byte ptr [bp - 0x52]
0107  30 E4           xor ah, ah
0109  8B D0           mov dx, ax
010B  8A 46 06        mov al, byte ptr [bp + 6]
010E  30 E4           xor ah, ah
0110  2B C2           sub ax, dx
0112  3D 02 00        cmp ax, 2
0115  7D 07           jge 0x11e
0117  C6 86 5C FF 00  mov byte ptr [bp - 0xa4], 0
011C  EB 2A           jmp 0x148
loc_011E:
011E  8D BE 5C FE     lea di, [bp - 0x1a4]
0122  16              push ss
0123  57              push di
0124  6A 20           push 0x20
0126  8A 46 AE        mov al, byte ptr [bp - 0x52]
0129  30 E4           xor ah, ah
012B  8B D0           mov dx, ax
012D  8A 46 06        mov al, byte ptr [bp + 6]
0130  30 E4           xor ah, ah
0132  2B C2           sub ax, dx
0134  D1 E8           shr ax, 1
0136  50              push ax
0137  0E              push cs
0138  E8 F9 03        call 0x534
013B  8D BE 5C FF     lea di, [bp - 0xa4]
013F  16              push ss
0140  57              push di
0141  6A 50           push 0x50
0143  9A 6D 0B C9 26  call far 26C9:0B6D
loc_0148:
0148  8D BE 5C FE     lea di, [bp - 0x1a4]
014C  16              push ss
014D  57              push di
014E  8D BE 5C FF     lea di, [bp - 0xa4]
0152  16              push ss
0153  57              push di
0154  9A 53 0B C9 26  call far 26C9:0B53
0159  8D 7E AE        lea di, [bp - 0x52]
015C  16              push ss
015D  57              push di
015E  9A D2 0B C9 26  call far 26C9:0BD2
0163  8D BE 5C FF     lea di, [bp - 0xa4]
0167  16              push ss
0168  57              push di
0169  9A D2 0B C9 26  call far 26C9:0BD2
016E  8D BE 5C FF     lea di, [bp - 0xa4]
0172  16              push ss
0173  57              push di
0174  6A 50           push 0x50
0176  9A 6D 0B C9 26  call far 26C9:0B6D
017B  8A 86 5C FF     mov al, byte ptr [bp - 0xa4]
017F  3A 46 06        cmp al, byte ptr [bp + 6]
0182  73 28           jae 0x1ac
0184  8D BE 5C FE     lea di, [bp - 0x1a4]
0188  16              push ss
0189  57              push di
018A  8D BE 5C FF     lea di, [bp - 0xa4]
018E  16              push ss
018F  57              push di
0190  9A 53 0B C9 26  call far 26C9:0B53
0195  BF E2 00        mov di, 0xe2
0198  0E              push cs
0199  57              push di
019A  9A D2 0B C9 26  call far 26C9:0BD2
019F  8D BE 5C FF     lea di, [bp - 0xa4]
01A3  16              push ss
01A4  57              push di
01A5  6A 50           push 0x50
01A7  9A 6D 0B C9 26  call far 26C9:0B6D
loc_01AC:
01AC  8D BE 5C FF     lea di, [bp - 0xa4]
01B0  16              push ss
01B1  57              push di
01B2  C4 7E 0C        les di, ptr [bp + 0xc]
01B5  06              push es
01B6  57              push di
01B7  6A 50           push 0x50
01B9  9A 6D 0B C9 26  call far 26C9:0B6D
01BE  C9              leave
01BF  CA 06 00        retf 6

; ---- routine 24BC:01C2  (found by: call, far)
sub_01C2:
01C2  55              push bp
01C3  89 E5           mov bp, sp
01C5  1E              push ds
01C6  C5 B6 0C 00     lds si, ptr [bp + 0xc]
01CA  C4 BE 08 00     les di, ptr [bp + 8]
01CE  8B 86 06 00     mov ax, word ptr [bp + 6]
01D2  BA 00 00        mov dx, 0
01D5  BB 02 00        mov bx, 2
01D8  F7 F3           div bx
01DA  8B C8           mov cx, ax
01DC  8B 86 06 00     mov ax, word ptr [bp + 6]
01E0  FC              cld
01E1  3B F7           cmp si, di
01E3  77 11           ja 0x1f6
01E5  FD              std
01E6  03 F0           add si, ax
01E8  4E              dec si
01E9  03 F8           add di, ax
01EB  4F              dec di
01EC  80 FA 00        cmp dl, 0
01EF  74 01           je 0x1f2
01F1  A4              movsb byte ptr es:[di], byte ptr [si]
loc_01F2:
01F2  4E              dec si
01F3  4F              dec di
01F4  EB 06           jmp 0x1fc
loc_01F6:
01F6  80 FA 00        cmp dl, 0
01F9  74 01           je 0x1fc
01FB  A4              movsb byte ptr es:[di], byte ptr [si]
loc_01FC:
01FC  F3 A5           rep movsw word ptr es:[di], word ptr [si]
01FE  1F              pop ds
01FF  C9              leave
0200  CA 0A 00        retf 0xa

; ---- routine 24BC:0203  (found by: far)
sub_0203:
0203  55              push bp
0204  89 E5           mov bp, sp
0206  1E              push ds
0207  C5 B6 0C 00     lds si, ptr [bp + 0xc]
020B  C4 BE 08 00     les di, ptr [bp + 8]
020F  8B 8E 06 00     mov cx, word ptr [bp + 6]
0213  FC              cld
0214  26 8A 05        mov al, byte ptr es:[di]
0217  86 04           xchg byte ptr [si], al
0219  46              inc si
021A  AA              stosb byte ptr es:[di], al
021B  E2 F7           loop 0x214
021D  1F              pop ds
021E  C9              leave
021F  CA 0A 00        retf 0xa

; ---- routine 24BC:0222  (found by: call, far)
sub_0222:
0222  55              push bp
0223  89 E5           mov bp, sp
0225  8B 8E 08 00     mov cx, word ptr [bp + 8]
0229  51              push cx
022A  D1 E9           shr cx, 1
022C  FC              cld
022D  C4 BE 0A 00     les di, ptr [bp + 0xa]
0231  8B 86 06 00     mov ax, word ptr [bp + 6]
0235  88 C4           mov ah, al
0237  F3 AB           rep stosw word ptr es:[di], ax
0239  59              pop cx
023A  83 E1 01        and cx, 1
023D  F3 AA           rep stosb byte ptr es:[di], al
023F  C9              leave
0240  CA 08 00        retf 8

; ---- routine 24BC:0243  (found by: call, far)
sub_0243:
0243  55              push bp
0244  89 E5           mov bp, sp
0246  C4 BE 0A 00     les di, ptr [bp + 0xa]
024A  8B 8E 08 00     mov cx, word ptr [bp + 8]
024E  8B 86 06 00     mov ax, word ptr [bp + 6]
0252  FC              cld
0253  F2 AB           repne stosw word ptr es:[di], ax
0255  C9              leave
0256  CA 08 00        retf 8

; ---- routine 24BC:0259  (found by: call, far)
sub_0259:
0259  C8 02 00 00     enter 2, 0
025D  8B 46 08        mov ax, word ptr [bp + 8]
0260  48              dec ax
0261  8B D0           mov dx, ax
0263  8B 46 06        mov ax, word ptr [bp + 6]
0266  8B CA           mov cx, dx
0268  D3 E8           shr ax, cl
026A  25 01 00        and ax, 1
026D  88 46 FF        mov byte ptr [bp - 1], al
0270  8A 46 FF        mov al, byte ptr [bp - 1]
0273  C9              leave
0274  CA 04 00        retf 4

; ---- routine 24BC:0277  (found by: call, far)
sub_0277:
0277  55              push bp
0278  89 E5           mov bp, sp
027A  1E              push ds
027B  C5 B6 0A 00     lds si, ptr [bp + 0xa]
027F  C4 BE 06 00     les di, ptr [bp + 6]
0283  FC              cld
0284  33 C9           xor cx, cx
0286  AC              lodsb al, byte ptr [si]
0287  88 C1           mov cl, al
0289  E3 04           jcxz 0x28f
028B  A4              movsb byte ptr es:[di], byte ptr [si]
028C  47              inc di
028D  E2 FC           loop 0x28b
loc_028F:
028F  1F              pop ds
0290  C9              leave
0291  CA 08 00        retf 8

; ---- routine 24BC:0294  (found by: far)
sub_0294:
0294  55              push bp
0295  89 E5           mov bp, sp
0297  1E              push ds
0298  C5 B6 0A 00     lds si, ptr [bp + 0xa]
029C  C4 BE 06 00     les di, ptr [bp + 6]
02A0  33 C9           xor cx, cx
02A2  8A 0C           mov cl, byte ptr [si]
02A4  E3 07           jcxz 0x2ad
02A6  01 CE           add si, cx
02A8  FD              std
02A9  A4              movsb byte ptr es:[di], byte ptr [si]
02AA  4F              dec di
02AB  E2 FC           loop 0x2a9
loc_02AD:
02AD  1F              pop ds
02AE  C9              leave
02AF  CA 08 00        retf 8

; ---- routine 24BC:02B2  (found by: call)
sub_02B2:
02B2  C8 00 01 00     enter 0x100, 0
02B6  8C D3           mov bx, ss
02B8  8E C3           mov es, bx
02BA  8C DB           mov bx, ds
02BC  FC              cld
02BD  8D BE 00 FF     lea di, [bp - 0x100]
02C1  C5 76 0A        lds si, ptr [bp + 0xa]
02C4  AC              lodsb al, byte ptr [si]
02C5  AA              stosb byte ptr es:[di], al
02C6  91              xchg cx, ax
02C7  30 ED           xor ch, ch
02C9  F3 A4           rep movsb byte ptr es:[di], byte ptr [si]
02CB  8E DB           mov ds, bx
02CD  83 3E 72 F8 19  cmp word ptr [0xf872], 0x19
02D2  76 38           jbe 0x30c
02D4  8D BE 00 FF     lea di, [bp - 0x100]
02D8  16              push ss
02D9  57              push di
02DA  8B 46 08        mov ax, word ptr [bp + 8]
02DD  25 0F 00        and ax, 0xf
02E0  50              push ax
02E1  8B 46 08        mov ax, word ptr [bp + 8]
02E4  C1 E8 04        shr ax, 4
02E7  50              push ax
02E8  A0 E8 E0        mov al, byte ptr [0xe0e8]
02EB  30 E4           xor ah, ah
02ED  8B C8           mov cx, ax
02EF  8B 46 06        mov ax, word ptr [bp + 6]
02F2  31 D2           xor dx, dx
02F4  F7 36 DC E0     div word ptr [0xe0dc]
02F8  F7 E1           mul cx
02FA  50              push ax
02FB  8B 46 06        mov ax, word ptr [bp + 6]
02FE  31 D2           xor dx, dx
0300  F7 36 DC E0     div word ptr [0xe0dc]
0304  92              xchg dx, ax
0305  50              push ax
0306  0E              push cs
0307  E8 E2 19        call 0x1cec
030A  EB 3B           jmp 0x347
loc_030C:
030C  8B 46 06        mov ax, word ptr [bp + 6]
030F  D1 E0           shl ax, 1
0311  C4 3E 1E DE     les di, ptr [0xde1e]
0315  03 F8           add di, ax
0317  81 C7 FE FF     add di, 0xfffe
031B  06              push es
031C  57              push di
031D  8A 46 08        mov al, byte ptr [bp + 8]
0320  50              push ax
0321  8A 86 00 FF     mov al, byte ptr [bp - 0x100]
0325  30 E4           xor ah, ah
0327  50              push ax
0328  0E              push cs
0329  E8 1F 00        call 0x34b
032C  8D BE 00 FF     lea di, [bp - 0x100]
0330  16              push ss
0331  57              push di
0332  8B 46 06        mov ax, word ptr [bp + 6]
0335  D1 E0           shl ax, 1
0337  C4 3E 1E DE     les di, ptr [0xde1e]
033B  03 F8           add di, ax
033D  81 C7 FE FF     add di, 0xfffe
0341  06              push es
0342  57              push di
0343  0E              push cs
0344  E8 30 FF        call 0x277
loc_0347:
0347  C9              leave
0348  CA 08 00        retf 8

; ---- routine 24BC:034B  (found by: call, far)
sub_034B:
034B  55              push bp
034C  89 E5           mov bp, sp
034E  83 7E 06 00     cmp word ptr [bp + 6], 0
0352  76 15           jbe 0x369
0354  1E              push ds
0355  C4 BE 0A 00     les di, ptr [bp + 0xa]
0359  8A 86 08 00     mov al, byte ptr [bp + 8]
035D  8B 8E 06 00     mov cx, word ptr [bp + 6]
0361  FC              cld
0362  E3 04           jcxz 0x368
0364  47              inc di
0365  AA              stosb byte ptr es:[di], al
0366  E2 FC           loop 0x364
loc_0368:
0368  1F              pop ds
loc_0369:
0369  C9              leave
036A  CA 08 00        retf 8

; ---- routine 24BC:036D  (found by: call, prologue)
sub_036D:
036D  55              push bp
036E  89 E5           mov bp, sp
0370  83 3E 72 F8 19  cmp word ptr [0xf872], 0x19
0375  76 0E           jbe 0x385
0377  6A 00           push 0
0379  FF 36 72 F8     push word ptr [0xf872]
037D  6A 00           push 0
037F  0E              push cs
0380  E8 AD 17        call 0x1b30
0383  EB 10           jmp 0x395
loc_0385:
0385  C4 3E 1E DE     les di, ptr [0xde1e]
0389  06              push es
038A  57              push di
038B  68 D0 07        push 0x7d0
038E  68 00 02        push 0x200
0391  0E              push cs
0392  E8 AE FE        call 0x243
loc_0395:
0395  C7 06 3A A3 01 00 mov word ptr [0xa33a], 1
039B  C9              leave
039C  CB              retf

; ---- routine 24BC:039D  (found by: call)
sub_039D:
039D  C8 52 00 00     enter 0x52, 0
03A1  8C D3           mov bx, ss
03A3  8E C3           mov es, bx
03A5  8C DB           mov bx, ds
03A7  FC              cld
03A8  8D 7E AE        lea di, [bp - 0x52]
03AB  C5 76 06        lds si, ptr [bp + 6]
03AE  AC              lodsb al, byte ptr [si]
03AF  3C 50           cmp al, 0x50
03B1  72 02           jb 0x3b5
03B3  B0 50           mov al, 0x50
loc_03B5:
03B5  AA              stosb byte ptr es:[di], al
03B6  91              xchg cx, ax
03B7  30 ED           xor ch, ch
03B9  F3 A4           rep movsb byte ptr es:[di], byte ptr [si]
03BB  8E DB           mov ds, bx
03BD  80 7E 0A 00     cmp byte ptr [bp + 0xa], 0
03C1  74 09           je 0x3cc
03C3  8D 7E AE        lea di, [bp - 0x52]
03C6  16              push ss
03C7  57              push di
03C8  0E              push cs
03C9  E8 A3 02        call 0x66f
loc_03CC:
03CC  8A 46 0A        mov al, byte ptr [bp + 0xa]
03CF  88 46 FF        mov byte ptr [bp - 1], al
03D2  8A 46 FF        mov al, byte ptr [bp - 1]
03D5  C9              leave
03D6  CA 06 00        retf 6

; ---- routine 24BC:03D9  (found by: far)
sub_03D9:
03D9  55              push bp
03DA  89 E5           mov bp, sp
03DC  C4 7E 0A        les di, ptr [bp + 0xa]
03DF  26 8B 05        mov ax, word ptr es:[di]
03E2  3B 46 08        cmp ax, word ptr [bp + 8]
03E5  7D 06           jge 0x3ed
03E7  8B 46 08        mov ax, word ptr [bp + 8]
03EA  26 89 05        mov word ptr es:[di], ax
loc_03ED:
03ED  C4 7E 0A        les di, ptr [bp + 0xa]
03F0  26 8B 05        mov ax, word ptr es:[di]
03F3  3B 46 06        cmp ax, word ptr [bp + 6]
03F6  7E 06           jle 0x3fe
03F8  8B 46 06        mov ax, word ptr [bp + 6]
03FB  26 89 05        mov word ptr es:[di], ax
loc_03FE:
03FE  C9              leave
03FF  CA 08 00        retf 8

; ---- routine 24BC:0402  (found by: far)
sub_0402:
0402  55              push bp
0403  89 E5           mov bp, sp
0405  C4 7E 0A        les di, ptr [bp + 0xa]
0408  26 8A 05        mov al, byte ptr es:[di]
040B  3A 46 08        cmp al, byte ptr [bp + 8]
040E  7D 06           jge 0x416
0410  8A 46 08        mov al, byte ptr [bp + 8]
0413  26 88 05        mov byte ptr es:[di], al
loc_0416:
0416  C4 7E 0A        les di, ptr [bp + 0xa]
0419  26 8A 05        mov al, byte ptr es:[di]
041C  3A 46 06        cmp al, byte ptr [bp + 6]
041F  7E 06           jle 0x427
0421  8A 46 06        mov al, byte ptr [bp + 6]
0424  26 88 05        mov byte ptr es:[di], al
loc_0427:
0427  C9              leave
0428  CA 08 00        retf 8

; ---- routine 24BC:042B  (found by: call, far)
sub_042B:
042B  55              push bp
042C  89 E5           mov bp, sp
042E  83 7E 06 00     cmp word ptr [bp + 6], 0
0432  7E 2B           jle 0x45f
0434  C4 7E 0C        les di, ptr [bp + 0xc]
0437  26 8B 05        mov ax, word ptr es:[di]
043A  03 46 06        add ax, word ptr [bp + 6]
043D  3B 46 08        cmp ax, word ptr [bp + 8]
0440  7F 08           jg 0x44a
0442  8B 46 06        mov ax, word ptr [bp + 6]
0445  26 01 05        add word ptr es:[di], ax
0448  EB 13           jmp 0x45d
loc_044A:
044A  C4 7E 0C        les di, ptr [bp + 0xc]
044D  26 8B 05        mov ax, word ptr es:[di]
0450  03 46 06        add ax, word ptr [bp + 6]
0453  2B 46 08        sub ax, word ptr [bp + 8]
0456  03 46 0A        add ax, word ptr [bp + 0xa]
0459  48              dec ax
045A  26 89 05        mov word ptr es:[di], ax
loc_045D:
045D  EB 29           jmp 0x488
loc_045F:
045F  C4 7E 0C        les di, ptr [bp + 0xc]
0462  26 8B 05        mov ax, word ptr es:[di]
0465  03 46 06        add ax, word ptr [bp + 6]
0468  3B 46 0A        cmp ax, word ptr [bp + 0xa]
046B  7C 08           jl 0x475
046D  8B 46 06        mov ax, word ptr [bp + 6]
0470  26 01 05        add word ptr es:[di], ax
0473  EB 13           jmp 0x488
loc_0475:
0475  C4 7E 0C        les di, ptr [bp + 0xc]
0478  26 8B 05        mov ax, word ptr es:[di]
047B  03 46 06        add ax, word ptr [bp + 6]
047E  03 46 08        add ax, word ptr [bp + 8]
0481  2B 46 0A        sub ax, word ptr [bp + 0xa]
0484  40              inc ax
0485  26 89 05        mov word ptr es:[di], ax
loc_0488:
0488  C9              leave
0489  CA 0A 00        retf 0xa

; ---- routine 24BC:048C  (found by: far)
sub_048C:
048C  C8 02 00 00     enter 2, 0
0490  C4 7E 0C        les di, ptr [bp + 0xc]
0493  26 8A 05        mov al, byte ptr es:[di]
0496  30 E4           xor ah, ah
0498  89 46 FE        mov word ptr [bp - 2], ax
049B  8D 7E FE        lea di, [bp - 2]
049E  16              push ss
049F  57              push di
04A0  8A 46 0A        mov al, byte ptr [bp + 0xa]
04A3  30 E4           xor ah, ah
04A5  50              push ax
04A6  8A 46 08        mov al, byte ptr [bp + 8]
04A9  30 E4           xor ah, ah
04AB  50              push ax
04AC  FF 76 06        push word ptr [bp + 6]
04AF  0E              push cs
04B0  E8 78 FF        call 0x42b
04B3  8A 46 FE        mov al, byte ptr [bp - 2]
04B6  C4 7E 0C        les di, ptr [bp + 0xc]
04B9  26 88 05        mov byte ptr es:[di], al
04BC  C9              leave
04BD  CA 0A 00        retf 0xa

; ---- routine 24BC:04C0  (found by: far)
sub_04C0:
04C0  C8 04 00 00     enter 4, 0
04C4  8B 46 0A        mov ax, word ptr [bp + 0xa]
04C7  8B 56 0C        mov dx, word ptr [bp + 0xc]
04CA  3B 56 08        cmp dx, word ptr [bp + 8]
04CD  7F 07           jg 0x4d6
04CF  7C 13           jl 0x4e4
04D1  3B 46 06        cmp ax, word ptr [bp + 6]
04D4  76 0E           jbe 0x4e4
loc_04D6:
04D6  8B 46 0A        mov ax, word ptr [bp + 0xa]
04D9  8B 56 0C        mov dx, word ptr [bp + 0xc]
04DC  89 46 FC        mov word ptr [bp - 4], ax
04DF  89 56 FE        mov word ptr [bp - 2], dx
04E2  EB 0C           jmp 0x4f0
loc_04E4:
04E4  8B 46 06        mov ax, word ptr [bp + 6]
04E7  8B 56 08        mov dx, word ptr [bp + 8]
04EA  89 46 FC        mov word ptr [bp - 4], ax
04ED  89 56 FE        mov word ptr [bp - 2], dx
loc_04F0:
04F0  8B 46 FC        mov ax, word ptr [bp - 4]
04F3  8B 56 FE        mov dx, word ptr [bp - 2]
04F6  C9              leave
04F7  CA 08 00        retf 8

; ---- routine 24BC:04FA  (found by: call, far)
sub_04FA:
04FA  C8 04 00 00     enter 4, 0
04FE  8B 46 0A        mov ax, word ptr [bp + 0xa]
0501  8B 56 0C        mov dx, word ptr [bp + 0xc]
0504  3B 56 08        cmp dx, word ptr [bp + 8]
0507  7F 07           jg 0x510
0509  7C 13           jl 0x51e
050B  3B 46 06        cmp ax, word ptr [bp + 6]
050E  76 0E           jbe 0x51e
loc_0510:
0510  8B 46 06        mov ax, word ptr [bp + 6]
0513  8B 56 08        mov dx, word ptr [bp + 8]
0516  89 46 FC        mov word ptr [bp - 4], ax
0519  89 56 FE        mov word ptr [bp - 2], dx
051C  EB 0C           jmp 0x52a
loc_051E:
051E  8B 46 0A        mov ax, word ptr [bp + 0xa]
0521  8B 56 0C        mov dx, word ptr [bp + 0xc]
0524  89 46 FC        mov word ptr [bp - 4], ax
0527  89 56 FE        mov word ptr [bp - 2], dx
loc_052A:
052A  8B 46 FC        mov ax, word ptr [bp - 4]
052D  8B 56 FE        mov dx, word ptr [bp - 2]
0530  C9              leave
0531  CA 08 00        retf 8

; ---- routine 24BC:0534  (found by: call)
sub_0534:
0534  C8 52 00 00     enter 0x52, 0
0538  8A 46 06        mov al, byte ptr [bp + 6]
053B  88 46 AE        mov byte ptr [bp - 0x52], al
053E  8D 7E AF        lea di, [bp - 0x51]
0541  16              push ss
0542  57              push di
0543  8A 46 06        mov al, byte ptr [bp + 6]
0546  30 E4           xor ah, ah
0548  50              push ax
0549  8A 46 08        mov al, byte ptr [bp + 8]
054C  30 E4           xor ah, ah
054E  50              push ax
054F  0E              push cs
0550  E8 CF FC        call 0x222
0553  8D 7E AE        lea di, [bp - 0x52]
0556  16              push ss
0557  57              push di
0558  C4 7E 0A        les di, ptr [bp + 0xa]
055B  06              push es
055C  57              push di
055D  6A 50           push 0x50
055F  9A 6D 0B C9 26  call far 26C9:0B6D
0564  C9              leave
0565  CA 04 00        retf 4

; ---- routine 24BC:0568  (found by: call, far)
sub_0568:
0568  55              push bp
0569  89 E5           mov bp, sp
056B  80 3E 36 A3 00  cmp byte ptr [0xa336], 0
0570  74 24           je 0x596
0572  83 3E 72 F8 19  cmp word ptr [0xf872], 0x19
0577  75 1D           jne 0x596
0579  A1 82 DE        mov ax, word ptr [0xde82]
057C  D1 E0           shl ax, 1
057E  C4 3E 1E DE     les di, ptr [0xde1e]
0582  03 F8           add di, ax
0584  81 C7 FE FF     add di, 0xfffe
0588  06              push es
0589  57              push di
058A  BF 78 F8        mov di, 0xf878
058D  1E              push ds
058E  57              push di
058F  68 A0 00        push 0xa0
0592  0E              push cs
0593  E8 2C FC        call 0x1c2
loc_0596:
0596  C9              leave
0597  CB              retf

; ---- routine 24BC:0598  (found by: call, far)
sub_0598:
0598  55              push bp
0599  89 E5           mov bp, sp
059B  80 3E 36 A3 00  cmp byte ptr [0xa336], 0
05A0  74 24           je 0x5c6
05A2  83 3E 72 F8 19  cmp word ptr [0xf872], 0x19
05A7  75 1D           jne 0x5c6
05A9  BF 78 F8        mov di, 0xf878
05AC  1E              push ds
05AD  57              push di
05AE  A1 82 DE        mov ax, word ptr [0xde82]
05B1  D1 E0           shl ax, 1
05B3  C4 3E 1E DE     les di, ptr [0xde1e]
05B7  03 F8           add di, ax
05B9  81 C7 FE FF     add di, 0xfffe
05BD  06              push es
05BE  57              push di
05BF  68 A0 00        push 0xa0
05C2  0E              push cs
05C3  E8 FC FB        call 0x1c2
loc_05C6:
05C6  C9              leave
05C7  CB              retf

; ---- routine 24BC:05C8  (found by: call)
sub_05C8:
05C8  C8 52 01 00     enter 0x152, 0
05CC  8C D3           mov bx, ss
05CE  8E C3           mov es, bx
05D0  8C DB           mov bx, ds
05D2  FC              cld
05D3  8D 7E AE        lea di, [bp - 0x52]
05D6  C5 76 04        lds si, ptr [bp + 4]
05D9  AC              lodsb al, byte ptr [si]
05DA  3C 50           cmp al, 0x50
05DC  72 02           jb 0x5e0
05DE  B0 50           mov al, 0x50
loc_05E0:
05E0  AA              stosb byte ptr es:[di], al
05E1  91              xchg cx, ax
05E2  30 ED           xor ch, ch
05E4  F3 A4           rep movsb byte ptr es:[di], byte ptr [si]
05E6  8E DB           mov ds, bx
05E8  80 3E DE E0 00  cmp byte ptr [0xe0de], 0
05ED  74 23           je 0x612
05EF  8D BE AE FE     lea di, [bp - 0x152]
05F3  16              push ss
05F4  57              push di
05F5  8D 7E AE        lea di, [bp - 0x52]
05F8  16              push ss
05F9  57              push di
05FA  A0 DC E0        mov al, byte ptr [0xe0dc]
05FD  50              push ax
05FE  0E              push cs
05FF  E8 96 FA        call 0x98
0602  8A 46 08        mov al, byte ptr [bp + 8]
0605  30 E4           xor ah, ah
0607  50              push ax
0608  FF 36 82 DE     push word ptr [0xde82]
060C  0E              push cs
060D  E8 A2 FC        call 0x2b2
0610  EB 21           jmp 0x633
loc_0612:
0612  8D BE AE FE     lea di, [bp - 0x152]
0616  16              push ss
0617  57              push di
0618  8D 7E AE        lea di, [bp - 0x52]
061B  16              push ss
061C  57              push di
061D  A0 DC E0        mov al, byte ptr [0xe0dc]
0620  50              push ax
0621  0E              push cs
0622  E8 BF FA        call 0xe4
0625  8A 46 08        mov al, byte ptr [bp + 8]
0628  30 E4           xor ah, ah
062A  50              push ax
062B  FF 36 82 DE     push word ptr [0xde82]
062F  0E              push cs
0630  E8 7F FC        call 0x2b2
loc_0633:
0633  C9              leave
0634  C2 06 00        ret 6

; ---- routine 24BC:0637  (found by: call)
sub_0637:
0637  C8 52 00 00     enter 0x52, 0
063B  8C D3           mov bx, ss
063D  8E C3           mov es, bx
063F  8C DB           mov bx, ds
0641  FC              cld
0642  8D 7E AE        lea di, [bp - 0x52]
0645  C5 76 06        lds si, ptr [bp + 6]
0648  AC              lodsb al, byte ptr [si]
0649  3C 50           cmp al, 0x50
064B  72 02           jb 0x64f
064D  B0 50           mov al, 0x50
loc_064F:
064F  AA              stosb byte ptr es:[di], al
0650  91              xchg cx, ax
0651  30 ED           xor ch, ch
0653  F3 A4           rep movsb byte ptr es:[di], byte ptr [si]
0655  8E DB           mov ds, bx
0657  A0 34 A3        mov al, byte ptr [0xa334]
065A  50              push ax
065B  8D 7E AE        lea di, [bp - 0x52]
065E  16              push ss
065F  57              push di
0660  E8 65 FF        call 0x5c8
0663  C9              leave
0664  CA 04 00        retf 4
; data (not reached as code), 8 bytes
0667                  pstr 'ERROR: '

; ---- routine 24BC:066F  (found by: call)
sub_066F:
066F  C8 52 01 00     enter 0x152, 0
0673  8C D3           mov bx, ss
0675  8E C3           mov es, bx
0677  8C DB           mov bx, ds
0679  FC              cld
067A  8D 7E AE        lea di, [bp - 0x52]
067D  C5 76 06        lds si, ptr [bp + 6]
0680  AC              lodsb al, byte ptr [si]
0681  3C 50           cmp al, 0x50
0683  72 02           jb 0x687
0685  B0 50           mov al, 0x50
loc_0687:
0687  AA              stosb byte ptr es:[di], al
0688  91              xchg cx, ax
0689  30 ED           xor ch, ch
068B  F3 A4           rep movsb byte ptr es:[di], byte ptr [si]
068D  8E DB           mov ds, bx
068F  0E              push cs
0690  E8 D5 FE        call 0x568
0693  6A 4F           push 0x4f
0695  8D BE AE FE     lea di, [bp - 0x152]
0699  16              push ss
069A  57              push di
069B  BF 67 06        mov di, 0x667
069E  0E              push cs
069F  57              push di
06A0  9A 53 0B C9 26  call far 26C9:0B53
06A5  8D 7E AE        lea di, [bp - 0x52]
06A8  16              push ss
06A9  57              push di
06AA  9A D2 0B C9 26  call far 26C9:0BD2
06AF  E8 16 FF        call 0x5c8
06B2  0E              push cs
06B3  E8 61 05        call 0xc17
06B6  0E              push cs
06B7  E8 DE FE        call 0x598
06BA  C9              leave
06BB  CA 04 00        retf 4

; ---- routine 24BC:06BE  (found by: call, far)
sub_06BE:
06BE  C8 52 00 00     enter 0x52, 0
06C2  8C D3           mov bx, ss
06C4  8E C3           mov es, bx
06C6  8C DB           mov bx, ds
06C8  FC              cld
06C9  8D 7E AE        lea di, [bp - 0x52]
06CC  C5 76 06        lds si, ptr [bp + 6]
06CF  AC              lodsb al, byte ptr [si]
06D0  3C 50           cmp al, 0x50
06D2  72 02           jb 0x6d6
06D4  B0 50           mov al, 0x50
loc_06D6:
06D6  AA              stosb byte ptr es:[di], al
06D7  91              xchg cx, ax
06D8  30 ED           xor ch, ch
06DA  F3 A4           rep movsb byte ptr es:[di], byte ptr [si]
06DC  8E DB           mov ds, bx
06DE  8D 7E AE        lea di, [bp - 0x52]
06E1  16              push ss
06E2  57              push di
06E3  0E              push cs
06E4  E8 88 FF        call 0x66f
06E7  31 C0           xor ax, ax
06E9  9A 16 01 C9 26  call far 26C9:0116
06EE  C9              leave
06EF  CA 04 00        retf 4
; data (not reached as code), 16 bytes
06F2                  pstr ' : '
06F6                  pstr 'hit any key'

; ---- routine 24BC:0702  (found by: far)
sub_0702:
0702  C8 52 01 00     enter 0x152, 0
0706  8C D3           mov bx, ss
0708  8E C3           mov es, bx
070A  8C DB           mov bx, ds
070C  FC              cld
070D  8D 7E AE        lea di, [bp - 0x52]
0710  C5 76 06        lds si, ptr [bp + 6]
0713  AC              lodsb al, byte ptr [si]
0714  3C 50           cmp al, 0x50
0716  72 02           jb 0x71a
0718  B0 50           mov al, 0x50
loc_071A:
071A  AA              stosb byte ptr es:[di], al
071B  91              xchg cx, ax
071C  30 ED           xor ch, ch
071E  F3 A4           rep movsb byte ptr es:[di], byte ptr [si]
0720  8E DB           mov ds, bx
0722  0E              push cs
0723  E8 42 FE        call 0x568
0726  80 7E AE 00     cmp byte ptr [bp - 0x52], 0
072A  74 26           je 0x752
072C  8D BE AE FE     lea di, [bp - 0x152]
0730  16              push ss
0731  57              push di
0732  8D 7E AE        lea di, [bp - 0x52]
0735  16              push ss
0736  57              push di
0737  9A 53 0B C9 26  call far 26C9:0B53
073C  BF F2 06        mov di, 0x6f2
073F  0E              push cs
0740  57              push di
0741  9A D2 0B C9 26  call far 26C9:0BD2
0746  8D 7E AE        lea di, [bp - 0x52]
0749  16              push ss
074A  57              push di
074B  6A 50           push 0x50
074D  9A 6D 0B C9 26  call far 26C9:0B6D
loc_0752:
0752  8D BE AE FE     lea di, [bp - 0x152]
0756  16              push ss
0757  57              push di
0758  8D 7E AE        lea di, [bp - 0x52]
075B  16              push ss
075C  57              push di
075D  9A 53 0B C9 26  call far 26C9:0B53
0762  BF F6 06        mov di, 0x6f6
0765  0E              push cs
0766  57              push di
0767  9A D2 0B C9 26  call far 26C9:0BD2
076C  0E              push cs
076D  E8 C7 FE        call 0x637
0770  0E              push cs
0771  E8 A3 04        call 0xc17
0774  0E              push cs
0775  E8 20 FE        call 0x598
0778  C9              leave
0779  CA 04 00        retf 4
; data (not reached as code), 8 bytes
077C                  pstr '? (Y/N)'

; ---- routine 24BC:0784  (found by: call)
sub_0784:
0784  C8 52 01 00     enter 0x152, 0
0788  8C D3           mov bx, ss
078A  8E C3           mov es, bx
078C  8C DB           mov bx, ds
078E  FC              cld
078F  8D 7E AE        lea di, [bp - 0x52]
0792  C5 76 06        lds si, ptr [bp + 6]
0795  AC              lodsb al, byte ptr [si]
0796  3C 50           cmp al, 0x50
0798  72 02           jb 0x79c
079A  B0 50           mov al, 0x50
loc_079C:
079C  AA              stosb byte ptr es:[di], al
079D  91              xchg cx, ax
079E  30 ED           xor ch, ch
07A0  F3 A4           rep movsb byte ptr es:[di], byte ptr [si]
07A2  8E DB           mov ds, bx
07A4  0E              push cs
07A5  E8 C0 FD        call 0x568
07A8  A0 35 A3        mov al, byte ptr [0xa335]
07AB  50              push ax
07AC  8D BE AE FE     lea di, [bp - 0x152]
07B0  16              push ss
07B1  57              push di
07B2  8D 7E AE        lea di, [bp - 0x52]
07B5  16              push ss
07B6  57              push di
07B7  9A 53 0B C9 26  call far 26C9:0B53
07BC  BF 7C 07        mov di, 0x77c
07BF  0E              push cs
07C0  57              push di
07C1  9A D2 0B C9 26  call far 26C9:0BD2
07C6  E8 FF FD        call 0x5c8
loc_07C9:
07C9  0E              push cs
07CA  E8 4A 04        call 0xc17
07CD  A0 88 DE        mov al, byte ptr [0xde88]
07D0  3C 01           cmp al, 1
07D2  74 10           je 0x7e4
07D4  3C 4E           cmp al, 0x4e
07D6  74 0C           je 0x7e4
07D8  3C 59           cmp al, 0x59
07DA  74 08           je 0x7e4
07DC  3C 6E           cmp al, 0x6e
07DE  74 04           je 0x7e4
07E0  3C 79           cmp al, 0x79
07E2  75 E5           jne 0x7c9
loc_07E4:
07E4  A0 88 DE        mov al, byte ptr [0xde88]
07E7  50              push ax
07E8  9A 86 19 C9 26  call far 26C9:1986
07ED  3C 59           cmp al, 0x59
07EF  B0 00           mov al, 0
07F1  75 01           jne 0x7f4
07F3  40              inc ax
loc_07F4:
07F4  88 46 FF        mov byte ptr [bp - 1], al
07F7  0E              push cs
07F8  E8 9D FD        call 0x598
07FB  8A 46 FF        mov al, byte ptr [bp - 1]
07FE  C9              leave
07FF  CA 04 00        retf 4

; ---- routine 24BC:0802  (found by: call)
sub_0802:
0802  C8 10 00 00     enter 0x10, 0
0806  FF 76 08        push word ptr [bp + 8]
0809  FF 76 06        push word ptr [bp + 6]
080C  6A 00           push 0
080E  8D 7E F0        lea di, [bp - 0x10]
0811  16              push ss
0812  57              push di
0813  6A 0F           push 0xf
0815  9A 0A 19 C9 26  call far 26C9:190A
081A  8D 7E F0        lea di, [bp - 0x10]
081D  16              push ss
081E  57              push di
081F  C4 7E 0A        les di, ptr [bp + 0xa]
0822  06              push es
0823  57              push di
0824  6A 0F           push 0xf
0826  9A 6D 0B C9 26  call far 26C9:0B6D
082B  C9              leave
082C  CA 04 00        retf 4

; ---- routine 24BC:082F  (found by: call)
sub_082F:
082F  C8 04 01 00     enter 0x104, 0
0833  8C D3           mov bx, ss
0835  8E C3           mov es, bx
0837  8C DB           mov bx, ds
0839  FC              cld
083A  8D BE FE FE     lea di, [bp - 0x102]
083E  C5 76 06        lds si, ptr [bp + 6]
0841  AC              lodsb al, byte ptr [si]
0842  AA              stosb byte ptr es:[di], al
0843  91              xchg cx, ax
0844  30 ED           xor ch, ch
0846  F3 A4           rep movsb byte ptr es:[di], byte ptr [si]
0848  8E DB           mov ds, bx
084A  8A 86 FE FE     mov al, byte ptr [bp - 0x102]
084E  88 86 FD FE     mov byte ptr [bp - 0x103], al
loc_0852:
0852  80 BE FD FE 00  cmp byte ptr [bp - 0x103], 0
0857  76 17           jbe 0x870
0859  8A 86 FD FE     mov al, byte ptr [bp - 0x103]
085D  30 E4           xor ah, ah
085F  8B F8           mov di, ax
0861  8A 83 FE FE     mov al, byte ptr [bp + di - 0x102]
0865  3A 46 0A        cmp al, byte ptr [bp + 0xa]
0868  74 06           je 0x870
086A  FE 8E FD FE     dec byte ptr [bp - 0x103]
086E  EB E2           jmp 0x852
loc_0870:
0870  8A 86 FD FE     mov al, byte ptr [bp - 0x103]
0874  88 46 FF        mov byte ptr [bp - 1], al
0877  8A 46 FF        mov al, byte ptr [bp - 1]
087A  C9              leave
087B  CA 06 00        retf 6

