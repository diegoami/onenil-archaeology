# F21 The named quick52B6 reset has complete raw input and intermediate cases

- **Status**: proposed
- **Task**: T21 (#88)
- **Edition**: 96.
- **Sources**: listing at `256659e`, `static/1-0-exe/quick-reset.md`; observer
  `quick_reset.py` at `8312afb`; six completed original runs/exports at `0100325`.
- **Check**: `python3 runtime/emul/quick_reset.py --check`; public decoded records suffice.

`[confirmed]` Six new original weeks reproduce the full T16/T20 observations, T08
events and ordered DOSBox-X waits. Their 17 reset calls contain 374 ordered word8 copies,
374 motion visits, 374 eligibility checks and 373 byte6 helpers. Every keeper-prelude and
strategy boundary is recorded, including all 12 original draws. Strategy cases link literally
to T20, with source/state/record/export digests pinned. All earlier evidence is unchanged.

`[confirmed]` Inputs include raw scene word0/8/10, slot/player and motion, actor/clock/
zero/alternate fields, physical offsets and signed direction table, canonical player byte6/8/
flags11, cache context and complete strategy context. Entry player eligibility fields and
scene word0/player identities match the actual retained prefix. Intermediate snapshots
show the strategy executing after the keeper prelude, before final player updates.

`[confirmed]` The actual resets have nonkeeper actors and take the nonzero-work branch
with zero flag 0. Keeper replacement and zero-short-circuit branches remain static-only
evidence here. The full word8 copy runs before the zero test. Motion marking uses the old
actor's physical side and each scene's stored slot, excluding physical keepers1/12. The
strategy updates flags10; final availability separately reads byte8/flags11. Cache flag 0
retains cached values while ordered byte6 stores observe earlier shared-ID mutations.

`[designed]` Native T09 translates this complete named quick logical projection, including
statically tested keeper pair/sign/kind logic, cyclic availability resolution and zero branch.
Strategy must run on the actual computed seed after keeper draws, never a supplied expected
intermediate snapshot. A keeper cycle with no eligible replacement diagnoses transactionally
rather than imitate an infinite original loop. Placement/prefix composition guards all
computed shared fields; byte6/cache/clock context not computed there remains raw input.

`[designed]` Preceding 045C buffers/rendering and goal-effect integration, 6B2F substitutions,
78B7 keyboard, continuous DD02/match/week/setup and arbitrary physical/scratch/timer/render
parity are separate work. Matching this reset projection is not full-step parity. F21 remains
proposed until independently checked and accepted.
