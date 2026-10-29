; 1-095.EXE (One-Nil 95), code segment 24AC (image offsets 24AC0..26A7F), part 4 of 4
; packed 1-095.EXE sha256 f659fb2d334500d6901fc8d6a0f06c85c0ccda2eb4a3035ae3bb0a0004d79192 (LZEXE 0.91)
; unpacked (tools/static/unlzexe.py) sha256 8df646e017e0965a5d90a58181ca764219ad847833aad0b6cb58fc53372bfb2c
; tool: capstone 5.0.9 (pip package; core library 5.0.1280) (CS_ARCH_X86, CS_MODE_16), recursive descent from the entry point, far calls and near calls/jumps, then routine prologues (55 89 E5 / 55 8B EC / C8 iw 00) in what remains; tools/static/listing.py
; addresses are SEGMENT:OFFSET with SEGMENT the image paragraph before relocation; image offset = SEGMENT*16+OFFSET
; ---- routine 24AC:1C96  (found by: call)
sub_1C96:
1C96  C8 52 00 00     enter 0x52, 0
1C9A  8C D3           mov bx, ss
1C9C  8E C3           mov es, bx
1C9E  8C DB           mov bx, ds
1CA0  FC              cld
1CA1  8D 7E AE        lea di, [bp - 0x52]
1CA4  C5 76 10        lds si, ptr [bp + 0x10]
1CA7  AC              lodsb al, byte ptr [si]
1CA8  3C 50           cmp al, 0x50
1CAA  72 02           jb 0x1cae
1CAC  B0 50           mov al, 0x50
loc_1CAE:
1CAE  AA              stosb byte ptr es:[di], al
1CAF  91              xchg cx, ax
1CB0  30 ED           xor ch, ch
1CB2  F3 A4           rep movsb byte ptr es:[di], byte ptr [si]
1CB4  8E DB           mov ds, bx
1CB6  A1 EE E0        mov ax, word ptr [0xe0ee]
1CB9  0B 06 F0 E0     or ax, word ptr [0xe0f0]
1CBD  74 29           je 0x1ce8
1CBF  C4 3E EE E0     les di, ptr [0xe0ee]
1CC3  06              push es
1CC4  57              push di
1CC5  8D 7E AE        lea di, [bp - 0x52]
1CC8  16              push ss
1CC9  57              push di
1CCA  8A 46 0E        mov al, byte ptr [bp + 0xe]
1CCD  50              push ax
1CCE  8A 46 0C        mov al, byte ptr [bp + 0xc]
1CD1  50              push ax
1CD2  FF 76 06        push word ptr [bp + 6]
1CD5  69 46 0A 40 01  imul ax, word ptr [bp + 0xa], 0x140
1CDA  03 46 08        add ax, word ptr [bp + 8]
1CDD  C4 3E E0 E0     les di, ptr [0xe0e0]
1CE1  03 F8           add di, ax
1CE3  06              push es
1CE4  57              push di
1CE5  E8 00 FF        call 0x1be8
loc_1CE8:
1CE8  C9              leave
1CE9  CA 0E 00        retf 0xe

