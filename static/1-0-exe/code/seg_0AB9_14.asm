; 1-0.EXE (One-Nil 96), code segment 0AB9 (image offsets 0AB90..1997F), part 14 of 22
; packed 1-0.EXE sha256 89ff9c5f238f24e81a0c2440a46cdd8997280a65fc3cc3d97cb974f55280a80a (LZEXE 0.91)
; unpacked (tools/static/unlzexe.py) sha256 887ed2a92767950e5309b2052409f875668605939b69e00737aa3047022b9f51
; tool: capstone 5.0.9 (pip package; core library 5.0.1280) (CS_ARCH_X86, CS_MODE_16), recursive descent from the entry point, far calls and near calls/jumps, then routine prologues (55 89 E5 / 55 8B EC / C8 iw 00) in what remains; tools/static/listing.py
; addresses are SEGMENT:OFFSET with SEGMENT the image paragraph before relocation; image offset = SEGMENT*16+OFFSET
; ---- routine 0AB9:8354  (found by: call)
sub_8354:
8354  C8 02 00 00     enter 2, 0
8358  8B 7E 04        mov di, word ptr [bp + 4]
835B  36 FF 75 FE     push word ptr ss:[di - 2]
835F  36 8A 45 E1     mov al, byte ptr ss:[di - 0x1f]
8363  98              cwde
8364  8B F8           mov di, ax
8366  8A 85 C8 D0     mov al, byte ptr [di - 0x2f38]
836A  30 E4           xor ah, ah
836C  50              push ax
836D  E8 66 7D        call 0x100d6
8370  8B 7E 04        mov di, word ptr [bp + 4]
8373  36 8A 45 E1     mov al, byte ptr ss:[di - 0x1f]
8377  30 E4           xor ah, ah
8379  F7 D8           neg ax
837B  A2 AC D0        mov byte ptr [0xd0ac], al
837E  36 8A 45 E1     mov al, byte ptr ss:[di - 0x1f]
8382  98              cwde
8383  03 F8           add di, ax
8385  36 8A 45 E2     mov al, byte ptr ss:[di - 0x1e]
8389  30 E4           xor ah, ah
838B  8B D0           mov dx, ax
838D  8B 7E 04        mov di, word ptr [bp + 4]
8390  36 8A 45 E1     mov al, byte ptr ss:[di - 0x1f]
8394  98              cwde
8395  6B C0 0C        imul ax, ax, 0xc
8398  03 F8           add di, ax
839A  03 FA           add di, dx
839C  36 8A 45 E6     mov al, byte ptr ss:[di - 0x1a]
83A0  30 E4           xor ah, ah
83A2  50              push ax
83A3  6A 0A           push 0xa
83A5  E8 3B D4        call 0x57e3
loc_83A8:
83A8  8B 7E 04        mov di, word ptr [bp + 4]
83AB  36 8A 45 E1     mov al, byte ptr ss:[di - 0x1f]
83AF  98              cwde
83B0  03 F8           add di, ax
83B2  81 C7 E2 FF     add di, 0xffe2
83B6  16              push ss
83B7  57              push di
83B8  6A 01           push 1
83BA  6A 0B           push 0xb
83BC  6A 01           push 1
83BE  9A 8C 04 BC 24  call far 24BC:048C
83C3  8B 7E 04        mov di, word ptr [bp + 4]
83C6  36 8A 45 E1     mov al, byte ptr ss:[di - 0x1f]
83CA  98              cwde
83CB  03 F8           add di, ax
83CD  36 8A 45 E2     mov al, byte ptr ss:[di - 0x1e]
83D1  30 E4           xor ah, ah
83D3  8B D0           mov dx, ax
83D5  8B 7E 04        mov di, word ptr [bp + 4]
83D8  36 8A 45 E1     mov al, byte ptr ss:[di - 0x1f]
83DC  98              cwde
83DD  6B C0 0C        imul ax, ax, 0xc
83E0  03 F8           add di, ax
83E2  03 FA           add di, dx
83E4  36 8A 45 E6     mov al, byte ptr ss:[di - 0x1a]
83E8  30 E4           xor ah, ah
83EA  6B F8 19        imul di, ax, 0x19
83ED  81 C7 EF CC     add di, 0xccef
83F1  1E              push ds
83F2  57              push di
83F3  0E              push cs
83F4  E8 AA 98        call 0x1ca1
83F7  08 C0           or al, al
83F9  75 AD           jne 0x83a8
83FB  C6 06 B7 D0 01  mov byte ptr [0xd0b7], 1
8400  C6 06 B8 D0 00  mov byte ptr [0xd0b8], 0
loc_8405:
8405  E8 FA F5        call 0x7a02
8408  80 3E B7 D0 00  cmp byte ptr [0xd0b7], 0
840D  75 F6           jne 0x8405
840F  6A 00           push 0
8411  E8 6A 98        call 0x1c7e
loc_8414:
8414  E8 EB F5        call 0x7a02
8417  83 3E 51 CF 00  cmp word ptr [0xcf51], 0
841C  75 F6           jne 0x8414
841E  C9              leave
841F  C2 02 00        ret 2
; data (not reached as code), 18 bytes
8422                  pstr 'penalty shoot out'

; ---- routine 0AB9:8434  (found by: call)
sub_8434:
8434  C8 26 00 00     enter 0x26, 0
8438  C4 3E D2 D7     les di, ptr [0xd7d2]
843C  89 7E DA        mov word ptr [bp - 0x26], di
843F  8C 46 DC        mov word ptr [bp - 0x24], es
8442  26 8A 45 02     mov al, byte ptr es:[di + 2]
8446  30 E4           xor ah, ah
8448  89 46 DE        mov word ptr [bp - 0x22], ax
844B  26 80 7D 02 1E  cmp byte ptr es:[di + 2], 0x1e
8450  73 04           jae 0x8456
8452  26 FE 45 02     inc byte ptr es:[di + 2]
loc_8456:
8456  C4 7E DA        les di, ptr [bp - 0x26]
8459  26 80 7D 02 02  cmp byte ptr es:[di + 2], 2
845E  73 05           jae 0x8465
8460  26 C6 45 02 02  mov byte ptr es:[di + 2], 2
loc_8465:
8465  6A 00           push 0
8467  E8 14 98        call 0x1c7e
846A  6A 3D           push 0x3d
846C  E8 A5 99        call 0x1e14
846F  80 3E CB D1 00  cmp byte ptr [0xd1cb], 0
8474  74 0A           je 0x8480
8476  BF 22 84        mov di, 0x8422
8479  0E              push cs
847A  57              push di
847B  9A 02 07 BC 24  call far 24BC:0702
loc_8480:
8480  C6 06 74 D0 00  mov byte ptr [0xd074], 0
8485  8D 7E E6        lea di, [bp - 0x1a]
8488  16              push ss
8489  57              push di
848A  6A 18           push 0x18
848C  6A 00           push 0
848E  9A 22 02 BC 24  call far 24BC:0222
8493  31 C0           xor ax, ax
8495  A3 C4 D0        mov word ptr [0xd0c4], ax
8498  C6 46 E1 00     mov byte ptr [bp - 0x1f], 0
849C  EB 03           jmp 0x84a1
loc_849E:
849E  FE 46 E1        inc byte ptr [bp - 0x1f]
loc_84A1:
84A1  8A 46 E1        mov al, byte ptr [bp - 0x1f]
84A4  98              cwde
84A5  8B F8           mov di, ax
84A7  C6 43 E2 01     mov byte ptr [bp + di - 0x1e], 1
84AB  8A 46 E1        mov al, byte ptr [bp - 0x1f]
84AE  98              cwde
84AF  8B F8           mov di, ax
84B1  C6 43 E4 05     mov byte ptr [bp + di - 0x1c], 5
84B5  8A 46 E1        mov al, byte ptr [bp - 0x1f]
84B8  98              cwde
84B9  8B F8           mov di, ax
84BB  D1 E7           shl di, 1
84BD  FF B5 E4 D6     push word ptr [di - 0x291c]
84C1  9A 7A 0E 55 1B  call far 1B55:0E7A
84C6  08 C0           or al, al
84C8  74 06           je 0x84d0
84CA  55              push bp
84CB  E8 22 FA        call 0x7ef0
84CE  EB 04           jmp 0x84d4
loc_84D0:
84D0  55              push bp
84D1  E8 82 FD        call 0x8256
loc_84D4:
84D4  80 7E E1 01     cmp byte ptr [bp - 0x1f], 1
84D8  75 C4           jne 0x849e
84DA  C7 46 FE 01 00  mov word ptr [bp - 2], 1
84DF  A0 AD D0        mov al, byte ptr [0xd0ad]
84E2  88 46 E1        mov byte ptr [bp - 0x1f], al
84E5  E8 59 55        call 0xda41
84E8  C4 3E 92 D0     les di, ptr [0xd092]
84EC  06              push es
84ED  57              push di
84EE  C4 3E 8A D0     les di, ptr [0xd08a]
84F2  06              push es
84F3  57              push di
84F4  68 A0 0F        push 0xfa0
84F7  9A 12 0A C9 26  call far 26C9:0A12
loc_84FC:
84FC  A0 C4 D0        mov al, byte ptr [0xd0c4]
84FF  30 E4           xor ah, ah
8501  8B C8           mov cx, ax
8503  8A 46 E5        mov al, byte ptr [bp - 0x1b]
8506  30 E4           xor ah, ah
8508  8B D0           mov dx, ax
850A  A0 C5 D0        mov al, byte ptr [0xd0c5]
850D  30 E4           xor ah, ah
850F  03 C2           add ax, dx
8511  3B C1           cmp ax, cx
8513  7C 72           jl 0x8587
8515  A0 C5 D0        mov al, byte ptr [0xd0c5]
8518  30 E4           xor ah, ah
851A  8B C8           mov cx, ax
851C  8A 46 E4        mov al, byte ptr [bp - 0x1c]
851F  30 E4           xor ah, ah
8521  8B D0           mov dx, ax
8523  A0 C4 D0        mov al, byte ptr [0xd0c4]
8526  30 E4           xor ah, ah
8528  03 C2           add ax, dx
852A  3B C1           cmp ax, cx
852C  7C 59           jl 0x8587
852E  55              push bp
852F  E8 22 FE        call 0x8354
8532  8A 46 E1        mov al, byte ptr [bp - 0x1f]
8535  98              cwde
8536  8B F8           mov di, ax
8538  80 7B E4 00     cmp byte ptr [bp + di - 0x1c], 0
853C  76 09           jbe 0x8547
853E  8A 46 E1        mov al, byte ptr [bp - 0x1f]
8541  98              cwde
8542  8B F8           mov di, ax
8544  FE 4B E4        dec byte ptr [bp + di - 0x1c]
loc_8547:
8547  8A 46 E1        mov al, byte ptr [bp - 0x1f]
854A  3A 06 AD D0     cmp al, byte ptr [0xd0ad]
854E  75 1C           jne 0x856c
8550  8A 46 E1        mov al, byte ptr [bp - 0x1f]
8553  98              cwde
8554  8B F8           mov di, ax
8556  80 7B E4 00     cmp byte ptr [bp + di - 0x1c], 0
855A  75 10           jne 0x856c
855C  80 7E E1 00     cmp byte ptr [bp - 0x1f], 0
8560  B0 00           mov al, 0
8562  75 01           jne 0x8565
8564  40              inc ax
loc_8565:
8565  98              cwde
8566  8B F8           mov di, ax
8568  C6 43 E4 01     mov byte ptr [bp + di - 0x1c], 1
loc_856C:
856C  8A 46 E1        mov al, byte ptr [bp - 0x1f]
856F  3A 06 AD D0     cmp al, byte ptr [0xd0ad]
8573  74 03           je 0x8578
8575  FF 46 FE        inc word ptr [bp - 2]
loc_8578:
8578  80 7E E1 00     cmp byte ptr [bp - 0x1f], 0
857C  B0 00           mov al, 0
857E  75 01           jne 0x8581
8580  40              inc ax
loc_8581:
8581  88 46 E1        mov byte ptr [bp - 0x1f], al
8584  E9 75 FF        jmp 0x84fc
loc_8587:
8587  8A 46 DE        mov al, byte ptr [bp - 0x22]
858A  C4 7E DA        les di, ptr [bp - 0x26]
858D  26 88 45 02     mov byte ptr es:[di + 2], al
8591  A0 75 D0        mov al, byte ptr [0xd075]
8594  A2 74 D0        mov byte ptr [0xd074], al
8597  C9              leave
8598  C3              ret

