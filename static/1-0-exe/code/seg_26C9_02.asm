; 1-0.EXE (One-Nil 96), code segment 26C9 (image offsets 26C90..2863F), part 2 of 3
; packed 1-0.EXE sha256 89ff9c5f238f24e81a0c2440a46cdd8997280a65fc3cc3d97cb974f55280a80a (LZEXE 0.91)
; unpacked (tools/static/unlzexe.py) sha256 887ed2a92767950e5309b2052409f875668605939b69e00737aa3047022b9f51
; tool: capstone 5.0.9 (pip package; core library 5.0.1280) (CS_ARCH_X86, CS_MODE_16), recursive descent from the entry point, far calls and near calls/jumps, then routine prologues (55 89 E5 / 55 8B EC / C8 iw 00) in what remains; tools/static/listing.py
; addresses are SEGMENT:OFFSET with SEGMENT the image paragraph before relocation; image offset = SEGMENT*16+OFFSET
; ---- routine 26C9:097D  (found by: prologue)
sub_097D:
097D  55              push bp
097E  8B EC           mov bp, sp
0980  81 EC 80 00     sub sp, 0x80
0984  E8 61 00        call 0x9e8
0987  8B 46 80        mov ax, word ptr [bp - 0x80]
098A  0A C0           or al, al
098C  74 2A           je 0x9b8
098E  80 FC 3A        cmp ah, 0x3a
0991  75 20           jne 0x9b3
0993  24 DF           and al, 0xdf
0995  2C 41           sub al, 0x41
0997  8A D0           mov dl, al
0999  B4 0E           mov ah, 0xe
099B  CD 21           int 0x21   ; INT 21h AH=0E select drive
099D  B4 19           mov ah, 0x19
099F  CD 21           int 0x21   ; INT 21h AH=19 get drive
09A1  3A C2           cmp al, dl
09A3  74 08           je 0x9ad
09A5  C7 06 1A A5 0F 00 mov word ptr [0xa51a], 0xf
09AB  EB 0B           jmp 0x9b8
loc_09AD:
09AD  80 7E 82 00     cmp byte ptr [bp - 0x7e], 0
09B1  74 05           je 0x9b8
loc_09B3:
09B3  B4 3B           mov ah, 0x3b
09B5  E8 4B 00        call 0xa03
loc_09B8:
09B8  8B E5           mov sp, bp
09BA  5D              pop bp
09BB  CA 04 00        retf 4

; ---- routine 26C9:09BE  (found by: prologue)
sub_09BE:
09BE  55              push bp
09BF  8B EC           mov bp, sp
09C1  81 EC 80 00     sub sp, 0x80
09C5  E8 20 00        call 0x9e8
09C8  B4 39           mov ah, 0x39
09CA  E8 36 00        call 0xa03
09CD  8B E5           mov sp, bp
09CF  5D              pop bp
09D0  CA 04 00        retf 4

; ---- routine 26C9:09D3  (found by: prologue)
sub_09D3:
09D3  55              push bp
09D4  8B EC           mov bp, sp
09D6  81 EC 80 00     sub sp, 0x80
09DA  E8 0B 00        call 0x9e8
09DD  B4 3A           mov ah, 0x3a
09DF  E8 21 00        call 0xa03
09E2  8B E5           mov sp, bp
09E4  5D              pop bp
09E5  CA 04 00        retf 4

; ---- routine 26C9:09E8  (found by: call)
sub_09E8:
09E8  1E              push ds
09E9  C5 76 06        lds si, ptr [bp + 6]
09EC  8D 7E 80        lea di, [bp - 0x80]
09EF  16              push ss
09F0  07              pop es
09F1  FC              cld
09F2  AC              lodsb al, byte ptr [si]
09F3  3C 7F           cmp al, 0x7f
09F5  72 02           jb 0x9f9
09F7  B0 7F           mov al, 0x7f
loc_09F9:
09F9  98              cwde
09FA  8B C8           mov cx, ax
09FC  F3 A4           rep movsb byte ptr es:[di], byte ptr [si]
09FE  32 C0           xor al, al
0A00  AA              stosb byte ptr es:[di], al
0A01  1F              pop ds
0A02  C3              ret

; ---- routine 26C9:0A03  (found by: call)
sub_0A03:
0A03  1E              push ds
0A04  8D 56 80        lea dx, [bp - 0x80]
0A07  16              push ss
0A08  1F              pop ds
0A09  CD 21           int 0x21   ; INT 21h, AH not set by a nearby mov
0A0B  1F              pop ds
0A0C  73 03           jae 0xa11
0A0E  A3 1A A5        mov word ptr [0xa51a], ax
loc_0A11:
0A11  C3              ret

; ---- routine 26C9:0A12  (found by: far)
sub_0A12:
0A12  8B DC           mov bx, sp
0A14  8C DA           mov dx, ds
0A16  36 C5 77 0A     lds si, ptr ss:[bx + 0xa]
0A1A  36 C4 7F 06     les di, ptr ss:[bx + 6]
0A1E  36 8B 4F 04     mov cx, word ptr ss:[bx + 4]
0A22  FC              cld
0A23  F3 A4           rep movsb byte ptr es:[di], byte ptr [si]
0A25  8E DA           mov ds, dx
0A27  CA 0A 00        retf 0xa

; ---- routine 26C9:0A2A  (found by: far)
sub_0A2A:
0A2A  80 3E 2A A5 02  cmp byte ptr [0xa52a], 2
0A2F  72 1B           jb 0xa4c
0A31  66 C1 E0 10     shl eax, 0x10
0A35  66 0F AC D0 10  shrd eax, edx, 0x10
0A3A  66 C1 E1 10     shl ecx, 0x10
0A3E  66 0F AC D9 10  shrd ecx, ebx, 0x10
0A43  66 F7 E9        imul ecx
0A46  66 0F A4 C2 10  shld edx, eax, 0x10
0A4B  CB              retf
loc_0A4C:
0A4C  8B F0           mov si, ax
0A4E  8B FA           mov di, dx
0A50  F7 E1           mul cx
0A52  50              push ax
0A53  52              push dx
0A54  8B C6           mov ax, si
0A56  F7 E3           mul bx
0A58  8B D8           mov bx, ax
0A5A  8B C7           mov ax, di
0A5C  F7 E1           mul cx
0A5E  8B C8           mov cx, ax
0A60  5A              pop dx
0A61  58              pop ax
0A62  03 D3           add dx, bx
0A64  03 D1           add dx, cx
0A66  CB              retf

