; 1-095.EXE (One-Nil 95), code segment 1B51 (image offsets 1B510..2305F), part 6 of 12
; packed 1-095.EXE sha256 f659fb2d334500d6901fc8d6a0f06c85c0ccda2eb4a3035ae3bb0a0004d79192 (LZEXE 0.91)
; unpacked (tools/static/unlzexe.py) sha256 8df646e017e0965a5d90a58181ca764219ad847833aad0b6cb58fc53372bfb2c
; tool: capstone 5.0.9 (pip package; core library 5.0.1280) (CS_ARCH_X86, CS_MODE_16), recursive descent from the entry point, far calls and near calls/jumps, then routine prologues (55 89 E5 / 55 8B EC / C8 iw 00) in what remains; tools/static/listing.py
; addresses are SEGMENT:OFFSET with SEGMENT the image paragraph before relocation; image offset = SEGMENT*16+OFFSET
; ---- routine 1B51:37D5  (found by: far)
sub_37D5:
37D5  C8 02 00 00     enter 2, 0
37D9  8B 7E 0A        mov di, word ptr [bp + 0xa]
37DC  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
37E0  30 E4           xor ah, ah
37E2  50              push ax
37E3  0E              push cs
37E4  E8 C7 FD        call 0x35ae
37E7  F7 D2           not dx
37E9  F7 D8           neg ax
37EB  83 DA FF        sbb dx, -1
37EE  2D 20 4E        sub ax, 0x4e20
37F1  83 DA 00        sbb dx, 0
37F4  52              push dx
37F5  50              push ax
37F6  FF 76 0A        push word ptr [bp + 0xa]
37F9  0E              push cs
37FA  E8 D6 FD        call 0x35d3
37FD  2B 46 06        sub ax, word ptr [bp + 6]
3800  1B 56 08        sbb dx, word ptr [bp + 8]
3803  59              pop cx
3804  5B              pop bx
3805  3B D3           cmp dx, bx
3807  7C 0A           jl 0x3813
3809  7F 04           jg 0x380f
380B  3B C1           cmp ax, cx
380D  72 04           jb 0x3813
loc_380F:
380F  B0 00           mov al, 0
3811  EB 02           jmp 0x3815
loc_3813:
3813  B0 01           mov al, 1
loc_3815:
3815  50              push ax
3816  BF AF 37        mov di, 0x37af
3819  0E              push cs
381A  57              push di
381B  9A 98 00 1A 23  call far 231A:0098
3820  88 46 FF        mov byte ptr [bp - 1], al
3823  8A 46 FF        mov al, byte ptr [bp - 1]
3826  C9              leave
3827  CA 06 00        retf 6

; ---- routine 1B51:382A  (found by: far)
sub_382A:
382A  C8 04 00 00     enter 4, 0
382E  FF 76 06        push word ptr [bp + 6]
3831  0E              push cs
3832  E8 20 FD        call 0x3555
3835  B9 04 00        mov cx, 4
3838  31 DB           xor bx, bx
383A  9A 67 0A B9 26  call far 26B9:0A67
383F  89 46 FC        mov word ptr [bp - 4], ax
3842  89 56 FE        mov word ptr [bp - 2], dx
3845  8B 46 FC        mov ax, word ptr [bp - 4]
3848  8B 56 FE        mov dx, word ptr [bp - 2]
384B  C9              leave
384C  CA 02 00        retf 2

