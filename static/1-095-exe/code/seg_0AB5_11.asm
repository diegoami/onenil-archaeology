; 1-095.EXE (One-Nil 95), code segment 0AB5 (image offsets 0AB50..1993F), part 11 of 22
; packed 1-095.EXE sha256 f659fb2d334500d6901fc8d6a0f06c85c0ccda2eb4a3035ae3bb0a0004d79192 (LZEXE 0.91)
; unpacked (tools/static/unlzexe.py) sha256 8df646e017e0965a5d90a58181ca764219ad847833aad0b6cb58fc53372bfb2c
; tool: capstone 5.0.9 (pip package; core library 5.0.1280) (CS_ARCH_X86, CS_MODE_16), recursive descent from the entry point, far calls and near calls/jumps, then routine prologues (55 89 E5 / 55 8B EC / C8 iw 00) in what remains; tools/static/listing.py
; addresses are SEGMENT:OFFSET with SEGMENT the image paragraph before relocation; image offset = SEGMENT*16+OFFSET
; ---- routine 0AB5:63E3  (found by: call)
sub_63E3:
63E3  C8 04 00 00     enter 4, 0
63E7  C4 7E 06        les di, ptr [bp + 6]
63EA  26 6B 45 0E 0F  imul ax, word ptr es:[di + 0xe], 0xf
63EF  C4 3E BE D7     les di, ptr [0xd7be]
63F3  03 F8           add di, ax
63F5  89 7E FC        mov word ptr [bp - 4], di
63F8  8C 46 FE        mov word ptr [bp - 2], es
63FB  6A 32           push 0x32
63FD  E8 E2 B9        call 0x1de2
6400  68 FE 0E        push 0xefe
6403  FF 36 3C CF     push word ptr [0xcf3c]
6407  BF 56 CF        mov di, 0xcf56
640A  1E              push ds
640B  57              push di
640C  9A A3 09 94 19  call far 1994:09A3
6411  C4 3E D2 D7     les di, ptr [0xd7d2]
6415  26 8A 45 02     mov al, byte ptr es:[di + 2]
6419  30 E4           xor ah, ah
641B  6B C0 28        imul ax, ax, 0x28
641E  50              push ax
641F  9A D6 00 94 19  call far 1994:00D6
6424  BF 56 CF        mov di, 0xcf56
6427  1E              push ds
6428  57              push di
6429  9A 3F 09 94 19  call far 1994:093F
642E  6A 05           push 5
6430  C4 7E FC        les di, ptr [bp - 4]
6433  81 C7 0B 00     add di, 0xb
6437  06              push es
6438  57              push di
6439  9A D5 00 1A 23  call far 231A:00D5
643E  C4 7E 06        les di, ptr [bp + 6]
6441  06              push es
6442  57              push di
6443  0E              push cs
6444  E8 74 B8        call 0x1cbb
6447  98              cwde
6448  6B F8 0A        imul di, ax, 0xa
644B  FE 85 D9 D0     inc byte ptr [di - 0x2f27]
644F  83 3E B4 D0 05  cmp word ptr [0xd0b4], 5
6454  73 04           jae 0x645a
6456  FF 06 B4 D0     inc word ptr [0xd0b4]
loc_645A:
645A  C4 7E 06        les di, ptr [bp + 6]
645D  26 8B 45 0E     mov ax, word ptr es:[di + 0xe]
6461  C1 E0 03        shl ax, 3
6464  C4 3E BA D7     les di, ptr [0xd7ba]
6468  03 F8           add di, ax
646A  26 8A 05        mov al, byte ptr es:[di]
646D  30 E4           xor ah, ah
646F  50              push ax
6470  9A DA 0D 51 1B  call far 1B51:0DDA
6475  08 C0           or al, al
6477  75 0C           jne 0x6485
6479  C4 7E 06        les di, ptr [bp + 6]
647C  26 FF 75 0E     push word ptr es:[di + 0xe]
6480  9A 26 53 51 1B  call far 1B51:5326
loc_6485:
6485  C9              leave
6486  CA 04 00        retf 4

; ---- routine 0AB5:6489  (found by: call)
sub_6489:
6489  C8 0A 00 00     enter 0xa, 0
648D  8A 46 04        mov al, byte ptr [bp + 4]
6490  98              cwde
6491  8B F8           mov di, ax
6493  D1 E7           shl di, 1
6495  FF B5 E4 D6     push word ptr [di - 0x291c]
6499  9A DA 0D 51 1B  call far 1B51:0DDA
649E  08 C0           or al, al
64A0  74 2B           je 0x64cd
64A2  8A 46 04        mov al, byte ptr [bp + 4]
64A5  98              cwde
64A6  6B F8 0A        imul di, ax, 0xa
64A9  8A 85 DA D0     mov al, byte ptr [di - 0x2f26]
64AD  30 E4           xor ah, ah
64AF  8B D0           mov dx, ax
64B1  8A 46 04        mov al, byte ptr [bp + 4]
64B4  98              cwde
64B5  6B F8 0A        imul di, ax, 0xa
64B8  8A 85 DB D0     mov al, byte ptr [di - 0x2f25]
64BC  30 E4           xor ah, ah
64BE  03 C2           add ax, dx
64C0  3D 03 00        cmp ax, 3
64C3  B0 00           mov al, 0
64C5  7D 01           jge 0x64c8
64C7  40              inc ax
loc_64C8:
64C8  88 46 FF        mov byte ptr [bp - 1], al
64CB  EB 75           jmp 0x6542
loc_64CD:
64CD  31 C0           xor ax, ax
64CF  89 46 FA        mov word ptr [bp - 6], ax
64D2  C7 46 FC 01 00  mov word ptr [bp - 4], 1
64D7  EB 03           jmp 0x64dc
loc_64D9:
64D9  FF 46 FC        inc word ptr [bp - 4]
loc_64DC:
64DC  8A 46 04        mov al, byte ptr [bp + 4]
64DF  98              cwde
64E0  8B F8           mov di, ax
64E2  D1 E7           shl di, 1
64E4  6B 85 E4 D6 3E  imul ax, word ptr [di - 0x291c], 0x3e
64E9  C4 3E C2 D7     les di, ptr [0xd7c2]
64ED  03 F8           add di, ax
64EF  81 C7 C2 FF     add di, 0xffc2
64F3  8B 46 FC        mov ax, word ptr [bp - 4]
64F6  D1 E0           shl ax, 1
64F8  03 F8           add di, ax
64FA  26 FF 75 FE     push word ptr es:[di - 2]
64FE  9A E9 4E 51 1B  call far 1B51:4EE9
6503  08 C0           or al, al
6505  75 03           jne 0x650a
6507  FF 46 FA        inc word ptr [bp - 6]
loc_650A:
650A  83 7E FC 14     cmp word ptr [bp - 4], 0x14
650E  75 C9           jne 0x64d9
6510  83 7E FA 0B     cmp word ptr [bp - 6], 0xb
6514  76 23           jbe 0x6539
6516  8A 46 04        mov al, byte ptr [bp + 4]
6519  98              cwde
651A  6B F8 0A        imul di, ax, 0xa
651D  8A 85 DA D0     mov al, byte ptr [di - 0x2f26]
6521  30 E4           xor ah, ah
6523  8B D0           mov dx, ax
6525  8A 46 04        mov al, byte ptr [bp + 4]
6528  98              cwde
6529  6B F8 0A        imul di, ax, 0xa
652C  8A 85 DB D0     mov al, byte ptr [di - 0x2f25]
6530  30 E4           xor ah, ah
6532  03 C2           add ax, dx
6534  3D 03 00        cmp ax, 3
6537  7C 04           jl 0x653d
loc_6539:
6539  B0 00           mov al, 0
653B  EB 02           jmp 0x653f
loc_653D:
653D  B0 01           mov al, 1
loc_653F:
653F  88 46 FF        mov byte ptr [bp - 1], al
loc_6542:
6542  8A 46 FF        mov al, byte ptr [bp - 1]
6545  C9              leave
6546  C2 02 00        ret 2

