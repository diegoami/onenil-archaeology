# Targeted 164F rearrangement capture (96, T28)

[confirmed: listings at `cdbcf8a`, 0AB9:164F–199F] The routine visits side zero
then one. It scans the first eleven roster entries twice: availability gates the
P8+4 sum, then unavailable players receive local role marker14 while available
players supply P8+6. The register-argument division helper receives DX:AX and
BX:CX; the caller's denominator is22 and its returned low-word quotient plus one
is stored in the opposite side's D12A total. The original quotient and remainder
are observations, not values computed by this capture.

[confirmed: same source] Strict unsigned comparison of local role bytes drives
paired exchanges. One transaction swaps roster words, local role bytes, full
25-byte scenes, event-total words and cache-selector bytes. The caller then
reindexes D09F actor and D0A0 secondary if either equals a participating physical
scene index. Physical scenes add the measured side offset to the roster slot.
These selectors were absent from T25's opaque helper projection.

[confirmed: same source] After each side's sorting phase, 8599 assigns all eleven
physical scenes. The final direct calls are 10B9,03BB,1539,3155 and21D7, followed
by clearing word12 of physical scenes1 and12. These five callees remain opaque
here. Their entry/return state must not be described as a complete callee read set.

[confirmed: `26C9:0A67–0B0C`, same listing revision] The division helper selects a
CPU implementation through A52A and uses signed32 division, returning quotient
in DX:AX and remainder in BX:CX. T28 includes the raw CPU-class byte and both
original register pairs. Captured callers use positive small operands; broader
signed/overflow/zero-divisor behavior is not exercised by this target specimen.

[designed: T28] Capture the two AEB8 refreshes in T04-week-r0017, selected because
T25-r0006's [14,8,1] replacement includes a measured logical rearrangement. Bind
T26's selected record and the complete upstream manifest, and reproduce all
retained T26/T25/T23/T22/T20/T16/T08/DOSBox-X evidence for this week. New root
snapshots contain complete T26 context, actor/secondary and CPU class.

[designed: T28] Availability observations include the actual roster, canonical
player fields and return byte; swap observations contain normalized side/slot
arguments and typed before/after participant values. A scene exchange is decoded
into individual fields rather than exported as memory bytes. Local role cells
are explicitly stack values. Pointer identities are checked while live and never
exported. A mark after the five exchanges records the caller's actual selector
updates. Scene assignments and opaque tail calls retain full named projections.
Callbacks are scoped to the measured 164F frame; opaque descendants are not
mistaken for direct caller events.

[designed: T28] This is a targeted original prefix/boundary observation, not a
Python sorting/effects model, complete native AI replay or all-25-refresh census.
Remaining weeks, opaque helper inputs and physical/scratch/register/render/timer
parity are separate work. Proposed F28 will pin the actual transaction/selector/
helper census and observed limits after capture.
