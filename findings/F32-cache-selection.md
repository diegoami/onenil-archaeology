# F32 Compact original selector and rating cases have small logical read sets

- **Status**: proposed
- **Task**: T32 (#111)
- **Edition**: 96.
- **Sources**: original T31-r0001 at `96f7ff4`, producer `98180e5`, merged
  through `ac2fb46`; projector/static contract `19b4710`; compact exports `fd595c8`.
- **Check**: `python3 tools/static/cache_selection.py --check`; no private bytes.

`[derived: complete static graph at ac2fb46, 0AB9:13B8–1452,1B55:4EBF–4F02/
4F89–5008,24BC:0259–0274]` A defined13B8 selection needs only its selected club's
first eleven roster words and canonical referenced-player ID,P8+1/+3/+5 and
P15+8/+11. Availability delegates to4F89 and its one-based bit tests; rating
delegates to4EBF. There is no extra game-global read beyond the normalized
side/club roster selection. A standalone4EBF call needs exactly three raw P8
bytes:1,3,5. Both routines are read-only in logical game state and use no RNG.

`[confirmed: same listings]`4EBF's signed IDIV result is the remainder via XCHG,
not the quotient. P8+1<21 selects a logical right shift of the16-bit word.13B8
sign-extends its stored current score but zero-extends the candidate score for
comparison; it cannot be translated as a naive unsigned maximum. With no eligible
player the original selected-player local is uninitialized, outside the defined
logical contract. No arbitrary stack value or synthetic zero is substituted.

`[confirmed: compact projection at fd595c8 of T31 at 96f7ff4]` Both original
selectors are side1,club134 and return2661. Roster slot6 is2666 in the first
invocation and2672 in the second; the other ten roster positions match. Every
referenced candidate has a positive raw P15+8 and flags11=0. The selected player's
same raw witness establishes a nonempty eligible input domain for these cases
without a Python availability evaluator. All selected candidates' P8+1 values
are at least21. No original nested availability/rating-call census is inferred.

`[confirmed: same projection]` The44 original final4EBF observations are:

| Player | P8+1 | P8+3 | P8+5 | Original return | Calls |
| ---: | ---: | ---: | ---: | ---: | ---: |
| 2590 | 21 | 217 | 14 | 3 | 22 |
| 2661 | 27 | 174 | 15 | 7 | 22 |

These are original word returns copied from the direct helper boundaries, not
calculated outputs. The44 calls occur in1539's final scene loop; they are not
the unobserved internal4EBF calls inside13B8. Both compact streams preserve the
original week, step, replacement, event order and zero-draw intervals, plus side/
club/roster or side/slot/scene/player metadata as appropriate.

`[confirmed: same retained boundaries]` Every projected selector/rating named
entry state equals its return state. Source record/fixture digests, the complete
T31/upstream manifest and static listing hashes bind the compact exports. The
checker reconstructs exact JSON rows and bytes; negative tests reject altered
inputs/returns/order, missing fields, unrelated source writes and bad provenance.

`[designed: T32]` Export creation preserves identical existing files, can finish
an identical partial export, and refuses changed existing files. No original
code is rerun, no private artifact is created and no earlier evidence is rewritten.
Python implements projection/schema/provenance checks only, not selection,
availability, remainder arithmetic or scene effects.

`[designed]` These two selectors and44 ratings cover one week and two enclosing
replacements. Blocked/zero/no-eligible inputs, negative remainders, below21 logical
shifts, high-bit score comparisons, arbitrary side/winner diversity, other weeks
and independent nested helper observations remain untested by this extraction.
Native synthetic/static checks or targeted original probes must cover broader
domains.1455/1AE2/9F6E closures, full AI/DD02/match/week parity and independent
acceptance remain separate; F32 is proposed.
