; 1-0.EXE (One-Nil 96), code segment 24BC (image offsets 24BC0..26B7F), part 3 of 4
; packed 1-0.EXE sha256 89ff9c5f238f24e81a0c2440a46cdd8997280a65fc3cc3d97cb974f55280a80a (LZEXE 0.91)
; unpacked (tools/static/unlzexe.py) sha256 887ed2a92767950e5309b2052409f875668605939b69e00737aa3047022b9f51
; tool: capstone 5.0.9 (pip package; core library 5.0.1280) (CS_ARCH_X86, CS_MODE_16), recursive descent from the entry point, far calls and near calls/jumps, then routine prologues (55 89 E5 / 55 8B EC / C8 iw 00) in what remains; tools/static/listing.py
; addresses are SEGMENT:OFFSET with SEGMENT the image paragraph before relocation; image offset = SEGMENT*16+OFFSET
; ---- routine 24BC:12CD  (found by: call)
sub_12CD:
12CD  C8 52 00 00     enter 0x52, 0
12D1  8C D3           mov bx, ss
12D3  8E C3           mov es, bx
12D5  8C DB           mov bx, ds
12D7  FC              cld
12D8  8D 7E AE        lea di, [bp - 0x52]
12DB  C5 76 06        lds si, ptr [bp + 6]
12DE  AC              lodsb al, byte ptr [si]
12DF  3C 50           cmp al, 0x50
12E1  72 02           jb 0x12e5
12E3  B0 50           mov al, 0x50
loc_12E5:
12E5  AA              stosb byte ptr es:[di], al
12E6  91              xchg cx, ax
12E7  30 ED           xor ch, ch
12E9  F3 A4           rep movsb byte ptr es:[di], byte ptr [si]
12EB  8E DB           mov ds, bx
loc_12ED:
12ED  8D 7E AE        lea di, [bp - 0x52]
12F0  16              push ss
12F1  57              push di
12F2  68 00 3C        push 0x3c00
12F5  E8 AC FD        call 0x10a4
12F8  81 3E 02 DF 98 00 cmp word ptr [0xdf02], 0x98
12FE  74 ED           je 0x12ed
1300  C9              leave
1301  CA 04 00        retf 4

; ---- routine 24BC:1304  (found by: far)
sub_1304:
1304  C8 52 00 00     enter 0x52, 0
1308  8C D3           mov bx, ss
130A  8E C3           mov es, bx
130C  8C DB           mov bx, ds
130E  FC              cld
130F  8D 7E AE        lea di, [bp - 0x52]
1312  C5 76 06        lds si, ptr [bp + 6]
1315  AC              lodsb al, byte ptr [si]
1316  3C 50           cmp al, 0x50
1318  72 02           jb 0x131c
131A  B0 50           mov al, 0x50
loc_131C:
131C  AA              stosb byte ptr es:[di], al
131D  91              xchg cx, ax
131E  30 ED           xor ch, ch
1320  F3 A4           rep movsb byte ptr es:[di], byte ptr [si]
1322  8E DB           mov ds, bx
1324  8D 7E AE        lea di, [bp - 0x52]
1327  16              push ss
1328  57              push di
1329  0E              push cs
132A  E8 A0 FF        call 0x12cd
132D  83 3E 02 DF 00  cmp word ptr [0xdf02], 0
1332  B0 00           mov al, 0
1334  75 01           jne 0x1337
1336  40              inc ax
loc_1337:
1337  88 46 FF        mov byte ptr [bp - 1], al
133A  8A 46 FF        mov al, byte ptr [bp - 1]
133D  C9              leave
133E  CA 04 00        retf 4

; ---- routine 24BC:1341  (found by: call, far)
sub_1341:
1341  C8 52 00 00     enter 0x52, 0
1345  8C D3           mov bx, ss
1347  8E C3           mov es, bx
1349  8C DB           mov bx, ds
134B  FC              cld
134C  8D 7E AE        lea di, [bp - 0x52]
134F  C5 76 06        lds si, ptr [bp + 6]
1352  AC              lodsb al, byte ptr [si]
1353  3C 50           cmp al, 0x50
1355  72 02           jb 0x1359
1357  B0 50           mov al, 0x50
loc_1359:
1359  AA              stosb byte ptr es:[di], al
135A  91              xchg cx, ax
135B  30 ED           xor ch, ch
135D  F3 A4           rep movsb byte ptr es:[di], byte ptr [si]
135F  8E DB           mov ds, bx
1361  8D 7E AE        lea di, [bp - 0x52]
1364  16              push ss
1365  57              push di
1366  68 02 3D        push 0x3d02
1369  E8 38 FD        call 0x10a4
136C  83 3E 02 DF 00  cmp word ptr [0xdf02], 0
1371  B0 00           mov al, 0
1373  75 01           jne 0x1376
1375  40              inc ax
loc_1376:
1376  88 46 FF        mov byte ptr [bp - 1], al
1379  8A 46 FF        mov al, byte ptr [bp - 1]
137C  C9              leave
137D  CA 04 00        retf 4
; data (not reached as code), 9 bytes
1380                  pstr 'loading '

; ---- routine 24BC:1389  (found by: far)
sub_1389:
1389  C8 52 01 00     enter 0x152, 0
138D  8C D3           mov bx, ss
138F  8E C3           mov es, bx
1391  8C DB           mov bx, ds
1393  FC              cld
1394  8D 7E AE        lea di, [bp - 0x52]
1397  C5 76 0C        lds si, ptr [bp + 0xc]
139A  AC              lodsb al, byte ptr [si]
139B  3C 50           cmp al, 0x50
139D  72 02           jb 0x13a1
139F  B0 50           mov al, 0x50
loc_13A1:
13A1  AA              stosb byte ptr es:[di], al
13A2  91              xchg cx, ax
13A3  30 ED           xor ch, ch
13A5  F3 A4           rep movsb byte ptr es:[di], byte ptr [si]
13A7  8E DB           mov ds, bx
13A9  C6 46 FF 00     mov byte ptr [bp - 1], 0
13AD  8D 7E AE        lea di, [bp - 0x52]
13B0  16              push ss
13B1  57              push di
13B2  0E              push cs
13B3  E8 8B FF        call 0x1341
13B6  08 C0           or al, al
13B8  74 39           je 0x13f3
13BA  80 3E F1 A3 00  cmp byte ptr [0xa3f1], 0
13BF  74 1E           je 0x13df
13C1  8D BE AE FE     lea di, [bp - 0x152]
13C5  16              push ss
13C6  57              push di
13C7  BF 80 13        mov di, 0x1380
13CA  0E              push cs
13CB  57              push di
13CC  9A 53 0B C9 26  call far 26C9:0B53
13D1  8D 7E AE        lea di, [bp - 0x52]
13D4  16              push ss
13D5  57              push di
13D6  9A D2 0B C9 26  call far 26C9:0BD2
13DB  0E              push cs
13DC  E8 58 F2        call 0x637
loc_13DF:
13DF  C4 7E 08        les di, ptr [bp + 8]
13E2  06              push es
13E3  57              push di
13E4  FF 76 06        push word ptr [bp + 6]
13E7  0E              push cs
13E8  E8 F6 FD        call 0x11e1
13EB  C6 46 FF 01     mov byte ptr [bp - 1], 1
13EF  0E              push cs
13F0  E8 61 FC        call 0x1054
loc_13F3:
13F3  8A 46 FF        mov al, byte ptr [bp - 1]
13F6  C9              leave
13F7  CA 0A 00        retf 0xa

