#!/usr/bin/env python3
"""T86 authenticated original watched suffix and numeric post-return caller trace."""
import argparse
import copy
import hashlib
import json
import platform
import re
import struct
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / 'runtime/emul'))
import checkpoint
import condition_handoff as prior
import watched_complete as full
import unicorn
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
    if unicorn.__version__ != '2.1.4':
        raise ValueError('unsupported Unicorn checkpoint context version; not loading it')
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
        self.hooks = []
        self.entry = self.returned = self.frame = None
        self.timer_effects = None
        self.service_effects = None
        self.final = self.census = self.preservation = None
        self.read_count = self.write_count = 0
        self.initial, self.ops, self.regions = [], [], []
        self.known = {}
        self.draw_start = self.draw_end = None
        self.ds_ranges = [(0xD72, 4), (0xD1A, 14), (0xD74, 8), (0xD075, 1),
            (0xD0C4, 2), (0xD146, 82),  # 0F7E live scores and two20-word performance rows
            (0xD086, 2), (0xD6DD, 1), (0xD6E4, 4), (0xDCBA, 2), (0xDCE0, 1), (0xD4FB, 177),
            *[(off, 4) for off in (0xD7BA, 0xD7BE, 0xD7C2, 0xD7C6, 0xD7CA,
                                  0xD7CE, 0xD7D2, 0xDCC0, 0xDCC8, 0xDE84)]]
        week.g.code_hook('0AB9:E679', self.enter)
        week.g.code_hook('0AB9:EBE6', self.leave)

    def enter(self, g):
        if self.entry is not None:
            if self.final is not None:
                # [T93] The week's full-time route invokes the processor for
                # every fixture of the round; an audit that has already sealed
                # one caller stands down for the route's remaining calls.
                return
            raise ValueError('second enclosing caller before stop')
        self.entry = prior.registers(g)
        self.timer_start = (g.timer_ticks, g.game_timer_ticks)
        self.service_start = dict(g.service_counts)
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
        club = g.rd(0xD4FB + self.frame['schedule_index'], 1)
        fixture = g.far(0xD7CA) + 174 * (club - 1) + 3 * (self.frame['week_slot'] - 1)
        self.frame.update(club=club, opponent=g.mem(fixture + 1, 1)[0],
                          competition=g.mem(fixture, 1)[0], performance_flag=g.rd(0xD075, 1),
                          stat_flag=g.rd(0xD6DD, 1), scores=list(g.mem(g.DS * 16 + 0xD086, 2)))
        self.before_memory = g.mem(0,0x110000)
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
        self.install()
        self.active = True

    def install(self):
        """[#214] Register the three operand hooks and keep their handles.

        `enter` calls this once the stack window is known; T98's probe calls it
        with `active=False` to install the same no-op hooks over a restored
        machine without running the caller."""
        mu = self.week.g.mu
        self.hooks = [mu.hook_add(UC_HOOK_MEM_READ, self.read, begin=0, end=self.stack_lo - 1),
                      mu.hook_add(UC_HOOK_MEM_READ, self.read, begin=self.stack_hi, end=0x10FFFF),
                      mu.hook_add(UC_HOOK_MEM_WRITE, self.write)]

    def close(self):
        """[#214] Delete the operand hooks once `Complete` has left `emu_start`.

        Unicorn 2.1.4 faults later guest code that reaches the live stack through
        a read hook (runs/T93/aborted-r0002, sevilla-week-r0002: UC_ERR_INSN_INVALID
        at 2864:B941). A hook is never deleted from inside its own callback, so the
        driver calls this after the play segment returns; repeated calls are safe."""
        handles, self.hooks = self.hooks, []
        for handle in handles:
            self.week.g.mu.hook_del(handle)

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
        self.read_count += 1
        field = self.describe(address, size)
        current = self.learn(address, size)
        self.ops.append(dict(kind='read', address=address, field=field, size=size,
                             value=current, site=self.week.g.where(), draw=self.week.draws))

    def write(self, mu, access, address, size, value, _):
        if not self.active or self.stack_lo <= address and address + size <= self.stack_hi:
            return
        self.write_count += 1
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
        self.timer_effects = dict(bios_interrupts=g.timer_ticks - self.timer_start[0],
                                 game_interrupts=g.game_timer_ticks - self.timer_start[1], divisor=g.divisor)
        self.service_effects = {key: value - self.service_start.get(key, 0)
                               for key, value in g.service_counts.items()
                               if value != self.service_start.get(key, 0)}
        if self.service_effects:
            raise ValueError('external service inside numeric caller scope')
        self.final = [dict(item,value=int.from_bytes(g.mem(item['address'],item['size']),'little'))
                      for item in self.initial]
        after = g.mem(0,0x110000)
        expected_writes = {i for op in self.ops if op['kind']=='write'
                           for i in range(op['address'],op['address']+op['size'])}
        changed = [i for i,(a,b) in enumerate(zip(self.before_memory,after)) if a!=b]
        unexpected = [i for i in changed if i not in expected_writes and not self.stack_lo<=i<self.stack_hi]
        self.preservation = dict(before_sha256=sha(self.before_memory),after_sha256=sha(after),
            changed_bytes=len(changed),unexpected_count=len(unexpected),unexpected_first=unexpected[:20])
        self.census = dict(reads=self.read_count,writes=self.write_count,initial=len(self.initial))
        if unexpected or any(self.known.get(i)!=after[i] for i in self.known):
            raise ValueError('final memory differs from recorded write footprint')
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
        runtime=dict(python=platform.python_version(), unicorn=unicorn.__version__),
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
        # [#214] The caller is sealed: delete the operand hooks before any later
        # guest code runs on this instance.
        if audit is not None:
            audit.close()
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
            timer_effects=audit.timer_effects,
            service_effects=audit.service_effects,
            final=audit.final,census=audit.census,preservation=audit.preservation,
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


