; 1-095.EXE (One-Nil 95), code segment 0AB5 (image offsets 0AB50..1993F), part 17 of 22
; packed 1-095.EXE sha256 f659fb2d334500d6901fc8d6a0f06c85c0ccda2eb4a3035ae3bb0a0004d79192 (LZEXE 0.91)
; unpacked (tools/static/unlzexe.py) sha256 8df646e017e0965a5d90a58181ca764219ad847833aad0b6cb58fc53372bfb2c
; tool: capstone 5.0.9 (pip package; core library 5.0.1280) (CS_ARCH_X86, CS_MODE_16), recursive descent from the entry point, far calls and near calls/jumps, then routine prologues (55 89 E5 / 55 8B EC / C8 iw 00) in what remains; tools/static/listing.py
; addresses are SEGMENT:OFFSET with SEGMENT the image paragraph before relocation; image offset = SEGMENT*16+OFFSET
; ---- routine 0AB5:ABD9  (found by: call)
sub_ABD9:
ABD9  C8 04 00 00     enter 4, 0
ABDD  83 7E 06 00     cmp word ptr [bp + 6], 0
ABE1  75 02           jne 0xabe5
ABE3  EB 69           jmp 0xac4e
loc_ABE5:
ABE5  8B 46 06        mov ax, word ptr [bp + 6]
ABE8  C1 E0 03        shl ax, 3
ABEB  C4 3E BA D7     les di, ptr [0xd7ba]
ABEF  03 F8           add di, ax
ABF1  89 7E FC        mov word ptr [bp - 4], di
ABF4  8C 46 FE        mov word ptr [bp - 2], es
ABF7  26 80 7D 07 00  cmp byte ptr es:[di + 7], 0
ABFC  B0 00           mov al, 0
ABFE  75 01           jne 0xac01
AC00  40              inc ax
loc_AC01:
AC01  50              push ax
AC02  BF B6 AB        mov di, 0xabb6
AC05  0E              push cs
AC06  57              push di
AC07  9A 98 00 1A 23  call far 231A:0098
AC0C  08 C0           or al, al
AC0E  74 02           je 0xac12
AC10  EB 3C           jmp 0xac4e
loc_AC12:
AC12  80 7E 04 00     cmp byte ptr [bp + 4], 0
AC16  74 07           je 0xac1f
AC18  C6 06 88 DE 06  mov byte ptr [0xde88], 6
AC1D  EB 05           jmp 0xac24
loc_AC1F:
AC1F  C6 06 88 DE 05  mov byte ptr [0xde88], 5
loc_AC24:
AC24  C4 7E FC        les di, ptr [bp - 4]
AC27  26 FE 45 06     inc byte ptr es:[di + 6]
AC2B  81 C7 06 00     add di, 6
AC2F  06              push es
AC30  57              push di
AC31  6A 0E           push 0xe
AC33  9A C4 0E 1A 23  call far 231A:0EC4
AC38  C4 7E FC        les di, ptr [bp - 4]
AC3B  26 FE 4D 06     dec byte ptr es:[di + 6]
AC3F  C6 06 88 DE 00  mov byte ptr [0xde88], 0
AC44  80 3E 91 0D 00  cmp byte ptr [0xd91], 0
AC49  74 03           je 0xac4e
AC4B  E8 6B 64        call 0x110b9
loc_AC4E:
AC4E  C9              leave
AC4F  C2 04 00        ret 4

; ---- routine 0AB5:AC52  (found by: call)
sub_AC52:
AC52  C8 04 00 00     enter 4, 0
AC56  83 7E 04 00     cmp word ptr [bp + 4], 0
AC5A  75 02           jne 0xac5e
AC5C  EB 25           jmp 0xac83
loc_AC5E:
AC5E  8B 46 04        mov ax, word ptr [bp + 4]
AC61  C1 E0 03        shl ax, 3
AC64  C4 3E BA D7     les di, ptr [0xd7ba]
AC68  03 F8           add di, ax
AC6A  26 80 7D 01 11  cmp byte ptr es:[di + 1], 0x11
AC6F  76 08           jbe 0xac79
AC71  26 8A 45 07     mov al, byte ptr es:[di + 7]
AC75  26 88 45 06     mov byte ptr es:[di + 6], al
loc_AC79:
AC79  80 3E 91 0D 00  cmp byte ptr [0xd91], 0
AC7E  74 03           je 0xac83
AC80  E8 36 64        call 0x110b9
loc_AC83:
AC83  C9              leave
AC84  C2 02 00        ret 2

; ---- routine 0AB5:AC87  (found by: call)
sub_AC87:
AC87  C8 04 00 00     enter 4, 0
AC8B  C4 7E 08        les di, ptr [bp + 8]
AC8E  06              push es
AC8F  57              push di
AC90  0E              push cs
AC91  E8 3C F3        call 0x9fd0
AC94  BF AC 22        mov di, 0x22ac
AC97  1E              push ds
AC98  57              push di
AC99  BF 5C DD        mov di, 0xdd5c
AC9C  1E              push ds
AC9D  57              push di
AC9E  9A 2F 05 1A 23  call far 231A:052F
ACA3  A0 7E 03        mov al, byte ptr [0x37e]
ACA6  30 E4           xor ah, ah
ACA8  D1 E0           shl ax, 1
ACAA  C4 7E 08        les di, ptr [bp + 8]
ACAD  03 F8           add di, ax
ACAF  26 FF 75 FE     push word ptr es:[di - 2]
ACB3  0E              push cs
ACB4  E8 FC E8        call 0x95b3
ACB7  80 7E 06 00     cmp byte ptr [bp + 6], 0
ACBB  75 11           jne 0xacce
ACBD  BF 22 63        mov di, 0x6322
ACC0  1E              push ds
ACC1  57              push di
ACC2  BF 5C DD        mov di, 0xdd5c
ACC5  1E              push ds
ACC6  57              push di
ACC7  9A 2F 05 1A 23  call far 231A:052F
ACCC  EB 3B           jmp 0xad09
loc_ACCE:
ACCE  80 7E 06 01     cmp byte ptr [bp + 6], 1
ACD2  75 11           jne 0xace5
ACD4  BF 24 49        mov di, 0x4924
ACD7  1E              push ds
ACD8  57              push di
ACD9  BF 5C DD        mov di, 0xdd5c
ACDC  1E              push ds
ACDD  57              push di
ACDE  9A 2F 05 1A 23  call far 231A:052F
ACE3  EB 24           jmp 0xad09
loc_ACE5:
ACE5  80 7E 06 02     cmp byte ptr [bp + 6], 2
ACE9  75 1E           jne 0xad09
ACEB  BF 22 63        mov di, 0x6322
ACEE  1E              push ds
ACEF  57              push di
ACF0  BF 5C DD        mov di, 0xdd5c
ACF3  1E              push ds
ACF4  57              push di
ACF5  9A 2F 05 1A 23  call far 231A:052F
ACFA  BF 0A 25        mov di, 0x250a
ACFD  1E              push ds
ACFE  57              push di
ACFF  BF 5C DD        mov di, 0xdd5c
AD02  1E              push ds
AD03  57              push di
AD04  9A 2F 05 1A 23  call far 231A:052F
loc_AD09:
AD09  80 3E 7E 03 0E  cmp byte ptr [0x37e], 0xe
AD0E  B0 00           mov al, 0
AD10  76 01           jbe 0xad13
AD12  40              inc ax
loc_AD13:
AD13  30 E4           xor ah, ah
AD15  8B C8           mov cx, ax
AD17  80 3E 7E 03 0B  cmp byte ptr [0x37e], 0xb
AD1C  B0 00           mov al, 0
AD1E  76 01           jbe 0xad21
AD20  40              inc ax
loc_AD21:
AD21  30 E4           xor ah, ah
AD23  8B D0           mov dx, ax
AD25  A0 7E 03        mov al, byte ptr [0x37e]
AD28  30 E4           xor ah, ah
AD2A  40              inc ax
AD2B  03 C2           add ax, dx
AD2D  03 C1           add ax, cx
AD2F  89 46 FC        mov word ptr [bp - 4], ax
AD32  FF 76 FC        push word ptr [bp - 4]
AD35  6A 3B           push 0x3b
AD37  6A 0E           push 0xe
AD39  9A 03 02 1A 23  call far 231A:0203
AD3E  C9              leave
AD3F  CA 06 00        retf 6
; data (not reached as code), 1 bytes
AD42                  db 00   ; .

