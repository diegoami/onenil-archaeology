; 1-0.EXE (One-Nil 96), code segment 0AB9 (image offsets 0AB90..1997F), part 20 of 22
; packed 1-0.EXE sha256 89ff9c5f238f24e81a0c2440a46cdd8997280a65fc3cc3d97cb974f55280a80a (LZEXE 0.91)
; unpacked (tools/static/unlzexe.py) sha256 887ed2a92767950e5309b2052409f875668605939b69e00737aa3047022b9f51
; tool: capstone 5.0.9 (pip package; core library 5.0.1280) (CS_ARCH_X86, CS_MODE_16), recursive descent from the entry point, far calls and near calls/jumps, then routine prologues (55 89 E5 / 55 8B EC / C8 iw 00) in what remains; tools/static/listing.py
; addresses are SEGMENT:OFFSET with SEGMENT the image paragraph before relocation; image offset = SEGMENT*16+OFFSET
; ---- routine 0AB9:D1DD  (found by: call)
sub_D1DD:
D1DD  55              push bp
D1DE  89 E5           mov bp, sp
D1E0  8B 7E 04        mov di, word ptr [bp + 4]
D1E3  36 8A 45 FC     mov al, byte ptr ss:[di - 4]
D1E7  3A 06 BA DC     cmp al, byte ptr [0xdcba]
D1EB  75 11           jne 0xd1fe
D1ED  C4 3E D2 D7     les di, ptr [0xd7d2]
D1F1  26 C6 45 04 01  mov byte ptr es:[di + 4], 1
D1F6  6A 01           push 1
D1F8  0E              push cs
D1F9  E8 F4 F9        call 0xcbf0
D1FC  EB 3C           jmp 0xd23a
loc_D1FE:
D1FE  8B 7E 04        mov di, word ptr [bp + 4]
D201  36 8A 45 FC     mov al, byte ptr ss:[di - 4]
D205  3A 06 BB DC     cmp al, byte ptr [0xdcbb]
D209  75 11           jne 0xd21c
D20B  C4 3E D2 D7     les di, ptr [0xd7d2]
D20F  26 C6 45 04 02  mov byte ptr es:[di + 4], 2
D214  6A 01           push 1
D216  0E              push cs
D217  E8 D6 F9        call 0xcbf0
D21A  EB 1E           jmp 0xd23a
loc_D21C:
D21C  8B 7E 04        mov di, word ptr [bp + 4]
D21F  36 8A 45 FC     mov al, byte ptr ss:[di - 4]
D223  30 E4           xor ah, ah
D225  6B C0 3E        imul ax, ax, 0x3e
D228  C4 3E C2 D7     les di, ptr [0xd7c2]
D22C  03 F8           add di, ax
D22E  81 C7 C2 FF     add di, 0xffc2
D232  06              push es
D233  57              push di
D234  6A 00           push 0
D236  0E              push cs
D237  E8 09 DB        call 0xad43
loc_D23A:
D23A  C9              leave
D23B  C2 02 00        ret 2
; data (not reached as code), 96 bytes
D23E                  pstr ' has insufficient players'
D258                  pstr ' has an ineligible player in the first team'
D284                  pstr ' has too many '
D293                  db 01 73   ; .s
D295                  pstr ' has no '

