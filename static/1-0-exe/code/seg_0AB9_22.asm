; 1-0.EXE (One-Nil 96), code segment 0AB9 (image offsets 0AB90..1997F), part 22 of 22
; packed 1-0.EXE sha256 89ff9c5f238f24e81a0c2440a46cdd8997280a65fc3cc3d97cb974f55280a80a (LZEXE 0.91)
; unpacked (tools/static/unlzexe.py) sha256 887ed2a92767950e5309b2052409f875668605939b69e00737aa3047022b9f51
; tool: capstone 5.0.9 (pip package; core library 5.0.1280) (CS_ARCH_X86, CS_MODE_16), recursive descent from the entry point, far calls and near calls/jumps, then routine prologues (55 89 E5 / 55 8B EC / C8 iw 00) in what remains; tools/static/listing.py
; addresses are SEGMENT:OFFSET with SEGMENT the image paragraph before relocation; image offset = SEGMENT*16+OFFSET
; ---- routine 0AB9:E87A  (found by: call)
sub_E87A:
E87A  C8 08 00 00     enter 8, 0
E87E  A1 86 D6        mov ax, word ptr [0xd686]
E881  89 46 FC        mov word ptr [bp - 4], ax
E884  B8 01 00        mov ax, 1
E887  3B 46 FC        cmp ax, word ptr [bp - 4]
E88A  77 63           ja 0xe8ef
E88C  89 46 FE        mov word ptr [bp - 2], ax
E88F  EB 03           jmp 0xe894
loc_E891:
E891  FF 46 FE        inc word ptr [bp - 2]
loc_E894:
E894  8B 7E 04        mov di, word ptr [bp + 4]
E897  36 8B 45 06     mov ax, word ptr ss:[di + 6]
E89B  8B F0           mov si, ax
E89D  D1 E0           shl ax, 1
E89F  01 F0           add ax, si
E8A1  8B D0           mov dx, ax
E8A3  8B 7E FE        mov di, word ptr [bp - 2]
E8A6  8A 85 FB D4     mov al, byte ptr [di - 0x2b05]
E8AA  30 E4           xor ah, ah
E8AC  69 C0 AE 00     imul ax, ax, 0xae
E8B0  C4 3E CA D7     les di, ptr [0xd7ca]
E8B4  03 F8           add di, ax
E8B6  03 FA           add di, dx
E8B8  81 C7 4F FF     add di, 0xff4f
E8BC  26 8A 05        mov al, byte ptr es:[di]
E8BF  98              cwde
E8C0  8B F8           mov di, ax
E8C2  8A 85 0C 0D     mov al, byte ptr [di + 0xd0c]
E8C6  30 E4           xor ah, ah
E8C8  8B 7E 04        mov di, word ptr [bp + 4]
E8CB  36 3B 45 06     cmp ax, word ptr ss:[di + 6]
E8CF  75 16           jne 0xe8e7
E8D1  8B 7E FE        mov di, word ptr [bp - 2]
E8D4  8A 85 FB D4     mov al, byte ptr [di - 0x2b05]
E8D8  30 E4           xor ah, ah
E8DA  50              push ax
E8DB  8B 7E 04        mov di, word ptr [bp + 4]
E8DE  36 FF 75 06     push word ptr ss:[di + 6]
E8E2  9A D5 73 55 1B  call far 1B55:73D5
loc_E8E7:
E8E7  8B 46 FE        mov ax, word ptr [bp - 2]
E8EA  3B 46 FC        cmp ax, word ptr [bp - 4]
E8ED  75 A2           jne 0xe891
loc_E8EF:
E8EF  C9              leave
E8F0  C2 02 00        ret 2

