#' Ct_check
#'
#' @param File_name File acquired from RT PCR
#'
#' @return
#' @export
#'
#' @examples Ct_check("220621 inhibitory ACC calcium.xls")
#'
Ct_check<-function(File_name){
  Data<-xlsx::read.xlsx(File_name,sheetName = "Results")[-(1:41),];colnames(Data)<-Data[1,];Data<-Data[-1,]
  Data<-na.omit(Data);Data<-Data[order(Data$`Sample Name`),]
  Data_to_reconsider<-Data %>% filter(`Ct SD`>0.3)
  if(nrow(Data_to_reconsider)!=0){
    for(Sample in unique(Data_to_reconsider$`Sample Name`)){
      Samp_groups<-Data_to_reconsider %>% filter(`Sample Name`==Sample)
      for(samp_No in 1:nrow(Samp_groups)){
        Samp_groups_test<-Samp_groups[-samp_No,]
        if(sd(Samp_groups_test$`CT`)<0.3){
          print(paste0("Consider_removing_Well_No_",Samp_groups[samp_No,1],
                       "_Well_Pos_",Samp_groups[samp_No,2],
                       "_for_",Sample,
                       "_to_achieve_",sd(Samp_groups_test$`CT`)))
        }
      }
    }
  }
  else {"All samples have passed the Ct_sd_threshold"}
}
