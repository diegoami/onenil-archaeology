"""T02: the decompiled view of 1-0.EXE (tools/static/decompile.sh, static/1-0-exe/decompiled/).

Ported from goal2-archaeology tests/static/test_decompile.py at 774473eb; the probed addresses are
1-0.EXE's, found in static/1-0-exe/code/; goal2's F009 flag-counter tests are not ported.

- GhidraMappingTests runs Ghidra's MZ loader and tools/static/ghidra/OnilSetup.java on One-Nil 96's
  1-0.EXE and checks that known routines sit at their listing addresses with the listing's bytes,
  that a near call whose 16-bit displacement wraps (0AB9:836D), near calls across a linear 64K line
  and far calls reach the right functions, and that DS-relative operands land in the data segment
  2864. Skipped where Ghidra or the original file is missing (CI).
- RewriteTests and RenderTests check tools/static/decompiled.py on small made-up inputs.
- RetryConditionTests read tools/static/ghidra/OnilDecompile.java and check that its retry loop
  retries only a dead decompiler process.
- CommittedOutputTests check the committed static/1-0-exe/decompiled/ against routines.tsv.
"""
import glob
import re
import os
import shutil
import subprocess
import sys
import unittest
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parent.parent
sys.path.insert(0, str(ROOT / "tools" / "static"))

import decompiled  # noqa: E402
import ghidra_work  # noqa: E402

OUT = ROOT / "static" / "1-0-exe" / "decompiled"
ROUTINES = ROOT / "static" / "1-0-exe" / "routines.tsv"
UNPACKED_HEADER = 10752  # static/1-0-exe/README.md


def ghidra_home() -> Path | None:
    p = Path(os.environ.get("GHIDRA_HOME", str(Path.home() / "tools" / "ghidra_12.1.4_PUBLIC")))
    return p if (p / "support" / "analyzeHeadless").exists() else None


def java_home() -> Path | None:
    if os.environ.get("JAVA_HOME"):
        p = Path(os.environ["JAVA_HOME"])
        return p if (p / "bin" / "java").exists() else None
    found = sorted(glob.glob(str(Path.home() / "tools" / "jdk-21*")))
    return Path(found[-1]) if found else None


def released_exe() -> Path | None:
    p = ROOT / ".cache" / "One-Nil96" / "1-0.EXE"
    return p if p.exists() else None


GHIDRA, JAVA, EXE = ghidra_home(), java_home(), released_exe()
SKIP_GHIDRA = (None if GHIDRA and JAVA and EXE else
               "needs Ghidra 12.1.4 (GHIDRA_HOME or ~/tools/ghidra_12.1.4_PUBLIC), a JDK 21 (JAVA_HOME "
               "or ~/tools/jdk-21*) and One-Nil 96's 1-0.EXE in .cache/One-Nil96/ (python3 tools/artifacts.py "
               "pull); CI has none of them")

PROBED = ["0AB9:1539", "0AB9:8354", "0AB9:00D6", "0AB9:0B53", "0AB9:0207", "1B55:311E", "26C9:0000"]


