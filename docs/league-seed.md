# The league campaign seed (T105)

[confirmed:T105, runs/T105/seed-r0001.json] The decoded campaign state behind the
T102 league week, published as data with no original byte:

| Field | Value |
| --- | --- |
| Week | 54 (the live pointer; Newcastle prepared at 53) |
| Club | Blackburn R (id 130), manager Dalglish, season 1994/95 |
| Funds | 1,045,060 |
| Squad | 15 players with the save's own positions, instructions and conditions |
| Prepared fixture | Newcastle Utd, week 53, competition 0 (league), venue away |
| Live next fixture | Chelsea, week 54, competition 0 |
| Table | 16 rows, pre-round and after-round values, with the block layout T103 decoded |
| Round | match 28, the eight captured results and the captured score/cash |

Every block names the receipt it came from: the T100 preparation state digest,
the T101 boot receipt, the T102 week receipt, the T103 table receipt and the
committed T102 results step. `python3 runs/T105/seed.py --check` re-reads the
private state, re-projects the campaign, the two fixtures and the table, and
requires the committed seed to match field for field - it prints `ready`.

[designed] The scope is deliberately narrow: this is the input the native
league-week transaction needs, not a new observation. It carries no other club's
future fixture and makes no ranking claim; the 15-player squad is what the save
holds at this point, not the 18-player squad of the early seed.

The native side can now hold the table and the fixture context without inventing
either, which is what T104's model deliberately left out.
