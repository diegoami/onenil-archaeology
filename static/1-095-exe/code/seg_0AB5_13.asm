; 1-095.EXE (One-Nil 95), code segment 0AB5 (image offsets 0AB50..1993F), part 13 of 22
; packed 1-095.EXE sha256 f659fb2d334500d6901fc8d6a0f06c85c0ccda2eb4a3035ae3bb0a0004d79192 (LZEXE 0.91)
; unpacked (tools/static/unlzexe.py) sha256 8df646e017e0965a5d90a58181ca764219ad847833aad0b6cb58fc53372bfb2c
; tool: capstone 5.0.9 (pip package; core library 5.0.1280) (CS_ARCH_X86, CS_MODE_16), recursive descent from the entry point, far calls and near calls/jumps, then routine prologues (55 89 E5 / 55 8B EC / C8 iw 00) in what remains; tools/static/listing.py
; addresses are SEGMENT:OFFSET with SEGMENT the image paragraph before relocation; image offset = SEGMENT*16+OFFSET
; ---- routine 0AB5:78B7  (found by: call)
sub_78B7:
78B7  C8 02 01 00     enter 0x102, 0
78BB  C4 3E D2 D7     les di, ptr [0xd7d2]
78BF  26 80 7D 02 00  cmp byte ptr es:[di + 2], 0
78C4  75 17           jne 0x78dd
78C6  6A 0E           push 0xe
78C8  BF AC 78        mov di, 0x78ac
78CB  0E              push cs
78CC  57              push di
78CD  6A 19           push 0x19
78CF  6A 17           push 0x17
78D1  BF 58 DD        mov di, 0xdd58
78D4  1E              push ds
78D5  57              push di
78D6  9A 1B 04 1A 23  call far 231A:041B
78DB  EB 39           jmp 0x7916
loc_78DD:
78DD  6A 0E           push 0xe
78DF  8D BE FE FE     lea di, [bp - 0x102]
78E3  16              push ss
78E4  57              push di
78E5  C4 3E D2 D7     les di, ptr [0xd7d2]
78E9  26 8A 45 02     mov al, byte ptr es:[di + 2]
78ED  30 E4           xor ah, ah
78EF  8B D0           mov dx, ax
78F1  B8 1E 00        mov ax, 0x1e
78F4  2B C2           sub ax, dx
78F6  99              cdq
78F7  52              push dx
78F8  50              push ax
78F9  9A C9 07 1A 23  call far 231A:07C9
78FE  BF B2 78        mov di, 0x78b2
7901  0E              push cs
7902  57              push di
7903  9A D2 0B B9 26  call far 26B9:0BD2
7908  6A 19           push 0x19
790A  6A 17           push 0x17
790C  BF 58 DD        mov di, 0xdd58
790F  1E              push ds
7910  57              push di
7911  9A 1B 04 1A 23  call far 231A:041B
loc_7916:
7916  9A 58 0C AC 24  call far 24AC:0C58
791B  08 C0           or al, al
791D  75 03           jne 0x7922
791F  E9 B3 00        jmp 0x79d5
loc_7922:
7922  C4 3E D2 D7     les di, ptr [0xd7d2]
7926  89 7E FA        mov word ptr [bp - 6], di
7929  8C 46 FC        mov word ptr [bp - 4], es
792C  9A 2E 02 1A 23  call far 231A:022E
7931  9A 9B 09 1A 23  call far 231A:099B
7936  A0 88 DE        mov al, byte ptr [0xde88]
7939  50              push ax
793A  9A 86 19 B9 26  call far 26B9:1986
793F  3C 20           cmp al, 0x20
7941  75 06           jne 0x7949
7943  E8 0D 92        call 0xb53
7946  E9 8A 00        jmp 0x79d3
loc_7949:
7949  3C 07           cmp al, 7
794B  75 10           jne 0x795d
794D  C4 7E FA        les di, ptr [bp - 6]
7950  26 80 7D 02 1E  cmp byte ptr es:[di + 2], 0x1e
7955  73 04           jae 0x795b
7957  26 FE 45 02     inc byte ptr es:[di + 2]
loc_795B:
795B  EB 76           jmp 0x79d3
loc_795D:
795D  3C 08           cmp al, 8
795F  75 10           jne 0x7971
7961  C4 7E FA        les di, ptr [bp - 6]
7964  26 80 7D 02 00  cmp byte ptr es:[di + 2], 0
7969  76 04           jbe 0x796f
796B  26 FE 4D 02     dec byte ptr es:[di + 2]
loc_796F:
796F  EB 62           jmp 0x79d3
loc_7971:
7971  3C 05           cmp al, 5
7973  74 04           je 0x7979
7975  3C 06           cmp al, 6
7977  75 27           jne 0x79a0
loc_7979:
7979  C4 3E C0 D0     les di, ptr [0xd0c0]
797D  06              push es
797E  57              push di
797F  6A 00           push 0
7981  6A 04           push 4
7983  80 3E 88 DE 06  cmp byte ptr [0xde88], 6
7988  B0 00           mov al, 0
798A  75 01           jne 0x798d
798C  40              inc ax
loc_798D:
798D  98              cwde
798E  8B F8           mov di, ax
7990  8A 85 38 A3     mov al, byte ptr [di - 0x5cc8]
7994  98              cwde
7995  50              push ax
7996  9A 8C 04 AC 24  call far 24AC:048C
799B  E8 1D 8A        call 0x3bb
799E  EB 33           jmp 0x79d3
loc_79A0:
79A0  3C 02           cmp al, 2
79A2  74 04           je 0x79a8
79A4  3C 01           cmp al, 1
79A6  75 07           jne 0x79af
loc_79A8:
79A8  6A 01           push 1
79AA  E8 23 5C        call 0xd5d0
79AD  EB 24           jmp 0x79d3
loc_79AF:
79AF  3C D1           cmp al, 0xd1
79B1  75 07           jne 0x79ba
79B3  9A 56 02 1A 23  call far 231A:0256
79B8  EB 19           jmp 0x79d3
loc_79BA:
79BA  3C 52           cmp al, 0x52
79BC  75 05           jne 0x79c3
79BE  E8 A1 61        call 0xdb62
79C1  EB 10           jmp 0x79d3
loc_79C3:
79C3  3C D2           cmp al, 0xd2
79C5  75 0C           jne 0x79d3
79C7  9A AB 00 94 19  call far 1994:00AB
79CC  31 C0           xor ax, ax
79CE  9A 16 01 B9 26  call far 26B9:0116
loc_79D3:
79D3  EB 0A           jmp 0x79df
loc_79D5:
79D5  80 3E CC D1 00  cmp byte ptr [0xd1cc], 0
79DA  74 03           je 0x79df
79DC  E8 83 61        call 0xdb62
loc_79DF:
79DF  80 3E 74 D0 00  cmp byte ptr [0xd074], 0
79E4  74 05           je 0x79eb
79E6  9A 2E 02 1A 23  call far 231A:022E
loc_79EB:
79EB  C9              leave
79EC  C3              ret

