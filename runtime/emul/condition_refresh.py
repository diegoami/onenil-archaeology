#!/usr/bin/env python3
"""T84 controlled original 1998:14A5 calls; observations, never a refresh model.

--run records/T84/calls-rNNNN.json executes private original code twice in fresh
machines. --check authenticates the committed index and both independent runs.
"""
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
sys.path.insert(0, str(ROOT / 'tools/static'))
import guest
import onilexe
import unlzexe
import unicorn
from unicorn import UC_HOOK_CODE, UC_HOOK_MEM_READ, UC_HOOK_MEM_WRITE

PACKED = '89ff9c5f238f24e81a0c2440a46cdd8997280a65fc3cc3d97cb974f55280a80a'
UNPACKED = '887ed2a92767950e5309b2052409f875668605939b69e00737aa3047022b9f51'
DEPENDENCIES = ['runtime/emul/condition_refresh.py', 'runtime/emul/guest.py',
                'runtime/driver/savestate.py', 'tools/static/onilexe.py', 'tools/static/unlzexe.py']
INDEX = ROOT / 'records/T84/index.json'
P8, P15, CLUB, STAFF, SEED = 0x50000, 0x51000, 0x52000, 0x53000, 0x54000
STACK, SP, RETURN = 0x90000, 0xFF00, 0xFF00
ENTRY = 0x19980 + 0x14A5
STOP = 0x19980 + RETURN
MARKS = {0x1208, 0x125C, 0x12AE, 0x1489, 0x14C6, 0x14F4,
         0x1527, 0x1535, 0x1546}


def sha(data):
    return hashlib.sha256(data).hexdigest()


def encoded(value):
    return json.dumps(value, sort_keys=True, separators=(',', ':')).encode()


def git(*args):
    return subprocess.check_output(['git', *args], cwd=ROOT)


def inputs():
    """[designed:T84] Controlled scalar interventions, not natural match inputs."""
    base = dict(player=1, club=1, age=25, age_reference=25, facility=128,
                base_condition=17, condition=10, recovery=0, flag=1, seed=7)
    variants = [
        ('active', {}), ('unused', dict(flag=0)),
        ('cap32', dict(age=19, base_condition=40)),
        ('cap25', dict(age=30, age_reference=20, base_condition=40)),
        ('facility_cap', dict(facility=0, base_condition=40)),
        ('signed_max', dict(base_condition=127)),
        ('signed_min', dict(base_condition=-128)),
        ('unused_floor', dict(flag=0, base_condition=-20)),
        ('unused_below25', dict(flag=0, base_condition=23)),
        ('unused_at25', dict(flag=0, base_condition=26)),
        ('zero_recovered', dict(condition=0, recovery=0)),
        ('zero_blocked', dict(condition=0, recovery=20)),
        ('negative_recovered', dict(condition=-1, recovery=0)),
        ('negative_counter', dict(condition=0, recovery=-5)),
        ('counter_wrap', dict(condition=0, recovery=-128)),
        ('byte_flag', dict(flag=255)),
    ]
    return [dict(name=name, input={**base, **changes}) for name, changes in variants]


def memory_fields():
    """All semantic memory operands of 14A5/11EC/13F9 and the original RNG."""
    ds = guest.DS_PARAGRAPH * 16
    return {
        'player8_pointer': (ds + 0xD7BA, 4), 'player15_pointer': (ds + 0xD7BE, 4),
        'clubs_pointer': (ds + 0xD7C2, 4), 'staff_pointer': (ds + 0xDCC8, 4),
        'seed_pointer': (ds + 0xDE84, 4), 'caps': (ds + 0xD72, 2),
        'club': (P8 + 8, 1), 'age': (P8 + 9, 1), 'age_reference': (P8 + 10, 1),
        'base_condition': (P15 + 22, 1), 'condition': (P15 + 23, 1),
        'recovery': (P15 + 29, 1), 'staff_id': (CLUB + 44, 2),
        'facility': (STAFF + 2, 1), 'seed': (SEED, 2),
    }


def operand(address, size):
    if STACK + SP - 256 <= address and address + size <= STACK + SP + 6:
        return 'stack'
    for name, (start, length) in memory_fields().items():
        if start <= address and address + size <= start + length:
            return name
    raise ValueError('undeclared semantic memory operand: %x/%d' % (address, size))


