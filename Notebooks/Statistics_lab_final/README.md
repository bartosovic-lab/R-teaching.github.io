# Statistics final: mouse proteins to human cognition

Two afternoons for students new to R. Open `index.html` for the route.

- Day 1: mouse-protein learnr tutorial, including summaries, quartiles/IQR, graphics, assumptions, Welch/Wilcoxon, correlation and Bonferroni. All exercises run in designated tutorial editors.
- Day 2: `notebooks/02_mmse_investigation.Rmd`, a real R Notebook with independent tasks, progressive hints and optional extensions. Its first output is `html_notebook`; `html_document` provides the reproducible final submission.
- Keep the entire folder together. Open `Statistics_lab.Rproj` in RStudio.
- Install once in the Console: `install.packages(c("learnr", "shiny", "rmarkdown", "knitr", "jsonlite"))`.
- Launch day 1: `source("scripts/run_day1.R")`. A running R session is required; the static preview is not the live tutorial.
- Day 1 downloads contain submitted code and current prose; download before closing or refreshing. No RStudio notebook editing is required on day 1.
- On day 2 save a personal copy in `notebooks/`, run chunks in order, and choose Knit to HTML. Keep the Rmd; submit the freshly rendered `.html`. Preview's `.nb.html` is a notebook snapshot, not the final execution check.

See `instructor/guide.md` in the author checkout for pacing and assessment. Source archives and instructor solutions are excluded from the student ZIP.

Author build from this folder: `python3 scripts/preview.py`, `Rscript scripts/render.R`, `Rscript scripts/validate.R`, `python3 scripts/validate_data.py`, `python3 scripts/package_students.py`.
The data check needs Python xlrd for the archived XLS; students never need Python.
