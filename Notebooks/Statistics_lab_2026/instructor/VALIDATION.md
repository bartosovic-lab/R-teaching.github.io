# Validation — 2026-09-16

Passed independently for this branch:

- Original workbook SHA-256 and source-record reconciliation; no original values overwritten.
- Animal IDs, group counts, selection/aggregation and tutorial CSV equality.
- R Markdown dependency discovery (regression for the live-launch self-reference recursion).
- All 15 solutions through the installed learnr evaluator, plus seven deliberately incorrect attempts.
- Actual learnr state accessor in a fresh Shiny test session: empty, successful and revised incorrect states.
- Histogram count/width extremes, outlier control and violin smoothing produce plot output.
- All three download buttons preserve current submitted code and written notes; missing tasks remain marked.
- Completed student export renders in a fresh R process, including its saved slider-reference views.
- Guided notebook and untouched day-2 draft render successfully.
- All 24 supported combinations of day-2 question, group test, association group and correlation method execute.
- Static index, setup, dictionary, tutorial preview and instructor results render successfully.
- Student ZIP excludes instructor solutions, source workbooks and local package installations.
- A separate unpacked ZIP renders both RStudio notebooks and a completed learnr export without accessing the original project.
- Both live tutorials started on automatically selected localhost ports and returned HTTP 200 with their exercise/control UI.
- Representative histogram, violin and individual-point figures were visually inspected.

Testing used the locally installed R and learnr 0.11.6. Browser click-by-click interaction has not been manually audited; controls and downloads were exercised through Shiny testServer, and HTTP launch was verified separately. Evaluate the full student journey in RStudio before teaching.

Run `Rscript scripts/validate.R`, `python3 scripts/validate_data.py` (author Excel-reader dependency), and `python3 scripts/validate_package.py` to repeat the automated checks. The raw workbook is intentionally absent from the student ZIP.

The chloride source discrepancy and mouse fixed-record limitation are documented in the data dictionary. The plateau cell-count discrepancy does not affect the chloride first-day core.
