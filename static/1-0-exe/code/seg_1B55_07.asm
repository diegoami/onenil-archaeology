; 1-0.EXE (One-Nil 96), code segment 1B55 (image offsets 1B550..2315F), part 7 of 12
; packed 1-0.EXE sha256 89ff9c5f238f24e81a0c2440a46cdd8997280a65fc3cc3d97cb974f55280a80a (LZEXE 0.91)
; unpacked (tools/static/unlzexe.py) sha256 887ed2a92767950e5309b2052409f875668605939b69e00737aa3047022b9f51
; tool: capstone 5.0.9 (pip package; core library 5.0.1280) (CS_ARCH_X86, CS_MODE_16), recursive descent from the entry point, far calls and near calls/jumps, then routine prologues (55 89 E5 / 55 8B EC / C8 iw 00) in what remains; tools/static/listing.py
; addresses are SEGMENT:OFFSET with SEGMENT the image paragraph before relocation; image offset = SEGMENT*16+OFFSET
; ---- routine 1B55:40DF  (found by: call, far)
sub_40DF:
40DF  C8 02 00 00     enter 2, 0
40E3  83 7E 06 3A     cmp word ptr [bp + 6], 0x3a
40E7  74 24           je 0x410d
40E9  8B 46 06        mov ax, word ptr [bp + 6]
40EC  8B F0           mov si, ax
40EE  D1 E0           shl ax, 1
40F0  01 F0           add ax, si
40F2  8B D0           mov dx, ax
40F4  69 46 08 AE 00  imul ax, word ptr [bp + 8], 0xae
40F9  C4 3E CA D7     les di, ptr [0xd7ca]
40FD  03 F8           add di, ax
40FF  03 FA           add di, dx
4101  26 80 BD 50 FF 00 cmp byte ptr es:[di - 0xb0], 0
4107  74 04           je 0x410d
4109  B0 00           mov al, 0
410B  EB 02           jmp 0x410f
loc_410D:
410D  B0 01           mov al, 1
loc_410F:
410F  88 46 FF        mov byte ptr [bp - 1], al
4112  8A 46 FF        mov al, byte ptr [bp - 1]
4115  C9              leave
4116  CA 04 00        retf 4

; ---- routine 1B55:4119  (found by: call, far)
sub_4119:
4119  C8 46 00 00     enter 0x46, 0
411D  C4 3E D2 D7     les di, ptr [0xd7d2]
4121  89 7E FA        mov word ptr [bp - 6], di
4124  8C 46 FC        mov word ptr [bp - 4], es
4127  FF 76 06        push word ptr [bp + 6]
412A  26 8A 05        mov al, byte ptr es:[di]
412D  30 E4           xor ah, ah
412F  40              inc ax
4130  50              push ax
4131  0E              push cs
4132  E8 AA FF        call 0x40df
4135  08 C0           or al, al
4137  74 03           je 0x413c
4139  E9 DA 00        jmp 0x4216
loc_413C:
413C  C4 7E FA        les di, ptr [bp - 6]
413F  26 8A 05        mov al, byte ptr es:[di]
4142  30 E4           xor ah, ah
4144  40              inc ax
4145  8B F0           mov si, ax
4147  D1 E0           shl ax, 1
4149  01 F0           add ax, si
414B  8B D0           mov dx, ax
414D  69 46 06 AE 00  imul ax, word ptr [bp + 6], 0xae
4152  C4 3E CA D7     les di, ptr [0xd7ca]
4156  03 F8           add di, ax
4158  03 FA           add di, dx
415A  26 8A 85 50 FF  mov al, byte ptr es:[di - 0xb0]
415F  30 E4           xor ah, ah
4161  89 46 FE        mov word ptr [bp - 2], ax
4164  8A 46 06        mov al, byte ptr [bp + 6]
4167  B4 01           mov ah, 1
4169  BA 20 00        mov dx, 0x20
416C  9A 1F 0E C9 26  call far 26C9:0E1F
4171  52              push dx
4172  50              push ax
4173  8D 7E DA        lea di, [bp - 0x26]
4176  16              push ss
4177  57              push di
4178  6A 00           push 0
417A  9A 94 0D C9 26  call far 26C9:0D94
417F  A0 BA DC        mov al, byte ptr [0xdcba]
4182  50              push ax
4183  9A AA 0D C9 26  call far 26C9:0DAA
4188  A0 BB DC        mov al, byte ptr [0xdcbb]
418B  50              push ax
418C  9A AA 0D C9 26  call far 26C9:0DAA
4191  5F              pop di
4192  07              pop es
4193  58              pop ax
4194  5A              pop dx
4195  03 FA           add di, dx
4197  26 84 05        test byte ptr es:[di], al
419A  75 38           jne 0x41d4
419C  8A 46 FE        mov al, byte ptr [bp - 2]
419F  B4 01           mov ah, 1
41A1  BA 20 00        mov dx, 0x20
41A4  9A 1F 0E C9 26  call far 26C9:0E1F
41A9  52              push dx
41AA  50              push ax
41AB  8D 7E BA        lea di, [bp - 0x46]
41AE  16              push ss
41AF  57              push di
41B0  6A 00           push 0
41B2  9A 94 0D C9 26  call far 26C9:0D94
41B7  A0 BA DC        mov al, byte ptr [0xdcba]
41BA  50              push ax
41BB  9A AA 0D C9 26  call far 26C9:0DAA
41C0  A0 BB DC        mov al, byte ptr [0xdcbb]
41C3  50              push ax
41C4  9A AA 0D C9 26  call far 26C9:0DAA
41C9  5F              pop di
41CA  07              pop es
41CB  58              pop ax
41CC  5A              pop dx
41CD  03 FA           add di, dx
41CF  26 84 05        test byte ptr es:[di], al
41D2  74 02           je 0x41d6
loc_41D4:
41D4  EB 40           jmp 0x4216
loc_41D6:
41D6  6B 46 06 3E     imul ax, word ptr [bp + 6], 0x3e
41DA  C4 3E C2 D7     les di, ptr [0xd7c2]
41DE  03 F8           add di, ax
41E0  26 80 7D FC 00  cmp byte ptr es:[di - 4], 0
41E5  B0 00           mov al, 0
41E7  75 01           jne 0x41ea
41E9  40              inc ax
loc_41EA:
41EA  8A D0           mov dl, al
41EC  6B 46 06 3E     imul ax, word ptr [bp + 6], 0x3e
41F0  C4 3E C2 D7     les di, ptr [0xd7c2]
41F4  03 F8           add di, ax
41F6  26 88 55 FC     mov byte ptr es:[di - 4], dl
41FA  6B 46 FE 3E     imul ax, word ptr [bp - 2], 0x3e
41FE  C4 3E C2 D7     les di, ptr [0xd7c2]
4202  03 F8           add di, ax
4204  81 C7 C2 FF     add di, 0xffc2
4208  26 80 7D 3A 00  cmp byte ptr es:[di + 0x3a], 0
420D  B0 00           mov al, 0
420F  75 01           jne 0x4212
4211  40              inc ax
loc_4212:
4212  26 88 45 3A     mov byte ptr es:[di + 0x3a], al
loc_4216:
4216  C9              leave
4217  CA 02 00        retf 2

