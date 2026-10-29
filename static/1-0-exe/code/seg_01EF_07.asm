; 1-0.EXE (One-Nil 96), code segment 01EF (image offsets 01EF0..06E7F), part 7 of 7
; packed 1-0.EXE sha256 89ff9c5f238f24e81a0c2440a46cdd8997280a65fc3cc3d97cb974f55280a80a (LZEXE 0.91)
; unpacked (tools/static/unlzexe.py) sha256 887ed2a92767950e5309b2052409f875668605939b69e00737aa3047022b9f51
; tool: capstone 5.0.9 (pip package; core library 5.0.1280) (CS_ARCH_X86, CS_MODE_16), recursive descent from the entry point, far calls and near calls/jumps, then routine prologues (55 89 E5 / 55 8B EC / C8 iw 00) in what remains; tools/static/listing.py
; addresses are SEGMENT:OFFSET with SEGMENT the image paragraph before relocation; image offset = SEGMENT*16+OFFSET
; ---- routine 01EF:467A  (found by: call)
sub_467A:
467A  C8 08 00 00     enter 8, 0
467E  BF 66 77        mov di, 0x7766
4681  1E              push ds
4682  57              push di
4683  BF 5C DD        mov di, 0xdd5c
4686  1E              push ds
4687  57              push di
4688  9A 2F 05 2A 23  call far 232A:052F
468D  C7 46 FE 04 00  mov word ptr [bp - 2], 4
4692  8B 7E 04        mov di, word ptr [bp + 4]
4695  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
4699  30 E4           xor ah, ah
469B  6B C0 3E        imul ax, ax, 0x3e
469E  C4 3E C2 D7     les di, ptr [0xd7c2]
46A2  03 F8           add di, ax
46A4  81 C7 C2 FF     add di, 0xffc2
46A8  89 7E F8        mov word ptr [bp - 8], di
46AB  8C 46 FA        mov word ptr [bp - 6], es
46AE  26 8A 45 37     mov al, byte ptr es:[di + 0x37]
46B2  98              cwde
46B3  8B F8           mov di, ax
46B5  8A 85 3C A2     mov al, byte ptr [di - 0x5dc4]
46B9  50              push ax
46BA  C4 7E F8        les di, ptr [bp - 8]
46BD  26 8A 45 37     mov al, byte ptr es:[di + 0x37]
46C1  98              cwde
46C2  8B F8           mov di, ax
46C4  C1 E7 04        shl di, 4
46C7  81 C7 E6 DC     add di, 0xdce6
46CB  1E              push ds
46CC  57              push di
46CD  8B 46 FE        mov ax, word ptr [bp - 2]
46D0  48              dec ax
46D1  48              dec ax
46D2  50              push ax
46D3  6A 07           push 7
46D5  BF 5C DD        mov di, 0xdd5c
46D8  1E              push ds
46D9  57              push di
46DA  9A 1B 04 2A 23  call far 232A:041B
46DF  8B 46 04        mov ax, word ptr [bp + 4]
46E2  05 0F 00        add ax, 0xf
46E5  89 46 FA        mov word ptr [bp - 6], ax
46E8  8B 46 04        mov ax, word ptr [bp + 4]
46EB  3B 46 FA        cmp ax, word ptr [bp - 6]
46EE  77 3B           ja 0x472b
46F0  89 46 FC        mov word ptr [bp - 4], ax
46F3  EB 03           jmp 0x46f8
loc_46F5:
46F5  FF 46 FC        inc word ptr [bp - 4]
loc_46F8:
46F8  8B 7E FC        mov di, word ptr [bp - 4]
46FB  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
46FF  30 E4           xor ah, ah
4701  6B C0 0C        imul ax, ax, 0xc
4704  C4 3E C6 D7     les di, ptr [0xd7c6]
4708  03 F8           add di, ax
470A  81 C7 F4 FF     add di, 0xfff4
470E  06              push es
470F  57              push di
4710  8B 7E FC        mov di, word ptr [bp - 4]
4713  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
4717  30 E4           xor ah, ah
4719  50              push ax
471A  FF 76 FE        push word ptr [bp - 2]
471D  E8 B1 FD        call 0x44d1
4720  FF 46 FE        inc word ptr [bp - 2]
4723  8B 46 FC        mov ax, word ptr [bp - 4]
4726  3B 46 FA        cmp ax, word ptr [bp - 6]
4729  75 CA           jne 0x46f5
loc_472B:
472B  C4 3E 5C DD     les di, ptr [0xdd5c]
472F  06              push es
4730  57              push di
4731  C4 3E 58 DD     les di, ptr [0xdd58]
4735  06              push es
4736  57              push di
4737  68 A0 0F        push 0xfa0
473A  9A 12 0A C9 26  call far 26C9:0A12
473F  C9              leave
4740  C2 02 00        ret 2

