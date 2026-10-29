; 1-095.EXE (One-Nil 95), code segment 0AB5 (image offsets 0AB50..1993F), part 15 of 22
; packed 1-095.EXE sha256 f659fb2d334500d6901fc8d6a0f06c85c0ccda2eb4a3035ae3bb0a0004d79192 (LZEXE 0.91)
; unpacked (tools/static/unlzexe.py) sha256 8df646e017e0965a5d90a58181ca764219ad847833aad0b6cb58fc53372bfb2c
; tool: capstone 5.0.9 (pip package; core library 5.0.1280) (CS_ARCH_X86, CS_MODE_16), recursive descent from the entry point, far calls and near calls/jumps, then routine prologues (55 89 E5 / 55 8B EC / C8 iw 00) in what remains; tools/static/listing.py
; addresses are SEGMENT:OFFSET with SEGMENT the image paragraph before relocation; image offset = SEGMENT*16+OFFSET
; ---- routine 0AB5:95B3  (found by: call, far)
sub_95B3:
95B3  55              push bp
95B4  89 E5           mov bp, sp
95B6  80 3E 2A 9A 00  cmp byte ptr [0x9a2a], 0
95BB  74 0A           je 0x95c7
95BD  FF 76 06        push word ptr [bp + 6]
95C0  9A EC 46 51 1B  call far 1B51:46EC
95C5  EB 06           jmp 0x95cd
loc_95C7:
95C7  FF 76 06        push word ptr [bp + 6]
95CA  E8 A2 F7        call 0x8d6f
loc_95CD:
95CD  C9              leave
95CE  CA 02 00        retf 2

; ---- routine 0AB5:95D1  (found by: call)
sub_95D1:
95D1  C8 08 00 00     enter 8, 0
95D5  A1 84 D6        mov ax, word ptr [0xd684]
95D8  C1 E0 03        shl ax, 3
95DB  C4 3E BA D7     les di, ptr [0xd7ba]
95DF  03 F8           add di, ax
95E1  6B 06 84 D6 0F  imul ax, word ptr [0xd684], 0xf
95E6  C4 3E BE D7     les di, ptr [0xd7be]
95EA  03 F8           add di, ax
95EC  89 7E F8        mov word ptr [bp - 8], di
95EF  8C 46 FA        mov word ptr [bp - 6], es
95F2  BF 5E 14        mov di, 0x145e
95F5  1E              push ds
95F6  57              push di
95F7  BF 5C DD        mov di, 0xdd5c
95FA  1E              push ds
95FB  57              push di
95FC  9A 2F 05 1A 23  call far 231A:052F
loc_9601:
9601  FF 36 84 D6     push word ptr [0xd684]
9605  0E              push cs
9606  E8 AA FF        call 0x95b3
9609  BF F0 2E        mov di, 0x2ef0
960C  1E              push ds
960D  57              push di
960E  BF 5C DD        mov di, 0xdd5c
9611  1E              push ds
9612  57              push di
9613  9A 2F 05 1A 23  call far 231A:052F
9618  A0 E8 0B        mov al, byte ptr [0xbe8]
961B  30 E4           xor ah, ah
961D  8B F8           mov di, ax
961F  8A 85 E9 0B     mov al, byte ptr [di + 0xbe9]
9623  30 E4           xor ah, ah
9625  D1 E0           shl ax, 1
9627  C4 3E 5C DD     les di, ptr [0xdd5c]
962B  03 F8           add di, ax
962D  81 C7 7E 02     add di, 0x27e
9631  06              push es
9632  57              push di
9633  6A 70           push 0x70
9635  6A 01           push 1
9637  9A 4B 03 AC 24  call far 24AC:034B
963C  BF E8 0B        mov di, 0xbe8
963F  1E              push ds
9640  57              push di
9641  6A 04           push 4
9643  9A 8B 0F 1A 23  call far 231A:0F8B
9648  80 3E 88 DE 0D  cmp byte ptr [0xde88], 0xd
964D  75 0D           jne 0x965c
964F  80 3E 2A 9A 00  cmp byte ptr [0x9a2a], 0
9654  B0 00           mov al, 0
9656  75 01           jne 0x9659
9658  40              inc ax
loc_9659:
9659  A2 2A 9A        mov byte ptr [0x9a2a], al
loc_965C:
965C  80 3E 88 DE 02  cmp byte ptr [0xde88], 2
9661  75 9E           jne 0x9601
9663  A0 E8 0B        mov al, byte ptr [0xbe8]
9666  C4 7E F8        les di, ptr [bp - 8]
9669  26 88 45 0C     mov byte ptr es:[di + 0xc], al
966D  C9              leave
966E  C3              ret

; ---- routine 0AB5:966F  (found by: call, far)
sub_966F:
966F  C8 04 00 00     enter 4, 0
9673  6B 46 06 3E     imul ax, word ptr [bp + 6], 0x3e
9677  C4 3E C2 D7     les di, ptr [0xd7c2]
967B  03 F8           add di, ax
967D  81 C7 C2 FF     add di, 0xffc2
9681  89 7E FC        mov word ptr [bp - 4], di
9684  8C 46 FE        mov word ptr [bp - 2], es
9687  BF 6C 17        mov di, 0x176c
968A  1E              push ds
968B  57              push di
968C  BF 5C DD        mov di, 0xdd5c
968F  1E              push ds
9690  57              push di
9691  9A 2F 05 1A 23  call far 231A:052F
9696  BF 5E 14        mov di, 0x145e
9699  1E              push ds
969A  57              push di
969B  BF 5C DD        mov di, 0xdd5c
969E  1E              push ds
969F  57              push di
96A0  9A 2F 05 1A 23  call far 231A:052F
loc_96A5:
96A5  FF 76 06        push word ptr [bp + 6]
96A8  9A 83 32 51 1B  call far 1B51:3283
96AD  A0 EE 0B        mov al, byte ptr [0xbee]
96B0  30 E4           xor ah, ah
96B2  05 0F 00        add ax, 0xf
96B5  50              push ax
96B6  6A 16           push 0x16
96B8  6A 21           push 0x21
96BA  9A 03 02 1A 23  call far 231A:0203
96BF  BF EE 0B        mov di, 0xbee
96C2  1E              push ds
96C3  57              push di
96C4  6A 08           push 8
96C6  9A 8B 0F 1A 23  call far 231A:0F8B
96CB  80 3E 88 DE 02  cmp byte ptr [0xde88], 2
96D0  75 14           jne 0x96e6
96D2  A0 EE 0B        mov al, byte ptr [0xbee]
96D5  30 E4           xor ah, ah
96D7  50              push ax
96D8  C4 7E FC        les di, ptr [bp - 4]
96DB  81 C7 39 00     add di, 0x39
96DF  06              push es
96E0  57              push di
96E1  9A 44 01 1A 23  call far 231A:0144
loc_96E6:
96E6  80 3E 91 0D 00  cmp byte ptr [0xd91], 0
96EB  74 0A           je 0x96f7
96ED  80 3E EE 0B 08  cmp byte ptr [0xbee], 8
96F2  75 03           jne 0x96f7
96F4  E8 C2 79        call 0x110b9
loc_96F7:
96F7  80 3E 88 DE 01  cmp byte ptr [0xde88], 1
96FC  75 A7           jne 0x96a5
96FE  C9              leave
96FF  CA 02 00        retf 2

