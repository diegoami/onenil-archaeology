"""One-Nil's text screens, read from a savestate's text page (T04): the highlighted menu item, and
closed-loop menu navigation. A menu's selected item is drawn with attribute 0x70 (black on light
grey), the other items without it (seen on the main menu of SAVE1, T04)."""
import time

HIGHLIGHT = 0x70
COLS = 80


def highlighted(screen):
    """[(row, text)] of the rows holding a run of at least 4 cells with attribute 0x70, the text of that run."""
    out = []
    for r in range(25):
        attrs = screen.attrs[r * COLS:(r + 1) * COLS]
        cols = [c for c in range(COLS) if attrs[c] == HIGHLIGHT]
        if len(cols) >= 4:
            line = screen.lines()[r]
            text = line[cols[0]:cols[-1] + 1].strip()
            if sum(ch.isalpha() for ch in text) >= 3:  # a menu item, not a bar of 0x70 cells
                out.append((r, text))
    return out


def select(driver, label, key="Down", tries=40, pause=0.3):
    """Press `key` until the highlighted item starts with `label` (case-insensitive); returns the screen.
    Closed loop: a key the game drops is pressed again. RuntimeError after `tries` presses."""
    for _ in range(tries):
        sc = driver.screen()
        if any(t.lower().startswith(label.lower()) for _, t in highlighted(sc)):
            driver.log(f"menu: {label!r} highlighted")
            return sc
        driver.keys(key)
        time.sleep(pause)  # let the menu redraw before the next read; logged by keys()
    raise RuntimeError(f"menu item {label!r} not highlighted after {tries} presses of {key}")
