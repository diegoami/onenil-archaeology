; 1-095.EXE (One-Nil 95), code segment 01EE (image offsets 01EE0..06E3F), part 4 of 7
; packed 1-095.EXE sha256 f659fb2d334500d6901fc8d6a0f06c85c0ccda2eb4a3035ae3bb0a0004d79192 (LZEXE 0.91)
; unpacked (tools/static/unlzexe.py) sha256 8df646e017e0965a5d90a58181ca764219ad847833aad0b6cb58fc53372bfb2c
; tool: capstone 5.0.9 (pip package; core library 5.0.1280) (CS_ARCH_X86, CS_MODE_16), recursive descent from the entry point, far calls and near calls/jumps, then routine prologues (55 89 E5 / 55 8B EC / C8 iw 00) in what remains; tools/static/listing.py
; addresses are SEGMENT:OFFSET with SEGMENT the image paragraph before relocation; image offset = SEGMENT*16+OFFSET
; ---- routine 01EE:24E4  (found by: call)
sub_24E4:
24E4  C8 0C 00 00     enter 0xc, 0
24E8  C7 46 FE 01 00  mov word ptr [bp - 2], 1
24ED  EB 03           jmp 0x24f2
loc_24EF:
24EF  FF 46 FE        inc word ptr [bp - 2]
loc_24F2:
24F2  8B 7E FE        mov di, word ptr [bp - 2]
24F5  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
24F9  30 E4           xor ah, ah
24FB  50              push ax
24FC  E8 BA FE        call 0x23b9
24FF  81 7E FE B0 00  cmp word ptr [bp - 2], 0xb0
2504  75 E9           jne 0x24ef
2506  C7 46 FE 01 00  mov word ptr [bp - 2], 1
250B  EB 03           jmp 0x2510
loc_250D:
250D  FF 46 FE        inc word ptr [bp - 2]
loc_2510:
2510  6B 46 FE 3E     imul ax, word ptr [bp - 2], 0x3e
2514  C4 3E C2 D7     les di, ptr [0xd7c2]
2518  03 F8           add di, ax
251A  26 83 7D F2 00  cmp word ptr es:[di - 0xe], 0
251F  75 03           jne 0x2524
2521  E9 8C 00        jmp 0x25b0
loc_2524:
2524  6B 46 FE 3E     imul ax, word ptr [bp - 2], 0x3e
2528  C4 3E C2 D7     les di, ptr [0xd7c2]
252C  03 F8           add di, ax
252E  26 8B 45 F2     mov ax, word ptr es:[di - 0xe]
2532  C1 E0 02        shl ax, 2
2535  C4 3E C8 DC     les di, ptr [0xdcc8]
2539  03 F8           add di, ax
253B  89 7E F8        mov word ptr [bp - 8], di
253E  8C 46 FA        mov word ptr [bp - 6], es
2541  6B 46 FE 3E     imul ax, word ptr [bp - 2], 0x3e
2545  C4 3E C2 D7     les di, ptr [0xd7c2]
2549  03 F8           add di, ax
254B  81 C7 C2 FF     add di, 0xffc2
254F  89 7E F4        mov word ptr [bp - 0xc], di
2552  8C 46 F6        mov word ptr [bp - 0xa], es
2555  C4 7E F8        les di, ptr [bp - 8]
2558  26 8A 45 02     mov al, byte ptr es:[di + 2]
255C  30 E4           xor ah, ah
255E  89 46 FC        mov word ptr [bp - 4], ax
2561  6A 00           push 0
2563  6A 01           push 1
2565  6A 20           push 0x20
2567  9A 6D 07 1A 23  call far 231A:076D
256C  50              push ax
256D  6A 20           push 0x20
256F  9A 6D 07 1A 23  call far 231A:076D
2574  8B D8           mov bx, ax
2576  C4 7E F4        les di, ptr [bp - 0xc]
2579  26 8A 45 33     mov al, byte ptr es:[di + 0x33]
257D  30 E4           xor ah, ah
257F  8B D0           mov dx, ax
2581  B8 B1 00        mov ax, 0xb1
2584  2B C2           sub ax, dx
2586  8B D0           mov dx, ax
2588  8B 46 FC        mov ax, word ptr [bp - 4]
258B  8B F0           mov si, ax
258D  D1 E0           shl ax, 1
258F  01 F0           add ax, si
2591  05 03 00        add ax, 3
2594  03 C2           add ax, dx
2596  99              cdq
2597  B9 04 00        mov cx, 4
259A  F7 F9           idiv cx
259C  03 C3           add ax, bx
259E  5A              pop dx
259F  2B C2           sub ax, dx
25A1  99              cdq
25A2  52              push dx
25A3  50              push ax
25A4  9A C0 04 AC 24  call far 24AC:04C0
25A9  C4 7E F8        les di, ptr [bp - 8]
25AC  26 88 45 02     mov byte ptr es:[di + 2], al
loc_25B0:
25B0  81 7E FE B0 00  cmp word ptr [bp - 2], 0xb0
25B5  74 03           je 0x25ba
25B7  E9 53 FF        jmp 0x250d
loc_25BA:
25BA  C9              leave
25BB  C3              ret

; ---- routine 01EE:25BC  (found by: call)
sub_25BC:
25BC  55              push bp
25BD  89 E5           mov bp, sp
25BF  6B 46 08 3E     imul ax, word ptr [bp + 8], 0x3e
25C3  C4 3E C2 D7     les di, ptr [0xd7c2]
25C7  03 F8           add di, ax
25C9  26 8A 45 F6     mov al, byte ptr es:[di - 0xa]
25CD  30 E4           xor ah, ah
25CF  03 46 06        add ax, word ptr [bp + 6]
25D2  3D FF 00        cmp ax, 0xff
25D5  76 11           jbe 0x25e8
25D7  6B 46 08 3E     imul ax, word ptr [bp + 8], 0x3e
25DB  C4 3E C2 D7     les di, ptr [0xd7c2]
25DF  03 F8           add di, ax
25E1  26 C6 45 F6 FF  mov byte ptr es:[di - 0xa], 0xff
25E6  EB 11           jmp 0x25f9
loc_25E8:
25E8  8A 56 06        mov dl, byte ptr [bp + 6]
25EB  6B 46 08 3E     imul ax, word ptr [bp + 8], 0x3e
25EF  C4 3E C2 D7     les di, ptr [0xd7c2]
25F3  03 F8           add di, ax
25F5  26 00 55 F6     add byte ptr es:[di - 0xa], dl
loc_25F9:
25F9  C9              leave
25FA  C2 06 00        ret 6