; ---- routine 1B55:421A  (found by: call, far)
sub_421A:
421A  C8 B6 00 00     enter 0xb6, 0
421E  31 C0           xor ax, ax
4220  A3 86 D6        mov word ptr [0xd686], ax
4223  8D BE 50 FF     lea di, [bp - 0xb0]
4227  16              push ss
4228  57              push di
4229  68 B0 00        push 0xb0
422C  6A 00           push 0
422E  9A 22 02 BC 24  call far 24BC:0222
4233  C7 86 4E FF 01 00 mov word ptr [bp - 0xb2], 1
4239  EB 04           jmp 0x423f
loc_423B:
423B  FF 86 4E FF     inc word ptr [bp - 0xb2]
loc_423F:
423F  8B 46 06        mov ax, word ptr [bp + 6]
4242  8B F0           mov si, ax
4244  D1 E0           shl ax, 1
4246  01 F0           add ax, si
4248  8B D0           mov dx, ax
424A  8B BE 4E FF     mov di, word ptr [bp - 0xb2]
424E  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
4252  30 E4           xor ah, ah
4254  69 C0 AE 00     imul ax, ax, 0xae
4258  C4 3E CA D7     les di, ptr [0xd7ca]
425C  03 F8           add di, ax
425E  03 FA           add di, dx
4260  81 C7 4F FF     add di, 0xff4f
4264  89 BE 4A FF     mov word ptr [bp - 0xb6], di
4268  8C 86 4C FF     mov word ptr [bp - 0xb4], es
426C  26 80 7D 01 00  cmp byte ptr es:[di + 1], 0
4271  74 53           je 0x42c6
4273  26 8A 45 02     mov al, byte ptr es:[di + 2]
4277  24 0F           and al, 0xf
4279  08 C0           or al, al
427B  74 49           je 0x42c6
427D  8B BE 4E FF     mov di, word ptr [bp - 0xb2]
4281  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
4285  30 E4           xor ah, ah
4287  8B F8           mov di, ax
4289  80 BB 4F FF 00  cmp byte ptr [bp + di - 0xb1], 0
428E  75 36           jne 0x42c6
4290  8B BE 4E FF     mov di, word ptr [bp - 0xb2]
4294  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
4298  30 E4           xor ah, ah
429A  8B F8           mov di, ax
429C  C6 83 4F FF 01  mov byte ptr [bp + di - 0xb1], 1
42A1  C4 BE 4A FF     les di, ptr [bp - 0xb6]
42A5  26 8A 45 01     mov al, byte ptr es:[di + 1]
42A9  30 E4           xor ah, ah
42AB  8B F8           mov di, ax
42AD  C6 83 4F FF 01  mov byte ptr [bp + di - 0xb1], 1
42B2  FF 06 86 D6     inc word ptr [0xd686]
42B6  8B BE 4E FF     mov di, word ptr [bp - 0xb2]
42BA  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
42BE  8B 3E 86 D6     mov di, word ptr [0xd686]
42C2  88 85 FB D4     mov byte ptr [di - 0x2b05], al
loc_42C6:
42C6  81 BE 4E FF B0 00 cmp word ptr [bp - 0xb2], 0xb0
42CC  74 03           je 0x42d1
42CE  E9 6A FF        jmp 0x423b
loc_42D1:
42D1  C9              leave
42D2  CA 02 00        retf 2
; data (not reached as code), 2 bytes
42D5                  db 01 FB   ; ..

