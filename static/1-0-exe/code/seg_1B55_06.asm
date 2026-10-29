; 1-0.EXE (One-Nil 96), code segment 1B55 (image offsets 1B550..2315F), part 6 of 12
; packed 1-0.EXE sha256 89ff9c5f238f24e81a0c2440a46cdd8997280a65fc3cc3d97cb974f55280a80a (LZEXE 0.91)
; unpacked (tools/static/unlzexe.py) sha256 887ed2a92767950e5309b2052409f875668605939b69e00737aa3047022b9f51
; tool: capstone 5.0.9 (pip package; core library 5.0.1280) (CS_ARCH_X86, CS_MODE_16), recursive descent from the entry point, far calls and near calls/jumps, then routine prologues (55 89 E5 / 55 8B EC / C8 iw 00) in what remains; tools/static/listing.py
; addresses are SEGMENT:OFFSET with SEGMENT the image paragraph before relocation; image offset = SEGMENT*16+OFFSET
; ---- routine 1B55:35F5  (found by: call)
sub_35F5:
35F5  C8 08 00 00     enter 8, 0
35F9  FF 76 06        push word ptr [bp + 6]
35FC  0E              push cs
35FD  E8 5B F0        call 0x265b
3600  8B D0           mov dx, ax
3602  6B 46 06 3E     imul ax, word ptr [bp + 6], 0x3e
3606  C4 3E C2 D7     les di, ptr [0xd7c2]
360A  03 F8           add di, ax
360C  26 8B 45 F2     mov ax, word ptr es:[di - 0xe]
3610  C1 E0 02        shl ax, 2
3613  C4 3E C8 DC     les di, ptr [0xdcc8]
3617  03 F8           add di, ax
3619  26 8A 45 02     mov al, byte ptr es:[di + 2]
361D  30 E4           xor ah, ah
361F  03 C2           add ax, dx
3621  99              cdq
3622  B9 02 00        mov cx, 2
3625  F7 F9           idiv cx
3627  99              cdq
3628  89 46 F8        mov word ptr [bp - 8], ax
362B  89 56 FA        mov word ptr [bp - 6], dx
362E  8B 46 F8        mov ax, word ptr [bp - 8]
3631  8B 56 FA        mov dx, word ptr [bp - 6]
3634  B9 10 27        mov cx, 0x2710
3637  31 DB           xor bx, bx
3639  9A 2A 0A C9 26  call far 26C9:0A2A
363E  89 46 FC        mov word ptr [bp - 4], ax
3641  89 56 FE        mov word ptr [bp - 2], dx
3644  8B 46 FC        mov ax, word ptr [bp - 4]
3647  8B 56 FE        mov dx, word ptr [bp - 2]
364A  C9              leave
364B  CA 02 00        retf 2

; ---- routine 1B55:364E  (found by: call, far)
sub_364E:
364E  C8 04 00 00     enter 4, 0
3652  FF 76 06        push word ptr [bp + 6]
3655  0E              push cs
3656  E8 9C FF        call 0x35f5
3659  B9 02 00        mov cx, 2
365C  31 DB           xor bx, bx
365E  9A 2A 0A C9 26  call far 26C9:0A2A
3663  89 46 FC        mov word ptr [bp - 4], ax
3666  89 56 FE        mov word ptr [bp - 2], dx
3669  8B 46 FC        mov ax, word ptr [bp - 4]
366C  8B 56 FE        mov dx, word ptr [bp - 2]
366F  C9              leave
3670  CA 02 00        retf 2

; ---- routine 1B55:3673  (found by: call)
sub_3673:
3673  C8 08 00 00     enter 8, 0
3677  6B 46 06 5E     imul ax, word ptr [bp + 6], 0x5e
367B  C4 3E C4 DC     les di, ptr [0xdcc4]
367F  03 F8           add di, ax
3681  81 C7 A2 FF     add di, 0xffa2
3685  26 8B 45 52     mov ax, word ptr es:[di + 0x52]
3689  26 8B 55 54     mov dx, word ptr es:[di + 0x54]
368D  26 2B 45 32     sub ax, word ptr es:[di + 0x32]
3691  26 1B 55 34     sbb dx, word ptr es:[di + 0x34]
3695  26 2B 45 3A     sub ax, word ptr es:[di + 0x3a]
3699  26 1B 55 3C     sbb dx, word ptr es:[di + 0x3c]
369D  26 03 45 2A     add ax, word ptr es:[di + 0x2a]
36A1  26 13 55 2C     adc dx, word ptr es:[di + 0x2c]
36A5  89 46 FC        mov word ptr [bp - 4], ax
36A8  89 56 FE        mov word ptr [bp - 2], dx
36AB  8B 46 FC        mov ax, word ptr [bp - 4]
36AE  8B 56 FE        mov dx, word ptr [bp - 2]
36B1  C9              leave
36B2  CA 02 00        retf 2

; ---- routine 1B55:36B5  (found by: far)
sub_36B5:
36B5  C8 02 00 00     enter 2, 0
36B9  8B 7E 06        mov di, word ptr [bp + 6]
36BC  80 BD B9 DC 00  cmp byte ptr [di - 0x2347], 0
36C1  74 41           je 0x3704
36C3  FF 76 06        push word ptr [bp + 6]
36C6  0E              push cs
36C7  E8 A9 FF        call 0x3673
36CA  83 FA 00        cmp dx, 0
36CD  7C 07           jl 0x36d6
36CF  7F 33           jg 0x3704
36D1  3D 00 00        cmp ax, 0
36D4  73 2E           jae 0x3704
loc_36D6:
36D6  8B 7E 06        mov di, word ptr [bp + 6]
36D9  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
36DD  30 E4           xor ah, ah
36DF  50              push ax
36E0  0E              push cs
36E1  E8 6A FF        call 0x364e
36E4  52              push dx
36E5  50              push ax
36E6  FF 76 06        push word ptr [bp + 6]
36E9  0E              push cs
36EA  E8 86 FF        call 0x3673
36ED  09 D2           or dx, dx
36EF  79 07           jns 0x36f8
36F1  F7 D2           not dx
36F3  F7 D8           neg ax
36F5  83 DA FF        sbb dx, -1
loc_36F8:
36F8  59              pop cx
36F9  5B              pop bx
36FA  3B D3           cmp dx, bx
36FC  7F 0A           jg 0x3708
36FE  7C 04           jl 0x3704
3700  3B C1           cmp ax, cx
3702  77 04           ja 0x3708
loc_3704:
3704  B0 00           mov al, 0
3706  EB 02           jmp 0x370a
loc_3708:
3708  B0 01           mov al, 1
loc_370A:
370A  88 46 FF        mov byte ptr [bp - 1], al
370D  8A 46 FF        mov al, byte ptr [bp - 1]
3710  C9              leave
3711  CA 02 00        retf 2