; ---- routine 0AB9:D29E  (found by: call)
sub_D29E:
D29E  C8 18 02 00     enter 0x218, 0
D2A2  8B 7E 04        mov di, word ptr [bp + 4]
D2A5  36 8A 45 FC     mov al, byte ptr ss:[di - 4]
D2A9  30 E4           xor ah, ah
D2AB  89 46 EA        mov word ptr [bp - 0x16], ax
D2AE  C6 46 ED 00     mov byte ptr [bp - 0x13], 0
D2B2  EB 03           jmp 0xd2b7
loc_D2B4:
D2B4  FE 46 ED        inc byte ptr [bp - 0x13]
loc_D2B7:
D2B7  8A 46 ED        mov al, byte ptr [bp - 0x13]
D2BA  98              cwde
D2BB  8B F8           mov di, ax
D2BD  D1 E7           shl di, 1
D2BF  FF B5 E4 D6     push word ptr [di - 0x291c]
D2C3  9A 7A 0E 55 1B  call far 1B55:0E7A
D2C8  08 C0           or al, al
D2CA  B0 00           mov al, 0
D2CC  75 01           jne 0xd2cf
D2CE  40              inc ax
loc_D2CF:
D2CF  8A D0           mov dl, al
D2D1  8A 46 ED        mov al, byte ptr [bp - 0x13]
D2D4  98              cwde
D2D5  8B F8           mov di, ax
D2D7  88 53 E8        mov byte ptr [bp + di - 0x18], dl
D2DA  80 7E ED 01     cmp byte ptr [bp - 0x13], 1
D2DE  75 D4           jne 0xd2b4
D2E0  C6 46 ED 00     mov byte ptr [bp - 0x13], 0
D2E4  EB 03           jmp 0xd2e9
loc_D2E6:
D2E6  FE 46 ED        inc byte ptr [bp - 0x13]
loc_D2E9:
D2E9  8A 46 ED        mov al, byte ptr [bp - 0x13]
D2EC  98              cwde
D2ED  8B F8           mov di, ax
D2EF  D1 E7           shl di, 1
D2F1  FF B5 E4 D6     push word ptr [di - 0x291c]
D2F5  9A 7A 0E 55 1B  call far 1B55:0E7A
D2FA  08 C0           or al, al
D2FC  75 03           jne 0xd301
D2FE  E9 9C 02        jmp 0xd59d
loc_D301:
D301  8A 46 ED        mov al, byte ptr [bp - 0x13]
D304  98              cwde
D305  8B F8           mov di, ax
D307  D1 E7           shl di, 1
D309  8A 85 E4 D6     mov al, byte ptr [di - 0x291c]
D30D  8B 7E 04        mov di, word ptr [bp + 4]
D310  36 88 45 FC     mov byte ptr ss:[di - 4], al
D314  8D 7E F0        lea di, [bp - 0x10]
D317  16              push ss
D318  57              push di
D319  6A 0F           push 0xf
D31B  6A 00           push 0
D31D  9A 22 02 BC 24  call far 24BC:0222
D322  8A 46 ED        mov al, byte ptr [bp - 0x13]
D325  98              cwde
D326  8B F8           mov di, ax
D328  C6 43 E8 01     mov byte ptr [bp + di - 0x18], 1
D32C  C7 46 EE 01 00  mov word ptr [bp - 0x12], 1
D331  EB 03           jmp 0xd336
loc_D333:
D333  FF 46 EE        inc word ptr [bp - 0x12]
loc_D336:
D336  8B 7E 04        mov di, word ptr [bp + 4]
D339  36 8A 45 FC     mov al, byte ptr ss:[di - 4]
D33D  30 E4           xor ah, ah
D33F  6B C0 3E        imul ax, ax, 0x3e
D342  C4 3E C2 D7     les di, ptr [0xd7c2]
D346  03 F8           add di, ax
D348  81 C7 C2 FF     add di, 0xffc2
D34C  89 7E E4        mov word ptr [bp - 0x1c], di
D34F  8C 46 E6        mov word ptr [bp - 0x1a], es
D352  8B 46 EE        mov ax, word ptr [bp - 0x12]
D355  D1 E0           shl ax, 1
D357  03 F8           add di, ax
D359  26 83 7D FE 00  cmp word ptr es:[di - 2], 0
D35E  75 05           jne 0xd365
D360  FE 46 FE        inc byte ptr [bp - 2]
D363  EB 39           jmp 0xd39e
loc_D365:
D365  8B 46 EE        mov ax, word ptr [bp - 0x12]
D368  D1 E0           shl ax, 1
D36A  C4 7E E4        les di, ptr [bp - 0x1c]
D36D  03 F8           add di, ax
D36F  26 FF 75 FE     push word ptr es:[di - 2]
D373  9A 89 4F 55 1B  call far 1B55:4F89
D378  08 C0           or al, al
D37A  75 22           jne 0xd39e
D37C  8B 46 EE        mov ax, word ptr [bp - 0x12]
D37F  D1 E0           shl ax, 1
D381  C4 7E E4        les di, ptr [bp - 0x1c]
D384  03 F8           add di, ax
D386  26 8B 45 FE     mov ax, word ptr es:[di - 2]
D38A  C1 E0 03        shl ax, 3
D38D  C4 3E BA D7     les di, ptr [0xd7ba]
D391  03 F8           add di, ax
D393  26 8A 45 06     mov al, byte ptr es:[di + 6]
D397  30 E4           xor ah, ah
D399  8B F8           mov di, ax
D39B  FE 43 F0        inc byte ptr [bp + di - 0x10]
loc_D39E:
D39E  80 3E 18 0D 00  cmp byte ptr [0xd18], 0
D3A3  75 21           jne 0xd3c6
D3A5  8B 46 EE        mov ax, word ptr [bp - 0x12]
D3A8  D1 E0           shl ax, 1
D3AA  C4 7E E4        les di, ptr [bp - 0x1c]
D3AD  03 F8           add di, ax
D3AF  26 FF 75 FE     push word ptr es:[di - 2]
D3B3  9A 89 4F 55 1B  call far 1B55:4F89
D3B8  08 C0           or al, al
D3BA  74 0A           je 0xd3c6
D3BC  8A 46 ED        mov al, byte ptr [bp - 0x13]
D3BF  98              cwde
D3C0  8B F8           mov di, ax
D3C2  C6 43 E8 00     mov byte ptr [bp + di - 0x18], 0
loc_D3C6:
D3C6  83 7E EE 0B     cmp word ptr [bp - 0x12], 0xb
D3CA  74 03           je 0xd3cf
D3CC  E9 64 FF        jmp 0xd333
loc_D3CF:
D3CF  8A 46 ED        mov al, byte ptr [bp - 0x13]
D3D2  98              cwde
D3D3  8B F8           mov di, ax
D3D5  80 7B E8 00     cmp byte ptr [bp + di - 0x18], 0
D3D9  74 03           je 0xd3de
D3DB  E9 89 00        jmp 0xd467
loc_D3DE:
D3DE  80 7E FE 00     cmp byte ptr [bp - 2], 0
D3E2  B0 00           mov al, 0
D3E4  74 01           je 0xd3e7
D3E6  40              inc ax
loc_D3E7:
D3E7  50              push ax
D3E8  8D BE E8 FE     lea di, [bp - 0x118]
D3EC  16              push ss
D3ED  57              push di
D3EE  8B 7E 04        mov di, word ptr [bp + 4]
D3F1  36 8A 45 FC     mov al, byte ptr ss:[di - 4]
D3F5  30 E4           xor ah, ah
D3F7  C1 E0 04        shl ax, 4
D3FA  C4 3E B2 D7     les di, ptr [0xd7b2]
D3FE  03 F8           add di, ax
D400  81 C7 F0 FF     add di, 0xfff0
D404  06              push es
D405  57              push di
D406  9A 53 0B C9 26  call far 26C9:0B53
D40B  BF 3E D2        mov di, 0xd23e
D40E  0E              push cs
D40F  57              push di
D410  9A D2 0B C9 26  call far 26C9:0BD2
D415  9A 98 00 2A 23  call far 232A:0098
D41A  08 C0           or al, al
D41C  75 46           jne 0xd464
D41E  8A 46 ED        mov al, byte ptr [bp - 0x13]
D421  98              cwde
D422  8B F8           mov di, ax
D424  80 7B E8 00     cmp byte ptr [bp + di - 0x18], 0
D428  B0 00           mov al, 0
D42A  75 01           jne 0xd42d
D42C  40              inc ax
loc_D42D:
D42D  50              push ax
D42E  8D BE E8 FD     lea di, [bp - 0x218]
D432  16              push ss
D433  57              push di
D434  8B 7E 04        mov di, word ptr [bp + 4]
D437  36 8A 45 FC     mov al, byte ptr ss:[di - 4]
D43B  30 E4           xor ah, ah
D43D  C1 E0 04        shl ax, 4
D440  C4 3E B2 D7     les di, ptr [0xd7b2]
D444  03 F8           add di, ax
D446  81 C7 F0 FF     add di, 0xfff0
D44A  06              push es
D44B  57              push di
D44C  9A 53 0B C9 26  call far 26C9:0B53
D451  BF 58 D2        mov di, 0xd258
D454  0E              push cs
D455  57              push di
D456  9A D2 0B C9 26  call far 26C9:0BD2
D45B  9A 98 00 2A 23  call far 232A:0098
D460  08 C0           or al, al
D462  74 00           je 0xd464
loc_D464:
D464  E9 AF 00        jmp 0xd516
loc_D467:
D467  80 7E F0 01     cmp byte ptr [bp - 0x10], 1
D46B  B0 00           mov al, 0
D46D  76 01           jbe 0xd470
D46F  40              inc ax
loc_D470:
D470  50              push ax
D471  8D BE E8 FE     lea di, [bp - 0x118]
D475  16              push ss
D476  57              push di
D477  8B 7E 04        mov di, word ptr [bp + 4]
D47A  36 8A 45 FC     mov al, byte ptr ss:[di - 4]
D47E  30 E4           xor ah, ah
D480  C1 E0 04        shl ax, 4
D483  C4 3E B2 D7     les di, ptr [0xd7b2]
D487  03 F8           add di, ax
D489  81 C7 F0 FF     add di, 0xfff0
D48D  06              push es
D48E  57              push di
D48F  9A 53 0B C9 26  call far 26C9:0B53
D494  BF 84 D2        mov di, 0xd284
D497  0E              push cs
D498  57              push di
D499  9A D2 0B C9 26  call far 26C9:0BD2
D49E  BF 24 87        mov di, 0x8724
D4A1  1E              push ds
D4A2  57              push di
D4A3  9A D2 0B C9 26  call far 26C9:0BD2
D4A8  BF 93 D2        mov di, 0xd293
D4AB  0E              push cs
D4AC  57              push di
D4AD  9A D2 0B C9 26  call far 26C9:0BD2
D4B2  9A 98 00 2A 23  call far 232A:0098
D4B7  08 C0           or al, al
D4B9  75 4A           jne 0xd505
D4BB  80 7E F0 00     cmp byte ptr [bp - 0x10], 0
D4BF  B0 00           mov al, 0
D4C1  75 01           jne 0xd4c4
D4C3  40              inc ax
loc_D4C4:
D4C4  50              push ax
D4C5  8D BE E8 FD     lea di, [bp - 0x218]
D4C9  16              push ss
D4CA  57              push di
D4CB  8B 7E 04        mov di, word ptr [bp + 4]
D4CE  36 8A 45 FC     mov al, byte ptr ss:[di - 4]
D4D2  30 E4           xor ah, ah
D4D4  C1 E0 04        shl ax, 4
D4D7  C4 3E B2 D7     les di, ptr [0xd7b2]
D4DB  03 F8           add di, ax
D4DD  81 C7 F0 FF     add di, 0xfff0
D4E1  06              push es
D4E2  57              push di
D4E3  9A 53 0B C9 26  call far 26C9:0B53
D4E8  BF 95 D2        mov di, 0xd295
D4EB  0E              push cs
D4EC  57              push di
D4ED  9A D2 0B C9 26  call far 26C9:0BD2
D4F2  BF 24 87        mov di, 0x8724
D4F5  1E              push ds
D4F6  57              push di
D4F7  9A D2 0B C9 26  call far 26C9:0BD2
D4FC  9A 98 00 2A 23  call far 232A:0098
D501  08 C0           or al, al
D503  74 04           je 0xd509
loc_D505:
D505  B0 00           mov al, 0
D507  EB 02           jmp 0xd50b
loc_D509:
D509  B0 01           mov al, 1
loc_D50B:
D50B  8A D0           mov dl, al
D50D  8A 46 ED        mov al, byte ptr [bp - 0x13]
D510  98              cwde
D511  8B F8           mov di, ax
D513  88 53 E8        mov byte ptr [bp + di - 0x18], dl
loc_D516:
D516  C7 46 EE 01 00  mov word ptr [bp - 0x12], 1
loc_D51B:
D51B  8A 46 ED        mov al, byte ptr [bp - 0x13]
D51E  98              cwde
D51F  8B F8           mov di, ax
D521  80 7B E8 00     cmp byte ptr [bp + di - 0x18], 0
D525  74 76           je 0xd59d
D527  83 7E EE 0D     cmp word ptr [bp - 0x12], 0xd
D52B  77 70           ja 0xd59d
D52D  8B 7E EE        mov di, word ptr [bp - 0x12]
D530  80 7B F0 03     cmp byte ptr [bp + di - 0x10], 3
D534  B0 00           mov al, 0
D536  76 01           jbe 0xd539
D538  40              inc ax
loc_D539:
D539  50              push ax
D53A  8D BE E8 FE     lea di, [bp - 0x118]
D53E  16              push ss
D53F  57              push di
D540  8B 7E 04        mov di, word ptr [bp + 4]
D543  36 8A 45 FC     mov al, byte ptr ss:[di - 4]
D547  30 E4           xor ah, ah
D549  C1 E0 04        shl ax, 4
D54C  C4 3E B2 D7     les di, ptr [0xd7b2]
D550  03 F8           add di, ax
D552  81 C7 F0 FF     add di, 0xfff0
D556  06              push es
D557  57              push di
D558  9A 53 0B C9 26  call far 26C9:0B53
D55D  BF 84 D2        mov di, 0xd284
D560  0E              push cs
D561  57              push di
D562  9A D2 0B C9 26  call far 26C9:0BD2
D567  6B 7E EE 13     imul di, word ptr [bp - 0x12], 0x13
D56B  81 C7 24 87     add di, 0x8724
D56F  1E              push ds
D570  57              push di
D571  9A D2 0B C9 26  call far 26C9:0BD2
D576  BF 93 D2        mov di, 0xd293
D579  0E              push cs
D57A  57              push di
D57B  9A D2 0B C9 26  call far 26C9:0BD2
D580  9A 98 00 2A 23  call far 232A:0098
D585  08 C0           or al, al
D587  B0 00           mov al, 0
D589  75 01           jne 0xd58c
D58B  40              inc ax
loc_D58C:
D58C  8A D0           mov dl, al
D58E  8A 46 ED        mov al, byte ptr [bp - 0x13]
D591  98              cwde
D592  8B F8           mov di, ax
D594  88 53 E8        mov byte ptr [bp + di - 0x18], dl
D597  FF 46 EE        inc word ptr [bp - 0x12]
D59A  E9 7E FF        jmp 0xd51b
loc_D59D:
D59D  80 7E ED 01     cmp byte ptr [bp - 0x13], 1
D5A1  74 03           je 0xd5a6
D5A3  E9 40 FD        jmp 0xd2e6
loc_D5A6:
D5A6  80 7E E8 00     cmp byte ptr [bp - 0x18], 0
D5AA  74 06           je 0xd5b2
D5AC  80 7E E9 00     cmp byte ptr [bp - 0x17], 0
D5B0  75 04           jne 0xd5b6
loc_D5B2:
D5B2  B0 00           mov al, 0
D5B4  EB 02           jmp 0xd5b8
loc_D5B6:
D5B6  B0 01           mov al, 1
loc_D5B8:
D5B8  88 46 FF        mov byte ptr [bp - 1], al
D5BB  8A 46 EA        mov al, byte ptr [bp - 0x16]
D5BE  8B 7E 04        mov di, word ptr [bp + 4]
D5C1  36 88 45 FC     mov byte ptr ss:[di - 4], al
D5C5  8A 46 FF        mov al, byte ptr [bp - 1]
D5C8  C9              leave
D5C9  C2 02 00        ret 2
; data (not reached as code), 10 bytes
D5CC                  pstr 'CONTINUE '

