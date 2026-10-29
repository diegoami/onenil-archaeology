; 1-0.EXE (One-Nil 96), code segment 1B55 (image offsets 1B550..2315F), part 3 of 12
; packed 1-0.EXE sha256 89ff9c5f238f24e81a0c2440a46cdd8997280a65fc3cc3d97cb974f55280a80a (LZEXE 0.91)
; unpacked (tools/static/unlzexe.py) sha256 887ed2a92767950e5309b2052409f875668605939b69e00737aa3047022b9f51
; tool: capstone 5.0.9 (pip package; core library 5.0.1280) (CS_ARCH_X86, CS_MODE_16), recursive descent from the entry point, far calls and near calls/jumps, then routine prologues (55 89 E5 / 55 8B EC / C8 iw 00) in what remains; tools/static/listing.py
; addresses are SEGMENT:OFFSET with SEGMENT the image paragraph before relocation; image offset = SEGMENT*16+OFFSET
; ---- routine 1B55:1542  (found by: call, far)
sub_1542:
1542  C8 02 01 00     enter 0x102, 0
1546  8A 46 0A        mov al, byte ptr [bp + 0xa]
1549  50              push ax
154A  8D 7E FE        lea di, [bp - 2]
154D  16              push ss
154E  57              push di
154F  9A E3 01 2A 23  call far 232A:01E3
1554  8A 46 FE        mov al, byte ptr [bp - 2]
1557  3A 46 FF        cmp al, byte ptr [bp - 1]
155A  74 19           je 0x1575
155C  8A 46 FE        mov al, byte ptr [bp - 2]
155F  3A 46 FF        cmp al, byte ptr [bp - 1]
1562  B0 00           mov al, 0
1564  76 01           jbe 0x1567
1566  40              inc ax
loc_1567:
1567  98              cwde
1568  8B F8           mov di, ax
156A  8A 85 E0 0F     mov al, byte ptr [di + 0xfe0]
156E  30 E4           xor ah, ah
1570  A3 64 DD        mov word ptr [0xdd64], ax
1573  EB 06           jmp 0x157b
loc_1575:
1575  C7 06 64 DD 06 00 mov word ptr [0xdd64], 6
loc_157B:
157B  8D BE FE FE     lea di, [bp - 0x102]
157F  16              push ss
1580  57              push di
1581  8A 46 FE        mov al, byte ptr [bp - 2]
1584  30 E4           xor ah, ah
1586  31 D2           xor dx, dx
1588  52              push dx
1589  50              push ax
158A  9A C9 07 2A 23  call far 232A:07C9
158F  8A 46 08        mov al, byte ptr [bp + 8]
1592  50              push ax
1593  8A 46 06        mov al, byte ptr [bp + 6]
1596  50              push ax
1597  BF 5C DD        mov di, 0xdd5c
159A  1E              push ds
159B  57              push di
159C  9A 83 02 2A 23  call far 232A:0283
15A1  8D BE FE FE     lea di, [bp - 0x102]
15A5  16              push ss
15A6  57              push di
15A7  8A 46 FF        mov al, byte ptr [bp - 1]
15AA  30 E4           xor ah, ah
15AC  31 D2           xor dx, dx
15AE  52              push dx
15AF  50              push ax
15B0  9A C9 07 2A 23  call far 232A:07C9
15B5  8A 46 08        mov al, byte ptr [bp + 8]
15B8  50              push ax
15B9  8B 46 06        mov ax, word ptr [bp + 6]
15BC  40              inc ax
15BD  40              inc ax
15BE  50              push ax
15BF  BF 5C DD        mov di, 0xdd5c
15C2  1E              push ds
15C3  57              push di
15C4  9A 9D 03 2A 23  call far 232A:039D
15C9  C9              leave
15CA  CA 06 00        retf 6
; data (not reached as code), 2 bytes
15CD                  db 01 FB   ; ..

; ---- routine 1B55:15CF  (found by: call)
sub_15CF:
15CF  55              push bp
15D0  89 E5           mov bp, sp
15D2  8B 46 08        mov ax, word ptr [bp + 8]
15D5  8B F0           mov si, ax
15D7  D1 E0           shl ax, 1
15D9  01 F0           add ax, si
15DB  8B D0           mov dx, ax
15DD  69 46 0A AE 00  imul ax, word ptr [bp + 0xa], 0xae
15E2  C4 3E CA D7     les di, ptr [0xd7ca]
15E6  03 F8           add di, ax
15E8  03 FA           add di, dx
15EA  26 8A 85 51 FF  mov al, byte ptr es:[di - 0xaf]
15EF  24 F0           and al, 0xf0
15F1  30 E4           xor ah, ah
15F3  C1 E8 04        shr ax, 4
15F6  3D 08 00        cmp ax, 8
15F9  75 1B           jne 0x1616
15FB  BF CD 15        mov di, 0x15cd
15FE  0E              push cs
15FF  57              push di
1600  8A 46 06        mov al, byte ptr [bp + 6]
1603  50              push ax
1604  8B 46 04        mov ax, word ptr [bp + 4]
1607  48              dec ax
1608  48              dec ax
1609  50              push ax
160A  BF 5C DD        mov di, 0xdd5c
160D  1E              push ds
160E  57              push di
160F  9A 9D 03 2A 23  call far 232A:039D
1614  EB 61           jmp 0x1677
loc_1616:
1616  8B 46 08        mov ax, word ptr [bp + 8]
1619  8B F0           mov si, ax
161B  D1 E0           shl ax, 1
161D  01 F0           add ax, si
161F  8B C8           mov cx, ax
1621  8B 46 08        mov ax, word ptr [bp + 8]
1624  8B F0           mov si, ax
1626  D1 E0           shl ax, 1
1628  01 F0           add ax, si
162A  8B D0           mov dx, ax
162C  69 46 0A AE 00  imul ax, word ptr [bp + 0xa], 0xae
1631  C4 3E CA D7     les di, ptr [0xd7ca]
1635  03 F8           add di, ax
1637  03 FA           add di, dx
1639  26 8A 85 50 FF  mov al, byte ptr es:[di - 0xb0]
163E  30 E4           xor ah, ah
1640  69 C0 AE 00     imul ax, ax, 0xae
1644  C4 3E CA D7     les di, ptr [0xd7ca]
1648  03 F8           add di, ax
164A  03 F9           add di, cx
164C  26 8A 85 51 FF  mov al, byte ptr es:[di - 0xaf]
1651  24 F0           and al, 0xf0
1653  30 E4           xor ah, ah
1655  C1 E8 04        shr ax, 4
1658  3D 08 00        cmp ax, 8
165B  75 1A           jne 0x1677
165D  BF CD 15        mov di, 0x15cd
1660  0E              push cs
1661  57              push di
1662  8A 46 06        mov al, byte ptr [bp + 6]
1665  50              push ax
1666  8B 46 04        mov ax, word ptr [bp + 4]
1669  05 04 00        add ax, 4
166C  50              push ax
166D  BF 5C DD        mov di, 0xdd5c
1670  1E              push ds
1671  57              push di
1672  9A 9D 03 2A 23  call far 232A:039D
loc_1677:
1677  C9              leave
1678  C2 08 00        ret 8
; data (not reached as code), 2 bytes
167B                  db 01 76   ; .v