; ---- routine 0AB5:9702  (found by: call, far)
sub_9702:
9702  55              push bp
9703  89 E5           mov bp, sp
9705  80 7E 06 00     cmp byte ptr [bp + 6], 0
9709  74 0F           je 0x971a
970B  BF 20 4F        mov di, 0x4f20
970E  1E              push ds
970F  57              push di
9710  BF 5C DD        mov di, 0xdd5c
9713  1E              push ds
9714  57              push di
9715  9A 2F 05 1A 23  call far 231A:052F
loc_971A:
971A  FF 76 08        push word ptr [bp + 8]
971D  8A 46 06        mov al, byte ptr [bp + 6]
9720  50              push ax
9721  9A BA 33 51 1B  call far 1B51:33BA
9726  6B 46 08 3E     imul ax, word ptr [bp + 8], 0x3e
972A  C4 3E C2 D7     les di, ptr [0xd7c2]
972E  03 F8           add di, ax
9730  81 C7 C2 FF     add di, 0xffc2
9734  06              push es
9735  57              push di
9736  0E              push cs
9737  E8 96 08        call 0x9fd0
973A  C9              leave
973B  CA 04 00        retf 4

; ---- routine 0AB5:973E  (found by: call)
sub_973E:
973E  C8 04 00 00     enter 4, 0
9742  8B 7E 04        mov di, word ptr [bp + 4]
9745  31 C0           xor ax, ax
9747  36 89 45 FA     mov word ptr ss:[di - 6], ax
974B  6A 10           push 0x10
974D  9A 6D 07 1A 23  call far 231A:076D
9752  8B D0           mov dx, ax
9754  8B 7E 04        mov di, word ptr [bp + 4]
9757  36 8B 7D FE     mov di, word ptr ss:[di - 2]
975B  8A 85 EF 0B     mov al, byte ptr [di + 0xbef]
975F  30 E4           xor ah, ah
9761  03 C2           add ax, dx
9763  8B F8           mov di, ax
9765  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
9769  30 E4           xor ah, ah
976B  89 46 FC        mov word ptr [bp - 4], ax
976E  FF 76 FC        push word ptr [bp - 4]
9771  9A DA 0D 51 1B  call far 1B51:0DDA
9776  08 C0           or al, al
9778  75 55           jne 0x97cf
977A  FF 76 FC        push word ptr [bp - 4]
977D  C4 3E D2 D7     les di, ptr [0xd7d2]
9781  26 8A 05        mov al, byte ptr es:[di]
9784  30 E4           xor ah, ah
9786  8B F0           mov si, ax
9788  D1 E0           shl ax, 1
978A  01 F0           add ax, si
978C  8B D0           mov dx, ax
978E  69 46 FC AE 00  imul ax, word ptr [bp - 4], 0xae
9793  C4 3E CA D7     les di, ptr [0xd7ca]
9797  03 F8           add di, ax
9799  03 FA           add di, dx
979B  26 8A 85 50 FF  mov al, byte ptr es:[di - 0xb0]
97A0  30 E4           xor ah, ah
97A2  50              push ax
97A3  9A 99 1B 94 19  call far 1994:1B99
97A8  08 C0           or al, al
97AA  75 23           jne 0x97cf
97AC  6A 0A           push 0xa
97AE  9A 6D 07 1A 23  call far 231A:076D
97B3  40              inc ax
97B4  D1 E0           shl ax, 1
97B6  8B D0           mov dx, ax
97B8  6B 46 FC 3E     imul ax, word ptr [bp - 4], 0x3e
97BC  C4 3E C2 D7     les di, ptr [0xd7c2]
97C0  03 F8           add di, ax
97C2  03 FA           add di, dx
97C4  26 8B 45 C0     mov ax, word ptr es:[di - 0x40]
97C8  8B 7E 04        mov di, word ptr [bp + 4]
97CB  36 89 45 FA     mov word ptr ss:[di - 6], ax
loc_97CF:
97CF  8B 7E 04        mov di, word ptr [bp + 4]
97D2  36 83 7D FA 00  cmp word ptr ss:[di - 6], 0
97D7  B0 00           mov al, 0
97D9  74 01           je 0x97dc
97DB  40              inc ax
loc_97DC:
97DC  88 46 FF        mov byte ptr [bp - 1], al
97DF  8A 46 FF        mov al, byte ptr [bp - 1]
97E2  C9              leave
97E3  C2 02 00        ret 2

; ---- routine 0AB5:97E6  (found by: call)
sub_97E6:
97E6  55              push bp
97E7  89 E5           mov bp, sp
97E9  8B 7E 04        mov di, word ptr [bp + 4]
97EC  57              push di
97ED  E8 4E FF        call 0x973e
97F0  08 C0           or al, al
97F2  74 0C           je 0x9800
97F4  8B 7E 04        mov di, word ptr [bp + 4]
97F7  36 FF 75 FA     push word ptr ss:[di - 6]
97FB  9A 94 13 94 19  call far 1994:1394
loc_9800:
9800  C9              leave
9801  C2 02 00        ret 2

; ---- routine 0AB5:9804  (found by: call)
sub_9804:
9804  55              push bp
9805  89 E5           mov bp, sp
9807  8B 7E 04        mov di, word ptr [bp + 4]
980A  57              push di
980B  E8 30 FF        call 0x973e
980E  08 C0           or al, al
9810  75 02           jne 0x9814
9812  EB 28           jmp 0x983c
loc_9814:
9814  FF 76 06        push word ptr [bp + 6]
9817  8B 7E 04        mov di, word ptr [bp + 4]
981A  36 6B 45 FA 0F  imul ax, word ptr ss:[di - 6], 0xf
981F  C4 3E BE D7     les di, ptr [0xd7be]
9823  03 F8           add di, ax
9825  81 C7 0B 00     add di, 0xb
9829  06              push es
982A  57              push di
982B  9A D5 00 1A 23  call far 231A:00D5
9830  8B 7E 04        mov di, word ptr [bp + 4]
9833  36 FF 75 FA     push word ptr ss:[di - 6]
9837  9A BE 12 94 19  call far 1994:12BE
loc_983C:
983C  C9              leave
983D  C2 04 00        ret 4

; ---- routine 0AB5:9840  (found by: call)
sub_9840:
9840  C8 06 00 00     enter 6, 0
9844  C7 46 FE 01 00  mov word ptr [bp - 2], 1
9849  EB 03           jmp 0x984e
loc_984B:
984B  FF 46 FE        inc word ptr [bp - 2]
loc_984E:
984E  C7 46 FC 01 00  mov word ptr [bp - 4], 1
9853  EB 03           jmp 0x9858
loc_9855:
9855  FF 46 FC        inc word ptr [bp - 4]
loc_9858:
9858  6A 05           push 5
985A  55              push bp
985B  E8 A6 FF        call 0x9804
985E  83 7E FC 01     cmp word ptr [bp - 4], 1
9862  75 04           jne 0x9868
9864  55              push bp
9865  E8 7E FF        call 0x97e6
loc_9868:
9868  83 7E FC 03     cmp word ptr [bp - 4], 3
986C  73 06           jae 0x9874
986E  6A 06           push 6
9870  55              push bp
9871  E8 90 FF        call 0x9804
loc_9874:
9874  83 7E FC 04     cmp word ptr [bp - 4], 4
9878  75 DB           jne 0x9855
987A  83 7E FE 05     cmp word ptr [bp - 2], 5
987E  75 CB           jne 0x984b
9880  C9              leave
9881  C3              ret