; ---- routine 0AB9:D5D6  (found by: call)
sub_D5D6:
D5D6  C8 06 01 00     enter 0x106, 0
D5DA  80 7E 04 00     cmp byte ptr [bp + 4], 0
D5DE  74 14           je 0xd5f4
D5E0  C4 3E 58 DD     les di, ptr [0xdd58]
D5E4  06              push es
D5E5  57              push di
D5E6  C4 3E 60 DD     les di, ptr [0xdd60]
D5EA  06              push es
D5EB  57              push di
D5EC  68 A0 0F        push 0xfa0
D5EF  9A 12 0A C9 26  call far 26C9:0A12
loc_D5F4:
D5F4  E8 58 40        call 0x1164f
D5F7  C6 46 FB 03     mov byte ptr [bp - 5], 3
D5FB  A0 E6 D6        mov al, byte ptr [0xd6e6]
D5FE  B4 01           mov ah, 1
D600  BA 20 00        mov dx, 0x20
D603  9A 1F 0E C9 26  call far 26C9:0E1F
D608  52              push dx
D609  50              push ax
D60A  8D 7E DA        lea di, [bp - 0x26]
D60D  16              push ss
D60E  57              push di
D60F  6A 00           push 0
D611  9A 94 0D C9 26  call far 26C9:0D94
D616  A0 BA DC        mov al, byte ptr [0xdcba]
D619  50              push ax
D61A  9A AA 0D C9 26  call far 26C9:0DAA
D61F  A0 BB DC        mov al, byte ptr [0xdcbb]
D622  50              push ax
D623  9A AA 0D C9 26  call far 26C9:0DAA
D628  5F              pop di
D629  07              pop es
D62A  58              pop ax
D62B  5A              pop dx
D62C  03 FA           add di, dx
D62E  26 84 05        test byte ptr es:[di], al
D631  74 06           je 0xd639
D633  C6 46 FE 01     mov byte ptr [bp - 2], 1
D637  EB 42           jmp 0xd67b
loc_D639:
D639  A0 E4 D6        mov al, byte ptr [0xd6e4]
D63C  B4 01           mov ah, 1
D63E  BA 20 00        mov dx, 0x20
D641  9A 1F 0E C9 26  call far 26C9:0E1F
D646  52              push dx
D647  50              push ax
D648  8D 7E BA        lea di, [bp - 0x46]
D64B  16              push ss
D64C  57              push di
D64D  6A 00           push 0
D64F  9A 94 0D C9 26  call far 26C9:0D94
D654  A0 BA DC        mov al, byte ptr [0xdcba]
D657  50              push ax
D658  9A AA 0D C9 26  call far 26C9:0DAA
D65D  A0 BB DC        mov al, byte ptr [0xdcbb]
D660  50              push ax
D661  9A AA 0D C9 26  call far 26C9:0DAA
D666  5F              pop di
D667  07              pop es
D668  58              pop ax
D669  5A              pop dx
D66A  03 FA           add di, dx
D66C  26 84 05        test byte ptr es:[di], al
D66F  74 06           je 0xd677
D671  C6 46 FE 00     mov byte ptr [bp - 2], 0
D675  EB 04           jmp 0xd67b
loc_D677:
D677  C6 46 FE 01     mov byte ptr [bp - 2], 1
loc_D67B:
D67B  8A 46 FE        mov al, byte ptr [bp - 2]
D67E  98              cwde
D67F  8B F8           mov di, ax
D681  D1 E7           shl di, 1
D683  8A 85 E4 D6     mov al, byte ptr [di - 0x291c]
D687  88 46 FC        mov byte ptr [bp - 4], al
D68A  80 3E 18 0D 00  cmp byte ptr [0xd18], 0
D68F  74 16           je 0xd6a7
D691  C4 3E 96 D0     les di, ptr [0xd096]
D695  06              push es
D696  57              push di
D697  C4 3E 8E D0     les di, ptr [0xd08e]
D69B  06              push es
D69C  57              push di
D69D  68 A0 0F        push 0xfa0
D6A0  9A 12 0A C9 26  call far 26C9:0A12
D6A5  EB 14           jmp 0xd6bb
loc_D6A7:
D6A7  C4 3E 92 D0     les di, ptr [0xd092]
D6AB  06              push es
D6AC  57              push di
D6AD  C4 3E 8E D0     les di, ptr [0xd08e]
D6B1  06              push es
D6B2  57              push di
D6B3  68 A0 0F        push 0xfa0
D6B6  9A 12 0A C9 26  call far 26C9:0A12
loc_D6BB:
D6BB  8A 46 FC        mov al, byte ptr [bp - 4]
D6BE  30 E4           xor ah, ah
D6C0  50              push ax
D6C1  6A 00           push 0
D6C3  0E              push cs
D6C4  E8 3B C0        call 0x9702
D6C7  BF 2E 13        mov di, 0x132e
D6CA  1E              push ds
D6CB  57              push di
D6CC  BF 5C DD        mov di, 0xdd5c
D6CF  1E              push ds
D6D0  57              push di
D6D1  9A 2F 05 2A 23  call far 232A:052F
D6D6  BF CC 25        mov di, 0x25cc
D6D9  1E              push ds
D6DA  57              push di
D6DB  BF 5C DD        mov di, 0xdd5c
D6DE  1E              push ds
D6DF  57              push di
D6E0  9A 2F 05 2A 23  call far 232A:052F
D6E5  C6 46 FD 00     mov byte ptr [bp - 3], 0
D6E9  EB 03           jmp 0xd6ee
loc_D6EB:
D6EB  FE 46 FD        inc byte ptr [bp - 3]
loc_D6EE:
D6EE  8A 46 FD        mov al, byte ptr [bp - 3]
D6F1  98              cwde
D6F2  8B F8           mov di, ax
D6F4  D1 E7           shl di, 1
D6F6  FF B5 E4 D6     push word ptr [di - 0x291c]
D6FA  8A 46 FD        mov al, byte ptr [bp - 3]
D6FD  98              cwde
D6FE  8B F8           mov di, ax
D700  8A 85 DC 0C     mov al, byte ptr [di + 0xcdc]
D704  30 E4           xor ah, ah
D706  50              push ax
D707  6A 03           push 3
D709  9A E3 0E 55 1B  call far 1B55:0EE3
D70E  80 7E FD 01     cmp byte ptr [bp - 3], 1
D712  75 D7           jne 0xd6eb
D714  8A 46 FC        mov al, byte ptr [bp - 4]
D717  30 E4           xor ah, ah
D719  50              push ax
D71A  6A 01           push 1
D71C  6A 01           push 1
D71E  9A E3 0E 55 1B  call far 1B55:0EE3
D723  6A 07           push 7
D725  8D BE FA FE     lea di, [bp - 0x106]
D729  16              push ss
D72A  57              push di
D72B  C4 3E D2 D7     les di, ptr [0xd7d2]
D72F  26 8A 05        mov al, byte ptr es:[di]
D732  30 E4           xor ah, ah
D734  8B F0           mov si, ax
D736  D1 E0           shl ax, 1
D738  01 F0           add ax, si
D73A  8B D0           mov dx, ax
D73C  69 06 E6 D6 AE 00 imul ax, word ptr [0xd6e6], 0xae
D742  C4 3E CA D7     les di, ptr [0xd7ca]
D746  03 F8           add di, ax
D748  03 FA           add di, dx
D74A  26 8A 85 4F FF  mov al, byte ptr es:[di - 0xb1]
D74F  50              push ax
D750  C4 3E D2 D7     les di, ptr [0xd7d2]
D754  26 8A 05        mov al, byte ptr es:[di]
D757  50              push ax
D758  9A 2B 14 55 1B  call far 1B55:142B
D75D  6A 03           push 3
D75F  6A 02           push 2
D761  BF 5C DD        mov di, 0xdd5c
D764  1E              push ds
D765  57              push di
D766  9A 1B 04 2A 23  call far 232A:041B
D76B  8D BE FA FE     lea di, [bp - 0x106]
D76F  16              push ss
D770  57              push di
D771  8A 46 FE        mov al, byte ptr [bp - 2]
D774  50              push ax
D775  9A 59 47 55 1B  call far 1B55:4759
D77A  31 D2           xor dx, dx
D77C  52              push dx
D77D  50              push ax
D77E  9A C9 07 2A 23  call far 232A:07C9
D783  6A 0A           push 0xa
D785  6A 12           push 0x12
D787  BF 5C DD        mov di, 0xdd5c
D78A  1E              push ds
D78B  57              push di
D78C  9A 83 02 2A 23  call far 232A:0283
D791  80 7E FE 00     cmp byte ptr [bp - 2], 0
D795  B0 00           mov al, 0
D797  75 01           jne 0xd79a
D799  40              inc ax
loc_D79A:
D79A  98              cwde
D79B  8B F8           mov di, ax
D79D  D1 E7           shl di, 1
D79F  FF B5 E4 D6     push word ptr [di - 0x291c]
D7A3  A0 D8 0C        mov al, byte ptr [0xcd8]
D7A6  30 E4           xor ah, ah
D7A8  50              push ax
D7A9  6A 03           push 3
D7AB  9A E3 0E 55 1B  call far 1B55:0EE3
D7B0  8A 46 FC        mov al, byte ptr [bp - 4]
D7B3  30 E4           xor ah, ah
D7B5  50              push ax
D7B6  9A 7A 0E 55 1B  call far 1B55:0E7A
D7BB  08 C0           or al, al
D7BD  74 1E           je 0xd7dd
D7BF  A0 DB 0C        mov al, byte ptr [0xcdb]
D7C2  30 E4           xor ah, ah
D7C4  69 C0 A0 00     imul ax, ax, 0xa0
D7C8  C4 3E 5C DD     les di, ptr [0xdd5c]
D7CC  03 F8           add di, ax
D7CE  81 C7 62 FF     add di, 0xff62
D7D2  06              push es
D7D3  57              push di
D7D4  6A 0C           push 0xc
D7D6  6A 11           push 0x11
D7D8  9A 4B 03 BC 24  call far 24BC:034B
loc_D7DD:
D7DD  80 3E 56 DD 00  cmp byte ptr [0xdd56], 0
D7E2  74 15           je 0xd7f9
D7E4  6A 0E           push 0xe
D7E6  BF CC D5        mov di, 0xd5cc
D7E9  0E              push cs
D7EA  57              push di
D7EB  6A 11           push 0x11
D7ED  6A 03           push 3
D7EF  BF 5C DD        mov di, 0xdd5c
D7F2  1E              push ds
D7F3  57              push di
D7F4  9A 1B 04 2A 23  call far 232A:041B
loc_D7F9:
D7F9  8A 46 FB        mov al, byte ptr [bp - 5]
D7FC  30 E4           xor ah, ah
D7FE  8B F8           mov di, ax
D800  8A 85 D7 0C     mov al, byte ptr [di + 0xcd7]
D804  30 E4           xor ah, ah
D806  50              push ax
D807  6A 02           push 2
D809  6A 11           push 0x11
D80B  9A 03 02 2A 23  call far 232A:0203
D810  8D 7E FB        lea di, [bp - 5]
D813  16              push ss
D814  57              push di
D815  6A 04           push 4
D817  9A 8B 0F 2A 23  call far 232A:0F8B
D81C  80 3E 88 DE 01  cmp byte ptr [0xde88], 1
D821  75 07           jne 0xd82a
D823  80 3E 18 0D 00  cmp byte ptr [0xd18], 0
D828  75 04           jne 0xd82e
loc_D82A:
D82A  B0 00           mov al, 0
D82C  EB 02           jmp 0xd830
loc_D82E:
D82E  B0 01           mov al, 1
loc_D830:
D830  88 46 FF        mov byte ptr [bp - 1], al
D833  80 3E 88 DE 0D  cmp byte ptr [0xde88], 0xd
D838  75 08           jne 0xd842
D83A  9A 08 31 55 1B  call far 1B55:3108
D83F  E9 87 00        jmp 0xd8c9
loc_D842:
D842  A0 88 DE        mov al, byte ptr [0xde88]
D845  50              push ax
D846  9A 86 19 C9 26  call far 26C9:1986
D84B  3C 54           cmp al, 0x54
D84D  75 1B           jne 0xd86a
D84F  8A 46 FC        mov al, byte ptr [bp - 4]
D852  30 E4           xor ah, ah
D854  50              push ax
D855  9A 7A 0E 55 1B  call far 1B55:0E7A
D85A  08 C0           or al, al
D85C  74 0C           je 0xd86a
D85E  8A 46 FC        mov al, byte ptr [bp - 4]
D861  30 E4           xor ah, ah
D863  50              push ax
D864  0E              push cs
D865  E8 07 BE        call 0x966f
D868  EB 5F           jmp 0xd8c9
loc_D86A:
D86A  80 3E 88 DE 20  cmp byte ptr [0xde88], 0x20
D86F  75 06           jne 0xd877
D871  55              push bp
D872  E8 68 F9        call 0xd1dd
D875  EB 52           jmp 0xd8c9
loc_D877:
D877  80 3E 88 DE 02  cmp byte ptr [0xde88], 2
D87C  75 4B           jne 0xd8c9
D87E  8A 46 FB        mov al, byte ptr [bp - 5]
D881  3C 01           cmp al, 1
D883  75 0E           jne 0xd893
D885  80 7E FE 00     cmp byte ptr [bp - 2], 0
D889  B0 00           mov al, 0
D88B  75 01           jne 0xd88e
D88D  40              inc ax
loc_D88E:
D88E  88 46 FE        mov byte ptr [bp - 2], al
D891  EB 36           jmp 0xd8c9
loc_D893:
D893  3C 02           cmp al, 2
D895  75 0B           jne 0xd8a2
D897  6A 01           push 1
D899  6A 00           push 0
D89B  9A 5C 04 98 19  call far 1998:045C
D8A0  EB 27           jmp 0xd8c9
loc_D8A2:
D8A2  3C 03           cmp al, 3
D8A4  75 06           jne 0xd8ac
D8A6  C6 46 FF 01     mov byte ptr [bp - 1], 1
D8AA  EB 1D           jmp 0xd8c9
loc_D8AC:
D8AC  3C 04           cmp al, 4
D8AE  75 19           jne 0xd8c9
D8B0  8A 46 FC        mov al, byte ptr [bp - 4]
D8B3  30 E4           xor ah, ah
D8B5  50              push ax
D8B6  9A 7A 0E 55 1B  call far 1B55:0E7A
D8BB  08 C0           or al, al
D8BD  74 0A           je 0xd8c9
D8BF  8A 46 FC        mov al, byte ptr [bp - 4]
D8C2  30 E4           xor ah, ah
D8C4  50              push ax
D8C5  0E              push cs
D8C6  E8 A6 BD        call 0x966f
loc_D8C9:
D8C9  80 7E FF 00     cmp byte ptr [bp - 1], 0
D8CD  75 03           jne 0xd8d2
D8CF  E9 A9 FD        jmp 0xd67b
loc_D8D2:
D8D2  55              push bp
D8D3  E8 C8 F9        call 0xd29e
D8D6  08 C0           or al, al
D8D8  75 03           jne 0xd8dd
D8DA  E9 9E FD        jmp 0xd67b
loc_D8DD:
D8DD  80 3E 18 0D 00  cmp byte ptr [0xd18], 0
D8E2  74 14           je 0xd8f8
D8E4  C4 3E 60 DD     les di, ptr [0xdd60]
D8E8  06              push es
D8E9  57              push di
D8EA  C4 3E 58 DD     les di, ptr [0xdd58]
D8EE  06              push es
D8EF  57              push di
D8F0  68 A0 0F        push 0xfa0
D8F3  9A 12 0A C9 26  call far 26C9:0A12
loc_D8F8:
D8F8  C6 06 18 0D 01  mov byte ptr [0xd18], 1
D8FD  E8 4F 3D        call 0x1164f
D900  C9              leave
D901  C2 02 00        ret 2

