# Native workflow gaps and dependency roadmap

[derived: T62 catalog] The full original management procedures currently map to
**11 partial / 72 missing / 0 implemented / 0 uncertain** native workflows.
This measures the complete procedures, not the amount of engine code already
ported. The native watched exhibition is playable; it does not yet provide a
campaign load→squad→match→results→next-week loop.

[confirmed] Research input commit is
`67dd355b4d4e5b646422fc1fdd922064bf6868d7`, including local T59–T61 candidates;
those dependencies await approved publication and merge. Native source is pinned
to `a634fb27a2d438c67d20e95cf66aa11bc0737732`. The inspected checkout
`6253ec222f0e80d56d2795163500a365ce422c9c` has an identical tree. The
[catalog](../../runs/T62/catalog-r0001.json) records all 83 workflow headings,
338 screenshot/record references, 27 referenced sessions and 173 native source
file digests. Of the referenced sessions, 24 authenticate as completed and 3 are
retained aborted attempts. Their scope is explicit in [coverage](coverage-audit.md).

## Native evidence and interpretation

[designed] Implemented requires the whole documented procedure at the product
boundary. Partial means a concrete part is supported, with the missing boundary
named. Missing means the inspected application does not expose that procedure;
isolated engine routines may still exist. Uncertain would mean insufficient
source/evidence to decide; no row needs that label for this pinned application.
No new native test execution or broader parity is claimed by this source audit.

