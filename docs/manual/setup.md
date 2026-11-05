# Starting a new game

[confirmed] These observations are of One-Nil 96, using the verified release in
`records/T01/inventory.json`. Captures were produced by committed scripts; each
session's `session.json` identifies its source and game files. This chapter covers
setup; persistence after saving and restarting is still pending under #137.

## W002: filename, season and number of managers

1. At the startup load question, press **N**. S003 asks “Please enter name of new
   game”; the visible default is `Save1` and the `.1-0` suffix is outside the input.
2. Press **Enter** to accept that default. S004 opens the starting-season selector.
   Its four visible choices are **ENGLAND 1993/94**, **ENGLAND 1994/95**,
   **ITALY 1993/94** and **SCOTLAND 1993/94**. England 1993/94 is initially highlighted.
3. Press **Down**, then **Enter**, to choose England 1994/95.
4. S005 asks for the number of players, **ONE** or **TWO**. ONE is initially
   highlighted. Press **Enter** to choose it and open the club browser.

[confirmed] Exact route and before/action/after evidence:
[session-r0003](../../runs/T42/session-r0003/session.json), steps 0–4,
producer `1bd53c2`. “Players” at this prompt means human managers: the subsequent
club selector says “Select your team, player 1”; the TWO branch's second manager
has not yet been exercised.

![S003: new-game filename](../../runs/T42/session-r0003/step-0001.png)
![S004: starting season](../../runs/T42/session-r0003/step-0002.png)
![S005: number of players](../../runs/T42/session-r0003/step-0003.png)

## W003: browse and choose a club

[confirmed] S006 has a club list on the left, team formation/averages/ratings/value
and tactics in the middle, and the named first team, substitutes and remaining
players on the right. Blackburn R is initially selected in this scenario.
Up/Down changes the highlighted club. Right changes from PREMIER LEAGUE to
DIVISION ONE, initially showing Manchester City. Left returns to PREMIER LEAGUE;
Down then highlights Manchester Utd. The team preview updates with the selection.
Press **Enter** on Blackburn R to open S007, the manager-name input.

[confirmed] The navigation experiment is in
[session-r0002 steps 7–9](../../runs/T42/session-r0002/step-0007.json), producer
`5a1422c`; the completed selection route is in session-r0003 steps 4–5.
The bottom of the browser advertises **Ins—Change information** and
**Spacebar—Squad**; these two controls remain untested in this setup slice.

![S006: club browser](../../runs/T42/session-r0003/step-0004.png)
![S006 variant: another division](../../runs/T42/session-r0002/step-0008.png)
![S006 variant: another club](../../runs/T42/session-r0002/step-0009.png)
![S007: manager name](../../runs/T42/session-r0003/step-0005.png)

## W004: manager name and nationality

[confirmed] S007 initially contains `K Dalglish` and asks for an initial followed
by a surname. In this run, **Home**, twelve **Delete** presses and **Enter**
cleared the field and advanced without a visible refusal. S008 then asks for
nationality. **ENGLAND** is highlighted in the rendered screenshot, and the
screen advertises Up/Down to move, Enter to select, Escape to exit.
Press **Enter** to accept England. This completes setup and opens S009, the
main menu: Blackburn R, season 1994/95, game name SAVE1 and a blank MANAGER
field. The observed balance is 464,000 and the next friendly is against Aston
Villa; those are this run's values, not a guaranteed seed-independent default.

[confirmed] Evidence: session-r0003 steps 5–8, producer `1bd53c2`.
This establishes that this setup route accepts a blank manager name; it does
not establish every string-editing or filename-validation rule.

![S007 variant: empty name](../../runs/T42/session-r0003/step-0006.png)
![S008: nationality](../../runs/T42/session-r0003/step-0007.png)
![S009: new-game main menu](../../runs/T42/session-r0003/step-0008.png)

## Escape behaves differently between prompts

[confirmed] At S003, **Escape accepts the default filename and advances to S004**;
it does not return to the initial question. At S004, Escape leaves the season
selector visible with England 1993/94 highlighted. See session-r0002 steps 1–3.

[confirmed] At the club browser, Escape caused the original emulator process to
exit with code 0. The harness then failed its next screen read, so this exploratory
session is correctly retained as aborted, not as a completed setup route. The key
and process result are recorded in
[session-r0002/end.json](../../runs/T42/session-r0002/end.json). No after-screen
exists for that exit; do not interpret the aborted harness status as a game crash.

![S004 after Escape at filename](../../runs/T42/session-r0002/step-0002.png)

## Coverage remaining

Other seasons, the two-manager route and duplicate-club refusal, filename editing
and further invalid-name cases, save overwrite/confirmation, missing-save loading and persisted
reload are pending. The presence of a season choice is not proof that its later
competition rules have been traversed. Squad inspection and matchday have their
own chapters/backlog tasks.
