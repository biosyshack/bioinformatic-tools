library(GEOquery)
library(affy)

# Set working directory for download
setwd("~/GSE22862")

getGEOSuppFiles("GSE22862")

setwd("~/GSE22862/GSE22862")

untar("GSE22862_RAW.tar", exdir = "data")
cels = list.files("~/GSE22862/GSE22862/data", pattern = "CEL") # sometiles, it is 'CEL', you need to check it first
sapply(paste("data", cels[], sep = "/"), gunzip)

cels = list.files("~/GEO/GSE22862/GSE22862/data", full=T)

# Set working directory for normalization
setwd("~/GSE22862/GSE22862/data")

raw.data=ReadAffy(verbose=TRUE, filenames=cels, cdfname="hgu133plus2") #From bioconductor, define cdf

# perform RMA normalization (log2)
data.rma.norm = rma(raw.data)

# Get the expression estimates for each array
rma = exprs(data.rma.norm)

# Take a look at the result (first 5 rows and 5 columes)
rma[1:5, 1:5]

write.table(rma, file = "rma.txt", quote = FALSE, sep = "\t")

tt = cbind(row.names(rma), rma)
colnames(tt) = c("ProbID", sub(".cel", "", colnames(rma), ignore.case = TRUE))
rownames(tt) = NULL
tt[1:5, 1:5]

write.table(tt, file = "rma_matrix.txt", quote = FALSE, sep = "\t")
