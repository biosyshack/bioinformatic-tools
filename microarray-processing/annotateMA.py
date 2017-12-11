import csv

with open(r'~\GSE22862_annotate.txt', mode='r') as f:
	reader = csv.reader(f, delimiter = '\t')
	genelist = list()
	index = list()
	counter = 0
	for row in reader:
		counter = counter+1
		if ' // ' in str(row):	# specify separation
			genelist.append(str(row[0]).split(' // ')[1]) #Set to 0 if only // in file
			index.append(counter)
		else:
			genelist.append(str(row[0]))

genelist = genelist[1:len(genelist)]

row_counter = 0
with open(r'~\GSE22862_num.txt', mode='r') as f:
	reader = csv.reader(f, delimiter = '\t')
	exprmat = list()
	exprmat_annotated = list()
	for row in reader:
		exprmat.append(row)

counter = 0
with open(r'~\GSE22862_annotate_done.txt', mode='w') as fout:
	for element in genelist:
		if element != '':
			fout.write(''.join(element)+'\t'+'\t'.join(exprmat[counter])+'\n')
		counter = counter+1