; ---- routine 1B55:42D7  (found by: far)
sub_42D7:
42D7  C8 10 01 00     enter 0x110, 0
42DB  8B 46 06        mov ax, word ptr [bp + 6]
42DE  40              inc ax
42DF  3D 3A 00        cmp ax, 0x3a
42E2  76 03           jbe 0x42e7
42E4  E9 F1 01        jmp 0x44d8
loc_42E7:
42E7  8B 7E 06        mov di, word ptr [bp + 6]
42EA  80 BD 6A A2 00  cmp byte ptr [di - 0x5d96], 0
42EF  75 09           jne 0x42fa
42F1  FF 76 06        push word ptr [bp + 6]
42F4  0E              push cs
42F5  E8 26 36        call 0x791e
42F8  EB 07           jmp 0x4301
loc_42FA:
42FA  FF 76 06        push word ptr [bp + 6]
42FD  0E              push cs
42FE  E8 19 FF        call 0x421a
loc_4301:
4301  83 3E 86 D6 00  cmp word ptr [0xd686], 0
4306  75 03           jne 0x430b
4308  E9 CD 01        jmp 0x44d8
loc_430B:
430B  C7 46 F8 01 00  mov word ptr [bp - 8], 1
4310  C6 46 FF 01     mov byte ptr [bp - 1], 1
loc_4314:
4314  BF 06 29        mov di, 0x2906
4317  1E              push ds
4318  57              push di
4319  BF 5C DD        mov di, 0xdd5c
431C  1E              push ds
431D  57              push di
431E  9A 2F 05 2A 23  call far 232A:052F
4323  BF 42 43        mov di, 0x4342
4326  1E              push ds
4327  57              push di
4328  BF 5C DD        mov di, 0xdd5c
432B  1E              push ds
432C  57              push di
432D  9A 2F 05 2A 23  call far 232A:052F
4332  6A 0B           push 0xb
4334  8D BE F6 FE     lea di, [bp - 0x10a]
4338  16              push ss
4339  57              push di
433A  8B 46 06        mov ax, word ptr [bp + 6]
433D  31 D2           xor dx, dx
433F  52              push dx
4340  50              push ax
4341  9A C9 07 2A 23  call far 232A:07C9
4346  6A 02           push 2
4348  6A 18           push 0x18
434A  BF 5C DD        mov di, 0xdd5c
434D  1E              push ds
434E  57              push di
434F  9A 0C 03 2A 23  call far 232A:030C
4354  C7 46 FA 06 00  mov word ptr [bp - 6], 6
4359  8A 46 FF        mov al, byte ptr [bp - 1]
435C  30 E4           xor ah, ah
435E  03 46 F8        add ax, word ptr [bp - 8]
4361  48              dec ax
4362  89 46 F6        mov word ptr [bp - 0xa], ax
4365  8B 46 F8        mov ax, word ptr [bp - 8]
4368  05 0F 00        add ax, 0xf
436B  89 46 F4        mov word ptr [bp - 0xc], ax
436E  8B 46 F8        mov ax, word ptr [bp - 8]
4371  3B 46 F4        cmp ax, word ptr [bp - 0xc]
4374  76 03           jbe 0x4379
4376  E9 DD 00        jmp 0x4456
loc_4379:
4379  89 46 FC        mov word ptr [bp - 4], ax
437C  EB 03           jmp 0x4381
loc_437E:
437E  FF 46 FC        inc word ptr [bp - 4]
loc_4381:
4381  8B 46 FC        mov ax, word ptr [bp - 4]
4384  3B 06 86 D6     cmp ax, word ptr [0xd686]
4388  76 03           jbe 0x438d
438A  E9 BE 00        jmp 0x444b
loc_438D:
438D  6A 05           push 5
438F  8D BE F4 FE     lea di, [bp - 0x10c]
4393  16              push ss
4394  57              push di
4395  8B 46 FC        mov ax, word ptr [bp - 4]
4398  31 D2           xor dx, dx
439A  52              push dx
439B  50              push ax
439C  9A C9 07 2A 23  call far 232A:07C9
43A1  8A 46 FA        mov al, byte ptr [bp - 6]
43A4  50              push ax
43A5  6A 11           push 0x11
43A7  BF 5C DD        mov di, 0xdd5c
43AA  1E              push ds
43AB  57              push di
43AC  9A 0C 03 2A 23  call far 232A:030C
43B1  8B 46 06        mov ax, word ptr [bp + 6]
43B4  8B F0           mov si, ax
43B6  D1 E0           shl ax, 1
43B8  01 F0           add ax, si
43BA  8B D0           mov dx, ax
43BC  8B 7E FC        mov di, word ptr [bp - 4]
43BF  8A 85 FB D4     mov al, byte ptr [di - 0x2b05]
43C3  30 E4           xor ah, ah
43C5  69 C0 AE 00     imul ax, ax, 0xae
43C9  C4 3E CA D7     les di, ptr [0xd7ca]
43CD  03 F8           add di, ax
43CF  03 FA           add di, dx
43D1  81 C7 4F FF     add di, 0xff4f
43D5  89 7E F0        mov word ptr [bp - 0x10], di
43D8  8C 46 F2        mov word ptr [bp - 0xe], es
43DB  8B 7E FC        mov di, word ptr [bp - 4]
43DE  8A 85 FB D4     mov al, byte ptr [di - 0x2b05]
43E2  30 E4           xor ah, ah
43E4  6B C0 3E        imul ax, ax, 0x3e
43E7  C4 3E C2 D7     les di, ptr [0xd7c2]
43EB  03 F8           add di, ax
43ED  26 80 7D FC 00  cmp byte ptr es:[di - 4], 0
43F2  74 17           je 0x440b
43F4  6A 0E           push 0xe
43F6  BF D5 42        mov di, 0x42d5
43F9  0E              push cs
43FA  57              push di
43FB  8A 46 FA        mov al, byte ptr [bp - 6]
43FE  50              push ax
43FF  6A 13           push 0x13
4401  BF 5C DD        mov di, 0xdd5c
4404  1E              push ds
4405  57              push di
4406  9A 1B 04 2A 23  call far 232A:041B
loc_440B:
440B  8B 7E FC        mov di, word ptr [bp - 4]
440E  8A 85 FB D4     mov al, byte ptr [di - 0x2b05]
4412  30 E4           xor ah, ah
4414  50              push ax
4415  FF 76 06        push word ptr [bp + 6]
4418  FF 76 FA        push word ptr [bp - 6]
441B  6A 27           push 0x27
441D  0E              push cs
441E  E8 5C D2        call 0x167d
4421  6A 05           push 5
4423  8D BE F0 FE     lea di, [bp - 0x110]
4427  16              push ss
4428  57              push di
4429  C4 7E F0        les di, ptr [bp - 0x10]
442C  26 8A 05        mov al, byte ptr es:[di]
442F  50              push ax
4430  8A 46 06        mov al, byte ptr [bp + 6]
4433  50              push ax
4434  0E              push cs
4435  E8 F3 CF        call 0x142b
4438  8A 46 FA        mov al, byte ptr [bp - 6]
443B  50              push ax
443C  6A 3E           push 0x3e
443E  BF 5C DD        mov di, 0xdd5c
4441  1E              push ds
4442  57              push di
4443  9A 1B 04 2A 23  call far 232A:041B
4448  FF 46 FA        inc word ptr [bp - 6]
loc_444B:
444B  8B 46 FC        mov ax, word ptr [bp - 4]
444E  3B 46 F4        cmp ax, word ptr [bp - 0xc]
4451  74 03           je 0x4456
4453  E9 28 FF        jmp 0x437e
loc_4456:
4456  BF FC 1C        mov di, 0x1cfc
4459  1E              push ds
445A  57              push di
445B  BF 5C DD        mov di, 0xdd5c
445E  1E              push ds
445F  57              push di
4460  9A 2F 05 2A 23  call far 232A:052F
4465  8A 46 FF        mov al, byte ptr [bp - 1]
4468  30 E4           xor ah, ah
446A  05 05 00        add ax, 5
446D  50              push ax
446E  6A 13           push 0x13
4470  6A 01           push 1
4472  9A 03 02 2A 23  call far 232A:0203
4477  FF 76 F6        push word ptr [bp - 0xa]
447A  6A 01           push 1
447C  FF 36 86 D6     push word ptr [0xd686]
4480  6A 17           push 0x17
4482  6A 16           push 0x16
4484  9A 67 01 2A 23  call far 232A:0167
4489  C4 3E 5C DD     les di, ptr [0xdd5c]
448D  06              push es
448E  57              push di
448F  C4 3E 58 DD     les di, ptr [0xdd58]
4493  06              push es
4494  57              push di
4495  68 A0 0F        push 0xfa0
4498  9A 12 0A C9 26  call far 26C9:0A12
449D  9A 9B 09 2A 23  call far 232A:099B
44A2  A0 88 DE        mov al, byte ptr [0xde88]
44A5  3C 02           cmp al, 2
44A7  75 10           jne 0x44b9
44A9  8B 7E F6        mov di, word ptr [bp - 0xa]
44AC  8A 85 FB D4     mov al, byte ptr [di - 0x2b05]
44B0  30 E4           xor ah, ah
44B2  50              push ax
44B3  0E              push cs
44B4  E8 62 FC        call 0x4119
44B7  EB 15           jmp 0x44ce
loc_44B9:
44B9  8D 7E FF        lea di, [bp - 1]
44BC  16              push ss
44BD  57              push di
44BE  8D 7E F8        lea di, [bp - 8]
44C1  16              push ss
44C2  57              push di
44C3  6A 10           push 0x10
44C5  FF 36 86 D6     push word ptr [0xd686]
44C9  9A D7 0F 2A 23  call far 232A:0FD7
loc_44CE:
44CE  80 3E 88 DE 01  cmp byte ptr [0xde88], 1
44D3  74 03           je 0x44d8
44D5  E9 3C FE        jmp 0x4314
loc_44D8:
44D8  C9              leave
44D9  CA 02 00        retf 2

; ---- routine 1B55:44DC  (found by: call, far)
sub_44DC:
44DC  C8 10 00 00     enter 0x10, 0
44E0  8B 46 06        mov ax, word ptr [bp + 6]
44E3  D1 E0           shl ax, 1
44E5  C4 3E A6 D7     les di, ptr [0xd7a6]
44E9  03 F8           add di, ax
44EB  26 8B 05        mov ax, word ptr es:[di]
44EE  89 46 F2        mov word ptr [bp - 0xe], ax
44F1  8B 46 06        mov ax, word ptr [bp + 6]
44F4  40              inc ax
44F5  D1 E0           shl ax, 1
44F7  C4 3E A6 D7     les di, ptr [0xd7a6]
44FB  03 F8           add di, ax
44FD  26 8B 05        mov ax, word ptr es:[di]
4500  89 46 F0        mov word ptr [bp - 0x10], ax
4503  8B 46 F2        mov ax, word ptr [bp - 0xe]
4506  C4 3E A2 D7     les di, ptr [0xd7a2]
450A  03 F8           add di, ax
450C  06              push es
450D  57              push di
450E  8D 7E F5        lea di, [bp - 0xb]
4511  16              push ss
4512  57              push di
4513  8B 46 F0        mov ax, word ptr [bp - 0x10]
4516  2B 46 F2        sub ax, word ptr [bp - 0xe]
4519  50              push ax
451A  9A C2 01 BC 24  call far 24BC:01C2
451F  8B 46 F0        mov ax, word ptr [bp - 0x10]
4522  2B 46 F2        sub ax, word ptr [bp - 0xe]
4525  88 46 F4        mov byte ptr [bp - 0xc], al
4528  8D 7E F4        lea di, [bp - 0xc]
452B  16              push ss
452C  57              push di
452D  C4 7E 08        les di, ptr [bp + 8]
4530  06              push es
4531  57              push di
4532  6A 0A           push 0xa
4534  9A 6D 0B C9 26  call far 26C9:0B6D
4539  C9              leave
453A  CA 02 00        retf 2

