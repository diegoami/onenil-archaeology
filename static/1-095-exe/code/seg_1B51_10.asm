; 1-095.EXE (One-Nil 95), code segment 1B51 (image offsets 1B510..2305F), part 10 of 12
; packed 1-095.EXE sha256 f659fb2d334500d6901fc8d6a0f06c85c0ccda2eb4a3035ae3bb0a0004d79192 (LZEXE 0.91)
; unpacked (tools/static/unlzexe.py) sha256 8df646e017e0965a5d90a58181ca764219ad847833aad0b6cb58fc53372bfb2c
; tool: capstone 5.0.9 (pip package; core library 5.0.1280) (CS_ARCH_X86, CS_MODE_16), recursive descent from the entry point, far calls and near calls/jumps, then routine prologues (55 89 E5 / 55 8B EC / C8 iw 00) in what remains; tools/static/listing.py
; addresses are SEGMENT:OFFSET with SEGMENT the image paragraph before relocation; image offset = SEGMENT*16+OFFSET
; ---- routine 1B51:662F  (found by: far)
sub_662F:
662F  C8 00 02 00     enter 0x200, 0
6633  83 7E 06 00     cmp word ptr [bp + 6], 0
6637  74 61           je 0x669a
6639  6B 46 06 0F     imul ax, word ptr [bp + 6], 0xf
663D  C4 3E BE D7     les di, ptr [0xd7be]
6641  03 F8           add di, ax
6643  26 80 7D 0D 02  cmp byte ptr es:[di + 0xd], 2
6648  74 50           je 0x669a
664A  8B 46 06        mov ax, word ptr [bp + 6]
664D  C1 E0 03        shl ax, 3
6650  C4 3E BA D7     les di, ptr [0xd7ba]
6654  03 F8           add di, ax
6656  26 80 7D 01 12  cmp byte ptr es:[di + 1], 0x12
665B  B0 00           mov al, 0
665D  73 01           jae 0x6660
665F  40              inc ax
loc_6660:
6660  50              push ax
6661  BF E4 65        mov di, 0x65e4
6664  0E              push cs
6665  57              push di
6666  9A 98 00 1A 23  call far 231A:0098
666B  08 C0           or al, al
666D  75 2B           jne 0x669a
666F  8D BE 00 FE     lea di, [bp - 0x200]
6673  16              push ss
6674  57              push di
6675  BF 01 66        mov di, 0x6601
6678  0E              push cs
6679  57              push di
667A  9A 53 0B B9 26  call far 26B9:0B53
667F  8D BE 00 FF     lea di, [bp - 0x100]
6683  16              push ss
6684  57              push di
6685  FF 76 06        push word ptr [bp + 6]
6688  0E              push cs
6689  E8 B0 DD        call 0x443c
668C  9A D2 0B B9 26  call far 26B9:0BD2
6691  9A E5 06 1A 23  call far 231A:06E5
6696  08 C0           or al, al
6698  75 02           jne 0x669c
loc_669A:
669A  EB 2B           jmp 0x66c7
loc_669C:
669C  8D BE 00 FF     lea di, [bp - 0x100]
66A0  16              push ss
66A1  57              push di
66A2  FF 76 06        push word ptr [bp + 6]
66A5  0E              push cs
66A6  E8 93 DD        call 0x443c
66A9  BF 07 66        mov di, 0x6607
66AC  0E              push cs
66AD  57              push di
66AE  9A D2 0B B9 26  call far 26B9:0BD2
66B3  9A 02 07 AC 24  call far 24AC:0702
66B8  6B 46 06 0F     imul ax, word ptr [bp + 6], 0xf
66BC  C4 3E BE D7     les di, ptr [0xd7be]
66C0  03 F8           add di, ax
66C2  26 C6 45 0D 02  mov byte ptr es:[di + 0xd], 2
loc_66C7:
66C7  C9              leave
66C8  CA 02 00        retf 2

; ---- routine 1B51:66CB  (found by: call, far)
sub_66CB:
66CB  55              push bp
66CC  89 E5           mov bp, sp
66CE  8B 46 06        mov ax, word ptr [bp + 6]
66D1  C1 E0 03        shl ax, 3
66D4  C4 3E BA D7     les di, ptr [0xd7ba]
66D8  03 F8           add di, ax
66DA  06              push es
66DB  57              push di
66DC  6A 08           push 8
66DE  6A 00           push 0
66E0  9A 22 02 AC 24  call far 24AC:0222
66E5  6B 46 06 0F     imul ax, word ptr [bp + 6], 0xf
66E9  C4 3E BE D7     les di, ptr [0xd7be]
66ED  03 F8           add di, ax
66EF  06              push es
66F0  57              push di
66F1  6A 0F           push 0xf
66F3  6A 00           push 0
66F5  9A 22 02 AC 24  call far 24AC:0222
66FA  C9              leave
66FB  CA 02 00        retf 2

; ---- routine 1B51:66FE  (found by: call, far)
sub_66FE:
66FE  55              push bp
66FF  89 E5           mov bp, sp
6701  8B 46 06        mov ax, word ptr [bp + 6]
6704  D1 E0           shl ax, 1
6706  C4 7E 08        les di, ptr [bp + 8]
6709  03 F8           add di, ax
670B  26 FF 75 FE     push word ptr es:[di - 2]
670F  0E              push cs
6710  E8 B8 FF        call 0x66cb
6713  8B 46 06        mov ax, word ptr [bp + 6]
6716  D1 E0           shl ax, 1
6718  C4 7E 08        les di, ptr [bp + 8]
671B  03 F8           add di, ax
671D  31 C0           xor ax, ax
671F  26 89 45 FE     mov word ptr es:[di - 2], ax
6723  C9              leave
6724  CA 06 00        retf 6

; ---- routine 1B51:6727  (found by: call)
sub_6727:
6727  55              push bp
6728  89 E5           mov bp, sp
672A  C4 7E 08        les di, ptr [bp + 8]
672D  06              push es
672E  57              push di
672F  FF 76 06        push word ptr [bp + 6]
6732  0E              push cs
6733  E8 C8 FF        call 0x66fe
6736  8B 7E 04        mov di, word ptr [bp + 4]
6739  36 6B 45 FE 3E  imul ax, word ptr ss:[di - 2], 0x3e
673E  C4 3E C2 D7     les di, ptr [0xd7c2]
6742  03 F8           add di, ax
6744  26 FE 4D F4     dec byte ptr es:[di - 0xc]
6748  C9              leave
6749  C2 08 00        ret 8

; ---- routine 1B51:674C  (found by: call)
sub_674C:
674C  55              push bp
674D  89 E5           mov bp, sp
674F  8B 7E 04        mov di, word ptr [bp + 4]
6752  36 FF 75 FE     push word ptr ss:[di - 2]
6756  FF 76 08        push word ptr [bp + 8]
6759  FF 76 06        push word ptr [bp + 6]
675C  0E              push cs
675D  E8 51 F9        call 0x60b1
6760  8B 7E 04        mov di, word ptr [bp + 4]
6763  36 6B 45 FE 3E  imul ax, word ptr ss:[di - 2], 0x3e
6768  C4 3E C2 D7     les di, ptr [0xd7c2]
676C  03 F8           add di, ax
676E  26 FE 45 F4     inc byte ptr es:[di - 0xc]
6772  C9              leave
6773  C2 06 00        ret 6

