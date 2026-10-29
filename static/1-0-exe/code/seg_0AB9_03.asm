; 1-0.EXE (One-Nil 96), code segment 0AB9 (image offsets 0AB90..1997F), part 3 of 22
; packed 1-0.EXE sha256 89ff9c5f238f24e81a0c2440a46cdd8997280a65fc3cc3d97cb974f55280a80a (LZEXE 0.91)
; unpacked (tools/static/unlzexe.py) sha256 887ed2a92767950e5309b2052409f875668605939b69e00737aa3047022b9f51
; tool: capstone 5.0.9 (pip package; core library 5.0.1280) (CS_ARCH_X86, CS_MODE_16), recursive descent from the entry point, far calls and near calls/jumps, then routine prologues (55 89 E5 / 55 8B EC / C8 iw 00) in what remains; tools/static/listing.py
; addresses are SEGMENT:OFFSET with SEGMENT the image paragraph before relocation; image offset = SEGMENT*16+OFFSET
; ---- routine 0AB9:164F  (found by: call)
sub_164F:
164F  C8 24 00 00     enter 0x24, 0
1653  C6 46 FF 00     mov byte ptr [bp - 1], 0
1657  EB 03           jmp 0x165c
loc_1659:
1659  FE 46 FF        inc byte ptr [bp - 1]
loc_165C:
165C  8A 46 FF        mov al, byte ptr [bp - 1]
165F  98              cwde
1660  8B F8           mov di, ax
1662  D1 E7           shl di, 1
1664  6B 85 E4 D6 3E  imul ax, word ptr [di - 0x291c], 0x3e
1669  C4 3E C2 D7     les di, ptr [0xd7c2]
166D  03 F8           add di, ax
166F  81 C7 C2 FF     add di, 0xffc2
1673  89 7E E4        mov word ptr [bp - 0x1c], di
1676  8C 46 E6        mov word ptr [bp - 0x1a], es
1679  31 C0           xor ax, ax
167B  89 46 E8        mov word ptr [bp - 0x18], ax
167E  89 46 EA        mov word ptr [bp - 0x16], ax
1681  C7 46 FC 01 00  mov word ptr [bp - 4], 1
1686  EB 03           jmp 0x168b
loc_1688:
1688  FF 46 FC        inc word ptr [bp - 4]
loc_168B:
168B  8B 46 FC        mov ax, word ptr [bp - 4]
168E  D1 E0           shl ax, 1
1690  C4 7E E4        les di, ptr [bp - 0x1c]
1693  03 F8           add di, ax
1695  26 8B 45 FE     mov ax, word ptr es:[di - 2]
1699  C1 E0 03        shl ax, 3
169C  C4 3E BA D7     les di, ptr [0xd7ba]
16A0  03 F8           add di, ax
16A2  89 7E E0        mov word ptr [bp - 0x20], di
16A5  8C 46 E2        mov word ptr [bp - 0x1e], es
16A8  8B 46 FC        mov ax, word ptr [bp - 4]
16AB  D1 E0           shl ax, 1
16AD  C4 7E E4        les di, ptr [bp - 0x1c]
16B0  03 F8           add di, ax
16B2  26 FF 75 FE     push word ptr es:[di - 2]
16B6  9A 89 4F 55 1B  call far 1B55:4F89
16BB  08 C0           or al, al
16BD  75 11           jne 0x16d0
16BF  C4 7E E0        les di, ptr [bp - 0x20]
16C2  26 8A 45 04     mov al, byte ptr es:[di + 4]
16C6  30 E4           xor ah, ah
16C8  31 D2           xor dx, dx
16CA  01 46 E8        add word ptr [bp - 0x18], ax
16CD  11 56 EA        adc word ptr [bp - 0x16], dx
loc_16D0:
16D0  83 7E FC 0B     cmp word ptr [bp - 4], 0xb
16D4  75 B2           jne 0x1688
16D6  8B 46 E8        mov ax, word ptr [bp - 0x18]
16D9  8B 56 EA        mov dx, word ptr [bp - 0x16]
16DC  B9 16 00        mov cx, 0x16
16DF  31 DB           xor bx, bx
16E1  9A 67 0A C9 26  call far 26C9:0A67
16E6  05 01 00        add ax, 1
16E9  83 D2 00        adc dx, 0
16EC  8B D0           mov dx, ax
16EE  80 7E FF 00     cmp byte ptr [bp - 1], 0
16F2  B0 00           mov al, 0
16F4  75 01           jne 0x16f7
16F6  40              inc ax
loc_16F7:
16F7  98              cwde
16F8  8B F8           mov di, ax
16FA  D1 E7           shl di, 1
16FC  89 95 2A D1     mov word ptr [di - 0x2ed6], dx
1700  C7 46 FC 01 00  mov word ptr [bp - 4], 1
1705  EB 03           jmp 0x170a
loc_1707:
1707  FF 46 FC        inc word ptr [bp - 4]
loc_170A:
170A  8B 46 FC        mov ax, word ptr [bp - 4]
170D  D1 E0           shl ax, 1
170F  C4 7E E4        les di, ptr [bp - 0x1c]
1712  03 F8           add di, ax
1714  26 8B 45 FE     mov ax, word ptr es:[di - 2]
1718  C1 E0 03        shl ax, 3
171B  C4 3E BA D7     les di, ptr [0xd7ba]
171F  03 F8           add di, ax
1721  89 7E E0        mov word ptr [bp - 0x20], di
1724  8C 46 E2        mov word ptr [bp - 0x1e], es
1727  8B 46 FC        mov ax, word ptr [bp - 4]
172A  D1 E0           shl ax, 1
172C  C4 7E E4        les di, ptr [bp - 0x1c]
172F  03 F8           add di, ax
1731  26 6B 45 FE 0F  imul ax, word ptr es:[di - 2], 0xf
1736  C4 3E BE D7     les di, ptr [0xd7be]
173A  03 F8           add di, ax
173C  8B 46 FC        mov ax, word ptr [bp - 4]
173F  D1 E0           shl ax, 1
1741  C4 7E E4        les di, ptr [bp - 0x1c]
1744  03 F8           add di, ax
1746  26 FF 75 FE     push word ptr es:[di - 2]
174A  9A 89 4F 55 1B  call far 1B55:4F89
174F  08 C0           or al, al
1751  74 09           je 0x175c
1753  8B 7E FC        mov di, word ptr [bp - 4]
1756  C6 43 EB 0E     mov byte ptr [bp + di - 0x15], 0xe
175A  EB 0D           jmp 0x1769
loc_175C:
175C  C4 7E E0        les di, ptr [bp - 0x20]
175F  26 8A 45 06     mov al, byte ptr es:[di + 6]
1763  8B 7E FC        mov di, word ptr [bp - 4]
1766  88 43 EB        mov byte ptr [bp + di - 0x15], al
loc_1769:
1769  83 7E FC 0B     cmp word ptr [bp - 4], 0xb
176D  75 98           jne 0x1707
176F  C7 46 FA 01 00  mov word ptr [bp - 6], 1
1774  EB 03           jmp 0x1779
loc_1776:
1776  FF 46 FA        inc word ptr [bp - 6]
loc_1779:
1779  8B 46 FA        mov ax, word ptr [bp - 6]
177C  40              inc ax
177D  3D 0B 00        cmp ax, 0xb
1780  76 03           jbe 0x1785
1782  E9 A9 01        jmp 0x192e
loc_1785:
1785  89 46 FC        mov word ptr [bp - 4], ax
1788  EB 03           jmp 0x178d
loc_178A:
178A  FF 46 FC        inc word ptr [bp - 4]
loc_178D:
178D  8B 7E FC        mov di, word ptr [bp - 4]
1790  8A 43 EB        mov al, byte ptr [bp + di - 0x15]
1793  8B 7E FA        mov di, word ptr [bp - 6]
1796  3A 43 EB        cmp al, byte ptr [bp + di - 0x15]
1799  72 03           jb 0x179e
179B  E9 87 01        jmp 0x1925
loc_179E:
179E  8B 46 FC        mov ax, word ptr [bp - 4]
17A1  D1 E0           shl ax, 1
17A3  C4 7E E4        les di, ptr [bp - 0x1c]
17A6  03 F8           add di, ax
17A8  81 C7 FE FF     add di, 0xfffe
17AC  06              push es
17AD  57              push di
17AE  8B 46 FA        mov ax, word ptr [bp - 6]
17B1  D1 E0           shl ax, 1
17B3  C4 7E E4        les di, ptr [bp - 0x1c]
17B6  03 F8           add di, ax
17B8  81 C7 FE FF     add di, 0xfffe
17BC  06              push es
17BD  57              push di
17BE  6A 02           push 2
17C0  9A 03 02 BC 24  call far 24BC:0203
17C5  8B 7E FC        mov di, word ptr [bp - 4]
17C8  8D 7B EB        lea di, [bp + di - 0x15]
17CB  16              push ss
17CC  57              push di
17CD  8B 7E FA        mov di, word ptr [bp - 6]
17D0  8D 7B EB        lea di, [bp + di - 0x15]
17D3  16              push ss
17D4  57              push di
17D5  6A 01           push 1
17D7  9A 03 02 BC 24  call far 24BC:0203
17DC  8A 46 FF        mov al, byte ptr [bp - 1]
17DF  98              cwde
17E0  8B F8           mov di, ax
17E2  8A 85 56 0D     mov al, byte ptr [di + 0xd56]
17E6  30 E4           xor ah, ah
17E8  03 46 FC        add ax, word ptr [bp - 4]
17EB  6B F8 19        imul di, ax, 0x19
17EE  81 C7 EF CC     add di, 0xccef
17F2  1E              push ds
17F3  57              push di
17F4  8A 46 FF        mov al, byte ptr [bp - 1]
17F7  98              cwde
17F8  8B F8           mov di, ax
17FA  8A 85 56 0D     mov al, byte ptr [di + 0xd56]
17FE  30 E4           xor ah, ah
1800  03 46 FA        add ax, word ptr [bp - 6]
1803  6B F8 19        imul di, ax, 0x19
1806  81 C7 EF CC     add di, 0xccef
180A  1E              push ds
180B  57              push di
180C  6A 19           push 0x19
180E  9A 03 02 BC 24  call far 24BC:0203
1813  8B 46 FC        mov ax, word ptr [bp - 4]
1816  D1 E0           shl ax, 1
1818  8B D0           mov dx, ax
181A  8A 46 FF        mov al, byte ptr [bp - 1]
181D  98              cwde
181E  6B F8 28        imul di, ax, 0x28
1821  03 FA           add di, dx
1823  81 C7 46 D1     add di, 0xd146
1827  1E              push ds
1828  57              push di
1829  8B 46 FA        mov ax, word ptr [bp - 6]
182C  D1 E0           shl ax, 1
182E  8B D0           mov dx, ax
1830  8A 46 FF        mov al, byte ptr [bp - 1]
1833  98              cwde
1834  6B F8 28        imul di, ax, 0x28
1837  03 FA           add di, dx
1839  81 C7 46 D1     add di, 0xd146
183D  1E              push ds
183E  57              push di
183F  6A 02           push 2
1841  9A 03 02 BC 24  call far 24BC:0203
1846  8B 56 FC        mov dx, word ptr [bp - 4]
1849  8A 46 FF        mov al, byte ptr [bp - 1]
184C  98              cwde
184D  6B F8 14        imul di, ax, 0x14
1850  03 FA           add di, dx
1852  81 C7 97 D1     add di, 0xd197
1856  1E              push ds
1857  57              push di
1858  8B 56 FA        mov dx, word ptr [bp - 6]
185B  8A 46 FF        mov al, byte ptr [bp - 1]
185E  98              cwde
185F  6B F8 14        imul di, ax, 0x14
1862  03 FA           add di, dx
1864  81 C7 97 D1     add di, 0xd197
1868  1E              push ds
1869  57              push di
186A  6A 01           push 1
186C  9A 03 02 BC 24  call far 24BC:0203
1871  8A 46 FF        mov al, byte ptr [bp - 1]
1874  98              cwde
1875  8B F8           mov di, ax
1877  8A 85 56 0D     mov al, byte ptr [di + 0xd56]
187B  30 E4           xor ah, ah
187D  03 46 FC        add ax, word ptr [bp - 4]
1880  8B D0           mov dx, ax
1882  A0 9F D0        mov al, byte ptr [0xd09f]
1885  30 E4           xor ah, ah
1887  3B C2           cmp ax, dx
1889  75 14           jne 0x189f
188B  8A 46 FF        mov al, byte ptr [bp - 1]
188E  98              cwde
188F  8B F8           mov di, ax
1891  8A 85 56 0D     mov al, byte ptr [di + 0xd56]
1895  30 E4           xor ah, ah
1897  03 46 FA        add ax, word ptr [bp - 6]
189A  A2 9F D0        mov byte ptr [0xd09f], al
189D  EB 2C           jmp 0x18cb
loc_189F:
189F  8A 46 FF        mov al, byte ptr [bp - 1]
18A2  98              cwde
18A3  8B F8           mov di, ax
18A5  8A 85 56 0D     mov al, byte ptr [di + 0xd56]
18A9  30 E4           xor ah, ah
18AB  03 46 FA        add ax, word ptr [bp - 6]
18AE  8B D0           mov dx, ax
18B0  A0 9F D0        mov al, byte ptr [0xd09f]
18B3  30 E4           xor ah, ah
18B5  3B C2           cmp ax, dx
18B7  75 12           jne 0x18cb
18B9  8A 46 FF        mov al, byte ptr [bp - 1]
18BC  98              cwde
18BD  8B F8           mov di, ax
18BF  8A 85 56 0D     mov al, byte ptr [di + 0xd56]
18C3  30 E4           xor ah, ah
18C5  03 46 FC        add ax, word ptr [bp - 4]
18C8  A2 9F D0        mov byte ptr [0xd09f], al
loc_18CB:
18CB  8A 46 FF        mov al, byte ptr [bp - 1]
18CE  98              cwde
18CF  8B F8           mov di, ax
18D1  8A 85 56 0D     mov al, byte ptr [di + 0xd56]
18D5  30 E4           xor ah, ah
18D7  03 46 FC        add ax, word ptr [bp - 4]
18DA  8B D0           mov dx, ax
18DC  A0 A0 D0        mov al, byte ptr [0xd0a0]
18DF  30 E4           xor ah, ah
18E1  3B C2           cmp ax, dx
18E3  75 14           jne 0x18f9
18E5  8A 46 FF        mov al, byte ptr [bp - 1]
18E8  98              cwde
18E9  8B F8           mov di, ax
18EB  8A 85 56 0D     mov al, byte ptr [di + 0xd56]
18EF  30 E4           xor ah, ah
18F1  03 46 FA        add ax, word ptr [bp - 6]
18F4  A2 A0 D0        mov byte ptr [0xd0a0], al
18F7  EB 2C           jmp 0x1925
loc_18F9:
18F9  8A 46 FF        mov al, byte ptr [bp - 1]
18FC  98              cwde
18FD  8B F8           mov di, ax
18FF  8A 85 56 0D     mov al, byte ptr [di + 0xd56]
1903  30 E4           xor ah, ah
1905  03 46 FA        add ax, word ptr [bp - 6]
1908  8B D0           mov dx, ax
190A  A0 A0 D0        mov al, byte ptr [0xd0a0]
190D  30 E4           xor ah, ah
190F  3B C2           cmp ax, dx
1911  75 12           jne 0x1925
1913  8A 46 FF        mov al, byte ptr [bp - 1]
1916  98              cwde
1917  8B F8           mov di, ax
1919  8A 85 56 0D     mov al, byte ptr [di + 0xd56]
191D  30 E4           xor ah, ah
191F  03 46 FC        add ax, word ptr [bp - 4]
1922  A2 A0 D0        mov byte ptr [0xd0a0], al
loc_1925:
1925  83 7E FC 0B     cmp word ptr [bp - 4], 0xb
1929  74 03           je 0x192e
192B  E9 5C FE        jmp 0x178a
loc_192E:
192E  83 7E FA 0A     cmp word ptr [bp - 6], 0xa
1932  74 03           je 0x1937
1934  E9 3F FE        jmp 0x1776
loc_1937:
1937  8A 46 FF        mov al, byte ptr [bp - 1]
193A  98              cwde
193B  8B F8           mov di, ax
193D  8A 85 56 0D     mov al, byte ptr [di + 0xd56]
1941  30 E4           xor ah, ah
1943  05 0B 00        add ax, 0xb
1946  89 46 E2        mov word ptr [bp - 0x1e], ax
1949  8A 46 FF        mov al, byte ptr [bp - 1]
194C  98              cwde
194D  8B F8           mov di, ax
194F  8A 85 56 0D     mov al, byte ptr [di + 0xd56]
1953  30 E4           xor ah, ah
1955  40              inc ax
1956  3B 46 E2        cmp ax, word ptr [bp - 0x1e]
1959  77 21           ja 0x197c
195B  89 46 FC        mov word ptr [bp - 4], ax
195E  EB 03           jmp 0x1963
loc_1960:
1960  FF 46 FC        inc word ptr [bp - 4]
loc_1963:
1963  FF 76 FC        push word ptr [bp - 4]
1966  6B 7E FC 19     imul di, word ptr [bp - 4], 0x19
196A  81 C7 EF CC     add di, 0xccef
196E  1E              push ds
196F  57              push di
1970  0E              push cs
1971  E8 25 6C        call 0x8599
1974  8B 46 FC        mov ax, word ptr [bp - 4]
1977  3B 46 E2        cmp ax, word ptr [bp - 0x1e]
197A  75 E4           jne 0x1960
loc_197C:
197C  80 7E FF 01     cmp byte ptr [bp - 1], 1
1980  74 03           je 0x1985
1982  E9 D4 FC        jmp 0x1659
loc_1985:
1985  E8 31 F7        call 0x10b9
1988  E8 30 EA        call 0x3bb
198B  E8 AB FB        call 0x1539
198E  E8 C4 17        call 0x3155
1991  E8 43 08        call 0x21d7
1994  31 C0           xor ax, ax
1996  A3 14 CD        mov word ptr [0xcd14], ax
1999  31 C0           xor ax, ax
199B  A3 27 CE        mov word ptr [0xce27], ax
199E  C9              leave
199F  C3              ret

