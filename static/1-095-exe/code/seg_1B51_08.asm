; 1-095.EXE (One-Nil 95), code segment 1B51 (image offsets 1B510..2305F), part 8 of 12
; packed 1-095.EXE sha256 f659fb2d334500d6901fc8d6a0f06c85c0ccda2eb4a3035ae3bb0a0004d79192 (LZEXE 0.91)
; unpacked (tools/static/unlzexe.py) sha256 8df646e017e0965a5d90a58181ca764219ad847833aad0b6cb58fc53372bfb2c
; tool: capstone 5.0.9 (pip package; core library 5.0.1280) (CS_ARCH_X86, CS_MODE_16), recursive descent from the entry point, far calls and near calls/jumps, then routine prologues (55 89 E5 / 55 8B EC / C8 iw 00) in what remains; tools/static/listing.py
; addresses are SEGMENT:OFFSET with SEGMENT the image paragraph before relocation; image offset = SEGMENT*16+OFFSET
; ---- routine 1B51:4EE9  (found by: call, far)
sub_4EE9:
4EE9  C8 06 00 00     enter 6, 0
4EED  6B 46 06 0F     imul ax, word ptr [bp + 6], 0xf
4EF1  C4 3E BE D7     les di, ptr [0xd7be]
4EF5  03 F8           add di, ax
4EF7  89 7E FA        mov word ptr [bp - 6], di
4EFA  8C 46 FC        mov word ptr [bp - 4], es
4EFD  83 7E 06 00     cmp word ptr [bp + 6], 0
4F01  74 5C           je 0x4f5f
4F03  26 80 7D 08 01  cmp byte ptr es:[di + 8], 1
4F08  7C 55           jl 0x4f5f
4F0A  6A 08           push 8
4F0C  26 8A 45 0B     mov al, byte ptr es:[di + 0xb]
4F10  30 E4           xor ah, ah
4F12  50              push ax
4F13  9A 59 02 AC 24  call far 24AC:0259
4F18  08 C0           or al, al
4F1A  75 43           jne 0x4f5f
4F1C  6A 06           push 6
4F1E  C4 7E FA        les di, ptr [bp - 6]
4F21  26 8A 45 0B     mov al, byte ptr es:[di + 0xb]
4F25  30 E4           xor ah, ah
4F27  50              push ax
4F28  9A 59 02 AC 24  call far 24AC:0259
4F2D  08 C0           or al, al
4F2F  75 2E           jne 0x4f5f
4F31  6A 02           push 2
4F33  C4 7E FA        les di, ptr [bp - 6]
4F36  26 8A 45 0B     mov al, byte ptr es:[di + 0xb]
4F3A  30 E4           xor ah, ah
4F3C  50              push ax
4F3D  9A 59 02 AC 24  call far 24AC:0259
4F42  08 C0           or al, al
4F44  75 19           jne 0x4f5f
4F46  6A 03           push 3
4F48  C4 7E FA        les di, ptr [bp - 6]
4F4B  26 8A 45 0B     mov al, byte ptr es:[di + 0xb]
4F4F  30 E4           xor ah, ah
4F51  50              push ax
4F52  9A 59 02 AC 24  call far 24AC:0259
4F57  08 C0           or al, al
4F59  75 04           jne 0x4f5f
4F5B  B0 00           mov al, 0
4F5D  EB 02           jmp 0x4f61
loc_4F5F:
4F5F  B0 01           mov al, 1
loc_4F61:
4F61  88 46 FF        mov byte ptr [bp - 1], al
4F64  8A 46 FF        mov al, byte ptr [bp - 1]
4F67  C9              leave
4F68  CA 02 00        retf 2

; ---- routine 1B51:4F6B  (found by: far)
sub_4F6B:
4F6B  C8 0C 01 00     enter 0x10c, 0
4F6F  31 C0           xor ax, ax
4F71  89 46 FC        mov word ptr [bp - 4], ax
4F74  31 C0           xor ax, ax
4F76  89 46 F8        mov word ptr [bp - 8], ax
4F79  8D BE F4 FE     lea di, [bp - 0x10c]
4F7D  16              push ss
4F7E  57              push di
4F7F  8A 46 06        mov al, byte ptr [bp + 6]
4F82  50              push ax
4F83  9A 6F 0C B9 26  call far 26B9:0C6F
4F88  BF 9A 0D        mov di, 0xd9a
4F8B  1E              push ds
4F8C  57              push di
4F8D  9A FE 0B B9 26  call far 26B9:0BFE
4F92  89 46 F4        mov word ptr [bp - 0xc], ax
4F95  8B 46 08        mov ax, word ptr [bp + 8]
4F98  89 46 F2        mov word ptr [bp - 0xe], ax
4F9B  B8 0C 00        mov ax, 0xc
4F9E  3B 46 F2        cmp ax, word ptr [bp - 0xe]
4FA1  76 03           jbe 0x4fa6
4FA3  E9 98 00        jmp 0x503e
loc_4FA6:
4FA6  89 46 FA        mov word ptr [bp - 6], ax
4FA9  EB 03           jmp 0x4fae
loc_4FAB:
4FAB  FF 46 FA        inc word ptr [bp - 6]
loc_4FAE:
4FAE  8B 46 FA        mov ax, word ptr [bp - 6]
4FB1  D1 E0           shl ax, 1
4FB3  C4 7E 0A        les di, ptr [bp + 0xa]
4FB6  03 F8           add di, ax
4FB8  26 FF 75 FE     push word ptr es:[di - 2]
4FBC  0E              push cs
4FBD  E8 29 FF        call 0x4ee9
4FC0  08 C0           or al, al
4FC2  75 6F           jne 0x5033
4FC4  8B 46 FA        mov ax, word ptr [bp - 6]
4FC7  D1 E0           shl ax, 1
4FC9  C4 7E 0A        les di, ptr [bp + 0xa]
4FCC  03 F8           add di, ax
4FCE  26 8B 45 FE     mov ax, word ptr es:[di - 2]
4FD2  C1 E0 03        shl ax, 3
4FD5  C4 3E BA D7     les di, ptr [0xd7ba]
4FD9  03 F8           add di, ax
4FDB  26 8A 45 07     mov al, byte ptr es:[di + 7]
4FDF  30 E4           xor ah, ah
4FE1  6B 7E 06 0E     imul di, word ptr [bp + 6], 0xe
4FE5  03 F8           add di, ax
4FE7  8A 85 A6 0D     mov al, byte ptr [di + 0xda6]
4FEB  30 E4           xor ah, ah
4FED  89 46 F6        mov word ptr [bp - 0xa], ax
4FF0  83 7E F4 00     cmp word ptr [bp - 0xc], 0
4FF4  76 29           jbe 0x501f
4FF6  8B 46 FA        mov ax, word ptr [bp - 6]
4FF9  D1 E0           shl ax, 1
4FFB  C4 7E 0A        les di, ptr [bp + 0xa]
4FFE  03 F8           add di, ax
5000  26 FF 75 FE     push word ptr es:[di - 2]
5004  0E              push cs
5005  E8 D9 FD        call 0x4de1
5008  8A D0           mov dl, al
500A  83 7E F4 03     cmp word ptr [bp - 0xc], 3
500E  B0 00           mov al, 0
5010  76 01           jbe 0x5013
5012  40              inc ax
loc_5013:
5013  3A C2           cmp al, dl
5015  74 08           je 0x501f
5017  8B 46 F6        mov ax, word ptr [bp - 0xa]
501A  D1 E8           shr ax, 1
501C  89 46 F6        mov word ptr [bp - 0xa], ax
loc_501F:
501F  8B 46 F6        mov ax, word ptr [bp - 0xa]
5022  3B 46 F8        cmp ax, word ptr [bp - 8]
5025  76 0C           jbe 0x5033
5027  8B 46 FA        mov ax, word ptr [bp - 6]
502A  89 46 FC        mov word ptr [bp - 4], ax
502D  8B 46 F6        mov ax, word ptr [bp - 0xa]
5030  89 46 F8        mov word ptr [bp - 8], ax
loc_5033:
5033  8B 46 FA        mov ax, word ptr [bp - 6]
5036  3B 46 F2        cmp ax, word ptr [bp - 0xe]
5039  74 03           je 0x503e
503B  E9 6D FF        jmp 0x4fab
loc_503E:
503E  8B 46 FC        mov ax, word ptr [bp - 4]
5041  89 46 FE        mov word ptr [bp - 2], ax
5044  8B 46 FE        mov ax, word ptr [bp - 2]
5047  C9              leave
5048  CA 08 00        retf 8

