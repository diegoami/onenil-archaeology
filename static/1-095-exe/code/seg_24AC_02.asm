; 1-095.EXE (One-Nil 95), code segment 24AC (image offsets 24AC0..26A7F), part 2 of 4
; packed 1-095.EXE sha256 f659fb2d334500d6901fc8d6a0f06c85c0ccda2eb4a3035ae3bb0a0004d79192 (LZEXE 0.91)
; unpacked (tools/static/unlzexe.py) sha256 8df646e017e0965a5d90a58181ca764219ad847833aad0b6cb58fc53372bfb2c
; tool: capstone 5.0.9 (pip package; core library 5.0.1280) (CS_ARCH_X86, CS_MODE_16), recursive descent from the entry point, far calls and near calls/jumps, then routine prologues (55 89 E5 / 55 8B EC / C8 iw 00) in what remains; tools/static/listing.py
; addresses are SEGMENT:OFFSET with SEGMENT the image paragraph before relocation; image offset = SEGMENT*16+OFFSET
; ---- routine 24AC:087E  (found by: call)
sub_087E:
087E  C8 02 01 00     enter 0x102, 0
loc_0882:
0882  8D BE FE FE     lea di, [bp - 0x102]
0886  16              push ss
0887  57              push di
0888  8A 46 0A        mov al, byte ptr [bp + 0xa]
088B  50              push ax
088C  9A 6F 0C B9 26  call far 26B9:0C6F
0891  C4 7E 06        les di, ptr [bp + 6]
0894  06              push es
0895  57              push di
0896  9A FE 0B B9 26  call far 26B9:0BFE
089B  88 46 FF        mov byte ptr [bp - 1], al
089E  80 7E FF 00     cmp byte ptr [bp - 1], 0
08A2  76 12           jbe 0x8b6
08A4  C4 7E 06        les di, ptr [bp + 6]
08A7  06              push es
08A8  57              push di
08A9  8A 46 FF        mov al, byte ptr [bp - 1]
08AC  30 E4           xor ah, ah
08AE  50              push ax
08AF  6A 01           push 1
08B1  9A FB 0C B9 26  call far 26B9:0CFB
loc_08B6:
08B6  80 7E FF 00     cmp byte ptr [bp - 1], 0
08BA  75 C6           jne 0x882
08BC  C9              leave
08BD  CA 06 00        retf 6

; ---- routine 24AC:08C0  (found by: call)
sub_08C0:
08C0  C8 14 00 00     enter 0x14, 0
08C4  C7 46 EC 04 00  mov word ptr [bp - 0x14], 4
08C9  8B 46 0A        mov ax, word ptr [bp + 0xa]
08CC  89 46 F0        mov word ptr [bp - 0x10], ax
08CF  8B 46 0C        mov ax, word ptr [bp + 0xc]
08D2  89 46 F2        mov word ptr [bp - 0xe], ax
08D5  6A 33           push 0x33
08D7  8D 7E EC        lea di, [bp - 0x14]
08DA  16              push ss
08DB  57              push di
08DC  9A B2 00 A8 26  call far 26A8:00B2
08E1  C9              leave
08E2  CA 08 00        retf 8

; ---- routine 24AC:08E5  (found by: call)
sub_08E5:
08E5  C8 14 00 00     enter 0x14, 0
08E9  C7 46 EC 07 00  mov word ptr [bp - 0x14], 7
08EE  8B 46 06        mov ax, word ptr [bp + 6]
08F1  D1 E0           shl ax, 1
08F3  89 46 F0        mov word ptr [bp - 0x10], ax
08F6  8B 46 04        mov ax, word ptr [bp + 4]
08F9  D1 E0           shl ax, 1
08FB  89 46 F2        mov word ptr [bp - 0xe], ax
08FE  6A 33           push 0x33
0900  8D 7E EC        lea di, [bp - 0x14]
0903  16              push ss
0904  57              push di
0905  9A B2 00 A8 26  call far 26A8:00B2
090A  C7 46 EC 08 00  mov word ptr [bp - 0x14], 8
090F  8B 46 0A        mov ax, word ptr [bp + 0xa]
0912  89 46 F0        mov word ptr [bp - 0x10], ax
0915  8B 46 08        mov ax, word ptr [bp + 8]
0918  89 46 F2        mov word ptr [bp - 0xe], ax
091B  6A 33           push 0x33
091D  8D 7E EC        lea di, [bp - 0x14]
0920  16              push ss
0921  57              push di
0922  9A B2 00 A8 26  call far 26A8:00B2
0927  C9              leave
0928  C2 08 00        ret 8

; ---- routine 24AC:092B  (found by: call)
sub_092B:
092B  C8 14 00 00     enter 0x14, 0
092F  31 C0           xor ax, ax
0931  89 46 EC        mov word ptr [bp - 0x14], ax
0934  6A 33           push 0x33
0936  8D 7E EC        lea di, [bp - 0x14]
0939  16              push ss
093A  57              push di
093B  9A B2 00 A8 26  call far 26A8:00B2
0940  83 7E EC FF     cmp word ptr [bp - 0x14], -1
0944  B0 00           mov al, 0
0946  75 01           jne 0x949
0948  40              inc ax
loc_0949:
0949  C4 7E 06        les di, ptr [bp + 6]
094C  26 88 45 07     mov byte ptr es:[di + 7], al
0950  8A 46 EE        mov al, byte ptr [bp - 0x12]
0953  26 88 45 04     mov byte ptr es:[di + 4], al
0957  6A 00           push 0
0959  68 DF 01        push 0x1df
095C  6A 00           push 0
095E  68 7F 02        push 0x27f
0961  E8 81 FF        call 0x8e5
0964  6A 64           push 0x64
0966  6A 64           push 0x64
0968  C4 7E 06        les di, ptr [bp + 6]
096B  06              push es
096C  57              push di
096D  0E              push cs
096E  E8 4F FF        call 0x8c0
0971  C4 3E 26 DE     les di, ptr [0xde26]
0975  26 8B 05        mov ax, word ptr es:[di]
0978  26 8B 55 02     mov dx, word ptr es:[di + 2]
097C  C4 7E 06        les di, ptr [bp + 6]
097F  26 89 05        mov word ptr es:[di], ax
0982  26 89 55 02     mov word ptr es:[di + 2], dx
0986  26 C6 45 05 00  mov byte ptr es:[di + 5], 0
098B  C9              leave
098C  CA 04 00        retf 4

