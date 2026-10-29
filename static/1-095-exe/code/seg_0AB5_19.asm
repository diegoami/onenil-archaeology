; 1-095.EXE (One-Nil 95), code segment 0AB5 (image offsets 0AB50..1993F), part 19 of 22
; packed 1-095.EXE sha256 f659fb2d334500d6901fc8d6a0f06c85c0ccda2eb4a3035ae3bb0a0004d79192 (LZEXE 0.91)
; unpacked (tools/static/unlzexe.py) sha256 8df646e017e0965a5d90a58181ca764219ad847833aad0b6cb58fc53372bfb2c
; tool: capstone 5.0.9 (pip package; core library 5.0.1280) (CS_ARCH_X86, CS_MODE_16), recursive descent from the entry point, far calls and near calls/jumps, then routine prologues (55 89 E5 / 55 8B EC / C8 iw 00) in what remains; tools/static/listing.py
; addresses are SEGMENT:OFFSET with SEGMENT the image paragraph before relocation; image offset = SEGMENT*16+OFFSET
; ---- routine 0AB5:C358  (found by: call)
sub_C358:
C358  C8 04 00 00     enter 4, 0
C35C  83 7E 04 00     cmp word ptr [bp + 4], 0
C360  74 60           je 0xc3c2
C362  6B 46 04 0F     imul ax, word ptr [bp + 4], 0xf
C366  C4 3E BE D7     les di, ptr [0xd7be]
C36A  03 F8           add di, ax
C36C  89 7E FC        mov word ptr [bp - 4], di
C36F  8C 46 FE        mov word ptr [bp - 2], es
C372  8B 46 04        mov ax, word ptr [bp + 4]
C375  C1 E0 03        shl ax, 3
C378  C4 3E BA D7     les di, ptr [0xd7ba]
C37C  03 F8           add di, ax
C37E  26 80 7D 01 12  cmp byte ptr es:[di + 1], 0x12
C383  72 1F           jb 0xc3a4
C385  C4 3E D2 D7     les di, ptr [0xd7d2]
C389  26 8A 45 04     mov al, byte ptr es:[di + 4]
C38D  30 E4           xor ah, ah
C38F  50              push ax
C390  9A 15 36 51 1B  call far 1B51:3615
C395  50              push ax
C396  BF 3C C3        mov di, 0xc33c
C399  0E              push cs
C39A  57              push di
C39B  9A 98 00 1A 23  call far 231A:0098
C3A0  08 C0           or al, al
C3A2  74 02           je 0xc3a6
loc_C3A4:
C3A4  EB 1C           jmp 0xc3c2
loc_C3A6:
C3A6  C4 7E FC        les di, ptr [bp - 4]
C3A9  26 80 7D 0C 00  cmp byte ptr es:[di + 0xc], 0
C3AE  74 07           je 0xc3b7
C3B0  26 C6 45 0D 00  mov byte ptr es:[di + 0xd], 0
C3B5  EB 0B           jmp 0xc3c2
loc_C3B7:
C3B7  FF 76 04        push word ptr [bp + 4]
C3BA  6A 00           push 0
C3BC  6A 00           push 0
C3BE  0E              push cs
C3BF  E8 E1 FC        call 0xc0a3
loc_C3C2:
C3C2  C9              leave
C3C3  C2 02 00        ret 2

; ---- routine 0AB5:C3C6  (found by: call)
sub_C3C6:
C3C6  55              push bp
C3C7  89 E5           mov bp, sp
C3C9  8B 7E 04        mov di, word ptr [bp + 4]
C3CC  36 80 7D F6 00  cmp byte ptr ss:[di - 0xa], 0
C3D1  75 03           jne 0xc3d6
C3D3  E9 97 00        jmp 0xc46d
loc_C3D6:
C3D6  36 C6 45 F6 00  mov byte ptr ss:[di - 0xa], 0
C3DB  A0 7E 03        mov al, byte ptr [0x37e]
C3DE  30 E4           xor ah, ah
C3E0  D1 E0           shl ax, 1
C3E2  8B D0           mov dx, ax
C3E4  36 8A 45 F7     mov al, byte ptr ss:[di - 9]
C3E8  30 E4           xor ah, ah
C3EA  C1 E0 02        shl ax, 2
C3ED  03 F8           add di, ax
C3EF  36 C4 7D F4     les di, ptr ss:[di - 0xc]
C3F3  03 FA           add di, dx
C3F5  81 C7 FE FF     add di, 0xfffe
C3F9  06              push es
C3FA  57              push di
C3FB  8B 7E 04        mov di, word ptr [bp + 4]
C3FE  36 8A 45 F4     mov al, byte ptr ss:[di - 0xc]
C402  30 E4           xor ah, ah
C404  D1 E0           shl ax, 1
C406  8B D0           mov dx, ax
C408  36 8A 45 F5     mov al, byte ptr ss:[di - 0xb]
C40C  30 E4           xor ah, ah
C40E  C1 E0 02        shl ax, 2
C411  03 F8           add di, ax
C413  36 C4 7D F4     les di, ptr ss:[di - 0xc]
C417  03 FA           add di, dx
C419  81 C7 FE FF     add di, 0xfffe
C41D  06              push es
C41E  57              push di
C41F  6A 02           push 2
C421  9A 03 02 AC 24  call far 24AC:0203
C426  80 3E 91 0D 00  cmp byte ptr [0xd91], 0
C42B  74 05           je 0xc432
C42D  E8 1F 52        call 0x1164f
C430  EB 39           jmp 0xc46b
loc_C432:
C432  C4 3E D2 D7     les di, ptr [0xd7d2]
C436  26 8A 45 04     mov al, byte ptr es:[di + 4]
C43A  30 E4           xor ah, ah
C43C  8B F8           mov di, ax
C43E  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
C442  30 E4           xor ah, ah
C444  6B C0 3E        imul ax, ax, 0x3e
C447  C4 3E C2 D7     les di, ptr [0xd7c2]
C44B  03 F8           add di, ax
C44D  81 C7 C2 FF     add di, 0xffc2
C451  06              push es
C452  57              push di
C453  C4 3E D2 D7     les di, ptr [0xd7d2]
C457  26 8A 45 04     mov al, byte ptr es:[di + 4]
C45B  30 E4           xor ah, ah
C45D  8B F8           mov di, ax
C45F  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
C463  30 E4           xor ah, ah
C465  50              push ax
C466  9A B8 76 51 1B  call far 1B51:76B8
loc_C46B:
C46B  EB 42           jmp 0xc4af
loc_C46D:
C46D  8B 7E 04        mov di, word ptr [bp + 4]
C470  36 80 7D F6 00  cmp byte ptr ss:[di - 0xa], 0
C475  75 38           jne 0xc4af
C477  A0 7E 03        mov al, byte ptr [0x37e]
C47A  30 E4           xor ah, ah
C47C  D1 E0           shl ax, 1
C47E  8B D0           mov dx, ax
C480  36 8A 45 F7     mov al, byte ptr ss:[di - 9]
C484  30 E4           xor ah, ah
C486  C1 E0 02        shl ax, 2
C489  03 F8           add di, ax
C48B  36 C4 7D F4     les di, ptr ss:[di - 0xc]
C48F  03 FA           add di, dx
C491  26 83 7D FE 00  cmp word ptr es:[di - 2], 0
C496  74 17           je 0xc4af
C498  A0 7E 03        mov al, byte ptr [0x37e]
C49B  8B 7E 04        mov di, word ptr [bp + 4]
C49E  36 88 45 F4     mov byte ptr ss:[di - 0xc], al
C4A2  36 8A 45 F7     mov al, byte ptr ss:[di - 9]
C4A6  36 88 45 F5     mov byte ptr ss:[di - 0xb], al
C4AA  36 C6 45 F6 01  mov byte ptr ss:[di - 0xa], 1
loc_C4AF:
C4AF  C9              leave
C4B0  C2 02 00        ret 2

; ---- routine 0AB5:C4B3  (found by: call)
sub_C4B3:
C4B3  55              push bp
C4B4  89 E5           mov bp, sp
C4B6  A0 88 DE        mov al, byte ptr [0xde88]
C4B9  A2 8A DE        mov byte ptr [0xde8a], al
C4BC  8A 46 06        mov al, byte ptr [bp + 6]
C4BF  A2 D4 0C        mov byte ptr [0xcd4], al
C4C2  C6 06 88 DE 02  mov byte ptr [0xde88], 2
C4C7  C9              leave
C4C8  C2 04 00        ret 4
; data (not reached as code), 2 bytes
C4CB                  db 01 20   ; . 