; ---- routine 1B51:504B  (found by: call, far)
sub_504B:
504B  C8 0E 00 00     enter 0xe, 0
504F  6B 46 0A 3E     imul ax, word ptr [bp + 0xa], 0x3e
5053  C4 3E C2 D7     les di, ptr [0xd7c2]
5057  03 F8           add di, ax
5059  81 C7 C2 FF     add di, 0xffc2
505D  89 7E F6        mov word ptr [bp - 0xa], di
5060  8C 46 F8        mov word ptr [bp - 8], es
5063  FF 76 0A        push word ptr [bp + 0xa]
5066  0E              push cs
5067  E8 2D F9        call 0x4997
506A  89 46 FC        mov word ptr [bp - 4], ax
506D  31 C0           xor ax, ax
506F  89 46 FE        mov word ptr [bp - 2], ax
5072  EB 03           jmp 0x5077
loc_5074:
5074  FF 46 FE        inc word ptr [bp - 2]
loc_5077:
5077  8B 46 08        mov ax, word ptr [bp + 8]
507A  D1 E0           shl ax, 1
507C  8B 7E FE        mov di, word ptr [bp - 2]
507F  C1 E7 02        shl di, 2
5082  03 F8           add di, ax
5084  31 C0           xor ax, ax
5086  89 85 74 D6     mov word ptr [di - 0x298c], ax
508A  83 7E FE 03     cmp word ptr [bp - 2], 3
508E  75 E4           jne 0x5074
5090  C7 46 FE 01 00  mov word ptr [bp - 2], 1
5095  EB 03           jmp 0x509a
loc_5097:
5097  FF 46 FE        inc word ptr [bp - 2]
loc_509A:
509A  8B 46 FE        mov ax, word ptr [bp - 2]
509D  D1 E0           shl ax, 1
509F  C4 7E F6        les di, ptr [bp - 0xa]
50A2  03 F8           add di, ax
50A4  26 83 7D FE 00  cmp word ptr es:[di - 2], 0
50A9  75 03           jne 0x50ae
50AB  E9 D3 00        jmp 0x5181
loc_50AE:
50AE  8B 46 FE        mov ax, word ptr [bp - 2]
50B1  D1 E0           shl ax, 1
50B3  C4 7E F6        les di, ptr [bp - 0xa]
50B6  03 F8           add di, ax
50B8  26 8B 45 FE     mov ax, word ptr es:[di - 2]
50BC  C1 E0 03        shl ax, 3
50BF  C4 3E BA D7     les di, ptr [0xd7ba]
50C3  03 F8           add di, ax
50C5  89 7E F2        mov word ptr [bp - 0xe], di
50C8  8C 46 F4        mov word ptr [bp - 0xc], es
50CB  8B 46 FE        mov ax, word ptr [bp - 2]
50CE  D1 E0           shl ax, 1
50D0  C4 7E F6        les di, ptr [bp - 0xa]
50D3  03 F8           add di, ax
50D5  26 FF 75 FE     push word ptr es:[di - 2]
50D9  6A 00           push 0
50DB  0E              push cs
50DC  E8 CB F9        call 0x4aaa
50DF  89 46 FA        mov word ptr [bp - 6], ax
50E2  83 7E FA 00     cmp word ptr [bp - 6], 0
50E6  74 06           je 0x50ee
50E8  8B 46 FC        mov ax, word ptr [bp - 4]
50EB  01 46 FA        add word ptr [bp - 6], ax
loc_50EE:
50EE  C4 7E F2        les di, ptr [bp - 0xe]
50F1  26 8A 45 06     mov al, byte ptr es:[di + 6]
50F5  30 E4           xor ah, ah
50F7  8B F8           mov di, ax
50F9  80 BD BE 12 04  cmp byte ptr [di + 0x12be], 4
50FE  73 28           jae 0x5128
5100  8B 4E FA        mov cx, word ptr [bp - 6]
5103  8B 46 08        mov ax, word ptr [bp + 8]
5106  D1 E0           shl ax, 1
5108  8B D0           mov dx, ax
510A  C4 7E F2        les di, ptr [bp - 0xe]
510D  26 8A 45 06     mov al, byte ptr es:[di + 6]
5111  30 E4           xor ah, ah
5113  8B F8           mov di, ax
5115  8A 85 BE 12     mov al, byte ptr [di + 0x12be]
5119  30 E4           xor ah, ah
511B  8B F8           mov di, ax
511D  C1 E7 02        shl di, 2
5120  03 FA           add di, dx
5122  01 8D 74 D6     add word ptr [di - 0x298c], cx
5126  EB 59           jmp 0x5181
loc_5128:
5128  8B 46 FA        mov ax, word ptr [bp - 6]
512B  D1 E8           shr ax, 1
512D  89 46 FA        mov word ptr [bp - 6], ax
5130  8B 4E FA        mov cx, word ptr [bp - 6]
5133  8B 46 08        mov ax, word ptr [bp + 8]
5136  D1 E0           shl ax, 1
5138  8B D0           mov dx, ax
513A  C4 7E F2        les di, ptr [bp - 0xe]
513D  26 8A 45 06     mov al, byte ptr es:[di + 6]
5141  30 E4           xor ah, ah
5143  8B F8           mov di, ax
5145  8A 85 BE 12     mov al, byte ptr [di + 0x12be]
5149  30 E4           xor ah, ah
514B  2D 03 00        sub ax, 3
514E  8B F8           mov di, ax
5150  C1 E7 02        shl di, 2
5153  03 FA           add di, dx
5155  01 8D 74 D6     add word ptr [di - 0x298c], cx
5159  8B 4E FA        mov cx, word ptr [bp - 6]
515C  8B 46 08        mov ax, word ptr [bp + 8]
515F  D1 E0           shl ax, 1
5161  8B D0           mov dx, ax
5163  C4 7E F2        les di, ptr [bp - 0xe]
5166  26 8A 45 06     mov al, byte ptr es:[di + 6]
516A  30 E4           xor ah, ah
516C  8B F8           mov di, ax
516E  8A 85 BE 12     mov al, byte ptr [di + 0x12be]
5172  30 E4           xor ah, ah
5174  48              dec ax
5175  48              dec ax
5176  8B F8           mov di, ax
5178  C1 E7 02        shl di, 2
517B  03 FA           add di, dx
517D  01 8D 74 D6     add word ptr [di - 0x298c], cx
loc_5181:
5181  83 7E FE 0B     cmp word ptr [bp - 2], 0xb
5185  74 03           je 0x518a
5187  E9 0D FF        jmp 0x5097
loc_518A:
518A  80 7E 06 00     cmp byte ptr [bp + 6], 0
518E  74 50           je 0x51e0
5190  31 C0           xor ax, ax
5192  89 46 FE        mov word ptr [bp - 2], ax
5195  EB 03           jmp 0x519a
loc_5197:
5197  FF 46 FE        inc word ptr [bp - 2]
loc_519A:
519A  C4 7E F6        les di, ptr [bp - 0xa]
519D  26 80 7D 37 00  cmp byte ptr es:[di + 0x37], 0
51A2  B0 00           mov al, 0
51A4  75 01           jne 0x51a7
51A6  40              inc ax
loc_51A7:
51A7  98              cwde
51A8  8B F8           mov di, ax
51AA  8A 85 CC 12     mov al, byte ptr [di + 0x12cc]
51AE  30 E4           xor ah, ah
51B0  8B C8           mov cx, ax
51B2  8B 46 08        mov ax, word ptr [bp + 8]
51B5  D1 E0           shl ax, 1
51B7  8B 7E FE        mov di, word ptr [bp - 2]
51BA  C1 E7 02        shl di, 2
51BD  03 F8           add di, ax
51BF  8B 85 74 D6     mov ax, word ptr [di - 0x298c]
51C3  31 D2           xor dx, dx
51C5  F7 F1           div cx
51C7  8B D0           mov dx, ax
51C9  8B 46 08        mov ax, word ptr [bp + 8]
51CC  D1 E0           shl ax, 1
51CE  8B 7E FE        mov di, word ptr [bp - 2]
51D1  C1 E7 02        shl di, 2
51D4  03 F8           add di, ax
51D6  01 95 74 D6     add word ptr [di - 0x298c], dx
51DA  83 7E FE 03     cmp word ptr [bp - 2], 3
51DE  75 B7           jne 0x5197
loc_51E0:
51E0  C9              leave
51E1  CA 06 00        retf 6

