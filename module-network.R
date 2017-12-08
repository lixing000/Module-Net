library(EMDomics)

## Run EMDomics and compute p-value 
## in.subtype1 parameter is the gene expression data of subtype1
## in.subtype2 parameter is the gene expression data of subtype2
## emd_result parameter is EMDomics output file
## The result is a data.frame with EMDomics results with p-value
run.EMDomics <- function (in.subtype1, in.subtype2, emd_result) {
  
  in.subtype1<-scale(in.subtype1,center = TRUE, scale = TRUE)
  
  in.subtype2<-scale(in.subtype2,center = TRUE, scale = TRUE)
  sample_number1=sum(in.subtype1[1,])
  sample_number1=sum(in.subtype2[1,])
  
  gene_number=sum(in.subtype1[,1])
  
  total<-cbind(in.subtype1,in.subtype2)
  
  outcomes <- c(rep("subtype1",sample_number1), rep("subtype2",sample_number2))
  
  names(outcomes) <- colnames(total)
  
  results <- calculate_emd(total, outcomes, nperm=10, parallel=FALSE)
  
  emd_results<-head(results$emd,n=20875)
  
  write.table(emd_results, file = "emd_results.txt", row.names = F, col.names = T, quote = F)
  
  return (emd_results)
}

## Run module-network and obtain the modules and candidate drivers
## TCGA_GBM_Agilent_Exp parameter is the gene expression data 
## biolearn.gene.matrix parameter is the CNV data
## candidate.List parameter is the all regulators name
## candidate.List.AMP parameter is the amplified genes name
## candidate.List.DEL parameter is the deleted genes name
run.initial.modules <- function (TCGA_GBM_Agilent_Exp, biolearn.gene.matrix, candidate.List, c, candidate.List.DEL) {

  for(i in 1:nrow(biolearn.gene.matrix))
  {
    for(j in 1:ncol(biolearn.gene.matrix))
    {
      if (biolearn.gene.matrix[i,j]==0)
        biolearn.gene.matrix[i,j]<-"N"
      else if (biolearn.gene.matrix[i,j]==-1)
        biolearn.gene.matrix[i,j]<-"D"
      else if (biolearn.gene.matrix[i,j]==-2)
        biolearn.gene.matrix[i,j]<-"D"
      else if (biolearn.gene.matrix[i,j]==1)
        biolearn.gene.matrix[i,j]<-"A"
      else if (biolearn.gene.matrix[i,j]==2)
        biolearn.gene.matrix[i,j]<-"A"
    }
  }
  
  command <- paste0("java -classpath  module_network.jar;commons-math-2.2.jar conexic.LearnModules SingleModulator.spec ")
  
  system(command, intern=TRUE)
}
  
## We will obtain the initial modude file "SingleModulator.spec.modules1" 
## The module modules will be copied into file  "InitialClustering.modules1" , then run the module network program

run.module.network(){
  command <- paste0("java -classpath  module_network.jar;commons-math-2.2.jar conexic.LearnModules ModuleNetwork.spec InitialClustering.modules1")
  
  system(command, intern=TRUE)
  
}
 



