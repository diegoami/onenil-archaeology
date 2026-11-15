#!/usr/bin/env python3
"""T85 natural original condition calls in one retained quick week; no engine model."""
import argparse
import hashlib
import json
import platform
import struct
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / 'runtime/emul'))
sys.path.insert(0, str(ROOT / 'tools/data'))
import match
import condition_refresh as controlled
import save as save_layout
import unicorn
from unicorn import UC_HOOK_MEM_WRITE

WEEK = 'T04-week-r0012'
NATIVE = '772cb7ae4afe630be6387f82f0ff8298b98827c9'
DEPENDENCIES = ['runtime/emul/condition_handoff.py', *controlled.DEPENDENCIES,
                'runtime/emul/match.py', 'runtime/emul/listing.py', 'runtime/emul/checkpoint.py',
                'runtime/driver/cycle.py', 'runtime/driver/screens.py', 'tools/data/save.py']
DEPENDENCIES = sorted(set(DEPENDENCIES))
RETURNS = {'1998:193A': 'first_team', '1998:19FB': 'first_team',
           '1998:17F3': 'manager_roster', '1998:1818': 'manager_roster'}
INDEX = ROOT / 'records/T85/index.json'


def sha(data):
    return hashlib.sha256(data).hexdigest()


def encoded(value):
    return json.dumps(value, sort_keys=True, separators=(',', ':')).encode()


def git(*args):
    return subprocess.check_output(['git', *args], cwd=ROOT)


def signed(value):
    return value if value < 128 else value - 256


def reference():
    entries = json.loads((ROOT / 'traces/T08/index.json').read_text())['entries']
    source = next(e for e in entries if e['t04_record'] == WEEK)
    path = ROOT / source['trace']
    if sha(path.read_bytes()) != source['trace_sha256']:
        raise ValueError('T08 source trace differs')
    return source, [json.loads(s) for s in path.read_text().splitlines()]


def fields(g, player):
    if not 1 <= player <= 3920:
        raise ValueError('observed player outside decoded domain')
    p8, p15 = g.far(0xD7BA) + 8 * player, g.far(0xD7BE) + 15 * player
    club, age, reference = g.mem(p8, 3)
    if not 1 <= club <= 176:
        raise ValueError('observed player has no admitted club')
    staff = g.word_at(g.far(0xD7C2) + 62 * club - 18)
    if staff > 1000:
        raise ValueError('observed staff outside decoded domain')
    return dict(player=player, club=club, age=age, age_reference=reference,
                facility=g.mem(g.far(0xDCC8) + 4 * staff + 2, 1)[0],
                caps=list(g.mem(g.DS * 16 + 0xD72, 2)),
                base_condition=signed(g.mem(p15 + 7, 1)[0]),
                condition=signed(g.mem(p15 + 8, 1)[0]),
                recovery=signed(g.mem(p15 + 14, 1)[0]))


def staff_dependency(g, player):
    club = g.mem(g.far(0xD7BA) + 8 * player, 1)[0]
    staff = g.word_at(g.far(0xD7C2) + 62 * club - 18)
    return dict(staff_id=staff, facility=g.mem(g.far(0xDCC8) + 4 * staff + 2, 1)[0])


class SaveView:
    """Decode the same declared fields from T03's save blocks, not an engine."""
    DS = match.guest.DS_PARAGRAPH

    def __init__(self, data, caps):
        self.data, self.caps, self.offsets = data, caps, {}
        offset = 0
        for name, size in save_layout.BLOCKS:
            self.offsets[name] = offset
            offset += size
        if len(data) != offset:
            raise ValueError('save length differs')

    def far(self, offset):
        return self.offsets['[DS:%04X]' % offset]

    def mem(self, address, size):
        if address == self.DS * 16 + 0xD72:
            return bytes(self.caps)
        return self.data[address:address + size]

    def word_at(self, address):
        return struct.unpack_from('<H', self.data, address)[0]


