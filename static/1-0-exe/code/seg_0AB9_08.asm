; 1-0.EXE (One-Nil 96), code segment 0AB9 (image offsets 0AB90..1997F), part 8 of 22
; packed 1-0.EXE sha256 89ff9c5f238f24e81a0c2440a46cdd8997280a65fc3cc3d97cb974f55280a80a (LZEXE 0.91)
; unpacked (tools/static/unlzexe.py) sha256 887ed2a92767950e5309b2052409f875668605939b69e00737aa3047022b9f51
; tool: capstone 5.0.9 (pip package; core library 5.0.1280) (CS_ARCH_X86, CS_MODE_16), recursive descent from the entry point, far calls and near calls/jumps, then routine prologues (55 89 E5 / 55 8B EC / C8 iw 00) in what remains; tools/static/listing.py
; addresses are SEGMENT:OFFSET with SEGMENT the image paragraph before relocation; image offset = SEGMENT*16+OFFSET
; ---- routine 0AB9:46D4  (found by: call)
sub_46D4:
46D4  C8 02 00 00     enter 2, 0
46D8  80 3E B8 D0 00  cmp byte ptr [0xd0b8], 0
46DD  75 07           jne 0x46e6
46DF  80 3E B7 D0 00  cmp byte ptr [0xd0b7], 0
46E4  74 60           je 0x4746
loc_46E6:
46E6  C6 46 FF 00     mov byte ptr [bp - 1], 0
46EA  A0 9F D0        mov al, byte ptr [0xd09f]
46ED  30 E4           xor ah, ah
46EF  50              push ax
46F0  E8 0D B9        call 0
46F3  08 C0           or al, al
46F5  75 07           jne 0x46fe
46F7  83 3E 51 CF 00  cmp word ptr [0xcf51], 0
46FC  75 02           jne 0x4700
loc_46FE:
46FE  EB 46           jmp 0x4746
loc_4700:
4700  A0 47 CF        mov al, byte ptr [0xcf47]
4703  98              cwde
4704  99              cdq
4705  31 D0           xor ax, dx
4707  29 D0           sub ax, dx
4709  3D 25 00        cmp ax, 0x25
470C  75 38           jne 0x4746
470E  A0 46 CF        mov al, byte ptr [0xcf46]
4711  98              cwde
4712  99              cdq
4713  31 D0           xor ax, dx
4715  29 D0           sub ax, dx
4717  3D 01 00        cmp ax, 1
471A  7F 2A           jg 0x4746
471C  A0 46 CF        mov al, byte ptr [0xcf46]
471F  98              cwde
4720  99              cdq
4721  31 D0           xor ax, dx
4723  29 D0           sub ax, dx
4725  09 C0           or ax, ax
4727  74 0F           je 0x4738
4729  6A 04           push 4
472B  9A 1C 0D BC 24  call far 24BC:0D1C
4730  08 C0           or al, al
4732  75 04           jne 0x4738
4734  B0 00           mov al, 0
4736  EB 02           jmp 0x473a
loc_4738:
4738  B0 01           mov al, 1
loc_473A:
473A  98              cwde
473B  8B F8           mov di, ax
473D  8A 85 96 0A     mov al, byte ptr [di + 0xa96]
4741  50              push ax
4742  55              push bp
4743  E8 1F FF        call 0x4665
loc_4746:
4746  8A 46 FF        mov al, byte ptr [bp - 1]
4749  C9              leave
474A  C3              ret

; ---- routine 0AB9:474B  (found by: call)
sub_474B:
474B  55              push bp
474C  89 E5           mov bp, sp
474E  8B 7E 04        mov di, word ptr [bp + 4]
4751  36 C4 7D 06     les di, ptr ss:[di + 6]
4755  26 8A 45 07     mov al, byte ptr es:[di + 7]
4759  A2 9F D0        mov byte ptr [0xd09f], al
475C  8A 46 06        mov al, byte ptr [bp + 6]
475F  50              push ax
4760  E8 54 D6        call 0x1db7
4763  80 3E B9 D0 00  cmp byte ptr [0xd0b9], 0
4768  75 17           jne 0x4781
476A  8B 7E 04        mov di, word ptr [bp + 4]
476D  36 C4 7D 06     les di, ptr ss:[di + 6]
4771  06              push es
4772  57              push di
4773  0E              push cs
4774  E8 44 D5        call 0x1cbb
4777  98              cwde
4778  6B F8 0A        imul di, ax, 0xa
477B  FE 85 D7 D0     inc byte ptr [di - 0x2f29]
477F  EB 0A           jmp 0x478b
loc_4781:
4781  8B 7E 04        mov di, word ptr [bp + 4]
4784  36 8A 45 FE     mov al, byte ptr ss:[di - 2]
4788  A2 9F D0        mov byte ptr [0xd09f], al
loc_478B:
478B  C6 06 B7 D0 00  mov byte ptr [0xd0b7], 0
4790  C9              leave
4791  C2 04 00        ret 4

; ---- routine 0AB9:4794  (found by: call)
sub_4794:
4794  55              push bp
4795  89 E5           mov bp, sp
4797  80 3E B9 D0 00  cmp byte ptr [0xd0b9], 0
479C  74 07           je 0x47a5
479E  31 C0           xor ax, ax
47A0  A3 51 CF        mov word ptr [0xcf51], ax
47A3  EB 0D           jmp 0x47b2
loc_47A5:
47A5  8B 7E 04        mov di, word ptr [bp + 4]
47A8  36 C4 7D 06     les di, ptr ss:[di + 6]
47AC  06              push es
47AD  57              push di
47AE  0E              push cs
47AF  E8 BC 27        call 0x6f6e
loc_47B2:
47B2  6A 1D           push 0x1d
47B4  8B 7E 04        mov di, word ptr [bp + 4]
47B7  57              push di
47B8  E8 90 FF        call 0x474b
47BB  8B 7E 04        mov di, word ptr [bp + 4]
47BE  36 C4 7D 06     les di, ptr ss:[di + 6]
47C2  26 FF 35        push word ptr es:[di]
47C5  06              push es
47C6  57              push di
47C7  0E              push cs
47C8  E8 2A D9        call 0x20f5
47CB  08 C0           or al, al
47CD  74 0F           je 0x47de
47CF  8B 7E 04        mov di, word ptr [bp + 4]
47D2  36 C4 7D 06     les di, ptr ss:[di + 6]
47D6  06              push es
47D7  57              push di
47D8  0E              push cs
47D9  E8 45 F3        call 0x3b21
47DC  EB 0F           jmp 0x47ed
loc_47DE:
47DE  6A 09           push 9
47E0  8B 7E 04        mov di, word ptr [bp + 4]
47E3  36 C4 7D 06     les di, ptr ss:[di + 6]
47E7  06              push es
47E8  57              push di
47E9  0E              push cs
47EA  E8 BD E7        call 0x2faa
loc_47ED:
47ED  C9              leave
47EE  C2 02 00        ret 2

