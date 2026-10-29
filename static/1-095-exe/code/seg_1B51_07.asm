; 1-095.EXE (One-Nil 95), code segment 1B51 (image offsets 1B510..2305F), part 7 of 12
; packed 1-095.EXE sha256 f659fb2d334500d6901fc8d6a0f06c85c0ccda2eb4a3035ae3bb0a0004d79192 (LZEXE 0.91)
; unpacked (tools/static/unlzexe.py) sha256 8df646e017e0965a5d90a58181ca764219ad847833aad0b6cb58fc53372bfb2c
; tool: capstone 5.0.9 (pip package; core library 5.0.1280) (CS_ARCH_X86, CS_MODE_16), recursive descent from the entry point, far calls and near calls/jumps, then routine prologues (55 89 E5 / 55 8B EC / C8 iw 00) in what remains; tools/static/listing.py
; addresses are SEGMENT:OFFSET with SEGMENT the image paragraph before relocation; image offset = SEGMENT*16+OFFSET
; ---- routine 1B51:443C  (found by: call, far)
sub_443C:
443C  C8 10 00 00     enter 0x10, 0
4440  8B 46 06        mov ax, word ptr [bp + 6]
4443  D1 E0           shl ax, 1
4445  C4 3E A6 D7     les di, ptr [0xd7a6]
4449  03 F8           add di, ax
444B  26 8B 05        mov ax, word ptr es:[di]
444E  89 46 F2        mov word ptr [bp - 0xe], ax
4451  8B 46 06        mov ax, word ptr [bp + 6]
4454  40              inc ax
4455  D1 E0           shl ax, 1
4457  C4 3E A6 D7     les di, ptr [0xd7a6]
445B  03 F8           add di, ax
445D  26 8B 05        mov ax, word ptr es:[di]
4460  89 46 F0        mov word ptr [bp - 0x10], ax
4463  8B 46 F2        mov ax, word ptr [bp - 0xe]
4466  C4 3E A2 D7     les di, ptr [0xd7a2]
446A  03 F8           add di, ax
446C  06              push es
446D  57              push di
446E  8D 7E F5        lea di, [bp - 0xb]
4471  16              push ss
4472  57              push di
4473  8B 46 F0        mov ax, word ptr [bp - 0x10]
4476  2B 46 F2        sub ax, word ptr [bp - 0xe]
4479  50              push ax
447A  9A C2 01 AC 24  call far 24AC:01C2
447F  8B 46 F0        mov ax, word ptr [bp - 0x10]
4482  2B 46 F2        sub ax, word ptr [bp - 0xe]
4485  88 46 F4        mov byte ptr [bp - 0xc], al
4488  8D 7E F4        lea di, [bp - 0xc]
448B  16              push ss
448C  57              push di
448D  C4 7E 08        les di, ptr [bp + 8]
4490  06              push es
4491  57              push di
4492  6A 0A           push 0xa
4494  9A 6D 0B B9 26  call far 26B9:0B6D
4499  C9              leave
449A  CA 02 00        retf 2

; ---- routine 1B51:449D  (found by: call, far)
sub_449D:
449D  55              push bp
449E  89 E5           mov bp, sp
44A0  81 3E 86 D6 90 01 cmp word ptr [0xd686], 0x190
44A6  73 11           jae 0x44b9
44A8  FF 06 86 D6     inc word ptr [0xd686]
44AC  8B 46 06        mov ax, word ptr [bp + 6]
44AF  8B 3E 86 D6     mov di, word ptr [0xd686]
44B3  D1 E7           shl di, 1
44B5  89 85 DA D1     mov word ptr [di - 0x2e26], ax
loc_44B9:
44B9  C9              leave
44BA  CA 02 00        retf 2

; ---- routine 1B51:44BD  (found by: call)
sub_44BD:
44BD  C8 08 00 00     enter 8, 0
44C1  8B 46 08        mov ax, word ptr [bp + 8]
44C4  89 46 FE        mov word ptr [bp - 2], ax
44C7  8B 46 06        mov ax, word ptr [bp + 6]
44CA  89 46 FC        mov word ptr [bp - 4], ax
44CD  8B 46 08        mov ax, word ptr [bp + 8]
44D0  03 46 06        add ax, word ptr [bp + 6]
44D3  D1 E8           shr ax, 1
44D5  8B F8           mov di, ax
44D7  D1 E7           shl di, 1
44D9  6B 85 DA D1 0F  imul ax, word ptr [di - 0x2e26], 0xf
44DE  C4 3E BE D7     les di, ptr [0xd7be]
44E2  03 F8           add di, ax
44E4  26 8A 45 05     mov al, byte ptr es:[di + 5]
44E8  30 E4           xor ah, ah
44EA  89 46 F8        mov word ptr [bp - 8], ax
loc_44ED:
44ED  8B 7E FE        mov di, word ptr [bp - 2]
44F0  D1 E7           shl di, 1
44F2  6B 85 DA D1 0F  imul ax, word ptr [di - 0x2e26], 0xf
44F7  C4 3E BE D7     les di, ptr [0xd7be]
44FB  03 F8           add di, ax
44FD  26 8A 45 05     mov al, byte ptr es:[di + 5]
4501  30 E4           xor ah, ah
4503  3B 46 F8        cmp ax, word ptr [bp - 8]
4506  76 05           jbe 0x450d
4508  FF 46 FE        inc word ptr [bp - 2]
450B  EB E0           jmp 0x44ed
loc_450D:
450D  8B 7E FC        mov di, word ptr [bp - 4]
4510  D1 E7           shl di, 1
4512  6B 85 DA D1 0F  imul ax, word ptr [di - 0x2e26], 0xf
4517  C4 3E BE D7     les di, ptr [0xd7be]
451B  03 F8           add di, ax
451D  26 8A 45 05     mov al, byte ptr es:[di + 5]
4521  30 E4           xor ah, ah
4523  3B 46 F8        cmp ax, word ptr [bp - 8]
4526  73 05           jae 0x452d
4528  FF 4E FC        dec word ptr [bp - 4]
452B  EB E0           jmp 0x450d
loc_452D:
452D  8B 46 FE        mov ax, word ptr [bp - 2]
4530  3B 46 FC        cmp ax, word ptr [bp - 4]
4533  77 30           ja 0x4565
4535  8B 7E FE        mov di, word ptr [bp - 2]
4538  D1 E7           shl di, 1
453A  8B 85 DA D1     mov ax, word ptr [di - 0x2e26]
453E  89 46 FA        mov word ptr [bp - 6], ax
4541  8B 7E FC        mov di, word ptr [bp - 4]
4544  D1 E7           shl di, 1
4546  8B 85 DA D1     mov ax, word ptr [di - 0x2e26]
454A  8B 7E FE        mov di, word ptr [bp - 2]
454D  D1 E7           shl di, 1
454F  89 85 DA D1     mov word ptr [di - 0x2e26], ax
4553  8B 46 FA        mov ax, word ptr [bp - 6]
4556  8B 7E FC        mov di, word ptr [bp - 4]
4559  D1 E7           shl di, 1
455B  89 85 DA D1     mov word ptr [di - 0x2e26], ax
455F  FF 46 FE        inc word ptr [bp - 2]
4562  FF 4E FC        dec word ptr [bp - 4]
loc_4565:
4565  8B 46 FE        mov ax, word ptr [bp - 2]
4568  3B 46 FC        cmp ax, word ptr [bp - 4]
456B  76 80           jbe 0x44ed
456D  8B 46 08        mov ax, word ptr [bp + 8]
4570  3B 46 FC        cmp ax, word ptr [bp - 4]
4573  73 0D           jae 0x4582
4575  FF 76 08        push word ptr [bp + 8]
4578  FF 76 FC        push word ptr [bp - 4]
457B  8B 7E 04        mov di, word ptr [bp + 4]
457E  57              push di
457F  E8 3B FF        call 0x44bd
loc_4582:
4582  8B 46 FE        mov ax, word ptr [bp - 2]
4585  3B 46 06        cmp ax, word ptr [bp + 6]
4588  73 0D           jae 0x4597
458A  FF 76 FE        push word ptr [bp - 2]
458D  FF 76 06        push word ptr [bp + 6]
4590  8B 7E 04        mov di, word ptr [bp + 4]
4593  57              push di
4594  E8 26 FF        call 0x44bd
loc_4597:
4597  C9              leave
4598  C2 06 00        ret 6

