; 1-095.EXE (One-Nil 95), code segment 26B9 (image offsets 26B90..2853F), part 3 of 3
; packed 1-095.EXE sha256 f659fb2d334500d6901fc8d6a0f06c85c0ccda2eb4a3035ae3bb0a0004d79192 (LZEXE 0.91)
; unpacked (tools/static/unlzexe.py) sha256 8df646e017e0965a5d90a58181ca764219ad847833aad0b6cb58fc53372bfb2c
; tool: capstone 5.0.9 (pip package; core library 5.0.1280) (CS_ARCH_X86, CS_MODE_16), recursive descent from the entry point, far calls and near calls/jumps, then routine prologues (55 89 E5 / 55 8B EC / C8 iw 00) in what remains; tools/static/listing.py
; addresses are SEGMENT:OFFSET with SEGMENT the image paragraph before relocation; image offset = SEGMENT*16+OFFSET
; ---- routine 26B9:1312  (found by: call)
sub_1312:
1312  57              push di
1313  56              push si
1314  51              push cx
1315  E8 9D FC        call 0xfb5
1318  59              pop cx
1319  5E              pop si
131A  5F              pop di
131B  C3              ret

; ---- routine 26B9:131C  (found by: call)
sub_131C:
131C  57              push di
131D  56              push si
131E  51              push cx
131F  E8 8F FC        call 0xfb1
1322  59              pop cx
1323  5E              pop si
1324  5F              pop di
1325  C3              ret
; data (not reached as code), 10 bytes
1326                  db 57 56 51 E8 4C FD 59 5E 5F C3   ; WVQ.L.Y^_.

