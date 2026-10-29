; 1-095.EXE (One-Nil 95), code segment 0AB5 (image offsets 0AB50..1993F), part 2 of 22
; packed 1-095.EXE sha256 f659fb2d334500d6901fc8d6a0f06c85c0ccda2eb4a3035ae3bb0a0004d79192 (LZEXE 0.91)
; unpacked (tools/static/unlzexe.py) sha256 8df646e017e0965a5d90a58181ca764219ad847833aad0b6cb58fc53372bfb2c
; tool: capstone 5.0.9 (pip package; core library 5.0.1280) (CS_ARCH_X86, CS_MODE_16), recursive descent from the entry point, far calls and near calls/jumps, then routine prologues (55 89 E5 / 55 8B EC / C8 iw 00) in what remains; tools/static/listing.py
; addresses are SEGMENT:OFFSET with SEGMENT the image paragraph before relocation; image offset = SEGMENT*16+OFFSET
; ---- routine 0AB5:0B53  (found by: call)
sub_0B53:
0B53  C8 0E 00 00     enter 0xe, 0
0B57  83 3E 80 03 00  cmp word ptr [0x380], 0
0B5C  75 03           jne 0xb61
0B5E  E9 1B 02        jmp 0xd7c
loc_0B61:
0B61  C4 3E 8A D0     les di, ptr [0xd08a]
0B65  06              push es
0B66  57              push di
0B67  C4 3E 96 D0     les di, ptr [0xd096]
0B6B  06              push es
0B6C  57              push di
0B6D  68 A0 0F        push 0xfa0
0B70  9A 12 0A B9 26  call far 26B9:0A12
0B75  B8 1C 1A        mov ax, 0x1a1c
0B78  8C DA           mov dx, ds
0B7A  89 46 F6        mov word ptr [bp - 0xa], ax
0B7D  89 56 F8        mov word ptr [bp - 8], dx
0B80  80 3E 47 CF 00  cmp byte ptr [0xcf47], 0
0B85  B0 00           mov al, 0
0B87  7D 01           jge 0xb8a
0B89  40              inc ax
loc_0B8A:
0B8A  98              cwde
0B8B  8B F8           mov di, ax
0B8D  D1 E7           shl di, 1
0B8F  8B 85 76 09     mov ax, word ptr [di + 0x976]
0B93  C4 7E F6        les di, ptr [bp - 0xa]
0B96  26 89 05        mov word ptr es:[di], ax
0B99  A1 80 03        mov ax, word ptr [0x380]
0B9C  89 46 FE        mov word ptr [bp - 2], ax
0B9F  BF 1C 1A        mov di, 0x1a1c
0BA2  1E              push ds
0BA3  57              push di
0BA4  BF 58 DD        mov di, 0xdd58
0BA7  1E              push ds
0BA8  57              push di
0BA9  9A 2F 05 1A 23  call far 231A:052F
0BAE  BF 82 1A        mov di, 0x1a82
0BB1  1E              push ds
0BB2  57              push di
0BB3  BF 58 DD        mov di, 0xdd58
0BB6  1E              push ds
0BB7  57              push di
0BB8  9A 2F 05 1A 23  call far 231A:052F
loc_0BBD:
0BBD  8B 46 FE        mov ax, word ptr [bp - 2]
0BC0  89 46 FC        mov word ptr [bp - 4], ax
0BC3  C7 46 FA 11 00  mov word ptr [bp - 6], 0x11
0BC8  EB 03           jmp 0xbcd
loc_0BCA:
0BCA  FF 4E FA        dec word ptr [bp - 6]
loc_0BCD:
0BCD  8B 7E FC        mov di, word ptr [bp - 4]
0BD0  D1 E7           shl di, 1
0BD2  8B F7           mov si, di
0BD4  D1 E7           shl di, 1
0BD6  01 F7           add di, si
0BD8  80 BD 2A A5 FF  cmp byte ptr [di - 0x5ad6], 0xff
0BDD  B0 00           mov al, 0
0BDF  75 01           jne 0xbe2
0BE1  40              inc ax
loc_0BE2:
0BE2  88 46 F5        mov byte ptr [bp - 0xb], al
0BE5  80 7E F5 00     cmp byte ptr [bp - 0xb], 0
0BE9  74 30           je 0xc1b
0BEB  6A 00           push 0
0BED  C4 7E F6        les di, ptr [bp - 0xa]
0BF0  26 8B 05        mov ax, word ptr es:[di]
0BF3  2D 8F 01        sub ax, 0x18f
0BF6  50              push ax
0BF7  C4 7E F6        les di, ptr [bp - 0xa]
0BFA  26 8B 05        mov ax, word ptr es:[di]
0BFD  2D 6F 01        sub ax, 0x16f
0C00  50              push ax
0C01  8B 46 FA        mov ax, word ptr [bp - 6]
0C04  05 06 00        add ax, 6
0C07  50              push ax
0C08  8B 46 FA        mov ax, word ptr [bp - 6]
0C0B  05 06 00        add ax, 6
0C0E  50              push ax
0C0F  BF 58 DD        mov di, 0xdd58
0C12  1E              push ds
0C13  57              push di
0C14  9A 07 05 1A 23  call far 231A:0507
0C19  EB 28           jmp 0xc43
loc_0C1B:
0C1B  FF 76 FC        push word ptr [bp - 4]
0C1E  8B 46 FA        mov ax, word ptr [bp - 6]
0C21  05 06 00        add ax, 6
0C24  50              push ax
0C25  C4 7E F6        les di, ptr [bp - 0xa]
0C28  26 8B 05        mov ax, word ptr es:[di]
0C2B  2D 8F 01        sub ax, 0x18f
0C2E  50              push ax
0C2F  E8 8B FD        call 0x9bd
0C32  8D 7E FC        lea di, [bp - 4]
0C35  16              push ss
0C36  57              push di
0C37  6A 01           push 1
0C39  68 A4 06        push 0x6a4
0C3C  6A FF           push -1
0C3E  9A 2B 04 AC 24  call far 24AC:042B
loc_0C43:
0C43  83 7E FA 01     cmp word ptr [bp - 6], 1
0C47  75 81           jne 0xbca
0C49  9A 9B 09 1A 23  call far 231A:099B
0C4E  A0 88 DE        mov al, byte ptr [0xde88]
0C51  3C 05           cmp al, 5
0C53  74 04           je 0xc59
0C55  3C 0B           cmp al, 0xb
0C57  75 48           jne 0xca1
loc_0C59:
0C59  80 7E F5 00     cmp byte ptr [bp - 0xb], 0
0C5D  75 3F           jne 0xc9e
0C5F  80 3E 88 DE 0B  cmp byte ptr [0xde88], 0xb
0C64  B0 00           mov al, 0
0C66  75 01           jne 0xc69
0C68  40              inc ax
loc_0C69:
0C69  98              cwde
0C6A  8B F8           mov di, ax
0C6C  8A 85 74 09     mov al, byte ptr [di + 0x974]
0C70  30 E4           xor ah, ah
0C72  89 46 F2        mov word ptr [bp - 0xe], ax
0C75  B8 01 00        mov ax, 1
0C78  3B 46 F2        cmp ax, word ptr [bp - 0xe]
0C7B  7F 21           jg 0xc9e
0C7D  89 46 FA        mov word ptr [bp - 6], ax
0C80  EB 03           jmp 0xc85
loc_0C82:
0C82  FF 46 FA        inc word ptr [bp - 6]
loc_0C85:
0C85  8D 7E FE        lea di, [bp - 2]
0C88  16              push ss
0C89  57              push di
0C8A  6A 01           push 1
0C8C  68 A4 06        push 0x6a4
0C8F  6A FF           push -1
0C91  9A 2B 04 AC 24  call far 24AC:042B
0C96  8B 46 FA        mov ax, word ptr [bp - 6]
0C99  3B 46 F2        cmp ax, word ptr [bp - 0xe]
0C9C  75 E4           jne 0xc82
loc_0C9E:
0C9E  E9 B1 00        jmp 0xd52
loc_0CA1:
0CA1  3C 06           cmp al, 6
0CA3  74 04           je 0xca9
0CA5  3C 0C           cmp al, 0xc
0CA7  75 4A           jne 0xcf3
loc_0CA9:
0CA9  80 3E 88 DE 0C  cmp byte ptr [0xde88], 0xc
0CAE  B0 00           mov al, 0
0CB0  75 01           jne 0xcb3
0CB2  40              inc ax
loc_0CB3:
0CB3  98              cwde
0CB4  8B F8           mov di, ax
0CB6  8A 85 74 09     mov al, byte ptr [di + 0x974]
0CBA  30 E4           xor ah, ah
0CBC  89 46 F2        mov word ptr [bp - 0xe], ax
0CBF  B8 01 00        mov ax, 1
0CC2  3B 46 F2        cmp ax, word ptr [bp - 0xe]
0CC5  7F 2A           jg 0xcf1
0CC7  89 46 FA        mov word ptr [bp - 6], ax
0CCA  EB 03           jmp 0xccf
loc_0CCC:
0CCC  FF 46 FA        inc word ptr [bp - 6]
loc_0CCF:
0CCF  8B 46 FE        mov ax, word ptr [bp - 2]
0CD2  3B 06 80 03     cmp ax, word ptr [0x380]
0CD6  74 11           je 0xce9
0CD8  8D 7E FE        lea di, [bp - 2]
0CDB  16              push ss
0CDC  57              push di
0CDD  6A 01           push 1
0CDF  68 A4 06        push 0x6a4
0CE2  6A 01           push 1
0CE4  9A 2B 04 AC 24  call far 24AC:042B
loc_0CE9:
0CE9  8B 46 FA        mov ax, word ptr [bp - 6]
0CEC  3B 46 F2        cmp ax, word ptr [bp - 0xe]
0CEF  75 DB           jne 0xccc
loc_0CF1:
0CF1  EB 5F           jmp 0xd52
loc_0CF3:
0CF3  3C 09           cmp al, 9
0CF5  75 51           jne 0xd48
loc_0CF7:
0CF7  8B 7E FE        mov di, word ptr [bp - 2]
0CFA  D1 E7           shl di, 1
0CFC  8B F7           mov si, di
0CFE  D1 E7           shl di, 1
0D00  01 F7           add di, si
0D02  80 BD 2A A5 FF  cmp byte ptr [di - 0x5ad6], 0xff
0D07  74 13           je 0xd1c
0D09  8D 7E FE        lea di, [bp - 2]
0D0C  16              push ss
0D0D  57              push di
0D0E  6A 01           push 1
0D10  68 A4 06        push 0x6a4
0D13  6A FF           push -1
0D15  9A 2B 04 AC 24  call far 24AC:042B
0D1A  EB DB           jmp 0xcf7
loc_0D1C:
0D1C  C7 46 FA 01 00  mov word ptr [bp - 6], 1
0D21  EB 03           jmp 0xd26
loc_0D23:
0D23  FF 46 FA        inc word ptr [bp - 6]
loc_0D26:
0D26  8B 46 FE        mov ax, word ptr [bp - 2]
0D29  3B 06 80 03     cmp ax, word ptr [0x380]
0D2D  74 11           je 0xd40
0D2F  8D 7E FE        lea di, [bp - 2]
0D32  16              push ss
0D33  57              push di
0D34  6A 01           push 1
0D36  68 A4 06        push 0x6a4
0D39  6A 01           push 1
0D3B  9A 2B 04 AC 24  call far 24AC:042B
loc_0D40:
0D40  83 7E FA 11     cmp word ptr [bp - 6], 0x11
0D44  75 DD           jne 0xd23
0D46  EB 0A           jmp 0xd52
loc_0D48:
0D48  3C 0A           cmp al, 0xa
0D4A  75 06           jne 0xd52
0D4C  A1 80 03        mov ax, word ptr [0x380]
0D4F  89 46 FE        mov word ptr [bp - 2], ax
loc_0D52:
0D52  A0 88 DE        mov al, byte ptr [0xde88]
0D55  3C 01           cmp al, 1
0D57  73 03           jae 0xd5c
0D59  E9 61 FE        jmp 0xbbd
loc_0D5C:
0D5C  3C 02           cmp al, 2
0D5E  76 03           jbe 0xd63
0D60  E9 5A FE        jmp 0xbbd
loc_0D63:
0D63  C4 3E 96 D0     les di, ptr [0xd096]
0D67  06              push es
0D68  57              push di
0D69  C4 3E 8A D0     les di, ptr [0xd08a]
0D6D  06              push es
0D6E  57              push di
0D6F  68 A0 0F        push 0xfa0
0D72  9A 12 0A B9 26  call far 26B9:0A12
0D77  C6 06 88 DE 00  mov byte ptr [0xde88], 0
loc_0D7C:
0D7C  C9              leave
0D7D  C3              ret