; ---- routine 01EE:25FD  (found by: call)
sub_25FD:
25FD  C8 02 00 00     enter 2, 0
2601  C7 46 FE 01 00  mov word ptr [bp - 2], 1
2606  EB 03           jmp 0x260b
loc_2608:
2608  FF 46 FE        inc word ptr [bp - 2]
loc_260B:
260B  8B 7E FE        mov di, word ptr [bp - 2]
260E  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
2612  30 E4           xor ah, ah
2614  50              push ax
2615  9A EE 1A 51 1B  call far 1B51:1AEE
261A  08 C0           or al, al
261C  74 2C           je 0x264a
261E  8B 7E FE        mov di, word ptr [bp - 2]
2621  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
2625  30 E4           xor ah, ah
2627  50              push ax
2628  6A 0F           push 0xf
262A  9A 6D 07 1A 23  call far 231A:076D
262F  8B F8           mov di, ax
2631  8A 85 21 02     mov al, byte ptr [di + 0x221]
2635  30 E4           xor ah, ah
2637  D1 E8           shr ax, 1
2639  8B D0           mov dx, ax
263B  B8 81 00        mov ax, 0x81
263E  2B 46 FE        sub ax, word ptr [bp - 2]
2641  03 C2           add ax, dx
2643  50              push ax
2644  55              push bp
2645  E8 74 FF        call 0x25bc
2648  EB 28           jmp 0x2672
loc_264A:
264A  8B 7E FE        mov di, word ptr [bp - 2]
264D  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
2651  30 E4           xor ah, ah
2653  50              push ax
2654  6A 0F           push 0xf
2656  9A 6D 07 1A 23  call far 231A:076D
265B  8B F8           mov di, ax
265D  8A 85 21 02     mov al, byte ptr [di + 0x221]
2661  30 E4           xor ah, ah
2663  8B D0           mov dx, ax
2665  B8 81 00        mov ax, 0x81
2668  2B 46 FE        sub ax, word ptr [bp - 2]
266B  03 C2           add ax, dx
266D  50              push ax
266E  55              push bp
266F  E8 4A FF        call 0x25bc
loc_2672:
2672  83 7E FE 10     cmp word ptr [bp - 2], 0x10
2676  75 90           jne 0x2608
2678  C7 46 FE 11 00  mov word ptr [bp - 2], 0x11
267D  EB 03           jmp 0x2682
loc_267F:
267F  FF 46 FE        inc word ptr [bp - 2]
loc_2682:
2682  8A 46 FE        mov al, byte ptr [bp - 2]
2685  B4 01           mov ah, 1
2687  BA 20 00        mov dx, 0x20
268A  9A 1F 0E B9 26  call far 26B9:0E1F
268F  8B FA           mov di, dx
2691  84 85 32 02     test byte ptr [di + 0x232], al
2695  74 1A           je 0x26b1
2697  8B 7E FE        mov di, word ptr [bp - 2]
269A  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
269E  30 E4           xor ah, ah
26A0  50              push ax
26A1  B8 81 00        mov ax, 0x81
26A4  2B 46 FE        sub ax, word ptr [bp - 2]
26A7  2D 06 00        sub ax, 6
26AA  50              push ax
26AB  55              push bp
26AC  E8 0D FF        call 0x25bc
26AF  EB 44           jmp 0x26f5
loc_26B1:
26B1  8A 46 FE        mov al, byte ptr [bp - 2]
26B4  B4 01           mov ah, 1
26B6  BA 20 00        mov dx, 0x20
26B9  9A 1F 0E B9 26  call far 26B9:0E1F
26BE  8B FA           mov di, dx
26C0  84 85 52 02     test byte ptr [di + 0x252], al
26C4  74 1A           je 0x26e0
26C6  8B 7E FE        mov di, word ptr [bp - 2]
26C9  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
26CD  30 E4           xor ah, ah
26CF  50              push ax
26D0  B8 81 00        mov ax, 0x81
26D3  2B 46 FE        sub ax, word ptr [bp - 2]
26D6  05 06 00        add ax, 6
26D9  50              push ax
26DA  55              push bp
26DB  E8 DE FE        call 0x25bc
26DE  EB 15           jmp 0x26f5
loc_26E0:
26E0  8B 7E FE        mov di, word ptr [bp - 2]
26E3  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
26E7  30 E4           xor ah, ah
26E9  50              push ax
26EA  B8 81 00        mov ax, 0x81
26ED  2B 46 FE        sub ax, word ptr [bp - 2]
26F0  50              push ax
26F1  55              push bp
26F2  E8 C7 FE        call 0x25bc
loc_26F5:
26F5  83 7E FE 50     cmp word ptr [bp - 2], 0x50
26F9  75 84           jne 0x267f
26FB  C7 46 FE 51 00  mov word ptr [bp - 2], 0x51
2700  EB 03           jmp 0x2705
loc_2702:
2702  FF 46 FE        inc word ptr [bp - 2]
loc_2705:
2705  8B 7E FE        mov di, word ptr [bp - 2]
2708  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
270C  30 E4           xor ah, ah
270E  50              push ax
270F  9A EE 1A 51 1B  call far 1B51:1AEE
2714  08 C0           or al, al
2716  74 17           je 0x272f
2718  8B 7E FE        mov di, word ptr [bp - 2]
271B  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
271F  30 E4           xor ah, ah
2721  50              push ax
2722  B8 81 00        mov ax, 0x81
2725  2B 46 FE        sub ax, word ptr [bp - 2]
2728  50              push ax
2729  55              push bp
272A  E8 8F FE        call 0x25bc
272D  EB 3B           jmp 0x276a
loc_272F:
272F  8B 7E FE        mov di, word ptr [bp - 2]
2732  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
2736  30 E4           xor ah, ah
2738  50              push ax
2739  6A 0F           push 0xf
273B  9A 6D 07 1A 23  call far 231A:076D
2740  8B F8           mov di, ax
2742  8A 85 21 02     mov al, byte ptr [di + 0x221]
2746  30 E4           xor ah, ah
2748  50              push ax
2749  8B 7E FE        mov di, word ptr [bp - 2]
274C  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
2750  30 E4           xor ah, ah
2752  C4 3E B6 D7     les di, ptr [0xd7b6]
2756  03 F8           add di, ax
2758  26 8A 45 FF     mov al, byte ptr es:[di - 1]
275C  50              push ax
275D  9A 00 00 51 1B  call far 1B51:0000
2762  5A              pop dx
2763  03 C2           add ax, dx
2765  50              push ax
2766  55              push bp
2767  E8 52 FE        call 0x25bc
loc_276A:
276A  83 7E FE 60     cmp word ptr [bp - 2], 0x60
276E  75 92           jne 0x2702
2770  C7 46 FE 61 00  mov word ptr [bp - 2], 0x61
2775  EB 03           jmp 0x277a
loc_2777:
2777  FF 46 FE        inc word ptr [bp - 2]
loc_277A:
277A  8B 7E FE        mov di, word ptr [bp - 2]
277D  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
2781  30 E4           xor ah, ah
2783  50              push ax
2784  6A 0F           push 0xf
2786  9A 6D 07 1A 23  call far 231A:076D
278B  8B F8           mov di, ax
278D  8A 85 21 02     mov al, byte ptr [di + 0x221]
2791  30 E4           xor ah, ah
2793  50              push ax
2794  8B 7E FE        mov di, word ptr [bp - 2]
2797  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
279B  30 E4           xor ah, ah
279D  C4 3E B6 D7     les di, ptr [0xd7b6]
27A1  03 F8           add di, ax
27A3  26 8A 45 FF     mov al, byte ptr es:[di - 1]
27A7  50              push ax
27A8  9A 00 00 51 1B  call far 1B51:0000
27AD  5A              pop dx
27AE  03 C2           add ax, dx
27B0  50              push ax
27B1  55              push bp
27B2  E8 07 FE        call 0x25bc
27B5  81 7E FE B0 00  cmp word ptr [bp - 2], 0xb0
27BA  75 BB           jne 0x2777
27BC  E8 0F FB        call 0x22ce
27BF  C7 46 FE 01 00  mov word ptr [bp - 2], 1
27C4  EB 03           jmp 0x27c9
loc_27C6:
27C6  FF 46 FE        inc word ptr [bp - 2]
loc_27C9:
27C9  6B 46 FE 3E     imul ax, word ptr [bp - 2], 0x3e
27CD  C4 3E C2 D7     les di, ptr [0xd7c2]
27D1  03 F8           add di, ax
27D3  26 C6 45 F6 00  mov byte ptr es:[di - 0xa], 0
27D8  81 7E FE B0 00  cmp word ptr [bp - 2], 0xb0
27DD  75 E7           jne 0x27c6
27DF  C9              leave
27E0  C3              ret

