# F13 Complete inputs for 558 goal placements and 12,276 original availability checks

- **Status**: proposed
- **Task**: T13 (#71)
- **Edition**: 96, quick result.
- **Sources**: `static/1-0-exe/goal-placement.md` (listing at `77841e9`); recorder
  `runtime/emul/placement.py` at `1cc76cf`, Unicorn/settings in each run; completed
  `runs/T13/T13-r0001.json`–`r0006.json`; `traces/T13/T13-r*.jsonl`, `availability.jsonl`
  and the derived digest/provenance manifest `traces/T13/index.json`; T11/F11 and T12/F12.

## Answer

1. `[confirmed]` **Complete recorded inputs.** Read-only hooks at DD7C/DF35 record the placement
   entry and semantic exit in each of the six canonical T08 weeks. Each of all 558 entries,
   including 541 no-goal cases, has both 20-word club rosters, the distinct referenced players'
   signed byte +8/status byte +11, the actual scorer table, seed, generated counts, saved scores,
   elapsed word, minute bound, side offsets and incoming actor. There are 36 or 37 distinct player
   IDs per entry, including the reserved zero ID where present. No default roster or player state
   is fabricated from the expected outcome. All newly executed weeks' events and ordered DOSBox-X
   comparisons match retained T08, and the placement/contest boundaries and outputs match T12/T11.
2. `[confirmed]` **Literal replay cases.** The exports contain 558 cases across six measured
   states, linked to all 15 T08 traces. Each case includes 1) original complete inputs; 2) observed
   residual generated counts, cumulative locals, actor, flag and goal event; 3) every literal
   placement draw; and 4) observed minute/scorer/mapping and goal-call contracts. The total is
   1,804 draws: 1,770 minute requests, 17 scorer requests and 17 goal-helper coin requests.

   | Run | Cases | Placement draws | Goal calls |
   | --- | ---: | ---: | ---: |
   | r0001 | 92 | 434 | 2 |
   | r0002 | 92 | 232 | 3 |
   | r0003 | 92 | 217 | 4 |
   | r0004 | 92 | 295 | 2 |
   | r0005 | 95 | 353 | 2 |
   | r0006 | 95 | 273 | 4 |
   | Total | 558 | 1,804 | 17 |

3. `[confirmed]` **Small helper semantics.** The listing's `1B55:4F89` rejects player zero,
   signed player byte +8 below 1, or any status bits selected by mask `0xA6`. Those are one-based
   bits 8/6/2/3 (`24BC:0259`). `1B55:5C6E` returns the first matching roster position 1–20 or
   zero; it does not itself reject player zero. The `0AB9:1CA1` scene wrapper forwards the same
   player ID/predicate unchanged. The literal T12 scene checks therefore supply 12,276 original
   helper observations: 12,238 available and 38 unavailable. These expected predicate values are
   copied as observations, not recomputed by a Python helper model.
4. `[confirmed]` **Bounded native coin projection.** `5083` makes one unconditional `random(2)`
   through `24BC:0D3F` at `518B`, return site `5190`. Its direct-call closure has no additional
   RNG path or indirect call, and no write changes the caller's generated counts, cumulative
   locals or actor under the valid disjoint game-data layout. All 17 observed goal calls have
   one such draw and preserve those core fields. The recorder separately reads the actual
   returned coin at `5190`: 1 when the underlying RNG value is 1, otherwise 0. A rebuild can
   compute this request and coin natively while keeping the remaining statistics/log/display
   effects explicit. A raw RNG value of 2 must not be treated as a true boolean.
5. `[derived]` **Native placement boundary.** Complete inputs permit onenil T02 to generate
   minute fills, scorer retries, eligibility/first-roster results, the chosen actor and coin
   without taking expected requests, seeds or goal decisions as control inputs. The emitted
   goal-effect request is a dependency boundary, not evidence that its remaining effects have
   been implemented. The consumer is [onenil T02](https://github.com/diegoami/onenil/issues/4).

## Limits

These are six consecutive weeks of one save; semantic inputs/outputs were measured in six
canonical states and literal draw spans linked to the nine repeat traces. Original scorer
retries, duplicate-ID selection and score/log/large-count boundaries remain unexercised. The
safe translated minute-buffer domain is generated counts at most 11; larger counts can alias
the original stack frame. Native diagnostics for unsupported inputs are not original-game
behavior claims. No Python placement model, original bytes or prior-record edits are introduced.
Full `5083` effects, native ratings/clock/player updates, full DD02, whole-match/week and timing
parity, watched-engine behavior and O-M3a completion remain pending.