; ---- routine 0AB9:E8F3  (found by: call)
sub_E8F3:
E8F3  C8 08 00 00     enter 8, 0
E8F7  8B 7E 04        mov di, word ptr [bp + 4]
E8FA  36 8B 45 06     mov ax, word ptr ss:[di + 6]
E8FE  8B F0           mov si, ax
E900  D1 E0           shl ax, 1
E902  01 F0           add ax, si
E904  8B D0           mov dx, ax
E906  36 8B 7D FE     mov di, word ptr ss:[di - 2]
E90A  8A 85 FB D4     mov al, byte ptr [di - 0x2b05]
E90E  30 E4           xor ah, ah
E910  69 C0 AE 00     imul ax, ax, 0xae
E914  C4 3E CA D7     les di, ptr [0xd7ca]
E918  03 F8           add di, ax
E91A  03 FA           add di, dx
E91C  81 C7 4F FF     add di, 0xff4f
E920  89 7E FC        mov word ptr [bp - 4], di
E923  8C 46 FE        mov word ptr [bp - 2], es
E926  8B 7E 04        mov di, word ptr [bp + 4]
E929  36 8B 7D FE     mov di, word ptr ss:[di - 2]
E92D  8A 85 FB D4     mov al, byte ptr [di - 0x2b05]
E931  30 E4           xor ah, ah
E933  50              push ax
E934  6A 00           push 0
E936  C4 7E FC        les di, ptr [bp - 4]
E939  26 8A 45 02     mov al, byte ptr es:[di + 2]
E93D  24 0F           and al, 0xf
E93F  3C 01           cmp al, 1
E941  B0 00           mov al, 0
E943  75 01           jne 0xe946
E945  40              inc ax
loc_E946:
E946  50              push ax
E947  9A EB 50 55 1B  call far 1B55:50EB
E94C  C4 7E FC        les di, ptr [bp - 4]
E94F  26 8A 45 01     mov al, byte ptr es:[di + 1]
E953  30 E4           xor ah, ah
E955  50              push ax
E956  6A 01           push 1
E958  6A 00           push 0
E95A  9A EB 50 55 1B  call far 1B55:50EB
E95F  6A 08           push 8
E961  E8 1F F0        call 0xd983
E964  8B 7E 04        mov di, word ptr [bp + 4]
E967  36 8B 7D FE     mov di, word ptr ss:[di - 2]
E96B  8A 85 FB D4     mov al, byte ptr [di - 0x2b05]
E96F  30 E4           xor ah, ah
E971  6B C0 3E        imul ax, ax, 0x3e
E974  C4 3E C2 D7     les di, ptr [0xd7c2]
E978  03 F8           add di, ax
E97A  26 80 7D F9 00  cmp byte ptr es:[di - 7], 0
E97F  75 2F           jne 0xe9b0
E981  C4 7E FC        les di, ptr [bp - 4]
E984  26 8A 45 01     mov al, byte ptr es:[di + 1]
E988  30 E4           xor ah, ah
E98A  6B C0 3E        imul ax, ax, 0x3e
E98D  C4 3E C2 D7     les di, ptr [0xd7c2]
E991  03 F8           add di, ax
E993  26 80 7D F9 00  cmp byte ptr es:[di - 7], 0
E998  75 16           jne 0xe9b0
E99A  80 3E 86 D0 01  cmp byte ptr [0xd086], 1
E99F  76 0F           jbe 0xe9b0
E9A1  80 3E 87 D0 01  cmp byte ptr [0xd087], 1
E9A6  76 08           jbe 0xe9b0
E9A8  FE 0E 86 D0     dec byte ptr [0xd086]
E9AC  FE 0E 87 D0     dec byte ptr [0xd087]
loc_E9B0:
E9B0  FF 36 86 D0     push word ptr [0xd086]
E9B4  8B 7E 04        mov di, word ptr [bp + 4]
E9B7  36 8B 55 06     mov dx, word ptr ss:[di + 6]
E9BB  36 8B 7D FE     mov di, word ptr ss:[di - 2]
E9BF  8A 85 FB D4     mov al, byte ptr [di - 0x2b05]
E9C3  30 E4           xor ah, ah
E9C5  6B C0 3A        imul ax, ax, 0x3a
E9C8  C4 3E CE D7     les di, ptr [0xd7ce]
E9CC  03 F8           add di, ax
E9CE  03 FA           add di, dx
E9D0  81 C7 C5 FF     add di, 0xffc5
E9D4  06              push es
E9D5  57              push di
E9D6  9A C5 01 2A 23  call far 232A:01C5
E9DB  C4 7E FC        les di, ptr [bp - 4]
E9DE  26 8A 45 02     mov al, byte ptr es:[di + 2]
E9E2  24 F0           and al, 0xf0
E9E4  30 E4           xor ah, ah
E9E6  C1 E8 04        shr ax, 4
E9E9  3D 01 00        cmp ax, 1
E9EC  74 03           je 0xe9f1
E9EE  E9 C1 00        jmp 0xeab2
loc_E9F1:
E9F1  8B 7E 04        mov di, word ptr [bp + 4]
E9F4  36 8B 7D FE     mov di, word ptr ss:[di - 2]
E9F8  8A 85 FB D4     mov al, byte ptr [di - 0x2b05]
E9FC  30 E4           xor ah, ah
E9FE  50              push ax
E9FF  8B 7E 04        mov di, word ptr [bp + 4]
EA02  36 FF 75 06     push word ptr ss:[di + 6]
EA06  E8 FB EE        call 0xd904
EA09  08 C0           or al, al
EA0B  75 03           jne 0xea10
EA0D  E9 A2 00        jmp 0xeab2
loc_EA10:
EA10  6A 03           push 3
EA12  E8 6E EF        call 0xd983
EA15  FF 36 86 D0     push word ptr [0xd086]
EA19  8B 7E 04        mov di, word ptr [bp + 4]
EA1C  36 8B 55 06     mov dx, word ptr ss:[di + 6]
EA20  36 8B 7D FE     mov di, word ptr ss:[di - 2]
EA24  8A 85 FB D4     mov al, byte ptr [di - 0x2b05]
EA28  30 E4           xor ah, ah
EA2A  6B C0 3A        imul ax, ax, 0x3a
EA2D  C4 3E CE D7     les di, ptr [0xd7ce]
EA31  03 F8           add di, ax
EA33  03 FA           add di, dx
EA35  81 C7 C5 FF     add di, 0xffc5
EA39  06              push es
EA3A  57              push di
EA3B  9A C5 01 2A 23  call far 232A:01C5
EA40  8B 7E 04        mov di, word ptr [bp + 4]
EA43  36 8B 7D FE     mov di, word ptr ss:[di - 2]
EA47  8A 85 FB D4     mov al, byte ptr [di - 0x2b05]
EA4B  30 E4           xor ah, ah
EA4D  50              push ax
EA4E  8B 7E 04        mov di, word ptr [bp + 4]
EA51  36 FF 75 06     push word ptr ss:[di + 6]
EA55  E8 AC EE        call 0xd904
EA58  08 C0           or al, al
EA5A  74 56           je 0xeab2
EA5C  6A 02           push 2
EA5E  9A 1C 0D BC 24  call far 24BC:0D1C
EA63  08 C0           or al, al
EA65  74 14           je 0xea7b
EA67  C4 7E FC        les di, ptr [bp - 4]
EA6A  26 8A 45 02     mov al, byte ptr es:[di + 2]
EA6E  24 0F           and al, 0xf
EA70  30 E4           xor ah, ah
EA72  05 80 00        add ax, 0x80
EA75  26 88 45 02     mov byte ptr es:[di + 2], al
EA79  EB 37           jmp 0xeab2
loc_EA7B:
EA7B  8B 7E 04        mov di, word ptr [bp + 4]
EA7E  36 8B 45 06     mov ax, word ptr ss:[di + 6]
EA82  8B F0           mov si, ax
EA84  D1 E0           shl ax, 1
EA86  01 F0           add ax, si
EA88  8B D0           mov dx, ax
EA8A  C4 7E FC        les di, ptr [bp - 4]
EA8D  26 8A 45 01     mov al, byte ptr es:[di + 1]
EA91  30 E4           xor ah, ah
EA93  69 C0 AE 00     imul ax, ax, 0xae
EA97  C4 3E CA D7     les di, ptr [0xd7ca]
EA9B  03 F8           add di, ax
EA9D  03 FA           add di, dx
EA9F  81 C7 4F FF     add di, 0xff4f
EAA3  26 8A 45 02     mov al, byte ptr es:[di + 2]
EAA7  24 0F           and al, 0xf
EAA9  30 E4           xor ah, ah
EAAB  05 80 00        add ax, 0x80
EAAE  26 88 45 02     mov byte ptr es:[di + 2], al
loc_EAB2:
EAB2  C9              leave
EAB3  C2 02 00        ret 2

