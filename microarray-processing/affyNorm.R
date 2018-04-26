#######################################################
# Filename: affyNorm.R
# Created: David Lauenstein
# Change history:
# 26.04.2018 / David Lauenstein
#######################################################
# Retrieval and normalization of Affymetrix datasets (GEO) using robust multi-array average (RMA)
#######################################################

library(GEOquery)
library(affy)

# set working directory for download
setwd("~/GSE22862")

# download dataset
getGEOSuppFiles("GSE22862")

setwd("~/GSE22862/GSE22862")

# unpack dataset
untar("GSE22862_RAW.tar", exdir = "data")
cels = list.files("~/GSE22862/GSE22862/data", pattern = "CEL")
sapply(paste("data", cels[], sep = "/"), gunzip)

cels = list.files("~/GEO/GSE22862/GSE22862/data", full=T)

# set working directory for normalization
setwd("~/GSE22862/GSE22862/data")

raw.data=ReadAffy(verbose=TRUE, filenames=cels, cdfname="hgu133plus2") #From bioconductor, cdf has to be installed

# perform RMA normalization (log2)
data.rma.norm = rma(raw.data)

# get the expression estimates for each array
rma = exprs(data.rma.norm)

# take a look at the result (first 5 rows and 5 columes)
rma[1:5, 1:5]

# export normalized expression matrix
write.table(rma, file = "rma.txt", quote = FALSE, sep = "\t")
