# F39 Original watched action prefix for detailed player commentary

- **Status**: proposed
- **Task**: T39 (#129)
- **Edition**: 96.
- **Sources**: T38 original reference at d9e20a4;committed observer34d751841799343d0f5a6808b1cec09d27106c2b;completed `runs/T39/T39-r0003.json`,`traces/T39/index.json` and `actions.jsonl`;static source pins in the index and `semantics-index.json`.

## Answer

1. [confirmed: T39-r0003] Enabling original config+F2 at E24C changes the
   retained reference into the watched path. All258 original setup draw
   requests,callers,seed transitions and results remain identical to T38.
   The first watched tick has quick-mode byte0. The run intentionally stops
   at32 accepted numeric action events,after171 watched ticks and7,248 draws,
   covering elapsed clock0–4. No original match result is claimed.
2. [confirmed: same capture] The prefix contains one kickoff-taker event,
   three collections,five runs,six tackles,four ball wins,one knock-on,one
   interception,two evasions,three receiving-pass events,three possession
   events,two further pass events and one clearance. Counts are original
   numeric-code counts,not invented chances or inferred clock messages.
   No shot or goal occurs in this prefix;those meanings remain static here.
3. [confirmed: original0F94/0E45 and capture] Code/side parameters are bytes,
   while the two roster slots are words. SP+6 supplies queue primary and
   SP+4 supplies queue secondary. Upper side bytes can be FF or01 and are
   ignored by original code. Independent entry roster reads match both
   completed queue identities for all32 accepted events. Slot0 is a valid
   absent identity. Text marker1 names queue primary;marker2 names secondary.
   A second player is not automatically an assist or fouled opponent.
4. [derived: original dispatch and F10] Detailed actions come from the
   watched7A02/72BB/action-and-motion path. The current native DD02 quick
   backend does not produce this sequence. Adding wording around its clock,
   or replaying this prefix behind the viewer,would not implement the engine.
   A native port needs a complete first-tick admission/reached read sets and
   the actual action/motion computations;first-tick observations here are
   assertions and a starting read-set description,not a complete admission.

## Scope and failed attempts

[confirmed] T39-r0001 was an extra test-side original run caused by an unsafe
resume test,then interrupted;its mocked `code_commit: unused` cannot establish
producer identity. T39-r0002 aborted because the observer misread parameter
width/order and attempted an unmapped identity lookup. Both remain unchanged
with limitations notes;neither is accepted behavior evidence. A genuine
byte-width/slot-order red test precedes the corrected capture. The corrected
resume test forbids constructing an original Week after a completed index.

[designed] This deliberate watch-on intervention is not DOSBox parity for this
reference. Timer behavior is scoped to the recorded20,000,000-instruction clock;
F10's separate watched reference does not establish this prefix's full-match
outcome. No full watched/native/player-motion parity follows. Prior quick
results and evidence are preserved. Native issue62/35 remains open for actual
detailed play-by-play;the existing summary preview does not satisfy the owner.
