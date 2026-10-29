; 1-0.EXE (One-Nil 96), code segment 1B55 (image offsets 1B550..2315F), part 10 of 12
; packed 1-0.EXE sha256 89ff9c5f238f24e81a0c2440a46cdd8997280a65fc3cc3d97cb974f55280a80a (LZEXE 0.91)
; unpacked (tools/static/unlzexe.py) sha256 887ed2a92767950e5309b2052409f875668605939b69e00737aa3047022b9f51
; tool: capstone 5.0.9 (pip package; core library 5.0.1280) (CS_ARCH_X86, CS_MODE_16), recursive descent from the entry point, far calls and near calls/jumps, then routine prologues (55 89 E5 / 55 8B EC / C8 iw 00) in what remains; tools/static/listing.py
; addresses are SEGMENT:OFFSET with SEGMENT the image paragraph before relocation; image offset = SEGMENT*16+OFFSET
; ---- routine 1B55:6284  (found by: far)
sub_6284:
6284  C8 0E 00 00     enter 0xe, 0
6288  31 C0           xor ax, ax
628A  89 46 FA        mov word ptr [bp - 6], ax
628D  C7 46 FC 01 00  mov word ptr [bp - 4], 1
6292  EB 03           jmp 0x6297
loc_6294:
6294  FF 46 FC        inc word ptr [bp - 4]
loc_6297:
6297  6B 46 FC 3E     imul ax, word ptr [bp - 4], 0x3e
629B  C4 3E C2 D7     les di, ptr [0xd7c2]
629F  03 F8           add di, ax
62A1  81 C7 C2 FF     add di, 0xffc2
62A5  89 7E F4        mov word ptr [bp - 0xc], di
62A8  8C 46 F6        mov word ptr [bp - 0xa], es
62AB  26 8A 45 37     mov al, byte ptr es:[di + 0x37]
62AF  98              cwde
62B0  8B F8           mov di, ax
62B2  8A 85 62 A2     mov al, byte ptr [di - 0x5d9e]
62B6  C4 7E F4        les di, ptr [bp - 0xc]
62B9  26 88 45 32     mov byte ptr es:[di + 0x32], al
62BD  26 8A 45 32     mov al, byte ptr es:[di + 0x32]
62C1  30 E4           xor ah, ah
62C3  89 46 F2        mov word ptr [bp - 0xe], ax
62C6  B8 01 00        mov ax, 1
62C9  3B 46 F2        cmp ax, word ptr [bp - 0xe]
62CC  77 26           ja 0x62f4
62CE  89 46 FE        mov word ptr [bp - 2], ax
62D1  EB 03           jmp 0x62d6
loc_62D3:
62D3  FF 46 FE        inc word ptr [bp - 2]
loc_62D6:
62D6  8B 46 FA        mov ax, word ptr [bp - 6]
62D9  03 46 FE        add ax, word ptr [bp - 2]
62DC  8B D0           mov dx, ax
62DE  8B 46 FE        mov ax, word ptr [bp - 2]
62E1  D1 E0           shl ax, 1
62E3  C4 7E F4        les di, ptr [bp - 0xc]
62E6  03 F8           add di, ax
62E8  26 89 55 FE     mov word ptr es:[di - 2], dx
62EC  8B 46 FE        mov ax, word ptr [bp - 2]
62EF  3B 46 F2        cmp ax, word ptr [bp - 0xe]
62F2  75 DF           jne 0x62d3
loc_62F4:
62F4  FF 76 FC        push word ptr [bp - 4]
62F7  0E              push cs
62F8  E8 EC F3        call 0x56e7
62FB  83 46 FA 14     add word ptr [bp - 6], 0x14
62FF  81 7E FC B0 00  cmp word ptr [bp - 4], 0xb0
6304  75 8E           jne 0x6294
6306  C9              leave
6307  CB              retf

; ---- routine 1B55:6308  (found by: call)
sub_6308:
6308  C8 04 00 00     enter 4, 0
630C  C4 7E 08        les di, ptr [bp + 8]
630F  89 7E FC        mov word ptr [bp - 4], di
6312  8C 46 FE        mov word ptr [bp - 2], es
6315  8B 46 06        mov ax, word ptr [bp + 6]
6318  C4 3E AA D7     les di, ptr [0xd7aa]
631C  03 F8           add di, ax
631E  26 8A 05        mov al, byte ptr es:[di]
6321  C4 7E FC        les di, ptr [bp - 4]
6324  26 88 45 04     mov byte ptr es:[di + 4], al
6328  8B 46 06        mov ax, word ptr [bp + 6]
632B  26 89 05        mov word ptr es:[di], ax
632E  8B 46 04        mov ax, word ptr [bp + 4]
6331  26 89 45 02     mov word ptr es:[di + 2], ax
6335  8B 46 06        mov ax, word ptr [bp + 6]
6338  C1 E0 03        shl ax, 3
633B  C4 3E BA D7     les di, ptr [0xd7ba]
633F  03 F8           add di, ax
6341  26 8A 45 07     mov al, byte ptr es:[di + 7]
6345  C4 7E FC        les di, ptr [bp - 4]
6348  26 88 45 05     mov byte ptr es:[di + 5], al
634C  C9              leave
634D  C2 08 00        ret 8