; ---- routine 1B55:167D  (found by: call, far)
sub_167D:
167D  55              push bp
167E  89 E5           mov bp, sp
1680  FF 76 0C        push word ptr [bp + 0xc]
1683  FF 76 08        push word ptr [bp + 8]
1686  8B 46 06        mov ax, word ptr [bp + 6]
1689  2D 03 00        sub ax, 3
168C  50              push ax
168D  0E              push cs
168E  E8 AA F8        call 0xf3b
1691  8B 46 0A        mov ax, word ptr [bp + 0xa]
1694  8B F0           mov si, ax
1696  D1 E0           shl ax, 1
1698  01 F0           add ax, si
169A  8B D0           mov dx, ax
169C  69 46 0C AE 00  imul ax, word ptr [bp + 0xc], 0xae
16A1  C4 3E CA D7     les di, ptr [0xd7ca]
16A5  03 F8           add di, ax
16A7  03 FA           add di, dx
16A9  26 8A 85 50 FF  mov al, byte ptr es:[di - 0xb0]
16AE  30 E4           xor ah, ah
16B0  50              push ax
16B1  FF 76 08        push word ptr [bp + 8]
16B4  8B 46 06        mov ax, word ptr [bp + 6]
16B7  05 05 00        add ax, 5
16BA  50              push ax
16BB  0E              push cs
16BC  E8 24 F8        call 0xee3
16BF  6A 05           push 5
16C1  BF 7B 16        mov di, 0x167b
16C4  0E              push cs
16C5  57              push di
16C6  8A 46 08        mov al, byte ptr [bp + 8]
16C9  50              push ax
16CA  8B 46 06        mov ax, word ptr [bp + 6]
16CD  40              inc ax
16CE  50              push ax
16CF  BF 5C DD        mov di, 0xdd5c
16D2  1E              push ds
16D3  57              push di
16D4  9A 1B 04 2A 23  call far 232A:041B
16D9  8B 46 0A        mov ax, word ptr [bp + 0xa]
16DC  8B F0           mov si, ax
16DE  D1 E0           shl ax, 1
16E0  01 F0           add ax, si
16E2  8B D0           mov dx, ax
16E4  69 46 0C AE 00  imul ax, word ptr [bp + 0xc], 0xae
16E9  C4 3E CA D7     les di, ptr [0xd7ca]
16ED  03 F8           add di, ax
16EF  03 FA           add di, dx
16F1  26 8A 85 51 FF  mov al, byte ptr es:[di - 0xaf]
16F6  24 F0           and al, 0xf0
16F8  30 E4           xor ah, ah
16FA  C1 E8 04        shr ax, 4
16FD  3D 01 00        cmp ax, 1
1700  7E 2F           jle 0x1731
1702  8B 56 0A        mov dx, word ptr [bp + 0xa]
1705  6B 46 0C 3A     imul ax, word ptr [bp + 0xc], 0x3a
1709  C4 3E CE D7     les di, ptr [0xd7ce]
170D  03 F8           add di, ax
170F  03 FA           add di, dx
1711  26 8A 45 C5     mov al, byte ptr es:[di - 0x3b]
1715  30 E4           xor ah, ah
1717  50              push ax
1718  FF 76 08        push word ptr [bp + 8]
171B  FF 76 06        push word ptr [bp + 6]
171E  0E              push cs
171F  E8 20 FE        call 0x1542
1722  FF 76 0C        push word ptr [bp + 0xc]
1725  FF 76 0A        push word ptr [bp + 0xa]
1728  FF 76 08        push word ptr [bp + 8]
172B  FF 76 06        push word ptr [bp + 6]
172E  E8 9E FE        call 0x15cf
loc_1731:
1731  C9              leave
1732  CA 08 00        retf 8

; ---- routine 1B55:1735  (found by: call, far)
sub_1735:
1735  C8 04 00 00     enter 4, 0
1739  8B 56 06        mov dx, word ptr [bp + 6]
173C  6B 46 08 3A     imul ax, word ptr [bp + 8], 0x3a
1740  C4 3E CE D7     les di, ptr [0xd7ce]
1744  03 F8           add di, ax
1746  03 FA           add di, dx
1748  26 8A 45 C5     mov al, byte ptr es:[di - 0x3b]
174C  50              push ax
174D  8D 7E FC        lea di, [bp - 4]
1750  16              push ss
1751  57              push di
1752  9A E3 01 2A 23  call far 232A:01E3
1757  8A 46 FC        mov al, byte ptr [bp - 4]
175A  3A 46 FD        cmp al, byte ptr [bp - 3]
175D  77 2D           ja 0x178c
175F  8B 46 06        mov ax, word ptr [bp + 6]
1762  8B F0           mov si, ax
1764  D1 E0           shl ax, 1
1766  01 F0           add ax, si
1768  8B D0           mov dx, ax
176A  69 46 08 AE 00  imul ax, word ptr [bp + 8], 0xae
176F  C4 3E CA D7     les di, ptr [0xd7ca]
1773  03 F8           add di, ax
1775  03 FA           add di, dx
1777  26 8A 85 51 FF  mov al, byte ptr es:[di - 0xaf]
177C  24 F0           and al, 0xf0
177E  30 E4           xor ah, ah
1780  C1 E8 04        shr ax, 4
1783  3D 08 00        cmp ax, 8
1786  74 04           je 0x178c
1788  B0 00           mov al, 0
178A  EB 02           jmp 0x178e
loc_178C:
178C  B0 01           mov al, 1
loc_178E:
178E  88 46 FF        mov byte ptr [bp - 1], al
1791  8A 46 FF        mov al, byte ptr [bp - 1]
1794  C9              leave
1795  CA 04 00        retf 4

; ---- routine 1B55:1798  (found by: far)
sub_1798:
1798  C8 02 00 00     enter 2, 0
179C  8B 7E 06        mov di, word ptr [bp + 6]
179F  80 BD 6A A2 05  cmp byte ptr [di - 0x5d96], 5
17A4  75 0C           jne 0x17b2
17A6  83 7E 06 16     cmp word ptr [bp + 6], 0x16
17AA  76 06           jbe 0x17b2
17AC  83 7E 06 39     cmp word ptr [bp + 6], 0x39
17B0  72 04           jb 0x17b6
loc_17B2:
17B2  B0 00           mov al, 0
17B4  EB 02           jmp 0x17b8
loc_17B6:
17B6  B0 01           mov al, 1
loc_17B8:
17B8  88 46 FF        mov byte ptr [bp - 1], al
17BB  8A 46 FF        mov al, byte ptr [bp - 1]
17BE  C9              leave
17BF  CA 02 00        retf 2