; ---- routine 01EE:27E1  (found by: call, far)
sub_27E1:
27E1  C8 0A 00 00     enter 0xa, 0
27E5  8B 7E 06        mov di, word ptr [bp + 6]
27E8  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
27EC  30 E4           xor ah, ah
27EE  6B C0 3E        imul ax, ax, 0x3e
27F1  C4 3E C2 D7     les di, ptr [0xd7c2]
27F5  03 F8           add di, ax
27F7  81 C7 C2 FF     add di, 0xffc2
27FB  89 7E FA        mov word ptr [bp - 6], di
27FE  8C 46 FC        mov word ptr [bp - 4], es
2801  C7 46 FE 01 00  mov word ptr [bp - 2], 1
2806  EB 03           jmp 0x280b
loc_2808:
2808  FF 46 FE        inc word ptr [bp - 2]
loc_280B:
280B  8B 46 FE        mov ax, word ptr [bp - 2]
280E  D1 E0           shl ax, 1
2810  C4 7E FA        les di, ptr [bp - 6]
2813  03 F8           add di, ax
2815  26 83 7D FE 00  cmp word ptr es:[di - 2], 0
281A  74 39           je 0x2855
281C  8B 46 FE        mov ax, word ptr [bp - 2]
281F  D1 E0           shl ax, 1
2821  C4 7E FA        les di, ptr [bp - 6]
2824  03 F8           add di, ax
2826  26 6B 45 FE 0F  imul ax, word ptr es:[di - 2], 0xf
282B  C4 3E BE D7     les di, ptr [0xd7be]
282F  03 F8           add di, ax
2831  89 7E F6        mov word ptr [bp - 0xa], di
2834  8C 46 F8        mov word ptr [bp - 8], es
2837  26 8A 45 06     mov al, byte ptr es:[di + 6]
283B  98              cwde
283C  99              cdq
283D  B9 02 00        mov cx, 2
2840  F7 F9           idiv cx
2842  99              cdq
2843  52              push dx
2844  50              push ax
2845  6A 00           push 0
2847  6A 01           push 1
2849  9A C0 04 AC 24  call far 24AC:04C0
284E  C4 7E F6        les di, ptr [bp - 0xa]
2851  26 88 45 06     mov byte ptr es:[di + 6], al
loc_2855:
2855  83 7E FE 14     cmp word ptr [bp - 2], 0x14
2859  75 AD           jne 0x2808
285B  6B 46 06 5E     imul ax, word ptr [bp + 6], 0x5e
285F  C4 3E C4 DC     les di, ptr [0xdcc4]
2863  03 F8           add di, ax
2865  81 C7 A2 FF     add di, 0xffa2
2869  06              push es
286A  57              push di
286B  6A 5E           push 0x5e
286D  6A 00           push 0
286F  9A 22 02 AC 24  call far 24AC:0222
2874  8B 7E 06        mov di, word ptr [bp + 6]
2877  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
287B  30 E4           xor ah, ah
287D  50              push ax
287E  9A DB 34 51 1B  call far 1B51:34DB
2883  8B C8           mov cx, ax
2885  8B DA           mov bx, dx
2887  6B 46 06 5E     imul ax, word ptr [bp + 6], 0x5e
288B  C4 3E C4 DC     les di, ptr [0xdcc4]
288F  03 F8           add di, ax
2891  26 89 4D F4     mov word ptr es:[di - 0xc], cx
2895  26 89 5D F6     mov word ptr es:[di - 0xa], bx
2899  8B 46 06        mov ax, word ptr [bp + 6]
289C  8B F0           mov si, ax
289E  D1 E0           shl ax, 1
28A0  01 F0           add ax, si
28A2  C4 3E D2 D7     les di, ptr [0xd7d2]
28A6  03 F8           add di, ax
28A8  81 C7 18 00     add di, 0x18
28AC  89 7E FA        mov word ptr [bp - 6], di
28AF  8C 46 FC        mov word ptr [bp - 4], es
28B2  C4 3E D2 D7     les di, ptr [0xd7d2]
28B6  26 8A 05        mov al, byte ptr es:[di]
28B9  30 E4           xor ah, ah
28BB  40              inc ax
28BC  C4 7E FA        les di, ptr [bp - 6]
28BF  26 88 45 02     mov byte ptr es:[di + 2], al
28C3  26 C6 45 01 00  mov byte ptr es:[di + 1], 0
28C8  8B 7E 06        mov di, word ptr [bp + 6]
28CB  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
28CF  30 E4           xor ah, ah
28D1  50              push ax
28D2  9A 1D 26 51 1B  call far 1B51:261D
28D7  C4 7E FA        les di, ptr [bp - 6]
28DA  26 88 05        mov byte ptr es:[di], al
28DD  C9              leave
28DE  CA 02 00        retf 2

; ---- routine 01EE:28E1  (found by: call)
sub_28E1:
28E1  C8 06 00 00     enter 6, 0
28E5  8B 46 04        mov ax, word ptr [bp + 4]
28E8  C1 E0 02        shl ax, 2
28EB  C4 3E C8 DC     les di, ptr [0xdcc8]
28EF  03 F8           add di, ax
28F1  89 7E FA        mov word ptr [bp - 6], di
28F4  8C 46 FC        mov word ptr [bp - 4], es
28F7  26 80 3D 00     cmp byte ptr es:[di], 0
28FB  75 07           jne 0x2904
28FD  C7 46 FE 07 00  mov word ptr [bp - 2], 7
2902  EB 13           jmp 0x2917
loc_2904:
2904  C4 7E FA        les di, ptr [bp - 6]
2907  26 8A 05        mov al, byte ptr es:[di]
290A  30 E4           xor ah, ah
290C  50              push ax
290D  9A 02 0E 51 1B  call far 1B51:0E02
2912  30 E4           xor ah, ah
2914  89 46 FE        mov word ptr [bp - 2], ax
loc_2917:
2917  8B 46 FE        mov ax, word ptr [bp - 2]
291A  C9              leave
291B  C2 02 00        ret 2

