; 1-095.EXE (One-Nil 95), code segment 0AB5 (image offsets 0AB50..1993F), part 16 of 22
; packed 1-095.EXE sha256 f659fb2d334500d6901fc8d6a0f06c85c0ccda2eb4a3035ae3bb0a0004d79192 (LZEXE 0.91)
; unpacked (tools/static/unlzexe.py) sha256 8df646e017e0965a5d90a58181ca764219ad847833aad0b6cb58fc53372bfb2c
; tool: capstone 5.0.9 (pip package; core library 5.0.1280) (CS_ARCH_X86, CS_MODE_16), recursive descent from the entry point, far calls and near calls/jumps, then routine prologues (55 89 E5 / 55 8B EC / C8 iw 00) in what remains; tools/static/listing.py
; addresses are SEGMENT:OFFSET with SEGMENT the image paragraph before relocation; image offset = SEGMENT*16+OFFSET
; ---- routine 0AB5:A0A4  (found by: call)
sub_A0A4:
A0A4  C8 0A 02 00     enter 0x20a, 0
A0A8  8B 46 04        mov ax, word ptr [bp + 4]
A0AB  D1 E0           shl ax, 1
A0AD  C4 7E 06        les di, ptr [bp + 6]
A0B0  03 F8           add di, ax
A0B2  26 6B 45 FE 0F  imul ax, word ptr es:[di - 2], 0xf
A0B7  C4 3E BE D7     les di, ptr [0xd7be]
A0BB  03 F8           add di, ax
A0BD  89 7E F6        mov word ptr [bp - 0xa], di
A0C0  8C 46 F8        mov word ptr [bp - 8], es
A0C3  26 80 7D 0D 03  cmp byte ptr es:[di + 0xd], 3
A0C8  B0 00           mov al, 0
A0CA  75 01           jne 0xa0cd
A0CC  40              inc ax
loc_A0CD:
A0CD  50              push ax
A0CE  BF 68 A0        mov di, 0xa068
A0D1  0E              push cs
A0D2  57              push di
A0D3  9A 98 00 1A 23  call far 231A:0098
A0D8  08 C0           or al, al
A0DA  75 37           jne 0xa113
A0DC  8D BE F6 FD     lea di, [bp - 0x20a]
A0E0  16              push ss
A0E1  57              push di
A0E2  BF 81 A0        mov di, 0xa081
A0E5  0E              push cs
A0E6  57              push di
A0E7  9A 53 0B B9 26  call far 26B9:0B53
A0EC  8D BE F6 FE     lea di, [bp - 0x10a]
A0F0  16              push ss
A0F1  57              push di
A0F2  8B 46 04        mov ax, word ptr [bp + 4]
A0F5  D1 E0           shl ax, 1
A0F7  C4 7E 06        les di, ptr [bp + 6]
A0FA  03 F8           add di, ax
A0FC  26 FF 75 FE     push word ptr es:[di - 2]
A100  9A 3C 44 51 1B  call far 1B51:443C
A105  9A D2 0B B9 26  call far 26B9:0BD2
A10A  9A E5 06 1A 23  call far 231A:06E5
A10F  08 C0           or al, al
A111  75 03           jne 0xa116
loc_A113:
A113  E9 22 01        jmp 0xa238
loc_A116:
A116  C4 7E F6        les di, ptr [bp - 0xa]
A119  26 80 7D 0C 00  cmp byte ptr es:[di + 0xc], 0
A11E  77 03           ja 0xa123
A120  E9 BC 00        jmp 0xa1df
loc_A123:
A123  26 8A 45 09     mov al, byte ptr es:[di + 9]
A127  30 E4           xor ah, ah
A129  50              push ax
A12A  9A 9C 47 51 1B  call far 1B51:479C
A12F  89 46 FC        mov word ptr [bp - 4], ax
A132  89 56 FE        mov word ptr [bp - 2], dx
A135  C4 7E F6        les di, ptr [bp - 0xa]
A138  26 8A 45 0C     mov al, byte ptr es:[di + 0xc]
A13C  30 E4           xor ah, ah
A13E  31 D2           xor dx, dx
A140  8B 4E FC        mov cx, word ptr [bp - 4]
A143  8B 5E FE        mov bx, word ptr [bp - 2]
A146  9A 2A 0A B9 26  call far 26B9:0A2A
A14B  89 46 FC        mov word ptr [bp - 4], ax
A14E  89 56 FE        mov word ptr [bp - 2], dx
A151  8B 46 04        mov ax, word ptr [bp + 4]
A154  D1 E0           shl ax, 1
A156  C4 7E 06        les di, ptr [bp + 6]
A159  03 F8           add di, ax
A15B  26 8B 45 FE     mov ax, word ptr es:[di - 2]
A15F  C1 E0 03        shl ax, 3
A162  C4 3E BA D7     les di, ptr [0xd7ba]
A166  03 F8           add di, ax
A168  26 8A 05        mov al, byte ptr es:[di]
A16B  3A 06 BA DC     cmp al, byte ptr [0xdcba]
A16F  B0 00           mov al, 0
A171  74 01           je 0xa174
A173  40              inc ax
loc_A174:
A174  30 E4           xor ah, ah
A176  40              inc ax
A177  89 46 FA        mov word ptr [bp - 6], ax
A17A  8D BE F6 FD     lea di, [bp - 0x20a]
A17E  16              push ss
A17F  57              push di
A180  BF 8D A0        mov di, 0xa08d
A183  0E              push cs
A184  57              push di
A185  9A 53 0B B9 26  call far 26B9:0B53
A18A  8D BE F6 FE     lea di, [bp - 0x10a]
A18E  16              push ss
A18F  57              push di
A190  FF 76 FE        push word ptr [bp - 2]
A193  FF 76 FC        push word ptr [bp - 4]
A196  9A C9 07 1A 23  call far 231A:07C9
A19B  9A D2 0B B9 26  call far 26B9:0BD2
A1A0  BF 9F A0        mov di, 0xa09f
A1A3  0E              push cs
A1A4  57              push di
A1A5  9A D2 0B B9 26  call far 26B9:0BD2
A1AA  9A E5 06 1A 23  call far 231A:06E5
A1AF  08 C0           or al, al
A1B1  74 12           je 0xa1c5
A1B3  FF 76 FA        push word ptr [bp - 6]
A1B6  FF 76 FE        push word ptr [bp - 2]
A1B9  FF 76 FC        push word ptr [bp - 4]
A1BC  9A D5 37 51 1B  call far 1B51:37D5
A1C1  08 C0           or al, al
A1C3  74 02           je 0xa1c7
loc_A1C5:
A1C5  EB 71           jmp 0xa238
loc_A1C7:
A1C7  8B 4E FC        mov cx, word ptr [bp - 4]
A1CA  8B 5E FE        mov bx, word ptr [bp - 2]
A1CD  6B 46 FA 5E     imul ax, word ptr [bp - 6], 0x5e
A1D1  C4 3E C4 DC     les di, ptr [0xdcc4]
A1D5  03 F8           add di, ax
A1D7  26 01 4D DC     add word ptr es:[di - 0x24], cx
A1DB  26 11 5D DE     adc word ptr es:[di - 0x22], bx
loc_A1DF:
A1DF  8B 46 04        mov ax, word ptr [bp + 4]
A1E2  D1 E0           shl ax, 1
A1E4  C4 7E 06        les di, ptr [bp + 6]
A1E7  03 F8           add di, ax
A1E9  26 FF 75 FE     push word ptr es:[di - 2]
A1ED  C4 3E D2 D7     les di, ptr [0xd7d2]
A1F1  26 8A 45 04     mov al, byte ptr es:[di + 4]
A1F5  30 E4           xor ah, ah
A1F7  8B F8           mov di, ax
A1F9  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
A1FD  30 E4           xor ah, ah
A1FF  50              push ax
A200  6A 00           push 0
A202  FF 76 FA        push word ptr [bp - 6]
A205  6A 00           push 0
A207  9A 88 63 51 1B  call far 1B51:6388
A20C  C4 7E 06        les di, ptr [bp + 6]
A20F  06              push es
A210  57              push di
A211  FF 76 04        push word ptr [bp + 4]
A214  9A FE 66 51 1B  call far 1B51:66FE
A219  C4 3E D2 D7     les di, ptr [0xd7d2]
A21D  26 8A 45 04     mov al, byte ptr es:[di + 4]
A221  30 E4           xor ah, ah
A223  8B F8           mov di, ax
A225  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
A229  30 E4           xor ah, ah
A22B  6B C0 3E        imul ax, ax, 0x3e
A22E  C4 3E C2 D7     les di, ptr [0xd7c2]
A232  03 F8           add di, ax
A234  26 FE 4D F4     dec byte ptr es:[di - 0xc]
loc_A238:
A238  C9              leave
A239  C2 06 00        ret 6

