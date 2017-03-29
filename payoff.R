Cx<-function(n){
  #Cx(n) creates a list of n variables named x1,x2,...,xn.
  if (n==0){
    return()
  }else{
    Cx<-paste("x",seq( from = 1, to = n, by = 1 ),sep="")
    
    return(Cx)
  }
}


payoffDM<-function(Cx,distanceMatrices,noAttr,m,i,j){
  #payoffDM(Cx,distanceMatrices,noAttr,m,i,j) returns the payoff of i-upstream and j-upstream in the m-market
  
  x<-as.numeric((distanceMatrices[[m]][i][[1]][j,]))*Sym(c(1,Cx[1:noAttr-1]))
  y<-""
  for(i in 1:noAttr){
    y<-y+Sym(x[i])
  }
  
  return(y)
  
}

CpayoffMatrix<-function(noM,noU,noD,Cx,distanceMatrices,noAttr){
  #payoffMatrix=CpayoffMatrix(noM,noU,noD,Cx,distanceMatrices,noAttr) calculates and assigns the payoffMatrix 
  
  CpayoffMatrix<-rep(list(list()),noM)
  CpayoffMatrix<-lapply(seq_along(CpayoffMatrix),function(i) rep(list(rep(list(list()),noD[[i]])),noU[[i]]))
  CpayoffMatrix<-lapply(seq_along(CpayoffMatrix), function(i) lapply(seq_along(CpayoffMatrix[[i]]),function(j) lapply(seq_along(CpayoffMatrix[[i]][[j]]),function(k) payoffDM(Cx,distanceMatrices,noAttr,i,j,k))))
  return(CpayoffMatrix)
}

assignpayoffMatrix<-function(payoffMatrix,xval){
  #assignpayoffMatrix(payoffMatrix,xval) assigns payoffMatrix numerical values (set x's)
  Cx<-paste("x",seq( from = 1, to = noAttr-1, by = 1 ),sep="")
  x<-lapply(seq_along(xval), function(i) xval[i])
  names(x)<-Cx
  return(lapply(seq_along(payoffMatrix),function(i) lapply(seq_along(payoffMatrix[[i]]), function(j) lapply(seq_along(payoffMatrix[[i]][[j]]),function(k) eval(parse(text=payoffMatrix[[i]][[j]][[k]]),x)))))
}