def initial(g, data):
    manager = g.mem(g.far(0xD7D2) + 4, 1)[0]
    club = g.rd(0xDCB9 + manager, 1)
    first = [g.word_at(g.far(0xD7C2) + 62 * (club - 1) + 2 * i) for i in range(20)]
    reserves = [g.word_at(g.far(0xD7D2) + 40 * manager + 48 + 2 * i) for i in range(20)]
    players = {str(pid): fields(g, pid) for pid in sorted(set(first + reserves) - {0})}
    view = SaveView(data, list(g.mem(g.DS * 16 + 0xD72, 2)))
    saved_first = [view.word_at(view.far(0xD7C2) + 62 * (club - 1) + 2 * i) for i in range(20)]
    saved_reserves = [view.word_at(view.far(0xD7D2) + 40 * manager + 48 + 2 * i) for i in range(20)]
    saved = {pid: fields(view, int(pid)) for pid in players}
    staff = {str(p['club']): staff_dependency(g, p['player']) for p in players.values()}
    saved_staff = {str(p['club']): staff_dependency(view, p['player']) for p in saved.values()}
    if (first, reserves, players, staff) != (saved_first, saved_reserves, saved, saved_staff):
        raise ValueError('initial memory differs from pinned save fields')
    return dict(manager=manager, club=club, first_team=first, manager_roster=reserves,
                caps_source='original DS:0D72/0D73, not serialized in the save',
                players=players, staff_by_club=staff)


def registers(g):
    return {name: g.reg(name) for name in ('ax', 'bx', 'cx', 'dx', 'si', 'di', 'bp',
                                         'sp', 'cs', 'ds', 'es', 'ss', 'eflags')}


def authenticate_code(g):
    packed = (ROOT / '.cache/One-Nil96/1-0.EXE').read_bytes()
    if sha(packed) != controlled.PACKED:
        raise ValueError('original executable identity differs')
    unpacked = controlled.unlzexe.unpack(packed)
    if sha(unpacked) != controlled.UNPACKED:
        raise ValueError('unpacked identity differs')
    image = controlled.onilexe.Image(unpacked)
    relocated = bytearray(image.data)
    for at, value in image.reloc_value.items():
        struct.pack_into('<H', relocated, at, (value + g.load) & 65535)
    result = {}
    for seg in (0x1998, 0x232A, 0x24BC):
        lo, hi = next((a * 16, b * 16) for a, b in image.code_segments if a == seg)
        actual = g.mem(g.seg(seg) * 16, hi - lo)
        if actual != relocated[lo:hi]:
            raise ValueError('loaded original code differs: %04X' % seg)
        result['%04X' % seg] = sha(actual)
    return result


