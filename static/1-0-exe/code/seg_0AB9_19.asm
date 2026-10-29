; 1-0.EXE (One-Nil 96), code segment 0AB9 (image offsets 0AB90..1997F), part 19 of 22
; packed 1-0.EXE sha256 89ff9c5f238f24e81a0c2440a46cdd8997280a65fc3cc3d97cb974f55280a80a (LZEXE 0.91)
; unpacked (tools/static/unlzexe.py) sha256 887ed2a92767950e5309b2052409f875668605939b69e00737aa3047022b9f51
; tool: capstone 5.0.9 (pip package; core library 5.0.1280) (CS_ARCH_X86, CS_MODE_16), recursive descent from the entry point, far calls and near calls/jumps, then routine prologues (55 89 E5 / 55 8B EC / C8 iw 00) in what remains; tools/static/listing.py
; addresses are SEGMENT:OFFSET with SEGMENT the image paragraph before relocation; image offset = SEGMENT*16+OFFSET
; ---- routine 0AB9:C358  (found by: call)
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
C390  9A B5 36 55 1B  call far 1B55:36B5
C395  50              push ax
C396  BF 3C C3        mov di, 0xc33c
C399  0E              push cs
C39A  57              push di
C39B  9A 98 00 2A 23  call far 232A:0098
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

; ---- routine 0AB9:C3C6  (found by: call)
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
C421  9A 03 02 BC 24  call far 24BC:0203
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
C466  9A 77 77 55 1B  call far 1B55:7777
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

; ---- routine 0AB9:C4B3  (found by: call)
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