; ---- routine 0AB5:79ED  (found by: call)
sub_79ED:
79ED  55              push bp
79EE  89 E5           mov bp, sp
79F0  C4 3E D2 D7     les di, ptr [0xd7d2]
79F4  26 8A 45 02     mov al, byte ptr es:[di + 2]
79F8  30 E4           xor ah, ah
79FA  50              push ax
79FB  9A D6 00 94 19  call far 1994:00D6
7A00  C9              leave
7A01  C3              ret

; ---- routine 0AB5:7A02  (found by: call)
sub_7A02:
7A02  C8 08 00 00     enter 8, 0
7A06  C7 46 FE 01 00  mov word ptr [bp - 2], 1
7A0B  EB 03           jmp 0x7a10
loc_7A0D:
7A0D  FF 46 FE        inc word ptr [bp - 2]
loc_7A10:
7A10  80 3E 53 CF 00  cmp byte ptr [0xcf53], 0
7A15  75 03           jne 0x7a1a
7A17  E9 F6 00        jmp 0x7b10
loc_7A1A:
7A1A  8B 56 FE        mov dx, word ptr [bp - 2]
7A1D  80 3E 54 CF 00  cmp byte ptr [0xcf54], 0
7A22  74 0B           je 0x7a2f
7A24  A0 BB D0        mov al, byte ptr [0xd0bb]
7A27  3C 01           cmp al, 1
7A29  72 08           jb 0x7a33
7A2B  3C 04           cmp al, 4
7A2D  77 04           ja 0x7a33
loc_7A2F:
7A2F  B0 00           mov al, 0
7A31  EB 02           jmp 0x7a35
loc_7A33:
7A33  B0 01           mov al, 1
loc_7A35:
7A35  98              cwde
7A36  6B F8 16        imul di, ax, 0x16
7A39  03 FA           add di, dx
7A3B  8A 85 2D 0B     mov al, byte ptr [di + 0xb2d]
7A3F  30 E4           xor ah, ah
7A41  3B 06 51 CF     cmp ax, word ptr [0xcf51]
7A45  76 03           jbe 0x7a4a
7A47  E9 C6 00        jmp 0x7b10
loc_7A4A:
7A4A  80 3E 47 CF 00  cmp byte ptr [0xcf47], 0
7A4F  74 2C           je 0x7a7d
7A51  BF 08 CD        mov di, 0xcd08
7A54  1E              push ds
7A55  57              push di
7A56  0E              push cs
7A57  E8 72 A4        call 0x1ecc
7A5A  8A D0           mov dl, al
7A5C  80 3E 47 CF 00  cmp byte ptr [0xcf47], 0
7A61  B0 00           mov al, 0
7A63  7E 01           jle 0x7a66
7A65  40              inc ax
loc_7A66:
7A66  98              cwde
7A67  8B F8           mov di, ax
7A69  8A 85 38 A3     mov al, byte ptr [di - 0x5cc8]
7A6D  3A C2           cmp al, dl
7A6F  B0 00           mov al, 0
7A71  75 01           jne 0x7a74
7A73  40              inc ax
loc_7A74:
7A74  98              cwde
7A75  8B F8           mov di, ax
7A77  D1 E7           shl di, 1
7A79  FF 85 C4 D1     inc word ptr [di - 0x2e3c]
loc_7A7D:
7A7D  BF 46 CF        mov di, 0xcf46
7A80  1E              push ds
7A81  57              push di
7A82  0E              push cs
7A83  E8 9D F9        call 0x7423
7A86  E8 4E A7        call 0x21d7
7A89  E8 4A A2        call 0x1cd6
7A8C  08 C0           or al, al
7A8E  B0 00           mov al, 0
7A90  75 01           jne 0x7a93
7A92  40              inc ax
loc_7A93:
7A93  98              cwde
7A94  8B F8           mov di, ax
7A96  8A 85 56 0D     mov al, byte ptr [di + 0xd56]
7A9A  30 E4           xor ah, ah
7A9C  40              inc ax
7A9D  6B F8 19        imul di, ax, 0x19
7AA0  81 C7 EF CC     add di, 0xccef
7AA4  1E              push ds
7AA5  07              pop es
7AA6  89 7E F8        mov word ptr [bp - 8], di
7AA9  8C 46 FA        mov word ptr [bp - 6], es
7AAC  A0 BB D0        mov al, byte ptr [0xd0bb]
7AAF  3C 01           cmp al, 1
7AB1  72 31           jb 0x7ae4
7AB3  3C 04           cmp al, 4
7AB5  77 2D           ja 0x7ae4
7AB7  06              push es
7AB8  57              push di
7AB9  0E              push cs
7ABA  E8 F9 A4        call 0x1fb6
7ABD  08 C0           or al, al
7ABF  75 23           jne 0x7ae4
7AC1  C4 7E F8        les di, ptr [bp - 8]
7AC4  26 8A 05        mov al, byte ptr es:[di]
7AC7  3A 06 46 CF     cmp al, byte ptr [0xcf46]
7ACB  75 0E           jne 0x7adb
7ACD  FF 36 46 CF     push word ptr [0xcf46]
7AD1  06              push es
7AD2  57              push di
7AD3  0E              push cs
7AD4  E8 A8 A5        call 0x207f
7AD7  08 C0           or al, al
7AD9  74 09           je 0x7ae4
loc_7ADB:
7ADB  C4 7E F8        les di, ptr [bp - 8]
7ADE  06              push es
7ADF  57              push di
7AE0  0E              push cs
7AE1  E8 D7 F7        call 0x72bb
loc_7AE4:
7AE4  E8 ED CB        call 0x46d4
7AE7  08 C0           or al, al
7AE9  75 25           jne 0x7b10
7AEB  C7 46 FC 01 00  mov word ptr [bp - 4], 1
7AF0  EB 03           jmp 0x7af5
loc_7AF2:
7AF2  FF 46 FC        inc word ptr [bp - 4]
loc_7AF5:
7AF5  80 3E 53 CF 00  cmp byte ptr [0xcf53], 0
7AFA  74 0E           je 0x7b0a
7AFC  6B 7E FC 19     imul di, word ptr [bp - 4], 0x19
7B00  81 C7 EF CC     add di, 0xccef
7B04  1E              push ds
7B05  57              push di
7B06  0E              push cs
7B07  E8 F5 D2        call 0x4dff
loc_7B0A:
7B0A  83 7E FC 16     cmp word ptr [bp - 4], 0x16
7B0E  75 E2           jne 0x7af2
loc_7B10:
7B10  8B 7E FE        mov di, word ptr [bp - 2]
7B13  8A 85 17 0B     mov al, byte ptr [di + 0xb17]
7B17  30 E4           xor ah, ah
7B19  6B F8 19        imul di, ax, 0x19
7B1C  81 C7 EF CC     add di, 0xccef
7B20  1E              push ds
7B21  07              pop es
7B22  89 7E F8        mov word ptr [bp - 8], di
7B25  8C 46 FA        mov word ptr [bp - 6], es
7B28  06              push es
7B29  57              push di
7B2A  0E              push cs
7B2B  E8 73 A1        call 0x1ca1
7B2E  08 C0           or al, al
7B30  75 09           jne 0x7b3b
7B32  C4 7E F8        les di, ptr [bp - 8]
7B35  06              push es
7B36  57              push di
7B37  0E              push cs
7B38  E8 80 F7        call 0x72bb
loc_7B3B:
7B3B  8B 7E FE        mov di, word ptr [bp - 2]
7B3E  8A 85 17 0B     mov al, byte ptr [di + 0xb17]
7B42  3A 06 9F D0     cmp al, byte ptr [0xd09f]
7B46  75 03           jne 0x7b4b
7B48  E8 8C A6        call 0x21d7
loc_7B4B:
7B4B  E8 9F FE        call 0x79ed
7B4E  BF 46 CF        mov di, 0xcf46
7B51  1E              push ds
7B52  57              push di
7B53  9A 16 0A 94 19  call far 1994:0A16
7B58  E8 5C FD        call 0x78b7
7B5B  80 3E 74 D0 00  cmp byte ptr [0xd074], 0
7B60  74 02           je 0x7b64
7B62  EB 15           jmp 0x7b79
loc_7B64:
7B64  83 7E FE 16     cmp word ptr [bp - 2], 0x16
7B68  74 03           je 0x7b6d
7B6A  E9 A0 FE        jmp 0x7a0d
loc_7B6D:
7B6D  83 3E BE D0 00  cmp word ptr [0xd0be], 0
7B72  76 05           jbe 0x7b79
7B74  83 2E BE D0 02  sub word ptr [0xd0be], 2
loc_7B79:
7B79  C9              leave
7B7A  C3              ret

