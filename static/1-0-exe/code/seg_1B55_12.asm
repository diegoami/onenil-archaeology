; 1-0.EXE (One-Nil 96), code segment 1B55 (image offsets 1B550..2315F), part 12 of 12
; packed 1-0.EXE sha256 89ff9c5f238f24e81a0c2440a46cdd8997280a65fc3cc3d97cb974f55280a80a (LZEXE 0.91)
; unpacked (tools/static/unlzexe.py) sha256 887ed2a92767950e5309b2052409f875668605939b69e00737aa3047022b9f51
; tool: capstone 5.0.9 (pip package; core library 5.0.1280) (CS_ARCH_X86, CS_MODE_16), recursive descent from the entry point, far calls and near calls/jumps, then routine prologues (55 89 E5 / 55 8B EC / C8 iw 00) in what remains; tools/static/listing.py
; addresses are SEGMENT:OFFSET with SEGMENT the image paragraph before relocation; image offset = SEGMENT*16+OFFSET
; ---- routine 1B55:7826  (found by: call)
sub_7826:
7826  C8 06 00 00     enter 6, 0
782A  8B 46 08        mov ax, word ptr [bp + 8]
782D  89 46 FE        mov word ptr [bp - 2], ax
7830  8B 46 06        mov ax, word ptr [bp + 6]
7833  89 46 FC        mov word ptr [bp - 4], ax
7836  8B 46 08        mov ax, word ptr [bp + 8]
7839  03 46 06        add ax, word ptr [bp + 6]
783C  D1 E8           shr ax, 1
783E  8B F8           mov di, ax
7840  8A 85 FB D4     mov al, byte ptr [di - 0x2b05]
7844  30 E4           xor ah, ah
7846  C1 E0 04        shl ax, 4
7849  C4 3E B2 D7     les di, ptr [0xd7b2]
784D  03 F8           add di, ax
784F  81 C7 F0 FF     add di, 0xfff0
7853  06              push es
7854  57              push di
7855  BF 92 D7        mov di, 0xd792
7858  1E              push ds
7859  57              push di
785A  6A 0F           push 0xf
785C  9A 6D 0B C9 26  call far 26C9:0B6D
loc_7861:
7861  8B 7E FE        mov di, word ptr [bp - 2]
7864  8A 85 FB D4     mov al, byte ptr [di - 0x2b05]
7868  30 E4           xor ah, ah
786A  C1 E0 04        shl ax, 4
786D  C4 3E B2 D7     les di, ptr [0xd7b2]
7871  03 F8           add di, ax
7873  81 C7 F0 FF     add di, 0xfff0
7877  06              push es
7878  57              push di
7879  BF 92 D7        mov di, 0xd792
787C  1E              push ds
787D  57              push di
787E  9A 44 0C C9 26  call far 26C9:0C44
7883  73 05           jae 0x788a
7885  FF 46 FE        inc word ptr [bp - 2]
7888  EB D7           jmp 0x7861
loc_788A:
788A  BF 92 D7        mov di, 0xd792
788D  1E              push ds
788E  57              push di
788F  8B 7E FC        mov di, word ptr [bp - 4]
7892  8A 85 FB D4     mov al, byte ptr [di - 0x2b05]
7896  30 E4           xor ah, ah
7898  C1 E0 04        shl ax, 4
789B  C4 3E B2 D7     les di, ptr [0xd7b2]
789F  03 F8           add di, ax
78A1  81 C7 F0 FF     add di, 0xfff0
78A5  06              push es
78A6  57              push di
78A7  9A 44 0C C9 26  call far 26C9:0C44
78AC  73 05           jae 0x78b3
78AE  FF 4E FC        dec word ptr [bp - 4]
78B1  EB D7           jmp 0x788a
loc_78B3:
78B3  8B 46 FE        mov ax, word ptr [bp - 2]
78B6  3B 46 FC        cmp ax, word ptr [bp - 4]
78B9  77 2A           ja 0x78e5
78BB  8B 7E FE        mov di, word ptr [bp - 2]
78BE  8A 85 FB D4     mov al, byte ptr [di - 0x2b05]
78C2  30 E4           xor ah, ah
78C4  89 46 FA        mov word ptr [bp - 6], ax
78C7  8B 7E FC        mov di, word ptr [bp - 4]
78CA  8A 85 FB D4     mov al, byte ptr [di - 0x2b05]
78CE  8B 7E FE        mov di, word ptr [bp - 2]
78D1  88 85 FB D4     mov byte ptr [di - 0x2b05], al
78D5  8A 46 FA        mov al, byte ptr [bp - 6]
78D8  8B 7E FC        mov di, word ptr [bp - 4]
78DB  88 85 FB D4     mov byte ptr [di - 0x2b05], al
78DF  FF 46 FE        inc word ptr [bp - 2]
78E2  FF 4E FC        dec word ptr [bp - 4]
loc_78E5:
78E5  8B 46 FE        mov ax, word ptr [bp - 2]
78E8  3B 46 FC        cmp ax, word ptr [bp - 4]
78EB  77 03           ja 0x78f0
78ED  E9 71 FF        jmp 0x7861
loc_78F0:
78F0  8B 46 08        mov ax, word ptr [bp + 8]
78F3  3B 46 FC        cmp ax, word ptr [bp - 4]
78F6  73 0D           jae 0x7905
78F8  FF 76 08        push word ptr [bp + 8]
78FB  FF 76 FC        push word ptr [bp - 4]
78FE  8B 7E 04        mov di, word ptr [bp + 4]
7901  57              push di
7902  E8 21 FF        call 0x7826
loc_7905:
7905  8B 46 FE        mov ax, word ptr [bp - 2]
7908  3B 46 06        cmp ax, word ptr [bp + 6]
790B  73 0D           jae 0x791a
790D  FF 76 FE        push word ptr [bp - 2]
7910  FF 76 06        push word ptr [bp + 6]
7913  8B 7E 04        mov di, word ptr [bp + 4]
7916  57              push di
7917  E8 0C FF        call 0x7826
loc_791A:
791A  C9              leave
791B  C2 06 00        ret 6

