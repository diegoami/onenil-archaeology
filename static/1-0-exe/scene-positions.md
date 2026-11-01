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

## Measured T34 capture

[confirmed: producer `a888111`, original/export `1ba264e`]
`runs/T34/T34-r0001.json` completed with two calls,44 visits and44 observed
base word stores. Both sides' eleven visits occur in order in each call.
There are42 unadjusted visits,two taken3235 near branches,and no3223 wide
branch. All root/visit intervals are4025→4025. Every original T33/upstream
observation,T08 event and ordered DOSBox-X comparison is retained.

[confirmed: same capture] Both root snapshots retain the same twelve position
cells:codes0,1,2,3,4,5,6,9,10,11,12,13; sign bytes are[255,1]. Each call's
single near adjustment is side0,slot3,physical scene14,previous scene13.
The current scene's observed base56576 becomes56579; the previous scene's
observed56576 becomes56829. The previous scene had itself received a base
store on the preceding visit. Each call has two base stores that change a
word,then the near adjustment restores their entry words. Consequently each
complete root's named input equals its named output; the routine still
executes all22 base stores and its paired adjustment. Root equality alone
would miss these effects within the call.

[designed] The original capture covers a low-byte-zero duplicate,one near
adjustment per call,both sides and zero RNG. The wide branch,its sign lookup,
other position cells/sign values/duplicate arrangements and other weeks are
unobserved. Static mapping documents the full routine; original tests do not
establish those unobserved domains. F34 remains proposed. Public verification:
`python3 runtime/emul/scene_positions.py --check`; negative tests:
`python3 -m pytest tests/emul/test_scene_positions.py`. `--run` restores the
original week only when needed,skips completed sources and never overwrites
records/exports. Private originals/start states are needed only for a new run.
