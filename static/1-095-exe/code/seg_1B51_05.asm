; 1-095.EXE (One-Nil 95), code segment 1B51 (image offsets 1B510..2305F), part 5 of 12
; packed 1-095.EXE sha256 f659fb2d334500d6901fc8d6a0f06c85c0ccda2eb4a3035ae3bb0a0004d79192 (LZEXE 0.91)
; unpacked (tools/static/unlzexe.py) sha256 8df646e017e0965a5d90a58181ca764219ad847833aad0b6cb58fc53372bfb2c
; tool: capstone 5.0.9 (pip package; core library 5.0.1280) (CS_ARCH_X86, CS_MODE_16), recursive descent from the entry point, far calls and near calls/jumps, then routine prologues (55 89 E5 / 55 8B EC / C8 iw 00) in what remains; tools/static/listing.py
; addresses are SEGMENT:OFFSET with SEGMENT the image paragraph before relocation; image offset = SEGMENT*16+OFFSET
; ---- routine 1B51:2D19  (found by: call)
sub_2D19:
2D19  C8 08 02 00     enter 0x208, 0
2D1D  6B 46 06 5E     imul ax, word ptr [bp + 6], 0x5e
2D21  C4 3E C4 DC     les di, ptr [0xdcc4]
2D25  03 F8           add di, ax
2D27  81 C7 A2 FF     add di, 0xffa2
2D2B  89 7E FC        mov word ptr [bp - 4], di
2D2E  8C 46 FE        mov word ptr [bp - 2], es
2D31  C4 3E D2 D7     les di, ptr [0xd7d2]
2D35  8B 7E 06        mov di, word ptr [bp + 6]
2D38  80 BD B9 DC 00  cmp byte ptr [di - 0x2347], 0
2D3D  75 03           jne 0x2d42
2D3F  E9 12 01        jmp 0x2e54
loc_2D42:
2D42  9A 68 05 AC 24  call far 24AC:0568
2D47  C4 7E FC        les di, ptr [bp - 4]
2D4A  26 83 7D 02 00  cmp word ptr es:[di + 2], 0
2D4F  77 03           ja 0x2d54
2D51  E9 87 00        jmp 0x2ddb
loc_2D54:
2D54  26 FF 4D 02     dec word ptr es:[di + 2]
2D58  26 83 7D 02 00  cmp word ptr es:[di + 2], 0
2D5D  75 39           jne 0x2d98
2D5F  BF DA 32        mov di, 0x32da
2D62  1E              push ds
2D63  57              push di
2D64  55              push bp
2D65  E8 C7 FC        call 0x2a2f
2D68  8D 7E D8        lea di, [bp - 0x28]
2D6B  16              push ss
2D6C  57              push di
2D6D  6A 02           push 2
2D6F  9A 94 0D B9 26  call far 26B9:0D94
2D74  9A 95 07 1A 23  call far 231A:0795
2D79  C4 7E FC        les di, ptr [bp - 4]
2D7C  26 8A 15        mov dl, byte ptr es:[di]
2D7F  8B 7E 06        mov di, word ptr [bp + 6]
2D82  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
2D86  30 E4           xor ah, ah
2D88  8B F8           mov di, ax
2D8A  00 95 E5 D9     add byte ptr [di - 0x261b], dl
2D8E  C4 7E FC        les di, ptr [bp - 4]
2D91  31 C0           xor ax, ax
2D93  26 89 05        mov word ptr es:[di], ax
2D96  EB 41           jmp 0x2dd9
loc_2D98:
2D98  80 3E 88 DE 0D  cmp byte ptr [0xde88], 0xd
2D9D  75 3A           jne 0x2dd9
2D9F  8D BE F8 FD     lea di, [bp - 0x208]
2DA3  16              push ss
2DA4  57              push di
2DA5  BF A9 2C        mov di, 0x2ca9
2DA8  0E              push cs
2DA9  57              push di
2DAA  9A 53 0B B9 26  call far 26B9:0B53
2DAF  8D BE F8 FE     lea di, [bp - 0x108]
2DB3  16              push ss
2DB4  57              push di
2DB5  C4 7E FC        les di, ptr [bp - 4]
2DB8  26 8B 45 02     mov ax, word ptr es:[di + 2]
2DBC  31 D2           xor dx, dx
2DBE  52              push dx
2DBF  50              push ax
2DC0  9A C9 07 1A 23  call far 231A:07C9
2DC5  9A D2 0B B9 26  call far 26B9:0BD2
2DCA  BF C8 2C        mov di, 0x2cc8
2DCD  0E              push cs
2DCE  57              push di
2DCF  9A D2 0B B9 26  call far 26B9:0BD2
2DD4  9A 02 07 AC 24  call far 24AC:0702
loc_2DD9:
2DD9  EB 74           jmp 0x2e4f
loc_2DDB:
2DDB  80 3E 88 DE 0D  cmp byte ptr [0xde88], 0xd
2DE0  75 6D           jne 0x2e4f
2DE2  8B 7E 06        mov di, word ptr [bp + 6]
2DE5  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
2DE9  30 E4           xor ah, ah
2DEB  8B F8           mov di, ax
2DED  80 BD E5 D9 96  cmp byte ptr [di - 0x261b], 0x96
2DF2  B0 00           mov al, 0
2DF4  72 01           jb 0x2df7
2DF6  40              inc ax
loc_2DF7:
2DF7  50              push ax
2DF8  BF CF 2C        mov di, 0x2ccf
2DFB  0E              push cs
2DFC  57              push di
2DFD  9A 98 00 1A 23  call far 231A:0098
2E02  08 C0           or al, al
2E04  75 49           jne 0x2e4f
2E06  8B 7E 06        mov di, word ptr [bp + 6]
2E09  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
2E0D  30 E4           xor ah, ah
2E0F  50              push ax
2E10  0E              push cs
2E11  E8 9A 07        call 0x35ae
2E14  F7 D2           not dx
2E16  F7 D8           neg ax
2E18  83 DA FF        sbb dx, -1
2E1B  52              push dx
2E1C  50              push ax
2E1D  FF 76 06        push word ptr [bp + 6]
2E20  0E              push cs
2E21  E8 AF 07        call 0x35d3
2E24  2D 20 A1        sub ax, 0xa120
2E27  83 DA 07        sbb dx, 7
2E2A  59              pop cx
2E2B  5B              pop bx
2E2C  3B D3           cmp dx, bx
2E2E  7C 0A           jl 0x2e3a
2E30  7F 04           jg 0x2e36
2E32  3B C1           cmp ax, cx
2E34  76 04           jbe 0x2e3a
loc_2E36:
2E36  B0 00           mov al, 0
2E38  EB 02           jmp 0x2e3c
loc_2E3A:
2E3A  B0 01           mov al, 1
loc_2E3C:
2E3C  50              push ax
2E3D  BF FD 2C        mov di, 0x2cfd
2E40  0E              push cs
2E41  57              push di
2E42  9A 98 00 1A 23  call far 231A:0098
2E47  08 C0           or al, al
2E49  75 04           jne 0x2e4f
2E4B  55              push bp
2E4C  E8 54 FC        call 0x2aa3
loc_2E4F:
2E4F  9A 98 05 AC 24  call far 24AC:0598
loc_2E54:
2E54  C9              leave
2E55  CA 02 00        retf 2
; data (not reached as code), 2 bytes
2E58                  db 01 02   ; ..

