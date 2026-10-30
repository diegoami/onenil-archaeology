# F11 D983's original inputs and outputs replay as a routine: 558 calls, 30,798 draws, linked to all 15 T08 traces

- **Status**: proposed
- **Task**: T11 (#67)
- **Edition**: 96; Watch match off.
- **Sources**: `static/1-0-exe/quick-contests.md` (listing at `7859d7d`); recorder
  `runtime/emul/contests.py` at `cd05153`, Unicorn 2.1.4 and that commit's guest/clock settings;
  `runs/T11/T11-r0001.json`–`r0006.json`; immutable fixtures `traces/T11/T11-r0001.jsonl`–`r0006.jsonl`;
  derived `traces/T11/index.json` (record/fixture/T08 trace digests and producer commits).

## Answer

1. `[confirmed]` **The static routine contract.** `0AB9:D983` takes an unsigned word k at entry
   SP+2 (near call), runs k chances with side 0 then side 1, and advances through three contests
   only on signed-16-bit strict wins (ties lose). It reads the four interleaved two-side ratings
   at `DS:D674`–`D683`. A side winning all three increments its existing goal byte at `DS:D086+s`,
   wrapping modulo 256; it does not clear the bytes. The RNG uses the seed through `[DS:DE84]`,
   initialized to `DS:A51C`, with unsigned multiplication and a wrapping seed step. Zero k makes
   no draws; random(0) still steps the seed and returns 1. Addresses and the six draw sites are in
   `quick-contests.md`, including the distinction between the exit hook at `DA3D` before LEAVE
   and an actual CPU return.
2. `[confirmed]` **Measured semantic inputs/outputs.** The six completed T11 runs restore the
   canonical T08 states for T04 weeks r0012–r0017. Each new week's draw/mark/key-wait event sequence
   equals its retained T08 trace's, and its ordered DOSBox-X key-wait comparison passes. There are
   92 calls in each of r0001–r0004 and 95 in each of r0005/r0006: 558 total. Entry/exit hooks record
   k, seed, eight ratings, goal bytes and exact draw bounds. The seed target is `2864:A51C` in
   every call, read through the actual pointer; ratings remain unchanged.
3. `[confirmed]` **Trace linkage and fixtures.** Each exported case contains the recorded inputs
   and outputs plus the literal expected draw slice from its retained T08 trace: site, n, seed
   before/after and returned value. All 30,798 managed D983 draws belong to exactly one case span;
   no span overlaps or omits a managed D983 draw. `contests.py --check` verifies case contents,
   digests, start-state identities and seed boundaries without implementing D983 in Python.
   The index maps all 15 T08 traces to these six routine runs; each repeat's corresponding spans
   agree. Semantic outputs were measured in six states, not remeasured in the nine repeated states.
4. `[confirmed]` **Observed range.** Every measured k is 8, every input goal pair is [0, 0], seed
   inputs range 32–65,328 and rating words 152–1,011. Output goal bytes range 0–6 (routine-local
   counts, not final match scores). Thus the corpus
   does not dynamically exercise zero/other chance counts, pre-existing or wrapping goal bytes,
   or draws crossing the signed boundary. Those contract branches are static claims, not coverage
   supplied by these six runs.
5. `[derived]` **A bounded Rust replay target.** These records let onenil compare each request,
   returned value, final seed and goal bytes against original execution, identifying the first
   mismatch. The first consumer is [onenil T01](https://github.com/diegoami/onenil/issues/2).
   This is routine-level evidence. It excludes timer/BIOS effects, scratch registers and stack
   locals, full-machine memory equality, the match clock/minute-fill loop and whole-match/week
   or watched-engine parity.

## Open

- Extend original-routine coverage to other k values and the signed/overflow/goal-accumulation
  boundaries when needed; synthetic Rust tests are distinguished from original-run evidence.
- Read and record the remaining quick-match loop, goal-minute placement and other draw sites.
  D983 replay alone does not establish O-M3a completion.
