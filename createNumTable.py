import csv
import numpy

with open('/home/david/Downloads/data.csv', 'r') as csvfile:
    data =  csv.reader(csvfile, delimiter=';')
    datalist = list(data)
    collen = list()
    for i in datalist:
        collen.append(len(i))
    rowcount = len(datalist)
    colcount = max(collen)

    matrix = numpy.zeros((rowcount,colcount))
    rowindex = 0
    for row in datalist:
        columnindex = 0
        rowindex = rowindex+1
        for element in row:
            columnindex = columnindex+1
            if 'NAN' in element:
                splitelement = element.split('NAN')
                matrix[rowindex-1,columnindex-1] = float(splitelement[1])
            else:
                pass
                matrix[rowindex-1, columnindex-1] = float(element)