; ---- routine 0AB9:C4CD  (found by: call)
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
C4E3  9A 22 02 BC 24  call far 24BC:0222
C4E8  C7 46 F4 04 00  mov word ptr [bp - 0xc], 4
C4ED  EB 03           jmp 0xc4f2
loc_C4EF:
C4EF  FF 46 F4        inc word ptr [bp - 0xc]
loc_C4F2:
C4F2  83 7E F4 05     cmp word ptr [bp - 0xc], 5
C4F6  74 0E           je 0xc506
C4F8  80 3E 18 0D 00  cmp byte ptr [0xd18], 0
C4FD  74 07           je 0xc506
C4FF  8B 7E F4        mov di, word ptr [bp - 0xc]
C502  C6 43 F5 00     mov byte ptr [bp + di - 0xb], 0
loc_C506:
C506  83 7E F4 07     cmp word ptr [bp - 0xc], 7
C50A  75 E3           jne 0xc4ef
C50C  8B 46 06        mov ax, word ptr [bp + 6]
C50F  C1 E0 03        shl ax, 3
C512  C4 3E BA D7     les di, ptr [0xd7ba]
C516  03 F8           add di, ax
C518  26 80 7D 07 00  cmp byte ptr es:[di + 7], 0
C51D  75 04           jne 0xc523
C51F  C6 46 F6 00     mov byte ptr [bp - 0xa], 0
loc_C523:
C523  6B 46 06 0F     imul ax, word ptr [bp + 6], 0xf
C527  C4 3E BE D7     les di, ptr [0xd7be]
C52B  03 F8           add di, ax
C52D  26 80 7D 0D 02  cmp byte ptr es:[di + 0xd], 2
C532  75 06           jne 0xc53a
C534  C6 46 F8 00     mov byte ptr [bp - 8], 0
C538  EB 04           jmp 0xc53e
loc_C53A:
C53A  C6 46 F9 00     mov byte ptr [bp - 7], 0
loc_C53E:
C53E  C7 46 F4 02 00  mov word ptr [bp - 0xc], 2
C543  EB 03           jmp 0xc548
loc_C545:
C545  FF 46 F4        inc word ptr [bp - 0xc]
loc_C548:
C548  83 7E F4 05     cmp word ptr [bp - 0xc], 5
C54C  74 1A           je 0xc568
C54E  8B 46 06        mov ax, word ptr [bp + 6]
C551  C1 E0 03        shl ax, 3
C554  C4 3E BA D7     les di, ptr [0xd7ba]
C558  03 F8           add di, ax
C55A  26 80 7D 01 12  cmp byte ptr es:[di + 1], 0x12
C55F  73 07           jae 0xc568
C561  8B 7E F4        mov di, word ptr [bp - 0xc]
C564  C6 43 F5 00     mov byte ptr [bp + di - 0xb], 0
loc_C568:
C568  83 7E F4 06     cmp word ptr [bp - 0xc], 6
C56C  75 D7           jne 0xc545
C56E  6B 46 06 0F     imul ax, word ptr [bp + 6], 0xf
C572  C4 3E BE D7     les di, ptr [0xd7be]
C576  03 F8           add di, ax
C578  26 80 7D 0D 03  cmp byte ptr es:[di + 0xd], 3
C57D  75 04           jne 0xc583
C57F  C6 46 FC 00     mov byte ptr [bp - 4], 0
loc_C583:
C583  BF 22 63        mov di, 0x6322
C586  1E              push ds
C587  57              push di
C588  BF 5C DD        mov di, 0xdd5c
C58B  1E              push ds
C58C  57              push di
C58D  9A 2F 05 2A 23  call far 232A:052F
C592  BF 7A 43        mov di, 0x437a
C595  1E              push ds
C596  57              push di
C597  BF 5C DD        mov di, 0xdd5c
C59A  1E              push ds
C59B  57              push di
C59C  9A 2F 05 2A 23  call far 232A:052F
C5A1  FF 76 06        push word ptr [bp + 6]
C5A4  0E              push cs
C5A5  E8 0B D0        call 0x95b3
C5A8  FF 76 06        push word ptr [bp + 6]
C5AB  8B 46 06        mov ax, word ptr [bp + 6]
C5AE  C1 E0 03        shl ax, 3
C5B1  C4 3E BA D7     les di, ptr [0xd7ba]
C5B5  03 F8           add di, ax
C5B7  26 8A 45 06     mov al, byte ptr es:[di + 6]
C5BB  30 E4           xor ah, ah
C5BD  50              push ax
C5BE  9A 4A 72 55 1B  call far 1B55:724A
C5C3  50              push ax
C5C4  8D BE F4 FE     lea di, [bp - 0x10c]
C5C8  16              push ss
C5C9  57              push di
C5CA  8B 46 06        mov ax, word ptr [bp + 6]
C5CD  C4 3E AA D7     les di, ptr [0xd7aa]
C5D1  03 F8           add di, ax
C5D3  26 8A 05        mov al, byte ptr es:[di]
C5D6  50              push ax
C5D7  9A 6F 0C C9 26  call far 26C9:0C6F
C5DC  BF CB C4        mov di, 0xc4cb
C5DF  0E              push cs
C5E0  57              push di
C5E1  9A D2 0B C9 26  call far 26C9:0BD2
C5E6  8D BE F4 FD     lea di, [bp - 0x20c]
C5EA  16              push ss
C5EB  57              push di
C5EC  FF 76 06        push word ptr [bp + 6]
C5EF  9A DC 44 55 1B  call far 1B55:44DC
C5F4  9A D2 0B C9 26  call far 26C9:0BD2
C5F9  6A 03           push 3
C5FB  6A 3C           push 0x3c
C5FD  BF 5C DD        mov di, 0xdd5c
C600  1E              push ds
C601  57              push di
C602  9A 1B 04 2A 23  call far 232A:041B
C607  A0 D4 0C        mov al, byte ptr [0xcd4]
C60A  30 E4           xor ah, ah
C60C  8B F8           mov di, ax
C60E  8A 85 CB 0C     mov al, byte ptr [di + 0xccb]
C612  30 E4           xor ah, ah
C614  50              push ax
C615  6A 3B           push 0x3b
C617  6A 11           push 0x11
C619  9A 03 02 2A 23  call far 232A:0203
C61E  C7 46 F4 01 00  mov word ptr [bp - 0xc], 1
C623  EB 03           jmp 0xc628
loc_C625:
C625  FF 46 F4        inc word ptr [bp - 0xc]
loc_C628:
C628  6A 0E           push 0xe
C62A  8D BE F4 FE     lea di, [bp - 0x10c]
C62E  16              push ss
C62F  57              push di
C630  8B 7E F4        mov di, word ptr [bp - 0xc]
C633  8A 43 F5        mov al, byte ptr [bp + di - 0xb]
C636  98              cwde
C637  8B F8           mov di, ax
C639  8A 85 EA A2     mov al, byte ptr [di - 0x5d16]
C63D  50              push ax
C63E  9A 6F 0C C9 26  call far 26C9:0C6F
C643  8B 7E F4        mov di, word ptr [bp - 0xc]
C646  8A 85 CB 0C     mov al, byte ptr [di + 0xccb]
C64A  50              push ax
C64B  6A 4D           push 0x4d
C64D  BF 5C DD        mov di, 0xdd5c
C650  1E              push ds
C651  57              push di
C652  9A 1B 04 2A 23  call far 232A:041B
C657  83 7E F4 08     cmp word ptr [bp - 0xc], 8
C65B  75 C8           jne 0xc625
C65D  BF D4 0C        mov di, 0xcd4
C660  1E              push ds
C661  57              push di
C662  6A 08           push 8
C664  9A 8B 0F 2A 23  call far 232A:0F8B
C669  80 3E 88 DE 72  cmp byte ptr [0xde88], 0x72
C66E  75 08           jne 0xc678
C670  6A 01           push 1
C672  55              push bp
C673  E8 3D FE        call 0xc4b3
C676  EB 70           jmp 0xc6e8
loc_C678:
C678  A0 88 DE        mov al, byte ptr [0xde88]
C67B  50              push ax
C67C  9A 86 19 C9 26  call far 26C9:1986
C681  3C 52           cmp al, 0x52
C683  75 08           jne 0xc68d
C685  6A 01           push 1
C687  55              push bp
C688  E8 28 FE        call 0xc4b3
C68B  EB 5B           jmp 0xc6e8
loc_C68D:
C68D  3C 43           cmp al, 0x43
C68F  75 08           jne 0xc699
C691  6A 02           push 2
C693  55              push bp
C694  E8 1C FE        call 0xc4b3
C697  EB 4F           jmp 0xc6e8
loc_C699:
C699  3C 53           cmp al, 0x53
C69B  75 08           jne 0xc6a5
C69D  6A 03           push 3
C69F  55              push bp
C6A0  E8 10 FE        call 0xc4b3
C6A3  EB 43           jmp 0xc6e8
loc_C6A5:
C6A5  3C 55           cmp al, 0x55
C6A7  75 08           jne 0xc6b1
C6A9  6A 04           push 4
C6AB  55              push bp
C6AC  E8 04 FE        call 0xc4b3
C6AF  EB 37           jmp 0xc6e8
loc_C6B1:
C6B1  3C 54           cmp al, 0x54
C6B3  75 08           jne 0xc6bd
C6B5  6A 05           push 5
C6B7  55              push bp
C6B8  E8 F8 FD        call 0xc4b3
C6BB  EB 2B           jmp 0xc6e8
loc_C6BD:
C6BD  3C 4E           cmp al, 0x4e
C6BF  75 08           jne 0xc6c9
C6C1  6A 06           push 6
C6C3  55              push bp
C6C4  E8 EC FD        call 0xc4b3
C6C7  EB 1F           jmp 0xc6e8
loc_C6C9:
C6C9  3C 46           cmp al, 0x46
C6CB  75 08           jne 0xc6d5
C6CD  6A 07           push 7
C6CF  55              push bp
C6D0  E8 E0 FD        call 0xc4b3
C6D3  EB 13           jmp 0xc6e8
loc_C6D5:
C6D5  80 3E 88 DE 02  cmp byte ptr [0xde88], 2
C6DA  75 0C           jne 0xc6e8
C6DC  80 3E D4 0C 01  cmp byte ptr [0xcd4], 1
C6E1  75 05           jne 0xc6e8
C6E3  C6 06 8A DE 72  mov byte ptr [0xde8a], 0x72
loc_C6E8:
C6E8  80 3E 88 DE 01  cmp byte ptr [0xde88], 1
C6ED  75 07           jne 0xc6f6
C6EF  C6 46 FF 01     mov byte ptr [bp - 1], 1
C6F3  E9 C3 00        jmp 0xc7b9
loc_C6F6:
C6F6  80 3E 88 DE 0D  cmp byte ptr [0xde88], 0xd
C6FB  75 10           jne 0xc70d
C6FD  80 3E 2A 9A 00  cmp byte ptr [0x9a2a], 0
C702  B0 00           mov al, 0
C704  75 01           jne 0xc707
C706  40              inc ax
loc_C707:
C707  A2 2A 9A        mov byte ptr [0x9a2a], al
C70A  E9 AC 00        jmp 0xc7b9
loc_C70D:
C70D  80 3E 88 DE 02  cmp byte ptr [0xde88], 2
C712  74 03           je 0xc717
C714  E9 A2 00        jmp 0xc7b9
loc_C717:
C717  A0 D4 0C        mov al, byte ptr [0xcd4]
C71A  30 E4           xor ah, ah
C71C  8B F8           mov di, ax
C71E  80 7B F5 00     cmp byte ptr [bp + di - 0xb], 0
C722  75 03           jne 0xc727
C724  E9 92 00        jmp 0xc7b9
loc_C727:
C727  A0 D4 0C        mov al, byte ptr [0xcd4]
C72A  3C 01           cmp al, 1
C72C  75 13           jne 0xc741
C72E  FF 76 06        push word ptr [bp + 6]
C731  80 3E 8A DE 72  cmp byte ptr [0xde8a], 0x72
C736  B0 00           mov al, 0
C738  75 01           jne 0xc73b
C73A  40              inc ax
loc_C73B:
C73B  50              push ax
C73C  E8 9A E4        call 0xabd9
C73F  EB 78           jmp 0xc7b9
loc_C741:
C741  3C 02           cmp al, 2
C743  75 08           jne 0xc74d
C745  FF 76 06        push word ptr [bp + 6]
C748  E8 07 E5        call 0xac52
C74B  EB 6C           jmp 0xc7b9
loc_C74D:
C74D  3C 03           cmp al, 3
C74F  75 0A           jne 0xc75b
C751  FF 76 06        push word ptr [bp + 6]
C754  9A EE 66 55 1B  call far 1B55:66EE
C759  EB 5E           jmp 0xc7b9
loc_C75B:
C75B  3C 04           cmp al, 4
C75D  75 08           jne 0xc767
C75F  FF 76 06        push word ptr [bp + 6]
C762  E8 F3 FB        call 0xc358
C765  EB 52           jmp 0xc7b9
loc_C767:
C767  3C 05           cmp al, 5
C769  75 0E           jne 0xc779
C76B  FF 76 06        push word ptr [bp + 6]
C76E  A0 7E 03        mov al, byte ptr [0x37e]
C771  30 E4           xor ah, ah
C773  50              push ax
C774  E8 FA EA        call 0xb271
C777  EB 40           jmp 0xc7b9
loc_C779:
C779  3C 06           cmp al, 6
C77B  75 0D           jne 0xc78a
C77D  FF 76 06        push word ptr [bp + 6]
C780  6A 00           push 0
C782  6A 00           push 0
C784  0E              push cs
C785  E8 1B F9        call 0xc0a3
C788  EB 2F           jmp 0xc7b9
loc_C78A:
C78A  3C 07           cmp al, 7
C78C  75 23           jne 0xc7b1
C78E  8B 7E 04        mov di, word ptr [bp + 4]
C791  36 8A 45 F7     mov al, byte ptr ss:[di - 9]
C795  30 E4           xor ah, ah
C797  C1 E0 02        shl ax, 2
C79A  03 F8           add di, ax
C79C  36 C4 7D F4     les di, ptr ss:[di - 0xc]
C7A0  06              push es
C7A1  57              push di
C7A2  A0 7E 03        mov al, byte ptr [0x37e]
C7A5  30 E4           xor ah, ah
C7A7  50              push ax
C7A8  E8 F9 D8        call 0xa0a4
C7AB  C6 46 FF 01     mov byte ptr [bp - 1], 1
C7AF  EB 08           jmp 0xc7b9
loc_C7B1:
C7B1  3C 08           cmp al, 8
C7B3  75 04           jne 0xc7b9
C7B5  C6 46 FF 01     mov byte ptr [bp - 1], 1
loc_C7B9:
C7B9  80 7E FF 00     cmp byte ptr [bp - 1], 0
C7BD  75 03           jne 0xc7c2
C7BF  E9 18 FD        jmp 0xc4da
loc_C7C2:
C7C2  C6 06 88 DE 00  mov byte ptr [0xde88], 0
C7C7  C9              leave
C7C8  C2 04 00        ret 4
; data (not reached as code), 155 bytes
C7CB                  pstr 'There is no player here'
C7E3                  pstr 'Your final substitute must be a goalkeeper'
C80E                  pstr 'Illegal substitution'
C823                  pstr 'You cannot have two goalkeepers on the pitch'
C850                  pstr ' cannot play'
C85D                  pstr 'Nice try'

