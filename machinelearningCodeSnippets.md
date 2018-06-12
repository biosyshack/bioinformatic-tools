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
library(doParallel)

cl = makeCluster(10) # specify number of cores

registerDoParallel(cl)

data = read.csv("~/predmodel.txt",sep = "\t", header=T)

data = data[1:18,1:7530] # optional: resize model

ctrl = gafsControl(functions = caretGA,verbose = TRUE)
obj = gafs(x = predictors, 
            y = outcome,
            iters = 100,
            gafsControl = ctrl,           
            method = "lda")
stopCluster(cl)
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
## Performance Assessment of Machine Learning Models using ROC curves.  [R]
```
library(caret)
library(pROC)

control = trainControl(method="repeatedcv", number=3, repeats=3,verboseIter = TRUE,
                       savePredictions = TRUE,classProbs=T,summaryFunction=twoClassSummary)
# train model using LDA
model = train(Outcome~., data=train, method="svmLinear", preProcess="scale", trControl=control)

# plot ROC curve and calculate AUC
plot.roc(model$pred$obs,model$pred$diabetes)
auc(model$pred$obs,model$pred$diabetes)

```
## Implementation of custom metric for training function in caret (F1 score).  [R]
```
library(caret)
library(MLmetrics)

# See http://topepo.github.io/caret/training.html#metric 
# and https://stackoverflow.com/questions/37666516/caret-package-custom-metric
f1 = function(data, lev = NULL, model = NULL) {
  f1_val = F1_Score(y_pred = data$pred, y_true = data$obs, positive = lev[1])
  c(F1 = f1_val)
}

model = train(Class ~ ., data = dat, method = "smvLinear", metric = "F1",
             trControl = trainControl(summaryFunction = f1, classProbs = TRUE))
```

