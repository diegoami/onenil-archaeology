; 1-0.EXE (One-Nil 96), code segment 1B55 (image offsets 1B550..2315F), part 5 of 12
; packed 1-0.EXE sha256 89ff9c5f238f24e81a0c2440a46cdd8997280a65fc3cc3d97cb974f55280a80a (LZEXE 0.91)
; unpacked (tools/static/unlzexe.py) sha256 887ed2a92767950e5309b2052409f875668605939b69e00737aa3047022b9f51
; tool: capstone 5.0.9 (pip package; core library 5.0.1280) (CS_ARCH_X86, CS_MODE_16), recursive descent from the entry point, far calls and near calls/jumps, then routine prologues (55 89 E5 / 55 8B EC / C8 iw 00) in what remains; tools/static/listing.py
; addresses are SEGMENT:OFFSET with SEGMENT the image paragraph before relocation; image offset = SEGMENT*16+OFFSET
; ---- routine 1B55:2ACF  (found by: call)
sub_2ACF:
2ACF  55              push bp
2AD0  89 E5           mov bp, sp
2AD2  C4 7E 06        les di, ptr [bp + 6]
2AD5  06              push es
2AD6  57              push di
2AD7  BF 5C DD        mov di, 0xdd5c
2ADA  1E              push ds
2ADB  57              push di
2ADC  9A 2F 05 2A 23  call far 232A:052F
2AE1  C7 06 64 DD 0F 00 mov word ptr [0xdd64], 0xf
2AE7  8B 7E 04        mov di, word ptr [bp + 4]
2AEA  36 8B 45 06     mov ax, word ptr ss:[di + 6]
2AEE  D1 E0           shl ax, 1
2AF0  C4 3E D2 D7     les di, ptr [0xd7d2]
2AF4  03 F8           add di, ax
2AF6  26 FF 75 03     push word ptr es:[di + 3]
2AFA  6A 19           push 0x19
2AFC  6A 01           push 1
2AFE  0E              push cs
2AFF  E8 F2 F3        call 0x1ef4
2B02  C4 3E 5C DD     les di, ptr [0xdd5c]
2B06  06              push es
2B07  57              push di
2B08  C4 3E 58 DD     les di, ptr [0xdd58]
2B0C  06              push es
2B0D  57              push di
2B0E  68 A0 0F        push 0xfa0
2B11  9A 12 0A C9 26  call far 26C9:0A12
2B16  C9              leave
2B17  C2 06 00        ret 6
; data (not reached as code), 41 bytes
2B1A                  pstr 'Ok...improvements will take a few months'

