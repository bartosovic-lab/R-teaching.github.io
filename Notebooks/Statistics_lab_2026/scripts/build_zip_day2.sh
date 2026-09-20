#!/bin/bash
# Instructor tool: build the Day 2 student project and download.
# Source of the tasks is Notebooks/Statistics_lab/04.mmse_tasks.Rmd (edit that file).
# This script derives the student notebook Statistics_lab_2026_day2/day2_mmse_tasks.Rmd
# from it (project-relative data path, name field, submission section), knits the
# HTML shown on the course page, copies the data, and zips the project.
# Usage, from anywhere:  bash Notebooks/Statistics_lab_2026/scripts/build_zip_day2.sh
set -e
cd "$(dirname "$0")/../.."          # Notebooks/
SRC=Statistics_lab/04.mmse_tasks.Rmd
DST=Statistics_lab_2026_day2
mkdir -p "$DST/data"

# The command card is maintained once, in day1.Rmd; copy it into the Day 2 notebook and page.
CARD=$(mktemp)
awk '/^### Command card/{f=1; next} /^### The result sentence/{f=0} f' Statistics_lab_2026/day1.Rmd \
  | sed -e 's/^Everything you need for today.s questions\./Everything you need for today'"'"'s questions, copied from the Day 1 tutorial./' > "$CARD"
cp ../data/alzheimer_data.csv "$DST/data/alzheimer_data.csv"

{
  cat <<'YAML'
---
title: "Day 2 · Investigating cognitive decline and brain volume (MMSE dataset)"
author: "YOUR NAME"
date: "`r Sys.Date()`"
output:
  html_document:
    toc: true
    toc_float: true
    df_print: paged
---

<!-- Answer each question below its heading: code in grey chunks (Code > Insert Chunk,
     or Ctrl/Cmd+Alt+I), your explanation as ordinary text. Knit regularly.
     At the end of the day, Knit once more and submit the HTML file to Canvas. -->

## Before you start: the notebook and the Console

Yesterday the tutorial hid RStudio from you. Today you work in RStudio itself.
This file is a **notebook** (top left pane): text, grey code chunks, and the
output of each chunk directly below it. Everything in it is saved, and at the end
you **Knit** it into the HTML report you submit. The **Console** (bottom left,
the `>` prompt) is a scratchpad: a command typed there runs, shows its result,
and is forgotten when R restarts.

![Notebook (top left) and Console (bottom left) in RStudio](https://raw.githubusercontent.com/bartosovic-lab/R-teaching.github.io/main/Figures/rstudio_notebook_console.png)

- Use the **Console** for a quick look (`head(mmse)`, `?t.test`) or to try a
  command before you commit to it.
- Put everything that is part of your answer in a **chunk** of this notebook:
  *Code → Insert Chunk* (Ctrl/Cmd+Alt+I), then run it with the green triangle or
  Ctrl/Cmd+Shift+Enter. Write your explanation as ordinary text below the chunk.
- Rule of thumb: *if you would want it tomorrow, it goes in the notebook.*
- Knit regularly (Ctrl/Cmd+Shift+K). Knitting runs the whole file from a clean
  start, so anything that only ever lived in the Console will fail here, which is
  what you want to find out early.
- `object not found`: run the chunks above, from the top. Console shows `+`
  instead of `>`: press **Esc** and retype the complete command.

More on this, with the common problems and their fixes: the
[Day 2 page](https://bartosovic-lab.github.io/R-teaching.github.io/Pages/KN7001_day2.html).

YAML
  # body of the source notebook without its YAML header, with project-relative data path
  awk 'BEGIN{n=0} /^---/{n++; next} n>=2{print}' "$SRC" \
    | sed -e "s#'\.\./\.\./data/alzheimer_data.csv'#'data/alzheimer_data.csv'#" \
          -e 's#\[Link for data download\](https://github.com/bartosovic-lab/R-teaching.github.io/tree/main/data)#The data file is in the `data/` folder of this project; see `data/README.md` for what every column means.#' \
          -e 's#!\[Example answer to Q32\](\.\./\.\./Figures/all_in_one.png)#![Example answer to Q32](https://raw.githubusercontent.com/bartosovic-lab/R-teaching.github.io/main/Figures/all_in_one.png)#'
  printf '\n## Command card\n'
  cat "$CARD"
  cat <<'TAIL'

------------------------------------------------------------------------

## Submit your work

1. Fill in your name in the `author:` line at the top of this file.
2. **Session → Restart R**, then click **Knit**. If the HTML appears without errors, your analysis is reproducible.
3. Open the knitted `day2_mmse_tasks.html`, check that your answers, figures and explanations are all there.
4. Upload the HTML file to **Canvas** before the end of the day.

Work individually; discussing the questions in groups is permitted, but the code and explanations you submit must be your own.
TAIL
} > "$DST/day2_mmse_tasks.Rmd"

# The tasks as a web page (Pages/KN7001_day2_tasks.md), derived from the same notebook
{
  cat <<'HEAD'
# Day 2 · The tasks

[← Back to Day 2](KN7001_day2.md) · [Download the project (zip)](../Notebooks/Statistics_lab_2026_day2.zip)

Answer every question in `day2_mmse_tasks.Rmd` in RStudio (code in a chunk,
explanation as text). This page is the same list of questions for reading on a
phone or a second screen.

HEAD
  awk 'BEGIN{n=0} /^---$/{if(n<2){n++; next}} n>=2{print}' "$DST/day2_mmse_tasks.Rmd" \
    | sed -e '/^<!-- Answer each question/,/-->$/d' \
          -e '/^## Before you start: the notebook and the Console/,/^## Introduction/{/^## Introduction/!d;}' \
          -e 's/^```{r}$/```r/' \
          -e 's#`data/README.md`#[`data/README.md`](../Notebooks/Statistics_lab_2026_day2/data/README.md)#'
} > ../Pages/KN7001_day2_tasks.md

# Day 2 page: refresh the command card between its markers
PAGE=../Pages/KN7001_day2.md
{
  sed '/^<!-- command-card:start -->/q' "$PAGE"
  printf '\n### Command card\n\n'
  cat "$CARD"
  printf '\n'
  sed -n '/^<!-- command-card:end -->/,$p' "$PAGE"
} > "$PAGE.tmp" && mv "$PAGE.tmp" "$PAGE"
rm -f "$CARD"

# Knit the tasks notebook for the online view
if [ -z "$RSTUDIO_PANDOC" ]; then
  for d in /Applications/RStudio.app/Contents/Resources/app/quarto/bin/tools/aarch64 \
           /Applications/RStudio.app/Contents/Resources/app/quarto/bin/tools/x86_64; do
    [ -x "$d/pandoc" ] && export RSTUDIO_PANDOC="$d" && break
  done
fi
( cd "$DST" && Rscript -e 'rmarkdown::render("day2_mmse_tasks.Rmd", quiet = TRUE)' )

rm -f Statistics_lab_2026_day2.zip
zip -r -X Statistics_lab_2026_day2.zip \
  "$DST/Statistics_lab_day2.Rproj" \
  "$DST/day2_mmse_tasks.Rmd" \
  "$DST/data/alzheimer_data.csv" \
  "$DST/data/README.md"
unzip -l Statistics_lab_2026_day2.zip
