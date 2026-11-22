"""[evidence] T98/#214 probe: does deleting the numeric audit's hooks restore the
week route on the same Unicorn instance?

Both phases restore the digest-pinned r0002 caller-boundary checkpoint, install
the audit's own three hooks with inactive (no-op) callbacks over the window the
sealed caller's entry registers give, and then drive the committed week route.

  --phase hooks   keeps the hooks: reproduces the T93 fault (documented here).
  --phase closed  deletes them first with NumericAudit.close: the route must reach
                  the management menu and reproduce runs/T93/week-suffix-r0003's
                  week facts.

Records are new files under records/T98/ and never overwritten. Run it only when
no original capture is running; it drives one emulated machine, not DOSBox.
"""
import argparse
import hashlib
import json
import platform
import subprocess
import sys
import time
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT/'runtime/emul'))
import checkpoint  # noqa: E402
import postmatch_tail as tail  # noqa: E402
import sevilla_week as week_route  # noqa: E402

RECEIPT = ROOT/'runs/T93/sevilla-week-r0002/checkpoint-caller.json'
CALLER_RUN = ROOT/'runs/T93/sevilla-week-r0002'
SUFFIX = ROOT/'runs/T93/week-suffix-r0003'
RECORDS = ROOT/'records/T98'


def ran(data):
    return hashlib.sha256(data).hexdigest()


def sha(path):
    return ran(Path(path).read_bytes())


def primary_checkout():
    """The private artifacts live in the repository's main worktree, not in a
    temporary fix worktree; records are still written under this checkout."""
    listing = subprocess.check_output(
        ['git', '-C', str(ROOT), 'worktree', 'list', '--porcelain'], text=True)
    first = next(line for line in listing.splitlines() if line.startswith('worktree '))
    return Path(first.split(' ', 1)[1])


def committed(relative):
    return subprocess.check_output(['git', '-C', str(ROOT), 'show', 'HEAD:' + str(relative)])


def restored():
    """Restore the private boundary machine with the receipt's own checks."""
    relative = RECEIPT.relative_to(ROOT)
    if RECEIPT.read_bytes() != committed(relative):
        raise ValueError(f'{relative} differs from HEAD')
    receipt = json.loads(RECEIPT.read_text())
    private = primary_checkout()/receipt['private_path']
    if receipt['schema'] != 'sevilla-week-checkpoint/1' \
            or receipt['unicorn'] != tail.unicorn.__version__ \
            or sha(private) != receipt['private_sha256']:
        raise ValueError('private checkpoint digest/runtime differs; not deserializing')
    saved = checkpoint.read_private(private)
    if saved['producer'] != receipt['producer'] \
            or week_route.progress_digest(saved['progress']) != receipt['progress_sha256']:
        raise ValueError('private/public checkpoint identity differs')
    week = checkpoint.restore(saved['machine'], tail.full.match.Week, [])
    g = week.g
    if g.where() != receipt['site'] or tail.prior.registers(g) != receipt['registers'] \
            or ran(g.mem(0, 0x110000)) != receipt['memory_sha256'] or week.draws != receipt['draws']:
        raise ValueError('the restored machine differs from the checkpoint receipt')
    return week, saved['progress'], receipt


def hidden_window(receipt):
    """The window the sealed caller's audit excluded, rebuilt from its entry
    registers: 1024 bytes below SP to six bytes above it (NumericAudit.enter)."""
    finish = json.loads((CALLER_RUN/'finish.json').read_text())
    caller = finish['result']['caller']
    if caller is None or caller.get('entry') is None:
        raise ValueError('the caller record is missing')
    entry = caller['entry']
    stack = entry['ss'] * 16
    return stack + entry['sp'] - 1024, stack + entry['sp'] + 6


def probe(phase):
    week, progress, receipt = restored()
    boundary = progress['caller_boundary']['projection']
    lo, hi = hidden_window(receipt)
    audit = tail.NumericAudit(week)
    audit.stack_lo, audit.stack_hi = lo, hi
    audit.active = False            # no-op callbacks: the hooks alone are under test
    # The sealed audit's own stand-down state: entry recorded and final sealed, so
    # its E679 code hook ignores the route's remaining calls and only the memory
    # hooks remain (seville#214's table).
    audit.entry, audit.final = dict(sealed=True), []
    audit.install()
    installed = dict(hooks=len(audit.hooks), stack_lo=lo, stack_hi=hi)
    if phase == 'closed':
        audit.close()
        installed['hooks_after_close'] = len(audit.hooks)
        if audit.hooks:
            raise ValueError('close() left hooks installed')
    stages, began = [], time.monotonic()
    fault = None
    try:
        week_route.observe_week_route(week, stages)
    except (Exception, KeyboardInterrupt) as error:
        fault = f'{type(error).__name__}: {error}'
    seconds = round(time.monotonic() - began, 2)
    record = dict(
        schema='t98-hook-lifetime-probe/1', issue=214, phase=phase,
        python=platform.python_version(), unicorn=tail.unicorn.__version__,
        checkpoint=dict(path=str(RECEIPT.relative_to(ROOT)), sha256=sha(RECEIPT),
                        private_path=receipt['private_path'], private_sha256=receipt['private_sha256'],
                        producer=receipt['producer'],
                        site=receipt['site'], draws=receipt['draws']),
        hooks=installed, seconds=seconds,
        stages=[dict(screen=stage['screen'], digest=stage['digest'], text=stage['text'])
                for stage in stages],
        keys_delivered=week.g.keys_delivered, draws=week.draws, finished=week.finished,
        fault=fault, week=None,
        scope='One emulated machine restored from a private digest-pinned boundary; '
              'no DOSBox, no original capture, no committed record changed.',
    )
    if fault is None:
        record['week'] = week_route.week_facts(
            week, stages, boundary['cash'], progress['caller_boundary']['projection'])
    RECORDS.mkdir(parents=True, exist_ok=True)
    number = max((int(path.stem.rsplit('-r', 1)[1]) for path in RECORDS.glob(f'{phase}-r*.json')),
                 default=0) + 1
    out = RECORDS/f'{phase}-r{number:04d}.json'
    tail.full.write(out, record)
    print(json.dumps(dict(path=str(out.relative_to(ROOT)), fault=fault,
                          finished=week.finished, keys=week.g.keys_delivered), indent=1))
    # [review #256] the phase contract decides the exit code: the closed phase
    # must complete without a fault and reproduce the T93 suffix facts; the
    # hooks phase must reproduce the documented fault. The receipt is written
    # either way; the exit code says whether the run matched its phase.
    if phase == 'closed':
        if fault is not None or not week.finished or record.get('week') is None:
            return 1
        suffix = json.loads((SUFFIX/'finish.json').read_text())['result']
        for key, value in suffix.get('week', {}).items():
            if record['week'].get(key) != value:
                return 1
        return 0
    if phase == 'hooks' and fault is None:
        return 1
    return 0


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--phase', choices=('hooks', 'closed'), required=True)
    return probe(parser.parse_args().phase)


if __name__ == '__main__':
    raise SystemExit(main())
