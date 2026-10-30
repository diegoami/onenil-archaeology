# Named quick52B6 reset (T21)

`[confirmed]` Listing at `256659e`: `seg_0AB9_09.asm` 5267..537B,
`seg_0AB9_08.asm` 4F95..5082, `seg_0AB9_03.asm` 1D3A/1F5E/1ECC,
and T14's 67D0 helper. T20/F20 specifies the A4F2 closure. This is a named
quick-mode projection; timer waits and display-buffer writes stay external.

`[confirmed]` 52B6 sets D0B8=1, calls the display/wait helper, then copies scene
word0 to word8 for all22 physical scenes. It saves D1CA and skips the remainder when
D0B9 is nonzero. Otherwise5267 marks motion byte19=6 when its scene's stored slot<12
test equals the actor physical-index<12 test, except physical keepers1/12; all other
motion bytes become0. It then calls4F95 before calling A4F2 with the ignored boolean
argument !saved_D1CA.

`[confirmed]` Quick4F95 handles a keeper actor specially: 1F5E transforms that
scene's word10 pair, stores word8, draws random10 at return4FDF, adds1 and the current
physical side offset, stores the new actor, and calls1D3A. Resolver1D3A repeatedly checks
the current actor via1CA1; while unavailable it advances cyclically through that side's
offset+2..offset+11 range. Once eligible, the common quick path copies the selected
actor's word0 to word8. Motion marking happens before actor replacement.

`[confirmed]` Pair transform1F5E independently sign-extends each byte of its word
argument, multiplies by the sign-extended byte returned by1ECC and retains the low byte.
1ECC compares zero-extended remaining to sign-extended kind as32-bit signed values,
XORs that result with the scene slot<12 side and reads byte A338+index. Negative kind
bytes therefore do not behave like unsigned words. The same raw table supplies the
later signed player delta; it is captured rather than assumed to contain +/-1.

`[confirmed]` After A4F2,52B6 visits all22 scenes in order. It skips1CA1-unavailable
players. For each available one it calls67D0 with cache flag0 and a sign-extended table
byte: index is whether scene slot-side equals the current actor physical-side, inverted
when live D1CA is nonzero. Player byte6 reloads signed and clamps as specified by F14;
repeated IDs observe earlier writes. Flags10 changed by A4F2 do not replace the separate
availability byte8/flags11 inputs. Cache values are observed but not written on flag0.

`[designed]` Capture entry/return, every copy/motion visit, keeper input/output, strategy
input/output, ordered availability/byte6 helpers and the literal T20 strategy case. Keep
complete raw scene word0/8/10, slot/player and motion fields, canonical player records,
clock/kind/zero/alternate, side offsets, table signs and cache context. Python only reads
addresses and joins observed values; native Rust computes the reset and strategy effects.

`[designed]` Native T09 uses physical offsets [11,0] and diagnoses a keeper cycle with
no eligible replacement transactionally, rather than imitate an infinite original loop.
It composes actual placement/prefix seed/actor/score/club/scene/eligibility fields; byte6,
cache and clock context not computed by that prefix remain legitimate raw inputs. Strategy
runs on the actual computed post-keeper seed, never an expected intermediate snapshot.
Preceding goal-effect/buffer work,045C rendering,6B2F substitutions,78B7 keyboard behavior,
continuous DD02/match/week/setup and arbitrary physical/scratch/timer/render parity remain
separate work. Original keeper/zero branches are not claimed until captures establish them.