; ---- routine 0AB5:AD43  (found by: call, far)
sub_AD43:
AD43  C8 02 00 00     enter 2, 0
loc_AD47:
AD47  C4 7E 08        les di, ptr [bp + 8]
AD4A  06              push es
AD4B  57              push di
AD4C  8A 46 06        mov al, byte ptr [bp + 6]
AD4F  50              push ax
AD50  0E              push cs
AD51  E8 33 FF        call 0xac87
AD54  C4 3E 5C DD     les di, ptr [0xdd5c]
AD58  06              push es
AD59  57              push di
AD5A  C4 3E 58 DD     les di, ptr [0xdd58]
AD5E  06              push es
AD5F  57              push di
AD60  68 A0 0F        push 0xfa0
AD63  9A 12 0A B9 26  call far 26B9:0A12
AD68  9A 9B 09 1A 23  call far 231A:099B
AD6D  A0 88 DE        mov al, byte ptr [0xde88]
AD70  A2 8A DE        mov byte ptr [0xde8a], al
AD73  A0 88 DE        mov al, byte ptr [0xde88]
AD76  3C 07           cmp al, 7
AD78  72 09           jb 0xad83
AD7A  3C 08           cmp al, 8
AD7C  77 05           ja 0xad83
AD7E  C6 06 88 DE 00  mov byte ptr [0xde88], 0
loc_AD83:
AD83  BF 7E 03        mov di, 0x37e
AD86  1E              push ds
AD87  57              push di
AD88  6A 14           push 0x14
AD8A  9A C4 0E 1A 23  call far 231A:0EC4
AD8F  A0 8A DE        mov al, byte ptr [0xde8a]
AD92  A2 88 DE        mov byte ptr [0xde88], al
AD95  80 3E 88 DE 01  cmp byte ptr [0xde88], 1
AD9A  B0 00           mov al, 0
AD9C  75 01           jne 0xad9f
AD9E  40              inc ax
loc_AD9F:
AD9F  88 46 FF        mov byte ptr [bp - 1], al
ADA2  80 3E 88 DE 02  cmp byte ptr [0xde88], 2
ADA7  75 06           jne 0xadaf
ADA9  C6 46 FF 01     mov byte ptr [bp - 1], 1
ADAD  EB 00           jmp 0xadaf
loc_ADAF:
ADAF  80 3E 88 DE 0D  cmp byte ptr [0xde88], 0xd
ADB4  75 0D           jne 0xadc3
ADB6  80 3E 2A 9A 00  cmp byte ptr [0x9a2a], 0
ADBB  B0 00           mov al, 0
ADBD  75 01           jne 0xadc0
ADBF  40              inc ax
loc_ADC0:
ADC0  A2 2A 9A        mov byte ptr [0x9a2a], al
loc_ADC3:
ADC3  80 7E FF 00     cmp byte ptr [bp - 1], 0
ADC7  75 03           jne 0xadcc
ADC9  E9 7B FF        jmp 0xad47
loc_ADCC:
ADCC  C9              leave
ADCD  CA 06 00        retf 6

; ---- routine 0AB5:ADD0  (found by: call)
sub_ADD0:
ADD0  C8 A0 01 00     enter 0x1a0, 0
ADD4  C4 3E 58 DD     les di, ptr [0xdd58]
ADD8  81 C7 00 0F     add di, 0xf00
ADDC  06              push es
ADDD  57              push di
ADDE  8D BE 60 FF     lea di, [bp - 0xa0]
ADE2  16              push ss
ADE3  57              push di
ADE4  68 A0 00        push 0xa0
ADE7  9A C2 01 AC 24  call far 24AC:01C2
ADEC  BF B8 2E        mov di, 0x2eb8
ADEF  1E              push ds
ADF0  57              push di
ADF1  BF 5C DD        mov di, 0xdd5c
ADF4  1E              push ds
ADF5  57              push di
ADF6  9A 2F 05 1A 23  call far 231A:052F
ADFB  FF 76 06        push word ptr [bp + 6]
ADFE  8B 46 06        mov ax, word ptr [bp + 6]
AE01  C1 E0 03        shl ax, 3
AE04  C4 3E BA D7     les di, ptr [0xd7ba]
AE08  03 F8           add di, ax
AE0A  26 8A 45 06     mov al, byte ptr es:[di + 6]
AE0E  30 E4           xor ah, ah
AE10  50              push ax
AE11  9A 8B 71 51 1B  call far 1B51:718B
AE16  50              push ax
AE17  8D BE 60 FE     lea di, [bp - 0x1a0]
AE1B  16              push ss
AE1C  57              push di
AE1D  FF 76 06        push word ptr [bp + 6]
AE20  9A 3C 44 51 1B  call far 1B51:443C
AE25  6A 19           push 0x19
AE27  6A 1D           push 0x1d
AE29  BF 5C DD        mov di, 0xdd5c
AE2C  1E              push ds
AE2D  57              push di
AE2E  9A 0C 03 1A 23  call far 231A:030C
AE33  FF 76 04        push word ptr [bp + 4]
AE36  8B 46 04        mov ax, word ptr [bp + 4]
AE39  C1 E0 03        shl ax, 3
AE3C  C4 3E BA D7     les di, ptr [0xd7ba]
AE40  03 F8           add di, ax
AE42  26 8A 45 06     mov al, byte ptr es:[di + 6]
AE46  30 E4           xor ah, ah
AE48  50              push ax
AE49  9A 8B 71 51 1B  call far 1B51:718B
AE4E  50              push ax
AE4F  8D BE 60 FE     lea di, [bp - 0x1a0]
AE53  16              push ss
AE54  57              push di
AE55  FF 76 04        push word ptr [bp + 4]
AE58  9A 3C 44 51 1B  call far 1B51:443C
AE5D  6A 19           push 0x19
AE5F  6A 26           push 0x26
AE61  BF 5C DD        mov di, 0xdd5c
AE64  1E              push ds
AE65  57              push di
AE66  9A 1B 04 1A 23  call far 231A:041B
AE6B  C4 3E 5C DD     les di, ptr [0xdd5c]
AE6F  81 C7 00 0F     add di, 0xf00
AE73  06              push es
AE74  57              push di
AE75  C4 3E 58 DD     les di, ptr [0xdd58]
AE79  81 C7 00 0F     add di, 0xf00
AE7D  06              push es
AE7E  57              push di
AE7F  68 A0 00        push 0xa0
AE82  9A C2 01 AC 24  call far 24AC:01C2
AE87  6A 02           push 2
AE89  9A A6 19 AC 24  call far 24AC:19A6
AE8E  9A 58 0C AC 24  call far 24AC:0C58
AE93  08 C0           or al, al
AE95  74 05           je 0xae9c
AE97  9A 9B 09 1A 23  call far 231A:099B
loc_AE9C:
AE9C  8D BE 60 FF     lea di, [bp - 0xa0]
AEA0  16              push ss
AEA1  57              push di
AEA2  C4 3E 58 DD     les di, ptr [0xdd58]
AEA6  81 C7 00 0F     add di, 0xf00
AEAA  06              push es
AEAB  57              push di
AEAC  68 A0 00        push 0xa0
AEAF  9A C2 01 AC 24  call far 24AC:01C2
AEB4  C9              leave
AEB5  C2 04 00        ret 4

