; 1-095.EXE (One-Nil 95), code segment 06E4 (image offsets 06E40..0AB4F), part 2 of 6
; packed 1-095.EXE sha256 f659fb2d334500d6901fc8d6a0f06c85c0ccda2eb4a3035ae3bb0a0004d79192 (LZEXE 0.91)
; unpacked (tools/static/unlzexe.py) sha256 8df646e017e0965a5d90a58181ca764219ad847833aad0b6cb58fc53372bfb2c
; tool: capstone 5.0.9 (pip package; core library 5.0.1280) (CS_ARCH_X86, CS_MODE_16), recursive descent from the entry point, far calls and near calls/jumps, then routine prologues (55 89 E5 / 55 8B EC / C8 iw 00) in what remains; tools/static/listing.py
; addresses are SEGMENT:OFFSET with SEGMENT the image paragraph before relocation; image offset = SEGMENT*16+OFFSET
; ---- routine 06E4:0C23  (found by: call)
sub_0C23:
0C23  55              push bp
0C24  89 E5           mov bp, sp
0C26  8B 7E 04        mov di, word ptr [bp + 4]
0C29  36 FF 45 FA     inc word ptr ss:[di - 6]
0C2D  8A 46 06        mov al, byte ptr [bp + 6]
0C30  8B 7E 08        mov di, word ptr [bp + 8]
0C33  88 85 FB D4     mov byte ptr [di - 0x2b05], al
0C37  8B 46 06        mov ax, word ptr [bp + 6]
0C3A  8B 7E 04        mov di, word ptr [bp + 4]
0C3D  03 F8           add di, ax
0C3F  36 C6 85 47 FF 01 mov byte ptr ss:[di - 0xb9], 1
0C45  8B 7E 08        mov di, word ptr [bp + 8]
0C48  8A 85 FB D4     mov al, byte ptr [di - 0x2b05]
0C4C  30 E4           xor ah, ah
0C4E  C4 3E B6 D7     les di, ptr [0xd7b6]
0C52  03 F8           add di, ax
0C54  26 8A 45 FF     mov al, byte ptr es:[di - 1]
0C58  30 E4           xor ah, ah
0C5A  8B 7E 04        mov di, word ptr [bp + 4]
0C5D  03 F8           add di, ax
0C5F  36 FE 85 C7 FE  inc byte ptr ss:[di - 0x139]
0C64  C9              leave
0C65  C2 06 00        ret 6

; ---- routine 06E4:0C68  (found by: call)
sub_0C68:
0C68  C8 06 00 00     enter 6, 0
0C6C  C7 46 FE 01 00  mov word ptr [bp - 2], 1
0C71  EB 03           jmp 0xc76
loc_0C73:
0C73  FF 46 FE        inc word ptr [bp - 2]
loc_0C76:
0C76  8B 7E FE        mov di, word ptr [bp - 2]
0C79  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
0C7D  30 E4           xor ah, ah
0C7F  6B C0 3E        imul ax, ax, 0x3e
0C82  C4 3E C2 D7     les di, ptr [0xd7c2]
0C86  03 F8           add di, ax
0C88  81 C7 C2 FF     add di, 0xffc2
0C8C  26 8A 45 38     mov al, byte ptr es:[di + 0x38]
0C90  3A 46 06        cmp al, byte ptr [bp + 6]
0C93  75 30           jne 0xcc5
0C95  8B 7E FE        mov di, word ptr [bp - 2]
0C98  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
0C9C  30 E4           xor ah, ah
0C9E  8B 7E 04        mov di, word ptr [bp + 4]
0CA1  03 F8           add di, ax
0CA3  36 80 BD 47 FF 00 cmp byte ptr ss:[di - 0xb9], 0
0CA9  75 1A           jne 0xcc5
0CAB  8B 7E 04        mov di, word ptr [bp + 4]
0CAE  36 8B 45 FA     mov ax, word ptr ss:[di - 6]
0CB2  40              inc ax
0CB3  50              push ax
0CB4  8B 7E FE        mov di, word ptr [bp - 2]
0CB7  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
0CBB  30 E4           xor ah, ah
0CBD  50              push ax
0CBE  8B 7E 04        mov di, word ptr [bp + 4]
0CC1  57              push di
0CC2  E8 5E FF        call 0xc23
loc_0CC5:
0CC5  81 7E FE B0 00  cmp word ptr [bp - 2], 0xb0
0CCA  75 A7           jne 0xc73
0CCC  C9              leave
0CCD  C2 04 00        ret 4

