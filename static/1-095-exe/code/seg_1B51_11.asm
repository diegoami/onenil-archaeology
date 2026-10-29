; 1-095.EXE (One-Nil 95), code segment 1B51 (image offsets 1B510..2305F), part 11 of 12
; packed 1-095.EXE sha256 f659fb2d334500d6901fc8d6a0f06c85c0ccda2eb4a3035ae3bb0a0004d79192 (LZEXE 0.91)
; unpacked (tools/static/unlzexe.py) sha256 8df646e017e0965a5d90a58181ca764219ad847833aad0b6cb58fc53372bfb2c
; tool: capstone 5.0.9 (pip package; core library 5.0.1280) (CS_ARCH_X86, CS_MODE_16), recursive descent from the entry point, far calls and near calls/jumps, then routine prologues (55 89 E5 / 55 8B EC / C8 iw 00) in what remains; tools/static/listing.py
; addresses are SEGMENT:OFFSET with SEGMENT the image paragraph before relocation; image offset = SEGMENT*16+OFFSET
; ---- routine 1B51:70A5  (found by: far)
sub_70A5:
70A5  C8 0E 00 00     enter 0xe, 0
70A9  C7 46 FA 01 00  mov word ptr [bp - 6], 1
70AE  C6 46 F9 00     mov byte ptr [bp - 7], 0
70B2  EB 03           jmp 0x70b7
loc_70B4:
70B4  FE 46 F9        inc byte ptr [bp - 7]
loc_70B7:
70B7  31 C0           xor ax, ax
70B9  89 46 FE        mov word ptr [bp - 2], ax
70BC  8B 46 FA        mov ax, word ptr [bp - 6]
70BF  05 0F 00        add ax, 0xf
70C2  89 46 F6        mov word ptr [bp - 0xa], ax
70C5  8B 46 FA        mov ax, word ptr [bp - 6]
70C8  3B 46 F6        cmp ax, word ptr [bp - 0xa]
70CB  77 75           ja 0x7142
70CD  89 46 FC        mov word ptr [bp - 4], ax
70D0  EB 03           jmp 0x70d5
loc_70D2:
70D2  FF 46 FC        inc word ptr [bp - 4]
loc_70D5:
70D5  8B 7E FC        mov di, word ptr [bp - 4]
70D8  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
70DC  30 E4           xor ah, ah
70DE  6B C0 3E        imul ax, ax, 0x3e
70E1  C4 3E C2 D7     les di, ptr [0xd7c2]
70E5  03 F8           add di, ax
70E7  81 C7 C2 FF     add di, 0xffc2
70EB  26 8A 45 35     mov al, byte ptr es:[di + 0x35]
70EF  30 E4           xor ah, ah
70F1  3B 46 FE        cmp ax, word ptr [bp - 2]
70F4  76 44           jbe 0x713a
70F6  26 8A 45 35     mov al, byte ptr es:[di + 0x35]
70FA  30 E4           xor ah, ah
70FC  89 46 FE        mov word ptr [bp - 2], ax
70FF  8B 7E FC        mov di, word ptr [bp - 4]
7102  8A 95 D5 D7     mov dl, byte ptr [di - 0x282b]
7106  8A 46 F9        mov al, byte ptr [bp - 7]
7109  98              cwde
710A  C4 3E D2 D7     les di, ptr [0xd7d2]
710E  03 F8           add di, ax
7110  26 88 55 21     mov byte ptr es:[di + 0x21], dl
7114  8B 7E FC        mov di, word ptr [bp - 4]
7117  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
711B  30 E4           xor ah, ah
711D  6B C0 3E        imul ax, ax, 0x3e
7120  C4 3E C2 D7     les di, ptr [0xd7c2]
7124  03 F8           add di, ax
7126  26 8B 55 EA     mov dx, word ptr es:[di - 0x16]
712A  8A 46 F9        mov al, byte ptr [bp - 7]
712D  98              cwde
712E  D1 E0           shl ax, 1
7130  C4 3E D2 D7     les di, ptr [0xd7d2]
7134  03 F8           add di, ax
7136  26 89 55 26     mov word ptr es:[di + 0x26], dx
loc_713A:
713A  8B 46 FC        mov ax, word ptr [bp - 4]
713D  3B 46 F6        cmp ax, word ptr [bp - 0xa]
7140  75 90           jne 0x70d2
loc_7142:
7142  83 46 FA 10     add word ptr [bp - 6], 0x10
7146  8A 46 F9        mov al, byte ptr [bp - 7]
7149  98              cwde
714A  C4 3E D2 D7     les di, ptr [0xd7d2]
714E  03 F8           add di, ax
7150  26 8A 45 21     mov al, byte ptr es:[di + 0x21]
7154  30 E4           xor ah, ah
7156  50              push ax
7157  6A 04           push 4
7159  0E              push cs
715A  E8 92 D8        call 0x49ef
715D  80 7E F9 04     cmp byte ptr [bp - 7], 4
7161  74 03           je 0x7166
7163  E9 4E FF        jmp 0x70b4
loc_7166:
7166  C7 46 FC 01 00  mov word ptr [bp - 4], 1
716B  EB 03           jmp 0x7170
loc_716D:
716D  FF 46 FC        inc word ptr [bp - 4]
loc_7170:
7170  6B 46 FC 3E     imul ax, word ptr [bp - 4], 0x3e
7174  C4 3E C2 D7     les di, ptr [0xd7c2]
7178  03 F8           add di, ax
717A  26 C6 45 F7 00  mov byte ptr es:[di - 9], 0
717F  81 7E FC B0 00  cmp word ptr [bp - 4], 0xb0
7184  75 E7           jne 0x716d
7186  E8 48 FE        call 0x6fd1
7189  C9              leave
718A  CB              retf