; ---- routine 1B55:6350  (found by: call, far)
sub_6350:
6350  C8 0C 00 00     enter 0xc, 0
6354  8B 46 0C        mov ax, word ptr [bp + 0xc]
6357  C1 E0 03        shl ax, 3
635A  C4 3E BA D7     les di, ptr [0xd7ba]
635E  03 F8           add di, ax
6360  89 7E FC        mov word ptr [bp - 4], di
6363  8C 46 FE        mov word ptr [bp - 2], es
6366  6B 46 0C 0F     imul ax, word ptr [bp + 0xc], 0xf
636A  C4 3E BE D7     les di, ptr [0xd7be]
636E  03 F8           add di, ax
6370  89 7E F8        mov word ptr [bp - 8], di
6373  8C 46 FA        mov word ptr [bp - 6], es
6376  69 46 08 3A 23  imul ax, word ptr [bp + 8], 0x233a
637B  C4 3E E2 DC     les di, ptr [0xdce2]
637F  03 F8           add di, ax
6381  81 C7 C6 DC     add di, 0xdcc6
6385  06              push es
6386  57              push di
6387  69 46 08 3A 23  imul ax, word ptr [bp + 8], 0x233a
638C  C4 3E E2 DC     les di, ptr [0xdce2]
6390  03 F8           add di, ax
6392  81 C7 D8 DC     add di, 0xdcd8
6396  06              push es
6397  57              push di
6398  68 16 23        push 0x2316
639B  9A C2 01 BC 24  call far 24BC:01C2
63A0  69 46 08 3A 23  imul ax, word ptr [bp + 8], 0x233a
63A5  C4 3E E2 DC     les di, ptr [0xdce2]
63A9  03 F8           add di, ax
63AB  81 C7 D8 DC     add di, 0xdcd8
63AF  89 7E F4        mov word ptr [bp - 0xc], di
63B2  8C 46 F6        mov word ptr [bp - 0xa], es
63B5  8B 46 0C        mov ax, word ptr [bp + 0xc]
63B8  C4 3E AA D7     les di, ptr [0xd7aa]
63BC  03 F8           add di, ax
63BE  26 8A 05        mov al, byte ptr es:[di]
63C1  C4 7E F4        les di, ptr [bp - 0xc]
63C4  26 88 05        mov byte ptr es:[di], al
63C7  8B 46 0C        mov ax, word ptr [bp + 0xc]
63CA  26 89 45 01     mov word ptr es:[di + 1], ax
63CE  8B 7E 08        mov di, word ptr [bp + 8]
63D1  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
63D5  30 E4           xor ah, ah
63D7  3B 46 0A        cmp ax, word ptr [bp + 0xa]
63DA  B0 00           mov al, 0
63DC  75 01           jne 0x63df
63DE  40              inc ax
loc_63DF:
63DF  C4 7E F4        les di, ptr [bp - 0xc]
63E2  26 88 45 03     mov byte ptr es:[di + 3], al
63E6  8A 46 06        mov al, byte ptr [bp + 6]
63E9  26 88 45 04     mov byte ptr es:[di + 4], al
63ED  C4 7E FC        les di, ptr [bp - 4]
63F0  26 8A 45 01     mov al, byte ptr es:[di + 1]
63F4  C4 7E F4        les di, ptr [bp - 0xc]
63F7  26 88 45 05     mov byte ptr es:[di + 5], al
63FB  C4 7E F8        les di, ptr [bp - 8]
63FE  26 8B 05        mov ax, word ptr es:[di]
6401  C4 7E F4        les di, ptr [bp - 0xc]
6404  26 89 45 0B     mov word ptr es:[di + 0xb], ax
6408  C4 7E F8        les di, ptr [bp - 8]
640B  26 8B 45 02     mov ax, word ptr es:[di + 2]
640F  C4 7E F4        les di, ptr [bp - 0xc]
6412  26 89 45 0D     mov word ptr es:[di + 0xd], ax
6416  C4 7E FC        les di, ptr [bp - 4]
6419  26 8A 45 07     mov al, byte ptr es:[di + 7]
641D  C4 7E F4        les di, ptr [bp - 0xc]
6420  26 88 45 06     mov byte ptr es:[di + 6], al
6424  C4 3E D2 D7     les di, ptr [0xd7d2]
6428  26 8A 45 01     mov al, byte ptr es:[di + 1]
642C  30 E4           xor ah, ah
642E  C4 7E F4        les di, ptr [bp - 0xc]
6431  26 89 45 0F     mov word ptr es:[di + 0xf], ax
6435  C4 3E D2 D7     les di, ptr [0xd7d2]
6439  26 8A 05        mov al, byte ptr es:[di]
643C  C4 7E F4        les di, ptr [bp - 0xc]
643F  26 88 45 11     mov byte ptr es:[di + 0x11], al
6443  C9              leave
6444  CA 08 00        retf 8

; ---- routine 1B55:6447  (found by: far)
sub_6447:
6447  C8 08 00 00     enter 8, 0
644B  6B 46 0C 2E     imul ax, word ptr [bp + 0xc], 0x2e
644F  C4 3E C0 DC     les di, ptr [0xdcc0]
6453  03 F8           add di, ax
6455  81 C7 D2 FF     add di, 0xffd2
6459  89 7E FC        mov word ptr [bp - 4], di
645C  8C 46 FE        mov word ptr [bp - 2], es
645F  6B 46 0E 0F     imul ax, word ptr [bp + 0xe], 0xf
6463  C4 3E BE D7     les di, ptr [0xd7be]
6467  03 F8           add di, ax
6469  89 7E F8        mov word ptr [bp - 8], di
646C  8C 46 FA        mov word ptr [bp - 6], es
646F  26 8B 05        mov ax, word ptr es:[di]
6472  C4 7E FC        les di, ptr [bp - 4]
6475  26 3B 45 2A     cmp ax, word ptr es:[di + 0x2a]
6479  76 12           jbe 0x648d
647B  81 C7 28 00     add di, 0x28
647F  06              push es
6480  57              push di
6481  FF 76 0E        push word ptr [bp + 0xe]
6484  C4 7E F8        les di, ptr [bp - 8]
6487  26 FF 35        push word ptr es:[di]
648A  E8 7B FE        call 0x6308
loc_648D:
648D  80 7E 0A 00     cmp byte ptr [bp + 0xa], 0
6491  74 10           je 0x64a3
6493  FF 76 0E        push word ptr [bp + 0xe]
6496  FF 76 0C        push word ptr [bp + 0xc]
6499  FF 76 08        push word ptr [bp + 8]
649C  FF 76 06        push word ptr [bp + 6]
649F  0E              push cs
64A0  E8 AD FE        call 0x6350
loc_64A3:
64A3  8B 46 0E        mov ax, word ptr [bp + 0xe]
64A6  C1 E0 03        shl ax, 3
64A9  C4 3E BA D7     les di, ptr [0xd7ba]
64AD  03 F8           add di, ax
64AF  26 80 7D 07 00  cmp byte ptr es:[di + 7], 0
64B4  75 02           jne 0x64b8
64B6  EB 4B           jmp 0x6503
loc_64B8:
64B8  C4 7E F8        les di, ptr [bp - 8]
64BB  26 8A 45 05     mov al, byte ptr es:[di + 5]
64BF  30 E4           xor ah, ah
64C1  C4 7E FC        les di, ptr [bp - 4]
64C4  26 3B 45 1E     cmp ax, word ptr es:[di + 0x1e]
64C8  76 16           jbe 0x64e0
64CA  81 C7 1C 00     add di, 0x1c
64CE  06              push es
64CF  57              push di
64D0  FF 76 0E        push word ptr [bp + 0xe]
64D3  C4 7E F8        les di, ptr [bp - 8]
64D6  26 8A 45 05     mov al, byte ptr es:[di + 5]
64DA  30 E4           xor ah, ah
64DC  50              push ax
64DD  E8 28 FE        call 0x6308
loc_64E0:
64E0  C4 7E F8        les di, ptr [bp - 8]
64E3  26 8B 45 02     mov ax, word ptr es:[di + 2]
64E7  C4 7E FC        les di, ptr [bp - 4]
64EA  26 3B 45 24     cmp ax, word ptr es:[di + 0x24]
64EE  76 13           jbe 0x6503
64F0  81 C7 22 00     add di, 0x22
64F4  06              push es
64F5  57              push di
64F6  FF 76 0E        push word ptr [bp + 0xe]
64F9  C4 7E F8        les di, ptr [bp - 8]
64FC  26 FF 75 02     push word ptr es:[di + 2]
6500  E8 05 FE        call 0x6308
loc_6503:
6503  C9              leave
6504  CA 0A 00        retf 0xa

; ---- routine 1B55:6507  (found by: call, far)
sub_6507:
6507  C8 04 00 00     enter 4, 0
650B  6B 46 0C 0F     imul ax, word ptr [bp + 0xc], 0xf
650F  C4 3E BE D7     les di, ptr [0xd7be]
6513  03 F8           add di, ax
6515  89 7E FC        mov word ptr [bp - 4], di
6518  8C 46 FE        mov word ptr [bp - 2], es
651B  26 C6 45 0D 00  mov byte ptr es:[di + 0xd], 0
6520  8A 46 0A        mov al, byte ptr [bp + 0xa]
6523  26 88 45 0C     mov byte ptr es:[di + 0xc], al
6527  8A 46 08        mov al, byte ptr [bp + 8]
652A  26 88 45 09     mov byte ptr es:[di + 9], al
652E  80 7E 06 00     cmp byte ptr [bp + 6], 0
6532  74 0F           je 0x6543
6534  6A 01           push 1
6536  81 C7 0B 00     add di, 0xb
653A  06              push es
653B  57              push di
653C  9A D5 00 2A 23  call far 232A:00D5
6541  EB 10           jmp 0x6553
loc_6543:
6543  6A 01           push 1
6545  C4 7E FC        les di, ptr [bp - 4]
6548  81 C7 0B 00     add di, 0xb
654C  06              push es
654D  57              push di
654E  9A F8 00 2A 23  call far 232A:00F8
loc_6553:
6553  C9              leave
6554  CA 08 00        retf 8