; ---- routine 1B51:384F  (found by: far)
sub_384F:
384F  C8 08 00 00     enter 8, 0
3853  C4 3E D2 D7     les di, ptr [0xd7d2]
3857  89 7E FC        mov word ptr [bp - 4], di
385A  8C 46 FE        mov word ptr [bp - 2], es
385D  26 8A 45 04     mov al, byte ptr es:[di + 4]
3861  30 E4           xor ah, ah
3863  8B F8           mov di, ax
3865  80 BD B9 DC 00  cmp byte ptr [di - 0x2347], 0
386A  75 03           jne 0x386f
386C  E9 F1 01        jmp 0x3a60
loc_386F:
386F  BF C4 7C        mov di, 0x7cc4
3872  1E              push ds
3873  57              push di
3874  BF 5C DD        mov di, 0xdd5c
3877  1E              push ds
3878  57              push di
3879  9A 2F 05 1A 23  call far 231A:052F
387E  C4 7E FC        les di, ptr [bp - 4]
3881  26 8A 45 04     mov al, byte ptr es:[di + 4]
3885  30 E4           xor ah, ah
3887  8B F8           mov di, ax
3889  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
388D  30 E4           xor ah, ah
388F  50              push ax
3890  6A 02           push 2
3892  6A 15           push 0x15
3894  0E              push cs
3895  E8 AB D5        call 0xe43
3898  C4 7E FC        les di, ptr [bp - 4]
389B  26 8A 45 04     mov al, byte ptr es:[di + 4]
389F  30 E4           xor ah, ah
38A1  6B C0 5E        imul ax, ax, 0x5e
38A4  C4 3E C4 DC     les di, ptr [0xdcc4]
38A8  03 F8           add di, ax
38AA  81 C7 A2 FF     add di, 0xffa2
38AE  89 7E F8        mov word ptr [bp - 8], di
38B1  8C 46 FA        mov word ptr [bp - 6], es
38B4  C7 06 64 DD 70 00 mov word ptr [0xdd64], 0x70
38BA  26 FF 75 20     push word ptr es:[di + 0x20]
38BE  26 FF 75 1E     push word ptr es:[di + 0x1e]
38C2  6A 06           push 6
38C4  6A 26           push 0x26
38C6  0E              push cs
38C7  E8 B4 D6        call 0xf7e
38CA  C4 7E F8        les di, ptr [bp - 8]
38CD  26 FF 75 28     push word ptr es:[di + 0x28]
38D1  26 FF 75 26     push word ptr es:[di + 0x26]
38D5  6A 08           push 8
38D7  6A 26           push 0x26
38D9  0E              push cs
38DA  E8 A1 D6        call 0xf7e
38DD  C4 7E F8        les di, ptr [bp - 8]
38E0  26 FF 75 08     push word ptr es:[di + 8]
38E4  26 FF 75 06     push word ptr es:[di + 6]
38E8  6A 0A           push 0xa
38EA  6A 26           push 0x26
38EC  0E              push cs
38ED  E8 8E D6        call 0xf7e
38F0  C4 7E F8        les di, ptr [bp - 8]
38F3  26 FF 75 0C     push word ptr es:[di + 0xc]
38F7  26 FF 75 0A     push word ptr es:[di + 0xa]
38FB  6A 0C           push 0xc
38FD  6A 26           push 0x26
38FF  0E              push cs
3900  E8 7B D6        call 0xf7e
3903  C4 7E F8        les di, ptr [bp - 8]
3906  26 FF 75 30     push word ptr es:[di + 0x30]
390A  26 FF 75 2E     push word ptr es:[di + 0x2e]
390E  6A 0E           push 0xe
3910  6A 26           push 0x26
3912  0E              push cs
3913  E8 68 D6        call 0xf7e
3916  C4 7E F8        les di, ptr [bp - 8]
3919  26 FF 75 10     push word ptr es:[di + 0x10]
391D  26 FF 75 0E     push word ptr es:[di + 0xe]
3921  6A 10           push 0x10
3923  6A 26           push 0x26
3925  0E              push cs
3926  E8 55 D6        call 0xf7e
3929  C4 7E F8        les di, ptr [bp - 8]
392C  26 FF 75 14     push word ptr es:[di + 0x14]
3930  26 FF 75 12     push word ptr es:[di + 0x12]
3934  6A 12           push 0x12
3936  6A 26           push 0x26
3938  0E              push cs
3939  E8 42 D6        call 0xf7e
393C  C4 7E F8        les di, ptr [bp - 8]
393F  26 FF 75 58     push word ptr es:[di + 0x58]
3943  26 FF 75 56     push word ptr es:[di + 0x56]
3947  6A 14           push 0x14
3949  6A 26           push 0x26
394B  0E              push cs
394C  E8 2F D6        call 0xf7e
394F  C7 06 64 DD 40 00 mov word ptr [0xdd64], 0x40
3955  C4 7E F8        les di, ptr [bp - 8]
3958  26 FF 75 4C     push word ptr es:[di + 0x4c]
395C  26 FF 75 4A     push word ptr es:[di + 0x4a]
3960  6A 04           push 4
3962  6A 4F           push 0x4f
3964  0E              push cs
3965  E8 16 D6        call 0xf7e
3968  C4 7E F8        les di, ptr [bp - 8]
396B  26 FF 75 50     push word ptr es:[di + 0x50]
396F  26 FF 75 4E     push word ptr es:[di + 0x4e]
3973  6A 06           push 6
3975  6A 4F           push 0x4f
3977  0E              push cs
3978  E8 03 D6        call 0xf7e
397B  C4 7E F8        les di, ptr [bp - 8]
397E  26 8B 45 04     mov ax, word ptr es:[di + 4]
3982  31 D2           xor dx, dx
3984  52              push dx
3985  50              push ax
3986  6A 08           push 8
3988  6A 4F           push 0x4f
398A  0E              push cs
398B  E8 F0 D5        call 0xf7e
398E  C4 7E F8        les di, ptr [bp - 8]
3991  26 FF 75 48     push word ptr es:[di + 0x48]
3995  26 FF 75 46     push word ptr es:[di + 0x46]
3999  6A 0A           push 0xa
399B  6A 4F           push 0x4f
399D  0E              push cs
399E  E8 DD D5        call 0xf7e
39A1  C4 7E F8        les di, ptr [bp - 8]
39A4  26 FF 75 38     push word ptr es:[di + 0x38]
39A8  26 FF 75 36     push word ptr es:[di + 0x36]
39AC  6A 0C           push 0xc
39AE  6A 4F           push 0x4f
39B0  0E              push cs
39B1  E8 CA D5        call 0xf7e
39B4  C4 7E F8        les di, ptr [bp - 8]
39B7  26 FF 75 40     push word ptr es:[di + 0x40]
39BB  26 FF 75 3E     push word ptr es:[di + 0x3e]
39BF  6A 0E           push 0xe
39C1  6A 4F           push 0x4f
39C3  0E              push cs
39C4  E8 B7 D5        call 0xf7e
39C7  C4 7E F8        les di, ptr [bp - 8]
39CA  26 FF 75 44     push word ptr es:[di + 0x44]
39CE  26 FF 75 42     push word ptr es:[di + 0x42]
39D2  6A 10           push 0x10
39D4  6A 4F           push 0x4f
39D6  0E              push cs
39D7  E8 A4 D5        call 0xf7e
39DA  C4 7E F8        les di, ptr [bp - 8]
39DD  26 FF 75 18     push word ptr es:[di + 0x18]
39E1  26 FF 75 16     push word ptr es:[di + 0x16]
39E5  6A 12           push 0x12
39E7  6A 4F           push 0x4f
39E9  0E              push cs
39EA  E8 91 D5        call 0xf7e
39ED  C4 7E F8        les di, ptr [bp - 8]
39F0  26 FF 75 5C     push word ptr es:[di + 0x5c]
39F4  26 FF 75 5A     push word ptr es:[di + 0x5a]
39F8  6A 14           push 0x14
39FA  6A 4F           push 0x4f
39FC  0E              push cs
39FD  E8 7E D5        call 0xf7e
3A00  C7 06 64 DD 50 00 mov word ptr [0xdd64], 0x50
3A06  C4 7E FC        les di, ptr [bp - 4]
3A09  26 8A 45 04     mov al, byte ptr es:[di + 4]
3A0D  30 E4           xor ah, ah
3A0F  8B F8           mov di, ax
3A11  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
3A15  30 E4           xor ah, ah
3A17  50              push ax
3A18  0E              push cs
3A19  E8 92 FB        call 0x35ae
3A1C  52              push dx
3A1D  50              push ax
3A1E  6A 17           push 0x17
3A20  6A 4F           push 0x4f
3A22  0E              push cs
3A23  E8 58 D5        call 0xf7e
3A26  C4 7E F8        les di, ptr [bp - 8]
3A29  26 FF 75 54     push word ptr es:[di + 0x54]
3A2D  26 FF 75 52     push word ptr es:[di + 0x52]
3A31  6A 17           push 0x17
3A33  6A 26           push 0x26
3A35  0E              push cs
3A36  E8 45 D5        call 0xf7e
3A39  C4 3E 5C DD     les di, ptr [0xdd5c]
3A3D  06              push es
3A3E  57              push di
3A3F  C4 3E 58 DD     les di, ptr [0xdd58]
3A43  06              push es
3A44  57              push di
3A45  68 A0 0F        push 0xfa0
3A48  9A 12 0A B9 26  call far 26B9:0A12
3A4D  9A 9B 09 1A 23  call far 231A:099B
3A52  C4 7E FC        les di, ptr [bp - 4]
3A55  26 8A 45 04     mov al, byte ptr es:[di + 4]
3A59  30 E4           xor ah, ah
3A5B  50              push ax
3A5C  0E              push cs
3A5D  E8 B9 F2        call 0x2d19
loc_3A60:
3A60  C9              leave
3A61  CB              retf

; ---- routine 1B51:3A62  (found by: call, far)
sub_3A62:
3A62  C8 00 01 00     enter 0x100, 0
3A66  C4 3E D2 D7     les di, ptr [0xd7d2]
3A6A  26 8A 05        mov al, byte ptr es:[di]
3A6D  30 E4           xor ah, ah
3A6F  40              inc ax
3A70  3B 46 0A        cmp ax, word ptr [bp + 0xa]
3A73  B0 00           mov al, 0
3A75  75 01           jne 0x3a78
3A77  40              inc ax
loc_3A78:
3A78  30 E4           xor ah, ah
3A7A  C1 E0 07        shl ax, 7
3A7D  8B D0           mov dx, ax
3A7F  8B 7E 0A        mov di, word ptr [bp + 0xa]
3A82  80 BD 6A A2 00  cmp byte ptr [di - 0x5d96], 0
3A87  B0 00           mov al, 0
3A89  75 01           jne 0x3a8c
3A8B  40              inc ax
loc_3A8C:
3A8C  98              cwde
3A8D  8B F8           mov di, ax
3A8F  8A 85 A2 0D     mov al, byte ptr [di + 0xda2]
3A93  30 E4           xor ah, ah
3A95  03 C2           add ax, dx
3A97  50              push ax
3A98  8B 7E 0A        mov di, word ptr [bp + 0xa]
3A9B  8A 85 C7 10     mov al, byte ptr [di + 0x10c7]
3A9F  30 E4           xor ah, ah
3AA1  8B F8           mov di, ax
3AA3  C1 E7 02        shl di, 2
3AA6  81 C7 98 10     add di, 0x1098
3AAA  1E              push ds
3AAB  57              push di
3AAC  8A 46 08        mov al, byte ptr [bp + 8]
3AAF  50              push ax
3AB0  8B 46 06        mov ax, word ptr [bp + 6]
3AB3  2D 04 00        sub ax, 4
3AB6  50              push ax
3AB7  BF 5C DD        mov di, 0xdd5c
3ABA  1E              push ds
3ABB  57              push di
3ABC  9A 1B 04 1A 23  call far 231A:041B
3AC1  8B 7E 0A        mov di, word ptr [bp + 0xa]
3AC4  80 BD 01 11 00  cmp byte ptr [di + 0x1101], 0
3AC9  74 2A           je 0x3af5
3ACB  8D BE 00 FF     lea di, [bp - 0x100]
3ACF  16              push ss
3AD0  57              push di
3AD1  8B 7E 0A        mov di, word ptr [bp + 0xa]
3AD4  8A 85 01 11     mov al, byte ptr [di + 0x1101]
3AD8  30 E4           xor ah, ah
3ADA  31 D2           xor dx, dx
3ADC  52              push dx
3ADD  50              push ax
3ADE  9A C9 07 1A 23  call far 231A:07C9
3AE3  8A 46 08        mov al, byte ptr [bp + 8]
3AE6  50              push ax
3AE7  8A 46 06        mov al, byte ptr [bp + 6]
3AEA  50              push ax
3AEB  BF 5C DD        mov di, 0xdd5c
3AEE  1E              push ds
3AEF  57              push di
3AF0  9A 9D 03 1A 23  call far 231A:039D
loc_3AF5:
3AF5  C9              leave
3AF6  CA 06 00        retf 6

