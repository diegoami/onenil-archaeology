# One-Nil 96 user manual — original-game research

[designed: owner, 2026-11-05] This manual documents the original game's UI and
workflows before the management rebuild. It is being built from actual play;
it does not describe a proposed replacement UI.

See the [roadmap and backlog](../roadmap.md) and
[manual milestone](https://github.com/diegoami/onenil-archaeology/issues/135).

## Reading conventions

- **Observed** means an original-game run and rendered screenshot support the claim.
- **Derived** conclusions cite the observations they follow from.
- **Unvisited** screens/branches remain unknown, even when menu text suggests their purpose.
- Screen IDs `S001` onward identify screens; workflow IDs `W001` onward identify procedures.
  A materially different screen state gets its own screenshot and explicit variant.
- Each procedure records entry conditions, exact keys, visible feedback, exits and limits.
  Confirmations, refusals, invalid inputs and cancellation are separate coverage items.

## Chapters and coverage

| Chapter | Evidence requirement | Backlog |
| --- | --- | --- |
| [Startup and main menu](startup.md) | Observed supplied-save route: S001/S002, W001; other main-menu actions unvisited | #136 |
| [New-game setup](setup.md) | Observed S003–S009/W002–W004: England 1994/95, one manager, club browsing, name/nationality, Escape/default/blank-name branches; all four starting-season setup routes and two managers observed; see branch matrix | #137 |
| [Saving and loading](saves.md) | Observed F7, F10/N, two-save selector, Escape and fresh-process MANUAL reload with matching visible state; error and post-match persistence branches pending | #137 |
| [Squad browsing and player details](squad.md) | Observed skills/details, three players, empty reserves, options/cancel, Space/Ins shortcuts; lineup/individual changes are in selection.md; conditional availability remains pending | #138 |
| [Lineup and individual instructions](selection.md) | Observed swap/cancel, current-position cycle, Club position restore, goalkeeper instruction cycle and changed-state reload; team tactics/conditional validation pending | #138 |
| [Match preparation](match-preparation.md) | Observed opponent/configuration, eight team instruction cycles, formation change/restoration, statistics, pitch kickoff and insufficient-player refusal; watched/quick completion pending | #139 |
| [Watched match](watched-match.md) | Observed display/speed/history, bench, request cancellation, halftime/replacement, fulltime/statistics and next-week management return; quick/conditional branches pending | #139 |
| Transfers and contracts | Offers, negotiation, acceptance/refusal and expiry | #140 |
| [Finances, staff and stadium](administration.md) | Observed accounts, staff refusal/hire/cancel/sack cancellation, weekly posting and stadium order/abort; deferred completion pending | #141 |
| Competitions and season | Weekly progression, cups/tables, conditional events and rollover | #142 |

Until a chapter cites its captures, its workflows are unvisited in this manual.
Engine traces and older text-only observations provide research context; they
are not substitutes for the requested illustrated walkthrough.

## Setup screen catalog

[confirmed] See [setup](setup.md) for capture links and exact key sequences.

| ID | Screen | Observed route and limits |
| --- | --- | --- |
| S003 | New-game filename | N from startup; default Save1; Escape and Enter advance |
| S004 | Starting season | Four visible choices; England 1994/95 exercised; Escape leaves selector |
| S005 | Number of players | ONE and TWO accepted; duplicate-club refusal captured |
| S006 | Club browser | England 1994/95; division and team navigation; Escape exits |
| S007 | Manager name | Default K Dalglish; clearing field and accepting blank exercised |
| S008 | Nationality | England, Italy and Spain accepted; 32 choices inventoried |
| S009 | New-game main menu | Blackburn R/1994–95; blank manager variant; persistence documented separately in saves.md |

[confirmed] [Saving and loading](saves.md) adds W005 save/quit-cancel and W006
fresh-process reload. S010 is the main menu after F7, S011 the quit confirmation,
and S012 the saved-game selector. S003-named/S009-named/S009-reloaded are scenario
variants; their evidence and the copied-save intervention are described in that
chapter. These do not establish every internal field's persistence.

[confirmed] [Setup coverage matrix](setup-coverage.md) reconciles W002–W009
and the remaining setup/load branches. S014 is the duplicate-club refusal.
The new-game menu has NEXT PLAYER/Previous player variants for two managers.

## Squad and information screen catalog

[confirmed] See [squad browsing](squad.md), W010–W013, for screenshots and routes.

| ID | Screen | Exercised controls/limits |
| --- | --- | --- |
| S015 | Player skills | Up/Down player, Insert details, Right reserves, Left first team |
| S016 | Player details | T Flowers, I Pearce, B Mimms; empty reserves variant |
| S017 | Selected player options | Space opens; Escape cancels; mutations pending |
| S018 | Main-menu Space shortcut arrival | Same details panel/remembered selection as S016 |
| S019 | Main-menu club information | First Insert; displayed fields inventoried |
| S020 | Main-menu staff information | Second Insert; displayed staff/fields inventoried |
| S021 | Return to original main panel | Third Insert; same formation/tactics panel as S002 |

[confirmed] [Selection changes](selection.md) adds W014–W017. S022 is the active
PUT HERE state; S023 labels Reposition result variants, S024 Club position result
variants (both on the existing details/options view); S025 is the individual
instruction editor. The saved/reloaded lineup and instruction are checked in
its captures; team-level tactics and match admission remain separate work.

## Match preparation screen catalog

[confirmed] [Match preparation](match-preparation.md) documents W018–W023.

| ID | Screen | Observed limits |
| --- | --- | --- |
| S026 | Opponent club browser | Initial opponent/fields; entry and exit tested |
| S027 | Game configuration | Watch match and Auto player select toggles exercised |
| S028 | Match preparation | Valid/incomplete, formation3-4-3/4-4-2, refusal-return variants |
| S029 | Team instruction editor | Eight rows and their two displayed values exercised |
| S030 | Match statistics before kickoff | Zero counters; any-key return |
| S031 | Watched pitch at kickoff | Actual original pitch and named opening commentary; controls advertised |
| S032 | Transfer browser, exploratory arrival | Wrong-route capture retained in T47-r0002; no admission claim |
| S033 | Incomplete pre-match variant | Same S028 view with ten visible starters; no refusal yet |
| S034 | Insufficient-player refusal | PLAY GAME blocked; Space dismisses back to preparation |

[confirmed] [Watched match](watched-match.md), W024–W030, adds S035 live/completed
bench, S036 substitution-request state, S037 commentary history, S038 halftime
statistics, S039 replacement target selection and S040 fulltime pitch. S041 and
S042 are route variants returning to the existing fulltime/statistics views.
S043 is cash flow, S044 transfer news, and S045 the next-week main-menu arrival
(same S002 screen type). These IDs distinguish captured workflow states; the
chapter's captions define the actual view rather than exploratory label text.
