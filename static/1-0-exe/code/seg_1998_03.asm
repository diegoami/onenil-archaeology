; 1-0.EXE (One-Nil 96), code segment 1998 (image offsets 19980..1B54F), part 3 of 3
; packed 1-0.EXE sha256 89ff9c5f238f24e81a0c2440a46cdd8997280a65fc3cc3d97cb974f55280a80a (LZEXE 0.91)
; unpacked (tools/static/unlzexe.py) sha256 887ed2a92767950e5309b2052409f875668605939b69e00737aa3047022b9f51
; tool: capstone 5.0.9 (pip package; core library 5.0.1280) (CS_ARCH_X86, CS_MODE_16), recursive descent from the entry point, far calls and near calls/jumps, then routine prologues (55 89 E5 / 55 8B EC / C8 iw 00) in what remains; tools/static/listing.py
; addresses are SEGMENT:OFFSET with SEGMENT the image paragraph before relocation; image offset = SEGMENT*16+OFFSET
; ---- routine 1998:13F9  (found by: call)
sub_13F9:
13F9  C8 0A 00 00     enter 0xa, 0
13FD  8B 46 04        mov ax, word ptr [bp + 4]
1400  C1 E0 03        shl ax, 3
1403  C4 3E BA D7     les di, ptr [0xd7ba]
1407  03 F8           add di, ax
1409  89 7E FA        mov word ptr [bp - 6], di
140C  8C 46 FC        mov word ptr [bp - 4], es
140F  6B 46 04 0F     imul ax, word ptr [bp + 4], 0xf
1413  C4 3E BE D7     les di, ptr [0xd7be]
1417  03 F8           add di, ax
1419  89 7E F6        mov word ptr [bp - 0xa], di
141C  8C 46 F8        mov word ptr [bp - 8], es
141F  FF 76 04        push word ptr [bp + 4]
1422  6A 02           push 2
1424  9A 6D 07 2A 23  call far 232A:076D
1429  50              push ax
142A  6A 08           push 8
142C  9A 6D 07 2A 23  call far 232A:076D
1431  F7 D8           neg ax
1433  5A              pop dx
1434  03 C2           add ax, dx
1436  8B D0           mov dx, ax
1438  C4 7E F6        les di, ptr [bp - 0xa]
143B  26 8A 45 07     mov al, byte ptr es:[di + 7]
143F  98              cwde
1440  03 C2           add ax, dx
1442  50              push ax
1443  E8 A6 FD        call 0x11ec
1446  C4 7E F6        les di, ptr [bp - 0xa]
1449  26 88 45 07     mov byte ptr es:[di + 7], al
144D  C4 7E FA        les di, ptr [bp - 6]
1450  26 8A 05        mov al, byte ptr es:[di]
1453  30 E4           xor ah, ah
1455  6B C0 3E        imul ax, ax, 0x3e
1458  C4 3E C2 D7     les di, ptr [0xd7c2]
145C  03 F8           add di, ax
145E  26 8B 45 EE     mov ax, word ptr es:[di - 0x12]
1462  C1 E0 02        shl ax, 2
1465  C4 3E C8 DC     les di, ptr [0xdcc8]
1469  03 F8           add di, ax
146B  26 8A 45 02     mov al, byte ptr es:[di + 2]
146F  30 E4           xor ah, ah
1471  C1 E8 05        shr ax, 5
1474  40              inc ax
1475  50              push ax
1476  9A 6D 07 2A 23  call far 232A:076D
147B  C4 7E F6        les di, ptr [bp - 0xa]
147E  26 28 45 0E     sub byte ptr es:[di + 0xe], al
1482  26 80 7D 0E 00  cmp byte ptr es:[di + 0xe], 0
1487  7D 05           jge 0x148e
1489  26 C6 45 0E 00  mov byte ptr es:[di + 0xe], 0
loc_148E:
148E  C4 7E F6        les di, ptr [bp - 0xa]
1491  26 80 7D 0E 00  cmp byte ptr es:[di + 0xe], 0
1496  B0 00           mov al, 0
1498  75 01           jne 0x149b
149A  40              inc ax
loc_149B:
149B  88 46 FF        mov byte ptr [bp - 1], al
149E  8A 46 FF        mov al, byte ptr [bp - 1]
14A1  C9              leave
14A2  C2 02 00        ret 2