; ---- routine 1B51:3AF9  (found by: call, far)
sub_3AF9:
3AF9  C8 06 00 00     enter 6, 0
3AFD  80 7E 08 03     cmp byte ptr [bp + 8], 3
3B01  75 06           jne 0x3b09
3B03  80 7E 0A 19     cmp byte ptr [bp + 0xa], 0x19
3B07  77 28           ja 0x3b31
loc_3B09:
3B09  80 7E 08 04     cmp byte ptr [bp + 8], 4
3B0D  75 06           jne 0x3b15
3B0F  80 7E 0A 29     cmp byte ptr [bp + 0xa], 0x29
3B13  77 1C           ja 0x3b31
loc_3B15:
3B15  80 7E 08 06     cmp byte ptr [bp + 8], 6
3B19  75 06           jne 0x3b21
3B1B  80 7E 0A 39     cmp byte ptr [bp + 0xa], 0x39
3B1F  74 10           je 0x3b31
loc_3B21:
3B21  80 7E 08 07     cmp byte ptr [bp + 8], 7
3B25  75 06           jne 0x3b2d
3B27  80 7E 0A 30     cmp byte ptr [bp + 0xa], 0x30
3B2B  74 04           je 0x3b31
loc_3B2D:
3B2D  B0 00           mov al, 0
3B2F  EB 02           jmp 0x3b33
loc_3B31:
3B31  B0 01           mov al, 1
loc_3B33:
3B33  88 46 FF        mov byte ptr [bp - 1], al
3B36  8A 46 0A        mov al, byte ptr [bp + 0xa]
3B39  30 E4           xor ah, ah
3B3B  8B F0           mov si, ax
3B3D  D1 E0           shl ax, 1
3B3F  01 F0           add ax, si
3B41  8B D0           mov dx, ax
3B43  8A 46 0E        mov al, byte ptr [bp + 0xe]
3B46  30 E4           xor ah, ah
3B48  69 C0 AE 00     imul ax, ax, 0xae
3B4C  C4 3E CA D7     les di, ptr [0xd7ca]
3B50  03 F8           add di, ax
3B52  03 FA           add di, dx
3B54  81 C7 4F FF     add di, 0xff4f
3B58  89 7E FA        mov word ptr [bp - 6], di
3B5B  8C 46 FC        mov word ptr [bp - 4], es
3B5E  8A 46 0C        mov al, byte ptr [bp + 0xc]
3B61  26 88 45 01     mov byte ptr es:[di + 1], al
3B65  8A 46 08        mov al, byte ptr [bp + 8]
3B68  26 88 05        mov byte ptr es:[di], al
3B6B  8A 46 06        mov al, byte ptr [bp + 6]
3B6E  30 E4           xor ah, ah
3B70  C1 E0 04        shl ax, 4
3B73  8B D0           mov dx, ax
3B75  8A 46 FF        mov al, byte ptr [bp - 1]
3B78  98              cwde
3B79  8B F8           mov di, ax
3B7B  8A 85 3C 11     mov al, byte ptr [di + 0x113c]
3B7F  30 E4           xor ah, ah
3B81  03 C2           add ax, dx
3B83  C4 7E FA        les di, ptr [bp - 6]
3B86  26 88 45 02     mov byte ptr es:[di + 2], al
3B8A  8A 46 0A        mov al, byte ptr [bp + 0xa]
3B8D  30 E4           xor ah, ah
3B8F  8B F0           mov si, ax
3B91  D1 E0           shl ax, 1
3B93  01 F0           add ax, si
3B95  8B D0           mov dx, ax
3B97  8A 46 0C        mov al, byte ptr [bp + 0xc]
3B9A  30 E4           xor ah, ah
3B9C  69 C0 AE 00     imul ax, ax, 0xae
3BA0  C4 3E CA D7     les di, ptr [0xd7ca]
3BA4  03 F8           add di, ax
3BA6  03 FA           add di, dx
3BA8  81 C7 4F FF     add di, 0xff4f
3BAC  89 7E FA        mov word ptr [bp - 6], di
3BAF  8C 46 FC        mov word ptr [bp - 4], es
3BB2  8A 46 0E        mov al, byte ptr [bp + 0xe]
3BB5  26 88 45 01     mov byte ptr es:[di + 1], al
3BB9  8A 46 08        mov al, byte ptr [bp + 8]
3BBC  26 88 05        mov byte ptr es:[di], al
3BBF  8A 46 06        mov al, byte ptr [bp + 6]
3BC2  30 E4           xor ah, ah
3BC4  C1 E0 04        shl ax, 4
3BC7  8B D0           mov dx, ax
3BC9  8A 46 FF        mov al, byte ptr [bp - 1]
3BCC  98              cwde
3BCD  8B F8           mov di, ax
3BCF  8A 85 3E 11     mov al, byte ptr [di + 0x113e]
3BD3  30 E4           xor ah, ah
3BD5  03 C2           add ax, dx
3BD7  C4 7E FA        les di, ptr [bp - 6]
3BDA  26 88 45 02     mov byte ptr es:[di + 2], al
3BDE  C9              leave
3BDF  CA 0A 00        retf 0xa

; ---- routine 1B51:3BE2  (found by: call)
sub_3BE2:
3BE2  C8 04 00 00     enter 4, 0
3BE6  6A 03           push 3
3BE8  9A 6D 07 1A 23  call far 231A:076D
3BED  89 46 FC        mov word ptr [bp - 4], ax
3BF0  C7 46 FE 01 00  mov word ptr [bp - 2], 1
3BF5  EB 03           jmp 0x3bfa
loc_3BF7:
3BF7  FF 46 FE        inc word ptr [bp - 2]
loc_3BFA:
3BFA  8B 46 FE        mov ax, word ptr [bp - 2]
3BFD  8B 7E FC        mov di, word ptr [bp - 4]
3C00  D1 E7           shl di, 1
3C02  8B F7           mov si, di
3C04  D1 E7           shl di, 1
3C06  01 F7           add di, si
3C08  03 F8           add di, ax
3C0A  8A 85 39 11     mov al, byte ptr [di + 0x1139]
3C0E  30 E4           xor ah, ah
3C10  8B F8           mov di, ax
3C12  81 C7 D5 D7     add di, 0xd7d5
3C16  1E              push ds
3C17  57              push di
3C18  8B 46 FE        mov ax, word ptr [bp - 2]
3C1B  8B 7E FC        mov di, word ptr [bp - 4]
3C1E  D1 E7           shl di, 1
3C20  8B F7           mov si, di
3C22  D1 E7           shl di, 1
3C24  01 F7           add di, si
3C26  03 F8           add di, ax
3C28  8A 85 4B 11     mov al, byte ptr [di + 0x114b]
3C2C  30 E4           xor ah, ah
3C2E  8B F8           mov di, ax
3C30  81 C7 D5 D7     add di, 0xd7d5
3C34  1E              push ds
3C35  57              push di
3C36  6A 08           push 8
3C38  9A 03 02 AC 24  call far 24AC:0203
3C3D  83 7E FE 06     cmp word ptr [bp - 2], 6
3C41  75 B4           jne 0x3bf7
3C43  C9              leave
3C44  C3              ret

