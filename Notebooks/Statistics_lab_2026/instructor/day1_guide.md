# Day 1 facilitator guide

Four hours including 25 minutes of breaks. Protect Missions 5 and 6 (assumptions and
the two-group comparison); shorten Gallery/Toolbox time first if the room is slow.
Day 1 is practice: nothing is knitted. The tutorial stays open all afternoon. At the
end each student types their name and clicks **Download my work** (Finish section);
the HTML file lists every code window with their code, every quiz answer and every
reflection, and can be handed in or kept. Progress is also remembered by the browser
on that computer, so a closed window loses nothing.

## Timing

The tutorial itself shows no times: students work at their own pace so that
nobody feels pressure to finish a mission in a given number of minutes. The
schedule below is for you. Each mission opens with a short "The ideas behind
this mission" theory subsection students can fall back to; every code window
that asks for a change (2 + 4 to 2 + 10, mean to median, 12 to 100, pearson to
spearman, ...) has a **Submit Answer** button that checks the change and says
what to fix, so pairs can self-correct without waiting for you.

| Elapsed | Min | Section | What every pair should have |
|---|---:|---|---|
| 0:00 | 15 | Welcome, retrieval questions, RStudio panes, LLM policy | Tutorial open, know where to type |
| 0:15 | 20 | Mission 1 | Ran, changed and repaired a command (the Console is busy running the tutorial, so the stuck-console / Esc rescue is not in the tutorial; show it on Day 2 when students work in the Console) |
| 0:35 | 20 | Mission 2 | Imported the table, selected a column and a group, named the observation unit |
| 0:55 | 20 | Mission 3 | Can say mean vs median, SD, IQR, what NA does |
| 1:15 | 15 | Break | |
| 1:30 | 20 | Mission 4 | Caption written for the boxplot; violin demo discussed |
| 1:50 | 30 | Mission 5 | Assumption reflection recorded **before** any test is run |
| 2:20 | 10 | Break | |
| 2:30 | 50 | Mission 6 | Result sentence with n, direction, points, CI, method, limitation; method comparison; overlap challenge |
| 3:20 | 15 | Mission 7 | Four-test Bonferroni table explained; family, survivors, unchanged estimates |
| 3:35 | 15 | Mission 8 | Correlation reflection |
| 3:50 | 10 | Finish | Workflow rebuilt from memory, exit ticket, work downloaded |

## Expected outputs (mmse_small.csv, unchanged values)

| Quantity | Control | AD |
|---|---|---|
| n | 10 | 10 |
| mean | 28.1 | 9.0 |
| median | 28 | 9.5 |
| SD | 1.20 | 2.45 |
| Q1, Q3 | 27, 28.75 | 7.25, 10.75 |
| IQR | 1.75 | 3.5 |
| Shapiro–Wilk | W = 0.82, p = 0.028 | W = 0.94, p = 0.58 |

- Welch: AD − Control = −19.1 points, 95% CI −20.96 to −17.24, t = −22.2, df = 13.1, p = 9.5e-12.
- Wilcoxon (exact = FALSE): W = 0, p = 0.00017. Complete rank separation.
- Talking point: the **control** group fails Shapiro (ceiling at 30, many ties) while AD does not. Use it to show that the test flags a bounded, tied sample rather than "bad data", and that a mechanical "p < 0.05 → Wilcoxon" rule is not reasoning.

Overlap challenge (neurites.csv, condition_1 vs control, independent-group assumption):
mean difference 0.430, 95% CI 0.273 to 0.587, p = 2.5e-06. Ranges overlap
(0.06–1.00 vs 0.41–1.41). Condition_2 vs control: difference 3.22, CI 1.76 to 4.69,
p = 0.00019, SD 3.1 (large, variable effect).

Bonferroni (Mission 7): raw 0.01, 0.03, 0.20 → 0.03, 0.09, 0.60 (m = 3). After the
students add protein_D = 0.04: 0.04, 0.12, 0.80, 0.16 (m = 4); only protein A survives.
Hand calculation quiz: 5 × 0.02 = 0.10.

Correlation example (seeded simulation): Pearson r = 0.75 (CI 0.53 to 0.87), Spearman rho = 0.77, n = 30.

## Common problems and the fix to demonstrate

| Symptom | Cause | Fix |
|---|---|---|
| Tutorial did not start when the project opened | `rstudioapi` missing and no internet, or an old RStudio | Run `source("setup.R")` in the Console, or open `day1.Rmd` → Run Document |
| "Where do I type?" | Tutorial vs Console | Show the map table in Welcome |
| `object not found` | Object created in another code window, or typo | Each window is self-contained; check spelling and capitals |
| Console shows `+` | Unfinished command | Esc |
| Tutorial occupies the Console | Run Document in the foreground | Launch it as a background job, or accept a busy Console |
| Submit Answer gives no feedback | The code produced a warning or error | Fix the code so it runs cleanly, then submit again |
| Wilcoxon warning about ties | `exact = TRUE` default | Keep `exact = FALSE` as supplied |
| Student closes the tutorial window | Progress is per browser; reopening restores the last attempts | Reopen via Run Document; explain that nothing is lost |

## Retrieval questions for the welcome

1. In a table with group, age and MMSE, what might one row represent?
2. What different things do a mean and a standard deviation tell you?
3. How would one extreme value affect a mean and a median?
4. How does measuring ten people twice differ from measuring twenty people once?
5. What can a correlation tell us, and what can it not?

## Checking the materials before class

```r
source("setup.R")                       # packages, files, and starts the tutorial
Rscript scripts/check_tutorial.R        # every chunk runs (from a terminal)
Rscript scripts/render_preview.R        # static HTML for the website
```
