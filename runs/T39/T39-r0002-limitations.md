# T39-r0002 is an aborted observer-ABI failure

[confirmed] Observer bf0e688 read code/side as words and interpreted SP+4 as
the primary roster slot. The actual0F94 instructions read byte code/side, and
0E45 writes SP+6's player as queue primary,SP+4's as secondary. Recorded side
words included FF00 and0100,whose high bytes are ignored by original code.
The observer's incorrect full-word side lookup produced invalid player reads
and eventually UC_ERR_READ_UNMAPPED after15 captured requests. This is an
observer failure,not an original watched-engine crash. Its decoded argument/
queue aliases are inconsistent,so it cannot support accepted action identities.
The aborted record is retained unchanged. A specific byte-width/slot-order
red test precedes the corrected observer and fresh capture.
