sdRplot<-function(nx,sl,ny,x){
#
# R function that can be used for creating Semantic Differential 
# (SD) inventory plots.  The input arguments for the function are:
#   nx - number of levels in scale, e.g., 5
#   sl - scale labels as a list, e.g. c("SA","A","N","A","SA")
#   ny - number of descriptor items in the inventory
#   x - data matrix: 
#              col1: low-end descriptors 
#              col2: high-end descriptors
#              col3-onwards: mean scale values for each group
# The names of the columns (col 3 and above) of the data matrix 
# (e.g., dimnames(x[[2]][3:ncol(x)])) are used for labelling 
# the groups in the legend.
# Author: Justine Leon A. Uro (justineuro@gmail.com)
# Date: 19 October 2011 orig.
#       06 January 2021 rev. to allow plotting for data on only one group (l. 60)
#       29 July 2021 rev. moved drawing of axis() before legend(); 
#                         added white opaque background (bg="white"); 
#                         cex.lab=1.0 for xlab and ylab size
#
# Example:
# low<-c("Serious","Slow","Useless","Tiring","Old","Hard","Long")
# high<-c("Fun","Fast","Useful","Light","New","Easy","Short")
# scale<-c("SA","A","N","A","SA")
# grp1means<-c(4.2,4.6,4.3,4.1,4.5,4.5,4.0)
# grp2means<-c(3.8,3.9,3.7,4.5,4.4,4.3,4.4)
# grp3means<-c(4.5,4.7,4.4,4.2,4.6,4.4,3.9)
# data<-matrix(
#      cbind(low,high,grp1means,grp2means,grp3means),
#      nrow=7,ncol=5,byrow=FALSE,
#      dimnames=list(c("I1","I2","I3","I4","I5","I6","I7"),
#                    c("Low","High","Grp1","Grp2","Grp3"))
#     )
# sdRplot(5,scale,7,data)
#
NSCALE<-nx
NLAB<-ny
NRW<-nrow(x)
NCL<-ncol(x)
NGRP<-ncol(x)-2
GRPNMS<-dimnames(x)[[2]][3:NCL]
yval<-NLAB:1
labvaln<-x[,1]
labvalp<-x[,2]
# plot means of first group (points and line, type="b")
plot(x[,3],yval,axes=F,pch=1,col=1,type="b",
     xlab="Mean SD Scale Value",ylab="Descriptor",
     cex.lab=1.0, # size of xlab, ylab
     xlim=c(0.30,NSCALE+0.95),
     lab=c(NSCALE,NLAB+2,1),mgp=c(3,1,0),xaxs="r",
     mar=c(7,7,1,1)
     )
# add title
title(main="SD Response Profiles",
      sub="",
      cex.sub=0.50
      )
# draw vertical axes
axis(1,tck=1,at=c(1:NSCALE),labels=sl,cex.axis=0.60)
# draw legend with opaque white background
legend(1.25,NLAB-0.5,title="Legend:",GRPNMS,
       title.col="black",
       text.col=1:NGRP,
       pch=1:NGRP,lty=1:NGRP,
       col=1:NGRP,cex=0.60,
       bg="white"
       )
# skip this if there is only 1 group
  if(NGRP>1){
    for(i in 2:NGRP){
      points(x[,i+2],yval,pch=i,col=i)
      lines(x[,i+2],yval,pch=i,col=i,lty=i)
    }
  }
# draw the labels for the tick marks on the axes
  for (i in 1:NLAB)
  {
    text(0.90,yval[i],label=labvaln[i],adj=1,cex=0.70) # cex = size of marks
    text(NSCALE+0.10,yval[i],label=labvalp[i],adj=0,cex=0.70)
  }
}
#
##
###