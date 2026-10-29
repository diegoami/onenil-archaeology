; 1-0.EXE (One-Nil 96), code segment 0AB9 (image offsets 0AB90..1997F), part 9 of 22
; packed 1-0.EXE sha256 89ff9c5f238f24e81a0c2440a46cdd8997280a65fc3cc3d97cb974f55280a80a (LZEXE 0.91)
; unpacked (tools/static/unlzexe.py) sha256 887ed2a92767950e5309b2052409f875668605939b69e00737aa3047022b9f51
; tool: capstone 5.0.9 (pip package; core library 5.0.1280) (CS_ARCH_X86, CS_MODE_16), recursive descent from the entry point, far calls and near calls/jumps, then routine prologues (55 89 E5 / 55 8B EC / C8 iw 00) in what remains; tools/static/listing.py
; addresses are SEGMENT:OFFSET with SEGMENT the image paragraph before relocation; image offset = SEGMENT*16+OFFSET
; ---- routine 0AB9:5083  (found by: call)
sub_5083:
5083  C8 10 00 00     enter 0x10, 0
5087  6B 7E 06 19     imul di, word ptr [bp + 6], 0x19
508B  81 C7 EF CC     add di, 0xccef
508F  1E              push ds
5090  07              pop es
5091  89 7E F8        mov word ptr [bp - 8], di
5094  8C 46 FA        mov word ptr [bp - 6], es
5097  80 3E CA D1 00  cmp byte ptr [0xd1ca], 0
509C  74 07           je 0x50a5
509E  6A 27           push 0x27
50A0  E8 14 CD        call 0x1db7
50A3  EB 47           jmp 0x50ec
loc_50A5:
50A5  6A 26           push 0x26
50A7  E8 0D CD        call 0x1db7
50AA  80 3E DD D6 00  cmp byte ptr [0xd6dd], 0
50AF  74 3B           je 0x50ec
50B1  C4 7E F8        les di, ptr [bp - 8]
50B4  26 8B 45 0E     mov ax, word ptr es:[di + 0xe]
50B8  C1 E0 03        shl ax, 3
50BB  C4 3E BA D7     les di, ptr [0xd7ba]
50BF  03 F8           add di, ax
50C1  26 80 7D 07 00  cmp byte ptr es:[di + 7], 0
50C6  74 24           je 0x50ec
50C8  C4 7E F8        les di, ptr [bp - 8]
50CB  26 6B 45 0E 0F  imul ax, word ptr es:[di + 0xe], 0xf
50D0  C4 3E BE D7     les di, ptr [0xd7be]
50D4  03 F8           add di, ax
50D6  26 FF 45 02     inc word ptr es:[di + 2]
50DA  C4 7E F8        les di, ptr [bp - 8]
50DD  26 6B 45 0E 0F  imul ax, word ptr es:[di + 0xe], 0xf
50E2  C4 3E BE D7     les di, ptr [0xd7be]
50E6  03 F8           add di, ax
50E8  26 FE 45 05     inc byte ptr es:[di + 5]
loc_50EC:
50EC  80 3E CA D1 00  cmp byte ptr [0xd1ca], 0
50F1  74 0F           je 0x5102
50F3  6A FF           push -1
50F5  6A 01           push 1
50F7  C4 7E F8        les di, ptr [bp - 8]
50FA  06              push es
50FB  57              push di
50FC  0E              push cs
50FD  E8 D0 16        call 0x67d0
5100  EB 29           jmp 0x512b
loc_5102:
5102  C4 7E F8        les di, ptr [bp - 8]
5105  26 8B 45 0E     mov ax, word ptr es:[di + 0xe]
5109  C1 E0 03        shl ax, 3
510C  C4 3E BA D7     les di, ptr [0xd7ba]
5110  03 F8           add di, ax
5112  26 8A 45 06     mov al, byte ptr es:[di + 6]
5116  30 E4           xor ah, ah
5118  8B F8           mov di, ax
511A  8A 85 1A 0D     mov al, byte ptr [di + 0xd1a]
511E  98              cwde
511F  50              push ax
5120  6A 01           push 1
5122  C4 7E F8        les di, ptr [bp - 8]
5125  06              push es
5126  57              push di
5127  0E              push cs
5128  E8 A5 16        call 0x67d0
loc_512B:
512B  80 7E 08 00     cmp byte ptr [bp + 8], 0
512F  B0 00           mov al, 0
5131  75 01           jne 0x5134
5133  40              inc ax
loc_5134:
5134  98              cwde
5135  8B F8           mov di, ax
5137  D1 E7           shl di, 1
5139  6B 85 E4 D6 3E  imul ax, word ptr [di - 0x291c], 0x3e
513E  C4 3E C2 D7     les di, ptr [0xd7c2]
5142  03 F8           add di, ax
5144  26 8B 45 C2     mov ax, word ptr es:[di - 0x3e]
5148  89 46 FE        mov word ptr [bp - 2], ax
514B  8B 46 FE        mov ax, word ptr [bp - 2]
514E  C1 E0 03        shl ax, 3
5151  C4 3E BA D7     les di, ptr [0xd7ba]
5155  03 F8           add di, ax
5157  89 7E F4        mov word ptr [bp - 0xc], di
515A  8C 46 F6        mov word ptr [bp - 0xa], es
515D  6B 46 FE 0F     imul ax, word ptr [bp - 2], 0xf
5161  C4 3E BE D7     les di, ptr [0xd7be]
5165  03 F8           add di, ax
5167  89 7E F0        mov word ptr [bp - 0x10], di
516A  8C 46 F2        mov word ptr [bp - 0xe], es
516D  80 3E DD D6 00  cmp byte ptr [0xd6dd], 0
5172  74 15           je 0x5189
5174  C4 7E F4        les di, ptr [bp - 0xc]
5177  26 80 7D 07 00  cmp byte ptr es:[di + 7], 0
517C  75 0B           jne 0x5189
517E  C4 7E F0        les di, ptr [bp - 0x10]
5181  26 FE 45 05     inc byte ptr es:[di + 5]
5185  26 FF 45 02     inc word ptr es:[di + 2]
loc_5189:
5189  6A FF           push -1
518B  9A 3F 0D BC 24  call far 24BC:0D3F
5190  50              push ax
5191  80 7E 08 00     cmp byte ptr [bp + 8], 0
5195  B0 00           mov al, 0
5197  75 01           jne 0x519a
5199  40              inc ax
loc_519A:
519A  98              cwde
519B  8B F8           mov di, ax
519D  8A 85 56 0D     mov al, byte ptr [di + 0xd56]
51A1  30 E4           xor ah, ah
51A3  40              inc ax
51A4  6B F8 19        imul di, ax, 0x19
51A7  81 C7 EF CC     add di, 0xccef
51AB  1E              push ds
51AC  57              push di
51AD  0E              push cs
51AE  E8 1F 16        call 0x67d0
51B1  8A 46 08        mov al, byte ptr [bp + 8]
51B4  88 46 FD        mov byte ptr [bp - 3], al
51B7  80 3E CA D1 00  cmp byte ptr [0xd1ca], 0
51BC  74 0C           je 0x51ca
51BE  80 7E 08 00     cmp byte ptr [bp + 8], 0
51C2  B0 00           mov al, 0
51C4  75 01           jne 0x51c7
51C6  40              inc ax
loc_51C7:
51C7  88 46 08        mov byte ptr [bp + 8], al
loc_51CA:
51CA  8A 46 08        mov al, byte ptr [bp + 8]
51CD  98              cwde
51CE  8B F8           mov di, ax
51D0  80 BD 28 D1 0B  cmp byte ptr [di - 0x2ed8], 0xb
51D5  73 0A           jae 0x51e1
51D7  8A 46 08        mov al, byte ptr [bp + 8]
51DA  98              cwde
51DB  8B F8           mov di, ax
51DD  FE 85 28 D1     inc byte ptr [di - 0x2ed8]
loc_51E1:
51E1  8A 46 08        mov al, byte ptr [bp + 8]
51E4  98              cwde
51E5  8B F8           mov di, ax
51E7  8A 85 28 D1     mov al, byte ptr [di - 0x2ed8]
51EB  30 E4           xor ah, ah
51ED  8B F0           mov si, ax
51EF  D1 E0           shl ax, 1
51F1  01 F0           add ax, si
51F3  8B D0           mov dx, ax
51F5  8A 46 08        mov al, byte ptr [bp + 8]
51F8  98              cwde
51F9  6B F8 21        imul di, ax, 0x21
51FC  03 FA           add di, dx
51FE  81 C7 E3 D0     add di, 0xd0e3
5202  1E              push ds
5203  07              pop es
5204  89 7E F4        mov word ptr [bp - 0xc], di
5207  8C 46 F6        mov word ptr [bp - 0xa], es
520A  C4 7E F8        les di, ptr [bp - 8]
520D  06              push es
520E  57              push di
520F  0E              push cs
5210  E8 8C CC        call 0x1e9f
5213  30 E4           xor ah, ah
5215  D1 E0           shl ax, 1
5217  8B D0           mov dx, ax
5219  8A 46 FD        mov al, byte ptr [bp - 3]
521C  98              cwde
521D  8B F8           mov di, ax
521F  D1 E7           shl di, 1
5221  6B 85 E4 D6 3E  imul ax, word ptr [di - 0x291c], 0x3e
5226  C4 3E C2 D7     les di, ptr [0xd7c2]
522A  03 F8           add di, ax
522C  03 FA           add di, dx
522E  26 8B 45 C0     mov ax, word ptr es:[di - 0x40]
5232  C4 7E F4        les di, ptr [bp - 0xc]
5235  26 89 05        mov word ptr es:[di], ax
5238  8A 46 04        mov al, byte ptr [bp + 4]
523B  26 88 45 02     mov byte ptr es:[di + 2], al
523F  80 3E B7 D0 00  cmp byte ptr [0xd0b7], 0
5244  75 07           jne 0x524d
5246  80 3E CA D1 00  cmp byte ptr [0xd1ca], 0
524B  74 08           je 0x5255
loc_524D:
524D  C4 7E F4        les di, ptr [bp - 0xc]
5250  26 80 45 02 80  add byte ptr es:[di + 2], 0x80
loc_5255:
5255  80 3E CA D1 00  cmp byte ptr [0xd1ca], 0
525A  75 07           jne 0x5263
525C  8A 46 08        mov al, byte ptr [bp + 8]
525F  50              push ax
5260  E8 51 DA        call 0x2cb4
loc_5263:
5263  C9              leave
5264  C2 06 00        ret 6