; ---- routine 0AB9:19A0  (found by: call)
sub_19A0:
19A0  C8 02 00 00     enter 2, 0
19A4  8B 3E 72 D0     mov di, word ptr [0xd072]
19A8  8A 85 71 CF     mov al, byte ptr [di - 0x308f]
19AC  30 E4           xor ah, ah
19AE  89 46 FE        mov word ptr [bp - 2], ax
19B1  81 3E 72 D0 FF 00 cmp word ptr [0xd072], 0xff
19B7  75 08           jne 0x19c1
19B9  C7 06 72 D0 01 00 mov word ptr [0xd072], 1
19BF  EB 04           jmp 0x19c5
loc_19C1:
19C1  FF 06 72 D0     inc word ptr [0xd072]
loc_19C5:
19C5  8B 46 FE        mov ax, word ptr [bp - 2]
19C8  C9              leave
19C9  C3              ret

; ---- routine 0AB9:19CA  (found by: call)
sub_19CA:
19CA  C8 08 00 00     enter 8, 0
19CE  C7 46 FC 3A 00  mov word ptr [bp - 4], 0x3a
19D3  C4 3E D2 D7     les di, ptr [0xd7d2]
19D7  26 8A 05        mov al, byte ptr es:[di]
19DA  30 E4           xor ah, ah
19DC  8B C8           mov cx, ax
19DE  26 8A 45 01     mov al, byte ptr es:[di + 1]
19E2  30 E4           xor ah, ah
19E4  F7 66 FC        mul word ptr [bp - 4]
19E7  03 C1           add ax, cx
19E9  C4 3E 84 DE     les di, ptr [0xde84]
19ED  26 89 05        mov word ptr es:[di], ax
19F0  C7 46 FE 01 00  mov word ptr [bp - 2], 1
19F5  EB 03           jmp 0x19fa
loc_19F7:
19F7  FF 46 FE        inc word ptr [bp - 2]
loc_19FA:
19FA  6A 10           push 0x10
19FC  9A 6D 07 2A 23  call far 232A:076D
1A01  48              dec ax
1A02  8B 7E FE        mov di, word ptr [bp - 2]
1A05  88 85 71 CF     mov byte ptr [di - 0x308f], al
1A09  81 7E FE FF 00  cmp word ptr [bp - 2], 0xff
1A0E  75 E7           jne 0x19f7
1A10  A1 E6 D6        mov ax, word ptr [0xd6e6]
1A13  A3 72 D0        mov word ptr [0xd072], ax
1A16  C9              leave
1A17  C3              ret

