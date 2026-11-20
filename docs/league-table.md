# The league table block (T103)

[confirmed:T103, runs/T103/table-r0001.json] The preparation machine stores the
English league table as **one 12-byte row per club**, indexed by the club's
number in `ENGL-95.DAT`:

```
row = base + (club - 1) * 12
P u8 | PTS u8 | HW u8 | AW u8 | HD u8 | AD u8 | HL u8 | AL u8 | F u16 | A u16
```

`base` is linear `0x18AEA` in this restored machine (decimal 101098). Clubs
without a league record are all zero, and every league club shares one played
count (27 at the preparation boundary), which is what locates the array. The
screen's column order differs from the storage order: the game keeps
`HW, AW, HD, AD, HL, AL` interleaved, while the table screen shows
`HW HD HL | AW AD AL`.

**The decode is proved by the round, not asserted.** Applying the eight results
the T102 capture displays to the decoded pre-round rows, with two points for a
win and one for a draw, reproduces **all 16 captured post-round rows exactly** -
played, points, both W-D-L triples, goals for and against. Two rows show the
shape:

| Club | Pre-round (decoded) | Post-round (captured) |
| --- | --- | --- |
| Newcastle Utd | P27, 43 pts, home 11-2-0, away 9-1-4, F65 A30 | P28, 45 pts, home 12-2-0, away 9-1-4, F67 A30 |
| Blackburn R | P27, 38 pts, home 8-3-3, away 9-1-3, F60 A33 | P28, 38 pts, home 8-3-3, away 9-1-4, F60 A35 |

[designed] The receipt records the 16 clubs in club-number order with both their
decoded and captured rows; it claims no ranking tie-break and does not infer the
storage order from the displayed position. `python3 runs/T103/table.py --check`
re-reads the private state, re-decodes and re-applies the round, and prints
`ready`.

[confirmed:T103 arithmetic] The captured table also fixes the points rule on its
own: Newcastle's 21 wins and 3 draws make 45, Blackburn's 17 wins and 4 draws
make 38, so a win is 2 points and a draw 1.