; ---- routine 1B55:17C2  (found by: far)
sub_17C2:
17C2  C8 04 00 00     enter 4, 0
17C6  8B 56 06        mov dx, word ptr [bp + 6]
17C9  6B 46 08 3A     imul ax, word ptr [bp + 8], 0x3a
17CD  C4 3E CE D7     les di, ptr [0xd7ce]
17D1  03 F8           add di, ax
17D3  03 FA           add di, dx
17D5  26 8A 45 C5     mov al, byte ptr es:[di - 0x3b]
17D9  50              push ax
17DA  8D 7E FC        lea di, [bp - 4]
17DD  16              push ss
17DE  57              push di
17DF  9A E3 01 2A 23  call far 232A:01E3
17E4  8A 46 FC        mov al, byte ptr [bp - 4]
17E7  3A 46 FD        cmp al, byte ptr [bp - 3]
17EA  B0 00           mov al, 0
17EC  75 01           jne 0x17ef
17EE  40              inc ax
loc_17EF:
17EF  88 46 FF        mov byte ptr [bp - 1], al
17F2  8A 46 FF        mov al, byte ptr [bp - 1]
17F5  C9              leave
17F6  CA 04 00        retf 4

; ---- routine 1B55:17F9  (found by: call, far)
sub_17F9:
17F9  C8 02 00 00     enter 2, 0
17FD  8B 56 0C        mov dx, word ptr [bp + 0xc]
1800  6B 46 0E 3A     imul ax, word ptr [bp + 0xe], 0x3a
1804  C4 3E CE D7     les di, ptr [0xd7ce]
1808  03 F8           add di, ax
180A  03 FA           add di, dx
180C  26 8A 45 C5     mov al, byte ptr es:[di - 0x3b]
1810  50              push ax
1811  8D 7E FE        lea di, [bp - 2]
1814  16              push ss
1815  57              push di
1816  9A E3 01 2A 23  call far 232A:01E3
181B  8A 46 FE        mov al, byte ptr [bp - 2]
181E  C4 7E 06        les di, ptr [bp + 6]
1821  26 88 05        mov byte ptr es:[di], al
1824  8A 46 FF        mov al, byte ptr [bp - 1]
1827  26 88 45 01     mov byte ptr es:[di + 1], al
182B  8B 56 0A        mov dx, word ptr [bp + 0xa]
182E  6B 46 0E 3A     imul ax, word ptr [bp + 0xe], 0x3a
1832  C4 3E CE D7     les di, ptr [0xd7ce]
1836  03 F8           add di, ax
1838  03 FA           add di, dx
183A  26 8A 45 C5     mov al, byte ptr es:[di - 0x3b]
183E  50              push ax
183F  8D 7E FE        lea di, [bp - 2]
1842  16              push ss
1843  57              push di
1844  9A E3 01 2A 23  call far 232A:01E3
1849  8A 46 FE        mov al, byte ptr [bp - 2]
184C  C4 7E 06        les di, ptr [bp + 6]
184F  26 00 05        add byte ptr es:[di], al
1852  8A 46 FF        mov al, byte ptr [bp - 1]
1855  26 00 45 01     add byte ptr es:[di + 1], al
1859  C9              leave
185A  CA 0A 00        retf 0xa

; ---- routine 1B55:185D  (found by: call)
sub_185D:
185D  C8 04 00 00     enter 4, 0
1861  FF 76 0C        push word ptr [bp + 0xc]
1864  FF 76 0A        push word ptr [bp + 0xa]
1867  FF 76 08        push word ptr [bp + 8]
186A  8D 7E FE        lea di, [bp - 2]
186D  16              push ss
186E  57              push di
186F  0E              push cs
1870  E8 86 FF        call 0x17f9
1873  FF 76 FE        push word ptr [bp - 2]
1876  8D 7E FD        lea di, [bp - 3]
1879  16              push ss
187A  57              push di
187B  9A C5 01 2A 23  call far 232A:01C5
1880  8A 46 FD        mov al, byte ptr [bp - 3]
1883  30 E4           xor ah, ah
1885  50              push ax
1886  FF 76 06        push word ptr [bp + 6]
1889  FF 76 04        push word ptr [bp + 4]
188C  0E              push cs
188D  E8 B2 FC        call 0x1542
1890  FF 76 0C        push word ptr [bp + 0xc]
1893  FF 76 08        push word ptr [bp + 8]
1896  FF 76 06        push word ptr [bp + 6]
1899  FF 76 04        push word ptr [bp + 4]
189C  E8 30 FD        call 0x15cf
189F  C9              leave
18A0  C2 0A 00        ret 0xa
; data (not reached as code), 24 bytes
18A3                  pstr '1st leg:  v'
18AF                  pstr '2nd leg:  v'