; ---- routine 26B9:1330  (found by: call)
sub_1330:
1330  57              push di
1331  56              push si
1332  51              push cx
1333  E8 45 FE        call 0x117b
1336  59              pop cx
1337  5E              pop si
1338  5F              pop di
1339  C3              ret
; data (not reached as code), 101 bytes
133A                  db 3C A8 73 49 8B C8 8B F3 8B FA 32 E4 33 DB 33 D2   ; <.sI......2.3.3.
134A                  db 80 E9 80 76 39 80 F9 10 72 0C 8A E7 8B DA BA FF   ; ...v9...r.......
135A                  db FF 80 E9 10 EB EF 80 F9 08 72 0D 8A E3 8A DF 8A   ; .........r......
136A                  db FA 8A D6 B6 FF 80 E9 08 0A C9 74 0B F9 D1 DA D1   ; ..........t.....
137A                  db DB D0 DC FE C9 75 F5 23 D7 23 DE 22 E5 CB 32 C0   ; .....u.#.#."..2.
138A                  db CB 52 53 50 0E E8 A8 FF 8B C8 8B F3 8B FA 58 5B   ; .RSP..........X[
139A                  db 5A E8 13 FC CB   ; Z....

; ---- routine 26B9:139F  (found by: prologue)
sub_139F:
139F  55              push bp
13A0  8B EC           mov bp, sp
13A2  83 EC 08        sub sp, 8
13A5  8B C8           mov cx, ax
13A7  8B F3           mov si, bx
13A9  8B FA           mov di, dx
13AB  0A C0           or al, al
13AD  74 3C           je 0x13eb
13AF  F6 C6 80        test dh, 0x80
13B2  75 41           jne 0x13f5
13B4  89 46 F8        mov word ptr [bp - 8], ax
13B7  89 5E FA        mov word ptr [bp - 6], bx
13BA  89 56 FC        mov word ptr [bp - 4], dx
13BD  80 C1 80        add cl, 0x80
13C0  D0 F9           sar cl, 1
13C2  80 C1 80        add cl, 0x80
13C5  8A C1           mov al, cl
13C7  2C 14           sub al, 0x14
13C9  88 46 FE        mov byte ptr [bp - 2], al
loc_13CC:
13CC  8B 46 F8        mov ax, word ptr [bp - 8]
13CF  8B 5E FA        mov bx, word ptr [bp - 6]
13D2  8B 56 FC        mov dx, word ptr [bp - 4]
13D5  E8 58 FF        call 0x1330
13D8  E8 37 FF        call 0x1312
13DB  FE C8           dec al
13DD  52              push dx
13DE  53              push bx
13DF  50              push ax
13E0  E8 CE FB        call 0xfb1
13E3  3A 46 FE        cmp al, byte ptr [bp - 2]
13E6  59              pop cx
13E7  5E              pop si
13E8  5F              pop di
13E9  73 E1           jae 0x13cc
loc_13EB:
13EB  8B C1           mov ax, cx
13ED  8B DE           mov bx, si
13EF  8B D7           mov dx, di
13F1  8B E5           mov sp, bp
13F3  5D              pop bp
13F4  CB              retf
loc_13F5:
13F5  8B E5           mov sp, bp
13F7  5D              pop bp
13F8  B8 CF 00        mov ax, 0xcf
13FB  E9 11 ED        jmp 0x10f
; data (not reached as code), 158 bytes
13FE                  db B9 81 21 BE A2 DA BF 0F C9 E8 AB FB 0A C0 74 03   ; ..!...........t.
140E                  db 80 F6 80 3C 6C 72 5C B9 83 21 BE A2 DA BF 0F 49   ; ...<lr\..!.....I
141E                  db 52 80 E6 7F E8 CD FD 5A 72 10 E8 05 FF 57 56 51   ; R......Zr....WVQ
142E                  db 0E E8 59 FF 59 5E 5F E8 EE FE F6 C6 80 74 03 E8   ; ..Y.Y^_......t..
143E                  db D2 FE FE C9 E8 AD FD 9C 72 03 E8 D1 FE FE C9 E8   ; ........r.......
144E                  db A2 FD 72 08 FE C1 80 CE 80 E8 5B FB 3C 6C 72 09   ; ..r.......[.<lr.
145E                  db BF 72 14 B9 07 00 E8 B6 02 9D 72 07 0A C0 74 03   ; .r........r...t.
146E                  db 80 F6 80 CB 58 9D 39 9F 3F D7 60 43 9D 30 92 30   ; ....X.9.?.`C.0.0
147E                  db 67 AA 3F 28 32 D7 6E B6 2A 1D EF 38 74 0D D0 00   ; g.?(2.n.*..8t...
148E                  db 0D D0 7A 88 88 88 88 08 7E AB AA AA AA AA   ; ..z.....~.....

; ---- routine 26B9:149C  (found by: far)
sub_149C:
149C  0A C0           or al, al
149E  74 05           je 0x14a5
14A0  F6 C6 80        test dh, 0x80
14A3  74 06           je 0x14ab
loc_14A5:
14A5  B8 CF 00        mov ax, 0xcf
14A8  E9 64 EC        jmp 0x10f
loc_14AB:
14AB  B1 81           mov cl, 0x81
14AD  2A C1           sub al, cl
14AF  50              push ax
14B0  8A C1           mov al, cl
14B2  B9 80 FB        mov cx, 0xfb80
14B5  BE 33 F3        mov si, 0xf333
14B8  BF 04 35        mov di, 0x3504
14BB  E8 BA FB        call 0x1078
14BE  8B C8           mov cx, ax
14C0  8B F3           mov si, bx
14C2  8B FA           mov di, dx
14C4  B8 81 00        mov ax, 0x81
14C7  33 DB           xor bx, bx
14C9  33 D2           xor dx, dx
14CB  E8 44 FE        call 0x1312
14CE  52              push dx
14CF  53              push bx
14D0  50              push ax
14D1  B8 81 00        mov ax, 0x81
14D4  33 DB           xor bx, bx
14D6  BA 00 80        mov dx, 0x8000
14D9  E8 D9 FA        call 0xfb5
14DC  59              pop cx
14DD  5E              pop si
14DE  5F              pop di
14DF  E8 99 FC        call 0x117b
14E2  BF 21 15        mov di, 0x1521
14E5  B9 06 00        mov cx, 6
14E8  E8 32 02        call 0x171d
14EB  FE C0           inc al
14ED  B9 7F D2        mov cx, 0xd27f
14F0  BE F7 17        mov si, 0x17f7
14F3  BF 72 31        mov di, 0x3172
14F6  E8 BC FA        call 0xfb5
14F9  59              pop cx
14FA  52              push dx
14FB  53              push bx
14FC  50              push ax
14FD  8A C1           mov al, cl
14FF  98              cwde
1500  99              cdq
1501  E8 18 FD        call 0x121c
1504  B9 80 D2        mov cx, 0xd280
1507  BE F7 17        mov si, 0x17f7
150A  BF 72 31        mov di, 0x3172
150D  E8 68 FB        call 0x1078
1510  59              pop cx
1511  5E              pop si
1512  5F              pop di
1513  E8 9F FA        call 0xfb5
1516  3C 67           cmp al, 0x67
1518  73 06           jae 0x1520
151A  33 C0           xor ax, ax
151C  33 DB           xor bx, bx
151E  33 D2           xor dx, dx
loc_1520:
1520  CB              retf
; data (not reached as code), 36 bytes
1521                  db 7D 8A 9D D8 89 1D 7D E9 A2 8B 2E 3A 7D 8E E3 38   ; }.....}....:}..8
1531                  db 8E 63 7E 49 92 24 49 12 7E CD CC CC CC 4C 7F AB   ; .c~I.$I.~....L..
1541                  db AA AA AA 2A   ; ...*

; ---- routine 26B9:1545  (found by: far)
sub_1545:
1545  F6 C6 80        test dh, 0x80
1548  9C              pushf
1549  80 E6 7F        and dh, 0x7f
154C  B9 80 D2        mov cx, 0xd280
154F  BE F7 17        mov si, 0x17f7
1552  BF 72 31        mov di, 0x3172
1555  E8 23 FC        call 0x117b
1558  3C 88           cmp al, 0x88
155A  73 55           jae 0x15b1
155C  52              push dx
155D  53              push bx
155E  50              push ax
155F  FE C0           inc al
1561  B5 FF           mov ch, 0xff
1563  E8 F2 FC        call 0x1258
1566  59              pop cx
1567  5E              pop si
1568  5F              pop di
1569  50              push ax
156A  51              push cx
156B  E8 AE FC        call 0x121c
156E  59              pop cx
156F  0A C0           or al, al
1571  74 02           je 0x1575
1573  FE C8           dec al
loc_1575:
1575  91              xchg cx, ax
1576  87 DE           xchg si, bx
1578  87 D7           xchg di, dx
157A  E8 34 FA        call 0xfb1
157D  BF B8 15        mov di, 0x15b8
1580  B9 08 00        mov cx, 8
1583  E8 B0 01        call 0x1736
1586  59              pop cx
1587  D1 E9           shr cx, 1
1589  73 0E           jae 0x1599
158B  51              push cx
158C  B9 81 FB        mov cx, 0xfb81
158F  BE 33 F3        mov si, 0xf333
1592  BF 04 35        mov di, 0x3504
1595  E8 E0 FA        call 0x1078
1598  59              pop cx
loc_1599:
1599  02 C1           add al, cl
159B  72 14           jb 0x15b1
159D  9D              popf
159E  74 10           je 0x15b0
15A0  8B C8           mov cx, ax
15A2  8B F3           mov si, bx
15A4  8B FA           mov di, dx
15A6  B8 81 00        mov ax, 0x81
15A9  33 DB           xor bx, bx
15AB  33 D2           xor dx, dx
15AD  E8 CB FB        call 0x117b
loc_15B0:
15B0  CB              retf
loc_15B1:
15B1  58              pop ax
15B2  B8 CD 00        mov ax, 0xcd
15B5  E9 57 EB        jmp 0x10f
; data (not reached as code), 48 bytes
15B8                  db 6D 2E 1D 11 60 31 70 46 2C FE E5 7F 74 36 7C 89   ; m...`1pF,...t6|.
15C8                  db 84 21 77 53 3C FF C3 2E 7A D2 7D 5B 95 1D 7C 25   ; .!wS<...z.}[..|%
15D8                  db B8 46 58 63 7E 16 FC EF FD 75 80 D2 F7 17 72 31   ; .FXc~....u....r1

; ---- routine 26B9:15E8  (found by: prologue)
sub_15E8:
15E8  55              push bp
15E9  8B EC           mov bp, sp
15EB  83 EC 06        sub sp, 6
15EE  0A C0           or al, al
15F0  75 03           jne 0x15f5
15F2  E9 D0 00        jmp 0x16c5
loc_15F5:
15F5  33 C9           xor cx, cx
15F7  F6 C6 80        test dh, 0x80
15FA  74 04           je 0x1600
15FC  41              inc cx
15FD  80 E6 7F        and dh, 0x7f
loc_1600:
1600  51              push cx
1601  B9 81 00        mov cx, 0x81
1604  33 F6           xor si, si
1606  33 FF           xor di, di
1608  E8 E7 FB        call 0x11f2
160B  72 0C           jb 0x1619
160D  91              xchg cx, ax
160E  87 DE           xchg si, bx
1610  87 D7           xchg di, dx
1612  E8 66 FB        call 0x117b
1615  59              pop cx
1616  41              inc cx
1617  41              inc cx
1618  51              push cx
loc_1619:
1619  B9 7E 4A        mov cx, 0x4a7e
161C  BE 8E E9        mov si, 0xe98e
161F  BF 6F 0C        mov di, 0xc6f
1622  E8 CD FB        call 0x11f2
1625  73 05           jae 0x162c
1627  E8 ED 00        call 0x1717
162A  EB 77           jmp 0x16a3
loc_162C:
162C  BF C9 16        mov di, 0x16c9
162F  B9 02 00        mov cx, 2
1632  51              push cx
1633  57              push di
1634  2E 8B 0D        mov cx, word ptr cs:[di]
1637  2E 8B 75 02     mov si, word ptr cs:[di + 2]
163B  2E 8B 7D 04     mov di, word ptr cs:[di + 4]
163F  E8 B0 FB        call 0x11f2
1642  5F              pop di
1643  59              pop cx
1644  72 08           jb 0x164e
1646  83 C7 12        add di, 0x12
1649  E2 E7           loop 0x1632
164B  83 EF 06        sub di, 6
loc_164E:
164E  83 C7 06        add di, 6
1651  89 46 FA        mov word ptr [bp - 6], ax
1654  89 5E FC        mov word ptr [bp - 4], bx
1657  89 56 FE        mov word ptr [bp - 2], dx
165A  57              push di
165B  2E 8B 0D        mov cx, word ptr cs:[di]
165E  2E 8B 75 02     mov si, word ptr cs:[di + 2]
1662  2E 8B 7D 04     mov di, word ptr cs:[di + 4]
1666  E8 B3 FC        call 0x131c
1669  52              push dx
166A  53              push bx
166B  50              push ax
166C  8B 46 FA        mov ax, word ptr [bp - 6]
166F  8B 5E FC        mov bx, word ptr [bp - 4]
1672  8B 56 FE        mov dx, word ptr [bp - 2]
1675  E8 00 FA        call 0x1078
1678  B9 81 00        mov cx, 0x81
167B  33 F6           xor si, si
167D  33 FF           xor di, di
167F  E8 33 F9        call 0xfb5
1682  8B C8           mov cx, ax
1684  8B F3           mov si, bx
1686  8B FA           mov di, dx
1688  58              pop ax
1689  5B              pop bx
168A  5A              pop dx
168B  E8 ED FA        call 0x117b
168E  E8 86 00        call 0x1717
1691  5F              pop di
1692  83 C7 06        add di, 6
1695  2E 8B 0D        mov cx, word ptr cs:[di]
1698  2E 8B 75 02     mov si, word ptr cs:[di + 2]
169C  2E 8B 7D 04     mov di, word ptr cs:[di + 4]
16A0  E8 12 F9        call 0xfb5
loc_16A3:
16A3  59              pop cx
16A4  F6 C1 02        test cl, 2
16A7  74 14           je 0x16bd
16A9  51              push cx
16AA  8B C8           mov cx, ax
16AC  8B F3           mov si, bx
16AE  8B FA           mov di, dx
16B0  B8 81 21        mov ax, 0x2181
16B3  BB A2 DA        mov bx, 0xdaa2
16B6  BA 0F 49        mov dx, 0x490f
16B9  E8 F5 F8        call 0xfb1
16BC  59              pop cx
loc_16BD:
16BD  F6 C1 01        test cl, 1
16C0  74 03           je 0x16c5
16C2  80 CE 80        or dh, 0x80
loc_16C5:
16C5  8B E5           mov sp, bp
16C7  5D              pop bp
16C8  CB              retf
; data (not reached as code), 78 bytes
16C9                  db 7F E7 CF CC 13 54 7F F6 F4 A2 30 09 7F 6A C1 91   ; .....T....0..j..
16D9                  db 0A 06 80 B5 9E 8A 6F 44 80 82 2C 3A CD 13 80 6A   ; ......oD..,:...j
16E9                  db C1 91 0A 06 81 00 00 00 00 00 80 21 A2 DA 0F 49   ; ...........!...I
16F9                  db 7D E8 A2 8B 2E BA 7D 8E E3 38 8E 63 7E 49 92 24   ; }.....}..8.c~I.$
1709                  db 49 92 7E CD CC CC CC 4C 7F AB AA AA AA AA   ; I.~....L......

