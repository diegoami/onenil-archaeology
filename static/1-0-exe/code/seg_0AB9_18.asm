; 1-0.EXE (One-Nil 96), code segment 0AB9 (image offsets 0AB90..1997F), part 18 of 22
; packed 1-0.EXE sha256 89ff9c5f238f24e81a0c2440a46cdd8997280a65fc3cc3d97cb974f55280a80a (LZEXE 0.91)
; unpacked (tools/static/unlzexe.py) sha256 887ed2a92767950e5309b2052409f875668605939b69e00737aa3047022b9f51
; tool: capstone 5.0.9 (pip package; core library 5.0.1280) (CS_ARCH_X86, CS_MODE_16), recursive descent from the entry point, far calls and near calls/jumps, then routine prologues (55 89 E5 / 55 8B EC / C8 iw 00) in what remains; tools/static/listing.py
; addresses are SEGMENT:OFFSET with SEGMENT the image paragraph before relocation; image offset = SEGMENT*16+OFFSET
; ---- routine 0AB9:B6BD  (found by: call)
sub_B6BD:
B6BD  C8 0E 00 00     enter 0xe, 0
B6C1  8A 46 06        mov al, byte ptr [bp + 6]
B6C4  98              cwde
B6C5  8B F8           mov di, ax
B6C7  D1 E7           shl di, 1
B6C9  6B 85 E4 D6 3E  imul ax, word ptr [di - 0x291c], 0x3e
B6CE  C4 3E C2 D7     les di, ptr [0xd7c2]
B6D2  03 F8           add di, ax
B6D4  81 C7 C2 FF     add di, 0xffc2
B6D8  89 7E F2        mov word ptr [bp - 0xe], di
B6DB  8C 46 F4        mov word ptr [bp - 0xc], es
B6DE  C4 3E D2 D7     les di, ptr [0xd7d2]
B6E2  26 80 BD F6 00 00 cmp byte ptr es:[di + 0xf6], 0
B6E8  74 53           je 0xb73d
B6EA  80 7E 04 01     cmp byte ptr [bp + 4], 1
B6EE  75 16           jne 0xb706
B6F0  8A 46 06        mov al, byte ptr [bp + 6]
B6F3  50              push ax
B6F4  E8 C1 5C        call 0x113b8
B6F7  8B D0           mov dx, ax
B6F9  8A 46 06        mov al, byte ptr [bp + 6]
B6FC  98              cwde
B6FD  6B F8 0A        imul di, ax, 0xa
B700  89 95 5E CF     mov word ptr [di - 0x30a2], dx
B704  EB 1B           jmp 0xb721
loc_B706:
B706  8A 46 06        mov al, byte ptr [bp + 6]
B709  50              push ax
B70A  8A 46 04        mov al, byte ptr [bp + 4]
B70D  30 E4           xor ah, ah
B70F  8B F8           mov di, ax
B711  8A 85 F6 09     mov al, byte ptr [di + 0x9f6]
B715  30 E4           xor ah, ah
B717  50              push ax
B718  8A 46 04        mov al, byte ptr [bp + 4]
B71B  30 E4           xor ah, ah
B71D  50              push ax
B71E  E8 34 5D        call 0x11455
loc_B721:
B721  8A 46 04        mov al, byte ptr [bp + 4]
B724  30 E4           xor ah, ah
B726  D1 E0           shl ax, 1
B728  8B D0           mov dx, ax
B72A  8A 46 06        mov al, byte ptr [bp + 6]
B72D  98              cwde
B72E  6B F8 0A        imul di, ax, 0xa
B731  03 FA           add di, dx
B733  8B 85 5C CF     mov ax, word ptr [di - 0x30a4]
B737  89 46 FE        mov word ptr [bp - 2], ax
B73A  E9 97 03        jmp 0xbad4
loc_B73D:
B73D  C4 3E 58 DD     les di, ptr [0xdd58]
B741  06              push es
B742  57              push di
B743  C4 3E 60 DD     les di, ptr [0xdd60]
B747  06              push es
B748  57              push di
B749  68 A0 0F        push 0xfa0
B74C  9A 12 0A C9 26  call far 26C9:0A12
B751  A0 2A 9A        mov al, byte ptr [0x9a2a]
B754  88 46 F7        mov byte ptr [bp - 9], al
B757  80 7E 04 01     cmp byte ptr [bp + 4], 1
B75B  B0 00           mov al, 0
B75D  74 01           je 0xb760
B75F  40              inc ax
loc_B760:
B760  A2 2A 9A        mov byte ptr [0x9a2a], al
B763  C6 46 FC 00     mov byte ptr [bp - 4], 0
B767  80 7E 04 01     cmp byte ptr [bp + 4], 1
B76B  75 41           jne 0xb7ae
B76D  8A 46 04        mov al, byte ptr [bp + 4]
B770  30 E4           xor ah, ah
B772  D1 E0           shl ax, 1
B774  8B D0           mov dx, ax
B776  8A 46 06        mov al, byte ptr [bp + 6]
B779  98              cwde
B77A  6B F8 0A        imul di, ax, 0xa
B77D  03 FA           add di, dx
B77F  FF B5 5C CF     push word ptr [di - 0x30a4]
B783  9A 89 4F 55 1B  call far 1B55:4F89
B788  08 C0           or al, al
B78A  75 0E           jne 0xb79a
B78C  8A 46 06        mov al, byte ptr [bp + 6]
B78F  50              push ax
B790  6A 01           push 1
B792  E8 EA 9F        call 0x577f
B795  3D 0B 00        cmp ax, 0xb
B798  76 14           jbe 0xb7ae
loc_B79A:
B79A  8A 46 06        mov al, byte ptr [bp + 6]
B79D  50              push ax
B79E  E8 17 5C        call 0x113b8
B7A1  8B D0           mov dx, ax
B7A3  8A 46 06        mov al, byte ptr [bp + 6]
B7A6  98              cwde
B7A7  6B F8 0A        imul di, ax, 0xa
B7AA  89 95 5E CF     mov word ptr [di - 0x30a2], dx
loc_B7AE:
B7AE  8A 46 04        mov al, byte ptr [bp + 4]
B7B1  30 E4           xor ah, ah
B7B3  D1 E0           shl ax, 1
B7B5  8B D0           mov dx, ax
B7B7  8A 46 06        mov al, byte ptr [bp + 6]
B7BA  98              cwde
B7BB  6B F8 0A        imul di, ax, 0xa
B7BE  03 FA           add di, dx
B7C0  FF B5 5C CF     push word ptr [di - 0x30a4]
B7C4  9A 89 4F 55 1B  call far 1B55:4F89
B7C9  08 C0           or al, al
B7CB  75 12           jne 0xb7df
B7CD  8A 46 06        mov al, byte ptr [bp + 6]
B7D0  50              push ax
B7D1  8A 46 04        mov al, byte ptr [bp + 4]
B7D4  30 E4           xor ah, ah
B7D6  50              push ax
B7D7  E8 A5 9F        call 0x577f
B7DA  3D 0B 00        cmp ax, 0xb
B7DD  76 1B           jbe 0xb7fa
loc_B7DF:
B7DF  8A 46 06        mov al, byte ptr [bp + 6]
B7E2  50              push ax
B7E3  8A 46 04        mov al, byte ptr [bp + 4]
B7E6  30 E4           xor ah, ah
B7E8  8B F8           mov di, ax
B7EA  8A 85 F6 09     mov al, byte ptr [di + 0x9f6]
B7EE  30 E4           xor ah, ah
B7F0  50              push ax
B7F1  8A 46 04        mov al, byte ptr [bp + 4]
B7F4  30 E4           xor ah, ah
B7F6  50              push ax
B7F7  E8 5B 5C        call 0x11455
loc_B7FA:
B7FA  C7 46 F8 01 00  mov word ptr [bp - 8], 1
B7FF  EB 03           jmp 0xb804
loc_B801:
B801  FF 46 F8        inc word ptr [bp - 8]
loc_B804:
B804  8B 46 F8        mov ax, word ptr [bp - 8]
B807  D1 E0           shl ax, 1
B809  C4 7E F2        les di, ptr [bp - 0xe]
B80C  03 F8           add di, ax
B80E  26 8B 4D FE     mov cx, word ptr es:[di - 2]
B812  8A 46 04        mov al, byte ptr [bp + 4]
B815  30 E4           xor ah, ah
B817  D1 E0           shl ax, 1
B819  8B D0           mov dx, ax
B81B  8A 46 06        mov al, byte ptr [bp + 6]
B81E  98              cwde
B81F  6B F8 0A        imul di, ax, 0xa
B822  03 FA           add di, dx
B824  8B 85 5C CF     mov ax, word ptr [di - 0x30a4]
B828  3B C1           cmp ax, cx
B82A  75 1D           jne 0xb849
B82C  8B 46 F8        mov ax, word ptr [bp - 8]
B82F  D1 E0           shl ax, 1
B831  C4 7E F2        les di, ptr [bp - 0xe]
B834  03 F8           add di, ax
B836  26 FF 75 FE     push word ptr es:[di - 2]
B83A  9A 89 4F 55 1B  call far 1B55:4F89
B83F  08 C0           or al, al
B841  75 06           jne 0xb849
B843  8A 46 F8        mov al, byte ptr [bp - 8]
B846  88 46 FC        mov byte ptr [bp - 4], al
loc_B849:
B849  83 7E F8 0B     cmp word ptr [bp - 8], 0xb
B84D  75 B2           jne 0xb801
B84F  80 7E FC 00     cmp byte ptr [bp - 4], 0
B853  74 15           je 0xb86a
B855  8A 46 FC        mov al, byte ptr [bp - 4]
B858  30 E4           xor ah, ah
B85A  D1 E0           shl ax, 1
B85C  C4 7E F2        les di, ptr [bp - 0xe]
B85F  03 F8           add di, ax
B861  26 8B 45 FE     mov ax, word ptr es:[di - 2]
B865  89 46 FA        mov word ptr [bp - 6], ax
B868  EB 09           jmp 0xb873
loc_B86A:
B86A  31 C0           xor ax, ax
B86C  89 46 FA        mov word ptr [bp - 6], ax
B86F  C6 46 FC 01     mov byte ptr [bp - 4], 1
loc_B873:
B873  C6 06 88 DE 00  mov byte ptr [0xde88], 0
B878  BF BE 22        mov di, 0x22be
B87B  1E              push ds
B87C  57              push di
B87D  BF 5C DD        mov di, 0xdd5c
B880  1E              push ds
B881  57              push di
B882  9A 2F 05 2A 23  call far 232A:052F
B887  BF 70 63        mov di, 0x6370
B88A  1E              push ds
B88B  57              push di
B88C  BF 5C DD        mov di, 0xdd5c
B88F  1E              push ds
B890  57              push di
B891  9A 2F 05 2A 23  call far 232A:052F
B896  BF B2 25        mov di, 0x25b2
B899  1E              push ds
B89A  57              push di
B89B  BF 5C DD        mov di, 0xdd5c
B89E  1E              push ds
B89F  57              push di
B8A0  9A 2F 05 2A 23  call far 232A:052F
B8A5  80 7E 04 01     cmp byte ptr [bp + 4], 1
B8A9  74 0F           je 0xb8ba
B8AB  BF A4 23        mov di, 0x23a4
B8AE  1E              push ds
B8AF  57              push di
B8B0  BF 5C DD        mov di, 0xdd5c
B8B3  1E              push ds
B8B4  57              push di
B8B5  9A 2F 05 2A 23  call far 232A:052F
loc_B8BA:
B8BA  8A 46 06        mov al, byte ptr [bp + 6]
B8BD  98              cwde
B8BE  8B F8           mov di, ax
B8C0  D1 E7           shl di, 1
B8C2  FF B5 E4 D6     push word ptr [di - 0x291c]
B8C6  6A 17           push 0x17
B8C8  6A 3C           push 0x3c
B8CA  9A E3 0E 55 1B  call far 1B55:0EE3
B8CF  C7 46 F8 01 00  mov word ptr [bp - 8], 1
B8D4  EB 03           jmp 0xb8d9
loc_B8D6:
B8D6  FF 46 F8        inc word ptr [bp - 8]
loc_B8D9:
B8D9  8B 46 F8        mov ax, word ptr [bp - 8]
B8DC  D1 E0           shl ax, 1
B8DE  C4 7E F2        les di, ptr [bp - 0xe]
B8E1  03 F8           add di, ax
B8E3  26 FF 75 FE     push word ptr es:[di - 2]
B8E7  8B 46 F8        mov ax, word ptr [bp - 8]
B8EA  40              inc ax
B8EB  50              push ax
B8EC  6A 3C           push 0x3c
B8EE  9A F1 1F 55 1B  call far 1B55:1FF1
B8F3  83 7E F8 0B     cmp word ptr [bp - 8], 0xb
B8F7  75 DD           jne 0xb8d6
B8F9  8A 46 FC        mov al, byte ptr [bp - 4]
B8FC  30 E4           xor ah, ah
B8FE  D1 E0           shl ax, 1
B900  C4 7E F2        les di, ptr [bp - 0xe]
B903  03 F8           add di, ax
B905  26 FF 75 FE     push word ptr es:[di - 2]
B909  0E              push cs
B90A  E8 A6 DC        call 0x95b3
B90D  8A 46 FC        mov al, byte ptr [bp - 4]
B910  30 E4           xor ah, ah
B912  40              inc ax
B913  50              push ax
B914  6A 3B           push 0x3b
B916  6A 0E           push 0xe
B918  9A 03 02 2A 23  call far 232A:0203
B91D  6A 03           push 3
B91F  8A 46 04        mov al, byte ptr [bp + 4]
B922  30 E4           xor ah, ah
B924  6B F8 0B        imul di, ax, 0xb
B927  81 C7 6B 0C     add di, 0xc6b
B92B  1E              push ds
B92C  57              push di
B92D  6A 19           push 0x19
B92F  6A 0B           push 0xb
B931  BF 5C DD        mov di, 0xdd5c
B934  1E              push ds
B935  57              push di
B936  9A 1B 04 2A 23  call far 232A:041B
B93B  80 7E 04 01     cmp byte ptr [bp + 4], 1
B93F  75 13           jne 0xb954
B941  BF B5 B6        mov di, 0xb6b5
B944  0E              push cs
B945  57              push di
B946  6A 19           push 0x19
B948  6A 13           push 0x13
B94A  BF 5C DD        mov di, 0xdd5c
B94D  1E              push ds
B94E  57              push di
B94F  9A 9D 03 2A 23  call far 232A:039D
loc_B954:
B954  8A 46 04        mov al, byte ptr [bp + 4]
B957  30 E4           xor ah, ah
B959  6B F8 0B        imul di, ax, 0xb
B95C  81 C7 6B 0C     add di, 0xc6b
B960  1E              push ds
B961  57              push di
B962  6A 14           push 0x14
B964  6A 3E           push 0x3e
B966  BF 5C DD        mov di, 0xdd5c
B969  1E              push ds
B96A  57              push di
B96B  9A 9D 03 2A 23  call far 232A:039D
B970  C4 3E 5C DD     les di, ptr [0xdd5c]
B974  06              push es
B975  57              push di
B976  C4 3E 58 DD     les di, ptr [0xdd58]
B97A  06              push es
B97B  57              push di
B97C  68 A0 0F        push 0xfa0
B97F  9A 12 0A C9 26  call far 26C9:0A12
B984  6A 0A           push 0xa
B986  9A A6 19 BC 24  call far 24BC:19A6
B98B  9A 58 0C BC 24  call far 24BC:0C58
B990  08 C0           or al, al
B992  75 06           jne 0xb99a
B994  C6 46 FD 01     mov byte ptr [bp - 3], 1
B998  EB 1C           jmp 0xb9b6
loc_B99A:
B99A  9A 9B 09 2A 23  call far 232A:099B
B99F  80 3E 88 DE 01  cmp byte ptr [0xde88], 1
B9A4  74 0B           je 0xb9b1
B9A6  80 3E 88 DE 02  cmp byte ptr [0xde88], 2
B9AB  74 04           je 0xb9b1
B9AD  B0 00           mov al, 0
B9AF  EB 02           jmp 0xb9b3
loc_B9B1:
B9B1  B0 01           mov al, 1
loc_B9B3:
B9B3  88 46 FD        mov byte ptr [bp - 3], al
loc_B9B6:
B9B6  80 3E 88 DE 0D  cmp byte ptr [0xde88], 0xd
B9BB  75 10           jne 0xb9cd
B9BD  80 3E 2A 9A 00  cmp byte ptr [0x9a2a], 0
B9C2  B0 00           mov al, 0
B9C4  75 01           jne 0xb9c7
B9C6  40              inc ax
loc_B9C7:
B9C7  A2 2A 9A        mov byte ptr [0x9a2a], al
B9CA  E9 D2 00        jmp 0xba9f
loc_B9CD:
B9CD  80 3E 88 DE 20  cmp byte ptr [0xde88], 0x20
B9D2  75 31           jne 0xba05
B9D4  80 7E 04 01     cmp byte ptr [bp + 4], 1
B9D8  74 2B           je 0xba05
B9DA  C4 3E 60 DD     les di, ptr [0xdd60]
B9DE  06              push es
B9DF  57              push di
B9E0  C4 3E 58 DD     les di, ptr [0xdd58]
B9E4  06              push es
B9E5  57              push di
B9E6  68 A0 0F        push 0xfa0
B9E9  9A 12 0A C9 26  call far 26C9:0A12
B9EE  BF DA 4E        mov di, 0x4eda
B9F1  1E              push ds
B9F2  57              push di
B9F3  BF 58 DD        mov di, 0xdd58
B9F6  1E              push ds
B9F7  57              push di
B9F8  9A 2F 05 2A 23  call far 232A:052F
B9FD  9A 9B 09 2A 23  call far 232A:099B
BA02  E9 9A 00        jmp 0xba9f
loc_BA05:
BA05  A0 88 DE        mov al, byte ptr [0xde88]
BA08  50              push ax
BA09  9A 86 19 C9 26  call far 26C9:1986
BA0E  3C 43           cmp al, 0x43
BA10  75 56           jne 0xba68
BA12  80 7E 04 01     cmp byte ptr [bp + 4], 1
BA16  75 16           jne 0xba2e
BA18  8A 46 06        mov al, byte ptr [bp + 6]
BA1B  50              push ax
BA1C  E8 99 59        call 0x113b8
BA1F  8B D0           mov dx, ax
BA21  8A 46 06        mov al, byte ptr [bp + 6]
BA24  98              cwde
BA25  6B F8 0A        imul di, ax, 0xa
BA28  89 95 5E CF     mov word ptr [di - 0x30a2], dx
BA2C  EB 1B           jmp 0xba49
loc_BA2E:
BA2E  8A 46 06        mov al, byte ptr [bp + 6]
BA31  50              push ax
BA32  8A 46 04        mov al, byte ptr [bp + 4]
BA35  30 E4           xor ah, ah
BA37  8B F8           mov di, ax
BA39  8A 85 F6 09     mov al, byte ptr [di + 0x9f6]
BA3D  30 E4           xor ah, ah
BA3F  50              push ax
BA40  8A 46 04        mov al, byte ptr [bp + 4]
BA43  30 E4           xor ah, ah
BA45  50              push ax
BA46  E8 0C 5A        call 0x11455
loc_BA49:
BA49  8A 46 04        mov al, byte ptr [bp + 4]
BA4C  30 E4           xor ah, ah
BA4E  D1 E0           shl ax, 1
BA50  8B D0           mov dx, ax
BA52  8A 46 06        mov al, byte ptr [bp + 6]
BA55  98              cwde
BA56  6B F8 0A        imul di, ax, 0xa
BA59  03 FA           add di, dx
BA5B  8B 85 5C CF     mov ax, word ptr [di - 0x30a4]
BA5F  89 46 FA        mov word ptr [bp - 6], ax
BA62  C6 46 FD 01     mov byte ptr [bp - 3], 1
BA66  EB 37           jmp 0xba9f
loc_BA68:
BA68  80 3E 88 DE 02  cmp byte ptr [0xde88], 2
BA6D  75 30           jne 0xba9f
BA6F  8A 46 FC        mov al, byte ptr [bp - 4]
BA72  30 E4           xor ah, ah
BA74  D1 E0           shl ax, 1
BA76  C4 7E F2        les di, ptr [bp - 0xe]
BA79  03 F8           add di, ax
BA7B  26 FF 75 FE     push word ptr es:[di - 2]
BA7F  9A 89 4F 55 1B  call far 1B55:4F89
BA84  08 C0           or al, al
BA86  75 17           jne 0xba9f
BA88  8A 46 FC        mov al, byte ptr [bp - 4]
BA8B  30 E4           xor ah, ah
BA8D  D1 E0           shl ax, 1
BA8F  C4 7E F2        les di, ptr [bp - 0xe]
BA92  03 F8           add di, ax
BA94  26 8B 45 FE     mov ax, word ptr es:[di - 2]
BA98  89 46 FA        mov word ptr [bp - 6], ax
BA9B  C6 46 FD 01     mov byte ptr [bp - 3], 1
loc_BA9F:
BA9F  8D 7E FC        lea di, [bp - 4]
BAA2  16              push ss
BAA3  57              push di
BAA4  6A 0B           push 0xb
BAA6  9A C4 0E 2A 23  call far 232A:0EC4
BAAB  80 7E FD 00     cmp byte ptr [bp - 3], 0
BAAF  75 03           jne 0xbab4
BAB1  E9 BF FD        jmp 0xb873
loc_BAB4:
BAB4  C4 3E 60 DD     les di, ptr [0xdd60]
BAB8  06              push es
BAB9  57              push di
BABA  C4 3E 58 DD     les di, ptr [0xdd58]
BABE  06              push es
BABF  57              push di
BAC0  68 A0 0F        push 0xfa0
BAC3  9A 12 0A C9 26  call far 26C9:0A12
BAC8  8B 46 FA        mov ax, word ptr [bp - 6]
BACB  89 46 FE        mov word ptr [bp - 2], ax
BACE  8A 46 F7        mov al, byte ptr [bp - 9]
BAD1  A2 2A 9A        mov byte ptr [0x9a2a], al
loc_BAD4:
BAD4  8B 46 FE        mov ax, word ptr [bp - 2]
BAD7  C9              leave
BAD8  C2 04 00        ret 4
; data (not reached as code), 27 bytes
BADB                  pstr 'REJECTED: '
BAE6                  pstr ' wants to leave'

