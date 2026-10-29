"""The guest's services on hand-assembled programs (no byte of the original)."""
import os
import struct
import sys
import unittest

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
sys.path.insert(0, os.path.join(ROOT, "runtime", "emul"))

import guest  # noqa: E402

KP = 0x24BC * 16 + 0x0C58   # keypressed, at load segment 0


def machine(extra=()):
    mem = bytearray(0x40000)
    # main 1000:0000: call far 24BC:0C58 ; jmp back
    mem[0x10000:0x10007] = bytes([0x9A, 0x58, 0x0C, 0xBC, 0x24, 0xEB, 0xF9])
    mem[KP] = 0xCB                                             # keypressed stub: retf
    # IRQ 1 handler 2000:0000: in al,60h; mov bx,[502h]; mov [bx+510h],al; inc word [502h]; iret
    mem[0x20000:0x2000F] = bytes([0xE4, 0x60, 0x8B, 0x1E, 0x02, 0x05, 0x88, 0x87, 0x10, 0x05,
                                  0xFF, 0x06, 0x02, 0x05, 0xCF])
    struct.pack_into("<HH", mem, 9 * 4, 0x0000, 0x2000)
    # INT 1Ch handler 2100:0000: inc word [600h]; iret
    mem[0x21000:0x21005] = bytes([0xFF, 0x06, 0x00, 0x06, 0xCF])
    struct.pack_into("<HH", mem, 0x1C * 4, 0x0000, 0xF000)     # the BIOS's: not run
    for addr, raw in extra:
        mem[addr:addr + len(raw)] = raw
    regs = {"CS": 0x1000, "EIP": 0, "SS": 0x3000, "ESP": 0xFFFE, "DS": 0, "ES": 0, "EFLAGS": 0x202}
    return guest.Guest(memory=mem, regs=regs)


class GuestTests(unittest.TestCase):
    def test_a_key_goes_in_through_irq1_as_make_then_break(self):
        g = machine()
        g.press("Return")
        g.run(max_steps=guest.TIMER_EVERY)
        self.assertEqual(g.mem(0x510, 2), bytes([0x1C, 0x9C]))
        self.assertEqual(g.word_at(0x502), 2)
        self.assertEqual([k for k, _ in g.keys_delivered], ["Return"])

    def test_the_bios_timer_is_not_run_the_games_is(self):
        g = machine()
        g.run(max_steps=3 * guest.TIMER_EVERY)
        self.assertEqual((g.timer_ticks, g.word_at(0x600)), (0, 0))
        g.put(0x1C * 4, struct.pack("<HH", 0x0000, 0x2100))
        g.run(max_steps=3 * guest.TIMER_EVERY)
        self.assertEqual(g.timer_ticks, 3)
        # each tick is entered at the end of a slice and its handler runs in the next one
        self.assertEqual(g.word_at(0x600), 2)

    def test_a_poll_loop_without_readkey_is_not_a_key_wait(self):
        g = machine()
        self.assertFalse(g.run(max_steps=guest.TIMER_EVERY))   # polls from 1000:0005, not readkey's loop

    def test_files_live_in_memory(self):
        g = machine(extra=[(0x700, b"SAVE2.1-0\0"), (0x800, b"hello")])
        g.set_reg("ds", 0); g.set_reg("dx", 0x700); g.set_reg("cx", 0)
        g._int21(0x3C)
        h = g.reg("ax")
        g.set_reg("bx", h); g.set_reg("cx", 5); g.set_reg("dx", 0x800)
        g._int21(0x40)
        g._int21(0x3E)
        self.assertEqual(g.files["SAVE2.1-0"], b"hello")
        g.set_reg("dx", 0x700); g.set_reg("ax", 0x3D00)
        g._int21(0x3D)
        g.set_reg("bx", g.reg("ax")); g.set_reg("cx", 3); g.set_reg("dx", 0x900)
        g._int21(0x3F)
        self.assertEqual(g.mem(0x900, 3), b"hel")

    def test_the_mouse_stays_where_it_was_set(self):
        g = machine()
        g.set_reg("ax", 4); g.set_reg("cx", 100); g.set_reg("dx", 100)
        g._intr(g.mu, 0x33, None)
        g.set_reg("ax", 3); g.set_reg("cx", 0); g.set_reg("dx", 0)
        g._intr(g.mu, 0x33, None)
        self.assertEqual((g.reg("bx"), g.reg("cx"), g.reg("dx")), (0, 100, 100))


if __name__ == "__main__":
    unittest.main()
