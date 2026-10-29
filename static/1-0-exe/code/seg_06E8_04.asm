; 1-0.EXE (One-Nil 96), code segment 06E8 (image offsets 06E80..0AB8F), part 4 of 6
; packed 1-0.EXE sha256 89ff9c5f238f24e81a0c2440a46cdd8997280a65fc3cc3d97cb974f55280a80a (LZEXE 0.91)
; unpacked (tools/static/unlzexe.py) sha256 887ed2a92767950e5309b2052409f875668605939b69e00737aa3047022b9f51
; tool: capstone 5.0.9 (pip package; core library 5.0.1280) (CS_ARCH_X86, CS_MODE_16), recursive descent from the entry point, far calls and near calls/jumps, then routine prologues (55 89 E5 / 55 8B EC / C8 iw 00) in what remains; tools/static/listing.py
; addresses are SEGMENT:OFFSET with SEGMENT the image paragraph before relocation; image offset = SEGMENT*16+OFFSET
; ---- routine 06E8:2207  (found by: call)
sub_2207:
2207  C8 0A 00 00     enter 0xa, 0
220B  C4 3E BC DC     les di, ptr [0xdcbc]
220F  89 7E FA        mov word ptr [bp - 6], di
2212  8C 46 FC        mov word ptr [bp - 4], es
2215  C4 3E D2 D7     les di, ptr [0xd7d2]
2219  26 8A 45 0F     mov al, byte ptr es:[di + 0xf]
221D  50              push ax
221E  C4 3E D2 D7     les di, ptr [0xd7d2]
2222  26 8A 45 0F     mov al, byte ptr es:[di + 0xf]
2226  30 E4           xor ah, ah
2228  50              push ax
2229  6A 25           push 0x25
222B  9A 35 17 55 1B  call far 1B55:1735
2230  98              cwde
2231  C4 7E FA        les di, ptr [bp - 6]
2234  03 F8           add di, ax
2236  58              pop ax
2237  26 88 05        mov byte ptr es:[di], al
223A  C4 3E D2 D7     les di, ptr [0xd7d2]
223E  26 8A 45 10     mov al, byte ptr es:[di + 0x10]
2242  50              push ax
2243  C4 3E D2 D7     les di, ptr [0xd7d2]
2247  26 8A 45 10     mov al, byte ptr es:[di + 0x10]
224B  30 E4           xor ah, ah
224D  50              push ax
224E  6A 25           push 0x25
2250  9A 35 17 55 1B  call far 1B55:1735
2255  98              cwde
2256  C4 7E FA        les di, ptr [bp - 6]
2259  03 F8           add di, ax
225B  58              pop ax
225C  26 88 05        mov byte ptr es:[di], al
225F  C4 3E D2 D7     les di, ptr [0xd7d2]
2263  26 8A 45 11     mov al, byte ptr es:[di + 0x11]
2267  50              push ax
2268  C4 3E D2 D7     les di, ptr [0xd7d2]
226C  26 8A 45 11     mov al, byte ptr es:[di + 0x11]
2270  30 E4           xor ah, ah
2272  50              push ax
2273  6A 33           push 0x33
2275  9A 35 17 55 1B  call far 1B55:1735
227A  98              cwde
227B  C4 7E FA        les di, ptr [bp - 6]
227E  03 F8           add di, ax
2280  58              pop ax
2281  26 88 45 02     mov byte ptr es:[di + 2], al
2285  C4 3E D2 D7     les di, ptr [0xd7d2]
2289  26 8A 45 12     mov al, byte ptr es:[di + 0x12]
228D  50              push ax
228E  C4 3E D2 D7     les di, ptr [0xd7d2]
2292  26 8A 45 12     mov al, byte ptr es:[di + 0x12]
2296  30 E4           xor ah, ah
2298  50              push ax
2299  6A 33           push 0x33
229B  9A 35 17 55 1B  call far 1B55:1735
22A0  98              cwde
22A1  C4 7E FA        les di, ptr [bp - 6]
22A4  03 F8           add di, ax
22A6  58              pop ax
22A7  26 88 45 02     mov byte ptr es:[di + 2], al
22AB  C4 3E D2 D7     les di, ptr [0xd7d2]
22AF  26 8A 45 09     mov al, byte ptr es:[di + 9]
22B3  50              push ax
22B4  C4 3E D2 D7     les di, ptr [0xd7d2]
22B8  26 8A 45 09     mov al, byte ptr es:[di + 9]
22BC  30 E4           xor ah, ah
22BE  50              push ax
22BF  6A 39           push 0x39
22C1  9A 35 17 55 1B  call far 1B55:1735
22C6  98              cwde
22C7  C4 7E FA        les di, ptr [bp - 6]
22CA  03 F8           add di, ax
22CC  58              pop ax
22CD  26 88 45 06     mov byte ptr es:[di + 6], al
22D1  C4 3E D2 D7     les di, ptr [0xd7d2]
22D5  26 8A 45 0A     mov al, byte ptr es:[di + 0xa]
22D9  50              push ax
22DA  C4 3E D2 D7     les di, ptr [0xd7d2]
22DE  26 8A 45 0A     mov al, byte ptr es:[di + 0xa]
22E2  30 E4           xor ah, ah
22E4  50              push ax
22E5  6A 39           push 0x39
22E7  9A 35 17 55 1B  call far 1B55:1735
22EC  98              cwde
22ED  C4 7E FA        les di, ptr [bp - 6]
22F0  03 F8           add di, ax
22F2  58              pop ax
22F3  26 88 45 06     mov byte ptr es:[di + 6], al
22F7  C4 3E D2 D7     les di, ptr [0xd7d2]
22FB  26 8A 45 0B     mov al, byte ptr es:[di + 0xb]
22FF  50              push ax
2300  C4 3E D2 D7     les di, ptr [0xd7d2]
2304  26 8A 45 0B     mov al, byte ptr es:[di + 0xb]
2308  30 E4           xor ah, ah
230A  50              push ax
230B  6A 30           push 0x30
230D  9A 35 17 55 1B  call far 1B55:1735
2312  98              cwde
2313  C4 7E FA        les di, ptr [bp - 6]
2316  03 F8           add di, ax
2318  58              pop ax
2319  26 88 45 08     mov byte ptr es:[di + 8], al
231D  C4 3E D2 D7     les di, ptr [0xd7d2]
2321  26 8A 45 0C     mov al, byte ptr es:[di + 0xc]
2325  50              push ax
2326  C4 3E D2 D7     les di, ptr [0xd7d2]
232A  26 8A 45 0C     mov al, byte ptr es:[di + 0xc]
232E  30 E4           xor ah, ah
2330  50              push ax
2331  6A 30           push 0x30
2333  9A 35 17 55 1B  call far 1B55:1735
2338  98              cwde
2339  C4 7E FA        les di, ptr [bp - 6]
233C  03 F8           add di, ax
233E  58              pop ax
233F  26 88 45 08     mov byte ptr es:[di + 8], al
2343  C4 3E D2 D7     les di, ptr [0xd7d2]
2347  26 8A 45 0D     mov al, byte ptr es:[di + 0xd]
234B  50              push ax
234C  C4 3E D2 D7     les di, ptr [0xd7d2]
2350  26 8A 45 0D     mov al, byte ptr es:[di + 0xd]
2354  30 E4           xor ah, ah
2356  50              push ax
2357  6A 30           push 0x30
2359  6A 35           push 0x35
235B  9A DA 1A 55 1B  call far 1B55:1ADA
2360  98              cwde
2361  C4 7E FA        les di, ptr [bp - 6]
2364  03 F8           add di, ax
2366  58              pop ax
2367  26 88 45 0A     mov byte ptr es:[di + 0xa], al
236B  C4 3E D2 D7     les di, ptr [0xd7d2]
236F  26 8A 45 0E     mov al, byte ptr es:[di + 0xe]
2373  50              push ax
2374  C4 3E D2 D7     les di, ptr [0xd7d2]
2378  26 8A 45 0E     mov al, byte ptr es:[di + 0xe]
237C  30 E4           xor ah, ah
237E  50              push ax
237F  6A 30           push 0x30
2381  6A 35           push 0x35
2383  9A DA 1A 55 1B  call far 1B55:1ADA
2388  98              cwde
2389  C4 7E FA        les di, ptr [bp - 6]
238C  03 F8           add di, ax
238E  58              pop ax
238F  26 88 45 0A     mov byte ptr es:[di + 0xa], al
2393  C6 46 FF 03     mov byte ptr [bp - 1], 3
2397  EB 03           jmp 0x239c
loc_2399:
2399  FE 46 FF        inc byte ptr [bp - 1]
loc_239C:
239C  80 7E FF 05     cmp byte ptr [bp - 1], 5
23A0  74 53           je 0x23f5
23A2  C6 46 FE 00     mov byte ptr [bp - 2], 0
23A6  EB 03           jmp 0x23ab
loc_23A8:
23A8  FE 46 FE        inc byte ptr [bp - 2]
loc_23AB:
23AB  8A 46 FE        mov al, byte ptr [bp - 2]
23AE  98              cwde
23AF  8B D0           mov dx, ax
23B1  8A 46 FF        mov al, byte ptr [bp - 1]
23B4  98              cwde
23B5  D1 E0           shl ax, 1
23B7  C4 7E FA        les di, ptr [bp - 6]
23BA  03 F8           add di, ax
23BC  03 FA           add di, dx
23BE  26 8A 45 FA     mov al, byte ptr es:[di - 6]
23C2  30 E4           xor ah, ah
23C4  6B C0 3E        imul ax, ax, 0x3e
23C7  C4 3E C2 D7     les di, ptr [0xd7c2]
23CB  03 F8           add di, ax
23CD  26 8A 45 F9     mov al, byte ptr es:[di - 7]
23D1  98              cwde
23D2  8B F8           mov di, ax
23D4  8A 8D 3C A2     mov cl, byte ptr [di - 0x5dc4]
23D8  8A 46 FE        mov al, byte ptr [bp - 2]
23DB  98              cwde
23DC  8B D0           mov dx, ax
23DE  8A 46 FF        mov al, byte ptr [bp - 1]
23E1  98              cwde
23E2  D1 E0           shl ax, 1
23E4  C4 7E FA        les di, ptr [bp - 6]
23E7  03 F8           add di, ax
23E9  03 FA           add di, dx
23EB  26 88 4D 06     mov byte ptr es:[di + 6], cl
23EF  80 7E FE 01     cmp byte ptr [bp - 2], 1
23F3  75 B3           jne 0x23a8
loc_23F5:
23F5  80 7E FF 08     cmp byte ptr [bp - 1], 8
23F9  75 9E           jne 0x2399
23FB  C6 46 FF 03     mov byte ptr [bp - 1], 3
23FF  EB 03           jmp 0x2404
loc_2401:
2401  FE 46 FF        inc byte ptr [bp - 1]
loc_2404:
2404  80 7E FF 05     cmp byte ptr [bp - 1], 5
2408  74 5A           je 0x2464
240A  C6 46 FE 00     mov byte ptr [bp - 2], 0
240E  EB 03           jmp 0x2413
loc_2410:
2410  FE 46 FE        inc byte ptr [bp - 2]
loc_2413:
2413  8A 46 FE        mov al, byte ptr [bp - 2]
2416  98              cwde
2417  8B D0           mov dx, ax
2419  8A 46 FF        mov al, byte ptr [bp - 1]
241C  98              cwde
241D  D1 E0           shl ax, 1
241F  C4 7E FA        les di, ptr [bp - 6]
2422  03 F8           add di, ax
2424  03 FA           add di, dx
2426  26 8A 45 FA     mov al, byte ptr es:[di - 6]
242A  30 E4           xor ah, ah
242C  6B C0 2E        imul ax, ax, 0x2e
242F  C4 3E C0 DC     les di, ptr [0xdcc0]
2433  03 F8           add di, ax
2435  81 C7 D2 FF     add di, 0xffd2
2439  89 7E F6        mov word ptr [bp - 0xa], di
243C  8C 46 F8        mov word ptr [bp - 8], es
243F  80 7E FF 04     cmp byte ptr [bp - 1], 4
2443  7F 0C           jg 0x2451
2445  8A 46 FE        mov al, byte ptr [bp - 2]
2448  98              cwde
2449  03 F8           add di, ax
244B  26 FE 45 05     inc byte ptr es:[di + 5]
244F  EB 0D           jmp 0x245e
loc_2451:
2451  8A 46 FE        mov al, byte ptr [bp - 2]
2454  98              cwde
2455  C4 7E F6        les di, ptr [bp - 0xa]
2458  03 F8           add di, ax
245A  26 FE 45 07     inc byte ptr es:[di + 7]
loc_245E:
245E  80 7E FE 01     cmp byte ptr [bp - 2], 1
2462  75 AC           jne 0x2410
loc_2464:
2464  80 7E FF 08     cmp byte ptr [bp - 1], 8
2468  75 97           jne 0x2401
246A  C9              leave
246B  C2 02 00        ret 2

