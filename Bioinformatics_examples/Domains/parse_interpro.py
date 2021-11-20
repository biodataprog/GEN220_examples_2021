#!/usr/bin/env python3

import csv

infile="Athaliana_TMK.fa.tsv"
data_keep = {}
with open(infile,"r") as fh:
    csvreader = csv.reader(fh,delimiter="\t")
    for row in csvreader:
        genename = row[0]
        dbname   = row[3]
        dbacc    = row[4]
        if genename not in data_keep:
            data_keep[genename] = []
        data_keep[genename].append([dbname,dbacc])
#        print("gene is {}".format(genename))

for gene in data_keep:
    print("gene {}".format(gene))
    for domain in data_keep[gene]:
        print("\t{}:{}".format(domain[0], domain[1]))