; ---- routine 06E4:0CD0  (found by: call)
sub_0CD0:
0CD0  C8 02 00 00     enter 2, 0
0CD4  C7 46 FE 60 00  mov word ptr [bp - 2], 0x60
loc_0CD9:
0CD9  8B 7E 04        mov di, word ptr [bp + 4]
0CDC  36 8B 7D 04     mov di, word ptr ss:[di + 4]
0CE0  36 83 7D FA 20  cmp word ptr ss:[di - 6], 0x20
0CE5  72 03           jb 0xcea
0CE7  E9 DE 00        jmp 0xdc8
loc_0CEA:
0CEA  FF 76 FE        push word ptr [bp - 2]
0CED  9A 6D 07 1A 23  call far 231A:076D
0CF2  05 50 00        add ax, 0x50
0CF5  8B 7E 04        mov di, word ptr [bp + 4]
0CF8  36 8B 7D 04     mov di, word ptr ss:[di + 4]
0CFC  36 89 45 F8     mov word ptr ss:[di - 8], ax
0D00  36 83 7D F8 51  cmp word ptr ss:[di - 8], 0x51
0D05  72 14           jb 0xd1b
0D07  36 8B 7D F8     mov di, word ptr ss:[di - 8]
0D0B  8A 85 FB D4     mov al, byte ptr [di - 0x2b05]
0D0F  30 E4           xor ah, ah
0D11  50              push ax
0D12  9A EE 1A 51 1B  call far 1B51:1AEE
0D17  08 C0           or al, al
0D19  75 77           jne 0xd92
loc_0D1B:
0D1B  8B 7E 04        mov di, word ptr [bp + 4]
0D1E  36 8B 7D 04     mov di, word ptr ss:[di + 4]
0D22  36 8B 7D F8     mov di, word ptr ss:[di - 8]
0D26  8A 85 FB D4     mov al, byte ptr [di - 0x2b05]
0D2A  30 E4           xor ah, ah
0D2C  8B 7E 04        mov di, word ptr [bp + 4]
0D2F  36 8B 7D 04     mov di, word ptr ss:[di + 4]
0D33  03 F8           add di, ax
0D35  36 80 BD 47 FF 00 cmp byte ptr ss:[di - 0xb9], 0
0D3B  75 55           jne 0xd92
0D3D  8B 7E 04        mov di, word ptr [bp + 4]
0D40  36 8B 7D 04     mov di, word ptr ss:[di + 4]
0D44  36 8B 7D F8     mov di, word ptr ss:[di - 8]
0D48  8A 85 FB D4     mov al, byte ptr [di - 0x2b05]
0D4C  30 E4           xor ah, ah
0D4E  C4 3E B6 D7     les di, ptr [0xd7b6]
0D52  03 F8           add di, ax
0D54  26 8A 45 FF     mov al, byte ptr es:[di - 1]
0D58  30 E4           xor ah, ah
0D5A  8B 7E 04        mov di, word ptr [bp + 4]
0D5D  36 8B 7D 04     mov di, word ptr ss:[di + 4]
0D61  03 F8           add di, ax
0D63  36 8A 85 C7 FE  mov al, byte ptr ss:[di - 0x139]
0D68  30 E4           xor ah, ah
0D6A  3B 46 06        cmp ax, word ptr [bp + 6]
0D6D  73 23           jae 0xd92
0D6F  8B 7E 04        mov di, word ptr [bp + 4]
0D72  36 8B 7D 04     mov di, word ptr ss:[di + 4]
0D76  36 8B 45 FA     mov ax, word ptr ss:[di - 6]
0D7A  40              inc ax
0D7B  50              push ax
0D7C  36 8B 7D F8     mov di, word ptr ss:[di - 8]
0D80  8A 85 FB D4     mov al, byte ptr [di - 0x2b05]
0D84  30 E4           xor ah, ah
0D86  50              push ax
0D87  8B 7E 04        mov di, word ptr [bp + 4]
0D8A  36 8B 7D 04     mov di, word ptr ss:[di + 4]
0D8E  57              push di
0D8F  E8 91 FE        call 0xc23
loc_0D92:
0D92  8B 7E 04        mov di, word ptr [bp + 4]
0D95  36 8B 7D 04     mov di, word ptr ss:[di + 4]
0D99  36 8B 7D F8     mov di, word ptr ss:[di - 8]
0D9D  81 C7 FB D4     add di, 0xd4fb
0DA1  1E              push ds
0DA2  57              push di
0DA3  8B 46 FE        mov ax, word ptr [bp - 2]
0DA6  05 50 00        add ax, 0x50
0DA9  8B F8           mov di, ax
0DAB  81 C7 FB D4     add di, 0xd4fb
0DAF  1E              push ds
0DB0  57              push di
0DB1  6A 01           push 1
0DB3  9A 03 02 AC 24  call far 24AC:0203
0DB8  83 7E FE 01     cmp word ptr [bp - 2], 1
0DBC  76 05           jbe 0xdc3
0DBE  FF 4E FE        dec word ptr [bp - 2]
0DC1  EB 02           jmp 0xdc5
loc_0DC3:
0DC3  EB 03           jmp 0xdc8
loc_0DC5:
0DC5  E9 11 FF        jmp 0xcd9
loc_0DC8:
0DC8  C9              leave
0DC9  C2 04 00        ret 4

; ---- routine 06E4:0DCC  (found by: call)
sub_0DCC:
0DCC  C8 06 00 00     enter 6, 0
0DD0  8A 46 08        mov al, byte ptr [bp + 8]
0DD3  50              push ax
0DD4  8B 7E 04        mov di, word ptr [bp + 4]
0DD7  57              push di
0DD8  E8 8D FE        call 0xc68
0DDB  8B 7E 04        mov di, word ptr [bp + 4]
0DDE  81 C7 C8 FE     add di, 0xfec8
0DE2  16              push ss
0DE3  57              push di
0DE4  68 80 00        push 0x80
0DE7  6A 00           push 0
0DE9  9A 22 02 AC 24  call far 24AC:0222
0DEE  FF 76 06        push word ptr [bp + 6]
0DF1  55              push bp
0DF2  E8 DB FE        call 0xcd0
0DF5  8B 7E 04        mov di, word ptr [bp + 4]
0DF8  36 83 7D FA 20  cmp word ptr ss:[di - 6], 0x20
0DFD  73 06           jae 0xe05
0DFF  6A 20           push 0x20
0E01  55              push bp
0E02  E8 CB FE        call 0xcd0
loc_0E05:
0E05  6A 20           push 0x20
0E07  6A 0A           push 0xa
0E09  8A 46 08        mov al, byte ptr [bp + 8]
0E0C  50              push ax
0E0D  6A 00           push 0
0E0F  E8 91 FA        call 0x8a3
0E12  C7 46 FE 01 00  mov word ptr [bp - 2], 1
0E17  EB 03           jmp 0xe1c
loc_0E19:
0E19  FF 46 FE        inc word ptr [bp - 2]
loc_0E1C:
0E1C  8B 7E FE        mov di, word ptr [bp - 2]
0E1F  8A 85 FB D4     mov al, byte ptr [di - 0x2b05]
0E23  30 E4           xor ah, ah
0E25  69 C0 AE 00     imul ax, ax, 0xae
0E29  C4 3E CA D7     les di, ptr [0xd7ca]
0E2D  03 F8           add di, ax
0E2F  81 C7 6D FF     add di, 0xff6d
0E33  26 8A 45 02     mov al, byte ptr es:[di + 2]
0E37  24 0F           and al, 0xf
0E39  08 C0           or al, al
0E3B  75 2E           jne 0xe6b
0E3D  8B 7E FE        mov di, word ptr [bp - 2]
0E40  8A 85 FB D4     mov al, byte ptr [di - 0x2b05]
0E44  50              push ax
0E45  8B 7E FE        mov di, word ptr [bp - 2]
0E48  8A 85 FB D4     mov al, byte ptr [di - 0x2b05]
0E4C  30 E4           xor ah, ah
0E4E  69 C0 AE 00     imul ax, ax, 0xae
0E52  C4 3E CA D7     les di, ptr [0xd7ca]
0E56  03 F8           add di, ax
0E58  26 8A 85 6E FF  mov al, byte ptr es:[di - 0x92]
0E5D  50              push ax
0E5E  6A 0C           push 0xc
0E60  8A 46 08        mov al, byte ptr [bp + 8]
0E63  50              push ax
0E64  6A 01           push 1
0E66  9A F9 3A 51 1B  call far 1B51:3AF9
loc_0E6B:
0E6B  83 7E FE 20     cmp word ptr [bp - 2], 0x20
0E6F  75 A8           jne 0xe19
0E71  C9              leave
0E72  C2 06 00        ret 6

