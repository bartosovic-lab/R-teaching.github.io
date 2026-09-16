"""Package only the current route; instructor answers, validation and source archives stay private."""
from pathlib import Path
import zipfile
root=Path(__file__).resolve().parents[1]
files=[root/n for n in ['Statistics_lab.Rproj','README.md','course.json','index.html','day1_preview.html','scripts/run_day1.R']]
files+=list((root/'notebooks').glob('*.Rmd'))+list((root/'notebooks').glob('*.html'))
files+=list((root/'data').glob('*.csv'))+[root/'data/dictionary.html']
files+=[root/'tutorials/01_basics'/n for n in ['01_basics.Rmd','helpers.R','course.json','exercises.json','data/study.csv','data/replicates.csv']]
with zipfile.ZipFile(root/'statistics_lab_student.zip','w',zipfile.ZIP_DEFLATED) as z:
 for f in sorted(files):
  assert f.is_file(),f
  rel=f.relative_to(root).as_posix();content=f.read_bytes()
  if rel=='index.html': content=content.replace(b'href="statistics_lab_student.zip"',b'href="README.md"')
  z.writestr('Statistics_lab_final/'+rel,content)
with zipfile.ZipFile(root/'statistics_lab_student.zip') as z:
 assert z.testzip() is None
 assert not any('/instructor/' in n or '/source/' in n or '.learnr-library' in n for n in z.namelist())
print('Packaged',len(files),'files')
