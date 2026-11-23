#!/usr/bin/env python3
"""T117: the league week in the harness - match.py's closed loop with the week
starting at a match preparation screen (PLAY GAME highlighted) instead of the
main menu. The only behavioural difference is `started`: a friendly run begins
at the main menu, so PLAY NEXT GAME there marks it started and the menu that
returns after the week finishes the run; a league run begins at the preparation
screen (the T100 machine), so the loop must consider the week started from the
beginning and the management screen that returns after match #28's week ends
it - otherwise the loop would advance into match #29.

The start state is the T100 preparation savestate (its screen digest is pinned
below from runs/T100/preparation-r0001.json; the probe, runs/T117/probe.py,
proved the harness decodes that savestate byte-identically to the DOSBox
capture). Everything else - journaling, checkpoints, the trace, the run record,
resume - is match.py's own machinery; run it with the same arguments:

    python3 runtime/emul/league_week.py --state <sha256> [--out traces/T117]
        [--runs runs/T117] [--experiment T117] [--resume <partial receipt>]
"""
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import match  # noqa: E402
import guest  # noqa: E402

# runs/T100/preparation-r0001.json 'preparation'.'screen_sha256': the match-#28
# PLAY GAME machine's text page, as the DOSBox driver recorded it.
PREPARATION_SCREEN_SHA = 'ac0e084ebed8f0481e1d6638e12fff1a5cc2b6caa2ddd576d727b230c1d71f5a'


class LeagueWeek(match.Week):
    """A week that starts at the preparation screen (review T117: started must
    be true from the beginning - the loop's only other setter is the main
    menu's PLAY NEXT GAME, which a preparation start never passes)."""

    def __init__(self, data):
        super().__init__(data)
        self.started = True
        first = self.g.screen()
        if first.digest() != PREPARATION_SCREEN_SHA:
            raise guest.GuestError(
                f'the start state is not the T100 preparation machine: the '
                f'decoded screen digest {first.digest()[:16]} differs from '
                f'{PREPARATION_SCREEN_SHA[:16]}')


if __name__ == '__main__':
    match.Week = LeagueWeek
    sys.exit(match.main())