def execute(image, case):
    """Run the original instructions with controlled inputs; do not predict outputs."""
    g = guest.Guest(memory=image, regs=dict(DS=guest.DS_PARAGRAPH, CS=0x1998,
                    SS=STACK // 16, ESP=SP, EBP=0, EFLAGS=2))
    data = case['input']
    ds = g.DS * 16
    for off, address in ((0xD7BA, P8), (0xD7BE, P15), (0xD7C2, CLUB),
                         (0xDCC8, STAFF), (0xDE84, SEED)):
        g.put(ds + off, struct.pack('<HH', 0, address // 16))
    for name in ('club', 'age', 'age_reference', 'facility',
                 'base_condition', 'condition', 'recovery'):
        address, _ = memory_fields()[name]
        g.put(address, bytes([data[name] & 255]))
    g.put(CLUB + 44, b'\0\0')
    g.put(SEED, struct.pack('<H', data['seed']))
    g.put(STACK + SP, struct.pack('<HHH', RETURN, data['flag'], data['player']))
    draws, sites, reads, writes = [], set(), {}, []
    pending = None
    finished = False
    executed = 0

    def code(mu, address, size, _):
        nonlocal pending, finished, executed
        if address == STOP:
            finished = True
            mu.emu_stop()
            return
        # Authenticate every executed instruction, including helpers, against
        # the pinned unpacked image. No service stubs or patched code run.
        if not (0 <= address < len(image)) or g.mem(address, size) != image[address:address + size]:
            raise ValueError('execution left authenticated original code at %s (linear %x)' %
                             (g.where(), address))
        executed += 1
        if g.reg('cs') == 0x1998 and g.reg('ip') in MARKS:
            sites.add('1998:%04X' % g.reg('ip'))
        if address == 0x24BC0 + 0xCDC:
            if pending is not None:
                raise ValueError('nested RNG observation')
            pending = dict(n=g.stack_word(4), seed_before=g.word_at(SEED))
        if address == 0x24BC0 + 0xCFD:
            if pending is None:
                raise ValueError('unmatched RNG return')
            pending.update(seed_after=g.word_at(SEED), value=g.reg('ax'))
            draws.append(pending)
            pending = None

    def read(mu, access, address, size, value, _):
        name = operand(address, size)
        if name != 'stack':
            reads[name] = reads.get(name, 0) + 1

    def write(mu, access, address, size, value, _):
        name = operand(address, size)
        if name == 'stack':
            return
        if name not in ('seed', 'base_condition', 'condition', 'recovery'):
            raise ValueError('undeclared semantic write: ' + name)
        writes.append(dict(field=name, before=int.from_bytes(g.mem(address, size), 'little'),
                           after=value, size=size))

    g.mu.hook_add(UC_HOOK_CODE, code)
    g.mu.hook_add(UC_HOOK_MEM_READ, read)
    g.mu.hook_add(UC_HOOK_MEM_WRITE, write)
    g.mu.emu_start(ENTRY, 0x110000, count=10000)
    if not finished or pending is not None or g.reg('sp') != SP + 6 or g.reg('cs') != 0x1998:
        raise ValueError('original routine did not complete its near ret 4')
    output = {name: struct.unpack('b', g.mem(memory_fields()[name][0], 1))[0]
              for name in ('base_condition', 'condition', 'recovery')}
    output['seed'] = g.word_at(SEED)
    return dict(**case, output=output, draws=draws, sites=sorted(sites),
                reads=reads, writes=writes, instructions=executed,
                returned=dict(cs='1998', ip=RETURN, sp=SP + 6))


def run(path):
    for name in DEPENDENCIES:
        if (ROOT / name).read_bytes() != git('show', 'HEAD:' + name):
            raise ValueError('commit producer first: ' + name)
    raw = (ROOT / '.cache/One-Nil96/1-0.EXE').read_bytes()
    if sha(raw) != PACKED:
        raise ValueError('original executable differs')
    unpacked = unlzexe.unpack(raw)
    if sha(unpacked) != UNPACKED:
        raise ValueError('unpacked original differs')
    image = onilexe.Image(unpacked).data
    cases, error = [], None
    try:
        for case in inputs():
            cases.append(execute(image, case))
    except Exception as exc:
        error = type(exc).__name__ + ': ' + str(exc)
    record = dict(schema='original-condition-calls/1', producer=git('rev-parse', 'HEAD').decode().strip(),
                  producer_files={p: sha((ROOT / p).read_bytes()) for p in DEPENDENCIES},
                  source=dict(packed_sha256=PACKED, unpacked_sha256=UNPACKED),
                  runtime=dict(python=platform.python_version(), unicorn=unicorn.__version__),
                  intervention='controlled isolated near calls; no naturally reached caller claim',
                  status='aborted' if error else 'completed', error=error,
                  cases=cases, payload_sha256=sha(encoded(cases)))
    if not error:
        validate(record)
    path.parent.mkdir(parents=True, exist_ok=True)
    with path.open('x') as f:
        json.dump(record, f, indent=2, sort_keys=True)
        f.write('\n')
    print('wrote', path, len(cases), 'completed original calls')
    if error:
        raise ValueError('aborted original capture: ' + error)


def validate(record):
    if record['schema'] != 'original-condition-calls/1' or record['status'] != 'completed':
        raise ValueError('incomplete condition calls')
    if record['source'] != dict(packed_sha256=PACKED, unpacked_sha256=UNPACKED):
        raise ValueError('original code identity differs')
    if set(record['producer_files']) != set(DEPENDENCIES):
        raise ValueError('producer census differs')
    for name, digest in record['producer_files'].items():
        if sha(git('show', record['producer'] + ':' + name)) != digest:
            raise ValueError('producer digest differs: ' + name)
    cases = record['cases']
    if sha(encoded(cases)) != record['payload_sha256']:
        raise ValueError('case payload digest differs')
    if [dict(name=c['name'], input=c['input']) for c in cases] != inputs():
        raise ValueError('controlled input census differs')
    for case in cases:
        if case['returned'] != dict(cs='1998', ip=RETURN, sp=SP + 6):
            raise ValueError('incomplete original return')
        state = {k: case['input'][k] & 255 for k in ('base_condition', 'condition', 'recovery')}
        state['seed'] = case['input']['seed']
        for write in case['writes']:
            key = write['field']
            if key not in state or write['before'] != state[key] or write['size'] != (2 if key == 'seed' else 1):
                raise ValueError('undeclared or discontinuous original write')
            if type(write['after']) is not int or not 0 <= write['after'] < 256 ** write['size']:
                raise ValueError('write value outside operand width')
            state[key] = write['after']
        actual = {k: v if k == 'seed' or v < 128 else v - 256 for k, v in state.items()}
        if actual != case['output']:
            raise ValueError('output differs from observed writes')
        previous = case['input']['seed']
        for draw in case['draws']:
            if draw['seed_before'] != previous or not 1 <= draw['value'] <= draw['n']:
                raise ValueError('draw continuity/range differs')
            previous = draw['seed_after']
        if previous != case['output']['seed']:
            raise ValueError('final RNG seed differs')
        if [w['after'] for w in case['writes'] if w['field'] == 'seed'] != [d['seed_after'] for d in case['draws']]:
            raise ValueError('draw/write census differs')
        if not case['reads'] or set(case['reads']) - set(memory_fields()) or any(
                type(n) is not int or n <= 0 for n in case['reads'].values()):
            raise ValueError('undeclared semantic read')
        if not 0 < case['instructions'] < 10000:
            raise ValueError('instruction budget differs')
    return cases


def check():
    index = json.loads(INDEX.read_text())
    if index['schema'] != 'original-condition-call-index/1' or len(index['runs']) != 2:
        raise ValueError('independent repeats required')
    outputs = []
    for entry in index['runs']:
        path = ROOT / entry['path']
        if sha(path.read_bytes()) != entry['sha256']:
            raise ValueError('immutable run digest differs')
        outputs.append(validate(json.loads(path.read_text())))
    if index['runs'][0]['path'] == index['runs'][1]['path'] or outputs[0] != outputs[1]:
        raise ValueError('independent original repeat differs')
    print('PASS', len(outputs[0]), 'controlled original calls, two fresh-machine repeats')


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--run', type=Path)
    parser.add_argument('--check', action='store_true')
    args = parser.parse_args()
    if args.run:
        run(args.run)
    elif args.check:
        check()
    else:
        parser.error('choose --run or --check')