; ---- routine 01EE:291E  (found by: call)
sub_291E:
291E  C8 06 00 00     enter 6, 0
2922  C4 3E D2 D7     les di, ptr [0xd7d2]
2926  89 7E FA        mov word ptr [bp - 6], di
2929  8C 46 FC        mov word ptr [bp - 4], es
292C  BF 12 52        mov di, 0x5212
292F  1E              push ds
2930  57              push di
2931  BF 5C DD        mov di, 0xdd5c
2934  1E              push ds
2935  57              push di
2936  9A 2F 05 1A 23  call far 231A:052F
293B  BF DA 4E        mov di, 0x4eda
293E  1E              push ds
293F  57              push di
2940  BF 5C DD        mov di, 0xdd5c
2943  1E              push ds
2944  57              push di
2945  9A 2F 05 1A 23  call far 231A:052F
294A  C4 3E 5C DD     les di, ptr [0xdd5c]
294E  06              push es
294F  57              push di
2950  C4 3E 58 DD     les di, ptr [0xdd58]
2954  06              push es
2955  57              push di
2956  68 A0 0F        push 0xfa0
2959  9A 12 0A B9 26  call far 26B9:0A12
295E  9A 9B 09 1A 23  call far 231A:099B
2963  8B 7E 04        mov di, word ptr [bp + 4]
2966  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
296A  30 E4           xor ah, ah
296C  89 46 FE        mov word ptr [bp - 2], ax
296F  8B 46 04        mov ax, word ptr [bp + 4]
2972  D1 E0           shl ax, 1
2974  C4 7E FA        les di, ptr [bp - 6]
2977  03 F8           add di, ax
2979  26 FF 75 03     push word ptr es:[di + 3]
297D  E8 61 FF        call 0x28e1
2980  50              push ax
2981  8B 46 04        mov ax, word ptr [bp + 4]
2984  D1 E0           shl ax, 1
2986  C4 7E FA        les di, ptr [bp - 6]
2989  03 F8           add di, ax
298B  26 6B 45 03 0B  imul ax, word ptr es:[di + 3], 0xb
2990  C4 3E CC DC     les di, ptr [0xdccc]
2994  03 F8           add di, ax
2996  06              push es
2997  57              push di
2998  6A 01           push 1
299A  6A 01           push 1
299C  BF 5C DD        mov di, 0xdd5c
299F  1E              push ds
29A0  57              push di
29A1  9A 1B 04 1A 23  call far 231A:041B
29A6  6B 46 FE 3E     imul ax, word ptr [bp - 2], 0x3e
29AA  C4 3E C2 D7     les di, ptr [0xd7c2]
29AE  03 F8           add di, ax
29B0  26 C6 45 FC 00  mov byte ptr es:[di - 4], 0
29B5  FF 76 04        push word ptr [bp + 4]
29B8  0E              push cs
29B9  E8 CE 0C        call 0x368a
29BC  8B 7E 04        mov di, word ptr [bp + 4]
29BF  C6 85 B9 DC 00  mov byte ptr [di - 0x2347], 0
29C4  FF 76 FE        push word ptr [bp - 2]
29C7  E8 EF F9        call 0x23b9
29CA  C9              leave
29CB  C2 02 00        ret 2

; ---- routine 01EE:29CE  (found by: call)
sub_29CE:
29CE  C8 08 00 00     enter 8, 0
29D2  C4 3E D2 D7     les di, ptr [0xd7d2]
29D6  26 80 BD F3 00 00 cmp byte ptr es:[di + 0xf3], 0
29DC  75 03           jne 0x29e1
29DE  E9 CF 00        jmp 0x2ab0
loc_29E1:
29E1  8B 7E 04        mov di, word ptr [bp + 4]
29E4  80 BD B9 DC 00  cmp byte ptr [di - 0x2347], 0
29E9  75 03           jne 0x29ee
29EB  E9 C2 00        jmp 0x2ab0
loc_29EE:
29EE  8B 46 04        mov ax, word ptr [bp + 4]
29F1  8B F0           mov si, ax
29F3  D1 E0           shl ax, 1
29F5  01 F0           add ax, si
29F7  C4 3E D2 D7     les di, ptr [0xd7d2]
29FB  03 F8           add di, ax
29FD  81 C7 18 00     add di, 0x18
2A01  89 7E FC        mov word ptr [bp - 4], di
2A04  8C 46 FE        mov word ptr [bp - 2], es
2A07  26 80 7D 01 14  cmp byte ptr es:[di + 1], 0x14
2A0C  73 07           jae 0x2a15
2A0E  26 FE 45 01     inc byte ptr es:[di + 1]
2A12  E9 9B 00        jmp 0x2ab0
loc_2A15:
2A15  C4 3E D2 D7     les di, ptr [0xd7d2]
2A19  26 8A 05        mov al, byte ptr es:[di]
2A1C  C4 7E FC        les di, ptr [bp - 4]
2A1F  26 3A 45 02     cmp al, byte ptr es:[di + 2]
2A23  75 17           jne 0x2a3c
2A25  8B 7E 04        mov di, word ptr [bp + 4]
2A28  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
2A2C  30 E4           xor ah, ah
2A2E  50              push ax
2A2F  9A 1D 26 51 1B  call far 1B51:261D
2A34  C4 7E FC        les di, ptr [bp - 4]
2A37  26 88 05        mov byte ptr es:[di], al
2A3A  EB 74           jmp 0x2ab0
loc_2A3C:
2A3C  C4 3E D2 D7     les di, ptr [0xd7d2]
2A40  26 80 3D 3A     cmp byte ptr es:[di], 0x3a
2A44  75 6A           jne 0x2ab0
2A46  8B 7E 04        mov di, word ptr [bp + 4]
2A49  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
2A4D  30 E4           xor ah, ah
2A4F  50              push ax
2A50  9A 1D 26 51 1B  call far 1B51:261D
2A55  05 05 00        add ax, 5
2A58  8B D0           mov dx, ax
2A5A  C4 7E FC        les di, ptr [bp - 4]
2A5D  26 8A 05        mov al, byte ptr es:[di]
2A60  30 E4           xor ah, ah
2A62  3B C2           cmp ax, dx
2A64  7E 4A           jle 0x2ab0
2A66  8B 7E 04        mov di, word ptr [bp + 4]
2A69  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
2A6D  30 E4           xor ah, ah
2A6F  6B C0 3E        imul ax, ax, 0x3e
2A72  C4 3E C2 D7     les di, ptr [0xd7c2]
2A76  03 F8           add di, ax
2A78  26 80 7D F8 03  cmp byte ptr es:[di - 8], 3
2A7D  76 31           jbe 0x2ab0
2A7F  FF 76 04        push word ptr [bp + 4]
2A82  E8 99 FE        call 0x291e
2A85  8B 46 04        mov ax, word ptr [bp + 4]
2A88  D1 E0           shl ax, 1
2A8A  C4 3E D2 D7     les di, ptr [0xd7d2]
2A8E  03 F8           add di, ax
2A90  26 8B 7D 03     mov di, word ptr es:[di + 3]
2A94  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
2A98  30 E4           xor ah, ah
2A9A  C1 E0 02        shl ax, 2
2A9D  C4 3E C8 DC     les di, ptr [0xdcc8]
2AA1  03 F8           add di, ax
2AA3  26 8A 45 02     mov al, byte ptr es:[di + 2]
2AA7  30 E4           xor ah, ah
2AA9  D1 E8           shr ax, 1
2AAB  40              inc ax
2AAC  26 88 45 02     mov byte ptr es:[di + 2], al
loc_2AB0:
2AB0  C9              leave
2AB1  C2 02 00        ret 2

