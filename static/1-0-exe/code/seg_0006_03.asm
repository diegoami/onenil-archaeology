; 1-0.EXE (One-Nil 96), code segment 0006 (image offsets 00060..01EEF), part 3 of 3
; packed 1-0.EXE sha256 89ff9c5f238f24e81a0c2440a46cdd8997280a65fc3cc3d97cb974f55280a80a (LZEXE 0.91)
; unpacked (tools/static/unlzexe.py) sha256 887ed2a92767950e5309b2052409f875668605939b69e00737aa3047022b9f51
; tool: capstone 5.0.9 (pip package; core library 5.0.1280) (CS_ARCH_X86, CS_MODE_16), recursive descent from the entry point, far calls and near calls/jumps, then routine prologues (55 89 E5 / 55 8B EC / C8 iw 00) in what remains; tools/static/listing.py
; addresses are SEGMENT:OFFSET with SEGMENT the image paragraph before relocation; image offset = SEGMENT*16+OFFSET
; ---- routine 0006:16B7  (found by: call)
sub_16B7:
16B7  C8 06 00 00     enter 6, 0
16BB  8B 7E 04        mov di, word ptr [bp + 4]
16BE  36 8A 45 FF     mov al, byte ptr ss:[di - 1]
16C2  30 E4           xor ah, ah
16C4  6B C0 3B        imul ax, ax, 0x3b
16C7  C4 3E BC DC     les di, ptr [0xdcbc]
16CB  03 F8           add di, ax
16CD  81 C7 C5 FF     add di, 0xffc5
16D1  89 7E FA        mov word ptr [bp - 6], di
16D4  8C 46 FC        mov word ptr [bp - 4], es
16D7  8A 46 06        mov al, byte ptr [bp + 6]
16DA  3C 03           cmp al, 3
16DC  72 0E           jb 0x16ec
16DE  3C 04           cmp al, 4
16E0  77 0A           ja 0x16ec
16E2  8B 46 08        mov ax, word ptr [bp + 8]
16E5  40              inc ax
16E6  40              inc ax
16E7  89 46 FE        mov word ptr [bp - 2], ax
16EA  EB 20           jmp 0x170c
loc_16EC:
16EC  80 7E 06 06     cmp byte ptr [bp + 6], 6
16F0  74 0E           je 0x1700
16F2  8B 7E 08        mov di, word ptr [bp + 8]
16F5  8A 85 BD 00     mov al, byte ptr [di + 0xbd]
16F9  30 E4           xor ah, ah
16FB  89 46 FE        mov word ptr [bp - 2], ax
16FE  EB 0C           jmp 0x170c
loc_1700:
1700  8B 7E 08        mov di, word ptr [bp + 8]
1703  8A 85 C7 00     mov al, byte ptr [di + 0xc7]
1707  30 E4           xor ah, ah
1709  89 46 FE        mov word ptr [bp - 2], ax
loc_170C:
170C  83 7E FE 08     cmp word ptr [bp - 2], 8
1710  75 2E           jne 0x1740
1712  C4 3E D2 D7     les di, ptr [0xd7d2]
1716  26 8A 45 04     mov al, byte ptr es:[di + 4]
171A  30 E4           xor ah, ah
171C  6B C0 09        imul ax, ax, 9
171F  C4 7E FA        les di, ptr [bp - 6]
1722  03 F8           add di, ax
1724  26 8A 55 22     mov dl, byte ptr es:[di + 0x22]
1728  8A 46 06        mov al, byte ptr [bp + 6]
172B  98              cwde
172C  D1 E0           shl ax, 1
172E  C4 7E FA        les di, ptr [bp - 6]
1731  03 F8           add di, ax
1733  26 8A 45 FB     mov al, byte ptr es:[di - 5]
1737  3A C2           cmp al, dl
1739  75 05           jne 0x1740
173B  C7 46 FE 0A 00  mov word ptr [bp - 2], 0xa
loc_1740:
1740  6B 7E FE 0E     imul di, word ptr [bp - 2], 0xe
1744  81 C7 24 00     add di, 0x24
1748  1E              push ds
1749  57              push di
174A  C4 7E 0A        les di, ptr [bp + 0xa]
174D  06              push es
174E  57              push di
174F  6A 0F           push 0xf
1751  9A 6D 0B C9 26  call far 26C9:0B6D
1756  C9              leave
1757  C2 06 00        ret 6

