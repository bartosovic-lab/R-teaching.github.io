# Presentation outline · statistics lab 2026

Three short talks, not one lecture. Students learn R by doing the tutorial, so every
slide deck ends with a keyboard action within 15 minutes. Timings follow the
facilitator guide. Speaker notes are in *italics*.

---

## Deck 0 · Setup session (Thursday, 30 min, optional slides)

Goal: everyone leaves with RStudio opening the tutorial once. No statistics.

1. **What you are installing** — R is the engine that computes; RStudio is the desk you sit at. Both free, both needed. *Install R first, then RStudio.*
2. **Download the Day 1 zip** from the course page. Unzip. Keep the folder together. *Show the folder contents once: the .Rproj is the door.*
3. **Open the project** — double-click `Statistics_lab.Rproj`. First launch installs packages (1–2 minutes). The tutorial appears; click Show in new window. *Walk the room; the only success criterion is "I see the tutorial".*
4. **If it did not start** — Console: `source("setup.R")`. Still nothing: raise your hand, or use a room computer on the day.
5. **Close everything and open it again** — the second time is the real test.

---

## Deck 1 · Day 1 opening (15 min, ~12 slides)

### Part A · Why you are here (4 min)

1. **Title** — *From a table to a biological story.* Two afternoons, one goal: take a small dataset, ask a clear question, plot it, run a suitable test, explain what it does and does not show.
2. **What this course is not** — not a programming course; no code from memory; no exam on syntax. Success = you can explain and justify a simple analysis using supplied code. *Say it twice; it lowers the anxiety in the room.*
3. **Retrieval, 3 minutes with your neighbour** — (a) In a table with group, age and MMSE, what is one row? (b) What do a mean and an SD tell you that the other does not? (c) One extreme value: what happens to the mean, to the median? (d) Ten people measured twice vs twenty people once: what is the difference? (e) What can a correlation tell you, and what can it not? *Collect two answers per question; do not correct much, the tutorial will.*

### Part B · R and RStudio in five slides (5 min)

4. **What R is, and why biologists use it** — free, open source, the language of the field (statistics, plots, RNA-seq, imaging). Reproducible: the analysis is a text file anyone can rerun. *One sentence on your own work: "every figure in our papers comes out of R".*
5. **Engine and desk** — R computes; RStudio is the window onto it. Screenshot of the four panes: editor (top left, files you keep), Console (bottom left, the `>` prompt, scratch space), Environment (top right, objects currently in memory), Files/Plots/Viewer/Help (bottom right).
6. **Where do I type?** — the question of the day. Today: in the tutorial's code windows. Console: quick tries, gone after restart. A script or notebook file: what you keep. *Point at each pane physically.*
7. **Four words of vocabulary** — object (`scores <- c(27, 28, 30)`), function (`mean(scores)`), argument (`mean(x, na.rm = TRUE)`), data frame (a table; `mmse$MMSE` picks a column). Everything today is a combination of these four.
8. **Errors are information** — `object not found` = misspelling or the creating line never ran. A `+` prompt = R is waiting for a bracket; press Esc. Red text is a message, not a verdict. *Demonstrate the Esc rescue live, on purpose.*

### Part C · How today works (5 min)

9. **The six questions** — What do we want to know? What is one row? What do the data look like? Which analysis answers the question? What does the output mean? What limits the conclusion? *These come back in every mission and on Day 2; put them on the wall if you can.*
10. **The route** — table of missions and times, breaks at 1:15 and 2:20. Missions 1–2 R basics and a first table; 3 typical and variable; 4 plots; 5 assumptions; 6 two groups; 7 many tests; 8 correlation. Toolbox/Gallery/Extras are optional.
11. **The rules of the game** — pairs: one drives, one predicts and explains, swap each mission. Predict → run → change → explain. Quizzes are practice. Hints before Solution. LLMs allowed for hints and explanations; you must be able to explain what you keep. Day 1 is not graded; at the end, Download my work.
12. **Go** — open the tutorial, Welcome section, first quiz. *Stop talking at minute 15.*

---

## Deck 2 · Day 2 briefing (15 min, ~10 slides)

### Part A · Recap (5 min)

1. **Yesterday in one picture** — the AD vs control boxplot with points; the Welch result sentence; the decision worksheet. *Ask: "what would change if the two groups had overlapped?" Recall the neurite challenge.*
2. **Retrieval** — (a) Shapiro–Wilk p = 0.6: what did you learn? (b) Welch vs Wilcoxon: what question does each answer? (c) Bonferroni: what changes, what does not? (d) A correlation of 0.4 across all patients: what should you check before believing it? *Two minutes, neighbours.*
3. **The worksheet, again** — question → independent observations → scale and sample size → plots per group → Shapiro as extra evidence → connect evidence to method → estimate with uncertainty. Today you apply it without the tutorial holding your hand.

### Part B · The dataset and the task (6 min)

4. **OASIS: real people, real scans** — 336 rows, two groups (Demented 146, Nondemented 190), age, education, socioeconomic status, MMSE, CDR, brain volumes. One slide on what MMSE and CDR are. *Say where the data come from (OASIS-2, Washington University) and that they are public.*
5. **Today's simplification** — each row is treated as an independent observation. In reality some rows are repeat visits of the same person. You will name this in your limitations. *This is the honest version of "we keep it simple".*
6. **Variable types before any statistics** — Group and sex nominal; SES and CDR ordinal (stored as numbers!); age, education, volumes numeric; MMSE a bounded score with a ceiling at 30. Nondemented scores sit at 26–30. *This slide prevents half of the wrong tests.*
7. **The notebook** — 32 questions in six blocks: exploration, descriptives, visualisation, statistical analysis, reflection, one bonus. Code in chunks, sentences outside. Knit early and often. *Show the notebook once: where the questions are, where to write.*
8. **What earns credit** — a plot that shows the observations, a test connected to the question, an estimate with its CI, a result sentence, a stated limitation, a Bonferroni table for your three tests. Not: the number of tests, the smallest p-value, the word "significant" on its own.

### Part C · Logistics (4 min)

9. **Working arrangement** — individual notebooks; discussing in groups is welcome; code and explanations you submit are your own. LLMs as yesterday: ask small questions, check column names, compare the explanation with the output, record one check in Q31.
10. **Timeline and submission** — download the Day 2 zip, open `Statistics_lab_day2.Rproj`, open `day2_mmse_tasks.Rmd`. Breaks at 1:15 and 2:45. From 3:40: put your name in the author line, Session → Restart R, Knit, open the HTML, upload to Canvas before you leave. *Say the deadline time out loud and write it on the board.*

---

## Backup slides (use only if needed)

- **When the tutorial does not start** — `source("setup.R")` in the Console; or open `day1.Rmd` and Run Document; or a room computer.
- **Reset progress** — Start Over link at the bottom of the tutorial's section list.
- **p-value in one sentence** — if there were truly no difference, how often would we see a result at least this extreme? It is not the probability that there is no difference.
- **CI in one sentence** — the range of effect sizes compatible with the data; not the range of individual values.
- **Why not pool the groups** — the pooled MMSE histogram is bimodal; the assumption check belongs within groups.
- **Ceiling effect** — the top of the scale cuts the distribution; healthy people all look alike at 29–30.