; ---- routine 06E8:246E  (found by: call)
sub_246E:
246E  C8 06 00 00     enter 6, 0
2472  C4 3E BC DC     les di, ptr [0xdcbc]
2476  89 7E FA        mov word ptr [bp - 6], di
2479  8C 46 FC        mov word ptr [bp - 4], es
247C  C6 46 FF 00     mov byte ptr [bp - 1], 0
2480  EB 03           jmp 0x2485
loc_2482:
2482  FE 46 FF        inc byte ptr [bp - 1]
loc_2485:
2485  8A 46 FF        mov al, byte ptr [bp - 1]
2488  98              cwde
2489  8B F8           mov di, ax
248B  8A 85 5A 03     mov al, byte ptr [di + 0x35a]
248F  30 E4           xor ah, ah
2491  8B F8           mov di, ax
2493  81 C7 D5 D7     add di, 0xd7d5
2497  1E              push ds
2498  57              push di
2499  8A 46 FF        mov al, byte ptr [bp - 1]
249C  98              cwde
249D  8B F0           mov si, ax
249F  D1 E0           shl ax, 1
24A1  01 F0           add ax, si
24A3  C4 7E FA        les di, ptr [bp - 6]
24A6  03 F8           add di, ax
24A8  81 C7 18 00     add di, 0x18
24AC  06              push es
24AD  57              push di
24AE  6A 03           push 3
24B0  9A C2 01 BC 24  call far 24BC:01C2
24B5  8A 46 FF        mov al, byte ptr [bp - 1]
24B8  98              cwde
24B9  8B D0           mov dx, ax
24BB  8A 46 FF        mov al, byte ptr [bp - 1]
24BE  98              cwde
24BF  8B F0           mov si, ax
24C1  D1 E0           shl ax, 1
24C3  01 F0           add ax, si
24C5  C4 7E FA        les di, ptr [bp - 6]
24C8  03 F8           add di, ax
24CA  26 8A 45 18     mov al, byte ptr es:[di + 0x18]
24CE  30 E4           xor ah, ah
24D0  6B C0 2E        imul ax, ax, 0x2e
24D3  C4 3E C0 DC     les di, ptr [0xdcc0]
24D7  03 F8           add di, ax
24D9  03 FA           add di, dx
24DB  26 FE 45 D2     inc byte ptr es:[di - 0x2e]
24DF  80 7E FF 04     cmp byte ptr [bp - 1], 4
24E3  75 9D           jne 0x2482
24E5  C9              leave
24E6  C2 02 00        ret 2