; ---- routine 1B55:2B43  (found by: call)
sub_2B43:
2B43  C8 0A 01 00     enter 0x10a, 0
2B47  8B 7E 04        mov di, word ptr [bp + 4]
2B4A  36 6B 45 06 5E  imul ax, word ptr ss:[di + 6], 0x5e
2B4F  C4 3E C4 DC     les di, ptr [0xdcc4]
2B53  03 F8           add di, ax
2B55  81 C7 A2 FF     add di, 0xffa2
2B59  89 7E F6        mov word ptr [bp - 0xa], di
2B5C  8C 46 F8        mov word ptr [bp - 8], es
2B5F  C7 46 FC 01 00  mov word ptr [bp - 4], 1
2B64  C7 46 FE 00 00  mov word ptr [bp - 2], 0
2B69  8B 7E 04        mov di, word ptr [bp + 4]
2B6C  36 8B 7D 06     mov di, word ptr ss:[di + 6]
2B70  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
2B74  30 E4           xor ah, ah
2B76  8B F8           mov di, ax
2B78  8A 85 E5 D9     mov al, byte ptr [di - 0x261b]
2B7C  30 E4           xor ah, ah
2B7E  8B D0           mov dx, ax
2B80  B8 96 00        mov ax, 0x96
2B83  2B C2           sub ax, dx
2B85  88 46 FB        mov byte ptr [bp - 5], al
2B88  8A 46 FB        mov al, byte ptr [bp - 5]
2B8B  30 E4           xor ah, ah
2B8D  31 D2           xor dx, dx
2B8F  89 46 FC        mov word ptr [bp - 4], ax
2B92  89 56 FE        mov word ptr [bp - 2], dx
loc_2B95:
2B95  8B 7E 04        mov di, word ptr [bp + 4]
2B98  36 8B 7D 06     mov di, word ptr ss:[di + 6]
2B9C  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
2BA0  30 E4           xor ah, ah
2BA2  50              push ax
2BA3  0E              push cs
2BA4  E8 A7 0A        call 0x364e
2BA7  F7 D2           not dx
2BA9  F7 D8           neg ax
2BAB  83 DA FF        sbb dx, -1
2BAE  52              push dx
2BAF  50              push ax
2BB0  8B 7E 04        mov di, word ptr [bp + 4]
2BB3  36 FF 75 06     push word ptr ss:[di + 6]
2BB7  0E              push cs
2BB8  E8 B8 0A        call 0x3673
2BBB  52              push dx
2BBC  50              push ax
2BBD  8B 46 FC        mov ax, word ptr [bp - 4]
2BC0  8B 56 FE        mov dx, word ptr [bp - 2]
2BC3  F7 D2           not dx
2BC5  F7 D8           neg ax
2BC7  83 DA FF        sbb dx, -1
2BCA  B9 20 A1        mov cx, 0xa120
2BCD  BB 07 00        mov bx, 7
2BD0  9A 2A 0A C9 26  call far 26C9:0A2A
2BD5  59              pop cx
2BD6  5B              pop bx
2BD7  03 C1           add ax, cx
2BD9  13 D3           adc dx, bx
2BDB  59              pop cx
2BDC  5B              pop bx
2BDD  3B D3           cmp dx, bx
2BDF  7C 06           jl 0x2be7
2BE1  7F 0E           jg 0x2bf1
2BE3  3B C1           cmp ax, cx
2BE5  73 0A           jae 0x2bf1
loc_2BE7:
2BE7  83 6E FC 01     sub word ptr [bp - 4], 1
2BEB  83 5E FE 00     sbb word ptr [bp - 2], 0
2BEF  EB A4           jmp 0x2b95
loc_2BF1:
2BF1  8A 46 FC        mov al, byte ptr [bp - 4]
2BF4  88 46 FB        mov byte ptr [bp - 5], al
2BF7  C7 46 FC 01 00  mov word ptr [bp - 4], 1
2BFC  C7 46 FE 00 00  mov word ptr [bp - 2], 0
loc_2C01:
2C01  8A 46 FC        mov al, byte ptr [bp - 4]
2C04  88 46 FA        mov byte ptr [bp - 6], al
2C07  BF 1E 33        mov di, 0x331e
2C0A  1E              push ds
2C0B  57              push di
2C0C  BF 5C DD        mov di, 0xdd5c
2C0F  1E              push ds
2C10  57              push di
2C11  9A 2F 05 2A 23  call far 232A:052F
2C16  6A 0B           push 0xb
2C18  8D BE F6 FE     lea di, [bp - 0x10a]
2C1C  16              push ss
2C1D  57              push di
2C1E  8B 46 FC        mov ax, word ptr [bp - 4]
2C21  8B 56 FE        mov dx, word ptr [bp - 2]
2C24  B9 E8 03        mov cx, 0x3e8
2C27  31 DB           xor bx, bx
2C29  9A 2A 0A C9 26  call far 26C9:0A2A
2C2E  52              push dx
2C2F  50              push ax
2C30  0E              push cs
2C31  E8 61 E3        call 0xf95
2C34  6A 19           push 0x19
2C36  6A 10           push 0x10
2C38  BF 5C DD        mov di, 0xdd5c
2C3B  1E              push ds
2C3C  57              push di
2C3D  9A 1B 04 2A 23  call far 232A:041B
2C42  8D BE F6 FE     lea di, [bp - 0x10a]
2C46  16              push ss
2C47  57              push di
2C48  8B 46 FC        mov ax, word ptr [bp - 4]
2C4B  8B 56 FE        mov dx, word ptr [bp - 2]
2C4E  B9 20 A1        mov cx, 0xa120
2C51  BB 07 00        mov bx, 7
2C54  9A 2A 0A C9 26  call far 26C9:0A2A
2C59  52              push dx
2C5A  50              push ax
2C5B  0E              push cs
2C5C  E8 36 E3        call 0xf95
2C5F  6A 19           push 0x19
2C61  6A 2A           push 0x2a
2C63  BF 5C DD        mov di, 0xdd5c
2C66  1E              push ds
2C67  57              push di
2C68  9A 9D 03 2A 23  call far 232A:039D
2C6D  C4 3E 5C DD     les di, ptr [0xdd5c]
2C71  81 C7 00 0F     add di, 0xf00
2C75  06              push es
2C76  57              push di
2C77  C4 3E 58 DD     les di, ptr [0xdd58]
2C7B  81 C7 00 0F     add di, 0xf00
2C7F  06              push es
2C80  57              push di
2C81  68 A0 00        push 0xa0
2C84  9A 12 0A C9 26  call far 26C9:0A12
2C89  9A 9B 09 2A 23  call far 232A:099B
2C8E  80 3E 88 DE 05  cmp byte ptr [0xde88], 5
2C93  75 07           jne 0x2c9c
2C95  C6 06 88 DE 06  mov byte ptr [0xde88], 6
2C9A  EB 0C           jmp 0x2ca8
loc_2C9C:
2C9C  80 3E 88 DE 06  cmp byte ptr [0xde88], 6
2CA1  75 05           jne 0x2ca8
2CA3  C6 06 88 DE 05  mov byte ptr [0xde88], 5
loc_2CA8:
2CA8  8D 7E FA        lea di, [bp - 6]
2CAB  16              push ss
2CAC  57              push di
2CAD  8A 46 FB        mov al, byte ptr [bp - 5]
2CB0  30 E4           xor ah, ah
2CB2  50              push ax
2CB3  9A C4 0E 2A 23  call far 232A:0EC4
2CB8  8A 46 FA        mov al, byte ptr [bp - 6]
2CBB  30 E4           xor ah, ah
2CBD  31 D2           xor dx, dx
2CBF  89 46 FC        mov word ptr [bp - 4], ax
2CC2  89 56 FE        mov word ptr [bp - 2], dx
2CC5  80 3E 88 DE 01  cmp byte ptr [0xde88], 1
2CCA  75 02           jne 0x2cce
2CCC  EB 77           jmp 0x2d45
loc_2CCE:
2CCE  80 3E 88 DE 02  cmp byte ptr [0xde88], 2
2CD3  74 03           je 0x2cd8
2CD5  E9 29 FF        jmp 0x2c01
loc_2CD8:
2CD8  BF 1A 2B        mov di, 0x2b1a
2CDB  0E              push cs
2CDC  57              push di
2CDD  9A 02 07 BC 24  call far 24BC:0702
2CE2  8B 46 FC        mov ax, word ptr [bp - 4]
2CE5  C4 7E F6        les di, ptr [bp - 0xa]
2CE8  26 89 05        mov word ptr es:[di], ax
2CEB  8B 46 FC        mov ax, word ptr [bp - 4]
2CEE  8B 56 FE        mov dx, word ptr [bp - 2]
2CF1  B9 20 A1        mov cx, 0xa120
2CF4  BB 07 00        mov bx, 7
2CF7  9A 2A 0A C9 26  call far 26C9:0A2A
2CFC  C4 7E F6        les di, ptr [bp - 0xa]
2CFF  26 29 45 52     sub word ptr es:[di + 0x52], ax
2D03  26 19 55 54     sbb word ptr es:[di + 0x54], dx
2D07  8B 46 FC        mov ax, word ptr [bp - 4]
2D0A  8B 56 FE        mov dx, word ptr [bp - 2]
2D0D  B9 20 A1        mov cx, 0xa120
2D10  BB 07 00        mov bx, 7
2D13  9A 2A 0A C9 26  call far 26C9:0A2A
2D18  C4 7E F6        les di, ptr [bp - 0xa]
2D1B  26 01 45 46     add word ptr es:[di + 0x46], ax
2D1F  26 11 55 48     adc word ptr es:[di + 0x48], dx
2D23  8B 46 FC        mov ax, word ptr [bp - 4]
2D26  8B 56 FE        mov dx, word ptr [bp - 2]
2D29  B9 20 A1        mov cx, 0xa120
2D2C  BB 07 00        mov bx, 7
2D2F  9A 2A 0A C9 26  call far 26C9:0A2A
2D34  C4 7E F6        les di, ptr [bp - 0xa]
2D37  26 01 45 5A     add word ptr es:[di + 0x5a], ax
2D3B  26 11 55 5C     adc word ptr es:[di + 0x5c], dx
2D3F  26 C7 45 02 1D 00 mov word ptr es:[di + 2], 0x1d
loc_2D45:
2D45  C9              leave
2D46  C2 02 00        ret 2
; data (not reached as code), 112 bytes
2D49                  pstr 'Your stadium will be ready in '
2D68                  pstr ' weeks'
2D6F                  pstr "Your stadium is as big as it's going to get!!"
2D9D                  pstr "You don't have enough money"

