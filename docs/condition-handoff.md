# Original96 quick-week condition handoff

[confirmed: records/T85/handoff-r0003.json and handoff-r0004.json,
producer 0ac2fa0; native-r0001.json, native 772cb7ae] Two fresh Unicorn machines
continue the original from the retained T04-week-r0012 start state. They
reproduce the complete T08 event stream, all **23,006 draws**, and the ordered
**10 DOSBox-X key waits**. The source is the first quick friendly against
P St Germain, not the watched T81 week or a new DOSBox-X execution. Both fresh
records are byte-identical. Read-only hooks observe the original naturally
reaching `1998:14A5`; no controlled input, seed or output is injected.

## Observed scope and caller order

[confirmed: same records] There are **176 first-team `1897` visits**, one per
club, containing **3,028 complete `14A5` calls**. Both native caller flags occur.
The observed slot/flag agrees with the listing: one-based slots 1–11 or a
later player with status mask `0x04` use flag 1; other later slots use flag 0.
Zero roster words are skipped. The records retain the full 20-word roster,
actual slot, pre-call status and flag, rather than reconstructing them from
the post-week save or the player's current position.

[confirmed: same records; static at83b7ef7, 01EF:4E14–4E2C] After those
first-team visits, the week invokes `16B1` for manager 1 and manager 2. Manager1
is active at club 130, but its separate manager roster contains twenty zeros;
manager 2 is inactive and its roster is also empty. Neither visit calls `14A5`
or consumes RNG. The recorder also watches direct `13F9` entries outside `14A5`:
there are none in this week. These empty observations do **not** establish
the behavior of populated manager rosters or a naturally reached nonpositive
condition branch. T84's nonpositive coverage remains controlled-call evidence.

## Shared RNG and memory effects

[confirmed static: 83b7ef7, code/seg_0AB9_22.asm EBD2–EBE6;
native772cb7ae, watched_compiled/watched_match.rs] The owned match's
`0AB9:EBE2` return precedes post-match processing: EBE2 pushes the parent
frame link and EBE3 calls `E679`. The native match therefore stops before
this outer caller work; a condition call is not the next direct operation.

[derived: retained T08 match-return mark and first T85 caller scope] The
quick match returns after draw 5,853; the first `1897` visit starts at 5,897,
with seed 3,910. Thus **44 intervening draws** precede even that caller's
entry. The native live return seed cannot be replaced with 3,910 to bridge
the gap. The enclosing `E679` prefix, its frame/state dependencies and the
later `1897` helper effects must be established for a composed implementation.
This static call boundary does not establish watched-mode numeric inputs.

[confirmed: same records and literal T08 draw slices] The 3,028 calls own
**6,056 draws**. Their complete complement contains **16,950 outside draws**;
none is discarded or assigned a fabricated value. Caller scopes together
contain 8,247 draws: 6,056 inside `14A5` and 2,191 in other caller/helper work.
The remaining 14,759 draws occur outside those caller scopes. Call spans,
caller entry/exit seeds and each numeric write are linked to the retained
stream. The independent T08 call-site attribution also accounts for every
condition draw, so dropping a call cannot pass by retaining the others.

[confirmed: same records] Each call records actual scalar inputs, ordered
draws, output and numeric writes (field, width, previous/new value). It also
records entry and actual caller-return registers. For these calls CS, DS,
SS and BP are preserved; SP advances by 6 for the near return and arguments.
Other registers are recorded as observations, without a preservation claim.
Outer caller returns are observed after the actual far return too: `1897` pops
10 bytes including its return address; `16B1` pops 6. This is an observed ABI
contract for these specimens, not a full register ABI for unexercised paths.

[confirmed: same records] The managed keeper enters with base condition 10
but match-depleted condition1, then leaves with 11. Pearce enters with base 31
and current 14, then leaves with 31; Gale enters 17/17 and leaves with 18.
These differ from the watched-week endpoints (for example Gale 19 in T83).
Copying that watched week's values or adding a constant to current condition
would fail to reproduce this quick-week observation.

## Initial field dependencies

[confirmed: same records, start-state841b0d3f…; pinned save6ef61bcf…]
The 18 managed first-team players' initial fields agree between start memory
and the pinned private save. The separate manager roster is empty. Exported
fields needed by the routine are:

