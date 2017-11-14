# Microarray Processing: Calculates the mean for genes with multiple probes and returns the averaged dense matrix 
# (only annotated genes)
# input: expression array with probes as row names and samples as column names

import pandas
import numpy as np

gse = pandas.read_csv(r'~\GSE14548_annotate_done.txt', delimiter='\t', header=None)

gse_num = np.loadtxt(r'~\GE14548_annotate_done_num.txt', delimiter='\t')

from collections import defaultdict
D = defaultdict(list)

for i,item in enumerate(gse.iloc[:,0]):
    D[item].append(i)
D = {k:v for k,v in D.items() if len(v)>1}

expression_mean = list()
for i in D:
	expression_mean_elements= list()
	for j in range(0,gse_num.shape[0-1]):
		expression_mean_elements.append(np.mean(gse_num[D[i],j]))
	expression_mean.append(expression_mean_elements)

duplicates = list(D.keys())

non_duplicates = list()
expression_mean_nondup = list()
for i in range(0,len(gse.iloc[:,0])-1):
	if gse.iloc[i,0] not in duplicates:
		non_duplicates.append(gse.iloc[i,0])
		expression_mean_nondup.append(gse_num[i,:])

counter_dup = 0
counter_nondup = 0
with open(r'~\GSE14548_mean.txt', mode='w') as fout:
	for gene_dup in duplicates:
		fout.write('\n'+''.join(gene_dup)+'\t')
		for gene_dup_expression in expression_mean[counter_dup]:
			fout.write(''.join(str(gene_dup_expression))+'\t')
		counter_dup = counter_dup+1

	for gene_nondup in non_duplicates:
		fout.write('\n'+''.join(gene_nondup)+'\t')
		for gene_nondup_expression in expression_mean_nondup[counter_nondup]:
			fout.write(''.join(str(gene_nondup_expression))+'\t')
		counter_nondup = counter_nondup+1
fout.close()
