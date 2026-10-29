; 1-095.EXE (One-Nil 95), code segment 0AB5 (image offsets 0AB50..1993F), part 20 of 22
; packed 1-095.EXE sha256 f659fb2d334500d6901fc8d6a0f06c85c0ccda2eb4a3035ae3bb0a0004d79192 (LZEXE 0.91)
; unpacked (tools/static/unlzexe.py) sha256 8df646e017e0965a5d90a58181ca764219ad847833aad0b6cb58fc53372bfb2c
; tool: capstone 5.0.9 (pip package; core library 5.0.1280) (CS_ARCH_X86, CS_MODE_16), recursive descent from the entry point, far calls and near calls/jumps, then routine prologues (55 89 E5 / 55 8B EC / C8 iw 00) in what remains; tools/static/listing.py
; addresses are SEGMENT:OFFSET with SEGMENT the image paragraph before relocation; image offset = SEGMENT*16+OFFSET
; ---- routine 0AB5:D1D7  (found by: call)
sub_D1D7:
D1D7  55              push bp
D1D8  89 E5           mov bp, sp
D1DA  8B 7E 04        mov di, word ptr [bp + 4]
D1DD  36 8A 45 FC     mov al, byte ptr ss:[di - 4]
D1E1  3A 06 BA DC     cmp al, byte ptr [0xdcba]
D1E5  75 11           jne 0xd1f8
D1E7  C4 3E D2 D7     les di, ptr [0xd7d2]
D1EB  26 C6 45 04 01  mov byte ptr es:[di + 4], 1
D1F0  6A 01           push 1
D1F2  0E              push cs
D1F3  E8 F4 F9        call 0xcbea
D1F6  EB 3C           jmp 0xd234
loc_D1F8:
D1F8  8B 7E 04        mov di, word ptr [bp + 4]
D1FB  36 8A 45 FC     mov al, byte ptr ss:[di - 4]
D1FF  3A 06 BB DC     cmp al, byte ptr [0xdcbb]
D203  75 11           jne 0xd216
D205  C4 3E D2 D7     les di, ptr [0xd7d2]
D209  26 C6 45 04 02  mov byte ptr es:[di + 4], 2
D20E  6A 01           push 1
D210  0E              push cs
D211  E8 D6 F9        call 0xcbea
D214  EB 1E           jmp 0xd234
loc_D216:
D216  8B 7E 04        mov di, word ptr [bp + 4]
D219  36 8A 45 FC     mov al, byte ptr ss:[di - 4]
D21D  30 E4           xor ah, ah
D21F  6B C0 3E        imul ax, ax, 0x3e
D222  C4 3E C2 D7     les di, ptr [0xd7c2]
D226  03 F8           add di, ax
D228  81 C7 C2 FF     add di, 0xffc2
D22C  06              push es
D22D  57              push di
D22E  6A 00           push 0
D230  0E              push cs
D231  E8 0F DB        call 0xad43
loc_D234:
D234  C9              leave
D235  C2 02 00        ret 2
; data (not reached as code), 96 bytes
D238                  pstr ' has insufficient players'
D252                  pstr ' has an ineligible player in the first team'
D27E                  pstr ' has too many '
D28D                  db 01 73   ; .s
D28F                  pstr ' has no '