; ---- routine 1B51:3C45  (found by: call)
sub_3C45:
3C45  C8 24 00 00     enter 0x24, 0
3C49  C6 46 FF 00     mov byte ptr [bp - 1], 0
3C4D  C4 3E D2 D7     les di, ptr [0xd7d2]
3C51  26 80 BD F5 00 00 cmp byte ptr es:[di + 0xf5], 0
3C57  75 02           jne 0x3c5b
3C59  EB 6B           jmp 0x3cc6
loc_3C5B:
3C5B  9A 68 05 AC 24  call far 24AC:0568
3C60  BF D0 26        mov di, 0x26d0
3C63  1E              push ds
3C64  57              push di
3C65  BF 5C DD        mov di, 0xdd5c
3C68  1E              push ds
3C69  57              push di
3C6A  9A 2F 05 1A 23  call far 231A:052F
3C6F  FF 76 08        push word ptr [bp + 8]
3C72  6A 19           push 0x19
3C74  6A 31           push 0x31
3C76  0E              push cs
3C77  E8 21 D2        call 0xe9b
3C7A  FF 76 06        push word ptr [bp + 6]
3C7D  6A 19           push 0x19
3C7F  6A 35           push 0x35
3C81  0E              push cs
3C82  E8 BE D1        call 0xe43
3C85  FF 76 04        push word ptr [bp + 4]
3C88  6A 19           push 0x19
3C8A  6A 1D           push 0x1d
3C8C  0E              push cs
3C8D  E8 D2 FD        call 0x3a62
3C90  C4 3E 5C DD     les di, ptr [0xdd5c]
3C94  81 C7 00 0F     add di, 0xf00
3C98  06              push es
3C99  57              push di
3C9A  C4 3E 58 DD     les di, ptr [0xdd58]
3C9E  81 C7 00 0F     add di, 0xf00
3CA2  06              push es
3CA3  57              push di
3CA4  68 A0 00        push 0xa0
3CA7  9A C2 01 AC 24  call far 24AC:01C2
3CAC  8D 7E DC        lea di, [bp - 0x24]
3CAF  16              push ss
3CB0  57              push di
3CB1  6A 02           push 2
3CB3  9A 94 0D B9 26  call far 26B9:0D94
3CB8  9A 95 07 1A 23  call far 231A:0795
3CBD  9A 98 05 AC 24  call far 24AC:0598
3CC2  C6 46 FF 01     mov byte ptr [bp - 1], 1
loc_3CC6:
3CC6  8A 46 FF        mov al, byte ptr [bp - 1]
3CC9  C9              leave
3CCA  C2 06 00        ret 6

; ---- routine 1B51:3CCD  (found by: far)
sub_3CCD:
3CCD  C8 BC 00 00     enter 0xbc, 0
3CD1  BF D6 D7        mov di, 0xd7d6
3CD4  1E              push ds
3CD5  57              push di
3CD6  8D BE 44 FF     lea di, [bp - 0xbc]
3CDA  16              push ss
3CDB  57              push di
3CDC  68 B0 00        push 0xb0
3CDF  9A C2 01 AC 24  call far 24AC:01C2
3CE4  C7 46 FE 01 00  mov word ptr [bp - 2], 1
3CE9  EB 03           jmp 0x3cee
loc_3CEB:
3CEB  FF 46 FE        inc word ptr [bp - 2]
loc_3CEE:
3CEE  8B 7E FE        mov di, word ptr [bp - 2]
3CF1  8A 93 43 FF     mov dl, byte ptr [bp + di - 0xbd]
3CF5  8B 7E FE        mov di, word ptr [bp - 2]
3CF8  8A 83 43 FF     mov al, byte ptr [bp + di - 0xbd]
3CFC  30 E4           xor ah, ah
3CFE  6B C0 3E        imul ax, ax, 0x3e
3D01  C4 3E C2 D7     les di, ptr [0xd7c2]
3D05  03 F8           add di, ax
3D07  26 8A 45 F5     mov al, byte ptr es:[di - 0xb]
3D0B  30 E4           xor ah, ah
3D0D  8B F8           mov di, ax
3D0F  88 95 D5 D7     mov byte ptr [di - 0x282b], dl
3D13  81 7E FE B0 00  cmp word ptr [bp - 2], 0xb0
3D18  75 D1           jne 0x3ceb
3D1A  E8 C5 FE        call 0x3be2
3D1D  6A 1E           push 0x1e
3D1F  9A 6D 07 1A 23  call far 231A:076D
3D24  89 46 F8        mov word ptr [bp - 8], ax
3D27  C7 46 FE 01 00  mov word ptr [bp - 2], 1
3D2C  EB 03           jmp 0x3d31
loc_3D2E:
3D2E  FF 46 FE        inc word ptr [bp - 2]
loc_3D31:
3D31  C7 46 FC 01 00  mov word ptr [bp - 4], 1
3D36  EB 03           jmp 0x3d3b
loc_3D38:
3D38  FF 46 FC        inc word ptr [bp - 4]
loc_3D3B:
3D3B  8B 46 FC        mov ax, word ptr [bp - 4]
3D3E  8B 7E FE        mov di, word ptr [bp - 2]
3D41  C1 E7 04        shl di, 4
3D44  03 F8           add di, ax
3D46  80 BD 53 11 00  cmp byte ptr [di + 0x1153], 0
3D4B  75 03           jne 0x3d50
3D4D  E9 F6 00        jmp 0x3e46
loc_3D50:
3D50  8B 46 FC        mov ax, word ptr [bp - 4]
3D53  8B 7E FE        mov di, word ptr [bp - 2]
3D56  C1 E7 04        shl di, 4
3D59  03 F8           add di, ax
3D5B  8A 85 53 11     mov al, byte ptr [di + 0x1153]
3D5F  30 E4           xor ah, ah
3D61  3B 46 F8        cmp ax, word ptr [bp - 8]
3D64  74 03           je 0x3d69
3D66  E9 DD 00        jmp 0x3e46
loc_3D69:
3D69  C7 46 FA 01 00  mov word ptr [bp - 6], 1
3D6E  EB 03           jmp 0x3d73
loc_3D70:
3D70  FF 46 FA        inc word ptr [bp - 6]
loc_3D73:
3D73  8B 7E FA        mov di, word ptr [bp - 6]
3D76  8A 85 63 12     mov al, byte ptr [di + 0x1263]
3D7A  30 E4           xor ah, ah
3D7C  03 46 FE        add ax, word ptr [bp - 2]
3D7F  8B F8           mov di, ax
3D81  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
3D85  30 E4           xor ah, ah
3D87  89 46 F6        mov word ptr [bp - 0xa], ax
3D8A  8B 7E FA        mov di, word ptr [bp - 6]
3D8D  8A 85 63 12     mov al, byte ptr [di + 0x1263]
3D91  30 E4           xor ah, ah
3D93  03 46 FC        add ax, word ptr [bp - 4]
3D96  8B F8           mov di, ax
3D98  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
3D9C  30 E4           xor ah, ah
3D9E  89 46 F4        mov word ptr [bp - 0xc], ax
3DA1  6B 46 F6 3E     imul ax, word ptr [bp - 0xa], 0x3e
3DA5  C4 3E C2 D7     les di, ptr [0xd7c2]
3DA9  03 F8           add di, ax
3DAB  26 80 7D F9 05  cmp byte ptr es:[di - 7], 5
3DB0  7C 11           jl 0x3dc3
3DB2  6B 46 F4 3E     imul ax, word ptr [bp - 0xc], 0x3e
3DB6  C4 3E C2 D7     les di, ptr [0xd7c2]
3DBA  03 F8           add di, ax
3DBC  26 80 7D F9 05  cmp byte ptr es:[di - 7], 5
3DC1  7D 7A           jge 0x3e3d
loc_3DC3:
3DC3  8B 46 06        mov ax, word ptr [bp + 6]
3DC6  8B F0           mov si, ax
3DC8  D1 E0           shl ax, 1
3DCA  01 F0           add ax, si
3DCC  8B D0           mov dx, ax
3DCE  69 46 F6 AE 00  imul ax, word ptr [bp - 0xa], 0xae
3DD3  C4 3E CA D7     les di, ptr [0xd7ca]
3DD7  03 F8           add di, ax
3DD9  03 FA           add di, dx
3DDB  26 80 BD 50 FF 00 cmp byte ptr es:[di - 0xb0], 0
3DE1  75 5A           jne 0x3e3d
3DE3  8B 46 06        mov ax, word ptr [bp + 6]
3DE6  8B F0           mov si, ax
3DE8  D1 E0           shl ax, 1
3DEA  01 F0           add ax, si
3DEC  8B D0           mov dx, ax
3DEE  69 46 F4 AE 00  imul ax, word ptr [bp - 0xc], 0xae
3DF3  C4 3E CA D7     les di, ptr [0xd7ca]
3DF7  03 F8           add di, ax
3DF9  03 FA           add di, dx
3DFB  26 80 BD 50 FF 00 cmp byte ptr es:[di - 0xb0], 0
3E01  75 3A           jne 0x3e3d
3E03  FF 76 F6        push word ptr [bp - 0xa]
3E06  0E              push cs
3E07  E8 D0 CF        call 0xdda
3E0A  08 C0           or al, al
3E0C  75 0B           jne 0x3e19
3E0E  FF 76 F4        push word ptr [bp - 0xc]
3E11  0E              push cs
3E12  E8 C5 CF        call 0xdda
3E15  08 C0           or al, al
3E17  74 10           je 0x3e29
loc_3E19:
3E19  FF 76 F6        push word ptr [bp - 0xa]
3E1C  FF 76 F4        push word ptr [bp - 0xc]
3E1F  FF 76 06        push word ptr [bp + 6]
3E22  E8 20 FE        call 0x3c45
3E25  08 C0           or al, al
3E27  74 14           je 0x3e3d
loc_3E29:
3E29  8A 46 F6        mov al, byte ptr [bp - 0xa]
3E2C  50              push ax
3E2D  8A 46 F4        mov al, byte ptr [bp - 0xc]
3E30  50              push ax
3E31  8A 46 06        mov al, byte ptr [bp + 6]
3E34  50              push ax
3E35  6A 02           push 2
3E37  6A 00           push 0
3E39  0E              push cs
3E3A  E8 BC FC        call 0x3af9
loc_3E3D:
3E3D  83 7E FA 0B     cmp word ptr [bp - 6], 0xb
3E41  74 03           je 0x3e46
3E43  E9 2A FF        jmp 0x3d70
loc_3E46:
3E46  83 7E FC 10     cmp word ptr [bp - 4], 0x10
3E4A  74 03           je 0x3e4f
3E4C  E9 E9 FE        jmp 0x3d38
loc_3E4F:
3E4F  83 7E FE 10     cmp word ptr [bp - 2], 0x10
3E53  74 03           je 0x3e58
3E55  E9 D6 FE        jmp 0x3d2e
loc_3E58:
3E58  8D BE 44 FF     lea di, [bp - 0xbc]
3E5C  16              push ss
3E5D  57              push di
3E5E  BF D6 D7        mov di, 0xd7d6
3E61  1E              push ds
3E62  57              push di
3E63  68 B0 00        push 0xb0
3E66  9A C2 01 AC 24  call far 24AC:01C2
3E6B  C9              leave
3E6C  CA 02 00        retf 2

