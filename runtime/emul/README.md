# runtime/emul/: One-Nil 96 as guest code, and its traces

`guest.py` runs `1-0.EXE` under Unicorn from a DOSBox-X 2024.03.01 savestate; `match.py` plays one
week from a main-menu savestate and writes its trace and a run record. What stands in for the
hardware, BIOS and DOS (keys through the game's IRQ 1 handler, a timer-chip clock with the BIOS tick
and the game's INT 1Ch handler, a stationary mouse, files in memory) is in `guest.py`'s docstring;
what it was checked against, in F06.

    python3 runtime/emul/match.py --state <sha256 prefix> [--compare runs/T04/<week record>.json]

The start state is found by sha256 under `.cache/states/` (from the owner's Drive:
`rclone copy onenildrive:states .cache/states`). The code under `runtime/emul/` must be committed.
Each run writes a new trace `traces/T06/<state sha256[:16]>-week-r<nnnn>.jsonl` and a run record
`runs/T06/T06-r<nnnn>.json` (the trace's sha256, the settings, the game files' sha256, the result, the
comparison); nothing is overwritten. The same state gives the same trace, byte for byte
(`T06-r0003`, `T06-r0004`: `-week-r0003`, `-r0004`, the current ones).

Superseded traces, kept as recorded: `-week-r0001`/`-r0002` (a new timer divisor waited for the old
deadline, #33; their draws, screens and state digests equal `-r0003`'s); and
`traces/T06/cf7eb2d04211ba88-week.jsonl`, the first trace (T06, before the O-M2 review). Its `callers` read every frame as far, so entries after the first can be
wrong (#23), and its clock was another model (a tick every 17,000 instructions, plus one per read of
0040:006C). Its draws (`n`, seeds, values) and screens are identical to `-week-r0001`'s.

The corpus (T08): `python3 runtime/emul/corpus.py` runs the week of every completed T04 week record
from its start state with `--compare` against it (`--experiment T08`: traces under `traces/T08/`,
records `runs/T08/T08-r<nnnn>.json`), skipping a week only when its latest receipt completed with
all required screens met in order (failed/stopped receipts remain immutable and are retryable), and writes `traces/T08/index.json`
(per week: the record, the start state, the trace and its sha256, the run, the verdict, the result,
the draws).

## Long runs and recovery

Run one foreground harness process per experiment/output directory. Events are flushed to a private
append-only journal under `.cache/emul-journals/` as they occur, rather than held in memory. At the
initial state and then every 300 wall-clock seconds, at the next guest stop after its action is
queued, the harness writes a new immutable decoded chunk under `<out>/partial/` and a `run/1` partial
receipt under `<runs>/partial/`. The receipt is explicitly aborted/partial, never completed corpus
coverage. A completed or interrupted attempt also writes its own final trace and receipt. An abrupt
process death retains the latest checkpoint and streamed tail; recovery starts at that checkpoint,
so only work since it is repeated. The interval is checked between `Guest.run` calls, each bounded
by the instruction budget, not in a running Unicorn callback.

The matching private `.cache/checkpoints/<experiment>/<run>-p<nnnn>.pkl.gz` contains memory, the full
Unicorn CPU context, timer deadlines, file handles and contents, queued/held keys, service audits,
pending RNG state and screen/run-on indices. It embeds game bytes and must never enter git or a
release. Its public receipt holds only its digest, private Drive destination, source/version/settings
fingerprint, progress counters and the immutable event-chunk manifest.

For a multi-hour run, use a task branch and publish each checkpoint:

```sh
python3 runtime/emul/match.py --state <sha> --experiment T10 --out traces/T10 --runs runs/T10 \
  --compare runs/T10/T10-r0002.json --publish-checkpoints
```

`--publish-checkpoints` copies each private checkpoint to `onenildrive:checkpoints/<experiment>/`
with rclone, commits only that new decoded chunk and receipt, then pushes the task branch. This
foreground command requires the configured remote and Git credentials; publication failure stops
the attempt with an aborted receipt. Without that option, the session must commit/push the partial
chunks and receipts and copy private checkpoints to Drive itself, at least every 30 minutes (rules
8/13). The live journal is never committed; a committed chunk is never appended to or replaced.

Resume using the latest successful partial receipt printed by the command, including after a
machine/session change (restore its private checkpoint from the Drive path named in the receipt):

```sh
rclone copy onenildrive:checkpoints/T10 .cache/checkpoints/T10
python3 runtime/emul/match.py --resume runs/T10/partial/<run>-p<nnnn>.json --publish-checkpoints
```

Resume verifies code, Unicorn/Python, clock/input settings and checkpoint/chunk digests, restores the
machine and the prefix, and writes a **new** run/trace without changing prior evidence. It retains the
original trace's `start` event and continues draw/screen numbering. Documentation/publication-only
commits may change HEAD; runtime source changes require a new run from the original state. Load only
trusted checkpoints made here and kept in the owner's private Drive (the private format is pickle).
`--stop-after-checkpoints N` and a shorter `--checkpoint-seconds` support controlled recovery checks;
they stop with an aborted receipt, and never mean a completed week.

## The trace

One JSON object per line, keys sorted, in the order things happened. Every line has `kind`.

| kind | fields | meaning |
| --- | --- | --- |
| `start` | `state_sha256`, `state_file`, `start_at`, `settings`, `lcg`, `tools` | the savestate, the image address the CPU was at, the guest's settings (instructions per second, the key hold, the DOS clock, ...), the generator traced, the code |
| `draw` | `i`, `n`, `seed_before`, `seed_after`, `value`, `callers` | one call of the generator `24BC:0CDC` (F02 item 4): `i` counts from 0; `n` its argument; `seed_before`/`seed_after` the 16-bit seed word (RandSeed, `DS:A51C`) before and after; `value` what it returned (1..n); `callers`: up to 4 return addresses, image addresses `SSSS:OOOO` of `static/1-0-exe/`: the first from the stack (in a wrapper, `24BC:0D01`/`0D1C`/`0D3F`), each next one from the BP frame of the routine holding the last, read near or far as that routine returns in the listing; `"?"` ends a chain where the listing cannot say (no BP frame, or several return forms) |
| `mark` | `what`, `draws` | a boundary, with the draws made before it: `match entry 0AB9:E1F2` and `match return to 0AB9:EBE2` (the managed club's match, F02 item 5) |
| `screen` | `i`, `digest`, `draws`, `action` | a key wait: the sha256 of the text page (80x25, chars and attributes interleaved, the 4000 bytes at B800:0000, as `runtime/driver/savestate.Screen.digest`), the draws so far, and the keys answered (`Down`, `Return`, `space`, `n`) or `... stop` |
| `run-on` | `n`, `digest`, `draws`, `caller` | (T10, Watch match on) the guest stopped at polls of keypressed from outside readkey's loop (`caller`, e.g. `1998:00F1`) while the watched pitch runs; no key is pressed and the run goes on. Not a key wait |
| `end` | see below | the run's outcome |

`end`: `status` (`completed`, `completed with unsupported services`, or why it stopped); `draws`;
`screens`; `instruction_budget` (the instructions the run allowed: an upper bound, a slice that ends
at a key wait counts whole); `timer_ticks` (IRQ 0 ticks) and `game_timer_ticks` (of them, those that
entered the game's INT 1Ch handler); `services` (the set of interrupt/function pairs the game
called: full AX for INT 33h, AH for other interrupts) and `unsupported` (those not served); `service_counts` (calls per interrupt and function),
`mouse_answers` (what the mouse reads answered, as counts: not in call order), `dos_calls` (every
INT 21h call in order: input AX, BX, CX, DX, DS, ES, a file name, the length and sha256 of written
bytes, and the AX, BX, CX, DX, ES and carry returned; traces before `-week-r0005` keep only AH, BX,
CX, DX in and AX, carry out); `files_written` (name, size, sha256 of each file the week created
or changed in the guest's folder); `state_digests` (the sha256 of the memory at each save block's
destination, F03 R24–R51, at the week's end); `result`: `teams` and `goals` (the full-time board's
score, read as text) and `board_digest` (that screen's digest, which only a renderer of the same text
page can reproduce).

While a watched pitch runs, `compact_services` keeps only the first `(interrupt, AX, image CS:IP)`
entry per reported interrupt/function in the guest's `services` list. Repeated calls' addresses and
per-call order are discarded; the final trace reports only the function set, with no call-site
addresses. `service_counts` still counts all calls, `dos_calls` retains every DOS call in order,
and `mouse_answers` retains an answer histogram, not a sequence. This compaction does not change
the guest's answers or the reported function set.

### What a trace is a test of

A trace is a **week**: the managed club's match (between the two `mark`s), the round's other
fixtures and the week's other work (everything after the match return; in `-week-r0003`, 17,153 of
23,006 draws). A model is checked against it as a whole week, from the same start state:

1. **The generator.** For every `draw` line, stepping `seed_before` with `n` gives `seed_after` and
   `value`:

       seed_after = (seed_before * 0x7ABD + 0x1B0F) & 0xFFFF
       value      = ((seed_after * n) >> 16) + 1

2. **The order of the requests.** From the start state, the model asks for the same `n`s in the same
   order, from the first `draw` line to the last, and the seed it holds before each is the line's
   `seed_before`. In `-week-r0003` the stream is unbroken (each `seed_before` is the last
   `seed_after`); in other weeks the game also writes the seed directly (F02 item 4: `0AB9:19CA`,
   `1B55:091D`, `1B55:5516`, `1B55:56E7`), so a break in the stream is the game's, not an error.
3. **The outcome.** The same `result` (`teams`, `goals`), and, for the state the week leaves, the same
   `state_digests` and `files_written`.

The first `draw` where a model asks for another `n`, or holds another seed, is where its reading
departs from the original; `callers` says which routine of the listing asked. Passing these checks
validates the model on this specimen, not every rule: two models can make the same requests and the
same score from different state updates, which `state_digests` partly guards.

`screen` digests are comparable with a DOSBox-X week record's screen digests (`--compare`: the
record's screens must occur in the trace's key waits in the record's order, and the record must
start from the same state; the run's status is `aborted: comparison failed` otherwise).
