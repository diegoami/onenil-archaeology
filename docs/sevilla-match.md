# T89: the authenticated Sevilla friendly — entry, boot, stream and post-match caller

Task: [docs/tasks/T89.md](tasks/T89.md) · issue [#210](https://github.com/diegoami/onenil-archaeology/issues/210) ·
branch `task/T89-sevilla-capture`. The native boundary this addresses: onenil T90
(c0546abb) refuses the following fixture — "The next fixture (Sevilla) has no
authenticated original match evidence; playing it is unwitnessed."

## What the original does, as evidenced here

**The entry state.** After the authenticated friendly week (T81/T82), the game's
saved state advertises exactly one next fixture: Sevilla/Aragones, Friendly #2,
away (competition 1, opponent 176, flags 0, week index 1 slot 1 — the T82
decode, cross-checked against the management menu text). The capture's entry
gate (`runtime/emul/sevilla_match.py`) refuses any save that is not the pinned
post-week save (sha256 f3aa2e4f…) before emulation begins, then authenticates
the decoded fixture sequence: the played friendly carries its played marker on
both reciprocal rows, the following fixture is the witnessed Sevilla triple,
and the week byte advanced exactly once. The menu projection reads seed 10649
in live machine memory — exactly the T81-decoded saved seed word (boot was
23260). records/T89/entry-r0001.json, produced by
`runtime/driver/sevilla_entry.py` (13.4s session).

**The preparation boundary — the pre-advance finding.** Booting the watched
machine from the preparation savestate (sha256 98275eb5…, private, digest-gated)
and projecting the campaign corroborates the committed evidence (cash 421,491,
the untouched Pearce XI, Dalglish, 1994/95) and reveals: **the original
pre-advances its live context when entering fixture preparation** — the
projected campaign at this boundary reads week_index 2 with the save's own
slot-2 fixture (Celtic, competition 1) as the live next fixture, and the seed
word consumed to 50238 by the preparation's own draw work, while the prepared
match stays bound to Sevilla (176). records/T89/boot-r0001.json publishes the
full projected campaign (projection_sha256 6e1bc987…) — the week-1 analogue of
T65's initial record — including the fixture venue fields for the first time
(flags 0, venue_code 0, opponent_flags 1; the fixture triple's flags byte is
not the venue bit). Native consequence: a native route that plays the Sevilla
fixture must bind the prepared match's own context, not the pre-advanced live
pointer.

**The match stream and post-match caller.** `capture()` drives the actual
original from the pinned savestate, delivers PLAY GAME, joins at the watched
loop header and records ticks/draws/actions into digest-chained chunks
(structurally validated like the T40/T67 machinery); at the EBE2 match return
it records the boundary and installs the T88 numeric observer and condition
recorder, whose E679→EBE6 hooks observe the original's own post-match
condition-update caller (typed reads/writes, preservation, timer and service
effects). No expected stream exists for this match: the entry state is
recorded, not verified, and only structural chaining is enforced.
`check_capture` publicly re-validates a capture directory (producer census
against the capture's own commit, chunk-chain replay, result identities, the
boot anchor, the caller block) without any private file.

**The result (runs/T89/sevilla-r0001, 4.25h wall):** the full natural match —
**3,927 ticks, 169,996 draws, 855 actions, final score Blackburn 1–1 Sevilla** —
joined at entry draws 0, match return at 0AB9:EBE2 (draw 169,889, seed 12917),
followed by the original's post-match caller under the sealed observer:
**2,275 reads, 409 writes, 431 initial fields, 36 condition calls in 2
contexts** (the same 36/36 condition signature T88 established for the fresh
route), preservation 169 changed bytes with **zero unexpected** — every
changed byte is a recorded write — and no external service inside the caller
scope. `check_capture` verifies the whole directory: ticks 3927, draws 169996,
actions 855.

## The emulated-hardware restoration (declared, not hidden)

The DOSBox savestate format cannot carry the timer chip. The game programs the
PIT divisor to 0x400 for every match at 1998:0096 (guest.py's F06 contract;
the fresh route's live machine carries divisor 1024 mid-match); that write
precedes the restored savestate point. boot() therefore restores
divisor=0x400 with exactly the retime semantics of the game's own write, and
every capture start declares this as `emulated_hardware` — `check_capture`
refuses a start without it. This restoration is what makes the capture a
faithful machine: without it the game clock runs ~64× slow (zero timer ticks
at boot) and the match crawls (162.6s/tick measured) on a machine the original
never ran. With it: 3.4s/tick, byte-same stream content on the comparison
smoke.

## What stays refused

Nothing here generalises: one friendly match. The week-0 PSG stream and caller
do not transplant; the checker refines only from observed reads. Edited-lineup
and halftime variants, league play, scheduler claims and season rollover all
remain unwitnessed and refused. Native admission of this fixture is a separate
frozen task that consumes these records.

## Provenance

- Entry save: owner-local, sha256 f3aa2e4f… (T81 session r0007 timeline;
  byte-identical local repeats r0003–r0008). Never in git.
- Preparation savestate: owner-local `.cache/T89/states/`, sha256 98275eb5…,
  digest-pinned in the committed records. Never in git.
- Public records: records/T89/entry-r0001.json (+progress sidecar),
  records/T89/boot-r0001.json, records/T89/fail-before.json, and the capture
  directory committed as runs/T89/sevilla-r0001/ (62 digest-chained chunks +
  start/finish/index; 3,927 ticks / 169,996 draws / 855 actions).