; ---- routine 24AC:098F  (found by: call)
sub_098F:
098F  C8 18 00 00     enter 0x18, 0
0993  C4 7E 06        les di, ptr [bp + 6]
0996  26 80 7D 07 00  cmp byte ptr es:[di + 7], 0
099B  75 03           jne 0x9a0
099D  E9 2C 01        jmp 0xacc
loc_09A0:
09A0  C7 46 EC 03 00  mov word ptr [bp - 0x14], 3
09A5  6A 33           push 0x33
09A7  8D 7E EC        lea di, [bp - 0x14]
09AA  16              push ss
09AB  57              push di
09AC  9A B2 00 A8 26  call far 26A8:00B2
09B1  C4 7E 06        les di, ptr [bp + 6]
09B4  26 8A 45 05     mov al, byte ptr es:[di + 5]
09B8  30 E4           xor ah, ah
09BA  3B 46 EE        cmp ax, word ptr [bp - 0x12]
09BD  75 4C           jne 0xa0b
09BF  A0 DA E0        mov al, byte ptr [0xe0da]
09C2  30 E4           xor ah, ah
09C4  8B D0           mov dx, ax
09C6  26 8A 45 06     mov al, byte ptr es:[di + 6]
09CA  30 E4           xor ah, ah
09CC  F7 E2           mul dx
09CE  99              cdq
09CF  8B C8           mov cx, ax
09D1  8B DA           mov bx, dx
09D3  C4 3E 26 DE     les di, ptr [0xde26]
09D7  26 8B 05        mov ax, word ptr es:[di]
09DA  26 8B 55 02     mov dx, word ptr es:[di + 2]
09DE  C4 7E 06        les di, ptr [bp + 6]
09E1  26 2B 05        sub ax, word ptr es:[di]
09E4  26 1B 55 02     sbb dx, word ptr es:[di + 2]
09E8  3B D3           cmp dx, bx
09EA  7F 0A           jg 0x9f6
09EC  7C 04           jl 0x9f2
09EE  3B C1           cmp ax, cx
09F0  77 04           ja 0x9f6
loc_09F2:
09F2  B0 00           mov al, 0
09F4  EB 02           jmp 0x9f8
loc_09F6:
09F6  B0 01           mov al, 1
loc_09F8:
09F8  88 46 E9        mov byte ptr [bp - 0x17], al
09FB  80 7E E9 00     cmp byte ptr [bp - 0x17], 0
09FF  74 08           je 0xa09
0A01  C4 7E 06        les di, ptr [bp + 6]
0A04  26 C6 45 06 01  mov byte ptr es:[di + 6], 1
loc_0A09:
0A09  EB 13           jmp 0xa1e
loc_0A0B:
0A0B  C6 46 E9 01     mov byte ptr [bp - 0x17], 1
0A0F  8A 46 EE        mov al, byte ptr [bp - 0x12]
0A12  C4 7E 06        les di, ptr [bp + 6]
0A15  26 88 45 05     mov byte ptr es:[di + 5], al
0A19  26 C6 45 06 05  mov byte ptr es:[di + 6], 5
loc_0A1E:
0A1E  6A 01           push 1
0A20  FF 76 EE        push word ptr [bp - 0x12]
0A23  0E              push cs
0A24  E8 32 F8        call 0x259
0A27  08 C0           or al, al
0A29  74 0E           je 0xa39
0A2B  80 7E E9 00     cmp byte ptr [bp - 0x17], 0
0A2F  74 08           je 0xa39
0A31  C7 06 8C DE 02 00 mov word ptr [0xde8c], 2
0A37  EB 71           jmp 0xaaa
loc_0A39:
0A39  6A 02           push 2
0A3B  FF 76 EE        push word ptr [bp - 0x12]
0A3E  0E              push cs
0A3F  E8 17 F8        call 0x259
0A42  08 C0           or al, al
0A44  74 0E           je 0xa54
0A46  80 7E E9 00     cmp byte ptr [bp - 0x17], 0
0A4A  74 08           je 0xa54
0A4C  C7 06 8C DE 01 00 mov word ptr [0xde8c], 1
0A52  EB 56           jmp 0xaaa
loc_0A54:
0A54  6A 03           push 3
0A56  FF 76 EE        push word ptr [bp - 0x12]
0A59  0E              push cs
0A5A  E8 FC F7        call 0x259
0A5D  08 C0           or al, al
0A5F  74 0E           je 0xa6f
0A61  80 7E E9 00     cmp byte ptr [bp - 0x17], 0
0A65  74 08           je 0xa6f
0A67  C7 06 8C DE 20 00 mov word ptr [0xde8c], 0x20
0A6D  EB 3B           jmp 0xaaa
loc_0A6F:
0A6F  83 7E F0 46     cmp word ptr [bp - 0x10], 0x46
0A73  73 08           jae 0xa7d
0A75  C7 06 8C DE 07 00 mov word ptr [0xde8c], 7
0A7B  EB 2D           jmp 0xaaa
loc_0A7D:
0A7D  81 7E F0 82 00  cmp word ptr [bp - 0x10], 0x82
0A82  76 08           jbe 0xa8c
0A84  C7 06 8C DE 08 00 mov word ptr [0xde8c], 8
0A8A  EB 1E           jmp 0xaaa
loc_0A8C:
0A8C  83 7E F2 50     cmp word ptr [bp - 0xe], 0x50
0A90  73 08           jae 0xa9a
0A92  C7 06 8C DE 05 00 mov word ptr [0xde8c], 5
0A98  EB 10           jmp 0xaaa
loc_0A9A:
0A9A  83 7E F2 78     cmp word ptr [bp - 0xe], 0x78
0A9E  76 08           jbe 0xaa8
0AA0  C7 06 8C DE 06 00 mov word ptr [0xde8c], 6
0AA6  EB 02           jmp 0xaaa
loc_0AA8:
0AA8  EB 22           jmp 0xacc
loc_0AAA:
0AAA  6A 64           push 0x64
0AAC  6A 64           push 0x64
0AAE  C4 7E 06        les di, ptr [bp + 6]
0AB1  06              push es
0AB2  57              push di
0AB3  0E              push cs
0AB4  E8 09 FE        call 0x8c0
0AB7  C4 3E 26 DE     les di, ptr [0xde26]
0ABB  26 8B 05        mov ax, word ptr es:[di]
0ABE  26 8B 55 02     mov dx, word ptr es:[di + 2]
0AC2  C4 7E 06        les di, ptr [bp + 6]
0AC5  26 89 05        mov word ptr es:[di], ax
0AC8  26 89 55 02     mov word ptr es:[di + 2], dx
loc_0ACC:
0ACC  C9              leave
0ACD  CA 04 00        retf 4
; data (not reached as code), 8 bytes
0AD0                  db 50 53 51 52 56 57 1E 06   ; PSQRVW..

