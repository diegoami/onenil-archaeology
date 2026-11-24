#!/usr/bin/env python3
"""T118: append the two late chapters to the manual catalog; check numbering and links.

The T62 catalog audited W001-W083. The T114 and T116 chapters were appended to
watched-match.md as W031/W032, numbers quick-results.md already used, so the
manual carried 83 headings' worth of numbers on 85 headings. This revision
starts from the latest append-only catalog (T64's) and adds W084/W085: the 83
earlier entries stay identical apart from watched-match.md's whole-file chapter
digests, which move because that file changed.

No private bytes: screenshots, records and session metadata are committed.
"""
import argparse
from collections import Counter
import hashlib
import importlib.util
import json
from pathlib import Path
import re
import subprocess

ROOT = Path(__file__).resolve().parents[2]
T62 = ROOT / 'runs/T62/catalog-r0001.json'
T64 = ROOT / 'runs/T64/catalog-r0001.json'
OUT = ROOT / 'runs/T118/catalog-r0001.json'
NATIVE = 'a634fb27a2d438c67d20e95cf66aa11bc0737732'
PARTIAL = {14, 18, 19, 22, 23, 24, 26, 27, 28, 29, 31}
ADDED = {'W084', 'W085'}
MOVED = 'docs/manual/watched-match.md'


def digest(data):
    return hashlib.sha256(data).hexdigest()


def git(*args):
    return subprocess.check_output(['git', '-C', str(ROOT), *args])


def headings():
    """Every '## Wnnn: title' heading in the manual, in file order."""
    found = []
    for path in sorted((ROOT / 'docs/manual').glob('*.md')):
        text = path.read_text()
        for match in re.finditer(r'^## (W\d{3})(?:\s*[:—])\s*([^\n]+)', text, re.M):
            found.append((match[1], match[2], path))
    return found


def collect():
    spec = importlib.util.spec_from_file_location('manual', ROOT / 'runtime/driver/manual_session.py')
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    sessions = {}
    workflows = []
    for path in sorted((ROOT / 'docs/manual').glob('*.md')):
        text = path.read_text()
        matches = list(re.finditer(r'^## (W\d{3})(?:\s*[:—])\s*([^\n]+)', text, re.M))
        for index, match in enumerate(matches):
            body = text[match.end():matches[index + 1].start() if index + 1 < len(matches) else len(text)]
            images = []
            for target in re.findall(r'!\[[^\]]*\]\(([^)]+)\)', body):
                image = (path.parent / target).resolve()
                record = image.with_suffix('.json')
                directory = record.parent
                if not record.exists() and (directory / 'record.json').exists():
                    record = directory / 'record.json'
                    legacy = json.loads(record.read_text())
                    legacy_spec = importlib.util.spec_from_file_location('legacy_manual', ROOT / 'runtime/driver/manual.py')
                    legacy_module = importlib.util.module_from_spec(legacy_spec)
                    legacy_spec.loader.exec_module(legacy_module)
                    legacy_module.validate(legacy, directory)
                    step = next(item for item in legacy['screens'] if item['screenshot'] == image.name)
                    step = dict(step, number=step['id'])
                    sessions[directory] = dict(path=str(directory.relative_to(ROOT)), producer=legacy['code_commit'],
                        status=legacy['status'], error=None, canonical_authenticated=True)
                else:
                    step = json.loads(record.read_text())
                assert image.is_relative_to(ROOT) and digest(image.read_bytes()) == step['screenshot_sha256'], ('screenshot digest', image)
                if directory not in sessions:
                    header = json.loads((directory / 'session.json').read_text())
                    end = json.loads((directory / 'end.json').read_text())
                    complete = end['status'] == 'completed'
                    if complete:
                        module.validate(directory)
                    sessions[directory] = dict(path=str(directory.relative_to(ROOT)),
                        producer=header['code_commit'], status=end['status'], error=end['error'],
                        canonical_authenticated=complete)
                images.append(dict(screenshot=str(image.relative_to(ROOT)),
                    record=str(record.relative_to(ROOT)), step=step['number'],
                    screenshot_sha256=step['screenshot_sha256'], session=sessions[directory]['path']))
            assert images, f'{match[1]} has no illustrated evidence'
            workflows.append(dict(id=match[1], title=match[2], chapter=str(path.relative_to(ROOT)),
                chapter_sha256=digest(path.read_bytes()), screenshots=images,
                native_status='partial' if int(match[1][1:]) in PARTIAL else 'missing'))
    workflows.sort(key=lambda item: item['id'])
    return workflows, sorted(sessions.values(), key=lambda item: item['path'])