; ---- routine 0AB9:1A18  (found by: call)
sub_1A18:
1A18  55              push bp
1A19  89 E5           mov bp, sp
1A1B  80 7E 04 00     cmp byte ptr [bp + 4], 0
1A1F  74 08           je 0x1a29
1A21  C7 06 5A CF AF 0E mov word ptr [0xcf5a], 0xeaf
1A27  EB 06           jmp 0x1a2f
loc_1A29:
1A29  C7 06 5A CF AE 0E mov word ptr [0xcf5a], 0xeae
loc_1A2F:
1A2F  C6 06 BC D0 01  mov byte ptr [0xd0bc], 1
1A34  C9              leave
1A35  C2 02 00        ret 2

; ---- routine 0AB9:1A38  (found by: call)
sub_1A38:
1A38  55              push bp
1A39  89 E5           mov bp, sp
1A3B  BF 56 CF        mov di, 0xcf56
1A3E  1E              push ds
1A3F  57              push di
1A40  9A 3F 09 98 19  call far 1998:093F
1A45  C6 06 BC D0 00  mov byte ptr [0xd0bc], 0
1A4A  C9              leave
1A4B  C3              ret

; ---- routine 0AB9:1A4C  (found by: call)
sub_1A4C:
1A4C  C8 02 00 00     enter 2, 0
1A50  83 7E 0A 04     cmp word ptr [bp + 0xa], 4
1A54  75 0D           jne 0x1a63
1A56  80 3E DD D6 00  cmp byte ptr [0xd6dd], 0
1A5B  75 06           jne 0x1a63
1A5D  C6 46 FF 00     mov byte ptr [bp - 1], 0
1A61  EB 78           jmp 0x1adb
loc_1A63:
1A63  83 7E 0A 05     cmp word ptr [bp + 0xa], 5
1A67  73 47           jae 0x1ab0
1A69  8B 46 0A        mov ax, word ptr [bp + 0xa]
1A6C  05 04 00        add ax, 4
1A6F  50              push ax
1A70  C4 7E 06        les di, ptr [bp + 6]
1A73  26 6B 45 0E 0F  imul ax, word ptr es:[di + 0xe], 0xf
1A78  C4 3E BE D7     les di, ptr [0xd7be]
1A7C  03 F8           add di, ax
1A7E  26 8A 45 0A     mov al, byte ptr es:[di + 0xa]
1A82  30 E4           xor ah, ah
1A84  50              push ax
1A85  9A 59 02 BC 24  call far 24BC:0259
1A8A  08 C0           or al, al
1A8C  74 22           je 0x1ab0
1A8E  FF 76 0A        push word ptr [bp + 0xa]
1A91  C4 7E 06        les di, ptr [bp + 6]
1A94  26 6B 45 0E 0F  imul ax, word ptr es:[di + 0xe], 0xf
1A99  C4 3E BE D7     les di, ptr [0xd7be]
1A9D  03 F8           add di, ax
1A9F  26 8A 45 0A     mov al, byte ptr es:[di + 0xa]
1AA3  30 E4           xor ah, ah
1AA5  50              push ax
1AA6  9A 59 02 BC 24  call far 24BC:0259
1AAB  88 46 FF        mov byte ptr [bp - 1], al
1AAE  EB 2B           jmp 0x1adb
loc_1AB0:
1AB0  FF 76 0A        push word ptr [bp + 0xa]
1AB3  C4 7E 06        les di, ptr [bp + 6]
1AB6  06              push es
1AB7  57              push di
1AB8  0E              push cs
1AB9  E8 FF 01        call 0x1cbb
1ABC  98              cwde
1ABD  8B F8           mov di, ax
1ABF  D1 E7           shl di, 1
1AC1  6B 85 E4 D6 3E  imul ax, word ptr [di - 0x291c], 0x3e
1AC6  C4 3E C2 D7     les di, ptr [0xd7c2]
1ACA  03 F8           add di, ax
1ACC  26 8A 45 FB     mov al, byte ptr es:[di - 5]
1AD0  30 E4           xor ah, ah
1AD2  50              push ax
1AD3  9A 59 02 BC 24  call far 24BC:0259
1AD8  88 46 FF        mov byte ptr [bp - 1], al
loc_1ADB:
1ADB  8A 46 FF        mov al, byte ptr [bp - 1]
1ADE  C9              leave
1ADF  CA 06 00        retf 6

