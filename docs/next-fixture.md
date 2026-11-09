# The original next-fixture lookup after a completed friendly week

[designed:T82, issue#196] What the original advertises as the next opponent and
week after the completed friendly — the lookup native B5's week advance may
use. The decoded record lives in `records/T82/next-fixture-r0001.json`,
chained to the committed T81 session (runs/T81/session-r0007.json) and its
post-week save by digest.

## The decoded lookup

[confirmed: records/T82/next-fixture-r0001.json, producer4a15aaa] The static
rule documented in campaign-seed.md — the club's fixture triples at
D7CA+club×174+(week+1)×3−177 as competition/opponent/flags — decodes the
supplied campaign's fixture sequence for club 130 exactly:

- week slot 0: competition 1, opponent 17, flags 1 — the played friendly
  (away at P St Germain); the reciprocal club-17 row carries opponent 130
  with the complementary flags, confirming the pairing.
- week slot 1: competition 1, opponent 176, flags 0 — **the following
  fixture**, which the original's management menu advertises as
  `Next opponents: Sevilla-------- / Aragones` and `Friendly #2` in the
  committed T81 menu text.

[confirmed: same record] The week bookkeeping advances exactly once: the week
counter byte at game[D7D2]+0 is 0 before the week and 1 after it, and the
played slot's flags byte gains the played marker (1→65 for club 130,
0→64 for club 17) on both clubs' rows in the post-week save, whose digest is
chained to the committed T81 timeline. The recorded cash movement
(452,000 → 421,491) is T81's week transaction.

## What native B5 may use

[derived] For the week after the played friendly the native campaign sets the
following fixture to the witnessed triple (competition 1, opponent 176,
flags 0 — Sevilla, managed by Aragones, per the original's own menu text),
advances its week index exactly once, and keeps the played fixture recorded
with its played marker (the native's `played_fixture` receipt is the
equivalent bookkeeping). One friendly week's lookup: nothing here
generalises into a scheduler, a season rollover, or a transfer-market rule.
