; 1-0.EXE (One-Nil 96), code segment 1B55 (image offsets 1B550..2315F), part 4 of 12
; packed 1-0.EXE sha256 89ff9c5f238f24e81a0c2440a46cdd8997280a65fc3cc3d97cb974f55280a80a (LZEXE 0.91)
; unpacked (tools/static/unlzexe.py) sha256 887ed2a92767950e5309b2052409f875668605939b69e00737aa3047022b9f51
; tool: capstone 5.0.9 (pip package; core library 5.0.1280) (CS_ARCH_X86, CS_MODE_16), recursive descent from the entry point, far calls and near calls/jumps, then routine prologues (55 89 E5 / 55 8B EC / C8 iw 00) in what remains; tools/static/listing.py
; addresses are SEGMENT:OFFSET with SEGMENT the image paragraph before relocation; image offset = SEGMENT*16+OFFSET
; ---- routine 1B55:1F46  (found by: call)
sub_1F46:
1F46  C8 0A 00 00     enter 0xa, 0
1F4A  6B 46 06 3E     imul ax, word ptr [bp + 6], 0x3e
1F4E  C4 3E C2 D7     les di, ptr [0xd7c2]
1F52  03 F8           add di, ax
1F54  81 C7 C2 FF     add di, 0xffc2
1F58  89 7E F6        mov word ptr [bp - 0xa], di
1F5B  8C 46 F8        mov word ptr [bp - 8], es
1F5E  BF AA 39        mov di, 0x39aa
1F61  1E              push ds
1F62  57              push di
1F63  BF 5C DD        mov di, 0xdd5c
1F66  1E              push ds
1F67  57              push di
1F68  9A 2F 05 2A 23  call far 232A:052F
1F6D  FF 76 06        push word ptr [bp + 6]
1F70  6A 02           push 2
1F72  6A 22           push 0x22
1F74  0E              push cs
1F75  E8 6B EF        call 0xee3
1F78  C7 46 FC 04 00  mov word ptr [bp - 4], 4
1F7D  C6 46 FF 00     mov byte ptr [bp - 1], 0
1F81  EB 03           jmp 0x1f86
loc_1F83:
1F83  FE 46 FF        inc byte ptr [bp - 1]
loc_1F86:
1F86  8A 46 FF        mov al, byte ptr [bp - 1]
1F89  98              cwde
1F8A  D1 E0           shl ax, 1
1F8C  C4 7E F6        les di, ptr [bp - 0xa]
1F8F  03 F8           add di, ax
1F91  26 8B 45 28     mov ax, word ptr es:[di + 0x28]
1F95  89 46 FA        mov word ptr [bp - 6], ax
1F98  83 7E FA 00     cmp word ptr [bp - 6], 0
1F9C  74 45           je 0x1fe3
1F9E  FF 76 FA        push word ptr [bp - 6]
1FA1  FF 76 FC        push word ptr [bp - 4]
1FA4  6A 35           push 0x35
1FA6  0E              push cs
1FA7  E8 E6 FE        call 0x1e90
1FAA  8B 46 FA        mov ax, word ptr [bp - 6]
1FAD  C4 3E D0 DC     les di, ptr [0xdcd0]
1FB1  03 F8           add di, ax
1FB3  26 8A 05        mov al, byte ptr es:[di]
1FB6  30 E4           xor ah, ah
1FB8  8B F8           mov di, ax
1FBA  C1 E7 04        shl di, 4
1FBD  81 C7 2C 9A     add di, 0x9a2c
1FC1  1E              push ds
1FC2  57              push di
1FC3  8B 46 FC        mov ax, word ptr [bp - 4]
1FC6  40              inc ax
1FC7  50              push ax
1FC8  6A 35           push 0x35
1FCA  BF 5C DD        mov di, 0xdd5c
1FCD  1E              push ds
1FCE  57              push di
1FCF  9A 83 02 2A 23  call far 232A:0283
1FD4  FF 76 FA        push word ptr [bp - 6]
1FD7  8B 46 FC        mov ax, word ptr [bp - 4]
1FDA  40              inc ax
1FDB  40              inc ax
1FDC  50              push ax
1FDD  6A 35           push 0x35
1FDF  0E              push cs
1FE0  E8 9B FD        call 0x1d7e
loc_1FE3:
1FE3  83 46 FC 04     add word ptr [bp - 4], 4
1FE7  80 7E FF 04     cmp byte ptr [bp - 1], 4
1FEB  75 96           jne 0x1f83
1FED  C9              leave
1FEE  CA 02 00        retf 2

; ---- routine 1B55:1FF1  (found by: far)
sub_1FF1:
1FF1  C8 04 01 00     enter 0x104, 0
1FF5  8B 46 0A        mov ax, word ptr [bp + 0xa]
1FF8  C1 E0 03        shl ax, 3
1FFB  C4 3E BA D7     les di, ptr [0xd7ba]
1FFF  03 F8           add di, ax
2001  89 7E FC        mov word ptr [bp - 4], di
2004  8C 46 FE        mov word ptr [bp - 2], es
2007  83 7E 0A 00     cmp word ptr [bp + 0xa], 0
200B  75 03           jne 0x2010
200D  E9 9D 00        jmp 0x20ad
loc_2010:
2010  FF 76 0A        push word ptr [bp + 0xa]
2013  C4 7E FC        les di, ptr [bp - 4]
2016  26 8A 45 06     mov al, byte ptr es:[di + 6]
201A  30 E4           xor ah, ah
201C  50              push ax
201D  0E              push cs
201E  E8 29 52        call 0x724a
2021  50              push ax
2022  8D BE FC FE     lea di, [bp - 0x104]
2026  16              push ss
2027  57              push di
2028  8B 46 0A        mov ax, word ptr [bp + 0xa]
202B  C4 3E AA D7     les di, ptr [0xd7aa]
202F  03 F8           add di, ax
2031  26 8A 05        mov al, byte ptr es:[di]
2034  50              push ax
2035  9A 6F 0C C9 26  call far 26C9:0C6F
203A  8A 46 08        mov al, byte ptr [bp + 8]
203D  50              push ax
203E  8A 46 06        mov al, byte ptr [bp + 6]
2041  50              push ax
2042  BF 5C DD        mov di, 0xdd5c
2045  1E              push ds
2046  57              push di
2047  9A 1B 04 2A 23  call far 232A:041B
204C  8D BE FC FE     lea di, [bp - 0x104]
2050  16              push ss
2051  57              push di
2052  FF 76 0A        push word ptr [bp + 0xa]
2055  0E              push cs
2056  E8 83 24        call 0x44dc
2059  8A 46 08        mov al, byte ptr [bp + 8]
205C  50              push ax
205D  8B 46 06        mov ax, word ptr [bp + 6]
2060  40              inc ax
2061  40              inc ax
2062  50              push ax
2063  BF 5C DD        mov di, 0xdd5c
2066  1E              push ds
2067  57              push di
2068  9A 9D 03 2A 23  call far 232A:039D
206D  C4 7E FC        les di, ptr [bp - 4]
2070  26 8A 45 06     mov al, byte ptr es:[di + 6]
2074  30 E4           xor ah, ah
2076  8B F8           mov di, ax
2078  8A 85 08 87     mov al, byte ptr [di - 0x78f8]
207C  50              push ax
207D  8D BE FC FE     lea di, [bp - 0x104]
2081  16              push ss
2082  57              push di
2083  C4 7E FC        les di, ptr [bp - 4]
2086  26 8A 45 06     mov al, byte ptr es:[di + 6]
208A  30 E4           xor ah, ah
208C  8B F8           mov di, ax
208E  8A 85 16 87     mov al, byte ptr [di - 0x78ea]
2092  50              push ax
2093  9A 6F 0C C9 26  call far 26C9:0C6F
2098  8A 46 08        mov al, byte ptr [bp + 8]
209B  50              push ax
209C  8B 46 06        mov ax, word ptr [bp + 6]
209F  05 0E 00        add ax, 0xe
20A2  50              push ax
20A3  BF 5C DD        mov di, 0xdd5c
20A6  1E              push ds
20A7  57              push di
20A8  9A 1B 04 2A 23  call far 232A:041B
loc_20AD:
20AD  C9              leave
20AE  CA 06 00        retf 6

