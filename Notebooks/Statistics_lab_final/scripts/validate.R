if(dir.exists('.learnr-library')) .libPaths(c(normalizePath('.learnr-library'),.libPaths()))
Sys.setenv(R_LIBS_USER=paste(.libPaths(),collapse=.Platform$path.sep))
if(!rmarkdown::pandoc_available())Sys.setenv(RSTUDIO_PANDOC='/Applications/RStudio.app/Contents/Resources/app/quarto/bin/tools/aarch64')
root<-normalizePath('.');setwd('tutorials/01_basics');tutorial<-getwd()
library(learnr);library(shiny);source('helpers.R')
exercises<-learnr:::get_tutorial_exercises('01_basics.Rmd')
stopifnot(length(exercises)==22,setequal(names(exercises),names(exercise_info)))
states<-list()
for(label in names(exercises)) {
 ex<-exercises[[label]];ex$code<-ex$solution;ex$tutorial<-list(language='en')
 result<-learnr:::evaluate_exercise(ex,new.env(parent=globalenv()),data_dir=file.path(tutorial,'data'))
 if(!isTRUE(result$feedback$correct)||!is.null(result$error_message)){print(result);stop('Failed exercise: ',label)}
 states[[label]]<-list(type='exercise',answer=ex$solution,correct=TRUE)
 cat('PASS solution',label,'\n')
 ex$code<-'NULL'
 result<-learnr:::evaluate_exercise(ex,new.env(parent=globalenv()),data_dir=file.path(tutorial,'data'))
 stopifnot(!isTRUE(result$feedback$correct))
}
# Statistically meaningful wrong answers: wrong groups, wrong direction and fake adjusted values.
wrong<-list(quartiles='memantine_q <- c(1,2,3); memantine_iqr <- 2',
 welch='study <- read.csv("data/study.csv"); a <- study$BDNF[study$group=="Saline"]; b <- study$BDNF[study$group=="Memantine"]; mean_difference <- mean(a)-mean(b); welch_result <- t.test(a,b)',
 replication='measurement_n <- 1080; mouse_n <- 1080',
 bonferroni='raw_p <- c(.01,.02,.03); adjusted_p <- raw_p',rescue='mean(Readings)')
for(label in names(wrong)) {
 ex<-exercises[[label]];ex$code<-wrong[[label]];ex$tutorial<-list(language='en')
 result<-learnr:::evaluate_exercise(ex,new.env(parent=globalenv()),data_dir=file.path(tutorial,'data'))
 stopifnot(!isTRUE(result$feedback$correct))
}
# Either defensible correlation method is accepted.
ex<-exercises$correlation;ex$code<-sub('"spearman"','"pearson"',ex$solution,fixed=TRUE);ex$tutorial<-list(language='en')
stopifnot(isTRUE(learnr:::evaluate_exercise(ex,new.env(parent=globalenv()),data_dir=file.path(tutorial,'data'))$feedback$correct))
notes<-setNames(rep(list('I checked the sample, units and uncertainty.'),length(note_labels)),names(note_labels))
notes$exit<-'My note contains `r stop("not executable")` and <tags>.'
empty<-export_notebook(list(),list());stopifnot(any(grepl('Not submitted',empty)),!any(grepl('^counts <-',empty)))
export<-file.path(root,'notebooks/validation_export.Rmd')
writeLines(export_notebook(states,notes,'Validation','Partner',list(mode='count',bins=8,width=.02,smooth=1.4)),export)
setwd(root)
render_fresh<-function(f) {
 script<-tempfile(fileext='.R');writeLines(c('args<-commandArgs(TRUE)','rmarkdown::render(args[1],output_format="html_document",quiet=TRUE)'),script)
 status<-system2(file.path(R.home('bin'),'Rscript'),c('--vanilla',shQuote(script),shQuote(f)));unlink(script);stopifnot(status==0)
 html<-sub('\\.Rmd$','.html',f);body<-paste(readLines(html,warn=FALSE),collapse='\n')
 stopifnot(!grepl('Error in',body,fixed=TRUE));invisible(html)
}
render_fresh(export)
unlink(c(export,sub('\\.Rmd$','.html',export)))
stopifnot(system2(file.path(R.home('bin'),'Rscript'),c('--vanilla','scripts/validate_server.R'))==0)
# Extract executable chunks, excluding reference hints (eval=FALSE).
doc<-readLines('notebooks/02_mmse_investigation.Rmd');starts<-which(grepl('^```\\{r ',doc));chunks<-list()
for(i in starts) {
 j<-i+which(doc[(i+1):length(doc)]=='```')[1]
 label<-sub('^```\\{r ([^,}]+).*','\\1',doc[i])
 if(!grepl('eval=FALSE',doc[i],fixed=TRUE))chunks[[label]]<-paste(doc[(i+1):(j-1)],collapse='\n')
}
pdf(file.path(root,'outputs/validation_plots.pdf'))
for(method in c('welch','wilcoxon'))for(variable in c('Age','nWBV'))for(cor_method in c('pearson','spearman')) {
 env<-new.env(parent=globalenv())
 for(label in setdiff(names(chunks),'setup')) {
  code<-chunks[[label]]
  code<-sub('group_method <- ""',paste0('group_method <- "',method,'"'),code,fixed=TRUE)
  code<-sub('correlation_variable <- ""',paste0('correlation_variable <- "',variable,'"'),code,fixed=TRUE)
  code<-sub('correlation_method <- ""',paste0('correlation_method <- "',cor_method,'"'),code,fixed=TRUE)
  capture.output(eval(parse(text=code),env))
 }
 stopifnot(inherits(env$group_result,'htest'),inherits(env$correlation_result,'htest'),nrow(env$correlation_data)==136)
}
dev.off()
# Render a completed representative choice in a fresh R process.
completed<-doc
completed<-gsub('group_method <- ""','group_method <- "welch"',completed,fixed=TRUE)
completed<-gsub('correlation_variable <- ""','correlation_variable <- "nWBV"',completed,fixed=TRUE)
completed<-gsub('correlation_method <- ""','correlation_method <- "spearman"',completed,fixed=TRUE)
f<-file.path(root,'notebooks/validation_completed.Rmd');writeLines(completed,f);render_fresh(f);unlink(c(f,sub('\\.Rmd$','.html',f)))
cat('PASS: 22 solutions, 22 empty attempts, 5 wrong attempts, both correlation choices, exported practice with literal prose, Shiny controls/downloads, 8 MMSE method combinations and fresh completed render.\n')
