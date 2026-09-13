# Run from the Statistics_lab_2026 project directory.
# Every document renders in a fresh R process. Does not install packages.
args <- commandArgs(trailingOnly = TRUE)
if (length(args) == 2 && args[1] == "--one") {
  html <- rmarkdown::render(args[2], quiet = TRUE, envir = new.env(parent = globalenv()))
  writeLines(sub("[ \t]+$", "", readLines(html, warn = FALSE)), html)
  quit(status = 0)
}
stopifnot(file.exists("Statistics_lab.Rproj"))
for (package in c("knitr", "rmarkdown", "ggplot2")) {
  if (!requireNamespace(package, quietly = TRUE)) stop("Install ", package, " before building.")
}
if (!rmarkdown::pandoc_available()) {
  stop("Pandoc not found. Build from RStudio or set RSTUDIO_PANDOC to its Pandoc directory.")
}
source("scripts/violin_figure.R")
documents <- c("index.Rmd", "data/dictionary.Rmd",
               list.files("notebooks", pattern = "\\.Rmd$", full.names = TRUE),
               "instructor/solutions.Rmd")
for (document in documents) {
  status <- system2(file.path(R.home("bin"), "Rscript"),
                    c("--vanilla", "scripts/render.R", "--one", shQuote(document)))
  if (status != 0) stop("Rendering failed: ", document)
  message("Rendered ", document)
}