; ---- routine 0AB9:8599  (found by: call)
sub_8599:
8599  C8 04 00 00     enter 4, 0
859D  8A 46 0A        mov al, byte ptr [bp + 0xa]
85A0  C4 7E 06        les di, ptr [bp + 6]
85A3  26 88 45 07     mov byte ptr es:[di + 7], al
85A7  06              push es
85A8  57              push di
85A9  0E              push cs
85AA  E8 F2 98        call 0x1e9f
85AD  30 E4           xor ah, ah
85AF  D1 E0           shl ax, 1
85B1  50              push ax
85B2  C4 7E 06        les di, ptr [bp + 6]
85B5  06              push es
85B6  57              push di
85B7  0E              push cs
85B8  E8 00 97        call 0x1cbb
85BB  98              cwde
85BC  8B F8           mov di, ax
85BE  D1 E7           shl di, 1
85C0  6B 85 E4 D6 3E  imul ax, word ptr [di - 0x291c], 0x3e
85C5  C4 3E C2 D7     les di, ptr [0xd7c2]
85C9  03 F8           add di, ax
85CB  58              pop ax
85CC  03 F8           add di, ax
85CE  26 8B 45 C0     mov ax, word ptr es:[di - 0x40]
85D2  C4 7E 06        les di, ptr [bp + 6]
85D5  26 89 45 0E     mov word ptr es:[di + 0xe], ax
85D9  26 8B 45 0E     mov ax, word ptr es:[di + 0xe]
85DD  C1 E0 03        shl ax, 3
85E0  C4 3E BA D7     les di, ptr [0xd7ba]
85E4  03 F8           add di, ax
85E6  26 8A 05        mov al, byte ptr es:[di]
85E9  30 E4           xor ah, ah
85EB  50              push ax
85EC  9A 37 4A 55 1B  call far 1B55:4A37
85F1  31 D2           xor dx, dx
85F3  52              push dx
85F4  50              push ax
85F5  C4 7E 06        les di, ptr [bp + 6]
85F8  26 6B 45 0E 0F  imul ax, word ptr es:[di + 0xe], 0xf
85FD  C4 3E BE D7     les di, ptr [0xd7be]
8601  03 F8           add di, ax
8603  26 8B 05        mov ax, word ptr es:[di]
8606  31 D2           xor dx, dx
8608  52              push dx
8609  50              push ax
860A  9A FA 04 BC 24  call far 24BC:04FA
860F  C4 7E 06        les di, ptr [bp + 6]
8612  26 88 45 12     mov byte ptr es:[di + 0x12], al
8616  26 8B 45 0E     mov ax, word ptr es:[di + 0xe]
861A  C1 E0 03        shl ax, 3
861D  C4 3E BA D7     les di, ptr [0xd7ba]
8621  03 F8           add di, ax
8623  89 7E FC        mov word ptr [bp - 4], di
8626  8C 46 FE        mov word ptr [bp - 2], es
8629  26 80 7D 01 12  cmp byte ptr es:[di + 1], 0x12
862E  76 0A           jbe 0x863a
8630  C4 7E 06        les di, ptr [bp + 6]
8633  26 80 45 12 20  add byte ptr es:[di + 0x12], 0x20
8638  EB 12           jmp 0x864c
loc_863A:
863A  C4 7E FC        les di, ptr [bp - 4]
863D  26 80 7D 01 11  cmp byte ptr es:[di + 1], 0x11
8642  76 08           jbe 0x864c
8644  C4 7E 06        les di, ptr [bp + 6]
8647  26 80 45 12 10  add byte ptr es:[di + 0x12], 0x10
loc_864C:
864C  C4 7E 06        les di, ptr [bp + 6]
864F  26 FF 75 0E     push word ptr es:[di + 0xe]
8653  9A 05 4F 55 1B  call far 1B55:4F05
8658  C4 7E 06        les di, ptr [bp + 6]
865B  26 88 45 16     mov byte ptr es:[di + 0x16], al
865F  C9              leave
8660  CA 06 00        retf 6

; ---- routine 0AB9:8663  (found by: call)
sub_8663:
8663  55              push bp
8664  89 E5           mov bp, sp
8666  FF 76 0A        push word ptr [bp + 0xa]
8669  C4 7E 06        les di, ptr [bp + 6]
866C  06              push es
866D  57              push di
866E  0E              push cs
866F  E8 27 FF        call 0x8599
8672  A1 32 0D        mov ax, word ptr [0xd32]
8675  C4 7E 06        les di, ptr [bp + 6]
8678  26 89 05        mov word ptr es:[di], ax
867B  26 8B 05        mov ax, word ptr es:[di]
867E  26 89 45 02     mov word ptr es:[di + 2], ax
8682  26 8A 45 07     mov al, byte ptr es:[di + 7]
8686  30 E4           xor ah, ah
8688  50              push ax
8689  E8 74 79        call 0x10000
868C  08 C0           or al, al
868E  74 19           je 0x86a9
8690  C4 7E 06        les di, ptr [bp + 6]
8693  06              push es
8694  57              push di
8695  0E              push cs
8696  E8 22 96        call 0x1cbb
8699  98              cwde
869A  8B F8           mov di, ax
869C  8A 85 CA D0     mov al, byte ptr [di - 0x2f36]
86A0  C4 7E 06        les di, ptr [bp + 6]
86A3  26 88 45 05     mov byte ptr es:[di + 5], al
86A7  EB 17           jmp 0x86c0
loc_86A9:
86A9  C4 7E 06        les di, ptr [bp + 6]
86AC  06              push es
86AD  57              push di
86AE  0E              push cs
86AF  E8 09 96        call 0x1cbb
86B2  98              cwde
86B3  8B F8           mov di, ax
86B5  8A 85 C8 D0     mov al, byte ptr [di - 0x2f38]
86B9  C4 7E 06        les di, ptr [bp + 6]
86BC  26 88 45 05     mov byte ptr es:[di + 5], al
loc_86C0:
86C0  A1 2C 0D        mov ax, word ptr [0xd2c]
86C3  C4 7E 06        les di, ptr [bp + 6]
86C6  26 89 45 0C     mov word ptr es:[di + 0xc], ax
86CA  31 C0           xor ax, ax
86CC  26 89 45 14     mov word ptr es:[di + 0x14], ax
86D0  26 C6 45 11 00  mov byte ptr es:[di + 0x11], 0
86D5  31 C0           xor ax, ax
86D7  26 89 45 17     mov word ptr es:[di + 0x17], ax
86DB  26 C6 45 06 00  mov byte ptr es:[di + 6], 0
86E0  26 C6 45 10 05  mov byte ptr es:[di + 0x10], 5
86E5  C9              leave
86E6  CA 06 00        retf 6

