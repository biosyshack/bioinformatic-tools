library(STRINGdb)

string_db <- STRINGdb$new(version="10", species=9606, score_threshold=0, 
                           input_directory="")

pw = read.csv("expressionmat.txt",sep = "\t",header = T)
nodes = pw[,1]
print("Reading data")
list.mat = as.matrix(nodes)
colnames(list.mat) = "gene"

mapping = string_db$map(list.mat, "gene", removeUnmappedRows = TRUE)


network_highconf = string_db$get_interactions(mapping$STRING_id)


#network_highconf = network[which(network$combined_score > 700),]

from1 = c()
to1 = c()

for (i in 1:dim(network_highconf)[1]){
  from = which(network_highconf$from[i] == mapping$STRING_id)
  to = which(network_highconf$to[i] == mapping$STRING_id)
  from1[i] = mapping$gene[from]
  to1[i] = mapping$gene[to]
}

interactions = cbind(from1,to1)

write.table(as.matrix(interactions), 'C:/Users/_interactions.txt',
            sep = '\t', quote = F, row.names = F, col.names = F)