; ---- routine 0AB9:1AE2  (found by: call)
sub_1AE2:
1AE2  C8 0A 00 00     enter 0xa, 0
1AE6  C4 7E 06        les di, ptr [bp + 6]
1AE9  26 6B 45 0E 0F  imul ax, word ptr es:[di + 0xe], 0xf
1AEE  C4 3E BE D7     les di, ptr [0xd7be]
1AF2  03 F8           add di, ax
1AF4  89 7E F6        mov word ptr [bp - 0xa], di
1AF7  8C 46 F8        mov word ptr [bp - 8], es
1AFA  26 80 7D 06 20  cmp byte ptr es:[di + 6], 0x20
1AFF  7D 0B           jge 0x1b0c
1B01  26 8A 45 06     mov al, byte ptr es:[di + 6]
1B05  98              cwde
1B06  40              inc ax
1B07  89 46 FC        mov word ptr [bp - 4], ax
1B0A  EB 33           jmp 0x1b3f
loc_1B0C:
1B0C  C4 7E 06        les di, ptr [bp + 6]
1B0F  26 8B 45 0E     mov ax, word ptr es:[di + 0xe]
1B13  C1 E0 03        shl ax, 3
1B16  C4 3E BA D7     les di, ptr [0xd7ba]
1B1A  03 F8           add di, ax
1B1C  26 8A 05        mov al, byte ptr es:[di]
1B1F  30 E4           xor ah, ah
1B21  3B 06 E6 D6     cmp ax, word ptr [0xd6e6]
1B25  B0 00           mov al, 0
1B27  75 01           jne 0x1b2a
1B29  40              inc ax
loc_1B2A:
1B2A  98              cwde
1B2B  8B F8           mov di, ax
1B2D  80 BD CE D1 00  cmp byte ptr [di - 0x2e32], 0
1B32  75 06           jne 0x1b3a
1B34  83 46 FC 20     add word ptr [bp - 4], 0x20
1B38  EB 05           jmp 0x1b3f
loc_1B3A:
1B3A  31 C0           xor ax, ax
1B3C  89 46 FC        mov word ptr [bp - 4], ax
loc_1B3F:
1B3F  83 7E 0A 15     cmp word ptr [bp + 0xa], 0x15
1B43  72 06           jb 0x1b4b
1B45  83 46 FC 20     add word ptr [bp - 4], 0x20
1B49  EB 0B           jmp 0x1b56
loc_1B4B:
1B4B  C4 7E F6        les di, ptr [bp - 0xa]
1B4E  26 8A 45 08     mov al, byte ptr es:[di + 8]
1B52  98              cwde
1B53  01 46 FC        add word ptr [bp - 4], ax
loc_1B56:
1B56  C4 7E 06        les di, ptr [bp + 6]
1B59  26 FF 75 0E     push word ptr es:[di + 0xe]
1B5D  FF 76 0A        push word ptr [bp + 0xa]
1B60  E8 0B 84        call 0xffff9f6e
1B63  89 46 FA        mov word ptr [bp - 6], ax
1B66  C4 7E 06        les di, ptr [bp + 6]
1B69  26 80 7D 16 00  cmp byte ptr es:[di + 0x16], 0
1B6E  74 08           je 0x1b78
1B70  8B 46 FA        mov ax, word ptr [bp - 6]
1B73  D1 E8           shr ax, 1
1B75  89 46 FA        mov word ptr [bp - 6], ax
loc_1B78:
1B78  8B 46 FA        mov ax, word ptr [bp - 6]
1B7B  C1 E8 02        shr ax, 2
1B7E  8B C8           mov cx, ax
1B80  8B 46 FC        mov ax, word ptr [bp - 4]
1B83  F7 66 FA        mul word ptr [bp - 6]
1B86  C1 E8 08        shr ax, 8
1B89  03 C1           add ax, cx
1B8B  89 46 FC        mov word ptr [bp - 4], ax
1B8E  8B 7E 0A        mov di, word ptr [bp + 0xa]
1B91  80 BD FB 09 00  cmp byte ptr [di + 0x9fb], 0
1B96  74 0C           je 0x1ba4
1B98  C4 7E 06        les di, ptr [bp + 6]
1B9B  26 8A 45 12     mov al, byte ptr es:[di + 0x12]
1B9F  30 E4           xor ah, ah
1BA1  01 46 FC        add word ptr [bp - 4], ax
loc_1BA4:
1BA4  C4 7E 06        les di, ptr [bp + 6]
1BA7  26 80 7D 07 0C  cmp byte ptr es:[di + 7], 0xc
1BAC  73 10           jae 0x1bbe
1BAE  80 3E 29 0D 00  cmp byte ptr [0xd29], 0
1BB3  74 09           je 0x1bbe
1BB5  8B 46 FC        mov ax, word ptr [bp - 4]
1BB8  C1 E8 04        shr ax, 4
1BBB  01 46 FC        add word ptr [bp - 4], ax
loc_1BBE:
1BBE  83 7E FC 01     cmp word ptr [bp - 4], 1
1BC2  73 05           jae 0x1bc9
1BC4  C7 46 FC 01 00  mov word ptr [bp - 4], 1
loc_1BC9:
1BC9  8B 46 FC        mov ax, word ptr [bp - 4]
1BCC  89 46 FE        mov word ptr [bp - 2], ax
1BCF  8B 46 FE        mov ax, word ptr [bp - 2]
1BD2  C9              leave
1BD3  CA 06 00        retf 6