; ---- routine 0AB5:9882  (found by: call, far)
sub_9882:
9882  C8 12 01 00     enter 0x112, 0
9886  8B 46 0A        mov ax, word ptr [bp + 0xa]
9889  C1 E0 03        shl ax, 3
988C  C4 3E BA D7     les di, ptr [0xd7ba]
9890  03 F8           add di, ax
9892  89 7E EE        mov word ptr [bp - 0x12], di
9895  8C 46 F0        mov word ptr [bp - 0x10], es
9898  26 8A 45 06     mov al, byte ptr es:[di + 6]
989C  30 E4           xor ah, ah
989E  8B F8           mov di, ax
98A0  C1 E7 03        shl di, 3
98A3  8D 85 F6 0B     lea ax, [di + 0xbf6]
98A7  8C DA           mov dx, ds
98A9  89 46 FA        mov word ptr [bp - 6], ax
98AC  89 56 FC        mov word ptr [bp - 4], dx
98AF  31 C0           xor ax, ax
98B1  89 46 F6        mov word ptr [bp - 0xa], ax
98B4  8D BE EE FE     lea di, [bp - 0x112]
98B8  16              push ss
98B9  57              push di
98BA  C4 7E EE        les di, ptr [bp - 0x12]
98BD  26 8A 45 06     mov al, byte ptr es:[di + 6]
98C1  50              push ax
98C2  9A 6F 0C B9 26  call far 26B9:0C6F
98C7  BF 9A 0D        mov di, 0xd9a
98CA  1E              push ds
98CB  57              push di
98CC  9A FE 0B B9 26  call far 26B9:0BFE
98D1  89 46 F4        mov word ptr [bp - 0xc], ax
98D4  83 7E F4 00     cmp word ptr [bp - 0xc], 0
98D8  77 03           ja 0x98dd
98DA  E9 89 00        jmp 0x9966
loc_98DD:
98DD  83 7E F4 03     cmp word ptr [bp - 0xc], 3
98E1  B0 00           mov al, 0
98E3  76 01           jbe 0x98e6
98E5  40              inc ax
loc_98E6:
98E6  88 46 F3        mov byte ptr [bp - 0xd], al
98E9  C4 7E FA        les di, ptr [bp - 6]
98EC  26 8A 05        mov al, byte ptr es:[di]
98EF  30 E4           xor ah, ah
98F1  89 46 EC        mov word ptr [bp - 0x14], ax
98F4  B8 01 00        mov ax, 1
98F7  3B 46 EC        cmp ax, word ptr [bp - 0x14]
98FA  77 68           ja 0x9964
98FC  89 46 F8        mov word ptr [bp - 8], ax
98FF  EB 03           jmp 0x9904
loc_9901:
9901  FF 46 F8        inc word ptr [bp - 8]
loc_9904:
9904  8B 46 F8        mov ax, word ptr [bp - 8]
9907  C4 7E FA        les di, ptr [bp - 6]
990A  03 F8           add di, ax
990C  26 8A 05        mov al, byte ptr es:[di]
990F  30 E4           xor ah, ah
9911  8B F8           mov di, ax
9913  80 BD 76 D0 00  cmp byte ptr [di - 0x2f8a], 0
9918  74 42           je 0x995c
991A  8B 46 F8        mov ax, word ptr [bp - 8]
991D  C4 7E FA        les di, ptr [bp - 6]
9920  03 F8           add di, ax
9922  26 8A 05        mov al, byte ptr es:[di]
9925  30 E4           xor ah, ah
9927  8B F8           mov di, ax
9929  8A 85 76 D0     mov al, byte ptr [di - 0x2f8a]
992D  30 E4           xor ah, ah
992F  D1 E0           shl ax, 1
9931  C4 7E 06        les di, ptr [bp + 6]
9934  03 F8           add di, ax
9936  26 FF 75 FE     push word ptr es:[di - 2]
993A  9A E1 4D 51 1B  call far 1B51:4DE1
993F  3A 46 F3        cmp al, byte ptr [bp - 0xd]
9942  75 18           jne 0x995c
9944  8B 46 F8        mov ax, word ptr [bp - 8]
9947  C4 7E FA        les di, ptr [bp - 6]
994A  03 F8           add di, ax
994C  26 8A 05        mov al, byte ptr es:[di]
994F  30 E4           xor ah, ah
9951  8B F8           mov di, ax
9953  8A 85 76 D0     mov al, byte ptr [di - 0x2f8a]
9957  30 E4           xor ah, ah
9959  89 46 F6        mov word ptr [bp - 0xa], ax
loc_995C:
995C  8B 46 F8        mov ax, word ptr [bp - 8]
995F  3B 46 EC        cmp ax, word ptr [bp - 0x14]
9962  75 9D           jne 0x9901
loc_9964:
9964  EB 51           jmp 0x99b7
loc_9966:
9966  C4 7E FA        les di, ptr [bp - 6]
9969  26 8A 05        mov al, byte ptr es:[di]
996C  30 E4           xor ah, ah
996E  89 46 EC        mov word ptr [bp - 0x14], ax
9971  B8 01 00        mov ax, 1
9974  3B 46 EC        cmp ax, word ptr [bp - 0x14]
9977  77 3E           ja 0x99b7
9979  89 46 F8        mov word ptr [bp - 8], ax
997C  EB 03           jmp 0x9981
loc_997E:
997E  FF 46 F8        inc word ptr [bp - 8]
loc_9981:
9981  8B 46 F8        mov ax, word ptr [bp - 8]
9984  C4 7E FA        les di, ptr [bp - 6]
9987  03 F8           add di, ax
9989  26 8A 05        mov al, byte ptr es:[di]
998C  30 E4           xor ah, ah
998E  8B F8           mov di, ax
9990  80 BD 76 D0 00  cmp byte ptr [di - 0x2f8a], 0
9995  74 18           je 0x99af
9997  8B 46 F8        mov ax, word ptr [bp - 8]
999A  C4 7E FA        les di, ptr [bp - 6]
999D  03 F8           add di, ax
999F  26 8A 05        mov al, byte ptr es:[di]
99A2  30 E4           xor ah, ah
99A4  8B F8           mov di, ax
99A6  8A 85 76 D0     mov al, byte ptr [di - 0x2f8a]
99AA  30 E4           xor ah, ah
99AC  89 46 F6        mov word ptr [bp - 0xa], ax
loc_99AF:
99AF  8B 46 F8        mov ax, word ptr [bp - 8]
99B2  3B 46 EC        cmp ax, word ptr [bp - 0x14]
99B5  75 C7           jne 0x997e
loc_99B7:
99B7  8B 46 F6        mov ax, word ptr [bp - 0xa]
99BA  89 46 FE        mov word ptr [bp - 2], ax
99BD  8B 46 FE        mov ax, word ptr [bp - 2]
99C0  C9              leave
99C1  CA 06 00        retf 6

