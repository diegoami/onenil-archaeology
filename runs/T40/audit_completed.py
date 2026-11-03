"""[derived] Audit completed decoded reference;interpret legacy score bytes correctly.
Does not execute original code or infer per-tick cumulative counters from scratch bytes.
"""
import collections,hashlib,json,sys
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT/'runtime/emul'))
import watched_complete as full

def main():
    index=full.check();actions=[];ticks=[]
    for item in index['chunks']:
        payload=json.loads((ROOT/item['path']).read_text())['payload'];actions+=payload['actions'];ticks+=payload['ticks']
    finish=json.loads((ROOT/index['finish']['path']).read_text())
    goals=[{key:e[key]for key in ('event','code','side','club','player','minute','tick')}for e in actions if e['code']in(38,39)]
    counts=[sum(e['side']==side for e in goals)for side in(0,1)]
    final_pair=finish['final']['scores']
    # Original E008:E069-E06E swaps D0C4/D0C5 into D086/D087 at match cleanup.
    if final_pair!=counts[::-1]:raise ValueError('accepted goal counts do not join swapped final result bytes')
    print(json.dumps({'schema':'watched-complete-independent-audit/1','finish_sha256':hashlib.sha256((ROOT/index['finish']['path']).read_bytes()).hexdigest(),'original_boundary':finish['boundary'],'ticks':len(ticks),'draws':finish['draws'],'accepted_actions':len(actions),'elapsed':finish['final']['elapsed'],'remaining':finish['final']['remaining'],'stoppage':finish['final']['stoppage'],'goals':goals,'derived_goals_by_event_side':counts,'observed_final_D086_D087':final_pair,'goal_join':'accepted goal counts by side equal reversed final result bytes','halftime_fulltime':[{'code':e['code'],'minute':e['minute'],'tick':e['tick']}for e in actions if e['code']in(63,64)],'score_field_correction':{'issue':133,'legacy_field':'state.scores','actual_addresses':'DS:D086/DS:D087','live_cumulative_addresses':'DS:D0C4/DS:D0C5','limit':'Intermediate legacy scores are generated-goal scratch bytes,not cumulative score. No per-tick live counter observation is claimed. Final interpretation uses the original cleanup copy and independent accepted-goal tally.'},'static_evidence':['d9e20a4:0AB9:E251 initializes D0C4/D0C5','d9e20a4:0AB9:53D7 increments side counter and reverses disallowed goals','d9e20a4:0AB9:E069-E06E swaps final D0C4/D0C5 into D086/D087'],'scope':'Original watched reference and derived audit only;not a native match or viewer.'},indent=2))
if __name__=='__main__':main()
