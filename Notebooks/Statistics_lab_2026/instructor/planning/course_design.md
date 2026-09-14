# Statistics lab for master's students in neurochemistry

Working course design for discussion. This document describes the intended learning experience before the student notebooks are revised.

## 1. Purpose and audience

This workshop introduces statistical reasoning through hands-on analysis in R and RStudio. Students have no assumed experience with either tool and little prior training in statistics. The workshop runs over two afternoons, following a preparatory statistics lecture.

The central aim is that students can take a small biological dataset, ask a clear question, inspect and visualise the observations, perform a suitable simple analysis with support, and explain what the results do and do not show. R is the tool for developing that understanding and keeping a reproducible record. Fluency in programming is a longer-term goal.

The two days form one learning sequence:

- **Day 1: supported analysis.** The instructor models decisions and code, students modify worked examples, and the class interprets results together. A small Alzheimer's disease example connects the analysis to neurochemistry.
- **Day 2: increasingly independent analysis.** Students investigate a larger dementia/MMSE dataset, make and document analytical choices, use LLMs as an available source of assistance, and explain their findings.

Both days should repeatedly connect six questions: What do we want to know? What does one observation represent? What do the data look like? Which analysis addresses our question? What does the output mean? What limits our conclusion?

## 2. Agreed priorities and remaining decisions

The course runs for **four hours each afternoon, including breaks**. The main success criterion is that students can **explain and justify a simple analysis using supplied R code**. Writing code from memory is not an assessment goal.

| Decision | Current position | Consequence for the design |
|---|---|---|
| Afternoon duration | Agreed: four hours per day | Protect breaks and interpretation time within 240 minutes |
| Main success criterion | Agreed: explain and justify analyses using supplied code | Keep programming instruction minimal and provide reusable code |
| Statistical breadth | Core: distributions, normality assessment, test selection and group comparisons, correlation, multiple-testing correction | Reserve substantial time for assumptions and interpretation; chi-square and ANOVA are proposed follow-on topics |
| Visualisation | Core: histograms, scatterplots, boxplots, and violin plots; violin plots are instructor-led demonstrations | Students practise the other plots and interpret all four; shorten customisation and repeated coding first |
| Working arrangement and assessment | Agreed: work in pairs; each student submits one integrated notebook containing code and their own narrative | No separate written report; students explain what they did and why |
| LLM use | Agreed: freely available for support, especially debugging, hints, and in-depth concept explanations; students must understand their work | Teach verification and require students to explain the code and reasoning they retain |
| Dataset strategy | Agreed: preserve existing values wherever possible and improve the guidance | Retain the small MMSE example; recommend a documented first-visit subset for the larger dataset |
| Contrasting example | Agreed: retain the clearly separated small MMSE groups and add a short exercise using existing data with more overlap | Compare distributions, effect magnitude, and uncertainty without changing measurements |
| Ambiguous test choice | Agreed: students compare Welch's t-test and Wilcoxon rank-sum and explain their different questions | Make the comparison required; reduce repeated calculations and plotting practice to protect discussion time |
| Day 2 workload | Agreed: one group comparison and one correlation; correction taught mainly through a separate worked example | Protect time for assumptions, interpretation, and individual narrative rather than requiring a third analysis |
| Technical preparation | Agreed: a 30-minute Thursday installation session, with computer-room machines available as a fallback | Check R, RStudio, project access, and notebook rendering before the workshop |

The schedules below are recommended allocations within the agreed duration. The first-visit subset is a proposed implementation of the preference to preserve existing values; no source datasets have been changed.

## 3. Proposed learning objectives and how students achieve them

Objectives describe observable actions. Normality assessment, justified test selection, and interpretation are the central objectives; the other core skills enable them.

| Learning objective | Day 1: supported practice | Day 2: independent application | Evidence of understanding |
|---|---|---|---|
| Explain what a row and a column represent | Identify the observation, group, measurement, and unit in a small table | Describe the MMSE dataset's observation unit and retained variables | A short dataset description distinguishes people, visits, and measurements |
| Recognise numeric, nominal, and ordinal variables | Classify group, MMSE, age, and a categorical rating; distinguish stored type from scientific meaning | Choose summaries and plots for age, education, MMSE, and SES | Student explains why a number-coded category need not be continuous |
| Run and adapt a simple reproducible R analysis | Open a project, run code in order, create an object, import a CSV, inspect a data frame | Reuse the same workflow with a different dataset | Analysis runs from a fresh session using relative paths |
| Identify missing values and basic data-quality issues | Demonstrate `NA`, count observed values, and inspect plausible ranges | Report missingness and analysis-specific sample sizes | Student states what was excluded, why, and how many observations remain |
| Describe centre and spread | Predict and calculate mean, median, SD, quartiles, and IQR; change one example value | Summarise relevant variables overall and within groups | Student connects the chosen summary to distribution shape and variable meaning |
| Choose and interpret informative visualisations | Build a histogram and boxplot with points; compare with a violin and a mean-only bar chart; introduce a scatterplot | Create labelled plots that answer the chosen questions | Each plot has a caption describing a pattern and a limitation |
| Assess assumptions without relying on one automatic rule | Inspect within-group distributions and Q–Q plots, then interpret Shapiro–Wilk alongside them | Justify the analysis using design, plots, sample size, and measurement scale | Student does not equate a non-significant normality test with proof of normality |
| Compare two groups and interpret the result | Formulate a question, compare Welch and Wilcoxon using supplied code, and explain their different targets and assumptions | Select and justify a primary group comparison using the day 1 reasoning | A result includes direction, magnitude, sample sizes, method, uncertainty where available, and limitations; method choice is not determined by the smallest p-value |
| Investigate an association between numeric variables | Predict the direction of a scatterplot association and introduce correlation | Analyse a chosen association, such as age with MMSE or nWBV with MMSE | Student explains the coefficient and distinguishes association from causation |
| Recognise repeated observations and dependence | Contrast separate people with repeated visits or cells from the same culture | Check that the provided core dataset has one row per participant | Student explains why more rows do not necessarily mean more independent samples |
| Account for multiple testing | Flag the problem of trying many questions when introducing test results | Interpret raw and Bonferroni-adjusted p-values in a separate guided example | Student explains which tests were adjusted together and why, without needing extra independent analyses |
| Use assistance critically | Instructor models checking a suggested command against the data and its output | Student checks LLM-generated code and explanations | Student can explain a retained suggestion and a correction or verification step |
| Communicate a defensible conclusion | Complete a result sentence and critique an exaggerated claim together | Write or present a concise evidence-based account | Conclusion answers the question without overstating significance, causality, or generalisability |

