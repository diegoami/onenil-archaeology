; 1-0.EXE (One-Nil 96), code segment 0AB9 (image offsets 0AB90..1997F), part 6 of 22
; packed 1-0.EXE sha256 89ff9c5f238f24e81a0c2440a46cdd8997280a65fc3cc3d97cb974f55280a80a (LZEXE 0.91)
; unpacked (tools/static/unlzexe.py) sha256 887ed2a92767950e5309b2052409f875668605939b69e00737aa3047022b9f51
; tool: capstone 5.0.9 (pip package; core library 5.0.1280) (CS_ARCH_X86, CS_MODE_16), recursive descent from the entry point, far calls and near calls/jumps, then routine prologues (55 89 E5 / 55 8B EC / C8 iw 00) in what remains; tools/static/listing.py
; addresses are SEGMENT:OFFSET with SEGMENT the image paragraph before relocation; image offset = SEGMENT*16+OFFSET
; ---- routine 0AB9:32DA  (found by: call)
sub_32DA:
32DA  55              push bp
32DB  89 E5           mov bp, sp
32DD  C4 7E 06        les di, ptr [bp + 6]
32E0  26 8B 45 0E     mov ax, word ptr es:[di + 0xe]
32E4  C1 E0 03        shl ax, 3
32E7  C4 3E BA D7     les di, ptr [0xd7ba]
32EB  03 F8           add di, ax
32ED  26 8A 45 06     mov al, byte ptr es:[di + 6]
32F1  3C 00           cmp al, 0
32F3  75 0A           jne 0x32ff
32F5  C4 7E 06        les di, ptr [bp + 6]
32F8  26 C6 45 0C 00  mov byte ptr es:[di + 0xc], 0
32FD  EB 45           jmp 0x3344
loc_32FF:
32FF  3C 0D           cmp al, 0xd
3301  75 30           jne 0x3333
3303  C4 7E 06        les di, ptr [bp + 6]
3306  26 80 7D 13 09  cmp byte ptr es:[di + 0x13], 9
330B  75 13           jne 0x3320
330D  6A 05           push 5
330F  9A 6D 07 2A 23  call far 232A:076D
3314  2D 03 00        sub ax, 3
3317  C4 7E 06        les di, ptr [bp + 6]
331A  26 88 45 0C     mov byte ptr es:[di + 0xc], al
331E  EB 11           jmp 0x3331
loc_3320:
3320  6A 0F           push 0xf
3322  9A 6D 07 2A 23  call far 232A:076D
3327  2D 08 00        sub ax, 8
332A  C4 7E 06        les di, ptr [bp + 6]
332D  26 88 45 0C     mov byte ptr es:[di + 0xc], al
loc_3331:
3331  EB 11           jmp 0x3344
loc_3333:
3333  6A 05           push 5
3335  9A 6D 07 2A 23  call far 232A:076D
333A  2D 03 00        sub ax, 3
333D  C4 7E 06        les di, ptr [bp + 6]
3340  26 88 45 0C     mov byte ptr es:[di + 0xc], al
loc_3344:
3344  C4 7E 06        les di, ptr [bp + 6]
3347  26 80 7D 0D 02  cmp byte ptr es:[di + 0xd], 2
334C  7D 0F           jge 0x335d
334E  26 8A 45 0A     mov al, byte ptr es:[di + 0xa]
3352  98              cwde
3353  99              cdq
3354  B9 02 00        mov cx, 2
3357  F7 F9           idiv cx
3359  26 28 45 0C     sub byte ptr es:[di + 0xc], al
loc_335D:
335D  C4 7E 06        les di, ptr [bp + 6]
3360  26 8A 45 0D     mov al, byte ptr es:[di + 0xd]
3364  98              cwde
3365  8B D0           mov dx, ax
3367  26 8A 45 0B     mov al, byte ptr es:[di + 0xb]
336B  98              cwde
336C  03 C2           add ax, dx
336E  26 88 45 09     mov byte ptr es:[di + 9], al
3372  26 8A 45 0C     mov al, byte ptr es:[di + 0xc]
3376  98              cwde
3377  8B D0           mov dx, ax
3379  26 8A 45 0A     mov al, byte ptr es:[di + 0xa]
337D  98              cwde
337E  03 C2           add ax, dx
3380  26 88 45 08     mov byte ptr es:[di + 8], al
3384  26 FF 75 08     push word ptr es:[di + 8]
3388  06              push es
3389  57              push di
338A  0E              push cs
338B  E8 D0 EB        call 0x1f5e
338E  C4 7E 06        les di, ptr [bp + 6]
3391  26 89 45 08     mov word ptr es:[di + 8], ax
3395  C9              leave
3396  CA 04 00        retf 4

; ---- routine 0AB9:3399  (found by: call)
sub_3399:
3399  C8 04 00 00     enter 4, 0
339D  C4 7E 06        les di, ptr [bp + 6]
33A0  26 8B 45 0A     mov ax, word ptr es:[di + 0xa]
33A4  89 46 FC        mov word ptr [bp - 4], ax
33A7  26 8B 45 0E     mov ax, word ptr es:[di + 0xe]
33AB  C1 E0 03        shl ax, 3
33AE  C4 3E BA D7     les di, ptr [0xd7ba]
33B2  03 F8           add di, ax
33B4  26 8A 45 06     mov al, byte ptr es:[di + 6]
33B8  30 E4           xor ah, ah
33BA  8B F8           mov di, ax
33BC  8A 85 5A 0A     mov al, byte ptr [di + 0xa5a]
33C0  00 46 FD        add byte ptr [bp - 3], al
33C3  8A 46 FC        mov al, byte ptr [bp - 4]
33C6  98              cwde
33C7  8B D0           mov dx, ax
33C9  8A 46 0A        mov al, byte ptr [bp + 0xa]
33CC  98              cwde
33CD  2B C2           sub ax, dx
33CF  99              cdq
33D0  31 D0           xor ax, dx
33D2  29 D0           sub ax, dx
33D4  3D 04 00        cmp ax, 4
33D7  7D 24           jge 0x33fd
33D9  C4 7E 06        les di, ptr [bp + 6]
33DC  06              push es
33DD  57              push di
33DE  0E              push cs
33DF  E8 EA EA        call 0x1ecc
33E2  98              cwde
33E3  8B D0           mov dx, ax
33E5  8A 46 FD        mov al, byte ptr [bp - 3]
33E8  98              cwde
33E9  F7 E2           mul dx
33EB  8B D0           mov dx, ax
33ED  8A 46 0B        mov al, byte ptr [bp + 0xb]
33F0  98              cwde
33F1  2B C2           sub ax, dx
33F3  99              cdq
33F4  31 D0           xor ax, dx
33F6  29 D0           sub ax, dx
33F8  3D 09 00        cmp ax, 9
33FB  7C 04           jl 0x3401
loc_33FD:
33FD  B0 00           mov al, 0
33FF  EB 02           jmp 0x3403
loc_3401:
3401  B0 01           mov al, 1
loc_3403:
3403  88 46 FF        mov byte ptr [bp - 1], al
3406  8A 46 FF        mov al, byte ptr [bp - 1]
3409  C9              leave
340A  CA 06 00        retf 6