; ---- routine 0AB5:AEB8  (found by: call)
sub_AEB8:
AEB8  C8 0A 00 00     enter 0xa, 0
AEBC  6B 7E 06 19     imul di, word ptr [bp + 6], 0x19
AEC0  81 C7 EF CC     add di, 0xccef
AEC4  1E              push ds
AEC5  07              pop es
AEC6  89 7E F6        mov word ptr [bp - 0xa], di
AEC9  8C 46 F8        mov word ptr [bp - 8], es
AECC  6A 03           push 3
AECE  26 6B 45 0E 0F  imul ax, word ptr es:[di + 0xe], 0xf
AED3  C4 3E BE D7     les di, ptr [0xd7be]
AED7  03 F8           add di, ax
AED9  81 C7 0B 00     add di, 0xb
AEDD  06              push es
AEDE  57              push di
AEDF  9A D5 00 1A 23  call far 231A:00D5
AEE4  8A 46 08        mov al, byte ptr [bp + 8]
AEE7  98              cwde
AEE8  8B F8           mov di, ax
AEEA  D1 E7           shl di, 1
AEEC  FF B5 E4 D6     push word ptr [di - 0x291c]
AEF0  9A DA 0D 51 1B  call far 1B51:0DDA
AEF5  88 46 FD        mov byte ptr [bp - 3], al
AEF8  80 7E FD 00     cmp byte ptr [bp - 3], 0
AEFC  74 03           je 0xaf01
AEFE  E9 81 00        jmp 0xaf82
loc_AF01:
AF01  9A 2E 02 1A 23  call far 231A:022E
AF06  80 7E 08 00     cmp byte ptr [bp + 8], 0
AF0A  B0 00           mov al, 0
AF0C  75 01           jne 0xaf0f
AF0E  40              inc ax
loc_AF0F:
AF0F  98              cwde
AF10  8B F8           mov di, ax
AF12  D1 E7           shl di, 1
AF14  FF B5 E4 D6     push word ptr [di - 0x291c]
AF18  9A DA 0D 51 1B  call far 1B51:0DDA
AF1D  08 C0           or al, al
AF1F  74 41           je 0xaf62
AF21  80 3E 74 D0 00  cmp byte ptr [0xd074], 0
AF26  75 3A           jne 0xaf62
AF28  8A 46 08        mov al, byte ptr [bp + 8]
AF2B  98              cwde
AF2C  8B F8           mov di, ax
AF2E  8A 85 56 0D     mov al, byte ptr [di + 0xd56]
AF32  30 E4           xor ah, ah
AF34  8B D0           mov dx, ax
AF36  8B 46 06        mov ax, word ptr [bp + 6]
AF39  2B C2           sub ax, dx
AF3B  D1 E0           shl ax, 1
AF3D  8B D0           mov dx, ax
AF3F  8A 46 08        mov al, byte ptr [bp + 8]
AF42  98              cwde
AF43  8B F8           mov di, ax
AF45  D1 E7           shl di, 1
AF47  6B 85 E4 D6 3E  imul ax, word ptr [di - 0x291c], 0x3e
AF4C  C4 3E C2 D7     les di, ptr [0xd7c2]
AF50  03 F8           add di, ax
AF52  03 FA           add di, dx
AF54  26 FF 75 C0     push word ptr es:[di - 0x40]
AF58  C4 7E F6        les di, ptr [bp - 0xa]
AF5B  26 FF 75 0E     push word ptr es:[di + 0xe]
AF5F  E8 6E FE        call 0xadd0
loc_AF62:
AF62  8A 46 08        mov al, byte ptr [bp + 8]
AF65  50              push ax
AF66  8A 46 08        mov al, byte ptr [bp + 8]
AF69  98              cwde
AF6A  8B F8           mov di, ax
AF6C  8A 85 56 0D     mov al, byte ptr [di + 0xd56]
AF70  30 E4           xor ah, ah
AF72  8B D0           mov dx, ax
AF74  8B 46 06        mov ax, word ptr [bp + 6]
AF77  2B C2           sub ax, dx
AF79  50              push ax
AF7A  FF 76 04        push word ptr [bp + 4]
AF7D  6A 00           push 0
AF7F  E8 12 60        call 0x10f94
loc_AF82:
AF82  C4 7E F6        les di, ptr [bp - 0xa]
AF85  26 8B 45 02     mov ax, word ptr es:[di + 2]
AF89  3B 06 2E 0D     cmp ax, word ptr [0xd2e]
AF8D  75 08           jne 0xaf97
AF8F  A1 32 0D        mov ax, word ptr [0xd32]
AF92  89 46 FE        mov word ptr [bp - 2], ax
AF95  EB 0A           jmp 0xafa1
loc_AF97:
AF97  C4 7E F6        les di, ptr [bp - 0xa]
AF9A  26 8B 45 02     mov ax, word ptr es:[di + 2]
AF9E  89 46 FE        mov word ptr [bp - 2], ax
loc_AFA1:
AFA1  FF 76 06        push word ptr [bp + 6]
AFA4  C4 7E F6        les di, ptr [bp - 0xa]
AFA7  06              push es
AFA8  57              push di
AFA9  0E              push cs
AFAA  E8 B6 D6        call 0x8663
AFAD  6A 01           push 1
AFAF  6A 01           push 1
AFB1  C4 7E F6        les di, ptr [bp - 0xa]
AFB4  06              push es
AFB5  57              push di
AFB6  0E              push cs
AFB7  E8 16 B8        call 0x67d0
AFBA  80 7E FD 00     cmp byte ptr [bp - 3], 0
AFBE  75 45           jne 0xb005
AFC0  C4 7E F6        les di, ptr [bp - 0xa]
AFC3  26 6B 45 0E 0F  imul ax, word ptr es:[di + 0xe], 0xf
AFC8  C4 3E BE D7     les di, ptr [0xd7be]
AFCC  03 F8           add di, ax
AFCE  26 C6 45 0A 00  mov byte ptr es:[di + 0xa], 0
AFD3  C4 7E F6        les di, ptr [bp - 0xa]
AFD6  26 FF 75 0E     push word ptr es:[di + 0xe]
AFDA  9A 5B 53 51 1B  call far 1B51:535B
AFDF  8A 46 08        mov al, byte ptr [bp + 8]
AFE2  98              cwde
AFE3  8B F8           mov di, ax
AFE5  8A 85 56 0D     mov al, byte ptr [di + 0xd56]
AFE9  30 E4           xor ah, ah
AFEB  8B D0           mov dx, ax
AFED  8B 46 06        mov ax, word ptr [bp + 6]
AFF0  2B C2           sub ax, dx
AFF2  D1 E0           shl ax, 1
AFF4  8B D0           mov dx, ax
AFF6  8A 46 08        mov al, byte ptr [bp + 8]
AFF9  98              cwde
AFFA  6B F8 28        imul di, ax, 0x28
AFFD  03 FA           add di, dx
AFFF  C7 85 46 D1 47 27 mov word ptr [di - 0x2eba], 0x2747
loc_B005:
B005  C4 7E F6        les di, ptr [bp - 0xa]
B008  26 FF 75 0E     push word ptr es:[di + 0xe]
B00C  9A 6C 18 94 19  call far 1994:186C
B011  C4 7E F6        les di, ptr [bp - 0xa]
B014  26 8B 45 0E     mov ax, word ptr es:[di + 0xe]
B018  C1 E0 03        shl ax, 3
B01B  C4 3E BA D7     les di, ptr [0xd7ba]
B01F  03 F8           add di, ax
B021  26 80 7D 07 00  cmp byte ptr es:[di + 7], 0
B026  75 21           jne 0xb049
B028  80 3E DD D6 00  cmp byte ptr [0xd6dd], 0
B02D  74 1A           je 0xb049
B02F  8A 46 08        mov al, byte ptr [bp + 8]
B032  98              cwde
B033  8B F8           mov di, ax
B035  80 BD DE D6 00  cmp byte ptr [di - 0x2922], 0
B03A  75 0D           jne 0xb049
B03C  8A 46 08        mov al, byte ptr [bp + 8]
B03F  98              cwde
B040  8B F8           mov di, ax
B042  C6 85 DE D6 01  mov byte ptr [di - 0x2922], 1
B047  EB 0A           jmp 0xb053
loc_B049:
B049  8A 46 08        mov al, byte ptr [bp + 8]
B04C  98              cwde
B04D  8B F8           mov di, ax
B04F  FE 8D E0 D6     dec byte ptr [di - 0x2920]
loc_B053:
B053  8B 46 FE        mov ax, word ptr [bp - 2]
B056  C4 7E F6        les di, ptr [bp - 0xa]
B059  26 89 45 02     mov word ptr es:[di + 2], ax
B05D  31 C0           xor ax, ax
B05F  89 46 FA        mov word ptr [bp - 6], ax
B062  C6 46 FC 00     mov byte ptr [bp - 4], 0
B066  EB 03           jmp 0xb06b
loc_B068:
B068  FE 46 FC        inc byte ptr [bp - 4]
loc_B06B:
B06B  8A 46 FC        mov al, byte ptr [bp - 4]
B06E  98              cwde
B06F  8B F8           mov di, ax
B071  D1 E7           shl di, 1
B073  FF B5 E4 D6     push word ptr [di - 0x291c]
B077  9A DA 0D 51 1B  call far 1B51:0DDA
B07C  08 C0           or al, al
B07E  74 40           je 0xb0c0
B080  8A 46 FC        mov al, byte ptr [bp - 4]
B083  98              cwde
B084  6B F8 0A        imul di, ax, 0xa
B087  FF B5 5E CF     push word ptr [di - 0x30a2]
B08B  9A E9 4E 51 1B  call far 1B51:4EE9
B090  08 C0           or al, al
B092  74 2C           je 0xb0c0
B094  8A 46 FC        mov al, byte ptr [bp - 4]
B097  98              cwde
B098  8B F8           mov di, ax
B09A  C6 43 FA 01     mov byte ptr [bp + di - 6], 1
B09E  8A 46 FC        mov al, byte ptr [bp - 4]
B0A1  98              cwde
B0A2  8B F8           mov di, ax
B0A4  D1 E7           shl di, 1
B0A6  6B 85 E4 D6 3E  imul ax, word ptr [di - 0x291c], 0x3e
B0AB  C4 3E C2 D7     les di, ptr [0xd7c2]
B0AF  03 F8           add di, ax
B0B1  26 8B 55 C2     mov dx, word ptr es:[di - 0x3e]
B0B5  8A 46 FC        mov al, byte ptr [bp - 4]
B0B8  98              cwde
B0B9  6B F8 0A        imul di, ax, 0xa
B0BC  89 95 5E CF     mov word ptr [di - 0x30a2], dx
loc_B0C0:
B0C0  80 7E FC 01     cmp byte ptr [bp - 4], 1
B0C4  75 A2           jne 0xb068
B0C6  E8 86 65        call 0x1164f
B0C9  C6 46 FC 00     mov byte ptr [bp - 4], 0
B0CD  EB 03           jmp 0xb0d2
loc_B0CF:
B0CF  FE 46 FC        inc byte ptr [bp - 4]
loc_B0D2:
B0D2  8A 46 FC        mov al, byte ptr [bp - 4]
B0D5  98              cwde
B0D6  8B F8           mov di, ax
B0D8  80 7B FA 00     cmp byte ptr [bp + di - 6], 0
B0DC  74 0D           je 0xb0eb
B0DE  8A 46 FC        mov al, byte ptr [bp - 4]
B0E1  98              cwde
B0E2  6B F8 0A        imul di, ax, 0xa
B0E5  31 C0           xor ax, ax
B0E7  89 85 5E CF     mov word ptr [di - 0x30a2], ax
loc_B0EB:
B0EB  80 7E FC 01     cmp byte ptr [bp - 4], 1
B0EF  75 DE           jne 0xb0cf
B0F1  C9              leave
B0F2  C2 06 00        ret 6

