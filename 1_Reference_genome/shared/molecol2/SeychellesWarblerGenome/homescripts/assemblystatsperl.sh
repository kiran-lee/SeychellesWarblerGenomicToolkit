#!/bin/bash
#Settings for the Sun Grid Engine

# run time for job in hours:mins:sec (max 168:0:0, jobs with h_rt < 8:0:0 have priority)

#$ -l h_rt=671:59:59
# request memory for job (default 2G, max 256G)

#$ -l rmem=8G
#$ -q molecol.q
#$ -P molecol

# number of processors to use (max 48)

#$ -pe openmp 8

perl /fastdata-sharc/bop16cl/assembly-stats/pl/asm2stats.pl /fastdata-sharc/bop16cl/normalizedmaskedSWgenome.fasta > statswarbo.json