; ---- routine 1B51:718B  (found by: call, far)
sub_718B:
718B  C8 0A 00 00     enter 0xa, 0
718F  6B 46 08 0F     imul ax, word ptr [bp + 8], 0xf
7193  C4 3E BE D7     les di, ptr [0xd7be]
7197  03 F8           add di, ax
7199  89 7E FA        mov word ptr [bp - 6], di
719C  8C 46 FC        mov word ptr [bp - 4], es
719F  8B 46 08        mov ax, word ptr [bp + 8]
71A2  C1 E0 03        shl ax, 3
71A5  C4 3E BA D7     les di, ptr [0xd7ba]
71A9  03 F8           add di, ax
71AB  C4 7E FA        les di, ptr [bp - 6]
71AE  26 80 7D 08 00  cmp byte ptr es:[di + 8], 0
71B3  75 06           jne 0x71bb
71B5  C6 46 FF 06     mov byte ptr [bp - 1], 6
71B9  EB 55           jmp 0x7210
loc_71BB:
71BB  6A 08           push 8
71BD  C4 7E FA        les di, ptr [bp - 6]
71C0  26 8A 45 0B     mov al, byte ptr es:[di + 0xb]
71C4  30 E4           xor ah, ah
71C6  50              push ax
71C7  9A 59 02 AC 24  call far 24AC:0259
71CC  08 C0           or al, al
71CE  75 15           jne 0x71e5
71D0  6A 06           push 6
71D2  C4 7E FA        les di, ptr [bp - 6]
71D5  26 8A 45 0B     mov al, byte ptr es:[di + 0xb]
71D9  30 E4           xor ah, ah
71DB  50              push ax
71DC  9A 59 02 AC 24  call far 24AC:0259
71E1  08 C0           or al, al
71E3  74 06           je 0x71eb
loc_71E5:
71E5  C6 46 FF 05     mov byte ptr [bp - 1], 5
71E9  EB 25           jmp 0x7210
loc_71EB:
71EB  6A 02           push 2
71ED  C4 7E FA        les di, ptr [bp - 6]
71F0  26 8A 45 0B     mov al, byte ptr es:[di + 0xb]
71F4  30 E4           xor ah, ah
71F6  50              push ax
71F7  9A 59 02 AC 24  call far 24AC:0259
71FC  08 C0           or al, al
71FE  74 06           je 0x7206
7200  C6 46 FF 04     mov byte ptr [bp - 1], 4
7204  EB 0A           jmp 0x7210
loc_7206:
7206  8B 7E 06        mov di, word ptr [bp + 6]
7209  8A 85 08 87     mov al, byte ptr [di - 0x78f8]
720D  88 46 FF        mov byte ptr [bp - 1], al
loc_7210:
7210  8A 46 FF        mov al, byte ptr [bp - 1]
7213  C9              leave
7214  CA 04 00        retf 4

; ---- routine 1B51:7217  (found by: call)
sub_7217:
7217  C8 06 00 00     enter 6, 0
721B  80 7E 0A 08     cmp byte ptr [bp + 0xa], 8
721F  75 48           jne 0x7269
7221  8B 7E 04        mov di, word ptr [bp + 4]
7224  36 FF 75 08     push word ptr ss:[di + 8]
7228  6A 30           push 0x30
722A  6A 35           push 0x35
722C  0E              push cs
722D  E8 0A A8        call 0x1a3a
7230  08 C0           or al, al
7232  74 0C           je 0x7240
7234  8B 7E 04        mov di, word ptr [bp + 4]
7237  36 8B 45 08     mov ax, word ptr ss:[di + 8]
723B  89 46 FE        mov word ptr [bp - 2], ax
723E  EB 27           jmp 0x7267
loc_7240:
7240  8B 7E 04        mov di, word ptr [bp + 4]
7243  36 8B 45 06     mov ax, word ptr ss:[di + 6]
7247  8B F0           mov si, ax
7249  D1 E0           shl ax, 1
724B  01 F0           add ax, si
724D  8B D0           mov dx, ax
724F  36 69 45 08 AE 00 imul ax, word ptr ss:[di + 8], 0xae
7255  C4 3E CA D7     les di, ptr [0xd7ca]
7259  03 F8           add di, ax
725B  03 FA           add di, dx
725D  26 8A 85 50 FF  mov al, byte ptr es:[di - 0xb0]
7262  30 E4           xor ah, ah
7264  89 46 FE        mov word ptr [bp - 2], ax
loc_7267:
7267  EB 46           jmp 0x72af
loc_7269:
7269  8B 7E 04        mov di, word ptr [bp + 4]
726C  36 FF 75 08     push word ptr ss:[di + 8]
7270  36 FF 75 06     push word ptr ss:[di + 6]
7274  0E              push cs
7275  E8 1D A4        call 0x1695
7278  08 C0           or al, al
727A  74 0C           je 0x7288
727C  8B 7E 04        mov di, word ptr [bp + 4]
727F  36 8B 45 08     mov ax, word ptr ss:[di + 8]
7283  89 46 FE        mov word ptr [bp - 2], ax
7286  EB 27           jmp 0x72af
loc_7288:
7288  8B 7E 04        mov di, word ptr [bp + 4]
728B  36 8B 45 06     mov ax, word ptr ss:[di + 6]
728F  8B F0           mov si, ax
7291  D1 E0           shl ax, 1
7293  01 F0           add ax, si
7295  8B D0           mov dx, ax
7297  36 69 45 08 AE 00 imul ax, word ptr ss:[di + 8], 0xae
729D  C4 3E CA D7     les di, ptr [0xd7ca]
72A1  03 F8           add di, ax
72A3  03 FA           add di, dx
72A5  26 8A 85 50 FF  mov al, byte ptr es:[di - 0xb0]
72AA  30 E4           xor ah, ah
72AC  89 46 FE        mov word ptr [bp - 2], ax
loc_72AF:
72AF  FF 76 FE        push word ptr [bp - 2]
72B2  FF 76 06        push word ptr [bp + 6]
72B5  0E              push cs
72B6  E8 C3 D7        call 0x4a7c
72B9  6B 46 FE 3E     imul ax, word ptr [bp - 2], 0x3e
72BD  C4 3E C2 D7     les di, ptr [0xd7c2]
72C1  03 F8           add di, ax
72C3  81 C7 C2 FF     add di, 0xffc2
72C7  8A 46 08        mov al, byte ptr [bp + 8]
72CA  26 88 45 38     mov byte ptr es:[di + 0x38], al
72CE  FF 76 FE        push word ptr [bp - 2]
72D1  0E              push cs
72D2  E8 05 9B        call 0xdda
72D5  08 C0           or al, al
72D7  74 39           je 0x7312
72D9  A0 BA DC        mov al, byte ptr [0xdcba]
72DC  30 E4           xor ah, ah
72DE  3B 46 FE        cmp ax, word ptr [bp - 2]
72E1  B0 00           mov al, 0
72E3  74 01           je 0x72e6
72E5  40              inc ax
loc_72E6:
72E6  30 E4           xor ah, ah
72E8  40              inc ax
72E9  50              push ax
72EA  8A 46 0A        mov al, byte ptr [bp + 0xa]
72ED  50              push ax
72EE  0E              push cs
72EF  E8 CE FB        call 0x6ec0
72F2  A0 BA DC        mov al, byte ptr [0xdcba]
72F5  30 E4           xor ah, ah
72F7  3B 46 FE        cmp ax, word ptr [bp - 2]
72FA  B0 00           mov al, 0
72FC  74 01           je 0x72ff
72FE  40              inc ax
loc_72FF:
72FF  30 E4           xor ah, ah
7301  40              inc ax
7302  50              push ax
7303  8B 7E 04        mov di, word ptr [bp + 4]
7306  36 FF 75 06     push word ptr ss:[di + 6]
730A  8A 46 0A        mov al, byte ptr [bp + 0xa]
730D  50              push ax
730E  0E              push cs
730F  E8 FF C0        call 0x3411
loc_7312:
7312  C9              leave
7313  C2 08 00        ret 8

