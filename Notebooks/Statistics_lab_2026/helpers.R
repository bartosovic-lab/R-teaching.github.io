# Instructor infrastructure for day1.Rmd. Students never need to read this file;
# they only use the visible exercise commands inside the tutorial.

# ---- Teaching data -----------------------------------------------------------
# Every learnr exercise starts from a fresh copy of the objects returned here.
load_workshop_data <- function(data_dir = "data") {
  mmse <- read.csv(file.path(data_dir, "mmse_small.csv"))
  mmse$group <- factor(mmse$group, levels = c("Control", "AD"))
  neurites <- read.csv(file.path(data_dir, "neurites.csv"))
  # Seeded simulation of 30 independent teaching units with two assay signals.
  set.seed(7001)
  signal_a <- seq(1, 10, length.out = 30)
  assay <- data.frame(signal_a = signal_a,
                      signal_b = 2 + 0.7 * signal_a + rnorm(30, sd = 1.8))
  list(mmse = mmse, neurites = neurites, assay = assay,
       ad = mmse$MMSE[mmse$group == "AD"],
       control = mmse$MMSE[mmse$group == "Control"])
}

# ---- Questions ---------------------------------------------------------------
# All question helpers have a static "preview" mode (options(workshop.preview = TRUE))
# so scripts/render_preview.R can knit a read-only HTML version of the tutorial.
preview_mode <- function() isTRUE(getOption("workshop.preview"))

preview_block <- function(kind, prompt, choices = NULL, reveal) {
  cat("\n**", kind, ":** ", prompt, "\n\n", sep = "")
  for (choice in choices) cat("- ", choice, "\n", sep = "")
  cat("\n<details><summary>Discuss with your partner, then reveal</summary>\n\n",
      reveal, "\n\n</details>\n", sep = "")
  invisible(NULL)
}

# Single-choice quiz. `correct_choice` is the index of the right answer.
mcq <- function(prompt, choices, correct_choice, explanation) {
  if (preview_mode()) {
    return(preview_block("Quiz", prompt, choices,
                         paste0(choices[correct_choice], ". ", explanation)))
  }
  answers <- lapply(seq_along(choices), function(i)
    learnr::answer(choices[i], correct = i == correct_choice))
  do.call(learnr::question, c(list(text = prompt), answers,
    list(allow_retry = TRUE, random_answer_order = TRUE,
         correct = paste("Yes.", explanation),
         try_again = "Not quite. Talk it through with your partner and try again.")))
}

# Multiple-choice quiz (checkboxes). `correct_choices` is a vector of indices.
mcq_multi <- function(prompt, choices, correct_choices, explanation) {
  if (preview_mode()) {
    return(preview_block("Quiz (choose all that apply)", prompt, choices,
                         paste0(paste(choices[correct_choices], collapse = "; "), ". ", explanation)))
  }
  answers <- lapply(seq_along(choices), function(i)
    learnr::answer(choices[i], correct = i %in% correct_choices))
  do.call(learnr::question, c(list(text = prompt, type = "multiple"), answers,
    list(allow_retry = TRUE, random_answer_order = TRUE,
         correct = paste("Yes.", explanation),
         try_again = "Not all of them yet. Which statements can you defend?")))
}

# Numeric answer with a tolerance, e.g. "What is the IQR?"
numq <- function(prompt, value, tolerance = 0.01, explanation = "") {
  if (preview_mode()) {
    return(preview_block("Number check", prompt, NULL, paste0(value, ". ", explanation)))
  }
  learnr::question_numeric(prompt,
    learnr::answer(value, correct = TRUE),
    tolerance = tolerance, allow_retry = TRUE,
    correct = paste("Yes.", explanation),
    incorrect = "Not that value. Re-read the R output and try again.")
}

# Open reflection. Recorded, never marked right or wrong; shows a discussion guide.
reflect <- function(prompt, guide) {
  if (preview_mode()) {
    return(preview_block("Your explanation", prompt, NULL,
                         paste0("\n", guide)))
  }
  recorded <- if (nzchar(trimws(guide))) paste("Recorded. Discussion guide:", guide) else "Recorded."
  # learnr stores answer_fn() functions as text and re-parses them later, so the
  # closure is lost: the guide must be inlined as a literal, not referenced.
  check <- eval(bquote(function(value) {
    if (!nzchar(trimws(value))) {
      return(learnr::incorrect("Write a thought first; a question is welcome too."))
    }
    learnr::correct(.(recorded))
  }))
  learnr::question_text(prompt,
    learnr::answer_fn(check, label = "Open reflection"),
    rows = 4, allow_retry = TRUE, submit_button = "Record my explanation",
    try_again_button = "Revise", correct = "", try_again = "")
}