; ---- routine 0AB5:0D7E  (found by: call)
sub_0D7E:
0D7E  C8 0E 00 00     enter 0xe, 0
0D82  8B 3E 80 03     mov di, word ptr [0x380]
0D86  D1 E7           shl di, 1
0D88  8B F7           mov si, di
0D8A  D1 E7           shl di, 1
0D8C  01 F7           add di, si
0D8E  81 C7 2A A5     add di, 0xa52a
0D92  1E              push ds
0D93  07              pop es
0D94  89 7E F6        mov word ptr [bp - 0xa], di
0D97  8C 46 F8        mov word ptr [bp - 8], es
0D9A  8B 7E 04        mov di, word ptr [bp + 4]
0D9D  36 8A 45 0A     mov al, byte ptr ss:[di + 0xa]
0DA1  98              cwde
0DA2  8B F8           mov di, ax
0DA4  D1 E7           shl di, 1
0DA6  6B 85 E4 D6 3E  imul ax, word ptr [di - 0x291c], 0x3e
0DAB  C4 3E C2 D7     les di, ptr [0xd7c2]
0DAF  03 F8           add di, ax
0DB1  81 C7 C2 FF     add di, 0xffc2
0DB5  89 7E F2        mov word ptr [bp - 0xe], di
0DB8  8C 46 F4        mov word ptr [bp - 0xc], es
0DBB  8B 7E 04        mov di, word ptr [bp + 4]
0DBE  36 83 7D 08 00  cmp word ptr ss:[di + 8], 0
0DC3  75 07           jne 0xdcc
0DC5  31 C0           xor ax, ax
0DC7  89 46 FC        mov word ptr [bp - 4], ax
0DCA  EB 15           jmp 0xde1
loc_0DCC:
0DCC  8B 7E 04        mov di, word ptr [bp + 4]
0DCF  36 8B 45 08     mov ax, word ptr ss:[di + 8]
0DD3  D1 E0           shl ax, 1
0DD5  C4 7E F2        les di, ptr [bp - 0xe]
0DD8  03 F8           add di, ax
0DDA  26 8B 45 FE     mov ax, word ptr es:[di - 2]
0DDE  89 46 FC        mov word ptr [bp - 4], ax
loc_0DE1:
0DE1  8B 7E 04        mov di, word ptr [bp + 4]
0DE4  36 83 7D 06 00  cmp word ptr ss:[di + 6], 0
0DE9  75 07           jne 0xdf2
0DEB  31 C0           xor ax, ax
0DED  89 46 FA        mov word ptr [bp - 6], ax
0DF0  EB 15           jmp 0xe07
loc_0DF2:
0DF2  8B 7E 04        mov di, word ptr [bp + 4]
0DF5  36 8B 45 06     mov ax, word ptr ss:[di + 6]
0DF9  D1 E0           shl ax, 1
0DFB  C4 7E F2        les di, ptr [bp - 0xe]
0DFE  03 F8           add di, ax
0E00  26 8B 45 FE     mov ax, word ptr es:[di - 2]
0E04  89 46 FA        mov word ptr [bp - 6], ax
loc_0E07:
0E07  8B 7E 04        mov di, word ptr [bp + 4]
0E0A  36 8A 45 04     mov al, byte ptr ss:[di + 4]
0E0E  C4 7E F6        les di, ptr [bp - 0xa]
0E11  26 3A 05        cmp al, byte ptr es:[di]
0E14  75 23           jne 0xe39
0E16  8B 46 FC        mov ax, word ptr [bp - 4]
0E19  26 3B 45 01     cmp ax, word ptr es:[di + 1]
0E1D  75 1A           jne 0xe39
0E1F  8B 46 FA        mov ax, word ptr [bp - 6]
0E22  26 3B 45 03     cmp ax, word ptr es:[di + 3]
0E26  75 11           jne 0xe39
0E28  26 8A 45 05     mov al, byte ptr es:[di + 5]
0E2C  8B 7E 04        mov di, word ptr [bp + 4]
0E2F  36 3A 45 0A     cmp al, byte ptr ss:[di + 0xa]
0E33  75 04           jne 0xe39
0E35  B0 00           mov al, 0
0E37  EB 02           jmp 0xe3b
loc_0E39:
0E39  B0 01           mov al, 1
loc_0E3B:
0E3B  88 46 FF        mov byte ptr [bp - 1], al
0E3E  8A 46 FF        mov al, byte ptr [bp - 1]
0E41  C9              leave
0E42  C2 02 00        ret 2

