#' Ct_res
#'
#' @param File_name File acquired from RT PCR
#' @param con_vir Control virus titer for normalization
#' @param gene_bp gene base pairs
#' @param Reference_Ct Reference for linear regression in descending order Reference_Ct = c("10000","1000","100","10","1")
#' @param Con_for_normalization name of the control group, e.g. Con_for_normalization = "con"
#'
#' @return
#' @export
#'
#' @examples Ct_res("220621 inhibitory ACC calcium.xls",5*10^12,6437,c("10000","1000","100","10","1"),"con")
Ct_res<-function(File_name,con_vir,gene_bp,Reference_Ct,Con_for_normalization){
  rdpart <-(6.02*10^11)/(gene_bp*684)
  Data<-read.xlsx(File_name,sheetName = "Results")[-(1:41),];colnames(Data)<-Data[1,];Data<-Data[-1,]
  Data<-na.omit(Data);Data<-Data[order(Data$`Sample Name`),]

  Data_ref<-Data %>% filter(`Sample Name` %in% Reference_Ct)
  Data_ref$reful<-c(rep(4,3),rep(3,3),rep(2,3),rep(1,3),rep(0,3))
  if(lm(CT~reful,Data_ref)[["coefficients"]]["reful"]>0){
    Data_ref$reful<-c(rep(0,3),rep(1,3),rep(2,3),rep(3,3),rep(4,3))
  }
  Ref_Result<-summary(lm(CT~reful,Data_ref))
  print(paste("calculated based on R^2 of",Ref_Result$r.squared))
  Tar_comp<-Data %>% filter(!(`Sample Name` %in% Reference_Ct))
  Result<-as.data.frame(matrix(nrow=length(unique(Tar_comp$`Sample Name`)),ncol=6))
  rownames(Result)<-unique(Tar_comp$`Sample Name`);colnames(Result)<-c("log10(pg/ul)","pg/ul","vg/ml",	"vg/uL","normalized")
  for(Sample in unique(Tar_comp$`Sample Name`)){
    Samp_groups<-Tar_comp %>% filter(`Sample Name`==Sample)
    Result[Sample,1]<-(as.numeric(Samp_groups$`Ct Mean`[1])-Ref_Result$coefficients[1,1])/Ref_Result$coefficients[2,1]
    Result[Sample,2]<-10^Result[Sample,1]
    Result[Sample,3]<-Result[Sample,2]*rdpart*1000*100
    Result[Sample,4]<-Result[Sample,3]/1000
  }
  for (a in 1: nrow(Result)){
    Result[a,5]<-Result[a,3]*con_vir/Result[Con_for_normalization,3]
  }
  write.csv(Result,paste0(File_name,"Result_file","_Rsq_",Ref_Result$r.squared,".csv"))
  print("Results_saved")
}
