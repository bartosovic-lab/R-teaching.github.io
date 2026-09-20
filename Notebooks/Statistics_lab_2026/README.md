# Statistics lab 2026 · Day 1 (learnr)

Interactive Day 1 of the KN7001 statistics workshop: one guided `learnr` document
with runnable code windows, quizzes, open-answer reflections and automatic checks.
Day 1 is practice; at the end students click **Download my work** in the Finish
section, which saves every code window (their last code), every quiz answer and
every reflection into one HTML file. Day 2 (MMSE/OASIS investigation) is where
students write and knit their own notebook.

## Files

| File | Role |
|---|---|
| `Statistics_lab.Rproj` | Open this first so that paths such as `data/mmse_small.csv` work |
| `setup.R` | Installs the required packages, checks the project and starts the tutorial (`source("setup.R")`) |
| `.Rprofile` | Runs when the project opens in RStudio: sources `setup.R`, which launches the tutorial |
| `day1.Rmd` | The interactive tutorial. In RStudio click **Run Document** |
| `helpers.R` | Data loading, quiz helpers, the exercise checker and the work-export function used by `day1.Rmd` |
| `data/` | `mmse_small.csv` (20 MMSE scores), `neurites.csv` (synthetic outgrowth), `README.md` with provenance |
| `day1_report.Rmd` | Optional R Markdown template mirroring the Day 1 analysis; not used in the tutorial, kept as a starting point for Day 2 |
| `instructor/day1_guide.md` | Timing, expected outputs and common student problems |
| `scripts/check_tutorial.R` | Runs every exercise, solution and demo chunk headlessly (`Rscript scripts/check_tutorial.R`) |
| `scripts/render_preview.R` | Knits a static `day1_preview.html` for the website (learnr itself needs a live R session) |
| `scripts/build_zip.sh` | Rebuilds `../Statistics_lab_2026.zip`, the student download linked from the course page |
| `scripts/build_zip_day2.sh` | Builds the Day 2 project `../Statistics_lab_2026_day2/` (notebook derived from `../Statistics_lab/04.mmse_tasks.Rmd` plus the RStudio intro, data, knitted HTML), its zip, and the tasks web page `Pages/KN7001_day2_tasks.md` |

## Student instructions (for the setup session)

1. Install R, then RStudio.
2. Download `Statistics_lab_2026.zip` from the course page, unzip it, keep the folder together.
3. Double-click `Statistics_lab.Rproj`. In the RStudio Console run `source("setup.R")`:
   it installs the packages (first time only) and starts the tutorial with
   `rmarkdown::run("day1.Rmd")`. Opening the project runs this automatically
   through `.Rprofile`. Use **Show in new window** for full size.
4. If nothing starts: open `day1.Rmd` and click **Run Document**.

Create an empty file called `.no_autolaunch` in the folder to open the project
without starting the tutorial (useful when editing). learnr needs a live R
session, so the tutorial runs on each student's computer; `day1_preview.html`
is the static, read-only version for the website.

## Structure of the tutorial

Core route (untimed for students; the facilitator schedule is in `instructor/day1_guide.md`): Welcome (incl. LLM policy)
→ Mission 1 first commands → Mission 2 import a table → Mission 3 centre and spread
→ Mission 4 plots → Mission 5 assumptions → Mission 6 two-group comparison and the
overlap challenge → Mission 7 multiple testing and Bonferroni → Mission 8
correlation → Finish (exit ticket).

Optional sections: Toolbox A (vectors), Toolbox B (data frames and slicing),
Gallery (base and ggplot2 plots), Extras (F-test, Student vs Welch, fold change,
ANOVA/Kruskal, chi-square, paired test), Command card.