; ---- routine 0AB9:C866  (found by: call)
sub_C866:
C866  C8 08 01 00     enter 0x108, 0
C86A  8B 7E 04        mov di, word ptr [bp + 4]
C86D  36 80 7D F6 00  cmp byte ptr ss:[di - 0xa], 0
C872  74 03           je 0xc877
C874  E9 85 00        jmp 0xc8fc
loc_C877:
C877  A0 7E 03        mov al, byte ptr [0x37e]
C87A  30 E4           xor ah, ah
C87C  D1 E0           shl ax, 1
C87E  36 C4 7D F8     les di, ptr ss:[di - 8]
C882  03 F8           add di, ax
C884  26 83 7D FE 00  cmp word ptr es:[di - 2], 0
C889  B0 00           mov al, 0
C88B  75 01           jne 0xc88e
C88D  40              inc ax
loc_C88E:
C88E  50              push ax
C88F  BF CB C7        mov di, 0xc7cb
C892  0E              push cs
C893  57              push di
C894  9A 98 00 2A 23  call far 232A:0098
C899  08 C0           or al, al
C89B  75 4A           jne 0xc8e7
C89D  8B 7E 04        mov di, word ptr [bp + 4]
C8A0  36 8A 45 F0     mov al, byte ptr ss:[di - 0x10]
C8A4  98              cwde
C8A5  8B F8           mov di, ax
C8A7  80 BD E0 D6 00  cmp byte ptr [di - 0x2920], 0
C8AC  75 24           jne 0xc8d2
C8AE  A0 7E 03        mov al, byte ptr [0x37e]
C8B1  30 E4           xor ah, ah
C8B3  D1 E0           shl ax, 1
C8B5  8B 7E 04        mov di, word ptr [bp + 4]
C8B8  36 C4 7D F8     les di, ptr ss:[di - 8]
C8BC  03 F8           add di, ax
C8BE  26 8B 45 FE     mov ax, word ptr es:[di - 2]
C8C2  C1 E0 03        shl ax, 3
C8C5  C4 3E BA D7     les di, ptr [0xd7ba]
C8C9  03 F8           add di, ax
C8CB  26 80 7D 06 00  cmp byte ptr es:[di + 6], 0
C8D0  75 04           jne 0xc8d6
loc_C8D2:
C8D2  B0 00           mov al, 0
C8D4  EB 02           jmp 0xc8d8
loc_C8D6:
C8D6  B0 01           mov al, 1
loc_C8D8:
C8D8  50              push ax
C8D9  BF E3 C7        mov di, 0xc7e3
C8DC  0E              push cs
C8DD  57              push di
C8DE  9A 98 00 2A 23  call far 232A:0098
C8E3  08 C0           or al, al
C8E5  74 03           je 0xc8ea
loc_C8E7:
C8E7  E9 7F 02        jmp 0xcb69
loc_C8EA:
C8EA  A0 7E 03        mov al, byte ptr [0x37e]
C8ED  8B 7E 04        mov di, word ptr [bp + 4]
C8F0  36 88 45 F4     mov byte ptr ss:[di - 0xc], al
C8F4  36 C6 45 F6 01  mov byte ptr ss:[di - 0xa], 1
C8F9  E9 6D 02        jmp 0xcb69
loc_C8FC:
C8FC  8B 7E 04        mov di, word ptr [bp + 4]
C8FF  36 C6 45 F6 00  mov byte ptr ss:[di - 0xa], 0
C904  36 80 7D F4 0C  cmp byte ptr ss:[di - 0xc], 0xc
C909  B0 00           mov al, 0
C90B  73 01           jae 0xc90e
C90D  40              inc ax
loc_C90E:
C90E  8A D0           mov dl, al
C910  80 3E 7E 03 0C  cmp byte ptr [0x37e], 0xc
C915  B0 00           mov al, 0
C917  73 01           jae 0xc91a
C919  40              inc ax
loc_C91A:
C91A  3A C2           cmp al, dl
C91C  B0 00           mov al, 0
C91E  75 01           jne 0xc921
C920  40              inc ax
loc_C921:
C921  50              push ax
C922  BF 0E C8        mov di, 0xc80e
C925  0E              push cs
C926  57              push di
C927  9A 98 00 2A 23  call far 232A:0098
C92C  08 C0           or al, al
C92E  74 03           je 0xc933
C930  E9 36 02        jmp 0xcb69
loc_C933:
C933  A0 7E 03        mov al, byte ptr [0x37e]
C936  30 E4           xor ah, ah
C938  31 D2           xor dx, dx
C93A  52              push dx
C93B  50              push ax
C93C  8B 7E 04        mov di, word ptr [bp + 4]
C93F  36 8A 45 F4     mov al, byte ptr ss:[di - 0xc]
C943  30 E4           xor ah, ah
C945  31 D2           xor dx, dx
C947  52              push dx
C948  50              push ax
C949  9A C0 04 BC 24  call far 24BC:04C0
C94E  89 46 FE        mov word ptr [bp - 2], ax
C951  A0 7E 03        mov al, byte ptr [0x37e]
C954  30 E4           xor ah, ah
C956  31 D2           xor dx, dx
C958  52              push dx
C959  50              push ax
C95A  8B 7E 04        mov di, word ptr [bp + 4]
C95D  36 8A 45 F4     mov al, byte ptr ss:[di - 0xc]
C961  30 E4           xor ah, ah
C963  31 D2           xor dx, dx
C965  52              push dx
C966  50              push ax
C967  9A FA 04 BC 24  call far 24BC:04FA
C96C  89 46 FC        mov word ptr [bp - 4], ax
C96F  C4 3E D2 D7     les di, ptr [0xd7d2]
C973  26 8A 45 04     mov al, byte ptr es:[di + 4]
C977  30 E4           xor ah, ah
C979  8B F8           mov di, ax
C97B  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
C97F  30 E4           xor ah, ah
C981  6B C0 3E        imul ax, ax, 0x3e
C984  C4 3E C2 D7     les di, ptr [0xd7c2]
C988  03 F8           add di, ax
C98A  81 C7 C2 FF     add di, 0xffc2
C98E  89 7E F4        mov word ptr [bp - 0xc], di
C991  8C 46 F6        mov word ptr [bp - 0xa], es
C994  8B 46 FE        mov ax, word ptr [bp - 2]
C997  D1 E0           shl ax, 1
C999  03 F8           add di, ax
C99B  26 8B 45 FE     mov ax, word ptr es:[di - 2]
C99F  C1 E0 03        shl ax, 3
C9A2  C4 3E BA D7     les di, ptr [0xd7ba]
C9A6  03 F8           add di, ax
C9A8  26 80 7D 07 00  cmp byte ptr es:[di + 7], 0
C9AD  75 65           jne 0xca14
C9AF  C7 46 FA 01 00  mov word ptr [bp - 6], 1
C9B4  EB 03           jmp 0xc9b9
loc_C9B6:
C9B6  FF 46 FA        inc word ptr [bp - 6]
loc_C9B9:
C9B9  8B 46 FA        mov ax, word ptr [bp - 6]
C9BC  3B 46 FC        cmp ax, word ptr [bp - 4]
C9BF  74 4D           je 0xca0e
C9C1  8B 46 FA        mov ax, word ptr [bp - 6]
C9C4  D1 E0           shl ax, 1
C9C6  C4 7E F4        les di, ptr [bp - 0xc]
C9C9  03 F8           add di, ax
C9CB  26 FF 75 FE     push word ptr es:[di - 2]
C9CF  9A 89 4F 55 1B  call far 1B55:4F89
C9D4  08 C0           or al, al
C9D6  75 1E           jne 0xc9f6
C9D8  8B 46 FA        mov ax, word ptr [bp - 6]
C9DB  D1 E0           shl ax, 1
C9DD  C4 7E F4        les di, ptr [bp - 0xc]
C9E0  03 F8           add di, ax
C9E2  26 8B 45 FE     mov ax, word ptr es:[di - 2]
C9E6  C1 E0 03        shl ax, 3
C9E9  C4 3E BA D7     les di, ptr [0xd7ba]
C9ED  03 F8           add di, ax
C9EF  26 80 7D 07 00  cmp byte ptr es:[di + 7], 0
C9F4  74 04           je 0xc9fa
loc_C9F6:
C9F6  B0 00           mov al, 0
C9F8  EB 02           jmp 0xc9fc
loc_C9FA:
C9FA  B0 01           mov al, 1
loc_C9FC:
C9FC  50              push ax
C9FD  BF 23 C8        mov di, 0xc823
CA00  0E              push cs
CA01  57              push di
CA02  9A 98 00 2A 23  call far 232A:0098
CA07  08 C0           or al, al
CA09  74 03           je 0xca0e
CA0B  E9 5B 01        jmp 0xcb69
loc_CA0E:
CA0E  83 7E FA 0B     cmp word ptr [bp - 6], 0xb
CA12  75 A2           jne 0xc9b6
loc_CA14:
CA14  8B 46 FE        mov ax, word ptr [bp - 2]
CA17  D1 E0           shl ax, 1
CA19  8B 7E 04        mov di, word ptr [bp + 4]
CA1C  36 C4 7D F8     les di, ptr ss:[di - 8]
CA20  03 F8           add di, ax
CA22  26 FF 75 FE     push word ptr es:[di - 2]
CA26  9A 89 4F 55 1B  call far 1B55:4F89
CA2B  50              push ax
CA2C  8D BE F8 FE     lea di, [bp - 0x108]
CA30  16              push ss
CA31  57              push di
CA32  8B 46 FE        mov ax, word ptr [bp - 2]
CA35  D1 E0           shl ax, 1
CA37  8B 7E 04        mov di, word ptr [bp + 4]
CA3A  36 C4 7D F8     les di, ptr ss:[di - 8]
CA3E  03 F8           add di, ax
CA40  26 FF 75 FE     push word ptr es:[di - 2]
CA44  9A DC 44 55 1B  call far 1B55:44DC
CA49  BF 50 C8        mov di, 0xc850
CA4C  0E              push cs
CA4D  57              push di
CA4E  9A D2 0B C9 26  call far 26C9:0BD2
CA53  9A 98 00 2A 23  call far 232A:0098
CA58  08 C0           or al, al
CA5A  75 36           jne 0xca92
CA5C  6A 06           push 6
CA5E  8B 46 FC        mov ax, word ptr [bp - 4]
CA61  D1 E0           shl ax, 1
CA63  8B 7E 04        mov di, word ptr [bp + 4]
CA66  36 C4 7D F8     les di, ptr ss:[di - 8]
CA6A  03 F8           add di, ax
CA6C  26 6B 45 FE 0F  imul ax, word ptr es:[di - 2], 0xf
CA71  C4 3E BE D7     les di, ptr [0xd7be]
CA75  03 F8           add di, ax
CA77  26 8A 45 0B     mov al, byte ptr es:[di + 0xb]
CA7B  30 E4           xor ah, ah
CA7D  50              push ax
CA7E  9A 59 02 BC 24  call far 24BC:0259
CA83  50              push ax
CA84  BF 5D C8        mov di, 0xc85d
CA87  0E              push cs
CA88  57              push di
CA89  9A 98 00 2A 23  call far 232A:0098
CA8E  08 C0           or al, al
CA90  74 03           je 0xca95
loc_CA92:
CA92  E9 D4 00        jmp 0xcb69
loc_CA95:
CA95  A0 7E 03        mov al, byte ptr [0x37e]
CA98  30 E4           xor ah, ah
CA9A  D1 E0           shl ax, 1
CA9C  8B 7E 04        mov di, word ptr [bp + 4]
CA9F  36 C4 7D F8     les di, ptr ss:[di - 8]
CAA3  03 F8           add di, ax
CAA5  81 C7 FE FF     add di, 0xfffe
CAA9  06              push es
CAAA  57              push di
CAAB  8B 7E 04        mov di, word ptr [bp + 4]
CAAE  36 8A 45 F4     mov al, byte ptr ss:[di - 0xc]
CAB2  30 E4           xor ah, ah
CAB4  D1 E0           shl ax, 1
CAB6  36 C4 7D F8     les di, ptr ss:[di - 8]
CABA  03 F8           add di, ax
CABC  81 C7 FE FF     add di, 0xfffe
CAC0  06              push es
CAC1  57              push di
CAC2  6A 02           push 2
CAC4  9A 03 02 BC 24  call far 24BC:0203
CAC9  A0 7E 03        mov al, byte ptr [0x37e]
CACC  30 E4           xor ah, ah
CACE  D1 E0           shl ax, 1
CAD0  8B D0           mov dx, ax
CAD2  8B 7E 04        mov di, word ptr [bp + 4]
CAD5  36 8A 45 F0     mov al, byte ptr ss:[di - 0x10]
CAD9  98              cwde
CADA  6B F8 28        imul di, ax, 0x28
CADD  03 FA           add di, dx
CADF  81 C7 46 D1     add di, 0xd146
CAE3  1E              push ds
CAE4  57              push di
CAE5  8B 7E 04        mov di, word ptr [bp + 4]
CAE8  36 8A 45 F4     mov al, byte ptr ss:[di - 0xc]
CAEC  30 E4           xor ah, ah
CAEE  D1 E0           shl ax, 1
CAF0  8B D0           mov dx, ax
CAF2  36 8A 45 F0     mov al, byte ptr ss:[di - 0x10]
CAF6  98              cwde
CAF7  6B F8 28        imul di, ax, 0x28
CAFA  03 FA           add di, dx
CAFC  81 C7 46 D1     add di, 0xd146
CB00  1E              push ds
CB01  57              push di
CB02  6A 02           push 2
CB04  9A 03 02 BC 24  call far 24BC:0203
CB09  A0 7E 03        mov al, byte ptr [0x37e]
CB0C  30 E4           xor ah, ah
CB0E  8B D0           mov dx, ax
CB10  8B 7E 04        mov di, word ptr [bp + 4]
CB13  36 8A 45 F0     mov al, byte ptr ss:[di - 0x10]
CB17  98              cwde
CB18  6B F8 14        imul di, ax, 0x14
CB1B  03 FA           add di, dx
CB1D  81 C7 97 D1     add di, 0xd197
CB21  1E              push ds
CB22  57              push di
CB23  8B 7E 04        mov di, word ptr [bp + 4]
CB26  36 8A 45 F4     mov al, byte ptr ss:[di - 0xc]
CB2A  30 E4           xor ah, ah
CB2C  8B D0           mov dx, ax
CB2E  36 8A 45 F0     mov al, byte ptr ss:[di - 0x10]
CB32  98              cwde
CB33  6B F8 14        imul di, ax, 0x14
CB36  03 FA           add di, dx
CB38  81 C7 97 D1     add di, 0xd197
CB3C  1E              push ds
CB3D  57              push di
CB3E  6A 01           push 1
CB40  9A 03 02 BC 24  call far 24BC:0203
CB45  8B 7E 04        mov di, word ptr [bp + 4]
CB48  36 8A 45 F0     mov al, byte ptr ss:[di - 0x10]
CB4C  50              push ax
CB4D  36 8A 45 F0     mov al, byte ptr ss:[di - 0x10]
CB51  98              cwde
CB52  8B F8           mov di, ax
CB54  8A 85 56 0D     mov al, byte ptr [di + 0xd56]
CB58  30 E4           xor ah, ah
CB5A  03 46 FC        add ax, word ptr [bp - 4]
CB5D  50              push ax
CB5E  FF 76 FE        push word ptr [bp - 2]
CB61  E8 54 E3        call 0xaeb8
CB64  C6 06 E2 D6 00  mov byte ptr [0xd6e2], 0
loc_CB69:
CB69  C9              leave
CB6A  C2 02 00        ret 2
; data (not reached as code), 131 bytes
CB6D                  pstr '              '
CB7C                  pstr 'NO MORE SUBS  '
CB8B                  pstr 'MAKE SUBSTITUTION'
CB9D                  pstr 'REQUEST SUBSTITION'
CBB0                  pstr 'CANCEL SUB REQUESTED'
CBC5                  pstr 'Cannot hire youths after match has started'

