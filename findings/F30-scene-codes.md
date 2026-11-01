# F30 Scene and cached codes require mode, table and cache context

- **Status**: proposed
- **Task**: T30 (#107)
- **Edition**: 96.
- **Sources**: listings at `0a031ff`; observer/static contract at `5158d91`;
  retained T28 boundaries at `d598c29` and T29 corpus at `d9a59df`; original
  T30-r0001/export/manifest at `fd7d4cd`, producer `5158d91`.
- **Check**: `python3 runtime/emul/scene_codes.py --check`; no private bytes.

`[confirmed: listings at 0a031ff, 0AB9:0000,0143–03E1,1CBB,1CD6,1ECC]`
03BB refreshes all22 physical scenes through02D7, then invokes033E for three
cached codes. Scene code writes occupy bytes4/5, and0143 can also change byte6.
The three cache results are stored at CF32,CF39,CF40, outside T28's projection.
The complete static graph has no RNG, renderer or timer calls.

`[derived: same graph]` T28's scene/player/actor/side/direction context needs the
following additional inputs to close this routine's admitted logical domain:

| Input | Meaning in the static contract |
| --- | --- |
| Byte pointed to by D0C0 | Mode0–4 selection |
| Raw D0AC byte and D0AE word | Signed threshold versus unsigned clock |
| A338/A339 bytes | Raw directional return table |
| 096A–096F bytes | Motion and mode2/mode3 code selectors |
| Fourteen8716 cells | Role-code lookup for valid roles0–13 |
| Cache records CF2E/CF35/CF3C words0/2 | Packed arguments to the three0143 calls |

Cache word4 entry values are additionally retained for before/after comparisons.
The raw D0AE word is also checked against T28's existing named clock alias.
Modes above4 can return uninitialized stack data and are explicitly unsupported;
no synthetic zero is substituted. Invalid-role indexing is outside the contract.

`[confirmed: same source]` Physical scene indices and stored byte7 selectors
serve different purposes. Cache target selection uses actor D09F and side
offsets, while02D7's keeper/side logic uses the stored selector.0143 receives
cache word2 as packed argument A and word0 as B. It adds the scene's entry byte6
to its code before conditionally changing that byte when the arguments differ.
Its direction products retain the low16 bits and use a signed word comparison.
Three ordered cache calls may therefore observe different byte6 values even
when they target the same scene. Caller033E adds0500 to each original return
before storing cache word4; Python does not compute those codes or decisions.

`[designed: T30]` Observe22 direct scene rows, one complete cache-refresh boundary
and three nested cache-code input/output rows per invocation. Normalize pointer
arguments while live and retain actual packed words, scalar returns and draw
intervals. The reader joins exact T28 boundaries, checks literal observed row
continuations and allowed writes, and binds the T29/upstream/static provenance.
It does not implement0207,0143 or033E as a Python engine model.

`[confirmed: T30-r0001 at fd7d4cd]` One original T04-week-r0017 completed and
reproduced all T29/T28/upstream observations, T08 events and ordered DOSBox-X
comparison. The enclosing replacements are[14,8,1] then[13,6,1]. Both03BB
intervals are4025→4025. The corpus contains44 ordered02D7 scene boundaries,
two033E cache boundaries and six nested0143 calls:52 observed helper boundaries,
all with zero draws. It does not count the unobserved nested helpers within02D7.

`[confirmed: same record]` Both cases use mode0, threshold45, clock34, direction
sign bytes[255,1], code-selector bytes[150,140,65,72,17,16] and existing D0C8
direction/code bytes[12,9,10,10]. Fourteen role-code cells are captured but their
mode1 branch is not reached. Potential input closure is not a dynamic table-read
census. Each complete root entry projection equals its return projection,
including the newly captured inputs and all three code caches.

`[confirmed: same record]` All three cache records enter and return with
word0=247,word2=247,word4=1436 in both invocations. All six nested0143 calls
target physical scene1 with packed arguments[247,247], return156, and preserve
byte6 at0. Actor5 and secondary22 are unchanged. The static caller's unconditional
cache stores therefore have the same observed before/after values in this
specimen; this is not evidence that the routine has no writes.

`[confirmed: same record]` All44 direct scene visits enter with words0 and2
equal and byte6 zero. Their before/after fields are identical. The output census
is:

| Scene byte4 | Scene byte5 | Scene byte6 | Visits across both cases |
| ---: | ---: | ---: | ---: |
| 1 | 10 | 0 | 4 |
| 156 | 9 | 0 | 20 |
| 146 | 12 | 0 | 20 |

The four first-row visits use stored keeper selectors1/12. No byte6 toggle,
unequal packed argument, opposite cache target12, threshold-crossing case or
mode1–4 path is dynamically exercised. Those branches need separate static/
synthetic native checks or targeted original probes; no result for them is
invented from this unchanged projection.

`[designed]` Other weeks, unobserved valid-mode/argument combinations, modes>4,
invalid roles, separate nested direction-helper observations, physical scratch/
register/flags/render/timer parity, native implementation, remaining164F helpers
and full rearrangement/AI/DD02/match/week parity remain outside this task.
F30 remains proposed pending an independent check.
