# Teaching statistics-final

Day 1 is entirely learnr, using mouse proteins. Day 2 is an R Notebook investigation using the revised 136-participant OASIS/MMSE baseline table. Do not route students through the earlier 03 statistical-analysis notebook. Its core reasoning is now inside learnr.

## Preparation

Use notebooks/00_setup.html before class. Test launch, one exercise, feedback and download on the actual room computers. Test RStudio, notebook rendering and file retention yourself before delivery. Student notebook editing starts on day 2. Distribute statistics_lab_student.zip, not the repository's older course ZIPs. The live lesson requires R/Shiny; a static website serves the reading preview and download only.

## Day 1: four hours including breaks

| Activity | Minutes |
|---|---:|
| First commands | 12 |
| Mice, data types and replication | 18 |
| Select one treatment | 10 |
| Mean/median/SD, quartiles/IQR and outlier challenge | 20 |
| Missing values | 10 |
| Break | 15 |
| Histograms and bins | 15 |
| Boxplots, dots and short violin demonstration | 15 |
| Scatterplots | 10 |
| Normality and assumptions | 15 |
| Break | 10 |
| Welch, Wilcoxon and an evidence-based headline | 30 |
| Correlation | 15 |
| Bonferroni | 15 |
| Evidence briefing and download | 10 |
| Flexible practice/catch-up across the afternoon | 20 |
| **Total** | **240** |

These timings are a middle ground between the earlier five-minute warm-up and a much longer orientation. They are unpiloted targets, not guarantees or speed assessments. Use flexible time where students need it. If behind, reduce extra plots and the violin discussion; protect quartiles/IQR, assumptions, interpretation and saving. Regression and repeated full analyses across three proteins are outside the core.

The code fields contain examples or explicit NULL placeholders; students keep context/import lines. Each learnr editor starts independently. Run Code is exploratory; Submit Answer retains the latest attempt. Download at both breaks and the end. Written answers are session-only. The export contains actual submitted attempts, including unfinished work; it never substitutes a solution. A green code check does not evaluate prose. The download is a practice record, not the final assessed report.

A normal model is a judgement using design and plots; never teach a Shapiro cutoff decision tree. Welch targets means and Wilcoxon uses ranks. Teach estimated difference and uncertainty before p-values. In the mouse data, pooled treatments mix genotype and protocol. One fixed assay record per mouse avoids treating repeated assay readings as independent animals, but is not a full abundance model. Keep units as relative assay signal. Do not promise evidence of a memory benefit.

## Day 2: four hours including breaks

Allow 180 minutes of core work, 25 minutes of breaks and 35 minutes for extensions or catch-up. Timing allocations are instructor-only; the student notebook gives an untimed route. Start with 15 minutes of real RStudio orientation. Students save a personal copy in notebooks/, run setup and import, and produce their first HTML before substantial editing. Explain that notebook chunks share a working session, unlike independent learnr editors.

The template's primary output is html_notebook, so it opens as a real R Notebook. Preview produces an .nb.html snapshot. For the final deliverable choose the HTML document output (Knit to HTML), which executes the saved recipe. The notebook gives a render command as a fallback if menus differ. Do not accept an unchanged task preview as a completed report.

Independent tasks include: row/ID/missingness audit; age summaries including quartiles/IQR; histogram-bin comparison; category counts; SES interpretation; age selection and proportions; two-question plan; group summaries and boxplot; normality assessment; justified test; result and limitation; association plot and coefficient; independent Bonferroni calculation; critique; and final narrative. Hints provide help without removing student decisions. Extensions offer a combined figure, another descriptive measurement, correction for their own test family, and counts/chi-square/Fisher. Chi-square remains an explicit extension rather than silently adding workload to the core.

Students work in pairs but write individually. Alternate who types and explains; avoid taking over the keyboard. No instructor approval gate is required. Encourage them to write interpretations beside outputs, then ask a partner to challenge one overclaim. LLM help is allowed, with one concrete verification reflection.

## Assessment

Assess the final individual HTML, not how many green checks or tests a student obtained. Require the correct observation unit, analysis-specific n/missingness, quartiles/IQR and clear plots, a justified group comparison, one association, effect and uncertainty where supplied, a multiple-testing explanation, and a proportionate conclusion. Accept a non-significant result with excellent reasoning. Separate type/plot choice, methodological reasoning, interpretation and reproducibility in feedback.

## Data and validation

The original working directories are unchanged. The combined course copies the reviewed mouse and MMSE CSVs without editing measurements. Source archives, original preparation scripts and hashes remain in instructor/source; current reconciliation is scripts/validate_data.py. The student ZIP excludes all instructor material and runtime libraries.

Run scripts/validate.R for actual learnr solution evaluation, wrong answers, Shiny controls/downloads, completed export rendering and all supported day-2 method combinations. Render the static pages with scripts/render.R and build the ZIP with scripts/package_students.py. See VALIDATION.md for results from this build; a successful technical check does not establish classroom pacing.

## Student-facing revision

All section, break, setup and extension time allocations are hidden from students. Keep the schedules above for facilitation. The variable-type quiz asks separately about all eight mouse-table columns; none is ordinal. Protein descriptions explain biological function. The normality section now teaches Q–Q axes, the quartile reference line, W, the normality null and p < 0.05 versus p >= 0.05 with examples and limitations. All 22 exercise editors include `# your code goes here`.