; ---- routine 0AB5:6549  (found by: call)
sub_6549:
6549  C8 04 00 00     enter 4, 0
654D  6B 46 04 0F     imul ax, word ptr [bp + 4], 0xf
6551  C4 3E BE D7     les di, ptr [0xd7be]
6555  03 F8           add di, ax
6557  89 7E FC        mov word ptr [bp - 4], di
655A  8C 46 FE        mov word ptr [bp - 2], es
655D  6A 06           push 6
655F  81 C7 0B 00     add di, 0xb
6563  06              push es
6564  57              push di
6565  9A D5 00 1A 23  call far 231A:00D5
656A  6A 05           push 5
656C  C4 7E FC        les di, ptr [bp - 4]
656F  81 C7 0B 00     add di, 0xb
6573  06              push es
6574  57              push di
6575  9A F8 00 1A 23  call far 231A:00F8
657A  8A 46 06        mov al, byte ptr [bp + 6]
657D  98              cwde
657E  6B F8 0A        imul di, ax, 0xa
6581  FE 85 DA D0     inc byte ptr [di - 0x2f26]
6585  C9              leave
6586  C2 04 00        ret 4

; ---- routine 0AB5:6589  (found by: call)
sub_6589:
6589  C8 0E 00 00     enter 0xe, 0
658D  C4 7E 06        les di, ptr [bp + 6]
6590  26 6B 45 0E 0F  imul ax, word ptr es:[di + 0xe], 0xf
6595  C4 3E BE D7     les di, ptr [0xd7be]
6599  03 F8           add di, ax
659B  C4 7E 06        les di, ptr [bp + 6]
659E  06              push es
659F  57              push di
65A0  0E              push cs
65A1  E8 17 B7        call 0x1cbb
65A4  50              push ax
65A5  E8 E1 FE        call 0x6489
65A8  08 C0           or al, al
65AA  75 03           jne 0x65af
65AC  E9 1D 02        jmp 0x67cc
loc_65AF:
65AF  6A 33           push 0x33
65B1  E8 2E B8        call 0x1de2
65B4  68 FE 0C        push 0xcfe
65B7  FF 36 3C CF     push word ptr [0xcf3c]
65BB  BF 56 CF        mov di, 0xcf56
65BE  1E              push ds
65BF  57              push di
65C0  9A A3 09 94 19  call far 1994:09A3
65C5  C4 7E 06        les di, ptr [bp + 6]
65C8  06              push es
65C9  57              push di
65CA  0E              push cs
65CB  E8 ED B6        call 0x1cbb
65CE  50              push ax
65CF  C4 7E 06        les di, ptr [bp + 6]
65D2  26 FF 75 0E     push word ptr es:[di + 0xe]
65D6  E8 70 FF        call 0x6549
65D9  C4 7E 06        les di, ptr [bp + 6]
65DC  26 8A 45 07     mov al, byte ptr es:[di + 7]
65E0  30 E4           xor ah, ah
65E2  50              push ax
65E3  E8 1F FD        call 0x6305
65E6  83 3E B4 D0 05  cmp word ptr [0xd0b4], 5
65EB  73 04           jae 0x65f1
65ED  FF 06 B4 D0     inc word ptr [0xd0b4]
loc_65F1:
65F1  BF 56 CF        mov di, 0xcf56
65F4  1E              push ds
65F5  57              push di
65F6  9A 3F 09 94 19  call far 1994:093F
65FB  6A FE           push -2
65FD  6A 01           push 1
65FF  C4 7E 06        les di, ptr [bp + 6]
6602  06              push es
6603  57              push di
6604  0E              push cs
6605  E8 C8 01        call 0x67d0
6608  C7 46 FE 01 00  mov word ptr [bp - 2], 1
660D  EB 03           jmp 0x6612
loc_660F:
660F  FF 46 FE        inc word ptr [bp - 2]
loc_6612:
6612  C4 7E 06        les di, ptr [bp + 6]
6615  06              push es
6616  57              push di
6617  0E              push cs
6618  E8 A0 B6        call 0x1cbb
661B  08 C0           or al, al
661D  B0 00           mov al, 0
661F  75 01           jne 0x6622
6621  40              inc ax
loc_6622:
6622  98              cwde
6623  8B F8           mov di, ax
6625  8A 85 56 0D     mov al, byte ptr [di + 0xd56]
6629  30 E4           xor ah, ah
662B  03 46 FE        add ax, word ptr [bp - 2]
662E  6B F8 19        imul di, ax, 0x19
6631  81 C7 EF CC     add di, 0xccef
6635  1E              push ds
6636  07              pop es
6637  89 7E F6        mov word ptr [bp - 0xa], di
663A  8C 46 F8        mov word ptr [bp - 8], es
663D  06              push es
663E  57              push di
663F  0E              push cs
6640  E8 5E B6        call 0x1ca1
6643  08 C0           or al, al
6645  75 0D           jne 0x6654
6647  6A 02           push 2
6649  6A 00           push 0
664B  C4 7E F6        les di, ptr [bp - 0xa]
664E  06              push es
664F  57              push di
6650  0E              push cs
6651  E8 7C 01        call 0x67d0
loc_6654:
6654  83 7E FE 0B     cmp word ptr [bp - 2], 0xb
6658  75 B5           jne 0x660f
665A  C4 7E 06        les di, ptr [bp + 6]
665D  26 8B 45 0E     mov ax, word ptr es:[di + 0xe]
6661  C1 E0 03        shl ax, 3
6664  C4 3E BA D7     les di, ptr [0xd7ba]
6668  03 F8           add di, ax
666A  89 7E F6        mov word ptr [bp - 0xa], di
666D  8C 46 F8        mov word ptr [bp - 8], es
6670  26 8A 05        mov al, byte ptr es:[di]
6673  30 E4           xor ah, ah
6675  50              push ax
6676  9A DA 0D 51 1B  call far 1B51:0DDA
667B  08 C0           or al, al
667D  74 03           je 0x6682
667F  E9 3B 01        jmp 0x67bd
loc_6682:
6682  C4 7E F6        les di, ptr [bp - 0xa]
6685  26 8A 05        mov al, byte ptr es:[di]
6688  30 E4           xor ah, ah
668A  6B C0 3E        imul ax, ax, 0x3e
668D  C4 3E C2 D7     les di, ptr [0xd7c2]
6691  03 F8           add di, ax
6693  81 C7 C2 FF     add di, 0xffc2
6697  06              push es
6698  57              push di
6699  C4 7E 06        les di, ptr [bp + 6]
669C  26 8A 45 07     mov al, byte ptr es:[di + 7]
66A0  30 E4           xor ah, ah
66A2  50              push ax
66A3  E8 91 41        call 0xa837
66A6  C7 46 FE 01 00  mov word ptr [bp - 2], 1
66AB  EB 03           jmp 0x66b0
loc_66AD:
66AD  FF 46 FE        inc word ptr [bp - 2]
loc_66B0:
66B0  C4 7E 06        les di, ptr [bp + 6]
66B3  06              push es
66B4  57              push di
66B5  0E              push cs
66B6  E8 02 B6        call 0x1cbb
66B9  98              cwde
66BA  8B F8           mov di, ax
66BC  8A 85 56 0D     mov al, byte ptr [di + 0xd56]
66C0  30 E4           xor ah, ah
66C2  03 46 FE        add ax, word ptr [bp - 2]
66C5  6B F8 19        imul di, ax, 0x19
66C8  81 C7 EF CC     add di, 0xccef
66CC  1E              push ds
66CD  07              pop es
66CE  89 7E F2        mov word ptr [bp - 0xe], di
66D1  8C 46 F4        mov word ptr [bp - 0xc], es
66D4  06              push es
66D5  57              push di
66D6  0E              push cs
66D7  E8 C7 B5        call 0x1ca1
66DA  08 C0           or al, al
66DC  74 03           je 0x66e1
66DE  E9 84 00        jmp 0x6765
loc_66E1:
66E1  C4 7E F2        les di, ptr [bp - 0xe]
66E4  26 8B 45 0E     mov ax, word ptr es:[di + 0xe]
66E8  C1 E0 03        shl ax, 3
66EB  C4 3E BA D7     les di, ptr [0xd7ba]
66EF  03 F8           add di, ax
66F1  26 8A 55 07     mov dl, byte ptr es:[di + 7]
66F5  C4 7E F2        les di, ptr [bp - 0xe]
66F8  26 8B 45 0E     mov ax, word ptr es:[di + 0xe]
66FC  C1 E0 03        shl ax, 3
66FF  C4 3E BA D7     les di, ptr [0xd7ba]
6703  03 F8           add di, ax
6705  26 8A 45 06     mov al, byte ptr es:[di + 6]
6709  3A C2           cmp al, dl
670B  74 58           je 0x6765
670D  C4 7E F2        les di, ptr [bp - 0xe]
6710  26 8B 45 0E     mov ax, word ptr es:[di + 0xe]
6714  C1 E0 03        shl ax, 3
6717  C4 3E BA D7     les di, ptr [0xd7ba]
671B  03 F8           add di, ax
671D  26 8A 45 06     mov al, byte ptr es:[di + 6]
6721  C4 7E F6        les di, ptr [bp - 0xa]
6724  26 3A 45 06     cmp al, byte ptr es:[di + 6]
6728  75 3B           jne 0x6765
672A  26 8A 05        mov al, byte ptr es:[di]
672D  30 E4           xor ah, ah
672F  6B C0 3E        imul ax, ax, 0x3e
6732  C4 3E C2 D7     les di, ptr [0xd7c2]
6736  03 F8           add di, ax
6738  81 C7 C2 FF     add di, 0xffc2
673C  06              push es
673D  57              push di
673E  C4 7E F2        les di, ptr [bp - 0xe]
6741  06              push es
6742  57              push di
6743  0E              push cs
6744  E8 74 B5        call 0x1cbb
6747  98              cwde
6748  8B F8           mov di, ax
674A  8A 85 56 0D     mov al, byte ptr [di + 0xd56]
674E  30 E4           xor ah, ah
6750  03 46 FE        add ax, word ptr [bp - 2]
6753  50              push ax
6754  C4 7E F2        les di, ptr [bp - 0xe]
6757  06              push es
6758  57              push di
6759  0E              push cs
675A  E8 5E B5        call 0x1cbb
675D  50              push ax
675E  6A 01           push 1
6760  E8 E8 41        call 0xa94b
6763  EB 09           jmp 0x676e
loc_6765:
6765  83 7E FE 0B     cmp word ptr [bp - 2], 0xb
6769  74 03           je 0x676e
676B  E9 3F FF        jmp 0x66ad
loc_676E:
676E  C7 46 FE 0C 00  mov word ptr [bp - 2], 0xc
6773  EB 03           jmp 0x6778
loc_6775:
6775  FF 46 FE        inc word ptr [bp - 2]
loc_6778:
6778  8B 46 FE        mov ax, word ptr [bp - 2]
677B  D1 E0           shl ax, 1
677D  8B D0           mov dx, ax
677F  C4 7E F6        les di, ptr [bp - 0xa]
6782  26 8A 05        mov al, byte ptr es:[di]
6785  30 E4           xor ah, ah
6787  6B C0 3E        imul ax, ax, 0x3e
678A  C4 3E C2 D7     les di, ptr [0xd7c2]
678E  03 F8           add di, ax
6790  03 FA           add di, dx
6792  26 8B 45 C0     mov ax, word ptr es:[di - 0x40]
6796  C1 E0 03        shl ax, 3
6799  C4 3E BA D7     les di, ptr [0xd7ba]
679D  03 F8           add di, ax
679F  26 80 7D 06 00  cmp byte ptr es:[di + 6], 0
67A4  75 0F           jne 0x67b5
67A6  26 80 7D 07 00  cmp byte ptr es:[di + 7], 0
67AB  74 08           je 0x67b5
67AD  26 8A 45 07     mov al, byte ptr es:[di + 7]
67B1  26 88 45 06     mov byte ptr es:[di + 6], al
loc_67B5:
67B5  83 7E FE 14     cmp word ptr [bp - 2], 0x14
67B9  75 BA           jne 0x6775
67BB  EB 0F           jmp 0x67cc
loc_67BD:
67BD  C4 7E F6        les di, ptr [bp - 0xa]
67C0  26 80 7D 06 00  cmp byte ptr es:[di + 6], 0
67C5  75 05           jne 0x67cc
67C7  C6 06 E2 D6 01  mov byte ptr [0xd6e2], 1
loc_67CC:
67CC  C9              leave
67CD  CA 04 00        retf 4

