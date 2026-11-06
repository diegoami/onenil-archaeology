import importlib.util
from pathlib import Path
import struct
import unittest
ROOT=Path(__file__).resolve().parents[2]
spec=importlib.util.spec_from_file_location('campaign_seed',ROOT/'tools/data/campaign_seed.py');seed=importlib.util.module_from_spec(spec);spec.loader.exec_module(seed)

def fixture():
    blocks={dest:bytearray(size) for dest,size in seed.save.BLOCKS}
    blocks['DS:DCDA'][:]=struct.pack('<H',1995);blocks['DS:DCBA'][0]=7
    game=blocks['[DS:D7D2]'];game[1]=1;game[3]=1;game[4]=1;struct.pack_into('<H',game,5,1)
    club=blocks['[DS:D7C2]'];struct.pack_into('<HH',club,6*62,1,2)
    for p in [1,2]:blocks['[DS:D7BA]'][p*8]=7
    names=blocks['[DS:DCCC]'];names[11]=7;names[12:19]=b'Manager'
    fixtures=blocks['[DS:D7CA]'];fixtures[6*174:6*174+3]=bytes([1,8,1]);fixtures[7*174:7*174+3]=bytes([1,7,2])
    return blocks,dict(year=1995,clubs=['Club']*176,players=['Player']*3920)
def joined(b):return b''.join(bytes(b[d]) for d,_ in seed.save.BLOCKS)
class CampaignSeedTests(unittest.TestCase):
    def test_projection_and_source_assumptions(self):
        b,t=fixture();p=seed.project(joined(b),t);self.assertEqual(p['club']['id'],7);self.assertEqual(p['season']['start_year'],1994)
        self.assertEqual(p['next_fixture']['opponent'],8);self.assertEqual([p['id'] for p in p['players']],[1,2])
    def test_bad_lengths_and_identity_relations(self):
        b,t=fixture()
        with self.assertRaises(seed.save.LayoutError):seed.project(joined(b)[:-1],t)
        for change in [lambda b:b['DS:DCBA'].__setitem__(0,0),lambda b:b['[DS:D7BA]'].__setitem__(8,8),lambda b:struct.pack_into('<H',b['[DS:D7C2]'],6*62+2,1),lambda b:b['[DS:D7CA]'].__setitem__(7*174+1,9)]:
            b,t=fixture();change(b)
            with self.assertRaises(ValueError):seed.project(joined(b),t)
        b,t=fixture();t['year']=1994
        with self.assertRaises(ValueError):seed.project(joined(b),t)