# ---- Exercise checker --------------------------------------------------------
# Used by "Submit Answer". An exercise gets the Submit button only when it has a
# *-check chunk. That chunk holds one of:
#   * a function(value, env, code): returns TRUE or right("message") when the
#     task was done, or a string telling the student what to change next.
#       value  the last value of the student's code
#       env    the environment after the student's code ran (env$scores, ...)
#       code   the student's code normalised by normalise_code(): comments and
#              whitespace removed, so code_has(code, "median(scores)") works
#   * a string: the last value is compared with the last value of the *-solution
#     chunk and the string is shown when they differ.
# Plots cannot be compared, so plotting exercises check the code text instead.
same <- function(a, b, tolerance = 1e-6) {
  isTRUE(all.equal(a, b, tolerance = tolerance, check.attributes = FALSE))
}
right <- function(message) structure(message, class = "check_right")
normalise_code <- function(code) {
  code <- paste(code, collapse = "\n")
  exprs <- tryCatch(base::parse(text = code, keep.source = FALSE), error = function(e) NULL)
  if (!is.null(exprs)) {
    code <- paste(vapply(exprs, function(e) paste(deparse(e), collapse = ""), ""), collapse = "\n")
  }
  gsub("[[:space:]]+", "", code)
}
code_has <- function(code, text) grepl(gsub("[[:space:]]+", "", text), code, fixed = TRUE)

workshop_checker <- function(label, user_code, solution_code, check_code,
                             envir_result, evaluate_result, envir_prep,
                             last_value, stage, ...) {
  if (!identical(stage, "check")) return(NULL)
  feedback <- function(message, correct) {
    list(message = message, correct = correct, location = "append")
  }
  spec <- tryCatch(base::eval(base::parse(text = check_code)), error = function(e) NULL)
  if (is.function(spec)) {
    verdict <- tryCatch(spec(last_value, envir_result, normalise_code(user_code)),
                        error = function(e) "The check could not run.")
    if (isTRUE(verdict)) {
      return(feedback("Correct. Now explain it to your partner.", TRUE))
    }
    if (inherits(verdict, "check_right")) {
      return(feedback(paste("Correct.", as.character(verdict)[1]), TRUE))
    }
    return(feedback(if (is.character(verdict)) verdict[1] else "Not there yet; read the task again.", FALSE))
  }
  if (is.null(solution_code)) {
    return(feedback("This exercise has no automatic check. Compare with the Solution.", TRUE))
  }
  extra <- if (is.character(spec)) paste0(" ", spec[1]) else ""

  expected <- tryCatch({
    grDevices::pdf(NULL); on.exit(grDevices::dev.off(), add = TRUE)
    env <- new.env(parent = envir_prep)
    for (obj in base::ls(envir_prep, all.names = TRUE)) {
      base::assign(obj, base::get(obj, envir = envir_prep), envir = env)
    }
    base::eval(base::parse(text = solution_code), envir = env)
  }, error = function(e) structure(list(), class = "checker_failed"))

  if (inherits(expected, "checker_failed")) {
    return(feedback("The reference solution could not be evaluated here; compare with the Solution by eye.", TRUE))
  }
  if (is.null(expected) || inherits(expected, "ggplot")) {
    return(feedback("R ran your code. This check cannot read a figure, so compare yours with the Solution.", TRUE))
  }
  same <- if (inherits(expected, "htest") && inherits(last_value, "htest")) {
    isTRUE(all.equal(unname(expected$statistic), unname(last_value$statistic), tolerance = 1e-6)) &&
      isTRUE(all.equal(expected$p.value, last_value$p.value, tolerance = 1e-6))
  } else {
    isTRUE(all.equal(expected, last_value, tolerance = 1e-6, check.attributes = FALSE))
  }
  if (same) {
    feedback("Correct: your result matches the reference solution. Now explain it to your partner.", TRUE)
  } else {
    feedback(paste0("Your last result does not match the reference yet.", extra,
                    " Remember: the check looks at the final line of your code."), FALSE)
  }
}