; ---- routine 0006:175A  (found by: call)
sub_175A:
175A  C8 04 00 00     enter 4, 0
175E  8B 7E 04        mov di, word ptr [bp + 4]
1761  36 8A 45 FF     mov al, byte ptr ss:[di - 1]
1765  30 E4           xor ah, ah
1767  6B C0 3B        imul ax, ax, 0x3b
176A  C4 3E BC DC     les di, ptr [0xdcbc]
176E  03 F8           add di, ax
1770  81 C7 C5 FF     add di, 0xffc5
1774  89 7E FC        mov word ptr [bp - 4], di
1777  8C 46 FE        mov word ptr [bp - 2], es
177A  6A 00           push 0
177C  FF 76 08        push word ptr [bp + 8]
177F  FF 76 06        push word ptr [bp + 6]
1782  9A E3 0E 55 1B  call far 1B55:0EE3
1787  C4 3E D2 D7     les di, ptr [0xd7d2]
178B  26 8A 45 04     mov al, byte ptr es:[di + 4]
178F  30 E4           xor ah, ah
1791  6B C0 09        imul ax, ax, 9
1794  C4 7E FC        les di, ptr [bp - 4]
1797  03 F8           add di, ax
1799  26 8A 45 22     mov al, byte ptr es:[di + 0x22]
179D  30 E4           xor ah, ah
179F  3B 46 0C        cmp ax, word ptr [bp + 0xc]
17A2  75 08           jne 0x17ac
17A4  C7 06 64 DD 0F 00 mov word ptr [0xdd64], 0xf
17AA  EB 06           jmp 0x17b2
loc_17AC:
17AC  8B 46 0A        mov ax, word ptr [bp + 0xa]
17AF  A3 64 DD        mov word ptr [0xdd64], ax
loc_17B2:
17B2  8B 46 0C        mov ax, word ptr [bp + 0xc]
17B5  C1 E0 04        shl ax, 4
17B8  C4 3E B2 D7     les di, ptr [0xd7b2]
17BC  03 F8           add di, ax
17BE  81 C7 F0 FF     add di, 0xfff0
17C2  06              push es
17C3  57              push di
17C4  8A 46 08        mov al, byte ptr [bp + 8]
17C7  50              push ax
17C8  8A 46 06        mov al, byte ptr [bp + 6]
17CB  50              push ax
17CC  BF 5C DD        mov di, 0xdd5c
17CF  1E              push ds
17D0  57              push di
17D1  9A 9D 03 2A 23  call far 232A:039D
17D6  C9              leave
17D7  C2 0A 00        ret 0xa
; data (not reached as code), 2 bytes
17DA                  db 01 2F   ; ./