; ---- routine 0AB9:340D  (found by: call)
sub_340D:
340D  C8 02 00 00     enter 2, 0
3411  C6 46 FF 00     mov byte ptr [bp - 1], 0
3415  8B 7E 04        mov di, word ptr [bp + 4]
3418  36 C4 7D 06     les di, ptr ss:[di + 6]
341C  06              push es
341D  57              push di
341E  0E              push cs
341F  E8 3D FE        call 0x325f
3422  50              push ax
3423  6A 07           push 7
3425  8B 7E 04        mov di, word ptr [bp + 4]
3428  36 C4 7D 06     les di, ptr ss:[di + 6]
342C  06              push es
342D  57              push di
342E  0E              push cs
342F  E8 1A E6        call 0x1a4c
3432  98              cwde
3433  8B F8           mov di, ax
3435  C1 E7 02        shl di, 2
3438  58              pop ax
3439  03 F8           add di, ax
343B  8A 85 77 0A     mov al, byte ptr [di + 0xa77]
343F  30 E4           xor ah, ah
3441  8B D0           mov dx, ax
3443  8B 7E 04        mov di, word ptr [bp + 4]
3446  36 C4 7D 06     les di, ptr ss:[di + 6]
344A  26 8A 45 0D     mov al, byte ptr es:[di + 0xd]
344E  98              cwde
344F  3B C2           cmp ax, dx
3451  7C 03           jl 0x3456
3453  E9 AF 00        jmp 0x3505
loc_3456:
3456  06              push es
3457  57              push di
3458  0E              push cs
3459  E8 03 FE        call 0x325f
345C  3D 01 00        cmp ax, 1
345F  75 3A           jne 0x349b
3461  6A 00           push 0
3463  8B 7E 04        mov di, word ptr [bp + 4]
3466  36 C4 7D 06     les di, ptr ss:[di + 6]
346A  06              push es
346B  57              push di
346C  0E              push cs
346D  E8 63 EB        call 0x1fd3
3470  08 C0           or al, al
3472  75 20           jne 0x3494
3474  6A 01           push 1
3476  8B 7E 04        mov di, word ptr [bp + 4]
3479  36 C4 7D 06     les di, ptr ss:[di + 6]
347D  06              push es
347E  57              push di
347F  0E              push cs
3480  E8 C9 E5        call 0x1a4c
3483  08 C0           or al, al
3485  75 0D           jne 0x3494
3487  9A 3F 0D BC 24  call far 24BC:0D3F
348C  08 C0           or al, al
348E  75 04           jne 0x3494
3490  B0 00           mov al, 0
3492  EB 02           jmp 0x3496
loc_3494:
3494  B0 01           mov al, 1
loc_3496:
3496  88 46 FF        mov byte ptr [bp - 1], al
3499  EB 6A           jmp 0x3505
loc_349B:
349B  3D 02 00        cmp ax, 2
349E  75 31           jne 0x34d1
34A0  6A 00           push 0
34A2  8B 7E 04        mov di, word ptr [bp + 4]
34A5  36 C4 7D 06     les di, ptr ss:[di + 6]
34A9  06              push es
34AA  57              push di
34AB  0E              push cs
34AC  E8 24 EB        call 0x1fd3
34AF  08 C0           or al, al
34B1  75 17           jne 0x34ca
34B3  6A 01           push 1
34B5  8B 7E 04        mov di, word ptr [bp + 4]
34B8  36 C4 7D 06     les di, ptr ss:[di + 6]
34BC  06              push es
34BD  57              push di
34BE  0E              push cs
34BF  E8 8A E5        call 0x1a4c
34C2  08 C0           or al, al
34C4  75 04           jne 0x34ca
34C6  B0 00           mov al, 0
34C8  EB 02           jmp 0x34cc
loc_34CA:
34CA  B0 01           mov al, 1
loc_34CC:
34CC  88 46 FF        mov byte ptr [bp - 1], al
34CF  EB 34           jmp 0x3505
loc_34D1:
34D1  3D 03 00        cmp ax, 3
34D4  75 2F           jne 0x3505
34D6  6A 1E           push 0x1e
34D8  8B 7E 04        mov di, word ptr [bp + 4]
34DB  36 C4 7D 06     les di, ptr ss:[di + 6]
34DF  06              push es
34E0  57              push di
34E1  0E              push cs
34E2  E8 EE EA        call 0x1fd3
34E5  08 C0           or al, al
34E7  75 17           jne 0x3500
34E9  6A 07           push 7
34EB  8B 7E 04        mov di, word ptr [bp + 4]
34EE  36 C4 7D 06     les di, ptr ss:[di + 6]
34F2  06              push es
34F3  57              push di
34F4  0E              push cs
34F5  E8 54 E5        call 0x1a4c
34F8  08 C0           or al, al
34FA  75 04           jne 0x3500
34FC  B0 00           mov al, 0
34FE  EB 02           jmp 0x3502
loc_3500:
3500  B0 01           mov al, 1
loc_3502:
3502  88 46 FF        mov byte ptr [bp - 1], al
loc_3505:
3505  8A 46 FF        mov al, byte ptr [bp - 1]
3508  C9              leave
3509  C2 02 00        ret 2

