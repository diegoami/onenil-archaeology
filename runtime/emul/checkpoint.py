"""Append-only trace journal and private machine checkpoints (#58).

Only decoded event chunks and run receipts belong in git. Machine images (including
Unicorn's picklable CPU context) stay in .cache and the owner's private Drive.
"""
import gzip
import hashlib
import json
import os
import pickle
import shutil
from pathlib import Path

import guest


def digest(path):
    with open(path, "rb") as f:
        return hashlib.file_digest(f, "sha256").hexdigest()


class Journal:
    """List-like event sink, flushed after every event; published chunks never change."""
    def __init__(self, path, chunks=()):
        self.path = Path(path)
        self.path.parent.mkdir(parents=True, exist_ok=True)
        self.f = self.path.open("xb")
        for chunk in chunks:
            with open(chunk, "rb") as src:
                shutil.copyfileobj(src, self.f)
        self.f.flush()
        self.published = self.f.tell()

    def append(self, event):
        self.f.write((json.dumps(event, ensure_ascii=False, sort_keys=True) + "\n").encode())
        self.f.flush()

    def __iter__(self):
        self.f.flush()
        with self.path.open("rb") as src:
            for line in src:
                yield json.loads(line)

    def chunk(self, path):
        """Publish only events since the previous checkpoint, including a durable flush."""
        self.f.flush()
        os.fsync(self.f.fileno())
        end = self.f.tell()
        path = Path(path)
        path.parent.mkdir(parents=True, exist_ok=True)
        with self.path.open("rb") as src, path.open("xb") as dst:
            src.seek(self.published)
            shutil.copyfileobj(src, dst)
            dst.flush()
            os.fsync(dst.fileno())
        self.published = end
        return {"sha256": digest(path), "size": end}

    def finish(self, path):
        self.f.flush()
        with self.path.open("rb") as src, Path(path).open("xb") as dst:
            shutil.copyfileobj(src, dst)
            dst.flush()
            os.fsync(dst.fileno())
        return digest(path)

    def close(self):
        self.f.close()


def capture(week):
    """Call only between Guest.run calls, after the screen's action has been queued."""
    g = week.g
    if g.error is not None:
        raise ValueError("cannot checkpoint a guest with a pending error")
    return {"guest": {k: v for k, v in vars(g).items() if k != "mu"},
            "cpu": g.mu.context_save(), "memory": g.mem(0, 0x110000),
            "week": {k: v for k, v in vars(week).items() if k not in ("g", "events")}}


def restore(state, week_type, events):
    """Reinstall hooks on a fresh Unicorn instance, then restore its complete CPU context."""
    fields = state["guest"]
    g = guest.Guest(memory=state["memory"], load=fields["load"])
    vars(g).update(fields)
    g.mu.context_restore(state["cpu"])
    week = week_type.__new__(week_type)
    vars(week).update(state["week"])
    week.g, week.events = g, events
    week.install_hooks()
    return week


def write_private(path, state):
    path = Path(path)
    path.parent.mkdir(parents=True, exist_ok=True)
    with path.open("xb") as raw:
        with gzip.GzipFile(fileobj=raw, mode="wb", mtime=0) as dst:
            pickle.dump(state, dst, protocol=pickle.HIGHEST_PROTOCOL)
        raw.flush()
        os.fsync(raw.fileno())
    return digest(path)


def read_private(path):
    # Only load checkpoints created locally or fetched from the owner's private Drive.
    with gzip.open(path, "rb") as src:
        return pickle.load(src)
