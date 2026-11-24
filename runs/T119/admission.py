#!/usr/bin/env python3
"""T119 checker: re-read the league admission record and its bindings.

The extraction lives in runtime/emul/league_admission.py; this checker is the
task's stable entry point, so the record is re-validated from the committed
bytes alone (the private savestate is optional).

    python3 runs/T119/admission.py --check
"""
import argparse
import importlib.util
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
RECORD = ROOT / 'runs/T119/admission-r0001.json'
spec = importlib.util.spec_from_file_location(
    'league_admission', ROOT / 'runtime/emul/league_admission.py')
tool = importlib.util.module_from_spec(spec)
spec.loader.exec_module(tool)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--check', action='store_true')
    parser.add_argument('--record', type=Path, default=RECORD)
    args = parser.parse_args()
    if not args.record.exists():
        raise SystemExit('the admission record does not exist yet')
    tool.check(args.record)
    print('the league admission record and its T100/T105 bindings: ready')


if __name__ == '__main__':
    sys.exit(main())