; ---- routine 1B55:791E  (found by: call, far)
sub_791E:
791E  C8 04 00 00     enter 4, 0
7922  FF 76 06        push word ptr [bp + 6]
7925  0E              push cs
7926  E8 F1 C8        call 0x421a
7929  C7 46 FE 01 00  mov word ptr [bp - 2], 1
792E  EB 03           jmp 0x7933
loc_7930:
7930  FF 46 FE        inc word ptr [bp - 2]
loc_7933:
7933  8B 7E FE        mov di, word ptr [bp - 2]
7936  8A 85 27 13     mov al, byte ptr [di + 0x1327]
793A  30 E4           xor ah, ah
793C  50              push ax
793D  8B 7E FE        mov di, word ptr [bp - 2]
7940  8A 85 27 13     mov al, byte ptr [di + 0x1327]
7944  30 E4           xor ah, ah
7946  05 07 00        add ax, 7
7949  50              push ax
794A  55              push bp
794B  E8 D8 FE        call 0x7826
794E  83 7E FE 05     cmp word ptr [bp - 2], 5
7952  75 DC           jne 0x7930
7954  C9              leave
7955  CA 02 00        retf 2
; data (not reached as code), 2 bytes
7958                  db 01 2E   ; ..

; ---- routine 1B55:795A  (found by: call, far)
sub_795A:
795A  C8 00 01 00     enter 0x100, 0
795E  8D BE 00 FF     lea di, [bp - 0x100]
7962  16              push ss
7963  57              push di
7964  BF 31 D7        mov di, 0xd731
7967  1E              push ds
7968  57              push di
7969  6A 01           push 1
796B  BF 58 79        mov di, 0x7958
796E  0E              push cs
796F  57              push di
7970  BF 31 D7        mov di, 0xd731
7973  1E              push ds
7974  57              push di
7975  9A FE 0B C9 26  call far 26C9:0BFE
797A  48              dec ax
797B  50              push ax
797C  9A 91 0B C9 26  call far 26C9:0B91
7981  C4 7E 06        les di, ptr [bp + 6]
7984  06              push es
7985  57              push di
7986  6A 0F           push 0xf
7988  9A 6D 0B C9 26  call far 26C9:0B6D
798D  C9              leave
798E  CB              retf
; data (not reached as code), 2 bytes
798F                  db 01 2E   ; ..

