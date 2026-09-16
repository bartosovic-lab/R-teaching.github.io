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

YAML
  # body of the source notebook without its YAML header, with project-relative data path
  awk 'BEGIN{n=0} /^---/{n++; next} n>=2{print}' "$SRC" \
    | sed -e "s#'\.\./\.\./data/alzheimer_data.csv'#'data/alzheimer_data.csv'#" \
          -e 's#\[Link for data download\](https://github.com/bartosovic-lab/R-teaching.github.io/tree/main/data)#The data file is in the `data/` folder of this project; see `data/README.md` for what every column means.#' \
          -e 's#!\[Example answer to Q32\](\.\./\.\./Figures/all_in_one.png)#![Example answer to Q32](https://raw.githubusercontent.com/bartosovic-lab/R-teaching.github.io/main/Figures/all_in_one.png)#'
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