| Field | Original location |
| --- | --- |
| Club, age, age reference | `[D7BA]+8*ID +0/+1/+2` |
| Base/current condition, recovery byte | `[D7BE]+15*ID +7/+8/+14`, signed bytes |
| Club's staff ID | `word([D7C2]+62*club-18)` |
| Staff dependency byte | `[DCC8]+4*staff_id+2` |
| Original caps | DS:0D72/0D73, 32 and 25; program data, not serialized save fields |

[confirmed: same records] Club130 resolves staff ID 530 and byte 140. The
call records retain each reached staff identity as well as the facility-byte
input; the initial export retains the club/staff mapping for future image
admission. Public checking authenticates these retained observations by
file/producer/source digests and a fresh repeat; private bytes are required
to re-decode the new initial fields. The known initial condition values are
also checked against the independently retained T83 decode. Public validation
does not pretend to reconstruct private save bytes from a hash.

## Native replay and limits

[confirmed: records/T85/native-r0001.json] A minimal Rust IO probe calls the
accepted native 772cb7ae routine with **only the observed input**. All 3,028
outputs, 6,056 ordered draws and numeric writes match. The receipt pins the
native commit/tree, observer/probe code, lockfile, binary digest and build
settings. No expected output enters the Rust process. The Python tool only
decodes observations and compares results; it implements no refresh or RNG
model. Native draw-site labels are excluded from the numeric comparison.

## Remaining caller effects

[derived: literal T08 draw slices within T85 caller scopes] The 2,191
non-condition draws inside `1897` are fully attributed:

| Original return sites | Observed draws | Work still outside the native condition port |
| --- | --- | --- |
| 1998:19C5 /19CD | 1,088 R(4) and 1,088 R(2) | Unused later-slot p15+6 update, clamped through `0DAE` |
| 1998:1999 /19A1 | 4 R(2) at each site | Used later-slot p15+6 update |
| 1998:15EB | 7 R(4) | 154E's optional p8+4 branch through `24BC:0D1C` |

[confirmed static: 83b7ef7, code/seg_1998_02.asm 0DAE–0DD2;
code/seg_1998_03.asm 154E–15F7,186C–1894,1897–1B98;
code/seg_1B55_08.asm 5284–5357] Further non-RNG caller effects include
guarded p15 counter writes through `186C`, p8+3/+4 updates and the `5284` helper,
p15+11 bit transformations through `12BE`, and p8+6 restoration from p8+7 for
non-managed later slots. The post-loop goalkeeper/scorer branches have
additional counters, p15+6 updates and RNG guarded by D6DD and the score
arguments. Their complete input/output contract is not supplied by `14A5`'s
case alone. No claim is made that these writes are absent simply because
they are outside the condition observer's active window.

[designed:T85 boundary] A composed `1897` port therefore needs these additional
field/flag/helper contracts and their natural entry/exit observations. The
outside-draw table is evidence of the gap, not permission to consume expected
draws or copy expected helper outputs in an implementation.

[designed:T85] This is **per-call replay**, with each observed entry seed
admitted explicitly for that isolated call. It is not a composed native `1897`
or week replay. The outside draw partition identifies the remaining work;
it must never become a ledger that drives a supposedly native caller. Other
caller effects, live initial-field admission, manager-roster processing,
campaign persistence and watched-mode branch checks remain separate work.
The native campaign's documented week-refresh exclusion remains in force.

[designed:T85] Current acceptance selects handoff-r0003/r0004 and native-r0001
through records/T85/index.json. Earlier completed r0001/r0002 remain immutable
at producer ba6d818; the refined pair adds staff identity and actual outer
return observations. No existing T83/T84 record or original byte was changed.
Loaded `1998`/`232A`/`24BC` segments are checked before/after against the pinned
unpacked executable with actual relocations applied. No new private snapshot
was created or uploaded.

```sh
.cache/venv/bin/python runtime/emul/condition_handoff.py --check
.cache/venv/bin/python -m pytest -q tests/emul/test_condition_handoff.py
```

[designed:T85] Reproduction needs the private T04 source savestate and original
game folder described in docs/artifacts.md. A new --run always writes a new
record; current acceptance files are never overwritten. Native re-execution
uses a clean checkout of 772cb7ae and a new comparison receipt:

```sh
.cache/venv/bin/python runtime/emul/condition_handoff.py --run records/T85/handoff-NEW.json
.cache/venv/bin/python runtime/emul/condition_handoff.py --native-run records/T85/native-NEW.json --native-root .cache/T85-native-source --source records/T85/handoff-r0003.json
```