; ---- routine 0006:17DC  (found by: call)
sub_17DC:
17DC  C8 0A 02 00     enter 0x20a, 0
17E0  8B 7E 04        mov di, word ptr [bp + 4]
17E3  36 8A 45 FF     mov al, byte ptr ss:[di - 1]
17E7  30 E4           xor ah, ah
17E9  6B C0 3B        imul ax, ax, 0x3b
17EC  C4 3E BC DC     les di, ptr [0xdcbc]
17F0  03 F8           add di, ax
17F2  81 C7 C5 FF     add di, 0xffc5
17F6  89 7E F6        mov word ptr [bp - 0xa], di
17F9  8C 46 F8        mov word ptr [bp - 8], es
17FC  6A 0E           push 0xe
17FE  8D BE F6 FE     lea di, [bp - 0x10a]
1802  16              push ss
1803  57              push di
1804  C4 7E F6        les di, ptr [bp - 0xa]
1807  26 8B 45 27     mov ax, word ptr es:[di + 0x27]
180B  2D 03 00        sub ax, 3
180E  31 D2           xor dx, dx
1810  52              push dx
1811  50              push ax
1812  9A C9 07 2A 23  call far 232A:07C9
1817  BF DA 17        mov di, 0x17da
181A  0E              push cs
181B  57              push di
181C  9A D2 0B C9 26  call far 26C9:0BD2
1821  8D BE F6 FD     lea di, [bp - 0x20a]
1825  16              push ss
1826  57              push di
1827  C4 7E F6        les di, ptr [bp - 0xa]
182A  26 8B 45 27     mov ax, word ptr es:[di + 0x27]
182E  48              dec ax
182F  48              dec ax
1830  50              push ax
1831  9A C1 00 55 1B  call far 1B55:00C1
1836  9A D2 0B C9 26  call far 26C9:0BD2
183B  6A 01           push 1
183D  6A 4A           push 0x4a
183F  BF 5C DD        mov di, 0xdd5c
1842  1E              push ds
1843  57              push di
1844  9A 1B 04 2A 23  call far 232A:041B
1849  C6 46 FE 03     mov byte ptr [bp - 2], 3
184D  EB 03           jmp 0x1852
loc_184F:
184F  FE 46 FE        inc byte ptr [bp - 2]
loc_1852:
1852  80 7E FE 05     cmp byte ptr [bp - 2], 5
1856  74 64           je 0x18bc
1858  C6 46 FF 00     mov byte ptr [bp - 1], 0
185C  EB 03           jmp 0x1861
loc_185E:
185E  FE 46 FF        inc byte ptr [bp - 1]
loc_1861:
1861  8A 46 FF        mov al, byte ptr [bp - 1]
1864  98              cwde
1865  8B D0           mov dx, ax
1867  8A 46 FE        mov al, byte ptr [bp - 2]
186A  98              cwde
186B  D1 E0           shl ax, 1
186D  C4 7E F6        les di, ptr [bp - 0xa]
1870  03 F8           add di, ax
1872  03 FA           add di, dx
1874  26 8A 45 FA     mov al, byte ptr es:[di - 6]
1878  30 E4           xor ah, ah
187A  50              push ax
187B  8A 46 FF        mov al, byte ptr [bp - 1]
187E  98              cwde
187F  8B D0           mov dx, ax
1881  8A 46 FE        mov al, byte ptr [bp - 2]
1884  98              cwde
1885  D1 E0           shl ax, 1
1887  C4 7E F6        les di, ptr [bp - 0xa]
188A  03 F8           add di, ax
188C  03 FA           add di, dx
188E  26 8A 45 06     mov al, byte ptr es:[di + 6]
1892  30 E4           xor ah, ah
1894  50              push ax
1895  8A 46 FE        mov al, byte ptr [bp - 2]
1898  98              cwde
1899  8B F8           mov di, ax
189B  8A 85 D1 00     mov al, byte ptr [di + 0xd1]
189F  30 E4           xor ah, ah
18A1  50              push ax
18A2  8A 46 FF        mov al, byte ptr [bp - 1]
18A5  98              cwde
18A6  8B F8           mov di, ax
18A8  8A 85 DA 00     mov al, byte ptr [di + 0xda]
18AC  30 E4           xor ah, ah
18AE  50              push ax
18AF  8B 7E 04        mov di, word ptr [bp + 4]
18B2  57              push di
18B3  E8 A4 FE        call 0x175a
18B6  80 7E FF 01     cmp byte ptr [bp - 1], 1
18BA  75 A2           jne 0x185e
loc_18BC:
18BC  80 7E FE 08     cmp byte ptr [bp - 2], 8
18C0  75 8D           jne 0x184f
18C2  C6 46 FD 00     mov byte ptr [bp - 3], 0
18C6  EB 03           jmp 0x18cb
loc_18C8:
18C8  FE 46 FD        inc byte ptr [bp - 3]
loc_18CB:
18CB  8A 46 FD        mov al, byte ptr [bp - 3]
18CE  98              cwde
18CF  8B F8           mov di, ax
18D1  8A 85 3C A2     mov al, byte ptr [di - 0x5dc4]
18D5  50              push ax
18D6  8A 46 FD        mov al, byte ptr [bp - 3]
18D9  98              cwde
18DA  8B F8           mov di, ax
18DC  C1 E7 04        shl di, 4
18DF  81 C7 E6 DC     add di, 0xdce6
18E3  1E              push ds
18E4  57              push di
18E5  8A 46 FD        mov al, byte ptr [bp - 3]
18E8  30 E4           xor ah, ah
18EA  05 11 00        add ax, 0x11
18ED  50              push ax
18EE  6A 05           push 5
18F0  BF 5C DD        mov di, 0xdd5c
18F3  1E              push ds
18F4  57              push di
18F5  9A 1B 04 2A 23  call far 232A:041B
18FA  C7 46 FA 01 00  mov word ptr [bp - 6], 1
18FF  EB 03           jmp 0x1904
loc_1901:
1901  FF 46 FA        inc word ptr [bp - 6]
loc_1904:
1904  8B 56 FA        mov dx, word ptr [bp - 6]
1907  8A 46 FD        mov al, byte ptr [bp - 3]
190A  98              cwde
190B  8B F0           mov si, ax
190D  D1 E0           shl ax, 1
190F  01 F0           add ax, si
1911  C4 7E F6        les di, ptr [bp - 0xa]
1914  03 F8           add di, ax
1916  03 FA           add di, dx
1918  26 8A 45 17     mov al, byte ptr es:[di + 0x17]
191C  30 E4           xor ah, ah
191E  50              push ax
191F  8A 46 FD        mov al, byte ptr [bp - 3]
1922  98              cwde
1923  8B F8           mov di, ax
1925  8A 85 3C A2     mov al, byte ptr [di - 0x5dc4]
1929  30 E4           xor ah, ah
192B  50              push ax
192C  8A 46 FD        mov al, byte ptr [bp - 3]
192F  30 E4           xor ah, ah
1931  05 11 00        add ax, 0x11
1934  50              push ax
1935  8B 7E FA        mov di, word ptr [bp - 6]
1938  8A 85 DB 00     mov al, byte ptr [di + 0xdb]
193C  30 E4           xor ah, ah
193E  50              push ax
193F  8B 7E 04        mov di, word ptr [bp + 4]
1942  57              push di
1943  E8 14 FE        call 0x175a
1946  83 7E FA 03     cmp word ptr [bp - 6], 3
194A  75 B5           jne 0x1901
194C  80 7E FD 04     cmp byte ptr [bp - 3], 4
1950  74 03           je 0x1955
1952  E9 73 FF        jmp 0x18c8
loc_1955:
1955  C4 3E D2 D7     les di, ptr [0xd7d2]
1959  26 8A 45 04     mov al, byte ptr es:[di + 4]
195D  30 E4           xor ah, ah
195F  6B C0 09        imul ax, ax, 9
1962  C4 7E F6        les di, ptr [bp - 0xa]
1965  03 F8           add di, ax
1967  81 C7 20 00     add di, 0x20
196B  89 7E F2        mov word ptr [bp - 0xe], di
196E  8C 46 F4        mov word ptr [bp - 0xc], es
1971  26 80 7D 02 00  cmp byte ptr es:[di + 2], 0
1976  75 03           jne 0x197b
1978  E9 B0 00        jmp 0x1a2b
loc_197B:
197B  C4 7E F2        les di, ptr [bp - 0xe]
197E  26 8A 45 02     mov al, byte ptr es:[di + 2]
1982  30 E4           xor ah, ah
1984  50              push ax
1985  6A 0F           push 0xf
1987  6A 04           push 4
1989  6A 3B           push 0x3b
198B  8B 7E 04        mov di, word ptr [bp + 4]
198E  57              push di
198F  E8 C8 FD        call 0x175a
1992  C4 7E F2        les di, ptr [bp - 0xe]
1995  26 8A 05        mov al, byte ptr es:[di]
1998  98              cwde
1999  8B F8           mov di, ax
199B  8A 85 3C A2     mov al, byte ptr [di - 0x5dc4]
199F  50              push ax
19A0  8D BE F2 FE     lea di, [bp - 0x10e]
19A4  16              push ss
19A5  57              push di
19A6  C4 7E F2        les di, ptr [bp - 0xe]
19A9  26 8A 45 01     mov al, byte ptr es:[di + 1]
19AD  30 E4           xor ah, ah
19AF  31 D2           xor dx, dx
19B1  52              push dx
19B2  50              push ax
19B3  9A C9 07 2A 23  call far 232A:07C9
19B8  C4 7E F2        les di, ptr [bp - 0xe]
19BB  26 8A 05        mov al, byte ptr es:[di]
19BE  30 E4           xor ah, ah
19C0  05 11 00        add ax, 0x11
19C3  50              push ax
19C4  6A 4C           push 0x4c
19C6  BF 5C DD        mov di, 0xdd5c
19C9  1E              push ds
19CA  57              push di
19CB  9A 0C 03 2A 23  call far 232A:030C
19D0  C6 46 FE 03     mov byte ptr [bp - 2], 3
19D4  EB 03           jmp 0x19d9
loc_19D6:
19D6  FE 46 FE        inc byte ptr [bp - 2]
loc_19D9:
19D9  8A 46 FE        mov al, byte ptr [bp - 2]
19DC  98              cwde
19DD  C4 7E F2        les di, ptr [bp - 0xe]
19E0  03 F8           add di, ax
19E2  26 80 3D 00     cmp byte ptr es:[di], 0
19E6  74 3D           je 0x1a25
19E8  80 7E FE 05     cmp byte ptr [bp - 2], 5
19EC  74 37           je 0x1a25
19EE  8D BE F2 FE     lea di, [bp - 0x10e]
19F2  16              push ss
19F3  57              push di
19F4  8A 46 FE        mov al, byte ptr [bp - 2]
19F7  98              cwde
19F8  C4 7E F2        les di, ptr [bp - 0xe]
19FB  03 F8           add di, ax
19FD  26 8A 05        mov al, byte ptr es:[di]
1A00  30 E4           xor ah, ah
1A02  50              push ax
1A03  8A 46 FE        mov al, byte ptr [bp - 2]
1A06  50              push ax
1A07  8B 7E 04        mov di, word ptr [bp + 4]
1A0A  57              push di
1A0B  E8 A9 FC        call 0x16b7
1A0E  8A 46 FE        mov al, byte ptr [bp - 2]
1A11  98              cwde
1A12  8B F8           mov di, ax
1A14  8A 85 D1 00     mov al, byte ptr [di + 0xd1]
1A18  50              push ax
1A19  6A 3B           push 0x3b
1A1B  BF 5C DD        mov di, 0xdd5c
1A1E  1E              push ds
1A1F  57              push di
1A20  9A 9D 03 2A 23  call far 232A:039D
loc_1A25:
1A25  80 7E FE 08     cmp byte ptr [bp - 2], 8
1A29  75 AB           jne 0x19d6
loc_1A2B:
1A2B  C9              leave
1A2C  C2 02 00        ret 2
; data (not reached as code), 56 bytes
1A2F                  pstr 'No history available until a full season is completed'
1A65                  db 01 2E   ; ..

