# Restoring the league preparation machine (T101)

[confirmed:T101, runs/T101/boot-r0001.json] The emulator harness restores the
T100 preparation savestate to the **same screen** the DOSBox capture recorded:
`match.Week(data)` on the digest-pinned bytes (3abfd6b0..., checked against
`runs/T100/preparation-r0001.json`) yields screen digest `ac0e084e...` and text
digest `f2228795...`, both equal to the capture's receipts, with the release
identity (One-Nil 96, `records/T01/inventory.json`) intact. No key is delivered.

The decoded boundary shows the original's **pre-advanced fixture pointer**, the
same shape T82/T89 recorded for the friendly week:

| Row | Week | Competition | Opponent | Meaning |
| --- | --- | --- | --- | --- |
| prepared | 53 | 0 (league) | 122 `Newcastle Utd` | the match on the preparation screen |
| live | 54 | 0 (league) | 103 `Chelsea` | the pointer already advanced one row |

The live week byte is 54, funds `1,045,060`, club Blackburn R, manager Dalglish,
season 1994/95, and the machine's seed word is 18521. The site is the key-wait
loop `24BC:0A23`.

[designed] The restored PIT divisor is 65,536: the savestate predates `PLAY
GAME`, so the game has not yet programmed the timer the way the T89 preparation
state had when it was captured. A match capture must therefore let the game make
that write, not force it as the Sevilla route does for its mid-match state.

`python3 runs/T101/boot.py --check` re-restores the state and re-derives every
fact; it needs the private savestate, so it stays a local check while the receipt
and this document are committed.