; ---- routine 0AB9:47F1  (found by: call)
sub_47F1:
47F1  C8 08 00 00     enter 8, 0
47F5  80 3E B8 D0 00  cmp byte ptr [0xd0b8], 0
47FA  75 0A           jne 0x4806
47FC  80 3E B7 D0 00  cmp byte ptr [0xd0b7], 0
4801  75 03           jne 0x4806
4803  E9 A7 02        jmp 0x4aad
loc_4806:
4806  C4 7E 06        les di, ptr [bp + 6]
4809  06              push es
480A  57              push di
480B  0E              push cs
480C  E8 3F D6        call 0x1e4e
480F  08 C0           or al, al
4811  74 03           je 0x4816
4813  E9 82 02        jmp 0x4a98
loc_4816:
4816  A0 9F D0        mov al, byte ptr [0xd09f]
4819  30 E4           xor ah, ah
481B  89 46 FE        mov word ptr [bp - 2], ax
481E  80 3E 53 CF 00  cmp byte ptr [0xcf53], 0
4823  74 03           je 0x4828
4825  E9 FE 00        jmp 0x4926
loc_4828:
4828  C4 7E 06        les di, ptr [bp + 6]
482B  26 FF 35        push word ptr es:[di]
482E  06              push es
482F  57              push di
4830  0E              push cs
4831  E8 C1 D8        call 0x20f5
4834  08 C0           or al, al
4836  75 06           jne 0x483e
4838  C6 46 F9 0B     mov byte ptr [bp - 7], 0xb
483C  EB 11           jmp 0x484f
loc_483E:
483E  80 3E 54 CF 00  cmp byte ptr [0xcf54], 0
4843  74 06           je 0x484b
4845  C6 46 F9 41     mov byte ptr [bp - 7], 0x41
4849  EB 04           jmp 0x484f
loc_484B:
484B  C6 46 F9 0D     mov byte ptr [bp - 7], 0xd
loc_484F:
484F  8A 46 F9        mov al, byte ptr [bp - 7]
4852  50              push ax
4853  C4 7E 06        les di, ptr [bp + 6]
4856  06              push es
4857  57              push di
4858  0E              push cs
4859  E8 CC D5        call 0x1e28
485C  80 3E 54 CF 00  cmp byte ptr [0xcf54], 0
4861  74 33           je 0x4896
4863  6A 0A           push 0xa
4865  A0 9F D0        mov al, byte ptr [0xd09f]
4868  30 E4           xor ah, ah
486A  6B F8 19        imul di, ax, 0x19
486D  81 C7 EF CC     add di, 0xccef
4871  1E              push ds
4872  57              push di
4873  0E              push cs
4874  E8 6B D2        call 0x1ae2
4877  50              push ax
4878  9A 6D 07 2A 23  call far 232A:076D
487D  50              push ax
487E  6A 03           push 3
4880  C4 7E 06        les di, ptr [bp + 6]
4883  06              push es
4884  57              push di
4885  0E              push cs
4886  E8 59 D2        call 0x1ae2
4889  D1 E0           shl ax, 1
488B  50              push ax
488C  9A 6D 07 2A 23  call far 232A:076D
4891  5A              pop dx
4892  3B C2           cmp ax, dx
4894  7F 47           jg 0x48dd
loc_4896:
4896  80 3E 54 CF 00  cmp byte ptr [0xcf54], 0
489B  75 46           jne 0x48e3
489D  6A 0E           push 0xe
489F  A0 9F D0        mov al, byte ptr [0xd09f]
48A2  30 E4           xor ah, ah
48A4  6B F8 19        imul di, ax, 0x19
48A7  81 C7 EF CC     add di, 0xccef
48AB  1E              push ds
48AC  57              push di
48AD  0E              push cs
48AE  E8 31 D2        call 0x1ae2
48B1  50              push ax
48B2  9A 6D 07 2A 23  call far 232A:076D
48B7  50              push ax
48B8  6A 02           push 2
48BA  C4 7E 06        les di, ptr [bp + 6]
48BD  06              push es
48BE  57              push di
48BF  0E              push cs
48C0  E8 1F D2        call 0x1ae2
48C3  8B D0           mov dx, ax
48C5  80 7E F9 0B     cmp byte ptr [bp - 7], 0xb
48C9  B0 00           mov al, 0
48CB  74 01           je 0x48ce
48CD  40              inc ax
loc_48CE:
48CE  30 E4           xor ah, ah
48D0  03 C2           add ax, dx
48D2  50              push ax
48D3  9A 6D 07 2A 23  call far 232A:076D
48D8  5A              pop dx
48D9  3B C2           cmp ax, dx
48DB  7E 06           jle 0x48e3
loc_48DD:
48DD  55              push bp
48DE  E8 B3 FE        call 0x4794
48E1  EB 40           jmp 0x4923
loc_48E3:
48E3  C4 7E 06        les di, ptr [bp + 6]
48E6  06              push es
48E7  57              push di
48E8  0E              push cs
48E9  E8 6E F2        call 0x3b5a
48EC  08 C0           or al, al
48EE  74 1E           je 0x490e
48F0  9A 3F 0D BC 24  call far 24BC:0D3F
48F5  08 C0           or al, al
48F7  74 0F           je 0x4908
48F9  C4 7E 06        les di, ptr [bp + 6]
48FC  26 8A 45 07     mov al, byte ptr es:[di + 7]
4900  30 E4           xor ah, ah
4902  50              push ax
4903  E8 C8 23        call 0x6cce
4906  EB 04           jmp 0x490c
loc_4908:
4908  55              push bp
4909  E8 88 FE        call 0x4794
loc_490C:
490C  EB 15           jmp 0x4923
loc_490E:
490E  80 3E 54 CF 00  cmp byte ptr [0xcf54], 0
4913  75 05           jne 0x491a
4915  6A 0C           push 0xc
4917  E8 9D D4        call 0x1db7
loc_491A:
491A  C4 7E 06        les di, ptr [bp + 6]
491D  06              push es
491E  57              push di
491F  0E              push cs
4920  E8 FE F1        call 0x3b21
loc_4923:
4923  E9 70 01        jmp 0x4a96
loc_4926:
4926  80 3E B7 D0 00  cmp byte ptr [0xd0b7], 0
492B  74 07           je 0x4934
492D  C7 46 FC 05 00  mov word ptr [bp - 4], 5
4932  EB 1D           jmp 0x4951
loc_4934:
4934  A0 BB D0        mov al, byte ptr [0xd0bb]
4937  3C 05           cmp al, 5
4939  72 04           jb 0x493f
493B  3C 07           cmp al, 7
493D  76 04           jbe 0x4943
loc_493F:
493F  B0 00           mov al, 0
4941  EB 02           jmp 0x4945
loc_4943:
4943  B0 01           mov al, 1
loc_4945:
4945  98              cwde
4946  8B F8           mov di, ax
4948  8A 85 9A 0A     mov al, byte ptr [di + 0xa9a]
494C  30 E4           xor ah, ah
494E  89 46 FC        mov word ptr [bp - 4], ax
loc_4951:
4951  80 3E B7 D0 00  cmp byte ptr [0xd0b7], 0
4956  75 07           jne 0x495f
4958  31 C0           xor ax, ax
495A  89 46 FA        mov word ptr [bp - 6], ax
495D  EB 4B           jmp 0x49aa
loc_495F:
495F  80 3E BB D0 04  cmp byte ptr [0xd0bb], 4
4964  75 1B           jne 0x4981
4966  6A 16           push 0x16
4968  A0 9F D0        mov al, byte ptr [0xd09f]
496B  30 E4           xor ah, ah
496D  6B F8 19        imul di, ax, 0x19
4970  81 C7 EF CC     add di, 0xccef
4974  1E              push ds
4975  57              push di
4976  0E              push cs
4977  E8 68 D1        call 0x1ae2
497A  D1 E8           shr ax, 1
497C  89 46 FA        mov word ptr [bp - 6], ax
497F  EB 29           jmp 0x49aa
loc_4981:
4981  6A 03           push 3
4983  9A 1C 0D BC 24  call far 24BC:0D1C
4988  08 C0           or al, al
498A  75 05           jne 0x4991
498C  E9 1E 01        jmp 0x4aad
; data (not reached as code), 2 bytes
498F                  db EB 19   ; ..
loc_4991:
4991  6A 15           push 0x15
4993  A0 9F D0        mov al, byte ptr [0xd09f]
4996  30 E4           xor ah, ah
4998  6B F8 19        imul di, ax, 0x19
499B  81 C7 EF CC     add di, 0xccef
499F  1E              push ds
49A0  57              push di
49A1  0E              push cs
49A2  E8 3D D1        call 0x1ae2
49A5  D1 E8           shr ax, 1
49A7  89 46 FA        mov word ptr [bp - 6], ax
loc_49AA:
49AA  C4 7E 06        les di, ptr [bp + 6]
49AD  26 FF 35        push word ptr es:[di]
49B0  06              push es
49B1  57              push di
49B2  0E              push cs
49B3  E8 3F D7        call 0x20f5
49B6  08 C0           or al, al
49B8  75 03           jne 0x49bd
49BA  E9 D9 00        jmp 0x4a96
loc_49BD:
49BD  83 3E 51 CF 00  cmp word ptr [0xcf51], 0
49C2  74 48           je 0x4a0c
49C4  BF 46 CF        mov di, 0xcf46
49C7  1E              push ds
49C8  57              push di
49C9  9A 3F 0B 98 19  call far 1998:0B3F
49CE  C1 E0 02        shl ax, 2
49D1  50              push ax
49D2  9A 6D 07 2A 23  call far 232A:076D
49D7  99              cdq
49D8  8B C8           mov cx, ax
49DA  8B DA           mov bx, dx
49DC  8B 46 FA        mov ax, word ptr [bp - 6]
49DF  31 D2           xor dx, dx
49E1  03 C1           add ax, cx
49E3  13 D3           adc dx, bx
49E5  52              push dx
49E6  50              push ax
49E7  FF 76 FC        push word ptr [bp - 4]
49EA  C4 7E 06        les di, ptr [bp + 6]
49ED  06              push es
49EE  57              push di
49EF  0E              push cs
49F0  E8 EF D0        call 0x1ae2
49F3  50              push ax
49F4  9A 6D 07 2A 23  call far 232A:076D
49F9  99              cdq
49FA  59              pop cx
49FB  5B              pop bx
49FC  3B D3           cmp dx, bx
49FE  7F 0C           jg 0x4a0c
4A00  7D 03           jge 0x4a05
4A02  E9 91 00        jmp 0x4a96
loc_4A05:
4A05  3B C1           cmp ax, cx
4A07  77 03           ja 0x4a0c
4A09  E9 8A 00        jmp 0x4a96
loc_4A0C:
4A0C  80 3E B9 D0 00  cmp byte ptr [0xd0b9], 0
4A11  75 12           jne 0x4a25
4A13  A0 BB D0        mov al, byte ptr [0xd0bb]
4A16  3C 01           cmp al, 1
4A18  72 0B           jb 0x4a25
4A1A  3C 04           cmp al, 4
4A1C  77 07           ja 0x4a25
4A1E  E8 B5 D2        call 0x1cd6
4A21  50              push ax
4A22  E8 8F E2        call 0x2cb4
loc_4A25:
4A25  6A 04           push 4
4A27  9A 6D 07 2A 23  call far 232A:076D
4A2C  3D 01 00        cmp ax, 1
4A2F  75 2E           jne 0x4a5f
4A31  A1 4F CF        mov ax, word ptr [0xcf4f]
4A34  F7 D8           neg ax
4A36  A3 4F CF        mov word ptr [0xcf4f], ax
4A39  A1 4D CF        mov ax, word ptr [0xcf4d]
4A3C  F7 D8           neg ax
4A3E  A3 4D CF        mov word ptr [0xcf4d], ax
4A41  6A 00           push 0
4A43  6A 01           push 1
4A45  A1 51 CF        mov ax, word ptr [0xcf51]
4A48  C1 E8 02        shr ax, 2
4A4B  31 D2           xor dx, dx
4A4D  52              push dx
4A4E  50              push ax
4A4F  9A C0 04 BC 24  call far 24BC:04C0
4A54  A3 51 CF        mov word ptr [0xcf51], ax
4A57  6A 1E           push 0x1e
4A59  55              push bp
4A5A  E8 EE FC        call 0x474b
4A5D  EB 37           jmp 0x4a96
loc_4A5F:
4A5F  3D 02 00        cmp ax, 2
4A62  75 2E           jne 0x4a92
4A64  9A 3F 0D BC 24  call far 24BC:0D3F
4A69  98              cwde
4A6A  8B F8           mov di, ax
4A6C  8A 85 38 A3     mov al, byte ptr [di - 0x5cc8]
4A70  98              cwde
4A71  A3 4D CF        mov word ptr [0xcf4d], ax
4A74  6A 00           push 0
4A76  6A 01           push 1
4A78  A1 51 CF        mov ax, word ptr [0xcf51]
4A7B  C1 E8 02        shr ax, 2
4A7E  31 D2           xor dx, dx
4A80  52              push dx
4A81  50              push ax
4A82  9A C0 04 BC 24  call far 24BC:04C0
4A87  A3 51 CF        mov word ptr [0xcf51], ax
4A8A  6A 1F           push 0x1f
4A8C  55              push bp
4A8D  E8 BB FC        call 0x474b
4A90  EB 04           jmp 0x4a96
loc_4A92:
4A92  55              push bp
4A93  E8 FE FC        call 0x4794
loc_4A96:
4A96  EB 15           jmp 0x4aad
loc_4A98:
4A98  80 3E B9 D0 00  cmp byte ptr [0xd0b9], 0
4A9D  75 0E           jne 0x4aad
4A9F  C4 7E 06        les di, ptr [bp + 6]
4AA2  06              push es
4AA3  57              push di
4AA4  0E              push cs
4AA5  E8 C6 24        call 0x6f6e
4AA8  6A 1C           push 0x1c
4AAA  E8 0A D3        call 0x1db7
loc_4AAD:
4AAD  C9              leave
4AAE  CA 04 00        retf 4