; ---- routine 1B51:6776  (found by: call)
sub_6776:
6776  C8 0E 00 00     enter 0xe, 0
677A  8B 7E 04        mov di, word ptr [bp + 4]
677D  36 6B 45 FE 3E  imul ax, word ptr ss:[di - 2], 0x3e
6782  C4 3E C2 D7     les di, ptr [0xd7c2]
6786  03 F8           add di, ax
6788  81 C7 C2 FF     add di, 0xffc2
678C  89 7E FA        mov word ptr [bp - 6], di
678F  8C 46 FC        mov word ptr [bp - 4], es
6792  C7 46 FE 01 00  mov word ptr [bp - 2], 1
6797  EB 03           jmp 0x679c
loc_6799:
6799  FF 46 FE        inc word ptr [bp - 2]
loc_679C:
679C  C4 7E FA        les di, ptr [bp - 6]
679F  26 8A 45 37     mov al, byte ptr es:[di + 0x37]
67A3  98              cwde
67A4  8B F8           mov di, ax
67A6  8A 85 62 A2     mov al, byte ptr [di - 0x5d9e]
67AA  C4 7E FA        les di, ptr [bp - 6]
67AD  26 3A 45 32     cmp al, byte ptr es:[di + 0x32]
67B1  77 6C           ja 0x681f
67B3  8B 46 FE        mov ax, word ptr [bp - 2]
67B6  D1 E0           shl ax, 1
67B8  C4 7E 06        les di, ptr [bp + 6]
67BB  03 F8           add di, ax
67BD  26 83 7D FE 00  cmp word ptr es:[di - 2], 0
67C2  74 5B           je 0x681f
67C4  8B 46 FE        mov ax, word ptr [bp - 2]
67C7  D1 E0           shl ax, 1
67C9  C4 7E 06        les di, ptr [bp + 6]
67CC  03 F8           add di, ax
67CE  26 8B 45 FE     mov ax, word ptr es:[di - 2]
67D2  C1 E0 03        shl ax, 3
67D5  C4 3E BA D7     les di, ptr [0xd7ba]
67D9  03 F8           add di, ax
67DB  89 7E F6        mov word ptr [bp - 0xa], di
67DE  8C 46 F8        mov word ptr [bp - 8], es
67E1  8B 46 FE        mov ax, word ptr [bp - 2]
67E4  D1 E0           shl ax, 1
67E6  C4 7E 06        les di, ptr [bp + 6]
67E9  03 F8           add di, ax
67EB  26 6B 45 FE 0F  imul ax, word ptr es:[di - 2], 0xf
67F0  C4 3E BE D7     les di, ptr [0xd7be]
67F4  03 F8           add di, ax
67F6  89 7E F2        mov word ptr [bp - 0xe], di
67F9  8C 46 F4        mov word ptr [bp - 0xc], es
67FC  C4 7E F6        les di, ptr [bp - 0xa]
67FF  26 80 7D 01 13  cmp byte ptr es:[di + 1], 0x13
6804  72 0A           jb 0x6810
6806  C4 7E F2        les di, ptr [bp - 0xe]
6809  26 80 7D 0C 00  cmp byte ptr es:[di + 0xc], 0
680E  75 0F           jne 0x681f
loc_6810:
6810  C4 7E 06        les di, ptr [bp + 6]
6813  06              push es
6814  57              push di
6815  FF 76 FE        push word ptr [bp - 2]
6818  8B 7E 04        mov di, word ptr [bp + 4]
681B  57              push di
681C  E8 08 FF        call 0x6727
loc_681F:
681F  83 7E FE 14     cmp word ptr [bp - 2], 0x14
6823  74 03           je 0x6828
6825  E9 71 FF        jmp 0x6799
loc_6828:
6828  C9              leave
6829  C2 06 00        ret 6