; ---- routine 0AB9:D904  (found by: call)
sub_D904:
D904  C8 06 00 00     enter 6, 0
D908  8B 46 04        mov ax, word ptr [bp + 4]
D90B  8B F0           mov si, ax
D90D  D1 E0           shl ax, 1
D90F  01 F0           add ax, si
D911  8B D0           mov dx, ax
D913  69 46 06 AE 00  imul ax, word ptr [bp + 6], 0xae
D918  C4 3E CA D7     les di, ptr [0xd7ca]
D91C  03 F8           add di, ax
D91E  03 FA           add di, dx
D920  81 C7 4F FF     add di, 0xff4f
D924  89 7E FA        mov word ptr [bp - 6], di
D927  8C 46 FC        mov word ptr [bp - 4], es
D92A  C6 46 FF 00     mov byte ptr [bp - 1], 0
D92E  26 80 3D 03     cmp byte ptr es:[di], 3
D932  74 21           je 0xd955
D934  26 80 3D 04     cmp byte ptr es:[di], 4
D938  74 1B           je 0xd955
D93A  26 80 3D 06     cmp byte ptr es:[di], 6
D93E  75 06           jne 0xd946
D940  83 7E 04 39     cmp word ptr [bp + 4], 0x39
D944  74 0F           je 0xd955
loc_D946:
D946  C4 7E FA        les di, ptr [bp - 6]
D949  26 80 3D 07     cmp byte ptr es:[di], 7
D94D  75 16           jne 0xd965
D94F  83 7E 04 30     cmp word ptr [bp + 4], 0x30
D953  75 10           jne 0xd965
loc_D955:
D955  FF 76 06        push word ptr [bp + 6]
D958  FF 76 04        push word ptr [bp + 4]
D95B  9A C2 17 55 1B  call far 1B55:17C2
D960  88 46 FF        mov byte ptr [bp - 1], al
D963  EB 17           jmp 0xd97c
loc_D965:
D965  FF 76 06        push word ptr [bp + 6]
D968  FF 76 04        push word ptr [bp + 4]
D96B  9A 2B 02 98 19  call far 1998:022B
D970  50              push ax
D971  FF 76 04        push word ptr [bp + 4]
D974  9A 1C 1A 55 1B  call far 1B55:1A1C
D979  88 46 FF        mov byte ptr [bp - 1], al
loc_D97C:
D97C  8A 46 FF        mov al, byte ptr [bp - 1]
D97F  C9              leave
D980  C2 04 00        ret 4