; ---- routine 0AB5:0E45  (found by: call)
sub_0E45:
0E45  C8 0C 00 00     enter 0xc, 0
0E49  C6 46 FF 00     mov byte ptr [bp - 1], 0
0E4D  83 3E 80 03 00  cmp word ptr [0x380], 0
0E52  74 0B           je 0xe5f
0E54  55              push bp
0E55  E8 26 FF        call 0xd7e
0E58  08 C0           or al, al
0E5A  75 03           jne 0xe5f
0E5C  E9 DC 00        jmp 0xf3b
loc_0E5F:
0E5F  8A 46 0A        mov al, byte ptr [bp + 0xa]
0E62  98              cwde
0E63  8B F8           mov di, ax
0E65  D1 E7           shl di, 1
0E67  FF 85 C0 D1     inc word ptr [di - 0x2e40]
0E6B  BF 80 03        mov di, 0x380
0E6E  1E              push ds
0E6F  57              push di
0E70  6A 01           push 1
0E72  68 A4 06        push 0x6a4
0E75  6A 01           push 1
0E77  9A 2B 04 AC 24  call far 24AC:042B
0E7C  8B 3E 80 03     mov di, word ptr [0x380]
0E80  D1 E7           shl di, 1
0E82  8B F7           mov si, di
0E84  D1 E7           shl di, 1
0E86  01 F7           add di, si
0E88  81 C7 2A A5     add di, 0xa52a
0E8C  1E              push ds
0E8D  07              pop es
0E8E  89 7E F8        mov word ptr [bp - 8], di
0E91  8C 46 FA        mov word ptr [bp - 6], es
0E94  8A 46 0A        mov al, byte ptr [bp + 0xa]
0E97  98              cwde
0E98  8B F8           mov di, ax
0E9A  D1 E7           shl di, 1
0E9C  6B 85 E4 D6 3E  imul ax, word ptr [di - 0x291c], 0x3e
0EA1  C4 3E C2 D7     les di, ptr [0xd7c2]
0EA5  03 F8           add di, ax
0EA7  81 C7 C2 FF     add di, 0xffc2
0EAB  89 7E F4        mov word ptr [bp - 0xc], di
0EAE  8C 46 F6        mov word ptr [bp - 0xa], es
0EB1  8A 46 04        mov al, byte ptr [bp + 4]
0EB4  C4 7E F8        les di, ptr [bp - 8]
0EB7  26 88 05        mov byte ptr es:[di], al
0EBA  83 7E 08 00     cmp word ptr [bp + 8], 0
0EBE  76 17           jbe 0xed7
0EC0  8B 46 08        mov ax, word ptr [bp + 8]
0EC3  D1 E0           shl ax, 1
0EC5  C4 7E F4        les di, ptr [bp - 0xc]
0EC8  03 F8           add di, ax
0ECA  26 8B 45 FE     mov ax, word ptr es:[di - 2]
0ECE  C4 7E F8        les di, ptr [bp - 8]
0ED1  26 89 45 01     mov word ptr es:[di + 1], ax
0ED5  EB 09           jmp 0xee0
loc_0ED7:
0ED7  C4 7E F8        les di, ptr [bp - 8]
0EDA  31 C0           xor ax, ax
0EDC  26 89 45 01     mov word ptr es:[di + 1], ax
loc_0EE0:
0EE0  83 7E 06 00     cmp word ptr [bp + 6], 0
0EE4  76 17           jbe 0xefd
0EE6  8B 46 06        mov ax, word ptr [bp + 6]
0EE9  D1 E0           shl ax, 1
0EEB  C4 7E F4        les di, ptr [bp - 0xc]
0EEE  03 F8           add di, ax
0EF0  26 8B 45 FE     mov ax, word ptr es:[di - 2]
0EF4  C4 7E F8        les di, ptr [bp - 8]
0EF7  26 89 45 03     mov word ptr es:[di + 3], ax
0EFB  EB 09           jmp 0xf06
loc_0EFD:
0EFD  C4 7E F8        les di, ptr [bp - 8]
0F00  31 C0           xor ax, ax
0F02  26 89 45 03     mov word ptr es:[di + 3], ax
loc_0F06:
0F06  8A 46 0A        mov al, byte ptr [bp + 0xa]
0F09  C4 7E F8        les di, ptr [bp - 8]
0F0C  26 88 45 05     mov byte ptr es:[di + 5], al
0F10  A1 80 03        mov ax, word ptr [0x380]
0F13  89 46 FC        mov word ptr [bp - 4], ax
0F16  8D 7E FC        lea di, [bp - 4]
0F19  16              push ss
0F1A  57              push di
0F1B  6A 01           push 1
0F1D  68 A4 06        push 0x6a4
0F20  6A 01           push 1
0F22  9A 2B 04 AC 24  call far 24AC:042B
0F27  8B 7E FC        mov di, word ptr [bp - 4]
0F2A  D1 E7           shl di, 1
0F2C  8B F7           mov si, di
0F2E  D1 E7           shl di, 1
0F30  01 F7           add di, si
0F32  C6 85 2A A5 FF  mov byte ptr [di - 0x5ad6], 0xff
0F37  C6 46 FF 01     mov byte ptr [bp - 1], 1
loc_0F3B:
0F3B  8A 46 FF        mov al, byte ptr [bp - 1]
0F3E  C9              leave
0F3F  C2 08 00        ret 8

