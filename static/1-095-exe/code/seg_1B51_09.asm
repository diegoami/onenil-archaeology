; 1-095.EXE (One-Nil 95), code segment 1B51 (image offsets 1B510..2305F), part 9 of 12
; packed 1-095.EXE sha256 f659fb2d334500d6901fc8d6a0f06c85c0ccda2eb4a3035ae3bb0a0004d79192 (LZEXE 0.91)
; unpacked (tools/static/unlzexe.py) sha256 8df646e017e0965a5d90a58181ca764219ad847833aad0b6cb58fc53372bfb2c
; tool: capstone 5.0.9 (pip package; core library 5.0.1280) (CS_ARCH_X86, CS_MODE_16), recursive descent from the entry point, far calls and near calls/jumps, then routine prologues (55 89 E5 / 55 8B EC / C8 iw 00) in what remains; tools/static/listing.py
; addresses are SEGMENT:OFFSET with SEGMENT the image paragraph before relocation; image offset = SEGMENT*16+OFFSET
; ---- routine 1B51:5A7D  (found by: call)
sub_5A7D:
5A7D  C8 04 00 00     enter 4, 0
5A81  68 90 01        push 0x190
5A84  9A 6D 07 1A 23  call far 231A:076D
5A89  89 46 FC        mov word ptr [bp - 4], ax
5A8C  81 46 FC C0 0D  add word ptr [bp - 4], 0xdc0
loc_5A91:
5A91  8B 46 FC        mov ax, word ptr [bp - 4]
5A94  C1 E0 03        shl ax, 3
5A97  C4 3E BA D7     les di, ptr [0xd7ba]
5A9B  03 F8           add di, ax
5A9D  26 80 3D 00     cmp byte ptr es:[di], 0
5AA1  74 11           je 0x5ab4
5AA3  FF 46 FC        inc word ptr [bp - 4]
5AA6  81 7E FC 50 0F  cmp word ptr [bp - 4], 0xf50
5AAB  76 05           jbe 0x5ab2
5AAD  C7 46 FC C1 0D  mov word ptr [bp - 4], 0xdc1
loc_5AB2:
5AB2  EB DD           jmp 0x5a91
loc_5AB4:
5AB4  8B 46 FC        mov ax, word ptr [bp - 4]
5AB7  89 46 FE        mov word ptr [bp - 2], ax
5ABA  8B 46 FE        mov ax, word ptr [bp - 2]
5ABD  C9              leave
5ABE  C3              ret

; ---- routine 1B51:5ABF  (found by: call)
sub_5ABF:
5ABF  C8 0C 00 00     enter 0xc, 0
5AC3  6B 46 04 3E     imul ax, word ptr [bp + 4], 0x3e
5AC7  C4 3E C2 D7     les di, ptr [0xd7c2]
5ACB  03 F8           add di, ax
5ACD  81 C7 C2 FF     add di, 0xffc2
5AD1  89 7E F4        mov word ptr [bp - 0xc], di
5AD4  8C 46 F6        mov word ptr [bp - 0xa], es
5AD7  C7 46 FA 01 00  mov word ptr [bp - 6], 1
5ADC  EB 03           jmp 0x5ae1
loc_5ADE:
5ADE  FF 46 FA        inc word ptr [bp - 6]
loc_5AE1:
5AE1  31 C0           xor ax, ax
5AE3  89 46 F8        mov word ptr [bp - 8], ax
5AE6  8B 46 FA        mov ax, word ptr [bp - 6]
5AE9  C4 7E F4        les di, ptr [bp - 0xc]
5AEC  03 F8           add di, ax
5AEE  26 8A 45 3A     mov al, byte ptr es:[di + 0x3a]
5AF2  30 E4           xor ah, ah
5AF4  48              dec ax
5AF5  6B C0 14        imul ax, ax, 0x14
5AF8  03 46 F8        add ax, word ptr [bp - 8]
5AFB  89 46 F8        mov word ptr [bp - 8], ax
5AFE  C7 46 FC 01 00  mov word ptr [bp - 4], 1
5B03  EB 03           jmp 0x5b08
loc_5B05:
5B05  FF 46 FC        inc word ptr [bp - 4]
loc_5B08:
5B08  8B 46 FC        mov ax, word ptr [bp - 4]
5B0B  03 46 F8        add ax, word ptr [bp - 8]
5B0E  C1 E0 03        shl ax, 3
5B11  C4 3E BA D7     les di, ptr [0xd7ba]
5B15  03 F8           add di, ax
5B17  26 80 3D 00     cmp byte ptr es:[di], 0
5B1B  75 0B           jne 0x5b28
5B1D  8B 46 FC        mov ax, word ptr [bp - 4]
5B20  03 46 F8        add ax, word ptr [bp - 8]
5B23  89 46 FE        mov word ptr [bp - 2], ax
5B26  EB 41           jmp 0x5b69
loc_5B28:
5B28  83 7E FC 14     cmp word ptr [bp - 4], 0x14
5B2C  75 D7           jne 0x5b05
5B2E  83 7E FA 03     cmp word ptr [bp - 6], 3
5B32  75 AA           jne 0x5ade
5B34  68 C0 0D        push 0xdc0
5B37  9A 6D 07 1A 23  call far 231A:076D
5B3C  48              dec ax
5B3D  89 46 FA        mov word ptr [bp - 6], ax
loc_5B40:
5B40  8B 46 FA        mov ax, word ptr [bp - 6]
5B43  C1 E0 03        shl ax, 3
5B46  C4 3E BA D7     les di, ptr [0xd7ba]
5B4A  03 F8           add di, ax
5B4C  26 80 3D 00     cmp byte ptr es:[di], 0
5B50  74 11           je 0x5b63
5B52  FF 46 FA        inc word ptr [bp - 6]
5B55  81 7E FA C0 0D  cmp word ptr [bp - 6], 0xdc0
5B5A  76 05           jbe 0x5b61
5B5C  C7 46 FA 01 00  mov word ptr [bp - 6], 1
loc_5B61:
5B61  EB DD           jmp 0x5b40
loc_5B63:
5B63  8B 46 FA        mov ax, word ptr [bp - 6]
5B66  89 46 FE        mov word ptr [bp - 2], ax
loc_5B69:
5B69  8B 46 FE        mov ax, word ptr [bp - 2]
5B6C  C9              leave
5B6D  C2 02 00        ret 2

; ---- routine 1B51:5B70  (found by: call)
sub_5B70:
5B70  C8 04 00 00     enter 4, 0
5B74  6B 46 04 0F     imul ax, word ptr [bp + 4], 0xf
5B78  C4 3E BE D7     les di, ptr [0xd7be]
5B7C  03 F8           add di, ax
5B7E  89 7E FC        mov word ptr [bp - 4], di
5B81  8C 46 FE        mov word ptr [bp - 2], es
5B84  6A 20           push 0x20
5B86  9A 6D 07 1A 23  call far 231A:076D
5B8B  C4 7E FC        les di, ptr [bp - 4]
5B8E  26 88 45 06     mov byte ptr es:[di + 6], al
5B92  6A 10           push 0x10
5B94  9A 6D 07 1A 23  call far 231A:076D
5B99  05 08 00        add ax, 8
5B9C  C4 7E FC        les di, ptr [bp - 4]
5B9F  26 88 45 07     mov byte ptr es:[di + 7], al
5BA3  26 8A 45 07     mov al, byte ptr es:[di + 7]
5BA7  26 88 45 08     mov byte ptr es:[di + 8], al
5BAB  C9              leave
5BAC  C2 02 00        ret 2