; ---- routine 24AC:0AD8  (found by: prologue)
sub_0AD8:
0AD8  C8 06 00 00     enter 6, 0
0ADC  B8 54 28        mov ax, 0x2854   ; relocated segment word 2854
0ADF  8E D8           mov ds, ax
0AE1  FB              sti
0AE2  E4 60           in al, 0x60
0AE4  30 E4           xor ah, ah
0AE6  89 46 FE        mov word ptr [bp - 2], ax
0AE9  E4 61           in al, 0x61
0AEB  30 E4           xor ah, ah
0AED  89 46 FC        mov word ptr [bp - 4], ax
0AF0  8B 46 FC        mov ax, word ptr [bp - 4]
0AF3  0D 80 00        or ax, 0x80
0AF6  E6 61           out 0x61, al
0AF8  8A 46 FC        mov al, byte ptr [bp - 4]
0AFB  E6 61           out 0x61, al
0AFD  8B 46 FE        mov ax, word ptr [bp - 2]
0B00  A3 FE DE        mov word ptr [0xdefe], ax
0B03  8B 46 FE        mov ax, word ptr [bp - 2]
0B06  25 7F 00        and ax, 0x7f
0B09  3D 56 00        cmp ax, 0x56
0B0C  76 03           jbe 0xb11
0B0E  E9 F8 00        jmp 0xc09
loc_0B11:
0B11  81 7E FE 80 00  cmp word ptr [bp - 2], 0x80
0B16  72 03           jb 0xb1b
0B18  E9 E1 00        jmp 0xbfc
loc_0B1B:
0B1B  8B 7E FE        mov di, word ptr [bp - 2]
0B1E  C6 85 A3 DE 01  mov byte ptr [di - 0x215d], 1
0B23  8B 46 FE        mov ax, word ptr [bp - 2]
0B26  3D 3A 00        cmp ax, 0x3a
0B29  75 0F           jne 0xb3a
0B2B  80 3E EC A3 00  cmp byte ptr [0xa3ec], 0
0B30  B0 00           mov al, 0
0B32  75 01           jne 0xb35
0B34  40              inc ax
loc_0B35:
0B35  A2 EC A3        mov byte ptr [0xa3ec], al
0B38  EB 3A           jmp 0xb74
loc_0B3A:
0B3A  3D 45 00        cmp ax, 0x45
0B3D  75 0F           jne 0xb4e
0B3F  80 3E ED A3 00  cmp byte ptr [0xa3ed], 0
0B44  B0 00           mov al, 0
0B46  75 01           jne 0xb49
0B48  40              inc ax
loc_0B49:
0B49  A2 ED A3        mov byte ptr [0xa3ed], al
0B4C  EB 26           jmp 0xb74
loc_0B4E:
0B4E  3D 46 00        cmp ax, 0x46
0B51  75 0F           jne 0xb62
0B53  80 3E EF A3 00  cmp byte ptr [0xa3ef], 0
0B58  B0 00           mov al, 0
0B5A  75 01           jne 0xb5d
0B5C  40              inc ax
loc_0B5D:
0B5D  A2 EF A3        mov byte ptr [0xa3ef], al
0B60  EB 12           jmp 0xb74
loc_0B62:
0B62  3D 52 00        cmp ax, 0x52
0B65  75 0D           jne 0xb74
0B67  80 3E EE A3 00  cmp byte ptr [0xa3ee], 0
0B6C  B0 00           mov al, 0
0B6E  75 01           jne 0xb71
0B70  40              inc ax
loc_0B71:
0B71  A2 EE A3        mov byte ptr [0xa3ee], al
loc_0B74:
0B74  80 3E CD DE 00  cmp byte ptr [0xdecd], 0
0B79  75 0B           jne 0xb86
0B7B  80 3E D9 DE 00  cmp byte ptr [0xded9], 0
0B80  75 04           jne 0xb86
0B82  B0 00           mov al, 0
0B84  EB 02           jmp 0xb88
loc_0B86:
0B86  B0 01           mov al, 1
loc_0B88:
0B88  88 46 FB        mov byte ptr [bp - 5], al
0B8B  83 7E FE 47     cmp word ptr [bp - 2], 0x47
0B8F  72 0C           jb 0xb9d
0B91  83 7E FE 53     cmp word ptr [bp - 2], 0x53
0B95  77 06           ja 0xb9d
0B97  C6 46 FB 00     mov byte ptr [bp - 5], 0
0B9B  EB 22           jmp 0xbbf
loc_0B9D:
0B9D  80 3E EC A3 00  cmp byte ptr [0xa3ec], 0
0BA2  74 1B           je 0xbbf
0BA4  8B 7E FE        mov di, word ptr [bp - 2]
0BA7  8A 85 3F A3     mov al, byte ptr [di - 0x5cc1]
0BAB  3C 61           cmp al, 0x61
0BAD  72 10           jb 0xbbf
0BAF  3C 7A           cmp al, 0x7a
0BB1  77 0C           ja 0xbbf
0BB3  80 7E FB 00     cmp byte ptr [bp - 5], 0
0BB7  B0 00           mov al, 0
0BB9  75 01           jne 0xbbc
0BBB  40              inc ax
loc_0BBC:
0BBC  88 46 FB        mov byte ptr [bp - 5], al
loc_0BBF:
0BBF  8B 56 FE        mov dx, word ptr [bp - 2]
0BC2  8A 46 FB        mov al, byte ptr [bp - 5]
0BC5  98              cwde
0BC6  6B F8 56        imul di, ax, 0x56
0BC9  03 FA           add di, dx
0BCB  8A 85 3F A3     mov al, byte ptr [di - 0x5cc1]
0BCF  30 E4           xor ah, ah
0BD1  89 46 FE        mov word ptr [bp - 2], ax
0BD4  83 7E FE 00     cmp word ptr [bp - 2], 0
0BD8  74 20           je 0xbfa
0BDA  8B 46 FE        mov ax, word ptr [bp - 2]
0BDD  A3 8C DE        mov word ptr [0xde8c], ax
0BE0  80 3E DB DE 00  cmp byte ptr [0xdedb], 0
0BE5  74 06           je 0xbed
0BE7  81 06 8C DE 00 02 add word ptr [0xde8c], 0x200
loc_0BED:
0BED  80 3E C0 DE 00  cmp byte ptr [0xdec0], 0
0BF2  74 06           je 0xbfa
0BF4  81 06 8C DE 00 01 add word ptr [0xde8c], 0x100
loc_0BFA:
0BFA  EB 0D           jmp 0xc09
loc_0BFC:
0BFC  8B 46 FE        mov ax, word ptr [bp - 2]
0BFF  25 7F 00        and ax, 0x7f
0C02  8B F8           mov di, ax
0C04  C6 85 A3 DE 00  mov byte ptr [di - 0x215d], 0
loc_0C09:
0C09  B0 20           mov al, 0x20
0C0B  E6 20           out 0x20, al
0C0D  C9              leave
0C0E  07              pop es
0C0F  1F              pop ds
0C10  5F              pop di
0C11  5E              pop si
0C12  5A              pop dx
0C13  59              pop cx
0C14  5B              pop bx
0C15  58              pop ax
0C16  CF              iret