; ---- routine 0AB5:0F42  (found by: call)
sub_0F42:
0F42  C8 04 00 00     enter 4, 0
0F46  8B 7E 04        mov di, word ptr [bp + 4]
0F49  36 8A 45 0A     mov al, byte ptr ss:[di + 0xa]
0F4D  98              cwde
0F4E  8B F8           mov di, ax
0F50  8A 85 56 0D     mov al, byte ptr [di + 0xd56]
0F54  30 E4           xor ah, ah
0F56  8B 7E 04        mov di, word ptr [bp + 4]
0F59  36 03 45 08     add ax, word ptr ss:[di + 8]
0F5D  6B F8 19        imul di, ax, 0x19
0F60  81 C7 EF CC     add di, 0xccef
0F64  1E              push ds
0F65  07              pop es
0F66  8B 7E 04        mov di, word ptr [bp + 4]
0F69  36 8A 45 04     mov al, byte ptr ss:[di + 4]
0F6D  98              cwde
0F6E  8B F8           mov di, ax
0F70  8A 85 7A 09     mov al, byte ptr [di + 0x97a]
0F74  98              cwde
0F75  8B C8           mov cx, ax
0F77  8B 7E 04        mov di, word ptr [bp + 4]
0F7A  36 8B 45 08     mov ax, word ptr ss:[di + 8]
0F7E  D1 E0           shl ax, 1
0F80  8B D0           mov dx, ax
0F82  36 8A 45 0A     mov al, byte ptr ss:[di + 0xa]
0F86  98              cwde
0F87  6B F8 28        imul di, ax, 0x28
0F8A  03 FA           add di, dx
0F8C  01 8D 46 D1     add word ptr [di - 0x2eba], cx
0F90  C9              leave
0F91  C2 02 00        ret 2

; ---- routine 0AB5:0F94  (found by: call)
sub_0F94:
0F94  C8 04 00 00     enter 4, 0
0F98  55              push bp
0F99  E8 A6 FF        call 0xf42
0F9C  8A 46 0A        mov al, byte ptr [bp + 0xa]
0F9F  50              push ax
0FA0  FF 76 08        push word ptr [bp + 8]
0FA3  FF 76 06        push word ptr [bp + 6]
0FA6  8A 46 04        mov al, byte ptr [bp + 4]
0FA9  50              push ax
0FAA  E8 98 FE        call 0xe45
0FAD  08 C0           or al, al
0FAF  74 4B           je 0xffc
0FB1  A1 80 03        mov ax, word ptr [0x380]
0FB4  05 FE FF        add ax, 0xfffe
0FB7  89 46 FC        mov word ptr [bp - 4], ax
0FBA  A1 80 03        mov ax, word ptr [0x380]
0FBD  3B 46 FC        cmp ax, word ptr [bp - 4]
0FC0  7C 2C           jl 0xfee
0FC2  89 46 FE        mov word ptr [bp - 2], ax
0FC5  EB 03           jmp 0xfca
loc_0FC7:
0FC7  FF 4E FE        dec word ptr [bp - 2]
loc_0FCA:
0FCA  83 7E FE 00     cmp word ptr [bp - 2], 0
0FCE  7E 16           jle 0xfe6
0FD0  FF 76 FE        push word ptr [bp - 2]
0FD3  A1 80 03        mov ax, word ptr [0x380]
0FD6  2B 46 FE        sub ax, word ptr [bp - 2]
0FD9  8B D0           mov dx, ax
0FDB  B8 04 00        mov ax, 4
0FDE  2B C2           sub ax, dx
0FE0  50              push ax
0FE1  6A 2A           push 0x2a
0FE3  E8 D7 F9        call 0x9bd
loc_0FE6:
0FE6  8B 46 FE        mov ax, word ptr [bp - 2]
0FE9  3B 46 FC        cmp ax, word ptr [bp - 4]
0FEC  75 D9           jne 0xfc7
loc_0FEE:
0FEE  A1 8A D0        mov ax, word ptr [0xd08a]
0FF1  8B 16 8C D0     mov dx, word ptr [0xd08c]
0FF5  A3 9A D0        mov word ptr [0xd09a], ax
0FF8  89 16 9C D0     mov word ptr [0xd09c], dx
loc_0FFC:
0FFC  C9              leave
0FFD  C2 08 00        ret 8

; ---- routine 0AB5:1000  (found by: call)
sub_1000:
1000  C8 06 01 00     enter 0x106, 0
1004  C7 46 FC 01 00  mov word ptr [bp - 4], 1
1009  EB 03           jmp 0x100e
loc_100B:
100B  FF 46 FC        inc word ptr [bp - 4]
loc_100E:
100E  C7 46 FE 0B 00  mov word ptr [bp - 2], 0xb
1013  EB 03           jmp 0x1018
loc_1015:
1015  FF 4E FE        dec word ptr [bp - 2]
loc_1018:
1018  8B 46 FE        mov ax, word ptr [bp - 2]
101B  8B 7E 04        mov di, word ptr [bp + 4]
101E  03 F8           add di, ax
1020  36 8A 45 E3     mov al, byte ptr ss:[di - 0x1d]
1024  30 E4           xor ah, ah
1026  3B 46 08        cmp ax, word ptr [bp + 8]
1029  72 78           jb 0x10a3
102B  8B 46 FE        mov ax, word ptr [bp - 2]
102E  8B 7E 04        mov di, word ptr [bp + 4]
1031  03 F8           add di, ax
1033  36 8A 45 E3     mov al, byte ptr ss:[di - 0x1d]
1037  30 E4           xor ah, ah
1039  3B 46 06        cmp ax, word ptr [bp + 6]
103C  77 65           ja 0x10a3
103E  8D BE FA FE     lea di, [bp - 0x106]
1042  16              push ss
1043  57              push di
1044  8B 46 FE        mov ax, word ptr [bp - 2]
1047  8B 7E 04        mov di, word ptr [bp + 4]
104A  03 F8           add di, ax
104C  36 8A 45 E3     mov al, byte ptr ss:[di - 0x1d]
1050  30 E4           xor ah, ah
1052  6B 7E FC 0E     imul di, word ptr [bp - 4], 0xe
1056  03 F8           add di, ax
1058  8A 85 B0 09     mov al, byte ptr [di + 0x9b0]
105C  50              push ax
105D  9A 6F 0C B9 26  call far 26B9:0C6F
1062  8B 7E 04        mov di, word ptr [bp + 4]
1065  81 C7 F0 FF     add di, 0xfff0
1069  16              push ss
106A  57              push di
106B  9A FE 0B B9 26  call far 26B9:0BFE
1070  40              inc ax
1071  89 46 FA        mov word ptr [bp - 6], ax
1074  83 7E FA 01     cmp word ptr [bp - 6], 1
1078  76 29           jbe 0x10a3
107A  8B 46 FA        mov ax, word ptr [bp - 6]
107D  8B 7E 04        mov di, word ptr [bp + 4]
1080  03 F8           add di, ax
1082  36 C6 45 EF 00  mov byte ptr ss:[di - 0x11], 0
1087  8B 46 FE        mov ax, word ptr [bp - 2]
108A  8B 7E 04        mov di, word ptr [bp + 4]
108D  03 F8           add di, ax
108F  36 C6 45 E3 00  mov byte ptr ss:[di - 0x1d], 0
1094  8A 56 FE        mov dl, byte ptr [bp - 2]
1097  8B 46 FA        mov ax, word ptr [bp - 6]
109A  8B 7E 04        mov di, word ptr [bp + 4]
109D  03 F8           add di, ax
109F  36 88 55 D7     mov byte ptr ss:[di - 0x29], dl
loc_10A3:
10A3  83 7E FE 02     cmp word ptr [bp - 2], 2
10A7  74 03           je 0x10ac
10A9  E9 69 FF        jmp 0x1015
loc_10AC:
10AC  83 7E FC 04     cmp word ptr [bp - 4], 4
10B0  74 03           je 0x10b5
10B2  E9 56 FF        jmp 0x100b
loc_10B5:
10B5  C9              leave
10B6  C2 06 00        ret 6