; ---- routine 0AB9:350C  (found by: call)
sub_350C:
350C  C8 02 00 00     enter 2, 0
3510  C6 46 FF 00     mov byte ptr [bp - 1], 0
3514  8B 7E 04        mov di, word ptr [bp + 4]
3517  36 C4 7D 06     les di, ptr ss:[di + 6]
351B  06              push es
351C  57              push di
351D  0E              push cs
351E  E8 3E FD        call 0x325f
3521  50              push ax
3522  6A 06           push 6
3524  8B 7E 04        mov di, word ptr [bp + 4]
3527  36 C4 7D 06     les di, ptr ss:[di + 6]
352B  06              push es
352C  57              push di
352D  0E              push cs
352E  E8 1B E5        call 0x1a4c
3531  98              cwde
3532  C1 E0 02        shl ax, 2
3535  50              push ax
3536  6A 05           push 5
3538  8B 7E 04        mov di, word ptr [bp + 4]
353B  36 C4 7D 06     les di, ptr ss:[di + 6]
353F  06              push es
3540  57              push di
3541  0E              push cs
3542  E8 07 E5        call 0x1a4c
3545  98              cwde
3546  8B F8           mov di, ax
3548  C1 E7 03        shl di, 3
354B  58              pop ax
354C  03 F8           add di, ax
354E  58              pop ax
354F  03 F8           add di, ax
3551  8A 85 67 0A     mov al, byte ptr [di + 0xa67]
3555  30 E4           xor ah, ah
3557  8B D0           mov dx, ax
3559  8B 7E 04        mov di, word ptr [bp + 4]
355C  36 C4 7D 06     les di, ptr ss:[di + 6]
3560  26 8A 45 0D     mov al, byte ptr es:[di + 0xd]
3564  98              cwde
3565  3B C2           cmp ax, dx
3567  7F 03           jg 0x356c
3569  E9 85 00        jmp 0x35f1
loc_356C:
356C  06              push es
356D  57              push di
356E  0E              push cs
356F  E8 ED FC        call 0x325f
3572  3D 01 00        cmp ax, 1
3575  75 14           jne 0x358b
3577  6A 0F           push 0xf
3579  8B 7E 04        mov di, word ptr [bp + 4]
357C  36 C4 7D 06     les di, ptr ss:[di + 6]
3580  06              push es
3581  57              push di
3582  0E              push cs
3583  E8 A3 EA        call 0x2029
3586  88 46 FF        mov byte ptr [bp - 1], al
3589  EB 66           jmp 0x35f1
loc_358B:
358B  3D 02 00        cmp ax, 2
358E  75 14           jne 0x35a4
3590  6A 00           push 0
3592  8B 7E 04        mov di, word ptr [bp + 4]
3595  36 C4 7D 06     les di, ptr ss:[di + 6]
3599  06              push es
359A  57              push di
359B  0E              push cs
359C  E8 8A EA        call 0x2029
359F  88 46 FF        mov byte ptr [bp - 1], al
35A2  EB 4D           jmp 0x35f1
loc_35A4:
35A4  3D 03 00        cmp ax, 3
35A7  75 48           jne 0x35f1
35A9  6A 0A           push 0xa
35AB  8B 7E 04        mov di, word ptr [bp + 4]
35AE  36 C4 7D 06     les di, ptr ss:[di + 6]
35B2  06              push es
35B3  57              push di
35B4  0E              push cs
35B5  E8 1B EA        call 0x1fd3
35B8  08 C0           or al, al
35BA  74 30           je 0x35ec
35BC  8B 7E 04        mov di, word ptr [bp + 4]
35BF  36 C4 7D 06     les di, ptr ss:[di + 6]
35C3  06              push es
35C4  57              push di
35C5  0E              push cs
35C6  E8 D6 E8        call 0x1e9f
35C9  3C 02           cmp al, 2
35CB  74 1F           je 0x35ec
35CD  8B 7E 04        mov di, word ptr [bp + 4]
35D0  36 C4 7D 06     les di, ptr ss:[di + 6]
35D4  26 8B 45 0E     mov ax, word ptr es:[di + 0xe]
35D8  C1 E0 03        shl ax, 3
35DB  C4 3E BA D7     les di, ptr [0xd7ba]
35DF  03 F8           add di, ax
35E1  26 80 7D 06 01  cmp byte ptr es:[di + 6], 1
35E6  74 04           je 0x35ec
35E8  B0 00           mov al, 0
35EA  EB 02           jmp 0x35ee
loc_35EC:
35EC  B0 01           mov al, 1
loc_35EE:
35EE  88 46 FF        mov byte ptr [bp - 1], al
loc_35F1:
35F1  8A 46 FF        mov al, byte ptr [bp - 1]
35F4  C9              leave
35F5  C2 02 00        ret 2

; ---- routine 0AB9:35F8  (found by: call)
sub_35F8:
35F8  C8 02 00 00     enter 2, 0
35FC  C4 7E 06        les di, ptr [bp + 6]
35FF  06              push es
3600  57              push di
3601  0E              push cs
3602  E8 49 E8        call 0x1e4e
3605  08 C0           or al, al
3607  74 33           je 0x363c
3609  C4 7E 06        les di, ptr [bp + 6]
360C  26 8B 45 0E     mov ax, word ptr es:[di + 0xe]
3610  C1 E0 03        shl ax, 3
3613  C4 3E BA D7     les di, ptr [0xd7ba]
3617  03 F8           add di, ax
3619  26 80 7D 06 04  cmp byte ptr es:[di + 6], 4
361E  77 0F           ja 0x362f
3620  6A 00           push 0
3622  C4 7E 06        les di, ptr [bp + 6]
3625  06              push es
3626  57              push di
3627  0E              push cs
3628  E8 A8 E9        call 0x1fd3
362B  08 C0           or al, al
362D  74 0D           je 0x363c
loc_362F:
362F  55              push bp
3630  E8 DA FD        call 0x340d
3633  C4 7E 06        les di, ptr [bp + 6]
3636  26 00 45 0D     add byte ptr es:[di + 0xd], al
363A  EB 23           jmp 0x365f
loc_363C:
363C  55              push bp
363D  E8 CC FE        call 0x350c
3640  C4 7E 06        les di, ptr [bp + 6]
3643  26 28 45 0D     sub byte ptr es:[di + 0xd], al
3647  06              push es
3648  57              push di
3649  0E              push cs
364A  E8 52 E8        call 0x1e9f
364D  3C 02           cmp al, 2
364F  75 0E           jne 0x365f
3651  C4 7E 06        les di, ptr [bp + 6]
3654  26 8A 45 0A     mov al, byte ptr es:[di + 0xa]
3658  98              cwde
3659  F7 D8           neg ax
365B  26 88 45 0C     mov byte ptr es:[di + 0xc], al
loc_365F:
365F  C9              leave
3660  CA 04 00        retf 4