; ---- routine 24AC:0C17  (found by: call, far)
sub_0C17:
0C17  55              push bp
0C18  89 E5           mov bp, sp
0C1A  83 3E 8E DE 00  cmp word ptr [0xde8e], 0
0C1F  76 1C           jbe 0xc3d
0C21  A1 90 DE        mov ax, word ptr [0xde90]
0C24  A3 88 DE        mov word ptr [0xde88], ax
0C27  BF 92 DE        mov di, 0xde92
0C2A  1E              push ds
0C2B  57              push di
0C2C  BF 90 DE        mov di, 0xde90
0C2F  1E              push ds
0C30  57              push di
0C31  6A 12           push 0x12
0C33  0E              push cs
0C34  E8 8B F5        call 0x1c2
0C37  FF 0E 8E DE     dec word ptr [0xde8e]
0C3B  EB 13           jmp 0xc50
loc_0C3D:
0C3D  0E              push cs
0C3E  E8 17 00        call 0xc58
0C41  08 C0           or al, al
0C43  74 F8           je 0xc3d
0C45  A1 8C DE        mov ax, word ptr [0xde8c]
0C48  A3 88 DE        mov word ptr [0xde88], ax
0C4B  31 C0           xor ax, ax
0C4D  A3 8C DE        mov word ptr [0xde8c], ax
loc_0C50:
0C50  A1 88 DE        mov ax, word ptr [0xde88]
0C53  A3 8A DE        mov word ptr [0xde8a], ax
0C56  C9              leave
0C57  CB              retf

; ---- routine 24AC:0C58  (found by: call, far)
sub_0C58:
0C58  C8 02 00 00     enter 2, 0
0C5C  BF 18 F9        mov di, 0xf918
0C5F  1E              push ds
0C60  57              push di
0C61  0E              push cs
0C62  E8 2A FD        call 0x98f
0C65  83 3E 8C DE 00  cmp word ptr [0xde8c], 0
0C6A  77 0B           ja 0xc77
0C6C  83 3E 8E DE 00  cmp word ptr [0xde8e], 0
0C71  77 04           ja 0xc77
0C73  B0 00           mov al, 0
0C75  EB 02           jmp 0xc79
loc_0C77:
0C77  B0 01           mov al, 1
loc_0C79:
0C79  88 46 FF        mov byte ptr [bp - 1], al
0C7C  8A 46 FF        mov al, byte ptr [bp - 1]
0C7F  C9              leave
0C80  CB              retf

; ---- routine 24AC:0C81  (found by: far)
sub_0C81:
0C81  55              push bp
0C82  89 E5           mov bp, sp
0C84  83 3E 8E DE 0A  cmp word ptr [0xde8e], 0xa
0C89  73 11           jae 0xc9c
0C8B  FF 06 8E DE     inc word ptr [0xde8e]
0C8F  8B 46 06        mov ax, word ptr [bp + 6]
0C92  8B 3E 8E DE     mov di, word ptr [0xde8e]
0C96  D1 E7           shl di, 1
0C98  89 85 8E DE     mov word ptr [di - 0x2172], ax
loc_0C9C:
0C9C  C9              leave
0C9D  CA 02 00        retf 2

; ---- routine 24AC:0CA0  (found by: call)
sub_0CA0:
0CA0  55              push bp
0CA1  89 E5           mov bp, sp
0CA3  31 C0           xor ax, ax
0CA5  A3 8E DE        mov word ptr [0xde8e], ax
0CA8  31 C0           xor ax, ax
0CAA  A3 8C DE        mov word ptr [0xde8c], ax
0CAD  31 C0           xor ax, ax
0CAF  A3 88 DE        mov word ptr [0xde88], ax
0CB2  BF A4 DE        mov di, 0xdea4
0CB5  1E              push ds
0CB6  57              push di
0CB7  6A 56           push 0x56
0CB9  6A 00           push 0
0CBB  0E              push cs
0CBC  E8 63 F5        call 0x222
0CBF  6A 09           push 9
0CC1  BF FA DE        mov di, 0xdefa
0CC4  1E              push ds
0CC5  57              push di
0CC6  9A 7C 00 A8 26  call far 26A8:007C
0CCB  6A 09           push 9
0CCD  BF D0 0A        mov di, 0xad0
0CD0  B8 AC 24        mov ax, 0x24ac   ; relocated segment word 24AC
0CD3  50              push ax
0CD4  57              push di
0CD5  9A 94 00 A8 26  call far 26A8:0094
0CDA  C9              leave
0CDB  C3              ret

; ---- routine 24AC:0CDC  (found by: call)
sub_0CDC:
0CDC  C8 02 00 00     enter 2, 0
0CE0  1E              push ds
0CE1  C5 76 08        lds si, ptr [bp + 8]
0CE4  1E              push ds
0CE5  56              push si
0CE6  AD              lodsw ax, word ptr [si]
0CE7  BB BD 7A        mov bx, 0x7abd
0CEA  F7 E3           mul bx
0CEC  05 0F 1B        add ax, 0x1b0f
0CEF  5F              pop di
0CF0  07              pop es
0CF1  AB              stosw word ptr es:[di], ax
0CF2  F7 66 06        mul word ptr [bp + 6]
0CF5  1F              pop ds
0CF6  42              inc dx
0CF7  89 56 FE        mov word ptr [bp - 2], dx
0CFA  8B 46 FE        mov ax, word ptr [bp - 2]
0CFD  C9              leave
0CFE  CA 06 00        retf 6