; ---- routine 0AB9:CBF0  (found by: call, far)
sub_CBF0:
CBF0  C8 18 00 00     enter 0x18, 0
CBF4  C4 3E D2 D7     les di, ptr [0xd7d2]
CBF8  89 7E EC        mov word ptr [bp - 0x14], di
CBFB  8C 46 EE        mov word ptr [bp - 0x12], es
CBFE  80 3E 91 0D 00  cmp byte ptr [0xd91], 0
CC03  75 34           jne 0xcc39
CC05  26 8A 45 04     mov al, byte ptr es:[di + 4]
CC09  30 E4           xor ah, ah
CC0B  8B F8           mov di, ax
CC0D  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
CC11  30 E4           xor ah, ah
CC13  6B C0 3E        imul ax, ax, 0x3e
CC16  C4 3E C2 D7     les di, ptr [0xd7c2]
CC1A  03 F8           add di, ax
CC1C  81 C7 C2 FF     add di, 0xffc2
CC20  06              push es
CC21  57              push di
CC22  C4 7E EC        les di, ptr [bp - 0x14]
CC25  26 8A 45 04     mov al, byte ptr es:[di + 4]
CC29  30 E4           xor ah, ah
CC2B  8B F8           mov di, ax
CC2D  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
CC31  30 E4           xor ah, ah
CC33  50              push ax
CC34  9A 77 77 55 1B  call far 1B55:7777
loc_CC39:
CC39  C6 46 F6 00     mov byte ptr [bp - 0xa], 0
CC3D  8A 46 06        mov al, byte ptr [bp + 6]
CC40  88 46 F7        mov byte ptr [bp - 9], al
CC43  C4 7E EC        les di, ptr [bp - 0x14]
CC46  26 8A 45 04     mov al, byte ptr es:[di + 4]
CC4A  30 E4           xor ah, ah
CC4C  8B F8           mov di, ax
CC4E  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
CC52  30 E4           xor ah, ah
CC54  6B C0 3E        imul ax, ax, 0x3e
CC57  C4 3E C2 D7     les di, ptr [0xd7c2]
CC5B  03 F8           add di, ax
CC5D  26 8D 45 C2     lea ax, es:[di - 0x3e]
CC61  8C C2           mov dx, es
CC63  89 46 F8        mov word ptr [bp - 8], ax
CC66  89 56 FA        mov word ptr [bp - 6], dx
CC69  C4 7E EC        les di, ptr [bp - 0x14]
CC6C  26 8A 45 04     mov al, byte ptr es:[di + 4]
CC70  30 E4           xor ah, ah
CC72  6B C0 28        imul ax, ax, 0x28
CC75  03 F8           add di, ax
CC77  26 8D 45 30     lea ax, es:[di + 0x30]
CC7B  8C C2           mov dx, es
CC7D  89 46 FC        mov word ptr [bp - 4], ax
CC80  89 56 FE        mov word ptr [bp - 2], dx
CC83  80 3E 18 0D 00  cmp byte ptr [0xd18], 0
CC88  74 21           je 0xccab
CC8A  C4 7E EC        les di, ptr [bp - 0x14]
CC8D  26 8A 45 04     mov al, byte ptr es:[di + 4]
CC91  30 E4           xor ah, ah
CC93  8B F8           mov di, ax
CC95  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
CC99  30 E4           xor ah, ah
CC9B  3B 06 E4 D6     cmp ax, word ptr [0xd6e4]
CC9F  75 06           jne 0xcca7
CCA1  C6 46 F0 00     mov byte ptr [bp - 0x10], 0
CCA5  EB 04           jmp 0xccab
loc_CCA7:
CCA7  C6 46 F0 01     mov byte ptr [bp - 0x10], 1
loc_CCAB:
CCAB  80 3E 18 0D 00  cmp byte ptr [0xd18], 0
CCB0  74 05           je 0xccb7
CCB2  C6 06 7E 03 01  mov byte ptr [0x37e], 1
loc_CCB7:
CCB7  8A 46 F7        mov al, byte ptr [bp - 9]
CCBA  30 E4           xor ah, ah
CCBC  8B F8           mov di, ax
CCBE  C1 E7 02        shl di, 2
CCC1  C4 7B F4        les di, ptr [bp + di - 0xc]
CCC4  06              push es
CCC5  57              push di
CCC6  6A 01           push 1
CCC8  0E              push cs
CCC9  E8 BB DF        call 0xac87
CCCC  80 3E 18 0D 00  cmp byte ptr [0xd18], 0
CCD1  75 03           jne 0xccd6
CCD3  E9 A3 00        jmp 0xcd79
loc_CCD6:
CCD6  80 3E 56 DD 00  cmp byte ptr [0xdd56], 0
CCDB  74 18           je 0xccf5
CCDD  6A 03           push 3
CCDF  BF 6D CB        mov di, 0xcb6d
CCE2  0E              push cs
CCE3  57              push di
CCE4  6A 19           push 0x19
CCE6  6A 01           push 1
CCE8  BF 5C DD        mov di, 0xdd5c
CCEB  1E              push ds
CCEC  57              push di
CCED  9A 1B 04 2A 23  call far 232A:041B
CCF2  E9 84 00        jmp 0xcd79
loc_CCF5:
CCF5  8A 46 F0        mov al, byte ptr [bp - 0x10]
CCF8  50              push ax
CCF9  9A 59 47 55 1B  call far 1B55:4759
CCFE  09 C0           or ax, ax
CD00  75 17           jne 0xcd19
CD02  6A 03           push 3
CD04  BF 7C CB        mov di, 0xcb7c
CD07  0E              push cs
CD08  57              push di
CD09  6A 19           push 0x19
CD0B  6A 01           push 1
CD0D  BF 5C DD        mov di, 0xdd5c
CD10  1E              push ds
CD11  57              push di
CD12  9A 1B 04 2A 23  call far 232A:041B
CD17  EB 60           jmp 0xcd79
loc_CD19:
CD19  80 3E BA D0 00  cmp byte ptr [0xd0ba], 0
CD1E  74 17           je 0xcd37
CD20  6A 03           push 3
CD22  BF 8B CB        mov di, 0xcb8b
CD25  0E              push cs
CD26  57              push di
CD27  6A 19           push 0x19
CD29  6A 04           push 4
CD2B  BF 5C DD        mov di, 0xdd5c
CD2E  1E              push ds
CD2F  57              push di
CD30  9A 1B 04 2A 23  call far 232A:041B
CD35  EB 42           jmp 0xcd79
loc_CD37:
CD37  80 3E E2 D6 00  cmp byte ptr [0xd6e2], 0
CD3C  75 17           jne 0xcd55
CD3E  6A 03           push 3
CD40  BF 9D CB        mov di, 0xcb9d
CD43  0E              push cs
CD44  57              push di
CD45  6A 19           push 0x19
CD47  6A 04           push 4
CD49  BF 5C DD        mov di, 0xdd5c
CD4C  1E              push ds
CD4D  57              push di
CD4E  9A 1B 04 2A 23  call far 232A:041B
CD53  EB 24           jmp 0xcd79
loc_CD55:
CD55  6A 03           push 3
CD57  BF B0 CB        mov di, 0xcbb0
CD5A  0E              push cs
CD5B  57              push di
CD5C  6A 19           push 0x19
CD5E  6A 04           push 4
CD60  BF 5C DD        mov di, 0xdd5c
CD63  1E              push ds
CD64  57              push di
CD65  9A 1B 04 2A 23  call far 232A:041B
CD6A  BF C0 1C        mov di, 0x1cc0
CD6D  1E              push ds
CD6E  57              push di
CD6F  BF 5C DD        mov di, 0xdd5c
CD72  1E              push ds
CD73  57              push di
CD74  9A 2F 05 2A 23  call far 232A:052F
loc_CD79:
CD79  80 3E 18 0D 00  cmp byte ptr [0xd18], 0
CD7E  75 26           jne 0xcda6
CD80  80 7E F7 01     cmp byte ptr [bp - 9], 1
CD84  75 11           jne 0xcd97
CD86  BF 0E 1D        mov di, 0x1d0e
CD89  1E              push ds
CD8A  57              push di
CD8B  BF 5C DD        mov di, 0xdd5c
CD8E  1E              push ds
CD8F  57              push di
CD90  9A 2F 05 2A 23  call far 232A:052F
CD95  EB 0F           jmp 0xcda6
loc_CD97:
CD97  BF 48 16        mov di, 0x1648
CD9A  1E              push ds
CD9B  57              push di
CD9C  BF 5C DD        mov di, 0xdd5c
CD9F  1E              push ds
CDA0  57              push di
CDA1  9A 2F 05 2A 23  call far 232A:052F
loc_CDA6:
CDA6  80 7E F6 00     cmp byte ptr [bp - 0xa], 0
CDAA  74 63           je 0xce0f
CDAC  BF 8C 49        mov di, 0x498c
CDAF  1E              push ds
CDB0  57              push di
CDB1  BF 5C DD        mov di, 0xdd5c
CDB4  1E              push ds
CDB5  57              push di
CDB6  9A 2F 05 2A 23  call far 232A:052F
CDBB  8A 46 F7        mov al, byte ptr [bp - 9]
CDBE  3A 46 F5        cmp al, byte ptr [bp - 0xb]
CDC1  74 07           je 0xcdca
CDC3  80 3E 18 0D 00  cmp byte ptr [0xd18], 0
CDC8  74 45           je 0xce0f
loc_CDCA:
CDCA  A0 7E 03        mov al, byte ptr [0x37e]
CDCD  3A 46 F4        cmp al, byte ptr [bp - 0xc]
CDD0  74 3D           je 0xce0f
CDD2  80 7E F4 0E     cmp byte ptr [bp - 0xc], 0xe
CDD6  B0 00           mov al, 0
CDD8  76 01           jbe 0xcddb
CDDA  40              inc ax
loc_CDDB:
CDDB  30 E4           xor ah, ah
CDDD  8B C8           mov cx, ax
CDDF  80 7E F4 0B     cmp byte ptr [bp - 0xc], 0xb
CDE3  B0 00           mov al, 0
CDE5  76 01           jbe 0xcde8
CDE7  40              inc ax
loc_CDE8:
CDE8  30 E4           xor ah, ah
CDEA  8B D0           mov dx, ax
CDEC  8A 46 F4        mov al, byte ptr [bp - 0xc]
CDEF  30 E4           xor ah, ah
CDF1  40              inc ax
CDF2  03 C2           add ax, dx
CDF4  03 C1           add ax, cx
CDF6  69 C0 A0 00     imul ax, ax, 0xa0
CDFA  C4 3E 5C DD     les di, ptr [0xdd5c]
CDFE  03 F8           add di, ax
CE00  81 C7 D4 FF     add di, 0xffd4
CE04  06              push es
CE05  57              push di
CE06  6A 8F           push -0x71
CE08  6A 0E           push 0xe
CE0A  9A 4B 03 BC 24  call far 24BC:034B
loc_CE0F:
CE0F  80 7E F7 02     cmp byte ptr [bp - 9], 2
CE13  75 0F           jne 0xce24
CE15  BF 24 1D        mov di, 0x1d24
CE18  1E              push ds
CE19  57              push di
CE1A  BF 5C DD        mov di, 0xdd5c
CE1D  1E              push ds
CE1E  57              push di
CE1F  9A 2F 05 2A 23  call far 232A:052F
loc_CE24:
CE24  C4 3E 5C DD     les di, ptr [0xdd5c]
CE28  06              push es
CE29  57              push di
CE2A  C4 3E 58 DD     les di, ptr [0xdd58]
CE2E  06              push es
CE2F  57              push di
CE30  68 A0 0F        push 0xfa0
CE33  9A 12 0A C9 26  call far 26C9:0A12
CE38  9A 9B 09 2A 23  call far 232A:099B
CE3D  80 3E 88 DE 01  cmp byte ptr [0xde88], 1
CE42  75 06           jne 0xce4a
CE44  80 7E F6 00     cmp byte ptr [bp - 0xa], 0
CE48  74 04           je 0xce4e
loc_CE4A:
CE4A  B0 00           mov al, 0
CE4C  EB 02           jmp 0xce50
loc_CE4E:
CE4E  B0 01           mov al, 1
loc_CE50:
CE50  88 46 F1        mov byte ptr [bp - 0xf], al
CE53  80 7E F6 00     cmp byte ptr [bp - 0xa], 0
CE57  74 0B           je 0xce64
CE59  80 3E 88 DE 01  cmp byte ptr [0xde88], 1
CE5E  75 04           jne 0xce64
CE60  C6 46 F6 00     mov byte ptr [bp - 0xa], 0
loc_CE64:
CE64  80 3E 88 DE 72  cmp byte ptr [0xde88], 0x72
CE69  75 24           jne 0xce8f
CE6B  A0 7E 03        mov al, byte ptr [0x37e]
CE6E  30 E4           xor ah, ah
CE70  D1 E0           shl ax, 1
CE72  8B D0           mov dx, ax
CE74  8A 46 F7        mov al, byte ptr [bp - 9]
CE77  30 E4           xor ah, ah
CE79  8B F8           mov di, ax
CE7B  C1 E7 02        shl di, 2
CE7E  C4 7B F4        les di, ptr [bp + di - 0xc]
CE81  03 FA           add di, dx
CE83  26 FF 75 FE     push word ptr es:[di - 2]
CE87  6A 01           push 1
CE89  E8 4D DD        call 0xabd9
CE8C  E9 90 02        jmp 0xd11f
loc_CE8F:
CE8F  80 3E 88 DE 52  cmp byte ptr [0xde88], 0x52
CE94  75 24           jne 0xceba
CE96  A0 7E 03        mov al, byte ptr [0x37e]
CE99  30 E4           xor ah, ah
CE9B  D1 E0           shl ax, 1
CE9D  8B D0           mov dx, ax
CE9F  8A 46 F7        mov al, byte ptr [bp - 9]
CEA2  30 E4           xor ah, ah
CEA4  8B F8           mov di, ax
CEA6  C1 E7 02        shl di, 2
CEA9  C4 7B F4        les di, ptr [bp + di - 0xc]
CEAC  03 FA           add di, dx
CEAE  26 FF 75 FE     push word ptr es:[di - 2]
CEB2  6A 00           push 0
CEB4  E8 22 DD        call 0xabd9
CEB7  E9 65 02        jmp 0xd11f
loc_CEBA:
CEBA  A0 88 DE        mov al, byte ptr [0xde88]
CEBD  50              push ax
CEBE  9A 86 19 C9 26  call far 26C9:1986
CEC3  3C 02           cmp al, 2
CEC5  75 4A           jne 0xcf11
CEC7  80 3E 18 0D 00  cmp byte ptr [0xd18], 0
CECC  75 06           jne 0xced4
CECE  55              push bp
CECF  E8 F4 F4        call 0xc3c6
CED2  EB 3A           jmp 0xcf0e
loc_CED4:
CED4  80 3E BA D0 00  cmp byte ptr [0xd0ba], 0
CED9  74 13           je 0xceee
CEDB  8A 46 F0        mov al, byte ptr [bp - 0x10]
CEDE  50              push ax
CEDF  9A 59 47 55 1B  call far 1B55:4759
CEE4  09 C0           or ax, ax
CEE6  76 06           jbe 0xceee
CEE8  55              push bp
CEE9  E8 7A F9        call 0xc866
CEEC  EB 20           jmp 0xcf0e
loc_CEEE:
CEEE  80 3E E2 D6 00  cmp byte ptr [0xd6e2], 0
CEF3  75 14           jne 0xcf09
CEF5  8A 46 F0        mov al, byte ptr [bp - 0x10]
CEF8  50              push ax
CEF9  9A 59 47 55 1B  call far 1B55:4759
CEFE  09 C0           or ax, ax
CF00  76 07           jbe 0xcf09
CF02  C6 06 E2 D6 01  mov byte ptr [0xd6e2], 1
CF07  EB 05           jmp 0xcf0e
loc_CF09:
CF09  C6 06 E2 D6 00  mov byte ptr [0xd6e2], 0
loc_CF0E:
CF0E  E9 0E 02        jmp 0xd11f
loc_CF11:
CF11  3C 07           cmp al, 7
CF13  74 04           je 0xcf19
CF15  3C 08           cmp al, 8
CF17  75 16           jne 0xcf2f
loc_CF19:
CF19  80 3E 18 0D 00  cmp byte ptr [0xd18], 0
CF1E  75 0C           jne 0xcf2c
CF20  8D 7E F7        lea di, [bp - 9]
CF23  16              push ss
CF24  57              push di
CF25  6A 02           push 2
CF27  9A C4 0E 2A 23  call far 232A:0EC4
loc_CF2C:
CF2C  E9 F0 01        jmp 0xd11f
loc_CF2F:
CF2F  3C 20           cmp al, 0x20
CF31  75 42           jne 0xcf75
CF33  A0 7E 03        mov al, byte ptr [0x37e]
CF36  30 E4           xor ah, ah
CF38  D1 E0           shl ax, 1
CF3A  8B D0           mov dx, ax
CF3C  8A 46 F7        mov al, byte ptr [bp - 9]
CF3F  30 E4           xor ah, ah
CF41  8B F8           mov di, ax
CF43  C1 E7 02        shl di, 2
CF46  C4 7B F4        les di, ptr [bp + di - 0xc]
CF49  03 FA           add di, dx
CF4B  26 83 7D FE 00  cmp word ptr es:[di - 2], 0
CF50  74 20           je 0xcf72
CF52  A0 7E 03        mov al, byte ptr [0x37e]
CF55  30 E4           xor ah, ah
CF57  D1 E0           shl ax, 1
CF59  8B D0           mov dx, ax
CF5B  8A 46 F7        mov al, byte ptr [bp - 9]
CF5E  30 E4           xor ah, ah
CF60  8B F8           mov di, ax
CF62  C1 E7 02        shl di, 2
CF65  C4 7B F4        les di, ptr [bp + di - 0xc]
CF68  03 FA           add di, dx
CF6A  26 FF 75 FE     push word ptr es:[di - 2]
CF6E  55              push bp
CF6F  E8 5B F5        call 0xc4cd
loc_CF72:
CF72  E9 AA 01        jmp 0xd11f
loc_CF75:
CF75  3C 43           cmp al, 0x43
CF77  75 22           jne 0xcf9b
CF79  A0 7E 03        mov al, byte ptr [0x37e]
CF7C  30 E4           xor ah, ah
CF7E  D1 E0           shl ax, 1
CF80  8B D0           mov dx, ax
CF82  8A 46 F7        mov al, byte ptr [bp - 9]
CF85  30 E4           xor ah, ah
CF87  8B F8           mov di, ax
CF89  C1 E7 02        shl di, 2
CF8C  C4 7B F4        les di, ptr [bp + di - 0xc]
CF8F  03 FA           add di, dx
CF91  26 FF 75 FE     push word ptr es:[di - 2]
CF95  E8 BA DC        call 0xac52
CF98  E9 84 01        jmp 0xd11f
loc_CF9B:
CF9B  3C 54           cmp al, 0x54
CF9D  75 47           jne 0xcfe6
CF9F  A0 7E 03        mov al, byte ptr [0x37e]
CFA2  30 E4           xor ah, ah
CFA4  D1 E0           shl ax, 1
CFA6  8B D0           mov dx, ax
CFA8  8A 46 F7        mov al, byte ptr [bp - 9]
CFAB  30 E4           xor ah, ah
CFAD  8B F8           mov di, ax
CFAF  C1 E7 02        shl di, 2
CFB2  C4 7B F4        les di, ptr [bp + di - 0xc]
CFB5  03 FA           add di, dx
CFB7  26 83 7D FE 00  cmp word ptr es:[di - 2], 0
CFBC  74 25           je 0xcfe3
CFBE  A0 7E 03        mov al, byte ptr [0x37e]
CFC1  30 E4           xor ah, ah
CFC3  D1 E0           shl ax, 1
CFC5  8B D0           mov dx, ax
CFC7  8A 46 F7        mov al, byte ptr [bp - 9]
CFCA  30 E4           xor ah, ah
CFCC  8B F8           mov di, ax
CFCE  C1 E7 02        shl di, 2
CFD1  C4 7B F4        les di, ptr [bp + di - 0xc]
CFD4  03 FA           add di, dx
CFD6  26 FF 75 FE     push word ptr es:[di - 2]
CFDA  A0 7E 03        mov al, byte ptr [0x37e]
CFDD  30 E4           xor ah, ah
CFDF  50              push ax
CFE0  E8 8E E2        call 0xb271
loc_CFE3:
CFE3  E9 39 01        jmp 0xd11f
loc_CFE6:
CFE6  3C 48           cmp al, 0x48
CFE8  75 41           jne 0xd02b
CFEA  A0 18 0D        mov al, byte ptr [0xd18]
CFED  50              push ax
CFEE  BF C5 CB        mov di, 0xcbc5
CFF1  0E              push cs
CFF2  57              push di
CFF3  9A 98 00 2A 23  call far 232A:0098
CFF8  08 C0           or al, al
CFFA  75 2C           jne 0xd028
CFFC  C6 46 F7 02     mov byte ptr [bp - 9], 2
D000  C4 7E EC        les di, ptr [bp - 0x14]
D003  26 8A 45 04     mov al, byte ptr es:[di + 4]
D007  30 E4           xor ah, ah
D009  50              push ax
D00A  26 8A 45 04     mov al, byte ptr es:[di + 4]
D00E  30 E4           xor ah, ah
D010  8B F8           mov di, ax
D012  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
D016  30 E4           xor ah, ah
D018  50              push ax
D019  9A 79 5E 55 1B  call far 1B55:5E79
D01E  83 3E 84 D6 00  cmp word ptr [0xd684], 0
D023  74 03           je 0xd028
D025  E8 A9 C5        call 0x95d1
loc_D028:
D028  E9 F4 00        jmp 0xd11f
loc_D02B:
D02B  3C 46           cmp al, 0x46
D02D  75 41           jne 0xd070
D02F  80 3E 18 0D 00  cmp byte ptr [0xd18], 0
D034  75 37           jne 0xd06d
D036  A0 7E 03        mov al, byte ptr [0x37e]
D039  30 E4           xor ah, ah
D03B  D1 E0           shl ax, 1
D03D  8B D0           mov dx, ax
D03F  8A 46 F7        mov al, byte ptr [bp - 9]
D042  30 E4           xor ah, ah
D044  8B F8           mov di, ax
D046  C1 E7 02        shl di, 2
D049  C4 7B F4        les di, ptr [bp + di - 0xc]
D04C  03 FA           add di, dx
D04E  26 83 7D FE 00  cmp word ptr es:[di - 2], 0
D053  74 18           je 0xd06d
D055  8A 46 F7        mov al, byte ptr [bp - 9]
D058  30 E4           xor ah, ah
D05A  8B F8           mov di, ax
D05C  C1 E7 02        shl di, 2
D05F  C4 7B F4        les di, ptr [bp + di - 0xc]
D062  06              push es
D063  57              push di
D064  A0 7E 03        mov al, byte ptr [0x37e]
D067  30 E4           xor ah, ah
D069  50              push ax
D06A  E8 37 D0        call 0xa0a4
loc_D06D:
D06D  E9 AF 00        jmp 0xd11f
loc_D070:
D070  3C 53           cmp al, 0x53
D072  75 24           jne 0xd098
D074  A0 7E 03        mov al, byte ptr [0x37e]
D077  30 E4           xor ah, ah
D079  D1 E0           shl ax, 1
D07B  8B D0           mov dx, ax
D07D  8A 46 F7        mov al, byte ptr [bp - 9]
D080  30 E4           xor ah, ah
D082  8B F8           mov di, ax
D084  C1 E7 02        shl di, 2
D087  C4 7B F4        les di, ptr [bp + di - 0xc]
D08A  03 FA           add di, dx
D08C  26 FF 75 FE     push word ptr es:[di - 2]
D090  9A EE 66 55 1B  call far 1B55:66EE
D095  E9 87 00        jmp 0xd11f
loc_D098:
D098  3C 55           cmp al, 0x55
D09A  75 21           jne 0xd0bd
D09C  A0 7E 03        mov al, byte ptr [0x37e]
D09F  30 E4           xor ah, ah
D0A1  D1 E0           shl ax, 1
D0A3  8B D0           mov dx, ax
D0A5  8A 46 F7        mov al, byte ptr [bp - 9]
D0A8  30 E4           xor ah, ah
D0AA  8B F8           mov di, ax
D0AC  C1 E7 02        shl di, 2
D0AF  C4 7B F4        les di, ptr [bp + di - 0xc]
D0B2  03 FA           add di, dx
D0B4  26 FF 75 FE     push word ptr es:[di - 2]
D0B8  E8 9D F2        call 0xc358
D0BB  EB 62           jmp 0xd11f
loc_D0BD:
D0BD  3C 4E           cmp al, 0x4e
D0BF  75 26           jne 0xd0e7
D0C1  A0 7E 03        mov al, byte ptr [0x37e]
D0C4  30 E4           xor ah, ah
D0C6  D1 E0           shl ax, 1
D0C8  8B D0           mov dx, ax
D0CA  8A 46 F7        mov al, byte ptr [bp - 9]
D0CD  30 E4           xor ah, ah
D0CF  8B F8           mov di, ax
D0D1  C1 E7 02        shl di, 2
D0D4  C4 7B F4        les di, ptr [bp + di - 0xc]
D0D7  03 FA           add di, dx
D0D9  26 FF 75 FE     push word ptr es:[di - 2]
D0DD  6A 00           push 0
D0DF  6A 00           push 0
D0E1  0E              push cs
D0E2  E8 BE EF        call 0xc0a3
D0E5  EB 38           jmp 0xd11f
loc_D0E7:
D0E7  3C 0D           cmp al, 0xd
D0E9  75 0F           jne 0xd0fa
D0EB  80 3E 2A 9A 00  cmp byte ptr [0x9a2a], 0
D0F0  B0 00           mov al, 0
D0F2  75 01           jne 0xd0f5
D0F4  40              inc ax
loc_D0F5:
D0F5  A2 2A 9A        mov byte ptr [0x9a2a], al
D0F8  EB 25           jmp 0xd11f
loc_D0FA:
D0FA  80 3E 18 0D 00  cmp byte ptr [0xd18], 0
D0FF  74 12           je 0xd113
D101  BF 7E 03        mov di, 0x37e
D104  1E              push ds
D105  57              push di
D106  9A 76 0B 98 19  call far 1998:0B76
D10B  50              push ax
D10C  9A C4 0E 2A 23  call far 232A:0EC4
D111  EB 0C           jmp 0xd11f
loc_D113:
D113  BF 7E 03        mov di, 0x37e
D116  1E              push ds
D117  57              push di
D118  6A 14           push 0x14
D11A  9A C4 0E 2A 23  call far 232A:0EC4
loc_D11F:
D11F  80 7E F1 00     cmp byte ptr [bp - 0xf], 0
D123  75 03           jne 0xd128
D125  E9 8F FB        jmp 0xccb7
loc_D128:
D128  C4 7E EC        les di, ptr [bp - 0x14]
D12B  26 8A 45 04     mov al, byte ptr es:[di + 4]
D12F  30 E4           xor ah, ah
D131  8B F8           mov di, ax
D133  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
D137  30 E4           xor ah, ah
D139  6B C0 3E        imul ax, ax, 0x3e
D13C  C4 3E C2 D7     les di, ptr [0xd7c2]
D140  03 F8           add di, ax
D142  81 C7 C2 FF     add di, 0xffc2
D146  89 7E E8        mov word ptr [bp - 0x18], di
D149  8C 46 EA        mov word ptr [bp - 0x16], es
D14C  26 C6 45 32 00  mov byte ptr es:[di + 0x32], 0
D151  C7 46 F2 01 00  mov word ptr [bp - 0xe], 1
D156  EB 03           jmp 0xd15b
loc_D158:
D158  FF 46 F2        inc word ptr [bp - 0xe]
loc_D15B:
D15B  8B 46 F2        mov ax, word ptr [bp - 0xe]
D15E  D1 E0           shl ax, 1
D160  C4 7E E8        les di, ptr [bp - 0x18]
D163  03 F8           add di, ax
D165  26 83 7D FE 00  cmp word ptr es:[di - 2], 0
D16A  74 07           je 0xd173
D16C  C4 7E E8        les di, ptr [bp - 0x18]
D16F  26 FE 45 32     inc byte ptr es:[di + 0x32]
loc_D173:
D173  83 7E F2 14     cmp word ptr [bp - 0xe], 0x14
D177  75 DF           jne 0xd158
D179  C7 46 F2 01 00  mov word ptr [bp - 0xe], 1
D17E  EB 03           jmp 0xd183
loc_D180:
D180  FF 46 F2        inc word ptr [bp - 0xe]
loc_D183:
D183  8B 46 F2        mov ax, word ptr [bp - 0xe]
D186  D1 E0           shl ax, 1
D188  8B D0           mov dx, ax
D18A  C4 7E EC        les di, ptr [bp - 0x14]
D18D  26 8A 45 04     mov al, byte ptr es:[di + 4]
D191  30 E4           xor ah, ah
D193  6B C0 28        imul ax, ax, 0x28
D196  03 F8           add di, ax
D198  03 FA           add di, dx
D19A  26 83 7D 2E 00  cmp word ptr es:[di + 0x2e], 0
D19F  74 07           je 0xd1a8
D1A1  C4 7E E8        les di, ptr [bp - 0x18]
D1A4  26 FE 45 32     inc byte ptr es:[di + 0x32]
loc_D1A8:
D1A8  83 7E F2 14     cmp word ptr [bp - 0xe], 0x14
D1AC  75 D2           jne 0xd180
D1AE  C4 7E EC        les di, ptr [bp - 0x14]
D1B1  26 8A 45 04     mov al, byte ptr es:[di + 4]
D1B5  30 E4           xor ah, ah
D1B7  6B C0 28        imul ax, ax, 0x28
D1BA  03 F8           add di, ax
D1BC  81 C7 30 00     add di, 0x30
D1C0  06              push es
D1C1  57              push di
D1C2  C4 7E EC        les di, ptr [bp - 0x14]
D1C5  26 8A 45 04     mov al, byte ptr es:[di + 4]
D1C9  30 E4           xor ah, ah
D1CB  8B F8           mov di, ax
D1CD  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
D1D1  30 E4           xor ah, ah
D1D3  50              push ax
D1D4  9A 77 77 55 1B  call far 1B55:7777
D1D9  C9              leave
D1DA  CA 02 00        retf 2