; ---- routine 1B55:6557  (found by: call, far)
sub_6557:
6557  C8 08 00 00     enter 8, 0
655B  8B 46 06        mov ax, word ptr [bp + 6]
655E  C1 E0 03        shl ax, 3
6561  C4 3E BA D7     les di, ptr [0xd7ba]
6565  03 F8           add di, ax
6567  89 7E FC        mov word ptr [bp - 4], di
656A  8C 46 FE        mov word ptr [bp - 2], es
656D  6B 46 06 0F     imul ax, word ptr [bp + 6], 0xf
6571  C4 3E BE D7     les di, ptr [0xd7be]
6575  03 F8           add di, ax
6577  C4 7E FC        les di, ptr [bp - 4]
657A  26 8A 45 02     mov al, byte ptr es:[di + 2]
657E  30 E4           xor ah, ah
6580  40              inc ax
6581  40              inc ax
6582  8B D0           mov dx, ax
6584  26 8A 45 01     mov al, byte ptr es:[di + 1]
6588  30 E4           xor ah, ah
658A  3B C2           cmp ax, dx
658C  7E 22           jle 0x65b0
658E  FF 76 06        push word ptr [bp + 6]
6591  A0 14 13        mov al, byte ptr [0x1314]
6594  30 E4           xor ah, ah
6596  50              push ax
6597  26 8A 45 04     mov al, byte ptr es:[di + 4]
659B  30 E4           xor ah, ah
659D  50              push ax
659E  26 80 7D 04 B4  cmp byte ptr es:[di + 4], 0xb4
65A3  B0 00           mov al, 0
65A5  76 01           jbe 0x65a8
65A7  40              inc ax
loc_65A8:
65A8  50              push ax
65A9  0E              push cs
65AA  E8 5A FF        call 0x6507
65AD  E9 EF 00        jmp 0x669f
loc_65B0:
65B0  C4 7E FC        les di, ptr [bp - 4]
65B3  26 80 7D 01 16  cmp byte ptr es:[di + 1], 0x16
65B8  73 31           jae 0x65eb
65BA  FF 76 06        push word ptr [bp + 6]
65BD  6A 02           push 2
65BF  9A 6D 07 2A 23  call far 232A:076D
65C4  40              inc ax
65C5  40              inc ax
65C6  8B F8           mov di, ax
65C8  8A 85 13 13     mov al, byte ptr [di + 0x1313]
65CC  30 E4           xor ah, ah
65CE  50              push ax
65CF  C4 7E FC        les di, ptr [bp - 4]
65D2  26 8A 45 04     mov al, byte ptr es:[di + 4]
65D6  30 E4           xor ah, ah
65D8  50              push ax
65D9  26 80 7D 04 B4  cmp byte ptr es:[di + 4], 0xb4
65DE  B0 00           mov al, 0
65E0  76 01           jbe 0x65e3
65E2  40              inc ax
loc_65E3:
65E3  50              push ax
65E4  0E              push cs
65E5  E8 1F FF        call 0x6507
65E8  E9 B4 00        jmp 0x669f
loc_65EB:
65EB  C4 7E FC        les di, ptr [bp - 4]
65EE  26 80 7D 01 19  cmp byte ptr es:[di + 1], 0x19
65F3  73 2F           jae 0x6624
65F5  FF 76 06        push word ptr [bp + 6]
65F8  6A 03           push 3
65FA  9A 6D 07 2A 23  call far 232A:076D
65FF  40              inc ax
6600  8B F8           mov di, ax
6602  8A 85 13 13     mov al, byte ptr [di + 0x1313]
6606  30 E4           xor ah, ah
6608  50              push ax
6609  C4 7E FC        les di, ptr [bp - 4]
660C  26 8A 45 04     mov al, byte ptr es:[di + 4]
6610  30 E4           xor ah, ah
6612  50              push ax
6613  26 80 7D 04 B4  cmp byte ptr es:[di + 4], 0xb4
6618  B0 00           mov al, 0
661A  76 01           jbe 0x661d
661C  40              inc ax
loc_661D:
661D  50              push ax
661E  0E              push cs
661F  E8 E5 FE        call 0x6507
6622  EB 7B           jmp 0x669f
loc_6624:
6624  C4 7E FC        les di, ptr [bp - 4]
6627  26 8A 45 01     mov al, byte ptr es:[di + 1]
662B  26 3A 45 02     cmp al, byte ptr es:[di + 2]
662F  76 13           jbe 0x6644
6631  26 8A 45 02     mov al, byte ptr es:[di + 2]
6635  30 E4           xor ah, ah
6637  40              inc ax
6638  8B D0           mov dx, ax
663A  26 8A 45 01     mov al, byte ptr es:[di + 1]
663E  30 E4           xor ah, ah
6640  3B C2           cmp ax, dx
6642  75 2F           jne 0x6673
loc_6644:
6644  FF 76 06        push word ptr [bp + 6]
6647  6A 02           push 2
6649  9A 6D 07 2A 23  call far 232A:076D
664E  40              inc ax
664F  8B F8           mov di, ax
6651  8A 85 13 13     mov al, byte ptr [di + 0x1313]
6655  30 E4           xor ah, ah
6657  50              push ax
6658  C4 7E FC        les di, ptr [bp - 4]
665B  26 8A 45 04     mov al, byte ptr es:[di + 4]
665F  30 E4           xor ah, ah
6661  50              push ax
6662  26 80 7D 04 B4  cmp byte ptr es:[di + 4], 0xb4
6667  B0 00           mov al, 0
6669  76 01           jbe 0x666c
666B  40              inc ax
loc_666C:
666C  50              push ax
666D  0E              push cs
666E  E8 96 FE        call 0x6507
6671  EB 2C           jmp 0x669f
loc_6673:
6673  FF 76 06        push word ptr [bp + 6]
6676  6A 04           push 4
6678  9A 6D 07 2A 23  call far 232A:076D
667D  8B F8           mov di, ax
667F  8A 85 13 13     mov al, byte ptr [di + 0x1313]
6683  30 E4           xor ah, ah
6685  50              push ax
6686  C4 7E FC        les di, ptr [bp - 4]
6689  26 8A 45 04     mov al, byte ptr es:[di + 4]
668D  30 E4           xor ah, ah
668F  50              push ax
6690  26 80 7D 04 B4  cmp byte ptr es:[di + 4], 0xb4
6695  B0 00           mov al, 0
6697  76 01           jbe 0x669a
6699  40              inc ax
loc_669A:
669A  50              push ax
669B  0E              push cs
669C  E8 68 FE        call 0x6507
loc_669F:
669F  C9              leave
66A0  CA 02 00        retf 2
; data (not reached as code), 75 bytes
66A3                  pstr "You can't sell youth players"
66C0                  pstr 'Sell '
66C6                  pstr ' has been placed on the transfer market'