; ---- routine 1B55:453D  (found by: call, far)
sub_453D:
453D  55              push bp
453E  89 E5           mov bp, sp
4540  81 3E 86 D6 90 01 cmp word ptr [0xd686], 0x190
4546  73 11           jae 0x4559
4548  FF 06 86 D6     inc word ptr [0xd686]
454C  8B 46 06        mov ax, word ptr [bp + 6]
454F  8B 3E 86 D6     mov di, word ptr [0xd686]
4553  D1 E7           shl di, 1
4555  89 85 DA D1     mov word ptr [di - 0x2e26], ax
loc_4559:
4559  C9              leave
455A  CA 02 00        retf 2

; ---- routine 1B55:455D  (found by: call)
sub_455D:
455D  C8 08 00 00     enter 8, 0
4561  8B 46 08        mov ax, word ptr [bp + 8]
4564  89 46 FE        mov word ptr [bp - 2], ax
4567  8B 46 06        mov ax, word ptr [bp + 6]
456A  89 46 FC        mov word ptr [bp - 4], ax
456D  8B 46 08        mov ax, word ptr [bp + 8]
4570  03 46 06        add ax, word ptr [bp + 6]
4573  D1 E8           shr ax, 1
4575  8B F8           mov di, ax
4577  D1 E7           shl di, 1
4579  6B 85 DA D1 0F  imul ax, word ptr [di - 0x2e26], 0xf
457E  C4 3E BE D7     les di, ptr [0xd7be]
4582  03 F8           add di, ax
4584  26 8A 45 05     mov al, byte ptr es:[di + 5]
4588  30 E4           xor ah, ah
458A  89 46 F8        mov word ptr [bp - 8], ax
loc_458D:
458D  8B 7E FE        mov di, word ptr [bp - 2]
4590  D1 E7           shl di, 1
4592  6B 85 DA D1 0F  imul ax, word ptr [di - 0x2e26], 0xf
4597  C4 3E BE D7     les di, ptr [0xd7be]
459B  03 F8           add di, ax
459D  26 8A 45 05     mov al, byte ptr es:[di + 5]
45A1  30 E4           xor ah, ah
45A3  3B 46 F8        cmp ax, word ptr [bp - 8]
45A6  76 05           jbe 0x45ad
45A8  FF 46 FE        inc word ptr [bp - 2]
45AB  EB E0           jmp 0x458d
loc_45AD:
45AD  8B 7E FC        mov di, word ptr [bp - 4]
45B0  D1 E7           shl di, 1
45B2  6B 85 DA D1 0F  imul ax, word ptr [di - 0x2e26], 0xf
45B7  C4 3E BE D7     les di, ptr [0xd7be]
45BB  03 F8           add di, ax
45BD  26 8A 45 05     mov al, byte ptr es:[di + 5]
45C1  30 E4           xor ah, ah
45C3  3B 46 F8        cmp ax, word ptr [bp - 8]
45C6  73 05           jae 0x45cd
45C8  FF 4E FC        dec word ptr [bp - 4]
45CB  EB E0           jmp 0x45ad
loc_45CD:
45CD  8B 46 FE        mov ax, word ptr [bp - 2]
45D0  3B 46 FC        cmp ax, word ptr [bp - 4]
45D3  77 30           ja 0x4605
45D5  8B 7E FE        mov di, word ptr [bp - 2]
45D8  D1 E7           shl di, 1
45DA  8B 85 DA D1     mov ax, word ptr [di - 0x2e26]
45DE  89 46 FA        mov word ptr [bp - 6], ax
45E1  8B 7E FC        mov di, word ptr [bp - 4]
45E4  D1 E7           shl di, 1
45E6  8B 85 DA D1     mov ax, word ptr [di - 0x2e26]
45EA  8B 7E FE        mov di, word ptr [bp - 2]
45ED  D1 E7           shl di, 1
45EF  89 85 DA D1     mov word ptr [di - 0x2e26], ax
45F3  8B 46 FA        mov ax, word ptr [bp - 6]
45F6  8B 7E FC        mov di, word ptr [bp - 4]
45F9  D1 E7           shl di, 1
45FB  89 85 DA D1     mov word ptr [di - 0x2e26], ax
45FF  FF 46 FE        inc word ptr [bp - 2]
4602  FF 4E FC        dec word ptr [bp - 4]
loc_4605:
4605  8B 46 FE        mov ax, word ptr [bp - 2]
4608  3B 46 FC        cmp ax, word ptr [bp - 4]
460B  76 80           jbe 0x458d
460D  8B 46 08        mov ax, word ptr [bp + 8]
4610  3B 46 FC        cmp ax, word ptr [bp - 4]
4613  73 0D           jae 0x4622
4615  FF 76 08        push word ptr [bp + 8]
4618  FF 76 FC        push word ptr [bp - 4]
461B  8B 7E 04        mov di, word ptr [bp + 4]
461E  57              push di
461F  E8 3B FF        call 0x455d
loc_4622:
4622  8B 46 FE        mov ax, word ptr [bp - 2]
4625  3B 46 06        cmp ax, word ptr [bp + 6]
4628  73 0D           jae 0x4637
462A  FF 76 FE        push word ptr [bp - 2]
462D  FF 76 06        push word ptr [bp + 6]
4630  8B 7E 04        mov di, word ptr [bp + 4]
4633  57              push di
4634  E8 26 FF        call 0x455d
loc_4637:
4637  C9              leave
4638  C2 06 00        ret 6

; ---- routine 1B55:463B  (found by: call)
sub_463B:
463B  C8 02 00 00     enter 2, 0
463F  C7 46 FE 01 00  mov word ptr [bp - 2], 1
4644  EB 03           jmp 0x4649
loc_4646:
4646  FF 46 FE        inc word ptr [bp - 2]
loc_4649:
4649  8B 46 FE        mov ax, word ptr [bp - 2]
464C  D1 E0           shl ax, 1
464E  C4 7E 06        les di, ptr [bp + 6]
4651  03 F8           add di, ax
4653  26 83 7D FE 00  cmp word ptr es:[di - 2], 0
4658  74 30           je 0x468a
465A  8B 46 FE        mov ax, word ptr [bp - 2]
465D  D1 E0           shl ax, 1
465F  C4 7E 06        les di, ptr [bp + 6]
4662  03 F8           add di, ax
4664  26 8B 45 FE     mov ax, word ptr es:[di - 2]
4668  C1 E0 03        shl ax, 3
466B  C4 3E BA D7     les di, ptr [0xd7ba]
466F  03 F8           add di, ax
4671  26 80 7D 07 00  cmp byte ptr es:[di + 7], 0
4676  74 12           je 0x468a
4678  8B 46 FE        mov ax, word ptr [bp - 2]
467B  D1 E0           shl ax, 1
467D  C4 7E 06        les di, ptr [bp + 6]
4680  03 F8           add di, ax
4682  26 FF 75 FE     push word ptr es:[di - 2]
4686  0E              push cs
4687  E8 B3 FE        call 0x453d
loc_468A:
468A  83 7E FE 14     cmp word ptr [bp - 2], 0x14
468E  75 B6           jne 0x4646
4690  C9              leave
4691  C2 06 00        ret 6