class Recorder:
    def __init__(self, week):
        self.week = week
        self.contexts, self.calls, self.direct_helpers = [], [], []
        self.parent = self.pending = None
        self.quick_steps = 0
        g = week.g
        for site, kind in (('1998:1897', 'first_team'), ('1998:16B1', 'manager_roster')):
            g.code_hook(site, lambda machine, kind=kind: self.enter_parent(machine, kind))
        for site in ('1998:1B96', '1998:1869'):
            g.code_hook(site, self.leave_parent)
        for site in ('0AB9:E7FE', '0AB9:E81E', '0AB9:ED5B', '01EF:4E26'):
            g.code_hook(site, self.parent_returned)
        g.code_hook('1998:14A5', self.enter)
        for site in RETURNS:
            g.code_hook(site, self.leave)
        g.code_hook('1998:13F9', self.helper)
        g.code_hook('0AB9:DD02', lambda machine: setattr(self, 'quick_steps', self.quick_steps + 1))
        for base, size in ((g.far(0xD7BE), 0xE5BF), (g.far(0xDE84), 2)):
            g.mu.hook_add(UC_HOOK_MEM_WRITE, self.write, begin=base, end=base + size - 1)

    def enter_parent(self, g, kind):
        if self.parent is not None:
            raise ValueError('nested condition caller')
        if kind == 'first_team':
            club = g.stack_word(8)
            roster = [g.word_at(g.far(0xD7C2) + 62 * (club - 1) + 2 * i) for i in range(20)]
            context = dict(kind=kind, club=club, arguments=[g.stack_word(i) for i in (4, 6, 8)],
                           active=True)
        else:
            manager = g.stack_word(4)
            club = g.rd(0xDCB9 + manager, 1)
            roster = [g.word_at(g.far(0xD7D2) + 40 * manager + 48 + 2 * i) for i in range(20)]
            competition = None
            if club:
                week = g.mem(g.far(0xD7D2), 1)[0]
                competition = g.mem(g.far(0xD7CA) + 174 * club + 3 * week - 176, 1)[0]
            context = dict(kind=kind, manager=manager, club=club, active=club != 0,
                           competition_byte=competition)
        self.parent = dict(index=len(self.contexts), **context, roster=roster,
                           entry=registers(g), entry_seed=g.word_at(g.far(0xDE84)),
                           return_site=g.image_address(g.stack_word(2), g.stack_word(0)),
                           draw_start=self.week.draws, draw_end=None, calls=[])
        self.contexts.append(self.parent)

    def leave_parent(self, g):
        if self.parent is None or self.pending is not None:
            raise ValueError('unmatched/incomplete caller return')
        self.parent['return_instruction'] = g.where()

    def parent_returned(self, g):
        if self.parent is None:
            return
        if g.where() != self.parent['return_site'] or self.pending is not None:
            raise ValueError('wrong caller return boundary')
        self.parent.update(draw_end=self.week.draws, returned=registers(g),
                           exit_seed=g.word_at(g.far(0xDE84)))
        self.parent = None

    def enter(self, g):
        if self.parent is None or self.pending is not None:
            raise ValueError('condition call outside declared caller')
        site = '1998:%04X' % g.stack_word(0)
        if RETURNS.get(site) != self.parent['kind']:
            raise ValueError('condition caller site differs')
        player, flag = g.stack_word(4), g.stack_word(2) & 255
        slot = g.word_at(g.reg('ss') * 16 + g.reg('bp') - 2)
        if not 1 <= slot <= 20 or self.parent['roster'][slot - 1] != player:
            raise ValueError('live slot differs from caller roster')
        self.pending = dict(index=len(self.calls), context=self.parent['index'], slot=slot,
                            return_site=site, input=dict(**fields(g, player), flag=flag,
                            seed=g.word_at(g.far(0xDE84))), entry=registers(g),
                            status_byte=g.mem(g.far(0xD7BE) + 15 * player + 11, 1)[0],
                            dependencies=staff_dependency(g, player),
                            draw_start=self.week.draws, writes=[])

    def leave(self, g):
        if self.pending is None:
            return
        call = self.pending
        if g.where() != call['return_site']:
            raise ValueError('wrong condition return site')
        after = fields(g, call['input']['player'])
        call.update(output={k: after[k] for k in ('base_condition', 'condition', 'recovery')},
                    returned=registers(g), draw_end=self.week.draws)
        call['output']['seed'] = g.word_at(g.far(0xDE84))
        self.calls.append(call)
        self.parent['calls'].append(call['index'])
        self.pending = None

    def helper(self, g):
        if self.pending is None:
            self.direct_helpers.append(dict(site='1998:13F9', draw=self.week.draws,
                                            player=g.stack_word(2), return_ip=g.stack_word(0)))

    def write(self, mu, access, address, size, value, _):
        if self.pending is None:
            return
        g = self.week.g
        p15 = g.far(0xD7BE) + 15 * self.pending['input']['player']
        names = {p15 + 7: ('base_condition', 1), p15 + 8: ('condition', 1),
                 p15 + 14: ('recovery', 1), g.far(0xDE84): ('seed', 2)}
        if address not in names or names[address][1] != size:
            raise ValueError('undeclared original condition write')
        self.pending['writes'].append(dict(field=names[address][0], size=size,
            before=int.from_bytes(g.mem(address, size), 'little'), after=value))