; ---- routine 24AC:0D01  (found by: far)
sub_0D01:
0D01  C8 02 00 00     enter 2, 0
0D05  C4 3E 84 DE     les di, ptr [0xde84]
0D09  06              push es
0D0A  57              push di
0D0B  FF 76 06        push word ptr [bp + 6]
0D0E  0E              push cs
0D0F  E8 CA FF        call 0xcdc
0D12  89 46 FE        mov word ptr [bp - 2], ax
0D15  8B 46 FE        mov ax, word ptr [bp - 2]
0D18  C9              leave
0D19  CA 02 00        retf 2

; ---- routine 24AC:0D1C  (found by: far)
sub_0D1C:
0D1C  C8 02 00 00     enter 2, 0
0D20  C4 3E 84 DE     les di, ptr [0xde84]
0D24  06              push es
0D25  57              push di
0D26  FF 76 06        push word ptr [bp + 6]
0D29  0E              push cs
0D2A  E8 AF FF        call 0xcdc
0D2D  3D 01 00        cmp ax, 1
0D30  B0 00           mov al, 0
0D32  75 01           jne 0xd35
0D34  40              inc ax
loc_0D35:
0D35  88 46 FF        mov byte ptr [bp - 1], al
0D38  8A 46 FF        mov al, byte ptr [bp - 1]
0D3B  C9              leave
0D3C  CA 02 00        retf 2

; ---- routine 24AC:0D3F  (found by: far)
sub_0D3F:
0D3F  C8 02 00 00     enter 2, 0
0D43  C4 3E 84 DE     les di, ptr [0xde84]
0D47  06              push es
0D48  57              push di
0D49  6A 02           push 2
0D4B  0E              push cs
0D4C  E8 8D FF        call 0xcdc
0D4F  3D 01 00        cmp ax, 1
0D52  B0 00           mov al, 0
0D54  75 01           jne 0xd57
0D56  40              inc ax
loc_0D57:
0D57  88 46 FF        mov byte ptr [bp - 1], al
0D5A  8A 46 FF        mov al, byte ptr [bp - 1]
0D5D  C9              leave
0D5E  CB              retf

; ---- routine 24AC:0D5F  (found by: call)
sub_0D5F:
0D5F  C8 14 00 00     enter 0x14, 0
0D63  C6 46 ED 02     mov byte ptr [bp - 0x13], 2
0D67  C6 46 EF 00     mov byte ptr [bp - 0x11], 0
0D6B  8A 46 08        mov al, byte ptr [bp + 8]
0D6E  88 46 F3        mov byte ptr [bp - 0xd], al
0D71  8A 46 06        mov al, byte ptr [bp + 6]
0D74  88 46 F2        mov byte ptr [bp - 0xe], al
0D77  6A 10           push 0x10
0D79  8D 7E EC        lea di, [bp - 0x14]
0D7C  16              push ss
0D7D  57              push di
0D7E  9A B2 00 A8 26  call far 26A8:00B2
0D83  C9              leave
0D84  CA 04 00        retf 4
; data (not reached as code), 251 bytes
0D87                  pstr ' not found'
0D92                  pstr 'Path not found'
0DA1                  pstr 'File access denied'
0DB4                  pstr 'Not enough memory'
0DC6                  pstr 'Write error'
0DD2                  pstr 'Disk read error - read beyond end of file'
0DFC                  pstr 'Disk is full'
0E09                  pstr 'Disk is write-protected'
0E21                  pstr 'Device not ready'
0E32                  pstr 'Unknown command'
0E42                  pstr 'Disk seek error'
0E52                  pstr 'Device write fault'
0E65                  pstr 'Device read fault'
0E77                  pstr 'Dos error '