; ---- routine 0AB9:EAB6  (found by: far)
sub_EAB6:
EAB6  C8 0E 00 00     enter 0xe, 0
EABA  C6 06 84 D0 00  mov byte ptr [0xd084], 0
EABF  31 C0           xor ax, ax
EAC1  A3 44 D1        mov word ptr [0xd144], ax
EAC4  A3 46 D1        mov word ptr [0xd146], ax
EAC7  FF 76 06        push word ptr [bp + 6]
EACA  9A 1A 42 55 1B  call far 1B55:421A
EACF  A1 86 D6        mov ax, word ptr [0xd686]
EAD2  89 46 F6        mov word ptr [bp - 0xa], ax
EAD5  B8 01 00        mov ax, 1
EAD8  3B 46 F6        cmp ax, word ptr [bp - 0xa]
EADB  77 75           ja 0xeb52
EADD  89 46 FE        mov word ptr [bp - 2], ax
EAE0  EB 03           jmp 0xeae5
loc_EAE2:
EAE2  FF 46 FE        inc word ptr [bp - 2]
loc_EAE5:
EAE5  8B 46 06        mov ax, word ptr [bp + 6]
EAE8  8B F0           mov si, ax
EAEA  D1 E0           shl ax, 1
EAEC  01 F0           add ax, si
EAEE  8B D0           mov dx, ax
EAF0  8B 7E FE        mov di, word ptr [bp - 2]
EAF3  8A 85 FB D4     mov al, byte ptr [di - 0x2b05]
EAF7  30 E4           xor ah, ah
EAF9  69 C0 AE 00     imul ax, ax, 0xae
EAFD  C4 3E CA D7     les di, ptr [0xd7ca]
EB01  03 F8           add di, ax
EB03  03 FA           add di, dx
EB05  81 C7 4F FF     add di, 0xff4f
EB09  89 7E F2        mov word ptr [bp - 0xe], di
EB0C  8C 46 F4        mov word ptr [bp - 0xc], es
EB0F  8B 7E FE        mov di, word ptr [bp - 2]
EB12  8A 85 FB D4     mov al, byte ptr [di - 0x2b05]
EB16  30 E4           xor ah, ah
EB18  50              push ax
EB19  FF 76 06        push word ptr [bp + 6]
EB1C  E8 5A F9        call 0xe479
EB1F  08 C0           or al, al
EB21  74 27           je 0xeb4a
EB23  8B 7E FE        mov di, word ptr [bp - 2]
EB26  8A 85 FB D4     mov al, byte ptr [di - 0x2b05]
EB2A  30 E4           xor ah, ah
EB2C  50              push ax
EB2D  C4 7E F2        les di, ptr [bp - 0xe]
EB30  26 8A 45 01     mov al, byte ptr es:[di + 1]
EB34  30 E4           xor ah, ah
EB36  50              push ax
EB37  9A 99 1B 98 19  call far 1998:1B99
EB3C  08 C0           or al, al
EB3E  74 0A           je 0xeb4a
EB40  8B 7E FE        mov di, word ptr [bp - 2]
EB43  8A 85 FB D4     mov al, byte ptr [di - 0x2b05]
EB47  A2 84 D0        mov byte ptr [0xd084], al
loc_EB4A:
EB4A  8B 46 FE        mov ax, word ptr [bp - 2]
EB4D  3B 46 F6        cmp ax, word ptr [bp - 0xa]
EB50  75 90           jne 0xeae2
loc_EB52:
EB52  A1 86 D6        mov ax, word ptr [0xd686]
EB55  89 46 F6        mov word ptr [bp - 0xa], ax
EB58  B8 01 00        mov ax, 1
EB5B  3B 46 F6        cmp ax, word ptr [bp - 0xa]
EB5E  76 03           jbe 0xeb63
EB60  E9 8E 00        jmp 0xebf1
loc_EB63:
EB63  89 46 FE        mov word ptr [bp - 2], ax
EB66  EB 03           jmp 0xeb6b
loc_EB68:
EB68  FF 46 FE        inc word ptr [bp - 2]
loc_EB6B:
EB6B  8B 46 06        mov ax, word ptr [bp + 6]
EB6E  8B F0           mov si, ax
EB70  D1 E0           shl ax, 1
EB72  01 F0           add ax, si
EB74  8B D0           mov dx, ax
EB76  8B 7E FE        mov di, word ptr [bp - 2]
EB79  8A 85 FB D4     mov al, byte ptr [di - 0x2b05]
EB7D  30 E4           xor ah, ah
EB7F  69 C0 AE 00     imul ax, ax, 0xae
EB83  C4 3E CA D7     les di, ptr [0xd7ca]
EB87  03 F8           add di, ax
EB89  03 FA           add di, dx
EB8B  81 C7 4F FF     add di, 0xff4f
EB8F  89 7E F2        mov word ptr [bp - 0xe], di
EB92  8C 46 F4        mov word ptr [bp - 0xc], es
EB95  8B 7E FE        mov di, word ptr [bp - 2]
EB98  8A 85 FB D4     mov al, byte ptr [di - 0x2b05]
EB9C  30 E4           xor ah, ah
EB9E  50              push ax
EB9F  FF 76 06        push word ptr [bp + 6]
EBA2  E8 D4 F8        call 0xe479
EBA5  08 C0           or al, al
EBA7  74 3D           je 0xebe6
EBA9  8B 7E FE        mov di, word ptr [bp - 2]
EBAC  8A 85 FB D4     mov al, byte ptr [di - 0x2b05]
EBB0  30 E4           xor ah, ah
EBB2  50              push ax
EBB3  C4 7E F2        les di, ptr [bp - 0xe]
EBB6  26 8A 45 01     mov al, byte ptr es:[di + 1]
EBBA  30 E4           xor ah, ah
EBBC  50              push ax
EBBD  9A 99 1B 98 19  call far 1998:1B99
EBC2  08 C0           or al, al
EBC4  74 20           je 0xebe6
EBC6  6A 01           push 1
EBC8  55              push bp
EBC9  E8 23 FA        call 0xe5ef
EBCC  80 7E F9 00     cmp byte ptr [bp - 7], 0
EBD0  74 14           je 0xebe6
EBD2  8B 7E FE        mov di, word ptr [bp - 2]
EBD5  8A 85 FB D4     mov al, byte ptr [di - 0x2b05]
EBD9  30 E4           xor ah, ah
EBDB  50              push ax
EBDC  FF 76 06        push word ptr [bp + 6]
EBDF  E8 10 F6        call 0xe1f2
EBE2  55              push bp
EBE3  E8 93 FA        call 0xe679
loc_EBE6:
EBE6  8B 46 FE        mov ax, word ptr [bp - 2]
EBE9  3B 46 F6        cmp ax, word ptr [bp - 0xa]
EBEC  74 03           je 0xebf1
EBEE  E9 77 FF        jmp 0xeb68
loc_EBF1:
EBF1  A1 86 D6        mov ax, word ptr [0xd686]
EBF4  89 46 F6        mov word ptr [bp - 0xa], ax
EBF7  B8 01 00        mov ax, 1
EBFA  3B 46 F6        cmp ax, word ptr [bp - 0xa]
EBFD  76 03           jbe 0xec02
EBFF  E9 D6 00        jmp 0xecd8
loc_EC02:
EC02  89 46 FE        mov word ptr [bp - 2], ax
EC05  EB 03           jmp 0xec0a
loc_EC07:
EC07  FF 46 FE        inc word ptr [bp - 2]
loc_EC0A:
EC0A  8B 46 06        mov ax, word ptr [bp + 6]
EC0D  8B F0           mov si, ax
EC0F  D1 E0           shl ax, 1
EC11  01 F0           add ax, si
EC13  8B D0           mov dx, ax
EC15  8B 7E FE        mov di, word ptr [bp - 2]
EC18  8A 85 FB D4     mov al, byte ptr [di - 0x2b05]
EC1C  30 E4           xor ah, ah
EC1E  69 C0 AE 00     imul ax, ax, 0xae
EC22  C4 3E CA D7     les di, ptr [0xd7ca]
EC26  03 F8           add di, ax
EC28  03 FA           add di, dx
EC2A  81 C7 4F FF     add di, 0xff4f
EC2E  89 7E F2        mov word ptr [bp - 0xe], di
EC31  8C 46 F4        mov word ptr [bp - 0xc], es
EC34  8B 7E FE        mov di, word ptr [bp - 2]
EC37  8A 85 FB D4     mov al, byte ptr [di - 0x2b05]
EC3B  30 E4           xor ah, ah
EC3D  50              push ax
EC3E  FF 76 06        push word ptr [bp + 6]
EC41  E8 35 F8        call 0xe479
EC44  08 C0           or al, al
EC46  75 03           jne 0xec4b
EC48  E9 82 00        jmp 0xeccd
loc_EC4B:
EC4B  6A 00           push 0
EC4D  55              push bp
EC4E  E8 9E F9        call 0xe5ef
EC51  8B 7E FE        mov di, word ptr [bp - 2]
EC54  8A 85 FB D4     mov al, byte ptr [di - 0x2b05]
EC58  30 E4           xor ah, ah
EC5A  50              push ax
EC5B  E8 4E B0        call 0x9cac
EC5E  C4 7E F2        les di, ptr [bp - 0xe]
EC61  26 8A 45 01     mov al, byte ptr es:[di + 1]
EC65  30 E4           xor ah, ah
EC67  50              push ax
EC68  E8 41 B0        call 0x9cac
EC6B  55              push bp
EC6C  E8 84 FC        call 0xe8f3
EC6F  55              push bp
EC70  E8 06 FA        call 0xe679
EC73  BF E8 30        mov di, 0x30e8
EC76  1E              push ds
EC77  57              push di
EC78  BF 5C DD        mov di, 0xdd5c
EC7B  1E              push ds
EC7C  57              push di
EC7D  9A 2F 05 2A 23  call far 232A:052F
EC82  C4 3E 5C DD     les di, ptr [0xdd5c]
EC86  81 C7 00 0F     add di, 0xf00
EC8A  06              push es
EC8B  57              push di
EC8C  6A 70           push 0x70
EC8E  6B 46 FE 50     imul ax, word ptr [bp - 2], 0x50
EC92  31 D2           xor dx, dx
EC94  F7 36 86 D6     div word ptr [0xd686]
EC98  50              push ax
EC99  9A 4B 03 BC 24  call far 24BC:034B
EC9E  C4 3E 5C DD     les di, ptr [0xdd5c]
ECA2  81 C7 00 0F     add di, 0xf00
ECA6  06              push es
ECA7  57              push di
ECA8  C4 3E 58 DD     les di, ptr [0xdd58]
ECAC  81 C7 00 0F     add di, 0xf00
ECB0  06              push es
ECB1  57              push di
ECB2  68 A0 00        push 0xa0
ECB5  9A 12 0A C9 26  call far 26C9:0A12
ECBA  9A 58 0C BC 24  call far 24BC:0C58
ECBF  08 C0           or al, al
ECC1  74 0A           je 0xeccd
ECC3  9A 9B 09 2A 23  call far 232A:099B
ECC8  C6 06 84 D0 00  mov byte ptr [0xd084], 0
loc_ECCD:
ECCD  8B 46 FE        mov ax, word ptr [bp - 2]
ECD0  3B 46 F6        cmp ax, word ptr [bp - 0xa]
ECD3  74 03           je 0xecd8
ECD5  E9 2F FF        jmp 0xec07
loc_ECD8:
ECD8  8B 7E 06        mov di, word ptr [bp + 6]
ECDB  80 BD 6A A2 00  cmp byte ptr [di - 0x5d96], 0
ECE0  74 03           je 0xece5
ECE2  E9 7D 00        jmp 0xed62
loc_ECE5:
ECE5  E8 58 AB        call 0x9840
ECE8  C7 46 FE 51 00  mov word ptr [bp - 2], 0x51
ECED  EB 03           jmp 0xecf2
loc_ECEF:
ECEF  FF 46 FE        inc word ptr [bp - 2]
loc_ECF2:
ECF2  8B 46 06        mov ax, word ptr [bp + 6]
ECF5  8B F0           mov si, ax
ECF7  D1 E0           shl ax, 1
ECF9  01 F0           add ax, si
ECFB  8B D0           mov dx, ax
ECFD  8B 7E FE        mov di, word ptr [bp - 2]
ED00  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
ED04  30 E4           xor ah, ah
ED06  69 C0 AE 00     imul ax, ax, 0xae
ED0A  C4 3E CA D7     les di, ptr [0xd7ca]
ED0E  03 F8           add di, ax
ED10  03 FA           add di, dx
ED12  81 C7 4F FF     add di, 0xff4f
ED16  26 80 7D 01 00  cmp byte ptr es:[di + 1], 0
ED1B  75 3E           jne 0xed5b
ED1D  6A 04           push 4
ED1F  9A 6D 07 2A 23  call far 232A:076D
ED24  48              dec ax
ED25  A2 86 D0        mov byte ptr [0xd086], al
ED28  6A 04           push 4
ED2A  9A 6D 07 2A 23  call far 232A:076D
ED2F  48              dec ax
ED30  A2 87 D0        mov byte ptr [0xd087], al
ED33  8B 7E FE        mov di, word ptr [bp - 2]
ED36  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
ED3A  30 E4           xor ah, ah
ED3C  50              push ax
ED3D  E8 6C AF        call 0x9cac
ED40  8B 7E FE        mov di, word ptr [bp - 2]
ED43  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
ED47  30 E4           xor ah, ah
ED49  50              push ax
ED4A  A0 86 D0        mov al, byte ptr [0xd086]
ED4D  30 E4           xor ah, ah
ED4F  50              push ax
ED50  A0 87 D0        mov al, byte ptr [0xd087]
ED53  30 E4           xor ah, ah
ED55  50              push ax
ED56  9A 97 18 98 19  call far 1998:1897
loc_ED5B:
ED5B  81 7E FE B0 00  cmp word ptr [bp - 2], 0xb0
ED60  75 8D           jne 0xecef
loc_ED62:
ED62  80 3E 84 D0 00  cmp byte ptr [0xd084], 0
ED67  74 14           je 0xed7d
ED69  BF DA 4E        mov di, 0x4eda
ED6C  1E              push ds
ED6D  57              push di
ED6E  BF 58 DD        mov di, 0xdd58
ED71  1E              push ds
ED72  57              push di
ED73  9A 2F 05 2A 23  call far 232A:052F
ED78  9A 9B 09 2A 23  call far 232A:099B
loc_ED7D:
ED7D  8B 7E 06        mov di, word ptr [bp + 6]
ED80  80 BD 6A A2 00  cmp byte ptr [di - 0x5d96], 0
ED85  74 04           je 0xed8b
ED87  55              push bp
ED88  E8 EF FA        call 0xe87a
loc_ED8B:
ED8B  C9              leave
ED8C  CA 02 00        retf 2

