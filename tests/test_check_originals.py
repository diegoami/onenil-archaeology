"""#221: the original-byte check also refuses any tracked private-cache path."""
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT/'tools'))
import check_originals as check  # noqa: E402


def test_the_repository_itself_is_clean():
    assert check.main() == 0


def test_a_tracked_cache_symlink_is_a_violation():
    # `.gitignore`'s `.cache/` matches a directory, not a symlink of that name;
    # one `git add -A` committed exactly this and destroyed the artifact cache.
    assert check.violations(['.cache']) == ([], ['.cache'])
    assert check.violations(['.cache/venv/bin/python']) == ([], ['.cache/venv/bin/python'])


def test_ordinary_paths_and_original_types():
    assert check.violations(['runs/T93/finish.json', 'docs/tasks/T99.md']) == ([], [])
    originals, cache = check.violations(['.cache/One-Nil96/1-0.EXE', 'records/T51/font.sav'])
    assert originals == ['.cache/One-Nil96/1-0.EXE', 'records/T51/font.sav'] and cache == [
        '.cache/One-Nil96/1-0.EXE']