; ---- routine 24AC:1CEC  (found by: call)
sub_1CEC:
1CEC  C8 52 00 00     enter 0x52, 0
1CF0  8C D3           mov bx, ss
1CF2  8E C3           mov es, bx
1CF4  8C DB           mov bx, ds
1CF6  FC              cld
1CF7  8D 7E AE        lea di, [bp - 0x52]
1CFA  C5 76 0E        lds si, ptr [bp + 0xe]
1CFD  AC              lodsb al, byte ptr [si]
1CFE  3C 50           cmp al, 0x50
1D00  72 02           jb 0x1d04
1D02  B0 50           mov al, 0x50
loc_1D04:
1D04  AA              stosb byte ptr es:[di], al
1D05  91              xchg cx, ax
1D06  30 ED           xor ch, ch
1D08  F3 A4           rep movsb byte ptr es:[di], byte ptr [si]
1D0A  8E DB           mov ds, bx
1D0C  80 7E AE 00     cmp byte ptr [bp - 0x52], 0
1D10  76 71           jbe 0x1d83
1D12  80 3E DE E0 00  cmp byte ptr [0xe0de], 0
1D17  74 26           je 0x1d3f
1D19  8D 7E AE        lea di, [bp - 0x52]
1D1C  16              push ss
1D1D  57              push di
1D1E  8A 46 0C        mov al, byte ptr [bp + 0xc]
1D21  50              push ax
1D22  8A 46 0A        mov al, byte ptr [bp + 0xa]
1D25  50              push ax
1D26  FF 76 08        push word ptr [bp + 8]
1D29  8B 46 06        mov ax, word ptr [bp + 6]
1D2C  C1 E0 03        shl ax, 3
1D2F  50              push ax
1D30  8A 46 AE        mov al, byte ptr [bp - 0x52]
1D33  30 E4           xor ah, ah
1D35  C1 E0 03        shl ax, 3
1D38  50              push ax
1D39  0E              push cs
1D3A  E8 59 FF        call 0x1c96
1D3D  EB 44           jmp 0x1d83
loc_1D3F:
1D3F  A1 EA E0        mov ax, word ptr [0xe0ea]
1D42  0B 06 EC E0     or ax, word ptr [0xe0ec]
1D46  74 3B           je 0x1d83
1D48  6A 02           push 2
1D4A  0E              push cs
1D4B  E8 35 FE        call 0x1b83
1D4E  8D 7E AE        lea di, [bp - 0x52]
1D51  16              push ss
1D52  57              push di
1D53  C4 3E EA E0     les di, ptr [0xe0ea]
1D57  06              push es
1D58  57              push di
1D59  A1 DC E0        mov ax, word ptr [0xe0dc]
1D5C  F7 66 08        mul word ptr [bp + 8]
1D5F  03 46 06        add ax, word ptr [bp + 6]
1D62  C4 3E E0 E0     les di, ptr [0xe0e0]
1D66  03 F8           add di, ax
1D68  06              push es
1D69  57              push di
1D6A  FF 36 DC E0     push word ptr [0xe0dc]
1D6E  A0 E8 E0        mov al, byte ptr [0xe0e8]
1D71  50              push ax
1D72  8A 46 0C        mov al, byte ptr [bp + 0xc]
1D75  50              push ax
1D76  8A 46 0A        mov al, byte ptr [bp + 0xa]
1D79  50              push ax
1D7A  E8 1A FE        call 0x1b97
1D7D  6A 00           push 0
1D7F  0E              push cs
1D80  E8 00 FE        call 0x1b83
loc_1D83:
1D83  C9              leave
1D84  CA 0C 00        retf 0xc

; ---- routine 24AC:1D87  (found by: call)
sub_1D87:
1D87  C8 14 00 00     enter 0x14, 0
1D8B  C6 46 ED 12     mov byte ptr [bp - 0x13], 0x12
1D8F  80 7E 06 00     cmp byte ptr [bp + 6], 0
1D93  B0 00           mov al, 0
1D95  75 01           jne 0x1d98
1D97  40              inc ax
loc_1D98:
1D98  88 46 EC        mov byte ptr [bp - 0x14], al
1D9B  C6 46 EE 36     mov byte ptr [bp - 0x12], 0x36
1D9F  6A 10           push 0x10
1DA1  8D 7E EC        lea di, [bp - 0x14]
1DA4  16              push ss
1DA5  57              push di
1DA6  9A B2 00 A8 26  call far 26A8:00B2
1DAB  C9              leave
1DAC  CA 02 00        retf 2
; data (not reached as code), 43 bytes
1DAF                  pstr '386 chip (or better) required'
1DCD                  pstr 'VGA required'