; ---- routine 0AB9:3663  (found by: call)
sub_3663:
3663  C8 0A 00 00     enter 0xa, 0
3667  E8 6C E6        call 0x1cd6
366A  98              cwde
366B  8B F8           mov di, ax
366D  D1 E7           shl di, 1
366F  6B 85 E4 D6 3E  imul ax, word ptr [di - 0x291c], 0x3e
3674  C4 3E C2 D7     les di, ptr [0xd7c2]
3678  03 F8           add di, ax
367A  81 C7 C2 FF     add di, 0xffc2
367E  89 7E F6        mov word ptr [bp - 0xa], di
3681  8C 46 F8        mov word ptr [bp - 8], es
3684  C6 46 FF 00     mov byte ptr [bp - 1], 0
3688  8B 7E 04        mov di, word ptr [bp + 4]
368B  36 C4 7D 06     les di, ptr ss:[di + 6]
368F  26 83 7D 14 00  cmp word ptr es:[di + 0x14], 0
3694  B0 00           mov al, 0
3696  75 01           jne 0x3699
3698  40              inc ax
loc_3699:
3699  8B 7E 04        mov di, word ptr [bp + 4]
369C  36 88 45 FB     mov byte ptr ss:[di - 5], al
36A0  8B 7E 04        mov di, word ptr [bp + 4]
36A3  36 C4 7D 06     les di, ptr ss:[di + 6]
36A7  26 83 7D 14 00  cmp word ptr es:[di + 0x14], 0
36AC  75 67           jne 0x3715
36AE  C7 46 FC 02 00  mov word ptr [bp - 4], 2
loc_36B3:
36B3  83 7E FC 0C     cmp word ptr [bp - 4], 0xc
36B7  73 5C           jae 0x3715
36B9  8B 46 FC        mov ax, word ptr [bp - 4]
36BC  D1 E0           shl ax, 1
36BE  C4 7E F6        les di, ptr [bp - 0xa]
36C1  03 F8           add di, ax
36C3  26 FF 75 FE     push word ptr es:[di - 2]
36C7  9A 89 4F 55 1B  call far 1B55:4F89
36CC  08 C0           or al, al
36CE  75 40           jne 0x3710
36D0  E8 03 E6        call 0x1cd6
36D3  98              cwde
36D4  8B F8           mov di, ax
36D6  8A 85 56 0D     mov al, byte ptr [di + 0xd56]
36DA  30 E4           xor ah, ah
36DC  03 46 FC        add ax, word ptr [bp - 4]
36DF  6B F8 19        imul di, ax, 0x19
36E2  FF B5 EF CC     push word ptr [di - 0x3311]
36E6  8B 7E 04        mov di, word ptr [bp + 4]
36E9  36 C4 7D 06     les di, ptr ss:[di + 6]
36ED  06              push es
36EE  57              push di
36EF  0E              push cs
36F0  E8 A6 FC        call 0x3399
36F3  08 C0           or al, al
36F5  74 19           je 0x3710
36F7  8B 46 FC        mov ax, word ptr [bp - 4]
36FA  D1 E0           shl ax, 1
36FC  C4 7E F6        les di, ptr [bp - 0xa]
36FF  03 F8           add di, ax
3701  26 8B 45 FE     mov ax, word ptr es:[di - 2]
3705  8B 7E 04        mov di, word ptr [bp + 4]
3708  36 C4 7D 06     les di, ptr ss:[di + 6]
370C  26 89 45 14     mov word ptr es:[di + 0x14], ax
loc_3710:
3710  FF 46 FC        inc word ptr [bp - 4]
3713  EB 9E           jmp 0x36b3
loc_3715:
3715  8B 7E 04        mov di, word ptr [bp + 4]
3718  36 C4 7D 06     les di, ptr ss:[di + 6]
371C  26 83 7D 14 00  cmp word ptr es:[di + 0x14], 0
3721  75 03           jne 0x3726
3723  E9 19 01        jmp 0x383f
loc_3726:
3726  C7 46 FC 02 00  mov word ptr [bp - 4], 2
loc_372B:
372B  83 7E FC 0C     cmp word ptr [bp - 4], 0xc
372F  72 03           jb 0x3734
3731  E9 FE 00        jmp 0x3832
loc_3734:
3734  8B 46 FC        mov ax, word ptr [bp - 4]
3737  D1 E0           shl ax, 1
3739  C4 7E F6        les di, ptr [bp - 0xa]
373C  03 F8           add di, ax
373E  26 8B 45 FE     mov ax, word ptr es:[di - 2]
3742  8B 7E 04        mov di, word ptr [bp + 4]
3745  36 C4 7D 06     les di, ptr ss:[di + 6]
3749  26 3B 45 14     cmp ax, word ptr es:[di + 0x14]
374D  74 03           je 0x3752
374F  E9 DA 00        jmp 0x382c
loc_3752:
3752  8B 46 FC        mov ax, word ptr [bp - 4]
3755  D1 E0           shl ax, 1
3757  C4 7E F6        les di, ptr [bp - 0xa]
375A  03 F8           add di, ax
375C  26 FF 75 FE     push word ptr es:[di - 2]
3760  9A 89 4F 55 1B  call far 1B55:4F89
3765  08 C0           or al, al
3767  74 03           je 0x376c
3769  E9 C0 00        jmp 0x382c
loc_376C:
376C  E8 67 E5        call 0x1cd6
376F  98              cwde
3770  8B F8           mov di, ax
3772  8A 85 56 0D     mov al, byte ptr [di + 0xd56]
3776  30 E4           xor ah, ah
3778  03 46 FC        add ax, word ptr [bp - 4]
377B  8B 7E 04        mov di, word ptr [bp + 4]
377E  36 89 45 FC     mov word ptr ss:[di - 4], ax
3782  36 6B 7D FC 19  imul di, word ptr ss:[di - 4], 0x19
3787  8B 85 EF CC     mov ax, word ptr [di - 0x3311]
378B  8B 7E 04        mov di, word ptr [bp + 4]
378E  36 89 45 FE     mov word ptr ss:[di - 2], ax
3792  36 6B 7D FC 19  imul di, word ptr ss:[di - 4], 0x19
3797  81 C7 EF CC     add di, 0xccef
379B  1E              push ds
379C  57              push di
379D  0E              push cs
379E  E8 92 E7        call 0x1f33
37A1  08 C0           or al, al
37A3  74 03           je 0x37a8
37A5  E9 97 00        jmp 0x383f
loc_37A8:
37A8  C7 46 FA 01 00  mov word ptr [bp - 6], 1
37AD  6A 08           push 8
37AF  8B 7E 04        mov di, word ptr [bp + 4]
37B2  36 C4 7D 06     les di, ptr ss:[di + 6]
37B6  06              push es
37B7  57              push di
37B8  0E              push cs
37B9  E8 26 E3        call 0x1ae2
37BC  50              push ax
37BD  6A 10           push 0x10
37BF  8B 7E 04        mov di, word ptr [bp + 4]
37C2  36 6B 7D FC 19  imul di, word ptr ss:[di - 4], 0x19
37C7  81 C7 EF CC     add di, 0xccef
37CB  1E              push ds
37CC  57              push di
37CD  0E              push cs
37CE  E8 11 E3        call 0x1ae2
37D1  5A              pop dx
37D2  3B C2           cmp ax, dx
37D4  76 2D           jbe 0x3803
37D6  6A 08           push 8
37D8  8B 7E 04        mov di, word ptr [bp + 4]
37DB  36 C4 7D 06     les di, ptr ss:[di + 6]
37DF  06              push es
37E0  57              push di
37E1  0E              push cs
37E2  E8 FD E2        call 0x1ae2
37E5  50              push ax
37E6  6A 10           push 0x10
37E8  8B 7E 04        mov di, word ptr [bp + 4]
37EB  36 6B 7D FC 19  imul di, word ptr ss:[di - 4], 0x19
37F0  81 C7 EF CC     add di, 0xccef
37F4  1E              push ds
37F5  57              push di
37F6  0E              push cs
37F7  E8 E8 E2        call 0x1ae2
37FA  5A              pop dx
37FB  2B C2           sub ax, dx
37FD  C1 E8 04        shr ax, 4
3800  01 46 FA        add word ptr [bp - 6], ax
loc_3803:
3803  FF 76 FA        push word ptr [bp - 6]
3806  9A 6D 07 2A 23  call far 232A:076D
380B  50              push ax
380C  8B 7E 04        mov di, word ptr [bp + 4]
380F  36 C4 7D 06     les di, ptr ss:[di + 6]
3813  06              push es
3814  57              push di
3815  0E              push cs
3816  E8 B3 E6        call 0x1ecc
3819  98              cwde
381A  5A              pop dx
381B  F7 E2           mul dx
381D  8B 7E 04        mov di, word ptr [bp + 4]
3820  36 28 45 FF     sub byte ptr ss:[di - 1], al
3824  C6 46 FF 01     mov byte ptr [bp - 1], 1
3828  EB 15           jmp 0x383f
; data (not reached as code), 2 bytes
382A                  db EB 03   ; ..
loc_382C:
382C  FF 46 FC        inc word ptr [bp - 4]
382F  E9 F9 FE        jmp 0x372b
loc_3832:
3832  8B 7E 04        mov di, word ptr [bp + 4]
3835  36 C4 7D 06     les di, ptr ss:[di + 6]
3839  31 C0           xor ax, ax
383B  26 89 45 14     mov word ptr es:[di + 0x14], ax
loc_383F:
383F  8A 46 FF        mov al, byte ptr [bp - 1]
3842  C9              leave
3843  C2 02 00        ret 2

