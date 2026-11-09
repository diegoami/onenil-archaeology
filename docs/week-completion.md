# The original management-week completion transaction

[designed:T81, issue#195] What the original does when one friendly management
week completes — the evidence native B5 (onenil#111) needs before it implements
any posting formula, news feed or next-fixture rule. Measured outputs live in
`runs/T81/`; the route itself is the accepted W029/W030 manual chapter.

## The observed transaction

[confirmed: runs/T81/session-r0007.json, producerb80f091; session-r0008.json,
the independent repeat] One fresh original96 session from the supplied SAVE1
plays the prepared friendly (Blackburn R, manager 1, club 130) without
substitutions: the interval is visited, the bench reviewed, PLAY GAME resumes,
the second half runs to the settled full time, and the W030 route (CONTINUE →
exit to final statistics → cash flow → transfer news → management menu)
completes the week. The decoded save file binds the transaction:

- **Cash**: the club's signed cash word at DCC4+(manager−1)×94+82 moves
  452,000 → 421,491 (the match's gate receipts and outgoings net −30,509);
  both independent sessions recorded the identical after-value, matching the
  W030 manual chapter's independently observed club funds for the same week.
- **Roster**: the first-team arrangement is unchanged by the week — the same
  twenty words before and after, and the reloaded memory carries them.
- **Player refreshes**: the week rewrites the roster players' condition fields
  (Gale 17→19 in r0007; both sessions record refreshes) while positions,
  individual instructions and status bits stay as the match left them
  (status 0 for this card-free friendly).
- **Seed**: the saved RNG seed word differs between sessions (clock-derived);
  the reloaded memory carries exactly the saved seed.

[confirmed: same records, save digest timeline] The save file changes during
the week-completion route — before F7 (the T80 autosave, reproduced here on
the substitution-free week) — and F7 at the management menu rewrites
byte-identical data on that state. The fresh process loads the saved file
(restart receipt, digests equal) and its memory decodes equal the saved file's
decodes: cash, roster, player fields and seed.

## What native B5 must reproduce, and what it must not invent

[derived] For one friendly week the native campaign commits, atomically with
the played result: the cash movement, the roster-player condition refreshes,
the unchanged roster arrangement, the advanced week state and the next
fixture — then saves the same bytes that a reload restores. The transfer-news
rows and the cash-flow categories are week OUTPUT the native displays; this
task authenticates their structure and this week's values without generalising
a transfer market or a financial formula from one friendly. The substitution
case's persistence (the roster exchange survives the week) is T80's finding
and is unchanged here: r0007/r0008 walk the no-substitution week and the
exchange policy is untouched by it.

Corruption controls: the public validation rejects wrong release/producer
identities, broken stage order, mutated state or decoded values, a missing
route marker (cash flow, transfer news, next-fixture menu), a week that left
the boot save unchanged, a saved roster that differs from the kickoff roster,
a reload that differs from the saved decode, and non-independent repeats.
The retained aborted sessions r0001–r0006 document each driver boundary the
route required (bootstrap, the halftime-bench resume key, the capacity scope,
the management/finance decode, the observation keys).