; ---- routine 06E4:0E75  (found by: far)
sub_0E75:
0E75  C8 38 01 00     enter 0x138, 0
0E79  C4 3E D2 D7     les di, ptr [0xd7d2]
0E7D  26 80 7D 01 01  cmp byte ptr es:[di + 1], 1
0E82  74 05           je 0xe89
0E84  9A F0 73 51 1B  call far 1B51:73F0
loc_0E89:
0E89  C4 3E DC DC     les di, ptr [0xdcdc]
0E8D  06              push es
0E8E  57              push di
0E8F  68 D0 01        push 0x1d0
0E92  6A 00           push 0
0E94  9A 22 02 AC 24  call far 24AC:0222
0E99  C4 3E CA D7     les di, ptr [0xd7ca]
0E9D  06              push es
0E9E  57              push di
0E9F  68 A0 77        push 0x77a0
0EA2  6A 00           push 0
0EA4  9A 22 02 AC 24  call far 24AC:0222
0EA9  C4 3E CE D7     les di, ptr [0xd7ce]
0EAD  06              push es
0EAE  57              push di
0EAF  68 E0 27        push 0x27e0
0EB2  6A 00           push 0
0EB4  9A 22 02 AC 24  call far 24AC:0222
0EB9  BF A6 DC        mov di, 0xdca6
0EBC  1E              push ds
0EBD  57              push di
0EBE  6A 08           push 8
0EC0  6A 00           push 0
0EC2  9A 22 02 AC 24  call far 24AC:0222
0EC7  C4 3E B6 DC     les di, ptr [0xdcb6]
0ECB  06              push es
0ECC  57              push di
0ECD  6A 60           push 0x60
0ECF  6A 00           push 0
0ED1  9A 22 02 AC 24  call far 24AC:0222
0ED6  C4 3E C6 D7     les di, ptr [0xd7c6]
0EDA  06              push es
0EDB  57              push di
0EDC  68 40 08        push 0x840
0EDF  6A 00           push 0
0EE1  9A 22 02 AC 24  call far 24AC:0222
0EE6  C7 46 FE 01 00  mov word ptr [bp - 2], 1
0EEB  EB 03           jmp 0xef0
loc_0EED:
0EED  FF 46 FE        inc word ptr [bp - 2]
loc_0EF0:
0EF0  C7 46 FC 01 00  mov word ptr [bp - 4], 1
0EF5  EB 03           jmp 0xefa
loc_0EF7:
0EF7  FF 46 FC        inc word ptr [bp - 4]
loc_0EFA:
0EFA  8B 7E FC        mov di, word ptr [bp - 4]
0EFD  8A 8D 6A A2     mov cl, byte ptr [di - 0x5d96]
0F01  8B 46 FC        mov ax, word ptr [bp - 4]
0F04  8B F0           mov si, ax
0F06  D1 E0           shl ax, 1
0F08  01 F0           add ax, si
0F0A  8B D0           mov dx, ax
0F0C  69 46 FE AE 00  imul ax, word ptr [bp - 2], 0xae
0F11  C4 3E CA D7     les di, ptr [0xd7ca]
0F15  03 F8           add di, ax
0F17  03 FA           add di, dx
0F19  26 88 8D 4F FF  mov byte ptr es:[di - 0xb1], cl
0F1E  83 7E FC 3A     cmp word ptr [bp - 4], 0x3a
0F22  75 D3           jne 0xef7
0F24  81 7E FE B0 00  cmp word ptr [bp - 2], 0xb0
0F29  75 C2           jne 0xeed
0F2B  31 C0           xor ax, ax
0F2D  89 46 FA        mov word ptr [bp - 6], ax
0F30  8D BE 48 FF     lea di, [bp - 0xb8]
0F34  16              push ss
0F35  57              push di
0F36  68 B0 00        push 0xb0
0F39  6A 00           push 0
0F3B  9A 22 02 AC 24  call far 24AC:0222
0F40  BF 26 D8        mov di, 0xd826
0F43  1E              push ds
0F44  57              push di
0F45  BF 4C D5        mov di, 0xd54c
0F48  1E              push ds
0F49  57              push di
0F4A  6A 60           push 0x60
0F4C  9A C2 01 AC 24  call far 24AC:01C2
0F51  C7 46 FE 01 00  mov word ptr [bp - 2], 1
0F56  EB 03           jmp 0xf5b
loc_0F58:
0F58  FF 46 FE        inc word ptr [bp - 2]
loc_0F5B:
0F5B  FF 76 FE        push word ptr [bp - 2]
0F5E  8B 7E FE        mov di, word ptr [bp - 2]
0F61  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
0F65  30 E4           xor ah, ah
0F67  50              push ax
0F68  55              push bp
0F69  E8 B7 FC        call 0xc23
0F6C  83 7E FE 04     cmp word ptr [bp - 2], 4
0F70  75 E6           jne 0xf58
0F72  6A 05           push 5
0F74  A0 E6 D7        mov al, byte ptr [0xd7e6]
0F77  30 E4           xor ah, ah
0F79  50              push ax
0F7A  55              push bp
0F7B  E8 A5 FC        call 0xc23
0F7E  C7 46 FA 05 00  mov word ptr [bp - 6], 5
0F83  6A 06           push 6
0F85  6A 01           push 1
0F87  55              push bp
0F88  E8 41 FE        call 0xdcc
0F8B  31 C0           xor ax, ax
0F8D  89 46 FA        mov word ptr [bp - 6], ax
0F90  C7 46 FE 05 00  mov word ptr [bp - 2], 5
0F95  EB 03           jmp 0xf9a
loc_0F97:
0F97  FF 46 FE        inc word ptr [bp - 2]
loc_0F9A:
0F9A  8B 7E FE        mov di, word ptr [bp - 2]
0F9D  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
0FA1  30 E4           xor ah, ah
0FA3  8B F8           mov di, ax
0FA5  80 BB 47 FF 00  cmp byte ptr [bp + di - 0xb9], 0
0FAA  75 13           jne 0xfbf
0FAC  8B 46 FA        mov ax, word ptr [bp - 6]
0FAF  40              inc ax
0FB0  50              push ax
0FB1  8B 7E FE        mov di, word ptr [bp - 2]
0FB4  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
0FB8  30 E4           xor ah, ah
0FBA  50              push ax
0FBB  55              push bp
0FBC  E8 64 FC        call 0xc23
loc_0FBF:
0FBF  83 7E FE 08     cmp word ptr [bp - 2], 8
0FC3  75 D2           jne 0xf97
0FC5  6A 07           push 7
0FC7  6A 01           push 1
0FC9  55              push bp
0FCA  E8 FF FD        call 0xdcc
0FCD  31 C0           xor ax, ax
0FCF  89 46 FA        mov word ptr [bp - 6], ax
0FD2  C7 46 FE 09 00  mov word ptr [bp - 2], 9
0FD7  EB 03           jmp 0xfdc
loc_0FD9:
0FD9  FF 46 FE        inc word ptr [bp - 2]
loc_0FDC:
0FDC  8B 7E FE        mov di, word ptr [bp - 2]
0FDF  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
0FE3  30 E4           xor ah, ah
0FE5  8B F8           mov di, ax
0FE7  80 BB 47 FF 00  cmp byte ptr [bp + di - 0xb9], 0
0FEC  75 13           jne 0x1001
0FEE  8B 46 FA        mov ax, word ptr [bp - 6]
0FF1  40              inc ax
0FF2  50              push ax
0FF3  8B 7E FE        mov di, word ptr [bp - 2]
0FF6  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
0FFA  30 E4           xor ah, ah
0FFC  50              push ax
0FFD  55              push bp
0FFE  E8 22 FC        call 0xc23
loc_1001:
1001  83 7E FE 10     cmp word ptr [bp - 2], 0x10
1005  75 D2           jne 0xfd9
1007  A0 E7 D7        mov al, byte ptr [0xd7e7]
100A  30 E4           xor ah, ah
100C  8B F8           mov di, ax
100E  80 BB 47 FF 00  cmp byte ptr [bp + di - 0xb9], 0
1013  75 0F           jne 0x1024
1015  8B 46 FA        mov ax, word ptr [bp - 6]
1018  40              inc ax
1019  50              push ax
101A  A0 E7 D7        mov al, byte ptr [0xd7e7]
101D  30 E4           xor ah, ah
101F  50              push ax
1020  55              push bp
1021  E8 FF FB        call 0xc23
loc_1024:
1024  6A 08           push 8
1026  6A 02           push 2
1028  55              push bp
1029  E8 A0 FD        call 0xdcc
102C  C9              leave
102D  CB              retf