; ---- routine 0AB5:D298  (found by: call)
sub_D298:
D298  C8 18 02 00     enter 0x218, 0
D29C  8B 7E 04        mov di, word ptr [bp + 4]
D29F  36 8A 45 FC     mov al, byte ptr ss:[di - 4]
D2A3  30 E4           xor ah, ah
D2A5  89 46 EA        mov word ptr [bp - 0x16], ax
D2A8  C6 46 ED 00     mov byte ptr [bp - 0x13], 0
D2AC  EB 03           jmp 0xd2b1
loc_D2AE:
D2AE  FE 46 ED        inc byte ptr [bp - 0x13]
loc_D2B1:
D2B1  8A 46 ED        mov al, byte ptr [bp - 0x13]
D2B4  98              cwde
D2B5  8B F8           mov di, ax
D2B7  D1 E7           shl di, 1
D2B9  FF B5 E4 D6     push word ptr [di - 0x291c]
D2BD  9A DA 0D 51 1B  call far 1B51:0DDA
D2C2  08 C0           or al, al
D2C4  B0 00           mov al, 0
D2C6  75 01           jne 0xd2c9
D2C8  40              inc ax
loc_D2C9:
D2C9  8A D0           mov dl, al
D2CB  8A 46 ED        mov al, byte ptr [bp - 0x13]
D2CE  98              cwde
D2CF  8B F8           mov di, ax
D2D1  88 53 E8        mov byte ptr [bp + di - 0x18], dl
D2D4  80 7E ED 01     cmp byte ptr [bp - 0x13], 1
D2D8  75 D4           jne 0xd2ae
D2DA  C6 46 ED 00     mov byte ptr [bp - 0x13], 0
D2DE  EB 03           jmp 0xd2e3
loc_D2E0:
D2E0  FE 46 ED        inc byte ptr [bp - 0x13]
loc_D2E3:
D2E3  8A 46 ED        mov al, byte ptr [bp - 0x13]
D2E6  98              cwde
D2E7  8B F8           mov di, ax
D2E9  D1 E7           shl di, 1
D2EB  FF B5 E4 D6     push word ptr [di - 0x291c]
D2EF  9A DA 0D 51 1B  call far 1B51:0DDA
D2F4  08 C0           or al, al
D2F6  75 03           jne 0xd2fb
D2F8  E9 9C 02        jmp 0xd597
loc_D2FB:
D2FB  8A 46 ED        mov al, byte ptr [bp - 0x13]
D2FE  98              cwde
D2FF  8B F8           mov di, ax
D301  D1 E7           shl di, 1
D303  8A 85 E4 D6     mov al, byte ptr [di - 0x291c]
D307  8B 7E 04        mov di, word ptr [bp + 4]
D30A  36 88 45 FC     mov byte ptr ss:[di - 4], al
D30E  8D 7E F0        lea di, [bp - 0x10]
D311  16              push ss
D312  57              push di
D313  6A 0F           push 0xf
D315  6A 00           push 0
D317  9A 22 02 AC 24  call far 24AC:0222
D31C  8A 46 ED        mov al, byte ptr [bp - 0x13]
D31F  98              cwde
D320  8B F8           mov di, ax
D322  C6 43 E8 01     mov byte ptr [bp + di - 0x18], 1
D326  C7 46 EE 01 00  mov word ptr [bp - 0x12], 1
D32B  EB 03           jmp 0xd330
loc_D32D:
D32D  FF 46 EE        inc word ptr [bp - 0x12]
loc_D330:
D330  8B 7E 04        mov di, word ptr [bp + 4]
D333  36 8A 45 FC     mov al, byte ptr ss:[di - 4]
D337  30 E4           xor ah, ah
D339  6B C0 3E        imul ax, ax, 0x3e
D33C  C4 3E C2 D7     les di, ptr [0xd7c2]
D340  03 F8           add di, ax
D342  81 C7 C2 FF     add di, 0xffc2
D346  89 7E E4        mov word ptr [bp - 0x1c], di
D349  8C 46 E6        mov word ptr [bp - 0x1a], es
D34C  8B 46 EE        mov ax, word ptr [bp - 0x12]
D34F  D1 E0           shl ax, 1
D351  03 F8           add di, ax
D353  26 83 7D FE 00  cmp word ptr es:[di - 2], 0
D358  75 05           jne 0xd35f
D35A  FE 46 FE        inc byte ptr [bp - 2]
D35D  EB 39           jmp 0xd398
loc_D35F:
D35F  8B 46 EE        mov ax, word ptr [bp - 0x12]
D362  D1 E0           shl ax, 1
D364  C4 7E E4        les di, ptr [bp - 0x1c]
D367  03 F8           add di, ax
D369  26 FF 75 FE     push word ptr es:[di - 2]
D36D  9A E9 4E 51 1B  call far 1B51:4EE9
D372  08 C0           or al, al
D374  75 22           jne 0xd398
D376  8B 46 EE        mov ax, word ptr [bp - 0x12]
D379  D1 E0           shl ax, 1
D37B  C4 7E E4        les di, ptr [bp - 0x1c]
D37E  03 F8           add di, ax
D380  26 8B 45 FE     mov ax, word ptr es:[di - 2]
D384  C1 E0 03        shl ax, 3
D387  C4 3E BA D7     les di, ptr [0xd7ba]
D38B  03 F8           add di, ax
D38D  26 8A 45 06     mov al, byte ptr es:[di + 6]
D391  30 E4           xor ah, ah
D393  8B F8           mov di, ax
D395  FE 43 F0        inc byte ptr [bp + di - 0x10]
loc_D398:
D398  80 3E 18 0D 00  cmp byte ptr [0xd18], 0
D39D  75 21           jne 0xd3c0
D39F  8B 46 EE        mov ax, word ptr [bp - 0x12]
D3A2  D1 E0           shl ax, 1
D3A4  C4 7E E4        les di, ptr [bp - 0x1c]
D3A7  03 F8           add di, ax
D3A9  26 FF 75 FE     push word ptr es:[di - 2]
D3AD  9A E9 4E 51 1B  call far 1B51:4EE9
D3B2  08 C0           or al, al
D3B4  74 0A           je 0xd3c0
D3B6  8A 46 ED        mov al, byte ptr [bp - 0x13]
D3B9  98              cwde
D3BA  8B F8           mov di, ax
D3BC  C6 43 E8 00     mov byte ptr [bp + di - 0x18], 0
loc_D3C0:
D3C0  83 7E EE 0B     cmp word ptr [bp - 0x12], 0xb
D3C4  74 03           je 0xd3c9
D3C6  E9 64 FF        jmp 0xd32d
loc_D3C9:
D3C9  8A 46 ED        mov al, byte ptr [bp - 0x13]
D3CC  98              cwde
D3CD  8B F8           mov di, ax
D3CF  80 7B E8 00     cmp byte ptr [bp + di - 0x18], 0
D3D3  74 03           je 0xd3d8
D3D5  E9 89 00        jmp 0xd461
loc_D3D8:
D3D8  80 7E FE 00     cmp byte ptr [bp - 2], 0
D3DC  B0 00           mov al, 0
D3DE  74 01           je 0xd3e1
D3E0  40              inc ax
loc_D3E1:
D3E1  50              push ax
D3E2  8D BE E8 FE     lea di, [bp - 0x118]
D3E6  16              push ss
D3E7  57              push di
D3E8  8B 7E 04        mov di, word ptr [bp + 4]
D3EB  36 8A 45 FC     mov al, byte ptr ss:[di - 4]
D3EF  30 E4           xor ah, ah
D3F1  C1 E0 04        shl ax, 4
D3F4  C4 3E B2 D7     les di, ptr [0xd7b2]
D3F8  03 F8           add di, ax
D3FA  81 C7 F0 FF     add di, 0xfff0
D3FE  06              push es
D3FF  57              push di
D400  9A 53 0B B9 26  call far 26B9:0B53
D405  BF 38 D2        mov di, 0xd238
D408  0E              push cs
D409  57              push di
D40A  9A D2 0B B9 26  call far 26B9:0BD2
D40F  9A 98 00 1A 23  call far 231A:0098
D414  08 C0           or al, al
D416  75 46           jne 0xd45e
D418  8A 46 ED        mov al, byte ptr [bp - 0x13]
D41B  98              cwde
D41C  8B F8           mov di, ax
D41E  80 7B E8 00     cmp byte ptr [bp + di - 0x18], 0
D422  B0 00           mov al, 0
D424  75 01           jne 0xd427
D426  40              inc ax
loc_D427:
D427  50              push ax
D428  8D BE E8 FD     lea di, [bp - 0x218]
D42C  16              push ss
D42D  57              push di
D42E  8B 7E 04        mov di, word ptr [bp + 4]
D431  36 8A 45 FC     mov al, byte ptr ss:[di - 4]
D435  30 E4           xor ah, ah
D437  C1 E0 04        shl ax, 4
D43A  C4 3E B2 D7     les di, ptr [0xd7b2]
D43E  03 F8           add di, ax
D440  81 C7 F0 FF     add di, 0xfff0
D444  06              push es
D445  57              push di
D446  9A 53 0B B9 26  call far 26B9:0B53
D44B  BF 52 D2        mov di, 0xd252
D44E  0E              push cs
D44F  57              push di
D450  9A D2 0B B9 26  call far 26B9:0BD2
D455  9A 98 00 1A 23  call far 231A:0098
D45A  08 C0           or al, al
D45C  74 00           je 0xd45e
loc_D45E:
D45E  E9 AF 00        jmp 0xd510
loc_D461:
D461  80 7E F0 01     cmp byte ptr [bp - 0x10], 1
D465  B0 00           mov al, 0
D467  76 01           jbe 0xd46a
D469  40              inc ax
loc_D46A:
D46A  50              push ax
D46B  8D BE E8 FE     lea di, [bp - 0x118]
D46F  16              push ss
D470  57              push di
D471  8B 7E 04        mov di, word ptr [bp + 4]
D474  36 8A 45 FC     mov al, byte ptr ss:[di - 4]
D478  30 E4           xor ah, ah
D47A  C1 E0 04        shl ax, 4
D47D  C4 3E B2 D7     les di, ptr [0xd7b2]
D481  03 F8           add di, ax
D483  81 C7 F0 FF     add di, 0xfff0
D487  06              push es
D488  57              push di
D489  9A 53 0B B9 26  call far 26B9:0B53
D48E  BF 7E D2        mov di, 0xd27e
D491  0E              push cs
D492  57              push di
D493  9A D2 0B B9 26  call far 26B9:0BD2
D498  BF 24 87        mov di, 0x8724
D49B  1E              push ds
D49C  57              push di
D49D  9A D2 0B B9 26  call far 26B9:0BD2
D4A2  BF 8D D2        mov di, 0xd28d
D4A5  0E              push cs
D4A6  57              push di
D4A7  9A D2 0B B9 26  call far 26B9:0BD2
D4AC  9A 98 00 1A 23  call far 231A:0098
D4B1  08 C0           or al, al
D4B3  75 4A           jne 0xd4ff
D4B5  80 7E F0 00     cmp byte ptr [bp - 0x10], 0
D4B9  B0 00           mov al, 0
D4BB  75 01           jne 0xd4be
D4BD  40              inc ax
loc_D4BE:
D4BE  50              push ax
D4BF  8D BE E8 FD     lea di, [bp - 0x218]
D4C3  16              push ss
D4C4  57              push di
D4C5  8B 7E 04        mov di, word ptr [bp + 4]
D4C8  36 8A 45 FC     mov al, byte ptr ss:[di - 4]
D4CC  30 E4           xor ah, ah
D4CE  C1 E0 04        shl ax, 4
D4D1  C4 3E B2 D7     les di, ptr [0xd7b2]
D4D5  03 F8           add di, ax
D4D7  81 C7 F0 FF     add di, 0xfff0
D4DB  06              push es
D4DC  57              push di
D4DD  9A 53 0B B9 26  call far 26B9:0B53
D4E2  BF 8F D2        mov di, 0xd28f
D4E5  0E              push cs
D4E6  57              push di
D4E7  9A D2 0B B9 26  call far 26B9:0BD2
D4EC  BF 24 87        mov di, 0x8724
D4EF  1E              push ds
D4F0  57              push di
D4F1  9A D2 0B B9 26  call far 26B9:0BD2
D4F6  9A 98 00 1A 23  call far 231A:0098
D4FB  08 C0           or al, al
D4FD  74 04           je 0xd503
loc_D4FF:
D4FF  B0 00           mov al, 0
D501  EB 02           jmp 0xd505
loc_D503:
D503  B0 01           mov al, 1
loc_D505:
D505  8A D0           mov dl, al
D507  8A 46 ED        mov al, byte ptr [bp - 0x13]
D50A  98              cwde
D50B  8B F8           mov di, ax
D50D  88 53 E8        mov byte ptr [bp + di - 0x18], dl
loc_D510:
D510  C7 46 EE 01 00  mov word ptr [bp - 0x12], 1
loc_D515:
D515  8A 46 ED        mov al, byte ptr [bp - 0x13]
D518  98              cwde
D519  8B F8           mov di, ax
D51B  80 7B E8 00     cmp byte ptr [bp + di - 0x18], 0
D51F  74 76           je 0xd597
D521  83 7E EE 0D     cmp word ptr [bp - 0x12], 0xd
D525  77 70           ja 0xd597
D527  8B 7E EE        mov di, word ptr [bp - 0x12]
D52A  80 7B F0 03     cmp byte ptr [bp + di - 0x10], 3
D52E  B0 00           mov al, 0
D530  76 01           jbe 0xd533
D532  40              inc ax
loc_D533:
D533  50              push ax
D534  8D BE E8 FE     lea di, [bp - 0x118]
D538  16              push ss
D539  57              push di
D53A  8B 7E 04        mov di, word ptr [bp + 4]
D53D  36 8A 45 FC     mov al, byte ptr ss:[di - 4]
D541  30 E4           xor ah, ah
D543  C1 E0 04        shl ax, 4
D546  C4 3E B2 D7     les di, ptr [0xd7b2]
D54A  03 F8           add di, ax
D54C  81 C7 F0 FF     add di, 0xfff0
D550  06              push es
D551  57              push di
D552  9A 53 0B B9 26  call far 26B9:0B53
D557  BF 7E D2        mov di, 0xd27e
D55A  0E              push cs
D55B  57              push di
D55C  9A D2 0B B9 26  call far 26B9:0BD2
D561  6B 7E EE 13     imul di, word ptr [bp - 0x12], 0x13
D565  81 C7 24 87     add di, 0x8724
D569  1E              push ds
D56A  57              push di
D56B  9A D2 0B B9 26  call far 26B9:0BD2
D570  BF 8D D2        mov di, 0xd28d
D573  0E              push cs
D574  57              push di
D575  9A D2 0B B9 26  call far 26B9:0BD2
D57A  9A 98 00 1A 23  call far 231A:0098
D57F  08 C0           or al, al
D581  B0 00           mov al, 0
D583  75 01           jne 0xd586
D585  40              inc ax
loc_D586:
D586  8A D0           mov dl, al
D588  8A 46 ED        mov al, byte ptr [bp - 0x13]
D58B  98              cwde
D58C  8B F8           mov di, ax
D58E  88 53 E8        mov byte ptr [bp + di - 0x18], dl
D591  FF 46 EE        inc word ptr [bp - 0x12]
D594  E9 7E FF        jmp 0xd515
loc_D597:
D597  80 7E ED 01     cmp byte ptr [bp - 0x13], 1
D59B  74 03           je 0xd5a0
D59D  E9 40 FD        jmp 0xd2e0
loc_D5A0:
D5A0  80 7E E8 00     cmp byte ptr [bp - 0x18], 0
D5A4  74 06           je 0xd5ac
D5A6  80 7E E9 00     cmp byte ptr [bp - 0x17], 0
D5AA  75 04           jne 0xd5b0
loc_D5AC:
D5AC  B0 00           mov al, 0
D5AE  EB 02           jmp 0xd5b2
loc_D5B0:
D5B0  B0 01           mov al, 1
loc_D5B2:
D5B2  88 46 FF        mov byte ptr [bp - 1], al
D5B5  8A 46 EA        mov al, byte ptr [bp - 0x16]
D5B8  8B 7E 04        mov di, word ptr [bp + 4]
D5BB  36 88 45 FC     mov byte ptr ss:[di - 4], al
D5BF  8A 46 FF        mov al, byte ptr [bp - 1]
D5C2  C9              leave
D5C3  C2 02 00        ret 2
; data (not reached as code), 10 bytes
D5C6                  pstr 'CONTINUE '