; ---- routine 0AB9:3846  (found by: call)
sub_3846:
3846  C8 0E 00 00     enter 0xe, 0
384A  C4 7E 06        les di, ptr [bp + 6]
384D  26 8B 45 0E     mov ax, word ptr es:[di + 0xe]
3851  C1 E0 03        shl ax, 3
3854  C4 3E BA D7     les di, ptr [0xd7ba]
3858  03 F8           add di, ax
385A  89 7E F6        mov word ptr [bp - 0xa], di
385D  8C 46 F8        mov word ptr [bp - 8], es
3860  C4 7E 06        les di, ptr [bp + 6]
3863  26 6B 45 0E 0F  imul ax, word ptr es:[di + 0xe], 0xf
3868  C4 3E BE D7     les di, ptr [0xd7be]
386C  03 F8           add di, ax
386E  89 7E F2        mov word ptr [bp - 0xe], di
3871  8C 46 F4        mov word ptr [bp - 0xc], es
3874  C4 7E 06        les di, ptr [bp + 6]
3877  06              push es
3878  57              push di
3879  0E              push cs
387A  E8 D1 E5        call 0x1e4e
387D  08 C0           or al, al
387F  74 32           je 0x38b3
3881  C4 7E 06        les di, ptr [bp + 6]
3884  06              push es
3885  57              push di
3886  0E              push cs
3887  E8 E7 E5        call 0x1e71
388A  08 C0           or al, al
388C  75 19           jne 0x38a7
388E  C4 7E F6        les di, ptr [bp - 0xa]
3891  26 80 7D 06 01  cmp byte ptr es:[di + 6], 1
3896  75 18           jne 0x38b0
3898  6A 0A           push 0xa
389A  C4 7E 06        les di, ptr [bp + 6]
389D  06              push es
389E  57              push di
389F  0E              push cs
38A0  E8 30 E7        call 0x1fd3
38A3  08 C0           or al, al
38A5  75 09           jne 0x38b0
loc_38A7:
38A7  C4 7E 06        les di, ptr [bp + 6]
38AA  06              push es
38AB  57              push di
38AC  0E              push cs
38AD  E8 2A FA        call 0x32da
loc_38B0:
38B0  E9 C0 00        jmp 0x3973
loc_38B3:
38B3  C4 7E 06        les di, ptr [bp + 6]
38B6  06              push es
38B7  57              push di
38B8  0E              push cs
38B9  E8 1E FA        call 0x32da
38BC  C4 7E 06        les di, ptr [bp + 6]
38BF  26 8A 45 07     mov al, byte ptr es:[di + 7]
38C3  30 E4           xor ah, ah
38C5  50              push ax
38C6  E8 37 C7        call 0
38C9  08 C0           or al, al
38CB  74 3A           je 0x3907
38CD  80 3E B8 D0 00  cmp byte ptr [0xd0b8], 0
38D2  74 31           je 0x3905
38D4  FF 36 46 CF     push word ptr [0xcf46]
38D8  C4 7E 06        les di, ptr [bp + 6]
38DB  06              push es
38DC  57              push di
38DD  0E              push cs
38DE  E8 9E E7        call 0x207f
38E1  08 C0           or al, al
38E3  75 16           jne 0x38fb
38E5  6A 01           push 1
38E7  C4 7E 06        les di, ptr [bp + 6]
38EA  06              push es
38EB  57              push di
38EC  0E              push cs
38ED  E8 5C E1        call 0x1a4c
38F0  08 C0           or al, al
38F2  74 11           je 0x3905
38F4  E8 A1 F7        call 0x3098
38F7  08 C0           or al, al
38F9  74 0A           je 0x3905
loc_38FB:
38FB  A1 46 CF        mov ax, word ptr [0xcf46]
38FE  C4 7E 06        les di, ptr [bp + 6]
3901  26 89 45 08     mov word ptr es:[di + 8], ax
loc_3905:
3905  EB 5D           jmp 0x3964
loc_3907:
3907  55              push bp
3908  E8 58 FD        call 0x3663
390B  08 C0           or al, al
390D  74 55           je 0x3964
390F  80 3E B8 D0 00  cmp byte ptr [0xd0b8], 0
3914  75 0A           jne 0x3920
3916  A0 9F D0        mov al, byte ptr [0xd09f]
3919  30 E4           xor ah, ah
391B  3B 46 FC        cmp ax, word ptr [bp - 4]
391E  74 44           je 0x3964
loc_3920:
3920  6A 06           push 6
3922  9A 6D 07 2A 23  call far 232A:076D
3927  8B D0           mov dx, ax
3929  C4 7E F2        les di, ptr [bp - 0xe]
392C  26 8A 45 08     mov al, byte ptr es:[di + 8]
3930  98              cwde
3931  3B C2           cmp ax, dx
3933  7E 2F           jle 0x3964
3935  6A 05           push 5
3937  C4 7E 06        les di, ptr [bp + 6]
393A  06              push es
393B  57              push di
393C  0E              push cs
393D  E8 0C E1        call 0x1a4c
3940  08 C0           or al, al
3942  75 16           jne 0x395a
3944  C4 7E 06        les di, ptr [bp + 6]
3947  06              push es
3948  57              push di
3949  0E              push cs
394A  E8 7F E5        call 0x1ecc
394D  98              cwde
394E  8B D0           mov dx, ax
3950  8A 46 FF        mov al, byte ptr [bp - 1]
3953  98              cwde
3954  F7 E2           mul dx
3956  09 C0           or ax, ax
3958  7D 0A           jge 0x3964
loc_395A:
395A  8B 46 FE        mov ax, word ptr [bp - 2]
395D  C4 7E 06        les di, ptr [bp + 6]
3960  26 89 45 08     mov word ptr es:[di + 8], ax
loc_3964:
3964  80 7E FB 00     cmp byte ptr [bp - 5], 0
3968  74 09           je 0x3973
396A  C4 7E 06        les di, ptr [bp + 6]
396D  31 C0           xor ax, ax
396F  26 89 45 14     mov word ptr es:[di + 0x14], ax
loc_3973:
3973  C9              leave
3974  CA 04 00        retf 4