; ---- routine 0AB5:A23C  (found by: call)
sub_A23C:
A23C  C8 06 00 00     enter 6, 0
A240  8A 46 04        mov al, byte ptr [bp + 4]
A243  98              cwde
A244  8B F8           mov di, ax
A246  D1 E7           shl di, 1
A248  6B 85 E4 D6 3E  imul ax, word ptr [di - 0x291c], 0x3e
A24D  C4 3E C2 D7     les di, ptr [0xd7c2]
A251  03 F8           add di, ax
A253  81 C7 C2 FF     add di, 0xffc2
A257  89 7E FA        mov word ptr [bp - 6], di
A25A  8C 46 FC        mov word ptr [bp - 4], es
A25D  8A 46 04        mov al, byte ptr [bp + 4]
A260  98              cwde
A261  8B F8           mov di, ax
A263  D1 E7           shl di, 1
A265  FF B5 E4 D6     push word ptr [di - 0x291c]
A269  8A 46 04        mov al, byte ptr [bp + 4]
A26C  98              cwde
A26D  8B F8           mov di, ax
A26F  D1 E7           shl di, 1
A271  8B BD E4 D6     mov di, word ptr [di - 0x291c]
A275  8A 85 85 D8     mov al, byte ptr [di - 0x277b]
A279  30 E4           xor ah, ah
A27B  8B F8           mov di, ax
A27D  8A 85 F7 93     mov al, byte ptr [di - 0x6c09]
A281  50              push ax
A282  9A 23 0C 94 19  call far 1994:0C23
A287  80 7E 04 01     cmp byte ptr [bp + 4], 1
A28B  75 29           jne 0xa2b6
A28D  6A 01           push 1
A28F  C4 7E FA        les di, ptr [bp - 6]
A292  81 C7 39 00     add di, 0x39
A296  06              push es
A297  57              push di
A298  9A D5 00 1A 23  call far 231A:00D5
A29D  8A 46 04        mov al, byte ptr [bp + 4]
A2A0  98              cwde
A2A1  8B F8           mov di, ax
A2A3  D1 E7           shl di, 1
A2A5  FF B5 E4 D6     push word ptr [di - 0x291c]
A2A9  C4 7E FA        les di, ptr [bp - 6]
A2AC  26 8A 45 39     mov al, byte ptr es:[di + 0x39]
A2B0  50              push ax
A2B1  9A 23 0C 94 19  call far 1994:0C23
loc_A2B6:
A2B6  80 7E 04 00     cmp byte ptr [bp + 4], 0
A2BA  B0 00           mov al, 0
A2BC  75 01           jne 0xa2bf
A2BE  40              inc ax
loc_A2BF:
A2BF  98              cwde
A2C0  8B F8           mov di, ax
A2C2  D1 E7           shl di, 1
A2C4  FF B5 E4 D6     push word ptr [di - 0x291c]
A2C8  9A BB 25 51 1B  call far 1B51:25BB
A2CD  50              push ax
A2CE  8A 46 04        mov al, byte ptr [bp + 4]
A2D1  98              cwde
A2D2  8B F8           mov di, ax
A2D4  8A 85 66 0C     mov al, byte ptr [di + 0xc66]
A2D8  30 E4           xor ah, ah
A2DA  50              push ax
A2DB  8A 46 04        mov al, byte ptr [bp + 4]
A2DE  98              cwde
A2DF  8B F8           mov di, ax
A2E1  D1 E7           shl di, 1
A2E3  FF B5 E4 D6     push word ptr [di - 0x291c]
A2E7  9A BB 25 51 1B  call far 1B51:25BB
A2EC  5A              pop dx
A2ED  2B C2           sub ax, dx
A2EF  5A              pop dx
A2F0  3B C2           cmp ax, dx
A2F2  7E 3F           jle 0xa333
A2F4  C7 46 FE 01 00  mov word ptr [bp - 2], 1
A2F9  EB 03           jmp 0xa2fe
loc_A2FB:
A2FB  FF 46 FE        inc word ptr [bp - 2]
loc_A2FE:
A2FE  6A 06           push 6
A300  9A 6D 07 1A 23  call far 231A:076D
A305  50              push ax
A306  C4 7E FA        les di, ptr [bp - 6]
A309  81 C7 39 00     add di, 0x39
A30D  06              push es
A30E  57              push di
A30F  9A D5 00 1A 23  call far 231A:00D5
A314  83 7E FE 02     cmp word ptr [bp - 2], 2
A318  75 E1           jne 0xa2fb
A31A  8A 46 04        mov al, byte ptr [bp + 4]
A31D  98              cwde
A31E  8B F8           mov di, ax
A320  D1 E7           shl di, 1
A322  FF B5 E4 D6     push word ptr [di - 0x291c]
A326  C4 7E FA        les di, ptr [bp - 6]
A329  26 8A 45 39     mov al, byte ptr es:[di + 0x39]
A32D  50              push ax
A32E  9A 23 0C 94 19  call far 1994:0C23
loc_A333:
A333  8A 46 04        mov al, byte ptr [bp + 4]
A336  98              cwde
A337  8B F8           mov di, ax
A339  C6 85 CC D0 00  mov byte ptr [di - 0x2f34], 0
A33E  8A 46 04        mov al, byte ptr [bp + 4]
A341  98              cwde
A342  8B F8           mov di, ax
A344  C6 85 CE D0 00  mov byte ptr [di - 0x2f32], 0
A349  C9              leave
A34A  C2 02 00        ret 2

