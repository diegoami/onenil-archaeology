# Roadmap: from the accepted watched match to the management game

[designed: owner, 2026-11-05] Play the original thoroughly and write an exact,
illustrated user manual before planning the remaining game from its binary alone.
Use that manual to identify missing behavior and decide the full-game UI technology.
The Rust engine remains; the match browser prototype does not decide the full UI stack.
Live status belongs to the linked issues, not this document.

## Milestones and dependencies

| Order | Deliverable | Exit check |
| --- | --- | --- |
| 0 | [Accepted native watched exhibition](https://github.com/diegoami/onenil/issues/35) | Owner review passes four match gates; original parity scope remains reference64 only |
| 1 | [Original-game illustrated manual and workflow coverage](https://github.com/diegoami/onenil-archaeology/issues/135) | Observed screen/transition catalog, screenshot-backed procedures, branch checklist and reproducible evidence; unknowns explicit; combined owner review follows the gap audit |
| 2 | [Coverage and rebuild gap audit](https://github.com/diegoami/onenil-archaeology/issues/143) | Every workflow maps to native status/evidence/dependencies and a bounded next task; owner reviews the manual and audit together before the UI decision |
| 3 | [UI technology decision](https://github.com/diegoami/onenil/issues/103) | Compare browser and packaged desktop delivery using documented requirements; working dense squad table and end-to-end matchday interaction spikes; record keyboard, dialogs, local save/load, offline distribution, accessibility, tests and Rust integration tradeoffs; owner design decision |
| 4 | [First complete native management week](https://github.com/diegoami/onenil/issues/104) | Club selection/load → squad/tactics → match → results/table → next week, with real persisted state and save/load; original comparisons and owner-run review |
| 5 | Management breadth and full season | Implement remaining observed transfers/contracts, finances, competitions and AI in dependency-ordered slices; original season checkpoints and rollover agree within explicitly documented scope |

Manual exploration comes before new management engine/UI implementation. Static
reading supplements observed workflows and explains effects; it cannot substitute
for playing an unvisited screen. UI spikes may use disposable data, but product
acceptance requires native state and rejects canned outcomes.

## Manual backlog, in working order

| Issue | Exploration | Required coverage |
| --- | --- | --- |
| [#136](https://github.com/diegoami/onenil-archaeology/issues/136) | T41 foundation and startup | Capture/validation pipeline, supplied-save startup, first main-menu catalog, exact keys, screenshots and identities |
| [#137](https://github.com/diegoami/onenil-archaeology/issues/137) | Setup and saves | New-game choices, leagues/clubs/names, cancel/invalid paths, save/load persistence |
| [#138](https://github.com/diegoami/onenil-archaeology/issues/138) | Squad and tactics | Player details, lineup/reserves, roles/formations, availability, invalid selections |
| [#139](https://github.com/diegoami/onenil-archaeology/issues/139) | Matchday | Pre-match options, watched/quick UI, commentary/pitch controls, halftime/substitutions, final results/table |
| [#140](https://github.com/diegoami/onenil-archaeology/issues/140) | Transfers and contracts | Buying/selling, offers, negotiations, defaults, acceptance/refusal/cancel, renewals/expiry and visible effects |
| [#141](https://github.com/diegoami/onenil-archaeology/issues/141) | Finances and club administration | Statements, wages/income/costs, board/administration interactions actually discovered |
| [#142](https://github.com/diegoami/onenil-archaeology/issues/142) | Competitions and season | Weekly flow, fixtures/tables/cups/news, conditional injuries/suspensions and season boundary; separate scenarios for unreached branches |
| [#143](https://github.com/diegoami/onenil-archaeology/issues/143) | Coverage audit | Menu/transition reconciliation, missing branches, native gap matrix and owner-review prompt |

Each area becomes one or more 150–400 word frozen tasks before implementation.
An area that cannot fit a bounded session is split by observable workflow, not
marked complete after its first screenshot. One season is a useful traversal,
not proof of every transfer/cup/relegation/error branch. Keep explicit scenarios
for choices, confirmations, failures and cancellation.

## Manual and evidence contract

The manual lives in [docs/manual](manual/README.md). Every observed screen has a
stable ID, entry route, controls, visible fields/defaults, exits, state effects,
screenshot and run reference. Every workflow gives exact steps and expected
visible feedback, then its limits. Screenshot sequences show before/action/after
for meaningful interactions rather than decorative duplicates. Record edition,
game hashes, supplied save or scenario identity, source commit and exact keys.
Never relabel guesses as observed behavior.

Rendered screenshots are research illustrations, not product assets. Original
executables, data, palettes, fonts, saves and savestates remain private/ignored.
Measured evidence is append-only. New sessions use new run names; screenshots
and records are digest-linked. New-game and loaded-save routes remain distinct.

## Existing follow-ups

The accepted exhibition has small independent review items: native
[#98](https://github.com/diegoami/onenil/issues/98)/[#99](https://github.com/diegoami/onenil/issues/99)
are the current T47 documentation/tooling task. CI coverage
[#97](https://github.com/diegoami/onenil/issues/97) depends on workflow permissions
tracked by #22; do not bypass the credential restriction. Compiler warnings
[#100](https://github.com/diegoami/onenil/issues/100) are nonblocking hygiene.
Broader original match observations #120/#121 and prose correction #134 stay
explicit in archaeology; the manual does not retroactively accept those claims.

## Audit handoff and next playable target

[derived: T62 pinned source audit] See the [coverage reconciliation](manual/coverage-audit.md),
[83-workflow native matrix and B1–B10 dependencies](manual/native-gaps.md), and
[owner-run review prompt](manual/review-prompt.md). The audit finds 11 partially
supported original procedures and 72 missing full procedures in the native
application. This is a workflow count, not a fraction of engine code completed.
The accepted watched exhibition remains the reusable match component.

[designed] Complete the approved publication/merge/CI gates, then obtain owner
acceptance of the manual and audit together. Native#103 selects the management
UI technology after that acceptance. The first campaign milestone is B1–B6:
one persistent club/fixture state, club load, squad edit/admission, the existing
watched match, a real week transition and a stored league result/table. Transfers,
staff/stadium and full-season breadth extend that loop in subsequent slices.
Unvisited original branches remain explicit G01–G14 research scenarios. This
handoff does not run the review or claim the campaign already exists.