# ---- Export of a student's work --------------------------------------------
# Builds one self-contained HTML file from the tutorial's item list
# (learnr::get_tutorial_info()$items: label, type, question text, starter code)
# and the student's state (learnr::get_tutorial_state(): code / answers).
# Section headings come from the level-2 headings of the tutorial source.
tutorial_sections <- function(rmd = "day1.Rmd") {
  if (!file.exists(rmd)) return(character())
  lines <- readLines(rmd, warn = FALSE)
  current <- ""
  out <- character()
  for (ln in lines) {
    if (grepl("^## ", ln)) current <- sub("^## ", "", ln)
    m <- regmatches(ln, regexpr("^```\\{r\\s*([^,} ]+)", ln))
    if (length(m)) out[sub("^```\\{r\\s*", "", m)] <- current
  }
  out
}

export_work_html <- function(state, items, file, student = "", rmd = "day1.Rmd") {
  esc <- htmltools::htmlEscape
  sections <- tutorial_sections(rmd)
  html <- c(
    "<!DOCTYPE html><html><head><meta charset='utf-8'>",
    "<title>Day 1 · my work</title>",
    "<style>body{font-family:-apple-system,Helvetica,Arial,sans-serif;max-width:860px;margin:2em auto;padding:0 1em;line-height:1.45;color:#222}",
    "h1{font-size:1.6em}h2{margin-top:2em;border-bottom:2px solid #ddd;padding-bottom:.2em}h3{margin-bottom:.2em;font-size:1.05em}",
    "pre{background:#f4f4f6;padding:.7em;border-radius:6px;overflow-x:auto;font-size:.9em}",
    ".q{background:#f7f9fc;border-left:4px solid #9bb7d4;padding:.5em .9em;margin:.6em 0}",
    ".a{margin:.3em 0 .3em 1em;white-space:pre-wrap}.ok{color:#2c8f7a}.no{color:#b04848}.na{color:#777}",
    ".meta{color:#666;font-size:.9em}</style></head><body>",
    sprintf("<h1>Day 1 · From a table to a biological story</h1><p class='meta'>%s%s</p>",
            if (nzchar(student)) paste0("<b>", esc(student), "</b> · ") else "",
            format(Sys.time(), "%Y-%m-%d %H:%M"))
  )
  attempted <- 0
  last_section <- NULL
  for (i in seq_len(nrow(items))) {
    label <- items$label[i]; type <- items$type[i]; data <- items$data[[i]]
    if (!type %in% c("exercise", "question")) next
    st <- state[[label]]
    section <- unname(sections[label])
    if (length(section) != 1 || is.na(section)) section <- ""
    if (!identical(section, last_section)) {
      html <- c(html, sprintf("<h2>%s</h2>", esc(section)))
      last_section <- section
    }
    if (type == "exercise") {
      code <- if (!is.null(st$answer)) paste(st$answer, collapse = "\n") else NULL
      status <- if (is.null(code)) "<span class='na'>not run</span>"
                else if (isTRUE(st$correct)) "<span class='ok'>submitted · correct</span>"
                else if (isFALSE(st$correct)) "<span class='no'>submitted · not matching yet</span>"
                else "<span class='ok'>run</span>"
      if (!is.null(code)) attempted <- attempted + 1
      html <- c(html, sprintf("<h3>Code window <code>%s</code> · %s</h3>", esc(label), status),
                sprintf("<pre>%s</pre>", esc(if (is.null(code)) paste(data$code, collapse = "\n") else code)))
    } else {
      prompt <- data$question
      prompt <- if (is.character(prompt)) prompt else as.character(prompt)
      html <- c(html, sprintf("<div class='q'><b>Question</b> <code>%s</code><br>%s</div>", esc(label), paste(prompt, collapse = " ")))
      if (is.null(st$answer)) {
        html <- c(html, "<p class='a na'>not answered</p>")
      } else {
        attempted <- attempted + 1
        ans <- paste(as.character(unlist(st$answer)), collapse = "; ")
        verdict <- if (isTRUE(st$correct)) " <span class='ok'>✔</span>"
                   else if (isFALSE(st$correct)) " <span class='no'>✘</span>" else ""
        html <- c(html, sprintf("<p class='a'><b>My answer:</b> %s%s</p>", esc(ans), verdict))
      }
    }
  }
  html <- c(html, sprintf("<p class='meta'>%d of %d items attempted. Answers are practice records, not marks.</p>",
                          attempted, sum(items$type %in% c("exercise", "question"))),
            "</body></html>")
  writeLines(html, file, useBytes = TRUE)
  invisible(file)
}
