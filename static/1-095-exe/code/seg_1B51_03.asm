; 1-095.EXE (One-Nil 95), code segment 1B51 (image offsets 1B510..2305F), part 3 of 12
; packed 1-095.EXE sha256 f659fb2d334500d6901fc8d6a0f06c85c0ccda2eb4a3035ae3bb0a0004d79192 (LZEXE 0.91)
; unpacked (tools/static/unlzexe.py) sha256 8df646e017e0965a5d90a58181ca764219ad847833aad0b6cb58fc53372bfb2c
; tool: capstone 5.0.9 (pip package; core library 5.0.1280) (CS_ARCH_X86, CS_MODE_16), recursive descent from the entry point, far calls and near calls/jumps, then routine prologues (55 89 E5 / 55 8B EC / C8 iw 00) in what remains; tools/static/listing.py
; addresses are SEGMENT:OFFSET with SEGMENT the image paragraph before relocation; image offset = SEGMENT*16+OFFSET
; ---- routine 1B51:152F  (found by: call)
sub_152F:
152F  55              push bp
1530  89 E5           mov bp, sp
1532  8B 46 08        mov ax, word ptr [bp + 8]
1535  8B F0           mov si, ax
1537  D1 E0           shl ax, 1
1539  01 F0           add ax, si
153B  8B D0           mov dx, ax
153D  69 46 0A AE 00  imul ax, word ptr [bp + 0xa], 0xae
1542  C4 3E CA D7     les di, ptr [0xd7ca]
1546  03 F8           add di, ax
1548  03 FA           add di, dx
154A  26 8A 85 51 FF  mov al, byte ptr es:[di - 0xaf]
154F  24 F0           and al, 0xf0
1551  30 E4           xor ah, ah
1553  C1 E8 04        shr ax, 4
1556  3D 08 00        cmp ax, 8
1559  75 1B           jne 0x1576
155B  BF 2D 15        mov di, 0x152d
155E  0E              push cs
155F  57              push di
1560  8A 46 06        mov al, byte ptr [bp + 6]
1563  50              push ax
1564  8B 46 04        mov ax, word ptr [bp + 4]
1567  48              dec ax
1568  48              dec ax
1569  50              push ax
156A  BF 5C DD        mov di, 0xdd5c
156D  1E              push ds
156E  57              push di
156F  9A 9D 03 1A 23  call far 231A:039D
1574  EB 61           jmp 0x15d7
loc_1576:
1576  8B 46 08        mov ax, word ptr [bp + 8]
1579  8B F0           mov si, ax
157B  D1 E0           shl ax, 1
157D  01 F0           add ax, si
157F  8B C8           mov cx, ax
1581  8B 46 08        mov ax, word ptr [bp + 8]
1584  8B F0           mov si, ax
1586  D1 E0           shl ax, 1
1588  01 F0           add ax, si
158A  8B D0           mov dx, ax
158C  69 46 0A AE 00  imul ax, word ptr [bp + 0xa], 0xae
1591  C4 3E CA D7     les di, ptr [0xd7ca]
1595  03 F8           add di, ax
1597  03 FA           add di, dx
1599  26 8A 85 50 FF  mov al, byte ptr es:[di - 0xb0]
159E  30 E4           xor ah, ah
15A0  69 C0 AE 00     imul ax, ax, 0xae
15A4  C4 3E CA D7     les di, ptr [0xd7ca]
15A8  03 F8           add di, ax
15AA  03 F9           add di, cx
15AC  26 8A 85 51 FF  mov al, byte ptr es:[di - 0xaf]
15B1  24 F0           and al, 0xf0
15B3  30 E4           xor ah, ah
15B5  C1 E8 04        shr ax, 4
15B8  3D 08 00        cmp ax, 8
15BB  75 1A           jne 0x15d7
15BD  BF 2D 15        mov di, 0x152d
15C0  0E              push cs
15C1  57              push di
15C2  8A 46 06        mov al, byte ptr [bp + 6]
15C5  50              push ax
15C6  8B 46 04        mov ax, word ptr [bp + 4]
15C9  05 04 00        add ax, 4
15CC  50              push ax
15CD  BF 5C DD        mov di, 0xdd5c
15D0  1E              push ds
15D1  57              push di
15D2  9A 9D 03 1A 23  call far 231A:039D
loc_15D7:
15D7  C9              leave
15D8  C2 08 00        ret 8
; data (not reached as code), 2 bytes
15DB                  db 01 76   ; .v

; ---- routine 1B51:15DD  (found by: call, far)
sub_15DD:
15DD  55              push bp
15DE  89 E5           mov bp, sp
15E0  FF 76 0C        push word ptr [bp + 0xc]
15E3  FF 76 08        push word ptr [bp + 8]
15E6  8B 46 06        mov ax, word ptr [bp + 6]
15E9  2D 03 00        sub ax, 3
15EC  50              push ax
15ED  0E              push cs
15EE  E8 AA F8        call 0xe9b
15F1  8B 46 0A        mov ax, word ptr [bp + 0xa]
15F4  8B F0           mov si, ax
15F6  D1 E0           shl ax, 1
15F8  01 F0           add ax, si
15FA  8B D0           mov dx, ax
15FC  69 46 0C AE 00  imul ax, word ptr [bp + 0xc], 0xae
1601  C4 3E CA D7     les di, ptr [0xd7ca]
1605  03 F8           add di, ax
1607  03 FA           add di, dx
1609  26 8A 85 50 FF  mov al, byte ptr es:[di - 0xb0]
160E  30 E4           xor ah, ah
1610  50              push ax
1611  FF 76 08        push word ptr [bp + 8]
1614  8B 46 06        mov ax, word ptr [bp + 6]
1617  05 05 00        add ax, 5
161A  50              push ax
161B  0E              push cs
161C  E8 24 F8        call 0xe43
161F  6A 05           push 5
1621  BF DB 15        mov di, 0x15db
1624  0E              push cs
1625  57              push di
1626  8A 46 08        mov al, byte ptr [bp + 8]
1629  50              push ax
162A  8B 46 06        mov ax, word ptr [bp + 6]
162D  40              inc ax
162E  50              push ax
162F  BF 5C DD        mov di, 0xdd5c
1632  1E              push ds
1633  57              push di
1634  9A 1B 04 1A 23  call far 231A:041B
1639  8B 46 0A        mov ax, word ptr [bp + 0xa]
163C  8B F0           mov si, ax
163E  D1 E0           shl ax, 1
1640  01 F0           add ax, si
1642  8B D0           mov dx, ax
1644  69 46 0C AE 00  imul ax, word ptr [bp + 0xc], 0xae
1649  C4 3E CA D7     les di, ptr [0xd7ca]
164D  03 F8           add di, ax
164F  03 FA           add di, dx
1651  26 8A 85 51 FF  mov al, byte ptr es:[di - 0xaf]
1656  24 F0           and al, 0xf0
1658  30 E4           xor ah, ah
165A  C1 E8 04        shr ax, 4
165D  3D 01 00        cmp ax, 1
1660  7E 2F           jle 0x1691
1662  8B 56 0A        mov dx, word ptr [bp + 0xa]
1665  6B 46 0C 3A     imul ax, word ptr [bp + 0xc], 0x3a
1669  C4 3E CE D7     les di, ptr [0xd7ce]
166D  03 F8           add di, ax
166F  03 FA           add di, dx
1671  26 8A 45 C5     mov al, byte ptr es:[di - 0x3b]
1675  30 E4           xor ah, ah
1677  50              push ax
1678  FF 76 08        push word ptr [bp + 8]
167B  FF 76 06        push word ptr [bp + 6]
167E  0E              push cs
167F  E8 20 FE        call 0x14a2
1682  FF 76 0C        push word ptr [bp + 0xc]
1685  FF 76 0A        push word ptr [bp + 0xa]
1688  FF 76 08        push word ptr [bp + 8]
168B  FF 76 06        push word ptr [bp + 6]
168E  E8 9E FE        call 0x152f
loc_1691:
1691  C9              leave
1692  CA 08 00        retf 8

