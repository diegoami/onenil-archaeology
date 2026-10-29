; 1-095.EXE (One-Nil 95), code segment 06E4 (image offsets 06E40..0AB4F), part 3 of 6
; packed 1-095.EXE sha256 f659fb2d334500d6901fc8d6a0f06c85c0ccda2eb4a3035ae3bb0a0004d79192 (LZEXE 0.91)
; unpacked (tools/static/unlzexe.py) sha256 8df646e017e0965a5d90a58181ca764219ad847833aad0b6cb58fc53372bfb2c
; tool: capstone 5.0.9 (pip package; core library 5.0.1280) (CS_ARCH_X86, CS_MODE_16), recursive descent from the entry point, far calls and near calls/jumps, then routine prologues (55 89 E5 / 55 8B EC / C8 iw 00) in what remains; tools/static/listing.py
; addresses are SEGMENT:OFFSET with SEGMENT the image paragraph before relocation; image offset = SEGMENT*16+OFFSET
; ---- routine 06E4:16EF  (found by: call)
sub_16EF:
16EF  C8 04 00 00     enter 4, 0
16F3  8B 46 0C        mov ax, word ptr [bp + 0xc]
16F6  8B F0           mov si, ax
16F8  D1 E0           shl ax, 1
16FA  01 F0           add ax, si
16FC  8B D0           mov dx, ax
16FE  69 46 0E AE 00  imul ax, word ptr [bp + 0xe], 0xae
1703  C4 3E CA D7     les di, ptr [0xd7ca]
1707  03 F8           add di, ax
1709  03 FA           add di, dx
170B  81 C7 4F FF     add di, 0xff4f
170F  C4 7E 06        les di, ptr [bp + 6]
1712  26 FF 05        inc word ptr es:[di]
1715  FF 76 0E        push word ptr [bp + 0xe]
1718  FF 76 0C        push word ptr [bp + 0xc]
171B  26 FF 35        push word ptr es:[di]
171E  FF 76 04        push word ptr [bp + 4]
1721  9A DD 15 51 1B  call far 1B51:15DD
1726  83 7E 0A 00     cmp word ptr [bp + 0xa], 0
172A  74 16           je 0x1742
172C  FF 76 0E        push word ptr [bp + 0xe]
172F  FF 76 0C        push word ptr [bp + 0xc]
1732  FF 76 0A        push word ptr [bp + 0xa]
1735  C4 7E 06        les di, ptr [bp + 6]
1738  06              push es
1739  57              push di
173A  FF 76 04        push word ptr [bp + 4]
173D  9A 1B 18 51 1B  call far 1B51:181B
loc_1742:
1742  C9              leave
1743  C2 0C 00        ret 0xc

; ---- routine 06E4:1746  (found by: call)
sub_1746:
1746  C8 08 01 00     enter 0x108, 0
174A  31 C0           xor ax, ax
174C  89 46 FC        mov word ptr [bp - 4], ax
174F  8B 46 08        mov ax, word ptr [bp + 8]
1752  48              dec ax
1753  89 46 FA        mov word ptr [bp - 6], ax
1756  8B 46 06        mov ax, word ptr [bp + 6]
1759  2D 12 00        sub ax, 0x12
175C  89 46 F8        mov word ptr [bp - 8], ax
175F  C7 46 FE 01 00  mov word ptr [bp - 2], 1
1764  EB 03           jmp 0x1769
loc_1766:
1766  FF 46 FE        inc word ptr [bp - 2]
loc_1769:
1769  8B 46 0C        mov ax, word ptr [bp + 0xc]
176C  8B F0           mov si, ax
176E  D1 E0           shl ax, 1
1770  01 F0           add ax, si
1772  8B D0           mov dx, ax
1774  8B 7E FE        mov di, word ptr [bp - 2]
1777  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
177B  30 E4           xor ah, ah
177D  69 C0 AE 00     imul ax, ax, 0xae
1781  C4 3E CA D7     les di, ptr [0xd7ca]
1785  03 F8           add di, ax
1787  03 FA           add di, dx
1789  81 C7 4F FF     add di, 0xff4f
178D  89 7E F4        mov word ptr [bp - 0xc], di
1790  8C 46 F6        mov word ptr [bp - 0xa], es
1793  26 80 7D 01 00  cmp byte ptr es:[di + 1], 0
1798  75 03           jne 0x179d
179A  E9 97 00        jmp 0x1834
loc_179D:
179D  26 8A 05        mov al, byte ptr es:[di]
17A0  8B 7E 04        mov di, word ptr [bp + 4]
17A3  36 3A 45 08     cmp al, byte ptr ss:[di + 8]
17A7  74 03           je 0x17ac
17A9  E9 88 00        jmp 0x1834
loc_17AC:
17AC  C4 7E F4        les di, ptr [bp - 0xc]
17AF  26 8A 45 02     mov al, byte ptr es:[di + 2]
17B3  24 0F           and al, 0xf
17B5  08 C0           or al, al
17B7  74 7B           je 0x1834
17B9  FF 46 FC        inc word ptr [bp - 4]
17BC  8B 7E FE        mov di, word ptr [bp - 2]
17BF  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
17C3  30 E4           xor ah, ah
17C5  50              push ax
17C6  FF 76 0C        push word ptr [bp + 0xc]
17C9  FF 76 0A        push word ptr [bp + 0xa]
17CC  8D 7E 08        lea di, [bp + 8]
17CF  16              push ss
17D0  57              push di
17D1  FF 76 06        push word ptr [bp + 6]
17D4  E8 18 FF        call 0x16ef
17D7  C4 7E F4        les di, ptr [bp - 0xc]
17DA  26 8A 45 02     mov al, byte ptr es:[di + 2]
17DE  24 0F           and al, 0xf
17E0  3C 02           cmp al, 2
17E2  75 50           jne 0x1834
17E4  8B 46 0C        mov ax, word ptr [bp + 0xc]
17E7  8B F0           mov si, ax
17E9  D1 E0           shl ax, 1
17EB  01 F0           add ax, si
17ED  8B D0           mov dx, ax
17EF  26 8A 45 01     mov al, byte ptr es:[di + 1]
17F3  30 E4           xor ah, ah
17F5  69 C0 AE 00     imul ax, ax, 0xae
17F9  C4 3E CA D7     les di, ptr [0xd7ca]
17FD  03 F8           add di, ax
17FF  03 FA           add di, dx
1801  26 8A 85 51 FF  mov al, byte ptr es:[di - 0xaf]
1806  24 F0           and al, 0xf0
1808  30 E4           xor ah, ah
180A  05 00 00        add ax, 0
180D  8A C8           mov cl, al
180F  8B 46 0C        mov ax, word ptr [bp + 0xc]
1812  8B F0           mov si, ax
1814  D1 E0           shl ax, 1
1816  01 F0           add ax, si
1818  8B D0           mov dx, ax
181A  C4 7E F4        les di, ptr [bp - 0xc]
181D  26 8A 45 01     mov al, byte ptr es:[di + 1]
1821  30 E4           xor ah, ah
1823  69 C0 AE 00     imul ax, ax, 0xae
1827  C4 3E CA D7     les di, ptr [0xd7ca]
182B  03 F8           add di, ax
182D  03 FA           add di, dx
182F  26 88 8D 51 FF  mov byte ptr es:[di - 0xaf], cl
loc_1834:
1834  81 7E FE B0 00  cmp word ptr [bp - 2], 0xb0
1839  74 03           je 0x183e
183B  E9 28 FF        jmp 0x1766
loc_183E:
183E  FF 76 0C        push word ptr [bp + 0xc]
1841  E8 0C FE        call 0x1650
1844  83 7E FC 00     cmp word ptr [bp - 4], 0
1848  76 40           jbe 0x188a
184A  8B 7E 04        mov di, word ptr [bp + 4]
184D  36 80 7D 08 06  cmp byte ptr ss:[di + 8], 6
1852  75 0B           jne 0x185f
1854  8A 46 0C        mov al, byte ptr [bp + 0xc]
1857  3C 14           cmp al, 0x14
1859  74 04           je 0x185f
185B  3C 39           cmp al, 0x39
185D  75 2B           jne 0x188a
loc_185F:
185F  6A 07           push 7
1861  8D BE F8 FE     lea di, [bp - 0x108]
1865  16              push ss
1866  57              push di
1867  8B 7E 04        mov di, word ptr [bp + 4]
186A  36 8A 45 08     mov al, byte ptr ss:[di + 8]
186E  50              push ax
186F  8A 46 0C        mov al, byte ptr [bp + 0xc]
1872  50              push ax
1873  9A 11 12 51 1B  call far 1B51:1211
1878  8A 46 FA        mov al, byte ptr [bp - 6]
187B  50              push ax
187C  8A 46 F8        mov al, byte ptr [bp - 8]
187F  50              push ax
1880  BF 5C DD        mov di, 0xdd5c
1883  1E              push ds
1884  57              push di
1885  9A 1B 04 1A 23  call far 231A:041B
loc_188A:
188A  C9              leave
188B  C2 0A 00        ret 0xa

