# Instructor implementation: student-facing code uses base R.
course <- jsonlite::fromJSON('course.json')
source('replication.R',local=TRUE)
exercise_info <- jsonlite::fromJSON('exercises.json', simplifyVector=FALSE)
near <- function(a,b) is.numeric(a) && length(a)==length(b) && !anyNA(a) && isTRUE(all.equal(as.numeric(a),as.numeric(b),tolerance=1e-7))
checker <- function(label,envir_result,last_value,stage,user_code='',...) {
  reply <- function(ok,yes,no) list(correct=isTRUE(ok),message=if(isTRUE(ok))yes else no,type=if(isTRUE(ok))'success' else 'info')
  if(stage=='error_check') return(reply(FALSE,'','Read the first error. Check spelling, capitals and brackets. Each editor starts fresh: keep its import and setup lines. Open a hint and try again.'))
  if(stage!='check') return(NULL)
  obj <- function(n) if(exists(n,envir_result,inherits=FALSE))get(n,envir_result) else NULL
  d<-read.csv('data/study.csv'); a<-d$reversal_mV[d$group==course$group_a]; b<-d$reversal_mV[d$group==course$group_b]
  reps<-read.csv('data/replicates.csv')
  ok<-switch(label,
    count_replicates=near(obj('measurement_n'),nrow(reps)) && identical(sort(as.character(obj('animal_ids'))),sort(unique(as.character(reps$sample_id)))) && near(obj('animal_n'),length(unique(reps$sample_id))),
    follow_animal=isTRUE(all.equal(obj('one_animal'),reps[reps$sample_id=="Rat_08",])) && near(obj('one_animal_n'),3),
    report_animals=near(obj('n_baseline'),7) && near(obj('n_acquisition'),6) && identical(sort(as.character(obj('baseline_ids'))),sort(as.character(d$sample_id[d$group==course$group_a]))) && identical(sort(as.character(obj('acquisition_ids'))),sort(as.character(d$sample_id[d$group==course$group_b]))),
    divide=near(last_value,3), multiply=near(last_value,12),
    store=near(obj('wells'),16)&&near(last_value,16),
    combine=near(obj('counts'),c(2,4,6,8))&&near(last_value,c(2,4,6,8)),
    average=near(obj('counts'),c(2,4,6))&&near(last_value,4),
    add_value=near(obj('readings'),c(4,5,6,9))&&near(last_value,6),
    rescue=near(obj('readings'),c(4,5,6))&&near(last_value,5),
    import=isTRUE(all.equal(obj('animals'),read.csv('data/investigation.csv')))&&near(last_value,dim(read.csv('data/investigation.csv'))),
    select=near(obj('acquisition_reversal_mV'),b)&&near(last_value,mean(b)),
    spread=near(obj('sd_baseline_reversal_mV'),sd(a))&&near(obj('sd_acquisition_reversal_mV'),sd(b)),
    outlier=near(obj('assay'),c(4,5,5,6,34))&&near(obj('new_mean'),10.8)&&near(obj('new_median'),5),
    missing=near(obj('observed_n'),3)&&near(obj('observed_mean'),6)&&near(obj('zero_mean'),4.5),
    histogram={h<-obj('hist_acquisition_reversal_mV'); expected<-hist(b,breaks=5,plot=FALSE); inherits(h,'histogram')&&near(h$breaks,expected$breaks)&&near(h$counts,expected$counts)},
    boxplot={z<-obj('comparison'); d$group<-factor(d$group,levels=c(course$group_a,course$group_b)); ref<-boxplot(reversal_mV~group,data=d,plot=FALSE); is.list(z)&&isTRUE(all.equal(z$stats,ref$stats))&&'stripchart'%in%all.names(parse(text=user_code))},
    scatter={v<-obj('acquisition_rats'); is.data.frame(v)&&isTRUE(all.equal(v,d[d$group==course$group_b,]))&&'plot'%in%all.names(parse(text=user_code))},
    FALSE)
  reply(ok,exercise_info[[label]]$success,exercise_info[[label]]$hint)
}
note_labels <- c(replication_count="The full table has ___ measurement rows from ___ distinct rats. Why can both counts be correct? Which count represents the number of animals available for biological comparisons, before choosing groups?",replication_animal="What varies within rat Rat_08, and what do these readings share? Explain what extra measurements can tell us and why they are not additional rats.",replication_copies="Predict first, then move the copy slider. Which numbers change? Why is the smaller naive standard error not evidence that new biological information was collected?",replication_report="For our original comparison, report both animal sample sizes and distinguish them from measurement counts. Explain why all 26 animals cannot be pooled into that two-group question. Recommend a defensible analysis and one design fact you would check before assuming independence.",
 row='In investigation.csv, describe one row, the measurement and its unit. Is conditioning nominal or ordinal? Is reversal_mV a continuous measurement? Explain why an ID is a label even when it contains digits.',
 selection='Which animals contributed to acquisition_reversal_mV? Explain the selection to your partner.',
 spread='Write both SDs with units. Which group varies more? Does that tell you how precisely its mean is known?',
 outlier='Which fifth reading doubles the mean? Why can the median stay fixed? Critique: “The average doubled, so every culture responded twice as much.” What would you check before deleting the unusual reading?',
 missing='How many observations contributed to observed_mean? Explain why inserting zero changes the scientific meaning. What if the assay fails more often for very high values?',
 histogram='Compare animal means and individual cells within the same protocol and phase. How do observation counts change while animal counts stay fixed? Describe a pattern that survives changing bins and a limitation of these small groups.',
 boxplot='What do the individual points reveal that a mean-only chart hides? Write a caption with units, group sizes, one pattern and one limitation.',
 scatter='Describe the association within the selected group: upward, downward or unclear? Could this plot establish that one measurement causes the other?',
 violin='Change the smoothing slider. Did any observations change? What part of the violin was estimated rather than measured?',
 exit='One thing I can now do in R; one thing I still need help with; one claim these data cannot support.',
 help='If you used an LLM or another source: I asked for __; I checked __; I now understand __.')