; ---- routine 0AB5:B0F5  (found by: call)
sub_B0F5:
B0F5  C8 0C 00 00     enter 0xc, 0
B0F9  6B 46 06 0F     imul ax, word ptr [bp + 6], 0xf
B0FD  C4 3E BE D7     les di, ptr [0xd7be]
B101  03 F8           add di, ax
B103  89 7E F8        mov word ptr [bp - 8], di
B106  8C 46 FA        mov word ptr [bp - 6], es
B109  8B 46 06        mov ax, word ptr [bp + 6]
B10C  C1 E0 03        shl ax, 3
B10F  C4 3E BA D7     les di, ptr [0xd7ba]
B113  03 F8           add di, ax
B115  26 8A 05        mov al, byte ptr es:[di]
B118  30 E4           xor ah, ah
B11A  3B 06 E6 D6     cmp ax, word ptr [0xd6e6]
B11E  75 06           jne 0xb126
B120  C6 46 FF 01     mov byte ptr [bp - 1], 1
B124  EB 04           jmp 0xb12a
loc_B126:
B126  C6 46 FF 00     mov byte ptr [bp - 1], 0
loc_B12A:
B12A  8B 46 06        mov ax, word ptr [bp + 6]
B12D  C1 E0 03        shl ax, 3
B130  C4 3E BA D7     les di, ptr [0xd7ba]
B134  03 F8           add di, ax
B136  26 80 7D 06 02  cmp byte ptr es:[di + 6], 2
B13B  73 13           jae 0xb150
B13D  6A 07           push 7
B13F  C4 7E F8        les di, ptr [bp - 8]
B142  81 C7 0B 00     add di, 0xb
B146  06              push es
B147  57              push di
B148  9A F8 00 1A 23  call far 231A:00F8
B14D  E9 1A 01        jmp 0xb26a
loc_B150:
B150  8A 46 FF        mov al, byte ptr [bp - 1]
B153  98              cwde
B154  8B F8           mov di, ax
B156  8A 85 56 0D     mov al, byte ptr [di + 0xd56]
B15A  30 E4           xor ah, ah
B15C  8B 7E 04        mov di, word ptr [bp + 4]
B15F  36 03 45 04     add ax, word ptr ss:[di + 4]
B163  6B F8 19        imul di, ax, 0x19
B166  81 C7 EF CC     add di, 0xccef
B16A  1E              push ds
B16B  07              pop es
B16C  89 7E F4        mov word ptr [bp - 0xc], di
B16F  8C 46 F6        mov word ptr [bp - 0xa], es
B172  6A 07           push 7
B174  C4 7E F8        les di, ptr [bp - 8]
B177  26 8A 45 0B     mov al, byte ptr es:[di + 0xb]
B17B  30 E4           xor ah, ah
B17D  50              push ax
B17E  9A 59 02 AC 24  call far 24AC:0259
B183  08 C0           or al, al
B185  74 3F           je 0xb1c6
B187  C7 46 FC 0C 00  mov word ptr [bp - 4], 0xc
loc_B18C:
B18C  FF 4E FC        dec word ptr [bp - 4]
B18F  83 7E FC 01     cmp word ptr [bp - 4], 1
B193  74 2F           je 0xb1c4
B195  8B 46 FC        mov ax, word ptr [bp - 4]
B198  D1 E0           shl ax, 1
B19A  8B D0           mov dx, ax
B19C  80 7E FF 00     cmp byte ptr [bp - 1], 0
B1A0  B0 00           mov al, 0
B1A2  75 01           jne 0xb1a5
B1A4  40              inc ax
loc_B1A5:
B1A5  98              cwde
B1A6  8B F8           mov di, ax
B1A8  D1 E7           shl di, 1
B1AA  6B 85 E4 D6 3E  imul ax, word ptr [di - 0x291c], 0x3e
B1AF  C4 3E C2 D7     les di, ptr [0xd7c2]
B1B3  03 F8           add di, ax
B1B5  03 FA           add di, dx
B1B7  26 8B 45 C0     mov ax, word ptr es:[di - 0x40]
B1BB  C4 7E F4        les di, ptr [bp - 0xc]
B1BE  26 3B 45 14     cmp ax, word ptr es:[di + 0x14]
B1C2  75 C8           jne 0xb18c
loc_B1C4:
B1C4  EB 05           jmp 0xb1cb
loc_B1C6:
B1C6  31 C0           xor ax, ax
B1C8  89 46 FC        mov word ptr [bp - 4], ax
loc_B1CB:
B1CB  FF 46 FC        inc word ptr [bp - 4]
B1CE  83 7E FC 0B     cmp word ptr [bp - 4], 0xb
B1D2  76 05           jbe 0xb1d9
B1D4  31 C0           xor ax, ax
B1D6  89 46 FC        mov word ptr [bp - 4], ax
loc_B1D9:
B1D9  83 7E FC 02     cmp word ptr [bp - 4], 2
B1DD  72 25           jb 0xb204
B1DF  80 7E FF 00     cmp byte ptr [bp - 1], 0
B1E3  B0 00           mov al, 0
B1E5  75 01           jne 0xb1e8
B1E7  40              inc ax
loc_B1E8:
B1E8  98              cwde
B1E9  8B F8           mov di, ax
B1EB  8A 85 56 0D     mov al, byte ptr [di + 0xd56]
B1EF  30 E4           xor ah, ah
B1F1  03 46 FC        add ax, word ptr [bp - 4]
B1F4  6B F8 19        imul di, ax, 0x19
B1F7  FF B5 FD CC     push word ptr [di - 0x3303]
B1FB  9A E9 4E 51 1B  call far 1B51:4EE9
B200  08 C0           or al, al
B202  75 C7           jne 0xb1cb
loc_B204:
B204  83 7E FC 00     cmp word ptr [bp - 4], 0
B208  75 12           jne 0xb21c
B20A  6A 07           push 7
B20C  C4 7E F8        les di, ptr [bp - 8]
B20F  81 C7 0B 00     add di, 0xb
B213  06              push es
B214  57              push di
B215  9A F8 00 1A 23  call far 231A:00F8
B21A  EB 10           jmp 0xb22c
loc_B21C:
B21C  6A 07           push 7
B21E  C4 7E F8        les di, ptr [bp - 8]
B221  81 C7 0B 00     add di, 0xb
B225  06              push es
B226  57              push di
B227  9A D5 00 1A 23  call far 231A:00D5
loc_B22C:
B22C  83 7E FC 01     cmp word ptr [bp - 4], 1
B230  76 2F           jbe 0xb261
B232  8B 46 FC        mov ax, word ptr [bp - 4]
B235  D1 E0           shl ax, 1
B237  8B D0           mov dx, ax
B239  80 7E FF 00     cmp byte ptr [bp - 1], 0
B23D  B0 00           mov al, 0
B23F  75 01           jne 0xb242
B241  40              inc ax
loc_B242:
B242  98              cwde
B243  8B F8           mov di, ax
B245  D1 E7           shl di, 1
B247  6B 85 E4 D6 3E  imul ax, word ptr [di - 0x291c], 0x3e
B24C  C4 3E C2 D7     les di, ptr [0xd7c2]
B250  03 F8           add di, ax
B252  03 FA           add di, dx
B254  26 8B 45 C0     mov ax, word ptr es:[di - 0x40]
B258  C4 7E F4        les di, ptr [bp - 0xc]
B25B  26 89 45 14     mov word ptr es:[di + 0x14], ax
B25F  EB 09           jmp 0xb26a
loc_B261:
B261  C4 7E F4        les di, ptr [bp - 0xc]
B264  31 C0           xor ax, ax
B266  26 89 45 14     mov word ptr es:[di + 0x14], ax
loc_B26A:
B26A  E8 4C 5E        call 0x110b9
B26D  C9              leave
B26E  C2 04 00        ret 4

