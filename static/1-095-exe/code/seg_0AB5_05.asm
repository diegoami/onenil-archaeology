; 1-095.EXE (One-Nil 95), code segment 0AB5 (image offsets 0AB50..1993F), part 5 of 22
; packed 1-095.EXE sha256 f659fb2d334500d6901fc8d6a0f06c85c0ccda2eb4a3035ae3bb0a0004d79192 (LZEXE 0.91)
; unpacked (tools/static/unlzexe.py) sha256 8df646e017e0965a5d90a58181ca764219ad847833aad0b6cb58fc53372bfb2c
; tool: capstone 5.0.9 (pip package; core library 5.0.1280) (CS_ARCH_X86, CS_MODE_16), recursive descent from the entry point, far calls and near calls/jumps, then routine prologues (55 89 E5 / 55 8B EC / C8 iw 00) in what remains; tools/static/listing.py
; addresses are SEGMENT:OFFSET with SEGMENT the image paragraph before relocation; image offset = SEGMENT*16+OFFSET
; ---- routine 0AB5:293A  (found by: call)
sub_293A:
293A  C8 04 00 00     enter 4, 0
293E  80 3E A1 D0 00  cmp byte ptr [0xd0a1], 0
2943  76 06           jbe 0x294b
2945  E8 78 44        call 0x6dc0
2948  E9 77 02        jmp 0x2bc2
loc_294B:
294B  6B 7E 0A 19     imul di, word ptr [bp + 0xa], 0x19
294F  8B 85 EF CC     mov ax, word ptr [di - 0x3311]
2953  89 46 FE        mov word ptr [bp - 2], ax
2956  FF 76 FE        push word ptr [bp - 2]
2959  6B 7E 0A 19     imul di, word ptr [bp + 0xa], 0x19
295D  81 C7 EF CC     add di, 0xccef
2961  1E              push ds
2962  57              push di
2963  0E              push cs
2964  E8 8E F7        call 0x20f5
2967  08 C0           or al, al
2969  74 03           je 0x296e
296B  E9 54 02        jmp 0x2bc2
loc_296E:
296E  C4 7E 06        les di, ptr [bp + 6]
2971  26 8A 45 07     mov al, byte ptr es:[di + 7]
2975  30 E4           xor ah, ah
2977  3B 46 0A        cmp ax, word ptr [bp + 0xa]
297A  75 22           jne 0x299e
297C  E8 21 F0        call 0x19a0
297F  40              inc ax
2980  50              push ax
2981  C4 7E 06        les di, ptr [bp + 6]
2984  06              push es
2985  57              push di
2986  0E              push cs
2987  E8 42 F5        call 0x1ecc
298A  98              cwde
298B  5A              pop dx
298C  F7 E2           mul dx
298E  99              cdq
298F  B9 02 00        mov cx, 2
2992  F7 F9           idiv cx
2994  00 46 FF        add byte ptr [bp - 1], al
2997  C6 06 54 CF 00  mov byte ptr [0xcf54], 0
299C  EB 42           jmp 0x29e0
loc_299E:
299E  8A 46 FF        mov al, byte ptr [bp - 1]
29A1  98              cwde
29A2  99              cdq
29A3  31 D0           xor ax, dx
29A5  29 D0           sub ax, dx
29A7  3D 19 00        cmp ax, 0x19
29AA  7D 34           jge 0x29e0
29AC  6B 7E 0A 19     imul di, word ptr [bp + 0xa], 0x19
29B0  8B 85 FD CC     mov ax, word ptr [di - 0x3303]
29B4  C1 E0 03        shl ax, 3
29B7  C4 3E BA D7     les di, ptr [0xd7ba]
29BB  03 F8           add di, ax
29BD  26 8A 45 06     mov al, byte ptr es:[di + 6]
29C1  30 E4           xor ah, ah
29C3  50              push ax
29C4  9A 6D 07 1A 23  call far 231A:076D
29C9  50              push ax
29CA  C4 7E 06        les di, ptr [bp + 6]
29CD  06              push es
29CE  57              push di
29CF  0E              push cs
29D0  E8 F9 F4        call 0x1ecc
29D3  98              cwde
29D4  5A              pop dx
29D5  F7 E2           mul dx
29D7  99              cdq
29D8  B9 04 00        mov cx, 4
29DB  F7 F9           idiv cx
29DD  00 46 FF        add byte ptr [bp - 1], al
loc_29E0:
29E0  6B 7E 0A 19     imul di, word ptr [bp + 0xa], 0x19
29E4  C6 85 02 CD 05  mov byte ptr [di - 0x32fe], 5
29E9  8A 46 0A        mov al, byte ptr [bp + 0xa]
29EC  A2 A0 D0        mov byte ptr [0xd0a0], al
29EF  80 3E C8 D1 00  cmp byte ptr [0xd1c8], 0
29F4  74 10           je 0x2a06
29F6  FF 76 FE        push word ptr [bp - 2]
29F9  6A 0B           push 0xb
29FB  C4 7E 06        les di, ptr [bp + 6]
29FE  06              push es
29FF  57              push di
2A00  0E              push cs
2A01  E8 21 FC        call 0x2625
2A04  EB 0E           jmp 0x2a14
loc_2A06:
2A06  FF 76 FE        push word ptr [bp - 2]
2A09  6A 06           push 6
2A0B  C4 7E 06        les di, ptr [bp + 6]
2A0E  06              push es
2A0F  57              push di
2A10  0E              push cs
2A11  E8 11 FC        call 0x2625
loc_2A14:
2A14  A1 A6 D0        mov ax, word ptr [0xd0a6]
2A17  89 46 FE        mov word ptr [bp - 2], ax
2A1A  C4 7E 06        les di, ptr [bp + 6]
2A1D  26 8A 45 07     mov al, byte ptr es:[di + 7]
2A21  30 E4           xor ah, ah
2A23  3B 46 0A        cmp ax, word ptr [bp + 0xa]
2A26  74 03           je 0x2a2b
2A28  E9 F8 00        jmp 0x2b23
loc_2A2B:
2A2B  83 3E 4F CF 00  cmp word ptr [0xcf4f], 0
2A30  75 03           jne 0x2a35
2A32  E9 EE 00        jmp 0x2b23
loc_2A35:
2A35  6A 03           push 3
2A37  9A 1C 0D AC 24  call far 24AC:0D1C
2A3C  08 C0           or al, al
2A3E  75 03           jne 0x2a43
2A40  E9 E0 00        jmp 0x2b23
loc_2A43:
2A43  83 3E 51 CF 02  cmp word ptr [0xcf51], 2
2A48  76 0D           jbe 0x2a57
2A4A  A1 51 CF        mov ax, word ptr [0xcf51]
2A4D  31 D2           xor dx, dx
2A4F  B9 03 00        mov cx, 3
2A52  F7 F1           div cx
2A54  A3 51 CF        mov word ptr [0xcf51], ax
loc_2A57:
2A57  A1 46 CF        mov ax, word ptr [0xcf46]
2A5A  89 46 FE        mov word ptr [bp - 2], ax
2A5D  9A 3F 0D AC 24  call far 24AC:0D3F
2A62  98              cwde
2A63  8B F8           mov di, ax
2A65  8A 85 38 A3     mov al, byte ptr [di - 0x5cc8]
2A69  98              cwde
2A6A  A3 4D CF        mov word ptr [0xcf4d], ax
2A6D  83 3E 4F CF 00  cmp word ptr [0xcf4f], 0
2A72  B0 00           mov al, 0
2A74  7E 01           jle 0x2a77
2A76  40              inc ax
loc_2A77:
2A77  98              cwde
2A78  8B F8           mov di, ax
2A7A  8A 85 38 A3     mov al, byte ptr [di - 0x5cc8]
2A7E  98              cwde
2A7F  01 06 4F CF     add word ptr [0xcf4f], ax
2A83  A1 51 CF        mov ax, word ptr [0xcf51]
2A86  31 D2           xor dx, dx
2A88  8B C8           mov cx, ax
2A8A  8B DA           mov bx, dx
2A8C  A1 4F CF        mov ax, word ptr [0xcf4f]
2A8F  99              cdq
2A90  9A 2A 0A B9 26  call far 26B9:0A2A
2A95  00 46 FF        add byte ptr [bp - 1], al
2A98  A1 51 CF        mov ax, word ptr [0xcf51]
2A9B  31 D2           xor dx, dx
2A9D  8B C8           mov cx, ax
2A9F  8B DA           mov bx, dx
2AA1  A1 4D CF        mov ax, word ptr [0xcf4d]
2AA4  99              cdq
2AA5  9A 2A 0A B9 26  call far 26B9:0A2A
2AAA  00 46 FE        add byte ptr [bp - 2], al
2AAD  FF 76 FE        push word ptr [bp - 2]
2AB0  9A 4B 08 94 19  call far 1994:084B
2AB5  08 C0           or al, al
2AB7  75 3A           jne 0x2af3
2AB9  6A 0E           push 0xe
2ABB  C4 7E 06        les di, ptr [bp + 6]
2ABE  06              push es
2ABF  57              push di
2AC0  0E              push cs
2AC1  E8 12 F1        call 0x1bd6
2AC4  08 C0           or al, al
2AC6  74 2B           je 0x2af3
2AC8  8A 46 FE        mov al, byte ptr [bp - 2]
2ACB  98              cwde
2ACC  99              cdq
2ACD  31 D0           xor ax, dx
2ACF  29 D0           sub ax, dx
2AD1  3D 08 00        cmp ax, 8
2AD4  7E 07           jle 0x2add
2AD6  31 C0           xor ax, ax
2AD8  A3 4D CF        mov word ptr [0xcf4d], ax
2ADB  EB 16           jmp 0x2af3
loc_2ADD:
2ADD  83 3E 4F CF 00  cmp word ptr [0xcf4f], 0
2AE2  B0 00           mov al, 0
2AE4  7D 01           jge 0x2ae7
2AE6  40              inc ax
loc_2AE7:
2AE7  98              cwde
2AE8  8B F8           mov di, ax
2AEA  8A 85 38 A3     mov al, byte ptr [di - 0x5cc8]
2AEE  98              cwde
2AEF  01 06 4F CF     add word ptr [0xcf4f], ax
loc_2AF3:
2AF3  A1 46 CF        mov ax, word ptr [0xcf46]
2AF6  89 46 FE        mov word ptr [bp - 2], ax
2AF9  A1 51 CF        mov ax, word ptr [0xcf51]
2AFC  31 D2           xor dx, dx
2AFE  8B C8           mov cx, ax
2B00  8B DA           mov bx, dx
2B02  A1 4F CF        mov ax, word ptr [0xcf4f]
2B05  99              cdq
2B06  9A 2A 0A B9 26  call far 26B9:0A2A
2B0B  00 46 FF        add byte ptr [bp - 1], al
2B0E  A1 51 CF        mov ax, word ptr [0xcf51]
2B11  31 D2           xor dx, dx
2B13  8B C8           mov cx, ax
2B15  8B DA           mov bx, dx
2B17  A1 4D CF        mov ax, word ptr [0xcf4d]
2B1A  99              cdq
2B1B  9A 2A 0A B9 26  call far 26B9:0A2A
2B20  00 46 FE        add byte ptr [bp - 2], al
loc_2B23:
2B23  BF 46 CF        mov di, 0xcf46
2B26  1E              push ds
2B27  57              push di
2B28  9A 3F 0B 94 19  call far 1994:0B3F
2B2D  3D 14 00        cmp ax, 0x14
2B30  77 25           ja 0x2b57
2B32  A0 A0 D0        mov al, byte ptr [0xd0a0]
2B35  3A 06 9F D0     cmp al, byte ptr [0xd09f]
2B39  74 18           je 0x2b53
2B3B  BF 46 CF        mov di, 0xcf46
2B3E  1E              push ds
2B3F  57              push di
2B40  9A 3F 0B 94 19  call far 1994:0B3F
2B45  3D 0A 00        cmp ax, 0xa
2B48  76 09           jbe 0x2b53
2B4A  9A 3F 0D AC 24  call far 24AC:0D3F
2B4F  08 C0           or al, al
2B51  75 04           jne 0x2b57
loc_2B53:
2B53  B0 00           mov al, 0
2B55  EB 02           jmp 0x2b59
loc_2B57:
2B57  B0 01           mov al, 1
loc_2B59:
2B59  A2 54 CF        mov byte ptr [0xcf54], al
2B5C  80 3E A0 D0 00  cmp byte ptr [0xd0a0], 0
2B61  75 12           jne 0x2b75
2B63  9A 3F 0D AC 24  call far 24AC:0D3F
2B68  98              cwde
2B69  8B F8           mov di, ax
2B6B  8A 85 22 0A     mov al, byte ptr [di + 0xa22]
2B6F  50              push ax
2B70  E8 44 F2        call 0x1db7
2B73  EB 4D           jmp 0x2bc2
loc_2B75:
2B75  A0 A0 D0        mov al, byte ptr [0xd0a0]
2B78  3A 06 9F D0     cmp al, byte ptr [0xd09f]
2B7C  75 15           jne 0x2b93
2B7E  FF 76 FE        push word ptr [bp - 2]
2B81  9A 4B 08 94 19  call far 1994:084B
2B86  98              cwde
2B87  8B F8           mov di, ax
2B89  8A 85 24 0A     mov al, byte ptr [di + 0xa24]
2B8D  50              push ax
2B8E  E8 26 F2        call 0x1db7
2B91  EB 2F           jmp 0x2bc2
loc_2B93:
2B93  80 3E BB D0 08  cmp byte ptr [0xd0bb], 8
2B98  75 07           jne 0x2ba1
2B9A  6A 03           push 3
2B9C  E8 18 F2        call 0x1db7
2B9F  EB 21           jmp 0x2bc2
loc_2BA1:
2BA1  80 3E 54 CF 00  cmp byte ptr [0xcf54], 0
2BA6  74 07           je 0x2baf
2BA8  6A 0A           push 0xa
2BAA  E8 0A F2        call 0x1db7
2BAD  EB 13           jmp 0x2bc2
loc_2BAF:
2BAF  80 3E BB D0 07  cmp byte ptr [0xd0bb], 7
2BB4  75 07           jne 0x2bbd
2BB6  6A 09           push 9
2BB8  E8 FC F1        call 0x1db7
2BBB  EB 05           jmp 0x2bc2
loc_2BBD:
2BBD  6A 08           push 8
2BBF  E8 F5 F1        call 0x1db7
loc_2BC2:
2BC2  C9              leave
2BC3  CA 06 00        retf 6