; ---- routine 01EF:4743  (found by: call, far)
sub_4743:
4743  C8 06 00 00     enter 6, 0
4747  C4 3E D2 D7     les di, ptr [0xd7d2]
474B  89 7E FA        mov word ptr [bp - 6], di
474E  8C 46 FC        mov word ptr [bp - 4], es
4751  26 8A 45 04     mov al, byte ptr es:[di + 4]
4755  30 E4           xor ah, ah
4757  8B F8           mov di, ax
4759  80 BD B9 DC 00  cmp byte ptr [di - 0x2347], 0
475E  75 06           jne 0x4766
4760  C6 46 FF 01     mov byte ptr [bp - 1], 1
4764  EB 24           jmp 0x478a
loc_4766:
4766  C4 7E FA        les di, ptr [bp - 6]
4769  26 8A 45 04     mov al, byte ptr es:[di + 4]
476D  30 E4           xor ah, ah
476F  8B F8           mov di, ax
4771  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
4775  30 E4           xor ah, ah
4777  6B C0 3E        imul ax, ax, 0x3e
477A  C4 3E C2 D7     les di, ptr [0xd7c2]
477E  03 F8           add di, ax
4780  26 8A 45 F9     mov al, byte ptr es:[di - 7]
4784  30 E4           xor ah, ah
4786  40              inc ax
4787  88 46 FF        mov byte ptr [bp - 1], al
loc_478A:
478A  80 7E 06 00     cmp byte ptr [bp + 6], 0
478E  74 11           je 0x47a1
4790  BF 6C 6C        mov di, 0x6c6c
4793  1E              push ds
4794  57              push di
4795  BF 5C DD        mov di, 0xdd5c
4798  1E              push ds
4799  57              push di
479A  9A 2F 05 2A 23  call far 232A:052F
479F  EB 0F           jmp 0x47b0
loc_47A1:
47A1  BF DA 4E        mov di, 0x4eda
47A4  1E              push ds
47A5  57              push di
47A6  BF 5C DD        mov di, 0xdd5c
47A9  1E              push ds
47AA  57              push di
47AB  9A 2F 05 2A 23  call far 232A:052F
loc_47B0:
47B0  8A 46 FF        mov al, byte ptr [bp - 1]
47B3  30 E4           xor ah, ah
47B5  48              dec ax
47B6  C1 E0 04        shl ax, 4
47B9  40              inc ax
47BA  50              push ax
47BB  E8 BC FE        call 0x467a
47BE  9A 00 00 E8 06  call far 06E8:0000
47C3  80 3E 88 DE 0D  cmp byte ptr [0xde88], 0xd
47C8  74 0D           je 0x47d7
47CA  80 7E 06 00     cmp byte ptr [bp + 6], 0
47CE  75 07           jne 0x47d7
47D0  C6 06 88 DE 01  mov byte ptr [0xde88], 1
47D5  EB 0C           jmp 0x47e3
loc_47D7:
47D7  8D 7E FF        lea di, [bp - 1]
47DA  16              push ss
47DB  57              push di
47DC  6A 05           push 5
47DE  9A C4 0E 2A 23  call far 232A:0EC4
loc_47E3:
47E3  80 3E 88 DE 01  cmp byte ptr [0xde88], 1
47E8  75 C6           jne 0x47b0
47EA  C9              leave
47EB  CA 02 00        retf 2

; ---- routine 01EF:47EE  (found by: call)
sub_47EE:
47EE  C8 0A 00 00     enter 0xa, 0
47F2  83 7E 06 01     cmp word ptr [bp + 6], 1
47F6  B0 00           mov al, 0
47F8  75 01           jne 0x47fb
47FA  40              inc ax
loc_47FB:
47FB  98              cwde
47FC  8B F8           mov di, ax
47FE  8A 85 BC 02     mov al, byte ptr [di + 0x2bc]
4802  30 E4           xor ah, ah
4804  89 46 FC        mov word ptr [bp - 4], ax
4807  80 3E A6 DC 00  cmp byte ptr [0xdca6], 0
480C  74 6A           je 0x4878
480E  8B 46 06        mov ax, word ptr [bp + 6]
4811  05 03 00        add ax, 3
4814  89 46 FA        mov word ptr [bp - 6], ax
4817  8B 46 06        mov ax, word ptr [bp + 6]
481A  3B 46 FA        cmp ax, word ptr [bp - 6]
481D  77 59           ja 0x4878
481F  89 46 FE        mov word ptr [bp - 2], ax
4822  EB 03           jmp 0x4827
loc_4824:
4824  FF 46 FE        inc word ptr [bp - 2]
loc_4827:
4827  8B 7E FE        mov di, word ptr [bp - 2]
482A  8A 85 AD DC     mov al, byte ptr [di - 0x2353]
482E  30 E4           xor ah, ah
4830  6B C0 0C        imul ax, ax, 0xc
4833  C4 3E B6 DC     les di, ptr [0xdcb6]
4837  03 F8           add di, ax
4839  81 C7 F4 FF     add di, 0xfff4
483D  8B 7E FE        mov di, word ptr [bp - 2]
4840  8A 85 AD DC     mov al, byte ptr [di - 0x2353]
4844  30 E4           xor ah, ah
4846  6B C0 0C        imul ax, ax, 0xc
4849  C4 3E B6 DC     les di, ptr [0xdcb6]
484D  03 F8           add di, ax
484F  81 C7 F4 FF     add di, 0xfff4
4853  06              push es
4854  57              push di
4855  8B 7E FE        mov di, word ptr [bp - 2]
4858  8A 85 AD DC     mov al, byte ptr [di - 0x2353]
485C  30 E4           xor ah, ah
485E  8B F8           mov di, ax
4860  8A 85 A5 DC     mov al, byte ptr [di - 0x235b]
4864  30 E4           xor ah, ah
4866  50              push ax
4867  FF 76 FC        push word ptr [bp - 4]
486A  E8 64 FC        call 0x44d1
486D  FF 46 FC        inc word ptr [bp - 4]
4870  8B 46 FE        mov ax, word ptr [bp - 2]
4873  3B 46 FA        cmp ax, word ptr [bp - 6]
4876  75 AC           jne 0x4824
loc_4878:
4878  C9              leave
4879  C2 04 00        ret 4