note <- function(id) shiny::textAreaInput(paste0('note_',id),note_labels[[id]],width='100%',rows=3,placeholder='Write in your own words. Download to keep your answer.')
literal <- function(x) {
 if(is.null(x)||!nzchar(trimws(x))) return('*Not yet written.*')
 x<-gsub('`','\\`',x,fixed=TRUE); gsub('<','&lt;',x,fixed=TRUE)
}
hist_edges <- function(d,mode='count',bins=6,width=1) {
 r<-range(d$reversal_mV); padding<-diff(r)*.02; lo<-r[1]-padding; hi<-r[2]+padding
 if(mode=='count') seq(lo,hi,length.out=bins+1) else seq(lo,by=width,length.out=ceiling((hi-lo)/width)+1)
}
hist_data <- function(level='animals') {
 read.csv(if(identical(level,'cells')) 'data/replicates.csv' else 'data/investigation.csv')
}
hist_panels <- function(d) {
 panels <- expand.grid(phase=c('Baseline','Acquisition','Plateau'),conditioning=c('Paired','Unpaired'),stringsAsFactors=FALSE)
 panels$observations <- panels$animals <- 0L
 for(i in seq_len(nrow(panels))) {
  selected <- d[d$conditioning==panels$conditioning[i] & d$phase==panels$phase[i] & !is.na(d$reversal_mV),]
  panels$observations[i] <- nrow(selected)
  panels$animals[i] <- length(unique(selected$sample_id))
 }
 panels
}
hist_view <- function(d=hist_data(),mode='count',bins=6,width=1,level='animals') {
 # Use the cell range for fixed bin boundaries across both levels: means lie inside it.
 edges <- hist_edges(hist_data('cells'),mode,bins,width)
 panels <- hist_panels(d)
 hs <- lapply(seq_len(nrow(panels)),function(i) hist(d$reversal_mV[d$conditioning==panels$conditioning[i] & d$phase==panels$phase[i]],breaks=edges,plot=FALSE))
 ymax <- max(vapply(hs,function(h)max(h$counts),numeric(1)))
 old <- par(mfrow=c(2,3),mar=c(4,4,4,1),oma=c(0,0,2,0),cex=1); on.exit(par(old))
 for(i in seq_len(nrow(panels))) {
  title <- sprintf('%s / %s\n%d %s from %d rats',panels$conditioning[i],panels$phase[i],panels$observations[i],if(level=='cells')'cells' else 'means',panels$animals[i])
  plot(hs[[i]],col=if(panels$conditioning[i]=='Paired')'#90c9cf' else '#edb18b',main=title,cex.main=.95,
       xlab=if(level=='cells')'Cell GABA reversal potential (mV)' else 'Rat mean GABA reversal potential (mV)',
       ylab=if(level=='cells')'Cells' else 'Rats',xlim=range(edges),ylim=c(0,ymax+1))
  rug(d$reversal_mV[d$conditioning==panels$conditioning[i] & d$phase==panels$phase[i]])
 }
 mtext(if(level=='cells')'All 47 cells from 26 rats: cells within a rat are not independent animals' else 'All 26 rats: one mean per animal',outer=TRUE,cex=.95)
}
violin_view <- function(d,adjust=1) {
 values<-list(d$reversal_mV[d$group==course$group_a],d$reversal_mV[d$group==course$group_b])
 plot(NA,xlim=c(.5,2.5),ylim=range(d$reversal_mV),xaxt='n',xlab='Group',ylab=course$measurement,main='Measured dots, estimated shapes')
 axis(1,1:2,c(course$group_a,course$group_b))
 for(i in 1:2) {
  x<-values[[i]]; den<-density(x,adjust=adjust,from=min(x),to=max(x)); width<-.32*den$y/max(den$y)
  polygon(c(i-width,rev(i+width)),c(den$x,rev(den$x)),col=c('#90c9cf','#edb18b')[i],border=NA)
  points(rep(i,length(x)),x,pch=16); segments(i-.15,median(x),i+.15,median(x),lwd=3)
 }
}
# Export assembles the helper filename to avoid recursive self-discovery in rmarkdown.
export_notebook <- function(states,notes,student='',partner='',settings=list()) {
 lines<-c('---',paste0('title: "',course$title,': my first R notebook"'),'output:', '  html_document:', '    toc: true','    self_contained: true','    mathjax: null','---','',
 paste0('**Name:** ',literal(student),'  \n**Partner:** ',literal(partner)),'',
 'Save in notebooks/. Restart R, run the setup chunk, then all chunks in order; click Knit. Latest submitted code and current written answers are included. A passed code check does not assess your explanation.',
 '', '```{r setup, include=FALSE}',
 'root <- normalizePath(if (file.exists("Statistics_lab.Rproj")) "." else "..")',
 'stopifnot(file.exists(file.path(root,"Statistics_lab.Rproj")))',
 'knitr::opts_knit$set(root.dir=root)',
 'knitr::opts_chunk$set(echo=TRUE,error=TRUE,fig.width=8,fig.height=4.5)', '```','',
 course$question,course$story,course$row,paste0('Source: ',course$source),'')
 for(label in names(exercise_info)) {
  s<-states[[label]]; submitted<-length(s$answer)>0
  status<-if(!submitted)'Not submitted' else if(isTRUE(s$correct))'Feedback check passed' else 'Review the feedback and retry'
  code<-if(submitted)paste(s$answer,collapse='\n')else '# Not submitted: complete this task in the tutorial or here.'
  runs<-regmatches(code,gregexpr('`+',code))[[1]]; fence<-paste(rep('`',max(c(3,nchar(runs)+1))),collapse='')
  e<-exercise_info[[label]]
  lines<-c(lines,paste0('## ',e$title),'',e$task,'',paste0('**Status:** ',status),'',paste0(fence,'{r ',label,'}'),code,fence,'')
  if(!is.null(e$note)) lines<-c(lines,paste0('**',note_labels[[e$note]],'**'),'',literal(notes[[e$note]]),'')
 }
 lines<-c(lines,'## My interactive views','',
 'These supplied reference plots record my slider settings at download time. My submitted plotting code is above. The replication copy experiment deliberately duplicates existing rows: it collects no new animals, and its naive standard error is not valid evidence of increased biological precision. Source data are unchanged.','',
 '```{r interactive-views, fig.width=12, fig.height=7}',
 'local({',
 '  helper_env <- new.env()',
 '  old_dir <- getwd()',
 '  on.exit(setwd(old_dir))',
 '  setwd("tutorials/01_basics")',
 '  sys.source(paste0("helpers", ".R"), envir=helper_env)',
 '  d <- read.csv("data/study.csv")',
 sprintf('  helper_env$hist_view(helper_env$hist_data("%s"), "%s", %d, %.10g, level="%s")',settings$level %||% 'animals',settings$mode %||% 'count',settings$bins %||% 6,settings$width %||% 1,settings$level %||% 'animals'),
 sprintf('  helper_env$violin_view(d, %.10g)',settings$smooth %||% 1),
 sprintf('  helper_env$replication_plot(read.csv("data/replicates.csv"), owners=%s)',if(isTRUE(settings$owners))'TRUE' else 'FALSE'),
 sprintf('  print(helper_env$copy_summary(d, %d))',settings$copies %||% 1),
 sprintf('  helper_env$copy_plot(d, %d)',settings$copies %||% 1),
 '})','```','')
 for(id in c('violin','replication_copies','exit','help'))lines<-c(lines,paste0('### ',note_labels[[id]]),'',literal(notes[[id]]),'')
 for(label in setdiff(names(states),names(exercise_info))) {
  s<-states[[label]]
  if(identical(s$type,'question')&&length(s$answer)) lines<-c(lines,paste0('**Quiz ',label,':** ',literal(paste(s$answer,collapse='; '))),'')
 }
 c(lines,'## Before submitting','',
 '- [ ] My explanations are written in my own words and all required tasks are complete.',
 '- [ ] I restarted R, ran the notebook in order, fixed errors and checked the knitted HTML.',
 '- [ ] My captions include the measurement, units, groups, sample sizes and a limitation.',
 'Continue with notebooks/03_statistical_analysis.Rmd. On day 2 use notebooks/04_investigation.Rmd. Keep this Rmd and submit your final HTML as directed.')
}
`%||%` <- function(a,b) if(is.null(a))b else a