; ---- routine 0AB5:A34D  (found by: call)
sub_A34D:
A34D  C8 06 00 00     enter 6, 0
A351  8A 46 06        mov al, byte ptr [bp + 6]
A354  98              cwde
A355  8B F8           mov di, ax
A357  D1 E7           shl di, 1
A359  6B 85 E4 D6 3E  imul ax, word ptr [di - 0x291c], 0x3e
A35E  C4 3E C2 D7     les di, ptr [0xd7c2]
A362  03 F8           add di, ax
A364  81 C7 C2 FF     add di, 0xffc2
A368  89 7E FA        mov word ptr [bp - 6], di
A36B  8C 46 FC        mov word ptr [bp - 4], es
A36E  8A 46 06        mov al, byte ptr [bp + 6]
A371  50              push ax
A372  E8 C7 FE        call 0xa23c
A375  C7 46 FE 01 00  mov word ptr [bp - 2], 1
A37A  EB 03           jmp 0xa37f
loc_A37C:
A37C  FF 46 FE        inc word ptr [bp - 2]
loc_A37F:
A37F  80 7E 08 00     cmp byte ptr [bp + 8], 0
A383  74 18           je 0xa39d
A385  6A 06           push 6
A387  9A 6D 07 1A 23  call far 231A:076D
A38C  50              push ax
A38D  C4 7E FA        les di, ptr [bp - 6]
A390  81 C7 39 00     add di, 0x39
A394  06              push es
A395  57              push di
A396  9A D5 00 1A 23  call far 231A:00D5
A39B  EB 16           jmp 0xa3b3
loc_A39D:
A39D  6A 06           push 6
A39F  9A 6D 07 1A 23  call far 231A:076D
A3A4  50              push ax
A3A5  C4 7E FA        les di, ptr [bp - 6]
A3A8  81 C7 39 00     add di, 0x39
A3AC  06              push es
A3AD  57              push di
A3AE  9A F8 00 1A 23  call far 231A:00F8
loc_A3B3:
A3B3  83 7E FE 03     cmp word ptr [bp - 2], 3
A3B7  75 C3           jne 0xa37c
A3B9  8A 46 06        mov al, byte ptr [bp + 6]
A3BC  98              cwde
A3BD  8B F8           mov di, ax
A3BF  D1 E7           shl di, 1
A3C1  FF B5 E4 D6     push word ptr [di - 0x291c]
A3C5  C4 7E FA        les di, ptr [bp - 6]
A3C8  26 8A 45 39     mov al, byte ptr es:[di + 0x39]
A3CC  50              push ax
A3CD  9A 23 0C 94 19  call far 1994:0C23
A3D2  C9              leave
A3D3  C2 06 00        ret 6

; ---- routine 0AB5:A3D6  (found by: call)
sub_A3D6:
A3D6  C8 06 00 00     enter 6, 0
A3DA  8A 46 06        mov al, byte ptr [bp + 6]
A3DD  98              cwde
A3DE  8B F8           mov di, ax
A3E0  D1 E7           shl di, 1
A3E2  6B 85 E4 D6 3E  imul ax, word ptr [di - 0x291c], 0x3e
A3E7  C4 3E C2 D7     les di, ptr [0xd7c2]
A3EB  03 F8           add di, ax
A3ED  81 C7 C2 FF     add di, 0xffc2
A3F1  89 7E FA        mov word ptr [bp - 6], di
A3F4  8C 46 FC        mov word ptr [bp - 4], es
A3F7  8A 46 06        mov al, byte ptr [bp + 6]
A3FA  98              cwde
A3FB  8B F8           mov di, ax
A3FD  80 BD CC D0 00  cmp byte ptr [di - 0x2f34], 0
A402  74 02           je 0xa406
A404  EB 5A           jmp 0xa460
loc_A406:
A406  C7 46 FE 01 00  mov word ptr [bp - 2], 1
A40B  EB 03           jmp 0xa410
loc_A40D:
A40D  FF 46 FE        inc word ptr [bp - 2]
loc_A410:
A410  6A 05           push 5
A412  9A 6D 07 1A 23  call far 231A:076D
A417  50              push ax
A418  C4 7E FA        les di, ptr [bp - 6]
A41B  81 C7 39 00     add di, 0x39
A41F  06              push es
A420  57              push di
A421  9A D5 00 1A 23  call far 231A:00D5
A426  83 7E FE 05     cmp word ptr [bp - 2], 5
A42A  75 E1           jne 0xa40d
A42C  6A 06           push 6
A42E  C4 7E FA        les di, ptr [bp - 6]
A431  81 C7 39 00     add di, 0x39
A435  06              push es
A436  57              push di
A437  9A D5 00 1A 23  call far 231A:00D5
A43C  8A 46 06        mov al, byte ptr [bp + 6]
A43F  98              cwde
A440  8B F8           mov di, ax
A442  D1 E7           shl di, 1
A444  FF B5 E4 D6     push word ptr [di - 0x291c]
A448  C4 7E FA        les di, ptr [bp - 6]
A44B  26 8A 45 39     mov al, byte ptr es:[di + 0x39]
A44F  50              push ax
A450  9A 23 0C 94 19  call far 1994:0C23
A455  8A 46 06        mov al, byte ptr [bp + 6]
A458  98              cwde
A459  8B F8           mov di, ax
A45B  C6 85 CC D0 01  mov byte ptr [di - 0x2f34], 1
loc_A460:
A460  C9              leave
A461  C2 04 00        ret 4

; ---- routine 0AB5:A464  (found by: call)
sub_A464:
A464  C8 06 00 00     enter 6, 0
A468  8A 46 06        mov al, byte ptr [bp + 6]
A46B  98              cwde
A46C  8B F8           mov di, ax
A46E  D1 E7           shl di, 1
A470  6B 85 E4 D6 3E  imul ax, word ptr [di - 0x291c], 0x3e
A475  C4 3E C2 D7     les di, ptr [0xd7c2]
A479  03 F8           add di, ax
A47B  81 C7 C2 FF     add di, 0xffc2
A47F  89 7E FA        mov word ptr [bp - 6], di
A482  8C 46 FC        mov word ptr [bp - 4], es
A485  8A 46 06        mov al, byte ptr [bp + 6]
A488  98              cwde
A489  8B F8           mov di, ax
A48B  80 BD CE D0 00  cmp byte ptr [di - 0x2f32], 0
A490  74 02           je 0xa494
A492  EB 5A           jmp 0xa4ee
loc_A494:
A494  C7 46 FE 01 00  mov word ptr [bp - 2], 1
A499  EB 03           jmp 0xa49e
loc_A49B:
A49B  FF 46 FE        inc word ptr [bp - 2]
loc_A49E:
A49E  6A 05           push 5
A4A0  9A 6D 07 1A 23  call far 231A:076D
A4A5  50              push ax
A4A6  C4 7E FA        les di, ptr [bp - 6]
A4A9  81 C7 39 00     add di, 0x39
A4AD  06              push es
A4AE  57              push di
A4AF  9A F8 00 1A 23  call far 231A:00F8
A4B4  83 7E FE 05     cmp word ptr [bp - 2], 5
A4B8  75 E1           jne 0xa49b
A4BA  6A 06           push 6
A4BC  C4 7E FA        les di, ptr [bp - 6]
A4BF  81 C7 39 00     add di, 0x39
A4C3  06              push es
A4C4  57              push di
A4C5  9A F8 00 1A 23  call far 231A:00F8
A4CA  8A 46 06        mov al, byte ptr [bp + 6]
A4CD  98              cwde
A4CE  8B F8           mov di, ax
A4D0  D1 E7           shl di, 1
A4D2  FF B5 E4 D6     push word ptr [di - 0x291c]
A4D6  C4 7E FA        les di, ptr [bp - 6]
A4D9  26 8A 45 39     mov al, byte ptr es:[di + 0x39]
A4DD  50              push ax
A4DE  9A 23 0C 94 19  call far 1994:0C23
A4E3  8A 46 06        mov al, byte ptr [bp + 6]
A4E6  98              cwde
A4E7  8B F8           mov di, ax
A4E9  C6 85 CE D0 01  mov byte ptr [di - 0x2f32], 1
loc_A4EE:
A4EE  C9              leave
A4EF  C2 04 00        ret 4