; ---- routine 1B55:18BB  (found by: far)
sub_18BB:
18BB  C8 04 00 00     enter 4, 0
18BF  8B 46 0E        mov ax, word ptr [bp + 0xe]
18C2  8B F0           mov si, ax
18C4  D1 E0           shl ax, 1
18C6  01 F0           add ax, si
18C8  8B D0           mov dx, ax
18CA  69 46 10 AE 00  imul ax, word ptr [bp + 0x10], 0xae
18CF  C4 3E CA D7     les di, ptr [0xd7ca]
18D3  03 F8           add di, ax
18D5  03 FA           add di, dx
18D7  81 C7 4F FF     add di, 0xff4f
18DB  89 7E FC        mov word ptr [bp - 4], di
18DE  8C 46 FE        mov word ptr [bp - 2], es
18E1  C4 7E 08        les di, ptr [bp + 8]
18E4  26 FF 05        inc word ptr es:[di]
18E7  6A 05           push 5
18E9  BF A3 18        mov di, 0x18a3
18EC  0E              push cs
18ED  57              push di
18EE  C4 7E 08        les di, ptr [bp + 8]
18F1  26 8A 05        mov al, byte ptr es:[di]
18F4  50              push ax
18F5  8B 46 06        mov ax, word ptr [bp + 6]
18F8  2D 11 00        sub ax, 0x11
18FB  50              push ax
18FC  BF 5C DD        mov di, 0xdd5c
18FF  1E              push ds
1900  57              push di
1901  9A 1B 04 2A 23  call far 232A:041B
1906  BF AF 18        mov di, 0x18af
1909  0E              push cs
190A  57              push di
190B  C4 7E 08        les di, ptr [bp + 8]
190E  26 8A 05        mov al, byte ptr es:[di]
1911  50              push ax
1912  8A 46 06        mov al, byte ptr [bp + 6]
1915  50              push ax
1916  BF 5C DD        mov di, 0xdd5c
1919  1E              push ds
191A  57              push di
191B  9A 9D 03 2A 23  call far 232A:039D
1920  C4 7E FC        les di, ptr [bp - 4]
1923  26 8A 45 02     mov al, byte ptr es:[di + 2]
1927  24 F0           and al, 0xf0
1929  30 E4           xor ah, ah
192B  C1 E8 04        shr ax, 4
192E  3D 01 00        cmp ax, 1
1931  7E 27           jle 0x195a
1933  8B 56 0E        mov dx, word ptr [bp + 0xe]
1936  6B 46 10 3A     imul ax, word ptr [bp + 0x10], 0x3a
193A  C4 3E CE D7     les di, ptr [0xd7ce]
193E  03 F8           add di, ax
1940  03 FA           add di, dx
1942  26 8A 45 C5     mov al, byte ptr es:[di - 0x3b]
1946  30 E4           xor ah, ah
1948  50              push ax
1949  C4 7E 08        les di, ptr [bp + 8]
194C  26 FF 35        push word ptr es:[di]
194F  8B 46 06        mov ax, word ptr [bp + 6]
1952  2D 08 00        sub ax, 8
1955  50              push ax
1956  0E              push cs
1957  E8 E8 FB        call 0x1542
loc_195A:
195A  8B 46 0C        mov ax, word ptr [bp + 0xc]
195D  8B F0           mov si, ax
195F  D1 E0           shl ax, 1
1961  01 F0           add ax, si
1963  8B D0           mov dx, ax
1965  69 46 10 AE 00  imul ax, word ptr [bp + 0x10], 0xae
196A  C4 3E CA D7     les di, ptr [0xd7ca]
196E  03 F8           add di, ax
1970  03 FA           add di, dx
1972  26 8A 85 51 FF  mov al, byte ptr es:[di - 0xaf]
1977  24 F0           and al, 0xf0
1979  30 E4           xor ah, ah
197B  C1 E8 04        shr ax, 4
197E  3D 01 00        cmp ax, 1
1981  7E 46           jle 0x19c9
1983  8B 56 0C        mov dx, word ptr [bp + 0xc]
1986  C4 7E FC        les di, ptr [bp - 4]
1989  26 8A 45 01     mov al, byte ptr es:[di + 1]
198D  30 E4           xor ah, ah
198F  6B C0 3A        imul ax, ax, 0x3a
1992  C4 3E CE D7     les di, ptr [0xd7ce]
1996  03 F8           add di, ax
1998  03 FA           add di, dx
199A  26 8A 45 C5     mov al, byte ptr es:[di - 0x3b]
199E  30 E4           xor ah, ah
19A0  50              push ax
19A1  C4 7E 08        les di, ptr [bp + 8]
19A4  26 FF 35        push word ptr es:[di]
19A7  8B 46 06        mov ax, word ptr [bp + 6]
19AA  05 09 00        add ax, 9
19AD  50              push ax
19AE  0E              push cs
19AF  E8 90 FB        call 0x1542
19B2  FF 76 10        push word ptr [bp + 0x10]
19B5  FF 76 0E        push word ptr [bp + 0xe]
19B8  FF 76 0C        push word ptr [bp + 0xc]
19BB  C4 7E 08        les di, ptr [bp + 8]
19BE  26 8B 05        mov ax, word ptr es:[di]
19C1  48              dec ax
19C2  50              push ax
19C3  FF 76 06        push word ptr [bp + 6]
19C6  E8 94 FE        call 0x185d
loc_19C9:
19C9  C9              leave
19CA  CA 0C 00        retf 0xc

; ---- routine 1B55:19CD  (found by: call)
sub_19CD:
19CD  C8 06 00 00     enter 6, 0
19D1  8B 7E 04        mov di, word ptr [bp + 4]
19D4  36 8B 45 08     mov ax, word ptr ss:[di + 8]
19D8  8B F0           mov si, ax
19DA  D1 E0           shl ax, 1
19DC  01 F0           add ax, si
19DE  8B D0           mov dx, ax
19E0  36 69 45 0A AE 00 imul ax, word ptr ss:[di + 0xa], 0xae
19E6  C4 3E CA D7     les di, ptr [0xd7ca]
19EA  03 F8           add di, ax
19EC  03 FA           add di, dx
19EE  81 C7 4F FF     add di, 0xff4f
19F2  26 8A 45 02     mov al, byte ptr es:[di + 2]
19F6  24 0F           and al, 0xf
19F8  30 E4           xor ah, ah
19FA  3B 46 06        cmp ax, word ptr [bp + 6]
19FD  75 0C           jne 0x1a0b
19FF  8B 7E 04        mov di, word ptr [bp + 4]
1A02  36 8B 45 08     mov ax, word ptr ss:[di + 8]
1A06  89 46 FE        mov word ptr [bp - 2], ax
1A09  EB 0A           jmp 0x1a15
loc_1A0B:
1A0B  8B 7E 04        mov di, word ptr [bp + 4]
1A0E  36 8B 45 06     mov ax, word ptr ss:[di + 6]
1A12  89 46 FE        mov word ptr [bp - 2], ax
loc_1A15:
1A15  8B 46 FE        mov ax, word ptr [bp - 2]
1A18  C9              leave
1A19  C2 04 00        ret 4

; ---- routine 1B55:1A1C  (found by: call, far)
sub_1A1C:
1A1C  C8 04 00 00     enter 4, 0
1A20  FF 76 0A        push word ptr [bp + 0xa]
1A23  FF 76 08        push word ptr [bp + 8]
1A26  FF 76 06        push word ptr [bp + 6]
1A29  8D 7E FC        lea di, [bp - 4]
1A2C  16              push ss
1A2D  57              push di
1A2E  0E              push cs
1A2F  E8 C7 FD        call 0x17f9
1A32  8A 46 FC        mov al, byte ptr [bp - 4]
1A35  3A 46 FD        cmp al, byte ptr [bp - 3]
1A38  75 41           jne 0x1a7b
1A3A  6A 01           push 1
1A3C  55              push bp
1A3D  E8 8D FF        call 0x19cd
1A40  8B D0           mov dx, ax
1A42  6B 46 0A 3A     imul ax, word ptr [bp + 0xa], 0x3a
1A46  C4 3E CE D7     les di, ptr [0xd7ce]
1A4A  03 F8           add di, ax
1A4C  03 FA           add di, dx
1A4E  26 8A 45 C5     mov al, byte ptr es:[di - 0x3b]
1A52  24 F0           and al, 0xf0
1A54  30 E4           xor ah, ah
1A56  C1 E8 04        shr ax, 4
1A59  50              push ax
1A5A  6A 00           push 0
1A5C  55              push bp
1A5D  E8 6D FF        call 0x19cd
1A60  8B D0           mov dx, ax
1A62  6B 46 0A 3A     imul ax, word ptr [bp + 0xa], 0x3a
1A66  C4 3E CE D7     les di, ptr [0xd7ce]
1A6A  03 F8           add di, ax
1A6C  03 FA           add di, dx
1A6E  26 8A 45 C5     mov al, byte ptr es:[di - 0x3b]
1A72  24 0F           and al, 0xf
1A74  30 E4           xor ah, ah
1A76  5A              pop dx
1A77  3B C2           cmp ax, dx
1A79  74 04           je 0x1a7f
loc_1A7B:
1A7B  B0 00           mov al, 0
1A7D  EB 02           jmp 0x1a81
loc_1A7F:
1A7F  B0 01           mov al, 1
loc_1A81:
1A81  88 46 FF        mov byte ptr [bp - 1], al
1A84  8A 46 FF        mov al, byte ptr [bp - 1]
1A87  C9              leave
1A88  CA 06 00        retf 6