; ---- routine 06E4:102E  (found by: call)
sub_102E:
102E  C8 02 00 00     enter 2, 0
1032  8B 46 04        mov ax, word ptr [bp + 4]
1035  3D 14 00        cmp ax, 0x14
1038  75 07           jne 0x1041
103A  C7 46 FE 16 00  mov word ptr [bp - 2], 0x16
103F  EB 22           jmp 0x1063
loc_1041:
1041  3D 1B 00        cmp ax, 0x1b
1044  75 07           jne 0x104d
1046  C7 46 FE 21 00  mov word ptr [bp - 2], 0x21
104B  EB 16           jmp 0x1063
loc_104D:
104D  3D 27 00        cmp ax, 0x27
1050  75 07           jne 0x1059
1052  C7 46 FE 2B 00  mov word ptr [bp - 2], 0x2b
1057  EB 0A           jmp 0x1063
loc_1059:
1059  3D 30 00        cmp ax, 0x30
105C  75 05           jne 0x1063
105E  C7 46 FE 35 00  mov word ptr [bp - 2], 0x35
loc_1063:
1063  8B 46 FE        mov ax, word ptr [bp - 2]
1066  C9              leave
1067  C2 02 00        ret 2

; ---- routine 06E4:106A  (found by: far)
sub_106A:
106A  C8 02 00 00     enter 2, 0
106E  8B 7E 06        mov di, word ptr [bp + 6]
1071  8A 85 FC 02     mov al, byte ptr [di + 0x2fc]
1075  30 E4           xor ah, ah
1077  89 46 FE        mov word ptr [bp - 2], ax
107A  8B 46 FE        mov ax, word ptr [bp - 2]
107D  C9              leave
107E  CA 02 00        retf 2

; ---- routine 06E4:1081  (found by: call)
sub_1081:
1081  C8 08 00 00     enter 8, 0
1085  8B 46 0A        mov ax, word ptr [bp + 0xa]
1088  8B 7E 04        mov di, word ptr [bp + 4]
108B  36 89 45 FE     mov word ptr ss:[di - 2], ax
108F  31 C0           xor ax, ax
1091  89 46 FC        mov word ptr [bp - 4], ax
1094  C7 46 FE 01 00  mov word ptr [bp - 2], 1
1099  EB 03           jmp 0x109e
loc_109B:
109B  FF 46 FE        inc word ptr [bp - 2]
loc_109E:
109E  8B 46 08        mov ax, word ptr [bp + 8]
10A1  8B F0           mov si, ax
10A3  D1 E0           shl ax, 1
10A5  01 F0           add ax, si
10A7  8B D0           mov dx, ax
10A9  8B 7E FE        mov di, word ptr [bp - 2]
10AC  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
10B0  30 E4           xor ah, ah
10B2  69 C0 AE 00     imul ax, ax, 0xae
10B6  C4 3E CA D7     les di, ptr [0xd7ca]
10BA  03 F8           add di, ax
10BC  03 FA           add di, dx
10BE  81 C7 4F FF     add di, 0xff4f
10C2  26 80 7D 01 00  cmp byte ptr es:[di + 1], 0
10C7  74 36           je 0x10ff
10C9  26 8A 05        mov al, byte ptr es:[di]
10CC  8B 7E 04        mov di, word ptr [bp + 4]
10CF  36 3A 45 06     cmp al, byte ptr ss:[di + 6]
10D3  75 2A           jne 0x10ff
10D5  8B 7E FE        mov di, word ptr [bp - 2]
10D8  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
10DC  30 E4           xor ah, ah
10DE  50              push ax
10DF  FF 76 08        push word ptr [bp + 8]
10E2  FF 76 06        push word ptr [bp + 6]
10E5  9A 3A 1A 51 1B  call far 1B51:1A3A
10EA  08 C0           or al, al
10EC  74 11           je 0x10ff
10EE  FF 46 FC        inc word ptr [bp - 4]
10F1  8B 7E FE        mov di, word ptr [bp - 2]
10F4  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
10F8  8B 7E FC        mov di, word ptr [bp - 4]
10FB  88 85 FB D4     mov byte ptr [di - 0x2b05], al
loc_10FF:
10FF  81 7E FE B0 00  cmp word ptr [bp - 2], 0xb0
1104  75 95           jne 0x109b
1106  8B 7E 04        mov di, word ptr [bp + 4]
1109  36 8B 45 FE     mov ax, word ptr ss:[di - 2]
110D  89 46 FA        mov word ptr [bp - 6], ax
1110  B8 01 00        mov ax, 1
1113  3B 46 FA        cmp ax, word ptr [bp - 6]
1116  77 21           ja 0x1139
1118  89 46 FE        mov word ptr [bp - 2], ax
111B  EB 03           jmp 0x1120
loc_111D:
111D  FF 46 FE        inc word ptr [bp - 2]
loc_1120:
1120  8B 7E FE        mov di, word ptr [bp - 2]
1123  8A 85 FB D4     mov al, byte ptr [di - 0x2b05]
1127  30 E4           xor ah, ah
1129  50              push ax
112A  6A 04           push 4
112C  9A 7C 4A 51 1B  call far 1B51:4A7C
1131  8B 46 FE        mov ax, word ptr [bp - 2]
1134  3B 46 FA        cmp ax, word ptr [bp - 6]
1137  75 E4           jne 0x111d
loc_1139:
1139  8B 7E 04        mov di, word ptr [bp + 4]
113C  36 83 7D FE 02  cmp word ptr ss:[di - 2], 2
1141  75 35           jne 0x1178
1143  36 80 7D 06 07  cmp byte ptr ss:[di + 6], 7
1148  75 18           jne 0x1162
114A  BF FC D4        mov di, 0xd4fc
114D  1E              push ds
114E  57              push di
114F  C4 3E D2 D7     les di, ptr [0xd7d2]
1153  81 C7 0B 00     add di, 0xb
1157  06              push es
1158  57              push di
1159  6A 02           push 2
115B  9A C2 01 AC 24  call far 24AC:01C2
1160  EB 16           jmp 0x1178
loc_1162:
1162  BF FC D4        mov di, 0xd4fc
1165  1E              push ds
1166  57              push di
1167  C4 3E D2 D7     les di, ptr [0xd7d2]
116B  81 C7 0D 00     add di, 0xd
116F  06              push es
1170  57              push di
1171  6A 02           push 2
1173  9A C2 01 AC 24  call far 24AC:01C2
loc_1178:
1178  C9              leave
1179  C2 08 00        ret 8