; ---- routine 0AB5:A4F2  (found by: call)
sub_A4F2:
A4F2  C8 02 00 00     enter 2, 0
A4F6  A0 C5 D0        mov al, byte ptr [0xd0c5]
A4F9  98              cwde
A4FA  8B D0           mov dx, ax
A4FC  A0 C4 D0        mov al, byte ptr [0xd0c4]
A4FF  98              cwde
A500  2B C2           sub ax, dx
A502  88 46 FF        mov byte ptr [bp - 1], al
A505  C6 46 FE 00     mov byte ptr [bp - 2], 0
A509  EB 03           jmp 0xa50e
loc_A50B:
A50B  FE 46 FE        inc byte ptr [bp - 2]
loc_A50E:
A50E  8A 46 FE        mov al, byte ptr [bp - 2]
A511  98              cwde
A512  8B F8           mov di, ax
A514  D1 E7           shl di, 1
A516  FF B5 E4 D6     push word ptr [di - 0x291c]
A51A  9A DA 0D 51 1B  call far 1B51:0DDA
A51F  08 C0           or al, al
A521  74 03           je 0xa526
A523  E9 8B 00        jmp 0xa5b1
loc_A526:
A526  8A 46 FF        mov al, byte ptr [bp - 1]
A529  98              cwde
A52A  99              cdq
A52B  31 D0           xor ax, dx
A52D  29 D0           sub ax, dx
A52F  3D 02 00        cmp ax, 2
A532  7D 09           jge 0xa53d
A534  8A 46 FE        mov al, byte ptr [bp - 2]
A537  50              push ax
A538  E8 01 FD        call 0xa23c
A53B  EB 74           jmp 0xa5b1
loc_A53D:
A53D  8A 46 FF        mov al, byte ptr [bp - 1]
A540  98              cwde
A541  99              cdq
A542  31 D0           xor ax, dx
A544  29 D0           sub ax, dx
A546  3D 02 00        cmp ax, 2
A549  75 36           jne 0xa581
A54B  80 7E FE 00     cmp byte ptr [bp - 2], 0
A54F  B0 00           mov al, 0
A551  75 01           jne 0xa554
A553  40              inc ax
loc_A554:
A554  98              cwde
A555  8B F8           mov di, ax
A557  8A 95 C4 D0     mov dl, byte ptr [di - 0x2f3c]
A55B  8A 46 FE        mov al, byte ptr [bp - 2]
A55E  98              cwde
A55F  8B F8           mov di, ax
A561  8A 85 C4 D0     mov al, byte ptr [di - 0x2f3c]
A565  3A C2           cmp al, dl
A567  76 0C           jbe 0xa575
A569  6A 00           push 0
A56B  8A 46 FE        mov al, byte ptr [bp - 2]
A56E  50              push ax
A56F  55              push bp
A570  E8 DA FD        call 0xa34d
A573  EB 0A           jmp 0xa57f
loc_A575:
A575  6A 01           push 1
A577  8A 46 FE        mov al, byte ptr [bp - 2]
A57A  50              push ax
A57B  55              push bp
A57C  E8 CE FD        call 0xa34d
loc_A57F:
A57F  EB 30           jmp 0xa5b1
loc_A581:
A581  80 7E FE 00     cmp byte ptr [bp - 2], 0
A585  B0 00           mov al, 0
A587  75 01           jne 0xa58a
A589  40              inc ax
loc_A58A:
A58A  98              cwde
A58B  8B F8           mov di, ax
A58D  8A 95 C4 D0     mov dl, byte ptr [di - 0x2f3c]
A591  8A 46 FE        mov al, byte ptr [bp - 2]
A594  98              cwde
A595  8B F8           mov di, ax
A597  8A 85 C4 D0     mov al, byte ptr [di - 0x2f3c]
A59B  3A C2           cmp al, dl
A59D  76 0A           jbe 0xa5a9
A59F  8A 46 FE        mov al, byte ptr [bp - 2]
A5A2  50              push ax
A5A3  55              push bp
A5A4  E8 BD FE        call 0xa464
A5A7  EB 08           jmp 0xa5b1
loc_A5A9:
A5A9  8A 46 FE        mov al, byte ptr [bp - 2]
A5AC  50              push ax
A5AD  55              push bp
A5AE  E8 25 FE        call 0xa3d6
loc_A5B1:
A5B1  80 7E FE 01     cmp byte ptr [bp - 2], 1
A5B5  74 03           je 0xa5ba
A5B7  E9 51 FF        jmp 0xa50b
loc_A5BA:
A5BA  C9              leave
A5BB  C2 02 00        ret 2

; ---- routine 0AB5:A5BE  (found by: call)
sub_A5BE:
A5BE  C8 02 00 00     enter 2, 0
A5C2  C7 46 FE 02 00  mov word ptr [bp - 2], 2
A5C7  EB 03           jmp 0xa5cc
loc_A5C9:
A5C9  FF 46 FE        inc word ptr [bp - 2]
loc_A5CC:
A5CC  8B 46 FE        mov ax, word ptr [bp - 2]
A5CF  D1 E0           shl ax, 1
A5D1  8B 7E 04        mov di, word ptr [bp + 4]
A5D4  36 C4 7D 06     les di, ptr ss:[di + 6]
A5D8  03 F8           add di, ax
A5DA  26 FF 75 FE     push word ptr es:[di - 2]
A5DE  9A E9 4E 51 1B  call far 1B51:4EE9
A5E3  08 C0           or al, al
A5E5  75 22           jne 0xa609
A5E7  8B 46 FE        mov ax, word ptr [bp - 2]
A5EA  D1 E0           shl ax, 1
A5EC  8B 7E 04        mov di, word ptr [bp + 4]
A5EF  36 C4 7D 06     les di, ptr ss:[di + 6]
A5F3  03 F8           add di, ax
A5F5  26 8B 45 FE     mov ax, word ptr es:[di - 2]
A5F9  C1 E0 03        shl ax, 3
A5FC  C4 3E BA D7     les di, ptr [0xd7ba]
A600  03 F8           add di, ax
A602  26 C6 45 06 00  mov byte ptr es:[di + 6], 0
A607  EB 06           jmp 0xa60f
loc_A609:
A609  83 7E FE 0B     cmp word ptr [bp - 2], 0xb
A60D  75 BA           jne 0xa5c9
loc_A60F:
A60F  C9              leave
A610  C2 02 00        ret 2