; ---- routine 24BC:13FA  (found by: far)
sub_13FA:
13FA  C8 16 00 00     enter 0x16, 0
13FE  C6 46 EB 19     mov byte ptr [bp - 0x15], 0x19
1402  8D 7E EA        lea di, [bp - 0x16]
1405  16              push ss
1406  57              push di
1407  9A A7 00 B8 26  call far 26B8:00A7
140C  80 7E EA 02     cmp byte ptr [bp - 0x16], 2
1410  B0 00           mov al, 0
1412  73 01           jae 0x1415
1414  40              inc ax
loc_1415:
1415  88 46 FF        mov byte ptr [bp - 1], al
1418  8A 46 FF        mov al, byte ptr [bp - 1]
141B  C9              leave
141C  CB              retf
; data (not reached as code), 2 bytes
141D                  db 01 5C   ; .\

; ---- routine 24BC:141F  (found by: call)
sub_141F:
141F  C8 46 01 00     enter 0x146, 0
1423  6A 00           push 0
1425  8D 7E BA        lea di, [bp - 0x46]
1428  16              push ss
1429  57              push di
142A  6A 44           push 0x44
142C  9A 2C 09 C9 26  call far 26C9:092C
1431  8A 46 BA        mov al, byte ptr [bp - 0x46]
1434  30 E4           xor ah, ah
1436  8B F8           mov di, ax
1438  80 7B BA 5C     cmp byte ptr [bp + di - 0x46], 0x5c
143C  74 26           je 0x1464
143E  8D BE BA FE     lea di, [bp - 0x146]
1442  16              push ss
1443  57              push di
1444  8D 7E BA        lea di, [bp - 0x46]
1447  16              push ss
1448  57              push di
1449  9A 53 0B C9 26  call far 26C9:0B53
144E  BF 1D 14        mov di, 0x141d
1451  0E              push cs
1452  57              push di
1453  9A D2 0B C9 26  call far 26C9:0BD2
1458  8D 7E BA        lea di, [bp - 0x46]
145B  16              push ss
145C  57              push di
145D  6A 44           push 0x44
145F  9A 6D 0B C9 26  call far 26C9:0B6D
loc_1464:
1464  8D 7E BA        lea di, [bp - 0x46]
1467  16              push ss
1468  57              push di
1469  C4 7E 06        les di, ptr [bp + 6]
146C  06              push es
146D  57              push di
146E  6A 44           push 0x44
1470  9A 6D 0B C9 26  call far 26C9:0B6D
1475  C9              leave
1476  CB              retf
; data (not reached as code), 14 bytes
1477                  pstr 'Out of memory'

; ---- routine 24BC:1485  (found by: call, far)
sub_1485:
1485  55              push bp
1486  89 E5           mov bp, sp
1488  9A 03 03 C9 26  call far 26C9:0303
148D  8B C8           mov cx, ax
148F  8B DA           mov bx, dx
1491  8B 46 06        mov ax, word ptr [bp + 6]
1494  31 D2           xor dx, dx
1496  3B D3           cmp dx, bx
1498  7F 0A           jg 0x14a4
149A  7C 04           jl 0x14a0
149C  3B C1           cmp ax, cx
149E  77 04           ja 0x14a4
loc_14A0:
14A0  B0 00           mov al, 0
14A2  EB 02           jmp 0x14a6
loc_14A4:
14A4  B0 01           mov al, 1
loc_14A6:
14A6  50              push ax
14A7  BF 77 14        mov di, 0x1477
14AA  0E              push cs
14AB  57              push di
14AC  0E              push cs
14AD  E8 ED EE        call 0x39d
14B0  08 C0           or al, al
14B2  74 07           je 0x14bb
14B4  31 C0           xor ax, ax
14B6  9A 16 01 C9 26  call far 26C9:0116
loc_14BB:
14BB  FF 76 06        push word ptr [bp + 6]
14BE  9A 8A 02 C9 26  call far 26C9:028A
14C3  C4 7E 08        les di, ptr [bp + 8]
14C6  26 89 05        mov word ptr es:[di], ax
14C9  26 89 55 02     mov word ptr es:[di + 2], dx
14CD  26 C4 3D        les di, ptr es:[di]
14D0  06              push es
14D1  57              push di
14D2  FF 76 06        push word ptr [bp + 6]
14D5  6A 00           push 0
14D7  0E              push cs
14D8  E8 47 ED        call 0x222
14DB  C9              leave
14DC  CA 06 00        retf 6
; data (not reached as code), 15 bytes
14DF                  db 01 2A 01 3A 01 5C 02 5C 5C 01 2E   ; .*.:.\.\\..
14EA                  pstr '*.*'