; ---- routine 26B9:1717  (found by: call)
sub_1717:
1717  BF F9 16        mov di, 0x16f9
171A  B9 05 00        mov cx, 5

; ---- routine 26B9:171D  (found by: call)
sub_171D:
171D  52              push dx
171E  53              push bx
171F  50              push ax
1720  51              push cx
1721  57              push di
1722  8B C8           mov cx, ax
1724  8B F3           mov si, bx
1726  8B FA           mov di, dx
1728  E8 4D F9        call 0x1078
172B  5F              pop di
172C  59              pop cx
172D  E8 06 00        call 0x1736
1730  59              pop cx
1731  5E              pop si
1732  5F              pop di
1733  E9 42 F9        jmp 0x1078

; ---- routine 26B9:1736  (found by: call)
sub_1736:
1736  55              push bp
1737  8B EC           mov bp, sp
1739  83 EC 06        sub sp, 6
173C  89 46 FA        mov word ptr [bp - 6], ax
173F  89 5E FC        mov word ptr [bp - 4], bx
1742  89 56 FE        mov word ptr [bp - 2], dx
1745  2E 8B 05        mov ax, word ptr cs:[di]
1748  2E 8B 5D 02     mov bx, word ptr cs:[di + 2]
174C  2E 8B 55 04     mov dx, word ptr cs:[di + 4]
1750  51              push cx
1751  57              push di
1752  EB 10           jmp 0x1764
; data (not reached as code), 16 bytes
1754                  db 51 57 2E 8B 0D 2E 8B 75 02 2E 8B 7D 04 E8 51 F8   ; QW.....u...}..Q.
loc_1764:
1764  8B 4E FA        mov cx, word ptr [bp - 6]
1767  8B 76 FC        mov si, word ptr [bp - 4]
176A  8B 7E FE        mov di, word ptr [bp - 2]
176D  E8 08 F9        call 0x1078
1770  5F              pop di
1771  59              pop cx
1772  83 C7 06        add di, 6
1775  E2 DD           loop 0x1754
1777  B9 81 00        mov cx, 0x81
177A  33 F6           xor si, si
177C  33 FF           xor di, di
177E  E8 34 F8        call 0xfb5
1781  8B E5           mov sp, bp
1783  5D              pop bp
1784  C3              ret
; data (not reached as code), 149 bytes
1785                  db E8 5A 00 8B DC 8B CA 36 F7 67 04 8B C1 8B CA 36   ; .Z.....6.g.....6
1795                  db F7 67 04 03 C1 83 D2 00 8B C2 CA 02 00 E8 3D 00   ; .g............=.
17A5                  db 93 B8 80 00 B9 20 00 F6 C6 80 75 0A D1 E3 D1 D2   ; ..... ....u.....
17B5                  db FE C8 E2 F3 32 C0 80 E6 7F CB E8 20 00 CD 3C 9F   ; ....2...... ..<.
17C5                  db 06 E0 17 CD 37 06 1C A5 CD 3C 98 06 DC 17 CD 35   ; ....7....<.....5
17D5                  db FD CD 39 D9 CD 3D CB 00 00 00 4F E0 FF A1 1C A5   ; ..9..=....O.....
17E5                  db 8B 1E 1E A5 8B C8 2E F7 26 18 18 D1 E1 D1 E1 D1   ; ........&.......
17F5                  db E1 02 E9 03 D1 03 D3 D1 E3 D1 E3 03 D3 02 F3 B1   ; ................
1805                  db 05 D3 E3 02 F3 05 01 00 83 D2 00 A3 1C A5 89 16   ; ................
1815                  db 1E A5 C3 05 84   ; .....