; ---- routine 24AC:1DDA  (found by: call)
sub_1DDA:
1DDA  C8 16 00 00     enter 0x16, 0
1DDE  C6 46 EB 00     mov byte ptr [bp - 0x15], 0
1DE2  54              push sp
1DE3  58              pop ax
1DE4  39 E0           cmp ax, sp
1DE6  75 12           jne 0x1dfa
1DE8  9C              pushf
1DE9  58              pop ax
1DEA  0D 00 30        or ax, 0x3000
1DED  50              push ax
1DEE  9D              popf
1DEF  9C              pushf
1DF0  58              pop ax
1DF1  A9 00 30        test ax, 0x3000
1DF4  74 04           je 0x1dfa
1DF6  C6 46 EB 01     mov byte ptr [bp - 0x15], 1
loc_1DFA:
1DFA  80 7E EB 00     cmp byte ptr [bp - 0x15], 0
1DFE  75 09           jne 0x1e09
1E00  BF AF 1D        mov di, 0x1daf
1E03  0E              push cs
1E04  57              push di
1E05  0E              push cs
1E06  E8 B5 E8        call 0x6be
loc_1E09:
1E09  6A 00           push 0
1E0B  0E              push cs
1E0C  E8 78 FF        call 0x1d87
1E0F  C7 46 EC 13 00  mov word ptr [bp - 0x14], 0x13
1E14  6A 10           push 0x10
1E16  8D 7E EC        lea di, [bp - 0x14]
1E19  16              push ss
1E1A  57              push di
1E1B  9A B2 00 A8 26  call far 26A8:00B2
1E20  C4 3E E0 E0     les di, ptr [0xe0e0]
1E24  26 C6 85 00 FF 7A mov byte ptr es:[di - 0x100], 0x7a
1E2A  C4 3E E0 E0     les di, ptr [0xe0e0]
1E2E  26 80 BD 00 FF 7A cmp byte ptr es:[di - 0x100], 0x7a
1E34  74 0D           je 0x1e43
1E36  0E              push cs
1E37  E8 B3 FB        call 0x19ed
1E3A  BF CD 1D        mov di, 0x1dcd
1E3D  0E              push cs
1E3E  57              push di
1E3F  0E              push cs
1E40  E8 7B E8        call 0x6be
loc_1E43:
1E43  6A 01           push 1
1E45  0E              push cs
1E46  E8 3E FF        call 0x1d87
1E49  0E              push cs
1E4A  E8 A0 FB        call 0x19ed
1E4D  C9              leave
1E4E  C3              ret

; ---- routine 24AC:1E4F  (found by: call, prologue)
sub_1E4F:
1E4F  55              push bp
1E50  89 E5           mov bp, sp
1E52  0E              push cs
1E53  E8 61 FC        call 0x1ab7
1E56  0E              push cs
1E57  E8 93 FB        call 0x19ed
1E5A  0E              push cs
1E5B  E8 0F E5        call 0x36d
1E5E  6A 01           push 1
1E60  6A 01           push 1
1E62  0E              push cs
1E63  E8 F9 EE        call 0xd5f
1E66  80 3E 30 DE 00  cmp byte ptr [0xde30], 0
1E6B  74 16           je 0x1e83
1E6D  BF 26 FA        mov di, 0xfa26
1E70  1E              push ds
1E71  57              push di
1E72  BF 30 DE        mov di, 0xde30
1E75  1E              push ds
1E76  57              push di
1E77  6A 00           push 0
1E79  9A 78 08 B9 26  call far 26B9:0878
1E7E  9A E5 07 B9 26  call far 26B9:07E5
loc_1E83:
1E83  C9              leave
1E84  CB              retf
; data (not reached as code), 5 bytes
1E85                  pstr 'BAMI'

; ---- routine 24AC:1E8A  (found by: prologue)
sub_1E8A:
1E8A  C8 00 01 00     enter 0x100, 0
1E8E  80 3E 4A A4 00  cmp byte ptr [0xa44a], 0
1E93  74 04           je 0x1e99
1E95  0E              push cs
1E96  E8 F8 FA        call 0x1991
loc_1E99:
1E99  6A 09           push 9
1E9B  FF 36 FC DE     push word ptr [0xdefc]
1E9F  FF 36 FA DE     push word ptr [0xdefa]
1EA3  9A 94 00 A8 26  call far 26A8:0094
1EA8  8D BE 00 FF     lea di, [bp - 0x100]
1EAC  16              push ss
1EAD  57              push di
1EAE  6A 01           push 1
1EB0  9A A4 08 B9 26  call far 26B9:08A4
1EB5  BF 85 1E        mov di, 0x1e85
1EB8  0E              push cs
1EB9  57              push di
1EBA  9A 44 0C B9 26  call far 26B9:0C44
1EBF  74 04           je 0x1ec5
1EC1  0E              push cs
1EC2  E8 8A FF        call 0x1e4f
loc_1EC5:
1EC5  A1 20 F9        mov ax, word ptr [0xf920]
1EC8  8B 16 22 F9     mov dx, word ptr [0xf922]
1ECC  A3 0C A5        mov word ptr [0xa50c], ax
1ECF  89 16 0E A5     mov word ptr [0xa50e], dx
1ED3  C9              leave
1ED4  CB              retf
; data (not reached as code), 25 bytes
1ED5                  pstr '*.*'
1ED9                  pstr '(c) new era software'