; ---- routine 1B55:4694  (found by: far)
sub_4694:
4694  C8 0A 00 00     enter 0xa, 0
4698  31 C0           xor ax, ax
469A  A3 86 D6        mov word ptr [0xd686], ax
469D  C4 7E 06        les di, ptr [bp + 6]
46A0  26 8B 05        mov ax, word ptr es:[di]
46A3  05 0F 00        add ax, 0xf
46A6  89 46 FA        mov word ptr [bp - 6], ax
46A9  26 8B 05        mov ax, word ptr es:[di]
46AC  3B 46 FA        cmp ax, word ptr [bp - 6]
46AF  77 64           ja 0x4715
46B1  89 46 FE        mov word ptr [bp - 2], ax
46B4  EB 03           jmp 0x46b9
loc_46B6:
46B6  FF 46 FE        inc word ptr [bp - 2]
loc_46B9:
46B9  8B 7E FE        mov di, word ptr [bp - 2]
46BC  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
46C0  30 E4           xor ah, ah
46C2  6B C0 3E        imul ax, ax, 0x3e
46C5  C4 3E C2 D7     les di, ptr [0xd7c2]
46C9  03 F8           add di, ax
46CB  81 C7 C2 FF     add di, 0xffc2
46CF  06              push es
46D0  57              push di
46D1  55              push bp
46D2  E8 66 FF        call 0x463b
46D5  8B 7E FE        mov di, word ptr [bp - 2]
46D8  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
46DC  3A 06 BA DC     cmp al, byte ptr [0xdcba]
46E0  75 10           jne 0x46f2
46E2  C4 3E D2 D7     les di, ptr [0xd7d2]
46E6  81 C7 58 00     add di, 0x58
46EA  06              push es
46EB  57              push di
46EC  55              push bp
46ED  E8 4B FF        call 0x463b
46F0  EB 1B           jmp 0x470d
loc_46F2:
46F2  8B 7E FE        mov di, word ptr [bp - 2]
46F5  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
46F9  3A 06 BB DC     cmp al, byte ptr [0xdcbb]
46FD  75 0E           jne 0x470d
46FF  C4 3E D2 D7     les di, ptr [0xd7d2]
4703  81 C7 80 00     add di, 0x80
4707  06              push es
4708  57              push di
4709  55              push bp
470A  E8 2E FF        call 0x463b
loc_470D:
470D  8B 46 FE        mov ax, word ptr [bp - 2]
4710  3B 46 FA        cmp ax, word ptr [bp - 6]
4713  75 A1           jne 0x46b6
loc_4715:
4715  6A 01           push 1
4717  FF 36 86 D6     push word ptr [0xd686]
471B  55              push bp
471C  E8 3E FE        call 0x455d
471F  BF DC D1        mov di, 0xd1dc
4722  1E              push ds
4723  57              push di
4724  C4 7E 06        les di, ptr [bp + 6]
4727  26 8B 3D        mov di, word ptr es:[di]
472A  8A 85 D5 D7     mov al, byte ptr [di - 0x282b]
472E  30 E4           xor ah, ah
4730  6B C0 3E        imul ax, ax, 0x3e
4733  C4 3E C2 D7     les di, ptr [0xd7c2]
4737  03 F8           add di, ax
4739  26 8A 45 F9     mov al, byte ptr es:[di - 7]
473D  98              cwde
473E  6B F8 28        imul di, ax, 0x28
4741  81 C7 AC D5     add di, 0xd5ac
4745  1E              push ds
4746  57              push di
4747  6A 28           push 0x28
4749  9A C2 01 BC 24  call far 24BC:01C2
474E  C4 7E 06        les di, ptr [bp + 6]
4751  26 83 05 10     add word ptr es:[di], 0x10
4755  C9              leave
4756  CA 04 00        retf 4

; ---- routine 1B55:4759  (found by: far)
sub_4759:
4759  C8 02 00 00     enter 2, 0
475D  8A 46 06        mov al, byte ptr [bp + 6]
4760  98              cwde
4761  8B F8           mov di, ax
4763  8A 85 DE D6     mov al, byte ptr [di - 0x2922]
4767  30 E4           xor ah, ah
4769  8B C8           mov cx, ax
476B  A0 DD D6        mov al, byte ptr [0xd6dd]
476E  30 E4           xor ah, ah
4770  8B D0           mov dx, ax
4772  8A 46 06        mov al, byte ptr [bp + 6]
4775  98              cwde
4776  8B F8           mov di, ax
4778  8A 85 E0 D6     mov al, byte ptr [di - 0x2920]
477C  30 E4           xor ah, ah
477E  03 C2           add ax, dx
4780  2B C1           sub ax, cx
4782  89 46 FE        mov word ptr [bp - 2], ax
4785  8B 46 FE        mov ax, word ptr [bp - 2]
4788  C9              leave
4789  CA 02 00        retf 2

; ---- routine 1B55:478C  (found by: far)
sub_478C:
478C  C8 0A 00 00     enter 0xa, 0
4790  BF 5E 1D        mov di, 0x1d5e
4793  1E              push ds
4794  57              push di
4795  BF 5C DD        mov di, 0xdd5c
4798  1E              push ds
4799  57              push di
479A  9A 2F 05 2A 23  call far 232A:052F
479F  83 7E 06 00     cmp word ptr [bp + 6], 0
47A3  75 03           jne 0x47a8
47A5  E9 90 00        jmp 0x4838
loc_47A8:
47A8  8B 46 06        mov ax, word ptr [bp + 6]
47AB  C1 E0 03        shl ax, 3
47AE  C4 3E BA D7     les di, ptr [0xd7ba]
47B2  03 F8           add di, ax
47B4  89 7E F6        mov word ptr [bp - 0xa], di
47B7  8C 46 F8        mov word ptr [bp - 8], es
47BA  C7 06 64 DD 70 00 mov word ptr [0xdd64], 0x70
47C0  26 8A 45 04     mov al, byte ptr es:[di + 4]
47C4  30 E4           xor ah, ah
47C6  89 46 FE        mov word ptr [bp - 2], ax
47C9  FF 46 FE        inc word ptr [bp - 2]
47CC  C7 46 FA 01 00  mov word ptr [bp - 6], 1
47D1  EB 03           jmp 0x47d6
loc_47D3:
47D3  FF 46 FA        inc word ptr [bp - 6]
loc_47D6:
47D6  8B 56 FA        mov dx, word ptr [bp - 6]
47D9  C4 7E F6        les di, ptr [bp - 0xa]
47DC  26 8A 45 07     mov al, byte ptr es:[di + 7]
47E0  30 E4           xor ah, ah
47E2  6B F8 16        imul di, ax, 0x16
47E5  03 FA           add di, dx
47E7  8A 85 7D 95     mov al, byte ptr [di - 0x6a83]
47EB  30 E4           xor ah, ah
47ED  8B D0           mov dx, ax
47EF  C4 7E F6        les di, ptr [bp - 0xa]
47F2  26 8A 45 05     mov al, byte ptr es:[di + 5]
47F6  30 E4           xor ah, ah
47F8  6B F8 16        imul di, ax, 0x16
47FB  03 FA           add di, dx
47FD  8A 85 B1 96     mov al, byte ptr [di - 0x694f]
4801  30 E4           xor ah, ah
4803  89 46 FC        mov word ptr [bp - 4], ax
4806  8B 46 FC        mov ax, word ptr [bp - 4]
4809  F7 66 FE        mul word ptr [bp - 2]
480C  C1 E8 08        shr ax, 8
480F  89 46 FC        mov word ptr [bp - 4], ax
4812  8B 46 FA        mov ax, word ptr [bp - 6]
4815  40              inc ax
4816  69 C0 A0 00     imul ax, ax, 0xa0
481A  C4 3E 5C DD     les di, ptr [0xdd5c]
481E  03 F8           add di, ax
4820  81 C7 8A FF     add di, 0xff8a
4824  06              push es
4825  57              push di
4826  A0 64 DD        mov al, byte ptr [0xdd64]
4829  50              push ax
482A  FF 76 FC        push word ptr [bp - 4]
482D  9A 4B 03 BC 24  call far 24BC:034B
4832  83 7E FA 16     cmp word ptr [bp - 6], 0x16
4836  75 9B           jne 0x47d3
loc_4838:
4838  C9              leave
4839  CA 02 00        retf 2

