; 1-095.EXE (One-Nil 95), code segment 0AB5 (image offsets 0AB50..1993F), part 4 of 22
; packed 1-095.EXE sha256 f659fb2d334500d6901fc8d6a0f06c85c0ccda2eb4a3035ae3bb0a0004d79192 (LZEXE 0.91)
; unpacked (tools/static/unlzexe.py) sha256 8df646e017e0965a5d90a58181ca764219ad847833aad0b6cb58fc53372bfb2c
; tool: capstone 5.0.9 (pip package; core library 5.0.1280) (CS_ARCH_X86, CS_MODE_16), recursive descent from the entry point, far calls and near calls/jumps, then routine prologues (55 89 E5 / 55 8B EC / C8 iw 00) in what remains; tools/static/listing.py
; addresses are SEGMENT:OFFSET with SEGMENT the image paragraph before relocation; image offset = SEGMENT*16+OFFSET
; ---- routine 0AB5:1FB6  (found by: call)
sub_1FB6:
1FB6  C8 02 00 00     enter 2, 0
1FBA  C4 7E 06        les di, ptr [bp + 6]
1FBD  26 8B 05        mov ax, word ptr es:[di]
1FC0  3B 06 46 CF     cmp ax, word ptr [0xcf46]
1FC4  B0 00           mov al, 0
1FC6  75 01           jne 0x1fc9
1FC8  40              inc ax
loc_1FC9:
1FC9  88 46 FF        mov byte ptr [bp - 1], al
1FCC  8A 46 FF        mov al, byte ptr [bp - 1]
1FCF  C9              leave
1FD0  CA 04 00        retf 4

; ---- routine 0AB5:1FD3  (found by: call)
sub_1FD3:
1FD3  C8 02 00 00     enter 2, 0
1FD7  C4 7E 06        les di, ptr [bp + 6]
1FDA  06              push es
1FDB  57              push di
1FDC  0E              push cs
1FDD  E8 EC FE        call 0x1ecc
1FE0  98              cwde
1FE1  8B D0           mov dx, ax
1FE3  C4 7E 06        les di, ptr [bp + 6]
1FE6  26 8A 45 01     mov al, byte ptr es:[di + 1]
1FEA  98              cwde
1FEB  F7 E2           mul dx
1FED  99              cdq
1FEE  8B C8           mov cx, ax
1FF0  8B DA           mov bx, dx
1FF2  8B 46 0A        mov ax, word ptr [bp + 0xa]
1FF5  31 D2           xor dx, dx
1FF7  03 C1           add ax, cx
1FF9  13 D3           adc dx, bx
1FFB  52              push dx
1FFC  50              push ax
1FFD  06              push es
1FFE  57              push di
1FFF  0E              push cs
2000  E8 C9 FE        call 0x1ecc
2003  98              cwde
2004  8B D0           mov dx, ax
2006  A0 47 CF        mov al, byte ptr [0xcf47]
2009  98              cwde
200A  F7 E2           mul dx
200C  99              cdq
200D  59              pop cx
200E  5B              pop bx
200F  3B D3           cmp dx, bx
2011  7F 0A           jg 0x201d
2013  7C 04           jl 0x2019
2015  3B C1           cmp ax, cx
2017  77 04           ja 0x201d
loc_2019:
2019  B0 00           mov al, 0
201B  EB 02           jmp 0x201f
loc_201D:
201D  B0 01           mov al, 1
loc_201F:
201F  88 46 FF        mov byte ptr [bp - 1], al
2022  8A 46 FF        mov al, byte ptr [bp - 1]
2025  C9              leave
2026  CA 06 00        retf 6

; ---- routine 0AB5:2029  (found by: call)
sub_2029:
2029  C8 02 00 00     enter 2, 0
202D  C4 7E 06        les di, ptr [bp + 6]
2030  06              push es
2031  57              push di
2032  0E              push cs
2033  E8 96 FE        call 0x1ecc
2036  98              cwde
2037  8B D0           mov dx, ax
2039  C4 7E 06        les di, ptr [bp + 6]
203C  26 8A 45 01     mov al, byte ptr es:[di + 1]
2040  98              cwde
2041  F7 E2           mul dx
2043  99              cdq
2044  52              push dx
2045  50              push ax
2046  06              push es
2047  57              push di
2048  0E              push cs
2049  E8 80 FE        call 0x1ecc
204C  98              cwde
204D  8B D0           mov dx, ax
204F  A0 47 CF        mov al, byte ptr [0xcf47]
2052  98              cwde
2053  F7 E2           mul dx
2055  99              cdq
2056  8B C8           mov cx, ax
2058  8B DA           mov bx, dx
205A  8B 46 0A        mov ax, word ptr [bp + 0xa]
205D  31 D2           xor dx, dx
205F  03 C1           add ax, cx
2061  13 D3           adc dx, bx
2063  59              pop cx
2064  5B              pop bx
2065  3B D3           cmp dx, bx
2067  7C 0A           jl 0x2073
2069  7F 04           jg 0x206f
206B  3B C1           cmp ax, cx
206D  72 04           jb 0x2073
loc_206F:
206F  B0 00           mov al, 0
2071  EB 02           jmp 0x2075
loc_2073:
2073  B0 01           mov al, 1
loc_2075:
2075  88 46 FF        mov byte ptr [bp - 1], al
2078  8A 46 FF        mov al, byte ptr [bp - 1]
207B  C9              leave
207C  CA 06 00        retf 6

; ---- routine 0AB5:207F  (found by: call)
sub_207F:
207F  C8 02 00 00     enter 2, 0
2083  C4 7E 06        les di, ptr [bp + 6]
2086  06              push es
2087  57              push di
2088  0E              push cs
2089  E8 40 FE        call 0x1ecc
208C  98              cwde
208D  8B D0           mov dx, ax
208F  8A 46 0B        mov al, byte ptr [bp + 0xb]
2092  98              cwde
2093  F7 E2           mul dx
2095  09 C0           or ax, ax
2097  7D 1C           jge 0x20b5
2099  8A 46 0B        mov al, byte ptr [bp + 0xb]
209C  98              cwde
209D  99              cdq
209E  31 D0           xor ax, dx
20A0  29 D0           sub ax, dx
20A2  3D 21 00        cmp ax, 0x21
20A5  7C 0E           jl 0x20b5
20A7  8A 46 0A        mov al, byte ptr [bp + 0xa]
20AA  98              cwde
20AB  99              cdq
20AC  31 D0           xor ax, dx
20AE  29 D0           sub ax, dx
20B0  3D 02 00        cmp ax, 2
20B3  7E 04           jle 0x20b9
loc_20B5:
20B5  B0 00           mov al, 0
20B7  EB 02           jmp 0x20bb
loc_20B9:
20B9  B0 01           mov al, 1
loc_20BB:
20BB  88 46 FF        mov byte ptr [bp - 1], al
20BE  8A 46 FF        mov al, byte ptr [bp - 1]
20C1  C9              leave
20C2  CA 06 00        retf 6

