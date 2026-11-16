# Fresh-friendly post-match source capture

[confirmed: accepted T66/T67, research430e992; native T84 at22d39634]
The saved Blackburn–PSG friendly is a different source from the historical
league profile. T67 authenticates its3825 ticks,158992 draws,748 player actions
and actual EBE2 return. Those named states do not include every operand needed
by the enclosing post-match caller. T88 observes that actual original caller;
no native admission or branch is enabled by a partial source run.

[designed:T88] `fresh_postmatch.py` restores the T66 private start only after
state/release/campaign identity checks. Actual draw events, tick entry/output
and player actions are compared incrementally with accepted T67. Comparison
values never initialize guest memory or its RNG. The already-enabled watch
setting is retained; no game data, background, clock or code patch is made.
After the actual match returns, the generic T86 numeric observer follows the
original EBE2 push/call and E679→EBE6; branch selectors and counts are observed,
not borrowed from either the league or quick-friendly source.

[designed:T88 recovery] Machine capture runs only at `Week.play`'s existing
`on_boundary`, after Guest.run returns and instruction-budget/timer accounting
is complete. Pending tick/action observations are retained. Stopping inside
emu_start and then resuming would lose the remainder of its budget accounting;
this recorder does not do that. Public receipts contain source/producer file
identities, verified-prefix counts/digests, site/registers/memory digest and
private SHA256. Machine memory, files and Unicorn context remain ignored.

A resume requires the exact receipt committed in the current Git history;
an unpublished/modified receipt cannot authorize pickle loading. Source,
producer, prefix/cursors, runtime2.1.4 and private byte digest authenticate
before deserialization. Restored source, counters, PC, registers and memory
must match the receipt, and loaded original code is authenticated again.
Expected source identity is copied at the protocol boundary so a mutable
receipt cannot change the expected identity. Prefix digests summarize already
compared actual observations; they are not game-state setters.

[confirmed:records/T88/source-r0001/result-r0001.json and checkpoint-r0003.json]
The first measured prefix safely paused at72 verified ticks,1875 draws and12
actions, then authenticated restoration reproduced its exact state at24BC:0C58.
The observed prefix took210.82seconds, so completing the source is a long run.
This is prefix/recovery evidence, not a completed fresh post-match contract.
Private checkpoint backups have owner-folder/non-sharing metadata and byte
readback verification; only their digests and status enter public records.

[designed:T88 public validation] The generic caller checker reconstructs only
observed memory reads/stores, pool/parent bindings, ordered seed writes and
literal callee draw/write spans. It implements no game or RNG algorithm.
Accepted T86 is a test of that shared numeric protocol, not initialization of
a fresh machine. Partial runs refuse completion. Full acceptance still needs
the natural complete fresh prefix and independently restored suffix/caller
with sealed public output digests. Until then `--check` deliberately refuses.

```sh
T88_CHECKPOINT=$(git ls-files 'records/T88/source-r0001/checkpoint-r*.json' | sort | tail -n 1)
test -n "$T88_CHECKPOINT"
.cache/venv/bin/python runtime/emul/fresh_postmatch.py \
  --run records/T88/source-r0001 \
  --resume "$T88_CHECKPOINT"
.cache/venv/bin/python -m pytest -q tests/emul/test_fresh_postmatch.py
```

[designed:next native work, diegoami/onenil#191] Authenticate early dependencies
for the actual friendly caller footprint, preserve existing known/computed
values and its real retained parent, then establish continuing native parity
before changing profile/competition/injury guards. Edited and halftime variants
need their own source coverage. Campaign schema, atomic persistence and weekly
player enabling remain later gates. No completed game or season is claimed by
this research capture.

## Session-safe recovery operations

[confirmed:T88 recovery inspection,2026-11-16] Tool session IDs and code-mode
backup monitors do not survive every environment/session renewal. A running
identifier in an old checkpoint is not proof of a live or completed capture.
Inspect fresh checkpoint/result files and actual process identity before
starting anything. Do not launch a duplicate. A missing tool handle plus stale
checkpoints is a recovery boundary, not evidence that the caller completed.

[designed:T88] The resume command above selects the newest **committed** receipt;
untracked receipts must first pass prefix validation, private byte-digest
checks, backup/readback and publication. A resume deliberately rejects a
receipt that differs from its Git blob before deserializing the owner pickle.
Use the latest checkpoint comment for current status; this document does not
name a permanently current process or recovery cursor.

Private locations are recorded only in the ignored
`.cache/T88/source-r0001/drive-index.json`. Its `files` map covers individual
backups and archive-backed members. For an archived member, use
`archive_members` and `archives`, verify the archive SHA256, extract only the
named ordinary member into its expected ignored path, then verify its member
SHA256 against the public checkpoint. The public backup receipt exposes only
digests/status, not private Drive locators. Do not copy ignored locator metadata
into public comments or PRs.

Keep the backup/publication worker independent from scientific acceptance.
It must stop publication on any failing prefix/original-byte check, verify the
private destination is unshared and compare actual downloaded bytes before
publishing a backup claim. Do not assume that worker continues after clearing
a session. Recreate monitoring explicitly after verifying the source process.
The original capture and its backup monitor are separate jobs.
