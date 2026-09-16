"""Build the reading preview from the live lesson; never present it as runnable learnr."""
from pathlib import Path
import re,json
root=Path(__file__).resolve().parents[1]
s=(root/'tutorials/01_basics/01_basics.Rmd').read_text()
body=s[s.index('## Welcome:'):]
header='---\ntitle: "Day 1 — mouse proteins: reading preview"\noutput:\n  html_document:\n    toc: true\n    self_contained: true\n    mathjax: null\n---\n\n**Reading preview only.** Use `source("scripts/run_day1.R")` in the project to open live editors, feedback and sliders. This page shows starter code, not completed student answers.\n\n'
header+='```{r preview-setup, include=FALSE}\nold <- getwd()\nsetwd("tutorials/01_basics")\nsource("helpers.R",local=knitr::knit_global())\nsetwd(old)\nknitr::opts_chunk$set(echo=FALSE,fig.width=8,fig.height=4.5)\n```\n\n'
def chunk(m):
 spec,code=m.groups(); label=spec.split(',')[0].strip()
 if 'exercise=TRUE' in spec:return '```{r '+label+', eval=FALSE, echo=TRUE}\n'+code+'```'
 if label.endswith('-solution') or '-hint-' in label or label.endswith('-check') or label=='server':return ''
 notes=re.findall(r'note\("([^"]+)"\)',code)
 out='\n'.join('```{r preview-note-'+x+'}\ncat(note_labels[["'+x+'"]])\n```' for x in notes)
 if label=='histogram-controls':out+='\n```{r preview-hist}\nhist_view(read.csv("data/study.csv"))\n```'
 if label=='violin-controls':out+='\n```{r preview-violin}\nviolin_view(read.csv("data/study.csv"))\n```'
 if label=='design-reveal':out+='\n```{r design-reveal, echo=TRUE}\n'+code+'```'
 if label=='types-quiz':
  out+='\n| Column | Your choice: ordinal, nominal or continuous |\n|---|---|\n'
  for column in ['sample_id','group','BDNF','pCREB','NR1','genotype','learning','source_record']:
   out+='| `'+column+'` | Write your choice |\n'
 if label=='selection-walkthrough':out+='\n```{r selection-walkthrough, echo=TRUE}\n'+code+'```'
 if label=='slider-outlier':out+='\n*Live slider: change the fifth reading, observe mean and median, then test your prediction in code.*\n'
 return out
body=re.sub(r'```\{r ([^\n]+)\}\n(.*?)```',chunk,body,flags=re.S)
(root/'day1_preview.Rmd').write_text((header+re.sub(r'\n{4,}','\n\n\n',body)).rstrip()+'\n')
print('Built day1_preview.Rmd from the live lesson')