; ---- routine 1B55:3714  (found by: call)
sub_3714:
3714  C8 06 00 00     enter 6, 0
3718  C7 46 FE 01 00  mov word ptr [bp - 2], 1
371D  EB 03           jmp 0x3722
loc_371F:
371F  FF 46 FE        inc word ptr [bp - 2]
loc_3722:
3722  8B 46 FE        mov ax, word ptr [bp - 2]
3725  D1 E0           shl ax, 1
3727  C4 7E 06        les di, ptr [bp + 6]
372A  03 F8           add di, ax
372C  26 83 7D FE 00  cmp word ptr es:[di - 2], 0
3731  74 4D           je 0x3780
3733  8B 46 FE        mov ax, word ptr [bp - 2]
3736  D1 E0           shl ax, 1
3738  C4 7E 06        les di, ptr [bp + 6]
373B  03 F8           add di, ax
373D  26 8B 45 FE     mov ax, word ptr es:[di - 2]
3741  C1 E0 03        shl ax, 3
3744  C4 3E BA D7     les di, ptr [0xd7ba]
3748  03 F8           add di, ax
374A  26 80 7D 01 11  cmp byte ptr es:[di + 1], 0x11
374F  76 2F           jbe 0x3780
3751  8B 46 FE        mov ax, word ptr [bp - 2]
3754  D1 E0           shl ax, 1
3756  C4 7E 06        les di, ptr [bp + 6]
3759  03 F8           add di, ax
375B  26 6B 45 FE 0F  imul ax, word ptr es:[di - 2], 0xf
3760  C4 3E BE D7     les di, ptr [0xd7be]
3764  03 F8           add di, ax
3766  26 80 7D 0C 00  cmp byte ptr es:[di + 0xc], 0
376B  76 13           jbe 0x3780
376D  26 80 7D 0D 02  cmp byte ptr es:[di + 0xd], 2
3772  74 0C           je 0x3780
3774  26 C6 45 0D 02  mov byte ptr es:[di + 0xd], 2
3779  8B 7E 04        mov di, word ptr [bp + 4]
377C  36 FF 45 FE     inc word ptr ss:[di - 2]
loc_3780:
3780  83 7E FE 14     cmp word ptr [bp - 2], 0x14
3784  75 99           jne 0x371f
3786  C9              leave
3787  C2 06 00        ret 6

; ---- routine 1B55:378A  (found by: far)
sub_378A:
378A  C8 C2 00 00     enter 0xc2, 0
378E  31 C0           xor ax, ax
3790  89 46 FE        mov word ptr [bp - 2], ax
3793  8B 7E 06        mov di, word ptr [bp + 6]
3796  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
379A  30 E4           xor ah, ah
379C  6B C0 3E        imul ax, ax, 0x3e
379F  C4 3E C2 D7     les di, ptr [0xd7c2]
37A3  03 F8           add di, ax
37A5  81 C7 C2 FF     add di, 0xffc2
37A9  06              push es
37AA  57              push di
37AB  55              push bp
37AC  E8 65 FF        call 0x3714
37AF  6B 46 06 28     imul ax, word ptr [bp + 6], 0x28
37B3  C4 3E D2 D7     les di, ptr [0xd7d2]
37B7  03 F8           add di, ax
37B9  81 C7 30 00     add di, 0x30
37BD  06              push es
37BE  57              push di
37BF  55              push bp
37C0  E8 51 FF        call 0x3714
37C3  83 7E FE 00     cmp word ptr [bp - 2], 0
37C7  75 03           jne 0x37cc
37C9  E9 7F 00        jmp 0x384b
loc_37CC:
37CC  C4 3E 58 DD     les di, ptr [0xdd58]
37D0  81 C7 00 0F     add di, 0xf00
37D4  06              push es
37D5  57              push di
37D6  8D BE 5E FF     lea di, [bp - 0xa2]
37DA  16              push ss
37DB  57              push di
37DC  68 A0 00        push 0xa0
37DF  9A C2 01 BC 24  call far 24BC:01C2
37E4  BF 6A 2E        mov di, 0x2e6a
37E7  1E              push ds
37E8  57              push di
37E9  BF 5C DD        mov di, 0xdd5c
37EC  1E              push ds
37ED  57              push di
37EE  9A 2F 05 2A 23  call far 232A:052F
37F3  8B 7E 06        mov di, word ptr [bp + 6]
37F6  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
37FA  30 E4           xor ah, ah
37FC  50              push ax
37FD  6A 19           push 0x19
37FF  6A 01           push 1
3801  0E              push cs
3802  E8 DE D6        call 0xee3
3805  C4 3E 5C DD     les di, ptr [0xdd5c]
3809  81 C7 00 0F     add di, 0xf00
380D  06              push es
380E  57              push di
380F  C4 3E 58 DD     les di, ptr [0xdd58]
3813  81 C7 00 0F     add di, 0xf00
3817  06              push es
3818  57              push di
3819  68 A0 00        push 0xa0
381C  9A C2 01 BC 24  call far 24BC:01C2
3821  8D BE 3E FF     lea di, [bp - 0xc2]
3825  16              push ss
3826  57              push di
3827  6A 02           push 2
3829  9A 94 0D C9 26  call far 26C9:0D94
382E  9A 95 07 2A 23  call far 232A:0795
3833  8D BE 5E FF     lea di, [bp - 0xa2]
3837  16              push ss
3838  57              push di
3839  C4 3E 58 DD     les di, ptr [0xdd58]
383D  81 C7 00 0F     add di, 0xf00
3841  06              push es
3842  57              push di
3843  68 A0 00        push 0xa0
3846  9A C2 01 BC 24  call far 24BC:01C2
loc_384B:
384B  C9              leave
384C  CA 02 00        retf 2
; data (not reached as code), 38 bytes
384F                  pstr "Your chairman won't release the money"

; ---- routine 1B55:3875  (found by: far)
sub_3875:
3875  C8 02 00 00     enter 2, 0
3879  8B 7E 0A        mov di, word ptr [bp + 0xa]
387C  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
3880  30 E4           xor ah, ah
3882  50              push ax
3883  0E              push cs
3884  E8 C7 FD        call 0x364e
3887  F7 D2           not dx
3889  F7 D8           neg ax
388B  83 DA FF        sbb dx, -1
388E  2D 20 4E        sub ax, 0x4e20
3891  83 DA 00        sbb dx, 0
3894  52              push dx
3895  50              push ax
3896  FF 76 0A        push word ptr [bp + 0xa]
3899  0E              push cs
389A  E8 D6 FD        call 0x3673
389D  2B 46 06        sub ax, word ptr [bp + 6]
38A0  1B 56 08        sbb dx, word ptr [bp + 8]
38A3  59              pop cx
38A4  5B              pop bx
38A5  3B D3           cmp dx, bx
38A7  7C 0A           jl 0x38b3
38A9  7F 04           jg 0x38af
38AB  3B C1           cmp ax, cx
38AD  72 04           jb 0x38b3
loc_38AF:
38AF  B0 00           mov al, 0
38B1  EB 02           jmp 0x38b5
loc_38B3:
38B3  B0 01           mov al, 1
loc_38B5:
38B5  50              push ax
38B6  BF 4F 38        mov di, 0x384f
38B9  0E              push cs
38BA  57              push di
38BB  9A 98 00 2A 23  call far 232A:0098
38C0  88 46 FF        mov byte ptr [bp - 1], al
38C3  8A 46 FF        mov al, byte ptr [bp - 1]
38C6  C9              leave
38C7  CA 06 00        retf 6

