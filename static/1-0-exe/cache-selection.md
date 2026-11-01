# Compact cached-player selector/rating contract (96, T32)

[confirmed: listings at `ac2fb46`, 0AB9:13B8–1452] 13B8 receives a side byte,
selects its D6E4 club roster and scans slots1–11. It calls4F89 on each player,
skipping unavailable entries. For an admitted candidate it calls4EBF, compares
against the current score and, on replacement, calls4EBF again before retaining
the player's ID and score. No game memory or RNG state is written.

[confirmed: same source] Current score BP-8 startsFFFF and is sign-extended to32
bits before comparison; a candidate return is zero-extended. High words compare
signed, low words unsigned. A current score greater than or equal to a candidate
preserves the old selection. This preserves earlier equal scores in the ordinary
nonnegative domain, but is not an unsigned maximum for arbitrary high-bit words.
With no eligible player, selected-player local BP-6 remains uninitialized. The
logical contract requires at least one eligible player; undefined stack behavior
is not filled with0 or silently accepted as a deterministic selector result.

[confirmed: 1B55:4F89–5008,24BC:0259–0274, same listing revision] Availability
reads player ID, signed P15+8 and flags11. Zero ID, byte8 below1 or any one-based
bits8,6,2,3 set returns unavailable. Other bits are not an additional rejection.
0259 shifts the zero-extended flag word by bit-number-minus-one and masks1.

[confirmed: 1B55:4EBF–4F02, same revision] Rating reads only P8+1,+3,+5. It
subtracts unsigned byte5 from unsigned byte3 in a word, sign-extends and divides
signed by8. XCHG returns the signed remainder, not quotient. P8+1 below21 then
logically shifts that16-bit word right once; higher values leave it unchanged.
Negative remainders retain their word bit patterns, so all16 return bits matter.
There are no child calls or game writes. Python does not evaluate this formula.

[derived: complete transitive graph above] Selector logical inputs are the
side-selected first eleven roster words and canonical referenced-player ID,
P8+1/+3/+5,P15+8/+11. Club identity is retained as provenance for the normalized
roster, not an extra arithmetic input. Pool pointers identify the data; no physical
pointer is exported.4EBF's standalone read set is exactly its three P8 bytes.
The graph is13B8→4F89/4EBF and4F89→0259; no other game-global inputs are read.

[designed: T32] Project two selector entries/returns and44 final4EBF calls from
the immutable T31 record. The selector output has an original in-roster chosen
ID with positive byte8 and flags11=0, a restricted raw witness that these calls
have defined results. This is not a general Python availability evaluator.
Compact rows preserve original week, step, replacement, event index, selected
side/club/roster or rating side/slot/scene/player metadata, actual inputs/outputs
and draw intervals. Bind T31/upstream hashes and these three static listing files.
Exports resume by preserving identical existing files and reject changed ones.

[designed] No original rerun, Python selector/rating model, independent nested
call count, accepted finding or native implementation is introduced. Other weeks,
blocked/zero/no-eligible cases, negative remainders, logical shifts, high-bit score
comparisons,1455 input closure and full AI parity remain separate checks. Proposed
F32 will record actual source coverage and measured values after extraction.