; ---- routine 0AB9:5267  (found by: call)
sub_5267:
5267  C8 06 00 00     enter 6, 0
526B  C7 46 FE 01 00  mov word ptr [bp - 2], 1
5270  EB 03           jmp 0x5275
loc_5272:
5272  FF 46 FE        inc word ptr [bp - 2]
loc_5275:
5275  6B 7E FE 19     imul di, word ptr [bp - 2], 0x19
5279  81 C7 EF CC     add di, 0xccef
527D  1E              push ds
527E  07              pop es
527F  89 7E FA        mov word ptr [bp - 6], di
5282  8C 46 FC        mov word ptr [bp - 4], es
5285  06              push es
5286  57              push di
5287  0E              push cs
5288  E8 C3 CB        call 0x1e4e
528B  08 C0           or al, al
528D  74 14           je 0x52a3
528F  FF 76 FE        push word ptr [bp - 2]
5292  E8 6B AD        call 0
5295  08 C0           or al, al
5297  75 0A           jne 0x52a3
5299  C4 7E FA        les di, ptr [bp - 6]
529C  26 C6 45 13 06  mov byte ptr es:[di + 0x13], 6
52A1  EB 08           jmp 0x52ab
loc_52A3:
52A3  C4 7E FA        les di, ptr [bp - 6]
52A6  26 C6 45 13 00  mov byte ptr es:[di + 0x13], 0
loc_52AB:
52AB  83 7E FE 16     cmp word ptr [bp - 2], 0x16
52AF  75 C1           jne 0x5272
52B1  E8 E1 FC        call 0x4f95
52B4  C9              leave
52B5  C3              ret

