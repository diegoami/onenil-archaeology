# Managed halftime replacement boundary

[confirmed: source011a341] The illustrated original procedure is W028 in
[the watched-match manual](manual/watched-match.md), T48 steps35–46. This task
adds numeric observations around that transaction, separately from full-match
parity and native desktop replacement support.

## Executable control path

[confirmed: source011a341, static listings] The original interval routine
[7DD3](../static/1-0-exe/code/seg_0AB9_13.asm) sets DS:D0BA=1 at7E0D,
shows statistics and calls D5D6 at7E4C when D1CB is nonzero. The live bench's
Space branch D86A..D872 enters D1DD. D1DD identifies the managed club through
DCBA/DCBB, sets config+4 to1/2 and calls CBF0 with1; an unmanaged inspected side
instead reaches AD43. See [D1DD/D5D6](../static/1-0-exe/code/seg_0AB9_20.asm).

[confirmed: same listings] In [CBF0](../static/1-0-exe/code/seg_0AB9_19.asm),
CEBA normalizes the key. Enter with0D18 nonzero follows CED4: a nonzero D0BA
and positive unsigned capacity (1B55:4759) call C866. Without that interval
control, CEEE..CF09 toggles D6E2 request state instead. Left/Right list-mode
selection atCF11..CF27 is also conditional on0D18 being zero. Thus a pre-match
move, live request and halftime replacement are distinct operations.

[confirmed: same listings] C866's first invocation checks the selected nonempty
roster slot, reserves and keeper-related eligibility, then stores the selected
slot in its parent's BP-0C and sets pick mode BP-0A. A later invocation clears
pick mode, requires the selected and saved slots to lie on opposite sides of
slot12, and computes their minimum/maximum. Additional eligibility/refusal
helpers run before the actual mutation. These branches require their own test
coverage before broad native admission; this case does not establish every
keeper, unavailable-player or exhausted-quota branch.

[confirmed: same listings] The successful closure atCA95..CAC4 exchanges the
selected two-byte roster entries through24BC:0203. CAC9..CB04 exchanges their
two-byte D146+40*side+2*slot accounting entries, and CB09..CB40 exchanges
one-byte D197+20*side+slot accounting entries. CB45..CB61 calls AEB8 with the
side, offset[side]+maximum slot and minimum slot. CB64 clears D6E2. Existing
[replacement evidence](../static/1-0-exe/replacement.md) owns AEB8's scene and
player effects; it must execute against the continuing native match image,
not be replaced by a cosmetic swap in the viewer.

## Observation and verification

[designed:T74] The observer runs the original supplied96 game in a fresh isolated
DOSBox-X2024.03.01 process, waits at actual halftime, then uses ordinary keys.
It reads original savestates without memory patching. The selected player is
verified from the original highlight before each confirmation; adaptive Down
keys are retained explicitly. Numeric state includes selected clubs/rosters,
player role/condition/instruction/status fields, all22 scene records, match
clock/score/seed, replacement controls/capacity inputs and slot accounting.
Savestate and decoded-screen digests bind each read; no private bytes enter git.
The bounded projection is not a claim of complete raw-memory parity.

[designed:T74] Cancellation must preserve this entire gameplay projection.
Confirmation must exchange exactly Pearce/Gale, reduce original capacity once,
preserve clock/score/seed and return to an advancing second half. Independent
fresh sessions compare those transaction invariants; their first-half state and
outcomes need not be identical. This is not a full substituted-match reference.

```sh
python3 runtime/driver/halftime_replacement.py --run runs/T74/session-NEW.json --scratch /tmp/onenil-T74-NEW
python3 -m pytest -q tests/test_halftime_replacement.py
```

[confirmed: local startup attempts] Immutable sessionsr0001–r0003 retain startup
failures. The first used an obsolete local Xvfb binary whose configured keyboard
compiler had disappeared. The next two hit the existing T04-documented DOSBox-X
savestate crash during SAVE1 loading. The observer now applies the established
three-second boot and SAVE1-load waits; the local run uses system Xvfb. Neither
failure is evidence of a completed match or replacement transaction.

## First successful numeric transaction

[confirmed: runs/T74/session-r0005.json, producer047b70b]
The genuine interval reached elapsed46. Cancellation and selection of the reserve
left the full bounded gameplay projection unchanged. Confirmation exchanged
roster slots2and12 (zero-based1and11), I Pearce2582 and T Gale2592. The active
physical scene2 now identifies2592, while scene22's word20 target reference also
changes2582→2592. The outgoing player's status changes0→4. Selected scene cache
fields are rebuilt; the managed reserve count decreases7→6. Original displayed
Remaining subs agrees7→6. Clock, score and seed remain unchanged across the
transaction, and the second half advances to elapsed47 after PLAY GAME.

[confirmed: same record] `runs/T74/transaction-r0001.json` lists all14 changed
leaves in this projection, including the two roster entries, four selected-scene
byte fields, scene player/target identities, outgoing status, reserve count and
four slot-accounting cells. These are this execution's changes; the projection
is bounded, and unknown/raw memory is not asserted unchanged.

[designed] Native integration should retain one owned engine image at the interval,
execute this editor/closure against that image and resume the second half from it.
The current complete-timeline viewer cannot implement this by changing its already
computed frames. A separate native pause/resume task must preserve the existing
no-substitution full-match traces before a replacement transaction is admitted.

[confirmed: runs/T74/session-r0006.json, producer18b13c3;
repeat-r0001.json] A separate fresh original process repeated the entire
procedure. Its halftime, cancellation, before-confirmation and after-confirmation
numeric projections equal the first execution. Both sessions resume to elapsed47.
The receipt records equality per stage without asserting full intervening ticks
or RNG draws. The public test authenticates both records, the independent repeat
and every retained delta leaf;19 synthetic corruption/contract checks plus that
real-record check cover the transaction and producer guards.

```sh
python3 runtime/driver/halftime_replacement.py --check runs/T74/session-r0005.json runs/T74/session-r0006.json
```

[confirmed: runs/T74/session-r0004.json] The earlier watched attempt timed out
before halftime because tightly spaced savestate observations left too little
uninterrupted play. It is retained as failed. Successful captures space reads
by2seconds and use a bounded900second halftime wait; game speed/cycles and game
inputs are unchanged. No old observation was edited or replaced.
