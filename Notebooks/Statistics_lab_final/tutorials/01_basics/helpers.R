# Instructor implementation: student-facing code uses base R.
course <- jsonlite::fromJSON('course.json')
exercise_info <- jsonlite::fromJSON('exercises.json', simplifyVector=FALSE)
near <- function(a,b) is.numeric(a) && length(a)==length(b) && !anyNA(a) && isTRUE(all.equal(as.numeric(a),as.numeric(b),tolerance=1e-7))
valid_test <- function(x,y) inherits(x,'htest') && identical(x$method,y$method) && near(x$statistic,y$statistic) && near(x$p.value,y$p.value) && isTRUE(all.equal(x$estimate,y$estimate))
checker <- function(label,envir_result,last_value,stage,user_code='',...) {
  reply <- function(ok,yes,no) list(correct=isTRUE(ok),message=if(isTRUE(ok))yes else no,type=if(isTRUE(ok))'success' else 'info')
  if(stage=='error_check') return(reply(FALSE,'','Read the first error. Check spelling, capitals and brackets. Each editor starts fresh: keep its import and setup lines. Open a hint and try again.'))
  if(stage!='check') return(NULL)
  obj <- function(n) if(exists(n,envir_result,inherits=FALSE))get(n,envir_result) else NULL
  d<-read.csv('data/study.csv'); a<-d$BDNF[d$group==course$group_a]; b<-d$BDNF[d$group==course$group_b]
  ok<-switch(label,
    divide=near(last_value,3), multiply=near(last_value,12),
    store=near(obj('wells'),16)&&near(last_value,16),
    combine=near(obj('counts'),c(2,4,6,8))&&near(last_value,c(2,4,6,8)),
    average=near(obj('counts'),c(2,4,6))&&near(last_value,4),
    add_value=near(obj('readings'),c(4,5,6,9))&&near(last_value,6),
    rescue=near(obj('readings'),c(4,5,6))&&near(last_value,5),
    import=isTRUE(all.equal(obj('study'),d))&&near(last_value,dim(d)),
    select=near(obj('memantine_bdnf'),b)&&near(last_value,mean(b)),
    spread=near(obj('sd_saline_bdnf'),sd(a))&&near(obj('sd_memantine_bdnf'),sd(b)),
    outlier=near(obj('assay'),c(4,5,5,6,34))&&near(obj('new_mean'),10.8)&&near(obj('new_median'),5),
    missing=near(obj('observed_n'),3)&&near(obj('observed_mean'),6)&&near(obj('zero_mean'),4.5),
    histogram={h<-obj('hist_memantine_bdnf'); expected<-hist(b,breaks=seq(min(d$BDNF),max(d$BDNF),length.out=7),plot=FALSE); inherits(h,'histogram')&&near(h$breaks,expected$breaks)&&near(h$counts,expected$counts)},
    boxplot={z<-obj('comparison'); d$group<-factor(d$group,levels=c(course$group_a,course$group_b)); ref<-boxplot(BDNF~group,data=d,plot=FALSE); is.list(z)&&isTRUE(all.equal(z$stats,ref$stats))&&'stripchart'%in%all.names(parse(text=user_code))},
    scatter={v<-obj('memantine_mice'); is.data.frame(v)&&isTRUE(all.equal(v,d[d$group==course$group_b,]))&&'plot'%in%all.names(parse(text=user_code))},
    replication=near(obj('measurement_n'),1080) && near(obj('mouse_n'),72),
    quartiles=near(obj('memantine_q'),quantile(b,c(.25,.5,.75))) && near(obj('memantine_iqr'),IQR(b)),
    normality=valid_test(obj('normal_check'),shapiro.test(b)),
    welch=near(obj('mean_difference'),mean(b)-mean(a)) && valid_test(obj('welch_result'),t.test(b,a)),
    ranks=valid_test(obj('rank_result'),wilcox.test(b,a,exact=FALSE)),
    correlation={method<-obj('association_method'); v<-d[d$group=='Memantine',];
      is.character(method) && length(method)==1 && method %in% c('pearson','spearman') &&
      valid_test(obj('association_result'),cor.test(v$BDNF,v$pCREB,method=method,exact=FALSE))},
    bonferroni={aa<-d[d$group=='Saline',]; bb<-d[d$group=='Memantine',];
      raw<-vapply(c('BDNF','pCREB','NR1'),function(n)t.test(bb[[n]],aa[[n]])$p.value,numeric(1));
      near(obj('raw_p'),raw) && near(obj('adjusted_p'),p.adjust(raw,'bonferroni'))},
    FALSE)
  reply(ok,exercise_info[[label]]$success,exercise_info[[label]]$hint)
}
note_labels <- c( row='Describe one row, the measurement and its unit. Is group nominal or ordinal? Is BDNF a continuous measurement? Explain why an ID is a label even when it contains digits.',
 selection='Which animals contributed to memantine_bdnf? Explain the selection to your partner.',
 spread='Write both SDs with units. Which group varies more? Does that tell you how precisely its mean is known?',
 outlier='Which fifth reading doubles the mean? Why can the median stay fixed? Critique: “The average doubled, so every culture responded twice as much.” What would you check before deleting the unusual reading?',
 missing='How many observations contributed to observed_mean? Explain why inserting zero changes the scientific meaning. What if the assay fails more often for very high values?',
 histogram='Describe one pattern that survives changing bins and one apparent feature that disappears. What can this small sample tell us about population shape?',
 boxplot='What do the individual points reveal that a mean-only chart hides? Write a caption with units, group sizes, one pattern and one limitation.',
 scatter='Describe the association within the selected group: upward, downward or unclear? Could this plot establish that one measurement causes the other?',
 violin='Change the smoothing slider. Did any observations change? What part of the violin was estimated rather than measured?',
 exit='One thing I can now do in R; one thing I still need help with; one claim these data cannot support.',
 help='If you used an LLM or another source: I asked for __; I checked __; I now understand __.')