; ---- routine 1998:14A5  (found by: call)
sub_14A5:
14A5  C8 04 00 00     enter 4, 0
14A9  6B 46 06 0F     imul ax, word ptr [bp + 6], 0xf
14AD  C4 3E BE D7     les di, ptr [0xd7be]
14B1  03 F8           add di, ax
14B3  89 7E FC        mov word ptr [bp - 4], di
14B6  8C 46 FE        mov word ptr [bp - 2], es
14B9  26 80 7D 08 00  cmp byte ptr es:[di + 8], 0
14BE  7E 6B           jle 0x152b
14C0  80 7E 04 00     cmp byte ptr [bp + 4], 0
14C4  74 2E           je 0x14f4
14C6  FF 76 06        push word ptr [bp + 6]
14C9  6A 02           push 2
14CB  9A 6D 07 2A 23  call far 232A:076D
14D0  50              push ax
14D1  6A 08           push 8
14D3  9A 6D 07 2A 23  call far 232A:076D
14D8  8B D0           mov dx, ax
14DA  C4 7E FC        les di, ptr [bp - 4]
14DD  26 8A 45 07     mov al, byte ptr es:[di + 7]
14E1  98              cwde
14E2  03 C2           add ax, dx
14E4  5A              pop dx
14E5  2B C2           sub ax, dx
14E7  50              push ax
14E8  E8 01 FD        call 0x11ec
14EB  C4 7E FC        les di, ptr [bp - 4]
14EE  26 88 45 07     mov byte ptr es:[di + 7], al
14F2  EB 37           jmp 0x152b
loc_14F4:
14F4  FF 76 06        push word ptr [bp + 6]
14F7  6A 03           push 3
14F9  9A 6D 07 2A 23  call far 232A:076D
14FE  50              push ax
14FF  6A 02           push 2
1501  9A 6D 07 2A 23  call far 232A:076D
1506  8B D0           mov dx, ax
1508  C4 7E FC        les di, ptr [bp - 4]
150B  26 8A 45 07     mov al, byte ptr es:[di + 7]
150F  98              cwde
1510  03 C2           add ax, dx
1512  5A              pop dx
1513  2B C2           sub ax, dx
1515  50              push ax
1516  E8 D3 FC        call 0x11ec
1519  C4 7E FC        les di, ptr [bp - 4]
151C  26 88 45 07     mov byte ptr es:[di + 7], al
1520  26 80 7D 07 19  cmp byte ptr es:[di + 7], 0x19
1525  7D 04           jge 0x152b
1527  26 FE 45 07     inc byte ptr es:[di + 7]
loc_152B:
152B  C4 7E FC        les di, ptr [bp - 4]
152E  26 80 7D 08 00  cmp byte ptr es:[di + 8], 0
1533  7F 0A           jg 0x153f
1535  FF 76 06        push word ptr [bp + 6]
1538  E8 BE FE        call 0x13f9
153B  08 C0           or al, al
153D  74 0B           je 0x154a
loc_153F:
153F  C4 7E FC        les di, ptr [bp - 4]
1542  26 8A 45 07     mov al, byte ptr es:[di + 7]
1546  26 88 45 08     mov byte ptr es:[di + 8], al
loc_154A:
154A  C9              leave
154B  C2 04 00        ret 4

; ---- routine 1998:154E  (found by: call)
sub_154E:
154E  C8 0A 00 00     enter 0xa, 0
1552  8B 46 06        mov ax, word ptr [bp + 6]
1555  C1 E0 03        shl ax, 3
1558  C4 3E BA D7     les di, ptr [0xd7ba]
155C  03 F8           add di, ax
155E  89 7E FA        mov word ptr [bp - 6], di
1561  8C 46 FC        mov word ptr [bp - 4], es
1564  6B 46 06 0F     imul ax, word ptr [bp + 6], 0xf
1568  C4 3E BE D7     les di, ptr [0xd7be]
156C  03 F8           add di, ax
156E  89 7E F6        mov word ptr [bp - 0xa], di
1571  8C 46 F8        mov word ptr [bp - 8], es
1574  80 7E 04 00     cmp byte ptr [bp + 4], 0
1578  75 12           jne 0x158c
157A  6A 02           push 2
157C  26 8A 45 0B     mov al, byte ptr es:[di + 0xb]
1580  30 E4           xor ah, ah
1582  50              push ax
1583  9A 59 02 BC 24  call far 24BC:0259
1588  08 C0           or al, al
158A  74 44           je 0x15d0
loc_158C:
158C  C4 7E FA        les di, ptr [bp - 6]
158F  26 8A 45 04     mov al, byte ptr es:[di + 4]
1593  30 E4           xor ah, ah
1595  89 46 FE        mov word ptr [bp - 2], ax
1598  FF 76 06        push word ptr [bp + 6]
159B  9A 84 52 55 1B  call far 1B55:5284
15A0  C4 7E FA        les di, ptr [bp - 6]
15A3  26 8A 45 04     mov al, byte ptr es:[di + 4]
15A7  30 E4           xor ah, ah
15A9  3B 46 FE        cmp ax, word ptr [bp - 2]
15AC  76 05           jbe 0x15b3
15AE  FF 46 FE        inc word ptr [bp - 2]
15B1  EB 11           jmp 0x15c4
loc_15B3:
15B3  C4 7E FA        les di, ptr [bp - 6]
15B6  26 8A 45 04     mov al, byte ptr es:[di + 4]
15BA  30 E4           xor ah, ah
15BC  3B 46 FE        cmp ax, word ptr [bp - 2]
15BF  73 03           jae 0x15c4
15C1  FF 4E FE        dec word ptr [bp - 2]
loc_15C4:
15C4  8A 46 FE        mov al, byte ptr [bp - 2]
15C7  C4 7E FA        les di, ptr [bp - 6]
15CA  26 88 45 04     mov byte ptr es:[di + 4], al
15CE  EB 26           jmp 0x15f6
loc_15D0:
15D0  C4 7E F6        les di, ptr [bp - 0xa]
15D3  26 80 7D 0C 00  cmp byte ptr es:[di + 0xc], 0
15D8  76 1C           jbe 0x15f6
15DA  C4 7E FA        les di, ptr [bp - 6]
15DD  26 80 7D 04 51  cmp byte ptr es:[di + 4], 0x51
15E2  76 12           jbe 0x15f6
15E4  6A 04           push 4
15E6  9A 1C 0D BC 24  call far 24BC:0D1C
15EB  08 C0           or al, al
15ED  74 07           je 0x15f6
15EF  C4 7E FA        les di, ptr [bp - 6]
15F2  26 FE 4D 04     dec byte ptr es:[di + 4]
loc_15F6:
15F6  C9              leave
15F7  C2 04 00        ret 4