; ---- routine 0AB5:10B9  (found by: call)
sub_10B9:
10B9  C8 30 00 00     enter 0x30, 0
10BD  C6 46 FB 00     mov byte ptr [bp - 5], 0
10C1  EB 03           jmp 0x10c6
loc_10C3:
10C3  FE 46 FB        inc byte ptr [bp - 5]
loc_10C6:
10C6  8A 46 FB        mov al, byte ptr [bp - 5]
10C9  98              cwde
10CA  8B F8           mov di, ax
10CC  8A 85 56 0D     mov al, byte ptr [di + 0xd56]
10D0  30 E4           xor ah, ah
10D2  40              inc ax
10D3  6B F8 19        imul di, ax, 0x19
10D6  31 C0           xor ax, ax
10D8  89 85 03 CD     mov word ptr [di - 0x32fd], ax
10DC  8A 46 FB        mov al, byte ptr [bp - 5]
10DF  98              cwde
10E0  8B F8           mov di, ax
10E2  8A 85 56 0D     mov al, byte ptr [di + 0xd56]
10E6  30 E4           xor ah, ah
10E8  40              inc ax
10E9  40              inc ax
10EA  6B F8 19        imul di, ax, 0x19
10ED  8B 85 FD CC     mov ax, word ptr [di - 0x3303]
10F1  C1 E0 03        shl ax, 3
10F4  C4 3E BA D7     les di, ptr [0xd7ba]
10F8  03 F8           add di, ax
10FA  26 80 7D 06 01  cmp byte ptr es:[di + 6], 1
10FF  75 17           jne 0x1118
1101  8A 46 FB        mov al, byte ptr [bp - 5]
1104  98              cwde
1105  8B F8           mov di, ax
1107  8A 85 56 0D     mov al, byte ptr [di + 0xd56]
110B  30 E4           xor ah, ah
110D  40              inc ax
110E  40              inc ax
110F  6B F8 19        imul di, ax, 0x19
1112  31 C0           xor ax, ax
1114  89 85 03 CD     mov word ptr [di - 0x32fd], ax
loc_1118:
1118  C6 46 F0 0A     mov byte ptr [bp - 0x10], 0xa
111C  C6 46 E4 0A     mov byte ptr [bp - 0x1c], 0xa
1120  C7 46 FE 02 00  mov word ptr [bp - 2], 2
1125  EB 03           jmp 0x112a
loc_1127:
1127  FF 46 FE        inc word ptr [bp - 2]
loc_112A:
112A  8A 46 FB        mov al, byte ptr [bp - 5]
112D  98              cwde
112E  8B F8           mov di, ax
1130  8A 85 56 0D     mov al, byte ptr [di + 0xd56]
1134  30 E4           xor ah, ah
1136  03 46 FE        add ax, word ptr [bp - 2]
1139  6B F8 19        imul di, ax, 0x19
113C  81 C7 EF CC     add di, 0xccef
1140  1E              push ds
1141  07              pop es
1142  89 7E D4        mov word ptr [bp - 0x2c], di
1145  8C 46 D6        mov word ptr [bp - 0x2a], es
1148  26 8B 45 0E     mov ax, word ptr es:[di + 0xe]
114C  C1 E0 03        shl ax, 3
114F  C4 3E BA D7     les di, ptr [0xd7ba]
1153  03 F8           add di, ax
1155  26 80 7D 06 01  cmp byte ptr es:[di + 6], 1
115A  74 2D           je 0x1189
115C  6A 07           push 7
115E  C4 7E D4        les di, ptr [bp - 0x2c]
1161  26 6B 45 0E 0F  imul ax, word ptr es:[di + 0xe], 0xf
1166  C4 3E BE D7     les di, ptr [0xd7be]
116A  03 F8           add di, ax
116C  26 8A 45 0B     mov al, byte ptr es:[di + 0xb]
1170  30 E4           xor ah, ah
1172  50              push ax
1173  9A 59 02 AC 24  call far 24AC:0259
1178  08 C0           or al, al
117A  75 0D           jne 0x1189
117C  C4 7E D4        les di, ptr [bp - 0x2c]
117F  06              push es
1180  57              push di
1181  0E              push cs
1182  E8 1C 0B        call 0x1ca1
1185  08 C0           or al, al
1187  74 09           je 0x1192
loc_1189:
1189  8B 7E FE        mov di, word ptr [bp - 2]
118C  C6 43 EF 00     mov byte ptr [bp + di - 0x11], 0
1190  EB 1A           jmp 0x11ac
loc_1192:
1192  C4 7E D4        les di, ptr [bp - 0x2c]
1195  26 8B 45 0E     mov ax, word ptr es:[di + 0xe]
1199  C1 E0 03        shl ax, 3
119C  C4 3E BA D7     les di, ptr [0xd7ba]
11A0  03 F8           add di, ax
11A2  26 8A 45 06     mov al, byte ptr es:[di + 6]
11A6  8B 7E FE        mov di, word ptr [bp - 2]
11A9  88 43 EF        mov byte ptr [bp + di - 0x11], al
loc_11AC:
11AC  80 7E FB 00     cmp byte ptr [bp - 5], 0
11B0  B0 00           mov al, 0
11B2  75 01           jne 0x11b5
11B4  40              inc ax
loc_11B5:
11B5  98              cwde
11B6  8B F8           mov di, ax
11B8  8A 85 56 0D     mov al, byte ptr [di + 0xd56]
11BC  30 E4           xor ah, ah
11BE  03 46 FE        add ax, word ptr [bp - 2]
11C1  6B F8 19        imul di, ax, 0x19
11C4  81 C7 EF CC     add di, 0xccef
11C8  1E              push ds
11C9  07              pop es
11CA  89 7E D4        mov word ptr [bp - 0x2c], di
11CD  8C 46 D6        mov word ptr [bp - 0x2a], es
11D0  06              push es
11D1  57              push di
11D2  0E              push cs
11D3  E8 CB 0A        call 0x1ca1
11D6  08 C0           or al, al
11D8  74 09           je 0x11e3
11DA  8B 7E FE        mov di, word ptr [bp - 2]
11DD  C6 43 E3 00     mov byte ptr [bp + di - 0x1d], 0
11E1  EB 1A           jmp 0x11fd
loc_11E3:
11E3  C4 7E D4        les di, ptr [bp - 0x2c]
11E6  26 8B 45 0E     mov ax, word ptr es:[di + 0xe]
11EA  C1 E0 03        shl ax, 3
11ED  C4 3E BA D7     les di, ptr [0xd7ba]
11F1  03 F8           add di, ax
11F3  26 8A 45 06     mov al, byte ptr es:[di + 6]
11F7  8B 7E FE        mov di, word ptr [bp - 2]
11FA  88 43 E3        mov byte ptr [bp + di - 0x1d], al
loc_11FD:
11FD  83 7E FE 0B     cmp word ptr [bp - 2], 0xb
1201  74 03           je 0x1206
1203  E9 21 FF        jmp 0x1127
loc_1206:
1206  C7 46 FE 02 00  mov word ptr [bp - 2], 2
120B  EB 03           jmp 0x1210
loc_120D:
120D  FF 46 FE        inc word ptr [bp - 2]
loc_1210:
1210  8A 46 FB        mov al, byte ptr [bp - 5]
1213  98              cwde
1214  8B F8           mov di, ax
1216  8A 85 56 0D     mov al, byte ptr [di + 0xd56]
121A  30 E4           xor ah, ah
121C  03 46 FE        add ax, word ptr [bp - 2]
121F  6B F8 19        imul di, ax, 0x19
1222  81 C7 EF CC     add di, 0xccef
1226  1E              push ds
1227  07              pop es
1228  89 7E D4        mov word ptr [bp - 0x2c], di
122B  8C 46 D6        mov word ptr [bp - 0x2a], es
122E  26 6B 45 0E 0F  imul ax, word ptr es:[di + 0xe], 0xf
1233  C4 3E BE D7     les di, ptr [0xd7be]
1237  03 F8           add di, ax
1239  6A 07           push 7
123B  26 8A 45 0B     mov al, byte ptr es:[di + 0xb]
123F  30 E4           xor ah, ah
1241  50              push ax
1242  9A 59 02 AC 24  call far 24AC:0259
1247  08 C0           or al, al
1249  74 46           je 0x1291
124B  C7 46 FC 02 00  mov word ptr [bp - 4], 2
1250  EB 03           jmp 0x1255
loc_1252:
1252  FF 46 FC        inc word ptr [bp - 4]
loc_1255:
1255  8B 46 FC        mov ax, word ptr [bp - 4]
1258  D1 E0           shl ax, 1
125A  8B D0           mov dx, ax
125C  80 7E FB 00     cmp byte ptr [bp - 5], 0
1260  B0 00           mov al, 0
1262  75 01           jne 0x1265
1264  40              inc ax
loc_1265:
1265  98              cwde
1266  8B F8           mov di, ax
1268  D1 E7           shl di, 1
126A  6B 85 E4 D6 3E  imul ax, word ptr [di - 0x291c], 0x3e
126F  C4 3E C2 D7     les di, ptr [0xd7c2]
1273  03 F8           add di, ax
1275  03 FA           add di, dx
1277  26 8B 45 C0     mov ax, word ptr es:[di - 0x40]
127B  C4 7E D4        les di, ptr [bp - 0x2c]
127E  26 3B 45 14     cmp ax, word ptr es:[di + 0x14]
1282  75 07           jne 0x128b
1284  8B 7E FC        mov di, word ptr [bp - 4]
1287  C6 43 E3 00     mov byte ptr [bp + di - 0x1d], 0
loc_128B:
128B  83 7E FC 0B     cmp word ptr [bp - 4], 0xb
128F  75 C1           jne 0x1252
loc_1291:
1291  83 7E FE 0B     cmp word ptr [bp - 2], 0xb
1295  74 03           je 0x129a
1297  E9 73 FF        jmp 0x120d
loc_129A:
129A  8D 7E D8        lea di, [bp - 0x28]
129D  16              push ss
129E  57              push di
129F  6A 0B           push 0xb
12A1  6A 00           push 0
12A3  9A 22 02 AC 24  call far 24AC:0222
12A8  6A 0C           push 0xc
12AA  6A 0D           push 0xd
12AC  55              push bp
12AD  E8 50 FD        call 0x1000
12B0  6A 09           push 9
12B2  6A 0B           push 0xb
12B4  55              push bp
12B5  E8 48 FD        call 0x1000
12B8  6A 05           push 5
12BA  6A 08           push 8
12BC  55              push bp
12BD  E8 40 FD        call 0x1000
12C0  6A 01           push 1
12C2  6A 01           push 1
12C4  55              push bp
12C5  E8 38 FD        call 0x1000
12C8  6A 02           push 2
12CA  6A 04           push 4
12CC  55              push bp
12CD  E8 30 FD        call 0x1000
12D0  C7 46 FE 02 00  mov word ptr [bp - 2], 2
12D5  EB 03           jmp 0x12da
loc_12D7:
12D7  FF 46 FE        inc word ptr [bp - 2]
loc_12DA:
12DA  8A 46 FB        mov al, byte ptr [bp - 5]
12DD  98              cwde
12DE  8B F8           mov di, ax
12E0  8A 85 56 0D     mov al, byte ptr [di + 0xd56]
12E4  30 E4           xor ah, ah
12E6  03 46 FE        add ax, word ptr [bp - 2]
12E9  6B F8 19        imul di, ax, 0x19
12EC  81 C7 EF CC     add di, 0xccef
12F0  1E              push ds
12F1  07              pop es
12F2  89 7E D4        mov word ptr [bp - 0x2c], di
12F5  8C 46 D6        mov word ptr [bp - 0x2a], es
12F8  26 6B 45 0E 0F  imul ax, word ptr es:[di + 0xe], 0xf
12FD  C4 3E BE D7     les di, ptr [0xd7be]
1301  03 F8           add di, ax
1303  89 7E D0        mov word ptr [bp - 0x30], di
1306  8C 46 D2        mov word ptr [bp - 0x2e], es
1309  6A 07           push 7
130B  26 8A 45 0B     mov al, byte ptr es:[di + 0xb]
130F  30 E4           xor ah, ah
1311  50              push ax
1312  9A 59 02 AC 24  call far 24AC:0259
1317  08 C0           or al, al
1319  75 09           jne 0x1324
131B  C4 7E D4        les di, ptr [bp - 0x2c]
131E  31 C0           xor ax, ax
1320  26 89 45 14     mov word ptr es:[di + 0x14], ax
loc_1324:
1324  6A 07           push 7
1326  C4 7E D0        les di, ptr [bp - 0x30]
1329  26 8A 45 0B     mov al, byte ptr es:[di + 0xb]
132D  30 E4           xor ah, ah
132F  50              push ax
1330  9A 59 02 AC 24  call far 24AC:0259
1335  08 C0           or al, al
1337  75 6B           jne 0x13a4
1339  6A 08           push 8
133B  8A 46 FB        mov al, byte ptr [bp - 5]
133E  98              cwde
133F  8B F8           mov di, ax
1341  D1 E7           shl di, 1
1343  6B 85 E4 D6 3E  imul ax, word ptr [di - 0x291c], 0x3e
1348  C4 3E C2 D7     les di, ptr [0xd7c2]
134C  03 F8           add di, ax
134E  26 8A 45 FB     mov al, byte ptr es:[di - 5]
1352  30 E4           xor ah, ah
1354  50              push ax
1355  9A 59 02 AC 24  call far 24AC:0259
135A  08 C0           or al, al
135C  74 46           je 0x13a4
135E  8B 7E FE        mov di, word ptr [bp - 2]
1361  80 7B D7 00     cmp byte ptr [bp + di - 0x29], 0
1365  76 34           jbe 0x139b
1367  8B 7E FE        mov di, word ptr [bp - 2]
136A  8A 43 D7        mov al, byte ptr [bp + di - 0x29]
136D  30 E4           xor ah, ah
136F  D1 E0           shl ax, 1
1371  8B D0           mov dx, ax
1373  80 7E FB 00     cmp byte ptr [bp - 5], 0
1377  B0 00           mov al, 0
1379  75 01           jne 0x137c
137B  40              inc ax
loc_137C:
137C  98              cwde
137D  8B F8           mov di, ax
137F  D1 E7           shl di, 1
1381  6B 85 E4 D6 3E  imul ax, word ptr [di - 0x291c], 0x3e
1386  C4 3E C2 D7     les di, ptr [0xd7c2]
138A  03 F8           add di, ax
138C  03 FA           add di, dx
138E  26 8B 45 C0     mov ax, word ptr es:[di - 0x40]
1392  C4 7E D4        les di, ptr [bp - 0x2c]
1395  26 89 45 14     mov word ptr es:[di + 0x14], ax
1399  EB 09           jmp 0x13a4
loc_139B:
139B  C4 7E D4        les di, ptr [bp - 0x2c]
139E  31 C0           xor ax, ax
13A0  26 89 45 14     mov word ptr es:[di + 0x14], ax
loc_13A4:
13A4  83 7E FE 0B     cmp word ptr [bp - 2], 0xb
13A8  74 03           je 0x13ad
13AA  E9 2A FF        jmp 0x12d7
loc_13AD:
13AD  80 7E FB 01     cmp byte ptr [bp - 5], 1
13B1  74 03           je 0x13b6
13B3  E9 0D FD        jmp 0x10c3
loc_13B6:
13B6  C9              leave
13B7  C3              ret

