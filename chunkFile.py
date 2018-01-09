file = r'~\bidata.txt'
outdir = r'outdir\\'

chunksize = 1000

with open(file) as openfile:
    lines = openfile.readlines()
    for chunk in range (0,100):
        with open(outdir+str(chunk)+'.txt', 'w') as writefile:
            for i in range(chunk*chunksize,chunksize+chunk*chunksize):
                writefile.write(lines[i])
