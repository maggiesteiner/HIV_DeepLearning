## data cleaning file for NNRTI

# read in and raw data
data<-read.csv("NNRTI_stanford.csv",header=T)
colnames(data)[1]<-"SeqID"

# remove missing values
missing_vals<-c()
for(i in 1:nrow(data)){
  for(j in 10:length(data[i,])){
    if(data[i,j]=="." || is.na(data[i,j]))
      missing_vals<-c(missing_vals,data[i,1])#seqID
  }
}
missing_vals<-missing_vals[!duplicated(missing_vals)]
data_new<-data
for(k in 1:length(missing_vals)){
  data_new<-data_new[!data_new$SeqID==missing_vals[k],]
}

#separate by drugs
efv<-data_new[!is.na(data_new$EFV),]
nvp<-data_new[!is.na(data_new$NVP),]
etr<-data_new[!is.na(data_new$ETR),]
rpv<-data_new[!is.na(data_new$RPV),]

#remove other drugs columns
efv<-efv[,-c(3:5)]
nvp<-nvp[,-c(2,4:5)]
etr<-etr[,-c(2:3,5)]
rpv<-rpv[,-c(2:4)]

#assign resistance classification
#cutoff = 3.5 
#1=resistant,0=not

res_vals_efv<-array()
for(i in 1:nrow(efv)){
  if(efv[i,2]>=3.5)
    res=1
  else
    res=0
  res_vals_efv[i]<-res
}
efv<-cbind(efv,res_vals_efv)

res_vals_nvp<-array()
for(i in 1:nrow(nvp)){
  if(nvp[i,2]>=3.5)
    res=1
  else
    res=0
  res_vals_nvp[i]<-res
}
nvp<-cbind(nvp,res_vals_nvp)

res_vals_etr<-array()
for(i in 1:nrow(etr)){
  if(etr[i,2]>=3.5)
    res=1
  else
    res=0
  res_vals_etr[i]<-res
}
etr<-cbind(etr,res_vals_etr)

res_vals_rpv<-array()
for(i in 1:nrow(rpv)){
  if(rpv[i,2]>=3.5)
    res=1
  else
    res=0
  res_vals_rpv[i]<-res
}
rpv<-cbind(rpv,res_vals_rpv)

#result is dataframes for each drug with binomial resistance values