; ---- routine 06E4:188E  (found by: call)
sub_188E:
188E  C8 0A 00 00     enter 0xa, 0
1892  C4 3E D2 D7     les di, ptr [0xd7d2]
1896  89 7E F6        mov word ptr [bp - 0xa], di
1899  8C 46 F8        mov word ptr [bp - 8], es
189C  6A 00           push 0
189E  6A 01           push 1
18A0  6A 50           push 0x50
18A2  6A 01           push 1
18A4  6A 18           push 0x18
18A6  BF 5C DD        mov di, 0xdd5c
18A9  1E              push ds
18AA  57              push di
18AB  9A 07 05 1A 23  call far 231A:0507
18B0  8B 7E 04        mov di, word ptr [bp + 4]
18B3  36 80 7D 08 03  cmp byte ptr ss:[di + 8], 3
18B8  75 0D           jne 0x18c7
18BA  B8 3C 03        mov ax, 0x33c
18BD  8C DA           mov dx, ds
18BF  89 46 FA        mov word ptr [bp - 6], ax
18C2  89 56 FC        mov word ptr [bp - 4], dx
18C5  EB 0B           jmp 0x18d2
loc_18C7:
18C7  B8 42 03        mov ax, 0x342
18CA  8C DA           mov dx, ds
18CC  89 46 FA        mov word ptr [bp - 6], ax
18CF  89 56 FC        mov word ptr [bp - 4], dx
loc_18D2:
18D2  C7 46 FE 01 00  mov word ptr [bp - 2], 1
18D7  EB 03           jmp 0x18dc
loc_18D9:
18D9  FF 46 FE        inc word ptr [bp - 2]
loc_18DC:
18DC  83 7E FE 01     cmp word ptr [bp - 2], 1
18E0  74 15           je 0x18f7
18E2  8B 46 FE        mov ax, word ptr [bp - 2]
18E5  48              dec ax
18E6  C4 7E FA        les di, ptr [bp - 6]
18E9  03 F8           add di, ax
18EB  26 8A 45 FF     mov al, byte ptr es:[di - 1]
18EF  C4 7E F6        les di, ptr [bp - 0xa]
18F2  26 3A 05        cmp al, byte ptr es:[di]
18F5  77 2C           ja 0x1923
loc_18F7:
18F7  8B 46 FE        mov ax, word ptr [bp - 2]
18FA  C4 7E FA        les di, ptr [bp - 6]
18FD  03 F8           add di, ax
18FF  26 8A 45 FF     mov al, byte ptr es:[di - 1]
1903  30 E4           xor ah, ah
1905  50              push ax
1906  6A 00           push 0
1908  8B 7E FE        mov di, word ptr [bp - 2]
190B  8A 85 47 03     mov al, byte ptr [di + 0x347]
190F  30 E4           xor ah, ah
1911  50              push ax
1912  8B 7E FE        mov di, word ptr [bp - 2]
1915  8A 85 4D 03     mov al, byte ptr [di + 0x34d]
1919  30 E4           xor ah, ah
191B  50              push ax
191C  8B 7E 04        mov di, word ptr [bp + 4]
191F  57              push di
1920  E8 23 FE        call 0x1746
loc_1923:
1923  83 7E FE 05     cmp word ptr [bp - 2], 5
1927  75 B0           jne 0x18d9
1929  C9              leave
192A  C2 02 00        ret 2

; ---- routine 06E4:192D  (found by: call)
sub_192D:
192D  C8 04 00 00     enter 4, 0
1931  C4 3E D2 D7     les di, ptr [0xd7d2]
1935  89 7E FC        mov word ptr [bp - 4], di
1938  8C 46 FE        mov word ptr [bp - 2], es
193B  6A 00           push 0
193D  6A 01           push 1
193F  6A 50           push 0x50
1941  6A 01           push 1
1943  6A 18           push 0x18
1945  BF 5C DD        mov di, 0xdd5c
1948  1E              push ds
1949  57              push di
194A  9A 07 05 1A 23  call far 231A:0507
194F  C4 7E FC        les di, ptr [bp - 4]
1952  26 80 3D 0C     cmp byte ptr es:[di], 0xc
1956  72 17           jb 0x196f
1958  6A 14           push 0x14
195A  6A 16           push 0x16
195C  A0 48 03        mov al, byte ptr [0x348]
195F  30 E4           xor ah, ah
1961  50              push ax
1962  A0 4E 03        mov al, byte ptr [0x34e]
1965  30 E4           xor ah, ah
1967  50              push ax
1968  8B 7E 04        mov di, word ptr [bp + 4]
196B  57              push di
196C  E8 D7 FD        call 0x1746
loc_196F:
196F  C4 7E FC        les di, ptr [bp - 4]
1972  26 80 3D 16     cmp byte ptr es:[di], 0x16
1976  72 17           jb 0x198f
1978  6A 1B           push 0x1b
197A  6A 21           push 0x21
197C  A0 48 03        mov al, byte ptr [0x348]
197F  30 E4           xor ah, ah
1981  50              push ax
1982  A0 4F 03        mov al, byte ptr [0x34f]
1985  30 E4           xor ah, ah
1987  50              push ax
1988  8B 7E 04        mov di, word ptr [bp + 4]
198B  57              push di
198C  E8 B7 FD        call 0x1746
loc_198F:
198F  C4 7E FC        les di, ptr [bp - 4]
1992  26 80 3D 21     cmp byte ptr es:[di], 0x21
1996  72 17           jb 0x19af
1998  6A 27           push 0x27
199A  6A 2B           push 0x2b
199C  A0 4A 03        mov al, byte ptr [0x34a]
199F  30 E4           xor ah, ah
19A1  50              push ax
19A2  A0 4F 03        mov al, byte ptr [0x34f]
19A5  30 E4           xor ah, ah
19A7  50              push ax
19A8  8B 7E 04        mov di, word ptr [bp + 4]
19AB  57              push di
19AC  E8 97 FD        call 0x1746
loc_19AF:
19AF  C4 7E FC        les di, ptr [bp - 4]
19B2  26 80 3D 2B     cmp byte ptr es:[di], 0x2b
19B6  72 37           jb 0x19ef
19B8  8B 7E 04        mov di, word ptr [bp + 4]
19BB  36 80 7D 08 07  cmp byte ptr ss:[di + 8], 7
19C0  75 16           jne 0x19d8
19C2  6A 30           push 0x30
19C4  6A 00           push 0
19C6  A0 4B 03        mov al, byte ptr [0x34b]
19C9  30 E4           xor ah, ah
19CB  50              push ax
19CC  A0 4F 03        mov al, byte ptr [0x34f]
19CF  30 E4           xor ah, ah
19D1  50              push ax
19D2  57              push di
19D3  E8 70 FD        call 0x1746
19D6  EB 17           jmp 0x19ef
loc_19D8:
19D8  6A 30           push 0x30
19DA  6A 35           push 0x35
19DC  A0 4B 03        mov al, byte ptr [0x34b]
19DF  30 E4           xor ah, ah
19E1  50              push ax
19E2  A0 4F 03        mov al, byte ptr [0x34f]
19E5  30 E4           xor ah, ah
19E7  50              push ax
19E8  8B 7E 04        mov di, word ptr [bp + 4]
19EB  57              push di
19EC  E8 57 FD        call 0x1746
loc_19EF:
19EF  C9              leave
19F0  C2 02 00        ret 2

