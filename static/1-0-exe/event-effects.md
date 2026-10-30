# Logical 69B8 quick effects (T19)

`[confirmed]` Read from the 96 listing at `59eb0c4`: `seg_0AB9_11.asm` 63E3..6A79,
`seg_0AB9_03.asm` 19A0/1DE2/1E28, `seg_0AB9_02.asm` 0D7E..0FFD,
`seg_0AB9_10.asm` 6305, `seg_1B55_02.asm` 0E7A, `seg_1B55_08.asm` 53C6,
and `seg_1998_02.asm` 1394. F17/F18/native T06 establish the entering DBC6 request.

## Decisions and independent cyclic selectors

`[confirmed]` 69B8 reads secondary scene D0A0 and consumes `19A0` at return69D3.
That helper reads byte `CF71+word[D072]`, advances the head (255 wraps to1), and
returns the zero-extended byte. It does not draw the LCG. Values below4 choose
63E3 unless the secondary player's flags11 one-based bit5 is already set, in which
case they choose6589. Values at least4 draw `0D1C(32)` (return6A15); true chooses6589.
The second selector call returns at6A25. Value1 compares secondary then actor player
thresholds via4E0C; unsigned actor threshold strictly greater chooses the secondary
scene for6849, otherwise it chooses the actor scene. The current pool head is a separate
stream input, not a value reconstructed from the LCG or an expected decision.

## Numeric effects

`[confirmed]` 63E3 emits numeric event50 through1DE2, sets player15 flags11 bit5,
increments byte D0D9+10*scene_side and increments added word D0B4 only below5.
If player8 club byte0 equals neither DCBA nor DCBB (0E7A), 53C6 sets player15
flags10 bit8 and clears bit4. These are one-based bits: masks10h,80h and08h.

`[confirmed]` 6489 uses the scene's slot<12 side. A managed club checks only the
zero-extended dismissal+injury count sum<3. An unmanaged club also requires more than11
available players among its20 roster entries. 6589 exits when this fails. Otherwise it
emits event51, sets flags11 bit6 and clears bit5 (6549), increments dismissal count,
clears the scene addressed by its byte+7 via6305, caps the added-time increment,
applies67D0(delta=-2,cache=1) to its target, then visits the opposite11 scenes in
physical order, applying67D0(+2,cache=0) only when1CA1 says available. Shared IDs see
earlier mutations. A managed target sets D6E2 when player8 position byte6 is zero.
Unmanaged targets can reach A837/A94B roster/scene rearrangements; those are engine
effects, not discarded display work.

`[confirmed]` 6849 first checks target availability and6489. On acceptance it emits
event52 through1E28;1394 zeros player15 byte8, draws with wrapping word bound
`20 - zero_extend(4E0C(player))` at return1998:13EE and stores the low result byte
at player15+14. It calls6305, applies67D0(-2,1), conditionally increments added time,
and increments injury count. A managed target sets D6E2 when player8 position is zero
or the side's D6E0 byte is zero. Unmanaged targets can invoke A94B and remain a separate
translation boundary. No recorded injury branch is assumed before capture verifies it.

`[confirmed]` 6305 accepts a physical scene index, obtained here from the target
scene's byte+7. If its word0 already equals D2E, it changes nothing. Otherwise in quick
mode it sets CF53=1, writes word8=D30 and word20=0, ends motion byte19 at0 and sets
word0=D2E. Active D0B8 and control D0BA are temporarily cleared then restored. Rendering
and timer waits in nonquick mode are outside this projection.

## Selectors, aliases and snapshot boundaries

`[confirmed]` 1DE2 differs from goal helper1DB7: it uses the secondary physical index's
below12 test as event side, the secondary scene's normalized slot as **actor_slot** and
the actor scene's normalized slot as **secondary_slot**. 1E28 instead uses its target
scene's side/normalized slot and secondary_slot0. Numeric0F94 always adds the signed
event weight, while acceptance controls queue insertion, accepted-event count and paired-word
copy. The T14 numeric contract applies; dedup does not suppress weighted updates.

`[designed]` Capture both initial selector cells and four queue rows at the entry-selected
indices. Preserve these indices in all intermediate/return snapshots while heads advance.
Named fields include full roster/shared player definitions, scene reset fields, eligibility
and managed-club inputs, cache/event matrices, raw weights, counters, added time and pending
flags. T17's full decision-state projection is retained as `handoff`, with duplicate shared
fields required to agree. Expected selector/helper/event results remain observations only.

`[designed]` Native T07 covers the observed quick logical projection and statically read
managed paths. Reached AI rearrangement calls return explicit transactional diagnostics until
separately translated. Formatted text, display buffers, asynchronous timers, scratch/physical
aliases and full DD02/match/week parity remain external.