; ---- routine 1B51:5BAF  (found by: far)
sub_5BAF:
5BAF  C8 04 00 00     enter 4, 0
5BB3  31 C0           xor ax, ax
5BB5  89 46 FE        mov word ptr [bp - 2], ax
5BB8  C7 46 FC 01 00  mov word ptr [bp - 4], 1
5BBD  EB 03           jmp 0x5bc2
loc_5BBF:
5BBF  FF 46 FC        inc word ptr [bp - 4]
loc_5BC2:
5BC2  8B 46 FC        mov ax, word ptr [bp - 4]
5BC5  D1 E0           shl ax, 1
5BC7  C4 7E 06        les di, ptr [bp + 6]
5BCA  03 F8           add di, ax
5BCC  26 8B 45 FE     mov ax, word ptr es:[di - 2]
5BD0  3B 46 0A        cmp ax, word ptr [bp + 0xa]
5BD3  75 08           jne 0x5bdd
5BD5  8B 46 FC        mov ax, word ptr [bp - 4]
5BD8  89 46 FE        mov word ptr [bp - 2], ax
5BDB  EB 06           jmp 0x5be3
loc_5BDD:
5BDD  83 7E FC 14     cmp word ptr [bp - 4], 0x14
5BE1  75 DC           jne 0x5bbf
loc_5BE3:
5BE3  8B 46 FE        mov ax, word ptr [bp - 2]
5BE6  C9              leave
5BE7  CA 06 00        retf 6

; ---- routine 1B51:5BEA  (found by: call, far)
sub_5BEA:
5BEA  C8 04 00 00     enter 4, 0
5BEE  31 C0           xor ax, ax
5BF0  89 46 FE        mov word ptr [bp - 2], ax
5BF3  C7 46 FC 01 00  mov word ptr [bp - 4], 1
5BF8  EB 03           jmp 0x5bfd
loc_5BFA:
5BFA  FF 46 FC        inc word ptr [bp - 4]
loc_5BFD:
5BFD  8B 46 FC        mov ax, word ptr [bp - 4]
5C00  D1 E0           shl ax, 1
5C02  C4 7E 06        les di, ptr [bp + 6]
5C05  03 F8           add di, ax
5C07  26 83 7D FE 00  cmp word ptr es:[di - 2], 0
5C0C  75 0B           jne 0x5c19
5C0E  8B 46 FC        mov ax, word ptr [bp - 4]
5C11  89 46 FE        mov word ptr [bp - 2], ax
5C14  C7 46 FC 14 00  mov word ptr [bp - 4], 0x14
loc_5C19:
5C19  83 7E FC 14     cmp word ptr [bp - 4], 0x14
5C1D  75 DB           jne 0x5bfa
5C1F  8B 46 FE        mov ax, word ptr [bp - 2]
5C22  C9              leave
5C23  CA 04 00        retf 4
; data (not reached as code), 22 bytes
5C26                  pstr 'You have a full squad'

; ---- routine 1B51:5C3C  (found by: call, far)
sub_5C3C:
5C3C  C8 02 00 00     enter 2, 0
5C40  8B 7E 06        mov di, word ptr [bp + 6]
5C43  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
5C47  30 E4           xor ah, ah
5C49  6B C0 3E        imul ax, ax, 0x3e
5C4C  C4 3E C2 D7     les di, ptr [0xd7c2]
5C50  03 F8           add di, ax
5C52  81 C7 C2 FF     add di, 0xffc2
5C56  06              push es
5C57  57              push di
5C58  0E              push cs
5C59  E8 8E FF        call 0x5bea
5C5C  09 C0           or ax, ax
5C5E  75 18           jne 0x5c78
5C60  6B 46 06 28     imul ax, word ptr [bp + 6], 0x28
5C64  C4 3E D2 D7     les di, ptr [0xd7d2]
5C68  03 F8           add di, ax
5C6A  81 C7 30 00     add di, 0x30
5C6E  06              push es
5C6F  57              push di
5C70  0E              push cs
5C71  E8 76 FF        call 0x5bea
5C74  09 C0           or ax, ax
5C76  74 04           je 0x5c7c
loc_5C78:
5C78  B0 00           mov al, 0
5C7A  EB 02           jmp 0x5c7e
loc_5C7C:
5C7C  B0 01           mov al, 1
loc_5C7E:
5C7E  88 46 FE        mov byte ptr [bp - 2], al
5C81  80 7E FE 00     cmp byte ptr [bp - 2], 0
5C85  74 0A           je 0x5c91
5C87  BF 26 5C        mov di, 0x5c26
5C8A  0E              push cs
5C8B  57              push di
5C8C  9A 02 07 AC 24  call far 24AC:0702
loc_5C91:
5C91  8A 46 FE        mov al, byte ptr [bp - 2]
5C94  88 46 FF        mov byte ptr [bp - 1], al
5C97  8A 46 FF        mov al, byte ptr [bp - 1]
5C9A  C9              leave
5C9B  CA 02 00        retf 2

; ---- routine 1B51:5C9E  (found by: call)
sub_5C9E:
5C9E  C8 02 00 00     enter 2, 0
5CA2  C7 46 FE 01 00  mov word ptr [bp - 2], 1
5CA7  EB 03           jmp 0x5cac
loc_5CA9:
5CA9  FF 46 FE        inc word ptr [bp - 2]
loc_5CAC:
5CAC  8B 46 FE        mov ax, word ptr [bp - 2]
5CAF  D1 E0           shl ax, 1
5CB1  C4 7E 06        les di, ptr [bp + 6]
5CB4  03 F8           add di, ax
5CB6  26 83 7D FE 00  cmp word ptr es:[di - 2], 0
5CBB  74 41           je 0x5cfe
5CBD  8B 46 FE        mov ax, word ptr [bp - 2]
5CC0  D1 E0           shl ax, 1
5CC2  C4 7E 06        les di, ptr [bp + 6]
5CC5  03 F8           add di, ax
5CC7  26 8B 45 FE     mov ax, word ptr es:[di - 2]
5CCB  C1 E0 03        shl ax, 3
5CCE  C4 3E BA D7     les di, ptr [0xd7ba]
5CD2  03 F8           add di, ax
5CD4  26 80 7D 01 11  cmp byte ptr es:[di + 1], 0x11
5CD9  76 23           jbe 0x5cfe
5CDB  8B 46 FE        mov ax, word ptr [bp - 2]
5CDE  D1 E0           shl ax, 1
5CE0  C4 7E 06        les di, ptr [bp + 6]
5CE3  03 F8           add di, ax
5CE5  26 6B 45 FE 0F  imul ax, word ptr es:[di - 2], 0xf
5CEA  C4 3E BE D7     les di, ptr [0xd7be]
5CEE  03 F8           add di, ax
5CF0  26 80 7D 0C 00  cmp byte ptr es:[di + 0xc], 0
5CF5  76 07           jbe 0x5cfe
5CF7  8B 7E 04        mov di, word ptr [bp + 4]
5CFA  36 FF 45 FC     inc word ptr ss:[di - 4]
loc_5CFE:
5CFE  83 7E FE 14     cmp word ptr [bp - 2], 0x14
5D02  75 A5           jne 0x5ca9
5D04  C9              leave
5D05  C2 06 00        ret 6