; ---- routine 06E4:19F3  (found by: call)
sub_19F3:
19F3  C8 0C 00 00     enter 0xc, 0
19F7  8B 7E 06        mov di, word ptr [bp + 6]
19FA  80 BD A5 DC 00  cmp byte ptr [di - 0x235b], 0
19FF  75 03           jne 0x1a04
1A01  E9 A2 00        jmp 0x1aa6
loc_1A04:
1A04  83 7E 06 01     cmp word ptr [bp + 6], 1
1A08  B0 00           mov al, 0
1A0A  75 01           jne 0x1a0d
1A0C  40              inc ax
loc_1A0D:
1A0D  98              cwde
1A0E  8B F8           mov di, ax
1A10  8A 85 54 03     mov al, byte ptr [di + 0x354]
1A14  30 E4           xor ah, ah
1A16  89 46 FA        mov word ptr [bp - 6], ax
1A19  C7 46 FE 01 00  mov word ptr [bp - 2], 1
1A1E  EB 03           jmp 0x1a23
loc_1A20:
1A20  FF 46 FE        inc word ptr [bp - 2]
loc_1A23:
1A23  8B 46 06        mov ax, word ptr [bp + 6]
1A26  05 03 00        add ax, 3
1A29  89 46 F8        mov word ptr [bp - 8], ax
1A2C  8B 46 06        mov ax, word ptr [bp + 6]
1A2F  3B 46 F8        cmp ax, word ptr [bp - 8]
1A32  77 69           ja 0x1a9d
1A34  89 46 FC        mov word ptr [bp - 4], ax
1A37  EB 03           jmp 0x1a3c
loc_1A39:
1A39  FF 46 FC        inc word ptr [bp - 4]
loc_1A3C:
1A3C  8B 7E FE        mov di, word ptr [bp - 2]
1A3F  8A 85 5B A2     mov al, byte ptr [di - 0x5da5]
1A43  30 E4           xor ah, ah
1A45  8B F0           mov si, ax
1A47  D1 E0           shl ax, 1
1A49  01 F0           add ax, si
1A4B  8B D0           mov dx, ax
1A4D  8B 7E FC        mov di, word ptr [bp - 4]
1A50  8A 85 A5 DC     mov al, byte ptr [di - 0x235b]
1A54  30 E4           xor ah, ah
1A56  69 C0 AE 00     imul ax, ax, 0xae
1A5A  C4 3E CA D7     les di, ptr [0xd7ca]
1A5E  03 F8           add di, ax
1A60  03 FA           add di, dx
1A62  81 C7 4F FF     add di, 0xff4f
1A66  26 8A 45 02     mov al, byte ptr es:[di + 2]
1A6A  24 0F           and al, 0xf
1A6C  3C 01           cmp al, 1
1A6E  75 25           jne 0x1a95
1A70  FF 46 FA        inc word ptr [bp - 6]
1A73  8B 7E FC        mov di, word ptr [bp - 4]
1A76  8A 85 A5 DC     mov al, byte ptr [di - 0x235b]
1A7A  30 E4           xor ah, ah
1A7C  50              push ax
1A7D  8B 7E FE        mov di, word ptr [bp - 2]
1A80  8A 85 5B A2     mov al, byte ptr [di - 0x5da5]
1A84  30 E4           xor ah, ah
1A86  50              push ax
1A87  FF 76 FA        push word ptr [bp - 6]
1A8A  A0 4F 03        mov al, byte ptr [0x34f]
1A8D  30 E4           xor ah, ah
1A8F  50              push ax
1A90  9A DD 15 51 1B  call far 1B51:15DD
loc_1A95:
1A95  8B 46 FC        mov ax, word ptr [bp - 4]
1A98  3B 46 F8        cmp ax, word ptr [bp - 8]
1A9B  75 9C           jne 0x1a39
loc_1A9D:
1A9D  83 7E FE 06     cmp word ptr [bp - 2], 6
1AA1  74 03           je 0x1aa6
1AA3  E9 7A FF        jmp 0x1a20
loc_1AA6:
1AA6  C9              leave
1AA7  C2 04 00        ret 4

; ---- routine 06E4:1AAA  (found by: call)
sub_1AAA:
1AAA  55              push bp
1AAB  89 E5           mov bp, sp
1AAD  6A 00           push 0
1AAF  6A 01           push 1
1AB1  6A 50           push 0x50
1AB3  6A 01           push 1
1AB5  6A 18           push 0x18
1AB7  BF 5C DD        mov di, 0xdd5c
1ABA  1E              push ds
1ABB  57              push di
1ABC  9A 07 05 1A 23  call far 231A:0507
1AC1  8B 7E 04        mov di, word ptr [bp + 4]
1AC4  36 80 7D 06 00  cmp byte ptr ss:[di + 6], 0
1AC9  75 22           jne 0x1aed
1ACB  C4 3E D2 D7     les di, ptr [0xd7d2]
1ACF  26 8A 05        mov al, byte ptr es:[di]
1AD2  30 E4           xor ah, ah
1AD4  50              push ax
1AD5  9A F8 16 51 1B  call far 1B51:16F8
1ADA  08 C0           or al, al
1ADC  74 0F           je 0x1aed
1ADE  BF A6 59        mov di, 0x59a6
1AE1  1E              push ds
1AE2  57              push di
1AE3  BF 5C DD        mov di, 0xdd5c
1AE6  1E              push ds
1AE7  57              push di
1AE8  9A 2F 05 1A 23  call far 231A:052F
loc_1AED:
1AED  6A 14           push 0x14
1AEF  6A 16           push 0x16
1AF1  A0 48 03        mov al, byte ptr [0x348]
1AF4  30 E4           xor ah, ah
1AF6  50              push ax
1AF7  A0 4E 03        mov al, byte ptr [0x34e]
1AFA  30 E4           xor ah, ah
1AFC  50              push ax
1AFD  8B 7E 04        mov di, word ptr [bp + 4]
1B00  57              push di
1B01  E8 42 FC        call 0x1746
1B04  6A 01           push 1
1B06  55              push bp
1B07  E8 E9 FE        call 0x19f3
1B0A  6A 05           push 5
1B0C  55              push bp
1B0D  E8 E3 FE        call 0x19f3
1B10  C4 3E D2 D7     les di, ptr [0xd7d2]
1B14  26 80 3D 35     cmp byte ptr es:[di], 0x35
1B18  72 13           jb 0x1b2d
1B1A  6A 39           push 0x39
1B1C  6A 00           push 0
1B1E  6A 17           push 0x17
1B20  A0 4E 03        mov al, byte ptr [0x34e]
1B23  30 E4           xor ah, ah
1B25  50              push ax
1B26  8B 7E 04        mov di, word ptr [bp + 4]
1B29  57              push di
1B2A  E8 19 FC        call 0x1746
loc_1B2D:
1B2D  C9              leave
1B2E  C2 02 00        ret 2