; ---- routine 1B51:2E5A  (found by: call)
sub_2E5A:
2E5A  C8 06 01 00     enter 0x106, 0
2E5E  6B 46 08 3E     imul ax, word ptr [bp + 8], 0x3e
2E62  C4 3E C2 D7     les di, ptr [0xd7c2]
2E66  03 F8           add di, ax
2E68  81 C7 C2 FF     add di, 0xffc2
2E6C  89 7E FA        mov word ptr [bp - 6], di
2E6F  8C 46 FC        mov word ptr [bp - 4], es
2E72  BF D8 23        mov di, 0x23d8
2E75  1E              push ds
2E76  57              push di
2E77  BF 5C DD        mov di, 0xdd5c
2E7A  1E              push ds
2E7B  57              push di
2E7C  9A 2F 05 1A 23  call far 231A:052F
2E81  C7 46 FE 01 00  mov word ptr [bp - 2], 1
2E86  EB 03           jmp 0x2e8b
loc_2E88:
2E88  FF 46 FE        inc word ptr [bp - 2]
loc_2E8B:
2E8B  8B 46 FE        mov ax, word ptr [bp - 2]
2E8E  8B 7E 08        mov di, word ptr [bp + 8]
2E91  8B F7           mov si, di
2E93  D1 E7           shl di, 1
2E95  01 F7           add di, si
2E97  03 F8           add di, ax
2E99  8A 85 92 DA     mov al, byte ptr [di - 0x256e]
2E9D  50              push ax
2E9E  BF 58 2E        mov di, 0x2e58
2EA1  0E              push cs
2EA2  57              push di
2EA3  6A 06           push 6
2EA5  8B 7E FE        mov di, word ptr [bp - 2]
2EA8  8A 85 8B 10     mov al, byte ptr [di + 0x108b]
2EAC  50              push ax
2EAD  BF 5C DD        mov di, 0xdd5c
2EB0  1E              push ds
2EB1  57              push di
2EB2  9A 1B 04 1A 23  call far 231A:041B
2EB7  83 7E FE 03     cmp word ptr [bp - 2], 3
2EBB  75 CB           jne 0x2e88
2EBD  FF 76 08        push word ptr [bp + 8]
2EC0  6A 04           push 4
2EC2  6A 35           push 0x35
2EC4  0E              push cs
2EC5  E8 D3 DF        call 0xe9b
2EC8  8B 46 08        mov ax, word ptr [bp + 8]
2ECB  C4 3E B6 D7     les di, ptr [0xd7b6]
2ECF  03 F8           add di, ax
2ED1  26 8A 45 FF     mov al, byte ptr es:[di - 1]
2ED5  30 E4           xor ah, ah
2ED7  8B F8           mov di, ax
2ED9  C1 E7 04        shl di, 4
2EDC  81 C7 2C 9A     add di, 0x9a2c
2EE0  1E              push ds
2EE1  57              push di
2EE2  6A 08           push 8
2EE4  6A 35           push 0x35
2EE6  BF 5C DD        mov di, 0xdd5c
2EE9  1E              push ds
2EEA  57              push di
2EEB  9A 83 02 1A 23  call far 231A:0283
2EF0  C4 7E FA        les di, ptr [bp - 6]
2EF3  26 8A 45 37     mov al, byte ptr es:[di + 0x37]
2EF7  98              cwde
2EF8  8B F8           mov di, ax
2EFA  C1 E7 04        shl di, 4
2EFD  81 C7 E6 DC     add di, 0xdce6
2F01  1E              push ds
2F02  57              push di
2F03  6A 0A           push 0xa
2F05  6A 35           push 0x35
2F07  BF 5C DD        mov di, 0xdd5c
2F0A  1E              push ds
2F0B  57              push di
2F0C  9A 83 02 1A 23  call far 231A:0283
2F11  8D BE FA FE     lea di, [bp - 0x106]
2F15  16              push ss
2F16  57              push di
2F17  C4 7E FA        les di, ptr [bp - 6]
2F1A  26 8A 45 36     mov al, byte ptr es:[di + 0x36]
2F1E  30 E4           xor ah, ah
2F20  31 D2           xor dx, dx
2F22  52              push dx
2F23  50              push ax
2F24  9A C9 07 1A 23  call far 231A:07C9
2F29  6A 0C           push 0xc
2F2B  6A 35           push 0x35
2F2D  BF 5C DD        mov di, 0xdd5c
2F30  1E              push ds
2F31  57              push di
2F32  9A 83 02 1A 23  call far 231A:0283
2F37  8D BE FA FE     lea di, [bp - 0x106]
2F3B  16              push ss
2F3C  57              push di
2F3D  FF 76 08        push word ptr [bp + 8]
2F40  0E              push cs
2F41  E8 1C F7        call 0x2660
2F44  52              push dx
2F45  50              push ax
2F46  9A C9 07 1A 23  call far 231A:07C9
2F4B  6A 0E           push 0xe
2F4D  6A 35           push 0x35
2F4F  BF 5C DD        mov di, 0xdd5c
2F52  1E              push ds
2F53  57              push di
2F54  9A 83 02 1A 23  call far 231A:0283
2F59  6A 00           push 0
2F5B  6A 0B           push 0xb
2F5D  8B 7E 08        mov di, word ptr [bp + 8]
2F60  8A 85 35 D9     mov al, byte ptr [di - 0x26cb]
2F64  30 E4           xor ah, ah
2F66  99              cdq
2F67  B9 12 00        mov cx, 0x12
2F6A  F7 F9           idiv cx
2F6C  99              cdq
2F6D  52              push dx
2F6E  50              push ax
2F6F  9A FA 04 AC 24  call far 24AC:04FA
2F74  8B F8           mov di, ax
2F76  8A 85 EC 93     mov al, byte ptr [di - 0x6c14]
2F7A  30 E4           xor ah, ah
2F7C  8B F8           mov di, ax
2F7E  C1 E7 04        shl di, 4
2F81  81 C7 0C 8A     add di, 0x8a0c
2F85  1E              push ds
2F86  57              push di
2F87  6A 10           push 0x10
2F89  6A 35           push 0x35
2F8B  BF 5C DD        mov di, 0xdd5c
2F8E  1E              push ds
2F8F  57              push di
2F90  9A 83 02 1A 23  call far 231A:0283
2F95  8D BE FA FE     lea di, [bp - 0x106]
2F99  16              push ss
2F9A  57              push di
2F9B  C4 7E FA        les di, ptr [bp - 6]
2F9E  26 8A 45 32     mov al, byte ptr es:[di + 0x32]
2FA2  30 E4           xor ah, ah
2FA4  31 D2           xor dx, dx
2FA6  52              push dx
2FA7  50              push ax
2FA8  9A C9 07 1A 23  call far 231A:07C9
2FAD  6A 12           push 0x12
2FAF  6A 35           push 0x35
2FB1  BF 5C DD        mov di, 0xdd5c
2FB4  1E              push ds
2FB5  57              push di
2FB6  9A 83 02 1A 23  call far 231A:0283
2FBB  C4 3E D2 D7     les di, ptr [0xd7d2]
2FBF  89 7E F6        mov word ptr [bp - 0xa], di
2FC2  8C 46 F8        mov word ptr [bp - 8], es
2FC5  B0 00           mov al, 0
2FC7  08 C0           or al, al
2FC9  75 2A           jne 0x2ff5
2FCB  80 7E 06 00     cmp byte ptr [bp + 6], 0
2FCF  75 26           jne 0x2ff7
2FD1  FF 76 08        push word ptr [bp + 8]
2FD4  0E              push cs
2FD5  E8 02 DE        call 0xdda
2FD8  08 C0           or al, al
2FDA  75 1B           jne 0x2ff7
2FDC  C4 7E F6        les di, ptr [bp - 0xa]
2FDF  26 8A 45 19     mov al, byte ptr es:[di + 0x19]
2FE3  30 E4           xor ah, ah
2FE5  3B 46 08        cmp ax, word ptr [bp + 8]
2FE8  74 0D           je 0x2ff7
2FEA  26 8A 45 1A     mov al, byte ptr es:[di + 0x1a]
2FEE  30 E4           xor ah, ah
2FF0  3B 46 08        cmp ax, word ptr [bp + 8]
2FF3  74 02           je 0x2ff7
loc_2FF5:
2FF5  EB 6D           jmp 0x3064
loc_2FF7:
2FF7  BF 22 25        mov di, 0x2522
2FFA  1E              push ds
2FFB  57              push di
2FFC  BF 5C DD        mov di, 0xdd5c
2FFF  1E              push ds
3000  57              push di
3001  9A 2F 05 1A 23  call far 231A:052F
3006  C7 06 64 DD 70 00 mov word ptr [0xdd64], 0x70
300C  FF 76 08        push word ptr [bp + 8]
300F  0E              push cs
3010  E8 C7 DD        call 0xdda
3013  08 C0           or al, al
3015  74 2B           je 0x3042
3017  A0 BA DC        mov al, byte ptr [0xdcba]
301A  30 E4           xor ah, ah
301C  3B 46 08        cmp ax, word ptr [bp + 8]
301F  B0 00           mov al, 0
3021  74 01           je 0x3024
3023  40              inc ax
loc_3024:
3024  30 E4           xor ah, ah
3026  40              inc ax
3027  6B C0 5E        imul ax, ax, 0x5e
302A  C4 3E C4 DC     les di, ptr [0xdcc4]
302E  03 F8           add di, ax
3030  26 FF 75 F6     push word ptr es:[di - 0xa]
3034  26 FF 75 F4     push word ptr es:[di - 0xc]
3038  6A 14           push 0x14
303A  6A 36           push 0x36
303C  0E              push cs
303D  E8 3E DF        call 0xf7e
3040  EB 11           jmp 0x3053
loc_3042:
3042  FF 76 08        push word ptr [bp + 8]
3045  0E              push cs
3046  E8 92 04        call 0x34db
3049  52              push dx
304A  50              push ax
304B  6A 14           push 0x14
304D  6A 36           push 0x36
304F  0E              push cs
3050  E8 2B DF        call 0xf7e
loc_3053:
3053  FF 76 08        push word ptr [bp + 8]
3056  0E              push cs
3057  E8 54 05        call 0x35ae
305A  52              push dx
305B  50              push ax
305C  6A 16           push 0x16
305E  6A 36           push 0x36
3060  0E              push cs
3061  E8 1A DF        call 0xf7e
loc_3064:
3064  C9              leave
3065  CA 04 00        retf 4

