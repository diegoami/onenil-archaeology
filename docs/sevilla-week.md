# T93: the Sevilla week's full-time route — cash, news, the week transaction and the week-2 state

Task: [docs/tasks/T93.md](tasks/T93.md) · issue [#212](https://github.com/diegoami/onenil-archaeology/issues/212) ·
branch `task/T93-sevilla-week`. The native boundary this addresses: onenil T91
(8cf2de3) admits the witnessed Sevilla friendly and then refuses the week
transaction, naming the unwitnessed second-week cash movement.

## What the original does, as evidenced here

**The route.** From the pinned preparation savestate (sha256 98275eb5…, the T89
boot gate unchanged) the capture replays the Sevilla friendly, runs the
original's post-match caller under the sealed T89 observer, and continues the
same machine through the week's full-time route: the full-time commentary,
CASH FLOW, TRANSFER NEWS and the week-2 management menu (8 keys after the
caller; no unsupported service). `runtime/emul/sevilla_week.py`.

**The match and the caller.** [confirmed: runs/T93/sevilla-week-r0003] Every one of the 62 chunks reproduces the
sealed `runs/T89/sevilla-r0001` payload digest (3,927 ticks, 169,996 draws, 855
actions, Blackburn 1–1 Sevilla); the caller's frame, census (2,275 reads, 409
writes, 431 initial fields) and preservation equal the sealed T89 record.
`sevilla_week.py --check` re-validates all of it without a private file.

**The second week's cash movement.** [confirmed: runs/T93/sevilla-week-r0003; runs/T93/week-suffix-r0003] Club funds
move **421,491 → 421,631**. CASH FLOW shows: in **69,410** (gate receipts
only); out **69,270** (player salaries 57,320, staff salaries 4,200, ground
maintenance 7,750); overdraft facility 2,920,000. The funds on the screen equal
the projected club cash and the management menu's MONEY. The outgoings equal
week 0's (69,270) because they are the weekly wage and upkeep bill; the
receipts differ (week 0: 38,761), and the entry gate refuses the week-0 pair
by name, so nothing is transplanted.

**The following fixture and the week byte.** [confirmed: same records] The decoded fixture
triples are indexed by week: slot 0 = week 0 (opponent 17, flags 65), slot 1 =
the Sevilla week (opponent 176, flags 64 once played), slot 2 = **week 2,
competition 1, opponent 28 (Celtic), flags 0**, slot 3 = week 3 (opponent 49,
flags 1). The week byte is **already 2 at the caller boundary**: the advance
happens when the original enters fixture preparation (T89's pre-advance
finding), not in this route. The boundary's next fixture and the menu's are
identical (slot 3 in the projection's 1-based numbering, club 130, Celtic,
venue code 0, opponent flags 1). The menu reads Friendly #3, away.

**The weekly condition refresh.** [confirmed: records/T89/boot-r0001.json and runs/T93/week-suffix-r0003] Between the
preparation boundary and the week-2 menu **10 of the 18 managed players'**
signed condition values change (2581: 9→15, 2583: 26→28, 2584: 14→18,
2586: 21→25, 2587: 11→12, 2589: 19→21, 2591: 27→31, 2593: 5→6, 2594: 10→11,
2598: 13→14). [confirmed: the same records' caller-boundary projection] **None** changes after the
post-match caller returns: all ten changes happen during the match and its
post-match caller (whose condition work, 36 calls in two contexts, the T89
record seals); these records do not separate the two. The full-time route
adds no further refresh.

**The week-end save.** [confirmed: runs/T93/week-suffix-r0003] The original writes `SAVE1.1-0` (194,426 bytes,
sha256 c0c3a6a3…) during the route, as the T81 week-0 route did.

**The restored repeat.** [confirmed: runs/T93/sevilla-week-r0002/checkpoint-caller.json, runs/T93/week-suffix-r0003, runs/T93/sevilla-week-r0003]
The suffix restored from the r0002 caller-boundary checkpoint, run in a
separate process, and the complete r0003 run observe the same week facts
(cash, movement, triples, conditions, seed word, save digest).

## How the capture got here — what the runs taught

[designed: T93] Each attempt is its own run directory and stays as recorded
(rule 13).

| Run | What it showed |
| --- | --- |
| aborted-r0001 | false abort: the identity compared file digests with payload digests (fixed: payload layer) |
| aborted-r0002 | the processor runs for every fixture of the round (observer stand-down); then `UC_ERR_INSN_INVALID` on the sixth key |
| sevilla-week-r0001 | killed at chunk 59 by a host out-of-memory event; its driver would also have aborted at the match return (`tail.Complete` wrapped as a fault) |
| sevilla-week-r0002 | match and caller exact; boundary checkpoint written; the same fault at `2864:B941` on the sixth key |
| week-suffix-r0001 | restored on a fresh instance the route reaches the menu; the cash parser concatenated two fields per row |
| week-suffix-r0002 | the week facts read the Sevilla slot instead of the live week's |
| week-suffix-r0003 | the complete week route |
| sevilla-week-r0003 | the complete run `--check` accepts |

**The emulator fault.** [derived: scratch diagnostics from the r0002 checkpoint, no records]
The fault was the harness's, not the game's. The NumericAudit's two
memory-read hooks exclude only the first caller's stack window and stay
installed after it stands down; in Unicorn 2.1.4 a read hook over the live
stack can re-enter RETF (the T84 note in `postmatch_tail.py`). Restored on a
fresh instance the route completes; the same two no-op read hooks alone
reproduce the fault at the same address and key; the global write hook alone
does not. [designed] After the boundary checkpoint the run continues the
identical machine on a fresh Unicorn instance (`fresh_instance`): position,
registers, all memory and the draw count are verified equal; only emulator
hooks and translation caches are dropped.

**Driver corrections, each with a control that failed before:** the fault
wrapper passes `tail.Complete` through; the route counts the week as started
at PLAY GAME (otherwise the week-2 menu starts Friendly #3); the cash screen
reads each labelled field to the row's next label; the following fixture is
the live week byte's slot, cross-checked against the projection; `check()`
authenticates the following fixture's four typed fields (the recorded one
carries its name), and compares the match's draw count — the last
digest-verified chunk's `draw_end`, 169,996 at the caller return, where the
sealed identity counts — instead of the route total (186,963), which the week
route extends. Before these two `check()` corrections no complete run could
pass.

**Resume.** A run that dies is followed by a new run
(`sevilla_week.py`, the next unused `sevilla-week-rNNNN`). A run that reaches
the boundary writes `checkpoint-caller.json`; `--resume <it>` repeats the week
suffix into `week-suffix-rNNNN` after the committed receipt, the private
image's digest and the Unicorn version authenticate and the restored machine
equals the receipt. The private checkpoints stay machine-local and git-ignored
(`.cache/T93/`); no `onenildrive` remote is configured on the capture machine.

## What this witnesses, and what stays refused

[derived] Witnessed for the native campaign's second week transaction: the
cash movement (+140: in 69,410, out 69,270), the week-2 Celtic advertisement
(already live at preparation), the managed roster's condition values after
the week, and the original's week-end save. Transfer news rows are week output
this run displays (five moves between other clubs), not a rule.

Still refused, with no evidence here: a third match (Friendly #3 at Celtic is
advertised, never played); edited-lineup or halftime-replacement variants of
the Sevilla route; anything past the week-2 advertisement (the following
week's cash, conditions or fixtures); a generalisation of the weekly costs or
gate receipts to other weeks or clubs.
