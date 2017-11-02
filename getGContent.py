# Refresher Course // Working with strings // Relative GC content

## Reads fasta files, calculates the GC content for each DNA sequence and translates the latter into protein sequences
## version:     1.1
## date:        02.11.2017
## author:      David Lauenstein

import pandas

# Load fasta file and process it
def loadFasta(file_location):
    with open(file_location) as f:
        fasta = f.readlines()
    f.close()

    fasta = [x.strip() for x in fasta]                      # remove whitespace character at line ends

    seq_count = 0
    dnaseq = ''

    for i in range(len(fasta)):                           # retrieve number and content of DNA sequences
        if '>' in  fasta[i]:
            seq_count = seq_count+1
            dnaseq += '>'
        else:
            dnaseq += fasta[i]
    dnaseq = dnaseq.upper()                                 # split sequences
    dnaseq_splitted = dnaseq.split('>')
    dnaseq_splitted = dnaseq_splitted[1:len(dnaseq_splitted)]
    print(seq_count, 'sequence(s) retrieved')
    return(dnaseq_splitted, seq_count)

#Analyze GC content of each DNA sequence
def gcContent(dnaseq_splitted, seq_count):
    for i in range(seq_count):
        if 'A' not in dnaseq_splitted[i] and 'T' not in dnaseq_splitted[i] and 'C' not in dnaseq_splitted[i]\
                and 'G' not in dnaseq_splitted[i]:                                        #control if DNA sequence provided
            print('input error: not a DNA sequence')
        else:
            g_counter = dnaseq_splitted[i].count('G')
            c_counter = dnaseq_splitted[i].count('C')
            gc_counter =g_counter+c_counter
            print('GC content of sequence ',i,':',gc_counter / len(dnaseq_splitted[i]), '%')

# Translate nucleotide sequence into protein sequence
def proteinSequence(dnaseq_splitted, seq_count):
    codon_db = pandas.read_csv('/home/david/Desktop/codons.csv', sep=' ', delimiter=None, header='infer')
    for i in range(seq_count):
        indexlist = list()
        for j in range(int(len(dnaseq_splitted[i])/3)):
            indexlist.append(list(codon_db['Codon']).index(dnaseq_splitted[i][j*3:j*3+3]))
        print([list(codon_db['AA'])[x] for x in indexlist])


file_location = '/home/david/Desktop/test.fasta'        # input path to fasta file
sequences, seq_number = loadFasta(file_location)
gcContent(sequences, seq_number)
proteinSequence(sequences, seq_number)