; ---- routine 1B51:459B  (found by: call)
sub_459B:
459B  C8 02 00 00     enter 2, 0
459F  C7 46 FE 01 00  mov word ptr [bp - 2], 1
45A4  EB 03           jmp 0x45a9
loc_45A6:
45A6  FF 46 FE        inc word ptr [bp - 2]
loc_45A9:
45A9  8B 46 FE        mov ax, word ptr [bp - 2]
45AC  D1 E0           shl ax, 1
45AE  C4 7E 06        les di, ptr [bp + 6]
45B1  03 F8           add di, ax
45B3  26 83 7D FE 00  cmp word ptr es:[di - 2], 0
45B8  74 30           je 0x45ea
45BA  8B 46 FE        mov ax, word ptr [bp - 2]
45BD  D1 E0           shl ax, 1
45BF  C4 7E 06        les di, ptr [bp + 6]
45C2  03 F8           add di, ax
45C4  26 8B 45 FE     mov ax, word ptr es:[di - 2]
45C8  C1 E0 03        shl ax, 3
45CB  C4 3E BA D7     les di, ptr [0xd7ba]
45CF  03 F8           add di, ax
45D1  26 80 7D 07 00  cmp byte ptr es:[di + 7], 0
45D6  74 12           je 0x45ea
45D8  8B 46 FE        mov ax, word ptr [bp - 2]
45DB  D1 E0           shl ax, 1
45DD  C4 7E 06        les di, ptr [bp + 6]
45E0  03 F8           add di, ax
45E2  26 FF 75 FE     push word ptr es:[di - 2]
45E6  0E              push cs
45E7  E8 B3 FE        call 0x449d
loc_45EA:
45EA  83 7E FE 14     cmp word ptr [bp - 2], 0x14
45EE  75 B6           jne 0x45a6
45F0  C9              leave
45F1  C2 06 00        ret 6

; ---- routine 1B51:45F4  (found by: far)
sub_45F4:
45F4  C8 0A 00 00     enter 0xa, 0
45F8  31 C0           xor ax, ax
45FA  A3 86 D6        mov word ptr [0xd686], ax
45FD  C4 7E 06        les di, ptr [bp + 6]
4600  26 8B 05        mov ax, word ptr es:[di]
4603  05 0F 00        add ax, 0xf
4606  89 46 FA        mov word ptr [bp - 6], ax
4609  26 8B 05        mov ax, word ptr es:[di]
460C  3B 46 FA        cmp ax, word ptr [bp - 6]
460F  77 64           ja 0x4675
4611  89 46 FE        mov word ptr [bp - 2], ax
4614  EB 03           jmp 0x4619
loc_4616:
4616  FF 46 FE        inc word ptr [bp - 2]
loc_4619:
4619  8B 7E FE        mov di, word ptr [bp - 2]
461C  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
4620  30 E4           xor ah, ah
4622  6B C0 3E        imul ax, ax, 0x3e
4625  C4 3E C2 D7     les di, ptr [0xd7c2]
4629  03 F8           add di, ax
462B  81 C7 C2 FF     add di, 0xffc2
462F  06              push es
4630  57              push di
4631  55              push bp
4632  E8 66 FF        call 0x459b
4635  8B 7E FE        mov di, word ptr [bp - 2]
4638  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
463C  3A 06 BA DC     cmp al, byte ptr [0xdcba]
4640  75 10           jne 0x4652
4642  C4 3E D2 D7     les di, ptr [0xd7d2]
4646  81 C7 58 00     add di, 0x58
464A  06              push es
464B  57              push di
464C  55              push bp
464D  E8 4B FF        call 0x459b
4650  EB 1B           jmp 0x466d
loc_4652:
4652  8B 7E FE        mov di, word ptr [bp - 2]
4655  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
4659  3A 06 BB DC     cmp al, byte ptr [0xdcbb]
465D  75 0E           jne 0x466d
465F  C4 3E D2 D7     les di, ptr [0xd7d2]
4663  81 C7 80 00     add di, 0x80
4667  06              push es
4668  57              push di
4669  55              push bp
466A  E8 2E FF        call 0x459b
loc_466D:
466D  8B 46 FE        mov ax, word ptr [bp - 2]
4670  3B 46 FA        cmp ax, word ptr [bp - 6]
4673  75 A1           jne 0x4616
loc_4675:
4675  6A 01           push 1
4677  FF 36 86 D6     push word ptr [0xd686]
467B  55              push bp
467C  E8 3E FE        call 0x44bd
467F  BF DC D1        mov di, 0xd1dc
4682  1E              push ds
4683  57              push di
4684  C4 7E 06        les di, ptr [bp + 6]
4687  26 8B 3D        mov di, word ptr es:[di]
468A  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
468E  30 E4           xor ah, ah
4690  6B C0 3E        imul ax, ax, 0x3e
4693  C4 3E C2 D7     les di, ptr [0xd7c2]
4697  03 F8           add di, ax
4699  26 8A 45 F9     mov al, byte ptr es:[di - 7]
469D  98              cwde
469E  6B F8 28        imul di, ax, 0x28
46A1  81 C7 AC D5     add di, 0xd5ac
46A5  1E              push ds
46A6  57              push di
46A7  6A 28           push 0x28
46A9  9A C2 01 AC 24  call far 24AC:01C2
46AE  C4 7E 06        les di, ptr [bp + 6]
46B1  26 83 05 10     add word ptr es:[di], 0x10
46B5  C9              leave
46B6  CA 04 00        retf 4

