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
    if (first, reserves, players) != (saved_first, saved_reserves, saved):
        raise ValueError('initial memory differs from pinned save fields')
    return dict(manager=manager, club=club, first_team=first, manager_roster=reserves,
                caps_source='original DS:0D72/0D73, not serialized in the save', players=players)


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
            context = dict(kind=kind, manager=manager, club=club, active=club != 0)
        self.parent = dict(index=len(self.contexts), **context, roster=roster,
                           draw_start=self.week.draws, draw_end=None, calls=[])
        self.contexts.append(self.parent)

    def leave_parent(self, g):
        if self.parent is None or self.pending is not None:
            raise ValueError('unmatched/incomplete caller return')
        self.parent['draw_end'] = self.week.draws
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


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--run', type=Path)
    args = parser.parse_args()
    if args.run:
        run(args.run)
    else:
        parser.error('choose --run')
