#!/bin/sh
# Decompile One-Nil 96's 1-0.EXE with Ghidra into pseudo-C per routine (T02).
# Ported from goal2-archaeology tools/static/decompile.sh at 774473eb, without its annotated (named) form.
#
#   bash tools/static/decompile.sh <packed 1-0.EXE> <output directory>
#   e.g. bash tools/static/decompile.sh .cache/One-Nil96/1-0.EXE static/1-0-exe/decompiled
#
# Unpacks 1-0.EXE with tools/static/unlzexe.py and checks the unpacked sha256, imports it with
# Ghidra's MZ loader (x86 real mode) in a throw-away project, places each listing segment at a
# 64K-aligned Ghidra segment and makes one function per routine of static/1-0-exe/routines.tsv
# (tools/static/ghidra/OnilSetup.java), runs Ghidra's default auto-analysis, decompiles every
# function (tools/static/ghidra/OnilDecompile.java) and writes the files of
# static/1-0-exe/decompiled/ into the output directory (tools/static/decompiled.py), byte for byte.
#
# Needs Ghidra 12.1.4 (GHIDRA_HOME, else ~/tools/ghidra_12.1.4_PUBLIC) and a JDK 21 (JAVA_HOME, else
# ~/tools/jdk-21*), python3 >= 3.11. One Ghidra instance,
# two CPUs (the machine is shared). KEEP_WORK=1 keeps the work directory (Ghidra's log, raw output).
# The work directory is $HOME/onenil-ghidra-work/decompile-<random> (ONENIL_GHIDRA_WORK moves the base), removed at the end.
set -eu
if [ $# -ne 2 ]; then
  echo "usage: $0 <packed 1-0.EXE> <output directory>" >&2
  exit 2
fi
exe=$1
out=$2
root=$(cd "$(dirname "$0")/../.." && pwd)
crash_reports=$(find "$root" -type f -name 'hs_err_pid*.log' -print)
if [ -n "$crash_reports" ]; then
  echo "decompile.sh: refusing to run while JVM crash reports remain in the worktree:" >&2
  printf '%s\n' "$crash_reports" >&2
  echo "Review the reports before retrying; report JVM crashes to Adoptium: https://github.com/adoptium/adoptium-support/issues" >&2
  exit 1
fi

GHIDRA_VERSION=12.1.4
JDK_MAJOR=21
UNPACKED_SHA256=887ed2a92767950e5309b2052409f875668605939b69e00737aa3047022b9f51
TIMEOUT_PER_FUNCTION=600

# the installs live under ~/tools unless GHIDRA_HOME / JAVA_HOME say otherwise
GHIDRA_HOME=${GHIDRA_HOME:-$HOME/tools/ghidra_${GHIDRA_VERSION}_PUBLIC}
if [ -z "${JAVA_HOME:-}" ]; then
  JAVA_HOME=$(ls -d "$HOME"/tools/jdk-"$JDK_MAJOR"* 2>/dev/null | sort | tail -1)
fi
if [ ! -x "$GHIDRA_HOME/support/analyzeHeadless" ] || [ ! -x "${JAVA_HOME:-/nonexistent}/bin/java" ]; then
  echo "decompile.sh: set GHIDRA_HOME to Ghidra $GHIDRA_VERSION and JAVA_HOME to a JDK $JDK_MAJOR" >&2
  exit 1
fi
props="$GHIDRA_HOME/Ghidra/application.properties"
ghidra_version=$(sed -n 's/^application.version=//p' "$props")
ghidra_revision=$(sed -n 's/^application.revision.ghidra=//p' "$props")
if [ "$ghidra_version" != "$GHIDRA_VERSION" ]; then
  echo "decompile.sh: Ghidra $GHIDRA_VERSION needed, $GHIDRA_HOME is '$ghidra_version'" >&2
  exit 1
fi
java_version=$("$JAVA_HOME/bin/java" -version 2>&1 | sed -n '1s/.*version "\([^"]*\)".*/\1/p')
case "$java_version" in
  "$JDK_MAJOR".*|"$JDK_MAJOR") ;;
  *) echo "decompile.sh: JDK $JDK_MAJOR needed, $JAVA_HOME is '$java_version'" >&2; exit 1 ;;
esac
export JAVA_HOME

# Ghidra rejects a project path with an element starting with '.', and worktrees may be under
# <repo>/.claude/: the work directory is in a dot-free folder whatever TMPDIR and the
# repository's path are (tools/static/ghidra_work.py), and Ghidra's temporary files go there too.
work=$(python3 "$root/tools/static/ghidra_work.py" new decompile)
export TMPDIR="$work" TMP="$work" TEMP="$work"
# removed on any exit from here on, an early failure included, unless KEEP_WORK=1
if [ "${KEEP_WORK:-0}" = 1 ]; then
  echo "decompile.sh: work directory $work" >&2
else
  trap 'rm -rf "$work"' EXIT
fi

python3 "$root/tools/static/unlzexe.py" "$exe" "$work/onil.exe" > /dev/null
sha=$(sha256sum "$work/onil.exe" | cut -d' ' -f1)
if [ "$sha" != "$UNPACKED_SHA256" ]; then
  echo "decompile.sh: unpacked sha256 $sha, expected $UNPACKED_SHA256" >&2
  exit 1
fi

mkdir "$work/project"
if ! "$GHIDRA_HOME/support/analyzeHeadless" "$work/project" onil \
    -import "$work/onil.exe" -loader MzLoader -processor 'x86:LE:16:Real Mode' \
    -scriptPath "$root/tools/static/ghidra" \
    -preScript OnilSetup.java "$root/static/1-0-exe/routines.tsv" "$work/segmap.tsv" \
    -postScript OnilDecompile.java "$work/segmap.tsv" "$work/raw.txt" "$TIMEOUT_PER_FUNCTION" \
    -deleteProject -max-cpu 2 > "$work/ghidra.log" 2>&1 \
  || grep -q 'SCRIPT ERROR' "$work/ghidra.log" || [ ! -s "$work/raw.txt" ]; then
  tail -30 "$work/ghidra.log" >&2
  echo "decompile.sh: Ghidra failed (log above)" >&2
  exit 1
fi
# OnilDecompile.java retries (with a fresh decompiler) only after "process died" and only before the
# last attempt (ATTEMPTS = 3); any other failed attempt ends that function's tries.
grep 'ONILRETRY' "$work/ghidra.log" | sed -E -e 's/ \(GhidraScript\).*//' -e 't clear' -e ':clear' -e '/ONILRETRY .* attempt [12]: .*process died/ s/.*> ONILRETRY /decompile.sh: decompiler failed, retrying with a fresh one: /' -e 't' -e 's/.*> ONILRETRY /decompile.sh: decompiler failed, not retrying: /' >&2 || true
grep -E 'ONILSETUP|ONILDECOMPILE' "$work/ghidra.log" | sed 's/.*> //; s/ (GhidraScript).*//' > "$work/summary.txt"

python3 "$root/tools/static/decompiled.py" \
  --raw "$work/raw.txt" --segmap "$work/segmap.tsv" --summary "$work/summary.txt" \
  --routines "$root/static/1-0-exe/routines.tsv" \
  --ghidra "$ghidra_version (revision $ghidra_revision)" --jdk "$java_version" \
  --out "$out"
