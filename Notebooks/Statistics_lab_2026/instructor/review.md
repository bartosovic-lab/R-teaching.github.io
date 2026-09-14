# Review of the revised notebooks

## Overall assessment

The notebooks follow the agreed priorities: learning statistical reasoning with supplied R code, normality assessment, comparison of Welch and Wilcoxon, useful plots, and a manageable independent investigation. They preserve the previous course values and keep the old notebooks on the unchanged main branch.

The main remaining uncertainty is pacing with actual beginners. The code can be checked automatically; whether students understand it and finish comfortably needs a short learner pilot or observation during the first run. Do not interpret successful rendering as evidence of learning.

## Review by notebook

| Notebook | What supports learning | Remaining risk and what to watch |
|---|---|---|
| 00: setup | A separate installation session, prepared project, one successful chunk, and one successful Knit | Installation may exceed thirty minutes. Test room computers beforehand and direct unresolved cases there. |
| 01: basics | One selection syntax first, a small visible vector, concrete table, prediction tasks, and separate missing-value examples | The 55-minute route now includes neurite transfer. Discuss scales and the supplied missingness example together, then let students adapt the neurite commands. |
| 02: plots | Matched histogram axes, all points on boxplots, a comparison with mean bars, and a supplied violin | The plot block is now 40 minutes, with hands-on histograms for all neurite conditions. Keep styling minimal and ggplot syntax optional. |
| 03: tests | Question before test, within-group diagnostics, output interpretation, required comparison of targets, and an overlap example | Small MMSE scores are strongly separated and bounded. Do not let agreement between tests obscure approximation limits or imply every biological dataset gives a clear result. |
| 04: investigation | Two questions only, explicit method choices, staged audit hints, a complete-case rule per analysis, and narrative beside outputs | A strong partner or LLM can still do the reasoning for another student. Use individual explanations and check actual selected-test output, not just a successful Knit. |
| 05: reference | Reusable commands without a new exercise burden | Students may use it as a test menu. Remind them to state the question and assumptions first. |

## Issues addressed during the second pass

- Made the two day 2 analysis choices explicit and left them blank in the template. A fresh template displays instructions rather than silently running a default inferential analysis.
- Added a completion warning: a rendered file with blank choices is not a completed notebook.
- Kept guidance in stages and supplied reference code without automatically completing the audit exercise.
- Checked all eight allowed group-method/correlation-variable/correlation-method combinations against direct R calculations.
- Verified the one-person-per-row preparation against preserved source values rather than relying on row counts alone.
- Improved day 2 histogram scaling so the distributions are visible while retaining common bins and axes.
- Included a pre-rendered violin to avoid an optional package blocking students.
- Distinguished missing values in the original visit-level dataset from the first-visit dataset, which has eight missing SES values and no missing MMSE scores.
- Preserved the limitations of the old data: synthetic scores in the small MMSE example, undocumented physical units for the synthetic neurites, and the source's longitudinal group selection in OASIS.
- Kept day 2 correction primarily as a separate worked exercise while acknowledging multiplicity in the exploratory independent work.
- Checked relative links and the student package; the extracted index does not link to an absent ZIP. Instructor answers and source archives are excluded.
- Disabled the unused MathJax dependency so the rendered teaching content does not need an internet connection. External reference links still need one.

## Suggested improvements for the next teaching run

### 1. Pilot the first hour with one or two genuine R beginners

**Why:** Someone familiar with R will miss the points where a novice does not know where to type, what a selected column is, or why an object is absent after restarting.

**How:** Ask a volunteer to open the project, run a chunk, import the CSV, select a group, and explain a summary while thinking aloud. Record where assistance is needed. If orientation takes longer than planned, replace repeated exercise commands with a supplied chunk before reducing normality/test discussion.

**Evidence to collect:** Can the learner perform the five orientation actions without the instructor taking over the keyboard? This is more informative than asking “Was that clear?”

### 2. Use a short concept check before and after the workshop

**Why:** A correct p-value can hide misunderstanding. The central learning outcomes concern what students think the test establishes.

**How:** Replace some existing opening and exit questions with the same three items: interpret a large Shapiro p-value, distinguish a mean comparison from a rank comparison, and distinguish correlation from causation. Ask for a reason, not just true/false. Keep it ungraded and brief.

**Evidence to collect:** Compare explanations, especially whether students stop treating normality as a binary permission slip for a test.

### 3. Add one brief transfer question if the core finishes on time

**Why:** Students may learn the MMSE example without recognising the same reasoning in another biological setting.

**How:** Use an oral scenario, not another dataset or full analysis: “We measured six cultures before and after treatment. Would today's independent-group commands fit?” Ask students to identify the observation unit and needed pairing information. This can replace an exit discussion and need not add a paired-test coding lesson.

**Evidence to collect:** Can students recognise a design change without being prompted by a function name?

### 4. Keep explanations individual

**Why:** Partners may share commands, but each student's final notebook should show their own understanding.

**How:** Students take turns explaining figures and method choices to one another, then write their own explanations. There are no instructor checks of individual plans, code, or results during the workshop.

**Evidence to collect:** Assess the explanations in each final submitted notebook. The final submission is the only instructor assessment.

### 5. Use the added practice to check transfer

**Why:** These notebooks already cover a substantial amount for eight hours. More tests or plots may reduce the time spent explaining the central ideas.

**How:** The expanded notebooks now let students repeat the same reasoning on MMSE and neurites. Collect the most common unclear points after day 1. If confidence intervals are the difficulty, replace a repeated calculation with a simple explanation contrasting individual spread and estimate uncertainty. If normality dominates every decision, return to the question-and-design worksheet. Keep ANOVA and chi-square as follow-on resources.

**Evidence to collect:** Fewer unsupported phrases such as “normal because p > 0.05”, “Wilcoxon compares means”, or “no effect because p > 0.05” in the final narratives.

## What this review could not establish

The HTML files were generated successfully, their embedded figures were inspected, and code/data/link checks were performed. The browser automation connection was unavailable, including after resetting it; full interactive browser layout, hint toggling, and RStudio operation were not verified through the UI. No students have piloted the notebooks yet. Before teaching, open the index and notebooks in the browser used in the computer room and complete Thursday's setup check on a student account.

## Breadth review after comparison with the original notebooks

Restored practical work on importing the neurite table, vector and table selection, three-condition summaries, repeated histogram views, common axes, three-condition boxplots, and transferring normality checks between datasets. Day 2 now includes a descriptive overview before inference. Empty chunks let students write and adapt commands, with supplied examples for reference.

Retained the clearer narrative and statistical safeguards. Did not restore row-by-row treatment differences between independent cultures, automatic test selection from Shapiro or a variance test, or fold-change exercises. Wide-to-long conversion uses base R; ggplot2 is the only optional plotting dependency. PDF export, pooled distributions, a second planned neurite comparison with correction, and a four-panel day 2 figure provide further work without extending the required list of statistical tests.

Main remaining risk: the expanded first afternoon is demanding for a complete beginner. The revised guide assigns 40 minutes to plotting and identifies exact demonstrations to shorten if the class falls behind. Pilot the first 55-minute notebook and the 40-minute plot block before fixing these times for future cohorts. Breadth should give students more chances to practise and explain, not require them to finish a checklist at speed.