; ---- routine 1B51:1695  (found by: call, far)
sub_1695:
1695  C8 04 00 00     enter 4, 0
1699  8B 56 06        mov dx, word ptr [bp + 6]
169C  6B 46 08 3A     imul ax, word ptr [bp + 8], 0x3a
16A0  C4 3E CE D7     les di, ptr [0xd7ce]
16A4  03 F8           add di, ax
16A6  03 FA           add di, dx
16A8  26 8A 45 C5     mov al, byte ptr es:[di - 0x3b]
16AC  50              push ax
16AD  8D 7E FC        lea di, [bp - 4]
16B0  16              push ss
16B1  57              push di
16B2  9A E3 01 1A 23  call far 231A:01E3
16B7  8A 46 FC        mov al, byte ptr [bp - 4]
16BA  3A 46 FD        cmp al, byte ptr [bp - 3]
16BD  77 2D           ja 0x16ec
16BF  8B 46 06        mov ax, word ptr [bp + 6]
16C2  8B F0           mov si, ax
16C4  D1 E0           shl ax, 1
16C6  01 F0           add ax, si
16C8  8B D0           mov dx, ax
16CA  69 46 08 AE 00  imul ax, word ptr [bp + 8], 0xae
16CF  C4 3E CA D7     les di, ptr [0xd7ca]
16D3  03 F8           add di, ax
16D5  03 FA           add di, dx
16D7  26 8A 85 51 FF  mov al, byte ptr es:[di - 0xaf]
16DC  24 F0           and al, 0xf0
16DE  30 E4           xor ah, ah
16E0  C1 E8 04        shr ax, 4
16E3  3D 08 00        cmp ax, 8
16E6  74 04           je 0x16ec
16E8  B0 00           mov al, 0
16EA  EB 02           jmp 0x16ee
loc_16EC:
16EC  B0 01           mov al, 1
loc_16EE:
16EE  88 46 FF        mov byte ptr [bp - 1], al
16F1  8A 46 FF        mov al, byte ptr [bp - 1]
16F4  C9              leave
16F5  CA 04 00        retf 4

; ---- routine 1B51:16F8  (found by: far)
sub_16F8:
16F8  C8 02 00 00     enter 2, 0
16FC  8B 7E 06        mov di, word ptr [bp + 6]
16FF  80 BD 6A A2 05  cmp byte ptr [di - 0x5d96], 5
1704  75 0C           jne 0x1712
1706  83 7E 06 16     cmp word ptr [bp + 6], 0x16
170A  76 06           jbe 0x1712
170C  83 7E 06 39     cmp word ptr [bp + 6], 0x39
1710  72 04           jb 0x1716
loc_1712:
1712  B0 00           mov al, 0
1714  EB 02           jmp 0x1718
loc_1716:
1716  B0 01           mov al, 1
loc_1718:
1718  88 46 FF        mov byte ptr [bp - 1], al
171B  8A 46 FF        mov al, byte ptr [bp - 1]
171E  C9              leave
171F  CA 02 00        retf 2

; ---- routine 1B51:1722  (found by: far)
sub_1722:
1722  C8 04 00 00     enter 4, 0
1726  8B 56 06        mov dx, word ptr [bp + 6]
1729  6B 46 08 3A     imul ax, word ptr [bp + 8], 0x3a
172D  C4 3E CE D7     les di, ptr [0xd7ce]
1731  03 F8           add di, ax
1733  03 FA           add di, dx
1735  26 8A 45 C5     mov al, byte ptr es:[di - 0x3b]
1739  50              push ax
173A  8D 7E FC        lea di, [bp - 4]
173D  16              push ss
173E  57              push di
173F  9A E3 01 1A 23  call far 231A:01E3
1744  8A 46 FC        mov al, byte ptr [bp - 4]
1747  3A 46 FD        cmp al, byte ptr [bp - 3]
174A  B0 00           mov al, 0
174C  75 01           jne 0x174f
174E  40              inc ax
loc_174F:
174F  88 46 FF        mov byte ptr [bp - 1], al
1752  8A 46 FF        mov al, byte ptr [bp - 1]
1755  C9              leave
1756  CA 04 00        retf 4

; ---- routine 1B51:1759  (found by: call, far)
sub_1759:
1759  C8 02 00 00     enter 2, 0
175D  8B 56 0C        mov dx, word ptr [bp + 0xc]
1760  6B 46 0E 3A     imul ax, word ptr [bp + 0xe], 0x3a
1764  C4 3E CE D7     les di, ptr [0xd7ce]
1768  03 F8           add di, ax
176A  03 FA           add di, dx
176C  26 8A 45 C5     mov al, byte ptr es:[di - 0x3b]
1770  50              push ax
1771  8D 7E FE        lea di, [bp - 2]
1774  16              push ss
1775  57              push di
1776  9A E3 01 1A 23  call far 231A:01E3
177B  8A 46 FE        mov al, byte ptr [bp - 2]
177E  C4 7E 06        les di, ptr [bp + 6]
1781  26 88 05        mov byte ptr es:[di], al
1784  8A 46 FF        mov al, byte ptr [bp - 1]
1787  26 88 45 01     mov byte ptr es:[di + 1], al
178B  8B 56 0A        mov dx, word ptr [bp + 0xa]
178E  6B 46 0E 3A     imul ax, word ptr [bp + 0xe], 0x3a
1792  C4 3E CE D7     les di, ptr [0xd7ce]
1796  03 F8           add di, ax
1798  03 FA           add di, dx
179A  26 8A 45 C5     mov al, byte ptr es:[di - 0x3b]
179E  50              push ax
179F  8D 7E FE        lea di, [bp - 2]
17A2  16              push ss
17A3  57              push di
17A4  9A E3 01 1A 23  call far 231A:01E3
17A9  8A 46 FE        mov al, byte ptr [bp - 2]
17AC  C4 7E 06        les di, ptr [bp + 6]
17AF  26 00 05        add byte ptr es:[di], al
17B2  8A 46 FF        mov al, byte ptr [bp - 1]
17B5  26 00 45 01     add byte ptr es:[di + 1], al
17B9  C9              leave
17BA  CA 0A 00        retf 0xa