; ---- routine 0AB5:20C5  (found by: call)
sub_20C5:
20C5  C8 02 00 00     enter 2, 0
20C9  8A 46 05        mov al, byte ptr [bp + 5]
20CC  98              cwde
20CD  99              cdq
20CE  31 D0           xor ax, dx
20D0  29 D0           sub ax, dx
20D2  3D 19 00        cmp ax, 0x19
20D5  7C 0E           jl 0x20e5
20D7  8A 46 04        mov al, byte ptr [bp + 4]
20DA  98              cwde
20DB  99              cdq
20DC  31 D0           xor ax, dx
20DE  29 D0           sub ax, dx
20E0  3D 05 00        cmp ax, 5
20E3  7E 04           jle 0x20e9
loc_20E5:
20E5  B0 00           mov al, 0
20E7  EB 02           jmp 0x20eb
loc_20E9:
20E9  B0 01           mov al, 1
loc_20EB:
20EB  88 46 FF        mov byte ptr [bp - 1], al
20EE  8A 46 FF        mov al, byte ptr [bp - 1]
20F1  C9              leave
20F2  C2 02 00        ret 2

; ---- routine 0AB5:20F5  (found by: call)
sub_20F5:
20F5  C8 02 00 00     enter 2, 0
20F9  C4 7E 06        les di, ptr [bp + 6]
20FC  06              push es
20FD  57              push di
20FE  0E              push cs
20FF  E8 CA FD        call 0x1ecc
2102  98              cwde
2103  8B D0           mov dx, ax
2105  8A 46 0B        mov al, byte ptr [bp + 0xb]
2108  98              cwde
2109  F7 E2           mul dx
210B  09 C0           or ax, ax
210D  7D 0A           jge 0x2119
210F  FF 76 0A        push word ptr [bp + 0xa]
2112  E8 B0 FF        call 0x20c5
2115  08 C0           or al, al
2117  75 04           jne 0x211d
loc_2119:
2119  B0 00           mov al, 0
211B  EB 02           jmp 0x211f
loc_211D:
211D  B0 01           mov al, 1
loc_211F:
211F  88 46 FF        mov byte ptr [bp - 1], al
2122  8A 46 FF        mov al, byte ptr [bp - 1]
2125  C9              leave
2126  CA 06 00        retf 6

; ---- routine 0AB5:2129  (found by: call)
sub_2129:
2129  C8 02 00 00     enter 2, 0
212D  C4 7E 06        les di, ptr [bp + 6]
2130  06              push es
2131  57              push di
2132  0E              push cs
2133  E8 96 FD        call 0x1ecc
2136  98              cwde
2137  8B D0           mov dx, ax
2139  8A 46 0B        mov al, byte ptr [bp + 0xb]
213C  98              cwde
213D  F7 E2           mul dx
213F  09 C0           or ax, ax
2141  7E 0A           jle 0x214d
2143  FF 76 0A        push word ptr [bp + 0xa]
2146  E8 7C FF        call 0x20c5
2149  08 C0           or al, al
214B  75 04           jne 0x2151
loc_214D:
214D  B0 00           mov al, 0
214F  EB 02           jmp 0x2153
loc_2151:
2151  B0 01           mov al, 1
loc_2153:
2153  88 46 FF        mov byte ptr [bp - 1], al
2156  8A 46 FF        mov al, byte ptr [bp - 1]
2159  C9              leave
215A  CA 06 00        retf 6

; ---- routine 0AB5:215D  (found by: call)
sub_215D:
215D  C8 02 00 00     enter 2, 0
2161  C4 7E 06        les di, ptr [bp + 6]
2164  06              push es
2165  57              push di
2166  0E              push cs
2167  E8 C9 FD        call 0x1f33
216A  08 C0           or al, al
216C  75 59           jne 0x21c7
216E  C4 7E 06        les di, ptr [bp + 6]
2171  26 8B 45 0E     mov ax, word ptr es:[di + 0xe]
2175  C1 E0 03        shl ax, 3
2178  C4 3E BA D7     les di, ptr [0xd7ba]
217C  03 F8           add di, ax
217E  26 8A 45 06     mov al, byte ptr es:[di + 6]
2182  30 E4           xor ah, ah
2184  05 0C 00        add ax, 0xc
2187  8B C8           mov cx, ax
2189  C4 7E 06        les di, ptr [bp + 6]
218C  26 8A 45 01     mov al, byte ptr es:[di + 1]
2190  98              cwde
2191  99              cdq
2192  31 D0           xor ax, dx
2194  29 D0           sub ax, dx
2196  3B C1           cmp ax, cx
2198  7C 2D           jl 0x21c7
219A  26 8A 45 01     mov al, byte ptr es:[di + 1]
219E  98              cwde
219F  99              cdq
21A0  31 D0           xor ax, dx
21A2  29 D0           sub ax, dx
21A4  3D 1C 00        cmp ax, 0x1c
21A7  B0 00           mov al, 0
21A9  7E 01           jle 0x21ac
21AB  40              inc ax
loc_21AC:
21AC  98              cwde
21AD  8B F8           mov di, ax
21AF  8A 85 12 0A     mov al, byte ptr [di + 0xa12]
21B3  30 E4           xor ah, ah
21B5  8B C8           mov cx, ax
21B7  C4 7E 06        les di, ptr [bp + 6]
21BA  26 8A 05        mov al, byte ptr es:[di]
21BD  98              cwde
21BE  99              cdq
21BF  31 D0           xor ax, dx
21C1  29 D0           sub ax, dx
21C3  3B C1           cmp ax, cx
21C5  7E 04           jle 0x21cb
loc_21C7:
21C7  B0 00           mov al, 0
21C9  EB 02           jmp 0x21cd
loc_21CB:
21CB  B0 01           mov al, 1
loc_21CD:
21CD  88 46 FF        mov byte ptr [bp - 1], al
21D0  8A 46 FF        mov al, byte ptr [bp - 1]
21D3  C9              leave
21D4  CA 04 00        retf 4