; ---- routine 0AB9:D983  (found by: call)
sub_D983:
D983  C8 08 00 00     enter 8, 0
D987  8B 46 04        mov ax, word ptr [bp + 4]
D98A  89 46 F8        mov word ptr [bp - 8], ax
D98D  B8 01 00        mov ax, 1
D990  3B 46 F8        cmp ax, word ptr [bp - 8]
D993  76 03           jbe 0xd998
D995  E9 A5 00        jmp 0xda3d
loc_D998:
D998  89 46 FC        mov word ptr [bp - 4], ax
D99B  EB 03           jmp 0xd9a0
loc_D99D:
D99D  FF 46 FC        inc word ptr [bp - 4]
loc_D9A0:
D9A0  31 C0           xor ax, ax
D9A2  89 46 FE        mov word ptr [bp - 2], ax
D9A5  EB 03           jmp 0xd9aa
loc_D9A7:
D9A7  FF 46 FE        inc word ptr [bp - 2]
loc_D9AA:
D9AA  8B 46 FE        mov ax, word ptr [bp - 2]
D9AD  35 01 00        xor ax, 1
D9B0  8B F8           mov di, ax
D9B2  D1 E7           shl di, 1
D9B4  FF B5 7C D6     push word ptr [di - 0x2984]
D9B8  9A 6D 07 2A 23  call far 232A:076D
D9BD  50              push ax
D9BE  8B 7E FE        mov di, word ptr [bp - 2]
D9C1  D1 E7           shl di, 1
D9C3  FF B5 7C D6     push word ptr [di - 0x2984]
D9C7  9A 6D 07 2A 23  call far 232A:076D
D9CC  5A              pop dx
D9CD  3B C2           cmp ax, dx
D9CF  7E 58           jle 0xda29
D9D1  8B 46 FE        mov ax, word ptr [bp - 2]
D9D4  35 01 00        xor ax, 1
D9D7  8B F8           mov di, ax
D9D9  D1 E7           shl di, 1
D9DB  FF B5 78 D6     push word ptr [di - 0x2988]
D9DF  9A 6D 07 2A 23  call far 232A:076D
D9E4  50              push ax
D9E5  8B 7E FE        mov di, word ptr [bp - 2]
D9E8  D1 E7           shl di, 1
D9EA  FF B5 80 D6     push word ptr [di - 0x2980]
D9EE  9A 6D 07 2A 23  call far 232A:076D
D9F3  5A              pop dx
D9F4  3B C2           cmp ax, dx
D9F6  7E 31           jle 0xda29
D9F8  8B 46 FE        mov ax, word ptr [bp - 2]
D9FB  35 01 00        xor ax, 1
D9FE  8B F8           mov di, ax
DA00  D1 E7           shl di, 1
DA02  FF B5 74 D6     push word ptr [di - 0x298c]
DA06  9A 6D 07 2A 23  call far 232A:076D
DA0B  50              push ax
DA0C  8B 7E FE        mov di, word ptr [bp - 2]
DA0F  D1 E7           shl di, 1
DA11  FF B5 80 D6     push word ptr [di - 0x2980]
DA15  9A 6D 07 2A 23  call far 232A:076D
DA1A  5A              pop dx
DA1B  3B C2           cmp ax, dx
DA1D  7E 0A           jle 0xda29
DA1F  8B 46 FE        mov ax, word ptr [bp - 2]
DA22  40              inc ax
DA23  8B F8           mov di, ax
DA25  FE 85 85 D0     inc byte ptr [di - 0x2f7b]
loc_DA29:
DA29  83 7E FE 01     cmp word ptr [bp - 2], 1
DA2D  74 03           je 0xda32
DA2F  E9 75 FF        jmp 0xd9a7
loc_DA32:
DA32  8B 46 FC        mov ax, word ptr [bp - 4]
DA35  3B 46 F8        cmp ax, word ptr [bp - 8]
DA38  74 03           je 0xda3d
DA3A  E9 60 FF        jmp 0xd99d
loc_DA3D:
DA3D  C9              leave
DA3E  C2 02 00        ret 2

