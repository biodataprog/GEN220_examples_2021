#!/usr/bin/bash
#SBATCH -p short -N 1 -n 24

module load hmmer
module load db-pfam
QUERY=cyanobacteria
hmmscan --cut_ga --cpu 24 --domtbl $OUT.domtbl $PFAM_DB/Pfam-A.hmm $QUERY > $OUT.hmmscan
