# F09 The match's four ratings per side are sums of the eleven players' values by position class, plus a staff bonus and a ÷16 bonus for side 0; the formula reproduces all 16,795 values the original computed in six weeks

- **Status**: proposed
- **Task**: T09 (#43)
- **Edition**: 96.
- **Sources**: `static/1-0-exe/ratings.md` (the formula, with listing addresses); run records
  `runs/T09/T09-r0001`…`r0006` (`tools/static/ratings.py --run`, from the start states of
  `T04-week-r0012`…`r0017`, the six distinct weeks of F08); `tools/static/ratings.py --check runs/T09`.

## Answer

1. `[confirmed]` `0AB9:D983`'s four values per side (F07) are set by `1B55:50EB(club, side, flag)` as
   stated in `ratings.md`: each of the club's 11 first-team players' value `1B55:4B4A`, plus the
   club's bonus `1B55:4A37` when non-zero, goes to value 0..3 by the class table `DS:12BE` of his
   position byte (r8 +6), in halves to two adjacent values for codes 3, 4 and 9..11; a set flag adds
   w / `DS:12CC`[club byte +0x37 = 0] (16 or 64) to each value w.
2. `[confirmed]` `1B55:4B4A`: 0 for a player `1B55:4F89` rejects; else r8 +4 − 62 + r15 +8, then
   + r15 +6 when that signed byte is below 32, else −v/16 (mode set, r8 +7 = 0) or +16 (r8 +7 = 0),
   clamped to 0..256, halved when `1B55:4F05` says so. `1B55:4A37`: 16 plus two staff records' byte
   +2, shifted right 5 and 4.
3. `[confirmed]` In the six weeks' managed matches the formula reproduces every value the original
   computed: 12,614 player values, 2,495 bonuses, 1,128 sides' four values, and the eight values at
   each of 558 `D983` entries (`--check`: 16,795 values, 0 differ).
4. `[derived]` With F07's contests and the classes: value 0 is the goalkeeper's, 1 the defence's, 2 the
   midfield's, 3 the attack's; a chance is midfield against midfield, then attack against defence,
   then attack against the goalkeeper.
5. `[confirmed]` In all six weeks the flag is set for side 0 (the club `DS:D6E6`, by `DD02`'s calls) and
   never for side 1, and the club byte +0x37 is never 0 (divisor 16). The league matches of weeks 5
   and 6 run 95 steps of `DD02`, the friendlies 92.

## Not exercised by the six weeks

The +16 branch, the clamps, the halving of `4F05` and the divisor 64 (`ratings.md`): the formula there
is the listing's, not checked against a computed value. What `4F89` and `4F05` test is read in the
decompile only; their results were recorded, not recomputed.

## Open

- Which club is side 0 (home, or the managed club), and what the flag `DS:0D29` is.
- What the staff records and the player fields r8 +4, r15 +6, r15 +8 are, in the game's terms.
