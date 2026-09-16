# Instructor tool: publish the Day 1 tutorial online so students can open it with
# one click from the course page (no R installation needed on their side).
#
# Hosting: shinyapps.io (Posit). Free tier = 5 apps, 25 active hours per month,
# one 1 GB instance. That is enough for one afternoon if the class is small
# (each student's Run Code executes on the server). For 20+ students running
# exercises at the same time, the Starter plan (more memory, several instances)
# is safer. Alternative hosts: Posit Connect, or a university Shiny Server.
#
# One-time setup (in the RStudio Console):
#   install.packages("rsconnect")
#   rsconnect::setAccountInfo(name = "<account>", token = "<token>", secret = "<secret>")
#   (token and secret: shinyapps.io > Account > Tokens > Show)
#
# Then run this script from the project folder:  source("scripts/deploy_shinyapps.R")
#
# Afterwards, put the button on the course page (Pages/KN7001.md):
#   [![Launch the Day 1 tutorial](https://img.shields.io/badge/Launch-Day%201%20tutorial-2c8f7a?style=for-the-badge)](https://<account>.shinyapps.io/day1/)
#
# Redeploy whenever day1.Rmd, helpers.R or data/ change.

stopifnot(file.exists("day1.Rmd"), file.exists("helpers.R"), dir.exists("data"))
if (!requireNamespace("rsconnect", quietly = TRUE)) install.packages("rsconnect")

rsconnect::deployApp(
  appDir = ".",
  appFiles = c("day1.Rmd", "helpers.R", "data/mmse_small.csv", "data/neurites.csv"),
  appPrimaryDoc = "day1.Rmd",
  appName = "day1",
  appTitle = "KN7001 Day 1 - From a table to a biological story",
  forceUpdate = TRUE
)
