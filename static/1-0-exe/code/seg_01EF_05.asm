; 1-0.EXE (One-Nil 96), code segment 01EF (image offsets 01EF0..06E7F), part 5 of 7
; packed 1-0.EXE sha256 89ff9c5f238f24e81a0c2440a46cdd8997280a65fc3cc3d97cb974f55280a80a (LZEXE 0.91)
; unpacked (tools/static/unlzexe.py) sha256 887ed2a92767950e5309b2052409f875668605939b69e00737aa3047022b9f51
; tool: capstone 5.0.9 (pip package; core library 5.0.1280) (CS_ARCH_X86, CS_MODE_16), recursive descent from the entry point, far calls and near calls/jumps, then routine prologues (55 89 E5 / 55 8B EC / C8 iw 00) in what remains; tools/static/listing.py
; addresses are SEGMENT:OFFSET with SEGMENT the image paragraph before relocation; image offset = SEGMENT*16+OFFSET
; ---- routine 01EF:2FF3  (found by: call)
sub_2FF3:
2FF3  C8 04 00 00     enter 4, 0
2FF7  8B 46 06        mov ax, word ptr [bp + 6]
2FFA  C1 E0 02        shl ax, 2
2FFD  C4 3E C8 DC     les di, ptr [0xdcc8]
3001  03 F8           add di, ax
3003  89 7E FC        mov word ptr [bp - 4], di
3006  8C 46 FE        mov word ptr [bp - 2], es
3009  FF 76 06        push word ptr [bp + 6]
300C  E8 D2 F8        call 0x28e1
300F  A3 64 DD        mov word ptr [0xdd64], ax
3012  FF 76 06        push word ptr [bp + 6]
3015  6A 05           push 5
3017  6A 4B           push 0x4b
3019  9A 90 1E 55 1B  call far 1B55:1E90
301E  8B 46 06        mov ax, word ptr [bp + 6]
3021  C4 3E D0 DC     les di, ptr [0xdcd0]
3025  03 F8           add di, ax
3027  26 8A 05        mov al, byte ptr es:[di]
302A  30 E4           xor ah, ah
302C  8B F8           mov di, ax
302E  C1 E7 04        shl di, 4
3031  81 C7 2C 9A     add di, 0x9a2c
3035  1E              push ds
3036  57              push di
3037  6A 07           push 7
3039  6A 4B           push 0x4b
303B  BF 5C DD        mov di, 0xdd5c
303E  1E              push ds
303F  57              push di
3040  9A 83 02 2A 23  call far 232A:0283
3045  FF 76 06        push word ptr [bp + 6]
3048  6A 09           push 9
304A  6A 4B           push 0x4b
304C  9A 7E 1D 55 1B  call far 1B55:1D7E
3051  C4 7E FC        les di, ptr [bp - 4]
3054  26 80 3D 00     cmp byte ptr es:[di], 0
3058  75 15           jne 0x306f
305A  BF E3 2F        mov di, 0x2fe3
305D  0E              push cs
305E  57              push di
305F  6A 0B           push 0xb
3061  6A 4B           push 0x4b
3063  BF 5C DD        mov di, 0xdd5c
3066  1E              push ds
3067  57              push di
3068  9A 83 02 2A 23  call far 232A:0283
306D  EB 12           jmp 0x3081
loc_306F:
306F  C4 7E FC        les di, ptr [bp - 4]
3072  26 8A 05        mov al, byte ptr es:[di]
3075  30 E4           xor ah, ah
3077  50              push ax
3078  6A 0B           push 0xb
307A  6A 4B           push 0x4b
307C  9A 3B 0F 55 1B  call far 1B55:0F3B
loc_3081:
3081  C4 7E FC        les di, ptr [bp - 4]
3084  26 80 7D 01 00  cmp byte ptr es:[di + 1], 0
3089  75 15           jne 0x30a0
308B  BF EE 2F        mov di, 0x2fee
308E  0E              push cs
308F  57              push di
3090  6A 0D           push 0xd
3092  6A 4B           push 0x4b
3094  BF 5C DD        mov di, 0xdd5c
3097  1E              push ds
3098  57              push di
3099  9A 83 02 2A 23  call far 232A:0283
309E  EB 13           jmp 0x30b3
loc_30A0:
30A0  C4 7E FC        les di, ptr [bp - 4]
30A3  26 8A 45 01     mov al, byte ptr es:[di + 1]
30A7  30 E4           xor ah, ah
30A9  50              push ax
30AA  6A 0D           push 0xd
30AC  6A 4B           push 0x4b
30AE  9A 3B 0F 55 1B  call far 1B55:0F3B
loc_30B3:
30B3  C7 06 64 DD 70 00 mov word ptr [0xdd64], 0x70
30B9  FF 76 06        push word ptr [bp + 6]
30BC  9A DF 01 E8 06  call far 06E8:01DF
30C1  52              push dx
30C2  50              push ax
30C3  6A 0F           push 0xf
30C5  6A 4C           push 0x4c
30C7  9A 1E 10 55 1B  call far 1B55:101E
30CC  FF 76 06        push word ptr [bp + 6]
30CF  E8 C6 FC        call 0x2d98
30D2  52              push dx
30D3  50              push ax
30D4  6A 11           push 0x11
30D6  6A 4C           push 0x4c
30D8  9A 1E 10 55 1B  call far 1B55:101E
30DD  C9              leave
30DE  C2 04 00        ret 4
; data (not reached as code), 60 bytes
30E1                  pstr ' is not interested in joining you'
3103                  pstr ' agrees to join you. Okay'