## 4. Scope and cognitive load

### Proposed essential R skills

Keep the recurring vocabulary small: assignment with `<-`, vectors with `c()`, functions and arguments, data frames, column selection with `$`, logical selection, missing values, and simple plotting commands. Reuse the same patterns across datasets.

Students need to understand that the script or notebook is the saved recipe, while objects in the Environment are temporary working results. Explain the roles of the source editor, Console, Environment, and plot/help panes by using each for a task.

Use one project structure and one path convention throughout. A proposed student project contains `data/`, `notebooks/`, and `outputs/`. Set the notebook execution root explicitly to the project root so that both interactive execution and rendering use paths such as `data/mmse_small.csv`. Test these instructions on a clean student copy before teaching.

Use base R for the core unless we agree that learning `ggplot2` is itself a priority. This reduces installation and syntax overhead. An optional visualisation section can show how the same information is represented in `ggplot2`.

Teach violin plots through an instructor-led demonstration using a tested `ggplot2` chunk. Students compare and interpret the display without needing to write or modify its code. Provide the example and its rendered figure for reference; student installation of `ggplot2` is needed only if they choose to rerun it. Teaching the grammar of graphics or rewriting all base R examples in a second syntax is unnecessary. The core skill is interpreting the violin correctly.

### How much R background is enough?

**No prior R knowledge is required.** Use the available **30-minute Thursday installation session**, separate from watching the lecture, to install and check R and RStudio. Supply a prepared project and notebook. Students can also use the computer-room machines. Installation problems may take longer than the session, so make that fallback explicit rather than consuming the first workshop's teaching time.

Allocate **about 50 minutes of day 1 to initial R confidence**: five minutes establishing the interface and project during the welcome, followed by 45 minutes of guided practice. Then teach commands as needed during the statistical exercises. This is a planning estimate, not a guarantee that every student will feel confident after a fixed time.

| Orientation activity | Suggested time | What the student should achieve |
|---|---|---|
| Find the editor, Console, Environment, and plots; open the prepared project | 5 minutes during the welcome | Know where to type, where results appear, and where work is saved |
| Run a line and a chunk; distinguish code from narrative | 10 minutes | Run supplied code without copying the Markdown fences into the Console |
| Create a small object and use a function | 10 minutes | Explain `scores <- c(...)`, `mean(scores)`, and an argument such as `na.rm` |
| Import and inspect the teaching data | 15 minutes | Identify the table, rows, columns, and a selected variable using `$` |
| Change one command, practise one common error, and rerun | 10 minutes | Change a variable or label, recognise a misspelling, and recover with help |

Avoid an introductory tour of every R feature. Teach one way to select a column first; additional indexing syntax can wait until it is needed. Use meaningful object names, visible code, short chunks, and adjacent plain-language explanations. Provide selection and plotting templates rather than requiring students to construct them from memory.

At the end of the orientation, each student should be able to run a chunk, select a column, change a function argument, locate the result, and save the notebook. If several pairs cannot do this, spend another ten minutes on supported practice and shorten visual styling or duplicate exercises. Protect the normality and test-interpretation sections.

Confidence should build through successful small actions: instructor runs one example, students change one element, then a partner explains the result. Introduce errors as ordinary information. Demonstrate `object not found` using a misspelled name, and show how rerunning the object-creation chunk or correcting the spelling resolves it. Students should not be asked to debug multiple unrelated syntax problems while learning a new statistical concept.

On day 2, retain the command reference, working import chunk, plot templates, and hints. Remove completed interpretations and preselected analysis decisions progressively; there is no need to remove code support to make the investigation independent.

### Proposed extensions

Extensions include multi-group comparisons, chi-square/Fisher's exact tests, paired analyses, and additional visualisation styles. Bonferroni correction and the four requested plot types are core. ANOVA and chi-square are proposed follow-on material rather than requirements within the two afternoons.

Vector recycling, extensive reshaping, ridge plots, programming loops, custom functions, regression modelling, and transcriptomic analysis need not occupy core practice time. They can remain available as follow-on resources. Students should first leave with a usable analysis workflow and an ability to interpret it.

## 5. Preparation before day 1

### Student preparation

Students watch the assigned lecture and complete a short retrieval exercise. Installation instructions and a minimal setup check should be supplied ahead of time. Watching the lecture should be the conceptual preparation; students should not be expected to independently learn R before the workshop.

Suggested retrieval questions:

1. In a table containing group, age, and MMSE, what might one row represent?
2. What different information do a mean and a standard deviation provide?
3. How could one extreme value affect a mean and a median?
4. How does measuring ten people twice differ from measuring twenty people once?
5. What can a correlation tell us? What can it not establish?

