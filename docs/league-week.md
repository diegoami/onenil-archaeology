# The league week after League match #28 (T102)

[confirmed:T102, runs/T102/session-r0002] One real original process, booted from
the restored `pre-league28` save, played **League match #28** and walked the
league week. Keys: `Y` (load), `Enter` (PLAY NEXT GAME), `Enter` (first half),
`Space` (bench), `Enter` (second half), then `Space` through the route.

| Stage | Observed |
| --- | --- |
| Half time | Newcastle Utd 2 — Blackburn R 0, Fox 29, Howey 33, attendance 36,986 |
| Full time | the same score; `NIL` beside Blackburn; Clark on for Venison, Watson on for Albert |
| LEAGUE RESULTS MATCH NO #28 | `Newcastle Utd  2v0  Blackburn R----`, beside seven other results |
| Table | Blackburn row: `2 | 28 | 8 3 3 | 9 1 4 | 60 | 35 | 38` (P28, F60, A35, PTS38); Newcastle 1st on 45 |
| Cash flow | total in 726,972, total out 80,639, club funds **1,691,393**, overdraft facility 2,920,000 |
| Transfer news | A.Thompson Bolton→Grimsby, M.Ielpo AC Milan→Sampdoria, M.Jimenez Sevilla→Besiktas |
| Management | funds 1,691,393, next opponents Chelsea, `League match #29`, away |

The funds join: 1,045,060 at preparation + 726,972 − 80,639 = 1,691,393, so the
route's own screens account for the movement.

[confirmed:T102 arithmetic] The captured table fixes the points rule without any
modern assumption: Newcastle's row (12-2-0 home, 9-1-4 away) is 21 wins and 3
draws for 45 points, and Blackburn's (8-3-3, 9-1-4) is 17 wins and 4 draws for 38,
so a win is **2 points**, a draw **1**, exactly as the manual's T54 observation
said - not three for a win. [designed] The menu's `LEAGUE POS.`
reads 9 after the match although the captured table shows Blackburn 2nd; the
receipt records both as observed and interprets neither. The score, the table
and the cash are this run's facts, not predictions or a points-rule formula.

`runs/T102/week-r0001.json` pins the source save, the session chain, the keys and
the screens; `python3 runs/T102/check_week.py --check` re-reads the score, the
results row, the table row, the cash totals and the next fixture from the
committed screens and prints `ready`. `session-r0001` is the earlier attempt
whose keys left the route at the wrong screen; it is kept as superseded evidence.