; ---- routine 1B51:7316  (found by: far)
sub_7316:
7316  C8 04 00 00     enter 4, 0
731A  C4 3E D2 D7     les di, ptr [0xd7d2]
731E  26 8A 05        mov al, byte ptr es:[di]
7321  3C 25           cmp al, 0x25
7323  75 0C           jne 0x7331
7325  6A 03           push 3
7327  6A 08           push 8
7329  6A 02           push 2
732B  55              push bp
732C  E8 E8 FE        call 0x7217
732F  EB 3E           jmp 0x736f
loc_7331:
7331  3C 33           cmp al, 0x33
7333  75 0C           jne 0x7341
7335  6A 04           push 4
7337  6A 07           push 7
7339  6A 02           push 2
733B  55              push bp
733C  E8 D8 FE        call 0x7217
733F  EB 2E           jmp 0x736f
loc_7341:
7341  3C 30           cmp al, 0x30
7343  75 0C           jne 0x7351
7345  6A 07           push 7
7347  6A 07           push 7
7349  6A 04           push 4
734B  55              push bp
734C  E8 C8 FE        call 0x7217
734F  EB 1E           jmp 0x736f
loc_7351:
7351  3C 35           cmp al, 0x35
7353  75 0C           jne 0x7361
7355  6A 08           push 8
7357  6A 08           push 8
7359  6A 04           push 4
735B  55              push bp
735C  E8 B8 FE        call 0x7217
735F  EB 0E           jmp 0x736f
loc_7361:
7361  3C 39           cmp al, 0x39
7363  75 0A           jne 0x736f
7365  6A 06           push 6
7367  6A 06           push 6
7369  6A 06           push 6
736B  55              push bp
736C  E8 A8 FE        call 0x7217
loc_736F:
736F  C9              leave
7370  CA 04 00        retf 4

; ---- routine 1B51:7373  (found by: call)
sub_7373:
7373  C8 02 00 00     enter 2, 0
7377  C7 46 FE 12 00  mov word ptr [bp - 2], 0x12
loc_737C:
737C  8B 7E FE        mov di, word ptr [bp - 2]
737F  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
7383  30 E4           xor ah, ah
7385  6B C0 3E        imul ax, ax, 0x3e
7388  C4 3E C2 D7     les di, ptr [0xd7c2]
738C  03 F8           add di, ax
738E  26 8A 45 FA     mov al, byte ptr es:[di - 6]
7392  3A 46 06        cmp al, byte ptr [bp + 6]
7395  7F 05           jg 0x739c
7397  FF 46 FE        inc word ptr [bp - 2]
739A  EB E0           jmp 0x737c
loc_739C:
739C  8A 56 06        mov dl, byte ptr [bp + 6]
739F  8B 7E FE        mov di, word ptr [bp - 2]
73A2  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
73A6  30 E4           xor ah, ah
73A8  6B C0 3E        imul ax, ax, 0x3e
73AB  C4 3E C2 D7     les di, ptr [0xd7c2]
73AF  03 F8           add di, ax
73B1  26 88 55 FA     mov byte ptr es:[di - 6], dl
73B5  C9              leave
73B6  C2 04 00        ret 4

; ---- routine 1B51:73B9  (found by: call)
sub_73B9:
73B9  C8 08 00 00     enter 8, 0
73BD  C4 3E BC DC     les di, ptr [0xdcbc]
73C1  8A 46 08        mov al, byte ptr [bp + 8]
73C4  98              cwde
73C5  D1 E0           shl ax, 1
73C7  03 F8           add di, ax
73C9  26 8A 45 FA     mov al, byte ptr es:[di - 6]
73CD  30 E4           xor ah, ah
73CF  6B C0 3E        imul ax, ax, 0x3e
73D2  C4 3E C2 D7     les di, ptr [0xd7c2]
73D6  03 F8           add di, ax
73D8  81 C7 C2 FF     add di, 0xffc2
73DC  26 8A 45 38     mov al, byte ptr es:[di + 0x38]
73E0  3A 46 06        cmp al, byte ptr [bp + 6]
73E3  7E 07           jle 0x73ec
73E5  8A 46 06        mov al, byte ptr [bp + 6]
73E8  26 88 45 38     mov byte ptr es:[di + 0x38], al
loc_73EC:
73EC  C9              leave
73ED  C2 06 00        ret 6

; ---- routine 1B51:73F0  (found by: far)
sub_73F0:
73F0  C8 0A 00 00     enter 0xa, 0
73F4  C4 3E BC DC     les di, ptr [0xdcbc]
73F8  89 7E FA        mov word ptr [bp - 6], di
73FB  8C 46 FC        mov word ptr [bp - 4], es
73FE  26 8A 45 03     mov al, byte ptr es:[di + 3]
7402  30 E4           xor ah, ah
7404  89 46 FE        mov word ptr [bp - 2], ax
7407  6B 46 FE 3E     imul ax, word ptr [bp - 2], 0x3e
740B  C4 3E C2 D7     les di, ptr [0xd7c2]
740F  03 F8           add di, ax
7411  81 C7 C2 FF     add di, 0xffc2
7415  26 80 7D 38 06  cmp byte ptr es:[di + 0x38], 6
741A  74 0A           je 0x7426
741C  A0 E6 D7        mov al, byte ptr [0xd7e6]
741F  30 E4           xor ah, ah
7421  3B 46 FE        cmp ax, word ptr [bp - 2]
7424  75 08           jne 0x742e
loc_7426:
7426  6A 04           push 4
7428  6A 07           push 7
742A  55              push bp
742B  E8 8B FF        call 0x73b9
loc_742E:
742E  C4 7E FA        les di, ptr [bp - 6]
7431  26 8A 45 01     mov al, byte ptr es:[di + 1]
7435  30 E4           xor ah, ah
7437  89 46 FE        mov word ptr [bp - 2], ax
743A  6B 46 FE 3E     imul ax, word ptr [bp - 2], 0x3e
743E  C4 3E C2 D7     les di, ptr [0xd7c2]
7442  03 F8           add di, ax
7444  81 C7 C2 FF     add di, 0xffc2
7448  26 80 7D 38 08  cmp byte ptr es:[di + 0x38], 8
744D  7C 0A           jl 0x7459
744F  A0 E6 D7        mov al, byte ptr [0xd7e6]
7452  30 E4           xor ah, ah
7454  3B 46 FE        cmp ax, word ptr [bp - 2]
7457  75 08           jne 0x7461
loc_7459:
7459  6A 03           push 3
745B  6A 08           push 8
745D  55              push bp
745E  E8 58 FF        call 0x73b9
loc_7461:
7461  A0 E7 D7        mov al, byte ptr [0xd7e7]
7464  30 E4           xor ah, ah
7466  6B C0 3E        imul ax, ax, 0x3e
7469  C4 3E C2 D7     les di, ptr [0xd7c2]
746D  03 F8           add di, ax
746F  81 C7 C2 FF     add di, 0xffc2
7473  26 80 7D 38 08  cmp byte ptr es:[di + 0x38], 8
7478  7F 06           jg 0x7480
747A  6A 08           push 8
747C  55              push bp
747D  E8 F3 FE        call 0x7373
loc_7480:
7480  C9              leave
7481  CB              retf