; ---- routine 0AB5:21D7  (found by: call)
sub_21D7:
21D7  C8 0E 00 00     enter 0xe, 0
21DB  C6 46 FF 00     mov byte ptr [bp - 1], 0
21DF  EB 03           jmp 0x21e4
loc_21E1:
21E1  FE 46 FF        inc byte ptr [bp - 1]
loc_21E4:
21E4  8A 46 FF        mov al, byte ptr [bp - 1]
21E7  98              cwde
21E8  8B F8           mov di, ax
21EA  8A 85 56 0D     mov al, byte ptr [di + 0xd56]
21EE  30 E4           xor ah, ah
21F0  40              inc ax
21F1  8A D0           mov dl, al
21F3  8A 46 FF        mov al, byte ptr [bp - 1]
21F6  98              cwde
21F7  8B F8           mov di, ax
21F9  88 95 A4 D0     mov byte ptr [di - 0x2f5c], dl
21FD  8A 46 FF        mov al, byte ptr [bp - 1]
2200  98              cwde
2201  8B F8           mov di, ax
2203  C6 85 A2 D0 00  mov byte ptr [di - 0x2f5e], 0
2208  C7 46 FA 64 00  mov word ptr [bp - 6], 0x64
220D  C7 46 F8 64 00  mov word ptr [bp - 8], 0x64
2212  C7 46 FC 02 00  mov word ptr [bp - 4], 2
2217  EB 03           jmp 0x221c
loc_2219:
2219  FF 46 FC        inc word ptr [bp - 4]
loc_221C:
221C  8A 46 FF        mov al, byte ptr [bp - 1]
221F  98              cwde
2220  8B F8           mov di, ax
2222  8A 85 56 0D     mov al, byte ptr [di + 0xd56]
2226  30 E4           xor ah, ah
2228  03 46 FC        add ax, word ptr [bp - 4]
222B  6B F8 19        imul di, ax, 0x19
222E  81 C7 EF CC     add di, 0xccef
2232  1E              push ds
2233  07              pop es
2234  89 7E F2        mov word ptr [bp - 0xe], di
2237  8C 46 F4        mov word ptr [bp - 0xc], es
223A  06              push es
223B  57              push di
223C  0E              push cs
223D  E8 61 FA        call 0x1ca1
2240  08 C0           or al, al
2242  74 03           je 0x2247
2244  E9 A9 00        jmp 0x22f0
loc_2247:
2247  A0 9F D0        mov al, byte ptr [0xd09f]
224A  C4 7E F2        les di, ptr [bp - 0xe]
224D  26 3A 45 07     cmp al, byte ptr es:[di + 7]
2251  75 03           jne 0x2256
2253  E9 9A 00        jmp 0x22f0
loc_2256:
2256  26 80 7D 13 0D  cmp byte ptr es:[di + 0x13], 0xd
225B  75 03           jne 0x2260
225D  E9 90 00        jmp 0x22f0
loc_2260:
2260  A0 46 CF        mov al, byte ptr [0xcf46]
2263  98              cwde
2264  8B D0           mov dx, ax
2266  26 8A 05        mov al, byte ptr es:[di]
2269  98              cwde
226A  2B C2           sub ax, dx
226C  99              cdq
226D  31 D0           xor ax, dx
226F  29 D0           sub ax, dx
2271  8B C8           mov cx, ax
2273  A0 47 CF        mov al, byte ptr [0xcf47]
2276  98              cwde
2277  8B D0           mov dx, ax
2279  26 8A 45 01     mov al, byte ptr es:[di + 1]
227D  98              cwde
227E  2B C2           sub ax, dx
2280  99              cdq
2281  31 D0           xor ax, dx
2283  29 D0           sub ax, dx
2285  03 C1           add ax, cx
2287  89 46 F6        mov word ptr [bp - 0xa], ax
228A  8B 46 F6        mov ax, word ptr [bp - 0xa]
228D  3B 46 FA        cmp ax, word ptr [bp - 6]
2290  73 14           jae 0x22a6
2292  26 8A 55 07     mov dl, byte ptr es:[di + 7]
2296  8A 46 FF        mov al, byte ptr [bp - 1]
2299  98              cwde
229A  8B F8           mov di, ax
229C  88 95 A4 D0     mov byte ptr [di - 0x2f5c], dl
22A0  8B 46 F6        mov ax, word ptr [bp - 0xa]
22A3  89 46 FA        mov word ptr [bp - 6], ax
loc_22A6:
22A6  C4 7E F2        les di, ptr [bp - 0xe]
22A9  06              push es
22AA  57              push di
22AB  0E              push cs
22AC  E8 1D FC        call 0x1ecc
22AF  98              cwde
22B0  8B D0           mov dx, ax
22B2  A0 47 CF        mov al, byte ptr [0xcf47]
22B5  98              cwde
22B6  F7 E2           mul dx
22B8  50              push ax
22B9  C4 7E F2        les di, ptr [bp - 0xe]
22BC  06              push es
22BD  57              push di
22BE  0E              push cs
22BF  E8 0A FC        call 0x1ecc
22C2  98              cwde
22C3  8B D0           mov dx, ax
22C5  C4 7E F2        les di, ptr [bp - 0xe]
22C8  26 8A 45 01     mov al, byte ptr es:[di + 1]
22CC  98              cwde
22CD  F7 E2           mul dx
22CF  5A              pop dx
22D0  3B C2           cmp ax, dx
22D2  7D 1C           jge 0x22f0
22D4  8B 46 F6        mov ax, word ptr [bp - 0xa]
22D7  3B 46 F8        cmp ax, word ptr [bp - 8]
22DA  73 14           jae 0x22f0
22DC  26 8A 55 07     mov dl, byte ptr es:[di + 7]
22E0  8A 46 FF        mov al, byte ptr [bp - 1]
22E3  98              cwde
22E4  8B F8           mov di, ax
22E6  88 95 A2 D0     mov byte ptr [di - 0x2f5e], dl
22EA  8B 46 F6        mov ax, word ptr [bp - 0xa]
22ED  89 46 F8        mov word ptr [bp - 8], ax
loc_22F0:
22F0  83 7E FC 0B     cmp word ptr [bp - 4], 0xb
22F4  74 03           je 0x22f9
22F6  E9 20 FF        jmp 0x2219
loc_22F9:
22F9  80 7E FF 01     cmp byte ptr [bp - 1], 1
22FD  74 03           je 0x2302
22FF  E9 DF FE        jmp 0x21e1
loc_2302:
2302  C9              leave
2303  C3              ret

