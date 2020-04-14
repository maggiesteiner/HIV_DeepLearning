## plots feature importance across whole gene region 
library(data.table)
library(ggplot2)
library(readxl)

pdf(file="cnn_imp_plots_wholesequence_nnrti.pdf")
list_names_pi = c("nfv","sqv","idv","fpv","atv","lpv","tpv","drv")
list_names_nrti = c("azt","tdf","abc","ttc","dft","ddi")
list_names_nnrti = c("efv","nvp","etr","rpv")

names_pi<-c("NFV","SQV","IDV","FPV","ATV","LPV","TPV","DRV")
names_nrti<-c("AZT","TDF","ABC","3TC","D4T","DDI")
names_nnrti<-c("EFV","NVP","ETR","RPV")

drm_list_pi<-c(30,32,46,47,48,50,54,76,82,84,88,90)
drm_list_nrti<-c(41,65,67,68,69,70,74,115,151,184,210,215)
drm_list_nnrti<-c(100,101,103,106,138,181,188,190,225,227,230)

### CHANGE TO RUN FOR EACH CLASS: PI, NRTI, NNRTI ###
list_names<-list_names_nnrti
names<-names_nnrti
drm_list<-drm_list_nnrti

for (i in 1:length(list_names)){
  name = list_names[[i]]
  imp1<-read.csv(paste(name,".fastaimp.1.cnn.csv",sep=""))
  imp2<-read.csv(paste(name,".fastaimp.2.cnn.csv",sep=""))
  imp3<-read.csv(paste(name,".fastaimp.3.cnn.csv",sep=""))
  imp4<-read.csv(paste(name,".fastaimp.4.cnn.csv",sep=""))
  imp5<-read.csv(paste(name,".fastaimp.5.cnn.csv",sep=""))
  
  imp<-rbindlist(list(imp1,imp2,imp3,imp4,imp5))[, lapply(.SD, mean), by = feature]
  imp$feature<-as.character(unlist(unlist((imp$feature))))
  imp$feature<-substring(imp$feature,2) 
  imp$feature<-as.numeric(imp$feature)
  drm_key<-c()
  for (l in 1:nrow(imp)){
    if (imp[l,feature]%in% drm_list){
      drm_key<-c(drm_key,1)
      #count=count+1
    }
    else drm_key=c(drm_key,0)
  }
  imp$drm=as.factor(drm_key)

  x<-ggplot(imp, aes(x=reorder(feature,feature), y=importance,color=drm)) + 
    geom_pointrange(aes(ymin=importance.05, ymax=importance.95,color=drm),fatten=2,size=.5) + xlab("Amino Acid Position")+ ylab("Importance") +
    ggtitle(names[i])+theme(legend.position="none")+ scale_color_manual(name="Test",values=c("grey", "darkturquoise"))+scale_x_discrete(breaks=seq(10,230,10))
  plot(x)
  
}
dev.off()

