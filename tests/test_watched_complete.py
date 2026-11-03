"""Structural reference continuity checks;synthetic records are not original match evidence."""
import copy,sys
from pathlib import Path
import pytest
sys.path.insert(0,str(Path(__file__).resolve().parents[1]/'runtime/emul'))
import watched_complete as full

def sample():
 state={'seed':2,'elapsed':1,'remaining':90,'quick':0,'scores':[0,0],'phase':45,'active':1,'hold':0,'actor':1,'secondary':0,'stoppage':0,'ball':{**{f'word{k}':0 for k in (0,2,4,7,9,11)},**{f'byte{k}':0 for k in (6,13,14)}},'scenes':[{'index':i,**{f'word{k}':(i if k==14 else 0)for k in (0,2,4,8,10,14,16,20)},**{f'byte{k}':0 for k in (6,7,12,13,18,19,22,23,24)}}for i in range(1,23)]}
 return {'index':0,'draw_start':0,'draw_end':1,'tick_start':1,'tick_end':1,'action_start':0,'action_end':0,'draws':[{'kind':'draw','i':0,'n':2,'seed_before':1,'seed_after':2,'value':1,'callers':[]}],'ticks':[{'tick':1,'draw_start':1,'draw_end':1,'before':state,'after':copy.deepcopy(state)}],'actions':[]}

def test_valid_chunk_and_seed_context():
 value=full.validate_chunk(sample());assert value=={'index':1,'draw':1,'tick':2,'action':0,'seed':2}

def test_indices_seed_and_tick_mutations_reject():
 for mutate in [lambda c:c.update(draw_end=2),lambda c:c['draws'][0].update(i=1),lambda c:c['ticks'][0].update(tick=2),lambda c:c['ticks'][0]['after'].update(seed=3),lambda c:c['ticks'][0]['before'].update(quick=1)]:
  c=sample();mutate(c)
  with pytest.raises(ValueError):full.validate_chunk(c)

def test_chunk_boundaries_and_seed_continuity_reject():
 previous={'index':0,'draw':0,'tick':1,'action':0,'seed':99}
 with pytest.raises(ValueError):full.validate_chunk(sample(),previous)

def test_non_action_queue_and_extra_fields_reject():
 c=sample();c['unexpected']=1
 with pytest.raises(ValueError):full.validate_chunk(c)

def test_valid_next_chunk_and_cross_chunk_seed():
 previous=full.validate_chunk(sample());c=sample();c.update(index=1,draw_start=1,draw_end=1,tick_start=2,tick_end=2,draws=[]);c['ticks'][0].update(tick=2)
 assert full.validate_chunk(c,previous)['tick']==3
 previous['seed']=99
 with pytest.raises(ValueError):full.validate_chunk(c,previous)

def test_incomplete_termination_rejected():
 with pytest.raises(ValueError):full.validate_finish(sample()['ticks'][0]['after'],[])