; ---- routine 01EF:311D  (found by: call)
sub_311D:
311D  C8 06 02 00     enter 0x206, 0
3121  C4 3E D2 D7     les di, ptr [0xd7d2]
3125  89 7E FA        mov word ptr [bp - 6], di
3128  8C 46 FC        mov word ptr [bp - 4], es
312B  26 8A 45 04     mov al, byte ptr es:[di + 4]
312F  30 E4           xor ah, ah
3131  8B F8           mov di, ax
3133  8A 95 B9 DC     mov dl, byte ptr [di - 0x2347]
3137  8B 46 06        mov ax, word ptr [bp + 6]
313A  C1 E0 02        shl ax, 2
313D  C4 3E C8 DC     les di, ptr [0xdcc8]
3141  03 F8           add di, ax
3143  26 8A 45 01     mov al, byte ptr es:[di + 1]
3147  3A C2           cmp al, dl
3149  74 4A           je 0x3195
314B  8B 46 06        mov ax, word ptr [bp + 6]
314E  C1 E0 02        shl ax, 2
3151  C4 3E C8 DC     les di, ptr [0xdcc8]
3155  03 F8           add di, ax
3157  26 80 3D 00     cmp byte ptr es:[di], 0
315B  74 34           je 0x3191
315D  C4 7E FA        les di, ptr [bp - 6]
3160  26 8A 45 04     mov al, byte ptr es:[di + 4]
3164  30 E4           xor ah, ah
3166  8B F8           mov di, ax
3168  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
316C  30 E4           xor ah, ah
316E  50              push ax
316F  9A 5B 26 55 1B  call far 1B55:265B
3174  50              push ax
3175  8B 46 06        mov ax, word ptr [bp + 6]
3178  C1 E0 02        shl ax, 2
317B  C4 3E C8 DC     les di, ptr [0xdcc8]
317F  03 F8           add di, ax
3181  26 8A 05        mov al, byte ptr es:[di]
3184  30 E4           xor ah, ah
3186  50              push ax
3187  9A 5B 26 55 1B  call far 1B55:265B
318C  5A              pop dx
318D  3B C2           cmp ax, dx
318F  7F 04           jg 0x3195
loc_3191:
3191  B0 00           mov al, 0
3193  EB 02           jmp 0x3197
loc_3195:
3195  B0 01           mov al, 1
loc_3197:
3197  50              push ax
3198  8D BE FA FE     lea di, [bp - 0x106]
319C  16              push ss
319D  57              push di
319E  6B 46 06 0B     imul ax, word ptr [bp + 6], 0xb
31A2  C4 3E CC DC     les di, ptr [0xdccc]
31A6  03 F8           add di, ax
31A8  06              push es
31A9  57              push di
31AA  9A 53 0B C9 26  call far 26C9:0B53
31AF  BF E1 30        mov di, 0x30e1
31B2  0E              push cs
31B3  57              push di
31B4  9A D2 0B C9 26  call far 26C9:0BD2
31B9  9A 98 00 2A 23  call far 232A:0098
31BE  08 C0           or al, al
31C0  75 2A           jne 0x31ec
31C2  8D BE FA FD     lea di, [bp - 0x206]
31C6  16              push ss
31C7  57              push di
31C8  6B 46 06 0B     imul ax, word ptr [bp + 6], 0xb
31CC  C4 3E CC DC     les di, ptr [0xdccc]
31D0  03 F8           add di, ax
31D2  06              push es
31D3  57              push di
31D4  9A 53 0B C9 26  call far 26C9:0B53
31D9  BF 03 31        mov di, 0x3103
31DC  0E              push cs
31DD  57              push di
31DE  9A D2 0B C9 26  call far 26C9:0BD2
31E3  9A E5 06 2A 23  call far 232A:06E5
31E8  08 C0           or al, al
31EA  75 03           jne 0x31ef
loc_31EC:
31EC  E9 E5 00        jmp 0x32d4
loc_31EF:
31EF  FF 76 06        push word ptr [bp + 6]
31F2  E8 A3 FB        call 0x2d98
31F5  8B C8           mov cx, ax
31F7  8B DA           mov bx, dx
31F9  C4 7E FA        les di, ptr [bp - 6]
31FC  26 8A 45 04     mov al, byte ptr es:[di + 4]
3200  30 E4           xor ah, ah
3202  6B C0 5E        imul ax, ax, 0x5e
3205  C4 3E C4 DC     les di, ptr [0xdcc4]
3209  03 F8           add di, ax
320B  26 01 4D DC     add word ptr es:[di - 0x24], cx
320F  26 11 5D DE     adc word ptr es:[di - 0x22], bx
3213  8B 46 06        mov ax, word ptr [bp + 6]
3216  C1 E0 02        shl ax, 2
3219  C4 3E C8 DC     les di, ptr [0xdcc8]
321D  03 F8           add di, ax
321F  26 8A 05        mov al, byte ptr es:[di]
3222  30 E4           xor ah, ah
3224  89 46 FE        mov word ptr [bp - 2], ax
3227  C4 7E FA        les di, ptr [bp - 6]
322A  26 8A 45 04     mov al, byte ptr es:[di + 4]
322E  30 E4           xor ah, ah
3230  8B F8           mov di, ax
3232  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
3236  30 E4           xor ah, ah
3238  6B C0 3E        imul ax, ax, 0x3e
323B  C4 3E C2 D7     les di, ptr [0xd7c2]
323F  03 F8           add di, ax
3241  81 C7 C2 FF     add di, 0xffc2
3245  89 7E F6        mov word ptr [bp - 0xa], di
3248  8C 46 F8        mov word ptr [bp - 8], es
324B  8B 46 06        mov ax, word ptr [bp + 6]
324E  C1 E0 02        shl ax, 2
3251  C4 3E C8 DC     les di, ptr [0xdcc8]
3255  03 F8           add di, ax
3257  26 8A 45 03     mov al, byte ptr es:[di + 3]
325B  98              cwde
325C  D1 E0           shl ax, 1
325E  C4 7E F6        les di, ptr [bp - 0xa]
3261  03 F8           add di, ax
3263  26 83 7D 28 00  cmp word ptr es:[di + 0x28], 0
3268  74 31           je 0x329b
326A  8B 46 06        mov ax, word ptr [bp + 6]
326D  C1 E0 02        shl ax, 2
3270  C4 3E C8 DC     les di, ptr [0xdcc8]
3274  03 F8           add di, ax
3276  26 8A 45 03     mov al, byte ptr es:[di + 3]
327A  98              cwde
327B  D1 E0           shl ax, 1
327D  C4 7E F6        les di, ptr [bp - 0xa]
3280  03 F8           add di, ax
3282  26 FF 75 28     push word ptr es:[di + 0x28]
3286  C4 7E FA        les di, ptr [bp - 6]
3289  26 8A 45 04     mov al, byte ptr es:[di + 4]
328D  30 E4           xor ah, ah
328F  8B F8           mov di, ax
3291  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
3295  30 E4           xor ah, ah
3297  50              push ax
3298  E8 3F FB        call 0x2dda
loc_329B:
329B  FF 76 06        push word ptr [bp + 6]
329E  C4 7E FA        les di, ptr [bp - 6]
32A1  26 8A 45 04     mov al, byte ptr es:[di + 4]
32A5  30 E4           xor ah, ah
32A7  8B F8           mov di, ax
32A9  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
32AD  30 E4           xor ah, ah
32AF  50              push ax
32B0  E8 69 FB        call 0x2e1c
32B3  83 7E FE 00     cmp word ptr [bp - 2], 0
32B7  74 1B           je 0x32d4
32B9  8B 46 06        mov ax, word ptr [bp + 6]
32BC  C1 E0 02        shl ax, 2
32BF  C4 3E C8 DC     les di, ptr [0xdcc8]
32C3  03 F8           add di, ax
32C5  26 8A 45 03     mov al, byte ptr es:[di + 3]
32C9  50              push ax
32CA  E8 9B FB        call 0x2e68
32CD  50              push ax
32CE  FF 76 FE        push word ptr [bp - 2]
32D1  E8 48 FB        call 0x2e1c
loc_32D4:
32D4  C9              leave
32D5  C2 04 00        ret 4
; data (not reached as code), 6 bytes
32D8                  pstr 'Sack '