; ---- routine 1B51:51E4  (found by: call, far)
sub_51E4:
51E4  C8 08 00 00     enter 8, 0
51E8  8B 46 06        mov ax, word ptr [bp + 6]
51EB  C1 E0 03        shl ax, 3
51EE  C4 3E BA D7     les di, ptr [0xd7ba]
51F2  03 F8           add di, ax
51F4  89 7E F8        mov word ptr [bp - 8], di
51F7  8C 46 FA        mov word ptr [bp - 6], es
51FA  26 8A 45 01     mov al, byte ptr es:[di + 1]
51FE  26 3A 45 02     cmp al, byte ptr es:[di + 2]
5202  72 20           jb 0x5224
5204  26 8A 45 02     mov al, byte ptr es:[di + 2]
5208  30 E4           xor ah, ah
520A  05 03 00        add ax, 3
520D  8B D0           mov dx, ax
520F  26 8A 45 01     mov al, byte ptr es:[di + 1]
5213  30 E4           xor ah, ah
5215  3B C2           cmp ax, dx
5217  7F 0B           jg 0x5224
5219  26 8A 45 03     mov al, byte ptr es:[di + 3]
521D  26 88 45 04     mov byte ptr es:[di + 4], al
5221  E9 93 00        jmp 0x52b7
loc_5224:
5224  C4 7E F8        les di, ptr [bp - 8]
5227  26 8A 45 03     mov al, byte ptr es:[di + 3]
522B  30 E4           xor ah, ah
522D  89 46 FC        mov word ptr [bp - 4], ax
5230  26 8A 45 02     mov al, byte ptr es:[di + 2]
5234  30 E4           xor ah, ah
5236  05 03 00        add ax, 3
5239  8B D0           mov dx, ax
523B  26 8A 45 01     mov al, byte ptr es:[di + 1]
523F  30 E4           xor ah, ah
5241  3B C2           cmp ax, dx
5243  7E 31           jle 0x5276
5245  6A 00           push 0
5247  6A 0F           push 0xf
5249  26 8A 45 02     mov al, byte ptr es:[di + 2]
524D  30 E4           xor ah, ah
524F  05 03 00        add ax, 3
5252  8B D0           mov dx, ax
5254  26 8A 45 01     mov al, byte ptr es:[di + 1]
5258  30 E4           xor ah, ah
525A  2B C2           sub ax, dx
525C  99              cdq
525D  52              push dx
525E  50              push ax
525F  9A FA 04 AC 24  call far 24AC:04FA
5264  8B C8           mov cx, ax
5266  8B DA           mov bx, dx
5268  B8 10 00        mov ax, 0x10
526B  31 D2           xor dx, dx
526D  2B C1           sub ax, cx
526F  1B D3           sbb dx, bx
5271  89 46 FE        mov word ptr [bp - 2], ax
5274  EB 31           jmp 0x52a7
loc_5276:
5276  6A 00           push 0
5278  6A 0F           push 0xf
527A  C4 7E F8        les di, ptr [bp - 8]
527D  26 8A 45 01     mov al, byte ptr es:[di + 1]
5281  30 E4           xor ah, ah
5283  8B D0           mov dx, ax
5285  26 8A 45 02     mov al, byte ptr es:[di + 2]
5289  30 E4           xor ah, ah
528B  2B C2           sub ax, dx
528D  D1 E8           shr ax, 1
528F  99              cdq
5290  52              push dx
5291  50              push ax
5292  9A FA 04 AC 24  call far 24AC:04FA
5297  8B C8           mov cx, ax
5299  8B DA           mov bx, dx
529B  B8 10 00        mov ax, 0x10
529E  31 D2           xor dx, dx
52A0  2B C1           sub ax, cx
52A2  1B D3           sbb dx, bx
52A4  89 46 FE        mov word ptr [bp - 2], ax
loc_52A7:
52A7  8B 46 FC        mov ax, word ptr [bp - 4]
52AA  F7 66 FE        mul word ptr [bp - 2]
52AD  C1 E8 04        shr ax, 4
52B0  C4 7E F8        les di, ptr [bp - 8]
52B3  26 88 45 04     mov byte ptr es:[di + 4], al
loc_52B7:
52B7  C9              leave
52B8  CA 02 00        retf 2

; ---- routine 1B51:52BB  (found by: call)
sub_52BB:
52BB  C8 04 00 00     enter 4, 0
52BF  8B 46 06        mov ax, word ptr [bp + 6]
52C2  C1 E0 03        shl ax, 3
52C5  C4 3E BA D7     les di, ptr [0xd7ba]
52C9  03 F8           add di, ax
52CB  89 7E FC        mov word ptr [bp - 4], di
52CE  8C 46 FE        mov word ptr [bp - 2], es
52D1  6A 03           push 3
52D3  9A 6D 07 1A 23  call far 231A:076D
52D8  50              push ax
52D9  6A 03           push 3
52DB  9A 6D 07 1A 23  call far 231A:076D
52E0  8B D0           mov dx, ax
52E2  C4 7E FC        les di, ptr [bp - 4]
52E5  26 80 7D 07 00  cmp byte ptr es:[di + 7], 0
52EA  B0 00           mov al, 0
52EC  75 01           jne 0x52ef
52EE  40              inc ax
loc_52EF:
52EF  98              cwde
52F0  8B F8           mov di, ax
52F2  8A 85 CE 12     mov al, byte ptr [di + 0x12ce]
52F6  30 E4           xor ah, ah
52F8  03 C2           add ax, dx
52FA  5A              pop dx
52FB  2B C2           sub ax, dx
52FD  C4 7E FC        les di, ptr [bp - 4]
5300  26 88 45 02     mov byte ptr es:[di + 2], al
loc_5304:
5304  C4 7E FC        les di, ptr [bp - 4]
5307  26 8A 45 01     mov al, byte ptr es:[di + 1]
530B  30 E4           xor ah, ah
530D  8B D0           mov dx, ax
530F  26 8A 45 02     mov al, byte ptr es:[di + 2]
5313  30 E4           xor ah, ah
5315  05 06 00        add ax, 6
5318  3B C2           cmp ax, dx
531A  7D 06           jge 0x5322
531C  26 FE 45 02     inc byte ptr es:[di + 2]
5320  EB E2           jmp 0x5304
loc_5322:
5322  C9              leave
5323  CA 02 00        retf 2