; ---- routine 0AB5:67D0  (found by: call)
sub_67D0:
67D0  C8 04 00 00     enter 4, 0
67D4  C4 7E 06        les di, ptr [bp + 6]
67D7  26 6B 45 0E 0F  imul ax, word ptr es:[di + 0xe], 0xf
67DC  C4 3E BE D7     les di, ptr [0xd7be]
67E0  03 F8           add di, ax
67E2  89 7E FC        mov word ptr [bp - 4], di
67E5  8C 46 FE        mov word ptr [bp - 2], es
67E8  26 8A 45 06     mov al, byte ptr es:[di + 6]
67EC  98              cwde
67ED  03 46 0C        add ax, word ptr [bp + 0xc]
67F0  89 46 0C        mov word ptr [bp + 0xc], ax
67F3  8D 7E 0C        lea di, [bp + 0xc]
67F6  16              push ss
67F7  57              push di
67F8  6A 01           push 1
67FA  68 FF 00        push 0xff
67FD  9A D9 03 AC 24  call far 24AC:03D9
6802  8A 46 0C        mov al, byte ptr [bp + 0xc]
6805  C4 7E FC        les di, ptr [bp - 4]
6808  26 88 45 06     mov byte ptr es:[di + 6], al
680C  80 7E 0A 00     cmp byte ptr [bp + 0xa], 0
6810  74 33           je 0x6845
6812  26 8A 45 06     mov al, byte ptr es:[di + 6]
6816  98              cwde
6817  99              cdq
6818  52              push dx
6819  50              push ax
681A  6A 00           push 0
681C  6A 20           push 0x20
681E  9A FA 04 AC 24  call far 24AC:04FA
6823  50              push ax
6824  C4 7E 06        les di, ptr [bp + 6]
6827  06              push es
6828  57              push di
6829  0E              push cs
682A  E8 72 B6        call 0x1e9f
682D  30 E4           xor ah, ah
682F  50              push ax
6830  C4 7E 06        les di, ptr [bp + 6]
6833  06              push es
6834  57              push di
6835  0E              push cs
6836  E8 82 B4        call 0x1cbb
6839  98              cwde
683A  6B F8 14        imul di, ax, 0x14
683D  58              pop ax
683E  03 F8           add di, ax
6840  58              pop ax
6841  88 85 97 D1     mov byte ptr [di - 0x2e69], al
loc_6845:
6845  C9              leave
6846  CA 08 00        retf 8