; ---- routine 0AB5:2BC6  (found by: call)
sub_2BC6:
2BC6  C8 02 00 00     enter 2, 0
2BCA  A1 46 CF        mov ax, word ptr [0xcf46]
2BCD  89 46 FE        mov word ptr [bp - 2], ax
2BD0  6A 00           push 0
2BD2  6A 1E           push 0x1e
2BD4  6A 04           push 4
2BD6  C4 7E 06        les di, ptr [bp + 6]
2BD9  06              push es
2BDA  57              push di
2BDB  0E              push cs
2BDC  E8 03 EF        call 0x1ae2
2BDF  C1 E8 02        shr ax, 2
2BE2  50              push ax
2BE3  9A 6D 07 1A 23  call far 231A:076D
2BE8  99              cdq
2BE9  52              push dx
2BEA  50              push ax
2BEB  9A C0 04 AC 24  call far 24AC:04C0
2BF0  52              push dx
2BF1  50              push ax
2BF2  C4 7E 06        les di, ptr [bp + 6]
2BF5  06              push es
2BF6  57              push di
2BF7  0E              push cs
2BF8  E8 D1 F2        call 0x1ecc
2BFB  98              cwde
2BFC  99              cdq
2BFD  59              pop cx
2BFE  5B              pop bx
2BFF  9A 2A 0A B9 26  call far 26B9:0A2A
2C04  00 46 FF        add byte ptr [bp - 1], al
2C07  C6 06 A0 D0 FF  mov byte ptr [0xd0a0], 0xff
2C0C  FF 76 FE        push word ptr [bp - 2]
2C0F  6A 0A           push 0xa
2C11  C4 7E 06        les di, ptr [bp + 6]
2C14  06              push es
2C15  57              push di
2C16  0E              push cs
2C17  E8 0B FA        call 0x2625
2C1A  C6 06 54 CF 01  mov byte ptr [0xcf54], 1
2C1F  80 3E A0 D0 00  cmp byte ptr [0xd0a0], 0
2C24  B0 00           mov al, 0
2C26  75 01           jne 0x2c29
2C28  40              inc ax
loc_2C29:
2C29  98              cwde
2C2A  8B F8           mov di, ax
2C2C  8A 85 26 0A     mov al, byte ptr [di + 0xa26]
2C30  50              push ax
2C31  E8 83 F1        call 0x1db7
2C34  C6 06 A0 D0 00  mov byte ptr [0xd0a0], 0
2C39  C9              leave
2C3A  CA 04 00        retf 4