; ---- routine 1B51:5326  (found by: call, far)
sub_5326:
5326  C8 04 00 00     enter 4, 0
532A  6B 46 06 0F     imul ax, word ptr [bp + 6], 0xf
532E  C4 3E BE D7     les di, ptr [0xd7be]
5332  03 F8           add di, ax
5334  89 7E FC        mov word ptr [bp - 4], di
5337  8C 46 FE        mov word ptr [bp - 2], es
533A  6A 08           push 8
533C  81 C7 0A 00     add di, 0xa
5340  06              push es
5341  57              push di
5342  9A D5 00 1A 23  call far 231A:00D5
5347  6A 04           push 4
5349  C4 7E FC        les di, ptr [bp - 4]
534C  81 C7 0A 00     add di, 0xa
5350  06              push es
5351  57              push di
5352  9A F8 00 1A 23  call far 231A:00F8
5357  C9              leave
5358  CA 02 00        retf 2

; ---- routine 1B51:535B  (found by: call, far)
sub_535B:
535B  C8 08 00 00     enter 8, 0
535F  6B 46 06 0F     imul ax, word ptr [bp + 6], 0xf
5363  C4 3E BE D7     les di, ptr [0xd7be]
5367  03 F8           add di, ax
5369  89 7E FC        mov word ptr [bp - 4], di
536C  8C 46 FE        mov word ptr [bp - 2], es
536F  8B 46 06        mov ax, word ptr [bp + 6]
5372  C1 E0 03        shl ax, 3
5375  C4 3E BA D7     les di, ptr [0xd7ba]
5379  03 F8           add di, ax
537B  89 7E F8        mov word ptr [bp - 8], di
537E  8C 46 FA        mov word ptr [bp - 6], es
5381  FF 76 06        push word ptr [bp + 6]
5384  0E              push cs
5385  E8 E4 F9        call 0x4d6c
5388  3C 04           cmp al, 4
538A  73 07           jae 0x5393
538C  FF 76 06        push word ptr [bp + 6]
538F  0E              push cs
5390  E8 93 FF        call 0x5326
loc_5393:
5393  C4 7E F8        les di, ptr [bp - 8]
5396  26 8A 45 06     mov al, byte ptr es:[di + 6]
539A  3C 01           cmp al, 1
539C  76 08           jbe 0x53a6
539E  3C 03           cmp al, 3
53A0  72 26           jb 0x53c8
53A2  3C 04           cmp al, 4
53A4  77 22           ja 0x53c8
loc_53A6:
53A6  6A 05           push 5
53A8  C4 7E FC        les di, ptr [bp - 4]
53AB  81 C7 0A 00     add di, 0xa
53AF  06              push es
53B0  57              push di
53B1  9A D5 00 1A 23  call far 231A:00D5
53B6  6A 01           push 1
53B8  C4 7E FC        les di, ptr [bp - 4]
53BB  81 C7 0A 00     add di, 0xa
53BF  06              push es
53C0  57              push di
53C1  9A D5 00 1A 23  call far 231A:00D5
53C6  EB 3A           jmp 0x5402
loc_53C8:
53C8  C4 7E F8        les di, ptr [bp - 8]
53CB  26 80 7D 06 02  cmp byte ptr es:[di + 6], 2
53D0  75 30           jne 0x5402
53D2  6A 05           push 5
53D4  C4 7E FC        les di, ptr [bp - 4]
53D7  81 C7 0A 00     add di, 0xa
53DB  06              push es
53DC  57              push di
53DD  9A D5 00 1A 23  call far 231A:00D5
53E2  6A 06           push 6
53E4  C4 7E FC        les di, ptr [bp - 4]
53E7  81 C7 0A 00     add di, 0xa
53EB  06              push es
53EC  57              push di
53ED  9A D5 00 1A 23  call far 231A:00D5
53F2  6A 02           push 2
53F4  C4 7E FC        les di, ptr [bp - 4]
53F7  81 C7 0A 00     add di, 0xa
53FB  06              push es
53FC  57              push di
53FD  9A D5 00 1A 23  call far 231A:00D5
loc_5402:
5402  C9              leave
5403  CA 02 00        retf 2

; ---- routine 1B51:5406  (found by: call, far)
sub_5406:
5406  C8 08 00 00     enter 8, 0
540A  8B 46 06        mov ax, word ptr [bp + 6]
540D  C1 E0 03        shl ax, 3
5410  C4 3E BA D7     les di, ptr [0xd7ba]
5414  03 F8           add di, ax
5416  89 7E FC        mov word ptr [bp - 4], di
5419  8C 46 FE        mov word ptr [bp - 2], es
541C  6B 46 06 0F     imul ax, word ptr [bp + 6], 0xf
5420  C4 3E BE D7     les di, ptr [0xd7be]
5424  03 F8           add di, ax
5426  89 7E F8        mov word ptr [bp - 8], di
5429  8C 46 FA        mov word ptr [bp - 6], es
542C  C4 7E FC        les di, ptr [bp - 4]
542F  26 8A 45 02     mov al, byte ptr es:[di + 2]
5433  30 E4           xor ah, ah
5435  05 04 00        add ax, 4
5438  8B D0           mov dx, ax
543A  26 8A 45 01     mov al, byte ptr es:[di + 1]
543E  30 E4           xor ah, ah
5440  3B C2           cmp ax, dx
5442  7E 10           jle 0x5454
5444  6A 19           push 0x19
5446  9A 6D 07 1A 23  call far 231A:076D
544B  C4 7E F8        les di, ptr [bp - 8]
544E  26 88 45 07     mov byte ptr es:[di + 7], al
5452  EB 0E           jmp 0x5462
loc_5454:
5454  6A 20           push 0x20
5456  9A 6D 07 1A 23  call far 231A:076D
545B  C4 7E F8        les di, ptr [bp - 8]
545E  26 88 45 07     mov byte ptr es:[di + 7], al
loc_5462:
5462  C4 7E F8        les di, ptr [bp - 8]
5465  26 8A 45 07     mov al, byte ptr es:[di + 7]
5469  26 88 45 08     mov byte ptr es:[di + 8], al
546D  26 C6 45 0E 00  mov byte ptr es:[di + 0xe], 0
5472  C9              leave
5473  CA 02 00        retf 2