; ---- routine 26C9:0A67  (found by: far)
sub_0A67:
0A67  80 3E 2A A5 02  cmp byte ptr [0xa52a], 2
0A6C  72 27           jb 0xa95
0A6E  66 C1 E0 10     shl eax, 0x10
0A72  66 0F AC D0 10  shrd eax, edx, 0x10
0A77  66 C1 E1 10     shl ecx, 0x10
0A7B  66 0F AC D9 10  shrd ecx, ebx, 0x10
0A80  74 5E           je 0xae0
0A82  66 99           cdq
0A84  66 F7 F9        idiv ecx
0A87  66 8B CA        mov ecx, edx
0A8A  66 0F A4 C2 10  shld edx, eax, 0x10
0A8F  66 0F A4 CB 10  shld ebx, ecx, 0x10
0A94  CB              retf
loc_0A95:
0A95  55              push bp
0A96  33 ED           xor bp, bp
0A98  0B D2           or dx, dx
0A9A  79 08           jns 0xaa4
0A9C  45              inc bp
0A9D  F7 D8           neg ax
0A9F  83 D2 00        adc dx, 0
0AA2  F7 DA           neg dx
loc_0AA4:
0AA4  0B DB           or bx, bx
0AA6  74 3E           je 0xae6
0AA8  79 0B           jns 0xab5
0AAA  45              inc bp
0AAB  45              inc bp
0AAC  F7 D9           neg cx
0AAE  83 D3 00        adc bx, 0
0AB1  F7 DB           neg bx
0AB3  74 33           je 0xae8
loc_0AB5:
0AB5  55              push bp
0AB6  8B F1           mov si, cx
0AB8  8B FB           mov di, bx
0ABA  33 DB           xor bx, bx
0ABC  8B CA           mov cx, dx
0ABE  8B D0           mov dx, ax
0AC0  33 C0           xor ax, ax
0AC2  BD 10 00        mov bp, 0x10
loc_0AC5:
0AC5  D1 E0           shl ax, 1
0AC7  D1 D2           rcl dx, 1
0AC9  D1 D1           rcl cx, 1
0ACB  D1 D3           rcl bx, 1
0ACD  40              inc ax
0ACE  2B CE           sub cx, si
0AD0  1B DF           sbb bx, di
0AD2  73 05           jae 0xad9
0AD4  48              dec ax
0AD5  03 CE           add cx, si
0AD7  13 DF           adc bx, di
loc_0AD9:
0AD9  4D              dec bp
0ADA  75 E9           jne 0xac5
0ADC  5D              pop bp
0ADD  EB 16           jmp 0xaf5
loc_0ADF:
0ADF  5D              pop bp
loc_0AE0:
0AE0  B8 C8 00        mov ax, 0xc8
0AE3  E9 29 F6        jmp 0x10f
loc_0AE6:
0AE6  E3 F7           jcxz 0xadf
loc_0AE8:
0AE8  93              xchg bx, ax
0AE9  92              xchg dx, ax
0AEA  F7 F1           div cx
0AEC  93              xchg bx, ax
0AED  F7 F1           div cx
0AEF  8B CA           mov cx, dx
0AF1  8B D3           mov dx, bx
0AF3  33 DB           xor bx, bx
loc_0AF5:
0AF5  D1 ED           shr bp, 1
0AF7  73 08           jae 0xb01
0AF9  F7 D9           neg cx
0AFB  83 D3 00        adc bx, 0
0AFE  F7 DB           neg bx
0B00  45              inc bp
loc_0B01:
0B01  4D              dec bp
0B02  75 07           jne 0xb0b
0B04  F7 D8           neg ax
0B06  83 D2 00        adc dx, 0
0B09  F7 DA           neg dx
loc_0B0B:
0B0B  5D              pop bp
0B0C  CB              retf
; data (not reached as code), 70 bytes
0B0D                  db 80 3E 2A A5 02 72 10 66 C1 E2 10 8B D0 66 D3 EA   ; .>*..r.f.....f..
0B1D                  db 8B C2 66 C1 EA 10 CB 83 E1 1F 74 06 D1 EA D1 D8   ; ..f.......t.....
0B2D                  db E2 FA CB 80 3E 2A A5 02 72 10 66 C1 E2 10 8B D0   ; ....>*..r.f.....
0B3D                  db 66 D3 E2 8B C2 66 C1 EA 10 CB 83 E1 1F 74 06 D1   ; f....f.......t..
0B4D                  db E0 D1 D2 E2 FA CB   ; ......

; ---- routine 26C9:0B53  (found by: far)
sub_0B53:
0B53  FC              cld
0B54  8B DC           mov bx, sp
0B56  8C DA           mov dx, ds
0B58  36 C4 7F 08     les di, ptr ss:[bx + 8]
0B5C  36 C5 77 04     lds si, ptr ss:[bx + 4]
0B60  AC              lodsb al, byte ptr [si]
0B61  AA              stosb byte ptr es:[di], al
0B62  8A C8           mov cl, al
0B64  32 ED           xor ch, ch
0B66  F3 A4           rep movsb byte ptr es:[di], byte ptr [si]
0B68  8E DA           mov ds, dx
0B6A  CA 04 00        retf 4

; ---- routine 26C9:0B6D  (found by: call, far)
sub_0B6D:
0B6D  FC              cld
0B6E  8B DC           mov bx, sp
0B70  8C DA           mov dx, ds
0B72  36 C5 77 0A     lds si, ptr ss:[bx + 0xa]
0B76  36 C4 7F 06     les di, ptr ss:[bx + 6]
0B7A  36 8B 4F 04     mov cx, word ptr ss:[bx + 4]
0B7E  AC              lodsb al, byte ptr [si]
0B7F  3A C1           cmp al, cl
0B81  76 02           jbe 0xb85
0B83  8A C1           mov al, cl
loc_0B85:
0B85  AA              stosb byte ptr es:[di], al
0B86  8A C8           mov cl, al
0B88  32 ED           xor ch, ch
0B8A  F3 A4           rep movsb byte ptr es:[di], byte ptr [si]
0B8C  8E DA           mov ds, dx
0B8E  CA 0A 00        retf 0xa