; ---- routine 0AB5:2C3D  (found by: call)
sub_2C3D:
2C3D  55              push bp
2C3E  89 E5           mov bp, sp
2C40  8A 46 0A        mov al, byte ptr [bp + 0xa]
2C43  A2 A0 D0        mov byte ptr [0xd0a0], al
2C46  6B 7E 0A 19     imul di, word ptr [bp + 0xa], 0x19
2C4A  FF B5 EF CC     push word ptr [di - 0x3311]
2C4E  C4 7E 06        les di, ptr [bp + 6]
2C51  06              push es
2C52  57              push di
2C53  0E              push cs
2C54  E8 DC F2        call 0x1f33
2C57  98              cwde
2C58  8B F8           mov di, ax
2C5A  8A 85 28 0A     mov al, byte ptr [di + 0xa28]
2C5E  30 E4           xor ah, ah
2C60  50              push ax
2C61  C4 7E 06        les di, ptr [bp + 6]
2C64  06              push es
2C65  57              push di
2C66  0E              push cs
2C67  E8 BB F9        call 0x2625
2C6A  6A 03           push 3
2C6C  E8 48 F1        call 0x1db7
2C6F  9A 3F 0D AC 24  call far 24AC:0D3F
2C74  A2 54 CF        mov byte ptr [0xcf54], al
2C77  C4 7E 06        les di, ptr [bp + 6]
2C7A  06              push es
2C7B  57              push di
2C7C  0E              push cs
2C7D  E8 A1 0E        call 0x3b21
2C80  C9              leave
2C81  CA 06 00        retf 6

; ---- routine 0AB5:2C84  (found by: call)
sub_2C84:
2C84  55              push bp
2C85  89 E5           mov bp, sp
2C87  80 3E A1 D0 00  cmp byte ptr [0xd0a1], 0
2C8C  76 05           jbe 0x2c93
2C8E  E8 2F 41        call 0x6dc0
2C91  EB 1D           jmp 0x2cb0
loc_2C93:
2C93  9A 3F 0D AC 24  call far 24AC:0D3F
2C98  08 C0           or al, al
2C9A  74 0B           je 0x2ca7
2C9C  C4 7E 06        les di, ptr [bp + 6]
2C9F  06              push es
2CA0  57              push di
2CA1  0E              push cs
2CA2  E8 21 FF        call 0x2bc6
2CA5  EB 09           jmp 0x2cb0
loc_2CA7:
2CA7  C4 7E 06        les di, ptr [bp + 6]
2CAA  06              push es
2CAB  57              push di
2CAC  0E              push cs
2CAD  E8 3B F8        call 0x24eb
loc_2CB0:
2CB0  C9              leave
2CB1  CA 04 00        retf 4

