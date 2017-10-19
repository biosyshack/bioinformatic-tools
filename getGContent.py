## Reads fasta files and calculates the GC content for each DNA sequence
## version:     1.0
## date:        19.10.2017
## author:      David Lauenstein

# Load fasta file and process it
file_location = '/home/david/Desktop/test.fasta'        # input path to file

with open(file_location) as f:
    fasta = f.readlines()
f.close()

fasta = [x.strip() for x in fasta]                      # remove whitespace character at line ends

seq_count = 0
dnaseq = ''

for i in range(len(fasta)):                             # retrieve number and content of DNA sequences
    if '>' in fasta[i]:
        seq_count = seq_count+1
        dnaseq += '>'
    else:
        dnaseq += fasta[i]

dnaseq = dnaseq.upper()                                 # split sequences
dnaseq_splitted = dnaseq.split('>')


#Analyze GC content of each DNA sequence

print(seq_count, 'sequence(s) retrieved')

for i in range(seq_count):
    if 'A' not in dnaseq_splitted[i+1] and 'T' not in dnaseq_splitted[i+1] and 'C' not in dnaseq_splitted[i+1]\
            and 'G' not in dnaseq_splitted[i+1]:                                        #control if DNA sequence provided
        print('input error: not a DNA sequence')
    else:
        seqlength = len(dnaseq_splitted[i+1])
        gc_counter = 0
        for j in range(seqlength-1):
            if dnaseq_splitted[i+1][j] == 'G' and dnaseq_splitted[i+1][j+1] == 'C':
                gc_counter = gc_counter+2                                               #count how many GC's found
            else:
                pass
        print('GC content of sequence ',i+1,':',gc_counter / seqlength, '%')


