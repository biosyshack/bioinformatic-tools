# Find Element in Cell Array
```
index = find([C{:}] == 5);
IndexC = strfind(C, 'bla'); Index = find(not(cellfun('isempty', IndexC)));
```
# Match Gene Expression Arrays
## Match two arrays
```
[sharedVals,idxsHNSSC] = intersect(GeneNames_cafHNSSc,GeneNames_cafBRC,'stable');
[sharedVals,idxsBRC] = intersect(GeneNames_cafBRC,GeneNames_cafHNSSC,'stable');
GeneNames_cafHNSSC= GeneNames_cafHNSSC(idxsHNSSC, :)
GeneNames_cafBRC = GeneNames_cafBRC(idxsBRC, :)
RnaSeq_HNSSC= RnaSeq_HNSSC(idxsHNSSC, :)
RnaSeq_BRC = RnaSeq_BRC(idxsBRC, :)
RnaSeq_combined = [RnaSeq_BRC, RnaSeq_HNSSC]
```

## Wrapper Function for Multiple Arrays
```
[z, iw, i1, i2, i3, i4]  = intersectm(upper(cellstr(GeneNamesW)),upper(cellstr(GeneNames1)),...
upper(cellstr(GeneNames2)),upper(cellstr(GeneNames3)), upper(cellstr(GeneNames4)), 'rows')
```
(mathworks.com/matlabcentral/fileexchange/28341-set-functions-with-multiple-inputs - modified for better indexing)

# Machine Learning
## Parallelized Sequential Feature Selection (Top 50 - slow). 
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