; ---- routine 0AB5:7B7B  (found by: call)
sub_7B7B:
7B7B  C8 06 00 00     enter 6, 0
7B7F  C6 46 FF 00     mov byte ptr [bp - 1], 0
7B83  80 3E B8 D0 00  cmp byte ptr [0xd0b8], 0
7B88  75 03           jne 0x7b8d
7B8A  E9 AB 00        jmp 0x7c38
loc_7B8D:
7B8D  83 3E B0 D0 00  cmp word ptr [0xd0b0], 0
7B92  76 07           jbe 0x7b9b
7B94  FF 0E B0 D0     dec word ptr [0xd0b0]
7B98  E9 9D 00        jmp 0x7c38
loc_7B9B:
7B9B  A1 AE D0        mov ax, word ptr [0xd0ae]
7B9E  03 06 B4 D0     add ax, word ptr [0xd0b4]
7BA2  09 C0           or ax, ax
7BA4  B0 00           mov al, 0
7BA6  75 01           jne 0x7ba9
7BA8  40              inc ax
loc_7BA9:
7BA9  A2 B9 D0        mov byte ptr [0xd0b9], al
7BAC  80 3E B9 D0 00  cmp byte ptr [0xd0b9], 0
7BB1  75 1D           jne 0x7bd0
7BB3  83 3E AE D0 00  cmp word ptr [0xd0ae], 0
7BB8  76 06           jbe 0x7bc0
7BBA  FF 0E AE D0     dec word ptr [0xd0ae]
7BBE  EB 04           jmp 0x7bc4
loc_7BC0:
7BC0  FF 0E B4 D0     dec word ptr [0xd0b4]
loc_7BC4:
7BC4  81 3E B2 D0 80 00 cmp word ptr [0xd0b2], 0x80
7BCA  73 04           jae 0x7bd0
7BCC  FF 06 B2 D0     inc word ptr [0xd0b2]
loc_7BD0:
7BD0  FF 36 AE D0     push word ptr [0xd0ae]
7BD4  6A 03           push 3
7BD6  E8 FD 84        call 0xd6
7BD9  A0 28 0D        mov al, byte ptr [0xd28]
7BDC  30 E4           xor ah, ah
7BDE  A3 B0 D0        mov word ptr [0xd0b0], ax
7BE1  A0 AC D0        mov al, byte ptr [0xd0ac]
7BE4  98              cwde
7BE5  99              cdq
7BE6  8B C8           mov cx, ax
7BE8  8B DA           mov bx, dx
7BEA  A1 AE D0        mov ax, word ptr [0xd0ae]
7BED  31 D2           xor dx, dx
7BEF  3B D3           cmp dx, bx
7BF1  75 04           jne 0x7bf7
7BF3  3B C1           cmp ax, cx
7BF5  74 07           je 0x7bfe
loc_7BF7:
7BF7  80 3E B9 D0 00  cmp byte ptr [0xd0b9], 0
7BFC  74 3A           je 0x7c38
loc_7BFE:
7BFE  80 3E B9 D0 00  cmp byte ptr [0xd0b9], 0
7C03  74 07           je 0x7c0c
7C05  6A 3F           push 0x3f
7C07  E8 0A A2        call 0x1e14
7C0A  EB 05           jmp 0x7c11
loc_7C0C:
7C0C  6A 40           push 0x40
7C0E  E8 03 A2        call 0x1e14
loc_7C11:
7C11  31 C0           xor ax, ax
7C13  A3 51 CF        mov word ptr [0xcf51], ax
7C16  C6 46 FF 01     mov byte ptr [bp - 1], 1
7C1A  6A 03           push 3
7C1C  9A E0 01 94 19  call far 1994:01E0
7C21  C4 3E D2 D7     les di, ptr [0xd7d2]
7C25  26 8A 45 02     mov al, byte ptr es:[di + 2]
7C29  30 E4           xor ah, ah
7C2B  50              push ax
7C2C  9A D6 00 94 19  call far 1994:00D6
7C31  6A 06           push 6
7C33  9A E0 01 94 19  call far 1994:01E0
loc_7C38:
7C38  8A 46 FF        mov al, byte ptr [bp - 1]
7C3B  C9              leave
7C3C  C2 02 00        ret 2

