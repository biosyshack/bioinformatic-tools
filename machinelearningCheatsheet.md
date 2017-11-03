# Feature Selection
## Remove Highly Correlated Features (Genes) and Retain Feature with Lowest Overall Mean Corr (CARET R)
```
library(caret)

set.seed(7)

data = read.csv("~/model.txt",sep = "\t",header = T, row.names = 1)
genenames = read.csv("~/genenames.txt",sep = "\t",header = F)

data = as.matrix(data[,1:2275]) #end-1, if response var in last column

correlationMatrix <- cor(data) 

highlyCorrelated <- findCorrelation(correlationMatrix, cutoff=0.8)

genenames_highcorr = genenames[highlyCorrelated]
genenames_uncorr = setdiff(as.vector(unlist(genenames[1,])),
            as.vector(unlist(genenames_highcorr[1,])))

View(as.matrix(genenames_uncorr))
write.table(as.matrix(genenames_uncorr), '/feature_uncorr.txt',
            sep = '\t', quote = F, row.names = F, col.names = F)

```