; ---- routine 0AB5:6849  (found by: call)
sub_6849:
6849  C8 04 00 00     enter 4, 0
684D  C4 7E 06        les di, ptr [bp + 6]
6850  06              push es
6851  57              push di
6852  0E              push cs
6853  E8 4B B4        call 0x1ca1
6856  08 C0           or al, al
6858  75 11           jne 0x686b
685A  C4 7E 06        les di, ptr [bp + 6]
685D  06              push es
685E  57              push di
685F  0E              push cs
6860  E8 58 B4        call 0x1cbb
6863  50              push ax
6864  E8 22 FC        call 0x6489
6867  08 C0           or al, al
6869  75 03           jne 0x686e
loc_686B:
686B  E9 C3 00        jmp 0x6931
loc_686E:
686E  6A 34           push 0x34
6870  C4 7E 06        les di, ptr [bp + 6]
6873  06              push es
6874  57              push di
6875  0E              push cs
6876  E8 AF B5        call 0x1e28
6879  C4 7E 06        les di, ptr [bp + 6]
687C  26 FF 75 0E     push word ptr es:[di + 0xe]
6880  9A 94 13 94 19  call far 1994:1394
6885  C4 7E 06        les di, ptr [bp + 6]
6888  26 8A 45 07     mov al, byte ptr es:[di + 7]
688C  30 E4           xor ah, ah
688E  50              push ax
688F  E8 73 FA        call 0x6305
6892  6A FE           push -2
6894  6A 01           push 1
6896  C4 7E 06        les di, ptr [bp + 6]
6899  06              push es
689A  57              push di
689B  0E              push cs
689C  E8 31 FF        call 0x67d0
689F  83 3E B4 D0 05  cmp word ptr [0xd0b4], 5
68A4  73 04           jae 0x68aa
68A6  FF 06 B4 D0     inc word ptr [0xd0b4]
loc_68AA:
68AA  C4 7E 06        les di, ptr [bp + 6]
68AD  06              push es
68AE  57              push di
68AF  0E              push cs
68B0  E8 08 B4        call 0x1cbb
68B3  98              cwde
68B4  6B F8 0A        imul di, ax, 0xa
68B7  FE 85 DB D0     inc byte ptr [di - 0x2f25]
68BB  C4 7E 06        les di, ptr [bp + 6]
68BE  26 8B 45 0E     mov ax, word ptr es:[di + 0xe]
68C2  C1 E0 03        shl ax, 3
68C5  C4 3E BA D7     les di, ptr [0xd7ba]
68C9  03 F8           add di, ax
68CB  89 7E FC        mov word ptr [bp - 4], di
68CE  8C 46 FE        mov word ptr [bp - 2], es
68D1  26 8A 05        mov al, byte ptr es:[di]
68D4  30 E4           xor ah, ah
68D6  50              push ax
68D7  9A DA 0D 51 1B  call far 1B51:0DDA
68DC  08 C0           or al, al
68DE  75 2F           jne 0x690f
68E0  C4 7E FC        les di, ptr [bp - 4]
68E3  26 8A 05        mov al, byte ptr es:[di]
68E6  30 E4           xor ah, ah
68E8  6B C0 3E        imul ax, ax, 0x3e
68EB  C4 3E C2 D7     les di, ptr [0xd7c2]
68EF  03 F8           add di, ax
68F1  81 C7 C2 FF     add di, 0xffc2
68F5  06              push es
68F6  57              push di
68F7  C4 7E 06        les di, ptr [bp + 6]
68FA  26 8A 45 07     mov al, byte ptr es:[di + 7]
68FE  30 E4           xor ah, ah
6900  50              push ax
6901  06              push es
6902  57              push di
6903  0E              push cs
6904  E8 B4 B3        call 0x1cbb
6907  50              push ax
6908  6A 01           push 1
690A  E8 3E 40        call 0xa94b
690D  EB 22           jmp 0x6931
loc_690F:
690F  C4 7E FC        les di, ptr [bp - 4]
6912  26 80 7D 06 00  cmp byte ptr es:[di + 6], 0
6917  74 13           je 0x692c
6919  C4 7E 06        les di, ptr [bp + 6]
691C  06              push es
691D  57              push di
691E  0E              push cs
691F  E8 99 B3        call 0x1cbb
6922  98              cwde
6923  8B F8           mov di, ax
6925  80 BD E0 D6 00  cmp byte ptr [di - 0x2920], 0
692A  76 05           jbe 0x6931
loc_692C:
692C  C6 06 E2 D6 01  mov byte ptr [0xd6e2], 1
loc_6931:
6931  C9              leave
6932  CA 04 00        retf 4