; ---- routine 01EF:32DE  (found by: call)
sub_32DE:
32DE  C8 04 01 00     enter 0x104, 0
32E2  C4 3E D2 D7     les di, ptr [0xd7d2]
32E6  89 7E FC        mov word ptr [bp - 4], di
32E9  8C 46 FE        mov word ptr [bp - 2], es
32EC  8D BE FC FE     lea di, [bp - 0x104]
32F0  16              push ss
32F1  57              push di
32F2  BF D8 32        mov di, 0x32d8
32F5  0E              push cs
32F6  57              push di
32F7  9A 53 0B C9 26  call far 26C9:0B53
32FC  6B 46 06 0B     imul ax, word ptr [bp + 6], 0xb
3300  C4 3E CC DC     les di, ptr [0xdccc]
3304  03 F8           add di, ax
3306  06              push es
3307  57              push di
3308  9A D2 0B C9 26  call far 26C9:0BD2
330D  9A E5 06 2A 23  call far 232A:06E5
3312  08 C0           or al, al
3314  74 18           je 0x332e
3316  FF 76 06        push word ptr [bp + 6]
3319  C4 7E FC        les di, ptr [bp - 4]
331C  26 8A 45 04     mov al, byte ptr es:[di + 4]
3320  30 E4           xor ah, ah
3322  8B F8           mov di, ax
3324  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
3328  30 E4           xor ah, ah
332A  50              push ax
332B  E8 AC FA        call 0x2dda
loc_332E:
332E  C9              leave
332F  C2 04 00        ret 4

; ---- routine 01EF:3332  (found by: call)
sub_3332:
3332  C8 02 00 00     enter 2, 0
3336  80 3E 7F 02 03  cmp byte ptr [0x27f], 3
333B  7D 0A           jge 0x3347
333D  A0 7F 02        mov al, byte ptr [0x27f]
3340  FE C0           inc al
3342  88 46 FF        mov byte ptr [bp - 1], al
3345  EB 04           jmp 0x334b
loc_3347:
3347  C6 46 FF 01     mov byte ptr [bp - 1], 1
loc_334B:
334B  8A 46 FF        mov al, byte ptr [bp - 1]
334E  C9              leave
334F  C2 02 00        ret 2

; ---- routine 01EF:3352  (found by: call)
sub_3352:
3352  C8 02 00 00     enter 2, 0
3356  80 3E 7F 02 01  cmp byte ptr [0x27f], 1
335B  7E 0A           jle 0x3367
335D  A0 7F 02        mov al, byte ptr [0x27f]
3360  FE C8           dec al
3362  88 46 FF        mov byte ptr [bp - 1], al
3365  EB 04           jmp 0x336b
loc_3367:
3367  C6 46 FF 03     mov byte ptr [bp - 1], 3
loc_336B:
336B  8A 46 FF        mov al, byte ptr [bp - 1]
336E  C9              leave
336F  C2 02 00        ret 2
; data (not reached as code), 5 bytes
3372                  pstr 'SACK'

; ---- routine 01EF:3377  (found by: call)
sub_3377:
3377  C8 06 01 00     enter 0x106, 0
337B  BF C2 6C        mov di, 0x6cc2
337E  1E              push ds
337F  57              push di
3380  BF 5C DD        mov di, 0xdd5c
3383  1E              push ds
3384  57              push di
3385  9A 2F 05 2A 23  call far 232A:052F
338A  C7 46 FC 04 00  mov word ptr [bp - 4], 4
338F  A1 7C 02        mov ax, word ptr [0x27c]
3392  05 13 00        add ax, 0x13
3395  89 46 FA        mov word ptr [bp - 6], ax
3398  A1 7C 02        mov ax, word ptr [0x27c]
339B  3B 46 FA        cmp ax, word ptr [bp - 6]
339E  77 70           ja 0x3410
33A0  89 46 FE        mov word ptr [bp - 2], ax
33A3  EB 03           jmp 0x33a8
loc_33A5:
33A5  FF 46 FE        inc word ptr [bp - 2]
loc_33A8:
33A8  8B 7E FE        mov di, word ptr [bp - 2]
33AB  D1 E7           shl di, 1
33AD  FF B5 DA D1     push word ptr [di - 0x2e26]
33B1  E8 2D F5        call 0x28e1
33B4  50              push ax
33B5  8D BE FA FE     lea di, [bp - 0x106]
33B9  16              push ss
33BA  57              push di
33BB  8B 7E FE        mov di, word ptr [bp - 2]
33BE  D1 E7           shl di, 1
33C0  8B 85 DA D1     mov ax, word ptr [di - 0x2e26]
33C4  C4 3E D4 DC     les di, ptr [0xdcd4]
33C8  03 F8           add di, ax
33CA  26 8A 05        mov al, byte ptr es:[di]
33CD  50              push ax
33CE  9A 6F 0C C9 26  call far 26C9:0C6F
33D3  8A 46 FC        mov al, byte ptr [bp - 4]
33D6  50              push ax
33D7  6A 0B           push 0xb
33D9  BF 5C DD        mov di, 0xdd5c
33DC  1E              push ds
33DD  57              push di
33DE  9A 1B 04 2A 23  call far 232A:041B
33E3  8B 7E FE        mov di, word ptr [bp - 2]
33E6  D1 E7           shl di, 1
33E8  6B 85 DA D1 0B  imul ax, word ptr [di - 0x2e26], 0xb
33ED  C4 3E CC DC     les di, ptr [0xdccc]
33F1  03 F8           add di, ax
33F3  06              push es
33F4  57              push di
33F5  8A 46 FC        mov al, byte ptr [bp - 4]
33F8  50              push ax
33F9  6A 0D           push 0xd
33FB  BF 5C DD        mov di, 0xdd5c
33FE  1E              push ds
33FF  57              push di
3400  9A 9D 03 2A 23  call far 232A:039D
3405  FF 46 FC        inc word ptr [bp - 4]
3408  8B 46 FE        mov ax, word ptr [bp - 2]
340B  3B 46 FA        cmp ax, word ptr [bp - 6]
340E  75 95           jne 0x33a5
loc_3410:
3410  A0 7E 02        mov al, byte ptr [0x27e]
3413  30 E4           xor ah, ah
3415  05 03 00        add ax, 3
3418  50              push ax
3419  6A 0A           push 0xa
341B  6A 0E           push 0xe
341D  9A 03 02 2A 23  call far 232A:0203
3422  A0 7E 02        mov al, byte ptr [0x27e]
3425  30 E4           xor ah, ah
3427  03 06 7C 02     add ax, word ptr [0x27c]
342B  48              dec ax
342C  8B 7E 04        mov di, word ptr [bp + 4]
342F  36 89 45 FE     mov word ptr ss:[di - 2], ax
3433  C4 3E D2 D7     les di, ptr [0xd7d2]
3437  26 8A 45 04     mov al, byte ptr es:[di + 4]
343B  30 E4           xor ah, ah
343D  8B F8           mov di, ax
343F  8A 95 B9 DC     mov dl, byte ptr [di - 0x2347]
3443  8B 7E 04        mov di, word ptr [bp + 4]
3446  36 8B 7D FE     mov di, word ptr ss:[di - 2]
344A  D1 E7           shl di, 1
344C  8B 85 DA D1     mov ax, word ptr [di - 0x2e26]
3450  C1 E0 02        shl ax, 2
3453  C4 3E C8 DC     les di, ptr [0xdcc8]
3457  03 F8           add di, ax
3459  26 8A 05        mov al, byte ptr es:[di]
345C  3A C2           cmp al, dl
345E  75 15           jne 0x3475
3460  6A 0B           push 0xb
3462  BF 72 33        mov di, 0x3372
3465  0E              push cs
3466  57              push di
3467  6A 17           push 0x17
3469  6A 2C           push 0x2c
346B  BF 5C DD        mov di, 0xdd5c
346E  1E              push ds
346F  57              push di
3470  9A 1B 04 2A 23  call far 232A:041B
loc_3475:
3475  8B 7E 04        mov di, word ptr [bp + 4]
3478  36 8B 7D FE     mov di, word ptr ss:[di - 2]
347C  D1 E7           shl di, 1
347E  FF B5 DA D1     push word ptr [di - 0x2e26]
3482  E8 5C F4        call 0x28e1
3485  50              push ax
3486  8B 7E 04        mov di, word ptr [bp + 4]
3489  36 8B 7D FE     mov di, word ptr ss:[di - 2]
348D  D1 E7           shl di, 1
348F  6B 85 DA D1 0B  imul ax, word ptr [di - 0x2e26], 0xb
3494  C4 3E CC DC     les di, ptr [0xdccc]
3498  03 F8           add di, ax
349A  06              push es
349B  57              push di
349C  6A 17           push 0x17
349E  6A 31           push 0x31
34A0  BF 5C DD        mov di, 0xdd5c
34A3  1E              push ds
34A4  57              push di
34A5  9A 1B 04 2A 23  call far 232A:041B
34AA  6A 07           push 7
34AC  8B 7E 04        mov di, word ptr [bp + 4]
34AF  57              push di
34B0  E8 7F FE        call 0x3332
34B3  98              cwde
34B4  6B F8 0D        imul di, ax, 0xd
34B7  81 C7 79 02     add di, 0x279
34BB  1E              push ds
34BC  57              push di
34BD  6A 15           push 0x15
34BF  6A 2B           push 0x2b
34C1  BF 5C DD        mov di, 0xdd5c
34C4  1E              push ds
34C5  57              push di
34C6  9A 1B 04 2A 23  call far 232A:041B
34CB  8B 7E 04        mov di, word ptr [bp + 4]
34CE  57              push di
34CF  E8 80 FE        call 0x3352
34D2  98              cwde
34D3  6B F8 0D        imul di, ax, 0xd
34D6  81 C7 79 02     add di, 0x279
34DA  1E              push ds
34DB  57              push di
34DC  6A 16           push 0x16
34DE  6A 2B           push 0x2b
34E0  BF 5C DD        mov di, 0xdd5c
34E3  1E              push ds
34E4  57              push di
34E5  9A 9D 03 2A 23  call far 232A:039D
34EA  6A 70           push 0x70
34EC  A0 7F 02        mov al, byte ptr [0x27f]
34EF  98              cwde
34F0  6B F8 0D        imul di, ax, 0xd
34F3  81 C7 79 02     add di, 0x279
34F7  1E              push ds
34F8  57              push di
34F9  6A 02           push 2
34FB  6A 3D           push 0x3d
34FD  BF 5C DD        mov di, 0xdd5c
3500  1E              push ds
3501  57              push di
3502  9A 1B 04 2A 23  call far 232A:041B
3507  A0 7E 02        mov al, byte ptr [0x27e]
350A  30 E4           xor ah, ah
350C  03 06 7C 02     add ax, word ptr [0x27c]
3510  48              dec ax
3511  50              push ax
3512  6A 01           push 1
3514  68 C8 00        push 0xc8
3517  6A 18           push 0x18
3519  6A 0B           push 0xb
351B  9A 67 01 2A 23  call far 232A:0167
3520  C9              leave
3521  C2 02 00        ret 2

