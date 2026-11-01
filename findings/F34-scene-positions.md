# F34 Original scene-position stores restore the same final state in two calls

- **Status**: proposed
- **Task**: T34 (#115)
- **Edition**: 96.
- **Sources**: T28/T33 merged at `0f66bad`; observer/static producer `a888111`;
  original `runs/T34/T34-r0001.json` and decoded exports `1ba264e`.
- **Check**: `python3 runtime/emul/scene_positions.py --check`; no private bytes.

[derived: listings at0f66bad,0AB9:3155–325E]3155 has no child calls or RNG.
Its logical input set comprises D56 side offsets,scene.word14/canonicalP8+6,
actual indexed0A3A+2*position words and A338/A339 sign bytes. It assigns each
side's eleven scene.word10 values,then adjusts adjacent duplicate positions.
The wide branch changes the current low byte and previous high byte; the near
branch changes both low bytes. Arithmetic wraps as separate bytes. The full
static contract is in [scene-positions.md](../static/1-0-exe/scene-positions.md).

[derived: same graph] The initial3159 uninitialized-byte read seeds BP-6 via
an indexed D56 read. Its result cannot affect named outputs:31E3 skips every
use on the first scene of each side,and3246 replaces BP-6 with that scene's
index before the next iteration. The side local is initialized before the loop;
byte offsets cannot make offset+1 exceed offset+11 by16-bit wrap. This is
output independence from that initial scratch value,not a claim about the
addresses of every instruction read or arbitrary physical memory. The original
runs without observer scratch writes or a substituted zero.

[confirmed: producer a888111,record/export1ba264e] One original week produces
two ordered boundaries,44 scene visits,44 observed base word stores and two
taken3235 near-adjustment branches.42 visits do not adjust duplicates; no3223
wide branch is reached. Both calls visit both sides and all eleven slots.
Every root and visit interval is4025→4025. Each root extends full T31 named
state with twelve canonical position cells,codes0,1,2,3,4,5,6,9,10,11,12,13,
and raw sign bytes[255,1]. Root entry equals the exact T31 final cache state;
root context also matches the retained T28 boundary on entry and return.

[confirmed: same capture] Each call adjusts side0,slot3,physical scene14 and
previous scene13. Its current observed base56576 becomes56579; the previous
scene's56576 becomes56829. Two base stores per call change entry words before
these adjustments restore them. The complete named input and output states
are equal despite the executed stores. This provides a concrete case where
opaque entry/return equality would conceal within-call writes. The observer
retains complete scene rows and taken branches,not inferred arithmetic outputs.

[confirmed: same capture] The new original week retains exact T33/T31/T30/
T29/T28/T26/T25/T23/T22/T20/T16 observations,T08 events and ordered DOSBox-X
comparison. Public checks bind source records,manifests,static listings and
immutable decoded exports. Mutation tests reject missing/reordered visits,
incomplete/mistyped cells,wrong scene/player/previous identities,broken literal
stores/continuations,incorrect byte-write domains,draws and bad provenance.

[designed] Python records actual table/store values and branches and validates
literal continuity. It does not calculate position adjustments. The original
specimens cover a zero low-byte duplicate and one near adjustment per call.
The wide branch/sign lookup,other position cells/sign values/arrangements,
other weeks,21D7,native replay/full AI and arbitrary physical/render/timer/
scratch parity remain unestablished. F34 awaits independent acceptance.