; ---- routine 24BC:14EE  (found by: far)
sub_14EE:
14EE  C8 A6 02 00     enter 0x2a6, 0
14F2  8C D3           mov bx, ss
14F4  8E C3           mov es, bx
14F6  8C DB           mov bx, ds
14F8  FC              cld
14F9  8D 7E AE        lea di, [bp - 0x52]
14FC  C5 76 0A        lds si, ptr [bp + 0xa]
14FF  AC              lodsb al, byte ptr [si]
1500  3C 50           cmp al, 0x50
1502  72 02           jb 0x1506
1504  B0 50           mov al, 0x50
loc_1506:
1506  AA              stosb byte ptr es:[di], al
1507  91              xchg cx, ax
1508  30 ED           xor ch, ch
150A  F3 A4           rep movsb byte ptr es:[di], byte ptr [si]
150C  8E DB           mov ds, bx
150E  80 7E AE 00     cmp byte ptr [bp - 0x52], 0
1512  75 11           jne 0x1525
1514  BF DF 14        mov di, 0x14df
1517  0E              push cs
1518  57              push di
1519  8D 7E AE        lea di, [bp - 0x52]
151C  16              push ss
151D  57              push di
151E  6A 50           push 0x50
1520  9A 6D 0B C9 26  call far 26C9:0B6D
loc_1525:
1525  8D BE 5A FE     lea di, [bp - 0x1a6]
1529  16              push ss
152A  57              push di
152B  8D 7E AE        lea di, [bp - 0x52]
152E  16              push ss
152F  57              push di
1530  0E              push cs
1531  E8 26 EB        call 0x5a
1534  8D 7E AE        lea di, [bp - 0x52]
1537  16              push ss
1538  57              push di
1539  6A 50           push 0x50
153B  9A 6D 0B C9 26  call far 26C9:0B6D
1540  8A 46 AE        mov al, byte ptr [bp - 0x52]
1543  88 86 59 FF     mov byte ptr [bp - 0xa7], al
1547  B0 01           mov al, 1
1549  3A 86 59 FF     cmp al, byte ptr [bp - 0xa7]
154D  77 38           ja 0x1587
154F  88 46 AD        mov byte ptr [bp - 0x53], al
1552  EB 03           jmp 0x1557
loc_1554:
1554  FE 46 AD        inc byte ptr [bp - 0x53]
loc_1557:
1557  8A 46 AD        mov al, byte ptr [bp - 0x53]
155A  30 E4           xor ah, ah
155C  8B F8           mov di, ax
155E  8A 43 AE        mov al, byte ptr [bp + di - 0x52]
1561  B4 01           mov ah, 1
1563  BA 20 00        mov dx, 0x20
1566  9A 1F 0E C9 26  call far 26C9:0E1F
156B  8B FA           mov di, dx
156D  84 85 AC A4     test byte ptr [di - 0x5b54], al
1571  75 0B           jne 0x157e
1573  8A 46 AD        mov al, byte ptr [bp - 0x53]
1576  30 E4           xor ah, ah
1578  8B F8           mov di, ax
157A  C6 43 AE 20     mov byte ptr [bp + di - 0x52], 0x20
loc_157E:
157E  8A 46 AD        mov al, byte ptr [bp - 0x53]
1581  3A 86 59 FF     cmp al, byte ptr [bp - 0xa7]
1585  75 CD           jne 0x1554
loc_1587:
1587  6A 20           push 0x20
1589  8D 7E AE        lea di, [bp - 0x52]
158C  16              push ss
158D  57              push di
158E  0E              push cs
158F  E8 EC F2        call 0x87e
1592  6A 5C           push 0x5c
1594  8D 7E AE        lea di, [bp - 0x52]
1597  16              push ss
1598  57              push di
1599  0E              push cs
159A  E8 92 F2        call 0x82f
159D  88 46 AD        mov byte ptr [bp - 0x53], al
15A0  80 7E AD 00     cmp byte ptr [bp - 0x53], 0
15A4  75 12           jne 0x15b8
15A6  BF E1 14        mov di, 0x14e1
15A9  0E              push cs
15AA  57              push di
15AB  8D 7E AE        lea di, [bp - 0x52]
15AE  16              push ss
15AF  57              push di
15B0  9A FE 0B C9 26  call far 26C9:0BFE
15B5  88 46 AD        mov byte ptr [bp - 0x53], al
loc_15B8:
15B8  80 7E AD 00     cmp byte ptr [bp - 0x53], 0
15BC  77 03           ja 0x15c1
15BE  E9 95 01        jmp 0x1756
loc_15C1:
15C1  8D BE 5A FE     lea di, [bp - 0x1a6]
15C5  16              push ss
15C6  57              push di
15C7  8D 7E AE        lea di, [bp - 0x52]
15CA  16              push ss
15CB  57              push di
15CC  6A 01           push 1
15CE  8A 46 AD        mov al, byte ptr [bp - 0x53]
15D1  30 E4           xor ah, ah
15D3  50              push ax
15D4  9A 91 0B C9 26  call far 26C9:0B91
15D9  8D BE 5A FF     lea di, [bp - 0xa6]
15DD  16              push ss
15DE  57              push di
15DF  6A 50           push 0x50
15E1  9A 6D 0B C9 26  call far 26C9:0B6D
15E6  8D 7E AE        lea di, [bp - 0x52]
15E9  16              push ss
15EA  57              push di
15EB  6A 01           push 1
15ED  8A 46 AD        mov al, byte ptr [bp - 0x53]
15F0  30 E4           xor ah, ah
15F2  50              push ax
15F3  9A FB 0C C9 26  call far 26C9:0CFB
15F8  80 BE 5C FF 3A  cmp byte ptr [bp - 0xa4], 0x3a
15FD  74 2C           je 0x162b
15FF  8D BE 5A FE     lea di, [bp - 0x1a6]
1603  16              push ss
1604  57              push di
1605  BF 80 E0        mov di, 0xe080
1608  1E              push ds
1609  57              push di
160A  6A 01           push 1
160C  6A 02           push 2
160E  9A 91 0B C9 26  call far 26C9:0B91
1613  8D BE 5A FF     lea di, [bp - 0xa6]
1617  16              push ss
1618  57              push di
1619  9A D2 0B C9 26  call far 26C9:0BD2
161E  8D BE 5A FF     lea di, [bp - 0xa6]
1622  16              push ss
1623  57              push di
1624  6A 50           push 0x50
1626  9A 6D 0B C9 26  call far 26C9:0B6D
loc_162B:
162B  80 BE 5D FF 5C  cmp byte ptr [bp - 0xa3], 0x5c
1630  74 5E           je 0x1690
1632  8A 86 5B FF     mov al, byte ptr [bp - 0xa5]
1636  3A 06 81 E0     cmp al, byte ptr [0xe081]
163A  75 40           jne 0x167c
163C  8D BE 5A FD     lea di, [bp - 0x2a6]
1640  16              push ss
1641  57              push di
1642  BF 80 E0        mov di, 0xe080
1645  1E              push ds
1646  57              push di
1647  9A 53 0B C9 26  call far 26C9:0B53
164C  8D BE 5A FE     lea di, [bp - 0x1a6]
1650  16              push ss
1651  57              push di
1652  8D BE 5A FF     lea di, [bp - 0xa6]
1656  16              push ss
1657  57              push di
1658  6A 03           push 3
165A  8A 86 5A FF     mov al, byte ptr [bp - 0xa6]
165E  30 E4           xor ah, ah
1660  48              dec ax
1661  48              dec ax
1662  50              push ax
1663  9A 91 0B C9 26  call far 26C9:0B91
1668  9A D2 0B C9 26  call far 26C9:0BD2
166D  8D BE 5A FF     lea di, [bp - 0xa6]
1671  16              push ss
1672  57              push di
1673  6A 50           push 0x50
1675  9A 6D 0B C9 26  call far 26C9:0B6D
167A  EB 14           jmp 0x1690
loc_167C:
167C  BF E3 14        mov di, 0x14e3
167F  0E              push cs
1680  57              push di
1681  8D BE 5A FF     lea di, [bp - 0xa6]
1685  16              push ss
1686  57              push di
1687  6A 50           push 0x50
1689  6A 03           push 3
168B  9A 9C 0C C9 26  call far 26C9:0C9C
loc_1690:
1690  6A 3A           push 0x3a
1692  8D BE 5A FF     lea di, [bp - 0xa6]
1696  16              push ss
1697  57              push di
1698  0E              push cs
1699  E8 E2 F1        call 0x87e
169C  BF E1 14        mov di, 0x14e1
169F  0E              push cs
16A0  57              push di
16A1  8D BE 5A FF     lea di, [bp - 0xa6]
16A5  16              push ss
16A6  57              push di
16A7  6A 50           push 0x50
16A9  6A 02           push 2
16AB  9A 9C 0C C9 26  call far 26C9:0C9C
loc_16B0:
16B0  BF E5 14        mov di, 0x14e5
16B3  0E              push cs
16B4  57              push di
16B5  8D BE 5A FF     lea di, [bp - 0xa6]
16B9  16              push ss
16BA  57              push di
16BB  9A FE 0B C9 26  call far 26C9:0BFE
16C0  88 46 AD        mov byte ptr [bp - 0x53], al
16C3  80 7E AD 03     cmp byte ptr [bp - 0x53], 3
16C7  76 46           jbe 0x170f
16C9  6A 5C           push 0x5c
16CB  8D BE 5A FE     lea di, [bp - 0x1a6]
16CF  16              push ss
16D0  57              push di
16D1  8D BE 5A FF     lea di, [bp - 0xa6]
16D5  16              push ss
16D6  57              push di
16D7  6A 01           push 1
16D9  8A 46 AD        mov al, byte ptr [bp - 0x53]
16DC  30 E4           xor ah, ah
16DE  48              dec ax
16DF  50              push ax
16E0  9A 91 0B C9 26  call far 26C9:0B91
16E5  0E              push cs
16E6  E8 46 F1        call 0x82f
16E9  88 46 AC        mov byte ptr [bp - 0x54], al
16EC  8D BE 5A FF     lea di, [bp - 0xa6]
16F0  16              push ss
16F1  57              push di
16F2  8A 46 AC        mov al, byte ptr [bp - 0x54]
16F5  30 E4           xor ah, ah
16F7  50              push ax
16F8  8A 46 AC        mov al, byte ptr [bp - 0x54]
16FB  30 E4           xor ah, ah
16FD  8B D0           mov dx, ax
16FF  8A 46 AD        mov al, byte ptr [bp - 0x53]
1702  30 E4           xor ah, ah
1704  40              inc ax
1705  2B C2           sub ax, dx
1707  50              push ax
1708  9A FB 0C C9 26  call far 26C9:0CFB
170D  EB 15           jmp 0x1724
loc_170F:
170F  80 7E AD 03     cmp byte ptr [bp - 0x53], 3
1713  75 0F           jne 0x1724
1715  8D BE 5A FF     lea di, [bp - 0xa6]
1719  16              push ss
171A  57              push di
171B  6A 03           push 3
171D  6A 01           push 1
171F  9A FB 0C C9 26  call far 26C9:0CFB
loc_1724:
1724  80 7E AD 00     cmp byte ptr [bp - 0x53], 0
1728  75 86           jne 0x16b0
172A  6A 2A           push 0x2a
172C  8D BE 5A FF     lea di, [bp - 0xa6]
1730  16              push ss
1731  57              push di
1732  0E              push cs
1733  E8 48 F1        call 0x87e
1736  6A 3F           push 0x3f
1738  8D BE 5A FF     lea di, [bp - 0xa6]
173C  16              push ss
173D  57              push di
173E  0E              push cs
173F  E8 3C F1        call 0x87e
1742  8D BE 5A FF     lea di, [bp - 0xa6]
1746  16              push ss
1747  57              push di
1748  C4 7E 06        les di, ptr [bp + 6]
174B  06              push es
174C  57              push di
174D  6A 44           push 0x44
174F  9A 6D 0B C9 26  call far 26C9:0B6D
1754  EB 11           jmp 0x1767
loc_1756:
1756  BF 80 E0        mov di, 0xe080
1759  1E              push ds
175A  57              push di
175B  C4 7E 06        les di, ptr [bp + 6]
175E  06              push es
175F  57              push di
1760  6A 44           push 0x44
1762  9A 6D 0B C9 26  call far 26C9:0B6D
loc_1767:
1767  6A 3A           push 0x3a
1769  8D 7E AE        lea di, [bp - 0x52]
176C  16              push ss
176D  57              push di
176E  0E              push cs
176F  E8 0C F1        call 0x87e
1772  80 7E AE 00     cmp byte ptr [bp - 0x52], 0
1776  75 14           jne 0x178c
1778  BF C5 E0        mov di, 0xe0c5
177B  1E              push ds
177C  57              push di
177D  8D 7E AE        lea di, [bp - 0x52]
1780  16              push ss
1781  57              push di
1782  6A 50           push 0x50
1784  9A 6D 0B C9 26  call far 26C9:0B6D
1789  E9 52 01        jmp 0x18de
loc_178C:
178C  BF E8 14        mov di, 0x14e8
178F  0E              push cs
1790  57              push di
1791  8D 7E AE        lea di, [bp - 0x52]
1794  16              push ss
1795  57              push di
1796  9A FE 0B C9 26  call far 26C9:0BFE
179B  09 C0           or ax, ax
179D  75 37           jne 0x17d6
179F  80 3E F2 A3 00  cmp byte ptr [0xa3f2], 0
17A4  74 30           je 0x17d6
17A6  8D BE 5A FE     lea di, [bp - 0x1a6]
17AA  16              push ss
17AB  57              push di
17AC  8D 7E AE        lea di, [bp - 0x52]
17AF  16              push ss
17B0  57              push di
17B1  9A 53 0B C9 26  call far 26C9:0B53
17B6  BF E8 14        mov di, 0x14e8
17B9  0E              push cs
17BA  57              push di
17BB  9A D2 0B C9 26  call far 26C9:0BD2
17C0  BF F2 A3        mov di, 0xa3f2
17C3  1E              push ds
17C4  57              push di
17C5  9A D2 0B C9 26  call far 26C9:0BD2
17CA  8D 7E AE        lea di, [bp - 0x52]
17CD  16              push ss
17CE  57              push di
17CF  6A 50           push 0x50
17D1  9A 6D 0B C9 26  call far 26C9:0B6D
loc_17D6:
17D6  8D 7E AE        lea di, [bp - 0x52]
17D9  16              push ss
17DA  57              push di
17DB  BF DF 14        mov di, 0x14df
17DE  0E              push cs
17DF  57              push di
17E0  9A 44 0C C9 26  call far 26C9:0C44
17E5  75 11           jne 0x17f8
17E7  BF EA 14        mov di, 0x14ea
17EA  0E              push cs
17EB  57              push di
17EC  8D 7E AE        lea di, [bp - 0x52]
17EF  16              push ss
17F0  57              push di
17F1  6A 50           push 0x50
17F3  9A 6D 0B C9 26  call far 26C9:0B6D
loc_17F8:
17F8  80 7E AF 2E     cmp byte ptr [bp - 0x51], 0x2e
17FC  75 26           jne 0x1824
17FE  8D BE 5A FE     lea di, [bp - 0x1a6]
1802  16              push ss
1803  57              push di
1804  BF DF 14        mov di, 0x14df
1807  0E              push cs
1808  57              push di
1809  9A 53 0B C9 26  call far 26C9:0B53
180E  8D 7E AE        lea di, [bp - 0x52]
1811  16              push ss
1812  57              push di
1813  9A D2 0B C9 26  call far 26C9:0BD2
1818  8D 7E AE        lea di, [bp - 0x52]
181B  16              push ss
181C  57              push di
181D  6A 50           push 0x50
181F  9A 6D 0B C9 26  call far 26C9:0B6D
loc_1824:
1824  8A 46 AE        mov al, byte ptr [bp - 0x52]
1827  30 E4           xor ah, ah
1829  8B F8           mov di, ax
182B  80 7B AE 2E     cmp byte ptr [bp + di - 0x52], 0x2e
182F  75 2D           jne 0x185e
1831  80 3E F2 A3 00  cmp byte ptr [0xa3f2], 0
1836  75 26           jne 0x185e
1838  8D BE 5A FE     lea di, [bp - 0x1a6]
183C  16              push ss
183D  57              push di
183E  8D 7E AE        lea di, [bp - 0x52]
1841  16              push ss
1842  57              push di
1843  9A 53 0B C9 26  call far 26C9:0B53
1848  BF DF 14        mov di, 0x14df
184B  0E              push cs
184C  57              push di
184D  9A D2 0B C9 26  call far 26C9:0BD2
1852  8D 7E AE        lea di, [bp - 0x52]
1855  16              push ss
1856  57              push di
1857  6A 50           push 0x50
1859  9A 6D 0B C9 26  call far 26C9:0B6D
loc_185E:
185E  BF E8 14        mov di, 0x14e8
1861  0E              push cs
1862  57              push di
1863  8D 7E AE        lea di, [bp - 0x52]
1866  16              push ss
1867  57              push di
1868  9A FE 0B C9 26  call far 26C9:0BFE
186D  88 46 AD        mov byte ptr [bp - 0x53], al
1870  80 7E AD 00     cmp byte ptr [bp - 0x53], 0
1874  75 0C           jne 0x1882
1876  80 7E AE 08     cmp byte ptr [bp - 0x52], 8
187A  76 06           jbe 0x1882
187C  C6 46 AE 08     mov byte ptr [bp - 0x52], 8
1880  EB 5C           jmp 0x18de
loc_1882:
1882  80 7E AD 08     cmp byte ptr [bp - 0x53], 8
1886  76 56           jbe 0x18de
1888  8D BE 5A FE     lea di, [bp - 0x1a6]
188C  16              push ss
188D  57              push di
188E  8D 7E AE        lea di, [bp - 0x52]
1891  16              push ss
1892  57              push di
1893  6A 01           push 1
1895  6A 08           push 8
1897  9A 91 0B C9 26  call far 26C9:0B91
189C  8D BE 5A FD     lea di, [bp - 0x2a6]
18A0  16              push ss
18A1  57              push di
18A2  8D 7E AE        lea di, [bp - 0x52]
18A5  16              push ss
18A6  57              push di
18A7  8A 46 AD        mov al, byte ptr [bp - 0x53]
18AA  30 E4           xor ah, ah
18AC  50              push ax
18AD  6A 00           push 0
18AF  6A 04           push 4
18B1  8A 46 AD        mov al, byte ptr [bp - 0x53]
18B4  30 E4           xor ah, ah
18B6  8B D0           mov dx, ax
18B8  8A 46 AE        mov al, byte ptr [bp - 0x52]
18BB  30 E4           xor ah, ah
18BD  2B C2           sub ax, dx
18BF  40              inc ax
18C0  99              cdq
18C1  52              push dx
18C2  50              push ax
18C3  0E              push cs
18C4  E8 33 EC        call 0x4fa
18C7  50              push ax
18C8  9A 91 0B C9 26  call far 26C9:0B91
18CD  9A D2 0B C9 26  call far 26C9:0BD2
18D2  8D 7E AE        lea di, [bp - 0x52]
18D5  16              push ss
18D6  57              push di
18D7  6A 50           push 0x50
18D9  9A 6D 0B C9 26  call far 26C9:0B6D
loc_18DE:
18DE  8D 7E AE        lea di, [bp - 0x52]
18E1  16              push ss
18E2  57              push di
18E3  C4 7E 06        les di, ptr [bp + 6]
18E6  81 C7 45 00     add di, 0x45
18EA  06              push es
18EB  57              push di
18EC  6A 0C           push 0xc
18EE  9A 6D 0B C9 26  call far 26C9:0B6D
18F3  C9              leave
18F4  CA 08 00        retf 8
; data (not reached as code), 8 bytes
18F7                  db 50 53 51 52 56 57 1E 06   ; PSQRVW..

