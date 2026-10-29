; 1-0.EXE (One-Nil 96), code segment 1B55 (image offsets 1B550..2315F), part 9 of 12
; packed 1-0.EXE sha256 89ff9c5f238f24e81a0c2440a46cdd8997280a65fc3cc3d97cb974f55280a80a (LZEXE 0.91)
; unpacked (tools/static/unlzexe.py) sha256 887ed2a92767950e5309b2052409f875668605939b69e00737aa3047022b9f51
; tool: capstone 5.0.9 (pip package; core library 5.0.1280) (CS_ARCH_X86, CS_MODE_16), recursive descent from the entry point, far calls and near calls/jumps, then routine prologues (55 89 E5 / 55 8B EC / C8 iw 00) in what remains; tools/static/listing.py
; addresses are SEGMENT:OFFSET with SEGMENT the image paragraph before relocation; image offset = SEGMENT*16+OFFSET
; ---- routine 1B55:56E7  (found by: call)
sub_56E7:
56E7  C8 0C 00 00     enter 0xc, 0
56EB  6B 46 06 3E     imul ax, word ptr [bp + 6], 0x3e
56EF  C4 3E C2 D7     les di, ptr [0xd7c2]
56F3  03 F8           add di, ax
56F5  81 C7 C2 FF     add di, 0xffc2
56F9  89 7E FA        mov word ptr [bp - 6], di
56FC  8C 46 FC        mov word ptr [bp - 4], es
56FF  26 8A 45 32     mov al, byte ptr es:[di + 0x32]
5703  30 E4           xor ah, ah
5705  89 46 F8        mov word ptr [bp - 8], ax
5708  B8 01 00        mov ax, 1
570B  3B 46 F8        cmp ax, word ptr [bp - 8]
570E  76 03           jbe 0x5713
5710  E9 5E 02        jmp 0x5971
loc_5713:
5713  89 46 FE        mov word ptr [bp - 2], ax
5716  EB 03           jmp 0x571b
loc_5718:
5718  FF 46 FE        inc word ptr [bp - 2]
loc_571B:
571B  8B 46 FE        mov ax, word ptr [bp - 2]
571E  D1 E0           shl ax, 1
5720  C4 7E FA        les di, ptr [bp - 6]
5723  03 F8           add di, ax
5725  26 8B 45 FE     mov ax, word ptr es:[di - 2]
5729  C1 E0 03        shl ax, 3
572C  C4 3E BA D7     les di, ptr [0xd7ba]
5730  03 F8           add di, ax
5732  89 7E F4        mov word ptr [bp - 0xc], di
5735  8C 46 F6        mov word ptr [bp - 0xa], es
5738  8B 46 FE        mov ax, word ptr [bp - 2]
573B  D1 E0           shl ax, 1
573D  C4 7E FA        les di, ptr [bp - 6]
5740  03 F8           add di, ax
5742  26 8B 45 FE     mov ax, word ptr es:[di - 2]
5746  C4 3E 84 DE     les di, ptr [0xde84]
574A  26 89 05        mov word ptr es:[di], ax
574D  8A 46 06        mov al, byte ptr [bp + 6]
5750  C4 7E F4        les di, ptr [bp - 0xc]
5753  26 88 05        mov byte ptr es:[di], al
5756  83 7E FE 0E     cmp word ptr [bp - 2], 0xe
575A  73 22           jae 0x577e
575C  8B 56 FE        mov dx, word ptr [bp - 2]
575F  26 8A 05        mov al, byte ptr es:[di]
5762  30 E4           xor ah, ah
5764  8B F8           mov di, ax
5766  8A 85 85 D8     mov al, byte ptr [di - 0x277b]
576A  30 E4           xor ah, ah
576C  6B F8 0E        imul di, ax, 0xe
576F  03 FA           add di, dx
5771  8A 85 04 94     mov al, byte ptr [di - 0x6bfc]
5775  C4 7E F4        les di, ptr [bp - 0xc]
5778  26 88 45 07     mov byte ptr es:[di + 7], al
577C  EB 2B           jmp 0x57a9
loc_577E:
577E  8B 7E FE        mov di, word ptr [bp - 2]
5781  8A 85 84 0D     mov al, byte ptr [di + 0xd84]
5785  30 E4           xor ah, ah
5787  8B D0           mov dx, ax
5789  C4 7E F4        les di, ptr [bp - 0xc]
578C  26 8A 05        mov al, byte ptr es:[di]
578F  30 E4           xor ah, ah
5791  8B F8           mov di, ax
5793  8A 85 85 D8     mov al, byte ptr [di - 0x277b]
5797  30 E4           xor ah, ah
5799  6B F8 0E        imul di, ax, 0xe
579C  03 FA           add di, dx
579E  8A 85 04 94     mov al, byte ptr [di - 0x6bfc]
57A2  C4 7E F4        les di, ptr [bp - 0xc]
57A5  26 88 45 07     mov byte ptr es:[di + 7], al
loc_57A9:
57A9  C4 7E F4        les di, ptr [bp - 0xc]
57AC  26 8A 45 07     mov al, byte ptr es:[di + 7]
57B0  26 88 45 06     mov byte ptr es:[di + 6], al
57B4  6A 10           push 0x10
57B6  9A 6D 07 2A 23  call far 232A:076D
57BB  C4 7E F4        les di, ptr [bp - 0xc]
57BE  26 88 45 05     mov byte ptr es:[di + 5], al
57C2  26 80 7D 01 00  cmp byte ptr es:[di + 1], 0
57C7  75 33           jne 0x57fc
57C9  6A 07           push 7
57CB  9A 6D 07 2A 23  call far 232A:076D
57D0  50              push ax
57D1  6A 07           push 7
57D3  9A 6D 07 2A 23  call far 232A:076D
57D8  8B D0           mov dx, ax
57DA  C4 7E F4        les di, ptr [bp - 0xc]
57DD  26 80 7D 07 00  cmp byte ptr es:[di + 7], 0
57E2  B0 00           mov al, 0
57E4  75 01           jne 0x57e7
57E6  40              inc ax
loc_57E7:
57E7  98              cwde
57E8  8B F8           mov di, ax
57EA  8A 85 DE 12     mov al, byte ptr [di + 0x12de]
57EE  30 E4           xor ah, ah
57F0  2B C2           sub ax, dx
57F2  5A              pop dx
57F3  03 C2           add ax, dx
57F5  C4 7E F4        les di, ptr [bp - 0xc]
57F8  26 88 45 01     mov byte ptr es:[di + 1], al
loc_57FC:
57FC  8B 46 FE        mov ax, word ptr [bp - 2]
57FF  D1 E0           shl ax, 1
5801  C4 7E FA        les di, ptr [bp - 6]
5804  03 F8           add di, ax
5806  26 FF 75 FE     push word ptr es:[di - 2]
580A  0E              push cs
580B  E8 4D FB        call 0x535b
580E  80 3E A4 0D 00  cmp byte ptr [0xda4], 0
5813  74 1C           je 0x5831
5815  C4 7E FA        les di, ptr [bp - 6]
5818  26 8A 45 33     mov al, byte ptr es:[di + 0x33]
581C  30 E4           xor ah, ah
581E  8B D0           mov dx, ax
5820  B8 B0 00        mov ax, 0xb0
5823  2B C2           sub ax, dx
5825  05 50 00        add ax, 0x50
5828  C4 7E F4        les di, ptr [bp - 0xc]
582B  26 88 45 03     mov byte ptr es:[di + 3], al
582F  EB 1D           jmp 0x584e
loc_5831:
5831  C4 7E F4        les di, ptr [bp - 0xc]
5834  26 80 7D 03 00  cmp byte ptr es:[di + 3], 0
5839  75 13           jne 0x584e
583B  A0 8F D7        mov al, byte ptr [0xd78f]
583E  30 E4           xor ah, ah
5840  8B D0           mov dx, ax
5842  B8 B0 00        mov ax, 0xb0
5845  2B C2           sub ax, dx
5847  05 50 00        add ax, 0x50
584A  26 88 45 03     mov byte ptr es:[di + 3], al
loc_584E:
584E  8B 46 FE        mov ax, word ptr [bp - 2]
5851  D1 E0           shl ax, 1
5853  C4 7E FA        les di, ptr [bp - 6]
5856  03 F8           add di, ax
5858  26 FF 75 FE     push word ptr es:[di - 2]
585C  0E              push cs
585D  E8 24 FA        call 0x5284
5860  C4 7E F4        les di, ptr [bp - 0xc]
5863  26 8A 55 04     mov dl, byte ptr es:[di + 4]
5867  8B 46 FE        mov ax, word ptr [bp - 2]
586A  D1 E0           shl ax, 1
586C  C4 7E FA        les di, ptr [bp - 6]
586F  03 F8           add di, ax
5871  26 6B 45 FE 0F  imul ax, word ptr es:[di - 2], 0xf
5876  C4 3E BE D7     les di, ptr [0xd7be]
587A  03 F8           add di, ax
587C  26 88 55 09     mov byte ptr es:[di + 9], dl
5880  6A 20           push 0x20
5882  9A 6D 07 2A 23  call far 232A:076D
5887  8A D0           mov dl, al
5889  8B 46 FE        mov ax, word ptr [bp - 2]
588C  D1 E0           shl ax, 1
588E  C4 7E FA        les di, ptr [bp - 6]
5891  03 F8           add di, ax
5893  26 6B 45 FE 0F  imul ax, word ptr es:[di - 2], 0xf
5898  C4 3E BE D7     les di, ptr [0xd7be]
589C  03 F8           add di, ax
589E  26 88 55 06     mov byte ptr es:[di + 6], dl
58A2  C4 7E FA        les di, ptr [bp - 6]
58A5  26 8A 45 32     mov al, byte ptr es:[di + 0x32]
58A9  30 E4           xor ah, ah
58AB  50              push ax
58AC  9A 1C 0D BC 24  call far 24BC:0D1C
58B1  08 C0           or al, al
58B3  74 1C           je 0x58d1
58B5  8B 46 FE        mov ax, word ptr [bp - 2]
58B8  D1 E0           shl ax, 1
58BA  C4 7E FA        les di, ptr [bp - 6]
58BD  03 F8           add di, ax
58BF  26 6B 45 FE 0F  imul ax, word ptr es:[di - 2], 0xf
58C4  C4 3E BE D7     les di, ptr [0xd7be]
58C8  03 F8           add di, ax
58CA  26 C6 45 0D 02  mov byte ptr es:[di + 0xd], 2
58CF  EB 12           jmp 0x58e3
loc_58D1:
58D1  8B 46 FE        mov ax, word ptr [bp - 2]
58D4  D1 E0           shl ax, 1
58D6  C4 7E FA        les di, ptr [bp - 6]
58D9  03 F8           add di, ax
58DB  26 FF 75 FE     push word ptr es:[di - 2]
58DF  0E              push cs
58E0  E8 74 0C        call 0x6557
loc_58E3:
58E3  6A 39           push 0x39
58E5  9A 6D 07 2A 23  call far 232A:076D
58EA  8A D0           mov dl, al
58EC  8B 46 FE        mov ax, word ptr [bp - 2]
58EF  D1 E0           shl ax, 1
58F1  C4 7E FA        les di, ptr [bp - 6]
58F4  03 F8           add di, ax
58F6  26 6B 45 FE 0F  imul ax, word ptr es:[di - 2], 0xf
58FB  C4 3E BE D7     les di, ptr [0xd7be]
58FF  03 F8           add di, ax
5901  26 28 55 0C     sub byte ptr es:[di + 0xc], dl
5905  C4 7E F4        les di, ptr [bp - 0xc]
5908  26 80 7D 04 B4  cmp byte ptr es:[di + 4], 0xb4
590D  76 22           jbe 0x5931
590F  6A 01           push 1
5911  8B 46 FE        mov ax, word ptr [bp - 2]
5914  D1 E0           shl ax, 1
5916  C4 7E FA        les di, ptr [bp - 6]
5919  03 F8           add di, ax
591B  26 6B 45 FE 0F  imul ax, word ptr es:[di - 2], 0xf
5920  C4 3E BE D7     les di, ptr [0xd7be]
5924  03 F8           add di, ax
5926  81 C7 0B 00     add di, 0xb
592A  06              push es
592B  57              push di
592C  9A D5 00 2A 23  call far 232A:00D5
loc_5931:
5931  8B 46 FE        mov ax, word ptr [bp - 2]
5934  D1 E0           shl ax, 1
5936  C4 7E FA        les di, ptr [bp - 6]
5939  03 F8           add di, ax
593B  26 FF 75 FE     push word ptr es:[di - 2]
593F  0E              push cs
5940  E8 B8 FA        call 0x53fb
5943  8B 46 FE        mov ax, word ptr [bp - 2]
5946  D1 E0           shl ax, 1
5948  C4 7E FA        les di, ptr [bp - 6]
594B  03 F8           add di, ax
594D  26 FF 75 FE     push word ptr es:[di - 2]
5951  0E              push cs
5952  E8 51 FB        call 0x54a6
5955  8B 46 FE        mov ax, word ptr [bp - 2]
5958  D1 E0           shl ax, 1
595A  C4 7E FA        les di, ptr [bp - 6]
595D  03 F8           add di, ax
595F  26 FF 75 FE     push word ptr es:[di - 2]
5963  E8 B0 FB        call 0x5516
5966  8B 46 FE        mov ax, word ptr [bp - 2]
5969  3B 46 F8        cmp ax, word ptr [bp - 8]
596C  74 03           je 0x5971
596E  E9 A7 FD        jmp 0x5718
loc_5971:
5971  C9              leave
5972  CA 02 00        retf 2