; ---- routine 26C9:0B91  (found by: call, far)
sub_0B91:
0B91  FC              cld
0B92  8B DC           mov bx, sp
0B94  8C DA           mov dx, ds
0B96  36 C4 7F 0C     les di, ptr ss:[bx + 0xc]
0B9A  36 C5 77 08     lds si, ptr ss:[bx + 8]
0B9E  8A 04           mov al, byte ptr [si]
0BA0  32 E4           xor ah, ah
0BA2  36 8B 4F 06     mov cx, word ptr ss:[bx + 6]
0BA6  0B C9           or cx, cx
0BA8  7F 03           jg 0xbad
0BAA  B9 01 00        mov cx, 1
loc_0BAD:
0BAD  03 F1           add si, cx
0BAF  2B C1           sub ax, cx
0BB1  72 13           jb 0xbc6
0BB3  40              inc ax
0BB4  36 8B 4F 04     mov cx, word ptr ss:[bx + 4]
0BB8  0B C9           or cx, cx
0BBA  7D 02           jge 0xbbe
0BBC  33 C9           xor cx, cx
loc_0BBE:
0BBE  3B C1           cmp ax, cx
0BC0  76 06           jbe 0xbc8
0BC2  8B C1           mov ax, cx
0BC4  EB 02           jmp 0xbc8
loc_0BC6:
0BC6  33 C0           xor ax, ax
loc_0BC8:
0BC8  AA              stosb byte ptr es:[di], al
0BC9  8B C8           mov cx, ax
0BCB  F3 A4           rep movsb byte ptr es:[di], byte ptr [si]
0BCD  8E DA           mov ds, dx
0BCF  CA 08 00        retf 8

; ---- routine 26C9:0BD2  (found by: call, far)
sub_0BD2:
0BD2  FC              cld
0BD3  8B DC           mov bx, sp
0BD5  8C DA           mov dx, ds
0BD7  36 C4 7F 08     les di, ptr ss:[bx + 8]
0BDB  36 C5 77 04     lds si, ptr ss:[bx + 4]
0BDF  26 8A 0D        mov cl, byte ptr es:[di]
0BE2  32 ED           xor ch, ch
0BE4  AC              lodsb al, byte ptr [si]
0BE5  26 00 05        add byte ptr es:[di], al
0BE8  73 08           jae 0xbf2
0BEA  26 C6 05 FF     mov byte ptr es:[di], 0xff
0BEE  8A C1           mov al, cl
0BF0  F6 D0           not al
loc_0BF2:
0BF2  03 F9           add di, cx
0BF4  47              inc di
0BF5  8A C8           mov cl, al
0BF7  F3 A4           rep movsb byte ptr es:[di], byte ptr [si]
0BF9  8E DA           mov ds, dx
0BFB  CA 04 00        retf 4

; ---- routine 26C9:0BFE  (found by: far)
sub_0BFE:
0BFE  55              push bp
0BFF  8B EC           mov bp, sp
0C01  1E              push ds
0C02  C5 76 0A        lds si, ptr [bp + 0xa]
0C05  FC              cld
0C06  AC              lodsb al, byte ptr [si]
0C07  0A C0           or al, al
0C09  74 2C           je 0xc37
0C0B  8A D0           mov dl, al
0C0D  32 F6           xor dh, dh
0C0F  C4 7E 06        les di, ptr [bp + 6]
0C12  26 8A 0D        mov cl, byte ptr es:[di]
0C15  32 ED           xor ch, ch
0C17  2B CA           sub cx, dx
0C19  72 1C           jb 0xc37
0C1B  41              inc cx
0C1C  47              inc di
loc_0C1D:
0C1D  AC              lodsb al, byte ptr [si]
0C1E  F2 AE           repne scasb al, byte ptr es:[di]
0C20  75 15           jne 0xc37
0C22  8B C7           mov ax, di
0C24  8B D9           mov bx, cx
0C26  8B CA           mov cx, dx
0C28  49              dec cx
0C29  F3 A6           repe cmpsb byte ptr [si], byte ptr es:[di]
0C2B  74 0E           je 0xc3b
0C2D  8B F8           mov di, ax
0C2F  8B CB           mov cx, bx
0C31  8B 76 0A        mov si, word ptr [bp + 0xa]
0C34  46              inc si
0C35  EB E6           jmp 0xc1d
loc_0C37:
0C37  33 C0           xor ax, ax
0C39  EB 04           jmp 0xc3f
loc_0C3B:
0C3B  48              dec ax
0C3C  2B 46 06        sub ax, word ptr [bp + 6]
loc_0C3F:
0C3F  1F              pop ds
0C40  5D              pop bp
0C41  CA 08 00        retf 8

; ---- routine 26C9:0C44  (found by: far)
sub_0C44:
0C44  FC              cld
0C45  8B DC           mov bx, sp
0C47  8C DA           mov dx, ds
0C49  36 C5 77 08     lds si, ptr ss:[bx + 8]
0C4D  36 C4 7F 04     les di, ptr ss:[bx + 4]
0C51  AC              lodsb al, byte ptr [si]
0C52  26 8A 25        mov ah, byte ptr es:[di]
0C55  47              inc di
0C56  8A C8           mov cl, al
0C58  3A CC           cmp cl, ah
0C5A  76 02           jbe 0xc5e
0C5C  8A CC           mov cl, ah
loc_0C5E:
0C5E  0A C9           or cl, cl
0C60  74 06           je 0xc68
0C62  32 ED           xor ch, ch
0C64  F3 A6           repe cmpsb byte ptr [si], byte ptr es:[di]
0C66  75 02           jne 0xc6a
loc_0C68:
0C68  3A C4           cmp al, ah
loc_0C6A:
0C6A  8E DA           mov ds, dx
0C6C  CA 08 00        retf 8