; ---- routine 24BC:18FF  (found by: prologue)
sub_18FF:
18FF  55              push bp
1900  89 E5           mov bp, sp
1902  B8 64 28        mov ax, 0x2864   ; relocated segment word 2864
1905  8E D8           mov ds, ax
1907  83 3E D8 E0 00  cmp word ptr [0xe0d8], 0
190C  76 04           jbe 0x1912
190E  FF 0E D8 E0     dec word ptr [0xe0d8]
loc_1912:
1912  83 3E CC A4 40  cmp word ptr [0xa4cc], 0x40
1917  75 08           jne 0x1921
1919  C7 06 CC A4 01 00 mov word ptr [0xa4cc], 1
191F  EB 24           jmp 0x1945
loc_1921:
1921  FF 06 CC A4     inc word ptr [0xa4cc]
1925  C4 3E 26 DE     les di, ptr [0xde26]
1929  26 83 7D 02 00  cmp word ptr es:[di + 2], 0
192E  7F 08           jg 0x1938
1930  7C 13           jl 0x1945
1932  26 83 3D 00     cmp word ptr es:[di], 0
1936  76 0D           jbe 0x1945
loc_1938:
1938  C4 3E 26 DE     les di, ptr [0xde26]
193C  26 83 2D 01     sub word ptr es:[di], 1
1940  26 83 5D 02 00  sbb word ptr es:[di + 2], 0
loc_1945:
1945  C9              leave
1946  07              pop es
1947  1F              pop ds
1948  5F              pop di
1949  5E              pop si
194A  5A              pop dx
194B  59              pop cx
194C  5B              pop bx
194D  58              pop ax
194E  CF              iret