; ---- routine 1B51:3068  (found by: far)
sub_3068:
3068  55              push bp
3069  89 E5           mov bp, sp
306B  C6 06 88 DE 06  mov byte ptr [0xde88], 6
3070  BF 90 0D        mov di, 0xd90
3073  1E              push ds
3074  57              push di
3075  6A 03           push 3
3077  9A C4 0E 1A 23  call far 231A:0EC4
307C  C9              leave
307D  CB              retf

; ---- routine 1B51:307E  (found by: call)
sub_307E:
307E  C8 0A 00 00     enter 0xa, 0
3082  6B 46 06 3E     imul ax, word ptr [bp + 6], 0x3e
3086  C4 3E C2 D7     les di, ptr [0xd7c2]
308A  03 F8           add di, ax
308C  81 C7 C2 FF     add di, 0xffc2
3090  89 7E FA        mov word ptr [bp - 6], di
3093  8C 46 FC        mov word ptr [bp - 4], es
3096  31 C0           xor ax, ax
3098  A3 D4 D1        mov word ptr [0xd1d4], ax
309B  31 C0           xor ax, ax
309D  A3 D6 D1        mov word ptr [0xd1d6], ax
30A0  31 C0           xor ax, ax
30A2  A3 DA D1        mov word ptr [0xd1da], ax
30A5  31 C0           xor ax, ax
30A7  A3 D8 D1        mov word ptr [0xd1d8], ax
30AA  C7 46 FE 01 00  mov word ptr [bp - 2], 1
30AF  EB 03           jmp 0x30b4
loc_30B1:
30B1  FF 46 FE        inc word ptr [bp - 2]
loc_30B4:
30B4  8B 46 FE        mov ax, word ptr [bp - 2]
30B7  D1 E0           shl ax, 1
30B9  C4 7E FA        les di, ptr [bp - 6]
30BC  03 F8           add di, ax
30BE  26 FF 75 FE     push word ptr es:[di - 2]
30C2  0E              push cs
30C3  E8 23 1E        call 0x4ee9
30C6  08 C0           or al, al
30C8  75 67           jne 0x3131
30CA  8B 46 FE        mov ax, word ptr [bp - 2]
30CD  D1 E0           shl ax, 1
30CF  C4 7E FA        les di, ptr [bp - 6]
30D2  03 F8           add di, ax
30D4  26 6B 45 FE 0F  imul ax, word ptr es:[di - 2], 0xf
30D9  C4 3E BE D7     les di, ptr [0xd7be]
30DD  03 F8           add di, ax
30DF  89 7E F6        mov word ptr [bp - 0xa], di
30E2  8C 46 F8        mov word ptr [bp - 8], es
30E5  26 8A 45 06     mov al, byte ptr es:[di + 6]
30E9  98              cwde
30EA  99              cdq
30EB  52              push dx
30EC  50              push ax
30ED  6A 00           push 0
30EF  6A 20           push 0x20
30F1  9A FA 04 AC 24  call far 24AC:04FA
30F6  01 06 D4 D1     add word ptr [0xd1d4], ax
30FA  C4 7E F6        les di, ptr [bp - 0xa]
30FD  26 80 7D 08 00  cmp byte ptr es:[di + 8], 0
3102  7E 09           jle 0x310d
3104  26 8A 45 07     mov al, byte ptr es:[di + 7]
3108  98              cwde
3109  01 06 D6 D1     add word ptr [0xd1d6], ax
loc_310D:
310D  8B 46 FE        mov ax, word ptr [bp - 2]
3110  D1 E0           shl ax, 1
3112  C4 7E FA        les di, ptr [bp - 6]
3115  03 F8           add di, ax
3117  26 FF 75 FE     push word ptr es:[di - 2]
311B  0E              push cs
311C  E8 4D 1C        call 0x4d6c
311F  30 E4           xor ah, ah
3121  01 06 DA D1     add word ptr [0xd1da], ax
3125  C4 7E F6        les di, ptr [bp - 0xa]
3128  26 8A 45 08     mov al, byte ptr es:[di + 8]
312C  98              cwde
312D  01 06 D8 D1     add word ptr [0xd1d8], ax
loc_3131:
3131  83 7E FE 0B     cmp word ptr [bp - 2], 0xb
3135  74 03           je 0x313a
3137  E9 77 FF        jmp 0x30b1
loc_313A:
313A  A1 D4 D1        mov ax, word ptr [0xd1d4]
313D  31 D2           xor dx, dx
313F  B9 0B 00        mov cx, 0xb
3142  F7 F1           div cx
3144  A3 D4 D1        mov word ptr [0xd1d4], ax
3147  A1 D6 D1        mov ax, word ptr [0xd1d6]
314A  31 D2           xor dx, dx
314C  B9 0B 00        mov cx, 0xb
314F  F7 F1           div cx
3151  A3 D6 D1        mov word ptr [0xd1d6], ax
3154  A1 DA D1        mov ax, word ptr [0xd1da]
3157  31 D2           xor dx, dx
3159  B9 0B 00        mov cx, 0xb
315C  F7 F1           div cx
315E  A3 DA D1        mov word ptr [0xd1da], ax
3161  A1 D8 D1        mov ax, word ptr [0xd1d8]
3164  31 D2           xor dx, dx
3166  B9 0B 00        mov cx, 0xb
3169  F7 F1           div cx
316B  A3 D8 D1        mov word ptr [0xd1d8], ax
316E  83 3E D4 D1 01  cmp word ptr [0xd1d4], 1
3173  73 06           jae 0x317b
3175  C7 06 D4 D1 01 00 mov word ptr [0xd1d4], 1
loc_317B:
317B  C9              leave
317C  CA 02 00        retf 2