; ---- routine 01EE:2AB4  (found by: call)
sub_2AB4:
2AB4  C8 0C 00 00     enter 0xc, 0
2AB8  C4 3E D2 D7     les di, ptr [0xd7d2]
2ABC  26 8A 45 03     mov al, byte ptr es:[di + 3]
2AC0  30 E4           xor ah, ah
2AC2  89 46 F8        mov word ptr [bp - 8], ax
2AC5  B8 01 00        mov ax, 1
2AC8  3B 46 F8        cmp ax, word ptr [bp - 8]
2ACB  77 49           ja 0x2b16
2ACD  89 46 FE        mov word ptr [bp - 2], ax
2AD0  EB 03           jmp 0x2ad5
loc_2AD2:
2AD2  FF 46 FE        inc word ptr [bp - 2]
loc_2AD5:
2AD5  8B 7E FE        mov di, word ptr [bp - 2]
2AD8  80 BD B9 DC 00  cmp byte ptr [di - 0x2347], 0
2ADD  74 2F           je 0x2b0e
2ADF  8B 7E FE        mov di, word ptr [bp - 2]
2AE2  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
2AE6  30 E4           xor ah, ah
2AE8  6B C0 3E        imul ax, ax, 0x3e
2AEB  C4 3E C2 D7     les di, ptr [0xd7c2]
2AEF  03 F8           add di, ax
2AF1  81 C7 C2 FF     add di, 0xffc2
2AF5  26 80 7D 37 04  cmp byte ptr es:[di + 0x37], 4
2AFA  7E 08           jle 0x2b04
2AFC  FF 76 FE        push word ptr [bp - 2]
2AFF  E8 1C FE        call 0x291e
2B02  EB 0A           jmp 0x2b0e
loc_2B04:
2B04  FF 76 FE        push word ptr [bp - 2]
2B07  6A 00           push 0
2B09  9A C0 6E 51 1B  call far 1B51:6EC0
loc_2B0E:
2B0E  8B 46 FE        mov ax, word ptr [bp - 2]
2B11  3B 46 F8        cmp ax, word ptr [bp - 8]
2B14  75 BC           jne 0x2ad2
loc_2B16:
2B16  C9              leave
2B17  C3              ret