; ---- routine 24BC:194F  (found by: call, prologue)
sub_194F:
194F  55              push bp
1950  89 E5           mov bp, sp
1952  80 7E 04 00     cmp byte ptr [bp + 4], 0
1956  74 11           je 0x1969
1958  6A 1C           push 0x1c
195A  BF F7 18        mov di, 0x18f7
195D  B8 BC 24        mov ax, 0x24bc   ; relocated segment word 24BC
1960  50              push ax
1961  57              push di
1962  9A 94 00 B8 26  call far 26B8:0094
1967  EB 0F           jmp 0x1978
loc_1969:
1969  6A 1C           push 0x1c
196B  FF 36 D6 E0     push word ptr [0xe0d6]
196F  FF 36 D4 E0     push word ptr [0xe0d4]
1973  9A 94 00 B8 26  call far 26B8:0094
loc_1978:
1978  C9              leave
1979  C2 02 00        ret 2

; ---- routine 24BC:197C  (found by: call, prologue)
sub_197C:
197C  55              push bp
197D  89 E5           mov bp, sp
197F  B0 36           mov al, 0x36
1981  E6 43           out 0x43, al
1983  8A 46 06        mov al, byte ptr [bp + 6]
1986  E6 40           out 0x40, al
1988  8A 46 07        mov al, byte ptr [bp + 7]
198B  E6 40           out 0x40, al
198D  C9              leave
198E  CA 02 00        retf 2