; ---- routine 24AC:0E82  (found by: call)
sub_0E82:
0E82  C8 52 02 00     enter 0x252, 0
0E86  8C D3           mov bx, ss
0E88  8E C3           mov es, bx
0E8A  8C DB           mov bx, ds
0E8C  FC              cld
0E8D  8D 7E AE        lea di, [bp - 0x52]
0E90  C5 76 08        lds si, ptr [bp + 8]
0E93  AC              lodsb al, byte ptr [si]
0E94  3C 50           cmp al, 0x50
0E96  72 02           jb 0xe9a
0E98  B0 50           mov al, 0x50
loc_0E9A:
0E9A  AA              stosb byte ptr es:[di], al
0E9B  91              xchg cx, ax
0E9C  30 ED           xor ch, ch
0E9E  F3 A4           rep movsb byte ptr es:[di], byte ptr [si]
0EA0  8E DB           mov ds, bx
0EA2  80 3E F1 A3 00  cmp byte ptr [0xa3f1], 0
0EA7  75 03           jne 0xeac
0EA9  E9 26 01        jmp 0xfd2
loc_0EAC:
0EAC  8B 46 06        mov ax, word ptr [bp + 6]
0EAF  3D 00 00        cmp ax, 0
0EB2  74 05           je 0xeb9
0EB4  3D 01 00        cmp ax, 1
0EB7  75 03           jne 0xebc
loc_0EB9:
0EB9  E9 16 01        jmp 0xfd2
loc_0EBC:
0EBC  3D 02 00        cmp ax, 2
0EBF  75 21           jne 0xee2
0EC1  8D BE AE FE     lea di, [bp - 0x152]
0EC5  16              push ss
0EC6  57              push di
0EC7  8D 7E AE        lea di, [bp - 0x52]
0ECA  16              push ss
0ECB  57              push di
0ECC  9A 53 0B B9 26  call far 26B9:0B53
0ED1  BF 87 0D        mov di, 0xd87
0ED4  0E              push cs
0ED5  57              push di
0ED6  9A D2 0B B9 26  call far 26B9:0BD2
0EDB  0E              push cs
0EDC  E8 90 F7        call 0x66f
0EDF  E9 F0 00        jmp 0xfd2
loc_0EE2:
0EE2  3D 03 00        cmp ax, 3
0EE5  75 0C           jne 0xef3
0EE7  BF 92 0D        mov di, 0xd92
0EEA  0E              push cs
0EEB  57              push di
0EEC  0E              push cs
0EED  E8 7F F7        call 0x66f
0EF0  E9 DF 00        jmp 0xfd2
loc_0EF3:
0EF3  3D 05 00        cmp ax, 5
0EF6  75 0C           jne 0xf04
0EF8  BF A1 0D        mov di, 0xda1
0EFB  0E              push cs
0EFC  57              push di
0EFD  0E              push cs
0EFE  E8 6E F7        call 0x66f
0F01  E9 CE 00        jmp 0xfd2
loc_0F04:
0F04  3D 08 00        cmp ax, 8
0F07  75 0C           jne 0xf15
0F09  BF B4 0D        mov di, 0xdb4
0F0C  0E              push cs
0F0D  57              push di
0F0E  0E              push cs
0F0F  E8 5D F7        call 0x66f
0F12  E9 BD 00        jmp 0xfd2
loc_0F15:
0F15  3D 25 00        cmp ax, 0x25
0F18  75 0C           jne 0xf26
0F1A  BF C6 0D        mov di, 0xdc6
0F1D  0E              push cs
0F1E  57              push di
0F1F  0E              push cs
0F20  E8 4C F7        call 0x66f
0F23  E9 AC 00        jmp 0xfd2
loc_0F26:
0F26  3D 64 00        cmp ax, 0x64
0F29  75 0C           jne 0xf37
0F2B  BF D2 0D        mov di, 0xdd2
0F2E  0E              push cs
0F2F  57              push di
0F30  0E              push cs
0F31  E8 3B F7        call 0x66f
0F34  E9 9B 00        jmp 0xfd2
loc_0F37:
0F37  3D 65 00        cmp ax, 0x65
0F3A  75 0C           jne 0xf48
0F3C  BF FC 0D        mov di, 0xdfc
0F3F  0E              push cs
0F40  57              push di
0F41  0E              push cs
0F42  E8 2A F7        call 0x66f
0F45  E9 8A 00        jmp 0xfd2
loc_0F48:
0F48  3D 96 00        cmp ax, 0x96
0F4B  75 0B           jne 0xf58
0F4D  BF 09 0E        mov di, 0xe09
0F50  0E              push cs
0F51  57              push di
0F52  0E              push cs
0F53  E8 19 F7        call 0x66f
0F56  EB 7A           jmp 0xfd2
loc_0F58:
0F58  3D 98 00        cmp ax, 0x98
0F5B  75 0B           jne 0xf68
0F5D  BF 21 0E        mov di, 0xe21
0F60  0E              push cs
0F61  57              push di
0F62  0E              push cs
0F63  E8 09 F7        call 0x66f
0F66  EB 6A           jmp 0xfd2
loc_0F68:
0F68  3D 99 00        cmp ax, 0x99
0F6B  75 0B           jne 0xf78
0F6D  BF 32 0E        mov di, 0xe32
0F70  0E              push cs
0F71  57              push di
0F72  0E              push cs
0F73  E8 F9 F6        call 0x66f
0F76  EB 5A           jmp 0xfd2
loc_0F78:
0F78  3D 9C 00        cmp ax, 0x9c
0F7B  75 0B           jne 0xf88
0F7D  BF 42 0E        mov di, 0xe42
0F80  0E              push cs
0F81  57              push di
0F82  0E              push cs
0F83  E8 E9 F6        call 0x66f
0F86  EB 4A           jmp 0xfd2
loc_0F88:
0F88  3D A0 00        cmp ax, 0xa0
0F8B  75 0B           jne 0xf98
0F8D  BF 52 0E        mov di, 0xe52
0F90  0E              push cs
0F91  57              push di
0F92  0E              push cs
0F93  E8 D9 F6        call 0x66f
0F96  EB 3A           jmp 0xfd2
loc_0F98:
0F98  3D A1 00        cmp ax, 0xa1
0F9B  75 0B           jne 0xfa8
0F9D  BF 65 0E        mov di, 0xe65
0FA0  0E              push cs
0FA1  57              push di
0FA2  0E              push cs
0FA3  E8 C9 F6        call 0x66f
0FA6  EB 2A           jmp 0xfd2
loc_0FA8:
0FA8  8D BE AE FD     lea di, [bp - 0x252]
0FAC  16              push ss
0FAD  57              push di
0FAE  BF 77 0E        mov di, 0xe77
0FB1  0E              push cs
0FB2  57              push di
0FB3  9A 53 0B B9 26  call far 26B9:0B53
0FB8  8D BE AE FE     lea di, [bp - 0x152]
0FBC  16              push ss
0FBD  57              push di
0FBE  8B 46 06        mov ax, word ptr [bp + 6]
0FC1  31 D2           xor dx, dx
0FC3  52              push dx
0FC4  50              push ax
0FC5  0E              push cs
0FC6  E8 39 F8        call 0x802
0FC9  9A D2 0B B9 26  call far 26B9:0BD2
0FCE  0E              push cs
0FCF  E8 9D F6        call 0x66f
loc_0FD2:
0FD2  C9              leave
0FD3  CA 06 00        retf 6

; ---- routine 24AC:0FD6  (found by: call)
sub_0FD6:
0FD6  C8 52 00 00     enter 0x52, 0
0FDA  8C D3           mov bx, ss
0FDC  8E C3           mov es, bx
0FDE  8C DB           mov bx, ds
0FE0  FC              cld
0FE1  8D 7E AE        lea di, [bp - 0x52]
0FE4  C5 76 08        lds si, ptr [bp + 8]
0FE7  AC              lodsb al, byte ptr [si]
0FE8  3C 50           cmp al, 0x50
0FEA  72 02           jb 0xfee
0FEC  B0 50           mov al, 0x50
loc_0FEE:
0FEE  AA              stosb byte ptr es:[di], al
0FEF  91              xchg cx, ax
0FF0  30 ED           xor ch, ch
0FF2  F3 A4           rep movsb byte ptr es:[di], byte ptr [si]
0FF4  8E DB           mov ds, bx
0FF6  8D 7E AF        lea di, [bp - 0x51]
0FF9  16              push ss
0FFA  57              push di
0FFB  C4 7E 04        les di, ptr [bp + 4]
0FFE  06              push es
0FFF  57              push di
1000  8A 46 AE        mov al, byte ptr [bp - 0x52]
1003  30 E4           xor ah, ah
1005  50              push ax
1006  0E              push cs
1007  E8 B8 F1        call 0x1c2
100A  8A 46 AE        mov al, byte ptr [bp - 0x52]
100D  30 E4           xor ah, ah
100F  C4 7E 04        les di, ptr [bp + 4]
1012  03 F8           add di, ax
1014  26 C6 05 00     mov byte ptr es:[di], 0
1018  C9              leave
1019  C2 08 00        ret 8