; ---- routine 0AB9:52B6  (found by: call)
sub_52B6:
52B6  C8 08 00 00     enter 8, 0
52BA  C6 06 B8 D0 01  mov byte ptr [0xd0b8], 1
52BF  6A 04           push 4
52C1  9A E0 01 98 19  call far 1998:01E0
52C6  C7 46 FE 01 00  mov word ptr [bp - 2], 1
52CB  EB 03           jmp 0x52d0
loc_52CD:
52CD  FF 46 FE        inc word ptr [bp - 2]
loc_52D0:
52D0  6B 7E FE 19     imul di, word ptr [bp - 2], 0x19
52D4  8B 85 EF CC     mov ax, word ptr [di - 0x3311]
52D8  6B 7E FE 19     imul di, word ptr [bp - 2], 0x19
52DC  89 85 F7 CC     mov word ptr [di - 0x3309], ax
52E0  83 7E FE 16     cmp word ptr [bp - 2], 0x16
52E4  75 E7           jne 0x52cd
52E6  A0 CA D1        mov al, byte ptr [0xd1ca]
52E9  88 46 FD        mov byte ptr [bp - 3], al
52EC  80 3E B9 D0 00  cmp byte ptr [0xd0b9], 0
52F1  74 03           je 0x52f6
52F3  E9 84 00        jmp 0x537a
loc_52F6:
52F6  E8 6E FF        call 0x5267
52F9  80 7E FD 00     cmp byte ptr [bp - 3], 0
52FD  B0 00           mov al, 0
52FF  75 01           jne 0x5302
5301  40              inc ax
loc_5302:
5302  50              push ax
5303  E8 EC 51        call 0xa4f2
5306  C7 46 FE 01 00  mov word ptr [bp - 2], 1
530B  EB 03           jmp 0x5310
loc_530D:
530D  FF 46 FE        inc word ptr [bp - 2]
loc_5310:
5310  6B 7E FE 19     imul di, word ptr [bp - 2], 0x19
5314  81 C7 EF CC     add di, 0xccef
5318  1E              push ds
5319  07              pop es
531A  89 7E F8        mov word ptr [bp - 8], di
531D  8C 46 FA        mov word ptr [bp - 6], es
5320  06              push es
5321  57              push di
5322  0E              push cs
5323  E8 7B C9        call 0x1ca1
5326  08 C0           or al, al
5328  75 4A           jne 0x5374
532A  80 3E CA D1 00  cmp byte ptr [0xd1ca], 0
532F  75 1F           jne 0x5350
5331  C4 7E F8        les di, ptr [bp - 8]
5334  06              push es
5335  57              push di
5336  0E              push cs
5337  E8 14 CB        call 0x1e4e
533A  98              cwde
533B  8B F8           mov di, ax
533D  8A 85 38 A3     mov al, byte ptr [di - 0x5cc8]
5341  98              cwde
5342  50              push ax
5343  6A 00           push 0
5345  C4 7E F8        les di, ptr [bp - 8]
5348  06              push es
5349  57              push di
534A  0E              push cs
534B  E8 82 14        call 0x67d0
534E  EB 24           jmp 0x5374
loc_5350:
5350  C4 7E F8        les di, ptr [bp - 8]
5353  06              push es
5354  57              push di
5355  0E              push cs
5356  E8 F5 CA        call 0x1e4e
5359  08 C0           or al, al
535B  B0 00           mov al, 0
535D  75 01           jne 0x5360
535F  40              inc ax
loc_5360:
5360  98              cwde
5361  8B F8           mov di, ax
5363  8A 85 38 A3     mov al, byte ptr [di - 0x5cc8]
5367  98              cwde
5368  50              push ax
5369  6A 00           push 0
536B  C4 7E F8        les di, ptr [bp - 8]
536E  06              push es
536F  57              push di
5370  0E              push cs
5371  E8 5C 14        call 0x67d0
loc_5374:
5374  83 7E FE 16     cmp word ptr [bp - 2], 0x16
5378  75 93           jne 0x530d
loc_537A:
537A  C9              leave
537B  C3              ret

; ---- routine 0AB9:537C  (found by: call)
sub_537C:
537C  55              push bp
537D  89 E5           mov bp, sp
537F  80 3E 47 CF 00  cmp byte ptr [0xcf47], 0
5384  B0 00           mov al, 0
5386  7E 01           jle 0x5389
5388  40              inc ax
loc_5389:
5389  98              cwde
538A  8B F8           mov di, ax
538C  8A 85 38 A3     mov al, byte ptr [di - 0x5cc8]
5390  98              cwde
5391  6B C0 27        imul ax, ax, 0x27
5394  A2 47 CF        mov byte ptr [0xcf47], al
5397  80 3E 46 CF 00  cmp byte ptr [0xcf46], 0
539C  75 07           jne 0x53a5
539E  6A 28           push 0x28
53A0  E8 14 CA        call 0x1db7
53A3  EB 05           jmp 0x53aa
loc_53A5:
53A5  6A 29           push 0x29
53A7  E8 0D CA        call 0x1db7
loc_53AA:
53AA  C7 06 BE D0 14 00 mov word ptr [0xd0be], 0x14
53B0  80 3E A1 D0 00  cmp byte ptr [0xd0a1], 0
53B5  74 07           je 0x53be
53B7  E8 C9 19        call 0x6d83
53BA  08 C0           or al, al
53BC  74 12           je 0x53d0
loc_53BE:
53BE  E8 15 C9        call 0x1cd6
53C1  08 C0           or al, al
53C3  B0 00           mov al, 0
53C5  75 01           jne 0x53c8
53C7  40              inc ax
loc_53C8:
53C8  50              push ax
53C9  6A 00           push 0
53CB  E8 B3 06        call 0x5a81
53CE  EB 03           jmp 0x53d3
loc_53D0:
53D0  E8 ED 19        call 0x6dc0
loc_53D3:
53D3  C9              leave
53D4  C2 02 00        ret 2