POOL_SPECS = {
    'player8': (0xD7BA, 3921, 8, 0), 'player15': (0xD7BE, 3921, 15, 0),
    'club': (0xD7C2, 176, 62, 1), 'club_stats': (0xD7C6, 176, 12, 1),
    'fixture': (0xD7CA, 176, 174, 1), 'history': (0xD7CE, 176, 58, 1),
    'game': (0xD7D2, 1, 247, 0), 'club_aux': (0xDCC0, 176, 46, 1),
    'staff': (0xDCC8, 1001, 4, 0),
}
DS_RANGES = [(0xD72, 4), (0xD1A, 14), (0xD74, 8), (0xD075, 1), (0xD0C4, 2),
    (0xD146, 82), (0xD086, 2), (0xD6DD, 1), (0xD6E4, 4), (0xDCBA, 2), (0xDCE0, 1),
    (0xD4FB, 177), *[(off, 4) for off in (0xD7BA, 0xD7BE, 0xD7C2, 0xD7C6, 0xD7CA,
                                        0xD7CE, 0xD7D2, 0xDCC0, 0xDCC8, 0xDE84)]]


def value_bytes(value, size):
    if type(size) is not int or size not in (1, 2, 4) or type(value) is not int \
            or not 0 <= value < 256 ** size:
        raise ValueError('numeric operand width/value differs')
    return value.to_bytes(size, 'little')


def memory_value(memory, address, size):
    if any(address + i not in memory for i in range(size)):
        raise ValueError('missing initial semantic operand')
    return int.from_bytes(bytes(memory[address + i] for i in range(size)), 'little')