; ---- routine 0AB5:7C3F  (found by: call)
sub_7C3F:
7C3F  C8 06 00 00     enter 6, 0
7C43  C6 06 BA D0 00  mov byte ptr [0xd0ba], 0
7C48  C6 06 A1 D0 00  mov byte ptr [0xd0a1], 0
7C4D  E8 DF EE        call 0x6b2f
7C50  E8 E7 A0        call 0x1d3a
7C53  80 3E 74 D0 00  cmp byte ptr [0xd074], 0
7C58  75 08           jne 0x7c62
7C5A  6A 01           push 1
7C5C  E8 1F A0        call 0x1c7e
7C5F  E8 83 F9        call 0x75e5
loc_7C62:
7C62  C6 06 53 CF 00  mov byte ptr [0xcf53], 0
loc_7C67:
7C67  80 3E 74 D0 00  cmp byte ptr [0xd074], 0
7C6C  74 05           je 0x7c73
7C6E  E8 8B 60        call 0xdcfc
7C71  EB 1B           jmp 0x7c8e
loc_7C73:
7C73  E8 8C FD        call 0x7a02
7C76  80 3E 74 D0 00  cmp byte ptr [0xd074], 0
7C7B  75 11           jne 0x7c8e
7C7D  E8 BE 86        call 0x33e
7C80  E8 89 F9        call 0x760c
7C83  6A 00           push 0
7C85  BF 3C CF        mov di, 0xcf3c
7C88  1E              push ds
7C89  57              push di
7C8A  0E              push cs
7C8B  E8 80 FA        call 0x770e
loc_7C8E:
7C8E  55              push bp
7C8F  E8 E9 FE        call 0x7b7b
7C92  08 C0           or al, al
7C94  74 D1           je 0x7c67
7C96  80 3E 74 D0 00  cmp byte ptr [0xd074], 0
7C9B  75 2B           jne 0x7cc8
7C9D  C6 46 FF 00     mov byte ptr [bp - 1], 0
7CA1  EB 03           jmp 0x7ca6
loc_7CA3:
7CA3  FE 46 FF        inc byte ptr [bp - 1]
loc_7CA6:
7CA6  8A 46 FF        mov al, byte ptr [bp - 1]
7CA9  98              cwde
7CAA  6B F8 07        imul di, ax, 7
7CAD  81 C7 2E CF     add di, 0xcf2e
7CB1  1E              push ds
7CB2  57              push di
7CB3  9A 3F 09 94 19  call far 1994:093F
7CB8  80 7E FF 01     cmp byte ptr [bp - 1], 1
7CBC  75 E5           jne 0x7ca3
7CBE  BF 3C CF        mov di, 0xcf3c
7CC1  1E              push ds
7CC2  57              push di
7CC3  9A 3F 09 94 19  call far 1994:093F
loc_7CC8:
7CC8  C6 06 B8 D0 00  mov byte ptr [0xd0b8], 0
7CCD  9A 2E 02 1A 23  call far 231A:022E
7CD2  C9              leave
7CD3  C3              ret

; ---- routine 0AB5:7CD4  (found by: call)
sub_7CD4:
7CD4  C8 06 00 00     enter 6, 0
7CD8  6A 0A           push 0xa
7CDA  9A 6D 07 1A 23  call far 231A:076D
7CDF  40              inc ax
7CE0  8B D0           mov dx, ax
7CE2  A0 C5 D0        mov al, byte ptr [0xd0c5]
7CE5  3A 06 C4 D0     cmp al, byte ptr [0xd0c4]
7CE9  B0 00           mov al, 0
7CEB  76 01           jbe 0x7cee
7CED  40              inc ax
loc_7CEE:
7CEE  98              cwde
7CEF  8B F8           mov di, ax
7CF1  8A 85 56 0D     mov al, byte ptr [di + 0xd56]
7CF5  30 E4           xor ah, ah
7CF7  03 C2           add ax, dx
7CF9  50              push ax
7CFA  6A 03           push 3
7CFC  E8 E4 DA        call 0x57e3
7CFF  C6 06 B8 D0 01  mov byte ptr [0xd0b8], 1
7D04  C7 46 FE 01 00  mov word ptr [bp - 2], 1
7D09  EB 03           jmp 0x7d0e
loc_7D0B:
7D0B  FF 46 FE        inc word ptr [bp - 2]
loc_7D0E:
7D0E  6B 7E FE 19     imul di, word ptr [bp - 2], 0x19
7D12  81 C7 EF CC     add di, 0xccef
7D16  1E              push ds
7D17  07              pop es
7D18  89 7E FA        mov word ptr [bp - 6], di
7D1B  8C 46 FC        mov word ptr [bp - 4], es
7D1E  06              push es
7D1F  57              push di
7D20  0E              push cs
7D21  E8 2A A1        call 0x1e4e
7D24  08 C0           or al, al
7D26  74 08           je 0x7d30
7D28  C4 7E FA        les di, ptr [bp - 6]
7D2B  26 C6 45 13 06  mov byte ptr es:[di + 0x13], 6
loc_7D30:
7D30  83 7E FE 16     cmp word ptr [bp - 2], 0x16
7D34  75 D5           jne 0x7d0b
7D36  E8 5C D2        call 0x4f95
7D39  80 3E 74 D0 00  cmp byte ptr [0xd074], 0
7D3E  75 0C           jne 0x7d4c
loc_7D40:
7D40  E8 BF FC        call 0x7a02
7D43  6A 01           push 1
7D45  E8 D6 9E        call 0x1c1e
7D48  08 C0           or al, al
7D4A  74 F4           je 0x7d40
loc_7D4C:
7D4C  9A 2E 02 1A 23  call far 231A:022E
7D51  C9              leave
7D52  C3              ret

; ---- routine 0AB5:7D53  (found by: call)
sub_7D53:
7D53  55              push bp
7D54  89 E5           mov bp, sp
7D56  C6 06 B8 D0 00  mov byte ptr [0xd0b8], 0
7D5B  80 3E 74 D0 00  cmp byte ptr [0xd074], 0
7D60  75 05           jne 0x7d67
7D62  6A 03           push 3
7D64  E8 17 9F        call 0x1c7e
loc_7D67:
7D67  C6 06 53 CF 00  mov byte ptr [0xcf53], 0
7D6C  80 3E 74 D0 00  cmp byte ptr [0xd074], 0
7D71  75 0C           jne 0x7d7f
loc_7D73:
7D73  E8 8C FC        call 0x7a02
7D76  6A 04           push 4
7D78  E8 A3 9E        call 0x1c1e
7D7B  08 C0           or al, al
7D7D  74 F4           je 0x7d73
loc_7D7F:
7D7F  9A 2E 02 1A 23  call far 231A:022E
7D84  C9              leave
7D85  C3              ret

; ---- routine 0AB5:7D86  (found by: call)
sub_7D86:
7D86  C8 04 00 00     enter 4, 0
7D8A  A0 AD D0        mov al, byte ptr [0xd0ad]
7D8D  98              cwde
7D8E  8B F8           mov di, ax
7D90  8A 85 56 0D     mov al, byte ptr [di + 0xd56]
7D94  30 E4           xor ah, ah
7D96  05 0A 00        add ax, 0xa
7D99  A2 9F D0        mov byte ptr [0xd09f], al
7D9C  E8 37 9F        call 0x1cd6
7D9F  98              cwde
7DA0  8B F8           mov di, ax
7DA2  D1 E7           shl di, 1
7DA4  6B 85 E4 D6 3E  imul ax, word ptr [di - 0x291c], 0x3e
7DA9  C4 3E C2 D7     les di, ptr [0xd7c2]
7DAD  03 F8           add di, ax
7DAF  81 C7 C2 FF     add di, 0xffc2
7DB3  E8 20 9F        call 0x1cd6
7DB6  50              push ax
7DB7  E8 1C 9F        call 0x1cd6
7DBA  50              push ax
7DBB  6A 01           push 1
7DBD  E8 BF D9        call 0x577f
7DC0  50              push ax
7DC1  6A 00           push 0
7DC3  6A 3B           push 0x3b
7DC5  E8 CC 91        call 0xf94
7DC8  E8 74 FE        call 0x7c3f
7DCB  A1 C4 D0        mov ax, word ptr [0xd0c4]
7DCE  A3 C6 D0        mov word ptr [0xd0c6], ax
7DD1  C9              leave
7DD2  C3              ret

