maximize<-function(par){
  #maximize is MSE specific and uses the optimize method. It uses objective function (that counts the number of satisfied inequalities).";
  
  
  lower       <-  par["lower"][[1]]
  upper       <-  par["upper"][[1]]
  NP          <-  par["NP"][[1]]
  itermax     <-  par["itermax"][[1]]
  trace       <-  par["trace"][[1]]
  reltol      <-  par["reltol"][[1]]
  CR          <-  par["CR"][[1]]
  F           <-  par["F"][[1]]
  RandomSeed  <-  par["RandomSeed"][[1]]
  
  set.seed(RandomSeed)
  
  outDEoptim<-DEoptim(objective, lower, upper, control=list(NP=NP, itermax=itermax,trace=trace,reltol=reltol,
                                                            CR=CR,F=F))
  bestmem<-outDEoptim$optim$bestmem
  bestval<--outDEoptim$optim$bestval
  return(list("bestmem"=bestmem,"bestval"=bestval))
  
}


maximize2<-function(par){
  #maximize is MSE specific and uses the optimize method. It uses objective function (that counts the number of satisfied inequalities).";
  
  
  lower       <-  par["lower"][[1]]
  upper       <-  par["upper"][[1]]
  NP          <-  par["NP"][[1]]
  itermax     <-  par["itermax"][[1]]
  trace       <-  par["trace"][[1]]
  reltol      <-  par["reltol"][[1]]
  CR          <-  par["CR"][[1]]
  F           <-  par["F"][[1]]
  RandomSeed  <-  par["RandomSeed"][[1]]
  
  set.seed(RandomSeed)
  
  outDEoptim<-DEoptim(objective2, lower, upper, control=list(NP=NP, itermax=itermax,trace=trace,reltol=reltol,
                                                            CR=CR,F=F))
  bestmem<-outDEoptim$optim$bestmem
  bestval<--outDEoptim$optim$bestval
  return(list("bestmem"=bestmem,"bestval"=bestval))
  
}