; ---- routine 0AB9:BAF6  (found by: call)
sub_BAF6:
BAF6  C8 0A 02 00     enter 0x20a, 0
BAFA  8B 46 06        mov ax, word ptr [bp + 6]
BAFD  C1 E0 03        shl ax, 3
BB00  C4 3E BA D7     les di, ptr [0xd7ba]
BB04  03 F8           add di, ax
BB06  89 7E FA        mov word ptr [bp - 6], di
BB09  8C 46 FC        mov word ptr [bp - 4], es
BB0C  6B 46 04 3E     imul ax, word ptr [bp + 4], 0x3e
BB10  C4 3E C2 D7     les di, ptr [0xd7c2]
BB14  03 F8           add di, ax
BB16  81 C7 C2 FF     add di, 0xffc2
BB1A  C4 7E FA        les di, ptr [bp - 6]
BB1D  26 8A 05        mov al, byte ptr es:[di]
BB20  30 E4           xor ah, ah
BB22  3B 46 04        cmp ax, word ptr [bp + 4]
BB25  75 0F           jne 0xbb36
BB27  FF 76 06        push word ptr [bp + 6]
BB2A  FF 76 04        push word ptr [bp + 4]
BB2D  9A 19 7B 55 1B  call far 1B55:7B19
BB32  08 C0           or al, al
BB34  75 04           jne 0xbb3a
loc_BB36:
BB36  B0 00           mov al, 0
BB38  EB 02           jmp 0xbb3c
loc_BB3A:
BB3A  B0 01           mov al, 1
loc_BB3C:
BB3C  50              push ax
BB3D  8D BE F6 FD     lea di, [bp - 0x20a]
BB41  16              push ss
BB42  57              push di
BB43  BF DB BA        mov di, 0xbadb
BB46  0E              push cs
BB47  57              push di
BB48  9A 53 0B C9 26  call far 26C9:0B53
BB4D  8D BE F6 FE     lea di, [bp - 0x10a]
BB51  16              push ss
BB52  57              push di
BB53  FF 76 06        push word ptr [bp + 6]
BB56  9A DC 44 55 1B  call far 1B55:44DC
BB5B  9A D2 0B C9 26  call far 26C9:0BD2
BB60  BF E6 BA        mov di, 0xbae6
BB63  0E              push cs
BB64  57              push di
BB65  9A D2 0B C9 26  call far 26C9:0BD2
BB6A  9A 98 00 2A 23  call far 232A:0098
BB6F  88 46 FF        mov byte ptr [bp - 1], al
BB72  8A 46 FF        mov al, byte ptr [bp - 1]
BB75  C9              leave
BB76  C2 04 00        ret 4