; ---- routine 1998:15FA  (found by: far)
sub_15FA:
15FA  C8 0C 00 00     enter 0xc, 0
15FE  C7 46 FC 01 00  mov word ptr [bp - 4], 1
1603  EB 03           jmp 0x1608
loc_1605:
1605  FF 46 FC        inc word ptr [bp - 4]
loc_1608:
1608  C4 3E D2 D7     les di, ptr [0xd7d2]
160C  26 8A 05        mov al, byte ptr es:[di]
160F  30 E4           xor ah, ah
1611  8B F0           mov si, ax
1613  D1 E0           shl ax, 1
1615  01 F0           add ax, si
1617  8B D0           mov dx, ax
1619  69 46 FC AE 00  imul ax, word ptr [bp - 4], 0xae
161E  C4 3E CA D7     les di, ptr [0xd7ca]
1622  03 F8           add di, ax
1624  03 FA           add di, dx
1626  26 80 BD 50 FF 00 cmp byte ptr es:[di - 0xb0], 0
162C  75 77           jne 0x16a5
162E  6B 46 FC 3E     imul ax, word ptr [bp - 4], 0x3e
1632  C4 3E C2 D7     les di, ptr [0xd7c2]
1636  03 F8           add di, ax
1638  81 C7 C2 FF     add di, 0xffc2
163C  89 7E F8        mov word ptr [bp - 8], di
163F  8C 46 FA        mov word ptr [bp - 6], es
1642  C7 46 FE 01 00  mov word ptr [bp - 2], 1
1647  EB 03           jmp 0x164c
loc_1649:
1649  FF 46 FE        inc word ptr [bp - 2]
loc_164C:
164C  8B 46 FE        mov ax, word ptr [bp - 2]
164F  D1 E0           shl ax, 1
1651  C4 7E F8        les di, ptr [bp - 8]
1654  03 F8           add di, ax
1656  26 83 7D FE 00  cmp word ptr es:[di - 2], 0
165B  74 42           je 0x169f
165D  8B 46 FE        mov ax, word ptr [bp - 2]
1660  D1 E0           shl ax, 1
1662  C4 7E F8        les di, ptr [bp - 8]
1665  03 F8           add di, ax
1667  26 6B 45 FE 0F  imul ax, word ptr es:[di - 2], 0xf
166C  C4 3E BE D7     les di, ptr [0xd7be]
1670  03 F8           add di, ax
1672  89 7E F4        mov word ptr [bp - 0xc], di
1675  8C 46 F6        mov word ptr [bp - 0xa], es
1678  26 80 7D 08 00  cmp byte ptr es:[di + 8], 0
167D  75 20           jne 0x169f
167F  8B 46 FE        mov ax, word ptr [bp - 2]
1682  D1 E0           shl ax, 1
1684  C4 7E F8        les di, ptr [bp - 8]
1687  03 F8           add di, ax
1689  26 FF 75 FE     push word ptr es:[di - 2]
168D  E8 69 FD        call 0x13f9
1690  08 C0           or al, al
1692  74 0B           je 0x169f
1694  C4 7E F4        les di, ptr [bp - 0xc]
1697  26 8A 45 07     mov al, byte ptr es:[di + 7]
169B  26 88 45 08     mov byte ptr es:[di + 8], al
loc_169F:
169F  83 7E FE 14     cmp word ptr [bp - 2], 0x14
16A3  75 A4           jne 0x1649
loc_16A5:
16A5  81 7E FC B0 00  cmp word ptr [bp - 4], 0xb0
16AA  74 03           je 0x16af
16AC  E9 56 FF        jmp 0x1605
loc_16AF:
16AF  C9              leave
16B0  CB              retf