; ---- routine 1B51:7482  (found by: call)
sub_7482:
7482  C8 08 00 00     enter 8, 0
7486  8B 46 08        mov ax, word ptr [bp + 8]
7489  89 46 FE        mov word ptr [bp - 2], ax
748C  8B 46 06        mov ax, word ptr [bp + 6]
748F  89 46 FC        mov word ptr [bp - 4], ax
7492  8B 46 08        mov ax, word ptr [bp + 8]
7495  03 46 06        add ax, word ptr [bp + 6]
7498  D1 E8           shr ax, 1
749A  D1 E0           shl ax, 1
749C  8B 7E 04        mov di, word ptr [bp + 4]
749F  36 C4 7D 08     les di, ptr ss:[di + 8]
74A3  03 F8           add di, ax
74A5  26 8B 45 FE     mov ax, word ptr es:[di - 2]
74A9  C1 E0 03        shl ax, 3
74AC  C4 3E BA D7     les di, ptr [0xd7ba]
74B0  03 F8           add di, ax
74B2  26 8A 45 06     mov al, byte ptr es:[di + 6]
74B6  30 E4           xor ah, ah
74B8  89 46 F8        mov word ptr [bp - 8], ax
loc_74BB:
74BB  8B 46 FE        mov ax, word ptr [bp - 2]
74BE  D1 E0           shl ax, 1
74C0  8B 7E 04        mov di, word ptr [bp + 4]
74C3  36 C4 7D 08     les di, ptr ss:[di + 8]
74C7  03 F8           add di, ax
74C9  26 8B 45 FE     mov ax, word ptr es:[di - 2]
74CD  C1 E0 03        shl ax, 3
74D0  C4 3E BA D7     les di, ptr [0xd7ba]
74D4  03 F8           add di, ax
74D6  26 8A 45 06     mov al, byte ptr es:[di + 6]
74DA  30 E4           xor ah, ah
74DC  3B 46 F8        cmp ax, word ptr [bp - 8]
74DF  73 05           jae 0x74e6
74E1  FF 46 FE        inc word ptr [bp - 2]
74E4  EB D5           jmp 0x74bb
loc_74E6:
74E6  8B 46 FC        mov ax, word ptr [bp - 4]
74E9  D1 E0           shl ax, 1
74EB  8B 7E 04        mov di, word ptr [bp + 4]
74EE  36 C4 7D 08     les di, ptr ss:[di + 8]
74F2  03 F8           add di, ax
74F4  26 8B 45 FE     mov ax, word ptr es:[di - 2]
74F8  C1 E0 03        shl ax, 3
74FB  C4 3E BA D7     les di, ptr [0xd7ba]
74FF  03 F8           add di, ax
7501  26 8A 45 06     mov al, byte ptr es:[di + 6]
7505  30 E4           xor ah, ah
7507  3B 46 F8        cmp ax, word ptr [bp - 8]
750A  76 05           jbe 0x7511
750C  FF 4E FC        dec word ptr [bp - 4]
750F  EB D5           jmp 0x74e6
loc_7511:
7511  8B 46 FE        mov ax, word ptr [bp - 2]
7514  3B 46 FC        cmp ax, word ptr [bp - 4]
7517  77 77           ja 0x7590
7519  8B 46 FE        mov ax, word ptr [bp - 2]
751C  D1 E0           shl ax, 1
751E  8B 7E 04        mov di, word ptr [bp + 4]
7521  36 C4 7D 08     les di, ptr ss:[di + 8]
7525  03 F8           add di, ax
7527  26 8B 45 FE     mov ax, word ptr es:[di - 2]
752B  89 46 FA        mov word ptr [bp - 6], ax
752E  8B 46 FC        mov ax, word ptr [bp - 4]
7531  D1 E0           shl ax, 1
7533  8B 7E 04        mov di, word ptr [bp + 4]
7536  36 C4 7D 08     les di, ptr ss:[di + 8]
753A  03 F8           add di, ax
753C  26 8B 55 FE     mov dx, word ptr es:[di - 2]
7540  8B 46 FE        mov ax, word ptr [bp - 2]
7543  D1 E0           shl ax, 1
7545  8B 7E 04        mov di, word ptr [bp + 4]
7548  36 C4 7D 08     les di, ptr ss:[di + 8]
754C  03 F8           add di, ax
754E  26 89 55 FE     mov word ptr es:[di - 2], dx
7552  8B 56 FA        mov dx, word ptr [bp - 6]
7555  8B 46 FC        mov ax, word ptr [bp - 4]
7558  D1 E0           shl ax, 1
755A  8B 7E 04        mov di, word ptr [bp + 4]
755D  36 C4 7D 08     les di, ptr ss:[di + 8]
7561  03 F8           add di, ax
7563  26 89 55 FE     mov word ptr es:[di - 2], dx
7567  8B 46 FE        mov ax, word ptr [bp - 2]
756A  8B 7E 04        mov di, word ptr [bp + 4]
756D  03 F8           add di, ax
756F  81 C7 F3 FF     add di, 0xfff3
7573  16              push ss
7574  57              push di
7575  8B 46 FC        mov ax, word ptr [bp - 4]
7578  8B 7E 04        mov di, word ptr [bp + 4]
757B  03 F8           add di, ax
757D  81 C7 F3 FF     add di, 0xfff3
7581  16              push ss
7582  57              push di
7583  6A 01           push 1
7585  9A 03 02 AC 24  call far 24AC:0203
758A  FF 46 FE        inc word ptr [bp - 2]
758D  FF 4E FC        dec word ptr [bp - 4]
loc_7590:
7590  8B 46 FE        mov ax, word ptr [bp - 2]
7593  3B 46 FC        cmp ax, word ptr [bp - 4]
7596  77 03           ja 0x759b
7598  E9 20 FF        jmp 0x74bb
loc_759B:
759B  8B 46 08        mov ax, word ptr [bp + 8]
759E  3B 46 FC        cmp ax, word ptr [bp - 4]
75A1  73 0D           jae 0x75b0
75A3  FF 76 08        push word ptr [bp + 8]
75A6  FF 76 FC        push word ptr [bp - 4]
75A9  8B 7E 04        mov di, word ptr [bp + 4]
75AC  57              push di
75AD  E8 D2 FE        call 0x7482
loc_75B0:
75B0  8B 46 FE        mov ax, word ptr [bp - 2]
75B3  3B 46 06        cmp ax, word ptr [bp + 6]
75B6  73 0D           jae 0x75c5
75B8  FF 76 FE        push word ptr [bp - 2]
75BB  FF 76 06        push word ptr [bp + 6]
75BE  8B 7E 04        mov di, word ptr [bp + 4]
75C1  57              push di
75C2  E8 BD FE        call 0x7482
loc_75C5:
75C5  C9              leave
75C6  C2 06 00        ret 6

