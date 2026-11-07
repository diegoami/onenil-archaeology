# Original saved-campaign watched stream (T67)

[confirmed] Accepted T66 at735e976e authenticates the private original start,
supplied campaign, preparation draws and first watched entry. The T67 observer
joins that entry before recording further original execution. Original7C67 is
the watched loop header, revisited through7C94; only its first visit establishes
the preparation join (`seg_0AB9_13.asm`). The existing Guest services and keyboard
dispatch remain; there is no additional gameplay-data or Watch-setting patch.

[designed] This is a source capture, not a Python match model or native runtime
backend. It records original ticks at7A02/7B79, queue actions at0F94/0FFC, ordered
draws and the actual return to EBE2. Player identities come from the original
club and slot arguments. Scores, tick counts and match length are assertions
observed at termination, never incoming constants. A complete reference requires
halftime/full-time evidence and an independent execution of the entire stream.
Additional native incoming read coverage may still require a separate task.

Restore the private start using the T66 recovery described by docs/artifacts.md.
The observer refuses wrong start/release identities or uncommitted dependencies.
Run from a full repository clone with requirements.txt installed:

```sh
python3 runtime/emul/campaign_watched.py --run <private-start.sav> --directory runs/T67/reference-r0001
python3 runtime/emul/campaign_watched.py --run <private-start.sav> --directory runs/T67/reference-r0001 --repeat
python3 runtime/emul/campaign_watched.py --check --directory runs/T67/reference-r0001
```

Original captures can take hours. A stopped first run resumes with the first
command: it recomputes and checks every completed chunk before appending.
It never overwrites existing captures. Independent repeat writes separate
verified-prefix receipts; it cannot extend or change the first stream.
An aborted attempt remains evidence and does not establish completion.

Check and preserve a partial stream while the original runs:

```sh
python3 runtime/emul/campaign_watched.py --check-prefix --directory runs/T67/reference-r0001
python3 runtime/emul/campaign_watched.py --checkpoint-prefix --directory runs/T67/reference-r0001
```

The second command validates complete leaves, scans raw and hex64-byte windows
against the local private originals and commits only new task records locally.
It requires this task's branch and an otherwise empty Git index. It refuses
changed immutable files, unexpected leaves and observer/source disagreements.
It makes no network request. With owner authorization for this trace's public
publication, `--publish-prefix` additionally pushes and posts a checkpoint.
Publishing needs the private original cache for scanning; public prefix/full
verification needs only the decoded repository records and producer history.

Full verification requires the independent repeat; partial verification makes
no completion claim. Neither establishes native full-match parity, arbitrary
edited squads, a desktop campaign-match action, result posting or week changes.