def partition(calls, total):
    outside, cursor = [], 0
    for call in calls:
        begin, end = call['draw_start'], call['draw_end']
        if not cursor <= begin <= end <= total:
            raise ValueError('overlapping or invalid condition draw span')
        if cursor < begin:
            outside.append([cursor, begin])
        cursor = end
    if cursor < total:
        outside.append([cursor, total])
    return outside


def run(path):
    if path.exists():
        raise ValueError('run records are immutable')
    for name in DEPENDENCIES:
        if (ROOT / name).read_bytes() != git('show', 'HEAD:' + name):
            raise ValueError('commit producer first: ' + name)
    source, retained = reference()
    state_path, data = match.find_state(source['start_state_sha256'])
    week = match.Week(data)
    save = (ROOT / '.cache/One-Nil96/SAVE1.1-0').read_bytes()
    record = dict(schema='original-condition-handoff/1', producer=git('rev-parse', 'HEAD').decode().strip(),
        producer_files={p: sha((ROOT / p).read_bytes()) for p in DEPENDENCIES}, source=source,
        start_state=dict(path=str(state_path.relative_to(ROOT)), sha256=sha(data)),
        save=dict(path='One-Nil96/SAVE1.1-0', sha256=sha(save), size=len(save)),
        runtime=dict(python=platform.python_version(), unicorn=unicorn.__version__),
        mode='original96 quick week; no watched-mode claim', status='aborted', error=None)
    recorder = Recorder(week)
    try:
        record['code'] = authenticate_code(week.g)
        record['initial'] = initial(week.g, save)
        week.play()
        if week.g.unsupported or recorder.pending is not None or recorder.parent is not None:
            raise ValueError('unsupported service or incomplete original call')
        if week.events != retained[1:-1]:
            raise ValueError('new original week differs from retained T08 events')
        ok, lines = match.compare(week.events, source['start_state_sha256'], ROOT / source['t04_record_path'])
        if not ok:
            raise ValueError('DOSBox-X comparison differs: ' + '\n'.join(lines))
        if authenticate_code(week.g) != record['code']:
            raise ValueError('original code changed during week')
        record['comparison'] = dict(t08_equal=True, dosbox_equal=True,
             events_sha256=sha(encoded(week.events)), waits=sum(e['kind'] == 'screen' for e in week.events))
        record['status'] = 'completed'
    except (Exception, KeyboardInterrupt) as exc:
        record['error'] = type(exc).__name__ + ': ' + str(exc)
    draws = [d for d in week.events if d['kind'] == 'draw']
    for call in recorder.calls:
        call['draws'] = [{k: d[k] for k in ('n', 'seed_before', 'seed_after', 'value')}
                         for d in draws[call['draw_start']:call['draw_end']]]
    payload = dict(contexts=recorder.contexts, calls=recorder.calls, direct_helpers=recorder.direct_helpers,
                   quick_steps=recorder.quick_steps, draws=week.draws,
                   outside=partition(recorder.calls, week.draws), pending=recorder.pending)
    record.update(payload=payload, payload_sha256=sha(encoded(payload)))
    path.parent.mkdir(parents=True, exist_ok=True)
    with path.open('x') as f:
        json.dump(record, f, sort_keys=True, separators=(',', ':'))
        f.write('\n')
    print(path, record['status'], 'calls', len(recorder.calls), 'draws', week.draws, record['error'], flush=True)
    if record['status'] != 'completed':
        raise ValueError(record['error'])


def authenticate_producer(record):
    if set(record['producer_files']) != set(DEPENDENCIES):
        raise ValueError('producer census differs')
    for name, digest in record['producer_files'].items():
        if sha(git('show', record['producer'] + ':' + name)) != digest:
            raise ValueError('producer identity differs: ' + name)


