#!/usr/bin/env python3
"""T86 authenticated original watched suffix and numeric post-return caller trace."""
import argparse
import copy
import hashlib
import json
import struct
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / 'runtime/emul'))
import checkpoint
import condition_handoff as prior
import watched_complete as full
from unicorn import UC_HOOK_MEM_READ, UC_HOOK_MEM_WRITE

NATIVE = prior.NATIVE
REFERENCE_SHA = '30a4fe8003f4677c2e2af0966d5fe81055c728a1b41c998a9d03766637414886'
SOURCE = ROOT / 'records/T86/source'
SOURCE_INDEX_SHA = 'd89f6152c66dcd7eac1ee1fe5779164d6c97c376bec82c3c1b9ef36a4ed26122'
INDEX = ROOT / 'records/T86/index.json'
PUBLIC = {
    'checkpoint.json': 'records/T45/original-r0003/checkpoint-r0047.json',
    'start.json': 'records/T45/original-r0003/start.json',
    'manifest.json': 'records/T45/original-r0003/manifest.json',
    'result.json': 'records/T45/original-r0003/result.json',
    'observer.py': 'records/T45/preservation-observer-r0003.py',
}
DEPENDENCIES = sorted(str(p.relative_to(ROOT)) for folder in ('runtime/emul', 'runtime/driver', 'tools/static')
                      for p in (ROOT / folder).glob('*.py'))
sha = prior.sha
encoded = prior.encoded
git = prior.git


def prepare_source(native_root):
    head = subprocess.check_output(['git', '-C', str(native_root), 'rev-parse', 'HEAD']).decode().strip()
    if head != NATIVE:
        raise ValueError('wrong native source')
    files = {}
    SOURCE.mkdir(parents=True, exist_ok=True)
    for name, path in PUBLIC.items():
        data = subprocess.check_output(['git', '-C', str(native_root), 'show', NATIVE + ':' + path])
        with (SOURCE / name).open('xb') as f:
            f.write(data)
        files[name] = dict(source=path, sha256=sha(data))
    with (SOURCE / 'index.json').open('x') as f:
        json.dump(dict(native_commit=NATIVE, files=files), f, indent=2, sort_keys=True)
        f.write('\n')
    print('copied authenticated public checkpoint lineage; no private bytes copied')


def lineage():
    if sha((SOURCE / 'index.json').read_bytes()) != SOURCE_INDEX_SHA:
        raise ValueError('accepted public checkpoint lineage root differs')
    index = json.loads((SOURCE / 'index.json').read_text())
    if index['native_commit'] != NATIVE or set(index['files']) != set(PUBLIC):
        raise ValueError('checkpoint lineage census differs')
    rows = {}
    for name, entry in index['files'].items():
        data = (SOURCE / name).read_bytes()
        if entry['source'] != PUBLIC[name] or sha(data) != entry['sha256']:
            raise ValueError('checkpoint public source digest differs')
        if name.endswith('.json'):
            rows[name] = json.loads(data)
    manifest = rows['manifest.json']['files']
    for name in ('start.json', 'result.json'):
        if sha((SOURCE / name).read_bytes()) != manifest[name]:
            raise ValueError('checkpoint manifest link differs')
    if sha((SOURCE / 'checkpoint.json').read_bytes()) != manifest['checkpoint-r0047.json']:
        raise ValueError('checkpoint receipt link differs')
    start = rows['start.json']
    if start['schema'] != 'original-prepared-full-lifecycle/3' \
            or sha((SOURCE / 'observer.py').read_bytes()) != start['observer_sha256'] \
            or start['reference_index_sha256'] != REFERENCE_SHA:
        raise ValueError('checkpoint observer/reference protocol differs')
    return rows


def reference():
    path = ROOT / 'traces/T40/index.json'
    if sha(path.read_bytes()) != REFERENCE_SHA:
        raise ValueError('watched reference index differs')
    index = json.loads(path.read_text())
    ticks, draws, actions = [], [], []
    for entry in [index['start'], *index['chunks'], index['finish']]:
        data = (ROOT / entry['path']).read_bytes()
        if sha(data) != entry['sha256']:
            raise ValueError('watched reference leaf differs')
        value = json.loads(data)
        if 'payload' in value:
            payload = value['payload']
            if sha(encoded(payload)) != value['payload_sha256']:
                raise ValueError('watched reference payload differs')
            ticks += payload['ticks']
            draws += payload['draws']
            actions += payload['actions']
    if (len(ticks), len(draws), len(actions)) != (4199, 182811, 831) \
            or value['status'] != 'completed' or value['boundary'] != '0AB9:EBE2':
        raise ValueError('watched reference completion differs')
    return ticks, draws, actions, value


