# A4F2 post-score strategy and late-call boundaries (T20)

`[confirmed]` Listing at `6804fbb`: `seg_0AB9_16.asm` A23C..A5BB,
`seg_1998_02.asm` 0C23..0C77, `seg_1B55_04.asm` 265B..26BA,
`seg_1B55_08.asm` 4E0C/53C6/53FB. A4F2 is called at52B6's return5306.
Its pushed word argument is removed byRET2 but never read.

`[confirmed]` The root subtracts sign-extended score byte D0C5 from sign-extended
D0C4, stores the low byte, then sign-extends that narrowed difference before abs.
It visits side0 then1, skipping clubs matching either DCBA/DCBB. Abs difference<2
callsA23C; exactly2 callsA34D with raise when its own **unsigned** score byte is no
greater than the other; larger differences callA464 when ahead, A3D6 otherwise.

`[confirmed]` A23C loads the club baseline from byte table93F7 indexed by byte
D885+clubID and passes it to0C23. Side1 then sets one-based strategy bit1 and calls
the setter again. It calls265B first on the opposite club and then its own club and
compares the wrapping signed word difference (own minus opposite) to zero-extended
byte C66+side. A positive excess sets two random6 bits and calls the setter again.
The original trace's club arguments independently check this selection. Finally it clears D0CC+side
and D0CE+side.

`[confirmed]` 265B returns the wrapping word193 - club byte51 - selected value.
Selected value is club byte54 unless that byte is zero, then player8 byte5 of the
first roster ID. ID zero is still read if it occupies that slot. A getter result is
an observation to compare, not an input value supplied to the native algorithm.

`[confirmed]` A34D first callsA23C, then performs three random6 one-based set/clear
operations on club byte57 and calls0C23. A3D6/A464 skip if the corresponding D0CC/D0CE
byte is nonzero; otherwise they do five random5 set/clear operations, set/clear bit6,
call0C23 and latch that side's flag to1. All underlying RNG calls still return1..n.

`[confirmed]` 0C23 stores its low argument byte to club+57, then calls53FB for every
nonzero ID in the20-word roster, in order. 53FB calls53C6 when4E0C's low return byte<4:
set player15 flags10 bit8 and clear bit4. Position byte player8+6 in {0,1,3,4} sets
bits5/1; position2 sets bits5/6/2; other positions do not add those bits. There is no
availability filter. Repeated/shared IDs mutate one canonical record sequentially.

`[designed]` Record complete raw club/roster/player, score, baseline lookup and flag
inputs plus path/getter/setter/normalizer observations. A separate ledger partitions
all prefix-to-clock spans into actual DBC6/6B2F/045C/52B6/78B7 calls. Capture the
entire six-week T16 projection and T08 events/waits for literal source comparison;
Python implements no strategy or flags formula.

`[designed]` Native T08 composes only the prefix's shared seed/score/club/roster
footprint into the strategy projection. It requires the quick goal-reset path and a
nonkeeper physical actor; the keeper path in5267/4F95 can draw and is untranslated.
The complete52B6 scene prelude,6B2F substitutions and78B7 keyboard effects remain
unexecuted dependencies. Neither a matching strategy nor a complete draw census is
proof of full DD02/match/week or timer/render/physical/scratch parity.
