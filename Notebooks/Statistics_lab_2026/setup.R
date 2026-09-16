# Run once, in the RStudio Console, after opening Statistics_lab.Rproj:
#   source("setup.R")
required <- c("learnr", "rmarkdown", "knitr", "shiny", "ggplot2")
missing <- required[!vapply(required, requireNamespace, logical(1), quietly = TRUE)]
if (length(missing)) install.packages(missing, repos = "https://cloud.r-project.org")
if (!rmarkdown::pandoc_available("2.8")) {
  stop("Pandoc was not found. Open this project in RStudio (which bundles pandoc) and run setup.R again.")
}
for (f in c("day1.Rmd", "helpers.R", "data/mmse_small.csv", "data/neurites.csv")) {
  if (!file.exists(f)) stop("Missing file: ", f, ". Keep the project folder together.")
}
cat("Ready. To start the tutorial: open day1.Rmd and click 'Run Document',\n",
    "or double-click Launch_day1.command (Mac) / Launch_day1.bat (Windows).\n", sep = "")