; ---- routine 1B51:17BD  (found by: call)
sub_17BD:
17BD  C8 04 00 00     enter 4, 0
17C1  FF 76 0C        push word ptr [bp + 0xc]
17C4  FF 76 0A        push word ptr [bp + 0xa]
17C7  FF 76 08        push word ptr [bp + 8]
17CA  8D 7E FE        lea di, [bp - 2]
17CD  16              push ss
17CE  57              push di
17CF  0E              push cs
17D0  E8 86 FF        call 0x1759
17D3  FF 76 FE        push word ptr [bp - 2]
17D6  8D 7E FD        lea di, [bp - 3]
17D9  16              push ss
17DA  57              push di
17DB  9A C5 01 1A 23  call far 231A:01C5
17E0  8A 46 FD        mov al, byte ptr [bp - 3]
17E3  30 E4           xor ah, ah
17E5  50              push ax
17E6  FF 76 06        push word ptr [bp + 6]
17E9  FF 76 04        push word ptr [bp + 4]
17EC  0E              push cs
17ED  E8 B2 FC        call 0x14a2
17F0  FF 76 0C        push word ptr [bp + 0xc]
17F3  FF 76 08        push word ptr [bp + 8]
17F6  FF 76 06        push word ptr [bp + 6]
17F9  FF 76 04        push word ptr [bp + 4]
17FC  E8 30 FD        call 0x152f
17FF  C9              leave
1800  C2 0A 00        ret 0xa
; data (not reached as code), 24 bytes
1803                  pstr '1st leg:  v'
180F                  pstr '2nd leg:  v'

; ---- routine 1B51:181B  (found by: far)
sub_181B:
181B  C8 04 00 00     enter 4, 0
181F  8B 46 0E        mov ax, word ptr [bp + 0xe]
1822  8B F0           mov si, ax
1824  D1 E0           shl ax, 1
1826  01 F0           add ax, si
1828  8B D0           mov dx, ax
182A  69 46 10 AE 00  imul ax, word ptr [bp + 0x10], 0xae
182F  C4 3E CA D7     les di, ptr [0xd7ca]
1833  03 F8           add di, ax
1835  03 FA           add di, dx
1837  81 C7 4F FF     add di, 0xff4f
183B  89 7E FC        mov word ptr [bp - 4], di
183E  8C 46 FE        mov word ptr [bp - 2], es
1841  C4 7E 08        les di, ptr [bp + 8]
1844  26 FF 05        inc word ptr es:[di]
1847  6A 05           push 5
1849  BF 03 18        mov di, 0x1803
184C  0E              push cs
184D  57              push di
184E  C4 7E 08        les di, ptr [bp + 8]
1851  26 8A 05        mov al, byte ptr es:[di]
1854  50              push ax
1855  8B 46 06        mov ax, word ptr [bp + 6]
1858  2D 11 00        sub ax, 0x11
185B  50              push ax
185C  BF 5C DD        mov di, 0xdd5c
185F  1E              push ds
1860  57              push di
1861  9A 1B 04 1A 23  call far 231A:041B
1866  BF 0F 18        mov di, 0x180f
1869  0E              push cs
186A  57              push di
186B  C4 7E 08        les di, ptr [bp + 8]
186E  26 8A 05        mov al, byte ptr es:[di]
1871  50              push ax
1872  8A 46 06        mov al, byte ptr [bp + 6]
1875  50              push ax
1876  BF 5C DD        mov di, 0xdd5c
1879  1E              push ds
187A  57              push di
187B  9A 9D 03 1A 23  call far 231A:039D
1880  C4 7E FC        les di, ptr [bp - 4]
1883  26 8A 45 02     mov al, byte ptr es:[di + 2]
1887  24 F0           and al, 0xf0
1889  30 E4           xor ah, ah
188B  C1 E8 04        shr ax, 4
188E  3D 01 00        cmp ax, 1
1891  7E 27           jle 0x18ba
1893  8B 56 0E        mov dx, word ptr [bp + 0xe]
1896  6B 46 10 3A     imul ax, word ptr [bp + 0x10], 0x3a
189A  C4 3E CE D7     les di, ptr [0xd7ce]
189E  03 F8           add di, ax
18A0  03 FA           add di, dx
18A2  26 8A 45 C5     mov al, byte ptr es:[di - 0x3b]
18A6  30 E4           xor ah, ah
18A8  50              push ax
18A9  C4 7E 08        les di, ptr [bp + 8]
18AC  26 FF 35        push word ptr es:[di]
18AF  8B 46 06        mov ax, word ptr [bp + 6]
18B2  2D 08 00        sub ax, 8
18B5  50              push ax
18B6  0E              push cs
18B7  E8 E8 FB        call 0x14a2
loc_18BA:
18BA  8B 46 0C        mov ax, word ptr [bp + 0xc]
18BD  8B F0           mov si, ax
18BF  D1 E0           shl ax, 1
18C1  01 F0           add ax, si
18C3  8B D0           mov dx, ax
18C5  69 46 10 AE 00  imul ax, word ptr [bp + 0x10], 0xae
18CA  C4 3E CA D7     les di, ptr [0xd7ca]
18CE  03 F8           add di, ax
18D0  03 FA           add di, dx
18D2  26 8A 85 51 FF  mov al, byte ptr es:[di - 0xaf]
18D7  24 F0           and al, 0xf0
18D9  30 E4           xor ah, ah
18DB  C1 E8 04        shr ax, 4
18DE  3D 01 00        cmp ax, 1
18E1  7E 46           jle 0x1929
18E3  8B 56 0C        mov dx, word ptr [bp + 0xc]
18E6  C4 7E FC        les di, ptr [bp - 4]
18E9  26 8A 45 01     mov al, byte ptr es:[di + 1]
18ED  30 E4           xor ah, ah
18EF  6B C0 3A        imul ax, ax, 0x3a
18F2  C4 3E CE D7     les di, ptr [0xd7ce]
18F6  03 F8           add di, ax
18F8  03 FA           add di, dx
18FA  26 8A 45 C5     mov al, byte ptr es:[di - 0x3b]
18FE  30 E4           xor ah, ah
1900  50              push ax
1901  C4 7E 08        les di, ptr [bp + 8]
1904  26 FF 35        push word ptr es:[di]
1907  8B 46 06        mov ax, word ptr [bp + 6]
190A  05 09 00        add ax, 9
190D  50              push ax
190E  0E              push cs
190F  E8 90 FB        call 0x14a2
1912  FF 76 10        push word ptr [bp + 0x10]
1915  FF 76 0E        push word ptr [bp + 0xe]
1918  FF 76 0C        push word ptr [bp + 0xc]
191B  C4 7E 08        les di, ptr [bp + 8]
191E  26 8B 05        mov ax, word ptr es:[di]
1921  48              dec ax
1922  50              push ax
1923  FF 76 06        push word ptr [bp + 6]
1926  E8 94 FE        call 0x17bd
loc_1929:
1929  C9              leave
192A  CA 0C 00        retf 0xc

