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

The successful R runs used R 4.4.2, rmarkdown 2.28, knitr 1.48, and ggplot2 3.5.1. RStudio supplied Pandoc at that time.

## Delivery

- Nine HTML pages passed 98 local file/anchor checks.
- The extracted student ZIP passed 85 local file/anchor checks across eight HTML pages.
- Student HTML dependencies and figures are embedded; external reference links require the internet, but reading the content does not.
- The ZIP excludes instructor answers, planning documents, preparation scripts, and original source archives.
- No previously tracked file from `main` was modified or deleted.

## Visual and teaching review

Inspected the embedded histogram panels, boxplots with points, mean bars, violin, normal Q–Q panels, neurite comparison, and correlation figures. The teaching review is in `review.md`; solutions provide numerical and interpretive feedback rather than a single required phrasing.

Full browser interaction was unavailable: no browser surface was exposed, and native computer access failed even after reset. Interactive hint toggling, full browser layout, and RStudio operation therefore still need a room-computer check. No beginner pilot has been performed.

## Late environment change

RStudio and then R were no longer present during the final verification stage. The final substantive notebook content and figures had already rendered successfully. The remaining change was disabling unused external MathJax loading: the source YAML now uses `mathjax: null`, and `scripts/offline_html.py` removed that loader from the already rendered HTML without changing content, numerical outputs, or figures. A later attempt to repeat the R checks could not run because `Rscript` was absent; this is not recorded as an additional passing run.

Future full rebuilds should use the documented R setup and `scripts/render.R`, followed by `scripts/validate.R`, packaging, and `scripts/check_delivery.py`.