; ---- routine 0AB5:6935  (found by: call)
sub_6935:
6935  C8 02 00 00     enter 2, 0
6939  C6 06 B8 D0 00  mov byte ptr [0xd0b8], 0
693E  6A 04           push 4
6940  9A E0 01 94 19  call far 1994:01E0
6945  C7 46 FE 01 00  mov word ptr [bp - 2], 1
694A  EB 03           jmp 0x694f
loc_694C:
694C  FF 46 FE        inc word ptr [bp - 2]
loc_694F:
694F  A0 9F D0        mov al, byte ptr [0xd09f]
6952  30 E4           xor ah, ah
6954  6B F8 19        imul di, ax, 0x19
6957  81 C7 EF CC     add di, 0xccef
695B  1E              push ds
695C  57              push di
695D  0E              push cs
695E  E8 C7 04        call 0x6e28
6961  C4 3E D2 D7     les di, ptr [0xd7d2]
6965  26 8A 45 02     mov al, byte ptr es:[di + 2]
6969  30 E4           xor ah, ah
696B  C1 E0 02        shl ax, 2
696E  50              push ax
696F  9A D6 00 94 19  call far 1994:00D6
6974  A0 A0 D0        mov al, byte ptr [0xd0a0]
6977  30 E4           xor ah, ah
6979  6B F8 19        imul di, ax, 0x19
697C  81 C7 EF CC     add di, 0xccef
6980  1E              push ds
6981  57              push di
6982  0E              push cs
6983  E8 A2 04        call 0x6e28
6986  C4 3E D2 D7     les di, ptr [0xd7d2]
698A  26 8A 45 02     mov al, byte ptr es:[di + 2]
698E  30 E4           xor ah, ah
6990  C1 E0 02        shl ax, 2
6993  50              push ax
6994  9A D6 00 94 19  call far 1994:00D6
6999  8A 46 04        mov al, byte ptr [bp + 4]
699C  50              push ax
699D  BF 3C CF        mov di, 0xcf3c
69A0  1E              push ds
69A1  57              push di
69A2  0E              push cs
69A3  E8 68 0D        call 0x770e
69A6  83 7E FE 0A     cmp word ptr [bp - 2], 0xa
69AA  75 A0           jne 0x694c
69AC  E8 89 B0        call 0x1a38
69AF  C6 06 9E D0 00  mov byte ptr [0xd09e], 0
69B4  C9              leave
69B5  C2 02 00        ret 2

; ---- routine 0AB5:69B8  (found by: call)
sub_69B8:
69B8  C8 04 00 00     enter 4, 0
69BC  A0 A0 D0        mov al, byte ptr [0xd0a0]
69BF  30 E4           xor ah, ah
69C1  6B F8 19        imul di, ax, 0x19
69C4  81 C7 EF CC     add di, 0xccef
69C8  1E              push ds
69C9  07              pop es
69CA  89 7E FC        mov word ptr [bp - 4], di
69CD  8C 46 FE        mov word ptr [bp - 2], es
69D0  E8 CD AF        call 0x19a0
69D3  3D 04 00        cmp ax, 4
69D6  7D 36           jge 0x6a0e
69D8  6A 05           push 5
69DA  C4 7E FC        les di, ptr [bp - 4]
69DD  26 6B 45 0E 0F  imul ax, word ptr es:[di + 0xe], 0xf
69E2  C4 3E BE D7     les di, ptr [0xd7be]
69E6  03 F8           add di, ax
69E8  26 8A 45 0B     mov al, byte ptr es:[di + 0xb]
69EC  30 E4           xor ah, ah
69EE  50              push ax
69EF  9A 59 02 AC 24  call far 24AC:0259
69F4  08 C0           or al, al
69F6  74 0B           je 0x6a03
69F8  C4 7E FC        les di, ptr [bp - 4]
69FB  06              push es
69FC  57              push di
69FD  0E              push cs
69FE  E8 88 FB        call 0x6589
6A01  EB 09           jmp 0x6a0c
loc_6A03:
6A03  C4 7E FC        les di, ptr [bp - 4]
6A06  06              push es
6A07  57              push di
6A08  0E              push cs
6A09  E8 D7 F9        call 0x63e3
loc_6A0C:
6A0C  EB 14           jmp 0x6a22
loc_6A0E:
6A0E  6A 20           push 0x20
6A10  9A 1C 0D AC 24  call far 24AC:0D1C
6A15  08 C0           or al, al
6A17  74 09           je 0x6a22
6A19  C4 7E FC        les di, ptr [bp - 4]
6A1C  06              push es
6A1D  57              push di
6A1E  0E              push cs
6A1F  E8 67 FB        call 0x6589
loc_6A22:
6A22  E8 7B AF        call 0x19a0
6A25  3D 01 00        cmp ax, 1
6A28  75 4E           jne 0x6a78
6A2A  A0 A0 D0        mov al, byte ptr [0xd0a0]
6A2D  30 E4           xor ah, ah
6A2F  6B F8 19        imul di, ax, 0x19
6A32  FF B5 FD CC     push word ptr [di - 0x3303]
6A36  9A 6C 4D 51 1B  call far 1B51:4D6C
6A3B  50              push ax
6A3C  A0 9F D0        mov al, byte ptr [0xd09f]
6A3F  30 E4           xor ah, ah
6A41  6B F8 19        imul di, ax, 0x19
6A44  FF B5 FD CC     push word ptr [di - 0x3303]
6A48  9A 6C 4D 51 1B  call far 1B51:4D6C
6A4D  5A              pop dx
6A4E  3A C2           cmp al, dl
6A50  76 14           jbe 0x6a66
6A52  A0 A0 D0        mov al, byte ptr [0xd0a0]
6A55  30 E4           xor ah, ah
6A57  6B F8 19        imul di, ax, 0x19
6A5A  81 C7 EF CC     add di, 0xccef
6A5E  1E              push ds
6A5F  57              push di
6A60  0E              push cs
6A61  E8 E5 FD        call 0x6849
6A64  EB 12           jmp 0x6a78
loc_6A66:
6A66  A0 9F D0        mov al, byte ptr [0xd09f]
6A69  30 E4           xor ah, ah
6A6B  6B F8 19        imul di, ax, 0x19
6A6E  81 C7 EF CC     add di, 0xccef
6A72  1E              push ds
6A73  57              push di
6A74  0E              push cs
6A75  E8 D1 FD        call 0x6849
loc_6A78:
6A78  C9              leave
6A79  C3              ret

