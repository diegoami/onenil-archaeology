# Replacement scene rebuild closure (96, T26)

[confirmed: listings at `9fbab34`, 0AB9:8663–86E6] Rebuild first calls 8599,
then sets scene word0/word2 from D32, selects a direction byte from D0CA+side
for keeper selectors (1 or 12), otherwise D0C8+side, sets word12 from D2C and
initializes word20, byte17, word23, byte6 and byte16. The caller later restores
word2 separately. The complete original outer snapshots are retained from T25.

[confirmed: same listing, 8599–8660] 8599 stores the supplied physical index in
scene byte7, obtains normalized slot (1E9F) and side (1CBB), and reads the club's
roster player. The side helper returns one for stored selectors below twelve,
zero otherwise; it does not read the caller's side-offset array. The slot helper
subtracts eleven for selectors above eleven. The player ID becomes scene word14.
The routine obtains 1B55:4A37's word result for P8+0's club, passes two zero-extended
word values to 24BC:04FA, stores its low byte in scene byte18, applies the age-byte
threshold additions (P8+1 above 18 or above 17), and stores 4F05's predicate result
in scene byte22.

[confirmed: same source, 1B55:4A37–4A8C] Club count reads club word40 and word42.
Each is shifted left twice as a 16-bit word and selects a four-byte entry in the
DCC8 table; entry byte2 supplies the two shifted bit fields. The return adds
sixteen, (cell42 >> 4) and (cell40 >> 5). The capture exports the raw indices/cells,
not only the returned count. Far-offset addition and the index shift wrap at
sixteen bits; no physical pointer words are part of the logical fixture.

[confirmed: same source, 24BC:04FA–0531] The minimum helper compares signed high
words and, when equal, unsigned low words, returning a complete DX:AX pair.
Both captured 8599 arguments have zero high words: player P15 word0 and the
actual club-count result. Preserve all 32 bits rather than assuming an eight-bit
helper merely because its caller writes AL.

[confirmed: same source, 1B55:4F05–4F86, 4E81–4EBC] The half/flag predicate uses
P8+6/P8+7 and handedness helper calls. Handedness indexes 12BA by player ID modulo
three, then indexes 129E by fourteen times that selector plus P8+7. T23/T25 already
retain these exact raw cells per canonical player. T26 additionally records the
actual nested handedness results and ordered predicate paths. Several calls push
CS explicitly before a near call to a far-returning routine; the observer checks
and normalizes the resulting argument positions.

[designed: T26] Input includes the complete T25 named snapshot plus the two raw
club table indices/cells for every nonzero canonical referenced player's club.
Player-zero is a sentinel, not a club-zero lookup request. This capture supports
the observed valid-club domain; unsupported club identifiers fail explicitly.
Nested helpers record semantic arguments, scene rows, original scalar results
and draw intervals. 8599's intermediate assigned scene row is retained separately.
No scene or helper output is calculated in Python. Public checking preserves every
T25 helper boundary and all earlier original comparisons and provenance.

[designed: T26] Original keeper and sentinel cases outside the retained replacement
corpus remain unobserved unless the measured census establishes otherwise. Native
translation, other replacement helper closures, arbitrary memory/timer/render
parity and continuous match integration are separate work. Proposed F26 will pin
the original producer, measured helper census and coverage after capture.