; ---- routine 1B55:66EE  (found by: far)
sub_66EE:
66EE  C8 00 02 00     enter 0x200, 0
66F2  83 7E 06 00     cmp word ptr [bp + 6], 0
66F6  74 61           je 0x6759
66F8  6B 46 06 0F     imul ax, word ptr [bp + 6], 0xf
66FC  C4 3E BE D7     les di, ptr [0xd7be]
6700  03 F8           add di, ax
6702  26 80 7D 0D 02  cmp byte ptr es:[di + 0xd], 2
6707  74 50           je 0x6759
6709  8B 46 06        mov ax, word ptr [bp + 6]
670C  C1 E0 03        shl ax, 3
670F  C4 3E BA D7     les di, ptr [0xd7ba]
6713  03 F8           add di, ax
6715  26 80 7D 01 12  cmp byte ptr es:[di + 1], 0x12
671A  B0 00           mov al, 0
671C  73 01           jae 0x671f
671E  40              inc ax
loc_671F:
671F  50              push ax
6720  BF A3 66        mov di, 0x66a3
6723  0E              push cs
6724  57              push di
6725  9A 98 00 2A 23  call far 232A:0098
672A  08 C0           or al, al
672C  75 2B           jne 0x6759
672E  8D BE 00 FE     lea di, [bp - 0x200]
6732  16              push ss
6733  57              push di
6734  BF C0 66        mov di, 0x66c0
6737  0E              push cs
6738  57              push di
6739  9A 53 0B C9 26  call far 26C9:0B53
673E  8D BE 00 FF     lea di, [bp - 0x100]
6742  16              push ss
6743  57              push di
6744  FF 76 06        push word ptr [bp + 6]
6747  0E              push cs
6748  E8 91 DD        call 0x44dc
674B  9A D2 0B C9 26  call far 26C9:0BD2
6750  9A E5 06 2A 23  call far 232A:06E5
6755  08 C0           or al, al
6757  75 02           jne 0x675b
loc_6759:
6759  EB 2B           jmp 0x6786
loc_675B:
675B  8D BE 00 FF     lea di, [bp - 0x100]
675F  16              push ss
6760  57              push di
6761  FF 76 06        push word ptr [bp + 6]
6764  0E              push cs
6765  E8 74 DD        call 0x44dc
6768  BF C6 66        mov di, 0x66c6
676B  0E              push cs
676C  57              push di
676D  9A D2 0B C9 26  call far 26C9:0BD2
6772  9A 02 07 BC 24  call far 24BC:0702
6777  6B 46 06 0F     imul ax, word ptr [bp + 6], 0xf
677B  C4 3E BE D7     les di, ptr [0xd7be]
677F  03 F8           add di, ax
6781  26 C6 45 0D 02  mov byte ptr es:[di + 0xd], 2
loc_6786:
6786  C9              leave
6787  CA 02 00        retf 2

; ---- routine 1B55:678A  (found by: call, far)
sub_678A:
678A  55              push bp
678B  89 E5           mov bp, sp
678D  8B 46 06        mov ax, word ptr [bp + 6]
6790  C1 E0 03        shl ax, 3
6793  C4 3E BA D7     les di, ptr [0xd7ba]
6797  03 F8           add di, ax
6799  06              push es
679A  57              push di
679B  6A 08           push 8
679D  6A 00           push 0
679F  9A 22 02 BC 24  call far 24BC:0222
67A4  6B 46 06 0F     imul ax, word ptr [bp + 6], 0xf
67A8  C4 3E BE D7     les di, ptr [0xd7be]
67AC  03 F8           add di, ax
67AE  06              push es
67AF  57              push di
67B0  6A 0F           push 0xf
67B2  6A 00           push 0
67B4  9A 22 02 BC 24  call far 24BC:0222
67B9  C9              leave
67BA  CA 02 00        retf 2

; ---- routine 1B55:67BD  (found by: call, far)
sub_67BD:
67BD  55              push bp
67BE  89 E5           mov bp, sp
67C0  8B 46 06        mov ax, word ptr [bp + 6]
67C3  D1 E0           shl ax, 1
67C5  C4 7E 08        les di, ptr [bp + 8]
67C8  03 F8           add di, ax
67CA  26 FF 75 FE     push word ptr es:[di - 2]
67CE  0E              push cs
67CF  E8 B8 FF        call 0x678a
67D2  8B 46 06        mov ax, word ptr [bp + 6]
67D5  D1 E0           shl ax, 1
67D7  C4 7E 08        les di, ptr [bp + 8]
67DA  03 F8           add di, ax
67DC  31 C0           xor ax, ax
67DE  26 89 45 FE     mov word ptr es:[di - 2], ax
67E2  C9              leave
67E3  CA 06 00        retf 6

; ---- routine 1B55:67E6  (found by: call)
sub_67E6:
67E6  55              push bp
67E7  89 E5           mov bp, sp
67E9  C4 7E 08        les di, ptr [bp + 8]
67EC  06              push es
67ED  57              push di
67EE  FF 76 06        push word ptr [bp + 6]
67F1  0E              push cs
67F2  E8 C8 FF        call 0x67bd
67F5  8B 7E 04        mov di, word ptr [bp + 4]
67F8  36 6B 45 FE 3E  imul ax, word ptr ss:[di - 2], 0x3e
67FD  C4 3E C2 D7     les di, ptr [0xd7c2]
6801  03 F8           add di, ax
6803  26 FE 4D F4     dec byte ptr es:[di - 0xc]
6807  C9              leave
6808  C2 08 00        ret 8

; ---- routine 1B55:680B  (found by: call)
sub_680B:
680B  55              push bp
680C  89 E5           mov bp, sp
680E  8B 7E 04        mov di, word ptr [bp + 4]
6811  36 FF 75 FE     push word ptr ss:[di - 2]
6815  FF 76 08        push word ptr [bp + 8]
6818  FF 76 06        push word ptr [bp + 6]
681B  0E              push cs
681C  E8 51 F9        call 0x6170
681F  8B 7E 04        mov di, word ptr [bp + 4]
6822  36 6B 45 FE 3E  imul ax, word ptr ss:[di - 2], 0x3e
6827  C4 3E C2 D7     les di, ptr [0xd7c2]
682B  03 F8           add di, ax
682D  26 FE 45 F4     inc byte ptr es:[di - 0xc]
6831  C9              leave
6832  C2 06 00        ret 6