; ---- routine 1B51:317F  (found by: call)
sub_317F:
317F  C8 0A 00 00     enter 0xa, 0
3183  FF 76 06        push word ptr [bp + 6]
3186  6A 01           push 1
3188  6A 00           push 0
318A  0E              push cs
318B  E8 BD 1E        call 0x504b
318E  C7 46 FE 01 00  mov word ptr [bp - 2], 1
3193  EB 03           jmp 0x3198
loc_3195:
3195  FF 46 FE        inc word ptr [bp - 2]
loc_3198:
3198  8B 7E FE        mov di, word ptr [bp - 2]
319B  C1 E7 02        shl di, 2
319E  8B 85 76 D6     mov ax, word ptr [di - 0x298a]
31A2  C1 E8 02        shr ax, 2
31A5  8B 7E FE        mov di, word ptr [bp - 2]
31A8  C1 E7 02        shl di, 2
31AB  89 85 76 D6     mov word ptr [di - 0x298a], ax
31AF  83 7E FE 03     cmp word ptr [bp - 2], 3
31B3  75 E0           jne 0x3195
31B5  31 C0           xor ax, ax
31B7  89 46 FE        mov word ptr [bp - 2], ax
31BA  EB 03           jmp 0x31bf
loc_31BC:
31BC  FF 46 FE        inc word ptr [bp - 2]
loc_31BF:
31BF  8B 7E FE        mov di, word ptr [bp - 2]
31C2  C1 E7 02        shl di, 2
31C5  81 BD 76 D6 00 01 cmp word ptr [di - 0x298a], 0x100
31CB  76 0C           jbe 0x31d9
31CD  8B 7E FE        mov di, word ptr [bp - 2]
31D0  C1 E7 02        shl di, 2
31D3  C7 85 76 D6 00 01 mov word ptr [di - 0x298a], 0x100
loc_31D9:
31D9  8B 46 FE        mov ax, word ptr [bp - 2]
31DC  05 09 00        add ax, 9
31DF  50              push ax
31E0  6A 27           push 0x27
31E2  8B 7E FE        mov di, word ptr [bp - 2]
31E5  C1 E7 02        shl di, 2
31E8  8B 85 76 D6     mov ax, word ptr [di - 0x298a]
31EC  C1 E8 04        shr ax, 4
31EF  50              push ax
31F0  9A 03 02 1A 23  call far 231A:0203
31F5  83 7E FE 03     cmp word ptr [bp - 2], 3
31F9  75 C1           jne 0x31bc
31FB  31 C0           xor ax, ax
31FD  89 46 FA        mov word ptr [bp - 6], ax
3200  89 46 FC        mov word ptr [bp - 4], ax
3203  C7 46 FE 01 00  mov word ptr [bp - 2], 1
3208  EB 03           jmp 0x320d
loc_320A:
320A  FF 46 FE        inc word ptr [bp - 2]
loc_320D:
320D  6B 46 06 3E     imul ax, word ptr [bp + 6], 0x3e
3211  C4 3E C2 D7     les di, ptr [0xd7c2]
3215  03 F8           add di, ax
3217  81 C7 C2 FF     add di, 0xffc2
321B  89 7E F6        mov word ptr [bp - 0xa], di
321E  8C 46 F8        mov word ptr [bp - 8], es
3221  8B 46 FE        mov ax, word ptr [bp - 2]
3224  D1 E0           shl ax, 1
3226  03 F8           add di, ax
3228  26 83 7D FE 00  cmp word ptr es:[di - 2], 0
322D  74 36           je 0x3265
322F  8B 46 FE        mov ax, word ptr [bp - 2]
3232  D1 E0           shl ax, 1
3234  C4 7E F6        les di, ptr [bp - 0xa]
3237  03 F8           add di, ax
3239  26 8B 45 FE     mov ax, word ptr es:[di - 2]
323D  C1 E0 03        shl ax, 3
3240  C4 3E BA D7     les di, ptr [0xd7ba]
3244  03 F8           add di, ax
3246  26 80 7D 01 11  cmp byte ptr es:[di + 1], 0x11
324B  76 18           jbe 0x3265
324D  8B 46 FE        mov ax, word ptr [bp - 2]
3250  D1 E0           shl ax, 1
3252  C4 7E F6        les di, ptr [bp - 0xa]
3255  03 F8           add di, ax
3257  26 FF 75 FE     push word ptr es:[di - 2]
325B  0E              push cs
325C  E8 5E 15        call 0x47bd
325F  01 46 FA        add word ptr [bp - 6], ax
3262  11 56 FC        adc word ptr [bp - 4], dx
loc_3265:
3265  83 7E FE 0B     cmp word ptr [bp - 2], 0xb
3269  75 9F           jne 0x320a
326B  C7 06 64 DD 70 00 mov word ptr [0xdd64], 0x70
3271  FF 76 FC        push word ptr [bp - 4]
3274  FF 76 FA        push word ptr [bp - 6]
3277  6A 0E           push 0xe
3279  6A 36           push 0x36
327B  0E              push cs
327C  E8 FF DC        call 0xf7e
327F  C9              leave
3280  CA 02 00        retf 2

