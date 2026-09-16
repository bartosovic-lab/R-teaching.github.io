"""Verify final teaching CSVs against archived raw sources without changing data."""
from pathlib import Path
import csv, hashlib, re, math, importlib.util, json
import xlrd
root=Path(__file__).resolve().parents[1]
def rows(p):
 with p.open(newline='') as h:return list(csv.DictReader(h))
def eq(a,b):
 if a=='NA':assert b in ('',None)
 else:assert math.isclose(float(a),float(b),rel_tol=1e-12,abs_tol=1e-12)
m=root/'instructor/source/mouse'
w=m/'Data_Cortex_Nuclear.xls'
expected=re.search(r'SHA-256: ([a-f0-9]{64})',(m/'PROVENANCE.md').read_text()).group(1)
assert hashlib.sha256(w.read_bytes()).hexdigest()==expected
s=xlrd.open_workbook(w).sheet_by_index(0);names=s.row_values(0)
lookup={s.cell_value(i,0):dict(zip(names,s.row_values(i))) for i in range(1,s.nrows)}
core=rows(root/'data/study.csv');reps=rows(root/'data/replicates.csv')
assert len(core)==len({r['sample_id'] for r in core})==72
assert [sum(r['group']==g for r in core) for g in ['Saline','Memantine']]==[34,38]
assert len(reps)==1080 and len({r['sample_id'] for r in reps})==72
for r in core+reps:
 raw=lookup[r['source_record']]
 for f in ['BDNF','pCREB','NR1']:eq(r[f],raw[f+'_N'])
for r in core:
 assert r['source_record']==r['sample_id']+'_1'
 raw=lookup[r['source_record']]
 assert (r['group'],r['genotype'],r['learning'])==(raw['Treatment'],raw['Genotype'],raw['Behavior'])
for f in ['study.csv','replicates.csv']:
 assert (root/'data'/f).read_bytes()==(root/'tutorials/01_basics/data'/f).read_bytes()
assert (root/'course.json').read_bytes()==(root/'tutorials/01_basics/course.json').read_bytes()
# Read the preserved OASIS workbook with the original stdlib XLSX parser.
spec=importlib.util.spec_from_file_location('archived',root/'instructor/source/mmse_prepare.py')
mod=importlib.util.module_from_spec(spec);spec.loader.exec_module(mod)
source=root/'instructor/source/mmse'
original=mod.worksheet(source/'oasis_longitudinal_demographics.xlsx')
headers={''.join(filter(str.isalpha,k)):v for k,v in original[0].items()}
raw=[{headers[''.join(filter(str.isalpha,k))]:v for k,v in row.items()} for row in original[1:]]
legacy=rows(source/'alzheimer_data.csv'); byrow={r['']:r for r in legacy}
mmse=rows(root/'data/mmse_baseline.csv')
assert len(mmse)==len({r['Subject_ID'] for r in mmse})==136
expected_rows={r[''] for r in legacy if raw[int(r[''])-1]['Visit']=='1'}
assert {r['Source_row'] for r in mmse}==expected_rows
for r in mmse:
 old=byrow[r['Source_row']];oasis=raw[int(r['Source_row'])-1]
 assert r['Subject_ID']==oasis['Subject ID'] and r['Visit']==oasis['Visit']=='1'
 for k,v in old.items():
  if k=='':continue
  assert r[k]==v
  origin=oasis.get('M/F' if k=='M.F' else k,'NA')
  if k in {'eTIV','nWBV','ASF'}:assert abs(float(v)-float(origin))<={'eTIV':.50001,'nWBV':.00050001,'ASF':.00050001}[k]
  else:assert v==origin
assert [sum(r['Group']==g for r in mmse) for g in ['Nondemented','Demented']]==[72,64]
assert sum(r['SES']=='NA' for r in mmse)==8
print('PASS: raw mouse/replicate measurements, mouse IDs and counts, identical tutorial copies; OASIS IDs/first visits, all retained legacy values, rounding and missingness.')