; ---- routine 26B9:181A  (found by: far)
sub_181A:
181A  B4 2C           mov ah, 0x2c
181C  CD 21           int 0x21   ; INT 21h AH=2C get time
181E  89 0E 1C A5     mov word ptr [0xa51c], cx
1822  89 16 1E A5     mov word ptr [0xa51e], dx
1826  CB              retf

; ---- routine 26B9:1827  (found by: call)
sub_1827:
1827  8B CF           mov cx, di
1829  BE 0A 00        mov si, 0xa
182C  8B DA           mov bx, dx
182E  0B DB           or bx, bx
1830  79 11           jns 0x1843
1832  F7 DB           neg bx
1834  F7 D8           neg ax
1836  83 DB 00        sbb bx, 0
1839  E8 07 00        call 0x1843
183C  4F              dec di
183D  26 C6 05 2D     mov byte ptr es:[di], 0x2d
1841  41              inc cx
1842  C3              ret

; ---- routine 26B9:1843  (found by: call, jump)
sub_1843:
1843  33 D2           xor dx, dx
1845  93              xchg bx, ax
1846  F7 F6           div si
1848  93              xchg bx, ax
1849  F7 F6           div si
184B  80 C2 30        add dl, 0x30
184E  80 FA 3A        cmp dl, 0x3a
1851  72 03           jb 0x1856
1853  80 C2 07        add dl, 7
loc_1856:
1856  4F              dec di
1857  26 88 15        mov byte ptr es:[di], dl
185A  8B D0           mov dx, ax
185C  0B D3           or dx, bx
185E  75 E3           jne 0x1843
1860  2B CF           sub cx, di
1862  C3              ret