; ---- routine 0AB5:7DD3  (found by: call)
sub_7DD3:
7DD3  C8 0A 00 00     enter 0xa, 0
7DD7  C7 46 FE 01 00  mov word ptr [bp - 2], 1
7DDC  EB 03           jmp 0x7de1
loc_7DDE:
7DDE  FF 46 FE        inc word ptr [bp - 2]
loc_7DE1:
7DE1  6B 7E FE 19     imul di, word ptr [bp - 2], 0x19
7DE5  81 C7 EF CC     add di, 0xccef
7DE9  1E              push ds
7DEA  07              pop es
7DEB  26 6B 45 0E 0F  imul ax, word ptr es:[di + 0xe], 0xf
7DF0  C4 3E BE D7     les di, ptr [0xd7be]
7DF4  03 F8           add di, ax
7DF6  26 8A 45 08     mov al, byte ptr es:[di + 8]
7DFA  3C 01           cmp al, 1
7DFC  72 09           jb 0x7e07
7DFE  3C 1E           cmp al, 0x1e
7E00  77 05           ja 0x7e07
7E02  26 80 45 08 02  add byte ptr es:[di + 8], 2
loc_7E07:
7E07  83 7E FE 16     cmp word ptr [bp - 2], 0x16
7E0B  75 D1           jne 0x7dde
7E0D  C6 06 BA D0 01  mov byte ptr [0xd0ba], 1
7E12  C4 3E 58 DD     les di, ptr [0xdd58]
7E16  06              push es
7E17  57              push di
7E18  C4 3E 60 DD     les di, ptr [0xdd60]
7E1C  06              push es
7E1D  57              push di
7E1E  68 A0 0F        push 0xfa0
7E21  9A 12 0A B9 26  call far 26B9:0A12
7E26  6A 01           push 1
7E28  6A 00           push 0
7E2A  9A 5C 04 94 19  call far 1994:045C
7E2F  C4 3E 60 DD     les di, ptr [0xdd60]
7E33  06              push es
7E34  57              push di
7E35  C4 3E 58 DD     les di, ptr [0xdd58]
7E39  06              push es
7E3A  57              push di
7E3B  68 A0 0F        push 0xfa0
7E3E  9A 12 0A B9 26  call far 26B9:0A12
7E43  80 3E CB D1 00  cmp byte ptr [0xd1cb], 0
7E48  74 05           je 0x7e4f
7E4A  6A 00           push 0
7E4C  E8 81 57        call 0xd5d0
loc_7E4F:
7E4F  80 3E AD D0 00  cmp byte ptr [0xd0ad], 0
7E54  B0 00           mov al, 0
7E56  75 01           jne 0x7e59
7E58  40              inc ax
loc_7E59:
7E59  98              cwde
7E5A  8B F8           mov di, ax
7E5C  8A 85 56 0D     mov al, byte ptr [di + 0xd56]
7E60  30 E4           xor ah, ah
7E62  05 0A 00        add ax, 0xa
7E65  A2 9F D0        mov byte ptr [0xd09f], al
7E68  C7 06 BE D0 50 00 mov word ptr [0xd0be], 0x50
7E6E  E8 CE FD        call 0x7c3f
7E71  C9              leave
7E72  C3              ret

; ---- routine 0AB5:7E73  (found by: call)
sub_7E73:
7E73  55              push bp
7E74  89 E5           mov bp, sp
7E76  C7 06 AE D0 1F 00 mov word ptr [0xd0ae], 0x1f
7E7C  C7 06 B2 D0 59 00 mov word ptr [0xd0b2], 0x59
7E82  C6 06 B9 D0 00  mov byte ptr [0xd0b9], 0
7E87  C6 06 AC D0 0F  mov byte ptr [0xd0ac], 0xf
7E8C  31 C0           xor ax, ax
7E8E  A3 B0 D0        mov word ptr [0xd0b0], ax
7E91  6A 3E           push 0x3e
7E93  E8 7E 9F        call 0x1e14
7E96  C6 06 BA D0 01  mov byte ptr [0xd0ba], 1
7E9B  80 3E CB D1 00  cmp byte ptr [0xd1cb], 0
7EA0  74 05           je 0x7ea7
7EA2  6A 01           push 1
7EA4  E8 29 57        call 0xd5d0
loc_7EA7:
7EA7  A0 AD D0        mov al, byte ptr [0xd0ad]
7EAA  98              cwde
7EAB  8B F8           mov di, ax
7EAD  8A 85 56 0D     mov al, byte ptr [di + 0xd56]
7EB1  30 E4           xor ah, ah
7EB3  05 0A 00        add ax, 0xa
7EB6  A2 9F D0        mov byte ptr [0xd09f], al
7EB9  E8 83 FD        call 0x7c3f
7EBC  C9              leave
7EBD  C3              ret

; ---- routine 0AB5:7EBE  (found by: call)
sub_7EBE:
7EBE  55              push bp
7EBF  89 E5           mov bp, sp
7EC1  C6 06 BA D0 01  mov byte ptr [0xd0ba], 1
7EC6  80 3E CB D1 00  cmp byte ptr [0xd1cb], 0
7ECB  74 05           je 0x7ed2
7ECD  6A 01           push 1
7ECF  E8 FE 56        call 0xd5d0
loc_7ED2:
7ED2  80 3E AD D0 00  cmp byte ptr [0xd0ad], 0
7ED7  B0 00           mov al, 0
7ED9  75 01           jne 0x7edc
7EDB  40              inc ax
loc_7EDC:
7EDC  98              cwde
7EDD  8B F8           mov di, ax
7EDF  8A 85 56 0D     mov al, byte ptr [di + 0xd56]
7EE3  30 E4           xor ah, ah
7EE5  05 0A 00        add ax, 0xa
7EE8  A2 9F D0        mov byte ptr [0xd09f], al
7EEB  E8 51 FD        call 0x7c3f
7EEE  C9              leave
7EEF  C3              ret

