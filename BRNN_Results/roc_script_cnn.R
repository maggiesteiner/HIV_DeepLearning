require(pROC)
require(ggpubr)
require(data.table)

#pdf(file="mlp_roc_plots.pdf")
auc_df_cnn<-data.frame()
list_names = c("atv","ddi","etr","rpv","drv","tpv",
               "lpv","sqv","nfv","fpv","idv","dft",
               "abc","azt","efv","nvp","tdf","ttc") 
for (i in 1:length(list_names)){
  name = list_names[[i]]
  plot.new()
  file1 = read.csv(paste(name,".fastaroc.1.cnn.csv",sep=""))
  x1<-roc(data=file1,response="validation_labels_k",predictor="X.1")
  #x1<-ggroc(x)
  
  file2 = read.csv(paste(name,".fastaroc.2.cnn.csv",sep=""))
  x2<-roc(data=file2,response="validation_labels_k",predictor="X.1")
  #x2<-ggroc(x2)
  
  file3 = read.csv(paste(name,".fastaroc.3.cnn.csv",sep=""))
  x3<-roc(data=file3,response="validation_labels_k",predictor="X.1")
  #x3<-ggroc(x3)
  
  file4 = read.csv(paste(name,".fastaroc.4.cnn.csv",sep=""))
  x4<-roc(data=file4,response="validation_labels_k",predictor="X.1")
  #x4<-ggroc(x4)
  
  file5 = read.csv(paste(name,".fastaroc.5.cnn.csv",sep=""))
  x5<-roc(data=file5,response="validation_labels_k",predictor="X.1")
  #x5<-ggroc(x5)
  
  data_avg=rbindlist(list(file1,file2,file3,file4,file5))[, lapply(.SD, mean), by = "X.1"]
  #x6<-roc(data=data_avg,response="validation_labels_k",predictor="X.1",plot=TRUE,auc=TRUE,print.auc=FALSE,add=add_val)
  #all_roc<-ggroc(x1) +ggtitle(list_names[[i]])
  all_roc <- ggroc(list(fold1=x1, fold2=x2,fold3=x3,fold4=x4,fold5=x5))+ggtitle(list_names[[i]])+geom_abline(intercept=1,slope=1)+theme(legend.position="none")
  #plot(all_roc)
  mean_auc<-mean(auc(x1),auc(x2),auc(x3),auc(x4),auc(x5))
  std_auc<-sd(c(auc(x1),auc(x2),auc(x3),auc(x4),auc(x5)))
  auc_df_cnn[i,1]<-mean_auc
  auc_df_cnn[i,2]<-std_auc
  # if (k == 6){
  #   add_val=TRUE
  #   #average ROC curve
  # }
  
}

#dev.off()

# 
# file = read.csv(paste(name,".fastaroc.2.cnn.csv",sep=""))
# roc(data=file,response="validation_labels_k",predictor="X.1",plot=TRUE,auc=TRUE,print.auc=FALSE,add=TRUE)
# file = read.csv(paste(name,".fastaroc.3.cnn.csv",sep=""))
# roc(data=file,response="validation_labels_k",predictor="X.1",plot=TRUE,auc=TRUE,prddint.auc=FALSE,add=TRUE)
# file = read.csv(paste(name,".fastaroc.4.cnn.csv",sep=""))
# roc(data=file,response="validation_labels_k",predictor="X.1",plot=TRUE,auc=TRUE,print.auc=FALSE,add=TRUE)
# file = read.csv(paste(name,".fastaroc.5.cnn.csv",sep=""))
# roc(data=file,response="validation_labels_k",predictor="X.1",plot=TRUE,auc=TRUE,print.auc=FALSE,add=TRUE)