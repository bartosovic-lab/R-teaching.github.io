"""Build a student ZIP with explicit exclusions for instructor answers and source archives."""
from pathlib import Path
import zipfile,json
root=Path(__file__).resolve().parents[1]
variant=json.loads((root/'course.json').read_text())['folder']
files=[root/n for n in ['Statistics_lab.Rproj','README.md','course.json','index.html','tutorial_preview.html']]
files += [root/'scripts/run_pilot.R']
files += list((root/'notebooks').glob('*.Rmd'))+list((root/'notebooks').glob('*.html'))
files += list((root/'data').glob('*.csv'))+[root/'data/dictionary.html']
files += [root/'tutorials/01_basics'/n for n in ['01_basics.Rmd','helpers.R','course.json','exercises.json','data/study.csv','data/replicates.csv','replication.R']]
with zipfile.ZipFile(root/'statistics_lab_student.zip','w',zipfile.ZIP_DEFLATED) as z:
 for f in sorted(files):
  assert f.is_file(),f
  rel=str(f.relative_to(root))
  content=f.read_bytes()
  if rel=='index.html': content=content.replace(b'href="statistics_lab_student.zip"',b'href="README.md"')
  z.writestr('Statistics_lab_'+variant+'/'+rel,content)
with zipfile.ZipFile(root/'statistics_lab_student.zip') as z:
 assert z.testzip() is None
 assert not any('/instructor/' in n or '/source/' in n or '.learnr-library' in n for n in z.namelist())
print('Packaged',len(files),'files into statistics_lab_student.zip')