; ---- routine 1B55:5975  (found by: call)
sub_5975:
5975  C8 02 00 00     enter 2, 0
5979  C7 46 FE 01 00  mov word ptr [bp - 2], 1
597E  EB 03           jmp 0x5983
loc_5980:
5980  FF 46 FE        inc word ptr [bp - 2]
loc_5983:
5983  8B 46 FE        mov ax, word ptr [bp - 2]
5986  D1 E0           shl ax, 1
5988  C4 7E 06        les di, ptr [bp + 6]
598B  03 F8           add di, ax
598D  26 83 7D FE 00  cmp word ptr es:[di - 2], 0
5992  74 23           je 0x59b7
5994  8B 46 FE        mov ax, word ptr [bp - 2]
5997  D1 E0           shl ax, 1
5999  C4 7E 06        les di, ptr [bp + 6]
599C  03 F8           add di, ax
599E  26 6B 45 FE 0F  imul ax, word ptr es:[di - 2], 0xf
59A3  C4 3E BE D7     les di, ptr [0xd7be]
59A7  03 F8           add di, ax
59A9  26 80 7D 0D 03  cmp byte ptr es:[di + 0xd], 3
59AE  75 07           jne 0x59b7
59B0  8B 7E 04        mov di, word ptr [bp + 4]
59B3  36 FF 45 FA     inc word ptr ss:[di - 6]
loc_59B7:
59B7  83 7E FE 14     cmp word ptr [bp - 2], 0x14
59BB  75 C3           jne 0x5980
59BD  C9              leave
59BE  C2 06 00        ret 6

