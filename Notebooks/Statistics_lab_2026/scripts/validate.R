# Actual learnr evaluation, stateful download checks, and fresh-session notebook rendering.
if(dir.exists('.learnr-library')) .libPaths(c(normalizePath('.learnr-library'),.libPaths()))
Sys.setenv(R_LIBS_USER=paste(.libPaths(),collapse=.Platform$path.sep))
if(!rmarkdown::pandoc_available())Sys.setenv(RSTUDIO_PANDOC='/Applications/RStudio.app/Contents/Resources/app/quarto/bin/tools/aarch64')
root<-normalizePath('.'); setwd('tutorials/01_basics'); tutorial<-getwd()
library(learnr); library(shiny)
source('helpers.R')
resources <- rmarkdown::find_external_resources('01_basics.Rmd')
stopifnot(all(c('helpers.R','course.json','exercises.json') %in% resources$path))
exercises<-learnr:::get_tutorial_exercises('01_basics.Rmd')
stopifnot(length(exercises)==15)
states<-list()
for(label in names(exercises)) {
 ex<-exercises[[label]]; ex$code<-ex$solution; ex$tutorial<-list(language='en')
 result<-learnr:::evaluate_exercise(ex,new.env(parent=globalenv()),data_dir=file.path(tutorial,'data'))
 if(!isTRUE(result$feedback$correct)||!is.null(result$error_message)) {print(result);stop('Failed exercise: ',label)}
 states[[label]]<-list(type='exercise',answer=ex$solution,correct=TRUE)
 cat('PASS exercise',label,'\n')
}
wrong_codes<-list(divide='12 / 3',rescue='mean(Readings)',select='acquisition_reversal_mV <- c(1,2,3); mean(acquisition_reversal_mV)',
 spread='sd_baseline_reversal_mV <- 0; sd_acquisition_reversal_mV <- 0',histogram='hist_acquisition_reversal_mV <- hist(c(1,2,3),breaks=5)',
 boxplot='study <- read.csv("data/study.csv"); comparison <- boxplot(reversal_mV~group,data=study)',
 scatter='study <- read.csv("data/study.csv"); acquisition_rats <- study; plot(study$reversal_mV,study$resting_mV)')
for(label in names(wrong_codes)) {
 ex<-exercises[[label]]; ex$code<-wrong_codes[[label]]; ex$tutorial<-list(language='en')
 result<-learnr:::evaluate_exercise(ex,new.env(parent=globalenv()),data_dir=file.path(tutorial,'data'))
 stopifnot(!isTRUE(result$feedback$correct))
}
notes<-setNames(rep(list('I checked the sample and can explain the pattern.'),length(note_labels)),names(note_labels))
empty<-export_notebook(list(),list())
stopifnot(any(grepl('Not submitted',empty)),!any(grepl('^counts <-',empty)))
stopifnot(startsWith(literal('`r stop("unsafe")`'),paste0(intToUtf8(92),'`')))
export<-file.path(root,'outputs/validation_export.Rmd')
writeLines(export_notebook(states,notes,'Validation','Partner',list(mode='count',bins=8,width=1,smooth=1.4)),export)
# Move to notebooks only while rendering because that is the documented download location.
export_in<-file.path(root,'notebooks/validation_export.Rmd'); file.copy(export,export_in,overwrite=TRUE)

setwd(root)
stopifnot(system2(file.path(R.home('bin'),'Rscript'),c('--vanilla','scripts/validate_server.R'))==0)
render_fresh<-function(f) {
 script<-tempfile(fileext='.R'); writeLines(c('args<-commandArgs(TRUE)','rmarkdown::render(args[1],quiet=TRUE)'),script)
 status<-system2(file.path(R.home('bin'),'Rscript'),c('--vanilla',shQuote(script),shQuote(f)));unlink(script)
 stopifnot(status==0)
 html<-sub('\\.Rmd$','.html',f); body<-paste(readLines(html,warn=FALSE),collapse='\n')
 stopifnot(!grepl('Error in',body,fixed=TRUE));invisible(html)
}
render_fresh(export_in)
unlink(c(export_in,sub('\\.Rmd$','.html',export_in)))
render_fresh('notebooks/03_statistical_analysis.Rmd')
render_fresh('notebooks/04_investigation.Rmd')
# Exercise every supported day-2 question, both group tests and both correlation methods.
doc<-readLines('notebooks/04_investigation.Rmd')
starts<-which(grepl('^```\\{r ',doc)); chunks<-list()
for(i in starts) {j<-i+which(doc[(i+1):length(doc)]=='```')[1]; label<-sub('^```\\{r ([^,}]+).*','\\1',doc[i]);chunks[[label]]<-paste(doc[(i+1):(j-1)],collapse='\n')}
pdf(file.path(root,'outputs/validation_plots.pdf'))
for(choice in 1:3) for(method in c('welch','wilcoxon')) for(cor_method in c('pearson','spearman')) for(cor_group in c('group_a','group_b')) {
 env<-new.env(parent=globalenv())
 for(label in setdiff(names(chunks),'setup')) {
  code<-chunks[[label]]
  code<-sub('question_choice <- 0',paste('question_choice <-',choice),code,fixed=TRUE)
  code<-sub('method_choice <- "choose"',paste0('method_choice <- "',method,'"'),code,fixed=TRUE)
  code<-sub('association_group <- "choose"',paste('association_group <-',cor_group),code,fixed=TRUE)
  code<-sub('correlation_method <- "choose"',paste0('correlation_method <- "',cor_method,'"'),code,fixed=TRUE)
  capture.output(eval(parse(text=code),env))
 }
 stopifnot(env$ready,inherits(env$group_result,'htest'),length(env$x)>=3,all(is.finite(env$x)),all(is.finite(env$y)))
}
dev.off()
cat('PASS: 15 real learnr solutions; 7 incorrect attempts; state, sliders and three downloads; export and notebook renders; 24 day-2 question, test, association-group and correlation-method combinations.\n')