; ---- routine 1B51:46B9  (found by: far)
sub_46B9:
46B9  C8 02 00 00     enter 2, 0
46BD  8A 46 06        mov al, byte ptr [bp + 6]
46C0  98              cwde
46C1  8B F8           mov di, ax
46C3  8A 85 DE D6     mov al, byte ptr [di - 0x2922]
46C7  30 E4           xor ah, ah
46C9  8B C8           mov cx, ax
46CB  A0 DD D6        mov al, byte ptr [0xd6dd]
46CE  30 E4           xor ah, ah
46D0  8B D0           mov dx, ax
46D2  8A 46 06        mov al, byte ptr [bp + 6]
46D5  98              cwde
46D6  8B F8           mov di, ax
46D8  8A 85 E0 D6     mov al, byte ptr [di - 0x2920]
46DC  30 E4           xor ah, ah
46DE  03 C2           add ax, dx
46E0  2B C1           sub ax, cx
46E2  89 46 FE        mov word ptr [bp - 2], ax
46E5  8B 46 FE        mov ax, word ptr [bp - 2]
46E8  C9              leave
46E9  CA 02 00        retf 2

; ---- routine 1B51:46EC  (found by: far)
sub_46EC:
46EC  C8 0A 00 00     enter 0xa, 0
46F0  BF 5E 1D        mov di, 0x1d5e
46F3  1E              push ds
46F4  57              push di
46F5  BF 5C DD        mov di, 0xdd5c
46F8  1E              push ds
46F9  57              push di
46FA  9A 2F 05 1A 23  call far 231A:052F
46FF  83 7E 06 00     cmp word ptr [bp + 6], 0
4703  75 03           jne 0x4708
4705  E9 90 00        jmp 0x4798
loc_4708:
4708  8B 46 06        mov ax, word ptr [bp + 6]
470B  C1 E0 03        shl ax, 3
470E  C4 3E BA D7     les di, ptr [0xd7ba]
4712  03 F8           add di, ax
4714  89 7E F6        mov word ptr [bp - 0xa], di
4717  8C 46 F8        mov word ptr [bp - 8], es
471A  C7 06 64 DD 70 00 mov word ptr [0xdd64], 0x70
4720  26 8A 45 04     mov al, byte ptr es:[di + 4]
4724  30 E4           xor ah, ah
4726  89 46 FE        mov word ptr [bp - 2], ax
4729  FF 46 FE        inc word ptr [bp - 2]
472C  C7 46 FA 01 00  mov word ptr [bp - 6], 1
4731  EB 03           jmp 0x4736
loc_4733:
4733  FF 46 FA        inc word ptr [bp - 6]
loc_4736:
4736  8B 56 FA        mov dx, word ptr [bp - 6]
4739  C4 7E F6        les di, ptr [bp - 0xa]
473C  26 8A 45 07     mov al, byte ptr es:[di + 7]
4740  30 E4           xor ah, ah
4742  6B F8 16        imul di, ax, 0x16
4745  03 FA           add di, dx
4747  8A 85 7D 95     mov al, byte ptr [di - 0x6a83]
474B  30 E4           xor ah, ah
474D  8B D0           mov dx, ax
474F  C4 7E F6        les di, ptr [bp - 0xa]
4752  26 8A 45 05     mov al, byte ptr es:[di + 5]
4756  30 E4           xor ah, ah
4758  6B F8 16        imul di, ax, 0x16
475B  03 FA           add di, dx
475D  8A 85 B1 96     mov al, byte ptr [di - 0x694f]
4761  30 E4           xor ah, ah
4763  89 46 FC        mov word ptr [bp - 4], ax
4766  8B 46 FC        mov ax, word ptr [bp - 4]
4769  F7 66 FE        mul word ptr [bp - 2]
476C  C1 E8 08        shr ax, 8
476F  89 46 FC        mov word ptr [bp - 4], ax
4772  8B 46 FA        mov ax, word ptr [bp - 6]
4775  40              inc ax
4776  69 C0 A0 00     imul ax, ax, 0xa0
477A  C4 3E 5C DD     les di, ptr [0xdd5c]
477E  03 F8           add di, ax
4780  81 C7 8A FF     add di, 0xff8a
4784  06              push es
4785  57              push di
4786  A0 64 DD        mov al, byte ptr [0xdd64]
4789  50              push ax
478A  FF 76 FC        push word ptr [bp - 4]
478D  9A 4B 03 AC 24  call far 24AC:034B
4792  83 7E FA 16     cmp word ptr [bp - 6], 0x16
4796  75 9B           jne 0x4733
loc_4798:
4798  C9              leave
4799  CA 02 00        retf 2

; ---- routine 1B51:479C  (found by: far)
sub_479C:
479C  C8 04 00 00     enter 4, 0
47A0  8B 7E 06        mov di, word ptr [bp + 6]
47A3  D1 E7           shl di, 1
47A5  8B 85 28 98     mov ax, word ptr [di - 0x67d8]
47A9  D1 E0           shl ax, 1
47AB  31 D2           xor dx, dx
47AD  89 46 FC        mov word ptr [bp - 4], ax
47B0  89 56 FE        mov word ptr [bp - 2], dx
47B3  8B 46 FC        mov ax, word ptr [bp - 4]
47B6  8B 56 FE        mov dx, word ptr [bp - 2]
47B9  C9              leave
47BA  CA 02 00        retf 2