; ---- routine 0AB5:2CB4  (found by: call)
sub_2CB4:
2CB4  55              push bp
2CB5  89 E5           mov bp, sp
2CB7  80 3E B9 D0 00  cmp byte ptr [0xd0b9], 0
2CBC  75 0B           jne 0x2cc9
2CBE  8A 46 04        mov al, byte ptr [bp + 4]
2CC1  98              cwde
2CC2  6B F8 0A        imul di, ax, 0xa
2CC5  FE 85 D6 D0     inc byte ptr [di - 0x2f2a]
loc_2CC9:
2CC9  C9              leave
2CCA  C2 02 00        ret 2

; ---- routine 0AB5:2CCD  (found by: call)
sub_2CCD:
2CCD  55              push bp
2CCE  89 E5           mov bp, sp
2CD0  A0 A1 D0        mov al, byte ptr [0xd0a1]
2CD3  C4 7E 06        les di, ptr [bp + 6]
2CD6  26 3A 45 07     cmp al, byte ptr es:[di + 7]
2CDA  75 0F           jne 0x2ceb
2CDC  9A 3F 0D AC 24  call far 24AC:0D3F
2CE1  08 C0           or al, al
2CE3  74 06           je 0x2ceb
2CE5  E8 D8 40        call 0x6dc0
2CE8  E9 C5 00        jmp 0x2db0
loc_2CEB:
2CEB  C6 06 A0 D0 00  mov byte ptr [0xd0a0], 0
2CF0  83 7E 0A 02     cmp word ptr [bp + 0xa], 2
2CF4  74 16           je 0x2d0c
2CF6  9A 3F 0D AC 24  call far 24AC:0D3F
2CFB  30 E4           xor ah, ah
2CFD  50              push ax
2CFE  9A 3F 0D AC 24  call far 24AC:0D3F
2D03  30 E4           xor ah, ah
2D05  5A              pop dx
2D06  2B C2           sub ax, dx
2D08  00 06 46 CF     add byte ptr [0xcf46], al
loc_2D0C:
2D0C  80 3E B7 D0 00  cmp byte ptr [0xd0b7], 0
2D11  75 32           jne 0x2d45
2D13  83 7E 0A 02     cmp word ptr [bp + 0xa], 2
2D17  B0 00           mov al, 0
2D19  75 01           jne 0x2d1c
2D1B  40              inc ax
loc_2D1C:
2D1C  98              cwde
2D1D  8B F8           mov di, ax
2D1F  8A 85 2A 0A     mov al, byte ptr [di + 0xa2a]
2D23  30 E4           xor ah, ah
2D25  50              push ax
2D26  C4 7E 06        les di, ptr [bp + 6]
2D29  06              push es
2D2A  57              push di
2D2B  0E              push cs
2D2C  E8 A7 EE        call 0x1bd6
2D2F  08 C0           or al, al
2D31  75 16           jne 0x2d49
2D33  6A 04           push 4
2D35  9A 1C 0D AC 24  call far 24AC:0D1C
2D3A  08 C0           or al, al
2D3C  75 0B           jne 0x2d49
2D3E  E8 AB EF        call 0x1cec
2D41  08 C0           or al, al
2D43  75 04           jne 0x2d49
loc_2D45:
2D45  B0 00           mov al, 0
2D47  EB 02           jmp 0x2d4b
loc_2D49:
2D49  B0 01           mov al, 1
loc_2D4B:
2D4B  A2 C9 D1        mov byte ptr [0xd1c9], al
2D4E  FF 36 34 0D     push word ptr [0xd34]
2D52  C4 7E 06        les di, ptr [bp + 6]
2D55  06              push es
2D56  57              push di
2D57  0E              push cs
2D58  E8 03 F2        call 0x1f5e
2D5B  50              push ax
2D5C  FF 76 0A        push word ptr [bp + 0xa]
2D5F  C4 7E 06        les di, ptr [bp + 6]
2D62  06              push es
2D63  57              push di
2D64  0E              push cs
2D65  E8 BD F8        call 0x2625
2D68  8A 46 0C        mov al, byte ptr [bp + 0xc]
2D6B  50              push ax
2D6C  E8 48 F0        call 0x1db7
2D6F  80 3E B9 D0 00  cmp byte ptr [0xd0b9], 0
2D74  75 11           jne 0x2d87
2D76  C4 7E 06        les di, ptr [bp + 6]
2D79  06              push es
2D7A  57              push di
2D7B  0E              push cs
2D7C  E8 3C EF        call 0x1cbb
2D7F  98              cwde
2D80  6B F8 0A        imul di, ax, 0xa
2D83  FE 85 D5 D0     inc byte ptr [di - 0x2f2b]
loc_2D87:
2D87  83 7E 0A 02     cmp word ptr [bp + 0xa], 2
2D8B  74 1E           je 0x2dab
2D8D  9A 3F 0D AC 24  call far 24AC:0D3F
2D92  08 C0           or al, al
2D94  74 06           je 0x2d9c
2D96  83 7E 0A 04     cmp word ptr [bp + 0xa], 4
2D9A  74 0F           je 0x2dab
loc_2D9C:
2D9C  6A 03           push 3
2D9E  9A 1C 0D AC 24  call far 24AC:0D1C
2DA3  08 C0           or al, al
2DA5  75 04           jne 0x2dab
2DA7  B0 00           mov al, 0
2DA9  EB 02           jmp 0x2dad
loc_2DAB:
2DAB  B0 01           mov al, 1
loc_2DAD:
2DAD  A2 54 CF        mov byte ptr [0xcf54], al
loc_2DB0:
2DB0  C9              leave
2DB1  CA 08 00        retf 8