; ---- routine 1B55:59C1  (found by: call)
sub_59C1:
59C1  C8 06 00 00     enter 6, 0
59C5  C4 3E D2 D7     les di, ptr [0xd7d2]
59C9  89 7E FA        mov word ptr [bp - 6], di
59CC  8C 46 FC        mov word ptr [bp - 4], es
59CF  8B 7E 04        mov di, word ptr [bp + 4]
59D2  31 C0           xor ax, ax
59D4  36 89 45 FA     mov word ptr ss:[di - 6], ax
59D8  C4 7E FA        les di, ptr [bp - 6]
59DB  26 8A 45 04     mov al, byte ptr es:[di + 4]
59DF  30 E4           xor ah, ah
59E1  8B F8           mov di, ax
59E3  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
59E7  30 E4           xor ah, ah
59E9  6B C0 3E        imul ax, ax, 0x3e
59EC  C4 3E C2 D7     les di, ptr [0xd7c2]
59F0  03 F8           add di, ax
59F2  81 C7 C2 FF     add di, 0xffc2
59F6  06              push es
59F7  57              push di
59F8  8B 7E 04        mov di, word ptr [bp + 4]
59FB  57              push di
59FC  E8 76 FF        call 0x5975
59FF  C4 7E FA        les di, ptr [bp - 6]
5A02  26 8A 45 04     mov al, byte ptr es:[di + 4]
5A06  30 E4           xor ah, ah
5A08  6B C0 28        imul ax, ax, 0x28
5A0B  03 F8           add di, ax
5A0D  81 C7 30 00     add di, 0x30
5A11  06              push es
5A12  57              push di
5A13  8B 7E 04        mov di, word ptr [bp + 4]
5A16  57              push di
5A17  E8 5B FF        call 0x5975
5A1A  8B 7E 04        mov di, word ptr [bp + 4]
5A1D  36 83 7D FA 0B  cmp word ptr ss:[di - 6], 0xb
5A22  B0 00           mov al, 0
5A24  72 01           jb 0x5a27
5A26  40              inc ax
loc_5A27:
5A27  88 46 FF        mov byte ptr [bp - 1], al
5A2A  8A 46 FF        mov al, byte ptr [bp - 1]
5A2D  C9              leave
5A2E  C2 02 00        ret 2
; data (not reached as code), 47 bytes
5A31                  pstr 'Your chairman thinks you have enough trialists'

; ---- routine 1B55:5A60  (found by: call)
sub_5A60:
5A60  C8 06 00 00     enter 6, 0
5A64  C6 46 FF FF     mov byte ptr [bp - 1], 0xff
5A68  80 7E 06 00     cmp byte ptr [bp + 6], 0
5A6C  74 08           je 0x5a76
5A6E  55              push bp
5A6F  E8 4F FF        call 0x59c1
5A72  08 C0           or al, al
5A74  75 04           jne 0x5a7a
loc_5A76:
5A76  B0 00           mov al, 0
5A78  EB 02           jmp 0x5a7c
loc_5A7A:
5A7A  B0 01           mov al, 1
loc_5A7C:
5A7C  50              push ax
5A7D  BF 31 5A        mov di, 0x5a31
5A80  0E              push cs
5A81  57              push di
5A82  9A 98 00 2A 23  call far 232A:0098
5A87  08 C0           or al, al
5A89  74 03           je 0x5a8e
5A8B  E9 A7 00        jmp 0x5b35
loc_5A8E:
5A8E  BF 5E 14        mov di, 0x145e
5A91  1E              push ds
5A92  57              push di
5A93  BF 5C DD        mov di, 0xdd5c
5A96  1E              push ds
5A97  57              push di
5A98  9A 2F 05 2A 23  call far 232A:052F
loc_5A9D:
5A9D  BF 6A 13        mov di, 0x136a
5AA0  1E              push ds
5AA1  57              push di
5AA2  BF 5C DD        mov di, 0xdd5c
5AA5  1E              push ds
5AA6  57              push di
5AA7  9A 2F 05 2A 23  call far 232A:052F
5AAC  31 C0           xor ax, ax
5AAE  89 46 FC        mov word ptr [bp - 4], ax
5AB1  EB 03           jmp 0x5ab6
loc_5AB3:
5AB3  FF 46 FC        inc word ptr [bp - 4]
loc_5AB6:
5AB6  8B 7E FC        mov di, word ptr [bp - 4]
5AB9  8A 85 08 87     mov al, byte ptr [di - 0x78f8]
5ABD  50              push ax
5ABE  6B 7E FC 13     imul di, word ptr [bp - 4], 0x13
5AC2  81 C7 24 87     add di, 0x8724
5AC6  1E              push ds
5AC7  57              push di
5AC8  8B 46 FC        mov ax, word ptr [bp - 4]
5ACB  05 05 00        add ax, 5
5ACE  50              push ax
5ACF  6A 3C           push 0x3c
5AD1  BF 5C DD        mov di, 0xdd5c
5AD4  1E              push ds
5AD5  57              push di
5AD6  9A 1B 04 2A 23  call far 232A:041B
5ADB  83 7E FC 0D     cmp word ptr [bp - 4], 0xd
5ADF  75 D2           jne 0x5ab3
5AE1  A0 E0 12        mov al, byte ptr [0x12e0]
5AE4  30 E4           xor ah, ah
5AE6  05 05 00        add ax, 5
5AE9  48              dec ax
5AEA  50              push ax
5AEB  6A 3B           push 0x3b
5AED  6A 14           push 0x14
5AEF  9A 03 02 2A 23  call far 232A:0203
5AF4  C4 3E 5C DD     les di, ptr [0xdd5c]
5AF8  06              push es
5AF9  57              push di
5AFA  C4 3E 58 DD     les di, ptr [0xdd58]
5AFE  06              push es
5AFF  57              push di
5B00  68 A0 0F        push 0xfa0
5B03  9A 12 0A C9 26  call far 26C9:0A12
5B08  9A 9B 09 2A 23  call far 232A:099B
5B0D  BF E0 12        mov di, 0x12e0
5B10  1E              push ds
5B11  57              push di
5B12  6A 0E           push 0xe
5B14  9A C4 0E 2A 23  call far 232A:0EC4
5B19  80 3E 88 DE 01  cmp byte ptr [0xde88], 1
5B1E  75 02           jne 0x5b22
5B20  EB 13           jmp 0x5b35
loc_5B22:
5B22  80 3E 88 DE 02  cmp byte ptr [0xde88], 2
5B27  74 03           je 0x5b2c
5B29  E9 71 FF        jmp 0x5a9d
loc_5B2C:
5B2C  A0 E0 12        mov al, byte ptr [0x12e0]
5B2F  30 E4           xor ah, ah
5B31  48              dec ax
5B32  88 46 FF        mov byte ptr [bp - 1], al
loc_5B35:
5B35  8A 46 FF        mov al, byte ptr [bp - 1]
5B38  C9              leave
5B39  CA 02 00        retf 2