; ---- routine 1B51:47BD  (found by: call, far)
sub_47BD:
47BD  C8 1A 00 00     enter 0x1a, 0
47C1  8B 46 06        mov ax, word ptr [bp + 6]
47C4  C1 E0 03        shl ax, 3
47C7  C4 3E BA D7     les di, ptr [0xd7ba]
47CB  03 F8           add di, ax
47CD  89 7E EE        mov word ptr [bp - 0x12], di
47D0  8C 46 F0        mov word ptr [bp - 0x10], es
47D3  6B 46 06 0F     imul ax, word ptr [bp + 6], 0xf
47D7  C4 3E BE D7     les di, ptr [0xd7be]
47DB  03 F8           add di, ax
47DD  89 7E EA        mov word ptr [bp - 0x16], di
47E0  8C 46 EC        mov word ptr [bp - 0x14], es
47E3  C4 7E EE        les di, ptr [bp - 0x12]
47E6  26 80 7D 07 00  cmp byte ptr es:[di + 7], 0
47EB  B0 00           mov al, 0
47ED  75 01           jne 0x47f0
47EF  40              inc ax
loc_47F0:
47F0  98              cwde
47F1  8B F8           mov di, ax
47F3  8A 85 84 12     mov al, byte ptr [di + 0x1284]
47F7  C4 7E EE        les di, ptr [bp - 0x12]
47FA  26 3A 45 01     cmp al, byte ptr es:[di + 1]
47FE  73 38           jae 0x4838
4800  26 80 7D 07 00  cmp byte ptr es:[di + 7], 0
4805  B0 00           mov al, 0
4807  75 01           jne 0x480a
4809  40              inc ax
loc_480A:
480A  98              cwde
480B  8B F8           mov di, ax
480D  8A 85 84 12     mov al, byte ptr [di + 0x1284]
4811  30 E4           xor ah, ah
4813  8B D0           mov dx, ax
4815  C4 7E EE        les di, ptr [bp - 0x12]
4818  26 8A 45 01     mov al, byte ptr es:[di + 1]
481C  30 E4           xor ah, ah
481E  2B C2           sub ax, dx
4820  8B D0           mov dx, ax
4822  B8 10 00        mov ax, 0x10
4825  2B C2           sub ax, dx
4827  99              cdq
4828  52              push dx
4829  50              push ax
482A  6A 00           push 0
482C  6A 00           push 0
482E  9A C0 04 AC 24  call far 24AC:04C0
4833  89 46 F2        mov word ptr [bp - 0xe], ax
4836  EB 05           jmp 0x483d
loc_4838:
4838  C7 46 F2 10 00  mov word ptr [bp - 0xe], 0x10
loc_483D:
483D  C4 7E EE        les di, ptr [bp - 0x12]
4840  26 8A 45 04     mov al, byte ptr es:[di + 4]
4844  30 E4           xor ah, ah
4846  31 D2           xor dx, dx
4848  89 46 F4        mov word ptr [bp - 0xc], ax
484B  89 56 F6        mov word ptr [bp - 0xa], dx
484E  26 8A 05        mov al, byte ptr es:[di]
4851  30 E4           xor ah, ah
4853  6B C0 3E        imul ax, ax, 0x3e
4856  C4 3E C2 D7     les di, ptr [0xd7c2]
485A  03 F8           add di, ax
485C  26 8A 45 F9     mov al, byte ptr es:[di - 7]
4860  98              cwde
4861  8B F8           mov di, ax
4863  8A 85 74 12     mov al, byte ptr [di + 0x1274]
4867  98              cwde
4868  99              cdq
4869  01 46 F4        add word ptr [bp - 0xc], ax
486C  11 56 F6        adc word ptr [bp - 0xa], dx
486F  83 7E F6 00     cmp word ptr [bp - 0xa], 0
4873  7C 08           jl 0x487d
4875  7F 0E           jg 0x4885
4877  83 7E F4 00     cmp word ptr [bp - 0xc], 0
487B  73 08           jae 0x4885
loc_487D:
487D  31 C0           xor ax, ax
487F  89 46 F4        mov word ptr [bp - 0xc], ax
4882  89 46 F6        mov word ptr [bp - 0xa], ax
loc_4885:
4885  C4 7E EE        les di, ptr [bp - 0x12]
4888  26 8A 05        mov al, byte ptr es:[di]
488B  30 E4           xor ah, ah
488D  6B C0 3E        imul ax, ax, 0x3e
4890  C4 3E C2 D7     les di, ptr [0xd7c2]
4894  03 F8           add di, ax
4896  81 C7 C2 FF     add di, 0xffc2
489A  C4 7E EE        les di, ptr [bp - 0x12]
489D  26 80 7D 07 00  cmp byte ptr es:[di + 7], 0
48A2  74 2A           je 0x48ce
48A4  26 8A 45 02     mov al, byte ptr es:[di + 2]
48A8  30 E4           xor ah, ah
48AA  40              inc ax
48AB  40              inc ax
48AC  8B D0           mov dx, ax
48AE  26 8A 45 01     mov al, byte ptr es:[di + 1]
48B2  30 E4           xor ah, ah
48B4  3B C2           cmp ax, dx
48B6  7F 16           jg 0x48ce
48B8  C4 7E EA        les di, ptr [bp - 0x16]
48BB  26 8B 45 02     mov ax, word ptr es:[di + 2]
48BF  31 D2           xor dx, dx
48C1  B9 0A 00        mov cx, 0xa
48C4  F7 F1           div cx
48C6  31 D2           xor dx, dx
48C8  01 46 F4        add word ptr [bp - 0xc], ax
48CB  11 56 F6        adc word ptr [bp - 0xa], dx
loc_48CE:
48CE  6A 00           push 0
48D0  68 00 01        push 0x100
48D3  8B 46 F2        mov ax, word ptr [bp - 0xe]
48D6  31 D2           xor dx, dx
48D8  8B 4E F4        mov cx, word ptr [bp - 0xc]
48DB  8B 5E F6        mov bx, word ptr [bp - 0xa]
48DE  9A 2A 0A B9 26  call far 26B9:0A2A
48E3  B9 10 00        mov cx, 0x10
48E6  31 DB           xor bx, bx
48E8  9A 67 0A B9 26  call far 26B9:0A67
48ED  52              push dx
48EE  50              push ax
48EF  9A FA 04 AC 24  call far 24AC:04FA
48F4  89 46 F4        mov word ptr [bp - 0xc], ax
48F7  89 56 F6        mov word ptr [bp - 0xa], dx
48FA  8B 7E F4        mov di, word ptr [bp - 0xc]
48FD  D1 E7           shl di, 1
48FF  8B 85 28 98     mov ax, word ptr [di - 0x67d8]
4903  31 D2           xor dx, dx
4905  89 46 F4        mov word ptr [bp - 0xc], ax
4908  89 56 F6        mov word ptr [bp - 0xa], dx
490B  8B 46 F4        mov ax, word ptr [bp - 0xc]
490E  8B 56 F6        mov dx, word ptr [bp - 0xa]
4911  B9 E8 03        mov cx, 0x3e8
4914  31 DB           xor bx, bx
4916  9A 2A 0A B9 26  call far 26B9:0A2A
491B  89 46 F4        mov word ptr [bp - 0xc], ax
491E  89 56 F6        mov word ptr [bp - 0xa], dx
4921  8B 46 F4        mov ax, word ptr [bp - 0xc]
4924  8B 56 F6        mov dx, word ptr [bp - 0xa]
4927  89 46 FC        mov word ptr [bp - 4], ax
492A  89 56 FE        mov word ptr [bp - 2], dx
492D  8B 46 FC        mov ax, word ptr [bp - 4]
4930  8B 56 FE        mov dx, word ptr [bp - 2]
4933  C9              leave
4934  CA 02 00        retf 2

; ---- routine 1B51:4937  (found by: far)
sub_4937:
4937  C8 08 00 00     enter 8, 0
493B  8B 46 06        mov ax, word ptr [bp + 6]
493E  C1 E0 03        shl ax, 3
4941  C4 3E BA D7     les di, ptr [0xd7ba]
4945  03 F8           add di, ax
4947  89 7E F8        mov word ptr [bp - 8], di
494A  8C 46 FA        mov word ptr [bp - 6], es
494D  6A 06           push 6
494F  9A 6D 07 1A 23  call far 231A:076D
4954  50              push ax
4955  6A 06           push 6
4957  9A 6D 07 1A 23  call far 231A:076D
495C  F7 D8           neg ax
495E  8B D0           mov dx, ax
4960  C4 7E F8        les di, ptr [bp - 8]
4963  26 8A 45 04     mov al, byte ptr es:[di + 4]
4967  30 E4           xor ah, ah
4969  03 C2           add ax, dx
496B  5A              pop dx
496C  03 C2           add ax, dx
496E  89 46 FC        mov word ptr [bp - 4], ax
4971  81 7E FC FF 00  cmp word ptr [bp - 4], 0xff
4976  7E 07           jle 0x497f
4978  C7 46 FC FF 00  mov word ptr [bp - 4], 0xff
497D  EB 0B           jmp 0x498a
loc_497F:
497F  83 7E FC 04     cmp word ptr [bp - 4], 4
4983  7D 05           jge 0x498a
4985  C7 46 FC 04 00  mov word ptr [bp - 4], 4
loc_498A:
498A  8A 46 FC        mov al, byte ptr [bp - 4]
498D  88 46 FF        mov byte ptr [bp - 1], al
4990  8A 46 FF        mov al, byte ptr [bp - 1]
4993  C9              leave
4994  CA 02 00        retf 2

