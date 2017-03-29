import<-function(filename){
	
	#Importing data 
	data <- read.delim(filename, header = TRUE, sep="", as.is=TRUE)

	#Sort is m,u,d
	data <- data[order(data[1],data[2],data[3]),]

	#Header names
	header<-colnames(data)

	#Calculating number of attributes
	noAttr<-length(data)-3-1

	#Calculating number of markets
	noM=nrow(unique(data[1]))

	#Creating a 3 dimensional list of variable length to access attributes by {market,upstream,downstream}
 	data<-setNames(data, rep(" ", length(data)))
	data<-split(data, data[[1]])
	data<-lapply(data, function(x) split(x, x[[2]]))
	#data<-lapply(data, function(x) lapply(x, function(y) lapply(y, function(z) list(z))))

	#Calculating number of upstreams and down streams in each market
	x<-(lapply(data,function(x) lapply(x,'[',2)))
	y<-lapply(x, function(y) do.call(rbind, y))
	noU<-lapply(y, function(z) lapply(z,function(k) length(unique(k))))

	x<-(lapply(data,function(x) lapply(x,'[',3)))
	y<-lapply(x, function(y) do.call(rbind, y))
	noD<-lapply(y, function(z) lapply(z,function(k) length(unique(k))))

	#Calculating distance matrices
	distanceMatrices<-lapply(data,function(x) lapply(x,'[',(3+1):(3+noAttr)))

	#Calculating matchMatrix
	matchMatrix<-lapply(data,function(x) as.vector(lapply(x,'[',3+1+noAttr)))
	matchMatrix<-lapply(seq_along(matchMatrix), function(i) lapply(seq_along(matchMatrix[[i]]), function(j) as.vector(as.matrix(matchMatrix[[i]][[j]]))))

	#Calculating mate
	mate<-lapply(matchMatrix, function(x) lapply(x,function(y) which(y==1)))
	index<-lapply(matchMatrix, function(x) 1:length(x))
	mate <- lapply(seq_along(mate), function(i){
		mate$line <-  list(index[i],mate[[i]])})

	return(list("header"=header,"noM"=noM,"noU"=noU,"noD"=noD,"noAttr"=noAttr,"distanceMatrices"=distanceMatrices,"matchMatrix"=matchMatrix,"mate"=mate))
}