; ---- routine 0AB9:3977  (found by: call)
sub_3977:
3977  55              push bp
3978  89 E5           mov bp, sp
397A  C4 7E 06        les di, ptr [bp + 6]
397D  26 8A 45 07     mov al, byte ptr es:[di + 7]
3981  30 E4           xor ah, ah
3983  50              push ax
3984  E8 79 C6        call 0
3987  08 C0           or al, al
3989  74 17           je 0x39a2
398B  C4 7E 06        les di, ptr [bp + 6]
398E  26 FF 75 0A     push word ptr es:[di + 0xa]
3992  06              push es
3993  57              push di
3994  0E              push cs
3995  E8 C6 E5        call 0x1f5e
3998  C4 7E 06        les di, ptr [bp + 6]
399B  26 89 45 08     mov word ptr es:[di + 8], ax
399F  E9 7B 01        jmp 0x3b1d
loc_39A2:
39A2  C4 7E 06        les di, ptr [bp + 6]
39A5  26 80 7D 13 09  cmp byte ptr es:[di + 0x13], 9
39AA  74 21           je 0x39cd
39AC  26 80 7D 13 0B  cmp byte ptr es:[di + 0x13], 0xb
39B1  74 03           je 0x39b6
39B3  E9 97 00        jmp 0x3a4d
loc_39B6:
39B6  06              push es
39B7  57              push di
39B8  0E              push cs
39B9  E8 10 E5        call 0x1ecc
39BC  98              cwde
39BD  8B D0           mov dx, ax
39BF  A0 47 CF        mov al, byte ptr [0xcf47]
39C2  98              cwde
39C3  F7 E2           mul dx
39C5  3D 14 00        cmp ax, 0x14
39C8  7F 03           jg 0x39cd
39CA  E9 80 00        jmp 0x3a4d
loc_39CD:
39CD  C4 7E 06        les di, ptr [bp + 6]
39D0  06              push es
39D1  57              push di
39D2  0E              push cs
39D3  E8 78 E4        call 0x1e4e
39D6  08 C0           or al, al
39D8  74 56           je 0x3a30
39DA  C4 7E 06        les di, ptr [bp + 6]
39DD  26 8B 45 0E     mov ax, word ptr es:[di + 0xe]
39E1  C1 E0 03        shl ax, 3
39E4  C4 3E BA D7     les di, ptr [0xd7ba]
39E8  03 F8           add di, ax
39EA  26 8A 45 06     mov al, byte ptr es:[di + 6]
39EE  3C 01           cmp al, 1
39F0  74 08           je 0x39fa
39F2  3C 03           cmp al, 3
39F4  72 1E           jb 0x3a14
39F6  3C 05           cmp al, 5
39F8  77 1A           ja 0x3a14
loc_39FA:
39FA  E8 A3 DF        call 0x19a0
39FD  8B C8           mov cx, ax
39FF  C4 7E 06        les di, ptr [bp + 6]
3A02  26 8A 45 0B     mov al, byte ptr es:[di + 0xb]
3A06  98              cwde
3A07  99              cdq
3A08  31 D0           xor ax, dx
3A0A  29 D0           sub ax, dx
3A0C  03 C1           add ax, cx
3A0E  26 88 45 0D     mov byte ptr es:[di + 0xd], al
3A12  EB 1A           jmp 0x3a2e
loc_3A14:
3A14  E8 89 DF        call 0x19a0
3A17  8B C8           mov cx, ax
3A19  C4 7E 06        les di, ptr [bp + 6]
3A1C  26 8A 45 0B     mov al, byte ptr es:[di + 0xb]
3A20  98              cwde
3A21  8B D0           mov dx, ax
3A23  B8 26 00        mov ax, 0x26
3A26  2B C2           sub ax, dx
3A28  2B C1           sub ax, cx
3A2A  26 88 45 0D     mov byte ptr es:[di + 0xd], al
loc_3A2E:
3A2E  EB 1A           jmp 0x3a4a
loc_3A30:
3A30  E8 6D DF        call 0x19a0
3A33  8B C8           mov cx, ax
3A35  C4 7E 06        les di, ptr [bp + 6]
3A38  26 8A 45 0B     mov al, byte ptr es:[di + 0xb]
3A3C  98              cwde
3A3D  8B D0           mov dx, ax
3A3F  B8 DA FF        mov ax, 0xffda
3A42  2B C2           sub ax, dx
3A44  03 C1           add ax, cx
3A46  26 88 45 0D     mov byte ptr es:[di + 0xd], al
loc_3A4A:
3A4A  E9 C7 00        jmp 0x3b14
loc_3A4D:
3A4D  C4 7E 06        les di, ptr [bp + 6]
3A50  06              push es
3A51  57              push di
3A52  0E              push cs
3A53  E8 F8 E3        call 0x1e4e
3A56  08 C0           or al, al
3A58  74 59           je 0x3ab3
3A5A  6A 00           push 0
3A5C  6A 14           push 0x14
3A5E  C4 7E 06        les di, ptr [bp + 6]
3A61  06              push es
3A62  57              push di
3A63  0E              push cs
3A64  E8 F8 F7        call 0x325f
3A67  50              push ax
3A68  6A 07           push 7
3A6A  C4 7E 06        les di, ptr [bp + 6]
3A6D  06              push es
3A6E  57              push di
3A6F  0E              push cs
3A70  E8 D9 DF        call 0x1a4c
3A73  98              cwde
3A74  8B F8           mov di, ax
3A76  C1 E7 02        shl di, 2
3A79  58              pop ax
3A7A  03 F8           add di, ax
3A7C  8A 85 77 0A     mov al, byte ptr [di + 0xa77]
3A80  30 E4           xor ah, ah
3A82  31 D2           xor dx, dx
3A84  52              push dx
3A85  50              push ax
3A86  9A C0 04 BC 24  call far 24BC:04C0
3A8B  C4 7E 06        les di, ptr [bp + 6]
3A8E  26 88 45 0D     mov byte ptr es:[di + 0xd], al
3A92  6A 28           push 0x28
3A94  06              push es
3A95  57              push di
3A96  0E              push cs
3A97  E8 8F E5        call 0x2029
3A9A  08 C0           or al, al
3A9C  74 13           je 0x3ab1
3A9E  C4 7E 06        les di, ptr [bp + 6]
3AA1  06              push es
3AA2  57              push di
3AA3  0E              push cs
3AA4  E8 25 E4        call 0x1ecc
3AA7  98              cwde
3AA8  F7 D8           neg ax
3AAA  C4 7E 06        les di, ptr [bp + 6]
3AAD  26 88 45 0D     mov byte ptr es:[di + 0xd], al
loc_3AB1:
3AB1  EB 61           jmp 0x3b14
loc_3AB3:
3AB3  C4 7E 06        les di, ptr [bp + 6]
3AB6  06              push es
3AB7  57              push di
3AB8  0E              push cs
3AB9  E8 A3 F7        call 0x325f
3ABC  50              push ax
3ABD  6A 06           push 6
3ABF  C4 7E 06        les di, ptr [bp + 6]
3AC2  06              push es
3AC3  57              push di
3AC4  0E              push cs
3AC5  E8 84 DF        call 0x1a4c
3AC8  98              cwde
3AC9  C1 E0 02        shl ax, 2
3ACC  50              push ax
3ACD  6A 05           push 5
3ACF  C4 7E 06        les di, ptr [bp + 6]
3AD2  06              push es
3AD3  57              push di
3AD4  0E              push cs
3AD5  E8 74 DF        call 0x1a4c
3AD8  98              cwde
3AD9  8B F8           mov di, ax
3ADB  C1 E7 03        shl di, 3
3ADE  58              pop ax
3ADF  03 F8           add di, ax
3AE1  58              pop ax
3AE2  03 F8           add di, ax
3AE4  8A 85 67 0A     mov al, byte ptr [di + 0xa67]
3AE8  C4 7E 06        les di, ptr [bp + 6]
3AEB  26 88 45 0D     mov byte ptr es:[di + 0xd], al
3AEF  81 C7 0D 00     add di, 0xd
3AF3  06              push es
3AF4  57              push di
3AF5  6A 00           push 0
3AF7  6A 00           push 0
3AF9  6A 2A           push 0x2a
3AFB  A0 47 CF        mov al, byte ptr [0xcf47]
3AFE  98              cwde
3AFF  99              cdq
3B00  31 D0           xor ax, dx
3B02  29 D0           sub ax, dx
3B04  D1 E0           shl ax, 1
3B06  99              cdq
3B07  52              push dx
3B08  50              push ax
3B09  9A FA 04 BC 24  call far 24BC:04FA
3B0E  50              push ax
3B0F  9A 02 04 BC 24  call far 24BC:0402
loc_3B14:
3B14  C4 7E 06        les di, ptr [bp + 6]
3B17  06              push es
3B18  57              push di
3B19  0E              push cs
3B1A  E8 29 FD        call 0x3846
loc_3B1D:
3B1D  C9              leave
3B1E  CA 04 00        retf 4