; ---- routine 1B51:5476  (found by: call)
sub_5476:
5476  C8 0E 00 00     enter 0xe, 0
547A  8B 46 04        mov ax, word ptr [bp + 4]
547D  C1 E0 03        shl ax, 3
5480  C4 3E BA D7     les di, ptr [0xd7ba]
5484  03 F8           add di, ax
5486  89 7E F8        mov word ptr [bp - 8], di
5489  8C 46 FA        mov word ptr [bp - 6], es
548C  6B 46 04 0F     imul ax, word ptr [bp + 4], 0xf
5490  C4 3E BE D7     les di, ptr [0xd7be]
5494  03 F8           add di, ax
5496  89 7E F4        mov word ptr [bp - 0xc], di
5499  8C 46 F6        mov word ptr [bp - 0xa], es
549C  8B 46 04        mov ax, word ptr [bp + 4]
549F  C4 3E 84 DE     les di, ptr [0xde84]
54A3  26 89 05        mov word ptr es:[di], ax
54A6  C4 7E F4        les di, ptr [bp - 0xc]
54A9  31 C0           xor ax, ax
54AB  26 89 05        mov word ptr es:[di], ax
54AE  31 C0           xor ax, ax
54B0  26 89 45 02     mov word ptr es:[di + 2], ax
54B4  C4 7E F8        les di, ptr [bp - 8]
54B7  26 8A 45 01     mov al, byte ptr es:[di + 1]
54BB  30 E4           xor ah, ah
54BD  89 46 F2        mov word ptr [bp - 0xe], ax
54C0  B8 14 00        mov ax, 0x14
54C3  3B 46 F2        cmp ax, word ptr [bp - 0xe]
54C6  77 26           ja 0x54ee
54C8  89 46 FE        mov word ptr [bp - 2], ax
54CB  EB 03           jmp 0x54d0
loc_54CD:
54CD  FF 46 FE        inc word ptr [bp - 2]
loc_54D0:
54D0  9A 3F 0D AC 24  call far 24AC:0D3F
54D5  08 C0           or al, al
54D7  74 0D           je 0x54e6
54D9  6A 20           push 0x20
54DB  9A 6D 07 1A 23  call far 231A:076D
54E0  C4 7E F4        les di, ptr [bp - 0xc]
54E3  26 01 05        add word ptr es:[di], ax
loc_54E6:
54E6  8B 46 FE        mov ax, word ptr [bp - 2]
54E9  3B 46 F2        cmp ax, word ptr [bp - 0xe]
54EC  75 DF           jne 0x54cd
loc_54EE:
54EE  C4 7E F4        les di, ptr [bp - 0xc]
54F1  26 83 3D 00     cmp word ptr es:[di], 0
54F5  77 03           ja 0x54fa
54F7  E9 94 00        jmp 0x558e
loc_54FA:
54FA  C4 7E F8        les di, ptr [bp - 8]
54FD  26 80 7D 07 00  cmp byte ptr es:[di + 7], 0
5502  75 39           jne 0x553d
5504  C4 7E F4        les di, ptr [bp - 0xc]
5507  26 8B 05        mov ax, word ptr es:[di]
550A  D1 E8           shr ax, 1
550C  50              push ax
550D  9A 6D 07 1A 23  call far 231A:076D
5512  99              cdq
5513  52              push dx
5514  50              push ax
5515  C4 7E F4        les di, ptr [bp - 0xc]
5518  26 FF 35        push word ptr es:[di]
551B  9A 6D 07 1A 23  call far 231A:076D
5520  99              cdq
5521  8B C8           mov cx, ax
5523  8B DA           mov bx, dx
5525  C4 7E F4        les di, ptr [bp - 0xc]
5528  26 8B 05        mov ax, word ptr es:[di]
552B  31 D2           xor dx, dx
552D  03 C1           add ax, cx
552F  13 D3           adc dx, bx
5531  59              pop cx
5532  5B              pop bx
5533  2B C1           sub ax, cx
5535  1B D3           sbb dx, bx
5537  26 89 45 02     mov word ptr es:[di + 2], ax
553B  EB 51           jmp 0x558e
loc_553D:
553D  C4 7E F8        les di, ptr [bp - 8]
5540  26 8A 45 07     mov al, byte ptr es:[di + 7]
5544  30 E4           xor ah, ah
5546  8B F8           mov di, ax
5548  8A 85 CF 12     mov al, byte ptr [di + 0x12cf]
554C  30 E4           xor ah, ah
554E  8B C8           mov cx, ax
5550  C4 7E F4        les di, ptr [bp - 0xc]
5553  26 8B 05        mov ax, word ptr es:[di]
5556  31 D2           xor dx, dx
5558  F7 F1           div cx
555A  89 46 FC        mov word ptr [bp - 4], ax
555D  8B 46 FC        mov ax, word ptr [bp - 4]
5560  99              cdq
5561  B9 02 00        mov cx, 2
5564  F7 F9           idiv cx
5566  50              push ax
5567  9A 6D 07 1A 23  call far 231A:076D
556C  50              push ax
556D  FF 76 FC        push word ptr [bp - 4]
5570  9A 6D 07 1A 23  call far 231A:076D
5575  03 46 FC        add ax, word ptr [bp - 4]
5578  5A              pop dx
5579  2B C2           sub ax, dx
557B  89 46 FC        mov word ptr [bp - 4], ax
557E  83 7E FC 00     cmp word ptr [bp - 4], 0
5582  7E 0A           jle 0x558e
5584  8B 46 FC        mov ax, word ptr [bp - 4]
5587  C4 7E F4        les di, ptr [bp - 0xc]
558A  26 89 45 02     mov word ptr es:[di + 2], ax
loc_558E:
558E  C9              leave
558F  C2 02 00        ret 2
; data (not reached as code), 2 bytes
5592                  db 01 2E   ; ..

; ---- routine 1B51:5594  (found by: far)
sub_5594:
5594  C8 10 01 00     enter 0x110, 0
5598  8B 46 0A        mov ax, word ptr [bp + 0xa]
559B  0B 46 0C        or ax, word ptr [bp + 0xc]
559E  75 0A           jne 0x55aa
55A0  31 C0           xor ax, ax
55A2  89 46 FC        mov word ptr [bp - 4], ax
55A5  89 46 FE        mov word ptr [bp - 2], ax
55A8  EB 2E           jmp 0x55d8
loc_55AA:
55AA  FF 76 08        push word ptr [bp + 8]
55AD  FF 76 06        push word ptr [bp + 6]
55B0  6A 00           push 0
55B2  6A 01           push 1
55B4  9A C0 04 AC 24  call far 24AC:04C0
55B9  52              push dx
55BA  50              push ax
55BB  8B 46 0A        mov ax, word ptr [bp + 0xa]
55BE  8B 56 0C        mov dx, word ptr [bp + 0xc]
55C1  B9 64 00        mov cx, 0x64
55C4  31 DB           xor bx, bx
55C6  9A 2A 0A B9 26  call far 26B9:0A2A
55CB  59              pop cx
55CC  5B              pop bx
55CD  9A 67 0A B9 26  call far 26B9:0A67
55D2  89 46 FC        mov word ptr [bp - 4], ax
55D5  89 56 FE        mov word ptr [bp - 2], dx
loc_55D8:
55D8  8B 46 FC        mov ax, word ptr [bp - 4]
55DB  8B 56 FE        mov dx, word ptr [bp - 2]
55DE  B9 64 00        mov cx, 0x64
55E1  31 DB           xor bx, bx
55E3  9A 67 0A B9 26  call far 26B9:0A67
55E8  89 C8           mov ax, cx
55EA  89 DA           mov dx, bx
55EC  52              push dx
55ED  50              push ax
55EE  6A 02           push 2
55F0  8D 7E F0        lea di, [bp - 0x10]
55F3  16              push ss
55F4  57              push di
55F5  6A 0A           push 0xa
55F7  9A 0A 19 B9 26  call far 26B9:190A
55FC  80 7E F1 20     cmp byte ptr [bp - 0xf], 0x20
5600  75 04           jne 0x5606
5602  C6 46 F1 30     mov byte ptr [bp - 0xf], 0x30
loc_5606:
5606  8D BE F0 FE     lea di, [bp - 0x110]
560A  16              push ss
560B  57              push di
560C  8B 46 FC        mov ax, word ptr [bp - 4]
560F  8B 56 FE        mov dx, word ptr [bp - 2]
5612  B9 64 00        mov cx, 0x64
5615  31 DB           xor bx, bx
5617  9A 67 0A B9 26  call far 26B9:0A67
561C  52              push dx
561D  50              push ax
561E  9A C9 07 1A 23  call far 231A:07C9
5623  BF 92 55        mov di, 0x5592
5626  0E              push cs
5627  57              push di
5628  9A D2 0B B9 26  call far 26B9:0BD2
562D  8D 7E F0        lea di, [bp - 0x10]
5630  16              push ss
5631  57              push di
5632  9A D2 0B B9 26  call far 26B9:0BD2
5637  C4 7E 0E        les di, ptr [bp + 0xe]
563A  06              push es
563B  57              push di
563C  6A 0A           push 0xa
563E  9A 6D 0B B9 26  call far 26B9:0B6D
5643  C9              leave
5644  CA 08 00        retf 8

