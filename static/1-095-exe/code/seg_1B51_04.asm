; 1-095.EXE (One-Nil 95), code segment 1B51 (image offsets 1B510..2305F), part 4 of 12
; packed 1-095.EXE sha256 f659fb2d334500d6901fc8d6a0f06c85c0ccda2eb4a3035ae3bb0a0004d79192 (LZEXE 0.91)
; unpacked (tools/static/unlzexe.py) sha256 8df646e017e0965a5d90a58181ca764219ad847833aad0b6cb58fc53372bfb2c
; tool: capstone 5.0.9 (pip package; core library 5.0.1280) (CS_ARCH_X86, CS_MODE_16), recursive descent from the entry point, far calls and near calls/jumps, then routine prologues (55 89 E5 / 55 8B EC / C8 iw 00) in what remains; tools/static/listing.py
; addresses are SEGMENT:OFFSET with SEGMENT the image paragraph before relocation; image offset = SEGMENT*16+OFFSET
; ---- routine 1B51:1F51  (found by: far)
sub_1F51:
1F51  C8 04 01 00     enter 0x104, 0
1F55  8B 46 0A        mov ax, word ptr [bp + 0xa]
1F58  C1 E0 03        shl ax, 3
1F5B  C4 3E BA D7     les di, ptr [0xd7ba]
1F5F  03 F8           add di, ax
1F61  89 7E FC        mov word ptr [bp - 4], di
1F64  8C 46 FE        mov word ptr [bp - 2], es
1F67  83 7E 0A 00     cmp word ptr [bp + 0xa], 0
1F6B  75 03           jne 0x1f70
1F6D  E9 9D 00        jmp 0x200d
loc_1F70:
1F70  FF 76 0A        push word ptr [bp + 0xa]
1F73  C4 7E FC        les di, ptr [bp - 4]
1F76  26 8A 45 06     mov al, byte ptr es:[di + 6]
1F7A  30 E4           xor ah, ah
1F7C  50              push ax
1F7D  0E              push cs
1F7E  E8 0A 52        call 0x718b
1F81  50              push ax
1F82  8D BE FC FE     lea di, [bp - 0x104]
1F86  16              push ss
1F87  57              push di
1F88  8B 46 0A        mov ax, word ptr [bp + 0xa]
1F8B  C4 3E AA D7     les di, ptr [0xd7aa]
1F8F  03 F8           add di, ax
1F91  26 8A 05        mov al, byte ptr es:[di]
1F94  50              push ax
1F95  9A 6F 0C B9 26  call far 26B9:0C6F
1F9A  8A 46 08        mov al, byte ptr [bp + 8]
1F9D  50              push ax
1F9E  8A 46 06        mov al, byte ptr [bp + 6]
1FA1  50              push ax
1FA2  BF 5C DD        mov di, 0xdd5c
1FA5  1E              push ds
1FA6  57              push di
1FA7  9A 1B 04 1A 23  call far 231A:041B
1FAC  8D BE FC FE     lea di, [bp - 0x104]
1FB0  16              push ss
1FB1  57              push di
1FB2  FF 76 0A        push word ptr [bp + 0xa]
1FB5  0E              push cs
1FB6  E8 83 24        call 0x443c
1FB9  8A 46 08        mov al, byte ptr [bp + 8]
1FBC  50              push ax
1FBD  8B 46 06        mov ax, word ptr [bp + 6]
1FC0  40              inc ax
1FC1  40              inc ax
1FC2  50              push ax
1FC3  BF 5C DD        mov di, 0xdd5c
1FC6  1E              push ds
1FC7  57              push di
1FC8  9A 9D 03 1A 23  call far 231A:039D
1FCD  C4 7E FC        les di, ptr [bp - 4]
1FD0  26 8A 45 06     mov al, byte ptr es:[di + 6]
1FD4  30 E4           xor ah, ah
1FD6  8B F8           mov di, ax
1FD8  8A 85 08 87     mov al, byte ptr [di - 0x78f8]
1FDC  50              push ax
1FDD  8D BE FC FE     lea di, [bp - 0x104]
1FE1  16              push ss
1FE2  57              push di
1FE3  C4 7E FC        les di, ptr [bp - 4]
1FE6  26 8A 45 06     mov al, byte ptr es:[di + 6]
1FEA  30 E4           xor ah, ah
1FEC  8B F8           mov di, ax
1FEE  8A 85 16 87     mov al, byte ptr [di - 0x78ea]
1FF2  50              push ax
1FF3  9A 6F 0C B9 26  call far 26B9:0C6F
1FF8  8A 46 08        mov al, byte ptr [bp + 8]
1FFB  50              push ax
1FFC  8B 46 06        mov ax, word ptr [bp + 6]
1FFF  05 0E 00        add ax, 0xe
2002  50              push ax
2003  BF 5C DD        mov di, 0xdd5c
2006  1E              push ds
2007  57              push di
2008  9A 1B 04 1A 23  call far 231A:041B
loc_200D:
200D  C9              leave
200E  CA 06 00        retf 6

; ---- routine 1B51:2011  (found by: call)
sub_2011:
2011  C8 04 00 00     enter 4, 0
2015  8B 7E 04        mov di, word ptr [bp + 4]
2018  36 6B 45 06 3E  imul ax, word ptr ss:[di + 6], 0x3e
201D  C4 3E C2 D7     les di, ptr [0xd7c2]
2021  03 F8           add di, ax
2023  81 C7 C2 FF     add di, 0xffc2
2027  89 7E FC        mov word ptr [bp - 4], di
202A  8C 46 FE        mov word ptr [bp - 2], es
202D  8B 7E 04        mov di, word ptr [bp + 4]
2030  36 8A 4D 06     mov cl, byte ptr ss:[di + 6]
2034  8B 56 06        mov dx, word ptr [bp + 6]
2037  C4 7E FC        les di, ptr [bp - 4]
203A  26 8A 45 37     mov al, byte ptr es:[di + 0x37]
203E  98              cwde
203F  C1 E0 02        shl ax, 2
2042  C4 3E D2 D7     les di, ptr [0xd7d2]
2046  03 F8           add di, ax
2048  03 FA           add di, dx
204A  26 88 4D 2F     mov byte ptr es:[di + 0x2f], cl
204E  8A 4E 08        mov cl, byte ptr [bp + 8]
2051  8B 56 06        mov dx, word ptr [bp + 6]
2054  C4 7E FC        les di, ptr [bp - 4]
2057  26 8A 45 37     mov al, byte ptr es:[di + 0x37]
205B  98              cwde
205C  C1 E0 02        shl ax, 2
205F  C4 3E D2 D7     les di, ptr [0xd7d2]
2063  03 F8           add di, ax
2065  03 FA           add di, dx
2067  26 88 4D 43     mov byte ptr es:[di + 0x43], cl
206B  C9              leave
206C  C2 06 00        ret 6