; ---- routine 1B51:3283  (found by: call, far)
sub_3283:
3283  C8 06 01 00     enter 0x106, 0
3287  6B 46 06 3E     imul ax, word ptr [bp + 6], 0x3e
328B  C4 3E C2 D7     les di, ptr [0xd7c2]
328F  03 F8           add di, ax
3291  81 C7 C2 FF     add di, 0xffc2
3295  89 7E FA        mov word ptr [bp - 6], di
3298  8C 46 FC        mov word ptr [bp - 4], es
329B  C6 06 90 0D 03  mov byte ptr [0xd90], 3
32A0  BF 82 3B        mov di, 0x3b82
32A3  1E              push ds
32A4  57              push di
32A5  BF 5C DD        mov di, 0xdd5c
32A8  1E              push ds
32A9  57              push di
32AA  9A 2F 05 1A 23  call far 231A:052F
32AF  FF 76 06        push word ptr [bp + 6]
32B2  6A 01           push 1
32B4  6A 17           push 0x17
32B6  0E              push cs
32B7  E8 89 DB        call 0xe43
32BA  C7 46 FE 01 00  mov word ptr [bp - 2], 1
32BF  EB 03           jmp 0x32c4
loc_32C1:
32C1  FF 46 FE        inc word ptr [bp - 2]
loc_32C4:
32C4  FF 76 FE        push word ptr [bp - 2]
32C7  C4 7E FA        les di, ptr [bp - 6]
32CA  26 8A 45 39     mov al, byte ptr es:[di + 0x39]
32CE  30 E4           xor ah, ah
32D0  50              push ax
32D1  9A 59 02 AC 24  call far 24AC:0259
32D6  98              cwde
32D7  C1 E0 04        shl ax, 4
32DA  8B 7E FE        mov di, word ptr [bp - 2]
32DD  C1 E7 05        shl di, 5
32E0  03 F8           add di, ax
32E2  81 C7 E8 85     add di, 0x85e8
32E6  1E              push ds
32E7  57              push di
32E8  8B 46 FE        mov ax, word ptr [bp - 2]
32EB  05 0F 00        add ax, 0xf
32EE  50              push ax
32EF  6A 35           push 0x35
32F1  BF 5C DD        mov di, 0xdd5c
32F4  1E              push ds
32F5  57              push di
32F6  9A 83 02 1A 23  call far 231A:0283
32FB  83 7E FE 08     cmp word ptr [bp - 2], 8
32FF  75 C0           jne 0x32c1
3301  8D BE FA FE     lea di, [bp - 0x106]
3305  16              push ss
3306  57              push di
3307  FF 76 06        push word ptr [bp + 6]
330A  0E              push cs
330B  E8 01 DD        call 0x100f
330E  6A 02           push 2
3310  6A 35           push 0x35
3312  BF 5C DD        mov di, 0xdd5c
3315  1E              push ds
3316  57              push di
3317  9A 83 02 1A 23  call far 231A:0283
331C  FF 76 06        push word ptr [bp + 6]
331F  0E              push cs
3320  E8 5B FD        call 0x307e
3323  8B 3E D4 D1     mov di, word ptr [0xd1d4]
3327  8A 85 5B 93     mov al, byte ptr [di - 0x6ca5]
332B  30 E4           xor ah, ah
332D  8B F8           mov di, ax
332F  C1 E7 04        shl di, 4
3332  81 C7 0C 8A     add di, 0x8a0c
3336  1E              push ds
3337  57              push di
3338  6A 04           push 4
333A  6A 35           push 0x35
333C  BF 5C DD        mov di, 0xdd5c
333F  1E              push ds
3340  57              push di
3341  9A 83 02 1A 23  call far 231A:0283
3346  8B 3E D6 D1     mov di, word ptr [0xd1d6]
334A  8A 85 A0 93     mov al, byte ptr [di - 0x6c60]
334E  30 E4           xor ah, ah
3350  8B F8           mov di, ax
3352  C1 E7 04        shl di, 4
3355  81 C7 0C 8A     add di, 0x8a0c
3359  1E              push ds
335A  57              push di
335B  6A 05           push 5
335D  6A 35           push 0x35
335F  BF 5C DD        mov di, 0xdd5c
3362  1E              push ds
3363  57              push di
3364  9A 83 02 1A 23  call far 231A:0283
3369  8B 3E D8 D1     mov di, word ptr [0xd1d8]
336D  8A 85 C2 93     mov al, byte ptr [di - 0x6c3e]
3371  30 E4           xor ah, ah
3373  8B F8           mov di, ax
3375  C1 E7 04        shl di, 4
3378  81 C7 0C 8A     add di, 0x8a0c
337C  1E              push ds
337D  57              push di
337E  6A 06           push 6
3380  6A 35           push 0x35
3382  BF 5C DD        mov di, 0xdd5c
3385  1E              push ds
3386  57              push di
3387  9A 83 02 1A 23  call far 231A:0283
338C  8B 3E DA D1     mov di, word ptr [0xd1da]
3390  8A 85 7C 93     mov al, byte ptr [di - 0x6c84]
3394  30 E4           xor ah, ah
3396  8B F8           mov di, ax
3398  C1 E7 04        shl di, 4
339B  81 C7 0C 8A     add di, 0x8a0c
339F  1E              push ds
33A0  57              push di
33A1  6A 07           push 7
33A3  6A 35           push 0x35
33A5  BF 5C DD        mov di, 0xdd5c
33A8  1E              push ds
33A9  57              push di
33AA  9A 83 02 1A 23  call far 231A:0283
33AF  FF 76 06        push word ptr [bp + 6]
33B2  0E              push cs
33B3  E8 C9 FD        call 0x317f
33B6  C9              leave
33B7  CA 02 00        retf 2