@unittest.skipIf(SKIP_GHIDRA, SKIP_GHIDRA or "")
class GhidraMappingTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.work = ghidra_work.new_work_dir("mapping-test")  # Ghidra rejects a dotted project path (#315)
        # tearDownClass does not run when this method fails; a class cleanup does
        cls.addClassCleanup(shutil.rmtree, cls.work, ignore_errors=True)
        exe = cls.work / "onil.exe"
        subprocess.run([sys.executable, str(ROOT / "tools" / "static" / "unlzexe.py"), str(EXE), str(exe)],
                       check=True, capture_output=True)
        cls.image = exe.read_bytes()
        (cls.work / "project").mkdir()
        env = dict(os.environ, JAVA_HOME=str(JAVA), TMPDIR=str(cls.work), TMP=str(cls.work), TEMP=str(cls.work))
        segmap, probe = cls.work / "segmap.tsv", cls.work / "probe.tsv"
        run = subprocess.run(
            [str(GHIDRA / "support" / "analyzeHeadless"), str(cls.work / "project"), "probe",
             "-import", str(exe), "-loader", "MzLoader", "-processor", "x86:LE:16:Real Mode",
             "-scriptPath", str(ROOT / "tools" / "static" / "ghidra"),
             "-preScript", "OnilSetup.java", str(ROUTINES), str(segmap),
             "-postScript", "OnilProbe.java", str(segmap), str(probe), *PROBED,
             "-deleteProject", "-max-cpu", "2"],
            env=env, capture_output=True, text=True, timeout=1200)
        if not probe.exists():
            raise RuntimeError("Ghidra probe failed:\n" + run.stdout[-3000:] + run.stderr[-3000:])
        cls.rows = {}
        for line in probe.read_text().splitlines():
            addr, ghidra, name, hexbytes, calls, data = line.split("\t")
            cls.rows[addr] = dict(ghidra=ghidra, name=name, bytes=hexbytes,
                                  calls=set(filter(None, calls.split(","))),
                                  data=set(filter(None, data.split(","))))

    def listing_bytes(self, addr: str, n: int = 8) -> str:
        seg, off = (int(x, 16) for x in addr.split(":"))
        at = UNPACKED_HEADER + seg * 16 + off
        return self.image[at:at + n].hex().upper()

    def test_known_routines_sit_at_their_listing_addresses(self):
        for addr in PROBED:
            with self.subTest(addr=addr):
                row = self.rows[addr]
                self.assertEqual(row["name"], "f_" + addr.replace(":", "_"), row)
                if addr != "26C9:0000":  # its first word is relocated (next test)
                    self.assertEqual(row["bytes"], self.listing_bytes(addr))

    def test_relocated_segment_words_hold_the_mapped_segment(self):
        # 26C9:0000 BA 64 28: mov dx, 2864 (relocated); Ghidra holds the data segment at E000
        self.assertEqual(self.listing_bytes("26C9:0000"), "BA64288EDA8C0616")
        self.assertEqual(self.rows["26C9:0000"]["bytes"], "BA00E08EDA8C0616")

    def test_near_call_with_a_wrapping_displacement_reaches_its_routine(self):
        # 0AB9:836D E8 66 7D: 0x8370 + 0x7D66 wraps to 0AB9:00D6 (seg_0AB9_*.asm)
        self.assertIn("f_0AB9_00D6", self.rows["0AB9:8354"]["calls"])

    def test_near_calls_across_a_linear_64k_line_reach_their_routines(self):
        # 0AB9:1539 (linear 0xC0C9..) calls 0AB9:577F (linear 0x1030F) and 0AB9:B6BD (0x1624D)
        calls = self.rows["0AB9:1539"]["calls"]
        self.assertTrue({"f_0AB9_13B8", "f_0AB9_1455", "f_0AB9_577F", "f_0AB9_B6BD"} <= calls, calls)
        # 1B55:311E (linear 0x1E66E..) calls 1B55:4F89 (0x204D9) and 1B55:4E0C (0x2035C)
        calls = self.rows["1B55:311E"]["calls"]
        self.assertTrue({"f_1B55_4F89", "f_1B55_4E0C"} <= calls, calls)

    def test_far_calls_follow_the_remapped_relocations(self):
        self.assertIn("f_26C9_0A12", self.rows["0AB9:0B53"]["calls"])  # 0B70 call far 26C9:0A12
        self.assertIn("f_232A_052F", self.rows["0AB9:0B53"]["calls"])  # 0BA9 call far 232A:052F
        calls = self.rows["0AB9:1539"]["calls"]
        self.assertTrue({"f_1B55_0E7A", "f_1B55_4F89", "f_1B55_4EBF"} <= calls, calls)
        self.assertIn("f_24BC_04FA", self.rows["1B55:311E"]["calls"])  # 3191 call far 24BC:04FA

    def test_ds_operands_land_in_the_data_segment(self):
        self.assertIn("DS:D0AC", self.rows["0AB9:0207"]["data"])  # mov al, byte ptr [0xd0ac]
        self.assertIn("DS:D0C0", self.rows["0AB9:0207"]["data"])  # les di, ptr [0xd0c0]
        self.assertIn("DS:0D18", self.rows["0AB9:1539"]["data"])  # cmp byte ptr [0xd18], 0
        self.assertIn("DS:A516", self.rows["26C9:0000"]["data"])  # mov word ptr [0xa516], es


