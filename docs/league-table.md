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

[designed] The receipt records the 16 clubs in the captured table's displayed
order (its club ids follow the screen's positions — 122, 130, 104, …), each row
carrying its explicit club id; it claims no ranking tie-break and does not infer
the storage order from the displayed position. [review #253: an earlier wording
claimed club-number order, which the committed receipt does not follow] `python3 runs/T103/table.py --check`
re-reads the private state, re-decodes and re-applies the round, and prints
`ready`.

## The display order (T110)

[confirmed:T110, findings/F41-league-order.md, runs/T110/order-r0001.json] The
order the screens show is a **per-division sort descending by (points, goal
difference, goals for)** — with the goal difference compared as the **signed
8-bit low byte of F−A** and goals for as unsigned 16-bit. One quicksort on the
points byte (01EF:4227) is followed by a bubble pass that orders equal-points
neighbours (01EF:4305); five groups of 16 clubs are sorted independently
(01EF:4450), positions 1..16 land in each club record at offset 0x36 of the
`[DS:D7C2]` block, and the table screen (01EF:4743 -> 467A -> 44D1) renders the
index array at `DS:D7D5` in array order. The re-sort runs inside week
processing, and the screen reads no arithmetic of its own.

[confirmed:T110, runs/T105/seed-r0001.json, runs/T106] The captured tables
decide the rule on their own at six points ties across weeks 28 and 29, all on
goal difference — goals-for descending is excluded (Q.P.R F40 displayed above
Chelsea F41 at 31 points) and fewest-goals-against is excluded (Wimbledon A49
displayed above both). Goal average is excluded only by the static reading.
`python3 runs/T110/order.py --check` re-derives the comparator from the
committed listing (49 anchored instructions) and requires both weeks' 16
displayed positions; it prints `T110 league table display order: ready`.

[confirmed:T103 arithmetic] The captured table also fixes the points rule on its
own: Newcastle's 21 wins and 3 draws make 45, Blackburn's 17 wins and 4 draws
make 38, so a win is 2 points and a draw 1.