; ---- routine 0AB9:53D7  (found by: call)
sub_53D7:
53D7  C8 08 00 00     enter 8, 0
53DB  BF 47 CF        mov di, 0xcf47
53DE  1E              push ds
53DF  57              push di
53E0  6A DA           push -0x26
53E2  6A 26           push 0x26
53E4  9A 02 04 BC 24  call far 24BC:0402
53E9  BF 46 CF        mov di, 0xcf46
53EC  1E              push ds
53ED  57              push di
53EE  6A FF           push -1
53F0  6A 01           push 1
53F2  9A 02 04 BC 24  call far 24BC:0402
53F7  80 3E CA D1 00  cmp byte ptr [0xd1ca], 0
53FC  74 0F           je 0x540d
53FE  E8 D5 C8        call 0x1cd6
5401  08 C0           or al, al
5403  B0 00           mov al, 0
5405  75 01           jne 0x5408
5407  40              inc ax
loc_5408:
5408  88 46 FC        mov byte ptr [bp - 4], al
540B  EB 06           jmp 0x5413
loc_540D:
540D  E8 C6 C8        call 0x1cd6
5410  88 46 FC        mov byte ptr [bp - 4], al
loc_5413:
5413  80 3E CA D1 00  cmp byte ptr [0xd1ca], 0
5418  74 06           je 0x5420
541A  C6 46 FD 27     mov byte ptr [bp - 3], 0x27
541E  EB 04           jmp 0x5424
loc_5420:
5420  C6 46 FD 26     mov byte ptr [bp - 3], 0x26
loc_5424:
5424  8A 46 FC        mov al, byte ptr [bp - 4]
5427  98              cwde
5428  8B F8           mov di, ax
542A  FE 85 C4 D0     inc byte ptr [di - 0x2f3c]
542E  BF 58 DD        mov di, 0xdd58
5431  1E              push ds
5432  57              push di
5433  9A DF 02 98 19  call far 1998:02DF
5438  80 7E FC 00     cmp byte ptr [bp - 4], 0
543C  B0 00           mov al, 0
543E  75 01           jne 0x5441
5440  40              inc ax
loc_5441:
5441  98              cwde
5442  8B F8           mov di, ax
5444  8A 85 56 0D     mov al, byte ptr [di + 0xd56]
5448  30 E4           xor ah, ah
544A  40              inc ax
544B  6B F8 19        imul di, ax, 0x19
544E  81 C7 EF CC     add di, 0xccef
5452  1E              push ds
5453  07              pop es
5454  89 7E F8        mov word ptr [bp - 8], di
5457  8C 46 FA        mov word ptr [bp - 6], es
545A  9A 3F 0D BC 24  call far 24BC:0D3F
545F  08 C0           or al, al
5461  74 0D           je 0x5470
5463  6A 24           push 0x24
5465  C4 7E F8        les di, ptr [bp - 8]
5468  06              push es
5469  57              push di
546A  0E              push cs
546B  E8 BA C9        call 0x1e28
546E  EB 0B           jmp 0x547b
loc_5470:
5470  6A 25           push 0x25
5472  C4 7E F8        les di, ptr [bp - 8]
5475  06              push es
5476  57              push di
5477  0E              push cs
5478  E8 AD C9        call 0x1e28
loc_547B:
547B  80 3E B9 D0 00  cmp byte ptr [0xd0b9], 0
5480  74 09           je 0x548b
5482  8A 46 FD        mov al, byte ptr [bp - 3]
5485  50              push ax
5486  E8 2E C9        call 0x1db7
5489  EB 50           jmp 0x54db
loc_548B:
548B  80 3E A1 D0 00  cmp byte ptr [0xd0a1], 0
5490  74 07           je 0x5499
5492  E8 EE 18        call 0x6d83
5495  08 C0           or al, al
5497  74 22           je 0x54bb
loc_5499:
5499  A0 9F D0        mov al, byte ptr [0xd09f]
549C  30 E4           xor ah, ah
549E  6B F8 19        imul di, ax, 0x19
54A1  81 C7 EF CC     add di, 0xccef
54A5  1E              push ds
54A6  57              push di
54A7  0E              push cs
54A8  E8 10 C8        call 0x1cbb
54AB  50              push ax
54AC  A0 9F D0        mov al, byte ptr [0xd09f]
54AF  30 E4           xor ah, ah
54B1  50              push ax
54B2  FF 36 B2 D0     push word ptr [0xd0b2]
54B6  E8 CA FB        call 0x5083
54B9  EB 20           jmp 0x54db
loc_54BB:
54BB  8A 46 FD        mov al, byte ptr [bp - 3]
54BE  50              push ax
54BF  E8 F5 C8        call 0x1db7
54C2  8A 46 FC        mov al, byte ptr [bp - 4]
54C5  98              cwde
54C6  8B F8           mov di, ax
54C8  FE 8D C4 D0     dec byte ptr [di - 0x2f3c]
54CC  E8 F1 18        call 0x6dc0
54CF  BF 58 DD        mov di, 0xdd58
54D2  1E              push ds
54D3  57              push di
54D4  9A DF 02 98 19  call far 1998:02DF
54D9  EB 03           jmp 0x54de
loc_54DB:
54DB  E8 D8 FD        call 0x52b6
loc_54DE:
54DE  C9              leave
54DF  C2 02 00        ret 2

; ---- routine 0AB9:54E2  (found by: call)
sub_54E2:
54E2  C8 08 00 00     enter 8, 0
54E6  80 3E BB D0 04  cmp byte ptr [0xd0bb], 4
54EB  77 18           ja 0x5505
54ED  E8 E6 C7        call 0x1cd6
54F0  98              cwde
54F1  8B F8           mov di, ax
54F3  80 BD C4 D0 0F  cmp byte ptr [di - 0x2f3c], 0xf
54F8  75 07           jne 0x5501
54FA  80 3E B9 D0 00  cmp byte ptr [0xd0b9], 0
54FF  74 04           je 0x5505
loc_5501:
5501  B0 00           mov al, 0
5503  EB 02           jmp 0x5507
loc_5505:
5505  B0 01           mov al, 1
loc_5507:
5507  88 46 FB        mov byte ptr [bp - 5], al
550A  80 7E FB 00     cmp byte ptr [bp - 5], 0
550E  75 71           jne 0x5581
5510  FF 36 E6 D6     push word ptr [0xd6e6]
5514  C4 3E D2 D7     les di, ptr [0xd7d2]
5518  26 8A 05        mov al, byte ptr es:[di]
551B  30 E4           xor ah, ah
551D  50              push ax
551E  9A 73 02 98 19  call far 1998:0273
5523  08 C0           or al, al
5525  74 5A           je 0x5581
5527  E8 AC C7        call 0x1cd6
552A  98              cwde
552B  8B F8           mov di, ax
552D  D1 E7           shl di, 1
552F  FF B5 E4 D6     push word ptr [di - 0x291c]
5533  C4 3E D2 D7     les di, ptr [0xd7d2]
5537  26 8A 05        mov al, byte ptr es:[di]
553A  30 E4           xor ah, ah
553C  50              push ax
553D  9A 2B 02 98 19  call far 1998:022B
5542  50              push ax
5543  C4 3E D2 D7     les di, ptr [0xd7d2]
5547  26 8A 05        mov al, byte ptr es:[di]
554A  30 E4           xor ah, ah
554C  50              push ax
554D  8D 7E F8        lea di, [bp - 8]
5550  16              push ss
5551  57              push di
5552  9A F9 17 55 1B  call far 1B55:17F9
5557  E8 7C C7        call 0x1cd6
555A  98              cwde
555B  8B F8           mov di, ax
555D  8A 85 C4 D0     mov al, byte ptr [di - 0x2f3c]
5561  30 E4           xor ah, ah
5563  8B D0           mov dx, ax
5565  8A 46 F8        mov al, byte ptr [bp - 8]
5568  30 E4           xor ah, ah
556A  03 C2           add ax, dx
556C  3D 0F 00        cmp ax, 0xf
556F  75 07           jne 0x5578
5571  80 3E B9 D0 00  cmp byte ptr [0xd0b9], 0
5576  74 04           je 0x557c
loc_5578:
5578  B0 00           mov al, 0
557A  EB 02           jmp 0x557e
loc_557C:
557C  B0 01           mov al, 1
loc_557E:
557E  88 46 FB        mov byte ptr [bp - 5], al
loc_5581:
5581  80 7E FB 00     cmp byte ptr [bp - 5], 0
5585  74 06           je 0x558d
5587  55              push bp
5588  E8 F1 FD        call 0x537c
558B  EB 56           jmp 0x55e3
loc_558D:
558D  80 3E CA D1 00  cmp byte ptr [0xd1ca], 0
5592  75 45           jne 0x55d9
5594  80 3E C9 D1 00  cmp byte ptr [0xd1c9], 0
5599  75 3E           jne 0x55d9
559B  A0 BB D0        mov al, byte ptr [0xd0bb]
559E  3C 03           cmp al, 3
55A0  72 3D           jb 0x55df
55A2  3C 04           cmp al, 4
55A4  77 39           ja 0x55df
55A6  6A 20           push 0x20
55A8  9A 6D 07 2A 23  call far 232A:076D
55AD  50              push ax
55AE  A0 BB D0        mov al, byte ptr [0xd0bb]
55B1  30 E4           xor ah, ah
55B3  8B F8           mov di, ax
55B5  8A 85 A4 0A     mov al, byte ptr [di + 0xaa4]
55B9  30 E4           xor ah, ah
55BB  50              push ax
55BC  A0 9F D0        mov al, byte ptr [0xd09f]
55BF  30 E4           xor ah, ah
55C1  6B F8 19        imul di, ax, 0x19
55C4  81 C7 EF CC     add di, 0xccef
55C8  1E              push ds
55C9  57              push di
55CA  0E              push cs
55CB  E8 14 C5        call 0x1ae2
55CE  50              push ax
55CF  9A 6D 07 2A 23  call far 232A:076D
55D4  5A              pop dx
55D5  3B C2           cmp ax, dx
55D7  7E 06           jle 0x55df
loc_55D9:
55D9  55              push bp
55DA  E8 FA FD        call 0x53d7
55DD  EB 04           jmp 0x55e3
loc_55DF:
55DF  55              push bp
55E0  E8 99 FD        call 0x537c
loc_55E3:
55E3  C6 06 B7 D0 00  mov byte ptr [0xd0b7], 0
55E8  C6 06 C9 D1 00  mov byte ptr [0xd1c9], 0
55ED  C9              leave
55EE  C3              ret