def validate_input(data):
    if set(data) != set(controlled.inputs()[0]['input']):
        raise ValueError('incomplete routine inputs')
    for key in ('base_condition', 'condition', 'recovery'):
        if type(data[key]) is not int or not -128 <= data[key] <= 127:
            raise ValueError('signed condition input outside byte')
    for key in ('age', 'age_reference', 'facility', 'flag'):
        if type(data[key]) is not int or not 0 <= data[key] <= 255:
            raise ValueError('unsigned condition input outside byte')
    if not 1 <= data['player'] <= 3920 or not 1 <= data['club'] <= 176 \
            or not 0 <= data['seed'] <= 65535 or data['caps'] != [32, 25]:
        raise ValueError('routine input domain differs')


def validate(record):
    if record['schema'] != 'original-condition-handoff/1' or record['status'] != 'completed' \
            or record['error'] is not None:
        raise ValueError('incomplete handoff capture')
    authenticate_producer(record)
    source, retained = reference()
    if record['source'] != source or record['start_state']['sha256'] != source['start_state_sha256']:
        raise ValueError('handoff source identity differs')
    if record['mode'] != 'original96 quick week; no watched-mode claim':
        raise ValueError('mode claim differs')
    if set(record['code']) != {'1998', '232A', '24BC'} or any(
            len(v) != 64 or any(ch not in '0123456789abcdef' for ch in v) for v in record['code'].values()):
        raise ValueError('loaded-code digest manifest differs')
    pinned = json.loads((ROOT / 'records/T83/conditions-r0002.json').read_text())
    if any(record['save'][k] != pinned['sources']['pre'][k] for k in ('sha256', 'size')):
        raise ValueError('initial save identity differs')
    initial_state = record['initial']
    expected_first = [0] * 20
    for pid, value in pinned['decoded']['conditions_pre'].items():
        expected_first[value['slot']] = int(pid)
        if initial_state['players'][pid]['condition'] != value['condition']:
            raise ValueError('initial condition differs from T83 save decode')
    if initial_state['club'] != 130 or initial_state['manager'] != 1 \
            or initial_state['first_team'] != expected_first or len(initial_state['manager_roster']) != 20:
        raise ValueError('initial managed roster differs')
    ids = set(initial_state['first_team'] + initial_state['manager_roster']) - {0}
    if set(initial_state['players']) != {str(pid) for pid in ids}:
        raise ValueError('initial player census differs')
    for pid, player in initial_state['players'].items():
        validate_input(dict(**player, flag=0, seed=0))
        staff = initial_state['staff_by_club'][str(player['club'])]
        if player['player'] != int(pid) or staff['facility'] != player['facility'] \
                or not 0 <= staff['staff_id'] <= 1000:
            raise ValueError('initial staff/player provenance differs')
    payload = record['payload']
    if sha(encoded(payload)) != record['payload_sha256'] or payload['pending'] is not None:
        raise ValueError('handoff payload differs or is incomplete')
    draws = [d for d in retained if d['kind'] == 'draw']
    events = retained[1:-1]
    wanted_comparison = dict(t08_equal=True, dosbox_equal=True, events_sha256=sha(encoded(events)),
                             waits=sum(e['kind'] == 'screen' for e in events))
    if record['comparison'] != wanted_comparison or payload['draws'] != len(draws) \
            or payload['quick_steps'] <= 0:
        raise ValueError('original comparison/draw census differs')
    calls, contexts = payload['calls'], payload['contexts']
    if not calls or [c['index'] for c in calls] != list(range(len(calls))) \
            or [c['index'] for c in contexts] != list(range(len(contexts))):
        raise ValueError('call/context indices differ')
    # [confirmed:T85 source week] All 176 club passes precede the two
    # unconditional manager visits (01EF:4E14..4E2A). This census belongs
    # to this pinned friendly, not a scheduler model for arbitrary weeks.
    if [c['kind'] for c in contexts] != ['first_team'] * 176 + ['manager_roster'] * 2 \
            or sorted(c['club'] for c in contexts[:176]) != list(range(1, 177)) \
            or [c['manager'] for c in contexts[176:]] != [1, 2]:
        raise ValueError('complete caller visit census differs')
    owned = []
    for parent in contexts:
        if any(type(i) is not int or not 0 <= i < len(calls) for i in parent['calls']):
            raise ValueError('invalid caller-owned call index')
        selected = [calls[i] for i in parent['calls']]
        expected = [(i + 1, pid) for i, pid in enumerate(parent['roster']) if pid and parent['active']]
        if len(parent['roster']) != 20 or [(c['slot'], c['input']['player']) for c in selected] != expected:
            raise ValueError('caller slot census differs')
        if any(c['context'] != parent['index'] for c in selected):
            raise ValueError('caller ownership differs')
        if parent['kind'] not in ('first_team', 'manager_roster'):
            raise ValueError('unknown caller class')
        pop = 10 if parent['kind'] == 'first_team' else 6
        expected_ret = '1998:1B96' if parent['kind'] == 'first_team' else '1998:1869'
        if parent.get('return_instruction') != expected_ret:
            raise ValueError('caller return instruction differs')
        if parent['returned']['sp'] != (parent['entry']['sp'] + pop) & 65535 \
                or any(parent['entry'][k] != parent['returned'][k] for k in ('ss', 'ds', 'bp')):
            raise ValueError('caller ABI return differs')
        begin, end = parent['draw_start'], parent['draw_end']
        if not 0 <= begin <= end <= len(draws):
            raise ValueError('caller draw scope differs')
        if parent['entry_seed'] != (draws[begin]['seed_before'] if begin < len(draws) else draws[-1]['seed_after']) \
                or parent['exit_seed'] != (draws[end - 1]['seed_after'] if end else draws[0]['seed_before']):
            raise ValueError('caller seed handoff differs')
        if any(not begin <= c['draw_start'] <= c['draw_end'] <= end for c in selected):
            raise ValueError('condition call outside caller draw scope')
        owned += parent['calls']
    if owned != list(range(len(calls))):
        raise ValueError('missing/duplicated caller-owned call')
    covered = []
    for call in calls:
        validate_input(call['input'])
        parent = contexts[call['context']]
        if RETURNS.get(call['return_site']) != parent['kind']:
            raise ValueError('routine caller return site differs')
        before, after = call['entry'], call['returned']
        if after['sp'] != (before['sp'] + 6) & 65535 \
                or any(after[k] != before[k] for k in ('cs', 'ds', 'ss', 'bp')):
            raise ValueError('routine ABI return differs')
        if parent['kind'] == 'first_team' and call['input']['flag'] != int(
                call['slot'] <= 11 or call['status_byte'] & 4 != 0):
            raise ValueError('first-team live flag differs')
        dependency = call['dependencies']
        if not 0 <= dependency['staff_id'] <= 1000 or dependency['facility'] != call['input']['facility']:
            raise ValueError('live staff dependency differs')
        begin, end = call['draw_start'], call['draw_end']
        observed = [{k: d[k] for k in ('n', 'seed_before', 'seed_after', 'value')} for d in draws[begin:end]]
        if not observed or observed != call['draws'] or observed[0]['seed_before'] != call['input']['seed']:
            raise ValueError('literal routine draw span differs')
        covered += list(range(begin, end))
        state = {k: call['input'][k] & 255 for k in ('base_condition', 'condition', 'recovery')}
        state['seed'] = call['input']['seed']
        for write in call['writes']:
            field = write['field']
            if field not in state or write['size'] != (2 if field == 'seed' else 1) \
                    or write['before'] != state[field] or not 0 <= write['after'] < 256 ** write['size']:
                raise ValueError('observed numeric write differs')
            state[field] = write['after']
        output = {k: v if k == 'seed' else signed(v) for k, v in state.items()}
        if output != call['output'] or output['seed'] != observed[-1]['seed_after'] \
                or [w['after'] for w in call['writes'] if w['field'] == 'seed'] != [d['seed_after'] for d in observed]:
            raise ValueError('output/write/draw handoff differs')
    direct_sites = {'1998:14D0', '1998:14D8', '1998:14FE', '1998:1506'}
    helper_sites = {'1998:1429', '1998:1431', '1998:147B'}
    attributed = [d['i'] for d in draws if direct_sites.intersection(d['callers']) or
                  (helper_sites.intersection(d['callers']) and '1998:153B' in d['callers'])]
    if covered != attributed or payload['outside'] != partition(calls, len(draws)):
        raise ValueError('condition/outside draw partition differs')
    return dict(calls=len(calls), call_draws=len(covered), outside_draws=len(draws) - len(covered),
                contexts=len(contexts), initial_players=len(ids), quick_steps=payload['quick_steps'])


