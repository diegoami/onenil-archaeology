# Owner-run original-manual milestone review

[designed] **OWNER RUNS** this review on the model of their choice. The agent
prepares this prompt and does not execute or delegate the review.

Status: prepared locally. Before submitting, require T59–T62 merged with
approved provenance handling and exact-head green hosted CI. Replace the
candidate references below with the actual checked research merge head. Do not
treat the current local audit as a completed publication/merge gate.

> Review onenil-archaeology milestone#135 against its illustrated-manual and
> workflow-coverage acceptance, using the checked research main head supplied by
> the owner. Start with docs/manual/README.md, coverage-audit.md, native-gaps.md,
> and runs/T62/catalog-r0001.json. Reconcile W001–W083 and all 18 executable menu
> slots against their actual screenshot/decoded-record/key sequences and source
> identities. Check that defaults, controls, state changes, confirmations,
> refusals, cancellation and persistence are supported by original observations;
> inspect examples across setup, squad/tactics, watched/quick matches,
> transfer/contract/youth, administration, competition weeks and actual rollover.
> Check conditional G01–G14 gaps, historical slice limits, incomplete captures,
> isolated save scenarios and the separate .95 history-file limitation. Confirm
> that unknowns are explicit and no promotion/retirement/accounting rule or
> cancellation outcome was inferred from labels or modern football assumptions.
> Audit native status against onenil commit
> a634fb27a2d438c67d20e95cf66aa11bc0737732 and cited handlers/assertions; distinguish
> the accepted watched exhibition and reusable admission guard from absent
> campaign workflows. Evaluate whether B1–B6 provide a defensible next playable
> management-week route and whether the UI decision requirements in native#103
> follow from the documented workflows. Run the public audit/capture/link tests
> needed for your conclusions, inspect immutable preservation and exact-head CI,
> and report all findings with severity, paths/record references, concrete
> counterexamples and acceptance impact. Do not select a UI technology or change
> native behavior. Post the complete findings and an explicit PASS/FAIL on
> milestone#135; required findings become review issues and checked fixes before
> acceptance. If additional original scenarios are necessary, name the smallest
> missing branch rather than demanding another undirected season traversal.

[designed] Public check commands from the research repository:

```sh
python3 runs/T62/catalog-source-r0003.py --check
python3 runtime/driver/manual_session.py --check runs/T59 --route supplied
python3 runtime/driver/manual_session.py --check runs/T60 --route supplied
python3 runtime/driver/manual_session.py --check runs/T61 --route supplied
python3 -m pytest -q tests/test_manual.py tests/test_manual_session.py tests/test_inventory.py tests/test_ui_blueprint.py tests/test_squad_ui_blueprint.py
python3 tools/check_originals.py
git diff --check
```

[designed] The full original-byte embed scan requires the owner's private
artifact cache; do not upload that cache or raw save/RAM bytes to perform review.
Public decoded records and screenshots travel with git. Upload receipts must
describe only operations actually completed under the approved scope. No review
result is filled in here in advance.