; ---- routine 1B51:5D08  (found by: far)
sub_5D08:
5D08  C8 0C 00 00     enter 0xc, 0
5D0C  C4 3E D2 D7     les di, ptr [0xd7d2]
5D10  89 7E F4        mov word ptr [bp - 0xc], di
5D13  8C 46 F6        mov word ptr [bp - 0xa], es
5D16  31 C0           xor ax, ax
5D18  89 46 FC        mov word ptr [bp - 4], ax
5D1B  8B 7E 06        mov di, word ptr [bp + 6]
5D1E  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
5D22  30 E4           xor ah, ah
5D24  89 46 F8        mov word ptr [bp - 8], ax
5D27  6B 46 F8 3E     imul ax, word ptr [bp - 8], 0x3e
5D2B  C4 3E C2 D7     les di, ptr [0xd7c2]
5D2F  03 F8           add di, ax
5D31  81 C7 C2 FF     add di, 0xffc2
5D35  06              push es
5D36  57              push di
5D37  55              push bp
5D38  E8 63 FF        call 0x5c9e
5D3B  6B 46 06 28     imul ax, word ptr [bp + 6], 0x28
5D3F  C4 7E F4        les di, ptr [bp - 0xc]
5D42  03 F8           add di, ax
5D44  81 C7 30 00     add di, 0x30
5D48  06              push es
5D49  57              push di
5D4A  55              push bp
5D4B  E8 50 FF        call 0x5c9e
5D4E  6B 46 F8 3E     imul ax, word ptr [bp - 8], 0x3e
5D52  C4 3E C2 D7     les di, ptr [0xd7c2]
5D56  03 F8           add di, ax
5D58  26 8B 45 F2     mov ax, word ptr es:[di - 0xe]
5D5C  C1 E0 02        shl ax, 2
5D5F  C4 3E C8 DC     les di, ptr [0xdcc8]
5D63  03 F8           add di, ax
5D65  26 8A 45 02     mov al, byte ptr es:[di + 2]
5D69  30 E4           xor ah, ah
5D6B  05 FF FF        add ax, 0xffff
5D6E  99              cdq
5D6F  B9 10 00        mov cx, 0x10
5D72  F7 F9           idiv cx
5D74  40              inc ax
5D75  40              inc ax
5D76  05 14 00        add ax, 0x14
5D79  99              cdq
5D7A  8B C8           mov cx, ax
5D7C  8B DA           mov bx, dx
5D7E  8B 46 FC        mov ax, word ptr [bp - 4]
5D81  31 D2           xor dx, dx
5D83  3B D3           cmp dx, bx
5D85  7F 0A           jg 0x5d91
5D87  7C 04           jl 0x5d8d
5D89  3B C1           cmp ax, cx
5D8B  73 04           jae 0x5d91
loc_5D8D:
5D8D  B0 00           mov al, 0
5D8F  EB 02           jmp 0x5d93
loc_5D91:
5D91  B0 01           mov al, 1
loc_5D93:
5D93  88 46 FF        mov byte ptr [bp - 1], al
5D96  8A 46 FF        mov al, byte ptr [bp - 1]
5D99  C9              leave
5D9A  CA 02 00        retf 2

; ---- routine 1B51:5D9D  (found by: call)
sub_5D9D:
5D9D  C8 02 00 00     enter 2, 0
5DA1  A0 E2 12        mov al, byte ptr [0x12e2]
5DA4  30 E4           xor ah, ah
5DA6  50              push ax
5DA7  9A 6D 07 1A 23  call far 231A:076D
5DAC  8B F8           mov di, ax
5DAE  8A 85 E2 12     mov al, byte ptr [di + 0x12e2]
5DB2  88 46 FF        mov byte ptr [bp - 1], al
5DB5  8A 46 FF        mov al, byte ptr [bp - 1]
5DB8  C9              leave
5DB9  C3              ret

