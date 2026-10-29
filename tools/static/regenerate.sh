#!/bin/sh
# Rebuild everything under static/ from the owner's files in .cache/, byte for byte:
#   static/1-0-exe/    the listing of the unpacked 1-0.EXE (One-Nil 96, the target)
#   static/1-095-exe/  the listing of the unpacked 1-095.EXE (One-Nil 95)
#   static/delta-95-96.tsv  the 95 -> 96 delta by routine (tools/static/delta.py)
#   static/*/index.tsv  the area index from static/areas.tsv (tools/static/index.py)
# Needs python3 >= 3.11 with requirements.txt (capstone pinned) and the files pulled by
# `python3 tools/artifacts.py pull`. Run from anywhere; then `git diff --exit-code static/` must be clean.
set -eu
root=$(cd "$(dirname "$0")/../.." && pwd)
cd "$root"
python3 tools/static/listing.py .cache/One-Nil96/1-0.EXE static/1-0-exe
python3 tools/static/listing.py .cache/One-Nil95/1-095.EXE static/1-095-exe
python3 tools/static/delta.py .cache/One-Nil95/1-095.EXE .cache/One-Nil96/1-0.EXE static/delta-95-96.tsv
python3 tools/static/index.py