PROBE = '''use std::io::{self, BufRead};
use onenil_engine::condition_refresh::{Input, replay};
fn main() {
    for line in io::stdin().lock().lines() {
        let input: Input = serde_json::from_str(&line.unwrap()).unwrap();
        let result = replay(&input).unwrap();
        println!("{}", serde_json::to_string(&result).unwrap());
    }
}
'''


def projections(capture):
    return [{key: call[key] for key in ('output', 'draws', 'writes')} for call in capture['payload']['calls']]


def native_run(out, source_path, native_root):
    if out.exists():
        raise ValueError('native receipts are immutable')
    for name in DEPENDENCIES:
        if (ROOT / name).read_bytes() != git('show', 'HEAD:' + name):
            raise ValueError('commit comparison producer first')
    native_root = native_root.resolve()
    def ng(*args):
        return subprocess.check_output(['git', '-C', str(native_root), *args]).decode().strip()
    if ng('rev-parse', 'HEAD') != NATIVE or ng('status', '--porcelain', '--untracked-files=no'):
        raise ValueError('native accepted source is not clean/pinned')
    capture = json.loads(source_path.read_text())
    counts = validate(capture)
    record = dict(schema='native-condition-handoff/1', producer=git('rev-parse', 'HEAD').decode().strip(),
        producer_files={p: sha((ROOT / p).read_bytes()) for p in DEPENDENCIES},
        native_commit=NATIVE, native_tree=ng('rev-parse', 'HEAD^{tree}'),
        source=dict(path=str(source_path.relative_to(ROOT)), sha256=sha(source_path.read_bytes())),
        counts=counts, status='aborted', error=None, matches=0)
    try:
        project = ROOT / '.cache/T85-native-probe'
        (project / 'src').mkdir(parents=True, exist_ok=True)
        (project / 'src/main.rs').write_text(PROBE)
        (project / 'Cargo.toml').write_text('[package]\nname="t85-condition-probe"\nversion="0.1.0"\nedition="2021"\n'
            '[dependencies]\nonenil-engine={path=' + json.dumps(str(native_root / 'engine')) + '}\nserde_json="=1.0.154"\n')
        build = subprocess.run(['cargo', 'build', '--locked', '--manifest-path', str(project / 'Cargo.toml')],
                               stdout=subprocess.PIPE, stderr=subprocess.STDOUT, text=True)
        (project / 'build.log').write_text(build.stdout)
        if build.returncode:
            raise ValueError('native probe build failed; see .cache/T85-native-probe/build.log')
        binary = project / 'target/debug/t85-condition-probe'
        record['build'] = dict(profile='dev', features=[], probe_sha256=sha(PROBE.encode()),
            binary_sha256=sha(binary.read_bytes()), lock_sha256=sha((project / 'Cargo.lock').read_bytes()),
            rustc=subprocess.check_output(['rustc', '--version']).decode().strip())
        actual = subprocess.run([str(binary)], input=''.join(json.dumps(c['input']) + '\n'
            for c in capture['payload']['calls']), stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
        if actual.returncode:
            raise ValueError('native execution failed: ' + actual.stderr[:1000])
        results = [json.loads(line) for line in actual.stdout.splitlines()]
        for result in results:
            result['draws'] = [{k: d[k] for k in ('n', 'seed_before', 'seed_after', 'value')} for d in result['draws']]
        expected = projections(capture)
        record['matches'] = sum(a == b for a, b in zip(results, expected))
        record['actual_sha256'] = sha(encoded(results))
        record['expected_sha256'] = sha(encoded(expected))
        if results != expected:
            raise ValueError('native natural-case replay differs')
        record['status'] = 'completed'
    except (Exception, KeyboardInterrupt) as exc:
        record['error'] = type(exc).__name__ + ': ' + str(exc)
    out.parent.mkdir(parents=True, exist_ok=True)
    with out.open('x') as f:
        json.dump(record, f, indent=2, sort_keys=True)
        f.write('\n')
    print(out, record['status'], record['matches'], 'native matches', record['error'])
    if record['status'] != 'completed':
        raise ValueError(record['error'])


def validate_native(record, source_path, capture):
    authenticate_producer(record)
    if record['schema'] != 'native-condition-handoff/1' or record['status'] != 'completed' \
            or record['error'] is not None or record['native_commit'] != NATIVE:
        raise ValueError('incomplete/foreign native receipt')
    if record['native_tree'] != '6e8c5a94a7d1b4de460cda60c736822ff5bfff72' \
            or record['build']['profile'] != 'dev' or record['build']['features'] != []:
        raise ValueError('native tree/build contract differs')
    if record['source'] != dict(path=str(source_path.relative_to(ROOT)), sha256=sha(source_path.read_bytes())):
        raise ValueError('native source digest differs')
    counts = validate(capture)
    if record['counts'] != counts or record['matches'] != counts['calls']:
        raise ValueError('native comparison census differs')
    digest = sha(encoded(projections(capture)))
    if record['actual_sha256'] != digest or record['expected_sha256'] != digest:
        raise ValueError('native projection digest differs')
    if record['build']['probe_sha256'] != sha(PROBE.encode()):
        raise ValueError('native probe identity differs')
    return counts


def check():
    index = json.loads(INDEX.read_text())
    if index['schema'] != 'original-condition-handoff-index/1' or len(index['runs']) != 2 \
            or index['runs'][0]['path'] == index['runs'][1]['path']:
        raise ValueError('two fresh-machine repeats required')
    captures = []
    for row in index['runs']:
        path = ROOT / row['path']
        if sha(path.read_bytes()) != row['sha256']:
            raise ValueError('immutable handoff run digest differs')
        capture = json.loads(path.read_text())
        validate(capture)
        captures.append(capture)
    if any(captures[0][key] != captures[1][key] for key in ('initial', 'code', 'comparison', 'payload')):
        raise ValueError('fresh-machine handoff repeat differs')
    row = index['native']
    path = ROOT / row['path']
    if sha(path.read_bytes()) != row['sha256']:
        raise ValueError('immutable native receipt digest differs')
    counts = validate_native(json.loads(path.read_text()), ROOT / index['runs'][0]['path'], captures[0])
    print('PASS natural quick-week condition handoff:', counts)


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--run', type=Path)
    parser.add_argument('--check', action='store_true')
    parser.add_argument('--native-run', type=Path)
    parser.add_argument('--native-root', type=Path)
    parser.add_argument('--source', type=Path)
    args = parser.parse_args()
    if args.run:
        run(args.run)
    elif args.check:
        check()
    elif args.native_run and args.native_root and args.source:
        native_run(args.native_run, args.source.resolve(), args.native_root)
    else:
        parser.error('choose --run, --check or --native-run with --native-root/--source')
