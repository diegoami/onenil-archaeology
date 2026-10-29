; 1-095.EXE (One-Nil 95), code segment 26A8 (image offsets 26A80..26B8F), part 1 of 1
; packed 1-095.EXE sha256 f659fb2d334500d6901fc8d6a0f06c85c0ccda2eb4a3035ae3bb0a0004d79192 (LZEXE 0.91)
; unpacked (tools/static/unlzexe.py) sha256 8df646e017e0965a5d90a58181ca764219ad847833aad0b6cb58fc53372bfb2c
; tool: capstone 5.0.9 (pip package; core library 5.0.1280) (CS_ARCH_X86, CS_MODE_16), recursive descent from the entry point, far calls and near calls/jumps, then routine prologues (55 89 E5 / 55 8B EC / C8 iw 00) in what remains; tools/static/listing.py
; addresses are SEGMENT:OFFSET with SEGMENT the image paragraph before relocation; image offset = SEGMENT*16+OFFSET

; ---- routine 26A8:0000  (found by: far)
sub_0000:
0000  55              push bp
0001  8B EC           mov bp, sp
0003  83 EC 50        sub sp, 0x50
0006  1E              push ds
0007  C5 76 0C        lds si, ptr [bp + 0xc]
000A  8D 7E B0        lea di, [bp - 0x50]
000D  16              push ss
000E  07              pop es
000F  FC              cld
0010  AC              lodsb al, byte ptr [si]
0011  3C 4F           cmp al, 0x4f
0013  72 02           jb 0x17
0015  B0 4F           mov al, 0x4f
loc_0017:
0017  98              cwde
0018  91              xchg cx, ax
0019  F3 A4           rep movsb byte ptr es:[di], byte ptr [si]
001B  32 C0           xor al, al
001D  AA              stosb byte ptr es:[di], al
001E  C5 56 06        lds dx, ptr [bp + 6]
0021  B4 1A           mov ah, 0x1a
0023  CD 21           int 0x21   ; INT 21h AH=1A set DTA
0025  8D 56 B0        lea dx, [bp - 0x50]
0028  16              push ss
0029  1F              pop ds
002A  8B 4E 0A        mov cx, word ptr [bp + 0xa]
002D  B4 4E           mov ah, 0x4e
002F  CD 21           int 0x21   ; INT 21h AH=4E find first
0031  1F              pop ds
0032  C4 7E 06        les di, ptr [bp + 6]
0035  E8 20 00        call 0x58
0038  8B E5           mov sp, bp
003A  5D              pop bp
003B  CA 0A 00        retf 0xa

; ---- routine 26A8:003E  (found by: far)
sub_003E:
003E  55              push bp
003F  8B EC           mov bp, sp
0041  1E              push ds
0042  C5 56 06        lds dx, ptr [bp + 6]
0045  B4 1A           mov ah, 0x1a
0047  CD 21           int 0x21   ; INT 21h AH=1A set DTA
0049  1F              pop ds
004A  B4 4F           mov ah, 0x4f
004C  CD 21           int 0x21   ; INT 21h AH=4F find next
004E  C4 7E 06        les di, ptr [bp + 6]
0051  E8 04 00        call 0x58
0054  5D              pop bp
0055  CA 04 00        retf 4

; ---- routine 26A8:0058  (found by: call)
sub_0058:
0058  72 1E           jb 0x78
005A  83 C7 1E        add di, 0x1e
005D  1E              push ds
005E  06              push es
005F  1F              pop ds
0060  32 C0           xor al, al
0062  B9 00 01        mov cx, 0x100
0065  FC              cld
0066  F2 AE           repne scasb al, byte ptr es:[di]
0068  F6 D1           not cl
006A  8A C1           mov al, cl
006C  4F              dec di
006D  8B F7           mov si, di
006F  4E              dec si
0070  FD              std
0071  F3 A4           rep movsb byte ptr es:[di], byte ptr [si]
0073  AA              stosb byte ptr es:[di], al
0074  FC              cld
0075  1F              pop ds
0076  33 C0           xor ax, ax
loc_0078:
0078  A3 24 F9        mov word ptr [0xf924], ax
007B  C3              ret