; ---- routine 0AB9:55EF  (found by: call)
sub_55EF:
55EF  55              push bp
55F0  89 E5           mov bp, sp
55F2  A0 9F D0        mov al, byte ptr [0xd09f]
55F5  30 E4           xor ah, ah
55F7  50              push ax
55F8  E8 05 AA        call 0
55FB  08 C0           or al, al
55FD  75 0B           jne 0x560a
55FF  6A 03           push 3
5601  9A 1C 0D BC 24  call far 24BC:0D1C
5606  08 C0           or al, al
5608  75 05           jne 0x560f
loc_560A:
560A  E8 F9 03        call 0x5a06
560D  EB 0D           jmp 0x561c
loc_560F:
560F  C6 06 BB D0 00  mov byte ptr [0xd0bb], 0
5614  C6 06 CA D1 01  mov byte ptr [0xd1ca], 1
5619  E8 C6 FE        call 0x54e2
loc_561C:
561C  C9              leave
561D  C3              ret

; ---- routine 0AB9:561E  (found by: call)
sub_561E:
561E  55              push bp
561F  89 E5           mov bp, sp
5621  C4 7E 06        les di, ptr [bp + 6]
5624  26 8B 45 0A     mov ax, word ptr es:[di + 0xa]
5628  26 89 45 08     mov word ptr es:[di + 8], ax
562C  26 8B 45 0E     mov ax, word ptr es:[di + 0xe]
5630  C1 E0 03        shl ax, 3
5633  C4 3E BA D7     les di, ptr [0xd7ba]
5637  03 F8           add di, ax
5639  26 8A 45 06     mov al, byte ptr es:[di + 6]
563D  30 E4           xor ah, ah
563F  8B F8           mov di, ax
5641  8A 85 AA 0A     mov al, byte ptr [di + 0xaaa]
5645  C4 7E 06        les di, ptr [bp + 6]
5648  26 88 45 0D     mov byte ptr es:[di + 0xd], al
564C  26 8A 45 0D     mov al, byte ptr es:[di + 0xd]
5650  26 00 45 09     add byte ptr es:[di + 9], al
5654  26 FF 75 08     push word ptr es:[di + 8]
5658  06              push es
5659  57              push di
565A  0E              push cs
565B  E8 00 C9        call 0x1f5e
565E  C4 7E 06        les di, ptr [bp + 6]
5661  26 89 45 08     mov word ptr es:[di + 8], ax
5665  E8 6E C6        call 0x1cd6
5668  98              cwde
5669  8B F8           mov di, ax
566B  8A 85 56 0D     mov al, byte ptr [di + 0xd56]
566F  30 E4           xor ah, ah
5671  05 0B 00        add ax, 0xb
5674  8B D0           mov dx, ax
5676  C4 7E 06        les di, ptr [bp + 6]
5679  26 8A 45 07     mov al, byte ptr es:[di + 7]
567D  30 E4           xor ah, ah
567F  3B C2           cmp ax, dx
5681  75 11           jne 0x5694
5683  FF 36 BA 0A     push word ptr [0xaba]
5687  06              push es
5688  57              push di
5689  0E              push cs
568A  E8 D1 C8        call 0x1f5e
568D  C4 7E 06        les di, ptr [bp + 6]
5690  26 89 45 08     mov word ptr es:[di + 8], ax
loc_5694:
5694  A0 9F D0        mov al, byte ptr [0xd09f]
5697  C4 7E 06        les di, ptr [bp + 6]
569A  26 3A 45 07     cmp al, byte ptr es:[di + 7]
569E  75 11           jne 0x56b1
56A0  FF 36 B8 0A     push word ptr [0xab8]
56A4  06              push es
56A5  57              push di
56A6  0E              push cs
56A7  E8 B4 C8        call 0x1f5e
56AA  C4 7E 06        les di, ptr [bp + 6]
56AD  26 89 45 08     mov word ptr es:[di + 8], ax
loc_56B1:
56B1  80 3E B9 D0 00  cmp byte ptr [0xd0b9], 0
56B6  75 32           jne 0x56ea
56B8  C4 7E 06        les di, ptr [bp + 6]
56BB  06              push es
56BC  57              push di
56BD  0E              push cs
56BE  E8 D8 C8        call 0x1f99
56C1  08 C0           or al, al
56C3  74 25           je 0x56ea
56C5  A0 9F D0        mov al, byte ptr [0xd09f]
56C8  C4 7E 06        les di, ptr [bp + 6]
56CB  26 3A 45 07     cmp al, byte ptr es:[di + 7]
56CF  75 11           jne 0x56e2
56D1  26 C6 45 13 02  mov byte ptr es:[di + 0x13], 2
56D6  C6 06 53 CF 00  mov byte ptr [0xcf53], 0
56DB  6A 31           push 0x31
56DD  E8 D7 C6        call 0x1db7
56E0  EB 08           jmp 0x56ea
loc_56E2:
56E2  C4 7E 06        les di, ptr [bp + 6]
56E5  26 C6 45 13 00  mov byte ptr es:[di + 0x13], 0
loc_56EA:
56EA  C9              leave
56EB  CA 04 00        retf 4