; ---- routine 0AB5:D5D0  (found by: call)
sub_D5D0:
D5D0  C8 06 01 00     enter 0x106, 0
D5D4  80 7E 04 00     cmp byte ptr [bp + 4], 0
D5D8  74 14           je 0xd5ee
D5DA  C4 3E 58 DD     les di, ptr [0xdd58]
D5DE  06              push es
D5DF  57              push di
D5E0  C4 3E 60 DD     les di, ptr [0xdd60]
D5E4  06              push es
D5E5  57              push di
D5E6  68 A0 0F        push 0xfa0
D5E9  9A 12 0A B9 26  call far 26B9:0A12
loc_D5EE:
D5EE  E8 5E 40        call 0x1164f
D5F1  C6 46 FB 03     mov byte ptr [bp - 5], 3
D5F5  A0 E6 D6        mov al, byte ptr [0xd6e6]
D5F8  B4 01           mov ah, 1
D5FA  BA 20 00        mov dx, 0x20
D5FD  9A 1F 0E B9 26  call far 26B9:0E1F
D602  52              push dx
D603  50              push ax
D604  8D 7E DA        lea di, [bp - 0x26]
D607  16              push ss
D608  57              push di
D609  6A 00           push 0
D60B  9A 94 0D B9 26  call far 26B9:0D94
D610  A0 BA DC        mov al, byte ptr [0xdcba]
D613  50              push ax
D614  9A AA 0D B9 26  call far 26B9:0DAA
D619  A0 BB DC        mov al, byte ptr [0xdcbb]
D61C  50              push ax
D61D  9A AA 0D B9 26  call far 26B9:0DAA
D622  5F              pop di
D623  07              pop es
D624  58              pop ax
D625  5A              pop dx
D626  03 FA           add di, dx
D628  26 84 05        test byte ptr es:[di], al
D62B  74 06           je 0xd633
D62D  C6 46 FE 01     mov byte ptr [bp - 2], 1
D631  EB 42           jmp 0xd675
loc_D633:
D633  A0 E4 D6        mov al, byte ptr [0xd6e4]
D636  B4 01           mov ah, 1
D638  BA 20 00        mov dx, 0x20
D63B  9A 1F 0E B9 26  call far 26B9:0E1F
D640  52              push dx
D641  50              push ax
D642  8D 7E BA        lea di, [bp - 0x46]
D645  16              push ss
D646  57              push di
D647  6A 00           push 0
D649  9A 94 0D B9 26  call far 26B9:0D94
D64E  A0 BA DC        mov al, byte ptr [0xdcba]
D651  50              push ax
D652  9A AA 0D B9 26  call far 26B9:0DAA
D657  A0 BB DC        mov al, byte ptr [0xdcbb]
D65A  50              push ax
D65B  9A AA 0D B9 26  call far 26B9:0DAA
D660  5F              pop di
D661  07              pop es
D662  58              pop ax
D663  5A              pop dx
D664  03 FA           add di, dx
D666  26 84 05        test byte ptr es:[di], al
D669  74 06           je 0xd671
D66B  C6 46 FE 00     mov byte ptr [bp - 2], 0
D66F  EB 04           jmp 0xd675
loc_D671:
D671  C6 46 FE 01     mov byte ptr [bp - 2], 1
loc_D675:
D675  8A 46 FE        mov al, byte ptr [bp - 2]
D678  98              cwde
D679  8B F8           mov di, ax
D67B  D1 E7           shl di, 1
D67D  8A 85 E4 D6     mov al, byte ptr [di - 0x291c]
D681  88 46 FC        mov byte ptr [bp - 4], al
D684  80 3E 18 0D 00  cmp byte ptr [0xd18], 0
D689  74 16           je 0xd6a1
D68B  C4 3E 96 D0     les di, ptr [0xd096]
D68F  06              push es
D690  57              push di
D691  C4 3E 8E D0     les di, ptr [0xd08e]
D695  06              push es
D696  57              push di
D697  68 A0 0F        push 0xfa0
D69A  9A 12 0A B9 26  call far 26B9:0A12
D69F  EB 14           jmp 0xd6b5
loc_D6A1:
D6A1  C4 3E 92 D0     les di, ptr [0xd092]
D6A5  06              push es
D6A6  57              push di
D6A7  C4 3E 8E D0     les di, ptr [0xd08e]
D6AB  06              push es
D6AC  57              push di
D6AD  68 A0 0F        push 0xfa0
D6B0  9A 12 0A B9 26  call far 26B9:0A12
loc_D6B5:
D6B5  8A 46 FC        mov al, byte ptr [bp - 4]
D6B8  30 E4           xor ah, ah
D6BA  50              push ax
D6BB  6A 00           push 0
D6BD  0E              push cs
D6BE  E8 41 C0        call 0x9702
D6C1  BF 2E 13        mov di, 0x132e
D6C4  1E              push ds
D6C5  57              push di
D6C6  BF 5C DD        mov di, 0xdd5c
D6C9  1E              push ds
D6CA  57              push di
D6CB  9A 2F 05 1A 23  call far 231A:052F
D6D0  BF CC 25        mov di, 0x25cc
D6D3  1E              push ds
D6D4  57              push di
D6D5  BF 5C DD        mov di, 0xdd5c
D6D8  1E              push ds
D6D9  57              push di
D6DA  9A 2F 05 1A 23  call far 231A:052F
D6DF  C6 46 FD 00     mov byte ptr [bp - 3], 0
D6E3  EB 03           jmp 0xd6e8
loc_D6E5:
D6E5  FE 46 FD        inc byte ptr [bp - 3]
loc_D6E8:
D6E8  8A 46 FD        mov al, byte ptr [bp - 3]
D6EB  98              cwde
D6EC  8B F8           mov di, ax
D6EE  D1 E7           shl di, 1
D6F0  FF B5 E4 D6     push word ptr [di - 0x291c]
D6F4  8A 46 FD        mov al, byte ptr [bp - 3]
D6F7  98              cwde
D6F8  8B F8           mov di, ax
D6FA  8A 85 DC 0C     mov al, byte ptr [di + 0xcdc]
D6FE  30 E4           xor ah, ah
D700  50              push ax
D701  6A 03           push 3
D703  9A 43 0E 51 1B  call far 1B51:0E43
D708  80 7E FD 01     cmp byte ptr [bp - 3], 1
D70C  75 D7           jne 0xd6e5
D70E  8A 46 FC        mov al, byte ptr [bp - 4]
D711  30 E4           xor ah, ah
D713  50              push ax
D714  6A 01           push 1
D716  6A 01           push 1
D718  9A 43 0E 51 1B  call far 1B51:0E43
D71D  6A 07           push 7
D71F  8D BE FA FE     lea di, [bp - 0x106]
D723  16              push ss
D724  57              push di
D725  C4 3E D2 D7     les di, ptr [0xd7d2]
D729  26 8A 05        mov al, byte ptr es:[di]
D72C  30 E4           xor ah, ah
D72E  8B F0           mov si, ax
D730  D1 E0           shl ax, 1
D732  01 F0           add ax, si
D734  8B D0           mov dx, ax
D736  69 06 E6 D6 AE 00 imul ax, word ptr [0xd6e6], 0xae
D73C  C4 3E CA D7     les di, ptr [0xd7ca]
D740  03 F8           add di, ax
D742  03 FA           add di, dx
D744  26 8A 85 4F FF  mov al, byte ptr es:[di - 0xb1]
D749  50              push ax
D74A  C4 3E D2 D7     les di, ptr [0xd7d2]
D74E  26 8A 05        mov al, byte ptr es:[di]
D751  50              push ax
D752  9A 8B 13 51 1B  call far 1B51:138B
D757  6A 03           push 3
D759  6A 02           push 2
D75B  BF 5C DD        mov di, 0xdd5c
D75E  1E              push ds
D75F  57              push di
D760  9A 1B 04 1A 23  call far 231A:041B
D765  8D BE FA FE     lea di, [bp - 0x106]
D769  16              push ss
D76A  57              push di
D76B  8A 46 FE        mov al, byte ptr [bp - 2]
D76E  50              push ax
D76F  9A B9 46 51 1B  call far 1B51:46B9
D774  31 D2           xor dx, dx
D776  52              push dx
D777  50              push ax
D778  9A C9 07 1A 23  call far 231A:07C9
D77D  6A 0A           push 0xa
D77F  6A 12           push 0x12
D781  BF 5C DD        mov di, 0xdd5c
D784  1E              push ds
D785  57              push di
D786  9A 83 02 1A 23  call far 231A:0283
D78B  80 7E FE 00     cmp byte ptr [bp - 2], 0
D78F  B0 00           mov al, 0
D791  75 01           jne 0xd794
D793  40              inc ax
loc_D794:
D794  98              cwde
D795  8B F8           mov di, ax
D797  D1 E7           shl di, 1
D799  FF B5 E4 D6     push word ptr [di - 0x291c]
D79D  A0 D8 0C        mov al, byte ptr [0xcd8]
D7A0  30 E4           xor ah, ah
D7A2  50              push ax
D7A3  6A 03           push 3
D7A5  9A 43 0E 51 1B  call far 1B51:0E43
D7AA  8A 46 FC        mov al, byte ptr [bp - 4]
D7AD  30 E4           xor ah, ah
D7AF  50              push ax
D7B0  9A DA 0D 51 1B  call far 1B51:0DDA
D7B5  08 C0           or al, al
D7B7  74 1E           je 0xd7d7
D7B9  A0 DB 0C        mov al, byte ptr [0xcdb]
D7BC  30 E4           xor ah, ah
D7BE  69 C0 A0 00     imul ax, ax, 0xa0
D7C2  C4 3E 5C DD     les di, ptr [0xdd5c]
D7C6  03 F8           add di, ax
D7C8  81 C7 62 FF     add di, 0xff62
D7CC  06              push es
D7CD  57              push di
D7CE  6A 0C           push 0xc
D7D0  6A 11           push 0x11
D7D2  9A 4B 03 AC 24  call far 24AC:034B
loc_D7D7:
D7D7  80 3E 56 DD 00  cmp byte ptr [0xdd56], 0
D7DC  74 15           je 0xd7f3
D7DE  6A 0E           push 0xe
D7E0  BF C6 D5        mov di, 0xd5c6
D7E3  0E              push cs
D7E4  57              push di
D7E5  6A 11           push 0x11
D7E7  6A 03           push 3
D7E9  BF 5C DD        mov di, 0xdd5c
D7EC  1E              push ds
D7ED  57              push di
D7EE  9A 1B 04 1A 23  call far 231A:041B
loc_D7F3:
D7F3  8A 46 FB        mov al, byte ptr [bp - 5]
D7F6  30 E4           xor ah, ah
D7F8  8B F8           mov di, ax
D7FA  8A 85 D7 0C     mov al, byte ptr [di + 0xcd7]
D7FE  30 E4           xor ah, ah
D800  50              push ax
D801  6A 02           push 2
D803  6A 11           push 0x11
D805  9A 03 02 1A 23  call far 231A:0203
D80A  8D 7E FB        lea di, [bp - 5]
D80D  16              push ss
D80E  57              push di
D80F  6A 04           push 4
D811  9A 8B 0F 1A 23  call far 231A:0F8B
D816  80 3E 88 DE 01  cmp byte ptr [0xde88], 1
D81B  75 07           jne 0xd824
D81D  80 3E 18 0D 00  cmp byte ptr [0xd18], 0
D822  75 04           jne 0xd828
loc_D824:
D824  B0 00           mov al, 0
D826  EB 02           jmp 0xd82a
loc_D828:
D828  B0 01           mov al, 1
loc_D82A:
D82A  88 46 FF        mov byte ptr [bp - 1], al
D82D  80 3E 88 DE 0D  cmp byte ptr [0xde88], 0xd
D832  75 08           jne 0xd83c
D834  9A 68 30 51 1B  call far 1B51:3068
D839  E9 87 00        jmp 0xd8c3
loc_D83C:
D83C  A0 88 DE        mov al, byte ptr [0xde88]
D83F  50              push ax
D840  9A 86 19 B9 26  call far 26B9:1986
D845  3C 54           cmp al, 0x54
D847  75 1B           jne 0xd864
D849  8A 46 FC        mov al, byte ptr [bp - 4]
D84C  30 E4           xor ah, ah
D84E  50              push ax
D84F  9A DA 0D 51 1B  call far 1B51:0DDA
D854  08 C0           or al, al
D856  74 0C           je 0xd864
D858  8A 46 FC        mov al, byte ptr [bp - 4]
D85B  30 E4           xor ah, ah
D85D  50              push ax
D85E  0E              push cs
D85F  E8 0D BE        call 0x966f
D862  EB 5F           jmp 0xd8c3
loc_D864:
D864  80 3E 88 DE 20  cmp byte ptr [0xde88], 0x20
D869  75 06           jne 0xd871
D86B  55              push bp
D86C  E8 68 F9        call 0xd1d7
D86F  EB 52           jmp 0xd8c3
loc_D871:
D871  80 3E 88 DE 02  cmp byte ptr [0xde88], 2
D876  75 4B           jne 0xd8c3
D878  8A 46 FB        mov al, byte ptr [bp - 5]
D87B  3C 01           cmp al, 1
D87D  75 0E           jne 0xd88d
D87F  80 7E FE 00     cmp byte ptr [bp - 2], 0
D883  B0 00           mov al, 0
D885  75 01           jne 0xd888
D887  40              inc ax
loc_D888:
D888  88 46 FE        mov byte ptr [bp - 2], al
D88B  EB 36           jmp 0xd8c3
loc_D88D:
D88D  3C 02           cmp al, 2
D88F  75 0B           jne 0xd89c
D891  6A 01           push 1
D893  6A 00           push 0
D895  9A 5C 04 94 19  call far 1994:045C
D89A  EB 27           jmp 0xd8c3
loc_D89C:
D89C  3C 03           cmp al, 3
D89E  75 06           jne 0xd8a6
D8A0  C6 46 FF 01     mov byte ptr [bp - 1], 1
D8A4  EB 1D           jmp 0xd8c3
loc_D8A6:
D8A6  3C 04           cmp al, 4
D8A8  75 19           jne 0xd8c3
D8AA  8A 46 FC        mov al, byte ptr [bp - 4]
D8AD  30 E4           xor ah, ah
D8AF  50              push ax
D8B0  9A DA 0D 51 1B  call far 1B51:0DDA
D8B5  08 C0           or al, al
D8B7  74 0A           je 0xd8c3
D8B9  8A 46 FC        mov al, byte ptr [bp - 4]
D8BC  30 E4           xor ah, ah
D8BE  50              push ax
D8BF  0E              push cs
D8C0  E8 AC BD        call 0x966f
loc_D8C3:
D8C3  80 7E FF 00     cmp byte ptr [bp - 1], 0
D8C7  75 03           jne 0xd8cc
D8C9  E9 A9 FD        jmp 0xd675
loc_D8CC:
D8CC  55              push bp
D8CD  E8 C8 F9        call 0xd298
D8D0  08 C0           or al, al
D8D2  75 03           jne 0xd8d7
D8D4  E9 9E FD        jmp 0xd675
loc_D8D7:
D8D7  80 3E 18 0D 00  cmp byte ptr [0xd18], 0
D8DC  74 14           je 0xd8f2
D8DE  C4 3E 60 DD     les di, ptr [0xdd60]
D8E2  06              push es
D8E3  57              push di
D8E4  C4 3E 58 DD     les di, ptr [0xdd58]
D8E8  06              push es
D8E9  57              push di
D8EA  68 A0 0F        push 0xfa0
D8ED  9A 12 0A B9 26  call far 26B9:0A12
loc_D8F2:
D8F2  C6 06 18 0D 01  mov byte ptr [0xd18], 1
D8F7  E8 55 3D        call 0x1164f
D8FA  C9              leave
D8FB  C2 02 00        ret 2

