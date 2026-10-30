# F17 DBC6's quick-step decision and external event boundary are recorded

- **Status**: proposed
- **Task**: T17 (#80)
- **Edition**: 96.
- **Sources**: listings at `99c4dc1`, `static/1-0-exe/extra-event.md`; observer
  `runtime/emul/extra_event.py` at `e26e7b4`; six completed original runs and exports
  at `a455882` (`runs/T17/T17-r0001.json`…`r0006.json`, `traces/T17/index.json`).
  T16 and T08 source records and fixture digests are named in each exported case.
- **Check**: `python3 runtime/emul/extra_event.py --check`. The check uses only committed
  decoded observations; original files and savestates are unnecessary for public verification.

## Answer

1. `[confirmed]` All six new original weeks match every retained T08 event and ordered
   DOSBox-X wait and reproduce the complete T16 prefix/clock observations. The corpus
   links every DBC6 request among all 558 T16 steps to the corresponding call, including
   the four weeks with zero requests, and checks all 15 T08 references. There are
   **184 DBC6 calls, 499 decision draws, 909 direct helper calls and 22 external 69B8
   dispatches**. Those dispatched calls consume another **17 draws** before DBC6 returns.
2. `[confirmed]` Inputs contain every physical scene's word0, slot, player ID, rating
   bonus and halving flag; canonical referenced player definitions; raw opponent/side
   selectors, club byte57, bonus flags and the input seed and actor pair. Player records
   include both the availability fields and all fields of the scene-rating, predicate and
   threshold helpers. Named raw lookup cells cover both modes6/14 of 9F6E. The direct
   helper observations retain their actual caller, arguments, return and draw boundary.
   Expected helper returns are observations, never engine inputs supplied by this producer.
3. `[confirmed]` DBC6 draws its initial candidate, checks both candidates' availability,
   draws a boolean side, compares mode6/14 scene ratings unsigned, and uses predicate4
   or a contingent random chance. Two final threshold draws compare signed, selected
   strictly greater than opposite. A successful decision writes the selected scene slot
   to D0A0 and opposite to D09F before calling 69B8. The static contract specifies each
   wrapper and comparison width without assigning an unsupported game-level event name.
4. `[confirmed]` The captured helpers are **368 availability, 362 scene ratings,
   87 predicates and 92 thresholds**. Three calls reject the second availability check;
   94 exit after the rating pair, 41 after a false contingent chance, and 46 reach both
   threshold draws. Predicate4 is true 45 times and false 42 times. The 22 actual dispatches
   are snapshots before the handler; their return snapshots are separate observations.
5. `[confirmed]` 69B8 consumes one draw in 17 dispatches and zero in 5. In the named
   snapshot fields it changes player records in 6 dispatches and scene records in 1.
   These are observed external effects, not a native implementation of the handler or
   a complete record of its writes. Both new full weeks still agree with their retained
   events and screens because the original handler itself ran during capture.
6. `[derived]` DBC6 and its dispatched handler account for 516 of the 528 draws in F16's
   prefix-to-clock gap. Twelve draws remain outside DBC6; accounting for the draws alone
   does not implement the remaining callee writes or establish whole-step replay.

## Stack-dependent helper and limits

`[confirmed]` The listing of 1AE2 has a branch where signed player15 byte6>=32 and a
selected side flag is zero: it adds32 into the existing BP-4 local before initializing
it in that invocation. Each captured rating helper therefore records its preexisting
stack word. The two observed calls with byte6=33 have both side flags set to1 and take
the explicit-zero branch. The uninitialized-local branch is **static-only evidence** here.
The independent native task must not turn a decompiler's uninitialized local into zero,
or feed expected helper results back as input to conceal the dependency.

`[confirmed]` No call rejects the first availability check in this corpus; three reject
the second. All other combinations absent from the captures need explicit static/synthetic
coverage in a native translation. The original rating helpers are RNG-free; the named
decision state changes only seed and, on dispatch, the actor pair. The separate event
handler can mutate named state and has more effects outside this snapshot.

`[designed]` T17 is the research contract. Native T06 should translate DBC6's decision
and helpers from raw inputs, with a first actual original-case test failing before its
body exists, then preserve the actual computed seed/actor handoff. It must distinguish
an emitted external 69B8 request from executing its handler. Continuous scratch/stack,
69B8's complete logical effects, remaining substitution/reset/keyboard callees, full DD02,
whole-match/week, watched-engine, timer/render and whole-memory parity remain pending.
F17 remains proposed until an independent evidence check accepts it.
