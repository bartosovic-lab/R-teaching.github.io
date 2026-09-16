"""Rebuild the teaching CSVs from preserved source workbooks; never change raw data.
Author-only requirements: xlrd (mouse) or openpyxl (chloride). Students need only R.
Run from the course project root: python3 scripts/prepare_data.py
"""
from pathlib import Path
import csv, json, hashlib, re, statistics, shutil

root = Path(__file__).resolve().parents[1]
cfg = json.loads((root / 'course.json').read_text())
raw = root / 'data/source'

def write(name, rows):
    with (root / 'data' / name).open('w', newline='') as f:
        out = csv.DictWriter(f, fieldnames=list(rows[0]), lineterminator="\n")
        out.writeheader()
        out.writerows(rows)

if cfg['variant'] == 'mouse':
    import xlrd
    s = xlrd.open_workbook(raw / 'Data_Cortex_Nuclear.xls').sheet_by_index(0)
    records = [dict(zip(s.row_values(0), s.row_values(i))) for i in range(1, s.nrows)]
    assert len(records) == 1080
    measurement_rows = [dict(sample_id=r['MouseID'].rsplit('_',1)[0],
        record_number=int(r['MouseID'].rsplit('_',1)[1]),source_record=r['MouseID'],
        genotype=r['Genotype'],treatment=r['Treatment'],learning=r['Behavior'],
        BDNF=r['BDNF_N'] if r['BDNF_N'] != '' else 'NA',
        pCREB=r['pCREB_N'] if r['pCREB_N'] != '' else 'NA') for r in records]
    write('replicates.csv',measurement_rows)
    # A fixed, outcome-independent assay index. No averaging across dilution levels.
    selected = [r for r in records if r['MouseID'].endswith('_1')]
    assert len(selected) == 72
    rows = []
    for r in selected:
        rows.append(dict(sample_id=r['MouseID'].rsplit('_', 1)[0],
            genotype=r['Genotype'], treatment=r['Treatment'], learning=r['Behavior'],
            BDNF=r['BDNF_N'] if r['BDNF_N'] != '' else 'NA',
            pCREB=r['pCREB_N'] if r['pCREB_N'] != '' else 'NA',
            NR1=r['NR1_N'] if r['NR1_N'] != '' else 'NA',
            source_record=r['MouseID']))
    write('investigation.csv', rows)
    core = [dict(sample_id=r['sample_id'], group=r['treatment'], BDNF=r['BDNF'],
                 pCREB=r['pCREB']) for r in rows
            if r['genotype'] == 'Control' and r['learning'] == 'C/S']
    assert len(core) == 19 and len({r['sample_id'] for r in core}) == 19
    write('study.csv', core)
else:
    import openpyxl
    w = openpyxl.load_workbook(raw / 'Source_Data.xlsx', read_only=True, data_only=True)
    s = w['Figure 1G+1H']
    cells = []
    for condition, col in [('Paired',1), ('Unpaired',6)]:
        for phase, day, first, last in [('Baseline',1,5,13),('Acquisition',7,21,32),('Plateau',13,38,47)]:
            for n in range(first,last+1):
                label, reversal, resting = [s.cell(n,col+i).value for i in range(3)]
                if not isinstance(reversal,(float,int)): continue
                animal = re.sub(r'\s*\(cell.*', '', label, flags=re.I).lower().replace(',','.').replace(' ','')
                cells.append(dict(sample_id=animal, conditioning=condition, phase=phase,
                                  day_label=day, reversal_mV=reversal, resting_mV=resting,
                                  source_row=n, source_label=label))
    original_ids = list(dict.fromkeys(cell['sample_id'] for cell in cells))
    id_map = {old:f'Rat_{i:02d}' for i,old in enumerate(original_ids,1)}
    write('animal_id_key.csv',[dict(sample_id=new,source_sample_id=old) for old,new in id_map.items()])
    for cell in cells: cell['sample_id'] = id_map[cell['sample_id']]
    write('cells.csv',cells)
    per_animal = {}
    measurement_rows = []
    for cell in cells:
        per_animal[cell['sample_id']] = per_animal.get(cell['sample_id'],0)+1
        measurement_rows.append(dict(cell,record_number=per_animal[cell['sample_id']]))
    write('replicates.csv',measurement_rows)
    groups = {}
    for r in cells: groups.setdefault((r['sample_id'],r['conditioning'],r['phase']),[]).append(r)
    rows = [dict(sample_id=k[0],conditioning=k[1],phase=k[2],day_label=v[0]['day_label'],
                 reversal_mV=statistics.mean(r['reversal_mV'] for r in v),
                 resting_mV=statistics.mean(r['resting_mV'] for r in v),n_cells=len(v))
            for k,v in groups.items()]
    assert len(rows)==26 and len({r['sample_id'] for r in rows})==26
    write('investigation.csv',rows)
    core = [dict(sample_id=r['sample_id'],group=r['phase'],reversal_mV=r['reversal_mV'],resting_mV=r['resting_mV'])
            for r in rows if r['conditioning']=='Paired' and r['phase'] in ['Baseline','Acquisition']]
    assert len(core)==13
    write('study.csv',core)
    s=w['Figure S1N']
    protein=[]
    for row in range(26,34):
        for day, col in [(1,3),(7,6)]:
            protein.append(dict(sample_id=s.cell(row,col).value,day=day,
                NKCC1_GAPDH=s.cell(row,col+1).value,blot_batch='February' if row<30 else 'March',source_row=row))
    assert len(protein)==16 and len({r['sample_id'] for r in protein})==16
    write('nkcc1.csv',protein)

measurements = ('BDNF','pCREB') if cfg['variant']=='mouse' else ('reversal_mV','resting_mV')
assert all(r[name]!='NA' for r in core for name in measurements)
dest=root/'tutorials/01_basics/data'
dest.mkdir(parents=True,exist_ok=True)
for name in ['study.csv','replicates.csv','investigation.csv']:
    shutil.copy2(root/'data'/name,dest/name)
manifest={p.name:hashlib.sha256(p.read_bytes()).hexdigest() for p in sorted(raw.iterdir()) if p.is_file()}
(raw/'checksums.json').write_text(json.dumps({k:v for k,v in manifest.items() if k!='checksums.json'},indent=2)+'\n')
print(cfg['variant'], 'core:',len(core),'independent animals; full:',len(rows))