note_labels <- c(note_labels, "replication"="If someone copies every row twice, have we doubled the biological sample size? Report measurements and mice separately; explain what a row in study.csv represents.",
"quartiles"="Report Memantine Q1, median, Q3 and IQR with units. Complete: the middle half lies approximately between ___ and ___. Why is this not an interval for uncertainty in the mean?",
"normality"="Describe one feature of each group plot. Is a normal approximation plausible, and what remains uncertain? What would be wrong with choosing a test only from Shapiro p > 0.05?",
"welch"="In this cohort, Memantine was ___ units higher/lower on average (95% CI ___ to ___; n = ___ and ___; p = ___). What can and cannot be concluded? Distinguish individual variation (SD) from uncertainty in a mean difference.",
"ranks"="Which method would you lead with, and what does it ask? Describe whether the conclusions agree. Explain why p > 0.05 would not prove equivalence. Write a headline your partner cannot reasonably call an overclaim.",
"correlation"="Before running: which coefficient and why? Afterwards: report direction, coefficient, n and p-value (CI if provided). What other factor or shared assay process could explain the pattern?",
"bonferroni"="Name the family. Which p-values are below 0.05 before and after correction? Why is reporting only the smallest raw value misleading? Do adjusted values change the biological effect size?")
note <- function(id) shiny::textAreaInput(paste0('note_',id),note_labels[[id]],width='100%',rows=3,placeholder='Write in your own words. Download to keep your answer.')
literal <- function(x) {
 if(is.null(x)||!nzchar(trimws(x))) return('*Not yet written.*')
 # HTML entities keep prose literal even before knitr processes inline R.
 x<-gsub('&','&amp;',x,fixed=TRUE)
 x<-gsub('`','&#96;',x,fixed=TRUE)
 gsub('<','&lt;',x,fixed=TRUE)
}
hist_edges <- function(d,mode='count',bins=6,width=1) {
 r<-range(d$BDNF); padding<-diff(r)*.02; lo<-r[1]-padding; hi<-r[2]+padding
 if(mode=='count') seq(lo,hi,length.out=bins+1) else seq(lo,by=width,length.out=ceiling((hi-lo)/width)+1)
}
hist_view <- function(d,mode='count',bins=6,width=1) {
 edges<-hist_edges(d,mode,bins,width)
 values<-list(d$BDNF[d$group==course$group_a],d$BDNF[d$group==course$group_b])
 hs<-lapply(values,hist,breaks=edges,plot=FALSE); ymax<-max(vapply(hs,function(h)max(h$counts),numeric(1)))
 old<-par(mfrow=c(1,2),mar=c(5,4,3,1)); on.exit(par(old))
 for(i in 1:2) {plot(hs[[i]],col=c('#90c9cf','#edb18b')[i],main=c(course$group_a,course$group_b)[i],xlab=course$measurement,xlim=range(edges),ylim=c(0,ymax+1)); rug(values[[i]])}
}
violin_view <- function(d,adjust=1) {
 values<-list(d$BDNF[d$group==course$group_a],d$BDNF[d$group==course$group_b])
 plot(NA,xlim=c(.5,2.5),ylim=range(d$BDNF),xaxt='n',xlab='Group',ylab=course$measurement,main='Measured dots, estimated shapes')
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
 'knitr::opts_chunk$set(echo=TRUE,error=FALSE,fig.width=8,fig.height=4.5)', '```','',
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
 'These supplied reference plots record my slider settings at download time. My submitted plotting code is above. All views use the same 72-mouse table.','',
 '```{r interactive-views}',
 'local({',
 '  helper_env <- new.env()',
 '  old_dir <- getwd()',
 '  on.exit(setwd(old_dir))',
 '  setwd("tutorials/01_basics")',
 '  sys.source(paste0("helpers", ".R"), envir=helper_env)',
 '  d <- read.csv("data/study.csv")',
 sprintf('  helper_env$hist_view(d, "%s", %d, %.10g)',settings$mode %||% 'count',settings$bins %||% 6,settings$width %||% 1),
 sprintf('  helper_env$violin_view(d, %.10g)',settings$smooth %||% 1),
 '})','```','')
 for(id in c('violin','exit','help'))lines<-c(lines,paste0('### ',note_labels[[id]]),'',literal(notes[[id]]),'')
 for(label in setdiff(names(states),names(exercise_info))) {
  s<-states[[label]]
  if(identical(s$type,'question')&&length(s$answer)) lines<-c(lines,paste0('**Quiz ',label,':** ',literal(paste(s$answer,collapse='; '))),'')
 }
 c(lines,'## Before submitting','',
 '- [ ] My explanations are written in my own words and all required tasks are complete.',
 '- [ ] I restarted R, ran the notebook in order, fixed errors and checked the knitted HTML.',
 '- [ ] My captions include the measurement, units, groups, sample sizes and a limitation.',
 'Day 1 is complete. On day 2 open notebooks/02_mmse_investigation.Rmd. Keep this practice Rmd as a reference; submit the final MMSE HTML report.')
}
`%||%` <- function(a,b) if(is.null(a))b else a