; ---- routine 0AB5:A613  (found by: call)
sub_A613:
A613  C8 12 00 00     enter 0x12, 0
A617  8D 7E EE        lea di, [bp - 0x12]
A61A  16              push ss
A61B  57              push di
A61C  6A 0E           push 0xe
A61E  6A 00           push 0
A620  9A 22 02 AC 24  call far 24AC:0222
A625  C7 46 FE 01 00  mov word ptr [bp - 2], 1
A62A  EB 03           jmp 0xa62f
loc_A62C:
A62C  FF 46 FE        inc word ptr [bp - 2]
loc_A62F:
A62F  8B 46 FE        mov ax, word ptr [bp - 2]
A632  D1 E0           shl ax, 1
A634  8B 7E 04        mov di, word ptr [bp + 4]
A637  36 C4 7D 06     les di, ptr ss:[di + 6]
A63B  03 F8           add di, ax
A63D  26 FF 75 FE     push word ptr es:[di - 2]
A641  9A E9 4E 51 1B  call far 1B51:4EE9
A646  08 C0           or al, al
A648  75 26           jne 0xa670
A64A  8B 46 FE        mov ax, word ptr [bp - 2]
A64D  D1 E0           shl ax, 1
A64F  8B 7E 04        mov di, word ptr [bp + 4]
A652  36 C4 7D 06     les di, ptr ss:[di + 6]
A656  03 F8           add di, ax
A658  26 8B 45 FE     mov ax, word ptr es:[di - 2]
A65C  C1 E0 03        shl ax, 3
A65F  C4 3E BA D7     les di, ptr [0xd7ba]
A663  03 F8           add di, ax
A665  26 8A 45 06     mov al, byte ptr es:[di + 6]
A669  30 E4           xor ah, ah
A66B  8B F8           mov di, ax
A66D  FE 43 EE        inc byte ptr [bp + di - 0x12]
loc_A670:
A670  83 7E FE 0B     cmp word ptr [bp - 2], 0xb
A674  75 B6           jne 0xa62c
A676  31 C0           xor ax, ax
A678  89 46 FC        mov word ptr [bp - 4], ax
A67B  83 7E 06 02     cmp word ptr [bp + 6], 2
A67F  B0 00           mov al, 0
A681  75 01           jne 0xa684
A683  40              inc ax
loc_A684:
A684  30 E4           xor ah, ah
A686  40              inc ax
A687  3D 05 00        cmp ax, 5
A68A  77 36           ja 0xa6c2
A68C  89 46 FE        mov word ptr [bp - 2], ax
A68F  EB 03           jmp 0xa694
loc_A691:
A691  FF 46 FE        inc word ptr [bp - 2]
loc_A694:
A694  8B 7E FE        mov di, word ptr [bp - 2]
A697  8A 85 67 0C     mov al, byte ptr [di + 0xc67]
A69B  30 E4           xor ah, ah
A69D  8B F8           mov di, ax
A69F  8A 43 EE        mov al, byte ptr [bp + di - 0x12]
A6A2  8B 7E FE        mov di, word ptr [bp - 2]
A6A5  3A 85 6D 0C     cmp al, byte ptr [di + 0xc6d]
A6A9  76 11           jbe 0xa6bc
A6AB  8B 7E FE        mov di, word ptr [bp - 2]
A6AE  8A 85 67 0C     mov al, byte ptr [di + 0xc67]
A6B2  30 E4           xor ah, ah
A6B4  89 46 FC        mov word ptr [bp - 4], ax
A6B7  C7 46 FE 05 00  mov word ptr [bp - 2], 5
loc_A6BC:
A6BC  83 7E FE 05     cmp word ptr [bp - 2], 5
A6C0  75 CF           jne 0xa691
loc_A6C2:
A6C2  83 7E FC 00     cmp word ptr [bp - 4], 0
A6C6  74 75           je 0xa73d
A6C8  C7 46 FE 01 00  mov word ptr [bp - 2], 1
A6CD  EB 03           jmp 0xa6d2
loc_A6CF:
A6CF  FF 46 FE        inc word ptr [bp - 2]
loc_A6D2:
A6D2  8B 46 FE        mov ax, word ptr [bp - 2]
A6D5  D1 E0           shl ax, 1
A6D7  8B 7E 04        mov di, word ptr [bp + 4]
A6DA  36 C4 7D 06     les di, ptr ss:[di + 6]
A6DE  03 F8           add di, ax
A6E0  26 8B 45 FE     mov ax, word ptr es:[di - 2]
A6E4  C1 E0 03        shl ax, 3
A6E7  C4 3E BA D7     les di, ptr [0xd7ba]
A6EB  03 F8           add di, ax
A6ED  26 8A 45 06     mov al, byte ptr es:[di + 6]
A6F1  30 E4           xor ah, ah
A6F3  3B 46 FC        cmp ax, word ptr [bp - 4]
A6F6  75 3F           jne 0xa737
A6F8  8B 46 FE        mov ax, word ptr [bp - 2]
A6FB  D1 E0           shl ax, 1
A6FD  8B 7E 04        mov di, word ptr [bp + 4]
A700  36 C4 7D 06     les di, ptr ss:[di + 6]
A704  03 F8           add di, ax
A706  26 FF 75 FE     push word ptr es:[di - 2]
A70A  9A E9 4E 51 1B  call far 1B51:4EE9
A70F  08 C0           or al, al
A711  75 24           jne 0xa737
A713  8A 56 06        mov dl, byte ptr [bp + 6]
A716  8B 46 FE        mov ax, word ptr [bp - 2]
A719  D1 E0           shl ax, 1
A71B  8B 7E 04        mov di, word ptr [bp + 4]
A71E  36 C4 7D 06     les di, ptr ss:[di + 6]
A722  03 F8           add di, ax
A724  26 8B 45 FE     mov ax, word ptr es:[di - 2]
A728  C1 E0 03        shl ax, 3
A72B  C4 3E BA D7     les di, ptr [0xd7ba]
A72F  03 F8           add di, ax
A731  26 88 55 06     mov byte ptr es:[di + 6], dl
A735  EB 06           jmp 0xa73d
loc_A737:
A737  83 7E FE 0B     cmp word ptr [bp - 2], 0xb
A73B  75 92           jne 0xa6cf
loc_A73D:
A73D  C9              leave
A73E  C2 04 00        ret 4

; ---- routine 0AB5:A741  (found by: call)
sub_A741:
A741  C8 02 00 00     enter 2, 0
A745  C7 46 FE 01 00  mov word ptr [bp - 2], 1
A74A  EB 03           jmp 0xa74f
loc_A74C:
A74C  FF 46 FE        inc word ptr [bp - 2]
loc_A74F:
A74F  8B 46 FE        mov ax, word ptr [bp - 2]
A752  D1 E0           shl ax, 1
A754  8B 7E 04        mov di, word ptr [bp + 4]
A757  36 C4 7D 06     les di, ptr ss:[di + 6]
A75B  03 F8           add di, ax
A75D  26 FF 75 FE     push word ptr es:[di - 2]
A761  9A E9 4E 51 1B  call far 1B51:4EE9
A766  08 C0           or al, al
A768  75 47           jne 0xa7b1
A76A  8B 46 FE        mov ax, word ptr [bp - 2]
A76D  D1 E0           shl ax, 1
A76F  8B 7E 04        mov di, word ptr [bp + 4]
A772  36 C4 7D 06     les di, ptr ss:[di + 6]
A776  03 F8           add di, ax
A778  26 8B 45 FE     mov ax, word ptr es:[di - 2]
A77C  C1 E0 03        shl ax, 3
A77F  C4 3E BA D7     les di, ptr [0xd7ba]
A783  03 F8           add di, ax
A785  26 8A 45 06     mov al, byte ptr es:[di + 6]
A789  3C 03           cmp al, 3
A78B  72 24           jb 0xa7b1
A78D  3C 04           cmp al, 4
A78F  77 20           ja 0xa7b1
A791  8B 46 FE        mov ax, word ptr [bp - 2]
A794  D1 E0           shl ax, 1
A796  8B 7E 04        mov di, word ptr [bp + 4]
A799  36 C4 7D 06     les di, ptr ss:[di + 6]
A79D  03 F8           add di, ax
A79F  26 8B 45 FE     mov ax, word ptr es:[di - 2]
A7A3  C1 E0 03        shl ax, 3
A7A6  C4 3E BA D7     les di, ptr [0xd7ba]
A7AA  03 F8           add di, ax
A7AC  26 C6 45 06 02  mov byte ptr es:[di + 6], 2
loc_A7B1:
A7B1  83 7E FE 0B     cmp word ptr [bp - 2], 0xb
A7B5  75 95           jne 0xa74c
A7B7  C9              leave
A7B8  C2 02 00        ret 2