; ---- routine 0AB9:1BD6  (found by: call)
sub_1BD6:
1BD6  C8 02 00 00     enter 2, 0
1BDA  C4 7E 06        les di, ptr [bp + 6]
1BDD  06              push es
1BDE  57              push di
1BDF  0E              push cs
1BE0  E8 D8 00        call 0x1cbb
1BE3  98              cwde
1BE4  8B F8           mov di, ax
1BE6  D1 E7           shl di, 1
1BE8  FF B5 2A D1     push word ptr [di - 0x2ed6]
1BEC  9A 6D 07 2A 23  call far 232A:076D
1BF1  99              cdq
1BF2  52              push dx
1BF3  50              push ax
1BF4  FF 76 0A        push word ptr [bp + 0xa]
1BF7  C4 7E 06        les di, ptr [bp + 6]
1BFA  06              push es
1BFB  57              push di
1BFC  0E              push cs
1BFD  E8 E2 FE        call 0x1ae2
1C00  31 D2           xor dx, dx
1C02  59              pop cx
1C03  5B              pop bx
1C04  3B D3           cmp dx, bx
1C06  7F 0A           jg 0x1c12
1C08  7C 04           jl 0x1c0e
1C0A  3B C1           cmp ax, cx
1C0C  77 04           ja 0x1c12
loc_1C0E:
1C0E  B0 00           mov al, 0
1C10  EB 02           jmp 0x1c14
loc_1C12:
1C12  B0 01           mov al, 1
loc_1C14:
1C14  88 46 FF        mov byte ptr [bp - 1], al
1C17  8A 46 FF        mov al, byte ptr [bp - 1]
1C1A  C9              leave
1C1B  CA 06 00        retf 6

; ---- routine 0AB9:1C1E  (found by: call)
sub_1C1E:
1C1E  C8 0A 00 00     enter 0xa, 0
1C22  31 C0           xor ax, ax
1C24  89 46 FA        mov word ptr [bp - 6], ax
1C27  C7 46 FC 01 00  mov word ptr [bp - 4], 1
1C2C  EB 03           jmp 0x1c31
loc_1C2E:
1C2E  FF 46 FC        inc word ptr [bp - 4]
loc_1C31:
1C31  6B 7E FC 19     imul di, word ptr [bp - 4], 0x19
1C35  81 C7 EF CC     add di, 0xccef
1C39  1E              push ds
1C3A  07              pop es
1C3B  26 8A 45 13     mov al, byte ptr es:[di + 0x13]
1C3F  3A 46 04        cmp al, byte ptr [bp + 4]
1C42  74 1E           je 0x1c62
1C44  A0 9F D0        mov al, byte ptr [0xd09f]
1C47  30 E4           xor ah, ah
1C49  3B 46 FC        cmp ax, word ptr [bp - 4]
1C4C  74 14           je 0x1c62
1C4E  A0 A0 D0        mov al, byte ptr [0xd0a0]
1C51  30 E4           xor ah, ah
1C53  3B 46 FC        cmp ax, word ptr [bp - 4]
1C56  74 0A           je 0x1c62
1C58  06              push es
1C59  57              push di
1C5A  0E              push cs
1C5B  E8 43 00        call 0x1ca1
1C5E  08 C0           or al, al
1C60  74 03           je 0x1c65
loc_1C62:
1C62  FF 46 FA        inc word ptr [bp - 6]
loc_1C65:
1C65  83 7E FC 16     cmp word ptr [bp - 4], 0x16
1C69  75 C3           jne 0x1c2e
1C6B  83 7E FA 16     cmp word ptr [bp - 6], 0x16
1C6F  B0 00           mov al, 0
1C71  75 01           jne 0x1c74
1C73  40              inc ax
loc_1C74:
1C74  88 46 FF        mov byte ptr [bp - 1], al
1C77  8A 46 FF        mov al, byte ptr [bp - 1]
1C7A  C9              leave
1C7B  C2 02 00        ret 2