; ---- routine 0AB9:86E9  (found by: call)
sub_86E9:
86E9  C8 04 00 00     enter 4, 0
86ED  C4 3E C0 DC     les di, ptr [0xdcc0]
86F1  26 8D 45 17     lea ax, es:[di + 0x17]
86F5  8C C2           mov dx, es
86F7  A3 C0 D0        mov word ptr [0xd0c0], ax
86FA  89 16 C2 D0     mov word ptr [0xd0c2], dx
86FE  31 C0           xor ax, ax
8700  A3 80 03        mov word ptr [0x380], ax
8703  BF 30 A5        mov di, 0xa530
8706  1E              push ds
8707  57              push di
8708  68 D8 27        push 0x27d8
870B  68 FF 00        push 0xff
870E  9A 22 02 BC 24  call far 24BC:0222
8713  BF D2 D0        mov di, 0xd0d2
8716  1E              push ds
8717  57              push di
8718  6A 14           push 0x14
871A  6A 00           push 0
871C  9A 22 02 BC 24  call far 24BC:0222
8721  BF E6 D0        mov di, 0xd0e6
8724  1E              push ds
8725  57              push di
8726  6A 42           push 0x42
8728  6A 00           push 0
872A  9A 22 02 BC 24  call far 24BC:0222
872F  BF C0 D1        mov di, 0xd1c0
8732  1E              push ds
8733  57              push di
8734  6A 04           push 4
8736  6A 00           push 0
8738  9A 22 02 BC 24  call far 24BC:0222
873D  BF C4 D1        mov di, 0xd1c4
8740  1E              push ds
8741  57              push di
8742  6A 04           push 4
8744  6A 00           push 0
8746  9A 22 02 BC 24  call far 24BC:0222
874B  9A 3F 0D BC 24  call far 24BC:0D3F
8750  A2 AD D0        mov byte ptr [0xd0ad], al
8753  C6 06 A0 D0 00  mov byte ptr [0xd0a0], 0
8758  C6 06 A1 D0 00  mov byte ptr [0xd0a1], 0
875D  C6 06 C8 D1 00  mov byte ptr [0xd1c8], 0
8762  C6 06 CA D1 00  mov byte ptr [0xd1ca], 0
8767  BF 46 CF        mov di, 0xcf46
876A  1E              push ds
876B  57              push di
876C  9A E9 09 98 19  call far 1998:09E9
8771  BF 3C CF        mov di, 0xcf3c
8774  1E              push ds
8775  57              push di
8776  9A 87 09 98 19  call far 1998:0987
877B  BF 56 CF        mov di, 0xcf56
877E  1E              push ds
877F  57              push di
8780  9A 87 09 98 19  call far 1998:0987
8785  C7 46 FE 01 00  mov word ptr [bp - 2], 1
878A  EB 03           jmp 0x878f
loc_878C:
878C  FF 46 FE        inc word ptr [bp - 2]
loc_878F:
878F  FF 76 FE        push word ptr [bp - 2]
8792  6B 7E FE 19     imul di, word ptr [bp - 2], 0x19
8796  81 C7 EF CC     add di, 0xccef
879A  1E              push ds
879B  57              push di
879C  0E              push cs
879D  E8 C3 FE        call 0x8663
87A0  83 7E FE 16     cmp word ptr [bp - 2], 0x16
87A4  75 E6           jne 0x878c
87A6  C6 06 18 0D 00  mov byte ptr [0xd18], 0
87AB  C6 06 B9 D0 00  mov byte ptr [0xd0b9], 0
87B0  C6 06 BA D0 01  mov byte ptr [0xd0ba], 1
87B5  C6 06 56 DD 00  mov byte ptr [0xdd56], 0
87BA  C7 06 AE D0 5B 00 mov word ptr [0xd0ae], 0x5b
87C0  C6 06 AC D0 2D  mov byte ptr [0xd0ac], 0x2d
87C5  C6 46 FD 00     mov byte ptr [bp - 3], 0
87C9  EB 03           jmp 0x87ce
loc_87CB:
87CB  FE 46 FD        inc byte ptr [bp - 3]
loc_87CE:
87CE  8A 46 FD        mov al, byte ptr [bp - 3]
87D1  98              cwde
87D2  8B F8           mov di, ax
87D4  C6 85 28 D1 00  mov byte ptr [di - 0x2ed8], 0
87D9  8A 46 FD        mov al, byte ptr [bp - 3]
87DC  98              cwde
87DD  6B F8 07        imul di, ax, 7
87E0  81 C7 2E CF     add di, 0xcf2e
87E4  1E              push ds
87E5  57              push di
87E6  9A 87 09 98 19  call far 1998:0987
87EB  A0 DD D6        mov al, byte ptr [0xd6dd]
87EE  98              cwde
87EF  8B F8           mov di, ax
87F1  8A 95 58 0D     mov dl, byte ptr [di + 0xd58]
87F5  8A 46 FD        mov al, byte ptr [bp - 3]
87F8  98              cwde
87F9  8B F8           mov di, ax
87FB  88 95 E0 D6     mov byte ptr [di - 0x2920], dl
87FF  8A 46 FD        mov al, byte ptr [bp - 3]
8802  98              cwde
8803  8B F8           mov di, ax
8805  C6 85 DE D6 00  mov byte ptr [di - 0x2922], 0
880A  8A 46 FD        mov al, byte ptr [bp - 3]
880D  98              cwde
880E  8B F8           mov di, ax
8810  D1 E7           shl di, 1
8812  FF B5 E4 D6     push word ptr [di - 0x291c]
8816  9A 7A 0E 55 1B  call far 1B55:0E7A
881B  08 C0           or al, al
881D  75 4E           jne 0x886d
881F  8A 46 FD        mov al, byte ptr [bp - 3]
8822  98              cwde
8823  8B F8           mov di, ax
8825  D1 E7           shl di, 1
8827  6B 85 E4 D6 3E  imul ax, word ptr [di - 0x291c], 0x3e
882C  C4 3E C2 D7     les di, ptr [0xd7c2]
8830  03 F8           add di, ax
8832  26 80 7D F9 00  cmp byte ptr es:[di - 7], 0
8837  75 34           jne 0x886d
8839  8A 46 FD        mov al, byte ptr [bp - 3]
883C  98              cwde
883D  8B F8           mov di, ax
883F  D1 E7           shl di, 1
8841  FF B5 E4 D6     push word ptr [di - 0x291c]
8845  9A 7A 0E 55 1B  call far 1B55:0E7A
884A  08 C0           or al, al
884C  75 1B           jne 0x8869
884E  80 7E FD 00     cmp byte ptr [bp - 3], 0
8852  B0 00           mov al, 0
8854  75 01           jne 0x8857
8856  40              inc ax
loc_8857:
8857  98              cwde
8858  8B F8           mov di, ax
885A  D1 E7           shl di, 1
885C  FF B5 E4 D6     push word ptr [di - 0x291c]
8860  9A 7A 0E 55 1B  call far 1B55:0E7A
8865  08 C0           or al, al
8867  74 04           je 0x886d
loc_8869:
8869  B0 00           mov al, 0
886B  EB 02           jmp 0x886f
loc_886D:
886D  B0 01           mov al, 1
loc_886F:
886F  8A D0           mov dl, al
8871  8A 46 FD        mov al, byte ptr [bp - 3]
8874  98              cwde
8875  8B F8           mov di, ax
8877  88 95 CE D1     mov byte ptr [di - 0x2e32], dl
887B  80 7E FD 01     cmp byte ptr [bp - 3], 1
887F  74 03           je 0x8884
8881  E9 47 FF        jmp 0x87cb
loc_8884:
8884  E8 C8 8D        call 0x164f
8887  C6 06 E2 D6 00  mov byte ptr [0xd6e2], 0
888C  31 C0           xor ax, ax
888E  A3 B0 D0        mov word ptr [0xd0b0], ax
8891  31 C0           xor ax, ax
8893  A3 B2 D0        mov word ptr [0xd0b2], ax
8896  31 C0           xor ax, ax
8898  A3 B4 D0        mov word ptr [0xd0b4], ax
889B  C6 06 B8 D0 00  mov byte ptr [0xd0b8], 0
88A0  C6 06 B7 D0 00  mov byte ptr [0xd0b7], 0
88A5  C6 06 BB D0 00  mov byte ptr [0xd0bb], 0
88AA  C6 06 BC D0 00  mov byte ptr [0xd0bc], 0
88AF  C7 06 BE D0 64 00 mov word ptr [0xd0be], 0x64
88B5  FF 36 E6 D6     push word ptr [0xd6e6]
88B9  9A 7A 0E 55 1B  call far 1B55:0E7A
88BE  08 C0           or al, al
88C0  75 11           jne 0x88d3
88C2  FF 36 E4 D6     push word ptr [0xd6e4]
88C6  9A 7A 0E 55 1B  call far 1B55:0E7A
88CB  08 C0           or al, al
88CD  75 04           jne 0x88d3
88CF  B0 00           mov al, 0
88D1  EB 02           jmp 0x88d5
loc_88D3:
88D3  B0 01           mov al, 1
loc_88D5:
88D5  A2 CB D1        mov byte ptr [0xd1cb], al
88D8  C9              leave
88D9  C3              ret

; ---- routine 0AB9:88DA  (found by: call)
sub_88DA:
88DA  55              push bp
88DB  89 E5           mov bp, sp
88DD  8B 3E E6 D6     mov di, word ptr [0xd6e6]
88E1  8B F7           mov si, di
88E3  D1 E7           shl di, 1
88E5  01 F7           add di, si
88E7  8A 85 93 DA     mov al, byte ptr [di - 0x256d]
88EB  A2 C9 D0        mov byte ptr [0xd0c9], al
88EE  8B 3E E6 D6     mov di, word ptr [0xd6e6]
88F2  8B F7           mov si, di
88F4  D1 E7           shl di, 1
88F6  01 F7           add di, si
88F8  8A 85 95 DA     mov al, byte ptr [di - 0x256b]
88FC  A2 CB D0        mov byte ptr [0xd0cb], al
88FF  8B 3E E4 D6     mov di, word ptr [0xd6e4]
8903  8B F7           mov si, di
8905  D1 E7           shl di, 1
8907  01 F7           add di, si
8909  8A 85 93 DA     mov al, byte ptr [di - 0x256d]
890D  A2 C8 D0        mov byte ptr [0xd0c8], al
8910  8B 3E E4 D6     mov di, word ptr [0xd6e4]
8914  8B F7           mov si, di
8916  D1 E7           shl di, 1
8918  01 F7           add di, si
891A  8A 85 95 DA     mov al, byte ptr [di - 0x256b]
891E  A2 CA D0        mov byte ptr [0xd0ca], al
8921  A0 C9 D0        mov al, byte ptr [0xd0c9]
8924  3A 06 C8 D0     cmp al, byte ptr [0xd0c8]
8928  75 13           jne 0x893d
892A  8B 3E E4 D6     mov di, word ptr [0xd6e4]
892E  8B F7           mov si, di
8930  D1 E7           shl di, 1
8932  01 F7           add di, si
8934  8A 85 94 DA     mov al, byte ptr [di - 0x256c]
8938  A2 C8 D0        mov byte ptr [0xd0c8], al
893B  EB 1A           jmp 0x8957
loc_893D:
893D  A0 C9 D0        mov al, byte ptr [0xd0c9]
8940  3A 06 CA D0     cmp al, byte ptr [0xd0ca]
8944  75 11           jne 0x8957
8946  8B 3E E4 D6     mov di, word ptr [0xd6e4]
894A  8B F7           mov si, di
894C  D1 E7           shl di, 1
894E  01 F7           add di, si
8950  8A 85 94 DA     mov al, byte ptr [di - 0x256c]
8954  A2 CA D0        mov byte ptr [0xd0ca], al
loc_8957:
8957  A0 C8 D0        mov al, byte ptr [0xd0c8]
895A  3A 06 CB D0     cmp al, byte ptr [0xd0cb]
895E  75 11           jne 0x8971
8960  8B 3E E6 D6     mov di, word ptr [0xd6e6]
8964  8B F7           mov si, di
8966  D1 E7           shl di, 1
8968  01 F7           add di, si
896A  8A 85 94 DA     mov al, byte ptr [di - 0x256c]
896E  A2 CB D0        mov byte ptr [0xd0cb], al
loc_8971:
8971  C9              leave
8972  C3              ret

; ---- routine 0AB9:8973  (found by: call)
sub_8973:
8973  C8 0A 00 00     enter 0xa, 0
8977  8B 46 04        mov ax, word ptr [bp + 4]
897A  C1 E0 03        shl ax, 3
897D  C4 3E BA D7     les di, ptr [0xd7ba]
8981  03 F8           add di, ax
8983  26 8A 05        mov al, byte ptr es:[di]
8986  30 E4           xor ah, ah
8988  6B C0 3E        imul ax, ax, 0x3e
898B  C4 3E C2 D7     les di, ptr [0xd7c2]
898F  03 F8           add di, ax
8991  81 C7 C2 FF     add di, 0xffc2
8995  89 7E F6        mov word ptr [bp - 0xa], di
8998  8C 46 F8        mov word ptr [bp - 8], es
899B  31 C0           xor ax, ax
899D  89 46 FA        mov word ptr [bp - 6], ax
89A0  C7 46 FC 01 00  mov word ptr [bp - 4], 1
89A5  EB 03           jmp 0x89aa
loc_89A7:
89A7  FF 46 FC        inc word ptr [bp - 4]
loc_89AA:
89AA  8B 46 FC        mov ax, word ptr [bp - 4]
89AD  D1 E0           shl ax, 1
89AF  C4 7E F6        les di, ptr [bp - 0xa]
89B2  03 F8           add di, ax
89B4  26 8B 45 FE     mov ax, word ptr es:[di - 2]
89B8  3B 46 04        cmp ax, word ptr [bp + 4]
89BB  75 06           jne 0x89c3
89BD  8B 46 FC        mov ax, word ptr [bp - 4]
89C0  89 46 FA        mov word ptr [bp - 6], ax
loc_89C3:
89C3  83 7E FC 0B     cmp word ptr [bp - 4], 0xb
89C7  75 DE           jne 0x89a7
89C9  83 7E FA 00     cmp word ptr [bp - 6], 0
89CD  74 26           je 0x89f5
89CF  8B 46 04        mov ax, word ptr [bp + 4]
89D2  C1 E0 03        shl ax, 3
89D5  C4 3E BA D7     les di, ptr [0xd7ba]
89D9  03 F8           add di, ax
89DB  26 8A 05        mov al, byte ptr es:[di]
89DE  30 E4           xor ah, ah
89E0  3B 06 E6 D6     cmp ax, word ptr [0xd6e6]
89E4  B0 00           mov al, 0
89E6  75 01           jne 0x89e9
89E8  40              inc ax
loc_89E9:
89E9  98              cwde
89EA  8B F8           mov di, ax
89EC  8A 85 56 0D     mov al, byte ptr [di + 0xd56]
89F0  30 E4           xor ah, ah
89F2  01 46 FA        add word ptr [bp - 6], ax
loc_89F5:
89F5  8B 46 FA        mov ax, word ptr [bp - 6]
89F8  89 46 FE        mov word ptr [bp - 2], ax
89FB  8B 46 FE        mov ax, word ptr [bp - 2]
89FE  C9              leave
89FF  C2 02 00        ret 2
; data (not reached as code), 13 bytes
8A02                  pstr 'Protect zone'

