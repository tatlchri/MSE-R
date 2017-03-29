#Install required packages
if (!"Matrix" %in% installed.packages()) install.packages("Matrix")
if (!"lpSolve" %in% installed.packages()) install.packages("lpSolve")
if (!"dplyr" %in% installed.packages()) install.packages("dplyr")
if (!"Ryacas" %in% installed.packages()) install.packages("Ryacas")
if (!"doSNOW" %in% installed.packages()) install.packages("doSNOW")
if (!"foreach" %in% installed.packages()) install.packages("foreach")

#Import installed packages
library(Matrix)
library(lpSolve)
library(dplyr)
library(Ryacas)
library(doSNOW)
library(foreach)

#Import functions
source("import.R")
source("matching.R")
source("payoff.R")
source("assignList.R")