; ---- routine 0AB5:B271  (found by: call)
sub_B271:
B271  C8 06 00 00     enter 6, 0
B275  6B 46 06 0F     imul ax, word ptr [bp + 6], 0xf
B279  C4 3E BE D7     les di, ptr [0xd7be]
B27D  03 F8           add di, ax
B27F  89 7E FA        mov word ptr [bp - 6], di
B282  8C 46 FC        mov word ptr [bp - 4], es
B285  C6 06 2A 9A 00  mov byte ptr [0x9a2a], 0
B28A  BF 6C 17        mov di, 0x176c
B28D  1E              push ds
B28E  57              push di
B28F  BF 5C DD        mov di, 0xdd5c
B292  1E              push ds
B293  57              push di
B294  9A 2F 05 1A 23  call far 231A:052F
B299  BF 5E 14        mov di, 0x145e
B29C  1E              push ds
B29D  57              push di
B29E  BF 5C DD        mov di, 0xdd5c
B2A1  1E              push ds
B2A2  57              push di
B2A3  9A 2F 05 1A 23  call far 231A:052F
B2A8  80 3E 91 0D 00  cmp byte ptr [0xd91], 0
B2AD  74 26           je 0xb2d5
B2AF  8B 46 06        mov ax, word ptr [bp + 6]
B2B2  C1 E0 03        shl ax, 3
B2B5  C4 3E BA D7     les di, ptr [0xd7ba]
B2B9  03 F8           add di, ax
B2BB  26 80 7D 06 01  cmp byte ptr es:[di + 6], 1
B2C0  76 13           jbe 0xb2d5
B2C2  80 3E 7E 03 0C  cmp byte ptr [0x37e], 0xc
B2C7  73 0C           jae 0xb2d5
B2C9  FF 76 06        push word ptr [bp + 6]
B2CC  9A E9 4E 51 1B  call far 1B51:4EE9
B2D1  08 C0           or al, al
B2D3  74 04           je 0xb2d9
loc_B2D5:
B2D5  B0 00           mov al, 0
B2D7  EB 02           jmp 0xb2db
loc_B2D9:
B2D9  B0 01           mov al, 1
loc_B2DB:
B2DB  88 46 FF        mov byte ptr [bp - 1], al
B2DE  80 3E 74 0C 05  cmp byte ptr [0xc74], 5
B2E3  75 0B           jne 0xb2f0
B2E5  80 7E FF 00     cmp byte ptr [bp - 1], 0
B2E9  75 05           jne 0xb2f0
B2EB  C6 06 74 0C 01  mov byte ptr [0xc74], 1
loc_B2F0:
B2F0  FF 76 06        push word ptr [bp + 6]
B2F3  0E              push cs
B2F4  E8 BC E2        call 0x95b3
B2F7  A0 74 0C        mov al, byte ptr [0xc74]
B2FA  30 E4           xor ah, ah
B2FC  05 0D 00        add ax, 0xd
B2FF  50              push ax
B300  6A 02           push 2
B302  6A 23           push 0x23
B304  9A 03 02 1A 23  call far 231A:0203
B309  BF 74 0C        mov di, 0xc74
B30C  1E              push ds
B30D  57              push di
B30E  8A 46 FF        mov al, byte ptr [bp - 1]
B311  30 E4           xor ah, ah
B313  05 04 00        add ax, 4
B316  50              push ax
B317  9A 8B 0F 1A 23  call far 231A:0F8B
B31C  80 3E 88 DE 02  cmp byte ptr [0xde88], 2
B321  74 03           je 0xb326
B323  E9 E2 00        jmp 0xb408
loc_B326:
B326  80 3E 74 0C 05  cmp byte ptr [0xc74], 5
B32B  75 0A           jne 0xb337
B32D  FF 76 06        push word ptr [bp + 6]
B330  55              push bp
B331  E8 C1 FD        call 0xb0f5
B334  E9 D1 00        jmp 0xb408
loc_B337:
B337  A0 74 0C        mov al, byte ptr [0xc74]
B33A  30 E4           xor ah, ah
B33C  05 04 00        add ax, 4
B33F  50              push ax
B340  C4 7E FA        les di, ptr [bp - 6]
B343  26 8A 45 0A     mov al, byte ptr es:[di + 0xa]
B347  30 E4           xor ah, ah
B349  50              push ax
B34A  9A 59 02 AC 24  call far 24AC:0259
B34F  08 C0           or al, al
B351  75 2E           jne 0xb381
B353  A0 74 0C        mov al, byte ptr [0xc74]
B356  30 E4           xor ah, ah
B358  05 04 00        add ax, 4
B35B  50              push ax
B35C  C4 7E FA        les di, ptr [bp - 6]
B35F  81 C7 0A 00     add di, 0xa
B363  06              push es
B364  57              push di
B365  9A D5 00 1A 23  call far 231A:00D5
B36A  A0 74 0C        mov al, byte ptr [0xc74]
B36D  30 E4           xor ah, ah
B36F  50              push ax
B370  C4 7E FA        les di, ptr [bp - 6]
B373  81 C7 0A 00     add di, 0xa
B377  06              push es
B378  57              push di
B379  9A F8 00 1A 23  call far 231A:00F8
B37E  E9 87 00        jmp 0xb408
loc_B381:
B381  A0 74 0C        mov al, byte ptr [0xc74]
B384  30 E4           xor ah, ah
B386  50              push ax
B387  C4 7E FA        les di, ptr [bp - 6]
B38A  26 8A 45 0A     mov al, byte ptr es:[di + 0xa]
B38E  30 E4           xor ah, ah
B390  50              push ax
B391  9A 59 02 AC 24  call far 24AC:0259
B396  08 C0           or al, al
B398  75 16           jne 0xb3b0
B39A  A0 74 0C        mov al, byte ptr [0xc74]
B39D  30 E4           xor ah, ah
B39F  50              push ax
B3A0  C4 7E FA        les di, ptr [bp - 6]
B3A3  81 C7 0A 00     add di, 0xa
B3A7  06              push es
B3A8  57              push di
B3A9  9A D5 00 1A 23  call far 231A:00D5
B3AE  EB 58           jmp 0xb408
loc_B3B0:
B3B0  A0 74 0C        mov al, byte ptr [0xc74]
B3B3  30 E4           xor ah, ah
B3B5  05 04 00        add ax, 4
B3B8  50              push ax
B3B9  C4 7E FA        les di, ptr [bp - 6]
B3BC  81 C7 0A 00     add di, 0xa
B3C0  06              push es
B3C1  57              push di
B3C2  9A F8 00 1A 23  call far 231A:00F8
B3C7  A0 74 0C        mov al, byte ptr [0xc74]
B3CA  30 E4           xor ah, ah
B3CC  50              push ax
B3CD  C4 7E FA        les di, ptr [bp - 6]
B3D0  81 C7 0A 00     add di, 0xa
B3D4  06              push es
B3D5  57              push di
B3D6  A0 74 0C        mov al, byte ptr [0xc74]
B3D9  30 E4           xor ah, ah
B3DB  50              push ax
B3DC  8B 46 06        mov ax, word ptr [bp + 6]
B3DF  C1 E0 03        shl ax, 3
B3E2  C4 3E BA D7     les di, ptr [0xd7ba]
B3E6  03 F8           add di, ax
B3E8  26 8A 05        mov al, byte ptr es:[di]
B3EB  30 E4           xor ah, ah
B3ED  6B C0 3E        imul ax, ax, 0x3e
B3F0  C4 3E C2 D7     les di, ptr [0xd7c2]
B3F4  03 F8           add di, ax
B3F6  26 8A 45 FB     mov al, byte ptr es:[di - 5]
B3FA  30 E4           xor ah, ah
B3FC  50              push ax
B3FD  9A 59 02 AC 24  call far 24AC:0259
B402  50              push ax
B403  9A 1D 01 1A 23  call far 231A:011D
loc_B408:
B408  A0 88 DE        mov al, byte ptr [0xde88]
B40B  3C 01           cmp al, 1
B40D  74 07           je 0xb416
B40F  3C 0D           cmp al, 0xd
B411  74 03           je 0xb416
B413  E9 DA FE        jmp 0xb2f0
loc_B416:
B416  80 3E 88 DE 0D  cmp byte ptr [0xde88], 0xd
B41B  75 0D           jne 0xb42a
B41D  80 3E 2A 9A 00  cmp byte ptr [0x9a2a], 0
B422  B0 00           mov al, 0
B424  75 01           jne 0xb427
B426  40              inc ax
loc_B427:
B427  A2 2A 9A        mov byte ptr [0x9a2a], al
loc_B42A:
B42A  C9              leave
B42B  C2 04 00        ret 4

