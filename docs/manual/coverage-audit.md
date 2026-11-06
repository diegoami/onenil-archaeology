# Original manual: coverage and remaining branches

[confirmed: T62 catalog] The [inventory](../../runs/T62/catalog-r0001.json),
produced from research `67dd355b4d4e5b646422fc1fdd922064bf6868d7`, covers
W001–W083 without gaps or duplicates. It links338 distinct illustrated screens
to their decoded records and screenshot digests. The27 referenced sessions
include24 completed sessions authenticated by their original capture validators
and3 aborted T61 attempts, retained explicitly as incomplete evidence. No failed
attempt is relabelled completed. Native comparison is pinned separately in
[the workflow gap matrix](native-gaps.md).

[designed] This is a bounded UI/workflow manual, with one observed season and
separate setup/administration scenarios. Observed means the named route and its
captured result, not every possible input, all competition rules or engine
formulas. Early chapters' remaining-work paragraphs describe their own slice;
the reconciliation below records later observations without rewriting captures.
Unvisited branches stay open for targeted scenarios or owner review findings.

## Screen and transition identity

[confirmed] A screen's stable evidence key is its complete record path plus
its screenshot: for example,T61/session-r0004/step-0024.json and its PNG. Short
S identifiers are scoped to their run; navigation-intent suffixes do not prove
which item was actually selected. The decoded text, highlight and rendered image
decide that. The catalog maps every numbered workflow to those complete keys.
T41's older record.json format is checked by its own committed capture validator;
later per-step sessions use manual_session.py. Producer/release identity and
completed-session authentication are retained rather than normalizing records.

[derived] Together, the illustrated workflow, exact recorded keys, before/after
screens and scoped screen key provide a reproducible transition reference.
Adjacent keypresses sometimes land at an unintended item; those observations
are retained, and the instructions explicitly inspect the highlight before
activation. All338 linked PNG hashes were checked; original binary/font/palette
bytes are not product assets.

## All executable main-menu slots

[confirmed] Slot numbers and dispatch boundaries come from the
[T57 executable blueprint](executable-ui.md), with component/input details in
[T58](executable-squad.md). The table separates an exercised transition from
a visible label. Enter activates a highlighted item; Escape and conditional
outcomes follow the cited procedure, not a blanket cancel convention.

| Slot | Action | Illustrated transition evidence | Current boundary / remaining case |
| --- | --- | --- | --- |
| 1 | PLAY NEXT GAME / NEXT PLAYER | W007 two-manager handover; W019/W024/W030/W031 preparation and next week; W051–W083 season progression | Single-manager play and first-to-second manager handover observed. Full two-manager match/week progression remains G02. |
| 2 | Previous player | W007 shows the conditional second-manager label; static dispatch decrements manager | Visible/static only; actual activation is unvisited,G02. |
| 3 | Players | W010–W017 browse/details/move/cancel/instructions/save; W054/W067/W071 availability and substitutions | Observed. Full squads, further role limits and untested option variants remain G04/G05. |
| 4 | Next opponents | W018 opens opponent information/configuration and returns | Observed when a fixture exists. Blank/no-fixture or unmanaged-club boundary is static, not an exercised refusal,G03. |
| 5 | Transfer market | W036/W037 browse, bid cancel/refusal, accepted purchase and changed squad | Observed limited purchase route; negotiation extremes and financial/full-squad cases remain G06. |
| 6 | Use scout | W039 criteria, successful search, results and cancel | Observed. Empty results, combinations and all criteria bounds remain G06. |
| 7 | New staff | W049 role lists, refusals, hire N/Y and changed scout; W050 weekly posting | Observed for one role; actual sack Y and other roles remain G08. |
| 8 | League tables | W033 empty-season/division browsing; W051/W056 populated league; W079 final; W082 reset | Observed before/during/after season. Tie-break and other promotion scenarios remain G11. |
| 9 | League results | W033 initial empty results; W051 league progression; W079 completed match30 in completed recovery | Observed. All league/year navigation combinations are not exhausted,G11. |
| 10 | Cup results | W034 initial pairings; W055/W059/W066/W070/W075/W080 played rounds, legs, elimination, neutral finals and win | Observed. Managed tied aggregate/penalties and other seeding rules remain G10. |
| 11 | Weekly fixtures | W034 scrolling/exit; W035 related team schedule | Observed browsing. Activating a chosen other club's fixture from this viewer remains G10; automatic observer finals are a separate route. |
| 12 | Fixture list | W035 paging/club/division/exit; W074 arranged friendlies; W082 next-year schedule | Observed. Enter-watch from this viewer and printing remain G10/G14. |
| 13 | Statistics | W043 unavailable message; W056 populated statistics after league4 | Both empty/populated variants observed. Every category, sort boundary and print path remains G12/G14. |
| 14 | Player/team history | W044 transfer/team history, W079 Slater departure context; T61/session-r0002 step76 records three actual sales | Observed. Long-history paging and all historic categories remain G12. |
| 15 | Seasonal history | W045 early unavailable message; W082 populated1994/95 summary | Summary observed. Full seasonal info capture failed; .95 reload and prompt N remain G13. |
| 16 | Other teams | W046 club/division/panels/squad and exit | Observed. Every club and unmanaged/empty edge is not exhausted,G12. |
| 17 | Game configuration | W018 displayed five options; W031 Watch off; static five stored bytes plus Continue | Only Watch toggle/Continue effects exercised. Other toggles/default combinations/downstream effects remain G03. |
| 18 | Cashflow | W047/W050 initial and posted weekly accounts; W053 sale; W069 renewal; W073 tribunal payment; W075/W081 prizes | Observed named periods. General financial rules, board/overdraft outcomes and other postings remain G07. |