; ---- routine 01EE:2B18  (found by: call)
sub_2B18:
2B18  C8 EC 0A 00     enter 0xaec, 0
2B1C  8D BE 00 F6     lea di, [bp - 0xa00]
2B20  16              push ss
2B21  57              push di
2B22  68 00 0A        push 0xa00
2B25  6A 00           push 0
2B27  9A 22 02 AC 24  call far 24AC:0222
2B2C  8D BE 1C F5     lea di, [bp - 0xae4]
2B30  16              push ss
2B31  57              push di
2B32  68 80 00        push 0x80
2B35  6A 00           push 0
2B37  9A 22 02 AC 24  call far 24AC:0222
2B3C  C7 86 1A F5 01 00 mov word ptr [bp - 0xae6], 1
2B42  EB 04           jmp 0x2b48
loc_2B44:
2B44  FF 86 1A F5     inc word ptr [bp - 0xae6]
loc_2B48:
2B48  6B 86 1A F5 3E  imul ax, word ptr [bp - 0xae6], 0x3e
2B4D  C4 3E C2 D7     les di, ptr [0xd7c2]
2B51  03 F8           add di, ax
2B53  81 C7 C2 FF     add di, 0xffc2
2B57  81 C7 3B 00     add di, 0x3b
2B5B  06              push es
2B5C  57              push di
2B5D  6A 03           push 3
2B5F  6A 00           push 0
2B61  9A 22 02 AC 24  call far 24AC:0222
2B66  8B 86 1A F5     mov ax, word ptr [bp - 0xae6]
2B6A  C4 3E B6 D7     les di, ptr [0xd7b6]
2B6E  03 F8           add di, ax
2B70  26 8A 45 FF     mov al, byte ptr es:[di - 1]
2B74  30 E4           xor ah, ah
2B76  8B F8           mov di, ax
2B78  FE 83 1B F5     inc byte ptr [bp + di - 0xae5]
2B7C  FF B6 1A F5     push word ptr [bp - 0xae6]
2B80  9A EE 1A 51 1B  call far 1B51:1AEE
2B85  08 C0           or al, al
2B87  74 24           je 0x2bad
2B89  8A 96 1A F5     mov dl, byte ptr [bp - 0xae6]
2B8D  8B 86 1A F5     mov ax, word ptr [bp - 0xae6]
2B91  C4 3E B6 D7     les di, ptr [0xd7b6]
2B95  03 F8           add di, ax
2B97  26 8A 45 FF     mov al, byte ptr es:[di - 1]
2B9B  30 E4           xor ah, ah
2B9D  8B F8           mov di, ax
2B9F  8A 83 1B F5     mov al, byte ptr [bp + di - 0xae5]
2BA3  30 E4           xor ah, ah
2BA5  8B F8           mov di, ax
2BA7  88 93 9B F5     mov byte ptr [bp + di - 0xa65], dl
2BAB  EB 39           jmp 0x2be6
loc_2BAD:
2BAD  8A 8E 1A F5     mov cl, byte ptr [bp - 0xae6]
2BB1  8B 86 1A F5     mov ax, word ptr [bp - 0xae6]
2BB5  C4 3E B6 D7     les di, ptr [0xd7b6]
2BB9  03 F8           add di, ax
2BBB  26 8A 45 FF     mov al, byte ptr es:[di - 1]
2BBF  30 E4           xor ah, ah
2BC1  8B D0           mov dx, ax
2BC3  8B 86 1A F5     mov ax, word ptr [bp - 0xae6]
2BC7  C4 3E B6 D7     les di, ptr [0xd7b6]
2BCB  03 F8           add di, ax
2BCD  26 8A 45 FF     mov al, byte ptr es:[di - 1]
2BD1  30 E4           xor ah, ah
2BD3  8B F8           mov di, ax
2BD5  8A 83 1B F5     mov al, byte ptr [bp + di - 0xae5]
2BD9  30 E4           xor ah, ah
2BDB  8B F8           mov di, ax
2BDD  C1 E7 07        shl di, 7
2BE0  03 FA           add di, dx
2BE2  88 8B 7F F5     mov byte ptr [bp + di - 0xa81], cl
loc_2BE6:
2BE6  81 BE 1A F5 B0 00 cmp word ptr [bp - 0xae6], 0xb0
2BEC  74 03           je 0x2bf1
2BEE  E9 53 FF        jmp 0x2b44
loc_2BF1:
2BF1  C7 86 1A F5 01 00 mov word ptr [bp - 0xae6], 1
2BF7  EB 04           jmp 0x2bfd
loc_2BF9:
2BF9  FF 86 1A F5     inc word ptr [bp - 0xae6]
loc_2BFD:
2BFD  6B 86 1A F5 3E  imul ax, word ptr [bp - 0xae6], 0x3e
2C02  C4 3E C2 D7     les di, ptr [0xd7c2]
2C06  03 F8           add di, ax
2C08  81 C7 C2 FF     add di, 0xffc2
2C0C  89 BE 14 F5     mov word ptr [bp - 0xaec], di
2C10  8C 86 16 F5     mov word ptr [bp - 0xaea], es
2C14  FF B6 1A F5     push word ptr [bp - 0xae6]
2C18  9A EE 1A 51 1B  call far 1B51:1AEE
2C1D  08 C0           or al, al
2C1F  74 47           je 0x2c68
2C21  C7 86 18 F5 01 00 mov word ptr [bp - 0xae8], 1
2C27  EB 04           jmp 0x2c2d
loc_2C29:
2C29  FF 86 18 F5     inc word ptr [bp - 0xae8]
loc_2C2D:
2C2D  8B 86 1A F5     mov ax, word ptr [bp - 0xae6]
2C31  C4 3E B6 D7     les di, ptr [0xd7b6]
2C35  03 F8           add di, ax
2C37  26 8A 45 FF     mov al, byte ptr es:[di - 1]
2C3B  30 E4           xor ah, ah
2C3D  8B F8           mov di, ax
2C3F  8A 83 1B F5     mov al, byte ptr [bp + di - 0xae5]
2C43  30 E4           xor ah, ah
2C45  50              push ax
2C46  9A 6D 07 1A 23  call far 231A:076D
2C4B  8B F8           mov di, ax
2C4D  8A 93 9B F5     mov dl, byte ptr [bp + di - 0xa65]
2C51  8B 86 18 F5     mov ax, word ptr [bp - 0xae8]
2C55  C4 BE 14 F5     les di, ptr [bp - 0xaec]
2C59  03 F8           add di, ax
2C5B  26 88 55 3A     mov byte ptr es:[di + 0x3a], dl
2C5F  83 BE 18 F5 03  cmp word ptr [bp - 0xae8], 3
2C64  75 C3           jne 0x2c29
2C66  EB 5C           jmp 0x2cc4
loc_2C68:
2C68  C7 86 18 F5 01 00 mov word ptr [bp - 0xae8], 1
2C6E  EB 04           jmp 0x2c74
loc_2C70:
2C70  FF 86 18 F5     inc word ptr [bp - 0xae8]
loc_2C74:
2C74  8B 86 1A F5     mov ax, word ptr [bp - 0xae6]
2C78  C4 3E B6 D7     les di, ptr [0xd7b6]
2C7C  03 F8           add di, ax
2C7E  26 8A 45 FF     mov al, byte ptr es:[di - 1]
2C82  30 E4           xor ah, ah
2C84  50              push ax
2C85  8B 86 1A F5     mov ax, word ptr [bp - 0xae6]
2C89  C4 3E B6 D7     les di, ptr [0xd7b6]
2C8D  03 F8           add di, ax
2C8F  26 8A 45 FF     mov al, byte ptr es:[di - 1]
2C93  30 E4           xor ah, ah
2C95  8B F8           mov di, ax
2C97  8A 83 1B F5     mov al, byte ptr [bp + di - 0xae5]
2C9B  30 E4           xor ah, ah
2C9D  50              push ax
2C9E  9A 6D 07 1A 23  call far 231A:076D
2CA3  8B F8           mov di, ax
2CA5  C1 E7 07        shl di, 7
2CA8  58              pop ax
2CA9  03 F8           add di, ax
2CAB  8A 93 7F F5     mov dl, byte ptr [bp + di - 0xa81]
2CAF  8B 86 18 F5     mov ax, word ptr [bp - 0xae8]
2CB3  C4 BE 14 F5     les di, ptr [bp - 0xaec]
2CB7  03 F8           add di, ax
2CB9  26 88 55 3A     mov byte ptr es:[di + 0x3a], dl
2CBD  83 BE 18 F5 03  cmp word ptr [bp - 0xae8], 3
2CC2  75 AC           jne 0x2c70
loc_2CC4:
2CC4  81 BE 1A F5 B0 00 cmp word ptr [bp - 0xae6], 0xb0
2CCA  74 03           je 0x2ccf
2CCC  E9 2A FF        jmp 0x2bf9
loc_2CCF:
2CCF  C9              leave
2CD0  C3              ret

; ---- routine 01EE:2CD1  (found by: call)
sub_2CD1:
2CD1  C8 06 00 00     enter 6, 0
2CD5  C4 3E D2 D7     les di, ptr [0xd7d2]
2CD9  26 C6 05 00     mov byte ptr es:[di], 0
2CDD  C4 3E D2 D7     les di, ptr [0xd7d2]
2CE1  26 FE 45 01     inc byte ptr es:[di + 1]
2CE5  C4 3E D2 D7     les di, ptr [0xd7d2]
2CE9  26 80 7D 01 01  cmp byte ptr es:[di + 1], 1
2CEE  74 07           je 0x2cf7
2CF0  9A C3 26 E4 06  call far 06E4:26C3
2CF5  EB 05           jmp 0x2cfc
loc_2CF7:
2CF7  9A 1A 18 B9 26  call far 26B9:181A
loc_2CFC:
2CFC  9A 75 0E E4 06  call far 06E4:0E75
2D01  C4 3E D2 D7     les di, ptr [0xd7d2]
2D05  26 80 7D 01 01  cmp byte ptr es:[di + 1], 1
2D0A  74 05           je 0x2d11
2D0C  9A 01 2B E4 06  call far 06E4:2B01
loc_2D11:
2D11  9A 79 3F 51 1B  call far 1B51:3F79
2D16  0E              push cs
2D17  E8 28 F4        call 0x2142
2D1A  C4 3E D2 D7     les di, ptr [0xd7d2]
2D1E  26 80 7D 01 01  cmp byte ptr es:[di + 1], 1
2D23  74 03           je 0x2d28
2D25  E8 8C FD        call 0x2ab4
loc_2D28:
2D28  C4 3E D2 D7     les di, ptr [0xd7d2]
2D2C  26 80 7D 01 01  cmp byte ptr es:[di + 1], 1
2D31  75 07           jne 0x2d3a
2D33  9A C5 61 51 1B  call far 1B51:61C5
2D38  EB 05           jmp 0x2d3f
loc_2D3A:
2D3A  9A E3 32 E4 06  call far 06E4:32E3
loc_2D3F:
2D3F  6A 08           push 8
2D41  6A 03           push 3
2D43  9A D1 0A E4 06  call far 06E4:0AD1
2D48  6A 17           push 0x17
2D4A  6A 04           push 4
2D4C  9A D1 0A E4 06  call far 06E4:0AD1
2D51  C7 46 FE 01 00  mov word ptr [bp - 2], 1
2D56  EB 03           jmp 0x2d5b
loc_2D58:
2D58  FF 46 FE        inc word ptr [bp - 2]
loc_2D5B:
2D5B  8B 7E FE        mov di, word ptr [bp - 2]
2D5E  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
2D62  30 E4           xor ah, ah
2D64  6B C0 3E        imul ax, ax, 0x3e
2D67  C4 3E C2 D7     les di, ptr [0xd7c2]
2D6B  03 F8           add di, ax
2D6D  81 C7 C2 FF     add di, 0xffc2
2D71  26 C6 45 38 0A  mov byte ptr es:[di + 0x38], 0xa
2D76  81 7E FE B0 00  cmp word ptr [bp - 2], 0xb0
2D7B  75 DB           jne 0x2d58
2D7D  E8 AF F5        call 0x232f
2D80  C4 3E D2 D7     les di, ptr [0xd7d2]
2D84  26 80 7D 01 01  cmp byte ptr es:[di + 1], 1
2D89  74 08           je 0x2d93
2D8B  9A DC 29 51 1B  call far 1B51:29DC
2D90  E8 51 F7        call 0x24e4
loc_2D93:
2D93  E8 82 FD        call 0x2b18
2D96  C9              leave
2D97  C3              ret