; ---- routine 0AB5:99C4  (found by: call)
sub_99C4:
99C4  C8 0A 00 00     enter 0xa, 0
99C8  8B 7E 04        mov di, word ptr [bp + 4]
99CB  36 6B 45 04 3E  imul ax, word ptr ss:[di + 4], 0x3e
99D0  C4 3E C2 D7     les di, ptr [0xd7c2]
99D4  03 F8           add di, ax
99D6  81 C7 C2 FF     add di, 0xffc2
99DA  89 7E FA        mov word ptr [bp - 6], di
99DD  8C 46 FC        mov word ptr [bp - 4], es
99E0  8B 46 06        mov ax, word ptr [bp + 6]
99E3  D1 E0           shl ax, 1
99E5  03 F8           add di, ax
99E7  26 8B 45 FE     mov ax, word ptr es:[di - 2]
99EB  89 46 FE        mov word ptr [bp - 2], ax
99EE  8B 46 FE        mov ax, word ptr [bp - 2]
99F1  C1 E0 03        shl ax, 3
99F4  C4 3E BA D7     les di, ptr [0xd7ba]
99F8  03 F8           add di, ax
99FA  89 7E F6        mov word ptr [bp - 0xa], di
99FD  8C 46 F8        mov word ptr [bp - 8], es
9A00  FF 76 FE        push word ptr [bp - 2]
9A03  9A E9 4E 51 1B  call far 1B51:4EE9
9A08  08 C0           or al, al
9A0A  75 57           jne 0x9a63
9A0C  C4 7E F6        les di, ptr [bp - 0xa]
9A0F  26 8A 45 07     mov al, byte ptr es:[di + 7]
9A13  30 E4           xor ah, ah
9A15  8B F8           mov di, ax
9A17  80 BD 76 D0 00  cmp byte ptr [di - 0x2f8a], 0
9A1C  74 33           je 0x9a51
9A1E  C4 7E F6        les di, ptr [bp - 0xa]
9A21  26 8A 45 07     mov al, byte ptr es:[di + 7]
9A25  30 E4           xor ah, ah
9A27  8B F8           mov di, ax
9A29  8A 85 76 D0     mov al, byte ptr [di - 0x2f8a]
9A2D  30 E4           xor ah, ah
9A2F  D1 E0           shl ax, 1
9A31  C4 7E FA        les di, ptr [bp - 6]
9A34  03 F8           add di, ax
9A36  26 FF 75 FE     push word ptr es:[di - 2]
9A3A  6A 01           push 1
9A3C  9A AA 4A 51 1B  call far 1B51:4AAA
9A41  50              push ax
9A42  FF 76 FE        push word ptr [bp - 2]
9A45  6A 01           push 1
9A47  9A AA 4A 51 1B  call far 1B51:4AAA
9A4C  5A              pop dx
9A4D  3B C2           cmp ax, dx
9A4F  76 12           jbe 0x9a63
loc_9A51:
9A51  8A 56 06        mov dl, byte ptr [bp + 6]
9A54  C4 7E F6        les di, ptr [bp - 0xa]
9A57  26 8A 45 07     mov al, byte ptr es:[di + 7]
9A5B  30 E4           xor ah, ah
9A5D  8B F8           mov di, ax
9A5F  88 95 76 D0     mov byte ptr [di - 0x2f8a], dl
loc_9A63:
9A63  C9              leave
9A64  C2 04 00        ret 4

; ---- routine 0AB5:9A67  (found by: call)
sub_9A67:
9A67  C8 08 00 00     enter 8, 0
9A6B  8B 7E 04        mov di, word ptr [bp + 4]
9A6E  36 6B 45 04 3E  imul ax, word ptr ss:[di + 4], 0x3e
9A73  C4 3E C2 D7     les di, ptr [0xd7c2]
9A77  03 F8           add di, ax
9A79  81 C7 C2 FF     add di, 0xffc2
9A7D  89 7E FC        mov word ptr [bp - 4], di
9A80  8C 46 FE        mov word ptr [bp - 2], es
9A83  8B 7E 04        mov di, word ptr [bp + 4]
9A86  36 8B 45 FE     mov ax, word ptr ss:[di - 2]
9A8A  D1 E0           shl ax, 1
9A8C  C4 7E FC        les di, ptr [bp - 4]
9A8F  03 F8           add di, ax
9A91  26 8B 45 FE     mov ax, word ptr es:[di - 2]
9A95  C1 E0 03        shl ax, 3
9A98  C4 3E BA D7     les di, ptr [0xd7ba]
9A9C  03 F8           add di, ax
9A9E  26 8A 45 07     mov al, byte ptr es:[di + 7]
9AA2  30 E4           xor ah, ah
9AA4  8B F8           mov di, ax
9AA6  C6 85 76 D0 00  mov byte ptr [di - 0x2f8a], 0
9AAB  8B 7E 04        mov di, word ptr [bp + 4]
9AAE  36 8B 45 FE     mov ax, word ptr ss:[di - 2]
9AB2  D1 E0           shl ax, 1
9AB4  C4 7E FC        les di, ptr [bp - 4]
9AB7  03 F8           add di, ax
9AB9  81 C7 FE FF     add di, 0xfffe
9ABD  06              push es
9ABE  57              push di
9ABF  8B 46 06        mov ax, word ptr [bp + 6]
9AC2  D1 E0           shl ax, 1
9AC4  C4 7E FC        les di, ptr [bp - 4]
9AC7  03 F8           add di, ax
9AC9  81 C7 FE FF     add di, 0xfffe
9ACD  06              push es
9ACE  57              push di
9ACF  6A 02           push 2
9AD1  9A 03 02 AC 24  call far 24AC:0203
9AD6  8B 7E 04        mov di, word ptr [bp + 4]
9AD9  36 8B 45 FE     mov ax, word ptr ss:[di - 2]
9ADD  D1 E0           shl ax, 1
9ADF  C4 7E FC        les di, ptr [bp - 4]
9AE2  03 F8           add di, ax
9AE4  26 8B 45 FE     mov ax, word ptr es:[di - 2]
9AE8  C1 E0 03        shl ax, 3
9AEB  C4 3E BA D7     les di, ptr [0xd7ba]
9AEF  03 F8           add di, ax
9AF1  26 8A 55 06     mov dl, byte ptr es:[di + 6]
9AF5  8B 46 06        mov ax, word ptr [bp + 6]
9AF8  D1 E0           shl ax, 1
9AFA  C4 7E FC        les di, ptr [bp - 4]
9AFD  03 F8           add di, ax
9AFF  26 8B 45 FE     mov ax, word ptr es:[di - 2]
9B03  C1 E0 03        shl ax, 3
9B06  C4 3E BA D7     les di, ptr [0xd7ba]
9B0A  03 F8           add di, ax
9B0C  26 88 55 06     mov byte ptr es:[di + 6], dl
9B10  8B 7E 04        mov di, word ptr [bp + 4]
9B13  36 8B 45 FE     mov ax, word ptr ss:[di - 2]
9B17  D1 E0           shl ax, 1
9B19  C4 7E FC        les di, ptr [bp - 4]
9B1C  03 F8           add di, ax
9B1E  26 8B 45 FE     mov ax, word ptr es:[di - 2]
9B22  C1 E0 03        shl ax, 3
9B25  C4 3E BA D7     les di, ptr [0xd7ba]
9B29  03 F8           add di, ax
9B2B  26 8A 45 07     mov al, byte ptr es:[di + 7]
9B2F  26 88 45 06     mov byte ptr es:[di + 6], al
9B33  8B 7E 04        mov di, word ptr [bp + 4]
9B36  36 FF 75 FE     push word ptr ss:[di - 2]
9B3A  57              push di
9B3B  E8 86 FE        call 0x99c4
9B3E  C9              leave
9B3F  C2 04 00        ret 4