; ---- routine 01EF:487C  (found by: call)
sub_487C:
487C  55              push bp
487D  89 E5           mov bp, sp
loc_487F:
487F  BF 66 56        mov di, 0x5666
4882  1E              push ds
4883  57              push di
4884  BF 5C DD        mov di, 0xdd5c
4887  1E              push ds
4888  57              push di
4889  9A 2F 05 2A 23  call far 232A:052F
488E  6A 01           push 1
4890  55              push bp
4891  E8 5A FF        call 0x47ee
4894  6A 05           push 5
4896  55              push bp
4897  E8 54 FF        call 0x47ee
489A  80 7E 04 00     cmp byte ptr [bp + 4], 0
489E  74 0F           je 0x48af
48A0  BF DA 4E        mov di, 0x4eda
48A3  1E              push ds
48A4  57              push di
48A5  BF 5C DD        mov di, 0xdd5c
48A8  1E              push ds
48A9  57              push di
48AA  9A 2F 05 2A 23  call far 232A:052F
loc_48AF:
48AF  C4 3E 5C DD     les di, ptr [0xdd5c]
48B3  06              push es
48B4  57              push di
48B5  C4 3E 58 DD     les di, ptr [0xdd58]
48B9  06              push es
48BA  57              push di
48BB  68 A0 0F        push 0xfa0
48BE  9A 12 0A C9 26  call far 26C9:0A12
48C3  80 7E 04 00     cmp byte ptr [bp + 4], 0
48C7  75 02           jne 0x48cb
48C9  EB 0C           jmp 0x48d7
loc_48CB:
48CB  9A 00 00 E8 06  call far 06E8:0000
48D0  80 3E 88 DE 0D  cmp byte ptr [0xde88], 0xd
48D5  74 A8           je 0x487f
loc_48D7:
48D7  C9              leave
48D8  C2 02 00        ret 2

; ---- routine 01EF:48DB  (found by: far)
sub_48DB:
48DB  C8 06 00 00     enter 6, 0
48DF  C4 3E D2 D7     les di, ptr [0xd7d2]
48E3  89 7E FA        mov word ptr [bp - 6], di
48E6  8C 46 FC        mov word ptr [bp - 4], es
48E9  C6 46 FF 01     mov byte ptr [bp - 1], 1
48ED  BF E6 76        mov di, 0x76e6
48F0  1E              push ds
48F1  57              push di
48F2  BF 5C DD        mov di, 0xdd5c
48F5  1E              push ds
48F6  57              push di
48F7  9A 2F 05 2A 23  call far 232A:052F
loc_48FC:
48FC  80 7E FF 0B     cmp byte ptr [bp - 1], 0xb
4900  75 07           jne 0x4909
4902  6A 00           push 0
4904  E8 75 FF        call 0x487c
4907  EB 5D           jmp 0x4966
loc_4909:
4909  8A 46 FF        mov al, byte ptr [bp - 1]
490C  D0 E8           shr al, 1
490E  72 15           jb 0x4925
4910  8A 46 FF        mov al, byte ptr [bp - 1]
4913  30 E4           xor ah, ah
4915  8B F8           mov di, ax
4917  8A 85 C9 02     mov al, byte ptr [di + 0x2c9]
491B  50              push ax
491C  6A 00           push 0
491E  9A 31 1B E8 06  call far 06E8:1B31
4923  EB 41           jmp 0x4966
loc_4925:
4925  80 7E FF 03     cmp byte ptr [bp - 1], 3
4929  77 28           ja 0x4953
492B  80 7E FF 03     cmp byte ptr [bp - 1], 3
492F  B0 00           mov al, 0
4931  75 01           jne 0x4934
4933  40              inc ax
loc_4934:
4934  98              cwde
4935  8B F8           mov di, ax
4937  8A 85 D4 02     mov al, byte ptr [di + 0x2d4]
493B  30 E4           xor ah, ah
493D  50              push ax
493E  8A 46 FF        mov al, byte ptr [bp - 1]
4941  30 E4           xor ah, ah
4943  8B F8           mov di, ax
4945  8A 85 C9 02     mov al, byte ptr [di + 0x2c9]
4949  50              push ax
494A  6A 00           push 0
494C  9A E2 15 E8 06  call far 06E8:15E2
4951  EB 13           jmp 0x4966
loc_4953:
4953  8A 46 FF        mov al, byte ptr [bp - 1]
4956  30 E4           xor ah, ah
4958  8B F8           mov di, ax
495A  8A 85 C9 02     mov al, byte ptr [di + 0x2c9]
495E  50              push ax
495F  6A 00           push 0
4961  9A 15 16 E8 06  call far 06E8:1615
loc_4966:
4966  9A 00 00 E8 06  call far 06E8:0000
496B  A0 88 DE        mov al, byte ptr [0xde88]
496E  50              push ax
496F  9A 86 19 C9 26  call far 26C9:1986
4974  3C 4C           cmp al, 0x4c
4976  75 06           jne 0x497e
4978  C6 46 FF 01     mov byte ptr [bp - 1], 1
497C  EB 26           jmp 0x49a4
loc_497E:
497E  3C 46           cmp al, 0x46
4980  75 06           jne 0x4988
4982  C6 46 FF 03     mov byte ptr [bp - 1], 3
4986  EB 1C           jmp 0x49a4
loc_4988:
4988  3C 55           cmp al, 0x55
498A  75 06           jne 0x4992
498C  C6 46 FF 05     mov byte ptr [bp - 1], 5
4990  EB 12           jmp 0x49a4
loc_4992:
4992  3C 43           cmp al, 0x43
4994  75 06           jne 0x499c
4996  C6 46 FF 07     mov byte ptr [bp - 1], 7
499A  EB 08           jmp 0x49a4
loc_499C:
499C  3C 45           cmp al, 0x45
499E  75 04           jne 0x49a4
49A0  C6 46 FF 09     mov byte ptr [bp - 1], 9
loc_49A4:
49A4  8D 7E FF        lea di, [bp - 1]
49A7  16              push ss
49A8  57              push di
49A9  6A 0B           push 0xb
49AB  9A C4 0E 2A 23  call far 232A:0EC4
loc_49B0:
49B0  8A 46 FF        mov al, byte ptr [bp - 1]
49B3  30 E4           xor ah, ah
49B5  8B F8           mov di, ax
49B7  8A 85 BD 02     mov al, byte ptr [di + 0x2bd]
49BB  C4 7E FA        les di, ptr [bp - 6]
49BE  26 3A 05        cmp al, byte ptr es:[di]
49C1  76 1F           jbe 0x49e2
49C3  A0 88 DE        mov al, byte ptr [0xde88]
49C6  3C 0A           cmp al, 0xa
49C8  74 04           je 0x49ce
49CA  3C 0C           cmp al, 0xc
49CC  75 06           jne 0x49d4
loc_49CE:
49CE  C6 46 FF 01     mov byte ptr [bp - 1], 1
49D2  EB 0C           jmp 0x49e0
loc_49D4:
49D4  8D 7E FF        lea di, [bp - 1]
49D7  16              push ss
49D8  57              push di
49D9  6A 0B           push 0xb
49DB  9A C4 0E 2A 23  call far 232A:0EC4
loc_49E0:
49E0  EB CE           jmp 0x49b0
loc_49E2:
49E2  80 3E 88 DE 01  cmp byte ptr [0xde88], 1
49E7  74 03           je 0x49ec
49E9  E9 10 FF        jmp 0x48fc
loc_49EC:
49EC  C9              leave
49ED  CB              retf

