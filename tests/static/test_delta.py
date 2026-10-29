import os
import sys
import unittest

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname(HERE)), "tools", "static"))
sys.path.insert(0, os.path.dirname(HERE))

import delta  # noqa: E402
import lzexe_fixture as fx  # noqa: E402


def program(far_seg=0x0002, imm=0x1234, extra_nop=False, data=b"AB"):
    """seg 0: call far <far_seg>:0000; mov di, imm; [nop]; retf; then string data.
    seg 2 (0x20): retf."""
    img = bytearray(0x30)
    code = bytes([0x9A, 0, 0, far_seg & 0xFF, far_seg >> 8, 0xBF, imm & 0xFF, imm >> 8])
    code += (b"\x90" if extra_nop else b"") + b"\xcb" + data
    img[:len(code)] = code
    img[0x20] = 0xCB
    return delta.Routines(fx.build_lzexe(bytes(img), relocs=[(0, 3)], ip0=0, cs0=0))


def status(a, b):
    return {r[1]: r[2] for r in delta.delta(a, b)}["0000:0000"]


class DeltaTests(unittest.TestCase):
    def test_same(self):
        self.assertEqual(status(program(), program()), "same")

    def test_an_immediate_and_trailing_data_are_operands(self):
        self.assertEqual(status(program(), program(imm=0x4321, data=b"XYZW")), "operands")

    def test_an_extra_instruction_is_changed(self):
        self.assertEqual(status(program(), program(extra_nop=True)), "changed")

    def test_an_instruction_after_a_far_call_counts(self):
        """capstone reports a bogus imm_size for far calls; the masking after one must still see
        the instructions that follow (a spilling mask fails the operands test above)."""
        a, b = program(), program(extra_nop=True)
        self.assertNotEqual(a.skeleton_digest(0, 10), b.skeleton_digest(0, 10))


if __name__ == "__main__":
    unittest.main()
