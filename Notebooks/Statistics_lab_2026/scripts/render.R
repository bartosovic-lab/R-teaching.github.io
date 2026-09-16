if(dir.exists('.learnr-library')) .libPaths(c(normalizePath('.learnr-library'),.libPaths()))
Sys.setenv(R_LIBS_USER=paste(.libPaths(),collapse=.Platform$path.sep))
if(!rmarkdown::pandoc_available())Sys.setenv(RSTUDIO_PANDOC='/Applications/RStudio.app/Contents/Resources/app/quarto/bin/tools/aarch64')
files<-c('index.Rmd','data/dictionary.Rmd','notebooks/00_setup.Rmd','notebooks/03_statistical_analysis.Rmd','notebooks/04_investigation.Rmd','tutorial_preview.Rmd','instructor/solutions.Rmd')
for(f in files) {
 script<-tempfile(fileext='.R')
 writeLines(c('args<-commandArgs(TRUE)','rmarkdown::render(args[1],quiet=TRUE)'),script)
 status<-system2(file.path(R.home('bin'),'Rscript'),c('--vanilla',shQuote(script),shQuote(f)))
 unlink(script); if(status!=0)stop('Render failed: ',f)
 cat('Rendered',f,'\n')
}
rmarkdown::render('tutorials/01_basics/01_basics.Rmd',quiet=TRUE)
cat('Rendered live tutorial. Launch it with scripts/run_pilot.R.\n')