; ---- routine 0AB5:6A7A  (found by: call)
sub_6A7A:
6A7A  C8 A0 00 00     enter 0xa0, 0
6A7E  C4 3E 58 DD     les di, ptr [0xdd58]
6A82  81 C7 00 0F     add di, 0xf00
6A86  06              push es
6A87  57              push di
6A88  8D BE 60 FF     lea di, [bp - 0xa0]
6A8C  16              push ss
6A8D  57              push di
6A8E  68 A0 00        push 0xa0
6A91  9A C2 01 AC 24  call far 24AC:01C2
6A96  80 7E 06 00     cmp byte ptr [bp + 6], 0
6A9A  75 11           jne 0x6aad
6A9C  BF 06 2E        mov di, 0x2e06
6A9F  1E              push ds
6AA0  57              push di
6AA1  BF 5C DD        mov di, 0xdd5c
6AA4  1E              push ds
6AA5  57              push di
6AA6  9A 2F 05 1A 23  call far 231A:052F
6AAB  EB 24           jmp 0x6ad1
loc_6AAD:
6AAD  BF 3C 2E        mov di, 0x2e3c
6AB0  1E              push ds
6AB1  57              push di
6AB2  BF 5C DD        mov di, 0xdd5c
6AB5  1E              push ds
6AB6  57              push di
6AB7  9A 2F 05 1A 23  call far 231A:052F
6ABC  8A 46 04        mov al, byte ptr [bp + 4]
6ABF  98              cwde
6AC0  8B F8           mov di, ax
6AC2  D1 E7           shl di, 1
6AC4  FF B5 E4 D6     push word ptr [di - 0x291c]
6AC8  6A 19           push 0x19
6ACA  6A 01           push 1
6ACC  9A 43 0E 51 1B  call far 1B51:0E43
loc_6AD1:
6AD1  C4 3E 5C DD     les di, ptr [0xdd5c]
6AD5  81 C7 00 0F     add di, 0xf00
6AD9  06              push es
6ADA  57              push di
6ADB  C4 3E 58 DD     les di, ptr [0xdd58]
6ADF  81 C7 00 0F     add di, 0xf00
6AE3  06              push es
6AE4  57              push di
6AE5  68 A0 00        push 0xa0
6AE8  9A C2 01 AC 24  call far 24AC:01C2
6AED  8A 46 06        mov al, byte ptr [bp + 6]
6AF0  98              cwde
6AF1  8B F8           mov di, ax
6AF3  D1 E7           shl di, 1
6AF5  FF B5 14 0B     push word ptr [di + 0xb14]
6AF9  9A A6 19 AC 24  call far 24AC:19A6
6AFE  9A 58 0C AC 24  call far 24AC:0C58
6B03  08 C0           or al, al
6B05  74 07           je 0x6b0e
6B07  9A 9B 09 1A 23  call far 231A:099B
6B0C  EB 05           jmp 0x6b13
loc_6B0E:
6B0E  C6 06 8A DE 01  mov byte ptr [0xde8a], 1
loc_6B13:
6B13  8D BE 60 FF     lea di, [bp - 0xa0]
6B17  16              push ss
6B18  57              push di
6B19  C4 3E 58 DD     les di, ptr [0xdd58]
6B1D  81 C7 00 0F     add di, 0xf00
6B21  06              push es
6B22  57              push di
6B23  68 A0 00        push 0xa0
6B26  9A C2 01 AC 24  call far 24AC:01C2
6B2B  C9              leave
6B2C  C2 04 00        ret 4

