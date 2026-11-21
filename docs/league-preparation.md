# The league fixture's preparation screen (T100)

[confirmed:T100, runs/T100/session-r0005] A real original process booted from the
restored `pre-league28` save (`League match #28`, Newcastle Utd versus Blackburn
R away), answered the load prompt with `Y`, and opened preparation with `Enter`.
The observed menu before it shows Blackburn R, manager Dalglish, funds
`1,045,060`, LEAGUE POS. 2, season 1994/95, opponent Newcastle Utd (`PREMIER
LEAGUE`, LEAGUE POS. 1) and competition `League match #28`, venue away. The
preparation screen shows the same fixture, `Remaining subs 3`, the eleven
(T Flowers, I Pearce, T Gale, C Hendry, G Le Saux, H Berg, M Atkins, T Sherwood,
J Wilcox, P Warhurst, A Shearer) and subs S Ripley, M Newell, A Wright, B Mimms,
with `PLAY GAME` highlighted.

The private savestate `.cache/T100/states/league-preparation-0001.sav` was taken
at that screen, before `PLAY GAME`; `runs/T100/preparation-r0001.json` records its
digest with the source save's, and `python3 runs/T100/check_preparation.py`
re-verifies the committed session chain, the typed facts and both private
digests when the bytes are present.

[designed] This is a preparation state, not a result: the host clock and seed are
uncontrolled and no kickoff was observed. The next milestone boots this state in
the emulator harness (as T93 booted the Sevilla preparation state), plays the
match under the sealed observer, and only then records a league week.