; ---- routine 0AB9:4AB1  (found by: call)
sub_4AB1:
4AB1  C8 04 00 00     enter 4, 0
4AB5  C4 7E 06        les di, ptr [bp + 6]
4AB8  26 8B 05        mov ax, word ptr es:[di]
4ABB  89 46 FE        mov word ptr [bp - 2], ax
4ABE  C7 46 FC 01 00  mov word ptr [bp - 4], 1
4AC3  EB 03           jmp 0x4ac8
loc_4AC5:
4AC5  FF 46 FC        inc word ptr [bp - 4]
loc_4AC8:
4AC8  A0 54 CF        mov al, byte ptr [0xcf54]
4ACB  98              cwde
4ACC  8B F8           mov di, ax
4ACE  8A 85 9C 0A     mov al, byte ptr [di + 0xa9c]
4AD2  30 E4           xor ah, ah
4AD4  50              push ax
4AD5  9A 6D 07 2A 23  call far 232A:076D
4ADA  40              inc ax
4ADB  40              inc ax
4ADC  50              push ax
4ADD  9A 3F 0D BC 24  call far 24BC:0D3F
4AE2  98              cwde
4AE3  8B F8           mov di, ax
4AE5  8A 85 38 A3     mov al, byte ptr [di - 0x5cc8]
4AE9  98              cwde
4AEA  5A              pop dx
4AEB  F7 E2           mul dx
4AED  8B 7E FC        mov di, word ptr [bp - 4]
4AF0  00 43 FD        add byte ptr [bp + di - 3], al
4AF3  83 7E FC 02     cmp word ptr [bp - 4], 2
4AF7  75 CC           jne 0x4ac5
4AF9  C4 7E 06        les di, ptr [bp + 6]
4AFC  06              push es
4AFD  57              push di
4AFE  0E              push cs
4AFF  E8 6C 24        call 0x6f6e
4B02  FF 76 FE        push word ptr [bp - 2]
4B05  6A 06           push 6
4B07  C4 7E 06        les di, ptr [bp + 6]
4B0A  06              push es
4B0B  57              push di
4B0C  0E              push cs
4B0D  E8 15 DB        call 0x2625
4B10  C9              leave
4B11  CA 04 00        retf 4

