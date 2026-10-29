#!/usr/bin/env python3
"""A Unicorn machine running One-Nil 96 (1-0.EXE) as guest code from a DOSBox-X 2024.03.01 savestate
(T06, F06).

The machine: 16-bit real mode, 1 MiB + HMA of RAM, filled from the savestate's `Memory` component
(runtime/driver/savestate.py), and the CPU's registers, flags and segments from its `CPU` component
(cpu_state(), layout ported from goal2-archaeology runtime/emul/watched_match.py at 774473eb, its E021
calibration; checked here on 96's states: the DS it reads is 1-0.EXE's, F05). Nothing runs that is not
guest code, except the services below, which stand in for the BIOS and DOS (Unicorn reports an `int`
to a hook and does not vector through the IVT; DOSBox-X's own BIOS is callbacks it cannot run):

- The keyboard: the game reads keys through its own IRQ 1 handler (IVT 9 -> 24BC:0AD0, which reads
  the scancode at port 60h and stores the key at DS:DE8C), polled by keypressed 24BC:0C58. A queued
  key is delivered as the hardware would: at an entry of 24BC:0C58 the machine pushes FLAGS, CS and
  IP, clears IF and enters the handler through the guest's IVT entry 9, with port 60h answering the
  key's make code, then, at the next poll, its break code (`in` and `out` are served by a hook; port
  60h the scancode, others 0). A key wait is readkey 24BC:0C17 blocking: STALL_POLLS polls of 24BC:0C58
  from its loop (returning to 24BC:0C41) with nothing queued stop the machine at that entry
  (`waiting_for_key`); polls from elsewhere (a match polls on every tick and goes on) answer "no key"
  and stop the machine only after OTHER_STALL_POLLS of them in a row. `press()` and `run()` resume.
- INT 16h (the BIOS keyboard) answers "no key" (AH=01h: ZF=1); a read (AH=00h) with nothing queued is
  an error (the game does not read keys through it, as far as seen).
- INT 33h, the mouse: AX=0003h answers no button and the position last set with AX=0004h (100, 100
  by default): no movement. The game turns movement away from (100, 100) into cursor keys
  (24BC:098F, 0A6F-0AA6) and recentres the mouse; AX=0000h answers installed with 2 buttons; others
  leave the registers.
- INT 21h: the clock (2Ah date, 2Ch time) from `clock`, fixed; vectors (25h set, 35h get) through the
  IVT in guest memory; files (3Ch create, 3Dh open, 3Eh close, 3Fh read, 40h write, 42h seek, 41h
  delete, 4Eh/4Fh find, 1Ah set DTA, 2Fh get DTA) against an in-memory folder `files` seeded from the
  game folder: writes never reach the host's files. Others: AX unchanged, carry clear, logged.
- INT 10h: the video BIOS; AH=0Fh answers mode 3, 80 columns; everything else is logged and ignored
  (the game writes its text page itself; the font and palette calls change nothing in memory).
- Any other interrupt: logged and ignored.
- The BIOS tick count 0040:006C advances by one at each read of it (`tick_per_read`), so a loop that
  waits for the tick to change ends; deterministic.
- The timer: the match installs its own INT 1Ch handler (1998:00BA -> 1998:0000) and speeds the timer
  chip up (divisor 0x400); `run()` enters that handler every TIMER_EVERY instructions while it is
  installed (see run()). The BIOS's own timer (INT 8, 1Ch at F000) is not run.

Every service call is logged in `services` (interrupt, AH, the guest's CS:IP as an image address).
"""
import io
import struct
import sys
import zipfile
import zlib
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / "runtime" / "driver"))
import savestate  # noqa: E402
from unicorn import (Uc, UC_ARCH_X86, UC_MODE_16, UC_HOOK_INTR, UC_HOOK_CODE,  # noqa: E402
                     UC_HOOK_MEM_READ, UC_HOOK_INSN)
from unicorn import x86_const as X  # noqa: E402

