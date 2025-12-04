#!/bin/bash

#Settings for the Sun Grid Engine

# run time for job in hours:mins:sec (max 168:0:0, jobs with h_rt < 8:0:0 have priority)

#$ -l h_rt=671:59:59
# request memory for job (default 2G, max 256G)

#$ -l rmem=32G
#$ -q molecosh.q
#$ -P molecosh

# number of processors to use (max 48)

#$ -pe openmp 1
#source /usr/local/extras/Genomics/apps/falcon/current/fc_env/bin/activate

/data/bop16cl/smrtlink/install/smrtlink-release_5.1.0.26412/bundles/smrttools/smrtcmds/bin/blasr /fastdata/bop16cl/bam/m54154_180419_084622.subreads.bam /fastdata/bop16cl/SWnew/SWnew.contigs.fasta --bam --out SWnewblasr3.bam