; ---- routine 0AB9:4B14  (found by: call)
sub_4B14:
4B14  55              push bp
4B15  89 E5           mov bp, sp
4B17  C4 7E 06        les di, ptr [bp + 6]
4B1A  06              push es
4B1B  57              push di
4B1C  0E              push cs
4B1D  E8 4E 24        call 0x6f6e
4B20  6A 20           push 0x20
4B22  E8 92 D2        call 0x1db7
4B25  E8 AF D6        call 0x21d7
4B28  C6 06 C8 D1 01  mov byte ptr [0xd1c8], 1
4B2D  E8 A6 D1        call 0x1cd6
4B30  98              cwde
4B31  8B F8           mov di, ax
4B33  8A 85 A4 D0     mov al, byte ptr [di - 0x2f5c]
4B37  30 E4           xor ah, ah
4B39  50              push ax
4B3A  C4 7E 06        les di, ptr [bp + 6]
4B3D  06              push es
4B3E  57              push di
4B3F  0E              push cs
4B40  E8 F7 DD        call 0x293a
4B43  C6 06 C8 D1 00  mov byte ptr [0xd1c8], 0
4B48  C9              leave
4B49  CA 04 00        retf 4

; ---- routine 0AB9:4B4C  (found by: call)
sub_4B4C:
4B4C  C8 02 00 00     enter 2, 0
4B50  A0 BB D0        mov al, byte ptr [0xd0bb]
4B53  3C 01           cmp al, 1
4B55  72 04           jb 0x4b5b
4B57  3C 04           cmp al, 4
4B59  76 04           jbe 0x4b5f
loc_4B5B:
4B5B  B0 00           mov al, 0
4B5D  EB 02           jmp 0x4b61
loc_4B5F:
4B5F  B0 01           mov al, 1
loc_4B61:
4B61  88 46 FF        mov byte ptr [bp - 1], al
4B64  8A 46 FF        mov al, byte ptr [bp - 1]
4B67  C9              leave
4B68  C2 02 00        ret 2

