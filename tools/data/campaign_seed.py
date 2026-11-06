#!/usr/bin/env python3
"""[derived] Named original saved-club fields for a bounded native campaign seed (T65)."""
import argparse,copy,hashlib,importlib.util,json,struct,subprocess,sys,tarfile
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT/'tools/data'))
import save,league
sha=lambda b:hashlib.sha256(b).hexdigest()

def blocks(data):
    save.decode(data)
    result={};offset=0
    for destination,size in save.BLOCKS:result[destination]=data[offset:offset+size];offset+=size
    return result

def pascal(data,offset,width):
    length=data[offset]
    if length>=width:raise ValueError('invalid Pascal field length')
    return data[offset+1:offset+1+length].decode('latin1')

def names(data):
    by={b['name']:b for b in league.decode(data)}
    return dict(year=by['header_year']['value'],clubs=by['club_names']['strings'],players=by['player_name_pool']['player_names'])

def project(data,tables):
    b=blocks(data);game=b['[DS:D7D2]'];manager=game[4];count=game[3]
    if not 1<=manager<=count<=2:raise ValueError('invalid active manager')
    club=b['DS:DCBA'][manager-1]
    if not 1<=club<=176:raise ValueError('invalid managed club')
    year=struct.unpack('<H',b['DS:DCDA'])[0]
    if year!=tables['year'] or len(tables['clubs'])!=176 or len(tables['players'])!=3920:raise ValueError('league namespace differs')
    clubrow=b['[DS:D7C2]'][(club-1)*62:club*62]
    first=list(struct.unpack_from('<20H',clubrow))
    reserve=list(struct.unpack_from('<20H',game,manager*40+48))
    identifiers=[p for p in first+reserve if p]
    if len(identifiers)!=len(set(identifiers)) or not identifiers or any(not 1<=p<=3920 for p in identifiers):raise ValueError('invalid/duplicate roster identity')
    players=[]
    for identifier in sorted(identifiers):
        p8=b['[DS:D7BA]'][identifier*8:identifier*8+8];p15=b['[DS:D7BE]'][identifier*15:identifier*15+15]
        if p8[0]!=club:raise ValueError('player belongs to a different club')
        initial=chr(b['[DS:D7AA]'][identifier])
        players.append(dict(id=identifier,name=(initial+' '+tables['players'][identifier-1]).strip(),age=p8[1],current_position=p8[6],club_position=p8[7],individual_instructions=p15[10],availability=dict(condition_signed=struct.unpack('b',p15[8:9])[0],status_bits=p15[11])))
    name_id=struct.unpack_from('<H',game,manager*2+3)[0]
    if not 0<=name_id<=1000:raise ValueError('manager name identity outside pool')
    manager_name=pascal(b['[DS:DCCC]'],name_id*11,11)
    if not manager_name:raise ValueError('empty manager name')
    week=game[0]
    if week>=57:raise ValueError('bounded seed requires a next fixture slot')
    slot=week+1;offset=club*174+slot*3-177
    competition,opponent,flags=b['[DS:D7CA]'][offset:offset+3]
    if not 1<=opponent<=176 or opponent==club:raise ValueError('missing/invalid next opponent')
    reverse_offset=opponent*174+slot*3-177
    reverse=b['[DS:D7CA]'][reverse_offset:reverse_offset+3]
    if reverse[1]!=club or reverse[0]!=competition:raise ValueError('reciprocal fixture identity differs')
    cash=struct.unpack_from('<i',b['[DS:DCC4]'],(manager-1)*94+82)[0]
    return dict(schema='original-club-seed/1',namespace=dict(edition=96,league='ENGL-95.DAT',league_year=year),season=dict(counter=game[1],start_year=year+game[1]-2,end_year=year+game[1]-1),week_index=week,manager=dict(slot=manager,name_id=name_id,name=manager_name),club=dict(id=club,name=tables['clubs'][club-1],first_team=first,reserves=reserve,team_instructions=clubrow[57]),cash=cash,next_fixture=dict(slot=slot,club=club,opponent=opponent,opponent_name=tables['clubs'][opponent-1],competition_code=competition,flags=flags,venue_code=flags&15,opponent_flags=reverse[2]),players=players)

LISTINGS=['static/1-0-exe/code/seg_0006_02.asm','static/1-0-exe/code/seg_0006_03.asm','static/1-0-exe/code/seg_1B55_02.asm','static/1-0-exe/code/seg_1B55_05.asm','static/1-0-exe/code/seg_1B55_07.asm','static/1-0-exe/code/seg_0AB9_14.asm','static/1-0-exe/code/seg_0AB9_19.asm']

