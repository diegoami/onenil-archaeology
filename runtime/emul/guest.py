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
  key goes in as the hardware would, at entries of 24BC:0C58 and only while IF is set: the machine
  pushes FLAGS, CS and IP, clears IF and TF and enters the handler through the guest's IVT entry 9,
  with port 60h answering the make code; the poll it interrupted then runs; the break code goes in
  the same way at the first poll after KEY_HOLD instructions (0.08 s at cycles 20000, as T04's driver
  holds a key), and the next key's make only after that. `in` and `out` are served by hooks: port 60h
  answers the scancode, other ports 0; writes to the timer chip are read (below), others dropped.
  A key wait is readkey 24BC:0C17 blocking: STALL_POLLS polls of 24BC:0C58 from its loop (returning
  to 24BC:0C41) with nothing queued or held stop the machine at that entry (`waiting_for_key`); polls
  from elsewhere (a match polls on every tick and goes on) answer "no key" and stop the machine only
  after OTHER_STALL_POLLS of them in a row. `press()` and `run()` resume it.
- The timer (F06 item 2): channel 0 of the timer chip interrupts every `divisor` input clocks (1,193,182
  per second; divisor 0x10000 until the game writes another through port 40h, as 1998:0096 does with
  0x400 for a match). At cycles 20000 (F04) the guest runs INSTR_PER_S instructions a second, so IRQ 0
  comes every divisor * INSTR_PER_S / 1,193,182 instructions, while IF is set (it waits, pending,
  while IF is clear). A write of a new divisor ends the running slice at that instruction, and the
  next IRQ 0 comes one new period after it (#33). [designed] Whether DOSBox-X restarts the count at
  the write or at the end of the current count is not checked; this restarts it at the write. IVT entry 8 is the BIOS's (DOSBox-X's, segment F000, not runnable): its tick is
  done here as DOSBox-X's INT8_Handler does it, the dword 0040:006C + 1, then INT 1Ch, which enters
  the game's handler when one is installed (the match's 1998:0000: it counts DS:D088 down and takes
  1 off 0040:006C at 63 of each 64 ticks, keeping the BIOS clock at 18.2 a second). The midnight
  wrap of 0040:006C and the floppy-motor count are not modelled.
- INT 16h (the BIOS keyboard) answers "no key" to AH=01h (ZF=1); a read (AH=00h) is an error (the
  game reads keys through IRQ 1).
- INT 33h, the mouse: AX=0003h answers no button and the position last set with AX=0004h (100, 100
  until the game sets one); AX=0004h sets it; AX=0000h answers installed with 2 buttons. The game polls
  the mouse only while its enabled flag is set, and turns a position outside x 70..130, y 80..120
  into cursor keys (24BC:0996, 0A6F-0AA0), then recentres it at (100, 100); a stationary mouse at the
  last position set gives no keys. This is a controlled input, not the savestate's mouse driver.
- INT 21h: the clock (2Ah date, 2Ch time) from `clock`, fixed; vectors (25h set, 35h get) through the
  IVT in guest memory; files (3Ch create, 3Dh open, 3Eh close, 3Fh read, 40h write, 42h seek, 41h
  delete, 4Eh/4Fh find, 1Ah set DTA, 2Fh get DTA) against an in-memory folder `files` seeded from the
  game folder: writes never reach the host's files.
- INT 10h AH=0Fh answers mode 3, 80 columns.
- Anything else (another INT 21h, 10h or 33h function, another interrupt) is not served: it is logged
  in `unsupported` and leaves the registers as they were, so a run that met one can say so.

Every service call is logged in `services` (interrupt, AX, the guest's CS:IP as an image address).
`budget` counts the instructions the run allowed (slices given to Unicorn, SLICE_MAX at most each);
a slice that ends early (at a key wait, or at a divisor write) still counts whole, so it is an upper
bound, not a count of instructions executed, and exceeds it by less than SLICE_MAX per early end. The next IRQ 0 is scheduled against it, so after an early end it comes as
many instructions after the stop as the schedule says (after a key wait, the rest of the slice is
time spent waiting for the key). The audit (#34): `service_counts` (calls per interrupt and
function), `mouse_answers` (what each mouse read answered), `dos_calls` (every INT 21h call in
order: its inputs, a file name, the length and sha256 of written bytes, the AX and carry it
returned).
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
                     UC_HOOK_INSN)
from unicorn import x86_const as X  # noqa: E402