; ---- routine 0AB5:2304  (found by: call)
sub_2304:
2304  C8 02 00 00     enter 2, 0
2308  C4 7E 06        les di, ptr [bp + 6]
230B  06              push es
230C  57              push di
230D  0E              push cs
230E  E8 AA F9        call 0x1cbb
2311  98              cwde
2312  8B F8           mov di, ax
2314  8A 85 56 0D     mov al, byte ptr [di + 0xd56]
2318  30 E4           xor ah, ah
231A  03 46 0A        add ax, word ptr [bp + 0xa]
231D  89 46 FE        mov word ptr [bp - 2], ax
2320  8B 46 FE        mov ax, word ptr [bp - 2]
2323  C9              leave
2324  CA 06 00        retf 6

; ---- routine 0AB5:2327  (found by: call)
sub_2327:
2327  C8 0E 00 00     enter 0xe, 0
232B  6A 03           push 3
232D  C4 7E 06        les di, ptr [bp + 6]
2330  06              push es
2331  57              push di
2332  0E              push cs
2333  E8 16 F7        call 0x1a4c
2336  08 C0           or al, al
2338  75 22           jne 0x235c
233A  C4 7E 06        les di, ptr [bp + 6]
233D  06              push es
233E  57              push di
233F  0E              push cs
2340  E8 F0 FB        call 0x1f33
2343  08 C0           or al, al
2345  74 11           je 0x2358
2347  C4 7E 06        les di, ptr [bp + 6]
234A  26 8A 45 07     mov al, byte ptr es:[di + 7]
234E  30 E4           xor ah, ah
2350  50              push ax
2351  E8 AC DC        call 0
2354  08 C0           or al, al
2356  74 04           je 0x235c
loc_2358:
2358  B0 00           mov al, 0
235A  EB 02           jmp 0x235e
loc_235C:
235C  B0 01           mov al, 1
loc_235E:
235E  88 46 F5        mov byte ptr [bp - 0xb], al
2361  E8 3C F6        call 0x19a0
2364  8B D0           mov dx, ax
2366  8A 46 F5        mov al, byte ptr [bp - 0xb]
2369  98              cwde
236A  8B F8           mov di, ax
236C  8A 85 14 0A     mov al, byte ptr [di + 0xa14]
2370  30 E4           xor ah, ah
2372  03 C2           add ax, dx
2374  89 46 F6        mov word ptr [bp - 0xa], ax
2377  C4 7E 06        les di, ptr [bp + 6]
237A  26 8A 45 07     mov al, byte ptr es:[di + 7]
237E  30 E4           xor ah, ah
2380  89 46 FA        mov word ptr [bp - 6], ax
2383  6A 02           push 2
2385  06              push es
2386  57              push di
2387  0E              push cs
2388  E8 79 FF        call 0x2304
238B  89 46 F2        mov word ptr [bp - 0xe], ax
238E  6A 0B           push 0xb
2390  C4 7E 06        les di, ptr [bp + 6]
2393  06              push es
2394  57              push di
2395  0E              push cs
2396  E8 6B FF        call 0x2304
2399  3B 46 F2        cmp ax, word ptr [bp - 0xe]
239C  73 03           jae 0x23a1
239E  E9 D7 00        jmp 0x2478
loc_23A1:
23A1  89 46 FC        mov word ptr [bp - 4], ax
23A4  EB 03           jmp 0x23a9
loc_23A6:
23A6  FF 4E FC        dec word ptr [bp - 4]
loc_23A9:
23A9  C4 7E 06        les di, ptr [bp + 6]
23AC  26 8A 45 07     mov al, byte ptr es:[di + 7]
23B0  30 E4           xor ah, ah
23B2  3B 46 FC        cmp ax, word ptr [bp - 4]
23B5  75 03           jne 0x23ba
23B7  E9 B3 00        jmp 0x246d
loc_23BA:
23BA  6B 7E FC 19     imul di, word ptr [bp - 4], 0x19
23BE  81 C7 EF CC     add di, 0xccef
23C2  1E              push ds
23C3  57              push di
23C4  0E              push cs
23C5  E8 D9 F8        call 0x1ca1
23C8  08 C0           or al, al
23CA  74 03           je 0x23cf
23CC  E9 9E 00        jmp 0x246d
loc_23CF:
23CF  6A 0A           push 0xa
23D1  6B 7E FC 19     imul di, word ptr [bp - 4], 0x19
23D5  81 C7 EF CC     add di, 0xccef
23D9  1E              push ds
23DA  57              push di
23DB  0E              push cs
23DC  E8 F4 FB        call 0x1fd3
23DF  08 C0           or al, al
23E1  74 03           je 0x23e6
23E3  E9 87 00        jmp 0x246d
loc_23E6:
23E6  6B 7E FC 19     imul di, word ptr [bp - 4], 0x19
23EA  80 BD 02 CD 0D  cmp byte ptr [di - 0x32fe], 0xd
23EF  74 7C           je 0x246d
23F1  8B 46 F6        mov ax, word ptr [bp - 0xa]
23F4  89 46 F8        mov word ptr [bp - 8], ax
23F7  C4 7E 06        les di, ptr [bp + 6]
23FA  26 8A 05        mov al, byte ptr es:[di]
23FD  98              cwde
23FE  8B D0           mov dx, ax
2400  6B 7E FC 19     imul di, word ptr [bp - 4], 0x19
2404  8A 85 EF CC     mov al, byte ptr [di - 0x3311]
2408  98              cwde
2409  2B C2           sub ax, dx
240B  99              cdq
240C  31 D0           xor ax, dx
240E  29 D0           sub ax, dx
2410  8B C8           mov cx, ax
2412  C4 7E 06        les di, ptr [bp + 6]
2415  26 8A 45 01     mov al, byte ptr es:[di + 1]
2419  98              cwde
241A  8B D0           mov dx, ax
241C  6B 7E FC 19     imul di, word ptr [bp - 4], 0x19
2420  8A 85 F0 CC     mov al, byte ptr [di - 0x3310]
2424  98              cwde
2425  2B C2           sub ax, dx
2427  99              cdq
2428  31 D0           xor ax, dx
242A  29 D0           sub ax, dx
242C  03 C1           add ax, cx
242E  89 46 F6        mov word ptr [bp - 0xa], ax
2431  8B 46 F6        mov ax, word ptr [bp - 0xa]
2434  3B 46 F8        cmp ax, word ptr [bp - 8]
2437  B0 00           mov al, 0
2439  76 01           jbe 0x243c
243B  40              inc ax
loc_243C:
243C  3A 46 F5        cmp al, byte ptr [bp - 0xb]
243F  75 26           jne 0x2467
2441  C4 7E 06        les di, ptr [bp + 6]
2444  26 8A 45 07     mov al, byte ptr es:[di + 7]
2448  30 E4           xor ah, ah
244A  3B 46 FA        cmp ax, word ptr [bp - 6]
244D  74 09           je 0x2458
244F  9A 3F 0D AC 24  call far 24AC:0D3F
2454  08 C0           or al, al
2456  74 0F           je 0x2467
loc_2458:
2458  6B 7E FC 19     imul di, word ptr [bp - 4], 0x19
245C  8A 85 F6 CC     mov al, byte ptr [di - 0x330a]
2460  30 E4           xor ah, ah
2462  89 46 FA        mov word ptr [bp - 6], ax
2465  EB 06           jmp 0x246d
loc_2467:
2467  8B 46 F8        mov ax, word ptr [bp - 8]
246A  89 46 F6        mov word ptr [bp - 0xa], ax
loc_246D:
246D  8B 46 FC        mov ax, word ptr [bp - 4]
2470  3B 46 F2        cmp ax, word ptr [bp - 0xe]
2473  74 03           je 0x2478
2475  E9 2E FF        jmp 0x23a6
loc_2478:
2478  C4 7E 06        les di, ptr [bp + 6]
247B  26 8A 45 07     mov al, byte ptr es:[di + 7]
247F  30 E4           xor ah, ah
2481  3B 46 FA        cmp ax, word ptr [bp - 6]
2484  75 58           jne 0x24de
2486  6A 0B           push 0xb
2488  06              push es
2489  57              push di
248A  0E              push cs
248B  E8 76 FE        call 0x2304
248E  89 46 F2        mov word ptr [bp - 0xe], ax
2491  6A 02           push 2
2493  C4 7E 06        les di, ptr [bp + 6]
2496  06              push es
2497  57              push di
2498  0E              push cs
2499  E8 68 FE        call 0x2304
249C  3B 46 F2        cmp ax, word ptr [bp - 0xe]
249F  77 3D           ja 0x24de
24A1  89 46 FC        mov word ptr [bp - 4], ax
24A4  EB 03           jmp 0x24a9
loc_24A6:
24A6  FF 46 FC        inc word ptr [bp - 4]
loc_24A9:
24A9  C4 7E 06        les di, ptr [bp + 6]
24AC  26 8A 45 07     mov al, byte ptr es:[di + 7]
24B0  30 E4           xor ah, ah
24B2  3B 46 FC        cmp ax, word ptr [bp - 4]
24B5  74 1F           je 0x24d6
24B7  6B 7E FC 19     imul di, word ptr [bp - 4], 0x19
24BB  81 C7 EF CC     add di, 0xccef
24BF  1E              push ds
24C0  57              push di
24C1  0E              push cs
24C2  E8 DC F7        call 0x1ca1
24C5  08 C0           or al, al
24C7  75 0D           jne 0x24d6
24C9  6B 7E FC 19     imul di, word ptr [bp - 4], 0x19
24CD  8A 85 F6 CC     mov al, byte ptr [di - 0x330a]
24D1  30 E4           xor ah, ah
24D3  89 46 FA        mov word ptr [bp - 6], ax
loc_24D6:
24D6  8B 46 FC        mov ax, word ptr [bp - 4]
24D9  3B 46 F2        cmp ax, word ptr [bp - 0xe]
24DC  75 C8           jne 0x24a6
loc_24DE:
24DE  8B 46 FA        mov ax, word ptr [bp - 6]
24E1  89 46 FE        mov word ptr [bp - 2], ax
24E4  8B 46 FE        mov ax, word ptr [bp - 2]
24E7  C9              leave
24E8  CA 04 00        retf 4

