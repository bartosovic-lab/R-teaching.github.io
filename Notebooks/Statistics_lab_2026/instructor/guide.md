# Teaching the revised statistics lab

The student route starts at `../index.html`. Distribute `../statistics_lab_student.zip`, which excludes this instructor folder and the preparation scripts. The deployment branch now routes students to the revised course. The original statistics notebooks are preserved on `main`; they have been removed from this branch. See the repository’s `PUBLISHING.md` for the one-time Pages setting.

## Thursday: thirty minutes

Use notebook 00. Install R before RStudio, then `rmarkdown` and `knitr`. Have students open the supplied project, run a chunk, save a personal copy in `notebooks/`, and Knit it. Test room computers with a student account beforehand, including file retention after logout. Move unresolved laptop cases to those machines; do not use the first statistics session for installation troubleshooting.

The violin figure is pre-rendered. Students do not need `ggplot2` unless they elect to rerun its optional code. No LLM account is required.

## Day 1: four hours including breaks

| Elapsed time | Activity |
|---|---|
| 0:00–0:15 | Welcome, lecture retrieval, five-minute RStudio overview |
| 0:15–1:00 | Notebook 01, sections 1–4: basic R and import |
| 1:00–1:20 | Notebook 01, sections 5–6: summaries and missingness |
| 1:20–1:35 | Break |
| 1:35–1:55 | Notebook 02: prepared histograms and boxplots; demonstrate violin |
| 1:55–2:25 | Notebook 03, sections 1–3: question, plots, normality |
| 2:25–2:35 | Break |
| 2:35–3:35 | Notebook 03, sections 4–7: Welch, Wilcoxon comparison, overlap |
| 3:35–3:50 | Notebook 03, section 8: scatterplot and correlation demonstration |
| 3:50–4:00 | Restart, Knit, and exit explanation |

Protect the 30-minute normality block and the 60-minute analysis block. Within the latter, aim for 25 minutes on mean estimation and Welch output, 15 on the paired method discussion, 8 on the overlap example, and 12 for writing and questions. Shorten duplicate calculations and cosmetic plotting first. For the 20-minute plot block, show prepared plots and ask targeted questions rather than typing all the code live.

Use the original teaching pattern: explain a concrete example, run it, ask students to change or interpret something. Avoid narrating every function argument. The early challenge is predicting output and connecting commands to values; later it is explaining statistical choices. A student who cannot type a test command from memory can still meet the goals.

### Checkpoints that matter

- After orientation: each student runs a chunk, selects a column, changes an argument, finds output, and saves. If several pairs cannot, spend another ten minutes here and shorten repetition later.
- After summaries: distinguish centre, spread, missing values, and sample size.
- After plots: explain why a box is not a confidence interval and why a smooth violin does not create more observations.
- After normality: describe the evidence and uncertainty without claiming that a large Shapiro p-value proves normality.
- After tests: identify the different targets of Welch and Wilcoxon. Agreement does not make their questions identical.

Do not teach a binary normality decision tree. Teach a question/design/plot/assumption worksheet. Acknowledge that the small MMSE example is discrete, bounded, strongly separated, and of undocumented clinical provenance. Welch is introduced as an approximate mean comparison under an explicit teaching design, not a universally correct test for MMSE. Wilcoxon is not generally a test of medians when shapes differ.

The existing synthetic neurite comparison has overlap but still a small Welch p-value. It illustrates individual variability versus precision of a mean difference, not a null result. We did not alter values to force disagreement or significance. Physical units and the original simulation generator are unknown, so use “recorded units”.

## Day 2: four hours including breaks

Follow notebook 04's timetable. Work in pairs but have each student run and write in their own copy. Change who explains and who operates the keyboard during discussion; do not let one partner do all interpretation.

Begin with the separate 20-minute Bonferroni example. The independent assignment contains only one primary group comparison and one correlation. Do not turn the day into a survey of additional tests. The blank method fields stop premature inference while keeping the template renderable.

The group templates use MMSE. An alternative outcome is possible with instructor support, but requires changing all relevant selectors, axis labels, bins/ranges, and interpretation, not just the test command. Prefer the provided outcome if a pair is struggling. For correlation, Age and nWBV are both supported explicitly.

Hints in collapsible sections progress from function names to working code. They are not compulsory reading. Students can also use LLMs for debugging, hints, and conceptual explanations. Ask them to check actual variables, sample sizes, and outputs. The short assistance reflection should show one check, not document every interaction.

### Submission

Each student submits one notebook, with its `.Rmd` and rendered HTML versions according to the course submission channel. No separate report. The minimum requirements are in notebook 04. A clean render with blank selection prompts is an incomplete assignment.

Allow minor narrative completion after class if needed, but aim to finish the analysis during the session. Assess reasoning, not volume. Accept exploratory conclusions acknowledging multiplicity; if students make a joint discovery claim, direct them to the optional two-test adjustment and its scope.

## Data preparation choices

The existing course values are preserved. `prepare_data.py` extracts the small MMSE scores from the workbook, copies the neurite CSV byte-for-byte, verifies every retained value against the official OASIS workbook, restores identifiers, and selects first visits. It records source hashes and counts. The independent dataset has 136 participants, not 336 independent rows; eight SES entries are missing and no baseline MMSE scores are missing.

Source group exclusions are unchanged. This retains a longitudinal-selection limitation, stated in the dictionary and task. It is simpler than introducing the Converted group or longitudinal modelling, but should not be presented as an unselected population sample.

The files in `planning/` preserve the agreed plan and original context. They are planning snapshots and retain references to the previous repository layout; the student index and this guide describe the implemented route.

## Building and checking

See the project README for commands. Render from fresh processes, then run `Rscript scripts/validate.R` and `python3 scripts/package_students.py`. The validation checks eight day 2 method/variable combinations and a copied project with spaces in its path. Preparation verifies the lineage rather than merely checking expected dimensions.

The browser review should inspect the four teaching notebooks, the setup page, dictionary, and the worked-answer tables. Check plots at ordinary screen width, collapsed hints, code wrapping, and navigation. Clean renders and numerical checks cannot establish that novices can complete the session on time; that requires observing students.
