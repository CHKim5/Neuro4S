% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/Ct_res.R
\name{Ct_res}
\alias{Ct_res}
\title{Ct_res}
\usage{
Ct_res(File_name, con_vir, gene_bp, Reference_Ct, Con_for_normalization)
}
\arguments{
\item{File_name}{File acquired from RT PCR}

\item{con_vir}{Control virus titer for normalization}

\item{gene_bp}{gene base pairs}

\item{Reference_Ct}{Reference for linear regression in descending order Reference_Ct = c("10000","1000","100","10","1")}

\item{Con_for_normalization}{name of the control group, e.g. Con_for_normalization = "con"}
}
\value{

}
\description{
Ct_res
}
\examples{
Ct_res("220621 inhibitory ACC calcium.xls",5*10^12,6437,c("10000","1000","100","10","1"),"con")
}