; ---- routine 06E8:24E9  (found by: call)
sub_24E9:
24E9  C8 06 00 00     enter 6, 0
24ED  C7 46 FE 01 00  mov word ptr [bp - 2], 1
24F2  EB 03           jmp 0x24f7
loc_24F4:
24F4  FF 46 FE        inc word ptr [bp - 2]
loc_24F7:
24F7  8B 7E FE        mov di, word ptr [bp - 2]
24FA  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
24FE  30 E4           xor ah, ah
2500  6B C0 0C        imul ax, ax, 0xc
2503  C4 3E C6 D7     les di, ptr [0xd7c6]
2507  03 F8           add di, ax
2509  81 C7 F4 FF     add di, 0xfff4
250D  89 7E FA        mov word ptr [bp - 6], di
2510  8C 46 FC        mov word ptr [bp - 4], es
2513  8B 7E FE        mov di, word ptr [bp - 2]
2516  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
251A  30 E4           xor ah, ah
251C  6B C0 2E        imul ax, ax, 0x2e
251F  C4 3E C0 DC     les di, ptr [0xdcc0]
2523  03 F8           add di, ax
2525  26 8A 45 DB     mov al, byte ptr es:[di - 0x25]
2529  C4 7E FA        les di, ptr [bp - 6]
252C  26 3A 45 01     cmp al, byte ptr es:[di + 1]
2530  73 1A           jae 0x254c
2532  26 8A 55 01     mov dl, byte ptr es:[di + 1]
2536  8B 7E FE        mov di, word ptr [bp - 2]
2539  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
253D  30 E4           xor ah, ah
253F  6B C0 2E        imul ax, ax, 0x2e
2542  C4 3E C0 DC     les di, ptr [0xdcc0]
2546  03 F8           add di, ax
2548  26 88 55 DB     mov byte ptr es:[di - 0x25], dl
loc_254C:
254C  8B 7E FE        mov di, word ptr [bp - 2]
254F  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
2553  30 E4           xor ah, ah
2555  6B C0 2E        imul ax, ax, 0x2e
2558  C4 3E C0 DC     les di, ptr [0xdcc0]
255C  03 F8           add di, ax
255E  26 8B 45 DC     mov ax, word ptr es:[di - 0x24]
2562  C4 7E FA        les di, ptr [bp - 6]
2565  26 3B 45 08     cmp ax, word ptr es:[di + 8]
2569  73 1A           jae 0x2585
256B  26 8B 55 08     mov dx, word ptr es:[di + 8]
256F  8B 7E FE        mov di, word ptr [bp - 2]
2572  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
2576  30 E4           xor ah, ah
2578  6B C0 2E        imul ax, ax, 0x2e
257B  C4 3E C0 DC     les di, ptr [0xdcc0]
257F  03 F8           add di, ax
2581  26 89 55 DC     mov word ptr es:[di - 0x24], dx
loc_2585:
2585  81 7E FE B0 00  cmp word ptr [bp - 2], 0xb0
258A  74 03           je 0x258f
258C  E9 65 FF        jmp 0x24f4
loc_258F:
258F  C9              leave
2590  C2 02 00        ret 2

; ---- routine 06E8:2593  (found by: call)
sub_2593:
2593  C8 0A 00 00     enter 0xa, 0
2597  31 C0           xor ax, ax
2599  89 46 FC        mov word ptr [bp - 4], ax
259C  C7 46 FA 01 00  mov word ptr [bp - 6], 1
25A1  EB 03           jmp 0x25a6
loc_25A3:
25A3  FF 46 FA        inc word ptr [bp - 6]
loc_25A6:
25A6  8B 46 FA        mov ax, word ptr [bp - 6]
25A9  8B F0           mov si, ax
25AB  D1 E0           shl ax, 1
25AD  01 F0           add ax, si
25AF  8B D0           mov dx, ax
25B1  69 46 08 AE 00  imul ax, word ptr [bp + 8], 0xae
25B6  C4 3E CA D7     les di, ptr [0xd7ca]
25BA  03 F8           add di, ax
25BC  03 FA           add di, dx
25BE  81 C7 4F FF     add di, 0xff4f
25C2  26 8A 05        mov al, byte ptr es:[di]
25C5  3A 46 06        cmp al, byte ptr [bp + 6]
25C8  75 0A           jne 0x25d4
25CA  26 80 7D 01 00  cmp byte ptr es:[di + 1], 0
25CF  74 03           je 0x25d4
25D1  FF 46 FC        inc word ptr [bp - 4]
loc_25D4:
25D4  83 7E FA 3A     cmp word ptr [bp - 6], 0x3a
25D8  75 C9           jne 0x25a3
25DA  8B 46 FC        mov ax, word ptr [bp - 4]
25DD  89 46 FE        mov word ptr [bp - 2], ax
25E0  8B 46 FE        mov ax, word ptr [bp - 2]
25E3  C9              leave
25E4  C2 06 00        ret 6

