# Run in RStudio after opening Statistics_lab.Rproj.
if (!file.exists('Statistics_lab.Rproj')) stop('Open Statistics_lab.Rproj first, then run this command from its project folder.')
if(dir.exists('.learnr-library')) .libPaths(c(normalizePath('.learnr-library'),.libPaths()))
needed<-c('learnr','shiny','rmarkdown','knitr','jsonlite')
missing<-needed[!vapply(needed,requireNamespace,logical(1),quietly=TRUE)]
if(length(missing))stop('Install packages first: install.packages(c(',paste(sprintf('"%s"',missing),collapse=', '),'))')
if(!rmarkdown::pandoc_available()) {
 paths<-file.path('/Applications/RStudio.app/Contents/Resources/app/quarto/bin/tools',c('aarch64','x86_64'))
 found<-paths[file.exists(file.path(paths,'pandoc'))]
 if(length(found))Sys.setenv(RSTUDIO_PANDOC=found[1])
}
if(!rmarkdown::pandoc_available())stop('Pandoc is needed. Launch from RStudio.')
stopifnot(identical(unname(tools::md5sum('data/study.csv')),unname(tools::md5sum('tutorials/01_basics/data/study.csv'))))
stopifnot(identical(unname(tools::md5sum('course.json')),unname(tools::md5sum('tutorials/01_basics/course.json'))))
local({
 old<-getwd(); on.exit(setwd(old)); setwd('tutorials/01_basics')
 port<-getOption('course.port',NULL)
 args<-list(host='127.0.0.1',launch.browser=interactive())
 if(!is.null(port))args$port<-as.integer(port)
 rmarkdown::run('01_basics.Rmd',shiny_args=args)
})