; ---- routine 0AB5:7EF0  (found by: call)
sub_7EF0:
7EF0  C8 0A 02 00     enter 0x20a, 0
7EF4  8B 7E 04        mov di, word ptr [bp + 4]
7EF7  36 8A 45 E1     mov al, byte ptr ss:[di - 0x1f]
7EFB  98              cwde
7EFC  8B F8           mov di, ax
7EFE  D1 E7           shl di, 1
7F00  6B 85 E4 D6 3E  imul ax, word ptr [di - 0x291c], 0x3e
7F05  C4 3E C2 D7     les di, ptr [0xd7c2]
7F09  03 F8           add di, ax
7F0B  81 C7 C2 FF     add di, 0xffc2
7F0F  89 7E F6        mov word ptr [bp - 0xa], di
7F12  8C 46 F8        mov word ptr [bp - 8], es
7F15  C4 3E 8A D0     les di, ptr [0xd08a]
7F19  06              push es
7F1A  57              push di
7F1B  C4 3E 96 D0     les di, ptr [0xd096]
7F1F  06              push es
7F20  57              push di
7F21  68 A0 0F        push 0xfa0
7F24  9A 12 0A B9 26  call far 26B9:0A12
7F29  A0 2A 9A        mov al, byte ptr [0x9a2a]
7F2C  88 46 FA        mov byte ptr [bp - 6], al
7F2F  C6 06 2A 9A 01  mov byte ptr [0x9a2a], 1
7F34  C6 46 FB 01     mov byte ptr [bp - 5], 1
7F38  C7 46 FC 0B 00  mov word ptr [bp - 4], 0xb
7F3D  C7 46 FE 01 00  mov word ptr [bp - 2], 1
7F42  EB 03           jmp 0x7f47
loc_7F44:
7F44  FF 46 FE        inc word ptr [bp - 2]
loc_7F47:
7F47  8B 46 FE        mov ax, word ptr [bp - 2]
7F4A  D1 E0           shl ax, 1
7F4C  C4 7E F6        les di, ptr [bp - 0xa]
7F4F  03 F8           add di, ax
7F51  26 FF 75 FE     push word ptr es:[di - 2]
7F55  9A E9 4E 51 1B  call far 1B51:4EE9
7F5A  08 C0           or al, al
7F5C  74 03           je 0x7f61
7F5E  FF 4E FC        dec word ptr [bp - 4]
loc_7F61:
7F61  83 7E FE 0B     cmp word ptr [bp - 2], 0xb
7F65  75 DD           jne 0x7f44
7F67  BF 6E 1C        mov di, 0x1c6e
7F6A  1E              push ds
7F6B  57              push di
7F6C  BF 5C DD        mov di, 0xdd5c
7F6F  1E              push ds
7F70  57              push di
7F71  9A 2F 05 1A 23  call far 231A:052F
7F76  8B 7E 04        mov di, word ptr [bp + 4]
7F79  36 8A 45 E1     mov al, byte ptr ss:[di - 0x1f]
7F7D  98              cwde
7F7E  8B F8           mov di, ax
7F80  D1 E7           shl di, 1
7F82  FF B5 E4 D6     push word ptr [di - 0x291c]
7F86  9A 02 0E 51 1B  call far 1B51:0E02
7F8B  50              push ax
7F8C  8B 7E 04        mov di, word ptr [bp + 4]
7F8F  36 8A 45 E1     mov al, byte ptr ss:[di - 0x1f]
7F93  98              cwde
7F94  8B F8           mov di, ax
7F96  D1 E7           shl di, 1
7F98  8B 85 E4 D6     mov ax, word ptr [di - 0x291c]
7F9C  C1 E0 04        shl ax, 4
7F9F  C4 3E B2 D7     les di, ptr [0xd7b2]
7FA3  03 F8           add di, ax
7FA5  81 C7 F0 FF     add di, 0xfff0
7FA9  06              push es
7FAA  57              push di
7FAB  6A 19           push 0x19
7FAD  6A 01           push 1
7FAF  BF 5C DD        mov di, 0xdd5c
7FB2  1E              push ds
7FB3  57              push di
7FB4  9A 1B 04 1A 23  call far 231A:041B
loc_7FB9:
7FB9  BF 5C 1B        mov di, 0x1b5c
7FBC  1E              push ds
7FBD  57              push di
7FBE  BF 5C DD        mov di, 0xdd5c
7FC1  1E              push ds
7FC2  57              push di
7FC3  9A 2F 05 1A 23  call far 231A:052F
7FC8  8A 46 FB        mov al, byte ptr [bp - 5]
7FCB  30 E4           xor ah, ah
7FCD  D1 E0           shl ax, 1
7FCF  C4 7E F6        les di, ptr [bp - 0xa]
7FD2  03 F8           add di, ax
7FD4  26 FF 75 FE     push word ptr es:[di - 2]
7FD8  0E              push cs
7FD9  E8 D7 15        call 0x95b3
7FDC  C7 46 FE 01 00  mov word ptr [bp - 2], 1
7FE1  EB 03           jmp 0x7fe6
loc_7FE3:
7FE3  FF 46 FE        inc word ptr [bp - 2]
loc_7FE6:
7FE6  8D BE F6 FE     lea di, [bp - 0x10a]
7FEA  16              push ss
7FEB  57              push di
7FEC  8B 7E 04        mov di, word ptr [bp + 4]
7FEF  36 8A 45 E1     mov al, byte ptr ss:[di - 0x1f]
7FF3  98              cwde
7FF4  8B F8           mov di, ax
7FF6  8A 85 56 0D     mov al, byte ptr [di + 0xd56]
7FFA  30 E4           xor ah, ah
7FFC  03 46 FE        add ax, word ptr [bp - 2]
7FFF  50              push ax
8000  9A 6F 0C B9 26  call far 26B9:0C6F
8005  8B 7E 04        mov di, word ptr [bp + 4]
8008  36 8A 45 E1     mov al, byte ptr ss:[di - 0x1f]
800C  98              cwde
800D  6B C0 0C        imul ax, ax, 0xc
8010  03 F8           add di, ax
8012  81 C7 E6 FF     add di, 0xffe6
8016  16              push ss
8017  57              push di
8018  9A FE 0B B9 26  call far 26B9:0BFE
801D  09 C0           or ax, ax
801F  75 1A           jne 0x803b
8021  8B 46 FE        mov ax, word ptr [bp - 2]
8024  D1 E0           shl ax, 1
8026  C4 7E F6        les di, ptr [bp - 0xa]
8029  03 F8           add di, ax
802B  26 FF 75 FE     push word ptr es:[di - 2]
802F  8B 46 FE        mov ax, word ptr [bp - 2]
8032  40              inc ax
8033  50              push ax
8034  6A 3C           push 0x3c
8036  9A 51 1F 51 1B  call far 1B51:1F51
loc_803B:
803B  83 7E FE 0B     cmp word ptr [bp - 2], 0xb
803F  75 A2           jne 0x7fe3
8041  8A 46 FB        mov al, byte ptr [bp - 5]
8044  30 E4           xor ah, ah
8046  40              inc ax
8047  50              push ax
8048  6A 3B           push 0x3b
804A  6A 0E           push 0xe
804C  9A 03 02 1A 23  call far 231A:0203
8051  8B 7E 04        mov di, word ptr [bp + 4]
8054  36 8A 45 E1     mov al, byte ptr ss:[di - 0x1f]
8058  98              cwde
8059  6B C0 0C        imul ax, ax, 0xc
805C  03 F8           add di, ax
805E  36 8A 45 E6     mov al, byte ptr ss:[di - 0x1a]
8062  30 E4           xor ah, ah
8064  89 46 F4        mov word ptr [bp - 0xc], ax
8067  B8 01 00        mov ax, 1
806A  3B 46 F4        cmp ax, word ptr [bp - 0xc]
806D  77 43           ja 0x80b2
806F  89 46 FE        mov word ptr [bp - 2], ax
8072  EB 03           jmp 0x8077
loc_8074:
8074  FF 46 FE        inc word ptr [bp - 2]
loc_8077:
8077  8B 56 FE        mov dx, word ptr [bp - 2]
807A  8B 7E 04        mov di, word ptr [bp + 4]
807D  36 8A 45 E1     mov al, byte ptr ss:[di - 0x1f]
8081  98              cwde
8082  6B C0 0C        imul ax, ax, 0xc
8085  03 F8           add di, ax
8087  03 FA           add di, dx
8089  36 8A 45 E6     mov al, byte ptr ss:[di - 0x1a]
808D  30 E4           xor ah, ah
808F  6B F8 19        imul di, ax, 0x19
8092  81 C7 EF CC     add di, 0xccef
8096  1E              push ds
8097  07              pop es
8098  26 FF 75 0E     push word ptr es:[di + 0xe]
809C  8B 46 FE        mov ax, word ptr [bp - 2]
809F  05 0D 00        add ax, 0xd
80A2  50              push ax
80A3  6A 3C           push 0x3c
80A5  9A 51 1F 51 1B  call far 1B51:1F51
80AA  8B 46 FE        mov ax, word ptr [bp - 2]
80AD  3B 46 F4        cmp ax, word ptr [bp - 0xc]
80B0  75 C2           jne 0x8074
loc_80B2:
80B2  C4 3E 5C DD     les di, ptr [0xdd5c]
80B6  06              push es
80B7  57              push di
80B8  C4 3E 58 DD     les di, ptr [0xdd58]
80BC  06              push es
80BD  57              push di
80BE  68 A0 0F        push 0xfa0
80C1  9A 12 0A B9 26  call far 26B9:0A12
80C6  9A 9B 09 1A 23  call far 231A:099B
80CB  8D 7E FB        lea di, [bp - 5]
80CE  16              push ss
80CF  57              push di
80D0  6A 0B           push 0xb
80D2  9A C4 0E 1A 23  call far 231A:0EC4
loc_80D7:
80D7  8D BE F6 FE     lea di, [bp - 0x10a]
80DB  16              push ss
80DC  57              push di
80DD  8B 7E 04        mov di, word ptr [bp + 4]
80E0  36 8A 45 E1     mov al, byte ptr ss:[di - 0x1f]
80E4  98              cwde
80E5  8B F8           mov di, ax
80E7  8A 85 56 0D     mov al, byte ptr [di + 0xd56]
80EB  30 E4           xor ah, ah
80ED  8B D0           mov dx, ax
80EF  8A 46 FB        mov al, byte ptr [bp - 5]
80F2  30 E4           xor ah, ah
80F4  03 C2           add ax, dx
80F6  50              push ax
80F7  9A 6F 0C B9 26  call far 26B9:0C6F
80FC  8B 7E 04        mov di, word ptr [bp + 4]
80FF  36 8A 45 E1     mov al, byte ptr ss:[di - 0x1f]
8103  98              cwde
8104  6B C0 0C        imul ax, ax, 0xc
8107  03 F8           add di, ax
8109  81 C7 E6 FF     add di, 0xffe6
810D  16              push ss
810E  57              push di
810F  9A FE 0B B9 26  call far 26B9:0BFE
8114  09 C0           or ax, ax
8116  7F 19           jg 0x8131
8118  8A 46 FB        mov al, byte ptr [bp - 5]
811B  30 E4           xor ah, ah
811D  D1 E0           shl ax, 1
811F  C4 7E F6        les di, ptr [bp - 0xa]
8122  03 F8           add di, ax
8124  26 FF 75 FE     push word ptr es:[di - 2]
8128  9A E9 4E 51 1B  call far 1B51:4EE9
812D  08 C0           or al, al
812F  74 23           je 0x8154
loc_8131:
8131  8D 7E FB        lea di, [bp - 5]
8134  16              push ss
8135  57              push di
8136  6A 01           push 1
8138  6A 0B           push 0xb
813A  80 3E 88 DE 06  cmp byte ptr [0xde88], 6
813F  B0 00           mov al, 0
8141  75 01           jne 0x8144
8143  40              inc ax
loc_8144:
8144  98              cwde
8145  8B F8           mov di, ax
8147  8A 85 38 A3     mov al, byte ptr [di - 0x5cc8]
814B  98              cwde
814C  50              push ax
814D  9A 8C 04 AC 24  call far 24AC:048C
8152  EB 83           jmp 0x80d7
loc_8154:
8154  80 3E 88 DE 02  cmp byte ptr [0xde88], 2
8159  75 6B           jne 0x81c6
815B  8D BE F6 FD     lea di, [bp - 0x20a]
815F  16              push ss
8160  57              push di
8161  8B 7E 04        mov di, word ptr [bp + 4]
8164  36 8A 45 E1     mov al, byte ptr ss:[di - 0x1f]
8168  98              cwde
8169  6B C0 0C        imul ax, ax, 0xc
816C  03 F8           add di, ax
816E  81 C7 E6 FF     add di, 0xffe6
8172  16              push ss
8173  57              push di
8174  9A 53 0B B9 26  call far 26B9:0B53
8179  8D BE F6 FE     lea di, [bp - 0x10a]
817D  16              push ss
817E  57              push di
817F  8B 7E 04        mov di, word ptr [bp + 4]
8182  36 8A 45 E1     mov al, byte ptr ss:[di - 0x1f]
8186  98              cwde
8187  8B F8           mov di, ax
8189  8A 85 56 0D     mov al, byte ptr [di + 0xd56]
818D  30 E4           xor ah, ah
818F  8B D0           mov dx, ax
8191  8A 46 FB        mov al, byte ptr [bp - 5]
8194  30 E4           xor ah, ah
8196  03 C2           add ax, dx
8198  50              push ax
8199  9A 6F 0C B9 26  call far 26B9:0C6F
819E  9A D2 0B B9 26  call far 26B9:0BD2
81A3  8B 7E 04        mov di, word ptr [bp + 4]
81A6  36 8A 45 E1     mov al, byte ptr ss:[di - 0x1f]
81AA  98              cwde
81AB  6B C0 0C        imul ax, ax, 0xc
81AE  03 F8           add di, ax
81B0  81 C7 E6 FF     add di, 0xffe6
81B4  16              push ss
81B5  57              push di
81B6  6A 0B           push 0xb
81B8  9A 6D 0B B9 26  call far 26B9:0B6D
81BD  6A 06           push 6
81BF  9A 83 07 1A 23  call far 231A:0783
81C4  EB 42           jmp 0x8208
loc_81C6:
81C6  80 3E 88 DE 0D  cmp byte ptr [0xde88], 0xd
81CB  75 0F           jne 0x81dc
81CD  80 3E 2A 9A 00  cmp byte ptr [0x9a2a], 0
81D2  B0 00           mov al, 0
81D4  75 01           jne 0x81d7
81D6  40              inc ax
loc_81D7:
81D7  A2 2A 9A        mov byte ptr [0x9a2a], al
81DA  EB 2C           jmp 0x8208
loc_81DC:
81DC  80 3E 88 DE 01  cmp byte ptr [0xde88], 1
81E1  75 25           jne 0x8208
81E3  8B 7E 04        mov di, word ptr [bp + 4]
81E6  36 8A 45 E1     mov al, byte ptr ss:[di - 0x1f]
81EA  98              cwde
81EB  6B C0 0C        imul ax, ax, 0xc
81EE  03 F8           add di, ax
81F0  36 80 7D E6 00  cmp byte ptr ss:[di - 0x1a], 0
81F5  76 11           jbe 0x8208
81F7  8B 7E 04        mov di, word ptr [bp + 4]
81FA  36 8A 45 E1     mov al, byte ptr ss:[di - 0x1f]
81FE  98              cwde
81FF  6B C0 0C        imul ax, ax, 0xc
8202  03 F8           add di, ax
8204  36 FE 4D E6     dec byte ptr ss:[di - 0x1a]
loc_8208:
8208  8B 7E 04        mov di, word ptr [bp + 4]
820B  36 8A 45 E1     mov al, byte ptr ss:[di - 0x1f]
820F  98              cwde
8210  6B C0 0C        imul ax, ax, 0xc
8213  03 F8           add di, ax
8215  36 8A 45 E6     mov al, byte ptr ss:[di - 0x1a]
8219  30 E4           xor ah, ah
821B  3B 46 FC        cmp ax, word ptr [bp - 4]
821E  74 03           je 0x8223
8220  E9 96 FD        jmp 0x7fb9
loc_8223:
8223  C4 3E 96 D0     les di, ptr [0xd096]
8227  06              push es
8228  57              push di
8229  C4 3E 8A D0     les di, ptr [0xd08a]
822D  06              push es
822E  57              push di
822F  68 A0 0F        push 0xfa0
8232  9A 12 0A B9 26  call far 26B9:0A12
8237  8A 46 FA        mov al, byte ptr [bp - 6]
823A  A2 2A 9A        mov byte ptr [0x9a2a], al
loc_823D:
823D  9A 58 0C AC 24  call far 24AC:0C58
8242  08 C0           or al, al
8244  74 07           je 0x824d
8246  9A 9B 09 1A 23  call far 231A:099B
824B  EB F0           jmp 0x823d
loc_824D:
824D  C6 06 88 DE 00  mov byte ptr [0xde88], 0
8252  C9              leave
8253  C2 02 00        ret 2

