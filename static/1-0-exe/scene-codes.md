# Original 03BB scene/cache code input contract (96, T30)

[confirmed: listings at `0a031ff`, 0AB9:0000,0143–03E1,1CBB,1CD6,1ECC]
03BB visits physical scenes1–22 through02D7, then calls033E. 02D7 writes scene
word4 (bytes4/5). A stored selector byte7 of1 or12 selects the keeper branch:
its low byte is1 and its high byte comes from D0CA/D0CB, indexed by1CBB's
stored-selector-below12 predicate. Other scenes use0207 for the low byte and
D0C8/D0C9 for the high byte. Physical scene index and stored selector are separate
inputs. 0000 tests selectors1/12; 1CBB tests the stored selector below12.

[confirmed: same source, 0207] D0C0 is a far pointer; its pointed byte selects:

| Mode | Additional low-code inputs |
| --- | --- |
| 0 | Scene words0/2 and0143's direction/position/byte6 inputs |
| 1 | Player ID from the scene indexed by the stored selector; P8+6; raw8716+role byte |
| 2 | Unsigned D0AE word versus sign-extended D0AC byte; stored selector below12;096E/096F |
| 3 | Stored selector below12;096C/096D |
| 4 | Wrapping unsigned selector-minus-one, unsigned remainder modulo11, offset47 |

Modes above4 reach the return without initializing local result byte BP-1. They
require physical scratch observations and are outside this logical contract;
T30 diagnoses them. Role bytes0–13 are the admitted player domain, so fourteen
individual8716 cells close mode1's table inputs. Broader invalid-role indexing
is not claimed. Python does not implement these mode decisions or formulas.

[confirmed: same source, 0143 and1ECC] 0143 takes a scene pointer and two packed
word arguments, called A at BP+0A and B at BP+0C. Their high bytes are compared
first. 1ECC compares unsigned D0AE against sign-extended D0AC, XORs that result
with1CBB's stored-selector predicate, then reads A338/A339. Its returned byte is
sign-extended for the high-byte argument products. MUL retains low16 bits;
the following comparison is signed on those words, not an unbounded product.
096A/096B select code offsets. Equal high bytes but different low bytes choose
an alternate offset. The code adds scene byte6 before conditionally writing its
logical negation (zero→one, nonzero→zero) when the two packed words differ.
Return values and byte6 before/after state are observed, never calculated here.

[confirmed: same source, 033E] Three cache records start at CF2E,CF35,CF3C.
Words0/2 are inputs; word4 (CF32,CF39,CF40) is written. Each of the three0143
calls receives A=cache word2 and B=cache word0, and returns a code to which the
caller adds0500 before storing word4. Two calls share site0378, the third uses
03B0. Actor D09F below12 (1CD6) selects D56's side offset, plus1, as the physical
scene pointer. All three calls can mutate that same keeper scene byte6 in order.
The cache words were absent from T28's opaque projection; unchanged T28 state
does not prove033E has no writes or no effects outside that projection.

[derived: the complete graph above] The logical read set is full scene rows
(including stored selectors, position words, IDs and byte6), referenced players'
P8+6, actor, side offsets, D0C8–D0CB, pointed mode, raw D0AC/D0AE, A338/A339,
096A–096F, fourteen8716 role cells, and all three caches' words0/2. Cache word4
entry values are retained for before/after comparisons. T28 already supplies the
scene/player/actor/offset/D0C8 context; T30 adds the missing named inputs. No
transitive helper calls RNG, the renderer, a timer or an external routine.
Logical writes are scene bytes4/5/6 and the three cache words4. There is no claim
of physical registers, CPU flags, stack leftovers or arbitrary whole-memory parity.

[designed: T30] Observe two03BB boundaries at1988→198B in the targeted T28/T29
week. Retain22 ordered scene input/output rows per invocation,033E's complete
entry/return projection, and three nested0143 rows, packed arguments, scalar
returns and draw intervals. Normalize scene pointers while live without export.
Validate literal observed row continuations and allowed writes rather than an
engine model. Reproduce T29/T28/upstream observations and T08/DOSBox-X comparisons.

[confirmed: T30-r0001/export at `fd7d4cd`, observer `5158d91`] Both captured
invocations use mode0, threshold45, clock34 and raw direction signs[255,1].
There are44 scene boundaries, two cache boundaries and six nested code calls,
all zero-draw. Each full root projection is unchanged, including the new caches.
All cache input words are247/247; nested0143 returns156 and preserves scene1
byte6 at0, while the cache code word remains1436. All44 scene input position
words0/2 are equal. Proposed F30 reports the exact output census and explicitly
excludes dynamic coverage of toggles, unequal arguments, modes1–4 and cache target12.