; ---- routine 1B51:192D  (found by: call)
sub_192D:
192D  C8 06 00 00     enter 6, 0
1931  8B 7E 04        mov di, word ptr [bp + 4]
1934  36 8B 45 08     mov ax, word ptr ss:[di + 8]
1938  8B F0           mov si, ax
193A  D1 E0           shl ax, 1
193C  01 F0           add ax, si
193E  8B D0           mov dx, ax
1940  36 69 45 0A AE 00 imul ax, word ptr ss:[di + 0xa], 0xae
1946  C4 3E CA D7     les di, ptr [0xd7ca]
194A  03 F8           add di, ax
194C  03 FA           add di, dx
194E  81 C7 4F FF     add di, 0xff4f
1952  26 8A 45 02     mov al, byte ptr es:[di + 2]
1956  24 0F           and al, 0xf
1958  30 E4           xor ah, ah
195A  3B 46 06        cmp ax, word ptr [bp + 6]
195D  75 0C           jne 0x196b
195F  8B 7E 04        mov di, word ptr [bp + 4]
1962  36 8B 45 08     mov ax, word ptr ss:[di + 8]
1966  89 46 FE        mov word ptr [bp - 2], ax
1969  EB 0A           jmp 0x1975
loc_196B:
196B  8B 7E 04        mov di, word ptr [bp + 4]
196E  36 8B 45 06     mov ax, word ptr ss:[di + 6]
1972  89 46 FE        mov word ptr [bp - 2], ax
loc_1975:
1975  8B 46 FE        mov ax, word ptr [bp - 2]
1978  C9              leave
1979  C2 04 00        ret 4

; ---- routine 1B51:197C  (found by: call, far)
sub_197C:
197C  C8 04 00 00     enter 4, 0
1980  FF 76 0A        push word ptr [bp + 0xa]
1983  FF 76 08        push word ptr [bp + 8]
1986  FF 76 06        push word ptr [bp + 6]
1989  8D 7E FC        lea di, [bp - 4]
198C  16              push ss
198D  57              push di
198E  0E              push cs
198F  E8 C7 FD        call 0x1759
1992  8A 46 FC        mov al, byte ptr [bp - 4]
1995  3A 46 FD        cmp al, byte ptr [bp - 3]
1998  75 41           jne 0x19db
199A  6A 01           push 1
199C  55              push bp
199D  E8 8D FF        call 0x192d
19A0  8B D0           mov dx, ax
19A2  6B 46 0A 3A     imul ax, word ptr [bp + 0xa], 0x3a
19A6  C4 3E CE D7     les di, ptr [0xd7ce]
19AA  03 F8           add di, ax
19AC  03 FA           add di, dx
19AE  26 8A 45 C5     mov al, byte ptr es:[di - 0x3b]
19B2  24 F0           and al, 0xf0
19B4  30 E4           xor ah, ah
19B6  C1 E8 04        shr ax, 4
19B9  50              push ax
19BA  6A 00           push 0
19BC  55              push bp
19BD  E8 6D FF        call 0x192d
19C0  8B D0           mov dx, ax
19C2  6B 46 0A 3A     imul ax, word ptr [bp + 0xa], 0x3a
19C6  C4 3E CE D7     les di, ptr [0xd7ce]
19CA  03 F8           add di, ax
19CC  03 FA           add di, dx
19CE  26 8A 45 C5     mov al, byte ptr es:[di - 0x3b]
19D2  24 0F           and al, 0xf
19D4  30 E4           xor ah, ah
19D6  5A              pop dx
19D7  3B C2           cmp ax, dx
19D9  74 04           je 0x19df
loc_19DB:
19DB  B0 00           mov al, 0
19DD  EB 02           jmp 0x19e1
loc_19DF:
19DF  B0 01           mov al, 1
loc_19E1:
19E1  88 46 FF        mov byte ptr [bp - 1], al
19E4  8A 46 FF        mov al, byte ptr [bp - 1]
19E7  C9              leave
19E8  CA 06 00        retf 6

; ---- routine 1B51:19EB  (found by: call)
sub_19EB:
19EB  C8 06 00 00     enter 6, 0
19EF  8B 7E 04        mov di, word ptr [bp + 4]
19F2  36 8B 45 08     mov ax, word ptr ss:[di + 8]
19F6  8B F0           mov si, ax
19F8  D1 E0           shl ax, 1
19FA  01 F0           add ax, si
19FC  8B D0           mov dx, ax
19FE  36 69 45 0A AE 00 imul ax, word ptr ss:[di + 0xa], 0xae
1A04  C4 3E CA D7     les di, ptr [0xd7ca]
1A08  03 F8           add di, ax
1A0A  03 FA           add di, dx
1A0C  81 C7 4F FF     add di, 0xff4f
1A10  26 8A 45 02     mov al, byte ptr es:[di + 2]
1A14  24 0F           and al, 0xf
1A16  30 E4           xor ah, ah
1A18  3B 46 06        cmp ax, word ptr [bp + 6]
1A1B  75 0C           jne 0x1a29
1A1D  8B 7E 04        mov di, word ptr [bp + 4]
1A20  36 8B 45 08     mov ax, word ptr ss:[di + 8]
1A24  89 46 FE        mov word ptr [bp - 2], ax
1A27  EB 0A           jmp 0x1a33
loc_1A29:
1A29  8B 7E 04        mov di, word ptr [bp + 4]
1A2C  36 8B 45 06     mov ax, word ptr ss:[di + 6]
1A30  89 46 FE        mov word ptr [bp - 2], ax
loc_1A33:
1A33  8B 46 FE        mov ax, word ptr [bp - 2]
1A36  C9              leave
1A37  C2 04 00        ret 4