; ---- routine 01EF:3524  (found by: far)
sub_3524:
3524  C8 04 00 00     enter 4, 0
3528  55              push bp
3529  E8 CE F9        call 0x2efa
loc_352C:
352C  55              push bp
352D  E8 47 FE        call 0x3377
3530  8B 7E FE        mov di, word ptr [bp - 2]
3533  D1 E7           shl di, 1
3535  FF B5 DA D1     push word ptr [di - 0x2e26]
3539  55              push bp
353A  E8 B6 FA        call 0x2ff3
353D  BF 22 63        mov di, 0x6322
3540  1E              push ds
3541  57              push di
3542  BF 5C DD        mov di, 0xdd5c
3545  1E              push ds
3546  57              push di
3547  9A 2F 05 2A 23  call far 232A:052F
354C  C4 3E 5C DD     les di, ptr [0xdd5c]
3550  06              push es
3551  57              push di
3552  C4 3E 58 DD     les di, ptr [0xdd58]
3556  06              push es
3557  57              push di
3558  68 A0 0F        push 0xfa0
355B  9A 12 0A C9 26  call far 26C9:0A12
3560  9A 9B 09 2A 23  call far 232A:099B
3565  80 3E 88 DE 01  cmp byte ptr [0xde88], 1
356A  B0 00           mov al, 0
356C  75 01           jne 0x356f
356E  40              inc ax
loc_356F:
356F  88 46 FD        mov byte ptr [bp - 3], al
3572  A0 88 DE        mov al, byte ptr [0xde88]
3575  3C 08           cmp al, 8
3577  74 04           je 0x357d
3579  3C 0D           cmp al, 0xd
357B  75 18           jne 0x3595
loc_357D:
357D  C6 06 88 DE 06  mov byte ptr [0xde88], 6
3582  BF 7F 02        mov di, 0x27f
3585  1E              push ds
3586  57              push di
3587  6A 03           push 3
3589  9A C4 0E 2A 23  call far 232A:0EC4
358E  55              push bp
358F  E8 68 F9        call 0x2efa
3592  E9 82 00        jmp 0x3617
loc_3595:
3595  3C 07           cmp al, 7
3597  74 08           je 0x35a1
3599  3C 0E           cmp al, 0xe
359B  74 04           je 0x35a1
359D  3C 0F           cmp al, 0xf
359F  75 17           jne 0x35b8
loc_35A1:
35A1  C6 06 88 DE 05  mov byte ptr [0xde88], 5
35A6  BF 7F 02        mov di, 0x27f
35A9  1E              push ds
35AA  57              push di
35AB  6A 03           push 3
35AD  9A C4 0E 2A 23  call far 232A:0EC4
35B2  55              push bp
35B3  E8 44 F9        call 0x2efa
35B6  EB 5F           jmp 0x3617
loc_35B8:
35B8  3C 02           cmp al, 2
35BA  75 47           jne 0x3603
35BC  C4 3E D2 D7     les di, ptr [0xd7d2]
35C0  26 8A 45 04     mov al, byte ptr es:[di + 4]
35C4  30 E4           xor ah, ah
35C6  8B F8           mov di, ax
35C8  8A 95 B9 DC     mov dl, byte ptr [di - 0x2347]
35CC  8B 7E FE        mov di, word ptr [bp - 2]
35CF  D1 E7           shl di, 1
35D1  8B 85 DA D1     mov ax, word ptr [di - 0x2e26]
35D5  C1 E0 02        shl ax, 2
35D8  C4 3E C8 DC     les di, ptr [0xdcc8]
35DC  03 F8           add di, ax
35DE  26 8A 05        mov al, byte ptr es:[di]
35E1  3A C2           cmp al, dl
35E3  75 0F           jne 0x35f4
35E5  8B 7E FE        mov di, word ptr [bp - 2]
35E8  D1 E7           shl di, 1
35EA  FF B5 DA D1     push word ptr [di - 0x2e26]
35EE  55              push bp
35EF  E8 EC FC        call 0x32de
35F2  EB 0D           jmp 0x3601
loc_35F4:
35F4  8B 7E FE        mov di, word ptr [bp - 2]
35F7  D1 E7           shl di, 1
35F9  FF B5 DA D1     push word ptr [di - 0x2e26]
35FD  55              push bp
35FE  E8 1C FB        call 0x311d
loc_3601:
3601  EB 14           jmp 0x3617
loc_3603:
3603  BF 7E 02        mov di, 0x27e
3606  1E              push ds
3607  57              push di
3608  BF 7C 02        mov di, 0x27c
360B  1E              push ds
360C  57              push di
360D  6A 14           push 0x14
360F  68 C8 00        push 0xc8
3612  9A D7 0F 2A 23  call far 232A:0FD7
loc_3617:
3617  80 7E FD 00     cmp byte ptr [bp - 3], 0
361B  75 03           jne 0x3620
361D  E9 0C FF        jmp 0x352c
loc_3620:
3620  C9              leave
3621  CB              retf