; ---- routine 0AB5:D8FE  (found by: call)
sub_D8FE:
D8FE  C8 06 00 00     enter 6, 0
D902  8B 46 04        mov ax, word ptr [bp + 4]
D905  8B F0           mov si, ax
D907  D1 E0           shl ax, 1
D909  01 F0           add ax, si
D90B  8B D0           mov dx, ax
D90D  69 46 06 AE 00  imul ax, word ptr [bp + 6], 0xae
D912  C4 3E CA D7     les di, ptr [0xd7ca]
D916  03 F8           add di, ax
D918  03 FA           add di, dx
D91A  81 C7 4F FF     add di, 0xff4f
D91E  89 7E FA        mov word ptr [bp - 6], di
D921  8C 46 FC        mov word ptr [bp - 4], es
D924  C6 46 FF 00     mov byte ptr [bp - 1], 0
D928  26 80 3D 03     cmp byte ptr es:[di], 3
D92C  74 21           je 0xd94f
D92E  26 80 3D 04     cmp byte ptr es:[di], 4
D932  74 1B           je 0xd94f
D934  26 80 3D 06     cmp byte ptr es:[di], 6
D938  75 06           jne 0xd940
D93A  83 7E 04 39     cmp word ptr [bp + 4], 0x39
D93E  74 0F           je 0xd94f
loc_D940:
D940  C4 7E FA        les di, ptr [bp - 6]
D943  26 80 3D 07     cmp byte ptr es:[di], 7
D947  75 16           jne 0xd95f
D949  83 7E 04 30     cmp word ptr [bp + 4], 0x30
D94D  75 10           jne 0xd95f
loc_D94F:
D94F  FF 76 06        push word ptr [bp + 6]
D952  FF 76 04        push word ptr [bp + 4]
D955  9A 22 17 51 1B  call far 1B51:1722
D95A  88 46 FF        mov byte ptr [bp - 1], al
D95D  EB 17           jmp 0xd976
loc_D95F:
D95F  FF 76 06        push word ptr [bp + 6]
D962  FF 76 04        push word ptr [bp + 4]
D965  9A 2B 02 94 19  call far 1994:022B
D96A  50              push ax
D96B  FF 76 04        push word ptr [bp + 4]
D96E  9A 7C 19 51 1B  call far 1B51:197C
D973  88 46 FF        mov byte ptr [bp - 1], al
loc_D976:
D976  8A 46 FF        mov al, byte ptr [bp - 1]
D979  C9              leave
D97A  C2 04 00        ret 4