; ---- routine 1B55:20B1  (found by: call)
sub_20B1:
20B1  C8 04 00 00     enter 4, 0
20B5  8B 7E 04        mov di, word ptr [bp + 4]
20B8  36 6B 45 06 3E  imul ax, word ptr ss:[di + 6], 0x3e
20BD  C4 3E C2 D7     les di, ptr [0xd7c2]
20C1  03 F8           add di, ax
20C3  81 C7 C2 FF     add di, 0xffc2
20C7  89 7E FC        mov word ptr [bp - 4], di
20CA  8C 46 FE        mov word ptr [bp - 2], es
20CD  8B 7E 04        mov di, word ptr [bp + 4]
20D0  36 8A 4D 06     mov cl, byte ptr ss:[di + 6]
20D4  8B 56 06        mov dx, word ptr [bp + 6]
20D7  C4 7E FC        les di, ptr [bp - 4]
20DA  26 8A 45 37     mov al, byte ptr es:[di + 0x37]
20DE  98              cwde
20DF  C1 E0 02        shl ax, 2
20E2  C4 3E D2 D7     les di, ptr [0xd7d2]
20E6  03 F8           add di, ax
20E8  03 FA           add di, dx
20EA  26 88 4D 2F     mov byte ptr es:[di + 0x2f], cl
20EE  8A 4E 08        mov cl, byte ptr [bp + 8]
20F1  8B 56 06        mov dx, word ptr [bp + 6]
20F4  C4 7E FC        les di, ptr [bp - 4]
20F7  26 8A 45 37     mov al, byte ptr es:[di + 0x37]
20FB  98              cwde
20FC  C1 E0 02        shl ax, 2
20FF  C4 3E D2 D7     les di, ptr [0xd7d2]
2103  03 F8           add di, ax
2105  03 FA           add di, dx
2107  26 88 4D 43     mov byte ptr es:[di + 0x43], cl
210B  C9              leave
210C  C2 06 00        ret 6

; ---- routine 1B55:210F  (found by: call)
sub_210F:
210F  C8 0C 00 00     enter 0xc, 0
2113  6B 46 06 2E     imul ax, word ptr [bp + 6], 0x2e
2117  C4 3E C0 DC     les di, ptr [0xdcc0]
211B  03 F8           add di, ax
211D  81 C7 D2 FF     add di, 0xffd2
2121  89 7E FC        mov word ptr [bp - 4], di
2124  8C 46 FE        mov word ptr [bp - 2], es
2127  26 8A 45 0D     mov al, byte ptr es:[di + 0xd]
212B  26 3A 45 0C     cmp al, byte ptr es:[di + 0xc]
212F  76 08           jbe 0x2139
2131  26 8A 45 0D     mov al, byte ptr es:[di + 0xd]
2135  26 88 45 0C     mov byte ptr es:[di + 0xc], al
loc_2139:
2139  C4 7E FC        les di, ptr [bp - 4]
213C  26 8A 45 0F     mov al, byte ptr es:[di + 0xf]
2140  26 3A 45 0E     cmp al, byte ptr es:[di + 0xe]
2144  76 08           jbe 0x214e
2146  26 8A 45 0F     mov al, byte ptr es:[di + 0xf]
214A  26 88 45 0E     mov byte ptr es:[di + 0xe], al
loc_214E:
214E  C4 7E FC        les di, ptr [bp - 4]
2151  26 8A 45 11     mov al, byte ptr es:[di + 0x11]
2155  26 3A 45 10     cmp al, byte ptr es:[di + 0x10]
2159  76 08           jbe 0x2163
215B  26 8A 45 11     mov al, byte ptr es:[di + 0x11]
215F  26 88 45 10     mov byte ptr es:[di + 0x10], al
loc_2163:
2163  C4 7E FC        les di, ptr [bp - 4]
2166  26 8A 45 13     mov al, byte ptr es:[di + 0x13]
216A  26 3A 45 12     cmp al, byte ptr es:[di + 0x12]
216E  76 08           jbe 0x2178
2170  26 8A 45 13     mov al, byte ptr es:[di + 0x13]
2174  26 88 45 12     mov byte ptr es:[di + 0x12], al
loc_2178:
2178  C4 3E D2 D7     les di, ptr [0xd7d2]
217C  89 7E F8        mov word ptr [bp - 8], di
217F  8C 46 FA        mov word ptr [bp - 6], es
2182  6B 46 06 3E     imul ax, word ptr [bp + 6], 0x3e
2186  C4 3E C2 D7     les di, ptr [0xd7c2]
218A  03 F8           add di, ax
218C  81 C7 C2 FF     add di, 0xffc2
2190  89 7E F4        mov word ptr [bp - 0xc], di
2193  8C 46 F6        mov word ptr [bp - 0xa], es
2196  26 8A 45 37     mov al, byte ptr es:[di + 0x37]
219A  98              cwde
219B  C1 E0 02        shl ax, 2
219E  C4 7E F8        les di, ptr [bp - 8]
21A1  03 F8           add di, ax
21A3  26 8A 45 44     mov al, byte ptr es:[di + 0x44]
21A7  C4 7E FC        les di, ptr [bp - 4]
21AA  26 3A 45 0D     cmp al, byte ptr es:[di + 0xd]
21AE  73 0D           jae 0x21bd
21B0  26 8A 45 0D     mov al, byte ptr es:[di + 0xd]
21B4  30 E4           xor ah, ah
21B6  50              push ax
21B7  6A 01           push 1
21B9  55              push bp
21BA  E8 F4 FE        call 0x20b1
loc_21BD:
21BD  C4 7E F4        les di, ptr [bp - 0xc]
21C0  26 8A 45 37     mov al, byte ptr es:[di + 0x37]
21C4  98              cwde
21C5  C1 E0 02        shl ax, 2
21C8  C4 7E F8        les di, ptr [bp - 8]
21CB  03 F8           add di, ax
21CD  26 8A 45 45     mov al, byte ptr es:[di + 0x45]
21D1  C4 7E FC        les di, ptr [bp - 4]
21D4  26 3A 45 0F     cmp al, byte ptr es:[di + 0xf]
21D8  73 0D           jae 0x21e7
21DA  26 8A 45 0F     mov al, byte ptr es:[di + 0xf]
21DE  30 E4           xor ah, ah
21E0  50              push ax
21E1  6A 02           push 2
21E3  55              push bp
21E4  E8 CA FE        call 0x20b1
loc_21E7:
21E7  C4 7E F4        les di, ptr [bp - 0xc]
21EA  26 8A 45 37     mov al, byte ptr es:[di + 0x37]
21EE  98              cwde
21EF  C1 E0 02        shl ax, 2
21F2  C4 7E F8        les di, ptr [bp - 8]
21F5  03 F8           add di, ax
21F7  26 8A 45 46     mov al, byte ptr es:[di + 0x46]
21FB  C4 7E FC        les di, ptr [bp - 4]
21FE  26 3A 45 11     cmp al, byte ptr es:[di + 0x11]
2202  73 0D           jae 0x2211
2204  26 8A 45 11     mov al, byte ptr es:[di + 0x11]
2208  30 E4           xor ah, ah
220A  50              push ax
220B  6A 03           push 3
220D  55              push bp
220E  E8 A0 FE        call 0x20b1
loc_2211:
2211  C4 7E F4        les di, ptr [bp - 0xc]
2214  26 8A 45 37     mov al, byte ptr es:[di + 0x37]
2218  98              cwde
2219  C1 E0 02        shl ax, 2
221C  C4 7E F8        les di, ptr [bp - 8]
221F  03 F8           add di, ax
2221  26 8A 45 47     mov al, byte ptr es:[di + 0x47]
2225  C4 7E FC        les di, ptr [bp - 4]
2228  26 3A 45 13     cmp al, byte ptr es:[di + 0x13]
222C  73 0D           jae 0x223b
222E  26 8A 45 13     mov al, byte ptr es:[di + 0x13]
2232  30 E4           xor ah, ah
2234  50              push ax
2235  6A 04           push 4
2237  55              push bp
2238  E8 76 FE        call 0x20b1
loc_223B:
223B  C9              leave
223C  C2 04 00        ret 4