; ---- routine 1B51:1A3A  (found by: call, far)
sub_1A3A:
1A3A  C8 04 00 00     enter 4, 0
1A3E  FF 76 0A        push word ptr [bp + 0xa]
1A41  FF 76 08        push word ptr [bp + 8]
1A44  FF 76 06        push word ptr [bp + 6]
1A47  8D 7E FC        lea di, [bp - 4]
1A4A  16              push ss
1A4B  57              push di
1A4C  0E              push cs
1A4D  E8 09 FD        call 0x1759
1A50  8A 46 FC        mov al, byte ptr [bp - 4]
1A53  3A 46 FD        cmp al, byte ptr [bp - 3]
1A56  76 03           jbe 0x1a5b
1A58  E9 87 00        jmp 0x1ae2
loc_1A5B:
1A5B  8A 46 FC        mov al, byte ptr [bp - 4]
1A5E  3A 46 FD        cmp al, byte ptr [bp - 3]
1A61  75 41           jne 0x1aa4
1A63  6A 01           push 1
1A65  55              push bp
1A66  E8 82 FF        call 0x19eb
1A69  8B D0           mov dx, ax
1A6B  6B 46 0A 3A     imul ax, word ptr [bp + 0xa], 0x3a
1A6F  C4 3E CE D7     les di, ptr [0xd7ce]
1A73  03 F8           add di, ax
1A75  03 FA           add di, dx
1A77  26 8A 45 C5     mov al, byte ptr es:[di - 0x3b]
1A7B  24 F0           and al, 0xf0
1A7D  30 E4           xor ah, ah
1A7F  C1 E8 04        shr ax, 4
1A82  50              push ax
1A83  6A 00           push 0
1A85  55              push bp
1A86  E8 62 FF        call 0x19eb
1A89  8B D0           mov dx, ax
1A8B  6B 46 0A 3A     imul ax, word ptr [bp + 0xa], 0x3a
1A8F  C4 3E CE D7     les di, ptr [0xd7ce]
1A93  03 F8           add di, ax
1A95  03 FA           add di, dx
1A97  26 8A 45 C5     mov al, byte ptr es:[di - 0x3b]
1A9B  24 0F           and al, 0xf
1A9D  30 E4           xor ah, ah
1A9F  5A              pop dx
1AA0  3B C2           cmp ax, dx
1AA2  7F 3E           jg 0x1ae2
loc_1AA4:
1AA4  FF 76 0A        push word ptr [bp + 0xa]
1AA7  FF 76 08        push word ptr [bp + 8]
1AAA  FF 76 06        push word ptr [bp + 6]
1AAD  0E              push cs
1AAE  E8 CB FE        call 0x197c
1AB1  08 C0           or al, al
1AB3  74 29           je 0x1ade
1AB5  8B 46 06        mov ax, word ptr [bp + 6]
1AB8  8B F0           mov si, ax
1ABA  D1 E0           shl ax, 1
1ABC  01 F0           add ax, si
1ABE  8B D0           mov dx, ax
1AC0  69 46 0A AE 00  imul ax, word ptr [bp + 0xa], 0xae
1AC5  C4 3E CA D7     les di, ptr [0xd7ca]
1AC9  03 F8           add di, ax
1ACB  03 FA           add di, dx
1ACD  26 8A 85 51 FF  mov al, byte ptr es:[di - 0xaf]
1AD2  24 F0           and al, 0xf0
1AD4  30 E4           xor ah, ah
1AD6  C1 E8 04        shr ax, 4
1AD9  3D 08 00        cmp ax, 8
1ADC  74 04           je 0x1ae2
loc_1ADE:
1ADE  B0 00           mov al, 0
1AE0  EB 02           jmp 0x1ae4
loc_1AE2:
1AE2  B0 01           mov al, 1
loc_1AE4:
1AE4  88 46 FF        mov byte ptr [bp - 1], al
1AE7  8A 46 FF        mov al, byte ptr [bp - 1]
1AEA  C9              leave
1AEB  CA 06 00        retf 6

; ---- routine 1B51:1AEE  (found by: call, far)
sub_1AEE:
1AEE  C8 02 00 00     enter 2, 0
1AF2  8B 46 06        mov ax, word ptr [bp + 6]
1AF5  C4 3E B6 D7     les di, ptr [0xd7b6]
1AF9  03 F8           add di, ax
1AFB  26 8A 45 FF     mov al, byte ptr es:[di - 1]
1AFF  3A 06 D8 DC     cmp al, byte ptr [0xdcd8]
1B03  B0 00           mov al, 0
1B05  75 01           jne 0x1b08
1B07  40              inc ax
loc_1B08:
1B08  88 46 FF        mov byte ptr [bp - 1], al
1B0B  8A 46 FF        mov al, byte ptr [bp - 1]
1B0E  C9              leave
1B0F  CA 02 00        retf 2

; ---- routine 1B51:1B12  (found by: call)
sub_1B12:
1B12  55              push bp
1B13  89 E5           mov bp, sp
1B15  8B 7E 04        mov di, word ptr [bp + 4]
1B18  36 C7 45 FC 01 00 mov word ptr ss:[di - 4], 1
1B1E  36 C6 45 FB 01  mov byte ptr ss:[di - 5], 1
1B23  36 80 7D 06 00  cmp byte ptr ss:[di + 6], 0
1B28  75 02           jne 0x1b2c
1B2A  EB 2B           jmp 0x1b57
loc_1B2C:
1B2C  8B 7E 04        mov di, word ptr [bp + 4]
1B2F  36 8A 45 06     mov al, byte ptr ss:[di + 6]
1B33  30 E4           xor ah, ah
1B35  48              dec ax
1B36  99              cdq
1B37  B9 10 00        mov cx, 0x10
1B3A  F7 F9           idiv cx
1B3C  92              xchg dx, ax
1B3D  40              inc ax
1B3E  36 88 45 FB     mov byte ptr ss:[di - 5], al
1B42  36 8A 45 FB     mov al, byte ptr ss:[di - 5]
1B46  30 E4           xor ah, ah
1B48  8B D0           mov dx, ax
1B4A  36 8A 45 06     mov al, byte ptr ss:[di + 6]
1B4E  30 E4           xor ah, ah
1B50  2B C2           sub ax, dx
1B52  40              inc ax
1B53  36 89 45 FC     mov word ptr ss:[di - 4], ax
loc_1B57:
1B57  C9              leave
1B58  C2 02 00        ret 2

