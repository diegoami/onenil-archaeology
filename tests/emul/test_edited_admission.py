"""T69 public shape/source guards; synthetic tests are not original observations."""
import copy,importlib.util,json
from pathlib import Path
import pytest
ROOT=Path(__file__).resolve().parents[2]
spec=importlib.util.spec_from_file_location('edited_admission_test',ROOT/'runtime/emul/edited_admission.py');module=importlib.util.module_from_spec(spec);spec.loader.exec_module(module)

def witness():
 initial=module.initial_campaign();edited=module.expected_campaign()
 return dict(initial_campaign=initial,campaign=edited,ui=[dict(stage=stage,key=None if i==0 else module.UI_KEYS[i-1],selected_player=module.UI_SELECTED[i],put_here=i in (3,4),screen_sha256='a'*64,roster=(initial if i<5 else edited)['club']['first_team']) for i,stage in enumerate(module.UI_STAGES)])

@pytest.mark.parametrize('damage',['initial','swap','cash','fixture','role','key','selected','picked','roster','digest','missing'])
def test_edit_refuses_foreign_or_incomplete_witness(damage):
 good=witness();module.validate_edit(good);bad=copy.deepcopy(good)
 if damage=='initial':bad['initial_campaign']['cash']+=1
 elif damage=='swap':bad['campaign']['club']['first_team'][1:3]=[2582,2583]
 elif damage=='cash':bad['campaign']['cash']+=1
 elif damage=='fixture':bad['campaign']['next_fixture']['opponent']=134
 elif damage=='role':bad['campaign']['players'][1]['current_position']=1
 elif damage=='key':bad['ui'][2]['key']='Up'
 elif damage=='selected':bad['ui'][2]['selected_player']=2583
 elif damage=='picked':bad['ui'][3]['put_here']=False
 elif damage=='roster':bad['ui'][5]['roster'][0]=0
 elif damage=='digest':bad['ui'][3]['screen_sha256']='foreign'
 else:bad['ui'].pop()
 with pytest.raises(ValueError):module.validate_edit(bad)

def test_old_unchanged_capture_is_not_edited_evidence():
 old=json.loads((ROOT/'runs/T66/admission-r0001.json').read_text())
 with pytest.raises(ValueError):module.validate_record(old)

@pytest.mark.parametrize('damage',['source','ui','admission','entry','keys','digest'])
def test_public_original_record_joins(damage):
 path=ROOT/'runs/T69/admission-r0001.json'
 if not path.exists():pytest.skip('original edited capture not yet retained')
 original=json.loads(path.read_text());module.validate_record(original);bad=copy.deepcopy(original)
 if damage=='source':bad['source']['state_sha256']='0'*64
 elif damage=='ui':bad['payload']['ui'][2]['selected_player']=2583
 elif damage=='admission':bad['payload']['selected_admission']['clubs'][0]['roster'][0]=0
 elif damage=='entry':bad['payload']['first_entry']['seed']^=1
 elif damage=='keys':bad['keys_delivered'][0][0]='Return'
 else:bad['payload_sha256']='0'*64
 if damage not in ('source','keys','digest'):bad['payload_sha256']=module.sha(module.encoded(bad['payload']))
 with pytest.raises(ValueError):module.validate_record(bad)