; ---- routine 0AB9:DA41  (found by: call)
sub_DA41:
DA41  C8 02 02 00     enter 0x202, 0
DA45  BF E2 63        mov di, 0x63e2
DA48  1E              push ds
DA49  57              push di
DA4A  BF 5C DD        mov di, 0xdd5c
DA4D  1E              push ds
DA4E  57              push di
DA4F  9A 2F 05 2A 23  call far 232A:052F
DA54  BF B4 66        mov di, 0x66b4
DA57  1E              push ds
DA58  57              push di
DA59  BF 5C DD        mov di, 0xdd5c
DA5C  1E              push ds
DA5D  57              push di
DA5E  9A 2F 05 2A 23  call far 232A:052F
DA63  BF DE 19        mov di, 0x19de
DA66  1E              push ds
DA67  57              push di
DA68  BF 5C DD        mov di, 0xdd5c
DA6B  1E              push ds
DA6C  57              push di
DA6D  9A 2F 05 2A 23  call far 232A:052F
DA72  C6 46 FF 00     mov byte ptr [bp - 1], 0
DA76  EB 03           jmp 0xda7b
loc_DA78:
DA78  FE 46 FF        inc byte ptr [bp - 1]
loc_DA7B:
DA7B  8A 46 FF        mov al, byte ptr [bp - 1]
DA7E  98              cwde
DA7F  8B F8           mov di, ax
DA81  8A 85 C8 D0     mov al, byte ptr [di - 0x2f38]
DA85  50              push ax
DA86  8D BE FE FE     lea di, [bp - 0x102]
DA8A  16              push ss
DA8B  57              push di
DA8C  8A 46 FF        mov al, byte ptr [bp - 1]
DA8F  98              cwde
DA90  8B F8           mov di, ax
DA92  D1 E7           shl di, 1
DA94  8B 85 E4 D6     mov ax, word ptr [di - 0x291c]
DA98  C1 E0 04        shl ax, 4
DA9B  C4 3E B2 D7     les di, ptr [0xd7b2]
DA9F  03 F8           add di, ax
DAA1  81 C7 F0 FF     add di, 0xfff0
DAA5  06              push es
DAA6  57              push di
DAA7  9A 5A 00 BC 24  call far 24BC:005A
DAAC  8A 46 FF        mov al, byte ptr [bp - 1]
DAAF  98              cwde
DAB0  8B F8           mov di, ax
DAB2  8A 85 DE 0C     mov al, byte ptr [di + 0xcde]
DAB6  50              push ax
DAB7  6A 02           push 2
DAB9  BF 5C DD        mov di, 0xdd5c
DABC  1E              push ds
DABD  57              push di
DABE  9A 1B 04 2A 23  call far 232A:041B
DAC3  80 7E FF 01     cmp byte ptr [bp - 1], 1
DAC7  75 AF           jne 0xda78
DAC9  6A 05           push 5
DACB  8D BE FE FD     lea di, [bp - 0x202]
DACF  16              push ss
DAD0  57              push di
DAD1  8D BE FE FE     lea di, [bp - 0x102]
DAD5  16              push ss
DAD6  57              push di
DAD7  C4 3E D2 D7     les di, ptr [0xd7d2]
DADB  26 8A 05        mov al, byte ptr es:[di]
DADE  30 E4           xor ah, ah
DAE0  8B F0           mov si, ax
DAE2  D1 E0           shl ax, 1
DAE4  01 F0           add ax, si
DAE6  8B D0           mov dx, ax
DAE8  69 06 E6 D6 AE 00 imul ax, word ptr [0xd6e6], 0xae
DAEE  C4 3E CA D7     les di, ptr [0xd7ca]
DAF2  03 F8           add di, ax
DAF4  03 FA           add di, dx
DAF6  26 8A 85 4F FF  mov al, byte ptr es:[di - 0xb1]
DAFB  50              push ax
DAFC  C4 3E D2 D7     les di, ptr [0xd7d2]
DB00  26 8A 05        mov al, byte ptr es:[di]
DB03  50              push ax
DB04  9A 2B 14 55 1B  call far 1B55:142B
DB09  9A 5A 00 BC 24  call far 24BC:005A
DB0E  6A 01           push 1
DB10  6A 2A           push 0x2a
DB12  BF 5C DD        mov di, 0xdd5c
DB15  1E              push ds
DB16  57              push di
DB17  9A 1B 04 2A 23  call far 232A:041B
DB1C  BF 5C DD        mov di, 0xdd5c
DB1F  1E              push ds
DB20  57              push di
DB21  9A DF 02 98 19  call far 1998:02DF
DB26  6A 06           push 6
DB28  8D BE FE FE     lea di, [bp - 0x102]
DB2C  16              push ss
DB2D  57              push di
DB2E  FF 36 EA D6     push word ptr [0xd6ea]
DB32  FF 36 E8 D6     push word ptr [0xd6e8]
DB36  9A C9 07 2A 23  call far 232A:07C9
DB3B  6A 03           push 3
DB3D  6A 1B           push 0x1b
DB3F  BF 5C DD        mov di, 0xdd5c
DB42  1E              push ds
DB43  57              push di
DB44  9A 0C 03 2A 23  call far 232A:030C
DB49  C4 3E 5C DD     les di, ptr [0xdd5c]
DB4D  06              push es
DB4E  57              push di
DB4F  C4 3E 92 D0     les di, ptr [0xd092]
DB53  06              push es
DB54  57              push di
DB55  68 A0 0F        push 0xfa0
DB58  9A C2 01 BC 24  call far 24BC:01C2
DB5D  C9              leave
DB5E  C3              ret
; data (not reached as code), 9 bytes
DB5F                  pstr 'HANG ON '

