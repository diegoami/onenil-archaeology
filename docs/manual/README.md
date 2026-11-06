# One-Nil 96 user manual — original-game research

[designed: owner, 2026-11-05] This manual documents the original game's UI and
workflows before the management rebuild. It is being built from actual play;
it does not describe a proposed replacement UI.

See the [current coverage audit](coverage-audit.md), [all83 native workflow gaps](native-gaps.md),
[owner review prompt](review-prompt.md), [roadmap and backlog](../roadmap.md) and
[manual milestone](https://github.com/diegoami/onenil-archaeology/issues/135).

The [executable UI blueprint](executable-ui.md) recovers template geometry and
menu/configuration handlers directly from the executable, checked against
original captures. Use it alongside the illustrated workflows below.
The [squad and preparation blueprint](executable-squad.md) adds component
composition, fixed spans, dynamic destinations and input/move/play boundaries.

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
| [Startup and main menu](startup.md) | Observed supplied-save route W001; menu actions reconciled across later chapters in coverage-audit.md; Previous player remains unvisited | #136 |
| [New-game setup](setup.md) | Observed W002–W004/W007–W009: four starting-season routes, one/two managers, names/nationalities and duplicate refusal; invalid-input/load-error branches remain G01/G02 | #137 |
| [Saving and loading](saves.md) | Observed F7, quit N, multiple-save selector/Escape and fresh-process reload; W017/W057/W083 extend to changed lineup, weeks and next season; errors/F10-Y remain G01 | #137 |
| [Squad browsing and player details](squad.md) | Observed W010–W013 skills/details/reserves/options and shortcuts; W054/W067 add availability/injury states; remaining variants G04/G05 | #138 |
| [Lineup and individual instructions](selection.md) | Observed W014–W017 move/cancel, positions/instructions and changed-state reload; W020 adds team instruction cycles, W023/W061 admission refusal; remaining G04/G05 | #138 |
| [Match preparation](match-preparation.md) | Observed W018–W023 opponent/configuration, team instructions, formation, statistics, kickoff and missing-player refusal; W061 adds unavailable-player refusal; other options G03/G05 | #139 |
| [Watched match](watched-match.md) | Observed W024–W030 named actions/history, display/speed, bench/cancel, halftime/replacement, final statistics and next-week return; further managed variants G05/G10 | #139 |
| [Quick results and fixture browsing](quick-results.md) | Observed W031–W035 Watch-off/R, browsing and next week; later chapters add league/cup progression, extra time and rollover; penalties/viewer watch/print remain G10/G11/G14 | #139/#142 |
| [Transfers and scouting](transfers.md) | Observed W036–W039 bid cancel/refusal/purchase, listing and scout search; W053/W073 add actual sales/tribunal payment; negotiation/empty-results cases G06 | #140 |
| [Contracts and youth trials](contracts.md) | Observed W040–W042 edit/cancel/refusal, dismissal and trial; W052/W068/W069/W076 add expiry/listing/renewal and W081 retirement despite renewal; trial lifecycle/other refusals G06/G07 | #140 |
| [Finances, staff and stadium](administration.md) | Observed W047–W050 accounts, staff refusal/hire/cancel/sack N, weekly posting and stadium order/abort; actual staff dismissal, stadium completion and isolated admin reload remain G07–G09 | #141 |
| [Statistics, histories and other teams](history.md) | Observed W043–W046 unavailable views, history and other-club browsing; W056 adds populated statistics, W082 seasonal summary; deeper history/categories remain G12/G13 | #142 |
| [League start and weekly events](league-start.md) | Observed W051–W057 league4, expiry/sale/availability, cup injury and progressed-save reload; later traversal reaches next season; rule/variant gaps G05–G13 | #142 |
| [Autumn progression and cup ties](autumn.md) | Observed W058–W064 league10, completed European tie, extra time, eligibility refusal, warnings and deferred/refused job offer; later lifecycle in W065–W083; job acceptance G08 | #142 |
| [Midseason progression](midseason.md) | Observed W065–W072 league16, elimination/groups, listed expiry, retiring-player renewal, neutral semi-final and announcements; later continuation W073–W083 | #142 |
| [Later-season progression](later-season.md) | Observed W073–W078 league24, tribunal payment, friendlies, neutral cup win/celebration, listed expiry and actual admission; final results/rollover W079–W083 | #142 |
| [Season finish and rollover](season-rollover.md) | Observed W079–W083 final results, season-information Y, promotion/relegation summaries, retirement, populated history, new fixtures/reset table and exact1995/96 reload; failed prefixes/deeper-history gap G13 retained | #142 |

[designed] The audit is the current cross-chapter coverage statement. Early
chapters describe their own original slice; a later cited procedure can close a
previously pending observation without rewriting that slice’s measured records.
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

[confirmed] [Quick results](quick-results.md), W031–W035, covers S046 quick-result
halftime/fulltime variants, league tables/results empty state, cup pairing views,
weekly fixtures and team fixture lists. Capture IDs after S046 include exploratory
intent labels; captions and actual rendered screens define each view.