; ---- routine 1998:16B1  (found by: far)
sub_16B1:
16B1  C8 10 00 00     enter 0x10, 0
16B5  C4 3E D2 D7     les di, ptr [0xd7d2]
16B9  89 7E F8        mov word ptr [bp - 8], di
16BC  8C 46 FA        mov word ptr [bp - 6], es
16BF  8B 7E 06        mov di, word ptr [bp + 6]
16C2  80 BD B9 DC 00  cmp byte ptr [di - 0x2347], 0
16C7  75 03           jne 0x16cc
16C9  E9 9C 01        jmp 0x1868
loc_16CC:
16CC  C4 7E F8        les di, ptr [bp - 8]
16CF  26 8A 05        mov al, byte ptr es:[di]
16D2  30 E4           xor ah, ah
16D4  8B F0           mov si, ax
16D6  D1 E0           shl ax, 1
16D8  01 F0           add ax, si
16DA  8B D0           mov dx, ax
16DC  8B 7E 06        mov di, word ptr [bp + 6]
16DF  8A 85 B9 DC     mov al, byte ptr [di - 0x2347]
16E3  30 E4           xor ah, ah
16E5  69 C0 AE 00     imul ax, ax, 0xae
16E9  C4 3E CA D7     les di, ptr [0xd7ca]
16ED  03 F8           add di, ax
16EF  03 FA           add di, dx
16F1  26 80 BD 50 FF 00 cmp byte ptr es:[di - 0xb0], 0
16F7  B0 00           mov al, 0
16F9  74 01           je 0x16fc
16FB  40              inc ax
loc_16FC:
16FC  88 46 FD        mov byte ptr [bp - 3], al
16FF  C7 46 FE 01 00  mov word ptr [bp - 2], 1
1704  EB 03           jmp 0x1709
loc_1706:
1706  FF 46 FE        inc word ptr [bp - 2]
loc_1709:
1709  8B 46 FE        mov ax, word ptr [bp - 2]
170C  D1 E0           shl ax, 1
170E  8B D0           mov dx, ax
1710  6B 46 06 28     imul ax, word ptr [bp + 6], 0x28
1714  C4 7E F8        les di, ptr [bp - 8]
1717  03 F8           add di, ax
1719  03 FA           add di, dx
171B  26 83 7D 2E 00  cmp word ptr es:[di + 0x2e], 0
1720  75 03           jne 0x1725
1722  E9 3A 01        jmp 0x185f
loc_1725:
1725  8B 46 FE        mov ax, word ptr [bp - 2]
1728  D1 E0           shl ax, 1
172A  8B D0           mov dx, ax
172C  6B 46 06 28     imul ax, word ptr [bp + 6], 0x28
1730  C4 7E F8        les di, ptr [bp - 8]
1733  03 F8           add di, ax
1735  03 FA           add di, dx
1737  26 6B 45 2E 0F  imul ax, word ptr es:[di + 0x2e], 0xf
173C  C4 3E BE D7     les di, ptr [0xd7be]
1740  03 F8           add di, ax
1742  89 7E F4        mov word ptr [bp - 0xc], di
1745  8C 46 F6        mov word ptr [bp - 0xa], es
1748  8B 46 FE        mov ax, word ptr [bp - 2]
174B  D1 E0           shl ax, 1
174D  8B D0           mov dx, ax
174F  6B 46 06 28     imul ax, word ptr [bp + 6], 0x28
1753  C4 7E F8        les di, ptr [bp - 8]
1756  03 F8           add di, ax
1758  03 FA           add di, dx
175A  26 8B 45 2E     mov ax, word ptr es:[di + 0x2e]
175E  C1 E0 03        shl ax, 3
1761  C4 3E BA D7     les di, ptr [0xd7ba]
1765  03 F8           add di, ax
1767  89 7E F0        mov word ptr [bp - 0x10], di
176A  8C 46 F2        mov word ptr [bp - 0xe], es
176D  C4 7E F4        les di, ptr [bp - 0xc]
1770  26 80 7D 08 00  cmp byte ptr es:[di + 8], 0
1775  75 16           jne 0x178d
1777  26 8A 45 06     mov al, byte ptr es:[di + 6]
177B  98              cwde
177C  05 FF FF        add ax, 0xffff
177F  50              push ax
1780  0E              push cs
1781  E8 2A F6        call 0xdae
1784  C4 7E F4        les di, ptr [bp - 0xc]
1787  26 88 45 06     mov byte ptr es:[di + 6], al
178B  EB 3F           jmp 0x17cc
loc_178D:
178D  C4 7E F0        les di, ptr [bp - 0x10]
1790  26 80 7D 01 12  cmp byte ptr es:[di + 1], 0x12
1795  B0 00           mov al, 0
1797  73 01           jae 0x179a
1799  40              inc ax
loc_179A:
179A  98              cwde
179B  8B F8           mov di, ax
179D  8A 85 74 0D     mov al, byte ptr [di + 0xd74]
17A1  30 E4           xor ah, ah
17A3  50              push ax
17A4  9A 6D 07 2A 23  call far 232A:076D
17A9  50              push ax
17AA  6A 02           push 2
17AC  9A 6D 07 2A 23  call far 232A:076D
17B1  8B D0           mov dx, ax
17B3  C4 7E F4        les di, ptr [bp - 0xc]
17B6  26 8A 45 06     mov al, byte ptr es:[di + 6]
17BA  98              cwde
17BB  03 C2           add ax, dx
17BD  5A              pop dx
17BE  2B C2           sub ax, dx
17C0  50              push ax
17C1  0E              push cs
17C2  E8 E9 F5        call 0xdae
17C5  C4 7E F4        les di, ptr [bp - 0xc]
17C8  26 88 45 06     mov byte ptr es:[di + 6], al
loc_17CC:
17CC  C4 7E F0        les di, ptr [bp - 0x10]
17CF  26 80 7D 01 12  cmp byte ptr es:[di + 1], 0x12
17D4  73 1F           jae 0x17f5
17D6  8B 46 FE        mov ax, word ptr [bp - 2]
17D9  D1 E0           shl ax, 1
17DB  8B D0           mov dx, ax
17DD  6B 46 06 28     imul ax, word ptr [bp + 6], 0x28
17E1  C4 7E F8        les di, ptr [bp - 8]
17E4  03 F8           add di, ax
17E6  03 FA           add di, dx
17E8  26 FF 75 2E     push word ptr es:[di + 0x2e]
17EC  8A 46 FD        mov al, byte ptr [bp - 3]
17EF  50              push ax
17F0  E8 B2 FC        call 0x14a5
17F3  EB 23           jmp 0x1818
loc_17F5:
17F5  8B 46 FE        mov ax, word ptr [bp - 2]
17F8  D1 E0           shl ax, 1
17FA  8B D0           mov dx, ax
17FC  6B 46 06 28     imul ax, word ptr [bp + 6], 0x28
1800  C4 7E F8        les di, ptr [bp - 8]
1803  03 F8           add di, ax
1805  03 FA           add di, dx
1807  26 FF 75 2E     push word ptr es:[di + 0x2e]
180B  80 7E FD 00     cmp byte ptr [bp - 3], 0
180F  B0 00           mov al, 0
1811  75 01           jne 0x1814
1813  40              inc ax
loc_1814:
1814  50              push ax
1815  E8 8D FC        call 0x14a5
loc_1818:
1818  80 7E FD 00     cmp byte ptr [bp - 3], 0
181C  74 41           je 0x185f
181E  8B 46 FE        mov ax, word ptr [bp - 2]
1821  D1 E0           shl ax, 1
1823  8B D0           mov dx, ax
1825  6B 46 06 28     imul ax, word ptr [bp + 6], 0x28
1829  C4 7E F8        les di, ptr [bp - 8]
182C  03 F8           add di, ax
182E  03 FA           add di, dx
1830  26 FF 75 2E     push word ptr es:[di + 0x2e]
1834  C4 7E F0        les di, ptr [bp - 0x10]
1837  26 80 7D 01 12  cmp byte ptr es:[di + 1], 0x12
183C  B0 00           mov al, 0
183E  73 01           jae 0x1841
1840  40              inc ax
loc_1841:
1841  50              push ax
1842  E8 09 FD        call 0x154e
1845  8B 46 FE        mov ax, word ptr [bp - 2]
1848  D1 E0           shl ax, 1
184A  8B D0           mov dx, ax
184C  6B 46 06 28     imul ax, word ptr [bp + 6], 0x28
1850  C4 7E F8        les di, ptr [bp - 8]
1853  03 F8           add di, ax
1855  03 FA           add di, dx
1857  26 FF 75 2E     push word ptr es:[di + 0x2e]
185B  0E              push cs
185C  E8 5F FA        call 0x12be
loc_185F:
185F  83 7E FE 14     cmp word ptr [bp - 2], 0x14
1863  74 03           je 0x1868
1865  E9 9E FE        jmp 0x1706
loc_1868:
1868  C9              leave
1869  CA 02 00        retf 2

