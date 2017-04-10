CdataArray<-function(distanceMatrices,ineqmembers){
  #CdataArray creates the dataArray.  It uses ineqmembers and distanceMatrices
  
   return(unlist(lapply(seq_along(ineqmembers),function(x) lapply(seq_along(ineqmembers[[x]][[1]]),function(y) ((Reduce("+",lapply(seq_along(ineqmembers[[x]][[1]][[y]]), function(k) colSums(distanceMatrices[[ineqmembers[[x]][[1]][[y]][[k]][1]]][[ineqmembers[[x]][[1]][[y]][[k]][2]]][ineqmembers[[x]][[1]][[y]][[k]][3],]-distanceMatrices[[ineqmembers[[x]][[2]][[y]][[k]][1]]][[ineqmembers[[x]][[2]][[y]][[k]][2]]][ineqmembers[[x]][[2]][[y]][[k]][3],] ))))))),recursive=FALSE))
}