; ---- routine 1B55:2DB9  (found by: call)
sub_2DB9:
2DB9  C8 08 02 00     enter 0x208, 0
2DBD  6B 46 06 5E     imul ax, word ptr [bp + 6], 0x5e
2DC1  C4 3E C4 DC     les di, ptr [0xdcc4]
2DC5  03 F8           add di, ax
2DC7  81 C7 A2 FF     add di, 0xffa2
2DCB  89 7E FC        mov word ptr [bp - 4], di
2DCE  8C 46 FE        mov word ptr [bp - 2], es
2DD1  C4 3E D2 D7     les di, ptr [0xd7d2]
2DD5  8B 7E 06        mov di, word ptr [bp + 6]
2DD8  80 BD B9 DC 00  cmp byte ptr [di - 0x2347], 0
2DDD  75 03           jne 0x2de2
2DDF  E9 12 01        jmp 0x2ef4
loc_2DE2:
2DE2  9A 68 05 BC 24  call far 24BC:0568
2DE7  C4 7E FC        les di, ptr [bp - 4]
2DEA  26 83 7D 02 00  cmp word ptr es:[di + 2], 0
2DEF  77 03           ja 0x2df4
2DF1  E9 87 00        jmp 0x2e7b
loc_2DF4:
2DF4  26 FF 4D 02     dec word ptr es:[di + 2]
2DF8  26 83 7D 02 00  cmp word ptr es:[di + 2], 0
2DFD  75 39           jne 0x2e38
2DFF  BF DA 32        mov di, 0x32da
2E02  1E              push ds
2E03  57              push di
2E04  55              push bp
2E05  E8 C7 FC        call 0x2acf
2E08  8D 7E D8        lea di, [bp - 0x28]
2E0B  16              push ss
2E0C  57              push di
2E0D  6A 02           push 2
2E0F  9A 94 0D C9 26  call far 26C9:0D94
2E14  9A 95 07 2A 23  call far 232A:0795
2E19  C4 7E FC        les di, ptr [bp - 4]
2E1C  26 8A 15        mov dl, byte ptr es:[di]
2E1F  8B 7E 06        mov di, word ptr [bp + 6]
2E22  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
2E26  30 E4           xor ah, ah
2E28  8B F8           mov di, ax
2E2A  00 95 E5 D9     add byte ptr [di - 0x261b], dl
2E2E  C4 7E FC        les di, ptr [bp - 4]
2E31  31 C0           xor ax, ax
2E33  26 89 05        mov word ptr es:[di], ax
2E36  EB 41           jmp 0x2e79
loc_2E38:
2E38  80 3E 88 DE 0D  cmp byte ptr [0xde88], 0xd
2E3D  75 3A           jne 0x2e79
2E3F  8D BE F8 FD     lea di, [bp - 0x208]
2E43  16              push ss
2E44  57              push di
2E45  BF 49 2D        mov di, 0x2d49
2E48  0E              push cs
2E49  57              push di
2E4A  9A 53 0B C9 26  call far 26C9:0B53
2E4F  8D BE F8 FE     lea di, [bp - 0x108]
2E53  16              push ss
2E54  57              push di
2E55  C4 7E FC        les di, ptr [bp - 4]
2E58  26 8B 45 02     mov ax, word ptr es:[di + 2]
2E5C  31 D2           xor dx, dx
2E5E  52              push dx
2E5F  50              push ax
2E60  9A C9 07 2A 23  call far 232A:07C9
2E65  9A D2 0B C9 26  call far 26C9:0BD2
2E6A  BF 68 2D        mov di, 0x2d68
2E6D  0E              push cs
2E6E  57              push di
2E6F  9A D2 0B C9 26  call far 26C9:0BD2
2E74  9A 02 07 BC 24  call far 24BC:0702
loc_2E79:
2E79  EB 74           jmp 0x2eef
loc_2E7B:
2E7B  80 3E 88 DE 0D  cmp byte ptr [0xde88], 0xd
2E80  75 6D           jne 0x2eef
2E82  8B 7E 06        mov di, word ptr [bp + 6]
2E85  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
2E89  30 E4           xor ah, ah
2E8B  8B F8           mov di, ax
2E8D  80 BD E5 D9 96  cmp byte ptr [di - 0x261b], 0x96
2E92  B0 00           mov al, 0
2E94  72 01           jb 0x2e97
2E96  40              inc ax
loc_2E97:
2E97  50              push ax
2E98  BF 6F 2D        mov di, 0x2d6f
2E9B  0E              push cs
2E9C  57              push di
2E9D  9A 98 00 2A 23  call far 232A:0098
2EA2  08 C0           or al, al
2EA4  75 49           jne 0x2eef
2EA6  8B 7E 06        mov di, word ptr [bp + 6]
2EA9  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
2EAD  30 E4           xor ah, ah
2EAF  50              push ax
2EB0  0E              push cs
2EB1  E8 9A 07        call 0x364e
2EB4  F7 D2           not dx
2EB6  F7 D8           neg ax
2EB8  83 DA FF        sbb dx, -1
2EBB  52              push dx
2EBC  50              push ax
2EBD  FF 76 06        push word ptr [bp + 6]
2EC0  0E              push cs
2EC1  E8 AF 07        call 0x3673
2EC4  2D 20 A1        sub ax, 0xa120
2EC7  83 DA 07        sbb dx, 7
2ECA  59              pop cx
2ECB  5B              pop bx
2ECC  3B D3           cmp dx, bx
2ECE  7C 0A           jl 0x2eda
2ED0  7F 04           jg 0x2ed6
2ED2  3B C1           cmp ax, cx
2ED4  76 04           jbe 0x2eda
loc_2ED6:
2ED6  B0 00           mov al, 0
2ED8  EB 02           jmp 0x2edc
loc_2EDA:
2EDA  B0 01           mov al, 1
loc_2EDC:
2EDC  50              push ax
2EDD  BF 9D 2D        mov di, 0x2d9d
2EE0  0E              push cs
2EE1  57              push di
2EE2  9A 98 00 2A 23  call far 232A:0098
2EE7  08 C0           or al, al
2EE9  75 04           jne 0x2eef
2EEB  55              push bp
2EEC  E8 54 FC        call 0x2b43
loc_2EEF:
2EEF  9A 98 05 BC 24  call far 24BC:0598
loc_2EF4:
2EF4  C9              leave
2EF5  CA 02 00        retf 2
; data (not reached as code), 2 bytes
2EF8                  db 01 02   ; ..