; ---- routine 1998:186C  (found by: call, far)
sub_186C:
186C  C8 04 00 00     enter 4, 0
1870  6B 46 06 0F     imul ax, word ptr [bp + 6], 0xf
1874  C4 3E BE D7     les di, ptr [0xd7be]
1878  03 F8           add di, ax
187A  89 7E FC        mov word ptr [bp - 4], di
187D  8C 46 FE        mov word ptr [bp - 2], es
1880  80 3E DD D6 00  cmp byte ptr [0xd6dd], 0
1885  75 02           jne 0x1889
1887  EB 0A           jmp 0x1893
loc_1889:
1889  C4 7E FC        les di, ptr [bp - 4]
188C  26 FE 45 04     inc byte ptr es:[di + 4]
1890  26 FF 05        inc word ptr es:[di]
loc_1893:
1893  C9              leave
1894  CA 02 00        retf 2

; ---- routine 1998:1897  (found by: far)
sub_1897:
1897  C8 12 00 00     enter 0x12, 0
189B  6B 46 0A 3E     imul ax, word ptr [bp + 0xa], 0x3e
189F  C4 3E C2 D7     les di, ptr [0xd7c2]
18A3  03 F8           add di, ax
18A5  81 C7 C2 FF     add di, 0xffc2
18A9  89 7E F6        mov word ptr [bp - 0xa], di
18AC  8C 46 F8        mov word ptr [bp - 8], es
18AF  FF 76 0A        push word ptr [bp + 0xa]
18B2  9A 7A 0E 55 1B  call far 1B55:0E7A
18B7  88 46 FB        mov byte ptr [bp - 5], al
18BA  C7 46 FE 01 00  mov word ptr [bp - 2], 1
18BF  EB 03           jmp 0x18c4
loc_18C1:
18C1  FF 46 FE        inc word ptr [bp - 2]
loc_18C4:
18C4  8B 46 FE        mov ax, word ptr [bp - 2]
18C7  D1 E0           shl ax, 1
18C9  C4 7E F6        les di, ptr [bp - 0xa]
18CC  03 F8           add di, ax
18CE  26 83 7D FE 00  cmp word ptr es:[di - 2], 0
18D3  75 03           jne 0x18d8
18D5  E9 97 01        jmp 0x1a6f
loc_18D8:
18D8  8B 46 FE        mov ax, word ptr [bp - 2]
18DB  D1 E0           shl ax, 1
18DD  C4 7E F6        les di, ptr [bp - 0xa]
18E0  03 F8           add di, ax
18E2  26 6B 45 FE 0F  imul ax, word ptr es:[di - 2], 0xf
18E7  C4 3E BE D7     les di, ptr [0xd7be]
18EB  03 F8           add di, ax
18ED  89 7E F2        mov word ptr [bp - 0xe], di
18F0  8C 46 F4        mov word ptr [bp - 0xc], es
18F3  83 7E FE 0C     cmp word ptr [bp - 2], 0xc
18F7  72 15           jb 0x190e
18F9  6A 03           push 3
18FB  26 8A 45 0B     mov al, byte ptr es:[di + 0xb]
18FF  30 E4           xor ah, ah
1901  50              push ax
1902  9A 59 02 BC 24  call far 24BC:0259
1907  08 C0           or al, al
1909  75 03           jne 0x190e
190B  E9 B0 00        jmp 0x19be
loc_190E:
190E  81 7E 08 FF 00  cmp word ptr [bp + 8], 0xff
1913  74 12           je 0x1927
1915  8B 46 FE        mov ax, word ptr [bp - 2]
1918  D1 E0           shl ax, 1
191A  C4 7E F6        les di, ptr [bp - 0xa]
191D  03 F8           add di, ax
191F  26 FF 75 FE     push word ptr es:[di - 2]
1923  0E              push cs
1924  E8 45 FF        call 0x186c
loc_1927:
1927  8B 46 FE        mov ax, word ptr [bp - 2]
192A  D1 E0           shl ax, 1
192C  C4 7E F6        les di, ptr [bp - 0xa]
192F  03 F8           add di, ax
1931  26 FF 75 FE     push word ptr es:[di - 2]
1935  6A 01           push 1
1937  E8 6B FB        call 0x14a5
193A  80 7E FB 00     cmp byte ptr [bp - 5], 0
193E  74 3C           je 0x197c
1940  8B 46 FE        mov ax, word ptr [bp - 2]
1943  D1 E0           shl ax, 1
1945  C4 7E F6        les di, ptr [bp - 0xa]
1948  03 F8           add di, ax
194A  26 8B 45 FE     mov ax, word ptr es:[di - 2]
194E  C1 E0 03        shl ax, 3
1951  C4 3E BA D7     les di, ptr [0xd7ba]
1955  03 F8           add di, ax
1957  26 80 7D 01 12  cmp byte ptr es:[di + 1], 0x12
195C  73 0B           jae 0x1969
195E  26 80 7D 03 FF  cmp byte ptr es:[di + 3], 0xff
1963  73 04           jae 0x1969
1965  26 FE 45 03     inc byte ptr es:[di + 3]
loc_1969:
1969  8B 46 FE        mov ax, word ptr [bp - 2]
196C  D1 E0           shl ax, 1
196E  C4 7E F6        les di, ptr [bp - 0xa]
1971  03 F8           add di, ax
1973  26 FF 75 FE     push word ptr es:[di - 2]
1977  6A 01           push 1
1979  E8 D2 FB        call 0x154e
loc_197C:
197C  83 7E FE 0B     cmp word ptr [bp - 2], 0xb
1980  76 3A           jbe 0x19bc
1982  6A 03           push 3
1984  C4 7E F2        les di, ptr [bp - 0xe]
1987  81 C7 0B 00     add di, 0xb
198B  06              push es
198C  57              push di
198D  9A F8 00 2A 23  call far 232A:00F8
1992  6A 02           push 2
1994  9A 6D 07 2A 23  call far 232A:076D
1999  50              push ax
199A  6A 02           push 2
199C  9A 6D 07 2A 23  call far 232A:076D
19A1  8B D0           mov dx, ax
19A3  C4 7E F2        les di, ptr [bp - 0xe]
19A6  26 8A 45 06     mov al, byte ptr es:[di + 6]
19AA  98              cwde
19AB  03 C2           add ax, dx
19AD  5A              pop dx
19AE  2B C2           sub ax, dx
19B0  50              push ax
19B1  0E              push cs
19B2  E8 F9 F3        call 0xdae
19B5  C4 7E F2        les di, ptr [bp - 0xe]
19B8  26 88 45 06     mov byte ptr es:[di + 6], al
loc_19BC:
19BC  EB 74           jmp 0x1a32
loc_19BE:
19BE  6A 04           push 4
19C0  9A 6D 07 2A 23  call far 232A:076D
19C5  50              push ax
19C6  6A 02           push 2
19C8  9A 6D 07 2A 23  call far 232A:076D
19CD  8B D0           mov dx, ax
19CF  C4 7E F2        les di, ptr [bp - 0xe]
19D2  26 8A 45 06     mov al, byte ptr es:[di + 6]
19D6  98              cwde
19D7  03 C2           add ax, dx
19D9  5A              pop dx
19DA  2B C2           sub ax, dx
19DC  50              push ax
19DD  0E              push cs
19DE  E8 CD F3        call 0xdae
19E1  C4 7E F2        les di, ptr [bp - 0xe]
19E4  26 88 45 06     mov byte ptr es:[di + 6], al
19E8  8B 46 FE        mov ax, word ptr [bp - 2]
19EB  D1 E0           shl ax, 1
19ED  C4 7E F6        les di, ptr [bp - 0xa]
19F0  03 F8           add di, ax
19F2  26 FF 75 FE     push word ptr es:[di - 2]
19F6  6A 00           push 0
19F8  E8 AA FA        call 0x14a5
19FB  80 7E FB 00     cmp byte ptr [bp - 5], 0
19FF  74 31           je 0x1a32
1A01  8B 46 FE        mov ax, word ptr [bp - 2]
1A04  D1 E0           shl ax, 1
1A06  C4 7E F6        les di, ptr [bp - 0xa]
1A09  03 F8           add di, ax
1A0B  26 8B 45 FE     mov ax, word ptr es:[di - 2]
1A0F  C1 E0 03        shl ax, 3
1A12  C4 3E BA D7     les di, ptr [0xd7ba]
1A16  03 F8           add di, ax
1A18  26 80 7D 01 13  cmp byte ptr es:[di + 1], 0x13
1A1D  76 13           jbe 0x1a32
1A1F  8B 46 FE        mov ax, word ptr [bp - 2]
1A22  D1 E0           shl ax, 1
1A24  C4 7E F6        les di, ptr [bp - 0xa]
1A27  03 F8           add di, ax
1A29  26 FF 75 FE     push word ptr es:[di - 2]
1A2D  6A 00           push 0
1A2F  E8 1C FB        call 0x154e
loc_1A32:
1A32  8B 46 FE        mov ax, word ptr [bp - 2]
1A35  D1 E0           shl ax, 1
1A37  C4 7E F6        les di, ptr [bp - 0xa]
1A3A  03 F8           add di, ax
1A3C  26 FF 75 FE     push word ptr es:[di - 2]
1A40  0E              push cs
1A41  E8 7A F8        call 0x12be
1A44  83 7E FE 0B     cmp word ptr [bp - 2], 0xb
1A48  76 25           jbe 0x1a6f
1A4A  80 7E FB 00     cmp byte ptr [bp - 5], 0
1A4E  75 1F           jne 0x1a6f
1A50  8B 46 FE        mov ax, word ptr [bp - 2]
1A53  D1 E0           shl ax, 1
1A55  C4 7E F6        les di, ptr [bp - 0xa]
1A58  03 F8           add di, ax
1A5A  26 8B 45 FE     mov ax, word ptr es:[di - 2]
1A5E  C1 E0 03        shl ax, 3
1A61  C4 3E BA D7     les di, ptr [0xd7ba]
1A65  03 F8           add di, ax
1A67  26 8A 45 07     mov al, byte ptr es:[di + 7]
1A6B  26 88 45 06     mov byte ptr es:[di + 6], al
loc_1A6F:
1A6F  83 7E FE 14     cmp word ptr [bp - 2], 0x14
1A73  74 03           je 0x1a78
1A75  E9 49 FE        jmp 0x18c1
loc_1A78:
1A78  80 3E DD D6 00  cmp byte ptr [0xd6dd], 0
1A7D  75 03           jne 0x1a82
1A7F  E9 13 01        jmp 0x1b95
loc_1A82:
1A82  81 7E 08 FF 00  cmp word ptr [bp + 8], 0xff
1A87  75 03           jne 0x1a8c
1A89  E9 09 01        jmp 0x1b95
loc_1A8C:
1A8C  C4 7E F6        les di, ptr [bp - 0xa]
1A8F  26 8B 05        mov ax, word ptr es:[di]
1A92  C1 E0 03        shl ax, 3
1A95  C4 3E BA D7     les di, ptr [0xd7ba]
1A99  03 F8           add di, ax
1A9B  89 7E F2        mov word ptr [bp - 0xe], di
1A9E  8C 46 F4        mov word ptr [bp - 0xc], es
1AA1  C4 7E F6        les di, ptr [bp - 0xa]
1AA4  26 6B 05 0F     imul ax, word ptr es:[di], 0xf
1AA8  C4 3E BE D7     les di, ptr [0xd7be]
1AAC  03 F8           add di, ax
1AAE  89 7E EE        mov word ptr [bp - 0x12], di
1AB1  8C 46 F0        mov word ptr [bp - 0x10], es
1AB4  C4 7E F2        les di, ptr [bp - 0xe]
1AB7  26 80 7D 07 00  cmp byte ptr es:[di + 7], 0
1ABC  75 31           jne 0x1aef
1ABE  8B 46 06        mov ax, word ptr [bp + 6]
1AC1  C4 7E EE        les di, ptr [bp - 0x12]
1AC4  26 01 45 02     add word ptr es:[di + 2], ax
1AC8  8A 46 06        mov al, byte ptr [bp + 6]
1ACB  26 00 45 05     add byte ptr es:[di + 5], al
1ACF  FF 76 06        push word ptr [bp + 6]
1AD2  9A 6D 07 2A 23  call far 232A:076D
1AD7  8B D0           mov dx, ax
1AD9  C4 7E EE        les di, ptr [bp - 0x12]
1ADC  26 8A 45 06     mov al, byte ptr es:[di + 6]
1AE0  98              cwde
1AE1  03 C2           add ax, dx
1AE3  50              push ax
1AE4  0E              push cs
1AE5  E8 C6 F2        call 0xdae
1AE8  C4 7E EE        les di, ptr [bp - 0x12]
1AEB  26 88 45 06     mov byte ptr es:[di + 6], al
loc_1AEF:
1AEF  83 7E 08 00     cmp word ptr [bp + 8], 0
1AF3  7F 03           jg 0x1af8
1AF5  E9 9D 00        jmp 0x1b95
loc_1AF8:
1AF8  6A 0A           push 0xa
1AFA  9A 6D 07 2A 23  call far 232A:076D
1AFF  40              inc ax
1B00  D1 E0           shl ax, 1
1B02  C4 7E F6        les di, ptr [bp - 0xa]
1B05  03 F8           add di, ax
1B07  26 8B 45 FE     mov ax, word ptr es:[di - 2]
1B0B  89 46 FC        mov word ptr [bp - 4], ax
1B0E  8B 46 FC        mov ax, word ptr [bp - 4]
1B11  C1 E0 03        shl ax, 3
1B14  C4 3E BA D7     les di, ptr [0xd7ba]
1B18  03 F8           add di, ax
1B1A  89 7E F2        mov word ptr [bp - 0xe], di
1B1D  8C 46 F4        mov word ptr [bp - 0xc], es
1B20  26 80 7D 07 00  cmp byte ptr es:[di + 7], 0
1B25  74 6B           je 0x1b92
1B27  26 8A 45 06     mov al, byte ptr es:[di + 6]
1B2B  30 E4           xor ah, ah
1B2D  8B F8           mov di, ax
1B2F  D1 E7           shl di, 1
1B31  FF B5 74 0D     push word ptr [di + 0xd74]
1B35  9A 6D 07 2A 23  call far 232A:076D
1B3A  50              push ax
1B3B  C4 7E F2        les di, ptr [bp - 0xe]
1B3E  26 8A 45 04     mov al, byte ptr es:[di + 4]
1B42  30 E4           xor ah, ah
1B44  50              push ax
1B45  9A 6D 07 2A 23  call far 232A:076D
1B4A  5A              pop dx
1B4B  3B C2           cmp ax, dx
1B4D  7E 43           jle 0x1b92
1B4F  6B 46 FC 0F     imul ax, word ptr [bp - 4], 0xf
1B53  C4 3E BE D7     les di, ptr [0xd7be]
1B57  03 F8           add di, ax
1B59  89 7E EE        mov word ptr [bp - 0x12], di
1B5C  8C 46 F0        mov word ptr [bp - 0x10], es
1B5F  26 FE 45 05     inc byte ptr es:[di + 5]
1B63  26 FF 45 02     inc word ptr es:[di + 2]
1B67  C4 7E F2        les di, ptr [bp - 0xe]
1B6A  26 8A 45 06     mov al, byte ptr es:[di + 6]
1B6E  30 E4           xor ah, ah
1B70  8B F8           mov di, ax
1B72  8A 85 1A 0D     mov al, byte ptr [di + 0xd1a]
1B76  98              cwde
1B77  8B D0           mov dx, ax
1B79  C4 7E EE        les di, ptr [bp - 0x12]
1B7C  26 8A 45 06     mov al, byte ptr es:[di + 6]
1B80  98              cwde
1B81  03 C2           add ax, dx
1B83  50              push ax
1B84  0E              push cs
1B85  E8 26 F2        call 0xdae
1B88  C4 7E EE        les di, ptr [bp - 0x12]
1B8B  26 88 45 06     mov byte ptr es:[di + 6], al
1B8F  FF 4E 08        dec word ptr [bp + 8]
loc_1B92:
1B92  E9 5A FF        jmp 0x1aef
loc_1B95:
1B95  C9              leave
1B96  CA 06 00        retf 6