; ---- routine 06E8:25E7  (found by: call)
sub_25E7:
25E7  C8 0E 00 00     enter 0xe, 0
25EB  C4 3E BC DC     les di, ptr [0xdcbc]
25EF  89 7E F8        mov word ptr [bp - 8], di
25F2  8C 46 FA        mov word ptr [bp - 6], es
25F5  C4 3E D2 D7     les di, ptr [0xd7d2]
25F9  26 8A 45 03     mov al, byte ptr es:[di + 3]
25FD  30 E4           xor ah, ah
25FF  89 46 F6        mov word ptr [bp - 0xa], ax
2602  B8 01 00        mov ax, 1
2605  3B 46 F6        cmp ax, word ptr [bp - 0xa]
2608  76 03           jbe 0x260d
260A  E9 B2 00        jmp 0x26bf
loc_260D:
260D  89 46 FE        mov word ptr [bp - 2], ax
2610  EB 03           jmp 0x2615
loc_2612:
2612  FF 46 FE        inc word ptr [bp - 2]
loc_2615:
2615  8B 7E FE        mov di, word ptr [bp - 2]
2618  80 BD B9 DC 00  cmp byte ptr [di - 0x2347], 0
261D  75 03           jne 0x2622
261F  E9 92 00        jmp 0x26b4
loc_2622:
2622  6B 46 FE 09     imul ax, word ptr [bp - 2], 9
2626  C4 7E F8        les di, ptr [bp - 8]
2629  03 F8           add di, ax
262B  81 C7 20 00     add di, 0x20
262F  89 7E F2        mov word ptr [bp - 0xe], di
2632  8C 46 F4        mov word ptr [bp - 0xc], es
2635  8B 7E FE        mov di, word ptr [bp - 2]
2638  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
263C  C4 7E F2        les di, ptr [bp - 0xe]
263F  26 88 45 02     mov byte ptr es:[di + 2], al
2643  8B 7E FE        mov di, word ptr [bp - 2]
2646  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
264A  30 E4           xor ah, ah
264C  6B C0 3E        imul ax, ax, 0x3e
264F  C4 3E C2 D7     les di, ptr [0xd7c2]
2653  03 F8           add di, ax
2655  26 8A 45 F9     mov al, byte ptr es:[di - 7]
2659  C4 7E F2        les di, ptr [bp - 0xe]
265C  26 88 05        mov byte ptr es:[di], al
265F  8B 7E FE        mov di, word ptr [bp - 2]
2662  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
2666  30 E4           xor ah, ah
2668  6B C0 3E        imul ax, ax, 0x3e
266B  C4 3E C2 D7     les di, ptr [0xd7c2]
266F  03 F8           add di, ax
2671  26 8A 45 F8     mov al, byte ptr es:[di - 8]
2675  C4 7E F2        les di, ptr [bp - 0xe]
2678  26 88 45 01     mov byte ptr es:[di + 1], al
267C  C6 46 FD 03     mov byte ptr [bp - 3], 3
2680  EB 03           jmp 0x2685
loc_2682:
2682  FE 46 FD        inc byte ptr [bp - 3]
loc_2685:
2685  80 7E FD 05     cmp byte ptr [bp - 3], 5
2689  74 23           je 0x26ae
268B  C4 7E F2        les di, ptr [bp - 0xe]
268E  26 8A 45 02     mov al, byte ptr es:[di + 2]
2692  30 E4           xor ah, ah
2694  50              push ax
2695  8A 46 FD        mov al, byte ptr [bp - 3]
2698  50              push ax
2699  8B 7E 04        mov di, word ptr [bp + 4]
269C  57              push di
269D  E8 F3 FE        call 0x2593
26A0  8A D0           mov dl, al
26A2  8A 46 FD        mov al, byte ptr [bp - 3]
26A5  98              cwde
26A6  C4 7E F2        les di, ptr [bp - 0xe]
26A9  03 F8           add di, ax
26AB  26 88 15        mov byte ptr es:[di], dl
loc_26AE:
26AE  80 7E FD 08     cmp byte ptr [bp - 3], 8
26B2  75 CE           jne 0x2682
loc_26B4:
26B4  8B 46 FE        mov ax, word ptr [bp - 2]
26B7  3B 46 F6        cmp ax, word ptr [bp - 0xa]
26BA  74 03           je 0x26bf
26BC  E9 53 FF        jmp 0x2612
loc_26BF:
26BF  C9              leave
26C0  C2 02 00        ret 2

; ---- routine 06E8:26C3  (found by: far)
sub_26C3:
26C3  C8 08 00 00     enter 8, 0
26C7  C4 3E BC DC     les di, ptr [0xdcbc]
26CB  06              push es
26CC  57              push di
26CD  C4 3E BC DC     les di, ptr [0xdcbc]
26D1  81 C7 3B 00     add di, 0x3b
26D5  06              push es
26D6  57              push di
26D7  68 AF 06        push 0x6af
26DA  9A C2 01 BC 24  call far 24BC:01C2
26DF  C4 3E BC DC     les di, ptr [0xdcbc]
26E3  06              push es
26E4  57              push di
26E5  6A 3B           push 0x3b
26E7  6A 00           push 0
26E9  9A 22 02 BC 24  call far 24BC:0222
26EE  C4 3E D2 D7     les di, ptr [0xd7d2]
26F2  26 8A 45 01     mov al, byte ptr es:[di + 1]
26F6  30 E4           xor ah, ah
26F8  03 06 DA DC     add ax, word ptr [0xdcda]
26FC  C4 3E BC DC     les di, ptr [0xdcbc]
2700  26 89 45 27     mov word ptr es:[di + 0x27], ax
2704  55              push bp
2705  E8 E1 FD        call 0x24e9
2708  55              push bp
2709  E8 FB FA        call 0x2207
270C  55              push bp
270D  E8 5E FD        call 0x246e
2710  55              push bp
2711  E8 D3 FE        call 0x25e7
2714  C7 46 FE 01 00  mov word ptr [bp - 2], 1
2719  EB 03           jmp 0x271e
loc_271B:
271B  FF 46 FE        inc word ptr [bp - 2]
loc_271E:
271E  8B 7E FE        mov di, word ptr [bp - 2]
2721  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
2725  30 E4           xor ah, ah
2727  50              push ax
2728  8B 7E FE        mov di, word ptr [bp - 2]
272B  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
272F  30 E4           xor ah, ah
2731  6B C0 3E        imul ax, ax, 0x3e
2734  C4 3E C2 D7     les di, ptr [0xd7c2]
2738  03 F8           add di, ax
273A  81 C7 C2 FF     add di, 0xffc2
273E  06              push es
273F  57              push di
2740  E8 0C F6        call 0x1d4f
2743  81 7E FE B0 00  cmp word ptr [bp - 2], 0xb0
2748  75 D1           jne 0x271b
274A  C4 3E D2 D7     les di, ptr [0xd7d2]
274E  89 7E FA        mov word ptr [bp - 6], di
2751  8C 46 FC        mov word ptr [bp - 4], es
2754  26 8A 45 03     mov al, byte ptr es:[di + 3]
2758  30 E4           xor ah, ah
275A  89 46 F8        mov word ptr [bp - 8], ax
275D  B8 01 00        mov ax, 1
2760  3B 46 F8        cmp ax, word ptr [bp - 8]
2763  77 43           ja 0x27a8
2765  89 46 FE        mov word ptr [bp - 2], ax
2768  EB 03           jmp 0x276d
loc_276A:
276A  FF 46 FE        inc word ptr [bp - 2]
loc_276D:
276D  8B 7E FE        mov di, word ptr [bp - 2]
2770  80 BD B9 DC 00  cmp byte ptr [di - 0x2347], 0
2775  74 29           je 0x27a0
2777  C4 7E FA        les di, ptr [bp - 6]
277A  26 8A 45 04     mov al, byte ptr es:[di + 4]
277E  30 E4           xor ah, ah
2780  8B F8           mov di, ax
2782  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
2786  30 E4           xor ah, ah
2788  50              push ax
2789  C4 7E FA        les di, ptr [bp - 6]
278C  26 8A 45 04     mov al, byte ptr es:[di + 4]
2790  30 E4           xor ah, ah
2792  6B C0 28        imul ax, ax, 0x28
2795  03 F8           add di, ax
2797  81 C7 30 00     add di, 0x30
279B  06              push es
279C  57              push di
279D  E8 AF F5        call 0x1d4f
loc_27A0:
27A0  8B 46 FE        mov ax, word ptr [bp - 2]
27A3  3B 46 F8        cmp ax, word ptr [bp - 8]
27A6  75 C2           jne 0x276a
loc_27A8:
27A8  C9              leave
27A9  CB              retf