; ---- routine 0AB5:D97D  (found by: call)
sub_D97D:
D97D  C8 08 00 00     enter 8, 0
D981  8B 46 04        mov ax, word ptr [bp + 4]
D984  89 46 F8        mov word ptr [bp - 8], ax
D987  B8 01 00        mov ax, 1
D98A  3B 46 F8        cmp ax, word ptr [bp - 8]
D98D  76 03           jbe 0xd992
D98F  E9 A5 00        jmp 0xda37
loc_D992:
D992  89 46 FC        mov word ptr [bp - 4], ax
D995  EB 03           jmp 0xd99a
loc_D997:
D997  FF 46 FC        inc word ptr [bp - 4]
loc_D99A:
D99A  31 C0           xor ax, ax
D99C  89 46 FE        mov word ptr [bp - 2], ax
D99F  EB 03           jmp 0xd9a4
loc_D9A1:
D9A1  FF 46 FE        inc word ptr [bp - 2]
loc_D9A4:
D9A4  8B 46 FE        mov ax, word ptr [bp - 2]
D9A7  35 01 00        xor ax, 1
D9AA  8B F8           mov di, ax
D9AC  D1 E7           shl di, 1
D9AE  FF B5 7C D6     push word ptr [di - 0x2984]
D9B2  9A 6D 07 1A 23  call far 231A:076D
D9B7  50              push ax
D9B8  8B 7E FE        mov di, word ptr [bp - 2]
D9BB  D1 E7           shl di, 1
D9BD  FF B5 7C D6     push word ptr [di - 0x2984]
D9C1  9A 6D 07 1A 23  call far 231A:076D
D9C6  5A              pop dx
D9C7  3B C2           cmp ax, dx
D9C9  7E 58           jle 0xda23
D9CB  8B 46 FE        mov ax, word ptr [bp - 2]
D9CE  35 01 00        xor ax, 1
D9D1  8B F8           mov di, ax
D9D3  D1 E7           shl di, 1
D9D5  FF B5 78 D6     push word ptr [di - 0x2988]
D9D9  9A 6D 07 1A 23  call far 231A:076D
D9DE  50              push ax
D9DF  8B 7E FE        mov di, word ptr [bp - 2]
D9E2  D1 E7           shl di, 1
D9E4  FF B5 80 D6     push word ptr [di - 0x2980]
D9E8  9A 6D 07 1A 23  call far 231A:076D
D9ED  5A              pop dx
D9EE  3B C2           cmp ax, dx
D9F0  7E 31           jle 0xda23
D9F2  8B 46 FE        mov ax, word ptr [bp - 2]
D9F5  35 01 00        xor ax, 1
D9F8  8B F8           mov di, ax
D9FA  D1 E7           shl di, 1
D9FC  FF B5 74 D6     push word ptr [di - 0x298c]
DA00  9A 6D 07 1A 23  call far 231A:076D
DA05  50              push ax
DA06  8B 7E FE        mov di, word ptr [bp - 2]
DA09  D1 E7           shl di, 1
DA0B  FF B5 80 D6     push word ptr [di - 0x2980]
DA0F  9A 6D 07 1A 23  call far 231A:076D
DA14  5A              pop dx
DA15  3B C2           cmp ax, dx
DA17  7E 0A           jle 0xda23
DA19  8B 46 FE        mov ax, word ptr [bp - 2]
DA1C  40              inc ax
DA1D  8B F8           mov di, ax
DA1F  FE 85 85 D0     inc byte ptr [di - 0x2f7b]
loc_DA23:
DA23  83 7E FE 01     cmp word ptr [bp - 2], 1
DA27  74 03           je 0xda2c
DA29  E9 75 FF        jmp 0xd9a1
loc_DA2C:
DA2C  8B 46 FC        mov ax, word ptr [bp - 4]
DA2F  3B 46 F8        cmp ax, word ptr [bp - 8]
DA32  74 03           je 0xda37
DA34  E9 60 FF        jmp 0xd997
loc_DA37:
DA37  C9              leave
DA38  C2 02 00        ret 2