; ---- routine 0AB5:C4CD  (found by: call)
sub_C4CD:
C4CD  C8 0C 02 00     enter 0x20c, 0
C4D1  C6 06 2A 9A 00  mov byte ptr [0x9a2a], 0
C4D6  C6 46 FF 00     mov byte ptr [bp - 1], 0
loc_C4DA:
C4DA  8D 7E F6        lea di, [bp - 0xa]
C4DD  16              push ss
C4DE  57              push di
C4DF  6A 08           push 8
C4E1  6A 01           push 1
C4E3  9A 22 02 AC 24  call far 24AC:0222
C4E8  C7 46 F4 04 00  mov word ptr [bp - 0xc], 4
C4ED  EB 03           jmp 0xc4f2
loc_C4EF:
C4EF  FF 46 F4        inc word ptr [bp - 0xc]
loc_C4F2:
C4F2  80 3E 18 0D 00  cmp byte ptr [0xd18], 0
C4F7  74 07           je 0xc500
C4F9  8B 7E F4        mov di, word ptr [bp - 0xc]
C4FC  C6 43 F5 00     mov byte ptr [bp + di - 0xb], 0
loc_C500:
C500  83 7E F4 07     cmp word ptr [bp - 0xc], 7
C504  75 E9           jne 0xc4ef
C506  8B 46 06        mov ax, word ptr [bp + 6]
C509  C1 E0 03        shl ax, 3
C50C  C4 3E BA D7     les di, ptr [0xd7ba]
C510  03 F8           add di, ax
C512  26 80 7D 07 00  cmp byte ptr es:[di + 7], 0
C517  75 04           jne 0xc51d
C519  C6 46 F6 00     mov byte ptr [bp - 0xa], 0
loc_C51D:
C51D  6B 46 06 0F     imul ax, word ptr [bp + 6], 0xf
C521  C4 3E BE D7     les di, ptr [0xd7be]
C525  03 F8           add di, ax
C527  26 80 7D 0D 02  cmp byte ptr es:[di + 0xd], 2
C52C  75 06           jne 0xc534
C52E  C6 46 F8 00     mov byte ptr [bp - 8], 0
C532  EB 04           jmp 0xc538
loc_C534:
C534  C6 46 F9 00     mov byte ptr [bp - 7], 0
loc_C538:
C538  C7 46 F4 02 00  mov word ptr [bp - 0xc], 2
C53D  EB 03           jmp 0xc542
loc_C53F:
C53F  FF 46 F4        inc word ptr [bp - 0xc]
loc_C542:
C542  83 7E F4 05     cmp word ptr [bp - 0xc], 5
C546  74 1A           je 0xc562
C548  8B 46 06        mov ax, word ptr [bp + 6]
C54B  C1 E0 03        shl ax, 3
C54E  C4 3E BA D7     les di, ptr [0xd7ba]
C552  03 F8           add di, ax
C554  26 80 7D 01 12  cmp byte ptr es:[di + 1], 0x12
C559  73 07           jae 0xc562
C55B  8B 7E F4        mov di, word ptr [bp - 0xc]
C55E  C6 43 F5 00     mov byte ptr [bp + di - 0xb], 0
loc_C562:
C562  83 7E F4 06     cmp word ptr [bp - 0xc], 6
C566  75 D7           jne 0xc53f
C568  6B 46 06 0F     imul ax, word ptr [bp + 6], 0xf
C56C  C4 3E BE D7     les di, ptr [0xd7be]
C570  03 F8           add di, ax
C572  26 80 7D 0D 03  cmp byte ptr es:[di + 0xd], 3
C577  75 04           jne 0xc57d
C579  C6 46 FC 00     mov byte ptr [bp - 4], 0
loc_C57D:
C57D  BF 22 63        mov di, 0x6322
C580  1E              push ds
C581  57              push di
C582  BF 5C DD        mov di, 0xdd5c
C585  1E              push ds
C586  57              push di
C587  9A 2F 05 1A 23  call far 231A:052F
C58C  BF 7A 43        mov di, 0x437a
C58F  1E              push ds
C590  57              push di
C591  BF 5C DD        mov di, 0xdd5c
C594  1E              push ds
C595  57              push di
C596  9A 2F 05 1A 23  call far 231A:052F
C59B  FF 76 06        push word ptr [bp + 6]
C59E  0E              push cs
C59F  E8 11 D0        call 0x95b3
C5A2  FF 76 06        push word ptr [bp + 6]
C5A5  8B 46 06        mov ax, word ptr [bp + 6]
C5A8  C1 E0 03        shl ax, 3
C5AB  C4 3E BA D7     les di, ptr [0xd7ba]
C5AF  03 F8           add di, ax
C5B1  26 8A 45 06     mov al, byte ptr es:[di + 6]
C5B5  30 E4           xor ah, ah
C5B7  50              push ax
C5B8  9A 8B 71 51 1B  call far 1B51:718B
C5BD  50              push ax
C5BE  8D BE F4 FE     lea di, [bp - 0x10c]
C5C2  16              push ss
C5C3  57              push di
C5C4  8B 46 06        mov ax, word ptr [bp + 6]
C5C7  C4 3E AA D7     les di, ptr [0xd7aa]
C5CB  03 F8           add di, ax
C5CD  26 8A 05        mov al, byte ptr es:[di]
C5D0  50              push ax
C5D1  9A 6F 0C B9 26  call far 26B9:0C6F
C5D6  BF CB C4        mov di, 0xc4cb
C5D9  0E              push cs
C5DA  57              push di
C5DB  9A D2 0B B9 26  call far 26B9:0BD2
C5E0  8D BE F4 FD     lea di, [bp - 0x20c]
C5E4  16              push ss
C5E5  57              push di
C5E6  FF 76 06        push word ptr [bp + 6]
C5E9  9A 3C 44 51 1B  call far 1B51:443C
C5EE  9A D2 0B B9 26  call far 26B9:0BD2
C5F3  6A 03           push 3
C5F5  6A 3C           push 0x3c
C5F7  BF 5C DD        mov di, 0xdd5c
C5FA  1E              push ds
C5FB  57              push di
C5FC  9A 1B 04 1A 23  call far 231A:041B
C601  A0 D4 0C        mov al, byte ptr [0xcd4]
C604  30 E4           xor ah, ah
C606  8B F8           mov di, ax
C608  8A 85 CB 0C     mov al, byte ptr [di + 0xccb]
C60C  30 E4           xor ah, ah
C60E  50              push ax
C60F  6A 3B           push 0x3b
C611  6A 11           push 0x11
C613  9A 03 02 1A 23  call far 231A:0203
C618  C7 46 F4 01 00  mov word ptr [bp - 0xc], 1
C61D  EB 03           jmp 0xc622
loc_C61F:
C61F  FF 46 F4        inc word ptr [bp - 0xc]
loc_C622:
C622  6A 0E           push 0xe
C624  8D BE F4 FE     lea di, [bp - 0x10c]
C628  16              push ss
C629  57              push di
C62A  8B 7E F4        mov di, word ptr [bp - 0xc]
C62D  8A 43 F5        mov al, byte ptr [bp + di - 0xb]
C630  98              cwde
C631  8B F8           mov di, ax
C633  8A 85 EA A2     mov al, byte ptr [di - 0x5d16]
C637  50              push ax
C638  9A 6F 0C B9 26  call far 26B9:0C6F
C63D  8B 7E F4        mov di, word ptr [bp - 0xc]
C640  8A 85 CB 0C     mov al, byte ptr [di + 0xccb]
C644  50              push ax
C645  6A 4D           push 0x4d
C647  BF 5C DD        mov di, 0xdd5c
C64A  1E              push ds
C64B  57              push di
C64C  9A 1B 04 1A 23  call far 231A:041B
C651  83 7E F4 08     cmp word ptr [bp - 0xc], 8
C655  75 C8           jne 0xc61f
C657  BF D4 0C        mov di, 0xcd4
C65A  1E              push ds
C65B  57              push di
C65C  6A 08           push 8
C65E  9A 8B 0F 1A 23  call far 231A:0F8B
C663  80 3E 88 DE 72  cmp byte ptr [0xde88], 0x72
C668  75 08           jne 0xc672
C66A  6A 01           push 1
C66C  55              push bp
C66D  E8 43 FE        call 0xc4b3
C670  EB 70           jmp 0xc6e2
loc_C672:
C672  A0 88 DE        mov al, byte ptr [0xde88]
C675  50              push ax
C676  9A 86 19 B9 26  call far 26B9:1986
C67B  3C 52           cmp al, 0x52
C67D  75 08           jne 0xc687
C67F  6A 01           push 1
C681  55              push bp
C682  E8 2E FE        call 0xc4b3
C685  EB 5B           jmp 0xc6e2
loc_C687:
C687  3C 43           cmp al, 0x43
C689  75 08           jne 0xc693
C68B  6A 02           push 2
C68D  55              push bp
C68E  E8 22 FE        call 0xc4b3
C691  EB 4F           jmp 0xc6e2
loc_C693:
C693  3C 53           cmp al, 0x53
C695  75 08           jne 0xc69f
C697  6A 03           push 3
C699  55              push bp
C69A  E8 16 FE        call 0xc4b3
C69D  EB 43           jmp 0xc6e2
loc_C69F:
C69F  3C 55           cmp al, 0x55
C6A1  75 08           jne 0xc6ab
C6A3  6A 04           push 4
C6A5  55              push bp
C6A6  E8 0A FE        call 0xc4b3
C6A9  EB 37           jmp 0xc6e2
loc_C6AB:
C6AB  3C 54           cmp al, 0x54
C6AD  75 08           jne 0xc6b7
C6AF  6A 05           push 5
C6B1  55              push bp
C6B2  E8 FE FD        call 0xc4b3
C6B5  EB 2B           jmp 0xc6e2
loc_C6B7:
C6B7  3C 4E           cmp al, 0x4e
C6B9  75 08           jne 0xc6c3
C6BB  6A 06           push 6
C6BD  55              push bp
C6BE  E8 F2 FD        call 0xc4b3
C6C1  EB 1F           jmp 0xc6e2
loc_C6C3:
C6C3  3C 46           cmp al, 0x46
C6C5  75 08           jne 0xc6cf
C6C7  6A 07           push 7
C6C9  55              push bp
C6CA  E8 E6 FD        call 0xc4b3
C6CD  EB 13           jmp 0xc6e2
loc_C6CF:
C6CF  80 3E 88 DE 02  cmp byte ptr [0xde88], 2
C6D4  75 0C           jne 0xc6e2
C6D6  80 3E D4 0C 01  cmp byte ptr [0xcd4], 1
C6DB  75 05           jne 0xc6e2
C6DD  C6 06 8A DE 72  mov byte ptr [0xde8a], 0x72
loc_C6E2:
C6E2  80 3E 88 DE 01  cmp byte ptr [0xde88], 1
C6E7  75 07           jne 0xc6f0
C6E9  C6 46 FF 01     mov byte ptr [bp - 1], 1
C6ED  E9 C3 00        jmp 0xc7b3
loc_C6F0:
C6F0  80 3E 88 DE 0D  cmp byte ptr [0xde88], 0xd
C6F5  75 10           jne 0xc707
C6F7  80 3E 2A 9A 00  cmp byte ptr [0x9a2a], 0
C6FC  B0 00           mov al, 0
C6FE  75 01           jne 0xc701
C700  40              inc ax
loc_C701:
C701  A2 2A 9A        mov byte ptr [0x9a2a], al
C704  E9 AC 00        jmp 0xc7b3
loc_C707:
C707  80 3E 88 DE 02  cmp byte ptr [0xde88], 2
C70C  74 03           je 0xc711
C70E  E9 A2 00        jmp 0xc7b3
loc_C711:
C711  A0 D4 0C        mov al, byte ptr [0xcd4]
C714  30 E4           xor ah, ah
C716  8B F8           mov di, ax
C718  80 7B F5 00     cmp byte ptr [bp + di - 0xb], 0
C71C  75 03           jne 0xc721
C71E  E9 92 00        jmp 0xc7b3
loc_C721:
C721  A0 D4 0C        mov al, byte ptr [0xcd4]
C724  3C 01           cmp al, 1
C726  75 13           jne 0xc73b
C728  FF 76 06        push word ptr [bp + 6]
C72B  80 3E 8A DE 72  cmp byte ptr [0xde8a], 0x72
C730  B0 00           mov al, 0
C732  75 01           jne 0xc735
C734  40              inc ax
loc_C735:
C735  50              push ax
C736  E8 A0 E4        call 0xabd9
C739  EB 78           jmp 0xc7b3
loc_C73B:
C73B  3C 02           cmp al, 2
C73D  75 08           jne 0xc747
C73F  FF 76 06        push word ptr [bp + 6]
C742  E8 0D E5        call 0xac52
C745  EB 6C           jmp 0xc7b3
loc_C747:
C747  3C 03           cmp al, 3
C749  75 0A           jne 0xc755
C74B  FF 76 06        push word ptr [bp + 6]
C74E  9A 2F 66 51 1B  call far 1B51:662F
C753  EB 5E           jmp 0xc7b3
loc_C755:
C755  3C 04           cmp al, 4
C757  75 08           jne 0xc761
C759  FF 76 06        push word ptr [bp + 6]
C75C  E8 F9 FB        call 0xc358
C75F  EB 52           jmp 0xc7b3
loc_C761:
C761  3C 05           cmp al, 5
C763  75 0E           jne 0xc773
C765  FF 76 06        push word ptr [bp + 6]
C768  A0 7E 03        mov al, byte ptr [0x37e]
C76B  30 E4           xor ah, ah
C76D  50              push ax
C76E  E8 00 EB        call 0xb271
C771  EB 40           jmp 0xc7b3
loc_C773:
C773  3C 06           cmp al, 6
C775  75 0D           jne 0xc784
C777  FF 76 06        push word ptr [bp + 6]
C77A  6A 00           push 0
C77C  6A 00           push 0
C77E  0E              push cs
C77F  E8 21 F9        call 0xc0a3
C782  EB 2F           jmp 0xc7b3
loc_C784:
C784  3C 07           cmp al, 7
C786  75 23           jne 0xc7ab
C788  8B 7E 04        mov di, word ptr [bp + 4]
C78B  36 8A 45 F7     mov al, byte ptr ss:[di - 9]
C78F  30 E4           xor ah, ah
C791  C1 E0 02        shl ax, 2
C794  03 F8           add di, ax
C796  36 C4 7D F4     les di, ptr ss:[di - 0xc]
C79A  06              push es
C79B  57              push di
C79C  A0 7E 03        mov al, byte ptr [0x37e]
C79F  30 E4           xor ah, ah
C7A1  50              push ax
C7A2  E8 FF D8        call 0xa0a4
C7A5  C6 46 FF 01     mov byte ptr [bp - 1], 1
C7A9  EB 08           jmp 0xc7b3
loc_C7AB:
C7AB  3C 08           cmp al, 8
C7AD  75 04           jne 0xc7b3
C7AF  C6 46 FF 01     mov byte ptr [bp - 1], 1
loc_C7B3:
C7B3  80 7E FF 00     cmp byte ptr [bp - 1], 0
C7B7  75 03           jne 0xc7bc
C7B9  E9 1E FD        jmp 0xc4da
loc_C7BC:
C7BC  C6 06 88 DE 00  mov byte ptr [0xde88], 0
C7C1  C9              leave
C7C2  C2 04 00        ret 4
; data (not reached as code), 155 bytes
C7C5                  pstr 'There is no player here'
C7DD                  pstr 'Your final substitute must be a goalkeeper'
C808                  pstr 'Illegal substitution'
C81D                  pstr 'You cannot have two goalkeepers on the pitch'
C84A                  pstr ' cannot play'
C857                  pstr 'Nice try'

