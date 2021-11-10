#!/usr/bin/env python3

import re

m = re.search("((ABX?)+)C","ABXABABCDED")
if m:
    print("Group 0",m.group(0))
    print("Group 1",m.group(1))
    print("Group 2",m.group(2))
    
    
msg = [ "My favorite animal is: dog, but I don't like cats",
        "My favorite animal is: snake, but I don't like beetles",
        "My favorite animal is: a bee, but I don't like rats",
      ]
sounds = {'snake': 'hiss', 'dog': 'woof', 'a bee': 'buzz'}

for s in msg:
#    print(s)
    m = re.search(":\s+((\w+\s+)?\w+),", s)
#    m = re.search(":\s+((\w+\s*)+),", s)

    if m:
#        print("group0 is {}".format(m.group(0)))
        animal = m.group(1)
        print("Animal is {}".format(animal))
        sound = "No idea"
        if animal in sounds:
            sound = sounds[animal]
#        else:
#            sound = "No idea"
        print("It says: {}".format(sound))
    else:
        print("Couldn't match the string {}".format(s))
        
        
pat = re.compile("AA[CG]A")
DNA="AAGAAGAAACAGGCACAACA"
print("DNA is {}".format(DNA))
start = 0
match = pat.search(DNA,start)
while( match ):
     #  process this match
    print("matched string {} at position {} to {}".format(match.group(0), match.start(), match.end()))
#    start = match.end()+1
    start += match.start() + 1
    match = pat.search(DNA,start)

    
message="The cat curled up on the catapult for a catnap"
newmsg = re.sub(r'cat',r'dog',message)
print(message)
print(newmsg)
# only replace first instance
newmsg = re.sub(r'cat',r'dog',message,1)
print(newmsg)

newmsg = re.sub(r'cat\s','dog ',message)
print(message)

import itertools, sys, re, os
Chr8="http://sgd-archive.yeastgenome.org/sequence/S288C_reference/chromosomes/fasta/chr08.fsa"

PREsite=r'TGA[AT]AC'
REPLACE='PREPRE'
Chr8File="chr08.fsa"
if not os.path.exists(Chr8File):
    os.system("curl -O {}".format(Chr8))

# define what a header looks like in FASTA format
def isheader(line):
    return line[0] == '>'

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

with open(Chr8File,"rt") as fh:
    seqs = aspairs(fh)
    for seqinfo in seqs:
        seqstr = seqinfo[1].lower()
        newseq=re.sub(PREsite,REPLACE,seqstr,flags=re.IGNORECASE)
        print(newseq)