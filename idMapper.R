# This script maps the Gene Symbols of an RNA-Seq or Microarray expression matrix into EntreZ or Uniprot identifiers.
# (input: delimiter-separated file, prerequisites: mygene bioconductor package for EntreZ mapping, 
# UniProt master file for UniProt)
# version   1.0
# date:     18.10.2017
# author:   David Lauenstein

# install prerequisites (try http:// if https:// URLs are not supported)
# source("https://bioconductor.org/biocLite.R")
# biocLite("mygene")

library(mygene)

mapEntrezID = function(exprmatrix, separator = "\t", header = TRUE, species = "human"){
  
  dataset = read.csv2(exprmatrix, sep = separator, header = header)                             # read expression matrix
  entrez = queryMany(dataset[,1], scopes="symbol", fields = "entrezgene", species = species)    # map gene symbols into EntreZ IDs
  frameR = cbind(entrez$query, entrez$entrezgene)                                               
  frameR = na.omit(frameR)
  loc = match(frameR[,1],dataset[,1])                                                           # match indices of gene symbols and EntreZ IDs
  coverage = length(loc)/dim(dataset)[1]                                                        # print mapping statistics
  
  print(paste(dim(dataset)[1], " Gene Symbols found"))
  print(paste(length(loc), "IDs were assigned"))
  print(paste("mapping coverage: ", coverage))
  
  dataset.mapped = dataset[loc,2:(dim(dataset)[2])]                                             # adjust expression matrix to matching
  dataset.mapped = as.matrix(dataset.mapped)
  rows = frameR[,2]                                                                             # change rownames to EntreZ IDs
  rownames(dataset.mapped) = rows
  dataset.mapped = na.omit(dataset.mapped)
  class(dataset.mapped) = "numeric"
  
  return(dataset.mapped)                                                                        # return mapped expression matrix
}


mapUniprotID = function(exprmatrix, separator = ";", header = TRUE, species = "human",
                        uniprotFile){
  dataset = read.csv2(exprmatrix, sep = separator, header = header)                             # read expression matrix
  uniprot = read.csv2(uniprotFile, sep = ";", header = TRUE)                                    # load uniprot master file
  dataset = as.matrix(dataset)
  uniprot = as.matrix(uniprot)
  loc = match(frameR[,1],dataset[,1])                                                           # match indices of gene symbols and UniProt IDs
  coverage = length(loc)/dim(dataset)[1]                                                        # print mapping statistics
  
  print(paste(dim(dataset)[1], " Gene Symbols found"))
  print(paste(length(loc), "IDs were assigned"))
  print(paste("mapping coverage: ", coverage))
  
  dataset.mapped = dataset[loc,2:(dim(dataset)[2])]                                             # adjust expression matrix to matching
  dataset.mapped = as.matrix(dataset.mapped)
  rows = frameR[,2]                                                                             # change rownames to UniProt IDs
  rownames(dataset.mapped) = rows
  dataset.mapped = na.omit(dataset.mapped)
  class(dataset.mapped) = "numeric"
  
  return(dataset.mapped)                                                                        # return mapped expression matrix   
}


exprmatMapped = mapEntrezID('~/RnaSeq.txt', separator='\t', header=FALSE)
exprmatMapped  = mapUniprotID('~/RnaSeq.txt', separator='\t', header=FALSE, '~/uniprotFile.txt')