; ---- routine 1B55:6835  (found by: call)
sub_6835:
6835  C8 0E 00 00     enter 0xe, 0
6839  8B 7E 04        mov di, word ptr [bp + 4]
683C  36 6B 45 FE 3E  imul ax, word ptr ss:[di - 2], 0x3e
6841  C4 3E C2 D7     les di, ptr [0xd7c2]
6845  03 F8           add di, ax
6847  81 C7 C2 FF     add di, 0xffc2
684B  89 7E FA        mov word ptr [bp - 6], di
684E  8C 46 FC        mov word ptr [bp - 4], es
6851  C7 46 FE 01 00  mov word ptr [bp - 2], 1
6856  EB 03           jmp 0x685b
loc_6858:
6858  FF 46 FE        inc word ptr [bp - 2]
loc_685B:
685B  C4 7E FA        les di, ptr [bp - 6]
685E  26 8A 45 37     mov al, byte ptr es:[di + 0x37]
6862  98              cwde
6863  8B F8           mov di, ax
6865  8A 85 62 A2     mov al, byte ptr [di - 0x5d9e]
6869  C4 7E FA        les di, ptr [bp - 6]
686C  26 3A 45 32     cmp al, byte ptr es:[di + 0x32]
6870  77 6C           ja 0x68de
6872  8B 46 FE        mov ax, word ptr [bp - 2]
6875  D1 E0           shl ax, 1
6877  C4 7E 06        les di, ptr [bp + 6]
687A  03 F8           add di, ax
687C  26 83 7D FE 00  cmp word ptr es:[di - 2], 0
6881  74 5B           je 0x68de
6883  8B 46 FE        mov ax, word ptr [bp - 2]
6886  D1 E0           shl ax, 1
6888  C4 7E 06        les di, ptr [bp + 6]
688B  03 F8           add di, ax
688D  26 8B 45 FE     mov ax, word ptr es:[di - 2]
6891  C1 E0 03        shl ax, 3
6894  C4 3E BA D7     les di, ptr [0xd7ba]
6898  03 F8           add di, ax
689A  89 7E F6        mov word ptr [bp - 0xa], di
689D  8C 46 F8        mov word ptr [bp - 8], es
68A0  8B 46 FE        mov ax, word ptr [bp - 2]
68A3  D1 E0           shl ax, 1
68A5  C4 7E 06        les di, ptr [bp + 6]
68A8  03 F8           add di, ax
68AA  26 6B 45 FE 0F  imul ax, word ptr es:[di - 2], 0xf
68AF  C4 3E BE D7     les di, ptr [0xd7be]
68B3  03 F8           add di, ax
68B5  89 7E F2        mov word ptr [bp - 0xe], di
68B8  8C 46 F4        mov word ptr [bp - 0xc], es
68BB  C4 7E F6        les di, ptr [bp - 0xa]
68BE  26 80 7D 01 13  cmp byte ptr es:[di + 1], 0x13
68C3  72 0A           jb 0x68cf
68C5  C4 7E F2        les di, ptr [bp - 0xe]
68C8  26 80 7D 0C 00  cmp byte ptr es:[di + 0xc], 0
68CD  75 0F           jne 0x68de
loc_68CF:
68CF  C4 7E 06        les di, ptr [bp + 6]
68D2  06              push es
68D3  57              push di
68D4  FF 76 FE        push word ptr [bp - 2]
68D7  8B 7E 04        mov di, word ptr [bp + 4]
68DA  57              push di
68DB  E8 08 FF        call 0x67e6
loc_68DE:
68DE  83 7E FE 14     cmp word ptr [bp - 2], 0x14
68E2  74 03           je 0x68e7
68E4  E9 71 FF        jmp 0x6858
loc_68E7:
68E7  C9              leave
68E8  C2 06 00        ret 6