; ---- routine 26C9:0C6F  (found by: far)
sub_0C6F:
0C6F  FC              cld
0C70  8B DC           mov bx, sp
0C72  36 C4 7F 06     les di, ptr ss:[bx + 6]
0C76  B0 01           mov al, 1
0C78  AA              stosb byte ptr es:[di], al
0C79  36 8A 47 04     mov al, byte ptr ss:[bx + 4]
0C7D  AA              stosb byte ptr es:[di], al
0C7E  CA 02 00        retf 2

; ---- routine 26C9:0C81  (found by: far)
sub_0C81:
0C81  FC              cld
0C82  8B DC           mov bx, sp
0C84  8C DA           mov dx, ds
0C86  36 C4 7F 0A     les di, ptr ss:[bx + 0xa]
0C8A  36 C5 77 06     lds si, ptr ss:[bx + 6]
0C8E  36 8B 47 04     mov ax, word ptr ss:[bx + 4]
0C92  AA              stosb byte ptr es:[di], al
0C93  8B C8           mov cx, ax
0C95  F3 A4           rep movsb byte ptr es:[di], byte ptr [si]
0C97  8E DA           mov ds, dx
0C99  CA 06 00        retf 6

; ---- routine 26C9:0C9C  (found by: far)
sub_0C9C:
0C9C  55              push bp
0C9D  8B EC           mov bp, sp
0C9F  81 EC 00 02     sub sp, 0x200
0CA3  83 7E 06 01     cmp word ptr [bp + 6], 1
0CA7  7D 05           jge 0xcae
0CA9  C7 46 06 01 00  mov word ptr [bp + 6], 1
loc_0CAE:
0CAE  8D BE 00 FF     lea di, [bp - 0x100]
0CB2  16              push ss
0CB3  57              push di
0CB4  C4 7E 0A        les di, ptr [bp + 0xa]
0CB7  06              push es
0CB8  57              push di
0CB9  B8 01 00        mov ax, 1
0CBC  50              push ax
0CBD  8B 46 06        mov ax, word ptr [bp + 6]
0CC0  48              dec ax
0CC1  50              push ax
0CC2  0E              push cs
0CC3  E8 CB FE        call 0xb91
0CC6  C4 7E 0E        les di, ptr [bp + 0xe]
0CC9  06              push es
0CCA  57              push di
0CCB  0E              push cs
0CCC  E8 03 FF        call 0xbd2
0CCF  8D BE 00 FE     lea di, [bp - 0x200]
0CD3  16              push ss
0CD4  57              push di
0CD5  C4 7E 0A        les di, ptr [bp + 0xa]
0CD8  06              push es
0CD9  57              push di
0CDA  FF 76 06        push word ptr [bp + 6]
0CDD  B8 FF 00        mov ax, 0xff
0CE0  50              push ax
0CE1  0E              push cs
0CE2  E8 AC FE        call 0xb91
0CE5  0E              push cs
0CE6  E8 E9 FE        call 0xbd2
0CE9  C4 7E 0A        les di, ptr [bp + 0xa]
0CEC  06              push es
0CED  57              push di
0CEE  FF 76 08        push word ptr [bp + 8]
0CF1  0E              push cs
0CF2  E8 78 FE        call 0xb6d
0CF5  8B E5           mov sp, bp
0CF7  5D              pop bp
0CF8  CA 0C 00        retf 0xc

; ---- routine 26C9:0CFB  (found by: far)
sub_0CFB:
0CFB  55              push bp
0CFC  8B EC           mov bp, sp
0CFE  81 EC 00 02     sub sp, 0x200
0D02  83 7E 06 00     cmp word ptr [bp + 6], 0
0D06  7E 5C           jle 0xd64
0D08  83 7E 08 00     cmp word ptr [bp + 8], 0
0D0C  7E 56           jle 0xd64
0D0E  81 7E 08 FF 00  cmp word ptr [bp + 8], 0xff
0D13  7F 4F           jg 0xd64
0D15  81 7E 06 FF 00  cmp word ptr [bp + 6], 0xff
0D1A  7E 05           jle 0xd21
0D1C  C7 46 06 FF 00  mov word ptr [bp + 6], 0xff
loc_0D21:
0D21  8D BE 00 FF     lea di, [bp - 0x100]
0D25  16              push ss
0D26  57              push di
0D27  C4 7E 0A        les di, ptr [bp + 0xa]
0D2A  06              push es
0D2B  57              push di
0D2C  B8 01 00        mov ax, 1
0D2F  50              push ax
0D30  8B 46 08        mov ax, word ptr [bp + 8]
0D33  48              dec ax
0D34  50              push ax
0D35  0E              push cs
0D36  E8 58 FE        call 0xb91
0D39  8D BE 00 FE     lea di, [bp - 0x200]
0D3D  16              push ss
0D3E  57              push di
0D3F  C4 7E 0A        les di, ptr [bp + 0xa]
0D42  06              push es
0D43  57              push di
0D44  8B 46 08        mov ax, word ptr [bp + 8]
0D47  03 46 06        add ax, word ptr [bp + 6]
0D4A  50              push ax
0D4B  B8 FF 00        mov ax, 0xff
0D4E  50              push ax
0D4F  0E              push cs
0D50  E8 3E FE        call 0xb91
0D53  0E              push cs
0D54  E8 7B FE        call 0xbd2
0D57  C4 7E 0A        les di, ptr [bp + 0xa]
0D5A  06              push es
0D5B  57              push di
0D5C  B8 FF 00        mov ax, 0xff
0D5F  50              push ax
0D60  0E              push cs
0D61  E8 09 FE        call 0xb6d
loc_0D64:
0D64  8B E5           mov sp, bp
0D66  5D              pop bp
0D67  CA 08 00        retf 8
; data (not reached as code), 42 bytes
0D6A                  db FC 8B DC 8C DA 36 C4 7F 0A 36 C5 77 06 36 8B 5F   ; .....6...6.w.6._
0D7A                  db 04 8A CF 32 ED 32 C0 F3 AA 8A CB F3 A4 B1 20 2A   ; ...2.2........ *
0D8A                  db CB 2A CF F3 AA 8E DA CA 06 00   ; .*........