; ---- routine 0AB9:1C7E  (found by: call)
sub_1C7E:
1C7E  C8 02 00 00     enter 2, 0
1C82  C7 46 FE 01 00  mov word ptr [bp - 2], 1
1C87  EB 03           jmp 0x1c8c
loc_1C89:
1C89  FF 46 FE        inc word ptr [bp - 2]
loc_1C8C:
1C8C  8A 46 04        mov al, byte ptr [bp + 4]
1C8F  6B 7E FE 19     imul di, word ptr [bp - 2], 0x19
1C93  88 85 02 CD     mov byte ptr [di - 0x32fe], al
1C97  83 7E FE 16     cmp word ptr [bp - 2], 0x16
1C9B  75 EC           jne 0x1c89
1C9D  C9              leave
1C9E  C2 02 00        ret 2

; ---- routine 0AB9:1CA1  (found by: call)
sub_1CA1:
1CA1  C8 02 00 00     enter 2, 0
1CA5  C4 7E 06        les di, ptr [bp + 6]
1CA8  26 FF 75 0E     push word ptr es:[di + 0xe]
1CAC  9A 89 4F 55 1B  call far 1B55:4F89
1CB1  88 46 FF        mov byte ptr [bp - 1], al
1CB4  8A 46 FF        mov al, byte ptr [bp - 1]
1CB7  C9              leave
1CB8  CA 04 00        retf 4

; ---- routine 0AB9:1CBB  (found by: call)
sub_1CBB:
1CBB  C8 02 00 00     enter 2, 0
1CBF  C4 7E 06        les di, ptr [bp + 6]
1CC2  26 80 7D 07 0C  cmp byte ptr es:[di + 7], 0xc
1CC7  B0 00           mov al, 0
1CC9  73 01           jae 0x1ccc
1CCB  40              inc ax
loc_1CCC:
1CCC  88 46 FF        mov byte ptr [bp - 1], al
1CCF  8A 46 FF        mov al, byte ptr [bp - 1]
1CD2  C9              leave
1CD3  CA 04 00        retf 4

; ---- routine 0AB9:1CD6  (found by: call)
sub_1CD6:
1CD6  C8 02 00 00     enter 2, 0
1CDA  80 3E 9F D0 0C  cmp byte ptr [0xd09f], 0xc
1CDF  B0 00           mov al, 0
1CE1  73 01           jae 0x1ce4
1CE3  40              inc ax
loc_1CE4:
1CE4  88 46 FF        mov byte ptr [bp - 1], al
1CE7  8A 46 FF        mov al, byte ptr [bp - 1]
1CEA  C9              leave
1CEB  C3              ret

; ---- routine 0AB9:1CEC  (found by: call)
sub_1CEC:
1CEC  C8 02 00 00     enter 2, 0
1CF0  E8 E3 FF        call 0x1cd6
1CF3  08 C0           or al, al
1CF5  B0 00           mov al, 0
1CF7  75 01           jne 0x1cfa
1CF9  40              inc ax
loc_1CFA:
1CFA  98              cwde
1CFB  8B F8           mov di, ax
1CFD  8A 85 56 0D     mov al, byte ptr [di + 0xd56]
1D01  30 E4           xor ah, ah
1D03  40              inc ax
1D04  6B F8 19        imul di, ax, 0x19
1D07  8A 85 F0 CC     mov al, byte ptr [di - 0x3310]
1D0B  98              cwde
1D0C  99              cdq
1D0D  31 D0           xor ax, dx
1D0F  29 D0           sub ax, dx
1D11  8B C8           mov cx, ax
1D13  A0 9F D0        mov al, byte ptr [0xd09f]
1D16  30 E4           xor ah, ah
1D18  6B F8 19        imul di, ax, 0x19
1D1B  8A 85 F0 CC     mov al, byte ptr [di - 0x3310]
1D1F  98              cwde
1D20  99              cdq
1D21  31 D0           xor ax, dx
1D23  29 D0           sub ax, dx
1D25  3B C1           cmp ax, cx
1D27  B0 00           mov al, 0
1D29  7C 01           jl 0x1d2c
1D2B  40              inc ax
loc_1D2C:
1D2C  A2 C9 D1        mov byte ptr [0xd1c9], al
1D2F  A0 C9 D1        mov al, byte ptr [0xd1c9]
1D32  88 46 FF        mov byte ptr [bp - 1], al
1D35  8A 46 FF        mov al, byte ptr [bp - 1]
1D38  C9              leave
1D39  C3              ret

; ---- routine 0AB9:1D3A  (found by: call)
sub_1D3A:
1D3A  55              push bp
1D3B  89 E5           mov bp, sp
1D3D  80 3E 9F D0 00  cmp byte ptr [0xd09f], 0
1D42  76 43           jbe 0x1d87
loc_1D44:
1D44  A0 9F D0        mov al, byte ptr [0xd09f]
1D47  30 E4           xor ah, ah
1D49  6B F8 19        imul di, ax, 0x19
1D4C  81 C7 EF CC     add di, 0xccef
1D50  1E              push ds
1D51  57              push di
1D52  0E              push cs
1D53  E8 4B FF        call 0x1ca1
1D56  08 C0           or al, al
1D58  74 2D           je 0x1d87
1D5A  BF 9F D0        mov di, 0xd09f
1D5D  1E              push ds
1D5E  57              push di
1D5F  E8 74 FF        call 0x1cd6
1D62  98              cwde
1D63  8B F8           mov di, ax
1D65  8A 85 56 0D     mov al, byte ptr [di + 0xd56]
1D69  30 E4           xor ah, ah
1D6B  40              inc ax
1D6C  40              inc ax
1D6D  50              push ax
1D6E  E8 65 FF        call 0x1cd6
1D71  98              cwde
1D72  8B F8           mov di, ax
1D74  8A 85 56 0D     mov al, byte ptr [di + 0xd56]
1D78  30 E4           xor ah, ah
1D7A  05 0B 00        add ax, 0xb
1D7D  50              push ax
1D7E  6A 01           push 1
1D80  9A 8C 04 BC 24  call far 24BC:048C
1D85  EB BD           jmp 0x1d44
loc_1D87:
1D87  C9              leave
1D88  C3              ret