; ---- routine 1B55:223F  (found by: call)
sub_223F:
223F  55              push bp
2240  89 E5           mov bp, sp
2242  6B 46 0C 2E     imul ax, word ptr [bp + 0xc], 0x2e
2246  C4 3E C0 DC     les di, ptr [0xdcc0]
224A  03 F8           add di, ax
224C  26 FE 45 DF     inc byte ptr es:[di - 0x21]
2250  6B 46 0C 2E     imul ax, word ptr [bp + 0xc], 0x2e
2254  C4 3E C0 DC     les di, ptr [0xdcc0]
2258  03 F8           add di, ax
225A  26 FE 45 E5     inc byte ptr es:[di - 0x1b]
225E  6B 46 0C 2E     imul ax, word ptr [bp + 0xc], 0x2e
2262  C4 3E C0 DC     les di, ptr [0xdcc0]
2266  03 F8           add di, ax
2268  26 C6 45 E3 00  mov byte ptr es:[di - 0x1d], 0
226D  6B 46 0C 2E     imul ax, word ptr [bp + 0xc], 0x2e
2271  C4 3E C0 DC     les di, ptr [0xdcc0]
2275  03 F8           add di, ax
2277  26 C6 45 E1 00  mov byte ptr es:[di - 0x1f], 0
227C  6B 46 0A 2E     imul ax, word ptr [bp + 0xa], 0x2e
2280  C4 3E C0 DC     les di, ptr [0xdcc0]
2284  03 F8           add di, ax
2286  26 FE 45 E1     inc byte ptr es:[di - 0x1f]
228A  6B 46 0A 2E     imul ax, word ptr [bp + 0xa], 0x2e
228E  C4 3E C0 DC     les di, ptr [0xdcc0]
2292  03 F8           add di, ax
2294  26 FE 45 E3     inc byte ptr es:[di - 0x1d]
2298  6B 46 0A 2E     imul ax, word ptr [bp + 0xa], 0x2e
229C  C4 3E C0 DC     les di, ptr [0xdcc0]
22A0  03 F8           add di, ax
22A2  26 C6 45 DF 00  mov byte ptr es:[di - 0x21], 0
22A7  6B 46 0A 2E     imul ax, word ptr [bp + 0xa], 0x2e
22AB  C4 3E C0 DC     les di, ptr [0xdcc0]
22AF  03 F8           add di, ax
22B1  26 C6 45 E5 00  mov byte ptr es:[di - 0x1b], 0
22B6  8B 56 08        mov dx, word ptr [bp + 8]
22B9  6B 46 0C 0C     imul ax, word ptr [bp + 0xc], 0xc
22BD  C4 3E C6 D7     les di, ptr [0xd7c6]
22C1  03 F8           add di, ax
22C3  03 FA           add di, dx
22C5  26 FE 45 F5     inc byte ptr es:[di - 0xb]
22C9  8A 16 E0 DC     mov dl, byte ptr [0xdce0]
22CD  6B 46 0C 0C     imul ax, word ptr [bp + 0xc], 0xc
22D1  C4 3E C6 D7     les di, ptr [0xd7c6]
22D5  03 F8           add di, ax
22D7  26 00 55 F5     add byte ptr es:[di - 0xb], dl
22DB  6B 46 0C 3E     imul ax, word ptr [bp + 0xc], 0x3e
22DF  C4 3E C2 D7     les di, ptr [0xd7c2]
22E3  03 F8           add di, ax
22E5  26 80 45 F7 02  add byte ptr es:[di - 9], 2
22EA  8B 56 06        mov dx, word ptr [bp + 6]
22ED  6B 46 0A 0C     imul ax, word ptr [bp + 0xa], 0xc
22F1  C4 3E C6 D7     les di, ptr [0xd7c6]
22F5  03 F8           add di, ax
22F7  03 FA           add di, dx
22F9  26 FE 45 F9     inc byte ptr es:[di - 7]
22FD  C9              leave
22FE  C2 0A 00        ret 0xa