; ---- routine 1998:1B99  (found by: call, far)
sub_1B99:
1B99  C8 02 00 00     enter 2, 0
1B9D  6B 46 08 3E     imul ax, word ptr [bp + 8], 0x3e
1BA1  C4 3E C2 D7     les di, ptr [0xd7c2]
1BA5  03 F8           add di, ax
1BA7  26 80 7D FC 00  cmp byte ptr es:[di - 4], 0
1BAC  75 15           jne 0x1bc3
1BAE  6B 46 06 3E     imul ax, word ptr [bp + 6], 0x3e
1BB2  C4 3E C2 D7     les di, ptr [0xd7c2]
1BB6  03 F8           add di, ax
1BB8  26 80 7D FC 00  cmp byte ptr es:[di - 4], 0
1BBD  75 04           jne 0x1bc3
1BBF  B0 00           mov al, 0
1BC1  EB 02           jmp 0x1bc5
loc_1BC3:
1BC3  B0 01           mov al, 1
loc_1BC5:
1BC5  88 46 FF        mov byte ptr [bp - 1], al
1BC8  8A 46 FF        mov al, byte ptr [bp - 1]
1BCB  C9              leave
1BCC  CA 04 00        retf 4
; data (not reached as code), 1 bytes
1BCF                  db 00   ; .