; ---- routine 06E8:27AA  (found by: call)
sub_27AA:
27AA  C8 06 00 00     enter 6, 0
27AE  C4 3E D2 D7     les di, ptr [0xd7d2]
27B2  89 7E FA        mov word ptr [bp - 6], di
27B5  8C 46 FC        mov word ptr [bp - 4], es
27B8  8B 7E 06        mov di, word ptr [bp + 6]
27BB  81 C7 FB D4     add di, 0xd4fb
27BF  1E              push ds
27C0  57              push di
27C1  8B 7E 08        mov di, word ptr [bp + 8]
27C4  81 C7 FB D4     add di, 0xd4fb
27C8  1E              push ds
27C9  57              push di
27CA  6A 01           push 1
27CC  9A 03 02 BC 24  call far 24BC:0203
27D1  C7 46 FE 01 00  mov word ptr [bp - 2], 1
27D6  EB 03           jmp 0x27db
loc_27D8:
27D8  FF 46 FE        inc word ptr [bp - 2]
loc_27DB:
27DB  8B 46 FE        mov ax, word ptr [bp - 2]
27DE  C4 7E FA        les di, ptr [bp - 6]
27E1  03 F8           add di, ax
27E3  26 8A 45 08     mov al, byte ptr es:[di + 8]
27E7  30 E4           xor ah, ah
27E9  3B 46 06        cmp ax, word ptr [bp + 6]
27EC  74 13           je 0x2801
27EE  8B 46 FE        mov ax, word ptr [bp - 2]
27F1  C4 7E FA        les di, ptr [bp - 6]
27F4  03 F8           add di, ax
27F6  26 8A 45 08     mov al, byte ptr es:[di + 8]
27FA  30 E4           xor ah, ah
27FC  3B 46 08        cmp ax, word ptr [bp + 8]
27FF  75 2B           jne 0x282c
loc_2801:
2801  8B 46 FE        mov ax, word ptr [bp - 2]
2804  C4 7E FA        les di, ptr [bp - 6]
2807  03 F8           add di, ax
2809  26 8A 45 08     mov al, byte ptr es:[di + 8]
280D  30 E4           xor ah, ah
280F  3B 46 08        cmp ax, word ptr [bp + 8]
2812  B0 00           mov al, 0
2814  75 01           jne 0x2817
2816  40              inc ax
loc_2817:
2817  98              cwde
2818  8B F8           mov di, ax
281A  8A 95 60 03     mov dl, byte ptr [di + 0x360]
281E  8B 46 FE        mov ax, word ptr [bp - 2]
2821  C4 7E FA        les di, ptr [bp - 6]
2824  03 F8           add di, ax
2826  26 00 55 08     add byte ptr es:[di + 8], dl
282A  EB 06           jmp 0x2832
loc_282C:
282C  83 7E FE 06     cmp word ptr [bp - 2], 6
2830  75 A6           jne 0x27d8
loc_2832:
2832  C9              leave
2833  C2 06 00        ret 6

; ---- routine 06E8:2836  (found by: call)
sub_2836:
2836  C8 0A 00 00     enter 0xa, 0
283A  C4 3E D2 D7     les di, ptr [0xd7d2]
283E  89 7E F6        mov word ptr [bp - 0xa], di
2841  8C 46 F8        mov word ptr [bp - 8], es
2844  C7 46 FE 01 00  mov word ptr [bp - 2], 1
2849  EB 03           jmp 0x284e
loc_284B:
284B  FF 46 FE        inc word ptr [bp - 2]
loc_284E:
284E  8B 46 FE        mov ax, word ptr [bp - 2]
2851  C4 7E F6        les di, ptr [bp - 0xa]
2854  03 F8           add di, ax
2856  26 80 7D 08 00  cmp byte ptr es:[di + 8], 0
285B  74 3A           je 0x2897
285D  C7 46 FC 01 00  mov word ptr [bp - 4], 1
2862  EB 03           jmp 0x2867
loc_2864:
2864  FF 46 FC        inc word ptr [bp - 4]
loc_2867:
2867  8B 46 FE        mov ax, word ptr [bp - 2]
286A  C4 7E F6        les di, ptr [bp - 0xa]
286D  03 F8           add di, ax
286F  26 8A 45 08     mov al, byte ptr es:[di + 8]
2873  8B 7E FC        mov di, word ptr [bp - 4]
2876  3A 85 FB D4     cmp al, byte ptr [di - 0x2b05]
287A  75 14           jne 0x2890
287C  8A 56 FC        mov dl, byte ptr [bp - 4]
287F  8B 46 FE        mov ax, word ptr [bp - 2]
2882  C4 7E F6        les di, ptr [bp - 0xa]
2885  03 F8           add di, ax
2887  26 88 55 08     mov byte ptr es:[di + 8], dl
288B  C7 46 FC B0 00  mov word ptr [bp - 4], 0xb0
loc_2890:
2890  81 7E FC B0 00  cmp word ptr [bp - 4], 0xb0
2895  75 CD           jne 0x2864
loc_2897:
2897  83 7E FE 06     cmp word ptr [bp - 2], 6
289B  75 AE           jne 0x284b
289D  C7 46 FA 01 00  mov word ptr [bp - 6], 1
28A2  EB 03           jmp 0x28a7
loc_28A4:
28A4  FF 46 FA        inc word ptr [bp - 6]
loc_28A7:
28A7  C7 46 FE 01 00  mov word ptr [bp - 2], 1
28AC  EB 03           jmp 0x28b1
loc_28AE:
28AE  FF 46 FE        inc word ptr [bp - 2]
loc_28B1:
28B1  8B 7E FA        mov di, word ptr [bp - 6]
28B4  8A 85 D7 02     mov al, byte ptr [di + 0x2d7]
28B8  30 E4           xor ah, ah
28BA  03 46 FE        add ax, word ptr [bp - 2]
28BD  50              push ax
28BE  8B 7E FA        mov di, word ptr [bp - 6]
28C1  8A 85 D7 02     mov al, byte ptr [di + 0x2d7]
28C5  30 E4           xor ah, ah
28C7  2D 03 00        sub ax, 3
28CA  03 46 FE        add ax, word ptr [bp - 2]
28CD  50              push ax
28CE  8B 7E 04        mov di, word ptr [bp + 4]
28D1  57              push di
28D2  E8 D5 FE        call 0x27aa
28D5  83 7E FE 03     cmp word ptr [bp - 2], 3
28D9  75 D3           jne 0x28ae
28DB  83 7E FA 03     cmp word ptr [bp - 6], 3
28DF  75 C3           jne 0x28a4
28E1  C9              leave
28E2  C2 02 00        ret 2