## Shortcuts and modal boundaries

[confirmed] W011 exercises main-menu Space→Players and remembered panel;
W012 cycles Insert through club/staff/tactics. W005/W006 exercise F7, F10/N,
multiple saves, selector Escape and a fresh-process named save reload. W017,
W057 and W083 extend visible persistence to changed instructions/lineup,
progressed weeks and the next season. F10/Y remains unvisited; harness process
termination is not that UI branch. Save-error/overwrite branches remain G01.

[confirmed] Cancellation is screen-specific. Escape from the filename prompt
advances, from the starting-season selector remains, and from the club browser
exits the process (setup matrix). A zero-game contract's Escape can leave a listed
squad member (W068/W076), rather than immediately dismissing him. Actual
tribunal departure/payment occurs later (W073). The proposed native interaction
must preserve these distinctions or explicitly seek an owner design decision.

[confirmed] Stadium quote abort and order acceptance are separate captures;
the ordered-stadium save is not the campaign followed through T61. Staff hire
N/Y, sack N, player dismissal first/cost confirmations and actual player removal
are separate procedures. An announcement acknowledged with Escape is not
proof of cancellation: the announced friendlies later occur (W074).

## Conditional and error branch checklist

[designed] Each gap is a bounded research scenario to freeze if selected, not
an implied engine behavior. B identifiers in the native matrix are implementation
dependencies. These G identifiers retain original observation work; they are not
closed by a native implementation or by this documentation audit.

