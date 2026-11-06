import copy,importlib.util,unittest
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2]
spec=importlib.util.spec_from_file_location('campaign_admission',ROOT/'runtime/emul/campaign_admission.py');module=importlib.util.module_from_spec(spec);spec.loader.exec_module(module)
class CampaignAdmissionTests(unittest.TestCase):
 def test_initial_identity_is_exact(self):
  initial=module.expected_campaign();module.require_campaign(initial)
  for field in ['club','opponent','roster','cash']:
   bad=copy.deepcopy(initial)
   if field=='club':bad['club']['id']=134
   elif field=='opponent':bad['next_fixture']['opponent']=134
   elif field=='roster':bad['club']['first_team'][0]=0
   else:bad['cash']+=1
   with self.assertRaises(ValueError):module.require_campaign(bad)
 def test_wrong_or_incomplete_record_is_refused(self):
  for bad in [{},{'schema':'original-campaign-admission/1','status':'aborted'},{'schema':'other','status':'completed'}]:
   with self.assertRaises((KeyError,ValueError)):module.validate_record(bad)
if __name__=='__main__':unittest.main()