; ---- routine 0AB5:9B42  (found by: call)
sub_9B42:
9B42  C8 08 00 00     enter 8, 0
9B46  8B 7E 04        mov di, word ptr [bp + 4]
9B49  36 6B 45 04 3E  imul ax, word ptr ss:[di + 4], 0x3e
9B4E  C4 3E C2 D7     les di, ptr [0xd7c2]
9B52  03 F8           add di, ax
9B54  81 C7 C2 FF     add di, 0xffc2
9B58  89 7E F8        mov word ptr [bp - 8], di
9B5B  8C 46 FA        mov word ptr [bp - 6], es
9B5E  C7 46 FE 01 00  mov word ptr [bp - 2], 1
9B63  EB 03           jmp 0x9b68
loc_9B65:
9B65  FF 46 FE        inc word ptr [bp - 2]
loc_9B68:
9B68  8B 46 FE        mov ax, word ptr [bp - 2]
9B6B  D1 E0           shl ax, 1
9B6D  C4 7E F8        les di, ptr [bp - 8]
9B70  03 F8           add di, ax
9B72  26 8B 45 FE     mov ax, word ptr es:[di - 2]
9B76  89 46 FC        mov word ptr [bp - 4], ax
9B79  FF 76 FC        push word ptr [bp - 4]
9B7C  C4 7E F8        les di, ptr [bp - 8]
9B7F  06              push es
9B80  57              push di
9B81  0E              push cs
9B82  E8 FD FC        call 0x9882
9B85  8B 7E 04        mov di, word ptr [bp + 4]
9B88  36 89 45 FE     mov word ptr ss:[di - 2], ax
9B8C  36 83 7D FE 00  cmp word ptr ss:[di - 2], 0
9B91  75 03           jne 0x9b96
9B93  E9 8C 00        jmp 0x9c22
loc_9B96:
9B96  FF 76 FC        push word ptr [bp - 4]
9B99  6A 01           push 1
9B9B  9A AA 4A 51 1B  call far 1B51:4AAA
9BA0  50              push ax
9BA1  8B 7E 04        mov di, word ptr [bp + 4]
9BA4  36 8B 45 FE     mov ax, word ptr ss:[di - 2]
9BA8  D1 E0           shl ax, 1
9BAA  C4 7E F8        les di, ptr [bp - 8]
9BAD  03 F8           add di, ax
9BAF  26 FF 75 FE     push word ptr es:[di - 2]
9BB3  6A 01           push 1
9BB5  9A AA 4A 51 1B  call far 1B51:4AAA
9BBA  5A              pop dx
9BBB  3B C2           cmp ax, dx
9BBD  77 57           ja 0x9c16
9BBF  8B 46 FC        mov ax, word ptr [bp - 4]
9BC2  C1 E0 03        shl ax, 3
9BC5  C4 3E BA D7     les di, ptr [0xd7ba]
9BC9  03 F8           add di, ax
9BCB  26 8A 55 06     mov dl, byte ptr es:[di + 6]
9BCF  8B 46 FC        mov ax, word ptr [bp - 4]
9BD2  C1 E0 03        shl ax, 3
9BD5  C4 3E BA D7     les di, ptr [0xd7ba]
9BD9  03 F8           add di, ax
9BDB  26 8A 45 07     mov al, byte ptr es:[di + 7]
9BDF  3A C2           cmp al, dl
9BE1  74 3F           je 0x9c22
9BE3  8B 46 FC        mov ax, word ptr [bp - 4]
9BE6  C1 E0 03        shl ax, 3
9BE9  C4 3E BA D7     les di, ptr [0xd7ba]
9BED  03 F8           add di, ax
9BEF  26 8A 55 06     mov dl, byte ptr es:[di + 6]
9BF3  8B 7E 04        mov di, word ptr [bp + 4]
9BF6  36 8B 45 FE     mov ax, word ptr ss:[di - 2]
9BFA  D1 E0           shl ax, 1
9BFC  C4 7E F8        les di, ptr [bp - 8]
9BFF  03 F8           add di, ax
9C01  26 8B 45 FE     mov ax, word ptr es:[di - 2]
9C05  C1 E0 03        shl ax, 3
9C08  C4 3E BA D7     les di, ptr [0xd7ba]
9C0C  03 F8           add di, ax
9C0E  26 8A 45 07     mov al, byte ptr es:[di + 7]
9C12  3A C2           cmp al, dl
9C14  75 0C           jne 0x9c22
loc_9C16:
9C16  FF 76 FE        push word ptr [bp - 2]
9C19  8B 7E 04        mov di, word ptr [bp + 4]
9C1C  57              push di
9C1D  E8 47 FE        call 0x9a67
9C20  EB 7D           jmp 0x9c9f
loc_9C22:
9C22  FF 76 FC        push word ptr [bp - 4]
9C25  9A E9 4E 51 1B  call far 1B51:4EE9
9C2A  08 C0           or al, al
9C2C  75 25           jne 0x9c53
9C2E  FF 76 FC        push word ptr [bp - 4]
9C31  9A 65 4E 51 1B  call far 1B51:4E65
9C36  08 C0           or al, al
9C38  75 19           jne 0x9c53
9C3A  83 7E FE 01     cmp word ptr [bp - 2], 1
9C3E  75 5F           jne 0x9c9f
9C40  8B 46 FC        mov ax, word ptr [bp - 4]
9C43  C1 E0 03        shl ax, 3
9C46  C4 3E BA D7     les di, ptr [0xd7ba]
9C4A  03 F8           add di, ax
9C4C  26 80 7D 07 00  cmp byte ptr es:[di + 7], 0
9C51  74 4C           je 0x9c9f
loc_9C53:
9C53  8B 7E 04        mov di, word ptr [bp + 4]
9C56  36 83 7D FE 00  cmp word ptr ss:[di - 2], 0
9C5B  74 09           je 0x9c66
9C5D  FF 76 FE        push word ptr [bp - 2]
9C60  57              push di
9C61  E8 03 FE        call 0x9a67
9C64  EB 39           jmp 0x9c9f
loc_9C66:
9C66  C4 7E F8        les di, ptr [bp - 8]
9C69  06              push es
9C6A  57              push di
9C6B  26 8A 45 32     mov al, byte ptr es:[di + 0x32]
9C6F  30 E4           xor ah, ah
9C71  50              push ax
9C72  8B 46 FC        mov ax, word ptr [bp - 4]
9C75  C1 E0 03        shl ax, 3
9C78  C4 3E BA D7     les di, ptr [0xd7ba]
9C7C  03 F8           add di, ax
9C7E  26 8A 45 06     mov al, byte ptr es:[di + 6]
9C82  30 E4           xor ah, ah
9C84  50              push ax
9C85  9A 6B 4F 51 1B  call far 1B51:4F6B
9C8A  8B 7E 04        mov di, word ptr [bp + 4]
9C8D  36 89 45 FE     mov word ptr ss:[di - 2], ax
9C91  36 83 7D FE 00  cmp word ptr ss:[di - 2], 0
9C96  74 07           je 0x9c9f
9C98  FF 76 FE        push word ptr [bp - 2]
9C9B  57              push di
9C9C  E8 C8 FD        call 0x9a67
loc_9C9F:
9C9F  83 7E FE 0B     cmp word ptr [bp - 2], 0xb
9CA3  74 03           je 0x9ca8
9CA5  E9 BD FE        jmp 0x9b65
loc_9CA8:
9CA8  C9              leave
9CA9  C2 02 00        ret 2