; ---- routine 0AB5:C860  (found by: call)
sub_C860:
C860  C8 08 01 00     enter 0x108, 0
C864  8B 7E 04        mov di, word ptr [bp + 4]
C867  36 80 7D F6 00  cmp byte ptr ss:[di - 0xa], 0
C86C  74 03           je 0xc871
C86E  E9 85 00        jmp 0xc8f6
loc_C871:
C871  A0 7E 03        mov al, byte ptr [0x37e]
C874  30 E4           xor ah, ah
C876  D1 E0           shl ax, 1
C878  36 C4 7D F8     les di, ptr ss:[di - 8]
C87C  03 F8           add di, ax
C87E  26 83 7D FE 00  cmp word ptr es:[di - 2], 0
C883  B0 00           mov al, 0
C885  75 01           jne 0xc888
C887  40              inc ax
loc_C888:
C888  50              push ax
C889  BF C5 C7        mov di, 0xc7c5
C88C  0E              push cs
C88D  57              push di
C88E  9A 98 00 1A 23  call far 231A:0098
C893  08 C0           or al, al
C895  75 4A           jne 0xc8e1
C897  8B 7E 04        mov di, word ptr [bp + 4]
C89A  36 8A 45 F0     mov al, byte ptr ss:[di - 0x10]
C89E  98              cwde
C89F  8B F8           mov di, ax
C8A1  80 BD E0 D6 00  cmp byte ptr [di - 0x2920], 0
C8A6  75 24           jne 0xc8cc
C8A8  A0 7E 03        mov al, byte ptr [0x37e]
C8AB  30 E4           xor ah, ah
C8AD  D1 E0           shl ax, 1
C8AF  8B 7E 04        mov di, word ptr [bp + 4]
C8B2  36 C4 7D F8     les di, ptr ss:[di - 8]
C8B6  03 F8           add di, ax
C8B8  26 8B 45 FE     mov ax, word ptr es:[di - 2]
C8BC  C1 E0 03        shl ax, 3
C8BF  C4 3E BA D7     les di, ptr [0xd7ba]
C8C3  03 F8           add di, ax
C8C5  26 80 7D 06 00  cmp byte ptr es:[di + 6], 0
C8CA  75 04           jne 0xc8d0
loc_C8CC:
C8CC  B0 00           mov al, 0
C8CE  EB 02           jmp 0xc8d2
loc_C8D0:
C8D0  B0 01           mov al, 1
loc_C8D2:
C8D2  50              push ax
C8D3  BF DD C7        mov di, 0xc7dd
C8D6  0E              push cs
C8D7  57              push di
C8D8  9A 98 00 1A 23  call far 231A:0098
C8DD  08 C0           or al, al
C8DF  74 03           je 0xc8e4
loc_C8E1:
C8E1  E9 7F 02        jmp 0xcb63
loc_C8E4:
C8E4  A0 7E 03        mov al, byte ptr [0x37e]
C8E7  8B 7E 04        mov di, word ptr [bp + 4]
C8EA  36 88 45 F4     mov byte ptr ss:[di - 0xc], al
C8EE  36 C6 45 F6 01  mov byte ptr ss:[di - 0xa], 1
C8F3  E9 6D 02        jmp 0xcb63
loc_C8F6:
C8F6  8B 7E 04        mov di, word ptr [bp + 4]
C8F9  36 C6 45 F6 00  mov byte ptr ss:[di - 0xa], 0
C8FE  36 80 7D F4 0C  cmp byte ptr ss:[di - 0xc], 0xc
C903  B0 00           mov al, 0
C905  73 01           jae 0xc908
C907  40              inc ax
loc_C908:
C908  8A D0           mov dl, al
C90A  80 3E 7E 03 0C  cmp byte ptr [0x37e], 0xc
C90F  B0 00           mov al, 0
C911  73 01           jae 0xc914
C913  40              inc ax
loc_C914:
C914  3A C2           cmp al, dl
C916  B0 00           mov al, 0
C918  75 01           jne 0xc91b
C91A  40              inc ax
loc_C91B:
C91B  50              push ax
C91C  BF 08 C8        mov di, 0xc808
C91F  0E              push cs
C920  57              push di
C921  9A 98 00 1A 23  call far 231A:0098
C926  08 C0           or al, al
C928  74 03           je 0xc92d
C92A  E9 36 02        jmp 0xcb63
loc_C92D:
C92D  A0 7E 03        mov al, byte ptr [0x37e]
C930  30 E4           xor ah, ah
C932  31 D2           xor dx, dx
C934  52              push dx
C935  50              push ax
C936  8B 7E 04        mov di, word ptr [bp + 4]
C939  36 8A 45 F4     mov al, byte ptr ss:[di - 0xc]
C93D  30 E4           xor ah, ah
C93F  31 D2           xor dx, dx
C941  52              push dx
C942  50              push ax
C943  9A C0 04 AC 24  call far 24AC:04C0
C948  89 46 FE        mov word ptr [bp - 2], ax
C94B  A0 7E 03        mov al, byte ptr [0x37e]
C94E  30 E4           xor ah, ah
C950  31 D2           xor dx, dx
C952  52              push dx
C953  50              push ax
C954  8B 7E 04        mov di, word ptr [bp + 4]
C957  36 8A 45 F4     mov al, byte ptr ss:[di - 0xc]
C95B  30 E4           xor ah, ah
C95D  31 D2           xor dx, dx
C95F  52              push dx
C960  50              push ax
C961  9A FA 04 AC 24  call far 24AC:04FA
C966  89 46 FC        mov word ptr [bp - 4], ax
C969  C4 3E D2 D7     les di, ptr [0xd7d2]
C96D  26 8A 45 04     mov al, byte ptr es:[di + 4]
C971  30 E4           xor ah, ah
C973  8B F8           mov di, ax
C975  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
C979  30 E4           xor ah, ah
C97B  6B C0 3E        imul ax, ax, 0x3e
C97E  C4 3E C2 D7     les di, ptr [0xd7c2]
C982  03 F8           add di, ax
C984  81 C7 C2 FF     add di, 0xffc2
C988  89 7E F4        mov word ptr [bp - 0xc], di
C98B  8C 46 F6        mov word ptr [bp - 0xa], es
C98E  8B 46 FE        mov ax, word ptr [bp - 2]
C991  D1 E0           shl ax, 1
C993  03 F8           add di, ax
C995  26 8B 45 FE     mov ax, word ptr es:[di - 2]
C999  C1 E0 03        shl ax, 3
C99C  C4 3E BA D7     les di, ptr [0xd7ba]
C9A0  03 F8           add di, ax
C9A2  26 80 7D 07 00  cmp byte ptr es:[di + 7], 0
C9A7  75 65           jne 0xca0e
C9A9  C7 46 FA 01 00  mov word ptr [bp - 6], 1
C9AE  EB 03           jmp 0xc9b3
loc_C9B0:
C9B0  FF 46 FA        inc word ptr [bp - 6]
loc_C9B3:
C9B3  8B 46 FA        mov ax, word ptr [bp - 6]
C9B6  3B 46 FC        cmp ax, word ptr [bp - 4]
C9B9  74 4D           je 0xca08
C9BB  8B 46 FA        mov ax, word ptr [bp - 6]
C9BE  D1 E0           shl ax, 1
C9C0  C4 7E F4        les di, ptr [bp - 0xc]
C9C3  03 F8           add di, ax
C9C5  26 FF 75 FE     push word ptr es:[di - 2]
C9C9  9A E9 4E 51 1B  call far 1B51:4EE9
C9CE  08 C0           or al, al
C9D0  75 1E           jne 0xc9f0
C9D2  8B 46 FA        mov ax, word ptr [bp - 6]
C9D5  D1 E0           shl ax, 1
C9D7  C4 7E F4        les di, ptr [bp - 0xc]
C9DA  03 F8           add di, ax
C9DC  26 8B 45 FE     mov ax, word ptr es:[di - 2]
C9E0  C1 E0 03        shl ax, 3
C9E3  C4 3E BA D7     les di, ptr [0xd7ba]
C9E7  03 F8           add di, ax
C9E9  26 80 7D 07 00  cmp byte ptr es:[di + 7], 0
C9EE  74 04           je 0xc9f4
loc_C9F0:
C9F0  B0 00           mov al, 0
C9F2  EB 02           jmp 0xc9f6
loc_C9F4:
C9F4  B0 01           mov al, 1
loc_C9F6:
C9F6  50              push ax
C9F7  BF 1D C8        mov di, 0xc81d
C9FA  0E              push cs
C9FB  57              push di
C9FC  9A 98 00 1A 23  call far 231A:0098
CA01  08 C0           or al, al
CA03  74 03           je 0xca08
CA05  E9 5B 01        jmp 0xcb63
loc_CA08:
CA08  83 7E FA 0B     cmp word ptr [bp - 6], 0xb
CA0C  75 A2           jne 0xc9b0
loc_CA0E:
CA0E  8B 46 FE        mov ax, word ptr [bp - 2]
CA11  D1 E0           shl ax, 1
CA13  8B 7E 04        mov di, word ptr [bp + 4]
CA16  36 C4 7D F8     les di, ptr ss:[di - 8]
CA1A  03 F8           add di, ax
CA1C  26 FF 75 FE     push word ptr es:[di - 2]
CA20  9A E9 4E 51 1B  call far 1B51:4EE9
CA25  50              push ax
CA26  8D BE F8 FE     lea di, [bp - 0x108]
CA2A  16              push ss
CA2B  57              push di
CA2C  8B 46 FE        mov ax, word ptr [bp - 2]
CA2F  D1 E0           shl ax, 1
CA31  8B 7E 04        mov di, word ptr [bp + 4]
CA34  36 C4 7D F8     les di, ptr ss:[di - 8]
CA38  03 F8           add di, ax
CA3A  26 FF 75 FE     push word ptr es:[di - 2]
CA3E  9A 3C 44 51 1B  call far 1B51:443C
CA43  BF 4A C8        mov di, 0xc84a
CA46  0E              push cs
CA47  57              push di
CA48  9A D2 0B B9 26  call far 26B9:0BD2
CA4D  9A 98 00 1A 23  call far 231A:0098
CA52  08 C0           or al, al
CA54  75 36           jne 0xca8c
CA56  6A 06           push 6
CA58  8B 46 FC        mov ax, word ptr [bp - 4]
CA5B  D1 E0           shl ax, 1
CA5D  8B 7E 04        mov di, word ptr [bp + 4]
CA60  36 C4 7D F8     les di, ptr ss:[di - 8]
CA64  03 F8           add di, ax
CA66  26 6B 45 FE 0F  imul ax, word ptr es:[di - 2], 0xf
CA6B  C4 3E BE D7     les di, ptr [0xd7be]
CA6F  03 F8           add di, ax
CA71  26 8A 45 0B     mov al, byte ptr es:[di + 0xb]
CA75  30 E4           xor ah, ah
CA77  50              push ax
CA78  9A 59 02 AC 24  call far 24AC:0259
CA7D  50              push ax
CA7E  BF 57 C8        mov di, 0xc857
CA81  0E              push cs
CA82  57              push di
CA83  9A 98 00 1A 23  call far 231A:0098
CA88  08 C0           or al, al
CA8A  74 03           je 0xca8f
loc_CA8C:
CA8C  E9 D4 00        jmp 0xcb63
loc_CA8F:
CA8F  A0 7E 03        mov al, byte ptr [0x37e]
CA92  30 E4           xor ah, ah
CA94  D1 E0           shl ax, 1
CA96  8B 7E 04        mov di, word ptr [bp + 4]
CA99  36 C4 7D F8     les di, ptr ss:[di - 8]
CA9D  03 F8           add di, ax
CA9F  81 C7 FE FF     add di, 0xfffe
CAA3  06              push es
CAA4  57              push di
CAA5  8B 7E 04        mov di, word ptr [bp + 4]
CAA8  36 8A 45 F4     mov al, byte ptr ss:[di - 0xc]
CAAC  30 E4           xor ah, ah
CAAE  D1 E0           shl ax, 1
CAB0  36 C4 7D F8     les di, ptr ss:[di - 8]
CAB4  03 F8           add di, ax
CAB6  81 C7 FE FF     add di, 0xfffe
CABA  06              push es
CABB  57              push di
CABC  6A 02           push 2
CABE  9A 03 02 AC 24  call far 24AC:0203
CAC3  A0 7E 03        mov al, byte ptr [0x37e]
CAC6  30 E4           xor ah, ah
CAC8  D1 E0           shl ax, 1
CACA  8B D0           mov dx, ax
CACC  8B 7E 04        mov di, word ptr [bp + 4]
CACF  36 8A 45 F0     mov al, byte ptr ss:[di - 0x10]
CAD3  98              cwde
CAD4  6B F8 28        imul di, ax, 0x28
CAD7  03 FA           add di, dx
CAD9  81 C7 46 D1     add di, 0xd146
CADD  1E              push ds
CADE  57              push di
CADF  8B 7E 04        mov di, word ptr [bp + 4]
CAE2  36 8A 45 F4     mov al, byte ptr ss:[di - 0xc]
CAE6  30 E4           xor ah, ah
CAE8  D1 E0           shl ax, 1
CAEA  8B D0           mov dx, ax
CAEC  36 8A 45 F0     mov al, byte ptr ss:[di - 0x10]
CAF0  98              cwde
CAF1  6B F8 28        imul di, ax, 0x28
CAF4  03 FA           add di, dx
CAF6  81 C7 46 D1     add di, 0xd146
CAFA  1E              push ds
CAFB  57              push di
CAFC  6A 02           push 2
CAFE  9A 03 02 AC 24  call far 24AC:0203
CB03  A0 7E 03        mov al, byte ptr [0x37e]
CB06  30 E4           xor ah, ah
CB08  8B D0           mov dx, ax
CB0A  8B 7E 04        mov di, word ptr [bp + 4]
CB0D  36 8A 45 F0     mov al, byte ptr ss:[di - 0x10]
CB11  98              cwde
CB12  6B F8 14        imul di, ax, 0x14
CB15  03 FA           add di, dx
CB17  81 C7 97 D1     add di, 0xd197
CB1B  1E              push ds
CB1C  57              push di
CB1D  8B 7E 04        mov di, word ptr [bp + 4]
CB20  36 8A 45 F4     mov al, byte ptr ss:[di - 0xc]
CB24  30 E4           xor ah, ah
CB26  8B D0           mov dx, ax
CB28  36 8A 45 F0     mov al, byte ptr ss:[di - 0x10]
CB2C  98              cwde
CB2D  6B F8 14        imul di, ax, 0x14
CB30  03 FA           add di, dx
CB32  81 C7 97 D1     add di, 0xd197
CB36  1E              push ds
CB37  57              push di
CB38  6A 01           push 1
CB3A  9A 03 02 AC 24  call far 24AC:0203
CB3F  8B 7E 04        mov di, word ptr [bp + 4]
CB42  36 8A 45 F0     mov al, byte ptr ss:[di - 0x10]
CB46  50              push ax
CB47  36 8A 45 F0     mov al, byte ptr ss:[di - 0x10]
CB4B  98              cwde
CB4C  8B F8           mov di, ax
CB4E  8A 85 56 0D     mov al, byte ptr [di + 0xd56]
CB52  30 E4           xor ah, ah
CB54  03 46 FC        add ax, word ptr [bp - 4]
CB57  50              push ax
CB58  FF 76 FE        push word ptr [bp - 2]
CB5B  E8 5A E3        call 0xaeb8
CB5E  C6 06 E2 D6 00  mov byte ptr [0xd6e2], 0
loc_CB63:
CB63  C9              leave
CB64  C2 02 00        ret 2
; data (not reached as code), 131 bytes
CB67                  pstr '              '
CB76                  pstr 'NO MORE SUBS  '
CB85                  pstr 'MAKE SUBSTITUTION'
CB97                  pstr 'REQUEST SUBSTITION'
CBAA                  pstr 'CANCEL SUB REQUESTED'
CBBF                  pstr 'Cannot hire youths after match has started'