; ---- routine 0AB5:B42E  (found by: call)
sub_B42E:
B42E  C8 0A 00 00     enter 0xa, 0
B432  C7 46 FA 3C 00  mov word ptr [bp - 6], 0x3c
B437  C6 46 FF 00     mov byte ptr [bp - 1], 0
B43B  EB 03           jmp 0xb440
loc_B43D:
B43D  FE 46 FF        inc byte ptr [bp - 1]
loc_B440:
B440  C7 46 FC 01 00  mov word ptr [bp - 4], 1
B445  EB 03           jmp 0xb44a
loc_B447:
B447  FF 46 FC        inc word ptr [bp - 4]
loc_B44A:
B44A  8B 46 FC        mov ax, word ptr [bp - 4]
B44D  D1 E0           shl ax, 1
B44F  8B D0           mov dx, ax
B451  8A 46 FF        mov al, byte ptr [bp - 1]
B454  98              cwde
B455  6B F8 28        imul di, ax, 0x28
B458  03 FA           add di, dx
B45A  81 BD 46 D1 88 13 cmp word ptr [di - 0x2eba], 0x1388
B460  7E 16           jle 0xb478
B462  8B 46 FC        mov ax, word ptr [bp - 4]
B465  D1 E0           shl ax, 1
B467  8B D0           mov dx, ax
B469  8A 46 FF        mov al, byte ptr [bp - 1]
B46C  98              cwde
B46D  6B F8 28        imul di, ax, 0x28
B470  03 FA           add di, dx
B472  81 AD 46 D1 10 27 sub word ptr [di - 0x2eba], 0x2710
loc_B478:
B478  8B 46 FC        mov ax, word ptr [bp - 4]
B47B  D1 E0           shl ax, 1
B47D  8B D0           mov dx, ax
B47F  8A 46 FF        mov al, byte ptr [bp - 1]
B482  98              cwde
B483  6B F8 28        imul di, ax, 0x28
B486  03 FA           add di, dx
B488  8B 85 46 D1     mov ax, word ptr [di - 0x2eba]
B48C  3B 46 FA        cmp ax, word ptr [bp - 6]
B48F  7E 3A           jle 0xb4cb
B491  8B 46 FC        mov ax, word ptr [bp - 4]
B494  D1 E0           shl ax, 1
B496  8B D0           mov dx, ax
B498  8A 46 FF        mov al, byte ptr [bp - 1]
B49B  98              cwde
B49C  8B F8           mov di, ax
B49E  D1 E7           shl di, 1
B4A0  6B 85 E4 D6 3E  imul ax, word ptr [di - 0x291c], 0x3e
B4A5  C4 3E C2 D7     les di, ptr [0xd7c2]
B4A9  03 F8           add di, ax
B4AB  03 FA           add di, dx
B4AD  26 8B 45 C0     mov ax, word ptr es:[di - 0x40]
B4B1  A3 42 D1        mov word ptr [0xd142], ax
B4B4  8B 46 FC        mov ax, word ptr [bp - 4]
B4B7  D1 E0           shl ax, 1
B4B9  8B D0           mov dx, ax
B4BB  8A 46 FF        mov al, byte ptr [bp - 1]
B4BE  98              cwde
B4BF  6B F8 28        imul di, ax, 0x28
B4C2  03 FA           add di, dx
B4C4  8B 85 46 D1     mov ax, word ptr [di - 0x2eba]
B4C8  89 46 FA        mov word ptr [bp - 6], ax
loc_B4CB:
B4CB  83 7E FC 14     cmp word ptr [bp - 4], 0x14
B4CF  74 03           je 0xb4d4
B4D1  E9 73 FF        jmp 0xb447
loc_B4D4:
B4D4  80 7E FF 01     cmp byte ptr [bp - 1], 1
B4D8  74 03           je 0xb4dd
B4DA  E9 60 FF        jmp 0xb43d
loc_B4DD:
B4DD  83 3E 42 D1 00  cmp word ptr [0xd142], 0
B4E2  74 46           je 0xb52a
B4E4  A1 42 D1        mov ax, word ptr [0xd142]
B4E7  C1 E0 03        shl ax, 3
B4EA  C4 3E BA D7     les di, ptr [0xd7ba]
B4EE  03 F8           add di, ax
B4F0  89 7E F6        mov word ptr [bp - 0xa], di
B4F3  8C 46 F8        mov word ptr [bp - 8], es
B4F6  26 8A 05        mov al, byte ptr es:[di]
B4F9  30 E4           xor ah, ah
B4FB  50              push ax
B4FC  9A DA 0D 51 1B  call far 1B51:0DDA
B501  08 C0           or al, al
B503  74 25           je 0xb52a
B505  C4 7E F6        les di, ptr [bp - 0xa]
B508  26 80 7D 01 11  cmp byte ptr es:[di + 1], 0x11
B50D  76 1B           jbe 0xb52a
B50F  8B 16 42 D1     mov dx, word ptr [0xd142]
B513  26 8A 05        mov al, byte ptr es:[di]
B516  3A 06 BA DC     cmp al, byte ptr [0xdcba]
B51A  B0 00           mov al, 0
B51C  74 01           je 0xb51f
B51E  40              inc ax
loc_B51F:
B51F  30 E4           xor ah, ah
B521  40              inc ax
B522  8B F8           mov di, ax
B524  D1 E7           shl di, 1
B526  89 95 42 D1     mov word ptr [di - 0x2ebe], dx
loc_B52A:
B52A  C9              leave
B52B  C3              ret