; ---- routine 26C9:0D94  (found by: far)
sub_0D94:
0D94  FC              cld
0D95  8B DC           mov bx, sp
0D97  36 C4 7F 06     les di, ptr ss:[bx + 6]
0D9B  36 8B 47 04     mov ax, word ptr ss:[bx + 4]
0D9F  AB              stosw word ptr es:[di], ax
0DA0  B9 0F 00        mov cx, 0xf
0DA3  33 C0           xor ax, ax
0DA5  F3 AB           rep stosw word ptr es:[di], ax
0DA7  CA 02 00        retf 2

; ---- routine 26C9:0DAA  (found by: far)
sub_0DAA:
0DAA  8B DC           mov bx, sp
0DAC  36 C4 7F 06     les di, ptr ss:[bx + 6]
0DB0  36 8A 47 04     mov al, byte ptr ss:[bx + 4]
0DB4  8A D8           mov bl, al
0DB6  32 FF           xor bh, bh
0DB8  B1 03           mov cl, 3
0DBA  D3 EB           shr bx, cl
0DBC  8A C8           mov cl, al
0DBE  80 E1 07        and cl, 7
0DC1  B0 01           mov al, 1
0DC3  D2 E0           shl al, cl
0DC5  26 08 01        or byte ptr es:[bx + di], al
0DC8  CA 02 00        retf 2
; data (not reached as code), 84 bytes
0DCB                  db 8B DC 36 C4 7F 08 36 8A 47 06 36 8A 57 04 2A D0   ; ..6...6.G.6.W.*.
0DDB                  db 72 1F FE C2 8A D8 32 FF B1 03 D3 EB 8A C8 80 E1   ; r.....2.........
0DEB                  db 07 B0 01 D2 E0 26 08 01 D0 C0 83 D3 00 FE CA 75   ; .....&.........u
0DFB                  db F4 CA 04 00 FC 8B DC 8C DA 36 C5 77 0A 36 C4 7F   ; .........6.w.6..
0E0B                  db 06 36 8B 5F 04 8A CF 32 ED 03 F1 8A CB F3 A4 8E   ; .6._...2........
0E1B                  db DA CA 0A 00   ; ....

; ---- routine 26C9:0E1F  (found by: far)
sub_0E1F:
0E1F  8A E8           mov ch, al
0E21  B1 03           mov cl, 3
0E23  D2 ED           shr ch, cl
0E25  2A EE           sub ch, dh
0E27  72 11           jb 0xe3a
0E29  3A EA           cmp ch, dl
0E2B  73 0D           jae 0xe3a
0E2D  8A D5           mov dl, ch
0E2F  32 F6           xor dh, dh
0E31  24 07           and al, 7
0E33  8A C8           mov cl, al
0E35  8A C4           mov al, ah
0E37  D2 C0           rol al, cl
0E39  CB              retf
loc_0E3A:
0E3A  99              cdq
0E3B  92              xchg dx, ax
0E3C  33 D2           xor dx, dx
0E3E  CB              retf
; data (not reached as code), 370 bytes
0E3F                  db FC 8B DC 8C DA 36 C4 7F 08 36 C5 77 04 B9 10 00   ; .....6...6.w....
0E4F                  db AD 26 0B 05 AB E2 F9 8E DA CA 04 00 FC 8B DC 8C   ; .&..............
0E5F                  db DA 36 C4 7F 08 36 C5 77 04 B9 10 00 AD F7 D0 26   ; .6...6.w.......&
0E6F                  db 23 05 AB E2 F7 8E DA CA 04 00 FC 8B DC 8C DA 36   ; #..............6
0E7F                  db C4 7F 08 36 C5 77 04 B9 10 00 AD 26 23 05 AB E2   ; ...6.w.....&#...
0E8F                  db F9 8E DA CA 04 00 FC 8B DC 8C DA 36 C4 7F 08 36   ; ...........6...6
0E9F                  db C5 77 04 B9 10 00 F3 A7 8E DA CA 08 00 FC 8B DC   ; .w..............
0EAF                  db 8C DA 36 C4 7F 08 36 C5 77 04 B9 10 00 AD 26 0B   ; ..6...6.w.....&.
0EBF                  db 05 AF 75 02 E2 F7 8E DA CA 08 00 8B DC 1E 36 C5   ; ..u...........6.
0ECF                  db 7F 04 33 C9 89 0D B8 00 3D 81 7D 02 B1 D7 74 0D   ; ..3.....=.}...t.
0EDF                  db B0 02 FF 05 81 7D 02 B3 D7 74 02 B4 3C 80 7D 30   ; .....}...t..<.}0
0EEF                  db 00 74 09 8D 55 30 CD 21 72 5A 89 05 B8 13 06 BA   ; .t..U0.!rZ......
0EFF                  db C9 26 33 C9 33 DB 81 7D 02 B1 D7 74 2F 8B 1D B8   ; .&3.3..}...t/...
0F0F                  db 00 44 CD 21 F6 C2 80 B8 68 06 BA C9 26 8B C8 8B   ; .D.!....h...&...
0F1F                  db DA 75 14 81 7D 02 B3 D7 75 03 E8 2B 00 B8 43 06   ; .u..}...u..+..C.
0F2F                  db BA C9 26 33 C9 33 DB C7 45 02 B2 D7 89 45 14 89   ; ..&3.3..E....E..
0F3F                  db 55 16 89 4D 18 89 5D 1A C7 45 1C 88 06 C7 45 1E   ; U..M..]..E....E.
0F4F                  db C9 26 33 C0 1F CA 04 00 33 D2 33 C9 8B 1D B8 02   ; .&3.....3.3.....
0F5F                  db 42 CD 21 2D 80 00 83 DA 00 73 04 33 C0 33 D2 8B   ; B.!-.....s.3.3..
0F6F                  db CA 8B D0 8B 1D B8 00 42 CD 21 8D 95 80 00 B9 80   ; .......B.!......
0F7F                  db 00 8B 1D B4 3F CD 21 73 02 33 C0 33 DB 3B D8 74   ; ....?.!s.3.3.;.t
0F8F                  db 20 80 B9 80 00 1A 74 03 43 EB F2 8B D3 2B D0 B9   ;  .....t.C....+..
0F9F                  db FF FF 8B 1D B8 02 42 CD 21 33 C9 8B 1D B4 40 CD   ; ......B.!3....@.
0FAF                  db 21 C3   ; !.

; ---- routine 26C9:0FB1  (found by: call)
sub_0FB1:
0FB1  81 F7 00 80     xor di, 0x8000