; ---- routine 01EE:2D98  (found by: call)
sub_2D98:
2D98  C8 08 00 00     enter 8, 0
2D9C  8B 46 04        mov ax, word ptr [bp + 4]
2D9F  C1 E0 02        shl ax, 2
2DA2  C4 3E C8 DC     les di, ptr [0xdcc8]
2DA6  03 F8           add di, ax
2DA8  26 80 3D 00     cmp byte ptr es:[di], 0
2DAC  75 0A           jne 0x2db8
2DAE  31 C0           xor ax, ax
2DB0  89 46 FC        mov word ptr [bp - 4], ax
2DB3  89 46 FE        mov word ptr [bp - 2], ax
2DB6  EB 18           jmp 0x2dd0
loc_2DB8:
2DB8  FF 76 04        push word ptr [bp + 4]
2DBB  9A DF 01 E4 06  call far 06E4:01DF
2DC0  B9 3A 00        mov cx, 0x3a
2DC3  31 DB           xor bx, bx
2DC5  9A 2A 0A B9 26  call far 26B9:0A2A
2DCA  89 46 FC        mov word ptr [bp - 4], ax
2DCD  89 56 FE        mov word ptr [bp - 2], dx
loc_2DD0:
2DD0  8B 46 FC        mov ax, word ptr [bp - 4]
2DD3  8B 56 FE        mov dx, word ptr [bp - 2]
2DD6  C9              leave
2DD7  C2 02 00        ret 2

; ---- routine 01EE:2DDA  (found by: call)
sub_2DDA:
2DDA  C8 04 00 00     enter 4, 0
2DDE  83 7E 06 00     cmp word ptr [bp + 6], 0
2DE2  75 02           jne 0x2de6
2DE4  EB 32           jmp 0x2e18
loc_2DE6:
2DE6  8B 46 06        mov ax, word ptr [bp + 6]
2DE9  C1 E0 02        shl ax, 2
2DEC  C4 3E C8 DC     les di, ptr [0xdcc8]
2DF0  03 F8           add di, ax
2DF2  26 8A 05        mov al, byte ptr es:[di]
2DF5  26 88 45 01     mov byte ptr es:[di + 1], al
2DF9  26 C6 05 00     mov byte ptr es:[di], 0
2DFD  26 8A 45 03     mov al, byte ptr es:[di + 3]
2E01  98              cwde
2E02  D1 E0           shl ax, 1
2E04  8B D0           mov dx, ax
2E06  6B 46 04 3E     imul ax, word ptr [bp + 4], 0x3e
2E0A  C4 3E C2 D7     les di, ptr [0xd7c2]
2E0E  03 F8           add di, ax
2E10  03 FA           add di, dx
2E12  31 C0           xor ax, ax
2E14  26 89 45 EA     mov word ptr es:[di - 0x16], ax
loc_2E18:
2E18  C9              leave
2E19  C2 04 00        ret 4

; ---- routine 01EE:2E1C  (found by: call)
sub_2E1C:
2E1C  C8 04 00 00     enter 4, 0
2E20  8B 46 06        mov ax, word ptr [bp + 6]
2E23  C1 E0 02        shl ax, 2
2E26  C4 3E C8 DC     les di, ptr [0xdcc8]
2E2A  03 F8           add di, ax
2E2C  89 7E FC        mov word ptr [bp - 4], di
2E2F  8C 46 FE        mov word ptr [bp - 2], es
2E32  26 80 3D 00     cmp byte ptr es:[di], 0
2E36  74 07           je 0x2e3f
2E38  26 8A 05        mov al, byte ptr es:[di]
2E3B  26 88 45 01     mov byte ptr es:[di + 1], al
loc_2E3F:
2E3F  8A 46 04        mov al, byte ptr [bp + 4]
2E42  C4 7E FC        les di, ptr [bp - 4]
2E45  26 88 05        mov byte ptr es:[di], al
2E48  8B 4E 06        mov cx, word ptr [bp + 6]
2E4B  26 8A 45 03     mov al, byte ptr es:[di + 3]
2E4F  98              cwde
2E50  D1 E0           shl ax, 1
2E52  8B D0           mov dx, ax
2E54  6B 46 04 3E     imul ax, word ptr [bp + 4], 0x3e
2E58  C4 3E C2 D7     les di, ptr [0xd7c2]
2E5C  03 F8           add di, ax
2E5E  03 FA           add di, dx
2E60  26 89 4D EA     mov word ptr es:[di - 0x16], cx
2E64  C9              leave
2E65  C2 04 00        ret 4

