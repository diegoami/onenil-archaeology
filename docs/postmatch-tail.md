# Original watched post-return caller contract

[confirmed: records/T86/tail-r0009.json and tail-r0010.json, producer 1003a58]
The retained late watched checkpoint can be restored and continued naturally
through the match return and the enclosing post-match call. The selected pair
is pinned by records/T86/index.json. This is original96 code under Unicorn,
with the accepted source's watch flag and numeric-background intervention
preserved. It is not a new DOSBox-X run or native composed-caller parity.

## Recovery and watched suffix

[confirmed: same records; accepted native 772cb7ae T45 recovery lineage]
The input is original-r0003/checkpoint-r0047: 4,158 completed ticks and 182,417
draws, paused at 24BC:0C58 inside tick 4,159. The public manifest, start,
frozen observer, reference protocol and private file digest authenticate
before deserialization. Loaded private cursors and reference metadata are then
checked against the pinned public values. The public lineage root is pinned
separately in the recorder. Unicorn 2.1.4 is required for the saved CPU context.

[confirmed: same records, linked to traces/T40/index.json]
The pending tick is preserved. All **41 remaining tick records /394 draws**
match the accepted source; the guest reaches the real `0AB9:EBE2` after
4,199 ticks /182,811 draws with the accepted final-state projection. No
expected observation initializes guest memory, and no new clock/state edit
is made. The public watched reference already exists in this repository;
it is byte-identical to the native reference index used by the old observer.

## The enclosing caller

[confirmed: same records] `EBE2` pushes the parent frame link and calls
`0AB9:E679`. The recorder continues until the actual near return reaches
`0AB9:EBE6`. CS, DS, SS and BP are preserved; SP advances by 4 for return
and hidden argument. The parent frame's week slot is 6, schedule index 16,
and detailed-match flag 1. The scheduled club is 134, opponent 130,
competition byte 0: **this is a league fixture**, distinct from T85's quick
friendly. Both 1897 calls receive 255/255 score arguments.

[confirmed: same records; static 83b7ef7, 1998:1126/10CA/0F7E]
In this specimen, E679's prefix uses the performance-word path. The first
1897 entry is at the same draw cursor and seed as EBE2: **182,811 /15,361**.
It does not consume T85's 44 random prefix draws. These are different
fixtures and inputs, not an experiment changing only a mode bit; the actual
selector values and reached instructions are recorded.

| Observed input | Original location/value |
| --- | --- |
| Performance selector | DS:D075 = 0 |
| Statistical selector | DS:D6DD = 1 |
| Global club pair | DS:D6E4/D6E6 = 130/134 |
| Result bytes at E679 entry | DS:D086/D087 = 1/2 |
| Live goal bytes | DS:D0C4/D0C5 = 2/1 |
| Slot performance words | DS:D146 + 40*side + 2*slot; slots 1–20 |
| Additional win-points byte | DS:DCE0 = 2 |

[derived: observed values and original call sites] The club and score pairs
have different orders. A consumer must retain the live end image and frame
context; it cannot assume byte 0 always means the managed club or initialize
the caller from the displayed/posted score vector. E679 also swaps the result
bytes as part of its two-sided processing.

## Numeric input/output footprint

[confirmed: same records] The enclosing call has **2,691 observed reads and
439 writes**, including writes that preserve a value. There are 482 disjoint
initial operand observations, covering 583 bytes: 563 are read before their
first write; 20 are write-before context only. The latter are not additional
semantic dependencies. The records also contain an independent final-memory
observation for each initial operand and a separately counted event census.

[confirmed: same records] The whole `0x110000`-byte memory comparison finds
205 changed positions, all within recorded write addresses or the declared
scratch-stack window. No changed memory lies outside that footprint. The
records retain hashes and counts, not RAM bytes. The caller produces no new
external service call and no BIOS/game timer interrupt; the observed restored
PIT divisor is 65,535. Hidden stack-link input is explicit; scratch-stack reads
are excluded at hook registration to avoid Unicorn's RETF tracing problem.

| Declared pool | Shape / indexing |
| --- | --- |
| Player8 / Player15 | 3,921 rows of 8 /15 bytes, zero-based player IDs |
| Club | 176 rows of 62 bytes, one-based club IDs |
| Club statistics | 176 rows of 12 bytes |
| Fixture / history | 176 rows of 174 /58 bytes |
| Game bookkeeping | One 247-byte record |
| Club auxiliary data | 176 rows of 46 bytes |
| Staff | 1,001 rows of 4 bytes, zero-based staff IDs |

[designed:T86 contract] Every operand retains its original site, width,
numeric value, field/pool coordinate and draw cursor. Actual pointer words
bind those pools; they are location context, not native business parameters
to copy blindly. Unknown regions/widths and cross-record operands refuse.
The validator reconstructs only the observed byte-state transitions to check
reads, writes and final observations; it implements no game or RNG algorithm.

## Condition calls and other effects

[confirmed: same records] The two first-team callers visit 17 players at
club 134 and 18 at club 130: **35 condition calls /70 draws**. The full E679
scope consumes **103 draws**, ending at seed 51,682. The other 33 draws
belong to caller/helper work; they are not skipped or supplied to a native
algorithm as expected values. Callee input snapshots and numeric writes
cross-check against the enclosing operand audit, with actual near/far returns.

[confirmed: same records] Writes cover player15 fields (261 events), seed
(103), player8 (31), club auxiliary data (15), club statistics (9), game
bookkeeping (8), staff (4), history (2), fixture (2), result bytes (2),
parent-frame score context (1) and club data (1). These counts describe
this source, not a general season rule. In particular, the trace includes
staff-state and league-table effects beyond condition refresh.

[designed:T86 boundary] Per-call condition input/output snapshots include
preserved fields that the CPU need not read on a positive-condition path.
They must not be confused with the minimum caller read set. A future native
port should distinguish required reads, pointer/frame bindings, write-only
context and preserved observations, and retain aliases in the shared image.

## Native work still required

[derived] Native772cb7ae contains the verified 14A5 kernel, not a composed
E679 transition. The next native slice can translate the enclosing helper
closure against these actual inputs/outputs, reusing existing helpers where
their contracts match. It must start with the owned match's real image and
seed, rather than a quick-case seed or a recorded post-call state.

[designed:T86 limits] Incoming-field admission must initialize new dependencies
from authenticated **pre-match** data, not inject later observations into a
continuing engine. Campaign persistence must then carry the computed player,
staff, fixture/table and bookkeeping effects atomically. This task changes no
native or desktop behavior and does not enable week refreshes. Drawn games,
other competitions, injuries and other branches need their own evidence or
explicit refusal; this single watched league specimen is not whole-season parity.

[designed:T86 publication] Earlier stopped attempts r0001/r0002 remain
immutable (undeclared numeric inputs caused explicit aborts). Completed
r0003–r0008 remain bound to their own producers; r0009/r0010 add independent
final-state/census/preservation checks and are the acceptance pair. No private
checkpoint was created or uploaded; existing owner recovery bytes stay private.

```sh
.cache/venv/bin/python runtime/emul/postmatch_tail.py --check
.cache/venv/bin/python -m pytest -q tests/emul/test_postmatch_tail.py
```
