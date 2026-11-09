# Environment

What a session needs to run the original (T04, F04) and the static tools (T02).

- **Python** 3.11 or later; `pip install -r requirements.txt` (pytest, capstone 5.0.9) into a venv,
  e.g. `.cache/venv`.
- **The game files**: `python3 tools/artifacts.py pull` (docs/artifacts.md) into `.cache/`.
- **DOSBox-X 2024.03.01**, exactly: the driver refuses another version (its savestate layout is the
  one the screen reader is calibrated to, goal2's F001). Ubuntu 26.04's apt has only 2026.01.02;
  `bash setup/dosbox-x-2024.03.01.sh` unpacks Ubuntu 24.04's package into `~/tools/dosbox-x-2024.03.01`
  without sudo (shared with goal2-archaeology). `$DOSBOX_X` overrides the path.
- **Xvfb and xdotool** (apt), for the headless display and the window search; keys go as raw XTEST
  keycodes (`runtime/driver/xkeys.py`).
- **Ghidra 12.1.4 and a JDK 21** under `~/tools` (or `GHIDRA_HOME`, `JAVA_HOME`), only for
  `tools/static/decompile.sh`.

`bash setup/onenil-runtime.sh` checks the run's needs and prints `ready`.

## Restoring on a new machine

Verified 2026-11-09 on a fresh Ubuntu 24.04 host provisioned with only the
project's apt display set (Xvfb + fonts) and no sudo. Everything below lives
under the home directory, so it survives in place but is **host-local by
design** (process.md §4): repeat it per machine. The accepted evidence never
depends on any of it; records are in git.
1. **Check first**: `bash setup/onenil-runtime.sh` prints exactly what is
   missing. A provisioner that installs the apt display set still skips
   `xdotool` (it is not a dependency of xvfb) — `command -v xdotool` before
   anything else.
2. **Python venv**: `python3 -m venv .cache/venv` and
   `.cache/venv/bin/python -m pip install -r requirements.txt` (README).
3. **DOSBox-X**: `bash setup/dosbox-x-2024.03.01.sh`. On a bare 24.04 host the
   script's bundle (libFLAC only) is not enough — the 24.04 deb normally gets
   its other libraries from apt. Unpack the noble builds of these packages into
   `~/tools/dosbox-x-2024.03.01/lib/` and rerun the script until it prints
   `ready`; drive any remaining `ldd … | grep "not found"` sonames the same way:

   | soname | package (noble) | pool dir |
   | --- | --- | --- |
   | libminizip.so.1 | libminizip1 | universe/m/minizip |
   | libphysfs.so.1 | libphysfs1 | launchpad librarian (source `libphysfs`; purged from the pool) |
   | libogg.so.0 | libogg0 | main/libo/libogg |
   | libSDL2-2.0.so.0 | libsdl2-2.0-0 2.30.x | main/libs/libsdl2 (2.32+ moves the library into `libsdl2-classic`) |
   | libSDL2_net-2.0.so.0 | libsdl2-net-2.0-0 | universe/libs/libsdl2-net |
   | libpcap.so.0.8 | libpcap0.8t64 | main/libp/libpcap |
   | libslirp.so.0 | libslirp0 | main/libs/libslirp |
   | libfluidsynth.so.3 | libfluidsynth3 2.3.x | universe/f/fluidsynth |
   | libopusfile.so.0 | libopusfile0 | universe/o/opusfile |
   | libspeexdsp.so.1 | libspeexdsp1 1.2.1-1ubuntu3 | main/s/speexdsp |
   | libasyncns.so.0 | libasyncns0 | main/liba/libasyncns |
   | libinstpatch-1.0.so.2 | libinstpatch-1.0-2 | main/libi/libinstpatch (launchpad) |
   | libvorbis.so.0 / libvorbisenc.so.2 | libvorbis0a / libvorbisenc2 | main/libv/libvorbis |
   | libmp3lame.so.0 | libmp3lame0 3.100-6build1 | main/l/lame (newer builds need glibc 2.43) |
   | libmpg123.so.0 | libmpg123-0t64 | main/m/mpg123 |
   | libnl-3.so.200 / libnl-route-3.so.200 | libnl-3-200 / libnl-route-3-200 | main/libn/libnl3 |
   | libpulse.so.0 (+ libpulsecommon) | libpulse0 | main/p/pulseaudio |
   | libXss / libdecor / libibverbs / libsndfile / libjack / libpipewire / libopus | as above | via the SDL2/fluidsynth/sndfile dependencies |

   Stay on noble builds: newer-suite builds embed newer glibc symbol versions.
4. **xdotool without sudo** (if the provisioner skipped it): unpack the noble
   `xdotool` and `libxdo3` debs into `~/tools/xdotool` (`bin/xdotool.real`,
   `lib/`), write a `bin/xdotool` wrapper that adds `lib/` to
   `LD_LIBRARY_PATH` (the dosbox bundle pattern), and symlink it into
   `~/.local/bin`.
5. **Rust**: `curl https://sh.rustup.rs | sh -s -- -y --profile minimal`, plus
   `rustup component add rustfmt clippy` (the fmt gate). Each crate builds
   separately (no workspace): `cargo test --manifest-path campaign/Cargo.toml
   --locked`, likewise `engine/Cargo.toml` and `desktop/faithful/Cargo.toml`.
6. **Linker without sudo**: the rust gnu target needs a linker driver plus crt
   objects. Unpack the noble debs `gcc-13-x86-64-linux-gnu`,
   `cpp-13-x86-64-linux-gnu`, `libgcc-13-dev`, `libisl23` into `~/tools/gcc`
   (`libmpc3` only exists on the launchpad librarian), and `libc6-dev` into
   `~/tools/sysroot` (crt objects, `libc.so`/`libm.so` scripts, `usr/include`).
   In the sysroot also symlink the loader and runtime libraries
   (`lib64/ld-linux-x86-64.so.2`, `lib/x86_64-linux-gnu/libc.so.6` and friends,
   `usr/lib/x86_64-linux-gnu/libgcc_s.so.1`, `libmvec.so.1`). A
   `~/tools/gcc/bin/gcc` wrapper execs the unpacked driver with `--sysroot`,
   `-B` over its gcc lib directory (finds `cc1`, `collect2`,
   `liblto_plugin.so`), `-B` over the sysroot library directory (resolves the
   bare `Scrt1.o`/`crti.o`/`crtn.o` names rustc passes under
   `-nodefaultlibs`), and `-isystem` for the headers; symlink it as
   `~/.local/bin/gcc` and `cc`. Host-local `~/.cargo/config.toml` sets
   `linker` to the wrapper. `cc` build scripts then work without sudo.
7. **Static decompilation** (rare): Ghidra + JDK under `~/tools` as above.

The original runs themselves are the machine-independent part: the harness
records digests, decoded values and producer identities, and a fresh machine
reproduces them from the repositories and the private artifacts alone.

Running: `python3 runtime/driver/cycle.py --runs 10 --start-state title` (the cycle);
`python3 runtime/driver/weeks.py --weeks N` (load SAVE1.1-0 and play on). Both refuse to run with
uncommitted changes under `runtime/driver/`, so a record's `code_commit` names the code that ran.
Run them one at a time: they share the game folder `.cache/driver/game`. Savestates go to
`.cache/states/T04/` and to the owner's Drive (`rclone copy .cache/states/T04 onenildrive:states/T04`),
never to git. Never press F1 under the driver (goal2: the help viewer breaks every later savestate).