; ---- routine 0AB5:DA3B  (found by: call)
sub_DA3B:
DA3B  C8 02 02 00     enter 0x202, 0
DA3F  BF E2 63        mov di, 0x63e2
DA42  1E              push ds
DA43  57              push di
DA44  BF 5C DD        mov di, 0xdd5c
DA47  1E              push ds
DA48  57              push di
DA49  9A 2F 05 1A 23  call far 231A:052F
DA4E  BF B4 66        mov di, 0x66b4
DA51  1E              push ds
DA52  57              push di
DA53  BF 5C DD        mov di, 0xdd5c
DA56  1E              push ds
DA57  57              push di
DA58  9A 2F 05 1A 23  call far 231A:052F
DA5D  BF DE 19        mov di, 0x19de
DA60  1E              push ds
DA61  57              push di
DA62  BF 5C DD        mov di, 0xdd5c
DA65  1E              push ds
DA66  57              push di
DA67  9A 2F 05 1A 23  call far 231A:052F
DA6C  C6 46 FF 00     mov byte ptr [bp - 1], 0
DA70  EB 03           jmp 0xda75
loc_DA72:
DA72  FE 46 FF        inc byte ptr [bp - 1]
loc_DA75:
DA75  8A 46 FF        mov al, byte ptr [bp - 1]
DA78  98              cwde
DA79  8B F8           mov di, ax
DA7B  8A 85 C8 D0     mov al, byte ptr [di - 0x2f38]
DA7F  50              push ax
DA80  8D BE FE FE     lea di, [bp - 0x102]
DA84  16              push ss
DA85  57              push di
DA86  8A 46 FF        mov al, byte ptr [bp - 1]
DA89  98              cwde
DA8A  8B F8           mov di, ax
DA8C  D1 E7           shl di, 1
DA8E  8B 85 E4 D6     mov ax, word ptr [di - 0x291c]
DA92  C1 E0 04        shl ax, 4
DA95  C4 3E B2 D7     les di, ptr [0xd7b2]
DA99  03 F8           add di, ax
DA9B  81 C7 F0 FF     add di, 0xfff0
DA9F  06              push es
DAA0  57              push di
DAA1  9A 5A 00 AC 24  call far 24AC:005A
DAA6  8A 46 FF        mov al, byte ptr [bp - 1]
DAA9  98              cwde
DAAA  8B F8           mov di, ax
DAAC  8A 85 DE 0C     mov al, byte ptr [di + 0xcde]
DAB0  50              push ax
DAB1  6A 02           push 2
DAB3  BF 5C DD        mov di, 0xdd5c
DAB6  1E              push ds
DAB7  57              push di
DAB8  9A 1B 04 1A 23  call far 231A:041B
DABD  80 7E FF 01     cmp byte ptr [bp - 1], 1
DAC1  75 AF           jne 0xda72
DAC3  6A 05           push 5
DAC5  8D BE FE FD     lea di, [bp - 0x202]
DAC9  16              push ss
DACA  57              push di
DACB  8D BE FE FE     lea di, [bp - 0x102]
DACF  16              push ss
DAD0  57              push di
DAD1  C4 3E D2 D7     les di, ptr [0xd7d2]
DAD5  26 8A 05        mov al, byte ptr es:[di]
DAD8  30 E4           xor ah, ah
DADA  8B F0           mov si, ax
DADC  D1 E0           shl ax, 1
DADE  01 F0           add ax, si
DAE0  8B D0           mov dx, ax
DAE2  69 06 E6 D6 AE 00 imul ax, word ptr [0xd6e6], 0xae
DAE8  C4 3E CA D7     les di, ptr [0xd7ca]
DAEC  03 F8           add di, ax
DAEE  03 FA           add di, dx
DAF0  26 8A 85 4F FF  mov al, byte ptr es:[di - 0xb1]
DAF5  50              push ax
DAF6  C4 3E D2 D7     les di, ptr [0xd7d2]
DAFA  26 8A 05        mov al, byte ptr es:[di]
DAFD  50              push ax
DAFE  9A 8B 13 51 1B  call far 1B51:138B
DB03  9A 5A 00 AC 24  call far 24AC:005A
DB08  6A 01           push 1
DB0A  6A 2A           push 0x2a
DB0C  BF 5C DD        mov di, 0xdd5c
DB0F  1E              push ds
DB10  57              push di
DB11  9A 1B 04 1A 23  call far 231A:041B
DB16  BF 5C DD        mov di, 0xdd5c
DB19  1E              push ds
DB1A  57              push di
DB1B  9A DF 02 94 19  call far 1994:02DF
DB20  6A 06           push 6
DB22  8D BE FE FE     lea di, [bp - 0x102]
DB26  16              push ss
DB27  57              push di
DB28  FF 36 EA D6     push word ptr [0xd6ea]
DB2C  FF 36 E8 D6     push word ptr [0xd6e8]
DB30  9A C9 07 1A 23  call far 231A:07C9
DB35  6A 03           push 3
DB37  6A 1B           push 0x1b
DB39  BF 5C DD        mov di, 0xdd5c
DB3C  1E              push ds
DB3D  57              push di
DB3E  9A 0C 03 1A 23  call far 231A:030C
DB43  C4 3E 5C DD     les di, ptr [0xdd5c]
DB47  06              push es
DB48  57              push di
DB49  C4 3E 92 D0     les di, ptr [0xd092]
DB4D  06              push es
DB4E  57              push di
DB4F  68 A0 0F        push 0xfa0
DB52  9A C2 01 AC 24  call far 24AC:01C2
DB57  C9              leave
DB58  C3              ret
; data (not reached as code), 9 bytes
DB59                  pstr 'HANG ON '

