# Continuing edited original watched prefix (T70)

[confirmed: runs/T70/reference-r0001/attempt-0001-bounded.json and attempt-0002-bounded.json]
Two independent original executions reproduce64 watched ticks,1,670 ordered RNG draws and
three observed actions for T69's exact Pearce/Hendry exchange. Both stop at the actual observed
tick boundary0AB9:7B79 with identical named state. This is a bounded prefix, not full time.

[designed] The observer pins both accepted T69 preparation records, authenticates the unchanged
original release/private start and complete committed producer closure, reconstructs the exchange
through original IRQ1 keys, then joins actual preparation draws/entry to T69. It traces one
continuing original image/RNG; expected observations are never written into guest state.
No gameplay data or RNG is patched. Existing calibrated Guest BIOS/DOS/timer/keyboard services
remain as in T66/T67. Repeat receipts bind each independently recomputed chunk; corrupted source,
entry/RNG/tick/stop/key/producer/receipt data and false full-match claims refuse.

Public checks (no original assets):

```
python3 runtime/emul/edited_watched.py --check-bounded --directory runs/T70/reference-r0001
python3 -m pytest -q tests/emul/test_edited_watched.py
```

Original execution additionally needs existing private T66 recovery with start RAM SHA
7a66ef10043b0a6da9312b8f729a5c4e6009096d955c1f7f4a7cf9b2507a78fc and the original96 release.
The default run stops after64 ticks. Use a new directory for a new stream; --repeat verifies an
existing bounded stream. Metadata, chunks, attempts and receipts are append-only. A restart
replays from the authenticated start, verifies existing chunks and refuses any divergence.
The writer has no git/publication action.

[designed] A subsequent frozen full-match task can continue this exact stream safely:

```
python3 runtime/emul/edited_watched.py --run <private-start.sav> --directory runs/T70/reference-r0001 --continue-full
python3 runtime/emul/edited_watched.py --run <private-start.sav> --directory runs/T70/reference-r0001 --continue-full --repeat
python3 runtime/emul/edited_watched.py --check --directory runs/T70/reference-r0001
```

These are continuation commands, not a claim of completed edited-match evidence. Full mode
must reach the actual original match return, produce its complete index/final state and then
independently repeat every chunk. Preserve all bounded leaves when extending the stream.
Any new decoded payload requires its publication authorization/checks. A later native task
must resolve edited incoming-support ownership and full parity; current edited-XI admission
remains refused. No week progression or other post-match effects are inferred.