; ---- routine 1B51:3E6F  (found by: call)
sub_3E6F:
3E6F  C8 B8 00 00     enter 0xb8, 0
3E73  BF D6 D7        mov di, 0xd7d6
3E76  1E              push ds
3E77  57              push di
3E78  8D BE 48 FF     lea di, [bp - 0xb8]
3E7C  16              push ss
3E7D  57              push di
3E7E  68 B0 00        push 0xb0
3E81  9A C2 01 AC 24  call far 24AC:01C2
3E86  C7 46 FE 01 00  mov word ptr [bp - 2], 1
3E8B  EB 03           jmp 0x3e90
loc_3E8D:
3E8D  FF 46 FE        inc word ptr [bp - 2]
loc_3E90:
3E90  8B 7E FE        mov di, word ptr [bp - 2]
3E93  8A 93 47 FF     mov dl, byte ptr [bp + di - 0xb9]
3E97  8B 7E FE        mov di, word ptr [bp - 2]
3E9A  8A 83 47 FF     mov al, byte ptr [bp + di - 0xb9]
3E9E  30 E4           xor ah, ah
3EA0  6B C0 3E        imul ax, ax, 0x3e
3EA3  C4 3E C2 D7     les di, ptr [0xd7c2]
3EA7  03 F8           add di, ax
3EA9  26 8A 45 F5     mov al, byte ptr es:[di - 0xb]
3EAD  30 E4           xor ah, ah
3EAF  8B F8           mov di, ax
3EB1  88 95 D5 D7     mov byte ptr [di - 0x282b], dl
3EB5  81 7E FE B0 00  cmp word ptr [bp - 2], 0xb0
3EBA  75 D1           jne 0x3e8d
3EBC  E8 23 FD        call 0x3be2
3EBF  31 C0           xor ax, ax
3EC1  89 46 F8        mov word ptr [bp - 8], ax
loc_3EC4:
3EC4  83 7E F8 04     cmp word ptr [bp - 8], 4
3EC8  72 03           jb 0x3ecd
3ECA  E9 95 00        jmp 0x3f62
loc_3ECD:
3ECD  FF 46 F8        inc word ptr [bp - 8]
3ED0  C7 46 FE 01 00  mov word ptr [bp - 2], 1
3ED5  EB 03           jmp 0x3eda
loc_3ED7:
3ED7  FF 46 FE        inc word ptr [bp - 2]
loc_3EDA:
3EDA  C7 46 FC 01 00  mov word ptr [bp - 4], 1
3EDF  EB 03           jmp 0x3ee4
loc_3EE1:
3EE1  FF 46 FC        inc word ptr [bp - 4]
loc_3EE4:
3EE4  8B 46 FC        mov ax, word ptr [bp - 4]
3EE7  8B 7E FE        mov di, word ptr [bp - 2]
3EEA  C1 E7 04        shl di, 4
3EED  03 F8           add di, ax
3EEF  80 BD 53 11 00  cmp byte ptr [di + 0x1153], 0
3EF4  74 5A           je 0x3f50
3EF6  8B 46 FC        mov ax, word ptr [bp - 4]
3EF9  8B 7E FE        mov di, word ptr [bp - 2]
3EFC  C1 E7 04        shl di, 4
3EFF  03 F8           add di, ax
3F01  8A 85 53 11     mov al, byte ptr [di + 0x1153]
3F05  8B 7E F8        mov di, word ptr [bp - 8]
3F08  3A 85 6F 12     cmp al, byte ptr [di + 0x126f]
3F0C  75 42           jne 0x3f50
3F0E  C7 46 FA 01 00  mov word ptr [bp - 6], 1
3F13  EB 03           jmp 0x3f18
loc_3F15:
3F15  FF 46 FA        inc word ptr [bp - 6]
loc_3F18:
3F18  8B 7E FA        mov di, word ptr [bp - 6]
3F1B  8A 85 63 12     mov al, byte ptr [di + 0x1263]
3F1F  30 E4           xor ah, ah
3F21  03 46 FE        add ax, word ptr [bp - 2]
3F24  8B F8           mov di, ax
3F26  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
3F2A  50              push ax
3F2B  8B 7E FA        mov di, word ptr [bp - 6]
3F2E  8A 85 63 12     mov al, byte ptr [di + 0x1263]
3F32  30 E4           xor ah, ah
3F34  03 46 FC        add ax, word ptr [bp - 4]
3F37  8B F8           mov di, ax
3F39  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
3F3D  50              push ax
3F3E  8A 46 F8        mov al, byte ptr [bp - 8]
3F41  50              push ax
3F42  6A 01           push 1
3F44  6A 00           push 0
3F46  0E              push cs
3F47  E8 AF FB        call 0x3af9
3F4A  83 7E FA 0B     cmp word ptr [bp - 6], 0xb
3F4E  75 C5           jne 0x3f15
loc_3F50:
3F50  83 7E FC 10     cmp word ptr [bp - 4], 0x10
3F54  75 8B           jne 0x3ee1
3F56  83 7E FE 10     cmp word ptr [bp - 2], 0x10
3F5A  74 03           je 0x3f5f
3F5C  E9 78 FF        jmp 0x3ed7
loc_3F5F:
3F5F  E9 62 FF        jmp 0x3ec4
loc_3F62:
3F62  8D BE 48 FF     lea di, [bp - 0xb8]
3F66  16              push ss
3F67  57              push di
3F68  BF D6 D7        mov di, 0xd7d6
3F6B  1E              push ds
3F6C  57              push di
3F6D  68 B0 00        push 0xb0
3F70  9A C2 01 AC 24  call far 24AC:01C2
3F75  C9              leave
3F76  C2 02 00        ret 2