; ---- routine 1B55:38CA  (found by: far)
sub_38CA:
38CA  C8 04 00 00     enter 4, 0
38CE  FF 76 06        push word ptr [bp + 6]
38D1  0E              push cs
38D2  E8 20 FD        call 0x35f5
38D5  B9 04 00        mov cx, 4
38D8  31 DB           xor bx, bx
38DA  9A 67 0A C9 26  call far 26C9:0A67
38DF  89 46 FC        mov word ptr [bp - 4], ax
38E2  89 56 FE        mov word ptr [bp - 2], dx
38E5  8B 46 FC        mov ax, word ptr [bp - 4]
38E8  8B 56 FE        mov dx, word ptr [bp - 2]
38EB  C9              leave
38EC  CA 02 00        retf 2

; ---- routine 1B55:38EF  (found by: far)
sub_38EF:
38EF  C8 08 00 00     enter 8, 0
38F3  C4 3E D2 D7     les di, ptr [0xd7d2]
38F7  89 7E FC        mov word ptr [bp - 4], di
38FA  8C 46 FE        mov word ptr [bp - 2], es
38FD  26 8A 45 04     mov al, byte ptr es:[di + 4]
3901  30 E4           xor ah, ah
3903  8B F8           mov di, ax
3905  80 BD B9 DC 00  cmp byte ptr [di - 0x2347], 0
390A  75 03           jne 0x390f
390C  E9 F1 01        jmp 0x3b00
loc_390F:
390F  BF C4 7C        mov di, 0x7cc4
3912  1E              push ds
3913  57              push di
3914  BF 5C DD        mov di, 0xdd5c
3917  1E              push ds
3918  57              push di
3919  9A 2F 05 2A 23  call far 232A:052F
391E  C4 7E FC        les di, ptr [bp - 4]
3921  26 8A 45 04     mov al, byte ptr es:[di + 4]
3925  30 E4           xor ah, ah
3927  8B F8           mov di, ax
3929  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
392D  30 E4           xor ah, ah
392F  50              push ax
3930  6A 02           push 2
3932  6A 15           push 0x15
3934  0E              push cs
3935  E8 AB D5        call 0xee3
3938  C4 7E FC        les di, ptr [bp - 4]
393B  26 8A 45 04     mov al, byte ptr es:[di + 4]
393F  30 E4           xor ah, ah
3941  6B C0 5E        imul ax, ax, 0x5e
3944  C4 3E C4 DC     les di, ptr [0xdcc4]
3948  03 F8           add di, ax
394A  81 C7 A2 FF     add di, 0xffa2
394E  89 7E F8        mov word ptr [bp - 8], di
3951  8C 46 FA        mov word ptr [bp - 6], es
3954  C7 06 64 DD 70 00 mov word ptr [0xdd64], 0x70
395A  26 FF 75 20     push word ptr es:[di + 0x20]
395E  26 FF 75 1E     push word ptr es:[di + 0x1e]
3962  6A 06           push 6
3964  6A 26           push 0x26
3966  0E              push cs
3967  E8 B4 D6        call 0x101e
396A  C4 7E F8        les di, ptr [bp - 8]
396D  26 FF 75 28     push word ptr es:[di + 0x28]
3971  26 FF 75 26     push word ptr es:[di + 0x26]
3975  6A 08           push 8
3977  6A 26           push 0x26
3979  0E              push cs
397A  E8 A1 D6        call 0x101e
397D  C4 7E F8        les di, ptr [bp - 8]
3980  26 FF 75 08     push word ptr es:[di + 8]
3984  26 FF 75 06     push word ptr es:[di + 6]
3988  6A 0A           push 0xa
398A  6A 26           push 0x26
398C  0E              push cs
398D  E8 8E D6        call 0x101e
3990  C4 7E F8        les di, ptr [bp - 8]
3993  26 FF 75 0C     push word ptr es:[di + 0xc]
3997  26 FF 75 0A     push word ptr es:[di + 0xa]
399B  6A 0C           push 0xc
399D  6A 26           push 0x26
399F  0E              push cs
39A0  E8 7B D6        call 0x101e
39A3  C4 7E F8        les di, ptr [bp - 8]
39A6  26 FF 75 30     push word ptr es:[di + 0x30]
39AA  26 FF 75 2E     push word ptr es:[di + 0x2e]
39AE  6A 0E           push 0xe
39B0  6A 26           push 0x26
39B2  0E              push cs
39B3  E8 68 D6        call 0x101e
39B6  C4 7E F8        les di, ptr [bp - 8]
39B9  26 FF 75 10     push word ptr es:[di + 0x10]
39BD  26 FF 75 0E     push word ptr es:[di + 0xe]
39C1  6A 10           push 0x10
39C3  6A 26           push 0x26
39C5  0E              push cs
39C6  E8 55 D6        call 0x101e
39C9  C4 7E F8        les di, ptr [bp - 8]
39CC  26 FF 75 14     push word ptr es:[di + 0x14]
39D0  26 FF 75 12     push word ptr es:[di + 0x12]
39D4  6A 12           push 0x12
39D6  6A 26           push 0x26
39D8  0E              push cs
39D9  E8 42 D6        call 0x101e
39DC  C4 7E F8        les di, ptr [bp - 8]
39DF  26 FF 75 58     push word ptr es:[di + 0x58]
39E3  26 FF 75 56     push word ptr es:[di + 0x56]
39E7  6A 14           push 0x14
39E9  6A 26           push 0x26
39EB  0E              push cs
39EC  E8 2F D6        call 0x101e
39EF  C7 06 64 DD 40 00 mov word ptr [0xdd64], 0x40
39F5  C4 7E F8        les di, ptr [bp - 8]
39F8  26 FF 75 4C     push word ptr es:[di + 0x4c]
39FC  26 FF 75 4A     push word ptr es:[di + 0x4a]
3A00  6A 04           push 4
3A02  6A 4F           push 0x4f
3A04  0E              push cs
3A05  E8 16 D6        call 0x101e
3A08  C4 7E F8        les di, ptr [bp - 8]
3A0B  26 FF 75 50     push word ptr es:[di + 0x50]
3A0F  26 FF 75 4E     push word ptr es:[di + 0x4e]
3A13  6A 06           push 6
3A15  6A 4F           push 0x4f
3A17  0E              push cs
3A18  E8 03 D6        call 0x101e
3A1B  C4 7E F8        les di, ptr [bp - 8]
3A1E  26 8B 45 04     mov ax, word ptr es:[di + 4]
3A22  31 D2           xor dx, dx
3A24  52              push dx
3A25  50              push ax
3A26  6A 08           push 8
3A28  6A 4F           push 0x4f
3A2A  0E              push cs
3A2B  E8 F0 D5        call 0x101e
3A2E  C4 7E F8        les di, ptr [bp - 8]
3A31  26 FF 75 48     push word ptr es:[di + 0x48]
3A35  26 FF 75 46     push word ptr es:[di + 0x46]
3A39  6A 0A           push 0xa
3A3B  6A 4F           push 0x4f
3A3D  0E              push cs
3A3E  E8 DD D5        call 0x101e
3A41  C4 7E F8        les di, ptr [bp - 8]
3A44  26 FF 75 38     push word ptr es:[di + 0x38]
3A48  26 FF 75 36     push word ptr es:[di + 0x36]
3A4C  6A 0C           push 0xc
3A4E  6A 4F           push 0x4f
3A50  0E              push cs
3A51  E8 CA D5        call 0x101e
3A54  C4 7E F8        les di, ptr [bp - 8]
3A57  26 FF 75 40     push word ptr es:[di + 0x40]
3A5B  26 FF 75 3E     push word ptr es:[di + 0x3e]
3A5F  6A 0E           push 0xe
3A61  6A 4F           push 0x4f
3A63  0E              push cs
3A64  E8 B7 D5        call 0x101e
3A67  C4 7E F8        les di, ptr [bp - 8]
3A6A  26 FF 75 44     push word ptr es:[di + 0x44]
3A6E  26 FF 75 42     push word ptr es:[di + 0x42]
3A72  6A 10           push 0x10
3A74  6A 4F           push 0x4f
3A76  0E              push cs
3A77  E8 A4 D5        call 0x101e
3A7A  C4 7E F8        les di, ptr [bp - 8]
3A7D  26 FF 75 18     push word ptr es:[di + 0x18]
3A81  26 FF 75 16     push word ptr es:[di + 0x16]
3A85  6A 12           push 0x12
3A87  6A 4F           push 0x4f
3A89  0E              push cs
3A8A  E8 91 D5        call 0x101e
3A8D  C4 7E F8        les di, ptr [bp - 8]
3A90  26 FF 75 5C     push word ptr es:[di + 0x5c]
3A94  26 FF 75 5A     push word ptr es:[di + 0x5a]
3A98  6A 14           push 0x14
3A9A  6A 4F           push 0x4f
3A9C  0E              push cs
3A9D  E8 7E D5        call 0x101e
3AA0  C7 06 64 DD 50 00 mov word ptr [0xdd64], 0x50
3AA6  C4 7E FC        les di, ptr [bp - 4]
3AA9  26 8A 45 04     mov al, byte ptr es:[di + 4]
3AAD  30 E4           xor ah, ah
3AAF  8B F8           mov di, ax
3AB1  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
3AB5  30 E4           xor ah, ah
3AB7  50              push ax
3AB8  0E              push cs
3AB9  E8 92 FB        call 0x364e
3ABC  52              push dx
3ABD  50              push ax
3ABE  6A 17           push 0x17
3AC0  6A 4F           push 0x4f
3AC2  0E              push cs
3AC3  E8 58 D5        call 0x101e
3AC6  C4 7E F8        les di, ptr [bp - 8]
3AC9  26 FF 75 54     push word ptr es:[di + 0x54]
3ACD  26 FF 75 52     push word ptr es:[di + 0x52]
3AD1  6A 17           push 0x17
3AD3  6A 26           push 0x26
3AD5  0E              push cs
3AD6  E8 45 D5        call 0x101e
3AD9  C4 3E 5C DD     les di, ptr [0xdd5c]
3ADD  06              push es
3ADE  57              push di
3ADF  C4 3E 58 DD     les di, ptr [0xdd58]
3AE3  06              push es
3AE4  57              push di
3AE5  68 A0 0F        push 0xfa0
3AE8  9A 12 0A C9 26  call far 26C9:0A12
3AED  9A 9B 09 2A 23  call far 232A:099B
3AF2  C4 7E FC        les di, ptr [bp - 4]
3AF5  26 8A 45 04     mov al, byte ptr es:[di + 4]
3AF9  30 E4           xor ah, ah
3AFB  50              push ax
3AFC  0E              push cs
3AFD  E8 B9 F2        call 0x2db9
loc_3B00:
3B00  C9              leave
3B01  CB              retf

