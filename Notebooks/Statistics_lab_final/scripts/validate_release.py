"""Check the student ZIP and its local links; extract a clean copy for R validation."""
from pathlib import Path
from html.parser import HTMLParser
from urllib.parse import urlsplit,unquote
import tempfile,zipfile,json
root=Path(__file__).resolve().parents[1]
class Links(HTMLParser):
 def __init__(self):super().__init__();self.links=[]
 def handle_starttag(self,tag,attrs):
  if tag=='a':
   for key,value in attrs:
    if key=='href' and value:self.links.append(value)
with zipfile.ZipFile(root/'statistics_lab_student.zip') as z:
 assert z.testzip() is None
 names=z.namelist()
 assert not any('validation_' in n or '/instructor/' in n or '.learnr-library' in n for n in names)
 tmp=Path(tempfile.mkdtemp(prefix='statistics final student '))
 z.extractall(tmp)
course=tmp/'Statistics_lab_final'
checked=0
for f in course.rglob('*.html'):
 parser=Links();parser.feed(f.read_text())
 for href in parser.links:
  u=urlsplit(href)
  if u.scheme or u.netloc or not u.path:continue
  target=(f.parent/unquote(u.path)).resolve()
  assert target.exists(),(f.relative_to(course),href)
  checked+=1
assert 'html_notebook:' in (course/'notebooks/02_mmse_investigation.Rmd').read_text()
assert (course/'data/study.csv').read_bytes()==(root/'data/study.csv').read_bytes()
assert (course/'data/mmse_baseline.csv').read_bytes()==(root/'data/mmse_baseline.csv').read_bytes()
(root/'outputs/student_copy_path.txt').write_text(str(course)+'\n')
print('PASS:',len(names),'packaged files;',checked,'local HTML links; clean student copy:',course)