; ---- routine 24BC:1991  (found by: call, prologue)
sub_1991:
1991  55              push bp
1992  89 E5           mov bp, sp
1994  6A FF           push -1
1996  0E              push cs
1997  E8 E2 FF        call 0x197c
199A  6A 00           push 0
199C  E8 B0 FF        call 0x194f
199F  C6 06 DA E0 01  mov byte ptr [0xe0da], 1
19A4  C9              leave
19A5  CB              retf

; ---- routine 24BC:19A6  (found by: far)
sub_19A6:
19A6  C8 04 00 00     enter 4, 0
19AA  A0 DA E0        mov al, byte ptr [0xe0da]
19AD  30 E4           xor ah, ah
19AF  8B D0           mov dx, ax
19B1  6B 46 06 12     imul ax, word ptr [bp + 6], 0x12
19B5  F7 E2           mul dx
19B7  31 D2           xor dx, dx
19B9  C4 3E 26 DE     les di, ptr [0xde26]
19BD  26 03 05        add ax, word ptr es:[di]
19C0  26 13 55 02     adc dx, word ptr es:[di + 2]
19C4  89 46 FC        mov word ptr [bp - 4], ax
19C7  89 56 FE        mov word ptr [bp - 2], dx
loc_19CA:
19CA  0E              push cs
19CB  E8 8A F2        call 0xc58
19CE  08 C0           or al, al
19D0  75 17           jne 0x19e9
19D2  C4 3E 26 DE     les di, ptr [0xde26]
19D6  26 8B 05        mov ax, word ptr es:[di]
19D9  26 8B 55 02     mov dx, word ptr es:[di + 2]
19DD  3B 56 FE        cmp dx, word ptr [bp - 2]
19E0  7F 07           jg 0x19e9
19E2  7C E6           jl 0x19ca
19E4  3B 46 FC        cmp ax, word ptr [bp - 4]
19E7  76 E1           jbe 0x19ca
loc_19E9:
19E9  C9              leave
19EA  CA 02 00        retf 2

; ---- routine 24BC:19ED  (found by: call)
sub_19ED:
19ED  C8 14 00 00     enter 0x14, 0
19F1  C7 46 EC 03 00  mov word ptr [bp - 0x14], 3
19F6  6A 10           push 0x10
19F8  8D 7E EC        lea di, [bp - 0x14]
19FB  16              push ss
19FC  57              push di
19FD  9A B2 00 B8 26  call far 26B8:00B2
1A02  31 C0           xor ax, ax
1A04  8B 16 28 A5     mov dx, word ptr [0xa528]
1A08  A3 1A DE        mov word ptr [0xde1a], ax
1A0B  89 16 1C DE     mov word ptr [0xde1c], dx
1A0F  A1 1A DE        mov ax, word ptr [0xde1a]
1A12  8B 16 1C DE     mov dx, word ptr [0xde1c]
1A16  A3 1E DE        mov word ptr [0xde1e], ax
1A19  89 16 20 DE     mov word ptr [0xde20], dx
1A1D  6A 1A           push 0x1a
1A1F  6A 01           push 1
1A21  0E              push cs
1A22  E8 3A F3        call 0xd5f
1A25  C7 06 72 F8 19 00 mov word ptr [0xf872], 0x19
1A2B  C7 06 82 DE 81 07 mov word ptr [0xde82], 0x781
1A31  C7 06 DC E0 50 00 mov word ptr [0xe0dc], 0x50
1A37  C7 06 74 F8 19 00 mov word ptr [0xf874], 0x19
1A3D  C7 06 76 F8 50 00 mov word ptr [0xf876], 0x50
1A43  C9              leave
1A44  CB              retf

