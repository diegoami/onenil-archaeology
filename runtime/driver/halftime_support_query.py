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
  if set(q)!={'stage','area','offset','width','consumer'} or q['stage'] not in stages or q['area'] not in ('ds','config','club') or q['width'] not in (8,16) or not isinstance(q['offset'],int) or not 0<=q['offset']<=65536-q['width']//8 or not source.re.fullmatch(r'[0-9A-F]{4}:[0-9A-F]{4}',q['consumer']):raise ValueError('invalid bounded input query')
  raw=(scratch/(q['stage']+'.sav')).read_bytes();row=stages[q['stage']]
  if sha(raw)!=row['savestate_sha256']:raise ValueError('private state does not match source observation')
  st=source.savestate.Savestate(raw);ds=st.program().ds_base
  base=ds
  pointer={}
  if q['area'] in ('config','club'):
   slot=0xD7D2 if q['area']=='config' else 0xD7C2
   off=int.from_bytes(st.memory(ds+slot,2),'little');seg=int.from_bytes(st.memory(ds+slot+2,2),'little');base=off+16*seg
   if q['area']=='club':pointer=dict(pointer_slot=slot,pointer_offset=off,pointer_segment=seg)
  address=base+q['offset'];value=int.from_bytes(st.memory(address,q['width']//8),'little')
  facts.append(dict(**q,**pointer,address=address,value=value,savestate_sha256=row['savestate_sha256'],screen_sha256=row['screen_sha256']))
 return dict(schema='original-halftime-input-query/1',producer=source.git('rev-parse','HEAD').decode().strip(),tool_sha256=sha((ROOT/TOOL).read_bytes()),source=dict(path=str(record_path.relative_to(ROOT)),sha256=sha(record_path.read_bytes()),producer=record['producer']),facts=facts)
def validate(packet):
 if packet['schema']!='original-halftime-input-query/1' or sha(source.git('show',packet['producer']+':'+TOOL))!=packet['tool_sha256']:raise ValueError('query producer differs')
 path=ROOT/packet['source']['path']
 if sha(path.read_bytes())!=packet['source']['sha256']:raise ValueError('query source digest differs')
 record=json.loads(path.read_text());source.validate_record(record)
 if packet['source']['producer']!=record['producer']:raise ValueError('query source producer differs')
 stages={s['name']:s for s in record['payload']['stages']}
 if not packet['facts'] or len(packet['facts'])>32:raise ValueError('query census differs')
 for f in packet['facts']:
  row=stages[f['stage']]
  if f['width'] not in (8,16) or not 0<=f['value']<(1<<f['width']) or f['area'] not in ('ds','config','club') or not 0<=f['offset']<=65536-f['width']//8 or not source.re.fullmatch(r'[0-9A-F]{4}:[0-9A-F]{4}',f['consumer']):raise ValueError('query field differs')
  if f['savestate_sha256']!=row['savestate_sha256'] or f['screen_sha256']!=row['screen_sha256']:raise ValueError('query stage binding differs')
  base=row['support']['ds_base'] if f['area']=='ds' else row['support']['address']-4
  if f['area']=='club':
   if f['pointer_slot']!=0xD7C2 or not all(isinstance(f[k],int) and 0<=f[k]<=65535 for k in ('pointer_offset','pointer_segment')):raise ValueError('club query pointer differs')
   base=f['pointer_offset']+16*f['pointer_segment']
  if f['address']!=base+f['offset']:raise ValueError('query field address differs')
  if (f['area'],f['offset'],f['width'])==('config',4,8) and (f['value']!=row['support']['value'] or f['consumer']!='0AB9:D1F1'):raise ValueError('query selected-team alias differs')
 return packet['facts']

def main():
 p=argparse.ArgumentParser(description=__doc__);p.add_argument('--source',type=Path,required=True);p.add_argument('--scratch',type=Path,required=True);p.add_argument('--queries',type=Path,required=True);p.add_argument('--output',type=Path,required=True);a=p.parse_args()
 if a.output.exists() or source.git('status','--porcelain','--',TOOL).strip():raise ValueError('committed producer and new output required')
 out=extract(a.source.resolve(),a.scratch,json.loads(a.queries.read_text()))
 a.output.parent.mkdir(parents=True,exist_ok=True)
 with a.output.open('x') as f:json.dump(out,f,indent=2);f.write('\n')
 print('PASS extracted',len(out['facts']),'authenticated bounded input facts')
if __name__=='__main__':main()