; ---- routine 24AC:1EEE  (found by: far)
sub_1EEE:
1EEE  C8 00 01 00     enter 0x100, 0
1EF2  BF 22 DE        mov di, 0xde22
1EF5  1E              push ds
1EF6  57              push di
1EF7  68 A0 0F        push 0xfa0
1EFA  0E              push cs
1EFB  E8 87 F5        call 0x1485
1EFE  31 C0           xor ax, ax
1F00  8B 16 24 A5     mov dx, word ptr [0xa524]
1F04  A3 E0 E0        mov word ptr [0xe0e0], ax
1F07  89 16 E2 E0     mov word ptr [0xe0e2], dx
1F0B  B8 6C 00        mov ax, 0x6c
1F0E  8B 16 22 A5     mov dx, word ptr [0xa522]
1F12  A3 26 DE        mov word ptr [0xde26], ax
1F15  89 16 28 DE     mov word ptr [0xde28], dx
1F19  C7 06 DC E0 50 00 mov word ptr [0xe0dc], 0x50
1F1F  B8 1C A5        mov ax, 0xa51c
1F22  8C DA           mov dx, ds
1F24  A3 84 DE        mov word ptr [0xde84], ax
1F27  89 16 86 DE     mov word ptr [0xde86], dx
1F2B  9A 1A 18 B9 26  call far 26B9:181A
1F30  8D BE 00 FF     lea di, [bp - 0x100]
1F34  16              push ss
1F35  57              push di
1F36  0E              push cs
1F37  E8 E5 F4        call 0x141f
1F3A  BF 80 E0        mov di, 0xe080
1F3D  1E              push ds
1F3E  57              push di
1F3F  6A 44           push 0x44
1F41  9A 6D 0B B9 26  call far 26B9:0B6D
1F46  BF D5 1E        mov di, 0x1ed5
1F49  0E              push cs
1F4A  57              push di
1F4B  BF C5 E0        mov di, 0xe0c5
1F4E  1E              push ds
1F4F  57              push di
1F50  6A 0C           push 0xc
1F52  9A 6D 0B B9 26  call far 26B9:0B6D
1F57  BF 80 E0        mov di, 0xe080
1F5A  1E              push ds
1F5B  57              push di
1F5C  BF DC DF        mov di, 0xdfdc
1F5F  1E              push ds
1F60  57              push di
1F61  6A 52           push 0x52
1F63  9A 12 0A B9 26  call far 26B9:0A12
1F68  BF D9 1E        mov di, 0x1ed9
1F6B  0E              push cs
1F6C  57              push di
1F6D  BF 30 DE        mov di, 0xde30
1F70  1E              push ds
1F71  57              push di
1F72  6A 50           push 0x50
1F74  9A 6D 0B B9 26  call far 26B9:0B6D
1F79  A1 0C A5        mov ax, word ptr [0xa50c]
1F7C  8B 16 0E A5     mov dx, word ptr [0xa50e]
1F80  A3 20 F9        mov word ptr [0xf920], ax
1F83  89 16 22 F9     mov word ptr [0xf922], dx
1F87  B8 8A 1E        mov ax, 0x1e8a
1F8A  BA AC 24        mov dx, 0x24ac   ; relocated segment word 24AC
1F8D  A3 0C A5        mov word ptr [0xa50c], ax
1F90  89 16 0E A5     mov word ptr [0xa50e], dx
1F94  E8 43 FE        call 0x1dda
1F97  BF 18 F9        mov di, 0xf918
1F9A  1E              push ds
1F9B  57              push di
1F9C  0E              push cs
1F9D  E8 8B E9        call 0x92b
1FA0  E8 FD EC        call 0xca0
1FA3  0E              push cs
1FA4  E8 9E FA        call 0x1a45
1FA7  31 C0           xor ax, ax
1FA9  A3 EA E0        mov word ptr [0xe0ea], ax
1FAC  A3 EC E0        mov word ptr [0xe0ec], ax
1FAF  31 C0           xor ax, ax
1FB1  A3 EE E0        mov word ptr [0xe0ee], ax
1FB4  A3 F0 E0        mov word ptr [0xe0f0], ax
1FB7  C6 06 DA E0 01  mov byte ptr [0xe0da], 1
1FBC  C9              leave
1FBD  CB              retf
; data (not reached as code), 2 bytes
1FBE                  db 00 00   ; ..