; ---- routine 0AB5:13B8  (found by: call)
sub_13B8:
13B8  C8 0C 00 00     enter 0xc, 0
13BC  8A 46 04        mov al, byte ptr [bp + 4]
13BF  98              cwde
13C0  8B F8           mov di, ax
13C2  D1 E7           shl di, 1
13C4  6B 85 E4 D6 3E  imul ax, word ptr [di - 0x291c], 0x3e
13C9  C4 3E C2 D7     les di, ptr [0xd7c2]
13CD  03 F8           add di, ax
13CF  81 C7 C2 FF     add di, 0xffc2
13D3  89 7E F4        mov word ptr [bp - 0xc], di
13D6  8C 46 F6        mov word ptr [bp - 0xa], es
13D9  C7 46 F8 FF FF  mov word ptr [bp - 8], 0xffff
13DE  C7 46 FC 01 00  mov word ptr [bp - 4], 1
13E3  EB 03           jmp 0x13e8
loc_13E5:
13E5  FF 46 FC        inc word ptr [bp - 4]
loc_13E8:
13E8  8B 46 FC        mov ax, word ptr [bp - 4]
13EB  D1 E0           shl ax, 1
13ED  C4 7E F4        les di, ptr [bp - 0xc]
13F0  03 F8           add di, ax
13F2  26 FF 75 FE     push word ptr es:[di - 2]
13F6  9A E9 4E 51 1B  call far 1B51:4EE9
13FB  08 C0           or al, al
13FD  75 43           jne 0x1442
13FF  8B 46 FC        mov ax, word ptr [bp - 4]
1402  D1 E0           shl ax, 1
1404  C4 7E F4        les di, ptr [bp - 0xc]
1407  03 F8           add di, ax
1409  26 FF 75 FE     push word ptr es:[di - 2]
140D  9A 1F 4E 51 1B  call far 1B51:4E1F
1412  31 D2           xor dx, dx
1414  8B C8           mov cx, ax
1416  8B DA           mov bx, dx
1418  8B 46 F8        mov ax, word ptr [bp - 8]
141B  99              cdq
141C  3B D3           cmp dx, bx
141E  7C 06           jl 0x1426
1420  7F 20           jg 0x1442
1422  3B C1           cmp ax, cx
1424  73 1C           jae 0x1442
loc_1426:
1426  8B 46 FC        mov ax, word ptr [bp - 4]
1429  D1 E0           shl ax, 1
142B  C4 7E F4        les di, ptr [bp - 0xc]
142E  03 F8           add di, ax
1430  26 8B 45 FE     mov ax, word ptr es:[di - 2]
1434  89 46 FA        mov word ptr [bp - 6], ax
1437  FF 76 FA        push word ptr [bp - 6]
143A  9A 1F 4E 51 1B  call far 1B51:4E1F
143F  89 46 F8        mov word ptr [bp - 8], ax
loc_1442:
1442  83 7E FC 0B     cmp word ptr [bp - 4], 0xb
1446  75 9D           jne 0x13e5
1448  8B 46 FA        mov ax, word ptr [bp - 6]
144B  89 46 FE        mov word ptr [bp - 2], ax
144E  8B 46 FE        mov ax, word ptr [bp - 2]
1451  C9              leave
1452  C2 02 00        ret 2