; ---- routine 0AB9:BB79  (found by: call)
sub_BB79:
BB79  55              push bp
BB7A  89 E5           mov bp, sp
BB7C  8B 7E 04        mov di, word ptr [bp + 4]
BB7F  36 8A 45 F2     mov al, byte ptr ss:[di - 0xe]
BB83  30 E4           xor ah, ah
BB85  8B F8           mov di, ax
BB87  8A 85 AD 0C     mov al, byte ptr [di + 0xcad]
BB8B  30 E4           xor ah, ah
BB8D  D1 E0           shl ax, 1
BB8F  C4 3E 5C DD     les di, ptr [0xdd5c]
BB93  03 F8           add di, ax
BB95  81 C7 BE 03     add di, 0x3be
BB99  06              push es
BB9A  57              push di
BB9B  6A 70           push 0x70
BB9D  6A 01           push 1
BB9F  9A 4B 03 BC 24  call far 24BC:034B
BBA4  C9              leave
BBA5  C2 02 00        ret 2

; ---- routine 0AB9:BBA8  (found by: call)
sub_BBA8:
BBA8  55              push bp
BBA9  89 E5           mov bp, sp
BBAB  8B 7E 04        mov di, word ptr [bp + 4]
BBAE  36 8A 45 FE     mov al, byte ptr ss:[di - 2]
BBB2  98              cwde
BBB3  8B F8           mov di, ax
BBB5  8A 85 B4 0C     mov al, byte ptr [di + 0xcb4]
BBB9  30 E4           xor ah, ah
BBBB  D1 E0           shl ax, 1
BBBD  C4 3E 5C DD     les di, ptr [0xdd5c]
BBC1  03 F8           add di, ax
BBC3  81 C7 7E 07     add di, 0x77e
BBC7  06              push es
BBC8  57              push di
BBC9  6A 70           push 0x70
BBCB  8B 7E 04        mov di, word ptr [bp + 4]
BBCE  36 8A 45 FE     mov al, byte ptr ss:[di - 2]
BBD2  30 E4           xor ah, ah
BBD4  40              inc ax
BBD5  40              inc ax
BBD6  50              push ax
BBD7  9A 4B 03 BC 24  call far 24BC:034B
BBDC  C9              leave
BBDD  C2 02 00        ret 2
; data (not reached as code), 2 bytes
BBE0                  db 01 10   ; ..