; ---- routine 01EF:49EE  (found by: far)
sub_49EE:
49EE  C8 08 00 00     enter 8, 0
49F2  BF 12 4E        mov di, 0x4e12
49F5  1E              push ds
49F6  57              push di
49F7  BF 5C DD        mov di, 0xdd5c
49FA  1E              push ds
49FB  57              push di
49FC  9A 2F 05 2A 23  call far 232A:052F
4A01  C7 46 FC 05 00  mov word ptr [bp - 4], 5
4A06  8B 7E 06        mov di, word ptr [bp + 6]
4A09  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
4A0D  30 E4           xor ah, ah
4A0F  6B C0 3E        imul ax, ax, 0x3e
4A12  C4 3E C2 D7     les di, ptr [0xd7c2]
4A16  03 F8           add di, ax
4A18  81 C7 C2 FF     add di, 0xffc2
4A1C  89 7E F8        mov word ptr [bp - 8], di
4A1F  8C 46 FA        mov word ptr [bp - 6], es
4A22  26 8A 45 37     mov al, byte ptr es:[di + 0x37]
4A26  98              cwde
4A27  8B F8           mov di, ax
4A29  8A 85 3C A2     mov al, byte ptr [di - 0x5dc4]
4A2D  50              push ax
4A2E  C4 7E F8        les di, ptr [bp - 8]
4A31  26 8A 45 37     mov al, byte ptr es:[di + 0x37]
4A35  98              cwde
4A36  8B F8           mov di, ax
4A38  C1 E7 04        shl di, 4
4A3B  81 C7 E6 DC     add di, 0xdce6
4A3F  1E              push ds
4A40  57              push di
4A41  8B 46 FC        mov ax, word ptr [bp - 4]
4A44  48              dec ax
4A45  48              dec ax
4A46  50              push ax
4A47  6A 03           push 3
4A49  BF 5C DD        mov di, 0xdd5c
4A4C  1E              push ds
4A4D  57              push di
4A4E  9A 1B 04 2A 23  call far 232A:041B
4A53  8B 46 06        mov ax, word ptr [bp + 6]
4A56  05 0F 00        add ax, 0xf
4A59  89 46 FA        mov word ptr [bp - 6], ax
4A5C  8B 46 06        mov ax, word ptr [bp + 6]
4A5F  3B 46 FA        cmp ax, word ptr [bp - 6]
4A62  77 27           ja 0x4a8b
4A64  89 46 FE        mov word ptr [bp - 2], ax
4A67  EB 03           jmp 0x4a6c
loc_4A69:
4A69  FF 46 FE        inc word ptr [bp - 2]
loc_4A6C:
4A6C  8B 7E FE        mov di, word ptr [bp - 2]
4A6F  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
4A73  30 E4           xor ah, ah
4A75  50              push ax
4A76  FF 76 FC        push word ptr [bp - 4]
4A79  6A 03           push 3
4A7B  9A E3 0E 55 1B  call far 1B55:0EE3
4A80  FF 46 FC        inc word ptr [bp - 4]
4A83  8B 46 FE        mov ax, word ptr [bp - 2]
4A86  3B 46 FA        cmp ax, word ptr [bp - 6]
4A89  75 DE           jne 0x4a69
loc_4A8B:
4A8B  C9              leave
4A8C  CA 02 00        retf 2

; ---- routine 01EF:4A8F  (found by: call)
sub_4A8F:
4A8F  55              push bp
4A90  89 E5           mov bp, sp
4A92  80 7E 06 00     cmp byte ptr [bp + 6], 0
4A96  74 0A           je 0x4aa2
4A98  FF 76 08        push word ptr [bp + 8]
4A9B  6A 06           push 6
4A9D  9A 84 13 E8 06  call far 06E8:1384
loc_4AA2:
4AA2  FF 76 08        push word ptr [bp + 8]
4AA5  6A 07           push 7
4AA7  9A 84 13 E8 06  call far 06E8:1384
4AAC  FF 76 08        push word ptr [bp + 8]
4AAF  6A 08           push 8
4AB1  9A 84 13 E8 06  call far 06E8:1384
4AB6  8A 46 08        mov al, byte ptr [bp + 8]
4AB9  3C 0A           cmp al, 0xa
4ABB  72 0C           jb 0x4ac9
4ABD  3C 16           cmp al, 0x16
4ABF  77 08           ja 0x4ac9
4AC1  FF 76 08        push word ptr [bp + 8]
4AC4  9A 6D 3D 55 1B  call far 1B55:3D6D
loc_4AC9:
4AC9  C9              leave
4ACA  C2 06 00        ret 6