; ---- routine 0AB5:8256  (found by: call)
sub_8256:
8256  C8 04 00 00     enter 4, 0
825A  C7 46 FE 01 00  mov word ptr [bp - 2], 1
825F  EB 03           jmp 0x8264
loc_8261:
8261  FF 46 FE        inc word ptr [bp - 2]
loc_8264:
8264  8B 7E 04        mov di, word ptr [bp + 4]
8267  36 8A 45 E1     mov al, byte ptr ss:[di - 0x1f]
826B  98              cwde
826C  8B F8           mov di, ax
826E  8A 85 56 0D     mov al, byte ptr [di + 0xd56]
8272  30 E4           xor ah, ah
8274  03 46 FE        add ax, word ptr [bp - 2]
8277  8A C8           mov cl, al
8279  8B 56 FE        mov dx, word ptr [bp - 2]
827C  8B 7E 04        mov di, word ptr [bp + 4]
827F  36 8A 45 E1     mov al, byte ptr ss:[di - 0x1f]
8283  98              cwde
8284  6B C0 0C        imul ax, ax, 0xc
8287  03 F8           add di, ax
8289  03 FA           add di, dx
828B  36 88 4D E6     mov byte ptr ss:[di - 0x1a], cl
828F  83 7E FE 0B     cmp word ptr [bp - 2], 0xb
8293  75 CC           jne 0x8261
8295  C7 46 FC 01 00  mov word ptr [bp - 4], 1
829A  EB 03           jmp 0x829f
loc_829C:
829C  FF 46 FC        inc word ptr [bp - 4]
loc_829F:
829F  8B 46 FC        mov ax, word ptr [bp - 4]
82A2  40              inc ax
82A3  3D 0B 00        cmp ax, 0xb
82A6  76 03           jbe 0x82ab
82A8  E9 9C 00        jmp 0x8347
loc_82AB:
82AB  89 46 FE        mov word ptr [bp - 2], ax
82AE  EB 03           jmp 0x82b3
loc_82B0:
82B0  FF 46 FE        inc word ptr [bp - 2]
loc_82B3:
82B3  6A 15           push 0x15
82B5  8B 56 FC        mov dx, word ptr [bp - 4]
82B8  8B 7E 04        mov di, word ptr [bp + 4]
82BB  36 8A 45 E1     mov al, byte ptr ss:[di - 0x1f]
82BF  98              cwde
82C0  6B C0 0C        imul ax, ax, 0xc
82C3  03 F8           add di, ax
82C5  03 FA           add di, dx
82C7  36 8A 45 E6     mov al, byte ptr ss:[di - 0x1a]
82CB  30 E4           xor ah, ah
82CD  6B F8 19        imul di, ax, 0x19
82D0  81 C7 EF CC     add di, 0xccef
82D4  1E              push ds
82D5  57              push di
82D6  0E              push cs
82D7  E8 08 98        call 0x1ae2
82DA  50              push ax
82DB  6A 15           push 0x15
82DD  8B 56 FE        mov dx, word ptr [bp - 2]
82E0  8B 7E 04        mov di, word ptr [bp + 4]
82E3  36 8A 45 E1     mov al, byte ptr ss:[di - 0x1f]
82E7  98              cwde
82E8  6B C0 0C        imul ax, ax, 0xc
82EB  03 F8           add di, ax
82ED  03 FA           add di, dx
82EF  36 8A 45 E6     mov al, byte ptr ss:[di - 0x1a]
82F3  30 E4           xor ah, ah
82F5  6B F8 19        imul di, ax, 0x19
82F8  81 C7 EF CC     add di, 0xccef
82FC  1E              push ds
82FD  57              push di
82FE  0E              push cs
82FF  E8 E0 97        call 0x1ae2
8302  5A              pop dx
8303  3B C2           cmp ax, dx
8305  76 37           jbe 0x833e
8307  8B 56 FE        mov dx, word ptr [bp - 2]
830A  8B 7E 04        mov di, word ptr [bp + 4]
830D  36 8A 45 E1     mov al, byte ptr ss:[di - 0x1f]
8311  98              cwde
8312  6B C0 0C        imul ax, ax, 0xc
8315  03 F8           add di, ax
8317  03 FA           add di, dx
8319  81 C7 E6 FF     add di, 0xffe6
831D  16              push ss
831E  57              push di
831F  8B 56 FC        mov dx, word ptr [bp - 4]
8322  8B 7E 04        mov di, word ptr [bp + 4]
8325  36 8A 45 E1     mov al, byte ptr ss:[di - 0x1f]
8329  98              cwde
832A  6B C0 0C        imul ax, ax, 0xc
832D  03 F8           add di, ax
832F  03 FA           add di, dx
8331  81 C7 E6 FF     add di, 0xffe6
8335  16              push ss
8336  57              push di
8337  6A 01           push 1
8339  9A 03 02 AC 24  call far 24AC:0203
loc_833E:
833E  83 7E FE 0B     cmp word ptr [bp - 2], 0xb
8342  74 03           je 0x8347
8344  E9 69 FF        jmp 0x82b0
loc_8347:
8347  83 7E FC 0A     cmp word ptr [bp - 4], 0xa
834B  74 03           je 0x8350
834D  E9 4C FF        jmp 0x829c
loc_8350:
8350  C9              leave
8351  C2 02 00        ret 2