; ---- routine 26B9:1863  (found by: call)
sub_1863:
1863  33 C0           xor ax, ax
1865  33 D2           xor dx, dx
1867  33 F6           xor si, si
1869  E3 5D           jcxz 0x18c8
186B  26 80 3D 2B     cmp byte ptr es:[di], 0x2b
186F  74 07           je 0x1878
1871  26 80 3D 2D     cmp byte ptr es:[di], 0x2d
1875  75 05           jne 0x187c
1877  4E              dec si
loc_1878:
1878  47              inc di
1879  49              dec cx
187A  74 4C           je 0x18c8
loc_187C:
187C  26 80 3D 24     cmp byte ptr es:[di], 0x24
1880  74 48           je 0x18ca
1882  26 8A 1D        mov bl, byte ptr es:[di]
1885  80 EB 3A        sub bl, 0x3a
1888  80 C3 0A        add bl, 0xa
188B  73 25           jae 0x18b2
188D  F6 C6 F0        test dh, 0xf0
1890  75 36           jne 0x18c8
1892  53              push bx
1893  D1 E0           shl ax, 1
1895  D1 D2           rcl dx, 1
1897  52              push dx
1898  50              push ax
1899  D1 E0           shl ax, 1
189B  D1 D2           rcl dx, 1
189D  D1 E0           shl ax, 1
189F  D1 D2           rcl dx, 1
18A1  5B              pop bx
18A2  03 C3           add ax, bx
18A4  5B              pop bx
18A5  13 D3           adc dx, bx
18A7  5B              pop bx
18A8  32 FF           xor bh, bh
18AA  03 C3           add ax, bx
18AC  83 D2 00        adc dx, 0
18AF  47              inc di
18B0  E2 D0           loop 0x1882
loc_18B2:
18B2  8B D8           mov bx, ax
18B4  0B DA           or bx, dx
18B6  74 0F           je 0x18c7
18B8  0B F6           or si, si
18BA  79 07           jns 0x18c3
18BC  F7 DA           neg dx
18BE  F7 D8           neg ax
18C0  83 DA 00        sbb dx, 0
loc_18C3:
18C3  33 F2           xor si, dx
18C5  78 01           js 0x18c8
loc_18C7:
18C7  C3              ret
loc_18C8:
18C8  F9              stc
18C9  C3              ret
loc_18CA:
18CA  47              inc di
18CB  49              dec cx
18CC  74 FA           je 0x18c8
18CE  26 8A 1D        mov bl, byte ptr es:[di]
18D1  80 FB 61        cmp bl, 0x61
18D4  72 03           jb 0x18d9
18D6  80 EB 20        sub bl, 0x20
loc_18D9:
18D9  80 EB 3A        sub bl, 0x3a
18DC  80 C3 0A        add bl, 0xa
18DF  72 0B           jb 0x18ec
18E1  80 EB 17        sub bl, 0x17
18E4  80 C3 06        add bl, 6
18E7  73 C9           jae 0x18b2
18E9  80 C3 0A        add bl, 0xa
loc_18EC:
18EC  B7 04           mov bh, 4
loc_18EE:
18EE  D1 E0           shl ax, 1
18F0  D1 D2           rcl dx, 1
18F2  72 D4           jb 0x18c8
18F4  FE CF           dec bh
18F6  75 F6           jne 0x18ee
18F8  0A C3           or al, bl
18FA  47              inc di
18FB  E2 D1           loop 0x18ce
18FD  0B F6           or si, si
18FF  79 07           jns 0x1908
1901  F7 DA           neg dx
1903  F7 D8           neg ax
1905  83 DA 00        sbb dx, 0
loc_1908:
1908  F8              clc
1909  C3              ret