; ---- routine 0AB9:56EE  (found by: call)
sub_56EE:
56EE  55              push bp
56EF  89 E5           mov bp, sp
56F1  6A 00           push 0
56F3  E8 28 C5        call 0x1c1e
56F6  08 C0           or al, al
56F8  74 2A           je 0x5724
56FA  C6 06 A0 D0 00  mov byte ptr [0xd0a0], 0
56FF  FF 36 BC 0A     push word ptr [0xabc]
5703  C4 7E 06        les di, ptr [bp + 6]
5706  06              push es
5707  57              push di
5708  0E              push cs
5709  E8 52 C8        call 0x1f5e
570C  50              push ax
570D  6A 06           push 6
570F  C4 7E 06        les di, ptr [bp + 6]
5712  06              push es
5713  57              push di
5714  0E              push cs
5715  E8 0D CF        call 0x2625
5718  6A 05           push 5
571A  E8 61 C5        call 0x1c7e
571D  6A 02           push 2
571F  9A E0 01 98 19  call far 1998:01E0
loc_5724:
5724  C9              leave
5725  CA 04 00        retf 4

; ---- routine 0AB9:5728  (found by: call)
sub_5728:
5728  55              push bp
5729  89 E5           mov bp, sp
572B  C4 7E 06        les di, ptr [bp + 6]
572E  26 8B 05        mov ax, word ptr es:[di]
5731  3B 06 32 0D     cmp ax, word ptr [0xd32]
5735  74 12           je 0x5749
5737  26 8B 05        mov ax, word ptr es:[di]
573A  3B 06 2E 0D     cmp ax, word ptr [0xd2e]
573E  74 09           je 0x5749
5740  A1 30 0D        mov ax, word ptr [0xd30]
5743  26 89 45 08     mov word ptr es:[di + 8], ax
5747  EB 0A           jmp 0x5753
loc_5749:
5749  C4 7E 06        les di, ptr [bp + 6]
574C  26 8B 05        mov ax, word ptr es:[di]
574F  26 89 45 08     mov word ptr es:[di + 8], ax
loc_5753:
5753  C4 7E 06        les di, ptr [bp + 6]
5756  06              push es
5757  57              push di
5758  0E              push cs
5759  E8 3D C8        call 0x1f99
575C  08 C0           or al, al
575E  74 1B           je 0x577b
5760  C4 7E 06        les di, ptr [bp + 6]
5763  26 C6 45 13 04  mov byte ptr es:[di + 0x13], 4
5768  A1 32 0D        mov ax, word ptr [0xd32]
576B  26 89 05        mov word ptr es:[di], ax
576E  26 8B 05        mov ax, word ptr es:[di]
5771  26 89 45 08     mov word ptr es:[di + 8], ax
5775  06              push es
5776  57              push di
5777  0E              push cs
5778  E8 AD 16        call 0x6e28
loc_577B:
577B  C9              leave
577C  CA 04 00        retf 4

; ---- routine 0AB9:577F  (found by: call)
sub_577F:
577F  C8 08 00 00     enter 8, 0
5783  8A 46 06        mov al, byte ptr [bp + 6]
5786  98              cwde
5787  8B F8           mov di, ax
5789  D1 E7           shl di, 1
578B  6B 85 E4 D6 3E  imul ax, word ptr [di - 0x291c], 0x3e
5790  C4 3E C2 D7     les di, ptr [0xd7c2]
5794  03 F8           add di, ax
5796  81 C7 C2 FF     add di, 0xffc2
579A  89 7E F8        mov word ptr [bp - 8], di
579D  8C 46 FA        mov word ptr [bp - 6], es
57A0  C7 46 FC 01 00  mov word ptr [bp - 4], 1
loc_57A5:
57A5  83 7E FC 0C     cmp word ptr [bp - 4], 0xc
57A9  73 2B           jae 0x57d6
57AB  8B 46 04        mov ax, word ptr [bp + 4]
57AE  D1 E0           shl ax, 1
57B0  8B D0           mov dx, ax
57B2  8A 46 06        mov al, byte ptr [bp + 6]
57B5  98              cwde
57B6  6B F8 0A        imul di, ax, 0xa
57B9  03 FA           add di, dx
57BB  8B 95 5C CF     mov dx, word ptr [di - 0x30a4]
57BF  8B 46 FC        mov ax, word ptr [bp - 4]
57C2  D1 E0           shl ax, 1
57C4  C4 7E F8        les di, ptr [bp - 8]
57C7  03 F8           add di, ax
57C9  26 8B 45 FE     mov ax, word ptr es:[di - 2]
57CD  3B C2           cmp ax, dx
57CF  74 05           je 0x57d6
57D1  FF 46 FC        inc word ptr [bp - 4]
57D4  EB CF           jmp 0x57a5
loc_57D6:
57D6  8B 46 FC        mov ax, word ptr [bp - 4]
57D9  89 46 FE        mov word ptr [bp - 2], ax
57DC  8B 46 FE        mov ax, word ptr [bp - 2]
57DF  C9              leave
57E0  C2 04 00        ret 4