; ---- routine 1B51:3F79  (found by: far)
sub_3F79:
3F79  C8 08 00 00     enter 8, 0
3F7D  55              push bp
3F7E  E8 EE FE        call 0x3e6f
3F81  C7 46 FE 01 00  mov word ptr [bp - 2], 1
3F86  EB 03           jmp 0x3f8b
loc_3F88:
3F88  FF 46 FE        inc word ptr [bp - 2]
loc_3F8B:
3F8B  C7 46 FC 01 00  mov word ptr [bp - 4], 1
3F90  EB 03           jmp 0x3f95
loc_3F92:
3F92  FF 46 FC        inc word ptr [bp - 4]
loc_3F95:
3F95  8B 46 FC        mov ax, word ptr [bp - 4]
3F98  8B 7E FE        mov di, word ptr [bp - 2]
3F9B  C1 E7 04        shl di, 4
3F9E  03 F8           add di, ax
3FA0  80 BD 53 11 00  cmp byte ptr [di + 0x1153], 0
3FA5  74 56           je 0x3ffd
3FA7  C7 46 FA 01 00  mov word ptr [bp - 6], 1
3FAC  EB 03           jmp 0x3fb1
loc_3FAE:
3FAE  FF 46 FA        inc word ptr [bp - 6]
loc_3FB1:
3FB1  8B 7E FA        mov di, word ptr [bp - 6]
3FB4  8A 85 63 12     mov al, byte ptr [di + 0x1263]
3FB8  30 E4           xor ah, ah
3FBA  03 46 FE        add ax, word ptr [bp - 2]
3FBD  8B F8           mov di, ax
3FBF  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
3FC3  50              push ax
3FC4  8B 7E FA        mov di, word ptr [bp - 6]
3FC7  8A 85 63 12     mov al, byte ptr [di + 0x1263]
3FCB  30 E4           xor ah, ah
3FCD  03 46 FC        add ax, word ptr [bp - 4]
3FD0  8B F8           mov di, ax
3FD2  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
3FD6  50              push ax
3FD7  8B 46 FC        mov ax, word ptr [bp - 4]
3FDA  8B 7E FE        mov di, word ptr [bp - 2]
3FDD  C1 E7 04        shl di, 4
3FE0  03 F8           add di, ax
3FE2  8A 85 53 11     mov al, byte ptr [di + 0x1153]
3FE6  30 E4           xor ah, ah
3FE8  8B F8           mov di, ax
3FEA  8A 85 FD 89     mov al, byte ptr [di - 0x7603]
3FEE  50              push ax
3FEF  6A 00           push 0
3FF1  6A 00           push 0
3FF3  0E              push cs
3FF4  E8 02 FB        call 0x3af9
3FF7  83 7E FA 05     cmp word ptr [bp - 6], 5
3FFB  75 B1           jne 0x3fae
loc_3FFD:
3FFD  83 7E FC 10     cmp word ptr [bp - 4], 0x10
4001  75 8F           jne 0x3f92
4003  83 7E FE 10     cmp word ptr [bp - 2], 0x10
4007  74 03           je 0x400c
4009  E9 7C FF        jmp 0x3f88
loc_400C:
400C  C7 46 FE 01 00  mov word ptr [bp - 2], 1
4011  EB 03           jmp 0x4016
loc_4013:
4013  FF 46 FE        inc word ptr [bp - 2]
loc_4016:
4016  8B 7E FE        mov di, word ptr [bp - 2]
4019  80 BD B9 DC 00  cmp byte ptr [di - 0x2347], 0
401E  74 17           je 0x4037
4020  8B 7E FE        mov di, word ptr [bp - 2]
4023  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
4027  30 E4           xor ah, ah
4029  6B C0 3E        imul ax, ax, 0x3e
402C  C4 3E C2 D7     les di, ptr [0xd7c2]
4030  03 F8           add di, ax
4032  26 C6 45 FC 01  mov byte ptr es:[di - 4], 1
loc_4037:
4037  83 7E FE 02     cmp word ptr [bp - 2], 2
403B  75 D6           jne 0x4013
403D  C9              leave
403E  CB              retf

; ---- routine 1B51:403F  (found by: call, far)
sub_403F:
403F  C8 02 00 00     enter 2, 0
4043  83 7E 06 3A     cmp word ptr [bp + 6], 0x3a
4047  74 24           je 0x406d
4049  8B 46 06        mov ax, word ptr [bp + 6]
404C  8B F0           mov si, ax
404E  D1 E0           shl ax, 1
4050  01 F0           add ax, si
4052  8B D0           mov dx, ax
4054  69 46 08 AE 00  imul ax, word ptr [bp + 8], 0xae
4059  C4 3E CA D7     les di, ptr [0xd7ca]
405D  03 F8           add di, ax
405F  03 FA           add di, dx
4061  26 80 BD 50 FF 00 cmp byte ptr es:[di - 0xb0], 0
4067  74 04           je 0x406d
4069  B0 00           mov al, 0
406B  EB 02           jmp 0x406f
loc_406D:
406D  B0 01           mov al, 1
loc_406F:
406F  88 46 FF        mov byte ptr [bp - 1], al
4072  8A 46 FF        mov al, byte ptr [bp - 1]
4075  C9              leave
4076  CA 04 00        retf 4