; ---- routine 1B51:5DBA  (found by: far)
sub_5DBA:
5DBA  C8 0C 01 00     enter 0x10c, 0
5DBE  31 C0           xor ax, ax
5DC0  A3 84 D6        mov word ptr [0xd684], ax
5DC3  FF 76 08        push word ptr [bp + 8]
5DC6  0E              push cs
5DC7  E8 72 FE        call 0x5c3c
5DCA  08 C0           or al, al
5DCC  74 03           je 0x5dd1
5DCE  E9 DC 02        jmp 0x60ad
loc_5DD1:
5DD1  6A 01           push 1
5DD3  0E              push cs
5DD4  E8 CA FB        call 0x59a1
5DD7  88 46 F9        mov byte ptr [bp - 7], al
5DDA  80 7E F9 FF     cmp byte ptr [bp - 7], 0xff
5DDE  75 03           jne 0x5de3
5DE0  E9 CA 02        jmp 0x60ad
loc_5DE3:
5DE3  E8 97 FC        call 0x5a7d
5DE6  89 46 FE        mov word ptr [bp - 2], ax
5DE9  8A 46 F9        mov al, byte ptr [bp - 7]
5DEC  88 46 F7        mov byte ptr [bp - 9], al
5DEF  80 7E F9 00     cmp byte ptr [bp - 7], 0
5DF3  75 03           jne 0x5df8
5DF5  E9 92 00        jmp 0x5e8a
loc_5DF8:
5DF8  6A 05           push 5
5DFA  9A 6D 07 1A 23  call far 231A:076D
5DFF  05 09 00        add ax, 9
5E02  88 46 F8        mov byte ptr [bp - 8], al
5E05  8D BE F4 FE     lea di, [bp - 0x10c]
5E09  16              push ss
5E0A  57              push di
5E0B  8A 46 F9        mov al, byte ptr [bp - 7]
5E0E  50              push ax
5E0F  9A 6F 0C B9 26  call far 26B9:0C6F
5E14  BF 9A 0D        mov di, 0xd9a
5E17  1E              push ds
5E18  57              push di
5E19  9A FE 0B B9 26  call far 26B9:0BFE
5E1E  89 46 FA        mov word ptr [bp - 6], ax
5E21  C6 46 F6 00     mov byte ptr [bp - 0xa], 0
loc_5E25:
5E25  6A 0D           push 0xd
5E27  9A 6D 07 1A 23  call far 231A:076D
5E2C  89 46 F4        mov word ptr [bp - 0xc], ax
5E2F  8A 56 F4        mov dl, byte ptr [bp - 0xc]
5E32  8B 46 FE        mov ax, word ptr [bp - 2]
5E35  C1 E0 03        shl ax, 3
5E38  C4 3E BA D7     les di, ptr [0xd7ba]
5E3C  03 F8           add di, ax
5E3E  26 88 55 07     mov byte ptr es:[di + 7], dl
5E42  8A 46 F8        mov al, byte ptr [bp - 8]
5E45  98              cwde
5E46  8B C8           mov cx, ax
5E48  8B 56 F4        mov dx, word ptr [bp - 0xc]
5E4B  8A 46 F9        mov al, byte ptr [bp - 7]
5E4E  98              cwde
5E4F  6B F8 0E        imul di, ax, 0xe
5E52  03 FA           add di, dx
5E54  8A 85 A6 0D     mov al, byte ptr [di + 0xda6]
5E58  30 E4           xor ah, ah
5E5A  3B C1           cmp ax, cx
5E5C  7C 26           jl 0x5e84
5E5E  83 7E FA 00     cmp word ptr [bp - 6], 0
5E62  74 16           je 0x5e7a
5E64  FF 76 FE        push word ptr [bp - 2]
5E67  0E              push cs
5E68  E8 76 EF        call 0x4de1
5E6B  8A D0           mov dl, al
5E6D  83 7E FA 03     cmp word ptr [bp - 6], 3
5E71  B0 00           mov al, 0
5E73  76 01           jbe 0x5e76
5E75  40              inc ax
loc_5E76:
5E76  3A C2           cmp al, dl
5E78  75 0A           jne 0x5e84
loc_5E7A:
5E7A  8A 46 F4        mov al, byte ptr [bp - 0xc]
5E7D  88 46 F9        mov byte ptr [bp - 7], al
5E80  C6 46 F6 01     mov byte ptr [bp - 0xa], 1
loc_5E84:
5E84  80 7E F6 00     cmp byte ptr [bp - 0xa], 0
5E88  74 9B           je 0x5e25
loc_5E8A:
5E8A  8B 7E 08        mov di, word ptr [bp + 8]
5E8D  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
5E91  30 E4           xor ah, ah
5E93  50              push ax
5E94  0E              push cs
5E95  E8 56 BC        call 0x1aee
5E98  08 C0           or al, al
5E9A  75 1F           jne 0x5ebb
5E9C  8B 7E 08        mov di, word ptr [bp + 8]
5E9F  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
5EA3  30 E4           xor ah, ah
5EA5  C4 3E B6 D7     les di, ptr [0xd7b6]
5EA9  03 F8           add di, ax
5EAB  26 8A 55 FF     mov dl, byte ptr es:[di - 1]
5EAF  8B 46 FE        mov ax, word ptr [bp - 2]
5EB2  C4 3E AE D7     les di, ptr [0xd7ae]
5EB6  03 F8           add di, ax
5EB8  26 88 15        mov byte ptr es:[di], dl
loc_5EBB:
5EBB  E8 DF FE        call 0x5d9d
5EBE  8A D0           mov dl, al
5EC0  8B 46 FE        mov ax, word ptr [bp - 2]
5EC3  C4 3E AA D7     les di, ptr [0xd7aa]
5EC7  03 F8           add di, ax
5EC9  26 88 15        mov byte ptr es:[di], dl
5ECC  8B 46 FE        mov ax, word ptr [bp - 2]
5ECF  C1 E0 03        shl ax, 3
5ED2  C4 3E BA D7     les di, ptr [0xd7ba]
5ED6  03 F8           add di, ax
5ED8  06              push es
5ED9  57              push di
5EDA  6A 08           push 8
5EDC  6A 00           push 0
5EDE  9A 22 02 AC 24  call far 24AC:0222
5EE3  6B 46 FE 0F     imul ax, word ptr [bp - 2], 0xf
5EE7  C4 3E BE D7     les di, ptr [0xd7be]
5EEB  03 F8           add di, ax
5EED  06              push es
5EEE  57              push di
5EEF  6A 0F           push 0xf
5EF1  6A 00           push 0
5EF3  9A 22 02 AC 24  call far 24AC:0222
5EF8  6B 46 06 3E     imul ax, word ptr [bp + 6], 0x3e
5EFC  C4 3E C2 D7     les di, ptr [0xd7c2]
5F00  03 F8           add di, ax
5F02  81 C7 C2 FF     add di, 0xffc2
5F06  89 7E F0        mov word ptr [bp - 0x10], di
5F09  8C 46 F2        mov word ptr [bp - 0xe], es
5F0C  6B 46 08 28     imul ax, word ptr [bp + 8], 0x28
5F10  C4 3E D2 D7     les di, ptr [0xd7d2]
5F14  03 F8           add di, ax
5F16  81 C7 30 00     add di, 0x30
5F1A  06              push es
5F1B  57              push di
5F1C  0E              push cs
5F1D  E8 CA FC        call 0x5bea
5F20  09 C0           or ax, ax
5F22  74 2E           je 0x5f52
5F24  FF 76 FE        push word ptr [bp - 2]
5F27  6B 46 08 28     imul ax, word ptr [bp + 8], 0x28
5F2B  C4 3E D2 D7     les di, ptr [0xd7d2]
5F2F  03 F8           add di, ax
5F31  81 C7 30 00     add di, 0x30
5F35  06              push es
5F36  57              push di
5F37  0E              push cs
5F38  E8 AF FC        call 0x5bea
5F3B  D1 E0           shl ax, 1
5F3D  8B D0           mov dx, ax
5F3F  6B 46 08 28     imul ax, word ptr [bp + 8], 0x28
5F43  C4 3E D2 D7     les di, ptr [0xd7d2]
5F47  03 F8           add di, ax
5F49  03 FA           add di, dx
5F4B  58              pop ax
5F4C  26 89 45 2E     mov word ptr es:[di + 0x2e], ax
5F50  EB 18           jmp 0x5f6a
loc_5F52:
5F52  FF 76 FE        push word ptr [bp - 2]
5F55  C4 7E F0        les di, ptr [bp - 0x10]
5F58  06              push es
5F59  57              push di
5F5A  0E              push cs
5F5B  E8 8C FC        call 0x5bea
5F5E  D1 E0           shl ax, 1
5F60  C4 7E F0        les di, ptr [bp - 0x10]
5F63  03 F8           add di, ax
5F65  58              pop ax
5F66  26 89 45 FE     mov word ptr es:[di - 2], ax
loc_5F6A:
5F6A  8B 46 FE        mov ax, word ptr [bp - 2]
5F6D  C1 E0 03        shl ax, 3
5F70  C4 3E BA D7     les di, ptr [0xd7ba]
5F74  03 F8           add di, ax
5F76  89 7E F0        mov word ptr [bp - 0x10], di
5F79  8C 46 F2        mov word ptr [bp - 0xe], es
5F7C  8A 46 06        mov al, byte ptr [bp + 6]
5F7F  26 88 05        mov byte ptr es:[di], al
5F82  8A 46 F9        mov al, byte ptr [bp - 7]
5F85  26 88 45 07     mov byte ptr es:[di + 7], al
5F89  8A 46 F7        mov al, byte ptr [bp - 9]
5F8C  26 88 45 06     mov byte ptr es:[di + 6], al
5F90  6A 10           push 0x10
5F92  9A 6D 07 1A 23  call far 231A:076D
5F97  C4 7E F0        les di, ptr [bp - 0x10]
5F9A  26 88 45 05     mov byte ptr es:[di + 5], al
5F9E  26 80 7D 07 00  cmp byte ptr es:[di + 7], 0
5FA3  75 07           jne 0x5fac
5FA5  26 C6 45 01 11  mov byte ptr es:[di + 1], 0x11
5FAA  EB 11           jmp 0x5fbd
loc_5FAC:
5FAC  6A 03           push 3
5FAE  9A 6D 07 1A 23  call far 231A:076D
5FB3  05 0E 00        add ax, 0xe
5FB6  C4 7E F0        les di, ptr [bp - 0x10]
5FB9  26 88 45 01     mov byte ptr es:[di + 1], al
loc_5FBD:
5FBD  FF 76 FE        push word ptr [bp - 2]
5FC0  0E              push cs
5FC1  E8 F7 F2        call 0x52bb
5FC4  C4 7E F0        les di, ptr [bp - 0x10]
5FC7  26 8A 05        mov al, byte ptr es:[di]
5FCA  30 E4           xor ah, ah
5FCC  6B C0 3E        imul ax, ax, 0x3e
5FCF  C4 3E C2 D7     les di, ptr [0xd7c2]
5FD3  03 F8           add di, ax
5FD5  26 8A 45 F9     mov al, byte ptr es:[di - 7]
5FD9  98              cwde
5FDA  8B F8           mov di, ax
5FDC  8A 85 0A 13     mov al, byte ptr [di + 0x130a]
5FE0  30 E4           xor ah, ah
5FE2  50              push ax
5FE3  9A 1C 0D AC 24  call far 24AC:0D1C
5FE8  08 C0           or al, al
5FEA  74 0D           je 0x5ff9
5FEC  68 B0 00        push 0xb0
5FEF  9A 6D 07 1A 23  call far 231A:076D
5FF4  89 46 F4        mov word ptr [bp - 0xc], ax
5FF7  EB 47           jmp 0x6040
loc_5FF9:
5FF9  6B 46 06 3E     imul ax, word ptr [bp + 6], 0x3e
5FFD  C4 3E C2 D7     les di, ptr [0xd7c2]
6001  03 F8           add di, ax
6003  26 8B 45 F0     mov ax, word ptr es:[di - 0x10]
6007  C1 E0 02        shl ax, 2
600A  C4 3E C8 DC     les di, ptr [0xdcc8]
600E  03 F8           add di, ax
6010  26 8A 45 02     mov al, byte ptr es:[di + 2]
6014  30 E4           xor ah, ah
6016  50              push ax
6017  9A 6D 07 1A 23  call far 231A:076D
601C  50              push ax
601D  6B 46 06 3E     imul ax, word ptr [bp + 6], 0x3e
6021  C4 3E C2 D7     les di, ptr [0xd7c2]
6025  03 F8           add di, ax
6027  26 8A 45 F5     mov al, byte ptr es:[di - 0xb]
602B  30 E4           xor ah, ah
602D  8B D0           mov dx, ax
602F  B8 B1 00        mov ax, 0xb1
6032  2B C2           sub ax, dx
6034  50              push ax
6035  9A 6D 07 1A 23  call far 231A:076D
603A  5A              pop dx
603B  03 C2           add ax, dx
603D  89 46 F4        mov word ptr [bp - 0xc], ax
loc_6040:
6040  8B 46 F4        mov ax, word ptr [bp - 0xc]
6043  05 4F 00        add ax, 0x4f
6046  99              cdq
6047  B9 02 00        mov cx, 2
604A  F7 F9           idiv cx
604C  89 46 F4        mov word ptr [bp - 0xc], ax
604F  8A 46 F4        mov al, byte ptr [bp - 0xc]
6052  C4 7E F0        les di, ptr [bp - 0x10]
6055  26 88 45 03     mov byte ptr es:[di + 3], al
6059  FF 76 FE        push word ptr [bp - 2]
605C  0E              push cs
605D  E8 84 F1        call 0x51e4
6060  C4 7E F0        les di, ptr [bp - 0x10]
6063  26 8A 45 04     mov al, byte ptr es:[di + 4]
6067  30 E4           xor ah, ah
6069  D1 E8           shr ax, 1
606B  50              push ax
606C  9A 6D 07 1A 23  call far 231A:076D
6071  C4 7E F0        les di, ptr [bp - 0x10]
6074  26 28 45 04     sub byte ptr es:[di + 4], al
6078  FF 76 FE        push word ptr [bp - 2]
607B  E8 F2 FA        call 0x5b70
607E  6B 46 FE 0F     imul ax, word ptr [bp - 2], 0xf
6082  C4 3E BE D7     les di, ptr [0xd7be]
6086  03 F8           add di, ax
6088  26 C6 45 09 14  mov byte ptr es:[di + 9], 0x14
608D  26 C6 45 0D 03  mov byte ptr es:[di + 0xd], 3
6092  FF 76 FE        push word ptr [bp - 2]
6095  0E              push cs
6096  E8 C2 F2        call 0x535b
6099  6B 46 06 3E     imul ax, word ptr [bp + 6], 0x3e
609D  C4 3E C2 D7     les di, ptr [0xd7c2]
60A1  03 F8           add di, ax
60A3  26 FE 45 F4     inc byte ptr es:[di - 0xc]
60A7  8B 46 FE        mov ax, word ptr [bp - 2]
60AA  A3 84 D6        mov word ptr [0xd684], ax
loc_60AD:
60AD  C9              leave
60AE  CA 04 00        retf 4

