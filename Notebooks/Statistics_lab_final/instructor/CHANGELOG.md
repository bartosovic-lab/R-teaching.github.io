# Statistics final — 16 September 2026

New isolated branch `statistics-final`, based on the existing learnr branch HEAD and the reviewed working-copy course content. Existing worktrees and edits are preserved.

- New course directory `Notebooks/Statistics_lab_final` and updated KN7001 course navigation.
- Day 1 mouse-protein learnr route now covers the complete guided statistical workflow, with 22 checked coding exercises, an ordinal-variable quiz, interactive plots and scientific answer boxes.
- Required quartiles/IQR exercise and a compact mice-versus-assay-records challenge; removed regression and repeated complete three-protein analyses from the core.
- Added guided diagnostics, Welch, Wilcoxon, choice of correlation and real three-protein Bonferroni example inside learnr.
- Day 2 uses the unchanged revised MMSE baseline data in a real R Notebook, with an HTML document output for the final fresh render.
- Independent audit, summary, quartile/IQR, graph, assumption, comparison, association, correction and interpretation tasks; optional hints and four extension choices.
- Day 1 has 195 core minutes, 25 break minutes and 20 flexible minutes. Day 2 has 180 core minutes, 25 break minutes and 35 flexible minutes. These schedules require classroom piloting.
- Source provenance, instructor solutions, data reconciliation, live-exercise and release checks supplied.
- Fixed export handling of backticks in student prose using entities before knitr evaluation.
- Separate `.nb.html` snapshot and freshly executed `.html` task preview are both distributed. Render order preserves both files.
