# F22 Quick substitution dispatch changes state without drawing RNG

- **Status**: proposed
- **Task**: T22 (#90)
- **Edition**: 96.
- **Sources**: static listings at `3223aa9`; `static/1-0-exe/substitution.md`;
  original observer `substitution.py` at `76d6c7f`; six completed runs/exports and
  manifest at `d58d3f0`.
- **Check**: `python3 runtime/emul/substitution.py --check`; public decoded evidence suffices.

`[confirmed]` Six new original weeks reproduce all T16/T20 observations, T08 events
and ordered DOSBox-X waits. The 541 dispatcher calls contain 1,082 managed predicates,
541 keeper predicates, 541 capacity results and **556 A94B entry/return boundaries**.
All dispatcher and child intervals draw zero RNG. The corpus pins every original
state/source/record/fixture identity; earlier evidence is unchanged.

`[confirmed]` Twenty-five AI boundaries change the named projection, within six
dispatcher calls (one per week). Changes include club rosters, scene player assignments,
canonical player flags11, reserve counts and event totals. The other 531 AI
boundaries preserve this projection; this is not a claim that they write no other bytes.
Raw before/after state and ordered arguments expose repeated calls and continuation
within the same dispatcher, including both physical sides across the six weeks.

`[confirmed]` Every captured managed side has pending=0 and its keeper predicate
returns available. No 6A7A prompt or D5D6 editor boundary is reached. Those paths have
static evidence only here. The dispatcher projection records physical side offsets
separately from scene stored-slot arguments and canonical player identities. AI roster
pointers are represented by the side's measured club identity; physical pointer words
and arbitrary scratch/render parity are outside the export.

`[confirmed: static]` The helper 4759 returns an unsigned wrapping word sum of reserves
and allowance minus substitution flags. A signed negative event-total word always lies
below the AI's zero-extended time threshold. Pending gates managed work but is not
cleared by 6B2F. These details must survive a native translation.

`[derived]` T20's zero-draw observation does not justify omitting substitution effects
from a continuous quick step. A native dispatcher that diagnoses every reached A94B
cannot replay the original corpus's changed state. T22 records A94B as an opaque
boundary, not a complete input contract for its algorithm.

`[designed]` The next bounded research task must capture the reached A94B closure:
reserve/candidate selection, player P8 context, availability helpers, actual limits,
D076 candidates, cache/event-total movement and AEB8 replacement effects (plus any
reached A837 fallback). It must preserve these T22 boundaries before a native task
claims their logical replay. Managed prompts, 78B7 keyboard, complete DD02 integration,
match/week/setup and arbitrary physical state remain separate work. F22 remains
proposed until independently checked and accepted.
