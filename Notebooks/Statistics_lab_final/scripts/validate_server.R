if(dir.exists('.learnr-library')) .libPaths(c(normalizePath('.learnr-library'),.libPaths()))
library(learnr); library(shiny)
setwd('tutorials/01_basics')
source('helpers.R')
text<-readLines('01_basics.Rmd'); i<-which(grepl('^```\\{r server,',text)); j<-i+which(text[(i+1):length(text)]=='```')[1]
server_code<-paste(text[(i+1):(j-1)],collapse='\n')
cache<-get('tutorial_cache_env',asNamespace('learnr')); cache$objects<-setNames(rep(list(list()),length(exercise_info)),names(exercise_info))
server<-function(input,output,session) {session$userData$tutorial_state<-reactiveValues();eval(parse(text=server_code))}
testServer(server,{
 session$setInputs(hist_mode='count',hist_bins=6,hist_width=.1,smooth=1,extreme=34,student='Student',partner='Partner',note_row='One row is one animal.')
 stopifnot(grepl('0 of 22',output$completion,fixed=TRUE),grepl('10.8',output$assay_stats,fixed=TRUE))
 stopifnot(nzchar(output$hist_explorer$src),nzchar(output$violin$src),nzchar(output$assay_plot$src))
 session$setInputs(hist_mode='width',hist_width=diff(range(read.csv('data/study.csv')$BDNF))/30,smooth=.4)
 stopifnot(nzchar(output$hist_explorer$src),nzchar(output$violin$src))
 session$setInputs(hist_bins=20,hist_mode='count',smooth=2.5)
 stopifnot(nzchar(output$hist_explorer$src),nzchar(output$violin$src))
 session$userData$tutorial_state[['divide']]<-list(type='exercise',answer='2 + 3\n12 / 4',correct=TRUE)
 session$flushReact();stopifnot(grepl('1 of 22',output$completion,fixed=TRUE))
 for(id in c('notebook','notebook_checkpoint','notebook_second','notebook_final')) {
  out<-readLines(output[[id]])
  stopifnot(any(grepl('12 / 4',out,fixed=TRUE)),any(grepl('One row is one animal.',out,fixed=TRUE)))
 }
 session$userData$tutorial_state[['divide']]<-list(type='exercise',answer='12 / 3',correct=FALSE)
 session$flushReact();stopifnot(grepl('0 of 22',output$completion,fixed=TRUE))
 out<-readLines(output$notebook_final);stopifnot(any(grepl('12 / 3',out,fixed=TRUE)),any(grepl('Review the feedback and retry',out,fixed=TRUE)))
})
cat('PASS: fresh-process server controls, state and downloads.\n')
