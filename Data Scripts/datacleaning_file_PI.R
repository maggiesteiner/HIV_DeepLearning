#data cleaning - remove sequences with unknown changes
data<-read.csv("PI_stanford.csv",header=T)
colnames(data)[1]<-"SeqID"
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
  #print(missing_vals[i])
}

#separate by drugs
fpv<-data_new[!is.na(data_new$FPV),]
atv<-data_new[!is.na(data_new$ATV),]
idv<-data_new[!is.na(data_new$IDV),]
lpv<-data_new[!is.na(data_new$LPV),]
nfv<-data_new[!is.na(data_new$NFV),]
sqv<-data_new[!is.na(data_new$SQV),]
tpv<-data_new[!is.na(data_new$TPV),]
drv<-data_new[!is.na(data_new$DRV),]

#remove other drugs columns
fpv<-fpv[,-c(3:9)]
atv<-atv[,-c(2,4:9)]
idv<-idv[,-c(2:3,5:9)]
lpv<-lpv[,-c(2:4,6:9)]
nfv<-nfv[,-c(2:5,7:9)]
sqv<-sqv[,-c(2:6,8:9)]
tpv<-tpv[,-c(2:7,9)]
drv<-drv[,-c(2:8)]

#assign resistance classification
#cutoff = 3.5 from Bonnet article
#1=resistant,0=not
res_vals_fpv<-array()
for(i in 1:nrow(fpv)){
  if(fpv[i,2]>=3.5)
    res=1
  else
    res=0
  res_vals_fpv[i]<-res
}
fpv<-cbind(fpv,res_vals_fpv)

res_vals_atv<-array()
for(i in 1:nrow(atv)){
  if(atv[i,2]>=3.5)
    res=1
  else
    res=0
  res_vals_atv[i]<-res
}
atv<-cbind(atv,res_vals_atv)

res_vals_idv<-array()
for(i in 1:nrow(idv)){
  if(idv[i,2]>=3.5)
    res=1
  else
    res=0
  res_vals_idv[i]<-res
}
idv<-cbind(idv,res_vals_idv)

#resistant = 1
#not resistant = 0

res_vals_lpv<-array()
for(i in 1:nrow(lpv)){
  if(lpv[i,2]>=3.5)
    res=1
  else
    res=0
  res_vals_lpv[i]<-res
}
lpv<-cbind(lpv,res_vals_lpv)

res_vals_nfv<-array()
for(i in 1:nrow(nfv)){
  if(nfv[i,2]>=3.5)
    res=1
  else
    res=0
  res_vals_nfv[i]<-res
}
nfv<-cbind(nfv,res_vals_nfv)

res_vals_sqv<-array()
for(i in 1:nrow(sqv)){
  if(sqv[i,2]>=3.5)
    res=1
  else
    res=0
  res_vals_sqv[i]<-res
}
sqv<-cbind(sqv,res_vals_sqv)

res_vals_tpv<-array()
for(i in 1:nrow(tpv)){
  if(tpv[i,2]>=3.5)
    res=1
  else
    res=0
  res_vals_tpv[i]<-res
}
tpv<-cbind(tpv,res_vals_tpv)

res_vals_drv<-array()
for(i in 1:nrow(drv)){
  if(drv[i,2]>=3.5)
    res=1
  else
    res=0
  res_vals_drv[i]<-res
}
drv<-cbind(drv,res_vals_drv)

#result is dataframes for each drug with binomial resistance values
