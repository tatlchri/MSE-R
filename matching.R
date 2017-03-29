generateAssignmentMatrix<-function(payoffs,quotaU,quotaD){

	numU <-dim(payoffs)[1]
	numD <-dim(payoffs)[2]

	#m1 is the first third of the constraint matrix.It represents the constraint\sum{x_ {ij}}_ {i=1}^n<=quotaD for all j
	m1<-matrix(as.vector(outer(cbind(rep(1,numD)),data.matrix(diag(numU)))
	),nrow = numU ,ncol = numD*numU ,byrow=TRUE)


	#m2 is the second third of the constraint matrix.It represents the constraint\sum{x_ {ij}}_ {j=1}^n<=quotaU for all i
	m2<-matrix(outer(diag(numD),rep(1,numU)),nrow=numD,ncol=numD*numU)

	#m3 is the last third of the constraint matrix.It represents the constraint that each pair of people can only match with each other once
	m3<-diag(numU*numD)

	m<-rbind(m1,m2,m3)

	b<-c(rep(quotaU,numU),rep(quotaD,numD),rep(1,numU*numD))



	f.obj <-as.vector(t(payoffs))
	f.con <-m
	f.dir<-rep("<=",numU+numD+numU*numD)
	f.rhs <-b
	result<-lp ("max", f.obj, f.con, f.dir, f.rhs)$solution

	return(split(matrix(result,nrow=numU,ncol=numD,byrow=TRUE),c(row(matrix(result,nrow=numU,ncol=numD,byrow=TRUE)))))
}

	

CmatchMatrix<-function(payoffMatrix,quotaU,quotaD){
  #matchMatrix[payoffMatrix,quotaU,quotaD] creates the matchMatrix by running generateAssignmentMatrix routine for all markets. For the moment quota's are fixed numbers the same accross all markets.
  #lapply(seq_along(x),function(i) lapply(seq_along(x[[i]]), function(j) lapply(seq_along(x[[i]][[j]]),function(k) eval(parse(text=x[[i]][[j]][[k]]),list(x1=3,x2=2)))))
  
  return(lapply(seq_along(payoffMatrix), function(i) generateAssignmentMatrix(matrix(unlist(payoffMatrix[[i]]),nrow=length(payoffMatrix[[i]]),byrow=TRUE),1,1)))
}

Cmates<-function(matchMatrix){
  #Cmates[matchMatrix] simplifies matchMatrix to a list of triples that define matches across all markets. Example :{{{1,1,3},{1,3,1},{1,3,2}},{{2,1,1},{2,2,1},{2,2,3},{2,3,2}}}. This is mainly used for the calculation of the total payoff - see Ctotalpayoff routine.
  return(lapply(seq_along(matchMatrix),function(i) lapply(seq_along(matchMatrix[[i]]),function(j) c(i,j,which(round(matchMatrix[[i]][[j]])==1)))))
}

Cmate<-function(matchMatrix){
  #Cmate[matchMatrix] simplifies matchMatrix to pairs of lists, one pair per market. The first part is the normal numbering and the second is the corespondance. Example : {{{{1},{2},{3}},{{3},{},{1,2}}},{{{1},{2},{3}},{{1},{1,3},{2}}}}. This is the prevailing way to express mates. This is feeded to the Cineqmembers routine.
  mate<-lapply(matchMatrix, function(x) lapply(x,function(y) which(round(y)==1)))
  index<-lapply(matchMatrix, function(x) 1:length(x))
  mate <- lapply(seq_along(mate), function(i){
    mate$line <-  list(index[i],mate[[i]])})
  
  return(mate)
  
}
	