; ---- routine 0AB9:1D89  (found by: call)
sub_1D89:
1D89  C8 02 00 00     enter 2, 0
1D8D  80 3E A0 D0 00  cmp byte ptr [0xd0a0], 0
1D92  76 19           jbe 0x1dad
1D94  A0 A0 D0        mov al, byte ptr [0xd0a0]
1D97  30 E4           xor ah, ah
1D99  6B F8 19        imul di, ax, 0x19
1D9C  81 C7 EF CC     add di, 0xccef
1DA0  1E              push ds
1DA1  57              push di
1DA2  0E              push cs
1DA3  E8 F9 00        call 0x1e9f
1DA6  30 E4           xor ah, ah
1DA8  89 46 FE        mov word ptr [bp - 2], ax
1DAB  EB 05           jmp 0x1db2
loc_1DAD:
1DAD  31 C0           xor ax, ax
1DAF  89 46 FE        mov word ptr [bp - 2], ax
loc_1DB2:
1DB2  8B 46 FE        mov ax, word ptr [bp - 2]
1DB5  C9              leave
1DB6  C3              ret

; ---- routine 0AB9:1DB7  (found by: call)
sub_1DB7:
1DB7  55              push bp
1DB8  89 E5           mov bp, sp
1DBA  E8 19 FF        call 0x1cd6
1DBD  50              push ax
1DBE  A0 9F D0        mov al, byte ptr [0xd09f]
1DC1  30 E4           xor ah, ah
1DC3  6B F8 19        imul di, ax, 0x19
1DC6  81 C7 EF CC     add di, 0xccef
1DCA  1E              push ds
1DCB  57              push di
1DCC  0E              push cs
1DCD  E8 CF 00        call 0x1e9f
1DD0  30 E4           xor ah, ah
1DD2  50              push ax
1DD3  E8 B3 FF        call 0x1d89
1DD6  50              push ax
1DD7  8A 46 04        mov al, byte ptr [bp + 4]
1DDA  50              push ax
1DDB  E8 B6 F1        call 0xf94
1DDE  C9              leave
1DDF  C2 02 00        ret 2

; ---- routine 0AB9:1DE2  (found by: call)
sub_1DE2:
1DE2  55              push bp
1DE3  89 E5           mov bp, sp
1DE5  80 3E A0 D0 0C  cmp byte ptr [0xd0a0], 0xc
1DEA  B0 00           mov al, 0
1DEC  73 01           jae 0x1def
1DEE  40              inc ax
loc_1DEF:
1DEF  50              push ax
1DF0  E8 96 FF        call 0x1d89
1DF3  50              push ax
1DF4  A0 9F D0        mov al, byte ptr [0xd09f]
1DF7  30 E4           xor ah, ah
1DF9  6B F8 19        imul di, ax, 0x19
1DFC  81 C7 EF CC     add di, 0xccef
1E00  1E              push ds
1E01  57              push di
1E02  0E              push cs
1E03  E8 99 00        call 0x1e9f
1E06  30 E4           xor ah, ah
1E08  50              push ax
1E09  8A 46 04        mov al, byte ptr [bp + 4]
1E0C  50              push ax
1E0D  E8 84 F1        call 0xf94
1E10  C9              leave
1E11  C2 02 00        ret 2

; ---- routine 0AB9:1E14  (found by: call)
sub_1E14:
1E14  55              push bp
1E15  89 E5           mov bp, sp
1E17  6A 01           push 1
1E19  6A 00           push 0
1E1B  6A 00           push 0
1E1D  8A 46 04        mov al, byte ptr [bp + 4]
1E20  50              push ax
1E21  E8 70 F1        call 0xf94
1E24  C9              leave
1E25  C2 02 00        ret 2

; ---- routine 0AB9:1E28  (found by: call)
sub_1E28:
1E28  55              push bp
1E29  89 E5           mov bp, sp
1E2B  C4 7E 06        les di, ptr [bp + 6]
1E2E  06              push es
1E2F  57              push di
1E30  0E              push cs
1E31  E8 87 FE        call 0x1cbb
1E34  50              push ax
1E35  C4 7E 06        les di, ptr [bp + 6]
1E38  06              push es
1E39  57              push di
1E3A  0E              push cs
1E3B  E8 61 00        call 0x1e9f
1E3E  30 E4           xor ah, ah
1E40  50              push ax
1E41  6A 00           push 0
1E43  8A 46 0A        mov al, byte ptr [bp + 0xa]
1E46  50              push ax
1E47  E8 4A F1        call 0xf94
1E4A  C9              leave
1E4B  CA 06 00        retf 6

; ---- routine 0AB9:1E4E  (found by: call)
sub_1E4E:
1E4E  C8 02 00 00     enter 2, 0
1E52  E8 81 FE        call 0x1cd6
1E55  50              push ax
1E56  C4 7E 06        les di, ptr [bp + 6]
1E59  06              push es
1E5A  57              push di
1E5B  0E              push cs
1E5C  E8 5C FE        call 0x1cbb
1E5F  5A              pop dx
1E60  3A C2           cmp al, dl
1E62  B0 00           mov al, 0
1E64  75 01           jne 0x1e67
1E66  40              inc ax
loc_1E67:
1E67  88 46 FF        mov byte ptr [bp - 1], al
1E6A  8A 46 FF        mov al, byte ptr [bp - 1]
1E6D  C9              leave
1E6E  CA 04 00        retf 4

; ---- routine 0AB9:1E71  (found by: call)
sub_1E71:
1E71  C8 02 00 00     enter 2, 0
1E75  C4 7E 06        les di, ptr [bp + 6]
1E78  26 6B 45 0E 0F  imul ax, word ptr es:[di + 0xe], 0xf
1E7D  C4 3E BE D7     les di, ptr [0xd7be]
1E81  03 F8           add di, ax
1E83  26 8A 45 08     mov al, byte ptr es:[di + 8]
1E87  98              cwde
1E88  8B D0           mov dx, ax
1E8A  B8 21 00        mov ax, 0x21
1E8D  2B C2           sub ax, dx
1E8F  50              push ax
1E90  9A 1C 0D BC 24  call far 24BC:0D1C
1E95  88 46 FF        mov byte ptr [bp - 1], al
1E98  8A 46 FF        mov al, byte ptr [bp - 1]
1E9B  C9              leave
1E9C  CA 04 00        retf 4