; ---- routine 1B51:4997  (found by: call, far)
sub_4997:
4997  C8 06 00 00     enter 6, 0
499B  6B 46 06 3E     imul ax, word ptr [bp + 6], 0x3e
499F  C4 3E C2 D7     les di, ptr [0xd7c2]
49A3  03 F8           add di, ax
49A5  81 C7 C2 FF     add di, 0xffc2
49A9  89 7E FA        mov word ptr [bp - 6], di
49AC  8C 46 FC        mov word ptr [bp - 4], es
49AF  26 8B 45 2A     mov ax, word ptr es:[di + 0x2a]
49B3  C1 E0 02        shl ax, 2
49B6  C4 3E C8 DC     les di, ptr [0xdcc8]
49BA  03 F8           add di, ax
49BC  26 8A 45 02     mov al, byte ptr es:[di + 2]
49C0  30 E4           xor ah, ah
49C2  C1 E8 04        shr ax, 4
49C5  8B D0           mov dx, ax
49C7  C4 7E FA        les di, ptr [bp - 6]
49CA  26 8B 45 28     mov ax, word ptr es:[di + 0x28]
49CE  C1 E0 02        shl ax, 2
49D1  C4 3E C8 DC     les di, ptr [0xdcc8]
49D5  03 F8           add di, ax
49D7  26 8A 45 02     mov al, byte ptr es:[di + 2]
49DB  30 E4           xor ah, ah
49DD  C1 E8 05        shr ax, 5
49E0  05 10 00        add ax, 0x10
49E3  03 C2           add ax, dx
49E5  89 46 FE        mov word ptr [bp - 2], ax
49E8  8B 46 FE        mov ax, word ptr [bp - 2]
49EB  C9              leave
49EC  CA 02 00        retf 2

; ---- routine 1B51:49EF  (found by: call, far)
sub_49EF:
49EF  C8 0C 00 00     enter 0xc, 0
49F3  6B 46 08 3E     imul ax, word ptr [bp + 8], 0x3e
49F7  C4 3E C2 D7     les di, ptr [0xd7c2]
49FB  03 F8           add di, ax
49FD  81 C7 C2 FF     add di, 0xffc2
4A01  89 7E F8        mov word ptr [bp - 8], di
4A04  8C 46 FA        mov word ptr [bp - 6], es
4A07  C6 46 FD 00     mov byte ptr [bp - 3], 0
4A0B  EB 03           jmp 0x4a10
loc_4A0D:
4A0D  FE 46 FD        inc byte ptr [bp - 3]
loc_4A10:
4A10  8A 46 FD        mov al, byte ptr [bp - 3]
4A13  98              cwde
4A14  D1 E0           shl ax, 1
4A16  C4 7E F8        les di, ptr [bp - 8]
4A19  03 F8           add di, ax
4A1B  26 83 7D 28 00  cmp word ptr es:[di + 0x28], 0
4A20  74 50           je 0x4a72
4A22  8A 46 FD        mov al, byte ptr [bp - 3]
4A25  98              cwde
4A26  D1 E0           shl ax, 1
4A28  C4 7E F8        les di, ptr [bp - 8]
4A2B  03 F8           add di, ax
4A2D  26 8B 45 28     mov ax, word ptr es:[di + 0x28]
4A31  C1 E0 02        shl ax, 2
4A34  C4 3E C8 DC     les di, ptr [0xdcc8]
4A38  03 F8           add di, ax
4A3A  89 7E F4        mov word ptr [bp - 0xc], di
4A3D  8C 46 F6        mov word ptr [bp - 0xa], es
4A40  26 8A 45 02     mov al, byte ptr es:[di + 2]
4A44  30 E4           xor ah, ah
4A46  89 46 FE        mov word ptr [bp - 2], ax
4A49  8B 46 06        mov ax, word ptr [bp + 6]
4A4C  01 46 FE        add word ptr [bp - 2], ax
4A4F  83 7E FE 01     cmp word ptr [bp - 2], 1
4A53  7D 07           jge 0x4a5c
4A55  C7 46 FE 01 00  mov word ptr [bp - 2], 1
4A5A  EB 0C           jmp 0x4a68
loc_4A5C:
4A5C  81 7E FE B0 00  cmp word ptr [bp - 2], 0xb0
4A61  7E 05           jle 0x4a68
4A63  C7 46 FE B0 00  mov word ptr [bp - 2], 0xb0
loc_4A68:
4A68  8A 46 FE        mov al, byte ptr [bp - 2]
4A6B  C4 7E F4        les di, ptr [bp - 0xc]
4A6E  26 88 45 02     mov byte ptr es:[di + 2], al
loc_4A72:
4A72  80 7E FD 01     cmp byte ptr [bp - 3], 1
4A76  75 95           jne 0x4a0d
4A78  C9              leave
4A79  CA 04 00        retf 4

; ---- routine 1B51:4A7C  (found by: call, far)
sub_4A7C:
4A7C  C8 04 00 00     enter 4, 0
4A80  6B 46 08 3E     imul ax, word ptr [bp + 8], 0x3e
4A84  C4 3E C2 D7     les di, ptr [0xd7c2]
4A88  03 F8           add di, ax
4A8A  81 C7 C2 FF     add di, 0xffc2
4A8E  8A 46 06        mov al, byte ptr [bp + 6]
4A91  26 00 45 35     add byte ptr es:[di + 0x35], al
4A95  8A 46 06        mov al, byte ptr [bp + 6]
4A98  26 00 45 34     add byte ptr es:[di + 0x34], al
4A9C  FF 76 08        push word ptr [bp + 8]
4A9F  FF 76 06        push word ptr [bp + 6]
4AA2  0E              push cs
4AA3  E8 49 FF        call 0x49ef
4AA6  C9              leave
4AA7  CA 04 00        retf 4

