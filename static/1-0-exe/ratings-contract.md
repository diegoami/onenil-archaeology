# Native ratings contract (T15)

`[confirmed]` This is One-Nil 96's logical ratings projection, read in the committed listing
at archaeology `da4f9af`: `code/seg_1B55_07.asm` (4A37, 4B4A) and
`code/seg_1B55_08.asm` (4E81, 4F05, 4F89, 50EB). T15 records raw numeric inputs and actual
returns; Python does not implement these formulas. F09's earlier observations remain unchanged.

## Memory and input domain

`[confirmed]` The four rating words for side s are `DS:D674 + 4*k + 2*s`, k=0..3. Player p's
8-byte record is `[D7BA]+8*p`; his 15-byte record is `[D7BE]+15*p`. Clubs use
`[D7C2]+62*(club-1)`. Staff record j is `[DCC8]+4*j`. Named raw inputs are the first eleven
club roster words, club byte +37h and words +28h/+2Ah, player r8 bytes +4/+6/+7 and r15 bytes
+6/+8/+0Bh, and staff byte +2. All are unsigned raw bytes/words in the exports; the native
consumer sign-extends r15 +6/+8 when the instructions do so.

`[designed]` The supported decoded domain has clubs 1..176, player IDs 0..3920, staff IDs
0..1000, side 0/1, and player position/selector bytes 0..13. ID zero is skipped in a side roster
but is a valid indexed staff record. Missing/duplicate player or staff definitions are invalid;
repeated roster or staff IDs refer to the same canonical record. These bounds describe named
pools and tables, not arbitrary segment-offset overflow or spillover semantics.

`[confirmed]` The raw tables are:

- `12BA`, three bytes `[0,1,0]`, indexed by unsigned player ID modulo 3.
- `129E`, two rows of fourteen bytes, indexed by `14*12BA[p%3] + r8[7]`:
  `[1,1,1,0,1,1,1,0,1,1,0,1,1,1]` and `[0,0,0,0,1,0,0,0,1,0,0,1,0,0]`.
- `12BE`, position classes `[0,1,1,4,4,2,2,2,2,5,5,5,3,3]`.
- `1286`, signed division's positive byte divisors `[8,16]`.
- `12CC`, unsigned side-bonus divisors `[16,64]`.

## Helper order and arithmetic

`[confirmed]` `4F89(p)` returns 1 if p=0, signed r15[8]<1, or r15[0Bh] intersects mask A6h;
otherwise 0. Calls to the Pascal set-membership helper use one-based bit numbers 8,6,2,3
(4FAA..4FF9), corresponding to bits 7,5,1,2. This agrees with the earlier placement contract.

`[confirmed]` `4E81(p)` returns the raw table byte at `129E + 14*12BA[p%3] + r8[7]` (4E85..4EB8).
`4F05(p)` returns 1 when any of these ordered conditions holds (4F1B..4F82):

1. The first `4E81` return is nonzero and position is 3,7,10.
2. Otherwise a second `4E81` return is zero and position is 4,8,11.
3. Otherwise position is zero and r8[7] is nonzero, or r8[7] is zero and position is nonzero.

The first condition short-circuits the second call. The observer retains the actual sequence of
one or two returned bytes. `4F89` rejection skips `4F05` and both selector calls altogether;
exports preserve `halved:null` and an empty selector list for that absence.

`[confirmed]` `4B4A(p,mode)` first calls `4F89`, returning zero on rejection. Otherwise its
16-bit intermediate v starts as unsigned r8[4] - 62 + signed r15[8] (4B83..4B9B). If signed
r15[6]<32, add that signed byte. Otherwise, if mode is nonzero and r8[7]=0, subtract
signed `v / 1286[1]`, truncated toward zero (4BB2..4BDD); else if r8[7]=0 add 16. All word
operations wrap at 16 bits. Signed comparisons then clamp v to 0..256 (4BF0..4C04). A reached
`4F05` nonzero return halves it with signed division by 2 (4C09..4C1D). Return AX at 4C2A.

`[confirmed]` `4A37(club)` reads the club's two staff IDs a,b and returns
`16 + (staff[a].byte2 >> 5) + (staff[b].byte2 >> 4)` in AX (4A37..4A8C). Its possible value is
16..38. F09's AL observation was sufficient in those runs, but the new observer retains AX.

## Side update and contest handoff

`[confirmed]` `50EB(club,side,flag)` computes `4A37` **before** zeroing the selected side's four
words (5103..5126). It visits first-team slots in order, skips player ID zero, and calls
`4B4A(p,0)` for each nonzero ID. It adds the staff bonus only to a nonzero returned player
value (5182..518B). The position class c selects the destination: c<4 adds the word to value c;
c=4/5 first shifts the word logically right one, then adds that same half to c-3 and c-2
(5199..521D). Each addition wraps as a word; duplicate roster IDs contribute repeatedly.

`[confirmed]` A nonzero flag adds `w / 12CC[club[37h]==0]` to each selected word, using unsigned
division and word addition (522A..527D). It does not alter the other side's words, seed or random
draw count. Return is at 5281. These are routine logical claims, not whole-memory equality.

`[designed]` Side cases retain all eight before/after rating words, seed, raw fields/tables,
draw boundaries, actual nested helper observations and exact indices into the all-call helper
streams. Expected helper outputs live only outside `input`. Every D983 handoff references the
latest actual call of each side in execution order and a literal T11 case; the second call's
incoming words equal the first call's outgoing words. The native consumer must preserve the
actual shared image and seed, compute both sides and enter D983 with those computed words.
The expected rating words and expected draws do not initialize that handoff.

## Evidence limits

`[confirmed]` F09 recorded 1,128 side calls, 12,614 player calls, 2,495 bonus calls and 558 D983
entries. The twelve side calls beyond twice the D983 count occur during setup. Side calls
always pass player mode zero; the observed mode-one division branch comes from another caller.

`[designed]` T15 checks full literal T09 projections and every retained T11 draw span, groups all
15 T08 references by their complete draw streams, and compares new week events and ordered
DOSBox-X waits. Synthetic Rust checks cover branches absent from these original runs. Formatted
text, pixels, timer/scratch and complete DD02/match/week or watched-engine behavior are excluded.