; ---- routine 06E4:1B31  (found by: call, far)
sub_1B31:
1B31  C8 02 00 00     enter 2, 0
loc_1B35:
1B35  C7 06 64 DD 07 00 mov word ptr [0xdd64], 7
1B3B  8A 46 08        mov al, byte ptr [bp + 8]
1B3E  3C 03           cmp al, 3
1B40  72 0A           jb 0x1b4c
1B42  3C 04           cmp al, 4
1B44  77 06           ja 0x1b4c
1B46  55              push bp
1B47  E8 44 FD        call 0x188e
1B4A  EB 10           jmp 0x1b5c
loc_1B4C:
1B4C  80 7E 08 06     cmp byte ptr [bp + 8], 6
1B50  75 06           jne 0x1b58
1B52  55              push bp
1B53  E8 54 FF        call 0x1aaa
1B56  EB 04           jmp 0x1b5c
loc_1B58:
1B58  55              push bp
1B59  E8 D1 FD        call 0x192d
loc_1B5C:
1B5C  80 3E D6 02 00  cmp byte ptr [0x2d6], 0
1B61  74 11           je 0x1b74
1B63  BF AE 4E        mov di, 0x4eae
1B66  1E              push ds
1B67  57              push di
1B68  BF 5C DD        mov di, 0xdd5c
1B6B  1E              push ds
1B6C  57              push di
1B6D  9A 2F 05 1A 23  call far 231A:052F
1B72  EB 15           jmp 0x1b89
loc_1B74:
1B74  80 7E 06 00     cmp byte ptr [bp + 6], 0
1B78  74 0F           je 0x1b89
1B7A  BF F4 4E        mov di, 0x4ef4
1B7D  1E              push ds
1B7E  57              push di
1B7F  BF 5C DD        mov di, 0xdd5c
1B82  1E              push ds
1B83  57              push di
1B84  9A 2F 05 1A 23  call far 231A:052F
loc_1B89:
1B89  C4 3E 5C DD     les di, ptr [0xdd5c]
1B8D  06              push es
1B8E  57              push di
1B8F  C4 3E 58 DD     les di, ptr [0xdd58]
1B93  06              push es
1B94  57              push di
1B95  68 A0 0F        push 0xfa0
1B98  9A 12 0A B9 26  call far 26B9:0A12
1B9D  80 7E 06 00     cmp byte ptr [bp + 6], 0
1BA1  75 02           jne 0x1ba5
1BA3  EB 0B           jmp 0x1bb0
loc_1BA5:
1BA5  0E              push cs
1BA6  E8 57 E4        call 0
1BA9  80 3E 88 DE 0D  cmp byte ptr [0xde88], 0xd
1BAE  74 85           je 0x1b35
loc_1BB0:
1BB0  C9              leave
1BB1  CA 04 00        retf 4

; ---- routine 06E4:1BB4  (found by: call)
sub_1BB4:
1BB4  C8 08 00 00     enter 8, 0
1BB8  C4 3E D2 D7     les di, ptr [0xd7d2]
1BBC  89 7E F8        mov word ptr [bp - 8], di
1BBF  8C 46 FA        mov word ptr [bp - 6], es
1BC2  C6 46 FF 00     mov byte ptr [bp - 1], 0
1BC6  C7 46 FC 01 00  mov word ptr [bp - 4], 1
1BCB  EB 03           jmp 0x1bd0
loc_1BCD:
1BCD  FF 46 FC        inc word ptr [bp - 4]
loc_1BD0:
1BD0  8B 46 FC        mov ax, word ptr [bp - 4]
1BD3  C4 7E F8        les di, ptr [bp - 8]
1BD6  03 F8           add di, ax
1BD8  26 80 7D 08 00  cmp byte ptr es:[di + 8], 0
1BDD  74 04           je 0x1be3
1BDF  C6 46 FF 01     mov byte ptr [bp - 1], 1
loc_1BE3:
1BE3  83 7E FC 06     cmp word ptr [bp - 4], 6
1BE7  75 E4           jne 0x1bcd
1BE9  8A 46 FF        mov al, byte ptr [bp - 1]
1BEC  C9              leave
1BED  C3              ret

; ---- routine 06E4:1BEE  (found by: call)
sub_1BEE:
1BEE  C8 04 00 00     enter 4, 0
1BF2  C6 46 FF 00     mov byte ptr [bp - 1], 0
1BF6  C7 46 FC 01 00  mov word ptr [bp - 4], 1
1BFB  EB 03           jmp 0x1c00
loc_1BFD:
1BFD  FF 46 FC        inc word ptr [bp - 4]
loc_1C00:
1C00  8B 46 FC        mov ax, word ptr [bp - 4]
1C03  8B 7E 04        mov di, word ptr [bp + 4]
1C06  03 F8           add di, ax
1C08  36 8A 45 F5     mov al, byte ptr ss:[di - 0xb]
1C0C  30 E4           xor ah, ah
1C0E  3B 46 06        cmp ax, word ptr [bp + 6]
1C11  75 04           jne 0x1c17
1C13  C6 46 FF 01     mov byte ptr [bp - 1], 1
loc_1C17:
1C17  83 7E FC 06     cmp word ptr [bp - 4], 6
1C1B  75 E0           jne 0x1bfd
1C1D  8A 46 FF        mov al, byte ptr [bp - 1]
1C20  C9              leave
1C21  C2 04 00        ret 4