; ---- routine 01EF:4ACD  (found by: call)
sub_4ACD:
4ACD  C8 0A 00 00     enter 0xa, 0
4AD1  C4 3E D2 D7     les di, ptr [0xd7d2]
4AD5  89 7E F8        mov word ptr [bp - 8], di
4AD8  8C 46 FA        mov word ptr [bp - 6], es
4ADB  26 8A 05        mov al, byte ptr es:[di]
4ADE  30 E4           xor ah, ah
4AE0  8B F8           mov di, ax
4AE2  80 BD 6A A2 00  cmp byte ptr [di - 0x5d96], 0
4AE7  74 03           je 0x4aec
4AE9  E9 80 00        jmp 0x4b6c
loc_4AEC:
4AEC  E8 61 F9        call 0x4450
4AEF  C4 7E F8        les di, ptr [bp - 8]
4AF2  26 8A 45 03     mov al, byte ptr es:[di + 3]
4AF6  30 E4           xor ah, ah
4AF8  89 46 F6        mov word ptr [bp - 0xa], ax
4AFB  B8 01 00        mov ax, 1
4AFE  3B 46 F6        cmp ax, word ptr [bp - 0xa]
4B01  77 67           ja 0x4b6a
4B03  89 46 FC        mov word ptr [bp - 4], ax
4B06  EB 03           jmp 0x4b0b
loc_4B08:
4B08  FF 46 FC        inc word ptr [bp - 4]
loc_4B0B:
4B0B  8B 7E FC        mov di, word ptr [bp - 4]
4B0E  80 BD B9 DC 00  cmp byte ptr [di - 0x2347], 0
4B13  74 4D           je 0x4b62
4B15  8A 46 FC        mov al, byte ptr [bp - 4]
4B18  C4 7E F8        les di, ptr [bp - 8]
4B1B  26 88 45 04     mov byte ptr es:[di + 4], al
4B1F  83 7E FC 01     cmp word ptr [bp - 4], 1
4B23  74 28           je 0x4b4d
4B25  A0 BB DC        mov al, byte ptr [0xdcbb]
4B28  30 E4           xor ah, ah
4B2A  6B C0 3E        imul ax, ax, 0x3e
4B2D  C4 3E C2 D7     les di, ptr [0xd7c2]
4B31  03 F8           add di, ax
4B33  26 8A 55 F9     mov dl, byte ptr es:[di - 7]
4B37  A0 BA DC        mov al, byte ptr [0xdcba]
4B3A  30 E4           xor ah, ah
4B3C  6B C0 3E        imul ax, ax, 0x3e
4B3F  C4 3E C2 D7     les di, ptr [0xd7c2]
4B43  03 F8           add di, ax
4B45  26 8A 45 F9     mov al, byte ptr es:[di - 7]
4B49  3A C2           cmp al, dl
4B4B  74 15           je 0x4b62
loc_4B4D:
4B4D  C4 7E F8        les di, ptr [bp - 8]
4B50  26 8A 05        mov al, byte ptr es:[di]
4B53  30 E4           xor ah, ah
4B55  50              push ax
4B56  6A 01           push 1
4B58  0E              push cs
4B59  E8 87 F3        call 0x3ee3
4B5C  6A 00           push 0
4B5E  0E              push cs
4B5F  E8 E1 FB        call 0x4743
loc_4B62:
4B62  8B 46 FC        mov ax, word ptr [bp - 4]
4B65  3B 46 F6        cmp ax, word ptr [bp - 0xa]
4B68  75 9E           jne 0x4b08
loc_4B6A:
4B6A  EB 15           jmp 0x4b81
loc_4B6C:
4B6C  C4 7E F8        les di, ptr [bp - 8]
4B6F  26 8A 05        mov al, byte ptr es:[di]
4B72  30 E4           xor ah, ah
4B74  50              push ax
4B75  9A 98 17 55 1B  call far 1B55:1798
4B7A  08 C0           or al, al
4B7C  74 03           je 0x4b81
4B7E  E8 6B F6        call 0x41ec
loc_4B81:
4B81  C4 7E F8        les di, ptr [bp - 8]
4B84  26 8A 05        mov al, byte ptr es:[di]
4B87  30 E4           xor ah, ah
4B89  8B F8           mov di, ax
4B8B  80 BD 6A A2 03  cmp byte ptr [di - 0x5d96], 3
4B90  75 26           jne 0x4bb8
4B92  C4 7E F8        les di, ptr [bp - 8]
4B95  26 80 3D 0E     cmp byte ptr es:[di], 0xe
4B99  73 11           jae 0x4bac
4B9B  26 8A 05        mov al, byte ptr es:[di]
4B9E  30 E4           xor ah, ah
4BA0  50              push ax
4BA1  6A 03           push 3
4BA3  6A 01           push 1
4BA5  9A E2 15 E8 06  call far 06E8:15E2
4BAA  EB 09           jmp 0x4bb5
loc_4BAC:
4BAC  6A 03           push 3
4BAE  6A 01           push 1
4BB0  9A 31 1B E8 06  call far 06E8:1B31
loc_4BB5:
4BB5  E9 CA 00        jmp 0x4c82
loc_4BB8:
4BB8  C4 7E F8        les di, ptr [bp - 8]
4BBB  26 8A 05        mov al, byte ptr es:[di]
4BBE  30 E4           xor ah, ah
4BC0  8B F8           mov di, ax
4BC2  80 BD 6A A2 04  cmp byte ptr [di - 0x5d96], 4
4BC7  75 26           jne 0x4bef
4BC9  C4 7E F8        les di, ptr [bp - 8]
4BCC  26 80 3D 1D     cmp byte ptr es:[di], 0x1d
4BD0  73 11           jae 0x4be3
4BD2  26 8A 05        mov al, byte ptr es:[di]
4BD5  30 E4           xor ah, ah
4BD7  50              push ax
4BD8  6A 04           push 4
4BDA  6A 01           push 1
4BDC  9A E2 15 E8 06  call far 06E8:15E2
4BE1  EB 09           jmp 0x4bec
loc_4BE3:
4BE3  6A 04           push 4
4BE5  6A 01           push 1
4BE7  9A 31 1B E8 06  call far 06E8:1B31
loc_4BEC:
4BEC  E9 93 00        jmp 0x4c82
loc_4BEF:
4BEF  C4 7E F8        les di, ptr [bp - 8]
4BF2  26 8A 05        mov al, byte ptr es:[di]
4BF5  30 E4           xor ah, ah
4BF7  8B F8           mov di, ax
4BF9  80 BD 6A A2 05  cmp byte ptr [di - 0x5d96], 5
4BFE  74 03           je 0x4c03
4C00  E9 7F 00        jmp 0x4c82
loc_4C03:
4C03  C4 7E F8        les di, ptr [bp - 8]
4C06  26 80 3D 14     cmp byte ptr es:[di], 0x14
4C0A  73 1C           jae 0x4c28
4C0C  C6 46 FF 06     mov byte ptr [bp - 1], 6
4C10  EB 03           jmp 0x4c15
loc_4C12:
4C12  FE 46 FF        inc byte ptr [bp - 1]
loc_4C15:
4C15  8A 46 FF        mov al, byte ptr [bp - 1]
4C18  50              push ax
4C19  6A 01           push 1
4C1B  9A 15 16 E8 06  call far 06E8:1615
4C20  80 7E FF 08     cmp byte ptr [bp - 1], 8
4C24  75 EC           jne 0x4c12
4C26  EB 5A           jmp 0x4c82
loc_4C28:
4C28  C4 7E F8        les di, ptr [bp - 8]
4C2B  26 80 3D 39     cmp byte ptr es:[di], 0x39
4C2F  75 0B           jne 0x4c3c
4C31  6A 06           push 6
4C33  6A 01           push 1
4C35  9A 31 1B E8 06  call far 06E8:1B31
4C3A  EB 46           jmp 0x4c82
loc_4C3C:
4C3C  C6 46 FF 06     mov byte ptr [bp - 1], 6
4C40  EB 03           jmp 0x4c45
loc_4C42:
4C42  FE 46 FF        inc byte ptr [bp - 1]
loc_4C45:
4C45  80 7E FF 07     cmp byte ptr [bp - 1], 7
4C49  75 09           jne 0x4c54
4C4B  C4 7E F8        les di, ptr [bp - 8]
4C4E  26 80 3D 30     cmp byte ptr es:[di], 0x30
4C52  77 28           ja 0x4c7c
loc_4C54:
4C54  8A 46 FF        mov al, byte ptr [bp - 1]
4C57  50              push ax
4C58  6A 01           push 1
4C5A  9A 31 1B E8 06  call far 06E8:1B31
4C5F  80 7E FF 06     cmp byte ptr [bp - 1], 6
4C63  75 17           jne 0x4c7c
4C65  C4 7E F8        les di, ptr [bp - 8]
4C68  26 8A 05        mov al, byte ptr es:[di]
4C6B  30 E4           xor ah, ah
4C6D  50              push ax
4C6E  9A 98 17 55 1B  call far 1B55:1798
4C73  08 C0           or al, al
4C75  74 05           je 0x4c7c
4C77  6A 01           push 1
4C79  E8 00 FC        call 0x487c
loc_4C7C:
4C7C  80 7E FF 08     cmp byte ptr [bp - 1], 8
4C80  75 C0           jne 0x4c42
loc_4C82:
4C82  C9              leave
4C83  C2 02 00        ret 2
; data (not reached as code), 130 bytes
4C86                  pstr 'TO CONTINUE PLAYING YOU MUST REGISTER THIS GAME'
4CB6                  pstr 'Do you want to save the full seasonal information'
4CE8                  db 00 02 04 82 20 08 21 02 00 00 00 00 00 00 00 00   ; .... .!.........
4CF8                  db 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00   ; ................