; ---- routine 06E8:28E5  (found by: call)
sub_28E5:
28E5  C8 06 00 00     enter 6, 0
loc_28E9:
28E9  C6 46 FB 01     mov byte ptr [bp - 5], 1
28ED  C7 46 FE 11 00  mov word ptr [bp - 2], 0x11
28F2  EB 03           jmp 0x28f7
loc_28F4:
28F4  FF 46 FE        inc word ptr [bp - 2]
loc_28F7:
28F7  8B 7E FE        mov di, word ptr [bp - 2]
28FA  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
28FE  30 E4           xor ah, ah
2900  50              push ax
2901  9A 8E 1B 55 1B  call far 1B55:1B8E
2906  08 C0           or al, al
2908  75 3C           jne 0x2946
290A  C6 46 FB 00     mov byte ptr [bp - 5], 0
290E  8B 7E FE        mov di, word ptr [bp - 2]
2911  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
2915  30 E4           xor ah, ah
2917  89 46 FC        mov word ptr [bp - 4], ax
291A  8B 46 FE        mov ax, word ptr [bp - 2]
291D  40              inc ax
291E  8B F8           mov di, ax
2920  81 C7 D5 D7     add di, 0xd7d5
2924  1E              push ds
2925  57              push di
2926  8B 7E FE        mov di, word ptr [bp - 2]
2929  81 C7 D5 D7     add di, 0xd7d5
292D  1E              push ds
292E  57              push di
292F  B8 60 00        mov ax, 0x60
2932  2B 46 FE        sub ax, word ptr [bp - 2]
2935  50              push ax
2936  9A C2 01 BC 24  call far 24BC:01C2
293B  8A 46 FC        mov al, byte ptr [bp - 4]
293E  A2 35 D8        mov byte ptr [0xd835], al
2941  C7 46 FE 50 00  mov word ptr [bp - 2], 0x50
loc_2946:
2946  83 7E FE 50     cmp word ptr [bp - 2], 0x50
294A  75 A8           jne 0x28f4
294C  80 7E FB 00     cmp byte ptr [bp - 5], 0
2950  74 97           je 0x28e9
2952  C9              leave
2953  C2 02 00        ret 2

; ---- routine 06E8:2956  (found by: call)
sub_2956:
2956  C8 08 00 00     enter 8, 0
295A  C7 46 FA 11 00  mov word ptr [bp - 6], 0x11
loc_295F:
295F  C6 46 F9 01     mov byte ptr [bp - 7], 1
2963  8B 46 FA        mov ax, word ptr [bp - 6]
2966  40              inc ax
2967  3D 60 00        cmp ax, 0x60
296A  77 6E           ja 0x29da
296C  89 46 FE        mov word ptr [bp - 2], ax
296F  EB 03           jmp 0x2974
loc_2971:
2971  FF 46 FE        inc word ptr [bp - 2]
loc_2974:
2974  8B 7E FE        mov di, word ptr [bp - 2]
2977  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
297B  30 E4           xor ah, ah
297D  6B C0 3E        imul ax, ax, 0x3e
2980  C4 3E C2 D7     les di, ptr [0xd7c2]
2984  03 F8           add di, ax
2986  26 80 7D F9 00  cmp byte ptr es:[di - 7], 0
298B  75 47           jne 0x29d4
298D  8B 7E FE        mov di, word ptr [bp - 2]
2990  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
2994  30 E4           xor ah, ah
2996  50              push ax
2997  9A 8E 1B 55 1B  call far 1B55:1B8E
299C  08 C0           or al, al
299E  74 34           je 0x29d4
29A0  C6 46 F9 00     mov byte ptr [bp - 7], 0
29A4  8B 7E FE        mov di, word ptr [bp - 2]
29A7  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
29AB  30 E4           xor ah, ah
29AD  89 46 FC        mov word ptr [bp - 4], ax
29B0  BF E6 D7        mov di, 0xd7e6
29B3  1E              push ds
29B4  57              push di
29B5  BF E7 D7        mov di, 0xd7e7
29B8  1E              push ds
29B9  57              push di
29BA  8B 46 FE        mov ax, word ptr [bp - 2]
29BD  2D 11 00        sub ax, 0x11
29C0  50              push ax
29C1  9A C2 01 BC 24  call far 24BC:01C2
29C6  8A 46 FC        mov al, byte ptr [bp - 4]
29C9  A2 E6 D7        mov byte ptr [0xd7e6], al
29CC  FF 46 FA        inc word ptr [bp - 6]
29CF  C7 46 FE 60 00  mov word ptr [bp - 2], 0x60
loc_29D4:
29D4  83 7E FE 60     cmp word ptr [bp - 2], 0x60
29D8  75 97           jne 0x2971
loc_29DA:
29DA  80 7E F9 00     cmp byte ptr [bp - 7], 0
29DE  75 03           jne 0x29e3
29E0  E9 7C FF        jmp 0x295f
loc_29E3:
29E3  C9              leave
29E4  C2 02 00        ret 2

; ---- routine 06E8:29E7  (found by: call)
sub_29E7:
29E7  C8 06 00 00     enter 6, 0
loc_29EB:
29EB  C6 46 FB 01     mov byte ptr [bp - 5], 1
29EF  C7 46 FE 61 00  mov word ptr [bp - 2], 0x61
29F4  EB 03           jmp 0x29f9
loc_29F6:
29F6  FF 46 FE        inc word ptr [bp - 2]
loc_29F9:
29F9  8B 7E FE        mov di, word ptr [bp - 2]
29FC  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
2A00  30 E4           xor ah, ah
2A02  50              push ax
2A03  9A 8E 1B 55 1B  call far 1B55:1B8E
2A08  08 C0           or al, al
2A0A  74 56           je 0x2a62
2A0C  8B 7E FE        mov di, word ptr [bp - 2]
2A0F  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
2A13  30 E4           xor ah, ah
2A15  6B C0 3E        imul ax, ax, 0x3e
2A18  C4 3E C2 D7     les di, ptr [0xd7c2]
2A1C  03 F8           add di, ax
2A1E  26 80 7D F9 00  cmp byte ptr es:[di - 7], 0
2A23  75 3D           jne 0x2a62
2A25  C6 46 FB 00     mov byte ptr [bp - 5], 0
2A29  BF 35 D8        mov di, 0xd835
2A2C  1E              push ds
2A2D  57              push di
2A2E  8B 7E FE        mov di, word ptr [bp - 2]
2A31  81 C7 D5 D7     add di, 0xd7d5
2A35  1E              push ds
2A36  57              push di
2A37  6A 01           push 1
2A39  9A 03 02 BC 24  call far 24BC:0203
2A3E  A0 35 D8        mov al, byte ptr [0xd835]
2A41  30 E4           xor ah, ah
2A43  89 46 FC        mov word ptr [bp - 4], ax
2A46  BF E6 D7        mov di, 0xd7e6
2A49  1E              push ds
2A4A  57              push di
2A4B  BF E7 D7        mov di, 0xd7e7
2A4E  1E              push ds
2A4F  57              push di
2A50  6A 4F           push 0x4f
2A52  9A C2 01 BC 24  call far 24BC:01C2
2A57  8A 46 FC        mov al, byte ptr [bp - 4]
2A5A  A2 E6 D7        mov byte ptr [0xd7e6], al
2A5D  C7 46 FE B0 00  mov word ptr [bp - 2], 0xb0
loc_2A62:
2A62  81 7E FE B0 00  cmp word ptr [bp - 2], 0xb0
2A67  75 8D           jne 0x29f6
2A69  80 7E FB 00     cmp byte ptr [bp - 5], 0
2A6D  75 03           jne 0x2a72
2A6F  E9 79 FF        jmp 0x29eb
loc_2A72:
2A72  C9              leave
2A73  C2 02 00        ret 2