DS_PARAGRAPH = 0x2864          # static/1-0-exe/README.md (F02)
CPU_GPR, CPU_EIP, CPU_FLAGS, CPU_SEGS, CPU_SEG_STRIDE = 0x00, 0x20, 0x28, 0xEB, 8
GPR_NAMES = ("EAX", "ECX", "EDX", "EBX", "ESP", "EBP", "ESI", "EDI")
SEG_NAMES = ("ES", "CS", "SS", "DS", "FS", "GS")
BDA_TICKS = 0x46C
TEXT_PAGE = 0xB8000
STALL_POLLS = 3              # polls by readkey's own loop: it blocks until a key
OTHER_STALL_POLLS = 200_000  # polls from elsewhere in a row with no key delivered
INSTR_PER_S = 20_000_000     # cycles 20000 (F04): DOSBox-X's normal core runs about 20,000 instructions per ms
PIT_HZ = 1_193_182
KEY_HOLD = 1_600_000         # 0.08 s at INSTR_PER_S: runtime/driver/driver.py's KEY_HOLD
IF_RETRY = 200               # instructions to the next look when an interrupt waits for IF
SLICE_MAX = 1_000            # instructions per Unicorn slice at most: a slice that ends early (a key
                             # wait, a divisor write) counts whole, so the clock is off by < SLICE_MAX
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
        self.waiting_for_key = False
        self.services = []                      # (int, AX, image CS:IP)
        self.service_counts = {}                # "int NN fn XXXX" -> calls
        self.mouse_answers = {}                 # "ax=0003 -> bx,cx,dx" -> calls
        self.dos_calls = []                     # every INT 21h call: function, decoded inputs, result
        self._retime = False
        self.handles = {}                       # DOS handle -> [name, position, bytearray, writable]
        self.dta = None
        self.find_state = None
        self.polls = 0
        self.error = None
        self.budget = 0                         # instructions allowed so far (see the docstring)
        self.divisor = 0x10000                  # timer chip channel 0
        self._pit_latch = []
        self.next_irq0 = None                   # budget at which IRQ 0 is due
        self.unsupported = []                   # (int, AX, image CS:IP) of calls not served
        self.held_since = None                  # budget when the held key's make went in
        self._resume_at = None                  # the linear address an IRQ 1 returned to
        self.scancodes = []                     # make/break codes still to deliver
        self.port60 = 0
        self.mouse = (100, 100)
        self.other_polls = 0
        self.wait_caller = None
        self.timer_ticks = 0                    # IRQ 0 ticks taken
        self.game_timer_ticks = 0               # of them, ticks that entered the game's INT 1Ch handler
        self.keys_delivered = []                # (key name, image CS:IP of the poll it came at)
        self.mu.hook_add(UC_HOOK_INTR, self._intr)
        self.mu.hook_add(UC_HOOK_INSN, self._in, None, 1, 0, X.UC_X86_INS_IN)
        self.mu.hook_add(UC_HOOK_INSN, self._out, None, 1, 0, X.UC_X86_INS_OUT)
        if data is not None or memory:
            self.code_hook(KEYPRESSED, self._keypressed)

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

    def _out(self, uc, port, size, value, data):
        if port == 0x43:
            self._pit_latch = []                # a new mode word: the divisor's two bytes follow
        elif port == 0x40:
            self._pit_latch.append(value & 0xFF)
            if len(self._pit_latch) == 2:
                d = self._pit_latch[0] | (self._pit_latch[1] << 8)
                self.divisor = d or 0x10000
                self._pit_latch = []
                self._retime = True             # the next IRQ 0: one new period after this write
                uc.emu_stop()

    def _keypressed(self, g):
        """At an entry of keypressed: deliver a scancode through IRQ 1, or count a poll."""
        here = self.reg("cs") * 16 + self.reg("ip")
        if self._resume_at == here:             # the IRET of a key's IRQ 1: the poll runs now
            self._resume_at = None
            return
        if self.scancodes and self.reg("eflags") & 0x200:
            name, code = self.scancodes[0]
            if code >= 0x80 and self.budget < self.held_since + KEY_HOLD:
                return                          # still held
            self.scancodes.pop(0)
            if code < 0x80:
                self.keys_delivered.append((name, self.where()))
                self.held_since = self.budget
            self.port60 = code
            self._interrupt(9)
            self._resume_at = here
            self.polls = self.other_polls = 0
            return
        if self.scancodes:
            return                              # a key is held or waits for IF: no key wait
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

    def irq0_period(self):
        return max(1, round(self.divisor * INSTR_PER_S / PIT_HZ))

    def _irq0(self):
        """One timer tick, as DOSBox-X's BIOS does it: 0040:006C + 1, then INT 1Ch (the game's handler,
        when installed). IVT entry 8 must be the BIOS's: a game handler there is not modelled."""
        if struct.unpack("<HH", self.mem(8 * 4, 4))[1] != 0xF000:
            raise GuestError("IVT entry 8 is not the BIOS's: a game timer handler is not modelled")
        t = int.from_bytes(self.mem(BDA_TICKS, 4), "little")
        self.put(BDA_TICKS, ((t + 1) & 0xFFFFFFFF).to_bytes(4, "little"))
        self.timer_ticks += 1
        if self.timer_hooked():
            self._interrupt(0x1C)
            self.game_timer_ticks += 1

    def run(self, max_steps=200_000_000):
        """Run guest code until it waits for a key with none queued (returns True), or max_steps
        instructions are allowed (returns False). Guest code runs in slices that end at the next
        IRQ 0 (the timer chip, see the docstring); the tick is taken when IF is set, else looked at
        again IF_RETRY instructions later. Deterministic: the same start state and keys give the
        same run."""
        self.waiting_for_key = False
        allowed = 0
        if self.next_irq0 is None:
            self.next_irq0 = self.budget + self.irq0_period()
        while allowed < max_steps:
            n = max(1, min(self.next_irq0 - self.budget, max_steps - allowed, SLICE_MAX))
            cs, ip = self.reg("cs"), self.reg("ip")
            self.mu.emu_start(cs * 16 + ip, 0x110000, count=n)
            self.budget += n
            allowed += n
            if self.error is not None:
                raise self.error
            if self.waiting_for_key:
                return True
            if self._retime:
                self._retime = False
                self.next_irq0 = self.budget + self.irq0_period()
                continue
            if self.budget >= self.next_irq0:
                if self.reg("eflags") & 0x200:
                    self._irq0()
                    self.next_irq0 += self.irq0_period()
                else:
                    self.next_irq0 = self.budget + IF_RETRY
        return False

    # -- services --------------------------------------------------------------------------------
    def _log(self, n):
        ax = self.reg("ax")
        self.services.append((n, ax, self.where()))
        key = "int %02X fn %04X" % (n, ax if n == 0x33 else ax >> 8)
        self.service_counts[key] = self.service_counts.get(key, 0) + 1

    def _unsupported(self, n):
        self.unsupported.append((n, self.reg("ax"), self.where()))

    def _intr(self, uc, intno, data):
        try:
            self._log(intno)
            ah = (self.reg("ax") >> 8) & 0xFF
            if intno == 0x16:
                if ah in (0x01, 0x11):
                    self.set_flag(ZF, True)
                elif ah in (0x00, 0x10):
                    raise GuestError(f"INT 16h read at {self.where()}: the game reads keys through IRQ 1")
                else:
                    self._unsupported(intno)
            elif intno == 0x33:
                ax = self.reg("ax")
                if ax == 0x0003:          # no button; the position the game last set: no movement
                    self.set_reg("bx", 0); self.set_reg("cx", self.mouse[0]); self.set_reg("dx", self.mouse[1])
                    key = "ax=0003 -> bx,cx,dx = 0,%d,%d" % self.mouse
                    self.mouse_answers[key] = self.mouse_answers.get(key, 0) + 1
                elif ax == 0x0004:        # set position (24BC:0AAA recentres it at 100, 100)
                    self.mouse = (self.reg("cx"), self.reg("dx"))
                elif ax == 0x0000:
                    self.set_reg("ax", 0xFFFF); self.set_reg("bx", 2)
                else:
                    self._unsupported(intno)
            elif intno == 0x21:
                call = self._dos_inputs(ah)
                self._int21(ah)
                call["result"] = {"ax": self.reg("ax"), "carry": bool(self.reg("eflags") & CF)}
                self.dos_calls.append(call)
            elif intno == 0x10 and ah == 0x0F:
                self.set_reg("ax", 0x5003)
                self.set_reg("bx", self.reg("bx") & 0x00FF)
            else:
                self._unsupported(intno)
        except Exception as e:  # noqa: BLE001
            self.error = e
            uc.emu_stop()

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

    def _dos_inputs(self, ah):
        """An INT 21h call's decoded inputs, for the audit: the function, the registers it reads, the
        file name it names, and for a write its length and the sha256 of the bytes (never the bytes)."""
        r = self.reg
        call = {"ah": "%02X" % ah, "at": self.where(), "bx": r("bx"), "cx": r("cx"), "dx": r("dx")}
        if ah in (0x3C, 0x3D, 0x41, 0x4E):
            call["name"] = self._asciiz(r("ds"), r("dx"))
        if ah == 0x40:
            import hashlib
            data = self.mem(r("ds") * 16 + r("dx"), r("cx"))
            call["written"] = {"length": len(data), "sha256": hashlib.sha256(data).hexdigest()}
        return call

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
            self._unsupported(0x21)


def _match(pattern, name):
    """DOS wildcard match of 8.3 names (`*` and `?`), case-insensitive."""
    import fnmatch
    return fnmatch.fnmatch(name.upper(), pattern.upper())
