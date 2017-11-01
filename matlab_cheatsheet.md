# Find Element in Cell Array:
1. index = find([C{:}] == 5);
2. IndexC = strfind(C, 'bla'); Index = find(not(cellfun('isempty', IndexC)));

# Match Gene Expression Arrays:
1. Match two arrays
[sharedVals,idxsHNSSC] = intersect(GeneNames_cafHNSSc,GeneNames_cafBRC,'stable');
[sharedVals,idxsBRC] = intersect(GeneNames_cafBRC,GeneNames_cafHNSSC,'stable');
GeneNames_cafHNSSC= GeneNames_cafHNSSC(idxsHNSSC, :)
GeneNames_cafBRC = GeneNames_cafBRC(idxsBRC, :)
RnaSeq_HNSSC= RnaSeq_HNSSC(idxsHNSSC, :)
RnaSeq_BRC = RnaSeq_BRC(idxsBRC, :)
RnaSeq_combined = [RnaSeq_BRC, RnaSeq_HNSSC]
 
2. Nice Wrapper Function for multiple arrays: mathworks.com/matlabcentral/fileexchange/28341-set-functions-with-multiple-inputs
[z, iw, i1, i2, i3, i4]  = intersectm(upper(cellstr(GeneNamesW)),upper(cellstr(GeneNames1)),upper(cellstr(GeneNames2)),...
upper(cellstr(GeneNames3)), upper(cellstr(GeneNames4)), 'rows')