; ---- routine 0AB9:8A0F  (found by: call)
sub_8A0F:
8A0F  55              push bp
8A10  89 E5           mov bp, sp
8A12  80 3E 91 0D 00  cmp byte ptr [0xd91], 0
8A17  74 1B           je 0x8a34
8A19  80 7E 06 00     cmp byte ptr [bp + 6], 0
8A1D  74 15           je 0x8a34
8A1F  BF 02 8A        mov di, 0x8a02
8A22  0E              push cs
8A23  57              push di
8A24  6A 12           push 0x12
8A26  6A 13           push 0x13
8A28  BF 5C DD        mov di, 0xdd5c
8A2B  1E              push ds
8A2C  57              push di
8A2D  9A 9D 03 2A 23  call far 232A:039D
8A32  EB 1B           jmp 0x8a4f
loc_8A34:
8A34  8A 46 06        mov al, byte ptr [bp + 6]
8A37  98              cwde
8A38  6B F8 0B        imul di, ax, 0xb
8A3B  81 C7 5A 0B     add di, 0xb5a
8A3F  1E              push ds
8A40  57              push di
8A41  6A 12           push 0x12
8A43  6A 13           push 0x13
8A45  BF 5C DD        mov di, 0xdd5c
8A48  1E              push ds
8A49  57              push di
8A4A  9A 9D 03 2A 23  call far 232A:039D
loc_8A4F:
8A4F  C9              leave
8A50  C2 04 00        ret 4
; data (not reached as code), 15 bytes
8A53                  pstr 'Protect zone'
8A60                  db 01 50   ; .P

; ---- routine 0AB9:8A62  (found by: call)
sub_8A62:
8A62  C8 08 00 00     enter 8, 0
8A66  8B 7E 04        mov di, word ptr [bp + 4]
8A69  36 6B 45 04 0F  imul ax, word ptr ss:[di + 4], 0xf
8A6E  C4 3E BE D7     les di, ptr [0xd7be]
8A72  03 F8           add di, ax
8A74  89 7E FC        mov word ptr [bp - 4], di
8A77  8C 46 FE        mov word ptr [bp - 2], es
8A7A  8B 7E 04        mov di, word ptr [bp + 4]
8A7D  36 8B 45 04     mov ax, word ptr ss:[di + 4]
8A81  C1 E0 03        shl ax, 3
8A84  C4 3E BA D7     les di, ptr [0xd7ba]
8A88  03 F8           add di, ax
8A8A  26 80 7D 06 02  cmp byte ptr es:[di + 6], 2
8A8F  73 02           jae 0x8a93
8A91  EB 72           jmp 0x8b05
loc_8A93:
8A93  6A 07           push 7
8A95  C4 7E FC        les di, ptr [bp - 4]
8A98  26 8A 45 0B     mov al, byte ptr es:[di + 0xb]
8A9C  30 E4           xor ah, ah
8A9E  50              push ax
8A9F  9A 59 02 BC 24  call far 24BC:0259
8AA4  08 C0           or al, al
8AA6  74 28           je 0x8ad0
8AA8  BF 53 8A        mov di, 0x8a53
8AAB  0E              push cs
8AAC  57              push di
8AAD  6A 12           push 0x12
8AAF  6A 13           push 0x13
8AB1  BF 5C DD        mov di, 0xdd5c
8AB4  1E              push ds
8AB5  57              push di
8AB6  9A 9D 03 2A 23  call far 232A:039D
8ABB  BF 60 8A        mov di, 0x8a60
8ABE  0E              push cs
8ABF  57              push di
8AC0  6A 12           push 0x12
8AC2  6A 23           push 0x23
8AC4  BF 5C DD        mov di, 0xdd5c
8AC7  1E              push ds
8AC8  57              push di
8AC9  9A 9D 03 2A 23  call far 232A:039D
8ACE  EB 35           jmp 0x8b05
loc_8AD0:
8AD0  8B 7E 04        mov di, word ptr [bp + 4]
8AD3  36 8B 45 04     mov ax, word ptr ss:[di + 4]
8AD7  C1 E0 03        shl ax, 3
8ADA  C4 3E BA D7     les di, ptr [0xd7ba]
8ADE  03 F8           add di, ax
8AE0  26 8A 05        mov al, byte ptr es:[di]
8AE3  30 E4           xor ah, ah
8AE5  6B C0 3E        imul ax, ax, 0x3e
8AE8  C4 3E C2 D7     les di, ptr [0xd7c2]
8AEC  03 F8           add di, ax
8AEE  81 C7 C2 FF     add di, 0xffc2
8AF2  6A 08           push 8
8AF4  26 8A 45 39     mov al, byte ptr es:[di + 0x39]
8AF8  30 E4           xor ah, ah
8AFA  50              push ax
8AFB  9A 59 02 BC 24  call far 24BC:0259
8B00  50              push ax
8B01  55              push bp
8B02  E8 0A FF        call 0x8a0f
loc_8B05:
8B05  C9              leave
8B06  C2 02 00        ret 2
; data (not reached as code), 2 bytes
8B09                  db 01 50   ; .P

