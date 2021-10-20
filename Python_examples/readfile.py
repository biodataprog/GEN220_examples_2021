#!/usr/bin/env python3
i=0
file = "data1.dat"
fh = open(file,"r")
for line in fh:
    line = line.strip()
    print("line[%d] is '%s'"%(i,line))
    i+=1

# this file doesn't exist
#myfile="data2.dat"
#print("I'm about to open the file")
#fh=open(myfile,"r")
#for line in fh:
#    print(line)
#print("I'm done reading from the file that is missing")

# this file doesn't exist - but we will detect that before going further
myfile="data2.dat"
with open(myfile,"r") as fh:
    for line in fh:
        print(line)