; ---- routine 06E8:2A76  (found by: call)
sub_2A76:
2A76  C8 0A 00 00     enter 0xa, 0
2A7A  C4 3E D2 D7     les di, ptr [0xd7d2]
2A7E  89 7E F6        mov word ptr [bp - 0xa], di
2A81  8C 46 F8        mov word ptr [bp - 8], es
2A84  BF FC D4        mov di, 0xd4fc
2A87  1E              push ds
2A88  57              push di
2A89  BF D6 D7        mov di, 0xd7d6
2A8C  1E              push ds
2A8D  57              push di
2A8E  68 B0 00        push 0xb0
2A91  9A C2 01 BC 24  call far 24BC:01C2
2A96  C7 46 FE 01 00  mov word ptr [bp - 2], 1
2A9B  EB 03           jmp 0x2aa0
loc_2A9D:
2A9D  FF 46 FE        inc word ptr [bp - 2]
loc_2AA0:
2AA0  8B 46 FE        mov ax, word ptr [bp - 2]
2AA3  C4 7E F6        les di, ptr [bp - 0xa]
2AA6  03 F8           add di, ax
2AA8  26 80 7D 08 00  cmp byte ptr es:[di + 8], 0
2AAD  74 33           je 0x2ae2
2AAF  8B 46 FE        mov ax, word ptr [bp - 2]
2AB2  C4 7E F6        les di, ptr [bp - 0xa]
2AB5  03 F8           add di, ax
2AB7  26 8A 45 08     mov al, byte ptr es:[di + 8]
2ABB  30 E4           xor ah, ah
2ABD  8B F8           mov di, ax
2ABF  81 C7 D5 D7     add di, 0xd7d5
2AC3  1E              push ds
2AC4  57              push di
2AC5  8B 46 FE        mov ax, word ptr [bp - 2]
2AC8  C4 7E F6        les di, ptr [bp - 0xa]
2ACB  03 F8           add di, ax
2ACD  26 8A 45 12     mov al, byte ptr es:[di + 0x12]
2AD1  30 E4           xor ah, ah
2AD3  8B F8           mov di, ax
2AD5  81 C7 D5 D7     add di, 0xd7d5
2AD9  1E              push ds
2ADA  57              push di
2ADB  6A 01           push 1
2ADD  9A 03 02 BC 24  call far 24BC:0203
loc_2AE2:
2AE2  83 7E FE 06     cmp word ptr [bp - 2], 6
2AE6  75 B5           jne 0x2a9d
2AE8  8B 7E 04        mov di, word ptr [bp + 4]
2AEB  57              push di
2AEC  E8 F6 FD        call 0x28e5
2AEF  8B 7E 04        mov di, word ptr [bp + 4]
2AF2  57              push di
2AF3  E8 60 FE        call 0x2956
2AF6  8B 7E 04        mov di, word ptr [bp + 4]
2AF9  57              push di
2AFA  E8 EA FE        call 0x29e7
2AFD  C9              leave
2AFE  C2 02 00        ret 2

; ---- routine 06E8:2B01  (found by: far)
sub_2B01:
2B01  55              push bp
2B02  89 E5           mov bp, sp
2B04  E8 7F F1        call 0x1c86
2B07  BF D6 D7        mov di, 0xd7d6
2B0A  1E              push ds
2B0B  57              push di
2B0C  BF FC D4        mov di, 0xd4fc
2B0F  1E              push ds
2B10  57              push di
2B11  68 B0 00        push 0xb0
2B14  9A C2 01 BC 24  call far 24BC:01C2
2B19  55              push bp
2B1A  E8 19 FD        call 0x2836
2B1D  55              push bp
2B1E  E8 55 FF        call 0x2a76
2B21  C9              leave
2B22  CB              retf

; ---- routine 06E8:2B23  (found by: call)
sub_2B23:
2B23  C8 10 00 00     enter 0x10, 0
2B27  6B 46 06 3E     imul ax, word ptr [bp + 6], 0x3e
2B2B  C4 3E C2 D7     les di, ptr [0xd7c2]
2B2F  03 F8           add di, ax
2B31  81 C7 C2 FF     add di, 0xffc2
2B35  89 7E F6        mov word ptr [bp - 0xa], di
2B38  8C 46 F8        mov word ptr [bp - 8], es
2B3B  31 C0           xor ax, ax
2B3D  89 46 FA        mov word ptr [bp - 6], ax
2B40  26 8A 45 32     mov al, byte ptr es:[di + 0x32]
2B44  30 E4           xor ah, ah
2B46  89 46 F4        mov word ptr [bp - 0xc], ax
2B49  B8 01 00        mov ax, 1
2B4C  3B 46 F4        cmp ax, word ptr [bp - 0xc]
2B4F  77 35           ja 0x2b86
2B51  89 46 FC        mov word ptr [bp - 4], ax
2B54  EB 03           jmp 0x2b59
loc_2B56:
2B56  FF 46 FC        inc word ptr [bp - 4]
loc_2B59:
2B59  8B 46 FC        mov ax, word ptr [bp - 4]
2B5C  D1 E0           shl ax, 1
2B5E  C4 7E F6        les di, ptr [bp - 0xa]
2B61  03 F8           add di, ax
2B63  26 8B 45 FE     mov ax, word ptr es:[di - 2]
2B67  C1 E0 03        shl ax, 3
2B6A  C4 3E BA D7     les di, ptr [0xd7ba]
2B6E  03 F8           add di, ax
2B70  26 8A 45 07     mov al, byte ptr es:[di + 7]
2B74  30 E4           xor ah, ah
2B76  3B 46 04        cmp ax, word ptr [bp + 4]
2B79  75 03           jne 0x2b7e
2B7B  FF 46 FA        inc word ptr [bp - 6]
loc_2B7E:
2B7E  8B 46 FC        mov ax, word ptr [bp - 4]
2B81  3B 46 F4        cmp ax, word ptr [bp - 0xc]
2B84  75 D0           jne 0x2b56
loc_2B86:
2B86  8B 7E 04        mov di, word ptr [bp + 4]
2B89  8A 85 62 03     mov al, byte ptr [di + 0x362]
2B8D  30 E4           xor ah, ah
2B8F  3B 46 FA        cmp ax, word ptr [bp - 6]
2B92  B0 00           mov al, 0
2B94  76 01           jbe 0x2b97
2B96  40              inc ax
loc_2B97:
2B97  88 46 FF        mov byte ptr [bp - 1], al
2B9A  8A 46 FF        mov al, byte ptr [bp - 1]
2B9D  C9              leave
2B9E  C2 04 00        ret 4