; ---- routine 0AB9:8B0B  (found by: call)
sub_8B0B:
8B0B  C8 0E 02 00     enter 0x20e, 0
8B0F  6B 46 04 0F     imul ax, word ptr [bp + 4], 0xf
8B13  C4 3E BE D7     les di, ptr [0xd7be]
8B17  03 F8           add di, ax
8B19  89 BE F6 FE     mov word ptr [bp - 0x10a], di
8B1D  8C 86 F8 FE     mov word ptr [bp - 0x108], es
8B21  8B 46 04        mov ax, word ptr [bp + 4]
8B24  C1 E0 03        shl ax, 3
8B27  C4 3E BA D7     les di, ptr [0xd7ba]
8B2B  03 F8           add di, ax
8B2D  26 80 7D 06 00  cmp byte ptr es:[di + 6], 0
8B32  75 35           jne 0x8b69
8B34  BF 08 86        mov di, 0x8608
8B37  1E              push ds
8B38  57              push di
8B39  8D BE FA FE     lea di, [bp - 0x106]
8B3D  16              push ss
8B3E  57              push di
8B3F  68 00 01        push 0x100
8B42  9A C2 01 BC 24  call far 24BC:01C2
8B47  BF 70 0B        mov di, 0xb70
8B4A  1E              push ds
8B4B  57              push di
8B4C  BF 08 86        mov di, 0x8608
8B4F  1E              push ds
8B50  57              push di
8B51  6A 20           push 0x20
8B53  9A C2 01 BC 24  call far 24BC:01C2
8B58  BF 90 0B        mov di, 0xb90
8B5B  1E              push ds
8B5C  57              push di
8B5D  BF 48 86        mov di, 0x8648
8B60  1E              push ds
8B61  57              push di
8B62  6A 20           push 0x20
8B64  9A C2 01 BC 24  call far 24BC:01C2
loc_8B69:
8B69  C7 46 FE 01 00  mov word ptr [bp - 2], 1
8B6E  EB 03           jmp 0x8b73
loc_8B70:
8B70  FF 46 FE        inc word ptr [bp - 2]
loc_8B73:
8B73  8B 46 FE        mov ax, word ptr [bp - 2]
8B76  05 04 00        add ax, 4
8B79  50              push ax
8B7A  C4 BE F6 FE     les di, ptr [bp - 0x10a]
8B7E  26 8A 45 0A     mov al, byte ptr es:[di + 0xa]
8B82  30 E4           xor ah, ah
8B84  50              push ax
8B85  9A 59 02 BC 24  call far 24BC:0259
8B8A  08 C0           or al, al
8B8C  74 52           je 0x8be0
8B8E  FF 76 FE        push word ptr [bp - 2]
8B91  C4 BE F6 FE     les di, ptr [bp - 0x10a]
8B95  26 8A 45 0A     mov al, byte ptr es:[di + 0xa]
8B99  30 E4           xor ah, ah
8B9B  50              push ax
8B9C  9A 59 02 BC 24  call far 24BC:0259
8BA1  98              cwde
8BA2  C1 E0 04        shl ax, 4
8BA5  8B 7E FE        mov di, word ptr [bp - 2]
8BA8  C1 E7 05        shl di, 5
8BAB  03 F8           add di, ax
8BAD  81 C7 E8 85     add di, 0x85e8
8BB1  1E              push ds
8BB2  57              push di
8BB3  8B 46 FE        mov ax, word ptr [bp - 2]
8BB6  05 0D 00        add ax, 0xd
8BB9  50              push ax
8BBA  6A 13           push 0x13
8BBC  BF 5C DD        mov di, 0xdd5c
8BBF  1E              push ds
8BC0  57              push di
8BC1  9A 9D 03 2A 23  call far 232A:039D
8BC6  BF 09 8B        mov di, 0x8b09
8BC9  0E              push cs
8BCA  57              push di
8BCB  8B 46 FE        mov ax, word ptr [bp - 2]
8BCE  05 0D 00        add ax, 0xd
8BD1  50              push ax
8BD2  6A 23           push 0x23
8BD4  BF 5C DD        mov di, 0xdd5c
8BD7  1E              push ds
8BD8  57              push di
8BD9  9A 9D 03 2A 23  call far 232A:039D
8BDE  EB 52           jmp 0x8c32
loc_8BE0:
8BE0  8B 46 04        mov ax, word ptr [bp + 4]
8BE3  C1 E0 03        shl ax, 3
8BE6  C4 3E BA D7     les di, ptr [0xd7ba]
8BEA  03 F8           add di, ax
8BEC  26 8A 05        mov al, byte ptr es:[di]
8BEF  30 E4           xor ah, ah
8BF1  6B C0 3E        imul ax, ax, 0x3e
8BF4  C4 3E C2 D7     les di, ptr [0xd7c2]
8BF8  03 F8           add di, ax
8BFA  81 C7 C2 FF     add di, 0xffc2
8BFE  FF 76 FE        push word ptr [bp - 2]
8C01  26 8A 45 39     mov al, byte ptr es:[di + 0x39]
8C05  30 E4           xor ah, ah
8C07  50              push ax
8C08  9A 59 02 BC 24  call far 24BC:0259
8C0D  98              cwde
8C0E  C1 E0 04        shl ax, 4
8C11  8B 7E FE        mov di, word ptr [bp - 2]
8C14  C1 E7 05        shl di, 5
8C17  03 F8           add di, ax
8C19  81 C7 E8 85     add di, 0x85e8
8C1D  1E              push ds
8C1E  57              push di
8C1F  8B 46 FE        mov ax, word ptr [bp - 2]
8C22  05 0D 00        add ax, 0xd
8C25  50              push ax
8C26  6A 13           push 0x13
8C28  BF 5C DD        mov di, 0xdd5c
8C2B  1E              push ds
8C2C  57              push di
8C2D  9A 9D 03 2A 23  call far 232A:039D
loc_8C32:
8C32  83 7E FE 04     cmp word ptr [bp - 2], 4
8C36  74 03           je 0x8c3b
8C38  E9 35 FF        jmp 0x8b70
loc_8C3B:
8C3B  31 C0           xor ax, ax
8C3D  89 46 FA        mov word ptr [bp - 6], ax
8C40  80 3E 91 0D 00  cmp byte ptr [0xd91], 0
8C45  75 07           jne 0x8c4e
8C47  55              push bp
8C48  E8 17 FE        call 0x8a62
8C4B  E9 DC 00        jmp 0x8d2a
loc_8C4E:
8C4E  FF 76 04        push word ptr [bp + 4]
8C51  E8 1F FD        call 0x8973
8C54  89 46 FA        mov word ptr [bp - 6], ax
8C57  83 7E FA 00     cmp word ptr [bp - 6], 0
8C5B  74 0B           je 0x8c68
8C5D  6B 7E FA 19     imul di, word ptr [bp - 6], 0x19
8C61  83 BD 03 CD 00  cmp word ptr [di - 0x32fd], 0
8C66  75 07           jne 0x8c6f
loc_8C68:
8C68  55              push bp
8C69  E8 F6 FD        call 0x8a62
8C6C  E9 BB 00        jmp 0x8d2a
loc_8C6F:
8C6F  6B 7E FA 19     imul di, word ptr [bp - 6], 0x19
8C73  81 C7 EF CC     add di, 0xccef
8C77  1E              push ds
8C78  07              pop es
8C79  89 BE F2 FE     mov word ptr [bp - 0x10e], di
8C7D  8C 86 F4 FE     mov word ptr [bp - 0x10c], es
8C81  A1 64 DD        mov ax, word ptr [0xdd64]
8C84  89 46 FC        mov word ptr [bp - 4], ax
8C87  26 FF 75 14     push word ptr es:[di + 0x14]
8C8B  26 8B 45 14     mov ax, word ptr es:[di + 0x14]
8C8F  C1 E0 03        shl ax, 3
8C92  C4 3E BA D7     les di, ptr [0xd7ba]
8C96  03 F8           add di, ax
8C98  26 8A 45 06     mov al, byte ptr es:[di + 6]
8C9C  30 E4           xor ah, ah
8C9E  50              push ax
8C9F  9A 4A 72 55 1B  call far 1B55:724A
8CA4  50              push ax
8CA5  8D BE F2 FD     lea di, [bp - 0x20e]
8CA9  16              push ss
8CAA  57              push di
8CAB  C4 BE F2 FE     les di, ptr [bp - 0x10e]
8CAF  26 FF 75 14     push word ptr es:[di + 0x14]
8CB3  9A DC 44 55 1B  call far 1B55:44DC
8CB8  6A 12           push 0x12
8CBA  6A 13           push 0x13
8CBC  BF 5C DD        mov di, 0xdd5c
8CBF  1E              push ds
8CC0  57              push di
8CC1  9A 1B 04 2A 23  call far 232A:041B
8CC6  8D BE F2 FD     lea di, [bp - 0x20e]
8CCA  16              push ss
8CCB  57              push di
8CCC  C4 BE F2 FE     les di, ptr [bp - 0x10e]
8CD0  26 8B 45 14     mov ax, word ptr es:[di + 0x14]
8CD4  C1 E0 03        shl ax, 3
8CD7  C4 3E BA D7     les di, ptr [0xd7ba]
8CDB  03 F8           add di, ax
8CDD  26 8A 45 06     mov al, byte ptr es:[di + 6]
8CE1  30 E4           xor ah, ah
8CE3  8B F8           mov di, ax
8CE5  8A 85 16 87     mov al, byte ptr [di - 0x78ea]
8CE9  50              push ax
8CEA  9A 6F 0C C9 26  call far 26C9:0C6F
8CEF  6A 12           push 0x12
8CF1  6A 21           push 0x21
8CF3  BF 5C DD        mov di, 0xdd5c
8CF6  1E              push ds
8CF7  57              push di
8CF8  9A 9D 03 2A 23  call far 232A:039D
8CFD  6A 07           push 7
8CFF  C4 BE F6 FE     les di, ptr [bp - 0x10a]
8D03  26 8A 45 0B     mov al, byte ptr es:[di + 0xb]
8D07  30 E4           xor ah, ah
8D09  50              push ax
8D0A  9A 59 02 BC 24  call far 24BC:0259
8D0F  08 C0           or al, al
8D11  74 17           je 0x8d2a
8D13  8A 46 FC        mov al, byte ptr [bp - 4]
8D16  50              push ax
8D17  BF 09 8B        mov di, 0x8b09
8D1A  0E              push cs
8D1B  57              push di
8D1C  6A 12           push 0x12
8D1E  6A 23           push 0x23
8D20  BF 5C DD        mov di, 0xdd5c
8D23  1E              push ds
8D24  57              push di
8D25  9A 1B 04 2A 23  call far 232A:041B
loc_8D2A:
8D2A  8B 46 04        mov ax, word ptr [bp + 4]
8D2D  C1 E0 03        shl ax, 3
8D30  C4 3E BA D7     les di, ptr [0xd7ba]
8D34  03 F8           add di, ax
8D36  26 80 7D 06 00  cmp byte ptr es:[di + 6], 0
8D3B  75 13           jne 0x8d50
8D3D  8D BE FA FE     lea di, [bp - 0x106]
8D41  16              push ss
8D42  57              push di
8D43  BF 08 86        mov di, 0x8608
8D46  1E              push ds
8D47  57              push di
8D48  68 00 01        push 0x100
8D4B  9A C2 01 BC 24  call far 24BC:01C2
loc_8D50:
8D50  C9              leave
8D51  C2 02 00        ret 2
; data (not reached as code), 27 bytes
8D54                  pstr '(Retiring this year)'
8D69                  db 01 28 01 29 01 FB   ; .(.)..

