# runtime/emul/: One-Nil 96 as guest code, and its traces

`guest.py` runs `1-0.EXE` under Unicorn from a DOSBox-X 2024.03.01 savestate; `match.py` plays one
week from a main-menu savestate and writes its trace. What stands in for the hardware, BIOS and DOS
(keys through the game's IRQ 1 handler, the match's timer through its INT 1Ch handler, the mouse,
files in memory) is in `guest.py`'s docstring; why each is as it is, in F06.

    python3 runtime/emul/match.py --state <sha256 prefix> --out traces/T06 [--compare runs/T04/<week record>.json]

The start state is found by sha256 under `.cache/states/` (pull them from the owner's Drive:
`rclone copy onenildrive:states .cache/states`). Same state, same trace, byte for byte.

## The trace

`traces/T06/<state sha256[:16]>-week.jsonl`: one JSON object per line, keys sorted, in the order
things happened. Every line has `kind`.

| kind | fields | meaning |
| --- | --- | --- |
| `start` | `state_sha256`, `state_file`, `start_at`, `dos_clock`, `lcg`, `tools` | the start: the savestate, the image address the CPU was at, the date and time DOS answers (fixed), the generator traced |
| `draw` | `i`, `n`, `seed_before`, `seed_after`, `value`, `callers` | one call of the generator `24BC:0CDC` (F02 item 4): `i` counts from 0; `n` is its argument; `seed_before`/`seed_after` the 16-bit seed word (RandSeed, `DS:A51C`) before and after; `value` what it returned (1..n); `callers` the return addresses up the BP chain, image addresses `SSSS:OOOO` of `static/1-0-exe/` (the first is in the wrapper `24BC:0D01`/`0D1C`/`0D3F`, the next ones are the game code that asked) |
| `screen` | `i`, `digest`, `draws`, `action` | a key wait: the sha256 of the text page (80x25, chars and attributes interleaved, the 4000 bytes at B800:0000, as `runtime/driver/savestate.Screen.digest`), the draws made so far, and the keys answered (`Down`, `Return`, `space`, `n`) or `... stop` |
| `end` | `status`, `draws`, `screens`, `steps`, `timer_ticks`, `result`, `services` | `completed` or why it stopped; instructions run; INT 1Ch ticks delivered; `result` = `{"teams": [home, away], "goals": [h, a], "board_digest"}` from the full-time board; the BIOS/DOS services the game called |

### Replaying it (onenil)

A model of the generator is right when, for every `draw` line, stepping `seed_before` with `n` gives
`seed_after` and `value`:

    seed_after = (seed_before * 0x7ABD + 0x1B0F) & 0xFFFF
    value      = ((seed_after * n) >> 16) + 1

and a model of the match is right when, from the same game state and the first draw's
`seed_before`, it asks for the same `n`s in the same order (the `draw` lines) and ends with the same
`result`. The first draw where a model asks for another `n`, or gets another `value`, is where its
reading departs from the original. `callers` says which routine of the listing asked.

`screen` digests are comparable with a DOSBox-X run record's screen digests (`--compare`): the
same digest is the same screen, character for character and colour for colour.
