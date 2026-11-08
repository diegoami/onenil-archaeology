#!/usr/bin/env python3
"""Extract narrowly requested numeric input facts from authenticated T75 states."""
import argparse
import hashlib
import json
import subprocess
from pathlib import Path
import halftime_editor_support as source
ROOT=source.ROOT
TOOL='runtime/driver/halftime_support_query.py'
sha=lambda b:hashlib.sha256(b).hexdigest()
def extract(record_path,scratch,queries):
 record=json.loads(record_path.read_text());source.validate_record(record)
 stages={s['name']:s for s in record['payload']['stages']};facts=[]
 if not queries or len(queries)>32:raise ValueError('bounded concrete queries required')
 for q in queries:
  if set(q)!={'stage','area','offset','width','consumer'} or q['stage'] not in stages or q['area'] not in ('ds','config') or q['width'] not in (8,16) or not isinstance(q['offset'],int) or not 0<=q['offset']<=65535-q['width']//8 or not source.re.fullmatch(r'[0-9A-F]{4}:[0-9A-F]{4}',q['consumer']):raise ValueError('invalid bounded input query')
  raw=(scratch/(q['stage']+'.sav')).read_bytes();row=stages[q['stage']]
  if sha(raw)!=row['savestate_sha256']:raise ValueError('private state does not match source observation')
  st=source.savestate.Savestate(raw);ds=st.program().ds_base
  base=ds
  if q['area']=='config':
   off=int.from_bytes(st.memory(ds+0xD7D2,2),'little');seg=int.from_bytes(st.memory(ds+0xD7D4,2),'little');base=off+16*seg
  address=base+q['offset'];value=int.from_bytes(st.memory(address,q['width']//8),'little')
  facts.append(dict(**q,address=address,value=value,savestate_sha256=row['savestate_sha256'],screen_sha256=row['screen_sha256']))
 return dict(schema='original-halftime-input-query/1',producer=source.git('rev-parse','HEAD').decode().strip(),tool_sha256=sha((ROOT/TOOL).read_bytes()),source=dict(path=str(record_path.relative_to(ROOT)),sha256=sha(record_path.read_bytes()),producer=record['producer']),facts=facts)
def main():
 p=argparse.ArgumentParser(description=__doc__);p.add_argument('--source',type=Path,required=True);p.add_argument('--scratch',type=Path,required=True);p.add_argument('--queries',type=Path,required=True);p.add_argument('--output',type=Path,required=True);a=p.parse_args()
 if a.output.exists() or source.git('status','--porcelain','--',TOOL).strip():raise ValueError('committed producer and new output required')
 out=extract(a.source.resolve(),a.scratch,json.loads(a.queries.read_text()))
 a.output.parent.mkdir(parents=True,exist_ok=True)
 with a.output.open('x') as f:json.dump(out,f,indent=2);f.write('\n')
 print('PASS extracted',len(out['facts']),'authenticated bounded input facts')
if __name__=='__main__':main()
