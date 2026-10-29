import os
import sys
import unittest

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
sys.path.insert(0, os.path.join(ROOT, "tools", "static"))

import ratings  # noqa: E402


def player(**kw):
    p = {"mode": 0, "p8_4": 150, "p8_7": 1, "p15_6": 5, "p15_8": 10, "unavailable": 0, "halved": 0}
    p.update(kw)
    return p


class RatingTests(unittest.TestCase):
    def test_player_value_branches(self):
        self.assertEqual(ratings.player_value(player()), 150 - 62 + 10 + 5)
        self.assertEqual(ratings.player_value(player(p15_6=40)), 98)                  # neither branch
        self.assertEqual(ratings.player_value(player(p15_6=40, p8_7=0)), 98 + 16)
        self.assertEqual(ratings.player_value(player(p15_6=40, p8_7=0, mode=1)), 98 - 98 // 16)
        self.assertEqual(ratings.player_value(player(p8_4=10, p15_8=-30)), 0)       # clamped at 0
        self.assertEqual(ratings.player_value(player(p8_4=255, p15_8=100)), 256)    # clamped at 256
        self.assertEqual(ratings.player_value(player(halved=1)), (150 - 62 + 10 + 5) // 2)
        self.assertEqual(ratings.player_value(player(unavailable=1)), 0)

    def test_signed_division_truncates_towards_zero(self):
        self.assertEqual(ratings.player_value(player(p8_4=40, p15_8=0, p15_6=40, p8_7=0, mode=1)), 0)
        # v = -22: -22 - (-22 / 16 = -1) = -21, then clamped to 0

    def test_club_bonus(self):
        self.assertEqual(ratings.club_bonus({"staff_a": 0xE0, "staff_b": 0xF0}), (0xE0 >> 5) + 16 + (0xF0 >> 4))

    def test_side_values_split_and_flag(self):
        side = {"flag": 1, "club_37": 5, "bonus": 10,
                "players": [{"position": 0, "value": 100}, {"position": 3, "value": 50},
                            {"position": 12, "value": 0}, {"position": 9, "value": 30}]}
        v = [110, 30, 30 + 20, 20]
        self.assertEqual(ratings.side_values(side), [w + w // 16 for w in v])
        side["club_37"] = 0
        self.assertEqual(ratings.side_values(side), [w + w // 64 for w in v])
        side["flag"] = 0
        self.assertEqual(ratings.side_values(side), v)


if __name__ == "__main__":
    unittest.main()