; ---- routine 0AB5:2DB4  (found by: call)
sub_2DB4:
2DB4  C8 08 00 00     enter 8, 0
2DB8  E8 1B EF        call 0x1cd6
2DBB  98              cwde
2DBC  8B F8           mov di, ax
2DBE  8A 85 56 0D     mov al, byte ptr [di + 0xd56]
2DC2  30 E4           xor ah, ah
2DC4  05 0B 00        add ax, 0xb
2DC7  89 46 FC        mov word ptr [bp - 4], ax
2DCA  E8 09 EF        call 0x1cd6
2DCD  98              cwde
2DCE  8B F8           mov di, ax
2DD0  8A 85 56 0D     mov al, byte ptr [di + 0xd56]
2DD4  30 E4           xor ah, ah
2DD6  40              inc ax
2DD7  40              inc ax
2DD8  3B 46 FC        cmp ax, word ptr [bp - 4]
2DDB  77 72           ja 0x2e4f
2DDD  89 46 FE        mov word ptr [bp - 2], ax
2DE0  EB 03           jmp 0x2de5
loc_2DE2:
2DE2  FF 46 FE        inc word ptr [bp - 2]
loc_2DE5:
2DE5  6B 7E FE 19     imul di, word ptr [bp - 2], 0x19
2DE9  81 C7 EF CC     add di, 0xccef
2DED  1E              push ds
2DEE  07              pop es
2DEF  89 7E F8        mov word ptr [bp - 8], di
2DF2  8C 46 FA        mov word ptr [bp - 6], es
2DF5  26 8A 45 07     mov al, byte ptr es:[di + 7]
2DF9  30 E4           xor ah, ah
2DFB  3B 46 04        cmp ax, word ptr [bp + 4]
2DFE  74 47           je 0x2e47
2E00  26 FF 75 0E     push word ptr es:[di + 0xe]
2E04  9A E9 4E 51 1B  call far 1B51:4EE9
2E09  08 C0           or al, al
2E0B  75 3A           jne 0x2e47
2E0D  C4 7E F8        les di, ptr [bp - 8]
2E10  26 FF 35        push word ptr es:[di]
2E13  06              push es
2E14  57              push di
2E15  0E              push cs
2E16  E8 10 F3        call 0x2129
2E19  08 C0           or al, al
2E1B  74 2A           je 0x2e47
2E1D  C4 7E F8        les di, ptr [bp - 8]
2E20  26 8B 05        mov ax, word ptr es:[di]
2E23  C4 7E 06        les di, ptr [bp + 6]
2E26  26 89 05        mov word ptr es:[di], ax
2E29  C4 7E F8        les di, ptr [bp - 8]
2E2C  26 8B 45 0E     mov ax, word ptr es:[di + 0xe]
2E30  C1 E0 03        shl ax, 3
2E33  C4 3E BA D7     les di, ptr [0xd7ba]
2E37  03 F8           add di, ax
2E39  26 8A 45 06     mov al, byte ptr es:[di + 6]
2E3D  3C 02           cmp al, 2
2E3F  74 04           je 0x2e45
2E41  3C 0C           cmp al, 0xc
2E43  75 02           jne 0x2e47
loc_2E45:
2E45  EB 08           jmp 0x2e4f
loc_2E47:
2E47  8B 46 FE        mov ax, word ptr [bp - 2]
2E4A  3B 46 FC        cmp ax, word ptr [bp - 4]
2E4D  75 93           jne 0x2de2
loc_2E4F:
2E4F  C9              leave
2E50  C2 06 00        ret 6

; ---- routine 0AB5:2E53  (found by: call)
sub_2E53:
2E53  C8 02 00 00     enter 2, 0
2E57  31 C0           xor ax, ax
2E59  89 46 FE        mov word ptr [bp - 2], ax
2E5C  8D 7E FE        lea di, [bp - 2]
2E5F  16              push ss
2E60  57              push di
2E61  C4 7E 06        les di, ptr [bp + 6]
2E64  26 8A 45 07     mov al, byte ptr es:[di + 7]
2E68  30 E4           xor ah, ah
2E6A  50              push ax
2E6B  E8 46 FF        call 0x2db4
2E6E  83 7E FE 00     cmp word ptr [bp - 2], 0
2E72  75 02           jne 0x2e76
2E74  EB 5A           jmp 0x2ed0
loc_2E76:
2E76  C4 7E 06        les di, ptr [bp + 6]
2E79  26 80 3D 00     cmp byte ptr es:[di], 0
2E7D  7D 06           jge 0x2e85
2E7F  80 46 FE 05     add byte ptr [bp - 2], 5
2E83  EB 04           jmp 0x2e89
loc_2E85:
2E85  80 6E FE 05     sub byte ptr [bp - 2], 5
loc_2E89:
2E89  C6 06 A0 D0 FF  mov byte ptr [0xd0a0], 0xff
2E8E  FF 76 FE        push word ptr [bp - 2]
2E91  6A 05           push 5
2E93  C4 7E 06        les di, ptr [bp + 6]
2E96  06              push es
2E97  57              push di
2E98  0E              push cs
2E99  E8 89 F7        call 0x2625
2E9C  80 3E A0 D0 00  cmp byte ptr [0xd0a0], 0
2EA1  B0 00           mov al, 0
2EA3  75 01           jne 0x2ea6
2EA5  40              inc ax
loc_2EA6:
2EA6  98              cwde
2EA7  8B F8           mov di, ax
2EA9  8A 85 30 0A     mov al, byte ptr [di + 0xa30]
2EAD  50              push ax
2EAE  E8 06 EF        call 0x1db7
2EB1  C6 06 A0 D0 00  mov byte ptr [0xd0a0], 0
2EB6  6A 08           push 8
2EB8  9A 1C 0D AC 24  call far 24AC:0D1C
2EBD  08 C0           or al, al
2EBF  B0 00           mov al, 0
2EC1  75 01           jne 0x2ec4
2EC3  40              inc ax
loc_2EC4:
2EC4  A2 54 CF        mov byte ptr [0xcf54], al
2EC7  C4 7E 06        les di, ptr [bp + 6]
2ECA  06              push es
2ECB  57              push di
2ECC  0E              push cs
2ECD  E8 51 0C        call 0x3b21
loc_2ED0:
2ED0  C9              leave
2ED1  CA 04 00        retf 4

; ---- routine 0AB5:2ED4  (found by: call)
sub_2ED4:
2ED4  55              push bp
2ED5  89 E5           mov bp, sp
2ED7  8A 46 0A        mov al, byte ptr [bp + 0xa]
2EDA  50              push ax
2EDB  6A 01           push 1
2EDD  C4 7E 06        les di, ptr [bp + 6]
2EE0  06              push es
2EE1  57              push di
2EE2  0E              push cs
2EE3  E8 E7 FD        call 0x2ccd
2EE6  C9              leave
2EE7  CA 06 00        retf 6

; ---- routine 0AB5:2EEA  (found by: call)
sub_2EEA:
2EEA  55              push bp
2EEB  89 E5           mov bp, sp
2EED  6A 14           push 0x14
2EEF  6A 02           push 2
2EF1  C4 7E 06        les di, ptr [bp + 6]
2EF4  06              push es
2EF5  57              push di
2EF6  0E              push cs
2EF7  E8 D3 FD        call 0x2ccd
2EFA  C9              leave
2EFB  CA 04 00        retf 4