; ---- routine 0AB5:9CAC  (found by: call)
sub_9CAC:
9CAC  C8 0C 00 00     enter 0xc, 0
9CB0  6B 46 04 3E     imul ax, word ptr [bp + 4], 0x3e
9CB4  C4 3E C2 D7     les di, ptr [0xd7c2]
9CB8  03 F8           add di, ax
9CBA  81 C7 C2 FF     add di, 0xffc2
9CBE  89 7E F6        mov word ptr [bp - 0xa], di
9CC1  8C 46 F8        mov word ptr [bp - 8], es
9CC4  BF 76 D0        mov di, 0xd076
9CC7  1E              push ds
9CC8  57              push di
9CC9  6A 0E           push 0xe
9CCB  6A 00           push 0
9CCD  9A 22 02 AC 24  call far 24AC:0222
9CD2  C4 7E F6        les di, ptr [bp - 0xa]
9CD5  26 8A 45 32     mov al, byte ptr es:[di + 0x32]
9CD9  30 E4           xor ah, ah
9CDB  89 46 F4        mov word ptr [bp - 0xc], ax
9CDE  B8 0C 00        mov ax, 0xc
9CE1  3B 46 F4        cmp ax, word ptr [bp - 0xc]
9CE4  77 17           ja 0x9cfd
9CE6  89 46 FC        mov word ptr [bp - 4], ax
9CE9  EB 03           jmp 0x9cee
loc_9CEB:
9CEB  FF 46 FC        inc word ptr [bp - 4]
loc_9CEE:
9CEE  FF 76 FC        push word ptr [bp - 4]
9CF1  55              push bp
9CF2  E8 CF FC        call 0x99c4
9CF5  8B 46 FC        mov ax, word ptr [bp - 4]
9CF8  3B 46 F4        cmp ax, word ptr [bp - 0xc]
9CFB  75 EE           jne 0x9ceb
loc_9CFD:
9CFD  55              push bp
9CFE  E8 41 FE        call 0x9b42
9D01  C4 7E F6        les di, ptr [bp - 0xa]
9D04  26 80 7D 32 0E  cmp byte ptr es:[di + 0x32], 0xe
9D09  77 03           ja 0x9d0e
9D0B  E9 E1 01        jmp 0x9eef
loc_9D0E:
9D0E  C7 46 FA 0D 00  mov word ptr [bp - 6], 0xd
9D13  EB 03           jmp 0x9d18
loc_9D15:
9D15  FF 46 FA        inc word ptr [bp - 6]
loc_9D18:
9D18  C4 7E F6        les di, ptr [bp - 0xa]
9D1B  26 8A 45 32     mov al, byte ptr es:[di + 0x32]
9D1F  30 E4           xor ah, ah
9D21  89 46 F4        mov word ptr [bp - 0xc], ax
9D24  B8 0F 00        mov ax, 0xf
9D27  3B 46 F4        cmp ax, word ptr [bp - 0xc]
9D2A  76 03           jbe 0x9d2f
9D2C  E9 BD 00        jmp 0x9dec
loc_9D2F:
9D2F  89 46 FC        mov word ptr [bp - 4], ax
9D32  EB 03           jmp 0x9d37
loc_9D34:
9D34  FF 46 FC        inc word ptr [bp - 4]
loc_9D37:
9D37  8B 46 FA        mov ax, word ptr [bp - 6]
9D3A  D1 E0           shl ax, 1
9D3C  C4 7E F6        les di, ptr [bp - 0xa]
9D3F  03 F8           add di, ax
9D41  26 8B 45 FE     mov ax, word ptr es:[di - 2]
9D45  C1 E0 03        shl ax, 3
9D48  C4 3E BA D7     les di, ptr [0xd7ba]
9D4C  03 F8           add di, ax
9D4E  26 80 7D 07 00  cmp byte ptr es:[di + 7], 0
9D53  74 65           je 0x9dba
9D55  8B 46 FA        mov ax, word ptr [bp - 6]
9D58  D1 E0           shl ax, 1
9D5A  C4 7E F6        les di, ptr [bp - 0xa]
9D5D  03 F8           add di, ax
9D5F  26 FF 75 FE     push word ptr es:[di - 2]
9D63  9A E9 4E 51 1B  call far 1B51:4EE9
9D68  08 C0           or al, al
9D6A  75 4E           jne 0x9dba
9D6C  8B 46 FC        mov ax, word ptr [bp - 4]
9D6F  D1 E0           shl ax, 1
9D71  C4 7E F6        les di, ptr [bp - 0xa]
9D74  03 F8           add di, ax
9D76  26 8B 45 FE     mov ax, word ptr es:[di - 2]
9D7A  C1 E0 03        shl ax, 3
9D7D  C4 3E BA D7     les di, ptr [0xd7ba]
9D81  03 F8           add di, ax
9D83  26 80 7D 07 00  cmp byte ptr es:[di + 7], 0
9D88  74 57           je 0x9de1
9D8A  8B 46 FA        mov ax, word ptr [bp - 6]
9D8D  D1 E0           shl ax, 1
9D8F  C4 7E F6        les di, ptr [bp - 0xa]
9D92  03 F8           add di, ax
9D94  26 FF 75 FE     push word ptr es:[di - 2]
9D98  6A 01           push 1
9D9A  9A AA 4A 51 1B  call far 1B51:4AAA
9D9F  50              push ax
9DA0  8B 46 FC        mov ax, word ptr [bp - 4]
9DA3  D1 E0           shl ax, 1
9DA5  C4 7E F6        les di, ptr [bp - 0xa]
9DA8  03 F8           add di, ax
9DAA  26 FF 75 FE     push word ptr es:[di - 2]
9DAE  6A 01           push 1
9DB0  9A AA 4A 51 1B  call far 1B51:4AAA
9DB5  5A              pop dx
9DB6  3B C2           cmp ax, dx
9DB8  76 27           jbe 0x9de1
loc_9DBA:
9DBA  8B 46 FC        mov ax, word ptr [bp - 4]
9DBD  D1 E0           shl ax, 1
9DBF  C4 7E F6        les di, ptr [bp - 0xa]
9DC2  03 F8           add di, ax
9DC4  81 C7 FE FF     add di, 0xfffe
9DC8  06              push es
9DC9  57              push di
9DCA  8B 46 FA        mov ax, word ptr [bp - 6]
9DCD  D1 E0           shl ax, 1
9DCF  C4 7E F6        les di, ptr [bp - 0xa]
9DD2  03 F8           add di, ax
9DD4  81 C7 FE FF     add di, 0xfffe
9DD8  06              push es
9DD9  57              push di
9DDA  6A 02           push 2
9DDC  9A 03 02 AC 24  call far 24AC:0203
loc_9DE1:
9DE1  8B 46 FC        mov ax, word ptr [bp - 4]
9DE4  3B 46 F4        cmp ax, word ptr [bp - 0xc]
9DE7  74 03           je 0x9dec
9DE9  E9 48 FF        jmp 0x9d34
loc_9DEC:
9DEC  83 7E FA 0E     cmp word ptr [bp - 6], 0xe
9DF0  74 03           je 0x9df5
9DF2  E9 20 FF        jmp 0x9d15
loc_9DF5:
9DF5  C7 46 FA 0C 00  mov word ptr [bp - 6], 0xc
9DFA  C4 7E F6        les di, ptr [bp - 0xa]
9DFD  26 8A 45 32     mov al, byte ptr es:[di + 0x32]
9E01  30 E4           xor ah, ah
9E03  89 46 F4        mov word ptr [bp - 0xc], ax
9E06  B8 0F 00        mov ax, 0xf
9E09  3B 46 F4        cmp ax, word ptr [bp - 0xc]
9E0C  76 03           jbe 0x9e11
9E0E  E9 DE 00        jmp 0x9eef
loc_9E11:
9E11  89 46 FC        mov word ptr [bp - 4], ax
9E14  EB 03           jmp 0x9e19
loc_9E16:
9E16  FF 46 FC        inc word ptr [bp - 4]
loc_9E19:
9E19  8B 46 FA        mov ax, word ptr [bp - 6]
9E1C  D1 E0           shl ax, 1
9E1E  C4 7E F6        les di, ptr [bp - 0xa]
9E21  03 F8           add di, ax
9E23  26 FF 75 FE     push word ptr es:[di - 2]
9E27  9A E9 4E 51 1B  call far 1B51:4EE9
9E2C  08 C0           or al, al
9E2E  74 03           je 0x9e33
9E30  E9 8A 00        jmp 0x9ebd
loc_9E33:
9E33  8B 46 FC        mov ax, word ptr [bp - 4]
9E36  D1 E0           shl ax, 1
9E38  C4 7E F6        les di, ptr [bp - 0xa]
9E3B  03 F8           add di, ax
9E3D  26 8B 45 FE     mov ax, word ptr es:[di - 2]
9E41  C1 E0 03        shl ax, 3
9E44  C4 3E BA D7     les di, ptr [0xd7ba]
9E48  03 F8           add di, ax
9E4A  26 80 7D 07 00  cmp byte ptr es:[di + 7], 0
9E4F  75 1E           jne 0x9e6f
9E51  8B 46 FA        mov ax, word ptr [bp - 6]
9E54  D1 E0           shl ax, 1
9E56  C4 7E F6        les di, ptr [bp - 0xa]
9E59  03 F8           add di, ax
9E5B  26 8B 45 FE     mov ax, word ptr es:[di - 2]
9E5F  C1 E0 03        shl ax, 3
9E62  C4 3E BA D7     les di, ptr [0xd7ba]
9E66  03 F8           add di, ax
9E68  26 80 7D 07 00  cmp byte ptr es:[di + 7], 0
9E6D  75 4E           jne 0x9ebd
loc_9E6F:
9E6F  8B 46 FC        mov ax, word ptr [bp - 4]
9E72  D1 E0           shl ax, 1
9E74  C4 7E F6        les di, ptr [bp - 0xa]
9E77  03 F8           add di, ax
9E79  26 8B 45 FE     mov ax, word ptr es:[di - 2]
9E7D  C1 E0 03        shl ax, 3
9E80  C4 3E BA D7     les di, ptr [0xd7ba]
9E84  03 F8           add di, ax
9E86  26 80 7D 07 00  cmp byte ptr es:[di + 7], 0
9E8B  75 57           jne 0x9ee4
9E8D  8B 46 FA        mov ax, word ptr [bp - 6]
9E90  D1 E0           shl ax, 1
9E92  C4 7E F6        les di, ptr [bp - 0xa]
9E95  03 F8           add di, ax
9E97  26 FF 75 FE     push word ptr es:[di - 2]
9E9B  6A 01           push 1
9E9D  9A AA 4A 51 1B  call far 1B51:4AAA
9EA2  50              push ax
9EA3  8B 46 FC        mov ax, word ptr [bp - 4]
9EA6  D1 E0           shl ax, 1
9EA8  C4 7E F6        les di, ptr [bp - 0xa]
9EAB  03 F8           add di, ax
9EAD  26 FF 75 FE     push word ptr es:[di - 2]
9EB1  6A 01           push 1
9EB3  9A AA 4A 51 1B  call far 1B51:4AAA
9EB8  5A              pop dx
9EB9  3B C2           cmp ax, dx
9EBB  76 27           jbe 0x9ee4
loc_9EBD:
9EBD  8B 46 FC        mov ax, word ptr [bp - 4]
9EC0  D1 E0           shl ax, 1
9EC2  C4 7E F6        les di, ptr [bp - 0xa]
9EC5  03 F8           add di, ax
9EC7  81 C7 FE FF     add di, 0xfffe
9ECB  06              push es
9ECC  57              push di
9ECD  8B 46 FA        mov ax, word ptr [bp - 6]
9ED0  D1 E0           shl ax, 1
9ED2  C4 7E F6        les di, ptr [bp - 0xa]
9ED5  03 F8           add di, ax
9ED7  81 C7 FE FF     add di, 0xfffe
9EDB  06              push es
9EDC  57              push di
9EDD  6A 02           push 2
9EDF  9A 03 02 AC 24  call far 24AC:0203
loc_9EE4:
9EE4  8B 46 FC        mov ax, word ptr [bp - 4]
9EE7  3B 46 F4        cmp ax, word ptr [bp - 0xc]
9EEA  74 03           je 0x9eef
9EEC  E9 27 FF        jmp 0x9e16
loc_9EEF:
9EEF  C9              leave
9EF0  C2 02 00        ret 2