; ---- routine 1B51:206F  (found by: call)
sub_206F:
206F  C8 0C 00 00     enter 0xc, 0
2073  6B 46 06 2E     imul ax, word ptr [bp + 6], 0x2e
2077  C4 3E C0 DC     les di, ptr [0xdcc0]
207B  03 F8           add di, ax
207D  81 C7 D2 FF     add di, 0xffd2
2081  89 7E FC        mov word ptr [bp - 4], di
2084  8C 46 FE        mov word ptr [bp - 2], es
2087  26 8A 45 0D     mov al, byte ptr es:[di + 0xd]
208B  26 3A 45 0C     cmp al, byte ptr es:[di + 0xc]
208F  76 08           jbe 0x2099
2091  26 8A 45 0D     mov al, byte ptr es:[di + 0xd]
2095  26 88 45 0C     mov byte ptr es:[di + 0xc], al
loc_2099:
2099  C4 7E FC        les di, ptr [bp - 4]
209C  26 8A 45 0F     mov al, byte ptr es:[di + 0xf]
20A0  26 3A 45 0E     cmp al, byte ptr es:[di + 0xe]
20A4  76 08           jbe 0x20ae
20A6  26 8A 45 0F     mov al, byte ptr es:[di + 0xf]
20AA  26 88 45 0E     mov byte ptr es:[di + 0xe], al
loc_20AE:
20AE  C4 7E FC        les di, ptr [bp - 4]
20B1  26 8A 45 11     mov al, byte ptr es:[di + 0x11]
20B5  26 3A 45 10     cmp al, byte ptr es:[di + 0x10]
20B9  76 08           jbe 0x20c3
20BB  26 8A 45 11     mov al, byte ptr es:[di + 0x11]
20BF  26 88 45 10     mov byte ptr es:[di + 0x10], al
loc_20C3:
20C3  C4 7E FC        les di, ptr [bp - 4]
20C6  26 8A 45 13     mov al, byte ptr es:[di + 0x13]
20CA  26 3A 45 12     cmp al, byte ptr es:[di + 0x12]
20CE  76 08           jbe 0x20d8
20D0  26 8A 45 13     mov al, byte ptr es:[di + 0x13]
20D4  26 88 45 12     mov byte ptr es:[di + 0x12], al
loc_20D8:
20D8  C4 3E D2 D7     les di, ptr [0xd7d2]
20DC  89 7E F8        mov word ptr [bp - 8], di
20DF  8C 46 FA        mov word ptr [bp - 6], es
20E2  6B 46 06 3E     imul ax, word ptr [bp + 6], 0x3e
20E6  C4 3E C2 D7     les di, ptr [0xd7c2]
20EA  03 F8           add di, ax
20EC  81 C7 C2 FF     add di, 0xffc2
20F0  89 7E F4        mov word ptr [bp - 0xc], di
20F3  8C 46 F6        mov word ptr [bp - 0xa], es
20F6  26 8A 45 37     mov al, byte ptr es:[di + 0x37]
20FA  98              cwde
20FB  C1 E0 02        shl ax, 2
20FE  C4 7E F8        les di, ptr [bp - 8]
2101  03 F8           add di, ax
2103  26 8A 45 44     mov al, byte ptr es:[di + 0x44]
2107  C4 7E FC        les di, ptr [bp - 4]
210A  26 3A 45 0D     cmp al, byte ptr es:[di + 0xd]
210E  73 0D           jae 0x211d
2110  26 8A 45 0D     mov al, byte ptr es:[di + 0xd]
2114  30 E4           xor ah, ah
2116  50              push ax
2117  6A 01           push 1
2119  55              push bp
211A  E8 F4 FE        call 0x2011
loc_211D:
211D  C4 7E F4        les di, ptr [bp - 0xc]
2120  26 8A 45 37     mov al, byte ptr es:[di + 0x37]
2124  98              cwde
2125  C1 E0 02        shl ax, 2
2128  C4 7E F8        les di, ptr [bp - 8]
212B  03 F8           add di, ax
212D  26 8A 45 45     mov al, byte ptr es:[di + 0x45]
2131  C4 7E FC        les di, ptr [bp - 4]
2134  26 3A 45 0F     cmp al, byte ptr es:[di + 0xf]
2138  73 0D           jae 0x2147
213A  26 8A 45 0F     mov al, byte ptr es:[di + 0xf]
213E  30 E4           xor ah, ah
2140  50              push ax
2141  6A 02           push 2
2143  55              push bp
2144  E8 CA FE        call 0x2011
loc_2147:
2147  C4 7E F4        les di, ptr [bp - 0xc]
214A  26 8A 45 37     mov al, byte ptr es:[di + 0x37]
214E  98              cwde
214F  C1 E0 02        shl ax, 2
2152  C4 7E F8        les di, ptr [bp - 8]
2155  03 F8           add di, ax
2157  26 8A 45 46     mov al, byte ptr es:[di + 0x46]
215B  C4 7E FC        les di, ptr [bp - 4]
215E  26 3A 45 11     cmp al, byte ptr es:[di + 0x11]
2162  73 0D           jae 0x2171
2164  26 8A 45 11     mov al, byte ptr es:[di + 0x11]
2168  30 E4           xor ah, ah
216A  50              push ax
216B  6A 03           push 3
216D  55              push bp
216E  E8 A0 FE        call 0x2011
loc_2171:
2171  C4 7E F4        les di, ptr [bp - 0xc]
2174  26 8A 45 37     mov al, byte ptr es:[di + 0x37]
2178  98              cwde
2179  C1 E0 02        shl ax, 2
217C  C4 7E F8        les di, ptr [bp - 8]
217F  03 F8           add di, ax
2181  26 8A 45 47     mov al, byte ptr es:[di + 0x47]
2185  C4 7E FC        les di, ptr [bp - 4]
2188  26 3A 45 13     cmp al, byte ptr es:[di + 0x13]
218C  73 0D           jae 0x219b
218E  26 8A 45 13     mov al, byte ptr es:[di + 0x13]
2192  30 E4           xor ah, ah
2194  50              push ax
2195  6A 04           push 4
2197  55              push bp
2198  E8 76 FE        call 0x2011
loc_219B:
219B  C9              leave
219C  C2 04 00        ret 4

; ---- routine 1B51:219F  (found by: call)
sub_219F:
219F  55              push bp
21A0  89 E5           mov bp, sp
21A2  6B 46 0C 2E     imul ax, word ptr [bp + 0xc], 0x2e
21A6  C4 3E C0 DC     les di, ptr [0xdcc0]
21AA  03 F8           add di, ax
21AC  26 FE 45 DF     inc byte ptr es:[di - 0x21]
21B0  6B 46 0C 2E     imul ax, word ptr [bp + 0xc], 0x2e
21B4  C4 3E C0 DC     les di, ptr [0xdcc0]
21B8  03 F8           add di, ax
21BA  26 FE 45 E5     inc byte ptr es:[di - 0x1b]
21BE  6B 46 0C 2E     imul ax, word ptr [bp + 0xc], 0x2e
21C2  C4 3E C0 DC     les di, ptr [0xdcc0]
21C6  03 F8           add di, ax
21C8  26 C6 45 E3 00  mov byte ptr es:[di - 0x1d], 0
21CD  6B 46 0C 2E     imul ax, word ptr [bp + 0xc], 0x2e
21D1  C4 3E C0 DC     les di, ptr [0xdcc0]
21D5  03 F8           add di, ax
21D7  26 C6 45 E1 00  mov byte ptr es:[di - 0x1f], 0
21DC  6B 46 0A 2E     imul ax, word ptr [bp + 0xa], 0x2e
21E0  C4 3E C0 DC     les di, ptr [0xdcc0]
21E4  03 F8           add di, ax
21E6  26 FE 45 E1     inc byte ptr es:[di - 0x1f]
21EA  6B 46 0A 2E     imul ax, word ptr [bp + 0xa], 0x2e
21EE  C4 3E C0 DC     les di, ptr [0xdcc0]
21F2  03 F8           add di, ax
21F4  26 FE 45 E3     inc byte ptr es:[di - 0x1d]
21F8  6B 46 0A 2E     imul ax, word ptr [bp + 0xa], 0x2e
21FC  C4 3E C0 DC     les di, ptr [0xdcc0]
2200  03 F8           add di, ax
2202  26 C6 45 DF 00  mov byte ptr es:[di - 0x21], 0
2207  6B 46 0A 2E     imul ax, word ptr [bp + 0xa], 0x2e
220B  C4 3E C0 DC     les di, ptr [0xdcc0]
220F  03 F8           add di, ax
2211  26 C6 45 E5 00  mov byte ptr es:[di - 0x1b], 0
2216  8B 56 08        mov dx, word ptr [bp + 8]
2219  6B 46 0C 0C     imul ax, word ptr [bp + 0xc], 0xc
221D  C4 3E C6 D7     les di, ptr [0xd7c6]
2221  03 F8           add di, ax
2223  03 FA           add di, dx
2225  26 FE 45 F5     inc byte ptr es:[di - 0xb]
2229  8A 16 E0 DC     mov dl, byte ptr [0xdce0]
222D  6B 46 0C 0C     imul ax, word ptr [bp + 0xc], 0xc
2231  C4 3E C6 D7     les di, ptr [0xd7c6]
2235  03 F8           add di, ax
2237  26 00 55 F5     add byte ptr es:[di - 0xb], dl
223B  6B 46 0C 3E     imul ax, word ptr [bp + 0xc], 0x3e
223F  C4 3E C2 D7     les di, ptr [0xd7c2]
2243  03 F8           add di, ax
2245  26 80 45 F7 02  add byte ptr es:[di - 9], 2
224A  8B 56 06        mov dx, word ptr [bp + 6]
224D  6B 46 0A 0C     imul ax, word ptr [bp + 0xa], 0xc
2251  C4 3E C6 D7     les di, ptr [0xd7c6]
2255  03 F8           add di, ax
2257  03 FA           add di, dx
2259  26 FE 45 F9     inc byte ptr es:[di - 7]
225D  C9              leave
225E  C2 0A 00        ret 0xa