; ---- routine 0AB9:4B6B  (found by: call)
sub_4B6B:
4B6B  C8 02 00 00     enter 2, 0
4B6F  A0 54 CF        mov al, byte ptr [0xcf54]
4B72  88 46 FF        mov byte ptr [bp - 1], al
4B75  8B 7E 04        mov di, word ptr [bp + 4]
4B78  36 8B 7D 04     mov di, word ptr ss:[di + 4]
4B7C  36 C4 7D 06     les di, ptr ss:[di + 6]
4B80  06              push es
4B81  57              push di
4B82  0E              push cs
4B83  E8 C8 D2        call 0x1e4e
4B86  88 46 FE        mov byte ptr [bp - 2], al
4B89  80 7E FF 00     cmp byte ptr [bp - 1], 0
4B8D  74 1E           je 0x4bad
4B8F  8B 7E 04        mov di, word ptr [bp + 4]
4B92  57              push di
4B93  E8 B6 FF        call 0x4b4c
4B96  08 C0           or al, al
4B98  75 13           jne 0x4bad
4B9A  8B 7E 04        mov di, word ptr [bp + 4]
4B9D  36 8B 7D 04     mov di, word ptr ss:[di + 4]
4BA1  36 C4 7D 06     les di, ptr ss:[di + 6]
4BA5  06              push es
4BA6  57              push di
4BA7  0E              push cs
4BA8  E8 69 FF        call 0x4b14
4BAB  EB 34           jmp 0x4be1
loc_4BAD:
4BAD  8B 7E 04        mov di, word ptr [bp + 4]
4BB0  36 8B 7D 04     mov di, word ptr ss:[di + 4]
4BB4  36 C4 7D 06     les di, ptr ss:[di + 6]
4BB8  06              push es
4BB9  57              push di
4BBA  0E              push cs
4BBB  E8 F3 FE        call 0x4ab1
4BBE  80 7E FF 00     cmp byte ptr [bp - 1], 0
4BC2  74 07           je 0x4bcb
4BC4  6A 20           push 0x20
4BC6  E8 EE D1        call 0x1db7
4BC9  EB 0E           jmp 0x4bd9
loc_4BCB:
4BCB  8A 46 FE        mov al, byte ptr [bp - 2]
4BCE  98              cwde
4BCF  8B F8           mov di, ax
4BD1  8A 85 A2 0A     mov al, byte ptr [di + 0xaa2]
4BD5  50              push ax
4BD6  E8 DE D1        call 0x1db7
loc_4BD9:
4BD9  9A 3F 0D BC 24  call far 24BC:0D3F
4BDE  A2 54 CF        mov byte ptr [0xcf54], al
loc_4BE1:
4BE1  C9              leave
4BE2  C2 02 00        ret 2