DS_PARAGRAPH = 0x2864          # static/1-0-exe/README.md (F02)
CPU_GPR, CPU_EIP, CPU_FLAGS, CPU_SEGS, CPU_SEG_STRIDE = 0x00, 0x20, 0x28, 0xEB, 8
GPR_NAMES = ("EAX", "ECX", "EDX", "EBX", "ESP", "EBP", "ESI", "EDI")
SEG_NAMES = ("ES", "CS", "SS", "DS", "FS", "GS")
BDA_TICKS = 0x46C
TEXT_PAGE = 0xB8000
STALL_POLLS = 3              # polls by readkey's own loop: it blocks until a key
OTHER_STALL_POLLS = 200_000  # polls from elsewhere in a row with no key delivered
TIMER_EVERY = 17_000         # instructions per timer tick: about 20,000 instructions per ms (cycles 20000,
                             # F04) over 1,193,182 / 0x400 = 1,165 ticks per s (1998:00C5 sets divisor 0x400)
READKEY_LOOP = "24BC:0C41"   # readkey 24BC:0C17's call of keypressed returns here (0C3E: push cs; call 0C58)
KEYPRESSED = "24BC:0C58"       # F06: keypressed, polled by every key wait seen
SCAN = {"Return": 0x1C, "space": 0x39, "Escape": 0x01, "Down": 0x50, "Up": 0x48, "Left": 0x4B,
        "Right": 0x4D, "y": 0x15, "n": 0x31, "r": 0x13, "Insert": 0x52}
ZF, CF = 0x40, 0x01
KEYS = {"Return": 0x1C0D, "space": 0x3920, "Escape": 0x011B, "Down": 0x5000, "Up": 0x4800,
        "Left": 0x4B00, "Right": 0x4D00, "y": 0x1579, "n": 0x316E, "r": 0x1372}


def cpu_state(data):
    """The registers a DOSBox-X 2024.03.01 savestate holds: {name: value}."""
    with zipfile.ZipFile(io.BytesIO(data)) as z:
        d = zlib.decompressobj().decompress(z.read("CPU"))
    regs = dict(zip(GPR_NAMES, struct.unpack_from("<8I", d, CPU_GPR)))
    regs["EIP"] = struct.unpack_from("<I", d, CPU_EIP)[0]
    regs["EFLAGS"] = struct.unpack_from("<Q", d, CPU_FLAGS)[0] & 0xFFFFFFFF
    for i, name in enumerate(SEG_NAMES):
        regs[name] = struct.unpack_from("<H", d, CPU_SEGS + CPU_SEG_STRIDE * i)[0]
    return regs


class GuestError(RuntimeError):
    pass