; ---- routine 26B9:190A  (found by: far)
sub_190A:
190A  55              push bp
190B  8B EC           mov bp, sp
190D  83 EC 20        sub sp, 0x20
1910  8B 46 0E        mov ax, word ptr [bp + 0xe]
1913  8B 56 10        mov dx, word ptr [bp + 0x10]
1916  8D 7E 00        lea di, [bp]
1919  16              push ss
191A  07              pop es
191B  E8 09 FF        call 0x1827
191E  1E              push ds
191F  8B F7           mov si, di
1921  16              push ss
1922  1F              pop ds
1923  C4 7E 08        les di, ptr [bp + 8]
1926  8B 56 06        mov dx, word ptr [bp + 6]
1929  8B 46 0C        mov ax, word ptr [bp + 0xc]
192C  3B C2           cmp ax, dx
192E  7E 02           jle 0x1932
1930  8B C2           mov ax, dx
loc_1932:
1932  3B CA           cmp cx, dx
1934  7E 02           jle 0x1938
1936  8B CA           mov cx, dx
loc_1938:
1938  3B C1           cmp ax, cx
193A  7D 02           jge 0x193e
193C  8B C1           mov ax, cx
loc_193E:
193E  FC              cld
193F  AA              stosb byte ptr es:[di], al
1940  2B C1           sub ax, cx
1942  74 08           je 0x194c
1944  51              push cx
1945  8B C8           mov cx, ax
1947  B0 20           mov al, 0x20
1949  F3 AA           rep stosb byte ptr es:[di], al
194B  59              pop cx
loc_194C:
194C  F3 A4           rep movsb byte ptr es:[di], byte ptr [si]
194E  1F              pop ds
194F  8B E5           mov sp, bp
1951  5D              pop bp
1952  CA 0C 00        retf 0xc