; ---- routine 1B55:3B02  (found by: call, far)
sub_3B02:
3B02  C8 00 01 00     enter 0x100, 0
3B06  C4 3E D2 D7     les di, ptr [0xd7d2]
3B0A  26 8A 05        mov al, byte ptr es:[di]
3B0D  30 E4           xor ah, ah
3B0F  40              inc ax
3B10  3B 46 0A        cmp ax, word ptr [bp + 0xa]
3B13  B0 00           mov al, 0
3B15  75 01           jne 0x3b18
3B17  40              inc ax
loc_3B18:
3B18  30 E4           xor ah, ah
3B1A  C1 E0 07        shl ax, 7
3B1D  8B D0           mov dx, ax
3B1F  8B 7E 0A        mov di, word ptr [bp + 0xa]
3B22  80 BD 6A A2 00  cmp byte ptr [di - 0x5d96], 0
3B27  B0 00           mov al, 0
3B29  75 01           jne 0x3b2c
3B2B  40              inc ax
loc_3B2C:
3B2C  98              cwde
3B2D  8B F8           mov di, ax
3B2F  8A 85 A2 0D     mov al, byte ptr [di + 0xda2]
3B33  30 E4           xor ah, ah
3B35  03 C2           add ax, dx
3B37  50              push ax
3B38  8B 7E 0A        mov di, word ptr [bp + 0xa]
3B3B  8A 85 C7 10     mov al, byte ptr [di + 0x10c7]
3B3F  30 E4           xor ah, ah
3B41  8B F8           mov di, ax
3B43  C1 E7 02        shl di, 2
3B46  81 C7 98 10     add di, 0x1098
3B4A  1E              push ds
3B4B  57              push di
3B4C  8A 46 08        mov al, byte ptr [bp + 8]
3B4F  50              push ax
3B50  8B 46 06        mov ax, word ptr [bp + 6]
3B53  2D 04 00        sub ax, 4
3B56  50              push ax
3B57  BF 5C DD        mov di, 0xdd5c
3B5A  1E              push ds
3B5B  57              push di
3B5C  9A 1B 04 2A 23  call far 232A:041B
3B61  8B 7E 0A        mov di, word ptr [bp + 0xa]
3B64  80 BD 01 11 00  cmp byte ptr [di + 0x1101], 0
3B69  74 2A           je 0x3b95
3B6B  8D BE 00 FF     lea di, [bp - 0x100]
3B6F  16              push ss
3B70  57              push di
3B71  8B 7E 0A        mov di, word ptr [bp + 0xa]
3B74  8A 85 01 11     mov al, byte ptr [di + 0x1101]
3B78  30 E4           xor ah, ah
3B7A  31 D2           xor dx, dx
3B7C  52              push dx
3B7D  50              push ax
3B7E  9A C9 07 2A 23  call far 232A:07C9
3B83  8A 46 08        mov al, byte ptr [bp + 8]
3B86  50              push ax
3B87  8A 46 06        mov al, byte ptr [bp + 6]
3B8A  50              push ax
3B8B  BF 5C DD        mov di, 0xdd5c
3B8E  1E              push ds
3B8F  57              push di
3B90  9A 9D 03 2A 23  call far 232A:039D
loc_3B95:
3B95  C9              leave
3B96  CA 06 00        retf 6

