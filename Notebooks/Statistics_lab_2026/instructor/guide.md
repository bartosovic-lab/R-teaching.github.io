# Instructor guide — A molecule, a mouse, and a memory

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
| Learnr section 9: biological replication investigation | 35 |
| Download and RStudio handoff | 5 |
| Analysis notebook sections 1–2: recipe and diagnostics | 30 |
| Break | 10 |
| Welch estimate and uncertainty | 30 |
| Reproducible finish | 5 |

Day 2: rank comparison 20, correlation 15 (return to notebook 03), question 15,
selection 20, figures 25, break 15, group inference 35, association 30,
break 10, multiple testing 20, peer review/write-up/render 35 = 240 minutes.
Protect interpretation time. Extras are optional; shorten repeated plot practice if needed.

## Facilitation

Ask for a prediction before output. Swap typing/explanation roles after each mission. When
someone gets an error, ask them to read its first line and point to the object or bracket;
avoid taking over the keyboard. Show Source versus Console using one actual command.
Students retain examples and append solutions. Feedback checks code objects, not scientific prose.
Use the supplied hints without penalty. The histogram and violin controls are opportunities
to challenge apparent patterns, not to optimise a graph until it agrees with a hypothesis.

## Dataset-specific decisions

One row is one mouse, using assay record 1 from that mouse. The original study measured each sample repeatedly; those repeated readings are not extra mice.

The fixed record-1 rule avoids pooling dilution levels and is independent of outcomes. This is an assay-record comparison, not a full abundance model. The first-day question fixes genotype and learning; day 2 retains all 72 animals with explicit subgroup choices. Discuss missingness and possible litter/cage dependence. Do not identify “BDNF changed” with “memory improved”.

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

## Day-1 highlight: more rows, more evidence? (35 minutes)

Allow 7 minutes to count rows and animals, 8 to follow one animal, 10 for the owner
reveal and copying experiment, and 10 to defend an animal-level analysis. Ask students
to predict before revealing owners or moving the slider. The reveal shows four animals
from one condition, not the whole dataset. Extra assay readings or cells can be useful,
but they do not create independent animals. Technical measurements at different dilution
levels are not interchangeable replicates. Treatment assignment, cage/litter and shared
experimental batches still matter even after counting unique animal IDs.

The copying demonstration deliberately violates independence: the mean and number of
animals stay fixed while the naive standard error decreases. Standard error describes
uncertainty in an estimated mean; it is different from SD, the spread of measurements.
The animal-level reference assumes independent animals and is not a guarantee that the
original design satisfies that assumption. Do not ask beginners to fit a multilevel model.
Require a written sample-size justification before proceeding to inferential statistics.