; ---- routine 1B51:60B1  (found by: call, far)
sub_60B1:
60B1  C8 06 00 00     enter 6, 0
60B5  FF 76 0A        push word ptr [bp + 0xa]
60B8  E8 04 FA        call 0x5abf
60BB  89 46 FE        mov word ptr [bp - 2], ax
60BE  E8 DC FC        call 0x5d9d
60C1  8A D0           mov dl, al
60C3  8B 46 FE        mov ax, word ptr [bp - 2]
60C6  C4 3E AA D7     les di, ptr [0xd7aa]
60CA  03 F8           add di, ax
60CC  26 88 15        mov byte ptr es:[di], dl
60CF  8B 46 FE        mov ax, word ptr [bp - 2]
60D2  C1 E0 03        shl ax, 3
60D5  C4 3E BA D7     les di, ptr [0xd7ba]
60D9  03 F8           add di, ax
60DB  06              push es
60DC  57              push di
60DD  6A 08           push 8
60DF  6A 00           push 0
60E1  9A 22 02 AC 24  call far 24AC:0222
60E6  6B 46 FE 0F     imul ax, word ptr [bp - 2], 0xf
60EA  C4 3E BE D7     les di, ptr [0xd7be]
60EE  03 F8           add di, ax
60F0  06              push es
60F1  57              push di
60F2  6A 0F           push 0xf
60F4  6A 00           push 0
60F6  9A 22 02 AC 24  call far 24AC:0222
60FB  6B 46 0A 3E     imul ax, word ptr [bp + 0xa], 0x3e
60FF  C4 3E C2 D7     les di, ptr [0xd7c2]
6103  03 F8           add di, ax
6105  81 C7 C2 FF     add di, 0xffc2
6109  8B 56 FE        mov dx, word ptr [bp - 2]
610C  8B 46 08        mov ax, word ptr [bp + 8]
610F  D1 E0           shl ax, 1
6111  03 F8           add di, ax
6113  26 89 55 FE     mov word ptr es:[di - 2], dx
6117  8B 46 FE        mov ax, word ptr [bp - 2]
611A  C1 E0 03        shl ax, 3
611D  C4 3E BA D7     les di, ptr [0xd7ba]
6121  03 F8           add di, ax
6123  89 7E FA        mov word ptr [bp - 6], di
6126  8C 46 FC        mov word ptr [bp - 4], es
6129  8A 46 0A        mov al, byte ptr [bp + 0xa]
612C  26 88 05        mov byte ptr es:[di], al
612F  8A 46 06        mov al, byte ptr [bp + 6]
6132  26 88 45 07     mov byte ptr es:[di + 7], al
6136  8A 46 06        mov al, byte ptr [bp + 6]
6139  26 88 45 06     mov byte ptr es:[di + 6], al
613D  6A 10           push 0x10
613F  9A 6D 07 1A 23  call far 231A:076D
6144  C4 7E FA        les di, ptr [bp - 6]
6147  26 88 45 05     mov byte ptr es:[di + 5], al
614B  6A 03           push 3
614D  9A 6D 07 1A 23  call far 231A:076D
6152  50              push ax
6153  6A 02           push 2
6155  9A 6D 07 1A 23  call far 231A:076D
615A  8B D0           mov dx, ax
615C  C4 7E FA        les di, ptr [bp - 6]
615F  26 80 7D 07 00  cmp byte ptr es:[di + 7], 0
6164  B0 00           mov al, 0
6166  75 01           jne 0x6169
6168  40              inc ax
loc_6169:
6169  98              cwde
616A  8B F8           mov di, ax
616C  8A 85 12 13     mov al, byte ptr [di + 0x1312]
6170  30 E4           xor ah, ah
6172  03 C2           add ax, dx
6174  5A              pop dx
6175  2B C2           sub ax, dx
6177  C4 7E FA        les di, ptr [bp - 6]
617A  26 88 45 01     mov byte ptr es:[di + 1], al
617E  FF 76 FE        push word ptr [bp - 2]
6181  0E              push cs
6182  E8 36 F1        call 0x52bb
6185  6B 46 0A 3E     imul ax, word ptr [bp + 0xa], 0x3e
6189  C4 3E C2 D7     les di, ptr [0xd7c2]
618D  03 F8           add di, ax
618F  26 8A 45 F5     mov al, byte ptr es:[di - 0xb]
6193  30 E4           xor ah, ah
6195  8B D0           mov dx, ax
6197  B8 B0 00        mov ax, 0xb0
619A  2B C2           sub ax, dx
619C  05 50 00        add ax, 0x50
619F  C4 7E FA        les di, ptr [bp - 6]
61A2  26 88 45 03     mov byte ptr es:[di + 3], al
61A6  FF 76 FE        push word ptr [bp - 2]
61A9  0E              push cs
61AA  E8 37 F0        call 0x51e4
61AD  FF 76 FE        push word ptr [bp - 2]
61B0  E8 BD F9        call 0x5b70
61B3  FF 76 FE        push word ptr [bp - 2]
61B6  0E              push cs
61B7  E8 DE 02        call 0x6498
61BA  FF 76 FE        push word ptr [bp - 2]
61BD  0E              push cs
61BE  E8 9A F1        call 0x535b
61C1  C9              leave
61C2  CA 06 00        retf 6