; ---- routine 1B55:68EB  (found by: far)
sub_68EB:
68EB  C8 1A 00 00     enter 0x1a, 0
68EF  C4 3E D2 D7     les di, ptr [0xd7d2]
68F3  89 7E F4        mov word ptr [bp - 0xc], di
68F6  8C 46 F6        mov word ptr [bp - 0xa], es
68F9  8B 7E 06        mov di, word ptr [bp + 6]
68FC  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
6900  30 E4           xor ah, ah
6902  89 46 FE        mov word ptr [bp - 2], ax
6905  6B 46 FE 3E     imul ax, word ptr [bp - 2], 0x3e
6909  C4 3E C2 D7     les di, ptr [0xd7c2]
690D  03 F8           add di, ax
690F  81 C7 C2 FF     add di, 0xffc2
6913  89 7E F0        mov word ptr [bp - 0x10], di
6916  8C 46 F2        mov word ptr [bp - 0xe], es
6919  8B 7E FE        mov di, word ptr [bp - 2]
691C  8A 85 85 D8     mov al, byte ptr [di - 0x277b]
6920  30 E4           xor ah, ah
6922  8B F8           mov di, ax
6924  8A 85 F7 93     mov al, byte ptr [di - 0x6c09]
6928  C4 7E F0        les di, ptr [bp - 0x10]
692B  26 88 45 39     mov byte ptr es:[di + 0x39], al
692F  6B 46 06 28     imul ax, word ptr [bp + 6], 0x28
6933  C4 7E F4        les di, ptr [bp - 0xc]
6936  03 F8           add di, ax
6938  81 C7 30 00     add di, 0x30
693C  06              push es
693D  57              push di
693E  55              push bp
693F  E8 F3 FE        call 0x6835
6942  C4 7E F0        les di, ptr [bp - 0x10]
6945  06              push es
6946  57              push di
6947  55              push bp
6948  E8 EA FE        call 0x6835
694B  C7 46 FC 01 00  mov word ptr [bp - 4], 1
6950  EB 03           jmp 0x6955
loc_6952:
6952  FF 46 FC        inc word ptr [bp - 4]
loc_6955:
6955  8B 46 FC        mov ax, word ptr [bp - 4]
6958  D1 E0           shl ax, 1
695A  8B D0           mov dx, ax
695C  6B 46 06 28     imul ax, word ptr [bp + 6], 0x28
6960  C4 7E F4        les di, ptr [bp - 0xc]
6963  03 F8           add di, ax
6965  03 FA           add di, dx
6967  26 83 7D 2E 00  cmp word ptr es:[di + 0x2e], 0
696C  74 50           je 0x69be
696E  C4 7E F0        les di, ptr [bp - 0x10]
6971  06              push es
6972  57              push di
6973  0E              push cs
6974  E8 32 F3        call 0x5ca9
6977  09 C0           or ax, ax
6979  74 43           je 0x69be
697B  8B 46 FC        mov ax, word ptr [bp - 4]
697E  D1 E0           shl ax, 1
6980  8B D0           mov dx, ax
6982  6B 46 06 28     imul ax, word ptr [bp + 6], 0x28
6986  C4 7E F4        les di, ptr [bp - 0xc]
6989  03 F8           add di, ax
698B  03 FA           add di, dx
698D  26 FF 75 2E     push word ptr es:[di + 0x2e]
6991  C4 7E F0        les di, ptr [bp - 0x10]
6994  06              push es
6995  57              push di
6996  0E              push cs
6997  E8 0F F3        call 0x5ca9
699A  D1 E0           shl ax, 1
699C  C4 7E F0        les di, ptr [bp - 0x10]
699F  03 F8           add di, ax
69A1  58              pop ax
69A2  26 89 45 FE     mov word ptr es:[di - 2], ax
69A6  8B 46 FC        mov ax, word ptr [bp - 4]
69A9  D1 E0           shl ax, 1
69AB  8B D0           mov dx, ax
69AD  6B 46 06 28     imul ax, word ptr [bp + 6], 0x28
69B1  C4 7E F4        les di, ptr [bp - 0xc]
69B4  03 F8           add di, ax
69B6  03 FA           add di, dx
69B8  31 C0           xor ax, ax
69BA  26 89 45 2E     mov word ptr es:[di + 0x2e], ax
loc_69BE:
69BE  83 7E FC 14     cmp word ptr [bp - 4], 0x14
69C2  75 8E           jne 0x6952
69C4  C7 46 FC 01 00  mov word ptr [bp - 4], 1
69C9  EB 03           jmp 0x69ce
loc_69CB:
69CB  FF 46 FC        inc word ptr [bp - 4]
loc_69CE:
69CE  8B 46 FC        mov ax, word ptr [bp - 4]
69D1  D1 E0           shl ax, 1
69D3  8B D0           mov dx, ax
69D5  6B 46 06 28     imul ax, word ptr [bp + 6], 0x28
69D9  C4 7E F4        les di, ptr [bp - 0xc]
69DC  03 F8           add di, ax
69DE  03 FA           add di, dx
69E0  26 83 7D 2E 00  cmp word ptr es:[di + 0x2e], 0
69E5  74 16           je 0x69fd
69E7  6B 46 06 28     imul ax, word ptr [bp + 6], 0x28
69EB  C4 7E F4        les di, ptr [bp - 0xc]
69EE  03 F8           add di, ax
69F0  81 C7 30 00     add di, 0x30
69F4  06              push es
69F5  57              push di
69F6  FF 76 FC        push word ptr [bp - 4]
69F9  55              push bp
69FA  E8 E9 FD        call 0x67e6
loc_69FD:
69FD  83 7E FC 14     cmp word ptr [bp - 4], 0x14
6A01  75 C8           jne 0x69cb
6A03  C7 46 FA 02 00  mov word ptr [bp - 6], 2
6A08  EB 03           jmp 0x6a0d
loc_6A0A:
6A0A  FF 46 FA        inc word ptr [bp - 6]
loc_6A0D:
6A0D  8B 46 FA        mov ax, word ptr [bp - 6]
6A10  89 46 EE        mov word ptr [bp - 0x12], ax
6A13  B8 14 00        mov ax, 0x14
6A16  3B 46 EE        cmp ax, word ptr [bp - 0x12]
6A19  72 4A           jb 0x6a65
6A1B  89 46 FC        mov word ptr [bp - 4], ax
6A1E  EB 03           jmp 0x6a23
loc_6A20:
6A20  FF 4E FC        dec word ptr [bp - 4]
loc_6A23:
6A23  8B 46 FC        mov ax, word ptr [bp - 4]
6A26  48              dec ax
6A27  D1 E0           shl ax, 1
6A29  C4 7E F0        les di, ptr [bp - 0x10]
6A2C  03 F8           add di, ax
6A2E  26 83 7D FE 00  cmp word ptr es:[di - 2], 0
6A33  75 28           jne 0x6a5d
6A35  8B 46 FC        mov ax, word ptr [bp - 4]
6A38  48              dec ax
6A39  D1 E0           shl ax, 1
6A3B  C4 7E F0        les di, ptr [bp - 0x10]
6A3E  03 F8           add di, ax
6A40  81 C7 FE FF     add di, 0xfffe
6A44  06              push es
6A45  57              push di
6A46  8B 46 FC        mov ax, word ptr [bp - 4]
6A49  D1 E0           shl ax, 1
6A4B  C4 7E F0        les di, ptr [bp - 0x10]
6A4E  03 F8           add di, ax
6A50  81 C7 FE FF     add di, 0xfffe
6A54  06              push es
6A55  57              push di
6A56  6A 02           push 2
6A58  9A 03 02 BC 24  call far 24BC:0203
loc_6A5D:
6A5D  8B 46 FC        mov ax, word ptr [bp - 4]
6A60  3B 46 EE        cmp ax, word ptr [bp - 0x12]
6A63  75 BB           jne 0x6a20
loc_6A65:
6A65  83 7E FA 14     cmp word ptr [bp - 6], 0x14
6A69  75 9F           jne 0x6a0a
6A6B  C7 46 FC 01 00  mov word ptr [bp - 4], 1
6A70  EB 03           jmp 0x6a75
loc_6A72:
6A72  FF 46 FC        inc word ptr [bp - 4]
loc_6A75:
6A75  8B 46 FC        mov ax, word ptr [bp - 4]
6A78  D1 E0           shl ax, 1
6A7A  C4 7E F0        les di, ptr [bp - 0x10]
6A7D  03 F8           add di, ax
6A7F  26 83 7D FE 00  cmp word ptr es:[di - 2], 0
6A84  75 1F           jne 0x6aa5
6A86  FF 76 FC        push word ptr [bp - 4]
6A89  8B 56 FC        mov dx, word ptr [bp - 4]
6A8C  8B 7E FE        mov di, word ptr [bp - 2]
6A8F  8A 85 85 D8     mov al, byte ptr [di - 0x277b]
6A93  30 E4           xor ah, ah
6A95  6B F8 0E        imul di, ax, 0xe
6A98  03 FA           add di, dx
6A9A  8A 85 04 94     mov al, byte ptr [di - 0x6bfc]
6A9E  30 E4           xor ah, ah
6AA0  50              push ax
6AA1  55              push bp
6AA2  E8 66 FD        call 0x680b
loc_6AA5:
6AA5  83 7E FC 0D     cmp word ptr [bp - 4], 0xd
6AA9  75 C7           jne 0x6a72
6AAB  C4 7E F0        les di, ptr [bp - 0x10]
6AAE  26 8A 45 37     mov al, byte ptr es:[di + 0x37]
6AB2  98              cwde
6AB3  8B F8           mov di, ax
6AB5  8A 85 62 A2     mov al, byte ptr [di - 0x5d9e]
6AB9  30 E4           xor ah, ah
6ABB  89 46 EE        mov word ptr [bp - 0x12], ax
6ABE  B8 0E 00        mov ax, 0xe
6AC1  3B 46 EE        cmp ax, word ptr [bp - 0x12]
6AC4  77 48           ja 0x6b0e
6AC6  89 46 FC        mov word ptr [bp - 4], ax
6AC9  EB 03           jmp 0x6ace
loc_6ACB:
6ACB  FF 46 FC        inc word ptr [bp - 4]
loc_6ACE:
6ACE  8B 46 FC        mov ax, word ptr [bp - 4]
6AD1  D1 E0           shl ax, 1
6AD3  C4 7E F0        les di, ptr [bp - 0x10]
6AD6  03 F8           add di, ax
6AD8  26 83 7D FE 00  cmp word ptr es:[di - 2], 0
6ADD  75 27           jne 0x6b06
6ADF  FF 76 FC        push word ptr [bp - 4]
6AE2  8B 7E FC        mov di, word ptr [bp - 4]
6AE5  8A 85 84 0D     mov al, byte ptr [di + 0xd84]
6AE9  30 E4           xor ah, ah
6AEB  8B D0           mov dx, ax
6AED  8B 7E FE        mov di, word ptr [bp - 2]
6AF0  8A 85 85 D8     mov al, byte ptr [di - 0x277b]
6AF4  30 E4           xor ah, ah
6AF6  6B F8 0E        imul di, ax, 0xe
6AF9  03 FA           add di, dx
6AFB  8A 85 04 94     mov al, byte ptr [di - 0x6bfc]
6AFF  30 E4           xor ah, ah
6B01  50              push ax
6B02  55              push bp
6B03  E8 05 FD        call 0x680b
loc_6B06:
6B06  8B 46 FC        mov ax, word ptr [bp - 4]
6B09  3B 46 EE        cmp ax, word ptr [bp - 0x12]
6B0C  75 BD           jne 0x6acb
loc_6B0E:
6B0E  C4 7E F0        les di, ptr [bp - 0x10]
6B11  26 8A 45 32     mov al, byte ptr es:[di + 0x32]
6B15  30 E4           xor ah, ah
6B17  89 46 EE        mov word ptr [bp - 0x12], ax
6B1A  B8 01 00        mov ax, 1
6B1D  3B 46 EE        cmp ax, word ptr [bp - 0x12]
6B20  77 2F           ja 0x6b51
6B22  89 46 FC        mov word ptr [bp - 4], ax
6B25  EB 03           jmp 0x6b2a
loc_6B27:
6B27  FF 46 FC        inc word ptr [bp - 4]
loc_6B2A:
6B2A  8B 46 FC        mov ax, word ptr [bp - 4]
6B2D  D1 E0           shl ax, 1
6B2F  C4 7E F0        les di, ptr [bp - 0x10]
6B32  03 F8           add di, ax
6B34  26 8B 45 FE     mov ax, word ptr es:[di - 2]
6B38  C1 E0 03        shl ax, 3
6B3B  C4 3E BA D7     les di, ptr [0xd7ba]
6B3F  03 F8           add di, ax
6B41  26 8A 45 07     mov al, byte ptr es:[di + 7]
6B45  26 88 45 06     mov byte ptr es:[di + 6], al
6B49  8B 46 FC        mov ax, word ptr [bp - 4]
6B4C  3B 46 EE        cmp ax, word ptr [bp - 0x12]
6B4F  75 D6           jne 0x6b27
loc_6B51:
6B51  C4 7E F0        les di, ptr [bp - 0x10]
6B54  06              push es
6B55  57              push di
6B56  FF 76 FE        push word ptr [bp - 2]
6B59  0E              push cs
6B5A  E8 1A 0C        call 0x7777
6B5D  C4 7E F0        les di, ptr [bp - 0x10]
6B60  26 8B 05        mov ax, word ptr es:[di]
6B63  C1 E0 03        shl ax, 3
6B66  C4 3E BA D7     les di, ptr [0xd7ba]
6B6A  03 F8           add di, ax
6B6C  26 80 7D 07 00  cmp byte ptr es:[di + 7], 0
6B71  74 30           je 0x6ba3
6B73  C4 7E F0        les di, ptr [bp - 0x10]
6B76  26 8A 45 32     mov al, byte ptr es:[di + 0x32]
6B7A  30 E4           xor ah, ah
6B7C  40              inc ax
6B7D  50              push ax
6B7E  6A 00           push 0
6B80  55              push bp
6B81  E8 87 FC        call 0x680b
6B84  C4 7E F0        les di, ptr [bp - 0x10]
6B87  26 8A 45 32     mov al, byte ptr es:[di + 0x32]
6B8B  30 E4           xor ah, ah
6B8D  D1 E0           shl ax, 1
6B8F  03 F8           add di, ax
6B91  81 C7 FE FF     add di, 0xfffe
6B95  06              push es
6B96  57              push di
6B97  C4 7E F0        les di, ptr [bp - 0x10]
6B9A  06              push es
6B9B  57              push di
6B9C  6A 02           push 2
6B9E  9A 03 02 BC 24  call far 24BC:0203
loc_6BA3:
6BA3  C4 7E F0        les di, ptr [bp - 0x10]
6BA6  26 8A 45 32     mov al, byte ptr es:[di + 0x32]
6BAA  30 E4           xor ah, ah
6BAC  89 46 EE        mov word ptr [bp - 0x12], ax
6BAF  B8 01 00        mov ax, 1
6BB2  3B 46 EE        cmp ax, word ptr [bp - 0x12]
6BB5  76 03           jbe 0x6bba
6BB7  E9 AD 00        jmp 0x6c67
loc_6BBA:
6BBA  89 46 FC        mov word ptr [bp - 4], ax
6BBD  EB 03           jmp 0x6bc2
loc_6BBF:
6BBF  FF 46 FC        inc word ptr [bp - 4]
loc_6BC2:
6BC2  8B 46 FC        mov ax, word ptr [bp - 4]
6BC5  D1 E0           shl ax, 1
6BC7  C4 7E F0        les di, ptr [bp - 0x10]
6BCA  03 F8           add di, ax
6BCC  26 8B 45 FE     mov ax, word ptr es:[di - 2]
6BD0  C1 E0 03        shl ax, 3
6BD3  C4 3E BA D7     les di, ptr [0xd7ba]
6BD7  03 F8           add di, ax
6BD9  89 7E EA        mov word ptr [bp - 0x16], di
6BDC  8C 46 EC        mov word ptr [bp - 0x14], es
6BDF  83 7E FC 0C     cmp word ptr [bp - 4], 0xc
6BE3  73 1C           jae 0x6c01
6BE5  8B 56 FC        mov dx, word ptr [bp - 4]
6BE8  8B 7E FE        mov di, word ptr [bp - 2]
6BEB  8A 85 85 D8     mov al, byte ptr [di - 0x277b]
6BEF  30 E4           xor ah, ah
6BF1  6B F8 0E        imul di, ax, 0xe
6BF4  03 FA           add di, dx
6BF6  8A 85 04 94     mov al, byte ptr [di - 0x6bfc]
6BFA  C4 7E EA        les di, ptr [bp - 0x16]
6BFD  26 88 45 06     mov byte ptr es:[di + 6], al
loc_6C01:
6C01  8B 46 FC        mov ax, word ptr [bp - 4]
6C04  D1 E0           shl ax, 1
6C06  C4 7E F0        les di, ptr [bp - 0x10]
6C09  03 F8           add di, ax
6C0B  26 6B 45 FE 0F  imul ax, word ptr es:[di - 2], 0xf
6C10  C4 3E BE D7     les di, ptr [0xd7be]
6C14  03 F8           add di, ax
6C16  89 7E E6        mov word ptr [bp - 0x1a], di
6C19  8C 46 E8        mov word ptr [bp - 0x18], es
6C1C  26 C6 45 0A 00  mov byte ptr es:[di + 0xa], 0
6C21  26 80 7D 0C 00  cmp byte ptr es:[di + 0xc], 0
6C26  76 0E           jbe 0x6c36
6C28  26 80 7D 0D 02  cmp byte ptr es:[di + 0xd], 2
6C2D  75 07           jne 0x6c36
6C2F  26 C6 45 0D 00  mov byte ptr es:[di + 0xd], 0
6C34  EB 26           jmp 0x6c5c
loc_6C36:
6C36  C4 7E E6        les di, ptr [bp - 0x1a]
6C39  26 80 7D 0C 00  cmp byte ptr es:[di + 0xc], 0
6C3E  75 1C           jne 0x6c5c
6C40  C4 7E EA        les di, ptr [bp - 0x16]
6C43  26 80 7D 01 12  cmp byte ptr es:[di + 1], 0x12
6C48  73 12           jae 0x6c5c
6C4A  8B 46 FC        mov ax, word ptr [bp - 4]
6C4D  D1 E0           shl ax, 1
6C4F  C4 7E F0        les di, ptr [bp - 0x10]
6C52  03 F8           add di, ax
6C54  26 FF 75 FE     push word ptr es:[di - 2]
6C58  0E              push cs
6C59  E8 FB F8        call 0x6557
loc_6C5C:
6C5C  8B 46 FC        mov ax, word ptr [bp - 4]
6C5F  3B 46 EE        cmp ax, word ptr [bp - 0x12]
6C62  74 03           je 0x6c67
6C64  E9 58 FF        jmp 0x6bbf
loc_6C67:
6C67  C9              leave
6C68  CA 02 00        retf 2