; ---- routine 0006:1A67  (found by: call)
sub_1A67:
1A67  C8 04 02 00     enter 0x204, 0
1A6B  C6 46 FE 00     mov byte ptr [bp - 2], 0
1A6F  C7 46 FC 01 00  mov word ptr [bp - 4], 1
1A74  EB 03           jmp 0x1a79
loc_1A76:
1A76  FF 46 FC        inc word ptr [bp - 4]
loc_1A79:
1A79  6B 46 FC 3B     imul ax, word ptr [bp - 4], 0x3b
1A7D  C4 3E BC DC     les di, ptr [0xdcbc]
1A81  03 F8           add di, ax
1A83  26 80 7D DD 00  cmp byte ptr es:[di - 0x23], 0
1A88  74 03           je 0x1a8d
1A8A  FE 46 FE        inc byte ptr [bp - 2]
loc_1A8D:
1A8D  83 7E FC 1E     cmp word ptr [bp - 4], 0x1e
1A91  75 E3           jne 0x1a76
1A93  80 7E FE 00     cmp byte ptr [bp - 2], 0
1A97  B0 00           mov al, 0
1A99  75 01           jne 0x1a9c
1A9B  40              inc ax
loc_1A9C:
1A9C  50              push ax
1A9D  BF 2F 1A        mov di, 0x1a2f
1AA0  0E              push cs
1AA1  57              push di
1AA2  9A 98 00 2A 23  call far 232A:0098
1AA7  08 C0           or al, al
1AA9  74 03           je 0x1aae
1AAB  E9 90 00        jmp 0x1b3e
loc_1AAE:
1AAE  C6 46 FF 01     mov byte ptr [bp - 1], 1
loc_1AB2:
1AB2  BF 24 83        mov di, 0x8324
1AB5  1E              push ds
1AB6  57              push di
1AB7  BF 5C DD        mov di, 0xdd5c
1ABA  1E              push ds
1ABB  57              push di
1ABC  9A 2F 05 2A 23  call far 232A:052F
1AC1  55              push bp
1AC2  E8 17 FD        call 0x17dc
1AC5  C4 3E 5C DD     les di, ptr [0xdd5c]
1AC9  06              push es
1ACA  57              push di
1ACB  C4 3E 58 DD     les di, ptr [0xdd58]
1ACF  06              push es
1AD0  57              push di
1AD1  68 A0 0F        push 0xfa0
1AD4  9A 12 0A C9 26  call far 26C9:0A12
1AD9  9A 9B 09 2A 23  call far 232A:099B
1ADE  80 3E 88 DE 02  cmp byte ptr [0xde88], 2
1AE3  75 3F           jne 0x1b24
1AE5  8D BE FC FE     lea di, [bp - 0x104]
1AE9  16              push ss
1AEA  57              push di
1AEB  9A 5A 79 55 1B  call far 1B55:795A
1AF0  BF 65 1A        mov di, 0x1a65
1AF3  0E              push cs
1AF4  57              push di
1AF5  9A D2 0B C9 26  call far 26C9:0BD2
1AFA  8D BE FC FD     lea di, [bp - 0x204]
1AFE  16              push ss
1AFF  57              push di
1B00  8A 46 FF        mov al, byte ptr [bp - 1]
1B03  30 E4           xor ah, ah
1B05  6B C0 3B        imul ax, ax, 0x3b
1B08  C4 3E BC DC     les di, ptr [0xdcbc]
1B0C  03 F8           add di, ax
1B0E  26 8B 45 EC     mov ax, word ptr es:[di - 0x14]
1B12  48              dec ax
1B13  48              dec ax
1B14  50              push ax
1B15  9A C1 00 55 1B  call far 1B55:00C1
1B1A  9A D2 0B C9 26  call far 26C9:0BD2
1B1F  E8 C0 F9        call 0x14e2
1B22  EB 10           jmp 0x1b34
loc_1B24:
1B24  8D 7E FF        lea di, [bp - 1]
1B27  16              push ss
1B28  57              push di
1B29  8A 46 FE        mov al, byte ptr [bp - 2]
1B2C  30 E4           xor ah, ah
1B2E  50              push ax
1B2F  9A 60 0E 2A 23  call far 232A:0E60
loc_1B34:
1B34  80 3E 88 DE 01  cmp byte ptr [0xde88], 1
1B39  74 03           je 0x1b3e
1B3B  E9 74 FF        jmp 0x1ab2
loc_1B3E:
1B3E  C9              leave
1B3F  C3              ret
; data (not reached as code), 18 bytes
1B40                  pstr 'No game this week'

