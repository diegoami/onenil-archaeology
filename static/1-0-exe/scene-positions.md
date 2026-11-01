# Scene-position assignment: original3155 contract

[confirmed: listings at0f66bad] `code/seg_0AB9_05.asm`3155–325E has no
child calls. It loops two sides and eleven slots, choosing physical scene
D56[side]+slot at CCEF+25*index. Scene.word14 selects the canonical P8 player;
P8+6 selects a word at0A3A+2*position, copied to scene.word10 at31CF.
The complete logical input set is these side offsets,scene/player identities,
canonical P8+6 and actual indexed position words,plus A338/A339 sign bytes.
Other named state is retained to reject unrelated writes.

[confirmed: same listing] The first scene of each side skips duplicate checks
at31E3. Later scenes compare the freshly assigned word10 with the previous
scene's current word10. On equality, the signed absolute low byte decides the
adjustment. For magnitude>4, the current low byte subtracts three times the
signed A338[low-byte>0] value, and the previous high byte subtracts3. Otherwise
the current low byte adds3 and previous low byte subtracts3. Byte arithmetic
wraps independently: these are not two word additions.3246 always assigns the
current physical index to the previous-scene local before the next visit.
No RNG or other game-state writes occur in the static graph.

[derived: same graph]3159 reads an uninitialized byte and uses it to index
D56,setting BP-6. This does not affect named outputs: each side's first scene
skips all BP-6 uses through31E3→3243,and3246 overwrites BP-6 before the next
scene. The side variable itself is initialized at3169 before either loop.
For byte side offsets,first=offset+1<=last=offset+11 without16-bit overflow,
so each side has a first visit. This is logical-output independence from that
scratch value; it is not an instruction-read trace claim or arbitrary-memory
safety proof. The observer neither initializes nor substitutes guest scratch.

[designed: T34] Each root extends T31 state with ordered actual position cells
for every canonical P8+6 value and both sign bytes.44 expected visits bind
side,slot,physical scene,player and actual previous-scene local where used.
31D3 observes the completed base store;3223/3235 identify taken wide/near
adjustment branches;3243 records both resulting scene rows. The checker
compares actual table/store words and literal continuations,allows only the
appropriate coordinate bytes to change,and never computes their arithmetic.
An unadjusted visit must retain its base/previous rows. Root input/output
binds exact T28 boundary context; the original run retains T33 and all prior
observers,T08 trace and ordered DOSBox-X comparison. Original records and
exports are append-only. Measured coverage follows after capture. Other
weeks,unobserved positions/sign values/adjustments,21D7,native/full AI and
arbitrary physical/scratch parity remain excluded.
