#######################################################
# Filename: retrieveGEO.R
# Created: David Lauenstein
# Change history:
# 26.04.2018 / David Lauenstein
#######################################################
# Retrieval and export of annotated GEO datasets
#######################################################

library(GEOquery)

gse = getGEO("GSE22862", GSEMatrix=TRUE, AnnotGPL=F)
gse = gse[[1]] # get first element in list

columnnames = as.matrix(fData(gse)) # check column names for gene symbols
symbols = as.matrix(fData(gse))[,'gene_assignment']


# get the expression matrix
expr_mat = exprs(gse) 

# map gene symbols to rows
rownames(expr_mat) = symbols 

# export annotated expression matrix and numeric expression matrix
write.table(as.matrix(expr_mat), '~/GSE22862_annotate.txt',
            sep = '\t', quote = F, row.names = T, col.names = T)
write.table(as.matrix(expr_mat), '~/GSE22862_num.txt',
            sep = '\t', quote = F, row.names = F, col.names = F)
