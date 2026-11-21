# F41 The league table's display order: points descending, then the signed 8-bit low byte of goal difference, then goals for

- **Status**: proposed
- **Task**: T110 (#235)
- **Edition**: 96.
- **Sources**: `static/1-0-exe` (unpacked 1-0.EXE, sha256
  887ed2a92767950e5309b2052409f875668605939b69e00737aa3047022b9f51);
  `runs/T110/order-r0001.json` (49 instructions anchored by their bytes);
  `runs/T105/seed-r0001.json`; `runs/T106/session-r0014/step-0048.json`
  (round-29 results screen) and `step-0049.json` (week-29 table screen);
  the independent check `runs/T110/order.py --check`.

[confirmed: static decode, runs/T110/order-r0001.json] The displayed table is
ordered, **per division of 16 clubs**, by two passes over one 176-byte club
index array at `DS:D7D5` (every access is `[di-0x282b]`, which is `di+0xD7D5`
in 16-bit wrap), reading rows from the table block through the far pointer at
`DS:D7C6` (F03's R29):

- `sub_4227` (01EF:4227) — a Hoare quicksort on the **points byte** (row+1,
  zero-extended, unsigned `cmp`), **descending**: the low side advances while
  `row.pts > pivot.pts` (`jbe`), the high side retreats while
  `row.pts < pivot.pts` (`jae`);
- `sub_4305` (01EF:4305) — a bubble pass over adjacent index slots whose swap
  needs **equal points** first (`cmp al, es:[di+1]`; `je`), then the **signed
  8-bit low byte of F−A strictly greater** (the full 16-bit difference is
  computed with `sub ax, dx` but only AL survives — `mov dl, al` — and the
  compare is `cmp al, dl; jl`), then, only when those low bytes are equal
  (`jne`), **goals for strictly greater as unsigned 16-bit** (`cmp ax,
  es:[di+8]`; `jbe`).

`sub_4450` (01EF:4450) orchestrates **five groups of 16** (base 1, 17, 33, 49,
65 — `add word ptr [bp-6], 0x10`, `cmp word ptr [bp-4], 5`), sorting each
group's index slice on [base, base+15], then writing positions 1..16 into each
club's 62-byte record at offset 0x36 of the `[DS:D7C2]` block. The re-sort runs
inside week processing (`sub_4D08`, called from 0006:1B52 per `calls.tsv`,
through `sub_4ACD` at 01EF:4AEC, after the season structure's week counter is
incremented). The table screen reads none of this arithmetic itself:
`sub_4743` picks the division (season-structure byte 4 through the `DS:DCB6`
map) and `sub_467A` renders the index entries **in array order**, one screen
row each through the formatter `sub_44D1` — the slice base is
(division−1)·16+1 (`shl ax, 4`).

[confirmed: static decode] **The goal difference is compared in 8 bits.** The
comparator computes F−A in 16 bits and truncates to AL (`8A D0`), so a
difference outside −128..+127 sorts as its low byte (for example +130 as
−126). The captured tables never exercise this: their GD range is −44..+37.

[confirmed: captures, runs/T105/seed-r0001.json] **Week 28.** The comparator
reproduces all 16 displayed positions from the decoded rows. Three points ties
decide the rule on data alone: Leeds (GD +15) above Liverpool (+9);
Wimbledon (+11) above Q.P.R (+3) above Chelsea (+1) — which **excludes
goals-for descending** (Q.P.R, F40, is displayed above Chelsea, F41) and
**excludes fewest goals against** (Wimbledon, A49, is displayed above both).

[confirmed: captures, runs/T106] **Week 29.** The eight round-29 rows the
committed results screen shows, applied to the week-28 rows under the 2/1/0
rule (F03/T103's arithmetic), reproduce all 16 rows of the committed week-29
table screen; the comparator then reproduces all 16 displayed positions. Three
further ties, all on goal difference: Leeds (+17) above Liverpool (+10),
Tottenham (+8) above Chelsea (+1), Coventry (−22) above Arsenal (−23) — the
last showing the rule on negative differences.

[derived: both sources] Goal average (F/A) is **not** excluded by the captures
(it orders every captured tie the same way); the static reading excludes it —
the comparator never divides, it subtracts and compares 8 bits.

[designed] Not claimed here: the semantics of the season-setup order
(`sub_0540` at 0006:0540, called by 0006:060F, quicksorts the same index
array by a `[DS:D7B6]` club byte — the initial order before the season's first
sort), the meaning of that byte, the division map's construction, promotion or
relegation, and any edition other than 96. Clubs equal in (PTS, GD8, F) keep
whatever arrangement the quicksort left: no captured pair ties that far, so
the confirmation above is exact, and any third-level behaviour beyond the
quicksort's outcome is not witnessed.

Independent check: `python3 runs/T110/order.py --check` re-reads all 49
anchored instructions from the committed listing, requires both weeks'
displayed positions, and prints `T110 league table display order: ready`.
F41 stays proposed until this check has run independently of the session that
wrote it.