; ---- routine 1B55:483C  (found by: far)
sub_483C:
483C  C8 04 00 00     enter 4, 0
4840  8B 7E 06        mov di, word ptr [bp + 6]
4843  D1 E7           shl di, 1
4845  8B 85 28 98     mov ax, word ptr [di - 0x67d8]
4849  D1 E0           shl ax, 1
484B  31 D2           xor dx, dx
484D  89 46 FC        mov word ptr [bp - 4], ax
4850  89 56 FE        mov word ptr [bp - 2], dx
4853  8B 46 FC        mov ax, word ptr [bp - 4]
4856  8B 56 FE        mov dx, word ptr [bp - 2]
4859  C9              leave
485A  CA 02 00        retf 2

; ---- routine 1B55:485D  (found by: call, far)
sub_485D:
485D  C8 1A 00 00     enter 0x1a, 0
4861  8B 46 06        mov ax, word ptr [bp + 6]
4864  C1 E0 03        shl ax, 3
4867  C4 3E BA D7     les di, ptr [0xd7ba]
486B  03 F8           add di, ax
486D  89 7E EE        mov word ptr [bp - 0x12], di
4870  8C 46 F0        mov word ptr [bp - 0x10], es
4873  6B 46 06 0F     imul ax, word ptr [bp + 6], 0xf
4877  C4 3E BE D7     les di, ptr [0xd7be]
487B  03 F8           add di, ax
487D  89 7E EA        mov word ptr [bp - 0x16], di
4880  8C 46 EC        mov word ptr [bp - 0x14], es
4883  C4 7E EE        les di, ptr [bp - 0x12]
4886  26 80 7D 07 00  cmp byte ptr es:[di + 7], 0
488B  B0 00           mov al, 0
488D  75 01           jne 0x4890
488F  40              inc ax
loc_4890:
4890  98              cwde
4891  8B F8           mov di, ax
4893  8A 85 84 12     mov al, byte ptr [di + 0x1284]
4897  C4 7E EE        les di, ptr [bp - 0x12]
489A  26 3A 45 01     cmp al, byte ptr es:[di + 1]
489E  73 38           jae 0x48d8
48A0  26 80 7D 07 00  cmp byte ptr es:[di + 7], 0
48A5  B0 00           mov al, 0
48A7  75 01           jne 0x48aa
48A9  40              inc ax
loc_48AA:
48AA  98              cwde
48AB  8B F8           mov di, ax
48AD  8A 85 84 12     mov al, byte ptr [di + 0x1284]
48B1  30 E4           xor ah, ah
48B3  8B D0           mov dx, ax
48B5  C4 7E EE        les di, ptr [bp - 0x12]
48B8  26 8A 45 01     mov al, byte ptr es:[di + 1]
48BC  30 E4           xor ah, ah
48BE  2B C2           sub ax, dx
48C0  8B D0           mov dx, ax
48C2  B8 10 00        mov ax, 0x10
48C5  2B C2           sub ax, dx
48C7  99              cdq
48C8  52              push dx
48C9  50              push ax
48CA  6A 00           push 0
48CC  6A 00           push 0
48CE  9A C0 04 BC 24  call far 24BC:04C0
48D3  89 46 F2        mov word ptr [bp - 0xe], ax
48D6  EB 05           jmp 0x48dd
loc_48D8:
48D8  C7 46 F2 10 00  mov word ptr [bp - 0xe], 0x10
loc_48DD:
48DD  C4 7E EE        les di, ptr [bp - 0x12]
48E0  26 8A 45 04     mov al, byte ptr es:[di + 4]
48E4  30 E4           xor ah, ah
48E6  31 D2           xor dx, dx
48E8  89 46 F4        mov word ptr [bp - 0xc], ax
48EB  89 56 F6        mov word ptr [bp - 0xa], dx
48EE  26 8A 05        mov al, byte ptr es:[di]
48F1  30 E4           xor ah, ah
48F3  6B C0 3E        imul ax, ax, 0x3e
48F6  C4 3E C2 D7     les di, ptr [0xd7c2]
48FA  03 F8           add di, ax
48FC  26 8A 45 F9     mov al, byte ptr es:[di - 7]
4900  98              cwde
4901  8B F8           mov di, ax
4903  8A 85 74 12     mov al, byte ptr [di + 0x1274]
4907  98              cwde
4908  99              cdq
4909  01 46 F4        add word ptr [bp - 0xc], ax
490C  11 56 F6        adc word ptr [bp - 0xa], dx
490F  83 7E F6 00     cmp word ptr [bp - 0xa], 0
4913  7C 08           jl 0x491d
4915  7F 0E           jg 0x4925
4917  83 7E F4 00     cmp word ptr [bp - 0xc], 0
491B  73 08           jae 0x4925
loc_491D:
491D  31 C0           xor ax, ax
491F  89 46 F4        mov word ptr [bp - 0xc], ax
4922  89 46 F6        mov word ptr [bp - 0xa], ax
loc_4925:
4925  C4 7E EE        les di, ptr [bp - 0x12]
4928  26 8A 05        mov al, byte ptr es:[di]
492B  30 E4           xor ah, ah
492D  6B C0 3E        imul ax, ax, 0x3e
4930  C4 3E C2 D7     les di, ptr [0xd7c2]
4934  03 F8           add di, ax
4936  81 C7 C2 FF     add di, 0xffc2
493A  C4 7E EE        les di, ptr [bp - 0x12]
493D  26 80 7D 07 00  cmp byte ptr es:[di + 7], 0
4942  74 2A           je 0x496e
4944  26 8A 45 02     mov al, byte ptr es:[di + 2]
4948  30 E4           xor ah, ah
494A  40              inc ax
494B  40              inc ax
494C  8B D0           mov dx, ax
494E  26 8A 45 01     mov al, byte ptr es:[di + 1]
4952  30 E4           xor ah, ah
4954  3B C2           cmp ax, dx
4956  7F 16           jg 0x496e
4958  C4 7E EA        les di, ptr [bp - 0x16]
495B  26 8B 45 02     mov ax, word ptr es:[di + 2]
495F  31 D2           xor dx, dx
4961  B9 0A 00        mov cx, 0xa
4964  F7 F1           div cx
4966  31 D2           xor dx, dx
4968  01 46 F4        add word ptr [bp - 0xc], ax
496B  11 56 F6        adc word ptr [bp - 0xa], dx
loc_496E:
496E  6A 00           push 0
4970  68 00 01        push 0x100
4973  8B 46 F2        mov ax, word ptr [bp - 0xe]
4976  31 D2           xor dx, dx
4978  8B 4E F4        mov cx, word ptr [bp - 0xc]
497B  8B 5E F6        mov bx, word ptr [bp - 0xa]
497E  9A 2A 0A C9 26  call far 26C9:0A2A
4983  B9 10 00        mov cx, 0x10
4986  31 DB           xor bx, bx
4988  9A 67 0A C9 26  call far 26C9:0A67
498D  52              push dx
498E  50              push ax
498F  9A FA 04 BC 24  call far 24BC:04FA
4994  89 46 F4        mov word ptr [bp - 0xc], ax
4997  89 56 F6        mov word ptr [bp - 0xa], dx
499A  8B 7E F4        mov di, word ptr [bp - 0xc]
499D  D1 E7           shl di, 1
499F  8B 85 28 98     mov ax, word ptr [di - 0x67d8]
49A3  31 D2           xor dx, dx
49A5  89 46 F4        mov word ptr [bp - 0xc], ax
49A8  89 56 F6        mov word ptr [bp - 0xa], dx
49AB  8B 46 F4        mov ax, word ptr [bp - 0xc]
49AE  8B 56 F6        mov dx, word ptr [bp - 0xa]
49B1  B9 E8 03        mov cx, 0x3e8
49B4  31 DB           xor bx, bx
49B6  9A 2A 0A C9 26  call far 26C9:0A2A
49BB  89 46 F4        mov word ptr [bp - 0xc], ax
49BE  89 56 F6        mov word ptr [bp - 0xa], dx
49C1  8B 46 F4        mov ax, word ptr [bp - 0xc]
49C4  8B 56 F6        mov dx, word ptr [bp - 0xa]
49C7  89 46 FC        mov word ptr [bp - 4], ax
49CA  89 56 FE        mov word ptr [bp - 2], dx
49CD  8B 46 FC        mov ax, word ptr [bp - 4]
49D0  8B 56 FE        mov dx, word ptr [bp - 2]
49D3  C9              leave
49D4  CA 02 00        retf 2