; ---- routine 1B55:5B3C  (found by: call)
sub_5B3C:
5B3C  C8 04 00 00     enter 4, 0
5B40  68 90 01        push 0x190
5B43  9A 6D 07 2A 23  call far 232A:076D
5B48  89 46 FC        mov word ptr [bp - 4], ax
5B4B  81 46 FC C0 0D  add word ptr [bp - 4], 0xdc0
loc_5B50:
5B50  8B 46 FC        mov ax, word ptr [bp - 4]
5B53  C1 E0 03        shl ax, 3
5B56  C4 3E BA D7     les di, ptr [0xd7ba]
5B5A  03 F8           add di, ax
5B5C  26 80 3D 00     cmp byte ptr es:[di], 0
5B60  74 11           je 0x5b73
5B62  FF 46 FC        inc word ptr [bp - 4]
5B65  81 7E FC 50 0F  cmp word ptr [bp - 4], 0xf50
5B6A  76 05           jbe 0x5b71
5B6C  C7 46 FC C1 0D  mov word ptr [bp - 4], 0xdc1
loc_5B71:
5B71  EB DD           jmp 0x5b50
loc_5B73:
5B73  8B 46 FC        mov ax, word ptr [bp - 4]
5B76  89 46 FE        mov word ptr [bp - 2], ax
5B79  8B 46 FE        mov ax, word ptr [bp - 2]
5B7C  C9              leave
5B7D  C3              ret

; ---- routine 1B55:5B7E  (found by: call)
sub_5B7E:
5B7E  C8 0C 00 00     enter 0xc, 0
5B82  6B 46 04 3E     imul ax, word ptr [bp + 4], 0x3e
5B86  C4 3E C2 D7     les di, ptr [0xd7c2]
5B8A  03 F8           add di, ax
5B8C  81 C7 C2 FF     add di, 0xffc2
5B90  89 7E F4        mov word ptr [bp - 0xc], di
5B93  8C 46 F6        mov word ptr [bp - 0xa], es
5B96  C7 46 FA 01 00  mov word ptr [bp - 6], 1
5B9B  EB 03           jmp 0x5ba0
loc_5B9D:
5B9D  FF 46 FA        inc word ptr [bp - 6]
loc_5BA0:
5BA0  31 C0           xor ax, ax
5BA2  89 46 F8        mov word ptr [bp - 8], ax
5BA5  8B 46 FA        mov ax, word ptr [bp - 6]
5BA8  C4 7E F4        les di, ptr [bp - 0xc]
5BAB  03 F8           add di, ax
5BAD  26 8A 45 3A     mov al, byte ptr es:[di + 0x3a]
5BB1  30 E4           xor ah, ah
5BB3  48              dec ax
5BB4  6B C0 14        imul ax, ax, 0x14
5BB7  03 46 F8        add ax, word ptr [bp - 8]
5BBA  89 46 F8        mov word ptr [bp - 8], ax
5BBD  C7 46 FC 01 00  mov word ptr [bp - 4], 1
5BC2  EB 03           jmp 0x5bc7
loc_5BC4:
5BC4  FF 46 FC        inc word ptr [bp - 4]
loc_5BC7:
5BC7  8B 46 FC        mov ax, word ptr [bp - 4]
5BCA  03 46 F8        add ax, word ptr [bp - 8]
5BCD  C1 E0 03        shl ax, 3
5BD0  C4 3E BA D7     les di, ptr [0xd7ba]
5BD4  03 F8           add di, ax
5BD6  26 80 3D 00     cmp byte ptr es:[di], 0
5BDA  75 0B           jne 0x5be7
5BDC  8B 46 FC        mov ax, word ptr [bp - 4]
5BDF  03 46 F8        add ax, word ptr [bp - 8]
5BE2  89 46 FE        mov word ptr [bp - 2], ax
5BE5  EB 41           jmp 0x5c28
loc_5BE7:
5BE7  83 7E FC 14     cmp word ptr [bp - 4], 0x14
5BEB  75 D7           jne 0x5bc4
5BED  83 7E FA 03     cmp word ptr [bp - 6], 3
5BF1  75 AA           jne 0x5b9d
5BF3  68 C0 0D        push 0xdc0
5BF6  9A 6D 07 2A 23  call far 232A:076D
5BFB  48              dec ax
5BFC  89 46 FA        mov word ptr [bp - 6], ax
loc_5BFF:
5BFF  8B 46 FA        mov ax, word ptr [bp - 6]
5C02  C1 E0 03        shl ax, 3
5C05  C4 3E BA D7     les di, ptr [0xd7ba]
5C09  03 F8           add di, ax
5C0B  26 80 3D 00     cmp byte ptr es:[di], 0
5C0F  74 11           je 0x5c22
5C11  FF 46 FA        inc word ptr [bp - 6]
5C14  81 7E FA C0 0D  cmp word ptr [bp - 6], 0xdc0
5C19  76 05           jbe 0x5c20
5C1B  C7 46 FA 01 00  mov word ptr [bp - 6], 1
loc_5C20:
5C20  EB DD           jmp 0x5bff
loc_5C22:
5C22  8B 46 FA        mov ax, word ptr [bp - 6]
5C25  89 46 FE        mov word ptr [bp - 2], ax
loc_5C28:
5C28  8B 46 FE        mov ax, word ptr [bp - 2]
5C2B  C9              leave
5C2C  C2 02 00        ret 2

; ---- routine 1B55:5C2F  (found by: call)
sub_5C2F:
5C2F  C8 04 00 00     enter 4, 0
5C33  6B 46 04 0F     imul ax, word ptr [bp + 4], 0xf
5C37  C4 3E BE D7     les di, ptr [0xd7be]
5C3B  03 F8           add di, ax
5C3D  89 7E FC        mov word ptr [bp - 4], di
5C40  8C 46 FE        mov word ptr [bp - 2], es
5C43  6A 20           push 0x20
5C45  9A 6D 07 2A 23  call far 232A:076D
5C4A  C4 7E FC        les di, ptr [bp - 4]
5C4D  26 88 45 06     mov byte ptr es:[di + 6], al
5C51  6A 10           push 0x10
5C53  9A 6D 07 2A 23  call far 232A:076D
5C58  05 08 00        add ax, 8
5C5B  C4 7E FC        les di, ptr [bp - 4]
5C5E  26 88 45 07     mov byte ptr es:[di + 7], al
5C62  26 8A 45 07     mov al, byte ptr es:[di + 7]
5C66  26 88 45 08     mov byte ptr es:[di + 8], al
5C6A  C9              leave
5C6B  C2 02 00        ret 2

; ---- routine 1B55:5C6E  (found by: far)
sub_5C6E:
5C6E  C8 04 00 00     enter 4, 0
5C72  31 C0           xor ax, ax
5C74  89 46 FE        mov word ptr [bp - 2], ax
5C77  C7 46 FC 01 00  mov word ptr [bp - 4], 1
5C7C  EB 03           jmp 0x5c81
loc_5C7E:
5C7E  FF 46 FC        inc word ptr [bp - 4]
loc_5C81:
5C81  8B 46 FC        mov ax, word ptr [bp - 4]
5C84  D1 E0           shl ax, 1
5C86  C4 7E 06        les di, ptr [bp + 6]
5C89  03 F8           add di, ax
5C8B  26 8B 45 FE     mov ax, word ptr es:[di - 2]
5C8F  3B 46 0A        cmp ax, word ptr [bp + 0xa]
5C92  75 08           jne 0x5c9c
5C94  8B 46 FC        mov ax, word ptr [bp - 4]
5C97  89 46 FE        mov word ptr [bp - 2], ax
5C9A  EB 06           jmp 0x5ca2
loc_5C9C:
5C9C  83 7E FC 14     cmp word ptr [bp - 4], 0x14
5CA0  75 DC           jne 0x5c7e
loc_5CA2:
5CA2  8B 46 FE        mov ax, word ptr [bp - 2]
5CA5  C9              leave
5CA6  CA 06 00        retf 6