; ---- routine 1B55:2EFA  (found by: call)
sub_2EFA:
2EFA  C8 06 01 00     enter 0x106, 0
2EFE  6B 46 08 3E     imul ax, word ptr [bp + 8], 0x3e
2F02  C4 3E C2 D7     les di, ptr [0xd7c2]
2F06  03 F8           add di, ax
2F08  81 C7 C2 FF     add di, 0xffc2
2F0C  89 7E FA        mov word ptr [bp - 6], di
2F0F  8C 46 FC        mov word ptr [bp - 4], es
2F12  BF D8 23        mov di, 0x23d8
2F15  1E              push ds
2F16  57              push di
2F17  BF 5C DD        mov di, 0xdd5c
2F1A  1E              push ds
2F1B  57              push di
2F1C  9A 2F 05 2A 23  call far 232A:052F
2F21  C7 46 FE 01 00  mov word ptr [bp - 2], 1
2F26  EB 03           jmp 0x2f2b
loc_2F28:
2F28  FF 46 FE        inc word ptr [bp - 2]
loc_2F2B:
2F2B  8B 46 FE        mov ax, word ptr [bp - 2]
2F2E  8B 7E 08        mov di, word ptr [bp + 8]
2F31  8B F7           mov si, di
2F33  D1 E7           shl di, 1
2F35  01 F7           add di, si
2F37  03 F8           add di, ax
2F39  8A 85 92 DA     mov al, byte ptr [di - 0x256e]
2F3D  50              push ax
2F3E  BF F8 2E        mov di, 0x2ef8
2F41  0E              push cs
2F42  57              push di
2F43  6A 06           push 6
2F45  8B 7E FE        mov di, word ptr [bp - 2]
2F48  8A 85 8B 10     mov al, byte ptr [di + 0x108b]
2F4C  50              push ax
2F4D  BF 5C DD        mov di, 0xdd5c
2F50  1E              push ds
2F51  57              push di
2F52  9A 1B 04 2A 23  call far 232A:041B
2F57  83 7E FE 03     cmp word ptr [bp - 2], 3
2F5B  75 CB           jne 0x2f28
2F5D  FF 76 08        push word ptr [bp + 8]
2F60  6A 04           push 4
2F62  6A 35           push 0x35
2F64  0E              push cs
2F65  E8 D3 DF        call 0xf3b
2F68  8B 46 08        mov ax, word ptr [bp + 8]
2F6B  C4 3E B6 D7     les di, ptr [0xd7b6]
2F6F  03 F8           add di, ax
2F71  26 8A 45 FF     mov al, byte ptr es:[di - 1]
2F75  30 E4           xor ah, ah
2F77  8B F8           mov di, ax
2F79  C1 E7 04        shl di, 4
2F7C  81 C7 2C 9A     add di, 0x9a2c
2F80  1E              push ds
2F81  57              push di
2F82  6A 08           push 8
2F84  6A 35           push 0x35
2F86  BF 5C DD        mov di, 0xdd5c
2F89  1E              push ds
2F8A  57              push di
2F8B  9A 83 02 2A 23  call far 232A:0283
2F90  C4 7E FA        les di, ptr [bp - 6]
2F93  26 8A 45 37     mov al, byte ptr es:[di + 0x37]
2F97  98              cwde
2F98  8B F8           mov di, ax
2F9A  C1 E7 04        shl di, 4
2F9D  81 C7 E6 DC     add di, 0xdce6
2FA1  1E              push ds
2FA2  57              push di
2FA3  6A 0A           push 0xa
2FA5  6A 35           push 0x35
2FA7  BF 5C DD        mov di, 0xdd5c
2FAA  1E              push ds
2FAB  57              push di
2FAC  9A 83 02 2A 23  call far 232A:0283
2FB1  8D BE FA FE     lea di, [bp - 0x106]
2FB5  16              push ss
2FB6  57              push di
2FB7  C4 7E FA        les di, ptr [bp - 6]
2FBA  26 8A 45 36     mov al, byte ptr es:[di + 0x36]
2FBE  30 E4           xor ah, ah
2FC0  31 D2           xor dx, dx
2FC2  52              push dx
2FC3  50              push ax
2FC4  9A C9 07 2A 23  call far 232A:07C9
2FC9  6A 0C           push 0xc
2FCB  6A 35           push 0x35
2FCD  BF 5C DD        mov di, 0xdd5c
2FD0  1E              push ds
2FD1  57              push di
2FD2  9A 83 02 2A 23  call far 232A:0283
2FD7  8D BE FA FE     lea di, [bp - 0x106]
2FDB  16              push ss
2FDC  57              push di
2FDD  FF 76 08        push word ptr [bp + 8]
2FE0  0E              push cs
2FE1  E8 1C F7        call 0x2700
2FE4  52              push dx
2FE5  50              push ax
2FE6  9A C9 07 2A 23  call far 232A:07C9
2FEB  6A 0E           push 0xe
2FED  6A 35           push 0x35
2FEF  BF 5C DD        mov di, 0xdd5c
2FF2  1E              push ds
2FF3  57              push di
2FF4  9A 83 02 2A 23  call far 232A:0283
2FF9  6A 00           push 0
2FFB  6A 0B           push 0xb
2FFD  8B 7E 08        mov di, word ptr [bp + 8]
3000  8A 85 35 D9     mov al, byte ptr [di - 0x26cb]
3004  30 E4           xor ah, ah
3006  99              cdq
3007  B9 12 00        mov cx, 0x12
300A  F7 F9           idiv cx
300C  99              cdq
300D  52              push dx
300E  50              push ax
300F  9A FA 04 BC 24  call far 24BC:04FA
3014  8B F8           mov di, ax
3016  8A 85 EC 93     mov al, byte ptr [di - 0x6c14]
301A  30 E4           xor ah, ah
301C  8B F8           mov di, ax
301E  C1 E7 04        shl di, 4
3021  81 C7 0C 8A     add di, 0x8a0c
3025  1E              push ds
3026  57              push di
3027  6A 10           push 0x10
3029  6A 35           push 0x35
302B  BF 5C DD        mov di, 0xdd5c
302E  1E              push ds
302F  57              push di
3030  9A 83 02 2A 23  call far 232A:0283
3035  8D BE FA FE     lea di, [bp - 0x106]
3039  16              push ss
303A  57              push di
303B  C4 7E FA        les di, ptr [bp - 6]
303E  26 8A 45 32     mov al, byte ptr es:[di + 0x32]
3042  30 E4           xor ah, ah
3044  31 D2           xor dx, dx
3046  52              push dx
3047  50              push ax
3048  9A C9 07 2A 23  call far 232A:07C9
304D  6A 12           push 0x12
304F  6A 35           push 0x35
3051  BF 5C DD        mov di, 0xdd5c
3054  1E              push ds
3055  57              push di
3056  9A 83 02 2A 23  call far 232A:0283
305B  C4 3E D2 D7     les di, ptr [0xd7d2]
305F  89 7E F6        mov word ptr [bp - 0xa], di
3062  8C 46 F8        mov word ptr [bp - 8], es
3065  B0 00           mov al, 0
3067  08 C0           or al, al
3069  75 2A           jne 0x3095
306B  80 7E 06 00     cmp byte ptr [bp + 6], 0
306F  75 26           jne 0x3097
3071  FF 76 08        push word ptr [bp + 8]
3074  0E              push cs
3075  E8 02 DE        call 0xe7a
3078  08 C0           or al, al
307A  75 1B           jne 0x3097
307C  C4 7E F6        les di, ptr [bp - 0xa]
307F  26 8A 45 19     mov al, byte ptr es:[di + 0x19]
3083  30 E4           xor ah, ah
3085  3B 46 08        cmp ax, word ptr [bp + 8]
3088  74 0D           je 0x3097
308A  26 8A 45 1A     mov al, byte ptr es:[di + 0x1a]
308E  30 E4           xor ah, ah
3090  3B 46 08        cmp ax, word ptr [bp + 8]
3093  74 02           je 0x3097
loc_3095:
3095  EB 6D           jmp 0x3104
loc_3097:
3097  BF 22 25        mov di, 0x2522
309A  1E              push ds
309B  57              push di
309C  BF 5C DD        mov di, 0xdd5c
309F  1E              push ds
30A0  57              push di
30A1  9A 2F 05 2A 23  call far 232A:052F
30A6  C7 06 64 DD 70 00 mov word ptr [0xdd64], 0x70
30AC  FF 76 08        push word ptr [bp + 8]
30AF  0E              push cs
30B0  E8 C7 DD        call 0xe7a
30B3  08 C0           or al, al
30B5  74 2B           je 0x30e2
30B7  A0 BA DC        mov al, byte ptr [0xdcba]
30BA  30 E4           xor ah, ah
30BC  3B 46 08        cmp ax, word ptr [bp + 8]
30BF  B0 00           mov al, 0
30C1  74 01           je 0x30c4
30C3  40              inc ax
loc_30C4:
30C4  30 E4           xor ah, ah
30C6  40              inc ax
30C7  6B C0 5E        imul ax, ax, 0x5e
30CA  C4 3E C4 DC     les di, ptr [0xdcc4]
30CE  03 F8           add di, ax
30D0  26 FF 75 F6     push word ptr es:[di - 0xa]
30D4  26 FF 75 F4     push word ptr es:[di - 0xc]
30D8  6A 14           push 0x14
30DA  6A 36           push 0x36
30DC  0E              push cs
30DD  E8 3E DF        call 0x101e
30E0  EB 11           jmp 0x30f3
loc_30E2:
30E2  FF 76 08        push word ptr [bp + 8]
30E5  0E              push cs
30E6  E8 92 04        call 0x357b
30E9  52              push dx
30EA  50              push ax
30EB  6A 14           push 0x14
30ED  6A 36           push 0x36
30EF  0E              push cs
30F0  E8 2B DF        call 0x101e
loc_30F3:
30F3  FF 76 08        push word ptr [bp + 8]
30F6  0E              push cs
30F7  E8 54 05        call 0x364e
30FA  52              push dx
30FB  50              push ax
30FC  6A 16           push 0x16
30FE  6A 36           push 0x36
3100  0E              push cs
3101  E8 1A DF        call 0x101e
loc_3104:
3104  C9              leave
3105  CA 04 00        retf 4