; ---- routine 1B51:75C9  (found by: call)
sub_75C9:
75C9  C8 0C 00 00     enter 0xc, 0
75CD  8B 46 06        mov ax, word ptr [bp + 6]
75D0  89 46 FA        mov word ptr [bp - 6], ax
75D3  8B 46 08        mov ax, word ptr [bp + 8]
75D6  40              inc ax
75D7  3B 46 FA        cmp ax, word ptr [bp - 6]
75DA  76 03           jbe 0x75df
75DC  E9 D5 00        jmp 0x76b4
loc_75DF:
75DF  89 46 FE        mov word ptr [bp - 2], ax
75E2  EB 03           jmp 0x75e7
loc_75E4:
75E4  FF 46 FE        inc word ptr [bp - 2]
loc_75E7:
75E7  8B 46 FE        mov ax, word ptr [bp - 2]
75EA  89 46 F8        mov word ptr [bp - 8], ax
75ED  8B 46 06        mov ax, word ptr [bp + 6]
75F0  3B 46 F8        cmp ax, word ptr [bp - 8]
75F3  73 03           jae 0x75f8
75F5  E9 B1 00        jmp 0x76a9
loc_75F8:
75F8  89 46 FC        mov word ptr [bp - 4], ax
75FB  EB 03           jmp 0x7600
loc_75FD:
75FD  FF 4E FC        dec word ptr [bp - 4]
loc_7600:
7600  8B 46 FC        mov ax, word ptr [bp - 4]
7603  48              dec ax
7604  D1 E0           shl ax, 1
7606  8B 7E 04        mov di, word ptr [bp + 4]
7609  36 C4 7D 08     les di, ptr ss:[di + 8]
760D  03 F8           add di, ax
760F  26 8B 45 FE     mov ax, word ptr es:[di - 2]
7613  C1 E0 03        shl ax, 3
7616  C4 3E BA D7     les di, ptr [0xd7ba]
761A  03 F8           add di, ax
761C  89 7E F4        mov word ptr [bp - 0xc], di
761F  8C 46 F6        mov word ptr [bp - 0xa], es
7622  8B 46 FC        mov ax, word ptr [bp - 4]
7625  D1 E0           shl ax, 1
7627  8B 7E 04        mov di, word ptr [bp + 4]
762A  36 C4 7D 08     les di, ptr ss:[di + 8]
762E  03 F8           add di, ax
7630  26 8B 45 FE     mov ax, word ptr es:[di - 2]
7634  C1 E0 03        shl ax, 3
7637  C4 3E BA D7     les di, ptr [0xd7ba]
763B  03 F8           add di, ax
763D  26 8A 45 06     mov al, byte ptr es:[di + 6]
7641  C4 7E F4        les di, ptr [bp - 0xc]
7644  26 3A 45 06     cmp al, byte ptr es:[di + 6]
7648  73 54           jae 0x769e
764A  8B 46 FC        mov ax, word ptr [bp - 4]
764D  8B 7E 04        mov di, word ptr [bp + 4]
7650  03 F8           add di, ax
7652  81 C7 F3 FF     add di, 0xfff3
7656  16              push ss
7657  57              push di
7658  8B 46 FC        mov ax, word ptr [bp - 4]
765B  48              dec ax
765C  8B 7E 04        mov di, word ptr [bp + 4]
765F  03 F8           add di, ax
7661  81 C7 F3 FF     add di, 0xfff3
7665  16              push ss
7666  57              push di
7667  6A 01           push 1
7669  9A 03 02 AC 24  call far 24AC:0203
766E  8B 46 FC        mov ax, word ptr [bp - 4]
7671  D1 E0           shl ax, 1
7673  8B 7E 04        mov di, word ptr [bp + 4]
7676  36 C4 7D 08     les di, ptr ss:[di + 8]
767A  03 F8           add di, ax
767C  81 C7 FE FF     add di, 0xfffe
7680  06              push es
7681  57              push di
7682  8B 46 FC        mov ax, word ptr [bp - 4]
7685  48              dec ax
7686  D1 E0           shl ax, 1
7688  8B 7E 04        mov di, word ptr [bp + 4]
768B  36 C4 7D 08     les di, ptr ss:[di + 8]
768F  03 F8           add di, ax
7691  81 C7 FE FF     add di, 0xfffe
7695  06              push es
7696  57              push di
7697  6A 02           push 2
7699  9A 03 02 AC 24  call far 24AC:0203
loc_769E:
769E  8B 46 FC        mov ax, word ptr [bp - 4]
76A1  3B 46 F8        cmp ax, word ptr [bp - 8]
76A4  74 03           je 0x76a9
76A6  E9 54 FF        jmp 0x75fd
loc_76A9:
76A9  8B 46 FE        mov ax, word ptr [bp - 2]
76AC  3B 46 FA        cmp ax, word ptr [bp - 6]
76AF  74 03           je 0x76b4
76B1  E9 30 FF        jmp 0x75e4
loc_76B4:
76B4  C9              leave
76B5  C2 06 00        ret 6