; ---- routine 0AB5:1455  (found by: call)
sub_1455:
1455  C8 08 00 00     enter 8, 0
1459  8B 46 04        mov ax, word ptr [bp + 4]
145C  D1 E0           shl ax, 1
145E  8B D0           mov dx, ax
1460  8A 46 08        mov al, byte ptr [bp + 8]
1463  98              cwde
1464  6B F8 0A        imul di, ax, 0xa
1467  03 FA           add di, dx
1469  31 C0           xor ax, ax
146B  89 85 5C CF     mov word ptr [di - 0x30a4], ax
146F  83 7E 04 05     cmp word ptr [bp + 4], 5
1473  B0 00           mov al, 0
1475  75 01           jne 0x1478
1477  40              inc ax
loc_1478:
1478  98              cwde
1479  8B F8           mov di, ax
147B  8A 85 F6 09     mov al, byte ptr [di + 0x9f6]
147F  30 E4           xor ah, ah
1481  40              inc ax
1482  3D 0B 00        cmp ax, 0xb
1485  76 03           jbe 0x148a
1487  E9 AB 00        jmp 0x1535
loc_148A:
148A  89 46 FE        mov word ptr [bp - 2], ax
148D  EB 03           jmp 0x1492
loc_148F:
148F  FF 46 FE        inc word ptr [bp - 2]
loc_1492:
1492  8A 46 08        mov al, byte ptr [bp + 8]
1495  98              cwde
1496  8B F8           mov di, ax
1498  8A 85 56 0D     mov al, byte ptr [di + 0xd56]
149C  30 E4           xor ah, ah
149E  03 46 FE        add ax, word ptr [bp - 2]
14A1  89 46 FC        mov word ptr [bp - 4], ax
14A4  6B 7E FC 19     imul di, word ptr [bp - 4], 0x19
14A8  81 C7 EF CC     add di, 0xccef
14AC  1E              push ds
14AD  07              pop es
14AE  89 7E F8        mov word ptr [bp - 8], di
14B1  8C 46 FA        mov word ptr [bp - 6], es
14B4  26 FF 75 0E     push word ptr es:[di + 0xe]
14B8  9A E9 4E 51 1B  call far 1B51:4EE9
14BD  08 C0           or al, al
14BF  75 6B           jne 0x152c
14C1  8B 46 04        mov ax, word ptr [bp + 4]
14C4  D1 E0           shl ax, 1
14C6  8B D0           mov dx, ax
14C8  8A 46 08        mov al, byte ptr [bp + 8]
14CB  98              cwde
14CC  6B F8 0A        imul di, ax, 0xa
14CF  03 FA           add di, dx
14D1  83 BD 5C CF 00  cmp word ptr [di - 0x30a4], 0
14D6  74 39           je 0x1511
14D8  FF 76 06        push word ptr [bp + 6]
14DB  8B 46 04        mov ax, word ptr [bp + 4]
14DE  D1 E0           shl ax, 1
14E0  8B D0           mov dx, ax
14E2  8A 46 08        mov al, byte ptr [bp + 8]
14E5  98              cwde
14E6  6B F8 0A        imul di, ax, 0xa
14E9  03 FA           add di, dx
14EB  FF B5 5C CF     push word ptr [di - 0x30a4]
14EF  E8 81 74        call 0x8973
14F2  6B F8 19        imul di, ax, 0x19
14F5  81 C7 EF CC     add di, 0xccef
14F9  1E              push ds
14FA  57              push di
14FB  0E              push cs
14FC  E8 E3 05        call 0x1ae2
14FF  50              push ax
1500  FF 76 06        push word ptr [bp + 6]
1503  C4 7E F8        les di, ptr [bp - 8]
1506  06              push es
1507  57              push di
1508  0E              push cs
1509  E8 D6 05        call 0x1ae2
150C  5A              pop dx
150D  3B C2           cmp ax, dx
150F  76 1B           jbe 0x152c
loc_1511:
1511  C4 7E F8        les di, ptr [bp - 8]
1514  26 8B 4D 0E     mov cx, word ptr es:[di + 0xe]
1518  8B 46 04        mov ax, word ptr [bp + 4]
151B  D1 E0           shl ax, 1
151D  8B D0           mov dx, ax
151F  8A 46 08        mov al, byte ptr [bp + 8]
1522  98              cwde
1523  6B F8 0A        imul di, ax, 0xa
1526  03 FA           add di, dx
1528  89 8D 5C CF     mov word ptr [di - 0x30a4], cx
loc_152C:
152C  83 7E FE 0B     cmp word ptr [bp - 2], 0xb
1530  74 03           je 0x1535
1532  E9 5A FF        jmp 0x148f
loc_1535:
1535  C9              leave
1536  C2 06 00        ret 6

