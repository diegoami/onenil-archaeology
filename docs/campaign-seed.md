# A coherent saved club for native persistence

[confirmed: F03/T03, T05] Supplied One-Nil96 SAVE1 loads the ENGL-95 namespace.
Its saved year1995 and game season counter1 display1994/95. Do not combine this
initial club with the later prepared exhibition's names/roster, even where numeric
player IDs coincide. Player identity includes the league/save namespace.

[confirmed static: generated listings at004fb87b; decoder T65] The projection reads
named fields only, not opaque save blocks for native execution. Save byte placement
uses the exact1B55:091D block sequence in tools/data/save.py.

| Field | Read and executable reference |
| --- | --- |
| Current manager and managed club | game[D7D2]+4; DS:DCBA[manager−1], 0006:1197/1B52 |
| Manager name | game+2×manager+3 gives a word into DCCC eleven-byte Pascal entries, 0006:11DE..11F7 |
| Cash | DCC4+(manager−1)×94+82, little-endian32-bit; 0006:1216..1231 passes both words to formatter |
| Current week and displayed season | game+0 and+1; 0006:1197 adds1 for next fixture and year+counter−2/−1 for season |
| First team | D7C2+(club−1)×62, twenty little-endian player words; squad/selection routines |
| Manager reserve list | game+40×manager+48, twenty words; 1B55:6E74 and squad caller |
| Player club/current/club position | D7BA+8×ID +0/+6/+7; 0AB9:8D6F |
| Player name and initial | league offset pair at D7A6+2×ID and name pool D7A2; 1B55:44DC. Initial comes from saved D7AA[ID], as8D6F reads it |
| Team instructions | club record+57; 1B55:3323 and0AB9:8B0B use one-based bit reads |
| Individual instructions | D7BE+15×ID+10, 0AB9:8B0B; lower four choices and upper four override markers |
| Availability observations | player15+8 signed and+11 bits; retained without adding eligibility rules |
| Next fixture | D7CA+club×174+(week+1)×3−177: competition,opponent,flags. 1B55:40DF/4119 and0006:1197; reciprocal opponent row checked |

[confirmed: runs/T65/seed-r0001.json] The coherent seed is Blackburn R130,
manager Dalglish/name130, cash452000, week0, season1994/95, next fixture slot1
against P St Germain17. Competition byte1 and venue code1 correspond to the
captured Friendly#1/home state; the reciprocal row has venue code0. This is a
case-specific correspondence, not a complete venue/competition decoding rule.
The20 first-team slots contain18 players; the20 reserve slots are empty. Full
player identity/name, position and packed instruction values are retained.

[confirmed] The retained T46 save swaps Flowers2581 and Mimms2598, changes
Pearce2582 current position2→1 while club position remains2, and changes Mimms's
packed instructions17→16. Authenticated steps53–54 show stay-in-box P and sweeper
with first-position centre back after fresh-process reload. The full campaign
context (manager/club/season/week/cash/next fixture) stays equal. This is direct
corroboration of save fields, not a port of editing/cycling or tactical effects.

Reproduce synthetic checks with `python3 -m unittest discover -s tests/data -p
 test_campaign_seed.py` (omit the line break). Public verification:
`python3 tools/data/campaign_seed.py --check runs/T65/seed-r0001.json`.
It validates authenticated captures, immutable producer/listing identities and
projection hashes and rejects four corruptions. Regenerating the observation
also needs the owner's supplied96 SAVE1/ENGL-95 and retained T46 archive, using
`--record <new-path> --changed-archive <private-archive>`; bytes remain ignored.

[designed boundary] This is a source-backed seed for native B1 state/persistence.
No finances/week simulation, new original run, arbitrary XI engine admission,
match result, complete skill model, whole-season save compatibility or native
production UI is claimed. Native saves use their own explicit versioned schema.