; ---- routine 0AB5:2EFE  (found by: call)
sub_2EFE:
2EFE  C8 04 00 00     enter 4, 0
2F02  C6 06 A0 D0 00  mov byte ptr [0xd0a0], 0
2F07  A1 46 CF        mov ax, word ptr [0xcf46]
2F0A  89 46 FE        mov word ptr [bp - 2], ax
2F0D  83 7E 0A 09     cmp word ptr [bp + 0xa], 9
2F11  B0 00           mov al, 0
2F13  75 01           jne 0x2f16
2F15  40              inc ax
loc_2F16:
2F16  88 46 FD        mov byte ptr [bp - 3], al
2F19  8A 46 FD        mov al, byte ptr [bp - 3]
2F1C  98              cwde
2F1D  8B F8           mov di, ax
2F1F  8A 85 38 0A     mov al, byte ptr [di + 0xa38]
2F23  30 E4           xor ah, ah
2F25  31 D2           xor dx, dx
2F27  52              push dx
2F28  50              push ax
2F29  8A 46 FD        mov al, byte ptr [bp - 3]
2F2C  98              cwde
2F2D  8B F8           mov di, ax
2F2F  8A 85 34 0A     mov al, byte ptr [di + 0xa34]
2F33  30 E4           xor ah, ah
2F35  50              push ax
2F36  8A 46 FD        mov al, byte ptr [bp - 3]
2F39  98              cwde
2F3A  8B F8           mov di, ax
2F3C  8A 85 32 0A     mov al, byte ptr [di + 0xa32]
2F40  30 E4           xor ah, ah
2F42  50              push ax
2F43  C4 7E 06        les di, ptr [bp + 6]
2F46  06              push es
2F47  57              push di
2F48  0E              push cs
2F49  E8 96 EB        call 0x1ae2
2F4C  59              pop cx
2F4D  31 D2           xor dx, dx
2F4F  F7 F1           div cx
2F51  50              push ax
2F52  9A 6D 07 1A 23  call far 231A:076D
2F57  99              cdq
2F58  52              push dx
2F59  50              push ax
2F5A  9A C0 04 AC 24  call far 24AC:04C0
2F5F  52              push dx
2F60  50              push ax
2F61  C4 7E 06        les di, ptr [bp + 6]
2F64  06              push es
2F65  57              push di
2F66  0E              push cs
2F67  E8 62 EF        call 0x1ecc
2F6A  98              cwde
2F6B  99              cdq
2F6C  59              pop cx
2F6D  5B              pop bx
2F6E  9A 2A 0A B9 26  call far 26B9:0A2A
2F73  00 46 FF        add byte ptr [bp - 1], al
2F76  FF 76 FE        push word ptr [bp - 2]
2F79  8A 46 FD        mov al, byte ptr [bp - 3]
2F7C  98              cwde
2F7D  8B F8           mov di, ax
2F7F  8A 85 36 0A     mov al, byte ptr [di + 0xa36]
2F83  30 E4           xor ah, ah
2F85  50              push ax
2F86  C4 7E 06        les di, ptr [bp + 6]
2F89  06              push es
2F8A  57              push di
2F8B  0E              push cs
2F8C  E8 96 F6        call 0x2625
2F8F  C6 06 54 CF 01  mov byte ptr [0xcf54], 1
2F94  80 7E FD 00     cmp byte ptr [bp - 3], 0
2F98  74 07           je 0x2fa1
2F9A  6A 17           push 0x17
2F9C  E8 18 EE        call 0x1db7
2F9F  EB 05           jmp 0x2fa6
loc_2FA1:
2FA1  6A 18           push 0x18
2FA3  E8 11 EE        call 0x1db7
loc_2FA6:
2FA6  C9              leave
2FA7  CA 06 00        retf 6

; ---- routine 0AB5:2FAA  (found by: call)
sub_2FAA:
2FAA  C8 02 00 00     enter 2, 0
2FAE  9A 3F 0D AC 24  call far 24AC:0D3F
2FB3  08 C0           or al, al
2FB5  75 11           jne 0x2fc8
2FB7  C4 7E 06        les di, ptr [bp + 6]
2FBA  26 8A 45 07     mov al, byte ptr es:[di + 7]
2FBE  30 E4           xor ah, ah
2FC0  50              push ax
2FC1  E8 3C D0        call 0
2FC4  08 C0           or al, al
2FC6  74 3F           je 0x3007
loc_2FC8:
2FC8  C4 7E 06        les di, ptr [bp + 6]
2FCB  26 80 3D 00     cmp byte ptr es:[di], 0
2FCF  B0 00           mov al, 0
2FD1  7E 01           jle 0x2fd4
2FD3  40              inc ax
loc_2FD4:
2FD4  98              cwde
2FD5  8B F8           mov di, ax
2FD7  8A 85 38 A3     mov al, byte ptr [di - 0x5cc8]
2FDB  98              cwde
2FDC  6B C0 0C        imul ax, ax, 0xc
2FDF  88 46 FE        mov byte ptr [bp - 2], al
2FE2  6A 28           push 0x28
2FE4  9A 6D 07 1A 23  call far 231A:076D
2FE9  8B D0           mov dx, ax
2FEB  C4 7E 06        les di, ptr [bp + 6]
2FEE  26 80 7D 01 00  cmp byte ptr es:[di + 1], 0
2FF3  B0 00           mov al, 0
2FF5  7E 01           jle 0x2ff8
2FF7  40              inc ax
loc_2FF8:
2FF8  98              cwde
2FF9  8B F8           mov di, ax
2FFB  8A 85 38 A3     mov al, byte ptr [di - 0x5cc8]
2FFF  98              cwde
3000  F7 E2           mul dx
3002  88 46 FF        mov byte ptr [bp - 1], al
3005  EB 3F           jmp 0x3046
loc_3007:
3007  6A 08           push 8
3009  9A 6D 07 1A 23  call far 231A:076D
300E  40              inc ax
300F  40              inc ax
3010  8B D0           mov dx, ax
3012  C4 7E 06        les di, ptr [bp + 6]
3015  26 80 3D 00     cmp byte ptr es:[di], 0
3019  B0 00           mov al, 0
301B  7E 01           jle 0x301e
301D  40              inc ax
loc_301E:
301E  98              cwde
301F  8B F8           mov di, ax
3021  8A 85 38 A3     mov al, byte ptr [di - 0x5cc8]
3025  98              cwde
3026  F7 E2           mul dx
3028  88 46 FE        mov byte ptr [bp - 2], al
302B  C4 7E 06        les di, ptr [bp + 6]
302E  26 80 7D 01 00  cmp byte ptr es:[di + 1], 0
3033  B0 00           mov al, 0
3035  7E 01           jle 0x3038
3037  40              inc ax
loc_3038:
3038  98              cwde
3039  8B F8           mov di, ax
303B  8A 85 38 A3     mov al, byte ptr [di - 0x5cc8]
303F  98              cwde
3040  6B C0 32        imul ax, ax, 0x32
3043  88 46 FF        mov byte ptr [bp - 1], al
loc_3046:
3046  FF 76 FE        push word ptr [bp - 2]
3049  FF 76 0A        push word ptr [bp + 0xa]
304C  C4 7E 06        les di, ptr [bp + 6]
304F  06              push es
3050  57              push di
3051  0E              push cs
3052  E8 D0 F5        call 0x2625
3055  C6 06 54 CF 01  mov byte ptr [0xcf54], 1
305A  83 7E 0A 0B     cmp word ptr [bp + 0xa], 0xb
305E  75 07           jne 0x3067
3060  6A 16           push 0x16
3062  E8 52 ED        call 0x1db7
3065  EB 05           jmp 0x306c
loc_3067:
3067  6A 15           push 0x15
3069  E8 4B ED        call 0x1db7
loc_306C:
306C  C9              leave
306D  CA 06 00        retf 6