; ---- routine 1B55:2301  (found by: far)
sub_2301:
2301  C8 04 00 00     enter 4, 0
2305  8B 56 06        mov dx, word ptr [bp + 6]
2308  6B 46 08 3A     imul ax, word ptr [bp + 8], 0x3a
230C  C4 3E CE D7     les di, ptr [0xd7ce]
2310  03 F8           add di, ax
2312  03 FA           add di, dx
2314  26 8A 45 C5     mov al, byte ptr es:[di - 0x3b]
2318  50              push ax
2319  8D 7E FE        lea di, [bp - 2]
231C  16              push ss
231D  57              push di
231E  9A E3 01 2A 23  call far 232A:01E3
2323  8B 46 06        mov ax, word ptr [bp + 6]
2326  8B F0           mov si, ax
2328  D1 E0           shl ax, 1
232A  01 F0           add ax, si
232C  8B D0           mov dx, ax
232E  69 46 08 AE 00  imul ax, word ptr [bp + 8], 0xae
2333  C4 3E CA D7     les di, ptr [0xd7ca]
2337  03 F8           add di, ax
2339  03 FA           add di, dx
233B  26 8A 85 50 FF  mov al, byte ptr es:[di - 0xb0]
2340  30 E4           xor ah, ah
2342  89 46 FC        mov word ptr [bp - 4], ax
2345  6B 46 08 0C     imul ax, word ptr [bp + 8], 0xc
2349  C4 3E C6 D7     les di, ptr [0xd7c6]
234D  03 F8           add di, ax
234F  26 FE 45 F4     inc byte ptr es:[di - 0xc]
2353  6B 46 FC 0C     imul ax, word ptr [bp - 4], 0xc
2357  C4 3E C6 D7     les di, ptr [0xd7c6]
235B  03 F8           add di, ax
235D  26 FE 45 F4     inc byte ptr es:[di - 0xc]
2361  8A 46 FE        mov al, byte ptr [bp - 2]
2364  30 E4           xor ah, ah
2366  8B D0           mov dx, ax
2368  6B 46 08 0C     imul ax, word ptr [bp + 8], 0xc
236C  C4 3E C6 D7     les di, ptr [0xd7c6]
2370  03 F8           add di, ax
2372  26 01 55 FC     add word ptr es:[di - 4], dx
2376  8A 46 FE        mov al, byte ptr [bp - 2]
2379  30 E4           xor ah, ah
237B  8B D0           mov dx, ax
237D  6B 46 FC 0C     imul ax, word ptr [bp - 4], 0xc
2381  C4 3E C6 D7     les di, ptr [0xd7c6]
2385  03 F8           add di, ax
2387  26 01 55 FE     add word ptr es:[di - 2], dx
238B  8A 46 FF        mov al, byte ptr [bp - 1]
238E  30 E4           xor ah, ah
2390  8B D0           mov dx, ax
2392  6B 46 08 0C     imul ax, word ptr [bp + 8], 0xc
2396  C4 3E C6 D7     les di, ptr [0xd7c6]
239A  03 F8           add di, ax
239C  26 01 55 FE     add word ptr es:[di - 2], dx
23A0  8A 46 FF        mov al, byte ptr [bp - 1]
23A3  30 E4           xor ah, ah
23A5  8B D0           mov dx, ax
23A7  6B 46 FC 0C     imul ax, word ptr [bp - 4], 0xc
23AB  C4 3E C6 D7     les di, ptr [0xd7c6]
23AF  03 F8           add di, ax
23B1  26 01 55 FC     add word ptr es:[di - 4], dx
23B5  8A 46 FE        mov al, byte ptr [bp - 2]
23B8  3A 46 FF        cmp al, byte ptr [bp - 1]
23BB  76 11           jbe 0x23ce
23BD  FF 76 08        push word ptr [bp + 8]
23C0  FF 76 FC        push word ptr [bp - 4]
23C3  6A 01           push 1
23C5  6A 02           push 2
23C7  55              push bp
23C8  E8 74 FE        call 0x223f
23CB  E9 E3 00        jmp 0x24b1
loc_23CE:
23CE  8A 46 FE        mov al, byte ptr [bp - 2]
23D1  3A 46 FF        cmp al, byte ptr [bp - 1]
23D4  74 03           je 0x23d9
23D6  E9 CA 00        jmp 0x24a3
loc_23D9:
23D9  6B 46 08 2E     imul ax, word ptr [bp + 8], 0x2e
23DD  C4 3E C0 DC     les di, ptr [0xdcc0]
23E1  03 F8           add di, ax
23E3  26 FE 45 E5     inc byte ptr es:[di - 0x1b]
23E7  6B 46 FC 2E     imul ax, word ptr [bp - 4], 0x2e
23EB  C4 3E C0 DC     les di, ptr [0xdcc0]
23EF  03 F8           add di, ax
23F1  26 FE 45 E5     inc byte ptr es:[di - 0x1b]
23F5  6B 46 08 2E     imul ax, word ptr [bp + 8], 0x2e
23F9  C4 3E C0 DC     les di, ptr [0xdcc0]
23FD  03 F8           add di, ax
23FF  26 FE 45 E3     inc byte ptr es:[di - 0x1d]
2403  6B 46 FC 2E     imul ax, word ptr [bp - 4], 0x2e
2407  C4 3E C0 DC     les di, ptr [0xdcc0]
240B  03 F8           add di, ax
240D  26 FE 45 E3     inc byte ptr es:[di - 0x1d]
2411  6B 46 08 2E     imul ax, word ptr [bp + 8], 0x2e
2415  C4 3E C0 DC     les di, ptr [0xdcc0]
2419  03 F8           add di, ax
241B  26 C6 45 E1 00  mov byte ptr es:[di - 0x1f], 0
2420  6B 46 FC 2E     imul ax, word ptr [bp - 4], 0x2e
2424  C4 3E C0 DC     les di, ptr [0xdcc0]
2428  03 F8           add di, ax
242A  26 C6 45 E1 00  mov byte ptr es:[di - 0x1f], 0
242F  6B 46 08 2E     imul ax, word ptr [bp + 8], 0x2e
2433  C4 3E C0 DC     les di, ptr [0xdcc0]
2437  03 F8           add di, ax
2439  26 C6 45 DF 00  mov byte ptr es:[di - 0x21], 0
243E  6B 46 FC 2E     imul ax, word ptr [bp - 4], 0x2e
2442  C4 3E C0 DC     les di, ptr [0xdcc0]
2446  03 F8           add di, ax
2448  26 C6 45 DF 00  mov byte ptr es:[di - 0x21], 0
244D  6B 46 08 0C     imul ax, word ptr [bp + 8], 0xc
2451  C4 3E C6 D7     les di, ptr [0xd7c6]
2455  03 F8           add di, ax
2457  26 FE 45 F8     inc byte ptr es:[di - 8]
245B  6B 46 08 0C     imul ax, word ptr [bp + 8], 0xc
245F  C4 3E C6 D7     les di, ptr [0xd7c6]
2463  03 F8           add di, ax
2465  26 FE 45 F5     inc byte ptr es:[di - 0xb]
2469  6B 46 08 3E     imul ax, word ptr [bp + 8], 0x3e
246D  C4 3E C2 D7     les di, ptr [0xd7c2]
2471  03 F8           add di, ax
2473  26 FE 45 F7     inc byte ptr es:[di - 9]
2477  6B 46 FC 0C     imul ax, word ptr [bp - 4], 0xc
247B  C4 3E C6 D7     les di, ptr [0xd7c6]
247F  03 F8           add di, ax
2481  26 FE 45 F9     inc byte ptr es:[di - 7]
2485  6B 46 FC 0C     imul ax, word ptr [bp - 4], 0xc
2489  C4 3E C6 D7     les di, ptr [0xd7c6]
248D  03 F8           add di, ax
248F  26 FE 45 F5     inc byte ptr es:[di - 0xb]
2493  6B 46 FC 3E     imul ax, word ptr [bp - 4], 0x3e
2497  C4 3E C2 D7     les di, ptr [0xd7c2]
249B  03 F8           add di, ax
249D  26 FE 45 F7     inc byte ptr es:[di - 9]
24A1  EB 0E           jmp 0x24b1
loc_24A3:
24A3  FF 76 FC        push word ptr [bp - 4]
24A6  FF 76 08        push word ptr [bp + 8]
24A9  6A 02           push 2
24AB  6A 01           push 1
24AD  55              push bp
24AE  E8 8E FD        call 0x223f
loc_24B1:
24B1  FF 76 08        push word ptr [bp + 8]
24B4  55              push bp
24B5  E8 57 FC        call 0x210f
24B8  FF 76 FC        push word ptr [bp - 4]
24BB  55              push bp
24BC  E8 50 FC        call 0x210f
24BF  C9              leave
24C0  CA 04 00        retf 4