; ---- routine 0AB9:1E9F  (found by: call)
sub_1E9F:
1E9F  C8 02 00 00     enter 2, 0
1EA3  C4 7E 06        les di, ptr [bp + 6]
1EA6  26 80 7D 07 0B  cmp byte ptr es:[di + 7], 0xb
1EAB  76 0E           jbe 0x1ebb
1EAD  26 8A 45 07     mov al, byte ptr es:[di + 7]
1EB1  30 E4           xor ah, ah
1EB3  2D 0B 00        sub ax, 0xb
1EB6  88 46 FF        mov byte ptr [bp - 1], al
1EB9  EB 0A           jmp 0x1ec5
loc_1EBB:
1EBB  C4 7E 06        les di, ptr [bp + 6]
1EBE  26 8A 45 07     mov al, byte ptr es:[di + 7]
1EC2  88 46 FF        mov byte ptr [bp - 1], al
loc_1EC5:
1EC5  8A 46 FF        mov al, byte ptr [bp - 1]
1EC8  C9              leave
1EC9  CA 04 00        retf 4

; ---- routine 0AB9:1ECC  (found by: call)
sub_1ECC:
1ECC  C8 02 00 00     enter 2, 0
1ED0  A0 AC D0        mov al, byte ptr [0xd0ac]
1ED3  98              cwde
1ED4  99              cdq
1ED5  8B C8           mov cx, ax
1ED7  8B DA           mov bx, dx
1ED9  A1 AE D0        mov ax, word ptr [0xd0ae]
1EDC  31 D2           xor dx, dx
1EDE  3B D3           cmp dx, bx
1EE0  7F 0A           jg 0x1eec
1EE2  7C 04           jl 0x1ee8
1EE4  3B C1           cmp ax, cx
1EE6  77 04           ja 0x1eec
loc_1EE8:
1EE8  B0 00           mov al, 0
1EEA  EB 02           jmp 0x1eee
loc_1EEC:
1EEC  B0 01           mov al, 1
loc_1EEE:
1EEE  50              push ax
1EEF  C4 7E 06        les di, ptr [bp + 6]
1EF2  06              push es
1EF3  57              push di
1EF4  0E              push cs
1EF5  E8 C3 FD        call 0x1cbb
1EF8  5A              pop dx
1EF9  32 C2           xor al, dl
1EFB  98              cwde
1EFC  8B F8           mov di, ax
1EFE  8A 85 38 A3     mov al, byte ptr [di - 0x5cc8]
1F02  88 46 FF        mov byte ptr [bp - 1], al
1F05  8A 46 FF        mov al, byte ptr [bp - 1]
1F08  C9              leave
1F09  CA 04 00        retf 4

; ---- routine 0AB9:1F0C  (found by: call)
sub_1F0C:
1F0C  C8 02 00 00     enter 2, 0
1F10  A0 9F D0        mov al, byte ptr [0xd09f]
1F13  C4 7E 06        les di, ptr [bp + 6]
1F16  26 3A 45 07     cmp al, byte ptr es:[di + 7]
1F1A  75 07           jne 0x1f23
1F1C  80 3E 53 CF 00  cmp byte ptr [0xcf53], 0
1F21  74 04           je 0x1f27
loc_1F23:
1F23  B0 00           mov al, 0
1F25  EB 02           jmp 0x1f29
loc_1F27:
1F27  B0 01           mov al, 1
loc_1F29:
1F29  88 46 FF        mov byte ptr [bp - 1], al
1F2C  8A 46 FF        mov al, byte ptr [bp - 1]
1F2F  C9              leave
1F30  CA 04 00        retf 4

; ---- routine 0AB9:1F33  (found by: call)
sub_1F33:
1F33  C8 02 00 00     enter 2, 0
1F37  C4 7E 06        les di, ptr [bp + 6]
1F3A  06              push es
1F3B  57              push di
1F3C  0E              push cs
1F3D  E8 8C FF        call 0x1ecc
1F40  98              cwde
1F41  8B D0           mov dx, ax
1F43  C4 7E 06        les di, ptr [bp + 6]
1F46  26 8A 45 01     mov al, byte ptr es:[di + 1]
1F4A  98              cwde
1F4B  F7 E2           mul dx
1F4D  09 C0           or ax, ax
1F4F  B0 00           mov al, 0
1F51  7D 01           jge 0x1f54
1F53  40              inc ax
loc_1F54:
1F54  88 46 FF        mov byte ptr [bp - 1], al
1F57  8A 46 FF        mov al, byte ptr [bp - 1]
1F5A  C9              leave
1F5B  CA 04 00        retf 4

; ---- routine 0AB9:1F5E  (found by: call)
sub_1F5E:
1F5E  C8 02 00 00     enter 2, 0
1F62  C4 7E 06        les di, ptr [bp + 6]
1F65  06              push es
1F66  57              push di
1F67  0E              push cs
1F68  E8 61 FF        call 0x1ecc
1F6B  98              cwde
1F6C  8B D0           mov dx, ax
1F6E  8A 46 0B        mov al, byte ptr [bp + 0xb]
1F71  98              cwde
1F72  F7 E2           mul dx
1F74  88 46 0B        mov byte ptr [bp + 0xb], al
1F77  C4 7E 06        les di, ptr [bp + 6]
1F7A  06              push es
1F7B  57              push di
1F7C  0E              push cs
1F7D  E8 4C FF        call 0x1ecc
1F80  98              cwde
1F81  8B D0           mov dx, ax
1F83  8A 46 0A        mov al, byte ptr [bp + 0xa]
1F86  98              cwde
1F87  F7 E2           mul dx
1F89  88 46 0A        mov byte ptr [bp + 0xa], al
1F8C  8B 46 0A        mov ax, word ptr [bp + 0xa]
1F8F  89 46 FE        mov word ptr [bp - 2], ax
1F92  8B 46 FE        mov ax, word ptr [bp - 2]
1F95  C9              leave
1F96  CA 06 00        retf 6

; ---- routine 0AB9:1F99  (found by: call)
sub_1F99:
1F99  C8 02 00 00     enter 2, 0
1F9D  C4 7E 06        les di, ptr [bp + 6]
1FA0  26 8B 05        mov ax, word ptr es:[di]
1FA3  26 3B 45 08     cmp ax, word ptr es:[di + 8]
1FA7  B0 00           mov al, 0
1FA9  75 01           jne 0x1fac
1FAB  40              inc ax
loc_1FAC:
1FAC  88 46 FF        mov byte ptr [bp - 1], al
1FAF  8A 46 FF        mov al, byte ptr [bp - 1]
1FB2  C9              leave
1FB3  CA 04 00        retf 4