; ---- routine 1B55:3B99  (found by: call, far)
sub_3B99:
3B99  C8 06 00 00     enter 6, 0
3B9D  80 7E 08 03     cmp byte ptr [bp + 8], 3
3BA1  75 06           jne 0x3ba9
3BA3  80 7E 0A 19     cmp byte ptr [bp + 0xa], 0x19
3BA7  77 28           ja 0x3bd1
loc_3BA9:
3BA9  80 7E 08 04     cmp byte ptr [bp + 8], 4
3BAD  75 06           jne 0x3bb5
3BAF  80 7E 0A 29     cmp byte ptr [bp + 0xa], 0x29
3BB3  77 1C           ja 0x3bd1
loc_3BB5:
3BB5  80 7E 08 06     cmp byte ptr [bp + 8], 6
3BB9  75 06           jne 0x3bc1
3BBB  80 7E 0A 39     cmp byte ptr [bp + 0xa], 0x39
3BBF  74 10           je 0x3bd1
loc_3BC1:
3BC1  80 7E 08 07     cmp byte ptr [bp + 8], 7
3BC5  75 06           jne 0x3bcd
3BC7  80 7E 0A 30     cmp byte ptr [bp + 0xa], 0x30
3BCB  74 04           je 0x3bd1
loc_3BCD:
3BCD  B0 00           mov al, 0
3BCF  EB 02           jmp 0x3bd3
loc_3BD1:
3BD1  B0 01           mov al, 1
loc_3BD3:
3BD3  88 46 FF        mov byte ptr [bp - 1], al
3BD6  8A 46 0A        mov al, byte ptr [bp + 0xa]
3BD9  30 E4           xor ah, ah
3BDB  8B F0           mov si, ax
3BDD  D1 E0           shl ax, 1
3BDF  01 F0           add ax, si
3BE1  8B D0           mov dx, ax
3BE3  8A 46 0E        mov al, byte ptr [bp + 0xe]
3BE6  30 E4           xor ah, ah
3BE8  69 C0 AE 00     imul ax, ax, 0xae
3BEC  C4 3E CA D7     les di, ptr [0xd7ca]
3BF0  03 F8           add di, ax
3BF2  03 FA           add di, dx
3BF4  81 C7 4F FF     add di, 0xff4f
3BF8  89 7E FA        mov word ptr [bp - 6], di
3BFB  8C 46 FC        mov word ptr [bp - 4], es
3BFE  8A 46 0C        mov al, byte ptr [bp + 0xc]
3C01  26 88 45 01     mov byte ptr es:[di + 1], al
3C05  8A 46 08        mov al, byte ptr [bp + 8]
3C08  26 88 05        mov byte ptr es:[di], al
3C0B  8A 46 06        mov al, byte ptr [bp + 6]
3C0E  30 E4           xor ah, ah
3C10  C1 E0 04        shl ax, 4
3C13  8B D0           mov dx, ax
3C15  8A 46 FF        mov al, byte ptr [bp - 1]
3C18  98              cwde
3C19  8B F8           mov di, ax
3C1B  8A 85 3C 11     mov al, byte ptr [di + 0x113c]
3C1F  30 E4           xor ah, ah
3C21  03 C2           add ax, dx
3C23  C4 7E FA        les di, ptr [bp - 6]
3C26  26 88 45 02     mov byte ptr es:[di + 2], al
3C2A  8A 46 0A        mov al, byte ptr [bp + 0xa]
3C2D  30 E4           xor ah, ah
3C2F  8B F0           mov si, ax
3C31  D1 E0           shl ax, 1
3C33  01 F0           add ax, si
3C35  8B D0           mov dx, ax
3C37  8A 46 0C        mov al, byte ptr [bp + 0xc]
3C3A  30 E4           xor ah, ah
3C3C  69 C0 AE 00     imul ax, ax, 0xae
3C40  C4 3E CA D7     les di, ptr [0xd7ca]
3C44  03 F8           add di, ax
3C46  03 FA           add di, dx
3C48  81 C7 4F FF     add di, 0xff4f
3C4C  89 7E FA        mov word ptr [bp - 6], di
3C4F  8C 46 FC        mov word ptr [bp - 4], es
3C52  8A 46 0E        mov al, byte ptr [bp + 0xe]
3C55  26 88 45 01     mov byte ptr es:[di + 1], al
3C59  8A 46 08        mov al, byte ptr [bp + 8]
3C5C  26 88 05        mov byte ptr es:[di], al
3C5F  8A 46 06        mov al, byte ptr [bp + 6]
3C62  30 E4           xor ah, ah
3C64  C1 E0 04        shl ax, 4
3C67  8B D0           mov dx, ax
3C69  8A 46 FF        mov al, byte ptr [bp - 1]
3C6C  98              cwde
3C6D  8B F8           mov di, ax
3C6F  8A 85 3E 11     mov al, byte ptr [di + 0x113e]
3C73  30 E4           xor ah, ah
3C75  03 C2           add ax, dx
3C77  C4 7E FA        les di, ptr [bp - 6]
3C7A  26 88 45 02     mov byte ptr es:[di + 2], al
3C7E  C9              leave
3C7F  CA 0A 00        retf 0xa

; ---- routine 1B55:3C82  (found by: call)
sub_3C82:
3C82  C8 04 00 00     enter 4, 0
3C86  6A 03           push 3
3C88  9A 6D 07 2A 23  call far 232A:076D
3C8D  89 46 FC        mov word ptr [bp - 4], ax
3C90  C7 46 FE 01 00  mov word ptr [bp - 2], 1
3C95  EB 03           jmp 0x3c9a
loc_3C97:
3C97  FF 46 FE        inc word ptr [bp - 2]
loc_3C9A:
3C9A  8B 46 FE        mov ax, word ptr [bp - 2]
3C9D  8B 7E FC        mov di, word ptr [bp - 4]
3CA0  D1 E7           shl di, 1
3CA2  8B F7           mov si, di
3CA4  D1 E7           shl di, 1
3CA6  01 F7           add di, si
3CA8  03 F8           add di, ax
3CAA  8A 85 39 11     mov al, byte ptr [di + 0x1139]
3CAE  30 E4           xor ah, ah
3CB0  8B F8           mov di, ax
3CB2  81 C7 D5 D7     add di, 0xd7d5
3CB6  1E              push ds
3CB7  57              push di
3CB8  8B 46 FE        mov ax, word ptr [bp - 2]
3CBB  8B 7E FC        mov di, word ptr [bp - 4]
3CBE  D1 E7           shl di, 1
3CC0  8B F7           mov si, di
3CC2  D1 E7           shl di, 1
3CC4  01 F7           add di, si
3CC6  03 F8           add di, ax
3CC8  8A 85 4B 11     mov al, byte ptr [di + 0x114b]
3CCC  30 E4           xor ah, ah
3CCE  8B F8           mov di, ax
3CD0  81 C7 D5 D7     add di, 0xd7d5
3CD4  1E              push ds
3CD5  57              push di
3CD6  6A 08           push 8
3CD8  9A 03 02 BC 24  call far 24BC:0203
3CDD  83 7E FE 06     cmp word ptr [bp - 2], 6
3CE1  75 B4           jne 0x3c97
3CE3  C9              leave
3CE4  C3              ret