; ---- routine 1B51:1B5B  (found by: call)
sub_1B5B:
1B5B  C8 06 00 00     enter 6, 0
1B5F  BF 76 70        mov di, 0x7076
1B62  1E              push ds
1B63  57              push di
1B64  BF 5C DD        mov di, 0xdd5c
1B67  1E              push ds
1B68  57              push di
1B69  9A 2F 05 1A 23  call far 231A:052F
1B6E  C7 06 64 DD 02 00 mov word ptr [0xdd64], 2
1B74  C7 46 FC 04 00  mov word ptr [bp - 4], 4
1B79  8B 7E 04        mov di, word ptr [bp + 4]
1B7C  36 8B 45 FC     mov ax, word ptr ss:[di - 4]
1B80  05 0F 00        add ax, 0xf
1B83  89 46 FA        mov word ptr [bp - 6], ax
1B86  36 8B 45 FC     mov ax, word ptr ss:[di - 4]
1B8A  3B 46 FA        cmp ax, word ptr [bp - 6]
1B8D  77 33           ja 0x1bc2
1B8F  89 46 FE        mov word ptr [bp - 2], ax
1B92  EB 03           jmp 0x1b97
loc_1B94:
1B94  FF 46 FE        inc word ptr [bp - 2]
loc_1B97:
1B97  8A 46 FE        mov al, byte ptr [bp - 2]
1B9A  30 E4           xor ah, ah
1B9C  8B F8           mov di, ax
1B9E  C1 E7 04        shl di, 4
1BA1  81 C7 2C 9A     add di, 0x9a2c
1BA5  1E              push ds
1BA6  57              push di
1BA7  8A 46 FC        mov al, byte ptr [bp - 4]
1BAA  50              push ax
1BAB  6A 3A           push 0x3a
1BAD  BF 5C DD        mov di, 0xdd5c
1BB0  1E              push ds
1BB1  57              push di
1BB2  9A 9D 03 1A 23  call far 231A:039D
1BB7  FF 46 FC        inc word ptr [bp - 4]
1BBA  8B 46 FE        mov ax, word ptr [bp - 2]
1BBD  3B 46 FA        cmp ax, word ptr [bp - 6]
1BC0  75 D2           jne 0x1b94
loc_1BC2:
1BC2  8B 7E 04        mov di, word ptr [bp + 4]
1BC5  36 8A 45 FB     mov al, byte ptr ss:[di - 5]
1BC9  30 E4           xor ah, ah
1BCB  05 03 00        add ax, 3
1BCE  50              push ax
1BCF  6A 39           push 0x39
1BD1  6A 11           push 0x11
1BD3  9A 03 02 1A 23  call far 231A:0203
1BD8  8B 7E 04        mov di, word ptr [bp + 4]
1BDB  36 8A 45 FB     mov al, byte ptr ss:[di - 5]
1BDF  30 E4           xor ah, ah
1BE1  36 03 45 FC     add ax, word ptr ss:[di - 4]
1BE5  48              dec ax
1BE6  50              push ax
1BE7  6A 01           push 1
1BE9  68 84 00        push 0x84
1BEC  6A 15           push 0x15
1BEE  6A 3A           push 0x3a
1BF0  9A 67 01 1A 23  call far 231A:0167
1BF5  C9              leave
1BF6  C2 02 00        ret 2

; ---- routine 1B51:1BF9  (found by: far)
sub_1BF9:
1BF9  C8 06 00 00     enter 6, 0
1BFD  BF 22 63        mov di, 0x6322
1C00  1E              push ds
1C01  57              push di
1C02  BF 5C DD        mov di, 0xdd5c
1C05  1E              push ds
1C06  57              push di
1C07  9A 2F 05 1A 23  call far 231A:052F
1C0C  C6 46 FF 00     mov byte ptr [bp - 1], 0
1C10  55              push bp
1C11  E8 FE FE        call 0x1b12
loc_1C14:
1C14  55              push bp
1C15  E8 43 FF        call 0x1b5b
1C18  C4 3E 5C DD     les di, ptr [0xdd5c]
1C1C  06              push es
1C1D  57              push di
1C1E  C4 3E 58 DD     les di, ptr [0xdd58]
1C22  06              push es
1C23  57              push di
1C24  68 A0 0F        push 0xfa0
1C27  9A 12 0A B9 26  call far 26B9:0A12
1C2C  9A 9B 09 1A 23  call far 231A:099B
1C31  A0 88 DE        mov al, byte ptr [0xde88]
1C34  3C 05           cmp al, 5
1C36  74 04           je 0x1c3c
1C38  3C 07           cmp al, 7
1C3A  75 1B           jne 0x1c57
loc_1C3C:
1C3C  80 7E FB 01     cmp byte ptr [bp - 5], 1
1C40  76 05           jbe 0x1c47
1C42  FE 4E FB        dec byte ptr [bp - 5]
1C45  EB 0E           jmp 0x1c55
loc_1C47:
1C47  83 7E FC 10     cmp word ptr [bp - 4], 0x10
1C4B  76 08           jbe 0x1c55
1C4D  83 6E FC 10     sub word ptr [bp - 4], 0x10
1C51  C6 46 FB 10     mov byte ptr [bp - 5], 0x10
loc_1C55:
1C55  EB 5F           jmp 0x1cb6
loc_1C57:
1C57  3C 06           cmp al, 6
1C59  74 04           je 0x1c5f
1C5B  3C 08           cmp al, 8
1C5D  75 1B           jne 0x1c7a
loc_1C5F:
1C5F  80 7E FB 10     cmp byte ptr [bp - 5], 0x10
1C63  73 05           jae 0x1c6a
1C65  FE 46 FB        inc byte ptr [bp - 5]
1C68  EB 0E           jmp 0x1c78
loc_1C6A:
1C6A  83 7E FC 71     cmp word ptr [bp - 4], 0x71
1C6E  73 08           jae 0x1c78
1C70  83 46 FC 10     add word ptr [bp - 4], 0x10
1C74  C6 46 FB 01     mov byte ptr [bp - 5], 1
loc_1C78:
1C78  EB 3C           jmp 0x1cb6
loc_1C7A:
1C7A  3C 0B           cmp al, 0xb
1C7C  75 0C           jne 0x1c8a
1C7E  83 7E FC 10     cmp word ptr [bp - 4], 0x10
1C82  76 04           jbe 0x1c88
1C84  83 6E FC 10     sub word ptr [bp - 4], 0x10
loc_1C88:
1C88  EB 2C           jmp 0x1cb6
loc_1C8A:
1C8A  3C 0C           cmp al, 0xc
1C8C  75 0C           jne 0x1c9a
1C8E  83 7E FC 71     cmp word ptr [bp - 4], 0x71
1C92  73 04           jae 0x1c98
1C94  83 46 FC 10     add word ptr [bp - 4], 0x10
loc_1C98:
1C98  EB 1C           jmp 0x1cb6
loc_1C9A:
1C9A  3C 09           cmp al, 9
1C9C  75 0B           jne 0x1ca9
1C9E  C7 46 FC 01 00  mov word ptr [bp - 4], 1
1CA3  C6 46 FB 01     mov byte ptr [bp - 5], 1
1CA7  EB 0D           jmp 0x1cb6
loc_1CA9:
1CA9  3C 0A           cmp al, 0xa
1CAB  75 09           jne 0x1cb6
1CAD  C7 46 FC 71 00  mov word ptr [bp - 4], 0x71
1CB2  C6 46 FB 10     mov byte ptr [bp - 5], 0x10
loc_1CB6:
1CB6  80 3E 88 DE 02  cmp byte ptr [0xde88], 2
1CBB  74 03           je 0x1cc0
1CBD  E9 54 FF        jmp 0x1c14
loc_1CC0:
1CC0  8A 46 FB        mov al, byte ptr [bp - 5]
1CC3  30 E4           xor ah, ah
1CC5  03 46 FC        add ax, word ptr [bp - 4]
1CC8  48              dec ax
1CC9  88 46 FF        mov byte ptr [bp - 1], al
1CCC  8A 46 FF        mov al, byte ptr [bp - 1]
1CCF  C9              leave
1CD0  CA 02 00        retf 2
; data (not reached as code), 11 bytes
1CD3                  pstr 'Large chin'