| Evidence | Inspected source and actual assertions | Limit |
| --- | --- | --- |
| N0 | [Watched HTML](https://github.com/diegoami/onenil/blob/a634fb27a2d438c67d20e95cf66aa11bc0737732/web/watched/index.html), [HTTP actions/state](https://github.com/diegoami/onenil/blob/a634fb27a2d438c67d20e95cf66aa11bc0737732/tools/play_watched.py#L339), [quick HTTP actions](https://github.com/diegoami/onenil/blob/a634fb27a2d438c67d20e95cf66aa11bc0737732/tools/play_match.py#L140), plus catalog source manifest | Both applications expose exhibition configuration/start/step/continue/restart; no campaign menus, game-save persistence, week/table/transfer/administration commands. The missing judgments are about these integrated workflows. |
| N1 | [Preparation and Match controller](https://github.com/diegoami/onenil/blob/a634fb27a2d438c67d20e95cf66aa11bc0737732/tools/play_watched.py#L15), [controller tests](https://github.com/diegoami/onenil/blob/a634fb27a2d438c67d20e95cf66aa11bc0737732/tools/test_play_watched.py#L81) | Tests compare all reference64 action identities/positions/score, all four lineup/seed completions, invalid-phase atomicity and preparation state. Arbitrary club/XI/season input is absent. Only reference64 has complete original parity. |
| N2 | [Frontend rendering/control](https://github.com/diegoami/onenil/blob/a634fb27a2d438c67d20e95cf66aa11bc0737732/web/watched/app.js), [browser assertions](https://github.com/diegoami/onenil/blob/a634fb27a2d438c67d20e95cf66aa11bc0737732/tools/smoke_watched_viewer.py#L87) | Actual named actions,22 player positions/ball, score/clock, pace, pause with in-flight request, halftime/fulltime/restart. Pause is one viewer's presentation control; the native match is computed during preparation. |
| N3 | [Quick Match controller](https://github.com/diegoami/onenil/blob/a634fb27a2d438c67d20e95cf66aa11bc0737732/tools/play_match.py), [quick controller tests](https://github.com/diegoami/onenil/blob/a634fb27a2d438c67d20e95cf66aa11bc0737732/tools/test_play_match.py#L22) | Continuous native exhibition with supported choices, goals/substitutions and phase guards. It is a separate preview; no watched R-switch or weekly accounting. Its generic clock messages are not the detailed watched commentary implementation. |
| N4 | [Lineup guard](https://github.com/diegoami/onenil/blob/a634fb27a2d438c67d20e95cf66aa11bc0737732/engine/src/watched_compiled/lineup_validation.rs), [nine-case assertions](https://github.com/diegoami/onenil/blob/a634fb27a2d438c67d20e95cf66aa11bc0737732/engine/src/watched_compiled/watched_match.rs#L735) | Native counts/availability/keeper/role checks compare original returns and counters. This is real reusable admission logic; the corresponding interactive management editor/modal UI is absent. |

## Every workflow

[derived] Each original link identifies the numbered procedure and its exact
keys/screens. N0 supplies the product boundary for missing rows; N1–N4 identify
partial support. The next column selects a bounded follow-up defined below,
whose dependency column applies to every row assigned to it.

| ID | Original procedure/evidence | Native | Evidence and remaining boundary | Next |
| --- | --- | --- | --- | --- |
| W001 | [load the supplied SAVE1](startup.md) | missing | N0: campaign procedure absent from inspected application | B2 |
| W002 | [filename, season and number of managers](setup.md) | missing | N0: campaign procedure absent from inspected application | B2 |
| W003 | [browse and choose a club](setup.md) | missing | N0: campaign procedure absent from inspected application | B2 |
| W004 | [manager name and nationality](setup.md) | missing | N0: campaign procedure absent from inspected application | B2 |
| W005 | [save and cancel quitting](saves.md) | missing | N0: campaign procedure absent from inspected application | B2 |
| W006 | [choose and reload the saved game](saves.md) | missing | N0: campaign procedure absent from inspected application | B2 |
| W007 | [two human managers and duplicate-club refusal](setup.md) | missing | N0: campaign procedure absent from inspected application | B2 |
| W008 | [Italy 1993/94 setup](setup.md) | missing | N0: campaign procedure absent from inspected application | B2 |
| W009 | [Scotland 1993/94 setup and another nationality](setup.md) | missing | N0: campaign procedure absent from inspected application | B2 |
| W010 | [enter Players, compare players and return](squad.md) | missing | N0: campaign procedure absent from inspected application | B3 |
| W011 | [the main-menu squad shortcut remembers the view](squad.md) | missing | N0: campaign procedure absent from inspected application | B3 |
| W012 | [cycle main-menu information](squad.md) | missing | N0: campaign procedure absent from inspected application | B3 |
| W013 | [inspect a player outside the starting eleven](squad.md) | missing | N0: campaign procedure absent from inspected application | B3 |
| W014 | [cancel a move, then exchange goalkeepers](selection.md) | partial | N1: reference/reserve preset swap only; arbitrary move/cancel and squad editor absent | B3 |
| W015 | [change individual goalkeeper instructions](selection.md) | missing | N0: campaign procedure absent from inspected application | B3 |
| W016 | [Reposition cycles current position; Club position restores it](selection.md) | missing | N0: campaign procedure absent from inspected application | B3 |
| W017 | [save and reload the changed selection](selection.md) | missing | N0: campaign procedure absent from inspected application | B3 |
| W018 | [inspect the opponent and configuration](match-preparation.md) | partial | N1: lineup/seed controls only; opponent/configuration workflow absent | B4 |
| W019 | [enter match preparation](match-preparation.md) | partial | N1: computed preparation and kickoff; original bench/options absent | B4 |
| W020 | [edit team instructions](match-preparation.md) | missing | N0: campaign procedure absent from inspected application | B4 |
| W021 | [change the displayed formation through player positions](match-preparation.md) | missing | N0: campaign procedure absent from inspected application | B4 |
| W022 | [view pre-match statistics and start the watched fixture](match-preparation.md) | partial | N1: watched kickoff supported; pre-match statistics page absent | B4 |
| W023 | [an incomplete lineup is refused at PLAY GAME](match-preparation.md) | partial | N4: original admission guard and nine cases; user-editable lineup/refusal UI absent | B4 |
| W024 | [start, open the bench and resume](watched-match.md) | partial | N1/N2: start/pause/resume; original bench controls absent | B4 |
| W025 | [request and cancel a substitution](watched-match.md) | missing | N0: campaign procedure absent from inspected application | B4 |
| W026 | [display and speed controls](watched-match.md) | partial | N2: pitch and pace; original display modes/keyboard controls absent | B4 |
| W027 | [read detailed commentary history](watched-match.md) | partial | N1/N2: named action log; original history screen/paging absent | B4 |
| W028 | [halftime and a legal replacement](watched-match.md) | partial | N1: halftime continuation; managed substitution/instruction editor absent | B4 |
| W029 | [fulltime, commentary and final statistics](watched-match.md) | partial | N1/N2: fulltime score/actions; original final statistics and campaign handoff absent | B4 |
| W030 | [return to the next management week](watched-match.md) | missing | N0: campaign procedure absent from inspected application | B5 |
| W031 | [Disable Watch match and complete a fixture](quick-results.md) | partial | N3: separate quick exhibition completes; Watch-off campaign fixture/accounting absent | B4 |
| W032 | [Switch the watched pitch to R-result](quick-results.md) | missing | N0: campaign procedure absent from inspected application | B4 |
| W033 | [League tables and results after a friendly](quick-results.md) | missing | N0: campaign procedure absent from inspected application | B6 |
| W034 | [Cup views and weekly fixtures](quick-results.md) | missing | N0: campaign procedure absent from inspected application | B6 |
| W035 | [Team fixture list](quick-results.md) | missing | N0: campaign procedure absent from inspected application | B6 |
| W036 | [Browse the market and cancel a bid](transfers.md) | missing | N0: campaign procedure absent from inspected application | B8 |
| W037 | [Refused fee, accepted purchase contract and resulting squad](transfers.md) | missing | N0: campaign procedure absent from inspected application | B8 |
| W038 | [Sell confirmation, transfer listing and removal](transfers.md) | missing | N0: campaign procedure absent from inspected application | B8 |
| W039 | [Scout criteria, search results and cancellation](transfers.md) | missing | N0: campaign procedure absent from inspected application | B8 |
| W040 | [Existing-player renewal, editing and cancellation](contracts.md) | missing | N0: campaign procedure absent from inspected application | B8 |
| W041 | [Fire confirmation, compensation and cancellation](contracts.md) | missing | N0: campaign procedure absent from inspected application | B8 |
| W042 | [Hire a youth player on trial](contracts.md) | missing | N0: campaign procedure absent from inspected application | B8 |
| W043 | [Statistics availability](history.md) | missing | N0: campaign procedure absent from inspected application | B10 |
| W044 | [Player transfer history and team history](history.md) | missing | N0: campaign procedure absent from inspected application | B10 |
| W045 | [Seasonal history availability](history.md) | missing | N0: campaign procedure absent from inspected application | B10 |
| W046 | [Other-team information and squad details](history.md) | missing | N0: campaign procedure absent from inspected application | B10 |
| W047 | [Read cash flow and club/staff information](administration.md) | missing | N0: campaign procedure absent from inspected application | B7 |
| W048 | [Stadium quote, abort and scheduled improvements](administration.md) | missing | N0: campaign procedure absent from inspected application | B9 |
| W049 | [Staff browser, refusals and a successful hire](administration.md) | missing | N0: campaign procedure absent from inspected application | B9 |
| W050 | [Weekly account posting after the hire](administration.md) | missing | N0: campaign procedure absent from inspected application | B7 |
| W051 | [Successive weeks and the first league match](league-start.md) | missing | N0: campaign procedure absent from inspected application | B5 |
| W052 | [Expiring contract interrupts weekly processing](league-start.md) | missing | N0: campaign procedure absent from inspected application | B8 |
| W053 | [Incoming offer and completed sale during the week](league-start.md) | missing | N0: campaign procedure absent from inspected application | B8 |
| W054 | [International duty, suspension and an incomplete lineup](league-start.md) | missing | N0: campaign procedure absent from inspected application | B3 |
| W055 | [Cup injury interruption, replacement and next-round draw](league-start.md) | missing | N0: campaign procedure absent from inspected application | B4 |
| W056 | [Statistics after league fixture four](league-start.md) | missing | N0: campaign procedure absent from inspected application | B10 |
| W057 | [Save and reload the progressed week in a fresh process](league-start.md) | missing | N0: campaign procedure absent from inspected application | B1 |
| W058 | [Restore and inspect availability](autumn.md) | missing | N0: campaign procedure absent from inspected application | B3 |
| W059 | [Complete a European two-leg tie](autumn.md) | missing | N0: campaign procedure absent from inspected application | B6 |
| W060 | [Injury replacement and recovery](autumn.md) | missing | N0: campaign procedure absent from inspected application | B4 |
| W061 | [Ineligible-player refusal and extra time](autumn.md) | missing | N0: campaign procedure absent from inspected application | B4 |
| W062 | [Ten-week contract warnings](autumn.md) | missing | N0: campaign procedure absent from inspected application | B8 |
| W063 | [Managerial approach, deferred decision and refusal](autumn.md) | missing | N0: campaign procedure absent from inspected application | B9 |
| W064 | [Scenario changes and league-ten checkpoint](autumn.md) | missing | N0: campaign procedure absent from inspected application | B5 |
| W065 | [Resume the saved season and progress through league sixteen](midseason.md) | missing | N0: campaign procedure absent from inspected application | B5 |
| W066 | [European elimination and the following group stage](midseason.md) | missing | N0: campaign procedure absent from inspected application | B6 |
| W067 | [Injury replacement, recovery and international absence](midseason.md) | missing | N0: campaign procedure absent from inspected application | B3 |
| W068 | [Expiry cancellation leaves a listed squad member](midseason.md) | missing | N0: campaign procedure absent from inspected application | B8 |
| W069 | [Renew a player still marked as retiring](midseason.md) | missing | N0: campaign procedure absent from inspected application | B8 |
| W070 | [Domestic cups, extra time and neutral semi-final](midseason.md) | missing | N0: campaign procedure absent from inspected application | B6 |
| W071 | [Inspect actual selection and cancel before committing a move](midseason.md) | missing | N0: campaign procedure absent from inspected application | B3 |
| W072 | [Weekly announcements and saved continuation](midseason.md) | missing | N0: campaign procedure absent from inspected application | B5 |
| W073 | [Expired player leaves at a tribunal-set fee](later-season.md) | missing | N0: campaign procedure absent from inspected application | B8 |
| W074 | [Announced friendlies become actual fixtures](later-season.md) | missing | N0: campaign procedure absent from inspected application | B6 |
| W075 | [Neutral final, injury replacement and winner celebration](later-season.md) | missing | N0: campaign procedure absent from inspected application | B6 |
| W076 | [Listed expiry and actual eligibility are separate observations](later-season.md) | missing | N0: campaign procedure absent from inspected application | B8 |
| W077 | [Later weekly flow and league progression](later-season.md) | missing | N0: campaign procedure absent from inspected application | B5 |
| W078 | [Save the league-twenty-four endpoint](later-season.md) | missing | N0: campaign procedure absent from inspected application | B1 |
| W079 | [Finish fixtures and handle unavailable players](season-rollover.md) | missing | N0: campaign procedure absent from inspected application; original prefix observations and completed final-result recovery distinguished | B5 |
| W080 | [European final and the actual End of season entry](season-rollover.md) | missing | N0: campaign procedure absent from inspected application | B6 |
| W081 | [Save seasonal information, promotion and retirement](season-rollover.md) | missing | N0: campaign procedure absent from inspected application | B10 |
| W082 | [Inspect populated history and the new-season state](season-rollover.md) | missing | N0: campaign procedure absent from inspected application | B10 |
| W083 | [Verify next-season persistence with a fresh process](season-rollover.md) | missing | N0: campaign procedure absent from inspected application | B1 |

## Bounded next tasks

[designed] These are proposed task boundaries, not authorization to choose a UI
stack or a claim that the manual review has passed. Freeze each implementation
task before coding. The first management-week target needs B1–B6; other areas
then extend that loop. Each first step below is deliberately narrower than its
whole workflow group.

| ID | Depends on | Next bounded task and its acceptance |
| --- | --- | --- |
| R0 | Approved T59–T61 publication/merges and checked T62 | Owner runs the [manual review prompt](review-prompt.md). Required findings become issues/fixes before acceptance. |
| U0 | R0 accepted | Native #103: compare browser/desktop requirements with squad-table and matchday spikes; owner selects delivery technology. No selection is made by this audit. |
| B1 | U0 | Define versioned campaign state for one club and one fixture; round-trip lineup, instructions, money and current week through a real local save. Reject malformed/version-mismatched input without replacing live state. |
| B2 | B1 | Build one club selection/load route into that state; demonstrate cancel and restored manager/club identity. Extend to the other observed setup variants in later tasks. |
| B3 | B2 | Build one squad list/detail pane and an actual pick/move/cancel operation; preserve club/current positions and reject an unavailable first XI using the existing admission guard. Individual/team instruction editors are subsequent bounded tasks. |
| B4 | B3 | Feed the edited campaign XI into the existing watched preparation, return the actual match result into campaign state, and preserve phase guards. Follow with one managed halftime substitution transaction; original controls/options need separate comparisons. |
| B5 | B4 | Complete exactly one friendly management week: result→cash/news→next opponent, with actual state changes and save/reload. This closes the first meaningful campaign loop before broadening to league weeks. |
| B6 | B5 | Complete one league fixture, update its stored result and table, then verify the next fixture and saved table against an original checkpoint. Cup scheduling/legs/extra time require separate tasks after this base. |
| B7 | B5 | Post one period's gate receipts, salaries and one known contract charge into cashflow; reconcile totals and persist them. Freeze further cost/board events separately. |
| B8 | B3,B7 | Implement one accepted purchase and cancel path, changing the real squad and posting its known charge. Subsequent slices cover sale, expiry/tribunal, renewal and youth trial lifecycles. |
| B9 | B7 | Implement one scout hire with N/Y confirmation, role replacement and next-week posting. Staff dismissal, job changes and stadium completion remain separate slices. |
| B10 | B6,B7,B8 | Store and render one completed week's fixture/statistics history, then later one season summary and rollover checkpoint with retirement and next-year persistence. Full-season logic is a later milestone. |

[derived] Reusing the native watched engine avoids rebuilding the accepted
exhibition. The missing bridge is persistent campaign state and the management
transitions feeding that engine and consuming its result. Counts above must not
be presented as a percentage of game code completed or a delivery-time estimate.

## Requirements for the later UI decision

[derived from the named original workflows] Native#103 can compare the same
acceptance cases across its proposed delivery technologies. These requirements
describe what the spikes must demonstrate; this audit selects no technology.

| Requirement | Original evidence | Concrete spike acceptance |
| --- | --- | --- |
| Dense squad and linked detail panels | W010–W017, executable-squad.md | Navigate first XI/subs/reserves by keyboard, keep selected player identity stable, and show detail/skills without losing the pending move. |
| Explicit transaction and cancellation boundaries | W014/W025/W036–W042/W048/W049/W068 | Preview one move or contract edit, commit once, cancel without unintended mutation, and distinguish a dismissal confirmation from a listing/expiry transition. |
| File persistence and offline use | W005/W006/W017/W057/W083 | Save real state, close/reopen the application offline, load it and compare the visible lineup/instructions/week. Include an invalid-save refusal without replacing current state. |
| Responsive match preparation and matchday return | W019/W024–W030, native N1/N2 | Keep the UI responsive while the existing Rust engine prepares the selected XI; follow commentary/pitch/halftime/fulltime and commit the actual result into one campaign fixture. |
| Long, navigable competition/history views | W033–W035/W044/W056/W082 | Browse a populated table, fixture schedule and history with keyboard/paging while preserving club/year/category context. |
| Clear conditional availability and accounting feedback | W023/W050/W054/W061/W067/W073 | Surface a refused XI with the actual reason, preserve the edit, and show one real weekly posting/tribunal payment without using display text as the state model. |
| Separate normal save and seasonal archive | W081–W083 and G13 | Define how both file purposes are represented/exported; retain the unverified .95 deeper-view limitation and do not claim it already reloads correctly. |

[designed] The owner chooses technology after the combined manual/audit review.
Accessibility, installation/distribution, Rust integration and validation costs
belong in that comparison alongside these original-workflow cases. The current
browser exhibition establishes one working presentation, not that decision.