; ---- routine 1B51:5647  (found by: call)
sub_5647:
5647  C8 0C 00 00     enter 0xc, 0
564B  6B 46 06 3E     imul ax, word ptr [bp + 6], 0x3e
564F  C4 3E C2 D7     les di, ptr [0xd7c2]
5653  03 F8           add di, ax
5655  81 C7 C2 FF     add di, 0xffc2
5659  89 7E FA        mov word ptr [bp - 6], di
565C  8C 46 FC        mov word ptr [bp - 4], es
565F  26 8A 45 32     mov al, byte ptr es:[di + 0x32]
5663  30 E4           xor ah, ah
5665  89 46 F8        mov word ptr [bp - 8], ax
5668  B8 01 00        mov ax, 1
566B  3B 46 F8        cmp ax, word ptr [bp - 8]
566E  76 03           jbe 0x5673
5670  E9 3F 02        jmp 0x58b2
loc_5673:
5673  89 46 FE        mov word ptr [bp - 2], ax
5676  EB 03           jmp 0x567b
loc_5678:
5678  FF 46 FE        inc word ptr [bp - 2]
loc_567B:
567B  8B 46 FE        mov ax, word ptr [bp - 2]
567E  D1 E0           shl ax, 1
5680  C4 7E FA        les di, ptr [bp - 6]
5683  03 F8           add di, ax
5685  26 8B 45 FE     mov ax, word ptr es:[di - 2]
5689  C1 E0 03        shl ax, 3
568C  C4 3E BA D7     les di, ptr [0xd7ba]
5690  03 F8           add di, ax
5692  89 7E F4        mov word ptr [bp - 0xc], di
5695  8C 46 F6        mov word ptr [bp - 0xa], es
5698  8B 46 FE        mov ax, word ptr [bp - 2]
569B  D1 E0           shl ax, 1
569D  C4 7E FA        les di, ptr [bp - 6]
56A0  03 F8           add di, ax
56A2  26 8B 45 FE     mov ax, word ptr es:[di - 2]
56A6  C4 3E 84 DE     les di, ptr [0xde84]
56AA  26 89 05        mov word ptr es:[di], ax
56AD  8A 46 06        mov al, byte ptr [bp + 6]
56B0  C4 7E F4        les di, ptr [bp - 0xc]
56B3  26 88 05        mov byte ptr es:[di], al
56B6  83 7E FE 0E     cmp word ptr [bp - 2], 0xe
56BA  73 22           jae 0x56de
56BC  8B 56 FE        mov dx, word ptr [bp - 2]
56BF  26 8A 05        mov al, byte ptr es:[di]
56C2  30 E4           xor ah, ah
56C4  8B F8           mov di, ax
56C6  8A 85 85 D8     mov al, byte ptr [di - 0x277b]
56CA  30 E4           xor ah, ah
56CC  6B F8 0E        imul di, ax, 0xe
56CF  03 FA           add di, dx
56D1  8A 85 04 94     mov al, byte ptr [di - 0x6bfc]
56D5  C4 7E F4        les di, ptr [bp - 0xc]
56D8  26 88 45 07     mov byte ptr es:[di + 7], al
56DC  EB 2B           jmp 0x5709
loc_56DE:
56DE  8B 7E FE        mov di, word ptr [bp - 2]
56E1  8A 85 84 0D     mov al, byte ptr [di + 0xd84]
56E5  30 E4           xor ah, ah
56E7  8B D0           mov dx, ax
56E9  C4 7E F4        les di, ptr [bp - 0xc]
56EC  26 8A 05        mov al, byte ptr es:[di]
56EF  30 E4           xor ah, ah
56F1  8B F8           mov di, ax
56F3  8A 85 85 D8     mov al, byte ptr [di - 0x277b]
56F7  30 E4           xor ah, ah
56F9  6B F8 0E        imul di, ax, 0xe
56FC  03 FA           add di, dx
56FE  8A 85 04 94     mov al, byte ptr [di - 0x6bfc]
5702  C4 7E F4        les di, ptr [bp - 0xc]
5705  26 88 45 07     mov byte ptr es:[di + 7], al
loc_5709:
5709  C4 7E F4        les di, ptr [bp - 0xc]
570C  26 8A 45 07     mov al, byte ptr es:[di + 7]
5710  26 88 45 06     mov byte ptr es:[di + 6], al
5714  6A 10           push 0x10
5716  9A 6D 07 1A 23  call far 231A:076D
571B  C4 7E F4        les di, ptr [bp - 0xc]
571E  26 88 45 05     mov byte ptr es:[di + 5], al
5722  26 80 7D 01 00  cmp byte ptr es:[di + 1], 0
5727  75 33           jne 0x575c
5729  6A 07           push 7
572B  9A 6D 07 1A 23  call far 231A:076D
5730  50              push ax
5731  6A 07           push 7
5733  9A 6D 07 1A 23  call far 231A:076D
5738  8B D0           mov dx, ax
573A  C4 7E F4        les di, ptr [bp - 0xc]
573D  26 80 7D 07 00  cmp byte ptr es:[di + 7], 0
5742  B0 00           mov al, 0
5744  75 01           jne 0x5747
5746  40              inc ax
loc_5747:
5747  98              cwde
5748  8B F8           mov di, ax
574A  8A 85 DE 12     mov al, byte ptr [di + 0x12de]
574E  30 E4           xor ah, ah
5750  2B C2           sub ax, dx
5752  5A              pop dx
5753  03 C2           add ax, dx
5755  C4 7E F4        les di, ptr [bp - 0xc]
5758  26 88 45 01     mov byte ptr es:[di + 1], al
loc_575C:
575C  8B 46 FE        mov ax, word ptr [bp - 2]
575F  D1 E0           shl ax, 1
5761  C4 7E FA        les di, ptr [bp - 6]
5764  03 F8           add di, ax
5766  26 FF 75 FE     push word ptr es:[di - 2]
576A  0E              push cs
576B  E8 4D FB        call 0x52bb
576E  80 3E A4 0D 00  cmp byte ptr [0xda4], 0
5773  74 1A           je 0x578f
5775  C4 7E FA        les di, ptr [bp - 6]
5778  26 8A 45 33     mov al, byte ptr es:[di + 0x33]
577C  30 E4           xor ah, ah
577E  8B D0           mov dx, ax
5780  B8 B0 00        mov ax, 0xb0
5783  2B C2           sub ax, dx
5785  05 50 00        add ax, 0x50
5788  C4 7E F4        les di, ptr [bp - 0xc]
578B  26 88 45 03     mov byte ptr es:[di + 3], al
loc_578F:
578F  8B 46 FE        mov ax, word ptr [bp - 2]
5792  D1 E0           shl ax, 1
5794  C4 7E FA        les di, ptr [bp - 6]
5797  03 F8           add di, ax
5799  26 FF 75 FE     push word ptr es:[di - 2]
579D  0E              push cs
579E  E8 43 FA        call 0x51e4
57A1  C4 7E F4        les di, ptr [bp - 0xc]
57A4  26 8A 55 04     mov dl, byte ptr es:[di + 4]
57A8  8B 46 FE        mov ax, word ptr [bp - 2]
57AB  D1 E0           shl ax, 1
57AD  C4 7E FA        les di, ptr [bp - 6]
57B0  03 F8           add di, ax
57B2  26 6B 45 FE 0F  imul ax, word ptr es:[di - 2], 0xf
57B7  C4 3E BE D7     les di, ptr [0xd7be]
57BB  03 F8           add di, ax
57BD  26 88 55 09     mov byte ptr es:[di + 9], dl
57C1  6A 20           push 0x20
57C3  9A 6D 07 1A 23  call far 231A:076D
57C8  8A D0           mov dl, al
57CA  8B 46 FE        mov ax, word ptr [bp - 2]
57CD  D1 E0           shl ax, 1
57CF  C4 7E FA        les di, ptr [bp - 6]
57D2  03 F8           add di, ax
57D4  26 6B 45 FE 0F  imul ax, word ptr es:[di - 2], 0xf
57D9  C4 3E BE D7     les di, ptr [0xd7be]
57DD  03 F8           add di, ax
57DF  26 88 55 06     mov byte ptr es:[di + 6], dl
57E3  C4 7E FA        les di, ptr [bp - 6]
57E6  26 8A 45 32     mov al, byte ptr es:[di + 0x32]
57EA  30 E4           xor ah, ah
57EC  50              push ax
57ED  9A 1C 0D AC 24  call far 24AC:0D1C
57F2  08 C0           or al, al
57F4  74 1C           je 0x5812
57F6  8B 46 FE        mov ax, word ptr [bp - 2]
57F9  D1 E0           shl ax, 1
57FB  C4 7E FA        les di, ptr [bp - 6]
57FE  03 F8           add di, ax
5800  26 6B 45 FE 0F  imul ax, word ptr es:[di - 2], 0xf
5805  C4 3E BE D7     les di, ptr [0xd7be]
5809  03 F8           add di, ax
580B  26 C6 45 0D 02  mov byte ptr es:[di + 0xd], 2
5810  EB 12           jmp 0x5824
loc_5812:
5812  8B 46 FE        mov ax, word ptr [bp - 2]
5815  D1 E0           shl ax, 1
5817  C4 7E FA        les di, ptr [bp - 6]
581A  03 F8           add di, ax
581C  26 FF 75 FE     push word ptr es:[di - 2]
5820  0E              push cs
5821  E8 74 0C        call 0x6498
loc_5824:
5824  6A 39           push 0x39
5826  9A 6D 07 1A 23  call far 231A:076D
582B  8A D0           mov dl, al
582D  8B 46 FE        mov ax, word ptr [bp - 2]
5830  D1 E0           shl ax, 1
5832  C4 7E FA        les di, ptr [bp - 6]
5835  03 F8           add di, ax
5837  26 6B 45 FE 0F  imul ax, word ptr es:[di - 2], 0xf
583C  C4 3E BE D7     les di, ptr [0xd7be]
5840  03 F8           add di, ax
5842  26 28 55 0C     sub byte ptr es:[di + 0xc], dl
5846  C4 7E F4        les di, ptr [bp - 0xc]
5849  26 80 7D 04 B4  cmp byte ptr es:[di + 4], 0xb4
584E  76 22           jbe 0x5872
5850  6A 01           push 1
5852  8B 46 FE        mov ax, word ptr [bp - 2]
5855  D1 E0           shl ax, 1
5857  C4 7E FA        les di, ptr [bp - 6]
585A  03 F8           add di, ax
585C  26 6B 45 FE 0F  imul ax, word ptr es:[di - 2], 0xf
5861  C4 3E BE D7     les di, ptr [0xd7be]
5865  03 F8           add di, ax
5867  81 C7 0B 00     add di, 0xb
586B  06              push es
586C  57              push di
586D  9A D5 00 1A 23  call far 231A:00D5
loc_5872:
5872  8B 46 FE        mov ax, word ptr [bp - 2]
5875  D1 E0           shl ax, 1
5877  C4 7E FA        les di, ptr [bp - 6]
587A  03 F8           add di, ax
587C  26 FF 75 FE     push word ptr es:[di - 2]
5880  0E              push cs
5881  E8 D7 FA        call 0x535b
5884  8B 46 FE        mov ax, word ptr [bp - 2]
5887  D1 E0           shl ax, 1
5889  C4 7E FA        les di, ptr [bp - 6]
588C  03 F8           add di, ax
588E  26 FF 75 FE     push word ptr es:[di - 2]
5892  0E              push cs
5893  E8 70 FB        call 0x5406
5896  8B 46 FE        mov ax, word ptr [bp - 2]
5899  D1 E0           shl ax, 1
589B  C4 7E FA        les di, ptr [bp - 6]
589E  03 F8           add di, ax
58A0  26 FF 75 FE     push word ptr es:[di - 2]
58A4  E8 CF FB        call 0x5476
58A7  8B 46 FE        mov ax, word ptr [bp - 2]
58AA  3B 46 F8        cmp ax, word ptr [bp - 8]
58AD  74 03           je 0x58b2
58AF  E9 C6 FD        jmp 0x5678
loc_58B2:
58B2  C9              leave
58B3  CA 02 00        retf 2