; ---- routine 0AB5:A7BB  (found by: call)
sub_A7BB:
A7BB  C8 02 00 00     enter 2, 0
A7BF  C7 46 FE 01 00  mov word ptr [bp - 2], 1
A7C4  EB 03           jmp 0xa7c9
loc_A7C6:
A7C6  FF 46 FE        inc word ptr [bp - 2]
loc_A7C9:
A7C9  8B 46 FE        mov ax, word ptr [bp - 2]
A7CC  D1 E0           shl ax, 1
A7CE  8B 7E 04        mov di, word ptr [bp + 4]
A7D1  36 C4 7D 06     les di, ptr ss:[di + 6]
A7D5  03 F8           add di, ax
A7D7  26 8B 45 FE     mov ax, word ptr es:[di - 2]
A7DB  C1 E0 03        shl ax, 3
A7DE  C4 3E BA D7     les di, ptr [0xd7ba]
A7E2  03 F8           add di, ax
A7E4  26 8A 45 06     mov al, byte ptr es:[di + 6]
A7E8  3C 09           cmp al, 9
A7EA  72 41           jb 0xa82d
A7EC  3C 0B           cmp al, 0xb
A7EE  77 3D           ja 0xa82d
A7F0  8B 46 FE        mov ax, word ptr [bp - 2]
A7F3  D1 E0           shl ax, 1
A7F5  8B 7E 04        mov di, word ptr [bp + 4]
A7F8  36 C4 7D 06     les di, ptr ss:[di + 6]
A7FC  03 F8           add di, ax
A7FE  26 FF 75 FE     push word ptr es:[di - 2]
A802  9A E9 4E 51 1B  call far 1B51:4EE9
A807  08 C0           or al, al
A809  75 22           jne 0xa82d
A80B  8B 46 FE        mov ax, word ptr [bp - 2]
A80E  D1 E0           shl ax, 1
A810  8B 7E 04        mov di, word ptr [bp + 4]
A813  36 C4 7D 06     les di, ptr ss:[di + 6]
A817  03 F8           add di, ax
A819  26 8B 45 FE     mov ax, word ptr es:[di - 2]
A81D  C1 E0 03        shl ax, 3
A820  C4 3E BA D7     les di, ptr [0xd7ba]
A824  03 F8           add di, ax
A826  26 C6 45 06 0D  mov byte ptr es:[di + 6], 0xd
A82B  EB 06           jmp 0xa833
loc_A82D:
A82D  83 7E FE 0B     cmp word ptr [bp - 2], 0xb
A831  75 93           jne 0xa7c6
loc_A833:
A833  C9              leave
A834  C2 02 00        ret 2

; ---- routine 0AB5:A837  (found by: call)
sub_A837:
A837  55              push bp
A838  89 E5           mov bp, sp
A83A  6B 7E 04 19     imul di, word ptr [bp + 4], 0x19
A83E  8B 85 FD CC     mov ax, word ptr [di - 0x3303]
A842  C1 E0 03        shl ax, 3
A845  C4 3E BA D7     les di, ptr [0xd7ba]
A849  03 F8           add di, ax
A84B  26 8A 45 06     mov al, byte ptr es:[di + 6]
A84F  3C 00           cmp al, 0
A851  75 06           jne 0xa859
A853  55              push bp
A854  E8 67 FD        call 0xa5be
A857  EB 40           jmp 0xa899
loc_A859:
A859  3C 01           cmp al, 1
A85B  74 04           je 0xa861
A85D  3C 02           cmp al, 2
A85F  75 1E           jne 0xa87f
loc_A861:
A861  6B 7E 04 19     imul di, word ptr [bp + 4], 0x19
A865  8B 85 FD CC     mov ax, word ptr [di - 0x3303]
A869  C1 E0 03        shl ax, 3
A86C  C4 3E BA D7     les di, ptr [0xd7ba]
A870  03 F8           add di, ax
A872  26 8A 45 06     mov al, byte ptr es:[di + 6]
A876  30 E4           xor ah, ah
A878  50              push ax
A879  55              push bp
A87A  E8 96 FD        call 0xa613
A87D  EB 1A           jmp 0xa899
loc_A87F:
A87F  3C 03           cmp al, 3
A881  74 04           je 0xa887
A883  3C 04           cmp al, 4
A885  75 06           jne 0xa88d
loc_A887:
A887  55              push bp
A888  E8 B6 FE        call 0xa741
A88B  EB 0C           jmp 0xa899
loc_A88D:
A88D  3C 0D           cmp al, 0xd
A88F  74 04           je 0xa895
A891  3C 0C           cmp al, 0xc
A893  75 04           jne 0xa899
loc_A895:
A895  55              push bp
A896  E8 22 FF        call 0xa7bb
loc_A899:
A899  E8 B3 6D        call 0x1164f
A89C  C9              leave
A89D  C2 06 00        ret 6