; ---- routine 0AB5:24EB  (found by: call)
sub_24EB:
24EB  55              push bp
24EC  89 E5           mov bp, sp
24EE  C4 7E 06        les di, ptr [bp + 6]
24F1  06              push es
24F2  57              push di
24F3  0E              push cs
24F4  E8 30 FE        call 0x2327
24F7  50              push ax
24F8  C4 7E 06        les di, ptr [bp + 6]
24FB  06              push es
24FC  57              push di
24FD  0E              push cs
24FE  E8 39 04        call 0x293a
2501  C9              leave
2502  CA 04 00        retf 4

; ---- routine 0AB5:2505  (found by: call)
sub_2505:
2505  C8 04 00 00     enter 4, 0
2509  80 3E B8 D0 00  cmp byte ptr [0xd0b8], 0
250E  75 08           jne 0x2518
2510  C6 06 B8 D0 01  mov byte ptr [0xd0b8], 1
2515  E9 09 01        jmp 0x2621
loc_2518:
2518  6A 0B           push 0xb
251A  8B 7E 04        mov di, word ptr [bp + 4]
251D  36 C4 7D 06     les di, ptr ss:[di + 6]
2521  06              push es
2522  57              push di
2523  0E              push cs
2524  E8 DD FD        call 0x2304
2527  89 46 FC        mov word ptr [bp - 4], ax
252A  6A 01           push 1
252C  8B 7E 04        mov di, word ptr [bp + 4]
252F  36 C4 7D 06     les di, ptr ss:[di + 6]
2533  06              push es
2534  57              push di
2535  0E              push cs
2536  E8 CB FD        call 0x2304
2539  3B 46 FC        cmp ax, word ptr [bp - 4]
253C  76 03           jbe 0x2541
253E  E9 E0 00        jmp 0x2621
loc_2541:
2541  89 46 FE        mov word ptr [bp - 2], ax
2544  EB 03           jmp 0x2549
loc_2546:
2546  FF 46 FE        inc word ptr [bp - 2]
loc_2549:
2549  6B 7E FE 19     imul di, word ptr [bp - 2], 0x19
254D  8A 85 F6 CC     mov al, byte ptr [di - 0x330a]
2551  8B 7E 04        mov di, word ptr [bp + 4]
2554  36 C4 7D 06     les di, ptr ss:[di + 6]
2558  26 3A 45 07     cmp al, byte ptr es:[di + 7]
255C  75 03           jne 0x2561
255E  E9 B5 00        jmp 0x2616
loc_2561:
2561  80 3E A1 D0 00  cmp byte ptr [0xd0a1], 0
2566  74 03           je 0x256b
2568  E9 AB 00        jmp 0x2616
loc_256B:
256B  6B 7E FE 19     imul di, word ptr [bp - 2], 0x19
256F  8A 85 F6 CC     mov al, byte ptr [di - 0x330a]
2573  3A 06 9E D0     cmp al, byte ptr [0xd09e]
2577  75 03           jne 0x257c
2579  E9 9A 00        jmp 0x2616
loc_257C:
257C  6A 00           push 0
257E  6B 7E FE 19     imul di, word ptr [bp - 2], 0x19
2582  81 C7 EF CC     add di, 0xccef
2586  1E              push ds
2587  57              push di
2588  0E              push cs
2589  E8 9D FA        call 0x2029
258C  08 C0           or al, al
258E  75 03           jne 0x2593
2590  E9 83 00        jmp 0x2616
loc_2593:
2593  A0 BB D0        mov al, byte ptr [0xd0bb]
2596  3C 01           cmp al, 1
2598  72 04           jb 0x259e
259A  3C 04           cmp al, 4
259C  76 78           jbe 0x2616
loc_259E:
259E  E8 35 F7        call 0x1cd6
25A1  08 C0           or al, al
25A3  B0 00           mov al, 0
25A5  75 01           jne 0x25a8
25A7  40              inc ax
loc_25A8:
25A8  98              cwde
25A9  6B F8 07        imul di, ax, 7
25AC  8A 85 2F CF     mov al, byte ptr [di - 0x30d1]
25B0  98              cwde
25B1  99              cdq
25B2  31 D0           xor ax, dx
25B4  29 D0           sub ax, dx
25B6  8B C8           mov cx, ax
25B8  6B 7E FE 19     imul di, word ptr [bp - 2], 0x19
25BC  8A 85 F0 CC     mov al, byte ptr [di - 0x3310]
25C0  98              cwde
25C1  99              cdq
25C2  31 D0           xor ax, dx
25C4  29 D0           sub ax, dx
25C6  3B C1           cmp ax, cx
25C8  7E 4C           jle 0x2616
25CA  6B 7E FE 19     imul di, word ptr [bp - 2], 0x19
25CE  81 C7 EF CC     add di, 0xccef
25D2  1E              push ds
25D3  57              push di
25D4  0E              push cs
25D5  E8 F4 F8        call 0x1ecc
25D8  08 C0           or al, al
25DA  B0 00           mov al, 0
25DC  7E 01           jle 0x25df
25DE  40              inc ax
loc_25DF:
25DF  8A D0           mov dl, al
25E1  6B 7E FE 19     imul di, word ptr [bp - 2], 0x19
25E5  80 BD F0 CC 00  cmp byte ptr [di - 0x3310], 0
25EA  B0 00           mov al, 0
25EC  7E 01           jle 0x25ef
25EE  40              inc ax
loc_25EF:
25EF  3A C2           cmp al, dl
25F1  75 23           jne 0x2616
25F3  6B 7E FE 19     imul di, word ptr [bp - 2], 0x19
25F7  80 BD 00 CD 00  cmp byte ptr [di - 0x3300], 0
25FC  75 18           jne 0x2616
25FE  8A 46 FE        mov al, byte ptr [bp - 2]
2601  A2 A1 D0        mov byte ptr [0xd0a1], al
2604  6B 7E FE 19     imul di, word ptr [bp - 2], 0x19
2608  8B 85 EF CC     mov ax, word ptr [di - 0x3311]
260C  A3 AA D0        mov word ptr [0xd0aa], ax
260F  C6 06 BD D0 00  mov byte ptr [0xd0bd], 0
2614  EB 0B           jmp 0x2621
loc_2616:
2616  8B 46 FE        mov ax, word ptr [bp - 2]
2619  3B 46 FC        cmp ax, word ptr [bp - 4]
261C  74 03           je 0x2621
261E  E9 25 FF        jmp 0x2546
loc_2621:
2621  C9              leave
2622  C2 02 00        ret 2