; ---- routine 0AB9:3B21  (found by: call)
sub_3B21:
3B21  55              push bp
3B22  89 E5           mov bp, sp
3B24  C4 7E 06        les di, ptr [bp + 6]
3B27  26 C6 45 13 0D  mov byte ptr es:[di + 0x13], 0xd
3B2C  26 8B 05        mov ax, word ptr es:[di]
3B2F  26 89 45 08     mov word ptr es:[di + 8], ax
3B33  E8 6A DE        call 0x19a0
3B36  05 04 00        add ax, 4
3B39  C4 7E 06        les di, ptr [bp + 6]
3B3C  26 88 45 11     mov byte ptr es:[di + 0x11], al
3B40  26 8A 45 07     mov al, byte ptr es:[di + 7]
3B44  30 E4           xor ah, ah
3B46  50              push ax
3B47  E8 B6 C4        call 0
3B4A  08 C0           or al, al
3B4C  74 08           je 0x3b56
3B4E  C4 7E 06        les di, ptr [bp + 6]
3B51  26 80 45 11 0A  add byte ptr es:[di + 0x11], 0xa
loc_3B56:
3B56  C9              leave
3B57  CA 04 00        retf 4

; ---- routine 0AB9:3B5A  (found by: call)
sub_3B5A:
3B5A  C8 02 00 00     enter 2, 0
3B5E  C4 7E 06        les di, ptr [bp + 6]
3B61  26 FF 75 0E     push word ptr es:[di + 0xe]
3B65  9A 0C 4E 55 1B  call far 1B55:4E0C
3B6A  30 E4           xor ah, ah
3B6C  8B D0           mov dx, ax
3B6E  B8 12 00        mov ax, 0x12
3B71  2B C2           sub ax, dx
3B73  50              push ax
3B74  9A 1C 0D BC 24  call far 24BC:0D1C
3B79  08 C0           or al, al
3B7B  75 0F           jne 0x3b8c
3B7D  6A 04           push 4
3B7F  C4 7E 06        les di, ptr [bp + 6]
3B82  06              push es
3B83  57              push di
3B84  0E              push cs
3B85  E8 C4 DE        call 0x1a4c
3B88  08 C0           or al, al
3B8A  74 33           je 0x3bbf
loc_3B8C:
3B8C  A0 9F D0        mov al, byte ptr [0xd09f]
3B8F  30 E4           xor ah, ah
3B91  6B F8 19        imul di, ax, 0x19
3B94  FF B5 FD CC     push word ptr [di - 0x3303]
3B98  9A 0C 4E 55 1B  call far 1B55:4E0C
3B9D  30 E4           xor ah, ah
3B9F  50              push ax
3BA0  9A 6D 07 2A 23  call far 232A:076D
3BA5  50              push ax
3BA6  C4 7E 06        les di, ptr [bp + 6]
3BA9  26 FF 75 0E     push word ptr es:[di + 0xe]
3BAD  9A 0C 4E 55 1B  call far 1B55:4E0C
3BB2  30 E4           xor ah, ah
3BB4  50              push ax
3BB5  9A 6D 07 2A 23  call far 232A:076D
3BBA  5A              pop dx
3BBB  3B C2           cmp ax, dx
3BBD  7F 04           jg 0x3bc3
loc_3BBF:
3BBF  B0 00           mov al, 0
3BC1  EB 02           jmp 0x3bc5
loc_3BC3:
3BC3  B0 01           mov al, 1
loc_3BC5:
3BC5  88 46 FF        mov byte ptr [bp - 1], al
3BC8  8A 46 FF        mov al, byte ptr [bp - 1]
3BCB  C9              leave
3BCC  CA 04 00        retf 4