; ---- routine 0AB9:DB68  (found by: call)
sub_DB68:
DB68  55              push bp
DB69  89 E5           mov bp, sp
DB6B  80 3E 74 D0 00  cmp byte ptr [0xd074], 0
DB70  75 0E           jne 0xdb80
DB72  83 3E AE D0 00  cmp word ptr [0xd0ae], 0
DB77  74 07           je 0xdb80
DB79  80 3E B9 D0 00  cmp byte ptr [0xd0b9], 0
DB7E  74 02           je 0xdb82
loc_DB80:
DB80  EB 42           jmp 0xdbc4
loc_DB82:
DB82  80 3E B8 D0 00  cmp byte ptr [0xd0b8], 0
DB87  75 23           jne 0xdbac
DB89  80 3E CC D1 00  cmp byte ptr [0xd1cc], 0
DB8E  75 15           jne 0xdba5
DB90  6A 0E           push 0xe
DB92  BF 5F DB        mov di, 0xdb5f
DB95  0E              push cs
DB96  57              push di
DB97  6A 19           push 0x19
DB99  6A 1E           push 0x1e
DB9B  BF 58 DD        mov di, 0xdd58
DB9E  1E              push ds
DB9F  57              push di
DBA0  9A 1B 04 2A 23  call far 232A:041B
loc_DBA5:
DBA5  C6 06 CC D1 01  mov byte ptr [0xd1cc], 1
DBAA  EB 18           jmp 0xdbc4
loc_DBAC:
DBAC  C6 06 74 D0 01  mov byte ptr [0xd074], 1
DBB1  C6 06 75 D0 01  mov byte ptr [0xd075], 1
DBB6  C6 06 CC D1 00  mov byte ptr [0xd1cc], 0
DBBB  6A 00           push 0
DBBD  6A 01           push 1
DBBF  9A 5C 04 98 19  call far 1998:045C
loc_DBC4:
DBC4  C9              leave
DBC5  C3              ret