; ---- routine 1B51:682C  (found by: far)
sub_682C:
682C  C8 1A 00 00     enter 0x1a, 0
6830  C4 3E D2 D7     les di, ptr [0xd7d2]
6834  89 7E F4        mov word ptr [bp - 0xc], di
6837  8C 46 F6        mov word ptr [bp - 0xa], es
683A  8B 7E 06        mov di, word ptr [bp + 6]
683D  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
6841  30 E4           xor ah, ah
6843  89 46 FE        mov word ptr [bp - 2], ax
6846  6B 46 FE 3E     imul ax, word ptr [bp - 2], 0x3e
684A  C4 3E C2 D7     les di, ptr [0xd7c2]
684E  03 F8           add di, ax
6850  81 C7 C2 FF     add di, 0xffc2
6854  89 7E F0        mov word ptr [bp - 0x10], di
6857  8C 46 F2        mov word ptr [bp - 0xe], es
685A  8B 7E FE        mov di, word ptr [bp - 2]
685D  8A 85 85 D8     mov al, byte ptr [di - 0x277b]
6861  30 E4           xor ah, ah
6863  8B F8           mov di, ax
6865  8A 85 F7 93     mov al, byte ptr [di - 0x6c09]
6869  C4 7E F0        les di, ptr [bp - 0x10]
686C  26 88 45 39     mov byte ptr es:[di + 0x39], al
6870  6B 46 06 28     imul ax, word ptr [bp + 6], 0x28
6874  C4 7E F4        les di, ptr [bp - 0xc]
6877  03 F8           add di, ax
6879  81 C7 30 00     add di, 0x30
687D  06              push es
687E  57              push di
687F  55              push bp
6880  E8 F3 FE        call 0x6776
6883  C4 7E F0        les di, ptr [bp - 0x10]
6886  06              push es
6887  57              push di
6888  55              push bp
6889  E8 EA FE        call 0x6776
688C  C7 46 FC 01 00  mov word ptr [bp - 4], 1
6891  EB 03           jmp 0x6896
loc_6893:
6893  FF 46 FC        inc word ptr [bp - 4]
loc_6896:
6896  8B 46 FC        mov ax, word ptr [bp - 4]
6899  D1 E0           shl ax, 1
689B  8B D0           mov dx, ax
689D  6B 46 06 28     imul ax, word ptr [bp + 6], 0x28
68A1  C4 7E F4        les di, ptr [bp - 0xc]
68A4  03 F8           add di, ax
68A6  03 FA           add di, dx
68A8  26 83 7D 2E 00  cmp word ptr es:[di + 0x2e], 0
68AD  74 50           je 0x68ff
68AF  C4 7E F0        les di, ptr [bp - 0x10]
68B2  06              push es
68B3  57              push di
68B4  0E              push cs
68B5  E8 32 F3        call 0x5bea
68B8  09 C0           or ax, ax
68BA  74 43           je 0x68ff
68BC  8B 46 FC        mov ax, word ptr [bp - 4]
68BF  D1 E0           shl ax, 1
68C1  8B D0           mov dx, ax
68C3  6B 46 06 28     imul ax, word ptr [bp + 6], 0x28
68C7  C4 7E F4        les di, ptr [bp - 0xc]
68CA  03 F8           add di, ax
68CC  03 FA           add di, dx
68CE  26 FF 75 2E     push word ptr es:[di + 0x2e]
68D2  C4 7E F0        les di, ptr [bp - 0x10]
68D5  06              push es
68D6  57              push di
68D7  0E              push cs
68D8  E8 0F F3        call 0x5bea
68DB  D1 E0           shl ax, 1
68DD  C4 7E F0        les di, ptr [bp - 0x10]
68E0  03 F8           add di, ax
68E2  58              pop ax
68E3  26 89 45 FE     mov word ptr es:[di - 2], ax
68E7  8B 46 FC        mov ax, word ptr [bp - 4]
68EA  D1 E0           shl ax, 1
68EC  8B D0           mov dx, ax
68EE  6B 46 06 28     imul ax, word ptr [bp + 6], 0x28
68F2  C4 7E F4        les di, ptr [bp - 0xc]
68F5  03 F8           add di, ax
68F7  03 FA           add di, dx
68F9  31 C0           xor ax, ax
68FB  26 89 45 2E     mov word ptr es:[di + 0x2e], ax
loc_68FF:
68FF  83 7E FC 14     cmp word ptr [bp - 4], 0x14
6903  75 8E           jne 0x6893
6905  C7 46 FC 01 00  mov word ptr [bp - 4], 1
690A  EB 03           jmp 0x690f
loc_690C:
690C  FF 46 FC        inc word ptr [bp - 4]
loc_690F:
690F  8B 46 FC        mov ax, word ptr [bp - 4]
6912  D1 E0           shl ax, 1
6914  8B D0           mov dx, ax
6916  6B 46 06 28     imul ax, word ptr [bp + 6], 0x28
691A  C4 7E F4        les di, ptr [bp - 0xc]
691D  03 F8           add di, ax
691F  03 FA           add di, dx
6921  26 83 7D 2E 00  cmp word ptr es:[di + 0x2e], 0
6926  74 16           je 0x693e
6928  6B 46 06 28     imul ax, word ptr [bp + 6], 0x28
692C  C4 7E F4        les di, ptr [bp - 0xc]
692F  03 F8           add di, ax
6931  81 C7 30 00     add di, 0x30
6935  06              push es
6936  57              push di
6937  FF 76 FC        push word ptr [bp - 4]
693A  55              push bp
693B  E8 E9 FD        call 0x6727
loc_693E:
693E  83 7E FC 14     cmp word ptr [bp - 4], 0x14
6942  75 C8           jne 0x690c
6944  C7 46 FA 02 00  mov word ptr [bp - 6], 2
6949  EB 03           jmp 0x694e
loc_694B:
694B  FF 46 FA        inc word ptr [bp - 6]
loc_694E:
694E  8B 46 FA        mov ax, word ptr [bp - 6]
6951  89 46 EE        mov word ptr [bp - 0x12], ax
6954  B8 14 00        mov ax, 0x14
6957  3B 46 EE        cmp ax, word ptr [bp - 0x12]
695A  72 4A           jb 0x69a6
695C  89 46 FC        mov word ptr [bp - 4], ax
695F  EB 03           jmp 0x6964
loc_6961:
6961  FF 4E FC        dec word ptr [bp - 4]
loc_6964:
6964  8B 46 FC        mov ax, word ptr [bp - 4]
6967  48              dec ax
6968  D1 E0           shl ax, 1
696A  C4 7E F0        les di, ptr [bp - 0x10]
696D  03 F8           add di, ax
696F  26 83 7D FE 00  cmp word ptr es:[di - 2], 0
6974  75 28           jne 0x699e
6976  8B 46 FC        mov ax, word ptr [bp - 4]
6979  48              dec ax
697A  D1 E0           shl ax, 1
697C  C4 7E F0        les di, ptr [bp - 0x10]
697F  03 F8           add di, ax
6981  81 C7 FE FF     add di, 0xfffe
6985  06              push es
6986  57              push di
6987  8B 46 FC        mov ax, word ptr [bp - 4]
698A  D1 E0           shl ax, 1
698C  C4 7E F0        les di, ptr [bp - 0x10]
698F  03 F8           add di, ax
6991  81 C7 FE FF     add di, 0xfffe
6995  06              push es
6996  57              push di
6997  6A 02           push 2
6999  9A 03 02 AC 24  call far 24AC:0203
loc_699E:
699E  8B 46 FC        mov ax, word ptr [bp - 4]
69A1  3B 46 EE        cmp ax, word ptr [bp - 0x12]
69A4  75 BB           jne 0x6961
loc_69A6:
69A6  83 7E FA 14     cmp word ptr [bp - 6], 0x14
69AA  75 9F           jne 0x694b
69AC  C7 46 FC 01 00  mov word ptr [bp - 4], 1
69B1  EB 03           jmp 0x69b6
loc_69B3:
69B3  FF 46 FC        inc word ptr [bp - 4]
loc_69B6:
69B6  8B 46 FC        mov ax, word ptr [bp - 4]
69B9  D1 E0           shl ax, 1
69BB  C4 7E F0        les di, ptr [bp - 0x10]
69BE  03 F8           add di, ax
69C0  26 83 7D FE 00  cmp word ptr es:[di - 2], 0
69C5  75 1F           jne 0x69e6
69C7  FF 76 FC        push word ptr [bp - 4]
69CA  8B 56 FC        mov dx, word ptr [bp - 4]
69CD  8B 7E FE        mov di, word ptr [bp - 2]
69D0  8A 85 85 D8     mov al, byte ptr [di - 0x277b]
69D4  30 E4           xor ah, ah
69D6  6B F8 0E        imul di, ax, 0xe
69D9  03 FA           add di, dx
69DB  8A 85 04 94     mov al, byte ptr [di - 0x6bfc]
69DF  30 E4           xor ah, ah
69E1  50              push ax
69E2  55              push bp
69E3  E8 66 FD        call 0x674c
loc_69E6:
69E6  83 7E FC 0D     cmp word ptr [bp - 4], 0xd
69EA  75 C7           jne 0x69b3
69EC  C4 7E F0        les di, ptr [bp - 0x10]
69EF  26 8A 45 37     mov al, byte ptr es:[di + 0x37]
69F3  98              cwde
69F4  8B F8           mov di, ax
69F6  8A 85 62 A2     mov al, byte ptr [di - 0x5d9e]
69FA  30 E4           xor ah, ah
69FC  89 46 EE        mov word ptr [bp - 0x12], ax
69FF  B8 0E 00        mov ax, 0xe
6A02  3B 46 EE        cmp ax, word ptr [bp - 0x12]
6A05  77 48           ja 0x6a4f
6A07  89 46 FC        mov word ptr [bp - 4], ax
6A0A  EB 03           jmp 0x6a0f
loc_6A0C:
6A0C  FF 46 FC        inc word ptr [bp - 4]
loc_6A0F:
6A0F  8B 46 FC        mov ax, word ptr [bp - 4]
6A12  D1 E0           shl ax, 1
6A14  C4 7E F0        les di, ptr [bp - 0x10]
6A17  03 F8           add di, ax
6A19  26 83 7D FE 00  cmp word ptr es:[di - 2], 0
6A1E  75 27           jne 0x6a47
6A20  FF 76 FC        push word ptr [bp - 4]
6A23  8B 7E FC        mov di, word ptr [bp - 4]
6A26  8A 85 84 0D     mov al, byte ptr [di + 0xd84]
6A2A  30 E4           xor ah, ah
6A2C  8B D0           mov dx, ax
6A2E  8B 7E FE        mov di, word ptr [bp - 2]
6A31  8A 85 85 D8     mov al, byte ptr [di - 0x277b]
6A35  30 E4           xor ah, ah
6A37  6B F8 0E        imul di, ax, 0xe
6A3A  03 FA           add di, dx
6A3C  8A 85 04 94     mov al, byte ptr [di - 0x6bfc]
6A40  30 E4           xor ah, ah
6A42  50              push ax
6A43  55              push bp
6A44  E8 05 FD        call 0x674c
loc_6A47:
6A47  8B 46 FC        mov ax, word ptr [bp - 4]
6A4A  3B 46 EE        cmp ax, word ptr [bp - 0x12]
6A4D  75 BD           jne 0x6a0c
loc_6A4F:
6A4F  C4 7E F0        les di, ptr [bp - 0x10]
6A52  26 8A 45 32     mov al, byte ptr es:[di + 0x32]
6A56  30 E4           xor ah, ah
6A58  89 46 EE        mov word ptr [bp - 0x12], ax
6A5B  B8 01 00        mov ax, 1
6A5E  3B 46 EE        cmp ax, word ptr [bp - 0x12]
6A61  77 2F           ja 0x6a92
6A63  89 46 FC        mov word ptr [bp - 4], ax
6A66  EB 03           jmp 0x6a6b
loc_6A68:
6A68  FF 46 FC        inc word ptr [bp - 4]
loc_6A6B:
6A6B  8B 46 FC        mov ax, word ptr [bp - 4]
6A6E  D1 E0           shl ax, 1
6A70  C4 7E F0        les di, ptr [bp - 0x10]
6A73  03 F8           add di, ax
6A75  26 8B 45 FE     mov ax, word ptr es:[di - 2]
6A79  C1 E0 03        shl ax, 3
6A7C  C4 3E BA D7     les di, ptr [0xd7ba]
6A80  03 F8           add di, ax
6A82  26 8A 45 07     mov al, byte ptr es:[di + 7]
6A86  26 88 45 06     mov byte ptr es:[di + 6], al
6A8A  8B 46 FC        mov ax, word ptr [bp - 4]
6A8D  3B 46 EE        cmp ax, word ptr [bp - 0x12]
6A90  75 D6           jne 0x6a68
loc_6A92:
6A92  C4 7E F0        les di, ptr [bp - 0x10]
6A95  06              push es
6A96  57              push di
6A97  FF 76 FE        push word ptr [bp - 2]
6A9A  0E              push cs
6A9B  E8 1A 0C        call 0x76b8
6A9E  C4 7E F0        les di, ptr [bp - 0x10]
6AA1  26 8B 05        mov ax, word ptr es:[di]
6AA4  C1 E0 03        shl ax, 3
6AA7  C4 3E BA D7     les di, ptr [0xd7ba]
6AAB  03 F8           add di, ax
6AAD  26 80 7D 07 00  cmp byte ptr es:[di + 7], 0
6AB2  74 30           je 0x6ae4
6AB4  C4 7E F0        les di, ptr [bp - 0x10]
6AB7  26 8A 45 32     mov al, byte ptr es:[di + 0x32]
6ABB  30 E4           xor ah, ah
6ABD  40              inc ax
6ABE  50              push ax
6ABF  6A 00           push 0
6AC1  55              push bp
6AC2  E8 87 FC        call 0x674c
6AC5  C4 7E F0        les di, ptr [bp - 0x10]
6AC8  26 8A 45 32     mov al, byte ptr es:[di + 0x32]
6ACC  30 E4           xor ah, ah
6ACE  D1 E0           shl ax, 1
6AD0  03 F8           add di, ax
6AD2  81 C7 FE FF     add di, 0xfffe
6AD6  06              push es
6AD7  57              push di
6AD8  C4 7E F0        les di, ptr [bp - 0x10]
6ADB  06              push es
6ADC  57              push di
6ADD  6A 02           push 2
6ADF  9A 03 02 AC 24  call far 24AC:0203
loc_6AE4:
6AE4  C4 7E F0        les di, ptr [bp - 0x10]
6AE7  26 8A 45 32     mov al, byte ptr es:[di + 0x32]
6AEB  30 E4           xor ah, ah
6AED  89 46 EE        mov word ptr [bp - 0x12], ax
6AF0  B8 01 00        mov ax, 1
6AF3  3B 46 EE        cmp ax, word ptr [bp - 0x12]
6AF6  76 03           jbe 0x6afb
6AF8  E9 AD 00        jmp 0x6ba8
loc_6AFB:
6AFB  89 46 FC        mov word ptr [bp - 4], ax
6AFE  EB 03           jmp 0x6b03
loc_6B00:
6B00  FF 46 FC        inc word ptr [bp - 4]
loc_6B03:
6B03  8B 46 FC        mov ax, word ptr [bp - 4]
6B06  D1 E0           shl ax, 1
6B08  C4 7E F0        les di, ptr [bp - 0x10]
6B0B  03 F8           add di, ax
6B0D  26 8B 45 FE     mov ax, word ptr es:[di - 2]
6B11  C1 E0 03        shl ax, 3
6B14  C4 3E BA D7     les di, ptr [0xd7ba]
6B18  03 F8           add di, ax
6B1A  89 7E EA        mov word ptr [bp - 0x16], di
6B1D  8C 46 EC        mov word ptr [bp - 0x14], es
6B20  83 7E FC 0C     cmp word ptr [bp - 4], 0xc
6B24  73 1C           jae 0x6b42
6B26  8B 56 FC        mov dx, word ptr [bp - 4]
6B29  8B 7E FE        mov di, word ptr [bp - 2]
6B2C  8A 85 85 D8     mov al, byte ptr [di - 0x277b]
6B30  30 E4           xor ah, ah
6B32  6B F8 0E        imul di, ax, 0xe
6B35  03 FA           add di, dx
6B37  8A 85 04 94     mov al, byte ptr [di - 0x6bfc]
6B3B  C4 7E EA        les di, ptr [bp - 0x16]
6B3E  26 88 45 06     mov byte ptr es:[di + 6], al
loc_6B42:
6B42  8B 46 FC        mov ax, word ptr [bp - 4]
6B45  D1 E0           shl ax, 1
6B47  C4 7E F0        les di, ptr [bp - 0x10]
6B4A  03 F8           add di, ax
6B4C  26 6B 45 FE 0F  imul ax, word ptr es:[di - 2], 0xf
6B51  C4 3E BE D7     les di, ptr [0xd7be]
6B55  03 F8           add di, ax
6B57  89 7E E6        mov word ptr [bp - 0x1a], di
6B5A  8C 46 E8        mov word ptr [bp - 0x18], es
6B5D  26 C6 45 0A 00  mov byte ptr es:[di + 0xa], 0
6B62  26 80 7D 0C 00  cmp byte ptr es:[di + 0xc], 0
6B67  76 0E           jbe 0x6b77
6B69  26 80 7D 0D 02  cmp byte ptr es:[di + 0xd], 2
6B6E  75 07           jne 0x6b77
6B70  26 C6 45 0D 00  mov byte ptr es:[di + 0xd], 0
6B75  EB 26           jmp 0x6b9d
loc_6B77:
6B77  C4 7E E6        les di, ptr [bp - 0x1a]
6B7A  26 80 7D 0C 00  cmp byte ptr es:[di + 0xc], 0
6B7F  75 1C           jne 0x6b9d
6B81  C4 7E EA        les di, ptr [bp - 0x16]
6B84  26 80 7D 01 12  cmp byte ptr es:[di + 1], 0x12
6B89  73 12           jae 0x6b9d
6B8B  8B 46 FC        mov ax, word ptr [bp - 4]
6B8E  D1 E0           shl ax, 1
6B90  C4 7E F0        les di, ptr [bp - 0x10]
6B93  03 F8           add di, ax
6B95  26 FF 75 FE     push word ptr es:[di - 2]
6B99  0E              push cs
6B9A  E8 FB F8        call 0x6498
loc_6B9D:
6B9D  8B 46 FC        mov ax, word ptr [bp - 4]
6BA0  3B 46 EE        cmp ax, word ptr [bp - 0x12]
6BA3  74 03           je 0x6ba8
6BA5  E9 58 FF        jmp 0x6b00
loc_6BA8:
6BA8  C9              leave
6BA9  CA 02 00        retf 2

