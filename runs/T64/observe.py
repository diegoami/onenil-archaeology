"""Read-only public-image/decoded-record proof of PUT HERE card selection."""
import argparse
import hashlib
import json
from pathlib import Path
import subprocess
from PIL import Image

ROOT=Path(__file__).resolve().parents[2]
REGION=(0,0,480,376)  # excludes roster and context-dependent bottom action line
sha=lambda value:hashlib.sha256(value).hexdigest()


def observe():
    rows=[]
    for number,name in [(2,'T Flowers'),(3,'T Flowers'),(4,'T Flowers'),(6,'B Mimms'),(7,'T Flowers'),(8,'B Mimms')]:
        path=ROOT/f'runs/T46/session-r0001/step-{number:04}.json'
        raw=path.read_bytes();record=json.loads(raw);png=path.with_suffix('.png')
        assert sha(png.read_bytes())==record['screenshot_sha256']
        assert any(name in text for _,text in record['highlighted'])
        image=Image.open(png).convert('RGB');assert image.size==(720,400)
        rows.append(dict(record=str(path.relative_to(ROOT)),record_sha256=sha(raw),
            screenshot_sha256=record['screenshot_sha256'],highlighted_player=name,
            panel_rgb_sha256=sha(image.crop(REGION).tobytes()),
            action='PUT HERE' if 'PUT HERE' in record['text'].splitlines()[-1] else 'move player'))
    hashes={int(Path(row['record']).stem.split('-')[1]):row['panel_rgb_sha256'] for row in rows}
    assert hashes[2]==hashes[3]==hashes[4]==hashes[7]
    assert hashes[6]==hashes[8] and hashes[6]!=hashes[2]
    details=[]
    for number,name in [(150,'M Newell'),(151,'M Newell'),(152,'S Ripley'),(153,'S Ripley')]:
        path=ROOT/f'runs/T59/session-r0001/step-{number:04}.json';raw=path.read_bytes();r=json.loads(raw)
        actual=r['text'].splitlines()[1].split('Age')[0].strip(' │')
        assert actual==name and any(name in text for _,text in r['highlighted'])
        action='PUT HERE' if 'PUT HERE' in r['text'].splitlines()[-1] else 'MAKE SUBSTITUTION'
        assert (action=='PUT HERE')==(number in (151,152))
        details.append(dict(record=str(path.relative_to(ROOT)),record_sha256=sha(raw),keys=r['keys'],card_name=actual,action=action))
    return dict(schema='original-put-here-card-proof/1',source=subprocess.check_output(
        ['git','-C',str(ROOT),'rev-parse','HEAD'],text=True).strip(),observer_sha256=sha(Path(__file__).read_bytes()),
        region=list(REGION),colour_mode='RGB; decompressed rendered pixels read only',skills=rows,details=details,
        conclusion='Card follows highlighted destination during PUT HERE; carried source identity remains separate. Escape in T59 leaves destination selected without committing swap.',
        scope='Existing public completed captures; no original execution or new game outcome; region equality plus named detail corroboration',status='passed')


if __name__=='__main__':
    p=argparse.ArgumentParser();p.add_argument('--out',type=Path);p.add_argument('--check',type=Path);a=p.parse_args()
    value=observe()
    if a.out:
        with a.out.open('x') as f:json.dump(value,f,indent=2);f.write('\n')
    if a.check:
        old=json.loads(a.check.read_text());assert {k:v for k,v in value.items() if k!='source'}=={k:v for k,v in old.items() if k!='source'}
    print('PUT HERE card proof PASS: destination panel equality and named details verified')