; ---- routine 1B51:76B8  (found by: call, far)
sub_76B8:
76B8  C8 12 00 00     enter 0x12, 0
76BC  C7 46 F2 01 00  mov word ptr [bp - 0xe], 1
76C1  EB 03           jmp 0x76c6
loc_76C3:
76C3  FF 46 F2        inc word ptr [bp - 0xe]
loc_76C6:
76C6  8B 46 F2        mov ax, word ptr [bp - 0xe]
76C9  D1 E0           shl ax, 1
76CB  C4 7E 08        les di, ptr [bp + 8]
76CE  03 F8           add di, ax
76D0  26 8B 45 FE     mov ax, word ptr es:[di - 2]
76D4  C1 E0 03        shl ax, 3
76D7  C4 3E BA D7     les di, ptr [0xd7ba]
76DB  03 F8           add di, ax
76DD  89 7E EE        mov word ptr [bp - 0x12], di
76E0  8C 46 F0        mov word ptr [bp - 0x10], es
76E3  26 8A 45 06     mov al, byte ptr es:[di + 6]
76E7  8B 7E F2        mov di, word ptr [bp - 0xe]
76EA  88 43 F3        mov byte ptr [bp + di - 0xd], al
76ED  8B 46 F2        mov ax, word ptr [bp - 0xe]
76F0  D1 E0           shl ax, 1
76F2  C4 7E 08        les di, ptr [bp + 8]
76F5  03 F8           add di, ax
76F7  26 83 7D FE 00  cmp word ptr es:[di - 2], 0
76FC  75 08           jne 0x7706
76FE  C4 7E EE        les di, ptr [bp - 0x12]
7701  26 C6 45 06 0E  mov byte ptr es:[di + 6], 0xe
loc_7706:
7706  83 7E F2 0B     cmp word ptr [bp - 0xe], 0xb
770A  75 B7           jne 0x76c3
770C  FF 76 06        push word ptr [bp + 6]
770F  0E              push cs
7710  E8 C7 96        call 0xdda
7713  08 C0           or al, al
7715  74 0A           je 0x7721
7717  6A 01           push 1
7719  6A 0B           push 0xb
771B  55              push bp
771C  E8 AA FE        call 0x75c9
771F  EB 08           jmp 0x7729
loc_7721:
7721  6A 01           push 1
7723  6A 0B           push 0xb
7725  55              push bp
7726  E8 59 FD        call 0x7482
loc_7729:
7729  C7 46 F2 01 00  mov word ptr [bp - 0xe], 1
772E  EB 03           jmp 0x7733
loc_7730:
7730  FF 46 F2        inc word ptr [bp - 0xe]
loc_7733:
7733  8B 46 F2        mov ax, word ptr [bp - 0xe]
7736  D1 E0           shl ax, 1
7738  C4 7E 08        les di, ptr [bp + 8]
773B  03 F8           add di, ax
773D  26 8B 45 FE     mov ax, word ptr es:[di - 2]
7741  C1 E0 03        shl ax, 3
7744  C4 3E BA D7     les di, ptr [0xd7ba]
7748  03 F8           add di, ax
774A  89 7E EE        mov word ptr [bp - 0x12], di
774D  8C 46 F0        mov word ptr [bp - 0x10], es
7750  8B 7E F2        mov di, word ptr [bp - 0xe]
7753  8A 43 F3        mov al, byte ptr [bp + di - 0xd]
7756  C4 7E EE        les di, ptr [bp - 0x12]
7759  26 88 45 06     mov byte ptr es:[di + 6], al
775D  83 7E F2 0B     cmp word ptr [bp - 0xe], 0xb
7761  75 CD           jne 0x7730
7763  C9              leave
7764  CA 06 00        retf 6

; ---- routine 1B51:7767  (found by: call)
sub_7767:
7767  C8 06 00 00     enter 6, 0
776B  8B 46 08        mov ax, word ptr [bp + 8]
776E  89 46 FE        mov word ptr [bp - 2], ax
7771  8B 46 06        mov ax, word ptr [bp + 6]
7774  89 46 FC        mov word ptr [bp - 4], ax
7777  8B 46 08        mov ax, word ptr [bp + 8]
777A  03 46 06        add ax, word ptr [bp + 6]
777D  D1 E8           shr ax, 1
777F  8B F8           mov di, ax
7781  8A 85 FB D4     mov al, byte ptr [di - 0x2b05]
7785  30 E4           xor ah, ah
7787  C1 E0 04        shl ax, 4
778A  C4 3E B2 D7     les di, ptr [0xd7b2]
778E  03 F8           add di, ax
7790  81 C7 F0 FF     add di, 0xfff0
7794  06              push es
7795  57              push di
7796  BF 92 D7        mov di, 0xd792
7799  1E              push ds
779A  57              push di
779B  6A 0F           push 0xf
779D  9A 6D 0B B9 26  call far 26B9:0B6D
loc_77A2:
77A2  8B 7E FE        mov di, word ptr [bp - 2]
77A5  8A 85 FB D4     mov al, byte ptr [di - 0x2b05]
77A9  30 E4           xor ah, ah
77AB  C1 E0 04        shl ax, 4
77AE  C4 3E B2 D7     les di, ptr [0xd7b2]
77B2  03 F8           add di, ax
77B4  81 C7 F0 FF     add di, 0xfff0
77B8  06              push es
77B9  57              push di
77BA  BF 92 D7        mov di, 0xd792
77BD  1E              push ds
77BE  57              push di
77BF  9A 44 0C B9 26  call far 26B9:0C44
77C4  73 05           jae 0x77cb
77C6  FF 46 FE        inc word ptr [bp - 2]
77C9  EB D7           jmp 0x77a2
loc_77CB:
77CB  BF 92 D7        mov di, 0xd792
77CE  1E              push ds
77CF  57              push di
77D0  8B 7E FC        mov di, word ptr [bp - 4]
77D3  8A 85 FB D4     mov al, byte ptr [di - 0x2b05]
77D7  30 E4           xor ah, ah
77D9  C1 E0 04        shl ax, 4
77DC  C4 3E B2 D7     les di, ptr [0xd7b2]
77E0  03 F8           add di, ax
77E2  81 C7 F0 FF     add di, 0xfff0
77E6  06              push es
77E7  57              push di
77E8  9A 44 0C B9 26  call far 26B9:0C44
77ED  73 05           jae 0x77f4
77EF  FF 4E FC        dec word ptr [bp - 4]
77F2  EB D7           jmp 0x77cb
loc_77F4:
77F4  8B 46 FE        mov ax, word ptr [bp - 2]
77F7  3B 46 FC        cmp ax, word ptr [bp - 4]
77FA  77 2A           ja 0x7826
77FC  8B 7E FE        mov di, word ptr [bp - 2]
77FF  8A 85 FB D4     mov al, byte ptr [di - 0x2b05]
7803  30 E4           xor ah, ah
7805  89 46 FA        mov word ptr [bp - 6], ax
7808  8B 7E FC        mov di, word ptr [bp - 4]
780B  8A 85 FB D4     mov al, byte ptr [di - 0x2b05]
780F  8B 7E FE        mov di, word ptr [bp - 2]
7812  88 85 FB D4     mov byte ptr [di - 0x2b05], al
7816  8A 46 FA        mov al, byte ptr [bp - 6]
7819  8B 7E FC        mov di, word ptr [bp - 4]
781C  88 85 FB D4     mov byte ptr [di - 0x2b05], al
7820  FF 46 FE        inc word ptr [bp - 2]
7823  FF 4E FC        dec word ptr [bp - 4]
loc_7826:
7826  8B 46 FE        mov ax, word ptr [bp - 2]
7829  3B 46 FC        cmp ax, word ptr [bp - 4]
782C  77 03           ja 0x7831
782E  E9 71 FF        jmp 0x77a2
loc_7831:
7831  8B 46 08        mov ax, word ptr [bp + 8]
7834  3B 46 FC        cmp ax, word ptr [bp - 4]
7837  73 0D           jae 0x7846
7839  FF 76 08        push word ptr [bp + 8]
783C  FF 76 FC        push word ptr [bp - 4]
783F  8B 7E 04        mov di, word ptr [bp + 4]
7842  57              push di
7843  E8 21 FF        call 0x7767
loc_7846:
7846  8B 46 FE        mov ax, word ptr [bp - 2]
7849  3B 46 06        cmp ax, word ptr [bp + 6]
784C  73 0D           jae 0x785b
784E  FF 76 FE        push word ptr [bp - 2]
7851  FF 76 06        push word ptr [bp + 6]
7854  8B 7E 04        mov di, word ptr [bp + 4]
7857  57              push di
7858  E8 0C FF        call 0x7767
loc_785B:
785B  C9              leave
785C  C2 06 00        ret 6

