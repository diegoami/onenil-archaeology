# The second league week (T106)

[confirmed:T106, runs/T106/week-r0001.json] One real original process, restored
from the committed `pre-league28` save, replayed the recorded week-28 route
(match #28 reproduced exactly: Newcastle Utd 2-0 Blackburn R, Fox 29, Howey 33,
attendance 36,986 - the match replays deterministically from the save, as F04
item 5 found for menus), reached the post-week management machine, and played
**League match #29: Chelsea 3-3 Blackburn R** before 29,158 (Newell 14,
Warhurst 16, 78; Spencer 23, Rocastle 25, Burley 88). The results screen shows
the eight round-29 rows; Blackburn's table row is 2nd with P29, 8-3-3 / 9-2-4,
F63 A38, **39 points** - the pre-round row plus one away draw under the 2/1/0
rule, re-proving the points model on a second week. The cash flow joins the
T102 receipt: 1,691,393 + 58,316 - 80,631 = **1,669,078**. The menu advertises
League match #30, Wimbledon, home. `python3 runs/T106/week.py --check` re-reads
every fact from the committed screens.

[confirmed:T106] **The original refuses a fielded ineligible player.** After
week 28's processing, PLAY GAME answered with *"Blackburn R has an ineligible
player in the first team : hit any key"* and returned to the pre-match screen
(the retained superseded sessions record it; F04 item 7 saw the same message at
League match #3). The retained T106 sessions show the refusal survives until
the squad is changed.

[confirmed:T106] **The manager's own squad transaction clears it.** On the
squad screen (SPACEBAR from the preparation screen), pressing Return on a
first-team player marks him, and completing Return on a reserve player
exchanges the two - the route T46's retained save used for Flowers/Mimms
([confirmed: docs/campaign-seed.md]), here recorded screen by screen: A Wright
came in for H Berg, M Newell for C Hendry, and PLAY GAME then admitted match
#29. [derived:T106] Decoding the private post-league28 state through the T105
projection flags exactly Hendry and Berg (status values 1 -> 3, the week-28
processing's own change) and shows Ripley with condition 0 - which is why the
first attempted pair (Wright, Ripley) was refused again and the second
(Wright, Newell) played. The eligibility rule itself is not decoded here; the
screens and the outcome are the record.

[designed] The superseded sessions (r0002-r0013) are retained: each records an
honest attempt - the lost-key and blank-row navigations, the refusal, and the
first swap pair - under its own r-number. Savestates stay private
(`.cache/T106/states/`): the preparation-29 machine (pre-PLAY GAME, original
squad) and the post-league29 machine (match #30 advertised).

The native league line can now bind a second witnessed week: the witnessed
squad transaction (a state change no earlier native API models), the draw's
table arithmetic, and the cash movement are all screen-bound and re-readable.
