# Changes for chloride-transport

- Created a new branch directly from main (f617a6c); no existing branch was reset or overwritten.
- Added an isolated Statistics_lab_2026 project; preserved main's legacy files outside it.
- Reused the pilot's progression and interaction patterns, with new data-specific teaching text.
- Replaced MMSE with Mean GABA reversal potential (mV) and documented animal-level observation rules.
- Added original workbook, provenance/checksums, deterministic CSV preparation and independent checks.
- Added 15 graded R exercises, hints, solutions and eleven written reflections.
- Kept original example commands and asked students to append their own commands.
- Added prediction prompts, a “double the headline” outlier puzzle and a missing-assay challenge.
- Added histogram controls for count or width and a working violin with adjustable smoothing.
- Added boxplots with observations and within-group scatterplot practice.
- Kept written notes, latest submitted code, quiz answers and slider reference views in Rmd exports.
- Added beginner RStudio setup, guided inference and a day-2 investigation template with explicit choices.
- Explained mean/median/SD, normality, p-values, confidence intervals, Welch/Wilcoxon, correlation and Bonferroni.
- Added branch-specific scientific limits, four-hour schedules, a static preview and student ZIP.
- Added evaluator, incorrect-answer, server, download, fresh-render and data-provenance checks.

This log describes authored changes. Actual validation results are recorded separately after testing.

## Biological column names

- Renamed the first-day measurement columns from `value` and `companion` to `reversal_mV` and `resting_mV`.
- Updated selections, plots, feedback, exports, references, dictionaries and data-generation checks.
- Preserved all measurements, sample IDs, group labels and the separate investigation dataset.

## Biological group object names

- Replaced `first` / `second` in the worked comparison with `baseline_reversal_mV` / `acquisition_reversal_mV`.
- Named the selected animal tables `baseline_rats` / `acquisition_rats` and updated SD and histogram object names.
- Updated hints, feedback, exports, statistical examples and validation.
- Day-2 choices use `voltage_by_group`, indexed by actual group labels, to keep different biological comparisons correctly named.

## Biological replication as the day-1 highlight

- Added a required 35-minute investigation after the existing gentle warm-ups and visualisation.
- Added three graded tasks: count 47 measurements versus 26 animals, follow one animal, and defend the original comparison sample sizes.
- Added a shared-animal plot reveal and an explicitly incorrect copy-and-paste precision demonstration.
- Exported new code, reflections and interactive settings into student notebooks.
- Supplied a reproducible measurement-level CSV with provenance and independent reconciliation.
- Moved the 20-minute rank-test and 15-minute correlation discussion to the start of day 2; both afternoons remain 240 minutes including breaks.