; ---- routine 1B51:2261  (found by: far)
sub_2261:
2261  C8 04 00 00     enter 4, 0
2265  8B 56 06        mov dx, word ptr [bp + 6]
2268  6B 46 08 3A     imul ax, word ptr [bp + 8], 0x3a
226C  C4 3E CE D7     les di, ptr [0xd7ce]
2270  03 F8           add di, ax
2272  03 FA           add di, dx
2274  26 8A 45 C5     mov al, byte ptr es:[di - 0x3b]
2278  50              push ax
2279  8D 7E FE        lea di, [bp - 2]
227C  16              push ss
227D  57              push di
227E  9A E3 01 1A 23  call far 231A:01E3
2283  8B 46 06        mov ax, word ptr [bp + 6]
2286  8B F0           mov si, ax
2288  D1 E0           shl ax, 1
228A  01 F0           add ax, si
228C  8B D0           mov dx, ax
228E  69 46 08 AE 00  imul ax, word ptr [bp + 8], 0xae
2293  C4 3E CA D7     les di, ptr [0xd7ca]
2297  03 F8           add di, ax
2299  03 FA           add di, dx
229B  26 8A 85 50 FF  mov al, byte ptr es:[di - 0xb0]
22A0  30 E4           xor ah, ah
22A2  89 46 FC        mov word ptr [bp - 4], ax
22A5  6B 46 08 0C     imul ax, word ptr [bp + 8], 0xc
22A9  C4 3E C6 D7     les di, ptr [0xd7c6]
22AD  03 F8           add di, ax
22AF  26 FE 45 F4     inc byte ptr es:[di - 0xc]
22B3  6B 46 FC 0C     imul ax, word ptr [bp - 4], 0xc
22B7  C4 3E C6 D7     les di, ptr [0xd7c6]
22BB  03 F8           add di, ax
22BD  26 FE 45 F4     inc byte ptr es:[di - 0xc]
22C1  8A 46 FE        mov al, byte ptr [bp - 2]
22C4  30 E4           xor ah, ah
22C6  8B D0           mov dx, ax
22C8  6B 46 08 0C     imul ax, word ptr [bp + 8], 0xc
22CC  C4 3E C6 D7     les di, ptr [0xd7c6]
22D0  03 F8           add di, ax
22D2  26 01 55 FC     add word ptr es:[di - 4], dx
22D6  8A 46 FE        mov al, byte ptr [bp - 2]
22D9  30 E4           xor ah, ah
22DB  8B D0           mov dx, ax
22DD  6B 46 FC 0C     imul ax, word ptr [bp - 4], 0xc
22E1  C4 3E C6 D7     les di, ptr [0xd7c6]
22E5  03 F8           add di, ax
22E7  26 01 55 FE     add word ptr es:[di - 2], dx
22EB  8A 46 FF        mov al, byte ptr [bp - 1]
22EE  30 E4           xor ah, ah
22F0  8B D0           mov dx, ax
22F2  6B 46 08 0C     imul ax, word ptr [bp + 8], 0xc
22F6  C4 3E C6 D7     les di, ptr [0xd7c6]
22FA  03 F8           add di, ax
22FC  26 01 55 FE     add word ptr es:[di - 2], dx
2300  8A 46 FF        mov al, byte ptr [bp - 1]
2303  30 E4           xor ah, ah
2305  8B D0           mov dx, ax
2307  6B 46 FC 0C     imul ax, word ptr [bp - 4], 0xc
230B  C4 3E C6 D7     les di, ptr [0xd7c6]
230F  03 F8           add di, ax
2311  26 01 55 FC     add word ptr es:[di - 4], dx
2315  8A 46 FE        mov al, byte ptr [bp - 2]
2318  3A 46 FF        cmp al, byte ptr [bp - 1]
231B  76 11           jbe 0x232e
231D  FF 76 08        push word ptr [bp + 8]
2320  FF 76 FC        push word ptr [bp - 4]
2323  6A 01           push 1
2325  6A 02           push 2
2327  55              push bp
2328  E8 74 FE        call 0x219f
232B  E9 E3 00        jmp 0x2411
loc_232E:
232E  8A 46 FE        mov al, byte ptr [bp - 2]
2331  3A 46 FF        cmp al, byte ptr [bp - 1]
2334  74 03           je 0x2339
2336  E9 CA 00        jmp 0x2403
loc_2339:
2339  6B 46 08 2E     imul ax, word ptr [bp + 8], 0x2e
233D  C4 3E C0 DC     les di, ptr [0xdcc0]
2341  03 F8           add di, ax
2343  26 FE 45 E5     inc byte ptr es:[di - 0x1b]
2347  6B 46 FC 2E     imul ax, word ptr [bp - 4], 0x2e
234B  C4 3E C0 DC     les di, ptr [0xdcc0]
234F  03 F8           add di, ax
2351  26 FE 45 E5     inc byte ptr es:[di - 0x1b]
2355  6B 46 08 2E     imul ax, word ptr [bp + 8], 0x2e
2359  C4 3E C0 DC     les di, ptr [0xdcc0]
235D  03 F8           add di, ax
235F  26 FE 45 E3     inc byte ptr es:[di - 0x1d]
2363  6B 46 FC 2E     imul ax, word ptr [bp - 4], 0x2e
2367  C4 3E C0 DC     les di, ptr [0xdcc0]
236B  03 F8           add di, ax
236D  26 FE 45 E3     inc byte ptr es:[di - 0x1d]
2371  6B 46 08 2E     imul ax, word ptr [bp + 8], 0x2e
2375  C4 3E C0 DC     les di, ptr [0xdcc0]
2379  03 F8           add di, ax
237B  26 C6 45 E1 00  mov byte ptr es:[di - 0x1f], 0
2380  6B 46 FC 2E     imul ax, word ptr [bp - 4], 0x2e
2384  C4 3E C0 DC     les di, ptr [0xdcc0]
2388  03 F8           add di, ax
238A  26 C6 45 E1 00  mov byte ptr es:[di - 0x1f], 0
238F  6B 46 08 2E     imul ax, word ptr [bp + 8], 0x2e
2393  C4 3E C0 DC     les di, ptr [0xdcc0]
2397  03 F8           add di, ax
2399  26 C6 45 DF 00  mov byte ptr es:[di - 0x21], 0
239E  6B 46 FC 2E     imul ax, word ptr [bp - 4], 0x2e
23A2  C4 3E C0 DC     les di, ptr [0xdcc0]
23A6  03 F8           add di, ax
23A8  26 C6 45 DF 00  mov byte ptr es:[di - 0x21], 0
23AD  6B 46 08 0C     imul ax, word ptr [bp + 8], 0xc
23B1  C4 3E C6 D7     les di, ptr [0xd7c6]
23B5  03 F8           add di, ax
23B7  26 FE 45 F8     inc byte ptr es:[di - 8]
23BB  6B 46 08 0C     imul ax, word ptr [bp + 8], 0xc
23BF  C4 3E C6 D7     les di, ptr [0xd7c6]
23C3  03 F8           add di, ax
23C5  26 FE 45 F5     inc byte ptr es:[di - 0xb]
23C9  6B 46 08 3E     imul ax, word ptr [bp + 8], 0x3e
23CD  C4 3E C2 D7     les di, ptr [0xd7c2]
23D1  03 F8           add di, ax
23D3  26 FE 45 F7     inc byte ptr es:[di - 9]
23D7  6B 46 FC 0C     imul ax, word ptr [bp - 4], 0xc
23DB  C4 3E C6 D7     les di, ptr [0xd7c6]
23DF  03 F8           add di, ax
23E1  26 FE 45 F9     inc byte ptr es:[di - 7]
23E5  6B 46 FC 0C     imul ax, word ptr [bp - 4], 0xc
23E9  C4 3E C6 D7     les di, ptr [0xd7c6]
23ED  03 F8           add di, ax
23EF  26 FE 45 F5     inc byte ptr es:[di - 0xb]
23F3  6B 46 FC 3E     imul ax, word ptr [bp - 4], 0x3e
23F7  C4 3E C2 D7     les di, ptr [0xd7c2]
23FB  03 F8           add di, ax
23FD  26 FE 45 F7     inc byte ptr es:[di - 9]
2401  EB 0E           jmp 0x2411
loc_2403:
2403  FF 76 FC        push word ptr [bp - 4]
2406  FF 76 08        push word ptr [bp + 8]
2409  6A 02           push 2
240B  6A 01           push 1
240D  55              push bp
240E  E8 8E FD        call 0x219f
loc_2411:
2411  FF 76 08        push word ptr [bp + 8]
2414  55              push bp
2415  E8 57 FC        call 0x206f
2418  FF 76 FC        push word ptr [bp - 4]
241B  55              push bp
241C  E8 50 FC        call 0x206f
241F  C9              leave
2420  CA 04 00        retf 4