; ---- routine 1B55:6C6B  (found by: far)
sub_6C6B:
6C6B  C8 0A 00 00     enter 0xa, 0
6C6F  8B 46 08        mov ax, word ptr [bp + 8]
6C72  C1 E0 02        shl ax, 2
6C75  C4 3E C8 DC     les di, ptr [0xdcc8]
6C79  03 F8           add di, ax
6C7B  89 7E FA        mov word ptr [bp - 6], di
6C7E  8C 46 FC        mov word ptr [bp - 4], es
6C81  6B 46 06 3E     imul ax, word ptr [bp + 6], 0x3e
6C85  C4 3E C2 D7     les di, ptr [0xd7c2]
6C89  03 F8           add di, ax
6C8B  81 C7 C2 FF     add di, 0xffc2
6C8F  89 7E F6        mov word ptr [bp - 0xa], di
6C92  8C 46 F8        mov word ptr [bp - 8], es
6C95  C4 7E FA        les di, ptr [bp - 6]
6C98  26 8A 45 01     mov al, byte ptr es:[di + 1]
6C9C  30 E4           xor ah, ah
6C9E  3B 46 06        cmp ax, word ptr [bp + 6]
6CA1  74 51           je 0x6cf4
6CA3  C4 7E F6        les di, ptr [bp - 0xa]
6CA6  26 80 7D 36 03  cmp byte ptr es:[di + 0x36], 3
6CAB  76 47           jbe 0x6cf4
6CAD  C4 7E FA        les di, ptr [bp - 6]
6CB0  26 8A 45 02     mov al, byte ptr es:[di + 2]
6CB4  30 E4           xor ah, ah
6CB6  31 D2           xor dx, dx
6CB8  52              push dx
6CB9  50              push ax
6CBA  6A 00           push 0
6CBC  6A 20           push 0x20
6CBE  9A C0 04 BC 24  call far 24BC:04C0
6CC3  8B C8           mov cx, ax
6CC5  8B DA           mov bx, dx
6CC7  C4 7E F6        les di, ptr [bp - 0xa]
6CCA  26 8B 45 28     mov ax, word ptr es:[di + 0x28]
6CCE  C1 E0 02        shl ax, 2
6CD1  C4 3E C8 DC     les di, ptr [0xdcc8]
6CD5  03 F8           add di, ax
6CD7  26 8A 45 02     mov al, byte ptr es:[di + 2]
6CDB  30 E4           xor ah, ah
6CDD  31 D2           xor dx, dx
6CDF  3B D3           cmp dx, bx
6CE1  7C 06           jl 0x6ce9
6CE3  7F 0F           jg 0x6cf4
6CE5  3B C1           cmp ax, cx
6CE7  73 0B           jae 0x6cf4
loc_6CE9:
6CE9  FF 76 06        push word ptr [bp + 6]
6CEC  0E              push cs
6CED  E8 8A A1        call 0xe7a
6CF0  08 C0           or al, al
6CF2  74 04           je 0x6cf8
loc_6CF4:
6CF4  B0 00           mov al, 0
6CF6  EB 02           jmp 0x6cfa
loc_6CF8:
6CF8  B0 01           mov al, 1
loc_6CFA:
6CFA  88 46 FF        mov byte ptr [bp - 1], al
6CFD  8A 46 FF        mov al, byte ptr [bp - 1]
6D00  C9              leave
6D01  CA 04 00        retf 4

