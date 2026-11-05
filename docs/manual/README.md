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
| [New-game setup](setup.md) | Observed S003–S009/W002–W004: England 1994/95, one manager, club browsing, name/nationality, Escape/default/blank-name branches; save/reload and other setups pending | #137 |
| Squad and tactics | Selection, player details, roles, reserves, validation | #138 |
| Matchday | Pre-match through halftime/fulltime and results | #139 |
| Transfers and contracts | Offers, negotiation, acceptance/refusal and expiry | #140 |
| Finances and administration | Visible accounts, board and club actions | #141 |
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
| S005 | Number of players | ONE accepted; TWO highlighted only |
| S006 | Club browser | England 1994/95; division and team navigation; Escape exits |
| S007 | Manager name | Default K Dalglish; clearing field and accepting blank exercised |
| S008 | Nationality | England accepted; alternatives visible but untested |
| S009 | New-game main menu | Blackburn R/1994–95; blank manager variant; no persistence claim yet |
