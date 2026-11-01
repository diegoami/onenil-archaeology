# Role-cache scoring: bounded input contract

[confirmed, static] `code/seg_0AB9_02.asm` 1455–1538 clears the selected
CF5C+10*side+2*kind word, then visits slots `09F6+(kind==5)` +1 through11.
The physical scene is D56[side]+slot, with25-byte rows at CCEF.4F89 returns
AL1 for unavailable candidates. The first available candidate fills the empty
cache; later candidates call8973 on the cached player, then1AE2 on that scene
and the candidate scene. A strictly greater unsigned candidate word replaces the
cache; ties retain the previous value. The observer records the taken1511 store
branch independently of the score returns. These are original-code observations,
not Python score or selection calculations.

[confirmed, static] `code/seg_0AB9_14.asm` 8973–89FF reads the cached player's
P8+0 club and its first eleven D7C2 roster words. It returns the last matching
slot plus D56[player-club==D6E6], or0 when not found. The public checker requires
a nonzero observed return with a roster/scene identity witness. The full named
T31 state retains D6E4/D6E6 clubs, side offsets, scene rows, canonical P8/P15
player fields, availability inputs and all cache words.

[confirmed, static] `code/seg_0AB9_03.asm` 1AE2–1BD3 reads scene.word14,
byte7,byte18,byte22; player P15+6/+8 and (on the high branch) P8+0; D6E6,
D1CE/D1CF, criterion,09FB+criterion and D29. Raw P15+6 in0–31 initializes
its baseline to signed-byte+1. Other signed values below32 also initialize it,
but are outside this capture's admitted domain. Signed values32–127 take the
club/flag branch: nonzero flag sets0, zero flag adds32 to an uninitialized
local. No zero scratch or arbitrary-state replay claim is made.

Criterion>=21 adds32; otherwise signed P15+8 is added. The nested9F6E return
is logically halved when scene.byte22 is nonzero. The original adds its logical
quarter to the upper byte of the low-word product with the baseline, wrapping
at16 bits. A nonzero09FB+criterion adds unsigned scene.byte18. Scene.byte7<12
and nonzero D29 adds a logical sixteenth; the unsigned minimum is1.1AE2 has
one nested call at1B60 and no named game-state writes.

[confirmed, static] `code/seg_0AB9_15.asm` 9F6E–9FCD reads P8+4/+5/+7.
First index is22*(P8+7)+criterion; the first byte is at957D+index. Second
index is22*(P8+5)+first-byte; its byte is at96B1+index. All address additions
wrap at16 bits. The result is the low word of (P8+4+1)*second-byte, logically
shifted right5. No child calls or named game-state writes occur. T33 records
both actual table cells at entry and at the nested call, without deriving a
cell from a score. Canonical P8 aliases must agree.

[designed] T33 extends T31 with D29,D1CE/D1CF,09FB+criterion, ordered indexed
lookup rows for every canonical player and ordered player-club rosters. Each
role boundary binds the exact T31 parent/event and full input/output state.
Visits bind slot,physical scene,player,actual cache clear/store continuations,
ordered helper arguments/word returns and draw intervals. Score helpers bind
read-only scene rows and exactly one nested table call. Public validation needs
only decoded records, never private game bytes. New original captures retain
all prior observers and the ordered T08/DOSBox-X week comparison. Counts and
measured coverage will be appended after recording. Other weeks, blocked
candidates, missing roster players, negative/high raw domains, scratch-dependent
calls, remaining tail routines and native/full-AI parity are unestablished.