; ---- routine 1B55:1A8B  (found by: call)
sub_1A8B:
1A8B  C8 06 00 00     enter 6, 0
1A8F  8B 7E 04        mov di, word ptr [bp + 4]
1A92  36 8B 45 08     mov ax, word ptr ss:[di + 8]
1A96  8B F0           mov si, ax
1A98  D1 E0           shl ax, 1
1A9A  01 F0           add ax, si
1A9C  8B D0           mov dx, ax
1A9E  36 69 45 0A AE 00 imul ax, word ptr ss:[di + 0xa], 0xae
1AA4  C4 3E CA D7     les di, ptr [0xd7ca]
1AA8  03 F8           add di, ax
1AAA  03 FA           add di, dx
1AAC  81 C7 4F FF     add di, 0xff4f
1AB0  26 8A 45 02     mov al, byte ptr es:[di + 2]
1AB4  24 0F           and al, 0xf
1AB6  30 E4           xor ah, ah
1AB8  3B 46 06        cmp ax, word ptr [bp + 6]
1ABB  75 0C           jne 0x1ac9
1ABD  8B 7E 04        mov di, word ptr [bp + 4]
1AC0  36 8B 45 08     mov ax, word ptr ss:[di + 8]
1AC4  89 46 FE        mov word ptr [bp - 2], ax
1AC7  EB 0A           jmp 0x1ad3
loc_1AC9:
1AC9  8B 7E 04        mov di, word ptr [bp + 4]
1ACC  36 8B 45 06     mov ax, word ptr ss:[di + 6]
1AD0  89 46 FE        mov word ptr [bp - 2], ax
loc_1AD3:
1AD3  8B 46 FE        mov ax, word ptr [bp - 2]
1AD6  C9              leave
1AD7  C2 04 00        ret 4

; ---- routine 1B55:1ADA  (found by: call, far)
sub_1ADA:
1ADA  C8 04 00 00     enter 4, 0
1ADE  FF 76 0A        push word ptr [bp + 0xa]
1AE1  FF 76 08        push word ptr [bp + 8]
1AE4  FF 76 06        push word ptr [bp + 6]
1AE7  8D 7E FC        lea di, [bp - 4]
1AEA  16              push ss
1AEB  57              push di
1AEC  0E              push cs
1AED  E8 09 FD        call 0x17f9
1AF0  8A 46 FC        mov al, byte ptr [bp - 4]
1AF3  3A 46 FD        cmp al, byte ptr [bp - 3]
1AF6  76 03           jbe 0x1afb
1AF8  E9 87 00        jmp 0x1b82
loc_1AFB:
1AFB  8A 46 FC        mov al, byte ptr [bp - 4]
1AFE  3A 46 FD        cmp al, byte ptr [bp - 3]
1B01  75 41           jne 0x1b44
1B03  6A 01           push 1
1B05  55              push bp
1B06  E8 82 FF        call 0x1a8b
1B09  8B D0           mov dx, ax
1B0B  6B 46 0A 3A     imul ax, word ptr [bp + 0xa], 0x3a
1B0F  C4 3E CE D7     les di, ptr [0xd7ce]
1B13  03 F8           add di, ax
1B15  03 FA           add di, dx
1B17  26 8A 45 C5     mov al, byte ptr es:[di - 0x3b]
1B1B  24 F0           and al, 0xf0
1B1D  30 E4           xor ah, ah
1B1F  C1 E8 04        shr ax, 4
1B22  50              push ax
1B23  6A 00           push 0
1B25  55              push bp
1B26  E8 62 FF        call 0x1a8b
1B29  8B D0           mov dx, ax
1B2B  6B 46 0A 3A     imul ax, word ptr [bp + 0xa], 0x3a
1B2F  C4 3E CE D7     les di, ptr [0xd7ce]
1B33  03 F8           add di, ax
1B35  03 FA           add di, dx
1B37  26 8A 45 C5     mov al, byte ptr es:[di - 0x3b]
1B3B  24 0F           and al, 0xf
1B3D  30 E4           xor ah, ah
1B3F  5A              pop dx
1B40  3B C2           cmp ax, dx
1B42  7F 3E           jg 0x1b82
loc_1B44:
1B44  FF 76 0A        push word ptr [bp + 0xa]
1B47  FF 76 08        push word ptr [bp + 8]
1B4A  FF 76 06        push word ptr [bp + 6]
1B4D  0E              push cs
1B4E  E8 CB FE        call 0x1a1c
1B51  08 C0           or al, al
1B53  74 29           je 0x1b7e
1B55  8B 46 06        mov ax, word ptr [bp + 6]
1B58  8B F0           mov si, ax
1B5A  D1 E0           shl ax, 1
1B5C  01 F0           add ax, si
1B5E  8B D0           mov dx, ax
1B60  69 46 0A AE 00  imul ax, word ptr [bp + 0xa], 0xae
1B65  C4 3E CA D7     les di, ptr [0xd7ca]
1B69  03 F8           add di, ax
1B6B  03 FA           add di, dx
1B6D  26 8A 85 51 FF  mov al, byte ptr es:[di - 0xaf]
1B72  24 F0           and al, 0xf0
1B74  30 E4           xor ah, ah
1B76  C1 E8 04        shr ax, 4
1B79  3D 08 00        cmp ax, 8
1B7C  74 04           je 0x1b82
loc_1B7E:
1B7E  B0 00           mov al, 0
1B80  EB 02           jmp 0x1b84
loc_1B82:
1B82  B0 01           mov al, 1
loc_1B84:
1B84  88 46 FF        mov byte ptr [bp - 1], al
1B87  8A 46 FF        mov al, byte ptr [bp - 1]
1B8A  C9              leave
1B8B  CA 06 00        retf 6

