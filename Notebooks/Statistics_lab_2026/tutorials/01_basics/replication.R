# Supplied visual aids: all dots retain their original measured values.
replication_plot <- function(reps, owners=FALSE) {
 mouse <- course$variant == 'mouse'
 selected <- if(mouse) reps[reps$genotype=='Control' & reps$treatment=='Memantine' & reps$learning=='C/S',] else reps[reps$conditioning=='Paired' & reps$phase=='Acquisition',]
 ids <- head(unique(as.character(selected$sample_id)),4)
 selected <- selected[as.character(selected$sample_id) %in% ids,]
 y <- if(mouse) selected$BDNF else selected$reversal_mV
 group <- match(as.character(selected$sample_id),ids)
 offset <- ave(seq_along(y),group,FUN=function(x) seq(-.16,.16,length.out=length(x)))
 x <- if(isTRUE(owners)) group+offset else 1+seq(-.3,.3,length.out=length(y))
 palette <- c('#0072B2','#D55E00','#009E73','#CC79A7')
 plot(x,y,pch=19,col=if(isTRUE(owners))palette[group] else '#536878',xaxt='n',xlab='',
      xlim=if(isTRUE(owners))c(.5,4.5) else c(.5,1.5),
      ylab=if(mouse)'BDNF relative signal' else 'Cell reversal potential (mV)',
      main=sprintf('%d observed readings from four selected animals',sum(!is.na(y))))
 axis(1,at=if(isTRUE(owners))1:4 else 1,labels=if(isTRUE(owners))ids else 'Pooled readings')
 mtext('Horizontal offsets separate dots; they do not encode another measurement.',side=1,line=3,cex=.8)
}
copy_summary <- function(d,copies=1) {
 copies <- if(is.null(copies))1 else as.integer(copies)
 selected <- d[d$group==course$group_a,]
 original <- if(course$variant=='mouse')selected$BDNF else selected$reversal_mV
 original <- original[!is.na(original)]
 copied <- rep(original,times=copies)
 data.frame(Rows=length(copied),Distinct_animals=length(original),Mean=mean(copied),
            Naive_SE=sd(copied)/sqrt(length(copied)),Animal_SE=sd(original)/sqrt(length(original)))
}
copy_plot <- function(d,copies=1) {
 copies <- if(is.null(copies))1 else as.integer(copies)
 values <- vapply(1:10,function(k)copy_summary(d,k)$Naive_SE,numeric(1))
 reference <- copy_summary(d,1)$Animal_SE
 plot(1:10,values,type='b',pch=19,col='#D55E00',ylim=c(0,reference*1.3),
      xlab='Copies of each existing row',ylab=paste('Standard error:',course$measurement),
      main=paste(course$group_a,': copying rows collects no new animals'))
 abline(h=reference,lty=2,col='#0072B2',lwd=2)
 points(copies,values[copies],pch=21,bg='#D55E00',cex=1.7)
 legend('topright',c('Naive SE: copied rows treated as independent','SE from original animal-level values'),
        col=c('#D55E00','#0072B2'),lty=c(1,2),bty='n',cex=.8)
}
