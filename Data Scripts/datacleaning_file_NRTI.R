## data cleaning file for NRTI

# read in raw data and remove missing values

data<-read.csv("NRTI_stanford.csv",header=T)
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
}

#separate by drugs
ttc<-data_new[!is.na(data_new$X3TC),]#TTC is 3Tc - can't have nums as var names
abc<-data_new[!is.na(data_new$ABC),]
azt<-data_new[!is.na(data_new$AZT),]
dft<-data_new[!is.na(data_new$D4T),]#d4t = dft
ddi<-data_new[!is.na(data_new$DDI),]
tdf<-data_new[!is.na(data_new$TDF),]


#remove other drugs columns
ttc<-ttc[,-c(3:7)]
abc<-abc[,-c(2,4:7)]
azt<-azt[,-c(2:3,5:7)]
dft<-dft[,-c(2:4,6:7)]
ddi<-ddi[,-c(2:5,7)]
tdf<-tdf[,-c(2:6)]


#assign resistance classification
#cutoff = 3.5 from Bonnet article
#1=resistant,0=not
res_vals_ttc<-array()
for(i in 1:nrow(ttc)){
  if(ttc[i,2]>=3.5)
    res=1
  else
    res=0
  res_vals_ttc[i]<-res
}
ttc<-cbind(ttc,res_vals_ttc)

res_vals_abc<-array()
for(i in 1:nrow(abc)){
  if(abc[i,2]>=3.5)
    res=1
  else
    res=0
  res_vals_abc[i]<-res
}
abc<-cbind(abc,res_vals_abc)

res_vals_azt<-array()
for(i in 1:nrow(azt)){
  if(azt[i,2]>=3.5)
    res=1
  else
    res=0
  res_vals_azt[i]<-res
}
azt<-cbind(azt,res_vals_azt)

res_vals_dft<-array()
for(i in 1:nrow(dft)){
  if(dft[i,2]>=3.5)
    res=1
  else
    res=0
  res_vals_dft[i]<-res
}
dft<-cbind(dft,res_vals_dft)

res_vals_ddi<-array()
for(i in 1:nrow(ddi)){
  if(ddi[i,2]>=3.5)
    res=1
  else
    res=0
  res_vals_ddi[i]<-res
}
ddi<-cbind(ddi,res_vals_ddi)

res_vals_tdf<-array()
for(i in 1:nrow(tdf)){
  if(tdf[i,2]>=3.5)
    res=1
  else
    res=0
  res_vals_tdf[i]<-res
}
tdf<-cbind(tdf,res_vals_tdf)

#result is dataframes for each drug with binomial resistance values
