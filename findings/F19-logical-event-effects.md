# F19 69B8's recorded quick logical effects have complete named input cases

- **Status**: proposed
- **Task**: T19 (#84)
- **Edition**: 96.
- **Sources**: listings at `59eb0c4`, `static/1-0-exe/event-effects.md`; producer
  `event_effects.py` at `beda0c7`; completed original runs T19-r0002/r0003 and exports
  at `2e80bdd`. T19-r0001 retains an earlier original run whose export failed; it is not
  counted as a completed case source. Prior T17/T18 observations remain immutable.
- **Check**: `python3 runtime/emul/event_effects.py --check`; public decoded records suffice.

`[confirmed]` Two new original weeks reproduce the complete retained T17 call stream,
T08 events and ordered DOSBox-X waits. Their 22 69B8 calls contain 44 independent cyclic
selector calls and 17 LCG draws. Inputs/returns link literally to T17's DBC6 dispatch
and return projections and T18's separate raw lookup cell. Each case contains full named
roster/shared player, scene, selector, numeric queue/cache/counter, clock/reset and pending
flag state. Input and output snapshots retain the same selector-cell/queue-row identities.

`[confirmed]` The observed closure calls 63E3 five times and 6589 once. It emits six numeric
events and records 23 ordered helpers: 11 availability checks and 12 shared-player byte6/cache
updates. It never calls 6849, A837 or A94B. The sole 6589 call uses the managed-club path,
sets a player's flags, changes a physical scene word, applies -2 to that player and +2
sequentially to available players on the opposite side. Expected helper outputs and numeric
acceptance flags are observations only; they are not legitimate native inputs.

`[confirmed]` 19A0 consumes a pre-generated cyclic byte stream at CF71+head and advances
head independently of the LCG. Both reads are captured, including their actual values and
head transitions. 69B8's first read chooses an immediate handler or a random32 chance;
its second may choose the still unobserved injury path. The static contract distinguishes
this stream from RNG seed updates and gives the correct one-based player flag masks.

`[confirmed]` 1DE2 uses the secondary physical index for its event-side test and swaps
the normalized actor/secondary slots relative to goal helper1DB7. Numeric acceptance controls
queue/count/pair writes; a rejected duplicate would still receive the signed weighted update.
63E3 and 6589 retain logical writes reached through display helpers. Quick scene6305 resets
word0/word8/word20/motion and CF53 while preserving active/control on return.

`[designed]` The native projection must compose the actual T06 request, guarding every
shared seed/actor/scene/player/club field. It covers the observed quick logical domain and
statically read managed injury behavior. AI roster-changing branches diagnose transactionally
until separately translated; they must never become silent no-ops. Unobserved branches need
explicit static/synthetic tests. Formatted text, display buffers, timers, scratch/physical
aliases and complete DD02/match/week/shared-stream setup parity remain outside this claim.
F19 stays proposed until independently checked and accepted.