; ---- routine 1B55:1B8E  (found by: call, far)
sub_1B8E:
1B8E  C8 02 00 00     enter 2, 0
1B92  8B 46 06        mov ax, word ptr [bp + 6]
1B95  C4 3E B6 D7     les di, ptr [0xd7b6]
1B99  03 F8           add di, ax
1B9B  26 8A 45 FF     mov al, byte ptr es:[di - 1]
1B9F  3A 06 D8 DC     cmp al, byte ptr [0xdcd8]
1BA3  B0 00           mov al, 0
1BA5  75 01           jne 0x1ba8
1BA7  40              inc ax
loc_1BA8:
1BA8  88 46 FF        mov byte ptr [bp - 1], al
1BAB  8A 46 FF        mov al, byte ptr [bp - 1]
1BAE  C9              leave
1BAF  CA 02 00        retf 2

; ---- routine 1B55:1BB2  (found by: call)
sub_1BB2:
1BB2  55              push bp
1BB3  89 E5           mov bp, sp
1BB5  8B 7E 04        mov di, word ptr [bp + 4]
1BB8  36 C7 45 FC 01 00 mov word ptr ss:[di - 4], 1
1BBE  36 C6 45 FB 01  mov byte ptr ss:[di - 5], 1
1BC3  36 80 7D 06 00  cmp byte ptr ss:[di + 6], 0
1BC8  75 02           jne 0x1bcc
1BCA  EB 2B           jmp 0x1bf7
loc_1BCC:
1BCC  8B 7E 04        mov di, word ptr [bp + 4]
1BCF  36 8A 45 06     mov al, byte ptr ss:[di + 6]
1BD3  30 E4           xor ah, ah
1BD5  48              dec ax
1BD6  99              cdq
1BD7  B9 10 00        mov cx, 0x10
1BDA  F7 F9           idiv cx
1BDC  92              xchg dx, ax
1BDD  40              inc ax
1BDE  36 88 45 FB     mov byte ptr ss:[di - 5], al
1BE2  36 8A 45 FB     mov al, byte ptr ss:[di - 5]
1BE6  30 E4           xor ah, ah
1BE8  8B D0           mov dx, ax
1BEA  36 8A 45 06     mov al, byte ptr ss:[di + 6]
1BEE  30 E4           xor ah, ah
1BF0  2B C2           sub ax, dx
1BF2  40              inc ax
1BF3  36 89 45 FC     mov word ptr ss:[di - 4], ax
loc_1BF7:
1BF7  C9              leave
1BF8  C2 02 00        ret 2

; ---- routine 1B55:1BFB  (found by: call)
sub_1BFB:
1BFB  C8 06 00 00     enter 6, 0
1BFF  BF 76 70        mov di, 0x7076
1C02  1E              push ds
1C03  57              push di
1C04  BF 5C DD        mov di, 0xdd5c
1C07  1E              push ds
1C08  57              push di
1C09  9A 2F 05 2A 23  call far 232A:052F
1C0E  C7 06 64 DD 02 00 mov word ptr [0xdd64], 2
1C14  C7 46 FC 04 00  mov word ptr [bp - 4], 4
1C19  8B 7E 04        mov di, word ptr [bp + 4]
1C1C  36 8B 45 FC     mov ax, word ptr ss:[di - 4]
1C20  05 0F 00        add ax, 0xf
1C23  89 46 FA        mov word ptr [bp - 6], ax
1C26  36 8B 45 FC     mov ax, word ptr ss:[di - 4]
1C2A  3B 46 FA        cmp ax, word ptr [bp - 6]
1C2D  77 33           ja 0x1c62
1C2F  89 46 FE        mov word ptr [bp - 2], ax
1C32  EB 03           jmp 0x1c37
loc_1C34:
1C34  FF 46 FE        inc word ptr [bp - 2]
loc_1C37:
1C37  8A 46 FE        mov al, byte ptr [bp - 2]
1C3A  30 E4           xor ah, ah
1C3C  8B F8           mov di, ax
1C3E  C1 E7 04        shl di, 4
1C41  81 C7 2C 9A     add di, 0x9a2c
1C45  1E              push ds
1C46  57              push di
1C47  8A 46 FC        mov al, byte ptr [bp - 4]
1C4A  50              push ax
1C4B  6A 3A           push 0x3a
1C4D  BF 5C DD        mov di, 0xdd5c
1C50  1E              push ds
1C51  57              push di
1C52  9A 9D 03 2A 23  call far 232A:039D
1C57  FF 46 FC        inc word ptr [bp - 4]
1C5A  8B 46 FE        mov ax, word ptr [bp - 2]
1C5D  3B 46 FA        cmp ax, word ptr [bp - 6]
1C60  75 D2           jne 0x1c34
loc_1C62:
1C62  8B 7E 04        mov di, word ptr [bp + 4]
1C65  36 8A 45 FB     mov al, byte ptr ss:[di - 5]
1C69  30 E4           xor ah, ah
1C6B  05 03 00        add ax, 3
1C6E  50              push ax
1C6F  6A 39           push 0x39
1C71  6A 11           push 0x11
1C73  9A 03 02 2A 23  call far 232A:0203
1C78  8B 7E 04        mov di, word ptr [bp + 4]
1C7B  36 8A 45 FB     mov al, byte ptr ss:[di - 5]
1C7F  30 E4           xor ah, ah
1C81  36 03 45 FC     add ax, word ptr ss:[di - 4]
1C85  48              dec ax
1C86  50              push ax
1C87  6A 01           push 1
1C89  68 84 00        push 0x84
1C8C  6A 15           push 0x15
1C8E  6A 3A           push 0x3a
1C90  9A 67 01 2A 23  call far 232A:0167
1C95  C9              leave
1C96  C2 02 00        ret 2