; ---- routine 0AB9:4BE5  (found by: call)
sub_4BE5:
4BE5  55              push bp
4BE6  89 E5           mov bp, sp
4BE8  8B 7E 04        mov di, word ptr [bp + 4]
4BEB  36 C4 7D 06     les di, ptr ss:[di + 6]
4BEF  06              push es
4BF0  57              push di
4BF1  0E              push cs
4BF2  E8 59 D2        call 0x1e4e
4BF5  08 C0           or al, al
4BF7  75 17           jne 0x4c10
4BF9  A0 9F D0        mov al, byte ptr [0xd09f]
4BFC  30 E4           xor ah, ah
4BFE  50              push ax
4BFF  E8 FE B3        call 0
4C02  08 C0           or al, al
4C04  74 0A           je 0x4c10
4C06  83 3E 51 CF 00  cmp word ptr [0xcf51], 0
4C0B  76 03           jbe 0x4c10
4C0D  E9 EB 01        jmp 0x4dfb
loc_4C10:
4C10  80 3E B8 D0 00  cmp byte ptr [0xd0b8], 0
4C15  75 0A           jne 0x4c21
4C17  80 3E B7 D0 00  cmp byte ptr [0xd0b7], 0
4C1C  75 03           jne 0x4c21
4C1E  E9 DA 01        jmp 0x4dfb
loc_4C21:
4C21  BF 46 CF        mov di, 0xcf46
4C24  1E              push ds
4C25  57              push di
4C26  9A 3F 0B 98 19  call far 1998:0B3F
4C2B  3D 0A 00        cmp ax, 0xa
4C2E  B0 00           mov al, 0
4C30  76 01           jbe 0x4c33
4C32  40              inc ax
loc_4C33:
4C33  8B 7E 04        mov di, word ptr [bp + 4]
4C36  36 88 45 FF     mov byte ptr ss:[di - 1], al
4C3A  80 3E 54 CF 00  cmp byte ptr [0xcf54], 0
4C3F  74 71           je 0x4cb2
4C41  36 80 7D FF 00  cmp byte ptr ss:[di - 1], 0
4C46  75 67           jne 0x4caf
4C48  6A 0A           push 0xa
4C4A  8B 7E 04        mov di, word ptr [bp + 4]
4C4D  36 C4 7D 06     les di, ptr ss:[di + 6]
4C51  06              push es
4C52  57              push di
4C53  0E              push cs
4C54  E8 7F CF        call 0x1bd6
4C57  08 C0           or al, al
4C59  74 54           je 0x4caf
4C5B  FF 36 46 CF     push word ptr [0xcf46]
4C5F  8B 7E 04        mov di, word ptr [bp + 4]
4C62  36 C4 7D 06     les di, ptr ss:[di + 6]
4C66  06              push es
4C67  57              push di
4C68  0E              push cs
4C69  E8 89 D4        call 0x20f5
4C6C  08 C0           or al, al
4C6E  74 0F           je 0x4c7f
4C70  8B 7E 04        mov di, word ptr [bp + 4]
4C73  36 C4 7D 06     les di, ptr ss:[di + 6]
4C77  06              push es
4C78  57              push di
4C79  0E              push cs
4C7A  E8 F3 E3        call 0x3070
4C7D  EB 30           jmp 0x4caf
loc_4C7F:
4C7F  FF 36 46 CF     push word ptr [0xcf46]
4C83  8B 7E 04        mov di, word ptr [bp + 4]
4C86  36 C4 7D 06     les di, ptr ss:[di + 6]
4C8A  06              push es
4C8B  57              push di
4C8C  0E              push cs
4C8D  E8 99 D4        call 0x2129
4C90  08 C0           or al, al
4C92  74 17           je 0x4cab
4C94  55              push bp
4C95  E8 B4 FE        call 0x4b4c
4C98  08 C0           or al, al
4C9A  75 0D           jne 0x4ca9
4C9C  8B 7E 04        mov di, word ptr [bp + 4]
4C9F  36 C4 7D 06     les di, ptr ss:[di + 6]
4CA3  06              push es
4CA4  57              push di
4CA5  0E              push cs
4CA6  E8 41 E2        call 0x2eea
loc_4CA9:
4CA9  EB 04           jmp 0x4caf
loc_4CAB:
4CAB  55              push bp
4CAC  E8 BC FE        call 0x4b6b
loc_4CAF:
4CAF  E9 49 01        jmp 0x4dfb
loc_4CB2:
4CB2  8B 7E 04        mov di, word ptr [bp + 4]
4CB5  36 80 7D FF 00  cmp byte ptr ss:[di - 1], 0
4CBA  74 1A           je 0x4cd6
4CBC  6A 07           push 7
4CBE  8B 7E 04        mov di, word ptr [bp + 4]
4CC1  36 C4 7D 06     les di, ptr ss:[di + 6]
4CC5  06              push es
4CC6  57              push di
4CC7  0E              push cs
4CC8  E8 0B CF        call 0x1bd6
4CCB  08 C0           or al, al
4CCD  74 04           je 0x4cd3
4CCF  55              push bp
4CD0  E8 98 FE        call 0x4b6b
loc_4CD3:
4CD3  E9 25 01        jmp 0x4dfb
loc_4CD6:
4CD6  8B 7E 04        mov di, word ptr [bp + 4]
4CD9  36 C4 7D 06     les di, ptr ss:[di + 6]
4CDD  06              push es
4CDE  57              push di
4CDF  0E              push cs
4CE0  E8 7A D4        call 0x215d
4CE3  08 C0           or al, al
4CE5  75 03           jne 0x4cea
4CE7  E9 8A 00        jmp 0x4d74
loc_4CEA:
4CEA  6A 0F           push 0xf
4CEC  8B 7E 04        mov di, word ptr [bp + 4]
4CEF  36 C4 7D 06     les di, ptr ss:[di + 6]
4CF3  06              push es
4CF4  57              push di
4CF5  0E              push cs
4CF6  E8 DD CE        call 0x1bd6
4CF9  08 C0           or al, al
4CFB  74 0B           je 0x4d08
4CFD  6A 04           push 4
4CFF  9A 1C 0D BC 24  call far 24BC:0D1C
4D04  08 C0           or al, al
4D06  75 11           jne 0x4d19
loc_4D08:
4D08  8B 7E 04        mov di, word ptr [bp + 4]
4D0B  36 C4 7D 06     les di, ptr ss:[di + 6]
4D0F  06              push es
4D10  57              push di
4D11  0E              push cs
4D12  E8 39 D1        call 0x1e4e
4D15  08 C0           or al, al
4D17  74 5B           je 0x4d74
loc_4D19:
4D19  55              push bp
4D1A  E8 2F FE        call 0x4b4c
4D1D  08 C0           or al, al
4D1F  75 50           jne 0x4d71
4D21  8B 7E 04        mov di, word ptr [bp + 4]
4D24  36 C4 7D 06     les di, ptr ss:[di + 6]
4D28  06              push es
4D29  57              push di
4D2A  0E              push cs
4D2B  E8 20 D1        call 0x1e4e
4D2E  08 C0           or al, al
4D30  74 1D           je 0x4d4f
4D32  83 3E 51 CF 00  cmp word ptr [0xcf51], 0
4D37  76 16           jbe 0x4d4f
4D39  80 3E BB D0 02  cmp byte ptr [0xd0bb], 2
4D3E  74 0F           je 0x4d4f
4D40  8B 7E 04        mov di, word ptr [bp + 4]
4D43  36 C4 7D 06     les di, ptr ss:[di + 6]
4D47  06              push es
4D48  57              push di
4D49  0E              push cs
4D4A  E8 9D E1        call 0x2eea
4D4D  EB 22           jmp 0x4d71
loc_4D4F:
4D4F  8B 7E 04        mov di, word ptr [bp + 4]
4D52  36 C4 7D 06     les di, ptr ss:[di + 6]
4D56  06              push es
4D57  57              push di
4D58  0E              push cs
4D59  E8 F2 D0        call 0x1e4e
4D5C  98              cwde
4D5D  8B F8           mov di, ax
4D5F  8A 85 A0 0A     mov al, byte ptr [di + 0xaa0]
4D63  50              push ax
4D64  8B 7E 04        mov di, word ptr [bp + 4]
4D67  36 C4 7D 06     les di, ptr ss:[di + 6]
4D6B  06              push es
4D6C  57              push di
4D6D  0E              push cs
4D6E  E8 63 E1        call 0x2ed4
loc_4D71:
4D71  E9 87 00        jmp 0x4dfb
loc_4D74:
4D74  83 3E 51 CF 00  cmp word ptr [0xcf51], 0
4D79  74 28           je 0x4da3
4D7B  8B 7E 04        mov di, word ptr [bp + 4]
4D7E  36 C4 7D 06     les di, ptr ss:[di + 6]
4D82  06              push es
4D83  57              push di
4D84  0E              push cs
4D85  E8 C6 D0        call 0x1e4e
4D88  98              cwde
4D89  8B F8           mov di, ax
4D8B  8A 85 9E 0A     mov al, byte ptr [di + 0xa9e]
4D8F  30 E4           xor ah, ah
4D91  50              push ax
4D92  8B 7E 04        mov di, word ptr [bp + 4]
4D95  36 C4 7D 06     les di, ptr ss:[di + 6]
4D99  06              push es
4D9A  57              push di
4D9B  0E              push cs
4D9C  E8 37 CE        call 0x1bd6
4D9F  08 C0           or al, al
4DA1  74 58           je 0x4dfb
loc_4DA3:
4DA3  8B 7E 04        mov di, word ptr [bp + 4]
4DA6  36 C4 7D 06     les di, ptr ss:[di + 6]
4DAA  06              push es
4DAB  57              push di
4DAC  0E              push cs
4DAD  E8 9E D0        call 0x1e4e
4DB0  08 C0           or al, al
4DB2  74 2B           je 0x4ddf
4DB4  A0 9F D0        mov al, byte ptr [0xd09f]
4DB7  8B 7E 04        mov di, word ptr [bp + 4]
4DBA  36 C4 7D 06     les di, ptr ss:[di + 6]
4DBE  26 3A 45 07     cmp al, byte ptr es:[di + 7]
4DC2  75 0A           jne 0x4dce
4DC4  6A 19           push 0x19
4DC6  06              push es
4DC7  57              push di
4DC8  0E              push cs
4DC9  E8 5C D0        call 0x1e28
4DCC  EB 0F           jmp 0x4ddd
loc_4DCE:
4DCE  6A 23           push 0x23
4DD0  8B 7E 04        mov di, word ptr [bp + 4]
4DD3  36 C4 7D 06     les di, ptr ss:[di + 6]
4DD7  06              push es
4DD8  57              push di
4DD9  0E              push cs
4DDA  E8 4B D0        call 0x1e28
loc_4DDD:
4DDD  EB 0F           jmp 0x4dee
loc_4DDF:
4DDF  6A 22           push 0x22
4DE1  8B 7E 04        mov di, word ptr [bp + 4]
4DE4  36 C4 7D 06     les di, ptr ss:[di + 6]
4DE8  06              push es
4DE9  57              push di
4DEA  0E              push cs
4DEB  E8 3A D0        call 0x1e28
loc_4DEE:
4DEE  8B 7E 04        mov di, word ptr [bp + 4]
4DF1  36 C4 7D 06     les di, ptr ss:[di + 6]
4DF5  06              push es
4DF6  57              push di
4DF7  0E              push cs
4DF8  E8 73 21        call 0x6f6e
loc_4DFB:
4DFB  C9              leave
4DFC  C2 02 00        ret 2