; ---- routine 06E4:117C  (found by: call)
sub_117C:
117C  C8 02 00 00     enter 2, 0
1180  A0 AE DC        mov al, byte ptr [0xdcae]
1183  30 E4           xor ah, ah
1185  8B F8           mov di, ax
1187  8A 85 A5 DC     mov al, byte ptr [di - 0x235b]
118B  A2 FC D4        mov byte ptr [0xd4fc], al
118E  A0 B2 DC        mov al, byte ptr [0xdcb2]
1191  30 E4           xor ah, ah
1193  8B F8           mov di, ax
1195  8A 85 A5 DC     mov al, byte ptr [di - 0x235b]
1199  A2 FD D4        mov byte ptr [0xd4fd], al
119C  A0 FC D4        mov al, byte ptr [0xd4fc]
119F  50              push ax
11A0  A0 FD D4        mov al, byte ptr [0xd4fd]
11A3  50              push ax
11A4  6A 39           push 0x39
11A6  6A 06           push 6
11A8  6A 01           push 1
11AA  9A F9 3A 51 1B  call far 1B51:3AF9
11AF  BF FC D4        mov di, 0xd4fc
11B2  1E              push ds
11B3  57              push di
11B4  C4 3E D2 D7     les di, ptr [0xd7d2]
11B8  81 C7 09 00     add di, 9
11BC  06              push es
11BD  57              push di
11BE  6A 02           push 2
11C0  9A C2 01 AC 24  call far 24AC:01C2
11C5  C7 46 FE 01 00  mov word ptr [bp - 2], 1
11CA  EB 03           jmp 0x11cf
loc_11CC:
11CC  FF 46 FE        inc word ptr [bp - 2]
loc_11CF:
11CF  8B 7E FE        mov di, word ptr [bp - 2]
11D2  8A 85 AD DC     mov al, byte ptr [di - 0x2353]
11D6  30 E4           xor ah, ah
11D8  8B F8           mov di, ax
11DA  8A 85 A5 DC     mov al, byte ptr [di - 0x235b]
11DE  30 E4           xor ah, ah
11E0  50              push ax
11E1  8B 7E FE        mov di, word ptr [bp - 2]
11E4  8A 85 AD DC     mov al, byte ptr [di - 0x2353]
11E8  30 E4           xor ah, ah
11EA  6B C0 0C        imul ax, ax, 0xc
11ED  C4 3E B6 DC     les di, ptr [0xdcb6]
11F1  03 F8           add di, ax
11F3  26 8A 45 F5     mov al, byte ptr es:[di - 0xb]
11F7  30 E4           xor ah, ah
11F9  D1 E0           shl ax, 1
11FB  50              push ax
11FC  9A 7C 4A 51 1B  call far 1B51:4A7C
1201  83 7E FE 08     cmp word ptr [bp - 2], 8
1205  75 C5           jne 0x11cc
1207  C9              leave
1208  C2 02 00        ret 2

