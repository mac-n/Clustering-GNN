library(dplyr)
library(ADNIMERGE)
data(adnimerge)
adnimerge$RID<-as.numeric(adnimerge$RID)
#datawithdemoandPET contains pre-processed tau-PET scores and demographic information on ADNI 
#subjects who had tau-PET scans. Data cannot be shared here as it belongs to ADNI
combined<-inner_join(datawithdemoandPET,adnimerge[!duplicated(adnimerge$RID),c("RID","APOE4")])
#check that individual CFA scores are available for these subjects. 
sum(combined$RID %in% gdscale$RID)
sum(combined$RID %in% neurobat$RID)
sum(combined$RID %in% npi_scores$RID)
sum(combined$RID %in% faq_scores$RID)
sum(combined$RID %in% mmse_scores$RID)
sum(combined$RID %in% ecogsp_scores$RID)
sum(combined$RID %in% neurobat_scores$RID)
sum(combined$RID %in% adas_scores$RID)


combined2<-inner_join(combined,gdscale[!duplicated(gdscale$RID),],by=c("RID"))
combined2<-inner_join(combined2,neurobat[!duplicated(neurobat$RID),],by=c("RID"))
combined2<-inner_join(combined2,npi_scores[!duplicated(npi_scores$RID),],by=c("RID"))
combined2<-inner_join(combined2,faq_scores[!duplicated(faq_scores$RID),],by=c("RID"))
combined2<-inner_join(combined2,mmse_scores[!duplicated(mmse_scores$RID),],by=c("RID"))
combined2<-inner_join(combined2,ecogsp_scores[!duplicated(ecogsp_scores$RID),],by=c("RID"))
combined2<-inner_join(combined2,neurobat_scores[!duplicated(neurobat_scores$RID),],by=c("RID"))
combined2<-inner_join(combined2,adas_scores[!duplicated(adas_scores$RID),],by=c("RID"))
combined2<-inner_join(combined2,ecogpt_scores[!duplicated(ecogpt_scores$RID),],by=c("RID"))
#remove anything with lots of NAS
combined2[,colSums(is.na(combined2))>3]<-NULL

combined2[,grepl("ORIGPROT|COLPROT|SITEID|USERDATE|VISCODE|EXAMDATE|SOURC",colnames(combined2))]<-NULL
#normalise APOE4 via one-hot method
combined2$APOE4<-as.factor(combined2$APOE4)
dummy<-dummyVars(~ APOE4,data=combined2)
trsf <- data.frame(predict(dummy, newdata = combined2))
trsf[is.na(trsf)]<-0
combined2<-cbind(combined2,trsf)
combined2$APOE4<-NULL


combined2<-na.omit(combined2)

#the combined dataset is used in the Python notebook data prep.ipynb

write.csv(combined2,"combinedwithquestions.csv")
