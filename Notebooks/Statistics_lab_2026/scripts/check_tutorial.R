# Instructor check: does every exercise, solution and demo chunk in day1.Rmd run?
# Usage (from the project folder):  Rscript scripts/check_tutorial.R
# Mimics learnr: each chunk runs in a fresh environment holding the setup objects,
# in a temporary directory that contains a copy of data/. Deliberate-error chunks
# are listed in `expected_errors`.
suppressPackageStartupMessages(library(knitr))
source("helpers.R", local = TRUE)
base <- new.env()
invisible(list2env(load_workshop_data(), envir = base))

expected_errors <- c("repair-name", "zscore", "ex-best2")   # contain typos or ___ blanks

lines <- readLines("day1.Rmd")
starts <- grep("^```\\{r", lines)
ends <- grep("^```\\s*$", lines)
chunks <- list()
for (s in starts) {
  e <- ends[ends > s][1]
  header <- lines[s]
  label <- sub("^```\\{r\\s*([^,} ]+).*$", "\\1", header)
  if (label == header) label <- "unnamed"
  chunks[[length(chunks) + 1]] <- list(label = label, header = header,
                                       code = lines[(s + 1):(e - 1)])
}
labels <- vapply(chunks, `[[`, "", "label")
dups <- labels[duplicated(labels)]
if (length(dups)) stop("Duplicate chunk labels: ", paste(dups, collapse = ", "))

setup_code <- function(label) {
  hit <- which(labels == label)
  if (!length(hit)) character() else chunks[[hit]]$code
}

tmp <- tempfile("check-"); dir.create(tmp)
file.copy("data", tmp, recursive = TRUE)
old <- setwd(tmp); on.exit(setwd(old), add = TRUE)
grDevices::pdf(NULL); on.exit(grDevices::dev.off(), add = TRUE)

run_chunk <- function(ch) {
  env <- new.env(parent = globalenv())
  for (obj in ls(base)) assign(obj, get(obj, base), env)
  code <- ch$code
  # Solutions inherit the exercise.setup of their parent exercise, as in learnr.
  parent <- which(labels == sub("-solution$", "", ch$label))
  header <- if (length(parent)) chunks[[parent]]$header else ch$header
  m <- regmatches(header, regexpr('exercise\\.setup\\s*=\\s*"[^"]+"', header))
  if (length(m)) code <- c(setup_code(sub('.*"([^"]+)"', "\\1", m)), code)
  invisible(capture.output(res <- eval(parse(text = code), envir = env)))
  res
}

withr_preview <- function(ch) {            # question chunks print static markdown
  old <- options(workshop.preview = TRUE); on.exit(options(old), add = TRUE)
  invisible(capture.output(run_chunk(ch)))
}

headers <- vapply(chunks, `[[`, "", "header")
skip <- grepl("-hint", labels) | labels %in% c("setup", "unnamed") | grepl("-check$", labels) |
  grepl("context\\s*=", headers)      # shiny server chunks need a live session
n_ok <- 0; failures <- character()
for (i in seq_along(chunks)) {
  if (skip[i]) next
  ch <- chunks[[i]]
  if (grepl("results=\"asis\"", ch$header)) {            # question chunks: run in preview mode
    res <- try(withr_preview(ch), silent = TRUE)
  } else {
    res <- try(suppressWarnings(run_chunk(ch)), silent = TRUE)
  }
  failed <- inherits(res, "try-error")
  if (ch$label %in% expected_errors) {
    if (!failed) failures <- c(failures, paste0(ch$label, " (expected an error but ran)"))
    else n_ok <- n_ok + 1
  } else if (failed) {
    failures <- c(failures, paste0(ch$label, ": ", conditionMessage(attr(res, "condition"))))
  } else n_ok <- n_ok + 1
}
cat(sprintf("Chunks checked: %d OK, %d failed\n", n_ok, length(failures)))

# ---- Check functions: the solution must pass, the untouched starter must not --
# (mimics "Submit Answer": run the code, then hand value, environment and
# normalised code to the *-check function).
run_check <- function(check, ch) {
  env <- new.env(parent = globalenv())
  for (obj in ls(base)) assign(obj, get(obj, base), env)
  value <- try(suppressWarnings(invisible(capture.output(
    res <- eval(parse(text = ch$code), envir = env)))), silent = TRUE)
  if (inherits(value, "try-error")) return("(code errored; learnr would show the error)")
  check(res, env, normalise_code(ch$code))
}
passed <- function(v) isTRUE(v) || inherits(v, "check_right")
n_checks <- 0
for (i in which(grepl("-check$", labels))) {
  spec <- try(eval(parse(text = chunks[[i]]$code)), silent = TRUE)
  if (!is.function(spec)) next
  n_checks <- n_checks + 1
  ex <- sub("-check$", "", labels[i])
  starter <- chunks[[which(labels == ex)]]
  solution <- chunks[[which(labels == paste0(ex, "-solution"))]]
  v <- run_check(spec, solution)
  if (!passed(v)) failures <- c(failures, paste0(ex, "-check rejects the solution: ", v))
  if (!identical(trimws(starter$code), trimws(solution$code))) {
    v <- run_check(spec, starter)
    if (passed(v)) failures <- c(failures, paste0(ex, "-check accepts the unmodified starter"))
  }
}
cat(sprintf("Check functions tested: %d\n", n_checks))
if (length(failures)) { cat(failures, sep = "\n"); quit(status = 1) }