; ---- routine 01EF:3622  (found by: call)
sub_3622:
3622  C8 06 00 00     enter 6, 0
3626  31 C0           xor ax, ax
3628  89 46 FE        mov word ptr [bp - 2], ax
362B  6A 50           push 0x50
362D  9A 6D 07 2A 23  call far 232A:076D
3632  89 46 FC        mov word ptr [bp - 4], ax
3635  8B 46 FC        mov ax, word ptr [bp - 4]
3638  89 46 FA        mov word ptr [bp - 6], ax
loc_363B:
363B  8B 46 04        mov ax, word ptr [bp + 4]
363E  D1 E0           shl ax, 1
3640  C4 3E D2 D7     les di, ptr [0xd7d2]
3644  03 F8           add di, ax
3646  26 FF 75 03     push word ptr es:[di + 3]
364A  8B 7E FC        mov di, word ptr [bp - 4]
364D  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
3651  30 E4           xor ah, ah
3653  50              push ax
3654  9A 6B 6C 55 1B  call far 1B55:6C6B
3659  08 C0           or al, al
365B  74 0E           je 0x366b
365D  8B 7E FC        mov di, word ptr [bp - 4]
3660  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
3664  30 E4           xor ah, ah
3666  89 46 FE        mov word ptr [bp - 2], ax
3669  EB 18           jmp 0x3683
loc_366B:
366B  83 7E FC 50     cmp word ptr [bp - 4], 0x50
366F  73 05           jae 0x3676
3671  FF 46 FC        inc word ptr [bp - 4]
3674  EB 05           jmp 0x367b
loc_3676:
3676  C7 46 FC 01 00  mov word ptr [bp - 4], 1
loc_367B:
367B  8B 46 FA        mov ax, word ptr [bp - 6]
367E  3B 46 FC        cmp ax, word ptr [bp - 4]
3681  75 B8           jne 0x363b
loc_3683:
3683  8B 46 FE        mov ax, word ptr [bp - 2]
3686  C9              leave
3687  C2 02 00        ret 2

; ---- routine 01EF:368A  (found by: call)
sub_368A:
368A  55              push bp
368B  89 E5           mov bp, sp
368D  FF 76 06        push word ptr [bp + 6]
3690  9A EB 68 55 1B  call far 1B55:68EB
3695  8B 46 06        mov ax, word ptr [bp + 6]
3698  D1 E0           shl ax, 1
369A  C4 3E D2 D7     les di, ptr [0xd7d2]
369E  03 F8           add di, ax
36A0  26 FF 75 03     push word ptr es:[di + 3]
36A4  8B 7E 06        mov di, word ptr [bp + 6]
36A7  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
36AB  30 E4           xor ah, ah
36AD  50              push ax
36AE  E8 29 F7        call 0x2dda
36B1  6A 00           push 0
36B3  E8 B2 F7        call 0x2e68
36B6  50              push ax
36B7  8B 7E 06        mov di, word ptr [bp + 6]
36BA  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
36BE  30 E4           xor ah, ah
36C0  50              push ax
36C1  E8 58 F7        call 0x2e1c
36C4  C9              leave
36C5  CA 02 00        retf 2
; data (not reached as code), 29 bytes
36C8                  pstr ': your assistant has joined '

; ---- routine 01EF:36E5  (found by: call)
sub_36E5:
36E5  C8 02 01 00     enter 0x102, 0
36E9  8B 7E 04        mov di, word ptr [bp + 4]
36EC  36 FF 75 FC     push word ptr ss:[di - 4]
36F0  9A 7A 0E 55 1B  call far 1B55:0E7A
36F5  88 46 FF        mov byte ptr [bp - 1], al
36F8  80 7E FF 00     cmp byte ptr [bp - 1], 0
36FC  74 4B           je 0x3749
36FE  8D BE FE FE     lea di, [bp - 0x102]
3702  16              push ss
3703  57              push di
3704  8B 7E 04        mov di, word ptr [bp + 4]
3707  36 8B 45 FC     mov ax, word ptr ss:[di - 4]
370B  C1 E0 04        shl ax, 4
370E  C4 3E B2 D7     les di, ptr [0xd7b2]
3712  03 F8           add di, ax
3714  81 C7 F0 FF     add di, 0xfff0
3718  06              push es
3719  57              push di
371A  9A 53 0B C9 26  call far 26C9:0B53
371F  BF C8 36        mov di, 0x36c8
3722  0E              push cs
3723  57              push di
3724  9A D2 0B C9 26  call far 26C9:0BD2
3729  8B 7E 04        mov di, word ptr [bp + 4]
372C  36 8B 45 FE     mov ax, word ptr ss:[di - 2]
3730  C1 E0 04        shl ax, 4
3733  C4 3E B2 D7     les di, ptr [0xd7b2]
3737  03 F8           add di, ax
3739  81 C7 F0 FF     add di, 0xfff0
373D  06              push es
373E  57              push di
373F  9A D2 0B C9 26  call far 26C9:0BD2
3744  9A 02 07 BC 24  call far 24BC:0702
loc_3749:
3749  FF 76 08        push word ptr [bp + 8]
374C  8B 7E 04        mov di, word ptr [bp + 4]
374F  36 FF 75 FE     push word ptr ss:[di - 2]
3753  E8 84 F6        call 0x2dda
3756  FF 76 06        push word ptr [bp + 6]
3759  8B 7E 04        mov di, word ptr [bp + 4]
375C  36 FF 75 FC     push word ptr ss:[di - 4]
3760  E8 77 F6        call 0x2dda
3763  FF 76 06        push word ptr [bp + 6]
3766  8B 7E 04        mov di, word ptr [bp + 4]
3769  36 FF 75 FE     push word ptr ss:[di - 2]
376D  E8 AC F6        call 0x2e1c
3770  80 7E FF 00     cmp byte ptr [bp - 1], 0
3774  75 12           jne 0x3788
3776  8A 46 0A        mov al, byte ptr [bp + 0xa]
3779  50              push ax
377A  E8 EB F6        call 0x2e68
377D  50              push ax
377E  8B 7E 04        mov di, word ptr [bp + 4]
3781  36 FF 75 FC     push word ptr ss:[di - 4]
3785  E8 94 F6        call 0x2e1c
loc_3788:
3788  8B 7E 04        mov di, word ptr [bp + 4]
378B  36 FF 75 FE     push word ptr ss:[di - 2]
378F  E8 27 EC        call 0x23b9
3792  80 7E FF 00     cmp byte ptr [bp - 1], 0
3796  75 0A           jne 0x37a2
3798  8B 7E 04        mov di, word ptr [bp + 4]
379B  36 FF 75 FC     push word ptr ss:[di - 4]
379F  E8 17 EC        call 0x23b9
loc_37A2:
37A2  C9              leave
37A3  C2 08 00        ret 8