; ---- routine 1B51:1CDE  (found by: call, far)
sub_1CDE:
1CDE  C8 18 00 00     enter 0x18, 0
1CE2  8B 46 0A        mov ax, word ptr [bp + 0xa]
1CE5  C1 E0 02        shl ax, 2
1CE8  C4 3E C8 DC     les di, ptr [0xdcc8]
1CEC  03 F8           add di, ax
1CEE  89 7E E8        mov word ptr [bp - 0x18], di
1CF1  8C 46 EA        mov word ptr [bp - 0x16], es
1CF4  26 8A 45 03     mov al, byte ptr es:[di + 3]
1CF8  30 E4           xor ah, ah
1CFA  31 D2           xor dx, dx
1CFC  52              push dx
1CFD  50              push ax
1CFE  6A 00           push 0
1D00  6A 01           push 1
1D02  9A C0 04 AC 24  call far 24AC:04C0
1D07  88 46 FF        mov byte ptr [bp - 1], al
1D0A  C4 7E E8        les di, ptr [bp - 0x18]
1D0D  26 8A 45 02     mov al, byte ptr es:[di + 2]
1D11  30 E4           xor ah, ah
1D13  89 46 FC        mov word ptr [bp - 4], ax
1D16  81 7E FC B0 00  cmp word ptr [bp - 4], 0xb0
1D1B  76 05           jbe 0x1d22
1D1D  C7 46 FC B0 00  mov word ptr [bp - 4], 0xb0
loc_1D22:
1D22  81 7E 0A BE 03  cmp word ptr [bp + 0xa], 0x3be
1D27  75 1B           jne 0x1d44
1D29  80 3E D8 DC 09  cmp byte ptr [0xdcd8], 9
1D2E  75 14           jne 0x1d44
1D30  BF D3 1C        mov di, 0x1cd3
1D33  0E              push cs
1D34  57              push di
1D35  8D 7E EC        lea di, [bp - 0x14]
1D38  16              push ss
1D39  57              push di
1D3A  6A 0F           push 0xf
1D3C  9A 6D 0B B9 26  call far 26B9:0B6D
1D41  E9 85 00        jmp 0x1dc9
loc_1D44:
1D44  80 7E FF 01     cmp byte ptr [bp - 1], 1
1D48  74 45           je 0x1d8f
1D4A  8B 46 FC        mov ax, word ptr [bp - 4]
1D4D  31 D2           xor dx, dx
1D4F  05 FF FF        add ax, 0xffff
1D52  83 D2 FF        adc dx, -1
1D55  B9 10 00        mov cx, 0x10
1D58  31 DB           xor bx, bx
1D5A  9A 67 0A B9 26  call far 26B9:0A67
1D5F  05 01 00        add ax, 1
1D62  83 D2 00        adc dx, 0
1D65  8B D0           mov dx, ax
1D67  8A 46 FF        mov al, byte ptr [bp - 1]
1D6A  98              cwde
1D6B  6B F8 0C        imul di, ax, 0xc
1D6E  03 FA           add di, dx
1D70  8A 85 E0 0F     mov al, byte ptr [di + 0xfe0]
1D74  30 E4           xor ah, ah
1D76  8B F8           mov di, ax
1D78  C1 E7 04        shl di, 4
1D7B  81 C7 0C 8A     add di, 0x8a0c
1D7F  1E              push ds
1D80  57              push di
1D81  8D 7E EC        lea di, [bp - 0x14]
1D84  16              push ss
1D85  57              push di
1D86  6A 0F           push 0xf
1D88  9A 6D 0B B9 26  call far 26B9:0B6D
1D8D  EB 3A           jmp 0x1dc9
loc_1D8F:
1D8F  8B 46 FC        mov ax, word ptr [bp - 4]
1D92  31 D2           xor dx, dx
1D94  05 FF FF        add ax, 0xffff
1D97  83 D2 FF        adc dx, -1
1D9A  B9 08 00        mov cx, 8
1D9D  31 DB           xor bx, bx
1D9F  9A 67 0A B9 26  call far 26B9:0A67
1DA4  05 01 00        add ax, 1
1DA7  83 D2 00        adc dx, 0
1DAA  8B F8           mov di, ax
1DAC  8A 85 E1 0F     mov al, byte ptr [di + 0xfe1]
1DB0  30 E4           xor ah, ah
1DB2  8B F8           mov di, ax
1DB4  C1 E7 04        shl di, 4
1DB7  81 C7 0C 8A     add di, 0x8a0c
1DBB  1E              push ds
1DBC  57              push di
1DBD  8D 7E EC        lea di, [bp - 0x14]
1DC0  16              push ss
1DC1  57              push di
1DC2  6A 0F           push 0xf
1DC4  9A 6D 0B B9 26  call far 26B9:0B6D
loc_1DC9:
1DC9  8A 46 ED        mov al, byte ptr [bp - 0x13]
1DCC  50              push ax
1DCD  9A 86 19 B9 26  call far 26B9:1986
1DD2  88 46 ED        mov byte ptr [bp - 0x13], al
1DD5  8D 7E EC        lea di, [bp - 0x14]
1DD8  16              push ss
1DD9  57              push di
1DDA  8A 46 08        mov al, byte ptr [bp + 8]
1DDD  50              push ax
1DDE  8A 46 06        mov al, byte ptr [bp + 6]
1DE1  50              push ax
1DE2  BF 5C DD        mov di, 0xdd5c
1DE5  1E              push ds
1DE6  57              push di
1DE7  9A 83 02 1A 23  call far 231A:0283
1DEC  C9              leave
1DED  CA 06 00        retf 6