; ---- routine 0AB5:3070  (found by: call)
sub_3070:
3070  55              push bp
3071  89 E5           mov bp, sp
3073  9A 3F 0D AC 24  call far 24AC:0D3F
3078  08 C0           or al, al
307A  74 0D           je 0x3089
307C  6A 0B           push 0xb
307E  C4 7E 06        les di, ptr [bp + 6]
3081  06              push es
3082  57              push di
3083  0E              push cs
3084  E8 23 FF        call 0x2faa
3087  EB 0B           jmp 0x3094
loc_3089:
3089  6A 0B           push 0xb
308B  C4 7E 06        les di, ptr [bp + 6]
308E  06              push es
308F  57              push di
3090  0E              push cs
3091  E8 6A FE        call 0x2efe
loc_3094:
3094  C9              leave
3095  CA 04 00        retf 4

; ---- routine 0AB5:3098  (found by: call)
sub_3098:
3098  C8 06 00 00     enter 6, 0
309C  A0 9F D0        mov al, byte ptr [0xd09f]
309F  30 E4           xor ah, ah
30A1  6B F8 19        imul di, ax, 0x19
30A4  81 C7 EF CC     add di, 0xccef
30A8  1E              push ds
30A9  07              pop es
30AA  89 7E FA        mov word ptr [bp - 6], di
30AD  8C 46 FC        mov word ptr [bp - 4], es
30B0  06              push es
30B1  57              push di
30B2  0E              push cs
30B3  E8 7D EE        call 0x1f33
30B6  08 C0           or al, al
30B8  75 3A           jne 0x30f4
30BA  E8 19 EC        call 0x1cd6
30BD  08 C0           or al, al
30BF  B0 00           mov al, 0
30C1  75 01           jne 0x30c4
30C3  40              inc ax
loc_30C4:
30C4  98              cwde
30C5  6B F8 07        imul di, ax, 7
30C8  8A 85 2F CF     mov al, byte ptr [di - 0x30d1]
30CC  98              cwde
30CD  99              cdq
30CE  31 D0           xor ax, dx
30D0  29 D0           sub ax, dx
30D2  8B C8           mov cx, ax
30D4  C4 7E FA        les di, ptr [bp - 6]
30D7  26 8A 45 01     mov al, byte ptr es:[di + 1]
30DB  98              cwde
30DC  99              cdq
30DD  31 D0           xor ax, dx
30DF  29 D0           sub ax, dx
30E1  3B C1           cmp ax, cx
30E3  7E 0F           jle 0x30f4
30E5  26 8A 45 01     mov al, byte ptr es:[di + 1]
30E9  98              cwde
30EA  99              cdq
30EB  31 D0           xor ax, dx
30ED  29 D0           sub ax, dx
30EF  3D 23 00        cmp ax, 0x23
30F2  7C 04           jl 0x30f8
loc_30F4:
30F4  B0 00           mov al, 0
30F6  EB 02           jmp 0x30fa
loc_30F8:
30F8  B0 01           mov al, 1
loc_30FA:
30FA  88 46 FF        mov byte ptr [bp - 1], al
30FD  8A 46 FF        mov al, byte ptr [bp - 1]
3100  C9              leave
3101  C3              ret

; ---- routine 0AB5:3102  (found by: call)
sub_3102:
3102  C8 06 00 00     enter 6, 0
3106  A0 9F D0        mov al, byte ptr [0xd09f]
3109  30 E4           xor ah, ah
310B  6B F8 19        imul di, ax, 0x19
310E  81 C7 EF CC     add di, 0xccef
3112  1E              push ds
3113  07              pop es
3114  89 7E FA        mov word ptr [bp - 6], di
3117  8C 46 FC        mov word ptr [bp - 4], es
311A  C6 46 FF 00     mov byte ptr [bp - 1], 0
311E  26 FF 35        push word ptr es:[di]
3121  06              push es
3122  57              push di
3123  0E              push cs
3124  E8 CE EF        call 0x20f5
3127  08 C0           or al, al
3129  74 11           je 0x313c
312B  6A 09           push 9
312D  C4 7E FA        les di, ptr [bp - 6]
3130  06              push es
3131  57              push di
3132  0E              push cs
3133  E8 74 FE        call 0x2faa
3136  C6 46 FF 01     mov byte ptr [bp - 1], 1
313A  EB 14           jmp 0x3150
loc_313C:
313C  80 3E 54 CF 00  cmp byte ptr [0xcf54], 0
3141  74 0D           je 0x3150
3143  C4 7E FA        les di, ptr [bp - 6]
3146  06              push es
3147  57              push di
3148  0E              push cs
3149  E8 C8 19        call 0x4b14
314C  C6 46 FF 01     mov byte ptr [bp - 1], 1
loc_3150:
3150  8A 46 FF        mov al, byte ptr [bp - 1]
3153  C9              leave
3154  C3              ret

