# The third league week (T112)

[confirmed:T112, runs/T112/week-r0001.json] One real original process, booted
from the same committed `pre-league28` save T106 used, **replayed the T106
route exactly** — every replayed screen digest equals the committed T106
session-r0014 step (53/53 pairs, checked per step) — re-witnessing weeks 28 and
29 before continuing, and played **League match #30: Blackburn R 5–3
Wimbledon** (home) before 28,666. Scorers: I Pearce 3, M Atkins 29 and 55,
T Gale 30, T Sherwood 61; E Ekoku 34 and 73, K Cunningham 68. The receipt is
`runs/T112/week-r0001.json`;
`python3 runs/T112/week.py --check` re-reads every fact from the committed
session and prints `third league week: ready`.

[confirmed:T112] **The week's eight results and the table.** Arsenal 3–0
Southampton, Blackburn R 5–3 Wimbledon, Everton 1–4 Coventry City, Leeds Utd
0–5 Liverpool, Manchester Utd 3–0 Chelsea, Newcastle Utd 2–3 Nottingham F,
Tottenham H 1–0 Sheffield Wed, West Ham Utd 1–3 Q.P.R. Blackburn's row is
P30, home 9-3-3, away 9-2-4, F68 A41, **41 points** — the T106 row plus one
home win under the 2/1/0 rule (41 = 39 + 2; the goals 63+5, 38+3). Newcastle
lead with 45. The cash chain joins: 1,669,078 + 58,332 (gate receipts 57,332)
− 90,827 (salaries, win bonuses, ground maintenance) = **1,636,583**. Transfer
news: K.McPherson (Reading → Bolton W), H.Aune (Rosenborg → Peterbro Utd).

[confirmed:T112] **An injury stoppage offers the substitution menu on the
pitch.** The second half paused with **SUBSTITUTION OPPORTUNITY** offered on
the live pitch (T Sherwood injured, Jones booked) and waited indefinitely —
the pause does not expire on its own. The opportunity sits in the pitch's own
menu; this capture declines it by waiting and the match resumed and finished
5–3 when the pause lifted (the retained superseded sessions show the pause
lasting through 36+ seconds of polling). The substitution flow itself — the
squad screen's PUT HERE route (W028) — is not exercised here.

[confirmed:T112] **The management screen at P30 advertises no next
opponent.** The NEXT OPPONENTS box reads blank: the league schedule of 16
clubs is complete at 30 matches (every club has played every other home and
away). What follows the completed league season belongs to the season-rollover
route and is not decided here.

[confirmed:T112, F41] The captured table's displayed order equals the F41
comparator (points, then the signed 8-bit low byte of goal difference, then
goals for) over the 16 rows. This third table carries **no points ties** (all
16 points totals are distinct), so it confirms the ordering on clean data; the
tie evidence remains weeks 28 and 29's six GD-decided ties.

[designed] The route re-uses the T106 keys and digests rather than re-deriving
the week: the replay is the determinism proof (F04), and week 30's own
screens — kickoff, halftime, the bench, the resumed second half, the injury
pause, full time, the walk (results, table, cash, news, management) — are
captured with their own digests. The retained superseded sessions (r0002–
r0018) record the honest failures: boot-timing races, a swallowed key, the
halftime bench navigation and the injury pause's discovery. Savestates stay
private in `.cache/T112/states/`.