; ---- routine 0AB5:A8A0  (found by: call)
sub_A8A0:
A8A0  C8 04 00 00     enter 4, 0
A8A4  9A 76 0B 94 19  call far 1994:0B76
A8A9  89 46 FC        mov word ptr [bp - 4], ax
A8AC  B8 0C 00        mov ax, 0xc
A8AF  3B 46 FC        cmp ax, word ptr [bp - 4]
A8B2  76 03           jbe 0xa8b7
A8B4  E9 90 00        jmp 0xa947
loc_A8B7:
A8B7  89 46 FE        mov word ptr [bp - 2], ax
A8BA  EB 03           jmp 0xa8bf
loc_A8BC:
A8BC  FF 46 FE        inc word ptr [bp - 2]
loc_A8BF:
A8BF  8B 7E 04        mov di, word ptr [bp + 4]
A8C2  36 8A 45 06     mov al, byte ptr ss:[di + 6]
A8C6  98              cwde
A8C7  8B F8           mov di, ax
A8C9  8A 85 56 0D     mov al, byte ptr [di + 0xd56]
A8CD  30 E4           xor ah, ah
A8CF  8B D0           mov dx, ax
A8D1  8B 7E 04        mov di, word ptr [bp + 4]
A8D4  36 8B 45 08     mov ax, word ptr ss:[di + 8]
A8D8  2B C2           sub ax, dx
A8DA  6B F8 19        imul di, ax, 0x19
A8DD  8B 95 FD CC     mov dx, word ptr [di - 0x3303]
A8E1  8B 46 FE        mov ax, word ptr [bp - 2]
A8E4  D1 E0           shl ax, 1
A8E6  8B 7E 04        mov di, word ptr [bp + 4]
A8E9  36 C4 7D 0A     les di, ptr ss:[di + 0xa]
A8ED  03 F8           add di, ax
A8EF  26 8B 45 FE     mov ax, word ptr es:[di - 2]
A8F3  3B C2           cmp ax, dx
A8F5  74 45           je 0xa93c
A8F7  8B 46 FE        mov ax, word ptr [bp - 2]
A8FA  D1 E0           shl ax, 1
A8FC  8B 7E 04        mov di, word ptr [bp + 4]
A8FF  36 C4 7D 0A     les di, ptr ss:[di + 0xa]
A903  03 F8           add di, ax
A905  26 FF 75 FE     push word ptr es:[di - 2]
A909  9A E9 4E 51 1B  call far 1B51:4EE9
A90E  08 C0           or al, al
A910  75 2A           jne 0xa93c
A912  8A 56 FE        mov dl, byte ptr [bp - 2]
A915  8B 46 FE        mov ax, word ptr [bp - 2]
A918  D1 E0           shl ax, 1
A91A  8B 7E 04        mov di, word ptr [bp + 4]
A91D  36 C4 7D 0A     les di, ptr ss:[di + 0xa]
A921  03 F8           add di, ax
A923  26 8B 45 FE     mov ax, word ptr es:[di - 2]
A927  C1 E0 03        shl ax, 3
A92A  C4 3E BA D7     les di, ptr [0xd7ba]
A92E  03 F8           add di, ax
A930  26 8A 45 07     mov al, byte ptr es:[di + 7]
A934  30 E4           xor ah, ah
A936  8B F8           mov di, ax
A938  88 95 76 D0     mov byte ptr [di - 0x2f8a], dl
loc_A93C:
A93C  8B 46 FE        mov ax, word ptr [bp - 2]
A93F  3B 46 FC        cmp ax, word ptr [bp - 4]
A942  74 03           je 0xa947
A944  E9 75 FF        jmp 0xa8bc
loc_A947:
A947  C9              leave
A948  C2 02 00        ret 2