; ---- routine 1B55:3108  (found by: far)
sub_3108:
3108  55              push bp
3109  89 E5           mov bp, sp
310B  C6 06 88 DE 06  mov byte ptr [0xde88], 6
3110  BF 90 0D        mov di, 0xd90
3113  1E              push ds
3114  57              push di
3115  6A 03           push 3
3117  9A C4 0E 2A 23  call far 232A:0EC4
311C  C9              leave
311D  CB              retf

; ---- routine 1B55:311E  (found by: call)
sub_311E:
311E  C8 0A 00 00     enter 0xa, 0
3122  6B 46 06 3E     imul ax, word ptr [bp + 6], 0x3e
3126  C4 3E C2 D7     les di, ptr [0xd7c2]
312A  03 F8           add di, ax
312C  81 C7 C2 FF     add di, 0xffc2
3130  89 7E FA        mov word ptr [bp - 6], di
3133  8C 46 FC        mov word ptr [bp - 4], es
3136  31 C0           xor ax, ax
3138  A3 D4 D1        mov word ptr [0xd1d4], ax
313B  31 C0           xor ax, ax
313D  A3 D6 D1        mov word ptr [0xd1d6], ax
3140  31 C0           xor ax, ax
3142  A3 DA D1        mov word ptr [0xd1da], ax
3145  31 C0           xor ax, ax
3147  A3 D8 D1        mov word ptr [0xd1d8], ax
314A  C7 46 FE 01 00  mov word ptr [bp - 2], 1
314F  EB 03           jmp 0x3154
loc_3151:
3151  FF 46 FE        inc word ptr [bp - 2]
loc_3154:
3154  8B 46 FE        mov ax, word ptr [bp - 2]
3157  D1 E0           shl ax, 1
3159  C4 7E FA        les di, ptr [bp - 6]
315C  03 F8           add di, ax
315E  26 FF 75 FE     push word ptr es:[di - 2]
3162  0E              push cs
3163  E8 23 1E        call 0x4f89
3166  08 C0           or al, al
3168  75 67           jne 0x31d1
316A  8B 46 FE        mov ax, word ptr [bp - 2]
316D  D1 E0           shl ax, 1
316F  C4 7E FA        les di, ptr [bp - 6]
3172  03 F8           add di, ax
3174  26 6B 45 FE 0F  imul ax, word ptr es:[di - 2], 0xf
3179  C4 3E BE D7     les di, ptr [0xd7be]
317D  03 F8           add di, ax
317F  89 7E F6        mov word ptr [bp - 0xa], di
3182  8C 46 F8        mov word ptr [bp - 8], es
3185  26 8A 45 06     mov al, byte ptr es:[di + 6]
3189  98              cwde
318A  99              cdq
318B  52              push dx
318C  50              push ax
318D  6A 00           push 0
318F  6A 20           push 0x20
3191  9A FA 04 BC 24  call far 24BC:04FA
3196  01 06 D4 D1     add word ptr [0xd1d4], ax
319A  C4 7E F6        les di, ptr [bp - 0xa]
319D  26 80 7D 08 00  cmp byte ptr es:[di + 8], 0
31A2  7E 09           jle 0x31ad
31A4  26 8A 45 07     mov al, byte ptr es:[di + 7]
31A8  98              cwde
31A9  01 06 D6 D1     add word ptr [0xd1d6], ax
loc_31AD:
31AD  8B 46 FE        mov ax, word ptr [bp - 2]
31B0  D1 E0           shl ax, 1
31B2  C4 7E FA        les di, ptr [bp - 6]
31B5  03 F8           add di, ax
31B7  26 FF 75 FE     push word ptr es:[di - 2]
31BB  0E              push cs
31BC  E8 4D 1C        call 0x4e0c
31BF  30 E4           xor ah, ah
31C1  01 06 DA D1     add word ptr [0xd1da], ax
31C5  C4 7E F6        les di, ptr [bp - 0xa]
31C8  26 8A 45 08     mov al, byte ptr es:[di + 8]
31CC  98              cwde
31CD  01 06 D8 D1     add word ptr [0xd1d8], ax
loc_31D1:
31D1  83 7E FE 0B     cmp word ptr [bp - 2], 0xb
31D5  74 03           je 0x31da
31D7  E9 77 FF        jmp 0x3151
loc_31DA:
31DA  A1 D4 D1        mov ax, word ptr [0xd1d4]
31DD  31 D2           xor dx, dx
31DF  B9 0B 00        mov cx, 0xb
31E2  F7 F1           div cx
31E4  A3 D4 D1        mov word ptr [0xd1d4], ax
31E7  A1 D6 D1        mov ax, word ptr [0xd1d6]
31EA  31 D2           xor dx, dx
31EC  B9 0B 00        mov cx, 0xb
31EF  F7 F1           div cx
31F1  A3 D6 D1        mov word ptr [0xd1d6], ax
31F4  A1 DA D1        mov ax, word ptr [0xd1da]
31F7  31 D2           xor dx, dx
31F9  B9 0B 00        mov cx, 0xb
31FC  F7 F1           div cx
31FE  A3 DA D1        mov word ptr [0xd1da], ax
3201  A1 D8 D1        mov ax, word ptr [0xd1d8]
3204  31 D2           xor dx, dx
3206  B9 0B 00        mov cx, 0xb
3209  F7 F1           div cx
320B  A3 D8 D1        mov word ptr [0xd1d8], ax
320E  83 3E D4 D1 01  cmp word ptr [0xd1d4], 1
3213  73 06           jae 0x321b
3215  C7 06 D4 D1 01 00 mov word ptr [0xd1d4], 1
loc_321B:
321B  C9              leave
321C  CA 02 00        retf 2

