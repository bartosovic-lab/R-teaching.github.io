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
| `setup.R` | Installs the required packages and checks the project (`source("setup.R")`) |
| `.Rprofile` | Runs when the project opens in RStudio: sources `setup.R` and launches the tutorial |
| `day1.Rmd` | The interactive tutorial. In RStudio click **Run Document** |
| `helpers.R` | Data loading, quiz helpers, the exercise checker and the work-export function used by `day1.Rmd` |
| `data/` | `mmse_small.csv` (20 MMSE scores), `neurites.csv` (synthetic outgrowth), `README.md` with provenance |
| `day1_report.Rmd` | Optional R Markdown template mirroring the Day 1 analysis; not used in the tutorial, kept as a starting point for Day 2 |
| `instructor/day1_guide.md` | Timing, expected outputs and common student problems |
| `scripts/check_tutorial.R` | Runs every exercise, solution and demo chunk headlessly (`Rscript scripts/check_tutorial.R`) |
| `scripts/render_preview.R` | Knits a static `day1_preview.html` for the website (learnr itself needs a live R session) |
| `scripts/deploy_shinyapps.R` | Publishes the tutorial to shinyapps.io for a one-click online button |
| `scripts/build_zip.sh` | Rebuilds `../Statistics_lab_2026.zip`, the student download linked from the course page |
| `Launch_day1.command`, `Launch_day1.bat` | Double-click launchers for Mac and Windows |

## Student instructions (for the setup session)

1. Install R, then RStudio.
2. Download `Statistics_lab_2026.zip` from the course page, unzip it, keep the folder together.
3. Double-click `Statistics_lab.Rproj`. RStudio opens, `.Rprofile` runs `setup.R`
   (installs the packages the first time) and starts the tutorial with
   `rmarkdown::run("day1.Rmd")`. Use **Show in new window** for full size.
4. If nothing starts: open `day1.Rmd` and click **Run Document**.

## Launch options

| Where | How | Notes |
|---|---|---|
| **Locally, any OS (default)** | Double-click `Statistics_lab.Rproj` | `.Rprofile` auto-launches the tutorial. Create an empty `.no_autolaunch` file in the folder to open the project without launching |
| **Locally, RStudio by hand** | Open `day1.Rmd` → **Run Document** | Always works |
| **Locally, without opening RStudio** | Double-click `Launch_day1.command` (Mac) or `Launch_day1.bat` (Windows) | On a Mac, a downloaded script is blocked by Gatekeeper ("Apple could not verify…"): after the first attempt, System Settings → Privacy & Security → **Open Anyway**; or in Terminal `xattr -d com.apple.quarantine Launch_day1.command`. RStudio must still be installed (it supplies pandoc) |
| **Online** | Button on the course page → hosted copy on shinyapps.io | No installation for students. Deploy with `scripts/deploy_shinyapps.R` (needs a Posit account); the free tier is enough for a small class only |

A GitHub Pages site is static and cannot run the tutorial itself; the online
button just links to the hosted copy. `day1_preview.html` is the static,
read-only version for the website.

## Structure of the tutorial

Core route (about 215 minutes of activity plus breaks): Welcome (incl. LLM policy)
→ Mission 1 first commands → Mission 2 import a table → Mission 3 centre and spread
→ Mission 4 plots → Mission 5 assumptions → Mission 6 two-group comparison and the
overlap challenge → Mission 7 multiple testing and Bonferroni → Mission 8
correlation → Finish (exit ticket).

Optional sections: Toolbox A (vectors), Toolbox B (data frames and slicing),
Gallery (base and ggplot2 plots), Extras (F-test, Student vs Welch, fold change,
ANOVA/Kruskal, chi-square, paired test), Command card.