; ---- routine 1B55:49D7  (found by: far)
sub_49D7:
49D7  C8 08 00 00     enter 8, 0
49DB  8B 46 06        mov ax, word ptr [bp + 6]
49DE  C1 E0 03        shl ax, 3
49E1  C4 3E BA D7     les di, ptr [0xd7ba]
49E5  03 F8           add di, ax
49E7  89 7E F8        mov word ptr [bp - 8], di
49EA  8C 46 FA        mov word ptr [bp - 6], es
49ED  6A 06           push 6
49EF  9A 6D 07 2A 23  call far 232A:076D
49F4  50              push ax
49F5  6A 06           push 6
49F7  9A 6D 07 2A 23  call far 232A:076D
49FC  F7 D8           neg ax
49FE  8B D0           mov dx, ax
4A00  C4 7E F8        les di, ptr [bp - 8]
4A03  26 8A 45 04     mov al, byte ptr es:[di + 4]
4A07  30 E4           xor ah, ah
4A09  03 C2           add ax, dx
4A0B  5A              pop dx
4A0C  03 C2           add ax, dx
4A0E  89 46 FC        mov word ptr [bp - 4], ax
4A11  81 7E FC FF 00  cmp word ptr [bp - 4], 0xff
4A16  7E 07           jle 0x4a1f
4A18  C7 46 FC FF 00  mov word ptr [bp - 4], 0xff
4A1D  EB 0B           jmp 0x4a2a
loc_4A1F:
4A1F  83 7E FC 04     cmp word ptr [bp - 4], 4
4A23  7D 05           jge 0x4a2a
4A25  C7 46 FC 04 00  mov word ptr [bp - 4], 4
loc_4A2A:
4A2A  8A 46 FC        mov al, byte ptr [bp - 4]
4A2D  88 46 FF        mov byte ptr [bp - 1], al
4A30  8A 46 FF        mov al, byte ptr [bp - 1]
4A33  C9              leave
4A34  CA 02 00        retf 2

; ---- routine 1B55:4A37  (found by: call, far)
sub_4A37:
4A37  C8 06 00 00     enter 6, 0
4A3B  6B 46 06 3E     imul ax, word ptr [bp + 6], 0x3e
4A3F  C4 3E C2 D7     les di, ptr [0xd7c2]
4A43  03 F8           add di, ax
4A45  81 C7 C2 FF     add di, 0xffc2
4A49  89 7E FA        mov word ptr [bp - 6], di
4A4C  8C 46 FC        mov word ptr [bp - 4], es
4A4F  26 8B 45 2A     mov ax, word ptr es:[di + 0x2a]
4A53  C1 E0 02        shl ax, 2
4A56  C4 3E C8 DC     les di, ptr [0xdcc8]
4A5A  03 F8           add di, ax
4A5C  26 8A 45 02     mov al, byte ptr es:[di + 2]
4A60  30 E4           xor ah, ah
4A62  C1 E8 04        shr ax, 4
4A65  8B D0           mov dx, ax
4A67  C4 7E FA        les di, ptr [bp - 6]
4A6A  26 8B 45 28     mov ax, word ptr es:[di + 0x28]
4A6E  C1 E0 02        shl ax, 2
4A71  C4 3E C8 DC     les di, ptr [0xdcc8]
4A75  03 F8           add di, ax
4A77  26 8A 45 02     mov al, byte ptr es:[di + 2]
4A7B  30 E4           xor ah, ah
4A7D  C1 E8 05        shr ax, 5
4A80  05 10 00        add ax, 0x10
4A83  03 C2           add ax, dx
4A85  89 46 FE        mov word ptr [bp - 2], ax
4A88  8B 46 FE        mov ax, word ptr [bp - 2]
4A8B  C9              leave
4A8C  CA 02 00        retf 2

; ---- routine 1B55:4A8F  (found by: call, far)
sub_4A8F:
4A8F  C8 0C 00 00     enter 0xc, 0
4A93  6B 46 08 3E     imul ax, word ptr [bp + 8], 0x3e
4A97  C4 3E C2 D7     les di, ptr [0xd7c2]
4A9B  03 F8           add di, ax
4A9D  81 C7 C2 FF     add di, 0xffc2
4AA1  89 7E F8        mov word ptr [bp - 8], di
4AA4  8C 46 FA        mov word ptr [bp - 6], es
4AA7  C6 46 FD 00     mov byte ptr [bp - 3], 0
4AAB  EB 03           jmp 0x4ab0
loc_4AAD:
4AAD  FE 46 FD        inc byte ptr [bp - 3]
loc_4AB0:
4AB0  8A 46 FD        mov al, byte ptr [bp - 3]
4AB3  98              cwde
4AB4  D1 E0           shl ax, 1
4AB6  C4 7E F8        les di, ptr [bp - 8]
4AB9  03 F8           add di, ax
4ABB  26 83 7D 28 00  cmp word ptr es:[di + 0x28], 0
4AC0  74 50           je 0x4b12
4AC2  8A 46 FD        mov al, byte ptr [bp - 3]
4AC5  98              cwde
4AC6  D1 E0           shl ax, 1
4AC8  C4 7E F8        les di, ptr [bp - 8]
4ACB  03 F8           add di, ax
4ACD  26 8B 45 28     mov ax, word ptr es:[di + 0x28]
4AD1  C1 E0 02        shl ax, 2
4AD4  C4 3E C8 DC     les di, ptr [0xdcc8]
4AD8  03 F8           add di, ax
4ADA  89 7E F4        mov word ptr [bp - 0xc], di
4ADD  8C 46 F6        mov word ptr [bp - 0xa], es
4AE0  26 8A 45 02     mov al, byte ptr es:[di + 2]
4AE4  30 E4           xor ah, ah
4AE6  89 46 FE        mov word ptr [bp - 2], ax
4AE9  8B 46 06        mov ax, word ptr [bp + 6]
4AEC  01 46 FE        add word ptr [bp - 2], ax
4AEF  83 7E FE 01     cmp word ptr [bp - 2], 1
4AF3  7D 07           jge 0x4afc
4AF5  C7 46 FE 01 00  mov word ptr [bp - 2], 1
4AFA  EB 0C           jmp 0x4b08
loc_4AFC:
4AFC  81 7E FE B0 00  cmp word ptr [bp - 2], 0xb0
4B01  7E 05           jle 0x4b08
4B03  C7 46 FE B0 00  mov word ptr [bp - 2], 0xb0
loc_4B08:
4B08  8A 46 FE        mov al, byte ptr [bp - 2]
4B0B  C4 7E F4        les di, ptr [bp - 0xc]
4B0E  26 88 45 02     mov byte ptr es:[di + 2], al
loc_4B12:
4B12  80 7E FD 01     cmp byte ptr [bp - 3], 1
4B16  75 95           jne 0x4aad
4B18  C9              leave
4B19  CA 04 00        retf 4