; ---- routine 1B51:2423  (found by: far)
sub_2423:
2423  C8 08 00 00     enter 8, 0
2427  8B 56 06        mov dx, word ptr [bp + 6]
242A  6B 46 08 3A     imul ax, word ptr [bp + 8], 0x3a
242E  C4 3E CE D7     les di, ptr [0xd7ce]
2432  03 F8           add di, ax
2434  03 FA           add di, dx
2436  26 8A 45 C5     mov al, byte ptr es:[di - 0x3b]
243A  50              push ax
243B  8D 7E FE        lea di, [bp - 2]
243E  16              push ss
243F  57              push di
2440  9A E3 01 1A 23  call far 231A:01E3
2445  C7 46 FC 01 00  mov word ptr [bp - 4], 1
244A  EB 03           jmp 0x244f
loc_244C:
244C  FF 46 FC        inc word ptr [bp - 4]
loc_244F:
244F  8B 7E FC        mov di, word ptr [bp - 4]
2452  8A 85 A5 DC     mov al, byte ptr [di - 0x235b]
2456  30 E4           xor ah, ah
2458  3B 46 08        cmp ax, word ptr [bp + 8]
245B  75 06           jne 0x2463
245D  8B 46 FC        mov ax, word ptr [bp - 4]
2460  89 46 F8        mov word ptr [bp - 8], ax
loc_2463:
2463  83 7E FC 08     cmp word ptr [bp - 4], 8
2467  75 E3           jne 0x244c
2469  C7 46 FC 01 00  mov word ptr [bp - 4], 1
246E  EB 03           jmp 0x2473
loc_2470:
2470  FF 46 FC        inc word ptr [bp - 4]
loc_2473:
2473  8B 46 06        mov ax, word ptr [bp + 6]
2476  8B F0           mov si, ax
2478  D1 E0           shl ax, 1
247A  01 F0           add ax, si
247C  8B D0           mov dx, ax
247E  69 46 08 AE 00  imul ax, word ptr [bp + 8], 0xae
2483  C4 3E CA D7     les di, ptr [0xd7ca]
2487  03 F8           add di, ax
2489  03 FA           add di, dx
248B  26 8A 85 50 FF  mov al, byte ptr es:[di - 0xb0]
2490  8B 7E FC        mov di, word ptr [bp - 4]
2493  3A 85 A5 DC     cmp al, byte ptr [di - 0x235b]
2497  75 06           jne 0x249f
2499  8B 46 FC        mov ax, word ptr [bp - 4]
249C  89 46 FA        mov word ptr [bp - 6], ax
loc_249F:
249F  83 7E FC 08     cmp word ptr [bp - 4], 8
24A3  75 CB           jne 0x2470
24A5  6B 46 F8 0C     imul ax, word ptr [bp - 8], 0xc
24A9  C4 3E B6 DC     les di, ptr [0xdcb6]
24AD  03 F8           add di, ax
24AF  26 FE 45 F4     inc byte ptr es:[di - 0xc]
24B3  6B 46 FA 0C     imul ax, word ptr [bp - 6], 0xc
24B7  C4 3E B6 DC     les di, ptr [0xdcb6]
24BB  03 F8           add di, ax
24BD  26 FE 45 F4     inc byte ptr es:[di - 0xc]
24C1  8A 46 FE        mov al, byte ptr [bp - 2]
24C4  30 E4           xor ah, ah
24C6  8B D0           mov dx, ax
24C8  6B 46 F8 0C     imul ax, word ptr [bp - 8], 0xc
24CC  C4 3E B6 DC     les di, ptr [0xdcb6]
24D0  03 F8           add di, ax
24D2  26 01 55 FC     add word ptr es:[di - 4], dx
24D6  8A 46 FE        mov al, byte ptr [bp - 2]
24D9  30 E4           xor ah, ah
24DB  8B D0           mov dx, ax
24DD  6B 46 FA 0C     imul ax, word ptr [bp - 6], 0xc
24E1  C4 3E B6 DC     les di, ptr [0xdcb6]
24E5  03 F8           add di, ax
24E7  26 01 55 FE     add word ptr es:[di - 2], dx
24EB  8A 46 FF        mov al, byte ptr [bp - 1]
24EE  30 E4           xor ah, ah
24F0  8B D0           mov dx, ax
24F2  6B 46 F8 0C     imul ax, word ptr [bp - 8], 0xc
24F6  C4 3E B6 DC     les di, ptr [0xdcb6]
24FA  03 F8           add di, ax
24FC  26 01 55 FE     add word ptr es:[di - 2], dx
2500  8A 46 FF        mov al, byte ptr [bp - 1]
2503  30 E4           xor ah, ah
2505  8B D0           mov dx, ax
2507  6B 46 FA 0C     imul ax, word ptr [bp - 6], 0xc
250B  C4 3E B6 DC     les di, ptr [0xdcb6]
250F  03 F8           add di, ax
2511  26 01 55 FC     add word ptr es:[di - 4], dx
2515  8A 46 FE        mov al, byte ptr [bp - 2]
2518  3A 46 FF        cmp al, byte ptr [bp - 1]
251B  76 2D           jbe 0x254a
251D  6B 46 F8 0C     imul ax, word ptr [bp - 8], 0xc
2521  C4 3E B6 DC     les di, ptr [0xdcb6]
2525  03 F8           add di, ax
2527  26 FE 45 F6     inc byte ptr es:[di - 0xa]
252B  6B 46 F8 0C     imul ax, word ptr [bp - 8], 0xc
252F  C4 3E B6 DC     les di, ptr [0xdcb6]
2533  03 F8           add di, ax
2535  26 80 45 F5 02  add byte ptr es:[di - 0xb], 2
253A  6B 46 FA 0C     imul ax, word ptr [bp - 6], 0xc
253E  C4 3E B6 DC     les di, ptr [0xdcb6]
2542  03 F8           add di, ax
2544  26 FE 45 FB     inc byte ptr es:[di - 5]
2548  EB 6D           jmp 0x25b7
loc_254A:
254A  8A 46 FE        mov al, byte ptr [bp - 2]
254D  3A 46 FF        cmp al, byte ptr [bp - 1]
2550  75 3A           jne 0x258c
2552  6B 46 F8 0C     imul ax, word ptr [bp - 8], 0xc
2556  C4 3E B6 DC     les di, ptr [0xdcb6]
255A  03 F8           add di, ax
255C  26 FE 45 F8     inc byte ptr es:[di - 8]
2560  6B 46 F8 0C     imul ax, word ptr [bp - 8], 0xc
2564  C4 3E B6 DC     les di, ptr [0xdcb6]
2568  03 F8           add di, ax
256A  26 FE 45 F5     inc byte ptr es:[di - 0xb]
256E  6B 46 FA 0C     imul ax, word ptr [bp - 6], 0xc
2572  C4 3E B6 DC     les di, ptr [0xdcb6]
2576  03 F8           add di, ax
2578  26 FE 45 F9     inc byte ptr es:[di - 7]
257C  6B 46 FA 0C     imul ax, word ptr [bp - 6], 0xc
2580  C4 3E B6 DC     les di, ptr [0xdcb6]
2584  03 F8           add di, ax
2586  26 FE 45 F5     inc byte ptr es:[di - 0xb]
258A  EB 2B           jmp 0x25b7
loc_258C:
258C  6B 46 F8 0C     imul ax, word ptr [bp - 8], 0xc
2590  C4 3E B6 DC     les di, ptr [0xdcb6]
2594  03 F8           add di, ax
2596  26 FE 45 FA     inc byte ptr es:[di - 6]
259A  6B 46 FA 0C     imul ax, word ptr [bp - 6], 0xc
259E  C4 3E B6 DC     les di, ptr [0xdcb6]
25A2  03 F8           add di, ax
25A4  26 FE 45 F7     inc byte ptr es:[di - 9]
25A8  6B 46 FA 0C     imul ax, word ptr [bp - 6], 0xc
25AC  C4 3E B6 DC     les di, ptr [0xdcb6]
25B0  03 F8           add di, ax
25B2  26 80 45 F5 02  add byte ptr es:[di - 0xb], 2
loc_25B7:
25B7  C9              leave
25B8  CA 04 00        retf 4

