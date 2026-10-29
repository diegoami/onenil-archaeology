# Plan

[designed: owner, 2026-10-29] What this repository establishes about *One-Nil*, and in what order.
The owner's decisions of 2026-10-29: 96 is the target and 95 a delta (CLAUDE.md rule 16);
listings and decompiles are committed as in goal2 (rule 14); the match engine is researched first;
the plan ends at the faithful rebuild (no bot, no new databases). This page holds no status; the
labels and issues do.

## What shapes the plan

- **Two editions, one codebase.** One-Nil 95 (`1-095.EXE`, 106,784 bytes, 1995-04-18) and 96
  (`1-0.EXE`, 106,962 bytes, 1996-07-03) are both LZEXE 0.91 and unpack to 218,224 and 218,480 bytes.
  Of the files the two folders share, `1-0.PAL`, `ENGL-94.DAT`, `ENGL-95.DAT`, `SCOT-94.DAT` and
  `INSTALL.EXE` are identical; `1-0.TFN`, `ALTER.EXE`, `RUN.BAT` and the save differ; 96 adds
  `ITAL-94.DAT` and drops `HELP.EXE`. A small diff, so one reading serves both, with the 96 changes
  as a delta (T01 confirms all of this).
- **The same studio and compiler as goal2.** Both EXEs carry "(c) new era software" and "Portions
  Copyright (c) 1983,92 Borland" (Turbo Pascal 7 run-time, to be confirmed by T01). goal2-archaeology's
  tools (the LZEXE unpacker, the capstone listing, the Ghidra decompile, the Unicorn harness, the
  DOSBox-X driver) are the starting point, and its run-time library map may carry over.
- **A larger program than goal2.** A club game: squads, transfers, finances, leagues and cups, other
  clubs' managers, and a match engine. The rebuild needs every one of them, not the match alone.
- **The rebuild is Rust, in onenil.** This repository's records are what onenil is checked against.
  The tooling here is Python (CLAUDE.md rule 15).

## Milestones

| Milestone | It proves | Exit check |
| --- | --- | --- |
| **O-M0 Inventory** | we know exactly what we have | T01: every file of both editions hashed; compiler and run-time identified; the 95→96 differences listed |
| **O-M1 Static base** | the code and data can be read | both EXEs unpacked and listed reproducibly; routines indexed by area (match, squad, transfers, finance, competitions, AI, save/load, UI); the league `.DAT` and save layouts proposed, one claim of each confirmed by a run |
| **O-M2 Runtime** | an agent can drive the original | launch → keys → screen read → savestate → reset, repeated with the same hash; a routine of the match run under the emulator harness from a recorded state |
| **O-M3a Match engine** | the match can be simulated | the engine read and run in the harness; seeded matches of `1-0.EXE` reproduced tick-exactly by a Python model of it |
| **O-M3b Season** | the rest of the game can be simulated | squads, transfers, finances, competitions and the other managers `[confirmed]` or `[derived]` to the depth onenil needs |
| **O-M4 Faithful rebuild** (onenil) | onenil behaves like the original | matches identical (or within stated tolerances) on recorded seeds; a season's fixtures, tables, transfers and finances reproduced from a start state |

## The first tasks

| Task | Milestone | What |
| --- | --- | --- |
| T01 | O-M0 | inventory, hashes, compiler and run-time identification, 95 vs 96 |
| T02 | O-M1 | static base: listing of both EXEs (tool pinned), routines by area (the match engine located first), the 95→96 code delta |
| T03 | O-M1 | data layouts: the league `.DAT` files, `1-0.TFN`, `1-0.PAL`, `SAVE1.1-0` |
| T04 | O-M2 | runtime: the DOSBox-X driver ported from goal2, the first run record |
| T05 | O-M2 | the Unicorn harness ported from goal2: a routine run from a recorded state |

T02–T05 are drafts until T01 merges; T02 and T03 can run in parallel, T04 in parallel with both.

## Risks

| Risk | Mitigation |
| --- | --- |
| The match engine is too intricate to read whole | read and run it together in the harness (goal2's route), routine by routine or whole matches |
| The match engine is random | find the RNG and its seed statically (O-M1), then fix it in the harness |
| Editions disagree on a rule | each finding names the edition(s) it holds for; 96 decides (rule 16) |
| goal2's tools assume goal2's layout | port them with tests on both EXEs, never by copying results |