; ---- routine 1B51:58B6  (found by: call)
sub_58B6:
58B6  C8 02 00 00     enter 2, 0
58BA  C7 46 FE 01 00  mov word ptr [bp - 2], 1
58BF  EB 03           jmp 0x58c4
loc_58C1:
58C1  FF 46 FE        inc word ptr [bp - 2]
loc_58C4:
58C4  8B 46 FE        mov ax, word ptr [bp - 2]
58C7  D1 E0           shl ax, 1
58C9  C4 7E 06        les di, ptr [bp + 6]
58CC  03 F8           add di, ax
58CE  26 83 7D FE 00  cmp word ptr es:[di - 2], 0
58D3  74 23           je 0x58f8
58D5  8B 46 FE        mov ax, word ptr [bp - 2]
58D8  D1 E0           shl ax, 1
58DA  C4 7E 06        les di, ptr [bp + 6]
58DD  03 F8           add di, ax
58DF  26 6B 45 FE 0F  imul ax, word ptr es:[di - 2], 0xf
58E4  C4 3E BE D7     les di, ptr [0xd7be]
58E8  03 F8           add di, ax
58EA  26 80 7D 0D 03  cmp byte ptr es:[di + 0xd], 3
58EF  75 07           jne 0x58f8
58F1  8B 7E 04        mov di, word ptr [bp + 4]
58F4  36 FF 45 FA     inc word ptr ss:[di - 6]
loc_58F8:
58F8  83 7E FE 14     cmp word ptr [bp - 2], 0x14
58FC  75 C3           jne 0x58c1
58FE  C9              leave
58FF  C2 06 00        ret 6

