"""Build append-only T62 documentary inventory; check coverage without private bytes."""
import argparse
from collections import Counter
import hashlib
import importlib.util
import json
from pathlib import Path
import re
import subprocess

ROOT = Path(__file__).resolve().parents[2]
NATIVE = 'a634fb27a2d438c67d20e95cf66aa11bc0737732'
PARTIAL = {14, 18, 19, 22, 23, 24, 26, 27, 28, 29, 31}


def git(root, *args):
    return subprocess.check_output(['git', '-C', str(root), *args])


def digest(data):
    return hashlib.sha256(data).hexdigest()


def collect():
    spec = importlib.util.spec_from_file_location('manual', ROOT/'runtime/driver/manual_session.py')
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    sessions = {}
    workflows = []
    for path in sorted((ROOT/'docs/manual').glob('*.md')):
        text = path.read_text()
        headings = list(re.finditer(r'^## (W\d{3})(?:\s*[:—])\s*([^\n]+)', text, re.M))
        for index, match in enumerate(headings):
            body = text[match.end():headings[index+1].start() if index+1<len(headings) else len(text)]
            images = []
            for target in re.findall(r'!\[[^\]]*\]\(([^)]+)\)', body):
                image = (path.parent/target).resolve()
                record = image.with_suffix('.json')
                step = json.loads(record.read_text())
                assert image.is_relative_to(ROOT) and digest(image.read_bytes()) == step['screenshot_sha256']
                directory = record.parent
                if directory not in sessions:
                    header = json.loads((directory/'session.json').read_text())
                    end = json.loads((directory/'end.json').read_text())
                    complete = end['status']=='completed'
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
    workflows.sort(key=lambda x:x['id'])
    assert [w['id'] for w in workflows] == [f'W{i:03}' for i in range(1,84)]
    return workflows, sorted(sessions.values(), key=lambda x:x['path'])


def build(native):
    workflows, sessions = collect()
    paths = git(native, 'ls-tree', '-r', '--name-only', NATIVE).decode().splitlines()
    selected = [p for p in paths if p.endswith(('.rs','.py','.js','.html')) or p=='Cargo.toml']
    # File names plus committed source digests document the inspected native surface.
    manifest = [dict(path=p, sha256=digest(git(native, 'show', NATIVE+':'+p))) for p in selected]
    value = dict(schema='manual-coverage-catalog/1', research_commit=git(ROOT,'rev-parse','HEAD').decode().strip(),
        native_commit=NATIVE, workflow_count=len(workflows),
        native_status_counts=dict(Counter(w['native_status'] for w in workflows)),
        workflows=workflows, sessions=sessions, native_source_manifest=manifest,
        scope='Documentary audit; completed capture authentication is distinct from aborted prefix observations. Native source/tests inspected, not newly executed.')
    out = ROOT/'runs/T62/catalog-r0001.json'
    with out.open('x') as handle:
        json.dump(value, handle, indent=2)
        handle.write('\n')
    print(json.dumps(dict(workflows=len(workflows), sessions=len(sessions), native_files=len(manifest), statuses=value['native_status_counts'])))


def check():
    catalog = json.loads((ROOT/'runs/T62/catalog-r0001.json').read_text())
    current, sessions = collect()
    assert current==catalog['workflows'] and sessions==catalog['sessions'], 'catalog drift'
    matrix = (ROOT/'docs/manual/native-gaps.md').read_text()
    ids = re.findall(r'^\| (W\d{3}) \|', matrix, re.M)
    assert ids==[w['id'] for w in current], 'workflow matrix missing/duplicate/out of order'
    coverage = (ROOT/'docs/manual/coverage-audit.md').read_text()
    slots = re.findall(r'^\| (\d+) \|', coverage, re.M)
    assert slots==list(map(str,range(1,19))), 'menu slot coverage'
    for path in (ROOT/'docs/manual').glob('*.md'):
        for target in re.findall(r'\]\(([^)]+)\)', path.read_text()):
            if '://' in target or target.startswith('#'):
                continue
            assert (path.parent/target.split('#')[0]).exists(), (path.name,target)
    assert catalog['native_commit']==NATIVE
    assert 'OWNER RUNS' in (ROOT/'docs/manual/review-prompt.md').read_text()
    print(f'{len(current)} workflows, 18 menu slots, all manual links and authenticated screenshot references verified')


if __name__=='__main__':
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--build', action='store_true')
    parser.add_argument('--native', type=Path)
    parser.add_argument('--check', action='store_true')
    args=parser.parse_args()
    if args.build and args.native and not args.check:
        build(args.native)
    elif args.check and not args.build:
        check()
    else:
        parser.error('choose --build --native PATH or --check')