; ---- routine 1B51:785F  (found by: call, far)
sub_785F:
785F  C8 04 00 00     enter 4, 0
7863  FF 76 06        push word ptr [bp + 6]
7866  0E              push cs
7867  E8 10 C9        call 0x417a
786A  C7 46 FE 01 00  mov word ptr [bp - 2], 1
786F  EB 03           jmp 0x7874
loc_7871:
7871  FF 46 FE        inc word ptr [bp - 2]
loc_7874:
7874  8B 7E FE        mov di, word ptr [bp - 2]
7877  8A 85 27 13     mov al, byte ptr [di + 0x1327]
787B  30 E4           xor ah, ah
787D  50              push ax
787E  8B 7E FE        mov di, word ptr [bp - 2]
7881  8A 85 27 13     mov al, byte ptr [di + 0x1327]
7885  30 E4           xor ah, ah
7887  05 07 00        add ax, 7
788A  50              push ax
788B  55              push bp
788C  E8 D8 FE        call 0x7767
788F  83 7E FE 05     cmp word ptr [bp - 2], 5
7893  75 DC           jne 0x7871
7895  C9              leave
7896  CA 02 00        retf 2
; data (not reached as code), 2 bytes
7899                  db 01 2E   ; ..

; ---- routine 1B51:789B  (found by: call, far)
sub_789B:
789B  C8 00 01 00     enter 0x100, 0
789F  8D BE 00 FF     lea di, [bp - 0x100]
78A3  16              push ss
78A4  57              push di
78A5  BF 31 D7        mov di, 0xd731
78A8  1E              push ds
78A9  57              push di
78AA  6A 01           push 1
78AC  BF 99 78        mov di, 0x7899
78AF  0E              push cs
78B0  57              push di
78B1  BF 31 D7        mov di, 0xd731
78B4  1E              push ds
78B5  57              push di
78B6  9A FE 0B B9 26  call far 26B9:0BFE
78BB  48              dec ax
78BC  50              push ax
78BD  9A 91 0B B9 26  call far 26B9:0B91
78C2  C4 7E 06        les di, ptr [bp + 6]
78C5  06              push es
78C6  57              push di
78C7  6A 0F           push 0xf
78C9  9A 6D 0B B9 26  call far 26B9:0B6D
78CE  C9              leave
78CF  CB              retf
; data (not reached as code), 2 bytes
78D0                  db 01 2E   ; ..

; ---- routine 1B51:78D2  (found by: far)
sub_78D2:
78D2  C8 A8 02 00     enter 0x2a8, 0
78D6  C4 3E D2 D7     les di, ptr [0xd7d2]
78DA  89 BE 58 FF     mov word ptr [bp - 0xa8], di
78DE  8C 86 5A FF     mov word ptr [bp - 0xa6], es
78E2  26 FE 0D        dec byte ptr es:[di]
78E5  BF 3E D7        mov di, 0xd73e
78E8  1E              push ds
78E9  57              push di
78EA  8D BE 5C FF     lea di, [bp - 0xa4]
78EE  16              push ss
78EF  57              push di
78F0  6A 50           push 0x50
78F2  9A 6D 0B B9 26  call far 26B9:0B6D
78F7  BF EC D6        mov di, 0xd6ec
78FA  1E              push ds
78FB  57              push di
78FC  8D 7E AE        lea di, [bp - 0x52]
78FF  16              push ss
7900  57              push di
7901  6A 52           push 0x52
7903  9A 12 0A B9 26  call far 26B9:0A12
7908  8D BE 58 FE     lea di, [bp - 0x1a8]
790C  16              push ss
790D  57              push di
790E  0E              push cs
790F  E8 89 FF        call 0x789b
7912  BF D0 78        mov di, 0x78d0
7915  0E              push cs
7916  57              push di
7917  9A D2 0B B9 26  call far 26B9:0BD2
791C  8D BE 58 FD     lea di, [bp - 0x2a8]
7920  16              push ss
7921  57              push di
7922  C4 BE 58 FF     les di, ptr [bp - 0xa8]
7926  26 8A 45 01     mov al, byte ptr es:[di + 1]
792A  30 E4           xor ah, ah
792C  03 06 DA DC     add ax, word ptr [0xdcda]
7930  48              dec ax
7931  50              push ax
7932  0E              push cs
7933  E8 8B 87        call 0xc1
7936  9A D2 0B B9 26  call far 26B9:0BD2
793B  BF 31 D7        mov di, 0xd731
793E  1E              push ds
793F  57              push di
7940  6A 0C           push 0xc
7942  9A 6D 0B B9 26  call far 26B9:0B6D
7947  8D BE 58 FE     lea di, [bp - 0x1a8]
794B  16              push ss
794C  57              push di
794D  BF EC D6        mov di, 0xd6ec
7950  1E              push ds
7951  57              push di
7952  9A 53 0B B9 26  call far 26B9:0B53
7957  BF 31 D7        mov di, 0xd731
795A  1E              push ds
795B  57              push di
795C  9A D2 0B B9 26  call far 26B9:0BD2
7961  BF 3E D7        mov di, 0xd73e
7964  1E              push ds
7965  57              push di
7966  6A 50           push 0x50
7968  9A 6D 0B B9 26  call far 26B9:0B6D
796D  0E              push cs
796E  E8 D7 93        call 0xd48
7971  8D 7E AE        lea di, [bp - 0x52]
7974  16              push ss
7975  57              push di
7976  BF EC D6        mov di, 0xd6ec
7979  1E              push ds
797A  57              push di
797B  6A 52           push 0x52
797D  9A 12 0A B9 26  call far 26B9:0A12
7982  8D BE 5C FF     lea di, [bp - 0xa4]
7986  16              push ss
7987  57              push di
7988  BF 3E D7        mov di, 0xd73e
798B  1E              push ds
798C  57              push di
798D  6A 50           push 0x50
798F  9A 6D 0B B9 26  call far 26B9:0B6D
7994  C4 BE 58 FF     les di, ptr [bp - 0xa8]
7998  26 C6 05 3A     mov byte ptr es:[di], 0x3a
799C  C9              leave
799D  CB              retf