; ---- routine 0AB9:4DFF  (found by: call)
sub_4DFF:
4DFF  C8 02 00 00     enter 2, 0
4E03  80 3E 74 D0 00  cmp byte ptr [0xd074], 0
4E08  75 4E           jne 0x4e58
4E0A  C4 7E 06        les di, ptr [bp + 6]
4E0D  26 80 7D 13 0D  cmp byte ptr es:[di + 0x13], 0xd
4E12  74 44           je 0x4e58
4E14  06              push es
4E15  57              push di
4E16  0E              push cs
4E17  E8 9C D1        call 0x1fb6
4E1A  08 C0           or al, al
4E1C  74 3A           je 0x4e58
4E1E  C4 7E 06        les di, ptr [bp + 6]
4E21  26 8A 45 07     mov al, byte ptr es:[di + 7]
4E25  30 E4           xor ah, ah
4E27  50              push ax
4E28  E8 D5 B1        call 0
4E2B  08 C0           or al, al
4E2D  74 0B           je 0x4e3a
4E2F  C4 7E 06        les di, ptr [bp + 6]
4E32  06              push es
4E33  57              push di
4E34  0E              push cs
4E35  E8 B9 F9        call 0x47f1
4E38  EB 1E           jmp 0x4e58
loc_4E3A:
4E3A  80 3E B9 D0 00  cmp byte ptr [0xd0b9], 0
4E3F  75 17           jne 0x4e58
4E41  80 3E A0 D0 00  cmp byte ptr [0xd0a0], 0
4E46  75 10           jne 0x4e58
4E48  A0 9F D0        mov al, byte ptr [0xd09f]
4E4B  C4 7E 06        les di, ptr [bp + 6]
4E4E  26 3A 45 07     cmp al, byte ptr es:[di + 7]
4E52  74 04           je 0x4e58
4E54  55              push bp
4E55  E8 8D FD        call 0x4be5
loc_4E58:
4E58  C9              leave
4E59  CA 04 00        retf 4

; ---- routine 0AB9:4E5C  (found by: call)
sub_4E5C:
4E5C  55              push bp
4E5D  89 E5           mov bp, sp
4E5F  C6 06 B8 D0 00  mov byte ptr [0xd0b8], 0
4E64  E8 C8 1C        call 0x6b2f
4E67  80 3E CA D1 00  cmp byte ptr [0xd1ca], 0
4E6C  74 14           je 0x4e82
4E6E  E8 65 CE        call 0x1cd6
4E71  98              cwde
4E72  8B F8           mov di, ax
4E74  8A 85 56 0D     mov al, byte ptr [di + 0xd56]
4E78  30 E4           xor ah, ah
4E7A  05 0A 00        add ax, 0xa
4E7D  A2 9F D0        mov byte ptr [0xd09f], al
4E80  EB 19           jmp 0x4e9b
loc_4E82:
4E82  E8 51 CE        call 0x1cd6
4E85  08 C0           or al, al
4E87  B0 00           mov al, 0
4E89  75 01           jne 0x4e8c
4E8B  40              inc ax
loc_4E8C:
4E8C  98              cwde
4E8D  8B F8           mov di, ax
4E8F  8A 85 56 0D     mov al, byte ptr [di + 0xd56]
4E93  30 E4           xor ah, ah
4E95  05 0A 00        add ax, 0xa
4E98  A2 9F D0        mov byte ptr [0xd09f], al
loc_4E9B:
4E9B  C6 06 CA D1 00  mov byte ptr [0xd1ca], 0
4EA0  E8 97 CE        call 0x1d3a
4EA3  6A 01           push 1
4EA5  E8 D6 CD        call 0x1c7e
4EA8  C9              leave
4EA9  C3              ret

; ---- routine 0AB9:4EAA  (found by: call)
sub_4EAA:
4EAA  55              push bp
4EAB  89 E5           mov bp, sp
4EAD  80 3E CA D1 00  cmp byte ptr [0xd1ca], 0
4EB2  74 06           je 0x4eba
4EB4  E8 A5 FF        call 0x4e5c
4EB7  E9 D7 00        jmp 0x4f91
loc_4EBA:
4EBA  C4 7E 06        les di, ptr [bp + 6]
4EBD  26 8A 45 07     mov al, byte ptr es:[di + 7]
4EC1  3A 06 9F D0     cmp al, byte ptr [0xd09f]
4EC5  74 42           je 0x4f09
4EC7  E8 0C CE        call 0x1cd6
4ECA  08 C0           or al, al
4ECC  B0 00           mov al, 0
4ECE  75 01           jne 0x4ed1
4ED0  40              inc ax
loc_4ED1:
4ED1  98              cwde
4ED2  8B F8           mov di, ax
4ED4  8A 85 C4 D0     mov al, byte ptr [di - 0x2f3c]
4ED8  50              push ax
4ED9  E8 FA CD        call 0x1cd6
4EDC  98              cwde
4EDD  8B F8           mov di, ax
4EDF  8A 85 C4 D0     mov al, byte ptr [di - 0x2f3c]
4EE3  5A              pop dx
4EE4  3A C2           cmp al, dl
4EE6  72 15           jb 0x4efd
4EE8  A0 9F D0        mov al, byte ptr [0xd09f]
4EEB  30 E4           xor ah, ah
4EED  6B F8 19        imul di, ax, 0x19
4EF0  8B 85 EF CC     mov ax, word ptr [di - 0x3311]
4EF4  C4 7E 06        les di, ptr [bp + 6]
4EF7  26 89 45 08     mov word ptr es:[di + 8], ax
4EFB  EB 09           jmp 0x4f06
loc_4EFD:
4EFD  C4 7E 06        les di, ptr [bp + 6]
4F00  06              push es
4F01  57              push di
4F02  0E              push cs
4F03  E8 D4 E3        call 0x32da
loc_4F06:
4F06  E9 88 00        jmp 0x4f91
loc_4F09:
4F09  C4 7E 06        les di, ptr [bp + 6]
4F0C  06              push es
4F0D  57              push di
4F0E  0E              push cs
4F0F  E8 87 D0        call 0x1f99
4F12  08 C0           or al, al
4F14  75 0B           jne 0x4f21
4F16  6A 10           push 0x10
4F18  9A 1C 0D BC 24  call far 24BC:0D1C
4F1D  08 C0           or al, al
4F1F  74 70           je 0x4f91
loc_4F21:
4F21  C4 7E 06        les di, ptr [bp + 6]
4F24  06              push es
4F25  57              push di
4F26  0E              push cs
4F27  E8 A2 CF        call 0x1ecc
4F2A  98              cwde
4F2B  8B F0           mov si, ax
4F2D  D1 E0           shl ax, 1
4F2F  D1 E0           shl ax, 1
4F31  01 F0           add ax, si
4F33  8B D0           mov dx, ax
4F35  C4 7E 06        les di, ptr [bp + 6]
4F38  26 8A 45 09     mov al, byte ptr es:[di + 9]
4F3C  98              cwde
4F3D  3B C2           cmp ax, dx
4F3F  74 18           je 0x4f59
4F41  06              push es
4F42  57              push di
4F43  0E              push cs
4F44  E8 85 CF        call 0x1ecc
4F47  98              cwde
4F48  8B F0           mov si, ax
4F4A  D1 E0           shl ax, 1
4F4C  D1 E0           shl ax, 1
4F4E  01 F0           add ax, si
4F50  C4 7E 06        les di, ptr [bp + 6]
4F53  26 88 45 09     mov byte ptr es:[di + 9], al
4F57  EB 38           jmp 0x4f91
loc_4F59:
4F59  C4 7E 06        les di, ptr [bp + 6]
4F5C  26 8A 45 08     mov al, byte ptr es:[di + 8]
4F60  98              cwde
4F61  99              cdq
4F62  31 D0           xor ax, dx
4F64  29 D0           sub ax, dx
4F66  3D 06 00        cmp ax, 6
4F69  74 23           je 0x4f8e
4F6B  26 80 7D 08 00  cmp byte ptr es:[di + 8], 0
4F70  B0 00           mov al, 0
4F72  7D 01           jge 0x4f75
4F74  40              inc ax
loc_4F75:
4F75  98              cwde
4F76  8B F8           mov di, ax
4F78  8A 85 38 A3     mov al, byte ptr [di - 0x5cc8]
4F7C  98              cwde
4F7D  D1 E0           shl ax, 1
4F7F  8B F0           mov si, ax
4F81  D1 E0           shl ax, 1
4F83  01 F0           add ax, si
4F85  C4 7E 06        les di, ptr [bp + 6]
4F88  26 88 45 08     mov byte ptr es:[di + 8], al
4F8C  EB 03           jmp 0x4f91
loc_4F8E:
4F8E  E8 CB FE        call 0x4e5c
loc_4F91:
4F91  C9              leave
4F92  CA 04 00        retf 4