; ---- routine 06E4:120B  (found by: call)
sub_120B:
120B  C8 0A 00 00     enter 0xa, 0
120F  C7 46 FA 01 00  mov word ptr [bp - 6], 1
1214  EB 03           jmp 0x1219
loc_1216:
1216  FF 46 FA        inc word ptr [bp - 6]
loc_1219:
1219  8A 46 FA        mov al, byte ptr [bp - 6]
121C  8B 7E FA        mov di, word ptr [bp - 6]
121F  88 85 AD DC     mov byte ptr [di - 0x2353], al
1223  83 7E FA 08     cmp word ptr [bp - 6], 8
1227  75 ED           jne 0x1216
1229  31 C0           xor ax, ax
122B  89 46 FE        mov word ptr [bp - 2], ax
122E  C7 46 FA 01 00  mov word ptr [bp - 6], 1
1233  EB 03           jmp 0x1238
loc_1235:
1235  FF 46 FA        inc word ptr [bp - 6]
loc_1238:
1238  8B 7E FA        mov di, word ptr [bp - 6]
123B  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
123F  30 E4           xor ah, ah
1241  69 C0 AE 00     imul ax, ax, 0xae
1245  C4 3E CA D7     les di, ptr [0xd7ca]
1249  03 F8           add di, ax
124B  81 C7 8B FF     add di, 0xff8b
124F  26 80 7D 01 00  cmp byte ptr es:[di + 1], 0
1254  74 2E           je 0x1284
1256  26 80 3D 06     cmp byte ptr es:[di], 6
125A  75 28           jne 0x1284
125C  8B 7E FA        mov di, word ptr [bp - 6]
125F  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
1263  30 E4           xor ah, ah
1265  50              push ax
1266  6A 14           push 0x14
1268  6A 16           push 0x16
126A  9A 3A 1A 51 1B  call far 1B51:1A3A
126F  08 C0           or al, al
1271  74 11           je 0x1284
1273  FF 46 FE        inc word ptr [bp - 2]
1276  8B 7E FA        mov di, word ptr [bp - 6]
1279  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
127D  8B 7E FE        mov di, word ptr [bp - 2]
1280  88 85 A5 DC     mov byte ptr [di - 0x235b], al
loc_1284:
1284  81 7E FA B0 00  cmp word ptr [bp - 6], 0xb0
1289  75 AA           jne 0x1235
128B  C7 46 FE 08 00  mov word ptr [bp - 2], 8
loc_1290:
1290  83 7E FE 01     cmp word ptr [bp - 2], 1
1294  76 25           jbe 0x12bb
1296  FF 76 FE        push word ptr [bp - 2]
1299  9A 6D 07 1A 23  call far 231A:076D
129E  8B F8           mov di, ax
12A0  81 C7 A5 DC     add di, 0xdca5
12A4  1E              push ds
12A5  57              push di
12A6  8B 7E FE        mov di, word ptr [bp - 2]
12A9  81 C7 A5 DC     add di, 0xdca5
12AD  1E              push ds
12AE  57              push di
12AF  6A 01           push 1
12B1  9A 03 02 AC 24  call far 24AC:0203
12B6  FF 4E FE        dec word ptr [bp - 2]
12B9  EB D5           jmp 0x1290
loc_12BB:
12BB  C7 46 FA 01 00  mov word ptr [bp - 6], 1
12C0  EB 03           jmp 0x12c5
loc_12C2:
12C2  FF 46 FA        inc word ptr [bp - 6]
loc_12C5:
12C5  C7 46 FC 01 00  mov word ptr [bp - 4], 1
12CA  EB 03           jmp 0x12cf
loc_12CC:
12CC  FF 46 FC        inc word ptr [bp - 4]
loc_12CF:
12CF  8B 46 FC        mov ax, word ptr [bp - 4]
12D2  8B 7E FA        mov di, word ptr [bp - 6]
12D5  C1 E7 02        shl di, 2
12D8  03 F8           add di, ax
12DA  80 BD 27 03 00  cmp byte ptr [di + 0x327], 0
12DF  74 6C           je 0x134d
12E1  8B 7E FA        mov di, word ptr [bp - 6]
12E4  8A 85 A5 DC     mov al, byte ptr [di - 0x235b]
12E8  50              push ax
12E9  8B 7E FC        mov di, word ptr [bp - 4]
12EC  8A 85 A5 DC     mov al, byte ptr [di - 0x235b]
12F0  50              push ax
12F1  8B 46 FC        mov ax, word ptr [bp - 4]
12F4  8B 7E FA        mov di, word ptr [bp - 6]
12F7  C1 E7 02        shl di, 2
12FA  03 F8           add di, ax
12FC  8A 85 27 03     mov al, byte ptr [di + 0x327]
1300  30 E4           xor ah, ah
1302  8B F8           mov di, ax
1304  8A 85 5B A2     mov al, byte ptr [di - 0x5da5]
1308  50              push ax
1309  6A 06           push 6
130B  6A 00           push 0
130D  9A F9 3A 51 1B  call far 1B51:3AF9
1312  8B 46 FA        mov ax, word ptr [bp - 6]
1315  05 04 00        add ax, 4
1318  8B F8           mov di, ax
131A  8A 85 A5 DC     mov al, byte ptr [di - 0x235b]
131E  50              push ax
131F  8B 46 FC        mov ax, word ptr [bp - 4]
1322  05 04 00        add ax, 4
1325  8B F8           mov di, ax
1327  8A 85 A5 DC     mov al, byte ptr [di - 0x235b]
132B  50              push ax
132C  8B 46 FC        mov ax, word ptr [bp - 4]
132F  8B 7E FA        mov di, word ptr [bp - 6]
1332  C1 E7 02        shl di, 2
1335  03 F8           add di, ax
1337  8A 85 27 03     mov al, byte ptr [di + 0x327]
133B  30 E4           xor ah, ah
133D  8B F8           mov di, ax
133F  8A 85 5B A2     mov al, byte ptr [di - 0x5da5]
1343  50              push ax
1344  6A 06           push 6
1346  6A 00           push 0
1348  9A F9 3A 51 1B  call far 1B51:3AF9
loc_134D:
134D  83 7E FC 04     cmp word ptr [bp - 4], 4
1351  74 03           je 0x1356
1353  E9 76 FF        jmp 0x12cc
loc_1356:
1356  83 7E FA 04     cmp word ptr [bp - 6], 4
135A  74 03           je 0x135f
135C  E9 63 FF        jmp 0x12c2
loc_135F:
135F  C7 46 FA 01 00  mov word ptr [bp - 6], 1
1364  EB 03           jmp 0x1369
loc_1366:
1366  FF 46 FA        inc word ptr [bp - 6]
loc_1369:
1369  8B 7E FA        mov di, word ptr [bp - 6]
136C  8A 85 A5 DC     mov al, byte ptr [di - 0x235b]
1370  30 E4           xor ah, ah
1372  50              push ax
1373  6A 04           push 4
1375  9A 7C 4A 51 1B  call far 1B51:4A7C
137A  83 7E FA 08     cmp word ptr [bp - 6], 8
137E  75 E6           jne 0x1366
1380  C9              leave
1381  C2 02 00        ret 2

