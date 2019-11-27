#TO CHANGE use list instead of by-drug


#plots 20 features with highest average importance across folds using IML output
library(data.table)
library(ggplot2)

#list_names = c("atv","ddi","etr","rpv","drv","tpv",
 #                           "lpv","sqv","nfv","fpv","idv","dft",
  #                          "abc","azt","efv","nvp","tdf","ttc") 
#pdf(file="mlp_imp_plots.pdf")
library(readxl)
# DRMS_key_pi <- read_excel("~/OneDrive/CBI/HIV_ML_Project/Code and Data Files/DRMS_key.xlsx", 
#                           sheet = "PI")
# DRMS_key_nrti <- read_excel("~/OneDrive/CBI/HIV_ML_Project/Code and Data Files/DRMS_key.xlsx", 
#                                sheet = "NRTI")
# 
# DRMS_key <- DRMS_key_nrti

list_names_pi = c("nfv","sqv","idv","fpv","atv","lpv","tpv","drv")
list_names_nrti = c("azt","tdf","abc","ttc","dft","ddi")
list_names_nnrti = c("efv","nvp","etr","rpv")


names_pi<-c("NFV","SQV","IDV","FPV","ATV","LPV","TPV","DRV")
names_nrti<-c("AZT","TDF","ABC","3TC","D4T","DDI")
names_nnrti<-c("EFV","NVP","ETR","RPV")



drm_list_pi<-c(30,32,46,47,48,50,54,76,82,84,88,90)
drm_list_nrti<-c(41,65,67,68,69,70,74,115,151,184,210,215)
drm_list_nnrti<-c(100,101,103,106,138,181,188,190,225,227,230)

list_names<-list_names_nrti
names<-names_nrti
#drm_key<-drm_key_nrti
drm_list<-drm_list_nrti

for (i in 1:length(list_names)){
  name = list_names[[i]]
  imp1<-read.csv(paste(name,".fastaimp.1.brnn.csv",sep=""))
  imp2<-read.csv(paste(name,".fastaimp.2.brnn.csv",sep=""))
  imp3<-read.csv(paste(name,".fastaimp.3.brnn.csv",sep=""))
  imp4<-read.csv(paste(name,".fastaimp.4.brnn.csv",sep=""))
  imp5<-read.csv(paste(name,".fastaimp.5.brnn.csv",sep=""))
  

  imp<-rbindlist(list(imp1,imp2,imp3,imp4,imp5))[, lapply(.SD, mean), by = feature]
  imp$feature<-as.character(unlist(unlist((imp$feature))))
  imp$feature<-substring(imp$feature,2) 
  imp$feature<-as.numeric(imp$feature)
  drm_key<-c()
  # for (l in 1:nrow(imp)){
  # if (DRMS_key[imp[l,feature],i+1]==1){
  #      drm_key<-c(drm_key,1)
  #      count=count+1
  #     }
  #    else drm_key=c(drm_key,0)
  # }
  for (l in 1:nrow(imp)){
  if (imp[l,feature]%in% drm_list){
       drm_key<-c(drm_key,1)
       #count=count+1
      }
     else drm_key=c(drm_key,0)
   }
  imp$drm=as.factor(drm_key)
  #names(drm_key)<-c("feature","drm")
  #imp <- merge(imp, drm_key, by = 'feature')
  x<-ggplot(imp[1:20,], aes(x=reorder(feature,-importance), y=importance,color=drm)) + 
              geom_pointrange(aes(ymin=importance.05, ymax=importance.95,color=drm),fatten=4,size=2) + xlab("Amino Acid Position")+ ylab("Importance") +
              ggtitle(names[i])+theme(legend.position="none")+ scale_color_manual(name="Test",values=c("grey", "darkturquoise"))
  plot(x)

}
#dev.off()


#x<-ggplot(imp, aes(x=feature, y=importance),col=drm) +
#geom_pointrange(aes(ymin=importance.05, ymax=importance.95),fatten=4,size=0.5) + xlab("Amino Acid Position")+ ylab("Importance") +
#ggtitle(paste(name," - MLP",sep=""))
# x<-ggplot(imp, aes(x=feature, y=importance)) + 
#   geom_point(shape=5,size=4) + xlab("Amino Acid Position")+ ylab("Importance") +
#   ggtitle(paste(name," - MLP",sep=""))


# drm_key_nrti<-c()
# for(i in 1:240){
#   if(i %in% c(41,65,67,68,69,70,74,115,151,184,210,215))
#     drm_key_nrti<-c(drm_key_nrti,1)
#   else
#     drm_key_nrti<-c(drm_key_nrti,0)
# }
# 
# drm_key_nnrti<-c()
# for(i in 1:240){
#   if(i %in% c(100,101,103,106,138,181,188,190,225,227,230))
#     drm_key_nnrti<-c(drm_key_nrti,1)
#   else
#     drm_key_nnrti<-c(drm_key_nrti,0)
# }
# 
# drm_key_pi<-c()
# for(i in 1:240){
#   if(i %in% c(30,32,46,47,48,50,54,76,82,84,88,90))
#     drm_key_pi<-c(drm_key_pi,1)
#   else
#     drm_key_pi<-c(drm_key_pi,0)
# }