; ---- routine 0AB9:57E3  (found by: call)
sub_57E3:
57E3  C8 04 00 00     enter 4, 0
57E7  8A 46 06        mov al, byte ptr [bp + 6]
57EA  A2 9F D0        mov byte ptr [0xd09f], al
57ED  E8 4A C5        call 0x1d3a
57F0  C6 06 A0 D0 00  mov byte ptr [0xd0a0], 0
57F5  C6 06 53 CF 01  mov byte ptr [0xcf53], 1
57FA  31 C0           xor ax, ax
57FC  A3 51 CF        mov word ptr [0xcf51], ax
57FF  8A 46 04        mov al, byte ptr [bp + 4]
5802  50              push ax
5803  E8 78 C4        call 0x1c7e
5806  A0 9F D0        mov al, byte ptr [0xd09f]
5809  30 E4           xor ah, ah
580B  6B F8 19        imul di, ax, 0x19
580E  81 C7 EF CC     add di, 0xccef
5812  1E              push ds
5813  07              pop es
5814  89 7E FC        mov word ptr [bp - 4], di
5817  8C 46 FE        mov word ptr [bp - 2], es
581A  8A 46 04        mov al, byte ptr [bp + 4]
581D  3C 0A           cmp al, 0xa
581F  75 15           jne 0x5836
5821  C6 06 A8 D0 00  mov byte ptr [0xd0a8], 0
5826  06              push es
5827  57              push di
5828  0E              push cs
5829  E8 A0 C6        call 0x1ecc
582C  98              cwde
582D  6B C0 1C        imul ax, ax, 0x1c
5830  A2 A9 D0        mov byte ptr [0xd0a9], al
5833  E9 9C 00        jmp 0x58d2
loc_5836:
5836  3C 09           cmp al, 9
5838  75 32           jne 0x586c
583A  80 3E 46 CF 00  cmp byte ptr [0xcf46], 0
583F  B0 00           mov al, 0
5841  7E 01           jle 0x5844
5843  40              inc ax
loc_5844:
5844  98              cwde
5845  8B F8           mov di, ax
5847  8A 85 38 A3     mov al, byte ptr [di - 0x5cc8]
584B  98              cwde
584C  C1 E0 03        shl ax, 3
584F  A2 A8 D0        mov byte ptr [0xd0a8], al
5852  80 3E 47 CF 00  cmp byte ptr [0xcf47], 0
5857  B0 00           mov al, 0
5859  7E 01           jle 0x585c
585B  40              inc ax
loc_585C:
585C  98              cwde
585D  8B F8           mov di, ax
585F  8A 85 38 A3     mov al, byte ptr [di - 0x5cc8]
5863  98              cwde
5864  6B C0 24        imul ax, ax, 0x24
5867  A2 A9 D0        mov byte ptr [0xd0a9], al
586A  EB 66           jmp 0x58d2
loc_586C:
586C  3C 0B           cmp al, 0xb
586E  75 08           jne 0x5878
5870  A1 46 CF        mov ax, word ptr [0xcf46]
5873  A3 A8 D0        mov word ptr [0xd0a8], ax
5876  EB 5A           jmp 0x58d2
loc_5878:
5878  3C 08           cmp al, 8
587A  75 29           jne 0x58a5
587C  80 3E 46 CF 00  cmp byte ptr [0xcf46], 0
5881  B0 00           mov al, 0
5883  7E 01           jle 0x5886
5885  40              inc ax
loc_5886:
5886  98              cwde
5887  8B F8           mov di, ax
5889  8A 85 38 A3     mov al, byte ptr [di - 0x5cc8]
588D  98              cwde
588E  D1 E0           shl ax, 1
5890  A2 A8 D0        mov byte ptr [0xd0a8], al
5893  C4 7E FC        les di, ptr [bp - 4]
5896  06              push es
5897  57              push di
5898  0E              push cs
5899  E8 30 C6        call 0x1ecc
589C  98              cwde
589D  6B C0 DF        imul ax, ax, -0x21
58A0  A2 A9 D0        mov byte ptr [0xd0a9], al
58A3  EB 2D           jmp 0x58d2
loc_58A5:
58A5  3C 07           cmp al, 7
58A7  75 20           jne 0x58c9
58A9  80 3E 46 CF 00  cmp byte ptr [0xcf46], 0
58AE  B0 00           mov al, 0
58B0  7E 01           jle 0x58b3
58B2  40              inc ax
loc_58B3:
58B3  98              cwde
58B4  8B F8           mov di, ax
58B6  8A 85 38 A3     mov al, byte ptr [di - 0x5cc8]
58BA  98              cwde
58BB  C1 E0 03        shl ax, 3
58BE  A2 A8 D0        mov byte ptr [0xd0a8], al
58C1  A0 47 CF        mov al, byte ptr [0xcf47]
58C4  A2 A9 D0        mov byte ptr [0xd0a9], al
58C7  EB 09           jmp 0x58d2
loc_58C9:
58C9  C4 7E FC        les di, ptr [bp - 4]
58CC  26 8B 05        mov ax, word ptr es:[di]
58CF  A3 A8 D0        mov word ptr [0xd0a8], ax
loc_58D2:
58D2  A1 A8 D0        mov ax, word ptr [0xd0a8]
58D5  C4 7E FC        les di, ptr [bp - 4]
58D8  26 89 45 08     mov word ptr es:[di + 8], ax
58DC  A1 A8 D0        mov ax, word ptr [0xd0a8]
58DF  A3 46 CF        mov word ptr [0xcf46], ax
58E2  06              push es
58E3  57              push di
58E4  0E              push cs
58E5  E8 75 C8        call 0x215d
58E8  30 E4           xor ah, ah
58EA  6B C0 0A        imul ax, ax, 0xa
58ED  50              push ax
58EE  E8 AF C0        call 0x19a0
58F1  05 0A 00        add ax, 0xa
58F4  5A              pop dx
58F5  03 C2           add ax, dx
58F7  C4 7E FC        les di, ptr [bp - 4]
58FA  26 88 45 11     mov byte ptr es:[di + 0x11], al
58FE  C9              leave
58FF  C2 04 00        ret 4

