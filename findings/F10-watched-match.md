# F10 The watched match of week 1 runs in the harness as in DOSBox-X (1-4); it shares the quick result's first 258 draws, then takes another path: 158,992 draws, another result (quick 0-2)

- **Status**: proposed
- **Task**: T10 (#44)
- **Edition**: 96.
- **Sources**: run records `runs/T10/T10-r0002` (DOSBox-X, `runtime/driver/watched.py`) and
  `runs/T10/T10-r0003` (the harness, `runtime/emul/match.py` at `76d6ba4`, unicorn 2.1.4, the settings
  of F06); the trace `traces/T10/64af71e7e4d2e1dc-week-r0001.jsonl` (sha256 `3bcb5a29…`); the quick
  result's trace `traces/T06/cf7eb2d04211ba88-week-r0003.jsonl` (F06, F07).

## Answer

1. `[confirmed]` **DOSBox-X.** `T10-r0002` restored T05-r0001's end savestate (sha256 `64af71e7…`, the
   main menu of SAVE1, Watch match on) and played week 1 to the main menu, completed: the watched pitch
   ran with no key pressed, its half time and full time were answered as `weeks.py` would (Space,
   Return; `n` at the watched full-time screen, where Space opens the commentary viewer, the
   interrupted r0001). The result was BLACKBURN R 1, P ST GERMAIN 4.
2. `[confirmed]` **The harness.** `T10-r0003`, from the same savestate, met all 9 key-wait screens of
   `T10-r0002` in order, byte-identical (`match.py --compare`, its comparison log in the record), with
   the same result 1-4 (`end.result` of the trace) and 176,134 draws over the week. While the pitch ran
   the harness pressed no key; it stopped 263 times on a run-on (`run_on_stops`).
3. `[confirmed]` **Against the quick result.** Both traces start with LCG seed 59 and draw the same
   first 258 values from the same sites (`0AB9:1A01`'s 255, then `1B55:27B1`'s; the pre-match screen
   `4361807016fd` is met after draw 258 in both). Draw 258 differs: the quick match draws
   random(945) at `0AB9:D9BD` (`D983`, F07), the watched match random(2) through `24BC:0D4F` from
   `0AB9:7217`.
4. `[confirmed]` **The watched match's draws.** From entry to its return to `0AB9:EBE2`, the watched
   match draws 158,992 values (quick: 5,853), from 67 sites after draw 258, none of them `D983`'s six;
   through three entries of the RNG at `24BC:0CDC`'s segment: `24BC:0D12` (68,779), `24BC:0D4F`
   (59,532), `24BC:0D2D` (30,423). Its busiest sites are `0AB9:7380` (57,318), `0AB9:388A` (29,226),
   `0AB9:333A` (27,308), `0AB9:380B` (11,970), `0AB9:3927` (11,834).
5. `[derived]` **Not equal.** With Watch match on, week 1's managed match is decided by another
   engine (its draw sites all lie in segment `0AB9`, `1BF1`–`A4A5`), not by `D983`'s contests: its draws differ from
   draw 258 on, and so does its result (1-4 watched, 0-2 quick). The rest of the week (17,142 draws
   after the match, quick 17,153) starts from another seed and differs too. A rebuild that offers
   Watch match needs that engine; replaying a quick-result trace does not cover it.

## Open

- The watched engine's rules (out of T10's scope): what the 67 sites draw for, what the three RNG
  entries `0D12`, `0D2D` and `0D4F` compute, and how the pitch's timer pacing (`DS:D088`) enters them.
- Whether the watched result depends on the timer model at all (one harness run, one DOSBox-X run;
  both 1-4).
