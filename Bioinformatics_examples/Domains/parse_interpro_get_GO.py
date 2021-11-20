#!/usr/bin/env python3

import csv

infile="Athaliana_TMK.fa.tsv"
GO_terms = {}
with open(infile,"r") as fh:
    csvreader = csv.reader(fh,delimiter="\t")
    for row in csvreader:
        genename = row[0]
        if len(row) < 14: # if the line doesn't have at least 14 terms, skip it, won't have GO in it
            continue
        GO   = row[13]
        # Skip when the GO term is empty
        if GO == "-" or len(GO) == 0:
            continue
        # initialize a GO database for this gene
        if genename not in GO_terms:
            GO_terms[genename] = set()
        for term in GO.split('|'):
            GO_terms[genename].add(term)

for gene in GO_terms:
    for GO in GO_terms[gene]:
        print("{}\tIEA\t{}".format(gene,GO))