; ---- routine 0AB9:BBE2  (found by: call)
sub_BBE2:
BBE2  C8 00 01 00     enter 0x100, 0
BBE6  BF A0 14        mov di, 0x14a0
BBE9  1E              push ds
BBEA  57              push di
BBEB  BF 5C DD        mov di, 0xdd5c
BBEE  1E              push ds
BBEF  57              push di
BBF0  9A 2F 05 2A 23  call far 232A:052F
BBF5  BF 5E 14        mov di, 0x145e
BBF8  1E              push ds
BBF9  57              push di
BBFA  BF 5C DD        mov di, 0xdd5c
BBFD  1E              push ds
BBFE  57              push di
BBFF  9A 2F 05 2A 23  call far 232A:052F
BC04  8B 7E 04        mov di, word ptr [bp + 4]
BC07  36 80 7D F3 05  cmp byte ptr ss:[di - 0xd], 5
BC0C  75 0F           jne 0xbc1d
BC0E  BF 00 16        mov di, 0x1600
BC11  1E              push ds
BC12  57              push di
BC13  BF 5C DD        mov di, 0xdd5c
BC16  1E              push ds
BC17  57              push di
BC18  9A 2F 05 2A 23  call far 232A:052F
loc_BC1D:
BC1D  8B 7E 04        mov di, word ptr [bp + 4]
BC20  36 8B 45 0A     mov ax, word ptr ss:[di + 0xa]
BC24  C1 E0 03        shl ax, 3
BC27  C4 3E BA D7     les di, ptr [0xd7ba]
BC2B  03 F8           add di, ax
BC2D  26 8A 45 07     mov al, byte ptr es:[di + 7]
BC31  30 E4           xor ah, ah
BC33  8B F8           mov di, ax
BC35  8A 85 08 87     mov al, byte ptr [di - 0x78f8]
BC39  50              push ax
BC3A  8D BE 00 FF     lea di, [bp - 0x100]
BC3E  16              push ss
BC3F  57              push di
BC40  8B 7E 04        mov di, word ptr [bp + 4]
BC43  36 8B 45 0A     mov ax, word ptr ss:[di + 0xa]
BC47  C4 3E AA D7     les di, ptr [0xd7aa]
BC4B  03 F8           add di, ax
BC4D  26 8A 05        mov al, byte ptr es:[di]
BC50  50              push ax
BC51  9A 6F 0C C9 26  call far 26C9:0C6F
BC56  6A 04           push 4
BC58  6A 3B           push 0x3b
BC5A  BF 5C DD        mov di, 0xdd5c
BC5D  1E              push ds
BC5E  57              push di
BC5F  9A 1B 04 2A 23  call far 232A:041B
BC64  8D BE 00 FF     lea di, [bp - 0x100]
BC68  16              push ss
BC69  57              push di
BC6A  8B 7E 04        mov di, word ptr [bp + 4]
BC6D  36 FF 75 0A     push word ptr ss:[di + 0xa]
BC71  9A DC 44 55 1B  call far 1B55:44DC
BC76  6A 04           push 4
BC78  6A 3D           push 0x3d
BC7A  BF 5C DD        mov di, 0xdd5c
BC7D  1E              push ds
BC7E  57              push di
BC7F  9A 9D 03 2A 23  call far 232A:039D
BC84  8B 7E 04        mov di, word ptr [bp + 4]
BC87  57              push di
BC88  E8 EE FE        call 0xbb79
BC8B  8B 7E 04        mov di, word ptr [bp + 4]
BC8E  36 80 7D F3 02  cmp byte ptr ss:[di - 0xd], 2
BC93  B0 00           mov al, 0
BC95  75 01           jne 0xbc98
BC97  40              inc ax
loc_BC98:
BC98  98              cwde
BC99  8B F8           mov di, ax
BC9B  8A 85 B2 0C     mov al, byte ptr [di + 0xcb2]
BC9F  50              push ax
BCA0  8D BE 00 FF     lea di, [bp - 0x100]
BCA4  16              push ss
BCA5  57              push di
BCA6  8B 7E 04        mov di, word ptr [bp + 4]
BCA9  36 8A 45 F1     mov al, byte ptr ss:[di - 0xf]
BCAD  30 E4           xor ah, ah
BCAF  50              push ax
BCB0  9A 3C 48 55 1B  call far 1B55:483C
BCB5  52              push dx
BCB6  50              push ax
BCB7  9A C9 07 2A 23  call far 232A:07C9
BCBC  6A 0A           push 0xa
BCBE  6A 3B           push 0x3b
BCC0  BF 5C DD        mov di, 0xdd5c
BCC3  1E              push ds
BCC4  57              push di
BCC5  9A 1B 04 2A 23  call far 232A:041B
BCCA  8B 7E 04        mov di, word ptr [bp + 4]
BCCD  57              push di
BCCE  E8 D7 FE        call 0xbba8
BCD1  8B 7E 04        mov di, word ptr [bp + 4]
BCD4  36 80 7D F3 04  cmp byte ptr ss:[di - 0xd], 4
BCD9  B0 00           mov al, 0
BCDB  75 01           jne 0xbcde
BCDD  40              inc ax
loc_BCDE:
BCDE  98              cwde
BCDF  8B F8           mov di, ax
BCE1  8A 85 B2 0C     mov al, byte ptr [di + 0xcb2]
BCE5  50              push ax
BCE6  8D BE 00 FF     lea di, [bp - 0x100]
BCEA  16              push ss
BCEB  57              push di
BCEC  8B 7E 04        mov di, word ptr [bp + 4]
BCEF  36 FF 75 FA     push word ptr ss:[di - 6]
BCF3  36 FF 75 F8     push word ptr ss:[di - 8]
BCF7  9A C9 07 2A 23  call far 232A:07C9
BCFC  6A 10           push 0x10
BCFE  6A 3B           push 0x3b
BD00  BF 5C DD        mov di, 0xdd5c
BD03  1E              push ds
BD04  57              push di
BD05  9A 1B 04 2A 23  call far 232A:041B
BD0A  8B 7E 04        mov di, word ptr [bp + 4]
BD0D  36 8A 45 F3     mov al, byte ptr ss:[di - 0xd]
BD11  30 E4           xor ah, ah
BD13  8B F8           mov di, ax
BD15  8A 85 B5 0C     mov al, byte ptr [di + 0xcb5]
BD19  30 E4           xor ah, ah
BD1B  69 C0 A0 00     imul ax, ax, 0xa0
BD1F  C4 3E 5C DD     les di, ptr [0xdd5c]
BD23  03 F8           add di, ax
BD25  81 C7 D2 FF     add di, 0xffd2
BD29  06              push es
BD2A  57              push di
BD2B  6A 0E           push 0xe
BD2D  6A 16           push 0x16
BD2F  9A 4B 03 BC 24  call far 24BC:034B
BD34  6A 0E           push 0xe
BD36  BF E0 BB        mov di, 0xbbe0
BD39  0E              push cs
BD3A  57              push di
BD3B  8B 7E 04        mov di, word ptr [bp + 4]
BD3E  36 8A 45 F3     mov al, byte ptr ss:[di - 0xd]
BD42  30 E4           xor ah, ah
BD44  8B F8           mov di, ax
BD46  8A 85 B5 0C     mov al, byte ptr [di + 0xcb5]
BD4A  50              push ax
BD4B  6A 38           push 0x38
BD4D  BF 5C DD        mov di, 0xdd5c
BD50  1E              push ds
BD51  57              push di
BD52  9A 1B 04 2A 23  call far 232A:041B
BD57  C9              leave
BD58  C2 02 00        ret 2