; ---- routine 1B55:3CE5  (found by: call)
sub_3CE5:
3CE5  C8 24 00 00     enter 0x24, 0
3CE9  C6 46 FF 00     mov byte ptr [bp - 1], 0
3CED  C4 3E D2 D7     les di, ptr [0xd7d2]
3CF1  26 80 BD F5 00 00 cmp byte ptr es:[di + 0xf5], 0
3CF7  75 02           jne 0x3cfb
3CF9  EB 6B           jmp 0x3d66
loc_3CFB:
3CFB  9A 68 05 BC 24  call far 24BC:0568
3D00  BF D0 26        mov di, 0x26d0
3D03  1E              push ds
3D04  57              push di
3D05  BF 5C DD        mov di, 0xdd5c
3D08  1E              push ds
3D09  57              push di
3D0A  9A 2F 05 2A 23  call far 232A:052F
3D0F  FF 76 08        push word ptr [bp + 8]
3D12  6A 19           push 0x19
3D14  6A 31           push 0x31
3D16  0E              push cs
3D17  E8 21 D2        call 0xf3b
3D1A  FF 76 06        push word ptr [bp + 6]
3D1D  6A 19           push 0x19
3D1F  6A 35           push 0x35
3D21  0E              push cs
3D22  E8 BE D1        call 0xee3
3D25  FF 76 04        push word ptr [bp + 4]
3D28  6A 19           push 0x19
3D2A  6A 1D           push 0x1d
3D2C  0E              push cs
3D2D  E8 D2 FD        call 0x3b02
3D30  C4 3E 5C DD     les di, ptr [0xdd5c]
3D34  81 C7 00 0F     add di, 0xf00
3D38  06              push es
3D39  57              push di
3D3A  C4 3E 58 DD     les di, ptr [0xdd58]
3D3E  81 C7 00 0F     add di, 0xf00
3D42  06              push es
3D43  57              push di
3D44  68 A0 00        push 0xa0
3D47  9A C2 01 BC 24  call far 24BC:01C2
3D4C  8D 7E DC        lea di, [bp - 0x24]
3D4F  16              push ss
3D50  57              push di
3D51  6A 02           push 2
3D53  9A 94 0D C9 26  call far 26C9:0D94
3D58  9A 95 07 2A 23  call far 232A:0795
3D5D  9A 98 05 BC 24  call far 24BC:0598
3D62  C6 46 FF 01     mov byte ptr [bp - 1], 1
loc_3D66:
3D66  8A 46 FF        mov al, byte ptr [bp - 1]
3D69  C9              leave
3D6A  C2 06 00        ret 6