class Guest:
    def __init__(self, data=None, *, memory=None, load=0, regs=None, files=None, clock=None):
        self.mu = Uc(UC_ARCH_X86, UC_MODE_16)
        self.mu.mem_map(0, 0x110000)
        if data is not None:
            st = savestate.Savestate(data)
            prog = st.program()
            self.load = prog.load
            self.mu.mem_write(0, bytes(st.mem[savestate.MEM_BASE:savestate.MEM_BASE + 0x110000]))
            # DOSBox-X keeps video memory in the Vga component, not in Memory: the text page the
            # savestate shows is copied to B800:0000, where the game writes it (its far pointer)
            self.mu.mem_write(TEXT_PAGE, st.screen().raw())
            regs = cpu_state(data)
        else:
            self.load = load
            if memory:
                self.mu.mem_write(0, bytes(memory))
        self.DS = self.load + DS_PARAGRAPH
        self.start_regs = dict(regs or {})
        for name, value in self.start_regs.items():
            self.mu.reg_write(getattr(X, f"UC_X86_REG_{name}"), value)
        self.files = dict(files or {})          # upper-case name -> bytes
        self.clock = clock or {"date": (1995, 8, 1, 2), "time": (10, 0, 0, 0)}  # (y, m, d, weekday), (h, m, s, cs)
        self.queue = []                         # BIOS key words waiting
        self.waiting_for_key = False
        self.services = []                      # (int, ah, image CS:IP)
        self.handles = {}                       # DOS handle -> [name, position, bytearray, writable]
        self.dta = None
        self.find_state = None
        self.polls = 0
        self.tick_per_read = True
        self.error = None
        self.steps = 0
        self.scancodes = []                     # make/break codes still to deliver
        self.port60 = 0
        self.mouse = (100, 100)
        self.other_polls = 0
        self.wait_caller = None
        self.timer_ticks = 0
        self.keys_delivered = []                # (key name, image CS:IP of the poll it came at)
        self.mu.hook_add(UC_HOOK_INTR, self._intr)
        self.mu.hook_add(UC_HOOK_INSN, self._in, None, 1, 0, X.UC_X86_INS_IN)
        self.mu.hook_add(UC_HOOK_INSN, lambda uc, port, size, value, d: None, None, 1, 0, X.UC_X86_INS_OUT)
        if data is not None or memory:
            self.code_hook(KEYPRESSED, self._keypressed)
        self.mu.hook_add(UC_HOOK_MEM_READ, self._tick_read, begin=BDA_TICKS, end=BDA_TICKS + 3)

    # -- addresses, memory, registers ------------------------------------------------------------
    def seg(self, paragraph):
        return (self.load + paragraph) & 0xFFFF

    def lin(self, address):
        s, o = address.split(":")
        return self.seg(int(s, 16)) * 16 + int(o, 16)

    def image_address(self, cs, ip):
        return "%04X:%04X" % ((cs - self.load) & 0xFFFF, ip)

    def where(self):
        return self.image_address(self.reg("cs"), self.reg("ip"))

    def mem(self, linear, n):
        return bytes(self.mu.mem_read(linear, n))

    def put(self, linear, raw):
        self.mu.mem_write(linear, bytes(raw))

    def word_at(self, linear):
        return int.from_bytes(self.mu.mem_read(linear, 2), "little")

    def rd(self, off, n=2):
        return int.from_bytes(self.mu.mem_read(self.DS * 16 + off, n), "little")

    def far(self, off):
        return self.rd(off + 2) * 16 + self.rd(off)

    def reg(self, name):
        return self.mu.reg_read(getattr(X, f"UC_X86_REG_{name.upper()}"))

    def set_reg(self, name, value):
        self.mu.reg_write(getattr(X, f"UC_X86_REG_{name.upper()}"), value)

    def set_flag(self, mask, on):
        f = self.reg("eflags")
        self.set_reg("eflags", (f | mask) if on else (f & ~mask))

    def stack_word(self, offset):
        return self.word_at(self.reg("ss") * 16 + ((self.reg("sp") + offset) & 0xFFFF))

    def code_hook(self, address, fn):
        """fn(guest) at each execution of the instruction at image address 'SSSS:OOOO'."""
        lin = self.lin(address)
        self.mu.hook_add(UC_HOOK_CODE, lambda uc, a, s, d: fn(self), begin=lin, end=lin)

    # -- the screen ------------------------------------------------------------------------------
    def screen(self):
        raw = self.mem(TEXT_PAGE, 4000)
        return savestate.Screen(raw[0::2], raw[1::2])

    # -- keys and running ------------------------------------------------------------------------
    def press(self, *names):
        for n in names:
            self.scancodes += [(n, SCAN[n]), (n, SCAN[n] | 0x80)]

    def _in(self, uc, port, size, data):
        return self.port60 if port == 0x60 else 0

    def _keypressed(self, g):
        """At an entry of keypressed: deliver the next scancode through IRQ 1, or count a poll."""
        if self.scancodes:
            name, code = self.scancodes.pop(0)
            if code < 0x80:
                self.keys_delivered.append((name, self.where()))
            self.port60 = code
            ss, sp = self.reg("ss"), self.reg("sp")
            frame = struct.pack("<HHH", self.reg("ip"), self.reg("cs"), self.reg("eflags") & 0xFFFF)
            sp = (sp - 6) & 0xFFFF
            self.put(ss * 16 + sp, frame)
            self.set_reg("sp", sp)
            self.set_flag(0x200, False)
            off, seg = struct.unpack("<HH", self.mem(9 * 4, 4))
            self.set_reg("cs", seg)
            self.set_reg("ip", off)
            self.polls = self.other_polls = 0
            return
        # A key wait is readkey 24BC:0C17 blocking: its loop calls keypressed from 0C3E (returning
        # to 24BC:0C41). Polls from anywhere else (a match polls on every tick) answer "no key" and
        # count only towards OTHER_STALL_POLLS, a loop that only polls.
        caller = self.image_address(self.stack_word(2), self.stack_word(0))
        if caller == READKEY_LOOP:
            self.polls += 1
        else:
            self.other_polls += 1
        if self.polls >= STALL_POLLS or self.other_polls >= OTHER_STALL_POLLS:
            self.polls = self.other_polls = 0
            self.wait_caller = caller
            self.waiting_for_key = True
            self.mu.emu_stop()

    def _interrupt(self, n):
        """Enter the guest's handler of interrupt n as the CPU would: FLAGS, CS, IP pushed, IF and TF cleared."""
        ss, sp = self.reg("ss"), (self.reg("sp") - 6) & 0xFFFF
        self.put(ss * 16 + sp, struct.pack("<HHH", self.reg("ip"), self.reg("cs"), self.reg("eflags") & 0xFFFF))
        self.set_reg("sp", sp)
        self.set_flag(0x300, False)
        off, seg = struct.unpack("<HH", self.mem(n * 4, 4))
        self.set_reg("cs", seg)
        self.set_reg("ip", off)

    def timer_hooked(self):
        """The game's own INT 1Ch handler is installed (not the BIOS's, segment F000)."""
        return struct.unpack("<HH", self.mem(0x1C * 4, 4))[1] != 0xF000

    def run(self, max_steps=200_000_000):
        """Run guest code until it waits for a key with none queued (returns True), or max_steps
        instructions pass (returns False). Guest code runs in slices of TIMER_EVERY instructions;
        between two slices, while the game's own INT 1Ch handler is installed (the match's timer,
        1998:0000, which counts DS:D088 down) and IF is set, one timer interrupt enters it
        (`timer_ticks` counts them). Deterministic: the same start state and keys give the same run."""
        self.waiting_for_key = False
        done = 0
        while done < max_steps:
            cs, ip = self.reg("cs"), self.reg("ip")
            self.mu.emu_start(cs * 16 + ip, 0x110000, count=TIMER_EVERY)
            done += TIMER_EVERY
            if self.error is not None:
                raise self.error
            if self.waiting_for_key:
                self.steps += done
                return True
            if self.timer_hooked() and self.reg("eflags") & 0x200:
                self._interrupt(0x1C)
                self.timer_ticks += 1
        self.steps += done
        return False

    # -- services --------------------------------------------------------------------------------
    def _tick_read(self, uc, access, address, size, value, data):
        if self.tick_per_read and address == BDA_TICKS:
            t = int.from_bytes(uc.mem_read(BDA_TICKS, 4), "little")
            uc.mem_write(BDA_TICKS, ((t + 1) & 0xFFFFFFFF).to_bytes(4, "little"))

    def _log(self, n, ah):
        self.services.append((n, ah, self.where()))

    def _back_to_int(self, uc):
        """Point IP back at the 2-byte `int nn` just executed, so that a resumed run repeats it."""
        self.set_reg("ip", (self.reg("ip") - 2) & 0xFFFF)
        self.waiting_for_key = True
        uc.emu_stop()

    def _intr(self, uc, intno, data):
        try:
            ah = (self.reg("ax") >> 8) & 0xFF
            if intno == 0x16:
                self._int16(uc, ah)
            elif intno == 0x33:
                ax = self.reg("ax")
                if ax == 0x0003:          # no button; the position the game last set: no movement
                    self.set_reg("bx", 0); self.set_reg("cx", self.mouse[0]); self.set_reg("dx", self.mouse[1])
                elif ax == 0x0004:        # set position (24BC:0AAA recentres it at 100, 100)
                    self.mouse = (self.reg("cx"), self.reg("dx"))
                elif ax == 0x0000:
                    self.set_reg("ax", 0xFFFF); self.set_reg("bx", 2)
            elif intno == 0x21:
                self._log(0x21, ah)
                self._int21(ah)
            elif intno == 0x10:
                self._log(0x10, ah)
                if ah == 0x0F:
                    self.set_reg("ax", 0x5003)
                    self.set_reg("bx", self.reg("bx") & 0x00FF)
            else:
                self._log(intno, ah)
        except Exception as e:  # noqa: BLE001
            self.error = e
            uc.emu_stop()

    def _int16(self, uc, ah):
        self._log(0x16, ah)
        if ah in (0x01, 0x11):
            self.set_flag(ZF, True)
        elif ah in (0x00, 0x10):
            raise GuestError(f"INT 16h read at {self.where()}: the game reads keys through IRQ 1 elsewhere")

    # -- DOS -------------------------------------------------------------------------------------
    def _asciiz(self, seg, off):
        out = bytearray()
        while len(out) < 128:
            b = self.mem(seg * 16 + off + len(out), 1)[0]
            if b == 0:
                break
            out.append(b)
        return out.decode("latin-1").upper().replace("C:\\", "").lstrip("\\")

    def _ok(self, ax=None):
        if ax is not None:
            self.set_reg("ax", ax)
        self.set_flag(CF, False)

    def _fail(self, code):
        self.set_reg("ax", code)
        self.set_flag(CF, True)

    def _int21(self, ah):
        r = self.reg
        if ah == 0x2A:
            y, m, d, wd = self.clock["date"]
            self.set_reg("cx", y); self.set_reg("dx", (m << 8) | d); self.set_reg("ax", (r("ax") & 0xFF00) | wd)
        elif ah == 0x2C:
            h, mi, s, cs = self.clock["time"]
            self.set_reg("cx", (h << 8) | mi); self.set_reg("dx", (s << 8) | cs)
        elif ah == 0x25:
            n = r("ax") & 0xFF
            self.put(n * 4, struct.pack("<HH", r("dx"), r("ds")))
        elif ah == 0x35:
            n = r("ax") & 0xFF
            off, seg = struct.unpack("<HH", self.mem(n * 4, 4))
            self.set_reg("bx", off); self.set_reg("es", seg)
        elif ah == 0x1A:
            self.dta = r("ds") * 16 + r("dx")
        elif ah == 0x2F:
            dta = self.dta if self.dta is not None else 0
            self.set_reg("es", dta // 16); self.set_reg("bx", dta % 16)
        elif ah in (0x3C, 0x3D):
            name = self._asciiz(r("ds"), r("dx"))
            if ah == 0x3D and name not in self.files:
                return self._fail(2)
            if ah == 0x3C:
                self.files[name] = b""
            h = 5 + len(self.handles)
            while h in self.handles:
                h += 1
            self.handles[h] = [name, 0, bytearray(self.files[name]), ah == 0x3C or (r("ax") & 3) != 0]
            self._ok(h)
        elif ah == 0x3E:
            hd = self.handles.pop(r("bx"), None)
            if hd and hd[3]:
                self.files[hd[0]] = bytes(hd[2])
            self._ok()
        elif ah == 0x3F:
            hd = self.handles.get(r("bx"))
            if hd is None:
                return self._fail(6)
            n = r("cx")
            chunk = bytes(hd[2][hd[1]:hd[1] + n])
            self.put(r("ds") * 16 + r("dx"), chunk)
            hd[1] += len(chunk)
            self._ok(len(chunk))
        elif ah == 0x40:
            hd = self.handles.get(r("bx"))
            if hd is None:
                return self._fail(6)
            n = r("cx")
            data = self.mem(r("ds") * 16 + r("dx"), n)
            buf = hd[2]
            if hd[1] > len(buf):
                buf.extend(bytes(hd[1] - len(buf)))
            buf[hd[1]:hd[1] + n] = data
            hd[1] += n
            self._ok(n)
        elif ah == 0x42:
            hd = self.handles.get(r("bx"))
            if hd is None:
                return self._fail(6)
            off = (r("cx") << 16) | r("dx")
            base = {0: 0, 1: hd[1], 2: len(hd[2])}[r("ax") & 0xFF]
            hd[1] = (base + off) & 0xFFFFFFFF
            self.set_reg("dx", hd[1] >> 16)
            self._ok(hd[1] & 0xFFFF)
        elif ah == 0x41:
            name = self._asciiz(r("ds"), r("dx"))
            if self.files.pop(name, None) is None:
                return self._fail(2)
            self._ok()
        elif ah in (0x4E, 0x4F):
            if ah == 0x4E:
                pat = self._asciiz(r("ds"), r("dx"))
                self.find_state = [n for n in sorted(self.files) if _match(pat, n)]
            if not self.find_state:
                return self._fail(0x12)
            name = self.find_state.pop(0)
            dta = self.dta if self.dta is not None else 0
            rec = bytearray(43)
            rec[0x15] = 0x20
            struct.pack_into("<I", rec, 0x1A, len(self.files[name]))
            rec[0x1E:0x1E + len(name)] = name.encode("latin-1")
            self.put(dta, rec)
            self._ok(0)
        else:
            self._ok(r("ax"))


def _match(pattern, name):
    """DOS wildcard match of 8.3 names (`*` and `?`), case-insensitive."""
    import fnmatch
    return fnmatch.fnmatch(name.upper(), pattern.upper())