; ---- routine 1B55:24C3  (found by: far)
sub_24C3:
24C3  C8 08 00 00     enter 8, 0
24C7  8B 56 06        mov dx, word ptr [bp + 6]
24CA  6B 46 08 3A     imul ax, word ptr [bp + 8], 0x3a
24CE  C4 3E CE D7     les di, ptr [0xd7ce]
24D2  03 F8           add di, ax
24D4  03 FA           add di, dx
24D6  26 8A 45 C5     mov al, byte ptr es:[di - 0x3b]
24DA  50              push ax
24DB  8D 7E FE        lea di, [bp - 2]
24DE  16              push ss
24DF  57              push di
24E0  9A E3 01 2A 23  call far 232A:01E3
24E5  C7 46 FC 01 00  mov word ptr [bp - 4], 1
24EA  EB 03           jmp 0x24ef
loc_24EC:
24EC  FF 46 FC        inc word ptr [bp - 4]
loc_24EF:
24EF  8B 7E FC        mov di, word ptr [bp - 4]
24F2  8A 85 A5 DC     mov al, byte ptr [di - 0x235b]
24F6  30 E4           xor ah, ah
24F8  3B 46 08        cmp ax, word ptr [bp + 8]
24FB  75 06           jne 0x2503
24FD  8B 46 FC        mov ax, word ptr [bp - 4]
2500  89 46 F8        mov word ptr [bp - 8], ax
loc_2503:
2503  83 7E FC 08     cmp word ptr [bp - 4], 8
2507  75 E3           jne 0x24ec
2509  C7 46 FC 01 00  mov word ptr [bp - 4], 1
250E  EB 03           jmp 0x2513
loc_2510:
2510  FF 46 FC        inc word ptr [bp - 4]
loc_2513:
2513  8B 46 06        mov ax, word ptr [bp + 6]
2516  8B F0           mov si, ax
2518  D1 E0           shl ax, 1
251A  01 F0           add ax, si
251C  8B D0           mov dx, ax
251E  69 46 08 AE 00  imul ax, word ptr [bp + 8], 0xae
2523  C4 3E CA D7     les di, ptr [0xd7ca]
2527  03 F8           add di, ax
2529  03 FA           add di, dx
252B  26 8A 85 50 FF  mov al, byte ptr es:[di - 0xb0]
2530  8B 7E FC        mov di, word ptr [bp - 4]
2533  3A 85 A5 DC     cmp al, byte ptr [di - 0x235b]
2537  75 06           jne 0x253f
2539  8B 46 FC        mov ax, word ptr [bp - 4]
253C  89 46 FA        mov word ptr [bp - 6], ax
loc_253F:
253F  83 7E FC 08     cmp word ptr [bp - 4], 8
2543  75 CB           jne 0x2510
2545  6B 46 F8 0C     imul ax, word ptr [bp - 8], 0xc
2549  C4 3E B6 DC     les di, ptr [0xdcb6]
254D  03 F8           add di, ax
254F  26 FE 45 F4     inc byte ptr es:[di - 0xc]
2553  6B 46 FA 0C     imul ax, word ptr [bp - 6], 0xc
2557  C4 3E B6 DC     les di, ptr [0xdcb6]
255B  03 F8           add di, ax
255D  26 FE 45 F4     inc byte ptr es:[di - 0xc]
2561  8A 46 FE        mov al, byte ptr [bp - 2]
2564  30 E4           xor ah, ah
2566  8B D0           mov dx, ax
2568  6B 46 F8 0C     imul ax, word ptr [bp - 8], 0xc
256C  C4 3E B6 DC     les di, ptr [0xdcb6]
2570  03 F8           add di, ax
2572  26 01 55 FC     add word ptr es:[di - 4], dx
2576  8A 46 FE        mov al, byte ptr [bp - 2]
2579  30 E4           xor ah, ah
257B  8B D0           mov dx, ax
257D  6B 46 FA 0C     imul ax, word ptr [bp - 6], 0xc
2581  C4 3E B6 DC     les di, ptr [0xdcb6]
2585  03 F8           add di, ax
2587  26 01 55 FE     add word ptr es:[di - 2], dx
258B  8A 46 FF        mov al, byte ptr [bp - 1]
258E  30 E4           xor ah, ah
2590  8B D0           mov dx, ax
2592  6B 46 F8 0C     imul ax, word ptr [bp - 8], 0xc
2596  C4 3E B6 DC     les di, ptr [0xdcb6]
259A  03 F8           add di, ax
259C  26 01 55 FE     add word ptr es:[di - 2], dx
25A0  8A 46 FF        mov al, byte ptr [bp - 1]
25A3  30 E4           xor ah, ah
25A5  8B D0           mov dx, ax
25A7  6B 46 FA 0C     imul ax, word ptr [bp - 6], 0xc
25AB  C4 3E B6 DC     les di, ptr [0xdcb6]
25AF  03 F8           add di, ax
25B1  26 01 55 FC     add word ptr es:[di - 4], dx
25B5  8A 46 FE        mov al, byte ptr [bp - 2]
25B8  3A 46 FF        cmp al, byte ptr [bp - 1]
25BB  76 2D           jbe 0x25ea
25BD  6B 46 F8 0C     imul ax, word ptr [bp - 8], 0xc
25C1  C4 3E B6 DC     les di, ptr [0xdcb6]
25C5  03 F8           add di, ax
25C7  26 FE 45 F6     inc byte ptr es:[di - 0xa]
25CB  6B 46 F8 0C     imul ax, word ptr [bp - 8], 0xc
25CF  C4 3E B6 DC     les di, ptr [0xdcb6]
25D3  03 F8           add di, ax
25D5  26 80 45 F5 02  add byte ptr es:[di - 0xb], 2
25DA  6B 46 FA 0C     imul ax, word ptr [bp - 6], 0xc
25DE  C4 3E B6 DC     les di, ptr [0xdcb6]
25E2  03 F8           add di, ax
25E4  26 FE 45 FB     inc byte ptr es:[di - 5]
25E8  EB 6D           jmp 0x2657
loc_25EA:
25EA  8A 46 FE        mov al, byte ptr [bp - 2]
25ED  3A 46 FF        cmp al, byte ptr [bp - 1]
25F0  75 3A           jne 0x262c
25F2  6B 46 F8 0C     imul ax, word ptr [bp - 8], 0xc
25F6  C4 3E B6 DC     les di, ptr [0xdcb6]
25FA  03 F8           add di, ax
25FC  26 FE 45 F8     inc byte ptr es:[di - 8]
2600  6B 46 F8 0C     imul ax, word ptr [bp - 8], 0xc
2604  C4 3E B6 DC     les di, ptr [0xdcb6]
2608  03 F8           add di, ax
260A  26 FE 45 F5     inc byte ptr es:[di - 0xb]
260E  6B 46 FA 0C     imul ax, word ptr [bp - 6], 0xc
2612  C4 3E B6 DC     les di, ptr [0xdcb6]
2616  03 F8           add di, ax
2618  26 FE 45 F9     inc byte ptr es:[di - 7]
261C  6B 46 FA 0C     imul ax, word ptr [bp - 6], 0xc
2620  C4 3E B6 DC     les di, ptr [0xdcb6]
2624  03 F8           add di, ax
2626  26 FE 45 F5     inc byte ptr es:[di - 0xb]
262A  EB 2B           jmp 0x2657
loc_262C:
262C  6B 46 F8 0C     imul ax, word ptr [bp - 8], 0xc
2630  C4 3E B6 DC     les di, ptr [0xdcb6]
2634  03 F8           add di, ax
2636  26 FE 45 FA     inc byte ptr es:[di - 6]
263A  6B 46 FA 0C     imul ax, word ptr [bp - 6], 0xc
263E  C4 3E B6 DC     les di, ptr [0xdcb6]
2642  03 F8           add di, ax
2644  26 FE 45 F7     inc byte ptr es:[di - 9]
2648  6B 46 FA 0C     imul ax, word ptr [bp - 6], 0xc
264C  C4 3E B6 DC     les di, ptr [0xdcb6]
2650  03 F8           add di, ax
2652  26 80 45 F5 02  add byte ptr es:[di - 0xb], 2
loc_2657:
2657  C9              leave
2658  CA 04 00        retf 4