; ---- routine 1B51:5902  (found by: call)
sub_5902:
5902  C8 06 00 00     enter 6, 0
5906  C4 3E D2 D7     les di, ptr [0xd7d2]
590A  89 7E FA        mov word ptr [bp - 6], di
590D  8C 46 FC        mov word ptr [bp - 4], es
5910  8B 7E 04        mov di, word ptr [bp + 4]
5913  31 C0           xor ax, ax
5915  36 89 45 FA     mov word ptr ss:[di - 6], ax
5919  C4 7E FA        les di, ptr [bp - 6]
591C  26 8A 45 04     mov al, byte ptr es:[di + 4]
5920  30 E4           xor ah, ah
5922  8B F8           mov di, ax
5924  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
5928  30 E4           xor ah, ah
592A  6B C0 3E        imul ax, ax, 0x3e
592D  C4 3E C2 D7     les di, ptr [0xd7c2]
5931  03 F8           add di, ax
5933  81 C7 C2 FF     add di, 0xffc2
5937  06              push es
5938  57              push di
5939  8B 7E 04        mov di, word ptr [bp + 4]
593C  57              push di
593D  E8 76 FF        call 0x58b6
5940  C4 7E FA        les di, ptr [bp - 6]
5943  26 8A 45 04     mov al, byte ptr es:[di + 4]
5947  30 E4           xor ah, ah
5949  6B C0 28        imul ax, ax, 0x28
594C  03 F8           add di, ax
594E  81 C7 30 00     add di, 0x30
5952  06              push es
5953  57              push di
5954  8B 7E 04        mov di, word ptr [bp + 4]
5957  57              push di
5958  E8 5B FF        call 0x58b6
595B  8B 7E 04        mov di, word ptr [bp + 4]
595E  36 83 7D FA 0B  cmp word ptr ss:[di - 6], 0xb
5963  B0 00           mov al, 0
5965  72 01           jb 0x5968
5967  40              inc ax
loc_5968:
5968  88 46 FF        mov byte ptr [bp - 1], al
596B  8A 46 FF        mov al, byte ptr [bp - 1]
596E  C9              leave
596F  C2 02 00        ret 2
; data (not reached as code), 47 bytes
5972                  pstr 'Your chairman thinks you have enough trialists'

; ---- routine 1B51:59A1  (found by: call)
sub_59A1:
59A1  C8 06 00 00     enter 6, 0
59A5  C6 46 FF FF     mov byte ptr [bp - 1], 0xff
59A9  80 7E 06 00     cmp byte ptr [bp + 6], 0
59AD  74 08           je 0x59b7
59AF  55              push bp
59B0  E8 4F FF        call 0x5902
59B3  08 C0           or al, al
59B5  75 04           jne 0x59bb
loc_59B7:
59B7  B0 00           mov al, 0
59B9  EB 02           jmp 0x59bd
loc_59BB:
59BB  B0 01           mov al, 1
loc_59BD:
59BD  50              push ax
59BE  BF 72 59        mov di, 0x5972
59C1  0E              push cs
59C2  57              push di
59C3  9A 98 00 1A 23  call far 231A:0098
59C8  08 C0           or al, al
59CA  74 03           je 0x59cf
59CC  E9 A7 00        jmp 0x5a76
loc_59CF:
59CF  BF 5E 14        mov di, 0x145e
59D2  1E              push ds
59D3  57              push di
59D4  BF 5C DD        mov di, 0xdd5c
59D7  1E              push ds
59D8  57              push di
59D9  9A 2F 05 1A 23  call far 231A:052F
loc_59DE:
59DE  BF 6A 13        mov di, 0x136a
59E1  1E              push ds
59E2  57              push di
59E3  BF 5C DD        mov di, 0xdd5c
59E6  1E              push ds
59E7  57              push di
59E8  9A 2F 05 1A 23  call far 231A:052F
59ED  31 C0           xor ax, ax
59EF  89 46 FC        mov word ptr [bp - 4], ax
59F2  EB 03           jmp 0x59f7
loc_59F4:
59F4  FF 46 FC        inc word ptr [bp - 4]
loc_59F7:
59F7  8B 7E FC        mov di, word ptr [bp - 4]
59FA  8A 85 08 87     mov al, byte ptr [di - 0x78f8]
59FE  50              push ax
59FF  6B 7E FC 13     imul di, word ptr [bp - 4], 0x13
5A03  81 C7 24 87     add di, 0x8724
5A07  1E              push ds
5A08  57              push di
5A09  8B 46 FC        mov ax, word ptr [bp - 4]
5A0C  05 05 00        add ax, 5
5A0F  50              push ax
5A10  6A 3C           push 0x3c
5A12  BF 5C DD        mov di, 0xdd5c
5A15  1E              push ds
5A16  57              push di
5A17  9A 1B 04 1A 23  call far 231A:041B
5A1C  83 7E FC 0D     cmp word ptr [bp - 4], 0xd
5A20  75 D2           jne 0x59f4
5A22  A0 E0 12        mov al, byte ptr [0x12e0]
5A25  30 E4           xor ah, ah
5A27  05 05 00        add ax, 5
5A2A  48              dec ax
5A2B  50              push ax
5A2C  6A 3B           push 0x3b
5A2E  6A 14           push 0x14
5A30  9A 03 02 1A 23  call far 231A:0203
5A35  C4 3E 5C DD     les di, ptr [0xdd5c]
5A39  06              push es
5A3A  57              push di
5A3B  C4 3E 58 DD     les di, ptr [0xdd58]
5A3F  06              push es
5A40  57              push di
5A41  68 A0 0F        push 0xfa0
5A44  9A 12 0A B9 26  call far 26B9:0A12
5A49  9A 9B 09 1A 23  call far 231A:099B
5A4E  BF E0 12        mov di, 0x12e0
5A51  1E              push ds
5A52  57              push di
5A53  6A 0E           push 0xe
5A55  9A C4 0E 1A 23  call far 231A:0EC4
5A5A  80 3E 88 DE 01  cmp byte ptr [0xde88], 1
5A5F  75 02           jne 0x5a63
5A61  EB 13           jmp 0x5a76
loc_5A63:
5A63  80 3E 88 DE 02  cmp byte ptr [0xde88], 2
5A68  74 03           je 0x5a6d
5A6A  E9 71 FF        jmp 0x59de
loc_5A6D:
5A6D  A0 E0 12        mov al, byte ptr [0x12e0]
5A70  30 E4           xor ah, ah
5A72  48              dec ax
5A73  88 46 FF        mov byte ptr [bp - 1], al
loc_5A76:
5A76  8A 46 FF        mov al, byte ptr [bp - 1]
5A79  C9              leave
5A7A  CA 02 00        retf 2