; ---- routine 06E4:1C24  (found by: call)
sub_1C24:
1C24  C8 08 00 00     enter 8, 0
1C28  C4 3E D2 D7     les di, ptr [0xd7d2]
1C2C  89 7E F8        mov word ptr [bp - 8], di
1C2F  8C 46 FA        mov word ptr [bp - 6], es
1C32  C7 46 FC 10 00  mov word ptr [bp - 4], 0x10
1C37  C7 46 FE 01 00  mov word ptr [bp - 2], 1
1C3C  EB 03           jmp 0x1c41
loc_1C3E:
1C3E  FF 46 FE        inc word ptr [bp - 2]
loc_1C41:
1C41  8B 46 FE        mov ax, word ptr [bp - 2]
1C44  C4 7E F8        les di, ptr [bp - 8]
1C47  03 F8           add di, ax
1C49  26 80 7D 08 00  cmp byte ptr es:[di + 8], 0
1C4E  74 2C           je 0x1c7c
loc_1C50:
1C50  8B 7E FC        mov di, word ptr [bp - 4]
1C53  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
1C57  30 E4           xor ah, ah
1C59  50              push ax
1C5A  8B 7E 04        mov di, word ptr [bp + 4]
1C5D  57              push di
1C5E  E8 8D FF        call 0x1bee
1C61  08 C0           or al, al
1C63  74 05           je 0x1c6a
1C65  FF 4E FC        dec word ptr [bp - 4]
1C68  EB E6           jmp 0x1c50
loc_1C6A:
1C6A  8A 56 FC        mov dl, byte ptr [bp - 4]
1C6D  8B 46 FE        mov ax, word ptr [bp - 2]
1C70  C4 7E F8        les di, ptr [bp - 8]
1C73  03 F8           add di, ax
1C75  26 88 55 12     mov byte ptr es:[di + 0x12], dl
1C79  FF 4E FC        dec word ptr [bp - 4]
loc_1C7C:
1C7C  83 7E FE 06     cmp word ptr [bp - 2], 6
1C80  75 BC           jne 0x1c3e
1C82  C9              leave
1C83  C2 02 00        ret 2

; ---- routine 06E4:1C86  (found by: call)
sub_1C86:
1C86  C8 0E 00 00     enter 0xe, 0
1C8A  C4 3E D2 D7     les di, ptr [0xd7d2]
1C8E  89 7E F2        mov word ptr [bp - 0xe], di
1C91  8C 46 F4        mov word ptr [bp - 0xc], es
1C94  31 C0           xor ax, ax
1C96  89 46 FE        mov word ptr [bp - 2], ax
1C99  81 C7 13 00     add di, 0x13
1C9D  06              push es
1C9E  57              push di
1C9F  6A 06           push 6
1CA1  6A 00           push 0
1CA3  9A 22 02 AC 24  call far 24AC:0222
1CA8  C4 7E F2        les di, ptr [bp - 0xe]
1CAB  81 C7 09 00     add di, 9
1CAF  06              push es
1CB0  57              push di
1CB1  8D 7E F6        lea di, [bp - 0xa]
1CB4  16              push ss
1CB5  57              push di
1CB6  6A 06           push 6
1CB8  9A C2 01 AC 24  call far 24AC:01C2
1CBD  C7 46 FC 01 00  mov word ptr [bp - 4], 1
1CC2  EB 03           jmp 0x1cc7
loc_1CC4:
1CC4  FF 46 FC        inc word ptr [bp - 4]
loc_1CC7:
1CC7  8B 46 FC        mov ax, word ptr [bp - 4]
1CCA  C4 7E F2        les di, ptr [bp - 0xe]
1CCD  03 F8           add di, ax
1CCF  26 8A 45 08     mov al, byte ptr es:[di + 8]
1CD3  30 E4           xor ah, ah
1CD5  6B C0 3E        imul ax, ax, 0x3e
1CD8  C4 3E C2 D7     les di, ptr [0xd7c2]
1CDC  03 F8           add di, ax
1CDE  26 80 7D F9 00  cmp byte ptr es:[di - 7], 0
1CE3  75 0D           jne 0x1cf2
1CE5  8B 46 FC        mov ax, word ptr [bp - 4]
1CE8  C4 7E F2        les di, ptr [bp - 0xe]
1CEB  03 F8           add di, ax
1CED  26 C6 45 08 00  mov byte ptr es:[di + 8], 0
loc_1CF2:
1CF2  83 7E FC 06     cmp word ptr [bp - 4], 6
1CF6  75 CC           jne 0x1cc4
1CF8  C7 46 FC 01 00  mov word ptr [bp - 4], 1
1CFD  EB 03           jmp 0x1d02
loc_1CFF:
1CFF  FF 46 FC        inc word ptr [bp - 4]
loc_1D02:
1D02  8A 46 FC        mov al, byte ptr [bp - 4]
1D05  D0 E8           shr al, 1
1D07  73 33           jae 0x1d3c
1D09  8B 46 FC        mov ax, word ptr [bp - 4]
1D0C  C4 7E F2        les di, ptr [bp - 0xe]
1D0F  03 F8           add di, ax
1D11  26 80 7D 08 00  cmp byte ptr es:[di + 8], 0
1D16  75 24           jne 0x1d3c
1D18  8B 46 FC        mov ax, word ptr [bp - 4]
1D1B  C4 7E F2        les di, ptr [bp - 0xe]
1D1E  03 F8           add di, ax
1D20  81 C7 08 00     add di, 8
1D24  06              push es
1D25  57              push di
1D26  8B 46 FC        mov ax, word ptr [bp - 4]
1D29  40              inc ax
1D2A  C4 7E F2        les di, ptr [bp - 0xe]
1D2D  03 F8           add di, ax
1D2F  81 C7 08 00     add di, 8
1D33  06              push es
1D34  57              push di
1D35  6A 01           push 1
1D37  9A 03 02 AC 24  call far 24AC:0203
loc_1D3C:
1D3C  83 7E FC 05     cmp word ptr [bp - 4], 5
1D40  75 BD           jne 0x1cff
1D42  E8 6F FE        call 0x1bb4
1D45  08 C0           or al, al
1D47  74 04           je 0x1d4d
1D49  55              push bp
1D4A  E8 D7 FE        call 0x1c24
loc_1D4D:
1D4D  C9              leave
1D4E  C3              ret

; ---- routine 06E4:1D4F  (found by: call)
sub_1D4F:
1D4F  C8 02 00 00     enter 2, 0
1D53  C7 46 FE 01 00  mov word ptr [bp - 2], 1
1D58  EB 03           jmp 0x1d5d
loc_1D5A:
1D5A  FF 46 FE        inc word ptr [bp - 2]
loc_1D5D:
1D5D  8B 46 FE        mov ax, word ptr [bp - 2]
1D60  D1 E0           shl ax, 1
1D62  C4 7E 04        les di, ptr [bp + 4]
1D65  03 F8           add di, ax
1D67  26 83 7D FE 00  cmp word ptr es:[di - 2], 0
1D6C  74 1C           je 0x1d8a
1D6E  8B 46 FE        mov ax, word ptr [bp - 2]
1D71  D1 E0           shl ax, 1
1D73  C4 7E 04        les di, ptr [bp + 4]
1D76  03 F8           add di, ax
1D78  26 FF 75 FE     push word ptr es:[di - 2]
1D7C  FF 76 08        push word ptr [bp + 8]
1D7F  6A 00           push 0
1D81  6A 00           push 0
1D83  6A 00           push 0
1D85  9A 88 63 51 1B  call far 1B51:6388
loc_1D8A:
1D8A  83 7E FE 14     cmp word ptr [bp - 2], 0x14
1D8E  75 CA           jne 0x1d5a
1D90  C9              leave
1D91  C2 06 00        ret 6

