# Neuro4S
Handy functions for personal usage

The package includes

* Virus titer caluclator 220701

## Instructions

### Installation

#### Download R
https://cran.r-project.org/bin/windows/base/
#### Download R Studio
https://www.rstudio.com/products/rstudio/download/
#### Download Rtools
https://cran.r-project.org/bin/windows/Rtools/

#### Download package in R

```
install.packages("devtools")

devtools::install_github("CHKim5/Neuro4S")

library(Neuro4S)
```

### Virus titer

Ct_check(File_name)

Ct_res(File_name,con_vir,gene_bp)
