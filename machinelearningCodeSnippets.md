# Feature Selection
## Remove Highly Correlated Features (Genes) and Retain Feature with Lowest Overall Mean Corr. [Caret Package R]
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
## Feature Selection using Genetic Algorithms (Parallelized, Linear Discriminant Analysis) [Caret Package R]

```
library(caret)
library(doMC)

registerDoMC(cores = 10)

data = read.csv("~/predmodel.txt",sep = "\t", header=T)

data = data[1:18,1:7530] # optional: resize model

ctrl <- gafsControl(functions = caretGA,verboseIter = TRUE)
obj <- gafs(x = predictors, 
            y = outcome,
            iters = 100,
            gafsControl = ctrl,           
            method = "lda")
```


## Parallelized Sequential Feature Selection (Top 50, very slow).  [Matlab]
```
Data =readtable('~/data.txt', 'Delimiter', '\t')

ferror = @(xtrain, ytrain, xtest, ytest)nnz(ytest ~= predict(fitcdiscr(xtrain, ytrain),xtest))

tic
paroptions = statset('UseParallel',true);
[selected, history] = sequentialfs(ferror, Data{:,1:end-1}, categorical(Data{:,end}),...
'nfeatures', 50,'Options',paroptions)
toc

mdlPart = fitcdiscr(Data(:,[selected true]),categorical(Data{:,end}), 'KFold', 10)
parLoss = kfoldLoss(mdlPart)
```