; ---- routine 0AB9:4F95  (found by: call)
sub_4F95:
4F95  C8 04 00 00     enter 4, 0
4F99  A0 9F D0        mov al, byte ptr [0xd09f]
4F9C  30 E4           xor ah, ah
4F9E  50              push ax
4F9F  E8 5E B0        call 0
4FA2  08 C0           or al, al
4FA4  74 43           je 0x4fe9
4FA6  A0 9F D0        mov al, byte ptr [0xd09f]
4FA9  30 E4           xor ah, ah
4FAB  6B F8 19        imul di, ax, 0x19
4FAE  81 C7 EF CC     add di, 0xccef
4FB2  1E              push ds
4FB3  07              pop es
4FB4  89 7E FC        mov word ptr [bp - 4], di
4FB7  8C 46 FE        mov word ptr [bp - 2], es
4FBA  26 FF 75 0A     push word ptr es:[di + 0xa]
4FBE  06              push es
4FBF  57              push di
4FC0  0E              push cs
4FC1  E8 9A CF        call 0x1f5e
4FC4  C4 7E FC        les di, ptr [bp - 4]
4FC7  26 89 45 08     mov word ptr es:[di + 8], ax
4FCB  E8 08 CD        call 0x1cd6
4FCE  98              cwde
4FCF  8B F8           mov di, ax
4FD1  8A 85 56 0D     mov al, byte ptr [di + 0xd56]
4FD5  30 E4           xor ah, ah
4FD7  50              push ax
4FD8  6A 0A           push 0xa
4FDA  9A 6D 07 2A 23  call far 232A:076D
4FDF  40              inc ax
4FE0  5A              pop dx
4FE1  03 C2           add ax, dx
4FE3  A2 9F D0        mov byte ptr [0xd09f], al
4FE6  E8 51 CD        call 0x1d3a
loc_4FE9:
4FE9  A0 9F D0        mov al, byte ptr [0xd09f]
4FEC  30 E4           xor ah, ah
4FEE  6B F8 19        imul di, ax, 0x19
4FF1  81 C7 EF CC     add di, 0xccef
4FF5  1E              push ds
4FF6  07              pop es
4FF7  89 7E FC        mov word ptr [bp - 4], di
4FFA  8C 46 FE        mov word ptr [bp - 2], es
4FFD  80 3E 74 D0 00  cmp byte ptr [0xd074], 0
5002  74 09           je 0x500d
5004  26 8B 05        mov ax, word ptr es:[di]
5007  26 89 45 08     mov word ptr es:[di + 8], ax
500B  EB 74           jmp 0x5081
loc_500D:
500D  9A 3F 0D BC 24  call far 24BC:0D3F
5012  08 C0           or al, al
5014  74 38           je 0x504e
5016  6A 19           push 0x19
5018  9A 6D 07 2A 23  call far 232A:076D
501D  05 0A 00        add ax, 0xa
5020  50              push ax
5021  C4 7E FC        les di, ptr [bp - 4]
5024  06              push es
5025  57              push di
5026  0E              push cs
5027  E8 A2 CE        call 0x1ecc
502A  98              cwde
502B  5A              pop dx
502C  F7 E2           mul dx
502E  C4 7E FC        les di, ptr [bp - 4]
5031  26 88 45 09     mov byte ptr es:[di + 9], al
5035  9A 3F 0D BC 24  call far 24BC:0D3F
503A  98              cwde
503B  8B F8           mov di, ax
503D  8A 85 38 A3     mov al, byte ptr [di - 0x5cc8]
5041  98              cwde
5042  6B C0 07        imul ax, ax, 7
5045  C4 7E FC        les di, ptr [bp - 4]
5048  26 88 45 08     mov byte ptr es:[di + 8], al
504C  EB 33           jmp 0x5081
loc_504E:
504E  C4 7E FC        les di, ptr [bp - 4]
5051  06              push es
5052  57              push di
5053  0E              push cs
5054  E8 75 CE        call 0x1ecc
5057  98              cwde
5058  6B C0 24        imul ax, ax, 0x24
505B  C4 7E FC        les di, ptr [bp - 4]
505E  26 88 45 09     mov byte ptr es:[di + 9], al
5062  6A 05           push 5
5064  9A 6D 07 2A 23  call far 232A:076D
5069  50              push ax
506A  9A 3F 0D BC 24  call far 24BC:0D3F
506F  98              cwde
5070  8B F8           mov di, ax
5072  8A 85 38 A3     mov al, byte ptr [di - 0x5cc8]
5076  98              cwde
5077  5A              pop dx
5078  F7 E2           mul dx
507A  C4 7E FC        les di, ptr [bp - 4]
507D  26 88 45 08     mov byte ptr es:[di + 8], al
loc_5081:
5081  C9              leave
5082  C3              ret