def normalized(draw):
    callers = draw['callers']
    site = callers[1] if callers[0] == '24BC:0D4F' else callers[2]
    return {k: draw[k] for k in ('n', 'seed_before', 'seed_after', 'value')} | dict(site=site)


def restore(private):
    rows = lineage()
    receipt, start = rows['checkpoint.json'], rows['start.json']
    if sha(private.read_bytes()) != receipt['private_sha256']:
        raise ValueError('private checkpoint digest differs; not loading it')
    # Only the checksum-authenticated owner-created checkpoint is deserialized.
    saved = checkpoint.read_private(private)
    if saved['observer_sha256'] != start['observer_sha256'] \
            or saved['reference_index_sha256'] != REFERENCE_SHA:
        raise ValueError('private checkpoint source protocol differs')
    if (saved['result']['ticks'], saved['machine']['week']['draws'], saved['result']['actions']) != (
            receipt['ticks'], receipt['draws'], receipt['actions']):
        raise ValueError('private/public checkpoint cursors differ')
    expected = reference()
    actual = [normalized(d) for d in saved['events'] if d['kind'] == 'draw']
    if actual != [normalized(d) for d in expected[1][:receipt['draws']]]:
        raise ValueError('checkpoint draw prefix differs')
    week = checkpoint.restore(saved['machine'], prior.match.Week, saved['events'])
    return week, saved, expected, rows


class Complete(Exception):
    pass