; ---- routine 1B51:4AAA  (found by: call, far)
sub_4AAA:
4AAA  C8 0E 00 00     enter 0xe, 0
4AAE  8B 46 08        mov ax, word ptr [bp + 8]
4AB1  C1 E0 03        shl ax, 3
4AB4  C4 3E BA D7     les di, ptr [0xd7ba]
4AB8  03 F8           add di, ax
4ABA  89 7E F6        mov word ptr [bp - 0xa], di
4ABD  8C 46 F8        mov word ptr [bp - 8], es
4AC0  6B 46 08 0F     imul ax, word ptr [bp + 8], 0xf
4AC4  C4 3E BE D7     les di, ptr [0xd7be]
4AC8  03 F8           add di, ax
4ACA  89 7E F2        mov word ptr [bp - 0xe], di
4ACD  8C 46 F4        mov word ptr [bp - 0xc], es
4AD0  FF 76 08        push word ptr [bp + 8]
4AD3  0E              push cs
4AD4  E8 12 04        call 0x4ee9
4AD7  08 C0           or al, al
4AD9  74 08           je 0x4ae3
4ADB  31 C0           xor ax, ax
4ADD  89 46 FE        mov word ptr [bp - 2], ax
4AE0  E9 A3 00        jmp 0x4b86
loc_4AE3:
4AE3  C4 7E F2        les di, ptr [bp - 0xe]
4AE6  26 8A 45 08     mov al, byte ptr es:[di + 8]
4AEA  98              cwde
4AEB  8B D0           mov dx, ax
4AED  C4 7E F6        les di, ptr [bp - 0xa]
4AF0  26 8A 45 04     mov al, byte ptr es:[di + 4]
4AF4  30 E4           xor ah, ah
4AF6  05 C2 FF        add ax, 0xffc2
4AF9  03 C2           add ax, dx
4AFB  89 46 FC        mov word ptr [bp - 4], ax
4AFE  C4 7E F2        les di, ptr [bp - 0xe]
4B01  26 80 7D 06 20  cmp byte ptr es:[di + 6], 0x20
4B06  7D 0A           jge 0x4b12
4B08  26 8A 45 06     mov al, byte ptr es:[di + 6]
4B0C  98              cwde
4B0D  01 46 FC        add word ptr [bp - 4], ax
4B10  EB 3E           jmp 0x4b50
loc_4B12:
4B12  80 7E 06 00     cmp byte ptr [bp + 6], 0
4B16  74 2A           je 0x4b42
4B18  C4 7E F6        les di, ptr [bp - 0xa]
4B1B  26 80 7D 07 00  cmp byte ptr es:[di + 7], 0
4B20  75 20           jne 0x4b42
4B22  26 80 7D 07 00  cmp byte ptr es:[di + 7], 0
4B27  B0 00           mov al, 0
4B29  75 01           jne 0x4b2c
4B2B  40              inc ax
loc_4B2C:
4B2C  98              cwde
4B2D  8B F8           mov di, ax
4B2F  8A 85 86 12     mov al, byte ptr [di + 0x1286]
4B33  30 E4           xor ah, ah
4B35  8B C8           mov cx, ax
4B37  8B 46 FC        mov ax, word ptr [bp - 4]
4B3A  99              cdq
4B3B  F7 F9           idiv cx
4B3D  29 46 FC        sub word ptr [bp - 4], ax
4B40  EB 0E           jmp 0x4b50
loc_4B42:
4B42  C4 7E F6        les di, ptr [bp - 0xa]
4B45  26 80 7D 07 00  cmp byte ptr es:[di + 7], 0
4B4A  75 04           jne 0x4b50
4B4C  83 46 FC 10     add word ptr [bp - 4], 0x10
loc_4B50:
4B50  83 7E FC 00     cmp word ptr [bp - 4], 0
4B54  7D 07           jge 0x4b5d
4B56  31 C0           xor ax, ax
4B58  89 46 FC        mov word ptr [bp - 4], ax
4B5B  EB 0C           jmp 0x4b69
loc_4B5D:
4B5D  81 7E FC 00 01  cmp word ptr [bp - 4], 0x100
4B62  7E 05           jle 0x4b69
4B64  C7 46 FC 00 01  mov word ptr [bp - 4], 0x100
loc_4B69:
4B69  FF 76 08        push word ptr [bp + 8]
4B6C  0E              push cs
4B6D  E8 F5 02        call 0x4e65
4B70  08 C0           or al, al
4B72  74 0C           je 0x4b80
4B74  8B 46 FC        mov ax, word ptr [bp - 4]
4B77  99              cdq
4B78  B9 02 00        mov cx, 2
4B7B  F7 F9           idiv cx
4B7D  89 46 FC        mov word ptr [bp - 4], ax
loc_4B80:
4B80  8B 46 FC        mov ax, word ptr [bp - 4]
4B83  89 46 FE        mov word ptr [bp - 2], ax
loc_4B86:
4B86  8B 46 FE        mov ax, word ptr [bp - 2]
4B89  C9              leave
4B8A  CA 04 00        retf 4
; data (not reached as code), 29 bytes
4B8D                  pstr "Can't play"
4B98                  pstr 'too young to tell'

; ---- routine 1B51:4BAA  (found by: far)
sub_4BAA:
4BAA  C8 02 00 00     enter 2, 0
4BAE  FF 76 0A        push word ptr [bp + 0xa]
4BB1  6A 01           push 1
4BB3  0E              push cs
4BB4  E8 F3 FE        call 0x4aaa
4BB7  C1 E8 04        shr ax, 4
4BBA  89 46 FE        mov word ptr [bp - 2], ax
4BBD  83 7E FE 10     cmp word ptr [bp - 2], 0x10
4BC1  76 05           jbe 0x4bc8
4BC3  C7 46 FE 10 00  mov word ptr [bp - 2], 0x10
loc_4BC8:
4BC8  83 7E FE 00     cmp word ptr [bp - 2], 0
4BCC  75 24           jne 0x4bf2
4BCE  FF 76 0A        push word ptr [bp + 0xa]
4BD1  0E              push cs
4BD2  E8 14 03        call 0x4ee9
4BD5  08 C0           or al, al
4BD7  74 19           je 0x4bf2
4BD9  BF 8D 4B        mov di, 0x4b8d
4BDC  0E              push cs
4BDD  57              push di
4BDE  8A 46 08        mov al, byte ptr [bp + 8]
4BE1  50              push ax
4BE2  8A 46 06        mov al, byte ptr [bp + 6]
4BE5  50              push ax
4BE6  BF 5C DD        mov di, 0xdd5c
4BE9  1E              push ds
4BEA  57              push di
4BEB  9A 9D 03 1A 23  call far 231A:039D
4BF0  EB 76           jmp 0x4c68
loc_4BF2:
4BF2  8B 46 0A        mov ax, word ptr [bp + 0xa]
4BF5  C1 E0 03        shl ax, 3
4BF8  C4 3E BA D7     les di, ptr [0xd7ba]
4BFC  03 F8           add di, ax
4BFE  26 80 7D 01 12  cmp byte ptr es:[di + 1], 0x12
4C03  73 19           jae 0x4c1e
4C05  BF 98 4B        mov di, 0x4b98
4C08  0E              push cs
4C09  57              push di
4C0A  8A 46 08        mov al, byte ptr [bp + 8]
4C0D  50              push ax
4C0E  8A 46 06        mov al, byte ptr [bp + 6]
4C11  50              push ax
4C12  BF 5C DD        mov di, 0xdd5c
4C15  1E              push ds
4C16  57              push di
4C17  9A 9D 03 1A 23  call far 231A:039D
4C1C  EB 4A           jmp 0x4c68
loc_4C1E:
4C1E  8B 7E FE        mov di, word ptr [bp - 2]
4C21  8A 85 8E 93     mov al, byte ptr [di - 0x6c72]
4C25  30 E4           xor ah, ah
4C27  8B F8           mov di, ax
4C29  C1 E7 04        shl di, 4
4C2C  81 C7 0C 8A     add di, 0x8a0c
4C30  1E              push ds
4C31  57              push di
4C32  8A 46 08        mov al, byte ptr [bp + 8]
4C35  50              push ax
4C36  8A 46 06        mov al, byte ptr [bp + 6]
4C39  50              push ax
4C3A  BF 5C DD        mov di, 0xdd5c
4C3D  1E              push ds
4C3E  57              push di
4C3F  9A 9D 03 1A 23  call far 231A:039D
4C44  8B 46 06        mov ax, word ptr [bp + 6]
4C47  D1 E0           shl ax, 1
4C49  8B D0           mov dx, ax
4C4B  69 46 08 A0 00  imul ax, word ptr [bp + 8], 0xa0
4C50  C4 3E 5C DD     les di, ptr [0xdd5c]
4C54  03 F8           add di, ax
4C56  03 FA           add di, dx
4C58  81 C7 5E FF     add di, 0xff5e
4C5C  06              push es
4C5D  57              push di
4C5E  6A 70           push 0x70
4C60  FF 76 FE        push word ptr [bp - 2]
4C63  9A 4B 03 AC 24  call far 24AC:034B
loc_4C68:
4C68  C9              leave
4C69  CA 06 00        retf 6