def segmap() -> decompiled.SegMap:
    # listing segment, Ghidra segment, bytes held: as OnilSetup.java writes for 1-0.EXE (made up)
    return decompiled.SegMap([(0x0000, 0x0000, 0x60), (0x01EF, 0x2000, 0xF450), (0x1B55, 0x6000, 0x2110),
                              (0x2864, 0xE000, 0xFB80)])


class RewriteTests(unittest.TestCase):
    def test_data_segment_names_become_ds_offsets(self):
        self.assertEqual(decompiled.rewrite("if (DAT_e000_9a3e == 0) x = &_DAT_e000_82ee;", segmap()),
                         "if (DS:9A3E == 0) x = &DS:82EE;")

    def test_code_labels_get_listing_numbering(self):
        self.assertEqual(decompiled.rewrite("goto LAB_2000_4796; y = DAT_6000_0010;", segmap()),
                         "goto LAB_01EF_4796; y = DAT_1B55_0010;")

    def test_memory_outside_the_program_is_physical(self):
        # 0040:0049 (BIOS video mode) is linear 0x449, past segment 0000's 0x60 bytes
        self.assertEqual(decompiled.rewrite("m = DAT_0000_0449;", segmap()), "m = ABS_00449;")
        # and so is a Ghidra segment that holds no listing segment
        self.assertEqual(decompiled.rewrite("m = DAT_c000_0001;", segmap()), "m = ABS_C0001;")

    def test_linear_addresses_get_listing_numbering(self):
        self.assertEqual(decompiled.rewrite("/* block (ram,0x00061dce) */ func_0x000287f7(); "
                                            "goto code_r0x00020711;", segmap()),
                         "/* block (1B55:1DCE) */ func_01EF_87F7(); goto code_r_01EF_0711;")

    def test_other_text_is_left_alone(self):
        text = "x = CONCAT22(register0x00000010,in_CX) + 0xb000; f_01EF_97D0(); PTR_c000_0001;"
        self.assertEqual(decompiled.rewrite(text, segmap()), text)


class RenderTests(unittest.TestCase):
    RAW = ("@@FUNC 2000:97d0 f_01EF_97D0 __stdcall16near ok\n\nvoid f_01EF_97D0(void)\n{\n"
           "  DAT_e000_9a3e = 0;\n}\n\n"
           "@@FUNC 6000:05f0 f_1B55_05F0 __stdcall16far failed Exception: out of bounds\n"
           "@@FUNC 6000:1000 f_1B55_1000 __cdecl16far ok\nvoid f_1B55_1000(void)\n{\n}\n")

    def test_files_index_and_failures(self):
        functions = decompiled.parse_raw(self.RAW)
        files, rows = decompiled.render(functions, ["01EF:97D0", "1B55:05F0", "1B55:0688"], segmap())
        self.assertEqual(sorted(files), ["seg_01EF_01.c", "seg_1B55_01.c"])
        by = {r[0]: r for r in rows}
        self.assertEqual(by["01EF:97D0"][1:4], ["decompiled", "seg_01EF_01.c", by["01EF:97D0"][3]])
        line = int(by["01EF:97D0"][3])
        self.assertTrue(files["seg_01EF_01.c"].splitlines()[line - 1].startswith("// ---- 01EF:97D0  "))
        self.assertIn("  DS:9A3E = 0;", files["seg_01EF_01.c"])
        self.assertEqual(by["1B55:05F0"][1], "failed")
        self.assertEqual(by["1B55:05F0"][6], "Exception: out of bounds")
        self.assertEqual(by["1B55:0688"][1], "missing")
        self.assertEqual(by["1B55:1000"][5], "ghidra")

    def test_a_segment_splits_into_parts_under_the_size_limit(self):
        body = "  x = 1;\n" * 3000  # about 27 KB per function
        raw = "".join(f"@@FUNC 2000:{o:04x} f_01EF_{o:04X} __cdecl16near ok\nvoid f(void)\n{{\n{body}}}\n"
                      for o in (0x10, 0x20, 0x30))
        files, rows = decompiled.render(decompiled.parse_raw(raw), [], segmap())
        self.assertEqual(sorted(files), ["seg_01EF_01.c", "seg_01EF_02.c", "seg_01EF_03.c"])
        self.assertTrue(all(len(t.encode()) <= decompiled.MAX_FILE_BYTES for t in files.values()))