; ---- routine 01EF:4D08  (found by: far)
sub_4D08:
4D08  C8 08 00 00     enter 8, 0
4D0C  C4 3E D2 D7     les di, ptr [0xd7d2]
4D10  89 7E F8        mov word ptr [bp - 8], di
4D13  8C 46 FA        mov word ptr [bp - 6], es
4D16  9A 85 00 2A 23  call far 232A:0085
4D1B  C4 7E F8        les di, ptr [bp - 8]
4D1E  26 C6 45 04 01  mov byte ptr es:[di + 4], 1
4D23  26 FE 05        inc byte ptr es:[di]
4D26  26 8A 05        mov al, byte ptr es:[di]
4D29  30 E4           xor ah, ah
4D2B  8B F8           mov di, ax
4D2D  80 BD 6A A2 00  cmp byte ptr [di - 0x5d96], 0
4D32  75 24           jne 0x4d58
4D34  C4 7E F8        les di, ptr [bp - 8]
4D37  81 C7 30 00     add di, 0x30
4D3B  06              push es
4D3C  57              push di
4D3D  6A 14           push 0x14
4D3F  6A 00           push 0
4D41  9A 22 02 BC 24  call far 24BC:0222
4D46  C4 7E F8        les di, ptr [bp - 8]
4D49  81 C7 44 00     add di, 0x44
4D4D  06              push es
4D4E  57              push di
4D4F  6A 14           push 0x14
4D51  6A 00           push 0
4D53  9A 22 02 BC 24  call far 24BC:0222
loc_4D58:
4D58  C4 7E F8        les di, ptr [bp - 8]
4D5B  26 8A 05        mov al, byte ptr es:[di]
4D5E  30 E4           xor ah, ah
4D60  50              push ax
4D61  9A B6 EA B9 0A  call far 0AB9:EAB6
4D66  55              push bp
4D67  E8 63 FD        call 0x4acd
4D6A  C4 7E F8        les di, ptr [bp - 8]
4D6D  26 8A 05        mov al, byte ptr es:[di]
4D70  30 E4           xor ah, ah
4D72  8B F8           mov di, ax
4D74  8A 85 6A A2     mov al, byte ptr [di - 0x5d96]
4D78  3C 03           cmp al, 3
4D7A  72 35           jb 0x4db1
4D7C  3C 04           cmp al, 4
4D7E  77 31           ja 0x4db1
4D80  C4 7E F8        les di, ptr [bp - 8]
4D83  26 80 3D 25     cmp byte ptr es:[di], 0x25
4D87  74 28           je 0x4db1
4D89  26 80 3D 33     cmp byte ptr es:[di], 0x33
4D8D  74 22           je 0x4db1
4D8F  26 8A 05        mov al, byte ptr es:[di]
4D92  30 E4           xor ah, ah
4D94  50              push ax
4D95  9A 6A 10 E8 06  call far 06E8:106A
4D9A  50              push ax
4D9B  C4 7E F8        les di, ptr [bp - 8]
4D9E  26 8A 05        mov al, byte ptr es:[di]
4DA1  30 E4           xor ah, ah
4DA3  8B F8           mov di, ax
4DA5  8A 85 6A A2     mov al, byte ptr [di - 0x5d96]
4DA9  50              push ax
4DAA  9A D1 0A E8 06  call far 06E8:0AD1
4DAF  EB 5E           jmp 0x4e0f
loc_4DB1:
4DB1  C4 7E F8        les di, ptr [bp - 8]
4DB4  26 80 3D 0C     cmp byte ptr es:[di], 0xc
4DB8  75 0A           jne 0x4dc4
4DBA  6A 14           push 0x14
4DBC  6A 01           push 1
4DBE  55              push bp
4DBF  E8 CD FC        call 0x4a8f
4DC2  EB 4B           jmp 0x4e0f
loc_4DC4:
4DC4  C4 7E F8        les di, ptr [bp - 8]
4DC7  26 80 3D 16     cmp byte ptr es:[di], 0x16
4DCB  75 0A           jne 0x4dd7
4DCD  6A 1B           push 0x1b
4DCF  6A 01           push 1
4DD1  55              push bp
4DD2  E8 BA FC        call 0x4a8f
4DD5  EB 38           jmp 0x4e0f
loc_4DD7:
4DD7  C4 7E F8        les di, ptr [bp - 8]
4DDA  26 80 3D 21     cmp byte ptr es:[di], 0x21
4DDE  75 0A           jne 0x4dea
4DE0  6A 27           push 0x27
4DE2  6A 00           push 0
4DE4  55              push bp
4DE5  E8 A7 FC        call 0x4a8f
4DE8  EB 25           jmp 0x4e0f
loc_4DEA:
4DEA  C4 7E F8        les di, ptr [bp - 8]
4DED  26 80 3D 2B     cmp byte ptr es:[di], 0x2b
4DF1  75 0A           jne 0x4dfd
4DF3  6A 30           push 0x30
4DF5  6A 00           push 0
4DF7  55              push bp
4DF8  E8 94 FC        call 0x4a8f
4DFB  EB 12           jmp 0x4e0f
loc_4DFD:
4DFD  C4 7E F8        les di, ptr [bp - 8]
4E00  26 80 3D 35     cmp byte ptr es:[di], 0x35
4E04  75 09           jne 0x4e0f
4E06  6A 39           push 0x39
4E08  6A 06           push 6
4E0A  9A 84 13 E8 06  call far 06E8:1384
loc_4E0F:
4E0F  9A 7E 06 E8 06  call far 06E8:067E
4E14  C7 46 FE 01 00  mov word ptr [bp - 2], 1
4E19  EB 03           jmp 0x4e1e
loc_4E1B:
4E1B  FF 46 FE        inc word ptr [bp - 2]
loc_4E1E:
4E1E  FF 76 FE        push word ptr [bp - 2]
4E21  9A B1 16 98 19  call far 1998:16B1
4E26  83 7E FE 02     cmp word ptr [bp - 2], 2
4E2A  75 EF           jne 0x4e1b
4E2C  9A FA 15 98 19  call far 1998:15FA
4E31  E8 7E B3        call 0x1b2
4E34  9A 1D 3A E8 06  call far 06E8:3A1D
4E39  C7 46 FE 01 00  mov word ptr [bp - 2], 1
4E3E  EB 03           jmp 0x4e43
loc_4E40:
4E40  FF 46 FE        inc word ptr [bp - 2]
loc_4E43:
4E43  FF 76 FE        push word ptr [bp - 2]
4E46  9A B5 36 55 1B  call far 1B55:36B5
4E4B  08 C0           or al, al
4E4D  74 08           je 0x4e57
4E4F  FF 76 FE        push word ptr [bp - 2]
4E52  9A 8A 37 55 1B  call far 1B55:378A
loc_4E57:
4E57  83 7E FE 02     cmp word ptr [bp - 2], 2
4E5B  75 E3           jne 0x4e40
4E5D  C4 7E F8        les di, ptr [bp - 8]
4E60  26 8A 05        mov al, byte ptr es:[di]
4E63  30 E4           xor ah, ah
4E65  99              cdq
4E66  B9 06 00        mov cx, 6
4E69  F7 F9           idiv cx
4E6B  92              xchg dx, ax
4E6C  09 C0           or ax, ax
4E6E  75 05           jne 0x4e75
4E70  9A 74 6E 55 1B  call far 1B55:6E74
loc_4E75:
4E75  C4 7E F8        les di, ptr [bp - 8]
4E78  26 80 3D 3A     cmp byte ptr es:[di], 0x3a
4E7C  75 31           jne 0x4eaf
4E7E  BF B6 4C        mov di, 0x4cb6
4E81  0E              push cs
4E82  57              push di
4E83  9A E5 06 2A 23  call far 232A:06E5
4E88  08 C0           or al, al
4E8A  74 05           je 0x4e91
4E8C  9A 91 79 55 1B  call far 1B55:7991
loc_4E91:
4E91  C7 46 FE 01 00  mov word ptr [bp - 2], 1
4E96  EB 03           jmp 0x4e9b
loc_4E98:
4E98  FF 46 FE        inc word ptr [bp - 2]
loc_4E9B:
4E9B  FF 76 FE        push word ptr [bp - 2]
4E9E  E8 2D DB        call 0x29ce
4EA1  83 7E FE 02     cmp word ptr [bp - 2], 2
4EA5  75 F1           jne 0x4e98
4EA7  E8 53 D7        call 0x25fd
4EAA  E8 24 DE        call 0x2cd1
4EAD  EB 16           jmp 0x4ec5
loc_4EAF:
4EAF  C7 46 FE 01 00  mov word ptr [bp - 2], 1
4EB4  EB 03           jmp 0x4eb9
loc_4EB6:
4EB6  FF 46 FE        inc word ptr [bp - 2]
loc_4EB9:
4EB9  FF 76 FE        push word ptr [bp - 2]
4EBC  E8 0F DB        call 0x29ce
4EBF  83 7E FE 02     cmp word ptr [bp - 2], 2
4EC3  75 F1           jne 0x4eb6
loc_4EC5:
4EC5  E8 9E EB        call 0x3a66
4EC8  C4 7E F8        les di, ptr [bp - 8]
4ECB  26 8A 05        mov al, byte ptr es:[di]
4ECE  B4 01           mov ah, 1
4ED0  BA 20 00        mov dx, 0x20
4ED3  9A 1F 0E C9 26  call far 26C9:0E1F
4ED8  8B FA           mov di, dx
4EDA  2E 84 85 E8 4C  test byte ptr cs:[di + 0x4ce8], al
4EDF  74 17           je 0x4ef8
4EE1  9A 64 71 55 1B  call far 1B55:7164
4EE6  C4 7E F8        les di, ptr [bp - 8]
4EE9  26 80 3D 09     cmp byte ptr es:[di], 9
4EED  76 09           jbe 0x4ef8
4EEF  26 80 3D 30     cmp byte ptr es:[di], 0x30
4EF3  73 03           jae 0x4ef8
4EF5  E8 AE E8        call 0x37a6
loc_4EF8:
4EF8  C4 7E F8        les di, ptr [bp - 8]
4EFB  26 C6 45 04 01  mov byte ptr es:[di + 4], 1
4F00  C7 46 FE 01 00  mov word ptr [bp - 2], 1
4F05  EB 03           jmp 0x4f0a
loc_4F07:
4F07  FF 46 FE        inc word ptr [bp - 2]
loc_4F0A:
4F0A  A0 BA DC        mov al, byte ptr [0xdcba]
4F0D  30 E4           xor ah, ah
4F0F  3B 46 FE        cmp ax, word ptr [bp - 2]
4F12  74 52           je 0x4f66
4F14  A0 BB DC        mov al, byte ptr [0xdcbb]
4F17  30 E4           xor ah, ah
4F19  3B 46 FE        cmp ax, word ptr [bp - 2]
4F1C  74 48           je 0x4f66
4F1E  C4 7E F8        les di, ptr [bp - 8]
4F21  26 8A 05        mov al, byte ptr es:[di]
4F24  30 E4           xor ah, ah
4F26  40              inc ax
4F27  8B F0           mov si, ax
4F29  D1 E0           shl ax, 1
4F2B  01 F0           add ax, si
4F2D  8B D0           mov dx, ax
4F2F  69 46 FE AE 00  imul ax, word ptr [bp - 2], 0xae
4F34  C4 3E CA D7     les di, ptr [0xd7ca]
4F38  03 F8           add di, ax
4F3A  03 FA           add di, dx
4F3C  26 8A 85 4F FF  mov al, byte ptr es:[di - 0xb1]
4F41  3C 03           cmp al, 3
4F43  72 1D           jb 0x4f62
4F45  3C 04           cmp al, 4
4F47  76 04           jbe 0x4f4d
4F49  3C 06           cmp al, 6
4F4B  75 15           jne 0x4f62
loc_4F4D:
4F4D  C4 7E F8        les di, ptr [bp - 8]
4F50  26 8A 05        mov al, byte ptr es:[di]
4F53  30 E4           xor ah, ah
4F55  40              inc ax
4F56  3C 25           cmp al, 0x25
4F58  74 0C           je 0x4f66
4F5A  3C 33           cmp al, 0x33
4F5C  74 08           je 0x4f66
4F5E  3C 39           cmp al, 0x39
4F60  74 04           je 0x4f66
loc_4F62:
4F62  B0 00           mov al, 0
4F64  EB 02           jmp 0x4f68
loc_4F66:
4F66  B0 01           mov al, 1
loc_4F68:
4F68  8A D0           mov dl, al
4F6A  6B 46 FE 3E     imul ax, word ptr [bp - 2], 0x3e
4F6E  C4 3E C2 D7     les di, ptr [0xd7c2]
4F72  03 F8           add di, ax
4F74  26 88 55 FC     mov byte ptr es:[di - 4], dl
4F78  81 7E FE B0 00  cmp word ptr [bp - 2], 0xb0
4F7D  75 88           jne 0x4f07
4F7F  C9              leave
4F80  CB              retf
; data (not reached as code), 15 bytes
4F81                  db 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00   ; ...............