; ---- routine 1B55:6D04  (found by: call)
sub_6D04:
6D04  C8 0A 00 00     enter 0xa, 0
6D08  C7 46 FE 01 00  mov word ptr [bp - 2], 1
6D0D  EB 03           jmp 0x6d12
loc_6D0F:
6D0F  FF 46 FE        inc word ptr [bp - 2]
loc_6D12:
6D12  8B 46 FE        mov ax, word ptr [bp - 2]
6D15  D1 E0           shl ax, 1
6D17  C4 7E 06        les di, ptr [bp + 6]
6D1A  03 F8           add di, ax
6D1C  26 83 7D FE 00  cmp word ptr es:[di - 2], 0
6D21  75 03           jne 0x6d26
6D23  E9 B1 00        jmp 0x6dd7
loc_6D26:
6D26  8B 7E 04        mov di, word ptr [bp + 4]
6D29  36 83 7D FE 05  cmp word ptr ss:[di - 2], 5
6D2E  72 03           jb 0x6d33
6D30  E9 A4 00        jmp 0x6dd7
loc_6D33:
6D33  8B 46 FE        mov ax, word ptr [bp - 2]
6D36  D1 E0           shl ax, 1
6D38  C4 7E 06        les di, ptr [bp + 6]
6D3B  03 F8           add di, ax
6D3D  26 8B 45 FE     mov ax, word ptr es:[di - 2]
6D41  C1 E0 03        shl ax, 3
6D44  C4 3E BA D7     les di, ptr [0xd7ba]
6D48  03 F8           add di, ax
6D4A  89 7E FA        mov word ptr [bp - 6], di
6D4D  8C 46 FC        mov word ptr [bp - 4], es
6D50  8B 46 FE        mov ax, word ptr [bp - 2]
6D53  D1 E0           shl ax, 1
6D55  C4 7E 06        les di, ptr [bp + 6]
6D58  03 F8           add di, ax
6D5A  26 6B 45 FE 0F  imul ax, word ptr es:[di - 2], 0xf
6D5F  C4 3E BE D7     les di, ptr [0xd7be]
6D63  03 F8           add di, ax
6D65  89 7E F6        mov word ptr [bp - 0xa], di
6D68  8C 46 F8        mov word ptr [bp - 8], es
6D6B  8B 46 FE        mov ax, word ptr [bp - 2]
6D6E  D1 E0           shl ax, 1
6D70  C4 7E 06        les di, ptr [bp + 6]
6D73  03 F8           add di, ax
6D75  26 8B 45 FE     mov ax, word ptr es:[di - 2]
6D79  C4 3E AE D7     les di, ptr [0xd7ae]
6D7D  03 F8           add di, ax
6D7F  26 8A 05        mov al, byte ptr es:[di]
6D82  8B 7E 04        mov di, word ptr [bp + 4]
6D85  36 3A 45 FB     cmp al, byte ptr ss:[di - 5]
6D89  74 4C           je 0x6dd7
6D8B  6A 64           push 0x64
6D8D  9A 6D 07 2A 23  call far 232A:076D
6D92  05 B4 00        add ax, 0xb4
6D95  8B D0           mov dx, ax
6D97  C4 7E FA        les di, ptr [bp - 6]
6D9A  26 8A 45 04     mov al, byte ptr es:[di + 4]
6D9E  30 E4           xor ah, ah
6DA0  3B C2           cmp ax, dx
6DA2  7E 33           jle 0x6dd7
6DA4  C4 7E F6        les di, ptr [bp - 0xa]
6DA7  26 80 7D 08 00  cmp byte ptr es:[di + 8], 0
6DAC  7E 29           jle 0x6dd7
6DAE  6A 01           push 1
6DB0  26 8A 45 0B     mov al, byte ptr es:[di + 0xb]
6DB4  30 E4           xor ah, ah
6DB6  50              push ax
6DB7  9A 59 02 BC 24  call far 24BC:0259
6DBC  08 C0           or al, al
6DBE  74 17           je 0x6dd7
6DC0  6A 02           push 2
6DC2  C4 7E F6        les di, ptr [bp - 0xa]
6DC5  81 C7 0B 00     add di, 0xb
6DC9  06              push es
6DCA  57              push di
6DCB  9A D5 00 2A 23  call far 232A:00D5
6DD0  8B 7E 04        mov di, word ptr [bp + 4]
6DD3  36 FF 45 FE     inc word ptr ss:[di - 2]
loc_6DD7:
6DD7  83 7E FE 14     cmp word ptr [bp - 2], 0x14
6DDB  74 03           je 0x6de0
6DDD  E9 2F FF        jmp 0x6d0f
loc_6DE0:
6DE0  C9              leave
6DE1  C2 06 00        ret 6