; ---- routine 06E4:1384  (found by: far)
sub_1384:
1384  C8 0A 00 00     enter 0xa, 0
1388  80 7E 06 06     cmp byte ptr [bp + 6], 6
138C  75 09           jne 0x1397
138E  83 7E 08 14     cmp word ptr [bp + 8], 0x14
1392  74 03           je 0x1397
1394  E9 F3 00        jmp 0x148a
loc_1397:
1397  8B 46 08        mov ax, word ptr [bp + 8]
139A  3D 14 00        cmp ax, 0x14
139D  75 0C           jne 0x13ab
139F  6A 10           push 0x10
13A1  6A 0A           push 0xa
13A3  6A 0C           push 0xc
13A5  55              push bp
13A6  E8 D8 FC        call 0x1081
13A9  EB 31           jmp 0x13dc
loc_13AB:
13AB  3D 1B 00        cmp ax, 0x1b
13AE  75 0C           jne 0x13bc
13B0  6A 08           push 8
13B2  6A 14           push 0x14
13B4  6A 16           push 0x16
13B6  55              push bp
13B7  E8 C7 FC        call 0x1081
13BA  EB 20           jmp 0x13dc
loc_13BC:
13BC  3D 27 00        cmp ax, 0x27
13BF  75 0C           jne 0x13cd
13C1  6A 04           push 4
13C3  6A 1B           push 0x1b
13C5  6A 21           push 0x21
13C7  55              push bp
13C8  E8 B6 FC        call 0x1081
13CB  EB 0F           jmp 0x13dc
loc_13CD:
13CD  3D 30 00        cmp ax, 0x30
13D0  75 0A           jne 0x13dc
13D2  6A 02           push 2
13D4  6A 27           push 0x27
13D6  6A 2B           push 0x2b
13D8  55              push bp
13D9  E8 A5 FC        call 0x1081
loc_13DC:
13DC  83 7E 08 30     cmp word ptr [bp + 8], 0x30
13E0  75 17           jne 0x13f9
13E2  80 7E 06 07     cmp byte ptr [bp + 6], 7
13E6  75 11           jne 0x13f9
13E8  FF 76 FE        push word ptr [bp - 2]
13EB  FF 76 08        push word ptr [bp + 8]
13EE  8A 46 06        mov al, byte ptr [bp + 6]
13F1  50              push ax
13F2  6A 01           push 1
13F4  E8 AC F4        call 0x8a3
13F7  EB 0F           jmp 0x1408
loc_13F9:
13F9  FF 76 FE        push word ptr [bp - 2]
13FC  FF 76 08        push word ptr [bp + 8]
13FF  8A 46 06        mov al, byte ptr [bp + 6]
1402  50              push ax
1403  6A 00           push 0
1405  E8 9B F4        call 0x8a3
loc_1408:
1408  83 7E 08 30     cmp word ptr [bp + 8], 0x30
140C  75 06           jne 0x1414
140E  80 7E 06 08     cmp byte ptr [bp + 6], 8
1412  75 74           jne 0x1488
loc_1414:
1414  8B 46 FE        mov ax, word ptr [bp - 2]
1417  89 46 FA        mov word ptr [bp - 6], ax
141A  B8 01 00        mov ax, 1
141D  3B 46 FA        cmp ax, word ptr [bp - 6]
1420  77 66           ja 0x1488
1422  89 46 FC        mov word ptr [bp - 4], ax
1425  EB 03           jmp 0x142a
loc_1427:
1427  FF 46 FC        inc word ptr [bp - 4]
loc_142A:
142A  8B 46 08        mov ax, word ptr [bp + 8]
142D  8B F0           mov si, ax
142F  D1 E0           shl ax, 1
1431  01 F0           add ax, si
1433  8B D0           mov dx, ax
1435  8B 7E FC        mov di, word ptr [bp - 4]
1438  8A 85 FB D4     mov al, byte ptr [di - 0x2b05]
143C  30 E4           xor ah, ah
143E  69 C0 AE 00     imul ax, ax, 0xae
1442  C4 3E CA D7     les di, ptr [0xd7ca]
1446  03 F8           add di, ax
1448  03 FA           add di, dx
144A  81 C7 4F FF     add di, 0xff4f
144E  89 7E F6        mov word ptr [bp - 0xa], di
1451  8C 46 F8        mov word ptr [bp - 8], es
1454  26 8A 45 02     mov al, byte ptr es:[di + 2]
1458  24 0F           and al, 0xf
145A  08 C0           or al, al
145C  75 22           jne 0x1480
145E  8B 7E FC        mov di, word ptr [bp - 4]
1461  8A 85 FB D4     mov al, byte ptr [di - 0x2b05]
1465  50              push ax
1466  C4 7E F6        les di, ptr [bp - 0xa]
1469  26 8A 45 01     mov al, byte ptr es:[di + 1]
146D  50              push ax
146E  FF 76 08        push word ptr [bp + 8]
1471  E8 BA FB        call 0x102e
1474  50              push ax
1475  8A 46 06        mov al, byte ptr [bp + 6]
1478  50              push ax
1479  6A 01           push 1
147B  9A F9 3A 51 1B  call far 1B51:3AF9
loc_1480:
1480  8B 46 FC        mov ax, word ptr [bp - 4]
1483  3B 46 FA        cmp ax, word ptr [bp - 6]
1486  75 9F           jne 0x1427
loc_1488:
1488  EB 10           jmp 0x149a
loc_148A:
148A  83 7E 08 1B     cmp word ptr [bp + 8], 0x1b
148E  75 06           jne 0x1496
1490  55              push bp
1491  E8 77 FD        call 0x120b
1494  EB 04           jmp 0x149a
loc_1496:
1496  55              push bp
1497  E8 E2 FC        call 0x117c
loc_149A:
149A  C6 06 D6 02 01  mov byte ptr [0x2d6], 1
149F  8A 46 06        mov al, byte ptr [bp + 6]
14A2  50              push ax
14A3  6A 01           push 1
14A5  0E              push cs
14A6  E8 88 06        call 0x1b31
14A9  C6 06 D6 02 00  mov byte ptr [0x2d6], 0
14AE  C4 3E D2 D7     les di, ptr [0xd7d2]
14B2  26 8A 45 03     mov al, byte ptr es:[di + 3]
14B6  30 E4           xor ah, ah
14B8  89 46 FA        mov word ptr [bp - 6], ax
14BB  B8 01 00        mov ax, 1
14BE  3B 46 FA        cmp ax, word ptr [bp - 6]
14C1  77 1F           ja 0x14e2
14C3  89 46 FC        mov word ptr [bp - 4], ax
14C6  EB 03           jmp 0x14cb
loc_14C8:
14C8  FF 46 FC        inc word ptr [bp - 4]
loc_14CB:
14CB  FF 76 FC        push word ptr [bp - 4]
14CE  FF 76 08        push word ptr [bp + 8]
14D1  8A 46 06        mov al, byte ptr [bp + 6]
14D4  50              push ax
14D5  9A 11 34 51 1B  call far 1B51:3411
14DA  8B 46 FC        mov ax, word ptr [bp - 4]
14DD  3B 46 FA        cmp ax, word ptr [bp - 6]
14E0  75 E6           jne 0x14c8
loc_14E2:
14E2  C9              leave
14E3  CA 04 00        retf 4

; ---- routine 06E4:14E6  (found by: call)
sub_14E6:
14E6  C8 06 01 00     enter 0x106, 0
14EA  6A 00           push 0
14EC  6A 01           push 1
14EE  6A 50           push 0x50
14F0  6A 01           push 1
14F2  6A 18           push 0x18
14F4  BF 5C DD        mov di, 0xdd5c
14F7  1E              push ds
14F8  57              push di
14F9  9A 07 05 1A 23  call far 231A:0507
14FE  6A 07           push 7
1500  8D BE FA FE     lea di, [bp - 0x106]
1504  16              push ss
1505  57              push di
1506  8A 46 04        mov al, byte ptr [bp + 4]
1509  50              push ax
150A  8A 46 08        mov al, byte ptr [bp + 8]
150D  50              push ax
150E  9A 11 12 51 1B  call far 1B51:1211
1513  6A 02           push 2
1515  6A 01           push 1
1517  BF 5C DD        mov di, 0xdd5c
151A  1E              push ds
151B  57              push di
151C  9A 1B 04 1A 23  call far 231A:041B
1521  C7 46 FC 05 00  mov word ptr [bp - 4], 5
1526  C7 46 FA 13 00  mov word ptr [bp - 6], 0x13
152B  C7 46 FE 01 00  mov word ptr [bp - 2], 1
1530  EB 03           jmp 0x1535
loc_1532:
1532  FF 46 FE        inc word ptr [bp - 2]
loc_1535:
1535  8B 46 08        mov ax, word ptr [bp + 8]
1538  8B F0           mov si, ax
153A  D1 E0           shl ax, 1
153C  01 F0           add ax, si
153E  8B D0           mov dx, ax
1540  8B 7E FE        mov di, word ptr [bp - 2]
1543  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
1547  30 E4           xor ah, ah
1549  69 C0 AE 00     imul ax, ax, 0xae
154D  C4 3E CA D7     les di, ptr [0xd7ca]
1551  03 F8           add di, ax
1553  03 FA           add di, dx
1555  81 C7 4F FF     add di, 0xff4f
1559  26 80 7D 01 00  cmp byte ptr es:[di + 1], 0
155E  74 60           je 0x15c0
1560  26 8A 45 02     mov al, byte ptr es:[di + 2]
1564  24 0F           and al, 0xf
1566  3C 01           cmp al, 1
1568  75 56           jne 0x15c0
156A  26 8A 05        mov al, byte ptr es:[di]
156D  3A 46 04        cmp al, byte ptr [bp + 4]
1570  75 4E           jne 0x15c0
1572  FF 46 FC        inc word ptr [bp - 4]
1575  83 7E FC 15     cmp word ptr [bp - 4], 0x15
1579  76 0A           jbe 0x1585
157B  C7 46 FC 06 00  mov word ptr [bp - 4], 6
1580  C7 46 FA 3B 00  mov word ptr [bp - 6], 0x3b
loc_1585:
1585  8B 7E FE        mov di, word ptr [bp - 2]
1588  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
158C  30 E4           xor ah, ah
158E  50              push ax
158F  FF 76 08        push word ptr [bp + 8]
1592  FF 76 FC        push word ptr [bp - 4]
1595  FF 76 FA        push word ptr [bp - 6]
1598  9A DD 15 51 1B  call far 1B51:15DD
159D  83 7E 06 00     cmp word ptr [bp + 6], 0
15A1  74 1D           je 0x15c0
15A3  8B 7E FE        mov di, word ptr [bp - 2]
15A6  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
15AA  30 E4           xor ah, ah
15AC  50              push ax
15AD  FF 76 08        push word ptr [bp + 8]
15B0  FF 76 06        push word ptr [bp + 6]
15B3  8D 7E FC        lea di, [bp - 4]
15B6  16              push ss
15B7  57              push di
15B8  FF 76 FA        push word ptr [bp - 6]
15BB  9A 1B 18 51 1B  call far 1B51:181B
loc_15C0:
15C0  81 7E FE B0 00  cmp word ptr [bp - 2], 0xb0
15C5  74 03           je 0x15ca
15C7  E9 68 FF        jmp 0x1532
loc_15CA:
15CA  C4 3E 5C DD     les di, ptr [0xdd5c]
15CE  06              push es
15CF  57              push di
15D0  C4 3E 58 DD     les di, ptr [0xdd58]
15D4  06              push es
15D5  57              push di
15D6  68 A0 0F        push 0xfa0
15D9  9A 12 0A B9 26  call far 26B9:0A12
15DE  C9              leave
15DF  C2 06 00        ret 6