; ---- routine 26C9:0FB5  (found by: call)
sub_0FB5:
0FB5  0A C9           or cl, cl
0FB7  74 7B           je 0x1034
0FB9  0A C0           or al, al
0FBB  74 78           je 0x1035
0FBD  3A C1           cmp al, cl
0FBF  76 05           jbe 0xfc6
0FC1  91              xchg cx, ax
0FC2  87 DE           xchg si, bx
0FC4  87 D7           xchg di, dx
loc_0FC6:
0FC6  2A C1           sub al, cl
0FC8  F6 D8           neg al
0FCA  3C 29           cmp al, 0x29
0FCC  73 67           jae 0x1035
0FCE  86 C1           xchg cl, al
0FD0  55              push bp
0FD1  50              push ax
0FD2  8A E6           mov ah, dh
0FD4  80 E4 80        and ah, 0x80
0FD7  8B E8           mov bp, ax
0FD9  33 C7           xor ax, di
0FDB  58              pop ax
0FDC  9C              pushf
0FDD  B0 00           mov al, 0
0FDF  80 CE 80        or dh, 0x80
0FE2  81 CF 00 80     or di, 0x8000
loc_0FE6:
0FE6  80 F9 08        cmp cl, 8
0FE9  72 11           jb 0xffc
0FEB  8A C4           mov al, ah
0FED  8A E3           mov ah, bl
0FEF  8A DF           mov bl, bh
0FF1  8A FA           mov bh, dl
0FF3  8A D6           mov dl, dh
0FF5  32 F6           xor dh, dh
0FF7  80 E9 08        sub cl, 8
0FFA  EB EA           jmp 0xfe6
loc_0FFC:
0FFC  0A C9           or cl, cl
0FFE  74 0A           je 0x100a
loc_1000:
1000  D1 EA           shr dx, 1
1002  D1 DB           rcr bx, 1
1004  D1 D8           rcr ax, 1
1006  FE C9           dec cl
1008  75 F6           jne 0x1000
loc_100A:
100A  9D              popf
100B  78 37           js 0x1044
100D  03 C1           add ax, cx
100F  13 DE           adc bx, si
1011  13 D7           adc dx, di
1013  8B CD           mov cx, bp
1015  5D              pop bp
1016  73 0A           jae 0x1022
1018  D1 DA           rcr dx, 1
101A  D1 DB           rcr bx, 1
101C  D1 D8           rcr ax, 1
101E  FE C1           inc cl
1020  74 20           je 0x1042
loc_1022:
1022  05 80 00        add ax, 0x80
1025  83 D3 00        adc bx, 0
1028  83 D2 00        adc dx, 0
102B  72 0F           jb 0x103c
loc_102D:
102D  8A C1           mov al, cl
102F  80 E6 7F        and dh, 0x7f
1032  0A F5           or dh, ch
loc_1034:
1034  C3              ret
loc_1035:
1035  8B C1           mov ax, cx
1037  8B DE           mov bx, si
1039  8B D7           mov dx, di
103B  C3              ret
loc_103C:
103C  D1 DA           rcr dx, 1
103E  FE C1           inc cl
1040  75 EB           jne 0x102d
loc_1042:
1042  F9              stc
1043  C3              ret
loc_1044:
1044  2B C1           sub ax, cx
1046  1B DE           sbb bx, si
1048  1B D7           sbb dx, di
104A  8B CD           mov cx, bp
104C  5D              pop bp
104D  73 10           jae 0x105f
104F  F7 D2           not dx
1051  F7 D3           not bx
1053  F7 D8           neg ax
1055  F5              cmc
1056  83 D3 00        adc bx, 0
1059  83 D2 00        adc dx, 0
105C  80 F5 80        xor ch, 0x80
loc_105F:
105F  8B FA           mov di, dx
1061  0B FB           or di, bx
1063  0B F8           or di, ax
1065  74 CD           je 0x1034
loc_1067:
1067  0A F6           or dh, dh
1069  78 B7           js 0x1022
106B  D1 E0           shl ax, 1
106D  D1 D3           rcl bx, 1
106F  D1 D2           rcl dx, 1
1071  FE C9           dec cl
1073  75 F2           jne 0x1067
loc_1075:
1075  E9 FC 00        jmp 0x1174