def validate(record, expected=None):
    if record['schema'] != 'original-watched-postmatch/1' or record['status'] != 'completed' \
            or record['error'] is not None:
        raise ValueError('incomplete watched caller capture')
    # Historical captures own their committed dependency census. Adding a new
    # recorder today must not add it retroactively to an accepted producer.
    paths = git('ls-tree', '-r', '--name-only', record['producer']).decode().splitlines()
    required = {name for name in paths if Path(name).suffix == '.py'
                and str(Path(name).parent) in ('runtime/emul', 'runtime/driver', 'tools/static')}
    if set(record['producer_files']) != required:
        raise ValueError('producer dependency census differs')
    for name, digest in record['producer_files'].items():
        if sha(git('show', record['producer'] + ':' + name)) != digest:
            raise ValueError('producer identity differs')
    rows = lineage()
    receipt = rows['checkpoint.json']
    if record['source'] != dict(native_commit=NATIVE, public_index_sha256=SOURCE_INDEX_SHA,
            private_sha256=receipt['private_sha256'], reference_index_sha256=REFERENCE_SHA):
        raise ValueError('private/public source lineage differs')
    if record['runtime']['unicorn'] != '2.1.4' or not record['runtime']['python']:
        raise ValueError('runtime protocol differs')
    if record['interventions'] != ['retained declared watch flag and numeric background initializer; no new state/clock edit']:
        raise ValueError('intervention claim differs')
    ticks, expected_draws, actions, finish = reference() if expected is None else expected
    payload = record['payload']
    if sha(encoded(payload)) != record['payload_sha256']:
        raise ValueError('watched caller payload digest differs')
    if payload['suffix'] != ticks[receipt['ticks']:]:
        raise ValueError('watched suffix differs from accepted source')
    boundary = payload['match_return']
    if boundary['site'] != '0AB9:EBE2' or boundary['draw'] != len(expected_draws) \
            or boundary['seed'] != finish['final']['seed'] \
            or boundary['state_sha256'] != sha(encoded(finish['final'])):
        raise ValueError('accepted match-return boundary differs')
    caller = payload['caller']
    if caller is None or caller['returned'] is None or caller['draw_start'] != boundary['draw']:
        raise ValueError('enclosing caller incomplete or starts after a hidden gap')
    entry, returned, match_regs = caller['entry'], caller['returned'], boundary['registers']
    if entry['sp'] != (match_regs['sp'] - 4) & 65535 \
            or returned['sp'] != (entry['sp'] + 4) & 65535 \
            or any(entry[k] != match_regs[k] or entry[k] != returned[k] for k in ('cs', 'ss', 'ds', 'bp')):
        raise ValueError('enclosing static-link/return ABI differs')
    frame = caller['frame']
    if frame['parent_bp'] != entry['bp'] or frame['detailed'] != 1:
        raise ValueError('enclosing frame contract differs')
    if caller['timer_effects'] != dict(bios_interrupts=0, game_interrupts=0, divisor=65535) \
            or caller['service_effects'] != {}:
        raise ValueError('unmodelled timer/external service effects')
    census=dict(reads=sum(x['kind']=='read' for x in caller['operations']),
                writes=sum(x['kind']=='write' for x in caller['operations']),initial=len(caller['initial']))
    if caller['census']!=census:
        raise ValueError('complete operand event census differs')
    if caller['preservation']['unexpected_count']!=0 or caller['preservation']['unexpected_first']!=[]:
        raise ValueError('memory outside the declared footprint changed')
    draws = payload['draws']
    if [d['i'] for d in draws] != list(range(receipt['draws'], caller['draw_end'])):
        raise ValueError('watched/caller draw ordering differs')
    watch_count = len(expected_draws) - receipt['draws']
    if [normalized(d) for d in draws[:watch_count]] != [normalized(d) for d in expected_draws[receipt['draws']:]]:
        raise ValueError('watched draw suffix differs')
    previous = expected_draws[receipt['draws']]['seed_before']
    for draw in draws:
        if draw['seed_before'] != previous or not 1 <= draw['value'] <= max(1, draw['n']):
            raise ValueError('draw seed/range continuity differs')
        previous = draw['seed_after']
    post = draws[watch_count:]
    if not post or post[0]['seed_before'] != boundary['seed']:
        raise ValueError('post-match live seed handoff differs')

    memory = {}
    for item in caller['initial']:
        raw = value_bytes(item['value'], item['size'])
        if any(item['address'] + i in memory for i in range(item['size'])):
            raise ValueError('overlapping initial operand observations')
        memory.update({item['address'] + i: b for i, b in enumerate(raw)})
    initial = dict(memory)
    ds, ss = entry['ds'] * 16, entry['ss'] * 16
    def far(off):
        value = memory_value(initial, ds + off, 4)
        return (value >> 16) * 16 + (value & 65535)
    seed = far(0xDE84)
    regions = {r['name']: r for r in caller['regions']}
    if set(regions) != set(POOL_SPECS):
        raise ValueError('declared pool census differs')
    for name, (pointer, count, stride, origin) in POOL_SPECS.items():
        if regions[name] != dict(name=name, base=far(pointer), count=count, stride=stride, origin=origin):
            raise ValueError('semantic pool binding differs')
    scratch_lo, scratch_hi = ss + entry['sp'] - 1024, ss + entry['sp'] + 6
    def location(item):
        address, size, field = item['address'], item['size'], item['field']
        if not 0 <= address < address + size <= 0x110000 \
                or max(address, scratch_lo) < min(address + size, scratch_hi):
            raise ValueError('operand escapes semantic/frame bounds')
        if field.startswith('seed+'):
            offset = int(field[5:])
            if offset < 0 or offset + size > 2 or address != seed + offset:
                raise ValueError('seed operand binding differs')
        elif field.startswith('DS:'):
            offset = int(field[3:], 16)
            if address != ds + offset or not any(lo <= offset and offset + size <= lo + n for lo, n in DS_RANGES):
                raise ValueError('undeclared DS numeric operand')
        elif field.startswith('frame:'):
            offset = int(field[6:], 16)
            if address != ss + offset or not scratch_hi <= address < address + size <= ss + entry['bp'] + 8:
                raise ValueError('parent frame input bounds differ')
        else:
            match = re.fullmatch(r'([a-z0-9_]+)\[(\d+)\]\+(\d+)', field)
            if not match or match[1] not in regions:
                raise ValueError('unclassified semantic operand')
            r = regions[match[1]]
            entity, offset = int(match[2]), int(match[3])
            if not r['origin'] <= entity < r['origin'] + r['count'] or not 0 <= offset < offset + size <= r['stride'] \
                    or address != r['base'] + (entity - r['origin']) * r['stride'] + offset:
                raise ValueError('semantic record/address binding differs')
    for item in caller['initial']:
        location(item)
    if memory_value(initial, seed, 2) != boundary['seed']:
        raise ValueError('initial live seed differs')
    if [memory_value(initial, ds + 0xD086 + i, 1) for i in range(2)] != frame['scores'] \
            or memory_value(initial, ds + 0xD075, 1) != frame['performance_flag'] \
            or memory_value(initial, ds + 0xD6DD, 1) != frame['stat_flag']:
        raise ValueError('caller score/performance inputs differ')

    written, required, touched, snapshots, seed_writes = set(), set(), set(), {}, []
    last_cursor = caller['draw_start']
    for op in caller['operations']:
        location(op)
        raw = value_bytes(op['value'], op['size'])
        if not re.fullmatch(r'[0-9A-F]{4}:[0-9A-F]{4}', op['site']) \
                or not last_cursor <= op['draw'] <= caller['draw_end']:
            raise ValueError('operand site/draw order differs')
        last_cursor = op['draw']
        if op['site'] == '1998:14AD' and op['draw'] not in snapshots:
            snapshots[op['draw']] = dict(memory)
        old = memory_value(memory, op['address'], op['size'])
        keys = set(range(op['address'], op['address'] + op['size']))
        touched |= keys
        if op['kind'] == 'read':
            if old != op['value']:
                raise ValueError('read differs from entry/observed write state')
            required |= keys - written
        elif op['kind'] == 'write':
            if old != op['before']:
                raise ValueError('write-before observation differs')
            if op['field'] == 'seed+0':
                seed_writes.append((op['draw'], op['before'], op['value']))
            memory.update({op['address'] + i: b for i, b in enumerate(raw)})
            written |= keys
        else:
            raise ValueError('unknown operand operation')
    if seed_writes != [(d['i'], d['seed_before'], d['seed_after']) for d in post] \
            or memory_value(memory, seed, 2) != post[-1]['seed_after']:
        raise ValueError('caller RNG writes differ from literal draw order')
    if touched != set(initial):
        raise ValueError('unused or missing initial operand coverage')
    if len(caller['final'])!=len(caller['initial']):
        raise ValueError('final observation census differs')
    for before,after in zip(caller['initial'],caller['final']):
        if {k:v for k,v in before.items() if k!='value'}!={k:v for k,v in after.items() if k!='value'} \
                or memory_value(memory,after['address'],after['size'])!=after['value']:
            raise ValueError('independent final memory observation differs')

    contexts, calls = payload['contexts'], payload['calls']
    if len(contexts) != 2 or [x['index'] for x in contexts] != [0, 1] \
            or [x['club'] for x in contexts] != [frame['club'], frame['opponent']]:
        raise ValueError('first post-match pair census differs')
    if [x['index'] for x in calls] != list(range(len(calls))):
        raise ValueError('condition call indices differ')
    owned, covered = [], []
    draw_map = {d['i']:d for d in post}
    for context in contexts:
        if context['kind'] != 'first_team' or not context['active'] or len(context['roster']) != 20 \
                or any(not 0 <= i < len(calls) for i in context['calls']):
            raise ValueError('caller roster/class differs')
        selected = [calls[i] for i in context['calls']]
        if [(c['slot'],c['input']['player']) for c in selected] != [(i+1,p) for i,p in enumerate(context['roster']) if p] \
                or any(c['context'] != context['index'] for c in selected):
            raise ValueError('missing or foreign roster slot call')
        if context['arguments'] != [255,255,context['club']] or context['return_instruction'] != '1998:1B96' \
                or context['returned']['sp'] != (context['entry']['sp'] + 10) & 65535 \
                or any(context['returned'][k] != context['entry'][k] for k in ('ds','ss','bp')):
            raise ValueError('first-pair caller arguments/ABI differ')
        if not caller['draw_start'] <= context['draw_start'] <= context['draw_end'] <= caller['draw_end']:
            raise ValueError('nested caller draw scope differs')
        owned += context['calls']
    if owned != list(range(len(calls))) or len(snapshots) != len(calls):
        raise ValueError('incomplete condition-entry coverage')
    for call in calls:
        prior.validate_input(call['input'])
        if call['return_site'] not in ('1998:193A','1998:19FB') \
                or call['returned']['sp'] != (call['entry']['sp']+6) & 65535 \
                or any(call['returned'][k] != call['entry'][k] for k in ('cs','ds','ss','bp')):
            raise ValueError('condition ABI differs')
        if call['input']['flag'] != int(call['slot'] <= 11 or call['status_byte'] & 4 != 0):
            raise ValueError('condition caller flag differs')
        begin,end = call['draw_start'],call['draw_end']
        if not contexts[call['context']]['draw_start'] <= begin < end <= contexts[call['context']]['draw_end']:
            raise ValueError('condition span outside parent')
        observed = [{k:draw_map[i][k] for k in ('n','seed_before','seed_after','value')} for i in range(begin,end)]
        if observed != call['draws'] or call['input']['seed'] != observed[0]['seed_before']:
            raise ValueError('condition literal draw span differs')
        covered += list(range(begin,end))
        before = snapshots[begin]
        pid = call['input']['player']
        p8,p15 = regions['player8']['base']+8*pid,regions['player15']['base']+15*pid
        for key,address,signed in [('club',p8,False),('age',p8+1,False),('age_reference',p8+2,False),
                                  ('base_condition',p15+7,True),('condition',p15+8,True)]:
            value=memory_value(before,address,1)
            if call['input'][key] != (prior.signed(value) if signed else value):
                raise ValueError('condition input differs from caller memory')
        if call['status_byte'] != memory_value(before,p15+11,1):
            raise ValueError('condition status differs from caller memory')
        staff = memory_value(before,regions['club']['base']+62*(call['input']['club']-1)+44,2)
        facility = memory_value(before,regions['staff']['base']+4*staff+2,1)
        if call['dependencies'] != dict(staff_id=staff,facility=facility) or call['input']['facility'] != facility:
            raise ValueError('condition staff dependency differs from caller memory')
        state={k:call['input'][k]&255 for k in ('base_condition','condition','recovery')}
        state['seed']=call['input']['seed']
        for write in call['writes']:
            key=write['field']
            if key not in state or write['before'] != state[key] or write['size'] != (2 if key=='seed' else 1):
                raise ValueError('condition write chain differs')
            value_bytes(write['after'],write['size']);state[key]=write['after']
        if {k:v if k=='seed' else prior.signed(v) for k,v in state.items()} != call['output'] \
                or state['seed'] != observed[-1]['seed_after']:
            raise ValueError('condition output differs')
        stores={'1998:14EE','1998:151C','1998:1527','1998:1546','1998:1449','1998:147E','1998:1489'}
        observed_writes=[]
        for op in caller['operations']:
            if op['kind']!='write':continue
            if op['field']=='seed+0' and begin<=op['draw']<end:
                key='seed'
            elif op['site'] in stores and begin<=op['draw']<=end \
                    and op['address'] in (p15+7,p15+8,p15+14):
                key={p15+7:'base_condition',p15+8:'condition',p15+14:'recovery'}[op['address']]
            else:continue
            observed_writes.append(dict(field=key,size=op['size'],before=op['before'],after=op['value']))
        if observed_writes!=call['writes']:
            raise ValueError('condition writes differ from enclosing operand audit')
    if covered != sorted(set(covered)):
        raise ValueError('overlapping condition draws')
    return dict(suffix_ticks=len(payload['suffix']), suffix_draws=watch_count,
                caller_draws=len(post), condition_calls=len(calls), condition_draws=len(covered),
                other_draws=len(post)-len(covered), initial_observations=len(caller['initial']),
                read_before_write_bytes=len(required), context_only_bytes=len(initial)-len(required),
                reads=sum(op['kind']=='read' for op in caller['operations']),
                writes=sum(op['kind']=='write' for op in caller['operations']))


def check():
    index=json.loads(INDEX.read_text())
    if index['schema']!='watched-postmatch-index/1' or len(index['runs'])!=2 \
            or index['runs'][0]['path']==index['runs'][1]['path']:
        raise ValueError('two independent restored runs required')
    expected=reference();records=[];counts=[]
    for entry in index['runs']:
        path=ROOT/entry['path']
        if sha(path.read_bytes())!=entry['sha256']:
            raise ValueError('immutable watched-tail run digest differs')
        record=json.loads(path.read_text());counts.append(validate(record,expected));records.append(record)
    if counts[0]!=counts[1] or records[0]['payload']!=records[1]['payload'] or records[0]['code']!=records[1]['code']:
        raise ValueError('independent watched caller repeat differs')
    print('PASS original watched post-match contract:',counts[0])


if __name__ == '__main__':
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('--prepare-source', type=Path)
    p.add_argument('--run', type=Path)
    p.add_argument('--private', type=Path)
    p.add_argument('--check', action='store_true')
    args = p.parse_args()
    if args.prepare_source:
        prepare_source(args.prepare_source.resolve())
    elif args.run and args.private:
        run(args.run, args.private)
    elif args.check:
        check()
    else:
        p.error('choose --prepare-source or --run/--private')