; ---- routine 0AB5:1539  (found by: call)
sub_1539:
1539  C8 0C 00 00     enter 0xc, 0
153D  C6 46 FF 00     mov byte ptr [bp - 1], 0
1541  EB 03           jmp 0x1546
loc_1543:
1543  FE 46 FF        inc byte ptr [bp - 1]
loc_1546:
1546  8A 46 FF        mov al, byte ptr [bp - 1]
1549  98              cwde
154A  8B F8           mov di, ax
154C  D1 E7           shl di, 1
154E  6B 85 E4 D6 3E  imul ax, word ptr [di - 0x291c], 0x3e
1553  C4 3E C2 D7     les di, ptr [0xd7c2]
1557  03 F8           add di, ax
1559  81 C7 C2 FF     add di, 0xffc2
155D  8A 46 FF        mov al, byte ptr [bp - 1]
1560  98              cwde
1561  8B F8           mov di, ax
1563  D1 E7           shl di, 1
1565  FF B5 E4 D6     push word ptr [di - 0x291c]
1569  9A DA 0D 51 1B  call far 1B51:0DDA
156E  88 46 FE        mov byte ptr [bp - 2], al
1571  80 7E FE 00     cmp byte ptr [bp - 2], 0
1575  74 07           je 0x157e
1577  80 3E 18 0D 00  cmp byte ptr [0xd18], 0
157C  75 40           jne 0x15be
loc_157E:
157E  80 7E FE 00     cmp byte ptr [bp - 2], 0
1582  75 14           jne 0x1598
1584  8A 46 FF        mov al, byte ptr [bp - 1]
1587  50              push ax
1588  E8 2D FE        call 0x13b8
158B  8B D0           mov dx, ax
158D  8A 46 FF        mov al, byte ptr [bp - 1]
1590  98              cwde
1591  6B F8 0A        imul di, ax, 0xa
1594  89 95 5E CF     mov word ptr [di - 0x30a2], dx
loc_1598:
1598  C7 46 FC 02 00  mov word ptr [bp - 4], 2
159D  EB 03           jmp 0x15a2
loc_159F:
159F  FF 46 FC        inc word ptr [bp - 4]
loc_15A2:
15A2  8A 46 FF        mov al, byte ptr [bp - 1]
15A5  50              push ax
15A6  8B 7E FC        mov di, word ptr [bp - 4]
15A9  8A 85 F6 09     mov al, byte ptr [di + 0x9f6]
15AD  30 E4           xor ah, ah
15AF  50              push ax
15B0  FF 76 FC        push word ptr [bp - 4]
15B3  E8 9F FE        call 0x1455
15B6  83 7E FC 05     cmp word ptr [bp - 4], 5
15BA  75 E3           jne 0x159f
15BC  EB 3F           jmp 0x15fd
loc_15BE:
15BE  80 3E 18 0D 00  cmp byte ptr [0xd18], 0
15C3  74 38           je 0x15fd
15C5  8A 46 FF        mov al, byte ptr [bp - 1]
15C8  98              cwde
15C9  6B F8 0A        imul di, ax, 0xa
15CC  FF B5 5E CF     push word ptr [di - 0x30a2]
15D0  9A E9 4E 51 1B  call far 1B51:4EE9
15D5  08 C0           or al, al
15D7  75 0E           jne 0x15e7
15D9  8A 46 FF        mov al, byte ptr [bp - 1]
15DC  50              push ax
15DD  6A 01           push 1
15DF  E8 9D 41        call 0x577f
15E2  3D 0B 00        cmp ax, 0xb
15E5  76 16           jbe 0x15fd
loc_15E7:
15E7  8A 46 FF        mov al, byte ptr [bp - 1]
15EA  50              push ax
15EB  6A 01           push 1
15ED  E8 CD A0        call 0xffffb6bd
15F0  8B D0           mov dx, ax
15F2  8A 46 FF        mov al, byte ptr [bp - 1]
15F5  98              cwde
15F6  6B F8 0A        imul di, ax, 0xa
15F9  89 95 5E CF     mov word ptr [di - 0x30a2], dx
loc_15FD:
15FD  C7 46 FC 01 00  mov word ptr [bp - 4], 1
1602  EB 03           jmp 0x1607
loc_1604:
1604  FF 46 FC        inc word ptr [bp - 4]
loc_1607:
1607  8A 46 FF        mov al, byte ptr [bp - 1]
160A  98              cwde
160B  8B F8           mov di, ax
160D  8A 85 56 0D     mov al, byte ptr [di + 0xd56]
1611  30 E4           xor ah, ah
1613  03 46 FC        add ax, word ptr [bp - 4]
1616  6B F8 19        imul di, ax, 0x19
1619  81 C7 EF CC     add di, 0xccef
161D  1E              push ds
161E  07              pop es
161F  89 7E F4        mov word ptr [bp - 0xc], di
1622  8C 46 F6        mov word ptr [bp - 0xa], es
1625  8A 46 FF        mov al, byte ptr [bp - 1]
1628  98              cwde
1629  6B F8 0A        imul di, ax, 0xa
162C  FF B5 5E CF     push word ptr [di - 0x30a2]
1630  9A 1F 4E 51 1B  call far 1B51:4E1F
1635  D1 E0           shl ax, 1
1637  C4 7E F4        les di, ptr [bp - 0xc]
163A  26 00 45 12     add byte ptr es:[di + 0x12], al
163E  83 7E FC 0B     cmp word ptr [bp - 4], 0xb
1642  75 C0           jne 0x1604
1644  80 7E FF 01     cmp byte ptr [bp - 1], 1
1648  74 03           je 0x164d
164A  E9 F6 FE        jmp 0x1543
loc_164D:
164D  C9              leave
164E  C3              ret