; ---- routine 1B55:321F  (found by: call)
sub_321F:
321F  C8 0A 00 00     enter 0xa, 0
3223  FF 76 06        push word ptr [bp + 6]
3226  6A 01           push 1
3228  6A 00           push 0
322A  0E              push cs
322B  E8 BD 1E        call 0x50eb
322E  C7 46 FE 01 00  mov word ptr [bp - 2], 1
3233  EB 03           jmp 0x3238
loc_3235:
3235  FF 46 FE        inc word ptr [bp - 2]
loc_3238:
3238  8B 7E FE        mov di, word ptr [bp - 2]
323B  C1 E7 02        shl di, 2
323E  8B 85 76 D6     mov ax, word ptr [di - 0x298a]
3242  C1 E8 02        shr ax, 2
3245  8B 7E FE        mov di, word ptr [bp - 2]
3248  C1 E7 02        shl di, 2
324B  89 85 76 D6     mov word ptr [di - 0x298a], ax
324F  83 7E FE 03     cmp word ptr [bp - 2], 3
3253  75 E0           jne 0x3235
3255  31 C0           xor ax, ax
3257  89 46 FE        mov word ptr [bp - 2], ax
325A  EB 03           jmp 0x325f
loc_325C:
325C  FF 46 FE        inc word ptr [bp - 2]
loc_325F:
325F  8B 7E FE        mov di, word ptr [bp - 2]
3262  C1 E7 02        shl di, 2
3265  81 BD 76 D6 00 01 cmp word ptr [di - 0x298a], 0x100
326B  76 0C           jbe 0x3279
326D  8B 7E FE        mov di, word ptr [bp - 2]
3270  C1 E7 02        shl di, 2
3273  C7 85 76 D6 00 01 mov word ptr [di - 0x298a], 0x100
loc_3279:
3279  8B 46 FE        mov ax, word ptr [bp - 2]
327C  05 09 00        add ax, 9
327F  50              push ax
3280  6A 27           push 0x27
3282  8B 7E FE        mov di, word ptr [bp - 2]
3285  C1 E7 02        shl di, 2
3288  8B 85 76 D6     mov ax, word ptr [di - 0x298a]
328C  C1 E8 04        shr ax, 4
328F  50              push ax
3290  9A 03 02 2A 23  call far 232A:0203
3295  83 7E FE 03     cmp word ptr [bp - 2], 3
3299  75 C1           jne 0x325c
329B  31 C0           xor ax, ax
329D  89 46 FA        mov word ptr [bp - 6], ax
32A0  89 46 FC        mov word ptr [bp - 4], ax
32A3  C7 46 FE 01 00  mov word ptr [bp - 2], 1
32A8  EB 03           jmp 0x32ad
loc_32AA:
32AA  FF 46 FE        inc word ptr [bp - 2]
loc_32AD:
32AD  6B 46 06 3E     imul ax, word ptr [bp + 6], 0x3e
32B1  C4 3E C2 D7     les di, ptr [0xd7c2]
32B5  03 F8           add di, ax
32B7  81 C7 C2 FF     add di, 0xffc2
32BB  89 7E F6        mov word ptr [bp - 0xa], di
32BE  8C 46 F8        mov word ptr [bp - 8], es
32C1  8B 46 FE        mov ax, word ptr [bp - 2]
32C4  D1 E0           shl ax, 1
32C6  03 F8           add di, ax
32C8  26 83 7D FE 00  cmp word ptr es:[di - 2], 0
32CD  74 36           je 0x3305
32CF  8B 46 FE        mov ax, word ptr [bp - 2]
32D2  D1 E0           shl ax, 1
32D4  C4 7E F6        les di, ptr [bp - 0xa]
32D7  03 F8           add di, ax
32D9  26 8B 45 FE     mov ax, word ptr es:[di - 2]
32DD  C1 E0 03        shl ax, 3
32E0  C4 3E BA D7     les di, ptr [0xd7ba]
32E4  03 F8           add di, ax
32E6  26 80 7D 01 11  cmp byte ptr es:[di + 1], 0x11
32EB  76 18           jbe 0x3305
32ED  8B 46 FE        mov ax, word ptr [bp - 2]
32F0  D1 E0           shl ax, 1
32F2  C4 7E F6        les di, ptr [bp - 0xa]
32F5  03 F8           add di, ax
32F7  26 FF 75 FE     push word ptr es:[di - 2]
32FB  0E              push cs
32FC  E8 5E 15        call 0x485d
32FF  01 46 FA        add word ptr [bp - 6], ax
3302  11 56 FC        adc word ptr [bp - 4], dx
loc_3305:
3305  83 7E FE 0B     cmp word ptr [bp - 2], 0xb
3309  75 9F           jne 0x32aa
330B  C7 06 64 DD 70 00 mov word ptr [0xdd64], 0x70
3311  FF 76 FC        push word ptr [bp - 4]
3314  FF 76 FA        push word ptr [bp - 6]
3317  6A 0E           push 0xe
3319  6A 36           push 0x36
331B  0E              push cs
331C  E8 FF DC        call 0x101e
331F  C9              leave
3320  CA 02 00        retf 2

