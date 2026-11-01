# F27 Compact original rating/flag cases need five logical byte inputs

- **Status**: proposed
- **Task**: T27 (#100)
- **Edition**: 96.
- **Sources**: original AFDA helper snapshots in T25 at `9fbab34`, producer
  `ddf4357`; compact projection and static contract at `6f4487e`; original listings
  at `f463c98`.
- **Check**: `python3 tools/static/rating_flags.py --check`; no private game bytes.

`[confirmed: retained T25 observations, projected at 6f4487e]` All 25 original
53FB calls across six weeks are represented by compact cases. Every helper
interval consumes zero draws. All input flags10 bytes are zero. The original
outputs are:

| Output flags10 | Cases |
| --- | ---: |
| 0x00 | 15 |
| 0x11 | 1 |
| 0x32 | 4 |
| 0x80 | 3 |
| 0x91 | 1 |
| 0xB2 | 1 |

`[confirmed: same observations]` Only the target player's P15 byte10 changes in
the named before/after state, in ten cases. Every other canonical player field,
scene, global, selector, roster, event-total and cache field in T25's expanded
projection is unchanged. This is a named-state result, not whole-memory or CPU
register/flags parity.

`[derived: static closed call graph at f463c98]` The complete logical read set is
P8 bytes1,3,5,6 and P15 byte10. 53FB calls 4E0C, conditionally 53C6 and the byte
bit primitives. Their only named write is P15 byte10. The P8+1-below-eighteen path
requires signed interpretation after wrapping 16-bit arithmetic, followed by the
signed-32 maximum with zero. The older path returns a wrapping unsigned byte after
subtracting P8+3's low bit. One-based bit arguments must retain that convention.
The static contract records these operations; Python never evaluates them.

`[derived: zero original input flags and this static graph]` Five outputs have
bit eight set, consistent with five conditional 53C6 executions. No nested helper
entry was captured by this extraction; this is an inference, not a new measured
call-site census. Only the parent helper's original inputs/outputs are measured.

`[designed: T27]` Compact rows retain the original player, week, step, replacement
and helper order, exact record/fixture digests and zero-draw intervals. The manifest
binds the static source hashes and T25 manifest. The checker reconstructs each row
from retained observations, checks unrelated fields unchanged and compares exact
fixture bytes. It does not calculate expected flags. Existing exports cannot be
overwritten; this extraction creates no new original run or private artifact.

`[designed]` This is a logical input/output contract for a later native slice,
not a Rust implementation, accepted finding or claim of full replacement parity.
The original cases have zero incoming flags and P8+1 at least eighteen; pre-set
flags, younger-player arithmetic and other zero/large/wrapping inputs need separate
static/synthetic native checks or targeted original probes. The reached 164F
rearrangement remains a separate major closure before continuous AI/DD02/match/
week integration. No benchmark or original nested-helper replay is claimed.