; ---- routine 0AB9:BD5B  (found by: call)
sub_BD5B:
BD5B  55              push bp
BD5C  89 E5           mov bp, sp
BD5E  8B 7E 04        mov di, word ptr [bp + 4]
BD61  36 8A 45 F3     mov al, byte ptr ss:[di - 0xd]
BD65  3C 01           cmp al, 1
BD67  75 2D           jne 0xbd96
BD69  80 3E 88 DE 07  cmp byte ptr [0xde88], 7
BD6E  75 07           jne 0xbd77
BD70  C6 06 88 DE 05  mov byte ptr [0xde88], 5
BD75  EB 0C           jmp 0xbd83
loc_BD77:
BD77  80 3E 88 DE 08  cmp byte ptr [0xde88], 8
BD7C  75 05           jne 0xbd83
BD7E  C6 06 88 DE 06  mov byte ptr [0xde88], 6
loc_BD83:
BD83  8B 7E 04        mov di, word ptr [bp + 4]
BD86  81 C7 F2 FF     add di, 0xfff2
BD8A  16              push ss
BD8B  57              push di
BD8C  6A 04           push 4
BD8E  9A C4 0E 2A 23  call far 232A:0EC4
BD93  E9 B3 00        jmp 0xbe49
loc_BD96:
BD96  3C 02           cmp al, 2
BD98  75 2E           jne 0xbdc8
BD9A  80 3E 88 DE 05  cmp byte ptr [0xde88], 5
BD9F  75 07           jne 0xbda8
BDA1  C6 06 88 DE 06  mov byte ptr [0xde88], 6
BDA6  EB 0C           jmp 0xbdb4
loc_BDA8:
BDA8  80 3E 88 DE 06  cmp byte ptr [0xde88], 6
BDAD  75 05           jne 0xbdb4
BDAF  C6 06 88 DE 05  mov byte ptr [0xde88], 5
loc_BDB4:
BDB4  8B 7E 04        mov di, word ptr [bp + 4]
BDB7  81 C7 F1 FF     add di, 0xfff1
BDBB  16              push ss
BDBC  57              push di
BDBD  68 FF 00        push 0xff
BDC0  9A C4 0E 2A 23  call far 232A:0EC4
BDC5  E9 81 00        jmp 0xbe49
loc_BDC8:
BDC8  3C 03           cmp al, 3
BDCA  75 13           jne 0xbddf
BDCC  8B 7E 04        mov di, word ptr [bp + 4]
BDCF  36 80 7D FE 00  cmp byte ptr ss:[di - 2], 0
BDD4  B0 00           mov al, 0
BDD6  75 01           jne 0xbdd9
BDD8  40              inc ax
loc_BDD9:
BDD9  36 88 45 FE     mov byte ptr ss:[di - 2], al
BDDD  EB 6A           jmp 0xbe49
loc_BDDF:
BDDF  3C 04           cmp al, 4
BDE1  75 66           jne 0xbe49
BDE3  A0 88 DE        mov al, byte ptr [0xde88]
BDE6  3C 05           cmp al, 5
BDE8  72 5F           jb 0xbe49
BDEA  3C 0C           cmp al, 0xc
BDEC  77 5B           ja 0xbe49
BDEE  A0 88 DE        mov al, byte ptr [0xde88]
BDF1  30 E4           xor ah, ah
BDF3  8B F8           mov di, ax
BDF5  D1 E7           shl di, 1
BDF7  8B 85 B2 0C     mov ax, word ptr [di + 0xcb2]
BDFB  99              cdq
BDFC  8B 7E 04        mov di, word ptr [bp + 4]
BDFF  36 01 45 F8     add word ptr ss:[di - 8], ax
BE03  36 11 55 FA     adc word ptr ss:[di - 6], dx
BE07  36 83 7D FA 00  cmp word ptr ss:[di - 6], 0
BE0C  7C 09           jl 0xbe17
BE0E  7F 16           jg 0xbe26
BE10  36 83 7D F8 00  cmp word ptr ss:[di - 8], 0
BE15  73 0F           jae 0xbe26
loc_BE17:
BE17  8B 7E 04        mov di, word ptr [bp + 4]
BE1A  31 C0           xor ax, ax
BE1C  36 89 45 F8     mov word ptr ss:[di - 8], ax
BE20  36 89 45 FA     mov word ptr ss:[di - 6], ax
BE24  EB 23           jmp 0xbe49
loc_BE26:
BE26  8B 7E 04        mov di, word ptr [bp + 4]
BE29  36 83 7D FA 0F  cmp word ptr ss:[di - 6], 0xf
BE2E  7F 0A           jg 0xbe3a
BE30  7C 17           jl 0xbe49
BE32  36 81 7D F8 40 42 cmp word ptr ss:[di - 8], 0x4240
BE38  76 0F           jbe 0xbe49
loc_BE3A:
BE3A  8B 7E 04        mov di, word ptr [bp + 4]
BE3D  36 C7 45 F8 40 42 mov word ptr ss:[di - 8], 0x4240
BE43  36 C7 45 FA 0F 00 mov word ptr ss:[di - 6], 0xf
loc_BE49:
BE49  C9              leave
BE4A  C2 02 00        ret 2
; data (not reached as code), 87 bytes
BE4D                  pstr 'REJECTED: not enough money offered'
BE70                  pstr 'REJECTED: internationals demanded'
BE92                  pstr 'CONTRACT ACCEPTED'