; ---- routine 1B51:6BAC  (found by: far)
sub_6BAC:
6BAC  C8 0A 00 00     enter 0xa, 0
6BB0  8B 46 08        mov ax, word ptr [bp + 8]
6BB3  C1 E0 02        shl ax, 2
6BB6  C4 3E C8 DC     les di, ptr [0xdcc8]
6BBA  03 F8           add di, ax
6BBC  89 7E FA        mov word ptr [bp - 6], di
6BBF  8C 46 FC        mov word ptr [bp - 4], es
6BC2  6B 46 06 3E     imul ax, word ptr [bp + 6], 0x3e
6BC6  C4 3E C2 D7     les di, ptr [0xd7c2]
6BCA  03 F8           add di, ax
6BCC  81 C7 C2 FF     add di, 0xffc2
6BD0  89 7E F6        mov word ptr [bp - 0xa], di
6BD3  8C 46 F8        mov word ptr [bp - 8], es
6BD6  C4 7E FA        les di, ptr [bp - 6]
6BD9  26 8A 45 01     mov al, byte ptr es:[di + 1]
6BDD  30 E4           xor ah, ah
6BDF  3B 46 06        cmp ax, word ptr [bp + 6]
6BE2  74 51           je 0x6c35
6BE4  C4 7E F6        les di, ptr [bp - 0xa]
6BE7  26 80 7D 36 03  cmp byte ptr es:[di + 0x36], 3
6BEC  76 47           jbe 0x6c35
6BEE  C4 7E FA        les di, ptr [bp - 6]
6BF1  26 8A 45 02     mov al, byte ptr es:[di + 2]
6BF5  30 E4           xor ah, ah
6BF7  31 D2           xor dx, dx
6BF9  52              push dx
6BFA  50              push ax
6BFB  6A 00           push 0
6BFD  6A 20           push 0x20
6BFF  9A C0 04 AC 24  call far 24AC:04C0
6C04  8B C8           mov cx, ax
6C06  8B DA           mov bx, dx
6C08  C4 7E F6        les di, ptr [bp - 0xa]
6C0B  26 8B 45 28     mov ax, word ptr es:[di + 0x28]
6C0F  C1 E0 02        shl ax, 2
6C12  C4 3E C8 DC     les di, ptr [0xdcc8]
6C16  03 F8           add di, ax
6C18  26 8A 45 02     mov al, byte ptr es:[di + 2]
6C1C  30 E4           xor ah, ah
6C1E  31 D2           xor dx, dx
6C20  3B D3           cmp dx, bx
6C22  7C 06           jl 0x6c2a
6C24  7F 0F           jg 0x6c35
6C26  3B C1           cmp ax, cx
6C28  73 0B           jae 0x6c35
loc_6C2A:
6C2A  FF 76 06        push word ptr [bp + 6]
6C2D  0E              push cs
6C2E  E8 A9 A1        call 0xdda
6C31  08 C0           or al, al
6C33  74 04           je 0x6c39
loc_6C35:
6C35  B0 00           mov al, 0
6C37  EB 02           jmp 0x6c3b
loc_6C39:
6C39  B0 01           mov al, 1
loc_6C3B:
6C3B  88 46 FF        mov byte ptr [bp - 1], al
6C3E  8A 46 FF        mov al, byte ptr [bp - 1]
6C41  C9              leave
6C42  CA 04 00        retf 4