; ---- routine 1B55:3323  (found by: call, far)
sub_3323:
3323  C8 06 01 00     enter 0x106, 0
3327  6B 46 06 3E     imul ax, word ptr [bp + 6], 0x3e
332B  C4 3E C2 D7     les di, ptr [0xd7c2]
332F  03 F8           add di, ax
3331  81 C7 C2 FF     add di, 0xffc2
3335  89 7E FA        mov word ptr [bp - 6], di
3338  8C 46 FC        mov word ptr [bp - 4], es
333B  C6 06 90 0D 03  mov byte ptr [0xd90], 3
3340  BF 82 3B        mov di, 0x3b82
3343  1E              push ds
3344  57              push di
3345  BF 5C DD        mov di, 0xdd5c
3348  1E              push ds
3349  57              push di
334A  9A 2F 05 2A 23  call far 232A:052F
334F  FF 76 06        push word ptr [bp + 6]
3352  6A 01           push 1
3354  6A 17           push 0x17
3356  0E              push cs
3357  E8 89 DB        call 0xee3
335A  C7 46 FE 01 00  mov word ptr [bp - 2], 1
335F  EB 03           jmp 0x3364
loc_3361:
3361  FF 46 FE        inc word ptr [bp - 2]
loc_3364:
3364  FF 76 FE        push word ptr [bp - 2]
3367  C4 7E FA        les di, ptr [bp - 6]
336A  26 8A 45 39     mov al, byte ptr es:[di + 0x39]
336E  30 E4           xor ah, ah
3370  50              push ax
3371  9A 59 02 BC 24  call far 24BC:0259
3376  98              cwde
3377  C1 E0 04        shl ax, 4
337A  8B 7E FE        mov di, word ptr [bp - 2]
337D  C1 E7 05        shl di, 5
3380  03 F8           add di, ax
3382  81 C7 E8 85     add di, 0x85e8
3386  1E              push ds
3387  57              push di
3388  8B 46 FE        mov ax, word ptr [bp - 2]
338B  05 0F 00        add ax, 0xf
338E  50              push ax
338F  6A 35           push 0x35
3391  BF 5C DD        mov di, 0xdd5c
3394  1E              push ds
3395  57              push di
3396  9A 83 02 2A 23  call far 232A:0283
339B  83 7E FE 08     cmp word ptr [bp - 2], 8
339F  75 C0           jne 0x3361
33A1  8D BE FA FE     lea di, [bp - 0x106]
33A5  16              push ss
33A6  57              push di
33A7  FF 76 06        push word ptr [bp + 6]
33AA  0E              push cs
33AB  E8 01 DD        call 0x10af
33AE  6A 02           push 2
33B0  6A 35           push 0x35
33B2  BF 5C DD        mov di, 0xdd5c
33B5  1E              push ds
33B6  57              push di
33B7  9A 83 02 2A 23  call far 232A:0283
33BC  FF 76 06        push word ptr [bp + 6]
33BF  0E              push cs
33C0  E8 5B FD        call 0x311e
33C3  8B 3E D4 D1     mov di, word ptr [0xd1d4]
33C7  8A 85 5B 93     mov al, byte ptr [di - 0x6ca5]
33CB  30 E4           xor ah, ah
33CD  8B F8           mov di, ax
33CF  C1 E7 04        shl di, 4
33D2  81 C7 0C 8A     add di, 0x8a0c
33D6  1E              push ds
33D7  57              push di
33D8  6A 04           push 4
33DA  6A 35           push 0x35
33DC  BF 5C DD        mov di, 0xdd5c
33DF  1E              push ds
33E0  57              push di
33E1  9A 83 02 2A 23  call far 232A:0283
33E6  8B 3E D6 D1     mov di, word ptr [0xd1d6]
33EA  8A 85 A0 93     mov al, byte ptr [di - 0x6c60]
33EE  30 E4           xor ah, ah
33F0  8B F8           mov di, ax
33F2  C1 E7 04        shl di, 4
33F5  81 C7 0C 8A     add di, 0x8a0c
33F9  1E              push ds
33FA  57              push di
33FB  6A 05           push 5
33FD  6A 35           push 0x35
33FF  BF 5C DD        mov di, 0xdd5c
3402  1E              push ds
3403  57              push di
3404  9A 83 02 2A 23  call far 232A:0283
3409  8B 3E D8 D1     mov di, word ptr [0xd1d8]
340D  8A 85 C2 93     mov al, byte ptr [di - 0x6c3e]
3411  30 E4           xor ah, ah
3413  8B F8           mov di, ax
3415  C1 E7 04        shl di, 4
3418  81 C7 0C 8A     add di, 0x8a0c
341C  1E              push ds
341D  57              push di
341E  6A 06           push 6
3420  6A 35           push 0x35
3422  BF 5C DD        mov di, 0xdd5c
3425  1E              push ds
3426  57              push di
3427  9A 83 02 2A 23  call far 232A:0283
342C  8B 3E DA D1     mov di, word ptr [0xd1da]
3430  8A 85 7C 93     mov al, byte ptr [di - 0x6c84]
3434  30 E4           xor ah, ah
3436  8B F8           mov di, ax
3438  C1 E7 04        shl di, 4
343B  81 C7 0C 8A     add di, 0x8a0c
343F  1E              push ds
3440  57              push di
3441  6A 07           push 7
3443  6A 35           push 0x35
3445  BF 5C DD        mov di, 0xdd5c
3448  1E              push ds
3449  57              push di
344A  9A 83 02 2A 23  call far 232A:0283
344F  FF 76 06        push word ptr [bp + 6]
3452  0E              push cs
3453  E8 C9 FD        call 0x321f
3456  C9              leave
3457  CA 02 00        retf 2

; ---- routine 1B55:345A  (found by: far)
sub_345A:
345A  55              push bp
345B  89 E5           mov bp, sp
345D  BF 2E 13        mov di, 0x132e
3460  1E              push ds
3461  57              push di
3462  BF 5C DD        mov di, 0xdd5c
3465  1E              push ds
3466  57              push di
3467  9A 2F 05 2A 23  call far 232A:052F
346C  BF 46 63        mov di, 0x6346
346F  1E              push ds
3470  57              push di
3471  BF 5C DD        mov di, 0xdd5c
3474  1E              push ds
3475  57              push di
3476  9A 2F 05 2A 23  call far 232A:052F
347B  80 3E 90 0D 01  cmp byte ptr [0xd90], 1
3480  75 0D           jne 0x348f
3482  FF 76 08        push word ptr [bp + 8]
3485  8A 46 06        mov al, byte ptr [bp + 6]
3488  50              push ax
3489  0E              push cs
348A  E8 6D FA        call 0x2efa
348D  EB 1E           jmp 0x34ad
loc_348F:
348F  80 3E 90 0D 02  cmp byte ptr [0xd90], 2
3494  75 09           jne 0x349f
3496  FF 76 08        push word ptr [bp + 8]
3499  0E              push cs
349A  E8 A9 EA        call 0x1f46
349D  EB 0E           jmp 0x34ad
loc_349F:
349F  80 3E 90 0D 03  cmp byte ptr [0xd90], 3
34A4  75 07           jne 0x34ad
34A6  FF 76 08        push word ptr [bp + 8]
34A9  0E              push cs
34AA  E8 76 FE        call 0x3323
loc_34AD:
34AD  C9              leave
34AE  CA 04 00        retf 4