; ---- routine 1B51:33BA  (found by: far)
sub_33BA:
33BA  55              push bp
33BB  89 E5           mov bp, sp
33BD  BF 2E 13        mov di, 0x132e
33C0  1E              push ds
33C1  57              push di
33C2  BF 5C DD        mov di, 0xdd5c
33C5  1E              push ds
33C6  57              push di
33C7  9A 2F 05 1A 23  call far 231A:052F
33CC  BF 46 63        mov di, 0x6346
33CF  1E              push ds
33D0  57              push di
33D1  BF 5C DD        mov di, 0xdd5c
33D4  1E              push ds
33D5  57              push di
33D6  9A 2F 05 1A 23  call far 231A:052F
33DB  80 3E 90 0D 01  cmp byte ptr [0xd90], 1
33E0  75 0D           jne 0x33ef
33E2  FF 76 08        push word ptr [bp + 8]
33E5  8A 46 06        mov al, byte ptr [bp + 6]
33E8  50              push ax
33E9  0E              push cs
33EA  E8 6D FA        call 0x2e5a
33ED  EB 1E           jmp 0x340d
loc_33EF:
33EF  80 3E 90 0D 02  cmp byte ptr [0xd90], 2
33F4  75 09           jne 0x33ff
33F6  FF 76 08        push word ptr [bp + 8]
33F9  0E              push cs
33FA  E8 A9 EA        call 0x1ea6
33FD  EB 0E           jmp 0x340d
loc_33FF:
33FF  80 3E 90 0D 03  cmp byte ptr [0xd90], 3
3404  75 07           jne 0x340d
3406  FF 76 08        push word ptr [bp + 8]
3409  0E              push cs
340A  E8 76 FE        call 0x3283
loc_340D:
340D  C9              leave
340E  CA 04 00        retf 4

; ---- routine 1B51:3411  (found by: call, far)
sub_3411:
3411  C8 04 00 00     enter 4, 0
3415  8B 7E 0A        mov di, word ptr [bp + 0xa]
3418  80 BD B9 DC 00  cmp byte ptr [di - 0x2347], 0
341D  74 52           je 0x3471
341F  8B 46 08        mov ax, word ptr [bp + 8]
3422  8B F0           mov si, ax
3424  D1 E0           shl ax, 1
3426  01 F0           add ax, si
3428  8B D0           mov dx, ax
342A  8B 7E 0A        mov di, word ptr [bp + 0xa]
342D  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
3431  30 E4           xor ah, ah
3433  69 C0 AE 00     imul ax, ax, 0xae
3437  C4 3E CA D7     les di, ptr [0xd7ca]
343B  03 F8           add di, ax
343D  03 FA           add di, dx
343F  26 80 BD 50 FF 00 cmp byte ptr es:[di - 0xb0], 0
3445  74 2A           je 0x3471
3447  8B 46 08        mov ax, word ptr [bp + 8]
344A  8B F0           mov si, ax
344C  D1 E0           shl ax, 1
344E  01 F0           add ax, si
3450  8B D0           mov dx, ax
3452  8B 7E 0A        mov di, word ptr [bp + 0xa]
3455  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
3459  30 E4           xor ah, ah
345B  69 C0 AE 00     imul ax, ax, 0xae
345F  C4 3E CA D7     les di, ptr [0xd7ca]
3463  03 F8           add di, ax
3465  03 FA           add di, dx
3467  26 8A 85 4F FF  mov al, byte ptr es:[di - 0xb1]
346C  3A 46 06        cmp al, byte ptr [bp + 6]
346F  74 02           je 0x3473
loc_3471:
3471  EB 64           jmp 0x34d7
loc_3473:
3473  8B 46 08        mov ax, word ptr [bp + 8]
3476  8B F0           mov si, ax
3478  D1 E0           shl ax, 1
347A  01 F0           add ax, si
347C  8B D0           mov dx, ax
347E  8B 7E 0A        mov di, word ptr [bp + 0xa]
3481  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
3485  30 E4           xor ah, ah
3487  69 C0 AE 00     imul ax, ax, 0xae
348B  C4 3E CA D7     les di, ptr [0xd7ca]
348F  03 F8           add di, ax
3491  03 FA           add di, dx
3493  26 8A 85 4F FF  mov al, byte ptr es:[di - 0xb1]
3498  98              cwde
3499  8B F8           mov di, ax
349B  D1 E7           shl di, 1
349D  8B 85 8A 10     mov ax, word ptr [di + 0x108a]
34A1  31 D2           xor dx, dx
34A3  89 46 FC        mov word ptr [bp - 4], ax
34A6  89 56 FE        mov word ptr [bp - 2], dx
34A9  8B 46 FC        mov ax, word ptr [bp - 4]
34AC  8B 56 FE        mov dx, word ptr [bp - 2]
34AF  B9 E8 03        mov cx, 0x3e8
34B2  31 DB           xor bx, bx
34B4  9A 2A 0A B9 26  call far 26B9:0A2A
34B9  89 46 FC        mov word ptr [bp - 4], ax
34BC  89 56 FE        mov word ptr [bp - 2], dx
34BF  8B 4E FC        mov cx, word ptr [bp - 4]
34C2  8B 5E FE        mov bx, word ptr [bp - 2]
34C5  6B 46 0A 5E     imul ax, word ptr [bp + 0xa], 0x5e
34C9  C4 3E C4 DC     les di, ptr [0xdcc4]
34CD  03 F8           add di, ax
34CF  26 01 4D C4     add word ptr es:[di - 0x3c], cx
34D3  26 11 5D C6     adc word ptr es:[di - 0x3a], bx
loc_34D7:
34D7  C9              leave
34D8  CA 06 00        retf 6