; ---- routine 26A8:007C  (found by: far)
sub_007C:
007C  55              push bp
007D  8B EC           mov bp, sp
007F  8A 46 0A        mov al, byte ptr [bp + 0xa]
0082  B4 35           mov ah, 0x35
0084  CD 21           int 0x21   ; INT 21h AH=35 get interrupt vector
0086  8C C0           mov ax, es
0088  C4 7E 06        les di, ptr [bp + 6]
008B  FC              cld
008C  93              xchg bx, ax
008D  AB              stosw word ptr es:[di], ax
008E  93              xchg bx, ax
008F  AB              stosw word ptr es:[di], ax
0090  5D              pop bp
0091  CA 06 00        retf 6

; ---- routine 26A8:0094  (found by: far)
sub_0094:
0094  55              push bp
0095  8B EC           mov bp, sp
0097  1E              push ds
0098  C5 56 06        lds dx, ptr [bp + 6]
009B  8A 46 0A        mov al, byte ptr [bp + 0xa]
009E  B4 25           mov ah, 0x25
00A0  CD 21           int 0x21   ; INT 21h AH=25 set interrupt vector
00A2  1F              pop ds
00A3  5D              pop bp
00A4  CA 06 00        retf 6

; ---- routine 26A8:00A7  (found by: far)
sub_00A7:
00A7  5E              pop si
00A8  5A              pop dx
00A9  59              pop cx
00AA  5B              pop bx
00AB  B0 21           mov al, 0x21
00AD  50              push ax
00AE  53              push bx
00AF  51              push cx
00B0  52              push dx
00B1  56              push si

; ---- routine 26A8:00B2  (found by: far)
sub_00B2:
00B2  55              push bp
00B3  1E              push ds
00B4  8B EC           mov bp, sp
00B6  2E FF 36 E1 00  push word ptr cs:[0xe1]
00BB  8A 46 0C        mov al, byte ptr [bp + 0xc]
00BE  2E A2 E2 00     mov byte ptr cs:[0xe2], al
00C2  C5 76 08        lds si, ptr [bp + 8]
00C5  FC              cld
00C6  AD              lodsw ax, word ptr [si]
00C7  50              push ax
00C8  AD              lodsw ax, word ptr [si]
00C9  8B D8           mov bx, ax
00CB  AD              lodsw ax, word ptr [si]
00CC  8B C8           mov cx, ax
00CE  AD              lodsw ax, word ptr [si]
00CF  8B D0           mov dx, ax
00D1  AD              lodsw ax, word ptr [si]
00D2  8B E8           mov bp, ax
00D4  AD              lodsw ax, word ptr [si]
00D5  50              push ax
00D6  AD              lodsw ax, word ptr [si]
00D7  8B F8           mov di, ax
00D9  AD              lodsw ax, word ptr [si]
00DA  50              push ax
00DB  AD              lodsw ax, word ptr [si]
00DC  8E C0           mov es, ax
00DE  1F              pop ds
00DF  5E              pop si
00E0  58              pop ax
00E1  CD 00           int 0
00E3  9C              pushf
00E4  06              push es
00E5  57              push di
00E6  55              push bp
00E7  8B EC           mov bp, sp
00E9  C4 7E 12        les di, ptr [bp + 0x12]
00EC  FC              cld
00ED  AB              stosw word ptr es:[di], ax
00EE  8B C3           mov ax, bx
00F0  AB              stosw word ptr es:[di], ax
00F1  8B C1           mov ax, cx
00F3  AB              stosw word ptr es:[di], ax
00F4  8B C2           mov ax, dx
00F6  AB              stosw word ptr es:[di], ax
00F7  58              pop ax
00F8  AB              stosw word ptr es:[di], ax
00F9  8B C6           mov ax, si
00FB  AB              stosw word ptr es:[di], ax
00FC  58              pop ax
00FD  AB              stosw word ptr es:[di], ax
00FE  8C D8           mov ax, ds
0100  AB              stosw word ptr es:[di], ax
0101  58              pop ax
0102  AB              stosw word ptr es:[di], ax
0103  58              pop ax
0104  AB              stosw word ptr es:[di], ax
0105  2E 8F 06 E1 00  pop word ptr cs:[0xe1]
010A  1F              pop ds
010B  5D              pop bp
010C  CA 06 00        retf 6
; data (not reached as code), 1 bytes
010F                  db 00   ; .