; ---- routine 0AB5:6B2F  (found by: call)
sub_6B2F:
6B2F  C8 0E 00 00     enter 0xe, 0
6B33  C6 46 FF 00     mov byte ptr [bp - 1], 0
6B37  EB 03           jmp 0x6b3c
loc_6B39:
6B39  FE 46 FF        inc byte ptr [bp - 1]
loc_6B3C:
6B3C  8A 46 FF        mov al, byte ptr [bp - 1]
6B3F  98              cwde
6B40  8B F8           mov di, ax
6B42  D1 E7           shl di, 1
6B44  FF B5 E4 D6     push word ptr [di - 0x291c]
6B48  9A DA 0D 51 1B  call far 1B51:0DDA
6B4D  08 C0           or al, al
6B4F  75 03           jne 0x6b54
6B51  E9 7D 00        jmp 0x6bd1
loc_6B54:
6B54  8A 46 FF        mov al, byte ptr [bp - 1]
6B57  98              cwde
6B58  8B F8           mov di, ax
6B5A  8A 85 56 0D     mov al, byte ptr [di + 0xd56]
6B5E  30 E4           xor ah, ah
6B60  40              inc ax
6B61  6B F8 19        imul di, ax, 0x19
6B64  FF B5 FD CC     push word ptr [di - 0x3303]
6B68  9A E9 4E 51 1B  call far 1B51:4EE9
6B6D  88 46 FB        mov byte ptr [bp - 5], al
6B70  80 3E E2 D6 00  cmp byte ptr [0xd6e2], 0
6B75  74 57           je 0x6bce
6B77  80 7E FB 00     cmp byte ptr [bp - 5], 0
6B7B  75 18           jne 0x6b95
6B7D  A1 AE D0        mov ax, word ptr [0xd0ae]
6B80  03 06 B4 D0     add ax, word ptr [0xd0b4]
6B84  09 C0           or ax, ax
6B86  76 46           jbe 0x6bce
6B88  8A 46 FF        mov al, byte ptr [bp - 1]
6B8B  50              push ax
6B8C  9A B9 46 51 1B  call far 1B51:46B9
6B91  09 C0           or ax, ax
6B93  76 39           jbe 0x6bce
loc_6B95:
6B95  8A 46 FF        mov al, byte ptr [bp - 1]
6B98  50              push ax
6B99  9A B9 46 51 1B  call far 1B51:46B9
6B9E  09 C0           or ax, ax
6BA0  76 05           jbe 0x6ba7
6BA2  C6 06 BA D0 01  mov byte ptr [0xd0ba], 1
loc_6BA7:
6BA7  9A 2E 02 1A 23  call far 231A:022E
6BAC  8A 46 FB        mov al, byte ptr [bp - 5]
6BAF  50              push ax
6BB0  8A 46 FF        mov al, byte ptr [bp - 1]
6BB3  50              push ax
6BB4  E8 C3 FE        call 0x6a7a
6BB7  80 3E 8A DE 01  cmp byte ptr [0xde8a], 1
6BBC  75 06           jne 0x6bc4
6BBE  80 7E FB 00     cmp byte ptr [bp - 5], 0
6BC2  74 05           je 0x6bc9
loc_6BC4:
6BC4  6A 01           push 1
6BC6  E8 07 6A        call 0xd5d0
loc_6BC9:
6BC9  C6 06 BA D0 00  mov byte ptr [0xd0ba], 0
loc_6BCE:
6BCE  E9 F2 00        jmp 0x6cc3
loc_6BD1:
6BD1  8A 46 FF        mov al, byte ptr [bp - 1]
6BD4  50              push ax
6BD5  9A B9 46 51 1B  call far 1B51:46B9
6BDA  09 C0           or ax, ax
6BDC  77 03           ja 0x6be1
6BDE  E9 E2 00        jmp 0x6cc3
loc_6BE1:
6BE1  C7 46 FC 0B 00  mov word ptr [bp - 4], 0xb
6BE6  EB 03           jmp 0x6beb
loc_6BE8:
6BE8  FF 4E FC        dec word ptr [bp - 4]
loc_6BEB:
6BEB  8A 46 FF        mov al, byte ptr [bp - 1]
6BEE  98              cwde
6BEF  8B F8           mov di, ax
6BF1  8A 85 56 0D     mov al, byte ptr [di + 0xd56]
6BF5  30 E4           xor ah, ah
6BF7  03 46 FC        add ax, word ptr [bp - 4]
6BFA  6B F8 19        imul di, ax, 0x19
6BFD  81 C7 EF CC     add di, 0xccef
6C01  1E              push ds
6C02  07              pop es
6C03  89 7E F6        mov word ptr [bp - 0xa], di
6C06  8C 46 F8        mov word ptr [bp - 8], es
6C09  26 6B 45 0E 0F  imul ax, word ptr es:[di + 0xe], 0xf
6C0E  C4 3E BE D7     les di, ptr [0xd7be]
6C12  03 F8           add di, ax
6C14  89 7E F2        mov word ptr [bp - 0xe], di
6C17  8C 46 F4        mov word ptr [bp - 0xc], es
6C1A  6A 06           push 6
6C1C  26 8A 45 0B     mov al, byte ptr es:[di + 0xb]
6C20  30 E4           xor ah, ah
6C22  50              push ax
6C23  9A 59 02 AC 24  call far 24AC:0259
6C28  08 C0           or al, al
6C2A  74 03           je 0x6c2f
6C2C  E9 8B 00        jmp 0x6cba
loc_6C2F:
6C2F  C4 7E F2        les di, ptr [bp - 0xe]
6C32  26 80 7D 08 00  cmp byte ptr es:[di + 8], 0
6C37  7F 03           jg 0x6c3c
6C39  E9 7E 00        jmp 0x6cba
loc_6C3C:
6C3C  83 3E AE D0 01  cmp word ptr [0xd0ae], 1
6C41  76 77           jbe 0x6cba
6C43  83 7E FC 01     cmp word ptr [bp - 4], 1
6C47  76 71           jbe 0x6cba
6C49  83 3E AE D0 23  cmp word ptr [0xd0ae], 0x23
6C4E  73 6A           jae 0x6cba
6C50  B8 5A 00        mov ax, 0x5a
6C53  2B 06 AE D0     sub ax, word ptr [0xd0ae]
6C57  31 D2           xor dx, dx
6C59  8B C8           mov cx, ax
6C5B  8B DA           mov bx, dx
6C5D  8B 46 FC        mov ax, word ptr [bp - 4]
6C60  D1 E0           shl ax, 1
6C62  8B D0           mov dx, ax
6C64  8A 46 FF        mov al, byte ptr [bp - 1]
6C67  98              cwde
6C68  6B F8 28        imul di, ax, 0x28
6C6B  03 FA           add di, dx
6C6D  8B 85 46 D1     mov ax, word ptr [di - 0x2eba]
6C71  99              cdq
6C72  3B D3           cmp dx, bx
6C74  7C 06           jl 0x6c7c
6C76  7F 42           jg 0x6cba
6C78  3B C1           cmp ax, cx
6C7A  73 3E           jae 0x6cba
loc_6C7C:
6C7C  8A 46 FF        mov al, byte ptr [bp - 1]
6C7F  98              cwde
6C80  8B F8           mov di, ax
6C82  D1 E7           shl di, 1
6C84  6B 85 E4 D6 3E  imul ax, word ptr [di - 0x291c], 0x3e
6C89  C4 3E C2 D7     les di, ptr [0xd7c2]
6C8D  03 F8           add di, ax
6C8F  81 C7 C2 FF     add di, 0xffc2
6C93  06              push es
6C94  57              push di
6C95  C4 7E F6        les di, ptr [bp - 0xa]
6C98  26 8A 45 07     mov al, byte ptr es:[di + 7]
6C9C  30 E4           xor ah, ah
6C9E  50              push ax
6C9F  8A 46 FF        mov al, byte ptr [bp - 1]
6CA2  50              push ax
6CA3  6A 00           push 0
6CA5  E8 A3 3C        call 0xa94b
6CA8  8A 46 FF        mov al, byte ptr [bp - 1]
6CAB  98              cwde
6CAC  8B F8           mov di, ax
6CAE  80 BD E0 D6 00  cmp byte ptr [di - 0x2920], 0
6CB3  75 05           jne 0x6cba
6CB5  C7 46 FC 01 00  mov word ptr [bp - 4], 1
loc_6CBA:
6CBA  83 7E FC 01     cmp word ptr [bp - 4], 1
6CBE  74 03           je 0x6cc3
6CC0  E9 25 FF        jmp 0x6be8
loc_6CC3:
6CC3  80 7E FF 01     cmp byte ptr [bp - 1], 1
6CC7  74 03           je 0x6ccc
6CC9  E9 6D FE        jmp 0x6b39
loc_6CCC:
6CCC  C9              leave
6CCD  C3              ret

