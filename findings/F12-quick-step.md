# F12 DD02 redraws temporary counts but commits at most one goal per step; 558 full-step observations account for six quick matches

- **Status**: proposed
- **Task**: T12 (#69)
- **Edition**: 96, Watch match off.
- **Sources**: `static/1-0-exe/quick-step.md` (listing at `78bdebc`); recorder
  `runtime/emul/quick_step.py` at `b5911b6` and `a234c04`, with settings in each receipt;
  completed `runs/T12/T12-r0001.json`, `r0002`, `r0004`–`r0007` and corresponding immutable
  `traces/T12/*.jsonl`; `traces/T12/index.json` links record/fixture digests to all 15 T08 traces.
  `T12-r0003` is the retained aborted export attempt, not completed coverage.

## Answer

1. `[confirmed]` **The full step differs from its contests.** DD02 saves the cumulative score,
   clears `D086/D087`, produces both sides' ratings, and calls D983 for temporary generated
   counts. The nested minute-table loops can refill both sides' tables on each entered outer
   pass. A minute must exactly equal word `D0B2`, the saved score must be below 15, and the
   selected player must pass `4F89`. After one `5083` call, the local flag suppresses later goals
   and the outer index is forced to its last side. Thus at most one actual goal is recorded per
   DD02 call. The saved cumulative score, not the generated count pair, is restored at `DF35`–`DF40`.
   The addresses, signedness, frame offsets and explicit callee dependencies are in `quick-step.md`.
2. `[confirmed]` **558 observed steps.** The six completed runs contain 92 steps each in the four
   friendly weeks and 95 each in the two league weeks. Every newly run week's draw/mark/key-wait
   sequence equals its retained T08 trace, and its ordered DOSBox-X key-wait comparison passes.
   Every nested D983 observation equals its corresponding T11 record; both rating vectors are
   linked to those original inputs. Expected draws are literal T08 slices, not a Python step model.

   | T12 run | T04 week | Steps | DD02 draws | Goal callbacks |
   | --- | --- | ---: | ---: | ---: |
   | r0001 | r0012 | 92 | 5,595 | 2 |
   | r0002 | r0013 | 92 | 5,220 | 3 |
   | r0004 | r0014 | 92 | 5,297 | 4 |
   | r0005 | r0015 | 92 | 5,336 | 2 |
   | r0006 | r0016 | 95 | 5,724 | 2 |
   | r0007 | r0017 | 95 | 5,958 | 4 |
   | Total | six canonical states | 558 | 33,130 | 17 |

3. `[confirmed]` **Complete draw accounting needs an outside-step boundary.** The six managed
   matches contain 34,680 draws: 33,130 inside DD02 and 1,550 outside it. Weeks r0014 and r0016
   make an additional setup draw at `1B55:28C2`, `random(50)`, before their first step; their
   first DD02 starts at draw 259 rather than 258. The later recorder observes every RNG return
   outside an active step and verifies the exact partition against T08, including callers and
   values. The first two immutable receipts have exactly their established 258-draw bootstrap.
   The earlier fixed-prefix check aborted r0003 after a correctly executed week; r0004 repeats
   its 92 step observations unchanged and supplies the missing boundary observations. No earlier
   receipt or export was repaired. All 15 T08 references are linked through six canonical runs;
   full semantic state was measured in six states, not remeasured in the nine repeats.
4. `[confirmed]` **Goal decisions and score representation.** The observations contain 1,770
   minute-fill draws, 17 scorer draws and 17 goal callbacks; the other 541 steps record no goal.
   Each goal helper consumes its own RNG draw at `5190`, besides the step's other helper draws.
   `5C6E` maps a player to the first matching position in the club's 20 roster words. All sampled
   scorers were accepted on the first attempt and mapped back to the sampled slot; reject/retry
   and duplicate-player alternatives remain static/synthetic coverage. The final working pair
   `D086/D087` is side 0/1; storage `D0C4/D0C5` is reversed. The history helper writes one byte,
   packing side 0 in the low nibble and side 1 in the high nibble. The six final score pairs
   equal T08's board scores. `[derived]` In these specimens side 0 is the first listed team,
   and is not always the managed club (for example SEVILLA–BLACKBURN).
5. `[confirmed]` **Clock boundary and the longer league weeks.** In these 558 calls, DD02 leaves
   the remaining/elapsed fields `D0AE/D0B2` unchanged; its caller invokes `7B7B` afterward. The
   first boundary occurs after step index 45, when remaining time changes 46→45. With no added
   time in the four friendly weeks, the final boundary is index 91. Each league run records
   three added-time increments before termination, and its final boundary is index 94. In r0006
   all three occur at `6456` (indices 12, 15, 57); r0007 uses `6456`, `65ED`, `6456` (39, 56, 59).
   These are observed callee paths through the extra no-goal work, not a claim about a named
   football event. `[derived]` Together with `7B7B`'s decrement/zero-test order, these increments
   explain 95 rather than 92 steps for these runs. They do not establish a general one-step-per-
   minute rule or invariance under other clocks or inputs.
6. `[confirmed]` **The full step changes more state.** There are 12,276 post-step scene visits,
   with 2,406 observed decrements of signed player-record byte `+8`. Their selected fields and
   all save-block digests are retained at the step boundaries. Statistics, scorer logs, scene
   state and helper draw spans are observed separately; graphics, keyboard, substitution and
   contingent event helpers are not translated by this task. A nonzero unavailable predicate
   followed by `1998:093F` must not be labelled as creating an injury merely from that call.

## Replay boundary and limits

`[designed]` The next bounded Rust target can be goal placement (`DD7C..DF35`) with explicit
availability, first-roster-match and goal-helper contracts; the helper's RNG effects must be
included. Another prerequisite is native ratings production. These are original observations
for that work, not proof that all DD02 effects are a closed function of seed and score alone.

Only six consecutive weeks of one save and the recorded harness model are measured. Scorer
retries, duplicate roster mappings, score-cap/log-cap boundaries and other configurations need
additional coverage when implemented. Full-DD02 Rust parity, whole-match/week replay, whole-
machine or timer equality, watched-engine behavior and O-M3a completion remain pending.
