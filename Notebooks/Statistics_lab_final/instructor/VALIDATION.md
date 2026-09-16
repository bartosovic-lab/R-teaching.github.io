# Validation — statistics-final

Completed 16 September 2026, with R 4.6.1 and learnr 0.11.6.

- `scripts/render.R`: course index, setup, dictionary, day-1 reading preview, day-2 HTML document and `.nb.html` R Notebook, command reference and instructor solutions render successfully. The live learnr lesson also compiles.
- `scripts/validate.R`: all 22 actual learnr solution evaluations pass. All 22 empty attempts and five targeted incorrect attempts are rejected. Both Pearson and Spearman solution choices pass the correlation exercise check.
- A complete day-1 download renders from a fresh R process, including scientific notes containing literal backticks and an inline-R-looking string. Unsubmitted exercises are marked incomplete; no solutions are silently substituted.
- `scripts/validate_server.R`: Shiny testServer checks the outlier, histogram and violin controls, completion counts, correct/incorrect state changes and all four notebook download buttons, including written notes.
- All eight day-2 combinations (Welch/Wilcoxon × Age/nWBV × Pearson/Spearman) execute and produce statistical results. A representative filled-choice notebook renders in a fresh R process. The blank template renders with its draft notice.
- `scripts/validate_data.py`: source reconciliation passes for the selected mouse assays, archived repeated assays, mouse IDs and group counts, the OASIS first-visit subset, retained legacy values/precision, restored participant IDs and missingness. Used the existing `/private/tmp/mouse-workshop-venv/bin/python` environment with xlrd. All three released CSVs are byte-identical to the reviewed working-copy datasets.
- `scripts/package_students.py` and `scripts/validate_release.py`: the ZIP contains 23 intended files; integrity and 20 local HTML links pass. Instructor files, source archives and local libraries are excluded.
- A clean extracted ZIP in a path with spaces successfully renders the day-2 HTML, compiles the live tutorial and evaluates its quartile exercise using installed R packages. No original project data paths or local library symlink are included in that ZIP.
- The launch script successfully started a localhost Shiny server; an HTTP response contained the live lesson and its new statistics sections. Browser visual interaction was not verified: Computer Use permissions were unavailable, and the user subsequently prohibited computer control. No further computer-control actions were taken.

The deliberately misspelled `Readings` attempt emits an expected exercise error during negative testing. A PDF-only diagnostic device substituted an ASCII dash for two Q–Q titles; those plot labels were changed to Q-Q and subsequent checks passed without that warning.

These checks establish execution, data consistency and packaging, not student comprehension or completion time. Both timetables remain proposals to pilot with beginners. The tutorial requires a live R/Shiny session; its HTML reading preview is not a hosted interactive application.
