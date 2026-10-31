# F25 Original replacement effects include a reached club rearrangement

- **Status**: proposed
- **Task**: T25 (#96)
- **Edition**: 96.
- **Sources**: T24 static map/contract at `7b39558`; original observer at `ddf4357`;
  six completed runs/exports and manifest at `d8a3a27`; reader checks at `1b659a6`.
- **Check**: `python3 runtime/emul/replacement.py --check` uses public decoded evidence.

`[confirmed: six T25 runs at d8a3a27]` All **25 AEB8 replacements** across six
original weeks match T23's argument triples, entry/return projection and draw
intervals. New weeks reproduce full T23/T22/T20/T16 observations, T08 events and
ordered DOSBox-X waits. All replacements and reached direct helpers consume
**zero RNG draws**. Previous evidence is unchanged.

`[confirmed: same runs]` There are **325 direct helper observations**. Each of
AEDF, AEF0, AF01, AF18, AF7F, AFAA, AFB7, AFDA, B00C, B08B and B0C6 is reached
25 times; B077 is reached 50 times. AF5F/ADD0 is never reached. These are measured
call sites from the checked thirteen-site map, not an inferred control-flow census.
All observed replacement sides are unmanaged and D074 is one. Cached-player
availability returns zero in all 25 calls; temporary CF5E substitution/zeroing
through the unavailable-cache branch is therefore not exercised by this corpus.

`[confirmed: same runs]` Outgoing-flag, rebuild, byte6/cache and final-refresh
helpers each change the named projection in all 25 calls. Rating/flag helper 53FB
changes it in ten calls. Season-counter helper 186C changes it in four calls,
all in the allowance-one weeks; the other 21 replacements have allowance zero.
An unchanged named projection does not prove a helper writes no other field.

`[confirmed: same runs]` Final refresh 164F changes full scene rows in all 25
calls, club-total words in sixteen and cached-player identifiers in three.
In **T25-r0006**, arguments **[14, 8, 1]**, it additionally changes T23's **club
rosters, scene projection, event totals and cache selectors**. Thus one actually
reached 164F call is a logical rearrangement, not just an update to scalar caches.
Its detailed algorithm and complete input closure remain to be captured.

`[confirmed: same runs]` Outer scene word2 equals its entry value in all 25
returns. The rebuild helper also leaves that field unchanged in all these cases;
none enters with word2 equal to D2E. `[confirmed: static at 7b39558]` The body
still contains a conditional save/default choice, a rebuild and a later word2
write. The observed equality does not dynamically exercise the alternate save
branch or prove that other inputs preserve the original word2 unchanged.

`[designed: T25]` The expanded projection records typed complete scene rows,
canonical referenced-player P8 fields and P15 word0/bytes2–14, T23's entire named
state, CF5E players, direction bytes, named club totals, D074, D2C/D2E/D32 and A2EC.
It normalizes checked physical pointers to semantic scene/player identifiers,
retains original helper input/output snapshots and meaningful scalar results,
and checks branch footprints, state/draw continuation and immutable provenance.
It does not calculate replacement or callee outputs in Python.

`[designed]` Each direct callee remains opaque. Full typed outer state is not a
claim that every callee's complete read set has been supplied. The next bounded
candidate is the **8663/8599 scene rebuild input closure**, including club-count,
rating/flag and direction helper context. The reached **164F rearrangement** and
**53FB rating/flag closure** remain separate required work before full native AI
parity. ADD0, managed replacement/editor and unavailable cached-player paths need
additional specimens. Physical/render/timer/whole-memory parity and continuous
DD02/match/week/setup remain outside this result. No native task, benchmark or
independent acceptance of F25 is claimed.
