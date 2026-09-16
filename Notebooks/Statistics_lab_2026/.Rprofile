# Project start-up file. When this project is opened in RStudio, it installs the
# packages the tutorial needs (first time only) and launches day1.Rmd, so that
# double-clicking Statistics_lab.Rproj is enough to start the workshop.
# To open the project without launching the tutorial, create an empty file
# called .no_autolaunch in this folder.

if (file.exists("~/.Rprofile")) source("~/.Rprofile")   # keep the user's own settings

local({
  if (!interactive() || file.exists(".no_autolaunch")) return(invisible())
  setHook("rstudio.sessionInit", function(newSession) {
    if (!newSession) return(invisible())
    if (!requireNamespace("rstudioapi", quietly = TRUE)) {
      install.packages("rstudioapi", repos = "https://cloud.r-project.org")
    }
    if (!requireNamespace("rstudioapi", quietly = TRUE)) return(invisible())
    message("Starting the Day 1 tutorial. To stop it later, click the red Stop button above the Console.")
    rstudioapi::sendToConsole(
      'source("setup.R"); rmarkdown::run("day1.Rmd")',
      execute = TRUE, echo = TRUE, focus = FALSE)
  }, action = "append")
})