; ---- routine 1B51:61C5  (found by: far)
sub_61C5:
61C5  C8 0E 00 00     enter 0xe, 0
61C9  31 C0           xor ax, ax
61CB  89 46 FA        mov word ptr [bp - 6], ax
61CE  C7 46 FC 01 00  mov word ptr [bp - 4], 1
61D3  EB 03           jmp 0x61d8
loc_61D5:
61D5  FF 46 FC        inc word ptr [bp - 4]
loc_61D8:
61D8  6B 46 FC 3E     imul ax, word ptr [bp - 4], 0x3e
61DC  C4 3E C2 D7     les di, ptr [0xd7c2]
61E0  03 F8           add di, ax
61E2  81 C7 C2 FF     add di, 0xffc2
61E6  89 7E F4        mov word ptr [bp - 0xc], di
61E9  8C 46 F6        mov word ptr [bp - 0xa], es
61EC  26 8A 45 37     mov al, byte ptr es:[di + 0x37]
61F0  98              cwde
61F1  8B F8           mov di, ax
61F3  8A 85 62 A2     mov al, byte ptr [di - 0x5d9e]
61F7  C4 7E F4        les di, ptr [bp - 0xc]
61FA  26 88 45 32     mov byte ptr es:[di + 0x32], al
61FE  26 8A 45 32     mov al, byte ptr es:[di + 0x32]
6202  30 E4           xor ah, ah
6204  89 46 F2        mov word ptr [bp - 0xe], ax
6207  B8 01 00        mov ax, 1
620A  3B 46 F2        cmp ax, word ptr [bp - 0xe]
620D  77 26           ja 0x6235
620F  89 46 FE        mov word ptr [bp - 2], ax
6212  EB 03           jmp 0x6217
loc_6214:
6214  FF 46 FE        inc word ptr [bp - 2]
loc_6217:
6217  8B 46 FA        mov ax, word ptr [bp - 6]
621A  03 46 FE        add ax, word ptr [bp - 2]
621D  8B D0           mov dx, ax
621F  8B 46 FE        mov ax, word ptr [bp - 2]
6222  D1 E0           shl ax, 1
6224  C4 7E F4        les di, ptr [bp - 0xc]
6227  03 F8           add di, ax
6229  26 89 55 FE     mov word ptr es:[di - 2], dx
622D  8B 46 FE        mov ax, word ptr [bp - 2]
6230  3B 46 F2        cmp ax, word ptr [bp - 0xe]
6233  75 DF           jne 0x6214
loc_6235:
6235  FF 76 FC        push word ptr [bp - 4]
6238  0E              push cs
6239  E8 0B F4        call 0x5647
623C  83 46 FA 14     add word ptr [bp - 6], 0x14
6240  81 7E FC B0 00  cmp word ptr [bp - 4], 0xb0
6245  75 8E           jne 0x61d5
6247  C9              leave
6248  CB              retf

; ---- routine 1B51:6249  (found by: call)
sub_6249:
6249  C8 04 00 00     enter 4, 0
624D  C4 7E 08        les di, ptr [bp + 8]
6250  89 7E FC        mov word ptr [bp - 4], di
6253  8C 46 FE        mov word ptr [bp - 2], es
6256  8B 46 06        mov ax, word ptr [bp + 6]
6259  C4 3E AA D7     les di, ptr [0xd7aa]
625D  03 F8           add di, ax
625F  26 8A 05        mov al, byte ptr es:[di]
6262  C4 7E FC        les di, ptr [bp - 4]
6265  26 88 45 04     mov byte ptr es:[di + 4], al
6269  8B 46 06        mov ax, word ptr [bp + 6]
626C  26 89 05        mov word ptr es:[di], ax
626F  8B 46 04        mov ax, word ptr [bp + 4]
6272  26 89 45 02     mov word ptr es:[di + 2], ax
6276  8B 46 06        mov ax, word ptr [bp + 6]
6279  C1 E0 03        shl ax, 3
627C  C4 3E BA D7     les di, ptr [0xd7ba]
6280  03 F8           add di, ax
6282  26 8A 45 07     mov al, byte ptr es:[di + 7]
6286  C4 7E FC        les di, ptr [bp - 4]
6289  26 88 45 05     mov byte ptr es:[di + 5], al
628D  C9              leave
628E  C2 08 00        ret 8