; ---- routine 01EE:2E68  (found by: call)
sub_2E68:
2E68  C8 08 00 00     enter 8, 0
2E6C  C4 3E D2 D7     les di, ptr [0xd7d2]
2E70  89 7E F8        mov word ptr [bp - 8], di
2E73  8C 46 FA        mov word ptr [bp - 6], es
2E76  68 C7 00        push 0xc7
2E79  9A 6D 07 1A 23  call far 231A:076D
2E7E  99              cdq
2E7F  8B C8           mov cx, ax
2E81  8B DA           mov bx, dx
2E83  8A 46 04        mov al, byte ptr [bp + 4]
2E86  98              cwde
2E87  8B F8           mov di, ax
2E89  D1 E7           shl di, 1
2E8B  8B 85 72 02     mov ax, word ptr [di + 0x272]
2E8F  31 D2           xor dx, dx
2E91  03 C1           add ax, cx
2E93  13 D3           adc dx, bx
2E95  2D 01 00        sub ax, 1
2E98  83 DA 00        sbb dx, 0
2E9B  89 46 FC        mov word ptr [bp - 4], ax
loc_2E9E:
2E9E  8B 46 FC        mov ax, word ptr [bp - 4]
2EA1  C1 E0 02        shl ax, 2
2EA4  C4 3E C8 DC     les di, ptr [0xdcc8]
2EA8  03 F8           add di, ax
2EAA  26 80 3D 00     cmp byte ptr es:[di], 0
2EAE  75 15           jne 0x2ec5
2EB0  8B 46 FC        mov ax, word ptr [bp - 4]
2EB3  C4 7E F8        les di, ptr [bp - 8]
2EB6  26 3B 45 05     cmp ax, word ptr es:[di + 5]
2EBA  74 09           je 0x2ec5
2EBC  8B 46 FC        mov ax, word ptr [bp - 4]
2EBF  26 3B 45 07     cmp ax, word ptr es:[di + 7]
2EC3  75 28           jne 0x2eed
loc_2EC5:
2EC5  FF 46 FC        inc word ptr [bp - 4]
2EC8  8A 46 04        mov al, byte ptr [bp + 4]
2ECB  98              cwde
2ECC  8B F8           mov di, ax
2ECE  D1 E7           shl di, 1
2ED0  8B 85 72 02     mov ax, word ptr [di + 0x272]
2ED4  05 C7 00        add ax, 0xc7
2ED7  3B 46 FC        cmp ax, word ptr [bp - 4]
2EDA  73 0F           jae 0x2eeb
2EDC  8A 46 04        mov al, byte ptr [bp + 4]
2EDF  98              cwde
2EE0  8B F8           mov di, ax
2EE2  D1 E7           shl di, 1
2EE4  8B 85 72 02     mov ax, word ptr [di + 0x272]
2EE8  89 46 FC        mov word ptr [bp - 4], ax
loc_2EEB:
2EEB  EB B1           jmp 0x2e9e
loc_2EED:
2EED  8B 46 FC        mov ax, word ptr [bp - 4]
2EF0  89 46 FE        mov word ptr [bp - 2], ax
2EF3  8B 46 FE        mov ax, word ptr [bp - 2]
2EF6  C9              leave
2EF7  C2 02 00        ret 2

; ---- routine 01EE:2EFA  (found by: call)
sub_2EFA:
2EFA  C8 06 00 00     enter 6, 0
2EFE  9A 85 00 1A 23  call far 231A:0085
2F03  31 C0           xor ax, ax
2F05  A3 86 D6        mov word ptr [0xd686], ax
2F08  BF FC D4        mov di, 0xd4fc
2F0B  1E              push ds
2F0C  57              push di
2F0D  68 B0 00        push 0xb0
2F10  6A 00           push 0
2F12  9A 22 02 AC 24  call far 24AC:0222
2F17  C7 46 FE 01 00  mov word ptr [bp - 2], 1
2F1C  EB 03           jmp 0x2f21
loc_2F1E:
2F1E  FF 46 FE        inc word ptr [bp - 2]
loc_2F21:
2F21  8A 56 FE        mov dl, byte ptr [bp - 2]
2F24  6B 46 FE 3E     imul ax, word ptr [bp - 2], 0x3e
2F28  C4 3E C2 D7     les di, ptr [0xd7c2]
2F2C  03 F8           add di, ax
2F2E  26 8A 45 F5     mov al, byte ptr es:[di - 0xb]
2F32  30 E4           xor ah, ah
2F34  8B F8           mov di, ax
2F36  88 95 FB D4     mov byte ptr [di - 0x2b05], dl
2F3A  81 7E FE B0 00  cmp word ptr [bp - 2], 0xb0
2F3F  75 DD           jne 0x2f1e
2F41  C7 46 FE 01 00  mov word ptr [bp - 2], 1
2F46  EB 03           jmp 0x2f4b
loc_2F48:
2F48  FF 46 FE        inc word ptr [bp - 2]
loc_2F4B:
2F4B  8B 7E FE        mov di, word ptr [bp - 2]
2F4E  8A 85 FB D4     mov al, byte ptr [di - 0x2b05]
2F52  30 E4           xor ah, ah
2F54  6B C0 3E        imul ax, ax, 0x3e
2F57  C4 3E C2 D7     les di, ptr [0xd7c2]
2F5B  03 F8           add di, ax
2F5D  81 C7 C2 FF     add di, 0xffc2
2F61  89 7E FA        mov word ptr [bp - 6], di
2F64  8C 46 FC        mov word ptr [bp - 4], es
2F67  A0 7F 02        mov al, byte ptr [0x27f]
2F6A  98              cwde
2F6B  D1 E0           shl ax, 1
2F6D  03 F8           add di, ax
2F6F  26 83 7D 28 00  cmp word ptr es:[di + 0x28], 0
2F74  74 14           je 0x2f8a
2F76  A0 7F 02        mov al, byte ptr [0x27f]
2F79  98              cwde
2F7A  D1 E0           shl ax, 1
2F7C  C4 7E FA        les di, ptr [bp - 6]
2F7F  03 F8           add di, ax
2F81  26 FF 75 28     push word ptr es:[di + 0x28]
2F85  9A 9D 44 51 1B  call far 1B51:449D
loc_2F8A:
2F8A  81 7E FE B0 00  cmp word ptr [bp - 2], 0xb0
2F8F  75 B7           jne 0x2f48
2F91  A0 7F 02        mov al, byte ptr [0x27f]
2F94  98              cwde
2F95  8B F8           mov di, ax
2F97  D1 E7           shl di, 1
2F99  8B 85 7E 02     mov ax, word ptr [di + 0x27e]
2F9D  05 C8 00        add ax, 0xc8
2FA0  89 46 FC        mov word ptr [bp - 4], ax
2FA3  A0 7F 02        mov al, byte ptr [0x27f]
2FA6  98              cwde
2FA7  8B F8           mov di, ax
2FA9  D1 E7           shl di, 1
2FAB  8B 85 7E 02     mov ax, word ptr [di + 0x27e]
2FAF  40              inc ax
2FB0  3B 46 FC        cmp ax, word ptr [bp - 4]
2FB3  77 2A           ja 0x2fdf
2FB5  89 46 FE        mov word ptr [bp - 2], ax
2FB8  EB 03           jmp 0x2fbd
loc_2FBA:
2FBA  FF 46 FE        inc word ptr [bp - 2]
loc_2FBD:
2FBD  8B 46 FE        mov ax, word ptr [bp - 2]
2FC0  C1 E0 02        shl ax, 2
2FC3  C4 3E C8 DC     les di, ptr [0xdcc8]
2FC7  03 F8           add di, ax
2FC9  26 80 3D 00     cmp byte ptr es:[di], 0
2FCD  75 08           jne 0x2fd7
2FCF  FF 76 FE        push word ptr [bp - 2]
2FD2  9A 9D 44 51 1B  call far 1B51:449D
loc_2FD7:
2FD7  8B 46 FE        mov ax, word ptr [bp - 2]
2FDA  3B 46 FC        cmp ax, word ptr [bp - 4]
2FDD  75 DB           jne 0x2fba
loc_2FDF:
2FDF  C9              leave
2FE0  C2 02 00        ret 2
; data (not reached as code), 16 bytes
2FE3                  pstr 'Unemployed'
2FEE                  pstr 'None'

