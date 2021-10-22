#!/usr/bin/env python3

import itertools
import sys
import re

def average1(list):
    count=0
    sum  = 0.0
    for item in list:
        count += 1
        sum   += item
    return sum / count

def average2(list):
    count=len(list)
    total  = sum(list)
    return total / count


# based on post here
# https://drj11.wordpress.com/2010/02/22/python-getting-fasta-with-itertools-groupby/

# define what a header looks like in FASTA format
def isheader(line):
    return line[0] == '>'


# this function reads in fasta file and returns pairs of data
# where the first item is the ID and the second is the sequence
# it isn't that efficient as it reads it all into memory
# but this is good enough for our project
def aspairs(f):
    seq_id = ''
    sequence = ''
    for header,group in itertools.groupby(f, isheader):
        if header:
            line = next(group)
            seq_id = line[1:].split()[0]
        else:
            sequence = ''.join(line.strip() for line in group)
            yield seq_id, sequence

# here is my program
# get the filename from the cmdline
print(sys.argv)
filename = sys.argv[1]
seqs = {}

with open(filename,"r") as f:
    seqs = dict(aspairs(f))

# iterate through the sequences
n=0
lengths=0
protein_lengths = []
aa_freq = {}

for k,v in seqs.items():
#    print( "id is ",k,"seq is",v)
    n += 1
    lengths += len(v)
    protein_lengths.append(len(v))
    for aa in v: # v is the protein sequence string
        if not aa in aa_freq:
            aa_freq[aa] = 0
        aa_freq[aa] += 1

print(aa_freq)

for aa in sorted(aa_freq.keys()):
    aa_count = aa_freq[aa]
    freq  = aa_count / lengths
    print("{}\t{}\t{}".format(aa,aa_count,100*freq))
    
# n should equal len(protein_lengths)

if n != len(protein_lengths): 
    print("something is weird about how you are calculating number of sequences")

# identical ways to get the keys in a dictionary
#for key in seqs:
#for key in seqs.keys():
    
print("There are {} sequences for a total length of {} bases".format(n,lengths))
avg1 = average1(protein_lengths)
avg2 = average2(protein_lengths)

print("The average length (method 1) of a protein is {}".format(avg1))
print("The average length (method 2) of a protein is {}".format(avg2))