; ---- routine 1B51:6291  (found by: call, far)
sub_6291:
6291  C8 0C 00 00     enter 0xc, 0
6295  8B 46 0C        mov ax, word ptr [bp + 0xc]
6298  C1 E0 03        shl ax, 3
629B  C4 3E BA D7     les di, ptr [0xd7ba]
629F  03 F8           add di, ax
62A1  89 7E FC        mov word ptr [bp - 4], di
62A4  8C 46 FE        mov word ptr [bp - 2], es
62A7  6B 46 0C 0F     imul ax, word ptr [bp + 0xc], 0xf
62AB  C4 3E BE D7     les di, ptr [0xd7be]
62AF  03 F8           add di, ax
62B1  89 7E F8        mov word ptr [bp - 8], di
62B4  8C 46 FA        mov word ptr [bp - 6], es
62B7  69 46 08 3A 23  imul ax, word ptr [bp + 8], 0x233a
62BC  C4 3E E2 DC     les di, ptr [0xdce2]
62C0  03 F8           add di, ax
62C2  81 C7 C6 DC     add di, 0xdcc6
62C6  06              push es
62C7  57              push di
62C8  69 46 08 3A 23  imul ax, word ptr [bp + 8], 0x233a
62CD  C4 3E E2 DC     les di, ptr [0xdce2]
62D1  03 F8           add di, ax
62D3  81 C7 D8 DC     add di, 0xdcd8
62D7  06              push es
62D8  57              push di
62D9  68 16 23        push 0x2316
62DC  9A C2 01 AC 24  call far 24AC:01C2
62E1  69 46 08 3A 23  imul ax, word ptr [bp + 8], 0x233a
62E6  C4 3E E2 DC     les di, ptr [0xdce2]
62EA  03 F8           add di, ax
62EC  81 C7 D8 DC     add di, 0xdcd8
62F0  89 7E F4        mov word ptr [bp - 0xc], di
62F3  8C 46 F6        mov word ptr [bp - 0xa], es
62F6  8B 46 0C        mov ax, word ptr [bp + 0xc]
62F9  C4 3E AA D7     les di, ptr [0xd7aa]
62FD  03 F8           add di, ax
62FF  26 8A 05        mov al, byte ptr es:[di]
6302  C4 7E F4        les di, ptr [bp - 0xc]
6305  26 88 05        mov byte ptr es:[di], al
6308  8B 46 0C        mov ax, word ptr [bp + 0xc]
630B  26 89 45 01     mov word ptr es:[di + 1], ax
630F  8B 7E 08        mov di, word ptr [bp + 8]
6312  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
6316  30 E4           xor ah, ah
6318  3B 46 0A        cmp ax, word ptr [bp + 0xa]
631B  B0 00           mov al, 0
631D  75 01           jne 0x6320
631F  40              inc ax
loc_6320:
6320  C4 7E F4        les di, ptr [bp - 0xc]
6323  26 88 45 03     mov byte ptr es:[di + 3], al
6327  8A 46 06        mov al, byte ptr [bp + 6]
632A  26 88 45 04     mov byte ptr es:[di + 4], al
632E  C4 7E FC        les di, ptr [bp - 4]
6331  26 8A 45 01     mov al, byte ptr es:[di + 1]
6335  C4 7E F4        les di, ptr [bp - 0xc]
6338  26 88 45 05     mov byte ptr es:[di + 5], al
633C  C4 7E F8        les di, ptr [bp - 8]
633F  26 8B 05        mov ax, word ptr es:[di]
6342  C4 7E F4        les di, ptr [bp - 0xc]
6345  26 89 45 0B     mov word ptr es:[di + 0xb], ax
6349  C4 7E F8        les di, ptr [bp - 8]
634C  26 8B 45 02     mov ax, word ptr es:[di + 2]
6350  C4 7E F4        les di, ptr [bp - 0xc]
6353  26 89 45 0D     mov word ptr es:[di + 0xd], ax
6357  C4 7E FC        les di, ptr [bp - 4]
635A  26 8A 45 07     mov al, byte ptr es:[di + 7]
635E  C4 7E F4        les di, ptr [bp - 0xc]
6361  26 88 45 06     mov byte ptr es:[di + 6], al
6365  C4 3E D2 D7     les di, ptr [0xd7d2]
6369  26 8A 45 01     mov al, byte ptr es:[di + 1]
636D  30 E4           xor ah, ah
636F  C4 7E F4        les di, ptr [bp - 0xc]
6372  26 89 45 0F     mov word ptr es:[di + 0xf], ax
6376  C4 3E D2 D7     les di, ptr [0xd7d2]
637A  26 8A 05        mov al, byte ptr es:[di]
637D  C4 7E F4        les di, ptr [bp - 0xc]
6380  26 88 45 11     mov byte ptr es:[di + 0x11], al
6384  C9              leave
6385  CA 08 00        retf 8

; ---- routine 1B51:6388  (found by: far)
sub_6388:
6388  C8 08 00 00     enter 8, 0
638C  6B 46 0C 2E     imul ax, word ptr [bp + 0xc], 0x2e
6390  C4 3E C0 DC     les di, ptr [0xdcc0]
6394  03 F8           add di, ax
6396  81 C7 D2 FF     add di, 0xffd2
639A  89 7E FC        mov word ptr [bp - 4], di
639D  8C 46 FE        mov word ptr [bp - 2], es
63A0  6B 46 0E 0F     imul ax, word ptr [bp + 0xe], 0xf
63A4  C4 3E BE D7     les di, ptr [0xd7be]
63A8  03 F8           add di, ax
63AA  89 7E F8        mov word ptr [bp - 8], di
63AD  8C 46 FA        mov word ptr [bp - 6], es
63B0  26 8B 05        mov ax, word ptr es:[di]
63B3  C4 7E FC        les di, ptr [bp - 4]
63B6  26 3B 45 2A     cmp ax, word ptr es:[di + 0x2a]
63BA  76 12           jbe 0x63ce
63BC  81 C7 28 00     add di, 0x28
63C0  06              push es
63C1  57              push di
63C2  FF 76 0E        push word ptr [bp + 0xe]
63C5  C4 7E F8        les di, ptr [bp - 8]
63C8  26 FF 35        push word ptr es:[di]
63CB  E8 7B FE        call 0x6249
loc_63CE:
63CE  80 7E 0A 00     cmp byte ptr [bp + 0xa], 0
63D2  74 10           je 0x63e4
63D4  FF 76 0E        push word ptr [bp + 0xe]
63D7  FF 76 0C        push word ptr [bp + 0xc]
63DA  FF 76 08        push word ptr [bp + 8]
63DD  FF 76 06        push word ptr [bp + 6]
63E0  0E              push cs
63E1  E8 AD FE        call 0x6291
loc_63E4:
63E4  8B 46 0E        mov ax, word ptr [bp + 0xe]
63E7  C1 E0 03        shl ax, 3
63EA  C4 3E BA D7     les di, ptr [0xd7ba]
63EE  03 F8           add di, ax
63F0  26 80 7D 07 00  cmp byte ptr es:[di + 7], 0
63F5  75 02           jne 0x63f9
63F7  EB 4B           jmp 0x6444
loc_63F9:
63F9  C4 7E F8        les di, ptr [bp - 8]
63FC  26 8A 45 05     mov al, byte ptr es:[di + 5]
6400  30 E4           xor ah, ah
6402  C4 7E FC        les di, ptr [bp - 4]
6405  26 3B 45 1E     cmp ax, word ptr es:[di + 0x1e]
6409  76 16           jbe 0x6421
640B  81 C7 1C 00     add di, 0x1c
640F  06              push es
6410  57              push di
6411  FF 76 0E        push word ptr [bp + 0xe]
6414  C4 7E F8        les di, ptr [bp - 8]
6417  26 8A 45 05     mov al, byte ptr es:[di + 5]
641B  30 E4           xor ah, ah
641D  50              push ax
641E  E8 28 FE        call 0x6249
loc_6421:
6421  C4 7E F8        les di, ptr [bp - 8]
6424  26 8B 45 02     mov ax, word ptr es:[di + 2]
6428  C4 7E FC        les di, ptr [bp - 4]
642B  26 3B 45 24     cmp ax, word ptr es:[di + 0x24]
642F  76 13           jbe 0x6444
6431  81 C7 22 00     add di, 0x22
6435  06              push es
6436  57              push di
6437  FF 76 0E        push word ptr [bp + 0xe]
643A  C4 7E F8        les di, ptr [bp - 8]
643D  26 FF 75 02     push word ptr es:[di + 2]
6441  E8 05 FE        call 0x6249
loc_6444:
6444  C9              leave
6445  CA 0A 00        retf 0xa

; ---- routine 1B51:6448  (found by: call, far)
sub_6448:
6448  C8 04 00 00     enter 4, 0
644C  6B 46 0C 0F     imul ax, word ptr [bp + 0xc], 0xf
6450  C4 3E BE D7     les di, ptr [0xd7be]
6454  03 F8           add di, ax
6456  89 7E FC        mov word ptr [bp - 4], di
6459  8C 46 FE        mov word ptr [bp - 2], es
645C  26 C6 45 0D 00  mov byte ptr es:[di + 0xd], 0
6461  8A 46 0A        mov al, byte ptr [bp + 0xa]
6464  26 88 45 0C     mov byte ptr es:[di + 0xc], al
6468  8A 46 08        mov al, byte ptr [bp + 8]
646B  26 88 45 09     mov byte ptr es:[di + 9], al
646F  80 7E 06 00     cmp byte ptr [bp + 6], 0
6473  74 0F           je 0x6484
6475  6A 01           push 1
6477  81 C7 0B 00     add di, 0xb
647B  06              push es
647C  57              push di
647D  9A D5 00 1A 23  call far 231A:00D5
6482  EB 10           jmp 0x6494
loc_6484:
6484  6A 01           push 1
6486  C4 7E FC        les di, ptr [bp - 4]
6489  81 C7 0B 00     add di, 0xb
648D  06              push es
648E  57              push di
648F  9A F8 00 1A 23  call far 231A:00F8
loc_6494:
6494  C9              leave
6495  CA 08 00        retf 8