; ---- routine 24AC:101C  (found by: call)
sub_101C:
101C  C8 04 00 00     enter 4, 0
1020  C4 7E 04        les di, ptr [bp + 4]
1023  89 7E FC        mov word ptr [bp - 4], di
1026  8C 46 FE        mov word ptr [bp - 2], es
1029  26 8B 45 12     mov ax, word ptr es:[di + 0x12]
102D  25 01 00        and ax, 1
1030  3D 01 00        cmp ax, 1
1033  75 0D           jne 0x1042
1035  31 C0           xor ax, ax
1037  A3 04 DF        mov word ptr [0xdf04], ax
103A  26 8B 05        mov ax, word ptr es:[di]
103D  A3 02 DF        mov word ptr [0xdf02], ax
1040  EB 0E           jmp 0x1050
loc_1042:
1042  31 C0           xor ax, ax
1044  A3 02 DF        mov word ptr [0xdf02], ax
1047  C4 7E FC        les di, ptr [bp - 4]
104A  26 8B 05        mov ax, word ptr es:[di]
104D  A3 04 DF        mov word ptr [0xdf04], ax
loc_1050:
1050  C9              leave
1051  C2 04 00        ret 4

; ---- routine 24AC:1054  (found by: call, far)
sub_1054:
1054  C8 14 00 00     enter 0x14, 0
1058  83 3E 04 DF 00  cmp word ptr [0xdf04], 0
105D  75 02           jne 0x1061
105F  EB 14           jmp 0x1075
loc_1061:
1061  A1 04 DF        mov ax, word ptr [0xdf04]
1064  89 46 EE        mov word ptr [bp - 0x12], ax
1067  C6 46 ED 3E     mov byte ptr [bp - 0x13], 0x3e
106B  8D 7E EC        lea di, [bp - 0x14]
106E  16              push ss
106F  57              push di
1070  9A A7 00 A8 26  call far 26A8:00A7
loc_1075:
1075  C9              leave
1076  CB              retf
; data (not reached as code), 45 bytes
1077                  pstr 'seeking '
1080                  pstr 'Drive not ready : Retry disk access'

; ---- routine 24AC:10A4  (found by: call)
sub_10A4:
10A4  C8 66 02 00     enter 0x266, 0
10A8  8C D3           mov bx, ss
10AA  8E C3           mov es, bx
10AC  8C DB           mov bx, ds
10AE  FC              cld
10AF  8D 7E AE        lea di, [bp - 0x52]
10B2  C5 76 06        lds si, ptr [bp + 6]
10B5  AC              lodsb al, byte ptr [si]
10B6  3C 50           cmp al, 0x50
10B8  72 02           jb 0x10bc
10BA  B0 50           mov al, 0x50
loc_10BC:
10BC  AA              stosb byte ptr es:[di], al
10BD  91              xchg cx, ax
10BE  30 ED           xor ch, ch
10C0  F3 A4           rep movsb byte ptr es:[di], byte ptr [si]
10C2  8E DB           mov ds, bx
10C4  80 3E F1 A3 00  cmp byte ptr [0xa3f1], 0
10C9  74 1E           je 0x10e9
10CB  8D BE 9A FD     lea di, [bp - 0x266]
10CF  16              push ss
10D0  57              push di
10D1  BF 77 10        mov di, 0x1077
10D4  0E              push cs
10D5  57              push di
10D6  9A 53 0B B9 26  call far 26B9:0B53
10DB  8D 7E AE        lea di, [bp - 0x52]
10DE  16              push ss
10DF  57              push di
10E0  9A D2 0B B9 26  call far 26B9:0BD2
10E5  0E              push cs
10E6  E8 4E F5        call 0x637
loc_10E9:
10E9  8D 7E AE        lea di, [bp - 0x52]
10EC  16              push ss
10ED  57              push di
10EE  8D BE 9A FE     lea di, [bp - 0x166]
10F2  16              push ss
10F3  57              push di
10F4  E8 DF FE        call 0xfd6
10F7  8D 7E AE        lea di, [bp - 0x52]
10FA  16              push ss
10FB  57              push di
10FC  BF 08 DF        mov di, 0xdf08
10FF  1E              push ds
1100  57              push di
1101  6A 50           push 0x50
1103  9A 6D 0B B9 26  call far 26B9:0B6D
loc_1108:
1108  8C D0           mov ax, ss
110A  89 46 A8        mov word ptr [bp - 0x58], ax
110D  8D 86 9A FE     lea ax, [bp - 0x166]
1111  89 46 A0        mov word ptr [bp - 0x60], ax
1114  31 C0           xor ax, ax
1116  89 46 9E        mov word ptr [bp - 0x62], ax
1119  8B 46 04        mov ax, word ptr [bp + 4]
111C  89 46 9A        mov word ptr [bp - 0x66], ax
111F  8D 7E 9A        lea di, [bp - 0x66]
1122  16              push ss
1123  57              push di
1124  9A A7 00 A8 26  call far 26A8:00A7
1129  8D 7E 9A        lea di, [bp - 0x66]
112C  16              push ss
112D  57              push di
112E  E8 EB FE        call 0x101c
1131  80 3E F1 A3 00  cmp byte ptr [0xa3f1], 0
1136  75 02           jne 0x113a
1138  EB 2A           jmp 0x1164
loc_113A:
113A  81 3E 02 DF 98 00 cmp word ptr [0xdf02], 0x98
1140  74 0D           je 0x114f
1142  BF 08 DF        mov di, 0xdf08
1145  1E              push ds
1146  57              push di
1147  FF 36 02 DF     push word ptr [0xdf02]
114B  0E              push cs
114C  E8 33 FD        call 0xe82
loc_114F:
114F  81 3E 02 DF 98 00 cmp word ptr [0xdf02], 0x98
1155  75 0D           jne 0x1164
1157  BF 80 10        mov di, 0x1080
115A  0E              push cs
115B  57              push di
115C  0E              push cs
115D  E8 24 F6        call 0x784
1160  08 C0           or al, al
1162  75 A4           jne 0x1108
loc_1164:
1164  C9              leave
1165  C2 06 00        ret 6
; data (not reached as code), 2 bytes
1168                  db 01 5C   ; .\