; ---- routine 1B51:6C45  (found by: call)
sub_6C45:
6C45  C8 0A 00 00     enter 0xa, 0
6C49  C7 46 FE 01 00  mov word ptr [bp - 2], 1
6C4E  EB 03           jmp 0x6c53
loc_6C50:
6C50  FF 46 FE        inc word ptr [bp - 2]
loc_6C53:
6C53  8B 46 FE        mov ax, word ptr [bp - 2]
6C56  D1 E0           shl ax, 1
6C58  C4 7E 06        les di, ptr [bp + 6]
6C5B  03 F8           add di, ax
6C5D  26 83 7D FE 00  cmp word ptr es:[di - 2], 0
6C62  75 03           jne 0x6c67
6C64  E9 B1 00        jmp 0x6d18
loc_6C67:
6C67  8B 7E 04        mov di, word ptr [bp + 4]
6C6A  36 83 7D FE 05  cmp word ptr ss:[di - 2], 5
6C6F  72 03           jb 0x6c74
6C71  E9 A4 00        jmp 0x6d18
loc_6C74:
6C74  8B 46 FE        mov ax, word ptr [bp - 2]
6C77  D1 E0           shl ax, 1
6C79  C4 7E 06        les di, ptr [bp + 6]
6C7C  03 F8           add di, ax
6C7E  26 8B 45 FE     mov ax, word ptr es:[di - 2]
6C82  C1 E0 03        shl ax, 3
6C85  C4 3E BA D7     les di, ptr [0xd7ba]
6C89  03 F8           add di, ax
6C8B  89 7E FA        mov word ptr [bp - 6], di
6C8E  8C 46 FC        mov word ptr [bp - 4], es
6C91  8B 46 FE        mov ax, word ptr [bp - 2]
6C94  D1 E0           shl ax, 1
6C96  C4 7E 06        les di, ptr [bp + 6]
6C99  03 F8           add di, ax
6C9B  26 6B 45 FE 0F  imul ax, word ptr es:[di - 2], 0xf
6CA0  C4 3E BE D7     les di, ptr [0xd7be]
6CA4  03 F8           add di, ax
6CA6  89 7E F6        mov word ptr [bp - 0xa], di
6CA9  8C 46 F8        mov word ptr [bp - 8], es
6CAC  8B 46 FE        mov ax, word ptr [bp - 2]
6CAF  D1 E0           shl ax, 1
6CB1  C4 7E 06        les di, ptr [bp + 6]
6CB4  03 F8           add di, ax
6CB6  26 8B 45 FE     mov ax, word ptr es:[di - 2]
6CBA  C4 3E AE D7     les di, ptr [0xd7ae]
6CBE  03 F8           add di, ax
6CC0  26 8A 05        mov al, byte ptr es:[di]
6CC3  8B 7E 04        mov di, word ptr [bp + 4]
6CC6  36 3A 45 FB     cmp al, byte ptr ss:[di - 5]
6CCA  74 4C           je 0x6d18
6CCC  6A 64           push 0x64
6CCE  9A 6D 07 1A 23  call far 231A:076D
6CD3  05 B4 00        add ax, 0xb4
6CD6  8B D0           mov dx, ax
6CD8  C4 7E FA        les di, ptr [bp - 6]
6CDB  26 8A 45 04     mov al, byte ptr es:[di + 4]
6CDF  30 E4           xor ah, ah
6CE1  3B C2           cmp ax, dx
6CE3  7E 33           jle 0x6d18
6CE5  C4 7E F6        les di, ptr [bp - 0xa]
6CE8  26 80 7D 08 00  cmp byte ptr es:[di + 8], 0
6CED  7E 29           jle 0x6d18
6CEF  6A 01           push 1
6CF1  26 8A 45 0B     mov al, byte ptr es:[di + 0xb]
6CF5  30 E4           xor ah, ah
6CF7  50              push ax
6CF8  9A 59 02 AC 24  call far 24AC:0259
6CFD  08 C0           or al, al
6CFF  74 17           je 0x6d18
6D01  6A 02           push 2
6D03  C4 7E F6        les di, ptr [bp - 0xa]
6D06  81 C7 0B 00     add di, 0xb
6D0A  06              push es
6D0B  57              push di
6D0C  9A D5 00 1A 23  call far 231A:00D5
6D11  8B 7E 04        mov di, word ptr [bp + 4]
6D14  36 FF 45 FE     inc word ptr ss:[di - 2]
loc_6D18:
6D18  83 7E FE 14     cmp word ptr [bp - 2], 0x14
6D1C  74 03           je 0x6d21
6D1E  E9 2F FF        jmp 0x6c50
loc_6D21:
6D21  C9              leave
6D22  C2 06 00        ret 6