; ---- routine 0AB9:BEA4  (found by: call)
sub_BEA4:
BEA4  C8 0A 00 00     enter 0xa, 0
BEA8  6B 46 06 0F     imul ax, word ptr [bp + 6], 0xf
BEAC  C4 3E BE D7     les di, ptr [0xd7be]
BEB0  03 F8           add di, ax
BEB2  8B 46 06        mov ax, word ptr [bp + 6]
BEB5  C1 E0 03        shl ax, 3
BEB8  C4 3E BA D7     les di, ptr [0xd7ba]
BEBC  03 F8           add di, ax
BEBE  89 7E F6        mov word ptr [bp - 0xa], di
BEC1  8C 46 F8        mov word ptr [bp - 8], es
BEC4  C4 3E D2 D7     les di, ptr [0xd7d2]
BEC8  26 8A 45 04     mov al, byte ptr es:[di + 4]
BECC  30 E4           xor ah, ah
BECE  8B F8           mov di, ax
BED0  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
BED4  C4 7E F6        les di, ptr [bp - 0xa]
BED7  26 3A 05        cmp al, byte ptr es:[di]
BEDA  75 21           jne 0xbefd
BEDC  FF 76 06        push word ptr [bp + 6]
BEDF  C4 3E D2 D7     les di, ptr [0xd7d2]
BEE3  26 8A 45 04     mov al, byte ptr es:[di + 4]
BEE7  30 E4           xor ah, ah
BEE9  8B F8           mov di, ax
BEEB  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
BEEF  30 E4           xor ah, ah
BEF1  50              push ax
BEF2  E8 01 FC        call 0xbaf6
BEF5  08 C0           or al, al
BEF7  74 04           je 0xbefd
BEF9  B0 00           mov al, 0
BEFB  EB 02           jmp 0xbeff
loc_BEFD:
BEFD  B0 01           mov al, 1
loc_BEFF:
BEFF  8B 7E 04        mov di, word ptr [bp + 4]
BF02  36 88 45 FD     mov byte ptr ss:[di - 3], al
BF06  36 80 7D FD 00  cmp byte ptr ss:[di - 3], 0
BF0B  75 08           jne 0xbf15
BF0D  36 8A 45 EF     mov al, byte ptr ss:[di - 0x11]
BF11  36 88 45 F0     mov byte ptr ss:[di - 0x10], al
loc_BF15:
BF15  8B 7E 04        mov di, word ptr [bp + 4]
BF18  36 80 7D FD 00  cmp byte ptr ss:[di - 3], 0
BF1D  75 03           jne 0xbf22
BF1F  E9 12 01        jmp 0xc034
loc_BF22:
BF22  36 8B 45 F4     mov ax, word ptr ss:[di - 0xc]
BF26  36 8B 55 F6     mov dx, word ptr ss:[di - 0xa]
BF2A  B9 04 00        mov cx, 4
BF2D  31 DB           xor bx, bx
BF2F  9A 67 0A C9 26  call far 26C9:0A67
BF34  52              push dx
BF35  50              push ax
BF36  8B 7E 04        mov di, word ptr [bp + 4]
BF39  36 FF 75 EC     push word ptr ss:[di - 0x14]
BF3D  9A 3C 48 55 1B  call far 1B55:483C
BF42  B9 3A 00        mov cx, 0x3a
BF45  31 DB           xor bx, bx
BF47  9A 2A 0A C9 26  call far 26C9:0A2A
BF4C  59              pop cx
BF4D  5B              pop bx
BF4E  03 C1           add ax, cx
BF50  13 D3           adc dx, bx
BF52  52              push dx
BF53  50              push ax
BF54  8B 7E 04        mov di, word ptr [bp + 4]
BF57  36 8A 45 F2     mov al, byte ptr ss:[di - 0xe]
BF5B  30 E4           xor ah, ah
BF5D  31 D2           xor dx, dx
BF5F  8B C8           mov cx, ax
BF61  8B DA           mov bx, dx
BF63  36 8B 45 F8     mov ax, word ptr ss:[di - 8]
BF67  36 8B 55 FA     mov dx, word ptr ss:[di - 6]
BF6B  9A 67 0A C9 26  call far 26C9:0A67
BF70  52              push dx
BF71  50              push ax
BF72  8B 7E 04        mov di, word ptr [bp + 4]
BF75  36 8A 45 F1     mov al, byte ptr ss:[di - 0xf]
BF79  30 E4           xor ah, ah
BF7B  50              push ax
BF7C  9A 3C 48 55 1B  call far 1B55:483C
BF81  B9 3A 00        mov cx, 0x3a
BF84  31 DB           xor bx, bx
BF86  9A 2A 0A C9 26  call far 26C9:0A2A
BF8B  59              pop cx
BF8C  5B              pop bx
BF8D  03 C1           add ax, cx
BF8F  13 D3           adc dx, bx
BF91  59              pop cx
BF92  5B              pop bx
BF93  3B D3           cmp dx, bx
BF95  7C 0A           jl 0xbfa1
BF97  7F 04           jg 0xbf9d
BF99  3B C1           cmp ax, cx
BF9B  72 04           jb 0xbfa1
loc_BF9D:
BF9D  B0 00           mov al, 0
BF9F  EB 02           jmp 0xbfa3
loc_BFA1:
BFA1  B0 01           mov al, 1
loc_BFA3:
BFA3  50              push ax
BFA4  BF 4D BE        mov di, 0xbe4d
BFA7  0E              push cs
BFA8  57              push di
BFA9  9A 98 00 2A 23  call far 232A:0098
BFAE  08 C0           or al, al
BFB0  75 75           jne 0xc027
BFB2  C4 7E F6        les di, ptr [bp - 0xa]
BFB5  26 80 7D 04 B4  cmp byte ptr es:[di + 4], 0xb4
BFBA  76 14           jbe 0xbfd0
BFBC  8B 7E 04        mov di, word ptr [bp + 4]
BFBF  36 80 7D FE 00  cmp byte ptr ss:[di - 2], 0
BFC4  75 0A           jne 0xbfd0
BFC6  C4 7E F6        les di, ptr [bp - 0xa]
BFC9  26 80 7D 05 08  cmp byte ptr es:[di + 5], 8
BFCE  75 04           jne 0xbfd4
loc_BFD0:
BFD0  B0 00           mov al, 0
BFD2  EB 02           jmp 0xbfd6
loc_BFD4:
BFD4  B0 01           mov al, 1
loc_BFD6:
BFD6  50              push ax
BFD7  BF 70 BE        mov di, 0xbe70
BFDA  0E              push cs
BFDB  57              push di
BFDC  9A 98 00 2A 23  call far 232A:0098
BFE1  08 C0           or al, al
BFE3  75 42           jne 0xc027
BFE5  C4 3E D2 D7     les di, ptr [0xd7d2]
BFE9  26 8A 45 04     mov al, byte ptr es:[di + 4]
BFED  30 E4           xor ah, ah
BFEF  50              push ax
BFF0  8B 7E 04        mov di, word ptr [bp + 4]
BFF3  36 8A 45 F1     mov al, byte ptr ss:[di - 0xf]
BFF7  30 E4           xor ah, ah
BFF9  50              push ax
BFFA  9A 3C 48 55 1B  call far 1B55:483C
BFFF  B9 3A 00        mov cx, 0x3a
C002  31 DB           xor bx, bx
C004  9A 2A 0A C9 26  call far 26C9:0A2A
C009  8B 7E 04        mov di, word ptr [bp + 4]
C00C  36 03 45 F8     add ax, word ptr ss:[di - 8]
C010  36 13 55 FA     adc dx, word ptr ss:[di - 6]
C014  36 03 45 06     add ax, word ptr ss:[di + 6]
C018  36 13 55 08     adc dx, word ptr ss:[di + 8]
C01C  52              push dx
C01D  50              push ax
C01E  9A 75 38 55 1B  call far 1B55:3875
C023  08 C0           or al, al
C025  74 04           je 0xc02b
loc_C027:
C027  B0 00           mov al, 0
C029  EB 02           jmp 0xc02d
loc_C02B:
C02B  B0 01           mov al, 1
loc_C02D:
C02D  8B 7E 04        mov di, word ptr [bp + 4]
C030  36 88 45 FD     mov byte ptr ss:[di - 3], al
loc_C034:
C034  8B 7E 04        mov di, word ptr [bp + 4]
C037  36 8A 45 FD     mov al, byte ptr ss:[di - 3]
C03B  88 46 FF        mov byte ptr [bp - 1], al
C03E  36 80 7D FD 00  cmp byte ptr ss:[di - 3], 0
C043  74 0A           je 0xc04f
C045  BF 92 BE        mov di, 0xbe92
C048  0E              push cs
C049  57              push di
C04A  9A 02 07 BC 24  call far 24BC:0702
loc_C04F:
C04F  8A 46 FF        mov al, byte ptr [bp - 1]
C052  C9              leave
C053  C2 04 00        ret 4