; ---- routine 0AB9:8D6F  (found by: call)
sub_8D6F:
8D6F  C8 0C 02 00     enter 0x20c, 0
8D73  BF 34 67        mov di, 0x6734
8D76  1E              push ds
8D77  57              push di
8D78  BF 5C DD        mov di, 0xdd5c
8D7B  1E              push ds
8D7C  57              push di
8D7D  9A 2F 05 2A 23  call far 232A:052F
8D82  83 7E 04 00     cmp word ptr [bp + 4], 0
8D86  75 09           jne 0x8d91
8D88  B0 01           mov al, 1
8D8A  08 C0           or al, al
8D8C  74 03           je 0x8d91
8D8E  E9 1E 08        jmp 0x95af
loc_8D91:
8D91  8B 46 04        mov ax, word ptr [bp + 4]
8D94  C1 E0 03        shl ax, 3
8D97  C4 3E BA D7     les di, ptr [0xd7ba]
8D9B  03 F8           add di, ax
8D9D  89 7E F8        mov word ptr [bp - 8], di
8DA0  8C 46 FA        mov word ptr [bp - 6], es
8DA3  6B 46 04 0F     imul ax, word ptr [bp + 4], 0xf
8DA7  C4 3E BE D7     les di, ptr [0xd7be]
8DAB  03 F8           add di, ax
8DAD  89 7E F4        mov word ptr [bp - 0xc], di
8DB0  8C 46 F6        mov word ptr [bp - 0xa], es
8DB3  FF 76 04        push word ptr [bp + 4]
8DB6  C4 7E F8        les di, ptr [bp - 8]
8DB9  26 8A 45 06     mov al, byte ptr es:[di + 6]
8DBD  30 E4           xor ah, ah
8DBF  50              push ax
8DC0  9A 4A 72 55 1B  call far 1B55:724A
8DC5  50              push ax
8DC6  8D BE F4 FE     lea di, [bp - 0x10c]
8DCA  16              push ss
8DCB  57              push di
8DCC  8B 46 04        mov ax, word ptr [bp + 4]
8DCF  C4 3E AA D7     les di, ptr [0xd7aa]
8DD3  03 F8           add di, ax
8DD5  26 8A 05        mov al, byte ptr es:[di]
8DD8  50              push ax
8DD9  9A 6F 0C C9 26  call far 26C9:0C6F
8DDE  6A 02           push 2
8DE0  6A 03           push 3
8DE2  BF 5C DD        mov di, 0xdd5c
8DE5  1E              push ds
8DE6  57              push di
8DE7  9A 1B 04 2A 23  call far 232A:041B
8DEC  8D BE F4 FE     lea di, [bp - 0x10c]
8DF0  16              push ss
8DF1  57              push di
8DF2  FF 76 04        push word ptr [bp + 4]
8DF5  9A DC 44 55 1B  call far 1B55:44DC
8DFA  6A 02           push 2
8DFC  6A 05           push 5
8DFE  BF 5C DD        mov di, 0xdd5c
8E01  1E              push ds
8E02  57              push di
8E03  9A 9D 03 2A 23  call far 232A:039D
8E08  C4 7E F8        les di, ptr [bp - 8]
8E0B  26 8A 45 06     mov al, byte ptr es:[di + 6]
8E0F  30 E4           xor ah, ah
8E11  6B F8 13        imul di, ax, 0x13
8E14  81 C7 24 87     add di, 0x8724
8E18  1E              push ds
8E19  57              push di
8E1A  6A 03           push 3
8E1C  6A 08           push 8
8E1E  BF 5C DD        mov di, 0xdd5c
8E21  1E              push ds
8E22  57              push di
8E23  9A 9D 03 2A 23  call far 232A:039D
8E28  8B 46 04        mov ax, word ptr [bp + 4]
8E2B  C4 3E AE D7     les di, ptr [0xd7ae]
8E2F  03 F8           add di, ax
8E31  26 8A 05        mov al, byte ptr es:[di]
8E34  30 E4           xor ah, ah
8E36  8B F8           mov di, ax
8E38  C1 E7 04        shl di, 4
8E3B  81 C7 2C 9A     add di, 0x9a2c
8E3F  1E              push ds
8E40  57              push di
8E41  6A 04           push 4
8E43  6A 0B           push 0xb
8E45  BF 5C DD        mov di, 0xdd5c
8E48  1E              push ds
8E49  57              push di
8E4A  9A 9D 03 2A 23  call far 232A:039D
8E4F  B0 00           mov al, 0
8E51  08 C0           or al, al
8E53  74 0C           je 0x8e61
8E55  C4 7E F8        les di, ptr [bp - 8]
8E58  26 80 3D 00     cmp byte ptr es:[di], 0
8E5C  75 03           jne 0x8e61
8E5E  E9 4E 07        jmp 0x95af
loc_8E61:
8E61  8D BE F4 FE     lea di, [bp - 0x10c]
8E65  16              push ss
8E66  57              push di
8E67  C4 7E F8        les di, ptr [bp - 8]
8E6A  26 8A 45 01     mov al, byte ptr es:[di + 1]
8E6E  30 E4           xor ah, ah
8E70  31 D2           xor dx, dx
8E72  52              push dx
8E73  50              push ax
8E74  9A C9 07 2A 23  call far 232A:07C9
8E79  6A 02           push 2
8E7B  6A 17           push 0x17
8E7D  BF 5C DD        mov di, 0xdd5c
8E80  1E              push ds
8E81  57              push di
8E82  9A 9D 03 2A 23  call far 232A:039D
8E87  8D BE F4 FE     lea di, [bp - 0x10c]
8E8B  16              push ss
8E8C  57              push di
8E8D  C4 7E F4        les di, ptr [bp - 0xc]
8E90  26 8A 45 09     mov al, byte ptr es:[di + 9]
8E94  30 E4           xor ah, ah
8E96  50              push ax
8E97  9A 3C 48 55 1B  call far 1B55:483C
8E9C  52              push dx
8E9D  50              push ax
8E9E  9A C9 07 2A 23  call far 232A:07C9
8EA3  6A 04           push 4
8EA5  6A 2F           push 0x2f
8EA7  BF 5C DD        mov di, 0xdd5c
8EAA  1E              push ds
8EAB  57              push di
8EAC  9A 9D 03 2A 23  call far 232A:039D
8EB1  8D BE F4 FE     lea di, [bp - 0x10c]
8EB5  16              push ss
8EB6  57              push di
8EB7  FF 76 04        push word ptr [bp + 4]
8EBA  9A C2 4D 55 1B  call far 1B55:4DC2
8EBF  31 D2           xor dx, dx
8EC1  B9 0C 00        mov cx, 0xc
8EC4  F7 F1           div cx
8EC6  31 D2           xor dx, dx
8EC8  52              push dx
8EC9  50              push ax
8ECA  9A C9 07 2A 23  call far 232A:07C9
8ECF  6A 04           push 4
8ED1  6A 22           push 0x22
8ED3  BF 5C DD        mov di, 0xdd5c
8ED6  1E              push ds
8ED7  57              push di
8ED8  9A 9D 03 2A 23  call far 232A:039D
8EDD  8D BE F4 FE     lea di, [bp - 0x10c]
8EE1  16              push ss
8EE2  57              push di
8EE3  FF 76 04        push word ptr [bp + 4]
8EE6  9A C2 4D 55 1B  call far 1B55:4DC2
8EEB  31 D2           xor dx, dx
8EED  B9 0C 00        mov cx, 0xc
8EF0  F7 F1           div cx
8EF2  92              xchg dx, ax
8EF3  31 D2           xor dx, dx
8EF5  52              push dx
8EF6  50              push ax
8EF7  9A C9 07 2A 23  call far 232A:07C9
8EFC  6A 04           push 4
8EFE  6A 25           push 0x25
8F00  BF 5C DD        mov di, 0xdd5c
8F03  1E              push ds
8F04  57              push di
8F05  9A 83 02 2A 23  call far 232A:0283
8F0A  C4 7E F8        les di, ptr [bp - 8]
8F0D  26 8A 45 02     mov al, byte ptr es:[di + 2]
8F11  30 E4           xor ah, ah
8F13  05 05 00        add ax, 5
8F16  8B D0           mov dx, ax
8F18  26 8A 45 01     mov al, byte ptr es:[di + 1]
8F1C  30 E4           xor ah, ah
8F1E  3B C2           cmp ax, dx
8F20  7C 13           jl 0x8f35
8F22  BF 54 8D        mov di, 0x8d54
8F25  0E              push cs
8F26  57              push di
8F27  6A 0B           push 0xb
8F29  6A 20           push 0x20
8F2B  BF 5C DD        mov di, 0xdd5c
8F2E  1E              push ds
8F2F  57              push di
8F30  9A 9D 03 2A 23  call far 232A:039D
loc_8F35:
8F35  C4 7E F4        les di, ptr [bp - 0xc]
8F38  26 8A 45 06     mov al, byte ptr es:[di + 6]
8F3C  98              cwde
8F3D  99              cdq
8F3E  52              push dx
8F3F  50              push ax
8F40  6A 00           push 0
8F42  6A 20           push 0x20
8F44  9A FA 04 BC 24  call far 24BC:04FA
8F49  8B F8           mov di, ax
8F4B  8A 85 5B 93     mov al, byte ptr [di - 0x6ca5]
8F4F  30 E4           xor ah, ah
8F51  8B F8           mov di, ax
8F53  C1 E7 04        shl di, 4
8F56  81 C7 0C 8A     add di, 0x8a0c
8F5A  1E              push ds
8F5B  57              push di
8F5C  6A 06           push 6
8F5E  6A 0E           push 0xe
8F60  BF 5C DD        mov di, 0xdd5c
8F63  1E              push ds
8F64  57              push di
8F65  9A 9D 03 2A 23  call far 232A:039D
8F6A  C4 7E F4        les di, ptr [bp - 0xc]
8F6D  26 80 7D 08 00  cmp byte ptr es:[di + 8], 0
8F72  75 28           jne 0x8f9c
8F74  26 8A 45 08     mov al, byte ptr es:[di + 8]
8F78  98              cwde
8F79  8B F8           mov di, ax
8F7B  8A 85 A0 93     mov al, byte ptr [di - 0x6c60]
8F7F  30 E4           xor ah, ah
8F81  8B F8           mov di, ax
8F83  C1 E7 04        shl di, 4
8F86  81 C7 0C 8A     add di, 0x8a0c
8F8A  1E              push ds
8F8B  57              push di
8F8C  6A 07           push 7
8F8E  6A 0E           push 0xe
8F90  BF 5C DD        mov di, 0xdd5c
8F93  1E              push ds
8F94  57              push di
8F95  9A 9D 03 2A 23  call far 232A:039D
8F9A  EB 29           jmp 0x8fc5
loc_8F9C:
8F9C  C4 7E F4        les di, ptr [bp - 0xc]
8F9F  26 8A 45 07     mov al, byte ptr es:[di + 7]
8FA3  98              cwde
8FA4  8B F8           mov di, ax
8FA6  8A 85 A0 93     mov al, byte ptr [di - 0x6c60]
8FAA  30 E4           xor ah, ah
8FAC  8B F8           mov di, ax
8FAE  C1 E7 04        shl di, 4
8FB1  81 C7 0C 8A     add di, 0x8a0c
8FB5  1E              push ds
8FB6  57              push di
8FB7  6A 07           push 7
8FB9  6A 0E           push 0xe
8FBB  BF 5C DD        mov di, 0xdd5c
8FBE  1E              push ds
8FBF  57              push di
8FC0  9A 9D 03 2A 23  call far 232A:039D
loc_8FC5:
8FC5  C4 7E F4        les di, ptr [bp - 0xc]
8FC8  26 8A 45 08     mov al, byte ptr es:[di + 8]
8FCC  98              cwde
8FCD  8B F8           mov di, ax
8FCF  8A 85 C2 93     mov al, byte ptr [di - 0x6c3e]
8FD3  30 E4           xor ah, ah
8FD5  8B F8           mov di, ax
8FD7  C1 E7 04        shl di, 4
8FDA  81 C7 0C 8A     add di, 0x8a0c
8FDE  1E              push ds
8FDF  57              push di
8FE0  6A 08           push 8
8FE2  6A 0E           push 0xe
8FE4  BF 5C DD        mov di, 0xdd5c
8FE7  1E              push ds
8FE8  57              push di
8FE9  9A 9D 03 2A 23  call far 232A:039D
8FEE  FF 76 04        push word ptr [bp + 4]
8FF1  9A 0C 4E 55 1B  call far 1B55:4E0C
8FF6  30 E4           xor ah, ah
8FF8  8B F8           mov di, ax
8FFA  8A 85 7C 93     mov al, byte ptr [di - 0x6c84]
8FFE  30 E4           xor ah, ah
9000  8B F8           mov di, ax
9002  C1 E7 04        shl di, 4
9005  81 C7 0C 8A     add di, 0x8a0c
9009  1E              push ds
900A  57              push di
900B  6A 09           push 9
900D  6A 0E           push 0xe
900F  BF 5C DD        mov di, 0xdd5c
9012  1E              push ds
9013  57              push di
9014  9A 9D 03 2A 23  call far 232A:039D
9019  C4 7E F4        les di, ptr [bp - 0xc]
901C  26 80 7D 06 20  cmp byte ptr es:[di + 6], 0x20
9021  7D 21           jge 0x9044
9023  C4 3E 5C DD     les di, ptr [0xdd5c]
9027  81 C7 3A 03     add di, 0x33a
902B  06              push es
902C  57              push di
902D  6A 70           push 0x70
902F  C4 7E F4        les di, ptr [bp - 0xc]
9032  26 8A 45 06     mov al, byte ptr es:[di + 6]
9036  98              cwde
9037  40              inc ax
9038  99              cdq
9039  B9 02 00        mov cx, 2
903C  F7 F9           idiv cx
903E  50              push ax
903F  9A 4B 03 BC 24  call far 24BC:034B
loc_9044:
9044  C4 7E F4        les di, ptr [bp - 0xc]
9047  26 80 7D 08 00  cmp byte ptr es:[di + 8], 0
904C  75 28           jne 0x9076
904E  C4 3E 5C DD     les di, ptr [0xdd5c]
9052  81 C7 DA 03     add di, 0x3da
9056  06              push es
9057  57              push di
9058  6A 40           push 0x40
905A  C4 7E F4        les di, ptr [bp - 0xc]
905D  26 8A 45 0E     mov al, byte ptr es:[di + 0xe]
9061  98              cwde
9062  99              cdq
9063  52              push dx
9064  50              push ax
9065  6A 00           push 0
9067  6A 10           push 0x10
9069  9A FA 04 BC 24  call far 24BC:04FA
906E  50              push ax
906F  9A 4B 03 BC 24  call far 24BC:034B
9074  EB 21           jmp 0x9097
loc_9076:
9076  C4 3E 5C DD     les di, ptr [0xdd5c]
907A  81 C7 DA 03     add di, 0x3da
907E  06              push es
907F  57              push di
9080  6A 70           push 0x70
9082  C4 7E F4        les di, ptr [bp - 0xc]
9085  26 8A 45 07     mov al, byte ptr es:[di + 7]
9089  98              cwde
908A  40              inc ax
908B  99              cdq
908C  B9 02 00        mov cx, 2
908F  F7 F9           idiv cx
9091  50              push ax
9092  9A 4B 03 BC 24  call far 24BC:034B
loc_9097:
9097  C4 3E 5C DD     les di, ptr [0xdd5c]
909B  81 C7 7A 04     add di, 0x47a
909F  06              push es
90A0  57              push di
90A1  6A 70           push 0x70
90A3  C4 7E F4        les di, ptr [bp - 0xc]
90A6  26 8A 45 08     mov al, byte ptr es:[di + 8]
90AA  98              cwde
90AB  40              inc ax
90AC  99              cdq
90AD  B9 02 00        mov cx, 2
90B0  F7 F9           idiv cx
90B2  50              push ax
90B3  9A 4B 03 BC 24  call far 24BC:034B
90B8  C4 3E 5C DD     les di, ptr [0xdd5c]
90BC  81 C7 1A 05     add di, 0x51a
90C0  06              push es
90C1  57              push di
90C2  6A 70           push 0x70
90C4  FF 76 04        push word ptr [bp + 4]
90C7  9A 0C 4E 55 1B  call far 1B55:4E0C
90CC  30 E4           xor ah, ah
90CE  50              push ax
90CF  9A 4B 03 BC 24  call far 24BC:034B
90D4  C4 7E F4        les di, ptr [bp - 0xc]
90D7  26 8A 45 0D     mov al, byte ptr es:[di + 0xd]
90DB  30 E4           xor ah, ah
90DD  6B F8 0B        imul di, ax, 0xb
90E0  81 C7 BC 0B     add di, 0xbbc
90E4  1E              push ds
90E5  57              push di
90E6  6A 0B           push 0xb
90E8  6A 13           push 0x13
90EA  BF 5C DD        mov di, 0xdd5c
90ED  1E              push ds
90EE  57              push di
90EF  9A 9D 03 2A 23  call far 232A:039D
90F4  8D BE F4 FE     lea di, [bp - 0x10c]
90F8  16              push ss
90F9  57              push di
90FA  C4 7E F4        les di, ptr [bp - 0xc]
90FD  26 8A 45 0C     mov al, byte ptr es:[di + 0xc]
9101  30 E4           xor ah, ah
9103  31 D2           xor dx, dx
9105  52              push dx
9106  50              push ax
9107  9A C9 07 2A 23  call far 232A:07C9
910C  6A 0C           push 0xc
910E  6A 13           push 0x13
9110  BF 5C DD        mov di, 0xdd5c
9113  1E              push ds
9114  57              push di
9115  9A 9D 03 2A 23  call far 232A:039D
911A  8D BE F4 FE     lea di, [bp - 0x10c]
911E  16              push ss
911F  57              push di
9120  C4 7E F4        les di, ptr [bp - 0xc]
9123  26 8A 45 04     mov al, byte ptr es:[di + 4]
9127  30 E4           xor ah, ah
9129  31 D2           xor dx, dx
912B  52              push dx
912C  50              push ax
912D  9A C9 07 2A 23  call far 232A:07C9
9132  6A 14           push 0x14
9134  6A 13           push 0x13
9136  BF 5C DD        mov di, 0xdd5c
9139  1E              push ds
913A  57              push di
913B  9A 83 02 2A 23  call far 232A:0283
9140  8D BE F4 FE     lea di, [bp - 0x10c]
9144  16              push ss
9145  57              push di
9146  C4 7E F4        les di, ptr [bp - 0xc]
9149  26 8B 05        mov ax, word ptr es:[di]
914C  31 D2           xor dx, dx
914E  52              push dx
914F  50              push ax
9150  9A C9 07 2A 23  call far 232A:07C9
9155  6A 15           push 0x15
9157  6A 13           push 0x13
9159  BF 5C DD        mov di, 0xdd5c
915C  1E              push ds
915D  57              push di
915E  9A 83 02 2A 23  call far 232A:0283
9163  C4 7E F8        les di, ptr [bp - 8]
9166  26 80 7D 07 00  cmp byte ptr es:[di + 7], 0
916B  74 03           je 0x9170
916D  E9 8A 00        jmp 0x91fa
loc_9170:
9170  8D BE F4 FD     lea di, [bp - 0x20c]
9174  16              push ss
9175  57              push di
9176  BF 69 8D        mov di, 0x8d69
9179  0E              push cs
917A  57              push di
917B  9A 53 0B C9 26  call far 26C9:0B53
9180  8D BE F4 FE     lea di, [bp - 0x10c]
9184  16              push ss
9185  57              push di
9186  C4 7E F4        les di, ptr [bp - 0xc]
9189  26 8A 45 05     mov al, byte ptr es:[di + 5]
918D  30 E4           xor ah, ah
918F  31 D2           xor dx, dx
9191  52              push dx
9192  50              push ax
9193  9A C9 07 2A 23  call far 232A:07C9
9198  9A D2 0B C9 26  call far 26C9:0BD2
919D  BF 6B 8D        mov di, 0x8d6b
91A0  0E              push cs
91A1  57              push di
91A2  9A D2 0B C9 26  call far 26C9:0BD2
91A7  6A 14           push 0x14
91A9  6A 1B           push 0x1b
91AB  BF 5C DD        mov di, 0xdd5c
91AE  1E              push ds
91AF  57              push di
91B0  9A 83 02 2A 23  call far 232A:0283
91B5  8D BE F4 FD     lea di, [bp - 0x20c]
91B9  16              push ss
91BA  57              push di
91BB  BF 69 8D        mov di, 0x8d69
91BE  0E              push cs
91BF  57              push di
91C0  9A 53 0B C9 26  call far 26C9:0B53
91C5  8D BE F4 FE     lea di, [bp - 0x10c]
91C9  16              push ss
91CA  57              push di
91CB  C4 7E F4        les di, ptr [bp - 0xc]
91CE  26 8B 45 02     mov ax, word ptr es:[di + 2]
91D2  31 D2           xor dx, dx
91D4  52              push dx
91D5  50              push ax
91D6  9A C9 07 2A 23  call far 232A:07C9
91DB  9A D2 0B C9 26  call far 26C9:0BD2
91E0  BF 6B 8D        mov di, 0x8d6b
91E3  0E              push cs
91E4  57              push di
91E5  9A D2 0B C9 26  call far 26C9:0BD2
91EA  6A 15           push 0x15
91EC  6A 1B           push 0x1b
91EE  BF 5C DD        mov di, 0xdd5c
91F1  1E              push ds
91F2  57              push di
91F3  9A 83 02 2A 23  call far 232A:0283
91F8  EB 4A           jmp 0x9244
loc_91FA:
91FA  8D BE F4 FE     lea di, [bp - 0x10c]
91FE  16              push ss
91FF  57              push di
9200  C4 7E F4        les di, ptr [bp - 0xc]
9203  26 8A 45 05     mov al, byte ptr es:[di + 5]
9207  30 E4           xor ah, ah
9209  31 D2           xor dx, dx
920B  52              push dx
920C  50              push ax
920D  9A C9 07 2A 23  call far 232A:07C9
9212  6A 14           push 0x14
9214  6A 1B           push 0x1b
9216  BF 5C DD        mov di, 0xdd5c
9219  1E              push ds
921A  57              push di
921B  9A 83 02 2A 23  call far 232A:0283
9220  8D BE F4 FE     lea di, [bp - 0x10c]
9224  16              push ss
9225  57              push di
9226  C4 7E F4        les di, ptr [bp - 0xc]
9229  26 8B 45 02     mov ax, word ptr es:[di + 2]
922D  31 D2           xor dx, dx
922F  52              push dx
9230  50              push ax
9231  9A C9 07 2A 23  call far 232A:07C9
9236  6A 15           push 0x15
9238  6A 1B           push 0x1b
923A  BF 5C DD        mov di, 0xdd5c
923D  1E              push ds
923E  57              push di
923F  9A 83 02 2A 23  call far 232A:0283
loc_9244:
9244  C4 7E F8        les di, ptr [bp - 8]
9247  26 8A 45 07     mov al, byte ptr es:[di + 7]
924B  30 E4           xor ah, ah
924D  50              push ax
924E  C4 7E F4        les di, ptr [bp - 0xc]
9251  26 8A 45 05     mov al, byte ptr es:[di + 5]
9255  30 E4           xor ah, ah
9257  50              push ax
9258  26 8A 45 04     mov al, byte ptr es:[di + 4]
925C  30 E4           xor ah, ah
925E  50              push ax
925F  6A 14           push 0x14
9261  6A 22           push 0x22
9263  9A 9E 0B 98 19  call far 1998:0B9E
9268  C4 7E F8        les di, ptr [bp - 8]
926B  26 8A 45 07     mov al, byte ptr es:[di + 7]
926F  30 E4           xor ah, ah
9271  50              push ax
9272  C4 7E F4        les di, ptr [bp - 0xc]
9275  26 FF 75 02     push word ptr es:[di + 2]
9279  26 FF 35        push word ptr es:[di]
927C  6A 15           push 0x15
927E  6A 22           push 0x22
9280  9A 9E 0B 98 19  call far 1998:0B9E
9285  FF 76 04        push word ptr [bp + 4]
9288  6A 17           push 0x17
928A  6A 0A           push 0xa
928C  9A 4A 4C 55 1B  call far 1B55:4C4A
9291  FF 76 04        push word ptr [bp + 4]
9294  9A 81 4E 55 1B  call far 1B55:4E81
9299  98              cwde
929A  8B F8           mov di, ax
929C  D1 E7           shl di, 1
929E  8B F7           mov si, di
92A0  D1 E7           shl di, 1
92A2  01 F7           add di, si
92A4  81 C7 B0 0B     add di, 0xbb0
92A8  1E              push ds
92A9  57              push di
92AA  6A 06           push 6
92AC  6A 2A           push 0x2a
92AE  BF 5C DD        mov di, 0xdd5c
92B1  1E              push ds
92B2  57              push di
92B3  9A 83 02 2A 23  call far 232A:0283
92B8  FF 76 04        push word ptr [bp + 4]
92BB  9A BF 4E 55 1B  call far 1B55:4EBF
92C0  8B F8           mov di, ax
92C2  8A 85 E4 93     mov al, byte ptr [di - 0x6c1c]
92C6  30 E4           xor ah, ah
92C8  8B F8           mov di, ax
92CA  C1 E7 04        shl di, 4
92CD  81 C7 0C 8A     add di, 0x8a0c
92D1  1E              push ds
92D2  57              push di
92D3  6A 07           push 7
92D5  6A 2A           push 0x2a
92D7  BF 5C DD        mov di, 0xdd5c
92DA  1E              push ds
92DB  57              push di
92DC  9A 9D 03 2A 23  call far 232A:039D
92E1  C4 3E 5C DD     les di, ptr [0xdd5c]
92E5  81 C7 12 04     add di, 0x412
92E9  06              push es
92EA  57              push di
92EB  6A 70           push 0x70
92ED  FF 76 04        push word ptr [bp + 4]
92F0  9A BF 4E 55 1B  call far 1B55:4EBF
92F5  6B C0 0A        imul ax, ax, 0xa
92F8  C1 E8 03        shr ax, 3
92FB  50              push ax
92FC  9A 4B 03 BC 24  call far 24BC:034B
9301  FF 76 04        push word ptr [bp + 4]
9304  E8 04 F8        call 0x8b0b
9307  C4 7E F8        les di, ptr [bp - 8]
930A  26 8A 05        mov al, byte ptr es:[di]
930D  30 E4           xor ah, ah
930F  50              push ax
9310  6A 02           push 2
9312  6A 20           push 0x20
9314  9A E3 0E 55 1B  call far 1B55:0EE3
9319  C4 7E F8        les di, ptr [bp - 8]
931C  26 80 7D 01 11  cmp byte ptr es:[di + 1], 0x11
9321  76 66           jbe 0x9389
9323  FF 76 04        push word ptr [bp + 4]
9326  26 8A 45 07     mov al, byte ptr es:[di + 7]
932A  30 E4           xor ah, ah
932C  50              push ax
932D  9A 4A 72 55 1B  call far 1B55:724A
9332  50              push ax
9333  C4 7E F8        les di, ptr [bp - 8]
9336  26 8A 45 07     mov al, byte ptr es:[di + 7]
933A  30 E4           xor ah, ah
933C  6B F8 13        imul di, ax, 0x13
933F  81 C7 24 87     add di, 0x8724
9343  1E              push ds
9344  57              push di
9345  6A 03           push 3
9347  6A 23           push 0x23
9349  BF 5C DD        mov di, 0xdd5c
934C  1E              push ds
934D  57              push di
934E  9A 1B 04 2A 23  call far 232A:041B
9353  FF 76 04        push word ptr [bp + 4]
9356  C4 7E F8        les di, ptr [bp - 8]
9359  26 8A 45 06     mov al, byte ptr es:[di + 6]
935D  30 E4           xor ah, ah
935F  50              push ax
9360  9A 4A 72 55 1B  call far 1B55:724A
9365  50              push ax
9366  8D BE F4 FE     lea di, [bp - 0x10c]
936A  16              push ss
936B  57              push di
936C  FF 76 04        push word ptr [bp + 4]
936F  9A 5D 48 55 1B  call far 1B55:485D
9374  52              push dx
9375  50              push ax
9376  9A 95 0F 55 1B  call far 1B55:0F95
937B  6A 0C           push 0xc
937D  6A 26           push 0x26
937F  BF 5C DD        mov di, 0xdd5c
9382  1E              push ds
9383  57              push di
9384  9A 1B 04 2A 23  call far 232A:041B
loc_9389:
9389  C7 06 64 DD 0E 00 mov word ptr [0xdd64], 0xe
938F  6A 04           push 4
9391  C4 7E F4        les di, ptr [bp - 0xc]
9394  26 8A 45 0B     mov al, byte ptr es:[di + 0xb]
9398  30 E4           xor ah, ah
939A  50              push ax
939B  9A 59 02 BC 24  call far 24BC:0259
93A0  08 C0           or al, al
93A2  74 13           je 0x93b7
93A4  BF 6D 8D        mov di, 0x8d6d
93A7  0E              push cs
93A8  57              push di
93A9  6A 0E           push 0xe
93AB  6A 35           push 0x35
93AD  BF 5C DD        mov di, 0xdd5c
93B0  1E              push ds
93B1  57              push di
93B2  9A 9D 03 2A 23  call far 232A:039D
loc_93B7:
93B7  6A 08           push 8
93B9  C4 7E F4        les di, ptr [bp - 0xc]
93BC  26 8A 45 0B     mov al, byte ptr es:[di + 0xb]
93C0  30 E4           xor ah, ah
93C2  50              push ax
93C3  9A 59 02 BC 24  call far 24BC:0259
93C8  08 C0           or al, al
93CA  74 13           je 0x93df
93CC  BF 6D 8D        mov di, 0x8d6d
93CF  0E              push cs
93D0  57              push di
93D1  6A 0F           push 0xf
93D3  6A 35           push 0x35
93D5  BF 5C DD        mov di, 0xdd5c
93D8  1E              push ds
93D9  57              push di
93DA  9A 9D 03 2A 23  call far 232A:039D
loc_93DF:
93DF  6A 02           push 2
93E1  C4 7E F4        les di, ptr [bp - 0xc]
93E4  26 8A 45 0B     mov al, byte ptr es:[di + 0xb]
93E8  30 E4           xor ah, ah
93EA  50              push ax
93EB  9A 59 02 BC 24  call far 24BC:0259
93F0  08 C0           or al, al
93F2  74 13           je 0x9407
93F4  BF 6D 8D        mov di, 0x8d6d
93F7  0E              push cs
93F8  57              push di
93F9  6A 10           push 0x10
93FB  6A 35           push 0x35
93FD  BF 5C DD        mov di, 0xdd5c
9400  1E              push ds
9401  57              push di
9402  9A 9D 03 2A 23  call far 232A:039D
loc_9407:
9407  C4 7E F4        les di, ptr [bp - 0xc]
940A  26 80 7D 08 00  cmp byte ptr es:[di + 8], 0
940F  75 13           jne 0x9424
9411  BF 6D 8D        mov di, 0x8d6d
9414  0E              push cs
9415  57              push di
9416  6A 11           push 0x11
9418  6A 35           push 0x35
941A  BF 5C DD        mov di, 0xdd5c
941D  1E              push ds
941E  57              push di
941F  9A 9D 03 2A 23  call far 232A:039D
loc_9424:
9424  6A 03           push 3
9426  C4 7E F4        les di, ptr [bp - 0xc]
9429  26 8A 45 0B     mov al, byte ptr es:[di + 0xb]
942D  30 E4           xor ah, ah
942F  50              push ax
9430  9A 59 02 BC 24  call far 24BC:0259
9435  08 C0           or al, al
9437  74 13           je 0x944c
9439  BF 6D 8D        mov di, 0x8d6d
943C  0E              push cs
943D  57              push di
943E  6A 13           push 0x13
9440  6A 35           push 0x35
9442  BF 5C DD        mov di, 0xdd5c
9445  1E              push ds
9446  57              push di
9447  9A 9D 03 2A 23  call far 232A:039D
loc_944C:
944C  6A 05           push 5
944E  C4 7E F4        les di, ptr [bp - 0xc]
9451  26 8A 45 0B     mov al, byte ptr es:[di + 0xb]
9455  30 E4           xor ah, ah
9457  50              push ax
9458  9A 59 02 BC 24  call far 24BC:0259
945D  08 C0           or al, al
945F  74 13           je 0x9474
9461  BF 6D 8D        mov di, 0x8d6d
9464  0E              push cs
9465  57              push di
9466  6A 14           push 0x14
9468  6A 35           push 0x35
946A  BF 5C DD        mov di, 0xdd5c
946D  1E              push ds
946E  57              push di
946F  9A 9D 03 2A 23  call far 232A:039D
loc_9474:
9474  6A 06           push 6
9476  C4 7E F4        les di, ptr [bp - 0xc]
9479  26 8A 45 0B     mov al, byte ptr es:[di + 0xb]
947D  30 E4           xor ah, ah
947F  50              push ax
9480  9A 59 02 BC 24  call far 24BC:0259
9485  08 C0           or al, al
9487  74 13           je 0x949c
9489  BF 6D 8D        mov di, 0x8d6d
948C  0E              push cs
948D  57              push di
948E  6A 15           push 0x15
9490  6A 35           push 0x35
9492  BF 5C DD        mov di, 0xdd5c
9495  1E              push ds
9496  57              push di
9497  9A 9D 03 2A 23  call far 232A:039D
loc_949C:
949C  6A 01           push 1
949E  C4 7E F4        les di, ptr [bp - 0xc]
94A1  26 8A 45 0B     mov al, byte ptr es:[di + 0xb]
94A5  30 E4           xor ah, ah
94A7  50              push ax
94A8  9A 59 02 BC 24  call far 24BC:0259
94AD  08 C0           or al, al
94AF  75 0F           jne 0x94c0
94B1  BF B0 3E        mov di, 0x3eb0
94B4  1E              push ds
94B5  57              push di
94B6  BF 5C DD        mov di, 0xdd5c
94B9  1E              push ds
94BA  57              push di
94BB  9A 2F 05 2A 23  call far 232A:052F
loc_94C0:
94C0  80 3E 18 0D 00  cmp byte ptr [0xd18], 0
94C5  75 03           jne 0x94ca
94C7  E9 E5 00        jmp 0x95af
loc_94CA:
94CA  8B 46 04        mov ax, word ptr [bp + 4]
94CD  C1 E0 03        shl ax, 3
94D0  C4 3E BA D7     les di, ptr [0xd7ba]
94D4  03 F8           add di, ax
94D6  26 8A 05        mov al, byte ptr es:[di]
94D9  30 E4           xor ah, ah
94DB  3B 06 E6 D6     cmp ax, word ptr [0xd6e6]
94DF  B0 00           mov al, 0
94E1  75 01           jne 0x94e4
94E3  40              inc ax
loc_94E4:
94E4  98              cwde
94E5  6B F8 0A        imul di, ax, 0xa
94E8  8B 85 5E CF     mov ax, word ptr [di - 0x30a2]
94EC  3B 46 04        cmp ax, word ptr [bp + 4]
94EF  75 0F           jne 0x9500
94F1  BF 38 1D        mov di, 0x1d38
94F4  1E              push ds
94F5  57              push di
94F6  BF 5C DD        mov di, 0xdd5c
94F9  1E              push ds
94FA  57              push di
94FB  9A 2F 05 2A 23  call far 232A:052F
loc_9500:
9500  80 3E 75 D0 00  cmp byte ptr [0xd075], 0
9505  74 03           je 0x950a
9507  E9 A5 00        jmp 0x95af
loc_950A:
950A  FF 76 04        push word ptr [bp + 4]
950D  8B 46 04        mov ax, word ptr [bp + 4]
9510  C1 E0 03        shl ax, 3
9513  C4 3E BA D7     les di, ptr [0xd7ba]
9517  03 F8           add di, ax
9519  26 8A 05        mov al, byte ptr es:[di]
951C  30 E4           xor ah, ah
951E  6B C0 3E        imul ax, ax, 0x3e
9521  C4 3E C2 D7     les di, ptr [0xd7c2]
9525  03 F8           add di, ax
9527  81 C7 C2 FF     add di, 0xffc2
952B  06              push es
952C  57              push di
952D  9A 6E 5C 55 1B  call far 1B55:5C6E
9532  89 46 FC        mov word ptr [bp - 4], ax
9535  83 7E FC 0C     cmp word ptr [bp - 4], 0xc
9539  72 1C           jb 0x9557
953B  6A 03           push 3
953D  6B 46 04 0F     imul ax, word ptr [bp + 4], 0xf
9541  C4 3E BE D7     les di, ptr [0xd7be]
9545  03 F8           add di, ax
9547  26 8A 45 0B     mov al, byte ptr es:[di + 0xb]
954B  30 E4           xor ah, ah
954D  50              push ax
954E  9A 59 02 BC 24  call far 24BC:0259
9553  08 C0           or al, al
9555  74 58           je 0x95af
loc_9557:
9557  BF 58 63        mov di, 0x6358
955A  1E              push ds
955B  57              push di
955C  BF 5C DD        mov di, 0xdd5c
955F  1E              push ds
9560  57              push di
9561  9A 2F 05 2A 23  call far 232A:052F
9566  8B 46 FC        mov ax, word ptr [bp - 4]
9569  D1 E0           shl ax, 1
956B  8B D0           mov dx, ax
956D  8B 46 04        mov ax, word ptr [bp + 4]
9570  C1 E0 03        shl ax, 3
9573  C4 3E BA D7     les di, ptr [0xd7ba]
9577  03 F8           add di, ax
9579  26 8A 05        mov al, byte ptr es:[di]
957C  30 E4           xor ah, ah
957E  3B 06 E6 D6     cmp ax, word ptr [0xd6e6]
9582  B0 00           mov al, 0
9584  75 01           jne 0x9587
9586  40              inc ax
loc_9587:
9587  98              cwde
9588  6B F8 28        imul di, ax, 0x28
958B  03 FA           add di, dx
958D  8B 85 46 D1     mov ax, word ptr [di - 0x2eba]
9591  2D 37 00        sub ax, 0x37
9594  89 46 FE        mov word ptr [bp - 2], ax
9597  81 7E FE 88 13  cmp word ptr [bp - 2], 0x1388
959C  7E 05           jle 0x95a3
959E  81 6E FE 10 27  sub word ptr [bp - 2], 0x2710
loc_95A3:
95A3  FF 76 FE        push word ptr [bp - 2]
95A6  6A 17           push 0x17
95A8  6A 29           push 0x29
95AA  9A 0C 4D 55 1B  call far 1B55:4D0C
loc_95AF:
95AF  C9              leave
95B0  C2 02 00        ret 2