; ---- routine 01EF:37A6  (found by: call)
sub_37A6:
37A6  C8 0E 00 00     enter 0xe, 0
37AA  C6 46 F7 01     mov byte ptr [bp - 9], 1
37AE  EB 03           jmp 0x37b3
loc_37B0:
37B0  FE 46 F7        inc byte ptr [bp - 9]
loc_37B3:
37B3  C6 46 F6 00     mov byte ptr [bp - 0xa], 0
37B7  EB 03           jmp 0x37bc
loc_37B9:
37B9  FE 46 F6        inc byte ptr [bp - 0xa]
loc_37BC:
37BC  6A 08           push 8
37BE  9A 6D 07 2A 23  call far 232A:076D
37C3  05 08 00        add ax, 8
37C6  8B D0           mov dx, ax
37C8  8A 46 F7        mov al, byte ptr [bp - 9]
37CB  98              cwde
37CC  8B F8           mov di, ax
37CE  8A 85 AD 02     mov al, byte ptr [di + 0x2ad]
37D2  30 E4           xor ah, ah
37D4  03 C2           add ax, dx
37D6  8B F8           mov di, ax
37D8  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
37DC  30 E4           xor ah, ah
37DE  89 46 FE        mov word ptr [bp - 2], ax
37E1  6A 08           push 8
37E3  9A 6D 07 2A 23  call far 232A:076D
37E8  05 10 00        add ax, 0x10
37EB  8B D0           mov dx, ax
37ED  8A 46 F7        mov al, byte ptr [bp - 9]
37F0  98              cwde
37F1  8B F8           mov di, ax
37F3  8A 85 AD 02     mov al, byte ptr [di + 0x2ad]
37F7  30 E4           xor ah, ah
37F9  03 C2           add ax, dx
37FB  8B F8           mov di, ax
37FD  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
3801  30 E4           xor ah, ah
3803  89 46 FC        mov word ptr [bp - 4], ax
3806  6B 46 FE 3E     imul ax, word ptr [bp - 2], 0x3e
380A  C4 3E C2 D7     les di, ptr [0xd7c2]
380E  03 F8           add di, ax
3810  81 C7 C2 FF     add di, 0xffc2
3814  89 7E F2        mov word ptr [bp - 0xe], di
3817  8C 46 F4        mov word ptr [bp - 0xc], es
381A  8A 46 F6        mov al, byte ptr [bp - 0xa]
381D  98              cwde
381E  D1 E0           shl ax, 1
3820  8B D0           mov dx, ax
3822  6B 46 FC 3E     imul ax, word ptr [bp - 4], 0x3e
3826  C4 3E C2 D7     les di, ptr [0xd7c2]
382A  03 F8           add di, ax
382C  03 FA           add di, dx
382E  26 8B 45 EA     mov ax, word ptr es:[di - 0x16]
3832  C1 E0 02        shl ax, 2
3835  C4 3E C8 DC     les di, ptr [0xdcc8]
3839  03 F8           add di, ax
383B  26 8A 55 02     mov dl, byte ptr es:[di + 2]
383F  8A 46 F6        mov al, byte ptr [bp - 0xa]
3842  98              cwde
3843  D1 E0           shl ax, 1
3845  C4 7E F2        les di, ptr [bp - 0xe]
3848  03 F8           add di, ax
384A  26 8B 45 28     mov ax, word ptr es:[di + 0x28]
384E  C1 E0 02        shl ax, 2
3851  C4 3E C8 DC     les di, ptr [0xdcc8]
3855  03 F8           add di, ax
3857  26 8A 45 02     mov al, byte ptr es:[di + 2]
385B  3A C2           cmp al, dl
385D  73 4D           jae 0x38ac
385F  FF 76 FE        push word ptr [bp - 2]
3862  9A 7A 0E 55 1B  call far 1B55:0E7A
3867  08 C0           or al, al
3869  75 41           jne 0x38ac
386B  FF 76 FC        push word ptr [bp - 4]
386E  9A 7A 0E 55 1B  call far 1B55:0E7A
3873  08 C0           or al, al
3875  74 06           je 0x387d
3877  80 7E F6 01     cmp byte ptr [bp - 0xa], 1
387B  75 2F           jne 0x38ac
loc_387D:
387D  8A 46 F6        mov al, byte ptr [bp - 0xa]
3880  50              push ax
3881  8A 46 F6        mov al, byte ptr [bp - 0xa]
3884  98              cwde
3885  D1 E0           shl ax, 1
3887  C4 7E F2        les di, ptr [bp - 0xe]
388A  03 F8           add di, ax
388C  26 FF 75 28     push word ptr es:[di + 0x28]
3890  8A 46 F6        mov al, byte ptr [bp - 0xa]
3893  98              cwde
3894  D1 E0           shl ax, 1
3896  8B D0           mov dx, ax
3898  6B 46 FC 3E     imul ax, word ptr [bp - 4], 0x3e
389C  C4 3E C2 D7     les di, ptr [0xd7c2]
38A0  03 F8           add di, ax
38A2  03 FA           add di, dx
38A4  26 FF 75 EA     push word ptr es:[di - 0x16]
38A8  55              push bp
38A9  E8 39 FE        call 0x36e5
loc_38AC:
38AC  80 7E F6 01     cmp byte ptr [bp - 0xa], 1
38B0  74 03           je 0x38b5
38B2  E9 04 FF        jmp 0x37b9
loc_38B5:
38B5  80 7E F7 03     cmp byte ptr [bp - 9], 3
38B9  74 03           je 0x38be
38BB  E9 F2 FE        jmp 0x37b0
loc_38BE:
38BE  C9              leave
38BF  C3              ret