; ---- routine 0AB5:DB62  (found by: call)
sub_DB62:
DB62  55              push bp
DB63  89 E5           mov bp, sp
DB65  80 3E 74 D0 00  cmp byte ptr [0xd074], 0
DB6A  75 0E           jne 0xdb7a
DB6C  83 3E AE D0 00  cmp word ptr [0xd0ae], 0
DB71  74 07           je 0xdb7a
DB73  80 3E B9 D0 00  cmp byte ptr [0xd0b9], 0
DB78  74 02           je 0xdb7c
loc_DB7A:
DB7A  EB 42           jmp 0xdbbe
loc_DB7C:
DB7C  80 3E B8 D0 00  cmp byte ptr [0xd0b8], 0
DB81  75 23           jne 0xdba6
DB83  80 3E CC D1 00  cmp byte ptr [0xd1cc], 0
DB88  75 15           jne 0xdb9f
DB8A  6A 0E           push 0xe
DB8C  BF 59 DB        mov di, 0xdb59
DB8F  0E              push cs
DB90  57              push di
DB91  6A 19           push 0x19
DB93  6A 1E           push 0x1e
DB95  BF 58 DD        mov di, 0xdd58
DB98  1E              push ds
DB99  57              push di
DB9A  9A 1B 04 1A 23  call far 231A:041B
loc_DB9F:
DB9F  C6 06 CC D1 01  mov byte ptr [0xd1cc], 1
DBA4  EB 18           jmp 0xdbbe
loc_DBA6:
DBA6  C6 06 74 D0 01  mov byte ptr [0xd074], 1
DBAB  C6 06 75 D0 01  mov byte ptr [0xd075], 1
DBB0  C6 06 CC D1 00  mov byte ptr [0xd1cc], 0
DBB5  6A 00           push 0
DBB7  6A 01           push 1
DBB9  9A 5C 04 94 19  call far 1994:045C
loc_DBBE:
DBBE  C9              leave
DBBF  C3              ret