; ---- routine 26B9:1955  (found by: prologue)
sub_1955:
1955  55              push bp
1956  8B EC           mov bp, sp
1958  C4 7E 0A        les di, ptr [bp + 0xa]
195B  26 8A 0D        mov cl, byte ptr es:[di]
195E  32 ED           xor ch, ch
1960  47              inc di
1961  E3 09           jcxz 0x196c
1963  26 80 3D 20     cmp byte ptr es:[di], 0x20
1967  75 03           jne 0x196c
1969  47              inc di
196A  E2 F7           loop 0x1963
loc_196C:
196C  E8 F4 FE        call 0x1863
196F  72 02           jb 0x1973
1971  E3 09           jcxz 0x197c
loc_1973:
1973  8B CF           mov cx, di
1975  2B 4E 0A        sub cx, word ptr [bp + 0xa]
1978  33 C0           xor ax, ax
197A  33 D2           xor dx, dx
loc_197C:
197C  C4 7E 06        les di, ptr [bp + 6]
197F  26 89 0D        mov word ptr es:[di], cx
1982  5D              pop bp
1983  CA 08 00        retf 8

; ---- routine 26B9:1986  (found by: far)
sub_1986:
1986  8B DC           mov bx, sp
1988  36 8A 47 04     mov al, byte ptr ss:[bx + 4]
198C  3C 61           cmp al, 0x61
198E  72 06           jb 0x1996
1990  3C 7A           cmp al, 0x7a
1992  77 02           ja 0x1996
1994  2C 20           sub al, 0x20
loc_1996:
1996  CA 02 00        retf 2

; ---- routine 26B9:1999  (found by: call)
sub_1999:
1999  BF 30 A5        mov di, 0xa530
199C  1E              push ds
199D  07              pop es
199E  B9 74 FB        mov cx, 0xfb74
19A1  2B CF           sub cx, di
19A3  D1 E9           shr cx, 1
19A5  33 C0           xor ax, ax
19A7  FC              cld
19A8  F3 AB           rep stosw word ptr es:[di], ax
19AA  C3              ret
; data (not reached as code), 5 bytes
19AB                  db 00 00 00 00 00   ; .....
