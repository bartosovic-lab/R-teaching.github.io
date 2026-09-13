# Build verification

Completed 14 September 2026.

## Execution and data

- All nine documents rendered to HTML in separate R processes: index, dictionary, six student notebooks/reference guides, and instructor solutions.
- The last successful full render included the revised day 2 histogram scale and instructor scatterplots.
- Eight day 2 combinations executed successfully: Welch/Wilcoxon × Age/nWBV × Pearson/Spearman. Results agreed with direct R calculations.
- Those checks used a copied project with spaces in its path, with fresh R processes for each case.
- Group counts were 64 Demented and 72 Nondemented; correlation analyses used 136 complete pairs.
- An injected missing-MMSE check excluded exactly one case from the relevant analyses, without dropping cases for unrelated missing SES values.
- Data preparation reran deterministically. The small MMSE scores match the workbook, the neurite file is an exact copy, and every retained dementia measurement was checked against the source before selecting first visits. Existing rounding is preserved.

The final full rebuild and all eight analysis-path checks passed with R 4.6.1, rmarkdown 2.32, knitr 1.51, ggplot2 4.0.3, and Pandoc 3.11. Packages and Pandoc were supplied from temporary build directories, without modifying the new R installation's system library. Earlier checks also passed with R 4.4.2, rmarkdown 2.28, knitr 1.48, and ggplot2 3.5.1.

## Delivery

- Nine HTML pages passed 98 local file/anchor checks.
- The extracted student ZIP passed 85 local file/anchor checks across eight HTML pages.
- Student HTML dependencies and figures are embedded; external reference links require the internet, but reading the content does not.
- The ZIP excludes instructor answers, planning documents, preparation scripts, and original source archives.
- The initial notebook addition preserved all previous files. The later authorised deployment cleanup removed the old `Notebooks/Statistics_lab/` directory and updated navigation on the course branch only; `main` remains at `f617a6c814ce0d1e25278856f0b967180757147e`.

## Visual and teaching review

Inspected the embedded histogram panels, boxplots with points, mean bars, violin, normal Q–Q panels, neurite comparison, and correlation figures. The teaching review is in `review.md`; solutions provide numerical and interpretive feedback rather than a single required phrasing.

Full browser interaction was unavailable: no browser surface was exposed, and native computer access failed even after reset. Interactive hint toggling, full browser layout, and RStudio operation therefore still need a room-computer check. No beginner pilot has been performed.

## Reinstallation and final rebuild

R and RStudio were temporarily unavailable while the user reinstalled them. Once `/usr/local/bin/R` was restored, all nine documents were rebuilt from source with the new installation, including the GitHub download instructions and `mathjax: null` output setting. All eight analysis paths were rerun successfully, then the student ZIP and delivery checks were regenerated. The earlier runtime blocker is resolved; RStudio UI and browser-layout checks remain separate, outstanding checks.

Future full rebuilds should use the documented R setup and `scripts/render.R`, followed by `scripts/validate.R`, packaging, and `scripts/check_delivery.py`.

## Pages deployment preparation

The root homepage and KN7001 navigation now target the revised workshop; their local links were checked, allowing Jekyll-generated HTML for Markdown course pages. Receptor–ligand and transcriptomic materials are unchanged. The Pages configuration excludes the new instructor folder and build scripts from the public teaching site. GitHub currently publishes `main`; a repository admin or maintainer must select `course/statistics-lab-2026` and `/(root)`. The authenticated account has write access but cannot change that setting. A live deployment check remains pending that change.

## Expanded practical work — September 2026

Rebuilt all nine HTML documents after expanding the neurite work and day 2 descriptive tasks. All eight day 2 method/variable paths passed again. In a separate copied project with spaces in its path, filled the new student chunks with representative answers and rendered notebooks 01–04; enabled the optional PDF export and ggplot2 chunks and verified the PDF was created. Inspected the new histogram, Q–Q, and four-panel figures; added an explicit label for missing SES. Student package and local-link checks were repeated. No dataset values were changed. The timing is a teaching estimate, not a learner-tested result.