Use answers to identify starting points, rather than as a prerequisite knowledge test. Technical preparation takes place in the Thursday session, with computer-room machines available for students whose laptops are not ready.

### Thursday setup session: 30 minutes

Keep this session focused on access and a successful first run. It is not an additional statistics lesson or a prerequisite programming course. Send installation links and the prepared project beforehand so students can start downloads early if they wish.

| Time | Task | Completion check |
|---|---|---|
| 0–5 minutes | Explain that R runs the analysis and RStudio provides the working interface; identify laptop versus room-computer plans | Each student knows which machine they will use |
| 5–15 minutes | Install R first, then RStudio, with help available | RStudio opens with a working R session |
| 15–25 minutes | Open the prepared project and notebook; install required notebook packages; run a small supplied chunk and render the example | Output appears, the notebook renders, and a file can be saved |
| 25–30 minutes | Confirm where the files are stored, repeat the opening procedure, and identify unresolved problems | Each student has a working setup or a clear computer-room fallback |

The instructor should test the room computers in advance using a student account: R and RStudio availability, required notebook packages, rendering support, access to the course files, and permission to save work. Check how students retain or export their individual notebook when they leave the room. LLM access is optional; if an account or connection fails, supplied hints and instructor assistance remain available.

Do not promise every laptop installation will finish within thirty minutes. Record unresolved issues and direct affected students to a tested room computer for the workshop. Student installation of optional plotting packages is unnecessary for an instructor-led violin demonstration. At the start of day 1, use only a brief readiness check; avoid troubleshooting installations in front of the whole class.

### How the lecture connects to the workshop

The supplied [lecture transcript](lecture.txt) covers reproducibility, measurement scales, distributions, summary statistics, tests, multiple comparisons, and correlation. The workshop should revisit these concepts through decisions about actual data, rather than repeat the lecture as another long presentation.

Some transcript passages need clarification in a short companion note and in the teaching. The transcript contains repetition and apparent transcription problems, so check the recording before changing the lecture itself.

| Topic in the transcript | Clarification to teach |
|---|---|
| Boxplots presented chiefly as a tool for non-normal data | Boxplots can describe many distributions. In R's default convention, whiskers extend to the most extreme observations within 1.5 IQR of the hinges; points beyond them are displayed separately. They are not automatically erroneous observations. |
| Normality presented as the first gate to selecting a test | Begin with the scientific question, study design, and variable types. Inspect relevant group distributions or model errors; a pooled distribution can be misleading. |
| A normality-test result treated as a distribution verdict | Failure to reject normality does not establish it. Small samples provide limited information; large samples can reveal minor departures. |
| Student's t-test and unpaired t-test treated as interchangeable labels | Explain independent versus paired designs separately from equal-variance versus Welch methods. |
| Non-significance described as no difference | Explain that insufficient evidence of a difference is not evidence that groups are equivalent. |
| Larger samples described as automatically resolving a result | More independent observations can improve precision, but cannot repair bias, confounding, or an invalid design. |
| Repeated pairwise tests following an ANOVA | An omnibus test does not remove multiplicity from subsequent comparisons. Define and report the comparison family. |