; ---- routine 1B55:5CA9  (found by: call, far)
sub_5CA9:
5CA9  C8 04 00 00     enter 4, 0
5CAD  31 C0           xor ax, ax
5CAF  89 46 FE        mov word ptr [bp - 2], ax
5CB2  C7 46 FC 01 00  mov word ptr [bp - 4], 1
5CB7  EB 03           jmp 0x5cbc
loc_5CB9:
5CB9  FF 46 FC        inc word ptr [bp - 4]
loc_5CBC:
5CBC  8B 46 FC        mov ax, word ptr [bp - 4]
5CBF  D1 E0           shl ax, 1
5CC1  C4 7E 06        les di, ptr [bp + 6]
5CC4  03 F8           add di, ax
5CC6  26 83 7D FE 00  cmp word ptr es:[di - 2], 0
5CCB  75 0B           jne 0x5cd8
5CCD  8B 46 FC        mov ax, word ptr [bp - 4]
5CD0  89 46 FE        mov word ptr [bp - 2], ax
5CD3  C7 46 FC 14 00  mov word ptr [bp - 4], 0x14
loc_5CD8:
5CD8  83 7E FC 14     cmp word ptr [bp - 4], 0x14
5CDC  75 DB           jne 0x5cb9
5CDE  8B 46 FE        mov ax, word ptr [bp - 2]
5CE1  C9              leave
5CE2  CA 04 00        retf 4
; data (not reached as code), 22 bytes
5CE5                  pstr 'You have a full squad'

; ---- routine 1B55:5CFB  (found by: call, far)
sub_5CFB:
5CFB  C8 02 00 00     enter 2, 0
5CFF  8B 7E 06        mov di, word ptr [bp + 6]
5D02  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
5D06  30 E4           xor ah, ah
5D08  6B C0 3E        imul ax, ax, 0x3e
5D0B  C4 3E C2 D7     les di, ptr [0xd7c2]
5D0F  03 F8           add di, ax
5D11  81 C7 C2 FF     add di, 0xffc2
5D15  06              push es
5D16  57              push di
5D17  0E              push cs
5D18  E8 8E FF        call 0x5ca9
5D1B  09 C0           or ax, ax
5D1D  75 18           jne 0x5d37
5D1F  6B 46 06 28     imul ax, word ptr [bp + 6], 0x28
5D23  C4 3E D2 D7     les di, ptr [0xd7d2]
5D27  03 F8           add di, ax
5D29  81 C7 30 00     add di, 0x30
5D2D  06              push es
5D2E  57              push di
5D2F  0E              push cs
5D30  E8 76 FF        call 0x5ca9
5D33  09 C0           or ax, ax
5D35  74 04           je 0x5d3b
loc_5D37:
5D37  B0 00           mov al, 0
5D39  EB 02           jmp 0x5d3d
loc_5D3B:
5D3B  B0 01           mov al, 1
loc_5D3D:
5D3D  88 46 FE        mov byte ptr [bp - 2], al
5D40  80 7E FE 00     cmp byte ptr [bp - 2], 0
5D44  74 0A           je 0x5d50
5D46  BF E5 5C        mov di, 0x5ce5
5D49  0E              push cs
5D4A  57              push di
5D4B  9A 02 07 BC 24  call far 24BC:0702
loc_5D50:
5D50  8A 46 FE        mov al, byte ptr [bp - 2]
5D53  88 46 FF        mov byte ptr [bp - 1], al
5D56  8A 46 FF        mov al, byte ptr [bp - 1]
5D59  C9              leave
5D5A  CA 02 00        retf 2

; ---- routine 1B55:5D5D  (found by: call)
sub_5D5D:
5D5D  C8 02 00 00     enter 2, 0
5D61  C7 46 FE 01 00  mov word ptr [bp - 2], 1
5D66  EB 03           jmp 0x5d6b
loc_5D68:
5D68  FF 46 FE        inc word ptr [bp - 2]
loc_5D6B:
5D6B  8B 46 FE        mov ax, word ptr [bp - 2]
5D6E  D1 E0           shl ax, 1
5D70  C4 7E 06        les di, ptr [bp + 6]
5D73  03 F8           add di, ax
5D75  26 83 7D FE 00  cmp word ptr es:[di - 2], 0
5D7A  74 41           je 0x5dbd
5D7C  8B 46 FE        mov ax, word ptr [bp - 2]
5D7F  D1 E0           shl ax, 1
5D81  C4 7E 06        les di, ptr [bp + 6]
5D84  03 F8           add di, ax
5D86  26 8B 45 FE     mov ax, word ptr es:[di - 2]
5D8A  C1 E0 03        shl ax, 3
5D8D  C4 3E BA D7     les di, ptr [0xd7ba]
5D91  03 F8           add di, ax
5D93  26 80 7D 01 11  cmp byte ptr es:[di + 1], 0x11
5D98  76 23           jbe 0x5dbd
5D9A  8B 46 FE        mov ax, word ptr [bp - 2]
5D9D  D1 E0           shl ax, 1
5D9F  C4 7E 06        les di, ptr [bp + 6]
5DA2  03 F8           add di, ax
5DA4  26 6B 45 FE 0F  imul ax, word ptr es:[di - 2], 0xf
5DA9  C4 3E BE D7     les di, ptr [0xd7be]
5DAD  03 F8           add di, ax
5DAF  26 80 7D 0C 00  cmp byte ptr es:[di + 0xc], 0
5DB4  76 07           jbe 0x5dbd
5DB6  8B 7E 04        mov di, word ptr [bp + 4]
5DB9  36 FF 45 FC     inc word ptr ss:[di - 4]
loc_5DBD:
5DBD  83 7E FE 14     cmp word ptr [bp - 2], 0x14
5DC1  75 A5           jne 0x5d68
5DC3  C9              leave
5DC4  C2 06 00        ret 6

; ---- routine 1B55:5DC7  (found by: far)
sub_5DC7:
5DC7  C8 0C 00 00     enter 0xc, 0
5DCB  C4 3E D2 D7     les di, ptr [0xd7d2]
5DCF  89 7E F4        mov word ptr [bp - 0xc], di
5DD2  8C 46 F6        mov word ptr [bp - 0xa], es
5DD5  31 C0           xor ax, ax
5DD7  89 46 FC        mov word ptr [bp - 4], ax
5DDA  8B 7E 06        mov di, word ptr [bp + 6]
5DDD  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
5DE1  30 E4           xor ah, ah
5DE3  89 46 F8        mov word ptr [bp - 8], ax
5DE6  6B 46 F8 3E     imul ax, word ptr [bp - 8], 0x3e
5DEA  C4 3E C2 D7     les di, ptr [0xd7c2]
5DEE  03 F8           add di, ax
5DF0  81 C7 C2 FF     add di, 0xffc2
5DF4  06              push es
5DF5  57              push di
5DF6  55              push bp
5DF7  E8 63 FF        call 0x5d5d
5DFA  6B 46 06 28     imul ax, word ptr [bp + 6], 0x28
5DFE  C4 7E F4        les di, ptr [bp - 0xc]
5E01  03 F8           add di, ax
5E03  81 C7 30 00     add di, 0x30
5E07  06              push es
5E08  57              push di
5E09  55              push bp
5E0A  E8 50 FF        call 0x5d5d
5E0D  6B 46 F8 3E     imul ax, word ptr [bp - 8], 0x3e
5E11  C4 3E C2 D7     les di, ptr [0xd7c2]
5E15  03 F8           add di, ax
5E17  26 8B 45 F2     mov ax, word ptr es:[di - 0xe]
5E1B  C1 E0 02        shl ax, 2
5E1E  C4 3E C8 DC     les di, ptr [0xdcc8]
5E22  03 F8           add di, ax
5E24  26 8A 45 02     mov al, byte ptr es:[di + 2]
5E28  30 E4           xor ah, ah
5E2A  05 FF FF        add ax, 0xffff
5E2D  99              cdq
5E2E  B9 10 00        mov cx, 0x10
5E31  F7 F9           idiv cx
5E33  40              inc ax
5E34  40              inc ax
5E35  05 14 00        add ax, 0x14
5E38  99              cdq
5E39  8B C8           mov cx, ax
5E3B  8B DA           mov bx, dx
5E3D  8B 46 FC        mov ax, word ptr [bp - 4]
5E40  31 D2           xor dx, dx
5E42  3B D3           cmp dx, bx
5E44  7F 0A           jg 0x5e50
5E46  7C 04           jl 0x5e4c
5E48  3B C1           cmp ax, cx
5E4A  73 04           jae 0x5e50
loc_5E4C:
5E4C  B0 00           mov al, 0
5E4E  EB 02           jmp 0x5e52
loc_5E50:
5E50  B0 01           mov al, 1
loc_5E52:
5E52  88 46 FF        mov byte ptr [bp - 1], al
5E55  8A 46 FF        mov al, byte ptr [bp - 1]
5E58  C9              leave
5E59  CA 02 00        retf 2