; ---- routine 24AC:116A  (found by: far)
sub_116A:
116A  C8 14 00 00     enter 0x14, 0
116E  83 7E 06 00     cmp word ptr [bp + 6], 0
1172  74 07           je 0x117b
1174  83 3E 04 DF 00  cmp word ptr [0xdf04], 0
1179  75 02           jne 0x117d
loc_117B:
117B  EB 60           jmp 0x11dd
loc_117D:
117D  C4 7E 08        les di, ptr [bp + 8]
1180  8C C0           mov ax, es
1182  89 46 FA        mov word ptr [bp - 6], ax
1185  89 F8           mov ax, di
1187  89 46 F2        mov word ptr [bp - 0xe], ax
118A  C6 46 ED 40     mov byte ptr [bp - 0x13], 0x40
118E  A1 04 DF        mov ax, word ptr [0xdf04]
1191  89 46 EE        mov word ptr [bp - 0x12], ax
1194  8B 46 06        mov ax, word ptr [bp + 6]
1197  89 46 F0        mov word ptr [bp - 0x10], ax
119A  8D 7E EC        lea di, [bp - 0x14]
119D  16              push ss
119E  57              push di
119F  9A A7 00 A8 26  call far 26A8:00A7
11A4  8B 46 FE        mov ax, word ptr [bp - 2]
11A7  25 01 00        and ax, 1
11AA  3D 01 00        cmp ax, 1
11AD  75 08           jne 0x11b7
11AF  8B 46 EC        mov ax, word ptr [bp - 0x14]
11B2  A3 02 DF        mov word ptr [0xdf02], ax
11B5  EB 15           jmp 0x11cc
loc_11B7:
11B7  8B 46 EC        mov ax, word ptr [bp - 0x14]
11BA  3B 46 F0        cmp ax, word ptr [bp - 0x10]
11BD  74 0D           je 0x11cc
11BF  83 3E 04 DF 04  cmp word ptr [0xdf04], 4
11C4  74 06           je 0x11cc
11C6  C7 06 02 DF 25 00 mov word ptr [0xdf02], 0x25
loc_11CC:
11CC  BF 68 11        mov di, 0x1168
11CF  0E              push cs
11D0  57              push di
11D1  BF 3D A4        mov di, 0xa43d
11D4  1E              push ds
11D5  57              push di
11D6  6A 0C           push 0xc
11D8  9A 6D 0B B9 26  call far 26B9:0B6D
loc_11DD:
11DD  C9              leave
11DE  CA 06 00        retf 6

; ---- routine 24AC:11E1  (found by: call, far)
sub_11E1:
11E1  C8 14 00 00     enter 0x14, 0
11E5  83 7E 06 00     cmp word ptr [bp + 6], 0
11E9  74 07           je 0x11f2
11EB  83 3E 04 DF 00  cmp word ptr [0xdf04], 0
11F0  75 02           jne 0x11f4
loc_11F2:
11F2  EB 52           jmp 0x1246
loc_11F4:
11F4  C4 7E 08        les di, ptr [bp + 8]
11F7  8C C0           mov ax, es
11F9  89 46 FA        mov word ptr [bp - 6], ax
11FC  89 F8           mov ax, di
11FE  89 46 F2        mov word ptr [bp - 0xe], ax
1201  C6 46 ED 3F     mov byte ptr [bp - 0x13], 0x3f
1205  A1 04 DF        mov ax, word ptr [0xdf04]
1208  89 46 EE        mov word ptr [bp - 0x12], ax
120B  8B 46 06        mov ax, word ptr [bp + 6]
120E  89 46 F0        mov word ptr [bp - 0x10], ax
1211  8D 7E EC        lea di, [bp - 0x14]
1214  16              push ss
1215  57              push di
1216  9A A7 00 A8 26  call far 26A8:00A7
121B  8B 46 F0        mov ax, word ptr [bp - 0x10]
121E  A3 00 DF        mov word ptr [0xdf00], ax
1221  8B 46 FE        mov ax, word ptr [bp - 2]
1224  25 01 00        and ax, 1
1227  3D 01 00        cmp ax, 1
122A  75 06           jne 0x1232
122C  8B 46 EC        mov ax, word ptr [bp - 0x14]
122F  A3 02 DF        mov word ptr [0xdf02], ax
loc_1232:
1232  83 7E EC 00     cmp word ptr [bp - 0x14], 0
1236  74 0E           je 0x1246
1238  8B 46 EC        mov ax, word ptr [bp - 0x14]
123B  3B 46 F0        cmp ax, word ptr [bp - 0x10]
123E  73 06           jae 0x1246
1240  8B 46 EC        mov ax, word ptr [bp - 0x14]
1243  A3 00 DF        mov word ptr [0xdf00], ax
loc_1246:
1246  C9              leave
1247  CA 06 00        retf 6
; data (not reached as code), 35 bytes
124A                  pstr 'printer not ready'
125C                  pstr 'printer off line'

; ---- routine 24AC:126D  (found by: far)
sub_126D:
126D  C8 16 00 00     enter 0x16, 0
1271  C6 46 FF 00     mov byte ptr [bp - 1], 0
1275  C6 46 EB 02     mov byte ptr [bp - 0x15], 2
1279  31 C0           xor ax, ax
127B  89 46 F0        mov word ptr [bp - 0x10], ax
127E  6A 17           push 0x17
1280  8D 7E EA        lea di, [bp - 0x16]
1283  16              push ss
1284  57              push di
1285  9A B2 00 A8 26  call far 26A8:00B2
128A  8A 46 EB        mov al, byte ptr [bp - 0x15]
128D  24 80           and al, 0x80
128F  08 C0           or al, al
1291  74 12           je 0x12a5
1293  8A 46 EB        mov al, byte ptr [bp - 0x15]
1296  24 40           and al, 0x40
1298  3C 40           cmp al, 0x40
129A  74 09           je 0x12a5
129C  8A 46 EB        mov al, byte ptr [bp - 0x15]
129F  24 20           and al, 0x20
12A1  3C 20           cmp al, 0x20
12A3  75 0B           jne 0x12b0
loc_12A5:
12A5  BF 4A 12        mov di, 0x124a
12A8  0E              push cs
12A9  57              push di
12AA  0E              push cs
12AB  E8 C1 F3        call 0x66f
12AE  EB 18           jmp 0x12c8
loc_12B0:
12B0  8A 46 EB        mov al, byte ptr [bp - 0x15]
12B3  24 08           and al, 8
12B5  3C 08           cmp al, 8
12B7  75 0B           jne 0x12c4
12B9  BF 5C 12        mov di, 0x125c
12BC  0E              push cs
12BD  57              push di
12BE  0E              push cs
12BF  E8 AD F3        call 0x66f
12C2  EB 04           jmp 0x12c8
loc_12C4:
12C4  C6 46 FF 01     mov byte ptr [bp - 1], 1
loc_12C8:
12C8  8A 46 FF        mov al, byte ptr [bp - 1]
12CB  C9              leave
12CC  CB              retf

