# Proximity selectors: original21D7 contract

[confirmed: listings at4b21d90] `code/seg_0AB9_04.asm`21D7–2303 loops both
sides,initializes D0A4[side] to the byte D56[side]+1 and D0A2[side] to0,
then visits slots2–11.1CA1 wraps4F89 on scene.word14; AL1 skips the candidate.
The actor D09F matching scene.byte7 or scene.byte19==13 also skips it.
Eligible candidates compare signed coordinate bytes at scene+0/+1 with
CF46/47. The sum of absolute signed differences is compared unsigned against
an initial100 threshold. A strict improvement copies scene.byte7 to D0A4.

[confirmed: same graph] Two1ECC calls on the same candidate supply signed-byte
direction returns. The original multiplies each by signed target/current Y,
retains each low16-bit product and uses a signed comparison to decide whether
the candidate is ahead. An unsigned distance improvement against a separate
initial100 threshold copies scene.byte7 to D0A2. Ties retain the prior selector.
These returned selector bytes differ from physical scene IDs; defaults are
D56+1 while updates copy scene.byte7. Only the four selector bytes are written.

[confirmed: `code/seg_0AB9_03.asm`1CA1,1ECC,1CBB; `seg_1B55_08.asm`4F89;
`seg_24BC_01.asm`0259 at4b21d90]1CA1 has one child4F89. Its complete player
inputs P15+8/+11 and bit semantics are already retained by T31 and earlier
availability contracts.4F89's0259 bit calls are statically mapped; T35 does
not claim a new independent census of those bit calls.1ECC compares unsigned
D0AE with sign-extended D0AC via a two-word comparison,then XORs that predicate
with1CBB(scene.byte7<12),indexing A338/A339.1CBB has no children. All helpers
are read-only and consume no RNG. There is no uninitialized-local output path.

[designed: T35] The root extends T31 context with raw CF46/47,D0AC,D0AE,
A338/A339 and both selector pairs. Capture2208 after side initialization,
223D candidate entry,all reached direct/nested helper returns,22A0/22EA after
actual selector stores,and22F0 at visit end. Normalize scene pointers and
save full read-only scene rows; retain original byte returns and draw intervals.
Validate skips,helper order,initialization and literal selector store identities
without computing distances,directions,winners or product comparisons in
Python. Entry binds final T34 context; both endpoints bind T28 context. The
new original week retains T34 and all upstream observers,T08 trace and ordered
DOSBox-X comparison. Original records/exports are append-only. Measured census
follows capture. Other weeks,unobserved branches,managed/native/full AI and
arbitrary physical/render/timer parity remain excluded.

## Measured T35 capture

[confirmed: producer `46ec8b5`, original/export `2a0216c`]
Two21D7 calls from T04-week-r0017 retain40 candidate visits,four side
initializations,four nearest-selector stores,and no ahead-selector stores.
There are40 original1CA1 calls and40 nested4F89 calls,36 calls at each of
the two1ECC sites,and72 nested1CBB calls. All intervals are4025→4025.
Each call has nineteen available candidates and one unavailable;one other
candidate is skipped because scene.byte7 equals actor5. No byte19==13 skip
is reached. Eighteen candidates per call receive the two direction helpers.

[confirmed: same capture] Target bytes are[11,0],phase45,time34,signs[255,1],
and side offsets[11,0]. Each direction site returns255 nine times and1 nine
times per call; nested side returns split18 each between0 and1. Availability
wrappers exactly retain child returns. Every helper/visit scene row is read-only.
The near pair enters/exits[13,2],ahead[0,0]. Side0 initializes near12,then
slot2/physical scene13 stores13. Side1 initializes near1,then slot2/physical
scene2 stores2. Other visits do not store. Thus full named input equals output
though selector initialization and restoration execute within the call.

[confirmed: immutable T34 rows,checked during T35] The same side offsets
identify T34's side0/slot3 adjustment as physical scene14/previous13. Earlier
F34/static prose incorrectly named physical3/2 by copying slot numbers; T35
corrects that prose. Original records,fixtures and measured word values never
change. This is why side,slot,scene.byte7 and physical index remain distinct.

[designed] These specimens cover available/unavailable and actor skips,both
signed direction returns,near initialization/restoration and no ahead stores.
Byte19==13,other target/phase/time/sign values,ahead-store branches,other weeks
and general native AI parity remain unobserved. The graph is statically closed
for this targeted path; wider recorded-week coverage still needs assessment.
F35 remains proposed. Public check: `python3 runtime/emul/proximity_selectors.py
--check`; negative tests: `python3 -m pytest tests/emul/test_proximity_selectors.py`.
`--run` requires private originals/start states only for a new capture,skips
completed sources and never overwrites records/exports.