; ---- routine 26C9:1078  (found by: call, jump)
sub_1078:
1078  0A C0           or al, al
107A  74 F9           je 0x1075
107C  0A C9           or cl, cl
107E  74 F5           je 0x1075
1080  55              push bp
1081  8B EA           mov bp, dx
1083  33 D7           xor dx, di
1085  81 E2 00 80     and dx, 0x8000
1089  86 D0           xchg al, dl
108B  02 D1           add dl, cl
108D  12 F0           adc dh, al
108F  8A C8           mov cl, al
1091  81 CD 00 80     or bp, 0x8000
1095  81 CF 00 80     or di, 0x8000
1099  52              push dx
109A  0A E4           or ah, ah
109C  75 04           jne 0x10a2
109E  0B DB           or bx, bx
10A0  74 0D           je 0x10af
loc_10A2:
10A2  0A ED           or ch, ch
10A4  75 26           jne 0x10cc
10A6  0B F6           or si, si
10A8  75 22           jne 0x10cc
10AA  91              xchg cx, ax
10AB  87 DE           xchg si, bx
10AD  87 EF           xchg di, bp
loc_10AF:
10AF  8B C1           mov ax, cx
10B1  F7 E5           mul bp
10B3  8B DA           mov bx, dx
10B5  8B C6           mov ax, si
10B7  F7 E5           mul bp
10B9  03 D8           add bx, ax
10BB  83 D2 00        adc dx, 0
10BE  8B CA           mov cx, dx
10C0  8B C7           mov ax, di
10C2  F7 E5           mul bp
10C4  03 C1           add ax, cx
10C6  83 D2 00        adc dx, 0
10C9  EB 7C           jmp 0x1147
; data (not reached as code), 1 bytes
10CB                  db 90   ; .
loc_10CC:
10CC  57              push di
10CD  56              push si
10CE  51              push cx
10CF  55              push bp
10D0  53              push bx
10D1  50              push ax
10D2  8B EC           mov bp, sp
10D4  33 C9           xor cx, cx
10D6  8A 46 01        mov al, byte ptr [bp + 1]
10D9  F6 66 07        mul byte ptr [bp + 7]
10DC  8B F0           mov si, ax
10DE  8B F9           mov di, cx
10E0  8B D9           mov bx, cx
10E2  8B 46 00        mov ax, word ptr [bp]
10E5  F7 66 08        mul word ptr [bp + 8]
10E8  03 F0           add si, ax
10EA  13 FA           adc di, dx
10EC  13 D9           adc bx, cx
10EE  8B 46 02        mov ax, word ptr [bp + 2]
10F1  F7 66 06        mul word ptr [bp + 6]
10F4  03 F0           add si, ax
10F6  13 FA           adc di, dx
10F8  13 D9           adc bx, cx
10FA  8B F1           mov si, cx
10FC  8B 46 00        mov ax, word ptr [bp]
10FF  F7 66 0A        mul word ptr [bp + 0xa]
1102  03 F8           add di, ax
1104  13 DA           adc bx, dx
1106  13 F1           adc si, cx
1108  8B 46 02        mov ax, word ptr [bp + 2]
110B  F7 66 08        mul word ptr [bp + 8]
110E  03 F8           add di, ax
1110  13 DA           adc bx, dx
1112  13 F1           adc si, cx
1114  8B 46 04        mov ax, word ptr [bp + 4]
1117  F7 66 06        mul word ptr [bp + 6]
111A  03 F8           add di, ax
111C  13 DA           adc bx, dx
111E  13 F1           adc si, cx
1120  8B F9           mov di, cx
1122  8B 46 02        mov ax, word ptr [bp + 2]
1125  F7 66 0A        mul word ptr [bp + 0xa]
1128  03 D8           add bx, ax
112A  13 F2           adc si, dx
112C  13 F9           adc di, cx
112E  8B 46 04        mov ax, word ptr [bp + 4]
1131  F7 66 08        mul word ptr [bp + 8]
1134  03 D8           add bx, ax
1136  13 F2           adc si, dx
1138  13 F9           adc di, cx
113A  8B 46 04        mov ax, word ptr [bp + 4]
113D  F7 66 0A        mul word ptr [bp + 0xa]
1140  03 C6           add ax, si
1142  13 D7           adc dx, di
1144  83 C4 0C        add sp, 0xc
loc_1147:
1147  93              xchg bx, ax
1148  59              pop cx
1149  5D              pop bp
114A  0A F6           or dh, dh
114C  78 07           js 0x1155
114E  D1 E0           shl ax, 1
1150  D1 D3           rcl bx, 1
1152  D1 D2           rcl dx, 1
1154  49              dec cx
loc_1155:
1155  81 E9 81 80     sub cx, 0x8081
loc_1159:
1159  05 80 00        add ax, 0x80
115C  83 D3 00        adc bx, 0
115F  83 D2 00        adc dx, 0
1162  73 03           jae 0x1167
1164  D1 DA           rcr dx, 1
1166  41              inc cx
loc_1167:
1167  F6 C5 40        test ch, 0x40
116A  75 08           jne 0x1174
116C  41              inc cx
116D  8A C1           mov al, cl
116F  32 F5           xor dh, ch
1171  D0 ED           shr ch, 1
1173  C3              ret
loc_1174:
1174  33 C0           xor ax, ax
1176  8B D8           mov bx, ax
1178  8B D0           mov dx, ax
117A  C3              ret

; ---- routine 26C9:117B  (found by: call)
sub_117B:
117B  0A C0           or al, al
117D  74 F5           je 0x1174
117F  55              push bp
1180  8B EA           mov bp, dx
1182  33 D7           xor dx, di
1184  81 CF 00 80     or di, 0x8000
1188  81 CD 00 80     or bp, 0x8000
118C  81 E2 00 80     and dx, 0x8000
1190  86 C2           xchg dl, al
1192  2A D1           sub dl, cl
1194  1A F0           sbb dh, al
1196  52              push dx
1197  B0 02           mov al, 2
1199  BA 01 00        mov dx, 1
loc_119C:
119C  3B EF           cmp bp, di
119E  75 06           jne 0x11a6
11A0  3B DE           cmp bx, si
11A2  75 02           jne 0x11a6
11A4  3A E5           cmp ah, ch
loc_11A6:
11A6  72 06           jb 0x11ae
11A8  2A E5           sub ah, ch
11AA  1B DE           sbb bx, si
11AC  1B EF           sbb bp, di
loc_11AE:
11AE  D1 D2           rcl dx, 1
11B0  72 11           jb 0x11c3
loc_11B2:
11B2  D0 E4           shl ah, 1
11B4  D1 D3           rcl bx, 1
11B6  D1 D5           rcl bp, 1
11B8  73 E2           jae 0x119c
11BA  2A E5           sub ah, ch
11BC  1B DE           sbb bx, si
11BE  1B EF           sbb bp, di
11C0  F8              clc
11C1  EB EB           jmp 0x11ae
loc_11C3:
11C3  FE C8           dec al
11C5  78 0A           js 0x11d1
11C7  52              push dx
11C8  BA 01 00        mov dx, 1
11CB  75 E5           jne 0x11b2
11CD  B2 40           mov dl, 0x40
11CF  EB E1           jmp 0x11b2
loc_11D1:
11D1  8B C2           mov ax, dx
11D3  B1 06           mov cl, 6
11D5  D3 E0           shl ax, cl
11D7  5B              pop bx
11D8  5A              pop dx
11D9  59              pop cx
11DA  5D              pop bp
11DB  F7 D0           not ax
11DD  F7 D3           not bx
11DF  83 F2 FF        xor dx, 0xffff
11E2  78 07           js 0x11eb
11E4  D1 D0           rcl ax, 1
11E6  D1 D3           rcl bx, 1
11E8  D1 D2           rcl dx, 1
11EA  49              dec cx
loc_11EB:
11EB  81 C1 80 80     add cx, 0x8080
11EF  E9 67 FF        jmp 0x1159