; ---- routine 1B55:3D6D  (found by: far)
sub_3D6D:
3D6D  C8 BC 00 00     enter 0xbc, 0
3D71  BF D6 D7        mov di, 0xd7d6
3D74  1E              push ds
3D75  57              push di
3D76  8D BE 44 FF     lea di, [bp - 0xbc]
3D7A  16              push ss
3D7B  57              push di
3D7C  68 B0 00        push 0xb0
3D7F  9A C2 01 BC 24  call far 24BC:01C2
3D84  C7 46 FE 01 00  mov word ptr [bp - 2], 1
3D89  EB 03           jmp 0x3d8e
loc_3D8B:
3D8B  FF 46 FE        inc word ptr [bp - 2]
loc_3D8E:
3D8E  8B 7E FE        mov di, word ptr [bp - 2]
3D91  8A 93 43 FF     mov dl, byte ptr [bp + di - 0xbd]
3D95  8B 7E FE        mov di, word ptr [bp - 2]
3D98  8A 83 43 FF     mov al, byte ptr [bp + di - 0xbd]
3D9C  30 E4           xor ah, ah
3D9E  6B C0 3E        imul ax, ax, 0x3e
3DA1  C4 3E C2 D7     les di, ptr [0xd7c2]
3DA5  03 F8           add di, ax
3DA7  26 8A 45 F5     mov al, byte ptr es:[di - 0xb]
3DAB  30 E4           xor ah, ah
3DAD  8B F8           mov di, ax
3DAF  88 95 D5 D7     mov byte ptr [di - 0x282b], dl
3DB3  81 7E FE B0 00  cmp word ptr [bp - 2], 0xb0
3DB8  75 D1           jne 0x3d8b
3DBA  E8 C5 FE        call 0x3c82
3DBD  6A 1E           push 0x1e
3DBF  9A 6D 07 2A 23  call far 232A:076D
3DC4  89 46 F8        mov word ptr [bp - 8], ax
3DC7  C7 46 FE 01 00  mov word ptr [bp - 2], 1
3DCC  EB 03           jmp 0x3dd1
loc_3DCE:
3DCE  FF 46 FE        inc word ptr [bp - 2]
loc_3DD1:
3DD1  C7 46 FC 01 00  mov word ptr [bp - 4], 1
3DD6  EB 03           jmp 0x3ddb
loc_3DD8:
3DD8  FF 46 FC        inc word ptr [bp - 4]
loc_3DDB:
3DDB  8B 46 FC        mov ax, word ptr [bp - 4]
3DDE  8B 7E FE        mov di, word ptr [bp - 2]
3DE1  C1 E7 04        shl di, 4
3DE4  03 F8           add di, ax
3DE6  80 BD 53 11 00  cmp byte ptr [di + 0x1153], 0
3DEB  75 03           jne 0x3df0
3DED  E9 F6 00        jmp 0x3ee6
loc_3DF0:
3DF0  8B 46 FC        mov ax, word ptr [bp - 4]
3DF3  8B 7E FE        mov di, word ptr [bp - 2]
3DF6  C1 E7 04        shl di, 4
3DF9  03 F8           add di, ax
3DFB  8A 85 53 11     mov al, byte ptr [di + 0x1153]
3DFF  30 E4           xor ah, ah
3E01  3B 46 F8        cmp ax, word ptr [bp - 8]
3E04  74 03           je 0x3e09
3E06  E9 DD 00        jmp 0x3ee6
loc_3E09:
3E09  C7 46 FA 01 00  mov word ptr [bp - 6], 1
3E0E  EB 03           jmp 0x3e13
loc_3E10:
3E10  FF 46 FA        inc word ptr [bp - 6]
loc_3E13:
3E13  8B 7E FA        mov di, word ptr [bp - 6]
3E16  8A 85 63 12     mov al, byte ptr [di + 0x1263]
3E1A  30 E4           xor ah, ah
3E1C  03 46 FE        add ax, word ptr [bp - 2]
3E1F  8B F8           mov di, ax
3E21  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
3E25  30 E4           xor ah, ah
3E27  89 46 F6        mov word ptr [bp - 0xa], ax
3E2A  8B 7E FA        mov di, word ptr [bp - 6]
3E2D  8A 85 63 12     mov al, byte ptr [di + 0x1263]
3E31  30 E4           xor ah, ah
3E33  03 46 FC        add ax, word ptr [bp - 4]
3E36  8B F8           mov di, ax
3E38  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
3E3C  30 E4           xor ah, ah
3E3E  89 46 F4        mov word ptr [bp - 0xc], ax
3E41  6B 46 F6 3E     imul ax, word ptr [bp - 0xa], 0x3e
3E45  C4 3E C2 D7     les di, ptr [0xd7c2]
3E49  03 F8           add di, ax
3E4B  26 80 7D F9 05  cmp byte ptr es:[di - 7], 5
3E50  7C 11           jl 0x3e63
3E52  6B 46 F4 3E     imul ax, word ptr [bp - 0xc], 0x3e
3E56  C4 3E C2 D7     les di, ptr [0xd7c2]
3E5A  03 F8           add di, ax
3E5C  26 80 7D F9 05  cmp byte ptr es:[di - 7], 5
3E61  7D 7A           jge 0x3edd
loc_3E63:
3E63  8B 46 06        mov ax, word ptr [bp + 6]
3E66  8B F0           mov si, ax
3E68  D1 E0           shl ax, 1
3E6A  01 F0           add ax, si
3E6C  8B D0           mov dx, ax
3E6E  69 46 F6 AE 00  imul ax, word ptr [bp - 0xa], 0xae
3E73  C4 3E CA D7     les di, ptr [0xd7ca]
3E77  03 F8           add di, ax
3E79  03 FA           add di, dx
3E7B  26 80 BD 50 FF 00 cmp byte ptr es:[di - 0xb0], 0
3E81  75 5A           jne 0x3edd
3E83  8B 46 06        mov ax, word ptr [bp + 6]
3E86  8B F0           mov si, ax
3E88  D1 E0           shl ax, 1
3E8A  01 F0           add ax, si
3E8C  8B D0           mov dx, ax
3E8E  69 46 F4 AE 00  imul ax, word ptr [bp - 0xc], 0xae
3E93  C4 3E CA D7     les di, ptr [0xd7ca]
3E97  03 F8           add di, ax
3E99  03 FA           add di, dx
3E9B  26 80 BD 50 FF 00 cmp byte ptr es:[di - 0xb0], 0
3EA1  75 3A           jne 0x3edd
3EA3  FF 76 F6        push word ptr [bp - 0xa]
3EA6  0E              push cs
3EA7  E8 D0 CF        call 0xe7a
3EAA  08 C0           or al, al
3EAC  75 0B           jne 0x3eb9
3EAE  FF 76 F4        push word ptr [bp - 0xc]
3EB1  0E              push cs
3EB2  E8 C5 CF        call 0xe7a
3EB5  08 C0           or al, al
3EB7  74 10           je 0x3ec9
loc_3EB9:
3EB9  FF 76 F6        push word ptr [bp - 0xa]
3EBC  FF 76 F4        push word ptr [bp - 0xc]
3EBF  FF 76 06        push word ptr [bp + 6]
3EC2  E8 20 FE        call 0x3ce5
3EC5  08 C0           or al, al
3EC7  74 14           je 0x3edd
loc_3EC9:
3EC9  8A 46 F6        mov al, byte ptr [bp - 0xa]
3ECC  50              push ax
3ECD  8A 46 F4        mov al, byte ptr [bp - 0xc]
3ED0  50              push ax
3ED1  8A 46 06        mov al, byte ptr [bp + 6]
3ED4  50              push ax
3ED5  6A 02           push 2
3ED7  6A 00           push 0
3ED9  0E              push cs
3EDA  E8 BC FC        call 0x3b99
loc_3EDD:
3EDD  83 7E FA 0B     cmp word ptr [bp - 6], 0xb
3EE1  74 03           je 0x3ee6
3EE3  E9 2A FF        jmp 0x3e10
loc_3EE6:
3EE6  83 7E FC 10     cmp word ptr [bp - 4], 0x10
3EEA  74 03           je 0x3eef
3EEC  E9 E9 FE        jmp 0x3dd8
loc_3EEF:
3EEF  83 7E FE 10     cmp word ptr [bp - 2], 0x10
3EF3  74 03           je 0x3ef8
3EF5  E9 D6 FE        jmp 0x3dce
loc_3EF8:
3EF8  8D BE 44 FF     lea di, [bp - 0xbc]
3EFC  16              push ss
3EFD  57              push di
3EFE  BF D6 D7        mov di, 0xd7d6
3F01  1E              push ds
3F02  57              push di
3F03  68 B0 00        push 0xb0
3F06  9A C2 01 BC 24  call far 24BC:01C2
3F0B  C9              leave
3F0C  CA 02 00        retf 2