; ---- routine 0006:1B52  (found by: far)
sub_1B52:
1B52  C8 06 01 00     enter 0x106, 0
1B56  C4 3E D2 D7     les di, ptr [0xd7d2]
1B5A  89 7E FA        mov word ptr [bp - 6], di
1B5D  8C 46 FC        mov word ptr [bp - 4], es
loc_1B60:
1B60  BF E6 45        mov di, 0x45e6
1B63  1E              push ds
1B64  57              push di
1B65  BF 5C DD        mov di, 0xdd5c
1B68  1E              push ds
1B69  57              push di
1B6A  9A 2F 05 2A 23  call far 232A:052F
1B6F  BF 42 43        mov di, 0x4342
1B72  1E              push ds
1B73  57              push di
1B74  BF 5C DD        mov di, 0xdd5c
1B77  1E              push ds
1B78  57              push di
1B79  9A 2F 05 2A 23  call far 232A:052F
1B7E  C4 7E FA        les di, ptr [bp - 6]
1B81  26 80 7D 03 01  cmp byte ptr es:[di + 3], 1
1B86  75 11           jne 0x1b99
1B88  BF 28 5A        mov di, 0x5a28
1B8B  1E              push ds
1B8C  57              push di
1B8D  BF 5C DD        mov di, 0xdd5c
1B90  1E              push ds
1B91  57              push di
1B92  9A 2F 05 2A 23  call far 232A:052F
1B97  EB 2A           jmp 0x1bc3
loc_1B99:
1B99  C4 7E FA        les di, ptr [bp - 6]
1B9C  26 80 7D 04 01  cmp byte ptr es:[di + 4], 1
1BA1  75 11           jne 0x1bb4
1BA3  BF 4E 5A        mov di, 0x5a4e
1BA6  1E              push ds
1BA7  57              push di
1BA8  BF 5C DD        mov di, 0xdd5c
1BAB  1E              push ds
1BAC  57              push di
1BAD  9A 2F 05 2A 23  call far 232A:052F
1BB2  EB 0F           jmp 0x1bc3
loc_1BB4:
1BB4  BF EE 59        mov di, 0x59ee
1BB7  1E              push ds
1BB8  57              push di
1BB9  BF 5C DD        mov di, 0xdd5c
1BBC  1E              push ds
1BBD  57              push di
1BBE  9A 2F 05 2A 23  call far 232A:052F
loc_1BC3:
1BC3  6A 0B           push 0xb
1BC5  8D BE FA FE     lea di, [bp - 0x106]
1BC9  16              push ss
1BCA  57              push di
1BCB  9A 5A 79 55 1B  call far 1B55:795A
1BD0  6A 02           push 2
1BD2  6A 47           push 0x47
1BD4  BF 5C DD        mov di, 0xdd5c
1BD7  1E              push ds
1BD8  57              push di
1BD9  9A 1B 04 2A 23  call far 232A:041B
1BDE  A0 E0 00        mov al, byte ptr [0xe0]
1BE1  30 E4           xor ah, ah
1BE3  05 04 00        add ax, 4
1BE6  50              push ax
1BE7  6A 3B           push 0x3b
1BE9  6A 14           push 0x14
1BEB  9A 03 02 2A 23  call far 232A:0203
1BF0  E8 A4 F5        call 0x1197
1BF3  C4 7E FA        les di, ptr [bp - 6]
1BF6  26 8A 45 04     mov al, byte ptr es:[di + 4]
1BFA  30 E4           xor ah, ah
1BFC  8B F8           mov di, ax
1BFE  80 BD B9 DC 00  cmp byte ptr [di - 0x2347], 0
1C03  75 05           jne 0x1c0a
1C05  E8 43 F8        call 0x144b
1C08  EB 19           jmp 0x1c23
loc_1C0A:
1C0A  C4 7E FA        les di, ptr [bp - 6]
1C0D  26 8A 45 04     mov al, byte ptr es:[di + 4]
1C11  30 E4           xor ah, ah
1C13  8B F8           mov di, ax
1C15  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
1C19  30 E4           xor ah, ah
1C1B  50              push ax
1C1C  6A 01           push 1
1C1E  9A 5A 34 55 1B  call far 1B55:345A
loc_1C23:
1C23  C4 7E FA        les di, ptr [bp - 6]
1C26  26 8A 45 04     mov al, byte ptr es:[di + 4]
1C2A  30 E4           xor ah, ah
1C2C  8B F8           mov di, ax
1C2E  80 BD B9 DC 00  cmp byte ptr [di - 0x2347], 0
1C33  75 11           jne 0x1c46
1C35  BF 5E 14        mov di, 0x145e
1C38  1E              push ds
1C39  57              push di
1C3A  BF 5C DD        mov di, 0xdd5c
1C3D  1E              push ds
1C3E  57              push di
1C3F  9A 2F 05 2A 23  call far 232A:052F
1C44  EB 0F           jmp 0x1c55
loc_1C46:
1C46  BF 2E 13        mov di, 0x132e
1C49  1E              push ds
1C4A  57              push di
1C4B  BF 5C DD        mov di, 0xdd5c
1C4E  1E              push ds
1C4F  57              push di
1C50  9A 2F 05 2A 23  call far 232A:052F
loc_1C55:
1C55  BF E0 00        mov di, 0xe0
1C58  1E              push ds
1C59  57              push di
1C5A  6A 12           push 0x12
1C5C  9A 8B 0F 2A 23  call far 232A:0F8B
1C61  80 3E 88 DE 20  cmp byte ptr [0xde88], 0x20
1C66  75 0A           jne 0x1c72
1C68  C6 06 E0 00 03  mov byte ptr [0xe0], 3
1C6D  C6 06 88 DE 02  mov byte ptr [0xde88], 2
loc_1C72:
1C72  80 3E E0 00 02  cmp byte ptr [0xe0], 2
1C77  75 16           jne 0x1c8f
1C79  C4 7E FA        les di, ptr [bp - 6]
1C7C  26 80 7D 04 02  cmp byte ptr es:[di + 4], 2
1C81  74 0C           je 0x1c8f
1C83  A0 88 DE        mov al, byte ptr [0xde88]
1C86  50              push ax
1C87  9A 83 07 2A 23  call far 232A:0783
1C8C  E9 EE 01        jmp 0x1e7d
loc_1C8F:
1C8F  80 3E 88 DE D2  cmp byte ptr [0xde88], 0xd2
1C94  75 08           jne 0x1c9e
1C96  9A 40 0E 55 1B  call far 1B55:0E40
1C9B  E9 DF 01        jmp 0x1e7d
loc_1C9E:
1C9E  80 3E 88 DE CF  cmp byte ptr [0xde88], 0xcf
1CA3  75 08           jne 0x1cad
1CA5  9A E2 0D 55 1B  call far 1B55:0DE2
1CAA  E9 D0 01        jmp 0x1e7d
loc_1CAD:
1CAD  80 3E 88 DE 0D  cmp byte ptr [0xde88], 0xd
1CB2  75 08           jne 0x1cbc
1CB4  9A 08 31 55 1B  call far 1B55:3108
1CB9  E9 C1 01        jmp 0x1e7d
loc_1CBC:
1CBC  A0 88 DE        mov al, byte ptr [0xde88]
1CBF  50              push ax
1CC0  9A 86 19 C9 26  call far 26C9:1986
1CC5  3C 54           cmp al, 0x54
1CC7  75 2C           jne 0x1cf5
1CC9  C4 7E FA        les di, ptr [bp - 6]
1CCC  26 8A 45 04     mov al, byte ptr es:[di + 4]
1CD0  30 E4           xor ah, ah
1CD2  8B F8           mov di, ax
1CD4  80 BD B9 DC 00  cmp byte ptr [di - 0x2347], 0
1CD9  74 1A           je 0x1cf5
1CDB  C4 7E FA        les di, ptr [bp - 6]
1CDE  26 8A 45 04     mov al, byte ptr es:[di + 4]
1CE2  30 E4           xor ah, ah
1CE4  8B F8           mov di, ax
1CE6  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
1CEA  30 E4           xor ah, ah
1CEC  50              push ax
1CED  9A 6F 96 B9 0A  call far 0AB9:966F
1CF2  E9 88 01        jmp 0x1e7d
loc_1CF5:
1CF5  80 3E 88 DE 02  cmp byte ptr [0xde88], 2
1CFA  74 03           je 0x1cff
1CFC  E9 7E 01        jmp 0x1e7d
loc_1CFF:
1CFF  A0 E0 00        mov al, byte ptr [0xe0]
1D02  3C 01           cmp al, 1
1D04  75 35           jne 0x1d3b
1D06  C4 7E FA        les di, ptr [bp - 6]
1D09  26 80 7D 03 01  cmp byte ptr es:[di + 3], 1
1D0E  74 07           je 0x1d17
1D10  26 80 7D 04 02  cmp byte ptr es:[di + 4], 2
1D15  75 1A           jne 0x1d31
loc_1D17:
1D17  9A 08 4D EF 01  call far 01EF:4D08
1D1C  C4 3E D2 D7     les di, ptr [0xd7d2]
1D20  26 80 BD F4 00 00 cmp byte ptr es:[di + 0xf4], 0
1D26  74 07           je 0x1d2f
1D28  6A CF           push -0x31
1D2A  9A 83 07 2A 23  call far 232A:0783
loc_1D2F:
1D2F  EB 07           jmp 0x1d38
loc_1D31:
1D31  C4 7E FA        les di, ptr [bp - 6]
1D34  26 FE 45 04     inc byte ptr es:[di + 4]
loc_1D38:
1D38  E9 42 01        jmp 0x1e7d
loc_1D3B:
1D3B  3C 02           cmp al, 2
1D3D  75 0F           jne 0x1d4e
1D3F  C4 7E FA        les di, ptr [bp - 6]
1D42  26 FE 4D 04     dec byte ptr es:[di + 4]
1D46  C6 06 E0 00 01  mov byte ptr [0xe0], 1
1D4B  E9 2F 01        jmp 0x1e7d
loc_1D4E:
1D4E  3C 03           cmp al, 3
1D50  75 1C           jne 0x1d6e
1D52  C4 7E FA        les di, ptr [bp - 6]
1D55  26 8A 45 04     mov al, byte ptr es:[di + 4]
1D59  30 E4           xor ah, ah
1D5B  8B F8           mov di, ax
1D5D  80 BD B9 DC 00  cmp byte ptr [di - 0x2347], 0
1D62  74 07           je 0x1d6b
1D64  6A 01           push 1
1D66  9A F0 CB B9 0A  call far 0AB9:CBF0
loc_1D6B:
1D6B  E9 0F 01        jmp 0x1e7d
loc_1D6E:
1D6E  3C 04           cmp al, 4
1D70  75 4B           jne 0x1dbd
1D72  C4 7E FA        les di, ptr [bp - 6]
1D75  26 8A 45 04     mov al, byte ptr es:[di + 4]
1D79  30 E4           xor ah, ah
1D7B  8B F8           mov di, ax
1D7D  80 BD B9 DC 00  cmp byte ptr [di - 0x2347], 0
1D82  74 36           je 0x1dba
1D84  C4 7E FA        les di, ptr [bp - 6]
1D87  26 8A 45 04     mov al, byte ptr es:[di + 4]
1D8B  30 E4           xor ah, ah
1D8D  8B F8           mov di, ax
1D8F  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
1D93  30 E4           xor ah, ah
1D95  50              push ax
1D96  C4 7E FA        les di, ptr [bp - 6]
1D99  26 8A 05        mov al, byte ptr es:[di]
1D9C  30 E4           xor ah, ah
1D9E  40              inc ax
1D9F  50              push ax
1DA0  9A DF 40 55 1B  call far 1B55:40DF
1DA5  50              push ax
1DA6  BF 40 1B        mov di, 0x1b40
1DA9  0E              push cs
1DAA  57              push di
1DAB  9A 98 00 2A 23  call far 232A:0098
1DB0  08 C0           or al, al
1DB2  75 06           jne 0x1dba
1DB4  6A 04           push 4
1DB6  0E              push cs
1DB7  E8 E7 E9        call 0x7a1
loc_1DBA:
1DBA  E9 C0 00        jmp 0x1e7d
loc_1DBD:
1DBD  3C 05           cmp al, 5
1DBF  75 08           jne 0x1dc9
1DC1  9A A4 0E EF 01  call far 01EF:0EA4
1DC6  E9 B4 00        jmp 0x1e7d
loc_1DC9:
1DC9  3C 06           cmp al, 6
1DCB  75 08           jne 0x1dd5
1DCD  9A 69 15 EF 01  call far 01EF:1569
1DD2  E9 A8 00        jmp 0x1e7d
loc_1DD5:
1DD5  3C 07           cmp al, 7
1DD7  75 1A           jne 0x1df3
1DD9  C4 7E FA        les di, ptr [bp - 6]
1DDC  26 8A 45 04     mov al, byte ptr es:[di + 4]
1DE0  30 E4           xor ah, ah
1DE2  8B F8           mov di, ax
1DE4  80 BD B9 DC 00  cmp byte ptr [di - 0x2347], 0
1DE9  74 05           je 0x1df0
1DEB  9A 24 35 EF 01  call far 01EF:3524
loc_1DF0:
1DF0  E9 8A 00        jmp 0x1e7d
loc_1DF3:
1DF3  3C 08           cmp al, 8
1DF5  75 09           jne 0x1e00
1DF7  6A 01           push 1
1DF9  9A 43 47 EF 01  call far 01EF:4743
1DFE  EB 7D           jmp 0x1e7d
loc_1E00:
1E00  3C 09           cmp al, 9
1E02  75 12           jne 0x1e16
1E04  C4 7E FA        les di, ptr [bp - 6]
1E07  26 8A 05        mov al, byte ptr es:[di]
1E0A  30 E4           xor ah, ah
1E0C  50              push ax
1E0D  6A 00           push 0
1E0F  9A E3 3E EF 01  call far 01EF:3EE3
1E14  EB 67           jmp 0x1e7d
loc_1E16:
1E16  3C 0A           cmp al, 0xa
1E18  75 07           jne 0x1e21
1E1A  9A DB 48 EF 01  call far 01EF:48DB
1E1F  EB 5C           jmp 0x1e7d
loc_1E21:
1E21  3C 0B           cmp al, 0xb
1E23  75 11           jne 0x1e36
1E25  C4 7E FA        les di, ptr [bp - 6]
1E28  26 8A 05        mov al, byte ptr es:[di]
1E2B  30 E4           xor ah, ah
1E2D  40              inc ax
1E2E  50              push ax
1E2F  9A D7 42 55 1B  call far 1B55:42D7
1E34  EB 47           jmp 0x1e7d
loc_1E36:
1E36  3C 0C           cmp al, 0xc
1E38  75 08           jne 0x1e42
1E3A  6A 02           push 2
1E3C  0E              push cs
1E3D  E8 61 E9        call 0x7a1
1E40  EB 3B           jmp 0x1e7d
loc_1E42:
1E42  3C 0D           cmp al, 0xd
1E44  75 07           jne 0x1e4d
1E46  9A 7A 1D EF 01  call far 01EF:1D7A
1E4B  EB 30           jmp 0x1e7d
loc_1E4D:
1E4D  3C 0E           cmp al, 0xe
1E4F  75 05           jne 0x1e56
1E51  E8 27 F1        call 0xf7b
1E54  EB 27           jmp 0x1e7d
loc_1E56:
1E56  3C 0F           cmp al, 0xf
1E58  75 05           jne 0x1e5f
1E5A  E8 0A FC        call 0x1a67
1E5D  EB 1E           jmp 0x1e7d
loc_1E5F:
1E5F  3C 10           cmp al, 0x10
1E61  75 08           jne 0x1e6b
1E63  6A 05           push 5
1E65  0E              push cs
1E66  E8 38 E9        call 0x7a1
1E69  EB 12           jmp 0x1e7d
loc_1E6B:
1E6B  3C 11           cmp al, 0x11
1E6D  75 05           jne 0x1e74
1E6F  E8 4D F2        call 0x10bf
1E72  EB 09           jmp 0x1e7d
loc_1E74:
1E74  3C 12           cmp al, 0x12
1E76  75 05           jne 0x1e7d
1E78  9A EF 38 55 1B  call far 1B55:38EF
loc_1E7D:
1E7D  E9 E0 FC        jmp 0x1b60
; data (not reached as code), 2 bytes
1E80                  db C9 CB   ; ..

; ---- routine 0006:1E82  (found by: far)
sub_1E82:
1E82  55              push bp
1E83  89 E5           mov bp, sp
1E85  C9              leave
1E86  CB              retf
; data (not reached as code), 9 bytes
1E87                  db 00 00 00 00 00 00 00 00 00   ; .........