; ---- routine 06E4:15E2  (found by: far)
sub_15E2:
15E2  55              push bp
15E3  89 E5           mov bp, sp
15E5  80 7E 06 00     cmp byte ptr [bp + 6], 0
15E9  74 0F           je 0x15fa
15EB  BF F4 4E        mov di, 0x4ef4
15EE  1E              push ds
15EF  57              push di
15F0  BF 5C DD        mov di, 0xdd5c
15F3  1E              push ds
15F4  57              push di
15F5  9A 2F 05 1A 23  call far 231A:052F
loc_15FA:
15FA  FF 76 0A        push word ptr [bp + 0xa]
15FD  6A 00           push 0
15FF  8A 46 08        mov al, byte ptr [bp + 8]
1602  50              push ax
1603  E8 E0 FE        call 0x14e6
1606  80 7E 06 00     cmp byte ptr [bp + 6], 0
160A  74 05           je 0x1611
160C  9A 9B 09 1A 23  call far 231A:099B
loc_1611:
1611  C9              leave
1612  CA 06 00        retf 6

; ---- routine 06E4:1615  (found by: far)
sub_1615:
1615  C8 06 00 00     enter 6, 0
1619  80 7E 06 00     cmp byte ptr [bp + 6], 0
161D  74 0F           je 0x162e
161F  BF F4 4E        mov di, 0x4ef4
1622  1E              push ds
1623  57              push di
1624  BF 5C DD        mov di, 0xdd5c
1627  1E              push ds
1628  57              push di
1629  9A 2F 05 1A 23  call far 231A:052F
loc_162E:
162E  6A 0A           push 0xa
1630  6A 0C           push 0xc
1632  8A 46 08        mov al, byte ptr [bp + 8]
1635  50              push ax
1636  E8 AD FE        call 0x14e6
1639  80 7E 06 00     cmp byte ptr [bp + 6], 0
163D  75 02           jne 0x1641
163F  EB 0B           jmp 0x164c
loc_1641:
1641  0E              push cs
1642  E8 BB E9        call 0
1645  80 3E 88 DE 0D  cmp byte ptr [0xde88], 0xd
164A  74 E2           je 0x162e
loc_164C:
164C  C9              leave
164D  CA 04 00        retf 4

; ---- routine 06E4:1650  (found by: call)
sub_1650:
1650  C8 06 00 00     enter 6, 0
1654  C7 46 FE 01 00  mov word ptr [bp - 2], 1
1659  EB 03           jmp 0x165e
loc_165B:
165B  FF 46 FE        inc word ptr [bp - 2]
loc_165E:
165E  8B 46 04        mov ax, word ptr [bp + 4]
1661  8B F0           mov si, ax
1663  D1 E0           shl ax, 1
1665  01 F0           add ax, si
1667  8B D0           mov dx, ax
1669  8B 7E FE        mov di, word ptr [bp - 2]
166C  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
1670  30 E4           xor ah, ah
1672  69 C0 AE 00     imul ax, ax, 0xae
1676  C4 3E CA D7     les di, ptr [0xd7ca]
167A  03 F8           add di, ax
167C  03 FA           add di, dx
167E  81 C7 4F FF     add di, 0xff4f
1682  89 7E FA        mov word ptr [bp - 6], di
1685  8C 46 FC        mov word ptr [bp - 4], es
1688  26 8A 45 02     mov al, byte ptr es:[di + 2]
168C  24 0F           and al, 0xf
168E  3C 02           cmp al, 2
1690  75 4F           jne 0x16e1
1692  8B 46 04        mov ax, word ptr [bp + 4]
1695  8B F0           mov si, ax
1697  D1 E0           shl ax, 1
1699  01 F0           add ax, si
169B  8B D0           mov dx, ax
169D  26 8A 45 01     mov al, byte ptr es:[di + 1]
16A1  30 E4           xor ah, ah
16A3  69 C0 AE 00     imul ax, ax, 0xae
16A7  C4 3E CA D7     les di, ptr [0xd7ca]
16AB  03 F8           add di, ax
16AD  03 FA           add di, dx
16AF  26 8A 85 51 FF  mov al, byte ptr es:[di - 0xaf]
16B4  24 F0           and al, 0xf0
16B6  30 E4           xor ah, ah
16B8  40              inc ax
16B9  40              inc ax
16BA  8A C8           mov cl, al
16BC  8B 46 04        mov ax, word ptr [bp + 4]
16BF  8B F0           mov si, ax
16C1  D1 E0           shl ax, 1
16C3  01 F0           add ax, si
16C5  8B D0           mov dx, ax
16C7  C4 7E FA        les di, ptr [bp - 6]
16CA  26 8A 45 01     mov al, byte ptr es:[di + 1]
16CE  30 E4           xor ah, ah
16D0  69 C0 AE 00     imul ax, ax, 0xae
16D4  C4 3E CA D7     les di, ptr [0xd7ca]
16D8  03 F8           add di, ax
16DA  03 FA           add di, dx
16DC  26 88 8D 51 FF  mov byte ptr es:[di - 0xaf], cl
loc_16E1:
16E1  81 7E FE B0 00  cmp word ptr [bp - 2], 0xb0
16E6  74 03           je 0x16eb
16E8  E9 70 FF        jmp 0x165b
loc_16EB:
16EB  C9              leave
16EC  C2 02 00        ret 2