; ---- routine 0AB5:9EF3  (found by: call)
sub_9EF3:
9EF3  C8 08 00 00     enter 8, 0
9EF7  6B 46 04 3E     imul ax, word ptr [bp + 4], 0x3e
9EFB  C4 3E C2 D7     les di, ptr [0xd7c2]
9EFF  03 F8           add di, ax
9F01  81 C7 C2 FF     add di, 0xffc2
9F05  89 7E FA        mov word ptr [bp - 6], di
9F08  8C 46 FC        mov word ptr [bp - 4], es
9F0B  26 8A 45 32     mov al, byte ptr es:[di + 0x32]
9F0F  30 E4           xor ah, ah
9F11  89 46 F8        mov word ptr [bp - 8], ax
9F14  B8 01 00        mov ax, 1
9F17  3B 46 F8        cmp ax, word ptr [bp - 8]
9F1A  77 4E           ja 0x9f6a
9F1C  89 46 FE        mov word ptr [bp - 2], ax
9F1F  EB 03           jmp 0x9f24
loc_9F21:
9F21  FF 46 FE        inc word ptr [bp - 2]
loc_9F24:
9F24  8B 46 FE        mov ax, word ptr [bp - 2]
9F27  D1 E0           shl ax, 1
9F29  C4 7E FA        les di, ptr [bp - 6]
9F2C  03 F8           add di, ax
9F2E  26 83 7D FE 00  cmp word ptr es:[di - 2], 0
9F33  74 2D           je 0x9f62
9F35  8B 46 FE        mov ax, word ptr [bp - 2]
9F38  D1 E0           shl ax, 1
9F3A  C4 7E FA        les di, ptr [bp - 6]
9F3D  03 F8           add di, ax
9F3F  26 6B 45 FE 0F  imul ax, word ptr es:[di - 2], 0xf
9F44  C4 3E BE D7     les di, ptr [0xd7be]
9F48  03 F8           add di, ax
9F4A  26 C6 45 0A 00  mov byte ptr es:[di + 0xa], 0
9F4F  8B 46 FE        mov ax, word ptr [bp - 2]
9F52  D1 E0           shl ax, 1
9F54  C4 7E FA        les di, ptr [bp - 6]
9F57  03 F8           add di, ax
9F59  26 FF 75 FE     push word ptr es:[di - 2]
9F5D  9A 5B 53 51 1B  call far 1B51:535B
loc_9F62:
9F62  8B 46 FE        mov ax, word ptr [bp - 2]
9F65  3B 46 F8        cmp ax, word ptr [bp - 8]
9F68  75 B7           jne 0x9f21
loc_9F6A:
9F6A  C9              leave
9F6B  C2 02 00        ret 2