; ---- routine 06E8:2BA1  (found by: call)
sub_2BA1:
2BA1  C8 10 01 00     enter 0x110, 0
2BA5  8B 46 04        mov ax, word ptr [bp + 4]
2BA8  C1 E0 03        shl ax, 3
2BAB  C4 3E BA D7     les di, ptr [0xd7ba]
2BAF  03 F8           add di, ax
2BB1  89 7E F4        mov word ptr [bp - 0xc], di
2BB4  8C 46 F6        mov word ptr [bp - 0xa], es
2BB7  31 C0           xor ax, ax
2BB9  89 46 FE        mov word ptr [bp - 2], ax
2BBC  68 B0 00        push 0xb0
2BBF  9A 6D 07 2A 23  call far 232A:076D
2BC4  89 46 FC        mov word ptr [bp - 4], ax
2BC7  C4 7E F4        les di, ptr [bp - 0xc]
2BCA  26 8A 05        mov al, byte ptr es:[di]
2BCD  30 E4           xor ah, ah
2BCF  3B 46 FC        cmp ax, word ptr [bp - 4]
2BD2  75 03           jne 0x2bd7
2BD4  E9 0C 01        jmp 0x2ce3
loc_2BD7:
2BD7  FF 76 FC        push word ptr [bp - 4]
2BDA  9A 7A 0E 55 1B  call far 1B55:0E7A
2BDF  08 C0           or al, al
2BE1  74 03           je 0x2be6
2BE3  E9 FD 00        jmp 0x2ce3
loc_2BE6:
2BE6  6B 46 FC 3E     imul ax, word ptr [bp - 4], 0x3e
2BEA  C4 3E C2 D7     les di, ptr [0xd7c2]
2BEE  03 F8           add di, ax
2BF0  81 C7 C2 FF     add di, 0xffc2
2BF4  89 7E F0        mov word ptr [bp - 0x10], di
2BF7  8C 46 F2        mov word ptr [bp - 0xe], es
2BFA  26 8A 45 37     mov al, byte ptr es:[di + 0x37]
2BFE  98              cwde
2BFF  8B F8           mov di, ax
2C01  8A 85 62 A2     mov al, byte ptr [di - 0x5d9e]
2C05  C4 7E F0        les di, ptr [bp - 0x10]
2C08  26 3A 45 32     cmp al, byte ptr es:[di + 0x32]
2C0C  73 03           jae 0x2c11
2C0E  E9 D2 00        jmp 0x2ce3
loc_2C11:
2C11  C4 7E F4        les di, ptr [bp - 0xc]
2C14  26 8A 45 04     mov al, byte ptr es:[di + 4]
2C18  30 E4           xor ah, ah
2C1A  2D 50 00        sub ax, 0x50
2C1D  8B C8           mov cx, ax
2C1F  6B 46 FC 3E     imul ax, word ptr [bp - 4], 0x3e
2C23  C4 3E C2 D7     les di, ptr [0xd7c2]
2C27  03 F8           add di, ax
2C29  26 8A 45 F5     mov al, byte ptr es:[di - 0xb]
2C2D  30 E4           xor ah, ah
2C2F  8B D0           mov dx, ax
2C31  B8 B1 00        mov ax, 0xb1
2C34  2B C2           sub ax, dx
2C36  2B C1           sub ax, cx
2C38  99              cdq
2C39  31 D0           xor ax, dx
2C3B  29 D0           sub ax, dx
2C3D  3D 0C 00        cmp ax, 0xc
2C40  7C 03           jl 0x2c45
2C42  E9 9E 00        jmp 0x2ce3
loc_2C45:
2C45  8B 7E FC        mov di, word ptr [bp - 4]
2C48  8A 85 85 D8     mov al, byte ptr [di - 0x277b]
2C4C  30 E4           xor ah, ah
2C4E  6B F8 0E        imul di, ax, 0xe
2C51  8D 85 04 94     lea ax, [di - 0x6bfc]
2C55  8C DA           mov dx, ds
2C57  89 46 F8        mov word ptr [bp - 8], ax
2C5A  89 56 FA        mov word ptr [bp - 6], dx
2C5D  C4 7E F4        les di, ptr [bp - 0xc]
2C60  26 8A 05        mov al, byte ptr es:[di]
2C63  30 E4           xor ah, ah
2C65  C4 3E B6 D7     les di, ptr [0xd7b6]
2C69  03 F8           add di, ax
2C6B  26 8A 55 FF     mov dl, byte ptr es:[di - 1]
2C6F  8B 46 FC        mov ax, word ptr [bp - 4]
2C72  C4 3E B6 D7     les di, ptr [0xd7b6]
2C76  03 F8           add di, ax
2C78  26 8A 45 FF     mov al, byte ptr es:[di - 1]
2C7C  3A C2           cmp al, dl
2C7E  74 28           je 0x2ca8
2C80  8B 46 04        mov ax, word ptr [bp + 4]
2C83  C4 3E AE D7     les di, ptr [0xd7ae]
2C87  03 F8           add di, ax
2C89  26 8A 15        mov dl, byte ptr es:[di]
2C8C  8B 46 FC        mov ax, word ptr [bp - 4]
2C8F  C4 3E B6 D7     les di, ptr [0xd7b6]
2C93  03 F8           add di, ax
2C95  26 8A 45 FF     mov al, byte ptr es:[di - 1]
2C99  3A C2           cmp al, dl
2C9B  74 0B           je 0x2ca8
2C9D  6A 0A           push 0xa
2C9F  9A 1C 0D BC 24  call far 24BC:0D1C
2CA4  08 C0           or al, al
2CA6  74 3B           je 0x2ce3
loc_2CA8:
2CA8  8D BE F0 FE     lea di, [bp - 0x110]
2CAC  16              push ss
2CAD  57              push di
2CAE  C4 7E F4        les di, ptr [bp - 0xc]
2CB1  26 8A 45 07     mov al, byte ptr es:[di + 7]
2CB5  50              push ax
2CB6  9A 6F 0C C9 26  call far 26C9:0C6F
2CBB  C4 7E F8        les di, ptr [bp - 8]
2CBE  06              push es
2CBF  57              push di
2CC0  9A FE 0B C9 26  call far 26C9:0BFE
2CC5  09 C0           or ax, ax
2CC7  74 1A           je 0x2ce3
2CC9  FF 76 FC        push word ptr [bp - 4]
2CCC  C4 7E F4        les di, ptr [bp - 0xc]
2CCF  26 8A 45 07     mov al, byte ptr es:[di + 7]
2CD3  30 E4           xor ah, ah
2CD5  50              push ax
2CD6  E8 4A FE        call 0x2b23
2CD9  08 C0           or al, al
2CDB  74 06           je 0x2ce3
2CDD  8B 46 FC        mov ax, word ptr [bp - 4]
2CE0  89 46 FE        mov word ptr [bp - 2], ax
loc_2CE3:
2CE3  8B 46 FE        mov ax, word ptr [bp - 2]
2CE6  C9              leave
2CE7  C2 02 00        ret 2

