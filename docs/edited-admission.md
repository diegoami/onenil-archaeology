# Keyboard-edited initial campaign preparation (T69)

[confirmed: runs/T69/admission-r0002.json and admission-r0003.json] Two independent executions
of original One-Nil96 exchange first-team slots1/2 (zero based), I Pearce2582 and C Hendry2583,
through the original IRQ1 keyboard handler. Both retain observed role2. The complete campaign
projection differs from supplied SAVE1 only by that exchange; fixture, players, instructions,
roles, cash, week and namespace are unchanged. No gameplay data or RNG is patched. The existing
calibrated Guest BIOS/DOS/timer/keyboard services remain in use, as in accepted T66.

The eight UI witnesses cover the initial main menu, squad, source selection, PUT HERE,
destination, placement, main return and explicit PLAY NEXT GAME selection. Seven edit/navigation
keys are followed by the original preparation's two Returns. The original UI consumes no RNG.
Returning from Players leaves that menu selected; an explicit Up selects PLAY NEXT GAME.
The initial run r0001 reached preparation but its extra Down navigation was rejected by the
public key contract. It and navigation-audit-r0001 remain immutable and are not accepted evidence.

[confirmed: the accepted pair compared by edited_admission.py] All11 original preparation
boundaries, typed inputs/context, ordered258 RNG draws and first watched entry reproduce exactly.
The draw stream also equals unchanged T66 preparation:255 selector draws and three subsequent
setup draws. The edited request reaches the actual watched scenes: scene2 identifies Hendry2583
and scene3 identifies Pearce2582, reversing the unchanged entry's two defenders. These entry
values are assertions, not incoming state for a native engine.

[designed] The public checker authenticates the original release/T65/T66 recovery identities,
complete committed producer closure, exact campaign edit, UI/key census, selected-squad and
role/instruction projections, RNG/boundary joins and first-entry aliases. Public corruption tests
cover source, UI, roster/admission, entry seed, IRQ1 keys, payload digest and producer closure.

```
python3 runtime/emul/edited_admission.py --check runs/T69/admission-r0003.json --compare runs/T69/admission-r0002.json
python3 -m pytest -q tests/emul/test_edited_admission.py
```

A new original run additionally needs the private original release and preserved T66 start RAM
(SHA7a66ef10043b0a6da9312b8f729a5c4e6009096d955c1f7f4a7cf9b2507a78fc). Reuse the existing
private recovery documented by T66; neither original RAM nor original save/binary files enter git.
Use a new output path; records are never overwritten:

```
python3 runtime/emul/edited_admission.py --run <private-start.sav> --record runs/T69/<new-name>.json
```

[derived] This closes only the original edited-preparation evidence boundary. Next capture a
continuing original match and independently verify it, resolve any changed incoming read support,
then establish native preparation/full-match parity for this exact edited case. Existing native
admission remains strict; neither arbitrary edited XIs nor a completed edited match is claimed.
Week progression, managed substitutions and other post-match effects remain separate.