; ---- routine 01EF:38C0  (found by: call, far)
sub_38C0:
38C0  C8 06 00 00     enter 6, 0
38C4  C4 3E D2 D7     les di, ptr [0xd7d2]
38C8  89 7E FA        mov word ptr [bp - 6], di
38CB  8C 46 FC        mov word ptr [bp - 4], es
38CE  8B 7E 08        mov di, word ptr [bp + 8]
38D1  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
38D5  30 E4           xor ah, ah
38D7  89 46 FE        mov word ptr [bp - 2], ax
38DA  83 7E FE 00     cmp word ptr [bp - 2], 0
38DE  74 07           je 0x38e7
38E0  FF 76 08        push word ptr [bp + 8]
38E3  0E              push cs
38E4  E8 A3 FD        call 0x368a
loc_38E7:
38E7  6B 46 06 3E     imul ax, word ptr [bp + 6], 0x3e
38EB  C4 3E C2 D7     les di, ptr [0xd7c2]
38EF  03 F8           add di, ax
38F1  26 FF 75 EA     push word ptr es:[di - 0x16]
38F5  FF 76 06        push word ptr [bp + 6]
38F8  E8 DF F4        call 0x2dda
38FB  8B 46 08        mov ax, word ptr [bp + 8]
38FE  D1 E0           shl ax, 1
3900  C4 7E FA        les di, ptr [bp - 6]
3903  03 F8           add di, ax
3905  26 FF 75 03     push word ptr es:[di + 3]
3909  FF 76 06        push word ptr [bp + 6]
390C  E8 0D F5        call 0x2e1c
390F  8A 46 06        mov al, byte ptr [bp + 6]
3912  8B 7E 08        mov di, word ptr [bp + 8]
3915  88 85 B9 DC     mov byte ptr [di - 0x2347], al
3919  83 7E FE 00     cmp word ptr [bp - 2], 0
391D  74 06           je 0x3925
391F  FF 76 FE        push word ptr [bp - 2]
3922  E8 94 EA        call 0x23b9
loc_3925:
3925  FF 76 08        push word ptr [bp + 8]
3928  0E              push cs
3929  E8 B5 EE        call 0x27e1
392C  C9              leave
392D  CA 04 00        retf 4

; ---- routine 01EF:3930  (found by: call)
sub_3930:
3930  C8 06 00 00     enter 6, 0
3934  C4 3E D2 D7     les di, ptr [0xd7d2]
3938  89 7E FA        mov word ptr [bp - 6], di
393B  8C 46 FC        mov word ptr [bp - 4], es
393E  C4 7E 08        les di, ptr [bp + 8]
3941  06              push es
3942  57              push di
3943  BF 5C DD        mov di, 0xdd5c
3946  1E              push ds
3947  57              push di
3948  9A 2F 05 2A 23  call far 232A:052F
394D  C7 06 64 DD 0F 00 mov word ptr [0xdd64], 0xf
3953  8B 46 0C        mov ax, word ptr [bp + 0xc]
3956  D1 E0           shl ax, 1
3958  C4 7E FA        les di, ptr [bp - 6]
395B  03 F8           add di, ax
395D  26 FF 75 03     push word ptr es:[di + 3]
3961  6A 19           push 0x19
3963  6A 04           push 4
3965  9A F4 1E 55 1B  call far 1B55:1EF4
396A  8B 46 0C        mov ax, word ptr [bp + 0xc]
396D  C4 7E FA        les di, ptr [bp - 6]
3970  03 F8           add di, ax
3972  26 8A 45 18     mov al, byte ptr es:[di + 0x18]
3976  30 E4           xor ah, ah
3978  50              push ax
3979  6A 19           push 0x19
397B  8B 46 06        mov ax, word ptr [bp + 6]
397E  05 04 00        add ax, 4
3981  50              push ax
3982  9A E3 0E 55 1B  call far 1B55:0EE3
3987  B8 28 2B        mov ax, 0x2b28
398A  8C DA           mov dx, ds
398C  8B C8           mov cx, ax
398E  8B DA           mov bx, dx
3990  C4 7E 08        les di, ptr [bp + 8]
3993  89 F8           mov ax, di
3995  8C C2           mov dx, es
3997  3B D3           cmp dx, bx
3999  75 44           jne 0x39df
399B  3B C1           cmp ax, cx
399D  75 40           jne 0x39df
399F  8B 46 0C        mov ax, word ptr [bp + 0xc]
39A2  C4 7E FA        les di, ptr [bp - 6]
39A5  03 F8           add di, ax
39A7  26 8A 45 18     mov al, byte ptr es:[di + 0x18]
39AB  30 E4           xor ah, ah
39AD  50              push ax
39AE  9A A2 0E 55 1B  call far 1B55:0EA2
39B3  30 E4           xor ah, ah
39B5  05 80 00        add ax, 0x80
39B8  A3 64 DD        mov word ptr [0xdd64], ax
39BB  8B 46 0C        mov ax, word ptr [bp + 0xc]
39BE  C4 7E FA        les di, ptr [bp - 6]
39C1  03 F8           add di, ax
39C3  26 8A 45 18     mov al, byte ptr es:[di + 0x18]
39C7  30 E4           xor ah, ah
39C9  6B C0 3E        imul ax, ax, 0x3e
39CC  C4 3E C2 D7     les di, ptr [0xd7c2]
39D0  03 F8           add di, ax
39D2  26 FF 75 F2     push word ptr es:[di - 0xe]
39D6  6A 19           push 0x19
39D8  6A 13           push 0x13
39DA  9A F4 1E 55 1B  call far 1B55:1EF4
loc_39DF:
39DF  C4 3E 5C DD     les di, ptr [0xdd5c]
39E3  06              push es
39E4  57              push di
39E5  C4 3E 58 DD     les di, ptr [0xdd58]
39E9  06              push es
39EA  57              push di
39EB  68 A0 0F        push 0xfa0
39EE  9A 12 0A C9 26  call far 26C9:0A12
39F3  C9              leave
39F4  C2 0A 00        ret 0xa

; ---- routine 01EF:39F7  (found by: call)
sub_39F7:
39F7  C8 20 00 00     enter 0x20, 0
39FB  FF 76 06        push word ptr [bp + 6]
39FE  BF 28 2B        mov di, 0x2b28
3A01  1E              push ds
3A02  57              push di
3A03  6A 30           push 0x30
3A05  8B 7E 04        mov di, word ptr [bp + 4]
3A08  57              push di
3A09  E8 24 FF        call 0x3930
3A0C  8D 7E E0        lea di, [bp - 0x20]
3A0F  16              push ss
3A10  57              push di
3A11  6A 02           push 2
3A13  9A 94 0D C9 26  call far 26C9:0D94
3A18  9A 95 07 2A 23  call far 232A:0795
3A1D  C9              leave
3A1E  C2 04 00        ret 4