; ---- routine 1B51:34DB  (found by: call, far)
sub_34DB:
34DB  C8 08 00 00     enter 8, 0
34DF  6B 46 06 3E     imul ax, word ptr [bp + 6], 0x3e
34E3  C4 3E C2 D7     les di, ptr [0xd7c2]
34E7  03 F8           add di, ax
34E9  26 8B 45 F2     mov ax, word ptr es:[di - 0xe]
34ED  C1 E0 02        shl ax, 2
34F0  C4 3E C8 DC     les di, ptr [0xdcc8]
34F4  03 F8           add di, ax
34F6  26 8A 45 02     mov al, byte ptr es:[di + 2]
34FA  30 E4           xor ah, ah
34FC  31 D2           xor dx, dx
34FE  89 46 F8        mov word ptr [bp - 8], ax
3501  89 56 FA        mov word ptr [bp - 6], dx
3504  8B 46 F8        mov ax, word ptr [bp - 8]
3507  8B 56 FA        mov dx, word ptr [bp - 6]
350A  B9 02 00        mov cx, 2
350D  31 DB           xor bx, bx
350F  9A 2A 0A B9 26  call far 26B9:0A2A
3514  89 46 F8        mov word ptr [bp - 8], ax
3517  89 56 FA        mov word ptr [bp - 6], dx
351A  FF 76 06        push word ptr [bp + 6]
351D  0E              push cs
351E  E8 9A F0        call 0x25bb
3521  8B D0           mov dx, ax
3523  8B 7E 06        mov di, word ptr [bp + 6]
3526  8A 85 35 D9     mov al, byte ptr [di - 0x26cb]
352A  30 E4           xor ah, ah
352C  03 C2           add ax, dx
352E  99              cdq
352F  01 46 F8        add word ptr [bp - 8], ax
3532  11 56 FA        adc word ptr [bp - 6], dx
3535  8B 46 F8        mov ax, word ptr [bp - 8]
3538  8B 56 FA        mov dx, word ptr [bp - 6]
353B  B9 20 03        mov cx, 0x320
353E  31 DB           xor bx, bx
3540  9A 2A 0A B9 26  call far 26B9:0A2A
3545  89 46 FC        mov word ptr [bp - 4], ax
3548  89 56 FE        mov word ptr [bp - 2], dx
354B  8B 46 FC        mov ax, word ptr [bp - 4]
354E  8B 56 FE        mov dx, word ptr [bp - 2]
3551  C9              leave
3552  CA 02 00        retf 2

; ---- routine 1B51:3555  (found by: call)
sub_3555:
3555  C8 08 00 00     enter 8, 0
3559  FF 76 06        push word ptr [bp + 6]
355C  0E              push cs
355D  E8 5B F0        call 0x25bb
3560  8B D0           mov dx, ax
3562  6B 46 06 3E     imul ax, word ptr [bp + 6], 0x3e
3566  C4 3E C2 D7     les di, ptr [0xd7c2]
356A  03 F8           add di, ax
356C  26 8B 45 F2     mov ax, word ptr es:[di - 0xe]
3570  C1 E0 02        shl ax, 2
3573  C4 3E C8 DC     les di, ptr [0xdcc8]
3577  03 F8           add di, ax
3579  26 8A 45 02     mov al, byte ptr es:[di + 2]
357D  30 E4           xor ah, ah
357F  03 C2           add ax, dx
3581  99              cdq
3582  B9 02 00        mov cx, 2
3585  F7 F9           idiv cx
3587  99              cdq
3588  89 46 F8        mov word ptr [bp - 8], ax
358B  89 56 FA        mov word ptr [bp - 6], dx
358E  8B 46 F8        mov ax, word ptr [bp - 8]
3591  8B 56 FA        mov dx, word ptr [bp - 6]
3594  B9 10 27        mov cx, 0x2710
3597  31 DB           xor bx, bx
3599  9A 2A 0A B9 26  call far 26B9:0A2A
359E  89 46 FC        mov word ptr [bp - 4], ax
35A1  89 56 FE        mov word ptr [bp - 2], dx
35A4  8B 46 FC        mov ax, word ptr [bp - 4]
35A7  8B 56 FE        mov dx, word ptr [bp - 2]
35AA  C9              leave
35AB  CA 02 00        retf 2

; ---- routine 1B51:35AE  (found by: call, far)
sub_35AE:
35AE  C8 04 00 00     enter 4, 0
35B2  FF 76 06        push word ptr [bp + 6]
35B5  0E              push cs
35B6  E8 9C FF        call 0x3555
35B9  B9 02 00        mov cx, 2
35BC  31 DB           xor bx, bx
35BE  9A 2A 0A B9 26  call far 26B9:0A2A
35C3  89 46 FC        mov word ptr [bp - 4], ax
35C6  89 56 FE        mov word ptr [bp - 2], dx
35C9  8B 46 FC        mov ax, word ptr [bp - 4]
35CC  8B 56 FE        mov dx, word ptr [bp - 2]
35CF  C9              leave
35D0  CA 02 00        retf 2

; ---- routine 1B51:35D3  (found by: call)
sub_35D3:
35D3  C8 08 00 00     enter 8, 0
35D7  6B 46 06 5E     imul ax, word ptr [bp + 6], 0x5e
35DB  C4 3E C4 DC     les di, ptr [0xdcc4]
35DF  03 F8           add di, ax
35E1  81 C7 A2 FF     add di, 0xffa2
35E5  26 8B 45 52     mov ax, word ptr es:[di + 0x52]
35E9  26 8B 55 54     mov dx, word ptr es:[di + 0x54]
35ED  26 2B 45 32     sub ax, word ptr es:[di + 0x32]
35F1  26 1B 55 34     sbb dx, word ptr es:[di + 0x34]
35F5  26 2B 45 3A     sub ax, word ptr es:[di + 0x3a]
35F9  26 1B 55 3C     sbb dx, word ptr es:[di + 0x3c]
35FD  26 03 45 2A     add ax, word ptr es:[di + 0x2a]
3601  26 13 55 2C     adc dx, word ptr es:[di + 0x2c]
3605  89 46 FC        mov word ptr [bp - 4], ax
3608  89 56 FE        mov word ptr [bp - 2], dx
360B  8B 46 FC        mov ax, word ptr [bp - 4]
360E  8B 56 FE        mov dx, word ptr [bp - 2]
3611  C9              leave
3612  CA 02 00        retf 2

