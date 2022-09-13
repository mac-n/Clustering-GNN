# find features most associated with each cluster
library(readr)
#read from CSV which is output by data prep.ipynb
datawithclusters <- read_csv("datawithclusters.csv")
datawithclusters<-data.frame(datawithclusters)
datwithclusters$clusters<-as.factor(newdata$clusters)
library(caret)
#convert cluster variable to 5 binary dummy variables
dummyk<-dummyVars(~ clusters,data=datawithclusters)
dummykvars<- data.frame(predict(dummyk, newdata = datawithclusters))
#remove outcome variables before re-analysis!
explorekmeans<-datawithclusters
explorekmeans$clusters<-NULL
explorekmeans$RID<-NULL
explorekmeans$newdiag<-NULL
explorekmeans$AD_LABEL<-NULL
#use each dummy variable in turn as outcome; perform feature selection by mutual information; print top 10 
library(FSelector)
temp<-list()
for (i in 1:ncol(dummykvars)){
  explorekmeans$classifier<-dummykvars[,i]
  print(paste("Cluster: ",i-1))
  temp[[i]]<-information.gain(classifier~.,data=explorekmeans)
  print(cutoff.k(temp[[i]],10))
}