; ---- routine 1B51:4C6C  (found by: far)
sub_4C6C:
4C6C  C8 02 00 00     enter 2, 0
4C70  83 7E 0A CE     cmp word ptr [bp + 0xa], -0x32
4C74  7D 07           jge 0x4c7d
4C76  C7 46 FE 01 00  mov word ptr [bp - 2], 1
4C7B  EB 55           jmp 0x4cd2
loc_4C7D:
4C7D  83 7E 0A 00     cmp word ptr [bp + 0xa], 0
4C81  7D 07           jge 0x4c8a
4C83  C7 46 FE 02 00  mov word ptr [bp - 2], 2
4C88  EB 48           jmp 0x4cd2
loc_4C8A:
4C8A  83 7E 0A 14     cmp word ptr [bp + 0xa], 0x14
4C8E  7D 07           jge 0x4c97
4C90  C7 46 FE 03 00  mov word ptr [bp - 2], 3
4C95  EB 3B           jmp 0x4cd2
loc_4C97:
4C97  83 7E 0A 28     cmp word ptr [bp + 0xa], 0x28
4C9B  7D 07           jge 0x4ca4
4C9D  C7 46 FE 04 00  mov word ptr [bp - 2], 4
4CA2  EB 2E           jmp 0x4cd2
loc_4CA4:
4CA4  83 7E 0A 50     cmp word ptr [bp + 0xa], 0x50
4CA8  7D 07           jge 0x4cb1
4CAA  C7 46 FE 05 00  mov word ptr [bp - 2], 5
4CAF  EB 21           jmp 0x4cd2
loc_4CB1:
4CB1  81 7E 0A 96 00  cmp word ptr [bp + 0xa], 0x96
4CB6  7D 07           jge 0x4cbf
4CB8  C7 46 FE 06 00  mov word ptr [bp - 2], 6
4CBD  EB 13           jmp 0x4cd2
loc_4CBF:
4CBF  81 7E 0A 2C 01  cmp word ptr [bp + 0xa], 0x12c
4CC4  7D 07           jge 0x4ccd
4CC6  C7 46 FE 07 00  mov word ptr [bp - 2], 7
4CCB  EB 05           jmp 0x4cd2
loc_4CCD:
4CCD  C7 46 FE 08 00  mov word ptr [bp - 2], 8
loc_4CD2:
4CD2  6A 06           push 6
4CD4  8B 7E FE        mov di, word ptr [bp - 2]
4CD7  8A 85 87 12     mov al, byte ptr [di + 0x1287]
4CDB  30 E4           xor ah, ah
4CDD  8B F8           mov di, ax
4CDF  C1 E7 04        shl di, 4
4CE2  81 C7 0C 8A     add di, 0x8a0c
4CE6  1E              push ds
4CE7  57              push di
4CE8  8A 46 08        mov al, byte ptr [bp + 8]
4CEB  50              push ax
4CEC  8A 46 06        mov al, byte ptr [bp + 6]
4CEF  50              push ax
4CF0  BF 5C DD        mov di, 0xdd5c
4CF3  1E              push ds
4CF4  57              push di
4CF5  9A 1B 04 1A 23  call far 231A:041B
4CFA  8B 46 06        mov ax, word ptr [bp + 6]
4CFD  D1 E0           shl ax, 1
4CFF  8B D0           mov dx, ax
4D01  69 46 08 A0 00  imul ax, word ptr [bp + 8], 0xa0
4D06  C4 3E 5C DD     les di, ptr [0xdd5c]
4D0A  03 F8           add di, ax
4D0C  03 FA           add di, dx
4D0E  81 C7 5E FF     add di, 0xff5e
4D12  06              push es
4D13  57              push di
4D14  6A 70           push 0x70
4D16  FF 76 FE        push word ptr [bp - 2]
4D19  9A 4B 03 AC 24  call far 24AC:034B
4D1E  C9              leave
4D1F  CA 06 00        retf 6

; ---- routine 1B51:4D22  (found by: far)
sub_4D22:
4D22  C8 06 00 00     enter 6, 0
4D26  8B 46 06        mov ax, word ptr [bp + 6]
4D29  C1 E0 03        shl ax, 3
4D2C  C4 3E BA D7     les di, ptr [0xd7ba]
4D30  03 F8           add di, ax
4D32  89 7E FA        mov word ptr [bp - 6], di
4D35  8C 46 FC        mov word ptr [bp - 4], es
4D38  8B 46 06        mov ax, word ptr [bp + 6]
4D3B  C4 3E A2 D7     les di, ptr [0xd7a2]
4D3F  03 F8           add di, ax
4D41  26 8A 05        mov al, byte ptr es:[di]
4D44  30 E4           xor ah, ah
4D46  99              cdq
4D47  B9 06 00        mov cx, 6
4D4A  F7 F9           idiv cx
4D4C  92              xchg dx, ax
4D4D  8B D0           mov dx, ax
4D4F  C4 7E FA        les di, ptr [bp - 6]
4D52  26 8A 45 07     mov al, byte ptr es:[di + 7]
4D56  30 E4           xor ah, ah
4D58  8B F8           mov di, ax
4D5A  8A 85 90 12     mov al, byte ptr [di + 0x1290]
4D5E  30 E4           xor ah, ah
4D60  03 C2           add ax, dx
4D62  89 46 FE        mov word ptr [bp - 2], ax
4D65  8B 46 FE        mov ax, word ptr [bp - 2]
4D68  C9              leave
4D69  CA 02 00        retf 2

