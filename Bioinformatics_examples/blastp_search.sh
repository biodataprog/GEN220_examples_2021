#!/usr/bin/bash
#SBATCH -p short -N 1 -n 32 --mem 32gb --out blastp_run.log

module load ncbi-blast/2.9.0+

echo "num CPUS requested is $SLURM_CPUS_ON_NODE"
blastp -query C_glabrata_ORFs.pep -db S_cerevisiae_ORFs.pep -evalue 1e-15 -out Cgla_vs_Scer.blastp \
	-outfmt 6 -num_threads 32