; ---- routine 1B51:25BB  (found by: call, far)
sub_25BB:
25BB  C8 08 00 00     enter 8, 0
25BF  6B 46 06 3E     imul ax, word ptr [bp + 6], 0x3e
25C3  C4 3E C2 D7     les di, ptr [0xd7c2]
25C7  03 F8           add di, ax
25C9  81 C7 C2 FF     add di, 0xffc2
25CD  89 7E F8        mov word ptr [bp - 8], di
25D0  8C 46 FA        mov word ptr [bp - 6], es
25D3  26 80 7D 36 00  cmp byte ptr es:[di + 0x36], 0
25D8  75 17           jne 0x25f1
25DA  26 8B 05        mov ax, word ptr es:[di]
25DD  C1 E0 03        shl ax, 3
25E0  C4 3E BA D7     les di, ptr [0xd7ba]
25E4  03 F8           add di, ax
25E6  26 8A 45 05     mov al, byte ptr es:[di + 5]
25EA  30 E4           xor ah, ah
25EC  89 46 FC        mov word ptr [bp - 4], ax
25EF  EB 0C           jmp 0x25fd
loc_25F1:
25F1  C4 7E F8        les di, ptr [bp - 8]
25F4  26 8A 45 36     mov al, byte ptr es:[di + 0x36]
25F8  30 E4           xor ah, ah
25FA  89 46 FC        mov word ptr [bp - 4], ax
loc_25FD:
25FD  C4 7E F8        les di, ptr [bp - 8]
2600  26 8A 45 33     mov al, byte ptr es:[di + 0x33]
2604  30 E4           xor ah, ah
2606  8B D0           mov dx, ax
2608  B8 B1 00        mov ax, 0xb1
260B  2B C2           sub ax, dx
260D  05 10 00        add ax, 0x10
2610  2B 46 FC        sub ax, word ptr [bp - 4]
2613  89 46 FE        mov word ptr [bp - 2], ax
2616  8B 46 FE        mov ax, word ptr [bp - 2]
2619  C9              leave
261A  CA 02 00        retf 2

; ---- routine 1B51:261D  (found by: far)
sub_261D:
261D  C8 06 00 00     enter 6, 0
2621  6B 46 06 3E     imul ax, word ptr [bp + 6], 0x3e
2625  C4 3E C2 D7     les di, ptr [0xd7c2]
2629  03 F8           add di, ax
262B  81 C7 C2 FF     add di, 0xffc2
262F  89 7E FA        mov word ptr [bp - 6], di
2632  8C 46 FC        mov word ptr [bp - 4], es
2635  26 8A 45 37     mov al, byte ptr es:[di + 0x37]
2639  98              cwde
263A  8B F8           mov di, ax
263C  8A 85 1C 10     mov al, byte ptr [di + 0x101c]
2640  30 E4           xor ah, ah
2642  8B C8           mov cx, ax
2644  C4 7E FA        les di, ptr [bp - 6]
2647  26 8A 45 36     mov al, byte ptr es:[di + 0x36]
264B  30 E4           xor ah, ah
264D  8B D0           mov dx, ax
264F  B8 11 00        mov ax, 0x11
2652  2B C2           sub ax, dx
2654  03 C1           add ax, cx
2656  89 46 FE        mov word ptr [bp - 2], ax
2659  8B 46 FE        mov ax, word ptr [bp - 2]
265C  C9              leave
265D  CA 02 00        retf 2

; ---- routine 1B51:2660  (found by: call, far)
sub_2660:
2660  C8 08 00 00     enter 8, 0
2664  8B 7E 06        mov di, word ptr [bp + 6]
2667  8A 85 E5 D9     mov al, byte ptr [di - 0x261b]
266B  30 E4           xor ah, ah
266D  31 D2           xor dx, dx
266F  89 46 F8        mov word ptr [bp - 8], ax
2672  89 56 FA        mov word ptr [bp - 6], dx
2675  8B 46 F8        mov ax, word ptr [bp - 8]
2678  8B 56 FA        mov dx, word ptr [bp - 6]
267B  B9 E8 03        mov cx, 0x3e8
267E  31 DB           xor bx, bx
2680  9A 2A 0A B9 26  call far 26B9:0A2A
2685  89 46 FC        mov word ptr [bp - 4], ax
2688  89 56 FE        mov word ptr [bp - 2], dx
268B  8B 46 FC        mov ax, word ptr [bp - 4]
268E  8B 56 FE        mov dx, word ptr [bp - 2]
2691  C9              leave
2692  CA 02 00        retf 2

; ---- routine 1B51:2695  (found by: call)
sub_2695:
2695  C8 16 00 00     enter 0x16, 0
2699  6B 46 04 3E     imul ax, word ptr [bp + 4], 0x3e
269D  C4 3E C2 D7     les di, ptr [0xd7c2]
26A1  03 F8           add di, ax
26A3  81 C7 C2 FF     add di, 0xffc2
26A7  89 7E EE        mov word ptr [bp - 0x12], di
26AA  8C 46 F0        mov word ptr [bp - 0x10], es
26AD  C4 3E D2 D7     les di, ptr [0xd7d2]
26B1  26 8A 05        mov al, byte ptr es:[di]
26B4  30 E4           xor ah, ah
26B6  8B F0           mov si, ax
26B8  D1 E0           shl ax, 1
26BA  01 F0           add ax, si
26BC  8B D0           mov dx, ax
26BE  69 46 04 AE 00  imul ax, word ptr [bp + 4], 0xae
26C3  C4 3E CA D7     les di, ptr [0xd7ca]
26C7  03 F8           add di, ax
26C9  03 FA           add di, dx
26CB  81 C7 4F FF     add di, 0xff4f
26CF  89 7E EA        mov word ptr [bp - 0x16], di
26D2  8C 46 EC        mov word ptr [bp - 0x14], es
26D5  8B 7E 04        mov di, word ptr [bp + 4]
26D8  8A 85 35 D9     mov al, byte ptr [di - 0x26cb]
26DC  30 E4           xor ah, ah
26DE  31 D2           xor dx, dx
26E0  89 46 F8        mov word ptr [bp - 8], ax
26E3  89 56 FA        mov word ptr [bp - 6], dx
26E6  80 3E DD D6 00  cmp byte ptr [0xd6dd], 0
26EB  75 07           jne 0x26f4
26ED  C7 46 F2 08 00  mov word ptr [bp - 0xe], 8
26F2  EB 15           jmp 0x2709
loc_26F4:
26F4  C4 7E EA        les di, ptr [bp - 0x16]
26F7  26 80 3D 00     cmp byte ptr es:[di], 0
26FB  75 07           jne 0x2704
26FD  C7 46 F2 0C 00  mov word ptr [bp - 0xe], 0xc
2702  EB 05           jmp 0x2709
loc_2704:
2704  C7 46 F2 0F 00  mov word ptr [bp - 0xe], 0xf
loc_2709:
2709  68 E7 03        push 0x3e7
270C  9A 6D 07 1A 23  call far 231A:076D
2711  99              cdq
2712  52              push dx
2713  50              push ax
2714  6A 00           push 0
2716  6A 0B           push 0xb
2718  8B 46 F8        mov ax, word ptr [bp - 8]
271B  8B 56 FA        mov dx, word ptr [bp - 6]
271E  B9 12 00        mov cx, 0x12
2721  31 DB           xor bx, bx
2723  9A 67 0A B9 26  call far 26B9:0A67
2728  52              push dx
2729  50              push ax
272A  9A FA 04 AC 24  call far 24AC:04FA
272F  8B D0           mov dx, ax
2731  C4 7E EA        les di, ptr [bp - 0x16]
2734  26 8A 45 02     mov al, byte ptr es:[di + 2]
2738  24 0F           and al, 0xf
273A  08 C0           or al, al
273C  B0 00           mov al, 0
273E  74 01           je 0x2741
2740  40              inc ax
loc_2741:
2741  98              cwde
2742  6B F8 0C        imul di, ax, 0xc
2745  03 FA           add di, dx
2747  8A 85 22 10     mov al, byte ptr [di + 0x1022]
274B  30 E4           xor ah, ah
274D  31 D2           xor dx, dx
274F  8B 4E F8        mov cx, word ptr [bp - 8]
2752  8B 5E FA        mov bx, word ptr [bp - 6]
2755  9A 2A 0A B9 26  call far 26B9:0A2A
275A  8B C8           mov cx, ax
275C  8B DA           mov bx, dx
275E  8B 46 F2        mov ax, word ptr [bp - 0xe]
2761  31 D2           xor dx, dx
2763  9A 2A 0A B9 26  call far 26B9:0A2A
2768  8B C8           mov cx, ax
276A  8B DA           mov bx, dx
276C  C4 7E EE        les di, ptr [bp - 0x12]
276F  26 8A 45 36     mov al, byte ptr es:[di + 0x36]
2773  30 E4           xor ah, ah
2775  8B D0           mov dx, ax
2777  B8 1F 00        mov ax, 0x1f
277A  2B C2           sub ax, dx
277C  99              cdq
277D  9A 2A 0A B9 26  call far 26B9:0A2A
2782  B9 1E 00        mov cx, 0x1e
2785  31 DB           xor bx, bx
2787  9A 67 0A B9 26  call far 26B9:0A67
278C  59              pop cx
278D  5B              pop bx
278E  03 C1           add ax, cx
2790  13 D3           adc dx, bx
2792  89 46 F4        mov word ptr [bp - 0xc], ax
2795  89 56 F6        mov word ptr [bp - 0xa], dx
2798  8B 46 F4        mov ax, word ptr [bp - 0xc]
279B  8B 56 F6        mov dx, word ptr [bp - 0xa]
279E  89 46 FC        mov word ptr [bp - 4], ax
27A1  89 56 FE        mov word ptr [bp - 2], dx
27A4  8B 46 FC        mov ax, word ptr [bp - 4]
27A7  8B 56 FE        mov dx, word ptr [bp - 2]
27AA  C9              leave
27AB  C2 02 00        ret 2