; ---- routine 0AB9:3BCF  (found by: call)
sub_3BCF:
3BCF  C8 04 00 00     enter 4, 0
3BD3  8B 7E 04        mov di, word ptr [bp + 4]
3BD6  36 C4 7D 06     les di, ptr ss:[di + 6]
3BDA  26 8B 45 0E     mov ax, word ptr es:[di + 0xe]
3BDE  C1 E0 03        shl ax, 3
3BE1  C4 3E BA D7     les di, ptr [0xd7ba]
3BE5  03 F8           add di, ax
3BE7  89 7E FC        mov word ptr [bp - 4], di
3BEA  8C 46 FE        mov word ptr [bp - 2], es
3BED  8B 7E 04        mov di, word ptr [bp + 4]
3BF0  36 C4 7D 06     les di, ptr ss:[di + 6]
3BF4  06              push es
3BF5  57              push di
3BF6  0E              push cs
3BF7  E8 D2 E2        call 0x1ecc
3BFA  98              cwde
3BFB  8B D0           mov dx, ax
3BFD  8B 7E 04        mov di, word ptr [bp + 4]
3C00  36 C4 7D 06     les di, ptr ss:[di + 6]
3C04  26 8A 45 01     mov al, byte ptr es:[di + 1]
3C08  98              cwde
3C09  F7 E2           mul dx
3C0B  3D F8 FF        cmp ax, 0xfff8
3C0E  7C 08           jl 0x3c18
3C10  E8 8D DD        call 0x19a0
3C13  3D 01 00        cmp ax, 1
3C16  75 10           jne 0x3c28
loc_3C18:
3C18  8B 7E 04        mov di, word ptr [bp + 4]
3C1B  36 C4 7D 06     les di, ptr ss:[di + 6]
3C1F  06              push es
3C20  57              push di
3C21  0E              push cs
3C22  E8 C6 E8        call 0x24eb
3C25  E9 0B 01        jmp 0x3d33
loc_3C28:
3C28  C4 7E FC        les di, ptr [bp - 4]
3C2B  26 8A 45 06     mov al, byte ptr es:[di + 6]
3C2F  3C 03           cmp al, 3
3C31  74 04           je 0x3c37
3C33  3C 04           cmp al, 4
3C35  75 39           jne 0x3c70
loc_3C37:
3C37  6A 01           push 1
3C39  8B 7E 04        mov di, word ptr [bp + 4]
3C3C  36 C4 7D 06     les di, ptr ss:[di + 6]
3C40  06              push es
3C41  57              push di
3C42  0E              push cs
3C43  E8 06 DE        call 0x1a4c
3C46  08 C0           or al, al
3C48  74 16           je 0x3c60
3C4A  8B 7E 04        mov di, word ptr [bp + 4]
3C4D  36 C4 7D 06     les di, ptr ss:[di + 6]
3C51  26 8A 45 07     mov al, byte ptr es:[di + 7]
3C55  30 E4           xor ah, ah
3C57  50              push ax
3C58  06              push es
3C59  57              push di
3C5A  0E              push cs
3C5B  E8 DC EC        call 0x293a
3C5E  EB 0D           jmp 0x3c6d
loc_3C60:
3C60  8B 7E 04        mov di, word ptr [bp + 4]
3C63  36 C4 7D 06     les di, ptr ss:[di + 6]
3C67  06              push es
3C68  57              push di
3C69  0E              push cs
3C6A  E8 7E E8        call 0x24eb
loc_3C6D:
3C6D  E9 C3 00        jmp 0x3d33
loc_3C70:
3C70  3C 07           cmp al, 7
3C72  74 04           je 0x3c78
3C74  3C 08           cmp al, 8
3C76  75 43           jne 0x3cbb
loc_3C78:
3C78  6A 01           push 1
3C7A  8B 7E 04        mov di, word ptr [bp + 4]
3C7D  36 C4 7D 06     les di, ptr ss:[di + 6]
3C81  06              push es
3C82  57              push di
3C83  0E              push cs
3C84  E8 C5 DD        call 0x1a4c
3C87  08 C0           or al, al
3C89  74 21           je 0x3cac
3C8B  6A 03           push 3
3C8D  9A 1C 0D BC 24  call far 24BC:0D1C
3C92  08 C0           or al, al
3C94  75 16           jne 0x3cac
3C96  8B 7E 04        mov di, word ptr [bp + 4]
3C99  36 C4 7D 06     les di, ptr ss:[di + 6]
3C9D  26 8A 45 07     mov al, byte ptr es:[di + 7]
3CA1  30 E4           xor ah, ah
3CA3  50              push ax
3CA4  06              push es
3CA5  57              push di
3CA6  0E              push cs
3CA7  E8 90 EC        call 0x293a
3CAA  EB 0D           jmp 0x3cb9
loc_3CAC:
3CAC  8B 7E 04        mov di, word ptr [bp + 4]
3CAF  36 C4 7D 06     les di, ptr ss:[di + 6]
3CB3  06              push es
3CB4  57              push di
3CB5  0E              push cs
3CB6  E8 32 E8        call 0x24eb
loc_3CB9:
3CB9  EB 78           jmp 0x3d33
loc_3CBB:
3CBB  3C 0A           cmp al, 0xa
3CBD  74 04           je 0x3cc3
3CBF  3C 0B           cmp al, 0xb
3CC1  75 16           jne 0x3cd9
loc_3CC3:
3CC3  8B 7E 04        mov di, word ptr [bp + 4]
3CC6  36 C4 7D 06     les di, ptr ss:[di + 6]
3CCA  26 8A 45 07     mov al, byte ptr es:[di + 7]
3CCE  30 E4           xor ah, ah
3CD0  50              push ax
3CD1  06              push es
3CD2  57              push di
3CD3  0E              push cs
3CD4  E8 63 EC        call 0x293a
3CD7  EB 5A           jmp 0x3d33
loc_3CD9:
3CD9  3C 0D           cmp al, 0xd
3CDB  74 04           je 0x3ce1
3CDD  3C 0C           cmp al, 0xc
3CDF  75 45           jne 0x3d26
loc_3CE1:
3CE1  C4 7E FC        les di, ptr [bp - 4]
3CE4  26 80 7D 06 0C  cmp byte ptr es:[di + 6], 0xc
3CE9  B0 00           mov al, 0
3CEB  75 01           jne 0x3cee
3CED  40              inc ax
loc_3CEE:
3CEE  98              cwde
3CEF  8B F8           mov di, ax
3CF1  8A 85 80 0A     mov al, byte ptr [di + 0xa80]
3CF5  30 E4           xor ah, ah
3CF7  50              push ax
3CF8  9A 1C 0D BC 24  call far 24BC:0D1C
3CFD  08 C0           or al, al
3CFF  74 0F           je 0x3d10
3D01  8B 7E 04        mov di, word ptr [bp + 4]
3D04  36 C4 7D 06     les di, ptr ss:[di + 6]
3D08  06              push es
3D09  57              push di
3D0A  0E              push cs
3D0B  E8 DD E7        call 0x24eb
3D0E  EB 14           jmp 0x3d24
loc_3D10:
3D10  8B 7E 04        mov di, word ptr [bp + 4]
3D13  36 C4 7D 06     les di, ptr ss:[di + 6]
3D17  26 8A 45 07     mov al, byte ptr es:[di + 7]
3D1B  30 E4           xor ah, ah
3D1D  50              push ax
3D1E  06              push es
3D1F  57              push di
3D20  0E              push cs
3D21  E8 16 EC        call 0x293a
loc_3D24:
3D24  EB 0D           jmp 0x3d33
loc_3D26:
3D26  8B 7E 04        mov di, word ptr [bp + 4]
3D29  36 C4 7D 06     les di, ptr ss:[di + 6]
3D2D  06              push es
3D2E  57              push di
3D2F  0E              push cs
3D30  E8 B8 E7        call 0x24eb
loc_3D33:
3D33  C9              leave
3D34  C2 02 00        ret 2