; ---- routine 1B51:6D25  (found by: call)
sub_6D25:
6D25  C8 02 00 00     enter 2, 0
6D29  C4 7E 06        les di, ptr [bp + 6]
6D2C  06              push es
6D2D  57              push di
6D2E  8B 7E 04        mov di, word ptr [bp + 4]
6D31  81 C7 D2 FF     add di, 0xffd2
6D35  16              push ss
6D36  57              push di
6D37  6A 28           push 0x28
6D39  9A C2 01 AC 24  call far 24AC:01C2
6D3E  C7 46 FE 01 00  mov word ptr [bp - 2], 1
6D43  EB 03           jmp 0x6d48
loc_6D45:
6D45  FF 46 FE        inc word ptr [bp - 2]
loc_6D48:
6D48  6A 14           push 0x14
6D4A  9A 6D 07 1A 23  call far 231A:076D
6D4F  D1 E0           shl ax, 1
6D51  C4 7E 06        les di, ptr [bp + 6]
6D54  03 F8           add di, ax
6D56  81 C7 FE FF     add di, 0xfffe
6D5A  06              push es
6D5B  57              push di
6D5C  6A 14           push 0x14
6D5E  9A 6D 07 1A 23  call far 231A:076D
6D63  D1 E0           shl ax, 1
6D65  C4 7E 06        les di, ptr [bp + 6]
6D68  03 F8           add di, ax
6D6A  81 C7 FE FF     add di, 0xfffe
6D6E  06              push es
6D6F  57              push di
6D70  6A 02           push 2
6D72  9A 03 02 AC 24  call far 24AC:0203
6D77  83 7E FE 0A     cmp word ptr [bp - 2], 0xa
6D7B  75 C8           jne 0x6d45
6D7D  C9              leave
6D7E  C2 06 00        ret 6

; ---- routine 1B51:6D81  (found by: call)
sub_6D81:
6D81  55              push bp
6D82  89 E5           mov bp, sp
6D84  C4 7E 06        les di, ptr [bp + 6]
6D87  06              push es
6D88  57              push di
6D89  8B 7E 04        mov di, word ptr [bp + 4]
6D8C  57              push di
6D8D  E8 95 FF        call 0x6d25
6D90  C4 7E 06        les di, ptr [bp + 6]
6D93  06              push es
6D94  57              push di
6D95  8B 7E 04        mov di, word ptr [bp + 4]
6D98  57              push di
6D99  E8 A9 FE        call 0x6c45
6D9C  8B 7E 04        mov di, word ptr [bp + 4]
6D9F  81 C7 D2 FF     add di, 0xffd2
6DA3  16              push ss
6DA4  57              push di
6DA5  C4 7E 06        les di, ptr [bp + 6]
6DA8  06              push es
6DA9  57              push di
6DAA  6A 28           push 0x28
6DAC  9A C2 01 AC 24  call far 24AC:01C2
6DB1  C9              leave
6DB2  C2 06 00        ret 6

