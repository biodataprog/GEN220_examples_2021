#!/usr/bin/bash -l
#SBATCH -p short -N 1 -n 4 --mem 4gb

module load iprscan

interproscan.sh --cpu 4 --goterms --pathways -f tsv -i Athaliana_TMK.fa > interprosearch.log