; ---- routine 1B55:4B1C  (found by: call, far)
sub_4B1C:
4B1C  C8 04 00 00     enter 4, 0
4B20  6B 46 08 3E     imul ax, word ptr [bp + 8], 0x3e
4B24  C4 3E C2 D7     les di, ptr [0xd7c2]
4B28  03 F8           add di, ax
4B2A  81 C7 C2 FF     add di, 0xffc2
4B2E  8A 46 06        mov al, byte ptr [bp + 6]
4B31  26 00 45 35     add byte ptr es:[di + 0x35], al
4B35  8A 46 06        mov al, byte ptr [bp + 6]
4B38  26 00 45 34     add byte ptr es:[di + 0x34], al
4B3C  FF 76 08        push word ptr [bp + 8]
4B3F  FF 76 06        push word ptr [bp + 6]
4B42  0E              push cs
4B43  E8 49 FF        call 0x4a8f
4B46  C9              leave
4B47  CA 04 00        retf 4

; ---- routine 1B55:4B4A  (found by: call, far)
sub_4B4A:
4B4A  C8 0E 00 00     enter 0xe, 0
4B4E  8B 46 08        mov ax, word ptr [bp + 8]
4B51  C1 E0 03        shl ax, 3
4B54  C4 3E BA D7     les di, ptr [0xd7ba]
4B58  03 F8           add di, ax
4B5A  89 7E F6        mov word ptr [bp - 0xa], di
4B5D  8C 46 F8        mov word ptr [bp - 8], es
4B60  6B 46 08 0F     imul ax, word ptr [bp + 8], 0xf
4B64  C4 3E BE D7     les di, ptr [0xd7be]
4B68  03 F8           add di, ax
4B6A  89 7E F2        mov word ptr [bp - 0xe], di
4B6D  8C 46 F4        mov word ptr [bp - 0xc], es
4B70  FF 76 08        push word ptr [bp + 8]
4B73  0E              push cs
4B74  E8 12 04        call 0x4f89
4B77  08 C0           or al, al
4B79  74 08           je 0x4b83
4B7B  31 C0           xor ax, ax
4B7D  89 46 FE        mov word ptr [bp - 2], ax
4B80  E9 A3 00        jmp 0x4c26
loc_4B83:
4B83  C4 7E F2        les di, ptr [bp - 0xe]
4B86  26 8A 45 08     mov al, byte ptr es:[di + 8]
4B8A  98              cwde
4B8B  8B D0           mov dx, ax
4B8D  C4 7E F6        les di, ptr [bp - 0xa]
4B90  26 8A 45 04     mov al, byte ptr es:[di + 4]
4B94  30 E4           xor ah, ah
4B96  05 C2 FF        add ax, 0xffc2
4B99  03 C2           add ax, dx
4B9B  89 46 FC        mov word ptr [bp - 4], ax
4B9E  C4 7E F2        les di, ptr [bp - 0xe]
4BA1  26 80 7D 06 20  cmp byte ptr es:[di + 6], 0x20
4BA6  7D 0A           jge 0x4bb2
4BA8  26 8A 45 06     mov al, byte ptr es:[di + 6]
4BAC  98              cwde
4BAD  01 46 FC        add word ptr [bp - 4], ax
4BB0  EB 3E           jmp 0x4bf0
loc_4BB2:
4BB2  80 7E 06 00     cmp byte ptr [bp + 6], 0
4BB6  74 2A           je 0x4be2
4BB8  C4 7E F6        les di, ptr [bp - 0xa]
4BBB  26 80 7D 07 00  cmp byte ptr es:[di + 7], 0
4BC0  75 20           jne 0x4be2
4BC2  26 80 7D 07 00  cmp byte ptr es:[di + 7], 0
4BC7  B0 00           mov al, 0
4BC9  75 01           jne 0x4bcc
4BCB  40              inc ax
loc_4BCC:
4BCC  98              cwde
4BCD  8B F8           mov di, ax
4BCF  8A 85 86 12     mov al, byte ptr [di + 0x1286]
4BD3  30 E4           xor ah, ah
4BD5  8B C8           mov cx, ax
4BD7  8B 46 FC        mov ax, word ptr [bp - 4]
4BDA  99              cdq
4BDB  F7 F9           idiv cx
4BDD  29 46 FC        sub word ptr [bp - 4], ax
4BE0  EB 0E           jmp 0x4bf0
loc_4BE2:
4BE2  C4 7E F6        les di, ptr [bp - 0xa]
4BE5  26 80 7D 07 00  cmp byte ptr es:[di + 7], 0
4BEA  75 04           jne 0x4bf0
4BEC  83 46 FC 10     add word ptr [bp - 4], 0x10
loc_4BF0:
4BF0  83 7E FC 00     cmp word ptr [bp - 4], 0
4BF4  7D 07           jge 0x4bfd
4BF6  31 C0           xor ax, ax
4BF8  89 46 FC        mov word ptr [bp - 4], ax
4BFB  EB 0C           jmp 0x4c09
loc_4BFD:
4BFD  81 7E FC 00 01  cmp word ptr [bp - 4], 0x100
4C02  7E 05           jle 0x4c09
4C04  C7 46 FC 00 01  mov word ptr [bp - 4], 0x100
loc_4C09:
4C09  FF 76 08        push word ptr [bp + 8]
4C0C  0E              push cs
4C0D  E8 F5 02        call 0x4f05
4C10  08 C0           or al, al
4C12  74 0C           je 0x4c20
4C14  8B 46 FC        mov ax, word ptr [bp - 4]
4C17  99              cdq
4C18  B9 02 00        mov cx, 2
4C1B  F7 F9           idiv cx
4C1D  89 46 FC        mov word ptr [bp - 4], ax
loc_4C20:
4C20  8B 46 FC        mov ax, word ptr [bp - 4]
4C23  89 46 FE        mov word ptr [bp - 2], ax
loc_4C26:
4C26  8B 46 FE        mov ax, word ptr [bp - 2]
4C29  C9              leave
4C2A  CA 04 00        retf 4
; data (not reached as code), 29 bytes
4C2D                  pstr "Can't play"
4C38                  pstr 'too young to tell'

