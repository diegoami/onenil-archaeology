# Fresh watched-caller incoming read witnesses (T68)

[confirmed] T66 at735e976e authenticates the private start, saved campaign and
preparation. T68 observes explicit numeric requests at E24C, E008 and7C67 and
requires their named state digests and full preparation RNG/entry to join T66.
The original runs unchanged through existing Guest services and keyboard dispatch.
No expected watched output or older-fixture value supplies these observations.

[designed] Requests contain only `area` and `offset`, with at most1024 locations
per request. They follow the disjoint support policy accepted in native
d42add34 `watched_compiled/prepared.rs`: bounded numeric DS tables and genuine
incoming scratch, configuration fields, counts, results and fixtures. Canonical
players, actors, scenes, ball, queue, seed and ABI remain excluded. Requests may
be split while retaining the same authenticated source joins. This is a named
read-witness protocol, not a whole-memory dump.

[confirmed] Static consumers include0AB9:7B13's22-entry tick list and
0AB9:5641's role-indexed table at0AAA. Original1B55:33C7 reads the display-rating
conversion table at935B. These routines motivate the request locations. Existing
native read-footprint locations bound initial requests; their values are always
read again from the actual fresh original state. Old-fixture values are never
copied. The current fixture kind already belongs to T66's typed income input and
must not be replaced with an older fixture's support cell.

Each witness records `before`, `precall` and `entry`. Only equality across all
three makes it eligible as unchanged incoming support. A changed value is
reported and excluded; its original computation needs native ownership rather
than an imported output. Source record, release, request and producer/dependency
identities, boundary joins, RNG and payload digests validate without original
bytes. Two independently executed captures must reproduce the entire payload.

Restore the private start from the existing T66 recovery described by
docs/artifacts.md. Commit observer, request and dependencies before measuring;
always use new capture paths:

```sh
python3 runtime/emul/fresh_support.py --run <private-start.sav> --request traces/T68/requests-r0003.json --record runs/T68/<new-capture>.json
python3 runtime/emul/fresh_support.py --check runs/T68/support-r0006.json --compare runs/T68/support-r0005.json
python3 runtime/emul/fresh_support.py --check runs/T68/support-r0008.json --compare runs/T68/support-r0007.json
python3 runtime/emul/fresh_support.py --check runs/T68/support-r0010.json --compare runs/T68/support-r0009.json
```

The public checker returns only eligible incoming facts. A native importer must
pin the accepted capture bytes, verify all source/request/projection aliases,
reconcile overlapping requests and retain unknown-read and owned-field guards.
This evidence alone establishes no full native match, edited-XI support,
desktop campaign-match action, result transaction or week progression.