; ---- routine 1B51:4079  (found by: call, far)
sub_4079:
4079  C8 46 00 00     enter 0x46, 0
407D  C4 3E D2 D7     les di, ptr [0xd7d2]
4081  89 7E FA        mov word ptr [bp - 6], di
4084  8C 46 FC        mov word ptr [bp - 4], es
4087  FF 76 06        push word ptr [bp + 6]
408A  26 8A 05        mov al, byte ptr es:[di]
408D  30 E4           xor ah, ah
408F  40              inc ax
4090  50              push ax
4091  0E              push cs
4092  E8 AA FF        call 0x403f
4095  08 C0           or al, al
4097  74 03           je 0x409c
4099  E9 DA 00        jmp 0x4176
loc_409C:
409C  C4 7E FA        les di, ptr [bp - 6]
409F  26 8A 05        mov al, byte ptr es:[di]
40A2  30 E4           xor ah, ah
40A4  40              inc ax
40A5  8B F0           mov si, ax
40A7  D1 E0           shl ax, 1
40A9  01 F0           add ax, si
40AB  8B D0           mov dx, ax
40AD  69 46 06 AE 00  imul ax, word ptr [bp + 6], 0xae
40B2  C4 3E CA D7     les di, ptr [0xd7ca]
40B6  03 F8           add di, ax
40B8  03 FA           add di, dx
40BA  26 8A 85 50 FF  mov al, byte ptr es:[di - 0xb0]
40BF  30 E4           xor ah, ah
40C1  89 46 FE        mov word ptr [bp - 2], ax
40C4  8A 46 06        mov al, byte ptr [bp + 6]
40C7  B4 01           mov ah, 1
40C9  BA 20 00        mov dx, 0x20
40CC  9A 1F 0E B9 26  call far 26B9:0E1F
40D1  52              push dx
40D2  50              push ax
40D3  8D 7E DA        lea di, [bp - 0x26]
40D6  16              push ss
40D7  57              push di
40D8  6A 00           push 0
40DA  9A 94 0D B9 26  call far 26B9:0D94
40DF  A0 BA DC        mov al, byte ptr [0xdcba]
40E2  50              push ax
40E3  9A AA 0D B9 26  call far 26B9:0DAA
40E8  A0 BB DC        mov al, byte ptr [0xdcbb]
40EB  50              push ax
40EC  9A AA 0D B9 26  call far 26B9:0DAA
40F1  5F              pop di
40F2  07              pop es
40F3  58              pop ax
40F4  5A              pop dx
40F5  03 FA           add di, dx
40F7  26 84 05        test byte ptr es:[di], al
40FA  75 38           jne 0x4134
40FC  8A 46 FE        mov al, byte ptr [bp - 2]
40FF  B4 01           mov ah, 1
4101  BA 20 00        mov dx, 0x20
4104  9A 1F 0E B9 26  call far 26B9:0E1F
4109  52              push dx
410A  50              push ax
410B  8D 7E BA        lea di, [bp - 0x46]
410E  16              push ss
410F  57              push di
4110  6A 00           push 0
4112  9A 94 0D B9 26  call far 26B9:0D94
4117  A0 BA DC        mov al, byte ptr [0xdcba]
411A  50              push ax
411B  9A AA 0D B9 26  call far 26B9:0DAA
4120  A0 BB DC        mov al, byte ptr [0xdcbb]
4123  50              push ax
4124  9A AA 0D B9 26  call far 26B9:0DAA
4129  5F              pop di
412A  07              pop es
412B  58              pop ax
412C  5A              pop dx
412D  03 FA           add di, dx
412F  26 84 05        test byte ptr es:[di], al
4132  74 02           je 0x4136
loc_4134:
4134  EB 40           jmp 0x4176
loc_4136:
4136  6B 46 06 3E     imul ax, word ptr [bp + 6], 0x3e
413A  C4 3E C2 D7     les di, ptr [0xd7c2]
413E  03 F8           add di, ax
4140  26 80 7D FC 00  cmp byte ptr es:[di - 4], 0
4145  B0 00           mov al, 0
4147  75 01           jne 0x414a
4149  40              inc ax
loc_414A:
414A  8A D0           mov dl, al
414C  6B 46 06 3E     imul ax, word ptr [bp + 6], 0x3e
4150  C4 3E C2 D7     les di, ptr [0xd7c2]
4154  03 F8           add di, ax
4156  26 88 55 FC     mov byte ptr es:[di - 4], dl
415A  6B 46 FE 3E     imul ax, word ptr [bp - 2], 0x3e
415E  C4 3E C2 D7     les di, ptr [0xd7c2]
4162  03 F8           add di, ax
4164  81 C7 C2 FF     add di, 0xffc2
4168  26 80 7D 3A 00  cmp byte ptr es:[di + 0x3a], 0
416D  B0 00           mov al, 0
416F  75 01           jne 0x4172
4171  40              inc ax
loc_4172:
4172  26 88 45 3A     mov byte ptr es:[di + 0x3a], al
loc_4176:
4176  C9              leave
4177  CA 02 00        retf 2

; ---- routine 1B51:417A  (found by: call, far)
sub_417A:
417A  C8 B6 00 00     enter 0xb6, 0
417E  31 C0           xor ax, ax
4180  A3 86 D6        mov word ptr [0xd686], ax
4183  8D BE 50 FF     lea di, [bp - 0xb0]
4187  16              push ss
4188  57              push di
4189  68 B0 00        push 0xb0
418C  6A 00           push 0
418E  9A 22 02 AC 24  call far 24AC:0222
4193  C7 86 4E FF 01 00 mov word ptr [bp - 0xb2], 1
4199  EB 04           jmp 0x419f
loc_419B:
419B  FF 86 4E FF     inc word ptr [bp - 0xb2]
loc_419F:
419F  8B 46 06        mov ax, word ptr [bp + 6]
41A2  8B F0           mov si, ax
41A4  D1 E0           shl ax, 1
41A6  01 F0           add ax, si
41A8  8B D0           mov dx, ax
41AA  8B BE 4E FF     mov di, word ptr [bp - 0xb2]
41AE  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
41B2  30 E4           xor ah, ah
41B4  69 C0 AE 00     imul ax, ax, 0xae
41B8  C4 3E CA D7     les di, ptr [0xd7ca]
41BC  03 F8           add di, ax
41BE  03 FA           add di, dx
41C0  81 C7 4F FF     add di, 0xff4f
41C4  89 BE 4A FF     mov word ptr [bp - 0xb6], di
41C8  8C 86 4C FF     mov word ptr [bp - 0xb4], es
41CC  26 80 7D 01 00  cmp byte ptr es:[di + 1], 0
41D1  74 53           je 0x4226
41D3  26 8A 45 02     mov al, byte ptr es:[di + 2]
41D7  24 0F           and al, 0xf
41D9  08 C0           or al, al
41DB  74 49           je 0x4226
41DD  8B BE 4E FF     mov di, word ptr [bp - 0xb2]
41E1  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
41E5  30 E4           xor ah, ah
41E7  8B F8           mov di, ax
41E9  80 BB 4F FF 00  cmp byte ptr [bp + di - 0xb1], 0
41EE  75 36           jne 0x4226
41F0  8B BE 4E FF     mov di, word ptr [bp - 0xb2]
41F4  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
41F8  30 E4           xor ah, ah
41FA  8B F8           mov di, ax
41FC  C6 83 4F FF 01  mov byte ptr [bp + di - 0xb1], 1
4201  C4 BE 4A FF     les di, ptr [bp - 0xb6]
4205  26 8A 45 01     mov al, byte ptr es:[di + 1]
4209  30 E4           xor ah, ah
420B  8B F8           mov di, ax
420D  C6 83 4F FF 01  mov byte ptr [bp + di - 0xb1], 1
4212  FF 06 86 D6     inc word ptr [0xd686]
4216  8B BE 4E FF     mov di, word ptr [bp - 0xb2]
421A  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
421E  8B 3E 86 D6     mov di, word ptr [0xd686]
4222  88 85 FB D4     mov byte ptr [di - 0x2b05], al
loc_4226:
4226  81 BE 4E FF B0 00 cmp word ptr [bp - 0xb2], 0xb0
422C  74 03           je 0x4231
422E  E9 6A FF        jmp 0x419b
loc_4231:
4231  C9              leave
4232  CA 02 00        retf 2
; data (not reached as code), 2 bytes
4235                  db 01 FB   ; ..

