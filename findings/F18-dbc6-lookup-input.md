# F18 DBC6's reached final lookup cell has supplementary original inputs

- **Status**: proposed
- **Task**: T18 (#82)
- **Edition**: 96.
- **Sources**: DBC6's listing at `321b495`; observer `extra_event_inputs.py` at
  `f2889b8`; `runs/T18/T18-r0001.json` and `r0002.json`, exports and index at `b41656a`.
- **Check**: `python3 runtime/emul/extra_event_inputs.py --check`.

`[confirmed]` The RNG wrapper returns 1..10. DBD1 increments that result before DBD8
reads byte D00+index, so the used lookup range is D02..D0B. T17's `opponents` field
contains D01..D0A. Its initial cell is unused, and its missing final cell is reached
by actual captured calls. Expected helper scene arguments cannot supply that raw input.

`[confirmed]` Two new original weeks reproduce the complete T17 call observations,
T08 events and ordered DOSBox-X waits. They directly read byte D0B at all 184 DBC6
entries, preserving each step, input seed and draw position. Every observed value is 2.
The exported cells have explicit T17 record/case digest links; the public checker
validates complete coverage and provenance. Existing T17 runs and exports are unchanged.

`[designed]` A native input loads D01..D0A from the unmodified T17 state and D0B from
its separately pinned T18 input. It follows the original address calculation, rather
than shifting the old array or inferring a constant from expected decisions. This
correction supplies a reached raw input; it does not implement 69B8 or establish full
DD02/match/week parity. F18 remains proposed.
