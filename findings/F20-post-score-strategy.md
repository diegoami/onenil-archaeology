# F20 Post-score strategy accounts for the remaining late-gap draws

- **Status**: proposed
- **Task**: T20 (#86)
- **Edition**: 96.
- **Sources**: listings at `6804fbb`, `static/1-0-exe/post-score.md`; producer
  `post_score.py` at `c3bea1c`; six completed runs/exports at `7b71f81`.
- **Check**: `python3 runtime/emul/post_score.py --check`; public decoded records suffice.

`[confirmed]` Six new original weeks reproduce the full T16 observations, T08 events
and ordered DOSBox-X waits. They capture 17 A4F2 calls, 12 LCG draws, 32 strategy setters,
566 ordered player-flag normalizers and 34 club getters. All 558 step ledgers contain
1317 ordered late calls and link to all 15 T08 references. Earlier run/trace files remain
unchanged. Each strategy case contains a literal retained prefix case and raw roster,
score/seed, baseline-table, club, player and local-flag inputs.

`[confirmed]` The late-call census contains 184 DBC6, 541 6B2F, 17 045C, 17 52B6 and 558
78B7 calls. Of the 528 draws between prefix exit and clock entry, 516 occur in DBC6's
closure and 12 in A4F2 under52B6. The measured 6B2F/045C/78B7 spans contain no draw.
That is not a claim that those callees make no logical writes.

`[confirmed]` A4F2 ignores its argument, narrows its signed score difference to a byte,
then selects baseline/three-bit/five-bit paths using the magnitude and independent unsigned
score-byte comparisons. The actual cases reach baseline and three-bit paths. Their 12
draws are exactly the A34D sites A38C/A3A4, checked literally against retained T08 draws.
The setter0C23 normalizes all nonzero roster IDs through53FB, including repeated IDs
in order; there is no availability filter. Zero ID remains a possible keeper lookup input
for265B even though the setter skips zero roster entries.

`[confirmed]` Getter traces independently establish A23C's **opposite first, own second**
club selection. The wrapping signed difference (own minus opposite) is compared against
the zero-extended limit byte. An initial static reading incorrectly treated these as the
same club; the original trace rejected that reading before implementation passed. The
static contract and native task definition were corrected. Both raw club inputs were
already captured, so no measurement was rewritten or inferred from expected answers.

`[designed]` Native T08 covers this strategy/flags closure and guarded shared prefix
seed/score/club/roster fields on the nonkeeper quick goal-reset path. Full 52B6 scene,
6B2F substitution and78B7 keyboard effects remain separate untranslated dependencies.
Keeper reset preludes diagnose. Five-bit/latched and positive-limit-adjustment paths have
static/synthetic coverage, without claiming new original cases. Accounting for all late
draws does not establish continuous DD02/match/week/setup, physical/scratch/timer/render
parity. F20 remains proposed pending independent checking and acceptance.