The [R boxplot documentation](https://stat.ethz.ch/R-manual/R-devel/library/graphics/html/boxplot.html), [Shapiro–Wilk documentation](https://www.stat.ethz.ch/R-manual/R-devel/library/stats/html/shapiro.test.html), and [t-test documentation](https://stat.ethz.ch/R-manual/R-devel/library/stats/html/t.test.html) provide implementation references for these demonstrations.

## 6. Day 1: supported analysis

### Recommended four-hour schedule

Times are relative to the start. For a 13:00 start, the session ends at 17:00. Both days include 25 minutes of breaks and 215 minutes of activities.

| Elapsed time | Minutes | Activity and minimum outcome |
|---|---:|---|
| 00:00–00:15 | 15 | Welcome, retrieval questions, and five-minute RStudio/project introduction |
| 00:15–01:00 | 45 | Guided R orientation; each student runs and modifies supplied code |
| 01:00–01:20 | 20 | Mean, median, SD, quartiles, IQR, and missing-value demonstration; use a supplied summary chunk |
| 01:20–01:35 | 15 | Break |
| 01:35–01:55 | 20 | Small MMSE dataset; prepared histogram and boxplot exercises; instructor-led violin demonstration |
| 01:55–02:25 | 30 | Within-group histograms, Q–Q plots, and Shapiro–Wilk; write an assumption assessment |
| 02:25–02:35 | 10 | Break |
| 02:35–03:35 | 60 | Two-group analysis and output interpretation; required Welch–Wilcoxon comparison; eight-minute overlap exercise |
| 03:35–03:50 | 15 | Worked scatterplot/correlation example and transition to day 2 |
| 03:50–04:00 | 10 | Save/rerun, exit questions, and explain the next day's task |

Keep instructor talk in short sections, typically five to ten minutes before a student action. The 60-minute analysis block includes a first worked analysis, a required comparison of methods, the overlap example, and written interpretation. An additional fifteen minutes has been allocated to this block by removing five minutes of repeated summary calculations and ten minutes of plotting/customisation practice. Retain the concepts through supplied code and figures. The agreed fallback is to retain all four plot types, demonstrate violin plots, and shorten further repetition before cutting reasoning practice. Preserve the allocated normality, test-choice, and interpretation time. Axis labels, units, and readable displays remain essential; decorative changes do not.

### Teaching pattern

Use short cycles of **predict → demonstrate → modify → explain**. Before running a command, ask students what they expect. After the demonstration, they change one meaningful element and describe what changed. Alternate short instructor explanations with time at the keyboard.

Each section should identify a minimum task, one interpretation question, a staged hint, and an optional extension. Worked answers should support feedback after students have attempted the question.

### Block A: a first successful analysis

**Question:** How can we turn a small table of measurements into a saved, reproducible result?

The instructor introduces the RStudio panes through a tiny example, then helps students open the project and import a CSV. Students run `head()`, `dim()`, `names()`, and `str()` and connect those outputs to the table they can see.

Keep the neurite example brief if retained. Its purpose here is to make a vector, a group, and a measurement concrete. Do not introduce several competing data organisations before students have completed their first successful import.

**Student self-check:** Every student can locate the saved analysis, run a line, and explain what an object and a row represent. Pause to resolve setup problems before moving into statistics.

### Block B: centre, spread, and variable meaning

**Question:** What does a typical observation look like, and how much do observations vary?

Use a small visible set of values to calculate mean, median, SD, quartiles, and IQR. Ask students to predict what happens when one value becomes much larger, then run the calculation. Keep this altered vector explicitly separate from the original dataset.

Connect the arithmetic to interpretation: SD describes spread among observations; a standard error or confidence interval concerns uncertainty in an estimate. A confidence interval is not an interval expected to contain 95% of individual scores.

Introduce a deliberately missing value in a separate demonstration. Compare the result with and without `na.rm = TRUE`, and report the observed sample size. Explain why silently removing missing values is not a complete data-cleaning strategy.

**Student self-check:** Students choose a summary for a skewed example and explain what information is lost by reporting only a mean.

### Block C: the small Alzheimer's disease example

**Question:** How do the MMSE score distributions differ between the two groups in this teaching example?

Introduce the small MMSE table already present in the Excel workbook. Explain the score's bounded scale, identify the groups, and describe the analysis as an educational comparison. The instructor has confirmed that these are synthetic teaching data, not actual patient measurements.

Students calculate summaries by group and create a histogram and a boxplot with individual points. Compare a mean-only bar chart with a plot showing all observations. With ten observations per group, point displays should remain central.

Explain that two columns of equal length do not establish pairing. In this synthetic example, the twenty entries represent separate individuals.

**Student self-check:** Each student produces a labelled figure and a two-sentence description of the group difference and within-group variation.

### Block D: from a plot to a statistical comparison

**Question:** What exactly are we comparing, and what additional information does a test provide?

Write the question and target quantity before selecting a test. A mean difference answers a question about average scores. A rank-based comparison addresses a different aspect of the distributions and should not be presented as an interchangeable test of means.

Demonstrate histograms, Q–Q plots, and Shapiro–Wilk within groups. Students record what each contributes and what remains uncertain. Avoid an automatic “Shapiro p below 0.05 means Wilcoxon, otherwise t-test” recipe.

For an introductory mean comparison under a suitable independent-observation teaching design, demonstrate Welch's t-test, which is R's default two-sample t-test. Do not require a preliminary variance test to decide between pooled and Welch methods. For the bounded, small MMSE example, explicitly discuss approximation limits and require students to compare the Welch analysis with Wilcoxon rank-sum using the same observations. This is a lesson in the analysis question and assumptions, not a search for the smallest p-value. See the [R t-test reference](https://stat.ethz.ch/R-manual/R-devel/library/stats/html/t.test.html).

Explain that Wilcoxon rank-sum uses ranks and is not generally a direct test of a difference in medians without additional distributional assumptions. Tied MMSE values also affect the computation; the notebook should specify the method used and be checked against the installed R version. See the [R Wilcoxon reference](https://stat.ethz.ch/R-manual/R-devel/library/stats/html/wilcox.test.html).

**Required paired discussion, approximately fifteen minutes within the analysis block:** Supply both commands and a comparison table to complete. Use the same group order and observations for both methods. Students first explain what each method asks, then interpret the outputs.

| Prompt | What students should explain |
|---|---|
| What question does Welch address? | Whether the population means differ; estimate the difference in the original measurement units and interpret its confidence interval. |
| What question does Wilcoxon address? | Whether one group tends to have higher ranked values under the rank-sum framework. A simple location-shift or median interpretation needs additional assumptions; it is not a universal test of every distributional difference. |
| What do the plots and Shapiro results contribute? | Evidence about shape, bounds, ties, and extreme observations, with sample-size limitations. They inform the reasoning but do not decide which scientific question matters. |
| If both methods give small p-values, what follows? | The analyses provide evidence for their respective questions under their assumptions. Agreement does not prove normality, validate independence, or make the tests interchangeable. |
| If the methods disagree, what should we do? | Revisit the question, distributions, influential values, and assumptions; report the discrepancy. Do not select the smaller p-value. |
| Which method would you lead with, and why? | State the intended target, justify a primary method, and acknowledge what its conclusion does not establish. A defensible explanation matters more than matching a predetermined test label. |

Use an explicitly hypothetical disagreement question if the existing data produce agreement; do not change values to manufacture conflicting results. Each student writes two or three sentences comparing the methods after discussing them with their partner. On day 2, students use this reasoning to choose a primary comparison before examining its p-value; running every possible test is not the goal.

Annotate the test output together: method, group order, sample summaries, statistic, degrees of freedom where relevant, p-value, and confidence interval where provided. Use a consistent subtraction direction such as AD minus control. For MMSE, a difference in score points is more interpretable than a fold change; a score of twenty does not mean twice the cognitive ability of a score of ten.

**Student self-check:** Complete a result sentence with sample sizes, effect direction and magnitude, uncertainty, and one limitation. Explain a p-value as a probability of a result at least as extreme under the null model and assumptions, rather than the probability the null hypothesis is true. Statistical significance alone does not express effect size or biological importance. This interpretation follows the [ASA statement](https://magazine.amstat.org/blog/2016/03/07/pvalue-mar16/).

### Short contrasting exercise: overlapping observations

Keep the small MMSE example as the first worked comparison. Within the 60-minute analysis block, reserve approximately **eight minutes** for a contrasting example using `control` and `condition_1` from the existing synthetic neurite CSV. These columns contain twenty values each and have overlapping observed ranges: approximately 0.064–0.999 and 0.411–1.414, respectively. Keep all original values and provide the plot and analysis code so students do not repeat the import and plotting workflow.

For this synthetic teaching exercise, explicitly assume independent observations across the two groups; column alignment does not imply matched measurements. Verify and document measurement units before labelling the final figure. This assumption is part of the teaching scenario, not a recovered experimental design.

Suggested sequence:

1. **Two minutes:** Inspect individual-point and box plots. Describe how the overlap differs from the small MMSE example and predict whether overlapping observations rule out a difference in means.
2. **Three minutes:** Inspect supplied Welch output. Identify the mean difference and its confidence interval, and distinguish variation among observations from uncertainty in the estimated mean difference.
3. **Three minutes:** Discuss why overlapping observations can coexist with evidence of a group mean difference. Write one limitation of using a group average to describe an individual observation.

Instructor reference, calculated from the unchanged CSV under that independent-group assumption: the mean difference, condition 1 minus control, is approximately **0.430**, with a **95% confidence interval of 0.273–0.587** and **p ≈ 0.00000247**. This example illustrates overlap and estimation; it is not a non-significant example. Do not suggest that overlapping observations imply a confidence interval containing zero, or that uncertainty disappears when a p-value is small.

Use this as an interpretation exercise in place of repeated coding or cosmetic plot changes, rather than adding time to the afternoon. Do not compare the numerical sizes of MMSE differences and neurite differences directly, because the measurements have different scales and units.

### A practical framework for normality and test choice

Give students a short decision worksheet and use the same worksheet on both days:

1. **State the question.** Are we comparing average scores, comparing ranked distributions, or studying an association?
2. **Identify independent observations.** Separate participants support an independent-group comparison. Repeated observations from the same participant require a different approach. A normality test cannot establish independence.
3. **Inspect the scale and sample size.** MMSE is bounded and has ties; check for a ceiling. Examine each comparison group rather than relying on the pooled sample.
4. **Inspect the histogram and Q–Q plot.** Describe symmetry, skew, tails, extreme observations, and uncertainty from a small sample. Similar mean and median alone do not establish normality.
5. **Use Shapiro–Wilk as additional evidence.** State its null hypothesis and interpret its p-value cautiously. With very few observations it may miss departures, and with many observations it can detect departures that are not decisive for a particular analysis.
6. **Connect the evidence to the method.** Explain why the chosen test answers the question and why its assumptions are reasonable enough, or explain why a different question/method is needed. Do not choose whichever method returns significance.
7. **Interpret the estimate and uncertainty.** Report the result in the variable's units or as the relevant coefficient, alongside the test output and limits.

For this introductory course, students should recognise the following choices without memorising a comprehensive catalogue of tests:

| Situation | Method to discuss | Reasoning students should articulate |
|---|---|---|
| Two independent groups; question about means | Welch's t-test | Appropriate question and independence; consider small-sample departures, skew, and extreme values. Equal variances are not required. |
| Two independent groups; rank/distribution comparison is appropriate | Wilcoxon rank-sum | Rank-based question, independent observations, and tied values; it is not an automatic substitute for a test of means. |
| Two numeric variables; question about a linear relationship | Pearson correlation | Inspect the scatterplot and influential points. Distinguish calculating the coefficient from the assumptions needed for its usual inference. |
| Numeric or ordered measurements; question about monotonic association | Spearman correlation | Rank-based association; assess shape and ties. It does not detect every possible nonlinear relationship. |

Ask students to write: “I inspected ___; I observed ___; I chose ___ because ___; an important limitation is ___.” A strong answer can acknowledge ambiguity. Normality should be a substantive reasoning exercise, not a pass/fail label assigned to the entire dataset.

### Visualisation exercises and further biological applications

The four required plot types should each have an interpretation task. Students practise histograms, boxplots, and scatterplots using supplied code; violin plots are demonstrated by the instructor with a short class interpretation question. Spend time reading the data rather than customising themes.

| Plot | Core exercise | Essential interpretation |
|---|---|---|
| Histogram | Compare two bin choices for the same MMSE or age values; use matched axes/bins when comparing groups | Binning changes appearance. Describe centre, spread, skew, and ceiling effects; a bell-like outline is not proof of normality. |
| Boxplot with individual points | Identify median, middle half, whiskers, and separately displayed observations | The box describes the middle half of the data; the default whiskers are not necessarily the minimum and maximum. Check the individual points and sample size. |
| Violin plot with individual points | Instructor demonstrates a violin beside a boxplot of the same variable; students explain what the smooth shape adds and might obscure | Width represents an estimated density, not individual observations or uncertainty. With ten values per group, smooth shapes can imply more detail than the data support. |
| Scatterplot | Plot a selected pair of variables, then colour by group and compare the interpretation | Describe direction, form, clustering, and influential observations. Group separation and confounding can affect an overall association. |

Show violin and box plots side by side using prepared code. For bounded/discrete MMSE scores, point out that smoothing may suggest values between observed scores or outside the scale unless the plotting settings constrain it; the individual observations remain important.

Useful follow-on plot suggestions for neurochemistry and biology students:

- **Dot/strip plots:** show all independent samples in small experiments, such as protein-abundance measurements.
- **Paired dot or connected-line plots:** show within-person or within-experiment change when the same units are measured twice. Connections must reflect actual pairing.
- **Time-course plots:** show trajectories across time and distinguish individual trajectories from a group summary.
- **Effect plots with confidence intervals:** compare estimated treatment effects and their precision without reducing results to significance stars.
- **Dose–response plots:** show a biological response across concentrations; log concentration axes and curve fitting can be introduced in the receptor-ligand lab.
- **Heatmaps:** provide an overview of many genes or proteins, with explicit explanation of colour scales and any row scaling.

These are suggestions for later use, not additional required exercises. Wherever error bars appear, label whether they represent SD, SE, or a confidence interval.

### Block E: bridge to independent work

Introduce a scatterplot and the distinction between a linear association and a monotonic association. Students should encounter one worked correlation example before day 2. A labelled simulation can provide a clear pattern without attributing invented measurements to patients.

End by asking students to reconstruct the workflow from question to conclusion. Demonstrate one instance of checking LLM assistance: confirm column names, inspect the suggested code, run it, and assess whether the explanation matches the output.

**Exit questions:** What can you now do in R? Which analysis decision still needs help? Why could a successful command still produce an inappropriate analysis?

## 7. Day 2: independent investigation with support available

### Recommended four-hour schedule

| Elapsed time | Minutes | Activity and minimum outcome |
|---|---:|---|
| 00:00–00:15 | 15 | Retrieval, normality/test-choice recap, and paired-work briefing |
| 00:15–00:35 | 20 | Separate worked multiple-testing example; define a family, apply Bonferroni correction, and answer a short interpretation question |
| 00:35–00:55 | 20 | Import, observation-unit check, missingness, and data description |
| 00:55–01:15 | 20 | Select questions and record the plan; partner discussion |
| 01:15–01:30 | 15 | Break |
| 01:30–02:20 | 50 | Group plots, normality/assumption assessment, justified comparison, and interpretation |
| 02:20–02:45 | 25 | One scatterplot and one correlation analysis using a supplied template |
| 02:45–02:55 | 10 | Break |
| 02:55–03:05 | 10 | Challenge an initial conclusion and discuss a limitation |
| 03:05–03:40 | 35 | Write the narrative within the notebook and compare reasoning with a partner |
| 03:40–03:55 | 15 | Restart, rerun, and check reproducibility and completeness |
| 03:55–04:00 | 5 | Individual exit explanation and submission instructions |

Require **one group comparison and one correlation**. A manageable default is an MMSE comparison between groups plus either age–MMSE or nWBV–MMSE correlation. Students choose one association, not both, and record the questions before inspecting test p-values. Alternative questions are welcome if they retain this workload and the same learning objectives. Multiple-testing correction is taught through the separate worked example, so students do not need a third independent analysis merely to practise adjustment.

For the independent notebook, frame the two selected analyses as a limited exploratory exercise and report both regardless of outcome. Teaching correction separately does not remove multiplicity from the students' own work. Ask them to acknowledge this limitation; if they make a joint claim of finding an effect in either analysis, provide the two-test adjustment as a supplied optional application. Do not encourage a search through many additional variables or methods. Normality checks support assumption assessment rather than being additional scientific discovery claims to count mechanically in the same family.

The writing allocation assumes a compact notebook completed progressively, not a polished manuscript. Allow minor completion after class if needed; the required analysis should fit within the afternoon. Do not add further statistical topics merely because the supplied code makes them quick to run.

### Starting brief

Students receive a dataset, a data dictionary, a notebook framework, the day 1 reference material, and an agreed policy for LLM use. The core dataset should have one observation per person so that beginners can use the simple methods they have learned without introducing a longitudinal model.

Independence means making and explaining choices using available resources. It should not mean discovering undocumented variable definitions or struggling with unfamiliar file paths.

### Stage 1: understand and audit the data

Students report the number of participants and variables, check identifiers, classify selected variables, count missing values, inspect plausible ranges, and summarise the groups. They distinguish all available participants from the participants contributing to each analysis.

**Support:** A checklist and function names are available. Full completed code is reserved as a later hint if needed.

**Milestone:** A short data description and one issue worth remembering during analysis.

### Stage 2: choose questions and record a plan

Offer a small menu instead of unrestricted exploration of every column. Potential questions include:

- How does the MMSE distribution differ between the supplied participant groups?
- Is age associated with MMSE in this sample?
- Is normalised whole-brain volume associated with MMSE?
- Do the groups differ in age or educational attainment, and how might that complicate interpretation?

MMSE versus group is a useful familiar comparison, but students should understand that cognitive assessments and clinical classification are related. It is not an independent validation of a diagnostic test.

Before generating test results, students write the outcome, comparison or association, unit of observation, proposed plot, relevant missing-data rule, and provisional method. They can revise the plan after inspecting assumptions, but record why.

**Self-check:** Students compare their chosen method with their written question and discuss it with their partner before continuing. No instructor review is required.

### Stage 3: explore, analyse, and interpret

Students first make the relevant plot and summaries, then perform the agreed analysis. Correlation should include its coefficient, direction, sample size, plot, and limitations; a p-value alone is insufficient. Spearman correlation describes monotonic association and does not require marginal normality, but it still requires an appropriate sampling/design interpretation. See the [R correlation reference](https://www.stat.ethz.ch/R-manual/R-devel/library/stats/html/cor.test.html).

For pooled associations, encourage students to consider whether groups occupy different parts of the scatterplot. A group-coloured plot can introduce confounding without making multivariable regression a requirement. Age, education, group, and sampling can all complicate a causal interpretation.

Any missing observations should be handled for the variables required by that analysis. Students should not remove every row with an SES value missing before analysing age and MMSE. Complete-case analysis can still introduce bias; reporting exclusions does not eliminate that limitation.

**Support:** Provide three levels of help: a conceptual question, a function hint, and a partial worked example. Students can ask an instructor or LLM while remaining responsible for their interpretation.

### Stage 4: challenge the conclusion

Ask students to investigate one challenge to their initial account. For example: Does a mean-only figure hide the score ceiling? Does a correlation reflect group separation? How would the claim change if the same person contributed several rows? Would removing an unusual point be scientifically justified?

This stage should deepen an existing analysis rather than require another large set of tests. Students must not remove observations simply to improve normality or significance.

### Stage 5: communicate and reproduce

The agreed submission arrangement is **one integrated notebook per student**, developed while working in pairs. It contains code, figures, a data description, selected questions, justified analyses, results, conclusions, and limitations. A separate report is unnecessary. Partners can share code and discuss decisions, while each student writes their own explanation of what was done and why.

Use a compact completion checklist: a data audit; one planned comparison and one planned association; histogram/Q–Q evidence and an assumption assessment for the group comparison; a justified primary group test; one scatterplot and correlation result; and conclusions with limitations. Include a short interpretation of the separate multiple-testing example, with its supplied raw and corrected p-values. Applying correction to the independent analyses is not a separate required exercise. Violin-plot understanding is checked during the day 1 demonstration; generating a violin is not a submission requirement. Avoid requiring redundant final figures. Narrative can consist of a few sentences beside each important output.

Students restart R and rerun the notebook in order. Alternate keyboard and explanation roles during paired work; both students should run the analysis on their own copy. Use a brief individual explanation to establish that both understand the analysis.

Suggested discussion prompts: Which figure best supports your conclusion? What did the test add? What assumption mattered most? What would you need before making a causal claim?

## 8. LLM use: support with understanding

Students may freely use LLM assistance, especially for debugging, hints, and detailed explanations when a concept is unclear. They must understand what the analysis does and why. The notebook narrative is their own explanation; copying a correct-sounding answer does not establish understanding.

A useful prompt includes the question, column names and meanings, the observation unit, and the student's attempt or error message. Prefer small, inspectable requests such as: “Explain why this command failed and suggest the smallest correction” or “Help me decide whether this plot addresses my question; ask about assumptions before suggesting a test.”

Students should check:

1. Do the named variables and group labels exist?
2. Does the code analyse the intended observations and report the correct sample size?
3. Are pairing, missing values, and the direction of the comparison handled correctly?
4. Does the proposed method answer the question?
5. Does the written explanation agree with the actual R output?

Use a light reflection within the notebook rather than a separate LLM report: “I asked for help with ___; I checked the suggestion by ___; I now understand ___.” One example is enough if LLMs were used. Partners can explain a retained command to each other or predict what changing one argument would do. Do not require a chat transcript or make use of an LLM mandatory.

Provide equivalent function hints and instructor help for students without an LLM account. For this workshop, students can usually seek help using the data dictionary and code rather than uploading an entire dataset. Any use of identifiable research data would require the institution's approved arrangements; none is needed for these exercises.

## 9. Dataset review and proposed preparation

### What is currently available

| Existing file | What was found | Teaching implication |
|---|---|---|
| `R-teaching.github.io/data/03_neurites_synthetic.csv` | Twenty rows and three treatment columns | Useful small synthetic warm-up; document units and whether observations across columns are independent. Do not infer pairing from row position. |
| `R-teaching.github.io/data/excel_data.xlsx`, “Mini Mental State exam” sheet | Ten control scores and ten AD scores, in cells A8:B17 | Provides the intended day 1 Alzheimer's example. A simple CSV would avoid making Excel import another learning hurdle. Synthetic teaching data, as confirmed by the instructor. |
| `R-teaching.github.io/data/alzheimer_data.csv` | 336 rows; 146 labelled Demented and 190 Nondemented; 19 SES values and two MMSE values missing | The rows represent repeated visits, not 336 independent people. Subject IDs and visit information were removed from this copy. |

### Confirmed source issue in the larger MMSE file

The existing file was checked against the [official OASIS-2 demographics workbook](https://sites.wustl.edu/oasisbrains/files/2024/03/oasis_longitudinal_demographics-8d83e569fa2e2d30.xlsx), retrieved on 13 September 2026. Its retained row-number column maps the course file to the original workbook. All retained clinical/demographic values agree, allowing for the course file's rounding of eTIV, nWBV, and ASF. The 336 retained rows are exactly the source rows outside the Converted group and represent **136 distinct participants**.

The source contains 373 visits from 150 participants. Restricting to `Visit == 1` gives 150 distinct participants: 72 in the source Nondemented group, 64 Demented, and 14 Converted. The source study is explicitly longitudinal; see the [OASIS-2 description](https://sites.wustl.edu/oasisbrains/home/oasis-2/).

**Recommended preparation, preserving existing values:** Restore subject IDs and visit numbers through the verified source mapping, then retain the first visit for each of the 136 participants in the two groups already used by the course. Keep the original course file's measurement values and rounding, rather than replacing them with the source workbook's greater numerical precision. Label the original grouping clearly and document the exclusion of participants in the Converted group. This gives a simple independent-person teaching dataset while remaining close to the previous course. It also limits generalisation because selection uses the source's longitudinal grouping.

An all-150-participant version would introduce observations outside the existing course file and an additional source group; it is not the preferred route given the preference to preserve the existing material. Do not silently relabel Converted as a baseline diagnosis: source grouping describes longitudinal status, and its relation to the baseline clinical rating needs careful explanation.

The original file should remain available for a short “rows versus people” demonstration. A paired or longitudinal extension can use the restored visit identifiers, but should not be part of the introductory independent-samples workflow by accident.

### Data dictionary and teaching variants

Each released dataset should state provenance, whether values are observed or simulated, what a row represents, units, permitted values, missing-value coding, inclusion rules, and transformations. Synthetic datasets need a reproducible generation script and a fixed seed.

Clarify that MMSE is a bounded score; SES and CDR are ordered categories; eTIV estimates intracranial volume rather than functioning brain tissue; nWBV is a normalised whole-brain volume measure; and ASF is an imaging scaling factor. Verify the exact source definitions and coding before releasing the dictionary. A numeric storage type alone is not enough to choose a summary or test.

Use the existing measurements for substantive exercises. If a particular concept needs a clearer illustration, use a tiny explicitly labelled example vector or a separate copy for an outlier/missingness demonstration. Preserve raw observations. Do not alter real values to manufacture significance, and do not force every exercise to have a positive result. A new large synthetic dataset is unnecessary.

## 10. Multiple-testing practice and optional extensions

### Categorical association — optional follow-on

Use a clearly stated two-way question and show a table of counts and proportions first. Inspect expected counts before interpreting a chi-square approximation. A small 2×2 table can motivate Fisher's exact test. Avoid automatically treating ordinal SES codes as a continuous outcome. See the [R chi-square documentation](https://www.stat.ethz.ch/R-manual/R-devel/library/stats/html/chisq.test.html).

### Multiple comparisons — core

Use a small, prespecified family of comparisons. Have students compare raw and Bonferroni-adjusted p-values and explain why the adjustment changes the criterion. The point is to recognise the consequences of searching many questions, including searches proposed by an LLM. Adjustment does not fix confounding, dependent observations, or selective reporting.

Use a **separate worked example** for everyone: three illustrative p-values, `0.01`, `0.03`, and `0.20`, adjusted to `0.03`, `0.09`, and `0.60`. Explain the calculation as `min(m * p, 1)` for a family of `m` tests. Supply `p.adjust(p_values, method = "bonferroni")`; students should explain the output rather than implement the formula themselves. Label these numbers as an arithmetic illustration, not results from the dementia data. No additional independent analyses are required to create a larger family.

Students answer three short questions within their notebook: Which tests belong to this example's family? Which results remain below 0.05 after adjustment? Why does reporting only the smallest unadjusted p-value give an incomplete account? Distinguish a change in the significance decision from a change in the underlying estimated effect, which adjustment does not alter. This is the required evidence of understanding; applying the command to their own two analyses can remain an optional extension.

Record the total number of planned tests and show all results in the family, including those that are non-significant. If a rank-based analysis is used only as a sensitivity check of a mean comparison, describe that purpose and avoid selecting whichever p-value is smaller. New exploratory questions must be disclosed rather than silently replacing earlier tests.

### More than two groups — optional follow-on

ANOVA need not be taught within the core two afternoons. A follow-on resource can begin with the scientific question and show that an omnibus result does not identify which groups differ. Keep the corresponding comparison strategy and its assumptions explicit.

## 11. Feedback and evidence of learning

Instructors assess only the final submitted notebooks. There are no instructor checks of individual plans, code, or results during the workshop. Assess the reasoning visible in the final work, with emphasis determined by the agreed success criterion.

| Dimension | Satisfactory evidence | Feedback if missing |
|---|---|---|
| Data understanding | Correct observation unit, types, groups, and missingness | Return to the dictionary and identify one row together |
| Visual reasoning | Suitable labelled plot and a description based on observations | Ask what question the axes answer and what information is hidden |
| Analysis choice | Method connected to question, design, and assumptions | Ask the student to name the quantity being compared or associated |
| Interpretation | Effect and uncertainty distinguished from significance; limitations acknowledged | Ask for a conclusion without using the word “significant” |
| Reproducibility | Saved code executes in order and reproduces key results | Restart and identify the first missing dependency or manual step |
| Critical assistance use | Student explains and verifies the help used | Ask them to explain a chosen command and check its inputs |

The initial retrieval exercise, day 1 self-checks, and day 2 analysis plan guide students during the workshop. Assessment uses the final submitted notebook. A result that does not support an association can demonstrate excellent learning. Producing many tests should not itself earn credit.

## 12. Materials to develop after agreeing the design

1. A timed facilitator guide with breaks, student self-checks, common misconceptions, and a shorter fallback route.
2. A setup guide and short lecture companion with retrieval questions and clarifications.
3. Revised day 1 notebooks with worked examples, gradual removal of code support, and interpretation exercises.
4. A day 2 brief, notebook framework, question menu, staged hints, and agreed LLM policy.
5. Documented teaching datasets and reproducible preparation scripts, including a participant-level OASIS version if selected.
6. Instructor solutions with expected summaries, acceptable interpretations, and alternative defensible choices.
7. Updated rendered HTML and course navigation, checked against the executable notebook sources.

The current repository has useful material to reuse, but the initial audit identified an absolute local path in the visualisation notebook, inconsistent project-path instructions, substantial advanced R content early in the sequence, and statistical guidance that needs the clarifications above. Notebook and data revisions should implement the agreed learning sequence together, so the student-facing route remains coherent.

## 13. Current status

This draft incorporates the existing [goals](goals.md), statistics notebooks, lecture transcript, workbook examples, a source check of the larger dementia dataset, and the agreed priorities: two four-hour afternoons; reasoning using supplied R code; normality, test choice, comparison, correlation, correction, and visualisation as core; paired work with individual integrated notebooks; LLM support with understanding; and preservation of existing data values wherever possible.

The next review should check the proposed pacing and depth, especially whether the 50-minute R introduction is sufficient for this cohort and whether the planned day 2 workload is manageable. The facilitator should be prepared to shorten repeated exercises if students need more practice time. Student guides, notebooks, and source datasets have not yet been changed.