; ---- routine 1B51:4D6C  (found by: call, far)
sub_4D6C:
4D6C  C8 08 00 00     enter 8, 0
4D70  8B 46 06        mov ax, word ptr [bp + 6]
4D73  C1 E0 03        shl ax, 3
4D76  C4 3E BA D7     les di, ptr [0xd7ba]
4D7A  03 F8           add di, ax
4D7C  89 7E F8        mov word ptr [bp - 8], di
4D7F  8C 46 FA        mov word ptr [bp - 6], es
4D82  26 80 7D 01 12  cmp byte ptr es:[di + 1], 0x12
4D87  73 34           jae 0x4dbd
4D89  26 8A 45 05     mov al, byte ptr es:[di + 5]
4D8D  30 E4           xor ah, ah
4D8F  48              dec ax
4D90  89 46 FC        mov word ptr [bp - 4], ax
4D93  26 8A 45 01     mov al, byte ptr es:[di + 1]
4D97  30 E4           xor ah, ah
4D99  8B D0           mov dx, ax
4D9B  B8 12 00        mov ax, 0x12
4D9E  2B C2           sub ax, dx
4DA0  8B F0           mov si, ax
4DA2  D1 E0           shl ax, 1
4DA4  01 F0           add ax, si
4DA6  29 46 FC        sub word ptr [bp - 4], ax
4DA9  8B 46 FC        mov ax, word ptr [bp - 4]
4DAC  99              cdq
4DAD  52              push dx
4DAE  50              push ax
4DAF  6A 00           push 0
4DB1  6A 00           push 0
4DB3  9A C0 04 AC 24  call far 24AC:04C0
4DB8  88 46 FF        mov byte ptr [bp - 1], al
4DBB  EB 1D           jmp 0x4dda
loc_4DBD:
4DBD  C4 7E F8        les di, ptr [bp - 8]
4DC0  26 8A 45 03     mov al, byte ptr es:[di + 3]
4DC4  D0 E8           shr al, 1
4DC6  B0 00           mov al, 0
4DC8  73 01           jae 0x4dcb
4DCA  40              inc ax
loc_4DCB:
4DCB  30 E4           xor ah, ah
4DCD  8B D0           mov dx, ax
4DCF  26 8A 45 05     mov al, byte ptr es:[di + 5]
4DD3  30 E4           xor ah, ah
4DD5  2B C2           sub ax, dx
4DD7  88 46 FF        mov byte ptr [bp - 1], al
loc_4DDA:
4DDA  8A 46 FF        mov al, byte ptr [bp - 1]
4DDD  C9              leave
4DDE  CA 02 00        retf 2

; ---- routine 1B51:4DE1  (found by: call, far)
sub_4DE1:
4DE1  C8 06 00 00     enter 6, 0
4DE5  8B 46 06        mov ax, word ptr [bp + 6]
4DE8  C1 E0 03        shl ax, 3
4DEB  C4 3E BA D7     les di, ptr [0xd7ba]
4DEF  03 F8           add di, ax
4DF1  26 8A 45 07     mov al, byte ptr es:[di + 7]
4DF5  30 E4           xor ah, ah
4DF7  8B D8           mov bx, ax
4DF9  8B 46 06        mov ax, word ptr [bp + 6]
4DFC  31 D2           xor dx, dx
4DFE  B9 03 00        mov cx, 3
4E01  F7 F1           div cx
4E03  92              xchg dx, ax
4E04  8B F8           mov di, ax
4E06  8A 85 BA 12     mov al, byte ptr [di + 0x12ba]
4E0A  30 E4           xor ah, ah
4E0C  6B F8 0E        imul di, ax, 0xe
4E0F  03 FB           add di, bx
4E11  8A 85 9E 12     mov al, byte ptr [di + 0x129e]
4E15  88 46 FF        mov byte ptr [bp - 1], al
4E18  8A 46 FF        mov al, byte ptr [bp - 1]
4E1B  C9              leave
4E1C  CA 02 00        retf 2

; ---- routine 1B51:4E1F  (found by: far)
sub_4E1F:
4E1F  C8 08 00 00     enter 8, 0
4E23  8B 46 06        mov ax, word ptr [bp + 6]
4E26  C1 E0 03        shl ax, 3
4E29  C4 3E BA D7     les di, ptr [0xd7ba]
4E2D  03 F8           add di, ax
4E2F  26 8A 45 05     mov al, byte ptr es:[di + 5]
4E33  30 E4           xor ah, ah
4E35  8B D0           mov dx, ax
4E37  26 8A 45 03     mov al, byte ptr es:[di + 3]
4E3B  30 E4           xor ah, ah
4E3D  2B C2           sub ax, dx
4E3F  99              cdq
4E40  B9 08 00        mov cx, 8
4E43  F7 F9           idiv cx
4E45  92              xchg dx, ax
4E46  89 46 FC        mov word ptr [bp - 4], ax
4E49  26 80 7D 01 15  cmp byte ptr es:[di + 1], 0x15
4E4E  73 08           jae 0x4e58
4E50  8B 46 FC        mov ax, word ptr [bp - 4]
4E53  D1 E8           shr ax, 1
4E55  89 46 FC        mov word ptr [bp - 4], ax
loc_4E58:
4E58  8B 46 FC        mov ax, word ptr [bp - 4]
4E5B  89 46 FE        mov word ptr [bp - 2], ax
4E5E  8B 46 FE        mov ax, word ptr [bp - 2]
4E61  C9              leave
4E62  CA 02 00        retf 2

; ---- routine 1B51:4E65  (found by: call, far)
sub_4E65:
4E65  C8 06 00 00     enter 6, 0
4E69  8B 46 06        mov ax, word ptr [bp + 6]
4E6C  C1 E0 03        shl ax, 3
4E6F  C4 3E BA D7     les di, ptr [0xd7ba]
4E73  03 F8           add di, ax
4E75  89 7E FA        mov word ptr [bp - 6], di
4E78  8C 46 FC        mov word ptr [bp - 4], es
4E7B  FF 76 06        push word ptr [bp + 6]
4E7E  0E              push cs
4E7F  E8 5F FF        call 0x4de1
4E82  08 C0           or al, al
4E84  74 13           je 0x4e99
4E86  C4 7E FA        les di, ptr [bp - 6]
4E89  26 8A 45 06     mov al, byte ptr es:[di + 6]
4E8D  3C 03           cmp al, 3
4E8F  74 4C           je 0x4edd
4E91  3C 07           cmp al, 7
4E93  74 48           je 0x4edd
4E95  3C 0A           cmp al, 0xa
4E97  74 44           je 0x4edd
loc_4E99:
4E99  FF 76 06        push word ptr [bp + 6]
4E9C  0E              push cs
4E9D  E8 41 FF        call 0x4de1
4EA0  08 C0           or al, al
4EA2  75 13           jne 0x4eb7
4EA4  C4 7E FA        les di, ptr [bp - 6]
4EA7  26 8A 45 06     mov al, byte ptr es:[di + 6]
4EAB  3C 04           cmp al, 4
4EAD  74 2E           je 0x4edd
4EAF  3C 08           cmp al, 8
4EB1  74 2A           je 0x4edd
4EB3  3C 0B           cmp al, 0xb
4EB5  74 26           je 0x4edd
loc_4EB7:
4EB7  C4 7E FA        les di, ptr [bp - 6]
4EBA  26 80 7D 06 00  cmp byte ptr es:[di + 6], 0
4EBF  75 07           jne 0x4ec8
4EC1  26 80 7D 07 00  cmp byte ptr es:[di + 7], 0
4EC6  75 15           jne 0x4edd
loc_4EC8:
4EC8  C4 7E FA        les di, ptr [bp - 6]
4ECB  26 80 7D 07 00  cmp byte ptr es:[di + 7], 0
4ED0  75 07           jne 0x4ed9
4ED2  26 80 7D 06 00  cmp byte ptr es:[di + 6], 0
4ED7  75 04           jne 0x4edd
loc_4ED9:
4ED9  B0 00           mov al, 0
4EDB  EB 02           jmp 0x4edf
loc_4EDD:
4EDD  B0 01           mov al, 1
loc_4EDF:
4EDF  88 46 FF        mov byte ptr [bp - 1], al
4EE2  8A 46 FF        mov al, byte ptr [bp - 1]
4EE5  C9              leave
4EE6  CA 02 00        retf 2