| Gap | Observed variants / exact workflow references | Unvisited or unverified | Next bounded research action |
| --- | --- | --- | --- |
| G01 Saves and input errors | W001–W009 startup/setup, four starting-season routes, blank manager, duplicate club, filename editing, save selector Escape; W017/W057/W083 persistence | Invalid/empty filename, malformed/unreadable/no-save errors, new-game collision semantics, F10/Y | Isolate a scratch folder; capture no-save/invalid-save UI and F10/Y with preserved originals. Treat overwrite as a distinct scenario. |
| G02 Two managers | W007 two clubs, duplicate refusal, name/nationality prompts and NEXT PLAYER | Previous player activation; full alternating match/week/persistence | Restore two-manager setup, activate Previous player, then one handover/save/reload; no full extra season needed. |
| G03 Configuration and absent fixture | W018 five visible options and Continue; W031 Watch off; W080 blank-opponent observer week | Four other option toggles/effects; no-fixture Next opponents boundary | Toggle one option per isolated save, record value/persistence and the immediate affected transition. Do not infer Auto save from its label. |
| G04 Squad/instructions | W010–W023 panels, move cancel/swap, current/club position, individual and eight team instruction cycles; W054/W067 availability | Every role/position overflow, full reserve/squad boundary, all player overrides | Capture one role-cap refusal and one per-player override interaction with pre/post state. |
| G05 Managed match changes | W025 cancel, W028 legal halftime replacement; W055/W060/W067/W071 injury/recovery and cancel/actual substitution; W079 repeated opportunities | All substitution limits/invalid requests, different competition allowances, managed red-card permutations | Restore before one invalid substitution and capture refusal/cancel without losing the accepted match checkpoint. |
| G06 Market/scout/contract/youth | W036–W042 bid cancel/refusal/purchase, listing, dismissal, renewal controls/refusal, two-game goalkeeper trial; W052/W068/W069 expiry/accepted renewal; W073 tribunal | Financial/full-squad purchase refusals, counteroffer/price bounds, empty scout results, other youth positions and trial conversion/expiry | Follow the preserved youth-trial scenario to its actual expiry, then isolate one financial refusal. Broader economy formulas need static/run tasks. |
| G07 Financial posting | W050 hiring charge, W053 sale, W069 renewal, W073 delayed tribunal payment, W075/W081 prizes | Player-dismissal compensation posting, other income/expenses, debt/board outcomes, universal timing | Continue the isolated player-dismissal save through one accounts period and reconcile the quoted compensation. |
| G08 Staff/job changes | W049 refusal/hire N/Y/sack N; W050 posting; W063 approach deferred then N | Staff sack Y/cost, other staff roles, accepting a managerial job and club change | Use isolated staff-hire save for sack Y and a week; keep a job-acceptance scenario separate. |
| G09 Stadium | W048 quote adjustment/abort/order; W050 cancelled-order scenario explicitly unchanged | Completion month/capacity/final charge and limits; administration-change fresh reload | Restore the actual ordered-stadium save, advance only the required period and compare completed capacity/charge. Do not use T61 as that save's continuation. |
| G10 Cup and observer variants | W059 completed two legs, W066 elimination/group week, W070 extra time/neutral semi-final, W075 cup win, W080 observer final extra time | Managed tied-aggregate/penalty decision, chosen-other-fixture watch, remaining tie/draw algorithms | Target one pre-tie checkpoint and capture resolution; separate viewer Enter-watch from automatic observer finals. |
| G11 League/competition rules | W051 league progression/points, W056 populated statistics, W079 final table, W081 promotion/relegation lists, W082 new league makeup | Tie-break formula, other promoted/relegated managed clubs, full selection/qualification rules | Static-first tie-break/qualification task, then a deliberately chosen original tie/checkpoint; do not substitute modern rules. |
| G12 Statistics/history browsing | W043/W045 empty messages; W044/W046 histories/other clubs; W056 populated statistics; W082 seasonal summary | All categories/sort/page bounds, long history, unavailable other-club variants | Navigate one populated statistics/history category at a time with explicit entry/exit and limits. |
| G13 Season archive/rollover variants | W081 seasonal-info Y, promotion/relegation summaries, Gale retires despite renewal; W082 summary, reset table/fixtures; W083 reload | Seasonal-info N, separate .95 fresh-load/deeper history, other retirement/promotion outcomes, annual awards not shown | Investigate the retained DOSBox-X capture crash before retrying full seasonal info; preserve both .95 and .1-0 files. N is a separate save branch. |
| G14 External output and presentation | W026 speed/display controls, W027 detailed history, W029 final stats | Print/F5/P paths, sound behavior, every speed/display boundary | Isolate one print-to-file path if supported; document actual destination/failure rather than assuming a printer workflow. |

## Retained failures and acceptance limits

[confirmed] T61/session-r0001 aborted after a rejected uppercase screen ID;
session-r0002 aborted when DOSBox-X exited-6 during a savestate read after
requesting full seasonal info; session-r0003 was intentionally stopped after
identifying the strict persistence-mode startup-restore mismatch. T61 sessions4/5
authenticate the final-results recovery, rollover/history and F7/fresh-process
reload. The earlier prefixes remain observations with explicit incomplete status.
The [T61 verification](../../runs/T61/verification-r0001.json) checks their ordered
prefixes; it does not grant completed-session status or broaden the byte scanner.
T62's first inventory attempt encountered T41's older schema, failed before
output, and is retained in [its failure receipt](../../runs/T62/catalog-failure-r0001.json).

[designed] This audit prepares the [owner review](review-prompt.md); it does not
run it or declare the manual milestone accepted. T59–T61 upload/publication
permissions and pinned merges remain separate gates. A pending receipt is not
an upload, green CI on an earlier head is not CI on a later candidate, and a
local chapter is not a merged deliverable. Native UI choice follows the accepted
manual/gap audit in #103. The first practical implementation target is a real,
saved management week around the already working watched match, as scoped by
B1–B6 in the [native roadmap](native-gaps.md).
