"""Append a prose-only catalog revision while retaining every T62 assertion."""
import argparse
import copy
import hashlib
import json
from pathlib import Path
import subprocess

ROOT=Path(__file__).resolve().parents[2]
OLD=ROOT/'runs/T62/catalog-r0001.json'
NEW=ROOT/'runs/T64/catalog-r0001.json'
CHECKER=ROOT/'runs/T62/catalog-source-r0003.py'


def inherited():
    # Execute the historical checker with only its catalog destination adapted.
    # Its assertion bodies and immutable source file remain unchanged.
    code=CHECKER.read_text()
    assert hashlib.sha256(code.encode()).hexdigest()=='c9de6108aa1f68e77a9cd5785cce8ea4df9d769308d87637d94e2b77852171ae'
    assert code.count('runs/T62/catalog-r0001.json')==2
    namespace={'__file__':str(CHECKER),'__name__':'t64_inherited_catalog'}
    exec(compile(code.replace('runs/T62/catalog-r0001.json','runs/T64/catalog-r0001.json'),str(CHECKER),'exec'),namespace)
    return namespace


def validate_revision(value,old):
    assert value['native_commit']==old['native_commit']
    assert value['sessions']==old['sessions'] and value['native_source_manifest']==old['native_source_manifest']
    assert value['workflow_count']==old['workflow_count']==83
    changes=[]
    for before,after in zip(old['workflows'],value['workflows']):
        b=copy.deepcopy(before);a=copy.deepcopy(after)
        bh=b.pop('chapter_sha256');ah=a.pop('chapter_sha256');assert a==b
        if bh!=ah:changes.append(after['id']);assert after['chapter']=='docs/manual/selection.md'
    assert changes==['W014','W015','W016','W017']
    for key in old:
        if key not in ('workflows','research_commit'):assert value[key]==old[key]


if __name__=='__main__':
    p=argparse.ArgumentParser();p.add_argument('--build',action='store_true');p.add_argument('--check',action='store_true');a=p.parse_args()
    old=json.loads(OLD.read_text());ns=inherited()
    if a.build:
        current,sessions=ns['collect']();value=copy.deepcopy(old);value['workflows']=current
        value['research_commit']=subprocess.check_output(['git','-C',str(ROOT),'rev-parse','HEAD'],text=True).strip()
        validate_revision(value,old);assert sessions==old['sessions']
        with NEW.open('x') as f:json.dump(value,f,indent=2);f.write('\n')
    if a.check:
        validate_revision(json.loads(NEW.read_text()),old);ns['check']()