; ---- routine 1B55:7991  (found by: far)
sub_7991:
7991  C8 A8 02 00     enter 0x2a8, 0
7995  C4 3E D2 D7     les di, ptr [0xd7d2]
7999  89 BE 58 FF     mov word ptr [bp - 0xa8], di
799D  8C 86 5A FF     mov word ptr [bp - 0xa6], es
79A1  26 FE 0D        dec byte ptr es:[di]
79A4  BF 3E D7        mov di, 0xd73e
79A7  1E              push ds
79A8  57              push di
79A9  8D BE 5C FF     lea di, [bp - 0xa4]
79AD  16              push ss
79AE  57              push di
79AF  6A 50           push 0x50
79B1  9A 6D 0B C9 26  call far 26C9:0B6D
79B6  BF EC D6        mov di, 0xd6ec
79B9  1E              push ds
79BA  57              push di
79BB  8D 7E AE        lea di, [bp - 0x52]
79BE  16              push ss
79BF  57              push di
79C0  6A 52           push 0x52
79C2  9A 12 0A C9 26  call far 26C9:0A12
79C7  8D BE 58 FE     lea di, [bp - 0x1a8]
79CB  16              push ss
79CC  57              push di
79CD  0E              push cs
79CE  E8 89 FF        call 0x795a
79D1  BF 8F 79        mov di, 0x798f
79D4  0E              push cs
79D5  57              push di
79D6  9A D2 0B C9 26  call far 26C9:0BD2
79DB  8D BE 58 FD     lea di, [bp - 0x2a8]
79DF  16              push ss
79E0  57              push di
79E1  C4 BE 58 FF     les di, ptr [bp - 0xa8]
79E5  26 8A 45 01     mov al, byte ptr es:[di + 1]
79E9  30 E4           xor ah, ah
79EB  03 06 DA DC     add ax, word ptr [0xdcda]
79EF  48              dec ax
79F0  50              push ax
79F1  0E              push cs
79F2  E8 CC 86        call 0xc1
79F5  9A D2 0B C9 26  call far 26C9:0BD2
79FA  BF 31 D7        mov di, 0xd731
79FD  1E              push ds
79FE  57              push di
79FF  6A 0C           push 0xc
7A01  9A 6D 0B C9 26  call far 26C9:0B6D
7A06  8D BE 58 FE     lea di, [bp - 0x1a8]
7A0A  16              push ss
7A0B  57              push di
7A0C  BF EC D6        mov di, 0xd6ec
7A0F  1E              push ds
7A10  57              push di
7A11  9A 53 0B C9 26  call far 26C9:0B53
7A16  BF 31 D7        mov di, 0xd731
7A19  1E              push ds
7A1A  57              push di
7A1B  9A D2 0B C9 26  call far 26C9:0BD2
7A20  BF 3E D7        mov di, 0xd73e
7A23  1E              push ds
7A24  57              push di
7A25  6A 50           push 0x50
7A27  9A 6D 0B C9 26  call far 26C9:0B6D
7A2C  0E              push cs
7A2D  E8 B2 93        call 0xde2
7A30  8D 7E AE        lea di, [bp - 0x52]
7A33  16              push ss
7A34  57              push di
7A35  BF EC D6        mov di, 0xd6ec
7A38  1E              push ds
7A39  57              push di
7A3A  6A 52           push 0x52
7A3C  9A 12 0A C9 26  call far 26C9:0A12
7A41  8D BE 5C FF     lea di, [bp - 0xa4]
7A45  16              push ss
7A46  57              push di
7A47  BF 3E D7        mov di, 0xd73e
7A4A  1E              push ds
7A4B  57              push di
7A4C  6A 50           push 0x50
7A4E  9A 6D 0B C9 26  call far 26C9:0B6D
7A53  C4 BE 58 FF     les di, ptr [bp - 0xa8]
7A57  26 C6 05 3A     mov byte ptr es:[di], 0x3a
7A5B  C9              leave
7A5C  CB              retf

