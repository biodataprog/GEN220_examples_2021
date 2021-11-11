#!/usr/bin/env python3

import csv, sys

filename=""
if len(sys.argv) > 1:
    filename=sys.argv[1]
else:
    print("need a filename on the commandline")
    exit()

# dictionary to story query - hit matches
matches = {}

with open(filename,"r") as csvin:
#    print("opened the file %s"%(filename))
    reader = csv.reader(csvin, delimiter='\t')
    for row in reader:
        qname = row[0]
        hname = row[1]
        pident= row[2]
        if qname not in matches:
            matches[qname] = [hname,pident]

for q in matches:
    print("\t".join([q,matches[q][0], matches[q][1]]))