; ---- routine 0AB5:2625  (found by: call)
sub_2625:
2625  C8 06 00 00     enter 6, 0
2629  C4 7E 06        les di, ptr [bp + 6]
262C  26 C6 45 10 05  mov byte ptr es:[di + 0x10], 5
2631  8B 46 0C        mov ax, word ptr [bp + 0xc]
2634  89 46 FE        mov word ptr [bp - 2], ax
2637  C6 06 53 CF 01  mov byte ptr [0xcf53], 1
263C  26 8A 45 07     mov al, byte ptr es:[di + 7]
2640  A2 9F D0        mov byte ptr [0xd09f], al
2643  A0 46 CF        mov al, byte ptr [0xcf46]
2646  28 46 FE        sub byte ptr [bp - 2], al
2649  A0 47 CF        mov al, byte ptr [0xcf47]
264C  28 46 FF        sub byte ptr [bp - 1], al
264F  31 C0           xor ax, ax
2651  A3 4D CF        mov word ptr [0xcf4d], ax
2654  31 C0           xor ax, ax
2656  A3 4F CF        mov word ptr [0xcf4f], ax
2659  8A 46 FF        mov al, byte ptr [bp - 1]
265C  98              cwde
265D  99              cdq
265E  31 D0           xor ax, dx
2660  29 D0           sub ax, dx
2662  8B C8           mov cx, ax
2664  8A 46 FE        mov al, byte ptr [bp - 2]
2667  98              cwde
2668  99              cdq
2669  31 D0           xor ax, dx
266B  29 D0           sub ax, dx
266D  3B C1           cmp ax, cx
266F  7E 62           jle 0x26d3
2671  80 7E FE 00     cmp byte ptr [bp - 2], 0
2675  B0 00           mov al, 0
2677  7E 01           jle 0x267a
2679  40              inc ax
loc_267A:
267A  98              cwde
267B  8B F8           mov di, ax
267D  8A 85 38 A3     mov al, byte ptr [di - 0x5cc8]
2681  98              cwde
2682  A3 4D CF        mov word ptr [0xcf4d], ax
2685  8A 46 FE        mov al, byte ptr [bp - 2]
2688  98              cwde
2689  99              cdq
268A  31 D0           xor ax, dx
268C  29 D0           sub ax, dx
268E  A3 51 CF        mov word ptr [0xcf51], ax
2691  8A 46 FE        mov al, byte ptr [bp - 2]
2694  98              cwde
2695  99              cdq
2696  31 D0           xor ax, dx
2698  29 D0           sub ax, dx
269A  99              cdq
269B  B9 02 00        mov cx, 2
269E  F7 F9           idiv cx
26A0  8B C8           mov cx, ax
26A2  8A 46 FF        mov al, byte ptr [bp - 1]
26A5  98              cwde
26A6  99              cdq
26A7  31 D0           xor ax, dx
26A9  29 D0           sub ax, dx
26AB  3B C1           cmp ax, cx
26AD  7C 21           jl 0x26d0
26AF  80 7E FF 00     cmp byte ptr [bp - 1], 0
26B3  B0 00           mov al, 0
26B5  7E 01           jle 0x26b8
26B7  40              inc ax
loc_26B8:
26B8  98              cwde
26B9  8B F8           mov di, ax
26BB  8A 85 38 A3     mov al, byte ptr [di - 0x5cc8]
26BF  98              cwde
26C0  A3 4F CF        mov word ptr [0xcf4f], ax
26C3  8A 46 FF        mov al, byte ptr [bp - 1]
26C6  98              cwde
26C7  99              cdq
26C8  31 D0           xor ax, dx
26CA  29 D0           sub ax, dx
26CC  01 06 51 CF     add word ptr [0xcf51], ax
loc_26D0:
26D0  E9 92 00        jmp 0x2765
loc_26D3:
26D3  80 7E FF 00     cmp byte ptr [bp - 1], 0
26D7  B0 00           mov al, 0
26D9  7E 01           jle 0x26dc
26DB  40              inc ax
loc_26DC:
26DC  98              cwde
26DD  8B F8           mov di, ax
26DF  8A 85 38 A3     mov al, byte ptr [di - 0x5cc8]
26E3  98              cwde
26E4  A3 4F CF        mov word ptr [0xcf4f], ax
26E7  8A 46 FF        mov al, byte ptr [bp - 1]
26EA  98              cwde
26EB  99              cdq
26EC  31 D0           xor ax, dx
26EE  29 D0           sub ax, dx
26F0  A3 51 CF        mov word ptr [0xcf51], ax
26F3  8A 46 FE        mov al, byte ptr [bp - 2]
26F6  98              cwde
26F7  99              cdq
26F8  31 D0           xor ax, dx
26FA  29 D0           sub ax, dx
26FC  09 C0           or ax, ax
26FE  7E 65           jle 0x2765
2700  8A 46 FF        mov al, byte ptr [bp - 1]
2703  98              cwde
2704  99              cdq
2705  31 D0           xor ax, dx
2707  29 D0           sub ax, dx
2709  99              cdq
270A  B9 02 00        mov cx, 2
270D  F7 F9           idiv cx
270F  8B C8           mov cx, ax
2711  8A 46 FE        mov al, byte ptr [bp - 2]
2714  98              cwde
2715  99              cdq
2716  31 D0           xor ax, dx
2718  29 D0           sub ax, dx
271A  3B C1           cmp ax, cx
271C  7C 47           jl 0x2765
271E  80 7E FE 00     cmp byte ptr [bp - 2], 0
2722  B0 00           mov al, 0
2724  7E 01           jle 0x2727
2726  40              inc ax
loc_2727:
2727  98              cwde
2728  8B F8           mov di, ax
272A  8A 85 38 A3     mov al, byte ptr [di - 0x5cc8]
272E  98              cwde
272F  A3 4D CF        mov word ptr [0xcf4d], ax
2732  8A 46 FE        mov al, byte ptr [bp - 2]
2735  98              cwde
2736  99              cdq
2737  31 D0           xor ax, dx
2739  29 D0           sub ax, dx
273B  01 06 51 CF     add word ptr [0xcf51], ax
273F  8A 46 FE        mov al, byte ptr [bp - 2]
2742  98              cwde
2743  99              cdq
2744  31 D0           xor ax, dx
2746  29 D0           sub ax, dx
2748  99              cdq
2749  B9 02 00        mov cx, 2
274C  F7 F9           idiv cx
274E  8B C8           mov cx, ax
2750  8A 46 FF        mov al, byte ptr [bp - 1]
2753  98              cwde
2754  99              cdq
2755  31 D0           xor ax, dx
2757  29 D0           sub ax, dx
2759  3B C1           cmp ax, cx
275B  7C 08           jl 0x2765
275D  A1 4F CF        mov ax, word ptr [0xcf4f]
2760  D1 E0           shl ax, 1
2762  A3 4F CF        mov word ptr [0xcf4f], ax
loc_2765:
2765  83 7E 0A 06     cmp word ptr [bp + 0xa], 6
2769  75 35           jne 0x27a0
276B  83 3E 51 CF 14  cmp word ptr [0xcf51], 0x14
2770  76 07           jbe 0x2779
2772  C7 46 0A 07 00  mov word ptr [bp + 0xa], 7
2777  EB 27           jmp 0x27a0
loc_2779:
2779  C4 7E 06        les di, ptr [bp + 6]
277C  26 8A 45 07     mov al, byte ptr es:[di + 7]
2780  30 E4           xor ah, ah
2782  50              push ax
2783  E8 7A D8        call 0
2786  08 C0           or al, al
2788  74 16           je 0x27a0
278A  FF 36 46 CF     push word ptr [0xcf46]
278E  C4 7E 06        les di, ptr [bp + 6]
2791  06              push es
2792  57              push di
2793  0E              push cs
2794  E8 5E F9        call 0x20f5
2797  08 C0           or al, al
2799  74 05           je 0x27a0
279B  C7 46 0A 08 00  mov word ptr [bp + 0xa], 8
loc_27A0:
27A0  8A 46 0A        mov al, byte ptr [bp + 0xa]
27A3  A2 BB D0        mov byte ptr [0xd0bb], al
27A6  8A 46 0A        mov al, byte ptr [bp + 0xa]
27A9  3C 01           cmp al, 1
27AB  72 37           jb 0x27e4
27AD  3C 04           cmp al, 4
27AF  77 33           ja 0x27e4
27B1  A1 51 CF        mov ax, word ptr [0xcf51]
27B4  05 05 00        add ax, 5
27B7  31 D2           xor dx, dx
27B9  52              push dx
27BA  50              push ax
27BB  8B 7E 0A        mov di, word ptr [bp + 0xa]
27BE  8A 85 15 0A     mov al, byte ptr [di + 0xa15]
27C2  30 E4           xor ah, ah
27C4  50              push ax
27C5  C4 7E 06        les di, ptr [bp + 6]
27C8  06              push es
27C9  57              push di
27CA  0E              push cs
27CB  E8 14 F3        call 0x1ae2
27CE  31 D2           xor dx, dx
27D0  B9 03 00        mov cx, 3
27D3  F7 F1           div cx
27D5  31 D2           xor dx, dx
27D7  52              push dx
27D8  50              push ax
27D9  9A C0 04 AC 24  call far 24AC:04C0
27DE  A3 51 CF        mov word ptr [0xcf51], ax
27E1  E9 DD 00        jmp 0x28c1
loc_27E4:
27E4  83 7E 0A 08     cmp word ptr [bp + 0xa], 8
27E8  75 03           jne 0x27ed
27EA  E9 D4 00        jmp 0x28c1
loc_27ED:
27ED  83 3E 51 CF 01  cmp word ptr [0xcf51], 1
27F2  77 03           ja 0x27f7
27F4  E9 CA 00        jmp 0x28c1
loc_27F7:
27F7  A0 9F D0        mov al, byte ptr [0xd09f]
27FA  3A 06 A0 D0     cmp al, byte ptr [0xd0a0]
27FE  75 03           jne 0x2803
2800  E9 BE 00        jmp 0x28c1
loc_2803:
2803  8B 7E 0A        mov di, word ptr [bp + 0xa]
2806  8A 85 15 0A     mov al, byte ptr [di + 0xa15]
280A  30 E4           xor ah, ah
280C  50              push ax
280D  C4 7E 06        les di, ptr [bp + 6]
2810  06              push es
2811  57              push di
2812  0E              push cs
2813  E8 C0 F3        call 0x1bd6
2816  08 C0           or al, al
2818  74 03           je 0x281d
281A  E9 A4 00        jmp 0x28c1
loc_281D:
281D  C6 06 A0 D0 00  mov byte ptr [0xd0a0], 0
2822  C4 7E 06        les di, ptr [bp + 6]
2825  26 8A 45 07     mov al, byte ptr es:[di + 7]
2829  30 E4           xor ah, ah
282B  50              push ax
282C  E8 D1 D7        call 0
282F  08 C0           or al, al
2831  74 03           je 0x2836
2833  E9 8B 00        jmp 0x28c1
loc_2836:
2836  83 7E 0A 05     cmp word ptr [bp + 0xa], 5
283A  75 11           jne 0x284d
283C  A1 51 CF        mov ax, word ptr [0xcf51]
283F  D1 E8           shr ax, 1
2841  50              push ax
2842  9A 6D 07 1A 23  call far 231A:076D
2847  01 06 51 CF     add word ptr [0xcf51], ax
284B  EB 74           jmp 0x28c1
loc_284D:
284D  9A 3F 0D AC 24  call far 24AC:0D3F
2852  08 C0           or al, al
2854  75 07           jne 0x285d
2856  80 3E B6 D0 00  cmp byte ptr [0xd0b6], 0
285B  74 11           je 0x286e
loc_285D:
285D  A1 51 CF        mov ax, word ptr [0xcf51]
2860  D1 E8           shr ax, 1
2862  50              push ax
2863  9A 6D 07 1A 23  call far 231A:076D
2868  29 06 51 CF     sub word ptr [0xcf51], ax
286C  EB 53           jmp 0x28c1
loc_286E:
286E  83 3E 4D CF 00  cmp word ptr [0xcf4d], 0
2873  75 28           jne 0x289d
2875  9A 3F 0D AC 24  call far 24AC:0D3F
287A  98              cwde
287B  8B F8           mov di, ax
287D  8A 85 38 A3     mov al, byte ptr [di - 0x5cc8]
2881  98              cwde
2882  A3 4D CF        mov word ptr [0xcf4d], ax
2885  83 3E 4F CF 00  cmp word ptr [0xcf4f], 0
288A  B0 00           mov al, 0
288C  7E 01           jle 0x288f
288E  40              inc ax
loc_288F:
288F  98              cwde
2890  8B F8           mov di, ax
2892  8A 85 38 A3     mov al, byte ptr [di - 0x5cc8]
2896  98              cwde
2897  01 06 4F CF     add word ptr [0xcf4f], ax
289B  EB 24           jmp 0x28c1
loc_289D:
289D  A1 4F CF        mov ax, word ptr [0xcf4f]
28A0  99              cdq
28A1  31 D0           xor ax, dx
28A3  29 D0           sub ax, dx
28A5  3D 01 00        cmp ax, 1
28A8  75 07           jne 0x28b1
28AA  31 C0           xor ax, ax
28AC  A3 4F CF        mov word ptr [0xcf4f], ax
28AF  EB 10           jmp 0x28c1
loc_28B1:
28B1  9A 3F 0D AC 24  call far 24AC:0D3F
28B6  98              cwde
28B7  8B F8           mov di, ax
28B9  8A 85 38 A3     mov al, byte ptr [di - 0x5cc8]
28BD  98              cwde
28BE  A3 4F CF        mov word ptr [0xcf4f], ax
loc_28C1:
28C1  C6 06 B6 D0 00  mov byte ptr [0xd0b6], 0
28C6  6A 00           push 0
28C8  6A 02           push 2
28CA  A1 4F CF        mov ax, word ptr [0xcf4f]
28CD  99              cdq
28CE  31 D0           xor ax, dx
28D0  29 D0           sub ax, dx
28D2  8B C8           mov cx, ax
28D4  A1 4D CF        mov ax, word ptr [0xcf4d]
28D7  99              cdq
28D8  31 D0           xor ax, dx
28DA  29 D0           sub ax, dx
28DC  03 C1           add ax, cx
28DE  99              cdq
28DF  8B C8           mov cx, ax
28E1  8B DA           mov bx, dx
28E3  A1 51 CF        mov ax, word ptr [0xcf51]
28E6  31 D2           xor dx, dx
28E8  9A 67 0A B9 26  call far 26B9:0A67
28ED  52              push dx
28EE  50              push ax
28EF  9A C0 04 AC 24  call far 24AC:04C0
28F4  A3 51 CF        mov word ptr [0xcf51], ax
28F7  A1 46 CF        mov ax, word ptr [0xcf46]
28FA  A3 A6 D0        mov word ptr [0xd0a6], ax
28FD  A1 51 CF        mov ax, word ptr [0xcf51]
2900  31 D2           xor dx, dx
2902  8B C8           mov cx, ax
2904  8B DA           mov bx, dx
2906  A1 4F CF        mov ax, word ptr [0xcf4f]
2909  99              cdq
290A  9A 2A 0A B9 26  call far 26B9:0A2A
290F  00 06 A7 D0     add byte ptr [0xd0a7], al
2913  A1 51 CF        mov ax, word ptr [0xcf51]
2916  31 D2           xor dx, dx
2918  8B C8           mov cx, ax
291A  8B DA           mov bx, dx
291C  A1 4D CF        mov ax, word ptr [0xcf4d]
291F  99              cdq
2920  9A 2A 0A B9 26  call far 26B9:0A2A
2925  00 06 A6 D0     add byte ptr [0xd0a6], al
2929  6A 0A           push 0xa
292B  6A 01           push 1
292D  9A 34 01 94 19  call far 1994:0134
2932  55              push bp
2933  E8 CF FB        call 0x2505
2936  C9              leave
2937  CA 08 00        retf 8

