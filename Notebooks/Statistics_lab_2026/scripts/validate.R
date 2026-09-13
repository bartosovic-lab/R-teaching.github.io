# Execute day 2 paths in a copied project whose location contains spaces.
# Requires knitr; this does not depend on instructor answers to fill student work.
stopifnot(file.exists("Statistics_lab.Rproj"))
args <- commandArgs(trailingOnly = TRUE)
if (length(args) == 4 && args[1] == "--case") {
  group <- args[2]
  variable <- args[3]
  method <- args[4]
  original <- readLines("notebooks/04_mmse_investigation.Rmd", warn = FALSE)
  original <- sub('group_method <- ""', paste0('group_method <- "', group, '"'), original, fixed = TRUE)
  original <- sub('correlation_variable <- ""', paste0('correlation_variable <- "', variable, '"'), original, fixed = TRUE)
  original <- sub('correlation_method <- ""', paste0('correlation_method <- "', method, '"'), original, fixed = TRUE)
  writeLines(original, "notebooks/validation_case.Rmd")
  env <- new.env(parent = globalenv())
  knitr::knit("notebooks/validation_case.Rmd", output = "outputs/validation.md",
              envir = env, quiet = TRUE)
  stopifnot(inherits(env$group_result, "htest"), inherits(env$correlation_result, "htest"),
            nrow(env$group_data) == 136, nrow(env$correlation_data) == 136,
            length(env$demented) == 64, length(env$nondemented) == 72)
  expected_group <- if (group == "welch") t.test(env$demented, env$nondemented) else
    wilcox.test(env$demented, env$nondemented, exact = FALSE)
  expected_cor <- cor.test(env$mmse[[variable]], env$mmse$MMSE,
                          method = method, exact = FALSE)
  stopifnot(isTRUE(all.equal(env$group_result$p.value, expected_group$p.value)),
            isTRUE(all.equal(unname(env$correlation_result$estimate), unname(expected_cor$estimate))))
  quit(status = 0)
}
root <- normalizePath(".")
test_root <- tempfile("statistics lab copied project ")
dir.create(test_root)
for (directory in c("data", "notebooks", "figures", "scripts")) {
  file.copy(directory, test_root, recursive = TRUE)
}
file.copy("Statistics_lab.Rproj", test_root)
dir.create(file.path(test_root, "outputs"))
setwd(test_root)
for (group in c("welch", "wilcoxon")) {
  for (variable in c("Age", "nWBV")) {
    for (method in c("pearson", "spearman")) {
      status <- system2(file.path(R.home("bin"), "Rscript"),
                         c("--vanilla", "scripts/validate.R", "--case", group, variable, method),
                         stdout = FALSE)
      if (status != 0) stop("Failed: ", paste(group, variable, method))
      cat("Passed:", group, variable, method, "\n")
    }
  }
}
# Explicit missingness exercise: an unrelated missing SES must not remove a case.
d <- read.csv("data/mmse_baseline.csv")
stopifnot(nrow(d) == 136, !anyDuplicated(d$Subject_ID), all(d$Visit == 1))
stopifnot(sum(is.na(d$SES)) == 8, sum(is.na(d$MMSE)) == 0)
d$MMSE[1] <- NA
stopifnot(sum(complete.cases(d[, c("Group", "MMSE")])) == 135,
          sum(complete.cases(d[, c("Age", "MMSE")])) == 135)
setwd(root)
cat("Passed: copied-project paths, independent-case counts, and analysis-specific missingness.\n")
