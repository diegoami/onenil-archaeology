# Setup and persistence branch matrix

[confirmed] Entries below cite the illustrated chapters and their original capture
records. “Observed” is limited to the procedure tested; it is not general proof
of a season, competition or every input string.

| Branch | Status | Procedure/evidence |
| --- | --- | --- |
| Supplied SAVE1 load, one file | Observed | [Startup W001](startup.md), T41-r0002 |
| N/default filename with Enter | Observed | [Setup W002](setup.md), T42-r0003 |
| N/default filename with Escape | Observed: advances | Setup, T42/session-r0002 steps 1–2 |
| Filename clear/type MANUAL | Observed | [Saves W005](saves.md), T43/session-r0003 steps 1–2 |
| Empty/invalid filename | Unvisited | Separate input-error scenario needed |
| England 1994/95 / one manager | Observed setup | Setup W002–W004, T42/session-r0003 |
| England 1993/94 / two managers | Observed setup | Setup W007, T44/session-r0001 |
| Italy 1993/94 / one manager | Observed setup | Setup W008, T44/session-r0002 |
| Scotland 1993/94 / one manager | Observed setup | Setup W009, T44/session-r0003 |
| Escape at season selector | Observed: remains | T42/session-r0002 step 3 |
| Club division/team browsing | Observed | England T42-r0002; Scotland T44-r0003 |
| Escape at club browser | Observed: process exits 0 | T42/session-r0002/end.json; no after-screen |
| Duplicate club for second manager | Observed refusal/dismissal | T44/session-r0001 steps 7–10 |
| Both manager name/nationality prompts | Observed | T44/session-r0001 |
| Blank manager name | Observed: accepted | T42/session-r0003 steps 5–8 |
| Other invalid manager strings | Unvisited | No inferred validation rule |
| England/Italy/Scotland nationality defaults | Observed | T42-r0003; T44-r0002/r0003 |
| Choose nationality different from league | Observed: Spain accepted | T44/session-r0003 steps 7–9 |
| Nationality list | 32 visible choices inventoried | Setup W009; most not selected |
| NEXT PLAYER handover | Observed | T44/session-r0001 steps 12–13 |
| Previous player | Visible, unexercised | T44/session-r0001 step 13 |
| F7 / fresh-process named-game reload | Observed matching visible state | Saves W005–W006, T43/session-r0003 |
| F10 then N | Observed quit cancellation | T43/session-r0003 steps 10–11 |
| F10 then Y | Unvisited | Explicit affirmative-exit scenario needed |
| Multiple saves / arrows / Enter | Observed | T43/session-r0003 steps 13–16 |
| Escape in saved-game selector | Observed: remains | T43/session-r0003 step 15 |
| No save files / unreadable save | Unvisited | Separate isolated filesystem scenario needed |
| New-game filename collision | Partly observed | Default SAVE1 accepted; destructive/overwrite semantics untested |
| Persistence after tactics, match or week | Unvisited | Squad/matchday/season chapters must check it |

The manual milestone remains open until these gaps and the other management
chapters are reconciled by the coverage audit (#143). This matrix does not close
#137 merely because the four season selectors have been traversed.