; ---- routine 0AB5:A94B  (found by: call)
sub_A94B:
A94B  C8 08 00 00     enter 8, 0
A94F  80 3E DD D6 00  cmp byte ptr [0xd6dd], 0
A954  74 25           je 0xa97b
A956  6B 7E 08 19     imul di, word ptr [bp + 8], 0x19
A95A  8B 85 FD CC     mov ax, word ptr [di - 0x3303]
A95E  C1 E0 03        shl ax, 3
A961  C4 3E BA D7     les di, ptr [0xd7ba]
A965  03 F8           add di, ax
A967  26 80 7D 06 00  cmp byte ptr es:[di + 6], 0
A96C  75 0D           jne 0xa97b
A96E  8A 46 06        mov al, byte ptr [bp + 6]
A971  98              cwde
A972  8B F8           mov di, ax
A974  80 BD DE D6 00  cmp byte ptr [di - 0x2922], 0
A979  74 04           je 0xa97f
loc_A97B:
A97B  B0 00           mov al, 0
A97D  EB 02           jmp 0xa981
loc_A97F:
A97F  B0 01           mov al, 1
loc_A981:
A981  88 46 FD        mov byte ptr [bp - 3], al
A984  8A 46 FD        mov al, byte ptr [bp - 3]
A987  30 E4           xor ah, ah
A989  8B D0           mov dx, ax
A98B  8A 46 06        mov al, byte ptr [bp + 6]
A98E  98              cwde
A98F  8B F8           mov di, ax
A991  8A 85 E0 D6     mov al, byte ptr [di - 0x2920]
A995  30 E4           xor ah, ah
A997  03 C2           add ax, dx
A999  09 C0           or ax, ax
A99B  75 3A           jne 0xa9d7
A99D  8A 46 06        mov al, byte ptr [bp + 6]
A9A0  98              cwde
A9A1  8B F8           mov di, ax
A9A3  8A 85 56 0D     mov al, byte ptr [di + 0xd56]
A9A7  30 E4           xor ah, ah
A9A9  8B D0           mov dx, ax
A9AB  8B 46 08        mov ax, word ptr [bp + 8]
A9AE  2B C2           sub ax, dx
A9B0  D1 E0           shl ax, 1
A9B2  C4 7E 0A        les di, ptr [bp + 0xa]
A9B5  03 F8           add di, ax
A9B7  26 6B 45 FE 0F  imul ax, word ptr es:[di - 2], 0xf
A9BC  C4 3E BE D7     les di, ptr [0xd7be]
A9C0  03 F8           add di, ax
A9C2  26 80 7D 08 01  cmp byte ptr es:[di + 8], 1
A9C7  7D 0E           jge 0xa9d7
A9C9  C4 7E 0A        les di, ptr [bp + 0xa]
A9CC  06              push es
A9CD  57              push di
A9CE  FF 76 08        push word ptr [bp + 8]
A9D1  E8 63 FE        call 0xa837
A9D4  E9 DB 01        jmp 0xabb2
loc_A9D7:
A9D7  8A 46 FD        mov al, byte ptr [bp - 3]
A9DA  30 E4           xor ah, ah
A9DC  8B D0           mov dx, ax
A9DE  8A 46 06        mov al, byte ptr [bp + 6]
A9E1  98              cwde
A9E2  8B F8           mov di, ax
A9E4  8A 85 E0 D6     mov al, byte ptr [di - 0x2920]
A9E8  30 E4           xor ah, ah
A9EA  03 C2           add ax, dx
A9EC  09 C0           or ax, ax
A9EE  7F 03           jg 0xa9f3
A9F0  E9 BF 01        jmp 0xabb2
loc_A9F3:
A9F3  BF 76 D0        mov di, 0xd076
A9F6  1E              push ds
A9F7  57              push di
A9F8  6A 0E           push 0xe
A9FA  6A 00           push 0
A9FC  9A 22 02 AC 24  call far 24AC:0222
AA01  55              push bp
AA02  E8 9B FE        call 0xa8a0
AA05  6B 7E 08 19     imul di, word ptr [bp + 8], 0x19
AA09  FF B5 FD CC     push word ptr [di - 0x3303]
AA0D  C4 7E 0A        les di, ptr [bp + 0xa]
AA10  06              push es
AA11  57              push di
AA12  0E              push cs
AA13  E8 6C EE        call 0x9882
AA16  89 46 FE        mov word ptr [bp - 2], ax
AA19  83 7E FE 00     cmp word ptr [bp - 2], 0
AA1D  75 56           jne 0xaa75
AA1F  80 7E 04 00     cmp byte ptr [bp + 4], 0
AA23  75 25           jne 0xaa4a
AA25  6B 7E 08 19     imul di, word ptr [bp + 8], 0x19
AA29  8B 85 FD CC     mov ax, word ptr [di - 0x3303]
AA2D  C1 E0 03        shl ax, 3
AA30  C4 3E BA D7     les di, ptr [0xd7ba]
AA34  03 F8           add di, ax
AA36  26 80 7D 06 00  cmp byte ptr es:[di + 6], 0
AA3B  75 38           jne 0xaa75
AA3D  8A 46 06        mov al, byte ptr [bp + 6]
AA40  98              cwde
AA41  8B F8           mov di, ax
AA43  80 BD E0 D6 00  cmp byte ptr [di - 0x2920], 0
AA48  76 2B           jbe 0xaa75
loc_AA4A:
AA4A  C4 7E 0A        les di, ptr [bp + 0xa]
AA4D  06              push es
AA4E  57              push di
AA4F  9A 76 0B 94 19  call far 1994:0B76
AA54  50              push ax
AA55  6B 7E 08 19     imul di, word ptr [bp + 8], 0x19
AA59  8B 85 FD CC     mov ax, word ptr [di - 0x3303]
AA5D  C1 E0 03        shl ax, 3
AA60  C4 3E BA D7     les di, ptr [0xd7ba]
AA64  03 F8           add di, ax
AA66  26 8A 45 06     mov al, byte ptr es:[di + 6]
AA6A  30 E4           xor ah, ah
AA6C  50              push ax
AA6D  9A 6B 4F 51 1B  call far 1B51:4F6B
AA72  89 46 FE        mov word ptr [bp - 2], ax
loc_AA75:
AA75  83 7E FE 00     cmp word ptr [bp - 2], 0
AA79  75 26           jne 0xaaa1
AA7B  6B 7E 08 19     imul di, word ptr [bp + 8], 0x19
AA7F  8B 85 FD CC     mov ax, word ptr [di - 0x3303]
AA83  C1 E0 03        shl ax, 3
AA86  C4 3E BA D7     les di, ptr [0xd7ba]
AA8A  03 F8           add di, ax
AA8C  26 80 7D 06 00  cmp byte ptr es:[di + 6], 0
AA91  75 0B           jne 0xaa9e
AA93  C4 7E 0A        les di, ptr [bp + 0xa]
AA96  06              push es
AA97  57              push di
AA98  FF 76 08        push word ptr [bp + 8]
AA9B  E8 99 FD        call 0xa837
loc_AA9E:
AA9E  E9 11 01        jmp 0xabb2
loc_AAA1:
AAA1  8A 46 06        mov al, byte ptr [bp + 6]
AAA4  98              cwde
AAA5  8B F8           mov di, ax
AAA7  D1 E7           shl di, 1
AAA9  6B 85 E4 D6 3E  imul ax, word ptr [di - 0x291c], 0x3e
AAAE  C4 3E C2 D7     les di, ptr [0xd7c2]
AAB2  03 F8           add di, ax
AAB4  81 C7 C2 FF     add di, 0xffc2
AAB8  89 7E F8        mov word ptr [bp - 8], di
AABB  8C 46 FA        mov word ptr [bp - 6], es
AABE  6B 7E 08 19     imul di, word ptr [bp + 8], 0x19
AAC2  8B 85 FD CC     mov ax, word ptr [di - 0x3303]
AAC6  C1 E0 03        shl ax, 3
AAC9  C4 3E BA D7     les di, ptr [0xd7ba]
AACD  03 F8           add di, ax
AACF  26 8A 55 06     mov dl, byte ptr es:[di + 6]
AAD3  8B 46 FE        mov ax, word ptr [bp - 2]
AAD6  D1 E0           shl ax, 1
AAD8  C4 7E F8        les di, ptr [bp - 8]
AADB  03 F8           add di, ax
AADD  26 8B 45 FE     mov ax, word ptr es:[di - 2]
AAE1  C1 E0 03        shl ax, 3
AAE4  C4 3E BA D7     les di, ptr [0xd7ba]
AAE8  03 F8           add di, ax
AAEA  26 88 55 06     mov byte ptr es:[di + 6], dl
AAEE  8B 46 FE        mov ax, word ptr [bp - 2]
AAF1  D1 E0           shl ax, 1
AAF3  C4 7E F8        les di, ptr [bp - 8]
AAF6  03 F8           add di, ax
AAF8  81 C7 FE FF     add di, 0xfffe
AAFC  06              push es
AAFD  57              push di
AAFE  8A 46 06        mov al, byte ptr [bp + 6]
AB01  98              cwde
AB02  8B F8           mov di, ax
AB04  8A 85 56 0D     mov al, byte ptr [di + 0xd56]
AB08  30 E4           xor ah, ah
AB0A  8B D0           mov dx, ax
AB0C  8B 46 08        mov ax, word ptr [bp + 8]
AB0F  2B C2           sub ax, dx
AB11  D1 E0           shl ax, 1
AB13  C4 7E F8        les di, ptr [bp - 8]
AB16  03 F8           add di, ax
AB18  81 C7 FE FF     add di, 0xfffe
AB1C  06              push es
AB1D  57              push di
AB1E  6A 02           push 2
AB20  9A 03 02 AC 24  call far 24AC:0203
AB25  8B 46 FE        mov ax, word ptr [bp - 2]
AB28  D1 E0           shl ax, 1
AB2A  8B D0           mov dx, ax
AB2C  8A 46 06        mov al, byte ptr [bp + 6]
AB2F  98              cwde
AB30  6B F8 28        imul di, ax, 0x28
AB33  03 FA           add di, dx
AB35  81 C7 46 D1     add di, 0xd146
AB39  1E              push ds
AB3A  57              push di
AB3B  8A 46 06        mov al, byte ptr [bp + 6]
AB3E  98              cwde
AB3F  8B F8           mov di, ax
AB41  8A 85 56 0D     mov al, byte ptr [di + 0xd56]
AB45  30 E4           xor ah, ah
AB47  8B D0           mov dx, ax
AB49  8B 46 08        mov ax, word ptr [bp + 8]
AB4C  2B C2           sub ax, dx
AB4E  D1 E0           shl ax, 1
AB50  8B D0           mov dx, ax
AB52  8A 46 06        mov al, byte ptr [bp + 6]
AB55  98              cwde
AB56  6B F8 28        imul di, ax, 0x28
AB59  03 FA           add di, dx
AB5B  81 C7 46 D1     add di, 0xd146
AB5F  1E              push ds
AB60  57              push di
AB61  6A 02           push 2
AB63  9A 03 02 AC 24  call far 24AC:0203
AB68  8B 56 FE        mov dx, word ptr [bp - 2]
AB6B  8A 46 06        mov al, byte ptr [bp + 6]
AB6E  98              cwde
AB6F  6B F8 14        imul di, ax, 0x14
AB72  03 FA           add di, dx
AB74  81 C7 97 D1     add di, 0xd197
AB78  1E              push ds
AB79  57              push di
AB7A  8A 46 06        mov al, byte ptr [bp + 6]
AB7D  98              cwde
AB7E  8B F8           mov di, ax
AB80  8A 85 56 0D     mov al, byte ptr [di + 0xd56]
AB84  30 E4           xor ah, ah
AB86  8B D0           mov dx, ax
AB88  8B 46 08        mov ax, word ptr [bp + 8]
AB8B  2B C2           sub ax, dx
AB8D  8B D0           mov dx, ax
AB8F  8A 46 06        mov al, byte ptr [bp + 6]
AB92  98              cwde
AB93  6B F8 14        imul di, ax, 0x14
AB96  03 FA           add di, dx
AB98  81 C7 97 D1     add di, 0xd197
AB9C  1E              push ds
AB9D  57              push di
AB9E  6A 01           push 1
ABA0  9A 03 02 AC 24  call far 24AC:0203
ABA5  8A 46 06        mov al, byte ptr [bp + 6]
ABA8  50              push ax
ABA9  FF 76 08        push word ptr [bp + 8]
ABAC  FF 76 FE        push word ptr [bp - 2]
ABAF  E8 06 03        call 0xaeb8
loc_ABB2:
ABB2  C9              leave
ABB3  C2 0A 00        ret 0xa
; data (not reached as code), 35 bytes
ABB6                  pstr 'Goalkeepers cannot be repositioned'