; ---- routine 06E4:1D94  (found by: call)
sub_1D94:
1D94  C8 04 00 00     enter 4, 0
1D98  C4 7E 08        les di, ptr [bp + 8]
1D9B  89 7E FC        mov word ptr [bp - 4], di
1D9E  8C 46 FE        mov word ptr [bp - 2], es
1DA1  26 80 3D 00     cmp byte ptr es:[di], 0
1DA5  75 02           jne 0x1da9
1DA7  EB 56           jmp 0x1dff
loc_1DA9:
1DA9  6A 00           push 0
1DAB  FF 76 06        push word ptr [bp + 6]
1DAE  6A 3D           push 0x3d
1DB0  9A 43 0E 51 1B  call far 1B51:0E43
1DB5  C4 7E FC        les di, ptr [bp - 4]
1DB8  26 8A 45 01     mov al, byte ptr es:[di + 1]
1DBC  98              cwde
1DBD  8B F8           mov di, ax
1DBF  8A 85 3C A2     mov al, byte ptr [di - 0x5dc4]
1DC3  50              push ax
1DC4  C4 7E FC        les di, ptr [bp - 4]
1DC7  26 8A 05        mov al, byte ptr es:[di]
1DCA  30 E4           xor ah, ah
1DCC  C1 E0 04        shl ax, 4
1DCF  C4 3E B2 D7     les di, ptr [0xd7b2]
1DD3  03 F8           add di, ax
1DD5  81 C7 F0 FF     add di, 0xfff0
1DD9  06              push es
1DDA  57              push di
1DDB  8A 46 06        mov al, byte ptr [bp + 6]
1DDE  50              push ax
1DDF  6A 3D           push 0x3d
1DE1  BF 5C DD        mov di, 0xdd5c
1DE4  1E              push ds
1DE5  57              push di
1DE6  9A 1B 04 1A 23  call far 231A:041B
1DEB  C4 7E FC        les di, ptr [bp - 4]
1DEE  26 8A 45 02     mov al, byte ptr es:[di + 2]
1DF2  30 E4           xor ah, ah
1DF4  50              push ax
1DF5  FF 76 06        push word ptr [bp + 6]
1DF8  6A 38           push 0x38
1DFA  9A A2 14 51 1B  call far 1B51:14A2
loc_1DFF:
1DFF  C9              leave
1E00  C2 08 00        ret 8
; data (not reached as code), 2 bytes
1E03                  db 01 20   ; . 

; ---- routine 06E4:1E05  (found by: call)
sub_1E05:
1E05  C8 04 02 00     enter 0x204, 0
1E09  C4 7E 08        les di, ptr [bp + 8]
1E0C  89 7E FC        mov word ptr [bp - 4], di
1E0F  8C 46 FE        mov word ptr [bp - 2], es
1E12  26 83 7D 02 00  cmp word ptr es:[di + 2], 0
1E17  75 02           jne 0x1e1b
1E19  EB 79           jmp 0x1e94
loc_1E1B:
1E1B  C4 7E FC        les di, ptr [bp - 4]
1E1E  26 8A 45 05     mov al, byte ptr es:[di + 5]
1E22  30 E4           xor ah, ah
1E24  8B F8           mov di, ax
1E26  8A 85 08 87     mov al, byte ptr [di - 0x78f8]
1E2A  50              push ax
1E2B  8D BE FC FE     lea di, [bp - 0x104]
1E2F  16              push ss
1E30  57              push di
1E31  C4 7E FC        les di, ptr [bp - 4]
1E34  26 8A 45 04     mov al, byte ptr es:[di + 4]
1E38  50              push ax
1E39  9A 6F 0C B9 26  call far 26B9:0C6F
1E3E  BF 03 1E        mov di, 0x1e03
1E41  0E              push cs
1E42  57              push di
1E43  9A D2 0B B9 26  call far 26B9:0BD2
1E48  8D BE FC FD     lea di, [bp - 0x204]
1E4C  16              push ss
1E4D  57              push di
1E4E  C4 7E FC        les di, ptr [bp - 4]
1E51  26 FF 35        push word ptr es:[di]
1E54  9A 3C 44 51 1B  call far 1B51:443C
1E59  9A D2 0B B9 26  call far 26B9:0BD2
1E5E  8A 46 06        mov al, byte ptr [bp + 6]
1E61  50              push ax
1E62  6A 31           push 0x31
1E64  BF 5C DD        mov di, 0xdd5c
1E67  1E              push ds
1E68  57              push di
1E69  9A 1B 04 1A 23  call far 231A:041B
1E6E  8D BE FC FE     lea di, [bp - 0x104]
1E72  16              push ss
1E73  57              push di
1E74  C4 7E FC        les di, ptr [bp - 4]
1E77  26 8B 45 02     mov ax, word ptr es:[di + 2]
1E7B  31 D2           xor dx, dx
1E7D  52              push dx
1E7E  50              push ax
1E7F  9A C9 07 1A 23  call far 231A:07C9
1E84  8A 46 06        mov al, byte ptr [bp + 6]
1E87  50              push ax
1E88  6A 42           push 0x42
1E8A  BF 5C DD        mov di, 0xdd5c
1E8D  1E              push ds
1E8E  57              push di
1E8F  9A 83 02 1A 23  call far 231A:0283
loc_1E94:
1E94  C9              leave
1E95  C2 08 00        ret 8

