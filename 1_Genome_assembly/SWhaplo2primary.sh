#!/bin/bash

#Settings for the Sun Grid Engine

# run time for job in hours:mins:sec (max 168:0:0, jobs with h_rt < 8:0:0 have priority)

#$ -l h_rt=671:59:59
# request memory for job (default 2G, max 256G)

#$ -l rmem=32G
#$ -q molecosh.q
#$ -P molecosh

# number of processors to use (max 48)

#$ -pe openmp 12


/usr/local/packages/apps/bwa/0.7.17/gcc-6.2/bin/bwa mem /fastdata/bop16cl/FALCONUNZIPSTAGE5/cns_p_ctg.fasta /fastdata/bop16cl/FALCONUNZIPSTAGE5/cns_h_ctg.fastq > SWhaplotoprimary.sam