def build():
    base = json.loads(T64.read_text())
    workflows, sessions = collect()
    # This is the pre-fix state check too: it fails with the duplicate numbers.
    assert [item['id'] for item in workflows] == [f'W{i:03}' for i in range(1, 86)], 'manual chapter numbers are not unique and gapless'
    byid = {item['id']: item for item in workflows}
    before = {item['id']: item for item in base['workflows']}
    changed = []
    for identifier, old in before.items():
        new = byid[identifier]
        assert new['chapter'] == old['chapter'] and new['title'] == old['title'], ('moved chapter', identifier)
        assert new['screenshots'] == old['screenshots'] and new['native_status'] == old['native_status'], ('evidence drift', identifier)
        if new['chapter_sha256'] != old['chapter_sha256']:
            assert new['chapter'] == MOVED, ('unexpected chapter digest move', identifier)
            changed.append(identifier)
    assert changed == [f'W{i:03}' for i in range(24, 31)], ('watched-match digests', changed)
    assert set(byid) - set(before) == ADDED, 'the revision adds exactly W084/W085'
    assert all(item in sessions for item in base['sessions']), 'earlier sessions dropped'
    assert len(sessions) == len(base['sessions']) + 2, 'two sessions join the catalog'
    manifest = base['native_source_manifest']
    value = dict(schema='manual-coverage-catalog/1',
        research_commit=git('rev-parse', 'HEAD').decode().strip(),
        native_commit=NATIVE, workflow_count=len(workflows),
        native_status_counts=dict(Counter(item['native_status'] for item in workflows)),
        workflows=workflows, sessions=sessions, native_source_manifest=manifest,
        base=dict(t62_sha256=digest(T62.read_bytes()), t64_sha256=digest(T64.read_bytes())),
        scope=base['scope'])
    with OUT.open('x') as handle:
        json.dump(value, handle, indent=2)
        handle.write('\n')
    print(json.dumps(dict(workflows=len(workflows), sessions=len(sessions), statuses=value['native_status_counts'],
        moved=changed, added=sorted(ADDED))))


def check():
    found = headings()
    numbers = [item[0] for item in found]
    duplicates = sorted({item for item in numbers if numbers.count(item) > 1})
    assert not duplicates, ('duplicate chapter numbers', duplicates)
    assert len(numbers) == len(set(numbers)) == 85, ('chapter count', len(numbers))
    assert sorted(numbers) == [f'W{i:03}' for i in range(1, 86)], 'chapter numbers are not gapless W001-W085'
    catalog = json.loads(OUT.read_text())
    workflows, sessions = collect()
    assert workflows == catalog['workflows'] and sessions == catalog['sessions'], 'catalog drift'
    assert catalog['workflow_count'] == 85 and catalog['native_status_counts'] == dict(missing=74, partial=11)
    assert {item['id'] for item in workflows} >= ADDED
    base = json.loads(T64.read_text())
    assert catalog['base'] == dict(t62_sha256=digest(T62.read_bytes()), t64_sha256=digest(T64.read_bytes())), 'base catalog edited'
    before = {item['id']: item for item in base['workflows']}
    after = {item['id']: item for item in workflows}
    for identifier, old in before.items():
        new = dict(after[identifier])
        if new['chapter'] == MOVED:
            new['chapter_sha256'] = old['chapter_sha256']
        assert new == old, ('earlier entry changed', identifier)
    assert catalog['native_commit'] == NATIVE and catalog['native_source_manifest'] == base['native_source_manifest']
    matrix = (ROOT / 'docs/manual/native-gaps.md').read_text()
    ids = re.findall(r'^\| (W\d{3}) \|', matrix, re.M)
    assert ids == [item['id'] for item in workflows], 'workflow matrix missing/duplicate/out of order'
    rows = re.findall(r'^\| (W\d{3}) \| ([^\n]+)$', matrix, re.M)
    for workflow, (identifier, row) in zip(workflows, rows):
        columns = [item.strip() for item in row.split('|')]
        assert columns[1] == workflow['native_status'], ('native status drift', identifier)
        assert re.fullmatch(r'B(?:[1-9]|10)', columns[3]), ('next task missing', identifier)
        assert f'| {columns[3]} |' in matrix, ('undefined dependency', identifier)
    native_paths = {item['path'] for item in catalog['native_source_manifest']}
    for commit, path in re.findall(r'https://github.com/diegoami/onenil/blob/([0-9a-f]+)/([^)#\s]+)', matrix):
        assert commit == NATIVE and path in native_paths, ('unpinned/unknown native source', commit, path)
    coverage = (ROOT / 'docs/manual/coverage-audit.md').read_text()
    slots = re.findall(r'^\| (\d+) \|', coverage, re.M)
    assert slots == list(map(str, range(1, 19))), 'menu slot coverage'
    for path in (ROOT / 'docs/manual').glob('*.md'):
        for target in re.findall(r'\]\(([^)]+)\)', path.read_text()):
            if '://' in target or target.startswith('#'):
                continue
            assert (path.parent / target.split('#')[0]).exists(), (path.name, target)
    print('ready: 85 unique chapters, 29 sessions, matrix and coverage indexed')


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('--check', action='store_true')
    arguments = parser.parse_args()
    check() if arguments.check else build()
