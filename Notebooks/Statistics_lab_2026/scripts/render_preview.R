# Instructor tool: knit a static, read-only HTML preview of day1.Rmd
# (all code and outputs visible, quizzes shown as collapsible answers).
# Useful for the course website, which cannot host a live learnr tutorial.
# Usage (from the project folder):  Rscript scripts/render_preview.R
options(workshop.preview = TRUE)
if (!rmarkdown::pandoc_available("2.8")) {
  # RStudio ships pandoc; point R at it when running outside RStudio.
  cands <- c("/Applications/RStudio.app/Contents/Resources/app/quarto/bin/tools/aarch64",
             "/Applications/RStudio.app/Contents/Resources/app/quarto/bin/tools/x86_64",
             "/Applications/RStudio.app/Contents/Resources/app/bin/quarto/bin/tools")
  hit <- cands[file.exists(file.path(cands, "pandoc"))]
  if (length(hit)) Sys.setenv(RSTUDIO_PANDOC = hit[1])
}
# Exercise chunks are ordinary chunks here; hint/check chunks are not evaluated;
# deliberate errors are allowed to print.
knitr::opts_hooks$set(label = function(options) {
  lab <- options$label
  if (grepl("-hint|-check$", lab)) { options$eval <- FALSE; options$echo <- FALSE }
  if (!is.null(options$context)) { options$eval <- FALSE; options$echo <- FALSE }   # shiny server chunks
  if (grepl("-solution$", lab)) { options$eval <- FALSE; options$class.source <- "solution" }
  if (isTRUE(options$exercise)) { options$echo <- TRUE; options$error <- TRUE; options$exercise <- NULL }
  if (grepl("results", paste(names(options), collapse = " ")) && identical(options$results, "asis")) options$echo <- FALSE
  options
})
knitr::opts_chunk$set(echo = TRUE)
rmarkdown::render("day1.Rmd", output_format = rmarkdown::html_document(
  toc = TRUE, toc_float = TRUE, toc_depth = 2, theme = "flatly",
  css = "scripts/preview.css"),
  output_file = "day1_preview.html", quiet = TRUE)
cat("Wrote day1_preview.html\n")