; ---- routine 0AB5:DBC0  (found by: call)
sub_DBC0:
DBC0  C8 0A 00 00     enter 0xa, 0
DBC4  6A 0A           push 0xa
DBC6  9A 6D 07 1A 23  call far 231A:076D
DBCB  40              inc ax
DBCC  89 46 FC        mov word ptr [bp - 4], ax
DBCF  8B 7E FC        mov di, word ptr [bp - 4]
DBD2  8A 85 00 0D     mov al, byte ptr [di + 0xd00]
DBD6  30 E4           xor ah, ah
DBD8  89 46 FA        mov word ptr [bp - 6], ax
DBDB  C6 46 FF 00     mov byte ptr [bp - 1], 0
DBDF  EB 03           jmp 0xdbe4
loc_DBE1:
DBE1  FE 46 FF        inc byte ptr [bp - 1]
loc_DBE4:
DBE4  8A 46 FF        mov al, byte ptr [bp - 1]
DBE7  98              cwde
DBE8  8B F8           mov di, ax
DBEA  8A 85 56 0D     mov al, byte ptr [di + 0xd56]
DBEE  30 E4           xor ah, ah
DBF0  8B D0           mov dx, ax
DBF2  8A 46 FF        mov al, byte ptr [bp - 1]
DBF5  98              cwde
DBF6  8B F8           mov di, ax
DBF8  D1 E7           shl di, 1
DBFA  01 53 FA        add word ptr [bp + di - 6], dx
DBFD  80 7E FF 01     cmp byte ptr [bp - 1], 1
DC01  75 DE           jne 0xdbe1
DC03  6B 7E FC 19     imul di, word ptr [bp - 4], 0x19
DC07  81 C7 EF CC     add di, 0xccef
DC0B  1E              push ds
DC0C  57              push di
DC0D  0E              push cs
DC0E  E8 90 40        call 0x11ca1
DC11  08 C0           or al, al
DC13  74 03           je 0xdc18
DC15  E9 E0 00        jmp 0xdcf8
loc_DC18:
DC18  6B 7E FA 19     imul di, word ptr [bp - 6], 0x19
DC1C  81 C7 EF CC     add di, 0xccef
DC20  1E              push ds
DC21  57              push di
DC22  0E              push cs
DC23  E8 7B 40        call 0x11ca1
DC26  08 C0           or al, al
DC28  74 03           je 0xdc2d
DC2A  E9 CB 00        jmp 0xdcf8
loc_DC2D:
DC2D  9A 3F 0D AC 24  call far 24AC:0D3F
DC32  88 46 FF        mov byte ptr [bp - 1], al
DC35  8A 46 FF        mov al, byte ptr [bp - 1]
DC38  98              cwde
DC39  8B F8           mov di, ax
DC3B  D1 E7           shl di, 1
DC3D  6B 7B FA 19     imul di, word ptr [bp + di - 6], 0x19
DC41  81 C7 EF CC     add di, 0xccef
DC45  1E              push ds
DC46  07              pop es
DC47  89 7E F6        mov word ptr [bp - 0xa], di
DC4A  8C 46 F8        mov word ptr [bp - 8], es
DC4D  6A 0E           push 0xe
DC4F  80 7E FF 00     cmp byte ptr [bp - 1], 0
DC53  B0 00           mov al, 0
DC55  75 01           jne 0xdc58
DC57  40              inc ax
loc_DC58:
DC58  98              cwde
DC59  8B F8           mov di, ax
DC5B  D1 E7           shl di, 1
DC5D  6B 7B FA 19     imul di, word ptr [bp + di - 6], 0x19
DC61  81 C7 EF CC     add di, 0xccef
DC65  1E              push ds
DC66  57              push di
DC67  0E              push cs
DC68  E8 77 3E        call 0x11ae2
DC6B  50              push ax
DC6C  6A 06           push 6
DC6E  C4 7E F6        les di, ptr [bp - 0xa]
DC71  06              push es
DC72  57              push di
DC73  0E              push cs
DC74  E8 6B 3E        call 0x11ae2
DC77  5A              pop dx
DC78  3B C2           cmp ax, dx
DC7A  73 7C           jae 0xdcf8
DC7C  6A 04           push 4
DC7E  C4 7E F6        les di, ptr [bp - 0xa]
DC81  06              push es
DC82  57              push di
DC83  0E              push cs
DC84  E8 C5 3D        call 0x11a4c
DC87  08 C0           or al, al
DC89  75 0B           jne 0xdc96
DC8B  6A 14           push 0x14
DC8D  9A 1C 0D AC 24  call far 24AC:0D1C
DC92  08 C0           or al, al
DC94  74 62           je 0xdcf8
loc_DC96:
DC96  80 7E FF 00     cmp byte ptr [bp - 1], 0
DC9A  B0 00           mov al, 0
DC9C  75 01           jne 0xdc9f
DC9E  40              inc ax
loc_DC9F:
DC9F  98              cwde
DCA0  8B F8           mov di, ax
DCA2  D1 E7           shl di, 1
DCA4  6B 7B FA 19     imul di, word ptr [bp + di - 6], 0x19
DCA8  FF B5 FD CC     push word ptr [di - 0x3303]
DCAC  9A 6C 4D 51 1B  call far 1B51:4D6C
DCB1  30 E4           xor ah, ah
DCB3  50              push ax
DCB4  9A 6D 07 1A 23  call far 231A:076D
DCB9  50              push ax
DCBA  C4 7E F6        les di, ptr [bp - 0xa]
DCBD  26 FF 75 0E     push word ptr es:[di + 0xe]
DCC1  9A 6C 4D 51 1B  call far 1B51:4D6C
DCC6  30 E4           xor ah, ah
DCC8  50              push ax
DCC9  9A 6D 07 1A 23  call far 231A:076D
DCCE  5A              pop dx
DCCF  3B C2           cmp ax, dx
DCD1  7E 25           jle 0xdcf8
DCD3  8A 46 FF        mov al, byte ptr [bp - 1]
DCD6  98              cwde
DCD7  8B F8           mov di, ax
DCD9  D1 E7           shl di, 1
DCDB  8A 43 FA        mov al, byte ptr [bp + di - 6]
DCDE  A2 A0 D0        mov byte ptr [0xd0a0], al
DCE1  80 7E FF 00     cmp byte ptr [bp - 1], 0
DCE5  B0 00           mov al, 0
DCE7  75 01           jne 0xdcea
DCE9  40              inc ax
loc_DCEA:
DCEA  98              cwde
DCEB  8B F8           mov di, ax
DCED  D1 E7           shl di, 1
DCEF  8A 43 FA        mov al, byte ptr [bp + di - 6]
DCF2  A2 9F D0        mov byte ptr [0xd09f], al
DCF5  E8 C0 8C        call 0x69b8
loc_DCF8:
DCF8  C9              leave
DCF9  C2 02 00        ret 2