; ---- routine 1B51:27AE  (found by: far)
sub_27AE:
27AE  C8 12 00 00     enter 0x12, 0
27B2  C4 3E D2 D7     les di, ptr [0xd7d2]
27B6  26 8A 05        mov al, byte ptr es:[di]
27B9  30 E4           xor ah, ah
27BB  8B F0           mov si, ax
27BD  D1 E0           shl ax, 1
27BF  01 F0           add ax, si
27C1  8B D0           mov dx, ax
27C3  69 06 E6 D6 AE 00 imul ax, word ptr [0xd6e6], 0xae
27C9  C4 3E CA D7     les di, ptr [0xd7ca]
27CD  03 F8           add di, ax
27CF  03 FA           add di, dx
27D1  81 C7 4F FF     add di, 0xff4f
27D5  89 7E F6        mov word ptr [bp - 0xa], di
27D8  8C 46 F8        mov word ptr [bp - 8], es
27DB  FF 36 E4 D6     push word ptr [0xd6e4]
27DF  E8 B3 FE        call 0x2695
27E2  52              push dx
27E3  50              push ax
27E4  FF 36 E6 D6     push word ptr [0xd6e6]
27E8  E8 AA FE        call 0x2695
27EB  59              pop cx
27EC  5B              pop bx
27ED  03 C1           add ax, cx
27EF  13 D3           adc dx, bx
27F1  A3 E8 D6        mov word ptr [0xd6e8], ax
27F4  89 16 EA D6     mov word ptr [0xd6ea], dx
27F8  C4 7E F6        les di, ptr [bp - 0xa]
27FB  26 8A 45 02     mov al, byte ptr es:[di + 2]
27FF  24 0F           and al, 0xf
2801  3C 01           cmp al, 1
2803  75 3E           jne 0x2843
2805  FF 36 E6 D6     push word ptr [0xd6e6]
2809  0E              push cs
280A  E8 53 FE        call 0x2660
280D  3B 16 EA D6     cmp dx, word ptr [0xd6ea]
2811  7C 08           jl 0x281b
2813  7F 2B           jg 0x2840
2815  3B 06 E8 D6     cmp ax, word ptr [0xd6e8]
2819  73 25           jae 0x2840
loc_281B:
281B  6A 32           push 0x32
281D  9A 6D 07 1A 23  call far 231A:076D
2822  99              cdq
2823  52              push dx
2824  50              push ax
2825  FF 36 E6 D6     push word ptr [0xd6e6]
2829  0E              push cs
282A  E8 33 FE        call 0x2660
282D  05 01 00        add ax, 1
2830  83 D2 00        adc dx, 0
2833  59              pop cx
2834  5B              pop bx
2835  2B C1           sub ax, cx
2837  1B D3           sbb dx, bx
2839  A3 E8 D6        mov word ptr [0xd6e8], ax
283C  89 16 EA D6     mov word ptr [0xd6ea], dx
loc_2840:
2840  E9 8D 00        jmp 0x28d0
loc_2843:
2843  A1 E8 D6        mov ax, word ptr [0xd6e8]
2846  8B 16 EA D6     mov dx, word ptr [0xd6ea]
284A  B9 E8 03        mov cx, 0x3e8
284D  31 DB           xor bx, bx
284F  9A 67 0A B9 26  call far 26B9:0A67
2854  8B C8           mov cx, ax
2856  8B DA           mov bx, dx
2858  C4 7E F6        les di, ptr [bp - 0xa]
285B  26 8A 05        mov al, byte ptr es:[di]
285E  3C 03           cmp al, 3
2860  72 04           jb 0x2866
2862  3C 04           cmp al, 4
2864  76 04           jbe 0x286a
loc_2866:
2866  B0 00           mov al, 0
2868  EB 02           jmp 0x286c
loc_286A:
286A  B0 01           mov al, 1
loc_286C:
286C  98              cwde
286D  8B F8           mov di, ax
286F  8A 85 86 10     mov al, byte ptr [di + 0x1086]
2873  30 E4           xor ah, ah
2875  31 D2           xor dx, dx
2877  3B D3           cmp dx, bx
2879  7C 06           jl 0x2881
287B  7F 53           jg 0x28d0
287D  3B C1           cmp ax, cx
287F  73 4F           jae 0x28d0
loc_2881:
2881  C4 7E F6        les di, ptr [bp - 0xa]
2884  26 8A 05        mov al, byte ptr es:[di]
2887  3C 03           cmp al, 3
2889  72 04           jb 0x288f
288B  3C 04           cmp al, 4
288D  76 04           jbe 0x2893
loc_288F:
288F  B0 00           mov al, 0
2891  EB 02           jmp 0x2895
loc_2893:
2893  B0 01           mov al, 1
loc_2895:
2895  98              cwde
2896  8B F8           mov di, ax
2898  8A 85 86 10     mov al, byte ptr [di + 0x1086]
289C  30 E4           xor ah, ah
289E  31 D2           xor dx, dx
28A0  A3 E8 D6        mov word ptr [0xd6e8], ax
28A3  89 16 EA D6     mov word ptr [0xd6ea], dx
28A7  68 F4 01        push 0x1f4
28AA  9A 6D 07 1A 23  call far 231A:076D
28AF  99              cdq
28B0  52              push dx
28B1  50              push ax
28B2  A1 E8 D6        mov ax, word ptr [0xd6e8]
28B5  8B 16 EA D6     mov dx, word ptr [0xd6ea]
28B9  B9 E8 03        mov cx, 0x3e8
28BC  31 DB           xor bx, bx
28BE  9A 2A 0A B9 26  call far 26B9:0A2A
28C3  59              pop cx
28C4  5B              pop bx
28C5  2B C1           sub ax, cx
28C7  1B D3           sbb dx, bx
28C9  A3 E8 D6        mov word ptr [0xd6e8], ax
28CC  89 16 EA D6     mov word ptr [0xd6ea], dx
loc_28D0:
28D0  C7 46 FA 01 00  mov word ptr [bp - 6], 1
28D5  EB 03           jmp 0x28da
loc_28D7:
28D7  FF 46 FA        inc word ptr [bp - 6]
loc_28DA:
28DA  8B 7E FA        mov di, word ptr [bp - 6]
28DD  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
28E1  30 E4           xor ah, ah
28E3  3B 06 E6 D6     cmp ax, word ptr [0xd6e6]
28E7  74 12           je 0x28fb
28E9  8B 7E FA        mov di, word ptr [bp - 6]
28EC  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
28F0  30 E4           xor ah, ah
28F2  3B 06 E4 D6     cmp ax, word ptr [0xd6e4]
28F6  74 03           je 0x28fb
28F8  E9 D6 00        jmp 0x29d1
loc_28FB:
28FB  6B 46 FA 5E     imul ax, word ptr [bp - 6], 0x5e
28FF  C4 3E C4 DC     les di, ptr [0xdcc4]
2903  03 F8           add di, ax
2905  81 C7 A2 FF     add di, 0xffa2
2909  89 7E F2        mov word ptr [bp - 0xe], di
290C  8C 46 F4        mov word ptr [bp - 0xc], es
290F  C4 3E D2 D7     les di, ptr [0xd7d2]
2913  26 8A 05        mov al, byte ptr es:[di]
2916  30 E4           xor ah, ah
2918  C1 E0 02        shl ax, 2
291B  8B D0           mov dx, ax
291D  69 46 FA E8 00  imul ax, word ptr [bp - 6], 0xe8
2922  C4 3E DC DC     les di, ptr [0xdcdc]
2926  03 F8           add di, ax
2928  03 FA           add di, dx
292A  81 C7 14 FF     add di, 0xff14
292E  89 7E EE        mov word ptr [bp - 0x12], di
2931  8C 46 F0        mov word ptr [bp - 0x10], es
2934  6B 06 E6 D6 3E  imul ax, word ptr [0xd6e6], 0x3e
2939  C4 3E C2 D7     les di, ptr [0xd7c2]
293D  03 F8           add di, ax
293F  26 8A 45 F9     mov al, byte ptr es:[di - 7]
2943  98              cwde
2944  8B F8           mov di, ax
2946  8A 85 74 10     mov al, byte ptr [di + 0x1074]
294A  30 E4           xor ah, ah
294C  31 D2           xor dx, dx
294E  89 46 FC        mov word ptr [bp - 4], ax
2951  89 56 FE        mov word ptr [bp - 2], dx
2954  C4 7E F6        les di, ptr [bp - 0xa]
2957  26 8A 05        mov al, byte ptr es:[di]
295A  98              cwde
295B  8B F8           mov di, ax
295D  8A 85 7C 10     mov al, byte ptr [di + 0x107c]
2961  98              cwde
2962  99              cdq
2963  01 46 FC        add word ptr [bp - 4], ax
2966  11 56 FE        adc word ptr [bp - 2], dx
2969  A1 E8 D6        mov ax, word ptr [0xd6e8]
296C  8B 16 EA D6     mov dx, word ptr [0xd6ea]
2970  8B 4E FC        mov cx, word ptr [bp - 4]
2973  8B 5E FE        mov bx, word ptr [bp - 2]
2976  9A 2A 0A B9 26  call far 26B9:0A2A
297B  B9 02 00        mov cx, 2
297E  31 DB           xor bx, bx
2980  9A 67 0A B9 26  call far 26B9:0A67
2985  C4 7E F2        les di, ptr [bp - 0xe]
2988  26 89 45 1A     mov word ptr es:[di + 0x1a], ax
298C  26 89 55 1C     mov word ptr es:[di + 0x1c], dx
2990  8B 7E FA        mov di, word ptr [bp - 6]
2993  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
2997  C4 7E EE        les di, ptr [bp - 0x12]
299A  26 88 45 03     mov byte ptr es:[di + 3], al
299E  A1 E8 D6        mov ax, word ptr [0xd6e8]
29A1  8B 16 EA D6     mov dx, word ptr [0xd6ea]
29A5  B9 E8 03        mov cx, 0x3e8
29A8  31 DB           xor bx, bx
29AA  9A 67 0A B9 26  call far 26B9:0A67
29AF  C4 7E EE        les di, ptr [bp - 0x12]
29B2  26 88 05        mov byte ptr es:[di], al
29B5  A1 E8 D6        mov ax, word ptr [0xd6e8]
29B8  8B 16 EA D6     mov dx, word ptr [0xd6ea]
29BC  B9 E8 03        mov cx, 0x3e8
29BF  31 DB           xor bx, bx
29C1  9A 67 0A B9 26  call far 26B9:0A67
29C6  89 C8           mov ax, cx
29C8  89 DA           mov dx, bx
29CA  C4 7E EE        les di, ptr [bp - 0x12]
29CD  26 89 45 01     mov word ptr es:[di + 1], ax
loc_29D1:
29D1  83 7E FA 02     cmp word ptr [bp - 6], 2
29D5  74 03           je 0x29da
29D7  E9 FD FE        jmp 0x28d7
loc_29DA:
29DA  C9              leave
29DB  CB              retf

