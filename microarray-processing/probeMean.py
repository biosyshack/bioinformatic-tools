#######################################################
# Filename: probeMean.py
# Created: David Lauenstein
# Change history:
# 26.04.2018 / David Lauenstein
#######################################################
# Calculate mean gene expression across identical probes
# Inputs: 
#   - gse: expression matrix with annotation
#   - gse_num: expression file without annotation (only numeric values)
#######################################################

import pandas
import numpy as np

# load gene epxression matrices
gsefile = 'foldername'
gse = pandas.read_csv(r'~\\'+gsefile+'_annotate_done.txt', delimiter='\t',header=1)
gse_num = np.loadtxt(r'~\\'+gsefile+'_annotate_done_num.txt', delimiter='\t')

# Find duplicate values and calculate mean gene expression
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
		
# export processed expression matrix
counter_dup = 0
counter_nondup = 0
with open(r'~\\'+gsefile+'_mean.txt', mode='w') as fout:
	for gene_dup in duplicates:
		fout.write('\n'+''.join(str(gene_dup))+'\t')
		for gene_dup_expression in expression_mean[counter_dup]:
			fout.write(''.join(str(gene_dup_expression))+'\t')
		counter_dup = counter_dup+1

	for gene_nondup in non_duplicates:
		fout.write('\n'+''.join(gene_nondup)+'\t')
		for gene_nondup_expression in expression_mean_nondup[counter_nondup]:
			fout.write(''.join(str(gene_nondup_expression))+'\t')
		counter_nondup = counter_nondup+1
fout.close()