; ---- routine 0AB9:DBC6  (found by: call)
sub_DBC6:
DBC6  C8 0A 00 00     enter 0xa, 0
DBCA  6A 0A           push 0xa
DBCC  9A 6D 07 2A 23  call far 232A:076D
DBD1  40              inc ax
DBD2  89 46 FC        mov word ptr [bp - 4], ax
DBD5  8B 7E FC        mov di, word ptr [bp - 4]
DBD8  8A 85 00 0D     mov al, byte ptr [di + 0xd00]
DBDC  30 E4           xor ah, ah
DBDE  89 46 FA        mov word ptr [bp - 6], ax
DBE1  C6 46 FF 00     mov byte ptr [bp - 1], 0
DBE5  EB 03           jmp 0xdbea
loc_DBE7:
DBE7  FE 46 FF        inc byte ptr [bp - 1]
loc_DBEA:
DBEA  8A 46 FF        mov al, byte ptr [bp - 1]
DBED  98              cwde
DBEE  8B F8           mov di, ax
DBF0  8A 85 56 0D     mov al, byte ptr [di + 0xd56]
DBF4  30 E4           xor ah, ah
DBF6  8B D0           mov dx, ax
DBF8  8A 46 FF        mov al, byte ptr [bp - 1]
DBFB  98              cwde
DBFC  8B F8           mov di, ax
DBFE  D1 E7           shl di, 1
DC00  01 53 FA        add word ptr [bp + di - 6], dx
DC03  80 7E FF 01     cmp byte ptr [bp - 1], 1
DC07  75 DE           jne 0xdbe7
DC09  6B 7E FC 19     imul di, word ptr [bp - 4], 0x19
DC0D  81 C7 EF CC     add di, 0xccef
DC11  1E              push ds
DC12  57              push di
DC13  0E              push cs
DC14  E8 8A 40        call 0x11ca1
DC17  08 C0           or al, al
DC19  74 03           je 0xdc1e
DC1B  E9 E0 00        jmp 0xdcfe
loc_DC1E:
DC1E  6B 7E FA 19     imul di, word ptr [bp - 6], 0x19
DC22  81 C7 EF CC     add di, 0xccef
DC26  1E              push ds
DC27  57              push di
DC28  0E              push cs
DC29  E8 75 40        call 0x11ca1
DC2C  08 C0           or al, al
DC2E  74 03           je 0xdc33
DC30  E9 CB 00        jmp 0xdcfe
loc_DC33:
DC33  9A 3F 0D BC 24  call far 24BC:0D3F
DC38  88 46 FF        mov byte ptr [bp - 1], al
DC3B  8A 46 FF        mov al, byte ptr [bp - 1]
DC3E  98              cwde
DC3F  8B F8           mov di, ax
DC41  D1 E7           shl di, 1
DC43  6B 7B FA 19     imul di, word ptr [bp + di - 6], 0x19
DC47  81 C7 EF CC     add di, 0xccef
DC4B  1E              push ds
DC4C  07              pop es
DC4D  89 7E F6        mov word ptr [bp - 0xa], di
DC50  8C 46 F8        mov word ptr [bp - 8], es
DC53  6A 0E           push 0xe
DC55  80 7E FF 00     cmp byte ptr [bp - 1], 0
DC59  B0 00           mov al, 0
DC5B  75 01           jne 0xdc5e
DC5D  40              inc ax
loc_DC5E:
DC5E  98              cwde
DC5F  8B F8           mov di, ax
DC61  D1 E7           shl di, 1
DC63  6B 7B FA 19     imul di, word ptr [bp + di - 6], 0x19
DC67  81 C7 EF CC     add di, 0xccef
DC6B  1E              push ds
DC6C  57              push di
DC6D  0E              push cs
DC6E  E8 71 3E        call 0x11ae2
DC71  50              push ax
DC72  6A 06           push 6
DC74  C4 7E F6        les di, ptr [bp - 0xa]
DC77  06              push es
DC78  57              push di
DC79  0E              push cs
DC7A  E8 65 3E        call 0x11ae2
DC7D  5A              pop dx
DC7E  3B C2           cmp ax, dx
DC80  73 7C           jae 0xdcfe
DC82  6A 04           push 4
DC84  C4 7E F6        les di, ptr [bp - 0xa]
DC87  06              push es
DC88  57              push di
DC89  0E              push cs
DC8A  E8 BF 3D        call 0x11a4c
DC8D  08 C0           or al, al
DC8F  75 0B           jne 0xdc9c
DC91  6A 14           push 0x14
DC93  9A 1C 0D BC 24  call far 24BC:0D1C
DC98  08 C0           or al, al
DC9A  74 62           je 0xdcfe
loc_DC9C:
DC9C  80 7E FF 00     cmp byte ptr [bp - 1], 0
DCA0  B0 00           mov al, 0
DCA2  75 01           jne 0xdca5
DCA4  40              inc ax
loc_DCA5:
DCA5  98              cwde
DCA6  8B F8           mov di, ax
DCA8  D1 E7           shl di, 1
DCAA  6B 7B FA 19     imul di, word ptr [bp + di - 6], 0x19
DCAE  FF B5 FD CC     push word ptr [di - 0x3303]
DCB2  9A 0C 4E 55 1B  call far 1B55:4E0C
DCB7  30 E4           xor ah, ah
DCB9  50              push ax
DCBA  9A 6D 07 2A 23  call far 232A:076D
DCBF  50              push ax
DCC0  C4 7E F6        les di, ptr [bp - 0xa]
DCC3  26 FF 75 0E     push word ptr es:[di + 0xe]
DCC7  9A 0C 4E 55 1B  call far 1B55:4E0C
DCCC  30 E4           xor ah, ah
DCCE  50              push ax
DCCF  9A 6D 07 2A 23  call far 232A:076D
DCD4  5A              pop dx
DCD5  3B C2           cmp ax, dx
DCD7  7E 25           jle 0xdcfe
DCD9  8A 46 FF        mov al, byte ptr [bp - 1]
DCDC  98              cwde
DCDD  8B F8           mov di, ax
DCDF  D1 E7           shl di, 1
DCE1  8A 43 FA        mov al, byte ptr [bp + di - 6]
DCE4  A2 A0 D0        mov byte ptr [0xd0a0], al
DCE7  80 7E FF 00     cmp byte ptr [bp - 1], 0
DCEB  B0 00           mov al, 0
DCED  75 01           jne 0xdcf0
DCEF  40              inc ax
loc_DCF0:
DCF0  98              cwde
DCF1  8B F8           mov di, ax
DCF3  D1 E7           shl di, 1
DCF5  8A 43 FA        mov al, byte ptr [bp + di - 6]
DCF8  A2 9F D0        mov byte ptr [0xd09f], al
DCFB  E8 BA 8C        call 0x69b8
loc_DCFE:
DCFE  C9              leave
DCFF  C2 02 00        ret 2