; ---- routine 1B55:1C99  (found by: far)
sub_1C99:
1C99  C8 06 00 00     enter 6, 0
1C9D  BF 22 63        mov di, 0x6322
1CA0  1E              push ds
1CA1  57              push di
1CA2  BF 5C DD        mov di, 0xdd5c
1CA5  1E              push ds
1CA6  57              push di
1CA7  9A 2F 05 2A 23  call far 232A:052F
1CAC  C6 46 FF 00     mov byte ptr [bp - 1], 0
1CB0  55              push bp
1CB1  E8 FE FE        call 0x1bb2
loc_1CB4:
1CB4  55              push bp
1CB5  E8 43 FF        call 0x1bfb
1CB8  C4 3E 5C DD     les di, ptr [0xdd5c]
1CBC  06              push es
1CBD  57              push di
1CBE  C4 3E 58 DD     les di, ptr [0xdd58]
1CC2  06              push es
1CC3  57              push di
1CC4  68 A0 0F        push 0xfa0
1CC7  9A 12 0A C9 26  call far 26C9:0A12
1CCC  9A 9B 09 2A 23  call far 232A:099B
1CD1  A0 88 DE        mov al, byte ptr [0xde88]
1CD4  3C 05           cmp al, 5
1CD6  74 04           je 0x1cdc
1CD8  3C 07           cmp al, 7
1CDA  75 1B           jne 0x1cf7
loc_1CDC:
1CDC  80 7E FB 01     cmp byte ptr [bp - 5], 1
1CE0  76 05           jbe 0x1ce7
1CE2  FE 4E FB        dec byte ptr [bp - 5]
1CE5  EB 0E           jmp 0x1cf5
loc_1CE7:
1CE7  83 7E FC 10     cmp word ptr [bp - 4], 0x10
1CEB  76 08           jbe 0x1cf5
1CED  83 6E FC 10     sub word ptr [bp - 4], 0x10
1CF1  C6 46 FB 10     mov byte ptr [bp - 5], 0x10
loc_1CF5:
1CF5  EB 5F           jmp 0x1d56
loc_1CF7:
1CF7  3C 06           cmp al, 6
1CF9  74 04           je 0x1cff
1CFB  3C 08           cmp al, 8
1CFD  75 1B           jne 0x1d1a
loc_1CFF:
1CFF  80 7E FB 10     cmp byte ptr [bp - 5], 0x10
1D03  73 05           jae 0x1d0a
1D05  FE 46 FB        inc byte ptr [bp - 5]
1D08  EB 0E           jmp 0x1d18
loc_1D0A:
1D0A  83 7E FC 71     cmp word ptr [bp - 4], 0x71
1D0E  73 08           jae 0x1d18
1D10  83 46 FC 10     add word ptr [bp - 4], 0x10
1D14  C6 46 FB 01     mov byte ptr [bp - 5], 1
loc_1D18:
1D18  EB 3C           jmp 0x1d56
loc_1D1A:
1D1A  3C 0B           cmp al, 0xb
1D1C  75 0C           jne 0x1d2a
1D1E  83 7E FC 10     cmp word ptr [bp - 4], 0x10
1D22  76 04           jbe 0x1d28
1D24  83 6E FC 10     sub word ptr [bp - 4], 0x10
loc_1D28:
1D28  EB 2C           jmp 0x1d56
loc_1D2A:
1D2A  3C 0C           cmp al, 0xc
1D2C  75 0C           jne 0x1d3a
1D2E  83 7E FC 71     cmp word ptr [bp - 4], 0x71
1D32  73 04           jae 0x1d38
1D34  83 46 FC 10     add word ptr [bp - 4], 0x10
loc_1D38:
1D38  EB 1C           jmp 0x1d56
loc_1D3A:
1D3A  3C 09           cmp al, 9
1D3C  75 0B           jne 0x1d49
1D3E  C7 46 FC 01 00  mov word ptr [bp - 4], 1
1D43  C6 46 FB 01     mov byte ptr [bp - 5], 1
1D47  EB 0D           jmp 0x1d56
loc_1D49:
1D49  3C 0A           cmp al, 0xa
1D4B  75 09           jne 0x1d56
1D4D  C7 46 FC 71 00  mov word ptr [bp - 4], 0x71
1D52  C6 46 FB 10     mov byte ptr [bp - 5], 0x10
loc_1D56:
1D56  80 3E 88 DE 02  cmp byte ptr [0xde88], 2
1D5B  74 03           je 0x1d60
1D5D  E9 54 FF        jmp 0x1cb4
loc_1D60:
1D60  8A 46 FB        mov al, byte ptr [bp - 5]
1D63  30 E4           xor ah, ah
1D65  03 46 FC        add ax, word ptr [bp - 4]
1D68  48              dec ax
1D69  88 46 FF        mov byte ptr [bp - 1], al
1D6C  8A 46 FF        mov al, byte ptr [bp - 1]
1D6F  C9              leave
1D70  CA 02 00        retf 2
; data (not reached as code), 11 bytes
1D73                  pstr 'Large chin'

