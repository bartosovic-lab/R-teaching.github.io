# Instructor guide — When a neuron changes its response

## Aim and assessment

Students begin without R or statistics. Judge a defensible question, understanding of the
sample, a labelled figure, a justified group comparison, an association and a proportionate
conclusion. Do not assess typing speed or whether a result is significant. Work in pairs;
each student writes an individual integrated HTML report on day 2. Rmd is retained as source.

## Pacing: day 1, exactly 240 minutes

| Activity | Minutes |
|---|---:|
| Welcome and interface | 5 |
| Learnr sections 1–5: R and descriptive basics | 70 |
| Break | 15 |
| Learnr sections 6–8: plots and association | 35 |
| Download and RStudio handoff | 5 |
| Analysis notebook sections 1–2: recipe and diagnostics | 30 |
| Break | 10 |
| Welch estimate and uncertainty | 30 |
| Rank comparison and headline workshop | 20 |
| Correlation | 15 |
| Reproducible finish | 5 |

Day 2: question 20, selection 25, figures 30, break 15, group inference 35, association 30,
break 10, multiple testing 20, peer review/write-up/render 40, welcome/recap 15 = 240 minutes.
The notebook's sections account for 225 minutes; reserve the first 15 for recap and opening files.
Protect interpretation time. Extras are optional; shorten repeated plot practice if needed.

## Facilitation

Ask for a prediction before output. Swap typing/explanation roles after each mission. When
someone gets an error, ask them to read its first line and point to the object or bracket;
avoid taking over the keyboard. Show Source versus Console using one actual command.
Students retain examples and append solutions. Feedback checks code objects, not scientific prose.
Use the supplied hints without penalty. The histogram and violin controls are opportunities
to challenge apparent patterns, not to optimise a graph until it agrees with a hypothesis.

## Dataset-specific decisions

One row is one rat, summarised by the mean of its recorded cells. Baseline and acquisition use different rats, not the same rat measured twice. All core animals received the cue followed by reward protocol. In the original paper this protocol is called paired conditioning; that name does not mean our statistical samples are paired.

The core has 7 baseline and 6 acquisition rats, after averaging recorded cells within rat. The paper analyses cells differently; our pedagogical target is animal means. Paired conditioning is not a paired-sample design. Day-2 choices can have only 3 rats in one group; teach the uncertainty honestly. The NKCC1 extension has two blot batches and remains descriptive until matching and batch assumptions are established. A membrane voltage shift alone does not identify a molecular cause.

See the detailed data dictionary and raw-source checks. Never add noise, remove inconvenient
animals, or choose a protein after scanning p-values to create a more satisfying result.

## Reviewer checklist

Launch both variants separately, complete a few exercises (including one wrong answer), move
all sliders, write a note and download. Restart R, open the download in notebooks/, run and Knit.
Then try a day-2 choice. The default day-2 HTML is intentionally a draft and contains no
inferential results until choices are filled. Incomplete notebook exports mark missing tasks;
they never silently substitute instructor solutions.

The notebook export records slider settings as supplied reference figures. The outlier code
task records the student's chosen value. Prose is escaped so Markdown backticks cannot become
executable inline R. Written notes are session-only, so remind students to download before closing.

## Scope

The course design's core topics are retained. Chi-square/ANOVA remain optional future topics:
neither is added simply to tick a box for these two-group continuous outcomes. Nominal and
ordinal distinctions are taught using actual labels and an explicit ordinal example rather
than treating numeric assay measurements as ordinal scores. Independent animals remain a
design assumption, not an inference from a histogram. All introduced terms have plain-language
definitions in the student notebooks.
