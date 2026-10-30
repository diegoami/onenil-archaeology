# F14 Seventeen original logical goal effects and 34 byte6 helper cases

- **Status**: proposed
- **Task**: T14 (#73)
- **Edition**: 96, quick result.
- **Sources**: `static/1-0-exe/goal-effects.md` (listing at `a39ac70`); recorder
  `runtime/emul/goal_effects.py` at `043ceea`, Unicorn/settings in each receipt;
  completed `runs/T14/T14-r0001.json`–`r0006.json` and corresponding immutable JSONL cases;
  `traces/T14/byte6.jsonl`, digest/index `traces/T14/index.json`; retained T12/T13/T08 evidence.

## Answer

1. `[confirmed]` **Complete numeric logical inputs.** The six original weeks supply 17
   before/after callbacks at `5083`/`5263`. Every new week's events and ordered DOSBox-X waits
   match retained T08; request/coin/draw boundaries match T13 and previously captured player/log
   effects match T12. New inputs include scene byte +7, shared player fields, complete rosters,
   signed tables, event-total/cache views, counters, all scorer-log cells, the fixed three-row
   numeric queue projection and copied word pair. Inputs do not depend on expected outcomes.
   The index links all 15 T08 references through six measured canonical states.
2. `[confirmed]` **Player and cache effects.** Both scorer and conceding-keeper raw player byte
   +6 change in every callback: 34 role updates. The first 11 friendly callbacks leave word +2
   and byte +5 unchanged; the final six league callbacks increment both fields for both roles
   (12 word increments and 12 byte increments). `67D0` sign-extends the old byte, wrapping-adds
   a signed word delta, signed-clamps to 1..255 and stores the low byte. Its cache flag controls
   only the later cache write: the byte6 update still occurs when the coin is zero. The stored
   byte is sign-extended again for `low8(min(value,32))`. One original scorer reaches 33, while
   its cache is 32. All 34 exact helper input/output pairs are exported separately.
3. `[confirmed]` **Logical writes behind commentary.** The `1DB7` path always applies the signed
   event weight to the selected wrapping word in the `D146` view. Structured duplicate detection
   separately controls the `D1C0` count, cyclic numeric queue head/row/sentinel and the paired-word
   copy. These are numeric state changes, not formatted commentary text. All 17 measured events
   use code `0x26` and are accepted; duplicate suppression and alternate-code branches are static
   claims rather than dynamic coverage. The copied words at `D08A/D08C` and `D09A/D09C` have
   pointer usage elsewhere; no coordinate meaning is asserted.
4. `[confirmed]` **Independent selectors and logs.** Actor-argument player updates, global-actor
   commentary selection, scene-byte-7 cache selection, original-side roster lookup and the
   flag-selected log row are separate operations. The scorer log count caps at 11 and later
   events overwrite entry 11; minute marking uses wrapping addition of `0x80`, not OR. All 17
   original callbacks append a log entry and reach counts at most three. Source flags `D1CA`,
   `D0B7`, `D0B9` are zero in this corpus, so side-flip, high-minute and finished-clock branches
   need static/synthetic checks. The conditional wrapping side-byte counter is part of the
   logical projection. No manager/home label is inferred from these different table selectors.
5. `[confirmed]` **Coin projection stays separate.** There is exactly one original `5190`
   underlying draw per callback, with nine true and eight false wrapper coins, matching T13.
   Logical before-state excludes RNG state. A non-RNG consumer can apply the field updates using
   T02's already-consumed coin and retain the post-coin seed unchanged; applying a second draw
   would depart from this contract. The role-input order is preserved so aliased player IDs use
   a single shared record, not independent before-state copies. No such ID alias occurs in the
   17 original callbacks, so that branch is static/synthetic coverage.

## Boundary and limits

`[designed]` onenil T03 consumes these numeric before-states and requests as inputs and computes
after-states. Formatted strings, screen buffers, timer/scratch effects and a renderer remain
external. The logical `D197` cache and `D146` totals are retained because downstream routines read
them; they cannot be discarded merely as UI data. The one-based two-by-20 views and three fixed
queue rows are a bounded projection, not a claim about universal declared array bounds or all
commentary operations. Unsupported scene-zero aliases are outside that projection.

Six consecutive weeks of one save cover 17 callbacks and 34 helper calls. Cache signed-negative
reloads, counter/queue/log wrapping and caps, flag alternatives, selector inconsistencies and
player aliases require static/synthetic checks; no original dynamic coverage is claimed for
them. F14 remains proposed. Full DD02, ratings/clock/event processing, full match/week, whole-
memory/timer equality, renderer/watched-engine parity and O-M3a completion remain pending.