; ---- routine 1B51:3615  (found by: far)
sub_3615:
3615  C8 02 00 00     enter 2, 0
3619  8B 7E 06        mov di, word ptr [bp + 6]
361C  80 BD B9 DC 00  cmp byte ptr [di - 0x2347], 0
3621  74 41           je 0x3664
3623  FF 76 06        push word ptr [bp + 6]
3626  0E              push cs
3627  E8 A9 FF        call 0x35d3
362A  83 FA 00        cmp dx, 0
362D  7C 07           jl 0x3636
362F  7F 33           jg 0x3664
3631  3D 00 00        cmp ax, 0
3634  73 2E           jae 0x3664
loc_3636:
3636  8B 7E 06        mov di, word ptr [bp + 6]
3639  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
363D  30 E4           xor ah, ah
363F  50              push ax
3640  0E              push cs
3641  E8 6A FF        call 0x35ae
3644  52              push dx
3645  50              push ax
3646  FF 76 06        push word ptr [bp + 6]
3649  0E              push cs
364A  E8 86 FF        call 0x35d3
364D  09 D2           or dx, dx
364F  79 07           jns 0x3658
3651  F7 D2           not dx
3653  F7 D8           neg ax
3655  83 DA FF        sbb dx, -1
loc_3658:
3658  59              pop cx
3659  5B              pop bx
365A  3B D3           cmp dx, bx
365C  7F 0A           jg 0x3668
365E  7C 04           jl 0x3664
3660  3B C1           cmp ax, cx
3662  77 04           ja 0x3668
loc_3664:
3664  B0 00           mov al, 0
3666  EB 02           jmp 0x366a
loc_3668:
3668  B0 01           mov al, 1
loc_366A:
366A  88 46 FF        mov byte ptr [bp - 1], al
366D  8A 46 FF        mov al, byte ptr [bp - 1]
3670  C9              leave
3671  CA 02 00        retf 2

; ---- routine 1B51:3674  (found by: call)
sub_3674:
3674  C8 06 00 00     enter 6, 0
3678  C7 46 FE 01 00  mov word ptr [bp - 2], 1
367D  EB 03           jmp 0x3682
loc_367F:
367F  FF 46 FE        inc word ptr [bp - 2]
loc_3682:
3682  8B 46 FE        mov ax, word ptr [bp - 2]
3685  D1 E0           shl ax, 1
3687  C4 7E 06        les di, ptr [bp + 6]
368A  03 F8           add di, ax
368C  26 83 7D FE 00  cmp word ptr es:[di - 2], 0
3691  74 4D           je 0x36e0
3693  8B 46 FE        mov ax, word ptr [bp - 2]
3696  D1 E0           shl ax, 1
3698  C4 7E 06        les di, ptr [bp + 6]
369B  03 F8           add di, ax
369D  26 8B 45 FE     mov ax, word ptr es:[di - 2]
36A1  C1 E0 03        shl ax, 3
36A4  C4 3E BA D7     les di, ptr [0xd7ba]
36A8  03 F8           add di, ax
36AA  26 80 7D 01 11  cmp byte ptr es:[di + 1], 0x11
36AF  76 2F           jbe 0x36e0
36B1  8B 46 FE        mov ax, word ptr [bp - 2]
36B4  D1 E0           shl ax, 1
36B6  C4 7E 06        les di, ptr [bp + 6]
36B9  03 F8           add di, ax
36BB  26 6B 45 FE 0F  imul ax, word ptr es:[di - 2], 0xf
36C0  C4 3E BE D7     les di, ptr [0xd7be]
36C4  03 F8           add di, ax
36C6  26 80 7D 0C 00  cmp byte ptr es:[di + 0xc], 0
36CB  76 13           jbe 0x36e0
36CD  26 80 7D 0D 02  cmp byte ptr es:[di + 0xd], 2
36D2  74 0C           je 0x36e0
36D4  26 C6 45 0D 02  mov byte ptr es:[di + 0xd], 2
36D9  8B 7E 04        mov di, word ptr [bp + 4]
36DC  36 FF 45 FE     inc word ptr ss:[di - 2]
loc_36E0:
36E0  83 7E FE 14     cmp word ptr [bp - 2], 0x14
36E4  75 99           jne 0x367f
36E6  C9              leave
36E7  C2 06 00        ret 6

; ---- routine 1B51:36EA  (found by: far)
sub_36EA:
36EA  C8 C2 00 00     enter 0xc2, 0
36EE  31 C0           xor ax, ax
36F0  89 46 FE        mov word ptr [bp - 2], ax
36F3  8B 7E 06        mov di, word ptr [bp + 6]
36F6  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
36FA  30 E4           xor ah, ah
36FC  6B C0 3E        imul ax, ax, 0x3e
36FF  C4 3E C2 D7     les di, ptr [0xd7c2]
3703  03 F8           add di, ax
3705  81 C7 C2 FF     add di, 0xffc2
3709  06              push es
370A  57              push di
370B  55              push bp
370C  E8 65 FF        call 0x3674
370F  6B 46 06 28     imul ax, word ptr [bp + 6], 0x28
3713  C4 3E D2 D7     les di, ptr [0xd7d2]
3717  03 F8           add di, ax
3719  81 C7 30 00     add di, 0x30
371D  06              push es
371E  57              push di
371F  55              push bp
3720  E8 51 FF        call 0x3674
3723  83 7E FE 00     cmp word ptr [bp - 2], 0
3727  75 03           jne 0x372c
3729  E9 7F 00        jmp 0x37ab
loc_372C:
372C  C4 3E 58 DD     les di, ptr [0xdd58]
3730  81 C7 00 0F     add di, 0xf00
3734  06              push es
3735  57              push di
3736  8D BE 5E FF     lea di, [bp - 0xa2]
373A  16              push ss
373B  57              push di
373C  68 A0 00        push 0xa0
373F  9A C2 01 AC 24  call far 24AC:01C2
3744  BF 6A 2E        mov di, 0x2e6a
3747  1E              push ds
3748  57              push di
3749  BF 5C DD        mov di, 0xdd5c
374C  1E              push ds
374D  57              push di
374E  9A 2F 05 1A 23  call far 231A:052F
3753  8B 7E 06        mov di, word ptr [bp + 6]
3756  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
375A  30 E4           xor ah, ah
375C  50              push ax
375D  6A 19           push 0x19
375F  6A 01           push 1
3761  0E              push cs
3762  E8 DE D6        call 0xe43
3765  C4 3E 5C DD     les di, ptr [0xdd5c]
3769  81 C7 00 0F     add di, 0xf00
376D  06              push es
376E  57              push di
376F  C4 3E 58 DD     les di, ptr [0xdd58]
3773  81 C7 00 0F     add di, 0xf00
3777  06              push es
3778  57              push di
3779  68 A0 00        push 0xa0
377C  9A C2 01 AC 24  call far 24AC:01C2
3781  8D BE 3E FF     lea di, [bp - 0xc2]
3785  16              push ss
3786  57              push di
3787  6A 02           push 2
3789  9A 94 0D B9 26  call far 26B9:0D94
378E  9A 95 07 1A 23  call far 231A:0795
3793  8D BE 5E FF     lea di, [bp - 0xa2]
3797  16              push ss
3798  57              push di
3799  C4 3E 58 DD     les di, ptr [0xdd58]
379D  81 C7 00 0F     add di, 0xf00
37A1  06              push es
37A2  57              push di
37A3  68 A0 00        push 0xa0
37A6  9A C2 01 AC 24  call far 24AC:01C2
loc_37AB:
37AB  C9              leave
37AC  CA 02 00        retf 2
; data (not reached as code), 38 bytes
37AF                  pstr "Your chairman won't release the money"

