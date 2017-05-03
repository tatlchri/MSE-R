groupIDs<-function(ineqmembers){
return(unlist(lapply(seq_along(ineqmembers),function(x) lapply(seq_along(ineqmembers[[x]][[1]]),function(y) c(x)))))
}