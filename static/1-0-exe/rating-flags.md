# 53FB logical rating/flag contract (96, T27)

[confirmed: listings at `f463c98`, 1B55:53FB–54A3] The routine selects one player
from its identifier, calls 4E0C and compares AL unsigned with four. A result below
four calls 53C6. It then reads P8+6: values zero/one/three/four set P15+10 bits
five and one; value two sets bits five, six and two; other values add no bits.
The routine returns no meaningful logical scalar. Its named write is P15+10.

[confirmed: same source, 53C6–53F8 and 232A:00D5–011A] 53C6 sets bit eight and
clears bit four of P15+10. The shared byte bit helpers use one-based arguments,
subtracting one before shifting. They preserve other bits. The caller does not
clear all incoming flags; AEB8 performs its own prior clear, outside this routine.
A logical replay must therefore retain the input flags even though all retained
original replacement samples enter with zero.

[confirmed: same source, 4E0C–4E7E] For P8+1 below eighteen, the routine forms a
16-bit word from zero-extended P8+5, decrements it and subtracts three times
(eighteen minus P8+1). It sign-extends that word, takes the signed-32 maximum with
zero through 24BC:04C0–04F7 and returns AL. For P8+1 at least eighteen, it subtracts
P8+3's low bit from zero-extended P8+5 and returns AL. The latter path has byte
wrapping and no lower clamp. The former path requires signed word interpretation;
replacing either with a generic nonnegative host-integer expression changes edge
cases. No such expression is implemented in this Python evidence repository.

[derived: these closed static dependencies] The complete logical read set is
P8 bytes1/3/5/6 plus P15 byte10; the output is P15 byte10. Pool pointers and player
identifiers locate the row but are not additional arithmetic inputs. No club,
scene, clock, RNG or other table input is read by this closure. CPU/register,
physical-pointer and arbitrary memory alias parity are outside this logical API.

[designed: T27] Compact fixtures project all 25 existing T25 AFDA helper snapshots,
retaining week/replacement/helper order, player identity, zero-draw intervals and
record/fixture hashes. The exporter validates full before/after named state and
permits a difference only in the target P15+10. Expected output is copied from
the original snapshot; it is never computed from the input. Static source hashes,
T25's manifest and the compact file digest are bound by the new manifest. Existing
exports are immutable and the checker regenerates the same bytes in memory.

[designed: T27] This creates no new original run and observes no nested helper
entry. A branch count inferred from source and output bits must remain derived,
not a newly measured call census. The retained corpus has zero input flags,
P8+1 at least eighteen and the input domain present in T25; younger, pre-set flag,
zero/large/wrapping and other invalid-context cases require separate native
static/synthetic checks or targeted original probes. Proposed F27 will report
the exact original output census and this limited coverage.