; ---- routine 1B55:5E5C  (found by: call)
sub_5E5C:
5E5C  C8 02 00 00     enter 2, 0
5E60  A0 E2 12        mov al, byte ptr [0x12e2]
5E63  30 E4           xor ah, ah
5E65  50              push ax
5E66  9A 6D 07 2A 23  call far 232A:076D
5E6B  8B F8           mov di, ax
5E6D  8A 85 E2 12     mov al, byte ptr [di + 0x12e2]
5E71  88 46 FF        mov byte ptr [bp - 1], al
5E74  8A 46 FF        mov al, byte ptr [bp - 1]
5E77  C9              leave
5E78  C3              ret

; ---- routine 1B55:5E79  (found by: far)
sub_5E79:
5E79  C8 0C 01 00     enter 0x10c, 0
5E7D  31 C0           xor ax, ax
5E7F  A3 84 D6        mov word ptr [0xd684], ax
5E82  FF 76 08        push word ptr [bp + 8]
5E85  0E              push cs
5E86  E8 72 FE        call 0x5cfb
5E89  08 C0           or al, al
5E8B  74 03           je 0x5e90
5E8D  E9 DC 02        jmp 0x616c
loc_5E90:
5E90  6A 01           push 1
5E92  0E              push cs
5E93  E8 CA FB        call 0x5a60
5E96  88 46 F9        mov byte ptr [bp - 7], al
5E99  80 7E F9 FF     cmp byte ptr [bp - 7], 0xff
5E9D  75 03           jne 0x5ea2
5E9F  E9 CA 02        jmp 0x616c
loc_5EA2:
5EA2  E8 97 FC        call 0x5b3c
5EA5  89 46 FE        mov word ptr [bp - 2], ax
5EA8  8A 46 F9        mov al, byte ptr [bp - 7]
5EAB  88 46 F7        mov byte ptr [bp - 9], al
5EAE  80 7E F9 00     cmp byte ptr [bp - 7], 0
5EB2  75 03           jne 0x5eb7
5EB4  E9 92 00        jmp 0x5f49
loc_5EB7:
5EB7  6A 05           push 5
5EB9  9A 6D 07 2A 23  call far 232A:076D
5EBE  05 09 00        add ax, 9
5EC1  88 46 F8        mov byte ptr [bp - 8], al
5EC4  8D BE F4 FE     lea di, [bp - 0x10c]
5EC8  16              push ss
5EC9  57              push di
5ECA  8A 46 F9        mov al, byte ptr [bp - 7]
5ECD  50              push ax
5ECE  9A 6F 0C C9 26  call far 26C9:0C6F
5ED3  BF 9A 0D        mov di, 0xd9a
5ED6  1E              push ds
5ED7  57              push di
5ED8  9A FE 0B C9 26  call far 26C9:0BFE
5EDD  89 46 FA        mov word ptr [bp - 6], ax
5EE0  C6 46 F6 00     mov byte ptr [bp - 0xa], 0
loc_5EE4:
5EE4  6A 0D           push 0xd
5EE6  9A 6D 07 2A 23  call far 232A:076D
5EEB  89 46 F4        mov word ptr [bp - 0xc], ax
5EEE  8A 56 F4        mov dl, byte ptr [bp - 0xc]
5EF1  8B 46 FE        mov ax, word ptr [bp - 2]
5EF4  C1 E0 03        shl ax, 3
5EF7  C4 3E BA D7     les di, ptr [0xd7ba]
5EFB  03 F8           add di, ax
5EFD  26 88 55 07     mov byte ptr es:[di + 7], dl
5F01  8A 46 F8        mov al, byte ptr [bp - 8]
5F04  98              cwde
5F05  8B C8           mov cx, ax
5F07  8B 56 F4        mov dx, word ptr [bp - 0xc]
5F0A  8A 46 F9        mov al, byte ptr [bp - 7]
5F0D  98              cwde
5F0E  6B F8 0E        imul di, ax, 0xe
5F11  03 FA           add di, dx
5F13  8A 85 A6 0D     mov al, byte ptr [di + 0xda6]
5F17  30 E4           xor ah, ah
5F19  3B C1           cmp ax, cx
5F1B  7C 26           jl 0x5f43
5F1D  83 7E FA 00     cmp word ptr [bp - 6], 0
5F21  74 16           je 0x5f39
5F23  FF 76 FE        push word ptr [bp - 2]
5F26  0E              push cs
5F27  E8 57 EF        call 0x4e81
5F2A  8A D0           mov dl, al
5F2C  83 7E FA 03     cmp word ptr [bp - 6], 3
5F30  B0 00           mov al, 0
5F32  76 01           jbe 0x5f35
5F34  40              inc ax
loc_5F35:
5F35  3A C2           cmp al, dl
5F37  75 0A           jne 0x5f43
loc_5F39:
5F39  8A 46 F4        mov al, byte ptr [bp - 0xc]
5F3C  88 46 F9        mov byte ptr [bp - 7], al
5F3F  C6 46 F6 01     mov byte ptr [bp - 0xa], 1
loc_5F43:
5F43  80 7E F6 00     cmp byte ptr [bp - 0xa], 0
5F47  74 9B           je 0x5ee4
loc_5F49:
5F49  8B 7E 08        mov di, word ptr [bp + 8]
5F4C  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
5F50  30 E4           xor ah, ah
5F52  50              push ax
5F53  0E              push cs
5F54  E8 37 BC        call 0x1b8e
5F57  08 C0           or al, al
5F59  75 1F           jne 0x5f7a
5F5B  8B 7E 08        mov di, word ptr [bp + 8]
5F5E  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
5F62  30 E4           xor ah, ah
5F64  C4 3E B6 D7     les di, ptr [0xd7b6]
5F68  03 F8           add di, ax
5F6A  26 8A 55 FF     mov dl, byte ptr es:[di - 1]
5F6E  8B 46 FE        mov ax, word ptr [bp - 2]
5F71  C4 3E AE D7     les di, ptr [0xd7ae]
5F75  03 F8           add di, ax
5F77  26 88 15        mov byte ptr es:[di], dl
loc_5F7A:
5F7A  E8 DF FE        call 0x5e5c
5F7D  8A D0           mov dl, al
5F7F  8B 46 FE        mov ax, word ptr [bp - 2]
5F82  C4 3E AA D7     les di, ptr [0xd7aa]
5F86  03 F8           add di, ax
5F88  26 88 15        mov byte ptr es:[di], dl
5F8B  8B 46 FE        mov ax, word ptr [bp - 2]
5F8E  C1 E0 03        shl ax, 3
5F91  C4 3E BA D7     les di, ptr [0xd7ba]
5F95  03 F8           add di, ax
5F97  06              push es
5F98  57              push di
5F99  6A 08           push 8
5F9B  6A 00           push 0
5F9D  9A 22 02 BC 24  call far 24BC:0222
5FA2  6B 46 FE 0F     imul ax, word ptr [bp - 2], 0xf
5FA6  C4 3E BE D7     les di, ptr [0xd7be]
5FAA  03 F8           add di, ax
5FAC  06              push es
5FAD  57              push di
5FAE  6A 0F           push 0xf
5FB0  6A 00           push 0
5FB2  9A 22 02 BC 24  call far 24BC:0222
5FB7  6B 46 06 3E     imul ax, word ptr [bp + 6], 0x3e
5FBB  C4 3E C2 D7     les di, ptr [0xd7c2]
5FBF  03 F8           add di, ax
5FC1  81 C7 C2 FF     add di, 0xffc2
5FC5  89 7E F0        mov word ptr [bp - 0x10], di
5FC8  8C 46 F2        mov word ptr [bp - 0xe], es
5FCB  6B 46 08 28     imul ax, word ptr [bp + 8], 0x28
5FCF  C4 3E D2 D7     les di, ptr [0xd7d2]
5FD3  03 F8           add di, ax
5FD5  81 C7 30 00     add di, 0x30
5FD9  06              push es
5FDA  57              push di
5FDB  0E              push cs
5FDC  E8 CA FC        call 0x5ca9
5FDF  09 C0           or ax, ax
5FE1  74 2E           je 0x6011
5FE3  FF 76 FE        push word ptr [bp - 2]
5FE6  6B 46 08 28     imul ax, word ptr [bp + 8], 0x28
5FEA  C4 3E D2 D7     les di, ptr [0xd7d2]
5FEE  03 F8           add di, ax
5FF0  81 C7 30 00     add di, 0x30
5FF4  06              push es
5FF5  57              push di
5FF6  0E              push cs
5FF7  E8 AF FC        call 0x5ca9
5FFA  D1 E0           shl ax, 1
5FFC  8B D0           mov dx, ax
5FFE  6B 46 08 28     imul ax, word ptr [bp + 8], 0x28
6002  C4 3E D2 D7     les di, ptr [0xd7d2]
6006  03 F8           add di, ax
6008  03 FA           add di, dx
600A  58              pop ax
600B  26 89 45 2E     mov word ptr es:[di + 0x2e], ax
600F  EB 18           jmp 0x6029
loc_6011:
6011  FF 76 FE        push word ptr [bp - 2]
6014  C4 7E F0        les di, ptr [bp - 0x10]
6017  06              push es
6018  57              push di
6019  0E              push cs
601A  E8 8C FC        call 0x5ca9
601D  D1 E0           shl ax, 1
601F  C4 7E F0        les di, ptr [bp - 0x10]
6022  03 F8           add di, ax
6024  58              pop ax
6025  26 89 45 FE     mov word ptr es:[di - 2], ax
loc_6029:
6029  8B 46 FE        mov ax, word ptr [bp - 2]
602C  C1 E0 03        shl ax, 3
602F  C4 3E BA D7     les di, ptr [0xd7ba]
6033  03 F8           add di, ax
6035  89 7E F0        mov word ptr [bp - 0x10], di
6038  8C 46 F2        mov word ptr [bp - 0xe], es
603B  8A 46 06        mov al, byte ptr [bp + 6]
603E  26 88 05        mov byte ptr es:[di], al
6041  8A 46 F9        mov al, byte ptr [bp - 7]
6044  26 88 45 07     mov byte ptr es:[di + 7], al
6048  8A 46 F7        mov al, byte ptr [bp - 9]
604B  26 88 45 06     mov byte ptr es:[di + 6], al
604F  6A 10           push 0x10
6051  9A 6D 07 2A 23  call far 232A:076D
6056  C4 7E F0        les di, ptr [bp - 0x10]
6059  26 88 45 05     mov byte ptr es:[di + 5], al
605D  26 80 7D 07 00  cmp byte ptr es:[di + 7], 0
6062  75 07           jne 0x606b
6064  26 C6 45 01 11  mov byte ptr es:[di + 1], 0x11
6069  EB 11           jmp 0x607c
loc_606B:
606B  6A 03           push 3
606D  9A 6D 07 2A 23  call far 232A:076D
6072  05 0E 00        add ax, 0xe
6075  C4 7E F0        les di, ptr [bp - 0x10]
6078  26 88 45 01     mov byte ptr es:[di + 1], al
loc_607C:
607C  FF 76 FE        push word ptr [bp - 2]
607F  0E              push cs
6080  E8 D8 F2        call 0x535b
6083  C4 7E F0        les di, ptr [bp - 0x10]
6086  26 8A 05        mov al, byte ptr es:[di]
6089  30 E4           xor ah, ah
608B  6B C0 3E        imul ax, ax, 0x3e
608E  C4 3E C2 D7     les di, ptr [0xd7c2]
6092  03 F8           add di, ax
6094  26 8A 45 F9     mov al, byte ptr es:[di - 7]
6098  98              cwde
6099  8B F8           mov di, ax
609B  8A 85 0A 13     mov al, byte ptr [di + 0x130a]
609F  30 E4           xor ah, ah
60A1  50              push ax
60A2  9A 1C 0D BC 24  call far 24BC:0D1C
60A7  08 C0           or al, al
60A9  74 0D           je 0x60b8
60AB  68 B0 00        push 0xb0
60AE  9A 6D 07 2A 23  call far 232A:076D
60B3  89 46 F4        mov word ptr [bp - 0xc], ax
60B6  EB 47           jmp 0x60ff
loc_60B8:
60B8  6B 46 06 3E     imul ax, word ptr [bp + 6], 0x3e
60BC  C4 3E C2 D7     les di, ptr [0xd7c2]
60C0  03 F8           add di, ax
60C2  26 8B 45 F0     mov ax, word ptr es:[di - 0x10]
60C6  C1 E0 02        shl ax, 2
60C9  C4 3E C8 DC     les di, ptr [0xdcc8]
60CD  03 F8           add di, ax
60CF  26 8A 45 02     mov al, byte ptr es:[di + 2]
60D3  30 E4           xor ah, ah
60D5  50              push ax
60D6  9A 6D 07 2A 23  call far 232A:076D
60DB  50              push ax
60DC  6B 46 06 3E     imul ax, word ptr [bp + 6], 0x3e
60E0  C4 3E C2 D7     les di, ptr [0xd7c2]
60E4  03 F8           add di, ax
60E6  26 8A 45 F5     mov al, byte ptr es:[di - 0xb]
60EA  30 E4           xor ah, ah
60EC  8B D0           mov dx, ax
60EE  B8 B1 00        mov ax, 0xb1
60F1  2B C2           sub ax, dx
60F3  50              push ax
60F4  9A 6D 07 2A 23  call far 232A:076D
60F9  5A              pop dx
60FA  03 C2           add ax, dx
60FC  89 46 F4        mov word ptr [bp - 0xc], ax
loc_60FF:
60FF  8B 46 F4        mov ax, word ptr [bp - 0xc]
6102  05 4F 00        add ax, 0x4f
6105  99              cdq
6106  B9 02 00        mov cx, 2
6109  F7 F9           idiv cx
610B  89 46 F4        mov word ptr [bp - 0xc], ax
610E  8A 46 F4        mov al, byte ptr [bp - 0xc]
6111  C4 7E F0        les di, ptr [bp - 0x10]
6114  26 88 45 03     mov byte ptr es:[di + 3], al
6118  FF 76 FE        push word ptr [bp - 2]
611B  0E              push cs
611C  E8 65 F1        call 0x5284
611F  C4 7E F0        les di, ptr [bp - 0x10]
6122  26 8A 45 04     mov al, byte ptr es:[di + 4]
6126  30 E4           xor ah, ah
6128  D1 E8           shr ax, 1
612A  50              push ax
612B  9A 6D 07 2A 23  call far 232A:076D
6130  C4 7E F0        les di, ptr [bp - 0x10]
6133  26 28 45 04     sub byte ptr es:[di + 4], al
6137  FF 76 FE        push word ptr [bp - 2]
613A  E8 F2 FA        call 0x5c2f
613D  6B 46 FE 0F     imul ax, word ptr [bp - 2], 0xf
6141  C4 3E BE D7     les di, ptr [0xd7be]
6145  03 F8           add di, ax
6147  26 C6 45 09 14  mov byte ptr es:[di + 9], 0x14
614C  26 C6 45 0D 03  mov byte ptr es:[di + 0xd], 3
6151  FF 76 FE        push word ptr [bp - 2]
6154  0E              push cs
6155  E8 A3 F2        call 0x53fb
6158  6B 46 06 3E     imul ax, word ptr [bp + 6], 0x3e
615C  C4 3E C2 D7     les di, ptr [0xd7c2]
6160  03 F8           add di, ax
6162  26 FE 45 F4     inc byte ptr es:[di - 0xc]
6166  8B 46 FE        mov ax, word ptr [bp - 2]
6169  A3 84 D6        mov word ptr [0xd684], ax
loc_616C:
616C  C9              leave
616D  CA 04 00        retf 4