; ---- routine 1B51:6DB5  (found by: far)
sub_6DB5:
6DB5  C8 2E 00 00     enter 0x2e, 0
6DB9  C7 46 FC 01 00  mov word ptr [bp - 4], 1
6DBE  EB 03           jmp 0x6dc3
loc_6DC0:
6DC0  FF 46 FC        inc word ptr [bp - 4]
loc_6DC3:
6DC3  8B 7E FC        mov di, word ptr [bp - 4]
6DC6  80 BD B9 DC 00  cmp byte ptr [di - 0x2347], 0
6DCB  74 4B           je 0x6e18
6DCD  31 C0           xor ax, ax
6DCF  89 46 FE        mov word ptr [bp - 2], ax
6DD2  8B 7E FC        mov di, word ptr [bp - 4]
6DD5  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
6DD9  30 E4           xor ah, ah
6DDB  C4 3E B6 D7     les di, ptr [0xd7b6]
6DDF  03 F8           add di, ax
6DE1  26 8A 45 FF     mov al, byte ptr es:[di - 1]
6DE5  88 46 FB        mov byte ptr [bp - 5], al
6DE8  8B 7E FC        mov di, word ptr [bp - 4]
6DEB  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
6DEF  30 E4           xor ah, ah
6DF1  6B C0 3E        imul ax, ax, 0x3e
6DF4  C4 3E C2 D7     les di, ptr [0xd7c2]
6DF8  03 F8           add di, ax
6DFA  81 C7 C2 FF     add di, 0xffc2
6DFE  06              push es
6DFF  57              push di
6E00  55              push bp
6E01  E8 7D FF        call 0x6d81
6E04  6B 46 FC 28     imul ax, word ptr [bp - 4], 0x28
6E08  C4 3E D2 D7     les di, ptr [0xd7d2]
6E0C  03 F8           add di, ax
6E0E  81 C7 30 00     add di, 0x30
6E12  06              push es
6E13  57              push di
6E14  55              push bp
6E15  E8 69 FF        call 0x6d81
loc_6E18:
6E18  83 7E FC 02     cmp word ptr [bp - 4], 2
6E1C  75 A2           jne 0x6dc0
6E1E  C9              leave
6E1F  CB              retf

; ---- routine 1B51:6E20  (found by: call)
sub_6E20:
6E20  C8 52 00 00     enter 0x52, 0
6E24  8C D3           mov bx, ss
6E26  8E C3           mov es, bx
6E28  8C DB           mov bx, ds
6E2A  FC              cld
6E2B  8D 7E AE        lea di, [bp - 0x52]
6E2E  C5 76 06        lds si, ptr [bp + 6]
6E31  AC              lodsb al, byte ptr [si]
6E32  3C 50           cmp al, 0x50
6E34  72 02           jb 0x6e38
6E36  B0 50           mov al, 0x50
loc_6E38:
6E38  AA              stosb byte ptr es:[di], al
6E39  91              xchg cx, ax
6E3A  30 ED           xor ch, ch
6E3C  F3 A4           rep movsb byte ptr es:[di], byte ptr [si]
6E3E  8E DB           mov ds, bx
6E40  BF 70 2B        mov di, 0x2b70
6E43  1E              push ds
6E44  57              push di
6E45  BF 5C DD        mov di, 0xdd5c
6E48  1E              push ds
6E49  57              push di
6E4A  9A 2F 05 1A 23  call far 231A:052F
6E4F  8B 7E 04        mov di, word ptr [bp + 4]
6E52  36 8B 7D 08     mov di, word ptr ss:[di + 8]
6E56  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
6E5A  30 E4           xor ah, ah
6E5C  50              push ax
6E5D  6A 01           push 1
6E5F  6A 01           push 1
6E61  0E              push cs
6E62  E8 DE 9F        call 0xe43
6E65  BF DA 4E        mov di, 0x4eda
6E68  1E              push ds
6E69  57              push di
6E6A  BF 5C DD        mov di, 0xdd5c
6E6D  1E              push ds
6E6E  57              push di
6E6F  9A 2F 05 1A 23  call far 231A:052F
6E74  6A 0F           push 0xf
6E76  8D 7E AE        lea di, [bp - 0x52]
6E79  16              push ss
6E7A  57              push di
6E7B  6A 17           push 0x17
6E7D  6A 01           push 1
6E7F  BF 5C DD        mov di, 0xdd5c
6E82  1E              push ds
6E83  57              push di
6E84  9A 1B 04 1A 23  call far 231A:041B
6E89  C4 3E 5C DD     les di, ptr [0xdd5c]
6E8D  06              push es
6E8E  57              push di
6E8F  C4 3E 58 DD     les di, ptr [0xdd58]
6E93  06              push es
6E94  57              push di
6E95  68 A0 0F        push 0xfa0
6E98  9A 12 0A B9 26  call far 26B9:0A12
6E9D  9A 9B 09 1A 23  call far 231A:099B
6EA2  C9              leave
6EA3  C2 06 00        ret 6
; data (not reached as code), 26 bytes
6EA6                  pstr 'THE '
6EAB                  pstr 'ON GAINING PROMOTION'

