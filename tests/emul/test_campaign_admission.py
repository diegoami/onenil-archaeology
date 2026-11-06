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

class PublicCaptureNegativeTests(unittest.TestCase):
 def test_wrong_source_and_fixture_aliases(self):
  import json
  original=json.loads((ROOT/'runs/T66/admission-r0001.json').read_text());module.validate_record(original)
  for field in ['state_sha256','save_sha256','league_sha256']:
   bad=copy.deepcopy(original);bad['source'][field]='0'*64
   with self.assertRaises(ValueError):module.validate_record(bad)
  bad=copy.deepcopy(original);bad['payload']['fixture_request']['club']=134;bad['payload_sha256']=module.sha(module.encoded(bad['payload']))
  with self.assertRaises(ValueError):module.validate_record(bad)

if __name__=='__main__':unittest.main()