class NumericAudit:
    """Record actual operand values; generic trace consistency, no game model."""
    def __init__(self, week):
        self.week = week
        self.active = False
        self.entry = self.returned = self.frame = None
        self.initial, self.ops, self.regions = [], [], []
        self.known = {}
        self.draw_start = self.draw_end = None
        self.ds_ranges = [(0xD72, 4), (0xD1A, 14), (0xD74, 8), (0xD075, 1),
            (0xD0C4, 2), (0xD146, 82),  # 0F7E live scores and two20-word performance rows
            (0xD086, 2), (0xD6DD, 1), (0xD6E4, 4), (0xDCBA, 2), (0xD4FB, 177),
            *[(off, 4) for off in (0xD7BA, 0xD7BE, 0xD7C2, 0xD7C6, 0xD7CA,
                                  0xD7CE, 0xD7D2, 0xDCC0, 0xDCC8, 0xDE84)]]
        week.g.code_hook('0AB9:E679', self.enter)
        week.g.code_hook('0AB9:EBE6', self.leave)

    def enter(self, g):
        if self.entry is not None:
            raise ValueError('second enclosing caller before stop')
        self.entry = prior.registers(g)
        self.draw_start = self.week.draws
        stack = g.reg('ss') * 16
        self.stack_lo = stack + g.reg('sp') - 1024
        self.stack_hi = stack + g.reg('sp') + 6
        self.frame_hi = stack + g.reg('bp') + 8
        link = g.stack_word(2)
        if link != g.reg('bp') or g.stack_word(0) != 0xEBE6:
            raise ValueError('enclosing static link/return frame differs')
        self.frame = dict(parent_bp=link, week_slot=g.word_at(stack + link + 6),
                          schedule_index=g.word_at(stack + link - 2),
                          detailed=g.mem(stack + link - 7, 1)[0])
        for off, name, count, stride, origin in (
                (0xD7BA, 'player8', 3921, 8, 0), (0xD7BE, 'player15', 3921, 15, 0),
                (0xD7C2, 'club', 176, 62, 1), (0xD7C6, 'club_stats', 176, 12, 1),
                (0xD7CA, 'fixture', 176, 174, 1), (0xD7CE, 'history', 176, 58, 1),
                (0xD7D2, 'game', 1, 247, 0), (0xDCC0, 'club_aux', 176, 46, 1),
                (0xDCC8, 'staff', 1001, 4, 0)):
            self.regions.append(dict(name=name, base=g.far(off), count=count, stride=stride, origin=origin))
        self.seed = g.far(0xDE84)
        # Scratch-stack hooks must be excluded at registration: a global read
        # hook can re-enter RETF in Unicorn2.1.4 (T84). Parent frame data above
        # this window is traced, and the hidden static link is explicit above.
        for r in self.regions:
            if max(r['base'], self.stack_lo) < min(r['base'] + r['count'] * r['stride'], self.stack_hi):
                raise ValueError('scratch window overlaps declared semantic pool')
        g.mu.hook_add(UC_HOOK_MEM_READ, self.read, begin=0, end=self.stack_lo - 1)
        g.mu.hook_add(UC_HOOK_MEM_READ, self.read, begin=self.stack_hi, end=0x10FFFF)
        g.mu.hook_add(UC_HOOK_MEM_WRITE, self.write)
        self.active = True

    def describe(self, address, size):
        if size not in (1, 2, 4):
            raise ValueError('unclassified operand width')
        if self.seed <= address and address + size <= self.seed + 2:
            return 'seed+%d' % (address - self.seed)
        ds = self.week.g.DS * 16
        for offset, length in self.ds_ranges:
            if ds + offset <= address and address + size <= ds + offset + length:
                return 'DS:%04X' % (address - ds)
        for r in self.regions:
            delta = address - r['base']
            if 0 <= delta and delta + size <= r['count'] * r['stride']:
                entity, field = divmod(delta, r['stride'])
                if field + size > r['stride']:
                    raise ValueError('operand crosses semantic record boundary')
                return '%s[%d]+%d' % (r['name'], entity + r['origin'], field)
        if self.stack_hi <= address and address + size <= self.frame_hi:
            return 'frame:%04X' % (address - self.week.g.reg('ss') * 16)
        raise ValueError('unclassified semantic operand at %05X/%d (%s)' % (address, size, self.week.g.where()))

    def learn(self, address, size):
        raw = self.week.g.mem(address, size)
        unknown = [i for i in range(size) if address + i not in self.known]
        if len(unknown) == size:
            self.initial.append(dict(address=address, field=self.describe(address, size),
                                     size=size, value=int.from_bytes(raw, 'little')))
        else:
            for i in unknown:
                self.initial.append(dict(address=address + i, field=self.describe(address + i, 1), size=1, value=raw[i]))
        for i in unknown:
            self.known[address + i] = raw[i]
        if any(self.known[address + i] != raw[i] for i in range(size)):
            raise ValueError('operand changed outside observed writes')
        return int.from_bytes(raw, 'little')

    def read(self, mu, access, address, size, value, _):
        if not self.active:
            return
        field = self.describe(address, size)
        current = self.learn(address, size)
        self.ops.append(dict(kind='read', address=address, field=field, size=size,
                             value=current, site=self.week.g.where(), draw=self.week.draws))

    def write(self, mu, access, address, size, value, _):
        if not self.active or self.stack_lo <= address and address + size <= self.stack_hi:
            return
        field = self.describe(address, size)
        before = self.learn(address, size)
        self.ops.append(dict(kind='write', address=address, field=field, size=size,
                             before=before, value=value, site=self.week.g.where(), draw=self.week.draws))
        for i, byte in enumerate(value.to_bytes(size, 'little')):
            self.known[address + i] = byte

    def leave(self, g):
        if not self.active:
            return
        self.returned = prior.registers(g)
        self.draw_end = self.week.draws
        self.active = False
        raise Complete()