; ---- routine 1B51:6EC0  (found by: call, far)
sub_6EC0:
6EC0  C8 04 02 00     enter 0x204, 0
6EC4  8B 7E 08        mov di, word ptr [bp + 8]
6EC7  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
6ECB  30 E4           xor ah, ah
6ECD  6B C0 3E        imul ax, ax, 0x3e
6ED0  C4 3E C2 D7     les di, ptr [0xd7c2]
6ED4  03 F8           add di, ax
6ED6  81 C7 C2 FF     add di, 0xffc2
6EDA  89 7E FC        mov word ptr [bp - 4], di
6EDD  8C 46 FE        mov word ptr [bp - 2], es
6EE0  80 7E 06 00     cmp byte ptr [bp + 6], 0
6EE4  74 3C           je 0x6f22
6EE6  8D BE FC FE     lea di, [bp - 0x104]
6EEA  16              push ss
6EEB  57              push di
6EEC  BF 18 13        mov di, 0x1318
6EEF  1E              push ds
6EF0  57              push di
6EF1  9A 53 0B B9 26  call far 26B9:0B53
6EF6  BF A6 6E        mov di, 0x6ea6
6EF9  0E              push cs
6EFA  57              push di
6EFB  9A D2 0B B9 26  call far 26B9:0BD2
6F00  8D BE FC FD     lea di, [bp - 0x204]
6F04  16              push ss
6F05  57              push di
6F06  8A 46 06        mov al, byte ptr [bp + 6]
6F09  50              push ax
6F0A  C4 3E D2 D7     les di, ptr [0xd7d2]
6F0E  26 8A 05        mov al, byte ptr es:[di]
6F11  50              push ax
6F12  0E              push cs
6F13  E8 FB A2        call 0x1211
6F16  9A D2 0B B9 26  call far 26B9:0BD2
6F1B  55              push bp
6F1C  E8 01 FF        call 0x6e20
6F1F  E9 AB 00        jmp 0x6fcd
loc_6F22:
6F22  6B 46 08 09     imul ax, word ptr [bp + 8], 9
6F26  C4 3E BC DC     les di, ptr [0xdcbc]
6F2A  03 F8           add di, ax
6F2C  26 8A 45 20     mov al, byte ptr es:[di + 0x20]
6F30  C4 7E FC        les di, ptr [bp - 4]
6F33  26 3A 45 37     cmp al, byte ptr es:[di + 0x37]
6F37  75 74           jne 0x6fad
6F39  26 80 7D 36 01  cmp byte ptr es:[di + 0x36], 1
6F3E  75 6D           jne 0x6fad
6F40  26 80 7D 37 00  cmp byte ptr es:[di + 0x37], 0
6F45  75 38           jne 0x6f7f
6F47  8D BE FC FE     lea di, [bp - 0x104]
6F4B  16              push ss
6F4C  57              push di
6F4D  BF 18 13        mov di, 0x1318
6F50  1E              push ds
6F51  57              push di
6F52  9A 53 0B B9 26  call far 26B9:0B53
6F57  BF A6 6E        mov di, 0x6ea6
6F5A  0E              push cs
6F5B  57              push di
6F5C  9A D2 0B B9 26  call far 26B9:0BD2
6F61  C4 7E FC        les di, ptr [bp - 4]
6F64  26 8A 45 37     mov al, byte ptr es:[di + 0x37]
6F68  98              cwde
6F69  8B F8           mov di, ax
6F6B  C1 E7 04        shl di, 4
6F6E  81 C7 E6 DC     add di, 0xdce6
6F72  1E              push ds
6F73  57              push di
6F74  9A D2 0B B9 26  call far 26B9:0BD2
6F79  55              push bp
6F7A  E8 A3 FE        call 0x6e20
6F7D  EB 2C           jmp 0x6fab
loc_6F7F:
6F7F  8D BE FC FE     lea di, [bp - 0x104]
6F83  16              push ss
6F84  57              push di
6F85  BF 18 13        mov di, 0x1318
6F88  1E              push ds
6F89  57              push di
6F8A  9A 53 0B B9 26  call far 26B9:0B53
6F8F  C4 7E FC        les di, ptr [bp - 4]
6F92  26 8A 45 37     mov al, byte ptr es:[di + 0x37]
6F96  98              cwde
6F97  8B F8           mov di, ax
6F99  C1 E7 04        shl di, 4
6F9C  81 C7 E6 DC     add di, 0xdce6
6FA0  1E              push ds
6FA1  57              push di
6FA2  9A D2 0B B9 26  call far 26B9:0BD2
6FA7  55              push bp
6FA8  E8 75 FE        call 0x6e20
loc_6FAB:
6FAB  EB 20           jmp 0x6fcd
loc_6FAD:
6FAD  6B 46 08 09     imul ax, word ptr [bp + 8], 9
6FB1  C4 3E BC DC     les di, ptr [0xdcbc]
6FB5  03 F8           add di, ax
6FB7  26 8A 45 20     mov al, byte ptr es:[di + 0x20]
6FBB  C4 7E FC        les di, ptr [bp - 4]
6FBE  26 3A 45 37     cmp al, byte ptr es:[di + 0x37]
6FC2  7E 09           jle 0x6fcd
6FC4  BF AB 6E        mov di, 0x6eab
6FC7  0E              push cs
6FC8  57              push di
6FC9  55              push bp
6FCA  E8 53 FE        call 0x6e20
loc_6FCD:
6FCD  C9              leave
6FCE  CA 04 00        retf 4

; ---- routine 1B51:6FD1  (found by: call)
sub_6FD1:
6FD1  C8 06 00 00     enter 6, 0
6FD5  BF 6A 71        mov di, 0x716a
6FD8  1E              push ds
6FD9  57              push di
6FDA  BF 5C DD        mov di, 0xdd5c
6FDD  1E              push ds
6FDE  57              push di
6FDF  9A 2F 05 1A 23  call far 231A:052F
6FE4  BF DA 4E        mov di, 0x4eda
6FE7  1E              push ds
6FE8  57              push di
6FE9  BF 5C DD        mov di, 0xdd5c
6FEC  1E              push ds
6FED  57              push di
6FEE  9A 2F 05 1A 23  call far 231A:052F
6FF3  C6 46 FF 00     mov byte ptr [bp - 1], 0
6FF7  EB 03           jmp 0x6ffc
loc_6FF9:
6FF9  FE 46 FF        inc byte ptr [bp - 1]
loc_6FFC:
6FFC  C4 3E D2 D7     les di, ptr [0xd7d2]
7000  89 7E FA        mov word ptr [bp - 6], di
7003  8C 46 FC        mov word ptr [bp - 4], es
7006  8A 46 FF        mov al, byte ptr [bp - 1]
7009  98              cwde
700A  8B F8           mov di, ax
700C  8A 85 3C A2     mov al, byte ptr [di - 0x5dc4]
7010  50              push ax
7011  8A 46 FF        mov al, byte ptr [bp - 1]
7014  98              cwde
7015  8B F8           mov di, ax
7017  C1 E7 04        shl di, 4
701A  81 C7 E6 DC     add di, 0xdce6
701E  1E              push ds
701F  57              push di
7020  8A 46 FF        mov al, byte ptr [bp - 1]
7023  30 E4           xor ah, ah
7025  05 13 00        add ax, 0x13
7028  50              push ax
7029  6A 0F           push 0xf
702B  BF 5C DD        mov di, 0xdd5c
702E  1E              push ds
702F  57              push di
7030  9A 1B 04 1A 23  call far 231A:041B
7035  8A 46 FF        mov al, byte ptr [bp - 1]
7038  98              cwde
7039  C4 7E FA        les di, ptr [bp - 6]
703C  03 F8           add di, ax
703E  26 8A 45 21     mov al, byte ptr es:[di + 0x21]
7042  30 E4           xor ah, ah
7044  50              push ax
7045  8A 46 FF        mov al, byte ptr [bp - 1]
7048  30 E4           xor ah, ah
704A  05 13 00        add ax, 0x13
704D  50              push ax
704E  6A 33           push 0x33
7050  0E              push cs
7051  E8 EF 9D        call 0xe43
7054  8A 46 FF        mov al, byte ptr [bp - 1]
7057  98              cwde
7058  D1 E0           shl ax, 1
705A  C4 7E FA        les di, ptr [bp - 6]
705D  03 F8           add di, ax
705F  26 6B 45 26 0B  imul ax, word ptr es:[di + 0x26], 0xb
7064  C4 3E CC DC     les di, ptr [0xdccc]
7068  03 F8           add di, ax
706A  06              push es
706B  57              push di
706C  8A 46 FF        mov al, byte ptr [bp - 1]
706F  30 E4           xor ah, ah
7071  05 13 00        add ax, 0x13
7074  50              push ax
7075  6A 20           push 0x20
7077  BF 5C DD        mov di, 0xdd5c
707A  1E              push ds
707B  57              push di
707C  9A 9D 03 1A 23  call far 231A:039D
7081  80 7E FF 04     cmp byte ptr [bp - 1], 4
7085  74 03           je 0x708a
7087  E9 6F FF        jmp 0x6ff9
loc_708A:
708A  C4 3E 5C DD     les di, ptr [0xdd5c]
708E  06              push es
708F  57              push di
7090  C4 3E 58 DD     les di, ptr [0xdd58]
7094  06              push es
7095  57              push di
7096  68 A0 0F        push 0xfa0
7099  9A 12 0A B9 26  call far 26B9:0A12
709E  9A 9B 09 1A 23  call far 231A:099B
70A3  C9              leave
70A4  C3              ret