; ---- routine 1B51:29DC  (found by: far)
sub_29DC:
29DC  C8 06 00 00     enter 6, 0
29E0  C7 46 FE 01 00  mov word ptr [bp - 2], 1
29E5  EB 03           jmp 0x29ea
loc_29E7:
29E7  FF 46 FE        inc word ptr [bp - 2]
loc_29EA:
29EA  FF 76 FE        push word ptr [bp - 2]
29ED  0E              push cs
29EE  E8 E9 E3        call 0xdda
29F1  08 C0           or al, al
29F3  75 31           jne 0x2a26
29F5  6B 46 FE 3E     imul ax, word ptr [bp - 2], 0x3e
29F9  C4 3E C2 D7     les di, ptr [0xd7c2]
29FD  03 F8           add di, ax
29FF  81 C7 C2 FF     add di, 0xffc2
2A03  26 80 7D 37 03  cmp byte ptr es:[di + 0x37], 3
2A08  7D 1C           jge 0x2a26
2A0A  26 8A 45 37     mov al, byte ptr es:[di + 0x37]
2A0E  98              cwde
2A0F  8B F8           mov di, ax
2A11  8A 85 88 10     mov al, byte ptr [di + 0x1088]
2A15  8B 7E FE        mov di, word ptr [bp - 2]
2A18  3A 85 E5 D9     cmp al, byte ptr [di - 0x261b]
2A1C  76 08           jbe 0x2a26
2A1E  8B 7E FE        mov di, word ptr [bp - 2]
2A21  80 85 E5 D9 05  add byte ptr [di - 0x261b], 5
loc_2A26:
2A26  81 7E FE B0 00  cmp word ptr [bp - 2], 0xb0
2A2B  75 BA           jne 0x29e7
2A2D  C9              leave
2A2E  CB              retf

; ---- routine 1B51:2A2F  (found by: call)
sub_2A2F:
2A2F  55              push bp
2A30  89 E5           mov bp, sp
2A32  C4 7E 06        les di, ptr [bp + 6]
2A35  06              push es
2A36  57              push di
2A37  BF 5C DD        mov di, 0xdd5c
2A3A  1E              push ds
2A3B  57              push di
2A3C  9A 2F 05 1A 23  call far 231A:052F
2A41  C7 06 64 DD 0F 00 mov word ptr [0xdd64], 0xf
2A47  8B 7E 04        mov di, word ptr [bp + 4]
2A4A  36 8B 45 06     mov ax, word ptr ss:[di + 6]
2A4E  D1 E0           shl ax, 1
2A50  C4 3E D2 D7     les di, ptr [0xd7d2]
2A54  03 F8           add di, ax
2A56  26 FF 75 03     push word ptr es:[di + 3]
2A5A  6A 19           push 0x19
2A5C  6A 01           push 1
2A5E  0E              push cs
2A5F  E8 F2 F3        call 0x1e54
2A62  C4 3E 5C DD     les di, ptr [0xdd5c]
2A66  06              push es
2A67  57              push di
2A68  C4 3E 58 DD     les di, ptr [0xdd58]
2A6C  06              push es
2A6D  57              push di
2A6E  68 A0 0F        push 0xfa0
2A71  9A 12 0A B9 26  call far 26B9:0A12
2A76  C9              leave
2A77  C2 06 00        ret 6
; data (not reached as code), 41 bytes
2A7A                  pstr 'Ok...improvements will take a few months'

