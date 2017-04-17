export<-function(filename){
  y<-do.call("rbind",lapply(seq_along(distanceMatrices),function(i) do.call("rbind", lapply(seq_along(distanceMatrices[[i]]),function(j) matrix(unlist(lapply(seq_along(1:nrow(distanceMatrices[[i]][[j]])),function(k) c(i,j,k,as.numeric(distanceMatrices[[i]][[j]][k,]),matchMatrix[[i]][[j]][[k]])),recursive =FALSE),ncol=(4+noAttr),byrow=TRUE)))))
  write.table(y, file=filename, col.names=header,row.names=FALSE, sep="\t", quote=FALSE)
}