; ---- routine 1B51:799E  (found by: far)
sub_799E:
799E  C8 B6 01 00     enter 0x1b6, 0
79A2  8C D3           mov bx, ss
79A4  8E C3           mov es, bx
79A6  8C DB           mov bx, ds
79A8  FC              cld
79A9  8D 7E F2        lea di, [bp - 0xe]
79AC  C5 76 06        lds si, ptr [bp + 6]
79AF  AC              lodsb al, byte ptr [si]
79B0  3C 0C           cmp al, 0xc
79B2  72 02           jb 0x79b6
79B4  B0 0C           mov al, 0xc
loc_79B6:
79B6  AA              stosb byte ptr es:[di], al
79B7  91              xchg cx, ax
79B8  30 ED           xor ch, ch
79BA  F3 A4           rep movsb byte ptr es:[di], byte ptr [si]
79BC  8E DB           mov ds, bx
79BE  C4 3E D2 D7     les di, ptr [0xd7d2]
79C2  BF 3E D7        mov di, 0xd73e
79C5  1E              push ds
79C6  57              push di
79C7  8D BE 4E FF     lea di, [bp - 0xb2]
79CB  16              push ss
79CC  57              push di
79CD  6A 50           push 0x50
79CF  9A 6D 0B B9 26  call far 26B9:0B6D
79D4  BF EC D6        mov di, 0xd6ec
79D7  1E              push ds
79D8  57              push di
79D9  8D 7E A0        lea di, [bp - 0x60]
79DC  16              push ss
79DD  57              push di
79DE  6A 52           push 0x52
79E0  9A 12 0A B9 26  call far 26B9:0A12
79E5  8D 7E F2        lea di, [bp - 0xe]
79E8  16              push ss
79E9  57              push di
79EA  BF 31 D7        mov di, 0xd731
79ED  1E              push ds
79EE  57              push di
79EF  6A 0C           push 0xc
79F1  9A 6D 0B B9 26  call far 26B9:0B6D
79F6  8D BE 4A FE     lea di, [bp - 0x1b6]
79FA  16              push ss
79FB  57              push di
79FC  BF EC D6        mov di, 0xd6ec
79FF  1E              push ds
7A00  57              push di
7A01  9A 53 0B B9 26  call far 26B9:0B53
7A06  BF 31 D7        mov di, 0xd731
7A09  1E              push ds
7A0A  57              push di
7A0B  9A D2 0B B9 26  call far 26B9:0BD2
7A10  BF 3E D7        mov di, 0xd73e
7A13  1E              push ds
7A14  57              push di
7A15  6A 50           push 0x50
7A17  9A 6D 0B B9 26  call far 26B9:0B6D
loc_7A1C:
7A1C  6A 01           push 1
7A1E  6A 00           push 0
7A20  0E              push cs
7A21  E8 16 92        call 0xc3a
7A24  08 C0           or al, al
7A26  75 0B           jne 0x7a33
7A28  6A 00           push 0
7A2A  9A 94 11 1A 23  call far 231A:1194
7A2F  08 C0           or al, al
7A31  75 E9           jne 0x7a1c
loc_7A33:
7A33  8D 7E A0        lea di, [bp - 0x60]
7A36  16              push ss
7A37  57              push di
7A38  BF EC D6        mov di, 0xd6ec
7A3B  1E              push ds
7A3C  57              push di
7A3D  6A 52           push 0x52
7A3F  9A 12 0A B9 26  call far 26B9:0A12
7A44  8D BE 4E FF     lea di, [bp - 0xb2]
7A48  16              push ss
7A49  57              push di
7A4A  BF 3E D7        mov di, 0xd73e
7A4D  1E              push ds
7A4E  57              push di
7A4F  6A 50           push 0x50
7A51  9A 6D 0B B9 26  call far 26B9:0B6D
7A56  C9              leave
7A57  CA 04 00        retf 4

; ---- routine 1B51:7A5A  (found by: far)
sub_7A5A:
7A5A  C8 0A 00 00     enter 0xa, 0
7A5E  8B 46 08        mov ax, word ptr [bp + 8]
7A61  C1 E0 03        shl ax, 3
7A64  C4 3E BA D7     les di, ptr [0xd7ba]
7A68  03 F8           add di, ax
7A6A  89 7E FA        mov word ptr [bp - 6], di
7A6D  8C 46 FC        mov word ptr [bp - 4], es
7A70  6B 46 06 3E     imul ax, word ptr [bp + 6], 0x3e
7A74  C4 3E C2 D7     les di, ptr [0xd7c2]
7A78  03 F8           add di, ax
7A7A  81 C7 C2 FF     add di, 0xffc2
7A7E  FF 76 06        push word ptr [bp + 6]
7A81  0E              push cs
7A82  E8 36 AB        call 0x25bb
7A85  8B D0           mov dx, ax
7A87  C4 7E FA        les di, ptr [bp - 6]
7A8A  26 8A 45 04     mov al, byte ptr es:[di + 4]
7A8E  30 E4           xor ah, ah
7A90  05 B0 FF        add ax, 0xffb0
7A93  3B C2           cmp ax, dx
7A95  B0 00           mov al, 0
7A97  7E 01           jle 0x7a9a
7A99  40              inc ax
loc_7A9A:
7A9A  88 46 FF        mov byte ptr [bp - 1], al
7A9D  8A 46 FF        mov al, byte ptr [bp - 1]
7AA0  C9              leave
7AA1  CA 04 00        retf 4

; ---- routine 1B51:7AA4  (found by: far)
sub_7AA4:
7AA4  C8 06 00 00     enter 6, 0
7AA8  8B 46 08        mov ax, word ptr [bp + 8]
7AAB  C1 E0 03        shl ax, 3
7AAE  C4 3E BA D7     les di, ptr [0xd7ba]
7AB2  03 F8           add di, ax
7AB4  89 7E FA        mov word ptr [bp - 6], di
7AB7  8C 46 FC        mov word ptr [bp - 4], es
7ABA  6B 46 06 3E     imul ax, word ptr [bp + 6], 0x3e
7ABE  C4 3E C2 D7     les di, ptr [0xd7c2]
7AC2  03 F8           add di, ax
7AC4  26 8A 45 F5     mov al, byte ptr es:[di - 0xb]
7AC8  30 E4           xor ah, ah
7ACA  8B D0           mov dx, ax
7ACC  B8 B1 00        mov ax, 0xb1
7ACF  2B C2           sub ax, dx
7AD1  8B D0           mov dx, ax
7AD3  C4 7E FA        les di, ptr [bp - 6]
7AD6  26 8A 45 04     mov al, byte ptr es:[di + 4]
7ADA  30 E4           xor ah, ah
7ADC  05 A0 FF        add ax, 0xffa0
7ADF  3B C2           cmp ax, dx
7AE1  B0 00           mov al, 0
7AE3  7E 01           jle 0x7ae6
7AE5  40              inc ax
loc_7AE6:
7AE6  88 46 FF        mov byte ptr [bp - 1], al
7AE9  8A 46 FF        mov al, byte ptr [bp - 1]
7AEC  C9              leave
7AED  CA 04 00        retf 4
; data (not reached as code), 47 bytes
7AF0                  pstr 'save1.1-0'
7AFA                  pstr 'Type install to install to hard disk'