; ---- routine 1B55:265B  (found by: call, far)
sub_265B:
265B  C8 08 00 00     enter 8, 0
265F  6B 46 06 3E     imul ax, word ptr [bp + 6], 0x3e
2663  C4 3E C2 D7     les di, ptr [0xd7c2]
2667  03 F8           add di, ax
2669  81 C7 C2 FF     add di, 0xffc2
266D  89 7E F8        mov word ptr [bp - 8], di
2670  8C 46 FA        mov word ptr [bp - 6], es
2673  26 80 7D 36 00  cmp byte ptr es:[di + 0x36], 0
2678  75 17           jne 0x2691
267A  26 8B 05        mov ax, word ptr es:[di]
267D  C1 E0 03        shl ax, 3
2680  C4 3E BA D7     les di, ptr [0xd7ba]
2684  03 F8           add di, ax
2686  26 8A 45 05     mov al, byte ptr es:[di + 5]
268A  30 E4           xor ah, ah
268C  89 46 FC        mov word ptr [bp - 4], ax
268F  EB 0C           jmp 0x269d
loc_2691:
2691  C4 7E F8        les di, ptr [bp - 8]
2694  26 8A 45 36     mov al, byte ptr es:[di + 0x36]
2698  30 E4           xor ah, ah
269A  89 46 FC        mov word ptr [bp - 4], ax
loc_269D:
269D  C4 7E F8        les di, ptr [bp - 8]
26A0  26 8A 45 33     mov al, byte ptr es:[di + 0x33]
26A4  30 E4           xor ah, ah
26A6  8B D0           mov dx, ax
26A8  B8 B1 00        mov ax, 0xb1
26AB  2B C2           sub ax, dx
26AD  05 10 00        add ax, 0x10
26B0  2B 46 FC        sub ax, word ptr [bp - 4]
26B3  89 46 FE        mov word ptr [bp - 2], ax
26B6  8B 46 FE        mov ax, word ptr [bp - 2]
26B9  C9              leave
26BA  CA 02 00        retf 2

; ---- routine 1B55:26BD  (found by: far)
sub_26BD:
26BD  C8 06 00 00     enter 6, 0
26C1  6B 46 06 3E     imul ax, word ptr [bp + 6], 0x3e
26C5  C4 3E C2 D7     les di, ptr [0xd7c2]
26C9  03 F8           add di, ax
26CB  81 C7 C2 FF     add di, 0xffc2
26CF  89 7E FA        mov word ptr [bp - 6], di
26D2  8C 46 FC        mov word ptr [bp - 4], es
26D5  26 8A 45 37     mov al, byte ptr es:[di + 0x37]
26D9  98              cwde
26DA  8B F8           mov di, ax
26DC  8A 85 1C 10     mov al, byte ptr [di + 0x101c]
26E0  30 E4           xor ah, ah
26E2  8B C8           mov cx, ax
26E4  C4 7E FA        les di, ptr [bp - 6]
26E7  26 8A 45 36     mov al, byte ptr es:[di + 0x36]
26EB  30 E4           xor ah, ah
26ED  8B D0           mov dx, ax
26EF  B8 11 00        mov ax, 0x11
26F2  2B C2           sub ax, dx
26F4  03 C1           add ax, cx
26F6  89 46 FE        mov word ptr [bp - 2], ax
26F9  8B 46 FE        mov ax, word ptr [bp - 2]
26FC  C9              leave
26FD  CA 02 00        retf 2

; ---- routine 1B55:2700  (found by: call, far)
sub_2700:
2700  C8 08 00 00     enter 8, 0
2704  8B 7E 06        mov di, word ptr [bp + 6]
2707  8A 85 E5 D9     mov al, byte ptr [di - 0x261b]
270B  30 E4           xor ah, ah
270D  31 D2           xor dx, dx
270F  89 46 F8        mov word ptr [bp - 8], ax
2712  89 56 FA        mov word ptr [bp - 6], dx
2715  8B 46 F8        mov ax, word ptr [bp - 8]
2718  8B 56 FA        mov dx, word ptr [bp - 6]
271B  B9 E8 03        mov cx, 0x3e8
271E  31 DB           xor bx, bx
2720  9A 2A 0A C9 26  call far 26C9:0A2A
2725  89 46 FC        mov word ptr [bp - 4], ax
2728  89 56 FE        mov word ptr [bp - 2], dx
272B  8B 46 FC        mov ax, word ptr [bp - 4]
272E  8B 56 FE        mov dx, word ptr [bp - 2]
2731  C9              leave
2732  CA 02 00        retf 2

; ---- routine 1B55:2735  (found by: call)
sub_2735:
2735  C8 16 00 00     enter 0x16, 0
2739  6B 46 04 3E     imul ax, word ptr [bp + 4], 0x3e
273D  C4 3E C2 D7     les di, ptr [0xd7c2]
2741  03 F8           add di, ax
2743  81 C7 C2 FF     add di, 0xffc2
2747  89 7E EE        mov word ptr [bp - 0x12], di
274A  8C 46 F0        mov word ptr [bp - 0x10], es
274D  C4 3E D2 D7     les di, ptr [0xd7d2]
2751  26 8A 05        mov al, byte ptr es:[di]
2754  30 E4           xor ah, ah
2756  8B F0           mov si, ax
2758  D1 E0           shl ax, 1
275A  01 F0           add ax, si
275C  8B D0           mov dx, ax
275E  69 46 04 AE 00  imul ax, word ptr [bp + 4], 0xae
2763  C4 3E CA D7     les di, ptr [0xd7ca]
2767  03 F8           add di, ax
2769  03 FA           add di, dx
276B  81 C7 4F FF     add di, 0xff4f
276F  89 7E EA        mov word ptr [bp - 0x16], di
2772  8C 46 EC        mov word ptr [bp - 0x14], es
2775  8B 7E 04        mov di, word ptr [bp + 4]
2778  8A 85 35 D9     mov al, byte ptr [di - 0x26cb]
277C  30 E4           xor ah, ah
277E  31 D2           xor dx, dx
2780  89 46 F8        mov word ptr [bp - 8], ax
2783  89 56 FA        mov word ptr [bp - 6], dx
2786  80 3E DD D6 00  cmp byte ptr [0xd6dd], 0
278B  75 07           jne 0x2794
278D  C7 46 F2 08 00  mov word ptr [bp - 0xe], 8
2792  EB 15           jmp 0x27a9
loc_2794:
2794  C4 7E EA        les di, ptr [bp - 0x16]
2797  26 80 3D 00     cmp byte ptr es:[di], 0
279B  75 07           jne 0x27a4
279D  C7 46 F2 0C 00  mov word ptr [bp - 0xe], 0xc
27A2  EB 05           jmp 0x27a9
loc_27A4:
27A4  C7 46 F2 0F 00  mov word ptr [bp - 0xe], 0xf
loc_27A9:
27A9  68 E7 03        push 0x3e7
27AC  9A 6D 07 2A 23  call far 232A:076D
27B1  99              cdq
27B2  52              push dx
27B3  50              push ax
27B4  6A 00           push 0
27B6  6A 0B           push 0xb
27B8  8B 46 F8        mov ax, word ptr [bp - 8]
27BB  8B 56 FA        mov dx, word ptr [bp - 6]
27BE  B9 12 00        mov cx, 0x12
27C1  31 DB           xor bx, bx
27C3  9A 67 0A C9 26  call far 26C9:0A67
27C8  52              push dx
27C9  50              push ax
27CA  9A FA 04 BC 24  call far 24BC:04FA
27CF  8B D0           mov dx, ax
27D1  C4 7E EA        les di, ptr [bp - 0x16]
27D4  26 8A 45 02     mov al, byte ptr es:[di + 2]
27D8  24 0F           and al, 0xf
27DA  08 C0           or al, al
27DC  B0 00           mov al, 0
27DE  74 01           je 0x27e1
27E0  40              inc ax
loc_27E1:
27E1  98              cwde
27E2  6B F8 0C        imul di, ax, 0xc
27E5  03 FA           add di, dx
27E7  8A 85 22 10     mov al, byte ptr [di + 0x1022]
27EB  30 E4           xor ah, ah
27ED  31 D2           xor dx, dx
27EF  8B 4E F8        mov cx, word ptr [bp - 8]
27F2  8B 5E FA        mov bx, word ptr [bp - 6]
27F5  9A 2A 0A C9 26  call far 26C9:0A2A
27FA  8B C8           mov cx, ax
27FC  8B DA           mov bx, dx
27FE  8B 46 F2        mov ax, word ptr [bp - 0xe]
2801  31 D2           xor dx, dx
2803  9A 2A 0A C9 26  call far 26C9:0A2A
2808  8B C8           mov cx, ax
280A  8B DA           mov bx, dx
280C  C4 7E EE        les di, ptr [bp - 0x12]
280F  26 8A 45 36     mov al, byte ptr es:[di + 0x36]
2813  30 E4           xor ah, ah
2815  8B D0           mov dx, ax
2817  B8 1F 00        mov ax, 0x1f
281A  2B C2           sub ax, dx
281C  99              cdq
281D  9A 2A 0A C9 26  call far 26C9:0A2A
2822  B9 1E 00        mov cx, 0x1e
2825  31 DB           xor bx, bx
2827  9A 67 0A C9 26  call far 26C9:0A67
282C  59              pop cx
282D  5B              pop bx
282E  03 C1           add ax, cx
2830  13 D3           adc dx, bx
2832  89 46 F4        mov word ptr [bp - 0xc], ax
2835  89 56 F6        mov word ptr [bp - 0xa], dx
2838  8B 46 F4        mov ax, word ptr [bp - 0xc]
283B  8B 56 F6        mov dx, word ptr [bp - 0xa]
283E  89 46 FC        mov word ptr [bp - 4], ax
2841  89 56 FE        mov word ptr [bp - 2], dx
2844  8B 46 FC        mov ax, word ptr [bp - 4]
2847  8B 56 FE        mov dx, word ptr [bp - 2]
284A  C9              leave
284B  C2 02 00        ret 2

