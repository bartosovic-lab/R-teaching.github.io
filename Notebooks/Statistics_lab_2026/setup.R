# Installs what the Day 1 tutorial needs, checks the project, and starts the tutorial.
# Run it in the RStudio Console after opening Statistics_lab.Rproj:
#   source("setup.R")
# (Opening the project in RStudio runs this for you; see .Rprofile.)
required <- c("learnr", "rmarkdown", "knitr", "shiny", "ggplot2", "rstudioapi")
missing <- required[!vapply(required, requireNamespace, logical(1), quietly = TRUE)]
if (length(missing)) {
  cat("Installing:", paste(missing, collapse = ", "), "(one or two minutes)\n")
  install.packages(missing, repos = "https://cloud.r-project.org")
}
if (!rmarkdown::pandoc_available("2.8")) {
  stop("Pandoc was not found. Open this project in RStudio (which bundles pandoc) and run setup.R again.")
}
for (f in c("day1.Rmd", "helpers.R", "data/mmse_small.csv", "data/neurites.csv")) {
  if (!file.exists(f)) stop("Missing file: ", f, ". Keep the project folder together.")
}
cat("Ready. Starting the tutorial. To stop it, click the red Stop button above the Console.\n",
    "To start it again later: source(\"setup.R\"), or open day1.Rmd and click Run Document.\n", sep = "")
rmarkdown::run("day1.Rmd")