; ---- routine 1B55:6170  (found by: call, far)
sub_6170:
6170  C8 06 00 00     enter 6, 0
6174  FF 76 0A        push word ptr [bp + 0xa]
6177  E8 04 FA        call 0x5b7e
617A  89 46 FE        mov word ptr [bp - 2], ax
617D  E8 DC FC        call 0x5e5c
6180  8A D0           mov dl, al
6182  8B 46 FE        mov ax, word ptr [bp - 2]
6185  C4 3E AA D7     les di, ptr [0xd7aa]
6189  03 F8           add di, ax
618B  26 88 15        mov byte ptr es:[di], dl
618E  8B 46 FE        mov ax, word ptr [bp - 2]
6191  C1 E0 03        shl ax, 3
6194  C4 3E BA D7     les di, ptr [0xd7ba]
6198  03 F8           add di, ax
619A  06              push es
619B  57              push di
619C  6A 08           push 8
619E  6A 00           push 0
61A0  9A 22 02 BC 24  call far 24BC:0222
61A5  6B 46 FE 0F     imul ax, word ptr [bp - 2], 0xf
61A9  C4 3E BE D7     les di, ptr [0xd7be]
61AD  03 F8           add di, ax
61AF  06              push es
61B0  57              push di
61B1  6A 0F           push 0xf
61B3  6A 00           push 0
61B5  9A 22 02 BC 24  call far 24BC:0222
61BA  6B 46 0A 3E     imul ax, word ptr [bp + 0xa], 0x3e
61BE  C4 3E C2 D7     les di, ptr [0xd7c2]
61C2  03 F8           add di, ax
61C4  81 C7 C2 FF     add di, 0xffc2
61C8  8B 56 FE        mov dx, word ptr [bp - 2]
61CB  8B 46 08        mov ax, word ptr [bp + 8]
61CE  D1 E0           shl ax, 1
61D0  03 F8           add di, ax
61D2  26 89 55 FE     mov word ptr es:[di - 2], dx
61D6  8B 46 FE        mov ax, word ptr [bp - 2]
61D9  C1 E0 03        shl ax, 3
61DC  C4 3E BA D7     les di, ptr [0xd7ba]
61E0  03 F8           add di, ax
61E2  89 7E FA        mov word ptr [bp - 6], di
61E5  8C 46 FC        mov word ptr [bp - 4], es
61E8  8A 46 0A        mov al, byte ptr [bp + 0xa]
61EB  26 88 05        mov byte ptr es:[di], al
61EE  8A 46 06        mov al, byte ptr [bp + 6]
61F1  26 88 45 07     mov byte ptr es:[di + 7], al
61F5  8A 46 06        mov al, byte ptr [bp + 6]
61F8  26 88 45 06     mov byte ptr es:[di + 6], al
61FC  6A 10           push 0x10
61FE  9A 6D 07 2A 23  call far 232A:076D
6203  C4 7E FA        les di, ptr [bp - 6]
6206  26 88 45 05     mov byte ptr es:[di + 5], al
620A  6A 03           push 3
620C  9A 6D 07 2A 23  call far 232A:076D
6211  50              push ax
6212  6A 02           push 2
6214  9A 6D 07 2A 23  call far 232A:076D
6219  8B D0           mov dx, ax
621B  C4 7E FA        les di, ptr [bp - 6]
621E  26 80 7D 07 00  cmp byte ptr es:[di + 7], 0
6223  B0 00           mov al, 0
6225  75 01           jne 0x6228
6227  40              inc ax
loc_6228:
6228  98              cwde
6229  8B F8           mov di, ax
622B  8A 85 12 13     mov al, byte ptr [di + 0x1312]
622F  30 E4           xor ah, ah
6231  03 C2           add ax, dx
6233  5A              pop dx
6234  2B C2           sub ax, dx
6236  C4 7E FA        les di, ptr [bp - 6]
6239  26 88 45 01     mov byte ptr es:[di + 1], al
623D  FF 76 FE        push word ptr [bp - 2]
6240  0E              push cs
6241  E8 17 F1        call 0x535b
6244  6B 46 0A 3E     imul ax, word ptr [bp + 0xa], 0x3e
6248  C4 3E C2 D7     les di, ptr [0xd7c2]
624C  03 F8           add di, ax
624E  26 8A 45 F5     mov al, byte ptr es:[di - 0xb]
6252  30 E4           xor ah, ah
6254  8B D0           mov dx, ax
6256  B8 B0 00        mov ax, 0xb0
6259  2B C2           sub ax, dx
625B  05 50 00        add ax, 0x50
625E  C4 7E FA        les di, ptr [bp - 6]
6261  26 88 45 03     mov byte ptr es:[di + 3], al
6265  FF 76 FE        push word ptr [bp - 2]
6268  0E              push cs
6269  E8 18 F0        call 0x5284
626C  FF 76 FE        push word ptr [bp - 2]
626F  E8 BD F9        call 0x5c2f
6272  FF 76 FE        push word ptr [bp - 2]
6275  0E              push cs
6276  E8 DE 02        call 0x6557
6279  FF 76 FE        push word ptr [bp - 2]
627C  0E              push cs
627D  E8 7B F1        call 0x53fb
6280  C9              leave
6281  CA 06 00        retf 6