; ---- routine 1B55:7A5D  (found by: far)
sub_7A5D:
7A5D  C8 B6 01 00     enter 0x1b6, 0
7A61  8C D3           mov bx, ss
7A63  8E C3           mov es, bx
7A65  8C DB           mov bx, ds
7A67  FC              cld
7A68  8D 7E F2        lea di, [bp - 0xe]
7A6B  C5 76 06        lds si, ptr [bp + 6]
7A6E  AC              lodsb al, byte ptr [si]
7A6F  3C 0C           cmp al, 0xc
7A71  72 02           jb 0x7a75
7A73  B0 0C           mov al, 0xc
loc_7A75:
7A75  AA              stosb byte ptr es:[di], al
7A76  91              xchg cx, ax
7A77  30 ED           xor ch, ch
7A79  F3 A4           rep movsb byte ptr es:[di], byte ptr [si]
7A7B  8E DB           mov ds, bx
7A7D  C4 3E D2 D7     les di, ptr [0xd7d2]
7A81  BF 3E D7        mov di, 0xd73e
7A84  1E              push ds
7A85  57              push di
7A86  8D BE 4E FF     lea di, [bp - 0xb2]
7A8A  16              push ss
7A8B  57              push di
7A8C  6A 50           push 0x50
7A8E  9A 6D 0B C9 26  call far 26C9:0B6D
7A93  BF EC D6        mov di, 0xd6ec
7A96  1E              push ds
7A97  57              push di
7A98  8D 7E A0        lea di, [bp - 0x60]
7A9B  16              push ss
7A9C  57              push di
7A9D  6A 52           push 0x52
7A9F  9A 12 0A C9 26  call far 26C9:0A12
7AA4  8D 7E F2        lea di, [bp - 0xe]
7AA7  16              push ss
7AA8  57              push di
7AA9  BF 31 D7        mov di, 0xd731
7AAC  1E              push ds
7AAD  57              push di
7AAE  6A 0C           push 0xc
7AB0  9A 6D 0B C9 26  call far 26C9:0B6D
7AB5  8D BE 4A FE     lea di, [bp - 0x1b6]
7AB9  16              push ss
7ABA  57              push di
7ABB  BF EC D6        mov di, 0xd6ec
7ABE  1E              push ds
7ABF  57              push di
7AC0  9A 53 0B C9 26  call far 26C9:0B53
7AC5  BF 31 D7        mov di, 0xd731
7AC8  1E              push ds
7AC9  57              push di
7ACA  9A D2 0B C9 26  call far 26C9:0BD2
7ACF  BF 3E D7        mov di, 0xd73e
7AD2  1E              push ds
7AD3  57              push di
7AD4  6A 50           push 0x50
7AD6  9A 6D 0B C9 26  call far 26C9:0B6D
loc_7ADB:
7ADB  6A 01           push 1
7ADD  6A 00           push 0
7ADF  0E              push cs
7AE0  E8 57 91        call 0xc3a
7AE3  08 C0           or al, al
7AE5  75 0B           jne 0x7af2
7AE7  6A 00           push 0
7AE9  9A 94 11 2A 23  call far 232A:1194
7AEE  08 C0           or al, al
7AF0  75 E9           jne 0x7adb
loc_7AF2:
7AF2  8D 7E A0        lea di, [bp - 0x60]
7AF5  16              push ss
7AF6  57              push di
7AF7  BF EC D6        mov di, 0xd6ec
7AFA  1E              push ds
7AFB  57              push di
7AFC  6A 52           push 0x52
7AFE  9A 12 0A C9 26  call far 26C9:0A12
7B03  8D BE 4E FF     lea di, [bp - 0xb2]
7B07  16              push ss
7B08  57              push di
7B09  BF 3E D7        mov di, 0xd73e
7B0C  1E              push ds
7B0D  57              push di
7B0E  6A 50           push 0x50
7B10  9A 6D 0B C9 26  call far 26C9:0B6D
7B15  C9              leave
7B16  CA 04 00        retf 4

