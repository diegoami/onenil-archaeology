# The match's ratings (T09, F09)

The four values `0AB9:D983` contests (F07) are words `DS:D674 + 4k + 2*side`, k = 0..3, side = 0, 1.
`0AB9:DD02` sets them before each `D983` with `1B55:50EB` for both sides. Read in the listing
(`code/seg_1B55_*.asm`) at the addresses given, and checked against the values the original computed
in six weeks (`runs/T09`, `tools/static/ratings.py --check`).

## A side's four values: 1B55:50EB(club, side, flag)

Arguments in push order: the club at `[bp+0Ah]` (50EF), the side at `[bp+8]`, the flag byte at
`[bp+6]` (522A). The club's record is `[DS:D7C2] + (club − 1) * 0x3E` (62 bytes, F03).

1. The side's four words are zeroed.
2. bonus = `1B55:4A37(club)` (below).
3. For each of the club's 11 first-team words (record words 0..10): if the player p ≠ 0, v =
   `1B55:4B4A(p)` (below), and v + bonus when v ≠ 0; the player's position byte (+6 of his 8-byte
   record `[DS:D7BA] + 8p`) indexes the class table `DS:12BE` = 0, 1, 1, 4, 4, 2, 2, 2, 2, 5, 5, 5, 3, 3
   (codes 0..13). Class c < 4 adds v to value c; class 4 or 5 adds v >> 1 to values c − 3 and c − 2
   (codes 3, 4 between 1 and 2; codes 9..11 between 2 and 3).
4. If the flag is set (522A), each value w gains w / `DS:12CC`[club byte +0x37 = 0] (unsigned: 16, or
   64 when that byte is 0).

By `D983`'s contests (F07): value 2 meets value 2; value 3 meets the opponent's 1, then its 0. With the
classes: value 0 is the goalkeeper's (code 0), 1 the defence's (codes 1, 2, half of 3, 4), 2 the
midfield's (codes 5..8, halves of 3, 4, 9..11), 3 the attack's (codes 12, 13, half of 9..11).

## A player's value: 1B55:4B4A(player, mode)

The player at `[bp+8]` (4B4E), the mode byte at `[bp+6]` (4BB2). r8 = `[DS:D7BA] + 8p`, r15 =
`[DS:D7BE] + 15p`.

- 0 if `1B55:4F89(p)` returns non-zero (4B74–4B80): by the decompile, when r15 +8 ≤ 0 or one of the
  bits 8, 6, 2, 3 of the set byte r15 +0Bh is set (not read further in the listing).
- v = r8 +4 (unsigned) − 62 + r15 +8 (signed) (4B83–4B9B).
- if r15 +6 (signed) < 32: v += r15 +6 (4BA1–4BAD);
  else if mode ≠ 0 and r8 +7 = 0: v −= v / 16 (`DS:1286`[r8 +7 = 0], signed idiv, 4BB2–4BDD);
  else if r8 +7 = 0: v += 16 (4BE2–4BEC).
- v is clamped to 0..256 (4BF0–4C04), and halved if `1B55:4F05(p)` returns non-zero (4F05: by the
  decompile, from r8 +6, r8 +7 and `1B55:4E81`; not read further).

## A club's bonus: 1B55:4A37(club)

(byte +2 of `[DS:DCC8]` record a) >> 5, + 16, + (byte +2 of record b) >> 4, as a byte, where a and b
are the club record's words +0x28 and +0x2A (4A37–4A8C): two of the 1001 four-byte records the save
holds (F03, `[DS:DCC8]`; their names are the league file's `names_1001`, by count, not read).

## What the six weeks exercised

`runs/T09` (T09-r0001..r0006, the weeks of F08): 12,614 player values, 2,495 bonuses, 1,128 sides and
558 `D983` entries, all reproduced. Exercised: r15 +6 < 32 (12,410), neither branch (165), the −v/16
branch (1), a rejected player (38), split positions (3,871), the flag with the divisor 16 (side 0 in
every week). Not exercised: the +16 branch, the clamps, the halving (4F05), the divisor 64.
