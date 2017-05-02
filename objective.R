objective<-function(b){
  #objective[x1,x2,...,xn] defines the objective function to minimize, as the number of satisfied inequalities. For a specific x-vector value we get a list of numbers. The number of positives is the outcome.
  return(-(sum((matrix(unlist(dataArray,use.names=FALSE),nrow=length(dataArray),byrow=TRUE)%*%c(coefficient1,b) )>0)))
}
  
objective2<-function(b){
  #objective[x1,x2,...,xn] defines the objective function to minimize, as the number of satisfied inequalities. For a specific x-vector value we get a list of numbers. The number of positives is the outcome.
  return(-(sum((matrix(unlist(ssDataArray,use.names=FALSE),nrow=length(ssDataArray),byrow=TRUE)%*%c(coefficient1,b) )>0)))
}
