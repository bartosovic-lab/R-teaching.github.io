if(dir.exists('.learnr-library')) .libPaths(c(normalizePath('.learnr-library'),.libPaths()))
Sys.setenv(R_LIBS_USER=paste(.libPaths(),collapse=.Platform$path.sep))
if(!rmarkdown::pandoc_available()) {
 paths<-file.path('/Applications/RStudio.app/Contents/Resources/app/quarto/bin/tools',c('aarch64','x86_64'))
 found<-paths[file.exists(file.path(paths,'pandoc'))]
 if(length(found))Sys.setenv(RSTUDIO_PANDOC=found[1])
}
rmarkdown::render('notebooks/02_mmse_investigation.Rmd',output_format='html_notebook',quiet=TRUE)
files<-c('index.Rmd','data/dictionary.Rmd','notebooks/00_setup.Rmd','notebooks/02_mmse_investigation.Rmd','notebooks/03_command_reference.Rmd','day1_preview.Rmd','instructor/solutions.Rmd')
for(f in files) {
 script<-tempfile(fileext='.R')
 writeLines(c('args<-commandArgs(TRUE)', 'rmarkdown::render(args[1],output_format="html_document",quiet=TRUE)'),script)
 status<-system2(file.path(R.home('bin'),'Rscript'),c('--vanilla',shQuote(script),shQuote(f)))
 unlink(script); if(status!=0)stop('Render failed: ',f)
 cat('Rendered',f,'\n')
}
rmarkdown::render('tutorials/01_basics/01_basics.Rmd',quiet=TRUE)
cat('Rendered live tutorial. Launch using scripts/run_day1.R.\n')