; ---- routine 1B51:2AA3  (found by: call)
sub_2AA3:
2AA3  C8 0A 01 00     enter 0x10a, 0
2AA7  8B 7E 04        mov di, word ptr [bp + 4]
2AAA  36 6B 45 06 5E  imul ax, word ptr ss:[di + 6], 0x5e
2AAF  C4 3E C4 DC     les di, ptr [0xdcc4]
2AB3  03 F8           add di, ax
2AB5  81 C7 A2 FF     add di, 0xffa2
2AB9  89 7E F6        mov word ptr [bp - 0xa], di
2ABC  8C 46 F8        mov word ptr [bp - 8], es
2ABF  C7 46 FC 01 00  mov word ptr [bp - 4], 1
2AC4  C7 46 FE 00 00  mov word ptr [bp - 2], 0
2AC9  8B 7E 04        mov di, word ptr [bp + 4]
2ACC  36 8B 7D 06     mov di, word ptr ss:[di + 6]
2AD0  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
2AD4  30 E4           xor ah, ah
2AD6  8B F8           mov di, ax
2AD8  8A 85 E5 D9     mov al, byte ptr [di - 0x261b]
2ADC  30 E4           xor ah, ah
2ADE  8B D0           mov dx, ax
2AE0  B8 96 00        mov ax, 0x96
2AE3  2B C2           sub ax, dx
2AE5  88 46 FB        mov byte ptr [bp - 5], al
2AE8  8A 46 FB        mov al, byte ptr [bp - 5]
2AEB  30 E4           xor ah, ah
2AED  31 D2           xor dx, dx
2AEF  89 46 FC        mov word ptr [bp - 4], ax
2AF2  89 56 FE        mov word ptr [bp - 2], dx
loc_2AF5:
2AF5  8B 7E 04        mov di, word ptr [bp + 4]
2AF8  36 8B 7D 06     mov di, word ptr ss:[di + 6]
2AFC  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
2B00  30 E4           xor ah, ah
2B02  50              push ax
2B03  0E              push cs
2B04  E8 A7 0A        call 0x35ae
2B07  F7 D2           not dx
2B09  F7 D8           neg ax
2B0B  83 DA FF        sbb dx, -1
2B0E  52              push dx
2B0F  50              push ax
2B10  8B 7E 04        mov di, word ptr [bp + 4]
2B13  36 FF 75 06     push word ptr ss:[di + 6]
2B17  0E              push cs
2B18  E8 B8 0A        call 0x35d3
2B1B  52              push dx
2B1C  50              push ax
2B1D  8B 46 FC        mov ax, word ptr [bp - 4]
2B20  8B 56 FE        mov dx, word ptr [bp - 2]
2B23  F7 D2           not dx
2B25  F7 D8           neg ax
2B27  83 DA FF        sbb dx, -1
2B2A  B9 20 A1        mov cx, 0xa120
2B2D  BB 07 00        mov bx, 7
2B30  9A 2A 0A B9 26  call far 26B9:0A2A
2B35  59              pop cx
2B36  5B              pop bx
2B37  03 C1           add ax, cx
2B39  13 D3           adc dx, bx
2B3B  59              pop cx
2B3C  5B              pop bx
2B3D  3B D3           cmp dx, bx
2B3F  7C 06           jl 0x2b47
2B41  7F 0E           jg 0x2b51
2B43  3B C1           cmp ax, cx
2B45  73 0A           jae 0x2b51
loc_2B47:
2B47  83 6E FC 01     sub word ptr [bp - 4], 1
2B4B  83 5E FE 00     sbb word ptr [bp - 2], 0
2B4F  EB A4           jmp 0x2af5
loc_2B51:
2B51  8A 46 FC        mov al, byte ptr [bp - 4]
2B54  88 46 FB        mov byte ptr [bp - 5], al
2B57  C7 46 FC 01 00  mov word ptr [bp - 4], 1
2B5C  C7 46 FE 00 00  mov word ptr [bp - 2], 0
loc_2B61:
2B61  8A 46 FC        mov al, byte ptr [bp - 4]
2B64  88 46 FA        mov byte ptr [bp - 6], al
2B67  BF 1E 33        mov di, 0x331e
2B6A  1E              push ds
2B6B  57              push di
2B6C  BF 5C DD        mov di, 0xdd5c
2B6F  1E              push ds
2B70  57              push di
2B71  9A 2F 05 1A 23  call far 231A:052F
2B76  6A 0B           push 0xb
2B78  8D BE F6 FE     lea di, [bp - 0x10a]
2B7C  16              push ss
2B7D  57              push di
2B7E  8B 46 FC        mov ax, word ptr [bp - 4]
2B81  8B 56 FE        mov dx, word ptr [bp - 2]
2B84  B9 E8 03        mov cx, 0x3e8
2B87  31 DB           xor bx, bx
2B89  9A 2A 0A B9 26  call far 26B9:0A2A
2B8E  52              push dx
2B8F  50              push ax
2B90  0E              push cs
2B91  E8 61 E3        call 0xef5
2B94  6A 19           push 0x19
2B96  6A 10           push 0x10
2B98  BF 5C DD        mov di, 0xdd5c
2B9B  1E              push ds
2B9C  57              push di
2B9D  9A 1B 04 1A 23  call far 231A:041B
2BA2  8D BE F6 FE     lea di, [bp - 0x10a]
2BA6  16              push ss
2BA7  57              push di
2BA8  8B 46 FC        mov ax, word ptr [bp - 4]
2BAB  8B 56 FE        mov dx, word ptr [bp - 2]
2BAE  B9 20 A1        mov cx, 0xa120
2BB1  BB 07 00        mov bx, 7
2BB4  9A 2A 0A B9 26  call far 26B9:0A2A
2BB9  52              push dx
2BBA  50              push ax
2BBB  0E              push cs
2BBC  E8 36 E3        call 0xef5
2BBF  6A 19           push 0x19
2BC1  6A 2A           push 0x2a
2BC3  BF 5C DD        mov di, 0xdd5c
2BC6  1E              push ds
2BC7  57              push di
2BC8  9A 9D 03 1A 23  call far 231A:039D
2BCD  C4 3E 5C DD     les di, ptr [0xdd5c]
2BD1  81 C7 00 0F     add di, 0xf00
2BD5  06              push es
2BD6  57              push di
2BD7  C4 3E 58 DD     les di, ptr [0xdd58]
2BDB  81 C7 00 0F     add di, 0xf00
2BDF  06              push es
2BE0  57              push di
2BE1  68 A0 00        push 0xa0
2BE4  9A 12 0A B9 26  call far 26B9:0A12
2BE9  9A 9B 09 1A 23  call far 231A:099B
2BEE  80 3E 88 DE 05  cmp byte ptr [0xde88], 5
2BF3  75 07           jne 0x2bfc
2BF5  C6 06 88 DE 06  mov byte ptr [0xde88], 6
2BFA  EB 0C           jmp 0x2c08
loc_2BFC:
2BFC  80 3E 88 DE 06  cmp byte ptr [0xde88], 6
2C01  75 05           jne 0x2c08
2C03  C6 06 88 DE 05  mov byte ptr [0xde88], 5
loc_2C08:
2C08  8D 7E FA        lea di, [bp - 6]
2C0B  16              push ss
2C0C  57              push di
2C0D  8A 46 FB        mov al, byte ptr [bp - 5]
2C10  30 E4           xor ah, ah
2C12  50              push ax
2C13  9A C4 0E 1A 23  call far 231A:0EC4
2C18  8A 46 FA        mov al, byte ptr [bp - 6]
2C1B  30 E4           xor ah, ah
2C1D  31 D2           xor dx, dx
2C1F  89 46 FC        mov word ptr [bp - 4], ax
2C22  89 56 FE        mov word ptr [bp - 2], dx
2C25  80 3E 88 DE 01  cmp byte ptr [0xde88], 1
2C2A  75 02           jne 0x2c2e
2C2C  EB 77           jmp 0x2ca5
loc_2C2E:
2C2E  80 3E 88 DE 02  cmp byte ptr [0xde88], 2
2C33  74 03           je 0x2c38
2C35  E9 29 FF        jmp 0x2b61
loc_2C38:
2C38  BF 7A 2A        mov di, 0x2a7a
2C3B  0E              push cs
2C3C  57              push di
2C3D  9A 02 07 AC 24  call far 24AC:0702
2C42  8B 46 FC        mov ax, word ptr [bp - 4]
2C45  C4 7E F6        les di, ptr [bp - 0xa]
2C48  26 89 05        mov word ptr es:[di], ax
2C4B  8B 46 FC        mov ax, word ptr [bp - 4]
2C4E  8B 56 FE        mov dx, word ptr [bp - 2]
2C51  B9 20 A1        mov cx, 0xa120
2C54  BB 07 00        mov bx, 7
2C57  9A 2A 0A B9 26  call far 26B9:0A2A
2C5C  C4 7E F6        les di, ptr [bp - 0xa]
2C5F  26 29 45 52     sub word ptr es:[di + 0x52], ax
2C63  26 19 55 54     sbb word ptr es:[di + 0x54], dx
2C67  8B 46 FC        mov ax, word ptr [bp - 4]
2C6A  8B 56 FE        mov dx, word ptr [bp - 2]
2C6D  B9 20 A1        mov cx, 0xa120
2C70  BB 07 00        mov bx, 7
2C73  9A 2A 0A B9 26  call far 26B9:0A2A
2C78  C4 7E F6        les di, ptr [bp - 0xa]
2C7B  26 01 45 46     add word ptr es:[di + 0x46], ax
2C7F  26 11 55 48     adc word ptr es:[di + 0x48], dx
2C83  8B 46 FC        mov ax, word ptr [bp - 4]
2C86  8B 56 FE        mov dx, word ptr [bp - 2]
2C89  B9 20 A1        mov cx, 0xa120
2C8C  BB 07 00        mov bx, 7
2C8F  9A 2A 0A B9 26  call far 26B9:0A2A
2C94  C4 7E F6        les di, ptr [bp - 0xa]
2C97  26 01 45 5A     add word ptr es:[di + 0x5a], ax
2C9B  26 11 55 5C     adc word ptr es:[di + 0x5c], dx
2C9F  26 C7 45 02 1D 00 mov word ptr es:[di + 2], 0x1d
loc_2CA5:
2CA5  C9              leave
2CA6  C2 02 00        ret 2
; data (not reached as code), 112 bytes
2CA9                  pstr 'Your stadium will be ready in '
2CC8                  pstr ' weeks'
2CCF                  pstr "Your stadium is as big as it's going to get!!"
2CFD                  pstr "You don't have enough money"