def corroborate(initial,changed):
    spec=importlib.util.spec_from_file_location('capture_blueprint',ROOT/'tools/static/ui_blueprint.py');ui=importlib.util.module_from_spec(spec);spec.loader.exec_module(ui)
    references=[]
    def capture(relative):
        path=ROOT/relative;value,lines=ui.capture(path)
        references.append(dict(path=relative,sha256=sha(path.read_bytes()),screenshot_sha256=value['screenshot_sha256']))
        return '\n'.join(lines),lines
    main,_=capture('runs/T46/session-r0001/step-0001.json')
    for text in [initial['club']['name'],initial['manager']['name'],format(initial['cash'],','),f"{initial['season']['start_year']}/{initial['season']['end_year']%100:02}",initial['next_fixture']['opponent_name']]:
        if text not in main:raise ValueError('main-menu source contradiction: '+text)
    _,roster=capture('runs/T46/session-r0001/step-0002.json')
    pool={p['id']:p for p in initial['players']}
    expected=[pool[p]['name'] for p in initial['club']['first_team'] if p]
    for name in expected:
        if not any(name in line[55:] for line in roster):raise ValueError('roster text differs: '+name)
    details,_=capture('runs/T45/session-r0001/step-0004.json')
    first=pool[initial['club']['first_team'][0]]
    if first['name'] not in details or str(first['age']) not in details:raise ValueError('initial card identity/age differs')
    reload,rows=capture('runs/T46/session-r0001/step-0053.json')
    changed_pool={p['id']:p for p in changed['players']};new_keeper=changed_pool[changed['club']['first_team'][0]]
    if new_keeper['name'] not in reload or 'stay in box' not in reload:raise ValueError('changed keeper card differs')
    _,rows=capture('runs/T46/session-r0001/step-0054.json')
    pearce=next(p for p in changed['players'] if p['name']=='I Pearce')
    if 'sweeper' not in '\n'.join(rows) or pearce['current_position']!=1 or pearce['club_position']!=2:raise ValueError('changed Pearce position differs')
    if initial['club']['first_team'][0]!=changed['club']['first_team'][17] or initial['club']['first_team'][17]!=changed['club']['first_team'][0]:raise ValueError('recorded goalkeeper swap differs')
    if {k:initial[k] for k in ['namespace','season','week_index','manager','cash','next_fixture']}!={k:changed[k] for k in ['namespace','season','week_index','manager','cash','next_fixture']}:raise ValueError('unrelated campaign context changed')
    return references

def validate(record):
    for path,digest in record['listing_sha256'].items():
        if sha((ROOT/path).read_bytes())!=digest:raise ValueError('listing identity differs')
    actual=corroborate(record['initial'],record['changed'])
    if actual!=record['capture_references']:raise ValueError('capture references differ')
    for name in ['initial','changed']:
        value=record[name]
        if sha(json.dumps(value,sort_keys=True,separators=(',',':')).encode())!=record['projection_sha256'][name]:raise ValueError('projection digest differs')
    if record['save_sha256']!='6ef61bcf78af17a78cbbdc50b68839be169552464b4f2ee9eec5ea9b3740bc36' or record['changed_save_sha256']!='aecb2f9ac707937bd1f10d333ed79143a407747b6e478627d752cd536b9e2385':raise ValueError('save source differs')

def main():
    p=argparse.ArgumentParser();g=p.add_mutually_exclusive_group(required=True);g.add_argument('--record',type=Path);g.add_argument('--check',type=Path);p.add_argument('--changed-archive',type=Path);args=p.parse_args()
    if args.check:
        r=json.loads(args.check.read_text());validate(r);print('PASS original club projection and authenticated UI references');return
    tracked=['tools/data/campaign_seed.py','tools/data/save.py','tools/data/league.py']
    if subprocess.check_output(['git','status','--porcelain','--',*tracked],cwd=ROOT):raise ValueError('commit producer first')
    sys.path.insert(0,str(ROOT/'tools'));import inventory
    sources=dict(inventory.original_sources());raw=sources['One-Nil96/SAVE1.1-0'];league_raw=sources['One-Nil96/ENGL-95.DAT']
    if sha(raw)!='6ef61bcf78af17a78cbbdc50b68839be169552464b4f2ee9eec5ea9b3740bc36':raise ValueError('wrong supplied save')
    with tarfile.open(args.changed_archive) as archive:changed=archive.extractfile('session-r0001/SAVE1.1-0').read()
    tables=names(league_raw);initial=project(raw,tables);after=project(changed,tables)
    r=dict(schema='campaign-seed-evidence/1',producer=subprocess.check_output(['git','rev-parse','HEAD'],cwd=ROOT,text=True).strip(),save_sha256=sha(raw),changed_save_sha256=sha(changed),league_sha256=sha(league_raw),changed_archive_sha256=sha(args.changed_archive.read_bytes()),producer_files={f:sha((ROOT/f).read_bytes()) for f in tracked},listing_sha256={f:sha((ROOT/f).read_bytes()) for f in LISTINGS},initial=initial,changed=after,capture_references=corroborate(initial,after),projection_sha256={k:sha(json.dumps(v,sort_keys=True,separators=(',',':')).encode()) for k,v in [('initial',initial),('changed',after)]})
    validate(r)
    with args.record.open('x') as f:json.dump(r,f,indent=2);f.write('\n')
    print('PASS',initial['club']['name'],len(initial['players']),'players; cash',initial['cash'],'week',initial['week_index'],'next',initial['next_fixture'])
if __name__=='__main__':main()
