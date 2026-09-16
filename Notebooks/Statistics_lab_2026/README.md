# When a neuron changes its response

Evaluation variant on `pilot/chloride-transport`, created directly from `main` at f617a6c.
All pre-existing branches and their working files are preserved. This course directory is new
on this branch; legacy material elsewhere in main remains available but is not the evaluation route.

## Run

Open `Statistics_lab.Rproj` in RStudio, then run:

```r
source("scripts/run_pilot.R")
```

See `index.html` for the route, `tutorial_preview.html` for a static preview, and
`statistics_lab_student.zip` for a portable student copy. Learnr requires R/Shiny; publishing
these files on a Git branch does not create a hosted Shiny service or change GitHub Pages.

## What to evaluate

- Beginner clarity: arithmetic, assignment, c(), mean(), where to type/run, and recovery from errors.
- Biological interest: Does the GABA reversal potential differ between baseline and the acquisition phase of reward learning?
- Interaction: predict–run–explain, outlier challenge, histogram count/width controls and violin smoothing.
- Submission: students append code to worked examples, write notes, download an Rmd, then finish analysis in RStudio.
- Two four-hour afternoons with protected breaks. Instructor pacing and limitations are in `instructor/guide.md`.

## Build and validate

With R packages from setup and Pandoc available:

```sh
Rscript scripts/validate.R
Rscript scripts/render.R
python3 scripts/package_students.py
```

Author-only raw-table verification additionally uses Python `xlrd` or `openpyxl`:

```sh
python3 scripts/validate_data.py
```

`scripts/prepare_data.py` rebuilds CSVs from preserved source workbooks. No student task needs Python.
See `data/dictionary.html` for attribution, units and exclusions; `instructor/CHANGELOG.md` for changes.