; ---- routine 0AB5:B52C  (found by: call)
sub_B52C:
B52C  C8 04 00 00     enter 4, 0
B530  C6 46 FF 01     mov byte ptr [bp - 1], 1
B534  C7 46 FC 01 00  mov word ptr [bp - 4], 1
B539  EB 03           jmp 0xb53e
loc_B53B:
B53B  FF 46 FC        inc word ptr [bp - 4]
loc_B53E:
B53E  8B 46 FC        mov ax, word ptr [bp - 4]
B541  8B F0           mov si, ax
B543  D1 E0           shl ax, 1
B545  01 F0           add ax, si
B547  8B D0           mov dx, ax
B549  8B 7E 04        mov di, word ptr [bp + 4]
B54C  36 8A 45 FF     mov al, byte ptr ss:[di - 1]
B550  98              cwde
B551  6B F8 21        imul di, ax, 0x21
B554  03 FA           add di, dx
B556  8B 85 E3 D0     mov ax, word ptr [di - 0x2f1d]
B55A  3B 46 06        cmp ax, word ptr [bp + 6]
B55D  75 04           jne 0xb563
B55F  C6 46 FF 00     mov byte ptr [bp - 1], 0
loc_B563:
B563  83 7E FC 0B     cmp word ptr [bp - 4], 0xb
B567  75 D2           jne 0xb53b
B569  8A 46 FF        mov al, byte ptr [bp - 1]
B56C  C9              leave
B56D  C2 04 00        ret 4

