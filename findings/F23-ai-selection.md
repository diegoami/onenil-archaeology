# F23 Quick AI reserve selection precedes 25 opaque replacements

- **Status**: proposed
- **Task**: T23 (#92)
- **Edition**: 96.
- **Sources**: static listings at `b54a8d4`; corrected static contract
  `static/1-0-exe/ai-selection.md` at `180474c`; original observer at `a317cfb`;
  six completed runs/exports and manifest at `0be8664`.
- **Check**: `python3 runtime/emul/ai_selection.py --check` uses public decoded
  observations only. Earlier T22/T20/T16/T08 provenance is checked transitively.

`[confirmed: six T23 runs at 0be8664]` Every one of T22's **556 A94B boundaries**
is retained, with identical projected entry/return states, arguments and draw spans.
The new weeks reproduce full T22 calls, T20 strategy/late-call observations, T16
tails, T08 events and ordered DOSBox-X waits. All A94B and nested intervals consume
**zero draws**. No previous run or trace was changed.

`[confirmed: same runs]` The nested census is **494 A8A0 candidate scans, 494
reserve-limit results, 4,362 availability calls, 494 preferred selections, 14
handedness results and 25 AEB8 replacements**. No 500B weighted fallback or A837
fallback is reached. The other 62 A94B entries return without these helpers. All
25 preferred nonzero results reach replacement, and exactly these 25 boundaries
change T22's named projection. Helper results and replacement entry/return states
are measured original values, not a Python or native computation.

`[confirmed: same runs]` The first four weeks contain 480 A94B calls with allowance
zero and 480 reserve-limit results of 20. The last two contain 76 calls with
allowance one and fourteen reached reserve-limit results of 14. Handedness returns
seven zeros and seven ones. Every candidate scan includes its actual reserve
availability calls, including zero-player entries. Candidate scratch differs
between A94B entry and return in 28 cases; scratch writes are not equivalent to
the 25 changes of T22's narrower projection.

`[confirmed: listings at b54a8d4, 26C9:0BFE–0C41 and 0C6F–0C7E]` The string
helper is Pascal substring search: construct a one-character string from P8+6,
search D9A, and use its one-based index (or zero). D9A is a sequence of position
characters, not a decimal number. 9882's comparison with three refers to this
search index. The export's historical field name `style_text` contains the
literal decoded character sequence; it does not contain a parsed numeric value.

`[confirmed: same listings, 0AB9:A8A0–ABB3 and 1B55:500B–50E8]` A8A0's
same-style candidate writes retain the last eligible reserve in scan order. 9882
retains the last matching preference. 500B's strict weight improvement retains
the first equal-weight candidate. The prefix copies P8+6 to the incoming player
and swaps roster, event-total and cache-selector cells before AEB8 is called.
The captured AEB8 input therefore already includes these prefix writes.

`[designed: T23 definition at 5030a1d]` The complete named selection context adds
position/style and indexed handedness cells for canonical players, the indexed
reserve-limit byte, decoded D9A sequence, preference/weight rows, candidate cells
and two cache-selector rows. The checker checks schema, observed helper footprints,
chosen-slot links, source hashes and boundary continuity; it does not implement
selection or replacement rules. Current table selectors fit fourteen-position/
style tables and reached reserve limits do not exceed the twenty-slot rosters.

`[designed]` AEB8 and A837 remain opaque. Their internal scene, player, cache,
log/UI and managed-helper inputs must be captured before a native implementation
can claim the complete AI contract. The next bounded task is the **reached AEB8
replacement closure**, preserving every T23 prefix and boundary. Unreached A837/
500B, managed prompt/editor work, 78B7 keyboard, continuous DD02/match/week/setup,
and arbitrary physical/render/timer/scratch parity remain separate work. No native
task or benchmark was produced here. F23 remains proposed pending independent
checking and acceptance.