; ---- routine 1B51:6498  (found by: call, far)
sub_6498:
6498  C8 08 00 00     enter 8, 0
649C  8B 46 06        mov ax, word ptr [bp + 6]
649F  C1 E0 03        shl ax, 3
64A2  C4 3E BA D7     les di, ptr [0xd7ba]
64A6  03 F8           add di, ax
64A8  89 7E FC        mov word ptr [bp - 4], di
64AB  8C 46 FE        mov word ptr [bp - 2], es
64AE  6B 46 06 0F     imul ax, word ptr [bp + 6], 0xf
64B2  C4 3E BE D7     les di, ptr [0xd7be]
64B6  03 F8           add di, ax
64B8  C4 7E FC        les di, ptr [bp - 4]
64BB  26 8A 45 02     mov al, byte ptr es:[di + 2]
64BF  30 E4           xor ah, ah
64C1  40              inc ax
64C2  40              inc ax
64C3  8B D0           mov dx, ax
64C5  26 8A 45 01     mov al, byte ptr es:[di + 1]
64C9  30 E4           xor ah, ah
64CB  3B C2           cmp ax, dx
64CD  7E 22           jle 0x64f1
64CF  FF 76 06        push word ptr [bp + 6]
64D2  A0 14 13        mov al, byte ptr [0x1314]
64D5  30 E4           xor ah, ah
64D7  50              push ax
64D8  26 8A 45 04     mov al, byte ptr es:[di + 4]
64DC  30 E4           xor ah, ah
64DE  50              push ax
64DF  26 80 7D 04 B4  cmp byte ptr es:[di + 4], 0xb4
64E4  B0 00           mov al, 0
64E6  76 01           jbe 0x64e9
64E8  40              inc ax
loc_64E9:
64E9  50              push ax
64EA  0E              push cs
64EB  E8 5A FF        call 0x6448
64EE  E9 EF 00        jmp 0x65e0
loc_64F1:
64F1  C4 7E FC        les di, ptr [bp - 4]
64F4  26 80 7D 01 16  cmp byte ptr es:[di + 1], 0x16
64F9  73 31           jae 0x652c
64FB  FF 76 06        push word ptr [bp + 6]
64FE  6A 02           push 2
6500  9A 6D 07 1A 23  call far 231A:076D
6505  40              inc ax
6506  40              inc ax
6507  8B F8           mov di, ax
6509  8A 85 13 13     mov al, byte ptr [di + 0x1313]
650D  30 E4           xor ah, ah
650F  50              push ax
6510  C4 7E FC        les di, ptr [bp - 4]
6513  26 8A 45 04     mov al, byte ptr es:[di + 4]
6517  30 E4           xor ah, ah
6519  50              push ax
651A  26 80 7D 04 B4  cmp byte ptr es:[di + 4], 0xb4
651F  B0 00           mov al, 0
6521  76 01           jbe 0x6524
6523  40              inc ax
loc_6524:
6524  50              push ax
6525  0E              push cs
6526  E8 1F FF        call 0x6448
6529  E9 B4 00        jmp 0x65e0
loc_652C:
652C  C4 7E FC        les di, ptr [bp - 4]
652F  26 80 7D 01 19  cmp byte ptr es:[di + 1], 0x19
6534  73 2F           jae 0x6565
6536  FF 76 06        push word ptr [bp + 6]
6539  6A 03           push 3
653B  9A 6D 07 1A 23  call far 231A:076D
6540  40              inc ax
6541  8B F8           mov di, ax
6543  8A 85 13 13     mov al, byte ptr [di + 0x1313]
6547  30 E4           xor ah, ah
6549  50              push ax
654A  C4 7E FC        les di, ptr [bp - 4]
654D  26 8A 45 04     mov al, byte ptr es:[di + 4]
6551  30 E4           xor ah, ah
6553  50              push ax
6554  26 80 7D 04 B4  cmp byte ptr es:[di + 4], 0xb4
6559  B0 00           mov al, 0
655B  76 01           jbe 0x655e
655D  40              inc ax
loc_655E:
655E  50              push ax
655F  0E              push cs
6560  E8 E5 FE        call 0x6448
6563  EB 7B           jmp 0x65e0
loc_6565:
6565  C4 7E FC        les di, ptr [bp - 4]
6568  26 8A 45 01     mov al, byte ptr es:[di + 1]
656C  26 3A 45 02     cmp al, byte ptr es:[di + 2]
6570  76 13           jbe 0x6585
6572  26 8A 45 02     mov al, byte ptr es:[di + 2]
6576  30 E4           xor ah, ah
6578  40              inc ax
6579  8B D0           mov dx, ax
657B  26 8A 45 01     mov al, byte ptr es:[di + 1]
657F  30 E4           xor ah, ah
6581  3B C2           cmp ax, dx
6583  75 2F           jne 0x65b4
loc_6585:
6585  FF 76 06        push word ptr [bp + 6]
6588  6A 02           push 2
658A  9A 6D 07 1A 23  call far 231A:076D
658F  40              inc ax
6590  8B F8           mov di, ax
6592  8A 85 13 13     mov al, byte ptr [di + 0x1313]
6596  30 E4           xor ah, ah
6598  50              push ax
6599  C4 7E FC        les di, ptr [bp - 4]
659C  26 8A 45 04     mov al, byte ptr es:[di + 4]
65A0  30 E4           xor ah, ah
65A2  50              push ax
65A3  26 80 7D 04 B4  cmp byte ptr es:[di + 4], 0xb4
65A8  B0 00           mov al, 0
65AA  76 01           jbe 0x65ad
65AC  40              inc ax
loc_65AD:
65AD  50              push ax
65AE  0E              push cs
65AF  E8 96 FE        call 0x6448
65B2  EB 2C           jmp 0x65e0
loc_65B4:
65B4  FF 76 06        push word ptr [bp + 6]
65B7  6A 04           push 4
65B9  9A 6D 07 1A 23  call far 231A:076D
65BE  8B F8           mov di, ax
65C0  8A 85 13 13     mov al, byte ptr [di + 0x1313]
65C4  30 E4           xor ah, ah
65C6  50              push ax
65C7  C4 7E FC        les di, ptr [bp - 4]
65CA  26 8A 45 04     mov al, byte ptr es:[di + 4]
65CE  30 E4           xor ah, ah
65D0  50              push ax
65D1  26 80 7D 04 B4  cmp byte ptr es:[di + 4], 0xb4
65D6  B0 00           mov al, 0
65D8  76 01           jbe 0x65db
65DA  40              inc ax
loc_65DB:
65DB  50              push ax
65DC  0E              push cs
65DD  E8 68 FE        call 0x6448
loc_65E0:
65E0  C9              leave
65E1  CA 02 00        retf 2
; data (not reached as code), 75 bytes
65E4                  pstr "You can't sell youth players"
6601                  pstr 'Sell '
6607                  pstr ' has been placed on the transfer market'

