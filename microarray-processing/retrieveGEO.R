library(GEOquery)

gse = getGEO("GSE22862", GSEMatrix=TRUE, AnnotGPL=F)

gse = gse[[1]] # get just the first element in list

columnnames = as.matrix(fData(gse)) # check column names for gene symbols

symbols = as.matrix(fData(gse))[,'gene_assignment']

expr_mat = exprs(gse)        # get the expression matrix

rownames(expr_mat) = symbols # map gene symbols to rows

# export annotated expression matrix
write.table(as.matrix(expr_mat), '~/GSE22862_annotate.txt',
            sep = '\t', quote = F, row.names = T, col.names = T)
write.table(as.matrix(expr_mat), '~/GSE22862_num.txt',
            sep = '\t', quote = F, row.names = F, col.names = F)
