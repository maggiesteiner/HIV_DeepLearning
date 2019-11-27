library(stringr)
library(dplyr)
library(gdata)

create_fasta_RT<-function(data,resvalname,filename){
#PI_norm<-"PQITLWQRPLVTIKIGGQLKEALLDTGADDTVLEEMNLPGRWKPKMIGGIGGFIKVRQYDQILIEICGHKAIGTVLVGPTPVNIIGRNLLTQIGCTLNF"
RT_norm<-"PISPIETVPVKLKPGMDGPKVKQWPLTEEKIKALVEICTEMEKEGKISKIGPENPYNTPVFAIKKKDSTKWRKLVDFRELNKRTQDFWEVQLGIPHPAGLKKKKSVTVLDVGDAYFSVPLDKDFRKYTAFTIPSINNETPGIRYQYNVLPQGWKGSPAIFQSSMTKILEPFRKQNPDIVIYQYMDDLYVGSDLEIGQHRTKIEELRQHLLRWGFTTPDKKHQKEPPFLWMGYELHPDKWT"
flagged<-c()
flag=F
sink(file=filename)
for(i in 1:nrow(data)){
  name<-paste(data[i,"SeqID"],resvalname[i],sep="_")
  seq<-RT_norm
  for(j in 1:240){ #99 for PI
    x<-data[i,j+2]
    if(str_length(x)>1){
      x<-substring(x,1,1)
      flag=T
    }
    x<-drop.levels(x)
    if(x!='-'){
      seq<-paste(substr(seq,1,j-1),x,substr(seq,j+1,240),sep="")
    }
    
  }
  print(paste(">",name,sep=""),quote=F,row.names=F)
  print(seq,quote=F,row.names=F)
  if(flag==T)
    flagged<-c(flagged,data[i,"SeqID"])
}
sink()
}

create_fasta_PI<-function(data,resvalname,filename){
  PI_norm<-"PQITLWQRPLVTIKIGGQLKEALLDTGADDTVLEEMNLPGRWKPKMIGGIGGFIKVRQYDQILIEICGHKAIGTVLVGPTPVNIIGRNLLTQIGCTLNF"
  flagged<-c()
  flag=F
  sink(file=filename)
  for(i in 1:nrow(data)){
    name<-paste(data[i,"SeqID"],resvalname[i],sep="_")
    seq<-PI_norm
    for(j in 1:99){ #99 for PI
      x<-data[i,j+2]
      if(str_length(x)>1){
        x<-substring(x,1,1)
        flag=T
      }
      x<-drop.levels(x)
      if(x!='-'){
        seq<-paste(substr(seq,1,j-1),x,substr(seq,j+1,99),sep="")
      }
      
    }
    print(paste(">",name,sep=""),quote=F,row.names=F)
    print(seq,quote=F,row.names=F)
    if(flag==T)
      flagged<-c(flagged,data[i,"SeqID"])
  }
  sink()
}