; ---- routine 0AB9:ED8F  (found by: far)
sub_ED8F:
ED8F  55              push bp
ED90  89 E5           mov bp, sp
ED92  C4 3E 58 DD     les di, ptr [0xdd58]
ED96  89 F8           mov ax, di
ED98  8C C2           mov dx, es
ED9A  A3 9A D0        mov word ptr [0xd09a], ax
ED9D  89 16 9C D0     mov word ptr [0xd09c], dx
EDA1  C4 3E 9A D0     les di, ptr [0xd09a]
EDA5  89 F8           mov ax, di
EDA7  8C C2           mov dx, es
EDA9  A3 8A D0        mov word ptr [0xd08a], ax
EDAC  89 16 8C D0     mov word ptr [0xd08c], dx
EDB0  C4 3E 5C DD     les di, ptr [0xdd5c]
EDB4  89 F8           mov ax, di
EDB6  8C C2           mov dx, es
EDB8  A3 8E D0        mov word ptr [0xd08e], ax
EDBB  89 16 90 D0     mov word ptr [0xd090], dx
EDBF  BF 92 D0        mov di, 0xd092
EDC2  1E              push ds
EDC3  57              push di
EDC4  68 A0 0F        push 0xfa0
EDC7  9A 85 14 BC 24  call far 24BC:1485
EDCC  C4 3E 60 DD     les di, ptr [0xdd60]
EDD0  89 F8           mov ax, di
EDD2  8C C2           mov dx, es
EDD4  A3 96 D0        mov word ptr [0xd096], ax
EDD7  89 16 98 D0     mov word ptr [0xd098], dx
EDDB  C4 3E 26 DE     les di, ptr [0xde26]
EDDF  26 8B 05        mov ax, word ptr es:[di]
EDE2  A3 D0 D0        mov word ptr [0xd0d0], ax
EDE5  C9              leave
EDE6  CB              retf
; data (not reached as code), 9 bytes
EDE7                  db 00 00 00 00 00 00 00 00 00   ; .........