; ---- routine 1B51:4237  (found by: far)
sub_4237:
4237  C8 10 01 00     enter 0x110, 0
423B  8B 46 06        mov ax, word ptr [bp + 6]
423E  40              inc ax
423F  3D 3A 00        cmp ax, 0x3a
4242  76 03           jbe 0x4247
4244  E9 F1 01        jmp 0x4438
loc_4247:
4247  8B 7E 06        mov di, word ptr [bp + 6]
424A  80 BD 6A A2 00  cmp byte ptr [di - 0x5d96], 0
424F  75 09           jne 0x425a
4251  FF 76 06        push word ptr [bp + 6]
4254  0E              push cs
4255  E8 07 36        call 0x785f
4258  EB 07           jmp 0x4261
loc_425A:
425A  FF 76 06        push word ptr [bp + 6]
425D  0E              push cs
425E  E8 19 FF        call 0x417a
loc_4261:
4261  83 3E 86 D6 00  cmp word ptr [0xd686], 0
4266  75 03           jne 0x426b
4268  E9 CD 01        jmp 0x4438
loc_426B:
426B  C7 46 F8 01 00  mov word ptr [bp - 8], 1
4270  C6 46 FF 01     mov byte ptr [bp - 1], 1
loc_4274:
4274  BF 06 29        mov di, 0x2906
4277  1E              push ds
4278  57              push di
4279  BF 5C DD        mov di, 0xdd5c
427C  1E              push ds
427D  57              push di
427E  9A 2F 05 1A 23  call far 231A:052F
4283  BF 42 43        mov di, 0x4342
4286  1E              push ds
4287  57              push di
4288  BF 5C DD        mov di, 0xdd5c
428B  1E              push ds
428C  57              push di
428D  9A 2F 05 1A 23  call far 231A:052F
4292  6A 0B           push 0xb
4294  8D BE F6 FE     lea di, [bp - 0x10a]
4298  16              push ss
4299  57              push di
429A  8B 46 06        mov ax, word ptr [bp + 6]
429D  31 D2           xor dx, dx
429F  52              push dx
42A0  50              push ax
42A1  9A C9 07 1A 23  call far 231A:07C9
42A6  6A 02           push 2
42A8  6A 18           push 0x18
42AA  BF 5C DD        mov di, 0xdd5c
42AD  1E              push ds
42AE  57              push di
42AF  9A 0C 03 1A 23  call far 231A:030C
42B4  C7 46 FA 06 00  mov word ptr [bp - 6], 6
42B9  8A 46 FF        mov al, byte ptr [bp - 1]
42BC  30 E4           xor ah, ah
42BE  03 46 F8        add ax, word ptr [bp - 8]
42C1  48              dec ax
42C2  89 46 F6        mov word ptr [bp - 0xa], ax
42C5  8B 46 F8        mov ax, word ptr [bp - 8]
42C8  05 0F 00        add ax, 0xf
42CB  89 46 F4        mov word ptr [bp - 0xc], ax
42CE  8B 46 F8        mov ax, word ptr [bp - 8]
42D1  3B 46 F4        cmp ax, word ptr [bp - 0xc]
42D4  76 03           jbe 0x42d9
42D6  E9 DD 00        jmp 0x43b6
loc_42D9:
42D9  89 46 FC        mov word ptr [bp - 4], ax
42DC  EB 03           jmp 0x42e1
loc_42DE:
42DE  FF 46 FC        inc word ptr [bp - 4]
loc_42E1:
42E1  8B 46 FC        mov ax, word ptr [bp - 4]
42E4  3B 06 86 D6     cmp ax, word ptr [0xd686]
42E8  76 03           jbe 0x42ed
42EA  E9 BE 00        jmp 0x43ab
loc_42ED:
42ED  6A 05           push 5
42EF  8D BE F4 FE     lea di, [bp - 0x10c]
42F3  16              push ss
42F4  57              push di
42F5  8B 46 FC        mov ax, word ptr [bp - 4]
42F8  31 D2           xor dx, dx
42FA  52              push dx
42FB  50              push ax
42FC  9A C9 07 1A 23  call far 231A:07C9
4301  8A 46 FA        mov al, byte ptr [bp - 6]
4304  50              push ax
4305  6A 11           push 0x11
4307  BF 5C DD        mov di, 0xdd5c
430A  1E              push ds
430B  57              push di
430C  9A 0C 03 1A 23  call far 231A:030C
4311  8B 46 06        mov ax, word ptr [bp + 6]
4314  8B F0           mov si, ax
4316  D1 E0           shl ax, 1
4318  01 F0           add ax, si
431A  8B D0           mov dx, ax
431C  8B 7E FC        mov di, word ptr [bp - 4]
431F  8A 85 FB D4     mov al, byte ptr [di - 0x2b05]
4323  30 E4           xor ah, ah
4325  69 C0 AE 00     imul ax, ax, 0xae
4329  C4 3E CA D7     les di, ptr [0xd7ca]
432D  03 F8           add di, ax
432F  03 FA           add di, dx
4331  81 C7 4F FF     add di, 0xff4f
4335  89 7E F0        mov word ptr [bp - 0x10], di
4338  8C 46 F2        mov word ptr [bp - 0xe], es
433B  8B 7E FC        mov di, word ptr [bp - 4]
433E  8A 85 FB D4     mov al, byte ptr [di - 0x2b05]
4342  30 E4           xor ah, ah
4344  6B C0 3E        imul ax, ax, 0x3e
4347  C4 3E C2 D7     les di, ptr [0xd7c2]
434B  03 F8           add di, ax
434D  26 80 7D FC 00  cmp byte ptr es:[di - 4], 0
4352  74 17           je 0x436b
4354  6A 0E           push 0xe
4356  BF 35 42        mov di, 0x4235
4359  0E              push cs
435A  57              push di
435B  8A 46 FA        mov al, byte ptr [bp - 6]
435E  50              push ax
435F  6A 13           push 0x13
4361  BF 5C DD        mov di, 0xdd5c
4364  1E              push ds
4365  57              push di
4366  9A 1B 04 1A 23  call far 231A:041B
loc_436B:
436B  8B 7E FC        mov di, word ptr [bp - 4]
436E  8A 85 FB D4     mov al, byte ptr [di - 0x2b05]
4372  30 E4           xor ah, ah
4374  50              push ax
4375  FF 76 06        push word ptr [bp + 6]
4378  FF 76 FA        push word ptr [bp - 6]
437B  6A 27           push 0x27
437D  0E              push cs
437E  E8 5C D2        call 0x15dd
4381  6A 05           push 5
4383  8D BE F0 FE     lea di, [bp - 0x110]
4387  16              push ss
4388  57              push di
4389  C4 7E F0        les di, ptr [bp - 0x10]
438C  26 8A 05        mov al, byte ptr es:[di]
438F  50              push ax
4390  8A 46 06        mov al, byte ptr [bp + 6]
4393  50              push ax
4394  0E              push cs
4395  E8 F3 CF        call 0x138b
4398  8A 46 FA        mov al, byte ptr [bp - 6]
439B  50              push ax
439C  6A 3E           push 0x3e
439E  BF 5C DD        mov di, 0xdd5c
43A1  1E              push ds
43A2  57              push di
43A3  9A 1B 04 1A 23  call far 231A:041B
43A8  FF 46 FA        inc word ptr [bp - 6]
loc_43AB:
43AB  8B 46 FC        mov ax, word ptr [bp - 4]
43AE  3B 46 F4        cmp ax, word ptr [bp - 0xc]
43B1  74 03           je 0x43b6
43B3  E9 28 FF        jmp 0x42de
loc_43B6:
43B6  BF FC 1C        mov di, 0x1cfc
43B9  1E              push ds
43BA  57              push di
43BB  BF 5C DD        mov di, 0xdd5c
43BE  1E              push ds
43BF  57              push di
43C0  9A 2F 05 1A 23  call far 231A:052F
43C5  8A 46 FF        mov al, byte ptr [bp - 1]
43C8  30 E4           xor ah, ah
43CA  05 05 00        add ax, 5
43CD  50              push ax
43CE  6A 13           push 0x13
43D0  6A 01           push 1
43D2  9A 03 02 1A 23  call far 231A:0203
43D7  FF 76 F6        push word ptr [bp - 0xa]
43DA  6A 01           push 1
43DC  FF 36 86 D6     push word ptr [0xd686]
43E0  6A 17           push 0x17
43E2  6A 16           push 0x16
43E4  9A 67 01 1A 23  call far 231A:0167
43E9  C4 3E 5C DD     les di, ptr [0xdd5c]
43ED  06              push es
43EE  57              push di
43EF  C4 3E 58 DD     les di, ptr [0xdd58]
43F3  06              push es
43F4  57              push di
43F5  68 A0 0F        push 0xfa0
43F8  9A 12 0A B9 26  call far 26B9:0A12
43FD  9A 9B 09 1A 23  call far 231A:099B
4402  A0 88 DE        mov al, byte ptr [0xde88]
4405  3C 02           cmp al, 2
4407  75 10           jne 0x4419
4409  8B 7E F6        mov di, word ptr [bp - 0xa]
440C  8A 85 FB D4     mov al, byte ptr [di - 0x2b05]
4410  30 E4           xor ah, ah
4412  50              push ax
4413  0E              push cs
4414  E8 62 FC        call 0x4079
4417  EB 15           jmp 0x442e
loc_4419:
4419  8D 7E FF        lea di, [bp - 1]
441C  16              push ss
441D  57              push di
441E  8D 7E F8        lea di, [bp - 8]
4421  16              push ss
4422  57              push di
4423  6A 10           push 0x10
4425  FF 36 86 D6     push word ptr [0xd686]
4429  9A D7 0F 1A 23  call far 231A:0FD7
loc_442E:
442E  80 3E 88 DE 01  cmp byte ptr [0xde88], 1
4433  74 03           je 0x4438
4435  E9 3C FE        jmp 0x4274
loc_4438:
4438  C9              leave
4439  CA 02 00        retf 2