; ---- routine 0AB5:9F6E  (found by: call)
sub_9F6E:
9F6E  C8 0A 00 00     enter 0xa, 0
9F72  8B 46 06        mov ax, word ptr [bp + 6]
9F75  C1 E0 03        shl ax, 3
9F78  C4 3E BA D7     les di, ptr [0xd7ba]
9F7C  03 F8           add di, ax
9F7E  89 7E F6        mov word ptr [bp - 0xa], di
9F81  8C 46 F8        mov word ptr [bp - 8], es
9F84  26 8A 45 04     mov al, byte ptr es:[di + 4]
9F88  30 E4           xor ah, ah
9F8A  89 46 FA        mov word ptr [bp - 6], ax
9F8D  FF 46 FA        inc word ptr [bp - 6]
9F90  8B 56 04        mov dx, word ptr [bp + 4]
9F93  26 8A 45 07     mov al, byte ptr es:[di + 7]
9F97  30 E4           xor ah, ah
9F99  6B F8 16        imul di, ax, 0x16
9F9C  03 FA           add di, dx
9F9E  8A 85 7D 95     mov al, byte ptr [di - 0x6a83]
9FA2  30 E4           xor ah, ah
9FA4  8B D0           mov dx, ax
9FA6  C4 7E F6        les di, ptr [bp - 0xa]
9FA9  26 8A 45 05     mov al, byte ptr es:[di + 5]
9FAD  30 E4           xor ah, ah
9FAF  6B F8 16        imul di, ax, 0x16
9FB2  03 FA           add di, dx
9FB4  8A 85 B1 96     mov al, byte ptr [di - 0x694f]
9FB8  30 E4           xor ah, ah
9FBA  89 46 FC        mov word ptr [bp - 4], ax
9FBD  8B 46 FC        mov ax, word ptr [bp - 4]
9FC0  F7 66 FA        mul word ptr [bp - 6]
9FC3  C1 E8 05        shr ax, 5
9FC6  89 46 FE        mov word ptr [bp - 2], ax
9FC9  8B 46 FE        mov ax, word ptr [bp - 2]
9FCC  C9              leave
9FCD  C2 04 00        ret 4

; ---- routine 0AB5:9FD0  (found by: call)
sub_9FD0:
9FD0  C8 06 00 00     enter 6, 0
9FD4  BF 72 3D        mov di, 0x3d72
9FD7  1E              push ds
9FD8  57              push di
9FD9  BF 5C DD        mov di, 0xdd5c
9FDC  1E              push ds
9FDD  57              push di
9FDE  9A 2F 05 1A 23  call far 231A:052F
9FE3  C7 46 FE 01 00  mov word ptr [bp - 2], 1
9FE8  EB 03           jmp 0x9fed
loc_9FEA:
9FEA  FF 46 FE        inc word ptr [bp - 2]
loc_9FED:
9FED  8B 46 FE        mov ax, word ptr [bp - 2]
9FF0  D1 E0           shl ax, 1
9FF2  C4 7E 06        les di, ptr [bp + 6]
9FF5  03 F8           add di, ax
9FF7  26 FF 75 FE     push word ptr es:[di - 2]
9FFB  8B 46 FE        mov ax, word ptr [bp - 2]
9FFE  40              inc ax
9FFF  50              push ax
A000  6A 3C           push 0x3c
A002  9A 51 1F 51 1B  call far 1B51:1F51
A007  83 7E FE 0B     cmp word ptr [bp - 2], 0xb
A00B  75 DD           jne 0x9fea
A00D  C7 46 FE 0C 00  mov word ptr [bp - 2], 0xc
A012  EB 03           jmp 0xa017
loc_A014:
A014  FF 46 FE        inc word ptr [bp - 2]
loc_A017:
A017  8B 46 FE        mov ax, word ptr [bp - 2]
A01A  D1 E0           shl ax, 1
A01C  C4 7E 06        les di, ptr [bp + 6]
A01F  03 F8           add di, ax
A021  26 FF 75 FE     push word ptr es:[di - 2]
A025  8B 46 FE        mov ax, word ptr [bp - 2]
A028  40              inc ax
A029  40              inc ax
A02A  50              push ax
A02B  6A 3C           push 0x3c
A02D  9A 51 1F 51 1B  call far 1B51:1F51
A032  83 7E FE 0E     cmp word ptr [bp - 2], 0xe
A036  75 DC           jne 0xa014
A038  C7 46 FE 0F 00  mov word ptr [bp - 2], 0xf
A03D  EB 03           jmp 0xa042
loc_A03F:
A03F  FF 46 FE        inc word ptr [bp - 2]
loc_A042:
A042  8B 46 FE        mov ax, word ptr [bp - 2]
A045  D1 E0           shl ax, 1
A047  C4 7E 06        les di, ptr [bp + 6]
A04A  03 F8           add di, ax
A04C  26 FF 75 FE     push word ptr es:[di - 2]
A050  8B 46 FE        mov ax, word ptr [bp - 2]
A053  05 03 00        add ax, 3
A056  50              push ax
A057  6A 3C           push 0x3c
A059  9A 51 1F 51 1B  call far 1B51:1F51
A05E  83 7E FE 14     cmp word ptr [bp - 2], 0x14
A062  75 DB           jne 0xa03f
A064  C9              leave
A065  CA 04 00        retf 4
; data (not reached as code), 60 bytes
A068                  pstr "You can't sack trialists"
A081                  pstr 'Get rid of '
A08D                  pstr 'It will cost you '
A09F                  pstr '. Ok'