; ---- routine 0AB5:3155  (found by: call)
sub_3155:
3155  C8 0C 00 00     enter 0xc, 0
3159  8A 46 FF        mov al, byte ptr [bp - 1]
315C  98              cwde
315D  8B F8           mov di, ax
315F  8A 85 56 0D     mov al, byte ptr [di + 0xd56]
3163  30 E4           xor ah, ah
3165  40              inc ax
3166  89 46 FA        mov word ptr [bp - 6], ax
3169  C6 46 FF 00     mov byte ptr [bp - 1], 0
316D  EB 03           jmp 0x3172
loc_316F:
316F  FE 46 FF        inc byte ptr [bp - 1]
loc_3172:
3172  8A 46 FF        mov al, byte ptr [bp - 1]
3175  98              cwde
3176  8B F8           mov di, ax
3178  8A 85 56 0D     mov al, byte ptr [di + 0xd56]
317C  30 E4           xor ah, ah
317E  05 0B 00        add ax, 0xb
3181  89 46 F8        mov word ptr [bp - 8], ax
3184  8A 46 FF        mov al, byte ptr [bp - 1]
3187  98              cwde
3188  8B F8           mov di, ax
318A  8A 85 56 0D     mov al, byte ptr [di + 0xd56]
318E  30 E4           xor ah, ah
3190  40              inc ax
3191  3B 46 F8        cmp ax, word ptr [bp - 8]
3194  76 03           jbe 0x3199
3196  E9 BB 00        jmp 0x3254
loc_3199:
3199  89 46 FC        mov word ptr [bp - 4], ax
319C  EB 03           jmp 0x31a1
loc_319E:
319E  FF 46 FC        inc word ptr [bp - 4]
loc_31A1:
31A1  6B 7E FC 19     imul di, word ptr [bp - 4], 0x19
31A5  81 C7 EF CC     add di, 0xccef
31A9  1E              push ds
31AA  07              pop es
31AB  89 7E F4        mov word ptr [bp - 0xc], di
31AE  8C 46 F6        mov word ptr [bp - 0xa], es
31B1  26 8B 45 0E     mov ax, word ptr es:[di + 0xe]
31B5  C1 E0 03        shl ax, 3
31B8  C4 3E BA D7     les di, ptr [0xd7ba]
31BC  03 F8           add di, ax
31BE  26 8A 45 06     mov al, byte ptr es:[di + 6]
31C2  30 E4           xor ah, ah
31C4  8B F8           mov di, ax
31C6  D1 E7           shl di, 1
31C8  8B 85 3A 0A     mov ax, word ptr [di + 0xa3a]
31CC  C4 7E F4        les di, ptr [bp - 0xc]
31CF  26 89 45 0A     mov word ptr es:[di + 0xa], ax
31D3  8A 46 FF        mov al, byte ptr [bp - 1]
31D6  98              cwde
31D7  8B F8           mov di, ax
31D9  8A 85 56 0D     mov al, byte ptr [di + 0xd56]
31DD  30 E4           xor ah, ah
31DF  40              inc ax
31E0  3B 46 FC        cmp ax, word ptr [bp - 4]
31E3  73 5E           jae 0x3243
31E5  C4 7E F4        les di, ptr [bp - 0xc]
31E8  26 8B 45 0A     mov ax, word ptr es:[di + 0xa]
31EC  6B 7E FA 19     imul di, word ptr [bp - 6], 0x19
31F0  3B 85 F9 CC     cmp ax, word ptr [di - 0x3307]
31F4  75 4D           jne 0x3243
31F6  C4 7E F4        les di, ptr [bp - 0xc]
31F9  26 8A 45 0A     mov al, byte ptr es:[di + 0xa]
31FD  98              cwde
31FE  99              cdq
31FF  31 D0           xor ax, dx
3201  29 D0           sub ax, dx
3203  3D 04 00        cmp ax, 4
3206  7E 2A           jle 0x3232
3208  26 80 7D 0A 00  cmp byte ptr es:[di + 0xa], 0
320D  B0 00           mov al, 0
320F  7E 01           jle 0x3212
3211  40              inc ax
loc_3212:
3212  98              cwde
3213  8B F8           mov di, ax
3215  8A 85 38 A3     mov al, byte ptr [di - 0x5cc8]
3219  98              cwde
321A  8B F0           mov si, ax
321C  D1 E0           shl ax, 1
321E  01 F0           add ax, si
3220  C4 7E F4        les di, ptr [bp - 0xc]
3223  26 28 45 0A     sub byte ptr es:[di + 0xa], al
3227  6B 7E FA 19     imul di, word ptr [bp - 6], 0x19
322B  80 AD FA CC 03  sub byte ptr [di - 0x3306], 3
3230  EB 11           jmp 0x3243
loc_3232:
3232  C4 7E F4        les di, ptr [bp - 0xc]
3235  26 80 45 0A 03  add byte ptr es:[di + 0xa], 3
323A  6B 7E FA 19     imul di, word ptr [bp - 6], 0x19
323E  80 AD F9 CC 03  sub byte ptr [di - 0x3307], 3
loc_3243:
3243  8B 46 FC        mov ax, word ptr [bp - 4]
3246  89 46 FA        mov word ptr [bp - 6], ax
3249  8B 46 FC        mov ax, word ptr [bp - 4]
324C  3B 46 F8        cmp ax, word ptr [bp - 8]
324F  74 03           je 0x3254
3251  E9 4A FF        jmp 0x319e
loc_3254:
3254  80 7E FF 01     cmp byte ptr [bp - 1], 1
3258  74 03           je 0x325d
325A  E9 12 FF        jmp 0x316f
loc_325D:
325D  C9              leave
325E  C3              ret

; ---- routine 0AB5:325F  (found by: call)
sub_325F:
325F  C8 06 00 00     enter 6, 0
3263  C4 7E 06        les di, ptr [bp + 6]
3266  26 8B 45 0E     mov ax, word ptr es:[di + 0xe]
326A  C1 E0 03        shl ax, 3
326D  C4 3E BA D7     les di, ptr [0xd7ba]
3271  03 F8           add di, ax
3273  89 7E FA        mov word ptr [bp - 6], di
3276  8C 46 FC        mov word ptr [bp - 4], es
3279  26 80 7D 06 00  cmp byte ptr es:[di + 6], 0
327E  75 07           jne 0x3287
3280  C7 46 FE 04 00  mov word ptr [bp - 2], 4
3285  EB 4C           jmp 0x32d3
loc_3287:
3287  C4 7E FA        les di, ptr [bp - 6]
328A  26 80 7D 06 0B  cmp byte ptr es:[di + 6], 0xb
328F  77 20           ja 0x32b1
3291  6A 01           push 1
3293  C4 7E 06        les di, ptr [bp + 6]
3296  06              push es
3297  57              push di
3298  0E              push cs
3299  E8 B0 E7        call 0x1a4c
329C  08 C0           or al, al
329E  74 0D           je 0x32ad
32A0  C4 7E 06        les di, ptr [bp + 6]
32A3  06              push es
32A4  57              push di
32A5  0E              push cs
32A6  E8 A5 EB        call 0x1e4e
32A9  08 C0           or al, al
32AB  75 04           jne 0x32b1
loc_32AD:
32AD  B0 00           mov al, 0
32AF  EB 02           jmp 0x32b3
loc_32B1:
32B1  B0 01           mov al, 1
loc_32B3:
32B3  98              cwde
32B4  8B D0           mov dx, ax
32B6  C4 7E FA        les di, ptr [bp - 6]
32B9  26 80 7D 06 04  cmp byte ptr es:[di + 6], 4
32BE  B0 00           mov al, 0
32C0  76 01           jbe 0x32c3
32C2  40              inc ax
loc_32C3:
32C3  98              cwde
32C4  8B F8           mov di, ax
32C6  D1 E7           shl di, 1
32C8  03 FA           add di, dx
32CA  8A 85 56 0A     mov al, byte ptr [di + 0xa56]
32CE  30 E4           xor ah, ah
32D0  89 46 FE        mov word ptr [bp - 2], ax
loc_32D3:
32D3  8B 46 FE        mov ax, word ptr [bp - 2]
32D6  C9              leave
32D7  CA 04 00        retf 4