def brace_block(text: str, open_idx: int) -> str:
    """The {...} block of text that opens at open_idx, braces included.

    OnilDecompile.java keeps braces out of its string literals and comments, so counting
    them is enough to find a block's end.
    """
    depth = 0
    for i in range(open_idx, len(text)):
        if text[i] == "{":
            depth += 1
        elif text[i] == "}":
            depth -= 1
            if depth == 0:
                return text[open_idx:i + 1]
    raise AssertionError(f"no closing brace for the block opening at {open_idx}")


class RetryConditionTests(unittest.TestCase):
    """OnilDecompile.java retries only a dead decompiler process (goal2's PR #54 review, round 2).

    The test reads tools/static/ghidra/OnilDecompile.java and checks the retry loop: after a
    failed attempt it must break out of the loop unless the result's error message says the
    decompiler process died, so any other unsuccessful result is written as a failure at
    once and only a dead process gets a fresh decompiler and another attempt.
    """

    @classmethod
    def setUpClass(cls):
        cls.source = (ROOT / "tools" / "static" / "ghidra" / "OnilDecompile.java").read_text()

    def retry_loop(self) -> str:
        at = self.source.index("for (int attempt")
        return brace_block(self.source, self.source.index("{", at))

    def test_retry_happens_only_when_the_error_message_says_the_process_died(self):
        loop = self.retry_loop()
        # a null result is logged as "no result", a message no retry condition can match
        self.assertIn('r == null ? "no result"', loop)
        # the guard: a failure whose message does not say "process died" leaves the loop
        died = loop.index('msg.contains("process died")')
        cond_at = loop.rindex("if (", 0, died)
        cond = loop[cond_at:loop.index("{", cond_at)]
        self.assertEqual(re.sub(r"\s+", " ", cond).strip(),
                         'if (msg == null || !msg.contains("process died"))')
        self.assertEqual(re.sub(r"\s+", " ", brace_block(loop, loop.index("{", cond_at))),
                         "{ break; }")
        # the fresh decompiler is opened only after that guard, and nowhere else in the loop
        self.assertEqual(loop.count("openDecompiler()"), 1)
        self.assertGreater(loop.index("openDecompiler()"), died)

    def test_any_other_unsuccessful_result_is_written_as_a_failure_at_once(self):
        loop = self.retry_loop()
        # a successful decompile leaves the loop before the guard is reached
        self.assertLess(loop.index("decompileCompleted"), loop.index('msg.contains("process died")'))
        at = self.source.index("for (int attempt")
        after = self.source[at + len(loop):]
        # the last attempt's result is written as ok or failed, with no further attempt
        written = after.index('head + " failed "')
        self.assertNotIn("decompileFunction", after[:written])


class CommittedOutputTests(unittest.TestCase):
    def setUp(self):
        if not (OUT / "index.tsv").exists():
            self.fail("static/1-0-exe/decompiled/index.tsv is missing")
        self.rows = [l.split("\t") for l in (OUT / "index.tsv").read_text().splitlines()[1:]]

    def test_index_covers_every_routine(self):
        routines = decompiled.read_routines(ROUTINES)
        indexed = {r[0] for r in self.rows if r[5] == "routines.tsv"}
        self.assertEqual(indexed, set(routines))
        self.assertEqual(len(routines), 940)
        for r in self.rows:
            self.assertIn(r[1], ("decompiled", "failed", "missing"))
            if r[1] != "decompiled":
                self.assertTrue(r[6], f"{r[0]} has no reason")

    def test_each_heading_is_at_its_indexed_line(self):
        lines = {}
        for r in self.rows:
            if r[1] == "decompiled":
                text = lines.setdefault(r[2], (OUT / r[2]).read_text().splitlines())
                self.assertTrue(text[int(r[3]) - 1].startswith(f"// ---- {r[0]}  f_{r[0].replace(':', '_')}  "),
                                r)

    def test_files_stay_under_the_size_limit(self):
        for p in OUT.glob("seg_*.c"):
            self.assertLessEqual(p.stat().st_size, decompiled.MAX_FILE_BYTES, p.name)


if __name__ == "__main__":
    unittest.main()