; ---- routine 0AB5:CBEA  (found by: call, far)
sub_CBEA:
CBEA  C8 18 00 00     enter 0x18, 0
CBEE  C4 3E D2 D7     les di, ptr [0xd7d2]
CBF2  89 7E EC        mov word ptr [bp - 0x14], di
CBF5  8C 46 EE        mov word ptr [bp - 0x12], es
CBF8  80 3E 91 0D 00  cmp byte ptr [0xd91], 0
CBFD  75 34           jne 0xcc33
CBFF  26 8A 45 04     mov al, byte ptr es:[di + 4]
CC03  30 E4           xor ah, ah
CC05  8B F8           mov di, ax
CC07  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
CC0B  30 E4           xor ah, ah
CC0D  6B C0 3E        imul ax, ax, 0x3e
CC10  C4 3E C2 D7     les di, ptr [0xd7c2]
CC14  03 F8           add di, ax
CC16  81 C7 C2 FF     add di, 0xffc2
CC1A  06              push es
CC1B  57              push di
CC1C  C4 7E EC        les di, ptr [bp - 0x14]
CC1F  26 8A 45 04     mov al, byte ptr es:[di + 4]
CC23  30 E4           xor ah, ah
CC25  8B F8           mov di, ax
CC27  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
CC2B  30 E4           xor ah, ah
CC2D  50              push ax
CC2E  9A B8 76 51 1B  call far 1B51:76B8
loc_CC33:
CC33  C6 46 F6 00     mov byte ptr [bp - 0xa], 0
CC37  8A 46 06        mov al, byte ptr [bp + 6]
CC3A  88 46 F7        mov byte ptr [bp - 9], al
CC3D  C4 7E EC        les di, ptr [bp - 0x14]
CC40  26 8A 45 04     mov al, byte ptr es:[di + 4]
CC44  30 E4           xor ah, ah
CC46  8B F8           mov di, ax
CC48  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
CC4C  30 E4           xor ah, ah
CC4E  6B C0 3E        imul ax, ax, 0x3e
CC51  C4 3E C2 D7     les di, ptr [0xd7c2]
CC55  03 F8           add di, ax
CC57  26 8D 45 C2     lea ax, es:[di - 0x3e]
CC5B  8C C2           mov dx, es
CC5D  89 46 F8        mov word ptr [bp - 8], ax
CC60  89 56 FA        mov word ptr [bp - 6], dx
CC63  C4 7E EC        les di, ptr [bp - 0x14]
CC66  26 8A 45 04     mov al, byte ptr es:[di + 4]
CC6A  30 E4           xor ah, ah
CC6C  6B C0 28        imul ax, ax, 0x28
CC6F  03 F8           add di, ax
CC71  26 8D 45 30     lea ax, es:[di + 0x30]
CC75  8C C2           mov dx, es
CC77  89 46 FC        mov word ptr [bp - 4], ax
CC7A  89 56 FE        mov word ptr [bp - 2], dx
CC7D  80 3E 18 0D 00  cmp byte ptr [0xd18], 0
CC82  74 21           je 0xcca5
CC84  C4 7E EC        les di, ptr [bp - 0x14]
CC87  26 8A 45 04     mov al, byte ptr es:[di + 4]
CC8B  30 E4           xor ah, ah
CC8D  8B F8           mov di, ax
CC8F  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
CC93  30 E4           xor ah, ah
CC95  3B 06 E4 D6     cmp ax, word ptr [0xd6e4]
CC99  75 06           jne 0xcca1
CC9B  C6 46 F0 00     mov byte ptr [bp - 0x10], 0
CC9F  EB 04           jmp 0xcca5
loc_CCA1:
CCA1  C6 46 F0 01     mov byte ptr [bp - 0x10], 1
loc_CCA5:
CCA5  80 3E 18 0D 00  cmp byte ptr [0xd18], 0
CCAA  74 05           je 0xccb1
CCAC  C6 06 7E 03 01  mov byte ptr [0x37e], 1
loc_CCB1:
CCB1  8A 46 F7        mov al, byte ptr [bp - 9]
CCB4  30 E4           xor ah, ah
CCB6  8B F8           mov di, ax
CCB8  C1 E7 02        shl di, 2
CCBB  C4 7B F4        les di, ptr [bp + di - 0xc]
CCBE  06              push es
CCBF  57              push di
CCC0  6A 01           push 1
CCC2  0E              push cs
CCC3  E8 C1 DF        call 0xac87
CCC6  80 3E 18 0D 00  cmp byte ptr [0xd18], 0
CCCB  75 03           jne 0xccd0
CCCD  E9 A3 00        jmp 0xcd73
loc_CCD0:
CCD0  80 3E 56 DD 00  cmp byte ptr [0xdd56], 0
CCD5  74 18           je 0xccef
CCD7  6A 03           push 3
CCD9  BF 67 CB        mov di, 0xcb67
CCDC  0E              push cs
CCDD  57              push di
CCDE  6A 19           push 0x19
CCE0  6A 01           push 1
CCE2  BF 5C DD        mov di, 0xdd5c
CCE5  1E              push ds
CCE6  57              push di
CCE7  9A 1B 04 1A 23  call far 231A:041B
CCEC  E9 84 00        jmp 0xcd73
loc_CCEF:
CCEF  8A 46 F0        mov al, byte ptr [bp - 0x10]
CCF2  50              push ax
CCF3  9A B9 46 51 1B  call far 1B51:46B9
CCF8  09 C0           or ax, ax
CCFA  75 17           jne 0xcd13
CCFC  6A 03           push 3
CCFE  BF 76 CB        mov di, 0xcb76
CD01  0E              push cs
CD02  57              push di
CD03  6A 19           push 0x19
CD05  6A 01           push 1
CD07  BF 5C DD        mov di, 0xdd5c
CD0A  1E              push ds
CD0B  57              push di
CD0C  9A 1B 04 1A 23  call far 231A:041B
CD11  EB 60           jmp 0xcd73
loc_CD13:
CD13  80 3E BA D0 00  cmp byte ptr [0xd0ba], 0
CD18  74 17           je 0xcd31
CD1A  6A 03           push 3
CD1C  BF 85 CB        mov di, 0xcb85
CD1F  0E              push cs
CD20  57              push di
CD21  6A 19           push 0x19
CD23  6A 04           push 4
CD25  BF 5C DD        mov di, 0xdd5c
CD28  1E              push ds
CD29  57              push di
CD2A  9A 1B 04 1A 23  call far 231A:041B
CD2F  EB 42           jmp 0xcd73
loc_CD31:
CD31  80 3E E2 D6 00  cmp byte ptr [0xd6e2], 0
CD36  75 17           jne 0xcd4f
CD38  6A 03           push 3
CD3A  BF 97 CB        mov di, 0xcb97
CD3D  0E              push cs
CD3E  57              push di
CD3F  6A 19           push 0x19
CD41  6A 04           push 4
CD43  BF 5C DD        mov di, 0xdd5c
CD46  1E              push ds
CD47  57              push di
CD48  9A 1B 04 1A 23  call far 231A:041B
CD4D  EB 24           jmp 0xcd73
loc_CD4F:
CD4F  6A 03           push 3
CD51  BF AA CB        mov di, 0xcbaa
CD54  0E              push cs
CD55  57              push di
CD56  6A 19           push 0x19
CD58  6A 04           push 4
CD5A  BF 5C DD        mov di, 0xdd5c
CD5D  1E              push ds
CD5E  57              push di
CD5F  9A 1B 04 1A 23  call far 231A:041B
CD64  BF C0 1C        mov di, 0x1cc0
CD67  1E              push ds
CD68  57              push di
CD69  BF 5C DD        mov di, 0xdd5c
CD6C  1E              push ds
CD6D  57              push di
CD6E  9A 2F 05 1A 23  call far 231A:052F
loc_CD73:
CD73  80 3E 18 0D 00  cmp byte ptr [0xd18], 0
CD78  75 26           jne 0xcda0
CD7A  80 7E F7 01     cmp byte ptr [bp - 9], 1
CD7E  75 11           jne 0xcd91
CD80  BF 0E 1D        mov di, 0x1d0e
CD83  1E              push ds
CD84  57              push di
CD85  BF 5C DD        mov di, 0xdd5c
CD88  1E              push ds
CD89  57              push di
CD8A  9A 2F 05 1A 23  call far 231A:052F
CD8F  EB 0F           jmp 0xcda0
loc_CD91:
CD91  BF 48 16        mov di, 0x1648
CD94  1E              push ds
CD95  57              push di
CD96  BF 5C DD        mov di, 0xdd5c
CD99  1E              push ds
CD9A  57              push di
CD9B  9A 2F 05 1A 23  call far 231A:052F
loc_CDA0:
CDA0  80 7E F6 00     cmp byte ptr [bp - 0xa], 0
CDA4  74 63           je 0xce09
CDA6  BF 8C 49        mov di, 0x498c
CDA9  1E              push ds
CDAA  57              push di
CDAB  BF 5C DD        mov di, 0xdd5c
CDAE  1E              push ds
CDAF  57              push di
CDB0  9A 2F 05 1A 23  call far 231A:052F
CDB5  8A 46 F7        mov al, byte ptr [bp - 9]
CDB8  3A 46 F5        cmp al, byte ptr [bp - 0xb]
CDBB  74 07           je 0xcdc4
CDBD  80 3E 18 0D 00  cmp byte ptr [0xd18], 0
CDC2  74 45           je 0xce09
loc_CDC4:
CDC4  A0 7E 03        mov al, byte ptr [0x37e]
CDC7  3A 46 F4        cmp al, byte ptr [bp - 0xc]
CDCA  74 3D           je 0xce09
CDCC  80 7E F4 0E     cmp byte ptr [bp - 0xc], 0xe
CDD0  B0 00           mov al, 0
CDD2  76 01           jbe 0xcdd5
CDD4  40              inc ax
loc_CDD5:
CDD5  30 E4           xor ah, ah
CDD7  8B C8           mov cx, ax
CDD9  80 7E F4 0B     cmp byte ptr [bp - 0xc], 0xb
CDDD  B0 00           mov al, 0
CDDF  76 01           jbe 0xcde2
CDE1  40              inc ax
loc_CDE2:
CDE2  30 E4           xor ah, ah
CDE4  8B D0           mov dx, ax
CDE6  8A 46 F4        mov al, byte ptr [bp - 0xc]
CDE9  30 E4           xor ah, ah
CDEB  40              inc ax
CDEC  03 C2           add ax, dx
CDEE  03 C1           add ax, cx
CDF0  69 C0 A0 00     imul ax, ax, 0xa0
CDF4  C4 3E 5C DD     les di, ptr [0xdd5c]
CDF8  03 F8           add di, ax
CDFA  81 C7 D4 FF     add di, 0xffd4
CDFE  06              push es
CDFF  57              push di
CE00  6A 8F           push -0x71
CE02  6A 0E           push 0xe
CE04  9A 4B 03 AC 24  call far 24AC:034B
loc_CE09:
CE09  80 7E F7 02     cmp byte ptr [bp - 9], 2
CE0D  75 0F           jne 0xce1e
CE0F  BF 24 1D        mov di, 0x1d24
CE12  1E              push ds
CE13  57              push di
CE14  BF 5C DD        mov di, 0xdd5c
CE17  1E              push ds
CE18  57              push di
CE19  9A 2F 05 1A 23  call far 231A:052F
loc_CE1E:
CE1E  C4 3E 5C DD     les di, ptr [0xdd5c]
CE22  06              push es
CE23  57              push di
CE24  C4 3E 58 DD     les di, ptr [0xdd58]
CE28  06              push es
CE29  57              push di
CE2A  68 A0 0F        push 0xfa0
CE2D  9A 12 0A B9 26  call far 26B9:0A12
CE32  9A 9B 09 1A 23  call far 231A:099B
CE37  80 3E 88 DE 01  cmp byte ptr [0xde88], 1
CE3C  75 06           jne 0xce44
CE3E  80 7E F6 00     cmp byte ptr [bp - 0xa], 0
CE42  74 04           je 0xce48
loc_CE44:
CE44  B0 00           mov al, 0
CE46  EB 02           jmp 0xce4a
loc_CE48:
CE48  B0 01           mov al, 1
loc_CE4A:
CE4A  88 46 F1        mov byte ptr [bp - 0xf], al
CE4D  80 7E F6 00     cmp byte ptr [bp - 0xa], 0
CE51  74 0B           je 0xce5e
CE53  80 3E 88 DE 01  cmp byte ptr [0xde88], 1
CE58  75 04           jne 0xce5e
CE5A  C6 46 F6 00     mov byte ptr [bp - 0xa], 0
loc_CE5E:
CE5E  80 3E 88 DE 72  cmp byte ptr [0xde88], 0x72
CE63  75 24           jne 0xce89
CE65  A0 7E 03        mov al, byte ptr [0x37e]
CE68  30 E4           xor ah, ah
CE6A  D1 E0           shl ax, 1
CE6C  8B D0           mov dx, ax
CE6E  8A 46 F7        mov al, byte ptr [bp - 9]
CE71  30 E4           xor ah, ah
CE73  8B F8           mov di, ax
CE75  C1 E7 02        shl di, 2
CE78  C4 7B F4        les di, ptr [bp + di - 0xc]
CE7B  03 FA           add di, dx
CE7D  26 FF 75 FE     push word ptr es:[di - 2]
CE81  6A 01           push 1
CE83  E8 53 DD        call 0xabd9
CE86  E9 90 02        jmp 0xd119
loc_CE89:
CE89  80 3E 88 DE 52  cmp byte ptr [0xde88], 0x52
CE8E  75 24           jne 0xceb4
CE90  A0 7E 03        mov al, byte ptr [0x37e]
CE93  30 E4           xor ah, ah
CE95  D1 E0           shl ax, 1
CE97  8B D0           mov dx, ax
CE99  8A 46 F7        mov al, byte ptr [bp - 9]
CE9C  30 E4           xor ah, ah
CE9E  8B F8           mov di, ax
CEA0  C1 E7 02        shl di, 2
CEA3  C4 7B F4        les di, ptr [bp + di - 0xc]
CEA6  03 FA           add di, dx
CEA8  26 FF 75 FE     push word ptr es:[di - 2]
CEAC  6A 00           push 0
CEAE  E8 28 DD        call 0xabd9
CEB1  E9 65 02        jmp 0xd119
loc_CEB4:
CEB4  A0 88 DE        mov al, byte ptr [0xde88]
CEB7  50              push ax
CEB8  9A 86 19 B9 26  call far 26B9:1986
CEBD  3C 02           cmp al, 2
CEBF  75 4A           jne 0xcf0b
CEC1  80 3E 18 0D 00  cmp byte ptr [0xd18], 0
CEC6  75 06           jne 0xcece
CEC8  55              push bp
CEC9  E8 FA F4        call 0xc3c6
CECC  EB 3A           jmp 0xcf08
loc_CECE:
CECE  80 3E BA D0 00  cmp byte ptr [0xd0ba], 0
CED3  74 13           je 0xcee8
CED5  8A 46 F0        mov al, byte ptr [bp - 0x10]
CED8  50              push ax
CED9  9A B9 46 51 1B  call far 1B51:46B9
CEDE  09 C0           or ax, ax
CEE0  76 06           jbe 0xcee8
CEE2  55              push bp
CEE3  E8 7A F9        call 0xc860
CEE6  EB 20           jmp 0xcf08
loc_CEE8:
CEE8  80 3E E2 D6 00  cmp byte ptr [0xd6e2], 0
CEED  75 14           jne 0xcf03
CEEF  8A 46 F0        mov al, byte ptr [bp - 0x10]
CEF2  50              push ax
CEF3  9A B9 46 51 1B  call far 1B51:46B9
CEF8  09 C0           or ax, ax
CEFA  76 07           jbe 0xcf03
CEFC  C6 06 E2 D6 01  mov byte ptr [0xd6e2], 1
CF01  EB 05           jmp 0xcf08
loc_CF03:
CF03  C6 06 E2 D6 00  mov byte ptr [0xd6e2], 0
loc_CF08:
CF08  E9 0E 02        jmp 0xd119
loc_CF0B:
CF0B  3C 07           cmp al, 7
CF0D  74 04           je 0xcf13
CF0F  3C 08           cmp al, 8
CF11  75 16           jne 0xcf29
loc_CF13:
CF13  80 3E 18 0D 00  cmp byte ptr [0xd18], 0
CF18  75 0C           jne 0xcf26
CF1A  8D 7E F7        lea di, [bp - 9]
CF1D  16              push ss
CF1E  57              push di
CF1F  6A 02           push 2
CF21  9A C4 0E 1A 23  call far 231A:0EC4
loc_CF26:
CF26  E9 F0 01        jmp 0xd119
loc_CF29:
CF29  3C 20           cmp al, 0x20
CF2B  75 42           jne 0xcf6f
CF2D  A0 7E 03        mov al, byte ptr [0x37e]
CF30  30 E4           xor ah, ah
CF32  D1 E0           shl ax, 1
CF34  8B D0           mov dx, ax
CF36  8A 46 F7        mov al, byte ptr [bp - 9]
CF39  30 E4           xor ah, ah
CF3B  8B F8           mov di, ax
CF3D  C1 E7 02        shl di, 2
CF40  C4 7B F4        les di, ptr [bp + di - 0xc]
CF43  03 FA           add di, dx
CF45  26 83 7D FE 00  cmp word ptr es:[di - 2], 0
CF4A  74 20           je 0xcf6c
CF4C  A0 7E 03        mov al, byte ptr [0x37e]
CF4F  30 E4           xor ah, ah
CF51  D1 E0           shl ax, 1
CF53  8B D0           mov dx, ax
CF55  8A 46 F7        mov al, byte ptr [bp - 9]
CF58  30 E4           xor ah, ah
CF5A  8B F8           mov di, ax
CF5C  C1 E7 02        shl di, 2
CF5F  C4 7B F4        les di, ptr [bp + di - 0xc]
CF62  03 FA           add di, dx
CF64  26 FF 75 FE     push word ptr es:[di - 2]
CF68  55              push bp
CF69  E8 61 F5        call 0xc4cd
loc_CF6C:
CF6C  E9 AA 01        jmp 0xd119
loc_CF6F:
CF6F  3C 43           cmp al, 0x43
CF71  75 22           jne 0xcf95
CF73  A0 7E 03        mov al, byte ptr [0x37e]
CF76  30 E4           xor ah, ah
CF78  D1 E0           shl ax, 1
CF7A  8B D0           mov dx, ax
CF7C  8A 46 F7        mov al, byte ptr [bp - 9]
CF7F  30 E4           xor ah, ah
CF81  8B F8           mov di, ax
CF83  C1 E7 02        shl di, 2
CF86  C4 7B F4        les di, ptr [bp + di - 0xc]
CF89  03 FA           add di, dx
CF8B  26 FF 75 FE     push word ptr es:[di - 2]
CF8F  E8 C0 DC        call 0xac52
CF92  E9 84 01        jmp 0xd119
loc_CF95:
CF95  3C 54           cmp al, 0x54
CF97  75 47           jne 0xcfe0
CF99  A0 7E 03        mov al, byte ptr [0x37e]
CF9C  30 E4           xor ah, ah
CF9E  D1 E0           shl ax, 1
CFA0  8B D0           mov dx, ax
CFA2  8A 46 F7        mov al, byte ptr [bp - 9]
CFA5  30 E4           xor ah, ah
CFA7  8B F8           mov di, ax
CFA9  C1 E7 02        shl di, 2
CFAC  C4 7B F4        les di, ptr [bp + di - 0xc]
CFAF  03 FA           add di, dx
CFB1  26 83 7D FE 00  cmp word ptr es:[di - 2], 0
CFB6  74 25           je 0xcfdd
CFB8  A0 7E 03        mov al, byte ptr [0x37e]
CFBB  30 E4           xor ah, ah
CFBD  D1 E0           shl ax, 1
CFBF  8B D0           mov dx, ax
CFC1  8A 46 F7        mov al, byte ptr [bp - 9]
CFC4  30 E4           xor ah, ah
CFC6  8B F8           mov di, ax
CFC8  C1 E7 02        shl di, 2
CFCB  C4 7B F4        les di, ptr [bp + di - 0xc]
CFCE  03 FA           add di, dx
CFD0  26 FF 75 FE     push word ptr es:[di - 2]
CFD4  A0 7E 03        mov al, byte ptr [0x37e]
CFD7  30 E4           xor ah, ah
CFD9  50              push ax
CFDA  E8 94 E2        call 0xb271
loc_CFDD:
CFDD  E9 39 01        jmp 0xd119
loc_CFE0:
CFE0  3C 48           cmp al, 0x48
CFE2  75 41           jne 0xd025
CFE4  A0 18 0D        mov al, byte ptr [0xd18]
CFE7  50              push ax
CFE8  BF BF CB        mov di, 0xcbbf
CFEB  0E              push cs
CFEC  57              push di
CFED  9A 98 00 1A 23  call far 231A:0098
CFF2  08 C0           or al, al
CFF4  75 2C           jne 0xd022
CFF6  C6 46 F7 02     mov byte ptr [bp - 9], 2
CFFA  C4 7E EC        les di, ptr [bp - 0x14]
CFFD  26 8A 45 04     mov al, byte ptr es:[di + 4]
D001  30 E4           xor ah, ah
D003  50              push ax
D004  26 8A 45 04     mov al, byte ptr es:[di + 4]
D008  30 E4           xor ah, ah
D00A  8B F8           mov di, ax
D00C  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
D010  30 E4           xor ah, ah
D012  50              push ax
D013  9A BA 5D 51 1B  call far 1B51:5DBA
D018  83 3E 84 D6 00  cmp word ptr [0xd684], 0
D01D  74 03           je 0xd022
D01F  E8 AF C5        call 0x95d1
loc_D022:
D022  E9 F4 00        jmp 0xd119
loc_D025:
D025  3C 46           cmp al, 0x46
D027  75 41           jne 0xd06a
D029  80 3E 18 0D 00  cmp byte ptr [0xd18], 0
D02E  75 37           jne 0xd067
D030  A0 7E 03        mov al, byte ptr [0x37e]
D033  30 E4           xor ah, ah
D035  D1 E0           shl ax, 1
D037  8B D0           mov dx, ax
D039  8A 46 F7        mov al, byte ptr [bp - 9]
D03C  30 E4           xor ah, ah
D03E  8B F8           mov di, ax
D040  C1 E7 02        shl di, 2
D043  C4 7B F4        les di, ptr [bp + di - 0xc]
D046  03 FA           add di, dx
D048  26 83 7D FE 00  cmp word ptr es:[di - 2], 0
D04D  74 18           je 0xd067
D04F  8A 46 F7        mov al, byte ptr [bp - 9]
D052  30 E4           xor ah, ah
D054  8B F8           mov di, ax
D056  C1 E7 02        shl di, 2
D059  C4 7B F4        les di, ptr [bp + di - 0xc]
D05C  06              push es
D05D  57              push di
D05E  A0 7E 03        mov al, byte ptr [0x37e]
D061  30 E4           xor ah, ah
D063  50              push ax
D064  E8 3D D0        call 0xa0a4
loc_D067:
D067  E9 AF 00        jmp 0xd119
loc_D06A:
D06A  3C 53           cmp al, 0x53
D06C  75 24           jne 0xd092
D06E  A0 7E 03        mov al, byte ptr [0x37e]
D071  30 E4           xor ah, ah
D073  D1 E0           shl ax, 1
D075  8B D0           mov dx, ax
D077  8A 46 F7        mov al, byte ptr [bp - 9]
D07A  30 E4           xor ah, ah
D07C  8B F8           mov di, ax
D07E  C1 E7 02        shl di, 2
D081  C4 7B F4        les di, ptr [bp + di - 0xc]
D084  03 FA           add di, dx
D086  26 FF 75 FE     push word ptr es:[di - 2]
D08A  9A 2F 66 51 1B  call far 1B51:662F
D08F  E9 87 00        jmp 0xd119
loc_D092:
D092  3C 55           cmp al, 0x55
D094  75 21           jne 0xd0b7
D096  A0 7E 03        mov al, byte ptr [0x37e]
D099  30 E4           xor ah, ah
D09B  D1 E0           shl ax, 1
D09D  8B D0           mov dx, ax
D09F  8A 46 F7        mov al, byte ptr [bp - 9]
D0A2  30 E4           xor ah, ah
D0A4  8B F8           mov di, ax
D0A6  C1 E7 02        shl di, 2
D0A9  C4 7B F4        les di, ptr [bp + di - 0xc]
D0AC  03 FA           add di, dx
D0AE  26 FF 75 FE     push word ptr es:[di - 2]
D0B2  E8 A3 F2        call 0xc358
D0B5  EB 62           jmp 0xd119
loc_D0B7:
D0B7  3C 4E           cmp al, 0x4e
D0B9  75 26           jne 0xd0e1
D0BB  A0 7E 03        mov al, byte ptr [0x37e]
D0BE  30 E4           xor ah, ah
D0C0  D1 E0           shl ax, 1
D0C2  8B D0           mov dx, ax
D0C4  8A 46 F7        mov al, byte ptr [bp - 9]
D0C7  30 E4           xor ah, ah
D0C9  8B F8           mov di, ax
D0CB  C1 E7 02        shl di, 2
D0CE  C4 7B F4        les di, ptr [bp + di - 0xc]
D0D1  03 FA           add di, dx
D0D3  26 FF 75 FE     push word ptr es:[di - 2]
D0D7  6A 00           push 0
D0D9  6A 00           push 0
D0DB  0E              push cs
D0DC  E8 C4 EF        call 0xc0a3
D0DF  EB 38           jmp 0xd119
loc_D0E1:
D0E1  3C 0D           cmp al, 0xd
D0E3  75 0F           jne 0xd0f4
D0E5  80 3E 2A 9A 00  cmp byte ptr [0x9a2a], 0
D0EA  B0 00           mov al, 0
D0EC  75 01           jne 0xd0ef
D0EE  40              inc ax
loc_D0EF:
D0EF  A2 2A 9A        mov byte ptr [0x9a2a], al
D0F2  EB 25           jmp 0xd119
loc_D0F4:
D0F4  80 3E 18 0D 00  cmp byte ptr [0xd18], 0
D0F9  74 12           je 0xd10d
D0FB  BF 7E 03        mov di, 0x37e
D0FE  1E              push ds
D0FF  57              push di
D100  9A 76 0B 94 19  call far 1994:0B76
D105  50              push ax
D106  9A C4 0E 1A 23  call far 231A:0EC4
D10B  EB 0C           jmp 0xd119
loc_D10D:
D10D  BF 7E 03        mov di, 0x37e
D110  1E              push ds
D111  57              push di
D112  6A 14           push 0x14
D114  9A C4 0E 1A 23  call far 231A:0EC4
loc_D119:
D119  80 7E F1 00     cmp byte ptr [bp - 0xf], 0
D11D  75 03           jne 0xd122
D11F  E9 8F FB        jmp 0xccb1
loc_D122:
D122  C4 7E EC        les di, ptr [bp - 0x14]
D125  26 8A 45 04     mov al, byte ptr es:[di + 4]
D129  30 E4           xor ah, ah
D12B  8B F8           mov di, ax
D12D  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
D131  30 E4           xor ah, ah
D133  6B C0 3E        imul ax, ax, 0x3e
D136  C4 3E C2 D7     les di, ptr [0xd7c2]
D13A  03 F8           add di, ax
D13C  81 C7 C2 FF     add di, 0xffc2
D140  89 7E E8        mov word ptr [bp - 0x18], di
D143  8C 46 EA        mov word ptr [bp - 0x16], es
D146  26 C6 45 32 00  mov byte ptr es:[di + 0x32], 0
D14B  C7 46 F2 01 00  mov word ptr [bp - 0xe], 1
D150  EB 03           jmp 0xd155
loc_D152:
D152  FF 46 F2        inc word ptr [bp - 0xe]
loc_D155:
D155  8B 46 F2        mov ax, word ptr [bp - 0xe]
D158  D1 E0           shl ax, 1
D15A  C4 7E E8        les di, ptr [bp - 0x18]
D15D  03 F8           add di, ax
D15F  26 83 7D FE 00  cmp word ptr es:[di - 2], 0
D164  74 07           je 0xd16d
D166  C4 7E E8        les di, ptr [bp - 0x18]
D169  26 FE 45 32     inc byte ptr es:[di + 0x32]
loc_D16D:
D16D  83 7E F2 14     cmp word ptr [bp - 0xe], 0x14
D171  75 DF           jne 0xd152
D173  C7 46 F2 01 00  mov word ptr [bp - 0xe], 1
D178  EB 03           jmp 0xd17d
loc_D17A:
D17A  FF 46 F2        inc word ptr [bp - 0xe]
loc_D17D:
D17D  8B 46 F2        mov ax, word ptr [bp - 0xe]
D180  D1 E0           shl ax, 1
D182  8B D0           mov dx, ax
D184  C4 7E EC        les di, ptr [bp - 0x14]
D187  26 8A 45 04     mov al, byte ptr es:[di + 4]
D18B  30 E4           xor ah, ah
D18D  6B C0 28        imul ax, ax, 0x28
D190  03 F8           add di, ax
D192  03 FA           add di, dx
D194  26 83 7D 2E 00  cmp word ptr es:[di + 0x2e], 0
D199  74 07           je 0xd1a2
D19B  C4 7E E8        les di, ptr [bp - 0x18]
D19E  26 FE 45 32     inc byte ptr es:[di + 0x32]
loc_D1A2:
D1A2  83 7E F2 14     cmp word ptr [bp - 0xe], 0x14
D1A6  75 D2           jne 0xd17a
D1A8  C4 7E EC        les di, ptr [bp - 0x14]
D1AB  26 8A 45 04     mov al, byte ptr es:[di + 4]
D1AF  30 E4           xor ah, ah
D1B1  6B C0 28        imul ax, ax, 0x28
D1B4  03 F8           add di, ax
D1B6  81 C7 30 00     add di, 0x30
D1BA  06              push es
D1BB  57              push di
D1BC  C4 7E EC        les di, ptr [bp - 0x14]
D1BF  26 8A 45 04     mov al, byte ptr es:[di + 4]
D1C3  30 E4           xor ah, ah
D1C5  8B F8           mov di, ax
D1C7  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
D1CB  30 E4           xor ah, ah
D1CD  50              push ax
D1CE  9A B8 76 51 1B  call far 1B51:76B8
D1D3  C9              leave
D1D4  CA 02 00        retf 2