; ---- routine 0AB9:5902  (found by: call)
sub_5902:
5902  C8 02 00 00     enter 2, 0
5906  8A 46 08        mov al, byte ptr [bp + 8]
5909  98              cwde
590A  8B F8           mov di, ax
590C  D1 E7           shl di, 1
590E  FF B5 E4 D6     push word ptr [di - 0x291c]
5912  9A 7A 0E 55 1B  call far 1B55:0E7A
5917  08 C0           or al, al
5919  74 23           je 0x593e
591B  8A 46 08        mov al, byte ptr [bp + 8]
591E  50              push ax
591F  8A 46 06        mov al, byte ptr [bp + 6]
5922  50              push ax
5923  E8 97 5D        call 0xb6bd
5926  8B C8           mov cx, ax
5928  8B 46 06        mov ax, word ptr [bp + 6]
592B  D1 E0           shl ax, 1
592D  8B D0           mov dx, ax
592F  8A 46 08        mov al, byte ptr [bp + 8]
5932  98              cwde
5933  6B F8 0A        imul di, ax, 0xa
5936  03 FA           add di, dx
5938  89 8D 5C CF     mov word ptr [di - 0x30a4], cx
593C  EB 14           jmp 0x5952
loc_593E:
593E  8A 46 08        mov al, byte ptr [bp + 8]
5941  50              push ax
5942  8B 7E 06        mov di, word ptr [bp + 6]
5945  8A 85 F6 09     mov al, byte ptr [di + 0x9f6]
5949  30 E4           xor ah, ah
594B  50              push ax
594C  FF 76 06        push word ptr [bp + 6]
594F  E8 03 BB        call 0x1455
loc_5952:
5952  8A 46 08        mov al, byte ptr [bp + 8]
5955  50              push ax
5956  FF 76 06        push word ptr [bp + 6]
5959  E8 23 FE        call 0x577f
595C  89 46 FE        mov word ptr [bp - 2], ax
595F  83 7E FE 0C     cmp word ptr [bp - 2], 0xc
5963  73 14           jae 0x5979
5965  8A 46 08        mov al, byte ptr [bp + 8]
5968  98              cwde
5969  8B F8           mov di, ax
596B  8A 85 56 0D     mov al, byte ptr [di + 0xd56]
596F  30 E4           xor ah, ah
5971  03 46 FE        add ax, word ptr [bp - 2]
5974  89 46 FE        mov word ptr [bp - 2], ax
5977  EB 0F           jmp 0x5988
loc_5979:
5979  8A 46 08        mov al, byte ptr [bp + 8]
597C  98              cwde
597D  8B F8           mov di, ax
597F  8A 85 A4 D0     mov al, byte ptr [di - 0x2f5c]
5983  30 E4           xor ah, ah
5985  89 46 FE        mov word ptr [bp - 2], ax
loc_5988:
5988  FF 76 FE        push word ptr [bp - 2]
598B  8A 46 04        mov al, byte ptr [bp + 4]
598E  50              push ax
598F  E8 51 FE        call 0x57e3
5992  C9              leave
5993  C2 06 00        ret 6

; ---- routine 0AB9:5996  (found by: call)
sub_5996:
5996  55              push bp
5997  89 E5           mov bp, sp
5999  8A 46 04        mov al, byte ptr [bp + 4]
599C  50              push ax
599D  E8 17 C4        call 0x1db7
59A0  8A 46 06        mov al, byte ptr [bp + 6]
59A3  98              cwde
59A4  50              push ax
59A5  E8 2E C3        call 0x1cd6
59A8  98              cwde
59A9  6B F8 0A        imul di, ax, 0xa
59AC  58              pop ax
59AD  03 F8           add di, ax
59AF  FE 85 D2 D0     inc byte ptr [di - 0x2f2e]
59B3  C9              leave
59B4  C2 04 00        ret 4

; ---- routine 0AB9:59B7  (found by: call)
sub_59B7:
59B7  55              push bp
59B8  89 E5           mov bp, sp
59BA  80 3E B9 D0 00  cmp byte ptr [0xd0b9], 0
59BF  75 43           jne 0x5a04
59C1  C6 06 A1 D0 00  mov byte ptr [0xd0a1], 0
59C6  E8 66 11        call 0x6b2f
59C9  E8 0A C3        call 0x1cd6
59CC  08 C0           or al, al
59CE  B0 00           mov al, 0
59D0  75 01           jne 0x59d3
59D2  40              inc ax
loc_59D3:
59D3  98              cwde
59D4  8B F8           mov di, ax
59D6  8A 85 A4 D0     mov al, byte ptr [di - 0x2f5c]
59DA  30 E4           xor ah, ah
59DC  50              push ax
59DD  6A 07           push 7
59DF  E8 01 FE        call 0x57e3
59E2  6A 2B           push 0x2b
59E4  E8 D0 C3        call 0x1db7
59E7  A0 9F D0        mov al, byte ptr [0xd09f]
59EA  30 E4           xor ah, ah
59EC  6B F8 19        imul di, ax, 0x19
59EF  81 C7 EF CC     add di, 0xccef
59F3  1E              push ds
59F4  57              push di
59F5  0E              push cs
59F6  E8 D3 C4        call 0x1ecc
59F9  08 C0           or al, al
59FB  B0 00           mov al, 0
59FD  7E 01           jle 0x5a00
59FF  40              inc ax
loc_5A00:
5A00  50              push ax
5A01  E8 14 C0        call 0x1a18
loc_5A04:
5A04  C9              leave
5A05  C3              ret

; ---- routine 0AB9:5A06  (found by: call)
sub_5A06:
5A06  55              push bp
5A07  89 E5           mov bp, sp
5A09  80 3E B9 D0 00  cmp byte ptr [0xd0b9], 0
5A0E  75 44           jne 0x5a54
5A10  C6 06 A1 D0 00  mov byte ptr [0xd0a1], 0
5A15  E8 17 11        call 0x6b2f
5A18  E8 BB C2        call 0x1cd6
5A1B  08 C0           or al, al
5A1D  B0 00           mov al, 0
5A1F  75 01           jne 0x5a22
5A21  40              inc ax
loc_5A22:
5A22  50              push ax
5A23  6A 02           push 2
5A25  6A 09           push 9
5A27  E8 D8 FE        call 0x5902
5A2A  A0 9F D0        mov al, byte ptr [0xd09f]
5A2D  A2 9E D0        mov byte ptr [0xd09e], al
5A30  6A 00           push 0
5A32  6A 2D           push 0x2d
5A34  E8 5F FF        call 0x5996
5A37  A0 9F D0        mov al, byte ptr [0xd09f]
5A3A  30 E4           xor ah, ah
5A3C  6B F8 19        imul di, ax, 0x19
5A3F  81 C7 EF CC     add di, 0xccef
5A43  1E              push ds
5A44  57              push di
5A45  0E              push cs
5A46  E8 83 C4        call 0x1ecc
5A49  08 C0           or al, al
5A4B  B0 00           mov al, 0
5A4D  7E 01           jle 0x5a50
5A4F  40              inc ax
loc_5A50:
5A50  50              push ax
5A51  E8 C4 BF        call 0x1a18
loc_5A54:
5A54  C9              leave
5A55  C3              ret