; ---- routine 26C9:11F2  (found by: call)
sub_11F2:
11F2  52              push dx
11F3  33 D7           xor dx, di
11F5  5A              pop dx
11F6  79 05           jns 0x11fd
11F8  52              push dx
11F9  D1 D2           rcl dx, 1
11FB  5A              pop dx
11FC  C3              ret
loc_11FD:
11FD  F6 C6 80        test dh, 0x80
1200  74 07           je 0x1209
1202  E8 04 00        call 0x1209
1205  74 14           je 0x121b
1207  F5              cmc
1208  C3              ret

; ---- routine 26C9:1209  (found by: call, jump)
sub_1209:
1209  3A C1           cmp al, cl
120B  75 0E           jne 0x121b
120D  0A C0           or al, al
120F  74 0A           je 0x121b
1211  3B D7           cmp dx, di
1213  75 06           jne 0x121b
1215  3B DE           cmp bx, si
1217  75 02           jne 0x121b
1219  3A E5           cmp ah, ch
loc_121B:
121B  C3              ret

; ---- routine 26C9:121C  (found by: call)
sub_121C:
121C  8B D8           mov bx, ax
121E  0B DA           or bx, dx
1220  74 35           je 0x1257
1222  8A EE           mov ch, dh
1224  0B D2           or dx, dx
1226  79 07           jns 0x122f
1228  F7 DA           neg dx
122A  F7 D8           neg ax
122C  83 DA 00        sbb dx, 0
loc_122F:
122F  8B D8           mov bx, ax
1231  B8 A0 00        mov ax, 0xa0
1234  0B D2           or dx, dx
1236  75 0C           jne 0x1244
1238  87 D3           xchg bx, dx
123A  B0 90           mov al, 0x90
123C  0A F6           or dh, dh
123E  75 04           jne 0x1244
1240  86 F2           xchg dl, dh
1242  B0 88           mov al, 0x88
loc_1244:
1244  0B D2           or dx, dx
1246  78 08           js 0x1250
loc_1248:
1248  FE C8           dec al
124A  03 DB           add bx, bx
124C  13 D2           adc dx, dx
124E  79 F8           jns 0x1248
loc_1250:
1250  0A ED           or ch, ch
1252  78 03           js 0x1257
1254  80 E6 7F        and dh, 0x7f
loc_1257:
1257  C3              ret

; ---- routine 26C9:1258  (found by: call)
sub_1258:
1258  93              xchg bx, ax
1259  B1 A0           mov cl, 0xa0
125B  2A CB           sub cl, bl
125D  72 5B           jb 0x12ba
125F  8A DE           mov bl, dh
1261  80 CE 80        or dh, 0x80
1264  80 F9 20        cmp cl, 0x20
1267  73 52           jae 0x12bb
1269  80 F9 10        cmp cl, 0x10
126C  72 09           jb 0x1277
126E  8A FC           mov bh, ah
1270  8B C2           mov ax, dx
1272  33 D2           xor dx, dx
1274  80 E9 10        sub cl, 0x10
loc_1277:
1277  80 F9 08        cmp cl, 8
127A  72 0D           jb 0x1289
127C  8A F8           mov bh, al
127E  8A C4           mov al, ah
1280  8A E2           mov ah, dl
1282  8A D6           mov dl, dh
1284  32 F6           xor dh, dh
1286  80 E9 08        sub cl, 8
loc_1289:
1289  0A C9           or cl, cl
128B  74 0A           je 0x1297
loc_128D:
128D  D1 EA           shr dx, 1
128F  D1 D8           rcr ax, 1
1291  D0 DF           rcr bh, 1
1293  FE C9           dec cl
1295  75 F6           jne 0x128d
loc_1297:
1297  0A ED           or ch, ch
1299  74 0A           je 0x12a5
129B  02 FF           add bh, bh
129D  15 00 00        adc ax, 0
12A0  83 D2 00        adc dx, 0
12A3  72 15           jb 0x12ba
loc_12A5:
12A5  8B C8           mov cx, ax
12A7  0B CA           or cx, dx
12A9  74 0F           je 0x12ba
12AB  0A DB           or bl, bl
12AD  79 07           jns 0x12b6
12AF  F7 DA           neg dx
12B1  F7 D8           neg ax
12B3  83 DA 00        sbb dx, 0
loc_12B6:
12B6  32 DE           xor bl, dh
12B8  02 DB           add bl, bl
loc_12BA:
12BA  C3              ret
loc_12BB:
12BB  8A FE           mov bh, dh
12BD  B8 00 00        mov ax, 0
12C0  BA 00 00        mov dx, 0
12C3  74 D2           je 0x1297
12C5  C3              ret

; ---- routine 26C9:12C6  (found by: far)
sub_12C6:
12C6  E8 EC FC        call 0xfb5
12C9  72 3B           jb 0x1306
12CB  CB              retf
; data (not reached as code), 12 bytes
12CC                  db E8 E2 FC 72 35 CB 8B C8 8B F3 8B FA   ; ...r5.......

; ---- routine 26C9:12D8  (found by: far)
sub_12D8:
12D8  E8 9D FD        call 0x1078
12DB  72 29           jb 0x1306
12DD  CB              retf

; ---- routine 26C9:12DE  (found by: far)
sub_12DE:
12DE  0A C9           or cl, cl
12E0  74 2A           je 0x130c
12E2  E8 96 FE        call 0x117b
12E5  72 1F           jb 0x1306
12E7  CB              retf
; data (not reached as code), 4 bytes
12E8                  db E8 07 FF CB   ; ....

; ---- routine 26C9:12EC  (found by: far)
sub_12EC:
12EC  E8 2D FF        call 0x121c
12EF  CB              retf
; data (not reached as code), 8 bytes
12F0                  db B5 00 E8 63 FF 72 09 CB   ; ...c.r..

; ---- routine 26C9:12F8  (found by: far)
sub_12F8:
12F8  B5 01           mov ch, 1
12FA  E8 5B FF        call 0x1258
12FD  72 01           jb 0x1300
12FF  CB              retf
loc_1300:
1300  B8 CF 00        mov ax, 0xcf
1303  E9 09 EE        jmp 0x10f
loc_1306:
1306  B8 CD 00        mov ax, 0xcd
1309  E9 03 EE        jmp 0x10f
loc_130C:
130C  B8 C8 00        mov ax, 0xc8
130F  E9 FD ED        jmp 0x10f