; ---- routine 1B51:1DF0  (found by: call, far)
sub_1DF0:
1DF0  C8 00 01 00     enter 0x100, 0
1DF4  6B 46 0A 0B     imul ax, word ptr [bp + 0xa], 0xb
1DF8  C4 3E CC DC     les di, ptr [0xdccc]
1DFC  03 F8           add di, ax
1DFE  06              push es
1DFF  57              push di
1E00  8A 46 08        mov al, byte ptr [bp + 8]
1E03  50              push ax
1E04  8A 46 06        mov al, byte ptr [bp + 6]
1E07  50              push ax
1E08  BF 5C DD        mov di, 0xdd5c
1E0B  1E              push ds
1E0C  57              push di
1E0D  9A 83 02 1A 23  call far 231A:0283
1E12  8D BE 00 FF     lea di, [bp - 0x100]
1E16  16              push ss
1E17  57              push di
1E18  8B 46 0A        mov ax, word ptr [bp + 0xa]
1E1B  C4 3E D4 DC     les di, ptr [0xdcd4]
1E1F  03 F8           add di, ax
1E21  26 8A 05        mov al, byte ptr es:[di]
1E24  50              push ax
1E25  9A 6F 0C B9 26  call far 26B9:0C6F
1E2A  8A 46 08        mov al, byte ptr [bp + 8]
1E2D  50              push ax
1E2E  6B 46 0A 0B     imul ax, word ptr [bp + 0xa], 0xb
1E32  C4 3E CC DC     les di, ptr [0xdccc]
1E36  03 F8           add di, ax
1E38  26 8A 05        mov al, byte ptr es:[di]
1E3B  30 E4           xor ah, ah
1E3D  40              inc ax
1E3E  8B D0           mov dx, ax
1E40  8B 46 06        mov ax, word ptr [bp + 6]
1E43  2B C2           sub ax, dx
1E45  50              push ax
1E46  BF 5C DD        mov di, 0xdd5c
1E49  1E              push ds
1E4A  57              push di
1E4B  9A 83 02 1A 23  call far 231A:0283
1E50  C9              leave
1E51  CA 06 00        retf 6

; ---- routine 1B51:1E54  (found by: call, far)
sub_1E54:
1E54  C8 00 01 00     enter 0x100, 0
1E58  8D BE 00 FF     lea di, [bp - 0x100]
1E5C  16              push ss
1E5D  57              push di
1E5E  8B 46 0A        mov ax, word ptr [bp + 0xa]
1E61  C4 3E D4 DC     les di, ptr [0xdcd4]
1E65  03 F8           add di, ax
1E67  26 8A 05        mov al, byte ptr es:[di]
1E6A  50              push ax
1E6B  9A 6F 0C B9 26  call far 26B9:0C6F
1E70  8A 46 08        mov al, byte ptr [bp + 8]
1E73  50              push ax
1E74  8A 46 06        mov al, byte ptr [bp + 6]
1E77  50              push ax
1E78  BF 5C DD        mov di, 0xdd5c
1E7B  1E              push ds
1E7C  57              push di
1E7D  9A 9D 03 1A 23  call far 231A:039D
1E82  6B 46 0A 0B     imul ax, word ptr [bp + 0xa], 0xb
1E86  C4 3E CC DC     les di, ptr [0xdccc]
1E8A  03 F8           add di, ax
1E8C  06              push es
1E8D  57              push di
1E8E  8A 46 08        mov al, byte ptr [bp + 8]
1E91  50              push ax
1E92  8B 46 06        mov ax, word ptr [bp + 6]
1E95  40              inc ax
1E96  40              inc ax
1E97  50              push ax
1E98  BF 5C DD        mov di, 0xdd5c
1E9B  1E              push ds
1E9C  57              push di
1E9D  9A 9D 03 1A 23  call far 231A:039D
1EA2  C9              leave
1EA3  CA 06 00        retf 6

; ---- routine 1B51:1EA6  (found by: call)
sub_1EA6:
1EA6  C8 0A 00 00     enter 0xa, 0
1EAA  6B 46 06 3E     imul ax, word ptr [bp + 6], 0x3e
1EAE  C4 3E C2 D7     les di, ptr [0xd7c2]
1EB2  03 F8           add di, ax
1EB4  81 C7 C2 FF     add di, 0xffc2
1EB8  89 7E F6        mov word ptr [bp - 0xa], di
1EBB  8C 46 F8        mov word ptr [bp - 8], es
1EBE  BF AA 39        mov di, 0x39aa
1EC1  1E              push ds
1EC2  57              push di
1EC3  BF 5C DD        mov di, 0xdd5c
1EC6  1E              push ds
1EC7  57              push di
1EC8  9A 2F 05 1A 23  call far 231A:052F
1ECD  FF 76 06        push word ptr [bp + 6]
1ED0  6A 02           push 2
1ED2  6A 22           push 0x22
1ED4  0E              push cs
1ED5  E8 6B EF        call 0xe43
1ED8  C7 46 FC 04 00  mov word ptr [bp - 4], 4
1EDD  C6 46 FF 00     mov byte ptr [bp - 1], 0
1EE1  EB 03           jmp 0x1ee6
loc_1EE3:
1EE3  FE 46 FF        inc byte ptr [bp - 1]
loc_1EE6:
1EE6  8A 46 FF        mov al, byte ptr [bp - 1]
1EE9  98              cwde
1EEA  D1 E0           shl ax, 1
1EEC  C4 7E F6        les di, ptr [bp - 0xa]
1EEF  03 F8           add di, ax
1EF1  26 8B 45 28     mov ax, word ptr es:[di + 0x28]
1EF5  89 46 FA        mov word ptr [bp - 6], ax
1EF8  83 7E FA 00     cmp word ptr [bp - 6], 0
1EFC  74 45           je 0x1f43
1EFE  FF 76 FA        push word ptr [bp - 6]
1F01  FF 76 FC        push word ptr [bp - 4]
1F04  6A 35           push 0x35
1F06  0E              push cs
1F07  E8 E6 FE        call 0x1df0
1F0A  8B 46 FA        mov ax, word ptr [bp - 6]
1F0D  C4 3E D0 DC     les di, ptr [0xdcd0]
1F11  03 F8           add di, ax
1F13  26 8A 05        mov al, byte ptr es:[di]
1F16  30 E4           xor ah, ah
1F18  8B F8           mov di, ax
1F1A  C1 E7 04        shl di, 4
1F1D  81 C7 2C 9A     add di, 0x9a2c
1F21  1E              push ds
1F22  57              push di
1F23  8B 46 FC        mov ax, word ptr [bp - 4]
1F26  40              inc ax
1F27  50              push ax
1F28  6A 35           push 0x35
1F2A  BF 5C DD        mov di, 0xdd5c
1F2D  1E              push ds
1F2E  57              push di
1F2F  9A 83 02 1A 23  call far 231A:0283
1F34  FF 76 FA        push word ptr [bp - 6]
1F37  8B 46 FC        mov ax, word ptr [bp - 4]
1F3A  40              inc ax
1F3B  40              inc ax
1F3C  50              push ax
1F3D  6A 35           push 0x35
1F3F  0E              push cs
1F40  E8 9B FD        call 0x1cde
loc_1F43:
1F43  83 46 FC 04     add word ptr [bp - 4], 4
1F47  80 7E FF 04     cmp byte ptr [bp - 1], 4
1F4B  75 96           jne 0x1ee3
1F4D  C9              leave
1F4E  CA 02 00        retf 2

