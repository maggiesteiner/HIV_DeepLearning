setwd("~/Desktop/Research/GW CBI/HIV ML")
library(readxl)
library(ggplot2)
imp_plot_data_pi <- read_excel("imp_plot_data.xlsx", sheet = "PI")
imp_plot_data_nrti <- read_excel("imp_plot_data.xlsx", sheet = "NRTI")
imp_plot_data_nnrti <- read_excel("imp_plot_data.xlsx", sheet = "NNRTI")

all_imp_pi = stack(imp_plot_data_pi)
all_imp_nrti = stack(imp_plot_data_nrti)
all_imp_nnrti = stack(imp_plot_data_nnrti)

drm_list_pi<-c(30,32,46,47,48,50,54,76,82,84,88,90)
drm_list_nrti<-c(41,65,67,68,69,70,74,115,151,184,210,215)
drm_list_nnrti<-c(100,101,103,106,138,181,188,190,225,227,230)

drm_key_pi = c()
for (l in 1:nrow(all_imp_pi)){
  if (all_imp_pi[l,"values"]%in% drm_list_pi){
    drm_key_pi<-c(drm_key_pi,1)
  }
  else drm_key_pi=c(drm_key_pi,0)
}
all_imp_pi$drm=as.factor(drm_key_pi)

levels(all_imp_pi$drm)[levels(all_imp_pi$drm)=='0']<-'No known DRM-ssociation'
levels(all_imp_pi$drm)[levels(all_imp_pi$drm)=='1']<-'Known DRM-associated position'


plot1 = ggplot(data=all_imp_pi,aes(all_imp_pi$values, fill=drm)) + geom_histogram(bins=99) + 
        scale_fill_manual(values=c("grey", "darkturquoise")) +xlab("Position") +ylab("Frequency")+
        ggtitle("Frequency of Features in 20 Most Important Features of CNN Models - PI") + theme(legend.title = element_blank()) +
        theme(legend.position="bottom")+ scale_x_continuous(breaks=seq(0,100,10))
        
plot(plot1)


drm_key_nrti = c()
for (l in 1:nrow(all_imp_nrti)){
  if (all_imp_nrti[l,"values"]%in% drm_list_nrti){
    drm_key_nrti<-c(drm_key_nrti,1)
  }
  else drm_key_nrti=c(drm_key_nrti,0)
}
all_imp_nrti$drm=as.factor(drm_key_nrti)

levels(all_imp_nrti$drm)[levels(all_imp_nrti$drm)=='0']<-'No known DRM-ssociation'
levels(all_imp_nrti$drm)[levels(all_imp_nrti$drm)=='1']<-'Known DRM-associated position'


plot2 = ggplot(data=all_imp_nrti,aes(all_imp_nrti$values, fill=drm)) + geom_histogram(bins=240) + 
  scale_fill_manual(values=c("grey", "darkturquoise")) +xlab("Position") +ylab("Frequency")+
  ggtitle("Frequency of Features in 20 Most Important Features of CNN Models - NRTI") + theme(legend.title = element_blank()) +
  theme(legend.position="bottom")+ scale_x_continuous(breaks=seq(0,240,10))

plot(plot2)

drm_key_nnrti = c()
for (l in 1:nrow(all_imp_nnrti)){
  if (all_imp_nnrti[l,"values"]%in% drm_list_nnrti){
    drm_key_nnrti<-c(drm_key_nnrti,1)
  }
  else drm_key_nnrti=c(drm_key_nnrti,0)
}
all_imp_nnrti$drm=as.factor(drm_key_nnrti)

levels(all_imp_nnrti$drm)[levels(all_imp_nnrti$drm)=='0']<-'No known DRM-ssociation'
levels(all_imp_nnrti$drm)[levels(all_imp_nnrti$drm)=='1']<-'Known DRM-associated position'


plot2 = ggplot(data=all_imp_nnrti,aes(all_imp_nnrti$values, fill=drm)) + geom_histogram(bins=240) + 
  scale_fill_manual(values=c("grey", "darkturquoise")) +xlab("Position") +ylab("Frequency")+
  ggtitle("Frequency of Features in 20 Most Important Features of CNN Models - NNRTI") + theme(legend.title = element_blank()) +
  theme(legend.position="bottom") + scale_x_continuous(breaks=seq(0,240,10))

plot(plot2)