; ---- routine 1B55:3F0F  (found by: call)
sub_3F0F:
3F0F  C8 B8 00 00     enter 0xb8, 0
3F13  BF D6 D7        mov di, 0xd7d6
3F16  1E              push ds
3F17  57              push di
3F18  8D BE 48 FF     lea di, [bp - 0xb8]
3F1C  16              push ss
3F1D  57              push di
3F1E  68 B0 00        push 0xb0
3F21  9A C2 01 BC 24  call far 24BC:01C2
3F26  C7 46 FE 01 00  mov word ptr [bp - 2], 1
3F2B  EB 03           jmp 0x3f30
loc_3F2D:
3F2D  FF 46 FE        inc word ptr [bp - 2]
loc_3F30:
3F30  8B 7E FE        mov di, word ptr [bp - 2]
3F33  8A 93 47 FF     mov dl, byte ptr [bp + di - 0xb9]
3F37  8B 7E FE        mov di, word ptr [bp - 2]
3F3A  8A 83 47 FF     mov al, byte ptr [bp + di - 0xb9]
3F3E  30 E4           xor ah, ah
3F40  6B C0 3E        imul ax, ax, 0x3e
3F43  C4 3E C2 D7     les di, ptr [0xd7c2]
3F47  03 F8           add di, ax
3F49  26 8A 45 F5     mov al, byte ptr es:[di - 0xb]
3F4D  30 E4           xor ah, ah
3F4F  8B F8           mov di, ax
3F51  88 95 D5 D7     mov byte ptr [di - 0x282b], dl
3F55  81 7E FE B0 00  cmp word ptr [bp - 2], 0xb0
3F5A  75 D1           jne 0x3f2d
3F5C  E8 23 FD        call 0x3c82
3F5F  31 C0           xor ax, ax
3F61  89 46 F8        mov word ptr [bp - 8], ax
loc_3F64:
3F64  83 7E F8 04     cmp word ptr [bp - 8], 4
3F68  72 03           jb 0x3f6d
3F6A  E9 95 00        jmp 0x4002
loc_3F6D:
3F6D  FF 46 F8        inc word ptr [bp - 8]
3F70  C7 46 FE 01 00  mov word ptr [bp - 2], 1
3F75  EB 03           jmp 0x3f7a
loc_3F77:
3F77  FF 46 FE        inc word ptr [bp - 2]
loc_3F7A:
3F7A  C7 46 FC 01 00  mov word ptr [bp - 4], 1
3F7F  EB 03           jmp 0x3f84
loc_3F81:
3F81  FF 46 FC        inc word ptr [bp - 4]
loc_3F84:
3F84  8B 46 FC        mov ax, word ptr [bp - 4]
3F87  8B 7E FE        mov di, word ptr [bp - 2]
3F8A  C1 E7 04        shl di, 4
3F8D  03 F8           add di, ax
3F8F  80 BD 53 11 00  cmp byte ptr [di + 0x1153], 0
3F94  74 5A           je 0x3ff0
3F96  8B 46 FC        mov ax, word ptr [bp - 4]
3F99  8B 7E FE        mov di, word ptr [bp - 2]
3F9C  C1 E7 04        shl di, 4
3F9F  03 F8           add di, ax
3FA1  8A 85 53 11     mov al, byte ptr [di + 0x1153]
3FA5  8B 7E F8        mov di, word ptr [bp - 8]
3FA8  3A 85 6F 12     cmp al, byte ptr [di + 0x126f]
3FAC  75 42           jne 0x3ff0
3FAE  C7 46 FA 01 00  mov word ptr [bp - 6], 1
3FB3  EB 03           jmp 0x3fb8
loc_3FB5:
3FB5  FF 46 FA        inc word ptr [bp - 6]
loc_3FB8:
3FB8  8B 7E FA        mov di, word ptr [bp - 6]
3FBB  8A 85 63 12     mov al, byte ptr [di + 0x1263]
3FBF  30 E4           xor ah, ah
3FC1  03 46 FE        add ax, word ptr [bp - 2]
3FC4  8B F8           mov di, ax
3FC6  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
3FCA  50              push ax
3FCB  8B 7E FA        mov di, word ptr [bp - 6]
3FCE  8A 85 63 12     mov al, byte ptr [di + 0x1263]
3FD2  30 E4           xor ah, ah
3FD4  03 46 FC        add ax, word ptr [bp - 4]
3FD7  8B F8           mov di, ax
3FD9  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
3FDD  50              push ax
3FDE  8A 46 F8        mov al, byte ptr [bp - 8]
3FE1  50              push ax
3FE2  6A 01           push 1
3FE4  6A 00           push 0
3FE6  0E              push cs
3FE7  E8 AF FB        call 0x3b99
3FEA  83 7E FA 0B     cmp word ptr [bp - 6], 0xb
3FEE  75 C5           jne 0x3fb5
loc_3FF0:
3FF0  83 7E FC 10     cmp word ptr [bp - 4], 0x10
3FF4  75 8B           jne 0x3f81
3FF6  83 7E FE 10     cmp word ptr [bp - 2], 0x10
3FFA  74 03           je 0x3fff
3FFC  E9 78 FF        jmp 0x3f77
loc_3FFF:
3FFF  E9 62 FF        jmp 0x3f64
loc_4002:
4002  8D BE 48 FF     lea di, [bp - 0xb8]
4006  16              push ss
4007  57              push di
4008  BF D6 D7        mov di, 0xd7d6
400B  1E              push ds
400C  57              push di
400D  68 B0 00        push 0xb0
4010  9A C2 01 BC 24  call far 24BC:01C2
4015  C9              leave
4016  C2 02 00        ret 2

; ---- routine 1B55:4019  (found by: far)
sub_4019:
4019  C8 08 00 00     enter 8, 0
401D  55              push bp
401E  E8 EE FE        call 0x3f0f
4021  C7 46 FE 01 00  mov word ptr [bp - 2], 1
4026  EB 03           jmp 0x402b
loc_4028:
4028  FF 46 FE        inc word ptr [bp - 2]
loc_402B:
402B  C7 46 FC 01 00  mov word ptr [bp - 4], 1
4030  EB 03           jmp 0x4035
loc_4032:
4032  FF 46 FC        inc word ptr [bp - 4]
loc_4035:
4035  8B 46 FC        mov ax, word ptr [bp - 4]
4038  8B 7E FE        mov di, word ptr [bp - 2]
403B  C1 E7 04        shl di, 4
403E  03 F8           add di, ax
4040  80 BD 53 11 00  cmp byte ptr [di + 0x1153], 0
4045  74 56           je 0x409d
4047  C7 46 FA 01 00  mov word ptr [bp - 6], 1
404C  EB 03           jmp 0x4051
loc_404E:
404E  FF 46 FA        inc word ptr [bp - 6]
loc_4051:
4051  8B 7E FA        mov di, word ptr [bp - 6]
4054  8A 85 63 12     mov al, byte ptr [di + 0x1263]
4058  30 E4           xor ah, ah
405A  03 46 FE        add ax, word ptr [bp - 2]
405D  8B F8           mov di, ax
405F  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
4063  50              push ax
4064  8B 7E FA        mov di, word ptr [bp - 6]
4067  8A 85 63 12     mov al, byte ptr [di + 0x1263]
406B  30 E4           xor ah, ah
406D  03 46 FC        add ax, word ptr [bp - 4]
4070  8B F8           mov di, ax
4072  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
4076  50              push ax
4077  8B 46 FC        mov ax, word ptr [bp - 4]
407A  8B 7E FE        mov di, word ptr [bp - 2]
407D  C1 E7 04        shl di, 4
4080  03 F8           add di, ax
4082  8A 85 53 11     mov al, byte ptr [di + 0x1153]
4086  30 E4           xor ah, ah
4088  8B F8           mov di, ax
408A  8A 85 FD 89     mov al, byte ptr [di - 0x7603]
408E  50              push ax
408F  6A 00           push 0
4091  6A 00           push 0
4093  0E              push cs
4094  E8 02 FB        call 0x3b99
4097  83 7E FA 05     cmp word ptr [bp - 6], 5
409B  75 B1           jne 0x404e
loc_409D:
409D  83 7E FC 10     cmp word ptr [bp - 4], 0x10
40A1  75 8F           jne 0x4032
40A3  83 7E FE 10     cmp word ptr [bp - 2], 0x10
40A7  74 03           je 0x40ac
40A9  E9 7C FF        jmp 0x4028
loc_40AC:
40AC  C7 46 FE 01 00  mov word ptr [bp - 2], 1
40B1  EB 03           jmp 0x40b6
loc_40B3:
40B3  FF 46 FE        inc word ptr [bp - 2]
loc_40B6:
40B6  8B 7E FE        mov di, word ptr [bp - 2]
40B9  80 BD B9 DC 00  cmp byte ptr [di - 0x2347], 0
40BE  74 17           je 0x40d7
40C0  8B 7E FE        mov di, word ptr [bp - 2]
40C3  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
40C7  30 E4           xor ah, ah
40C9  6B C0 3E        imul ax, ax, 0x3e
40CC  C4 3E C2 D7     les di, ptr [0xd7c2]
40D0  03 F8           add di, ax
40D2  26 C6 45 FC 01  mov byte ptr es:[di - 4], 1
loc_40D7:
40D7  83 7E FE 02     cmp word ptr [bp - 2], 2
40DB  75 D6           jne 0x40b3
40DD  C9              leave
40DE  CB              retf

