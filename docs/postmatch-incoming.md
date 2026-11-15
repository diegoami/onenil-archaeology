# Early original fields for post-match admission

[confirmed:records/T87/incoming-r0001.json and incoming-r0002.json;
producers0a6e293/2edd077] Two fresh original96 machines restored the accepted
T40/T45 start, SHA2f634978859f7c07b3519e4278d8aaf70c2c70b93ad48362408fbcfa210576a1,
and stopped at actual0AB9:E24C, before the19CA call. Both payloads are exact
equals. They observe the482 T86 field coordinates, covering583 bytes, through
current original pointers and the real parent frame. They contain numeric
values and digests; no RAM, save, executable or font bytes are exported.

[confirmed:same records; accepted T40 index30a4fe8003f4677c2e2af0966d5fe81055c728a1b41c998a9d03766637414886]
The original has executed zero RNG draws at this boundary; the prefix digest
binds the empty prefix of the accepted complete stream. The fixture is the
same league source as T86: week slot6, schedule index16, scheduled club134,
opponent130, competition0 and detailed flag1. It is distinct from T85's quick
friendly and must be reconciled with the selected native route before admission.

| Actual early context | Observed value |
| --- | --- |
| E1F2 frame BP | 16070 |
| Saved parent BP | 16092 |
| Near return | EBE2 |
| E1F2 week/club arguments | 6 /134 |
| Parent offsets | detailed −7; before-context −6; schedule −2; week +6 |
| Raw seed before19CA | 65341 |

[confirmed:same records; static0AB9:19CA–19ED atba499b9]
The first accepted RNG draw starts from64, not the raw pre19CA seed65341.
19CA reads the game configuration and stores a setup-owned seed at19ED
before drawing. The existing native setup also computes that transition;
these early observations do not authorize resetting a continuing image to an
observed late or exit seed. The late T86 caller seed is15361, a third phase.

[confirmed:same records] Loaded original0AB9,1998,1B55,232A and24BC segments
were compared to the pinned unpacked original with actual relocations before
execution and at the stop; their digests are unchanged. All14 supplied game
file digests equal the accepted96 inventory atrecords/T01/inventory.json,
SHA6c82541c7adf26f806b7cb3304f3f964f6066f2e0ac7e0b54b2c4d6a416b06a5.
No unsupported guest service occurs. The only retained intervention is T45's
watch flag atE24C: game+242 becomes1. Whole-memory hashes and changed-address
checks show no other capture-side write, and the callback advances no clocks.
The background initializer and watched match are not reached in these runs.

[designed:T87] `postmatch_incoming.requests()` discards every late value and
uses only T86's field coordinates and widths. DS and pool fields retain their
original identities; frame coordinates become offsets from the actual saved
parent, independent of the original numeric address. Pool geometry, original
pointer words, seed pointer, source/fixture/frame identity, field census and
numeric domains are checked. Producer hashes authenticate files from each
producer's committed tree. The T86 validator now uses that historical tree
rather than today's growing recorder list; old records remain unchanged.

[designed:T87 public contract] `--check` authenticates both immutable leaves
against the consumer's sealed SHA256 pins and validates their source, producer,
coordinates and exact repeat. Numeric observations cannot be authenticated
merely by recomputing a payload hash: a consistently altered value fails the
accepted leaf digest. The internal `validate` helper checks consistency; an
importer must use the sealed `check`/`check_leaf` entry. Public checks execute
no original code and require no private game files. Accepted leaf digests and
producer identities are also retained inrecords/T87/index.json.

[confirmed:comparison of these early observations with accepted T86]
71 of the482 values differ across the two phases. Examples include the result
word, previous-result history, performance selector, live goals, player form,
performance words and seed. This comparison measures differences only.
**Equality does not prove that a field was unchanged or establish who owns its
initial value.** Round trips and writes preserving a value remain possible.
The20 write-only context bytes in T86 remain audit context, not newly proved
semantic dependencies just because they were observed early.

[designed:continuing native work, diegoami/onenil#189] The existing native
prepared image relocates pools, uses DS0 and synthetic parent0 at its EBE2
return. T83's isolated caller-entry replay uses original bindings. The next
bounded native task must classify these early observations against already
admitted/computed state, admit only authenticated incoming dependencies,
resolve pointer/frame relocation and preserve the actual EBE2→E679→EBE6
handoff. It must retain a genuine failing integration and match original
caller effects from a continuing start. No late/output snapshot may initialize
that image. Campaign persistence and enabling weekly player updates remain
subsequent gates; this research changes no native behavior.

[confirmed:T87 record history] r0001 completed the original capture, then its
first post-capture validator wrongly equated the early seed with the first
reference draw's seed. The record was kept unchanged. The original19ED store
explains the distinction; the corrected public checker validates the observed
pre19CA phase. The independently restored r0002 has the identical payload.

```sh
.cache/venv/bin/python runtime/emul/postmatch_incoming.py --check
.cache/venv/bin/python -m pytest -q tests/emul/test_postmatch_incoming.py
```