; ---- routine 1B55:284E  (found by: far)
sub_284E:
284E  C8 12 00 00     enter 0x12, 0
2852  C4 3E D2 D7     les di, ptr [0xd7d2]
2856  26 8A 05        mov al, byte ptr es:[di]
2859  30 E4           xor ah, ah
285B  8B F0           mov si, ax
285D  D1 E0           shl ax, 1
285F  01 F0           add ax, si
2861  8B D0           mov dx, ax
2863  69 06 E6 D6 AE 00 imul ax, word ptr [0xd6e6], 0xae
2869  C4 3E CA D7     les di, ptr [0xd7ca]
286D  03 F8           add di, ax
286F  03 FA           add di, dx
2871  81 C7 4F FF     add di, 0xff4f
2875  89 7E F6        mov word ptr [bp - 0xa], di
2878  8C 46 F8        mov word ptr [bp - 8], es
287B  FF 36 E4 D6     push word ptr [0xd6e4]
287F  E8 B3 FE        call 0x2735
2882  52              push dx
2883  50              push ax
2884  FF 36 E6 D6     push word ptr [0xd6e6]
2888  E8 AA FE        call 0x2735
288B  59              pop cx
288C  5B              pop bx
288D  03 C1           add ax, cx
288F  13 D3           adc dx, bx
2891  A3 E8 D6        mov word ptr [0xd6e8], ax
2894  89 16 EA D6     mov word ptr [0xd6ea], dx
2898  C4 7E F6        les di, ptr [bp - 0xa]
289B  26 8A 45 02     mov al, byte ptr es:[di + 2]
289F  24 0F           and al, 0xf
28A1  3C 01           cmp al, 1
28A3  75 3E           jne 0x28e3
28A5  FF 36 E6 D6     push word ptr [0xd6e6]
28A9  0E              push cs
28AA  E8 53 FE        call 0x2700
28AD  3B 16 EA D6     cmp dx, word ptr [0xd6ea]
28B1  7C 08           jl 0x28bb
28B3  7F 2B           jg 0x28e0
28B5  3B 06 E8 D6     cmp ax, word ptr [0xd6e8]
28B9  73 25           jae 0x28e0
loc_28BB:
28BB  6A 32           push 0x32
28BD  9A 6D 07 2A 23  call far 232A:076D
28C2  99              cdq
28C3  52              push dx
28C4  50              push ax
28C5  FF 36 E6 D6     push word ptr [0xd6e6]
28C9  0E              push cs
28CA  E8 33 FE        call 0x2700
28CD  05 01 00        add ax, 1
28D0  83 D2 00        adc dx, 0
28D3  59              pop cx
28D4  5B              pop bx
28D5  2B C1           sub ax, cx
28D7  1B D3           sbb dx, bx
28D9  A3 E8 D6        mov word ptr [0xd6e8], ax
28DC  89 16 EA D6     mov word ptr [0xd6ea], dx
loc_28E0:
28E0  E9 8D 00        jmp 0x2970
loc_28E3:
28E3  A1 E8 D6        mov ax, word ptr [0xd6e8]
28E6  8B 16 EA D6     mov dx, word ptr [0xd6ea]
28EA  B9 E8 03        mov cx, 0x3e8
28ED  31 DB           xor bx, bx
28EF  9A 67 0A C9 26  call far 26C9:0A67
28F4  8B C8           mov cx, ax
28F6  8B DA           mov bx, dx
28F8  C4 7E F6        les di, ptr [bp - 0xa]
28FB  26 8A 05        mov al, byte ptr es:[di]
28FE  3C 03           cmp al, 3
2900  72 04           jb 0x2906
2902  3C 04           cmp al, 4
2904  76 04           jbe 0x290a
loc_2906:
2906  B0 00           mov al, 0
2908  EB 02           jmp 0x290c
loc_290A:
290A  B0 01           mov al, 1
loc_290C:
290C  98              cwde
290D  8B F8           mov di, ax
290F  8A 85 86 10     mov al, byte ptr [di + 0x1086]
2913  30 E4           xor ah, ah
2915  31 D2           xor dx, dx
2917  3B D3           cmp dx, bx
2919  7C 06           jl 0x2921
291B  7F 53           jg 0x2970
291D  3B C1           cmp ax, cx
291F  73 4F           jae 0x2970
loc_2921:
2921  C4 7E F6        les di, ptr [bp - 0xa]
2924  26 8A 05        mov al, byte ptr es:[di]
2927  3C 03           cmp al, 3
2929  72 04           jb 0x292f
292B  3C 04           cmp al, 4
292D  76 04           jbe 0x2933
loc_292F:
292F  B0 00           mov al, 0
2931  EB 02           jmp 0x2935
loc_2933:
2933  B0 01           mov al, 1
loc_2935:
2935  98              cwde
2936  8B F8           mov di, ax
2938  8A 85 86 10     mov al, byte ptr [di + 0x1086]
293C  30 E4           xor ah, ah
293E  31 D2           xor dx, dx
2940  A3 E8 D6        mov word ptr [0xd6e8], ax
2943  89 16 EA D6     mov word ptr [0xd6ea], dx
2947  68 F4 01        push 0x1f4
294A  9A 6D 07 2A 23  call far 232A:076D
294F  99              cdq
2950  52              push dx
2951  50              push ax
2952  A1 E8 D6        mov ax, word ptr [0xd6e8]
2955  8B 16 EA D6     mov dx, word ptr [0xd6ea]
2959  B9 E8 03        mov cx, 0x3e8
295C  31 DB           xor bx, bx
295E  9A 2A 0A C9 26  call far 26C9:0A2A
2963  59              pop cx
2964  5B              pop bx
2965  2B C1           sub ax, cx
2967  1B D3           sbb dx, bx
2969  A3 E8 D6        mov word ptr [0xd6e8], ax
296C  89 16 EA D6     mov word ptr [0xd6ea], dx
loc_2970:
2970  C7 46 FA 01 00  mov word ptr [bp - 6], 1
2975  EB 03           jmp 0x297a
loc_2977:
2977  FF 46 FA        inc word ptr [bp - 6]
loc_297A:
297A  8B 7E FA        mov di, word ptr [bp - 6]
297D  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
2981  30 E4           xor ah, ah
2983  3B 06 E6 D6     cmp ax, word ptr [0xd6e6]
2987  74 12           je 0x299b
2989  8B 7E FA        mov di, word ptr [bp - 6]
298C  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
2990  30 E4           xor ah, ah
2992  3B 06 E4 D6     cmp ax, word ptr [0xd6e4]
2996  74 03           je 0x299b
2998  E9 D6 00        jmp 0x2a71
loc_299B:
299B  6B 46 FA 5E     imul ax, word ptr [bp - 6], 0x5e
299F  C4 3E C4 DC     les di, ptr [0xdcc4]
29A3  03 F8           add di, ax
29A5  81 C7 A2 FF     add di, 0xffa2
29A9  89 7E F2        mov word ptr [bp - 0xe], di
29AC  8C 46 F4        mov word ptr [bp - 0xc], es
29AF  C4 3E D2 D7     les di, ptr [0xd7d2]
29B3  26 8A 05        mov al, byte ptr es:[di]
29B6  30 E4           xor ah, ah
29B8  C1 E0 02        shl ax, 2
29BB  8B D0           mov dx, ax
29BD  69 46 FA E8 00  imul ax, word ptr [bp - 6], 0xe8
29C2  C4 3E DC DC     les di, ptr [0xdcdc]
29C6  03 F8           add di, ax
29C8  03 FA           add di, dx
29CA  81 C7 14 FF     add di, 0xff14
29CE  89 7E EE        mov word ptr [bp - 0x12], di
29D1  8C 46 F0        mov word ptr [bp - 0x10], es
29D4  6B 06 E6 D6 3E  imul ax, word ptr [0xd6e6], 0x3e
29D9  C4 3E C2 D7     les di, ptr [0xd7c2]
29DD  03 F8           add di, ax
29DF  26 8A 45 F9     mov al, byte ptr es:[di - 7]
29E3  98              cwde
29E4  8B F8           mov di, ax
29E6  8A 85 74 10     mov al, byte ptr [di + 0x1074]
29EA  30 E4           xor ah, ah
29EC  31 D2           xor dx, dx
29EE  89 46 FC        mov word ptr [bp - 4], ax
29F1  89 56 FE        mov word ptr [bp - 2], dx
29F4  C4 7E F6        les di, ptr [bp - 0xa]
29F7  26 8A 05        mov al, byte ptr es:[di]
29FA  98              cwde
29FB  8B F8           mov di, ax
29FD  8A 85 7C 10     mov al, byte ptr [di + 0x107c]
2A01  98              cwde
2A02  99              cdq
2A03  01 46 FC        add word ptr [bp - 4], ax
2A06  11 56 FE        adc word ptr [bp - 2], dx
2A09  A1 E8 D6        mov ax, word ptr [0xd6e8]
2A0C  8B 16 EA D6     mov dx, word ptr [0xd6ea]
2A10  8B 4E FC        mov cx, word ptr [bp - 4]
2A13  8B 5E FE        mov bx, word ptr [bp - 2]
2A16  9A 2A 0A C9 26  call far 26C9:0A2A
2A1B  B9 02 00        mov cx, 2
2A1E  31 DB           xor bx, bx
2A20  9A 67 0A C9 26  call far 26C9:0A67
2A25  C4 7E F2        les di, ptr [bp - 0xe]
2A28  26 89 45 1A     mov word ptr es:[di + 0x1a], ax
2A2C  26 89 55 1C     mov word ptr es:[di + 0x1c], dx
2A30  8B 7E FA        mov di, word ptr [bp - 6]
2A33  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
2A37  C4 7E EE        les di, ptr [bp - 0x12]
2A3A  26 88 45 03     mov byte ptr es:[di + 3], al
2A3E  A1 E8 D6        mov ax, word ptr [0xd6e8]
2A41  8B 16 EA D6     mov dx, word ptr [0xd6ea]
2A45  B9 E8 03        mov cx, 0x3e8
2A48  31 DB           xor bx, bx
2A4A  9A 67 0A C9 26  call far 26C9:0A67
2A4F  C4 7E EE        les di, ptr [bp - 0x12]
2A52  26 88 05        mov byte ptr es:[di], al
2A55  A1 E8 D6        mov ax, word ptr [0xd6e8]
2A58  8B 16 EA D6     mov dx, word ptr [0xd6ea]
2A5C  B9 E8 03        mov cx, 0x3e8
2A5F  31 DB           xor bx, bx
2A61  9A 67 0A C9 26  call far 26C9:0A67
2A66  89 C8           mov ax, cx
2A68  89 DA           mov dx, bx
2A6A  C4 7E EE        les di, ptr [bp - 0x12]
2A6D  26 89 45 01     mov word ptr es:[di + 1], ax
loc_2A71:
2A71  83 7E FA 02     cmp word ptr [bp - 6], 2
2A75  74 03           je 0x2a7a
2A77  E9 FD FE        jmp 0x2977
loc_2A7A:
2A7A  C9              leave
2A7B  CB              retf