; ---- routine 0AB5:B570  (found by: call)
sub_B570:
B570  C8 0E 00 00     enter 0xe, 0
B574  C6 46 FF 00     mov byte ptr [bp - 1], 0
B578  EB 03           jmp 0xb57d
loc_B57A:
B57A  FE 46 FF        inc byte ptr [bp - 1]
loc_B57D:
B57D  C7 46 FC 01 00  mov word ptr [bp - 4], 1
B582  EB 03           jmp 0xb587
loc_B584:
B584  FF 46 FC        inc word ptr [bp - 4]
loc_B587:
B587  8A 46 FF        mov al, byte ptr [bp - 1]
B58A  98              cwde
B58B  8B F8           mov di, ax
B58D  D1 E7           shl di, 1
B58F  6B 85 E4 D6 3E  imul ax, word ptr [di - 0x291c], 0x3e
B594  C4 3E C2 D7     les di, ptr [0xd7c2]
B598  03 F8           add di, ax
B59A  81 C7 C2 FF     add di, 0xffc2
B59E  89 7E F6        mov word ptr [bp - 0xa], di
B5A1  8C 46 F8        mov word ptr [bp - 8], es
B5A4  8B 46 FC        mov ax, word ptr [bp - 4]
B5A7  D1 E0           shl ax, 1
B5A9  03 F8           add di, ax
B5AB  26 83 7D FE 00  cmp word ptr es:[di - 2], 0
B5B0  74 29           je 0xb5db
B5B2  8B 56 FC        mov dx, word ptr [bp - 4]
B5B5  8A 46 FF        mov al, byte ptr [bp - 1]
B5B8  98              cwde
B5B9  6B F8 14        imul di, ax, 0x14
B5BC  03 FA           add di, dx
B5BE  8A 95 97 D1     mov dl, byte ptr [di - 0x2e69]
B5C2  8B 46 FC        mov ax, word ptr [bp - 4]
B5C5  D1 E0           shl ax, 1
B5C7  C4 7E F6        les di, ptr [bp - 0xa]
B5CA  03 F8           add di, ax
B5CC  26 6B 45 FE 0F  imul ax, word ptr es:[di - 2], 0xf
B5D1  C4 3E BE D7     les di, ptr [0xd7be]
B5D5  03 F8           add di, ax
B5D7  26 88 55 06     mov byte ptr es:[di + 6], dl
loc_B5DB:
B5DB  83 7E FC 14     cmp word ptr [bp - 4], 0x14
B5DF  75 A3           jne 0xb584
B5E1  80 7E FF 01     cmp byte ptr [bp - 1], 1
B5E5  75 93           jne 0xb57a
B5E7  C6 46 FF 00     mov byte ptr [bp - 1], 0
B5EB  EB 03           jmp 0xb5f0
loc_B5ED:
B5ED  FE 46 FF        inc byte ptr [bp - 1]
loc_B5F0:
B5F0  C7 46 FA 01 00  mov word ptr [bp - 6], 1
B5F5  EB 03           jmp 0xb5fa
loc_B5F7:
B5F7  FF 46 FA        inc word ptr [bp - 6]
loc_B5FA:
B5FA  8A 46 FF        mov al, byte ptr [bp - 1]
B5FD  98              cwde
B5FE  8B F8           mov di, ax
B600  D1 E7           shl di, 1
B602  6B 85 E4 D6 3E  imul ax, word ptr [di - 0x291c], 0x3e
B607  C4 3E C2 D7     les di, ptr [0xd7c2]
B60B  03 F8           add di, ax
B60D  81 C7 C2 FF     add di, 0xffc2
B611  89 7E F6        mov word ptr [bp - 0xa], di
B614  8C 46 F8        mov word ptr [bp - 8], es
B617  8B 46 FA        mov ax, word ptr [bp - 6]
B61A  D1 E0           shl ax, 1
B61C  03 F8           add di, ax
B61E  26 83 7D FE 00  cmp word ptr es:[di - 2], 0
B623  74 7C           je 0xb6a1
B625  8B 46 FA        mov ax, word ptr [bp - 6]
B628  D1 E0           shl ax, 1
B62A  C4 7E F6        les di, ptr [bp - 0xa]
B62D  03 F8           add di, ax
B62F  26 8B 45 FE     mov ax, word ptr es:[di - 2]
B633  C1 E0 03        shl ax, 3
B636  C4 3E BA D7     les di, ptr [0xd7ba]
B63A  03 F8           add di, ax
B63C  26 80 7D 06 0D  cmp byte ptr es:[di + 6], 0xd
B641  75 5E           jne 0xb6a1
B643  8B 46 FA        mov ax, word ptr [bp - 6]
B646  D1 E0           shl ax, 1
B648  8B D0           mov dx, ax
B64A  8A 46 FF        mov al, byte ptr [bp - 1]
B64D  98              cwde
B64E  6B F8 28        imul di, ax, 0x28
B651  03 FA           add di, dx
B653  81 BD 46 D1 88 13 cmp word ptr [di - 0x2eba], 0x1388
B659  7D 46           jge 0xb6a1
B65B  8B 46 FA        mov ax, word ptr [bp - 6]
B65E  D1 E0           shl ax, 1
B660  C4 7E F6        les di, ptr [bp - 0xa]
B663  03 F8           add di, ax
B665  26 FF 75 FE     push word ptr es:[di - 2]
B669  55              push bp
B66A  E8 BF FE        call 0xb52c
B66D  08 C0           or al, al
B66F  74 30           je 0xb6a1
B671  8B 46 FA        mov ax, word ptr [bp - 6]
B674  D1 E0           shl ax, 1
B676  C4 7E F6        les di, ptr [bp - 0xa]
B679  03 F8           add di, ax
B67B  26 6B 45 FE 0F  imul ax, word ptr es:[di - 2], 0xf
B680  C4 3E BE D7     les di, ptr [0xd7be]
B684  03 F8           add di, ax
B686  89 7E F2        mov word ptr [bp - 0xe], di
B689  8C 46 F4        mov word ptr [bp - 0xc], es
B68C  26 8A 45 06     mov al, byte ptr es:[di + 6]
B690  98              cwde
B691  05 FD FF        add ax, 0xfffd
B694  50              push ax
B695  9A AE 0D 94 19  call far 1994:0DAE
B69A  C4 7E F2        les di, ptr [bp - 0xe]
B69D  26 88 45 06     mov byte ptr es:[di + 6], al
loc_B6A1:
B6A1  83 7E FA 0B     cmp word ptr [bp - 6], 0xb
B6A5  74 03           je 0xb6aa
B6A7  E9 4D FF        jmp 0xb5f7
loc_B6AA:
B6AA  80 7E FF 01     cmp byte ptr [bp - 1], 1
B6AE  74 03           je 0xb6b3
B6B0  E9 3A FF        jmp 0xb5ed
loc_B6B3:
B6B3  C9              leave
B6B4  C3              ret
; data (not reached as code), 8 bytes
B6B5                  pstr '       '

