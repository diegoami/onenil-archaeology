# Where artifacts live

[designed: owner, 2026-10-29, as in goal2] Everything the project needs is in the repository, so a
fresh clone (a cloud session included) has it, except private original-game artifacts and savestates.

| What | Where |
| --- | --- |
| The project's own outputs: findings, run records, measurements, reports, fixtures holding no original byte; listings and decompiles generated from the unpacked executables (CLAUDE.md rule 14) | **Committed** |
| The unpacked executables | Regenerated into `.cache/` by `tools/static/unlzexe.py`, never committed |
| The same, over ~50 MB | A **GitHub release**, linked from the document that uses it |
| The original game's bytes: One-Nil 95 and 96 (`1-095.EXE`, `1-0.EXE`, `ALTER.EXE`, `INSTALL.EXE`, `HELP.EXE`, the league data `*.DAT`, `1-0.PAL`, `1-0.TFN`, the saves `SAVE1.1-0`), emulator savestates and anything embedding them | The owner's **private Google Drive folder** `1-0`, pulled into the git-ignored `.cache/` |

The repositories are public and the game is copyrighted: its bytes never enter git or a release
(`tools/check_originals.py` refuses tracked files of its types).

## The Google Drive folder

[The folder](https://drive.google.com/drive/folders/1IyIUQBE_Clkv6aBizULKIymRzHBLd4U8) (`My Drive/1-0`,
on the owner's Windows machine `G:\Meine Ablage\1-0`) holds `One-Nil95/` and `One-Nil96/`. Its
location is `artifacts.json`.

- With [rclone](https://rclone.org), once per machine: a remote `onenildrive` of type drive whose
  root is that folder (`rclone config create onenildrive drive scope=drive
  root_folder_id=1IyIUQBE_Clkv6aBizULKIymRzHBLd4U8`, a browser login). Then
  `python3 tools/artifacts.py pull` copies the folder into `.cache/`, `pull One-Nil96/1-0.EXE` one
  file, `push .cache/<file>` uploads one, `where` prints the location.
- By hand: copy the folder from Google Drive into `.cache/`.
- In a cloud session: create the remote with a token from a configured machine, kept in a secret,
  never committed.

**What the login can reach.** A remote created with `scope=drive` holds a login to the owner's
whole Google Drive: `root_folder_id` only sets where rclone starts, it is no security boundary. Keep
such a token on the owner's machine. For CI, use a Google service account that the folder alone is
shared with (it sees nothing else), never the owner's own token.

rclone's shared Google Drive client_id is being retired during 2026: give the remote its own
client_id (`client_id`/`client_secret`, https://rclone.org/drive/#making-your-own-client-id) before then.

## Restoring on another computer

Public Python checks and Rust replays use committed decoded fixtures and need no Drive login.
For new original-code runs, configure the private remote as above, then restore the whole folder
from the archaeology checkout:

```sh
python3 tools/artifacts.py pull
```

The full pull preserves the folder layout, including `.cache/One-Nil96/` and `.cache/states/`.
For a smaller restore, the equivalent directories can be copied explicitly:

```sh
rclone copy onenildrive:One-Nil96 .cache/One-Nil96
rclone copy onenildrive:states .cache/states
```

A named `tools/artifacts.py pull NAME` writes that file's basename directly under `.cache/`;
it is not a directory restore. The harness expects the game directory above, and
`runtime/emul/match.py` searches `.cache/states/` recursively for each run's recorded
`start_state.sha256`. Use the recorded hashes to identify states rather than relying on another
machine's absolute paths. The T04 states are stored under `states/T04/` in Drive. Run records
also identify the game-file hashes used by each capture.

No credentials, original bytes or private savestates belong in a git commit, public attachment
or release. A checkpoint records the verification receipt and whether any private artifact is
still only local; build environments and disposable caches are not transfer artifacts.