; ---- routine 06E4:1E98  (found by: far)
sub_1E98:
1E98  C8 1A 01 00     enter 0x11a, 0
1E9C  6B 46 06 2E     imul ax, word ptr [bp + 6], 0x2e
1EA0  C4 3E C0 DC     les di, ptr [0xdcc0]
1EA4  03 F8           add di, ax
1EA6  81 C7 D2 FF     add di, 0xffd2
1EAA  89 7E E6        mov word ptr [bp - 0x1a], di
1EAD  8C 46 E8        mov word ptr [bp - 0x18], es
1EB0  BF DE 72        mov di, 0x72de
1EB3  1E              push ds
1EB4  57              push di
1EB5  BF 5C DD        mov di, 0xdd5c
1EB8  1E              push ds
1EB9  57              push di
1EBA  9A 2F 05 1A 23  call far 231A:052F
1EBF  BF 22 63        mov di, 0x6322
1EC2  1E              push ds
1EC3  57              push di
1EC4  BF 5C DD        mov di, 0xdd5c
1EC7  1E              push ds
1EC8  57              push di
1EC9  9A 2F 05 1A 23  call far 231A:052F
1ECE  C6 46 FF 00     mov byte ptr [bp - 1], 0
1ED2  EB 03           jmp 0x1ed7
loc_1ED4:
1ED4  FE 46 FF        inc byte ptr [bp - 1]
loc_1ED7:
1ED7  8A 46 FF        mov al, byte ptr [bp - 1]
1EDA  98              cwde
1EDB  8B F8           mov di, ax
1EDD  8A 85 3C A2     mov al, byte ptr [di - 0x5dc4]
1EE1  50              push ax
1EE2  8A 46 FF        mov al, byte ptr [bp - 1]
1EE5  98              cwde
1EE6  8B F8           mov di, ax
1EE8  C1 E7 04        shl di, 4
1EEB  81 C7 E6 DC     add di, 0xdce6
1EEF  1E              push ds
1EF0  57              push di
1EF1  8A 46 FF        mov al, byte ptr [bp - 1]
1EF4  30 E4           xor ah, ah
1EF6  05 04 00        add ax, 4
1EF9  50              push ax
1EFA  6A 1A           push 0x1a
1EFC  BF 5C DD        mov di, 0xdd5c
1EFF  1E              push ds
1F00  57              push di
1F01  9A 1B 04 1A 23  call far 231A:041B
1F06  8D BE E6 FE     lea di, [bp - 0x11a]
1F0A  16              push ss
1F0B  57              push di
1F0C  8A 46 FF        mov al, byte ptr [bp - 1]
1F0F  98              cwde
1F10  C4 7E E6        les di, ptr [bp - 0x1a]
1F13  03 F8           add di, ax
1F15  26 8A 05        mov al, byte ptr es:[di]
1F18  30 E4           xor ah, ah
1F1A  31 D2           xor dx, dx
1F1C  52              push dx
1F1D  50              push ax
1F1E  9A C9 07 1A 23  call far 231A:07C9
1F23  8A 46 FF        mov al, byte ptr [bp - 1]
1F26  30 E4           xor ah, ah
1F28  05 04 00        add ax, 4
1F2B  50              push ax
1F2C  6A 2E           push 0x2e
1F2E  BF 5C DD        mov di, 0xdd5c
1F31  1E              push ds
1F32  57              push di
1F33  9A 83 02 1A 23  call far 231A:0283
1F38  80 7E FF 04     cmp byte ptr [bp - 1], 4
1F3C  75 96           jne 0x1ed4
1F3E  FF 76 06        push word ptr [bp + 6]
1F41  6A 0E           push 0xe
1F43  6A 3F           push 0x3f
1F45  9A 43 0E 51 1B  call far 1B51:0E43
1F4A  C6 46 FE 00     mov byte ptr [bp - 2], 0
1F4E  EB 03           jmp 0x1f53
loc_1F50:
1F50  FE 46 FE        inc byte ptr [bp - 2]
loc_1F53:
1F53  8D BE E6 FE     lea di, [bp - 0x11a]
1F57  16              push ss
1F58  57              push di
1F59  8A 46 FE        mov al, byte ptr [bp - 2]
1F5C  98              cwde
1F5D  C4 7E E6        les di, ptr [bp - 0x1a]
1F60  03 F8           add di, ax
1F62  26 8A 45 05     mov al, byte ptr es:[di + 5]
1F66  30 E4           xor ah, ah
1F68  31 D2           xor dx, dx
1F6A  52              push dx
1F6B  50              push ax
1F6C  9A C9 07 1A 23  call far 231A:07C9
1F71  6A 03           push 3
1F73  8A 46 FE        mov al, byte ptr [bp - 2]
1F76  98              cwde
1F77  8B F8           mov di, ax
1F79  8A 85 56 03     mov al, byte ptr [di + 0x356]
1F7D  50              push ax
1F7E  BF 5C DD        mov di, 0xdd5c
1F81  1E              push ds
1F82  57              push di
1F83  9A 83 02 1A 23  call far 231A:0283
1F88  8D BE E6 FE     lea di, [bp - 0x11a]
1F8C  16              push ss
1F8D  57              push di
1F8E  8A 46 FE        mov al, byte ptr [bp - 2]
1F91  98              cwde
1F92  C4 7E E6        les di, ptr [bp - 0x1a]
1F95  03 F8           add di, ax
1F97  26 8A 45 07     mov al, byte ptr es:[di + 7]
1F9B  30 E4           xor ah, ah
1F9D  31 D2           xor dx, dx
1F9F  52              push dx
1FA0  50              push ax
1FA1  9A C9 07 1A 23  call far 231A:07C9
1FA6  6A 04           push 4
1FA8  8A 46 FE        mov al, byte ptr [bp - 2]
1FAB  98              cwde
1FAC  8B F8           mov di, ax
1FAE  8A 85 56 03     mov al, byte ptr [di + 0x356]
1FB2  50              push ax
1FB3  BF 5C DD        mov di, 0xdd5c
1FB6  1E              push ds
1FB7  57              push di
1FB8  9A 83 02 1A 23  call far 231A:0283
1FBD  80 7E FE 01     cmp byte ptr [bp - 2], 1
1FC1  75 8D           jne 0x1f50
1FC3  8D BE E6 FE     lea di, [bp - 0x11a]
1FC7  16              push ss
1FC8  57              push di
1FC9  C4 7E E6        les di, ptr [bp - 0x1a]
1FCC  26 8A 45 09     mov al, byte ptr es:[di + 9]
1FD0  30 E4           xor ah, ah
1FD2  31 D2           xor dx, dx
1FD4  52              push dx
1FD5  50              push ax
1FD6  9A C9 07 1A 23  call far 231A:07C9
1FDB  6A 0B           push 0xb
1FDD  6A 33           push 0x33
1FDF  BF 5C DD        mov di, 0xdd5c
1FE2  1E              push ds
1FE3  57              push di
1FE4  9A 83 02 1A 23  call far 231A:0283
1FE9  8D BE E6 FE     lea di, [bp - 0x11a]
1FED  16              push ss
1FEE  57              push di
1FEF  C4 7E E6        les di, ptr [bp - 0x1a]
1FF2  26 8B 45 0A     mov ax, word ptr es:[di + 0xa]
1FF6  31 D2           xor dx, dx
1FF8  52              push dx
1FF9  50              push ax
1FFA  9A C9 07 1A 23  call far 231A:07C9
1FFF  6A 0C           push 0xc
2001  6A 33           push 0x33
2003  BF 5C DD        mov di, 0xdd5c
2006  1E              push ds
2007  57              push di
2008  9A 83 02 1A 23  call far 231A:0283
200D  C6 46 FE 00     mov byte ptr [bp - 2], 0
2011  EB 03           jmp 0x2016
loc_2013:
2013  FE 46 FE        inc byte ptr [bp - 2]
loc_2016:
2016  8D BE E6 FE     lea di, [bp - 0x11a]
201A  16              push ss
201B  57              push di
201C  8A 46 FE        mov al, byte ptr [bp - 2]
201F  98              cwde
2020  C4 7E E6        les di, ptr [bp - 0x1a]
2023  03 F8           add di, ax
2025  26 8A 45 0C     mov al, byte ptr es:[di + 0xc]
2029  30 E4           xor ah, ah
202B  31 D2           xor dx, dx
202D  52              push dx
202E  50              push ax
202F  9A C9 07 1A 23  call far 231A:07C9
2034  6A 0D           push 0xd
2036  8A 46 FE        mov al, byte ptr [bp - 2]
2039  98              cwde
203A  8B F8           mov di, ax
203C  8A 85 58 03     mov al, byte ptr [di + 0x358]
2040  50              push ax
2041  BF 5C DD        mov di, 0xdd5c
2044  1E              push ds
2045  57              push di
2046  9A 83 02 1A 23  call far 231A:0283
204B  8D BE E6 FE     lea di, [bp - 0x11a]
204F  16              push ss
2050  57              push di
2051  8A 46 FE        mov al, byte ptr [bp - 2]
2054  98              cwde
2055  C4 7E E6        les di, ptr [bp - 0x1a]
2058  03 F8           add di, ax
205A  26 8A 45 0E     mov al, byte ptr es:[di + 0xe]
205E  30 E4           xor ah, ah
2060  31 D2           xor dx, dx
2062  52              push dx
2063  50              push ax
2064  9A C9 07 1A 23  call far 231A:07C9
2069  6A 0E           push 0xe
206B  8A 46 FE        mov al, byte ptr [bp - 2]
206E  98              cwde
206F  8B F8           mov di, ax
2071  8A 85 58 03     mov al, byte ptr [di + 0x358]
2075  50              push ax
2076  BF 5C DD        mov di, 0xdd5c
2079  1E              push ds
207A  57              push di
207B  9A 83 02 1A 23  call far 231A:0283
2080  8D BE E6 FE     lea di, [bp - 0x11a]
2084  16              push ss
2085  57              push di
2086  8A 46 FE        mov al, byte ptr [bp - 2]
2089  98              cwde
208A  C4 7E E6        les di, ptr [bp - 0x1a]
208D  03 F8           add di, ax
208F  26 8A 45 10     mov al, byte ptr es:[di + 0x10]
2093  30 E4           xor ah, ah
2095  31 D2           xor dx, dx
2097  52              push dx
2098  50              push ax
2099  9A C9 07 1A 23  call far 231A:07C9
209E  6A 0F           push 0xf
20A0  8A 46 FE        mov al, byte ptr [bp - 2]
20A3  98              cwde
20A4  8B F8           mov di, ax
20A6  8A 85 58 03     mov al, byte ptr [di + 0x358]
20AA  50              push ax
20AB  BF 5C DD        mov di, 0xdd5c
20AE  1E              push ds
20AF  57              push di
20B0  9A 83 02 1A 23  call far 231A:0283
20B5  8D BE E6 FE     lea di, [bp - 0x11a]
20B9  16              push ss
20BA  57              push di
20BB  8A 46 FE        mov al, byte ptr [bp - 2]
20BE  98              cwde
20BF  C4 7E E6        les di, ptr [bp - 0x1a]
20C2  03 F8           add di, ax
20C4  26 8A 45 12     mov al, byte ptr es:[di + 0x12]
20C8  30 E4           xor ah, ah
20CA  31 D2           xor dx, dx
20CC  52              push dx
20CD  50              push ax
20CE  9A C9 07 1A 23  call far 231A:07C9
20D3  6A 10           push 0x10
20D5  8A 46 FE        mov al, byte ptr [bp - 2]
20D8  98              cwde
20D9  8B F8           mov di, ax
20DB  8A 85 58 03     mov al, byte ptr [di + 0x358]
20DF  50              push ax
20E0  BF 5C DD        mov di, 0xdd5c
20E3  1E              push ds
20E4  57              push di
20E5  9A 83 02 1A 23  call far 231A:0283
20EA  80 7E FE 01     cmp byte ptr [bp - 2], 1
20EE  74 03           je 0x20f3
20F0  E9 20 FF        jmp 0x2013
loc_20F3:
20F3  C4 7E E6        les di, ptr [bp - 0x1a]
20F6  81 C7 14 00     add di, 0x14
20FA  06              push es
20FB  57              push di
20FC  6A 07           push 7
20FE  55              push bp
20FF  E8 92 FC        call 0x1d94
2102  C4 7E E6        les di, ptr [bp - 0x1a]
2105  81 C7 18 00     add di, 0x18
2109  06              push es
210A  57              push di
210B  6A 0A           push 0xa
210D  55              push bp
210E  E8 83 FC        call 0x1d94
2111  C4 7E E6        les di, ptr [bp - 0x1a]
2114  81 C7 1C 00     add di, 0x1c
2118  06              push es
2119  57              push di
211A  8D 7E F6        lea di, [bp - 0xa]
211D  16              push ss
211E  57              push di
211F  6A 06           push 6
2121  9A 12 0A B9 26  call far 26B9:0A12
2126  C4 7E E6        les di, ptr [bp - 0x1a]
2129  81 C7 22 00     add di, 0x22
212D  06              push es
212E  57              push di
212F  8D 7E F0        lea di, [bp - 0x10]
2132  16              push ss
2133  57              push di
2134  6A 06           push 6
2136  9A 12 0A B9 26  call far 26B9:0A12
213B  C4 7E E6        les di, ptr [bp - 0x1a]
213E  81 C7 28 00     add di, 0x28
2142  06              push es
2143  57              push di
2144  8D 7E EA        lea di, [bp - 0x16]
2147  16              push ss
2148  57              push di
2149  6A 06           push 6
214B  9A 12 0A B9 26  call far 26B9:0A12
2150  FF 76 06        push word ptr [bp + 6]
2153  6B 46 06 3E     imul ax, word ptr [bp + 6], 0x3e
2157  C4 3E C2 D7     les di, ptr [0xd7c2]
215B  03 F8           add di, ax
215D  81 C7 C2 FF     add di, 0xffc2
2161  06              push es
2162  57              push di
2163  E8 E9 FB        call 0x1d4f
2166  FF 76 06        push word ptr [bp + 6]
2169  9A DA 0D 51 1B  call far 1B51:0DDA
216E  08 C0           or al, al
2170  74 25           je 0x2197
2172  FF 76 06        push word ptr [bp + 6]
2175  A0 BA DC        mov al, byte ptr [0xdcba]
2178  30 E4           xor ah, ah
217A  3B 46 06        cmp ax, word ptr [bp + 6]
217D  B0 00           mov al, 0
217F  74 01           je 0x2182
2181  40              inc ax
loc_2182:
2182  30 E4           xor ah, ah
2184  40              inc ax
2185  6B C0 28        imul ax, ax, 0x28
2188  C4 3E D2 D7     les di, ptr [0xd7d2]
218C  03 F8           add di, ax
218E  81 C7 30 00     add di, 0x30
2192  06              push es
2193  57              push di
2194  E8 B8 FB        call 0x1d4f
loc_2197:
2197  C4 7E E6        les di, ptr [bp - 0x1a]
219A  81 C7 1C 00     add di, 0x1c
219E  06              push es
219F  57              push di
21A0  6A 13           push 0x13
21A2  55              push bp
21A3  E8 5F FC        call 0x1e05
21A6  C4 7E E6        les di, ptr [bp - 0x1a]
21A9  81 C7 22 00     add di, 0x22
21AD  06              push es
21AE  57              push di
21AF  6A 14           push 0x14
21B1  55              push bp
21B2  E8 50 FC        call 0x1e05
21B5  C4 7E E6        les di, ptr [bp - 0x1a]
21B8  81 C7 28 00     add di, 0x28
21BC  06              push es
21BD  57              push di
21BE  6A 15           push 0x15
21C0  55              push bp
21C1  E8 41 FC        call 0x1e05
21C4  8D 7E F6        lea di, [bp - 0xa]
21C7  16              push ss
21C8  57              push di
21C9  C4 7E E6        les di, ptr [bp - 0x1a]
21CC  81 C7 1C 00     add di, 0x1c
21D0  06              push es
21D1  57              push di
21D2  6A 06           push 6
21D4  9A 12 0A B9 26  call far 26B9:0A12
21D9  8D 7E F0        lea di, [bp - 0x10]
21DC  16              push ss
21DD  57              push di
21DE  C4 7E E6        les di, ptr [bp - 0x1a]
21E1  81 C7 22 00     add di, 0x22
21E5  06              push es
21E6  57              push di
21E7  6A 06           push 6
21E9  9A 12 0A B9 26  call far 26B9:0A12
21EE  8D 7E EA        lea di, [bp - 0x16]
21F1  16              push ss
21F2  57              push di
21F3  C4 7E E6        les di, ptr [bp - 0x1a]
21F6  81 C7 28 00     add di, 0x28
21FA  06              push es
21FB  57              push di
21FC  6A 06           push 6
21FE  9A 12 0A B9 26  call far 26B9:0A12
2203  C9              leave
2204  CA 02 00        retf 2