; ---- routine 24BC:1A45  (found by: call)
sub_1A45:
1A45  C8 14 00 00     enter 0x14, 0
1A49  C6 46 ED 10     mov byte ptr [bp - 0x13], 0x10
1A4D  C6 46 EC 02     mov byte ptr [bp - 0x14], 2
1A51  8C D8           mov ax, ds
1A53  89 46 FC        mov word ptr [bp - 4], ax
1A56  B8 CE A4        mov ax, 0xa4ce
1A59  89 46 F2        mov word ptr [bp - 0xe], ax
1A5C  6A 10           push 0x10
1A5E  8D 7E EC        lea di, [bp - 0x14]
1A61  16              push ss
1A62  57              push di
1A63  9A B2 00 B8 26  call far 26B8:00B2
1A68  C6 46 ED 12     mov byte ptr [bp - 0x13], 0x12
1A6C  C6 46 EE 31     mov byte ptr [bp - 0x12], 0x31
1A70  C6 46 EC 01     mov byte ptr [bp - 0x14], 1
1A74  6A 10           push 0x10
1A76  8D 7E EC        lea di, [bp - 0x14]
1A79  16              push ss
1A7A  57              push di
1A7B  9A B2 00 B8 26  call far 26B8:00B2
1A80  C6 46 ED 10     mov byte ptr [bp - 0x13], 0x10
1A84  C6 46 EC 13     mov byte ptr [bp - 0x14], 0x13
1A88  C6 46 EE 01     mov byte ptr [bp - 0x12], 1
1A8C  C6 46 EF 00     mov byte ptr [bp - 0x11], 0
1A90  6A 10           push 0x10
1A92  8D 7E EC        lea di, [bp - 0x14]
1A95  16              push ss
1A96  57              push di
1A97  9A B2 00 B8 26  call far 26B8:00B2
1A9C  BF 7C A4        mov di, 0xa47c
1A9F  1E              push ds
1AA0  57              push di
1AA1  BF 75 F5        mov di, 0xf575
1AA4  1E              push ds
1AA5  57              push di
1AA6  6A 30           push 0x30
1AA8  0E              push cs
1AA9  E8 16 E7        call 0x1c2
1AAC  BF 75 F5        mov di, 0xf575
1AAF  1E              push ds
1AB0  57              push di
1AB1  0E              push cs
1AB2  E8 20 00        call 0x1ad5
1AB5  C9              leave
1AB6  CB              retf

; ---- routine 24BC:1AB7  (found by: call, prologue)
sub_1AB7:
1AB7  C8 14 00 00     enter 0x14, 0
1ABB  C6 46 ED 12     mov byte ptr [bp - 0x13], 0x12
1ABF  C6 46 EE 31     mov byte ptr [bp - 0x12], 0x31
1AC3  C6 46 EC 00     mov byte ptr [bp - 0x14], 0
1AC7  6A 10           push 0x10
1AC9  8D 7E EC        lea di, [bp - 0x14]
1ACC  16              push ss
1ACD  57              push di
1ACE  9A B2 00 B8 26  call far 26B8:00B2
1AD3  C9              leave
1AD4  CB              retf

; ---- routine 24BC:1AD5  (found by: call, far)
sub_1AD5:
1AD5  C8 14 00 00     enter 0x14, 0
1AD9  C6 46 ED 10     mov byte ptr [bp - 0x13], 0x10
1ADD  C6 46 EC 12     mov byte ptr [bp - 0x14], 0x12
1AE1  C4 7E 06        les di, ptr [bp + 6]
1AE4  8C C0           mov ax, es
1AE6  89 46 FC        mov word ptr [bp - 4], ax
1AE9  89 F8           mov ax, di
1AEB  89 46 F2        mov word ptr [bp - 0xe], ax
1AEE  C7 46 F0 10 00  mov word ptr [bp - 0x10], 0x10
1AF3  31 C0           xor ax, ax
1AF5  89 46 EE        mov word ptr [bp - 0x12], ax
1AF8  6A 10           push 0x10
1AFA  8D 7E EC        lea di, [bp - 0x14]
1AFD  16              push ss
1AFE  57              push di
1AFF  9A B2 00 B8 26  call far 26B8:00B2
1B04  C9              leave
1B05  CA 04 00        retf 4

; ---- routine 24BC:1B08  (found by: call)
sub_1B08:
1B08  55              push bp
1B09  89 E5           mov bp, sp
1B0B  B0 00           mov al, 0
1B0D  BA CE 03        mov dx, 0x3ce
1B10  EE              out dx, al
1B11  8A 46 06        mov al, byte ptr [bp + 6]
1B14  BA CF 03        mov dx, 0x3cf
1B17  EE              out dx, al
1B18  C9              leave
1B19  CA 02 00        retf 2

; ---- routine 24BC:1B1C  (found by: call)
sub_1B1C:
1B1C  55              push bp
1B1D  89 E5           mov bp, sp
1B1F  B0 08           mov al, 8
1B21  BA CE 03        mov dx, 0x3ce
1B24  EE              out dx, al
1B25  8A 46 06        mov al, byte ptr [bp + 6]
1B28  BA CF 03        mov dx, 0x3cf
1B2B  EE              out dx, al
1B2C  C9              leave
1B2D  CA 02 00        retf 2

; ---- routine 24BC:1B30  (found by: call)
sub_1B30:
1B30  55              push bp
1B31  89 E5           mov bp, sp
1B33  80 3E DE E0 00  cmp byte ptr [0xe0de], 0
1B38  74 1C           je 0x1b56
1B3A  69 46 0A 40 01  imul ax, word ptr [bp + 0xa], 0x140
1B3F  C4 3E E0 E0     les di, ptr [0xe0e0]
1B43  03 F8           add di, ax
1B45  06              push es
1B46  57              push di
1B47  69 46 08 40 01  imul ax, word ptr [bp + 8], 0x140
1B4C  50              push ax
1B4D  FF 76 06        push word ptr [bp + 6]
1B50  0E              push cs
1B51  E8 CE E6        call 0x222
1B54  EB 29           jmp 0x1b7f
loc_1B56:
1B56  6A FF           push -1
1B58  0E              push cs
1B59  E8 C0 FF        call 0x1b1c
1B5C  8A 46 06        mov al, byte ptr [bp + 6]
1B5F  50              push ax
1B60  0E              push cs
1B61  E8 A4 FF        call 0x1b08
1B64  A1 DC E0        mov ax, word ptr [0xe0dc]
1B67  F7 66 0A        mul word ptr [bp + 0xa]
1B6A  C4 3E E0 E0     les di, ptr [0xe0e0]
1B6E  03 F8           add di, ax
1B70  06              push es
1B71  57              push di
1B72  A1 DC E0        mov ax, word ptr [0xe0dc]
1B75  F7 66 08        mul word ptr [bp + 8]
1B78  50              push ax
1B79  6A 00           push 0
1B7B  0E              push cs
1B7C  E8 A3 E6        call 0x222
loc_1B7F:
1B7F  C9              leave
1B80  CA 06 00        retf 6

; ---- routine 24BC:1B83  (found by: call)
sub_1B83:
1B83  55              push bp
1B84  89 E5           mov bp, sp
1B86  B0 05           mov al, 5
1B88  BA CE 03        mov dx, 0x3ce
1B8B  EE              out dx, al
1B8C  8A 46 06        mov al, byte ptr [bp + 6]
1B8F  BA CF 03        mov dx, 0x3cf
1B92  EE              out dx, al
1B93  C9              leave
1B94  CA 02 00        retf 2