def run(out, private):
    if out.exists():
        raise ValueError('run records are immutable')
    for name in DEPENDENCIES:
        if (ROOT / name).read_bytes() != git('show', 'HEAD:' + name):
            raise ValueError('commit recorder first: ' + name)
    rows = lineage()
    record = dict(schema='original-watched-postmatch/1', producer=git('rev-parse', 'HEAD').decode().strip(),
        producer_files={p: sha((ROOT / p).read_bytes()) for p in DEPENDENCIES},
        source=dict(native_commit=NATIVE, public_index_sha256=sha((SOURCE / 'index.json').read_bytes()),
                    private_sha256=rows['checkpoint.json']['private_sha256'], reference_index_sha256=REFERENCE_SHA),
        interventions=['retained declared watch flag and numeric background initializer; no new state/clock edit'],
        status='aborted', error=None)
    audit = observer = week = None
    suffix = []
    match_return = None
    try:
        week, saved, expected, _ = restore(private)
        record['code'] = prior.authenticate_code(week.g)
        expected_ticks, expected_draws, expected_actions, finish = expected
        pending = copy.deepcopy(saved['pending'])
        tick = saved['tick']
        action_pending = None
        audit = NumericAudit(week)
        observer = prior.Recorder(week)
        def tick_enter(g):
            nonlocal pending, tick
            if match_return is not None:
                return
            if pending is not None:
                raise ValueError('nested restored watched tick')
            tick += 1
            pending = dict(tick=tick, draw_start=week.draws, before=full.state(g))
        def tick_leave(g):
            nonlocal pending
            if match_return is not None:
                return
            if pending is None:
                raise ValueError('restored tick return without entry')
            pending.update(draw_end=week.draws, after=full.state(g))
            if pending != expected_ticks[pending['tick'] - 1]:
                raise ValueError('restored watched suffix differs')
            suffix.append(pending)
            pending = None
        def action_enter(g):
            nonlocal action_pending
            if match_return is None:
                action_pending = g.rd(0x380)
        def action_leave(g):
            nonlocal action_pending
            if match_return is None and action_pending is not None and action_pending != g.rd(0x380):
                raise ValueError('unexpected action beyond the complete source action prefix')
            action_pending = None
        def returned(g):
            nonlocal match_return
            actual = [normalized(d) for d in week.events if d['kind'] == 'draw']
            if pending is not None or tick != 4199 or full.state(g) != finish['final'] \
                    or actual != [normalized(d) for d in expected_draws]:
                raise ValueError('restored original EBE2 boundary differs')
            match_return = dict(site=g.where(), draw=week.draws, seed=g.word_at(g.far(0xDE84)),
                                 registers=prior.registers(g), state_sha256=sha(prior.encoded(full.state(g))))
        for site, callback in [('0AB9:7A02', tick_enter), ('0AB9:7B79', tick_leave),
                               ('0AB9:0F94', action_enter), ('0AB9:0FFC', action_leave), ('0AB9:EBE2', returned)]:
            week.g.code_hook(site, callback)
        try:
            week.play(max_run_on=500000)
        except Complete:
            pass
        else:
            raise ValueError('original ended without E679 return')
        if match_return is None or observer.parent is not None or observer.pending is not None \
                or week.g.unsupported or prior.authenticate_code(week.g) != record['code']:
            raise ValueError('incomplete/unsupported original caller continuation')
        record['status'] = 'completed'
    except (Exception, KeyboardInterrupt) as exc:
        record['error'] = type(exc).__name__ + ': ' + str(exc)
    draws = [] if week is None else [d for d in week.events if d['kind'] == 'draw']
    payload = dict(suffix=suffix, match_return=match_return,
        caller=None if audit is None else dict(entry=audit.entry, returned=audit.returned, frame=audit.frame,
            regions=audit.regions, initial=audit.initial, operations=audit.ops,
            draw_start=audit.draw_start, draw_end=audit.draw_end),
        contexts=[] if observer is None else observer.contexts,
        calls=[] if observer is None else observer.calls,
        draws=draws[182417:])
    for call in payload['calls']:
        call['draws'] = [{k:d[k] for k in ('n','seed_before','seed_after','value')}
                         for d in draws[call['draw_start']:call['draw_end']]]
    record.update(payload=payload, payload_sha256=sha(encoded(payload)))
    out.parent.mkdir(parents=True, exist_ok=True)
    with out.open('x') as f:
        json.dump(record, f, sort_keys=True, separators=(',', ':'))
        f.write('\n')
    print(out, record['status'], record['error'], 'suffix ticks',len(suffix),flush=True)
    if record['status'] != 'completed':
        raise ValueError(record['error'])


if __name__ == '__main__':
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('--prepare-source', type=Path)
    p.add_argument('--run', type=Path)
    p.add_argument('--private', type=Path)
    args = p.parse_args()
    if args.prepare_source:
        prepare_source(args.prepare_source.resolve())
    elif args.run and args.private:
        run(args.run, args.private)
    else:
        p.error('choose --prepare-source or --run/--private')