; ---- routine 0AB9:C056  (found by: call)
sub_C056:
C056  55              push bp
C057  89 E5           mov bp, sp
C059  C4 7E 06        les di, ptr [bp + 6]
C05C  06              push es
C05D  57              push di
C05E  BF 5C DD        mov di, 0xdd5c
C061  1E              push ds
C062  57              push di
C063  9A 2F 05 2A 23  call far 232A:052F
C068  BF DA 4E        mov di, 0x4eda
C06B  1E              push ds
C06C  57              push di
C06D  BF 5C DD        mov di, 0xdd5c
C070  1E              push ds
C071  57              push di
C072  9A 2F 05 2A 23  call far 232A:052F
C077  C4 3E 5C DD     les di, ptr [0xdd5c]
C07B  06              push es
C07C  57              push di
C07D  C4 3E 58 DD     les di, ptr [0xdd58]
C081  06              push es
C082  57              push di
C083  68 A0 0F        push 0xfa0
C086  9A 12 0A C9 26  call far 26C9:0A12
C08B  9A 9B 09 2A 23  call far 232A:099B
C090  C9              leave
C091  C2 06 00        ret 6
; data (not reached as code), 15 bytes
C094                  pstr ' is not 18 yet'

; ---- routine 0AB9:C0A3  (found by: call, far)
sub_C0A3:
C0A3  C8 18 01 00     enter 0x118, 0
C0A7  83 7E 0A 00     cmp word ptr [bp + 0xa], 0
C0AB  75 03           jne 0xc0b0
C0AD  E9 85 02        jmp 0xc335
loc_C0B0:
C0B0  8B 46 0A        mov ax, word ptr [bp + 0xa]
C0B3  C1 E0 03        shl ax, 3
C0B6  C4 3E BA D7     les di, ptr [0xd7ba]
C0BA  03 F8           add di, ax
C0BC  89 7E E8        mov word ptr [bp - 0x18], di
C0BF  8C 46 EA        mov word ptr [bp - 0x16], es
C0C2  C6 46 FF 00     mov byte ptr [bp - 1], 0
C0C6  26 80 7D 01 12  cmp byte ptr es:[di + 1], 0x12
C0CB  B0 00           mov al, 0
C0CD  73 01           jae 0xc0d0
C0CF  40              inc ax
loc_C0D0:
C0D0  50              push ax
C0D1  8D BE E8 FE     lea di, [bp - 0x118]
C0D5  16              push ss
C0D6  57              push di
C0D7  FF 76 0A        push word ptr [bp + 0xa]
C0DA  9A DC 44 55 1B  call far 1B55:44DC
C0DF  BF 94 C0        mov di, 0xc094
C0E2  0E              push cs
C0E3  57              push di
C0E4  9A D2 0B C9 26  call far 26C9:0BD2
C0E9  9A 98 00 2A 23  call far 232A:0098
C0EE  08 C0           or al, al
C0F0  74 03           je 0xc0f5
C0F2  E9 40 02        jmp 0xc335
loc_C0F5:
C0F5  C6 06 2A 9A 00  mov byte ptr [0x9a2a], 0
C0FA  FF 76 0A        push word ptr [bp + 0xa]
C0FD  0E              push cs
C0FE  E8 B2 D4        call 0x95b3
C101  C4 7E E8        les di, ptr [bp - 0x18]
C104  26 8A 45 01     mov al, byte ptr es:[di + 1]
C108  26 3A 45 02     cmp al, byte ptr es:[di + 2]
C10C  76 06           jbe 0xc114
C10E  C6 46 F2 01     mov byte ptr [bp - 0xe], 1
C112  EB 0A           jmp 0xc11e
loc_C114:
C114  6A 04           push 4
C116  9A 6D 07 2A 23  call far 232A:076D
C11B  88 46 F2        mov byte ptr [bp - 0xe], al
loc_C11E:
C11E  6B 46 0A 0F     imul ax, word ptr [bp + 0xa], 0xf
C122  C4 3E BE D7     les di, ptr [0xd7be]
C126  03 F8           add di, ax
C128  26 80 7D 0C 0A  cmp byte ptr es:[di + 0xc], 0xa
C12D  76 2B           jbe 0xc15a
C12F  6B 46 0A 0F     imul ax, word ptr [bp + 0xa], 0xf
C133  C4 3E BE D7     les di, ptr [0xd7be]
C137  03 F8           add di, ax
C139  26 8A 45 09     mov al, byte ptr es:[di + 9]
C13D  30 E4           xor ah, ah
C13F  31 D2           xor dx, dx
C141  52              push dx
C142  50              push ax
C143  C4 7E E8        les di, ptr [bp - 0x18]
C146  26 8A 45 04     mov al, byte ptr es:[di + 4]
C14A  30 E4           xor ah, ah
C14C  31 D2           xor dx, dx
C14E  52              push dx
C14F  50              push ax
C150  9A C0 04 BC 24  call far 24BC:04C0
C155  88 46 F1        mov byte ptr [bp - 0xf], al
C158  EB 0A           jmp 0xc164
loc_C15A:
C15A  C4 7E E8        les di, ptr [bp - 0x18]
C15D  26 8A 45 04     mov al, byte ptr es:[di + 4]
C161  88 46 F1        mov byte ptr [bp - 0xf], al
loc_C164:
C164  6B 46 0A 0F     imul ax, word ptr [bp + 0xa], 0xf
C168  C4 3E BE D7     les di, ptr [0xd7be]
C16C  03 F8           add di, ax
C16E  26 80 7D 0C 0A  cmp byte ptr es:[di + 0xc], 0xa
C173  76 21           jbe 0xc196
C175  FF 76 0A        push word ptr [bp + 0xa]
C178  9A D7 49 55 1B  call far 1B55:49D7
C17D  30 E4           xor ah, ah
C17F  31 D2           xor dx, dx
C181  52              push dx
C182  50              push ax
C183  8A 46 F1        mov al, byte ptr [bp - 0xf]
C186  30 E4           xor ah, ah
C188  31 D2           xor dx, dx
C18A  52              push dx
C18B  50              push ax
C18C  9A C0 04 BC 24  call far 24BC:04C0
C191  89 46 EC        mov word ptr [bp - 0x14], ax
C194  EB 0D           jmp 0xc1a3
loc_C196:
C196  FF 76 0A        push word ptr [bp + 0xa]
C199  9A D7 49 55 1B  call far 1B55:49D7
C19E  30 E4           xor ah, ah
C1A0  89 46 EC        mov word ptr [bp - 0x14], ax
loc_C1A3:
C1A3  6A 01           push 1
C1A5  6B 46 0A 0F     imul ax, word ptr [bp + 0xa], 0xf
C1A9  C4 3E BE D7     les di, ptr [0xd7be]
C1AD  03 F8           add di, ax
C1AF  26 8A 45 0B     mov al, byte ptr es:[di + 0xb]
C1B3  30 E4           xor ah, ah
C1B5  50              push ax
C1B6  9A 59 02 BC 24  call far 24BC:0259
C1BB  88 46 FE        mov byte ptr [bp - 2], al
C1BE  6B 46 0A 0F     imul ax, word ptr [bp + 0xa], 0xf
C1C2  C4 3E BE D7     les di, ptr [0xd7be]
C1C6  03 F8           add di, ax
C1C8  26 80 7D 0C 3A  cmp byte ptr es:[di + 0xc], 0x3a
C1CD  72 2A           jb 0xc1f9
C1CF  C4 3E D2 D7     les di, ptr [0xd7d2]
C1D3  26 8A 45 04     mov al, byte ptr es:[di + 4]
C1D7  30 E4           xor ah, ah
C1D9  8B F8           mov di, ax
C1DB  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
C1DF  C4 7E E8        les di, ptr [bp - 0x18]
C1E2  26 3A 05        cmp al, byte ptr es:[di]
C1E5  75 12           jne 0xc1f9
C1E7  31 C0           xor ax, ax
C1E9  89 46 F8        mov word ptr [bp - 8], ax
C1EC  89 46 FA        mov word ptr [bp - 6], ax
C1EF  31 C0           xor ax, ax
C1F1  89 46 F4        mov word ptr [bp - 0xc], ax
C1F4  89 46 F6        mov word ptr [bp - 0xa], ax
C1F7  EB 23           jmp 0xc21c
loc_C1F9:
C1F9  C4 7E E8        les di, ptr [bp - 0x18]
C1FC  26 8A 45 04     mov al, byte ptr es:[di + 4]
C200  30 E4           xor ah, ah
C202  50              push ax
C203  9A 79 0D 98 19  call far 1998:0D79
C208  89 46 F8        mov word ptr [bp - 8], ax
C20B  89 56 FA        mov word ptr [bp - 6], dx
C20E  FF 76 EC        push word ptr [bp - 0x14]
C211  9A 79 0D 98 19  call far 1998:0D79
C216  89 46 F4        mov word ptr [bp - 0xc], ax
C219  89 56 F6        mov word ptr [bp - 0xa], dx
loc_C21C:
C21C  C6 46 F0 00     mov byte ptr [bp - 0x10], 0
C220  6A 03           push 3
C222  9A 6D 07 2A 23  call far 232A:076D
C227  40              inc ax
C228  40              inc ax
C229  88 46 EF        mov byte ptr [bp - 0x11], al
loc_C22C:
C22C  FE 46 F0        inc byte ptr [bp - 0x10]
C22F  C6 46 F3 01     mov byte ptr [bp - 0xd], 1
loc_C233:
C233  55              push bp
C234  E8 AB F9        call 0xbbe2
C237  C4 3E 5C DD     les di, ptr [0xdd5c]
C23B  06              push es
C23C  57              push di
C23D  C4 3E 58 DD     les di, ptr [0xdd58]
C241  06              push es
C242  57              push di
C243  68 A0 0F        push 0xfa0
C246  9A 12 0A C9 26  call far 26C9:0A12
C24B  9A 9B 09 2A 23  call far 232A:099B
C250  A0 88 DE        mov al, byte ptr [0xde88]
C253  3C 0D           cmp al, 0xd
C255  75 16           jne 0xc26d
C257  80 3E 2A 9A 00  cmp byte ptr [0x9a2a], 0
C25C  B0 00           mov al, 0
C25E  75 01           jne 0xc261
C260  40              inc ax
loc_C261:
C261  A2 2A 9A        mov byte ptr [0x9a2a], al
C264  FF 76 0A        push word ptr [bp + 0xa]
C267  0E              push cs
C268  E8 48 D3        call 0x95b3
C26B  EB 43           jmp 0xc2b0
loc_C26D:
C26D  3C 02           cmp al, 2
C26F  75 19           jne 0xc28a
C271  80 7E F3 05     cmp byte ptr [bp - 0xd], 5
C275  74 11           je 0xc288
C277  C6 06 88 DE 06  mov byte ptr [0xde88], 6
C27C  8D 7E F3        lea di, [bp - 0xd]
C27F  16              push ss
C280  57              push di
C281  6A 05           push 5
C283  9A 60 0E 2A 23  call far 232A:0E60
loc_C288:
C288  EB 26           jmp 0xc2b0
loc_C28A:
C28A  3C 01           cmp al, 1
C28C  75 1E           jne 0xc2ac
C28E  80 7E F3 01     cmp byte ptr [bp - 0xd], 1
C292  75 05           jne 0xc299
C294  E9 9E 00        jmp 0xc335
; data (not reached as code), 2 bytes
C297                  db EB 11   ; ..
loc_C299:
C299  C6 06 88 DE 05  mov byte ptr [0xde88], 5
C29E  8D 7E F3        lea di, [bp - 0xd]
C2A1  16              push ss
C2A2  57              push di
C2A3  6A 05           push 5
C2A5  9A 60 0E 2A 23  call far 232A:0E60
C2AA  EB 04           jmp 0xc2b0
loc_C2AC:
C2AC  55              push bp
C2AD  E8 AB FA        call 0xbd5b
loc_C2B0:
C2B0  80 7E F3 05     cmp byte ptr [bp - 0xd], 5
C2B4  74 03           je 0xc2b9
C2B6  E9 7A FF        jmp 0xc233
loc_C2B9:
C2B9  80 3E 88 DE 02  cmp byte ptr [0xde88], 2
C2BE  74 03           je 0xc2c3
C2C0  E9 70 FF        jmp 0xc233
loc_C2C3:
C2C3  FF 76 0A        push word ptr [bp + 0xa]
C2C6  55              push bp
C2C7  E8 DA FB        call 0xbea4
C2CA  08 C0           or al, al
C2CC  75 0B           jne 0xc2d9
C2CE  8A 46 F0        mov al, byte ptr [bp - 0x10]
C2D1  3A 46 EF        cmp al, byte ptr [bp - 0x11]
C2D4  74 03           je 0xc2d9
C2D6  E9 53 FF        jmp 0xc22c
loc_C2D9:
C2D9  8A 46 FD        mov al, byte ptr [bp - 3]
C2DC  88 46 FF        mov byte ptr [bp - 1], al
C2DF  80 7E FD 00     cmp byte ptr [bp - 3], 0
C2E3  75 0B           jne 0xc2f0
C2E5  BF 60 16        mov di, 0x1660
C2E8  1E              push ds
C2E9  57              push di
C2EA  55              push bp
C2EB  E8 68 FD        call 0xc056
C2EE  EB 45           jmp 0xc335
loc_C2F0:
C2F0  BF C0 16        mov di, 0x16c0
C2F3  1E              push ds
C2F4  57              push di
C2F5  55              push bp
C2F6  E8 5D FD        call 0xc056
C2F9  FF 76 0A        push word ptr [bp + 0xa]
C2FC  8A 46 F2        mov al, byte ptr [bp - 0xe]
C2FF  30 E4           xor ah, ah
C301  6B C0 3A        imul ax, ax, 0x3a
C304  50              push ax
C305  8A 46 F1        mov al, byte ptr [bp - 0xf]
C308  30 E4           xor ah, ah
C30A  50              push ax
C30B  8A 46 FE        mov al, byte ptr [bp - 2]
C30E  50              push ax
C30F  9A 07 65 55 1B  call far 1B55:6507
C314  8B 4E F8        mov cx, word ptr [bp - 8]
C317  8B 5E FA        mov bx, word ptr [bp - 6]
C31A  C4 3E D2 D7     les di, ptr [0xd7d2]
C31E  26 8A 45 04     mov al, byte ptr es:[di + 4]
C322  30 E4           xor ah, ah
C324  6B C0 5E        imul ax, ax, 0x5e
C327  C4 3E C4 DC     les di, ptr [0xdcc4]
C32B  03 F8           add di, ax
C32D  26 01 4D DC     add word ptr es:[di - 0x24], cx
C331  26 11 5D DE     adc word ptr es:[di - 0x22], bx
loc_C335:
C335  8A 46 FF        mov al, byte ptr [bp - 1]
C338  C9              leave
C339  CA 06 00        retf 6
; data (not reached as code), 28 bytes
C33C                  pstr "Your chairman won't let you"