; ---- routine 24BC:1B97  (found by: call)
sub_1B97:
1B97  55              push bp
1B98  89 E5           mov bp, sp
1B9A  1E              push ds
1B9B  FC              cld
1B9C  BA CE 03        mov dx, 0x3ce
1B9F  B0 08           mov al, 8
1BA1  EE              out dx, al
1BA2  42              inc dx
1BA3  8A 5E 08        mov bl, byte ptr [bp + 8]
1BA6  8A 7E 06        mov bh, byte ptr [bp + 6]
1BA9  C4 7E 0C        les di, ptr [bp + 0xc]
1BAC  B0 FF           mov al, 0xff
1BAE  EE              out dx, al
1BAF  8A 46 04        mov al, byte ptr [bp + 4]
1BB2  26 A2 FF FF     mov byte ptr es:[0xffff], al
1BB6  C5 76 14        lds si, ptr [bp + 0x14]
1BB9  AC              lodsb al, byte ptr [si]
1BBA  88 C1           mov cl, al
1BBC  30 ED           xor ch, ch
1BBE  E3 23           jcxz 0x1be3
1BC0  AC              lodsb al, byte ptr [si]
1BC1  F6 E3           mul bl
1BC3  1E              push ds
1BC4  56              push si
1BC5  51              push cx
1BC6  57              push di
1BC7  C5 76 10        lds si, ptr [bp + 0x10]
1BCA  01 C6           add si, ax
1BCC  88 D9           mov cl, bl
1BCE  AC              lodsb al, byte ptr [si]
1BCF  EE              out dx, al
1BD0  26 A0 FF FF     mov al, byte ptr es:[0xffff]
1BD4  26 88 3D        mov byte ptr es:[di], bh
1BD7  03 7E 0A        add di, word ptr [bp + 0xa]
1BDA  E2 F2           loop 0x1bce
1BDC  5F              pop di
1BDD  59              pop cx
1BDE  5E              pop si
1BDF  1F              pop ds
1BE0  47              inc di
1BE1  E2 DD           loop 0x1bc0
loc_1BE3:
1BE3  1F              pop ds
1BE4  C9              leave
1BE5  C2 14 00        ret 0x14

; ---- routine 24BC:1BE8  (found by: call)
sub_1BE8:
1BE8  C8 06 00 00     enter 6, 0
1BEC  31 C0           xor ax, ax
1BEE  89 46 FE        mov word ptr [bp - 2], ax
1BF1  1E              push ds
1BF2  C4 7E 04        les di, ptr [bp + 4]
1BF5  C5 76 0E        lds si, ptr [bp + 0xe]
1BF8  8A 56 0C        mov dl, byte ptr [bp + 0xc]
1BFB  8A 76 0A        mov dh, byte ptr [bp + 0xa]
1BFE  FC              cld
1BFF  AC              lodsb al, byte ptr [si]
1C00  30 E4           xor ah, ah
1C02  89 C1           mov cx, ax
1C04  E3 4B           jcxz 0x1c51
1C06  AC              lodsb al, byte ptr [si]
1C07  57              push di
1C08  1E              push ds
1C09  56              push si
1C0A  51              push cx
1C0B  31 DB           xor bx, bx
1C0D  8E DB           mov ds, bx
1C0F  C5 76 12        lds si, ptr [bp + 0x12]
1C12  30 ED           xor ch, ch
1C14  B1 09           mov cl, 9
1C16  F6 E1           mul cl
1C18  01 C6           add si, ax
1C1A  AC              lodsb al, byte ptr [si]
1C1B  30 E4           xor ah, ah
1C1D  01 46 FE        add word ptr [bp - 2], ax
1C20  88 C4           mov ah, al
1C22  49              dec cx
1C23  AC              lodsb al, byte ptr [si]
1C24  88 C3           mov bl, al
1C26  51              push cx
1C27  30 ED           xor ch, ch
1C29  88 E1           mov cl, ah
1C2B  57              push di
1C2C  F6 C3 80        test bl, 0x80
1C2F  74 05           je 0x1c36
1C31  88 D0           mov al, dl
1C33  AA              stosb byte ptr es:[di], al
1C34  EB 03           jmp 0x1c39
loc_1C36:
1C36  88 F0           mov al, dh
1C38  AA              stosb byte ptr es:[di], al
loc_1C39:
1C39  D0 E3           shl bl, 1
1C3B  E2 EF           loop 0x1c2c
1C3D  5F              pop di
1C3E  81 C7 40 01     add di, 0x140
1C42  59              pop cx
1C43  E2 DE           loop 0x1c23
1C45  59              pop cx
1C46  5E              pop si
1C47  1F              pop ds
1C48  5F              pop di
1C49  88 E0           mov al, ah
1C4B  30 E4           xor ah, ah
1C4D  01 C7           add di, ax
1C4F  E2 B5           loop 0x1c06
loc_1C51:
1C51  1F              pop ds
1C52  31 C0           xor ax, ax
1C54  89 46 FC        mov word ptr [bp - 4], ax
1C57  8B 46 FE        mov ax, word ptr [bp - 2]
1C5A  3B 46 08        cmp ax, word ptr [bp + 8]
1C5D  73 33           jae 0x1c92
1C5F  C7 46 FA 01 00  mov word ptr [bp - 6], 1
1C64  EB 03           jmp 0x1c69
loc_1C66:
1C66  FF 46 FA        inc word ptr [bp - 6]
loc_1C69:
1C69  8B 46 FE        mov ax, word ptr [bp - 2]
1C6C  03 46 FC        add ax, word ptr [bp - 4]
1C6F  C4 7E 04        les di, ptr [bp + 4]
1C72  03 F8           add di, ax
1C74  06              push es
1C75  57              push di
1C76  8B 46 08        mov ax, word ptr [bp + 8]
1C79  2B 46 FE        sub ax, word ptr [bp - 2]
1C7C  50              push ax
1C7D  8A 46 0A        mov al, byte ptr [bp + 0xa]
1C80  30 E4           xor ah, ah
1C82  50              push ax
1C83  0E              push cs
1C84  E8 9B E5        call 0x222
1C87  81 46 FC 40 01  add word ptr [bp - 4], 0x140
1C8C  83 7E FA 09     cmp word ptr [bp - 6], 9
1C90  75 D4           jne 0x1c66
loc_1C92:
1C92  C9              leave
1C93  C2 12 00        ret 0x12

