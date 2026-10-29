# F07 The managed match's 5,853 draws come from 13 sites; 5,158 of them are D983's three contests a chance, in which three won contests make a goal

- **Status**: proposed
- **Task**: T07 (#39)
- **Edition**: 96.
- **Sources**: `static/1-0-exe/drawsites.tsv` (`tools/static/drawsites.py` on
  `traces/T06/cf7eb2d04211ba88-week-r0003.jsonl`, F06), `static/1-0-exe/match-structure.md`, the
  listing `static/1-0-exe/code/` and decompile `static/1-0-exe/decompiled/` (F02).

## Answer

1. `[confirmed]` In week 1 of SAVE1 (a friendly, Watch match off), the managed club's match
   (`0AB9:E1F2`'s call, draws 0–5,852) draws from 13 sites in 9 routines: `0AB9:19CA` (255),
   `0AB9:86E9` (1), `1B55:2735` (2), `0AB9:D983` (5,158), `0AB9:DD02` (432), `0AB9:5083` (2),
   `0AB9:A34D` (3) (`drawsites.tsv`; every draw of the match is in exactly one row).
2. `[confirmed]` `0AB9:D983(k)` (`D983`–`DA3D`): for each of k chances and each side s, contest 1
   draws random(`DS:D67C`[1−s]) then random(`DS:D67C`[s]); if s's draw is higher (`cmp ax,dx; jle`,
   a tie is lost), contest 2 draws random(`DS:D678`[1−s]) and random(`DS:D680`[s]); if won, contest 3
   draws random(`DS:D674`[1−s]) and random(`DS:D680`[s]); if won, the byte `DS:D086 + s` gains 1.
   In the trace its 6 sites drew 1,472, 1,472, 739, 739, 368 and 368 times.
3. `[confirmed]` `D983`'s k is the byte `DS:0CFE[DS:D0AC = 15]` (8 or 11); its only caller in the
   match is `0AB9:DD02`, reached `E1F2` → `E008` → `7D86` → `7C3F` → `DD02` (calls.tsv). `[derived]` In
   the trace `D983` ran 92 times (1,472 / (8 chances x 2 sides)).
4. `[confirmed]` `DD02`'s own draws: random(`DS:0D00`[`DS:D0AC` = 15]) (90 or 120) per goal, stored per
   goal (`DDE4`–`DDEF`); random(30) indexing the slot table `DS:0CDF` (slots 2–11, weighted towards
   9–11), redrawn until `1B55:4F89` accepts (`DE55`–`DE6A`). `[derived]` the goal's minute and its
   scorer's squad slot.
5. `[derived]` The match's result (Watch match off) is decided by `D983`: goals come only from three
   contests won in a row. Which of the four arrays is goalkeeper, defence, midfield and attack is
   not read; by the pre-match screen's four ratings, contest 1 would be midfield against midfield,
   2 attack against defence, 3 attack against the goalkeeper.

## Open

- Where `DS:D674`–`D680` are set (`1B55:50EB` is called before each `D983`), and from which player
  and club fields; what `0AB9:7C3F`'s loop counts (92 steps); the uses of the table `19CA` fills,
  of the coin flips at `8750` and `5190`, of `A34D`'s set and of `1B55:2735`'s draw.
- The watched match (Watch match on): another path, not traced yet.