; ---- routine 1B55:2A7C  (found by: far)
sub_2A7C:
2A7C  C8 06 00 00     enter 6, 0
2A80  C7 46 FE 01 00  mov word ptr [bp - 2], 1
2A85  EB 03           jmp 0x2a8a
loc_2A87:
2A87  FF 46 FE        inc word ptr [bp - 2]
loc_2A8A:
2A8A  FF 76 FE        push word ptr [bp - 2]
2A8D  0E              push cs
2A8E  E8 E9 E3        call 0xe7a
2A91  08 C0           or al, al
2A93  75 31           jne 0x2ac6
2A95  6B 46 FE 3E     imul ax, word ptr [bp - 2], 0x3e
2A99  C4 3E C2 D7     les di, ptr [0xd7c2]
2A9D  03 F8           add di, ax
2A9F  81 C7 C2 FF     add di, 0xffc2
2AA3  26 80 7D 37 03  cmp byte ptr es:[di + 0x37], 3
2AA8  7D 1C           jge 0x2ac6
2AAA  26 8A 45 37     mov al, byte ptr es:[di + 0x37]
2AAE  98              cwde
2AAF  8B F8           mov di, ax
2AB1  8A 85 88 10     mov al, byte ptr [di + 0x1088]
2AB5  8B 7E FE        mov di, word ptr [bp - 2]
2AB8  3A 85 E5 D9     cmp al, byte ptr [di - 0x261b]
2ABC  76 08           jbe 0x2ac6
2ABE  8B 7E FE        mov di, word ptr [bp - 2]
2AC1  80 85 E5 D9 05  add byte ptr [di - 0x261b], 5
loc_2AC6:
2AC6  81 7E FE B0 00  cmp word ptr [bp - 2], 0xb0
2ACB  75 BA           jne 0x2a87
2ACD  C9              leave
2ACE  CB              retf