; ---- routine 1B55:34B1  (found by: call, far)
sub_34B1:
34B1  C8 04 00 00     enter 4, 0
34B5  8B 7E 0A        mov di, word ptr [bp + 0xa]
34B8  80 BD B9 DC 00  cmp byte ptr [di - 0x2347], 0
34BD  74 52           je 0x3511
34BF  8B 46 08        mov ax, word ptr [bp + 8]
34C2  8B F0           mov si, ax
34C4  D1 E0           shl ax, 1
34C6  01 F0           add ax, si
34C8  8B D0           mov dx, ax
34CA  8B 7E 0A        mov di, word ptr [bp + 0xa]
34CD  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
34D1  30 E4           xor ah, ah
34D3  69 C0 AE 00     imul ax, ax, 0xae
34D7  C4 3E CA D7     les di, ptr [0xd7ca]
34DB  03 F8           add di, ax
34DD  03 FA           add di, dx
34DF  26 80 BD 50 FF 00 cmp byte ptr es:[di - 0xb0], 0
34E5  74 2A           je 0x3511
34E7  8B 46 08        mov ax, word ptr [bp + 8]
34EA  8B F0           mov si, ax
34EC  D1 E0           shl ax, 1
34EE  01 F0           add ax, si
34F0  8B D0           mov dx, ax
34F2  8B 7E 0A        mov di, word ptr [bp + 0xa]
34F5  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
34F9  30 E4           xor ah, ah
34FB  69 C0 AE 00     imul ax, ax, 0xae
34FF  C4 3E CA D7     les di, ptr [0xd7ca]
3503  03 F8           add di, ax
3505  03 FA           add di, dx
3507  26 8A 85 4F FF  mov al, byte ptr es:[di - 0xb1]
350C  3A 46 06        cmp al, byte ptr [bp + 6]
350F  74 02           je 0x3513
loc_3511:
3511  EB 64           jmp 0x3577
loc_3513:
3513  8B 46 08        mov ax, word ptr [bp + 8]
3516  8B F0           mov si, ax
3518  D1 E0           shl ax, 1
351A  01 F0           add ax, si
351C  8B D0           mov dx, ax
351E  8B 7E 0A        mov di, word ptr [bp + 0xa]
3521  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
3525  30 E4           xor ah, ah
3527  69 C0 AE 00     imul ax, ax, 0xae
352B  C4 3E CA D7     les di, ptr [0xd7ca]
352F  03 F8           add di, ax
3531  03 FA           add di, dx
3533  26 8A 85 4F FF  mov al, byte ptr es:[di - 0xb1]
3538  98              cwde
3539  8B F8           mov di, ax
353B  D1 E7           shl di, 1
353D  8B 85 8A 10     mov ax, word ptr [di + 0x108a]
3541  31 D2           xor dx, dx
3543  89 46 FC        mov word ptr [bp - 4], ax
3546  89 56 FE        mov word ptr [bp - 2], dx
3549  8B 46 FC        mov ax, word ptr [bp - 4]
354C  8B 56 FE        mov dx, word ptr [bp - 2]
354F  B9 E8 03        mov cx, 0x3e8
3552  31 DB           xor bx, bx
3554  9A 2A 0A C9 26  call far 26C9:0A2A
3559  89 46 FC        mov word ptr [bp - 4], ax
355C  89 56 FE        mov word ptr [bp - 2], dx
355F  8B 4E FC        mov cx, word ptr [bp - 4]
3562  8B 5E FE        mov bx, word ptr [bp - 2]
3565  6B 46 0A 5E     imul ax, word ptr [bp + 0xa], 0x5e
3569  C4 3E C4 DC     les di, ptr [0xdcc4]
356D  03 F8           add di, ax
356F  26 01 4D C4     add word ptr es:[di - 0x3c], cx
3573  26 11 5D C6     adc word ptr es:[di - 0x3a], bx
loc_3577:
3577  C9              leave
3578  CA 06 00        retf 6

; ---- routine 1B55:357B  (found by: call, far)
sub_357B:
357B  C8 08 00 00     enter 8, 0
357F  6B 46 06 3E     imul ax, word ptr [bp + 6], 0x3e
3583  C4 3E C2 D7     les di, ptr [0xd7c2]
3587  03 F8           add di, ax
3589  26 8B 45 F2     mov ax, word ptr es:[di - 0xe]
358D  C1 E0 02        shl ax, 2
3590  C4 3E C8 DC     les di, ptr [0xdcc8]
3594  03 F8           add di, ax
3596  26 8A 45 02     mov al, byte ptr es:[di + 2]
359A  30 E4           xor ah, ah
359C  31 D2           xor dx, dx
359E  89 46 F8        mov word ptr [bp - 8], ax
35A1  89 56 FA        mov word ptr [bp - 6], dx
35A4  8B 46 F8        mov ax, word ptr [bp - 8]
35A7  8B 56 FA        mov dx, word ptr [bp - 6]
35AA  B9 02 00        mov cx, 2
35AD  31 DB           xor bx, bx
35AF  9A 2A 0A C9 26  call far 26C9:0A2A
35B4  89 46 F8        mov word ptr [bp - 8], ax
35B7  89 56 FA        mov word ptr [bp - 6], dx
35BA  FF 76 06        push word ptr [bp + 6]
35BD  0E              push cs
35BE  E8 9A F0        call 0x265b
35C1  8B D0           mov dx, ax
35C3  8B 7E 06        mov di, word ptr [bp + 6]
35C6  8A 85 35 D9     mov al, byte ptr [di - 0x26cb]
35CA  30 E4           xor ah, ah
35CC  03 C2           add ax, dx
35CE  99              cdq
35CF  01 46 F8        add word ptr [bp - 8], ax
35D2  11 56 FA        adc word ptr [bp - 6], dx
35D5  8B 46 F8        mov ax, word ptr [bp - 8]
35D8  8B 56 FA        mov dx, word ptr [bp - 6]
35DB  B9 20 03        mov cx, 0x320
35DE  31 DB           xor bx, bx
35E0  9A 2A 0A C9 26  call far 26C9:0A2A
35E5  89 46 FC        mov word ptr [bp - 4], ax
35E8  89 56 FE        mov word ptr [bp - 2], dx
35EB  8B 46 FC        mov ax, word ptr [bp - 4]
35EE  8B 56 FE        mov dx, word ptr [bp - 2]
35F1  C9              leave
35F2  CA 02 00        retf 2

