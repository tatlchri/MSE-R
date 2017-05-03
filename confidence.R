generateRandomSubsample<-function(ssSize,groupIDs,dataArray,seed){
  #generateRandomSubsample[ssSize,groupIDs,dataArray] generates a subsample of a given size from a data array.
  totalgroups<-unique(groupIDs)
  set.seed(seed)
  groups<-sort(sample(totalgroups,ssSize))
  
  #Get the indexes of the dataArray rows that correspond to selected groups
  qualifiedIndexes<-unlist(lapply(seq_along(groups),function(x) (which(groupIDs==groups[x]))))
  
  return(dataArray[qualifiedIndexes])
}

pointIdentifiedCR<-function(ssSize, numSubsamples,pointEstimate,args,groupIDs,dataArray,options,par){
  #pointIdentifiedCR[ssSize,numSubsamples,pointEstimate,args,groupIDs,dataArray,method,permuteinvariant,options] generates a confidence region estimate using subsampling
  #Parameters:
  #ssSize - The size of each subsample to be estimated.
  #numSubsamples -The number of subsamples to use in estimating the confidence region.
  #pointEstimate - The point estimate to build the confidence region around (typically the output of pairwiseMSE).
  #objFunc - The objective function used in pairwiseMSE.
  #args - A list of unique symbols used in pairwiseMSE.
  #groupIDs - A data map used to generate the subsamples.
  #dataArray - The dataArray parameter used in pairwiseMSE.
  #options - An optional parameter specifying options. Available options are:
    #progressUpdate - How often to print progress (0 to disable).Default=0.
    #confidenceLevel - The confidence level of the region.Default=.95.
    #asymptotics - Type of asymptotics to use (nests or coalitions).Default=nests.
    #subsampleMonitor - An expression to evaluate for each subsample.Default=Null.
    #symmetric - True or False.If True,the confidence region will be symmetric.Default=False.
  
  
  progress <-options[["progressUpdate"]]
  confLevel<-options[["confidenceLevel"]]
  asymp    <-options[["asymptotics"]]
  sym      <-options[["symmetric"]]
  
  
  #This block sets variables that are slightly different for each of the 
  #two asymptotics.subNormalization is the standardization multiplier 
  #for the subsamples, fullNormalization is the multiplier for the 
  #construction of the final confidence interval from all of the subsamples.
  
  switch(asymp,
         "nests" = {
            subNormalization <-(ssSize)^(1/3)
            fullNormalization <- (length(unique(groupIDs)))^(1/3)
  
         },
         
         "coalitions"={
            subNormalization <- (ssSize)^(1/2)
            fullNormalization <-(length(unique(groupIDs)))^(1/2)
         }
  )
  
  estimates  <-matrix(0, nrow = numSubsamples, ncol = length(args)-1)  #List of standardized subsample estimates.
  ssEstimates<-matrix(0, nrow = numSubsamples, ncol = length(args)-1)  #List of raw subsample estimates.
  
  for (i in 1:numSubsamples){
    set.seed(i*1000)
    ssDataArray<-generateRandomSubsample(ssSize, groupIDs, dataArray,i*1000)
    
    
    
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
    objective2<-function(b){
      #objective[x1,x2,...,xn] defines the objective function to minimize, as the number of satisfied inequalities. For a specific x-vector value we get a list of numbers. The number of positives is the outcome.
      return(-(sum((matrix(unlist(ssDataArray,use.names=FALSE),nrow=length(ssDataArray),byrow=TRUE)%*%c(coefficient1,b) )>0)))
    }
    outDEoptim<-DEoptim(objective2, lower, upper, control=list(NP=NP, itermax=itermax,trace=trace,reltol=reltol,
                                                               CR=CR,F=F))
    bestmem<-outDEoptim$optim$bestmem
    bestval<--outDEoptim$optim$bestval
    
    
    ssEstimates[i,]<-bestmem
    estimates[i,]<-subNormalization*(ssEstimates[i,] - pointEstimate)
    if (progress>0 && i%%progress==0)
      cat(sprintf("Iterations completed: %d \n",i ))
  }
  
  plot(c(col(estimates)),c(estimates),type="p",col="blue",xlab="",ylab="")
  abline(h = 0, v = 0)
  alpha <- 1 - confLevel
  
  cr1<-list()
  cr2<-list()
  
  for (i in 1:(length(args)-1)){
    cr1[[i]]=pointEstimate[i]-rev(c(-1,1)*quantile(abs(estimates[,i]),c(1 - alpha, 1 - alpha),names=FALSE,type=1))/fullNormalization
    cr2[[i]]=pointEstimate[i]-rev(quantile((estimates[,i]),c(alpha/2, 1 - alpha/2),names=FALSE,type=1))/fullNormalization
  }
  #For the symmetric case, we want to add and subtract the 1 - alpha' th quantile
  #from the point estimate.We take the Abs here for simplicity : tn*Abs[x - y] == Abs[tn*(x - y)]
  
  #For the asymmetric case we separately take the alpha/2 and 1 - alpha/2 quantiles 
  #and subtract them.Keep in mind that since estimates has its mean subtracted,
  #only in freakishly unlikely cases will these two have the same sign.This is 
  #not true for the symmetric case.
  return(list(list("Symmetric case",cr1),list("Asymmetric case",cr2),estimates))
}

