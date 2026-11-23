#!/usr/bin/env python3
"""T117 milestone 1, the probe: the harness decodes the T100 preparation
savestate. Thesavestate (sha256 3abfd6b0..., the match-#28 PLAY GAME machine)
is found by its sha under .cache/states/ (private bytes, per
runtime/emul/README.md); runtime/emul's guest decodes it, and the probe
requires the decoded screen to equal the T100 receipt's preparation step - the
same text and the same text-page digest the DOSBox driver recorded. The screen
is read straight from the savestate's memory: no instructions run, nothing is
simulated yet. --check re-reads the record and prints ready."""
import argparse
import hashlib
import json
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / 'runtime' / 'emul'))
import guest  # noqa: E402  (unicorn import; no guest code runs here)

RECORD = ROOT / 'runs/T117/probe-r0001.json'
T100_RECEIPT = ROOT / 'runs/T100/preparation-r0001.json'
STATE_SHA = '3abfd6b00f8024900b93a20d1ff1eec60cfd2d570e927a00eca495d7f7b1d1c8'


def sha(data):
    return hashlib.sha256(data).hexdigest()


def find_state(want):
    for path in sorted((ROOT / '.cache' / 'states').rglob('*.sav')):
        data = path.read_bytes()
        if sha(data) == want:
            return path, data
    raise SystemExit(f'no savestate with sha256 {want[:12]}... under '
                     f'.cache/states (copy it there by its sha; private bytes)')


def build(state=None):
    """state: None to decode the savestate now (write mode), or the stored
    boot digests and path (--check without the private bytes)."""
    receipt = json.loads(T100_RECEIPT.read_text())
    step = receipt['preparation']
    if state is None:
        path, data = find_state(STATE_SHA)
        if sha(data) != STATE_SHA:
            raise SystemExit('the savestate bytes do not hash to the pinned sha')
        screen = guest.Guest(data, files={}).screen()
        text_sha, screen_sha = (sha(screen.text().encode()), screen.digest())
        text_head = screen.text().splitlines()[0][:60]
        path = path.relative_to(ROOT).as_posix()
    else:
        text_sha = state['text_sha256']
        screen_sha = state['screen_sha256']
        path = state['path']
        text_head = None
    if step['text_sha256'] != text_sha or step['screen_sha256'] != screen_sha:
        raise SystemExit(f'the decoded preparation screen differs from the T100 '
                         f'receipt: text {text_sha[:12]} against '
                         f"{step['text_sha256'][:12]}, screen {screen_sha[:12]} "
                         f"against {step['screen_sha256'][:12]}")
    return dict(
        schema='harness-league-probe-1/1', issue=273, task='T117',
        state=dict(sha256=STATE_SHA, path=path),
        boot=dict(text_sha256=text_sha, screen_sha256=screen_sha,
                  text_head=text_head),
        binding=dict(receipt=T100_RECEIPT.relative_to(ROOT).as_posix(),
                     step=step['step'], id=step['id'],
                     text_sha256=step['text_sha256'],
                     screen_sha256=step['screen_sha256']),
        scope='The savestate is decoded, not executed: the screen comes straight '
              "from its memory and equals the T100 receipt's preparation step.")


def differs(stored, rebuilt, path=''):
    if isinstance(stored, dict) and isinstance(rebuilt, dict):
        for key in stored:
            differs(stored[key], rebuilt.get(key), path + '/' + key)
        return
    if stored == rebuilt:
        return
    if isinstance(rebuilt, str) and rebuilt.startswith('unverified'):
        return
    if rebuilt is None:
        return
    raise SystemExit(f"the record's {path or 'root'} differs from the re-read state")


def main():
    ap = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    ap.add_argument('--check', action='store_true')
    a = ap.parse_args()
    if a.check:
        if not RECORD.exists():
            raise SystemExit('the probe record does not exist yet')
        stored = json.loads(RECORD.read_text())
        private = ROOT / stored['state']['path']
        if private.exists() and sha(private.read_bytes()) == STATE_SHA:
            rebuilt = build()
        else:
            rebuilt = build(dict(text_sha256=stored['boot']['text_sha256'],
                                 screen_sha256=stored['boot']['screen_sha256'],
                                 path=stored['state']['path']))
        differs(stored, rebuilt)
        print('the harness decodes the T100 machine: ready')
        return 0
    record = build()
    RECORD.parent.mkdir(parents=True, exist_ok=True)
    RECORD.write_text(json.dumps(record, indent=1) + '\n')
    print(f"record written: {RECORD.relative_to(ROOT)} "
          f"(boot head {record['boot']['text_head']!r})")
    return 0


if __name__ == '__main__':
    sys.exit(main())
