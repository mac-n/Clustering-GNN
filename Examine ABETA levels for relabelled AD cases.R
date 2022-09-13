
#combined was generated in a previous step, "combine CFA subassessments with other data." Retains RID (participant ID) information
#datawithclusters is imported from the Python notebook, contains new_diag and cluster variables


#get participants who were relabelled (ie diagnosed as AD by algorithm but not by clinicians)
relabelled1<-combined[which(datawithclusters$new_diag!=datawithclusters$AD_LABEL),]
#get AD participants who were diagnosed as AD by both algorithm and clinicians 
stayedAD1<-combined[which(datawithclusters$new_diag==3 & datawithclusters$AD_LABEL==3),]



adnimergerelabelled<-adnimerge[adnimerge$RID %in%relabelled1$RID,]
relabelled_amyloid <-as.numeric(na.omit(adnimergerelabelled$ABETA))

adnimergestayedAD<-adnimerge[adnimerge$RID %in%stayedAD1$RID,]
stayedADamyloid<-as.numeric(na.omit(adnimergestayedAD$ABETA))



t.test(stayedADamyloid,relabelled_amyloid)


#the relabelled people have the worst amyloid scores, worse even than the ones who stayed AD.

#what makes some people more clinically functional at an objectively worse disease stage?