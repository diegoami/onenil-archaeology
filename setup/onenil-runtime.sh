#!/bin/sh
# Check what a run of One-Nil 96 needs (T04) and print `ready`, or what is missing.
#   bash setup/onenil-runtime.sh
# Needs: DOSBox-X 2024.03.01 (the driver refuses another version; bash setup/dosbox-x-2024.03.01.sh
# installs it under ~/tools without sudo), Xvfb, xdotool, python3 >= 3.11, and One-Nil 96's files in
# .cache/One-Nil96 matching records/T01/inventory.json (python3 tools/artifacts.py pull).
set -u
root=$(cd "$(dirname "$0")/.." && pwd)
missing=""
command -v Xvfb >/dev/null 2>&1 || missing="$missing Xvfb(apt: xvfb)"
command -v xdotool >/dev/null 2>&1 || missing="$missing xdotool(apt: xdotool)"
python3 -c 'import sys; sys.exit(sys.version_info < (3, 11))' 2>/dev/null || missing="$missing python3>=3.11"
v=$(cd "$root" && python3 -c 'import sys; sys.path.insert(0, "runtime/driver"); import driver; print(driver.dosbox_version_of(driver.dosbox_x()) or "none")' 2>/dev/null)
[ "$v" = "2024.03.01" ] || missing="$missing dosbox-x-2024.03.01(found:${v:-none};bash setup/dosbox-x-2024.03.01.sh)"
(cd "$root" && python3 -c 'import sys; sys.path.insert(0, "runtime/driver"); import driver; driver.verify_release(driver.CACHE)') >/dev/null 2>&1 \
  || missing="$missing One-Nil96-files(python3 tools/artifacts.py pull)"
if [ -n "$missing" ]; then
  echo "missing:$missing"
  exit 1
fi
echo ready