; ---- routine 1B55:7B19  (found by: far)
sub_7B19:
7B19  C8 0A 00 00     enter 0xa, 0
7B1D  8B 46 08        mov ax, word ptr [bp + 8]
7B20  C1 E0 03        shl ax, 3
7B23  C4 3E BA D7     les di, ptr [0xd7ba]
7B27  03 F8           add di, ax
7B29  89 7E FA        mov word ptr [bp - 6], di
7B2C  8C 46 FC        mov word ptr [bp - 4], es
7B2F  6B 46 06 3E     imul ax, word ptr [bp + 6], 0x3e
7B33  C4 3E C2 D7     les di, ptr [0xd7c2]
7B37  03 F8           add di, ax
7B39  81 C7 C2 FF     add di, 0xffc2
7B3D  FF 76 06        push word ptr [bp + 6]
7B40  0E              push cs
7B41  E8 17 AB        call 0x265b
7B44  8B D0           mov dx, ax
7B46  C4 7E FA        les di, ptr [bp - 6]
7B49  26 8A 45 04     mov al, byte ptr es:[di + 4]
7B4D  30 E4           xor ah, ah
7B4F  05 B0 FF        add ax, 0xffb0
7B52  3B C2           cmp ax, dx
7B54  B0 00           mov al, 0
7B56  7E 01           jle 0x7b59
7B58  40              inc ax
loc_7B59:
7B59  88 46 FF        mov byte ptr [bp - 1], al
7B5C  8A 46 FF        mov al, byte ptr [bp - 1]
7B5F  C9              leave
7B60  CA 04 00        retf 4

; ---- routine 1B55:7B63  (found by: far)
sub_7B63:
7B63  C8 06 00 00     enter 6, 0
7B67  8B 46 08        mov ax, word ptr [bp + 8]
7B6A  C1 E0 03        shl ax, 3
7B6D  C4 3E BA D7     les di, ptr [0xd7ba]
7B71  03 F8           add di, ax
7B73  89 7E FA        mov word ptr [bp - 6], di
7B76  8C 46 FC        mov word ptr [bp - 4], es
7B79  6B 46 06 3E     imul ax, word ptr [bp + 6], 0x3e
7B7D  C4 3E C2 D7     les di, ptr [0xd7c2]
7B81  03 F8           add di, ax
7B83  26 8A 45 F5     mov al, byte ptr es:[di - 0xb]
7B87  30 E4           xor ah, ah
7B89  8B D0           mov dx, ax
7B8B  B8 B1 00        mov ax, 0xb1
7B8E  2B C2           sub ax, dx
7B90  8B D0           mov dx, ax
7B92  C4 7E FA        les di, ptr [bp - 6]
7B95  26 8A 45 04     mov al, byte ptr es:[di + 4]
7B99  30 E4           xor ah, ah
7B9B  05 A0 FF        add ax, 0xffa0
7B9E  3B C2           cmp ax, dx
7BA0  B0 00           mov al, 0
7BA2  7E 01           jle 0x7ba5
7BA4  40              inc ax
loc_7BA5:
7BA5  88 46 FF        mov byte ptr [bp - 1], al
7BA8  8A 46 FF        mov al, byte ptr [bp - 1]
7BAB  C9              leave
7BAC  CA 04 00        retf 4
; data (not reached as code), 47 bytes
7BAF                  pstr 'save1.1-0'
7BB9                  pstr 'Type install to install to hard disk'

; ---- routine 1B55:7BDE  (found by: far)
sub_7BDE:
7BDE  55              push bp
7BDF  89 E5           mov bp, sp
7BE1  BF AF 7B        mov di, 0x7baf
7BE4  0E              push cs
7BE5  57              push di
7BE6  BF 31 D7        mov di, 0xd731
7BE9  1E              push ds
7BEA  57              push di
7BEB  6A 0C           push 0xc
7BED  9A 6D 0B C9 26  call far 26C9:0B6D
7BF2  9A FA 13 BC 24  call far 24BC:13FA
7BF7  08 C0           or al, al
7BF9  74 11           je 0x7c0c
7BFB  BF B9 7B        mov di, 0x7bb9
7BFE  0E              push cs
7BFF  57              push di
7C00  9A 02 07 BC 24  call far 24BC:0702
7C05  31 C0           xor ax, ax
7C07  9A 16 01 C9 26  call far 26C9:0116
loc_7C0C:
7C0C  C9              leave
7C0D  CB              retf
; data (not reached as code), 2 bytes
7C0E                  db 00 00   ; ..