; ---- routine 0AB5:6CCE  (found by: call)
sub_6CCE:
6CCE  C8 06 00 00     enter 6, 0
6CD2  8A 46 04        mov al, byte ptr [bp + 4]
6CD5  A2 A0 D0        mov byte ptr [0xd0a0], al
6CD8  A0 A0 D0        mov al, byte ptr [0xd0a0]
6CDB  30 E4           xor ah, ah
6CDD  6B F8 19        imul di, ax, 0x19
6CE0  81 C7 EF CC     add di, 0xccef
6CE4  1E              push ds
6CE5  07              pop es
6CE6  26 FF 35        push word ptr es:[di]
6CE9  06              push es
6CEA  57              push di
6CEB  0E              push cs
6CEC  E8 06 B4        call 0x20f5
6CEF  08 C0           or al, al
6CF1  74 0C           je 0x6cff
6CF3  9A 3F 0D AC 24  call far 24AC:0D3F
6CF8  08 C0           or al, al
6CFA  74 03           je 0x6cff
6CFC  E9 80 00        jmp 0x6d7f
loc_6CFF:
6CFF  6A 37           push 0x37
6D01  E8 B3 B0        call 0x1db7
6D04  6A 35           push 0x35
6D06  E8 D9 B0        call 0x1de2
6D09  6A 01           push 1
6D0B  E8 27 FC        call 0x6935
6D0E  80 3E A0 D0 0C  cmp byte ptr [0xd0a0], 0xc
6D13  B0 00           mov al, 0
6D15  73 01           jae 0x6d18
6D17  40              inc ax
loc_6D18:
6D18  98              cwde
6D19  6B F8 0A        imul di, ax, 0xa
6D1C  FE 85 D8 D0     inc byte ptr [di - 0x2f28]
6D20  FF 36 46 CF     push word ptr [0xcf46]
6D24  A0 A0 D0        mov al, byte ptr [0xd0a0]
6D27  30 E4           xor ah, ah
6D29  6B F8 19        imul di, ax, 0x19
6D2C  81 C7 EF CC     add di, 0xccef
6D30  1E              push ds
6D31  57              push di
6D32  0E              push cs
6D33  E8 BF B3        call 0x20f5
6D36  88 46 FF        mov byte ptr [bp - 1], al
6D39  E8 7C FC        call 0x69b8
6D3C  80 7E FF 00     cmp byte ptr [bp - 1], 0
6D40  74 3A           je 0x6d7c
6D42  A0 A0 D0        mov al, byte ptr [0xd0a0]
6D45  30 E4           xor ah, ah
6D47  6B F8 19        imul di, ax, 0x19
6D4A  8B 85 FD CC     mov ax, word ptr [di - 0x3303]
6D4E  C1 E0 03        shl ax, 3
6D51  C4 3E BA D7     les di, ptr [0xd7ba]
6D55  03 F8           add di, ax
6D57  26 8A 05        mov al, byte ptr es:[di]
6D5A  30 E4           xor ah, ah
6D5C  50              push ax
6D5D  9A DA 0D 51 1B  call far 1B51:0DDA
6D62  08 C0           or al, al
6D64  75 11           jne 0x6d77
6D66  A0 A0 D0        mov al, byte ptr [0xd0a0]
6D69  30 E4           xor ah, ah
6D6B  6B F8 19        imul di, ax, 0x19
6D6E  FF B5 FD CC     push word ptr [di - 0x3303]
6D72  9A 26 53 51 1B  call far 1B51:5326
loc_6D77:
6D77  E8 DC EC        call 0x5a56
6D7A  EB 03           jmp 0x6d7f
loc_6D7C:
6D7C  E8 A2 ED        call 0x5b21
loc_6D7F:
6D7F  C9              leave
6D80  C2 02 00        ret 2

; ---- routine 0AB5:6D83  (found by: call)
sub_6D83:
6D83  C8 02 00 00     enter 2, 0
6D87  C6 46 FF 00     mov byte ptr [bp - 1], 0
6D8B  80 3E A1 D0 00  cmp byte ptr [0xd0a1], 0
6D90  74 29           je 0x6dbb
6D92  E8 41 AF        call 0x1cd6
6D95  50              push ax
6D96  A0 A1 D0        mov al, byte ptr [0xd0a1]
6D99  30 E4           xor ah, ah
6D9B  6B F8 19        imul di, ax, 0x19
6D9E  81 C7 EF CC     add di, 0xccef
6DA2  1E              push ds
6DA3  57              push di
6DA4  0E              push cs
6DA5  E8 13 AF        call 0x1cbb
6DA8  5A              pop dx
6DA9  3A C2           cmp al, dl
6DAB  74 0E           je 0x6dbb
6DAD  6A 42           push 0x42
6DAF  E8 62 B0        call 0x1e14
6DB2  C6 06 A1 D0 00  mov byte ptr [0xd0a1], 0
6DB7  C6 46 FF 01     mov byte ptr [bp - 1], 1
loc_6DBB:
6DBB  8A 46 FF        mov al, byte ptr [bp - 1]
6DBE  C9              leave
6DBF  C3              ret

; ---- routine 0AB5:6DC0  (found by: call)
sub_6DC0:
6DC0  55              push bp
6DC1  89 E5           mov bp, sp
6DC3  E8 BD FF        call 0x6d83
6DC6  08 C0           or al, al
6DC8  74 02           je 0x6dcc
6DCA  EB 5A           jmp 0x6e26
loc_6DCC:
6DCC  A0 A1 D0        mov al, byte ptr [0xd0a1]
6DCF  A2 A0 D0        mov byte ptr [0xd0a0], al
6DD2  6A 36           push 0x36
6DD4  E8 0B B0        call 0x1de2
6DD7  A0 A0 D0        mov al, byte ptr [0xd0a0]
6DDA  30 E4           xor ah, ah
6DDC  6B F8 19        imul di, ax, 0x19
6DDF  81 C7 EF CC     add di, 0xccef
6DE3  1E              push ds
6DE4  57              push di
6DE5  0E              push cs
6DE6  E8 E3 B0        call 0x1ecc
6DE9  08 C0           or al, al
6DEB  B0 00           mov al, 0
6DED  7D 01           jge 0x6df0
6DEF  40              inc ax
loc_6DF0:
6DF0  50              push ax
6DF1  E8 24 AC        call 0x1a18
6DF4  6A 00           push 0
6DF6  E8 3C FB        call 0x6935
6DF9  A1 AA D0        mov ax, word ptr [0xd0aa]
6DFC  A3 46 CF        mov word ptr [0xcf46], ax
6DFF  80 3E A0 D0 0C  cmp byte ptr [0xd0a0], 0xc
6E04  B0 00           mov al, 0
6E06  73 01           jae 0x6e09
6E08  40              inc ax
loc_6E09:
6E09  98              cwde
6E0A  8B F8           mov di, ax
6E0C  8A 85 38 A3     mov al, byte ptr [di - 0x5cc8]
6E10  98              cwde
6E11  6B C0 0B        imul ax, ax, 0xb
6E14  8B D0           mov dx, ax
6E16  A0 A0 D0        mov al, byte ptr [0xd0a0]
6E19  30 E4           xor ah, ah
6E1B  03 C2           add ax, dx
6E1D  A2 9F D0        mov byte ptr [0xd09f], al
6E20  E8 B4 B3        call 0x21d7
6E23  E8 FB EC        call 0x5b21
loc_6E26:
6E26  C9              leave
6E27  C3              ret