; ---- routine 01EF:3A21  (found by: call)
sub_3A21:
3A21  C8 02 00 00     enter 2, 0
3A25  FF 76 06        push word ptr [bp + 6]
3A28  BF 68 14        mov di, 0x1468
3A2B  1E              push ds
3A2C  57              push di
3A2D  6A 23           push 0x23
3A2F  8B 7E 04        mov di, word ptr [bp + 4]
3A32  57              push di
3A33  E8 FA FE        call 0x3930
loc_3A36:
3A36  9A 9B 09 2A 23  call far 232A:099B
3A3B  A0 88 DE        mov al, byte ptr [0xde88]
3A3E  50              push ax
3A3F  9A 86 19 C9 26  call far 26C9:1986
3A44  3C 4E           cmp al, 0x4e
3A46  74 04           je 0x3a4c
3A48  3C 59           cmp al, 0x59
3A4A  75 EA           jne 0x3a36
loc_3A4C:
3A4C  A0 88 DE        mov al, byte ptr [0xde88]
3A4F  50              push ax
3A50  9A 86 19 C9 26  call far 26C9:1986
3A55  3C 59           cmp al, 0x59
3A57  B0 00           mov al, 0
3A59  75 01           jne 0x3a5c
3A5B  40              inc ax
loc_3A5C:
3A5C  88 46 FF        mov byte ptr [bp - 1], al
3A5F  8A 46 FF        mov al, byte ptr [bp - 1]
3A62  C9              leave
3A63  C2 04 00        ret 4

; ---- routine 01EF:3A66  (found by: call)
sub_3A66:
3A66  C8 08 00 00     enter 8, 0
3A6A  C4 3E D2 D7     les di, ptr [0xd7d2]
3A6E  89 7E FA        mov word ptr [bp - 6], di
3A71  8C 46 FC        mov word ptr [bp - 4], es
3A74  26 8A 45 03     mov al, byte ptr es:[di + 3]
3A78  30 E4           xor ah, ah
3A7A  89 46 F8        mov word ptr [bp - 8], ax
3A7D  B8 01 00        mov ax, 1
3A80  3B 46 F8        cmp ax, word ptr [bp - 8]
3A83  76 03           jbe 0x3a88
3A85  E9 D2 00        jmp 0x3b5a
loc_3A88:
3A88  89 46 FE        mov word ptr [bp - 2], ax
3A8B  EB 03           jmp 0x3a90
loc_3A8D:
3A8D  FF 46 FE        inc word ptr [bp - 2]
loc_3A90:
3A90  8B 46 FE        mov ax, word ptr [bp - 2]
3A93  C4 7E FA        les di, ptr [bp - 6]
3A96  03 F8           add di, ax
3A98  26 80 7D 18 00  cmp byte ptr es:[di + 0x18], 0
3A9D  74 31           je 0x3ad0
3A9F  FF 76 FE        push word ptr [bp - 2]
3AA2  55              push bp
3AA3  E8 7B FF        call 0x3a21
3AA6  08 C0           or al, al
3AA8  74 16           je 0x3ac0
3AAA  FF 76 FE        push word ptr [bp - 2]
3AAD  8B 46 FE        mov ax, word ptr [bp - 2]
3AB0  C4 7E FA        les di, ptr [bp - 6]
3AB3  03 F8           add di, ax
3AB5  26 8A 45 18     mov al, byte ptr es:[di + 0x18]
3AB9  30 E4           xor ah, ah
3ABB  50              push ax
3ABC  0E              push cs
3ABD  E8 00 FE        call 0x38c0
loc_3AC0:
3AC0  8B 46 FE        mov ax, word ptr [bp - 2]
3AC3  C4 7E FA        les di, ptr [bp - 6]
3AC6  03 F8           add di, ax
3AC8  26 C6 45 18 00  mov byte ptr es:[di + 0x18], 0
3ACD  E9 7F 00        jmp 0x3b4f
loc_3AD0:
3AD0  C4 7E FA        les di, ptr [bp - 6]
3AD3  26 80 3D 37     cmp byte ptr es:[di], 0x37
3AD7  73 76           jae 0x3b4f
3AD9  8B 7E FE        mov di, word ptr [bp - 2]
3ADC  80 BD B9 DC 00  cmp byte ptr [di - 0x2347], 0
3AE1  75 0B           jne 0x3aee
3AE3  6A 05           push 5
3AE5  9A 1C 0D BC 24  call far 24BC:0D1C
3AEA  08 C0           or al, al
3AEC  75 37           jne 0x3b25
loc_3AEE:
3AEE  C4 7E FA        les di, ptr [bp - 6]
3AF1  26 80 3D 06     cmp byte ptr es:[di], 6
3AF5  76 58           jbe 0x3b4f
3AF7  8B 46 FE        mov ax, word ptr [bp - 2]
3AFA  D1 E0           shl ax, 1
3AFC  03 F8           add di, ax
3AFE  26 8B 45 03     mov ax, word ptr es:[di + 3]
3B02  C1 E0 02        shl ax, 2
3B05  C4 3E C8 DC     les di, ptr [0xdcc8]
3B09  03 F8           add di, ax
3B0B  26 8A 45 02     mov al, byte ptr es:[di + 2]
3B0F  30 E4           xor ah, ah
3B11  8B D0           mov dx, ax
3B13  B8 B0 00        mov ax, 0xb0
3B16  2B C2           sub ax, dx
3B18  05 20 00        add ax, 0x20
3B1B  50              push ax
3B1C  9A 1C 0D BC 24  call far 24BC:0D1C
3B21  08 C0           or al, al
3B23  74 2A           je 0x3b4f
loc_3B25:
3B25  FF 76 FE        push word ptr [bp - 2]
3B28  E8 F7 FA        call 0x3622
3B2B  8A D0           mov dl, al
3B2D  8B 46 FE        mov ax, word ptr [bp - 2]
3B30  C4 7E FA        les di, ptr [bp - 6]
3B33  03 F8           add di, ax
3B35  26 88 55 18     mov byte ptr es:[di + 0x18], dl
3B39  8B 46 FE        mov ax, word ptr [bp - 2]
3B3C  C4 7E FA        les di, ptr [bp - 6]
3B3F  03 F8           add di, ax
3B41  26 80 7D 18 00  cmp byte ptr es:[di + 0x18], 0
3B46  74 07           je 0x3b4f
3B48  FF 76 FE        push word ptr [bp - 2]
3B4B  55              push bp
3B4C  E8 A8 FE        call 0x39f7
loc_3B4F:
3B4F  8B 46 FE        mov ax, word ptr [bp - 2]
3B52  3B 46 F8        cmp ax, word ptr [bp - 8]
3B55  74 03           je 0x3b5a
3B57  E9 33 FF        jmp 0x3a8d
loc_3B5A:
3B5A  C9              leave
3B5B  C3              ret

