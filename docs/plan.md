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
| **O-M3a Match engine** | the match can be simulated | the engine read, and its routines and whole seeded matches run in the harness with their traces recorded; onenil's Rust engine replays those traces tick-exactly |
| **O-M3b Season** | the rest of the game can be simulated | squads, transfers, finances, competitions and the other managers `[confirmed]` or `[derived]` to the depth onenil needs |
| **O-M4 Faithful rebuild** (onenil) | onenil behaves like the original | matches identical (or within stated tolerances) on recorded seeds; a season's fixtures, tables, transfers and finances reproduced from a start state |

## The match engine: read here, written in Rust, checked by traces

[designed: owner, 2026-10-29] Unlike goal2, no Python model of the engine is written. This repository
reads the engine (listing, decompile) and runs the original's own code in the Python harness: single
routines on chosen inputs, and whole matches from recorded seeds. Their input/output traces are
committed run records. onenil's Rust engine is written straight from the reading, and its tests
replay those traces; a wrong reading shows as the first tick or call where the traces differ.

## The first tasks

| Task | Milestone | What |
| --- | --- | --- |
| T01 | O-M0 | inventory, hashes, compiler and run-time identification, 95 vs 96 |
| T02 | O-M1 | static base: listing of both EXEs (tool pinned), routines by area (the match engine located first), the 95→96 code delta |
| T03 | O-M1 | data layouts: the league `.DAT` files, `1-0.TFN`, `1-0.PAL`, `SAVE1.1-0` |
| T04 | O-M2 | runtime: the DOSBox-X driver ported from goal2, the first run record |
| T05 | O-M1 | the layouts confirmed by a run: a league block and save blocks read back from 96's memory after a load |
| T06 | O-M2 | the Unicorn harness ported from goal2: the match seeded and run from a recorded state, its draws traced |
| T07 | O-M3a | the match's structure: from `0AB9:E1F2` to its loop and every routine that draws, each draw site named by what it decides (static, with the traced callers as the map) |
| T08 | O-M3a | a trace corpus: the weeks T04 played in DOSBox-X traced in the harness from their own start states, each compared with its DOSBox-X record |
| T09 | O-M3a | the match's ratings: where `D983`'s four values come from, the formula checked against values read in the harness |
| T10 | O-M3a | the watched match: week 1 with Watch match on, in DOSBox-X and in the harness, compared and traced |

T01–T10 are merged. Later O-M3a tasks follow from T07: the engine's routines read one area at a
time (movement, contests, fouls, the result), each with routine traces in the harness, and onenil's
first test replaying T08's corpus. F10 found that Watch match on runs a second engine: T10-r0003's
managed-match window has 67 post-prefix draw sites, three RNG entries and 158,992 draws under its
recorded harness clock, against the quick match's 5,853 (whole watched week: 176,134). These counts
are scoped to those runs; the watched stream's timer dependence remains to be read. O-M3a has two
engines to read. [designed: owner, 2026-10-30] The interim review of T07–T10 comes before further
engine research or onenil implementation; the choice of engine to read next remains open.

## Risks

| Risk | Mitigation |
| --- | --- |
| The match engine is too intricate to read whole | read and run it together in the harness (goal2's route), routine by routine or whole matches |
| The match engine is random | find the RNG and its seed statically (O-M1), then fix it in the harness |
| Editions disagree on a rule | each finding names the edition(s) it holds for; 96 decides (rule 16) |
| A trace format too narrow for onenil's tests | the first harness task (T06) fixes the trace format with onenil's first consuming test |
| goal2's tools assume goal2's layout | port them with tests on both EXEs, never by copying results |