; ---- routine 1B55:1D7E  (found by: call, far)
sub_1D7E:
1D7E  C8 18 00 00     enter 0x18, 0
1D82  8B 46 0A        mov ax, word ptr [bp + 0xa]
1D85  C1 E0 02        shl ax, 2
1D88  C4 3E C8 DC     les di, ptr [0xdcc8]
1D8C  03 F8           add di, ax
1D8E  89 7E E8        mov word ptr [bp - 0x18], di
1D91  8C 46 EA        mov word ptr [bp - 0x16], es
1D94  26 8A 45 03     mov al, byte ptr es:[di + 3]
1D98  30 E4           xor ah, ah
1D9A  31 D2           xor dx, dx
1D9C  52              push dx
1D9D  50              push ax
1D9E  6A 00           push 0
1DA0  6A 01           push 1
1DA2  9A C0 04 BC 24  call far 24BC:04C0
1DA7  88 46 FF        mov byte ptr [bp - 1], al
1DAA  C4 7E E8        les di, ptr [bp - 0x18]
1DAD  26 8A 45 02     mov al, byte ptr es:[di + 2]
1DB1  30 E4           xor ah, ah
1DB3  89 46 FC        mov word ptr [bp - 4], ax
1DB6  81 7E FC B0 00  cmp word ptr [bp - 4], 0xb0
1DBB  76 05           jbe 0x1dc2
1DBD  C7 46 FC B0 00  mov word ptr [bp - 4], 0xb0
loc_1DC2:
1DC2  81 7E 0A BE 03  cmp word ptr [bp + 0xa], 0x3be
1DC7  75 1B           jne 0x1de4
1DC9  80 3E D8 DC 09  cmp byte ptr [0xdcd8], 9
1DCE  75 14           jne 0x1de4
1DD0  BF 73 1D        mov di, 0x1d73
1DD3  0E              push cs
1DD4  57              push di
1DD5  8D 7E EC        lea di, [bp - 0x14]
1DD8  16              push ss
1DD9  57              push di
1DDA  6A 0F           push 0xf
1DDC  9A 6D 0B C9 26  call far 26C9:0B6D
1DE1  E9 85 00        jmp 0x1e69
loc_1DE4:
1DE4  80 7E FF 01     cmp byte ptr [bp - 1], 1
1DE8  74 45           je 0x1e2f
1DEA  8B 46 FC        mov ax, word ptr [bp - 4]
1DED  31 D2           xor dx, dx
1DEF  05 FF FF        add ax, 0xffff
1DF2  83 D2 FF        adc dx, -1
1DF5  B9 10 00        mov cx, 0x10
1DF8  31 DB           xor bx, bx
1DFA  9A 67 0A C9 26  call far 26C9:0A67
1DFF  05 01 00        add ax, 1
1E02  83 D2 00        adc dx, 0
1E05  8B D0           mov dx, ax
1E07  8A 46 FF        mov al, byte ptr [bp - 1]
1E0A  98              cwde
1E0B  6B F8 0C        imul di, ax, 0xc
1E0E  03 FA           add di, dx
1E10  8A 85 E0 0F     mov al, byte ptr [di + 0xfe0]
1E14  30 E4           xor ah, ah
1E16  8B F8           mov di, ax
1E18  C1 E7 04        shl di, 4
1E1B  81 C7 0C 8A     add di, 0x8a0c
1E1F  1E              push ds
1E20  57              push di
1E21  8D 7E EC        lea di, [bp - 0x14]
1E24  16              push ss
1E25  57              push di
1E26  6A 0F           push 0xf
1E28  9A 6D 0B C9 26  call far 26C9:0B6D
1E2D  EB 3A           jmp 0x1e69
loc_1E2F:
1E2F  8B 46 FC        mov ax, word ptr [bp - 4]
1E32  31 D2           xor dx, dx
1E34  05 FF FF        add ax, 0xffff
1E37  83 D2 FF        adc dx, -1
1E3A  B9 08 00        mov cx, 8
1E3D  31 DB           xor bx, bx
1E3F  9A 67 0A C9 26  call far 26C9:0A67
1E44  05 01 00        add ax, 1
1E47  83 D2 00        adc dx, 0
1E4A  8B F8           mov di, ax
1E4C  8A 85 E1 0F     mov al, byte ptr [di + 0xfe1]
1E50  30 E4           xor ah, ah
1E52  8B F8           mov di, ax
1E54  C1 E7 04        shl di, 4
1E57  81 C7 0C 8A     add di, 0x8a0c
1E5B  1E              push ds
1E5C  57              push di
1E5D  8D 7E EC        lea di, [bp - 0x14]
1E60  16              push ss
1E61  57              push di
1E62  6A 0F           push 0xf
1E64  9A 6D 0B C9 26  call far 26C9:0B6D
loc_1E69:
1E69  8A 46 ED        mov al, byte ptr [bp - 0x13]
1E6C  50              push ax
1E6D  9A 86 19 C9 26  call far 26C9:1986
1E72  88 46 ED        mov byte ptr [bp - 0x13], al
1E75  8D 7E EC        lea di, [bp - 0x14]
1E78  16              push ss
1E79  57              push di
1E7A  8A 46 08        mov al, byte ptr [bp + 8]
1E7D  50              push ax
1E7E  8A 46 06        mov al, byte ptr [bp + 6]
1E81  50              push ax
1E82  BF 5C DD        mov di, 0xdd5c
1E85  1E              push ds
1E86  57              push di
1E87  9A 83 02 2A 23  call far 232A:0283
1E8C  C9              leave
1E8D  CA 06 00        retf 6

; ---- routine 1B55:1E90  (found by: call, far)
sub_1E90:
1E90  C8 00 01 00     enter 0x100, 0
1E94  6B 46 0A 0B     imul ax, word ptr [bp + 0xa], 0xb
1E98  C4 3E CC DC     les di, ptr [0xdccc]
1E9C  03 F8           add di, ax
1E9E  06              push es
1E9F  57              push di
1EA0  8A 46 08        mov al, byte ptr [bp + 8]
1EA3  50              push ax
1EA4  8A 46 06        mov al, byte ptr [bp + 6]
1EA7  50              push ax
1EA8  BF 5C DD        mov di, 0xdd5c
1EAB  1E              push ds
1EAC  57              push di
1EAD  9A 83 02 2A 23  call far 232A:0283
1EB2  8D BE 00 FF     lea di, [bp - 0x100]
1EB6  16              push ss
1EB7  57              push di
1EB8  8B 46 0A        mov ax, word ptr [bp + 0xa]
1EBB  C4 3E D4 DC     les di, ptr [0xdcd4]
1EBF  03 F8           add di, ax
1EC1  26 8A 05        mov al, byte ptr es:[di]
1EC4  50              push ax
1EC5  9A 6F 0C C9 26  call far 26C9:0C6F
1ECA  8A 46 08        mov al, byte ptr [bp + 8]
1ECD  50              push ax
1ECE  6B 46 0A 0B     imul ax, word ptr [bp + 0xa], 0xb
1ED2  C4 3E CC DC     les di, ptr [0xdccc]
1ED6  03 F8           add di, ax
1ED8  26 8A 05        mov al, byte ptr es:[di]
1EDB  30 E4           xor ah, ah
1EDD  40              inc ax
1EDE  8B D0           mov dx, ax
1EE0  8B 46 06        mov ax, word ptr [bp + 6]
1EE3  2B C2           sub ax, dx
1EE5  50              push ax
1EE6  BF 5C DD        mov di, 0xdd5c
1EE9  1E              push ds
1EEA  57              push di
1EEB  9A 83 02 2A 23  call far 232A:0283
1EF0  C9              leave
1EF1  CA 06 00        retf 6

; ---- routine 1B55:1EF4  (found by: call, far)
sub_1EF4:
1EF4  C8 00 01 00     enter 0x100, 0
1EF8  8D BE 00 FF     lea di, [bp - 0x100]
1EFC  16              push ss
1EFD  57              push di
1EFE  8B 46 0A        mov ax, word ptr [bp + 0xa]
1F01  C4 3E D4 DC     les di, ptr [0xdcd4]
1F05  03 F8           add di, ax
1F07  26 8A 05        mov al, byte ptr es:[di]
1F0A  50              push ax
1F0B  9A 6F 0C C9 26  call far 26C9:0C6F
1F10  8A 46 08        mov al, byte ptr [bp + 8]
1F13  50              push ax
1F14  8A 46 06        mov al, byte ptr [bp + 6]
1F17  50              push ax
1F18  BF 5C DD        mov di, 0xdd5c
1F1B  1E              push ds
1F1C  57              push di
1F1D  9A 9D 03 2A 23  call far 232A:039D
1F22  6B 46 0A 0B     imul ax, word ptr [bp + 0xa], 0xb
1F26  C4 3E CC DC     les di, ptr [0xdccc]
1F2A  03 F8           add di, ax
1F2C  06              push es
1F2D  57              push di
1F2E  8A 46 08        mov al, byte ptr [bp + 8]
1F31  50              push ax
1F32  8B 46 06        mov ax, word ptr [bp + 6]
1F35  40              inc ax
1F36  40              inc ax
1F37  50              push ax
1F38  BF 5C DD        mov di, 0xdd5c
1F3B  1E              push ds
1F3C  57              push di
1F3D  9A 9D 03 2A 23  call far 232A:039D
1F42  C9              leave
1F43  CA 06 00        retf 6

