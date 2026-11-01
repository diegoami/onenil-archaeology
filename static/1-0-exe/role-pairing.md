# Original 10B9 role-pairing input contract (96, T29)

[confirmed: listings at `3f59c97`, 0AB9:1000–13B7] 10B9 visits sides0 and1.
It writes only scene word20 in logical game state. It first clears that word for
each side's first physical scene, and for its second if the second scene player's
P8+6 equals1. Slots2–11 provide own/opponent role bytes; slot1 of each local
array is the Pascal length10. Own candidates exclude P8+6 equal1, P15+11 bit7
set, or 1CA1-unavailable players. Opponent candidates exclude unavailable players.
Bit7 here is one-based, so its mask is0x40; 4F89 separately uses bits8,6,2,3.

[confirmed: same source, 1CA1 and 1B55:4F89–5008] 1CA1 reads scene word14
as player ID and delegates to4F89. Availability reads the ID, signed P15+8 and
P15+11. Zero ID, signed byte8 below1 or any of bits8,6,2,3 set returns unavailable.
24BC:0259 shifts right by bit-number-minus-one and masks1; no RNG is called.

[confirmed: 0AB9:1206–129A, same source] For each own scene whose player's bit7
is set, the caller excludes opponent slots whose match-club roster ID equals
the existing own scene word20. It zero-fills eleven assignment bytes. It then
calls1000 with ranges12–13,9–11,5–8,1–1,2–4 in that order for each side.

[confirmed: 0AB9:1000–10B6, same source] Each range helper makes passes1–4,
visiting opponent slots11 down to2. A candidate's unsigned role must lie within
the inclusive range. DS:09B0+14*pass+role supplies a preference character; the
guard limits role to1–13, closing the read set to52 individual cells. The helper
converts this character into a Pascal one-character string through26C9:0C6F,
searches the length10 own-role array through26C9:0BFE (Pos), and adds1 to the
one-based position. A result above1 zeroes the selected own and opponent role
cells and stores the opponent slot in that own slot's assignment byte. A search
miss produces1 and makes no assignment. Pass and reverse-slot order are material
when multiple candidates match. These operations are a static contract, not a
Python implementation.

[confirmed: 0AB9:12D0–13B7, same source] In slots2–11, an own player's bit7
clear first clears scene word20. If also its club byte57 bit8 is set, a nonzero
assignment chooses the opposing club's roster ID; a zero assignment stores0.
When the club flag is clear, the word stays at its already cleared value. An own
player with bit7 set retains its previous word20. The opponent roster lookup is
at record62*(clubID-1)+2*(slot-1). Club byte57 is read as record62*clubID-5.

[derived: complete direct/transitive graph above] Logical inputs are both side
offsets and match-club IDs, both rosters slots2–11, scenes word14 and word20,
referenced players' P8+6/P15+8/P15+11, both club bytes57 and the52 preference cells.
Scene word20 and selected IDs are actual entry inputs; role and assignment arrays
are caller-initialized local state. Remaining context in T28 is redundant for
10B9 but retained to detect unrelated writes. Far pointers identify these pools
and are normalized live; they are not logical engine inputs. The Pascal string,
fill and bit primitives have no additional game-global inputs. Signedness and
16-bit address arithmetic follow the listings rather than decompiler notation.

[designed: T29] Capture the two original10B9 calls at1985→1988 within the same
targeted T28 week. Add the missing logical inputs and observe each1000 call's
actual range and all three named local arrays, preserving parent-frame identity
without exporting addresses. Bind the full T28/upstream comparisons and static
source hashes. New observations are immutable, and Python does not calculate
pairings, role preferences, availability or search results.

[designed] This closes logical inputs for this routine, not arbitrary physical
scratch/register/flags behavior or the remaining opaque164F callees. Other weeks,
unobserved flag/role combinations, nested bit/search call counts, native replay,
complete rearrangement and continuous AI/DD02/match/week parity remain separate.

[confirmed: T29-r0002/export at `d9a59df`, observer `f00db10`] The two original
invocations contain20 range boundaries and zero draws. Actual match clubs130/134
have byte57 values75/133, and all52 preference cells remain unchanged. Per
invocation, final local assignments have9 nonzero entries for side0 and8 for
side1; they are identical in the companion call. Named scene-word20 changes are
two in the first call and one in the second. No other named state changes.
Proposed F29 distinguishes these observations from complete-corpus or nested
primitive-call coverage. Abortedr0001 is retained separately: its observer used
human-manager slots rather than match-club IDs, rejected by strict validation.
